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
static const char *ng0 = "D:/file/study/2023Autumn/computer_composition/experiment/P1/practice_after_class/P1_L7_expr/string2.v";
static unsigned int ng1[] = {2U, 0U};
static unsigned int ng2[] = {1U, 0U};
static unsigned int ng3[] = {0U, 0U};
static int ng4[] = {48, 0};
static int ng5[] = {57, 0};
static int ng6[] = {40, 0};
static unsigned int ng7[] = {4U, 0U};
static int ng8[] = {43, 0};
static int ng9[] = {42, 0};
static unsigned int ng10[] = {3U, 0U};
static unsigned int ng11[] = {5U, 0U};
static int ng12[] = {41, 0};
static unsigned int ng13[] = {6U, 0U};



static void Cont_29_0(char *t0)
{
    char t3[8];
    char t4[8];
    char t8[8];
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
    char *t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    unsigned int t46;
    unsigned int t47;
    char *t48;
    unsigned int t49;
    unsigned int t50;
    char *t51;
    unsigned int t52;
    unsigned int t53;
    char *t54;

LAB0:    t1 = (t0 + 2848U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(29, ng0);
    t2 = (t0 + 1928);
    t5 = (t2 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng1)));
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

LAB13:    t36 = *((unsigned int *)t4);
    t37 = (~(t36));
    t38 = *((unsigned int *)t31);
    t39 = (t37 || t38);
    if (t39 > 0)
        goto LAB14;

LAB15:    if (*((unsigned int *)t31) > 0)
        goto LAB16;

LAB17:    if (*((unsigned int *)t4) > 0)
        goto LAB18;

LAB19:    memcpy(t3, t40, 8);

LAB20:    t41 = (t0 + 3512);
    t42 = (t41 + 56U);
    t43 = *((char **)t42);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    memset(t45, 0, 8);
    t46 = 1U;
    t47 = t46;
    t48 = (t3 + 4);
    t49 = *((unsigned int *)t3);
    t46 = (t46 & t49);
    t50 = *((unsigned int *)t48);
    t47 = (t47 & t50);
    t51 = (t45 + 4);
    t52 = *((unsigned int *)t45);
    *((unsigned int *)t45) = (t52 | t46);
    t53 = *((unsigned int *)t51);
    *((unsigned int *)t51) = (t53 | t47);
    xsi_driver_vfirst_trans(t41, 0, 0);
    t54 = (t0 + 3416);
    *((int *)t54) = 1;

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

LAB12:    t35 = ((char*)((ng2)));
    goto LAB13;

LAB14:    t40 = ((char*)((ng3)));
    goto LAB15;

LAB16:    xsi_vlog_unsigned_bit_combine(t3, 1, t35, 1, t40, 1);
    goto LAB20;

LAB18:    memcpy(t3, t35, 8);
    goto LAB20;

}

