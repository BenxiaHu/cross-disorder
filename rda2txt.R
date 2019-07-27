load("/proj/hyejunglab/disorder/Schizophrenia_clozuk/capstone4/coloc_outputfile_SCZ_Capstone4_cisQTL.rda")
write.table(coloc_result_sig$locus2gene,file="/proj/hyejunglab/crossdisorder/Revision/hubenxia/coloc.txt",sep="\t",quote=F,row.names=F)

load("/proj/hyejunglab/eQTL/capstone4/eQTL/adultonly/eQTL_GRanges_colocinput.rda")
write.table(qtlranges$gene,file="/proj/hyejunglab/crossdisorder/Revision/hubenxia/coloc_background.txt",sep="\t",quote=F,row.names=F)
