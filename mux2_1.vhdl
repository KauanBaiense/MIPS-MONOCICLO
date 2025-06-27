library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux2_1 is
    Port (
        sel : in  STD_LOGIC;
        A, B : in  STD_LOGIC_VECTOR(31 downto 0);
        Y    : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity;

architecture fast_logic of mux2_1 is
begin
    Y <= A when sel = '0' else B;
end architecture;
