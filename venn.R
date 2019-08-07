library(Vennerable)
setwd("/proj/hyejunglab/crossdisorder/Revision/hubenxia/")
background_SCZ<-read.table("/proj/hyejunglab/crossdisorder/Revision/hubenxia/background_SCZ.txt",header=T,sep="\t")
SCZ_gene<-read.table("/proj/hyejunglab/crossdisorder/Revision/hubenxia/SCZ_gene.txt", header=T,sep="\t")[,1]  #coloc
MAGMAv26_SCZ_gene<-read.table("/proj/hyejunglab/crossdisorder/Revision/hubenxia/MAGMAv26_SCZ_gene.txt", header=T,sep="\t")[,1]

coloc_backgroundid<-read.table("/proj/hyejunglab/crossdisorder/Revision/hubenxia/coloc_backgroundid.txt", header=T,sep="\t")[,1]
background_SCZ$FDR<-p.adjust(background_SCZ[,2], method= "BH")
background_SCZ<-background_SCZ[background_SCZ$FDR<0.05,][,1]
gplot<-function(input,target,filename){
    gene<-list(disease=input,coloc=target)
    Vdemo<-Venn(gene)
    pdf(paste0(filename,"_coloc_overlap_gene.pdf"))
    p<-plot(Vdemo, doWeights = TRUE, type = "circles")
    print (p)
    dev.off()
}

gplot(background_SCZ,SCZ_gene,'SCZ')
gplot(background_SCZ,MAGMAv26_SCZ_gene,'MAGMAv26_SCZ')

SCZ_coloc<-181
SCZ_only<-4396
colc_only<-74
two_gene<-union(background_SCZ,SCZ_gene)
SCZ_background<-length(setdiff(coloc_backgroundid,two_gene))
SCZ<-matrix(c(SCZ_coloc,SCZ_only,colc_only,SCZ_background),2,2)
fisher.result<-fisher.test(SCZ)


#fisher.result$p.value
[1] 3.195631e-93

#Fisher's Exact Test for Count Data

data:  SCZ
p-value < 2.2e-16
alternative hypothesis: true odds ratio is not equal to 1
95 percent confidence interval:
 11.33803 19.92837
sample estimates:
odds ratio 
  14.96772 




MAGMAv26_SCZ_coloc<-189
MAGMAv26_SCZ_only<-4679
colc_only<-66
two_gene<-union(background_SCZ,MAGMAv26_SCZ_gene)
SCZ_background<-length(setdiff(coloc_backgroundid,two_gene))
SCZ<-matrix(c(MAGMAv26_SCZ_coloc,MAGMAv26_SCZ_only,colc_only,SCZ_background),2,2)
fisher.result<-fisher.test(SCZ)


#fisher.result$p.value
[1] 4.935881e-98

#fisher.result

	Fisher's Exact Test for Count Data

data:  SCZ
p-value < 2.2e-16
alternative hypothesis: true odds ratio is not equal to 1
95 percent confidence interval:
 12.22895 21.93239
sample estimates:
odds ratio 
  16.29126 