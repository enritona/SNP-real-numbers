library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Z_a is port
	(
	en: in std_logic;
	clk: in std_logic;
	in_1: in std_logic;
	in_2: in std_logic;
	
	in_sum: in std_logic;
	
	--Salidas de Spikes de colores--
	out_c1: out std_logic := '0';
	out_c2: out std_logic := '0';
	out_c3: out std_logic := '0';
	out_1: out std_logic := '0'
	); 
end Z_a;

architecture behavior of Z_a is
	--Contadores de clk y acumulación de Spikes--
	signal cont_clk: integer := 0;
	signal cont_c1: integer := 10;
	signal cont_c2: integer := 9;
	signal cont_c3: integer := 9;
	signal cont_n: std_logic := '1';
	signal aux: std_logic := '0';
	signal suma: std_logic := '0';
	signal disp: std_logic_vector(1 downto 0) := (others => '0');
	signal clk_aux: integer := 0;
	
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
				disp(1) <= disp(0);
				disp(0) <= in_1 or in_2;
			end if;
		end process;
		
		--Señal auxiliar para disparar los spikes de colores--
		process (clk)
		begin
			if(clk'event and clk ='1' and en = '1') then
				if(disp(1) = '1' and aux = '0') then
					aux <= '1';
				--Vuelta a condiciones inicales--
				elsif(cont_c1 = 0 and cont_c2 = 0 and cont_c3 = 0) then
					aux <= '0';
				end if;
			end if;
		end process;
		
		--Señal suma para no disparar los spikes de colores--
		process (clk)
		begin
			if(clk'event and clk ='1' and en = '1') then
				if(in_sum = '1') then
					suma <= '1';
				--Vuelta a condiciones inicales--
				elsif(cont_c1 = 0 and cont_c2 = 0 and cont_c3 = 0) then
					suma <= '0';
				end if;
			end if;
		end process;
		
		--Disparo de spikes de color 1--
		process (clk)
		begin
			if(clk'event and clk ='1' and en = '1') then
				if(aux = '1' and cont_c1 > 0) then
					cont_c1 <= cont_c1 - 1;
				--Vuelta a condiciones inicales--
				elsif(cont_c1 = 0 and cont_c2 = 0 and cont_c3 = 0 and aux = '0') then
					cont_c1 <= 10;
				end if;
			end if;
		end process;
		
		--Disparo de spikes de color 2--
		process (clk)
		begin
			if(clk'event and clk ='1' and en = '1') then
				if(aux = '1' and cont_c2 > 0) then
					cont_c2 <= cont_c2 - 1;
				--Vuelta a condiciones inicales--
				elsif(cont_c1 = 0 and cont_c2 = 0 and cont_c3 = 0 and aux = '0') then
					cont_c2 <= 9;
				end if;
			end if;
		end process;
		
		--Disparo de spikes de color 3--
		process (clk)
		begin
			if(clk'event and clk ='1' and en = '1') then
				if(aux = '1' and cont_c3 > 0) then
					cont_c3 <= cont_c3 - 1;
				elsif(cont_c1 = 0 and cont_c2 = 0 and cont_c3 = 0 and aux = '0') then
					cont_c3 <= 9;
				end if;
			end if;
		end process;
		
		--Disparo de spike normal--
		process (clk)
		begin
			if(clk'event and clk ='1' and en = '1') then
				if(aux = '1' and cont_n = '1') then
					cont_n <= '0';
				--Vuelta a condiciones inicales--
				elsif(cont_c1 = 0 and cont_c2 = 0 and cont_c3 = 0 and aux = '0') then
					cont_n <= '1';
				end if;
			end if;
		end process;
		
		out_c1 <= '1' when((aux = '1' and cont_c1 > 0) and suma = '0') else '0';
		out_c2 <= '1' when((aux = '1' and cont_c2 > 0) and suma = '0') else '0';
		out_c3 <= '1' when((aux = '1' and cont_c3 > 0) and suma = '0') else '0';
		out_1 <= '1' when(aux = '1' and cont_n = '1') else '0';
		
end behavior;