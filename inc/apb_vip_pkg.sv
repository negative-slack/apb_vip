`ifndef __APB_VIP_PKG__
`define __APB_VIP_PKG__ 

// wildcard include of the defines file to get all the defines in the package
import apb_defines::*;

package apb_vip_pkg;

  typedef bit [`__NUM_OF_SLAVES__-1:0] apb_psel_t;

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

  /* PPROT[0]: 0 ; NORMAL
     PPROT[0]: 1 ; PRIVILEGED
     PPROT[1]: 0 ; SECURE
     PPROT[1]: 1 ; NONSECURE
     PPROT[2]: 0 ; DATA
     PPROT[2]: 1 ; INSTRUCTION
  */
  typedef enum apb_pprot_t {
    NORMAL_SECURE_DATA = 3'b000,
    PRIVILEGED_SECURE_DATA = 3'b001,
    NORMAL_NONSECURE_DATA = 3'b010,
    PRIVILEGED_NONSECURE_DATA = 3'b011,
    NORMAL_SECURE_INSTRUCTION = 3'b100,
    PRIVILEGED_SECURE_INSTRUCTION = 3'b101,
    NORMAL_NONSECURE_INSTRUCTION = 3'b110,
    PRIVILEGED_NONSECURE_INSTRUCTION = 3'b111
  } pprot_enum;

  // since pselx is a 1 bit signal, hence hot-encoded slaves are used
  typedef enum apb_psel_t {
    SLAVE_0  = 16'b0000_0000_0000_0001,
    SLAVE_1  = 16'b0000_0000_0000_0010,
    SLAVE_2  = 16'b0000_0000_0000_0100,
    SLAVE_3  = 16'b0000_0000_0000_1000,
    SLAVE_4  = 16'b0000_0000_0001_0000,
    SLAVE_5  = 16'b0000_0000_0010_0000,
    SLAVE_6  = 16'b0000_0000_0100_0000,
    SLAVE_7  = 16'b0000_0000_1000_0000,
    SLAVE_8  = 16'b0000_0001_0000_0000,
    SLAVE_9  = 16'b0000_0010_0000_0000,
    SLAVE_10 = 16'b0000_0100_0000_0000,
    SLAVE_11 = 16'b0000_1000_0000_0000,
    SLAVE_12 = 16'b0001_0000_0000_0000,
    SLAVE_13 = 16'b0010_0000_0000_0000,
    SLAVE_14 = 16'b0100_0000_0000_0000,
    SLAVE_15 = 16'b1000_0000_0000_0000
  } slave_num_enum;

  typedef enum bit [1:0] {
    IDLE_STATE   = 2'b00,
    SETUP_STATE  = 2'b01,
    ACCESS_STATE = 2'b10,
    WAIT_STATE   = 2'b11
  } apb_fsm_enum;

  typedef struct packed {

    apb_psel_t pselx;  // 16 bits for 16 slaves

    apb_addr_t  paddr;   // 32 bits for address
    pwrite_enum pwrite;  // 1 bit for read/write
    apb_data_t  pwdata;  // 32 bits for write data
    apb_strb_t  pstrb;   // 16 bits for write strobe
    apb_pprot_t pprot;   // 3 bits for protection type

    apb_data_t   prdata;   // 32 bits for read data
    pslverr_enum pslverr;  // 1 bit for slave error

    int num_of_wait_states;

  } tnx_struct;

endpackage : apb_vip_pkg

`endif
