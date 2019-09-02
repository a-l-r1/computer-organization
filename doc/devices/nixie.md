## 七段数码管控制

### 原理

七段数码管通过向内部的 5 个寄存器写入值，来实现对七段数码管的控制。5 个寄存器对应 5 个数码管，每个寄存器有 8 位，让数码管分别显示 0-f。这样，它对外就有两个暴露出来的寄存器。

由于数码管分组，每组只有统一的段选信号和开关，所以需要通过隔一段时间刷新信号的方式进行控制，这样能显示出稳定的图像。具体分组如下：

内部寄存器地址 | 内部寄存器结构 | 具体数据位置 | 对应的数码管 | 对应的数码管段选信号 | 对应的数码管段选信号值
--- | --- | --- | --- | --- | ---
`$unsigned(BASE) + $unsigned(4)` | `{24'b0, tube2}` | `tube2[3:0]` | `digital_tube2` | `digital_tube_sel2` | `1'b1`
`$unsigned(BASE)` | `{tube1, tube0}` | `tube1[15:12]` | `digital_tube1` | `digital_tube_sel1` | `4'b1000`
`$unsigned(BASE)` | `{tube1, tube0}` | `tube1[11:8]` | `digital_tube1` | `digital_tube_sel1` | `4'b0100`
`$unsigned(BASE)` | `{tube1, tube0}` | `tube1[7:4]` | `digital_tube1` | `digital_tube_sel1` | `4'b0010`
`$unsigned(BASE)` | `{tube1, tube0}` | `tube1[3:0]` | `digital_tube1` | `digital_tube_sel1` | `4'b0001`
`$unsigned(BASE)` | `{tube1, tube0}` | `tube0[15:12]` | `digital_tube0` | `digital_tube_sel0` | `4'b1000`
`$unsigned(BASE)` | `{tube1, tube0}` | `tube0[11:8]` | `digital_tube0` | `digital_tube_sel0` | `4'b0100`
`$unsigned(BASE)` | `{tube1, tube0}` | `tube0[7:4]` | `digital_tube0` | `digital_tube_sel0` | `4'b0010`
`$unsigned(BASE)` | `{tube1, tube0}` | `tube0[3:0]` | `digital_tube0` | `digital_tube_sel0` | `4'b0001`

### 端口定义

端口 | 类型 | 位宽 | 功能
--- | --- | --- | ---
`clk` | 输入 | 1 | 时钟信号
`rst` | 输入 | 1 | 复位信号
`we` | 输入 | 1 | 写使能
`wd` | 输入 | 32 | 要写入的数据
`addr` | 输入 | 32 | 要读写的地址
`rd` | 输出 | 32 | 读取的数据
`digital_tube[0-2]` | 输出 | 8 | 第 `[0=2]` 个数码管的控制信号
`digital_tube_sel[01]` | 输出 | 4 | 第 `[01]` 个数码管的段选信号
`digital_tube_sel2` | 输出 | 1 | 第 2 个数码管的段选信号

### 宏定义

类别 | 定义 | 值 | 意义
--- | --- | --- | ---
计数器 | `NIXIE_CTR` | `32'd50000` | 计数器初值，决定计数器周期

### 参数定义

参数 | 默认值 | 功能
--- | --- | ---
`BASE_ADDR` | `32'h00007f38` | MMIO 基地址

### 功能

该部件为时序部件，所有寄存器若未说明，则初值均为 0。

维护一个 32 位的寄存器 `ctr` 和一个 4 位的寄存器 `phase`，以及一个 8 位的寄存器 `tube0` 和两个 16 位的寄存器 `tube1` 和 `tube2`。`ctr` 和 `phase` 初值分别为 `NIXIE_CTR` 和 `4'b1000`。每个时钟上升沿，若 `rst == 1'b1`，则所有寄存器恢复初值。否则，若 `we == 1'b1` 且 `wd` 属于上表中提到的地址之一，则把上表中对应的寄存器写入 `wd` 中对应位置的内容。否则，若 `$unsigned(ctr) > $unsigned(0)`，则 `ctr <= $unsigned(ctr) - $unsigned(1)`。否则，`ctr <= NIXIE_CTR`，`phase` 按照下表变换。

`phase` 原值 | `phase` 新值
--- | ---
`4'b1000` | `4'b0100`
`4'b0100` | `4'b0010`
`4'b0010` | `4'b0001`
`4'b0001` | `4'b1000`
（其它）| `4'b1000`

无论什么时候，`digital_tube_sel2 = 1'b1`，`digital_tube_sel[10] = phase`。令两个 4 位的 `wire` 变量 `data[210]` 为按照段选信号和对应的数码管序号得到的内部寄存器 `tube[210]` 的相应部分。把 `data[210]` 转换后的相应结果输出到对应的 `digital_tube[210]` 中。具体的转换逻辑使用数码管译码器实现。

无论什么时候，若 `addr` 为合法的输入地址，则 `rd` 为相应的结果。否则，`rd = 32'b0`。

### 注意事项

1. 译码器用单独的模块实现，这样能增强模块化。
2. **地址计算和比较用无符号数**
3. **写入数据后刷新是及时的，没有延迟，可能和要求不大一样**

