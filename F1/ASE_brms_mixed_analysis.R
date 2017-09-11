# slurmlogin_big.sh # require big memory to load data
library(brms)
library(psych)

load("/share/malooflab/Ruijuan/F1/output/brms_all_mixed.Rdata")

ouptut <- list()
for (gene in names(brms_all_mixed)){
	tryCatch({
	output[[gene]] <- hypothesis(brms_all_mixed[[gene]], "crossF1_415 = 0")
}, error = function(e) NA)
}

brms_all_mixed.result <- output
save(brms_all_mixed.result, file="/share/malooflab/Ruijuan/F1/output/brms_all_mixed.result.Rdata")

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

# for fixed effect result, looks like needs even more memory...
