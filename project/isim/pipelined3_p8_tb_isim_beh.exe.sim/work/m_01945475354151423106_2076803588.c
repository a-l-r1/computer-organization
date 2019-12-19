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
static const char *ng0 = "/home/a-l-r/co/src/src/devices/nixie.v";
static unsigned int ng1[] = {25000U, 0U};
static unsigned int ng2[] = {8U, 0U};
static int ng3[] = {0, 0};
static unsigned int ng4[] = {1U, 0U};
static unsigned int ng5[] = {0U, 0U};
static int ng6[] = {1, 0};
static unsigned int ng7[] = {4U, 0U};
static unsigned int ng8[] = {2U, 0U};



static void Initial_29_0(char *t0)
{
    char *t1;
    char *t2;

LAB0:    xsi_set_current_line(29, ng0);

LAB2:    xsi_set_current_line(30, ng0);
    t1 = ((char*)((ng1)));
    t2 = (t0 + 3848);
    xsi_vlogvar_wait_assign_value(t2, t1, 0, 0, 32, 0LL);
    xsi_set_current_line(31, ng0);
    t1 = ((char*)((ng2)));
    t2 = (t0 + 4008);
    xsi_vlogvar_wait_assign_value(t2, t1, 0, 0, 4, 0LL);
    xsi_set_current_line(32, ng0);
    t1 = ((char*)((ng3)));
    t2 = (t0 + 4488);
    xsi_vlogvar_wait_assign_value(t2, t1, 0, 0, 16, 0LL);
    xsi_set_current_line(33, ng0);
    t1 = ((char*)((ng3)));
    t2 = (t0 + 4328);
    xsi_vlogvar_wait_assign_value(t2, t1, 0, 0, 16, 0LL);
    xsi_set_current_line(34, ng0);
    t1 = ((char*)((ng3)));
    t2 = (t0 + 4168);
    xsi_vlogvar_wait_assign_value(t2, t1, 0, 0, 8, 0LL);

LAB1:    return;
}

static void Always_52_1(char *t0)
{
    char t6[8];
    char t33[8];
    char t38[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
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
    char *t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    char *t28;
    char *t29;
    int t30;
    char *t31;
    char *t35;
    char *t37;
    char *t39;

LAB0:    t1 = (t0 + 5648U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(52, ng0);
    t2 = (t0 + 7952);
    *((int *)t2) = 1;
    t3 = (t0 + 5680);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(52, ng0);

LAB5:    xsi_set_current_line(53, ng0);
    t4 = (t0 + 1208U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng4)));
    memset(t6, 0, 8);
    t7 = (t5 + 4);
    t8 = (t4 + 4);
    t9 = *((unsigned int *)t5);
    t10 = *((unsigned int *)t4);
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
        goto LAB9;

LAB6:    if (t18 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t6) = 1;

LAB9:    t22 = (t6 + 4);
    t23 = *((unsigned int *)t22);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB10;

LAB11:    xsi_set_current_line(59, ng0);

LAB14:    xsi_set_current_line(61, ng0);
    t2 = (t0 + 1528U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng4)));
    memset(t6, 0, 8);
    t4 = (t3 + 4);
    t5 = (t2 + 4);
    t9 = *((unsigned int *)t3);
    t10 = *((unsigned int *)t2);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t4);
    t13 = *((unsigned int *)t5);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t4);
    t17 = *((unsigned int *)t5);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB18;

LAB15:    if (t18 != 0)
        goto LAB17;

LAB16:    *((unsigned int *)t6) = 1;

LAB18:    t8 = (t6 + 4);
    t23 = *((unsigned int *)t8);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB19;

LAB20:    xsi_set_current_line(69, ng0);

LAB32:    xsi_set_current_line(70, ng0);
    t2 = (t0 + 3848);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng3)));
    memset(t33, 0, 8);
    t7 = (t4 + 4);
    if (*((unsigned int *)t7) != 0)
        goto LAB34;

LAB33:    t8 = (t5 + 4);
    if (*((unsigned int *)t8) != 0)
        goto LAB34;

LAB37:    if (*((unsigned int *)t4) > *((unsigned int *)t5))
        goto LAB35;

LAB36:    t28 = (t33 + 4);
    t9 = *((unsigned int *)t28);
    t10 = (~(t9));
    t11 = *((unsigned int *)t33);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB38;

LAB39:    xsi_set_current_line(72, ng0);

LAB42:    xsi_set_current_line(73, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3848);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 32, 0LL);
    xsi_set_current_line(74, ng0);
    t2 = (t0 + 4008);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);

LAB43:    t5 = ((char*)((ng2)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 4, t5, 4);
    if (t30 == 1)
        goto LAB44;

LAB45:    t2 = ((char*)((ng7)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 4, t2, 4);
    if (t30 == 1)
        goto LAB46;

LAB47:    t2 = ((char*)((ng8)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 4, t2, 4);
    if (t30 == 1)
        goto LAB48;

LAB49:    t2 = ((char*)((ng4)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 4, t2, 4);
    if (t30 == 1)
        goto LAB50;

LAB51:
LAB53:
LAB52:    xsi_set_current_line(79, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4008);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 4, 0LL);

LAB54:
LAB40:
LAB21:
LAB12:    goto LAB2;

LAB8:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(53, ng0);

LAB13:    xsi_set_current_line(54, ng0);
    t28 = ((char*)((ng3)));
    t29 = (t0 + 3848);
    xsi_vlogvar_wait_assign_value(t29, t28, 0, 0, 32, 0LL);
    xsi_set_current_line(55, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4008);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 4, 0LL);
    xsi_set_current_line(56, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 4488);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 16, 0LL);
    xsi_set_current_line(57, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 4328);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 16, 0LL);
    xsi_set_current_line(58, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 4168);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 8, 0LL);
    goto LAB12;

LAB17:    t7 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t7) = 1;
    goto LAB18;

