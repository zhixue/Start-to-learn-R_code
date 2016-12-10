##############
#差异基因分析#
##############

#首先在R环境下安装affy，limma包
source("http://biconductor.org/biocLite.R")
biocLite(c("affy","limma"))

#加载包，前者用于affymatrix预处理，后者用于差异表达分析
library(affy)
library(limma)

#将实验数据的表型信息读给变量phenoData，数据在安装好的系统里
phenoData<-read.AnnotatedDataFrame(system.file("extdata","pdata.txt",package="arrays"))

#读入数据，利用RMA函数对数据进行标准化处理
celfiles<-system.file("extdata",package="arrays")
eset<-justRMA(phenodata=phenodata,celfile.path=celfiles)

#差异基因表达，首次进行模型拟合
combn<-factor(paste(pData(phenoData)[,1],pData(phenoDatap)[,2],sep="_"))
design<-model.matrix(~combn)

#对探针组进行拟合后，用经验贝叶斯矫正
fit<-lmFit(eset,design)
efit<-eBayes(fit)

#差异表达列表
topTable(efit,coef=2)