library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Z_Su is port
	(
	en: in std_logic;
	clk: in std_logic;
	in_c1: in std_logic;
	in_Zc_c1: in std_logic;
	in_n: in std_logic;
	in_r: in std_logic;
	
	--Salidas de Spikes de colores--
	out_c2_1: out std_logic := '0';
	out_c2_2: out std_logic := '0';
	out_n: out std_logic := '0'
	); 
end Z_Su;

architecture behavior of Z_Su is
	--Contadores de clk y acumulación de Spikes--
	signal cont_clk: integer := 0;
	signal cont_c1: integer := 0;
	signal cont_n: std_logic := '1';
	signal aux: std_logic := '0';
	
	begin
		--Conteo clk--	
		process (clk)
		begin
			--Aumenta el contador de clk en cada ciclo--
			if(clk'event and clk ='1' and en = '1') then 
				cont_clk <= cont_clk + 1;
			end if;
		end process;				
		
		process (clk)
		begin
			if(clk'event and clk = '1' and en = '1') then
				
				if(in_c1 = '1' and in_Zc_c1 = '1' and aux = '0') then
					cont_c1 <= cont_c1 + 2;
				elsif((in_c1 = '1' or in_Zc_c1 = '1') and aux = '0') then
					cont_c1 <= cont_c1 + 1;
				--Disparo de spikes de color 1--
				elsif(aux = '1' and cont_c1 > 9) then
					cont_c1 <= 0;
				elsif(in_r = '1') then
					cont_c1 <= 0;
				end if;
			end if;
		end process;
		
		process (clk)
		begin
			if(clk'event and clk ='1' and en = '1') then
				--Señal auxiliar para disparar los spikes de colores--
				if(in_n = '1' and aux = '0') then
					aux <= '1';				
				--Vuelta a condiciones inicales--
				elsif(aux = '1') then
					aux <= '0';
				end if;
			end if;
		end process;
		
		process (clk)
		begin
			if(clk'event and clk ='1' and en = '1') then
				--Disparo de spike normal--
				if(aux = '1' and cont_n = '1') then
					cont_n <= '0';				
				--Vuelta a condiciones inicales--
				elsif(cont_n = '0') then
					cont_n <= '1';
				end if;
			end if;
		end process;
		
		out_c2_1 <= '1' when(aux = '1' and cont_c1 > 9) else '0';
		out_c2_2 <= '1' when(aux = '1' and cont_c1 > 9) else '0';
		out_n <= '1' when(aux = '1' and cont_n = '1') else '0';
		
end behavior;