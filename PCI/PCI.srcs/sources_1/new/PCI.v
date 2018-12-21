`timescale 1ns / 1ps
// Just to PUSH comment
module device_A(Output0,Output1,CLK, RST_N, AD, CBE_N, FRAME_N, IRDY_N, TRDY_N, DEVSEL_N, REQ_N, GNT_N, FORCED_REQ_N, FORCED_ADDRESS, FORCED_CBE_N, Forced_DataTfNo, MIN_ADDRESS);

parameter TransactionStart = 4'b0000, GrantGiven = 4'b0001, FrameAsserted = 4'b0010;
parameter DataPhase = 4'b0100, DataPhase2 = 4'b0101, DataPhase3 = 4'b0110, DataPhase4 = 4'b0111, DataPhase5 = 4'b1000;
parameter DataPhase6 = 4'b1001, DataPhase7 = 4'b1010, DataPhase8 = 4'b1011, DataPhase9 = 4'b1100, DataPhase10 = 4'b1101,OverFlowed = 4'b1110;

input FORCED_REQ_N;
input [3:0] Forced_DataTfNo;
input [31:0] MIN_ADDRESS;
input [31:0] FORCED_ADDRESS;
input [3:0] FORCED_CBE_N;

input CLK, RST_N, GNT_N;

inout [31:0] AD;	
inout [3:0] CBE_N;
inout FRAME_N, IRDY_N, TRDY_N, DEVSEL_N;

output REQ_N;
output [31:0] Output1, Output0;

reg [31:0] ADreg; 
reg [3:0] CBE_Nreg; 
reg [3:0] Status;
reg [3:0] Counter;
reg FRAME_Nreg, IRDY_Nreg, TRDY_Nreg, DEVSEL_Nreg;
reg MasterFlag, SlaveFlag, ReadFlag, WriteFlag;

reg [31:0] memory [0:9];


assign REQ_N    = FORCED_REQ_N;
assign AD       = ADreg;	       
assign CBE_N    = CBE_Nreg;
assign FRAME_N  = FRAME_Nreg;	
assign IRDY_N   = IRDY_Nreg;
assign TRDY_N   = TRDY_Nreg;	    
assign DEVSEL_N = DEVSEL_Nreg;

assign Output0 = memory [0];
assign Output1 = memory [1];

always @ (negedge CLK)
begin
	if (RST_N)
	begin
		if(MasterFlag)
		begin
			case (Status)
			GrantGiven:
<<<<<<< HEAD
			begin
				FRAME_Nreg <= 0;
				ADreg    <= FORCED_ADDRESS;
				CBE_Nreg <= FORCED_CBE_N;
				Status   <= FrameAsserted;
			end
			FrameAsserted: 
			begin 
				IRDY_Nreg <= 0;
				if (CBE_N == 4'b0110)       //Read Operation
				begin
					ReadFlag  <= 1;
					WriteFlag <= 0;
					ADreg    <= {(32){1'bz}};
					CBE_Nreg <= 4'b0000;
					Status   <= DataPhase1;
				end
				else if (CBE_N == 4'b0111) // Write Operation
				begin
					ReadFlag  <= 0;
					WriteFlag <= 1;
					if(!DEVSEL_N)
					begin
						if (!TRDY_N)
						begin
							ADreg  <= memory [0];
							CBE_Nreg  <= FORCED_CBE_N;
							Status <= DataPhase1;
						end
					end
					else
					begin
						MasterFlag <= 0;
						FRAME_Nreg <= 1;
						IRDY_Nreg  <= 1;
						Status <= TransactionStart;
					end
				end
			end
			DataPhase1:
			begin
				if (WriteFlag)
				begin
					if(!DEVSEL_N)
					begin
						if (!TRDY_N)
						begin
							ADreg  <= memory [1];
							CBE_Nreg  <= FORCED_CBE_N;
							Status <= DataPhase2;
						end
					end
					else
					begin
						MasterFlag <= 0;
						FRAME_Nreg <= 1;
						IRDY_Nreg  <= 1;
						Status <= TransactionStart;
					end
				end
			end
			DataPhase2:
			begin
				if (WriteFlag)
				begin
					if(!DEVSEL_N)
					begin
						if (!TRDY_N)
						begin
							ADreg  <= memory [2];
							CBE_Nreg  <= FORCED_CBE_N;
							Status <= DataPhase3;
						end
					end
					else
					begin
						MasterFlag <= 0;
						FRAME_Nreg <= 1;
						IRDY_Nreg  <= 1;
						Status <= TransactionStart;
					end
				end
			end
			DataPhase3:
			begin
				if (WriteFlag)
				begin
					if(!DEVSEL_N)
					begin
						if (!TRDY_N)
						begin
							ADreg  <= memory [3];
							CBE_Nreg  <= FORCED_CBE_N;
							Status <= DataPhase4;
						end
					end
					else
					begin
						MasterFlag <= 0;
						FRAME_Nreg <= 1;
						IRDY_Nreg  <= 1;
						Status <= TransactionStart;
					end
				end
			end
			DataPhase4:
			begin
				if (WriteFlag)
				begin
					if(!DEVSEL_N)
					begin
						if (!TRDY_N)
						begin
							ADreg  <= memory [4];
							CBE_Nreg  <= FORCED_CBE_N;
							Status <= DataPhase5;
						end
					end
					else
					begin
						MasterFlag <= 0;
						FRAME_Nreg <= 1;
						IRDY_Nreg  <= 1;
						Status <= TransactionStart;
					end
				end
			end
			DataPhase5:
			begin
				if (WriteFlag)
				begin
					if(!DEVSEL_N)
					begin
						if (!TRDY_N)
						begin
							ADreg  <= memory [5];
							CBE_Nreg  <= FORCED_CBE_N;
							Status <= DataPhase6;
						end
					end
					else
					begin
						MasterFlag <= 0;
						FRAME_Nreg <= 1;
						IRDY_Nreg  <= 1;
						Status <= TransactionStart;
					end
				end
			end
			DataPhase6:
			begin
				if (WriteFlag)
				begin
					if(!DEVSEL_N)
					begin
						if (!TRDY_N)
						begin
							ADreg  <= memory [6];
							CBE_Nreg  <= FORCED_CBE_N;
							Status <= DataPhase7;
						end
					end
					else
					begin
						MasterFlag <= 0;
						FRAME_Nreg <= 1;
						IRDY_Nreg  <= 1;
						Status <= TransactionStart;
					end
				end
			end
			DataPhase7:
			begin
				if (WriteFlag)
				begin
					if(!DEVSEL_N)
					begin
						if (!TRDY_N)
						begin
							ADreg  <= memory [7];
							CBE_Nreg  <= FORCED_CBE_N;
							Status <= DataPhase8;
						end
					end
					else
					begin
						MasterFlag <= 0;
						FRAME_Nreg <= 1;
						IRDY_Nreg  <= 1;
						Status <= TransactionStart;
					end
				end
			end
			DataPhase8:
			begin
				if (WriteFlag)
				begin
					if(!DEVSEL_N)
					begin
						if (!TRDY_N)
						begin
							ADreg  <= memory [8];
							CBE_Nreg  <= FORCED_CBE_N;
							Status <= DataPhase9;
						end
					end
					else
					begin
						MasterFlag <= 0;
						FRAME_Nreg <= 1;
						IRDY_Nreg  <= 1;
						Status <= TransactionStart;
					end
				end
			end
			DataPhase9:
			begin
				if (WriteFlag)
				begin
					if(!DEVSEL_N)
					begin
						if (!TRDY_N)
						begin
							ADreg  <= memory [9];
							CBE_Nreg  <= FORCED_CBE_N;
							Status <= OverFlowed; /*__Need to change__*/
						end
					end
					else
					begin
						MasterFlag <= 0;
						FRAME_Nreg <= 1;
						IRDY_Nreg  <= 1;
						Status <= TransactionStart;
					end
				end
			end
			endcase
		end
		else if (SlaveFlag)
		begin
			case (Status)
			GrantGiven:
			begin
				DEVSEL_Nreg <= 0;
				TRDY_Nreg <= 0; 
				if (CBE_N == 4'b0110)       //Read Operation by master
				begin
					ReadFlag  <= 1;
					WriteFlag <= 0;
				end
				else if (CBE_N == 4'b0111) // Write Operation by master
				begin
					ReadFlag  <= 0;
					WriteFlag <= 1;
				end
				Status   <= DataPhase1;
			end
			// FrameAsserted: 
			// begin 
			// 	IRDY_Nreg <= 0;
			// 	if (CBE_N == 4'b0110)       //Read Operation
			// 	begin
			// 		ReadFlag  <= 1;
			// 		WriteFlag <= 0;
			// 		ADreg    <= {(32){1'bz}};
			// 		CBE_Nreg <= 4'b0000;
			// 		Status   <= DataPhase1;
			// 	end
			// 	else if (CBE_N == 4'b0111) // Write Operation
			// 	begin
			// 		ReadFlag  <= 0;
			// 		WriteFlag <= 1;
			// 		if(!DEVSEL_N)
			// 		begin
			// 			if (!TRDY_N)
			// 			begin
			// 				ADreg  <= memory [0];
			// 				CBE_Nreg  <= FORCED_CBE_N;
			// 				Status <= DataPhase1;
			// 			end
			// 		end
			// 		else
			// 		begin
			// 			MasterFlag <= 0;
			// 			FRAME_Nreg <= 1;
			// 			IRDY_Nreg  <= 1;
			// 			Status <= TransactionStart;
			// 		end
			// 	end
			// end
			DataPhase1:
			begin
				if (ReadFlag)
				begin
						if (!TRDY_N)
						begin
							if(CBE_N [0] == 0)
							 ADreg [7:0] = memory    [0] [7:0];
							if(CBE_N [1] == 0)
							 ADreg [15:8] = memory   [0] [15:8];
							if(CBE_N [2] == 0)
							 ADreg [23:16] = memory  [0] [23:16];
							if(CBE_N [3] == 0)
							 ADreg [31:24]  = memory [0] [31:24];

							Status <= DataPhase2;
						end
									end
			end
			DataPhase2:
			begin
				if (ReadFlag)
				begin
						if (!TRDY_N)
						begin
							if(CBE_N [0] == 0)
							 ADreg [7:0] = memory    [1] [7:0];
							if(CBE_N [1] == 0)
							 ADreg [15:8] = memory   [1] [15:8];
							if(CBE_N [2] == 0)
							 ADreg [23:16] = memory  [1] [23:16];
							if(CBE_N [3] == 0)
							 ADreg [31:24]  = memory [1] [31:24];
							Status <= DataPhase3;
						end
				
					
				end
			end
			DataPhase3:
			begin
				if (ReadFlag)
				begin
				
						if (!TRDY_N)
						begin
							if(CBE_N [0] == 0)
							 ADreg [7:0] = memory    [2] [7:0];
							if(CBE_N [1] == 0)
							 ADreg [15:8] = memory   [2] [15:8];
							if(CBE_N [2] == 0)
							 ADreg [23:16] = memory  [2] [23:16];
							if(CBE_N [3] == 0)
							 ADreg [31:24]  = memory [2] [31:24];
							Status <= DataPhase4;
						end
				
					
				end
			end
			DataPhase4:
			begin
				if (ReadFlag)
				begin
				
						if (!TRDY_N)
						begin
							if(CBE_N [0] == 0)
							 ADreg [7:0] = memory    [3] [7:0];
							if(CBE_N [1] == 0)
							 ADreg [15:8] = memory   [3] [15:8];
							if(CBE_N [2] == 0)
							 ADreg [23:16] = memory  [3] [23:16];
							if(CBE_N [3] == 0)
							 ADreg [31:24]  = memory [3] [31:24];
							Status <= DataPhase5;
						end
				
					
				end
			end
			DataPhase5:
			begin
				if (ReadFlag)
				begin
				
						if (!TRDY_N)
						begin
							if(CBE_N [0] == 0)
							 ADreg [7:0] = memory    [4] [7:0];
							if(CBE_N [1] == 0)
							 ADreg [15:8] = memory   [4] [15:8];
							if(CBE_N [2] == 0)
							 ADreg [23:16] = memory  [4] [23:16];
							if(CBE_N [3] == 0)
							 ADreg [31:24]  = memory [4] [31:24];
							Status <= DataPhase6;
						end
				
					
				end
			end
			DataPhase6:
			begin
				if (ReadFlag)
				begin
					
						if (!TRDY_N)
						begin
							if(CBE_N [0] == 0)
							 ADreg [7:0] = memory    [5] [7:0];
							if(CBE_N [1] == 0)
							 ADreg [15:8] = memory   [5] [15:8];
							if(CBE_N [2] == 0)
							 ADreg [23:16] = memory  [5] [23:16];
							if(CBE_N [3] == 0)
							 ADreg [31:24]  = memory [5] [31:24];
							Status <= DataPhase7;
						end
				
					
				end
			end
			DataPhase7:
			begin
				if (ReadFlag)
				begin
				
						if (!TRDY_N)
						begin
							if(CBE_N [0] == 0)
							 ADreg [7:0] = memory    [6] [7:0];
							if(CBE_N [1] == 0)
							 ADreg [15:8] = memory   [6] [15:8];
							if(CBE_N [2] == 0)
							 ADreg [23:16] = memory  [6] [23:16];
							if(CBE_N [3] == 0)
							 ADreg [31:24]  = memory [6] [31:24];
							Status <= DataPhase8;
						end
				
					
				end
			end
			DataPhase8:
			begin
				if (ReadFlag)
				begin
				
						if (!TRDY_N)
						begin
							if(CBE_N [0] == 0)
							 ADreg [7:0] = memory    [7] [7:0];
							if(CBE_N [1] == 0)
							 ADreg [15:8] = memory   [7] [15:8];
							if(CBE_N [2] == 0)
							 ADreg [23:16] = memory  [7] [23:16];
							if(CBE_N [3] == 0)
							 ADreg [31:24]  = memory [7] [31:24];
							Status <= DataPhase9;
						end
				
					
				end
			end
			DataPhase9:
			begin
				if (ReadFlag)
				begin
						if (!TRDY_N)
						begin
							if(CBE_N [0] == 0)
							 ADreg [7:0] = memory    [8] [7:0];
							if(CBE_N [1] == 0)
							 ADreg [15:8] = memory   [8] [15:8];
							if(CBE_N [2] == 0)
							 ADreg [23:16] = memory  [8] [23:16];
							if(CBE_N [3] == 0)
							 ADreg [31:24]  = memory [8] [31:24];
							Status <= OverFlowed; /*__Need to change__*/
						end
				end
			end
			endcase
		end
	end
end

always @ (posedge CLK, RST_N)
    if (!RST_N)
	begin
		ADreg       <= {(32){1'bz}};
		CBE_Nreg    <= 4'bzzzz;
		FRAME_Nreg  <= 1'b1;
		IRDY_Nreg   <= 1'b1; 
		TRDY_Nreg   <= 1'b1; 
		DEVSEL_Nreg <= 1'b1;
		MasterFlag  <= 1'b0; 
		SlaveFlag   <= 1'b0;
		Status      <= TransactionStart; 
		memory[0]   <= {MIN_ADDRESS [15:0],{16'h0001}};
		memory[1]   <= {MIN_ADDRESS [15:0],{16'h0002}};
		memory[2]   <= {MIN_ADDRESS [15:0],{16'h0003}};
		memory[3]   <= {MIN_ADDRESS [15:0],{16'h0004}};
		memory[4]   <= {MIN_ADDRESS [15:0],{16'h0005}};
		memory[5]   <= {MIN_ADDRESS [15:0],{16'h0006}};
		memory[6]   <= {MIN_ADDRESS [15:0],{16'h0007}};
		memory[7]   <= {MIN_ADDRESS [15:0],{16'h0008}};
		memory[8]   <= {MIN_ADDRESS [15:0],{16'h0009}};
		memory[9]   <= {MIN_ADDRESS [15:0],{16'h000A}}; 
	end
    else
	begin 
        if((!GNT_N && !REQ_N && DEVSEL_N) || MasterFlag ) //Then Device is Master
        begin 
			MasterFlag = 1;
		    case (Status)
			TransactionStart:
			begin
				Status      <= GrantGiven;
				TRDY_Nreg   <= 1'bz; 
				DEVSEL_Nreg <= 1'bz;
			end
			DataPhase1:
			begin
				if (WriteFlag)
					begin
						if (!IRDY_N)
						begin
							memory[0] <= AD;
							Status <= DataPhase2;
						end
					end
			end
			DataPhase2:
			begin
				if (WriteFlag)
					begin
						if (!IRDY_N)
						begin
							memory[1] <= AD;
							Status <= DataPhase2;
						end
					end
			end
			DataPhase3:
			begin
				if (WriteFlag)
					begin
						if (!IRDY_N)
						begin
							memory[2] <= AD;
							Status <= DataPhase2;
						end
					end
			end
			DataPhase4:
			begin
				if (WriteFlag)
					begin
						if (!IRDY_N)
						begin
							memory[3] <= AD;
							Status <= DataPhase2;
						end
					end
			end
			DataPhase5:
			begin
				if (WriteFlag)
					begin
						if (!IRDY_N)
						begin
							memory[4] <= AD;
							Status <= DataPhase2;
						end
					end
			end
			DataPhase6:
			begin
				if (WriteFlag)
					begin
						if (!IRDY_N)
						begin
							memory[5] <= AD;
							Status <= DataPhase2;
						end
					end
			end
			DataPhase7:
			begin
				if (WriteFlag)
					begin
						if (!IRDY_N)
						begin
							memory[6] <= AD;
							Status <= DataPhase2;
						end
					end
			end
			DataPhase8:
			begin
				if (WriteFlag)
					begin
						if (!IRDY_N)
						begin
							memory[7] <= AD;
							Status <= DataPhase2;
						end
					end
			end    
			DataPhase9:
			begin
				if (WriteFlag)
					begin
						if (!IRDY_N)
						begin
							memory[8] <= AD;
							Status <= DataPhase2;
						end
					end
			end
			DataPhase10:
			begin
				if (WriteFlag)
					begin
						if (!IRDY_N)
						begin
							memory[9] <= AD;
							Status <= DataPhase2;
						end
					end
			end

                OverFlowed:       // Need to reset Memory ? ------- if not Granted? (for every Data Phase also) ---------- Slave's DEVSEL be affected by FRAME
                        begin
                            if(!GNT_N)
                                if (!REQ_N)
                                    begin
                                        MasterFlag <= 1;
                                        FRAME_Nreg <= 1;
                                        IRDY_Nreg  <= 1;
                                        Status     <= TransactionStart;
                                    end
                                else
                                    begin 
                                        //Remove Grant For this master
                                        MasterFlag <= 0;
                                        FRAME_Nreg <= 1;
                                        IRDY_Nreg  <= 1;
                                        //Status <= default;

                                    end
                            else 
                                begin
                                    MasterFlag <= 0;
                                    FRAME_Nreg <= 1;
                                    IRDY_Nreg  <= 1;
                                   // Status <= default;
                                end
                        end

                default: /* default */;
            endcase
        end
        else if (IRDY_N || SlaveFlag)  	//Device is Slave Slave
        begin
        	if((AD >= MIN_ADDRESS) && (AD <= (MIN_ADDRESS + 10))|| SlaveFlag)
        	begin 
            case (Status)
			TransactionStart:
=======
>>>>>>> 818b88fdbc2e943496c114bd83da0206784b4819
			begin
				FRAME_Nreg <= 1'b0;
				ADreg      <= FORCED_ADDRESS;
				CBE_Nreg   <= FORCED_CBE_N;
				Status     <= FrameAsserted;
			end
			FrameAsserted: 
			begin 
				IRDY_Nreg <= 1'b0;
				if (CBE_N == 4'b0110)       //Read Operation
				begin
					ReadFlag  <= 1'b1;
					WriteFlag <= 1'b0;
					ADreg     <= {(32){1'bz}};
					CBE_Nreg  <= 4'b0000;
					Status    <= DataPhase;
				end
				else if (CBE_N == 4'b0111) // Write Operation
				begin
					ReadFlag  <= 1'b0;
					WriteFlag <= 1'b1;
					if(!DEVSEL_N)
					begin
						if (!TRDY_N)
						begin
							ADreg     <= memory [Counter];
							CBE_Nreg  <= FORCED_CBE_N;
							Status    <= DataPhase;
							Counter   <= Counter + 1;
						end
					end
					else
					begin
						MasterFlag <= 1'b0;
						FRAME_Nreg <= 1'b1;
						IRDY_Nreg  <= 1'bz;
						Counter    <= 4'b0000;
						Status     <= TransactionStart;
					end
				end
			end
			DataPhase:
			begin
				if (WriteFlag)
				begin
					if(!DEVSEL_N)
					begin
						if (!TRDY_N)
						begin
							ADreg     <= memory [Counter];
							CBE_Nreg  <= FORCED_CBE_N;
							Counter   <= Counter + 1;
						end
					end
					else
					begin
						MasterFlag <= 1'b0;
						FRAME_Nreg <= 1'b1;
						IRDY_Nreg  <= 1'bz;
						Counter    <= 4'b0000;
						Status     <= TransactionStart;
					end
				end
			end
			endcase
		end
		else if(SlaveFlag)
		begin
			case (Status)
			GrantGiven:
			begin
				DEVSEL_Nreg <= 0;
				TRDY_Nreg <= 0; 
				if (CBE_N == 4'b0110)       //Read Operation by master
				begin
					ReadFlag  <= 1;
					WriteFlag <= 0;
				end
				else if (CBE_N == 4'b0111) // Write Operation by master
				begin
					ReadFlag  <= 0;
					WriteFlag <= 1;
				end
				Status <= DataPhase;
			end
			DataPhase:
			begin
				if (ReadFlag)
				begin
					if (!TRDY_N)
					begin
						if(CBE_N [0] == 0)
							ADreg [7:0]   = memory[0][7:0];
						if(CBE_N [1] == 0)
							ADreg [15:8]  = memory[0][15:8];
						if(CBE_N [2] == 0)
							ADreg [23:16] = memory[0][23:16];
						if(CBE_N [3] == 0)
							ADreg [31:24] = memory[0][31:24];

						Counter <= Counter + 1;
					end
				end
			end
			endcase
		end
	end
end

always @ (posedge CLK, RST_N)
    if (!RST_N)
	begin
		ADreg <= {(32){1'bz}};
		CBE_Nreg <= 4'bzzzz;
		FRAME_Nreg <= 1'bz;
		IRDY_Nreg <= 1'bz; 
		TRDY_Nreg <= 1'bz; 
		DEVSEL_Nreg <= 1'b1;
		MasterFlag <= 1'b0; 
		Counter <= 4'b0000;
		Status <= TransactionStart; 
		memory[0] <= {MIN_ADDRESS [15:0],{16'h0001}};
		memory[1] <= {MIN_ADDRESS [15:0],{16'h0002}};
		memory[2] <= {MIN_ADDRESS [15:0],{16'h0003}};
		memory[3] <= {MIN_ADDRESS [15:0],{16'h0004}};
		memory[4] <= {MIN_ADDRESS [15:0],{16'h0005}};
		memory[5] <= {MIN_ADDRESS [15:0],{16'h0006}};
		memory[6] <= {MIN_ADDRESS [15:0],{16'h0007}};
		memory[7] <= {MIN_ADDRESS [15:0],{16'h0008}};
		memory[8] <= {MIN_ADDRESS [15:0],{16'h0009}};
		memory[9] <= {MIN_ADDRESS [15:0],{16'h000A}}; 
	end
    else if((!GNT_N && !REQ_N && DEVSEL_N) || MasterFlag ) //Then Device is Master
	begin 
		MasterFlag = 1;
		case (Status)
		TransactionStart:
		begin
			Status      <= GrantGiven;
			TRDY_Nreg   <= 1'bz; 
			DEVSEL_Nreg <= 1'bz;
		end
		DataPhase:
		begin
			if (ReadFlag)
			begin
				if(!DEVSEL_N)
				begin
					if (!TRDY_N)
					begin
						memory[Counter] <= AD;
						Counter         <= Counter + 1;
					end
				end
				else
				begin
					MasterFlag <= 1'b0;
					FRAME_Nreg <= 1'b1;
					IRDY_Nreg  <= 1'bz;
					Counter    <= 4'b0000;
					Status     <= TransactionStart;
				end
			end
		end
		endcase
	end
	else if (IRDY_N || SlaveFlag)  	//Device is Slave
	begin
		if(((AD >= MIN_ADDRESS) && (AD <= (MIN_ADDRESS + 10))) || SlaveFlag)
		begin
			case (Status)
			TransactionStart:
			begin
				SlaveFlag <= 1;
				Status <= GrantGiven;
			end
			DataPhase:
			begin
				if (ReadFlag)
				begin
					if(!DEVSEL_N)
					begin
						if (!TRDY_N)
						begin
							memory[Counter] = AD;
							Counter = Counter + 1;
						end
					end
				end
			end
			endcase
		end		
	end
 endmodule

module arbiter_priority(GNT_Neg , REQ_Neg , FRAME_Neg , RST_Neg);
output reg [7:0] GNT_Neg;
input [7:0] REQ_Neg;
input FRAME_Neg,RST_Neg;
reg EN;

always @(negedge FRAME_Neg)
begin
	EN <= 1'b1;
end

always @(FRAME_Neg , REQ_Neg)
begin
    if(~RST_Neg)
    begin
        GNT_Neg <= 8'b1111_1111;
        EN <= 1'b1;
    end
    else if(FRAME_Neg && EN)
    begin
        casez(REQ_Neg)
            8'bzzzz_zzz0:begin GNT_Neg <= 8'b1111_1110; EN <= 1'b0; end
            8'bzzzz_zz01:begin GNT_Neg <= 8'b1111_1101; EN <= 1'b0; end
            8'bzzzz_z011:begin GNT_Neg <= 8'b1111_1011; EN <= 1'b0; end
            8'bzzzz_0111:begin GNT_Neg <= 8'b1111_0111; EN <= 1'b0; end
            8'bzzz0_1111:begin GNT_Neg <= 8'b1110_1111; EN <= 1'b0; end
            8'bzz01_1111:begin GNT_Neg <= 8'b1101_1111; EN <= 1'b0; end
            8'bz011_1111:begin GNT_Neg <= 8'b1011_1111; EN <= 1'b0; end
            8'b0111_1111:begin GNT_Neg <= 8'b0111_1111; EN <= 1'b0; end
            default:begin GNT_Neg <= 8'b1111_1111; EN <= 1'b1; end
        endcase
    end
end
endmodule

module arbiter_RobinRound(GNT_Neg , REQ_Neg , FRAME_Neg , RST_Neg);
output reg [7:0] GNT_Neg;
input [7:0] REQ_Neg;
input FRAME_Neg,RST_Neg;

reg EN;
reg [2:0] counter;

always @(negedge FRAME_Neg)
begin
	EN <= 1'b1;
end

always @(FRAME_Neg , REQ_Neg)
begin
    if(~RST_Neg)
    begin
        GNT_Neg <= 8'b1111_1111;
        counter <= 3'b000;
    end
    else if(FRAME_Neg && EN)
    begin
        case(counter)
            3'b000:
                begin
                    casez(REQ_Neg)
                        8'bzzzz_zzz0:begin GNT_Neg <= 8'b1111_1110; counter = 3'b001; EN <= 1'b0; end
                        8'bzzzz_zz01:begin GNT_Neg <= 8'b1111_1101; counter = 3'b010; EN <= 1'b0; end
                        8'bzzzz_z011:begin GNT_Neg <= 8'b1111_1011; counter = 3'b011; EN <= 1'b0; end
                        8'bzzzz_0111:begin GNT_Neg <= 8'b1111_0111; counter = 3'b100; EN <= 1'b0; end
                        8'bzzz0_1111:begin GNT_Neg <= 8'b1110_1111; counter = 3'b101; EN <= 1'b0; end
                        8'bzz01_1111:begin GNT_Neg <= 8'b1101_1111; counter = 3'b110; EN <= 1'b0; end
                        8'bz011_1111:begin GNT_Neg <= 8'b1011_1111; counter = 3'b111; EN <= 1'b0; end
                        8'b0111_1111:begin GNT_Neg <= 8'b0111_1111; counter = 3'b000; EN <= 1'b0; end
                        default: begin GNT_Neg <= 8'b1111_1111; counter = 3'b000; EN <= 1'b1; end
                    endcase
                end
            3'b001:
                begin
                    casez(REQ_Neg)
                        8'bzzzz_zz0z:begin GNT_Neg <= 8'b1111_1101; counter = 3'b010; EN <= 1'b0; end
                        8'bzzzz_z01z:begin GNT_Neg <= 8'b1111_1011; counter = 3'b011; EN <= 1'b0; end
                        8'bzzzz_011z:begin GNT_Neg <= 8'b1111_0111; counter = 3'b100; EN <= 1'b0; end
                        8'bzzz0_111z:begin GNT_Neg <= 8'b1110_1111; counter = 3'b101; EN <= 1'b0; end
                        8'bzz01_111z:begin GNT_Neg <= 8'b1101_1111; counter = 3'b110; EN <= 1'b0; end
                        8'bz011_111z:begin GNT_Neg <= 8'b1011_1111; counter = 3'b111; EN <= 1'b0; end
                        8'b0111_111z:begin GNT_Neg <= 8'b0111_1111; counter = 3'b000; EN <= 1'b0; end
                        8'b1111_1110:begin GNT_Neg <= 8'b1111_1110; counter = 3'b001; EN <= 1'b0; end
                        default: begin GNT_Neg <= 8'b1111_1111; counter = 3'b001; EN <= 1'b1; end
                    endcase
                end
            3'b010:
                begin
                    casez(REQ_Neg)
                        8'bzzzz_z0zz:begin GNT_Neg <= 8'b1111_1011; counter = 3'b011; EN <= 1'b0; end
                        8'bzzzz_01zz:begin GNT_Neg <= 8'b1111_0111; counter = 3'b100; EN <= 1'b0; end
                        8'bzzz0_11zz:begin GNT_Neg <= 8'b1110_1111; counter = 3'b101; EN <= 1'b0; end
                        8'bzz01_11zz:begin GNT_Neg <= 8'b1101_1111; counter = 3'b110; EN <= 1'b0; end
                        8'bz011_11zz:begin GNT_Neg <= 8'b1011_1111; counter = 3'b111; EN <= 1'b0; end
                        8'b0111_11zz:begin GNT_Neg <= 8'b0111_1111; counter = 3'b000; EN <= 1'b0; end
                        8'b1111_11z0:begin GNT_Neg <= 8'b1111_1110; counter = 3'b001; EN <= 1'b0; end
                        8'b1111_1101:begin GNT_Neg <= 8'b1111_1101; counter = 3'b010; EN <= 1'b0; end
                        default: begin GNT_Neg <= 8'b1111_1111; counter = 3'b010; EN <= 1'b1; end
                    endcase
                end
            3'b011:
                begin
                    casez(REQ_Neg)
                        8'bzzzz_0zzz:begin GNT_Neg <= 8'b1111_0111; counter = 3'b100; EN <= 1'b0; end
                        8'bzzz0_1zzz:begin GNT_Neg <= 8'b1110_1111; counter = 3'b101; EN <= 1'b0; end
                        8'bzz01_1zzz:begin GNT_Neg <= 8'b1101_1111; counter = 3'b110; EN <= 1'b0; end
                        8'bz011_1zzz:begin GNT_Neg <= 8'b1011_1111; counter = 3'b111; EN <= 1'b0; end
                        8'b0111_1zzz:begin GNT_Neg <= 8'b0111_1111; counter = 3'b000; EN <= 1'b0; end
                        8'b1111_1zz0:begin GNT_Neg <= 8'b1111_1110; counter = 3'b001; EN <= 1'b0; end
                        8'b1111_1z01:begin GNT_Neg <= 8'b1111_1101; counter = 3'b010; EN <= 1'b0; end
                        8'b1111_1011:begin GNT_Neg <= 8'b1111_1011; counter = 3'b011; EN <= 1'b0; end
                        default: begin GNT_Neg <= 8'b1111_1111; counter = 3'b011; EN <= 1'b1; end
                    endcase                
                end
            3'b100:
                begin
                    casez(REQ_Neg)
						8'bzzz0_zzzz:begin GNT_Neg <= 8'b1110_1111; counter = 3'b101; EN <= 1'b0; end
						8'bzz01_zzzz:begin GNT_Neg <= 8'b1101_1111; counter = 3'b110; EN <= 1'b0; end
						8'bz011_zzzz:begin GNT_Neg <= 8'b1011_1111; counter = 3'b111; EN <= 1'b0; end
						8'b0111_zzzz:begin GNT_Neg <= 8'b0111_1111; counter = 3'b000; EN <= 1'b0; end
						8'b1111_zzz0:begin GNT_Neg <= 8'b1111_1110; counter = 3'b001; EN <= 1'b0; end
						8'b1111_zz01:begin GNT_Neg <= 8'b1111_1101; counter = 3'b010; EN <= 1'b0; end
						8'b1111_z011:begin GNT_Neg <= 8'b1111_1011; counter = 3'b011; EN <= 1'b0; end
						8'b1111_0111:begin GNT_Neg <= 8'b1111_0111; counter = 3'b100; EN <= 1'b0; end
						default: begin GNT_Neg <= 8'b1111_1111; counter = 3'b100; EN <= 1'b1; end
                endcase                
                end
            3'b101:
                begin
                    casez(REQ_Neg)
						8'bzz0z_zzzz:begin GNT_Neg <= 8'b1101_1111; counter = 3'b110; EN <= 1'b0; end
						8'bz01z_zzzz:begin GNT_Neg <= 8'b1011_1111; counter = 3'b111; EN <= 1'b0; end
						8'b011z_zzzz:begin GNT_Neg <= 8'b0111_1111; counter = 3'b000; EN <= 1'b0; end
						8'b111z_zzz0:begin GNT_Neg <= 8'b1111_1110; counter = 3'b001; EN <= 1'b0; end
						8'b111z_zz01:begin GNT_Neg <= 8'b1111_1101; counter = 3'b010; EN <= 1'b0; end
						8'b111z_z011:begin GNT_Neg <= 8'b1111_1011; counter = 3'b011; EN <= 1'b0; end
						8'b111z_0111:begin GNT_Neg <= 8'b1111_0111; counter = 3'b100; EN <= 1'b0; end
						8'b1110_1111:begin GNT_Neg <= 8'b1110_1111; counter = 3'b101; EN <= 1'b0; end
						default: begin GNT_Neg <= 8'b1111_1111; counter = 3'b101; EN <= 1'b1; end
                endcase                
                end
            3'b110:
                begin
                    casez(REQ_Neg)
						8'bz0zz_zzzz:begin GNT_Neg <= 8'b1011_1111; counter = 3'b111; EN <= 1'b0; end
						8'b01zz_zzzz:begin GNT_Neg <= 8'b0111_1111; counter = 3'b000; EN <= 1'b0; end
						8'b11zz_zzz0:begin GNT_Neg <= 8'b1111_1110; counter = 3'b001; EN <= 1'b0; end
						8'b11zz_zz01:begin GNT_Neg <= 8'b1111_1101; counter = 3'b010; EN <= 1'b0; end
						8'b11zz_z011:begin GNT_Neg <= 8'b1111_1011; counter = 3'b011; EN <= 1'b0; end
						8'b11zz_0111:begin GNT_Neg <= 8'b1111_0111; counter = 3'b100; EN <= 1'b0; end
						8'b11z0_1111:begin GNT_Neg <= 8'b1110_1111; counter = 3'b101; EN <= 1'b0; end
						8'b1101_1111:begin GNT_Neg <= 8'b1101_1111; counter = 3'b110; EN <= 1'b0; end
						default: begin GNT_Neg <= 8'b1111_1111; counter = 3'b110; EN <= 1'b1; end
                endcase               
                end
            3'b111:
                begin
                    casez(REQ_Neg)
						8'b0zzz_zzzz:begin GNT_Neg <= 8'b0111_1111; counter = 3'b000; EN <= 1'b0; end
						8'b1zzz_zzz0:begin GNT_Neg <= 8'b1111_1110; counter = 3'b001; EN <= 1'b0; end
						8'b1zzz_zz01:begin GNT_Neg <= 8'b1111_1101; counter = 3'b010; EN <= 1'b0; end
						8'b1zzz_z011:begin GNT_Neg <= 8'b1111_1011; counter = 3'b011; EN <= 1'b0; end
						8'b1zzz_0111:begin GNT_Neg <= 8'b1111_0111; counter = 3'b100; EN <= 1'b0; end
						8'b1zz0_1111:begin GNT_Neg <= 8'b1110_1111; counter = 3'b101; EN <= 1'b0; end
						8'b1z01_1111:begin GNT_Neg <= 8'b1101_1111; counter = 3'b110; EN <= 1'b0; end
						8'b1011_1111:begin GNT_Neg <= 8'b1011_1111; counter = 3'b111; EN <= 1'b0; end
						default: begin GNT_Neg <= 8'b1111_1111; counter = 3'b111; EN <= 1'b1; end
                endcase                
                end
        endcase
    end
end
endmodule 

module arbiter_FCFS(GNT , REQ , FRAME_Neg ,CLK, RST_Neg,flag);
output [7:0] GNT ;
wire [7:0] TH0,TH1,TH2,TH3,TH4,TH5,TH6,TH7,memory_out;
input [7:0] REQ;
reg EN;
output reg flag;
input FRAME_Neg,RST_Neg,CLK;

REQ_THREADER RT1(REQ,TH0,TH1,TH2,TH3,TH4,TH5,TH6,TH7);
memory m1(TH0,TH1,TH2,TH3,TH4,TH5,TH6,TH7,memory_out,CLK,FRAME_Neg,RST_Neg);
assign GNT=memory_out;

 
endmodule

// thread the input depending on the zeros, all 1=> all1 and arragne them with piorty
module REQ_THREADER(REQ,THREADING_REQ0,THREADING_REQ1,THREADING_REQ2,THREADING_REQ3,THREADING_REQ4,THREADING_REQ5,THREADING_REQ6,THREADING_REQ7);
//request output only 1 time
input [7:0]REQ;
output reg [7:0]THREADING_REQ0;
output reg [7:0]THREADING_REQ1;
output reg [7:0]THREADING_REQ2;
output reg [7:0]THREADING_REQ3;
output reg [7:0]THREADING_REQ4;
output reg [7:0]THREADING_REQ5;
output reg [7:0]THREADING_REQ6;
output reg [7:0]THREADING_REQ7;
reg [7:0]THREADING_REQ[0:7]; // memory
reg [2:0] location;
//if 0 get out 
//if all 1 output =1111_1111

always@(*)
begin
    
     location=0;
    
      
            if(REQ[0]==1'b0)
            begin
                THREADING_REQ[location]= 8'b1111_1110;  
                location=location+1;
            end
          
        
      
            if(REQ[1]==1'b0)
            begin
                THREADING_REQ[location]<= 8'b1111_1101;  
                location=location+1;
            end
         

        
            if(REQ[2]==1'b0)
            begin
                THREADING_REQ[location]= 8'b1111_1011;
                location=location+1;
            end
         
        
       
            if(REQ[3]==1'b0)
            begin
                THREADING_REQ[location]= 8'b1111_0111;
                location=location+1;
            end
           
        
       
            if(REQ[4]==1'b0)
            begin
                THREADING_REQ[location]= 8'b1110_1111;
                location=location+1;
            end
        
        
      
            if(REQ[5]==1'b0)
            begin
                THREADING_REQ[location]= 8'b1101_1111;
                location=location+1;
            end
           
        
       
            if(REQ[6]==1'b0)
            begin
                THREADING_REQ[location]= 8'b1011_1111;
                location=location+1;
            end
           
        
       
            if(REQ[7]==1'b0)
            begin
                THREADING_REQ[location]= 8'b0111_1111;
                location=location+1;
            end
           

        case(location)
            0:begin
                THREADING_REQ[0]= 8'b1111_1111 ;
                THREADING_REQ[1]= 8'b1111_1111 ;
                THREADING_REQ[2]= 8'b1111_1111 ;
                THREADING_REQ[3]= 8'b1111_1111 ;
                THREADING_REQ[4]= 8'b1111_1111 ;
                THREADING_REQ[5]= 8'b1111_1111 ;
                THREADING_REQ[6]= 8'b1111_1111 ;
                THREADING_REQ[7]= 8'b1111_1111 ;
            end
            
            1:begin
                THREADING_REQ[1]= 8'b1111_1111 ;
                THREADING_REQ[2]= 8'b1111_1111 ;
                THREADING_REQ[3]= 8'b1111_1111 ;
                THREADING_REQ[4]= 8'b1111_1111 ;
                THREADING_REQ[5]= 8'b1111_1111 ;
                THREADING_REQ[6]= 8'b1111_1111 ;
                THREADING_REQ[7]= 8'b1111_1111 ;
            end
            
            2:begin
                THREADING_REQ[2]= 8'b1111_1111 ;          
                THREADING_REQ[3]= 8'b1111_1111 ;        
                THREADING_REQ[4]= 8'b1111_1111 ;      
                THREADING_REQ[5]= 8'b1111_1111 ;    
                THREADING_REQ[6]= 8'b1111_1111 ;  
                THREADING_REQ[7]= 8'b1111_1111 ;
            end
            
            3:begin
                THREADING_REQ[3]= 8'b1111_1111 ;        
                THREADING_REQ[4]= 8'b1111_1111 ;      
                THREADING_REQ[5]= 8'b1111_1111 ;    
                THREADING_REQ[6]= 8'b1111_1111 ;  
                THREADING_REQ[7]= 8'b1111_1111 ;
            end
            
            4:begin
                THREADING_REQ[4]= 8'b1111_1111 ;      
                THREADING_REQ[5]= 8'b1111_1111 ;    
                THREADING_REQ[6]= 8'b1111_1111 ;  
                THREADING_REQ[7]= 8'b1111_1111 ;
            end
            
            5:begin
                THREADING_REQ[5]= 8'b1111_1111 ;    
                THREADING_REQ[6]= 8'b1111_1111 ;  
                THREADING_REQ[7]= 8'b1111_1111 ;
            end
            
            6:begin
                THREADING_REQ[6]= 8'b1111_1111 ;  
                THREADING_REQ[7]= 8'b1111_1111 ;
            end
            
            7:begin
                THREADING_REQ[7]= 8'b1111_1111 ;
            end
        endcase
      
        
        
    
        
  
        THREADING_REQ0<=THREADING_REQ[0];
        THREADING_REQ1<=THREADING_REQ[1];
        THREADING_REQ2<=THREADING_REQ[2];
        THREADING_REQ3<=THREADING_REQ[3];
        THREADING_REQ4<=THREADING_REQ[4];
        THREADING_REQ5<=THREADING_REQ[5];
        THREADING_REQ6<=THREADING_REQ[6];
        THREADING_REQ7<=THREADING_REQ[7];
        
end
endmodule

module memory(IN0,IN1,IN2,IN3,IN4,IN5,IN6,IN7,OUT1,CLK,FRAME,RESET);
input [7:0] IN0,IN1,IN2,IN3,IN4,IN5,IN6,IN7;
output reg [7:0] OUT1;
input CLK,FRAME,RESET;
reg [7:0]MEGA_MIND[0:7], shift_dumy[0:7],MEGA_DUMY[0:7];
reg IN0_FLAG,IN1_FLAG,IN2_FLAG,IN3_FLAG,IN4_FLAG,IN5_FLAG,IN6_FLAG,IN7_FLAG;
//flag1 equals ex
reg first_time,not_first_time,ENABLE_TO_GNT;
reg [1:0]flag;
reg [2:0]free_location;

always@(negedge FRAME)
begin
ENABLE_TO_GNT=0;
end
always@(posedge FRAME)
begin
ENABLE_TO_GNT=1;
end

always@(posedge CLK)
begin
if(~RESET)
begin
OUT1<=8'b1111_1111;
ENABLE_TO_GNT=1;
end
else
begin

 if(first_time==1)
   begin
   
   
   casez(MEGA_MIND[7])
 
    IN0:;
    IN1:;
    IN2:;
    IN3:;
    IN4:;
    IN5:;
    IN6:;
    IN7:;
    default:
    begin
    MEGA_MIND[7]=8'b1111_1111;
    free_location=free_location-1;
    end
    
   endcase
 
    casez(MEGA_MIND[6])
  
      IN0:;
      IN1:;
      IN2:;
      IN3:;
      IN4:;
      IN5:;
      IN6:;
      IN7:;
      default:
      begin
      MEGA_MIND[6]=MEGA_MIND[7];
      MEGA_MIND[7]=8'b1111_1111;
      free_location=free_location-1;
      end
      
      
      endcase
      
      casez(MEGA_MIND[5])
          IN0:;
           IN1:;
           IN2:;
           IN3:;
           IN4:;
           IN5:;
           IN6:;
           IN7:;
           default:
           begin
          
           MEGA_MIND[5]=MEGA_MIND[6];
           MEGA_MIND[6]=MEGA_MIND[7];
           MEGA_MIND[7]=8'b1111_1111;
           free_location=free_location-1;
           end
         
         endcase
         
         casez(MEGA_MIND[4])
            IN0:;
                    IN1:;
                    IN2:;
                    IN3:;
                    IN4:;
                    IN5:;
                    IN6:;
                    IN7:;
                    default:
                    begin
                    MEGA_MIND[4]=MEGA_MIND[5];
                    MEGA_MIND[5]=MEGA_MIND[6];
                    MEGA_MIND[6]=MEGA_MIND[7];
                    MEGA_MIND[7]=8'b1111_1111;
                    free_location=free_location-1;
                    end
            
            endcase
            
            casez(MEGA_MIND[3])
                  IN0:;
                     IN1:;
                     IN2:;
                     IN3:;
                     IN4:;
                     IN5:;
                     IN6:;
                     IN7:;
                     default:
                     begin
                     MEGA_MIND[3]=MEGA_MIND[4];
                     MEGA_MIND[4]=MEGA_MIND[5];
                     MEGA_MIND[5]=MEGA_MIND[6];
                     MEGA_MIND[6]=MEGA_MIND[7];
                     MEGA_MIND[7]=8'b1111_1111;
                     free_location=free_location-1;
                     end
       
               endcase
               
               casez(MEGA_MIND[2])
                     IN0:;
                                 IN1:;
                                 IN2:;
                                 IN3:;
                                 IN4:;
                                 IN5:;
                                 IN6:;
                                 IN7:;
                                 default:
                                 begin
                                 MEGA_MIND[2]=MEGA_MIND[3];
                                 MEGA_MIND[3]=MEGA_MIND[4];
                                 MEGA_MIND[4]=MEGA_MIND[5];
                                 MEGA_MIND[5]=MEGA_MIND[6];
                                 MEGA_MIND[6]=MEGA_MIND[7];
                                 MEGA_MIND[7]=8'b1111_1111;
                                 free_location=free_location-1;
                                 end
                  
                  endcase
                  
                  casez(MEGA_MIND[1])
                        IN0:;
                        IN1:;
                        IN2:;
                        IN3:;
                        IN4:;
                        IN5:;
                        IN6:;
                        IN7:;
                        default:
                        begin
                        MEGA_MIND[1]=MEGA_MIND[2];
                        MEGA_MIND[2]=MEGA_MIND[3];
                        MEGA_MIND[3]=MEGA_MIND[4];
                        MEGA_MIND[4]=MEGA_MIND[5];
                        MEGA_MIND[5]=MEGA_MIND[6];
                        MEGA_MIND[6]=MEGA_MIND[7];
                        MEGA_MIND[7]=8'b1111_1111;
                        free_location=free_location-1;
                        end
                     
                     endcase
                     
                     casez(MEGA_MIND[0])
                           IN0:;
                           IN1:;
                           IN2:;
                           IN3:;
                           IN4:;
                           IN5:;
                           IN6:;
                           IN7:;
                           default:
                           begin
                           MEGA_MIND[0]=MEGA_MIND[1];
                           MEGA_MIND[1]=MEGA_MIND[2];
                           MEGA_MIND[2]=MEGA_MIND[3];
                           MEGA_MIND[3]=MEGA_MIND[4];
                           MEGA_MIND[4]=MEGA_MIND[5];
                           MEGA_MIND[5]=MEGA_MIND[6];
                           MEGA_MIND[6]=MEGA_MIND[7];
                           MEGA_MIND[7]=8'b1111_1111;
                           free_location=free_location-1;
                           end
                        
                        endcase
                           
             //CHECK MEMORY INSIDE THE NEW DATA  AND REMOVE THE UNFOUND REQUESTS
            //===================================================================\\
            
       
        casez(IN0)
        MEGA_MIND[0]: ;
        MEGA_MIND[1]: ;
        MEGA_MIND[2]: ;
        MEGA_MIND[3]: ;
        MEGA_MIND[4]: ;
        MEGA_MIND[5]: ;
        MEGA_MIND[6]: ;
        MEGA_MIND[7]: ;
        default:begin
        
      
        MEGA_MIND[free_location]=IN0;
        free_location=free_location+1;
        end
        endcase
                
        casez(IN1)
        
               MEGA_MIND[0]: ;
               MEGA_MIND[1]: ;
               MEGA_MIND[2]: ;
               MEGA_MIND[3]: ;
               MEGA_MIND[4]: ;
               MEGA_MIND[5]: ;
               MEGA_MIND[6]: ;
               MEGA_MIND[7]: ;
        
        default:begin
        
      
        
        MEGA_MIND[free_location]=IN1;
        free_location=free_location+1;
        end
        endcase
                
        casez(IN2)
        
      MEGA_MIND[0]: ;
               MEGA_MIND[1]: ;
               MEGA_MIND[2]: ;
               MEGA_MIND[3]: ;
               MEGA_MIND[4]: ;
               MEGA_MIND[5]: ;
               MEGA_MIND[6]: ;
               MEGA_MIND[7]: ;
        
        default:begin
        
        MEGA_MIND[free_location]=IN2;
        free_location=free_location+1;
        end
        endcase
        
        casez(IN3)
        
               MEGA_MIND[0]: ;
               MEGA_MIND[1]: ;
               MEGA_MIND[2]: ;
               MEGA_MIND[3]: ;
               MEGA_MIND[4]: ;
               MEGA_MIND[5]: ;
               MEGA_MIND[6]: ;
               MEGA_MIND[7]: ;
        
        default:begin
        
        
     
        MEGA_MIND[free_location]=IN3;
        free_location=free_location+1;
        end
        endcase
        
        casez(IN4)
        
       MEGA_MIND[0]: ;
               MEGA_MIND[1]: ;
               MEGA_MIND[2]: ;
               MEGA_MIND[3]: ;
               MEGA_MIND[4]: ;
               MEGA_MIND[5]: ;
               MEGA_MIND[6]: ;
               MEGA_MIND[7]: ;
        
        default:begin 
        
       
        MEGA_MIND[free_location]=IN4;
        free_location=free_location+1;
        end
        endcase
        
        casez(IN5)
        
      MEGA_MIND[0]: ;
               MEGA_MIND[1]: ;
               MEGA_MIND[2]: ;
               MEGA_MIND[3]: ;
               MEGA_MIND[4]: ;
               MEGA_MIND[5]: ;
               MEGA_MIND[6]: ;
               MEGA_MIND[7]: ;
        
        default:begin
        
        
        

        MEGA_MIND[free_location]=IN5;
        free_location=free_location+1;
        end
        endcase
        
        casez(IN6)
        
        MEGA_MIND[0]: ;
               MEGA_MIND[1]: ;
               MEGA_MIND[2]: ;
               MEGA_MIND[3]: ;
               MEGA_MIND[4]: ;
               MEGA_MIND[5]: ;
               MEGA_MIND[6]: ;
               MEGA_MIND[7]: ;
        
        default:begin
        
        
        
        
        MEGA_MIND[free_location]=IN6;
        free_location=free_location+1;
        end
        
        endcase
        
        casez(IN7)
        
        MEGA_MIND[0]: ;
               MEGA_MIND[1]: ;
               MEGA_MIND[2]: ;
               MEGA_MIND[3]: ;
               MEGA_MIND[4]: ;
               MEGA_MIND[5]: ;
               MEGA_MIND[6]: ;
               MEGA_MIND[7]: ;
       
        default:begin
        if(free_location>7)
      
        MEGA_MIND[free_location]=IN7;  
                
        
        
        free_location=free_location+1;
        end
        
        endcase
       
        
      
                    end
else
 begin

  first_time=1;
   
    free_location=0;
    MEGA_MIND[free_location]=IN0;
    free_location=free_location+1;
    MEGA_MIND[free_location]=IN1;
    free_location=free_location+1;  
    MEGA_MIND[free_location]=IN2;
    free_location=free_location+1;
    MEGA_MIND[free_location]=IN3;
    free_location=free_location+1;
    MEGA_MIND[free_location]=IN4;
    free_location=free_location+1;
    MEGA_MIND[free_location]=IN5;
    free_location=free_location+1;
    MEGA_MIND[free_location]=IN6;
    free_location=free_location+1;
    MEGA_MIND[free_location]=IN7;
    //reset the free location
    if(IN0==8'b1111_1111)
    free_location=0;
    else if(IN1==8'b1111_1111)
    free_location=1;
    else if(IN2==8'b1111_1111)
    free_location=2;
    else if(IN3==8'b1111_1111)
    free_location=3;
    else if(IN4==8'b1111_1111)
    free_location=4;
    else if(IN5==8'b1111_1111)
    free_location=5;
    else if(IN6==8'b1111_1111)
    free_location=6;
    else if(IN7==8'b1111_1111) 
    free_location=7;  
 /*   OUT1=MEGA_MIND[0];//==========
    
    MEGA_DUMY[0]=MEGA_MIND[0];
    MEGA_DUMY[1]=MEGA_MIND[1];
    MEGA_DUMY[2]=MEGA_MIND[2];
    MEGA_DUMY[3]=MEGA_MIND[3];
    MEGA_DUMY[4]=MEGA_MIND[4];
    MEGA_DUMY[5]=MEGA_MIND[5];
    MEGA_DUMY[6]=MEGA_MIND[6];
    MEGA_DUMY[7]=MEGA_MIND[7];  
    MEGA_MIND[0]=    MEGA_DUMY[1];
    MEGA_MIND[1]=    MEGA_DUMY[2];
    MEGA_MIND[2]=    MEGA_DUMY[3];
    MEGA_MIND[3]=    MEGA_DUMY[4];
    MEGA_MIND[4]=    MEGA_DUMY[5];
    MEGA_MIND[5]=    MEGA_DUMY[6];
    MEGA_MIND[6]=    MEGA_DUMY[7];
    MEGA_MIND[7]=    8'b1111_1111;
    if(OUT1!=8'b1111_1111)
    free_location=free_location-1;*/
    
    end
    
    
    
   

end
end

always@(negedge CLK)
begin

if(ENABLE_TO_GNT)
    begin
    if(MEGA_MIND[0]===8'bxxxx_xxxx)
    begin
    OUT1=8'b1111_1111;
   
    end
    else
    begin
    
 OUT1=MEGA_MIND[0];//=============
       
        ENABLE_TO_GNT=0;
        MEGA_MIND[0]<=    MEGA_MIND[1];
        MEGA_MIND[1]<=    MEGA_MIND[2];
        MEGA_MIND[2]<=    MEGA_MIND[3];
        MEGA_MIND[3]<=    MEGA_MIND[4];
        MEGA_MIND[4]<=    MEGA_MIND[5];
        MEGA_MIND[5]<=    MEGA_MIND[6];
        MEGA_MIND[6]<=    MEGA_MIND[7];
        MEGA_MIND[7]<=    8'b1111_1111;
        if(OUT1!=8'b1111_1111)
      free_location=free_location-1;  
     
      end
      end
 end
endmodule


module PCI();
endmodule




module tb_RTH_AND_MEMORY();
reg[7:0]in;
reg clk;
wire [7:0]gnt_out,gnt_out2,fl;
reg [7:0] out0,out1,out2,out3,out4,out5,out6,out7;
reg z=0;
reg[7:0] y=8'b1111_1111;
initial
begin
$monitor( "  out0 = %b out1 = %b out2 = %b out3 = %b out4 = %b  out5 = %b out6 = %b out7 = %b  gnt_out= %b  gnt_out2=%b  fl=%d" ,out0,out1,out2,out3,out4,out5,out6,out7,gnt_out,gnt_out2,fl );
  clk <= 0;
$display("----0-----");
out0=8'b1111_1110;
out1=8'b1111_1101;
out2=8'b1111_1111;
out3=8'b1111_1111;
out4=8'b1111_1111;
out5=8'b1111_1111;
out6=8'b1111_1111;
out7=8'b1111_1111;
#30
$display("----1-----");
out0<=8'b1111_1111;
out1<=8'b1111_1111;
out2<=8'b1111_1111;
out3<=8'b1111_1111;
out4<=8'b1111_1111;
out5<=8'b1111_1111;
out6<=8'b1111_1111;
out7<=8'b1111_1111;

#30
$display("----2-----");
out0<=8'b1111_1011;
out1<=8'b1110_1111;
out2<=8'b0111_1111;
out3<=8'b1111_1111;
out4<=8'b1111_1111;
out5<=8'b1111_1111;
out6<=8'b1111_1111;
out7<=8'b1111_1111;
#30
$display("----3-----");
out0<=8'b1111_1011;
out1<=8'b1110_1111;
out2<=8'b1011_1111;
out3<=8'b0111_1111;
out4<=8'b1111_1111;
out5<=8'b1111_1111;
out6<=8'b1111_1111;
out7<=8'b1111_1111;
#30
$display("----4-----");
out0<=8'b1111_1110;
out1<=8'b1110_1111;
out2<=8'b0111_1111;
out3<=8'b1111_1111;
out4<=8'b1111_1111;
out5<=8'b1111_1111;
out6<=8'b1111_1111;
out7<=8'b1111_1111;
 

end
always
begin
    #15
    clk = ~clk;
end

memory a2(out0,out1,out2,out3,out4,out5,out6,out7,gnt_out,clk);



endmodule

module tb_arbiter_priority();

wire [7:0] GNT;
reg [7:0] REQ;
reg FRAME,clk,RST;

integer i;
initial
begin
    $monitor($time ,, "REQ = %b  FRAME = %b  GNT = %b  RST = %b" , REQ , FRAME , GNT , RST);
    #2
    clk <= 0;
    RST <= 0;
    FRAME <= 1;
    #5
    RST <= 1;
    for(i = 0 ; i < 20 ; i = i + 1)
    begin
        #10
        REQ <= $urandom %8;
        //  RST <= $urandom %2;
    end
end

always
begin
    #25
    FRAME = ~FRAME;
end

always
begin
    #5
    clk = ~clk;
end


arbiter_priority arbiter_priority_test(GNT,REQ,FRAME,clk,RST);
endmodule

module tb_arbiter_RobinRound();

wire [7:0] GNT;
reg [7:0] REQ;
reg FRAME,clk,RST;

integer i;
initial
    begin
    $monitor($time ,, "REQ = %b  FRAME = %b  GNT = %b  RST = %b" , REQ , FRAME , GNT , RST);
    clk <= 0;
    RST <= 0;
    FRAME <= 1;
    #8
    RST <= 1;
    for(i = 0 ; i < 20 ; i = i + 1)
    begin
        #10
        REQ <= $urandom %8;
        //  RST <= $urandom %2;
    end
end

always
begin
    #25
    FRAME = ~FRAME;
end

always
begin
    #5
    clk = ~clk;
end


arbiter_RobinRound arbiter_RobinRound_test(GNT,REQ,FRAME,clk,RST);
endmodule

module tb_fcfs();

wire [7:0] GNT;
reg [7:0] REQ;
reg FRAME,clk,RST;

integer i;
initial
    begin
    $monitor($time ,, "REQ = %b  FRAME = %b  GNT = %b  RST = %b" , REQ , FRAME , GNT , RST);
    #2
    clk <= 0;
    RST <= 0;
    FRAME <= 1;
    #5
    RST <= 1;
        for(i = 0 ; i < 20 ; i = i + 1)
    begin
        #5
        REQ <= $urandom %8;
        //  RST <= $urandom %2;
        // FRAME <= $urandom %2;
    end
end

always
begin
    #5
    clk = ~clk;
end


arbiter_FCFS arbiter_test(GNT,REQ,FRAME,clk,RST);
endmodule

module tb_arbiter_FCFS();
wire EN;
wire [7:0] GNT;
reg [7:0] REQ;
reg FRAME,clk,RST;

integer i;
initial
    begin
    $monitor($time ,, "REQ = %b  FRAME = %b  GNT = %b  RST = %b EN=%b" , REQ , FRAME , GNT , RST,EN);
    clk <= 0;
    RST <= 0;
    FRAME <= 1;
    #12
    RST <= 1;
    #1
    REQ <= 8'b1111_1101;
    #10
    REQ <= 8'b1111_0101;
    #10
    FRAME <= 0;
    REQ <= 8'b1001_0111;
    #10
    FRAME <= 1;
    REQ <= 8'b1001_0110;
    #10
    FRAME <= 0;
    REQ <= 8'b1001_1110;
    #10
    FRAME <= 1;
    REQ <= 8'b1011_1010;
    #10
    REQ <= 8'b1111_1010; 
    #10
    REQ <= 8'b1111_1011; 
    #10
    REQ <= 8'b1111_1111;  
end

/*always
begin
    #25
    FRAME = ~FRAME;
end*/

always
begin
    #5
    clk = ~clk;
end


arbiter_FCFS arbiter_FCFS_test(GNT,REQ,FRAME,clk,RST,EN);
endmodule


module device_tb();

wire [31:0] Output0, Output1;

reg FORCED_REQ_N;
reg [31:0] MIN_ADDRESS;
reg [31:0] FORCED_ADDRESS;
reg [3:0] FORCED_CBE_N;

reg CLK, RST_N, GNT_N;

wire [31:0] AD;	
wire [3:0] CBE_N;
wire FRAME_N, IRDY_N, TRDY_N, DEVSEL_N;

reg FRAME_Nreg, IRDY_Nreg, TRDY_Nreg, DEVSEL_Nreg;
reg [31:0] ADreg;	
reg [3:0] CBE_Nreg;
reg [3:0] DataTfNo;
wire REQ_N;

assign FRAME_N = FRAME_Nreg;
assign IRDY_N = IRDY_Nreg;
assign TRDY_N = TRDY_Nreg;
assign DEVSEL_N = DEVSEL_Nreg;
assign AD = ADreg;
assign CBE_N = CBE_Nreg;


initial
begin
CLK <= 0;
RST_N <= 0;
MIN_ADDRESS <= 32'h0000_0001;
IRDY_Nreg <= 1'bz;
TRDY_Nreg <= 1'bz;
FRAME_Nreg <= 1'bz;
DEVSEL_Nreg <= 1'bz;
CBE_Nreg <= 4'bzzzz;
ADreg <= {(32){1'bz}};
#12
RST_N <= 1;
FORCED_REQ_N <= 0;
FORCED_ADDRESS <= 32'h0000_0002;
FORCED_CBE_N <= 4'b0110;
#10
GNT_N <= 0;
#10
DEVSEL_Nreg <= 0;
#20
TRDY_Nreg <= 0;
ADreg <= 32'h1000_0000;
#10
ADreg <= 32'h2000_0000;
#10
ADreg <= 32'h3000_0000;
#10
ADreg <= 32'h4000_0000;
#10
ADreg <= 32'h5000_0000;
#10
ADreg <= 32'h6000_0000;
#10
ADreg <= 32'h7000_0000;
#10
ADreg <= 32'h8000_0000;
#10
ADreg <= 32'h9000_0000;
#10
ADreg <= 32'hA000_0000;


#10
DEVSEL_Nreg <= 1;
ADreg <= {(32){1'bz}};
#10
FORCED_CBE_N <= 4'b0111;
#20
GNT_N <= 0;
#15
DEVSEL_Nreg <= 0;
#5
TRDY_Nreg <= 0;



end

always
begin
#5 CLK = ~CLK;
end
device_A device_tb(Output0,Output1,CLK, RST_N, AD, CBE_N, FRAME_N, IRDY_N, TRDY_N, DEVSEL_N, REQ_N, GNT_N, FORCED_REQ_N, FORCED_ADDRESS, FORCED_CBE_N,DataTfNo, MIN_ADDRESS);

endmodule