if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("DESeq2")

setwd("~/RNAseq/jawaheer 11-2022/ReadsPerGene")


# sampleTable <- read.table("Expression_Data.txt",header=T,sep="\t",row.names=1)

keytable <- read.table("SraRunTable.txt", sep=",", header = T, row.names = 1)

# tab file format:
# col1 = gene name, col2 = unstranded counts
# col3 = forward counts, col4 = reverse counts

# dataFiles <- lapply(Sys.glob("data*.csv"), read.csv)
# reading in multiple files
countsdata <- lapply(Sys.glob("*.out.tab"), read.table, skip = 4, sep = "\t", row.names = 1)

#reformatting my list of dfs to have the samples as names
samplelist <- rownames(keytable)
names(countsdata) <- samplelist

# making a smaller list of samples and timepoints for input into DESeq2
coldata <- keytable["Time_point"]

# make 2D matrix of counts by gene name (rows) and sample name (columns)
# counts <- countsdata[[1]][1] for the first 1-97
counts <- data.frame(row.names = rownames(countsdata[[1]]))
for (x in 1:length(samplelist)) {
  counts[samplelist[x]] <- countsdata[[x]][1]
}

# make the DESeq2 dataset
library("DESeq2")
deseq2_dataset <- DESeqDataSetFromMatrix(countData = counts,
                                         colData = keytable,
                                         design = ~Time_point)
# backup, just in case:
write.csv(coldata, file="coldata.csv")
write.csv(counts, file="counts.csv")


# dds$condition <- factor(dds$condition,levels=c("Group1","Group2"))

# deseq2_dataset$Time_point <- factor(deseq2_dataset$Time_point, levels = c("PrS1-W1", "PoS1-W1"))
dds <- DESeq(deseq2_dataset)
res <- results(dds)
summary(res)
resOrdered <- res[order(res$padj),]
sum(res$padj<=0.05,na.rm=T) # 0 genes p<0.05

# Let's try a different design
# Let's make one variable in keytable that is a simple yes/no for before/after the 1st surgery
keytable$surg.status <- keytable$Time_point
for (x in 1:length(keytable$surg.status)) {
  if (keytable$surg.status[x] == "PrS1-W1") keytable$surg.status[x] <- "before.all"
    else keytable$surg.status[x] <- "after1st"
}

deseq2_dataset <- DESeqDataSetFromMatrix(countData = counts,
                                         colData = keytable,
                                         design = ~surg.status)
  
dds <- DESeq(deseq2_dataset)
res <- results(dds)
summary(res)
resOrdered <- res[order(res$padj),]
sum(res$padj<=0.05,na.rm=T) # got one this time!

deseq2_dataset <- DESeqDataSetFromMatrix(countData = counts,
                                         colData = keytable,
                                         design = ~surg.status+PATIENT)

dds <- DESeq(deseq2_dataset)
res <- results(dds)
summary(res)
resOrdered <- res[order(res$padj),]
sum(res$padj<=0.05,na.rm=T) #877 this time, better!

res05 <- results(dds,alpha=0.05)
sum(res05$padj<=0.05,na.rm=T) # 908 with p<0.5

plotMA(res,main="DESeq2",ylim=c(-2,2))


# plotCounts(dds,gene=which.min(res$padj),intgroup="condition")
plotCounts(dds,gene=which.min(res$padj),intgroup="surg.status")


write.csv(as.data.frame(resOrdered), file = 'surg.statusBYpatient_results.csv')
