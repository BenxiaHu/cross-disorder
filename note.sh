#H-MAGMA results are stored: /proj/hyejunglab/crossdisorder/MAGMA/result_harper/magma1.07/adult_brain/ab_results
#SCZ: scz.clozuk.2017_AB_wointron.genes.genes.out
#ASD: asd.daly.2017_AB_wointron.genes.genes.out
#BD: bp.pgc.2018_AB_wointron.genes.genes.out
#Coloc for SCZ: /proj/hyejunglab/disorder/Schizophrenia_clozuk/capstone4/coloc_outputfile_SCZ_Capstone4_cisQTL.rda

#TWAS results are stored: /proj/hyejunglab/expression/capstone1_disorder
#SCZ: SCZ_TWAS.csv
#ASD: ASD_TWAS.csv
#BD: BD_TWAS.csv

#protein-coding genes can be obtained by: /proj/hyejunglab/chr/geneAnno_allgenes.rda

#TWAS comparison
#1. Read H-MAGMA SCZ results
#2. Read TWAS SCZ results
#3. Select H-MAGMA genes that were detected in TWAS SCZ results
#4. Calculate FDR from the H-MAGMA
#5. Take FDR<0.05 genes from H-MAGMA
#6. Calculate TWAS FDR from TWAS.P
#7. Take FDR<0.05 genes from TWAS
#8. Make a Venn diagram with H-MAGMA genes vs. TWAS genes
#9. Run Fisher’s exact test (edited) 
#Repeat this for ASD and BD

module add r/3.5.2
R CMD BATCH --no-save /nas/longleaf/home/hubenxia/project/cross/rda2txt.R

cd /proj/hyejunglab/crossdisorder/MAGMA/result_harper/magma1.07/adult_brain/ab_results
SCZ=scz.clozuk.2017_AB_wointron.genes.genes.out
ASD=asd.daly.2017_AB_wointron.genes.genes.out
BD=bp.pgc.2018_AB_wointron.genes.genes.out

SCZ_TWAS=/proj/hyejunglab/expression/capstone1_disorder/SCZ_TWAS.csv
ASD_TWAS=/proj/hyejunglab/expression/capstone1_disorder/ASD_TWAS.csv
BD_TWAS=/proj/hyejunglab/expression/capstone1_disorder/BD_TWAS.csv

dos2unix /nas/longleaf/home/hubenxia/project/cross/selection2.py
python /nas/longleaf/home/hubenxia/project/cross/selection2.py -t $SCZ_TWAS -d $SCZ  -o /proj/hyejunglab/crossdisorder/Revision/hubenxia/twas_SCZ_gene.txt -k /proj/hyejunglab/crossdisorder/Revision/hubenxia/twas_SCZ_overlap_gene.txt
python /nas/longleaf/home/hubenxia/project/cross/selection2.py -t $ASD_TWAS -d $ASD  -o /proj/hyejunglab/crossdisorder/Revision/hubenxia/twas_ASD_gene.txt -k /proj/hyejunglab/crossdisorder/Revision/hubenxia/twas_ASD_overlap_gene.txt
python /nas/longleaf/home/hubenxia/project/cross/selection2.py -t $BD_TWAS -d $BD  -o /proj/hyejunglab/crossdisorder/Revision/hubenxia/twas_BD_gene.txt -k /proj/hyejunglab/crossdisorder/Revision/hubenxia/twas_BD_overlap_gene.txt

module add r/3.5.2
R CMD BATCH --no-save /nas/longleaf/home/hubenxia/project/cross/venn2.R

#Coloc comparison
#1. Load coloc results
#2. Take genes from coloc_result_sig$locus2gene: you should get  ENSG IDs (remove .)
#3. Load eQTL source file: load("/proj/hyejunglab/eQTL/capstone4/eQTL/adultonly/eQTL_GRanges_colocinput.rda")
#4. Retrieve genes from qtlranges: qtlranges$gene -> remove . & unique -> this will be your background gene list
#5. Read H-MAGMA SCZ results
#6. Select H-MAGMA genes that were detected in background genes.
#7. Take FDR<0.05 genes from H-MAGMA
#8. Compare H-MAGMA genes from coloc genes from (2)
#9. Make a Venn diagram with H-MAGMA genes vs. coloc genes
#10. Run Fisher’s exact test
#Save all files in this revision directory: /proj/hyejunglab/crossdisorder/Revision


