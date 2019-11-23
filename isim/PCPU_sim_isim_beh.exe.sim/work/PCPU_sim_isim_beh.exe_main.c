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
    work_m_00000000002032609360_2058220583_init();
    work_m_00000000003049037367_0254784918_init();
    work_m_00000000002608045778_3476153904_init();
    work_m_00000000002074599550_0886308060_init();
    work_m_00000000003333680889_2533970755_init();
    work_m_00000000000901306046_1303956269_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000000901306046_1303956269");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
