`ifndef __APB_MST_BASE_SEQ_SV__
`define __APB_MST_BASE_SEQ_SV__ 

class apb_mst_base_seq extends uvm_sequence #(apb_mst_tnx);

  `uvm_object_utils(apb_mst_base_seq);

  /* Declares p_sequencer of type apb_mst_seqr and does
    the $cast(p_sequencer, m_sequencer) for you automatically
    (in pre_body’s hidden setup, via m_set_p_sequencer()). 
    If the cast fails, UVM reports the error itself.*/
  `uvm_declare_p_sequencer(apb_mst_seqr);

  function new(string name = "apb_mst_base_seq");
    super.new(name);
  endfunction : new

  task body();
    super.body();
    // if (!$cast(p_sequencer, m_sequencer)) begin
    //   `uvm_fatal(get_full_name(), "Master sequencer pointer cast failed")
    // end
  endtask : body

endclass

`endif
