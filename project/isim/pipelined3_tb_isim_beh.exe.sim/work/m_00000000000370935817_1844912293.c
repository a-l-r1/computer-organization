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

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/cygwin64/home/A-l-r/co/src/src/devices/timer.v";
static unsigned int ng1[] = {0U, 0U};
static unsigned int ng2[] = {32528U, 0U};
static int ng3[] = {0, 0};
static unsigned int ng4[] = {1U, 0U};
static unsigned int ng5[] = {4U, 0U};
static unsigned int ng6[] = {8U, 0U};
static unsigned int ng7[] = {2U, 0U};
static int ng8[] = {1, 0};
static unsigned int ng9[] = {3U, 0U};



static void Cont_23_0(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;

LAB0:    t1 = (t0 + 4744U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(23, ng0);
    t2 = (t0 + 3504);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t0 + 3344);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = ((char*)((ng1)));
    t10 = (t0 + 3184);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = ((char*)((ng1)));
    xsi_vlogtype_concat(t3, 32, 32, 5U, t13, 28, t12, 1, t9, 1, t8, 1, t5, 1);
    t14 = (t0 + 6448);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t3, 8);
    xsi_driver_vfirst_trans(t14, 0, 31);
    t19 = (t0 + 6304);
    *((int *)t19) = 1;

LAB1:    return;
}

static void Cont_25_1(char *t0)
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

LAB0:    t1 = (t0 + 4992U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(25, ng0);
    t2 = (t0 + 3664);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 6512);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 1U;
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
    xsi_driver_vfirst_trans(t5, 0, 0);
    t18 = (t0 + 6320);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Cont_28_2(char *t0)
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

LAB0:    t1 = (t0 + 5240U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(28, ng0);
    t2 = (t0 + 1504U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng2)));
    memset(t6, 0, 8);
    xsi_vlog_unsigned_minus(t6, 32, t4, 32, t2, 32);
    t7 = (t0 + 6576);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t6, 8);
    xsi_driver_vfirst_trans(t7, 0, 31);
    t12 = (t0 + 6336);
    *((int *)t12) = 1;

LAB1:    return;
}

static void Initial_32_3(char *t0)
{
    char *t1;
    char *t2;

LAB0:    xsi_set_current_line(32, ng0);

LAB2:    xsi_set_current_line(33, ng0);
    t1 = ((char*)((ng3)));
    t2 = (t0 + 2864);
    xsi_vlogvar_wait_assign_value(t2, t1, 0, 0, 32, 0LL);
    xsi_set_current_line(34, ng0);
    t1 = ((char*)((ng3)));
    t2 = (t0 + 3024);
    xsi_vlogvar_wait_assign_value(t2, t1, 0, 0, 32, 0LL);
    xsi_set_current_line(35, ng0);
    t1 = ((char*)((ng3)));
    t2 = (t0 + 3184);
    xsi_vlogvar_wait_assign_value(t2, t1, 0, 0, 1, 0LL);
    xsi_set_current_line(36, ng0);
    t1 = ((char*)((ng3)));
    t2 = (t0 + 3344);
    xsi_vlogvar_wait_assign_value(t2, t1, 0, 0, 1, 0LL);
    xsi_set_current_line(37, ng0);
    t1 = ((char*)((ng3)));
    t2 = (t0 + 3504);
    xsi_vlogvar_wait_assign_value(t2, t1, 0, 0, 1, 0LL);
    xsi_set_current_line(38, ng0);
    t1 = ((char*)((ng1)));
    t2 = (t0 + 3824);
    xsi_vlogvar_wait_assign_value(t2, t1, 0, 0, 3, 0LL);
    xsi_set_current_line(39, ng0);
    t1 = ((char*)((ng3)));
    t2 = (t0 + 3664);
    xsi_vlogvar_wait_assign_value(t2, t1, 0, 0, 1, 0LL);

LAB1:    return;
}

static void Always_42_4(char *t0)
{
    char t6[8];
    char t31[8];
    char t32[8];
    char t42[8];
    char t52[8];
    char t63[8];
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
    char *t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    char *t40;
    char *t41;
    char *t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    char *t50;
    char *t51;
    char *t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    char *t60;
    char *t61;
    char *t62;

LAB0:    t1 = (t0 + 5736U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(42, ng0);
    t2 = (t0 + 6352);
    *((int *)t2) = 1;
    t3 = (t0 + 5768);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(42, ng0);

LAB5:    xsi_set_current_line(43, ng0);
    t4 = (t0 + 1344U);
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

LAB11:    xsi_set_current_line(49, ng0);

LAB14:    xsi_set_current_line(50, ng0);
    t2 = (t0 + 1664U);
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

LAB20:    xsi_set_current_line(57, ng0);

LAB31:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 3824);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);

