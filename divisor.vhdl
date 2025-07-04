library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity divisor is
    generic (N: integer := 32);
    Port (
        a, b: in  STD_LOGIC_VECTOR(N-1 downto 0);
        S   : out STD_LOGIC_VECTOR(N downto 0)
    );
end entity;

architecture fast_logic of divisor is
    
begin
    S <= std_logic_vector(resize(signed(A),33) / resize(signed(B),33));
end architecture;



