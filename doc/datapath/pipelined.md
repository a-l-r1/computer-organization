## 流水线 CPU 数据通路

### 原理

流水线技术是通过指令级并行，缩短每级的执行时间从而提高频率的技术。这样可以让关键路径缩短，从而提升频率，因此提高了执行效率。

流水线要注意会出现冒险问题，因此会有暂停和转发机制。暂停和转发实际上是控制的内容，数据通路只需要留出需要的部件即可。

### 分析

p5 需要实现的指令为：

`addu, subu, lui, ori, lw, sw, beq, nop, j, jal, jr, movz`

由于不同指令的数据通路可以归类，因此首先需要对数据通路进行分类，之后再对每类数据通路总结连接。数据通路分类表如下。

数据通路类型 | 指令
--- | ---
`UNKNOWN` | （未知指令）
`CAL_R` | `addu, subu`
`CAL_I` | `lui, ori`
`LOAD` | `lw`
`STORE` | `sw`
`BRANCH` | `beq`
`NOP` | `nop`
`JAL` | `j, jal`
`JR` | `jr`
`CMOV` | `movz`

通过分析它们的 RTL，可以得到每条指令对应的数据通路连接如下。其中表格某一列的值表示这个输入端口是哪个输出端口的输出。端口用 `流水线级: 部件.端口名字` 格式表示。空白的单元格表示不用关心相对应的端口的值，因为它们会被忽略，不影响指令的正常执行。未知指令只需要屏蔽各个写入的使能，这样就可以避免未知指令的影响，因此不用分析未知指令。

有时部件名称可能和级不对应。这表示相应端口的值是经过流水后的结果。

由于指令分析函数可以分析到指令读写的寄存器，因此把 D 级和 E 级的三个寄存器地址端口交给控制模块控制。这样也能避免在不该写寄存器的指令写寄存器，因为哪怕寄存器写入使能打开，要写入的寄存器也是 `ZERO`。

**注意：使用延迟槽来简化暂停和转发的分析。**

#### F 级（IF）

数据通路类型 | `F: npc.curr_pc` | `F: npc.alu_comp_result` | `F: npc.num` | `F: npc.jnum` | `F: npc.reg_` | `F: pc.next_pc`
--- | --- | --- | ---
`BRANCH` | `F: pc.curr_pc` | `E: alu.comp_result` | `D: im.result[15:0]` | | | `F: npc.next_pc`
`JAL` | `F: pc.curr_pc` | | | `D: im.result[25:0]` | | `F: npc.next_pc`
`JR` | `F: pc.curr_pc` | | | | `D: rf.read_result1` | `F: npc.next_pc`
（其它）| `F: pc.curr_pc` | | | | | `F: npc.next_pc`
综合 | `F: pc.curr_pc` | `D: cmp.cmp` | `D: im.result[15:0]` | `D: im.result[25:0]` | `D: rf.read_result1` | `F: npc.next_pc`

#### D 级（ID）

数据通路类型 | `D: ext.num` | `D: cmp.reg1` | `D: cmp.reg2`
`CAL_R` | | |
`CAL_I` | `D: im.result[15:0]` | |
`LOAD` | `D: im.result[15:0]` | |
`STORE` | | |
`BRANCH` | | `D: rf.read_result1` | `D: rf.read_result2`
`NOP` | | |
`JAL` | | |
`JR` | | |
`CMOV` | | `D: rf.read_result2`
综合 | `D: im.result[15:0]` | `D: rf.read_result1` | `D: rf.read_result2`

#### E 级（EX）

数据通路类型 | `E: alu.num1` | `E: alu.num2`
`CAL_R` | `D: rf.read_result1` | `D: rf.read_result2`
`CAL_I` | `D: rf.read_result1` | `D: ext.result` 
`LOAD` | `D: rf.read_result1` | `D: ext.result`
`STORE` | `D: rf.read_result1` | `D: ext.result`
`BRANCH` | | 
`NOP` | | 
`JAL` | | 
`JR` | | 
`CMOV` | `D: rf.read_result1` | `D: rf.read_result2`
综合 | `D: rf.read_result1` | `D: rf.read_result2, D: ext.result`

#### M 级（MEM）

数据通路类型 | `M: dm.read_addr` | `M: dm.write_addr` | `M: dm.write_data`
`CAL_R` | | | 
`CAL_I` | | | 
`LOAD` | `E: alu.result` | | | 
`STORE` | | `E: alu.result` | `E: rf.read_result2`
`BRANCH` | | | 
`NOP` | | | 
`JAL` | | | 
`JR` | | | 
`CMOV` | | | 
综合 | `E: alu.result` | `E: alu.result` | `E: rf.read_result2`

#### W 级（WB）

数据通路类型 | `W: rf.write_data`
`CAL_R` | `E: alu.result`
`CAL_I` | `E: alu.result`
`LOAD` | `M: dm.read_result`
`STORE` | 
`BRANCH` |  
`NOP` | 
`JAL` | `F: $unsigned(pc.curr_pc) + $unsigned(8)`
`JR` | 
`CMOV` | `E: alu.result`
综合 | `E: alu.result, M: dm.read_result, F: $unsigned(pc.curr_pc) + $unsigned(8)`