LAB32:    t5 = ((char*)((ng1)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t5, 3);
    if (t30 == 1)
        goto LAB33;

LAB34:    t2 = ((char*)((ng4)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t30 == 1)
        goto LAB35;

LAB36:    t2 = ((char*)((ng7)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t30 == 1)
        goto LAB37;

LAB38:    t2 = ((char*)((ng9)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t30 == 1)
        goto LAB39;

LAB40:
LAB41:
LAB21:
LAB12:    goto LAB2;

LAB8:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(43, ng0);

LAB13:    xsi_set_current_line(44, ng0);
    t28 = ((char*)((ng3)));
    t29 = (t0 + 2864);
    xsi_vlogvar_wait_assign_value(t29, t28, 0, 0, 32, 0LL);
    xsi_set_current_line(45, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3024);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 32, 0LL);
    xsi_set_current_line(46, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3184);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(47, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3344);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(48, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3504);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB12;

LAB17:    t7 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t7) = 1;
    goto LAB18;

LAB19:    xsi_set_current_line(50, ng0);

LAB22:    xsi_set_current_line(51, ng0);
    t21 = (t0 + 2464U);
    t22 = *((char **)t21);

LAB23:    t21 = ((char*)((ng1)));
    t30 = xsi_vlog_unsigned_case_compare(t22, 32, t21, 32);
    if (t30 == 1)
        goto LAB24;

LAB25:    t2 = ((char*)((ng5)));
    t30 = xsi_vlog_unsigned_case_compare(t22, 32, t2, 32);
    if (t30 == 1)
        goto LAB26;

LAB27:    t2 = ((char*)((ng6)));
    t30 = xsi_vlog_unsigned_case_compare(t22, 32, t2, 32);
    if (t30 == 1)
        goto LAB28;

LAB29:
LAB30:    goto LAB21;

LAB24:    xsi_set_current_line(52, ng0);
    t28 = (t0 + 1824U);
    t29 = *((char **)t28);
    memset(t32, 0, 8);
    t28 = (t32 + 4);
    t33 = (t29 + 4);
    t34 = *((unsigned int *)t29);
    t35 = (t34 >> 0);
    t36 = (t35 & 1);
    *((unsigned int *)t32) = t36;
    t37 = *((unsigned int *)t33);
    t38 = (t37 >> 0);
    t39 = (t38 & 1);
    *((unsigned int *)t28) = t39;
    t40 = (t0 + 1824U);
    t41 = *((char **)t40);
    memset(t42, 0, 8);
    t40 = (t42 + 4);
    t43 = (t41 + 4);
    t44 = *((unsigned int *)t41);
    t45 = (t44 >> 1);
    t46 = (t45 & 1);
    *((unsigned int *)t42) = t46;
    t47 = *((unsigned int *)t43);
    t48 = (t47 >> 1);
    t49 = (t48 & 1);
    *((unsigned int *)t40) = t49;
    t50 = (t0 + 1824U);
    t51 = *((char **)t50);
    memset(t52, 0, 8);
    t50 = (t52 + 4);
    t53 = (t51 + 4);
    t54 = *((unsigned int *)t51);
    t55 = (t54 >> 3);
    t56 = (t55 & 1);
    *((unsigned int *)t52) = t56;
    t57 = *((unsigned int *)t53);
    t58 = (t57 >> 3);
    t59 = (t58 & 1);
    *((unsigned int *)t50) = t59;
    xsi_vlogtype_concat(t31, 3, 3, 3U, t52, 1, t42, 1, t32, 1);
    t60 = (t0 + 3504);
    xsi_vlogvar_wait_assign_value(t60, t31, 0, 0, 1, 0LL);
    t61 = (t0 + 3344);
    xsi_vlogvar_wait_assign_value(t61, t31, 1, 0, 1, 0LL);
    t62 = (t0 + 3184);
    xsi_vlogvar_wait_assign_value(t62, t31, 2, 0, 1, 0LL);
    goto LAB30;

LAB26:    xsi_set_current_line(53, ng0);
    t3 = (t0 + 1824U);
    t4 = *((char **)t3);
    t3 = (t0 + 2864);
    xsi_vlogvar_wait_assign_value(t3, t4, 0, 0, 32, 0LL);
    goto LAB30;

LAB28:    xsi_set_current_line(54, ng0);
    t3 = (t0 + 1824U);
    t4 = *((char **)t3);
    t3 = (t0 + 3024);
    xsi_vlogvar_wait_assign_value(t3, t4, 0, 0, 32, 0LL);
    goto LAB30;

LAB33:    xsi_set_current_line(59, ng0);

LAB42:    xsi_set_current_line(60, ng0);
    t7 = (t0 + 3504);
    t8 = (t7 + 56U);
    t21 = *((char **)t8);
    t28 = ((char*)((ng4)));
    memset(t6, 0, 8);
    t29 = (t21 + 4);
    t33 = (t28 + 4);
    t9 = *((unsigned int *)t21);
    t10 = *((unsigned int *)t28);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t29);
    t13 = *((unsigned int *)t33);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t29);
    t17 = *((unsigned int *)t33);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB46;

