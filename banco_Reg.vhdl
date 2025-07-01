library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity banco_Reg is
    generic (n : integer := 8);
    Port (
        reg_rs : in  STD_LOGIC_VECTOR(4 downto 0); -- 25 downto 21
        reg_rt : in  STD_LOGIC_VECTOR(4 downto 0); -- 20 downto 16
        reg_rd : in  STD_LOGIC_VECTOR(4 downto 0); -- 15 downto 11
        writer : in STD_LOGIC_VECTOR(n-1 downto 0);
        escReg : in STD_LOGIC;
        A , B  : out STD_LOGIC_VECTOR(n-1 downto 0)
    );
end entity;

architecture behavior of banco_Reg is

begin

    ESCRITA : entity work.escrita_reg
    generic map (n => n)
    port map (escReg => escReg, writer => writer, destino => reg_rd);

    LEITURA : entity work.leitura_reg
    generic map (n => n)
    port map (A => A, B => B, reg_rs => reg_rs, reg_rt => reg_rt);

end architecture;