static void Always_30_1(char *t0)
{
    char t6[8];
    char t31[8];
    char t36[8];
    char t40[8];
    char t43[8];
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
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t37;
    char *t38;
    char *t39;
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
    char *t53;
    char *t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    int t63;
    int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    char *t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    char *t77;
    char *t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
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
    unsigned int t95;
    unsigned int t96;
    unsigned int t97;
    unsigned int t98;
    unsigned int t99;

LAB0:    t1 = (t0 + 3096U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(30, ng0);
    t2 = (t0 + 3432);
    *((int *)t2) = 1;
    t3 = (t0 + 3128);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(30, ng0);

LAB5:    xsi_set_current_line(31, ng0);
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

LAB11:    xsi_set_current_line(34, ng0);

LAB14:    xsi_set_current_line(35, ng0);
    t2 = (t0 + 1928);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);

LAB15:    t5 = ((char*)((ng3)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t5, 3);
    if (t30 == 1)
        goto LAB16;

LAB17:    t2 = ((char*)((ng2)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t30 == 1)
        goto LAB18;

LAB19:    t2 = ((char*)((ng1)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t30 == 1)
        goto LAB20;

LAB21:    t2 = ((char*)((ng10)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t30 == 1)
        goto LAB22;

LAB23:    t2 = ((char*)((ng7)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t30 == 1)
        goto LAB24;

LAB25:    t2 = ((char*)((ng11)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t30 == 1)
        goto LAB26;

LAB27:    t2 = ((char*)((ng13)));
    t30 = xsi_vlog_unsigned_case_compare(t4, 3, t2, 3);
    if (t30 == 1)
        goto LAB28;

LAB29:
LAB31:
LAB30:    xsi_set_current_line(97, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);

LAB32:
LAB12:    goto LAB2;

LAB8:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(31, ng0);

LAB13:    xsi_set_current_line(32, ng0);
    t28 = ((char*)((ng3)));
    t29 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t29, t28, 0, 0, 3, 0LL);
    goto LAB12;

LAB16:    xsi_set_current_line(36, ng0);

LAB33:    xsi_set_current_line(37, ng0);
    t7 = (t0 + 1368U);
    t8 = *((char **)t7);
    t7 = ((char*)((ng4)));
    memset(t6, 0, 8);
    t21 = (t8 + 4);
    if (*((unsigned int *)t21) != 0)
        goto LAB35;

LAB34:    t22 = (t7 + 4);
    if (*((unsigned int *)t22) != 0)
        goto LAB35;

LAB38:    if (*((unsigned int *)t8) < *((unsigned int *)t7))
        goto LAB37;

LAB36:    *((unsigned int *)t6) = 1;

LAB37:    memset(t31, 0, 8);
    t29 = (t6 + 4);
    t9 = *((unsigned int *)t29);
    t10 = (~(t9));
    t11 = *((unsigned int *)t6);
    t12 = (t11 & t10);
    t13 = (t12 & 1U);
    if (t13 != 0)
        goto LAB39;

LAB40:    if (*((unsigned int *)t29) != 0)
        goto LAB41;

LAB42:    t33 = (t31 + 4);
    t14 = *((unsigned int *)t31);
    t15 = *((unsigned int *)t33);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB43;

LAB44:    memcpy(t43, t31, 8);

LAB45:    t71 = (t43 + 4);
    t72 = *((unsigned int *)t71);
    t73 = (~(t72));
    t74 = *((unsigned int *)t43);
    t75 = (t74 & t73);
    t76 = (t75 != 0);
    if (t76 > 0)
        goto LAB58;

LAB59:    xsi_set_current_line(40, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng6)));
    memset(t6, 0, 8);
    t5 = (t3 + 4);
    t7 = (t2 + 4);
    t9 = *((unsigned int *)t3);
    t10 = *((unsigned int *)t2);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t5);
    t13 = *((unsigned int *)t7);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t5);
    t17 = *((unsigned int *)t7);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB65;

LAB62:    if (t18 != 0)
        goto LAB64;

LAB63:    *((unsigned int *)t6) = 1;

LAB65:    t21 = (t6 + 4);
    t23 = *((unsigned int *)t21);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB66;

LAB67:    xsi_set_current_line(43, ng0);

LAB70:    xsi_set_current_line(44, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);

LAB68:
LAB60:    goto LAB32;

LAB18:    xsi_set_current_line(47, ng0);

LAB71:    xsi_set_current_line(48, ng0);
    t3 = (t0 + 1928);
    t5 = (t3 + 56U);
    t7 = *((char **)t5);
    t8 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t8, t7, 0, 0, 3, 0LL);
    goto LAB32;

LAB20:    xsi_set_current_line(50, ng0);

LAB72:    xsi_set_current_line(51, ng0);
    t3 = (t0 + 1368U);
    t5 = *((char **)t3);
    t3 = ((char*)((ng8)));
    memset(t6, 0, 8);
    t7 = (t5 + 4);
    t8 = (t3 + 4);
    t9 = *((unsigned int *)t5);
    t10 = *((unsigned int *)t3);
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
        goto LAB76;

LAB73:    if (t18 != 0)
        goto LAB75;

LAB74:    *((unsigned int *)t6) = 1;

LAB76:    memset(t31, 0, 8);
    t22 = (t6 + 4);
    t23 = *((unsigned int *)t22);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 & 1U);
    if (t27 != 0)
        goto LAB77;

LAB78:    if (*((unsigned int *)t22) != 0)
        goto LAB79;

LAB80:    t29 = (t31 + 4);
    t47 = *((unsigned int *)t31);
    t48 = (!(t47));
    t49 = *((unsigned int *)t29);
    t50 = (t48 || t49);
    if (t50 > 0)
        goto LAB81;

LAB82:    memcpy(t43, t31, 8);

LAB83:    t53 = (t43 + 4);
    t95 = *((unsigned int *)t53);
    t96 = (~(t95));
    t97 = *((unsigned int *)t43);
    t98 = (t97 & t96);
    t99 = (t98 != 0);
    if (t99 > 0)
        goto LAB95;

LAB96:    xsi_set_current_line(54, ng0);

LAB99:    xsi_set_current_line(55, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);

LAB97:    goto LAB32;

LAB22:    xsi_set_current_line(58, ng0);

LAB100:    xsi_set_current_line(59, ng0);
    t3 = (t0 + 1368U);
    t5 = *((char **)t3);
    t3 = ((char*)((ng4)));
    memset(t6, 0, 8);
    t7 = (t5 + 4);
    if (*((unsigned int *)t7) != 0)
        goto LAB102;

LAB101:    t8 = (t3 + 4);
    if (*((unsigned int *)t8) != 0)
        goto LAB102;

LAB105:    if (*((unsigned int *)t5) < *((unsigned int *)t3))
        goto LAB104;

LAB103:    *((unsigned int *)t6) = 1;

LAB104:    memset(t31, 0, 8);
    t22 = (t6 + 4);
    t9 = *((unsigned int *)t22);
    t10 = (~(t9));
    t11 = *((unsigned int *)t6);
    t12 = (t11 & t10);
    t13 = (t12 & 1U);
    if (t13 != 0)
        goto LAB106;