LAB19:    xsi_set_current_line(61, ng0);

LAB22:    xsi_set_current_line(62, ng0);
    t21 = (t0 + 1368U);
    t22 = *((char **)t21);

LAB23:    t21 = ((char*)((ng5)));
    t30 = xsi_vlog_unsigned_case_compare(t22, 32, t21, 32);
    if (t30 == 1)
        goto LAB24;

LAB25:    t2 = ((char*)((ng4)));
    t30 = xsi_vlog_unsigned_case_compare(t22, 32, t2, 32);
    if (t30 == 1)
        goto LAB26;

LAB27:
LAB29:
LAB28:    xsi_set_current_line(65, ng0);

LAB31:
LAB30:    goto LAB21;

LAB24:    xsi_set_current_line(63, ng0);
    t28 = (t0 + 1688U);
    t29 = *((char **)t28);
    t28 = (t0 + 4328);
    xsi_vlogvar_wait_assign_value(t28, t29, 0, 0, 16, 0LL);
    t31 = (t0 + 4488);
    xsi_vlogvar_wait_assign_value(t31, t29, 16, 0, 16, 0LL);
    goto LAB30;

LAB26:    xsi_set_current_line(64, ng0);
    t3 = (t0 + 1688U);
    t4 = *((char **)t3);
    memset(t6, 0, 8);
    t3 = (t6 + 4);
    t5 = (t4 + 4);
    t9 = *((unsigned int *)t4);
    t10 = (t9 >> 0);
    *((unsigned int *)t6) = t10;
    t11 = *((unsigned int *)t5);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t13 & 255U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 255U);
    t7 = (t0 + 4168);
    xsi_vlogvar_wait_assign_value(t7, t6, 0, 0, 8, 0LL);
    goto LAB30;

LAB34:    t21 = (t33 + 4);
    *((unsigned int *)t33) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB36;

LAB35:    *((unsigned int *)t33) = 1;
    goto LAB36;

LAB38:    xsi_set_current_line(70, ng0);

LAB41:    xsi_set_current_line(71, ng0);
    t29 = (t0 + 3848);
    t31 = (t29 + 56U);
    t35 = *((char **)t31);
    t37 = ((char*)((ng6)));
    memset(t38, 0, 8);
    xsi_vlog_unsigned_minus(t38, 32, t35, 32, t37, 32);
    t39 = (t0 + 3848);
    xsi_vlogvar_wait_assign_value(t39, t38, 0, 0, 32, 0LL);
    goto LAB40;

LAB44:    xsi_set_current_line(75, ng0);
    t7 = ((char*)((ng7)));
    t8 = (t0 + 4008);
    xsi_vlogvar_wait_assign_value(t8, t7, 0, 0, 4, 0LL);
    goto LAB54;

LAB46:    xsi_set_current_line(76, ng0);
    t3 = ((char*)((ng8)));
    t5 = (t0 + 4008);
    xsi_vlogvar_wait_assign_value(t5, t3, 0, 0, 4, 0LL);
    goto LAB54;

LAB48:    xsi_set_current_line(77, ng0);
    t3 = ((char*)((ng4)));
    t5 = (t0 + 4008);
    xsi_vlogvar_wait_assign_value(t5, t3, 0, 0, 4, 0LL);
    goto LAB54;

LAB50:    xsi_set_current_line(78, ng0);
    t3 = ((char*)((ng2)));
    t5 = (t0 + 4008);
    xsi_vlogvar_wait_assign_value(t5, t3, 0, 0, 4, 0LL);
    goto LAB54;

}

static void Cont_86_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;

LAB0:    t1 = (t0 + 5896U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(86, ng0);
    t2 = (t0 + 4008);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 8128);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 15U;
    t11 = t10;
    t12 = (t4 + 4);
    t13 = *((unsigned int *)t4);
    t10 = (t10 & t13);
    t14 = *((unsigned int *)t12);
    t11 = (t11 & t14);
    t15 = (t9 + 4);
    t16 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t16 | t10);
    t17 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t17 | t11);
    xsi_driver_vfirst_trans(t5, 0, 3);
    t18 = (t0 + 7968);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Cont_87_3(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;

LAB0:    t1 = (t0 + 6144U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(87, ng0);
    t2 = (t0 + 4008);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 8192);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 15U;
    t11 = t10;
    t12 = (t4 + 4);
    t13 = *((unsigned int *)t4);
    t10 = (t10 & t13);
    t14 = *((unsigned int *)t12);
    t11 = (t11 & t14);
    t15 = (t9 + 4);
    t16 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t16 | t10);
    t17 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t17 | t11);
    xsi_driver_vfirst_trans(t5, 0, 3);
    t18 = (t0 + 7984);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Cont_88_4(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;

LAB0:    t1 = (t0 + 6392U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(88, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 8256);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memset(t7, 0, 8);
    t8 = 1U;
    t9 = t8;
    t10 = (t2 + 4);
    t11 = *((unsigned int *)t2);
    t8 = (t8 & t11);
    t12 = *((unsigned int *)t10);
    t9 = (t9 & t12);
    t13 = (t7 + 4);
    t14 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t14 | t8);
    t15 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t15 | t9);
    xsi_driver_vfirst_trans(t3, 0, 0);

LAB1:    return;
}

