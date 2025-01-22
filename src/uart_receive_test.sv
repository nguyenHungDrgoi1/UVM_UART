class uart_receive_test extends uvm_test;
    `uvm_component_utils(uart_receive_test)
    uart_sequence base_seq;
    uart_standard_send_seq send_seq;
    uart_rx_sequence base_rx;
    uart_tx_sequence base_tx;
    uart_random_seq ran_seq;
    uart_random_cfg_seq ran_cfg_seq;
    uart_env uart_envr;
    virtual uart_sw_intf sw_intf;
    virtual uart_rx_intf rx_if;
    virtual uart_tx_intf tx_if;
    virtual	config_interface config_intf;
    function new(string name , uvm_component parent) ;
    	super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
    	super.build_phase(phase);
      base_seq = uart_sequence::type_id::create("base_seq");
      uart_envr = uart_env::type_id::create("uart_envr",this);
      send_seq = uart_standard_send_seq::type_id::create("send_seqs");
      ran_seq = uart_random_seq::type_id::create("ran_seq");
      ran_cfg_seq = uart_random_cfg_seq::type_id::create("ran_cfg_seq");
      base_rx = uart_rx_sequence::type_id::create("base_rx");
      base_tx = uart_tx_sequence::type_id::create("base_tx");
    	//get sw_intf from test top
    	if (!uvm_config_db#(virtual uart_sw_intf)::get(this, "", "uart_sw_intf", sw_intf))
      `uvm_fatal("TEST", "Did not get vif")
      if (!uvm_config_db#(virtual uart_rx_intf)::get(this, "", "uart_rx_intf", rx_if))
      `uvm_fatal("TEST", "Did not get rx vif")
      if (!uvm_config_db#(virtual uart_tx_intf)::get(this, "", "uart_tx_intf", tx_if))
      `uvm_fatal("TEST", "Did not get tx vif")
      if (!uvm_config_db#(virtual config_interface)::get(this, "", "config_interface", config_intf))
      `uvm_fatal("TEST", "Did not get cfg vif")
      //uart_envr.print();
  	//pass this intf to everything
  		 uvm_config_db#(virtual uart_sw_intf)::set(this, "uart_envr.sw_agent.*", "uart_sw_intf", sw_intf);
       uvm_config_db#(virtual uart_rx_intf)::set(this, "uart_envr.rx_agent.*", "uart_rx_intf", rx_if);
        uvm_config_db#(virtual uart_tx_intf)::set(this, "uart_envr.tx_agent.*", "uart_tx_intf", tx_if);
       uvm_config_db#(virtual config_interface)::set(this, "uart_envr.rx_agent.*", "config_interface", config_intf);
       uvm_config_db#(virtual config_interface)::set(this, "uart_envr.tx_agent.*", "config_interface", config_intf);
       `uvm_info("config_uart",$sformatf("sw_intf : %d",sw_intf.reset_n),UVM_MEDIUM)
  	endfunction
    task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    //apply_reset();
    //base_seq.start(uart_envr.sw_agent.sequencer);
    //send_seq.start(uart_envr.sw_agent.sequencer);
    //base_rx.start(uart_envr.rx_agent.sequencer);
    //base_tx.start(uart_envr.tx_agent.sequencer);
     repeat(200) begin
        ran_cfg_seq.start(uart_envr.sw_agent.sequencer);
    base_tx.start(uart_envr.tx_agent.sequencer);
    // ran_seq.start(uart_envr.sw_agent.sequencer);
    // #20000;
    end
    //`uvm_info("check_run_phase",$sformatf("hello chua biet fill gi"),UVM_MEDIUM)
    #200000;
    `uvm_info("test",$sformatf("complete test"),UVM_MEDIUM)
    phase.drop_objection(this);
  endtask
 endclass
