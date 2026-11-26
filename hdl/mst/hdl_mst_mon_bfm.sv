`ifndef __HDL_MST_MON_BFM__
`define __HDL_MST_MON_BFM__ 

interface hdl_mst_mon_bfm
  import apb_vip_pkg::*;
(
    input bit PCLK,    // system clk
    input bit PRESETn, // system reset negative

    input bit PREADY,
    input apb_data_t PRDATA,
    input pslverr_enum PSLVERR,

    input apb_pselx_t PSELX,  // slave select, when asserted indicates the start of the transaction
    input bit PENABLE,  // low indicates the first cycle of the transaction (setup state)
    input apb_addr_t PADDR,  // address to write to or read from
    input pwrite_enum PWRITE,  // 0: read, 1: write
    input apb_data_t PWDATA,  // write data value
    input apb_strb_t PSTRB,  // write strobe; indicates which byte lane to update during a write transaction (16 diff choice)
    input apb_pprot_t PPROT  // protection type of the transaction
);

  //////////////////////////////////////////////////////////////////////////////
  // Variable: a hvl_mst_dri_proxy_hndl
  // Description : Creating the handle for the hvl_mst_proxy_monitor
  hvl_mst_mon_proxy hvl_mst_mon_proxy_hndl;
  //////////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////////////////////
  // Method : mon_presetn
  // Description : mon the presetn signal to be low
  ////////////////////////////////////////////////////////////////////////////// 
  task mon_presetn();
    @(negedge PRESETn);
    `uvm_info(get_full_name(), "SYSTEM RESET ACTIVATED", UVM_MEDIUM);

    @(posedge PRESETn);
    `uvm_info(get_full_name(), "SYSTEM RESET DEACTIVATED", UVM_MEDIUM);
  endtask : mon_presetn

  //////////////////////////////////////////////////////////////////////////////
  // Task : sample_signals
  // Description : This task is used to sample the signals of the interface and store them in the transaction structure
  //               The task will wait until a slave is selected and the transaction is in the access state, 
  //               then it will sample the signals and store them in the transaction structure
  //               The task will also count the number of wait states and store it in the transaction structure
  //////////////////////////////////////////////////////////////////////////////
  task sample_signals(output tnx_struct req);

    while (($countones(
        PSELX
    ) != 1)  // NO SLAVE IS SELECTED
    || (PENABLE != 1'b1)) // NOT EVEN IN THE ACCESS STATE 
    begin
      @(negedge PCLK);
    end

    // WE ARE IN THE ACCESS STATE, IS PREADY HIGH ?
    while (PREADY != 1'b1) begin  // SLAVE IS NOT READY, WAIT STATE DETECTED
      @(negedge PCLK);
      req.num_of_wait_states++;
    end

    `uvm_info(get_full_name(), $sformat(
              "PSELX = %0d, PENABLE = %0b, PREADY = %0b", req.pselx, req.penable, req.pready),
              UVM_MEDIUM);
    req.pselx  = PSELX;

    req.paddr  = PADDR;
    req.pwrite = PWRITE;

    if (PWRITE == WRITE) begin
      req.pwdata = PWDATA;
      req.pstrb  = PSTRB;
    end else begin
      req.rdata   = PRDATA;
      req.pslverr = PSLVERR;
    end

    req.pprot = PPROT;

    `uvm_info(get_full_name(), $sformatf("Sampled transaction: %0p", req), UVM_MEDIUM);

  endtask : sample_signals

endinterface : hdl_mst_mon_bfm

`endif
