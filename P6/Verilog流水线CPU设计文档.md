# Verilog流水线CPU设计文档

## CPU设计方案综述

### 总体设计概述

使用$\cal{Verilog}$开发一个32位$\cal{MIPS}$流水线处理器, $\cal{PC}$初始地址为`0x0000_3000`, 支持如下指令集:

```
add, sub, and, or, sll, slt, sltu, lui
addi, andi, ori
lb, lh, lw, sb, sh, sw
mult, multu, div, divu, mfhi, mflo, mthi, mtlo
beq, bne, bgez, bltz, jal, jr, j
nop
```

其中

- `nop`为空指令, 机器码为`0x0000_0000`, 不进行任何有效行为
- `add, sub`为不考虑溢出的无符号加减法
- 采取集中式译码
- 支持延迟槽，存储器外置，有单独的乘除法模块和数据扩展模块

### 顶层模块规格

#### 接口定义

```verilog
module mips (
    input wire clk,
    input wire reset,
    input wire [31:0] i_inst_rdata,
    output wire [31:0] i_inst_addr,
    input wire [31:0] m_data_rdata,
    output wire [31:0] m_data_addr,
    output wire [31:0] m_data_wdata,
    output wire [3:0] m_data_byteen,
    output wire [31:0] m_inst_addr,
    output wire w_grf_we,
    output wire [4:0] w_grf_addr,
    output wire [31:0] w_grf_wdata,
    output wire [31:0] w_inst_addr
);
```
#### 详细含义

| 信号名              | 方向 | 描述                         |
| ------------------- | ---- | :--------------------------- |
| clk                 | I    | 时钟信号                     |
| reset               | I    | 同步复位信号                 |
| i_inst_rdata [31:0] | I    | i_inst_addr 对应的 32 位指令 |
| m_data_rdata [31:0] | I    | m_data_addr 对应的 32 位数据 |
| i_inst_addr [31:0]  | O    | 需要进行取指操作的流水级 PC  |
| m_data_addr [31:0]  | O    | 数据存储器待写入地址         |
| m_data_wdata [31:0] | O    | 数据存储器待写入数据         |
| m_data_byteen [3:0] | O    | 字节使能信号                 |
| m_inst_addr [31:0]  | O    | M 级 PC                      |
| w_grf_we            | O    | GRF 写使能信号               |
| w_grf_addr [4:0]    | O    | GRF 中待写入寄存器编号       |
| w_grf_wdata [31:0]  | O    | GRF 中待写入数据             |
| w_inst_addr [31:0]  | O    | W 级 PC                      |

### 关键模块定义

#### IFU

1. 端口定义

    | 信号名       | 方向 | 描述                                                         |
    | ------------ | ---- | :----------------------------------------------------------- |
    | clk          | I    | 时钟信号                                                     |
    | reset        | I    | 同步复位信号, 将PC置为0x00003000<br/>1: 复位信号有效<br/>0: 复位信号无效 |
    | WE           | I    | 取指使能信号                                                 |
    | NextPC[31:0] | I    | 下一个PC值                                                   |
    | PC[31:0]     | O    | 当前PC值                                                     |

