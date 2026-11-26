`ifndef __HDL_TOP__
`define __HDL_TOP__ 

module hdl_top;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import apb_vip_pkg::*;

  bit pclk;
  bit presetn;

  localparam CLK_CYCLE = 10;

  //-------------------------------------------------------
  // Generation of system clock at frequency rate of 100MHz
  //-------------------------------------------------------
  initial begin
    pclk = 1'b0;
    forever begin
      #(CLK_CYCLE / 2);
      pclk = ~pclk;
    end
  end

  initial begin
    presetn = 1'b1;
    #15;
    presetn = 1'b0;
    repeat (2) begin
      @(posedge pclk);
    end
    presetn = 1'b1;
  end

  initial begin
    $dumpfile("hdl_top.vcd");
    $dumpvars(0, top);
  end

  apb_if intf_slv[`__NUM_OF_SLAVES__] (
      .PCLK(pclk),
      .PRESETn(presetn)
  );

  apb_if intf_mst (
      .PCLK(pclk),
      .PRESETn(presetn)
  );

  hdl_mst_agnt_bfm hdl_mst_agnt_bfm_h (.intf(intf_mst));

  // Intermediate nets, so the return mux can use a normal loop
  bit        [`__NUM_OF_SLAVES__-1:0] pready_s;
  apb_data_t [`__NUM_OF_SLAVES__-1:0] prdata_s;
  bit        [`__NUM_OF_SLAVES__-1:0] pslverr_s;

  // Master -> slave: one generate block per slave
  for (genvar i = 0; i < NO_OF_SLAVES; i++) begin
    assign intf_slv[i].pselx = intf_mst.pselx[i];
    assign intf_slv[i].penable = intf_mst.penable;

    assign intf_slv[i].paddr = intf_mst.paddr;
    assign intf_slv[i].pwrite = intf_mst.pwrite;
    assign intf_slv[i].pwdata = intf_mst.pwdata;
    assign intf_slv[i].pstrb = intf_mst.pstrb;
    assign intf_slv[i].pprot = intf_mst.pprot;

    assign pready_s[i] = intf_slv[i].pready;
    assign pslverr_s[i] = intf_slv[i].pslverr;
    assign prdata_s[i] = intf_slv[i].prdata;
  end

  always_comb begin
    intf_slv.pready  = 1'b0;
    intf_slv.prdata  = '0;
    intf_slv.pslverr = 1'b0;
    for (int i = 0; i < NO_OF_SLAVES; i++) begin
      if (intf.pselx[i]) begin
        intf_slv.pready  = pready_s[i];
        intf_slv.pslverr = pslverr_s[i];
        intf_slv.prdata  = prdata_s[i];
      end
    end
  end

  //   genvar i;
  //   generate;
  //     for (int i=0; i<`__NUM_OF_SLAVES__; ++i) begin
  //         hdl_slv_agnt_bfm #(.SLV_ID(i));
  //     end
  //   endgenerate

endmodule

`endif
