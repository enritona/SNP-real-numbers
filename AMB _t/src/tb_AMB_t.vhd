library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_AMB_t is
end tb_AMB_t;

architecture behavior_tb of tb_AMB_t is
	signal clk_tb: std_logic;
	signal en_tb: std_logic;
	
	signal in_c1_1_tb: integer;
	signal in_c2_1_tb: integer;
	signal in_c3_1_tb: integer;
	
	signal in_c1_2_tb: integer;
	signal in_c2_2_tb: integer;
	signal in_c3_2_tb: integer;
	
	signal in_tb: std_logic;
	
	signal in_suma_tb: std_logic;
	
	signal out_c1_tb: std_logic;
	signal out_c2_tb: std_logic;
	signal out_c3_tb: std_logic;
	signal out_sp_tb: std_logic;
	signal out_sn_tb: std_logic;
	constant clk_period: time := 2000 ns;
	
begin
	--Reconexión de entidades--	
	t_circuit: entity work.AMB_t(behavior)
		port map (
				  en_At  => en_tb,
				  clk_At => clk_tb,
				  
				  in_n1_1 => in_c1_1_tb,
				  in_n2_1 => in_c2_1_tb,
				  in_n3_1 => in_c3_1_tb,
				  
				  in_n1_2 => in_c1_2_tb,
				  in_n2_2 => in_c2_2_tb,
				  in_n3_2 => in_c3_2_tb,
				  
				  in_n_t => in_tb,
				  
				  in_suma_t => in_suma_tb,
				  
				  out_c1_t => out_c1_tb,
				  out_c2_t => out_c2_tb,
				  out_c3_t => out_c3_tb,
				  out_sp_t => out_sp_tb,
				  out_sn_t => out_sn_tb
				  );
	--Generación del ciclo de reloj--
	clk_process: process
		   begin
				clk_tb <= '0';
				wait for clk_period/2;  
				clk_tb <= '1';
				wait for clk_period/2; 
		   end process;
		   
	--Prueba de trabajo para el entorno--
	int_process: process
					begin
					en_tb <= '0';
					
					in_tb <= '0';
					
					in_suma_tb <= '0';
					
					in_c1_1_tb <= 0;
					in_c2_1_tb <= 0;
					in_c3_1_tb <= 0;
					
					in_c1_2_tb <= 0;
					in_c2_2_tb <= 0;
					in_c3_2_tb <= 0;
					wait for clk_period;
					en_tb <= '1';
					
					in_tb <= '1';
					
					in_suma_tb <= '0';
					
					in_c1_1_tb <= 0;
					in_c2_1_tb <= 5;
					in_c3_1_tb <= 0;
					
					in_c1_2_tb <= 4;
					in_c2_2_tb <= 6;
					in_c3_2_tb <= 0;
					wait for clk_period;
					in_tb <= '0';
					
					in_suma_tb <= '0';
					
					in_c1_1_tb <= 0;
					in_c2_1_tb <= 0;
					in_c3_1_tb <= 0;
					
					in_c1_2_tb <= 0;
					in_c2_2_tb <= 0;
					in_c3_2_tb <= 0;
					
					wait for 700000 ns;
			end process;
end ;
	