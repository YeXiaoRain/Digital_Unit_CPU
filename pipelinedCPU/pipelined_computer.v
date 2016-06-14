module pipelined_computer (resetn,clock,mem_clock, pc,inst,ealu,malu,walu);
	//���嶥��ģ�� pipelined_computer�� ��Ϊ�����ļ��Ķ�����ڣ� ��ͼ 1-1 ��������ʱָ����
	input resetn, clock, mem_clock;
	//������������� module ����罻���������źţ�������λ�ź� resetn��ʱ���ź� clock��
	//�Լ�һ���� clock ͬƵ�ʵ������ mem_clock �źš� mem_clock ����ָ��ͬ�� ROM ��
	//����ͬ�� RAM ʹ�ã��䲨����Ҫ�б���ʵ��һ��
	//��Щ�źſ�������������֤ʱ������۲��źš�
	output [31:0] pc,inst,ealu,malu,walu;
	//ģ�����ڷ�������Ĺ۲��źš�ȱʡΪ wire �͡�
	wire [31:0] bpc,jpc,npc,pc4,ins, inst;
	//ģ��以���������ݻ������Ϣ���ź���,��Ϊ 32 λ���źš� IF ȡָ��׶Ρ�
	wire [31:0] dpc4,da,db,dimm;
	//ģ��以���������ݻ������Ϣ���ź���,��Ϊ 32 λ���źš� ID ָ������׶Ρ�
	wire [31:0] epc4,ea,eb,eimm;
	//ģ��以���������ݻ������Ϣ���ź���,��Ϊ 32 λ���źš� EXE ָ������׶Ρ�
	wire [31:0] mb,mmo;
	//ģ��以���������ݻ������Ϣ���ź���,��Ϊ 32 λ���źš� MEM �������ݽ׶Ρ�
	wire [31:0] wmo,wdi;
	//ģ��以���������ݻ������Ϣ���ź���,��Ϊ 32 λ���źš� WB ��д�Ĵ����׶Ρ�
	wire [4:0] drn,ern0,ern,mrn,wrn;
	//ģ��以����ͨ����ˮ�߼Ĵ������ݽ���Ĵ����ŵ��ź��ߣ��Ĵ����ţ� 32 ����Ϊ 5bit��
	wire [3:0] daluc,ealuc;
	//ID �׶��� EXE �׶�ͨ����ˮ�߼Ĵ������ݵ� aluc �����źţ� 4bit��
	wire [1:0] pcsource;
	//CU ģ���� IF �׶�ģ�鴫�ݵ� PC ѡ���źţ� 2bit��
	wire wpcir;
	// CU ģ�鷢���Ŀ�����ˮ��ͣ�ٵĿ����źţ�ʹ PC �� IF/ID ��ˮ�߼Ĵ������ֲ��䡣
	wire dwreg,dm2reg,dwmem,daluimm,dshift,djal; // id stage
	// ID �׶β���������������ˮ���������źš�
	wire ewreg,em2reg,ewmem,ealuimm,eshift,ejal; // exe stage
	//������ ID/EXE ��ˮ�߼Ĵ����� EXE �׶�ʹ�ã�����Ҫ��������ˮ���������źš�
	wire mwreg,mm2reg,mwmem; // mem stage
	//������ EXE/MEM ��ˮ�߼Ĵ����� MEM �׶�ʹ�ã�����Ҫ��������ˮ���������źš�
	wire wwreg,wm2reg; // wb stage
	//������ MEM/WB ��ˮ�߼Ĵ����� WB �׶�ʹ�õ��źš�
	
	pipepc prog_cnt ( npc,wpcir,clock,resetn,pc );
	//���������ģ�飬����ǰ��һ�� IF ��ˮ�ε����롣
	pipeif if_stage ( pcsource,pc,bpc,da,jpc,npc,pc4,ins,mem_clock ); // IF stage
	//IF ȡָ��ģ�飬ע�����а�����ָ��ͬ�� ROM �洢����ͬ���źţ�
	//���������ģ��� mem_clock �źţ�ģ���ڶ���Ϊ rom_clk�� // ע�� mem_clock��
	//ʵ���пɲ���ϵͳ clock �ķ����ź���Ϊ mem_clock���༴ rom_clock�� ,
	//�������źŰ�����ĵĴ���ʱ�䡣
	pipeir inst_reg ( pc4,ins,wpcir,clock,resetn,dpc4,inst ); // IF/ID ��ˮ�߼Ĵ���
	//IF/ID ��ˮ�߼Ĵ���ģ�飬��н� IF �׶κ� ID �׶ε���ˮ����
	//�� clock ������ʱ���� IF �׶��贫�ݸ� ID �׶ε���Ϣ�������� IF/ID ��ˮ�߼Ĵ���
	//�У��������� ID �׶Ρ�
	pipeid id_stage ( mwreg,mrn,ern,ewreg,em2reg,mm2reg,dpc4,inst,wrn,wdi,ealu,malu,mmo,wwreg,clock,resetn,	bpc,jpc,pcsource,wpcir,dwreg,dm2reg,dwmem,daluc,daluimm,da,db,dimm,drn,dshift,djal ); // ID stage
	//ID ָ������ģ�顣ע�����а��������� CU���Ĵ����ѡ��������·���ȡ�
	//���еļĴ����ѣ�����ϵͳ clock �����ؽ��мĴ���д�룬Ҳ���Ǹ��źŴ� WB �׶�
	//����������а�� clock ���ӳ�ʱ�䣬�༴ȷ���ź��ȶ���
	//�ý׶� CU �����ġ�Ҫ��������ˮ�ߺ󼶵��źŽ϶ࡣ
	pipedereg de_reg ( dwreg,dm2reg,dwmem,daluc,daluimm,da,db,dimm,drn,dshift,djal,dpc4,clock,resetn,ewreg,em2reg,ewmem,ealuc,ealuimm,ea,eb,eimm,ern0,eshift,ejal,epc4 ); // ID/EXE ��ˮ�߼Ĵ���
	//ID/EXE ��ˮ�߼Ĵ���ģ�飬��н� ID �׶κ� EXE �׶ε���ˮ����
	//�� clock ������ʱ���� ID �׶��贫�ݸ� EXE �׶ε���Ϣ�������� ID/EXE ��ˮ��
	//�Ĵ����У��������� EXE �׶Ρ�
	pipeexe exe_stage ( ealuc,ealuimm,ea,eb,eimm,eshift,ern0,epc4,ejal,ern,ealu ); // EXE stage
	//EXE ����ģ�顣���а��� ALU �������·���ȡ�
	pipeemreg em_reg ( ewreg,em2reg,ewmem,ealu,eb,ern,clock,resetn,mwreg,mm2reg,mwmem,malu,mb,mrn); // EXE/MEM ��ˮ�߼Ĵ���
	//EXE/MEM ��ˮ�߼Ĵ���ģ�飬��н� EXE �׶κ� MEM �׶ε���ˮ����
	//�� clock ������ʱ���� EXE �׶��贫�ݸ� MEM �׶ε���Ϣ�������� EXE/MEM
	//��ˮ�߼Ĵ����У��������� MEM �׶Ρ�
	pipemem mem_stage ( mwmem,malu,mb,clock,mem_clock,mmo ); // MEM stage
	//MEM ���ݴ�ȡģ�顣���а���������ͬ�� RAM �Ķ�д���ʡ� // ע�� mem_clock��
	//�������ͬ�� RAM �� mem_clock �źţ�ģ���ڶ���Ϊ ram_clk��
	//ʵ���пɲ���ϵͳ clock �ķ����ź���Ϊ mem_clock �źţ��༴ ram_clk�� ,
	//�������źŰ�����ĵĴ���ʱ�䣬Ȼ���� mem_clock ����ʱ�����������д���롣
	pipemwreg mw_reg ( mwreg,mm2reg,mmo,malu,mrn,clock,resetn,wwreg,wm2reg,wmo,walu,wrn); // MEM/WB ��ˮ�߼Ĵ���
	//MEM/WB ��ˮ�߼Ĵ���ģ�飬��н� MEM �׶κ� WB �׶ε���ˮ����
	//�� clock ������ʱ���� MEM �׶��贫�ݸ� WB �׶ε���Ϣ�������� MEM/WB
	//��ˮ�߼Ĵ����У��������� WB �׶Ρ�
	mux2x32 wb_stage( walu,wmo,wm2reg,wdi ); // WB stage
	//WB д�ؽ׶�ģ�顣��ʵ�ϣ������ԭ��ͼ�Ͽ��Կ������ý׶ε��߼����ܲ���ֻ
	//����һ����·�������Կ��Խ���һ����·����ʵ������ʵ�ָò��֡�
	//��Ȼ�����ר��дһ��������ģ��Ҳ�Ǻܺõġ�
endmodule