library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BancoReg is
    generic (n : integer := 32);
    port (
        clk      : in  std_logic;
        reg_rs   : in  std_logic_vector(4 downto 0);
        reg_rt   : in  std_logic_vector(4 downto 0);
        reg_rd   : in  std_logic_vector(4 downto 0);
        writer   : in  std_logic_vector(n-1 downto 0);
        escReg   : in  std_logic;
        A, B     : out std_logic_vector(n-1 downto 0)
    );
end entity;

architecture behavior of BancoReg is
    type reg_array is array (0 to 31) of std_logic_vector(n-1 downto 0);
    signal regs : reg_array := (others => (others => '0'));
begin

    -- Leitura combinacional
    A <= regs(to_integer(unsigned(reg_rs)));
    B <= regs(to_integer(unsigned(reg_rt)));

    -- Escrita síncrona
    process(clk)
    begin
        if rising_edge(clk) then
            if escReg = '1' and reg_rd /= "00000" then
                regs(to_integer(unsigned(reg_rd))) <= writer;
            end if;
        end if;
    end process;

end architecture;
