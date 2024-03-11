/* A testbench to verify a DUT using Verilator */

#include <array>
#include <iostream>
#include <bitset>
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vtop.h"

namespace {
static constexpr std::array<unsigned int, 10> kTestCases {
    0b00111110000000000000000000000000, // 0.125
    0b00111101100000000000000000000000, // 0.0625
    0b10111101100000000000000000000000, // -0.0625
    0b00000000000000000000000000000000, // 0
    0b00111111100000000000000000000000, // 1
    0b10111111100000000000000000000000, // -1
    0b00111110100101000111101011100001, // idk
    0b00111110100101000111101011100001,  // idk
    0b00111110100101000111101011100001,  // idk
    0b00111110100101000111101011100001  // idk
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

    dut->in = 0;
    // flush the pipeline
    dut->eval();
    dut->eval();
    dut->eval();
    dut->eval();
    dut->eval();
    dut->eval();

    for (std::size_t i = 0; i < kTestCases.size(); i++) {
        dut->in = kTestCases[i];
        dut->eval();
        tfp->dump(i);
        // for (int tick = 0; tick < 2; tick++) {
        //     dut->clk = !dut->clk;
        //     tfp->dump(2*i + tick);
        //     dut->eval();
        // }
        std::cout << "Input: " << dut->in << ((dut->in != 0) ? " \t| " : " \t\t| ") << std::bitset<32>(dut->in) << std::endl;
        std::cout << "Output: " << dut->fp_out << ((dut->in != 0) ? " \t| " : " \t\t| ") << std::bitset<32>(dut->fp_out) << std::endl;
    }

    // housekeeping
    tfp->close();
    delete dut;
    delete tfp;
    exit(0);
}

