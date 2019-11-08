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
static const char *ng0 = "/home/a-l-r/co/src/src/datapath/npc.v";
static unsigned int ng1[] = {0U, 0U};
static int ng2[] = {14, 0};
static int ng3[] = {4, 0};
static unsigned int ng4[] = {1U, 0U};
static unsigned int ng5[] = {2U, 0U};
static unsigned int ng6[] = {3U, 0U};



static void Cont_18_0(char *t0)
{
    char t3[8];
    char t6[8];
    char t9[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t7;
    char *t8;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;

LAB0:    t1 = (t0 + 3320U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(18, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 1528U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
    t7 = (t0 + 1528U);
    t8 = *((char **)t7);
    memset(t9, 0, 8);
    t7 = (t9 + 4);
    t10 = (t8 + 4);
    t11 = *((unsigned int *)t8);
    t12 = (t11 >> 15);
    t13 = (t12 & 1);
    *((unsigned int *)t9) = t13;
    t14 = *((unsigned int *)t10);
    t15 = (t14 >> 15);
    t16 = (t15 & 1);
    *((unsigned int *)t7) = t16;
    xsi_vlog_mul_concat(t6, 14, 1, t4, 1U, t9, 1);
    xsi_vlogtype_concat(t3, 32, 32, 3U, t6, 14, t5, 16, t2, 2);
    t17 = (t0 + 4512);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t3, 8);
    xsi_driver_vfirst_trans(t17, 0, 31);
    t22 = (t0 + 4384);
    *((int *)t22) = 1;

LAB1:    return;
}

static void Cont_21_1(char *t0)
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

LAB0:    t1 = (t0 + 3568U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(21, ng0);
    t2 = (t0 + 1048U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng3)));
    memset(t6, 0, 8);
    xsi_vlog_unsigned_add(t6, 32, t4, 32, t2, 32);
    t7 = (t0 + 4576);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t6, 8);
    xsi_driver_vfirst_trans(t7, 0, 31);
    t12 = (t0 + 4400);
    *((int *)t12) = 1;

LAB1:    return;
}

