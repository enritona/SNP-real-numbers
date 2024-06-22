library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
 
entity AMB is
 port(en_A: in std_logic;
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
end AMB;
  
architecture behavior of AMB is

	--Declaración de componentes del ambiente--
	
	--Conversor decimal a spike--
	component Conv is
		port (en: in std_logic;
			clk: in std_logic;
			in_d: in integer;
	
			--Salidas de Spikes--
			out_s: out std_logic := '0'
			); 
	end component;
	
	--Retardo dentrítico 1 tiempo--
	component D_r1 is
		port (en: in std_logic;
			clk: in std_logic;
			in_1: in std_logic;
	
			--Salidas de Spikes--
			out_1: out std_logic := '0'
			);
	end component;
	
	--Retardo dentrítico 9 tiempos--
	component D_r9 is
		port (en: in std_logic;
			clk: in std_logic;
			in_1: in std_logic;
	
			--Salidas de Spikes--
			out_1: out std_logic := '0'
			);
	end component;
	
	--Retardo dentrítico 8 tiempos--
	component D_r8 is
		port (en: in std_logic;
			clk: in std_logic;
			in_1: in std_logic;
	
			--Salidas de Spikes--
			out_1: out std_logic := '0'
			);
	end component;
	
	--Retardo dentrítico 6 tiempos--
	component D_r6 is
		port (en: in std_logic;
			clk: in std_logic;
			in_1: in std_logic;
	
			--Salidas de Spikes--
			out_1: out std_logic := '0'
			);
	end component;
	
	--Retardo dentrítico 7 tiempos--
	component D_r7 is
		port (en: in std_logic;
			clk: in std_logic;
			in_1: in std_logic;
	
			--Salidas de Spikes--
			out_1: out std_logic := '0'
			);
	end component;
	
	--Retardo dentrítico 2 tiempos--
	component D_r2 is
		port (en: in std_logic;
			clk: in std_logic;
			in_1: in std_logic;
	
			--Salidas de Spikes--
			out_1: out std_logic := '0'
			);
	end component;
	
	--Retardo dentrítico 10 tiempos--
	component D_r10 is
		port (en: in std_logic;
			clk: in std_logic;
			in_1: in std_logic;
	
			--Salidas de Spikes--
			out_1: out std_logic := '0'
			);
	end component;
	
	--Retardo dentrítico 11 tiempos--
	component D_r11 is
		port (en: in std_logic;
			clk: in std_logic;
			in_1: in std_logic;
	
			--Salidas de Spikes--
			out_1: out std_logic := '0'
			);
	end component;
	
	--Retardo dentrítico 25 tiempos--
	component D_r25 is
		port (en: in std_logic;
			clk: in std_logic;
			in_1: in std_logic;
	
			--Salidas de Spikes--
			out_1: out std_logic := '0'
			);
	end component;
	
	--Neurona Z_a--
	component Z_a is
		port (en: in std_logic;
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
	end component;
	
	--Neurona Z_c--
	component Z_c is
		port (en: in std_logic;
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
	end component;
	
	--Neurona Z_Su--
	component Z_Su is
		port (en: in std_logic;
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
	end component;
	
	--Neurona Z_Sd--
	component Z_Sd is
		port (en: in std_logic;
			clk: in std_logic;
			in_c2: in std_logic;
			in_Zc_c2_1: in std_logic;
			in_Zc_c2_2: in std_logic;
			in_ZSu_c2: in std_logic;
			in_n: in std_logic;
			in_r: in std_logic;
			
			--Salidas de Spikes de colores--
			out_c3_1: out std_logic := '0';
			out_c3_2: out std_logic := '0';
			out_n: out std_logic := '0'
			);
	end component;
	
	--Nuerona Z_Sc--
	component Z_Sc is
		port (en: in std_logic;
			clk: in std_logic;
			in_c3: in std_logic;
			in_Zc_c3: in std_logic;
			in_ZSd_c3: in std_logic;
			in_n: in std_logic;
			in_r: in std_logic;
			
			in_sum: in std_logic;
			
			--Salidas de Spikes de colores--
			out_n: out std_logic := '0';
			out_r: out std_logic := '0'
			);
	end component;
	
	--Neurona Z_cx--
	component Z_cx is
		port(en: in std_logic;
			clk: in std_logic;
			
			in_n: in std_logic;
			
			--Salidas de Spikes de colores--

			out_n: out std_logic := '0';
			out_ps: out std_logic := '0';
			out_ng: out std_logic := '0'
			);
	end component;
	
	--Neurona Z_Sa--
	component Z_Sa is
		port(en: in std_logic;
			clk: in std_logic;
			in_c1: in std_logic;
			in_c2: in std_logic;
			in_c3: in std_logic;
			in_Zc_c1: in std_logic;
			in_Zc_c2_1: in std_logic;
			in_Zc_c2_2: in std_logic;
			in_Zc_c3: in std_logic;
			in_n: in std_logic;
			
			--Salidas de Spikes de colores--
			out_c1: out std_logic := '0';
			out_c2: out std_logic := '0';
			out_c3: out std_logic := '0';
			out_n: out std_logic := '0'
			);
	end component;
	
	--Neurona Z_St--
	component Z_St is
		port(en: in std_logic;
			clk: in std_logic;
			
			in_a1_c1: in std_logic;
			in_a1_c2: in std_logic;
			in_a1_c3: in std_logic;
			in_a1_n: in std_logic;
			
			in_a2_c2: in std_logic;
			in_a2_c3: in std_logic;
			in_a2_n: in std_logic;
			
			in_cx_n: in std_logic;
			
			--Salidas de Spikes de colores--
			out_ps_c1: out std_logic := '0';
			out_ps_c2: out std_logic := '0';
			out_ps_c3: out std_logic := '0';
			out_ps: out std_logic := '0';
			
			out_ng_c1: out std_logic := '0';
			out_ng_c2: out std_logic := '0';
			out_ng_c3: out std_logic := '0';
			out_n: out std_logic := '0'
			);
	end component;
	
	--Astrocito--
	component Astro is
		port (en: in std_logic;
			clk: in std_logic;
			in_1: in std_logic;
			in_1_aux: in std_logic;
			in_2: in std_logic;
			
			--Salidas de Spikes--
			out_1: out std_logic := '0'
			); 
	end component;
  
  --Señales auxiliares para las neuronas--
  
  --Conversión decimal a spike--
  signal s_c1: std_logic := '0';
  signal s_c2: std_logic := '0';
  signal s_c3: std_logic := '0';
  
  signal r_c1: std_logic := '0';
  signal r_c2: std_logic := '0';
  signal r_c3: std_logic := '0';
  
  --Retardo de Feedback--
  signal Rr_c1: std_logic := '0';
  signal Rr_c2: std_logic := '0';
  signal Rr_c3: std_logic := '0';
  
  --Retardo spike normal de Z_a--
  signal RZa_n: std_logic := '0';
  
  --Retardo spike normal de Z_c--
  signal RZc_n: std_logic := '0';
  
  --Retardo sipke normal de Z_Sa--
  signal RZSa_n: std_logic := '0';
  
  --Retardo spike normal de Z_Sc--
  signal RZSc_n: std_logic := '0';
  
   --Retardo spike reset de Z_Sc--
  signal RZSc_r: std_logic := '0';
  
  --Retardo de spike normal a Z_cx--
  signal RZcx_n: std_logic := '0';
  
  --Retardo spike de colores de Z_St--
  signal RZSt_c1: std_logic := '0';
  signal RZSt_c2: std_logic := '0';
  signal RZSt_c3: std_logic := '0';
  
  --Retardo de spikes de salida de Z_cx--
  signal RRZcx_ps: std_logic := '0';
  signal RRZcx_n: std_logic := '0';
  
  --Salidas neurona Z_a--
  signal Za_c1: std_logic := '0';
  signal Za_c2: std_logic := '0';
  signal Za_c3: std_logic := '0';
  signal Za_n: std_logic := '0';
  
  --Salida neurona Z_c--
  signal Zc_c1: std_logic := '0';
  signal Zc_c2a: std_logic := '0';
  signal Zc_c2: std_logic := '0';
  signal Zc_c3: std_logic := '0';
  signal Zc_n: std_logic := '0';
  
  --Salida neurona Z_Sa--
  signal ZSa_c1: std_logic := '0';
  signal ZSa_c2: std_logic := '0';
  signal ZSa_c3: std_logic := '0';
  signal ZSa_n: std_logic := '0';
  
  --Salida neurona Z_Su--
  signal ZSu_c2_1: std_logic := '0';
  signal ZSu_c2_2: std_logic := '0';
  signal ZSu_n: std_logic := '0';
  
  --Salida neurona Z_Sd--
  signal ZSd_c3_1: std_logic := '0';
  signal ZSd_c3_2: std_logic := '0';
  signal ZSd_n: std_logic := '0';
  
  --Salida neurona Z_Sc--
  signal ZSc_n: std_logic := '0';
  signal ZSc_r: std_logic := '0';
  
  --Salida neurona Z_St--
  signal ZSt_c1_ng: std_logic := '0';
  signal ZSt_c2_ng: std_logic := '0';
  signal ZSt_c3_ng: std_logic := '0';
  signal ZSt_n_ng: std_logic := '0';
  signal ZSt_sp_aux: std_logic := '0';
  
  --Salida neurona Z_cx--
  signal ZScx_n: std_logic := '0';
  Signal ZScx_ps: std_logic := '0';
  signal ZScx_ng: std_logic := '0';
  
  --Salida de astrocitos de feedback--
  signal A1_c1: std_logic := '0';
  signal A1_c2: std_logic := '0';
  signal A1_c3: std_logic := '0';
  
  --Salida de astrocitos de feedback ng--
  signal A2_c1: std_logic := '0';
  signal A2_c2: std_logic := '0';
  signal A2_c3: std_logic := '0';

  --Señal de conteo de clk--
  signal cont_clk: integer := 0;
  
 begin
	--Conexión de entradas y neuronas--
	
	--Conversión de SetPoint-
	Sc1: Conv port map(en => en_A, clk => clk_A,
			in_d => in_sc1, out_s => s_c1);
	Sc2: Conv port map(en => en_A, clk => clk_A,
			in_d => in_sc2, out_s => s_c2);
	Sc3: Conv port map(en => en_A, clk => clk_A,
			in_d => in_sc3, out_s => s_c3);	
	
	--Conversión de Feedback--
	Rc1: Conv port map(en => en_A, clk => clk_A,
			in_d => in_rc1, out_s => r_c1);
	Rc2: Conv port map(en => en_A, clk => clk_A,
			in_d => in_rc2, out_s => r_c2);
	Rc3: Conv port map(en => en_A, clk => clk_A,
			in_d => in_rc3, out_s => r_c3);
	
	--Retardo de Feedback--
	RRc1: D_r1 port map(en => en_A, clk => clk_A,
			in_1 => r_c1, out_1 => Rr_c1);
	RRc2: D_r1 port map(en => en_A, clk => clk_A,
			in_1 => r_c2, out_1 => Rr_c2);
	RRc3: D_r1 port map(en => en_A, clk => clk_A,
			in_1 => r_c3, out_1 => Rr_c3);
			
	--Retardos de spikes de colores ZSt--
	RRZSt_c1: D_r2 port map(en => en_A, clk => clk_A,
			in_1 => ZSt_c1_ng, out_1 => RZSt_c1);
	RRZSt_c2: D_r2 port map(en => en_A, clk => clk_A,
			in_1 => ZSt_c2_ng, out_1 => RZSt_c2);
	RRZSt_c3: D_r2 port map(en => en_A, clk => clk_A,
			in_1 => ZSt_c3_ng, out_1 => RZSt_c3);
	
	--Retardo de spike normal de Z_a--
	RZan: D_r9 port map(en => en_A, clk => clk_A,
						in_1 => Za_n, out_1 => RZa_n);
						
	--Retardo de spike normal de Z_c--
	RZcn: D_r10 port map(en => en_A, clk => clk_A,
						in_1 => Zc_n, out_1 => RZc_n);
	

						
	--Retardo de sipke normal de ZSc--
	RZScn: D_r7 port map(en => en_A, clk => clk_A,
						in_1 => ZSc_n, out_1 => RZSc_n);
	
	--Retardo de sipke reset de ZSc--
	RZScr: D_r9 port map(en => en_A, clk => clk_A,
						in_1 => ZSc_r, out_1 => RZSc_r);
	
	--Retardo de spike normal a Zcx--
	RZcx: D_r25 port map(en => en_A, clk => clk_A,
						in_1 => ZSt_n_ng, out_1 => RZcx_n);
	
	--Retardo de spike normal de Zcx--
	RZcx_n_ng: D_r8 port map(en => en_A, clk => clk_A,
						in_1 => ZScx_n, out_1 => RRZcx_n);
	--Retardo de spike anti-positivo de Zcx--
	RZcx_ps_ng: D_r9 port map(en => en_A, clk => clk_A,
						in_1 => ZScx_ps, out_1 => RRZcx_ps);
	--Retardo de spike negativo de Zcx--
	RZcx_ng_ng: D_r10 port map(en => en_A, clk => clk_A,
						in_1 => ZScx_ng, out_1 => out_sn);
	
	--Neurona Z_a--
	Za: Z_a port map(en => en_A, clk => clk_A,
					in_1 => in_n, in_2 => ZSt_n_ng,
					in_sum => in_suma, out_c1 => Za_c1,
					out_c2 => Za_c2, out_c3 => Za_c3,
					out_1 => Za_n);
	
	--Neurona Z_c--
	Zc: Z_c port map(en => en_A, clk => clk_A,
					in_c1 => A1_c1, in_c2 => A1_c2,
					in_c3 => A1_c3, in_n => RZa_n,
					out_c1 => Zc_c1, out_c2a => Zc_c2a,
					out_c2 => Zc_c2, out_c3 => Zc_c3,
					out_n => Zc_n);
	
	--Neurona Z_Sa--
	ZSa: Z_Sa port map(en => en_A, clk => clk_A,
					in_c1 => s_c1, in_c2 => s_c2, in_c3 => s_c3,
					in_Zc_c1 => Zc_c1, in_Zc_c2_1 => Zc_c2a,
					in_Zc_c2_2 => Zc_c2, in_Zc_c3 => Zc_c3,
					in_n => RZc_n, out_c1 => ZSa_c1,
					out_c2 => ZSa_c2, out_c3 => ZSa_c3,
					out_n => ZSa_n);
	
	--Neurona Z_Su--
	ZSu: Z_Su port map(en => en_A, clk => clk_A,
					in_c1 => s_c1, in_Zc_c1 => Zc_c1, in_n => RZc_n,
					in_r => RZSc_r, out_c2_1 => ZSu_c2_1, out_c2_2 => ZSu_c2_2,
					out_n => ZSu_n);
					
	--Neurona Z_Sd--
	ZSd: Z_Sd port map(en => en_A, clk => clk_A,
					in_c2 => s_c2, in_Zc_c2_1 => Zc_c2, in_Zc_c2_2 => Zc_c2a,
					in_ZSu_c2 => ZSu_c2_2, in_n => ZSu_n, in_r => RZSc_r,
					out_c3_1 => ZSd_c3_1, out_c3_2 => ZSd_c3_2, out_n => ZSd_n);
	
	--Neurona Z_Sc--
	ZSc: Z_Sc port map(en => en_A, clk => clk_A,
					in_c3 => s_c3, in_Zc_c3 => Zc_c3,
					in_ZSd_c3 => ZSd_c3_2, in_n => ZSd_n, in_r => RZSc_r,
					in_sum => in_suma, out_n => ZSc_n, out_r => ZSc_r);
	
	
	
	--Neurona Z_cx--
	Zcx: Z_cx port map(en => en_A, clk => clk_A,
					in_n => RZcx_n, out_n => ZScx_n,
					out_ps => ZScx_ps, out_ng => ZScx_ng);				

	--Astrocitos de feedback--
	Ar_c1_1: Astro port map(en => en_A, clk => clk_A,
					in_1 => Rr_c1, in_1_aux => RZSt_c1, in_2 => Za_c1,
					out_1 => A1_c1);
	Ar_c2_1: Astro port map(en => en_A, clk => clk_A,
					in_1 => Rr_c2, in_1_aux => RZSt_c2, in_2 => Za_c2,
					out_1 => A1_c2);
	Ar_c3_1: Astro port map(en => en_A, clk => clk_A,
					in_1 => Rr_c3, in_1_aux => RZSt_c3, in_2 => Za_c3,
					out_1 => A1_c3);
	
		
	 --Contador de clk--
	 process (clk_A)
			begin
				if(clk_A'event and clk_A ='1' and en_A = '1') then 
					cont_clk  <= cont_clk + 1;
				end if;
	end process;

end behavior;