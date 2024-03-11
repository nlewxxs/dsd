// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtop__Syms.h"


void Vtop___024root__trace_chg_sub_0(Vtop___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vtop___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_chg_top_0\n"); );
    // Init
    Vtop___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vtop___024root__trace_chg_sub_0((&vlSymsp->TOP), bufp);
}

void Vtop___024root__trace_chg_sub_0(Vtop___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_chg_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[1U])) {
        bufp->chgIData(oldp+0,(vlSelf->top__DOT__fixed_converter__DOT__fp_reg),32);
        bufp->chgCData(oldp+1,(vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__exponent),8);
        bufp->chgIData(oldp+2,(vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array),19);
        bufp->chgBit(oldp+3,(vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__integer_part));
        bufp->chgIData(oldp+4,(vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part),23);
    }
    bufp->chgBit(oldp+5,(vlSelf->clk));
    bufp->chgIData(oldp+6,(vlSelf->in),32);
    bufp->chgBit(oldp+7,(vlSelf->sign_out));
    bufp->chgBit(oldp+8,(vlSelf->int_out));
    bufp->chgIData(oldp+9,(vlSelf->frac_out),19);
    bufp->chgIData(oldp+10,(vlSelf->fp_out),32);
    bufp->chgCData(oldp+11,((0xffU & (vlSelf->in >> 0x17U))),8);
    bufp->chgCData(oldp+12,((0xffU & (~ (((vlSelf->in 
                                           >> 0x17U) 
                                          - (IData)(0x7fU)) 
                                         - (IData)(1U))))),8);
    bufp->chgIData(oldp+13,((0x7fffffU & vlSelf->in)),23);
}

void Vtop___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_cleanup\n"); );
    // Init
    Vtop___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
}
