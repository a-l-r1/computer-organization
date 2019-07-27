## 控制

### 功能

控制是指通过识别指令，控制数据的流通，从而让 CPU 执行指定的计算的过程。数据通路只是得到了数据可能的流向，真正要控制还是控制完成。控制通过已有的控制信号和数据通路的分叉完成控制。

### 分析

通过对数据通路的分析，可以得到每条指令需要的控制信号如下。其中表格某一单元格的值有两种情况：若该单元格所在的行最左边的单元格是 MUX，则说明对应的指令需要让该 MUX 的输入端口接入该单元格表示的端口；若该单元格所在的行最左边的单元格是端口，则说明对应的指令需要的控制信号为该单元格表示的控制信号。

若单元格以 `#` 开头，则说明该控制信号或端口只是为了使控制单元功能明晰而加上的，实际上并不需要关心该控制信号或要接入的端口的值。如果想理解该单元格的值，去掉 `#` 再按照上一段理解即可。

指令 | `addu` | `subu` | `lui` | `ori` 
--- | --- | --- | --- | ---
`m_rf_write_addr` | `im.data[15:11]` | `im.data[15:11]` | `im.data[20:16]` | `im.data[20:16]` 
`m_rf_write_data` | `alu.result` | `alu.result` | `alu.result` | `alu.result` 
`m_alu_num2` | `rf.read_result2` | `rf.read_result2` | `ext.result` | `ext.result` 
`npc.jump_mode` | `NPC_JUMP_DISABLED` | `NPC_JUMP_DISABLED` | `NPC_JUMP_DISABLED` | `NPC_JUMP_DISABLED` 
`pc.enable` | `PC_ENABLED` | `PC_ENABLED` | `PC_ENABLED` | `PC_ENABLED` 
`im.enable` | `IM_ENABLED` | `IM_ENABLED` | `IM_ENABLED` | `IM_ENABLED` 
`rf.write_enable` | `RF_WRITE_ENABLED` | `RF_WRITE_ENABLED` | `RF_WRITE_ENABLED` | `RF_WRITE_ENABLED` 
`alu.op` | `ALU_ADD` | `ALU_SUB` | `ALU_OR` | `ALU_OR` 
`ext.mode` | `#EXT_MODE_UNSIGNED` | `#EXT_MODE_UNSIGNED` | `EXT_MODE_PAD` | `EXT_MODE_UNSIGNED` 
`dm.write_enable` | `DM_WRITE_DISABLED` | `DM_WRITE_DISABLED` | `DM_WRITE_DISABLED` | `DM_WRITE_DISABLED` 

指令 | `lw` | `sw` | `beq` | `nop` 
--- | --- | --- | --- | ---
`m_rf_write_addr` | `im.data[20:16]` | `im.data[20:16]` | `#im.data[20:16]` | `#im.data[20:16]` 
`m_rf_write_data` | `dm.read_result` | `alu.result` | `#alu.result` | `#alu.result` 
`m_alu_num2` | `ext.result` | `ext.result` | `rf.read_result2` | `#rf.read_result2` 
`npc.jump_mode` | `NPC_JUMP_DISABLED` | `NPC_JUMP_DISABLED` | `NPC_JUMP_WHEN_EQUAL` | `NPC_JUMP_DISABLED` 
`pc.enable` | `PC_ENABLED` | `PC_ENABLED` | `PC_ENABLED` | `PC_ENABLED` 
`im.enable` | `IM_ENABLED` | `IM_ENABLED` | `IM_ENABLED` | `IM_ENABLED` 
`rf.write_enable` | `RF_WRITE_ENABLED` | `RF_WRITE_DISABLED` | `RF_WRITE_DISABLED` | `RF_WRITE_DISABLED` 
`alu.op` | `ALU_ADD` | `ALU_ADD` | `#ALU_OR` | `#ALU_OR` 
`ext.mode` | `EXT_MODE_SIGNED` | `EXT_MODE_SIGNED` | `#EXT_MODE_UNSIGNED` | `#EXT_MODE_UNSIGNED` 
`dm.write_enable` | `DM_WRITE_DISABLED` | `DM_WRITE_ENABLED` | `DM_WRITE_DISABLED` | `DM_WRITE_DISABLED` 

对于未知指令，各控制信号的值与 `nop` 指令的相应值相同。这样相当于直接忽略未知指令。

### 宏定义

