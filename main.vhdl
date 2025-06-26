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
architecture Behavior of controle is
    signal sPC,M5,S1,D2,ES : unsigned(31 downto 0);
    signal inst : unsigned(25 downto 0);
    signal D1 : unsigned(27 downto 0);
    signal D : unsigned(14 downto 0);
    signal A,B,C : unsigned(4 downto 0);
    signal FontePC : std_logic;
begin

    PC: entity work.unsigned_register(behavior)
        generic map(N => 32)
        port map(clk => clk, enable => signals, d => M5, q => sPC);
    -- PARTE DE BAIXO MIPS
    -- sMem : entity work.memory
    inst <= sMem(25 downto 0);
    
    D <= inst(14 downto 0);
    
    ES <= resize(D,32); -- extensão de sinal
    A,B,C


    -- PARTE DE CIMA MIPS
    S1 <= '4' + sPC; -- somador 1
    D1 <= inst & "00"; -- Deslocamento de 2 bits para a esquerda *4
    D2 <= S1(31 downto 28) & D1; -- concatenação D1 E (PC + 4) 4 bits
    
    MUX5: entity work.mux_2to1(behavior)
        generic map(N => 32)
        port map(sel => /*VEMDOCONTROLE*/ DVI, in_0 => M4, in_1 => D2, y => M5);
    
    MUX4: entity work.mux_2to1(behavior)
        generic map(N => 32)
        port map(sel => FontePC, in_0 => S1, in_1 => S2, y => M4);
    
    FontePC <= zero and DvC;
    ESv4 <= ES(29 downto 0) & "00";
    somador2: entity work.somador(behavior)
        generic map(N => 32)
        port map(a => S1, b => ESv4, y => S2);
    
    


end behavior;
