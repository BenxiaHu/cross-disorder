#!/usr/bin/env python
import os
import sys, getopt
import os.path
import gzip
from subprocess import call
def annotation(input,query,output):
    input_file= open(input,'r')
    query_file= open(query,'r')
    output_file=open(output,'w')
    header=('\t').join(['geneid','ADHD','BD','MDD','SCZ'])
    output_file.writelines(header+'\n')
    input_file.readline()
    query_file.readline()
    total={}
    dict_gene={}
    for line in input_file:
        if line.startswith('geneid'):
            continue
        total_gene=line.strip('\n')
        total[total_gene]=''
    for each in query_file:
        if each.startswith('geneid'):
            continue
        each=each.strip('\n').split('\t')
        if each[0] in total:
            col_left=each[1].split('_')
            col_right=each[3].split('_')
            key=('\t').join([each[0],col_left[0],col_right[1]])
            if dict_gene.get(key):
                dict_gene[key].append(col_left[1])
            else:
                dict_gene[key]=[col_left[1]]
    for id in dict_gene:
        value=dict_gene[id]
        list1=['MDD','SCZ']
        list2=['MDD']
        list3=['SCZ']
        if value==list1:
            output_file.writelines(id+'\t'+('\t').join(list1)+'\n')
        elif value==list2:
            list2=['MDD',' ']
            output_file.writelines(id+'\t'+('\t').join(list2)+'\n')
        elif value==list3:
            list3=[' ','SCZ']
            output_file.writelines(id+'\t'+('\t').join(list3)+'\n')
    output_file.close()
    query_file.close()
    input_file.close()


def main(argv):
    input_file=''
    target_file=''
    output_file=''
    try:
        opts, args = getopt.getopt(argv,"ha:b:o:",["input=","target=","output="])
    except getopt.GetoptError:
        print 'python selection4.py -a <input_file>  -b <target_file>  -o <output_file>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'python selection4.py -a <input_file>  -b <target_file>  -o <output_file>'
            sys.exit()
        elif opt in ("-a", "--input"):
            input_file = arg
        elif opt in ("-b", "--target"):
            target_file = arg
        elif opt in ("-o", "--output"):
            output_file = arg
    if input_file=='':
        print >> sys.stderr, "Error: No input file!"
        exit(1)
    if target_file=='':
        print >> sys.stderr, "Error: No target file!"
        exit(1)
    if output_file=='':
        print >> sys.stderr, "Error: No output file!"
        exit(1)
    print "starting..."
    annotation(input_file,target_file,output_file)
    print "Finished"

if __name__ == '__main__':
    main(sys.argv[1:])