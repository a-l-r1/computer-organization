## 寄存器堆

### 原理

寄存器堆保存着 32 位 32 个通用寄存器，负责存储 CPU 立刻想要的数据，它是存储器层次结构中的最高一级，负责暂存数据。第 0 号寄存器 `$0` 的值永远是 `32'b0`，写入不会改变它的值。

由于 MIPS 体系结构中的指令最多读两个寄存器，写一个寄存器，所以寄存器输入两个要读的地址，输出两个要读的数据；输入一个要写的地址和一个要写的数据；同时还有写使能端口。

寄存器的使用没有规定，这一般是软件关心的问题。

### 端口定义

端口 | 类型 | 位宽 | 功能 
--- | --- | --- | ---
`clk` | 输入 | 1 | 时钟信号
`read_addr1` | 输入 | 5 | 第一个读地址
`read_addr2` | 输入 | 5 | 第二个读地址
`write_addr` | 输入 | 5 | 写地址
`write_data` | 输入 | 32 | 要写入的数据
`write_enable` | 输入 | 1 | 写使能
`read_result1` | 输出 | 32 | 第一个读地址读出的数据
`read_result2` | 输出 | 32 | 第二个读地址读出的数据

### 宏定义

用把宏定义成宏的方法，定义表中值为宏的宏。值为宏的宏的意义，与定义它的宏一样，在表中省略。

类别 | 定义 | 值 | 意义
--- | --- | --- | ---
`.*_addr.*` | `RF_ADDR_ZERO` | 5'b0 | 零寄存器的地址
`.*_addr.*` | `RF_ZERO` | `RF_ADDR_ZERO` | 
`write_enable` | `RF_WRITE_ENABLED` | 1'b1 | 寄存器堆使能
`write_enable` | `RF_WRITE_ENABLE` | `RF_WRITE_ENABLED` | 
`write_enable` | `RF_WRITE_DISABLED` | 1'b0 | 寄存器堆非使能
`write_enable` | `RF_WRITE_DISABLE` | `RF_WRITE_DISABLED` | 
输出 | `RF_OUTPUT_FORMAT` | `"%d: 0x%08x => 0x%08x" | 输出模版

### 功能

该部件为时序部件。

有 31 个 32 位寄存器，代表 `$1`~`$31`，它们初值都为 `32'b0`。`$0` 实际上不需要寄存器。

在每个时钟上升沿，若 `write_enable == RF_WRITE_ENABLED` 且 `write_addr != RF_ADDR_ZERO`，则说明可以执行写操作，且写到的寄存器是可以保存数值的寄存器。此时把 `write_addr` 指代的寄存器的值更新为 `write_data`。更新时，以模版中的格式打印出数据变化，第一个参数是寄存器号，第二个参数是寄存器原来的值，第三个参数时更新后的值。

无论什么时候，若 `read_addr1 != RF_ADDR_ZERO`，则把 `read_addr1` 指代的寄存器的值输出到 `read_result1` 中，否则把 `32'b0` 输出到 `read_result1` 中。对 `read_addr2` 和 `read_result2` 的相应操作相同。

### 注意事项

1. 暂时还没有内部转发。
2. 寄存器可以定义为 `reg [31:1] registers [31:0]`，把 `$0` 空出来。
3. TODO: 应该把正常显示 wrap 起来，等到 ISE 装好后再说

