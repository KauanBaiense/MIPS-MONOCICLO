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
    signal sPC,M5,S1,D2,ES,Aumenta : unsigned(31 downto 0);
    signal inst : unsigned(25 downto 0);
    signal D1 : unsigned(27 downto 0);
    signal FontePC : std_logic;
begin

    PC: entity work.unsigned_register(behavior)
        generic map(N => 32)
        port map(clk => clk, enable => signals, d => M5, q => sPC);
    
    inst <= sMem(25 downto 0);
    
    Aumenta <= inst(15 downto 0);
    ES <= resize(aumenta,32); -- sinal de extensão
    S1 <= '4' + sPC; --saida somador1
    D1 <= inst & "00"; 
    
    D2 <= S1(31 downto 28) & D1;
    
    FontePC <= zero and DvC;
    Mux: entity work.mux_2to1(behavior)
        generic map(N => 32)
        port map(sel => FontePC, in_0 => S1, in_1 => S2, y => M5);
    
    


end behavior;