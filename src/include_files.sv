`include "uvm.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

//`include "uart_env"
`include "define.sv"
`include "uart_sw_intf.sv"
`include "uart_rx_intf.sv"
`include "uart_tx_intf.sv"
`include "config_interface.sv"
`include "uart_rx_transaction.sv"
`include "uart_tx_transaction.sv"
`include "uart_sw_item.sv"
`include "uart_rx_sequencer.sv"
`include "uart_tx_sequencer.sv"
`include "uart_sw_sequencer.sv"
`include "uart_rx_sequence.sv"
`include "uart_tx_sequence.sv"
`include "uart_sequence.sv"
`include "uart_standard_send_seq.sv"
`include "uart_random_seq.sv"
`include "uart_random_cfg_seq.sv"
`include "uart_rx_monitor.sv"
`include "uart_tx_monitor.sv"
`include "uart_rx_driver.sv"
`include "uart_tx_driver.sv"
`include "uart_rx_agent.sv"
`include "uart_tx_agent.sv"
`include "uart_sw_monitor.sv"
`include "uart_sw_driver.sv"
`include "uart_sw_agent.sv"
`include "uart_scoreboard.sv"
// `include "dti_uart_env.sv"

// `include "dti_uart_tx_seq.sv"
// `include "dti_uart_rx_seq.sv"

// `include "dti_uart_base_test.sv"
// `include "dti_uart_random_test.sv"