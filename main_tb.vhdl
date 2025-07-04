-- Testbench para a entidade "main"
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main_tb is
end entity;

architecture testbench of main_tb is

    -- Sinais para conectar com a UUT (Unit Under Test)
    signal clk     : std_logic := '0';
    signal reset   : std_logic := '1';
    signal MEMORIA : std_logic_vector(31 downto 0);
    signal RESULT  : std_logic_vector(31 downto 0);

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instancia a UUT
    uut: entity work.main
        port map (
            clk     => clk,
            reset   => reset,
            MEMORIA => MEMORIA,
            RESULT  => RESULT
        );

    -- Geração de clock
    clk_process : process
    begin
        while now < 200 ns loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Estímulo de entrada
    stim_proc: process
    begin
        -- Reset inicial
        wait for 20 ns;
        reset <= '0';

        -- Instrução fictícia (ex: add $t0, $t1, $t2)
        -- opcode = 000000 (R-type), funct = 100000 (add)
        -- rs = 01001 (t1 = reg9), rt = 01010 (t2 = reg10), rd = 01000 (t0 = reg8)
        MEMORIA <= "00000001001010100100000000100000";  -- ADD t0, t1, t2
        wait for 20 ns;

        -- Outras instruções podem ser adicionadas aqui
        MEMORIA <= (others => '0');

        wait;
    end process;

end architecture;
