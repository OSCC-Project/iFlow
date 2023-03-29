#!/usr/bin/python3
#--------------------------------------------------------------------------- 
#             Copyright 2021 PENG CHENG LABORATORY
#--------------------------------------------------------------------------- 
# Author      : liubojun
# Email       : liubj@pcl.ac.cn
# Date        : 2021-04-06
# Project     : 
# Language    : Python
# Description : 
#--------------------------------------------------------------------------- 
import sys
import os
import subprocess
import re
from   data_def import *

#----------------------------------------------------------
# nangate45
#----------------------------------------------------------
nangate45 = Foundry(
    name='nangate45',
    lib = {
        'std,HD,TYP': (
            'foundry/nangate45/lib/NangateOpenCellLibrary_typical.lib',
        ),
        'dontuse'   : 'TAPCELL_X1 FILLCELL_X1 AOI211_X1 OAI211_X1',
        'macro,TYP' : (
            'foundry/nangate45/lib/fakeram45_32x64.lib',
            'foundry/nangate45/lib/fakeram45_64x7.lib',
            'foundry/nangate45/lib/fakeram45_64x15.lib',
            'foundry/nangate45/lib/fakeram45_64x21.lib',
            'foundry/nangate45/lib/fakeram45_64x32.lib',
            'foundry/nangate45/lib/fakeram45_64x96.lib',
            'foundry/nangate45/lib/fakeram45_256x34.lib',
            'foundry/nangate45/lib/fakeram45_256x95.lib',
            'foundry/nangate45/lib/fakeram45_256x96.lib',
            'foundry/nangate45/lib/fakeram45_512x64.lib',
            'foundry/nangate45/lib/fakeram45_1024x32.lib',
            'foundry/nangate45/lib/fakeram45_2048x39.lib'
        ),
    },
    lef = {
        'tech'      : (
            'foundry/nangate45/lef/NangateOpenCellLibrary.tech.lef',
        ),
        'std,HD'    : (
            'foundry/nangate45/lef/NangateOpenCellLibrary.macro.mod.lef',
        ),
        'macro'     : (
            'foundry/nangate45/lef/fakeram45_32x64.lef',
            'foundry/nangate45/lef/fakeram45_64x7.lef',
            'foundry/nangate45/lef/fakeram45_64x15.lef',
            'foundry/nangate45/lef/fakeram45_64x21.lef',
            'foundry/nangate45/lef/fakeram45_64x32.lef',
            'foundry/nangate45/lef/fakeram45_64x96.lef',
            'foundry/nangate45/lef/fakeram45_256x34.lef',
            'foundry/nangate45/lef/fakeram45_256x95.lef',
            'foundry/nangate45/lef/fakeram45_256x96.lef',
            'foundry/nangate45/lef/fakeram45_512x64.lef',
            'foundry/nangate45/lef/fakeram45_1024x32.lef',
            'foundry/nangate45/lef/fakeram45_2048x39.lef'
        )
    },
    gds = {
        'std,HD'    : (
            'foundry/nangate45/gds/NangateOpenCellLibrary.gds',
        ),
        'macro'     : (
        )
    }
)

#----------------------------------------------------------
# asap7
#----------------------------------------------------------

asap7 = Foundry(
    name='asap7',
    lib = {
        'std,HS,MAX': (
            'foundry/asap7/lib/asap7sc7p5t_AO_RVT_SS_nldm_201020.lib',
            'foundry/asap7/lib/asap7sc7p5t_INVBUF_RVT_SS_nldm_201020.lib',
            'foundry/asap7/lib/asap7sc7p5t_OA_RVT_SS_nldm_201020.lib',
            'foundry/asap7/lib/asap7sc7p5t_SEQ_RVT_SS_nldm_201020.lib',
            'foundry/asap7/lib/asap7sc7p5t_SIMPLE_RVT_SS_nldm_201020.lib'
        ),
        'std,HS,TYP': (
            'foundry/asap7/lib/asap7sc7p5t_AO_RVT_TT_nldm_201020.lib',
            'foundry/asap7/lib/asap7sc7p5t_INVBUF_RVT_TT_nldm_201020.lib',
            'foundry/asap7/lib/asap7sc7p5t_OA_RVT_TT_nldm_201020.lib',
            'foundry/asap7/lib/asap7sc7p5t_SEQ_RVT_TT_nldm_201020.lib',
            'foundry/asap7/lib/asap7sc7p5t_SIMPLE_RVT_TT_nldm_201020.lib'
        ),
        'std,HS,MIN': (
            'foundry/asap7/lib/asap7sc7p5t_AO_RVT_FF_nldm_201020.lib',
            'foundry/asap7/lib/asap7sc7p5t_INVBUF_RVT_FF_nldm_201020.lib',
            'foundry/asap7/lib/asap7sc7p5t_OA_RVT_FF_nldm_201020.lib',
            'foundry/asap7/lib/asap7sc7p5t_SIMPLE_RVT_FF_nldm_201020.lib',
            'foundry/asap7/lib/asap7sc7p5t_SEQ_RVT_FF_nldm_201020.lib'
        ),
        'dontuse'   : '*x1_ASAP7* *x1p*_ASAP7* *xp*_ASAP7* SDF* ICG* DFFH* AO21* *SRAM*',
        'macro,MAX' : (
        ),
        'macro,TYP' : (
        ),
        'macro,MIN' : (
        ),
    },
    lef = {
        'tech'      : (
            'foundry/asap7/lef/asap7_tech_1x_201209.lef',
        ),
        'std,HS'    : (
            'foundry/asap7/lef/asap7sc7p5t_27_R_1x_201211.lef',
        ),
        'macro'     : (
        )
    },
    gds = {
        'std,HS'    : (
            'foundry/asap7/gds/asap7sc7p5t_27_R_1x_201211.gds',
        ),
        'macro'     : (
        )
    }
)



