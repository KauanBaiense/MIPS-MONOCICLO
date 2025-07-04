library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity controle is
    Port (
        opcode    : in  std_logic_vector(5 downto 0);
        RegDst    : out std_logic;
        ALUFonte  : out std_logic;
        MemParaReg  : out std_logic;
        RegWrite  : out std_logic;
        MemRead   : out std_logic;
        MemWrite  : out std_logic;
        DvC       : out std_logic;
        DVI      : out std_logic;
        ULAop     : out std_logic_vector(1 downto 0)
    );
end controle;

architecture Behavior of controle is
begin
    process(opcode)
    begin
        -- Default values
        RegDst   <= '0';
        ALUFonte <= '0';
        MemParaReg <= '0';
        RegWrite <= '0';
        MemRead  <= '0';
        MemWrite <= '0';
        DvC      <= '0';
        DVI      <= '0';
        ULAop    <= "00";

        case opcode is
            when "000000" => -- R-type
                RegDst   <= '1';
                ALUFonte <= '0';
                MemParaReg <= '-';
                RegWrite <= '1';
                MemRead  <= '0';
                MemWrite <= '0';
                DvC      <= '0';
                DVI      <= '0';
                ULAop    <= "10";
            when "100011" => -- LW
                RegDst   <= '0';
                ALUFonte <= '1';
                MemParaReg <= '1';
                RegWrite <= '1';
                MemRead  <= '1';
                MemWrite <= '0';
                DvC      <= '0';
                DVI      <= '0';
                ULAop    <= "00";
            when "101011" => -- SW
                RegDst   <= '0'; 
                ALUFonte <= '1';
                MemParaReg <= '0'; 
                RegWrite <= '0';
                MemRead  <= '0';
                MemWrite <= '1';
                DvC      <= '0';
                DVI      <= '0';
                ULAop    <= "00";
            when "000100" => -- BEQ
                RegDst   <= '0'; 
                ALUFonte <= '0';
                MemParaReg <= '0'; 
                RegWrite <= '0';
                MemRead  <= '0';
                MemWrite <= '0';
                DvC      <= '1';
                DVI      <= '0';
                ULAop    <= "01";
            when "000010" => -- JUMP
                RegDst   <= '0'; 
                ALUFonte <= '0'; 
                MemParaReg <= '0'; 
                RegWrite <= '0';
                MemRead  <= '0';
                MemWrite <= '0';
                DvC      <= '0';
                DVI      <= '1';
                ULAop    <= "00";
            when others =>
                null;
        end case;
    end process;
end Behavior;
