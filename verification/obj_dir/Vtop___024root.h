// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtop.h for the primary calling header

#ifndef VERILATED_VTOP___024ROOT_H_
#define VERILATED_VTOP___024ROOT_H_  // guard

#include "verilated.h"

class Vtop__Syms;

class Vtop___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_OUT8(sign_out,0,0);
    VL_OUT8(int_out,0,0);
    CData/*0:0*/ top__DOT__fp_converter__DOT__unnamedblk1__DOT__integer_part;
    CData/*0:0*/ __Vclklast__TOP__clk;
    VL_IN(in,31,0);
    VL_OUT(frac_out,22,0);
    IData/*22:0*/ top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part;

    // INTERNAL VARIABLES
    Vtop__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtop___024root(Vtop__Syms* symsp, const char* name);
    ~Vtop___024root();
    VL_UNCOPYABLE(Vtop___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
