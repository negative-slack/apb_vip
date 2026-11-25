`ifndef __MST_TNX_SV__
`define __MST_TNX_SV__ 

class mst_tnx extends uvm_sequence_item;

  `uvm_object_utils(mst_tnx);

  rand slave_num_enum pslex;

  rand apb_addr_t paddr;
  rand pwrite_enum pwrite;
  rand apb_data_t pwdata;
  rand apb_strb_t pstrb;
  rand apb_pprot_t pprot;

  apb_data_t prdata;
  bit pready;
  pslverr_enum pslverr;

endclass : mst_tnx

`endif
