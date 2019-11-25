## 指令识别机制

### 原理

指令识别机制是为了判断指令的功能而设计的。它可以实现判断指令的具体类型、数据通路类型、需要的控制信号等功能。用这些函数识别出来的数据，就可以判断指令的数据流、转发和暂停相关信息和异常相关信息等。

#### 宏定义

由于有特殊的指令读写固定的寄存器，所以寄存器号也要宏定义。

由于函数的声明需要一定的范式保证健壮性，所以函数的声明本身也要定义。

用把宏定义成宏的方法，定义表中值为宏的宏。值为宏的宏的意义，与定义它的宏一样，在表中省略。

类别 | 定义 | 值 | 意义
--- | --- | --- | ---
寄存器号 | `ZERO` | `5'd0` | 0 号寄存器（或者表示某指令在某函数下对应的寄存器不存在）
寄存器号 | `NULL` | `ZERO` |
寄存器号 | `RA` | `5'd31` | 31 号寄存器（`$ra`，`jal` 指令要写入）
函数声明 | `ROBUST_FUNCTION` | `function automatic` | `automatic` 保证函数同时调用时一定使用不同的硬件块

### 端口定义

端口 | 类型 | 位宽 | 功能
--- | --- | ---
`instr` | 输入 | 32 | 要分析的指令
`kind` | 输出 | 9 | 当前指令的具体类型

#### 功能

获取当前指令的具体类型。返回的结果一共 9 位，前 4 位是数据通路类型，后 5 位是具体类型。

若指令的格式符合 MIPS 指令集中的相应格式，则返回对应指令的代码（在宏定义一节中描述）。否则，返回 0。

#### 宏定义

用把宏定义成宏的方法，定义表中值为宏的宏。值为宏的宏的意义，与定义它的宏一样，在表中省略。

编码方式为前 4 位为数据通路类型，后 5 位为其下的具体类型。

指令的意义在表示相应指令的情况下省略不写。但如果有相应备注，也会在这栏注明。

##### 指令字段

类别 | 定义 | 值 | 意义
--- | --- | --- | ---
指令字段 | `OP(x)` | `(x[31:26])` | 指令的 `op` 字段
指令字段 | `RS(x)` | `(x[25:21])` | 指令的 `rs` 字段
指令字段 | `RT(x)` | `(x[20:16])` | 指令的 `rt` 字段
指令字段 | `RD(x)` | `(x[15:11])` | 指令的 `rd` 字段
指令字段 | `SHAMT(x)` | `(x[10:6])` | 指令的 `shamt` 字段
指令字段 | `FUNCT(x)` | `(x[5:0])` | 指令的 `funct` 字段
指令字段 | `IMM(x)` | `(x[15:0])` | 指令的 `imm` 字段
指令字段 | `IMM_J(x)` | `(x[25:0])` | `j` 指令的 `imm` 字段

##### 指令类型

类别 | 定义 | 值 | 意义
--- | --- | --- | ---
指令类型 | `UNKNOWN` | `9'b0000_00000` | 未知指令
指令类型 | `UNK` | `UNKNOWN` | 
指令类型 | `ADDU` | `9'b0001_00000` | 
指令类型 | `SUBU` | `9'b0001_00001` | 
指令类型 | `ADD` | `9'b0001_00010` |
指令类型 | `SUB` | `9'b0001_00011` |
指令类型 | `SLL` | `9'b0001_00100` |
指令类型 | `SRL` | `9'b0001_00101` |
指令类型 | `SRA` | `9'b0001_00110` |
指令类型 | `AND` | `9'b0001_00111` |
指令类型 | `OR` | `9'b0001_01000` |
指令类型 | `NOR` | `9'b0001_01001` |
指令类型 | `XOR` | `9'b0001_01010` |
指令类型 | `SLT` | `9'b0001_01011` |
指令类型 | `SLTU` | `9'b0001_01100` |
指令类型 | `SLLV` | `9'b0001_01101` |
指令类型 | `SRLV` | `9'b0001_01110` |
指令类型 | `SRAV` | `9'b0001_01111` |
指令类型 | `LUI` | `9'b0010_00000` | 
指令类型 | `ORI` | `9'b0010_00001` | 
指令类型 | `ADDI` | `9'b0010_00010` |
指令类型 | `ADDIU` | `9'b0010_00011` |
指令类型 | `ANDI` | `9'b0010_00100` |
指令类型 | `XORI` | `9'b0010_00101` |
指令类型 | `SLTI` | `9'b0010_00110` |
指令类型 | `SLTIU` | `9'b0010_00111` |
指令类型 | `LW` | `9'b0011_00000` | 
指令类型 | `LH` | `9'b0011_00001` |
指令类型 | `LHU` | `9'b0011_00010` |
指令类型 | `LB` | `9'b0011_00011` |
指令类型 | `LBU` | `9'b0011_00100` |
指令类型 | `SW` | `9'b0100_00000` | 
指令类型 | `SH` | `9'b0100_00001` |
指令类型 | `SB` | `9'b0100_00010` |
指令类型 | `BEQ` | `9'b0101_00000` |
指令类型 | `BNE` | `9'b0101_00001` |
指令类型 | `BLEZ` | `9'b0101_00010` |
指令类型 | `BGEZ` | `9'b0101_00011` |
指令类型 | `BLTZ` | `9'b0101_00100` |
指令类型 | `BGTZ` | `9'b0101_00101` |
指令类型 | `J` | `9'b0110_00000` |
指令类型 | `JAL` | `9'b0110_00001` |
指令类型 | `JR` | `9'b0111_00000` | 
指令类型 | `JALR` | `9'b0111_00001` |
指令类型 | `MOVZ` | `9'b1000_00000` |
指令类型 | `MULT` | `9'b1001_00000` | 
指令类型 | `MULTU` | `9'b1001_00001` |
指令类型 | `DIV` | `9'b1001_00010` |
指令类型 | `DIVU` | `9'b1001_00011` |
指令类型 | `MFHI` | `9'b1010_00000` |
指令类型 | `MFLO` | `9'b1010_00001` |
指令类型 | `MTHI` | `9'b1011_00000` |
指令类型 | `MTLO` | `9'b1011_00001` |

### 注意

1. 临时的数据通路类型都是从上往下长的。
