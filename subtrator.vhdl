library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity subtrator32 is
    Port (
        A, B : in  STD_LOGIC_VECTOR(31 downto 0);
        S    : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity;
architecture logic of subtrator32 is
begin
    S <= std_logic_vector(unsigned(A) - unsigned(B));
end architecture;
