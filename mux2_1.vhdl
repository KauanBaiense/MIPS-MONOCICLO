library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux2_1 is
    generic (n : integer := 8);
    Port (
        sel : in  STD_LOGIC;
        A, B : in  STD_LOGIC_VECTOR(n-1 downto 0);
        Y    : out STD_LOGIC_VECTOR(n-1 downto 0)
    );
end entity;

architecture fast_logic of mux2_1 is
begin
    Y <= A when sel = '0' else B;
end architecture;
