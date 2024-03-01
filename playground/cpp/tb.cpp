/* A testbench to verify a DUT using Verilator */

#include <iostream>
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vtop.h"

int main(int argc, char** argv, char** env) {

    Verilated::commandArgs(argc, argv);
    // initialise device under test
    Vtop* dut = new Vtop;

    // intitialise trace
    VerilatedVcdC* tfp = new VerilatedVcdC;
    Verilated::traceEverOn(true);
    dut->trace(tfp, 99);
    tfp->open("top.vcd");

    // initialise
    dut->clk = 0;
    dut->count = 0;

    for (int i = 0; i < 100; i++) {
        dut->count++;
        dut->clk = !dut->clk;
        dut->eval();
    }

// housekeeping
tfp->close();
delete dut;
delete tfp;
exit(0);
}

