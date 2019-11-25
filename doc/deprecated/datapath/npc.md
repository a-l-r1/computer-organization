## NPC

### 原理

NPC 是下个 PC 值的意思。它能做到根据当前的 PC 值，计算出下一个 32 位的 PC 值。

一般来说，PC 值的转换是顺序转换。但是，NPC 必须要听控制模块的指令，做到在某些条件下进行符号转换。

### 接口定义 

端口 | 类型 | 位宽 | 功能
--- | --- | --- | ---
`curr_pc` | 输入 | 32 | 当前 PC
`jump_mode` | 输入 | 4 | 是否可以跳转
`cmp_result` | 输入 | 2 | `cmp` 的比较结果
`cmp_sig_result` | 输入 | 2 | `cmp` 的有符号比较结果
`num` | 输入 | 16 | 输入的立即数
`jnum` | 输入 | 26 | 输入的 J 型指令的立即数
`reg_` | 输入 | 32 | 输入的寄存器值
`next_pc` | 输出 | 32 | 下一个 PC

### 宏定义

用把宏定义成宏的方法，定义表中值为宏的宏。把一个宏定义成另一个宏，那该宏的意义与定义它的宏一样，表中省略。

类别 | 定义 | 值 | 意义
--- | --- | --- | ---
`jump_mode` | `NPC_JUMP_DISABLE` | 4'b0000 | 不要跳转
`jump_mode` | `NPC_JUMP_DISABLED` | `NPC_JUMP_DISABLE` | 
`jump_mode` | `NPC_JUMP_WHEN_EQUAL` | 4'b0001 | 当输入的比较结果相等时跳转
`jump_mode` | `NPC_JUMP_WHEN_EQUALS_TO` | `NPC_JUMP_WHEN_EQUAL` | 
`jump_mode` | `NPC_EQUAL` | `NPC_JUMP_WHEN_EQUAL` |
`jump_mode` | `NPC_JUMP_WHEN_NOT_EQUAL` | 4'b0010 | 当输入的比较结果不等时跳转
`jump_mode` | `NPC_JUMP_WHEN_NOT_EQUALS_TO` | `NPC_JUMP_WHEN_NOT_EQUAL` | 
`jump_mode` | `NPC_NOT_EQUAL` | `NOT_JUMP_WHEN_NOT_EQUAL` |
`jump_mode` | `NPC_REG` | 4'b1111 | 按照寄存器内地址跳转
`jump_mode` | `NPC_J` | 4'b1110 | 按照 J 型指令的立即数跳转
`jump_mode` | `NPC_LARGER` | 4'b0011 | 当输入的比较结果为大于时跳转
`jump_mode` | `NPC_SMALLER` | 4'b0100 | 当输入的比较结果为小于时跳转
`jump_mode` | `NPC_LARGER_OR_EQUAL` | 4'b0101 | 当输入的比较结果为大于或等于时跳转
`jump_mode` | `NPC_SMALLER_OR_EQUAL` | 4'b0110 | 当输入的比较结果为小于或等于时跳转
`jump_mode` | `NPC_SIG_LARGER` | 4'b0111 | 当输入的有符号比较结果为大于时跳转
`jump_mode` | `NPC_SIG_SMALLER` | 4'b1000 | 当输入的有符号比较结果为小于时跳转
`jump_mode` | `NPC_SIG_LARGER_OR_EQUAL` | 4'b1001 | 当输入的有符号比较结果为大于或等于时跳转
`jump_mode` | `NPC_SIG_SMALLER_OR_EQUAL` | 4'b1010 | 当输入的有符号比较结果为小于或等于时跳转

`comp_result` 的相应数值代表的意义，与相应的宏有关，这些宏在 `alu.h` 中。

### 功能

令跳转基准地址 `base = $unsigned(curr_pc)`。

若 `jump_mode == NPC_JUMP_DISABLE`，则令 `next_pc = $unsigned(base) + $unsigned(4)`。

若 `jump_mode == NPC_JUMP_WHEN_EQUAL`，则 `alu_comp_result == ALU_EQUAL` 时，首先把 `num` 扩展成 32 位有符号立即数，扩展方式是首先把 `num` 后面加上 `2'b0`，然后把这 18 位二进制数扩展成 32 位有符号二进制数。然后令 `next_pc = $signed(base) + $signed(num)`。否则做跟 `jump_mode == NPC_JUMP_DISABLE` 时相同的步骤。

若 `jump_mode` 对应的意义有其它的比较，则 `cmp_result` 或 `cmp_sig_result` 满足相应条件时，做跟上面相同的步骤。否则做跟 `jump_mode == NPC_JUMP_DISABLE` 时相同的步骤。

若 `jump_mode == NPC_REG`，则令 `next_pc = reg_`。

若 `jump_mode == NPC_J`，则令 `next_pc = {base[31:28], jnum, 2'b0}`。

若 `jump_mode` 为其它值，则做跟 `jump_mode == NPC_JUMP_DISABLE` 时相同的步骤。

### 注意事项

1. NPC 是在内部进行符号扩展，不用 ext。
2. `reg_` 是为了避免和 `reg` 冲突。
3. `base` 抽象出来是为了方便调试和维护，它是跟 MIPS 指令集手册相符的。

