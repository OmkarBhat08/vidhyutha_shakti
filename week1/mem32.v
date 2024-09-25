module mem32(
    input clk,
    input rst,
    input wr,
    input rd,
    input [3:0] InAddr,
    input [31:0] InData,
    output reg [31:0] dataout,
    output reg [7:0] datain,
    output reg valid);
    
    wire [7:0] Dataout;
    reg [3:0] Addr;
    
    mem mem_module(
        .clk(clk),
        .rst(rst),
        .wr(wr),
        .rd(rd),
        .Datain(datain),
        .Addr(Addr),
        .Dataout(Dataout));
      
    parameter RESET = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              S3 = 3'b011,
              S4 = 3'b100,
              VALID = 3'b101;
    
    reg [2:0] state, next_state;

    always @ (posedge clk)
    begin
        if (rst)
            state <= RESET;
        else
            state <= next_state;
    end
    
    always @ (posedge clk)
    begin
        case(state)
            RESET:
                next_state <= S1;
            S1:
                next_state <= S2;
            S2:
                next_state <= S3;
            S3:
                next_state <= S4;
            S4:
                next_state <= VALID;
            VALID:
                next_state <= S1;
            default:
                next_state <= S1;
        endcase
    end
    
    always @ (posedge clk)
    begin
        case(state)
            RESET:
            begin
                dataout <= 32'd0;
                datain <= 32'd0;
                valid <= 1'd0;
                Addr<= 4'd0;
            end
            S1:
            begin
                Addr<=InAddr;
                valid = 0;
                if({wr,rd}== 2'b01)
                    dataout[31:24] <= Dataout;
                else if ({wr,rd}== 2'b10)
                    datain <= InData[7:0];
                else if({wr,rd}== 2'b11)  //Write After Read
                begin
                     dataout[7:0] <= Dataout;
                     datain <= InData[7:0];
                end
                else
                begin
                    // Do nothing
                end  
            end
            S2:
            begin
                Addr <=InAddr+1;
                valid = 0;
                if({wr,rd}== 2'b01)
                    dataout[7:0] <= Dataout;
                else if ({wr,rd}== 2'b10)
                    datain <= InData[15:8];
                else if({wr,rd}== 2'b11)  //Write After Read
                begin
                     dataout[15:8] <= Dataout;
                     datain <= InData[15:8];
                end
                else
                begin
                    // Do nothing
                end
            end
            S3:
            begin
                Addr <=InAddr+2;
                valid = 0;
                if({wr,rd}== 2'b01)
                    dataout[15:8] <= Dataout;
                else if ({wr,rd}== 2'b10)
                    datain <= InData[23:16];
                else if({wr,rd}== 2'b11)  //Write After Read
                begin
                    dataout[23:16] <= Dataout;
                    datain <= InData[23:16];
                end
                else
                begin
                    // Do nothing
                end  
            end
            S4:
            begin
                Addr =InAddr+3;
                valid=0;
                if({wr,rd}== 2'b01)
                    dataout[23:16] = Dataout;
                else if ({wr,rd}== 2'b10)
                    datain = InData[31:24];
                else if({wr,rd}== 2'b11)  //Write After Read
                begin
                    dataout[31:24] <= Dataout;
                    datain <= InData[31:24];
                end
                else
                begin
                    // Do nothing
                end  
             end
             VALID:
                valid=1;
        endcase
    end
endmodule
