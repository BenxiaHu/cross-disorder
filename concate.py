#!/usr/bin/env python
import os
import sys, getopt
import os.path
import gzip
from subprocess import call
import numpy as np
import pandas as pd
def annotation(asd,bd,adhd,output):
    asd_file =pd.read_csv(asd,sep="\t")
    bd_file = pd.read_csv(bd,sep="\t")
    adhd_file=pd.read_csv(adhd,sep="\t")
    output_file=open(output,'w')
    frame= pd.DataFrame()
    frame_temp= pd.DataFrame()
    result= []
    result=[asd_file,bd_file,adhd_file]
    frame_temp= pd.merge(asd_file,bd_file,how='outer')
    frame= pd.merge(adhd_file,frame_temp,how='outer')
    frame.to_csv(output_file,sep="\t",header=True,index=False)
    output_file.close()


def main(argv):
    asd_file=''
    bd_file=''
    adhd_file=''
    output_file=''
    try:
        opts, args = getopt.getopt(argv,"ha:b:c:o:",["asd=","bd=","adhd=","output="])
    except getopt.GetoptError:
        print 'python concate.py -a <asd_file> -b <bd_file> -c <adhd_file> -o <output_file>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'python concate.py -a <asd_file> -b <bd_file> -c <adhd_file> -o <output_file>'
            sys.exit()
        elif opt in ("-a", "--asd"):
            asd_file = arg
        elif opt in ("-b", "--bd"):
            bd_file = arg
        elif opt in ("-c", "--adhd"):
            adhd_file = arg
        elif opt in ("-o", "--output"):
            output_file = arg

    if asd_file=='':
        print >> sys.stderr, "Error: No asd file!"
        exit(1)
    if bd_file=='':
        print >> sys.stderr, "Error: No bd file!"
        exit(1)
    if adhd_file=='':
        print >> sys.stderr, "Error: No adhd file!"
        exit(1)
    if output_file=='':
        print >> sys.stderr, "Error: No output file!"
        exit(1)

    print "starting..."
    annotation(asd_file,bd_file,adhd_file,output_file)
    print "Finished"

if __name__ == '__main__':
    main(sys.argv[1:])