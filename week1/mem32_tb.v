module mem32_tb();
    reg clk, rst, wr, rd;
    reg [3:0] InAddr;
    reg [31:0] InData;
    wire [31:0] dataout;
    wire [7:0] datain;
    wire valid;
   
    integer i;
    wire [3:0] Addr;
    wire [7:0] Dataout;
   
    assign Addr= DUT.mem_module.Addr;
    assign Dataout=DUT.mem_module.Dataout;
   
    mem32 DUT(
        .clk(clk),
        .rst(rst),
        .wr(wr),
        .rd(rd),
        .InAddr(InAddr),
        .InData(InData),
        .dataout(dataout),
        .datain(datain),
        .valid(valid)
        );
   
    always
        #5 clk = ~clk;
    initial
    begin
        clk=0;
        rst =1;
        #5 rst=0;
        for(i=0;i<4;i=i+1)
        begin
            $display("--------------------------------------------");
            wr=1'b1;
            rd=1'b0;
            InAddr=i; //4'd0
            if (i%2==0)
                InData=32'b0110000001011011010111101100000; //302DAF60
            else
                InData=32'b1110011010111100000010111010010; //735E05D2
            $display("time=%1d rst:%1d \t Mode: %1d/%1d \t Address: %1d \t DataIn: %1d DataOut: %1d",$time,rst,wr,rd,InAddr,InData, dataout);
            #110;
            wr=1'b0;
            rd=1'b1;
            $display("time=%1d rst:%1d \t Mode: %1d/%1d \t Address: %1d \t DataIn: %1d DataOut: %1d",$time,rst,wr,rd,InAddr,InData, dataout);
            $display("--------------------------------------------");
            #115;
        end
        #10 $finish;
    end
endmodule
