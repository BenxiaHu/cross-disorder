library(Vennerable)
setwd("/proj/hyejunglab/crossdisorder/Revision/hubenxia/")
options(stringsAsFactors=FALSE)
background_SCZ<-read.table("twas_SCZ_gene.txt",header=T,sep="\t")
SCZ_gene<-read.table("twas_SCZ_overlap_gene.txt", header=T,sep="\t")
MAGMAv26_SCZ_gene<-read.table("/proj/hyejunglab/crossdisorder/Revision/hubenxia/twas_MAGMAv26_SCZ_overlap_gene.txt",sep="\t",header=T)

background_ASD<-read.table("twas_ASD_gene.txt",header=T,sep="\t")
ASD_gene<-read.table("twas_ASD_overlap_gene.txt", header=T,sep="\t")
background_BD<-read.table("twas_BD_gene.txt",header=T,sep="\t")
BD_gene<-read.table("twas_BD_overlap_gene.txt", header=T,sep="\t")

adjust<-function(input){
    input$FDR<-p.adjust(input[,2], method= "BH")
    result<-input[input$FDR<0.05,][,1]
    return(result)
}
twas_SCZ_adjust<-adjust(background_SCZ)
SCZ_adjust<-adjust(SCZ_gene)
MAGMAv26_SCZ_adjust<-adjust(MAGMAv26_SCZ_gene)

twas_ASD_adjust<-adjust(background_ASD)
ASD_adjust<-adjust(ASD_gene)
twas_BD_adjust<-adjust(background_BD)
BD_adjust<-adjust(BD_gene)

gplot<-function(input,target,filename){
    gene<-list(disease=input,twas=target)
    Vdemo<-Venn(gene)
    pdf(paste0(filename,"_twas_overlap_gene.pdf"))
    p<-plot(Vdemo, doWeights = TRUE, type = "circles")
    print (p)
    dev.off()
}

gplot(SCZ_adjust,twas_SCZ_adjust,'SCZ')
gplot(MAGMAv26_SCZ_adjust,twas_SCZ_adjust,'MAGMAv26_SCZ')

gplot(ASD_adjust,twas_ASD_adjust,'ASD')
gplot(BD_adjust,twas_BD_adjust,'BD')

SCZ_twas<-515
SCZ_only<-2286
twas_only<-193
two_gene<-union(SCZ_adjust,twas_SCZ_adjust)
SCZ_background<-length(setdiff(background_SCZ[,1],two_gene))
SCZ<-matrix(c(SCZ_twas,SCZ_only,twas_only,SCZ_background),2,2)
fisher.result<-fisher.test(SCZ)


#fisher.result$p.value
[1] 3.939112e-206
#Fisher's Exact Test for Count Data

data:  SCZ
p-value < 2.2e-16
alternative hypothesis: true odds ratio is not equal to 1
95 percent confidence interval:
 10.20282 14.48942
sample estimates:
odds ratio 
  12.13855 


MAGMAv26_SCZ_twas<-597
MAGMAv26_SCZ_only<-1943
twas_only<-111
two_gene<-union(MAGMAv26_SCZ_adjust,twas_SCZ_adjust)
SCZ_background<-length(setdiff(background_SCZ[,1],two_gene))
SCZ<-matrix(c(MAGMAv26_SCZ_twas,MAGMAv26_SCZ_only,twas_only,SCZ_background),2,2)
fisher.result<-fisher.test(SCZ)

##fisher.result
##fisher.result$p.value
0

	Fisher's Exact Test for Count Data

data:  SCZ
p-value < 2.2e-16
alternative hypothesis: true odds ratio is not equal to 1
95 percent confidence interval:
 24.09868 36.92882
sample estimates:
odds ratio 
  29.72708




ASD_twas<-5
ASD_only<-56
twas_only<-4
two_gene<-union(ASD_adjust,twas_ASD_adjust)
ASD_background<-length(setdiff(background_ASD[,1],two_gene))
ASD<-matrix(c(ASD_twas,ASD_only,twas_only,ASD_background),2,2)
fisher.result<-fisher.test(ASD)

#fisher.result$p.value
[1]2.087099e-10
#Fisher's Exact Test for Count Data

data:  ASD
p-value = 2.087e-10
alternative hypothesis: true odds ratio is not equal to 1
95 percent confidence interval:
   61.40082 1599.04645
sample estimates:
odds ratio 
  292.7914


BD_twas<-7
BD_only<-351
twas_only<-28
two_gene<-union(BD_adjust,twas_BD_adjust)
BD_background<-length(setdiff(background_BD[,1],two_gene))
BD<-matrix(c(BD_twas,BD_only,twas_only,BD_background),2,2)
fisher.result<-fisher.test(BD)

#fisher.result$p.value
[1]0.000114327

#Fisher's Exact Test for Count Data

data:  BD
p-value = 0.0001143
alternative hypothesis: true odds ratio is not equal to 1
95 percent confidence interval:
  2.755982 17.789328
sample estimates:
odds ratio 
  7.523825