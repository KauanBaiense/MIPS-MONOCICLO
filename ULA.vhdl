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
    signal result_soma, result_sub, result_soma_sub, result_and_or, result_interno,result_div : std_logic_vector(n downto 0);
    signal bit_significativo : std_logic;
    signal zeros : std_logic_vector(n-1 downto 0) := (others => '0');
begin
    c0 <= cULA(0);
    c1 <= cULA(1);
    c2 <= cULA(2);

    MUX_CTRL_SAIDA : entity work.mux2_1
        generic map( n => n+1 )
        port map (A => result_and_or, B => result_soma_sub, sel => c1, Y => result_interno);

    SOMA : entity work.somador32
        generic map( n => n )
        port map (A => a, B => b, S => result_soma);

    SUB : entity work.subtrator32
        generic map( n => n )
        port map (A => a, B => b, S => result_sub);

    DIV : entity work.divisor
        generic map( n => n )
        port map (a => a, b => b, S => result_div);
    
    process(all)
    begin
        if cULA = "011" then
            result_soma_sub <= result_div;
        else 
            result_soma_sub <= result_soma when (c2 = '0') else result_sub;
        end if;
    end process;
    bit_significativo <= result_interno(result_interno'high);
    result_and_or <= '0' & (a AND b) when (c0 = '0') else '0' & (a OR b);
    process(all)
    begin
        if cULA = "111" and bit_significativo = '1' then
            result <= std_logic_vector(unsigned(zeros) + 1);
        elsif cULA = "111" and bit_significativo = '0' then
            result <= std_logic_vector(unsigned(zeros));
        elsif bit_significativo = '0' then
            result <= result_interno(n-1 downto 0);
            zero <= '1' when unsigned(result_interno) = 0 else '0';
            overflow_ULA <= '0';
        else
            overflow_ULA <= '1';
            result <= result_interno(n-1 downto 0);                           
        end if;
    end process;

end behavior;