#### 流水线寄存器

由于流水线需要保存每一级流水线的执行结果，所以需要流水线寄存器。需要保存的执行结果，可以从上面数据通路表格中综合出来。为了方便和上面的表格对应，每一级流水线的流水线寄存器都保存上一级流水线的数据。

流水线级 | 信号 | 流水线寄存器名称
--- | --- | ---
D | `im.result` | `d_im`
E | `rf.read_result1` | `e_reg1`
E | `rf.read_result2` | `e_reg2`
E | `ext.result` | `e_ext`
M | `alu.result` | `m_alu`
M | `rf.read_result2` | `m_reg2`
W | `alu.result` | `w_alu`
W | `dm.read_result` | `w_dm`
W | `pc.curr_pc` | `w_pc`

由于需要的流水线寄存器有跨级的（比如只有 D 级和 W 级），所以需要把漏掉的级补充上。

流水线级 | 信号 | 流水线寄存器名称
--- | --- | ---
D | `pc.curr_pc` | `d_pc`
E | `pc.curr_pc` | `e_pc`
M | `pc.curr_pc` | `m_pc`

这里没有补充 D 级 `BRANCH` 类指令需要的 `alu.comp_result` 到 F 级的连接以及 `JAL` 和 `JR` 类指令相应数据到 F 级的连接，因为为了正确控制 PC 的转换，它们必须是实时的，不需要流水线寄存器。

注意：**返回 `PC + 8` 实际上是通过流水 `PC` 再加 8 实现的。**

注意：**D 级流水线寄存器都要接使能信号，E 级流水线寄存器都要接复位信号，因为要插入气泡。**

### 调试相关功能

为了能够正确地打印出写入寄存器和 `dm` 时需要的 `pc` 值，需要流水 `pc.curr_pc`，一直到 W 级。因此，可能需要新增流水线寄存器，并把相应的 `pc` 值流水。

注意：**写入寄存器是使用 `w` 级流水到的 `pc` 值。**

#### 数据通路 MUX

最后是把所有可能的连接综合起来以后，得到的结果。如果有多个可能的连接，就需要一个 MUX。把 MUX 的输出端口连接在相应的输入端口上，MUX 的输入端口要保证所有可能的输入端口都能连接上。

端口 | 所有的信号来源 | MUX 名称
--- | --- | ---
`E: alu.num2` | `D: rf.read_result2, D: ext.result` | `m_alusrc`
`W: rf.write_data` | `（无）, E: alu.result, M: dm.read_result, D: npc.next_pc` | `m_regdata`

注意：**都是把信号来源从 0 开始编号，对应 MUX 的 `input`_n_ 接第 _n_ 个信号源。**

注意：**如果写了（无），那么相应端口的数据为全 0，不过这时相应端口实际上也没有作用。**

#### 转发

需要转发是因为可能出现后面的指令需要使用前面的指令的结果，而前面的指令结果来不及写回（数据冒险）的情况。由于同一个时钟周期只有一条指令读写 `dm`，所以 `dm` 不需要转发。但是 `rf` 在同一个时钟周期内一般会有多条指令读写，所以 `rf` 需要转发。

转发的原则就是比较新的指令需要读的寄存器和比较老的指令需要写的寄存器一样。对这个条件的判断，在指令识别函数中已经有了。注意一条指令最多读 2 个寄存器，所以要判断 2 次。

转发是通过转发 MUX 来更改数据通路上寄存器的值，从而达到提前更新的目的。首先，数据通路上有寄存器值的地方，一共有五处：`D: rf.read_result1, D: rf.read_result2, E: rf.read_result1, E: rf.read_result2, M: dm.write_data`。其中 E 级的两处是通过流水线寄存器暂存的。这五处可以分三类。对每类需要构造的转发 MUX 总结如下。

端口 | 所有的信号来源 | MUX 名称
--- | --- | ---
`D: rf.read_result[12]` | `E: rf.read_result1, E: npc.next_pc, M: npc.next_pc, M: alu.result, W: rf.write_data` | `fm_d1`
`E: rf.read_result[12]` | `M: npc.next_pc, M: alu.result, W: rf.write_data` | `fm_e1`
`M: dm.write_data` | `W: rf.write_data` | `fm_m`

**注意：不能在 M 级设置 MUX 转发 `dm` 的数据，因为这样 D 级或 E 级会等待 M 级 `dm` 的数据，关键路径会变得非常长，极大地降低流水线性能。同样地，也不能在 E 级设置 MUX 转发 `alu` 的数据。**

转发 MUX 最终是由控制模块控制的。但是控制模块也没法克服有些数据通路不能转发的现实（比如 `M: dm.read_result`）。这就需要——

#### 暂停

需要暂停是因为有些数据冒险靠转发解决不了，必须要让后面的指令暂停一个时钟周期。暂停的方式是在流水线中插入一个 NOP（这时候也叫气泡），从而让发生数据冒险的指令能够转发。

流水线 CPU 数据通路中能提供的暂停机制有锁定 `pc` 和清空 E 级各个流水线寄存器。这样就可以在流水线 E 级插入气泡。清空 E 级各个寄存器是通过流水线寄存器的同步复位功能实现的。

