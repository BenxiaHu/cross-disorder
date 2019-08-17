# cross-disorder
cross disorder revision
## TWAS comparison

1. Read H-MAGMA SCZ results
2. Read TWAS SCZ results
3. Select H-MAGMA genes that were detected in TWAS SCZ results
4. Calculate FDR from the H-MAGMA
5. Take FDR<0.05 genes from H-MAGMA
6. Calculate TWAS FDR from TWAS.P
7. Take FDR<0.05 genes from TWAS
8. Make a Venn diagram with H-MAGMA genes vs. TWAS genes
9. Run Fisher’s exact test (edited) 
10.Repeat this for ASD and BD

## Coloc comparison

1. Load coloc results
2. Take genes from coloc_result_sig$locus2gene: you should get  ENSG IDs (remove .)
3. Load eQTL source file: load("/proj/hyejunglab/eQTL/capstone4/eQTL/adultonly/eQTL_GRanges_colocinput.rda")
4. Retrieve genes from qtlranges: qtlranges$gene -> remove . & unique -> this will be your background gene list
5. Read H-MAGMA SCZ results
6. Select H-MAGMA genes that were detected in background genes.
7. Take FDR<0.05 genes from H-MAGMA
8. Compare H-MAGMA genes from coloc genes from (2)
9. Make a Venn diagram with H-MAGMA genes vs. coloc genes
10. Run Fisher’s exact test

## generate union gene list