static void Cont_90_5(char *t0)
{
    char t3[8];
    char t4[8];
    char t8[8];
    char t35[8];
    char t51[8];
    char t52[8];
    char t57[8];
    char t84[8];
    char t100[8];
    char t101[8];
    char t106[8];
    char t133[8];
    char t149[8];
    char *t1;
    char *t2;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
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
    unsigned int t21;
    unsigned int t22;
    char *t23;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t30;
    char *t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
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
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t58;
    char *t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    char *t72;
    char *t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    char *t79;
    char *t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    char *t85;
    char *t86;
    char *t87;
    char *t88;
    char *t89;
    unsigned int t90;
    unsigned int t91;
    unsigned int t92;
    unsigned int t93;
    unsigned int t94;
    unsigned int t95;
    unsigned int t96;
    unsigned int t97;
    unsigned int t98;
    unsigned int t99;
    char *t102;
    char *t103;
    char *t104;
    char *t105;
    char *t107;
    char *t108;
    unsigned int t109;
    unsigned int t110;
    unsigned int t111;
    unsigned int t112;
    unsigned int t113;
    unsigned int t114;
    unsigned int t115;
    unsigned int t116;
    unsigned int t117;
    unsigned int t118;
    unsigned int t119;
    unsigned int t120;
    char *t121;
    char *t122;
    unsigned int t123;
    unsigned int t124;
    unsigned int t125;
    unsigned int t126;
    unsigned int t127;
    char *t128;
    char *t129;
    unsigned int t130;
    unsigned int t131;
    unsigned int t132;
    char *t134;
    char *t135;
    char *t136;
    char *t137;
    char *t138;
    unsigned int t139;
    unsigned int t140;
    unsigned int t141;
    unsigned int t142;
    unsigned int t143;
    unsigned int t144;
    unsigned int t145;
    unsigned int t146;
    unsigned int t147;
    unsigned int t148;
    char *t150;
    char *t151;
    char *t152;
    char *t153;
    char *t154;
    unsigned int t155;
    unsigned int t156;
    unsigned int t157;
    unsigned int t158;
    unsigned int t159;
    unsigned int t160;
    char *t161;
    char *t162;
    char *t163;
    char *t164;
    char *t165;
    unsigned int t166;
    unsigned int t167;
    char *t168;
    unsigned int t169;
    unsigned int t170;
    char *t171;
    unsigned int t172;
    unsigned int t173;
    char *t174;

LAB0:    t1 = (t0 + 6640U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(90, ng0);
    t2 = (t0 + 4008);
    t5 = (t2 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng2)));
    memset(t8, 0, 8);
    t9 = (t6 + 4);
    t10 = (t7 + 4);
    t11 = *((unsigned int *)t6);
    t12 = *((unsigned int *)t7);
    t13 = (t11 ^ t12);
    t14 = *((unsigned int *)t9);
    t15 = *((unsigned int *)t10);
    t16 = (t14 ^ t15);
    t17 = (t13 | t16);
    t18 = *((unsigned int *)t9);
    t19 = *((unsigned int *)t10);
    t20 = (t18 | t19);
    t21 = (~(t20));
    t22 = (t17 & t21);
    if (t22 != 0)
        goto LAB7;

LAB4:    if (t20 != 0)
        goto LAB6;

LAB5:    *((unsigned int *)t8) = 1;

LAB7:    memset(t4, 0, 8);
    t24 = (t8 + 4);
    t25 = *((unsigned int *)t24);
    t26 = (~(t25));
    t27 = *((unsigned int *)t8);
    t28 = (t27 & t26);
    t29 = (t28 & 1U);
    if (t29 != 0)
        goto LAB8;

LAB9:    if (*((unsigned int *)t24) != 0)
        goto LAB10;

LAB11:    t31 = (t4 + 4);
    t32 = *((unsigned int *)t4);
    t33 = *((unsigned int *)t31);
    t34 = (t32 || t33);
    if (t34 > 0)
        goto LAB12;

LAB13:    t47 = *((unsigned int *)t4);
    t48 = (~(t47));
    t49 = *((unsigned int *)t31);
    t50 = (t48 || t49);
    if (t50 > 0)
        goto LAB14;

LAB15:    if (*((unsigned int *)t31) > 0)
        goto LAB16;

LAB17:    if (*((unsigned int *)t4) > 0)
        goto LAB18;

LAB19:    memcpy(t3, t51, 8);

LAB20:    t161 = (t0 + 8320);
    t162 = (t161 + 56U);
    t163 = *((char **)t162);
    t164 = (t163 + 56U);
    t165 = *((char **)t164);
    memset(t165, 0, 8);
    t166 = 15U;
    t167 = t166;
    t168 = (t3 + 4);
    t169 = *((unsigned int *)t3);
    t166 = (t166 & t169);
    t170 = *((unsigned int *)t168);
    t167 = (t167 & t170);
    t171 = (t165 + 4);
    t172 = *((unsigned int *)t165);
    *((unsigned int *)t165) = (t172 | t166);
    t173 = *((unsigned int *)t171);
    *((unsigned int *)t171) = (t173 | t167);
    xsi_driver_vfirst_trans(t161, 0, 3);
    t174 = (t0 + 8000);
    *((int *)t174) = 1;

LAB1:    return;
LAB6:    t23 = (t8 + 4);
    *((unsigned int *)t8) = 1;
    *((unsigned int *)t23) = 1;
    goto LAB7;

LAB8:    *((unsigned int *)t4) = 1;
    goto LAB11;

LAB10:    t30 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t30) = 1;
    goto LAB11;

LAB12:    t36 = (t0 + 4488);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    memset(t35, 0, 8);
    t39 = (t35 + 4);
    t40 = (t38 + 4);
    t41 = *((unsigned int *)t38);
    t42 = (t41 >> 12);
    *((unsigned int *)t35) = t42;
    t43 = *((unsigned int *)t40);
    t44 = (t43 >> 12);
    *((unsigned int *)t39) = t44;
    t45 = *((unsigned int *)t35);
    *((unsigned int *)t35) = (t45 & 15U);
    t46 = *((unsigned int *)t39);
    *((unsigned int *)t39) = (t46 & 15U);
    goto LAB13;

