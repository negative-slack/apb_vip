`ifndef __APB_VIP_PKG___
`define __APB_VIP_PKG___ 

package apb_vip_pkg;

  parameter int NUM_OF_SLAVES = 16;

  typedef enum bit {
    READ  = 1'b0,
    WRITE = 1'b1
  } pwrite_enum;

  typedef enum bit {
    NO_ERROR = 1'b0,
    ERROR = 1'b1
  } pslverr_enum;



endpackage

`endif