LAB107:    if (*((unsigned int *)t22) != 0)
        goto LAB108;

LAB109:    t29 = (t31 + 4);
    t14 = *((unsigned int *)t31);
    t15 = *((unsigned int *)t29);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB110;

LAB111:    memcpy(t43, t31, 8);

LAB112:    t53 = (t43 + 4);
    t72 = *((unsigned int *)t53);
    t73 = (~(t72));
    t74 = *((unsigned int *)t43);
    t75 = (t74 & t73);
    t76 = (t75 != 0);
    if (t76 > 0)
        goto LAB125;

LAB126:    xsi_set_current_line(62, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng6)));
    memset(t6, 0, 8);
    t5 = (t3 + 4);
    t7 = (t2 + 4);
    t9 = *((unsigned int *)t3);
    t10 = *((unsigned int *)t2);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t5);
    t13 = *((unsigned int *)t7);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t5);
    t17 = *((unsigned int *)t7);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB132;

LAB129:    if (t18 != 0)
        goto LAB131;

LAB130:    *((unsigned int *)t6) = 1;

LAB132:    t21 = (t6 + 4);
    t23 = *((unsigned int *)t21);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB133;

LAB134:    xsi_set_current_line(65, ng0);

LAB137:    xsi_set_current_line(66, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);

LAB135:
LAB127:    goto LAB32;

LAB24:    xsi_set_current_line(70, ng0);

LAB138:    xsi_set_current_line(71, ng0);
    t3 = (t0 + 1368U);
    t5 = *((char **)t3);
    t3 = ((char*)((ng4)));
    memset(t6, 0, 8);
    t7 = (t5 + 4);
    if (*((unsigned int *)t7) != 0)
        goto LAB140;

LAB139:    t8 = (t3 + 4);
    if (*((unsigned int *)t8) != 0)
        goto LAB140;

LAB143:    if (*((unsigned int *)t5) < *((unsigned int *)t3))
        goto LAB142;

LAB141:    *((unsigned int *)t6) = 1;

LAB142:    memset(t31, 0, 8);
    t22 = (t6 + 4);
    t9 = *((unsigned int *)t22);
    t10 = (~(t9));
    t11 = *((unsigned int *)t6);
    t12 = (t11 & t10);
    t13 = (t12 & 1U);
    if (t13 != 0)
        goto LAB144;

LAB145:    if (*((unsigned int *)t22) != 0)
        goto LAB146;

LAB147:    t29 = (t31 + 4);
    t14 = *((unsigned int *)t31);
    t15 = *((unsigned int *)t29);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB148;

LAB149:    memcpy(t43, t31, 8);

LAB150:    t53 = (t43 + 4);
    t72 = *((unsigned int *)t53);
    t73 = (~(t72));
    t74 = *((unsigned int *)t43);
    t75 = (t74 & t73);
    t76 = (t75 != 0);
    if (t76 > 0)
        goto LAB163;

LAB164:    xsi_set_current_line(74, ng0);

LAB167:    xsi_set_current_line(75, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);

LAB165:    goto LAB32;

LAB26:    xsi_set_current_line(78, ng0);

LAB168:    xsi_set_current_line(79, ng0);
    t3 = (t0 + 1368U);
    t5 = *((char **)t3);
    t3 = ((char*)((ng12)));
    memset(t6, 0, 8);
    t7 = (t5 + 4);
    t8 = (t3 + 4);
    t9 = *((unsigned int *)t5);
    t10 = *((unsigned int *)t3);
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
        goto LAB172;

LAB169:    if (t18 != 0)
        goto LAB171;

LAB170:    *((unsigned int *)t6) = 1;

LAB172:    t22 = (t6 + 4);
    t23 = *((unsigned int *)t22);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB173;

LAB174:    xsi_set_current_line(82, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng8)));
    memset(t6, 0, 8);
    t5 = (t3 + 4);
    t7 = (t2 + 4);
    t9 = *((unsigned int *)t3);
    t10 = *((unsigned int *)t2);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t5);
    t13 = *((unsigned int *)t7);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t5);
    t17 = *((unsigned int *)t7);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB180;

LAB177:    if (t18 != 0)
        goto LAB179;

LAB178:    *((unsigned int *)t6) = 1;

LAB180:    memset(t31, 0, 8);
    t21 = (t6 + 4);
    t23 = *((unsigned int *)t21);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 & 1U);
    if (t27 != 0)
        goto LAB181;

LAB182:    if (*((unsigned int *)t21) != 0)
        goto LAB183;

LAB184:    t28 = (t31 + 4);
    t47 = *((unsigned int *)t31);
    t48 = (!(t47));
    t49 = *((unsigned int *)t28);
    t50 = (t48 || t49);
    if (t50 > 0)
        goto LAB185;

LAB186:    memcpy(t43, t31, 8);

LAB187:    t46 = (t43 + 4);
    t95 = *((unsigned int *)t46);
    t96 = (~(t95));
    t97 = *((unsigned int *)t43);
    t98 = (t97 & t96);
    t99 = (t98 != 0);
    if (t99 > 0)
        goto LAB199;

