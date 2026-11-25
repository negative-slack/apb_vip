`ifndef __APB_MST_AGNT_BFM__
`define __APB_MST_AGNT_BFM__ 

module apb_slv_agnt_bfm (
    apb_if intf
);

  apb_slv_dri_bfm apb_slv_dri_bfm_hndl (
      .PCLK(intf.PCLK),
      .PRESETn(intf.PRESETn),

      .PREADY (intf.PREADY),
      .PRDATA (intf.PRDATA),
      .PSLVERR(intf.PSLVERR),

      .PSELX  (intf.PSELX),
      .PENABLE(intf.PENABLE),
      .PADDR  (intf.PADDR),
      .PWRITE (intf.PWRITE),
      .PWDATA (intf.PWDATA),
      .PSTRB  (intf.PSTRB),
      .PPROT  (intf.PPROT)
  );

  apb_slv_mon_bfm apb_slv_mon_bfm_hndl (
      .PCLK(intf.PCLK),
      .PRESETn(intf.PRESETn),

      .PREADY (intf.PREADY),
      .PRDATA (intf.PRDATA),
      .PSLVERR(intf.PSLVERR),

      .PSELX  (intf.PSELX),
      .PENABLE(intf.PENABLE),
      .PADDR  (intf.PADDR),
      .PWRITE (intf.PWRITE),
      .PWDATA (intf.PWDATA),
      .PSTRB  (intf.PSTRB),
      .PPROT  (intf.PPROT)
  );

  // setting the virtual handles of the BFMs into the configuration database!
  initial begin
    uvm_config_db#(virtual apb_slv_dri_bfm)::set(null, "*", "apb_slv_dri_bfm",
                                                 apb_slv_dri_bfm_hndl);
    uvm_config_db#(virtual apb_slv_mon_bfm)::set(null, "*", "apb_slv_mon_bfm",
                                                 apb_slv_mon_bfm_hndl);
  end

endmodule : apb_slv_agnt_bfm

`endif
