class uart_random_cfg_seq extends uart_sequence;
  `uvm_object_utils(uart_random_cfg_seq)
  //`uvm_declare_p_sequencer(uart_sw_sequencer)
  function new(string name="uart_random_cfg_seq");
    super.new(name);
  endfunction
  task body();
  uart_sw_item m_item = uart_sw_item::type_id::create("m_item");
    //config mode for uart send
    //config_mode(3,1,1,1,m_item);
    //`uvm_info("sequence", $sformatf("m_item data bit: %d", m_item.data_bit_num), UVM_MEDIUM)
    //start send
    //tx_tran(8'h40,m_item);
    //m_item.print();
    //`uvm_info("sequence", $sformatf("m_item data bit: %d", m_item.tx_data), UVM_MEDIUM)
    m_item.randomize() with {m_item.start_tx == 0;};
    //m_item.print();
    start_item(m_item);
    finish_item(m_item);
    // tx_tran(8'h45,m_item);
    // config_mode(3,0,0,1,m_item);
    // start_item(m_item);
    // finish_item(m_item);
    // tx_tran(8'h45,m_item);
    // config_mode(3,1,1,0,m_item);
    // start_item(m_item);
    // finish_item(m_item);
    //m_item.print();
    `uvm_info("sequence", $sformatf("m_item data bit: %d", m_item.tx_data), UVM_MEDIUM)
  endtask
endclass