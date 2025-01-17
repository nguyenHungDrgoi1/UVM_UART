class uart_standard_send_seq extends uart_sequence;
  `uvm_object_utils(uart_standard_send_seq)
  //`uvm_declare_p_sequencer(uart_sw_sequencer)
  function new(string name="uart_standard_send");
    super.new(name);
  endfunction
  task body();
  uart_sw_item m_item = uart_sw_item::type_id::create("m_item");
    config_mode(`DATA_8BIT,1,1,1,m_item);
    tx_tran(8'h12,m_item);
    `uvm_do(m_item);
  endtask
endclass