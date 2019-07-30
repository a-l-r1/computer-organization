## 指令识别系列函数

### 原理

指令识别系列函数是为了判断指令的功能而设计的。它可以实现判断指令的具体类型、数据通路类型、需要的控制信号等功能。用这些函数识别出来的数据，就可以判断指令的数据流、转发和暂停相关信息和异常相关信息等。

### 函数列表

* `get_instr_kind`
* `get_instr_datapath_type`
* `get_instr_read_reg1`
* `get_instr_read_reg2`
* `get_instr_write_reg`

TODO: 函数需要的控制信号

### 输入输出定义

所有函数的输入都相同。

输入 | 类型 | 位宽 | 功能
--- | --- | --- | ---
`instr` | 输入 | 32 | 要分析的指令

### 为什么要用函数？

1. 函数是纯组合逻辑，没有引入锁存器的危险
2. 函数可以设置成可重入（`automatic`）的，每次调用都使用不同的硬件资源
3. 函数可以增强模块化程度
4. 在函数里可以很放心地使用 `if` 和 `case` 等常规编程语言能用的语句
