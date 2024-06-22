library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity D_r7 is port
	(
	en: in std_logic;
	clk: in std_logic;
	in_1: in std_logic;
	
	--Salidas de Spikes--
	out_1: out std_logic := '0'
	); 
end D_r7;

architecture behavior of D_r7 is
	--Contadores de clk y acumulación de Spikes--
	signal cont_clk: integer := 0;
	signal retard: std_logic_vector(7 downto 0) := (others => '0');
	
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
				retard(7 downto 1) <= retard(6 downto 0);
				--Entrada del spike al retardo dendrítico--
				retard(0) <= in_1;
			end if;
		end process;
		
		--Salida del retardo dendrítico--
		out_1 <= retard(7);
end behavior;