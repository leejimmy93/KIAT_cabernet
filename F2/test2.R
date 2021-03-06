library(qtl)
library(snowfall)

load("/share/malooflab/Ruijuan/F2/QTL_analysis/data/LG.f2.after.crossover_Erucic_Oleic.Rdata")

sfInit(parallel = TRUE, cpus = 16)
sfExport("LG.f2.after.crossover")
sfLibrary(qtl)

# system.time(
# scantwo.imp <-
# sfLapply(seq_along(LG.f2.after.crossover$pheno), function(trait) {
#   print(trait)
#   scantwo(LG.f2.after.crossover,pheno.col=trait,method="imp")
# })
# )
# names(scantwo.imp) <- colnames(LG.f2.after.crossover$pheno)

set.seed(2)
# run permuation to decide threshold 
system.time(
scantwo.perm.imp <-
  sfLapply(seq_along(LG.f2.after.crossover$pheno), function(trait){
    print(trait) # print doesn't work in here
    scantwo(LG.f2.after.crossover,pheno.col = trait, n.perm=10, n.cluster = 16)
    # summary(tmp)[1] # #keep the 95th percentile for future use.This corresponds to p <0.05
  }) # takes ... to finish
)
names(scantwo.perm.imp) <- colnames(LG.f2.after.crossover$pheno)

sfStop()

# save output 
save(scantwo.perm.imp, file = "/share/malooflab/Ruijuan/F2/QTL_analysis/output/scantwo.result_Erucic_Oleic_mcluster_test2.Rdata")
