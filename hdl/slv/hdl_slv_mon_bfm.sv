`ifndef __HDL_SLV_MON_BFM__
`define __HDL_SLV_MON_BFM__ 

interface hdl_slv_mon_bfm (
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
    input apb_pprot_t PPROT  // protection type of the transaction
);

  task sample_signals(output tnx_struct req);

    while (($countones(
        PSELX
    ) != 1)  // NO SLAVE IS SELECTED
    || (PENABLE != 1'b1) || (PREADY != 1'b1)) begin
      @(negedge PCLK);
    end

    req.PSELXx = PSELX;

    req.paddr  = PADDR;
    req.pwrite = PWRITE;

    if (PWRITE == WRITE) begin
      req.pwdata = PWDATA;
      req.pstrb  = PSTRB;
    end else begin
      req.prdata  = PRDATA;
      req.pslverr = PSLVERR;
    end

    req.pprot = PPROT;

  endtask : sample_signals

endinterface : hdl_slv_mon_bfm

`endif
