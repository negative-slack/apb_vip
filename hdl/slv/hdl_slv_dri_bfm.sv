`ifndef __HDL_SLV_DRI_BFM__
`define __HDL_SLV_DRI_BFM__ 

interface hdl_slv_dri_bfm (
    input bit PCLK,    // system clk
    input bit PRESETn, // system reset negative

    // slv output signals a.k.a mst input signals
    output bit PREADY,
    output apb_data_t PRDATA,
    output pslverr_enum PSLVERR,

    // slv input signals a.k.a mst output signals
    input apb_pselx_t PSELX,  // slave select, when asserted indicates the start of the transaction
    input bit PENABLE,  // low indicates the first cycle of the transaction (setup state
    input apb_addr_t PADDR,  // address to write to or read from
    input pwrite_enum PWRITE,  // 0: read, 1: write
    input apb_data_t PWDATA,  // write data value
    input apb_strb_t PSTRB,  // write strobe; indicates which byte lane to update during a write transaction (16 diff choice)
    input apb_pprot_t PPROT  // protection type of the transaction
);

  //////////////////////////////////////////////////////////////////////////////
  // Method : dri_presetn
  // Description : drive the presetn signal to be low
  ////////////////////////////////////////////////////////////////////////////// 
  task dri_presetn();
    @(negedge PRESEETn);
    `uvm_info(get_full_name(), "SYSTEM RESET ACTIVATED", UVM_MEDIUM);

    @(posedge PRESEETn);
    `uvm_info(get_full_name(), "SYSTEM RESET DEACTIVATED", UVM_MEDIUM);
  endtask : dri_presetn

  task wait_for_setup_state(output apb_trans_struct req);
    @(posedge PCLK);
    `uvm_info(get_full_name(), "WAITING FOR SETUP STATE", UVM_MEDIUM);
    `uvm_info(get_full_name(), $sformatf("PSELX: %0h", PSELX), UVM_MEDIUM);

    while ($countones(
        PSELX
    ) != 1) begin
      @(negedge PCLK);
    end

    `uvm_info(get_full_name(), "SETUP STATE DETECTED", UVM_MEDIUM);
    `uvm_info(get_full_name(), $sformatf("PSELX: %0h", PSELX), UVM_MEDIUM);

    req.pselq  = PSELX;
    req.paddr  = PADDR;
    req.pwrite = PWRITE;

    if (PWRITE == WRITE) begin  // it is a write transaction, so we need to drive PWDATA and PSTRB
      req.pwdata = PWDATA;
      req.pstrb  = PSTRB;
    end

    req.pprot = PPROT;

  endtask : wait_for_setup_state

  task wait_for_access_state(output apb_trans_struct req);
    @(posedge PCLK);
    `uvm_info(get_full_name(), "WAITING FOR ACCESS STATE", UVM_MEDIUM);
    `uvm_info(get_full_name(), $sformatf("NUM_OF_WAIT_STATES: %0h", req.num_of_wait_states),
              UVM_MEDIUM);

    repeat (req.num_of_wait_states) begin
      @(posedge PCLK);
      PREADY <= 1'b0;
    end

    PREADY <= 1'b1;
    `uvm_info(get_full_name(), "ACCESS STATE DETECTED", UVM_MEDIUM);
    `uvm_info(get_full_name(), $sformatf("PREADY: %0h", PREADY), UVM_MEDIUM);

    if (req.PWRITE == READ) begin
      PRDATA <= req.prdata;
    end

    PSLVERR <= req.pslverr;

  endtask : wait_for_access_state


endinterface : hdl_slv_dri_bfm

`endif
