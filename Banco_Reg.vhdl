library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REGBANK is
    Port (
        entrada16 : in  STD_LOGIC_VECTOR(15 downto 0);
        saida32   : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity;

architecture arch of REGBANK is
begin

    saida32 <= (others => entrada16(15)) & entrada16;
end architecture;
