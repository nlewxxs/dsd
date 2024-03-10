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
    tracep->declBit(c+1,"clk", false,-1);
    tracep->declBus(c+2,"in", false,-1, 31,0);
    tracep->declBit(c+3,"sign_out", false,-1);
    tracep->declBit(c+4,"int_out", false,-1);
    tracep->declBus(c+5,"frac_out", false,-1, 22,0);
    tracep->pushNamePrefix("top ");
    tracep->declBit(c+1,"clk", false,-1);
    tracep->declBus(c+2,"in", false,-1, 31,0);
    tracep->declBit(c+3,"sign_out", false,-1);
    tracep->declBit(c+4,"int_out", false,-1);
    tracep->declBus(c+5,"frac_out", false,-1, 22,0);
    tracep->pushNamePrefix("fp_converter ");
    tracep->declBit(c+1,"clk", false,-1);
    tracep->declBus(c+2,"fp_i", false,-1, 31,0);
    tracep->declBit(c+3,"sign_o", false,-1);
    tracep->declBit(c+4,"integer_o", false,-1);
    tracep->declBus(c+5,"fractional_o", false,-1, 22,0);
    tracep->declBus(c+6,"exponent", false,-1, 7,0);
    tracep->declBus(c+7,"unbiased_exponent", false,-1, 7,0);
    tracep->declBus(c+8,"significand", false,-1, 22,0);
    tracep->pushNamePrefix("unnamedblk1 ");
    tracep->declBit(c+9,"integer_part", false,-1);
    tracep->declBus(c+10,"fractional_part", false,-1, 22,0);
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
    bufp->fullBit(oldp+1,(vlSelf->clk));
    bufp->fullIData(oldp+2,(vlSelf->in),32);
    bufp->fullBit(oldp+3,(vlSelf->sign_out));
    bufp->fullBit(oldp+4,(vlSelf->int_out));
    bufp->fullIData(oldp+5,(vlSelf->frac_out),23);
    bufp->fullCData(oldp+6,((0xffU & (vlSelf->in >> 0x17U))),8);
    bufp->fullCData(oldp+7,((0xffU & (~ (((vlSelf->in 
                                           >> 0x17U) 
                                          - (IData)(0x7fU)) 
                                         - (IData)(1U))))),8);
    bufp->fullIData(oldp+8,((0x7fffffU & vlSelf->in)),23);
    bufp->fullBit(oldp+9,(vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__integer_part));
    bufp->fullIData(oldp+10,(vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part),23);
}
