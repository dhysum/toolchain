#/bin/bash

ctags -R ./

rm -vf cscope.*
find . -name "*.cpp" -or -name "*.h" -or -name "*.c" -o -name "*.y" -o -name "*.l" > cscope.files

cscope -C -b -q -k

