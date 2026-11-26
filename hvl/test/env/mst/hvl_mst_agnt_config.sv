`ifndef __HVL_MST_AGNT_CONFIG__
`define __HVL_MST_AGNT_CONFIG__ 

class hvl_mst_agnt_config extends uvm_object;

  `uvm_object_utils(hvl_mst_agnt_config);

  uvm_active_passive_enum is_active = UVNM_ACTIVE;

  apb_addr_t mst_max_addr_range_arr[int];

endclass : hvl_mst_agnt_config

function void hvl_mst_agnt_config::mst_max_addr_range(int slave_number,
                                                      apb_addr_t slv_max_addr_range);
  master_max_addr_range_array[slave_number] = slave_max_address_range;
endfunction : master_max_addr_range

`endif
