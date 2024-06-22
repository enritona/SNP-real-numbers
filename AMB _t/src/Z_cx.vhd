library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Z_cx is port
	(
	en: in std_logic;
	clk: in std_logic;
	
	in_n: in std_logic;
	
	--Salidas de Spikes de colores--

	out_n: out std_logic := '0';
	out_ps: out std_logic := '0';
	out_ng: out std_logic := '0'
	); 
end Z_cx;

architecture behavior of Z_cx is
	--Contadores de clk y acumulación de Spikes--
	signal cont_clk: integer := 0;

	signal cont_n: std_logic := '1';
	signal cont_ps: std_logic :='1';
	signal cont_ng: std_logic := '1';
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
			if(clk'event and clk ='1' and en = '1') then
				if(aux = '1') then
					cont_n <= '0';
				else
					cont_n <= '1';
				end if;
			end if;
		end process;
		
		process (clk)
		begin
			if(clk'event and clk ='1' and en = '1') then
				if(aux = '1') then
					cont_ps <= '0';
				else
					cont_ps <= '1';
				end if;
			end if;
		end process;
		
		process (clk)
		begin
			if(clk'event and clk ='1' and en = '1') then
				if(aux = '1') then
					cont_ng <= '0';
				else
					cont_ng <= '1';
				end if;
			end if;
		end process;
		
		process (clk)
		begin
			if(clk'event and clk ='1' and en = '1') then
				--Señal auxiliar para disparar los spikes de colores--
				if(in_n = '1') then
					aux <= '1';				
				--Vuelta a condiciones inicales--
				else
					aux <= '0';
				end if;
			end if;
		end process;
		
		
		out_n <= '1' when(aux = '1' and cont_n = '1') else '0';
		out_ps <= '1' when(aux = '1' and cont_ps = '1') else '0';
		out_ng <= '1' when(aux = '1' and cont_ng = '1') else '0';	

		
end behavior;