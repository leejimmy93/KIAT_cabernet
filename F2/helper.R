# function to do correlation across very large matrices. 
library(bigmemory)

chunked.cor <- function(my.data,chunk.size=NA,use="everything",method="pearson", verbose=TRUE) {
  
  ncol <- ncol(my.data)
  
  if(is.na(chunk.size)) chunk.size <- min(10000, floor(ncol/10))

  n.chunks <- ceiling(ncol/chunk.size)
  
  if(verbose) cat("chunk size: ",chunk.size,"\n n.chunks: ",n.chunks,"\n")
  
    if(verbose) cat("creating matrix\n")

    cor.results <- filebacked.big.matrix(nrow = ncol,
                                        ncol = ncol,
                                        backingfile = "cor.results.bm"
                                        )
                                        
  if(verbose) cat("done\n")
    
  
  for(i in 1:n.chunks) {
    chunk.i.cols <- ((i-1)*chunk.size + 1) : min(i*chunk.size,ncol) # so that we don't go over on the last column
    
      if(verbose) cat("starting outer chunk i: ",i,"\n")
    
    for(j in i:n.chunks) {
      #cat("\ni: ",i,"j: ",j)
      chunk.j.cols <- ((j-1)*chunk.size + 1) : min(j*chunk.size,ncol) # so that we don't go over on the last column
      tmp.cor <- cor(my.data[,chunk.i.cols],
                         my.data[,chunk.j.cols],use=use,method=method)
      if(i==j) tmp.cor[lower.tri(tmp.cor)] <- NA # clean up if on diagonal
      cor.results[chunk.i.cols,chunk.j.cols] <- tmp.cor
    }
  }
  cor.results
}
