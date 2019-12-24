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
static const char *ng0 = "/home/a-l-r/co/src/src/datapath/mmu.v";
static unsigned int ng1[] = {0U, 0U};
static unsigned int ng2[] = {1U, 0U};



static void Cont_53_0(char *t0)
{
    char t3[8];
    char t4[8];
    char t13[8];
    char t14[8];
    char t17[8];
    char t26[8];
    char t53[8];
    char t67[8];
    char t68[8];
    char t71[8];
    char t80[8];
    char t107[8];
    char *t1;
    char *t2;
    char *t5;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t15;
    char *t16;
    char *t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    char *t25;
    char *t27;
    char *t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    char *t41;
    char *t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    char *t48;
    char *t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
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
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    char *t69;
    char *t70;
    char *t72;
    unsigned int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    char *t79;
    char *t81;
    char *t82;
    unsigned int t83;
    unsigned int t84;
    unsigned int t85;
    unsigned int t86;
    unsigned int t87;
    unsigned int t88;
    unsigned int t89;
    unsigned int t90;
    unsigned int t91;
    unsigned int t92;
    unsigned int t93;
    unsigned int t94;
    char *t95;
    char *t96;
    unsigned int t97;
    unsigned int t98;
    unsigned int t99;
    unsigned int t100;
    unsigned int t101;
    char *t102;
    char *t103;
    unsigned int t104;
    unsigned int t105;
    unsigned int t106;
    char *t108;
    char *t109;
    char *t110;
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
    char *t123;
    char *t124;
    char *t125;
    char *t126;
    char *t127;

LAB0:    t1 = (t0 + 2840U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(53, ng0);
    t2 = (t0 + 1048U);
    t5 = *((char **)t2);
    memset(t4, 0, 8);
    t2 = (t4 + 4);
    t6 = (t5 + 4);
    t7 = *((unsigned int *)t5);
    t8 = (t7 >> 0);
    *((unsigned int *)t4) = t8;
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t2) = t10;
    t11 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t11 & 4095U);
    t12 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t12 & 4095U);
    t15 = (t0 + 1048U);
    t16 = *((char **)t15);
    memset(t17, 0, 8);
    t15 = (t17 + 4);
    t18 = (t16 + 4);
    t19 = *((unsigned int *)t16);
    t20 = (t19 >> 12);
    t21 = (t20 & 1);
    *((unsigned int *)t17) = t21;
    t22 = *((unsigned int *)t18);
    t23 = (t22 >> 12);
    t24 = (t23 & 1);
    *((unsigned int *)t15) = t24;
    t25 = ((char*)((ng1)));
    memset(t26, 0, 8);
    t27 = (t17 + 4);
    t28 = (t25 + 4);
    t29 = *((unsigned int *)t17);
    t30 = *((unsigned int *)t25);
    t31 = (t29 ^ t30);
    t32 = *((unsigned int *)t27);
    t33 = *((unsigned int *)t28);
    t34 = (t32 ^ t33);
    t35 = (t31 | t34);
    t36 = *((unsigned int *)t27);
    t37 = *((unsigned int *)t28);
    t38 = (t36 | t37);
    t39 = (~(t38));
    t40 = (t35 & t39);
    if (t40 != 0)
        goto LAB7;

LAB4:    if (t38 != 0)
        goto LAB6;

LAB5:    *((unsigned int *)t26) = 1;

LAB7:    memset(t14, 0, 8);
    t42 = (t26 + 4);
    t43 = *((unsigned int *)t42);
    t44 = (~(t43));
    t45 = *((unsigned int *)t26);
    t46 = (t45 & t44);
    t47 = (t46 & 1U);
    if (t47 != 0)
        goto LAB8;

LAB9:    if (*((unsigned int *)t42) != 0)
        goto LAB10;

LAB11:    t49 = (t14 + 4);
    t50 = *((unsigned int *)t14);
    t51 = *((unsigned int *)t49);
    t52 = (t50 || t51);
    if (t52 > 0)
        goto LAB12;

LAB13:    t63 = *((unsigned int *)t14);
    t64 = (~(t63));
    t65 = *((unsigned int *)t49);
    t66 = (t64 || t65);
    if (t66 > 0)
        goto LAB14;

LAB15:    if (*((unsigned int *)t49) > 0)
        goto LAB16;

LAB17:    if (*((unsigned int *)t14) > 0)
        goto LAB18;

LAB19:    memcpy(t13, t67, 8);

LAB20:    xsi_vlogtype_concat(t3, 32, 32, 2U, t13, 20, t4, 12);
    t122 = (t0 + 3240);
    t123 = (t122 + 56U);
    t124 = *((char **)t123);
    t125 = (t124 + 56U);
    t126 = *((char **)t125);
    memcpy(t126, t3, 8);
    xsi_driver_vfirst_trans(t122, 0, 31);
    t127 = (t0 + 3160);
    *((int *)t127) = 1;

LAB1:    return;
LAB6:    t41 = (t26 + 4);
    *((unsigned int *)t26) = 1;
    *((unsigned int *)t41) = 1;
    goto LAB7;

LAB8:    *((unsigned int *)t14) = 1;
    goto LAB11;