LAB200:    xsi_set_current_line(85, ng0);

LAB203:    xsi_set_current_line(86, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);

LAB201:
LAB175:    goto LAB32;

LAB28:    xsi_set_current_line(89, ng0);

LAB204:    xsi_set_current_line(90, ng0);
    t3 = (t0 + 1368U);
    t5 = *((char **)t3);
    t3 = ((char*)((ng4)));
    memset(t6, 0, 8);
    t7 = (t5 + 4);
    if (*((unsigned int *)t7) != 0)
        goto LAB206;

LAB205:    t8 = (t3 + 4);
    if (*((unsigned int *)t8) != 0)
        goto LAB206;

LAB209:    if (*((unsigned int *)t5) < *((unsigned int *)t3))
        goto LAB208;

LAB207:    *((unsigned int *)t6) = 1;

LAB208:    memset(t31, 0, 8);
    t22 = (t6 + 4);
    t9 = *((unsigned int *)t22);
    t10 = (~(t9));
    t11 = *((unsigned int *)t6);
    t12 = (t11 & t10);
    t13 = (t12 & 1U);
    if (t13 != 0)
        goto LAB210;

LAB211:    if (*((unsigned int *)t22) != 0)
        goto LAB212;

LAB213:    t29 = (t31 + 4);
    t14 = *((unsigned int *)t31);
    t15 = *((unsigned int *)t29);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB214;

LAB215:    memcpy(t43, t31, 8);

LAB216:    t53 = (t43 + 4);
    t72 = *((unsigned int *)t53);
    t73 = (~(t72));
    t74 = *((unsigned int *)t43);
    t75 = (t74 & t73);
    t76 = (t75 != 0);
    if (t76 > 0)
        goto LAB229;

LAB230:    xsi_set_current_line(93, ng0);

LAB233:    xsi_set_current_line(94, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 3, 0LL);

LAB231:    goto LAB32;

LAB35:    t28 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t28) = 1;
    goto LAB37;

LAB39:    *((unsigned int *)t31) = 1;
    goto LAB42;

LAB41:    t32 = (t31 + 4);
    *((unsigned int *)t31) = 1;
    *((unsigned int *)t32) = 1;
    goto LAB42;

LAB43:    t34 = (t0 + 1368U);
    t35 = *((char **)t34);
    t34 = ((char*)((ng5)));
    memset(t36, 0, 8);
    t37 = (t35 + 4);
    if (*((unsigned int *)t37) != 0)
        goto LAB47;

LAB46:    t38 = (t34 + 4);
    if (*((unsigned int *)t38) != 0)
        goto LAB47;

LAB50:    if (*((unsigned int *)t35) > *((unsigned int *)t34))
        goto LAB49;

LAB48:    *((unsigned int *)t36) = 1;

LAB49:    memset(t40, 0, 8);
    t41 = (t36 + 4);
    t17 = *((unsigned int *)t41);
    t18 = (~(t17));
    t19 = *((unsigned int *)t36);
    t20 = (t19 & t18);
    t23 = (t20 & 1U);
    if (t23 != 0)
        goto LAB51;

LAB52:    if (*((unsigned int *)t41) != 0)
        goto LAB53;

LAB54:    t24 = *((unsigned int *)t31);
    t25 = *((unsigned int *)t40);
    t26 = (t24 & t25);
    *((unsigned int *)t43) = t26;
    t44 = (t31 + 4);
    t45 = (t40 + 4);
    t46 = (t43 + 4);
    t27 = *((unsigned int *)t44);
    t47 = *((unsigned int *)t45);
    t48 = (t27 | t47);
    *((unsigned int *)t46) = t48;
    t49 = *((unsigned int *)t46);
    t50 = (t49 != 0);
    if (t50 == 1)
        goto LAB55;

LAB56:
LAB57:    goto LAB45;

LAB47:    t39 = (t36 + 4);
    *((unsigned int *)t36) = 1;
    *((unsigned int *)t39) = 1;
    goto LAB49;

LAB51:    *((unsigned int *)t40) = 1;
    goto LAB54;

LAB53:    t42 = (t40 + 4);
    *((unsigned int *)t40) = 1;
    *((unsigned int *)t42) = 1;
    goto LAB54;

LAB55:    t51 = *((unsigned int *)t43);
    t52 = *((unsigned int *)t46);
    *((unsigned int *)t43) = (t51 | t52);
    t53 = (t31 + 4);
    t54 = (t40 + 4);
    t55 = *((unsigned int *)t31);
    t56 = (~(t55));
    t57 = *((unsigned int *)t53);
    t58 = (~(t57));
    t59 = *((unsigned int *)t40);
    t60 = (~(t59));
    t61 = *((unsigned int *)t54);
    t62 = (~(t61));
    t63 = (t56 & t58);
    t64 = (t60 & t62);
    t65 = (~(t63));
    t66 = (~(t64));
    t67 = *((unsigned int *)t46);
    *((unsigned int *)t46) = (t67 & t65);
    t68 = *((unsigned int *)t46);
    *((unsigned int *)t46) = (t68 & t66);
    t69 = *((unsigned int *)t43);
    *((unsigned int *)t43) = (t69 & t65);
    t70 = *((unsigned int *)t43);
    *((unsigned int *)t43) = (t70 & t66);
    goto LAB57;

