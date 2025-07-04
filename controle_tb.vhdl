library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity controle_tb is
end entity;

architecture tb of controle_tb is
    -- Sinais para conectar ao DUT
    signal opcode    : std_logic_vector(5 downto 0);
    signal RegDst    : std_logic;
    signal ALUFonte    : std_logic;
    signal MemParaReg  : std_logic;
    signal RegWrite  : std_logic;
    signal MemRead   : std_logic;
    signal MemWrite  : std_logic;
    signal DvC    : std_logic;
    signal DVI      : std_logic;
    signal ULAop     : std_logic_vector(1 downto 0);
begin

    
    command: entity work.controle
        port map (
            opcode    => opcode,
            RegDst    => RegDst,
            ALUFonte  => ALUFonte,
            MemParaReg  => MemParaReg,
            RegWrite  => RegWrite,
            MemRead   => MemRead,
            MemWrite  => MemWrite,
            DvC       => DvC,
            DVI       => DVI,
            ULAop     => ULAop
        );

    -- Processo de estímulo
    stimulus: process
    begin
        -- Teste 1: R-type (opcode = "000000")
        opcode <= "000000";
        wait for 10 ns;

        -- Teste 2: LW (opcode = "100011")
        opcode <= "100011";
        wait for 10 ns;

        -- Teste 3: SW (opcode = "101011")
        opcode <= "101011";
        wait for 10 ns;

        -- Teste 4: BEQ (opcode = "000100")
        opcode <= "000100";
        wait for 10 ns;

        -- Teste 5: JUMP (opcode = "000010")
        opcode <= "000010";
        wait for 10 ns;

        -- Teste 6: Opcode inválido (others)
        opcode <= "111111";
        wait for 10 ns;

        -- Encerrar simulação
        wait;
    end process;
end architecture;
