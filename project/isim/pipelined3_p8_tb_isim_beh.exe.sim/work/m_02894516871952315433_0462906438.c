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
static const char *ng0 = "/home/a-l-r/co/src/src/devices/buttons.v";
static int ng1[] = {0, 0};
static unsigned int ng2[] = {1U, 0U};
static unsigned int ng3[] = {0U, 0U};



static void Initial_17_0(char *t0)
{
    char *t1;
    char *t2;

LAB0:    xsi_set_current_line(17, ng0);

LAB2:    xsi_set_current_line(18, ng0);
    t1 = ((char*)((ng1)));
    t2 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t2, t1, 0, 0, 8, 0LL);
    xsi_set_current_line(19, ng0);
    t1 = ((char*)((ng1)));
    t2 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t2, t1, 0, 0, 1, 0LL);

LAB1:    return;
}

static void Always_22_1(char *t0)
{
    char t6[8];
    char t30[8];
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
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;

LAB0:    t1 = (t0 + 3888U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(22, ng0);
    t2 = (t0 + 4704);
    *((int *)t2) = 1;
    t3 = (t0 + 3920);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(22, ng0);

LAB5:    xsi_set_current_line(23, ng0);
    t4 = (t0 + 1208U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng2)));
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

LAB11:    xsi_set_current_line(26, ng0);

LAB14:    xsi_set_current_line(27, ng0);
    t2 = (t0 + 2168U);
    t3 = *((char **)t2);
    memset(t6, 0, 8);
    t2 = (t6 + 4);
    t4 = (t3 + 4);
    t9 = *((unsigned int *)t3);
    t10 = (~(t9));
    *((unsigned int *)t6) = t10;
    *((unsigned int *)t2) = 0;
    if (*((unsigned int *)t4) != 0)
        goto LAB16;

LAB15:    t15 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t15 & 255U);
    t16 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t16 & 255U);
    t5 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t5, t6, 0, 0, 8, 0LL);
    xsi_set_current_line(31, ng0);
    t2 = (t0 + 2168U);
    t3 = *((char **)t2);
    memset(t6, 0, 8);
    t2 = (t3 + 4);
    t9 = *((unsigned int *)t3);
    t10 = *((unsigned int *)t2);
    t11 = (t9 | t10);
    if (t11 != 255U)
        goto LAB18;

LAB17:    if (*((unsigned int *)t2) == 0)
        goto LAB19;

LAB20:    t4 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t4) = 1;

LAB18:    t5 = ((char*)((ng1)));
    memset(t30, 0, 8);
    t7 = (t6 + 4);
    t8 = (t5 + 4);
    t12 = *((unsigned int *)t6);
    t13 = *((unsigned int *)t5);
    t14 = (t12 ^ t13);
    t15 = *((unsigned int *)t7);
    t16 = *((unsigned int *)t8);
    t17 = (t15 ^ t16);
    t18 = (t14 | t17);
    t19 = *((unsigned int *)t7);
    t20 = *((unsigned int *)t8);
    t23 = (t19 | t20);
    t24 = (~(t23));
    t25 = (t18 & t24);
    if (t25 != 0)
        goto LAB24;

LAB21:    if (t23 != 0)
        goto LAB23;

LAB22:    *((unsigned int *)t30) = 1;

LAB24:    t22 = (t30 + 4);
    t26 = *((unsigned int *)t22);
    t27 = (~(t26));
    t31 = *((unsigned int *)t30);
    t32 = (t31 & t27);
    t33 = (t32 != 0);
    if (t33 > 0)
        goto LAB25;

LAB26:    xsi_set_current_line(33, ng0);

LAB29:    xsi_set_current_line(34, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);

LAB27:
LAB12:    goto LAB2;

LAB8:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(23, ng0);

LAB13:    xsi_set_current_line(24, ng0);
    t28 = ((char*)((ng1)));
    t29 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t29, t28, 0, 0, 8, 0LL);
    xsi_set_current_line(25, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB12;

LAB16:    t11 = *((unsigned int *)t6);
    t12 = *((unsigned int *)t4);
    *((unsigned int *)t6) = (t11 | t12);
    t13 = *((unsigned int *)t2);
    t14 = *((unsigned int *)t4);
    *((unsigned int *)t2) = (t13 | t14);
    goto LAB15;

LAB19:    *((unsigned int *)t6) = 1;
    goto LAB18;

LAB23:    t21 = (t30 + 4);
    *((unsigned int *)t30) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB24;

LAB25:    xsi_set_current_line(31, ng0);

LAB28:    xsi_set_current_line(32, ng0);
    t28 = ((char*)((ng2)));
    t29 = (t0 + 2728);
    xsi_vlogvar_wait_assign_value(t29, t28, 0, 0, 1, 0LL);
    goto LAB27;

}

static void Cont_39_2(char *t0)
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

LAB0:    t1 = (t0 + 4136U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(39, ng0);
    t2 = (t0 + 2568);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng3)));
    xsi_vlogtype_concat(t3, 32, 32, 2U, t6, 24, t5, 8);
    t7 = (t0 + 4816);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t3, 8);
    xsi_driver_vfirst_trans(t7, 0, 31);
    t12 = (t0 + 4720);
    *((int *)t12) = 1;

LAB1:    return;
}

static void Cont_40_3(char *t0)
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

LAB0:    t1 = (t0 + 4384U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(40, ng0);
    t2 = (t0 + 2728);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 4880);
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
    t18 = (t0 + 4736);
    *((int *)t18) = 1;

LAB1:    return;
}


extern void work_m_02894516871952315433_0462906438_init()
{
	static char *pe[] = {(void *)Initial_17_0,(void *)Always_22_1,(void *)Cont_39_2,(void *)Cont_40_3};
	xsi_register_didat("work_m_02894516871952315433_0462906438", "isim/pipelined3_p8_tb_isim_beh.exe.sim/work/m_02894516871952315433_0462906438.didat");
	xsi_register_executes(pe);
}