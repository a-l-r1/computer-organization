## 控制

### 原理

控制是指通过识别指令，控制数据的流通，从而让 CPU 执行指定的计算的过程。数据通路只是得到了数据可能的流向，真正要控制还是控制完成。控制通过已有的控制信号和数据通路的分叉完成控制。

在流水线 CPU 中，由于存在结构冒险和数据冒险，所以需要通过暂停和转发解决。暂停控制和转发控制可以放在单独的控制模块中，从而不影响原来单周期时的控制模块。但是，也可以通过改造控制模块的方式集成暂停和转发功能。通过指令识别系列函数（实际上综合时也会被综合成电路），可以分析指令，做到有效的暂停和转发。

### 端口定义

端口 | 类型 | 位宽 | 功能
--- | --- | --- | ---
`clk` | 输入 | 1 | 时钟信号
`d_instr` | 输入 | 32 | 当前在 D 级（ID）的指令
`rf_read_result2` | 输入 | 32 | `rf` 的 2 号读取结果
`cw_f_pc_enable` | 输出 | 1 | 控制 `pc` 使能
`cw_d_pff_enable` | 输出 | 1 | 控制 D 级流水线寄存器使能
`cw_e_pff_rst` | 输出 | 1 | 控制 E 级流水线寄存器复位
`cw_f_npc_jump_mode` | 输出 | 4 | 控制 `npc` 的跳转模式
`cw_d_ext_mode` | 输出 | 3 | 控制 `D: ext.mode`
`cw_d_rf_read_addr1` | 输出 | 5 | 控制 `D: rf.read_addr1`
`cw_d_rf_read_addr2` | 输出 | 5 | 控制 `D: rf.read_addr2`
`cw_e_m_alusrc` | 输出 | 1 | 控制 `E: m_alu_num2`
`cw_e_alu_op` | 输出 | 5 | 控制 `E: alu.op`
`cw_e_md_op` | 输出 | 3 | 控制 `E: md.op`
`cw_m_hilo` | 输出 | 1 | 控制 `E: m_hilo`
`cw_m_dm_write_enable` | 输出 | 1 | 控制 `M: dm.write_enable`
`cw_m_dm_mode` | 输出 | 1 | 控制 `M: dm.mode`
`cw_w_rf_write_enable` | 输出 | 1 | 控制 `W: rf.write_enable`
`cw_w_m_regdata` | 输出 | 3 | 控制 `W: m_rf_write_data`
`cw_w_rf_write_addr` | 输出 | 5 | 控制 `W: rf.write_addr`
`cw_fm_d[12]` | 输出 | 3 | 控制 `fm_d[12]`
`cw_fm_e[12]` | 输出 | 3 | 控制 `fm_e[12]`
`cw_fm_m` | 输出 | 3 | 控制 `fm_w`

### 总体结构

控制模块是时序部件。不设置成组合逻辑部件的原因如下。

1. 哪怕控制本身不设置成时序部件，也需要流水控制信号，这是流水线 CPU 结构上的需要。
2. 控制本身是时序部件，就可以流水更多的信息。最明显的就是指令读写寄存器的信息。比如暴力转发也把指令读写寄存器的信息放在流水线中流水。
3. 保留单周期处理器的控制机制实际上过渡不是那么平滑，因为还有多周期处理器，它的控制是类似状态机的结构。

控制模块在内部流水指令，从而做到比较有效的控制信号发射和数据冒险分析。负责控制信号发射的部分是纯组合逻辑，用函数实现。

同时，控制模块也在内部流水指令需要读取和写入的三个寄存器。因为流水线 CPU 和单周期 CPU 逻辑上应该一样，所以一条指令需要读取和写入的三个寄存器可以直接判断出来，并且流水。这样也可以更方便地处理数据冒险。

### 数据通路和功能控制信号

由于指令的数据通路可以分成几个类型，每种类型中需要的数据通路是一样的，只是某些控制信号不同。而且，流水线是分级的，所以每级控制数据通路形状的信号可以单独列表。

但是，不同的具体指令对不同部件的某些具体操作不同。比如 `CAL_R` 类指令对 ALU 的具体操作就不同。因此，对这些控制具体操作的信号，需要单独列表。

通过对数据通路形状的分析，可以得到每种数据通路类型需要的控制信号如下。其中表格某一单元格的值有两种情况：若该单元格所在的行最左边的单元格是 MUX，则说明对应的指令需要让该 MUX 的输入端口接入该单元格表示的端口；若该单元格所在的行最左边的单元格是端口，则说明对应的指令需要的控制信号为该单元格表示的控制信号。

