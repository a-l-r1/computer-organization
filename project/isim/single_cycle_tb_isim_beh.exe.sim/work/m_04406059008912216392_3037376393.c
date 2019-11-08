/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/a-l-r/co/src/src/datapath/im.v";
static int ng1[] = {0, 0};
static int ng2[] = {1024, 0};
static unsigned int ng3[] = {0U, 0U};
static int ng4[] = {1, 0};
static const char *ng5 = "code.hex";
static unsigned int ng6[] = {12288U, 0U};
static unsigned int ng7[] = {1U, 0U};



static void Initial_15_0(char *t0)
{
    char t5[8];
    char t14[8];
    char t15[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    unsigned int t26;
    int t27;
    char *t28;
    unsigned int t29;
    int t30;
    int t31;
    unsigned int t32;
    unsigned int t33;
    int t34;
    int t35;

LAB0:    xsi_set_current_line(15, ng0);

LAB2:    xsi_set_current_line(16, ng0);
    xsi_set_current_line(16, ng0);
    t1 = ((char*)((ng1)));
    t2 = (t0 + 2088);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 32);

LAB3:    t1 = (t0 + 2088);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = ((char*)((ng2)));
    memset(t5, 0, 8);
    xsi_vlog_signed_less(t5, 32, t3, 32, t4, 32);
    t6 = (t5 + 4);
    t7 = *((unsigned int *)t6);
    t8 = (~(t7));
    t9 = *((unsigned int *)t5);
    t10 = (t9 & t8);
    t11 = (t10 != 0);
    if (t11 > 0)
        goto LAB4;

LAB5:    xsi_set_current_line(20, ng0);
    t1 = (t0 + 1928);
    t2 = ((char*)((ng1)));
    xsi_vlogfile_readmemh(ng5, 0, t1, 1, *((unsigned int *)t2), 0, 0);

LAB1:    return;
LAB4:    xsi_set_current_line(16, ng0);

LAB6:    xsi_set_current_line(17, ng0);
    t12 = ((char*)((ng3)));
    t13 = (t0 + 1928);
    t16 = (t0 + 1928);
    t17 = (t16 + 72U);
    t18 = *((char **)t17);
    t19 = (t0 + 1928);
    t20 = (t19 + 64U);
    t21 = *((char **)t20);
    t22 = (t0 + 2088);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    xsi_vlog_generic_convert_array_indices(t14, t15, t18, t21, 2, 1, t24, 32, 1);
    t25 = (t14 + 4);
    t26 = *((unsigned int *)t25);
    t27 = (!(t26));
    t28 = (t15 + 4);
    t29 = *((unsigned int *)t28);
    t30 = (!(t29));
    t31 = (t27 && t30);
    if (t31 == 1)
        goto LAB7;

LAB8:    xsi_set_current_line(16, ng0);
    t1 = (t0 + 2088);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = ((char*)((ng4)));
    memset(t5, 0, 8);
    xsi_vlog_signed_add(t5, 32, t3, 32, t4, 32);
    t6 = (t0 + 2088);
    xsi_vlogvar_assign_value(t6, t5, 0, 0, 32);
    goto LAB3;

LAB7:    t32 = *((unsigned int *)t14);
    t33 = *((unsigned int *)t15);
    t34 = (t32 - t33);
    t35 = (t34 + 1);
    xsi_vlogvar_assign_value(t13, t12, 0, *((unsigned int *)t15), t35);
    goto LAB8;

}

static void Cont_27_1(char *t0)
{
    char t6[8];
    char *t1;
    char *t2;
    char *t4;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;

LAB0:    t1 = (t0 + 3248U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(27, ng0);
    t2 = (t0 + 1048U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng6)));
    memset(t6, 0, 8);
    xsi_vlog_unsigned_minus(t6, 32, t4, 32, t2, 32);
    t7 = (t0 + 3912);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t6, 8);
    xsi_driver_vfirst_trans(t7, 0, 31);
    t12 = (t0 + 3816);
    *((int *)t12) = 1;

LAB1:    return;
}

