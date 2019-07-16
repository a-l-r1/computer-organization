## 程序存储器

### 原理

程序存储器是存储程序指令的地方。为了加载程序指令，它可以通过系统任务读取编译后的指令内容。

为了简便，程序存储器由许多寄存器实现。

### 端口定义

端口 | 类型 | 位宽 | 功能
--- | --- | --- | ---
`addr` | 输入 | `IM_ADDR_WIDTH` | 读地址
`enable` | 输入 | 1 | 使能信号
`result` | 输出 | 32 | 读到的结果

### 宏定义

用把宏定义成宏的方法，定义表中值为宏的宏。值为宏的宏的意义，与定义它的宏一样，在表中省略。

类别 | 定义 | 值 | 意义
--- | --- | --- | ---
`enable` | `IM_ENABLE` | `1'b1` | IM 使能
`enable` | `IM_ENABLED` | `IM_ENABLE` | 
`enable` | `IM_DISABLE` | `1'b0` | IM 非使能
`enable` | `IM_DISABLED` | `IM_DISABLE` | 
`addr` | `IM_ADDR_WIDTH` | 8 | `addr` 的位宽
指令存储器 | `IM_SIZE` | 64 | 能存储指令的个数
指令存储器 | `IM_CODE_FILENAME` | `"code/code.hex"` | 要加载的机器码

### 功能

有 `IM_SIZE` 个 32 位存储器，代表其中存储的指令。它们初值应该使用加载文件的系统任务加载。加载文件名由 `IM_CODE_FILENAME` 指定。

若 `enable == IM_ENABLED`，则 `result` 为 `addr[IM_ADDR_WIDTH - 1:1]` 对应的指令（从存储器中取得），否则 `result` 为 `32'b0`。

### 注意事项

1. `IM_ADDR_WIDTH` 和 `IM_SIZE` 需要一块改，因为它们的大小有关系
2. 以后可能会有 offset，注意一点