若单元格以 `#` 开头，则说明该控制信号或端口只是为了使控制单元功能明晰而加上的，实际上并不需要关心该控制信号或要接入的端口的值。如果想理解该单元格的值，去掉 `#` 再按照上一段理解即可。

#### F 级

数据通路类型 | `F: npc.jump_mode`
--- | ---
`BRANCH` | 视具体指令而定
`JUMP_I` | `NPC_J`
`JUMP_R` | `NPC_REG`
（其它）| `NPC_JUMP_DISABLED`

`BRANCH` 类指令类型与 `F: npc.jump_mode` 的关系：

指令类型 | `F: npc.jump_mode`
--- | ---
`BEQ` | `NPC_EQUAL`
`BNE` | `NPC_NOT_EQUAL`
`BLEZ` | `NPC_SIG_SMALLER_OR_EQUAL`
`BGEZ` | `NPC_SIG_LARGER_OR_EQUAL`
`BLTZ` | `NPC_SIG_SMALLER`
`BGTZ` | `NPC_SIG_LARGER`

注意：**F 级的控制信号是由 D 级指令控制的。**

注意：**BRANCH 类指令要跟 0 比较的那些指令，是通过读 `$0` 比较的，所以能直接进行大小比较。**

#### D 级（ID）

数据通路类型 | `D: ext.mode`
--- | ---
`CAL_I` | 视具体指令而定
`LOAD` | `EXT_MODE_SIGNED`
`STORE` | `EXT_MODE_SIGNED`
（其它）| `#EXT_MODE_SIGNED`

`CAL_I` 类指令类型与 `D: ext.mode` 的关系：

指令类型 | `D: ext.mode`
--- | ---
`LUI` | `EXT_PAD`
`ORI` | `EXT_UNSIGNED`
`ADDI` | `EXT_SIGNED`
`ADDIU` | `EXT_SIGNED`
`ANDI` | `EXT_UNSIGNED`
`XORI` | `EXT_UNSIGNED`
`SLTI` | `EXT_SIGNED`
`SLTIU` | `EXT_SIGNED`

注意：**`SLTIU` 扩展立即数的时候确实是按照有符号扩展的，但比较是按照无符号数比较，可以查指令手册。**

#### E 级（EX）

数据通路类型 | `E: m_alusrc` | `E: alu.op` | `E: md.op` | `E: m_hilo`
--- | --- | --- | ---
`CAL_R` | `D: rf.read_result2` | 视具体指令而定 | `MD_NONE` | `#E: md.hi`
`CAL_I` | `D: ext.result` | 视具体指令而定 | `MD_NONE` | `#E: md.hi`
`LOAD` | `D: ext.result` | `ALU_ADD` | `MD_NONE` | `#E: md.hi`
`STORE` | `D: ext.result` | `ALU_ADD` | `MD_NONE` | `#E: md.hi`
`BRANCH` | `D: rf.read_result2` | `#ALU_OR` | `MD_NONE` | `#E: md.hi`
`CMOV` | `D: rf.read_result2` | 视具体指令而定 | `MD_NONE` | `#E: md.hi`
`CAL_M` | `#D: rf.read_result2` | `#ALU_OR` | 视具体指令而定 | `#E: md.hi`
`LOAD_M` | `#D: rf.read_result2` | `#ALU_OR` | 视具体指令而定 | 视具体指令而定
`STORE_M` | `#D: rf.read_result2` | `#ALU_OR` | 视具体指令而定 | `#E: md.hi`
（其它）| `#D: rf.read_result2` | `#ALU_OR` | `MD_NONE` | `#E: md.hi`

`CAL_R` 类指令类型与 `E: alu.op` 的关系：

指令类型 | `E: alu.op`
--- | ---
`ADDU` | `ALU_ADD`
`SUBU` | `ALU_SUB`
`ADD` | `ALU_ADD`
`SUB` | `ALU_SUB`
`AND` | `ALU_AND`
`OR` | `ALU_OR`
`NOR` | `ALU_NOR`
`XOR` | `ALU_XOR`
`SLT` | `ALU_SLT`
`SLTU` | `ALU_SLTU`
`SLL` | `ALU_SLL`
`SRL` | `ALU_SRL`
`SRA` | `ALU_SRA`
`SLLV` | `ALU_SLLV`
`SRLV` | `ALU_SRLV`
`SRAV` | `ALU_SRAV`

