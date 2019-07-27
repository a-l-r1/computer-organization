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
static const char *ng0 = "Z:/home/a-l-r/co/src/src/datapath/im.v";
static int ng1[] = {0, 0};
static int ng2[] = {64, 0};
static unsigned int ng3[] = {0U, 0U};
static int ng4[] = {1, 0};
static const char *ng5 = "code.hex";
static const char *ng6 = "[time %0d] ";
static const char *ng7 = "im";
static const char *ng8 = ": ";
static const char *ng9 = "enable = %0d, addr = 0x%08x, real_addr = 0x%08x, result = 0x%08x\n";
static unsigned int ng10[] = {1U, 0U};



static void Initial_17_0(char *t0)
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

LAB0:    xsi_set_current_line(17, ng0);

LAB2:    xsi_set_current_line(18, ng0);
    xsi_set_current_line(18, ng0);
    t1 = ((char*)((ng1)));
    t2 = (t0 + 1928);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 32);

LAB3:    t1 = (t0 + 1928);
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

LAB5:    xsi_set_current_line(22, ng0);
    t1 = (t0 + 1768);
    t2 = ((char*)((ng1)));
    xsi_vlogfile_readmemh(ng5, 0, t1, 1, *((unsigned int *)t2), 0, 0);

LAB1:    return;
LAB4:    xsi_set_current_line(18, ng0);

LAB6:    xsi_set_current_line(19, ng0);
    t12 = ((char*)((ng3)));
    t13 = (t0 + 1768);
    t16 = (t0 + 1768);
    t17 = (t16 + 72U);
    t18 = *((char **)t17);
    t19 = (t0 + 1768);
    t20 = (t19 + 64U);
    t21 = *((char **)t20);
    t22 = (t0 + 1928);
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

LAB8:    xsi_set_current_line(18, ng0);
    t1 = (t0 + 1928);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = ((char*)((ng4)));
    memset(t5, 0, 8);
    xsi_vlog_signed_add(t5, 32, t3, 32, t4, 32);
    t6 = (t0 + 1928);
    xsi_vlogvar_assign_value(t6, t5, 0, 0, 32);
    goto LAB3;

LAB7:    t32 = *((unsigned int *)t14);
    t33 = *((unsigned int *)t15);
    t34 = (t32 - t33);
    t35 = (t34 + 1);
    xsi_vlogvar_assign_value(t13, t12, 0, *((unsigned int *)t15), t35);
    goto LAB8;

}

static void Always_27_1(char *t0)
{
    char t4[16];
    char t6[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t7;
    char *t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    char *t16;

LAB0:    t1 = (t0 + 3096U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(27, ng0);
    t2 = (t0 + 3664);
    *((int *)t2) = 1;
    t3 = (t0 + 3128);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(27, ng0);

LAB5:    xsi_set_current_line(29, ng0);
    t5 = xsi_vlog_time(t4, 1000.0000000000000, 1000.0000000000000);
    xsi_vlogfile_write(0, 0, 1, ng6, 2, t0, (char)118, t4, 64);
    xsi_set_current_line(29, ng0);
    xsi_vlogfile_write(0, 0, 1, ng7, 1, t0);
    xsi_set_current_line(29, ng0);
    xsi_vlogfile_write(0, 0, 1, ng8, 1, t0);
    xsi_set_current_line(29, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    t2 = (t0 + 1048U);
    t5 = *((char **)t2);
    t2 = (t0 + 1048U);
    t7 = *((char **)t2);
    memset(t6, 0, 8);
    t2 = (t6 + 4);
    t8 = (t7 + 4);
    t9 = *((unsigned int *)t7);
    t10 = (t9 >> 2);
    *((unsigned int *)t6) = t10;
    t11 = *((unsigned int *)t8);
    t12 = (t11 >> 2);
    *((unsigned int *)t2) = t12;
    t13 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t13 & 63U);
    t14 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t14 & 63U);
    t15 = (t0 + 1368U);
    t16 = *((char **)t15);
    xsi_vlogfile_write(0, 0, 1, ng9, 5, t0, (char)118, t3, 1, (char)118, t5, 32, (char)118, t6, 6, (char)118, t16, 32);
    goto LAB2;

}

static void Cont_32_2(char *t0)
{
    char t3[8];
    char t4[8];
    char t6[8];
    char t36[8];
    char t43[8];
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
    char *t33;
    char *t34;
    char *t35;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t44;
    char *t45;
    char *t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    char *t57;
    char *t58;
    char *t59;
    char *t60;
    char *t61;
    char *t62;
    char *t63;

LAB0:    t1 = (t0 + 3344U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(32, ng0);
    t2 = (t0 + 1208U);
    t5 = *((char **)t2);
    t2 = ((char*)((ng10)));
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

LAB13:    t53 = *((unsigned int *)t4);
    t54 = (~(t53));
    t55 = *((unsigned int *)t29);
    t56 = (t54 || t55);
    if (t56 > 0)
        goto LAB14;

LAB15:    if (*((unsigned int *)t29) > 0)
        goto LAB16;

LAB17:    if (*((unsigned int *)t4) > 0)
        goto LAB18;

LAB19:    memcpy(t3, t57, 8);

LAB20:    t58 = (t0 + 3760);
    t59 = (t58 + 56U);
    t60 = *((char **)t59);
    t61 = (t60 + 56U);
    t62 = *((char **)t61);
    memcpy(t62, t3, 8);
    xsi_driver_vfirst_trans(t58, 0, 31);
    t63 = (t0 + 3680);
    *((int *)t63) = 1;

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

LAB12:    t33 = (t0 + 1768);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    t37 = (t0 + 1768);
    t38 = (t37 + 72U);
    t39 = *((char **)t38);
    t40 = (t0 + 1768);
    t41 = (t40 + 64U);
    t42 = *((char **)t41);
    t44 = (t0 + 1048U);
    t45 = *((char **)t44);
    memset(t43, 0, 8);
    t44 = (t43 + 4);
    t46 = (t45 + 4);
    t47 = *((unsigned int *)t45);
    t48 = (t47 >> 2);
    *((unsigned int *)t43) = t48;
    t49 = *((unsigned int *)t46);
    t50 = (t49 >> 2);
    *((unsigned int *)t44) = t50;
    t51 = *((unsigned int *)t43);
    *((unsigned int *)t43) = (t51 & 63U);
    t52 = *((unsigned int *)t44);
    *((unsigned int *)t44) = (t52 & 63U);
    xsi_vlog_generic_get_array_select_value(t36, 32, t35, t39, t42, 2, 1, t43, 6, 2);
    goto LAB13;

LAB14:    t57 = ((char*)((ng3)));
    goto LAB15;

LAB16:    xsi_vlog_unsigned_bit_combine(t3, 32, t36, 32, t57, 32);
    goto LAB20;

LAB18:    memcpy(t3, t36, 8);
    goto LAB20;

}


extern void work_m_00000000003985029622_3037376393_init()
{
	static char *pe[] = {(void *)Initial_17_0,(void *)Always_27_1,(void *)Cont_32_2};
	xsi_register_didat("work_m_00000000003985029622_3037376393", "isim/single_cycle_tb_isim_beh.exe.sim/work/m_00000000003985029622_3037376393.didat");
	xsi_register_executes(pe);
}
