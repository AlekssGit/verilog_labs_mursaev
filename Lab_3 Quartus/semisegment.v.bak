	//Модуль превращения числа от 1 до 15 (hex) 
//		в значение сегментов на семисигментном индикаторе
//Работа данного модуля основана на обычном дешифраторе
module semisegment (
	input [3:0] number, //Входное число
	output [6:0] result //Выходное значение сегментов
);

always@*
begin
	case(number)
	4'd0 : result = 7'b0111111;
	4'd1 : result = 7'b0000110;
	4'd2 : result = 7'b1011011;
	4'd3 : result = 7'b1001111;
	4'd4 : result = 7'b1100110;
	4'd5 : result = 7'b1101101;
	4'd6 : result = 7'b1111101;
	4'd7 : result = 7'b0000111;
	4'd8 : result = 7'b1111111;
	4'd9 : result = 7'b1101111;
	4'd10: result = 7'b1110111;
	4'd11: result = 7'b1111100;
	4'd12: result = 7'b0111001;
	4'd13: result = 7'b1011110;
	4'd14: result = 7'b1111001;
	4'd15: result = 7'b1110001;
	endcase
end

endmodule