`CAL_I` 类指令类型与 `E: alu.op` 的关系：

指令类型 | `E: alu.op`
--- | ---
`LUI` | `ALU_OR`
`ORI` | `ALU_OR`
`ADDI` | `ALU_ADD`
`ADDIU` | `ALU_ADD`
`ANDI` | `ALU_AND`
`XORI` | `ALU_XOR`
`SLTI` | `ALU_SLT`
`SLTIU` | `ALU_SLTU`

`CMOV` 类指令类型与 `E: alu.op` 的关系：

指令类型 | `E: alu.op`
--- | ---
`MOVZ` | `ALU_MOVZ`

`CAL_M` 类指令类型与 `E: md.op` 的关系：

指令类型 | E: md.op
--- | ---
`MULT` | `MD_MULT`
`MULTU` | `MD_MULTU`
`DIV` | `MD_DIV`
`DIVU` | `MD_DIVU`

`LOAD_M` 类指令类型与 `E: md.op` 的关系：

指令类型 | `E: md.op`
--- | ---
`MFHI` | `MD_MFHI`
`MFLO` | `MD_MFLO`

`STORE_M` 类指令类型与 `E: md.op` 的关系：

指令类型 | `E: md.op`
--- | ---
`MTHI` | `MD_MTHI`
`MTLO` | `MD_MTLO`

`LOAD_M` 类指令类型与 `E: m_hilo` 的关系：

指令类型 | `E: m_hilo`
--- | ---
`MFHI` | `E: md.hi`
`MFLO` | `E: md.lo`

#### M 级（MEM）

数据通路类型 | `M: dm.write_enable` | `M: dm.mode`
--- | ---
`LOAD` | 1'b0 | 视具体指令而定
`STORE` | `1'b1` | 视具体指令而定
（其它）| `1'b0` | `DM_NONE`

`LOAD` 类指令类型与 `M: dm.mode` 的关系：

指令类型 | `M: dm.mode`
--- | ---
`LW` | `DM_W`
`LH` | `DM_H`
`LHU` | `DM_HU`
`LB` | `DM_B`
`LBU` | `DM_BU`

`STORE` 类指令类型与 `M: dm.mode` 的关系：

指令类型 | `M: dm.mode`
--- | ---
`SW` | `DM_W`
`SH` | `DM_H`
`SB` | `DM_B`

#### W 级（WB）

数据通路类型 | `W: rf.write_enable` | `W: m_regdata`
--- | --- | --- | ---
`CAL_R` | `1'b1` | `E: alu.result`
`CAL_I` | `1'b1` | `E: alu.result`
`LOAD` | `1'b1` | `E: dm.read_result`
`JUMP_I` | `1'b1` | `D: npc.next_pc`
`JUMP_R` | `1'b1` | `D: npc.next_pc`
`CMOV` | `1'b1` | `E: alu.result`
`LOAD_M` | 1'b1 | `E: md.out`
（其它）| `1'b0` | `#E: alu.result`

#### 流水的内容

流水 E 级、M 级、W 级指令及其要读的两个寄存器和要写的一个寄存器。不流水 D 级指令是为了配合暂停机制，D 级一被暂停，D 级指令只在组合逻辑跟着变化，不需要再在控制模块里改变 D 级指令的值。

#### 指令读写寄存器识别

比较显然的一点是数据通路类型决定指令要读写的寄存器号。所以，可以直接用取指令字段的宏来完成。

数据通路类型和指令读写寄存器的关系如下。如果指令不读写哪个寄存器，就用 `ZERO` 替换，因为 `ZERO` 不参与转发。这样，对转发正确性也没有影响。其中使用的获取指令字段的宏隐含着用要分析的指令作为参数。

数据通路类型 | `reg1` | `reg2` | `regw`
--- | --- | --- | ---
`CAL_R` | `RS` | `RT` | `RD`
`CAL_I` | `RS` | `RT` | `RT`
`LOAD` | `RS` | `ZERO` | `RT`
`STORE` | `RS` | `RT` | `ZERO`
`BRANCH` | `RS` | 视指令类型而定（[4]） | `ZERO`
`JUMP_I` | `ZERO` | `ZERO` | 视指令而定（[2]）
`JUMP_R` | `RS` | `ZERO` | 视指令而定（[3]）
`CMOV` | `RS` | `RT` | 视寄存器值而定（[1]）
`CAL_M` | `RS` | `RT` | `ZERO`
`LOAD_M` | `ZERO` | `ZERO` | `RD`
`STORE_M` | `RS` | `ZERO` | `ZERO`
（其它）| `ZERO` | `ZERO` | `ZERO`