module add r/3.5.2
R CMD BATCH --no-save /nas/longleaf/home/hubenxia/project/cross/rda2txt.R

cd /proj/hyejunglab/crossdisorder/MAGMA/result_harper/magma1.07/adult_brain/ab_results
SCZ=scz.clozuk.2017_AB_wointron.genes.genes.out
background=/proj/hyejunglab/crossdisorder/Revision/hubenxia/coloc_background.txt
coloc=/proj/hyejunglab/crossdisorder/Revision/hubenxia/coloc.txt
dos2unix /nas/longleaf/home/hubenxia/project/cross/selection.py
python /nas/longleaf/home/hubenxia/project/cross/selection.py -b $background -d $SCZ -c $coloc -o /proj/hyejunglab/crossdisorder/Revision/hubenxia/background_SCZ.txt -k /proj/hyejunglab/crossdisorder/Revision/hubenxia/coloc_backgroundid.txt -e /proj/hyejunglab/crossdisorder/Revision/hubenxia/SCZ_gene.txt

module add r/3.5.2
R CMD BATCH --no-save /nas/longleaf/home/hubenxia/project/cross/venn.R


ASD_BD=/proj/hyejunglab/crossdisorder/MAGMA/RRHO/RRHO_GO_MostUpregulatedASD_VS_Bipolar.csv
ASD_SCZ=/proj/hyejunglab/crossdisorder/MAGMA/RRHO/RRHO_GO_MostUpregulatedASD_VS_Schizophrenia.csv
ASD_MDD=/proj/hyejunglab/crossdisorder/MAGMA/RRHO/RRHO_GO_MostUpregulatedASD_VS_MDD.csv
ASD_ADHD=/proj/hyejunglab/crossdisorder/MAGMA/RRHO/RRHO_GO_MostUpregulatedADHD_VS_ASD.csv

ASD=($ASD_SCZ $ASD_MDD $ASD_ADHD)
ASD_name=("ASD_SCZ" "ASD_MDD" "ASD_ADHD")
for i in {0..2}
do
    filename=ASD_BD_"${ASD_name[i]}".txt
    dos2unix /nas/longleaf/home/hubenxia/project/cross/selection3.py
    python /nas/longleaf/home/hubenxia/project/cross/selection3.py  -a $ASD_BD  -c ASD_BD -b "${ASD[i]}" -d "${ASD_name[i]}" -o /proj/hyejunglab/crossdisorder/Revision/hubenxia/$filename
done

ASD_BD_ASD_ADHD=/proj/hyejunglab/crossdisorder/Revision/hubenxia/ASD_BD_ASD_ADHD.txt
ASD_BD_ASD_MDD=/proj/hyejunglab/crossdisorder/Revision/hubenxia/ASD_BD_ASD_MDD.txt
ASD_BD_ASD_SCZ=/proj/hyejunglab/crossdisorder/Revision/hubenxia/ASD_BD_ASD_SCZ.txt
ASD=($ASD_BD_ASD_ADHD $ASD_BD_ASD_MDD $ASD_BD_ASD_SCZ)

for i in {0..2}
do
    cat "${ASD[i]}" >> /proj/hyejunglab/crossdisorder/Revision/hubenxia/ASD_BD_merge.txt
    filename=ASD_BD_class_temp.txt
    cat "${ASD[i]}" | awk '{print $1}'  >> /proj/hyejunglab/crossdisorder/Revision/hubenxia/$filename
done

cat /proj/hyejunglab/crossdisorder/Revision/hubenxia/$filename | sort | uniq  > /proj/hyejunglab/crossdisorder/Revision/hubenxia/ASD_BD_class.txt

dos2unix /nas/longleaf/home/hubenxia/project/cross/selection4.py

input=/proj/hyejunglab/crossdisorder/Revision/hubenxia/ASD_BD_class.txt
target=/proj/hyejunglab/crossdisorder/Revision/hubenxia/ASD_BD_merge.txt
python /nas/longleaf/home/hubenxia/project/cross/selection4.py -a $input  -b $target  -o /proj/hyejunglab/crossdisorder/Revision/hubenxia/ASD_union.txt