LAB14:    t53 = (t0 + 4008);
    t54 = (t53 + 56U);
    t55 = *((char **)t54);
    t56 = ((char*)((ng7)));
    memset(t57, 0, 8);
    t58 = (t55 + 4);
    t59 = (t56 + 4);
    t60 = *((unsigned int *)t55);
    t61 = *((unsigned int *)t56);
    t62 = (t60 ^ t61);
    t63 = *((unsigned int *)t58);
    t64 = *((unsigned int *)t59);
    t65 = (t63 ^ t64);
    t66 = (t62 | t65);
    t67 = *((unsigned int *)t58);
    t68 = *((unsigned int *)t59);
    t69 = (t67 | t68);
    t70 = (~(t69));
    t71 = (t66 & t70);
    if (t71 != 0)
        goto LAB24;

LAB21:    if (t69 != 0)
        goto LAB23;

LAB22:    *((unsigned int *)t57) = 1;

LAB24:    memset(t52, 0, 8);
    t73 = (t57 + 4);
    t74 = *((unsigned int *)t73);
    t75 = (~(t74));
    t76 = *((unsigned int *)t57);
    t77 = (t76 & t75);
    t78 = (t77 & 1U);
    if (t78 != 0)
        goto LAB25;

LAB26:    if (*((unsigned int *)t73) != 0)
        goto LAB27;

LAB28:    t80 = (t52 + 4);
    t81 = *((unsigned int *)t52);
    t82 = *((unsigned int *)t80);
    t83 = (t81 || t82);
    if (t83 > 0)
        goto LAB29;

LAB30:    t96 = *((unsigned int *)t52);
    t97 = (~(t96));
    t98 = *((unsigned int *)t80);
    t99 = (t97 || t98);
    if (t99 > 0)
        goto LAB31;

LAB32:    if (*((unsigned int *)t80) > 0)
        goto LAB33;

LAB34:    if (*((unsigned int *)t52) > 0)
        goto LAB35;

LAB36:    memcpy(t51, t100, 8);

LAB37:    goto LAB15;

LAB16:    xsi_vlog_unsigned_bit_combine(t3, 4, t35, 4, t51, 4);
    goto LAB20;

LAB18:    memcpy(t3, t35, 8);
    goto LAB20;

LAB23:    t72 = (t57 + 4);
    *((unsigned int *)t57) = 1;
    *((unsigned int *)t72) = 1;
    goto LAB24;

LAB25:    *((unsigned int *)t52) = 1;
    goto LAB28;

LAB27:    t79 = (t52 + 4);
    *((unsigned int *)t52) = 1;
    *((unsigned int *)t79) = 1;
    goto LAB28;

LAB29:    t85 = (t0 + 4488);
    t86 = (t85 + 56U);
    t87 = *((char **)t86);
    memset(t84, 0, 8);
    t88 = (t84 + 4);
    t89 = (t87 + 4);
    t90 = *((unsigned int *)t87);
    t91 = (t90 >> 8);
    *((unsigned int *)t84) = t91;
    t92 = *((unsigned int *)t89);
    t93 = (t92 >> 8);
    *((unsigned int *)t88) = t93;
    t94 = *((unsigned int *)t84);
    *((unsigned int *)t84) = (t94 & 15U);
    t95 = *((unsigned int *)t88);
    *((unsigned int *)t88) = (t95 & 15U);
    goto LAB30;

LAB31:    t102 = (t0 + 4008);
    t103 = (t102 + 56U);
    t104 = *((char **)t103);
    t105 = ((char*)((ng8)));
    memset(t106, 0, 8);
    t107 = (t104 + 4);
    t108 = (t105 + 4);
    t109 = *((unsigned int *)t104);
    t110 = *((unsigned int *)t105);
    t111 = (t109 ^ t110);
    t112 = *((unsigned int *)t107);
    t113 = *((unsigned int *)t108);
    t114 = (t112 ^ t113);
    t115 = (t111 | t114);
    t116 = *((unsigned int *)t107);
    t117 = *((unsigned int *)t108);
    t118 = (t116 | t117);
    t119 = (~(t118));
    t120 = (t115 & t119);
    if (t120 != 0)
        goto LAB41;

LAB38:    if (t118 != 0)
        goto LAB40;

LAB39:    *((unsigned int *)t106) = 1;

LAB41:    memset(t101, 0, 8);
    t122 = (t106 + 4);
    t123 = *((unsigned int *)t122);
    t124 = (~(t123));
    t125 = *((unsigned int *)t106);
    t126 = (t125 & t124);
    t127 = (t126 & 1U);
    if (t127 != 0)
        goto LAB42;

LAB43:    if (*((unsigned int *)t122) != 0)
        goto LAB44;

LAB45:    t129 = (t101 + 4);
    t130 = *((unsigned int *)t101);
    t131 = *((unsigned int *)t129);
    t132 = (t130 || t131);
    if (t132 > 0)
        goto LAB46;

LAB47:    t145 = *((unsigned int *)t101);
    t146 = (~(t145));
    t147 = *((unsigned int *)t129);
    t148 = (t146 || t147);
    if (t148 > 0)
        goto LAB48;

LAB49:    if (*((unsigned int *)t129) > 0)
        goto LAB50;

LAB51:    if (*((unsigned int *)t101) > 0)
        goto LAB52;

LAB53:    memcpy(t100, t149, 8);

LAB54:    goto LAB32;

LAB33:    xsi_vlog_unsigned_bit_combine(t51, 4, t84, 4, t100, 4);
    goto LAB37;

LAB35:    memcpy(t51, t84, 8);
    goto LAB37;

LAB40:    t121 = (t106 + 4);
    *((unsigned int *)t106) = 1;
    *((unsigned int *)t121) = 1;
    goto LAB41;

LAB42:    *((unsigned int *)t101) = 1;
    goto LAB45;

LAB44:    t128 = (t101 + 4);
    *((unsigned int *)t101) = 1;
    *((unsigned int *)t128) = 1;
    goto LAB45;

