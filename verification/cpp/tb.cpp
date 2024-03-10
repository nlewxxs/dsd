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

    for (std::size_t i = 0; i < kTestCases.size(); i++) {
        dut->in = kTestCases[i];
        for (int tick = 0; tick < 2; tick++) {
            tfp->dump(2*i + tick);
            dut->clk = !dut->clk;
            dut->eval();
        }
    }

    // housekeeping
    tfp->close();
    delete dut;
    delete tfp;
    exit(0);
}

