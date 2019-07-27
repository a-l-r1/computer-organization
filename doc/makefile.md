## Makefile

### 概述

Makefile 主要是为了自动化一些命令，省去繁琐的人工操作，提高可用性才用的。

Makefile 分多种目标，主要是给 Linux 下面的 GNU Make 用的。但是 `pypi` 里有个 `pymake`，可以勉强让 Windows 也用上 Make。

TODO: 把这个 Makefile 移植到 `pymake` 上。

### `all` 目标

TODO

“所有的事”是哪些事？现在还不知道。

### `code` 目标

用 `tools/mips-as.py` 把每个 CPU 设计阶段的 `asm` 文件编译成合适位置的 `code.hex` 文件。

### `clean-release` 目标

TODO

把不符合考试要求的一些文件（比如脚本文件等）删掉，并且编译设计文档，形成适合带到考场的 tarball。

### `test` 目标

TODO

自动进行测试，根据当前的 CPU 设计阶段，而且自动对拍，并使用 `colordiff` 工具彩色输出。

测试时可能不用 iSim，而是使用 Linux 下面的 `iverilog`，具体视平台而定。

### `lint` 目标

TODO

检查一些必要的语法是不是已经遵守了。使用脚本进行检查。

