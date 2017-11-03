library(qtl)

load("/share/malooflab/Ruijuan/F2/QTL_analysis/data/LG.f2.after.crossover.final.Rdata")

# run scantwo for all traits at once 
system.time(
scantwo.imp <- 
lapply(seq_along(LG.f2.after.crossover$pheno), function(trait) {
  print(trait)
  scantwo(LG.f2.after.crossover,pheno.col=trait,method="hk")
}) 
)

names(scantwo.imp) <- colnames(LG.f2.after.crossover$pheno)

# save output 
save(scantwo.imp, file = "/share/malooflab/Ruijuan/F2/QTL_analysis/output/scantwo.imp.Rdata")
