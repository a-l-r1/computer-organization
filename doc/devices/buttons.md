## 按钮模块

### 原理

按钮模块通过捕获外部输入的 8 个信号，把它转换成相应的硬件中断。输入会自动经过防抖处理，因此在模块内不考虑防抖的问题。由于按钮只是输入，没有输出，所以不考虑向设备内寄存器写入数据的问题。

### 端口定义

端口 | 类型 | 位宽 | 功能
--- | --- | --- | ---
`clk` | 输入 | 1 | 时钟信号
`rst` | 输入 | 1 | 复位信号
`input_` | 输入 | 8 | 输入的 8 个信号，代表用户输入
`addr` | 输入 | 32 | 地址信号
`out` | 输出 | 32 | 读出的数据

### 宏定义

暂无

### 参数定义

参数 | 默认值 | 功能
--- | --- | ---
`BASE_ADDR` | `0x7fff0100` | MMIO 基地址

### 功能

该部件为时序部件，所有寄存器初值均为 0。

该部件维护一个 8 位寄存器 `stored`，负责存储在这个时钟周期中用户的输入。

每个时钟上升沿，若 `rst == 1'b1`，则 `stored <= 0`。否则，`stored <= ~input_`。

无论什么时候，若 `addr == BASE_ADDR`，则令 `out = {24'b0, stored}`，否则令 `out = 32'b0`。