2. 功能定义

    | 序号 | 功能     | 描述         |
    | ---- | -------- | :----------- |
    | 1    | 更新PC值 | PC <= NextPC |

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
    |  ALUOp[3:0]   |  O   | ALU功能选择信号                                              |
    |  MDUOp[3:0]   |  O   | MDU功能选择信号                                              |
    |  MemOp[3:0]   |  O   | 存储功能选择信号                                             |
    |  SignExtend   |  O   | 16位立即数符号扩展信号<br/>1: 进行符号扩展<br/>0: 进行零扩展 |
    |   MemWrite    |  O   | DM写使能信号<br/>1: 可向DM中写入数据<br/>0: 不可写入数据     |
    |   RegWrite    |  O   | GRF写使能信号<br/>1: 可向GRF中写入数据<br/>0: 不可写入数据   |
    |  RegDst[4:0]  |  O   | 写入GRF寄存器的编号                                          |
    |  RegSrc[1:0]  |  O   | 写入GRF中数据选择信号<br/>00: 来自ALU<br/>01: 数据来自DM<br/>10: 数据来自PC4 (Jal) |
    |    ALUSrc     |  O   | ALU中SrcB端口数据选择信号<br/>1: 数据来自立即数扩展<br/>0: 数据来自GRF中的RD2 |
    | BranchOp[3:0] |  O   | B类跳转指令选择信号                                          |
    |  TuseRs[1:0]  |  O   | 指令进入IF/ID寄存器后，其后的某个功能部件再经过多少cycle就必须要使用相应的寄存器值 |
    |  TuseRt[1:0]  |  O   | 同上                                                         |
    |   Tnew[1:0]   |  O   | 指令再经过多少cycle才能产生要写入某个寄存器的值              |
    |     Start     |  O   | MDU开启信号                                                  |
    |    HIRead     |  O   | 读HI寄存器信号                                               |
    |    HIWrite    |  O   | 写HI信号                                                     |
    |    LORead     |  O   | 读LO信号                                                     |
    |    LOWrite    |  O   | 写LO信号                                                     |
    |   MDUStall    |  O   | 当前指令是否会引发由MDU导致的暂停操作                        |

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

    | 序号 | 功能     | 描述                                                         |
    | ---- | -------- | :----------------------------------------------------------- |
    | 1    | 复位     | 时钟信号处于信号上升沿且reset信号有效时, 将所有寄存器存储的数值清零 |
    | 2    | 读数据   | 读出A1, A2地址对应寄存器中所存储的数据到RD1, RD2             |
    | 3    | 写数据   | 读出A1, A2地址对应寄存器中所存储的数据到RD1, RD2             |
    | 4    | 转发数据 | 当满足转发条件时, 将WD中的数据作为RD1或RD2的输出             |

    ```verilog
    //转发部分
    assign RD1 = ((A1 == A3) && A3 && WE) ? WD : grf[A1];
    assign RD2 = ((A2 == A3) && A3 && WE) ? WD : grf[A2];
    ```

#### EXT

1. 端口定义

    | 信号名      | 方向 | 描述                                                   |
    | ----------- | ---- | :----------------------------------------------------- |
    | imm16[15:0] | I    | 待扩展的16位立即数                                     |
    | ExtOp       | I    | 扩展选择信号<br/>1: 进行符号扩展<br/>0: 进行无符号扩展 |
    | imm32[31:0] | O    | 扩展后的32位立即数                                     |

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
    | BranchOp[3:0] |  I   | 表示是何种B类指令<br/>5'd1: bgez, bltz<br>5'd2: beq<br />5'd3: bne |
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
    | ALUOpD[3:0]   | I    | D级ALU功能选择信号                                           |
    | MDUOpD[3:0]   | I    | D级MDU功能选择信号                                           |
    | MemOpD[3:0]   | I    | D级数据存储器功能选择信号                                    |
    | ALUSrcD       | I    | D级ALUALU中SrcB端口数据选择信号<br/>1: 数据来自立即数扩展<br/>0: 数据来自GRF中的RD2 |
    | MemWriteD     | I    | D级DM写使能信号<br>1: 可向DM中写入数据<br/>0: 不可写入数据   |
    | RegWriteD     | I    | D级GRF写使能信号<br/>1: 可向GRF中写入数据<br/>0: 不可写入数据 |
    | StartD        | I    | D级MDU开启信号                                               |
    | HIReadD       | I    | D级读HI寄存器信号                                            |
    | HIWriteD      | I    | D级写HI寄存器信号                                            |
    | LOReadD       | I    | D级读LO寄存器信号                                            |
    | LOWriteD      | I    | D级写LO寄存器信号                                            |
    | TnewD[1:0]    | I    | 指令在E级时还需多少cycle才能产生可以写入寄存器的值           |
    | RegDstD[4:0]  | I    | D级写入GRF寄存器的编号                                       |
    | RegSrcD[1:0]  | I    | D级写入GRF中数据选择信号<br/>00: 来自ALU<br/>01: 数据来自DM<br/>10: 数据来自PC4 (Jal) |
    | RsD[4:0]      | I    | D级操作数                                                    |
    | RtD[4:0]      | I    | 同上                                                         |
    | ShamtD[4:0]   | I    | D级移位数                                                    |
    | OffsetD[31:0] | I    | D级32位扩展数                                                |
    | RD1D[31:0]    | I    | D级操作数对应寄存器的值                                      |
    | RD2D[31:0]    | I    | 同上                                                         |
    | PCE[31:0]     | O    |                                                              |
    | ALUOpE[3:0]   | O    |                                                              |
    | MDUOpE[3:0]   | O    |                                                              |
    | MemOpE[3:0]   | O    |                                                              |
    | ALUSrcE       | O    |                                                              |
    | MemWriteE     | O    |                                                              |
    | RegWriteE     | O    |                                                              |
    | StartE        | O    |                                                              |
    | HIReadE       | O    |                                                              |
    | HIWriteE      | O    |                                                              |
    | LOReadE       | O    |                                                              |
    | LOWriteE      | O    |                                                              |
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
    |  ALUOp[3:0]  |  I   | 决定ALU所做操作类型<br/>4'd0: 无符号加<br/>4'd1: 无符号减<br/>4'd2: 与<br/>4'd3: 或<br/>4'd4: 逻辑左移<br/>4'd5: 加载SrcB至高位<br />4'd6: 小于置1<br />4‘d7: 小于置1(无符号) |
    | Result[31:0] |  O   | 输出ALU计算结果                                              |

