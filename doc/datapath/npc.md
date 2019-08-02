## NPC

### 功能

NPC 是下个 PC 值的意思。它能做到根据当前的 PC 值，计算出下一个 32 位的 PC 值。

一般来说，PC 值的转换是顺序转换。但是，NPC 必须要听控制模块的指令，做到在某些条件下进行符号转换。

### 接口定义 

端口 | 类型 | 位宽 | 功能
--- | --- | --- | ---
`curr_pc` | 输入 | 32 | 当前 PC
`jump_mode` | 输入 | 3 | 是否可以跳转
`alu_comp_result` | 输入 | 2 | ALU 的比较结果
`num` | 输入 | 16 | 输入的立即数
`reg` | 输入 | 32 | 输入的寄存器值
`next_pc` | 输出 | 32 | 下一个 PC

### 宏定义

用把宏定义成宏的方法，定义表中值为宏的宏。把一个宏定义成另一个宏，那该宏的意义与定义它的宏一样，表中省略。

类别 | 定义 | 值 | 意义
--- | --- | --- | ---
`jump_mode` | `NPC_JUMP_DISABLE` | 3'b000 | 不要跳转
`jump_mode` | `NPC_JUMP_DISABLED` | `NPC_JUMP_DISABLE` | 
`jump_mode` | `NPC_JUMP_WHEN_EQUAL` | 3'b001 | 当 ALU 输入的比较结果相等时跳转
`jump_mode` | `NPC_JUMP_WHEN_EQUALS_TO` | `NPC_JUMP_WHEN_EQUAL` | 
`jump_mode` | `NPC_JUMP_WHEN_NOT_EQUAL` | 3'b010 | 当 ALU 输入的比较结果不等时跳转
`jump_mode` | `NPC_JUMP_WHEN_NOT_EQUALS_TO` | `NPC_JUMP_WHEN_NOT_EQUAL` | 
`jump_mode` | `NPC_REG` | 3'b111 | 按照寄存器内地址跳转

`alu_comp_result` 的相应数值代表的意义，与相应的宏有关，这些宏在 `alu.h` 中。

### 功能

若 `jump_mode == NPC_JUMP_DISABLE`，则令 `next_pc = $unsigned(curr_pc) + $unsigned(4)`。

若 `jump_mode == NPC_JUMP_WHEN_EQUAL`，则 `alu_comp_result == ALU_EQUAL` 时，首先把 `num` 扩展成 32 位有符号立即数，扩展方式是首先把 `num` 后面加上 `2'b0`，然后把这 18 位二进制数扩展成 32 位有符号二进制数。然后令 `next_pc = $signed(curr_pc) + $signed(4) + $signed(num)`。否则做跟 `jump_mode == NPC_JUMP_DISABLE` 时相同的步骤。

若 `jump_mode == NPC_JUMP_WHEN_NOT_EQUAL`，则 `alu_comp_result != ALU_EQUAL` 时，做跟上面相同的步骤。否则做跟 `jump_mode == NPC_JUMP_DISABLE` 时相同的步骤。

若 `jump_mode == NPC_REG`，则令 `nextpc = reg`。

若 `jump_mode` 为其它值，则做跟 `jump_mode == NPC_JUMP_DISABLE` 时相同的步骤。

### 注意事项

1. NPC 是在内部进行符号扩展，不用 ext。

