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
static const char *ng0 = "D:/file/study/2023Autumn/computer_composition/experiment/P1/practice_after_class/P1_L1_vote_plus/VoterPlus.v";
static int ng1[] = {0, 0};
static unsigned int ng2[] = {32U, 0U};
static unsigned int ng3[] = {1U, 0U};
static int ng4[] = {1, 0};
static unsigned int ng5[] = {8U, 0U};
static unsigned int ng6[] = {4U, 0U};
static unsigned int ng7[] = {16U, 0U};
static unsigned int ng8[] = {0U, 0U};



static void Always_34_0(char *t0)
{
    char t6[8];
    char t22[8];
    char t24[8];
    char t57[8];
    char t83[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t23;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    char *t28;
    char *t29;
    char *t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    char *t38;
    char *t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    int t48;
    int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
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
    char *t81;
    char *t82;
    char *t84;

LAB0:    t1 = (t0 + 3648U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(34, ng0);
    t2 = (t0 + 4216);
    *((int *)t2) = 1;
    t3 = (t0 + 3680);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(34, ng0);

LAB5:    xsi_set_current_line(35, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t0 + 2088);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 8);
    xsi_set_current_line(36, ng0);
    xsi_set_current_line(36, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2728);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB6:    t2 = (t0 + 2728);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng2)));
    memset(t6, 0, 8);
    t7 = (t4 + 4);
    if (*((unsigned int *)t7) != 0)
        goto LAB8;

LAB7:    t8 = (t5 + 4);
    if (*((unsigned int *)t8) != 0)
        goto LAB8;

LAB11:    if (*((unsigned int *)t4) < *((unsigned int *)t5))
        goto LAB9;

LAB10:    t10 = (t6 + 4);
    t11 = *((unsigned int *)t10);
    t12 = (~(t11));
    t13 = *((unsigned int *)t6);
    t14 = (t13 & t12);
    t15 = (t14 != 0);
    if (t15 > 0)
        goto LAB12;

LAB13:    xsi_set_current_line(41, ng0);
    xsi_set_current_line(41, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2728);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB26:    t2 = (t0 + 2728);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng5)));
    memset(t6, 0, 8);
    t7 = (t4 + 4);
    if (*((unsigned int *)t7) != 0)
        goto LAB28;

LAB27:    t8 = (t5 + 4);
    if (*((unsigned int *)t8) != 0)
        goto LAB28;

LAB31:    if (*((unsigned int *)t4) < *((unsigned int *)t5))
        goto LAB29;

LAB30:    t10 = (t6 + 4);
    t11 = *((unsigned int *)t10);
    t12 = (~(t11));
    t13 = *((unsigned int *)t6);
    t14 = (t13 & t12);
    t15 = (t14 != 0);
    if (t15 > 0)
        goto LAB32;

LAB33:    xsi_set_current_line(46, ng0);
    t2 = (t0 + 2568);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng3)));
    memset(t6, 0, 8);
    t7 = (t4 + 4);
    t8 = (t5 + 4);
    t11 = *((unsigned int *)t4);
    t12 = *((unsigned int *)t5);
    t13 = (t11 ^ t12);
    t14 = *((unsigned int *)t7);
    t15 = *((unsigned int *)t8);
    t25 = (t14 ^ t15);
    t26 = (t13 | t25);
    t27 = *((unsigned int *)t7);
    t31 = *((unsigned int *)t8);
    t32 = (t27 | t31);
    t33 = (~(t32));
    t34 = (t26 & t33);
    if (t34 != 0)
        goto LAB49;

LAB46:    if (t32 != 0)
        goto LAB48;

LAB47:    *((unsigned int *)t6) = 1;

LAB49:    t10 = (t6 + 4);
    t35 = *((unsigned int *)t10);
    t36 = (~(t35));
    t37 = *((unsigned int *)t6);
    t40 = (t37 & t36);
    t41 = (t40 != 0);
    if (t41 > 0)
        goto LAB50;

LAB51:
LAB52:    goto LAB2;

LAB8:    t9 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB10;

LAB9:    *((unsigned int *)t6) = 1;
    goto LAB10;

LAB12:    xsi_set_current_line(36, ng0);

