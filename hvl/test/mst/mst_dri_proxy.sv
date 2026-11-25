`ifndef __MST_DRI_PROXY_SV__
`define __MST_DRI_PROXY_SV__ 

class mst_dri_proxy extends uvm_driver #(mst_tnx);

  `uvm_component_utils(mst_dri_proxy);

  // Variable : tnx_hndl
  // Description : Handle to the transaction item being driven by this driver
  mst_tnx tnx_hndl;

  // Variable : apb_mst_dri_bfm_hndl
  // Description : Handle to the APB MST driver BFM
  apb_mst_dri_bfm apb_mst_dri_bfm_hndl;

  function new(string name = "mst_dri_proxy", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual apb_mst_dri_bfm)::get(
            this, "", "apb_mst_dri_bfm", apb_mst_dri_bfm_hndl
        ))
      `uvm_fatal("MST_DRI_PROXY",
                 "Virtual handle to the APB MST driver BFM not found in configuration database")
  endfunction : build_phase

  function void run_phase(uvm_phase phase);
    super.run_phase(phase);

    forever begin
      seq_item_port.get_next_item(tnx_hndl);

      // drive the transaction item using the APB MST driver BFM
      apb_mst_dri_bfm_hndl.drive_tnx(tnx_hndl);

      seq_item_port.item_done();
    end

  endfunction : run_phase



endclass : mst_dri_proxy
`endif
