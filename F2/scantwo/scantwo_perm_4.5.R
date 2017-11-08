library(qtl)
library(snowfall)

load("/share/malooflab/Ruijuan/F2/QTL_analysis/data/LG.f2.after.crossover.43traits.Rdata")

LG.f2.after.crossover <- sim.geno(LG.f2.after.crossover,step=1,n.draws=32)
LG.f2.after.crossover <- calc.genoprob(LG.f2.after.crossover,step=1)

sfInit(parallel = TRUE, cpus = 16)
sfExport("LG.f2.after.crossover")
sfLibrary(qtl)

# run scantwo for all traits at once 
set.seed(5)

system.time(
scantwo.perm.imp.4.5 <- 
  scantwo(LG.f2.after.crossover,pheno.col=c(7,9),method="hk",n.perm=10,n.cluster = 16)
)
names(scantwo.perm.imp.4.5) <- colnames(LG.f2.after.crossover$pheno)

sfStop()

# save output 
save(scantwo.perm.imp.4.5, file = "/share/malooflab/Ruijuan/F2/QTL_analysis/output/scantwo/scantwo.perm.imp.4.5.Rdata")
