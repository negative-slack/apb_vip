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

  typedef enum logic [2:0] {
    NORMAL_SECURE_DATA = 3'b000,
    NORMAL_SECURE_INSTRUCTION = 3'b001,
    NORMAL_NONSECURE_DATA = 3'b010,
    NORMAL_NONSECURE_INSTRUCTION = 3'b011,
    PRIVILEGED_SECURE_DATA = 3'b100,
    PRIVILEGED_SECURE_INSTRUCTION = 3'b101,
    PRIVILEGED_NONSECURE_DATA = 3'b110,
    PRIVILEGED_NONSECURE_INSTRUCTION = 3'b111
  } apb_prot_enum;

  typedef enum bit [3:0] {
    SLAVE_0  = 4'b0000,
    SLAVE_1  = 4'b0001,
    SLAVE_2  = 4'b0010,
    SLAVE_3  = 4'b0011,
    SLAVE_4  = 4'b0100,
    SLAVE_5  = 4'b0101,
    SLAVE_6  = 4'b0110,
    SLAVE_7  = 4'b0111,
    SLAVE_8  = 4'b1000,
    SLAVE_9  = 4'b1001,
    SLAVE_10 = 4'b1010,
    SLAVE_11 = 4'b1011,
    SLAVE_12 = 4'b1100,
    SLAVE_13 = 4'b1101,
    SLAVE_14 = 4'b1110,
    SLAVE_15 = 4'b1111
  } apb_slave_num_enum;

  typedef struct packed {

    bit [`__APB_NUM_OF_SLAVES__-1:0] psel;

    apb_addr_t paddr;
    pwrite_enum pwrite;
    apb_data_t pwdata;
    apb_strb_t pstrb;
    apb_prot_enum prot;

    apb_data_t   prdata;
    pslverr_enum pslverr;

    int num_of_wait_states;
  } apb_trans_st;

endpackage : apb_vip_pkg

`endif
