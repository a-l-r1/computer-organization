## 控制

### 功能

控制是指通过识别指令，控制数据的流通，从而让 CPU 执行指定的计算的过程。数据通路只是得到了数据可能的流向，真正要控制还是控制完成。控制通过已有的控制信号和数据通路的分叉完成控制。

### 分析

通过对数据通路的分析，可以得到每条指令需要的控制信号如下。

指令 | `addu` | `subu` | `lui` | `ori` 
`dm_rf_write_addr` | `im.data[15:11]` | `im.data[15:11]` | `im.data[20:16]` | `im.data[20:16]` 
`dm_rf_write_data` | `im.data[15:11]` | `im.data[15:11]` | `alu.result` | `alu.result` 
`dm_alu_num2` | `rf.read_result2` | `rf.read_result2` | `ext.result` | `ext.result` 
`npc.jump_mode` | `NPC_JUMP_DISABLED` | `NPC_JUMP_DISABLED` | `NPC_JUMP_DISABLED` | `NPC_JUMP_DISABLED` 
`pc.enable` | `PC_ENABLED` | `PC_ENABLED` | `PC_ENABLED` | `PC_ENABLED` 
`im.enable` | `IM_ENABLED` | `IM_ENABLED` | `IM_ENABLED` | `IM_ENABLED` 
`rf.write_enable` | `RF_WRITE_ENABLED` | `RF_WRITE_ENABLED` | `RF_WRITE_ENABLED` | `RF_WRITE_ENABLED` 
`alu.op` | `ALU_ADD` | `ALU_SUB` | `ALU_OR` | `ALU_OR` 
`ext.mode` | | | `EXT_MODE_PAD` | `EXT_MODE_UNSIGNED` 
`dm.write_enable` | `DM_WRITE_DISABLED` | `DM_WRITE_DISABLED` | `DM_WRITE_DISABLED` | `DM_WRITE_DISABLED` 

指令 | `lw` | `sw` | `beq` | `nop` 
`dm_rf_write_addr` | 
`dm_rf_write_data` | 
`dm_alu_num2` | 
`npc.jump_mode` | 
`pc.enable` | 
`im.enable` | 
`rf.write_enable` | 
`alu.op` | 
`ext.mode` | 
`dm.write_enable` | 


