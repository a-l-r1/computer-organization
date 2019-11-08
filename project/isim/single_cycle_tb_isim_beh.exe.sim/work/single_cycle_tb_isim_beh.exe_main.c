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
    work_m_13488074455857098113_3037777339_init();
    work_m_15388827882813134003_3146453351_init();
    work_m_16857643689151942132_3383896982_init();
    work_m_04406059008912216392_3037376393_init();
    work_m_00965919391217495174_3527808377_init();
    work_m_14484932997211067321_2347679131_init();
    work_m_07249813116753128284_4241813833_init();
    work_m_16509421830658313583_0992325708_init();
    work_m_13295615461976157633_2725559894_init();
    work_m_16448653343709007940_0010801604_init();
    work_m_14686651114165047670_3877310806_init();
    work_m_02199740068577276398_2144801286_init();
    work_m_16541823861846354283_2073120511_init();


    xsi_register_tops("work_m_02199740068577276398_2144801286");
    xsi_register_tops("work_m_16541823861846354283_2073120511");


    return xsi_run_simulation(argc, argv);

}
