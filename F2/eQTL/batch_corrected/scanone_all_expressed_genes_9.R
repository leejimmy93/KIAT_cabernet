library(qtl)
# library(snowfall)

LG.f2.after.crossover <- read.cross("csvsr", genfile =  "/share/malooflab/Ruijuan/F2/eQTL/batch_corrected/LG.f2.madmapper.final_gen_revised.csv",
                         phefile = "/share/malooflab/Ruijuan/F2/eQTL/batch_corrected/vstMat.f2.batch.corrected_revised.csv",
                         genotypes = c("AA", "AB", "BB"))

LG.f2.after.crossover <- sim.geno(LG.f2.after.crossover,step=1,n.draws=32) # imputation? 
LG.f2.after.crossover <- calc.genoprob(LG.f2.after.crossover,step=1) 

# sfInit(parallel = TRUE, cpus = 16) 
# sfExport("LG.f2.after.crossover")
# sfLibrary(qtl)

# system.time(
# scanone.perm.imp <- 
#   sfLapply(seq_along(LG.f2.after.crossover$pheno), function(trait){
#     print(trait) # print doesn't work in here 
#     tmp <-scanone(LG.f2.after.crossover,pheno.col = trait, method="imp",n.perm=1000)
#     summary(tmp)[1] # #keep the 95th percentile for future use.This corresponds to p <0.05
#   }) # takes 40 mins to finish 
# )
# sfStop() 

# names(scanone.perm.imp) <- colnames(LG.f2.after.crossover$pheno) 

LG.f2.after.crossover$pheno <- LG.f2.after.crossover$pheno[,44945:50562]

system.time(
scanone.imp.9 <- 
lapply(seq_along(LG.f2.after.crossover$pheno), function(trait) {
  print(trait)
  scanone(LG.f2.after.crossover,pheno.col=trait,method="imp")
}) 
)
names(scanone.imp.9) <- colnames(LG.f2.after.crossover$pheno) 

save(scanone.imp.9, file = "/share/malooflab/Ruijuan/F2/eQTL/no_scale_center/output/scanone_all_expressed_genes.imp.9.Rdata")