类别 | 定义 | 值 | 意义
--- | --- | --- | ---
宏函数 | `GET_OP(x)` | `x[31:26]` | 得到指令的 `op` 字段
宏函数 | `GET_FUNCT(x)` | `x[25:11]` | 得到指令的 `funct` 字段
指令类型 | `R_TYPE` | 2'b00 | R 型指令
指令类型 | `I_TYPE` | 2'b01 | I 型指令
指令类型 | `J_TYPE` | 2'b10 | J 型指令
指令类型 | `C_TYPE` | 2'b11 | 协处理器指令
指令魔数 | `INSTR_MAGIC_RTYPE_OP` | 6'b000000 | R 型指令 `op` 字段魔数
指令魔数 | `INSTR_MAGIC_ADDU_FUNCT` | 6'b100001 | `addu` 指令 `funct` 字段魔数
指令魔数 | `INSTR_MAGIC_SUBU_FUNCT` | 6'b100011 | `subu` 指令 `funct` 字段魔数
指令魔数 | `INSTR_MAGIC_LUI_OP` | 6'b001111 | `lui` 指令 `op` 字段魔数
指令魔数 | `INSTR_MAGIC_ORI_OP` | 6'b001101 | `ori` 指令 `op` 字段魔数
指令魔数 | `INSTR_MAGIC_LW_OP` | 6'b100011 | `lw` 指令 `op` 字段魔数
指令魔数 | `INSTR_MAGIC_SW_OP` | 6'b101011 | `sw` 指令 `op` 字段魔数
指令魔数 | `INSTR_MAGIC_BEQ_OP` | 6'b000100 | `beq` 指令 `op` 字段魔数
指令魔数 | `INSTR_MAGIC_NOP_FUNCT` | 6'b000000 | `nop` 指令 `funct` 字段魔数
指令具体类型 | `INSTR_UNKNOWN` | 8'd0 | 未知指令
指令具体类型 | `INSTR_ADDU` | 8'd1 | `addu` 指令
指令具体类型 | `INSTR_SUBU` | 8'd2 | `subu` 指令
指令具体类型 | `INSTR_LUI` | 8'd3 | `lui` 指令
指令具体类型 | `INSTR_ORI` | 8'd4 | `ori` 指令
指令具体类型 | `INSTR_LW` | 8'd5 | `lw` 指令
指令具体类型 | `INSTR_SW` | 8'd6 | `sw` 指令
指令具体类型 | `INSTR_BEQ` | 8'd7 | `beq` 指令
指令具体类型 | `INSTR_NOP` | 8'd8 | `nop` 指令
`cm_rf_write_addr` | `CM_RF_WRITE_ADDR_IM_DATA_20_16` | 1'b0 | `m_rf_write_addr` 输入来源为 `im.data[20:16]` 
`cm_rf_write_addr` | `CM_RF_WRITE_ADDR_IM_DATA_15_11` | 1'b1 | `m_rf_write_addr` 输入来源为 `im.data[15:11]` 
`cm_rf_write_data` | `CM_RF_WRITE_DATA_ALU_RESULT` | 1'b0 | `m_rf_write_data` 输入来源为 `alu.result` 
`cm_rf_write_data` | `CM_RF_WRITE_DATA_DM_READ_RESULT` | 1'b1 | `m_rf_write_data` 输入来源为 `dm.read_result` 
`cm_alu_num2` | `CM_ALU_NUM2_RF_READ_RESULT2` | 1'b0 | `m_alu_num2` 输入来源为 `rf.read_result2` 
`cm_alu_num2` | `CM_ALU_NUM2_EXT_RESULT` | 1'b1 | `m_alu_num2` 输入来源为 `ext.result` 

### 端口定义

端口 | 类型 | 位宽 | 功能
--- | --- | --- | ---
`curr_instr` | 输入 | 32 | 当前指令
`cm_rf_write_addr` | 输出 | 1 | 控制 `m_rf_write_addr` 
`cm_rf_write_data` | 输出 | 1 | 控制 `m_rf_write_data` 
`cm_alu_num2` | 输出 | 1 | 控制 `m_alu_num2` 
`cw_npc_jump_mode` | 输出 | 1 | 控制 `npc.jump_mode`
`cw_pc_enable` | 输出 | 1 | 控制 `pc.enable` 
`cw_im_enable` | 输出 | 1 | 控制 `im.enable` 
`cw_rf_write_enable` | 输出 | 1 | 控制 `rf.write_enable` 
`cw_alu_op` | 输出 | 1 | 控制 `alu.op` 
`cw_ext_mode` | 输出 | 1 | 控制 `ext.mode` 
`cw_dm_write_enable` | 输出 | 1 | 控制 `dm.write_enable` 

### 功能

由于 `pc.enable` 和 `im.enable` 都是相应的启用值，所以真正实现控制模块的时候，不会控制这两个值，而是把它们都设成对应的常量。

首先，识别指令具体类型。这里只使用一个 8 位的 `wire` 类型变量存放指令类型，而不是多个 `wire` 类型变量，这样其实也是一种类似 `enum` 的做法。识别指令类型主要还是看 `op` 字段，再更细致一点地去看 R 型指令的 `funct` 字段。当然也可以先看指令是否为 R 型指令，但是这样逻辑上有点互相缠绕，所以个人认为识别到具体类型比较好。

然后，识别指令类型。这里主要是为了以后的暂停和转发逻辑做准备，代码中不一定实现（虽然一定有宏定义），利用一个 2 位的 `wire` 类型变量存放指令类型。

最后，做相对应的操作，并输出控制信号。这个识别出指令具体类型以后，按照表格中每个单元格的意义实现即可，主要考虑的是一个判断问题。

### 注意事项

1. 输入整个指令在电路设计中实际上没用，是为了方便 debug
2. 控制信号和最终 CPU 实现中相应的连接数据通路和控制部分的 `wire` 有些名字是重复的，在 Verilog 中语法没错误，没有分开
3. **关于各 MUX 选择哪个输入的宏的值是跟 MUX 接线有关的**
4. **谨慎使用宏函数**

