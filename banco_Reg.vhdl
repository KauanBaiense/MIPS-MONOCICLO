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
    signal lista_reg : lista;
    signal reg_rd_interno, reg_rs_interno, reg_rt_interno : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal writer_interno : STD_LOGIC_VECTOR(n-1 downto 0) := (others => '0');
    signal escReg_interno : STD_LOGIC := '0';

begin

    reg_rd_interno <= reg_rd;
    reg_rt_interno <= reg_rt;
    reg_rs_interno <= reg_rs;
    writer_interno <= writer;

    process(all)
    begin
        if escReg = '1' then
            lista_reg(to_integer(unsigned(reg_rd_interno))) <= writer_interno;
        else
            A <= lista_reg(to_integer(unsigned(reg_rs_interno)));
            B <= lista_reg(to_integer(unsigned(reg_rt_interno)));
        end if;
    end process;
            
end architecture;