LAB46:    t134 = (t0 + 4488);
    t135 = (t134 + 56U);
    t136 = *((char **)t135);
    memset(t133, 0, 8);
    t137 = (t133 + 4);
    t138 = (t136 + 4);
    t139 = *((unsigned int *)t136);
    t140 = (t139 >> 4);
    *((unsigned int *)t133) = t140;
    t141 = *((unsigned int *)t138);
    t142 = (t141 >> 4);
    *((unsigned int *)t137) = t142;
    t143 = *((unsigned int *)t133);
    *((unsigned int *)t133) = (t143 & 15U);
    t144 = *((unsigned int *)t137);
    *((unsigned int *)t137) = (t144 & 15U);
    goto LAB47;

LAB48:    t150 = (t0 + 4488);
    t151 = (t150 + 56U);
    t152 = *((char **)t151);
    memset(t149, 0, 8);
    t153 = (t149 + 4);
    t154 = (t152 + 4);
    t155 = *((unsigned int *)t152);
    t156 = (t155 >> 0);
    *((unsigned int *)t149) = t156;
    t157 = *((unsigned int *)t154);
    t158 = (t157 >> 0);
    *((unsigned int *)t153) = t158;
    t159 = *((unsigned int *)t149);
    *((unsigned int *)t149) = (t159 & 15U);
    t160 = *((unsigned int *)t153);
    *((unsigned int *)t153) = (t160 & 15U);
    goto LAB49;

LAB50:    xsi_vlog_unsigned_bit_combine(t100, 4, t133, 4, t149, 4);
    goto LAB54;

LAB52:    memcpy(t100, t133, 8);
    goto LAB54;

}

static void Cont_96_6(char *t0)
{
    char t3[8];
    char t4[8];
    char t8[8];
    char t35[8];
    char t51[8];
    char t52[8];
    char t57[8];
    char t84[8];
    char t100[8];
    char t101[8];
    char t106[8];
    char t133[8];
    char t149[8];
    char *t1;
    char *t2;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
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
    unsigned int t21;
    unsigned int t22;
    char *t23;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t30;
    char *t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
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
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t58;
    char *t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    char *t72;
    char *t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    char *t79;
    char *t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    char *t85;
    char *t86;
    char *t87;
    char *t88;
    char *t89;
    unsigned int t90;
    unsigned int t91;
    unsigned int t92;
    unsigned int t93;
    unsigned int t94;
    unsigned int t95;
    unsigned int t96;
    unsigned int t97;
    unsigned int t98;
    unsigned int t99;
    char *t102;
    char *t103;
    char *t104;
    char *t105;
    char *t107;
    char *t108;
    unsigned int t109;
    unsigned int t110;
    unsigned int t111;
    unsigned int t112;
    unsigned int t113;
    unsigned int t114;
    unsigned int t115;
    unsigned int t116;
    unsigned int t117;
    unsigned int t118;
    unsigned int t119;
    unsigned int t120;
    char *t121;
    char *t122;
    unsigned int t123;
    unsigned int t124;
    unsigned int t125;
    unsigned int t126;
    unsigned int t127;
    char *t128;
    char *t129;
    unsigned int t130;
    unsigned int t131;
    unsigned int t132;
    char *t134;
    char *t135;
    char *t136;
    char *t137;
    char *t138;
    unsigned int t139;
    unsigned int t140;
    unsigned int t141;
    unsigned int t142;
    unsigned int t143;
    unsigned int t144;
    unsigned int t145;
    unsigned int t146;
    unsigned int t147;
    unsigned int t148;
    char *t150;
    char *t151;
    char *t152;
    char *t153;
    char *t154;
    unsigned int t155;
    unsigned int t156;
    unsigned int t157;
    unsigned int t158;
    unsigned int t159;
    unsigned int t160;
    char *t161;
    char *t162;
    char *t163;
    char *t164;
    char *t165;
    unsigned int t166;
    unsigned int t167;
    char *t168;
    unsigned int t169;
    unsigned int t170;
    char *t171;
    unsigned int t172;
    unsigned int t173;
    char *t174;

LAB0:    t1 = (t0 + 6888U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(96, ng0);
    t2 = (t0 + 4008);
    t5 = (t2 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng2)));
    memset(t8, 0, 8);
    t9 = (t6 + 4);
    t10 = (t7 + 4);
    t11 = *((unsigned int *)t6);
    t12 = *((unsigned int *)t7);
    t13 = (t11 ^ t12);
    t14 = *((unsigned int *)t9);
    t15 = *((unsigned int *)t10);
    t16 = (t14 ^ t15);
    t17 = (t13 | t16);
    t18 = *((unsigned int *)t9);
    t19 = *((unsigned int *)t10);
    t20 = (t18 | t19);
    t21 = (~(t20));
    t22 = (t17 & t21);
    if (t22 != 0)
        goto LAB7;

LAB4:    if (t20 != 0)
        goto LAB6;

LAB5:    *((unsigned int *)t8) = 1;

LAB7:    memset(t4, 0, 8);
    t24 = (t8 + 4);
    t25 = *((unsigned int *)t24);
    t26 = (~(t25));
    t27 = *((unsigned int *)t8);
    t28 = (t27 & t26);
    t29 = (t28 & 1U);
    if (t29 != 0)
        goto LAB8;

LAB9:    if (*((unsigned int *)t24) != 0)
        goto LAB10;

LAB11:    t31 = (t4 + 4);
    t32 = *((unsigned int *)t4);
    t33 = *((unsigned int *)t31);
    t34 = (t32 || t33);
    if (t34 > 0)
        goto LAB12;

LAB13:    t47 = *((unsigned int *)t4);
    t48 = (~(t47));
    t49 = *((unsigned int *)t31);
    t50 = (t48 || t49);
    if (t50 > 0)
        goto LAB14;

LAB15:    if (*((unsigned int *)t31) > 0)
        goto LAB16;

LAB17:    if (*((unsigned int *)t4) > 0)
        goto LAB18;

LAB19:    memcpy(t3, t51, 8);

