# sas-test

ssh -i "/Users/anthonychamberas/Projects/Steritas/steritas-aws-key.pem" ec2-user@ec2-52-6-8-66.compute-1.amazonaws.com

sudo yum groupinstall "Development Tools"
sudo yum install -y python3-pip python3 python3-setuptools
sudo yum install -y python3-devel.x86_64
sudo python3.7m -m pip install Cython

python3 setup.py build_ext --inplace
gcc -o main main.c -I/usr/include/python3.7m -L /usr/lib/x86_64-linux-gnu/ -lpython3.7m

gcc -m64 -c -Wall -g -fPIC calculate_wrapper.c -I/usr/include/python3.7m -L /usr/lib/x86_64-linux-gnu/ -lpython3.7m
gcc -m64 -shared -o calculate_wrapper.so -fPIC calculate_wrapper.o -I/usr/include/python3.7m -L /usr/lib/x86_64-linux-gnu/ -lpython3.7m
gcc -m64 main.c calculate_wrapper.so -I/usr/include/python3.7m -L /usr/lib/x86_64-linux-gnu/ -lpython3.7m
./a.out

export CPLUS_INCLUDE_PATH=/Library/Developer/CommandLineTools/Library/Frameworks/Python3.framework/Versions/3.9/Headers
export C_INCLUDE_PATH=/Library/Developer/CommandLineTools/Library/Frameworks/Python3.framework/Versions/3.9/Headers
gcc -o main main.c -I/usr/include/python3.9 -L/Library/Developer/CommandLineTools/Library/Frameworks/Python3.framework/Versions/3.9/lib/python3.9

