## 单周期数据通路

### 功能

单周期数据通路是负责单周期处理器的数据通路。由于它只是在一个周期内做完五步操作，所以能简单一些。数据通路是把相应的数据通路部件按照一定的逻辑关系连接起来得到的、

通过对需要实现的每条指令的分析，可以得出每条指令具体需要什么样的数据通路，然后用这个来知道实现。有些数据的流向是需要指定的，这时就需要控制单元出马，在相应的地方放上 MUX，然后让控制单元控制。

### 分析

p4 需要实现的 8 条指令为：

`addu, subu, lui, ori, lw, sw, beq, nop`

通过分析它们的 RTL，可以得到每条指令对应的数据通路连接如下。其中表格某一列的值表示这个输入端口是哪个输出端口的输出。端口用 `部件.端口名字` 格式表示。空白的单元格表示不用关心相对应的端口的值，因为它们会被忽略，不影响指令的正常执行。

最后一行是把所有可能的连接综合起来以后，得到的结果。如果有多个可能的连接，就需要一个 MUX。把 MUX 的输出端口连接在相应的输入端口上，MUX 的输入端口要保证所有可能的输入端口都能连接上。

指令 | `addu` | `subu` | `lui` | `ori` | `lw` | `sw` | `beq` | `nop` | 综合 
--- | --- | --- | --- | --- | --- | --- | --- | --- | --- 
`npc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` 
`npc.alu_comp_result` | | | | | | | `alu.comp_result` | | `alu.comp_result` 
`npc.num` | | | | | | | `im.data[15:0]` | | `im.data[15:0]` 
`pc.next_pc` | `npc.next_pc` | `npc.next_pc` | `npc.next_pc` | `npc.next_pc` | `npc.next_pc` | `npc.next_pc` | `npc.next_pc` | `npc.next_pc` | `npc.next_pc` 
`im.addr` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` | `pc.curr_pc` 
`rf.read_addr1` | `im.data[25:21]` | `im.data[25:21]` | `im.data[25:21]` | `im.data[25:21]` | `im.data[25:21]` | `im.data[25:21]` | `im.data[25:21]` | | `im.data[25:21]` 
`rf.read_addr2` | `im.data[20:16]` | `im.data[20:16]` | | `im.data[20:16]` | | `im.data[20:16]` | `im.data[20:16]` | | `im.data[20:16]` 
`rf.write_addr` | `im.data[15:11]` | `im.data[15:11]` | `im.data[20:16]` | `im.data[20:16]` | `im.data[20:16]` | | | | `im.data[20:16], im.data[15:11]` 
`rf.write_data` | `alu.result` | `alu.result` | `alu.result`|  `alu.result` | `dm.read_result` | | | | `alu.result, dm.read_result`
`alu.num1` | `rf.read_result1` | `rf.read_result1` | `rf.read_result1` | `rf.read_result1` | `rf.read_result1` | `rf.read_result1` | `rf.read_result1` | | `rf.read_result1` 
`alu.num2` | `rf.read_result2` | `rf.read_result2` | `ext.result` | `ext.result` | `ext.result` | `ext.result` | `rf.read_result2` | | `rf.read_result2, ext.result` 
`ext.num` | | | `im.data[15:0]` | `im.data[15:0]` | `im.data[15:0]` | `im.data[15:0]` | | | `im.data[15:0]` 
`dm.read_addr` | | | | | `alu.result` | | | | `alu.result` 
`dm.write_addr` | | | | | | `alu.result` | | | `alu.result` 
`dm.write_data` | | | | | | `rf.read_result2` | | | `rf.read_result2` 

这时可以看出如下的端口需要 MUX:

端口 | 所有的信号来源 | MUX 名称
--- | --- | ---
`rf.write_addr` | `im.data[20:16], im.data[15:11]` | `m_rf_write_addr` 
`rf.write_data` | `alu.result, dm.read_result` | `m_rf_write_data` 
`alu.num2` | `rf.read_result2, ext.result` | `m_alu_num2` 

这些 MUX 最终还是让控制部件来识别。MUX 端口的连接顺序（其实也对应着当控制信号从 0 开始递增时会选择的端口）按照上表中的顺序给定。

