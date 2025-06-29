library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
    generic(
        n : integer := 32
    );
    port(
        a : in std_logic_vector (n-1 downto 0);
        b : in std_logic_vector (n-1 downto 0);
        result : out std_logic_vector(n-1 downto 0);
        overflow_ULA : out std_logic;
        cULA : in std_logic_vector(2 downto 0);
        zero : out std_logic
    );
end entity;

architecture behavior of ULA is
    signal c2, c1, c0 : std_logic;
    signal result_soma, result_sub, result_soma_sub, result_and_or, result_interno : std_logic_vector(n downto 0);
begin
    c0 <= cULA(0);
    c1 <= cULA(1);
    c2 <= cULA(2);

    MUX_CTRL_SAIDA : entity work.mux2_1
        generic map( n => n )
        port map (A => result_soma_sub, B => result_and_or, sel => c1, Y => result_interno);

    SOMA : entity work.somador
        generic map( n => n )
        port map (A => a, B => b, S => result_soma);

    SUB : entity work.subtrator
        generic map( n => n )
        port map (A => a, B => b, S => result_sub);

    result_and_or <= '0' & (a AND b) when (c0 = '0') else '0' & (a OR b);
    result_soma_sub <= result_soma when (c2 = '0') else result_sub;

    process(result_interno, cULA)
    begin
        if result_interno'high = '0' then
            result <= result_interno(n-1 downto 0);
            zero <= '1' when result_interno = (others => '0') else '0';
            overflow_ULA <= '0';
        elsif cULA = "111" then
            result <= std_logic_vector(unsigned((others => '0')) + 1);
        else
            overflow_ULA <= '1';
        end if;
    end process;

end behavior;