LAB20:    t161 = (t0 + 8384);
    t162 = (t161 + 56U);
    t163 = *((char **)t162);
    t164 = (t163 + 56U);
    t165 = *((char **)t164);
    memset(t165, 0, 8);
    t166 = 15U;
    t167 = t166;
    t168 = (t3 + 4);
    t169 = *((unsigned int *)t3);
    t166 = (t166 & t169);
    t170 = *((unsigned int *)t168);
    t167 = (t167 & t170);
    t171 = (t165 + 4);
    t172 = *((unsigned int *)t165);
    *((unsigned int *)t165) = (t172 | t166);
    t173 = *((unsigned int *)t171);
    *((unsigned int *)t171) = (t173 | t167);
    xsi_driver_vfirst_trans(t161, 0, 3);
    t174 = (t0 + 8016);
    *((int *)t174) = 1;

LAB1:    return;
LAB6:    t23 = (t8 + 4);
    *((unsigned int *)t8) = 1;
    *((unsigned int *)t23) = 1;
    goto LAB7;

LAB8:    *((unsigned int *)t4) = 1;
    goto LAB11;

LAB10:    t30 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t30) = 1;
    goto LAB11;

LAB12:    t36 = (t0 + 4328);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    memset(t35, 0, 8);
    t39 = (t35 + 4);
    t40 = (t38 + 4);
    t41 = *((unsigned int *)t38);
    t42 = (t41 >> 12);
    *((unsigned int *)t35) = t42;
    t43 = *((unsigned int *)t40);
    t44 = (t43 >> 12);
    *((unsigned int *)t39) = t44;
    t45 = *((unsigned int *)t35);
    *((unsigned int *)t35) = (t45 & 15U);
    t46 = *((unsigned int *)t39);
    *((unsigned int *)t39) = (t46 & 15U);
    goto LAB13;

LAB14:    t53 = (t0 + 4008);
    t54 = (t53 + 56U);
    t55 = *((char **)t54);
    t56 = ((char*)((ng7)));
    memset(t57, 0, 8);
    t58 = (t55 + 4);
    t59 = (t56 + 4);
    t60 = *((unsigned int *)t55);
    t61 = *((unsigned int *)t56);
    t62 = (t60 ^ t61);
    t63 = *((unsigned int *)t58);
    t64 = *((unsigned int *)t59);
    t65 = (t63 ^ t64);
    t66 = (t62 | t65);
    t67 = *((unsigned int *)t58);
    t68 = *((unsigned int *)t59);
    t69 = (t67 | t68);
    t70 = (~(t69));
    t71 = (t66 & t70);
    if (t71 != 0)
        goto LAB24;

LAB21:    if (t69 != 0)
        goto LAB23;

LAB22:    *((unsigned int *)t57) = 1;

LAB24:    memset(t52, 0, 8);
    t73 = (t57 + 4);
    t74 = *((unsigned int *)t73);
    t75 = (~(t74));
    t76 = *((unsigned int *)t57);
    t77 = (t76 & t75);
    t78 = (t77 & 1U);
    if (t78 != 0)
        goto LAB25;

LAB26:    if (*((unsigned int *)t73) != 0)
        goto LAB27;

LAB28:    t80 = (t52 + 4);
    t81 = *((unsigned int *)t52);
    t82 = *((unsigned int *)t80);
    t83 = (t81 || t82);
    if (t83 > 0)
        goto LAB29;

LAB30:    t96 = *((unsigned int *)t52);
    t97 = (~(t96));
    t98 = *((unsigned int *)t80);
    t99 = (t97 || t98);
    if (t99 > 0)
        goto LAB31;

LAB32:    if (*((unsigned int *)t80) > 0)
        goto LAB33;

LAB34:    if (*((unsigned int *)t52) > 0)
        goto LAB35;

LAB36:    memcpy(t51, t100, 8);

LAB37:    goto LAB15;

LAB16:    xsi_vlog_unsigned_bit_combine(t3, 4, t35, 4, t51, 4);
    goto LAB20;

LAB18:    memcpy(t3, t35, 8);
    goto LAB20;

LAB23:    t72 = (t57 + 4);
    *((unsigned int *)t57) = 1;
    *((unsigned int *)t72) = 1;
    goto LAB24;

LAB25:    *((unsigned int *)t52) = 1;
    goto LAB28;

LAB27:    t79 = (t52 + 4);
    *((unsigned int *)t52) = 1;
    *((unsigned int *)t79) = 1;
    goto LAB28;

LAB29:    t85 = (t0 + 4328);
    t86 = (t85 + 56U);
    t87 = *((char **)t86);
    memset(t84, 0, 8);
    t88 = (t84 + 4);
    t89 = (t87 + 4);
    t90 = *((unsigned int *)t87);
    t91 = (t90 >> 8);
    *((unsigned int *)t84) = t91;
    t92 = *((unsigned int *)t89);
    t93 = (t92 >> 8);
    *((unsigned int *)t88) = t93;
    t94 = *((unsigned int *)t84);
    *((unsigned int *)t84) = (t94 & 15U);
    t95 = *((unsigned int *)t88);
    *((unsigned int *)t88) = (t95 & 15U);
    goto LAB30;

LAB31:    t102 = (t0 + 4008);
    t103 = (t102 + 56U);
    t104 = *((char **)t103);
    t105 = ((char*)((ng8)));
    memset(t106, 0, 8);
    t107 = (t104 + 4);
    t108 = (t105 + 4);
    t109 = *((unsigned int *)t104);
    t110 = *((unsigned int *)t105);
    t111 = (t109 ^ t110);
    t112 = *((unsigned int *)t107);
    t113 = *((unsigned int *)t108);
    t114 = (t112 ^ t113);
    t115 = (t111 | t114);
    t116 = *((unsigned int *)t107);
    t117 = *((unsigned int *)t108);
    t118 = (t116 | t117);
    t119 = (~(t118));
    t120 = (t115 & t119);
    if (t120 != 0)
        goto LAB41;

