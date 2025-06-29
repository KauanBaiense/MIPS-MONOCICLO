library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrl_ULA is
    generic(
        n : integer := 32
    );
    port(
        funct : in std_logic_vector (5 downto 0);
        ULAop : in std_logic_vector(1 downto 0);
        cULA : out std_logic_vector (2 downto 0)
    );
end entity;

architecture behavior of ctrl_ULA is
    signal cULA_interno : std_logic_vector (2 downto 0);
begin
    process(ULAop, funct)
    begin
        case ULAop is
            when "00" => cULA_interno <= "010";
            when "01" => cULA_interno <= "110";
            when "10" =>
                case funct is
                    when "100000" => cULA_interno <= "010";
                    when "100010" => cULA_interno <= "110";
                    when "100100" => cULA_interno <= "000";
                    when "100101" => cULA_interno <= "001";
                    when "101010" => cULA_interno <= "111";
                    when others => cULA_interno <= "000";
                end case;
            when others => cULA_interno <= "000";
        end case;
    end process;
    cULA <= cULA_interno;
end behavior;