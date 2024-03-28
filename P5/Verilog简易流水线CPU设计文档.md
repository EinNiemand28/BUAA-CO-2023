# Verilog简易流水线CPU设计文档

## CPU设计方案综述

### 总体设计概述

使用$\cal{Verilog}$开发一个32位$\cal{MIPS}$流水线处理器, $\cal{PC}$初始地址为`0x0000_3000`, 支持指令集为`add, sub, ori, lw, sw, beq, lui, jal, jr, nop`. 其中:

- `nop`为空指令, 机器码为`0x0000_0000`, 不进行任何有效行为
- `add, sub`为不考虑溢出的无符号加减法
- 支持延迟槽
- 采取集中式译码

### 关键模块定义

#### IFU

1. 端口定义

    |    信号名    | 方向 | 描述                                                         |
    | :----------: | :--: | :----------------------------------------------------------- |
    |     clk      |  I   | 时钟信号                                                     |
    |    reset     |  I   | 同步复位信号, 将PC置为0x00003000<br/>1: 复位信号有效<br/>0: 复位信号无效 |
    | NextPC[31:0] |  I   | 下一个PC值                                                   |
    |   PC[31:0]   |  O   | 当前PC值                                                     |
    | Instr[31:0]  |  O   | 当前指令(F级)                                                |

2. 功能定义

    | 序号 |   功能   | 描述                 |
    | :--: | :------: | :------------------- |
    |  1   |  取指令  | 取出当前PC对应的指令 |
    |  2   | 更新PC值 | PC <= NextPC         |

#### IFID

1. 端口定义

    |    信号名    | 方向 | 描述                                                         |
    | :----------: | :--: | :----------------------------------------------------------- |
    |     clk      |  I   | 时钟信号                                                     |
    |    reset     |  I   | 同步复位信号, 将IF/ID级寄存器清零<br/>1: 复位信号有效<br/>0: 复位信号无效 |
    | InstrF[31:0] |  I   | F级指令                                                      |
    |  PCF[31:0]   |  I   | F级PC值                                                      |
    | InstrD[31:0] |  O   | D级指令                                                      |
    |  PCD[31:0]   |  O   | D级PC值                                                      |

2. 功能定义

    | 序号 | 功能     | 描述                       |
    | ---- | -------- | :------------------------- |
    | 1    | 保存数据 | 存储Decode阶段所需要的内容 |

#### Controller

1. 端口定义

    |    信号名     | 方向 | 描述                                                         |
    | :-----------: | :--: | :----------------------------------------------------------- |
    |  Instr[31:0]  |  I   | 当前待译码指令                                               |
    |     Jump      |  O   | j/jal指令信号<br/>1: 信号有效<br/>0: 信号无效                |
    |      Jr       |  O   | jr指令信号<br/>1: Jr指令信号有效<br/>0: 无效                 |
    |  ALUOp[2:0]   |  O   | ALU功能选择信号                                              |
    |    ALUSrc     |  O   | ALU中SrcB端口数据选择信号<br/>1: 数据来自立即数扩展<br/>0: 数据来自GRF中的RD2 |
    |  SignExtend   |  O   | 16位立即数符号扩展信号<br/>1: 进行符号扩展<br/>0: 进行零扩展 |
    |   MemWrite    |  O   | DM写使能信号<br/>1: 可向DM中写入数据<br/>0: 不可写入数据     |
    |   RegWrite    |  O   | GRF写使能信号<br/>1: 可向GRF中写入数据<br/>0: 不可写入数据   |
    |  RegDst[4:0]  |  O   | 写入GRF寄存器的编号                                          |
    |  RegSrc[1:0]  |  O   | 写入GRF中数据选择信号<br/>00: 来自ALU<br/>01: 数据来自DM<br/>10: 数据来自PC4 (Jal) |
    | BranchOp[4:0] |  O   | B类跳转指令选择信号                                          |
    |    TuseRs     |  O   | 指令进入IF/ID寄存器后，其后的某个功能部件再经过多少cycle就必须要使用相应的寄存器值 |
    |    TuseRt     |  O   | 同上                                                         |

#### GRF

