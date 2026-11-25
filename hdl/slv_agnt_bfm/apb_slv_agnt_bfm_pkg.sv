`ifndef __APB_SLV_AGNT_BFM_PKG__
`define __APB_SLV_AGNT_BFM_PKG__ 

import uvm_pkg::*;
`include "uvm_macros.svh"

package apb_slv_agnt_bfm_pkg;

  `include "apb_slv_dri_bfm.sv"
  `include "apb_slv_mon_bfm.sv"
  `include "apb_slv_agnt_bfm.sv"

endpackage : apb_slv_agnt_bfm_pkg

`endif
