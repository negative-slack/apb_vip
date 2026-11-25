`ifndef __HDL_SLV_AGNT_BFM__
`define __HDL_SLV_AGNT_BFM__ 

module hdl_slv_agnt_bfm (
    apb_if intf
);

  hdl_slv_dri_bfm hdl_slv_dri_bfm_hndl (
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

  hdl_slv_mon_bfm hdl_slv_mon_bfm_hndl (
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
    uvm_config_db#(virtual hdl_slv_dri_bfm)::set(null, "*", "hdl_slv_dri_bfm",
                                                 hdl_slv_dri_bfm_hndl);
    uvm_config_db#(virtual hdl_slv_mon_bfm)::set(null, "*", "hdl_slv_mon_bfm",
                                                 hdl_slv_mon_bfm_hndl);
  end

endmodule : hdl_slv_agnt_bfm

`endif
