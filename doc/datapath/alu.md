## ALU

### 原理

ALU 是运算控制单元的意思，负责两个 32 位整数的运算。它可以负责各种运算，包括数学运算和逻辑运算。易知它是纯组合逻辑。

由于定义运算的时候需要给运算编码，所以表示运算就有点类似于 C 语言中的 `enum`。因此，需要对各种运算进行宏定义，以保证系统的可维护性。宏定义也可以把定义的数据空间分隔开，以及对运算按照逻辑进行排序，从而得到对端口运算编码的更好理解。

### 端口定义

端口 | 类型 | 位宽 | 功能
--- | --- | --- | ---
`num1` | 输入 | 32 | 第一个操作数
`num2` | 输入 | 32 | 第二个操作数
`op` | 输入 | 5 | 操作符
`result` | 输出 | 32 | 结果
`comp_result` | 输出 | 2 | 作为无符号数的比较结果
`sig_comp_result` | 输出 | 2 | 作为有符号数的比较结果
`overflow` | 输出 | 1 | 计算过程中是否发生溢出
`op_invalid` | 输出 | 1 | 操作符是否无效

由于在硬件层级对数的加减都是无符号数加减法，所以这里的溢出，是指操作过程中出现了做无符号数加减法时结果超出无符号数范围的现象。

### 宏定义

采用操作符最高两位区分类别的方法定义宏。用把宏定义成宏的方法，定义表中值为宏的宏。

类别 | 定义 | 值 | 意义
--- | --- | --- | ---
`op` | `ALU_ADD` | 5b'00000 | 加法运算
`op` | `ALU_UNSIGNED_ADD` | `ALU_ADD` | 同上
`op` | `ALU_SUB` | 5b'00001 | 减法运算
`op` | `ALU_UNSIGNED_SUB` | `ALU_SUB` | 同上
`op` | `ALU_AND` | 5b'10000 | 按位与运算
`op` | `ALU_BITWISE_AND` | `ALU_AND` | 同上
`op` | `ALU_OR` | 5b'10001 | 按位或运算
`op` | `ALU_BITWISE_OR` | `ALU_OR` | 同上
`op` | `ALU_NOT` | 5b'10010 | 按位非运算
`op` | `ALU_BITWISE_NOT` | `ALU_NOT` | 同上
`op` | `ALU_XOR` | 5b'10011 | 按位异或运算
`op` | `ALU_MOVZ` | 5b'00010 | 数据转移运算（[1]）
`.*comp_result` | `ALU_EQUAL` | 2b'00 | 等于
`.*comp_result` | `ALU_EQUAL_TO` | `ALU_EQUAL` | 同上
`.*comp_result` | `ALU_LARGER` | 2b'01 | 大于
`.*comp_result` | `ALU_LARGER_THAN` | `ALU_LARGER` | 同上
`.*comp_result` | `ALU_SMALLER` | 2b'10 | 小于
`.*comp_result` | `ALU_SMALLER_THAN` | `ALU_SMALLER` | 同上
`overflow` | `ALU_OVERFLOW` | 1'b1 | 溢出
`overflow` | `ALU_NOT_OVERFLOW` | 1'b0 | 未溢出
`op_invalid` | `ALU_INVALID_OP` | 1'b1 | 操作符无效
`op_invalid` | `ALU_INVALID` | `ALU_INVALID_OP` | 同上
`op_invalid` | `ALU_VALID_OP` | 1'b0 | 操作符有效
`op_invalid` | `ALU_VALID` | `ALU_VALID_OP` | 同上

注：

1. 数据转移运算只是简单地让结果等于第一个操作数，因为真正转不转移是控制模块判断写入哪个寄存器决定的。

### 功能

若 `op` 的值为合法操作（即上面“宏定义”一节中列出的操作），按照 `op` 中给出的操作计算出结果，并把结果放入 `result` 中。然后把输入的数看成无符号数并比较，若发生上面提到的溢出现象，就令 `overflow` 为 `1'b1`，否则为 `1'b0`。注意不管 `num[12]` 输入的原来意义是什么，都把它看成无符号数进行计算。

检查溢出的方式是用一个 33 位的中间变量，在加减法时用同样的方法算出该中间变量的值。如果有溢出，那它的最高位应该为 1，否则为 0。在做其它运算时，把这个中间变量变为恒 0。

如果 `op` 的值为非法操作，就令 `op_invalid` 为 `1'b1`，否则为 `1'b0`。此时令 `result` 为 `32'b0`。

`.*comp_result` 的值仅由 `num[12]` 确定，与其它输入无关。`.*comp_result` 的比较方式，在端口定义中。比较的输出结果，在宏定义中。不会输出宏定义中没有定义的结果。

### 注意事项

1. 添加新运算时注意同时改 `op_invalid` 的输出和 `result` 的输出
2. 如果不确定符号，就加上 `[un|]signed`

