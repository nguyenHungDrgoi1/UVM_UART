class uart_sw_item extends uvm_sequence_item;
    rand [7:0] rx_data[];
    rand [7:0] tx_data[];
    `uvm_object_utils_begin(uart_sw_item)
    `uvm_field_array_int ( apb_data,   UVM_ALL_ON)
    `uvm_field_array_int ( apb_addr,    UVM_ALL_ON)
    `uvm_field_array_int ( apb_write,   UVM_ALL_ON)
    `uvm_field_array_int ( apb_strb,    UVM_ALL_ON)
    `uvm_field_int ( burst_len,   UVM_ALL_ON)
`uvm_object_utils_end
    extern function new(string name = "uart_sw_item");
endclass
function uart_sw_item::new(string name="uart_sw_item");  
  super.new(name);
endfunction