LAB43:    if (t18 != 0)
        goto LAB45;

LAB44:    *((unsigned int *)t6) = 1;

LAB46:    t41 = (t6 + 4);
    t23 = *((unsigned int *)t41);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB47;

LAB48:    xsi_set_current_line(63, ng0);

LAB51:    xsi_set_current_line(64, ng0);
    t2 = (t0 + 3184);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t7 = ((char*)((ng1)));
    memset(t6, 0, 8);
    t8 = (t5 + 4);
    t21 = (t7 + 4);
    t9 = *((unsigned int *)t5);
    t10 = *((unsigned int *)t7);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t8);
    t13 = *((unsigned int *)t21);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t8);
    t17 = *((unsigned int *)t21);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB55;

LAB52:    if (t18 != 0)
        goto LAB54;

LAB53:    *((unsigned int *)t6) = 1;

LAB55:    t29 = (t6 + 4);
    t23 = *((unsigned int *)t29);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB56;

LAB57:
LAB58:
LAB49:    goto LAB41;

LAB35:    xsi_set_current_line(69, ng0);

LAB60:    xsi_set_current_line(70, ng0);
    t3 = (t0 + 2864);
    t5 = (t3 + 56U);
    t7 = *((char **)t5);
    t8 = (t0 + 3024);
    xsi_vlogvar_wait_assign_value(t8, t7, 0, 0, 32, 0LL);
    xsi_set_current_line(71, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t0 + 3824);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);
    goto LAB41;

LAB37:    xsi_set_current_line(73, ng0);

LAB61:    xsi_set_current_line(74, ng0);
    t3 = (t0 + 3504);
    t5 = (t3 + 56U);
    t7 = *((char **)t5);
    t8 = ((char*)((ng1)));
    memset(t6, 0, 8);
    t21 = (t7 + 4);
    t28 = (t8 + 4);
    t9 = *((unsigned int *)t7);
    t10 = *((unsigned int *)t8);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t21);
    t13 = *((unsigned int *)t28);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t21);
    t17 = *((unsigned int *)t28);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB65;

LAB62:    if (t18 != 0)
        goto LAB64;

LAB63:    *((unsigned int *)t6) = 1;

LAB65:    t33 = (t6 + 4);
    t23 = *((unsigned int *)t33);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB66;

LAB67:    xsi_set_current_line(76, ng0);

LAB70:    xsi_set_current_line(77, ng0);
    t2 = (t0 + 3024);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t7 = ((char*)((ng8)));
    memset(t32, 0, 8);
    t8 = (t5 + 4);
    if (*((unsigned int *)t8) != 0)
        goto LAB72;

LAB71:    t21 = (t7 + 4);
    if (*((unsigned int *)t21) != 0)
        goto LAB72;

LAB75:    if (*((unsigned int *)t5) > *((unsigned int *)t7))
        goto LAB73;

LAB74:    t29 = (t32 + 4);
    t9 = *((unsigned int *)t29);
    t10 = (~(t9));
    t11 = *((unsigned int *)t32);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB76;

LAB77:    xsi_set_current_line(79, ng0);