LAB58:    xsi_set_current_line(37, ng0);

LAB61:    xsi_set_current_line(38, ng0);
    t77 = ((char*)((ng1)));
    t78 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t78, t77, 0, 0, 3, 0LL);
    goto LAB60;

LAB64:    t8 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t8) = 1;
    goto LAB65;

LAB66:    xsi_set_current_line(40, ng0);

LAB69:    xsi_set_current_line(41, ng0);
    t22 = ((char*)((ng7)));
    t28 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t28, t22, 0, 0, 3, 0LL);
    goto LAB68;

LAB75:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB76;

LAB77:    *((unsigned int *)t31) = 1;
    goto LAB80;

LAB79:    t28 = (t31 + 4);
    *((unsigned int *)t31) = 1;
    *((unsigned int *)t28) = 1;
    goto LAB80;

LAB81:    t32 = (t0 + 1368U);
    t33 = *((char **)t32);
    t32 = ((char*)((ng9)));
    memset(t36, 0, 8);
    t34 = (t33 + 4);
    t35 = (t32 + 4);
    t51 = *((unsigned int *)t33);
    t52 = *((unsigned int *)t32);
    t55 = (t51 ^ t52);
    t56 = *((unsigned int *)t34);
    t57 = *((unsigned int *)t35);
    t58 = (t56 ^ t57);
    t59 = (t55 | t58);
    t60 = *((unsigned int *)t34);
    t61 = *((unsigned int *)t35);
    t62 = (t60 | t61);
    t65 = (~(t62));
    t66 = (t59 & t65);
    if (t66 != 0)
        goto LAB87;

LAB84:    if (t62 != 0)
        goto LAB86;

LAB85:    *((unsigned int *)t36) = 1;

LAB87:    memset(t40, 0, 8);
    t38 = (t36 + 4);
    t67 = *((unsigned int *)t38);
    t68 = (~(t67));
    t69 = *((unsigned int *)t36);
    t70 = (t69 & t68);
    t72 = (t70 & 1U);
    if (t72 != 0)
        goto LAB88;

LAB89:    if (*((unsigned int *)t38) != 0)
        goto LAB90;

LAB91:    t73 = *((unsigned int *)t31);
    t74 = *((unsigned int *)t40);
    t75 = (t73 | t74);
    *((unsigned int *)t43) = t75;
    t41 = (t31 + 4);
    t42 = (t40 + 4);
    t44 = (t43 + 4);
    t76 = *((unsigned int *)t41);
    t79 = *((unsigned int *)t42);
    t80 = (t76 | t79);
    *((unsigned int *)t44) = t80;
    t81 = *((unsigned int *)t44);
    t82 = (t81 != 0);
    if (t82 == 1)
        goto LAB92;

LAB93:
LAB94:    goto LAB83;

LAB86:    t37 = (t36 + 4);
    *((unsigned int *)t36) = 1;
    *((unsigned int *)t37) = 1;
    goto LAB87;

LAB88:    *((unsigned int *)t40) = 1;
    goto LAB91;

LAB90:    t39 = (t40 + 4);
    *((unsigned int *)t40) = 1;
    *((unsigned int *)t39) = 1;
    goto LAB91;

LAB92:    t83 = *((unsigned int *)t43);
    t84 = *((unsigned int *)t44);
    *((unsigned int *)t43) = (t83 | t84);
    t45 = (t31 + 4);
    t46 = (t40 + 4);
    t85 = *((unsigned int *)t45);
    t86 = (~(t85));
    t87 = *((unsigned int *)t31);
    t63 = (t87 & t86);
    t88 = *((unsigned int *)t46);
    t89 = (~(t88));
    t90 = *((unsigned int *)t40);
    t64 = (t90 & t89);
    t91 = (~(t63));
    t92 = (~(t64));
    t93 = *((unsigned int *)t44);
    *((unsigned int *)t44) = (t93 & t91);
    t94 = *((unsigned int *)t44);
    *((unsigned int *)t44) = (t94 & t92);
    goto LAB94;

LAB95:    xsi_set_current_line(51, ng0);

LAB98:    xsi_set_current_line(52, ng0);
    t54 = ((char*)((ng10)));
    t71 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t71, t54, 0, 0, 3, 0LL);
    goto LAB97;

LAB102:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB104;

LAB106:    *((unsigned int *)t31) = 1;
    goto LAB109;

LAB108:    t28 = (t31 + 4);
    *((unsigned int *)t31) = 1;
    *((unsigned int *)t28) = 1;
    goto LAB109;

LAB110:    t32 = (t0 + 1368U);
    t33 = *((char **)t32);
    t32 = ((char*)((ng5)));
    memset(t36, 0, 8);
    t34 = (t33 + 4);
    if (*((unsigned int *)t34) != 0)
        goto LAB114;

