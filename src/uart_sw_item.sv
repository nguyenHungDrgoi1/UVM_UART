class uart_sw_item extends uvm_sequence_item;
    rand bit cts_n;
    rand bit [7:0] tx_data;
    rand bit [1:0] data_bit_num;
    rand bit stop_bit_num;
    rand bit parity_en;
    rand bit parity_type;
    rand bit start_tx;

    rand bit rx;
    rand bit [7:0] rx_data;

    rand int burst_len;
  `uvm_object_utils_begin(uart_sw_item)
    `uvm_field_array_int ( cts_n,         UVM_ALL_ON)
    `uvm_field_array_int ( tx_data,       UVM_ALL_ON)
    `uvm_field_array_int ( data_bit_num,  UVM_ALL_ON)
    `uvm_field_array_int ( stop_bit_num,  UVM_ALL_ON)
    `uvm_field_array_int ( parity_en,     UVM_ALL_ON)
    `uvm_field_array_int ( parity_type,   UVM_ALL_ON)
    `uvm_field_array_int ( start_tx,      UVM_ALL_ON)

    `uvm_field_array_int ( rx,            UVM_ALL_ON)
    `uvm_field_array_int ( tx_data,       UVM_ALL_ON)
    `uvm_field_int ( burst_len,           UVM_ALL_ON)
  `uvm_object_utils_end
    extern function new(string name = "uart_sw_item");
endclass
function uart_sw_item::new(string name="uart_sw_item");  
  super.new(name);
endfunction