# 计组编码哲学

## **手足无措时做什么**

1. Don't panic!
2. 测试的时候把调试打开，不测试的时候把调试观赏
3. 深呼吸，专心想调试的事情
4. 看看哪里的逻辑出错了，**不要逃避！**
5. 稳定心态，做出来是最重要的

## 编码风格

### 大小写

统一用 Linux 式风格，全小写，单词间用下划线隔开。也就是 `function_name` ，而不是 `functionName` 或者 `FunctionName`

### 对象命名

#### 部件

```
pc, npc, rf, alu, ext, im, dm, bridge, cp0
```

#### 宏命名格式

用 Linux 式风格，全大写，单词间用下划线隔开。

#### 转发命名格式

```
fm_level_part_port
```

`fm` 就是 forward muxer 的意思

### 代码结构

1. 模块一定要在输入输出端口时明确指出 `input` 还是 `output`
2. 每个端口占一行，好改
3. 每个代码放在单独的代码文件中
4. 尽量复用代码，用现成的模块
5. 尽量避免魔数，能够用宏定义的地方就要用宏定义，尤其是用类似 enum 的东西的时候

### ALU

#### 命名格式

宏：`ALU_FUNC`

## 文件 hierarchy

### 根目录

目录 | 功能
`bin` | 二进制文件
`doc` | 相关文档
`.gitignore` | `git` 忽略文件
`src` | 源代码本身
`project` | ISE 用到的项目文件
`tests` | 自动化测试
`tmp` | 临时文件
`tools` | 用到的工具，非二进制文件
`output` | 输出文件
`export` | 导出文件，发布时要用

### `src` 目录

目录 | 功能
`datapath` | 数据通路
`control` | 控制
`common` | 通用文件
`common/debug` | 调试相关代码
