library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity std_register is
	generic(
		N : positive := 8 
	);
	port(
		clk, enable : in  std_logic;              
		d           : in  std_logic_vector(N - 1 downto 0); 
		q           : out std_logic_vector(N - 1 downto 0)
	);
end std_register;

architecture behavior OF std_register is

begin
process(clk)
	begin
		if rising_edge(clk) then
			if enable = '1' then
				q <= d;
			end if;
		end if;
end process;

end architecture behavior;