static void Cont_29_2(char *t0)
{
    char t3[8];
    char t4[8];
    char t6[8];
    char t22[8];
    char t38[8];
    char t42[8];
    char t50[8];
    char t98[8];
    char t99[8];
    char t102[8];
    char t118[8];
    char t134[8];
    char t138[8];
    char t146[8];
    char t192[8];
    char t199[8];
    char *t1;
    char *t2;
    char *t5;
    char *t7;
    char *t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    char *t35;
    char *t36;
    char *t39;
    char *t40;
    char *t41;
    char *t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    char *t49;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    char *t54;
    char *t55;
    char *t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    char *t64;
    char *t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    int t74;
    int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    char *t82;
    unsigned int t83;
    unsigned int t84;
    unsigned int t85;
    unsigned int t86;
    unsigned int t87;
    char *t88;
    char *t89;
    unsigned int t90;
    unsigned int t91;
    unsigned int t92;
    char *t93;
    unsigned int t94;
    unsigned int t95;
    unsigned int t96;
    unsigned int t97;
    char *t100;
    char *t101;
    char *t103;
    char *t104;
    unsigned int t105;
    unsigned int t106;
    unsigned int t107;
    unsigned int t108;
    unsigned int t109;
    unsigned int t110;
    unsigned int t111;
    unsigned int t112;
    unsigned int t113;
    unsigned int t114;
    unsigned int t115;
    unsigned int t116;
    char *t117;
    char *t119;
    unsigned int t120;
    unsigned int t121;
    unsigned int t122;
    unsigned int t123;
    unsigned int t124;
    char *t125;
    char *t126;
    unsigned int t127;
    unsigned int t128;
    unsigned int t129;
    char *t131;
    char *t132;
    char *t135;
    char *t136;
    char *t137;
    char *t139;
    unsigned int t140;
    unsigned int t141;
    unsigned int t142;
    unsigned int t143;
    unsigned int t144;
    char *t145;
    unsigned int t147;
    unsigned int t148;
    unsigned int t149;
    char *t150;
    char *t151;
    char *t152;
    unsigned int t153;
    unsigned int t154;
    unsigned int t155;
    unsigned int t156;
    unsigned int t157;
    unsigned int t158;
    unsigned int t159;
    char *t160;
    char *t161;
    unsigned int t162;
    unsigned int t163;
    unsigned int t164;
    unsigned int t165;
    unsigned int t166;
    unsigned int t167;
    unsigned int t168;
    unsigned int t169;
    int t170;
    int t171;
    unsigned int t172;
    unsigned int t173;
    unsigned int t174;
    unsigned int t175;
    unsigned int t176;
    unsigned int t177;
    char *t178;
    unsigned int t179;
    unsigned int t180;
    unsigned int t181;
    unsigned int t182;
    unsigned int t183;
    char *t184;
    char *t185;
    unsigned int t186;
    unsigned int t187;
    unsigned int t188;
    char *t189;
    char *t190;
    char *t191;
    char *t193;
    char *t194;
    char *t195;
    char *t196;
    char *t197;
    char *t198;
    char *t200;
    char *t201;
    char *t202;
    unsigned int t203;
    unsigned int t204;
    unsigned int t205;
    unsigned int t206;
    unsigned int t207;
    unsigned int t208;
    unsigned int t209;
    unsigned int t210;
    unsigned int t211;
    unsigned int t212;
    char *t213;
    char *t214;
    char *t215;
    char *t216;
    char *t217;
    char *t218;
    char *t219;

LAB0:    t1 = (t0 + 3496U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(29, ng0);
    t2 = (t0 + 1208U);
    t5 = *((char **)t2);
    t2 = ((char*)((ng7)));
    memset(t6, 0, 8);
    t7 = (t5 + 4);
    t8 = (t2 + 4);
    t9 = *((unsigned int *)t5);
    t10 = *((unsigned int *)t2);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t7);
    t17 = *((unsigned int *)t8);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB7;

LAB4:    if (t18 != 0)
        goto LAB6;

LAB5:    *((unsigned int *)t6) = 1;

LAB7:    memset(t22, 0, 8);
    t23 = (t6 + 4);
    t24 = *((unsigned int *)t23);
    t25 = (~(t24));
    t26 = *((unsigned int *)t6);
    t27 = (t26 & t25);
    t28 = (t27 & 1U);
    if (t28 != 0)
        goto LAB8;

LAB9:    if (*((unsigned int *)t23) != 0)
        goto LAB10;

LAB11:    t30 = (t22 + 4);
    t31 = *((unsigned int *)t22);
    t32 = *((unsigned int *)t30);
    t33 = (t31 || t32);
    if (t33 > 0)
        goto LAB12;

LAB13:    memcpy(t50, t22, 8);

LAB14:    memset(t4, 0, 8);
    t82 = (t50 + 4);
    t83 = *((unsigned int *)t82);
    t84 = (~(t83));
    t85 = *((unsigned int *)t50);
    t86 = (t85 & t84);
    t87 = (t86 & 1U);
    if (t87 != 0)
        goto LAB27;

LAB28:    if (*((unsigned int *)t82) != 0)
        goto LAB29;

LAB30:    t89 = (t4 + 4);
    t90 = *((unsigned int *)t4);
    t91 = *((unsigned int *)t89);
    t92 = (t90 || t91);
    if (t92 > 0)
        goto LAB31;

LAB32:    t94 = *((unsigned int *)t4);
    t95 = (~(t94));
    t96 = *((unsigned int *)t89);
    t97 = (t95 || t96);
    if (t97 > 0)
        goto LAB33;

LAB34:    if (*((unsigned int *)t89) > 0)
        goto LAB35;

LAB36:    if (*((unsigned int *)t4) > 0)
        goto LAB37;

LAB38:    memcpy(t3, t98, 8);

LAB39:    t214 = (t0 + 3976);
    t215 = (t214 + 56U);
    t216 = *((char **)t215);
    t217 = (t216 + 56U);
    t218 = *((char **)t217);
    memcpy(t218, t3, 8);
    xsi_driver_vfirst_trans(t214, 0, 31);
    t219 = (t0 + 3832);
    *((int *)t219) = 1;

LAB1:    return;
LAB6:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB7;

LAB8:    *((unsigned int *)t22) = 1;
    goto LAB11;

LAB10:    t29 = (t22 + 4);
    *((unsigned int *)t22) = 1;
    *((unsigned int *)t29) = 1;
    goto LAB11;

LAB12:    t35 = (t0 + 1048U);
    t36 = *((char **)t35);
    t35 = ((char*)((ng6)));
    memset(t38, 0, 8);
    t39 = (t36 + 4);
    if (*((unsigned int *)t39) != 0)
        goto LAB16;

LAB15:    t40 = (t35 + 4);
    if (*((unsigned int *)t40) != 0)
        goto LAB16;

LAB19:    if (*((unsigned int *)t36) < *((unsigned int *)t35))
        goto LAB17;

LAB18:    memset(t42, 0, 8);
    t43 = (t38 + 4);
    t44 = *((unsigned int *)t43);
    t45 = (~(t44));
    t46 = *((unsigned int *)t38);
    t47 = (t46 & t45);
    t48 = (t47 & 1U);
    if (t48 != 0)
        goto LAB20;

LAB21:    if (*((unsigned int *)t43) != 0)
        goto LAB22;

LAB23:    t51 = *((unsigned int *)t22);
    t52 = *((unsigned int *)t42);
    t53 = (t51 & t52);
    *((unsigned int *)t50) = t53;
    t54 = (t22 + 4);
    t55 = (t42 + 4);
    t56 = (t50 + 4);
    t57 = *((unsigned int *)t54);
    t58 = *((unsigned int *)t55);
    t59 = (t57 | t58);
    *((unsigned int *)t56) = t59;
    t60 = *((unsigned int *)t56);
    t61 = (t60 != 0);
    if (t61 == 1)
        goto LAB24;

LAB25:
LAB26:    goto LAB14;

LAB16:    t41 = (t38 + 4);
    *((unsigned int *)t38) = 1;
    *((unsigned int *)t41) = 1;
    goto LAB18;

LAB17:    *((unsigned int *)t38) = 1;
    goto LAB18;

LAB20:    *((unsigned int *)t42) = 1;
    goto LAB23;

LAB22:    t49 = (t42 + 4);
    *((unsigned int *)t42) = 1;
    *((unsigned int *)t49) = 1;
    goto LAB23;

LAB24:    t62 = *((unsigned int *)t50);
    t63 = *((unsigned int *)t56);
    *((unsigned int *)t50) = (t62 | t63);
    t64 = (t22 + 4);
    t65 = (t42 + 4);
    t66 = *((unsigned int *)t22);
    t67 = (~(t66));
    t68 = *((unsigned int *)t64);
    t69 = (~(t68));
    t70 = *((unsigned int *)t42);
    t71 = (~(t70));
    t72 = *((unsigned int *)t65);
    t73 = (~(t72));
    t74 = (t67 & t69);
    t75 = (t71 & t73);
    t76 = (~(t74));
    t77 = (~(t75));
    t78 = *((unsigned int *)t56);
    *((unsigned int *)t56) = (t78 & t76);
    t79 = *((unsigned int *)t56);
    *((unsigned int *)t56) = (t79 & t77);
    t80 = *((unsigned int *)t50);
    *((unsigned int *)t50) = (t80 & t76);
    t81 = *((unsigned int *)t50);
    *((unsigned int *)t50) = (t81 & t77);
    goto LAB26;

LAB27:    *((unsigned int *)t4) = 1;
    goto LAB30;

LAB29:    t88 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t88) = 1;
    goto LAB30;

