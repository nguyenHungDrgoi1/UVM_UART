`include "include_file_top.sv"
module uart_test_top();
	//define intf
	uart_sw_intf uart_intf();
	uart_rx_intf rx_if();
	uart_tx_intf tx_if();
	config_interface config_intf();
	logic rx;
	logic tx;
	logic cts_n;
	logic rts_n;
	logic clk;
	logic reset_n;
	//instance dut
	uart dut(
		.clk(uart_intf.clk),
		.reset_n(uart_intf.reset_n),
		.tx_data     (uart_intf.tx_data),
		.rx          (tx_if.tx),
		.tx          (rx_if.rx),
		.tx_done     (uart_intf.tx_done),
		.rx_data     (uart_intf.rx_data),
		.rx_done     (uart_intf.rx_done),
		.start_tx    (uart_intf.start_tx),
		.data_bit_num(uart_intf.data_bit_num),
		.parity_en   (uart_intf.parity_en),
		.stop_bit_num(uart_intf.stop_bit_num),
		.parity_type (uart_intf.parity_type),
		.parity_error(uart_intf.parity_error),
		.cts_n       (cts_n),
		.rts_n       (tx_if.cts_n)
	);
	assign tx_if.clk = clk;
	assign rx_if.clk = clk;
	assign uart_intf.clk = clk;
	assign uart_intf.reset_n = reset_n;
	assign cts_n = 0;
	assign config_intf.data_bit_num = uart_intf.data_bit_num;
	assign config_intf.parity_en = uart_intf.parity_en;
	assign config_intf.parity_type = uart_intf.parity_type;
	assign config_intf.stop_bit_num = uart_intf.stop_bit_num;
	initial begin
		clk = 0;
		forever #10ns clk = !clk;
	end
	initial begin
		reset_n = 1;
		#30 
		reset_n = 0;
		#30
		reset_n = 1;
	end
	// connect
	initial begin
	uvm_config_db#(virtual uart_sw_intf)::set(null, "uvm_test_top", "uart_sw_intf", uart_intf);
	uvm_config_db#(virtual uart_rx_intf)::set(null, "uvm_test_top", "uart_rx_intf", rx_if);
	uvm_config_db#(virtual uart_tx_intf)::set(null, "uvm_test_top", "uart_tx_intf", tx_if);
	uvm_config_db#(virtual config_interface)::set(null, "uvm_test_top", "config_interface", config_intf);
	run_test();
	end
endmodule
