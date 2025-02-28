`timescale 1ns / 1ps
`include "configs.vh"
module swdec (
    input wire [5:0] opM, //最高32-26位的 op字段
    input wire [31:0] addr, // 写地址，末两位决定写哪个字节或是高低位,由存储器本身决定
    input wire [31:0] writedataM, // 从执行阶段传递过来的写ram值，在这里进行修改
    output reg [3:0] memwriteM,
    output reg [31:0] writedata2M // 经过字节半字处理的写入ram的值
);
    always @(*) begin
        case (opM)
            `SW: begin // store word 需要将32位的数据完整地写入内存
                memwriteM = 4'b1111;
                writedata2M = writedataM; //
            end
            `SH: begin // store half word 需要将16位的数据写入内存
                writedata2M = {2{writedataM[15:0]}};
                case (addr[1:0])
                2'b00: memwriteM = 4'b0011;
                2'b10: memwriteM = 4'b1100;
                default: begin
                    memwriteM = 4'b0000;
                    writedata2M = writedataM;
                end 
                endcase
            end
            `SB: begin  //store byte 只存储一个字节 需要将8位的数据写入内存
                writedata2M = {4{writedataM[7:0]}};
                case (addr[1:0])
                2'b00: memwriteM = 4'b0001;
                2'b01: memwriteM = 4'b0010;
                2'b10: memwriteM = 4'b0100;
                2'b11: memwriteM = 4'b1000;
                default: begin
                    memwriteM = 4'b0000;
                    writedata2M = writedataM;
                end 
                endcase
            end
            default: begin
                memwriteM = 4'b0000;
                writedata2M = writedataM;
            end 
        endcase
    end
endmodule