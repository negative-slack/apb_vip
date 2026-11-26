`ifndef __APB_DEFINES_SVH__
`define __APB_DEFINES_SVH__
  
`ifndef __APB_ADDR_WIDTH__
`define __APB_ADDR_WIDTH__ 32
`endif

`ifndef __APB_DATA_WIDTH__
`define __APB_DATA_WIDTH__ 32
`endif

`ifndef __APB_STRB_WIDTH__
`define __APB_STRB_WIDTH__ (`__APB_DATA_WIDTH__ / 8)
`endif

`ifndef __APB_PPROT_WIDTH__
`define __APB_PPROT_WIDTH__ 3
`endif

// Number of APB slaves = 16
`ifndef __NUM_OF_SLAVES__
`define __NUM_OF_SLAVES__ 16
`endif

// 4096 bytes of memory for each slave
`ifndef __SLAVE_MEMORY_SIZE_IN_KB__
`define __SLAVE_MEMORY_SIZE_IN_KB__ 4
`endif

// byte addressed memory
`ifndef __SLAVE_MEMORY_WIDTH__
`define __SLAVE_MEMORY_WIDTH__ 8
`endif

// 4 bytes of gap between each slave memory
`ifndef __SLAVE_MEMORY__GAP__
`define __SLAVE_MEMORY__GAP__ 4
`endif

`ifndef __MASTER_AGENT_ACTIVE__
`define __MASTER_AGENT_ACTIVE__ 1
`endif

`ifndef __SLAVE_AGENT_ACTIVE__
`define __SLAVE_AGENT_ACTIVE__ 1
`endif

`endif