1. 端口定义

    |  信号名   | 方向 | 描述                                                         |
    | :-------: | :--: | :----------------------------------------------------------- |
    |    clk    |  I   | 时钟信号                                                     |
    |   reset   |  I   | 同步复位信号, 将32个寄存器中的值全部清零<br/>1: 复位信号有效<br/>0: 复位信号无效 |
    |    WE     |  I   | 写使能信号<br/>1: 可向GRF中写入数据<br/>0: 不能向GRF中写入数据 |
    |  A1[4:0]  |  I   | 5 位地址输入信号，指定 32 个寄存器中的一个，将其中存储的数据读出到RD1 |
    |  A2[4:0]  |  I   | 5 位地址输入信号，指定 32 个寄存器中的一个，将其中存储的数据读出到 RD2 |
    |  A3[4:0]  |  I   | 5位地址输入信号，指定 32 个寄存器中的一个作为写入的目标寄存器 |
    | WD[31:0]  |  I   | 写入数据信号                                                 |
    | PC[31:0]  |  I   | 写入指令对应PC值                                             |
    | RD1[31:0] |  O   | 输出A1指定的寄存器中的32位数据                               |
    | RD2[31:0] |  O   | 输出A2指定的寄存器中的32位数据                               |

2. 功能定义

    | 序号 | 功能   | 描述                                                         |
    | ---- | ------ | :----------------------------------------------------------- |
    | 1    | 复位   | 时钟信号处于信号上升沿且reset信号有效时, 将所有寄存器存储的数值清零 |
    | 2    | 读数据 | 读出A1, A2地址对应寄存器中所存储的数据到RD1, RD2             |
    | 3    | 写数据 | 读出A1, A2地址对应寄存器中所存储的数据到RD1, RD2             |
    | 4    | 转发   |                                                              |

    ```verilog
    //转发部分
    assign RD1 = ((A1 == A3) && A3 && WE) ? WD : grf[A1];
    assign RD2 = ((A2 == A3) && A3 && WE) ? WD : grf[A2];
    ```

#### EXT

1. 端口定义

    |   信号名    | 方向 | 描述                                                   |
    | :---------: | :--: | :----------------------------------------------------- |
    | imm16[15:0] |  I   | 待扩展的16位立即数                                     |
    |    ExtOp    |  I   | 扩展选择信号<br/>1: 进行符号扩展<br/>0: 进行无符号扩展 |
    | imm32[31:0] |  O   | 扩展后的32位立即数                                     |

2. 功能定义

    | 序号 | 功能       | 描述                               |
    | ---- | ---------- | :--------------------------------- |
    | 1    | 无符号扩展 | ExtOp = 0时, 对imm16进行无符号扩展 |
    | 2    | 符号扩展   | ExtOp = 1时, 对imm16进行符号扩展   |

#### BranchControl

1. 端口定义

    |    信号名     | 方向 | 描述                                                         |
    | :-----------: | :--: | :----------------------------------------------------------- |
    |   rs[31:0]    |  I   | 待比较操作数                                                 |
    |   rt[31:0]    |  I   | 同上                                                         |
    | BranchOp[4:0] |  I   | 表示是何种B类指令<br/>5'd1: bgez, bltz<br>5'd2: beq          |
    |     Judge     |  I   | 区分bgez, bltz<br/>1: Instr[20:16] = 00001<br/>0: Instr[20:16] = 00000 |
    |    Branch     |  O   | 判断跳转信号<br/>1: 跳转<br/>0: 不跳转                       |
    
1. 功能定义

    | 序号 | 功能         | 描述                                           |
    | ---- | ------------ | :--------------------------------------------- |
    | 1    | 产生跳转信号 | 判断当前跳转指令是否满足跳转条件并输出对应信号 |

#### NPC

1. 端口定义

    |     信号名      | 方向 | 描述                            |
    | :-------------: | :--: | :------------------------------ |
    |    PCF[31:0]    |  I   | F级PC值                         |
    |    PCD[31:0]    |  I   | D级PC值                         |
    |  Instr26[25:0]  |  I   | J/Jar指令的26位立即数           |
    |  Offset[31:0]   |  I   | B类跳转指令经过扩展的地址偏移量 |
    | RegToJump[31:0] |  I   | Jr指令跳转地址                  |
    |      Jump       |  I   | J/Jal指令信号                   |
    |       Jr        |  I   | Jr指令信号                      |
    |     Branch      |  I   | B类指令信号                     |
    |  NextPC[31:0]   |  O   | 下一个PC值                      |
    
