library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
 
entity AMB_t is
 port(en_At: in std_logic;
	clk_At: in std_logic;
	
	in_n1_1: in integer;
	in_n2_1: in integer;
	in_n3_1: in integer;
	
	in_n1_2: in integer;
	in_n2_2: in integer;
	in_n3_2: in integer;
	
	in_n_t: in std_logic;
	
	in_suma_t: in std_logic;
	
	out_c1_t: out std_logic := '0';
	out_c2_t: out std_logic := '0';
	out_c3_t: out std_logic := '0';
	out_sp_t: out std_logic := '0';
	out_sn_t: out std_logic := '0'
	); 
end AMB_t;
  
architecture behavior of AMB_t is

	--Declaración del circuito de ambiente--
	
	--Circuito de ambiente--
	component AMB is
		port (en_A: in std_logic;
			clk_A: in std_logic;
			
			in_sc1: in integer;
			in_sc2: in integer;
			in_sc3: in integer;
			
			in_rc1: in integer;
			in_rc2: in integer;
			in_rc3: in integer;
			
			in_n: in std_logic;
			
			in_suma: in std_logic;
			
			out_c1: out std_logic := '0';
			out_c2: out std_logic := '0';
			out_c3: out std_logic := '0';
			out_sp: out std_logic := '0';
			out_sn: out std_logic := '0'
			); 
	end component;
	
	--Señal de conteo de clk--
	signal cont_clk: integer := 0;
	
	begin
	
	AMB_total: AMB port map(en_A => en_At, clk_A => clk_At,
					in_sc1 => in_n1_1, in_sc2 => in_n2_1, in_sc3 => in_n3_1,
					in_rc1 => in_n1_2, in_rc2 => in_n2_2, in_rc3 => in_n3_2,
					in_n => in_n_t, in_suma => in_suma_t,
					out_c1 => out_c1_t, out_c2 => out_c2_t, out_c3 => out_c3_t,
					out_sp => out_sp_t, out_sn => out_sn_t);
	
	process (clk_At)
			begin
				if(clk_At'event and clk_At ='1' and en_At = '1') then 
					cont_clk  <= cont_clk + 1;
				end if;
	end process;

end behavior;