#-----------------------------------------------------------
# SMIC110
#-----------------------------------------------------------
smic110 = Foundry(
    name='smic110',
    lib = {
        'std,HD,MAX': (
            'foundry/smic110/lib/scc011ums_hd_lvt_ss_v1p08_125c_ccs.lib',
            'foundry/smic110/lib/scc011ums_hd_hvt_ss_v1p08_125c_ccs.lib',
            'foundry/smic110/lib/scc011ums_hd_rvt_ss_v1p08_125c_ccs.lib'
        ),
        'std,HD,MIN': (
            'foundry/smic110/lib/scc011ums_hd_lvt_ff_v1p32_-40c_ccs.lib',
            'foundry/smic110/lib/scc011ums_hd_hvt_ff_v1p32_-40c_ccs.lib',
            'foundry/smic110/lib/scc011ums_hd_rvt_ff_v1p32_-40c_ccs.lib'
        ),
        'dontuse'   : '*HVT* *DEL* *V0* *V24* *V20* *222* *33* *32* *F_DIO* *PULL* *TBUF* SED* SND* SD*',
        'macro,MAX' : (
            'foundry/smic110/lib/S011HD1P_X32Y2D128_BW_SS_1.08_125.lib',
            'foundry/smic110/lib/S011HD1P_X64Y4D32_BW_SS_1.08_125.lib',
            'foundry/smic110/lib/SP013D3WP_V1p7_typ.lib',
            'foundry/smic110/lib/S013PLLFN_v1.5.1_typ.lib'
        ),
        'macro,MIN' : (
            'foundry/smic110/lib/S011HD1P_X32Y2D128_BW_SS_1.08_-40.lib',
            'foundry/smic110/lib/S011HD1P_X64Y4D32_BW_FF_1.32_-40.lib',
            'foundry/smic110/lib/SP013D3WP_V1p7_min.lib',
            'foundry/smic110/lib/S013PLLFN_v1.5.1_min.lib'
        ),
    },
    lef = {
        'tech'      : (
            'foundry/smic110/lef/scc011u_8lm_1tm_thin_ALPA.lef',
        ),
        'std,HD'    : (
            'foundry/smic110/lef/scc011ums_hd_hvt.lef',
            'foundry/smic110/lef/scc011ums_hd_lvt.lef',
            'foundry/smic110/lef/scc011ums_hd_rvt.lef'
        ),
        'macro'     : (
            'foundry/smic110/lef/S011HD1P_X32Y2D128_BW.lef',
            'foundry/smic110/lef/S011HD1P_X64Y4D32_BW.lef',
            'foundry/smic110/lef/SP013D3WP_V1p7_8MT.lef',
            'foundry/smic110/lef/S013PLLFN_8m_V1_2_1.lef'
        )
    },
    gds = {
        'std,HD'    : (
            'foundry/smic110/gds/scc011ums_hd_hvt.gds',
            'foundry/smic110/gds/scc011ums_hd_lvt.gds',
            'foundry/smic110/gds/scc011ums_hd_rvt.gds',
        ),
        'macro'     : (
            'foundry/smic110/gds/S011HD1P_X32Y2D128_BW.gds',
            'foundry/smic110/gds/S011HD1P_X64Y4D32_BW.gds',
            'foundry/smic110/gds/SP013D3WP_V1p7_8MT.gds',
            'foundry/smic110/gds/S013PLLFN_V1.5.2_1P8M_partial.gds'
        )
    }
)

