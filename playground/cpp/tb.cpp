/* A testbench to verify a DUT using Verilator */

#include <iostream>
#include <bitset>
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
    dut->in = 0b01000010101010100100000000000000;
    dut->eval();
    std::cout << "Converting: \t" << std::hex << dut->in << " \t| " << std::bitset<32>(dut->in) << std::endl;
    std::cout << "Got: \t\t" << std::hex << dut->out << " \t| " << std::bitset<32>(dut->out) << std::endl;

// housekeeping
tfp->close();
delete dut;
delete tfp;
exit(0);
}