2. 功能定义

    | 序号 | 功能             | 描述                                                     |
    | ---- | ---------------- | :------------------------------------------------------- |
    | 1    | 无符号加         | Result = SrcA + SrcB                                     |
    | 2    | 无符号减         | Result = SrcA - SrcB                                     |
    | 3    | 与               | Result = SrcA & SrcB                                     |
    | 4    | 或               | Result = SrcA \| SrcB                                    |
    | 5    | 逻辑左移         | Result = SrcB << Shamt                                   |
    | 6    | 加载立即数至高位 | Result = {SrcB[15:0], 16'b0}                             |
    | 7    | 小于置1          | Result = (\$signed(SrcA) < \$signed(SrcB)) ? 1'b1 : 1'b0 |
    | 8    | 小于置1(无符号)  | Result = (SrcA < SrcB) ? 1'b1 : 1'b0                     |

#### MDU

1. 端口定义

    | 信号名       | 方向 | 描述                                                         |
    | ------------ | ---- | :----------------------------------------------------------- |
    | clk          | I    | 时钟信号                                                     |
    | reset        | I    | 同步复位信号<br/>1: 复位信号有效<br/>0: 复位信号无效         |
    | SrcA[31:0]   | I    | 参与运算的第一个数                                           |
    | SrcB[31:0]   | I    | 参与运算的第二个数                                           |
    | Start        | I    | 乘除法运算启动信号                                           |
    | MDUOp[3:0]   | I    | 决定MDU所执行操作类型<br />4'd0: 符号乘<br />4'd1: 无符号乘<br />4'd2: 符号除<br />4'd3: 无符号除 |
    | HIWrite      | I    | 读HI寄存器信号                                               |
    | LOWrite      | I    | 读LO寄存器信号                                               |
    | HIRead       | I    | 写HI寄存器信号                                               |
    | LORead       | I    | 写LO寄存器信号                                               |
    | Busy         | O    | 模拟乘除法延迟信号                                           |
    | Result[31:0] | O    | 输出从HI或LO寄存器中读出的值                                 |

2. 功能定义

    | 序号 | 功能             | 描述                                                         |
    | ---- | ---------------- | :----------------------------------------------------------- |
    | 1    | 符号乘           | {RegHI, RegLO} <= \$signed(SrcA) * \$signed(SrcB)            |
    | 2    | 无符号乘         | {RegHI, RegLO} <= SrcA * SrcB                                |
    | 3    | 符号除           | RegLO <= \$signed(SrcA) / \$signed(SrcB)<br />RegHI <= \$signed(SrcA) % \$signed(SrcB) |
    | 4    | 无符号除         | RegLO <= SrcA / SrcB<br />RegHI <= SrcA % SrcB               |
    | 5    | 读写HI、LO寄存器 | 读: mfhi, mflo<br />写: mthi, mtlo                           |

#### EXME

1. 端口定义

    |      信号名      | 方向 | 描述                                                         |
    | :--------------: | :--: | :----------------------------------------------------------- |
    |       clk        |  I   | 时钟信号                                                     |
    |      reset       |  I   | 同步复位信号, 将EX/ME级寄存器清零<br/>1: 复位信号有效<br/>0: 复位信号无效 |
    |   MemOpE[3:0]    |  I   | E级存储器功能选择信号                                        |
    |    PCE[31:0]     |  I   | E级PC值                                                      |
    |    RegWriteE     |  I   | E级GRF写使能信号<br/>1: 可向GRF中写入数据<br/>0: 不可写入数据 |
    |    TnewE[1:0]    |  I   | 指令在E级时还需多少cycle产生写入寄存器值                     |
    |   RegSrcE[1:0]   |  I   | E级写入GRF中数据选择信号<br/>00: 来自ALU<br/>01: 数据来自DM<br/>10: 数据来自PC4 (Jal) |
    |   RegDstE[4:0]   |  I   | E级写入GRF寄存器的编号                                       |
    |  ResultE[31:0]   |  I   | E级ALU计算结果                                               |
    | WriteDataE[31:0] |  I   | E级写入DM数据信号                                            |
    |     RtE[4:0]     |  I   | E级操作数                                                    |
    |    MemWriteE     |  I   | E级DM写使能信号<br/>1: 可向DM中写入数据<br/>0: 不可写入数据  |
    |   MemOpM[3:0]    |  O   |                                                              |
    |    PCM[31:0]     |  O   |                                                              |
    | RegWriteM[31:0]  |  O   |                                                              |
    |    TnewM[1:0]    |  O   | TnewM <= max{2'b00, TnewE - 1}                               |
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

#### BE

1. 端口定义

    | 信号名     | 方向 | 描述                                                         |
    | ---------- | ---- | :----------------------------------------------------------- |
    | A[1:0]     | I    | 最低两位的地址                                               |
    | Din[31:0]  | I    | DM读出数据                                                   |
    | Op[2:0]    | O    | 数据扩展控制码<br />3'b000: 无扩展<br />3'b001: 符号半字数据扩展<br />3'b010: 无符半字数据扩展<br />3'b011: 符号字节数据扩展<br />3'b100: 无符号字节数据扩展 |
    | Dout[31:0] | O    | 扩展后的 32 位数据                                           |

2. 功能定义

    | 序号 | 功能     | 描述                                              |
    | ---- | -------- | :------------------------------------------------ |
    | 1    | 数据扩展 | 根据Op和A的值对数据进行相应扩展, 使其符合指令行为 |

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

### 转发和暂停

#### 暂停

> >Tuse(time-to-use): 指令进入IF/ID寄存器后，其后的某个功能部件再经过多少cycle就必须要使用相应的寄存器值
> >
> >Tnew(time-to-new): 位于ID/EX及其后各流水段的指令，再经过多少周期能够产生要写入寄存器的结果(遂流水逐级减小, 且TnewW均为0)
> >
> >```verilog
> >assign TuseRs = (Addu || Subu || And || Or || Sll || Slt || Sltu ||
> >                 Addi || Andi || Ori || Lui ||
> >                 Mult || Multu || Div || Divu ||
> >                 Mthi || Mtlo ||
> >                 Lb || Lh || Lw ||
> >                 Sb || Sh || Sw) ? 2'b01 : 
> >                (Jr || (BranchOp != 0)) ? 2'b00 : 2'b11;
> >assign TuseRt = (Sb || Sh || Sw) ? 2'b10 :
> >                (Addu || Subu || And || Or || Sll || Slt || Sltu ||
> >                 Mult || Multu || Div || Divu) ? 2'b01 :
> >                (BranchOp != 0) ? 2'b00 : 2'b11;
> >assign Tnew = (Lb || Lh || Lw) ? 2'b10 :
> >              (Addu || Subu || And || Or || Sll || Slt || Sltu ||
> >               Addi || Andi || Ori || Lui ||
> >               Mfhi || Mflo) ? 2'b01 : 2'b00;
> >```
> >
> >-----
> >
> >乘除模块可能导致的暂停:
> >
> >```verilog
> >assign MDUStall = Mult || Multu || Div || Divu ||
> >                  Mfhi || Mflo || Mthi || Mtlo;
> >assign StallMDU = Busy && MDUStall;
> >```
> >
> >----
> >
> >最后把暂停信号传入$\cal{ID/EX}$级流水寄存器的复位信号端口
> >
> >```verilog
> >wire Stall = StallRsE || StallRtE || StallRsM || StallRtM || StallMDU;
> >/*------------------------------------------------*/
> >wire StallRsE = (RegDstE == InstrD[25:21]) && (RegDstE != 0) && RegWriteE && (TuseRs < TnewE);
> >wire StallRtE = (RegDstE == InstrD[20:16]) && (RegDstE != 0) && RegWriteE && (TuseRt < TnewE);
> >/*-----------EX/ME-------------*/
> >wire StallRsM = (RegDstM == InstrD[25:21]) && (RegDstM != 0) && RegWriteM && (TuseRs < TnewM);
> >wire StallRtM = (RegDstM == InstrD[20:16]) && (RegDstM != 0) && RegWriteM && (TuseRt < TnewM);
> >```

#### 条件转发(包括GRF内部转发)

> >要写入寄存器的值准备好了才可以转发
> >
> >```verilog
> >wire ForwardE = (TnewE == 2'b00);
> >wire [31:0] WriteRegE = (RegSrcE == 2'b10) ? PCE + 8 : 0;
> >wire ForwardM = (TnewM == 2'b00);
> >wire [31:0] WriteRegM = (RegSrcM == 2'b10) ? PCM + 8 :
> >                        (RegSrcM == 2'b00 || RegSrcM == 2'b11) ? ResultM : 0;
> >wire ForwardW = 1'b1;
> >wire [31:0] WriteRegW = (RegSrcW == 2'b10) ? PCW + 8 :
> >                        (RegSrcW == 2'b01) ? ReadDataW : ResultW;
> >```
> >
> >------
> >
> >接收
> >```verilog
> >wire [31:0] ForwardRsD = (InstrD[25:21] == 0) ? 0 :
> >            ((RegDstE == InstrD[25:21]) && RegWriteE && ForwardE) ? WriteRegE :
> >            ((RegDstM == InstrD[25:21]) && RegWriteM && ForwardM) ? WriteRegM : RD1D;
> >wire [31:0] ForwardRtD = (InstrD[20:16] == 0) ? 0 :
> >            ((RegDstE == InstrD[20:16]) && RegWriteE && ForwardE) ? WriteRegE :
> >            ((RegDstM == InstrD[20:16]) && RegWriteM && ForwardM) ? WriteRegM : RD2D;
> >/*-----------ID/EX-------------*/
> >wire [31:0] ForwardRsE = (RsE == 0) ? 0 :
> >            ((RegDstM == RsE) && RegWriteM && ForwardM) ? WriteRegM : 
> >            ((RegDstW == RsE) && RegWriteW && ForwardW) ? WriteRegW : RD1E;
> >wire [31:0] ForwardRtE = (RtE == 0) ? 0 :
> >            ((RegDstM == RtE) && RegWriteM && ForwardM) ? WriteRegM :
> >            ((RegDstW == RtE) && RegWriteW && ForwardW) ? WriteRegW : RD2E;
> >/*-----------EX/ME-------------*/
> >wire [31:0] ForwardWriteDataM = (RtM == 0) ? 0 :
> >            ((RtM == RegDstW) && RegWriteW && ForwardW) ? WriteRegW : WriteDataM;
> >```

## 测试方案

### 姜涵章同学的coKiller

![image-20231202215255005](C:\Users\pengzhengyu\AppData\Roaming\Typora\typora-user-images\image-20231202215255005.png)

![image-20231202215318265](C:\Users\pengzhengyu\AppData\Roaming\Typora\typora-user-images\image-20231202215318265.png)

## 思考题

1. 为什么需要有单独的乘除法部件而不是整合进 ALU？为何需要有独立的 HI、LO 寄存器？

    > >因为乘除法计算过程是有延迟的, 并且在课程CPU的设计中以时序逻辑来模拟这一延迟, 为了使其他计算指令能在运算延迟的过程中正常使用ALU, 我们需要将乘除法部件独立出来. $\cal{HI,LO}$寄存器并不是通用寄存器, 而是用来存放乘除法的结果, 同时也为了使乘除法运算尽可能不阻塞其他指令, 所以我们需要独立的$\cal{HI,LO}$.

2. 真实的流水线 CPU 是如何使用实现乘除法的？请查阅相关资料进行简单说明。

    > >二进制乘法的特点是可以将乘法转化为移位, 乘$2^n$就是左移$n$位, 故可以用移位器和加法器实现乘法操作. 于是可以串行计算或者采用多级流水线的形式进行计算.
    > >
    > >除法则类似, 可以使用移位和减法操作实现.

3. 请结合自己的实现分析，你是如何处理 Busy 信号带来的周期阻塞的？

    > >当$\cal{Busy}$信号为高电平, 且当前指令为乘除法相关指令时, 产生阻塞信号.
    > >
    > >```verilog
    > >assign MDUStall = Mult || Multu || Div || Divu ||
    > >             Mfhi || Mflo || Mthi || Mtlo;
    > >assign StallMDU = Busy && MDUStall;
    > >```

4. 请问采用字节使能信号的方式处理写指令有什么好处？（提示：从清晰性、统一性等角度考虑）

    > >清晰性: 字节使能信号以独热码的形式清晰地表示出了哪些字节是需要写入的.
    > >
    > >统一性: 只要设置好使能信号就能控制数据的写入, 统一了相关指令.

5. 请思考，我们在按字节读和按字节写时，实际从 DM 获得的数据和向 DM 写入的数据是否是一字节？在什么情况下我们按字节读和按字节写的效率会高于按字读和按字写呢？

    > >不是一字节. 当我们需要对半字和字节进行读取和写入操作时, 按字节读和按字节写的效率会高于按字读和按字写.

6. 为了对抗复杂性你采取了哪些抽象和规范手段？这些手段在译码和处理数据冲突的时候有什么样的特点与帮助？

    > >各种变量命名规范统一, 在需要进行流水的数据的末尾加上不同流水段标识, 提高了统一性, 明确了职能, 不容易出错. 例子可见暂停/转发一节.

7. 在本实验中你遇到了哪些不同指令类型组合产生的冲突？你又是如何解决的？相应的测试样例是什么样的？

    > >本次实验相较p5只增加了有关乘除指令的冲突(其他新增指令只需按照p5的方式进行处理即可). 具体解决方式可见暂停/转发一节对乘除指令的处理.
    > >
    > >可构造相应测试样例为:
    > >
    > >```assembly
    > >ori		$t0, $0, 0x1234
    > >ori		$t1, $0, 0x5678
    > >mult	$t0, $t1
    > >mfhi	$t2
    > >mflo	$t3
    > >add		$t2, $t2, $t3
    > >divu	$t3, $t2
    > >mfhi	$t2
    > >mflo	$t3
    > >mthi	$t3
    > >mfhi	$t4
    > ># ……
    > >```

8. 如果你是手动构造的样例，请说明构造策略，说明你的测试程序如何保证**覆盖**了所有需要测试的情况；如果你是**完全随机**生成的测试样例，请思考完全随机的测试程序有何不足之处；如果你在生成测试样例时采用了**特殊的策略**，比如构造连续数据冒险序列，请你描述一下你使用的策略如何**结合了随机性**达到强测的效果。

    > >完全随机生成的测试样例会容易出现异常情况, 难以对跳转、存取以及其他冒险的处理进行很好的测试. 可以按照覆盖率测试软件中给出的冲突类型进行指令的构造.

