#!/bin/bash

#cleanup
rm -rf obj_dir

# verilate
verilator -Wall --trace -cc verilog/top.v verilog/cordic.v verilog/fp_to_fixed.v verilog/fixed_to_fp.v --exe cpp/tb.cpp

# make
make -C obj_dir -f Vtop.mk Vtop

# run
./obj_dir/Vtop