LAB113:    t35 = (t32 + 4);
    if (*((unsigned int *)t35) != 0)
        goto LAB114;

LAB117:    if (*((unsigned int *)t33) > *((unsigned int *)t32))
        goto LAB116;

LAB115:    *((unsigned int *)t36) = 1;

LAB116:    memset(t40, 0, 8);
    t38 = (t36 + 4);
    t17 = *((unsigned int *)t38);
    t18 = (~(t17));
    t19 = *((unsigned int *)t36);
    t20 = (t19 & t18);
    t23 = (t20 & 1U);
    if (t23 != 0)
        goto LAB118;

LAB119:    if (*((unsigned int *)t38) != 0)
        goto LAB120;

LAB121:    t24 = *((unsigned int *)t31);
    t25 = *((unsigned int *)t40);
    t26 = (t24 & t25);
    *((unsigned int *)t43) = t26;
    t41 = (t31 + 4);
    t42 = (t40 + 4);
    t44 = (t43 + 4);
    t27 = *((unsigned int *)t41);
    t47 = *((unsigned int *)t42);
    t48 = (t27 | t47);
    *((unsigned int *)t44) = t48;
    t49 = *((unsigned int *)t44);
    t50 = (t49 != 0);
    if (t50 == 1)
        goto LAB122;

LAB123:
LAB124:    goto LAB112;

LAB114:    t37 = (t36 + 4);
    *((unsigned int *)t36) = 1;
    *((unsigned int *)t37) = 1;
    goto LAB116;

LAB118:    *((unsigned int *)t40) = 1;
    goto LAB121;

LAB120:    t39 = (t40 + 4);
    *((unsigned int *)t40) = 1;
    *((unsigned int *)t39) = 1;
    goto LAB121;

LAB122:    t51 = *((unsigned int *)t43);
    t52 = *((unsigned int *)t44);
    *((unsigned int *)t43) = (t51 | t52);
    t45 = (t31 + 4);
    t46 = (t40 + 4);
    t55 = *((unsigned int *)t31);
    t56 = (~(t55));
    t57 = *((unsigned int *)t45);
    t58 = (~(t57));
    t59 = *((unsigned int *)t40);
    t60 = (~(t59));
    t61 = *((unsigned int *)t46);
    t62 = (~(t61));
    t63 = (t56 & t58);
    t64 = (t60 & t62);
    t65 = (~(t63));
    t66 = (~(t64));
    t67 = *((unsigned int *)t44);
    *((unsigned int *)t44) = (t67 & t65);
    t68 = *((unsigned int *)t44);
    *((unsigned int *)t44) = (t68 & t66);
    t69 = *((unsigned int *)t43);
    *((unsigned int *)t43) = (t69 & t65);
    t70 = *((unsigned int *)t43);
    *((unsigned int *)t43) = (t70 & t66);
    goto LAB124;

LAB125:    xsi_set_current_line(59, ng0);

LAB128:    xsi_set_current_line(60, ng0);
    t54 = ((char*)((ng1)));
    t71 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t71, t54, 0, 0, 3, 0LL);
    goto LAB127;

LAB131:    t8 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t8) = 1;
    goto LAB132;

LAB133:    xsi_set_current_line(62, ng0);

LAB136:    xsi_set_current_line(63, ng0);
    t22 = ((char*)((ng7)));
    t28 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t28, t22, 0, 0, 3, 0LL);
    goto LAB135;

LAB140:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB142;

LAB144:    *((unsigned int *)t31) = 1;
    goto LAB147;

LAB146:    t28 = (t31 + 4);
    *((unsigned int *)t31) = 1;
    *((unsigned int *)t28) = 1;
    goto LAB147;

LAB148:    t32 = (t0 + 1368U);
    t33 = *((char **)t32);
    t32 = ((char*)((ng5)));
    memset(t36, 0, 8);
    t34 = (t33 + 4);
    if (*((unsigned int *)t34) != 0)
        goto LAB152;

LAB151:    t35 = (t32 + 4);
    if (*((unsigned int *)t35) != 0)
        goto LAB152;

LAB155:    if (*((unsigned int *)t33) > *((unsigned int *)t32))
        goto LAB154;

LAB153:    *((unsigned int *)t36) = 1;

LAB154:    memset(t40, 0, 8);
    t38 = (t36 + 4);
    t17 = *((unsigned int *)t38);
    t18 = (~(t17));
    t19 = *((unsigned int *)t36);
    t20 = (t19 & t18);
    t23 = (t20 & 1U);
    if (t23 != 0)
        goto LAB156;

LAB157:    if (*((unsigned int *)t38) != 0)
        goto LAB158;

LAB159:    t24 = *((unsigned int *)t31);
    t25 = *((unsigned int *)t40);
    t26 = (t24 & t25);
    *((unsigned int *)t43) = t26;
    t41 = (t31 + 4);
    t42 = (t40 + 4);
    t44 = (t43 + 4);
    t27 = *((unsigned int *)t41);
    t47 = *((unsigned int *)t42);
    t48 = (t27 | t47);
    *((unsigned int *)t44) = t48;
    t49 = *((unsigned int *)t44);
    t50 = (t49 != 0);
    if (t50 == 1)
        goto LAB160;

