`ifndef __HVL_MST_MON_PROXY__
`define __HVL_MST_MON_PROXY__ 

class hvl_mst_mon_proxy extends uvm_monitor;

  //////////////////////////////////////////////////////////////////////////////
  // Variable : hvl_tnx_hndl
  // Description : Handle to the transaction item being driven by this driver
  //////////////////////////////////////////////////////////////////////////////
  hvl_mst_tnx hvl_tnx_hndl;

  //////////////////////////////////////////////////////////////////////////////
  // Declaration of component utils to register with factory 
  //////////////////////////////////////////////////////////////////////////////
  `uvm_component_utils(hvl_mst_mon_proxy);

  //////////////////////////////////////////////////////////////////////////////
  // Variable : hdl_mst_mon_bfm_hndl
  // Description : Handle to the interface hdl_mst_dri_bfm
  virtual hdl_mst_mon_bfm hdl_mst_mon_bfm_hndl;
  //////////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////////////////////
  // Variable : hdl_mst_agnt_cfg_hndl
  // Description : Handle to the class hdl_mst_agnt_cfg
  hdl_mst_agnt_cfg hdl_mst_agnt_cfg_hndl;
  //////////////////////////////////////////////////////////////////////////////

  ///////////////////////////////////////////////////////////////////////////////
  // Declaration of Analysis ports and exports
  // broadcasting the ACTUAL transactions to the scoreboard, so we can compare them 
  // later with the expected transactions from the reference model
  ///////////////////////////////////////////////////////////////////////////////
  uvm_analysis_port #(hvl_mst_tnx) hvl_mon2scb_analysis_port;

  extern function new(string name = "hvl_mst_mon_proxy", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass : hvl_mst_mon_proxy

//////////////////////////////////////////////////////////////////////////////
// Method name : new 
// Description : constructor 
//////////////////////////////////////////////////////////////////////////////
function hvl_mst_mon_proxy::new(string name = "hvl_mst_mon_proxy", uvm_component parent);
  super.new(name, parent);
  hvl_mon2scb_analysis_port = new("hvl_mon2scb_analysis_port", this);
endfunction : new

//////////////////////////////////////////////////////////////////////////////
// Method name : build_phase 
// Description :  
//////////////////////////////////////////////////////////////////////////////
function void hvl_mst_mon_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if (!uvm_config_db#(virtual hdl_mst_mon_bfm)::get(
          this, "", "hdl_mst_mon_bfm", hdl_mst_mon_bfm_h
      )) begin
    `uvm_fatal(get_full_name(),
               "Virtual handle to the hdl_mst_mon_bfm not found in configuration database");
  end

endfunction : build_phase

function void hvl_mst_mon_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  hdl_mst_mon_bfm_hndl.hvl_mst_mon_proxy_h = this;
endfunction : end_of_elaboration_phase

task hvl_mst_mon_proxy::run_phase(uvm_phase phase);

  hdl_mst_mon_bfm_hndl.mon_presetn();

  forever begin
    tnx_struct  tnx_struct_h;

    hvl_mst_tnx hvl_mst_mon_clone_packet;

    hdl_mst_mon_bfm_hndl.sample_data(tnx_struct_h);

    hvl_mst_seq_item_cnvrtr::to_class(tnx_struct_h, hvl_tnx_hndl);

    `uvm_info(get_type_name(), $sformatf(
              "Received packet from hdl_mst_mon_bfm: , \n %s", hvl_tnx_hndl.sprint()), UVM_HIGH)

    //Clone and publish the cloned item to the subscribers
    $cast(hvl_mst_mon_clone_packet, hvl_tnx_hndl.clone());
    `uvm_info(get_type_name(), $sformatf(
              "Sending packet via analysis_port: , \n %s", hvl_mst_mon_clone_packet.sprint()),
              UVM_HIGH)

    hvl_mon2scb_analysis_port.write(apb_master_clone_packet);
  end

endtask : run_phase


`endif
