library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main is
    Port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        MEMORIA : in  STD_LOGIC_VECTOR(31 downto 0); -- MEMORIA DE INSTRUÇÕES
        RESULT  : out STD_LOGIC_VECTOR(31 downto 0) --TESTE
    );
end main;

architecture Behavior of main is
    signal sPC,M3,M4,M5,S1,S2,D2,ES,A,B,resultado,sMem,ESv4 : std_logic_vector(31 downto 0);
    signal inst : std_logic_vector(25 downto 0);
    signal D1 : std_logic_vector(27 downto 0);
    signal D : std_logic_vector(15 downto 0);
    signal regl1,regl2,C,M1 : std_logic_vector(4 downto 0);
    signal opcode,funct : std_logic_vector(5 downto 0);
    signal FontePC,zero,overflow_ULA : std_logic;
    signal RegDst, ALUFonte, MemParaReg, RegWrite, MemRead, MemWrite, DvC, DVI : std_logic; -- SINAIS CONTROLE
    signal ULAop : std_logic_vector(1 downto 0); --SINAL CONTROLE PARA ULA
    signal cULA : std_logic_vector(2 downto 0);
begin
    -- PARTE DE BAIXO MIPS
    PC: entity work.registerEnable(behavior)
        generic map(N => 32)
        port map(clk => clk, d => M5, q => sPC);

    -- sMem : entity work.memory
    -- LEITURA de SPC
    sMem <= MEMORIA; 
    inst <= sMem(25 downto 0);

    opcode <= sMem(31 downto 26); -- BITS DO CONTROLE
    
    regl1 <= inst(25 downto 21); --reg a ser lido 1 ENTRADA DE BANCO DE REGISTRADORES
    regl2 <= inst(20 downto 16); --reg a ser lido 2 mux 0 ENTRADA DE BANCO DE REGISTRADORES
    
    C <= inst(15 downto 11); -- reg a ser escrito mux 1
    D <= inst(15 downto 0); -- vai pra extensao de sinal
    funct <= inst(5 downto 0); -- sinal pro Ctrl-ULA
    
    Controlador: entity work.controle
    port map(opcode => opcode, RegDst => RegDst, ALUFonte => ALUFonte, MemParaReg => MemParaReg,
        RegWrite => RegWrite, MemRead => MemRead, MemWrite => MemWrite, DvC => DvC, DVI => DVI,
        ULAop => ULAop); --CONTROLE

    --BANCO DE REGISTRADORES
    BancoREG : entity work.banco_Reg
        generic map(n => 32)
        port map(reg_rs => regl1, reg_rt => regl2, reg_rd => M1, writer => M3, escReg => RegWrite, A => A, B => B);
    
    ES <= std_logic_vector(resize(unsigned(D),32)); -- extensão de sinal
    
    MUX1: entity work.mux2_1(behavior)
        generic map(N => 5)
        port map(sel => RegDst, A => regl2, B => C, Y => M1);
    
    ctrlULA: entity work.ctrl_ULA
        generic map(n => 32)
        port map(funct => funct, ULAop => ULAop, cULA => cULA);
    
    ULA: entity work.ULA
        generic map(N=> 32)
        port map(a=> A, b => B, result=> resultado, overflow_ULA=> overflow_ULA, cULA=> cULA, zero => zero);
    
    MUX3: entity work.mux2_1(behavior)
        generic map(N => 32)
        port map(sel => MemParaReg, A => resultado, B => MEMORIA, Y => M3);
    
    -- PARTE DE CIMA MIPS
    Somador1: entity work.somador(behavior)
        generic map(N => 32)
        port map(a => sPC, b => "00000000000000000000000000000000100", s => S1); -- soma PC + 4
    
    ESv4 <= ES(29 downto 0) & "00";
    somador2: entity work.somador(behavior)
        generic map(N => 32)
        port map(a => S1, b => ESv4, S => S2);

    D1 <= inst & "00"; -- Deslocamento de 2 bits para a esquerda *4
    D2 <= S1(31 downto 28) & D1; -- concatenação D1 E (PC + 4) 4 bits
    
    MUX4: entity work.mux2_1(behavior)
        generic map(N => 32)
        port map(sel => FontePC, A => S1, B => S2, Y => M4);

    MUX5: entity work.mux2_1(behavior)
        generic map(N => 32)
        port map(sel => DVI, A => M4, B => D2, Y => M5);
    
    FontePC <= zero and DvC;

end behavior;
