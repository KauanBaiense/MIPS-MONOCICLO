--------------------------------------------------
--	Author:      Ismael Seidel (entidade)
--	Created:     May 1, 2025
--
--	Project:     Exercício 6 de INE5406
--	Description: Contém a descrição de uma entidade para um registrador com controle
--               de carga (sinal enable). O registrador armazena valores sem sinal
--               de N bits na borda de subida do clock, desde que `enable` esteja
--               em nível lógico alto. 
--               As entradas e saídas utilizam o tipo `unsigned`.
--------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Registrador parametrizável para N bits com controle de enable.
-- O registrador atualiza sua saída `q` com o valor da entrada `d` na borda de
-- subida do sinal `clk`, apenas quando `enable = '1'`.
entity registerEnable is
	generic(
		N : positive := 4 -- número de bits armazenados
	);
	port(
		clk         : in  std_logic;                -- clock (clk) e carga (enable)
		d           : in  std_logic_vector(N - 1 downto 0); -- dado de entrada
		q           : out std_logic_vector(N - 1 downto 0)  -- dado armazenado
	);
end registerEnable;
-- Não altere a definição da entidade!
-- Ou seja, não modifique o nome da entidade, nome das portas e tipos/tamanhos das portas!

-- Não alterar o nome da arquitetura!
architecture behavior OF registerEnable is
    -- Se precisar, podes adicionar declarações aqui (remova este comentário).
begin
process(clk)
	begin
		if rising_edge(clk) then
				q <= d;
		end if;
end process;
    -- Implementar um processo sensível à borda de subida do relógio (clock/clk).
    -- Se enable = '1', o valor de d deve ser atribuído a q.
end architecture behavior;
