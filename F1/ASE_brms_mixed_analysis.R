# slurmlogin_big.sh # require big memory to load data
library(brms)
library(psych)

load("/share/malooflab/Ruijuan/F1/output/F1.young.gene.Ae_ratio.Rdata")
intersect(F1.young.gene.Ae_ratio$gene_ID %>% unique(), rownames(DEgene.young.F1)) # 1008


load("/share/malooflab/Ruijuan/F1/output/brms_all_mixed.Rdata")
# all 12044 genes have brms output, but some are NA due to 
# overlaps with DEGs 1008
intersect(names(brms_all_mixed), rownames(DEgene.young.F1)) # 1008 # negative... 

ouptut <- list()
for (gene in names(brms_all_mixed)){
	tryCatch({
	output[[gene]] <- hypothesis(brms_all_mixed[[gene]], "crossF1_415 = 0")
}, error = function(e) NA)
}

brms_all_mixed.result <- output
save(brms_all_mixed.result, file="/share/malooflab/Ruijuan/F1/output/brms_all_mixed.result.Rdata")
# 8619 genes have brms hypothesis result 
# overlaps with DEGs
intersect(names(brms_all_mixed.result), rownames(DEgene.young.F1)) # 662

# look for genes that show significant different Ae_ratio between 414 & 415 
ASE_gene <- vector() 

for (gene in names(brms_all_mixed.result)){
	if (brms_all_mixed.result[[gene]]$hypothesis$Star == "*")
	ASE_gene[[gene]] <- gene
}
# 2530 genes show ASE

save(ASE_gene, file="/share/malooflab/Ruijuan/F1/output/ASE_gene.Rdata")

# compare with DEGs between 414 & 415, are many of them show ASE? 
load("/share/malooflab/Ruijuan/F1/data/DEgene.gt.F1.Rdata")
ASE_DE_young_gene <- 
intersect(names(ASE_gene), rownames(DEgene.young.F1)) # 219 
# only 219 genes out of 4024 genes show ASE

save(ASE_DE_young_gene, file="/share/malooflab/Ruijuan/F1/output/ASE_DE_young_gene.Rdata")

# code for prob from model prediction 
model_prob_Ae_result <-
lapply(names(brms_all_mixed), function(gene)
        tryCatch({
        prob_Ae_414 = logistic(fixef(brms_all_mixed[[gene]], old=T)[1])
        prob_Ae_415 = logistic(sum(fixef(brms_all_mixed[[gene]], old=T))) 
        c(prob_Ae_414, prob_Ae_415)
}, error = function(e) NA)
)
save(model_prob_Ae_result, file="/share/malooflab/Ruijuan/F1/output/model_prob_Ae_result.Rdata")

# fixed effect result, do I need to? compare fixed effect & mixed effect, which model is better? 

# brms AIC() says fixed effect model fit the data better, while I need to confirm that using rethinking package, now calculate all the result for fixed effect model. 

output <- list()
for (gene in names(brms_all_fixed)){
        tryCatch({
        output[[gene]] <- hypothesis(brms_all_fixed[[gene]], "crossF1_415 = 0")
}, error = function(e) NA)
}

brms_all_fixed.result <- output
save(brms_all_fixed.result, file="/share/malooflab/Ruijuan/F1/output/brms_all_fixed.result.Rdata")
# 8619 genes have brms hypothesis result
# overlaps with DEGs
intersect(names(brms_all_fixed.result), rownames(DEgene.young.F1)) # 662

# look for genes that show significant different Ae_ratio between 414 & 415
ASE_gene_fixed <- vector()

for (gene in names(brms_all_fixed.result)){
        if (brms_all_fixed.result[[gene]]$hypothesis$Star == "*")
        ASE_gene_fixed[[gene]] <- gene
}
# 2529 genes show ASE

save(ASE_gene_fixed, file="/share/malooflab/Ruijuan/F1/output/ASE_gene_fixed.Rdata")
ASE_DE_young_gene_fixed <-
intersect(names(ASE_gene_fixed), rownames(DEgene.young.F1)) # 208
save(ASE_DE_young_gene_fixed, file="/share/malooflab/Ruijuan/F1/output/ASE_DE_young_gene_fixed.Rdata")

# only 208 genes out of 4024 genes show ASE












