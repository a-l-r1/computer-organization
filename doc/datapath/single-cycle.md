## 单周期数据通路

### 功能

单周期数据通路是负责单周期处理器的数据通路。由于它只是在一个周期内做完五步操作，所以能简单一些。数据通路是把相应的数据通路部件按照一定的逻辑关系连接起来得到的、

通过对需要实现的每条指令的分析，可以得出每条指令具体需要什么样的数据通路，然后用这个来知道实现。有些数据的流向是需要指定的，这时就需要控制单元出马，在相应的地方放上 MUX，然后让控制单元控制。

### 分析

p4 需要实现的 8 条指令为：

`addu, subu, lui, ori, lw, sw, beq, nop`

通过分析它们的 RTL，可以得到每条指令对应的数据链路连接如下。其中表格某一列的值表示这个输入端口是哪个输出端口的输出。端口用 `部件.端口名字` 格式表示。空白的单元格表示不用关心相对应的端口的值，因为它们会被忽略，不影响指令的正常执行。

最后一行是把所有可能的连接综合起来以后，得到的结果。如果有多个可能的连接，就需要一个 MUX。

指令 | `npc.curr_pc` | `npc.alu_comp_result` | `npc.num` | `pc.next_pc` | `im.addr` | `rf.read_addr1` | `rf.read_addr2` | `rf.write_addr` | `rf.write_data` | `alu.num1` | `alu.num2` | `ext.num` | `dm.read_addr` | `dm.write_addr` | `dm.write_data` 
--- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---
`addu` | `pc.curr_pc` | | | `npc.next_pc` | `pc.curr_pc` | `im.data[25:21]` | `im.data[20:16]` | `im.data[15:11]` | `alu.result` | `rf.read_result1` | `rf.read_result2` | | | |
`subu` | `pc.curr_pc` | | | `npc.next_pc` | `pc.curr_pc` | `im.data[25:21]` | `im.data[20:16]` | `im.data[15:11]` | `alu.result` | `rf.read_result1` | `rf.read_result2` | | | |
`lui` | `pc.curr_pc` | | | `npc.next_pc` | `pc.curr_pc` | `im.data[25:21]` | | `im.data[20:16]` | `alu.result` | `rf.read_result1` | `ext.result` | `im.data[15:0]` | | | |
`ori` | `pc.curr_pc` | | | `npc.next_pc` | `pc.curr_pc` | `im.data[25:21]` | `im.data[20:16]` | `im.data[20:16]` | `alu.result` | `rf.read_result1` | `ext.result` | `im.data[15:0]` | | |
`lw` | `pc.curr_pc` | | | `npc.next_pc` | `pc.curr_pc` | `im.data[25:21]` | | `im.data[20:16]` | `dm.read_result` | `rf.read_result1` | `ext.result` | `im.data[15:0]` | `alu.result` | | | 
`sw` | `pc.curr_pc` | | | `npc.next_pc` | `pc.curr_pc` | `im.data[25:21]` | | `im.data[20:16]` | | `rf.read_result1` | `ext.result` | `im.data[15:0]` | | `alu.result` | `rf.read_result2` 
`beq` | `pc.curr_pc` | `alu.comp_result` | `im.data[15:0]` | `npc.next_pc` | `pc.curr_pc` | `im.data[20:16]` | `im.data[15:11]` | | | `rf.read_result1` | `rf.read_result2` | | | | | 
`nop` | `pc.curr_pc` | | `npc.next_pc` | `pc.curr_pc` | | | | | | | | | | 

 | `addu` | `subu` | `lui` | `ori` | `lw` | `sw` | `beq` | `nop` 
`npc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | 
`npc.alu_comp_result` | | | | | | 
`npc.num` | | | | | | 
`pc.next_pc` | `npc.next_pc` | `npc.next_pc` | `npc.next_pc` | `npc.next_pc` | `npc.next_pc` | 
`im.addr` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | 
`rf.read_addr1` | `im.data[25:21]` | `im.data[25:21]` | `im.data[25:21]` | `im.data[25:21]` | `im.data[25:21]` | 
`rf.read_addr2` | `im.data[20:16]` | `im.data[20:16]` | | `im.data[20:16]` | | 
`rf.write_addr` | `im.data[15:11]` | `im.data[15:11]` | `im.data[20:16]` | `im.data[20:16]` | `im.data[20:16]` | 
`rf.write_data` | `alu.result` | `alu.result` | `alu.result`|  `alu.result` | `dm.read_result` | 
`alu.num1` | `rf.read_result1` | `rf.read_result1` | `rf.read_result1` | `rf.read_result1` | `rf.read_result1` | 
`alu.num2` | `rf.read_result2` | `rf.read_result2` | `ext.result` | `ext.result` | `ext.result` | 
`ext.num` | | | `im.data[15:0]` | `im.data[15:0]` | `im.data[15:0]` | 
`dm.read_addr` | | | | | `alu.result` | 
`dm.write_addr` | | | | | | 
`dm.write_data` | | | | | | 