1. 功能定义

    | 序号 | 功能         | 描述                           |
    | ---- | ------------ | :----------------------------- |
    | 1    | 计算NextPC值 | 根据当前指令和PC计算下一个PC值 |

#### IDEX

1. 端口定义

    | 信号名        | 方向 | 描述                                                         |
    | ------------- | ---- | :----------------------------------------------------------- |
    | clk           | I    | 时钟信号                                                     |
    | reset         | I    | 同步复位信号, 将ID/EX级寄存器清零<br/>1: 复位信号有效<br/>0: 复位信号无效 |
    | PCD[31:0]     | I    | D级PC值                                                      |
    | ALUOpD[2:0]   | I    | D级ALU功能选择信号                                           |
    | ALUSrcD       | I    | D级ALUALU中SrcB端口数据选择信号<br/>1: 数据来自立即数扩展<br/>0: 数据来自GRF中的RD2 |
    | MemWriteD     | I    | D级DM写使能信号<br>1: 可向DM中写入数据<br/>0: 不可写入数据   |
    | RegWriteD     | I    | D级GRF写使能信号<br/>1: 可向GRF中写入数据<br/>0: 不可写入数据 |
    | RegDstD[4:0]  | I    | D级写入GRF寄存器的编号                                       |
    | RegSrcD[1:0]  | I    | D级写入GRF中数据选择信号<br/>00: 来自ALU<br/>01: 数据来自DM<br/>10: 数据来自PC4 (Jal) |
    | RsD[4:0]      | I    | D级操作数                                                    |
    | RtD[4:0]      | I    | 同上                                                         |
    | ShamtD[4:0]   | I    | D级移位数                                                    |
    | OffsetD[31:0] | I    | D级32位扩展数                                                |
    | RD1D[31:0]    | I    | D级操作数对应寄存器的值                                      |
    | RD2D[31:0]    | I    | 同上                                                         |
    | PCE[31:0]     | O    |                                                              |
    | ALUOpE[2:0]   | O    |                                                              |
    | ALUSrcE       | O    |                                                              |
    | MemWriteE     | O    |                                                              |
    | RegWriteE     | O    |                                                              |
    | RegDstE[4:0]  | O    |                                                              |
    | RegSrcE[1:0]  | O    |                                                              |
    | RsE[4:0]      | O    |                                                              |
    | RtE[4:0]      | O    |                                                              |
    | ShamtE[4:0]   | O    |                                                              |
    | OffsetE[31:0] | O    |                                                              |
    | RD1E[31:0]    | O    |                                                              |
    | RD2E[31:0]    | O    |                                                              |
    
1. 功能定义

    | 序号 | 功能     | 描述                        |
    | ---- | -------- | :-------------------------- |
    | 1    | 保存数据 | 存储Execute阶段所需要的内容 |

#### ALU

1. 端口定义

    |    信号名    | 方向 | 描述                                                         |
    | :----------: | :--: | :----------------------------------------------------------- |
    |  SrcA[31:0]  |  I   | 参与运算的第一个数                                           |
    |  SrcB[31:0]  |  I   | 参与运算的第二个数                                           |
    |  Shamt[4:0]  |  I   | 移位数                                                       |
    |  ALUOp[2:0]  |  I   | 决定ALU所做操作类型<br/>000: 无符号加<br/>001: 无符号减<br/>010: 与<br/>011: 或<br/>100: 逻辑左移<br/>101: 加载SrcB至高位 |
    | Result[31:0] |  O   | 输出ALU计算结果                                              |

