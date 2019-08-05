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
    work_m_00000000002918165918_2514678930_init();
    work_m_00000000001451081791_3037777339_init();
    work_m_00000000000143651450_3146453351_init();
    work_m_00000000001053322197_3383896982_init();
    work_m_00000000000094327112_3037376393_init();
    work_m_00000000003978925186_3250708037_init();
    work_m_00000000003197195866_2347679131_init();
    work_m_00000000001477028700_4241813833_init();
    work_m_00000000002869645290_3363942390_init();
    work_m_00000000003376917953_2725559894_init();
    work_m_00000000004194678437_0010801604_init();
    work_m_00000000003255848624_1200043877_init();
    work_m_00000000001891001969_0728349233_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000001891001969_0728349233");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
