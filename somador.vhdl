library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity somador is
    generic (n : integer := 8);
    Port (
        A, B : in  STD_LOGIC_VECTOR(n-1 downto 0);
        S    : out STD_LOGIC_VECTOR(n-1 downto 0)
    );
end entity;
architecture behavior of somador is
begin

   S <= std_logic_vector(unsigned(A) + unsigned(B));

end architecture;
