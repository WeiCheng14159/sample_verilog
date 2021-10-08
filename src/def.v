// This is generated automatically on 2021/10/08-10:37:38
// Check the # of bits for state registers !!!
// Check the # of bits for flag registers !!!

`ifndef __FLAG_DEF__
`define __FLAG_DEF__

// There're 8 flags in this design
`define F_IDLE                 	 0  
`define F_1                    	 1  
`define F_2                    	 2  
`define F_3                    	 3  
`define F_4                    	 4  
`define F_5                    	 5  
`define F_6                    	 6  
`define F_FINISH               	 7  
`define FLAG_W                 	 8  

// There're 5 states in this design
`define S_RST                  	 0  
`define S_IDLE                 	 1  
`define S_G                    	 2  
`define S_Y                    	 3  
`define S_R                    	 4  
`define STATE_INIT             	 5'b0
`define STATE_W                	 5  

// Macro from template
`define BUF_SIZE               	 8'd66
`define READ_MEM_DELAY         	 2'd2
`define EMPTY_ADDR             	 {12{1'b0}}
`define EMPTY_DATA             	 {20{1'b0}}
`define LOCAL_IDX_W            	 16 
`define DATA_W                 	 20 

// Self-defined macro
`define COUNTER_W              	 15 

`endif