LAB38:    if (t118 != 0)
        goto LAB40;

LAB39:    *((unsigned int *)t106) = 1;

LAB41:    memset(t101, 0, 8);
    t122 = (t106 + 4);
    t123 = *((unsigned int *)t122);
    t124 = (~(t123));
    t125 = *((unsigned int *)t106);
    t126 = (t125 & t124);
    t127 = (t126 & 1U);
    if (t127 != 0)
        goto LAB42;

LAB43:    if (*((unsigned int *)t122) != 0)
        goto LAB44;

LAB45:    t129 = (t101 + 4);
    t130 = *((unsigned int *)t101);
    t131 = *((unsigned int *)t129);
    t132 = (t130 || t131);
    if (t132 > 0)
        goto LAB46;

LAB47:    t145 = *((unsigned int *)t101);
    t146 = (~(t145));
    t147 = *((unsigned int *)t129);
    t148 = (t146 || t147);
    if (t148 > 0)
        goto LAB48;

LAB49:    if (*((unsigned int *)t129) > 0)
        goto LAB50;

LAB51:    if (*((unsigned int *)t101) > 0)
        goto LAB52;

LAB53:    memcpy(t100, t149, 8);

LAB54:    goto LAB32;

LAB33:    xsi_vlog_unsigned_bit_combine(t51, 4, t84, 4, t100, 4);
    goto LAB37;

LAB35:    memcpy(t51, t84, 8);
    goto LAB37;

LAB40:    t121 = (t106 + 4);
    *((unsigned int *)t106) = 1;
    *((unsigned int *)t121) = 1;
    goto LAB41;

LAB42:    *((unsigned int *)t101) = 1;
    goto LAB45;

LAB44:    t128 = (t101 + 4);
    *((unsigned int *)t101) = 1;
    *((unsigned int *)t128) = 1;
    goto LAB45;

LAB46:    t134 = (t0 + 4328);
    t135 = (t134 + 56U);
    t136 = *((char **)t135);
    memset(t133, 0, 8);
    t137 = (t133 + 4);
    t138 = (t136 + 4);
    t139 = *((unsigned int *)t136);
    t140 = (t139 >> 4);
    *((unsigned int *)t133) = t140;
    t141 = *((unsigned int *)t138);
    t142 = (t141 >> 4);
    *((unsigned int *)t137) = t142;
    t143 = *((unsigned int *)t133);
    *((unsigned int *)t133) = (t143 & 15U);
    t144 = *((unsigned int *)t137);
    *((unsigned int *)t137) = (t144 & 15U);
    goto LAB47;

LAB48:    t150 = (t0 + 4328);
    t151 = (t150 + 56U);
    t152 = *((char **)t151);
    memset(t149, 0, 8);
    t153 = (t149 + 4);
    t154 = (t152 + 4);
    t155 = *((unsigned int *)t152);
    t156 = (t155 >> 0);
    *((unsigned int *)t149) = t156;
    t157 = *((unsigned int *)t154);
    t158 = (t157 >> 0);
    *((unsigned int *)t153) = t158;
    t159 = *((unsigned int *)t149);
    *((unsigned int *)t149) = (t159 & 15U);
    t160 = *((unsigned int *)t153);
    *((unsigned int *)t153) = (t160 & 15U);
    goto LAB49;

LAB50:    xsi_vlog_unsigned_bit_combine(t100, 4, t133, 4, t149, 4);
    goto LAB54;

LAB52:    memcpy(t100, t133, 8);
    goto LAB54;

}

static void Cont_102_7(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    char *t27;

LAB0:    t1 = (t0 + 7136U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(102, ng0);
    t2 = (t0 + 4168);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    memset(t3, 0, 8);
    t6 = (t3 + 4);
    t7 = (t5 + 4);
    t8 = *((unsigned int *)t5);
    t9 = (t8 >> 0);
    *((unsigned int *)t3) = t9;
    t10 = *((unsigned int *)t7);
    t11 = (t10 >> 0);
    *((unsigned int *)t6) = t11;
    t12 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t12 & 15U);
    t13 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t13 & 15U);
    t14 = (t0 + 8448);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memset(t18, 0, 8);
    t19 = 15U;
    t20 = t19;
    t21 = (t3 + 4);
    t22 = *((unsigned int *)t3);
    t19 = (t19 & t22);
    t23 = *((unsigned int *)t21);
    t20 = (t20 & t23);
    t24 = (t18 + 4);
    t25 = *((unsigned int *)t18);
    *((unsigned int *)t18) = (t25 | t19);
    t26 = *((unsigned int *)t24);
    *((unsigned int *)t24) = (t26 | t20);
    xsi_driver_vfirst_trans(t14, 0, 3);
    t27 = (t0 + 8032);
    *((int *)t27) = 1;

LAB1:    return;
}

