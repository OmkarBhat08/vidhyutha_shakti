module mem(
    input clk,
    input rst,
    input wr,
    input rd,
    input [7:0] Datain,
    input [3:0] Addr,
    output reg [7:0] Dataout
    );

    reg [7:0] A [0:10];
   
    always @(posedge clk)
    begin
        if (rst)
        begin
            A[0] <= 8'b0;
            A[1] <= 8'b0;
            A[2] <= 8'b0;
            A[3] <= 8'b0;
            A[4] <= 8'b0;
            A[5] <= 8'b0;
            A[6] <= 8'b0;
            A[7] <= 8'b0;
            A[8] <= 8'b0;
            A[9] <= 8'b0;
            Dataout <= 8'b0;  
        end
        else
        begin
            case ({wr, rd})
                2'b10:
                begin
                    A[Addr] <= Datain;
                end
                2'b01:
                begin
                    Dataout <= A[Addr];
                end
                default:
                begin
                    Dataout <= 8'bz;
                end
            endcase
        end
    end
endmodule
