library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity divisorClock is
    generic (C : integer := 25_000_000); -- Divide por 25 milhões = 1 Hz (se CLOCK_50 for 50 MHz)
    port (
        clk_in  : in  std_logic;
        reset   : in  std_logic;
        clk_out : out std_logic
    );
end entity;

architecture rtl of divisorClock is
    signal counter : unsigned(31 downto 0) := (others => '0');
    signal clk_reg : std_logic := '0';
begin
    process(clk_in, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
            clk_reg <= '0';
        elsif rising_edge(clk_in) then
            if counter = C - 1 then
                counter <= (others => '0');
                clk_reg <= not clk_reg;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_out <= clk_reg;
end architecture;
