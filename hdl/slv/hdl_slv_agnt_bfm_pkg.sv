`ifndef __HDL_SLV_AGNT_BFM_PKG__
`define __HDL_SLV_AGNT_BFM_PKG__ 

import uvm_pkg::*;
`include "uvm_macros.svh"

package hdl_slv_agnt_bfm_pkg;

  `include "hdl_slv_dri_bfm.sv"
  `include "hdl_slv_mon_bfm.sv"
  `include "hdl_slv_agnt_bfm.sv"

endpackage : hdl_slv_agnt_bfm_pkg

`endif
