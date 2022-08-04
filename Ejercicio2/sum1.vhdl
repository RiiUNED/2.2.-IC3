--------------------------------------------------------------------------------------------
--sum1. Componente del ejercicio 2.
--Entrada: (a, b) dos números de n bits en complento a 2
--Salida: (sum, sumc) Su suma con y sin acarreo.
--------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sum1 is
	generic (n:integer);
	port (sum, sumc : out std_logic_vector (n-1 downto 0);
	a, b : in std_logic_vector (n-1 downto 0));
end entity sum1;

architecture archsum1 of sum1 is
	constant carry : std_logic_vector (n downto 0) := std_logic_vector(to_signed(1, n+1));
	signal aux : std_logic_vector (n downto 0) := (others => '0');
	
	begin
		sum <= std_logic_vector(signed(a)+signed(b));
		aux <= std_logic_vector(signed(a)+signed(b)+signed(carry));
		sumc <= aux(n-1 downto 0);
end architecture archsum1;


