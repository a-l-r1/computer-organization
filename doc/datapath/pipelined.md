## 流水线 CPU 数据通路

### 原理

流水线技术是通过指令级并行，缩短每级的执行时间从而提高频率的技术。这样可以让关键路径缩短，从而提升频率，因此提高了执行效率。

流水线要注意会出现冒险问题，因此会有暂停和转发机制。暂停和转发实际上是控制的内容，数据通路只需要留出需要的部件即可。

### 分析

p5 需要实现的指令为：

`addu, subu, lui, ori, lw, sw, beq, nop`

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

通过分析它们的 RTL，可以得到每条指令对应的数据通路连接如下。其中表格某一列的值表示这个输入端口是哪个输出端口的输出。端口用 `流水线级: 部件.端口名字` 格式表示。空白的单元格表示不用关心相对应的端口的值，因为它们会被忽略，不影响指令的正常执行。未知指令只需要屏蔽各个写入的使能，这样就可以避免未知指令的影响，因此不用分析未知指令。

有时部件名称可能和级不对应。这表示相应端口的值是经过流水后的结果。

由于指令分析函数可以分析到指令读写的寄存器，因此把 D 级和 E 级的三个寄存器地址端口交给控制模块控制。这样也能避免在不该写寄存器的指令写寄存器，因为哪怕寄存器写入使能打开，要写入的寄存器也是 `REG_ZERO`。

**注意：使用延迟槽来简化暂停和转发的分析。**

#### IF

数据通路类型 | `F: npc.curr_pc` | `F: npc.alu_comp_result` | `F: npc.num` | `F: pc.next_pc`
--- | --- | --- | ---
`BRANCH` | `F: pc.curr_pc` | `E: alu.comp_result` | `D: im.result[15:0]` | `F: npc.next_pc`
（其它）| `F: pc.curr_pc` | | | `F: npc.next_pc`
综合 | `F: pc.curr_pc` | `D: comp.result` | `D: im.result[15:0]` | `F: npc.next_pc`

#### D 级（ID）

数据通路类型 | `D: ext.num`
`CAL_R` | 
`CAL_I` | `D: im.result[15:0]`
`LOAD` | `D: im.result[15:0]`
`STORE` | 
`BRANCH` | 
`NOP` | | | | | 
综合 | `D: im.result[15:0]`

#### E 级（EX）

数据通路类型 | `E: alu.num1` | `E: alu.num2`
`CAL_R` | `D: rf.read_result1` | `D: rf.read_result2`
`CAL_I` | `D: rf.read_result1` | `D: ext.result` 
`LOAD` | `D: rf.read_result1` | `D: ext.result`
`STORE` | `D: rf.read_result1` | `D: ext.result`
`BRANCH` | | 
`NOP` | | 
综合 | `D: rf.read_result1` | `D: rf.read_result2, D: ext.result`

#### M 级（MEM）

数据通路类型 | `M: dm.read_addr` | `M: dm.write_addr` | `M: dm.write_data`
`CAL_R` | | | 
`CAL_I` | | | 
`LOAD` | `E: alu.result` | | | 
`STORE` | | `E: alu.result` | `E: rf.read_result2`
`BRANCH` | | | 
`NOP` | | | 
综合 | `E: alu.result` | `E: alu.result` | `E: rf.read_result2`

#### W 级（WB）

数据通路类型 | `W: rf.write_data`
`CAL_R` | `E: alu.result`
`CAL_I` | `E: alu.result`
`LOAD` | `M: dm.read_result`
`STORE` | 
`BRANCH` |  
`NOP` | 
综合 | `E: alu.result, M: dm.read_result`

#### 流水线寄存器

由于流水线需要保存每一级流水线的执行结果，所以需要流水线寄存器。需要保存的执行结果，可以从上面数据通路表格中综合出来。为了方便和上面的表格对应，每一级流水线的流水线寄存器都保存上一级流水线的数据。

流水线级 | 信号 | 流水线寄存器名称
--- | --- | ---
D | `im.result` | `d_im_result`
E | `rf.read_result1` | `e_rf_read_result1`
E | `rf.read_result2` | `e_rf_read_result2`
E | `ext.result` | `e_ext_result`
M | `alu.result` | `m_alu_result`
M | `rf.read_result2` | `m_rf_read_result2`
W | `alu.result` | `w_alu_result`
W | `dm.read_result` | `w_dm_read_result`

由于需要的流水线寄存器没有跨级的（比如只有 D 级和 W 级），所以不需要把漏掉的级补充上。

这里没有补充 E 级 `BRANCH` 类指令需要的 `alu.comp_result` 到 F 级的连接，因为为了正确控制 PC 的转换，它必须是实时的，不需要流水线寄存器。

#### MUX

最后是把所有可能的连接综合起来以后，得到的结果。如果有多个可能的连接，就需要一个 MUX。把 MUX 的输出端口连接在相应的输入端口上，MUX 的输入端口要保证所有可能的输入端口都能连接上。

端口 | 所有的信号来源 | MUX 名称
--- | --- | ---
`E: alu.num2` | `D: rf.read_result2, D: ext.result` | `m_alu_num2`
`W: rf.write_data` | `E: alu.result, M: im.read_result` | `m_rf_write_data`

注意：**都是把信号来源从 0 开始编号，对应 MUX 的 `input`_n_ 接第 _n_ 个信号源。**

#### 转发

需要转发是因为可能出现后面的指令需要使用前面的指令的结果，而前面的指令结果来不及写回（数据冒险）的情况。由于同一个时钟周期只有一条指令读写 `dm`，所以 `dm` 不需要转发。但是 `rf` 在同一个时钟周期内一般会有多条指令读写，所以 `rf` 需要转发。

转发的原则就是比较新的指令需要读的寄存器和比较老的指令需要写的寄存器一样。对这个条件的判断，在指令识别函数中已经有了。注意一条指令最多读 2 个寄存器，所以要判断 2 次。

转发是通过转发 MUX 来更改数据通路上寄存器的值，从而达到提前更新的目的。首先，数据通路上有寄存器值的地方，一共有四处：`D: rf.read_result1, D: rf.read_result2, E: rf.read_result1, E: rf.read_result2`。其中 E 级的两处是通过流水线寄存器暂存的。这四处可以分两类。对每类需要构造的转发 MUX 总结如下。

端口 | 所有的信号来源 | MUX 名称
--- | --- | ---
`D: rf.read_result1` | `E: alu.result, M: alu.result, W: rf.write_data` | `fm_d1`
`E: rf.read_result1` | `M: alu.result, W: rf.write_data` | `fm_e1`

**注意：不能在 M 级设置 MUX 转发 `dm` 的数据，因为这样 D 级或 E 级会等待 M 级 `dm` 的数据，关键路径会变得非常长，极大地降低流水线性能。**

转发 MUX 最终是由控制模块控制的。但是控制模块也没法克服有些数据通路不能转发的现实（比如 `M: dm.read_result`）。这就需要——

#### 暂停

需要暂停是因为有些数据冒险靠转发解决不了，必须要让后面的指令暂停一个时钟周期。暂停的方式是在流水线中插入一个 NOP（这时候也叫气泡），从而让发生数据冒险的指令能够转发。

流水线 CPU 数据通路中能提供的暂停机制有锁定 `pc` 和清空 D 级 `im.result` 寄存器。这样就可以在流水线 D 级插入气泡。清空 D 级 `im.result` 寄存器是通过流水线寄存器都有的复位功能实现的。

