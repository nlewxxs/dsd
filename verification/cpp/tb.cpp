/* A testbench to verify a DUT using Verilator */

#include <array>
#include <iostream>
#include <bitset>
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vtop.h"

namespace {
static constexpr std::array<unsigned int, 6> kTestCases {
    0b00111110000000000000000000000000, // 0.125
    0b00111101100000000000000000000000, // 0.0625
    0b10111101100000000000000000000000, // -0.0625
    0b00000000000000000000000000000000, // 0
    0b00111111100000000000000000000000, // 1
    0b10111111100000000000000000000000 // -1
};
}

int main(int argc, char** argv, char** env) {

    Verilated::commandArgs(argc, argv);
    // initialise device under test
    Vtop* dut = new Vtop;

    // intitialise trace
    VerilatedVcdC* tfp = new VerilatedVcdC;
    Verilated::traceEverOn(true);
    dut->trace(tfp, 99);
    tfp->open("top.vcd");

    for (auto& i : kTestCases) {
        dut->clk = 0; // falling edge
        dut->in = i;
        dut->eval();
        dut->clk = 1; // rising edge
        dut->eval();
        std::cout << "-----------------------------" << std::endl;
        std::cout << "Converting: \t" << std::bitset<32>(dut->in) << std::endl;
        std::cout << "integer: \t" << std::bitset<2>(dut->int_out) << std::endl;
        std::cout << "fractional: \t" << std::bitset<23>(dut->frac_out) << std::endl;
    }

    // housekeeping
    tfp->close();
    delete dut;
    delete tfp;
    exit(0);
}

