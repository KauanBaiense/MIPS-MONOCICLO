library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity divisor is
    generic (N: integer := 32);
    Port (
        A, B: in  STD_LOGIC_VECTOR(N-1 downto 0);
        S   : out STD_LOGIC_VECTOR(N downto 0)
    );
end entity;

architecture behavior of divisor is


begin
process(B)
begin
    if signed(B) = ("00000000000000000000000000000000") then
        S <= ("000000000000000000000000000000000");  -- Evita divisão por zero
    else
        S <= std_logic_vector(resize(signed(A), N+1) / resize(signed(B), N+1));
    end if;
end process;
end architecture;





