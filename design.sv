module AED_FSM (    
  input wire clk, // Clock Signal    
  input wire reset, // Reset Button  
  input wire B, // Orange Button pressed
  input wire H, // Heartbeat detected
  input wire R, // Regular Heartbeat measured  
  output reg L, // Orange Light
  output reg S  // Shock heart
);

  // Defines the four states of the AED FSM      
  typedef enum logic [1:0] {  
    WAITING = 2'b00, // State for waiting    
    MEASURING = 2'b01, // State for measuring    
    IRREGULAR = 2'b10, // State for irregular heartbeat    
    SHOCK_DONE = 2'b11 // State for shock done  
  } state_t;
  
  state_t state, next_state;

  // Update state on clock edge or reset  
  always_ff @(posedge clk or posedge reset) begin        
    if (reset)            
      state <= WAITING;        
    else            
      state <= next_state;  
  end

  // Combinational logic portion  
  always_comb begin    
    // Default outputs
    next_state = state;    
    L = 0;
    S = 0;
    
    case (state)      
      WAITING: begin         
        if (H) // Heartbeat detected, start measuring
          next_state = MEASURING;      
      end
                
      MEASURING: begin    
        if (!H) // Heartbeat lost, go back to waiting      
          next_state = WAITING;
        else if (!R) begin  // Irregular heartbeat so turn on the orange light    
          next_state = IRREGULAR;          
          L = 1;     
        end    
      end
                
      IRREGULAR: begin
        L = 1; // For keeping the light on 
        if (!H) // Heartbeat stopped go back to waiting.
          next_state = WAITING;
        else if (R) // Heartbeat regular go back to measuring
          next_state = MEASURING; 
        else if (B) begin // Button pressed, shock and turn off light
          S = 1;
          L = 0;
          next_state = SHOCK_DONE;
        end       
      end
                   
      SHOCK_DONE: begin
        if (reset) // Only way out is reset 
          next_state = WAITING;          
      end       
      default: next_state = WAITING; // tarts on waiting    
    endcase    
  end
endmodule
