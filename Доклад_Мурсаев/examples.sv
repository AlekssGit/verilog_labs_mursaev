// Пример 1
class myPacket
	rand bit [7:0] byte;
	constraint constr_byte { byte < 3; }
endclass

module tb_top;
	myPacket data;
	initial 
	begin
		data = new();
		for(int i = 0; i < 15; i++)
		begin
			assert(data.randomize());
		end
	end
endmodule

//Пример 2 - виды ограничений
class myPacket
	rand bit [2:0] mode;
	rand bit [3:0] len;
	rand bit [7:0] data;
	//Внутри промежутка
	constraint constr_mode { mode inside {[1 : 5]};} 
	//Если режим 2, то длина больше 10. 
	//Для организации if-else используются стандартные конструкции if-else
	constraint constr_len { mode == 2 -> len > 10; } 
	
	// Вероятность получения данных: 4 с вероятностью 10%, 
	//								43 с вероятностью 30%, 
	//								45,46,47 с вероятностью 20%
	constraint constr_data { data dist {4:/10, 43:/30, [45:47]:/60 };
endclass

module tb_top;
	myPacket data;
	initial 
	begin
		data = new();
		for(int i = 0; i < 15; i++)
		begin
			assert(data.randomize());
		end
	end
endmodule


// Пример 3 Функции рандомизации
// pre-randomize() функция используется для того, чтобы инициализировать переменные, которые используются для ограничений.
// post-randomize() функция используется для того, чтобы произвести расчёты на основе полученных после рандомизации данных.
class myPacket
	rand bit [7:0] byte_1;
	rand bit [7:0] byte_2;
	int low, high, sum;
	constraint constr_byte_1 { byte_1 inside {[low:high]}; }
	constraint constr_byte_2 { byte_2 inside {[2:10]}; }
	
	function void pre_randomize ();
		this.low = 1;
		this.high = 100;
		$display ("This called before randomization");
	endfunction
	
	function void post_randomize();
		this.sum = this.byte_1 + this.byte_2;
		$display ("This called after randomization");
	endfunction
endclass

module tb_top;
	myPacket data;
	initial 
	begin
		data = new();
		for(int i = 0; i < 15; i++)
		begin
			assert(data.randomize());
		end
	end
endmodule