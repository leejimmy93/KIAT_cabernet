# purpose of this script is to defining significance level for eQTL analysis. Since the number of genes are too big. The idea here is 1) reduce gene list by conducting correlation test, remove genes with correlation equal or greater than 0.9; 2) sample 100 genes from the leftover genes; 3) do permutation test using the 100 sampled genes 

# 0) load libs
library("qtl")
library("tidyverse")
library("snow")
library("bigmemory")
source("/share/malooflab/Ruijuan/KIAT_cabernet/F2/helper.R")

# 1) read in data
load("/share/malooflab/Ruijuan/F2/QTL_analysis/data/vstMat.f2.centered.scaled.Rdata")
vstMat.f2.centered.scaled.t <- as.data.frame(t(vstMat.f2.centered.scaled))
system.time(cor.results <- as.matrix(chunked.cor(vstMat.f2.centered.scaled.t)))
save(cor.results, file="/share/malooflab/Ruijuan/F2/QTL_analysis/output/cor.results.Rdata")

# 2) use correlation test to remove genes with pairwise correlation equal to or greater than 0.9 

# 3) sample 100 genes from the unique genes (correlation smaller than 0.9)

# 4) do QTL permutation test on the 100 genes and save the output 

# 5) take the median as the threshold for eQTL   