static void Cont_23_2(char *t0)
{
    char t3[8];
    char t4[8];
    char t6[8];
    char t22[8];
    char t36[8];
    char t52[8];
    char t60[8];
    char t108[8];
    char t113[8];
    char t114[8];
    char t116[8];
    char t132[8];
    char t146[8];
    char t162[8];
    char t170[8];
    char t218[8];
    char t223[8];
    char t224[8];
    char t226[8];
    char t253[8];
    char t257[8];
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
    char *t34;
    char *t35;
    char *t37;
    char *t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    char *t51;
    char *t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    char *t59;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    char *t64;
    char *t65;
    char *t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    char *t74;
    char *t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    int t84;
    int t85;
    unsigned int t86;
    unsigned int t87;
    unsigned int t88;
    unsigned int t89;
    unsigned int t90;
    unsigned int t91;
    char *t92;
    unsigned int t93;
    unsigned int t94;
    unsigned int t95;
    unsigned int t96;
    unsigned int t97;
    char *t98;
    char *t99;
    unsigned int t100;
    unsigned int t101;
    unsigned int t102;
    char *t104;
    char *t105;
    char *t107;
    unsigned int t109;
    unsigned int t110;
    unsigned int t111;
    unsigned int t112;
    char *t115;
    char *t117;
    char *t118;
    unsigned int t119;
    unsigned int t120;
    unsigned int t121;
    unsigned int t122;
    unsigned int t123;
    unsigned int t124;
    unsigned int t125;
    unsigned int t126;
    unsigned int t127;
    unsigned int t128;
    unsigned int t129;
    unsigned int t130;
    char *t131;
    char *t133;
    unsigned int t134;
    unsigned int t135;
    unsigned int t136;
    unsigned int t137;
    unsigned int t138;
    char *t139;
    char *t140;
    unsigned int t141;
    unsigned int t142;
    unsigned int t143;
    char *t144;
    char *t145;
    char *t147;
    char *t148;
    unsigned int t149;
    unsigned int t150;
    unsigned int t151;
    unsigned int t152;
    unsigned int t153;
    unsigned int t154;
    unsigned int t155;
    unsigned int t156;
    unsigned int t157;
    unsigned int t158;
    unsigned int t159;
    unsigned int t160;
    char *t161;
    char *t163;
    unsigned int t164;
    unsigned int t165;
    unsigned int t166;
    unsigned int t167;
    unsigned int t168;
    char *t169;
    unsigned int t171;
    unsigned int t172;
    unsigned int t173;
    char *t174;
    char *t175;
    char *t176;
    unsigned int t177;
    unsigned int t178;
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
    unsigned int t189;
    unsigned int t190;
    unsigned int t191;
    unsigned int t192;
    unsigned int t193;
    int t194;
    int t195;
    unsigned int t196;
    unsigned int t197;
    unsigned int t198;
    unsigned int t199;
    unsigned int t200;
    unsigned int t201;
    char *t202;
    unsigned int t203;
    unsigned int t204;
    unsigned int t205;
    unsigned int t206;
    unsigned int t207;
    char *t208;
    char *t209;
    unsigned int t210;
    unsigned int t211;
    unsigned int t212;
    char *t214;
    char *t215;
    char *t217;
    unsigned int t219;
    unsigned int t220;
    unsigned int t221;
    unsigned int t222;
    char *t225;
    char *t227;
    char *t228;
    unsigned int t229;
    unsigned int t230;
    unsigned int t231;
    unsigned int t232;
    unsigned int t233;
    unsigned int t234;
    unsigned int t235;
    unsigned int t236;
    unsigned int t237;
    unsigned int t238;
    unsigned int t239;
    unsigned int t240;
    char *t241;
    char *t242;
    unsigned int t243;
    unsigned int t244;
    unsigned int t245;
    unsigned int t246;
    unsigned int t247;
    char *t248;
    char *t249;
    unsigned int t250;
    unsigned int t251;
    unsigned int t252;
    char *t254;
    char *t255;
    char *t256;
    char *t258;
    char *t259;
    unsigned int t260;
    unsigned int t261;
    unsigned int t262;
    unsigned int t263;
    unsigned int t264;
    unsigned int t265;
    unsigned int t266;
    unsigned int t267;
    unsigned int t268;
    unsigned int t269;
    char *t271;
    char *t272;
    char *t273;
    char *t274;
    char *t275;
    char *t276;
    char *t277;

LAB0:    t1 = (t0 + 3816U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(23, ng0);
    t2 = (t0 + 1208U);
    t5 = *((char **)t2);
    t2 = ((char*)((ng4)));
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

LAB13:    memcpy(t60, t22, 8);

LAB14:    memset(t4, 0, 8);
    t92 = (t60 + 4);
    t93 = *((unsigned int *)t92);
    t94 = (~(t93));
    t95 = *((unsigned int *)t60);
    t96 = (t95 & t94);
    t97 = (t96 & 1U);
    if (t97 != 0)
        goto LAB26;

LAB27:    if (*((unsigned int *)t92) != 0)
        goto LAB28;

LAB29:    t99 = (t4 + 4);
    t100 = *((unsigned int *)t4);
    t101 = *((unsigned int *)t99);
    t102 = (t100 || t101);
    if (t102 > 0)
        goto LAB30;

LAB31:    t109 = *((unsigned int *)t4);
    t110 = (~(t109));
    t111 = *((unsigned int *)t99);
    t112 = (t110 || t111);
    if (t112 > 0)
        goto LAB32;

LAB33:    if (*((unsigned int *)t99) > 0)
        goto LAB34;

LAB35:    if (*((unsigned int *)t4) > 0)
        goto LAB36;

LAB37:    memcpy(t3, t113, 8);

LAB38:    t271 = (t0 + 4640);
    t273 = (t271 + 56U);
    t274 = *((char **)t273);
    t275 = (t274 + 56U);
    t276 = *((char **)t275);
    memcpy(t276, t3, 8);
    xsi_driver_vfirst_trans(t271, 0, 31);
    t277 = (t0 + 4416);
    *((int *)t277) = 1;

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

LAB12:    t34 = (t0 + 1368U);
    t35 = *((char **)t34);
    t34 = ((char*)((ng1)));
    memset(t36, 0, 8);
    t37 = (t35 + 4);
    t38 = (t34 + 4);
    t39 = *((unsigned int *)t35);
    t40 = *((unsigned int *)t34);
    t41 = (t39 ^ t40);
    t42 = *((unsigned int *)t37);
    t43 = *((unsigned int *)t38);
    t44 = (t42 ^ t43);
    t45 = (t41 | t44);
    t46 = *((unsigned int *)t37);
    t47 = *((unsigned int *)t38);
    t48 = (t46 | t47);
    t49 = (~(t48));
    t50 = (t45 & t49);
    if (t50 != 0)
        goto LAB18;

LAB15:    if (t48 != 0)
        goto LAB17;

LAB16:    *((unsigned int *)t36) = 1;

LAB18:    memset(t52, 0, 8);
    t53 = (t36 + 4);
    t54 = *((unsigned int *)t53);
    t55 = (~(t54));
    t56 = *((unsigned int *)t36);
    t57 = (t56 & t55);
    t58 = (t57 & 1U);
    if (t58 != 0)
        goto LAB19;

LAB20:    if (*((unsigned int *)t53) != 0)
        goto LAB21;

LAB22:    t61 = *((unsigned int *)t22);
    t62 = *((unsigned int *)t52);
    t63 = (t61 & t62);
    *((unsigned int *)t60) = t63;
    t64 = (t22 + 4);
    t65 = (t52 + 4);
    t66 = (t60 + 4);
    t67 = *((unsigned int *)t64);
    t68 = *((unsigned int *)t65);
    t69 = (t67 | t68);
    *((unsigned int *)t66) = t69;
    t70 = *((unsigned int *)t66);
    t71 = (t70 != 0);
    if (t71 == 1)
        goto LAB23;

LAB24:
LAB25:    goto LAB14;

LAB17:    t51 = (t36 + 4);
    *((unsigned int *)t36) = 1;
    *((unsigned int *)t51) = 1;
    goto LAB18;

LAB19:    *((unsigned int *)t52) = 1;
    goto LAB22;

LAB21:    t59 = (t52 + 4);
    *((unsigned int *)t52) = 1;
    *((unsigned int *)t59) = 1;
    goto LAB22;

LAB23:    t72 = *((unsigned int *)t60);
    t73 = *((unsigned int *)t66);
    *((unsigned int *)t60) = (t72 | t73);
    t74 = (t22 + 4);
    t75 = (t52 + 4);
    t76 = *((unsigned int *)t22);
    t77 = (~(t76));
    t78 = *((unsigned int *)t74);
    t79 = (~(t78));
    t80 = *((unsigned int *)t52);
    t81 = (~(t80));
    t82 = *((unsigned int *)t75);
    t83 = (~(t82));
    t84 = (t77 & t79);
    t85 = (t81 & t83);
    t86 = (~(t84));
    t87 = (~(t85));
    t88 = *((unsigned int *)t66);
    *((unsigned int *)t66) = (t88 & t86);
    t89 = *((unsigned int *)t66);
    *((unsigned int *)t66) = (t89 & t87);
    t90 = *((unsigned int *)t60);
    *((unsigned int *)t60) = (t90 & t86);
    t91 = *((unsigned int *)t60);
    *((unsigned int *)t60) = (t91 & t87);
    goto LAB25;

LAB26:    *((unsigned int *)t4) = 1;
    goto LAB29;

LAB28:    t98 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t98) = 1;
    goto LAB29;

LAB30:    t104 = (t0 + 2168U);
    t105 = *((char **)t104);
    t104 = (t0 + 2008U);
    t107 = *((char **)t104);
    memset(t108, 0, 8);
    xsi_vlog_unsigned_add(t108, 32, t105, 32, t107, 32);
    goto LAB31;

LAB32:    t104 = (t0 + 1208U);
    t115 = *((char **)t104);
    t104 = ((char*)((ng5)));
    memset(t116, 0, 8);
    t117 = (t115 + 4);
    t118 = (t104 + 4);
    t119 = *((unsigned int *)t115);
    t120 = *((unsigned int *)t104);
    t121 = (t119 ^ t120);
    t122 = *((unsigned int *)t117);
    t123 = *((unsigned int *)t118);
    t124 = (t122 ^ t123);
    t125 = (t121 | t124);
    t126 = *((unsigned int *)t117);
    t127 = *((unsigned int *)t118);
    t128 = (t126 | t127);
    t129 = (~(t128));
    t130 = (t125 & t129);
    if (t130 != 0)
        goto LAB42;

LAB39:    if (t128 != 0)
        goto LAB41;

LAB40:    *((unsigned int *)t116) = 1;

LAB42:    memset(t132, 0, 8);
    t133 = (t116 + 4);
    t134 = *((unsigned int *)t133);
    t135 = (~(t134));
    t136 = *((unsigned int *)t116);
    t137 = (t136 & t135);
    t138 = (t137 & 1U);
    if (t138 != 0)
        goto LAB43;

LAB44:    if (*((unsigned int *)t133) != 0)
        goto LAB45;

LAB46:    t140 = (t132 + 4);
    t141 = *((unsigned int *)t132);
    t142 = *((unsigned int *)t140);
    t143 = (t141 || t142);
    if (t143 > 0)
        goto LAB47;

LAB48:    memcpy(t170, t132, 8);

LAB49:    memset(t114, 0, 8);
    t202 = (t170 + 4);
    t203 = *((unsigned int *)t202);
    t204 = (~(t203));
    t205 = *((unsigned int *)t170);
    t206 = (t205 & t204);
    t207 = (t206 & 1U);
    if (t207 != 0)
        goto LAB61;

LAB62:    if (*((unsigned int *)t202) != 0)
        goto LAB63;

LAB64:    t209 = (t114 + 4);
    t210 = *((unsigned int *)t114);
    t211 = *((unsigned int *)t209);
    t212 = (t210 || t211);
    if (t212 > 0)
        goto LAB65;

LAB66:    t219 = *((unsigned int *)t114);
    t220 = (~(t219));
    t221 = *((unsigned int *)t209);
    t222 = (t220 || t221);
    if (t222 > 0)
        goto LAB67;

LAB68:    if (*((unsigned int *)t209) > 0)
        goto LAB69;

LAB70:    if (*((unsigned int *)t114) > 0)
        goto LAB71;

LAB72:    memcpy(t113, t223, 8);

LAB73:    goto LAB33;

LAB34:    xsi_vlog_unsigned_bit_combine(t3, 32, t108, 32, t113, 32);
    goto LAB38;

LAB36:    memcpy(t3, t108, 8);
    goto LAB38;

LAB41:    t131 = (t116 + 4);
    *((unsigned int *)t116) = 1;
    *((unsigned int *)t131) = 1;
    goto LAB42;

LAB43:    *((unsigned int *)t132) = 1;
    goto LAB46;

LAB45:    t139 = (t132 + 4);
    *((unsigned int *)t132) = 1;
    *((unsigned int *)t139) = 1;
    goto LAB46;

LAB47:    t144 = (t0 + 1368U);
    t145 = *((char **)t144);
    t144 = ((char*)((ng1)));
    memset(t146, 0, 8);
    t147 = (t145 + 4);
    t148 = (t144 + 4);
    t149 = *((unsigned int *)t145);
    t150 = *((unsigned int *)t144);
    t151 = (t149 ^ t150);
    t152 = *((unsigned int *)t147);
    t153 = *((unsigned int *)t148);
    t154 = (t152 ^ t153);
    t155 = (t151 | t154);
    t156 = *((unsigned int *)t147);
    t157 = *((unsigned int *)t148);
    t158 = (t156 | t157);
    t159 = (~(t158));
    t160 = (t155 & t159);
    if (t160 != 0)
        goto LAB51;

LAB50:    if (t158 != 0)
        goto LAB52;

LAB53:    memset(t162, 0, 8);
    t163 = (t146 + 4);
    t164 = *((unsigned int *)t163);
    t165 = (~(t164));
    t166 = *((unsigned int *)t146);
    t167 = (t166 & t165);
    t168 = (t167 & 1U);
    if (t168 != 0)
        goto LAB54;

LAB55:    if (*((unsigned int *)t163) != 0)
        goto LAB56;

LAB57:    t171 = *((unsigned int *)t132);
    t172 = *((unsigned int *)t162);
    t173 = (t171 & t172);
    *((unsigned int *)t170) = t173;
    t174 = (t132 + 4);
    t175 = (t162 + 4);
    t176 = (t170 + 4);
    t177 = *((unsigned int *)t174);
    t178 = *((unsigned int *)t175);
    t179 = (t177 | t178);
    *((unsigned int *)t176) = t179;
    t180 = *((unsigned int *)t176);
    t181 = (t180 != 0);
    if (t181 == 1)
        goto LAB58;

LAB59:
LAB60:    goto LAB49;

LAB51:    *((unsigned int *)t146) = 1;
    goto LAB53;

LAB52:    t161 = (t146 + 4);
    *((unsigned int *)t146) = 1;
    *((unsigned int *)t161) = 1;
    goto LAB53;

LAB54:    *((unsigned int *)t162) = 1;
    goto LAB57;

LAB56:    t169 = (t162 + 4);
    *((unsigned int *)t162) = 1;
    *((unsigned int *)t169) = 1;
    goto LAB57;

LAB58:    t182 = *((unsigned int *)t170);
    t183 = *((unsigned int *)t176);
    *((unsigned int *)t170) = (t182 | t183);
    t184 = (t132 + 4);
    t185 = (t162 + 4);
    t186 = *((unsigned int *)t132);
    t187 = (~(t186));
    t188 = *((unsigned int *)t184);
    t189 = (~(t188));
    t190 = *((unsigned int *)t162);
    t191 = (~(t190));
    t192 = *((unsigned int *)t185);
    t193 = (~(t192));
    t194 = (t187 & t189);
    t195 = (t191 & t193);
    t196 = (~(t194));
    t197 = (~(t195));
    t198 = *((unsigned int *)t176);
    *((unsigned int *)t176) = (t198 & t196);
    t199 = *((unsigned int *)t176);
    *((unsigned int *)t176) = (t199 & t197);
    t200 = *((unsigned int *)t170);
    *((unsigned int *)t170) = (t200 & t196);
    t201 = *((unsigned int *)t170);
    *((unsigned int *)t170) = (t201 & t197);
    goto LAB60;

LAB61:    *((unsigned int *)t114) = 1;
    goto LAB64;

LAB63:    t208 = (t114 + 4);
    *((unsigned int *)t114) = 1;
    *((unsigned int *)t208) = 1;
    goto LAB64;

LAB65:    t214 = (t0 + 2168U);
    t215 = *((char **)t214);
    t214 = (t0 + 2008U);
    t217 = *((char **)t214);
    memset(t218, 0, 8);
    xsi_vlog_unsigned_add(t218, 32, t215, 32, t217, 32);
    goto LAB66;

LAB67:    t214 = (t0 + 1208U);
    t225 = *((char **)t214);
    t214 = ((char*)((ng6)));
    memset(t226, 0, 8);
    t227 = (t225 + 4);
    t228 = (t214 + 4);
    t229 = *((unsigned int *)t225);
    t230 = *((unsigned int *)t214);
    t231 = (t229 ^ t230);
    t232 = *((unsigned int *)t227);
    t233 = *((unsigned int *)t228);
    t234 = (t232 ^ t233);
    t235 = (t231 | t234);
    t236 = *((unsigned int *)t227);
    t237 = *((unsigned int *)t228);
    t238 = (t236 | t237);
    t239 = (~(t238));
    t240 = (t235 & t239);
    if (t240 != 0)
        goto LAB77;

LAB74:    if (t238 != 0)
        goto LAB76;

LAB75:    *((unsigned int *)t226) = 1;

LAB77:    memset(t224, 0, 8);
    t242 = (t226 + 4);
    t243 = *((unsigned int *)t242);
    t244 = (~(t243));
    t245 = *((unsigned int *)t226);
    t246 = (t245 & t244);
    t247 = (t246 & 1U);
    if (t247 != 0)
        goto LAB78;

LAB79:    if (*((unsigned int *)t242) != 0)
        goto LAB80;

LAB81:    t249 = (t224 + 4);
    t250 = *((unsigned int *)t224);
    t251 = *((unsigned int *)t249);
    t252 = (t250 || t251);
    if (t252 > 0)
        goto LAB82;

LAB83:    t266 = *((unsigned int *)t224);
    t267 = (~(t266));
    t268 = *((unsigned int *)t249);
    t269 = (t267 || t268);
    if (t269 > 0)
        goto LAB84;

LAB85:    if (*((unsigned int *)t249) > 0)
        goto LAB86;

LAB87:    if (*((unsigned int *)t224) > 0)
        goto LAB88;

LAB89:    memcpy(t223, t272, 8);

LAB90:    goto LAB68;

LAB69:    xsi_vlog_unsigned_bit_combine(t113, 32, t218, 32, t223, 32);
    goto LAB73;

LAB71:    memcpy(t113, t218, 8);
    goto LAB73;

LAB76:    t241 = (t226 + 4);
    *((unsigned int *)t226) = 1;
    *((unsigned int *)t241) = 1;
    goto LAB77;

LAB78:    *((unsigned int *)t224) = 1;
    goto LAB81;

LAB80:    t248 = (t224 + 4);
    *((unsigned int *)t224) = 1;
    *((unsigned int *)t248) = 1;
    goto LAB81;

LAB82:    t254 = ((char*)((ng1)));
    t255 = (t0 + 1688U);
    t256 = *((char **)t255);
    t255 = (t0 + 1048U);
    t258 = *((char **)t255);
    memset(t257, 0, 8);
    t255 = (t257 + 4);
    t259 = (t258 + 4);
    t260 = *((unsigned int *)t258);
    t261 = (t260 >> 28);
    *((unsigned int *)t257) = t261;
    t262 = *((unsigned int *)t259);
    t263 = (t262 >> 28);
    *((unsigned int *)t255) = t263;
    t264 = *((unsigned int *)t257);
    *((unsigned int *)t257) = (t264 & 15U);
    t265 = *((unsigned int *)t255);
    *((unsigned int *)t255) = (t265 & 15U);
    xsi_vlogtype_concat(t253, 32, 32, 3U, t257, 4, t256, 26, t254, 2);
    goto LAB83;

LAB84:    t271 = (t0 + 2168U);
    t272 = *((char **)t271);
    goto LAB85;

LAB86:    xsi_vlog_unsigned_bit_combine(t223, 32, t253, 32, t272, 32);
    goto LAB90;

LAB88:    memcpy(t223, t253, 8);
    goto LAB90;

}

static void Always_30_3(char *t0)
{
    char *t1;
    char *t2;
    char *t3;

LAB0:    t1 = (t0 + 4064U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(30, ng0);
    t2 = (t0 + 4432);
    *((int *)t2) = 1;
    t3 = (t0 + 4096);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(30, ng0);

LAB5:    goto LAB2;

}


extern void work_m_02065202864218950549_3146453351_init()
{
	static char *pe[] = {(void *)Cont_18_0,(void *)Cont_21_1,(void *)Cont_23_2,(void *)Always_30_3};
	xsi_register_didat("work_m_02065202864218950549_3146453351", "isim/single_cycle_tb_isim_beh.exe.sim/work/m_02065202864218950549_3146453351.didat");
	xsi_register_executes(pe);
}
