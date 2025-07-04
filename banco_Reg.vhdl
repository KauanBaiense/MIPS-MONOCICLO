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
    type lista is array (0 to 31) of STD_LOGIC_VECTOR(n-1 downto 0);
    signal lista_reg : lista := (others => "0");

begin

    process(all)
    begin
        if escReg = '1' then
            lista_reg(to_integer(unsigned(reg_rd))) <= writer;
        else
            A <= lista_reg(to_integer(unsigned(reg_rs)));
            B <= lista_reg(to_integer(unsigned(reg_rt)));
        end if;
    end process;

end architecture;
