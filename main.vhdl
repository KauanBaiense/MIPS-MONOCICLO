library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main is
    Port (
        clk             : in  STD_LOGIC;
        reset           : in  STD_LOGIC;
        o_PC_Atual      : out STD_LOGIC_VECTOR(31 downto 0);
        o_Saida_ULA     : out STD_LOGIC_VECTOR(31 downto 0);
        o_Dado_Lido_Mem : out STD_LOGIC_VECTOR(31 downto 0)
    );
end main;

architecture Behavior of main is
    signal sPC, M3, M2, M4, M5, S1, S2, D2, ES, A, B, resultado, sMem, ESv4, DadoLido : std_logic_vector(31 downto 0);
    signal inst : std_logic_vector(25 downto 0);
    signal D1 : std_logic_vector(27 downto 0);
    signal D : std_logic_vector(15 downto 0);
    signal regl1, regl2, C, M1 : std_logic_vector(4 downto 0);
    signal opcode, funct : std_logic_vector(5 downto 0);
    signal FontePC, zero, overflow_ULA : std_logic;
    signal RegDst, ALUFonte, MemParaReg, RegWrite, MemRead, MemWrite, DvC, DVI : std_logic;
    signal ULAop : std_logic_vector(1 downto 0);
    signal cULA : std_logic_vector(2 downto 0);

begin
    
    PC: entity work.registerEnable(behavior)
        generic map(N => 32)
        port map(clk => clk, d => M5, q => sPC);

    MemInst : entity work.RomMips
        port map(
            address => sPC(7 downto 0),
            q       => sMem
        );
    
    inst <= sMem(25 downto 0);
    opcode <= sMem(31 downto 26);
    regl1 <= sMem(25 downto 21);
    regl2 <= sMem(20 downto 16);
    C <= sMem(15 downto 11);
    D <= sMem(15 downto 0);
    funct <= sMem(5 downto 0);
    
    Controlador: entity work.controle
        port map(opcode => opcode, RegDst => RegDst, ALUFonte => ALUFonte, MemParaReg => MemParaReg,
                 RegWrite => RegWrite, MemRead => MemRead, MemWrite => MemWrite, DvC => DvC, DVI => DVI,
                 ULAop => ULAop);

    MUX1: entity work.mux2_1(behavior)
        generic map(N => 5)
        port map(sel => RegDst, A => regl2, B => C, Y => M1);
    
    BancoREG : entity work.BancoReg
        generic map(n => 32)
        port map(clk => clk, reg_rs => regl1, reg_rt => regl2, reg_rd => M1, writer => M3, escReg => RegWrite, A => A, B => B);
    
    ES <= std_logic_vector(resize(signed(D), 32));
    
    ctrlULA: entity work.ctrl_ULA
        port map(funct => funct, ULAop => ULAop, cULA => cULA);
    
    MUX2: entity work.mux2_1(behavior)
        generic map(N => 32)
        port map(sel => ALUFonte, A => B, B => ES, Y => M2);
    
    ULA: entity work.ULA
        generic map(N=> 32)
        port map(a=> A, b => M2, result=> resultado, overflow_ULA=> overflow_ULA, cULA=> cULA, zero => zero);

    MEM_DADOS: entity work.RamMips
        port map(
            address => resultado(7 downto 0),
            clock   => clk,
            data    => B,
            wren    => MemWrite,
            q       => DadoLido
        );
    
    MUX3: entity work.mux2_1(behavior)
        generic map(N => 32)
        port map(sel => MemParaReg, A => resultado, B => DadoLido, Y => M3);
    
    Somador1: entity work.somador(behavior)
        generic map(N => 32)
        port map(a => sPC, b => x"00000004", s => S1);
    
    ESv4 <= ES(29 downto 0) & "00";

    somador2: entity work.somador(behavior)
        generic map(N => 32)
        port map(a => S1, b => ESv4, S => S2);
    
    D1 <= sMem(25 downto 0) & "00";
    D2 <= S1(31 downto 28) & D1;
    
    FontePC <= zero and DvC;

    MUX4: entity work.mux2_1(behavior)
        generic map(N => 32)
        port map(sel => FontePC, A => S1, B => S2, Y => M4);

    MUX5: entity work.mux2_1(behavior)
        generic map(N => 32)
        port map(sel => DVI, A => M4, B => D2, Y => M5);
        
    o_PC_Atual      <= sPC;
    o_Saida_ULA       <= resultado;
    o_Dado_Lido_Mem   <= DadoLido;

end architecture;