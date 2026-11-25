`ifndef __HVL_MST_DRI_PROXY__
`define __HVL_MST_DRI_PROXY__ 

class hvl_mst_dri_proxy extends uvm_driver #(hvl_mst_tnx);

  //////////////////////////////////////////////////////////////////////////////
  // Declaration of component utils to register with factory 
  //////////////////////////////////////////////////////////////////////////////
  `uvm_component_utils(mst_dri_proxy);

  //////////////////////////////////////////////////////////////////////////////
  // Variable : hvl_tnx_hndl
  // Description : Handle to the transaction item being driven by this driver
  //////////////////////////////////////////////////////////////////////////////
  hvl_mst_tnx hvl_tnx_hndl;

  //////////////////////////////////////////////////////////////////////////////
  // Variable : hdl_mst_dri_bfm_hndl
  // Description : Handle to the interface hdl_mst_dri_bfm
  virtual hdl_mst_dri_bfm hdl_mst_dri_bfm_hndl;
  //////////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////////////////////
  // Variable : hdl_mst_agnt_cfg_hndl
  // Description : Handle to the class hdl_mst_agnt_cfg
  hdl_mst_agnt_cfg hdl_mst_agnt_cfg_hndl;
  //////////////////////////////////////////////////////////////////////////////

  extern function new(string name = "hvl_mst_dri_proxy", uvm_component parent);

  extern function void build_phase(uvm_phase phase);

  extern function void end_of_elaboration_phase(uvm_phase phase);

  extern function void connect_phase(uvm_phase phase);

  extern function void run_phase(uvm_phase phase);

endclass : mst_dri_proxy

//////////////////////////////////////////////////////////////////////////////
// Method name : new 
// Description : constructor 
//////////////////////////////////////////////////////////////////////////////
function hvl_mst_dri_proxy::new(string name = "hvl_mst_dri_proxy", uvm_component parent);
  super.new(name, parent);
endfunction : new

//////////////////////////////////////////////////////////////////////////////
// Method name : build_phase 
// Description :  
//////////////////////////////////////////////////////////////////////////////
function void hvl_mst_dri_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if (!uvm_config_db#(virtual hdl_mst_dri_bfm)::get(
          this, "", "hdl_mst_dri_bfm", hdl_mst_dri_bfm_hndl
      ))
    `uvm_fatal(get_full_name(),
               "Virtual handle to the hdl_mst_dri_bfm not found in configuration database")
endfunction : build_phase

//////////////////////////////////////////////////////////////////////////////
// Method name : end_of_elaboration 
// Description : Point the hdl_mst_dri_bfm_hndl in the BFM to this proxy (BFM -> proxy link) 
//////////////////////////////////////////////////////////////////////////////
function void hvl_mst_dri_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);

  hdl_mst_dri_bfm_hndl.hvl_mst_dri_proxy_hndl = this;
endfunction : end_of_elaboration_phase

//////////////////////////////////////////////////////////////////////////////
// Method name : connect_phase 
// Description : Connecting apb_master driver handle with apb_master agent config 
//////////////////////////////////////////////////////////////////////////////
function void hvl_mst_dri_proxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//////////////////////////////////////////////////////////////////////////////
// Method name : run_phase 
// Description : 
//////////////////////////////////////////////////////////////////////////////
function void run_phase(uvm_phase phase);
  super.run_phase(phase);

  // drive the presetn
  hdl_mst_dri_bfm_hndl.dri_presetn();

  // drive the idle_state
  hdl_mst_dri_bfm_hndl.dri_idle_state();

  forever begin

    tnx_struct tnx_struct_h;
    seq_item_port.get_next_item(req);

    // convert class to struct_packed to be passed to the hdl_mst_dri_bfm 
    mst_seq_item_cnvrt::from_class(req, tnx_struct_h);

    hdl_mst_dri_bfm_hndl.drive_tnx(tnx_struct_h);

    // convert struct_packed back to class to be passed to the hvl_mst_mon_proxy 
    mst_seq_item_cnvrt::to_class(tnx_struct_h, req);

    seq_item_port.item_done();
  end

endfunction : run_phase

`endif