ADHD_BD=/proj/hyejunglab/crossdisorder/MAGMA/RRHO/RRHO_GO_MostUpregulatedADHD_VS_Bipolar.csv
ADHD_SCZ=/proj/hyejunglab/crossdisorder/MAGMA/RRHO/RRHO_GO_MostUpregulatedADHD_VS_Schizophrenia.csv
ADHD_MDD=/proj/hyejunglab/crossdisorder/MAGMA/RRHO/RRHO_GO_MostUpregulatedADHD_VS_MDD.csv

ADHD=($ADHD_SCZ $ADHD_MDD)
ADHD_name=("ADHD_SCZ" "ADHD_MDD")
for i in {0..1}
do
    filename=ADHD_BD_"${ADHD_name[i]}".txt
    dos2unix /nas/longleaf/home/hubenxia/project/cross/selection3.py
    python /nas/longleaf/home/hubenxia/project/cross/selection3.py  -a $ADHD_BD  -c ADHD_BD -b "${ADHD[i]}" -d "${ADHD_name[i]}" -o /proj/hyejunglab/crossdisorder/Revision/hubenxia/$filename
done

ADHD_BD_ADHD_MDD=/proj/hyejunglab/crossdisorder/Revision/hubenxia/ADHD_BD_ADHD_MDD.txt 
ADHD_BD_ADHD_SCZ=/proj/hyejunglab/crossdisorder/Revision/hubenxia/ADHD_BD_ADHD_SCZ.txt

ADHD=($ADHD_BD_ADHD_MDD $ADHD_BD_ADHD_SCZ)
for i in {0..1}
do
    cat "${ADHD[i]}" >> /proj/hyejunglab/crossdisorder/Revision/hubenxia/ADHD_BD_merge.txt
    #filename=ADHD_BD_class_temp.txt
    #cat "${ADHD[i]}" | awk '{print $1}'  >> /proj/hyejunglab/crossdisorder/Revision/hubenxia/$filename
done

cat /proj/hyejunglab/crossdisorder/Revision/hubenxia/$filename | sort | uniq  > /proj/hyejunglab/crossdisorder/Revision/hubenxia/ADHD_BD_class.txt

dos2unix /nas/longleaf/home/hubenxia/project/cross/selection5.py

input=/proj/hyejunglab/crossdisorder/Revision/hubenxia/ADHD_BD_class.txt
target=/proj/hyejunglab/crossdisorder/Revision/hubenxia/ADHD_BD_merge.txt
python /nas/longleaf/home/hubenxia/project/cross/selection5.py -a $input  -b $target  -o /proj/hyejunglab/crossdisorder/Revision/hubenxia/ADHD_union.txt

BD_SCZ=/proj/hyejunglab/crossdisorder/MAGMA/RRHO/RRHO_GO_MostUpregulatedBipolar_VS_Schizophrenia.csv
BD_MDD=/proj/hyejunglab/crossdisorder/MAGMA/RRHO/RRHO_GO_MostUpregulatedBipolar_VS_MDD.csv

BD=($BD_MDD)
BD_name=("BD_MDD")
for i in 0
do
    filename=BD_SCZ_"${BD_name[i]}".txt
    dos2unix /nas/longleaf/home/hubenxia/project/cross/selection3.py
    python /nas/longleaf/home/hubenxia/project/cross/selection3.py  -a $BD_SCZ  -c BD_SCZ -b "${BD[i]}" -d "${BD_name[i]}" -o /proj/hyejunglab/crossdisorder/Revision/hubenxia/$filename
done

input=/proj/hyejunglab/crossdisorder/Revision/hubenxia/BD_SCZ_BD_MDD.txt
cat $input | awk -v OFS="\t" '{print $1,"BD","MDD","SCZ"}' > /proj/hyejunglab/crossdisorder/Revision/hubenxia/BD_union.txt

SCZ_MDD=/proj/hyejunglab/crossdisorder/MAGMA/RRHO/RRHO_GO_MostUpregulatedSchizophrenia_VS_MDD.csv
cat $SCZ_MDD | awk -v OFS="\t" '{print $0,"SCZ","MDD"}' > /proj/hyejunglab/crossdisorder/Revision/hubenxia/SCZ_union.txt