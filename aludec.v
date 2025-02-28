`timescale 1ns / 1ps
`include "configs.vh"

module aludec(
	input wire stall,
	input wire [5:0] funct,
	input wire [3:0] aluop,
	output reg [4:0] alucontrol
    );
	always @(*) begin
		if (~stall)begin
			case (aluop)
			// 逻辑运算
			`ANDI_OP: alucontrol <= `AND_CONTROL;
			`XORI_OP: alucontrol <= `XOR_CONTROL;
			`LUI_OP: alucontrol <= `LUI_CONTROL;
			`ORI_OP: alucontrol <= `OR_CONTROL;
			// 算术运算
			`ADDI_OP: alucontrol <= `ADD_CONTROL;
			`ADDIU_OP: alucontrol <= `ADDU_CONTROL;
			`SLTI_OP: alucontrol <= `SLT_CONTROL;
			`SLTIU_OP: alucontrol <= `SLTU_CONTROL;
			// 访存
			`MEM_OP: alucontrol <= `ADD_CONTROL; // 访存都是用add算地址
			// 特权
			`MFC0_OP: alucontrol <= `MFC0_CONTROL;
			`MTC0_OP: alucontrol <= `MTC0_CONTROL;
			// R-type
			`R_TYPE_OP : case (funct) 
				// 逻辑运算
				`AND: alucontrol <= `AND_CONTROL;
				`OR: alucontrol <= `OR_CONTROL;
				`XOR: alucontrol <= `XOR_CONTROL;
				`NOR: alucontrol <= `NOR_CONTROL;
				// 移位运算
				`SLL: alucontrol <= `SLL_CONTROL;
				`SRL: alucontrol <= `SRL_CONTROL;
				`SRA: alucontrol <= `SRA_CONTROL;
				`SLLV: alucontrol <= `SLLV_CONTROL;
				`SRLV: alucontrol <= `SRLV_CONTROL;
				`SRAV: alucontrol <= `SRAV_CONTROL;
				// 数据移动
				`MTHI: alucontrol <= `MTHI_CONTROL;
				`MTLO: alucontrol <= `MTLO_CONTROL;
				`MFHI: alucontrol <= `MFHI_CONTROL;
				`MFLO: alucontrol <= `MFLO_CONTROL;
				// 算术运算
				`ADD: alucontrol <= `ADD_CONTROL;
				`ADDU: alucontrol <= `ADDU_CONTROL;
				`SUB: alucontrol <= `SUB_CONTROL;
				`SUBU: alucontrol <= `SUBU_CONTROL;
				`SLT: alucontrol <= `SLT_CONTROL;
				`SLTU: alucontrol <= `SLTU_CONTROL;
				`MULT: alucontrol <= `MULT_CONTROL;
				`MULTU: alucontrol <= `MULTU_CONTROL;
				`DIV: alucontrol <= `DIV_CONTROL;
				`DIVU: alucontrol <= `DIVU_CONTROL;
				default:  alucontrol <= 5'b0;
			endcase
			default: alucontrol <= 5'b0;
		endcase
	end
	end
endmodule