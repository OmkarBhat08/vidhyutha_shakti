module alu_32_tb();
    reg clk, rst;
    reg [31:0] a_in, b_in;
    reg [3:0] select;
    wire [31:0] y_out;
    wire flag, carry_bit;

    alu_32 DUT (clk, rst, a_in, b_in, select, y_out, flag, carry_bit);
    integer i,j,k;
    always
        #5 clk = ~clk;
    initial
    begin
        clk=0;
        #5 rst=1'b1;
        #5 rst=1'b0;
        for(k=0;k<3;k=k+1)
        begin
            for(i=0;i<32;i=i+1)
            begin
                for(j=0;j<32;j=j+1)
                begin
                    a_in= i;
                    b_in= j;
                    select= k;
                    #10;
                    $display("-----------------------------");
                    $display("a_in=%1b opcode=%1b b_in=%1b = y_out=%1b | flag=%1b | carry=%1b",a_in, select, b_in, y_out, flag, carry_bit);
                    $display("a_in=%1d opcode=%1d b_in=%1d = y_out=%1d | flag=%1b | carry=%1b",a_in, select, b_in, y_out, flag, carry_bit);
                end
            end
            $display("-----------------------------");
        end
        $finish;
    end
endmodule
