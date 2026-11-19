`ifndef __APB_MST_W32B_SEQ_SV__
`define __APB_MST_W32B_SEQ_SV__ 

import apb_vip_pkg::*;

class apb_mst_w32b_seq extends apb_mst_base_seq;
  `uvm_object_utils(apb_mst_w32b_seq);

  function new(string name = "apb_mst_w32b_seq");
    super.new(name);
  endfunction : new

  task body();
    super.body();

    req = apb_master_tnx::type_id::create("req");

    // set the configuration handle of the transaction to the configuration handle of the sequencer
    req.apb_m_agnt_cfg_h = p_sequencer.apb_m_agnt_cfg_h;

    start_item(req);

    if (!req.randomize() with {
          pselx == SLAVE_0;
          transfer_size == _word;
          //   paddr == addr_seq;
          pwrite == WRITE;
          //   count_pwrite == count_pwrite_seq;
        });
    begin
      `uvm_error("apb_mst_w32b_seq", "Failed to randomize the transaction");
    end

    finish_item(req);

  endtask : body

endclass : apb_mst_w32b_seq

`endif
