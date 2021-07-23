# Digital_Unit_CPU

singlecycle cpu / pipeline cpu

## 文件夹

`singlecyclecpu` 无I/O的单周期CPU modelsim 顶层文件为`testbench.v`

`singlecyclecpuio` 有I/O的单周期CPU 线路图见 `基本单周期 CPU 设计.docx`

`pipelinedCPU` 无I/O的pipeline CPU modelsim 顶层文件为`testbench.v`

`pipelinedCPUio` 有I/O的pipeline CPU 线路图见 `pipelineCPU设计.docx`

`materials` 所有必须的参考资料

## modelsim

将 source 文件夹放于modelsim工程的根目录下

并将所需的指令(ROM)文件 改为`sc_instmem.mif`文件名

### 需要的文件

`altera_lite\15.1\quartus\eda\sim_lib` 下的

`220model.v` 和 `altera_mf.v`

convert_hex2ver.dll

## I/O

|-|文件|
|---|---|
| 入门 | `My_First_Fpga.pdf` |
| pin | `DE1-SoC_User_manual.pdf` |
| ModelSim |`ModelSim-Altera使用方法.pdf`|
| 图表参考 |`Real_Value_Table_to student.xls`|