LAB14:    xsi_set_current_line(37, ng0);
    t16 = (t0 + 2248);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t0 + 2728);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memset(t22, 0, 8);
    xsi_vlog_unsigned_rshift(t22, 32, t18, 32, t21, 32);
    t23 = ((char*)((ng3)));
    t25 = *((unsigned int *)t22);
    t26 = *((unsigned int *)t23);
    t27 = (t25 & t26);
    *((unsigned int *)t24) = t27;
    t28 = (t22 + 4);
    t29 = (t23 + 4);
    t30 = (t24 + 4);
    t31 = *((unsigned int *)t28);
    t32 = *((unsigned int *)t29);
    t33 = (t31 | t32);
    *((unsigned int *)t30) = t33;
    t34 = *((unsigned int *)t30);
    t35 = (t34 != 0);
    if (t35 == 1)
        goto LAB15;

LAB16:
LAB17:    t56 = ((char*)((ng3)));
    memset(t57, 0, 8);
    t58 = (t24 + 4);
    t59 = (t56 + 4);
    t60 = *((unsigned int *)t24);
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
        goto LAB21;

LAB18:    if (t69 != 0)
        goto LAB20;

LAB19:    *((unsigned int *)t57) = 1;

LAB21:    t73 = (t57 + 4);
    t74 = *((unsigned int *)t73);
    t75 = (~(t74));
    t76 = *((unsigned int *)t57);
    t77 = (t76 & t75);
    t78 = (t77 != 0);
    if (t78 > 0)
        goto LAB22;

LAB23:
LAB24:    xsi_set_current_line(36, ng0);
    t2 = (t0 + 2728);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng4)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 2728);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB6;

LAB15:    t36 = *((unsigned int *)t24);
    t37 = *((unsigned int *)t30);
    *((unsigned int *)t24) = (t36 | t37);
    t38 = (t22 + 4);
    t39 = (t23 + 4);
    t40 = *((unsigned int *)t22);
    t41 = (~(t40));
    t42 = *((unsigned int *)t38);
    t43 = (~(t42));
    t44 = *((unsigned int *)t23);
    t45 = (~(t44));
    t46 = *((unsigned int *)t39);
    t47 = (~(t46));
    t48 = (t41 & t43);
    t49 = (t45 & t47);
    t50 = (~(t48));
    t51 = (~(t49));
    t52 = *((unsigned int *)t30);
    *((unsigned int *)t30) = (t52 & t50);
    t53 = *((unsigned int *)t30);
    *((unsigned int *)t30) = (t53 & t51);
    t54 = *((unsigned int *)t24);
    *((unsigned int *)t24) = (t54 & t50);
    t55 = *((unsigned int *)t24);
    *((unsigned int *)t24) = (t55 & t51);
    goto LAB17;

LAB20:    t72 = (t57 + 4);
    *((unsigned int *)t57) = 1;
    *((unsigned int *)t72) = 1;
    goto LAB21;

LAB22:    xsi_set_current_line(37, ng0);

LAB25:    xsi_set_current_line(38, ng0);
    t79 = (t0 + 2088);
    t80 = (t79 + 56U);
    t81 = *((char **)t80);
    t82 = ((char*)((ng3)));
    memset(t83, 0, 8);
    xsi_vlog_unsigned_add(t83, 8, t81, 8, t82, 8);
    t84 = (t0 + 2088);
    xsi_vlogvar_assign_value(t84, t83, 0, 0, 8);
    goto LAB24;

LAB28:    t9 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB30;

LAB29:    *((unsigned int *)t6) = 1;
    goto LAB30;

LAB32:    xsi_set_current_line(41, ng0);

LAB34:    xsi_set_current_line(42, ng0);
    t16 = (t0 + 2408);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t0 + 2728);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memset(t22, 0, 8);
    xsi_vlog_unsigned_rshift(t22, 8, t18, 8, t21, 32);
    t23 = ((char*)((ng3)));
    t25 = *((unsigned int *)t22);
    t26 = *((unsigned int *)t23);
    t27 = (t25 & t26);
    *((unsigned int *)t24) = t27;
    t28 = (t22 + 4);
    t29 = (t23 + 4);
    t30 = (t24 + 4);
    t31 = *((unsigned int *)t28);
    t32 = *((unsigned int *)t29);
    t33 = (t31 | t32);
    *((unsigned int *)t30) = t33;
    t34 = *((unsigned int *)t30);
    t35 = (t34 != 0);
    if (t35 == 1)
        goto LAB35;

LAB36:
LAB37:    t56 = ((char*)((ng3)));
    memset(t57, 0, 8);
    t58 = (t24 + 4);
    t59 = (t56 + 4);
    t60 = *((unsigned int *)t24);
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
        goto LAB41;

LAB38:    if (t69 != 0)
        goto LAB40;

LAB39:    *((unsigned int *)t57) = 1;

