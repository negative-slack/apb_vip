`ifndef __HVL_MST_DRI_PROXY_SV__
`define __HVL_MST_DRI_PROXY_SV__ 

class hvl_mst_dri_proxy extends uvm_driver #(hvl_mst_tnx);

  //////////////////////////////////////////////////////////////////////////////
  // Declaration of component utils to register with factory 
  //////////////////////////////////////////////////////////////////////////////
  `uvm_component_utils(mst_dri_proxy);

  // Variable : hvl_tnx_hndl
  // Description : Handle to the transaction item being driven by this driver
  hvl_mst_tnx hvl_tnx_hndl;

  // Variable : hdl_mst_dri_bfm_hndl
  // Description : Handle to the hdl_mst_dri_bfm
  virtual hdl_mst_dri_bfm hdl_mst_dri_bfm_hndl;

  function new(string name = "hvl_mst_dri_proxy", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual hdl_mst_dri_bfm)::get(
            this, "", "hdl_mst_dri_bfm", hdl_mst_dri_bfm_hndl
        ))
      `uvm_fatal(get_full_name(),
                 "Virtual handle to the hdl_mst_dri_bfm not found in configuration database")
  endfunction : build_phase

function void end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);

  // Point the BFM's proxy handle to this proxy (BFM -> proxy link)
  hdl_mst_dri_bfm_hndl.hvl_mst_dri_proxy_hndl = this;
endfunction : end_of_elaboration_phasef

  function void run_phase(uvm_phase phase);
    super.run_phase(phase);

    hdl_mst_dri_bfm_hndl.dri_presetn();

    hdl_mst_dri_bfm_hndl.dri_idle_state();

    forever begin

      apb_trans_struct tnx_struct_h;
      seq_item_port.get_next_item(req);

      mst_seq_item_cnvrt::from_class(req, tnx_struct_h);
      // drive the transaction item using the APB MST driver BFM
      hdl_mst_dri_bfm_hndl.drive_tnx(tnx_struct_h);

      mst_seq_item_cnvrt::to_class(tnx_struct_h, req);

      seq_item_port.item_done();
    end

  endfunction : run_phase


endclass : mst_dri_proxy
`endif
