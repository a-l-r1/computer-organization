## 数据存储器

### 原理

数据存储器是存储数据的地方。

为了渐变，数据存储器由许多寄存器实现。

### 端口定义

端口 | 类型 | 位宽 | 功能
--- | --- | --- | ---
`clk` | 输入 | 1 | 时钟信号
`curr_pc` | 输入 | 32 | 当前 PC 值
`read_addr` | 输入 | 32 | 读地址
`write_addr` | 输入 | 32 | 写地址
`write_data` | 输入 | 32 | 写数据
`write_enable` | 输入 | 1 | 写使能信号
`mode` | 输入 | 3 | 模式选择
`read_result` | 输出 | 32 | 读到的结果
`invalid` | 输出 | 1 | 地址是否错误

### 宏定义

用把宏定义成宏的方法，定义表中值为宏的宏。值为宏的宏的意义，与定义它的宏一样，在表中省略。

类别 | 定义 | 值 | 意义
--- | --- | --- | ---
`write_enable` | `DM_WRITE_ENABLE` | `1'b1` | DM 使能
`write_enable` | `DM_WRITE_ENABLED` | `DM_WRITE_ENABLE` | 
`write_enable` | `DM_WRITE_DISABLE` | `1'b0` | DM 非使能
`write_enable` | `DM_WRITE_DISABLED` | `DM_WRITE_DISABLE` | 
`mode` | `DM_NONE` | 3'b000 | 不操作 `dm`
`mode` | `DM_W` | 3'b001 | 读取/写入一个字
`mode` | `DM_H` | 3'b011 | 读取/写入半个字
`mode` | `DM_HU` | 3'b010 | 读取半个字，按无符号数读取
`mode` | `DM_B` | 3'b101 | 读取/写入一个字节
`mode` | `DM_BU` | 3'b110 | 读取一个字节，按无符号数读取
`.*_addr` | `DM_ADDR_WIDTH` | 8 | `.*_addr` 的位宽
指令存储器 | `DM_SIZE` | 64 | 能存储 32 位字的个数

### 功能

该部件为时序部件。

有 `DM_SIZE` 个 32 位存储器，代表其中存储的指令。它们初值都为 `32'b0`。

首先得出操作地址 `op_addr`。若 `write_enable == DM_ENABLED`，则操作地址为写地址，否则操作地址为读地址。

然后确定操作是否合法。若 `mode == DM_NONE || (mode == DM_W && op_addr[1:0] == 2'b0) || (mode == DM_H && op_addr[0] == 1'b0) || (mode == DM_HU && op_addr[0] = 1'b0) || mode == DM_B || mode == DM_BU`，则操作合法，否则操作不合法。

在每个时钟上升沿，若 `write_enable == DM_ENABLED && invalid == 0`，则根据操作模式写入相应地址对应的数据。写入半个字和字节分别取 `write_data` 的低 16 位和低 8 位。同时，打印当前 PC 的值、`write_addr`和它对应地址的新值。如果是写入半个字或者字节，就打印四位或者两位十六进制数。

任何时候，若 `invalid == 1'b1`，则 `read_result == 32'b0`。否则，若 `mode == DM_NONE`，则 `read_result == 32'b0`。若 `mode` 为其它 `dm` 宏的值，则按照相应宏的意义读出数据，读到 `read_result` 中。若 `mode` 为其他值，则 `read_result == 32'b0`。

注意 `dm` 内部对 `write_addr` 和 `read_addr` 都截取了一部分。这样可以把 `dm` 直接接入数据通路，在数据通路中假定地址是 32 位的；同时 `dm` 的实现不需要那么多寄存器，更现实。但是实际上这样对地址空间进行了限制。

### 注意事项

1. `DM_ADDR_WIDTH` 和 `DM_ADDR_SIZE` 要一块改
2. 地址空间是被截断的，看起来是 32 位，实际上不是
3. **CPU 是小端序的**

