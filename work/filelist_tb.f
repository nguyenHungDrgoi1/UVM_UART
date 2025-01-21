////////////////////////////////////////////////////////////////////////////////
//  Library Folder
////////////////////////////////////////////////////////////////////////////////

//  Global Defines and Global Params
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
//  Include Directories
////////////////////////////////////////////////////////////////////////////////
// +incdir+../inc
// +incdir+../libs/trunk
// // +incdir+../libs/uvm-1.1d/src
// +incdir+/data_sip/sip5/workspace/phuongvd0/UVM_Training/dti_uart/sim/libs/uvm-1.1d/src
// +incdir+../libs/dti_apb_vip/trunk/inc
// +incdir+../libs/dti_apb_vip/trunk/intf
// +incdir+../libs/dti_apb_vip/trunk/src
// +incdir+../libs/dti_apb_vip/trunk/master
// +incdir+../libs/dti_apb_vip/trunk/slave
// +incdir+../libs/dti_apb_vip/trunk/env
// //+incdir+../libs/dti_uart_vip/env
// +incdir+../libs/dti_uart_vip/inc
// +incdir+../libs/dti_uart_vip/intf
// +incdir+../libs/dti_uart_vip/receiver
// +incdir+../libs/dti_uart_vip/src
// +incdir+../libs/dti_uart_vip/transmitter

// +incdir+../src/top_tb
// +incdir+../src/uvm_component
// +incdir+../src/uvm_test
// +incdir+../src/uvm_seqs/apb_seqs
// +incdir+../src/uvm_seqs/uart_seqs
// +incdir+../src/sva
//  APB VIP
// -y  ../inc
// -y  ../libs/dti_apb_vip/trunk/inc
// -y  ../libs/dti_apb_vip/trunk/intf
// -y  ../libs/dti_uart_vip/intf
// -y  ../libs/dti_uart_vip/inc
+incdir+../src
+incdir+../src/uart_rx
+incdir+../src/sw_seqs
+incdir+../inc
+incdir+../libs/uvm-1.1d/src
// +define+CLK_APB=2000

////////////////////////////////////////////////////////////////////////////////
//  Top Testbench Level Module
////////////////////////////////////////////////////////////////////////////////

../src/uart_test_top.sv
