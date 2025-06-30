library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity subtrator32 is
    generic (n : integer := 8);
    Port (
        A, B : in  STD_LOGIC_VECTOR(n-1 downto 0);
        S    : out STD_LOGIC_VECTOR(n downto 0)
    );
end entity;
architecture logic of subtrator32 is
begin
    S <= std_logic_vector(unsigned('0' & A) - unsigned('0' & B));
end architecture;
