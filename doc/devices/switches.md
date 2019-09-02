## 开关模块

### 原理

开关模块负责控制 FPGA 上 64 个开关，并以一定的形式输出。由于 FPGA 上 64 个开关分成 8 组，每组代表的高低位不同，所以应该按组输入模块，以使模块的接线与 FPGA 的接线相对应。

由于一共有 64 个开关，所以一共有 64 位，分成两个 32 位寄存器读取。

### 端口定义

端口 | 类型 | 位宽 | 功能
--- | --- | --- | ---
`clk` | 输入 | 1 | 时钟信号
`rst` | 输入 | 1 | 同步复位信号
`addr` | 输入 | 32 | 读取地址
`dip_switch[0-7]` | 输入 | 8 | 8 组开关
`out` | 输出 | 32 | 读取结果

### 宏定义

暂无

### 参数定义

参数 | 默认值 | 功能
--- | --- | ---
`BASE_ADDR` | `32'h00007f2c` | MMIO 基地址

### 功能

该部件为时序部件，所有寄存器初值为 0。

维护一个内部寄存器 `stored`，为 64 位，存储 `{dip_switch7, dip_switch6, ..., dip_switch0}`。

每个时钟上升沿，若 `rst == 1'b1`，`stored <= 0`。否则，`stored <= ~{dip_switch7, dip_switch6, ..., dip_switch0}`。

无论什么时候，`real_addr = $unsigned(addr) - $unsigned(BASE_ADDR)`。若 `real_addr == 0`，则 `out = stored[31:0]`；若 `real_addr = 4`，则 `out = stored[63:32]`；否则 `out = 32'h0`。