LAB161:
LAB162:    goto LAB150;

LAB152:    t37 = (t36 + 4);
    *((unsigned int *)t36) = 1;
    *((unsigned int *)t37) = 1;
    goto LAB154;

LAB156:    *((unsigned int *)t40) = 1;
    goto LAB159;

LAB158:    t39 = (t40 + 4);
    *((unsigned int *)t40) = 1;
    *((unsigned int *)t39) = 1;
    goto LAB159;

LAB160:    t51 = *((unsigned int *)t43);
    t52 = *((unsigned int *)t44);
    *((unsigned int *)t43) = (t51 | t52);
    t45 = (t31 + 4);
    t46 = (t40 + 4);
    t55 = *((unsigned int *)t31);
    t56 = (~(t55));
    t57 = *((unsigned int *)t45);
    t58 = (~(t57));
    t59 = *((unsigned int *)t40);
    t60 = (~(t59));
    t61 = *((unsigned int *)t46);
    t62 = (~(t61));
    t63 = (t56 & t58);
    t64 = (t60 & t62);
    t65 = (~(t63));
    t66 = (~(t64));
    t67 = *((unsigned int *)t44);
    *((unsigned int *)t44) = (t67 & t65);
    t68 = *((unsigned int *)t44);
    *((unsigned int *)t44) = (t68 & t66);
    t69 = *((unsigned int *)t43);
    *((unsigned int *)t43) = (t69 & t65);
    t70 = *((unsigned int *)t43);
    *((unsigned int *)t43) = (t70 & t66);
    goto LAB162;

LAB163:    xsi_set_current_line(71, ng0);

LAB166:    xsi_set_current_line(72, ng0);
    t54 = ((char*)((ng11)));
    t71 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t71, t54, 0, 0, 3, 0LL);
    goto LAB165;

LAB171:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB172;

LAB173:    xsi_set_current_line(79, ng0);

LAB176:    xsi_set_current_line(80, ng0);
    t28 = ((char*)((ng1)));
    t29 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t29, t28, 0, 0, 3, 0LL);
    goto LAB175;

LAB179:    t8 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t8) = 1;
    goto LAB180;

LAB181:    *((unsigned int *)t31) = 1;
    goto LAB184;

LAB183:    t22 = (t31 + 4);
    *((unsigned int *)t31) = 1;
    *((unsigned int *)t22) = 1;
    goto LAB184;

LAB185:    t29 = (t0 + 1368U);
    t32 = *((char **)t29);
    t29 = ((char*)((ng9)));
    memset(t36, 0, 8);
    t33 = (t32 + 4);
    t34 = (t29 + 4);
    t51 = *((unsigned int *)t32);
    t52 = *((unsigned int *)t29);
    t55 = (t51 ^ t52);
    t56 = *((unsigned int *)t33);
    t57 = *((unsigned int *)t34);
    t58 = (t56 ^ t57);
    t59 = (t55 | t58);
    t60 = *((unsigned int *)t33);
    t61 = *((unsigned int *)t34);
    t62 = (t60 | t61);
    t65 = (~(t62));
    t66 = (t59 & t65);
    if (t66 != 0)
        goto LAB191;

LAB188:    if (t62 != 0)
        goto LAB190;

LAB189:    *((unsigned int *)t36) = 1;

LAB191:    memset(t40, 0, 8);
    t37 = (t36 + 4);
    t67 = *((unsigned int *)t37);
    t68 = (~(t67));
    t69 = *((unsigned int *)t36);
    t70 = (t69 & t68);
    t72 = (t70 & 1U);
    if (t72 != 0)
        goto LAB192;

LAB193:    if (*((unsigned int *)t37) != 0)
        goto LAB194;

LAB195:    t73 = *((unsigned int *)t31);
    t74 = *((unsigned int *)t40);
    t75 = (t73 | t74);
    *((unsigned int *)t43) = t75;
    t39 = (t31 + 4);
    t41 = (t40 + 4);
    t42 = (t43 + 4);
    t76 = *((unsigned int *)t39);
    t79 = *((unsigned int *)t41);
    t80 = (t76 | t79);
    *((unsigned int *)t42) = t80;
    t81 = *((unsigned int *)t42);
    t82 = (t81 != 0);
    if (t82 == 1)
        goto LAB196;

LAB197:
LAB198:    goto LAB187;

LAB190:    t35 = (t36 + 4);
    *((unsigned int *)t36) = 1;
    *((unsigned int *)t35) = 1;
    goto LAB191;

LAB192:    *((unsigned int *)t40) = 1;
    goto LAB195;

LAB194:    t38 = (t40 + 4);
    *((unsigned int *)t40) = 1;
    *((unsigned int *)t38) = 1;
    goto LAB195;

