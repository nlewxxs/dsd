// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "verilated.h"

#include "Vtop___024root.h"

VL_INLINE_OPT void Vtop___024root___sequent__TOP__0(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___sequent__TOP__0\n"); );
    // Init
    IData/*18:0*/ __Vdly__frac_out;
    // Body
    __Vdly__frac_out = vlSelf->frac_out;
    if (VL_LIKELY(vlSelf->int_out)) {
        vlSelf->top__DOT__fixed_converter__DOT__fp_reg 
            = ((IData)(vlSelf->sign_out) ? 1U : 0U);
    } else {
        vlSelf->top__DOT__fixed_converter__DOT__cursor = 0U;
        vlSelf->top__DOT__fixed_converter__DOT__cursor_array 
            = vlSelf->frac_out;
        VL_WRITEF("\nCursor array is: %b\n",19,vlSelf->top__DOT__fixed_converter__DOT__cursor_array);
        vlSelf->top__DOT__fixed_converter__DOT__exponent 
            = (((((((((0x40000U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array) 
                      | (0x20000U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)) 
                     | (0x10000U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)) 
                    | (0x8000U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)) 
                   | (0x4000U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)) 
                  | (0x2000U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)) 
                 | (0x1000U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)) 
                | (0x800U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array))
                ? ((0x40000U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)
                    ? 0x7eU : ((0x20000U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)
                                ? 0x7dU : ((0x10000U 
                                            == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)
                                            ? 0x7cU
                                            : ((0x8000U 
                                                == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)
                                                ? 0x7bU
                                                : (
                                                   (0x4000U 
                                                    == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)
                                                    ? 0x7aU
                                                    : 
                                                   ((0x2000U 
                                                     == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)
                                                     ? 0x79U
                                                     : 
                                                    ((0x1000U 
                                                      == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)
                                                      ? 0x78U
                                                      : 0x77U)))))))
                : (((((((((0x400U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array) 
                          | (0x200U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)) 
                         | (0x100U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)) 
                        | (0x80U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)) 
                       | (0x40U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)) 
                      | (0x20U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)) 
                     | (0x10U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)) 
                    | (8U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array))
                    ? ((0x400U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)
                        ? 0x76U : ((0x200U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)
                                    ? 0x75U : ((0x100U 
                                                == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)
                                                ? 0x74U
                                                : (
                                                   (0x80U 
                                                    == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)
                                                    ? 0x73U
                                                    : 
                                                   ((0x40U 
                                                     == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)
                                                     ? 0x72U
                                                     : 
                                                    ((0x20U 
                                                      == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)
                                                      ? 0x71U
                                                      : 
                                                     ((0x10U 
                                                       == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)
                                                       ? 0x70U
                                                       : 0x6fU)))))))
                    : ((4U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)
                        ? 0x6eU : ((2U == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)
                                    ? 0x6dU : ((1U 
                                                == vlSelf->top__DOT__fixed_converter__DOT__cursor_array)
                                                ? 0x6cU
                                                : 0U)))));
        VL_WRITEF("Exponent is %b\n\n",8,vlSelf->top__DOT__fixed_converter__DOT__exponent);
        vlSelf->top__DOT__fixed_converter__DOT__fp_reg 
            = (((IData)(vlSelf->sign_out) << 0x1fU) 
               | (((IData)(vlSelf->top__DOT__fixed_converter__DOT__exponent) 
                   << 0x17U) | (((0x12U >= (IData)(vlSelf->top__DOT__fixed_converter__DOT__exponent))
                                  ? (0x7ffffU & (vlSelf->frac_out 
                                                 << (IData)(vlSelf->top__DOT__fixed_converter__DOT__exponent)))
                                  : 0U) << 4U)));
    }
    vlSelf->fp_out = vlSelf->top__DOT__fixed_converter__DOT__fp_reg;
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
    __Vdly__frac_out = (0x7ffffU & (vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part 
                                    >> 4U));
    VL_WRITEF("full fractional part: %b\n\ntruncated fractional part: %b\n\n",
              23,vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part,
              19,vlSelf->frac_out);
    vlSelf->frac_out = __Vdly__frac_out;
}

VL_INLINE_OPT void Vtop___024root___combo__TOP__0(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___combo__TOP__0\n"); );
    // Body
    vlSelf->sign_out = (vlSelf->in >> 0x1fU);
}

void Vtop___024root___eval(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval\n"); );
    // Body
    if (((IData)(vlSelf->clk) & (~ (IData)(vlSelf->__Vclklast__TOP__clk)))) {
        Vtop___024root___sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
    }
    Vtop___024root___combo__TOP__0(vlSelf);
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
