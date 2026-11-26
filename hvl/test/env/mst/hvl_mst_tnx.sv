`ifndef __HVL_MST_TNX__
`define __HVL_MST_TNX__ 

import apb_vip_pkg::*;

class hvl_mst_tnx extends uvm_sequence_item;

  rand slave_num_enum pselx;

  rand apb_addr_t paddr;
  rand pwrite_enum pwrite;
  rand apb_data_t pwdata;
  rand apb_strb_t pstrb;
  rand pprot_enum pprot;

  apb_data_t prdata;
  bit pready;
  pslverr_enum pslverr;

  `uvm_object_utils_begin(hvl_mst_tnx);
    `uvm_field_int(pselx, UVM_ALL_ON);
    `uvm_field_int(paddr, UVM_ALL_ON);
    `uvm_field_int(pwrite, UVM_ALL_ON);
    `uvm_field_int(pwdata, UVM_ALL_ON);
    `uvm_field_int(pstrb, UVM_ALL_ON);
    `uvm_field_int(pprot, UVM_ALL_ON);

    `uvm_field_int(prdata, UVM_ALL_ON);
    `uvm_field_int(pready, UVM_ALL_ON);
    `uvm_field_int(pslverr, UVM_ALL_ON);
  `uvm_object_utils_end

  extern function new(string name = "hvl_mst_tnx");

  constraint pselx_c {$countones(pselx) == 1;}

  // constraint to distribute the pwrite 
  constraint pwrite_c {
    pwrite dist {
      0 :/ 50,
      1 :/ 50
    };
  }

  // constraint to set pwdata to 0 if it is a read operation
  constraint pwdata_c {(pwrite == pwrite_enum::READ) -> (pwdata == '0);}

  // constraint to set pstrb to 0 if it is a read operation
  constraint pstrb_c1 {(pwrite == pwrite_enum::READ) -> (pstrb == '0);}

  constraint pstrb_c2 {
    (pwrite == pwrite_enum::WRITE) ->
    ($countones(
        pstrb
    ) dist {
      (4'b0001, 4'b0010, 4'b0100, 4'b1000) :/ 25,
      (4'b1100, 4'b1001, 4'b1010, 4'b0110, 4'b0101, 4'b0011) :/ 25,
      (4'b1110, 4'b1101, 4'b1011, 4'b0111) :/ 25,
      4'b1111 :/ 25
    });
  }

endclass : hvl_mst_tnx

//////////////////////////////////////////////////////////////////////////////
// Method name : new 
// Description : constructor 
//////////////////////////////////////////////////////////////////////////////
function hvl_mst_tnx::new(string name = "hvl_mst_tnx");
  super.new(name);
endfunction : new

`endif