LAB196:    t83 = *((unsigned int *)t43);
    t84 = *((unsigned int *)t42);
    *((unsigned int *)t43) = (t83 | t84);
    t44 = (t31 + 4);
    t45 = (t40 + 4);
    t85 = *((unsigned int *)t44);
    t86 = (~(t85));
    t87 = *((unsigned int *)t31);
    t30 = (t87 & t86);
    t88 = *((unsigned int *)t45);
    t89 = (~(t88));
    t90 = *((unsigned int *)t40);
    t63 = (t90 & t89);
    t91 = (~(t30));
    t92 = (~(t63));
    t93 = *((unsigned int *)t42);
    *((unsigned int *)t42) = (t93 & t91);
    t94 = *((unsigned int *)t42);
    *((unsigned int *)t42) = (t94 & t92);
    goto LAB198;

LAB199:    xsi_set_current_line(82, ng0);

LAB202:    xsi_set_current_line(83, ng0);
    t53 = ((char*)((ng13)));
    t54 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t54, t53, 0, 0, 3, 0LL);
    goto LAB201;

LAB206:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB208;

LAB210:    *((unsigned int *)t31) = 1;
    goto LAB213;

LAB212:    t28 = (t31 + 4);
    *((unsigned int *)t31) = 1;
    *((unsigned int *)t28) = 1;
    goto LAB213;

LAB214:    t32 = (t0 + 1368U);
    t33 = *((char **)t32);
    t32 = ((char*)((ng5)));
    memset(t36, 0, 8);
    t34 = (t33 + 4);
    if (*((unsigned int *)t34) != 0)
        goto LAB218;

LAB217:    t35 = (t32 + 4);
    if (*((unsigned int *)t35) != 0)
        goto LAB218;

LAB221:    if (*((unsigned int *)t33) > *((unsigned int *)t32))
        goto LAB220;

LAB219:    *((unsigned int *)t36) = 1;

LAB220:    memset(t40, 0, 8);
    t38 = (t36 + 4);
    t17 = *((unsigned int *)t38);
    t18 = (~(t17));
    t19 = *((unsigned int *)t36);
    t20 = (t19 & t18);
    t23 = (t20 & 1U);
    if (t23 != 0)
        goto LAB222;

LAB223:    if (*((unsigned int *)t38) != 0)
        goto LAB224;

LAB225:    t24 = *((unsigned int *)t31);
    t25 = *((unsigned int *)t40);
    t26 = (t24 & t25);
    *((unsigned int *)t43) = t26;
    t41 = (t31 + 4);
    t42 = (t40 + 4);
    t44 = (t43 + 4);
    t27 = *((unsigned int *)t41);
    t47 = *((unsigned int *)t42);
    t48 = (t27 | t47);
    *((unsigned int *)t44) = t48;
    t49 = *((unsigned int *)t44);
    t50 = (t49 != 0);
    if (t50 == 1)
        goto LAB226;

LAB227:
LAB228:    goto LAB216;

LAB218:    t37 = (t36 + 4);
    *((unsigned int *)t36) = 1;
    *((unsigned int *)t37) = 1;
    goto LAB220;

LAB222:    *((unsigned int *)t40) = 1;
    goto LAB225;

LAB224:    t39 = (t40 + 4);
    *((unsigned int *)t40) = 1;
    *((unsigned int *)t39) = 1;
    goto LAB225;

LAB226:    t51 = *((unsigned int *)t43);
    t52 = *((unsigned int *)t44);
    *((unsigned int *)t43) = (t51 | t52);
    t45 = (t31 + 4);
    t46 = (t40 + 4);
    t55 = *((unsigned int *)t31);
    t56 = (~(t55));
    t57 = *((unsigned int *)t45);
    t58 = (~(t57));
    t59 = *((unsigned int *)t40);
    t60 = (~(t59));
    t61 = *((unsigned int *)t46);
    t62 = (~(t61));
    t63 = (t56 & t58);
    t64 = (t60 & t62);
    t65 = (~(t63));
    t66 = (~(t64));
    t67 = *((unsigned int *)t44);
    *((unsigned int *)t44) = (t67 & t65);
    t68 = *((unsigned int *)t44);
    *((unsigned int *)t44) = (t68 & t66);
    t69 = *((unsigned int *)t43);
    *((unsigned int *)t43) = (t69 & t65);
    t70 = *((unsigned int *)t43);
    *((unsigned int *)t43) = (t70 & t66);
    goto LAB228;

LAB229:    xsi_set_current_line(90, ng0);

LAB232:    xsi_set_current_line(91, ng0);
    t54 = ((char*)((ng11)));
    t71 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t71, t54, 0, 0, 3, 0LL);
    goto LAB231;

}


extern void work_m_00000000002355683903_3985308163_init()
{
	static char *pe[] = {(void *)Cont_29_0,(void *)Always_30_1};
	xsi_register_didat("work_m_00000000002355683903_3985308163", "isim/string2_tb_isim_beh.exe.sim/work/m_00000000002355683903_3985308163.didat");
	xsi_register_executes(pe);
}
