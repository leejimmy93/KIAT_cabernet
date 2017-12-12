library(qtl)
library(snowfall)

load("/share/malooflab/Ruijuan/F2/QTL_analysis/data/LG.f2.after.crossover.43traits.corrected.Rdata")

# just get the three traits that I need
LG.f2.after.crossover$pheno <- LG.f2.after.crossover$pheno[,c("cis_11_Eicosenoic_acid", "Palmitoliec_aicd", "Behenic_acid")]

LG.f2.after.crossover <- sim.geno(LG.f2.after.crossover,step=1,n.draws=32)
LG.f2.after.crossover <- calc.genoprob(LG.f2.after.crossover,step=1)

sfInit(parallel = TRUE, cpus = 16)
sfExport("LG.f2.after.crossover")
sfLibrary(qtl)

# run scantwo for all traits at once 
set.seed(10)

system.time(
scantwo.perm.imp.10 <- 
  scantwo(LG.f2.after.crossover,pheno.col=1:3,method="hk",n.perm=10,n.cluster = 16)
)

sfStop()

names(scantwo.imp) <- colnames(LG.f2.after.crossover$pheno)

# save output 
save(scantwo.perm.imp.10, file = "/share/malooflab/Ruijuan/F2/QTL_analysis/output/scantwo/corrected_three_traits/scantwo.perm.imp.10.Rdata")
