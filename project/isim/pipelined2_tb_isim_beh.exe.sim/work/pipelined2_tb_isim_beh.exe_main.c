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

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_04733474707971867610_2514678930_init();
    work_m_08273487103722745032_3037777339_init();
    work_m_12513368627736290752_3146453351_init();
    work_m_16857643689151942132_3383896982_init();
    work_m_04406059008912216392_3037376393_init();
    work_m_14318527503976207490_3250708037_init();
    work_m_14484932997211067321_2347679131_init();
    work_m_07249813116753128284_4241813833_init();
    work_m_14237514932081610730_3363942390_init();
    work_m_12705464837893837330_2725559894_init();
    work_m_17145650419188772159_2830815785_init();
    work_m_03075463573732361805_0010801604_init();
    work_m_12117598942609775303_1200043877_init();
    work_m_05916939032839477016_3457385337_init();
    work_m_16541823861846354283_2073120511_init();


    xsi_register_tops("work_m_05916939032839477016_3457385337");
    xsi_register_tops("work_m_16541823861846354283_2073120511");


    return xsi_run_simulation(argc, argv);

}
