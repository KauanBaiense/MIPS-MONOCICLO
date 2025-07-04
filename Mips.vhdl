library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Mips is
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
end Mips;
architecture Behavior of controle is
    signal sPC,M5,S1,D2,ES,Aumenta : unsigned(31 downto 0);
    signal inst : unsigned(25 downto 0);
    signal D1 : unsigned(27 downto 0);
    signal FontePC : std_logic;
begin


end behavior;