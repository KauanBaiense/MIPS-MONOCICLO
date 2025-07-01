library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.memReg.all;

entity escrita_reg is
    generic (n : integer := 8);
    Port (
        destino : in  STD_LOGIC_VECTOR(5 downto 0);
        writer : in STD_LOGIC_VECTOR(n-1 downto 0);
        escReg : in STD_LOGIC
    );
end entity;

architecture behavior of escrita_reg is
    signal banco : memReg;
begin
    GERADOR_REG : if escReg = '1' generate
    begin
        banco(destino) <= writer;
    end generate GERADOR_REG;
end architecture;
