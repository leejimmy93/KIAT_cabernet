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

# for fixed effect result, looks like needs even more memory...
