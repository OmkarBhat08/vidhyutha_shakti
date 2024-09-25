module mem(
    input clk,
    input rst,
    input wr,
    input rd,
    input [7:0] Datain,
    input [3:0] Addr,
    output reg [7:0] Dataout
    );

    reg [7:0] A [0:15];
   
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
            A[10] <= 8'b0;
            A[11] <= 8'b0;
            A[12] <= 8'b0;
            A[13] <= 8'b0;
            A[14] <= 8'b0;
            A[15] <= 8'b0;
            Dataout <= 8'b0;  
        end
        else
        begin
            if (wr)
                A[Addr] <= Datain;  // Write to memory
            else if (rd)
                Dataout <= A[Addr]; // Read from memory
            else
                Dataout <= 8'bz;
        end
    end
endmodule
