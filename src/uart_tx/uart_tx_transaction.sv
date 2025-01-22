class uart_tx_transaction extends uvm_sequence_item;
    rand uart_data_frame data_frame;
      `uvm_object_utils_begin(uart_tx_transaction)
    `uvm_field_int ( data_frame, UVM_ALL_ON)
  `uvm_object_utils_end
    extern function new(string name = "uart_tx_transaction");
endclass
function uart_tx_transaction::new(string name="uart_tx_transaction");  
  super.new(name);
endfunction