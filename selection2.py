#!/usr/bin/env python
import os
import sys, getopt
import os.path
import gzip
from subprocess import call
def annotation(twas,disease,output,output1):
    disease_file= open(disease,'r')
    twas_file=open(twas,'r')
    output_file=open(output,'w')
    output_file.writelines('geneid'+'\t'+'p'+'\n')
    output_file1=open(output1,'w')
    output_file1.writelines('geneid'+'\t'+'p'+'\n')
    twas_file.readline()
    disease_file.readline()
    total={}
    for line in twas_file:
        total_gene=line.strip('\n').split(',')
        total[total_gene[1]]=total_gene[-6]
    for key in total:
        output_file.writelines(key+'\t'+total[key]+'\n')  #output twas gene and p value
    for each in disease_file:
        each=each.strip('\n').split(' ')
        if each[0] in total:
            output_file1.writelines(each[0]+'\t'+each[-1]+'\n')  #output disease genes in the twas list
    twas_file.close()
    disease_file.close()
    output_file.close()
    output_file1.close()


def main(argv):
    disease_file=''
    twas_file=''
    output_file=''
    output_file1=''

    try:
        opts, args = getopt.getopt(argv,"ht:d:o:k:",["twas=","disease=","output=","output1="])
    except getopt.GetoptError:
        print 'python selection2.py -t <twas_file> -d <disease_file>  -o <output_file> -k <output_file1>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'python selection2.py -t <twas_file> -d <disease_file>  -o <output_file> -k <output_file1>'
            sys.exit()
        elif opt in ("-d", "--disease"):
            disease_file = arg
        elif opt in ("-t", "--twas"):
            twas_file = arg
        elif opt in ("-o", "--output"):
            output_file = arg
        elif opt in ("-k", "--output1"):
            output_file1 = arg
    if disease_file=='':
        print >> sys.stderr, "Error: No disease file!"
        exit(1)
    if twas_file=='':
        print >> sys.stderr, "Error: No twas file!"
        exit(1)
    if output_file=='':
        print >> sys.stderr, "Error: No output file!"
        exit(1)
    if output_file1=='':
        print >> sys.stderr, "Error: No output file1!"
        exit(1)
    print "starting..."
    annotation(twas_file,disease_file,output_file,output_file1)
    print "Finished"

if __name__ == '__main__':
    main(sys.argv[1:])