LAB80:    xsi_set_current_line(80, ng0);
    t2 = (t0 + 3024);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t7 = ((char*)((ng8)));
    memset(t32, 0, 8);
    t8 = (t5 + 4);
    t21 = (t7 + 4);
    t9 = *((unsigned int *)t5);
    t10 = *((unsigned int *)t7);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t8);
    t13 = *((unsigned int *)t21);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t8);
    t17 = *((unsigned int *)t21);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB84;

LAB81:    if (t18 != 0)
        goto LAB83;

LAB82:    *((unsigned int *)t32) = 1;

LAB84:    t29 = (t32 + 4);
    t23 = *((unsigned int *)t29);
    t24 = (~(t23));
    t25 = *((unsigned int *)t32);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB85;

LAB86:
LAB87:
LAB78:
LAB68:    goto LAB41;

LAB39:    xsi_set_current_line(90, ng0);

LAB97:    xsi_set_current_line(91, ng0);
    t3 = (t0 + 3344);
    t5 = (t3 + 56U);
    t7 = *((char **)t5);
    t8 = ((char*)((ng1)));
    memset(t6, 0, 8);
    t21 = (t7 + 4);
    t28 = (t8 + 4);
    t9 = *((unsigned int *)t7);
    t10 = *((unsigned int *)t8);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t21);
    t13 = *((unsigned int *)t28);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t21);
    t17 = *((unsigned int *)t28);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB101;

LAB98:    if (t18 != 0)
        goto LAB100;

LAB99:    *((unsigned int *)t6) = 1;

LAB101:    t33 = (t6 + 4);
    t23 = *((unsigned int *)t33);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB102;

LAB103:    xsi_set_current_line(97, ng0);

LAB114:    xsi_set_current_line(98, ng0);
    t2 = (t0 + 3344);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t7 = ((char*)((ng4)));
    memset(t6, 0, 8);
    t8 = (t5 + 4);
    t21 = (t7 + 4);
    t9 = *((unsigned int *)t5);
    t10 = *((unsigned int *)t7);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t8);
    t13 = *((unsigned int *)t21);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t8);
    t17 = *((unsigned int *)t21);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB118;

LAB115:    if (t18 != 0)
        goto LAB117;

LAB116:    *((unsigned int *)t6) = 1;

LAB118:    t29 = (t6 + 4);
    t23 = *((unsigned int *)t29);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB119;

LAB120:
LAB121:
LAB104:    goto LAB41;

LAB45:    t40 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t40) = 1;
    goto LAB46;

LAB47:    xsi_set_current_line(60, ng0);

LAB50:    xsi_set_current_line(61, ng0);
    t43 = ((char*)((ng1)));
    t50 = (t0 + 3664);
    xsi_vlogvar_wait_assign_value(t50, t43, 0, 0, 1, 0LL);
    xsi_set_current_line(62, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 3824);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);
    goto LAB49;

LAB54:    t28 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t28) = 1;
    goto LAB55;

LAB56:    xsi_set_current_line(64, ng0);

LAB59:    xsi_set_current_line(65, ng0);
    t33 = ((char*)((ng1)));
    t40 = (t0 + 3664);
    xsi_vlogvar_wait_assign_value(t40, t33, 0, 0, 1, 0LL);
    goto LAB58;

LAB64:    t29 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t29) = 1;
    goto LAB65;

LAB66:    xsi_set_current_line(74, ng0);

LAB69:    xsi_set_current_line(75, ng0);
    t40 = ((char*)((ng1)));
    t41 = (t0 + 3824);
    xsi_vlogvar_wait_assign_value(t41, t40, 0, 0, 3, 0LL);
    goto LAB68;

LAB72:    t28 = (t32 + 4);
    *((unsigned int *)t32) = 1;
    *((unsigned int *)t28) = 1;
    goto LAB74;

LAB73:    *((unsigned int *)t32) = 1;
    goto LAB74;

LAB76:    xsi_set_current_line(77, ng0);

LAB79:    xsi_set_current_line(78, ng0);
    t33 = (t0 + 3024);
    t40 = (t33 + 56U);
    t41 = *((char **)t40);
    t43 = ((char*)((ng8)));
    memset(t63, 0, 8);
    xsi_vlog_unsigned_minus(t63, 32, t41, 32, t43, 32);
    t50 = (t0 + 3024);
    xsi_vlogvar_wait_assign_value(t50, t63, 0, 0, 32, 0LL);
    goto LAB78;

