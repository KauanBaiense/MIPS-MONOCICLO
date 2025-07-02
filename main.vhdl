library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main is
    Port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        ZERO    : in STD_LOGIC;
        opcode  : in  STD_LOGIC_VECTOR(5 downto 0);
        funct   : in  STD_LOGIC_VECTOR(5 downto 0);
        A       : in  STD_LOGIC_VECTOR(7 downto 0);
        B       : in  STD_LOGIC_VECTOR(7 downto 0);
        RESULT  : out STD_LOGIC_VECTOR(7 downto 0)
    );
end main;
architecture Behavior of main is
    signal sPC,M5,S1,D2,ES,A,B,resultado : unsigned(31 downto 0);
    signal inst : unsigned(25 downto 0);
    signal D1 : unsigned(27 downto 0);
    signal D : unsigned(14 downto 0);
    signal regl1,regl2,C,M1 : unsigned(4 downto 0);
    signal Controle,ctrlULA : std_logic_vector(5 downto 0);
    signal FontePC,zero,overflow_ULA : std_logic;
    signal cULA : std_logic_vector(2 downto 0);
begin

    PC: entity work.unsigned_register(behavior)
        generic map(N => 32)
        port map(clk => clk, enable => signals, d => M5, q => sPC);
   
    -- PARTE DE BAIXO MIPS
    -- sMem : entity work.memory
    inst <= sMem(25 downto 0);
    Controle <= sMem(31 downto 26); -- controle de instrução
    regl1 <= inst(25 downto 21); --reg a ser lido 1
    regl2 <= inst(20 downto 16); --reg a ser lido 2 mux 0
    C <= inst(15 downto 11); -- reg a ser escrito mux 1
    D <= inst(15 downto 0); -- vai pra extensao de sinal
    ctrlULA <= inst(5 downto 0); -- controle da ULA
    ES <= resize(D,32); -- extensão de sinal
    MUX1: entity work.mux_2to1(behavior)
        generic map(N => 5)
        port map(sel => RegDst, in_0 => regl2, in_1 => C, y => M1);
    
    ULA: entity work.ULA
        generic map(N=> 32)
        port map(a=> A, b=> B, result=> resultado, overflow_ULA=> overflow_ULA, cULA=> cULA, zero => zero);
    
    MUX3: entity work.mux_2to1(behavior)
        generic map(N => 32)
        port map(sel => MemParaReg,in_0 => resultado, in_1 => dado lido#memoria, y => M3);
    
    -- PARTE DE CIMA MIPS
    S1 <= '4' + sPC; -- somador 1
    D1 <= inst & "00"; -- Deslocamento de 2 bits para a esquerda *4
    D2 <= S1(31 downto 28) & D1; -- concatenação D1 E (PC + 4) 4 bits
    
    MUX4: entity work.mux_2to1(behavior)
        generic map(N => 32)
        port map(sel => FontePC, in_0 => S1, in_1 => S2, y => M4);

    MUX5: entity work.mux_2to1(behavior)
        generic map(N => 32)
        port map(sel => /*VEMDOCONTROLE*/ DVI, in_0 => M4, in_1 => D2, y => M5);
    
    FontePC <= zero and DvC;
    ESv4 <= ES(29 downto 0) & "00";
    somador2: entity work.somador(behavior)
        generic map(N => 32)
        port map(a => S1, b => ESv4, y => S2);
    
    


end behavior;
