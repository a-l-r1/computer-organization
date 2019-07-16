## Debug 机制

### 打印 debug 信息

由 debug 机制控制，通过设定一个有 `varargs` 的函数实现。

TODO: 怎么用 `varargs`？

### 文件中的打印宏

把它 wrap 起来，这样就能把 debug 信息和正常信息区分开

### 打开和关闭 debug 模式

可以使用 `ifdef`

```Verilog
`ifdef DEBUG
`define debug_print xxx
/* ... */
`else
`define debug_print xxx_stub
/* ... */
`endif /* DEBUG */
```

### 译码机制

可以考虑内置简单的 disassembler，当然直接 `%08x` 打出来也行

### 流水线的 debug

prefix 里应该要有级，记得在各个部件里加上

### Debug 宏的分层

分成 `DEBUG_ALU`，`DEBUG_IM` 等等，然后设上 `DEBUG`

记得在每个模块里实现

### Debug 宏的用法

不用管 `ifdef`，直接调用一个函数就行，最后预处理会处理掉的