LAB83:    t28 = (t32 + 4);
    *((unsigned int *)t32) = 1;
    *((unsigned int *)t28) = 1;
    goto LAB84;

LAB85:    xsi_set_current_line(80, ng0);

LAB88:    xsi_set_current_line(81, ng0);
    t33 = (t0 + 3024);
    t40 = (t33 + 56U);
    t41 = *((char **)t40);
    t43 = ((char*)((ng8)));
    memset(t63, 0, 8);
    xsi_vlog_unsigned_minus(t63, 32, t41, 32, t43, 32);
    t50 = (t0 + 3024);
    xsi_vlogvar_wait_assign_value(t50, t63, 0, 0, 32, 0LL);
    xsi_set_current_line(82, ng0);
    t2 = ((char*)((ng9)));
    t3 = (t0 + 3824);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);
    xsi_set_current_line(83, ng0);
    t2 = (t0 + 3184);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t7 = ((char*)((ng4)));
    memset(t6, 0, 8);
    t8 = (t5 + 4);
    t21 = (t7 + 4);
    t9 = *((unsigned int *)t5);
    t10 = *((unsigned int *)t7);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t8);
    t13 = *((unsigned int *)t21);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t8);
    t17 = *((unsigned int *)t21);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB92;

LAB89:    if (t18 != 0)
        goto LAB91;

LAB90:    *((unsigned int *)t6) = 1;

LAB92:    t29 = (t6 + 4);
    t23 = *((unsigned int *)t29);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB93;

LAB94:
LAB95:    goto LAB87;

LAB91:    t28 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t28) = 1;
    goto LAB92;

LAB93:    xsi_set_current_line(83, ng0);

LAB96:    xsi_set_current_line(84, ng0);
    t33 = ((char*)((ng4)));
    t40 = (t0 + 3664);
    xsi_vlogvar_wait_assign_value(t40, t33, 0, 0, 1, 0LL);
    goto LAB95;

LAB100:    t29 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t29) = 1;
    goto LAB101;

LAB102:    xsi_set_current_line(91, ng0);

LAB105:    xsi_set_current_line(92, ng0);
    t40 = ((char*)((ng1)));
    t41 = (t0 + 3504);
    xsi_vlogvar_wait_assign_value(t41, t40, 0, 0, 1, 0LL);
    xsi_set_current_line(93, ng0);
    t2 = (t0 + 3184);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t7 = ((char*)((ng1)));
    memset(t6, 0, 8);
    t8 = (t5 + 4);
    t21 = (t7 + 4);
    t9 = *((unsigned int *)t5);
    t10 = *((unsigned int *)t7);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t8);
    t13 = *((unsigned int *)t21);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t8);
    t17 = *((unsigned int *)t21);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB109;

LAB106:    if (t18 != 0)
        goto LAB108;

LAB107:    *((unsigned int *)t6) = 1;

LAB109:    t29 = (t6 + 4);
    t23 = *((unsigned int *)t29);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB110;

LAB111:
LAB112:    xsi_set_current_line(96, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3824);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);
    goto LAB104;

LAB108:    t28 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t28) = 1;
    goto LAB109;

LAB110:    xsi_set_current_line(93, ng0);

LAB113:    xsi_set_current_line(94, ng0);
    t33 = ((char*)((ng1)));
    t40 = (t0 + 3664);
    xsi_vlogvar_wait_assign_value(t40, t33, 0, 0, 1, 0LL);
    goto LAB112;

LAB117:    t28 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t28) = 1;
    goto LAB118;

LAB119:    xsi_set_current_line(98, ng0);

LAB122:    xsi_set_current_line(99, ng0);
    t33 = ((char*)((ng1)));
    t40 = (t0 + 3664);
    xsi_vlogvar_wait_assign_value(t40, t33, 0, 0, 1, 0LL);
    xsi_set_current_line(100, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3824);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);
    goto LAB121;

}

