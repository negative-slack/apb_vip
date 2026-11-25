`ifndef __APB_VIP_PKG___
`define __APB_VIP_PKG___ 

// wildcard include of the defines file to get all the defines in the package
import apb_defines::*;

package apb_vip_pkg;

  typedef bit [`__APB_NUM_OF_SLAVES__-1:0] apb_psel_t;

  typedef logic [`__APB_ADDR_WIDTH__-1:0] apb_addr_t;
  typedef logic [`__APB_DATA_WIDTH__-1:0] apb_data_t;
  typedef logic [`__APB_STRB_WIDTH__-1:0] apb_strb_t;
  typedef logic [`__APB_PPROT_WIDTH__-1:0] apb_pprot_t;

  typedef enum bit {
    READ  = 1'b0,
    WRITE = 1'b1
  } pwrite_enum;

  typedef enum bit {
    OKAY  = 1'b0,  // a.k.a NO_ERROR
    ERROR = 1'b1
  } pslverr_enum;

  typedef enum bit [1:0] {
    IDLE_STATE   = 2'b00,
    SETUP_STATE  = 2'b01,
    ACCESS_STATE = 2'b10,
    WAIT_STATE   = 2'b11
  } apb_fsm_enum;

  typedef enum apb_pprot_t {
    NORMAL_SECURE_DATA = 3'b000,
    NORMAL_SECURE_INSTRUCTION = 3'b001,
    NORMAL_NONSECURE_DATA = 3'b010,
    NORMAL_NONSECURE_INSTRUCTION = 3'b011,
    PRIVILEGED_SECURE_DATA = 3'b100,
    PRIVILEGED_SECURE_INSTRUCTION = 3'b101,
    PRIVILEGED_NONSECURE_DATA = 3'b110,
    PRIVILEGED_NONSECURE_INSTRUCTION = 3'b111
  } apb__enum;

  typedef enum bit [`__APB_NUM_OF_SLAVES__-1:0] {
    SLAVE_0  = 4'b0000_0000_0000_0001,
    SLAVE_1  = 4'b0000_0000_0000_0010,
    SLAVE_2  = 4'b0000_0000_0000_0100,
    SLAVE_3  = 4'b0000_0000_0000_1000,
    SLAVE_4  = 4'b0000_0000_0001_0000,
    SLAVE_5  = 4'b0000_0000_0010_0000,
    SLAVE_6  = 4'b0000_0000_0100_0000,
    SLAVE_7  = 4'b0000_0000_1000_0000,
    SLAVE_8  = 4'b0000_0001_0000_0000,
    SLAVE_9  = 4'b0000_0010_0000_0000,
    SLAVE_10 = 4'b0000_0100_0000_0000,
    SLAVE_11 = 4'b0000_1000_0000_0000,
    SLAVE_12 = 4'b0001_0000_0000_0000,
    SLAVE_13 = 4'b0010_0000_0000_0000,
    SLAVE_14 = 4'b0100_0000_0000_0000,
    SLAVE_15 = 4'b1000_0000_0000_0000
  } apb_slave_num_enum;

  typedef enum apb_addr_t {
    _byte = 32'd8,
    _halfword = 32'd16,
    _3_fourth_word = 32'd24,
    _word = 32'd32
  } transfer_size_enum;

  typedef struct packed {

    apb_pselx_t pselx;  // 16 bits for 16 slaves

    apb_addr_t  paddr;   // 32 bits for address
    pwrite_enum pwrite;  // 1 bit for read/write
    apb_data_t  pwdata;  // 32 bits for write data
    apb_strb_t  pstrb;   // 4 bits for write strobe
    apb_pprot_t pprot;   // 3 bits for protection type

    apb_data_t   prdata;   // 32 bits for read data
    pslverr_enum pslverr;  // 1 bit for slave error

    int num_of_wait_states;

  } apb_trans_struct;

endpackage : apb_vip_pkg

`endif
