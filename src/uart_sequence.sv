class uart_sequence extends uvm_sequence #(uart_sw_item);
  `uvm_object_utils(uart_sequence)
  `uvm_declare_p_sequencer(uart_sw_sequencer)
  function new(string name="uart_sequence");
    super.new(name);
  endfunction
// Config total number of items to be sent
  task config_mode(
    logic [1:0] data_bit_num ,
    logic stop_bit_num,
    logic parity_en,
    logic parity_type,
    uart_sw_item item 
  );
  item.data_bit_num = data_bit_num;
  item.stop_bit_num = stop_bit_num;
  item.parity_en = parity_en;
  item.parity_type = parity_type;
  endtask
  task tx_tran(
    logic [7:0] tx_data,
    uart_sw_item item 
  );
  item.tx_data = tx_data;
  item.start_tx = 1;
  //item.cts_n = 1;
  endtask
  virtual task body();
     	uart_sw_item m_item = uart_sw_item::type_id::create("m_item");
     	//start_item(m_item);
       // 
    	m_item.randomize();
      m_item.print();
       `uvm_info("SEQ", $sformatf("Generate new item: %d", m_item.tx_data), UVM_MEDIUM)
       `uvm_do(m_item);
      //  m_item.randomize();
      //  `uvm_do(m_item);
    //   	finish_item(m_item);
    //`uvm_info("SEQ", $sformatf("Done generation of %0d items", num), UVM_LOW)
  endtask
endclass