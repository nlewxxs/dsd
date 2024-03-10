// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "verilated.h"

#include "Vtop___024root.h"

VL_INLINE_OPT void Vtop___024root___combo__TOP__0(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___combo__TOP__0\n"); );
    // Body
    vlSelf->sign_out = (vlSelf->in >> 0x1fU);
}

VL_INLINE_OPT void Vtop___024root___sequent__TOP__0(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___sequent__TOP__0\n"); );
    // Body
    vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__integer_part = 1U;
    vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part 
        = (0x7fffffU & vlSelf->in);
    if ((1U & (~ (((vlSelf->in >> 0x17U) - (IData)(1U)) 
                  - (IData)(1U))))) {
        vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part 
            = (((IData)(vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__integer_part) 
                << 0x16U) | (0x3fffffU & (vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part 
                                          >> 1U)));
        vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__integer_part = 0U;
    }
    if ((1U & (~ (0x7fU & ((((vlSelf->in >> 0x17U) 
                             - (IData)(0x7fU)) - (IData)(1U)) 
                           >> 1U))))) {
        vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part 
            = (((IData)(vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__integer_part) 
                << 0x15U) | (0x1fffffU & (vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part 
                                          >> 2U)));
        vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__integer_part = 0U;
    }
    if ((1U & (~ (0x3fU & ((((vlSelf->in >> 0x17U) 
                             - (IData)(0x7fU)) - (IData)(1U)) 
                           >> 2U))))) {
        vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part 
            = (((IData)(vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__integer_part) 
                << 0x13U) | (0x7ffffU & (vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part 
                                         >> 4U)));
        vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__integer_part = 0U;
    }
    if ((1U & (~ (0x1fU & ((((vlSelf->in >> 0x17U) 
                             - (IData)(0x7fU)) - (IData)(1U)) 
                           >> 3U))))) {
        vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part 
            = (((IData)(vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__integer_part) 
                << 0xfU) | (0x7fffU & (vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part 
                                       >> 8U)));
        vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__integer_part = 0U;
    }
    if ((1U & (~ (0xfU & ((((vlSelf->in >> 0x17U) - (IData)(0x7fU)) 
                           - (IData)(1U)) >> 4U))))) {
        vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part 
            = (((IData)(vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__integer_part) 
                << 7U) | (0x7fU & (vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part 
                                   >> 0x10U)));
        vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__integer_part = 0U;
    }
    vlSelf->int_out = vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__integer_part;
    vlSelf->frac_out = vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part;
}

void Vtop___024root___eval(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval\n"); );
    // Body
    Vtop___024root___combo__TOP__0(vlSelf);
    if (((IData)(vlSelf->clk) & (~ (IData)(vlSelf->__Vclklast__TOP__clk)))) {
        Vtop___024root___sequent__TOP__0(vlSelf);
    }
    // Final
    vlSelf->__Vclklast__TOP__clk = vlSelf->clk;
}

#ifdef VL_DEBUG
void Vtop___024root___eval_debug_assertions(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
}
#endif  // VL_DEBUG
