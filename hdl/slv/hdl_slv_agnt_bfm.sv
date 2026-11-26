`ifndef __HDL_SLV_AGNT_BFM__
`define __HDL_SLV_AGNT_BFM__ 

module hdl_slv_agnt_bfm #(
    parameter SLV_ID = 0
) (
    apb_if hdl_slv_agnt_intf
);

  hdl_slv_dri_bfm hdl_slv_dri_bfm_hndl (
      .PCLK(hdl_slv_agnt_intf.PCLK),
      .PRESETn(hdl_slv_agnt_intf.PRESETn),

      .PREADY (hdl_slv_agnt_intf.PREADY),
      .PRDATA (hdl_slv_agnt_intf.PRDATA),
      .PSLVERR(hdl_slv_agnt_intf.PSLVERR),

      .PSELX  (hdl_slv_agnt_intf.PSELX),
      .PENABLE(hdl_slv_agnt_intf.PENABLE),
      .PADDR  (hdl_slv_agnt_intf.PADDR),
      .PWRITE (hdl_slv_agnt_intf.PWRITE),
      .PWDATA (hdl_slv_agnt_intf.PWDATA),
      .PSTRB  (hdl_slv_agnt_intf.PSTRB),
      .PPROT  (hdl_slv_agnt_intf.PPROT)
  );

  hdl_slv_mon_bfm hdl_slv_mon_bfm_hndl (
      .PCLK(hdl_slv_agnt_intf.PCLK),
      .PRESETn(hdl_slv_agnt_intf.PRESETn),

      .PREADY (hdl_slv_agnt_intf.PREADY),
      .PRDATA (hdl_slv_agnt_intf.PRDATA),
      .PSLVERR(hdl_slv_agnt_intf.PSLVERR),

      .PSELX  (hdl_slv_agnt_intf.PSELX),
      .PENABLE(hdl_slv_agnt_intf.PENABLE),
      .PADDR  (hdl_slv_agnt_intf.PADDR),
      .PWRITE (hdl_slv_agnt_intf.PWRITE),
      .PWDATA (hdl_slv_agnt_intf.PWDATA),
      .PSTRB  (hdl_slv_agnt_intf.PSTRB),
      .PPROT  (hdl_slv_agnt_intf.PPROT)
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
