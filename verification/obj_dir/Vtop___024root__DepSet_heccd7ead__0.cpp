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
    vlSelf->frac_out = (0x7ffffU & (vlSelf->top__DOT__fp_converter__DOT__unnamedblk1__DOT__fractional_part 
                                    >> 4U));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x3ffffU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (0x40000U & vlSelf->frac_out));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x5ffffU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (0x20000U & ((0x7ffe0000U & (vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                                          >> 1U)) | 
                          (0xfffe0000U & vlSelf->frac_out))));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x6ffffU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (0x10000U & ((0x7fff0000U & (vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                                          >> 1U)) | 
                          (0xffff0000U & vlSelf->frac_out))));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x77fffU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (0x8000U & ((0x7fff8000U & (vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                                         >> 1U)) | 
                         (0xffff8000U & vlSelf->frac_out))));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x7bfffU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (0x4000U & ((0x7fffc000U & (vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                                         >> 1U)) | 
                         (0xffffc000U & vlSelf->frac_out))));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x7dfffU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (0x2000U & ((0x7fffe000U & (vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                                         >> 1U)) | 
                         (0xffffe000U & vlSelf->frac_out))));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x7efffU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (0x1000U & ((0x7ffff000U & (vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                                         >> 1U)) | 
                         (0xfffff000U & vlSelf->frac_out))));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x7f7ffU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (0x800U & ((0x7ffff800U & (vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                                        >> 1U)) | (0xfffff800U 
                                                   & vlSelf->frac_out))));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x7fbffU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (0x400U & ((0x7ffffc00U & (vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                                        >> 1U)) | (0xfffffc00U 
                                                   & vlSelf->frac_out))));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x7fdffU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (0x200U & ((0x7ffffe00U & (vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                                        >> 1U)) | (0xfffffe00U 
                                                   & vlSelf->frac_out))));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x7feffU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (0x100U & ((0x7fffff00U & (vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                                        >> 1U)) | (0xffffff00U 
                                                   & vlSelf->frac_out))));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x7ff7fU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (0x80U & ((0x7fffff80U & (vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                                       >> 1U)) | (0xffffff80U 
                                                  & vlSelf->frac_out))));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x7ffbfU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (0x40U & ((0x7fffffc0U & (vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                                       >> 1U)) | (0xffffffc0U 
                                                  & vlSelf->frac_out))));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x7ffdfU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (0x20U & ((0x7fffffe0U & (vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                                       >> 1U)) | (0xffffffe0U 
                                                  & vlSelf->frac_out))));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x7ffefU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (0x10U & ((0x7ffffff0U & (vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                                       >> 1U)) | (0xfffffff0U 
                                                  & vlSelf->frac_out))));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x7fff7U & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (8U & ((0x7ffffff8U & (vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                                    >> 1U)) | (0xfffffff8U 
                                               & vlSelf->frac_out))));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x7fffbU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (4U & ((0x7ffffffcU & (vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                                    >> 1U)) | (0xfffffffcU 
                                               & vlSelf->frac_out))));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x7fffdU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (2U & ((0x7ffffffeU & (vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                                    >> 1U)) | (0xfffffffeU 
                                               & vlSelf->frac_out))));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
        = ((0x7fffeU & vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
           | (1U & ((vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array 
                     >> 1U) | vlSelf->frac_out)));
    vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__exponent 
        = (((((((((0x7ffffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
                  | (0x3ffffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)) 
                 | (0x1ffffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)) 
                | (0xffffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)) 
               | (0x7fffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)) 
              | (0x3fffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)) 
             | (0x1fffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)) 
            | (0xfffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array))
            ? ((0x7ffffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)
                ? 1U : ((0x3ffffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)
                         ? 2U : ((0x1ffffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)
                                  ? 3U : ((0xffffU 
                                           == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)
                                           ? 4U : (
                                                   (0x7fffU 
                                                    == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)
                                                    ? 5U
                                                    : 
                                                   ((0x3fffU 
                                                     == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)
                                                     ? 6U
                                                     : 
                                                    ((0x1fffU 
                                                      == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)
                                                      ? 7U
                                                      : 8U)))))))
            : (((((((((0x7ffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array) 
                      | (0x3ffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)) 
                     | (0x1ffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)) 
                    | (0xffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)) 
                   | (0x7fU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)) 
                  | (0x3fU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)) 
                 | (0x1fU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)) 
                | (0xfU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array))
                ? ((0x7ffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)
                    ? 9U : ((0x3ffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)
                             ? 0xaU : ((0x1ffU == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)
                                        ? 0xbU : ((0xffU 
                                                   == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)
                                                   ? 0xcU
                                                   : 
                                                  ((0x7fU 
                                                    == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)
                                                    ? 0xdU
                                                    : 
                                                   ((0x3fU 
                                                     == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)
                                                     ? 0xeU
                                                     : 
                                                    ((0x1fU 
                                                      == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)
                                                      ? 0xfU
                                                      : 0x10U)))))))
                : ((7U == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)
                    ? 0x11U : ((3U == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)
                                ? 0x12U : ((1U == vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__bitwise_or_array)
                                            ? 0x13U
                                            : 0U)))));
    vlSelf->top__DOT__fixed_converter__DOT__fp_reg 
        = ((IData)(vlSelf->int_out) ? ((IData)(vlSelf->sign_out)
                                        ? 0x3f800000U
                                        : 0xbf800000U)
            : (((IData)(vlSelf->sign_out) << 0x1fU) 
               | ((0x7f800000U & (((IData)(0x80U) + 
                                   (~ (IData)(vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__exponent))) 
                                  << 0x17U)) | (((0x12U 
                                                  >= (IData)(vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__exponent))
                                                  ? 
                                                 (0x7ffffU 
                                                  & (vlSelf->frac_out 
                                                     << (IData)(vlSelf->top__DOT__fixed_converter__DOT__unnamedblk1__DOT__exponent)))
                                                  : 0U) 
                                                << 4U))));
    vlSelf->fp_out = vlSelf->top__DOT__fixed_converter__DOT__fp_reg;
}

void Vtop___024root___eval(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval\n"); );
    // Body
    Vtop___024root___combo__TOP__0(vlSelf);
    vlSelf->__Vm_traceActivity[1U] = 1U;
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
