library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.memReg.all;

entity escrita_reg is
    generic (n : integer := 8);
    Port (
        destino : in  STD_LOGIC_VECTOR(4 downto 0); -- Corrigido para 5 bits
        writer  : in  STD_LOGIC_VECTOR(n-1 downto 0);
        escReg  : in  STD_LOGIC
    );
end entity;

architecture behavior of escrita_reg is
    signal banco : Lista_registradores := (others => (others => '0')); -- inicializa opcionalmente
begin
    process(destino, writer, escReg)
    begin
        if escReg = '1' then
            banco(to_integer(unsigned(destino))) <= writer;
        end if;
    end process;
end architecture;
