## 数据存储器

### 原理

数据存储器是存储数据的地方。

为了渐变，数据存储器由许多寄存器实现。

### 端口定义

端口 | 类型 | 位宽 | 功能
--- | --- | --- | ---
`clk` | 输入 | 1 | 时钟信号
`read_addr` | 输入 | 32 | 读地址
`write_addr` | 输入 | 32 | 写地址
`write_data` | 输入 | 32 | 写数据
`write_enable` | 输入 | 1 | 写使能信号
`read_result` | 输出 | 32 | 读到的结果

### 宏定义

用把宏定义成宏的方法，定义表中值为宏的宏。值为宏的宏的意义，与定义它的宏一样，在表中省略。

类别 | 定义 | 值 | 意义
--- | --- | --- | ---
`write_enable` | `DM_WRITE_ENABLE` | `1'b1` | DM 使能
`write_enable` | `DM_WRITE_ENABLED` | `DM_WRITE_ENABLE` | 
`write_enable` | `DM_WRITE_DISABLE` | `1'b0` | DM 非使能
`write_enable` | `DM_WRITE_DISABLED` | `DM_WRITE_DISABLE` | 
`.*_addr` | `DM_ADDR_WIDTH` | 8 | `.*_addr` 的位宽
指令存储器 | `DM_SIZE` | 64 | 能存储 32 位字的个数

### 功能

该部件为时序部件。

有 `DM_SIZE` 个 32 位存储器，代表其中存储的指令。它们初值都为 `32'b0`。

在每个时钟上升沿，若 `write_enable == DM_ENABLED`，则 `write_addr[DM_ADDR_WIDTH - 1:1]` 这个地址对应的 32 位字写入 `write_data` 对应的值。同时，打印 `write_addr`、`write_addr` 这个地址对应的 32 位字原来的值、它的新值。

任何时候，`read_result` 的值为 `read_addr[DM_ADDR_WIDTH - 1:1]` 对应的地址的值。

注意 `dm` 内部对 `write_addr` 和 `read_addr` 都截取了一部分。这样可以把 `dm` 直接接入数据通路，在数据通路中假定地址是 32 位的；同时 `dm` 的实现不需要那么多寄存器，更现实。但是实际上这样对地址空间进行了限制。

### 注意事项

1. 现在还没有按照半个字或者字节寻址，所以暂时不加入 `mode` 端口
2. 直接忽略地址后两位
3. `DM_ADDR_WIDTH` 和 `DM_ADDR_SIZE` 要一块改
4. 地址空间是被截断的，看起来是 32 位，实际上不是

