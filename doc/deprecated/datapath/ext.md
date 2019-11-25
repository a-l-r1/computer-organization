## 扩展器

### 功能

扩展器是专门执行扩展整数功能的运算。它能做到小于 32 位的整数向 32 位整数的转换，其中有符号转换，也有无符号转换。

转换器的模式由宏定义的方式指定，有符号扩展，也有无符号扩展，也有其它模式。由于没有明显的层次和类别关系，采用顺序编号和按常见顺序编号的方法。

### 接口定义

端口 | 类型 | 位宽 | 功能
--- | --- | --- | ---
`num` | 输入 | 16 | 输入的数字
`mode` | 输入 | 3 | 模式
`result` | 输出 | 32 | 扩展的结果

### 宏定义

用把宏定义成宏的方法，定义表中值为宏的宏。把一个宏定义成另一个宏，那该宏的意义与定义它的宏一样，表中省略。

类别 | 定义 | 值 | 意义
--- | --- | --- | ---
`mode` | `EXT_MODE_SIGNED` | 3'b000 | 符号扩展
`mode` | `EXT_SIGNED` | `EXT_MODE_SIGNED` | 
`mode` | `EXT_MODE_UNSIGNED` | 3'b001 | 无符号扩展
`mode` | `EXT_UNSIGNED` | `EXT_MODE_UNSIGNED` | 
`mode` | `EXT_MODE_PAD` | 3'b010 | 把输入的 16 位填充到输出结果的高 16 位，输出结果低 16 位置零的扩展
`mode` | `EXT_PAD` | `EXT_MODE_PAD` | 
`mode` | `EXT_MODE_HIGH_BITS` | `EXT_MODE_PAD` | 
`mode` | `EXT_HIGH_BITS` | `EXT_MODE_PAD` | 
`mode` | `EXT_MODE_ONE` | 3'b011 | 在数字前面填充二进制 1 的扩展
`mode` | `EXT_ONE` | `EXT_MODE_ONE` | 

### 功能

若 `mode` 的值为合法操作（即上面“宏定义”一节中列出的操作），按照 `mode` 中给出的操作计算出结果，并把结果放入 `result` 中。

若 `mode` 的值为非法操作，就令 `result = 32'b0`。

