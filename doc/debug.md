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

不用手动写 `ifdef` 的判断代码，直接调用一个宏函数就行，最后预处理会处理掉的。同时，对正常情况下也要打印的数据（比如 `rf` 里的寄存器更新情况），在 debug 模式下加前缀。

#### Debug 相关宏函数的功能

打印 debug 消息时，若相应部件的 debug 模式开启，则打印相应的 debug 信息，附上部件名称和当前模拟的时刻。否则，就什么也不做。

打印正常情况下要打印的消息时，若相应部件的 debug 模式关闭，则原样打印消息。否则，在消息前面附加由部件名称和当时模拟的时刻，以及表示打印正常消息的前缀组成的更大的前缀。

打印两种消息使用两种函数。

#### Debug 相关宏函数的实现

Verilog 不支持宏函数的变个数参数，不像 C 语言有相应的机制。如果直接定义一个宏函数代替，没法做出跟 `$display` 等包含变个数参数的系统任务相似的、也支持变个数参数的宏函数。因此，需要使用一种 hack。

代码如下：

```verilog
`define debug_print(A) $write("%s", $sformatf A );
```

注意 `$sformatf A` 的 `A` 周围没有括号。这样，调用宏函数 `debug_print` 时补上括号即可。在预处理时，会自动把括号当成 `$sformatf` 周围的括号。

```verilog
`debug_print(("%d", 2 + 2));
```

注意这两个括号是必不可少的。这样，就可以定义类似的函数，来实现 debug 相关的宏函数。

同时，为了区别 debug 模式和正常模式，需要用到预处理时的对宏的条件判断。

### 注意事项

1. **调用 debug 打印相关宏时注意加两个括号！**

