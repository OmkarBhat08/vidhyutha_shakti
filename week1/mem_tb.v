module mem_tb();
    reg clk, rst, wr, rd;
    reg [3:0] addr;
    reg [7:0] data_in;
    wire [7:0] data_out;
    
    integer i;
    
    mem DUT(
        .clk(clk),
        .rst(rst),
        .wr(wr),
        .rd(rd),
        .Datain(data_in),
        .Addr(addr),
        .Dataout(data_out)
        );
    
    always 
        #5 clk = ~clk;
    initial
    begin
        clk=0;
        rst =1;
        #5 rst=0;
        
        for(i=0; i<10; i=i+1)
        begin
            $display("--------------------------------------------");
            wr=1'b1;
            rd=1'b0;
            addr=i;
            data_in=i;
            $display("time=%1d rst:%1d \t Mode: %1d/%1d \t Address: %1d \t DataIn: %1d DataOut: %1d",$time,rst,wr,rd,addr,data_in, data_out);
            #10;
            wr=1'b0;
            rd=1'b1;
            $display("rst:%1d \t Mode: %1d/%1d \t Address: %1d \t DataIn: %1d DataOut: %1d",rst,wr,rd,addr,data_in, data_out);
            $display("--------------------------------------------");
            #10;
        end
        
        #10;
        $display("--------------------------------------------");
        wr=1'b0;
        rd=1'b0;
        addr=i;
        data_in=i;
        $display("time=%1d rst:%1d \t Mode: %1d/%1d \t Address: %1d \t DataIn: %1d DataOut: %1d",$time,rst,wr,rd,addr,data_in, data_out);
        #10;
        wr=1'b0;
        rd=1'b1;
        $display("rst:%1d \t Mode: %1d/%1d \t Address: %1d \t DataIn: %1d DataOut: %1d",rst,wr,rd,addr,data_in, data_out);
        $display("--------------------------------------------");
        #10;
        
        #10;
        $display("--------------------------------------------");
        wr=1'b1;
        rd=1'b1;
        addr=i;
        data_in=i;
        $display("time=%1d rst:%1d \t Mode: %1d/%1d \t Address: %1d \t DataIn: %1d DataOut: %1d",$time,rst,wr,rd,addr,data_in, data_out);
        #10;
        wr=1'b0;
        rd=1'b1;
        $display("rst:%1d \t Mode: %1d/%1d \t Address: %1d \t DataIn: %1d DataOut: %1d",rst,wr,rd,addr,data_in, data_out);
        $display("--------------------------------------------");
        #10;  
        
        #50 $finish;
    end
endmodule
