library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity divisor is
    generic (N: integer := 32);
    Port (
        a, b: in  STD_LOGIC_VECTOR(N-1 downto 0);
        S   : out STD_LOGIC_VECTOR(N-1 downto 0)
    );
end entity;

architecture fast_logic of divisor is
    signal c1 : unsigned(N-1 downto 0);
begin
    c1 <= unsigned(a) / unsigned(b);
    S  <= std_logic_vector(c1);
end architecture;



