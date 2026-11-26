`ifndef __HVL_TOP__
`define __HVL_TOP__ 

module hvl_top;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  initial begin
    run_test("apb_base_test");
  end

endmodule : hvl_top

`endif
