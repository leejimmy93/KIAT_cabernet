library(qtl)
library(snowfall)

LG.f2.after.crossover <- read.cross("csvsr", genfile = "/share/malooflab/Ruijuan/F2/data/LG.f2.madmapper.final_gen_revised_flipped.csv",
                     phefile = "/share/malooflab/Ruijuan/F2/data/growth_model_trait.2.csv",
                     genotypes = c("AA", "AB", "BB")) # the only problem is that 44 phenotypes were read instead of 43, need to figure out why later

LG.f2.after.crossover <- sim.geno(LG.f2.after.crossover,step=1,n.draws=32)
LG.f2.after.crossover <- calc.genoprob(LG.f2.after.crossover,step=1)

sfInit(parallel = TRUE, cpus = 16)
sfExport("LG.f2.after.crossover")
sfLibrary(qtl)

# run scantwo for all traits at once 
set.seed(9)

system.time(
scantwo.perm.imp.5.9 <- 
  scantwo(LG.f2.after.crossover,pheno.col=9:10,method="hk",n.perm=10,n.cluster = 16)
)

sfStop()

# save output 
save(scantwo.perm.imp.5.9, file = "/share/malooflab/Ruijuan/F2/QTL_analysis/output/scantwo_flipped/scantwo.perm.imp.5.9.Rdata")