static void Cont_110_5(char *t0)
{
    char t3[8];
    char t4[8];
    char t6[8];
    char t33[8];
    char t49[8];
    char t50[8];
    char t53[8];
    char t87[8];
    char t88[8];
    char t91[8];
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
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    char *t51;
    char *t52;
    char *t54;
    char *t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    char *t68;
    char *t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    char *t75;
    char *t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    char *t80;
    char *t81;
    char *t82;
    unsigned int t83;
    unsigned int t84;
    unsigned int t85;
    unsigned int t86;
    char *t89;
    char *t90;
    char *t92;
    char *t93;
    unsigned int t94;
    unsigned int t95;
    unsigned int t96;
    unsigned int t97;
    unsigned int t98;
    unsigned int t99;
    unsigned int t100;
    unsigned int t101;
    unsigned int t102;
    unsigned int t103;
    unsigned int t104;
    unsigned int t105;
    char *t106;
    char *t107;
    unsigned int t108;
    unsigned int t109;
    unsigned int t110;
    unsigned int t111;
    unsigned int t112;
    char *t113;
    char *t114;
    unsigned int t115;
    unsigned int t116;
    unsigned int t117;
    char *t118;
    char *t119;
    char *t120;
    unsigned int t121;
    unsigned int t122;
    unsigned int t123;
    unsigned int t124;
    char *t125;
    char *t126;
    char *t127;
    char *t128;
    char *t129;
    char *t130;
    char *t131;

LAB0:    t1 = (t0 + 5984U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(110, ng0);
    t2 = (t0 + 2464U);
    t5 = *((char **)t2);
    t2 = ((char*)((ng1)));
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

LAB13:    t45 = *((unsigned int *)t4);
    t46 = (~(t45));
    t47 = *((unsigned int *)t29);
    t48 = (t46 || t47);
    if (t48 > 0)
        goto LAB14;

LAB15:    if (*((unsigned int *)t29) > 0)
        goto LAB16;

LAB17:    if (*((unsigned int *)t4) > 0)
        goto LAB18;

LAB19:    memcpy(t3, t49, 8);

LAB20:    t126 = (t0 + 6640);
    t127 = (t126 + 56U);
    t128 = *((char **)t127);
    t129 = (t128 + 56U);
    t130 = *((char **)t129);
    memcpy(t130, t3, 8);
    xsi_driver_vfirst_trans(t126, 0, 31);
    t131 = (t0 + 6368);
    *((int *)t131) = 1;

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

LAB12:    t34 = (t0 + 3504);
    t35 = (t34 + 56U);
    t36 = *((char **)t35);
    t37 = (t0 + 3344);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    t40 = ((char*)((ng1)));
    t41 = (t0 + 3184);
    t42 = (t41 + 56U);
    t43 = *((char **)t42);
    t44 = ((char*)((ng1)));
    xsi_vlogtype_concat(t33, 32, 32, 5U, t44, 28, t43, 1, t40, 1, t39, 1, t36, 1);
    goto LAB13;

LAB14:    t51 = (t0 + 2464U);
    t52 = *((char **)t51);
    t51 = ((char*)((ng5)));
    memset(t53, 0, 8);
    t54 = (t52 + 4);
    t55 = (t51 + 4);
    t56 = *((unsigned int *)t52);
    t57 = *((unsigned int *)t51);
    t58 = (t56 ^ t57);
    t59 = *((unsigned int *)t54);
    t60 = *((unsigned int *)t55);
    t61 = (t59 ^ t60);
    t62 = (t58 | t61);
    t63 = *((unsigned int *)t54);
    t64 = *((unsigned int *)t55);
    t65 = (t63 | t64);
    t66 = (~(t65));
    t67 = (t62 & t66);
    if (t67 != 0)
        goto LAB24;

LAB21:    if (t65 != 0)
        goto LAB23;

LAB22:    *((unsigned int *)t53) = 1;

LAB24:    memset(t50, 0, 8);
    t69 = (t53 + 4);
    t70 = *((unsigned int *)t69);
    t71 = (~(t70));
    t72 = *((unsigned int *)t53);
    t73 = (t72 & t71);
    t74 = (t73 & 1U);
    if (t74 != 0)
        goto LAB25;

LAB26:    if (*((unsigned int *)t69) != 0)
        goto LAB27;

LAB28:    t76 = (t50 + 4);
    t77 = *((unsigned int *)t50);
    t78 = *((unsigned int *)t76);
    t79 = (t77 || t78);
    if (t79 > 0)
        goto LAB29;

LAB30:    t83 = *((unsigned int *)t50);
    t84 = (~(t83));
    t85 = *((unsigned int *)t76);
    t86 = (t84 || t85);
    if (t86 > 0)
        goto LAB31;

LAB32:    if (*((unsigned int *)t76) > 0)
        goto LAB33;

LAB34:    if (*((unsigned int *)t50) > 0)
        goto LAB35;

LAB36:    memcpy(t49, t87, 8);

LAB37:    goto LAB15;

LAB16:    xsi_vlog_unsigned_bit_combine(t3, 32, t33, 32, t49, 32);
    goto LAB20;

LAB18:    memcpy(t3, t33, 8);
    goto LAB20;

LAB23:    t68 = (t53 + 4);
    *((unsigned int *)t53) = 1;
    *((unsigned int *)t68) = 1;
    goto LAB24;

LAB25:    *((unsigned int *)t50) = 1;
    goto LAB28;

LAB27:    t75 = (t50 + 4);
    *((unsigned int *)t50) = 1;
    *((unsigned int *)t75) = 1;
    goto LAB28;

LAB29:    t80 = (t0 + 2864);
    t81 = (t80 + 56U);
    t82 = *((char **)t81);
    goto LAB30;

LAB31:    t89 = (t0 + 2464U);
    t90 = *((char **)t89);
    t89 = ((char*)((ng6)));
    memset(t91, 0, 8);
    t92 = (t90 + 4);
    t93 = (t89 + 4);
    t94 = *((unsigned int *)t90);
    t95 = *((unsigned int *)t89);
    t96 = (t94 ^ t95);
    t97 = *((unsigned int *)t92);
    t98 = *((unsigned int *)t93);
    t99 = (t97 ^ t98);
    t100 = (t96 | t99);
    t101 = *((unsigned int *)t92);
    t102 = *((unsigned int *)t93);
    t103 = (t101 | t102);
    t104 = (~(t103));
    t105 = (t100 & t104);
    if (t105 != 0)
        goto LAB41;

LAB38:    if (t103 != 0)
        goto LAB40;

LAB39:    *((unsigned int *)t91) = 1;

LAB41:    memset(t88, 0, 8);
    t107 = (t91 + 4);
    t108 = *((unsigned int *)t107);
    t109 = (~(t108));
    t110 = *((unsigned int *)t91);
    t111 = (t110 & t109);
    t112 = (t111 & 1U);
    if (t112 != 0)
        goto LAB42;

LAB43:    if (*((unsigned int *)t107) != 0)
        goto LAB44;

LAB45:    t114 = (t88 + 4);
    t115 = *((unsigned int *)t88);
    t116 = *((unsigned int *)t114);
    t117 = (t115 || t116);
    if (t117 > 0)
        goto LAB46;

LAB47:    t121 = *((unsigned int *)t88);
    t122 = (~(t121));
    t123 = *((unsigned int *)t114);
    t124 = (t122 || t123);
    if (t124 > 0)
        goto LAB48;

LAB49:    if (*((unsigned int *)t114) > 0)
        goto LAB50;

LAB51:    if (*((unsigned int *)t88) > 0)
        goto LAB52;

LAB53:    memcpy(t87, t125, 8);

LAB54:    goto LAB32;

LAB33:    xsi_vlog_unsigned_bit_combine(t49, 32, t82, 32, t87, 32);
    goto LAB37;

LAB35:    memcpy(t49, t82, 8);
    goto LAB37;

LAB40:    t106 = (t91 + 4);
    *((unsigned int *)t91) = 1;
    *((unsigned int *)t106) = 1;
    goto LAB41;

LAB42:    *((unsigned int *)t88) = 1;
    goto LAB45;

LAB44:    t113 = (t88 + 4);
    *((unsigned int *)t88) = 1;
    *((unsigned int *)t113) = 1;
    goto LAB45;

LAB46:    t118 = (t0 + 3024);
    t119 = (t118 + 56U);
    t120 = *((char **)t119);
    goto LAB47;

LAB48:    t125 = ((char*)((ng1)));
    goto LAB49;

LAB50:    xsi_vlog_unsigned_bit_combine(t87, 32, t120, 32, t125, 32);
    goto LAB54;

LAB52:    memcpy(t87, t120, 8);
    goto LAB54;

}


extern void work_m_00000000000370935817_1844912293_init()
{
	static char *pe[] = {(void *)Cont_23_0,(void *)Cont_25_1,(void *)Cont_28_2,(void *)Initial_32_3,(void *)Always_42_4,(void *)Cont_110_5};
	xsi_register_didat("work_m_00000000000370935817_1844912293", "isim/pipelined3_tb_isim_beh.exe.sim/work/m_00000000000370935817_1844912293.didat");
	xsi_register_executes(pe);
}