#-----------------------------------------------------------
# TSMC28
#-----------------------------------------------------------
tsmc28 = Foundry(
    name='tsmc28',
    lib = {
        'std,HD,MAX': (
            'foundry/tsmc28/lib/tcbn28hpcplusbwp40p140lvtssg0p81v0c.lib',
        ),
        'std,HD,MIN': (
            'foundry/tsmc28/lib/scc55nll_hd_hvt_ff_v1p32_-40c_ccs.lib',
            'foundry/tsmc28/lib/scc55nll_hd_lvt_ff_v1p32_-40c_ccs.lib',
            'foundry/tsmc28/lib/scc55nll_hd_rvt_ff_v1p32_-40c_ccs.lib'
        ),
        'dontuse'   : '*DEL* *ED* *SED* *SND* *AOI222* *AOI33* *OAI222* *OAI33* *CK* *NOR4* *D0* *D24* *D20* *DCAP* *FILL*',
        'macro,MAX' : (
            'foundry/tsmc28/lib/PLLTS28HPMLAINT_SS_0P81_125C.lib',
            'foundry/tsmc28/lib/tphn28hpcpgv18ssg0p81v1p62v125c.lib',
            'foundry/tsmc28/lib/ts5n28hpcplvta256x32m4fw_130a_ssg0p81v125c.lib',
            'foundry/tsmc28/lib/ts5n28hpcplvta64x128m2fw_130a_ssg0p81v125c.lib'
        ),
        'macro,MIN' : (
            'foundry/tsmc28/lib/S55NLL_CP_V0p2_ff_v1p32_-40C.lib',
            'foundry/tsmc28/lib/S55NLLGSPH_X512Y16D32_BW_ff_1.32_-40.lib',
            'foundry/tsmc28/lib/S55NLLGVMH_X128Y8D32_ff_1.32_-40.lib',
            'foundry/tsmc28/lib/S55NLLPLLGS_ZP1500A_V1.2.8_min.lib',
            'foundry/tsmc28/lib/SP55NLLD2RP_POR12C_OV3_V0p1_ff_v1p32_-40C.lib',
            'foundry/tsmc28/lib/SPT55NLLD2RP_OV3_ANALOG_V0p3_ff_V1p32_-40C.lib',
            'foundry/tsmc28/lib/SPT55NLLD2RP_OV3_V0p3_ff_V1p32_-40C.lib'
        ),
    },
    lef = {
        'tech'      : (
            'foundry/tsmc28/lef/scc55nll_hd_9lm_2tm.lef',
        ),
        'std,HD'    : (
            'foundry/tsmc28/lef/SCC55NLL_HD_LVT_V2p0.lef',
            'foundry/tsmc28/lef/SCC55NLL_HD_RVT_V2p0.lef',
            'foundry/tsmc28/lef/SCC55NLL_HD_HVT_V2p0.lef'
        ),
        'macro'     : (
            'foundry/tsmc28/lef/S55NLLGSPH_X512Y16D32_BW.lef',
            'foundry/tsmc28/lef/S55NLLGVMH_X128Y8D32.lef',
            'foundry/tsmc28/lef/S55NLLPLLGS_ZP1500A_9m2tm_V1.2.3.lef',
            'foundry/tsmc28/lef/SP55NLLD2RP_POR12C_OV3_V0p2_9MT_2TM.lef',
            'foundry/tsmc28/lef/SPT55NLLD2RP_OV3_ANALOG_V0p3_9MT_2TM.lef',
            'foundry/tsmc28/lef/SPT55NLLD2RP_OV3_V0p3_9MT_2TM.lef'
        )
    },
    gds = {
        'std,HD'    : (
            'foundry/tsmc28/gds/SCC55NLL_HD_LVT_V2p0.gds',
            'foundry/tsmc28/gds/SCC55NLL_HD_RVT_V2p0.gds',
            'foundry/tsmc28/gds/SCC55NLL_HD_HVT_V2p0.gds'
        ),
        'macro'     : (
            'foundry/tsmc28/gds/S011HD1P1024X64M4B0.gds',
        )
    }
)