LAB41:    t73 = (t57 + 4);
    t74 = *((unsigned int *)t73);
    t75 = (~(t74));
    t76 = *((unsigned int *)t57);
    t77 = (t76 & t75);
    t78 = (t77 != 0);
    if (t78 > 0)
        goto LAB42;

LAB43:
LAB44:    xsi_set_current_line(41, ng0);
    t2 = (t0 + 2728);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng4)));
    memset(t6, 0, 8);
    xsi_vlog_signed_add(t6, 32, t4, 32, t5, 32);
    t7 = (t0 + 2728);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    goto LAB26;

LAB35:    t36 = *((unsigned int *)t24);
    t37 = *((unsigned int *)t30);
    *((unsigned int *)t24) = (t36 | t37);
    t38 = (t22 + 4);
    t39 = (t23 + 4);
    t40 = *((unsigned int *)t22);
    t41 = (~(t40));
    t42 = *((unsigned int *)t38);
    t43 = (~(t42));
    t44 = *((unsigned int *)t23);
    t45 = (~(t44));
    t46 = *((unsigned int *)t39);
    t47 = (~(t46));
    t48 = (t41 & t43);
    t49 = (t45 & t47);
    t50 = (~(t48));
    t51 = (~(t49));
    t52 = *((unsigned int *)t30);
    *((unsigned int *)t30) = (t52 & t50);
    t53 = *((unsigned int *)t30);
    *((unsigned int *)t30) = (t53 & t51);
    t54 = *((unsigned int *)t24);
    *((unsigned int *)t24) = (t54 & t50);
    t55 = *((unsigned int *)t24);
    *((unsigned int *)t24) = (t55 & t51);
    goto LAB37;

LAB40:    t72 = (t57 + 4);
    *((unsigned int *)t57) = 1;
    *((unsigned int *)t72) = 1;
    goto LAB41;

LAB42:    xsi_set_current_line(42, ng0);

LAB45:    xsi_set_current_line(43, ng0);
    t79 = (t0 + 2088);
    t80 = (t79 + 56U);
    t81 = *((char **)t80);
    t82 = ((char*)((ng6)));
    memset(t83, 0, 8);
    xsi_vlog_unsigned_add(t83, 8, t81, 8, t82, 8);
    t84 = (t0 + 2088);
    xsi_vlogvar_assign_value(t84, t83, 0, 0, 8);
    goto LAB44;

LAB48:    t9 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB49;

LAB50:    xsi_set_current_line(46, ng0);

LAB53:    xsi_set_current_line(47, ng0);
    t16 = (t0 + 2088);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = ((char*)((ng7)));
    memset(t22, 0, 8);
    xsi_vlog_unsigned_add(t22, 8, t18, 8, t19, 8);
    t20 = (t0 + 2088);
    xsi_vlogvar_assign_value(t20, t22, 0, 0, 8);
    goto LAB52;

}

static void Always_51_1(char *t0)
{
    char t6[8];
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
    int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;

LAB0:    t1 = (t0 + 3896U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(51, ng0);
    t2 = (t0 + 4232);
    *((int *)t2) = 1;
    t3 = (t0 + 3928);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(51, ng0);

LAB5:    xsi_set_current_line(52, ng0);
    t4 = (t0 + 1208U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng3)));
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

LAB11:    xsi_set_current_line(57, ng0);

LAB14:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 2248);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 1368U);
    t7 = *((char **)t5);
    t9 = *((unsigned int *)t4);
    t10 = *((unsigned int *)t7);
    t11 = (t9 | t10);
    *((unsigned int *)t6) = t11;
    t5 = (t4 + 4);
    t8 = (t7 + 4);
    t21 = (t6 + 4);
    t12 = *((unsigned int *)t5);
    t13 = *((unsigned int *)t8);
    t14 = (t12 | t13);
    *((unsigned int *)t21) = t14;
    t15 = *((unsigned int *)t21);
    t16 = (t15 != 0);
    if (t16 == 1)
        goto LAB15;

LAB16:
LAB17:    t29 = (t0 + 2248);
    xsi_vlogvar_wait_assign_value(t29, t6, 0, 0, 32, 0LL);
    xsi_set_current_line(59, ng0);
    t2 = (t0 + 2408);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 1528U);
    t7 = *((char **)t5);
    t9 = *((unsigned int *)t4);
    t10 = *((unsigned int *)t7);
    t11 = (t9 | t10);
    *((unsigned int *)t6) = t11;
    t5 = (t4 + 4);
    t8 = (t7 + 4);
    t21 = (t6 + 4);
    t12 = *((unsigned int *)t5);
    t13 = *((unsigned int *)t8);
    t14 = (t12 | t13);
    *((unsigned int *)t21) = t14;
    t15 = *((unsigned int *)t21);
    t16 = (t15 != 0);
    if (t16 == 1)
        goto LAB18;

