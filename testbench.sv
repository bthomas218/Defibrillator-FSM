module AED_FSM_tb;
    
  reg clk, reset, B, H, R;
  wire L, S;
    
  AED_FSM uut (
    .clk(clk),
    .reset(reset),
    .B(B),
    .H(H),
    .R(R),
    .L(L),
    .S(S)
    );
    
  initial begin
    // Clock generation every 5 units
    clk = 0;
    forever #5 clk = ~clk;  
  end
    
  initial begin 
    // EPWave setup
	$dumpfile("dump.vcd");
    $dumpvars(0, AED_FSM_tb);
    
    $monitor("Time: %0t | State: %b | B: %b, H: %b, R: %b | L: %b, S: %b", $time, uut.state, B, H, R, L, S);
         
    // Initialize inputs
    reset = 1; B = 0; H = 0; R = 0;
    #10 reset = 0;
          
    // Normal heartbeat
    #10 H = 1; R = 1;
    #20 H = 0;
            
    // Irregular heartbeat detected
    #10 H = 1; R = 0;
    #20 R = 1; // Regular heartbeat returns
        
    // Heartbeat lost 
    #10 H = 0;
        
    // Irregular heartbeat, then shock
    #10 H = 1; R = 0;
    #20 B = 1; // Press button to shock
    #10 B = 0;
        
        
    #30 $finish; 
  end
endmodule