注：

1. 有一点就是 `CMOV` 类指令。这类指令的一种实现是无条件把要写入的数据看成是 `$rs` 的值，但是**改变要写入的寄存器号**。如果 `$rt == 32'b0`，就写入 `$rd`，否则写入 `$0 / ZERO`。这样，加上把要读写的寄存器号流水的机制，能保证 `CMOV` 类指令的数据冒险处理不出错。哪怕在 W 级打开了 `rf` 的写使能，写入 `$0` 也没有影响。
2. `JUMP` 类指令若为 `jal`，则 `regw == RA`。若为 `j`，则 `regw == ZERO`。
3. `JUMP_R` 类指令若为 `jr`，则 `regw == ZERO`。若为 `jalr`，则 `regw == RD`。由于 `jr` 指令 `RS` 字段永远为 0，所以这样分析是正确的。
4. `BRANCH` 类指令若为 `beq` 或 `bne`，则 `reg2 == RT`。若为 `blez, bgez, bltz, bgtz`，则 `reg2 == ZERO`。由于这样会让 `cmp` 的比较结果变成对应寄存器与 0 的比较，符合指令功能描述，所以这样分析是正确的。

### 转发控制信号

由于流水线 CPU 中存在数据冒险，所以需要转发。由于有了指令识别函数，所以转发是非常抽象的，只需要判断涉及的寄存器号。而且只有两个级是转发的接收端（数据的需求者），因此可以在某一级的角度，一级一级往后排查。

注意：**先检查较新级的数据冒险，再检查较老级的，因为 `rf` 中的内容最终还是较新级的。**

对 D 级，先检查 E 级，再检查 M 级，再检查 W 级。对 E 级的寄存器，先检查 M 级，再检查 W 级。这样就能保证转发的完整性。

转发控制信号最终需要控制的是转发 MUX，因此转发 MUX 也要进行定义。

下表是所有转发的情况和具体的描述。意义中说的数据通路类型，都是源指令的数据通路类型。

类别 | 定义 | 值 | 意义
所有转发 MUX | `orig` | `0` | 不转发，保持原样
`fm_d[12]` | `E2D_rf` | `1` | E 级到 D 级，数据通路类型是 `CMOV`，要写入的数据在 D 级产生好了，到了 E 级才能转发
`fm_d[12]` | `E2D_npc` | `2` | E 级到 D 级，数据通路类型是 `JUMP_I / JUMP_R`，要写入的数据在 D 级产生好了，到了 E 级才能转发
`fm_d[12]` |  `M2D_npc` | `3` | M 级到 D 级，之后同上
`fm_d[12]` | `M2D_alu` | `4` | M 级到 D 级，数据通路类型是 `CAL_R / CAL_I / CMOV`，数据在 D 级或 E 级产生好了，但对 `CAL_R / CAL_I` 来说，到了 M 级才能转发
`fm_d[12]` | `W2D_rf` | `5` | W 级到 D 级，数据通路类型是所有能够写入寄存器的类型，数据在 W 级都可以转发了
`fm_d[12]` | `M2D_md` | `6` | M 级到 D 级，数据通路类型是 `LOAD_M`，数据在 E 级产生好了
`fm_d[12]` | `E2D_md` | `7` | E 级到 D 级，数据通路类型是 `LOAD_M`，数据在 E 级产生好了
`fm_e[12]` | `M2E_npc` | `1` | M 级到 E 级，数据通路类型是 `JUMP_I / JUMP_R`，要写入的数据在 D 级产生好了，到了 E 级才能转发
`fm_e[12]` | `M2E_alu` | `2` | M 级到 E 级，数据通路类型是 `CAL_R / CAL_I / CMOV`，数据在 D 级或 E 级产生好了，但对 `CAL_R / CAL_I` 来说，到了 M 级才能转发
`fm_e[12]` | `W2E_rf` | `3` | W 级到 D 级，数据通路类型是所有能够写入寄存器的类型，数据在 W 级都可以转发了
`fm_e[12]` | `M2E_md` | `4` | M 级到 D 级，数据通路类型为 `LOAD_M`，数据在 E 级产生好了
`fm_m` | `W2M_rf` | `1` | W 级到 M 级，数据通路类型是所有能够写入寄存器的类型，数据在 W 级都可以转发了（比如 `sw` 指令转发 `rf` 内容）

