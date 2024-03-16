#!/bin/bash

#cleanup
rm -rf obj_dir

# verilate
verilator -Wall --trace -cc unfolded/top.v unfolded/cordic_reg.v unfolded/cordic.v unfolded/add_sub.v unfolded/fp_to_fixed.v unfolded/fixed_to_fp.v --exe cpp/tb.cpp

# make
make -C obj_dir -f Vtop.mk Vtop

# run
./obj_dir/Vtop