LAB19:
LAB20:    t29 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t29, t6, 0, 0, 8, 0LL);
    xsi_set_current_line(60, ng0);
    t2 = (t0 + 2568);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 1688U);
    t7 = *((char **)t5);
    t9 = *((unsigned int *)t4);
    t10 = *((unsigned int *)t7);
    t11 = (t9 | t10);
    *((unsigned int *)t6) = t11;
    t5 = (t4 + 4);
    t8 = (t7 + 4);
    t21 = (t6 + 4);
    t12 = *((unsigned int *)t5);
    t13 = *((unsigned int *)t8);
    t14 = (t12 | t13);
    *((unsigned int *)t21) = t14;
    t15 = *((unsigned int *)t21);
    t16 = (t15 != 0);
    if (t16 == 1)
        goto LAB21;

LAB22:
LAB23:    t29 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t29, t6, 0, 0, 1, 0LL);

LAB12:    goto LAB2;

LAB8:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(52, ng0);

LAB13:    xsi_set_current_line(53, ng0);
    t28 = ((char*)((ng8)));
    t29 = (t0 + 2248);
    xsi_vlogvar_wait_assign_value(t29, t28, 0, 0, 32, 0LL);
    xsi_set_current_line(54, ng0);
    t2 = ((char*)((ng8)));
    t3 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 8, 0LL);
    xsi_set_current_line(55, ng0);
    t2 = ((char*)((ng8)));
    t3 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB12;

LAB15:    t17 = *((unsigned int *)t6);
    t18 = *((unsigned int *)t21);
    *((unsigned int *)t6) = (t17 | t18);
    t22 = (t4 + 4);
    t28 = (t7 + 4);
    t19 = *((unsigned int *)t22);
    t20 = (~(t19));
    t23 = *((unsigned int *)t4);
    t30 = (t23 & t20);
    t24 = *((unsigned int *)t28);
    t25 = (~(t24));
    t26 = *((unsigned int *)t7);
    t31 = (t26 & t25);
    t27 = (~(t30));
    t32 = (~(t31));
    t33 = *((unsigned int *)t21);
    *((unsigned int *)t21) = (t33 & t27);
    t34 = *((unsigned int *)t21);
    *((unsigned int *)t21) = (t34 & t32);
    goto LAB17;

LAB18:    t17 = *((unsigned int *)t6);
    t18 = *((unsigned int *)t21);
    *((unsigned int *)t6) = (t17 | t18);
    t22 = (t4 + 4);
    t28 = (t7 + 4);
    t19 = *((unsigned int *)t22);
    t20 = (~(t19));
    t23 = *((unsigned int *)t4);
    t30 = (t23 & t20);
    t24 = *((unsigned int *)t28);
    t25 = (~(t24));
    t26 = *((unsigned int *)t7);
    t31 = (t26 & t25);
    t27 = (~(t30));
    t32 = (~(t31));
    t33 = *((unsigned int *)t21);
    *((unsigned int *)t21) = (t33 & t27);
    t34 = *((unsigned int *)t21);
    *((unsigned int *)t21) = (t34 & t32);
    goto LAB20;

LAB21:    t17 = *((unsigned int *)t6);
    t18 = *((unsigned int *)t21);
    *((unsigned int *)t6) = (t17 | t18);
    t22 = (t4 + 4);
    t28 = (t7 + 4);
    t19 = *((unsigned int *)t22);
    t20 = (~(t19));
    t23 = *((unsigned int *)t4);
    t30 = (t23 & t20);
    t24 = *((unsigned int *)t28);
    t25 = (~(t24));
    t26 = *((unsigned int *)t7);
    t31 = (t26 & t25);
    t27 = (~(t30));
    t32 = (~(t31));
    t33 = *((unsigned int *)t21);
    *((unsigned int *)t21) = (t33 & t27);
    t34 = *((unsigned int *)t21);
    *((unsigned int *)t21) = (t34 & t32);
    goto LAB23;

}


extern void work_m_00000000003904471726_1990751517_init()
{
	static char *pe[] = {(void *)Always_34_0,(void *)Always_51_1};
	xsi_register_didat("work_m_00000000003904471726_1990751517", "isim/VoterPlus_tb_isim_beh.exe.sim/work/m_00000000003904471726_1990751517.didat");
	xsi_register_executes(pe);
}