LAB31:    t93 = ((char*)((ng3)));
    goto LAB32;

LAB33:    t100 = (t0 + 1208U);
    t101 = *((char **)t100);
    t100 = ((char*)((ng7)));
    memset(t102, 0, 8);
    t103 = (t101 + 4);
    t104 = (t100 + 4);
    t105 = *((unsigned int *)t101);
    t106 = *((unsigned int *)t100);
    t107 = (t105 ^ t106);
    t108 = *((unsigned int *)t103);
    t109 = *((unsigned int *)t104);
    t110 = (t108 ^ t109);
    t111 = (t107 | t110);
    t112 = *((unsigned int *)t103);
    t113 = *((unsigned int *)t104);
    t114 = (t112 | t113);
    t115 = (~(t114));
    t116 = (t111 & t115);
    if (t116 != 0)
        goto LAB43;

LAB40:    if (t114 != 0)
        goto LAB42;

LAB41:    *((unsigned int *)t102) = 1;

LAB43:    memset(t118, 0, 8);
    t119 = (t102 + 4);
    t120 = *((unsigned int *)t119);
    t121 = (~(t120));
    t122 = *((unsigned int *)t102);
    t123 = (t122 & t121);
    t124 = (t123 & 1U);
    if (t124 != 0)
        goto LAB44;

