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
    dut->in = 0b00111110000000000000000000000000; // 0.125
    dut->eval();
    dut->clk = !dut->clk;
    dut->eval();
    std::cout << "Converting: \t" << std::hex << dut->in << " \t| " << std::bitset<32>(dut->in) << std::endl;
    std::cout << "int: \t\t" << std::hex << dut->int_out << " \t| " << std::bitset<2>(dut->int_out) << std::endl;
    std::cout << "frac: \t\t" << std::hex << dut->frac_out << " \t| " << std::bitset<23>(dut->frac_out) << std::endl;

    std::cout << "-----------------------------" << std::endl;

    dut->clk = 0;
    dut->in = 0b00111101100000000000000000000000; // 0.0625
    dut->eval();
    dut->clk = !dut->clk;
    dut->eval();
    std::cout << "Converting: \t" << std::hex << dut->in << " \t| " << std::bitset<32>(dut->in) << std::endl;
    std::cout << "int: \t\t" << std::hex << dut->int_out << " \t| " << std::bitset<2>(dut->int_out) << std::endl;
    std::cout << "frac: \t\t" << std::hex << dut->frac_out << " \t| " << std::bitset<23>(dut->frac_out) << std::endl;

    std::cout << "-----------------------------" << std::endl;

    dut->clk = 0;
    dut->in = 0b10111101100000000000000000000000; // -0.0625
    dut->eval();
    dut->clk = !dut->clk;
    dut->eval();
    std::cout << "Converting: \t" << std::hex << dut->in << " \t| " << std::bitset<32>(dut->in) << std::endl;
    std::cout << "int: \t\t" << std::hex << dut->int_out << " \t| " << std::bitset<2>(dut->int_out) << std::endl;
    std::cout << "frac: \t\t" << std::hex << dut->frac_out << " \t| " << std::bitset<23>(dut->frac_out) << std::endl;

    std::cout << "-----------------------------" << std::endl;

    dut->clk = 0;
    dut->in = 0b10110110101110110001100101111010; // -0.0000005576
    dut->eval();
    dut->clk = !dut->clk;
    dut->eval();
    std::cout << "Converting: \t" << std::hex << dut->in << " \t| " << std::bitset<32>(dut->in) << std::endl;
    std::cout << "int: \t\t" << std::hex << dut->int_out << " \t| " << std::bitset<2>(dut->int_out) << std::endl;
    std::cout << "frac: \t\t" << std::hex << dut->frac_out << " \t| " << std::bitset<23>(dut->frac_out) << std::endl;

    std::cout << "-----------------------------" << std::endl;

    dut->clk = 0;
    dut->in = 0b00000000000000000000000000000000; // 0
    dut->eval();
    dut->clk = !dut->clk;
    dut->eval();
    std::cout << "Converting: \t" << std::hex << dut->in << " \t| " << std::bitset<32>(dut->in) << std::endl;
    std::cout << "int: \t\t" << std::hex << dut->int_out << " \t| " << std::bitset<2>(dut->int_out) << std::endl;
    std::cout << "frac: \t\t" << std::hex << dut->frac_out << " \t| " << std::bitset<23>(dut->frac_out) << std::endl;

    std::cout << "-----------------------------" << std::endl;

    dut->clk = 0;
    dut->in = 0b00111111100000000000000000000000; // 0
    dut->eval();
    dut->clk = !dut->clk;
    dut->eval();
    std::cout << "Converting: \t" << std::hex << dut->in << " \t| " << std::bitset<32>(dut->in) << std::endl;
    std::cout << "int: \t\t" << std::hex << dut->int_out << " \t| " << std::bitset<2>(dut->int_out) << std::endl;
    std::cout << "frac: \t\t" << std::hex << dut->frac_out << " \t| " << std::bitset<23>(dut->frac_out) << std::endl;

    // housekeeping
    tfp->close();
    delete dut;
    delete tfp;
    exit(0);
}

