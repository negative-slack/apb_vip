`ifndef __HDL_MST_DRI_BFM__
`define __HDL_MST_DRI_BFM__ 

interface hdl_mst_dri_bfm
  import apb_vip_pkg::*;
(
    input bit PCLK,    // system clk
    input bit PRESETn, // system reset negative

    // slv output signals
    input bit PREADY,
    input apb_data_t PRDATA,
    input pslverr_enum PSLVERR,

    // mst output signals
    output apb_pselx_t PSELX,  // slave select, when asserted indicates the start of the transaction
    output bit PENABLE,  // low indicates the first cycle of the transaction (setup state
    output apb_addr_t PADDR,  // address to write to or read from
    output pwrite_enum PWRITE,  // 0: read, 1: write
    output apb_pprot_t PPROT,  // protection type of the transaction

    output apb_data_t PWDATA,  // write data value
    output apb_strb_t PSTRB  // write strobe; indicates which byte lane to update during a write transaction (16 diff choice)

);

  //////////////////////////////////////////////////////////////////////////////
  // Variable: a hvl_mst_dri_proxy_hndl
  // Description : Creating the handle for the hvl_mst_proxy_driver
  hvl_mst_dri_proxy hvl_mst_dri_proxy_hndl;
  //////////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////////////////////
  // Variable : fsm_state
  // Description : This variable is used to keep track of the current state of the FSM
  ////////////////////////////////////////////////////////////////////////////// 
  apb_fsm_enum fsm_state;

  //////////////////////////////////////////////////////////////////////////////
  // Method : dri_presetn
  // Description : drive the presetn signal to be low
  ////////////////////////////////////////////////////////////////////////////// 
  task dri_presetn();
    @(negedge PRESETn);
    `uvm_info(get_full_name(), "SYSTEM RESET ACTIVATED", UVM_MEDIUM);

    @(posedge PRESETn);
    `uvm_info(get_full_name(), "SYSTEM RESET DEACTIVATED", UVM_MEDIUM);
  endtask : reset

  //////////////////////////////////////////////////////////////////////////////
  // Method : dri_idle_state
  // Description : This task is used to drive the FSM to the IDLE state
  ////////////////////////////////////////////////////////////////////////////// 
  task dri_idle_state();

    @(posedge PCLK);
    PSELX   <= '0;  // no slave is selected
    PENABLE <= 1'b0;
    fsm_state = IDLE_STATE;

    `uvm_info(get_full_name(), "MST_DRI_BFM is in the IDLE state", UVM_MEDIUM);

  endtask : dri_idle_state

  //////////////////////////////////////////////////////////////////////////////
  // Method : dri_setup_state
  // Description : This task is used to drive the FSM to the SETUP state
  ////////////////////////////////////////////////////////////////////////////// 
  task dri_setup_state(inout apb_trans_struct req);

    @(posedge PCLK);

    PSELX <= req.pselx;
    PENABLE <= 1'b0;  // 1st cycle is low indicates the first cycle of the transaction (setup state)
    PADDR <= req.paddr;
    PWRITE <= req.pwrite;

    if (req.pwrite == WRITE) begin // it is a write transaction, so we need to drive PWDATA and PSTRB
      PWDATA <= req.pwdata;
      PSTRB  <= req.pstrb;
    end else begin  // it is a read transaction, so we don't need to drive PWDATA and PSTRB
      PWDATA <= '0;
      PSTRB  <= '0;
    end

    PPROT <= req.pprot;

    fsm_state = SETUP_STATE;

    `uvm_info(get_full_name(), "MST_DRI_BFM is in the SETUP state", UVM_MEDIUM);

  endtask : dri_setup_state

  //////////////////////////////////////////////////////////////////////////////
  // Method : dri_access_state
  // Description : This task is used to drive the FSM to the ACCESS state
  ////////////////////////////////////////////////////////////////////////////// 
  task dri_access_state(inout apb_trans_struct req);

    @(posedge PCLK);

    PENABLE <= 1'b1;  // PENABLE is high in the ACCESS state
    fsm_state = ACCESS_STATE;
    wait_state_detected(req);

    `uvm_info(get_full_name(), "MST_DRI_BFM is in ACCESS state", UVM_MEDIUM);

    if (req.pwrite == READ) begin
      req.prdata = PRDATA;
      `uvm_info(get_full_name(), $sformatf("Read data = 0x%0h", req.prdata), UVM_MEDIUM);
    end

    req.pslverr = PSLVERR;

  endtask : dri_access_state

  //////////////////////////////////////////////////////////////////////////////
  // Method : wait_state_detected
  // Description : This task is used to detect when PREADY is low so the FSM stays in the wait_state
  ////////////////////////////////////////////////////////////////////////////// 
  task wait_state_detected(inout apb_trans_struct req);

    @(posedge PCLK);
    `uvm_info(get_full_name(), "PREADY is LOW, wait state detected", UVM_MEDIUM);
    while (PREADY == 1'b0) begin
      @(posedge PCLK);
      fsm_state = WAIT_STATE;
      req.num_of_wait_states++;
    end

    `uvm_info(get_full_name(), "PREADY is HIGH, Exiting the wait state", UVM_MEDIUM);
    `uvm_info(get_full_name(), $sformatf("Number of wait states = %0d", req.num_of_wait_states),
              UVM_MEDIUM);

  endtask : wait_state_detected


  task dri(apb_trans_struct req);

    dri_idle_state();
    dri_setup_state(req);
    dri_access_state(req);

  endtask : dri

endinterface : hdl_mst_dri_bfm

`endif
