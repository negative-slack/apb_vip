`ifndef __APB_IF__SV__
`define __APB_IF__SV__ 

interface apb_if
  import apb_vip_pkg::*;
(
    input bit PCLK,    // system clk
    input bit PRESETn  // system reset negative
);

  // mst output signals : (a master example is an AHB2APB bridge)
  // below are the control signals of a single transaction
  apb_psel_t PSEL;  // slave select, when asserted indicates the start of the transaction
  bit PENABLE;  // low indicates the first cycle of the transaction (setup state), and must be 1 in the following cycle > which indicates the 2nd/subsequent cycle (access state) of the apb protocol
  apb_addr_t PADDR;  // address to write to or read from
  pwrite_enum PWRITE;  // 0: read, 1: write
  // below signals have a value other than '0, only when PWRITE is asserted for a write transaction (will be controlled via a constraint)
  apb_data_t PWDATA;  // write data value
  apb_strb_t PSTRB;  // write strobe; indicates which byte lane to update during a write transaction (16 diff choice)

  // slv output signals
  bit PREADY; // only when PREADY is high it indicates the end of the tnx, read data is avaialbe at the same clock cycle with 0 delay. For a write tnxs, we update the memory after 1 delay cycle! (When PREADY = 0)
  apb_data_t PRDATA;
  pslverr_enum PSLVERR;

endinterface : apb_if

`endif
