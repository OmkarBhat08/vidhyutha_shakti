module alu_32(
    input clk, rst,
    input [31:0] a_in, b_in,
    input [3:0] select,
    output reg [31:0] y_out,
    output reg flag, carry_bit);
   
    always @ (posedge clk)
    begin
        if(rst)
        begin
            y_out=32'd0;
            carry_bit=1'd0;
            flag=1'b0;
        end
        else
        begin
            flag=1'b0;
            case(select)
                4'b0000:        // ADD
                begin
                    {carry_bit,y_out} = a_in + b_in;
                    if (carry_bit == 1'b1)
                        flag=1'b1;
                    else
                        flag=1'b0;
                end
                4'b0001: y_out=a_in - b_in;      //SUB
                4'b0010: y_out=a_in * b_in;      //MULL
                4'b0011: y_out=a_in >> b_in;     //SLR
                4'b0100: y_out=a_in << b_in;     //SLL
                4'b0101: y_out=a_in & b_in;      //AND
                4'b0110: y_out=a_in | b_in;      //OR
                4'b0111: y_out=a_in ^ b_in;      //XOR
                4'b1000: y_out= ~a_in;           //NOT
                default:
                        y_out=32'd0;
            endcase
        end
    end
endmodule
