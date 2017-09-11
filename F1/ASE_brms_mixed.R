library(brms)
library(tidyverse)
library(stringr)
library(rethinking)
load("/share/malooflab/Ruijuan/F1/output/F1.young.gene.Ae_ratio.Rdata")

# Calcaulte  total and Ae counts because this is what (I think) we want to work with in the binomial model
F1.young.gene.Ae_ratio <-  F1.young.gene.Ae_ratio %>%  
  mutate(total_F1_414.counts=F1_414_RO+F1_414_AO, # total count 
         total_F1_415.counts=F1_415_RO+F1_415_AO,
         Ae_F1_414.counts=Ae_ratio_414*total_F1_414.counts, # Ae count 
         Ae_F1_415.counts=Ae_ratio_415*total_F1_415.counts,
         SNP_ID=str_c(CHROM,POS,sep="_")) %>% # usage of str_c 
  select(SNP_ID,gene_ID,ends_with("counts"))

# Rearrange the data so that each line is for one SNP in one of the crosses
Total.counts.long <- F1.young.gene.Ae_ratio %>% 
gather(key="cross",value="total.counts",total_F1_414.counts,total_F1_415.counts) %>% # the usage of gather 
  mutate(cross=str_extract(cross,"F1_41[45]")) %>% # usage of str_extract()
  select(-starts_with("Ae")) # usage of -starts_with() 

Ae.counts.long <- F1.young.gene.Ae_ratio %>%
  gather(key="cross",value="Ae.counts",Ae_F1_414.counts,Ae_F1_415.counts) %>%
    mutate(cross=str_extract(cross,"F1_41[45]")) %>%
select(-starts_with("total"))

F1.counts.long <- full_join(Total.counts.long,Ae.counts.long) # full_join()

# Start by selecting a single gene to work with
onegene <- F1.counts.long %>% filter(gene_ID=="BnaA01g00020D")
onegene

# one gene, with random effects
brms2 <- brm(Ae.counts | trials(total.counts) ~ cross + (1|SNP_ID),
             family="binomial",
             prior=set_prior("normal(0,10)", class="b"),
             data=onegene,
	     iter=10000, 
             control = list(adapt_delta = 0.99))

library(snowfall)
F1.counts.long.c <- F1.counts.long[complete.cases(F1.counts.long),]

sfInit(parallel = TRUE, cpus = parallel::detectCores())
sfLibrary(brms)
sfExport("F1.counts.long.c","brms2")

brms_all_mixed <-  
  sapply(unique(as.character(F1.counts.long.c$gene_ID)), function(x){
    new.data <- F1.counts.long.c %>% filter(gene_ID==x)
    tryCatch(update(brms2, newdata = new.data),
    error = function(e) NA)
})    

sfStop()

save(brms_all_mixed, file="/share/malooflab/Ruijuan/F1/output/brms_all_mixed_iter_10000.Rdata")

# calculate Ae_ratio in 414 & 415 actural data 
data_prob_Ae_result <- 
lapply(F1.counts.long.c$gene_ID, function(gene) 
	tryCatch({
	F1.counts.long.c %>% 
	filter(gene_ID=="BnaA01g00010D") %>% 
	group_by(cross) %>% 
	summarize(ae.ratio=mean(Ae.counts/total.counts))
}, error = function(e) NA)
)

# running in screen -r 23189.pts-66.cabernet 
