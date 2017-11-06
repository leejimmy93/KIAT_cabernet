library(qtl)
library(snowfall)

load("/share/malooflab/Ruijuan/F2/QTL_analysis/data/LG.f2.after.crossover_all_expressed_genes.Rdata")

LG.f2.after.crossover <- sim.geno(LG.f2.after.crossover,step=1,n.draws=32) # imputation? 
LG.f2.after.crossover <- calc.genoprob(LG.f2.after.crossover,step=1) 

# sample 100 genes for permutation 
set.seed(1)
LG.f2.after.crossover$pheno <- sample(LG.f2.after.crossover$pheno, 100)

sfInit(parallel = TRUE, cpus = 16) 
sfExport("LG.f2.after.crossover")
sfLibrary(qtl)

system.time(
scanone.perm.imp <- 
  sfLapply(seq_along(LG.f2.after.crossover$pheno), function(trait){
    print(trait) # print doesn't work in here 
    tmp <-scanone(LG.f2.after.crossover,pheno.col = trait, method="imp",n.perm=1000, n.cluster = 16)
    summary(tmp)[1] # #keep the 95th percentile for future use.This corresponds to p <0.05
  }) # takes 40 mins to finish 
)
sfStop() 

names(scanone.perm.imp) <- colnames(LG.f2.after.crossover$pheno) 

# LG.f2.after.crossover$pheno <- LG.f2.after.crossover$pheno[,1:5618]

# system.time(
# scanone.imp.1 <- 
# lapply(seq_along(LG.f2.after.crossover$pheno), function(trait) {
#   print(trait)
#   scanone(LG.f2.after.crossover,pheno.col=trait,method="imp")
# }) 
# )
# names(scanone.imp.1) <- colnames(LG.f2.after.crossover$pheno) 

save(scanone.perm.imp, file = "/share/malooflab/Ruijuan/F2/QTL_analysis/output/scanone.perm.imp.mcluster.Rdata")