注意：**`B2A_.*` 表示 B 级从 A 级转发。**

注意：**宏的值要和对应转发 MUX 的接线顺序相符。**

注意：**`E2D_rf` 表示把 E 级的第一个寄存器转发出去，因为用到这条指令的是 `CMOV` 类指令。**

注意：**`fm_m` 检查的是要读取的第二个寄存器，因为现在用到的所有写入内存的指令，要写入内存的数据都与相应指令第二个寄存器的读取结果对应。以后甚至可能加上检查要读取的第一个寄存器，不过就要根据指令类型判断了。**

### 暂停控制信号

由于流水线中有些数据冒险通过转发解决不了，所以需要暂停机制。暂停机制的前提是产生数据冒险。暂停机制是通过 Tuse 和 Tnew 机制实现的。

Tuse 是指指令到 D 级以后还剩最晚多少时间就需要新值。Tnew 是指指令还需要多长时间才能开始转发。因此只要 Tuse < Tnew，就需要暂停，因为在流水线中如果没有暂停，两条指令的相对位置是不变的，如果不暂停，就不能解决数据冒险。

数据冒险可以只在 D 级检测和在 E 级解决，因为在 E 级插入气泡，就可以保证 Tuse 和 Tnew 最终回回归正常。

插入气泡是通过锁定 `pc` 和清空 E 级各个流水线寄存器实现的。但是，控制内部的流水线也要插入气泡。

暂停要分两个寄存器，因为数据冒险也是要分成两个寄存器的情况的。

注意：**Tnew 的计算是要看能够开始转发的时间，而不是生成好要转发数据的时间，因为不是所有转发路径都是可能的。**

注意：**控制内部的流水线也要插入气泡。**

在 D 级各种数据通路类型的 Tuse 如下。

数据通路类型 | Tuse (read\_addr1) | Tuse (read\_addr2)
--- | ---
`UNKNOWN` | | 
`CAL_R` | 1 | 1
`CAL_I` | 1 | 1
`LOAD` | 1 |
`STORE` | 1 | 2
`BRANCH` | 0 | 0
`JUMP_I` | | 
`JUMP_R` | 0 |
`CMOV` | 0 | 0
`CAL_M` | 1 | 1
`LOAD_M` | |
`STORE_M` | 1 | 1

在 E 级和 M 级各种数据通路类型的 Tnew 如下。忽略 W 级，因为所有指令到 W 级时都可以马上转发数据。

数据通路类型 | Tnew (E) | Tnew (M)
--- | --- | ---
`UNKNOWN` | |
`CAL_R` | 1 | 0
`CAL_I` | 1 | 0
`LOAD` | 2 | 1
`STORE` | |
`BRANCH` | | 
`JUMP_I` | 0 | 0
`JUMP_R` | 0 | 0
`CMOV` | 0 | 0
`NOP` | |
`CAL_M` | |
`LOAD_M` | 0 | 0
`STORE_M` | |

以上列表中 Tuse 没有列出的，是因为它没有意义，认为 Tuse 足够大。Tnew 同理，认为 Tnew 为 0。

这样，只要算出每个阶段的 Tuse 和 Tnew，并且保证发生数据冒险时对两个寄存器，Tuse >= Tnew，就能控制暂停和转发。当且仅当 `t_use_reg[12]` 小于 `t_new_[em]` 中的任何一个时，需要暂停。

`md.busy == 1'b1` 时，会一直插入气泡，直到 `md.busy == 1'b0`。而且，`CAL_M` 类指令虽然进行计算，但不写普通寄存器，所以跟其它指令没有转发解决不了的数据冒险，所以不停地插入气泡这种方式是可以解决数据冒险的。而且，跟 `dm` 类似，`md` 的 `HI` 和 `LO` 寄存器也没有数据冒险。因此，乘除法相关指令和其它指令之间，可以看成解决了需要暂停的问题，虽然 `md` 需要多个周期运行。

注意：**比较 Tuse 和 Tnew 应该用无符号比较，避免数值最高位是 1 时被看成负数。**

### 寄存器地址控制信号

由于已经有指令识别机制了，所以寄存器的地址控制可以简化。只需要在 D 级和 M 级的三个地址端口输入指令识别机制相应的结果即可。

