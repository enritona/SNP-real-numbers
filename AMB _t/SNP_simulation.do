vsim -t ns work.tb_AMB_t(behavior_tb)
vsim -t ns -voptargs=+acc work.tb_AMB_t(behavior_tb) 
 set IgnoreWarning 1 
 
  add wave -divider ff
  add wave -u /tb_AMB_t/t_circuit/*
  
 run  700000 ns