static void Cont_104_8(char *t0)
{
    char t3[8];
    char t4[8];
    char t6[8];
    char t33[8];
    char t44[8];
    char t45[8];
    char t48[8];
    char t75[8];
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
    char *t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    char *t28;
    char *t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    char *t46;
    char *t47;
    char *t49;
    char *t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    char *t63;
    char *t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    char *t70;
    char *t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    char *t76;
    char *t77;
    char *t78;
    char *t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    char *t84;
    char *t85;
    char *t86;
    char *t87;
    char *t88;
    char *t89;
    char *t90;

LAB0:    t1 = (t0 + 7384U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(104, ng0);
    t2 = (t0 + 1368U);
    t5 = *((char **)t2);
    t2 = ((char*)((ng5)));
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

LAB7:    memset(t4, 0, 8);
    t22 = (t6 + 4);
    t23 = *((unsigned int *)t22);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 & 1U);
    if (t27 != 0)
        goto LAB8;

LAB9:    if (*((unsigned int *)t22) != 0)
        goto LAB10;

LAB11:    t29 = (t4 + 4);
    t30 = *((unsigned int *)t4);
    t31 = *((unsigned int *)t29);
    t32 = (t30 || t31);
    if (t32 > 0)
        goto LAB12;

LAB13:    t40 = *((unsigned int *)t4);
    t41 = (~(t40));
    t42 = *((unsigned int *)t29);
    t43 = (t41 || t42);
    if (t43 > 0)
        goto LAB14;

LAB15:    if (*((unsigned int *)t29) > 0)
        goto LAB16;

LAB17:    if (*((unsigned int *)t4) > 0)
        goto LAB18;

LAB19:    memcpy(t3, t44, 8);

LAB20:    t85 = (t0 + 8512);
    t86 = (t85 + 56U);
    t87 = *((char **)t86);
    t88 = (t87 + 56U);
    t89 = *((char **)t88);
    memcpy(t89, t3, 8);
    xsi_driver_vfirst_trans(t85, 0, 31);
    t90 = (t0 + 8048);
    *((int *)t90) = 1;

LAB1:    return;
LAB6:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB7;

LAB8:    *((unsigned int *)t4) = 1;
    goto LAB11;

LAB10:    t28 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t28) = 1;
    goto LAB11;

LAB12:    t34 = (t0 + 4328);
    t35 = (t34 + 56U);
    t36 = *((char **)t35);
    t37 = (t0 + 4488);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    xsi_vlogtype_concat(t33, 32, 32, 2U, t39, 16, t36, 16);
    goto LAB13;

LAB14:    t46 = (t0 + 1368U);
    t47 = *((char **)t46);
    t46 = ((char*)((ng4)));
    memset(t48, 0, 8);
    t49 = (t47 + 4);
    t50 = (t46 + 4);
    t51 = *((unsigned int *)t47);
    t52 = *((unsigned int *)t46);
    t53 = (t51 ^ t52);
    t54 = *((unsigned int *)t49);
    t55 = *((unsigned int *)t50);
    t56 = (t54 ^ t55);
    t57 = (t53 | t56);
    t58 = *((unsigned int *)t49);
    t59 = *((unsigned int *)t50);
    t60 = (t58 | t59);
    t61 = (~(t60));
    t62 = (t57 & t61);
    if (t62 != 0)
        goto LAB24;

LAB21:    if (t60 != 0)
        goto LAB23;

LAB22:    *((unsigned int *)t48) = 1;

LAB24:    memset(t45, 0, 8);
    t64 = (t48 + 4);
    t65 = *((unsigned int *)t64);
    t66 = (~(t65));
    t67 = *((unsigned int *)t48);
    t68 = (t67 & t66);
    t69 = (t68 & 1U);
    if (t69 != 0)
        goto LAB25;

LAB26:    if (*((unsigned int *)t64) != 0)
        goto LAB27;

LAB28:    t71 = (t45 + 4);
    t72 = *((unsigned int *)t45);
    t73 = *((unsigned int *)t71);
    t74 = (t72 || t73);
    if (t74 > 0)
        goto LAB29;

LAB30:    t80 = *((unsigned int *)t45);
    t81 = (~(t80));
    t82 = *((unsigned int *)t71);
    t83 = (t81 || t82);
    if (t83 > 0)
        goto LAB31;

LAB32:    if (*((unsigned int *)t71) > 0)
        goto LAB33;

LAB34:    if (*((unsigned int *)t45) > 0)
        goto LAB35;

LAB36:    memcpy(t44, t84, 8);

LAB37:    goto LAB15;

LAB16:    xsi_vlog_unsigned_bit_combine(t3, 32, t33, 32, t44, 32);
    goto LAB20;

LAB18:    memcpy(t3, t33, 8);
    goto LAB20;

LAB23:    t63 = (t48 + 4);
    *((unsigned int *)t48) = 1;
    *((unsigned int *)t63) = 1;
    goto LAB24;

LAB25:    *((unsigned int *)t45) = 1;
    goto LAB28;

LAB27:    t70 = (t45 + 4);
    *((unsigned int *)t45) = 1;
    *((unsigned int *)t70) = 1;
    goto LAB28;

LAB29:    t76 = (t0 + 4168);
    t77 = (t76 + 56U);
    t78 = *((char **)t77);
    t79 = ((char*)((ng5)));
    xsi_vlogtype_concat(t75, 32, 32, 2U, t79, 24, t78, 8);
    goto LAB30;

LAB31:    t84 = ((char*)((ng5)));
    goto LAB32;

LAB33:    xsi_vlog_unsigned_bit_combine(t44, 32, t75, 32, t84, 32);
    goto LAB37;

LAB35:    memcpy(t44, t75, 8);
    goto LAB37;

}

static void Cont_109_9(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;

LAB0:    t1 = (t0 + 7632U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(109, ng0);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 8576);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memset(t7, 0, 8);
    t8 = 1U;
    t9 = t8;
    t10 = (t2 + 4);
    t11 = *((unsigned int *)t2);
    t8 = (t8 & t11);
    t12 = *((unsigned int *)t10);
    t9 = (t9 & t12);
    t13 = (t7 + 4);
    t14 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t14 | t8);
    t15 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t15 | t9);
    xsi_driver_vfirst_trans(t3, 0, 0);

LAB1:    return;
}


extern void work_m_01945475354151423106_2076803588_init()
{
	static char *pe[] = {(void *)Initial_29_0,(void *)Always_52_1,(void *)Cont_86_2,(void *)Cont_87_3,(void *)Cont_88_4,(void *)Cont_90_5,(void *)Cont_96_6,(void *)Cont_102_7,(void *)Cont_104_8,(void *)Cont_109_9};
	xsi_register_didat("work_m_01945475354151423106_2076803588", "isim/pipelined3_p8_tb_isim_beh.exe.sim/work/m_01945475354151423106_2076803588.didat");
	xsi_register_executes(pe);
}
