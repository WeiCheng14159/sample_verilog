`include "def.v"

module traffic_light (
    input  clk,
    input  rst,
    input  pass,
    output reg R,
    output reg G,
    output reg Y
);

    reg [`STATE_W-1:0]        curr_state, next_state;
    reg [`COUNTER_W-1:0]      cyc;
    reg                       pass_rst;
    reg                       pass_reg;
    
    // State transition condition
    wire [`COUNTER_W-1:0]     x128_4 = 128 * 4;
    wire [`COUNTER_W-1:0]     x128_3 = 128 * 3;
    wire [`COUNTER_W-1:0]     base = 1024 - 1;
    wire                      init_done = ( cyc == base );
    wire                      idle_done = ( cyc == ( base + 128 ) | cyc == ( base + 128 * 3 ) );
    wire                      turn_yellow = ( cyc == ( base + 128 * 4 ) );
    wire                      turn_idle = ( cyc == ( base + 128 + 128 ) );
    wire                      turn_red = ( cyc == ( base + 128 * 4 + 512 ) );
    wire                      turn_rst = ( cyc == ( base + 128 * 4 + 512 + 1024 ) );
 
    // Pass signal sync
    always @(posedge clk, posedge rst) begin
      if(rst)
        pass_reg <= 1'b0;
      else
        pass_reg <= pass;
    end
 
    // Pass signal reset condition
    always @(*) begin
      if(pass)
        pass_rst = (curr_state[`S_RST]) ? 1'b0 : 1'b1;
      else
        pass_rst = 1'b0;
    end
 
    // Counter
    always @(posedge clk, posedge rst) begin
      if(rst)
        cyc <= {`COUNTER_W{1'b0}};
      else 
        cyc <= ( turn_rst || pass_rst ) ? {`COUNTER_W{1'b0}} : (cyc + 1'b1);
    end
 
    // State Register (S)
    always @(posedge clk, posedge rst) begin
       if(rst)
         curr_state <= `STATE_INIT | 1'b1;
       else
         curr_state <= next_state;
    end // State Register
 
    // Next State Logic (C)
    always @(*) begin
       next_state = `STATE_INIT;
 
       case (1'b1) // synopsys parallel_case
 
         // INIT state
         curr_state[`S_RST]: begin
            if(init_done)
              next_state[`S_IDLE] = 1'b1;
            else
              next_state[`S_RST] = 1'b1;
         end
 
         // IDLE state
         curr_state[`S_IDLE]: begin
            if(idle_done)
              next_state[`S_G] = 1'b1;
            else
              next_state[`S_IDLE] = 1'b1;
         end
 
         // Green state
         curr_state[`S_G]: begin
            if(turn_yellow) begin
              next_state[`S_Y] = 1'b1;
            end else if(turn_idle) begin
              next_state[`S_IDLE] = 1'b1;
            end else begin
              next_state[`S_G] = 1'b1;
            end
         end
 
         // Yellow state
         curr_state[`S_Y]: begin
            if(turn_red)
              next_state[`S_R] = 1'b1;
            else
              next_state[`S_Y] = 1'b1;
         end
 
         // Red state
         curr_state[`S_R]: begin
            if(turn_rst)
              next_state[`S_RST] = 1'b1;
            else
              next_state[`S_R] = 1'b1;
         end
         
         // default
         default: begin
           next_state[`S_RST] = 1'b1;
         end
       endcase
 
       // Reset condition
       if(rst | pass_rst)
         next_state = `STATE_INIT | 1'b1;
 
    end // Next State Logic (C)
 
 
    // Output Logic (C)
    always @(*) begin
      R = 1'b0;
      G = 1'b0;
      Y = 1'b0;
 
      case (1'b1) // synopsys parallel_case
        // INIT state
        curr_state[`S_RST]: begin
          G = 1'b1;
        end
 
        // IDLE state
 
        // Green state
        curr_state[`S_G]: begin
           G = 1'b1;
        end
 
        // Yellow state
        curr_state[`S_Y]: begin
           Y = 1'b1;
        end
 
        // Red state
        curr_state[`S_R]: begin
           R = 1'b1;
        end
 
        //default
        default: ;
      endcase
 
    end // Next State Logic (C)
 
endmodule
