interface uart_sw_intf();
    logic clk;
    logic reset_n;
    logic [7:0] tx_data;
    logic [1:0] data_bit_num;
    logic stop_bit_num;
    logic parity_en;
    logic parity_type;
    logic start_tx;
    logic rx_done;
    logic tx_done;
    logic [7:0] rx_data;
    logic parity_error;
endinterface