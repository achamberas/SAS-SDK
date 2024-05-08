# sas-test

ssh -i "/Users/anthonychamberas/Projects/Steritas/steritas-aws-key.pem" ec2-user@ec2-52-6-8-66.compute-1.amazonaws.com

python3.9 setup.py build_ext --inplace
export CPLUS_INCLUDE_PATH=/Library/Developer/CommandLineTools/Library/Frameworks/Python3.framework/Versions/3.9/Headers
export C_INCLUDE_PATH=/Library/Developer/CommandLineTools/Library/Frameworks/Python3.framework/Versions/3.9/Headers
gcc -o main main.c -I/usr/include/python3.9 -L/Library/Developer/CommandLineTools/Library/Frameworks/Python3.framework/Versions/3.9/lib/python3.9