LAB45:    if (*((unsigned int *)t119) != 0)
        goto LAB46;

LAB47:    t126 = (t118 + 4);
    t127 = *((unsigned int *)t118);
    t128 = *((unsigned int *)t126);
    t129 = (t127 || t128);
    if (t129 > 0)
        goto LAB48;

LAB49:    memcpy(t146, t118, 8);

LAB50:    memset(t99, 0, 8);
    t178 = (t146 + 4);
    t179 = *((unsigned int *)t178);
    t180 = (~(t179));
    t181 = *((unsigned int *)t146);
    t182 = (t181 & t180);
    t183 = (t182 & 1U);
    if (t183 != 0)
        goto LAB63;

LAB64:    if (*((unsigned int *)t178) != 0)
        goto LAB65;

LAB66:    t185 = (t99 + 4);
    t186 = *((unsigned int *)t99);
    t187 = *((unsigned int *)t185);
    t188 = (t186 || t187);
    if (t188 > 0)
        goto LAB67;

LAB68:    t209 = *((unsigned int *)t99);
    t210 = (~(t209));
    t211 = *((unsigned int *)t185);
    t212 = (t210 || t211);
    if (t212 > 0)
        goto LAB69;

LAB70:    if (*((unsigned int *)t185) > 0)
        goto LAB71;

LAB72:    if (*((unsigned int *)t99) > 0)
        goto LAB73;

LAB74:    memcpy(t98, t213, 8);

LAB75:    goto LAB34;

LAB35:    xsi_vlog_unsigned_bit_combine(t3, 32, t93, 32, t98, 32);
    goto LAB39;

LAB37:    memcpy(t3, t93, 8);
    goto LAB39;

LAB42:    t117 = (t102 + 4);
    *((unsigned int *)t102) = 1;
    *((unsigned int *)t117) = 1;
    goto LAB43;

LAB44:    *((unsigned int *)t118) = 1;
    goto LAB47;

LAB46:    t125 = (t118 + 4);
    *((unsigned int *)t118) = 1;
    *((unsigned int *)t125) = 1;
    goto LAB47;

LAB48:    t131 = (t0 + 1048U);
    t132 = *((char **)t131);
    t131 = ((char*)((ng6)));
    memset(t134, 0, 8);
    t135 = (t132 + 4);
    if (*((unsigned int *)t135) != 0)
        goto LAB52;

LAB51:    t136 = (t131 + 4);
    if (*((unsigned int *)t136) != 0)
        goto LAB52;

LAB55:    if (*((unsigned int *)t132) < *((unsigned int *)t131))
        goto LAB54;

LAB53:    *((unsigned int *)t134) = 1;

