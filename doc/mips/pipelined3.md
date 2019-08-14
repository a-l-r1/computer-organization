## 顶层模块

### 原理

顶层模块是整个工程的顶层模块，负责把用到的所有电路综合起来。顶层模块包括 CPU 和 `bridge`，把它们接在一起，形成综合的模块。

### 端口定义

端口 | 类型 | 位宽 | 功能
--- | --- | --- | ---
`clk` | 输入 | 1 | 时钟信号
`rst` | 输入 | 1 | 复位信号

### 接线

CPU 和 `bridge` 的接线，除了 `clk` 和 `rst` 之外都是可以对应的。所以，可以列出对应关系表。

CPU 端口 | `bridge` 端口 | 数据流动方向
--- | --- | ---
`clk` | `clk` | 外部 → CPU 和 `bridge`
`rst` | `rst` | 外部 → CPU 和 `bridge`
`cpu_addr` | `addr` | CPU → `bridge`
`dev_write_enable` | `write_enable` | CPU → `bridge`
`cpu_write_data` | `write_data` | CPU → `bridge`
`cpu_read_result` | `read_result` | `bridge` → CPU
`hwirq` | `hwirq` | `bridge` → CPU

### 功能

顶层模块按照接线连接起 CPU 和 `bridge`，通过这种方式确定 CPU 和 `bridge` 之间数据流的流向。

