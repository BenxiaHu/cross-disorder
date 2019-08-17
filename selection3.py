#!/usr/bin/env python
import os
import sys, getopt
import os.path
import gzip
from subprocess import call
def annotation(input,input_name,query,query_name,output):
    input_file= open(input,'r')
    query_file= open(query,'r')
    output_file=open(output,'w')
    output_file.writelines('geneid'+'\t'+'p'+'\n')
    input_file.readline()
    query_file.readline()
    total={}
    for line in input_file:
        total_gene=line.strip('\n')
        total[total_gene]=input_name
    for each in query_file:
        each=each.strip('\n')
        if each in total:
            output_file.writelines(each+'\t'+query_name+'\t'+each+'\t'+total[each]+'\n')
    output_file.close()
    query_file.close()
    input_file.close()


def main(argv):
    input_file=''
    target_file=''
    input_name=''
    target_name=''
    output_file=''
    try:
        opts, args = getopt.getopt(argv,"ha:c:b:d:o:",["input=","inputname=","target=","targetname=","output="])
    except getopt.GetoptError:
        print 'python selection3.py -a <input_file> -c <input_name> -b <target_file> -d <target_name> -o <output_file>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'python selection3.py -a <input_file> -c <input_name> -b <target_file> -d <target_name> -o <output_file>'
            sys.exit()
        elif opt in ("-a", "--input"):
            input_file = arg
        elif opt in ("-c", "--inputname"):
            input_name = arg
        elif opt in ("-b", "--target"):
            target_file = arg
        elif opt in ("-d", "--targetname"):
            target_name = arg
        elif opt in ("-o", "--output"):
            output_file = arg
    if input_file=='':
        print >> sys.stderr, "Error: No input file!"
        exit(1)
    if input_name=='':
        print >> sys.stderr, "Error: No input name!"
        exit(1)
    if target_file=='':
        print >> sys.stderr, "Error: No target file!"
        exit(1)
    if target_name=='':
        print >> sys.stderr, "Error: No target name!"
        exit(1)
    if output_file=='':
        print >> sys.stderr, "Error: No output file!"
        exit(1)
    print "starting..."
    annotation(input_file,input_name,target_file,target_name,output_file)
    print "Finished"

if __name__ == '__main__':
    main(sys.argv[1:])