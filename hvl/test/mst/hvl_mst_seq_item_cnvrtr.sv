`ifndef __HVL_MST_SEQ_ITEM_CNVRTR_SV__
`define __MST_SEQ_ITEM_CNVRTR_SV__ 

class hvl_mst_seq_item_cnvrtr extends uvm_object;

  `uvm_object_utils(mst_seq_item_cnvrtr);

  function new(string name = "hvl_mst_seq_item_cnvrtr");
    super.new(name);
  endfunction : new

  function void from_class(input hvl_mst_tnx i_conv, output apb_trans_struct o_conv);
    $cast(o_conv.pselx, i_conv.pslex);

    $cast(o_conv.paddr, i_conv.paddr);
    $cast(o_conv.pwrite, i_conv.pwrite);
    $cast(o_conv.pwdata, i_conv.pwdata);
    $cast(o_conv.pstrb, i_conv.pstrb);
    $cast(o_conv.pprot, i_conv.pprot);

    $cast(o_conv.prdata, i_conv.prdata);
    $cast(o_conv.pslverr, i_conv.pslverr);
    $cast(o_conv.num_of_wait_states, i_conv.num_of_wait_states);
  endfunction : from_class

  function void to_class(input apb_trans_struct i_conv, output mst_tnx o_conv);
    $cast(o_conv.pselx, i_conv.pslex);

    $cast(o_conv.paddr, i_conv.paddr);
    $cast(o_conv.pwrite, i_conv.pwrite);
    $cast(o_conv.pwdata, i_conv.pwdata);
    $cast(o_conv.pstrb, i_conv.pstrb);
    $cast(o_conv.pprot, i_conv.pprot);

    $cast(o_conv.prdata, i_conv.prdata);
    $cast(o_conv.pslverr, i_conv.pslverr);
    $cast(o_conv.num_of_wait_states, i_conv.num_of_wait_states);
  endfunction : to_class



endclass : mst_seq_item_cnvrtr

`endif
