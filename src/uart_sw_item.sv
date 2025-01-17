class uart_sw_item extends uvm_sequence_item;
    rand logic [7:0] tx_data;
    rand logic [1:0] data_bit_num;
    rand logic stop_bit_num;
    rand logic parity_en;
    rand logic parity_type;
    rand logic start_tx;
    rand logic [7:0] rx_data;
    rand int delay_for_tran;
    constraint default_delay{
      delay_for_tran == 100;
    }
  `uvm_object_utils_begin(uart_sw_item)
    `uvm_field_int ( tx_data,       UVM_ALL_ON)
    `uvm_field_int ( data_bit_num,  UVM_ALL_ON)
    `uvm_field_int ( stop_bit_num,  UVM_ALL_ON)
    `uvm_field_int ( parity_en,     UVM_ALL_ON)
    `uvm_field_int ( parity_type,   UVM_ALL_ON)
    `uvm_field_int ( start_tx,      UVM_ALL_ON)

    `uvm_field_int ( rx_data,       UVM_ALL_ON)
    `uvm_field_int ( delay_for_tran,           UVM_ALL_ON)
  `uvm_object_utils_end
    extern function new(string name = "uart_sw_item");
endclass
function uart_sw_item::new(string name="uart_sw_item");  
  super.new(name);
endfunction