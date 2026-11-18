`ifndef __APB_VIP_PKG___
`define __APB_VIP_PKG___ 

import apb_defines::*;

package apb_vip_pkg;

  typedef logic [`__APB_ADDR_WIDTH__-1:0] apb_addr_t;
  typedef logic [`__APB_DATA_WIDTH__-1:0] apb_data_t;
  typedef logic [`__APB_STRB_WIDTH__-1:0] apb_strb_t;


  typedef enum bit {
    READ  = 1'b0,
    WRITE = 1'b1
  } pwrite_enum;

  typedef enum bit {
    NO_ERROR = 1'b0,
    ERROR = 1'b1
  } pslverr_enum;

  typedef enum bit [1:0] {
    IDLE = 2'b00,
    SETUP = 2'b01,
    ACCESS = 2'b10,
    WAIT_STATE = 2'b11
  } apb_fsm_enum;



endpackage

`endif
