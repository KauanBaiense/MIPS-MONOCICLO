library ieee;
use ieee.std_logic_1164.all;

entity Controle is
	port(
		 opcode : in STD_LOGIC_VECTOR(5 downto 0);
        reg_write : out STD_LOGIC;
        ula_src : out STD_LOGIC;
        mem_read : out STD_LOGIC;
        mem_write : out STD_LOGIC;
        mem_to_reg : out STD_LOGIC;
        reg_dst : out STD_LOGIC;
        DvCeq : out STD_LOGIC;
        DvCne : out STD_LOGIC;
        jump : out STD_LOGIC;
        ula_op : out STD_LOGIC_VECTOR(1 downto 0)
	);
end entity;

architecture comportamento of Controle is
    constant r     : std_logic_vector(5 downto 0) := "000000";
    constant lw    : std_logic_vector(5 downto 0) := "100011";
    constant sw    : std_logic_vector(5 downto 0) := "101011";
    constant beq   : std_logic_vector(5 downto 0) := "000100";
    constant bne   : std_logic_vector(5 downto 0) := "000101";
    constant jumpc : std_logic_vector(5 downto 0) := "000010";
    constant addi  : std_logic_vector(5 downto 0) := "001000";	
begin
    reg_dst    <= '1' when Opcode = r else '0';
    DvCeq <= '1' when Opcode = beq else '0';
    DvCne <= '1' when Opcode = bne else '0';
    jump       <= '1' when Opcode = jumpc else '0';
    ula_src    <= '1' when Opcode = lw or Opcode = sw or Opcode = addi else '0';
    mem_read   <= '1' when Opcode = lw else '0';
    mem_to_reg <= '1' when Opcode = lw else '0';
    mem_write  <= '1' when Opcode = sw else '0';
    reg_write  <= '1' when Opcode = r or Opcode = lw or Opcode = addi else '0';

    ula_op(1) <= '1' when Opcode = r or Opcode = jump or Opcode = addi else '0';
    ula_op(0) <= '1' when Opcode = beq or Opcode = bne else '0';
end architecture;
