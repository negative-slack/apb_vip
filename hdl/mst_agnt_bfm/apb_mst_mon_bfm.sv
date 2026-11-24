`ifndef __APB_MST_MON_BFM__
`define __APB_MST_MON_BFM__ 

interface apb_mst_mon_bfm
  import apb_vip_pkg::*;
(
    input bit PCLK,    // system clk
    input bit PRESETn, // system reset negative

    // slv input signals
    input bit PREADY,
    input apb_data_t PRDATA,
    input pslverr_enum PSLVERR,

    // mst input signals
    input apb_pselx_t PSELX,  // slave select, when asserted indicates the start of the transaction
    input bit PENABLE,  // low indicates the first cycle of the transaction (setup state)
    input apb_addr_t PADDR,  // address to write to or read from
    input pwrite_enum PWRITE,  // 0: read, 1: write
    input apb_data_t PWDATA,  // write data value
    input apb_strb_t PSTRB,  // write strobe; indicates which byte lane to update during a write transaction (16 diff choice)
    input apb_prot_enum PROT  // protection type of the transaction
);

  task sample_signals(apb_trans_struct req);

    while (($countones(
        PSELX
    ) != 1)  // NO SLAVE IS SELECTED
    || (PENABLE != 1'b1)) begin
      @(negedge PCLK);
    end

    while (PREADY != 1'b1) begin
      @(negedge PCLK);
      req.num_of_wait_states++;
    end


    req.PSELXx = PSELX;

    req.paddr  = PADDR;
    req.pwrite = PWRITE;

    if (PWRITE == WRITE) begin
      req.pwdata = PWDATA;
      req.pstrb  = PSTRB;
    end else begin
      req.rdata   = PRDATA;
      req.pslverr = PSLVERR;
    end

    req.prot = PROT;

    `uvm_info(get_full_name(), $sformatf("Sampled transaction: %0p", req), UVM_MEDIUM);

  endtask : sample_signals


endinterface : apb_mst_mon_bfm


`endif
