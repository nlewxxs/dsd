// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtop__Syms.h"


VL_ATTR_COLD void Vtop___024root__trace_init_sub__TOP__0(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+7,"clk", false,-1);
    tracep->declBus(c+8,"in", false,-1, 31,0);
    tracep->declBit(c+9,"sign_out", false,-1);
    tracep->declBit(c+10,"int_out", false,-1);
    tracep->declBus(c+11,"frac_out", false,-1, 18,0);
    tracep->declBus(c+12,"fp_out", false,-1, 31,0);
    tracep->pushNamePrefix("top ");
    tracep->declBit(c+7,"clk", false,-1);
    tracep->declBus(c+8,"in", false,-1, 31,0);
    tracep->declBit(c+9,"sign_out", false,-1);
    tracep->declBit(c+10,"int_out", false,-1);
    tracep->declBus(c+11,"frac_out", false,-1, 18,0);
    tracep->declBus(c+12,"fp_out", false,-1, 31,0);
    tracep->pushNamePrefix("fixed_converter ");
    tracep->declBit(c+7,"clk", false,-1);
    tracep->declBit(c+9,"sign_i", false,-1);
    tracep->declBit(c+10,"integer_i", false,-1);
    tracep->declBus(c+11,"fractional_i", false,-1, 18,0);
    tracep->declBus(c+12,"fp_o", false,-1, 31,0);
    tracep->declBit(c+1,"cursor", false,-1);
    tracep->declBus(c+2,"cursor_array", false,-1, 18,0);
    tracep->declBus(c+3,"exponent", false,-1, 7,0);
    tracep->declBus(c+4,"fp_reg", false,-1, 31,0);
    tracep->popNamePrefix(1);
    tracep->pushNamePrefix("fp_converter ");
    tracep->declBit(c+7,"clk", false,-1);
    tracep->declBus(c+8,"fp_i", false,-1, 31,0);
    tracep->declBit(c+9,"sign_o", false,-1);
    tracep->declBit(c+10,"integer_o", false,-1);
    tracep->declBus(c+11,"fractional_o", false,-1, 18,0);
    tracep->declBus(c+13,"exponent", false,-1, 7,0);
    tracep->declBus(c+14,"unbiased_exponent", false,-1, 7,0);
    tracep->declBus(c+15,"significand", false,-1, 22,0);
    tracep->pushNamePrefix("unnamedblk1 ");
    tracep->declBit(c+5,"integer_part", false,-1);
    tracep->declBus(c+6,"fractional_part", false,-1, 22,0);
    tracep->popNamePrefix(3);
}

VL_ATTR_COLD void Vtop___024root__trace_init_top(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_init_top\n"); );
    // Body
    Vtop___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vtop___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vtop___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vtop___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void Vtop___024root__trace_register(Vtop___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&Vtop___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&Vtop___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&Vtop___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vtop___024root__trace_full_sub_0(Vtop___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vtop___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_full_top_0\n"); );
    // Init
    Vtop___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vtop___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vtop___024root__trace_full_sub_0(Vtop___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_full_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullBit(oldp+1,(vlSelf->top__DOT__fixed_converter__DOT__cursor));
    bufp->fullIData(oldp+2,(vlSelf->top__DOT__fixed_converter__DOT__cursor_array),19);
    bufp->fullCData(oldp+3,(vlSelf->top__DOT__fixed_converter__DOT__exponent),8);
    bufp->fullIData(oldp+4,(vlSelf->top__DOT__fixed_converter__DOT__fp_reg),32);
    bufp->fullBit(oldp+5,(vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__integer_part));
    bufp->fullIData(oldp+6,(vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part),23);
    bufp->fullBit(oldp+7,(vlSelf->clk));
    bufp->fullIData(oldp+8,(vlSelf->in),32);
    bufp->fullBit(oldp+9,(vlSelf->sign_out));
    bufp->fullBit(oldp+10,(vlSelf->int_out));
    bufp->fullIData(oldp+11,(vlSelf->frac_out),19);
    bufp->fullIData(oldp+12,(vlSelf->fp_out),32);
    bufp->fullCData(oldp+13,((0xffU & (vlSelf->in >> 0x17U))),8);
    bufp->fullCData(oldp+14,((0xffU & (~ (((vlSelf->in 
                                            >> 0x17U) 
                                           - (IData)(0x7fU)) 
                                          - (IData)(1U))))),8);
    bufp->fullIData(oldp+15,((0x7fffffU & vlSelf->in)),23);
}