#-----------------------------------------------------------
# sky130
#-----------------------------------------------------------
sky130 = Foundry(
    name='sky130',
    lib = {
        'std,HS,TYP': (
            'foundry/sky130/lib/sky130_fd_sc_hs__tt_025C_1v80.lib',
        ),
        'std,HD,TYP': (
            'foundry/sky130/lib/sky130_fd_sc_hd__tt_025C_1v80.lib',
        ),
        'dontuse'   : 'sky130_fd_sc_hs__xor3_1 *2111* *221* *311* *32* *41* *clk* *dly* *nand4* *or4*',
        'macro,TYP' : (
            'foundry/sky130/lib/sky130_dummy_io.lib',
            'foundry/sky130/lib/sky130_sram_1rw1r_128x256_8_TT_1p8V_25C.lib',
            'foundry/sky130/lib/sky130_sram_1rw1r_44x64_8_TT_1p8V_25C.lib',
            'foundry/sky130/lib/sky130_sram_1rw1r_64x256_8_TT_1p8V_25C.lib',
            'foundry/sky130/lib/sky130_sram_1rw1r_80x64_8_TT_1p8V_25C.lib'
        ),
    },
    lef = {
        'tech'      : (
            'foundry/sky130/lef/sky130_fd_sc_hs.tlef',
        ),
        'std,HS'    : (
            'foundry/sky130/lef/sky130_fd_sc_hs_merged.lef',
        ),
        'std,HD'    : (
            'foundry/sky130/lef/sky130_fd_sc_hd_merged.lef',
        ),
        'macro'     : (
            'foundry/sky130/lef/sky130_ef_io__com_bus_slice_10um.lef',
            'foundry/sky130/lef/sky130_ef_io__com_bus_slice_1um.lef',
            'foundry/sky130/lef/sky130_ef_io__com_bus_slice_20um.lef',
            'foundry/sky130/lef/sky130_ef_io__com_bus_slice_5um.lef',
            'foundry/sky130/lef/sky130_ef_io__connect_vcchib_vccd_and_vswitch_vddio_slice_20um.lef',
            'foundry/sky130/lef/sky130_ef_io__corner_pad.lef',
            'foundry/sky130/lef/sky130_ef_io__disconnect_vccd_slice_5um.lef',
            'foundry/sky130/lef/sky130_ef_io__disconnect_vdda_slice_5um.lef',
            'foundry/sky130/lef/sky130_ef_io__gpiov2_pad_wrapped.lef',
            'foundry/sky130/lef/sky130_ef_io__vccd_hvc_pad.lef',
            'foundry/sky130/lef/sky130_ef_io__vccd_lvc_pad.lef',
            'foundry/sky130/lef/sky130_ef_io__vdda_hvc_pad.lef',
            'foundry/sky130/lef/sky130_ef_io__vdda_lvc_pad.lef',
            'foundry/sky130/lef/sky130_ef_io__vddio_hvc_pad.lef',
            'foundry/sky130/lef/sky130_ef_io__vddio_lvc_pad.lef',
            'foundry/sky130/lef/sky130_ef_io__vssa_hvc_pad.lef',
            'foundry/sky130/lef/sky130_ef_io__vssa_lvc_pad.lef',
            'foundry/sky130/lef/sky130_ef_io__vssd_hvc_pad.lef',
            'foundry/sky130/lef/sky130_ef_io__vssd_lvc_pad.lef',
            'foundry/sky130/lef/sky130_ef_io__vssio_hvc_pad.lef',
            'foundry/sky130/lef/sky130_ef_io__vssio_lvc_pad.lef',
            'foundry/sky130/lef/sky130_fd_io__top_xres4v2.lef',
            'foundry/sky130/lef/sky130io_fill.lef',
            'foundry/sky130/lef/sky130_sram_1rw1r_128x256_8.lef',
            'foundry/sky130/lef/sky130_sram_1rw1r_44x64_8.lef',
            'foundry/sky130/lef/sky130_sram_1rw1r_64x256_8.lef',
            'foundry/sky130/lef/sky130_sram_1rw1r_80x64_8.lef'
        )
    },
    gds = {
        'std,HS'    : (
            'foundry/sky130/gds/sky130_fd_sc_hs.gds',
        ),
        'std,HD'    : (
            'foundry/sky130/gds/sky130_fd_sc_hd.gds',
        ),
        'macro'     : (
            'foundry/sky130/gds/sky130_sram_1rw1r_128x256_8.gds',
            'foundry/sky130/gds/sky130_sram_1rw1r_44x64_8.gds',
            'foundry/sky130/gds/sky130_sram_1rw1r_64x256_8.gds',
            'foundry/sky130/gds/sky130_sram_1rw1r_80x64_8.gds'
        )
    }
)

            #'foundry/sky130/lef/sky130_fd_sc_hd.tlef'
