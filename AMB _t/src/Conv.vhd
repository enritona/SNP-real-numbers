library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Conv is port
	(
	en: in std_logic;
	clk: in std_logic;
	in_d: in integer;
	
	--Salidas de Spikes--
	out_s: out std_logic := '0'
	); 
end Conv;

architecture behavior of Conv is
	--Contadores de clk y acumulación de Spikes--
	signal cont_clk: integer := 0;
	signal cont_aux: integer := 0;
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
				--Corrimeinto del retardo dentrítico--
				if (in_d > 0 and aux = '0') then
					cont_aux <= in_d;
				elsif (cont_aux > 0 and aux = '1') then
					cont_aux <= cont_aux - 1;
				end if;
			end if;
		end process;
		
		--Señal auxiliar para disparar los spikes de colores--
		process (clk)
		begin
			if(clk'event and clk ='1' and en = '1') then
				if (in_d > 0 and aux = '0') then
					aux <= '1';
				elsif (cont_aux = 0 and aux = '1') then
					aux <= '0';
				end if;
			end if;
		end process;
		
		--Salida del retardo dendrítico--
		out_s <= '1' when (cont_aux > 0) else '0';
end behavior;