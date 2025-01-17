class uart_test extends uvm_test;
    `uvm_component_utils(uart_test)
    uart_sequence base_seq;
    uart_standard_send_seq send_seq;
    uart_env uart_envr;
    virtual uart_sw_intf sw_intf;
    function new(string name , uvm_component parent) ;
    	super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
    	super.build_phase(phase);
      base_seq = uart_sequence::type_id::create("base_seq");
      uart_envr = uart_env::type_id::create("uart_envr",this);
      send_seq = uart_standard_send_seq::type_id::create("send_seqs");
    	//get sw_intf from test top
    	if (!uvm_config_db#(virtual uart_sw_intf)::get(this, "", "uart_sw_intf", sw_intf))
      `uvm_fatal("TEST", "Did not get vif")
      `uvm_info("config_uart",$sformatf("hello chua biet fill gi"),UVM_MEDIUM)
      //uart_envr.print();
  	//pass this intf to everything
  		 uvm_config_db#(virtual uart_sw_intf)::set(this, "uart_envr.sw_agent.*", "uart_sw_intf", sw_intf);
       `uvm_info("config_uart",$sformatf("sw_intf : %d",sw_intf.reset_n),UVM_MEDIUM)
  	endfunction
    task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    //apply_reset();
    //base_seq.start(uart_envr.sw_agent.sequencer);
    send_seq.start(uart_envr.sw_agent.sequencer);
    //`uvm_info("check_run_phase",$sformatf("hello chua biet fill gi"),UVM_MEDIUM)
    #20;
    `uvm_info("test",$sformatf("complete test"),UVM_MEDIUM)
    phase.drop_objection(this);
  endtask
 endclass
