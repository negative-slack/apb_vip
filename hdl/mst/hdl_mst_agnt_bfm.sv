`ifndef __HDL_MST_AGNT_BFM__
`define __HDL_MST_AGNT_BFM__ 

module hdl_mst_agnt_bfm (
    apb_if hdl_mst_agnt_intf
);

  hdl_mst_dri_bfm hdl_mst_dri_bfm_hndl (
      .PCLK(hdl_mst_agnt_intf.PCLK),
      .PRESETn(hdl_mst_agnt_intf.PRESETn),

      .PREADY (hdl_mst_agnt_intf.PREADY),
      .PRDATA (hdl_mst_agnt_intf.PRDATA),
      .PSLVERR(hdl_mst_agnt_intf.PSLVERR),

      .PSELX  (hdl_mst_agnt_intf.PSELX),
      .PENABLE(hdl_mst_agnt_intf.PENABLE),
      .PADDR  (hdl_mst_agnt_intf.PADDR),
      .PWRITE (hdl_mst_agnt_intf.PWRITE),
      .PWDATA (hdl_mst_agnt_intf.PWDATA),
      .PSTRB  (hdl_mst_agnt_intf.PSTRB),
      .PPROT  (hdl_mst_agnt_intf.PPROT)
  );

  hdl_mst_mon_bfm hdl_mst_mon_bfm_hndl (
      .PCLK(hdl_mst_agnt_intf.PCLK),
      .PRESETn(hdl_mst_agnt_intf.PRESETn),

      .PREADY (hdl_mst_agnt_intf.PREADY),
      .PRDATA (hdl_mst_agnt_intf.PRDATA),
      .PSLVERR(hdl_mst_agnt_intf.PSLVERR),

      .PSELX  (hdl_mst_agnt_intf.PSELX),
      .PENABLE(hdl_mst_agnt_intf.PENABLE),
      .PADDR  (hdl_mst_agnt_intf.PADDR),
      .PWRITE (hdl_mst_agnt_intf.PWRITE),
      .PWDATA (hdl_mst_agnt_intf.PWDATA),
      .PSTRB  (hdl_mst_agnt_intf.PSTRB),
      .PPROT  (hdl_mst_agnt_intf.PPROT)
  );

  // setting the virtual handles of the BFMs into the configuration database!
  initial begin
    uvm_config_db#(virtual hdl_mst_dri_bfm)::set(null, "*", "hdl_mst_dri_bfm",
                                                 hdl_mst_dri_bfm_hndl);
    uvm_config_db#(virtual hdl_mst_mon_bfm)::set(null, "*", "hdl_mst_mon_bfm",
                                                 hdl_mst_mon_bfm_hndl);
  end

endmodule : hdl_mst_agnt_bfm

`endif
