## 汇编语言总结

### 调试不出来怎么办

1. Don't panic!
2. TLE 时首先尝试优化算法
3. 想算法的流程
4. 用边界例子、特殊例子测试

### 汇编语言注意事项

1. **尽量让语义明确，汇编语言本身够晦涩的了**
2. **跳转指令后面必须有 `nop`**
3. **临时寄存器必须保证现用现写现抛弃**
4. **把语句按照语义分块**
5. **先把 `push, pop, save_regs, restore_regs` 等宏准备好**

