library(qtl)
library(snowfall)

load("/share/malooflab/Ruijuan/F2/QTL_analysis/data/LG.f2.after.crossover_Erucic_Oleic.Rdata")

LG.f2.after.crossover <- sim.geno(LG.f2.after.crossover,step=1,n.draws=32)
LG.f2.after.crossover <- calc.genoprob(LG.f2.after.crossover,step=1)

sfInit(parallel = TRUE, cpus = 10)
sfExport("LG.f2.after.crossover")
sfLibrary(qtl)

# run scantwo for all traits at once 
set.seed(8)

system.time(
scantwo.perm.imp.8.1 <- 
sfLapply(seq_along(LG.f2.after.crossover$pheno), function(trait) {
  print(trait)
  scantwo(LG.f2.after.crossover,pheno.col=trait,method="hk",n.perm=10,n.cluster = 10)
}) 
)

names(scantwo.perm.imp.8.1) <- colnames(LG.f2.after.crossover$pheno)

sfStop()

# save output 
save(scantwo.perm.imp.8.1, file = "/share/malooflab/Ruijuan/F2/QTL_analysis/output/scantwo.perm.imp.8.1.Rdata")