2. 功能定义

    | 序号 | 功能             | 描述                         |
    | ---- | ---------------- | :--------------------------- |
    | 1    | 无符号加         | Result = SrcA + SrcB         |
    | 2    | 无符号减         | Result = SrcA - SrcB         |
    | 3    | 与               | Result = SrcA & SrcB         |
    | 4    | 或               | Result = SrcA \| SrcB        |
    | 5    | 逻辑左移         | Result = SrcB << Shamt       |
    | 6    | 加载立即数至高位 | Result = {SrcB[15:0], 16'b0} |

#### EXME

1. 端口定义

    |      信号名      | 方向 | 描述                                                         |
    | :--------------: | :--: | :----------------------------------------------------------- |
    |       clk        |  I   | 时钟信号                                                     |
    |      reset       |  I   | 同步复位信号, 将EX/ME级寄存器清零<br/>1: 复位信号有效<br/>0: 复位信号无效 |
    |    PCE[31:0]     |  I   | E级PC值                                                      |
    |    RegWriteE     |  I   | E级GRF写使能信号<br/>1: 可向GRF中写入数据<br/>0: 不可写入数据 |
    |   RegSrcE[1:0]   |  I   | E级写入GRF中数据选择信号<br/>00: 来自ALU<br/>01: 数据来自DM<br/>10: 数据来自PC4 (Jal) |
    |   RegDstE[4:0]   |  I   | E级写入GRF寄存器的编号                                       |
    |  ResultE[31:0]   |  I   | E级ALU计算结果                                               |
    | WriteDataE[31:0] |  I   | E级写入DM数据信号                                            |
    |     RtE[4:0]     |  I   | E级操作数                                                    |
    |    MemWriteE     |  I   | E级DM写使能信号<br/>1: 可向DM中写入数据<br/>0: 不可写入数据  |
    |    PCM[31:0]     |  O   |                                                              |
    | RegWriteM[31:0]  |  O   |                                                              |
    |   RegSrcM[1:0]   |  O   |                                                              |
    |   RegDstM[4:0]   |  O   |                                                              |
    |  ResultM[31:0]   |  O   |                                                              |
    | WriteDataM[31:0] |  O   |                                                              |
    |     RtM[4:0]     |  O   |                                                              |
    |    MemWriteM     |  O   |                                                              |

2. 功能定义

    | 序号 | 功能     | 描述                       |
    | ---- | -------- | :------------------------- |
    | 1    | 保存数据 | 存储Memory阶段所需要的内容 |

#### DM

1. 端口定义

    |   信号名   | 方向 | 描述                                                   |
    | :--------: | :--: | :----------------------------------------------------- |
    |    clk     |  I   | 时钟信号                                               |
    |   reset    |  I   | 同步复位信号<br/>1: 复位信号有效<br/>0: 复位信号无效   |
    |     WE     |  I   | 写使能信号<br/>1: 可向DM中写入数据<br/>0: 不可写入数据 |
    | Addr[31:0] |  I   | 地址输入信号, 指向DM中某个存储单元                     |
    |  WD[31:0]  |  I   | 待写入的数据                                           |
    |  PC[31:0]  |  I   | 写入指令对应的PC值                                     |
    |  RD[31:0]  |  O   | 输出Addr指定的存储单元中的数据                         |

1. 功能定义

    | 序号 | 功能   | 描述                                                         |
    | ---- | ------ | :----------------------------------------------------------- |
    | 1    | 复位   | 时钟信号处于上升沿且reset信号有效时, 将DM存储的数据清零      |
    | 2    | 读数据 | p读出Addr地址对应的存储单元中的数据到RD                      |
    | 3    | 写数据 | 当WE 有效且时钟上升沿来临时,将 WD 写入Addr地址所对应的存储单元中 |

#### MEWB

1. 端口定义

    |     信号名      | 方向 | 描述                                                         |
    | :-------------: | :--: | :----------------------------------------------------------- |
    |       clk       |  I   | 时钟信号                                                     |
    |      reset      |  I   | 同步复位信号, 将ME/WB级寄存器清零<br/>1: 复位信号有效<br/>0: 复位信号无效 |
    |    PCM[31:0]    |  I   | M级PC值                                                      |
    |    RegWriteM    |  I   | M级GRF写使能信号<br/>1: 可向GRF中写入数据<br/>0: 不可写入数据 |
    |  RegSrcM[1:0]   |  I   | M级写入GRF中数据选择信号<br/>00: 来自ALU<br/>01: 数据来自DM<br/>10: 数据来自PC4 (Jal) |
    |  RegDstM[4:0]   |  I   | M级写入GRF寄存器的编号                                       |
    | ReadDataM[31:0] |  I   | M级从DM中读出的数据                                          |
    |  ResultM[31:0]  |  I   | M级ALU计算结果                                               |
    |    PCW[31:0]    |  O   |                                                              |
    |    RegWriteW    |  O   |                                                              |
    |  RegSrcW[1:0]   |  O   |                                                              |
    |  RegDstW[4:0]   |  O   |                                                              |
    | ReadDataW[31:0] |  O   |                                                              |
    |  ResultW[31:0]  |  O   |                                                              |
    
1. 功能定义

    | 序号 | 功能     | 描述                          |
    | ---- | -------- | :---------------------------- |
    | 1    | 保存数据 | 存储WriteBack阶段所需要的内容 |

### 转发与暂停

#### 暂停

> >Tuse(time-to-use): 指令进入IF/ID寄存器后，其后的某个功能部件再经过多少cycle就必须要使用相应的寄存器值
> >
> >Tnew(time-to-new): 位于ID/EX及其后各流水段的指令，再经过多少周期能够产生要写入寄存器的结果(TnewW均为0)
> >
> >---------------------
> >
> >Tuse和Tnew的值可以在$\cal{Controller}$中译码对应得出，然后让Tnew流水，逐级减小即可
> >
> >-----
> >
> >```verilog
> >wire Stall = StallRsE || StallRtE || StallRsM || StallRtM;
> >```
> >
> >同时要把暂停信号传入$\cal{ID/EX}$级流水寄存器的复位信号端口

| 指令 | TuseRs | TuseRt | TnewE | TnewM |
| ---- | ------ | ------ | ----- | ----- |
| addu | 1      | 1      | 1     | 0     |
| subu | 1      | 1      | 1     | 0     |
| ori  | 1      | -      | 1     | 0     |
| sll  | 1      | 1      | 1     | 0     |
| lui  | 1      | -      | 1     | 0     |
| lw   | 1      | -      | 2     | 1     |
| sw   | 1      | 2      | -     | -     |
| beq  | 0      | 0      | -     | -     |
| jal  | -      | -      | 0     | 0     |
| jr   | 0      | -      | -     | -     |
| j    | -      | -      | -     | -     |

```verilog
wire StallRsE = (RegDstE == InstrD[25:21]) && (RegDstE != 0) && RegWriteE && (TuseRs < TnewE);
wire StallRtE = (RegDstE == InstrD[20:16]) && (RegDstE != 0) && RegWriteE && (TuseRt < TnewE);
/*-----------EX/ME-------------*/
wire StallRsM = (RegDstM == InstrD[25:21]) && (RegDstM != 0) && RegWriteM && (TuseRs < TnewM);
wire StallRtM = (RegDstM == InstrD[20:16]) && (RegDstM != 0) && RegWriteM && (TuseRt < TnewM);
```



#### 条件转发(包括GRF内部转发)

```verilog
wire [31:0] ForwardRsD = (InstrD[25:21] == 0) ? 0 :
            ((RegDstE == InstrD[25:21]) && RegWriteE && ForwardE) ? WriteRegE :
            ((RegDstM == InstrD[25:21]) && RegWriteM && ForwardM) ? WriteRegM : RD1D;
wire [31:0] ForwardRtD = (InstrD[20:16] == 0) ? 0 :
            ((RegDstE == InstrD[20:16]) && RegWriteE && ForwardE) ? WriteRegE :
            ((RegDstM == InstrD[20:16]) && RegWriteM && ForwardM) ? WriteRegM : RD2D;
/*-----------ID/EX-------------*/
wire [31:0] WriteRegE = (RegSrcE == 2'b10) ? PCE + 8 : 0;
wire ForwardE = (TnewE == 2'b00);
//要写入的结果准备好了才转发
wire [31:0] ForwardRsE = (RsE == 0) ? 0 :
            ((RegDstM == RsE) && RegWriteM && ForwardM) ? WriteRegM : 
            ((RegDstW == RsE) && RegWriteW && ForwardW) ? WriteRegW : RD1E;
wire [31:0] ForwardRtE = (RtE == 0) ? 0 :
            ((RegDstM == RtE) && RegWriteM && ForwardM) ? WriteRegM :
            ((RegDstW == RtE) && RegWriteW && ForwardW) ? WriteRegW : RD2E;
/*-----------EX/ME-------------*/
wire [31:0] WriteRegM = (RegSrcM == 2'b10) ? PCM + 8 :
                        (RegSrcM == 2'b00) ? ResultM : 0;
wire ForwardM = (TnewM == 2'b00);
wire [31:0] ForwardWriteDataM = (RtM == 0) ? 0 :
            ((RtM == RegDstW) && RegWriteW && ForwardW) ? WriteRegW : WriteDataM;
/*-----------ME/WB-------------*/
wire ForwardW = 1'b1;
wire [31:0] WriteRegW = (RegSrcW == 2'b10) ? PCW + 8 :
                        (RegSrcW == 2'b01) ? ReadDataW : ResultW;
```

## 测试方案

### 姜涵章同学的coKiller

![image-20231119213053269](C:\Users\pengzhengyu\AppData\Roaming\Typora\typora-user-images\image-20231119213053269.png)

![image-20231119213347381](C:\Users\pengzhengyu\AppData\Roaming\Typora\typora-user-images\image-20231119213347381.png)

![image-20231119213403359](C:\Users\pengzhengyu\AppData\Roaming\Typora\typora-user-images\image-20231119213403359.png)



## 思考题

1. 我们使用提前分支判断的方法尽早产生结果来减少因不确定而带来的开销，但实际上这种方法并非总能提高效率，请从流水线冒险的角度思考其原因并给出一个指令序列的例子。

    > >```assembly
    > >label:
    > >add		$t0, $t0, $t1
    > >beq		$t0, $t1, label
    > >```
    > >
    > >例如这个例子, 提前分支判断导致原本转发可以解决的冲突需要暂停一个周期.

2. 因为延迟槽的存在，对于 jal 等需要将指令地址写入寄存器的指令，要写回 PC + 8，请思考为什么这样设计？

    > > 延迟槽的存在会使jal等跳转指令的下一条指令随之执行, 故使用jr等指令返回时, 需跳至再下一条指令, 即PC + 8对应的指令.

3. 我们要求所有转发数据都来源于流水寄存器而不能是功能部件（如 DM、ALU），请思考为什么？

    > >比较统一直观.

4. 我们为什么要使用 GPR 内部转发？该如何实现？

    > > GRF内部转发即为$\cal{WB \to ID}$​的转发.
    > >
    > > ```verilog
    > > assign RD1 = ((A1 == A3) && A3 && WE) ? WD : grf[A1];
    > > assign RD2 = ((A2 == A3) && A3 && WE) ? WD : grf[A2];
    > > ```

5. 我们转发时数据的需求者和供给者可能来源于哪些位置？共有哪些转发数据通路？

    > > 需求者: $\cal{BranchControl}$的两个操作数, $\cal{ALU}$的两个操作数, $\cal{DM}$的WD端口.
    > >
    > > 供给者: $\cal{ID/EX、EX/ME、ME/WB}$级流水寄存器.
    > >
    > > 数据通路：
    > >
    > > ​	$\cal{ID/EX} \to BranchControl$
    > >
    > > ​	$\cal{EX/ME} \to BranchControl$
    > >
    > > ​	$\cal{ME/WB} \to BranchControl$
    > >
    > > ​	$\cal{EX/ME} \to ALU$
    > >
    > > ​	$\cal{ME/WB} \to ALU$
    > >
    > > ​	$\cal{ME/WB} \to DM$

6. 在课上测试时，我们需要你现场实现新的指令，对于这些新的指令，你可能需要在原有的数据通路上做哪些扩展或修改？提示：你可以对指令进行分类，思考每一类指令可能修改或扩展哪些位置。

    > >计算: 在$\cal{Controller}$中加入新的ALUOp信号, 并在$\cal{ALU}$完成相应方法.
    > >
    > >跳转: 在$\cal{Controller}$中加入新的BranchOp信号, 并在$\cal{BranchControl}$完成相应方法.
    > >
    > >访存: 在$\cal{Controller}$中加入新的MemOp信号, 并在$\cal{DM}$完成相应方法.
    > >
    > >同时均需处理转发和暂停问题.

7. 简要描述你的译码器架构，并思考该架构的优势以及不足。

    > >我采用的是集中式译码器, 优势在于不需要多次实例化译码器模块, 避免资源浪费和冗长的数据通路.
    > >
    > >不足之处在于需要将控制信号进行流水, 还需处理Tnew随流水减少的问题.