LAB54:    memset(t138, 0, 8);
    t139 = (t134 + 4);
    t140 = *((unsigned int *)t139);
    t141 = (~(t140));
    t142 = *((unsigned int *)t134);
    t143 = (t142 & t141);
    t144 = (t143 & 1U);
    if (t144 != 0)
        goto LAB56;

LAB57:    if (*((unsigned int *)t139) != 0)
        goto LAB58;

LAB59:    t147 = *((unsigned int *)t118);
    t148 = *((unsigned int *)t138);
    t149 = (t147 & t148);
    *((unsigned int *)t146) = t149;
    t150 = (t118 + 4);
    t151 = (t138 + 4);
    t152 = (t146 + 4);
    t153 = *((unsigned int *)t150);
    t154 = *((unsigned int *)t151);
    t155 = (t153 | t154);
    *((unsigned int *)t152) = t155;
    t156 = *((unsigned int *)t152);
    t157 = (t156 != 0);
    if (t157 == 1)
        goto LAB60;

LAB61:
LAB62:    goto LAB50;

LAB52:    t137 = (t134 + 4);
    *((unsigned int *)t134) = 1;
    *((unsigned int *)t137) = 1;
    goto LAB54;

LAB56:    *((unsigned int *)t138) = 1;
    goto LAB59;

LAB58:    t145 = (t138 + 4);
    *((unsigned int *)t138) = 1;
    *((unsigned int *)t145) = 1;
    goto LAB59;

LAB60:    t158 = *((unsigned int *)t146);
    t159 = *((unsigned int *)t152);
    *((unsigned int *)t146) = (t158 | t159);
    t160 = (t118 + 4);
    t161 = (t138 + 4);
    t162 = *((unsigned int *)t118);
    t163 = (~(t162));
    t164 = *((unsigned int *)t160);
    t165 = (~(t164));
    t166 = *((unsigned int *)t138);
    t167 = (~(t166));
    t168 = *((unsigned int *)t161);
    t169 = (~(t168));
    t170 = (t163 & t165);
    t171 = (t167 & t169);
    t172 = (~(t170));
    t173 = (~(t171));
    t174 = *((unsigned int *)t152);
    *((unsigned int *)t152) = (t174 & t172);
    t175 = *((unsigned int *)t152);
    *((unsigned int *)t152) = (t175 & t173);
    t176 = *((unsigned int *)t146);
    *((unsigned int *)t146) = (t176 & t172);
    t177 = *((unsigned int *)t146);
    *((unsigned int *)t146) = (t177 & t173);
    goto LAB62;

LAB63:    *((unsigned int *)t99) = 1;
    goto LAB66;

LAB65:    t184 = (t99 + 4);
    *((unsigned int *)t99) = 1;
    *((unsigned int *)t184) = 1;
    goto LAB66;

LAB67:    t189 = (t0 + 1928);
    t190 = (t189 + 56U);
    t191 = *((char **)t190);
    t193 = (t0 + 1928);
    t194 = (t193 + 72U);
    t195 = *((char **)t194);
    t196 = (t0 + 1928);
    t197 = (t196 + 64U);
    t198 = *((char **)t197);
    t200 = (t0 + 1528U);
    t201 = *((char **)t200);
    memset(t199, 0, 8);
    t200 = (t199 + 4);
    t202 = (t201 + 4);
    t203 = *((unsigned int *)t201);
    t204 = (t203 >> 2);
    *((unsigned int *)t199) = t204;
    t205 = *((unsigned int *)t202);
    t206 = (t205 >> 2);
    *((unsigned int *)t200) = t206;
    t207 = *((unsigned int *)t199);
    *((unsigned int *)t199) = (t207 & 255U);
    t208 = *((unsigned int *)t200);
    *((unsigned int *)t200) = (t208 & 255U);
    xsi_vlog_generic_get_array_select_value(t192, 32, t191, t195, t198, 2, 1, t199, 8, 2);
    goto LAB68;

LAB69:    t213 = ((char*)((ng3)));
    goto LAB70;

LAB71:    xsi_vlog_unsigned_bit_combine(t98, 32, t192, 32, t213, 32);
    goto LAB75;

LAB73:    memcpy(t98, t192, 8);
    goto LAB75;

}


extern void work_m_04406059008912216392_3037376393_init()
{
	static char *pe[] = {(void *)Initial_15_0,(void *)Cont_27_1,(void *)Cont_29_2};
	xsi_register_didat("work_m_04406059008912216392_3037376393", "isim/single_cycle_tb_isim_beh.exe.sim/work/m_04406059008912216392_3037376393.didat");
	xsi_register_executes(pe);
}
