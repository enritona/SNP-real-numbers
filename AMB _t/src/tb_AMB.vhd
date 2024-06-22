library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_AMB is
end tb_AMB;

architecture behavior_tb of tb_AMB is
	signal clk_tb: std_logic;
	signal en_tb: std_logic;
	
	signal isc1_tb: integer;
	signal isc2_tb: integer;
	signal isc3_tb: integer;
	
	signal irc1_tb: integer;
	signal irc2_tb: integer;
	signal irc3_tb: integer;
	
	signal in_tb: std_logic;
	
	signal in_sum_tb: std_logic;
	
	signal out_c1_tb: std_logic;
	signal out_c2_tb: std_logic;
	signal out_c3_tb: std_logic;
	signal out_sp_tb: std_logic;
	signal out_sn_tb: std_logic;
	constant clk_period: time := 2000 ns;
	
begin
	--Reconexión de entidades--	
	t_circuit: entity work.AMB(behavior)
		port map (
				  en_A  => en_tb,
				  clk_A => clk_tb,
				  
				  in_sc1 => isc1_tb,
				  in_sc2 => isc2_tb,
				  in_sc3 => isc3_tb,
				  
				  in_rc1 => irc1_tb,
				  in_rc2 => irc2_tb,
				  in_rc3 => irc3_tb,
				  
				  in_n => in_tb,
				  
				  in_suma => in_sum_tb,
				  
				  out_c1 => out_c1_tb,
				  out_c2 => out_c2_tb,
				  out_c3 => out_c3_tb,
				  out_sp => out_sp_tb,
				  out_sn => out_sn_tb
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
					
					in_sum_tb <= '0';
					
					isc1_tb <= 0;
					isc2_tb <= 0;
					isc3_tb <= 0;
					
					irc1_tb <= 0;
					irc2_tb <= 0;
					irc3_tb <= 0;
					wait for clk_period;
					en_tb <= '1';
					
					in_tb <= '1';
					
					in_sum_tb <= '0';
					
					isc1_tb <= 1;
					isc2_tb <= 7;
					isc3_tb <= 5;
					
					irc1_tb <= 2;
					irc2_tb <= 1;
					irc3_tb <= 3;
					
					wait for clk_period;
					in_tb <= '0';
					
					in_sum_tb <= '0';
					
					isc1_tb <= 0;
					isc2_tb <= 0;
					isc3_tb <= 0;
					
					irc1_tb <= 0;
					irc2_tb <= 0;
					irc3_tb <= 0;
					wait for 700000	ns;
			end process;
end ;
	