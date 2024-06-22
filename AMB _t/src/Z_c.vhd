library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Z_c is port
	(
	en: in std_logic;
	clk: in std_logic;
	in_c1: in std_logic;
	in_c2: in std_logic;
	in_c3: in std_logic;
	
	in_n: in std_logic;
	
	--Salidas de Spikes de colores--
	out_c1: out std_logic := '0';
	out_c2a: out std_logic := '0';
	out_c2: out std_logic := '0';
	out_c3: out std_logic := '0';
	out_n: out std_logic := '0'
	); 
end Z_c;

architecture behavior of Z_c is
	--Contadores de clk y acumulación de Spikes--
	signal cont_clk: integer := 0;
	signal cont_c1: integer := 0;
	signal cont_c2: integer := 0;
	signal cont_c3: integer := 0;
	signal cont_n: std_logic := '0';
	signal suma: std_logic := '0';
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
		
		--Señal auxiliar para disparar los spikes de colores--
		process (clk)
		begin
			if(clk'event and clk ='1' and en = '1') then
				if(in_n = '1') then
					aux <= '1';
				end if;
				--Vuelta a condiciones inicales--
				if(cont_c1 = 0 and cont_c2 = 0 and cont_c3 = 0) then
					aux <= '0';
				end if;
			end if;
		end process;
		
		--Señal de spike de color 1--
		process (clk)
		begin
			if(clk'event and clk ='1' and en = '1') then
				if(in_c1 = '1' and aux = '0') then
					cont_c1 <= cont_c1 + 1;
				--Disparo de spike de color 2 si se acumulan 10--
				elsif(aux = '1' and cont_c1 > 9) then
					cont_c1 <= cont_c1 - 10;
				--Disparo de spikes de color 1--
				elsif(aux = '1' and cont_c1 /= 0) then
					cont_c1 <= cont_c1 - 1;
				end if;	
			end if;
		end process;
		
		--Señal de spike de color 2--
		process (clk)
		begin
			if(clk'event and clk ='1' and en = '1') then
				if(in_c2 = '1' and aux = '0') then
					cont_c2 <= cont_c2 + 1;
				--Disparo de spikes de color 2--
				elsif(aux = '1' and cont_c2 > 0) then
					cont_c2 <= cont_c2 - 1;
				end if;
			end if;
		end process;
		
		--Señal de spike de color 3--
		process (clk)
		begin
			if(clk'event and clk ='1' and en = '1') then
				if(in_c3 = '1' and aux = '0') then
					cont_c3 <= cont_c3 + 1;
				--Disparo de spikes de color 3--
				elsif(aux = '1' and cont_c3 > 0) then
					cont_c3 <= cont_c3 - 1;
				end if;
			end if;
		end process;
		
		--Señal de spike normal--
		process (clk)
		begin
			if(clk'event and clk ='1' and en = '1') then
					--Disparo de spike normal--
				if(aux = '1' and cont_n = '1') then
					cont_n <= '0';
				--Vuelta a condiciones iniciales--
				elsif(cont_c1 = 0 and cont_c2 = 0 and cont_c3 = 0) then
					cont_n <= '1';
				end if;
			end if;
		end process;
		
		out_c2a <= '1' when(aux = '1' and cont_c1 > 9) else '0';
		out_c1 <= '1' when(aux = '1' and cont_c1 > 0 and cont_c1 < 10) else '0';
		out_c2 <= '1' when(aux = '1' and cont_c2 > 0) else '0';
		out_c3 <= '1' when(aux = '1' and cont_c3 > 0) else '0';	
		out_n <= '1' when(aux = '1' and cont_n = '1') else '0';
		
end behavior;