LAB10:    t48 = (t14 + 4);
    *((unsigned int *)t14) = 1;
    *((unsigned int *)t48) = 1;
    goto LAB11;

LAB12:    t54 = (t0 + 1528U);
    t55 = *((char **)t54);
    memset(t53, 0, 8);
    t54 = (t53 + 4);
    t56 = (t55 + 4);
    t57 = *((unsigned int *)t55);
    t58 = (t57 >> 6);
    *((unsigned int *)t53) = t58;
    t59 = *((unsigned int *)t56);
    t60 = (t59 >> 6);
    *((unsigned int *)t54) = t60;
    t61 = *((unsigned int *)t53);
    *((unsigned int *)t53) = (t61 & 1048575U);
    t62 = *((unsigned int *)t54);
    *((unsigned int *)t54) = (t62 & 1048575U);
    goto LAB13;

LAB14:    t69 = (t0 + 1048U);
    t70 = *((char **)t69);
    memset(t71, 0, 8);
    t69 = (t71 + 4);
    t72 = (t70 + 4);
    t73 = *((unsigned int *)t70);
    t74 = (t73 >> 12);
    t75 = (t74 & 1);
    *((unsigned int *)t71) = t75;
    t76 = *((unsigned int *)t72);
    t77 = (t76 >> 12);
    t78 = (t77 & 1);
    *((unsigned int *)t69) = t78;
    t79 = ((char*)((ng2)));
    memset(t80, 0, 8);
    t81 = (t71 + 4);
    t82 = (t79 + 4);
    t83 = *((unsigned int *)t71);
    t84 = *((unsigned int *)t79);
    t85 = (t83 ^ t84);
    t86 = *((unsigned int *)t81);
    t87 = *((unsigned int *)t82);
    t88 = (t86 ^ t87);
    t89 = (t85 | t88);
    t90 = *((unsigned int *)t81);
    t91 = *((unsigned int *)t82);
    t92 = (t90 | t91);
    t93 = (~(t92));
    t94 = (t89 & t93);
    if (t94 != 0)
        goto LAB24;

LAB21:    if (t92 != 0)
        goto LAB23;

LAB22:    *((unsigned int *)t80) = 1;

LAB24:    memset(t68, 0, 8);
    t96 = (t80 + 4);
    t97 = *((unsigned int *)t96);
    t98 = (~(t97));
    t99 = *((unsigned int *)t80);
    t100 = (t99 & t98);
    t101 = (t100 & 1U);
    if (t101 != 0)
        goto LAB25;

LAB26:    if (*((unsigned int *)t96) != 0)
        goto LAB27;

LAB28:    t103 = (t68 + 4);
    t104 = *((unsigned int *)t68);
    t105 = *((unsigned int *)t103);
    t106 = (t104 || t105);
    if (t106 > 0)
        goto LAB29;

LAB30:    t117 = *((unsigned int *)t68);
    t118 = (~(t117));
    t119 = *((unsigned int *)t103);
    t120 = (t118 || t119);
    if (t120 > 0)
        goto LAB31;

LAB32:    if (*((unsigned int *)t103) > 0)
        goto LAB33;

LAB34:    if (*((unsigned int *)t68) > 0)
        goto LAB35;

LAB36:    memcpy(t67, t121, 8);

LAB37:    goto LAB15;

LAB16:    xsi_vlog_unsigned_bit_combine(t13, 20, t53, 20, t67, 20);
    goto LAB20;

LAB18:    memcpy(t13, t53, 8);
    goto LAB20;

LAB23:    t95 = (t80 + 4);
    *((unsigned int *)t80) = 1;
    *((unsigned int *)t95) = 1;
    goto LAB24;

LAB25:    *((unsigned int *)t68) = 1;
    goto LAB28;

LAB27:    t102 = (t68 + 4);
    *((unsigned int *)t68) = 1;
    *((unsigned int *)t102) = 1;
    goto LAB28;

LAB29:    t108 = (t0 + 1368U);
    t109 = *((char **)t108);
    memset(t107, 0, 8);
    t108 = (t107 + 4);
    t110 = (t109 + 4);
    t111 = *((unsigned int *)t109);
    t112 = (t111 >> 6);
    *((unsigned int *)t107) = t112;
    t113 = *((unsigned int *)t110);
    t114 = (t113 >> 6);
    *((unsigned int *)t108) = t114;
    t115 = *((unsigned int *)t107);
    *((unsigned int *)t107) = (t115 & 1048575U);
    t116 = *((unsigned int *)t108);
    *((unsigned int *)t108) = (t116 & 1048575U);
    goto LAB30;

LAB31:    t121 = ((char*)((ng1)));
    goto LAB32;

LAB33:    xsi_vlog_unsigned_bit_combine(t67, 20, t107, 20, t121, 20);
    goto LAB37;

LAB35:    memcpy(t67, t107, 8);
    goto LAB37;

}


extern void work_m_01002339564829849650_0030350946_init()
{
	static char *pe[] = {(void *)Cont_53_0};
	xsi_register_didat("work_m_01002339564829849650_0030350946", "isim/pipelined3_p8_tb_isim_beh.exe.sim/work/m_01002339564829849650_0030350946.didat");
	xsi_register_executes(pe);
}
