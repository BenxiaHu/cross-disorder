#!/usr/bin/env python
import os
import sys, getopt
import os.path
import gzip
from subprocess import call
def annotation(background,disease,coloc,output,output1,output2):
    background_file= open(background,'r')
    disease_file= open(disease,'r')
    coloc_file=open(coloc,'r')
    output_file=open(output,'w')
    output_file.writelines('geneid'+'\t'+'p'+'\n')
    output_file1=open(output1,'w')
    output_file1.writelines('geneid'+'\n')
    output_file2=open(output2,'w')
    output_file2.writelines('geneid'+'\n')
    background_file.readline()
    disease_file.readline()
    coloc_file.readline()
    total={}
    Hgene={}
    for line in background_file:
        total_gene=line.strip('\n').split('.')[0]
        total[total_gene]=''
    for key in total:
        output_file1.writelines(key+'\n')
    for each in disease_file:
        each=each.strip('\n').split(' ')
        if each[0] in total:
            output_file.writelines(each[0]+'\t'+each[-1]+'\n')
    for eachline in coloc_file:
        each=eachline.strip('\n').split(':')[2]
        gene=each.split('.')[0]
        output_file2.writelines(gene+'\n')
    background_file.close()
    disease_file.close()
    coloc_file.close()
    output_file.close()
    output_file1.close()
    output_file2.close()


def main(argv):
    background_file=''
    disease_file=''
    coloc_file=''
    output_file=''
    output_file1=''
    output_file2=''
    try:
        opts, args = getopt.getopt(argv,"hb:d:c:o:k:e:",["background=","disease=","coloc=","output=","output1=","output2="])
    except getopt.GetoptError:
        print 'python selection.py -b <background_file> -d <disease_file> -c <coloc_file> -o <output_file> -k <output_file1>  -e <output_file2>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'python selection.py -b <background_file> -d <disease_file> -c <coloc_file> -o <output_file> -k <output_file1> -e <output_file2>'
            sys.exit()
        elif opt in ("-b", "--background"):
            background_file = arg
        elif opt in ("-d", "--disease"):
            disease_file = arg
        elif opt in ("-c", "--coloc"):
            coloc_file = arg
        elif opt in ("-o", "--output"):
            output_file = arg
        elif opt in ("-k", "--output1"):
            output_file1 = arg
        elif opt in ("-e", "--output2"):
            output_file2 = arg
    if background_file=='':
        print >> sys.stderr, "Error: No background file!"
        exit(1)
    if disease_file=='':
        print >> sys.stderr, "Error: No disease file!"
        exit(1)
    if coloc_file=='':
        print >> sys.stderr, "Error: No coloc file!"
        exit(1)
    if output_file=='':
        print >> sys.stderr, "Error: No output file!"
        exit(1)
    if output_file1=='':
        print >> sys.stderr, "Error: No output file1!"
        exit(1)
    if output_file2=='':
        print >> sys.stderr, "Error: No output file2!"
        exit(1)
    print "starting..."
    annotation(background_file,disease_file,coloc_file,output_file,output_file1,output_file2)
    print "Finished"

if __name__ == '__main__':
    main(sys.argv[1:])