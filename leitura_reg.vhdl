library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.memReg.all;

entity leitura_reg is
    generic (n : integer := 8);
    Port (
        reg_rs : in  STD_LOGIC_VECTOR(4 downto 0); -- 25 downto 21
        reg_rt : in  STD_LOGIC_VECTOR(4 downto 0); -- 20 downto 16
        A , B  : out STD_LOGIC_VECTOR(n-1 downto 0)
    );
end entity;

architecture behavior of leitura_reg is
    signal banco : memReg;
begin
    A <= banco(reg_rs);
    B <= banco(reg_rt);
end architecture;
