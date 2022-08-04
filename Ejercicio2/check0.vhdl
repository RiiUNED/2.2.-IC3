----------------------------------------------------------
-- checkzero. Componente del ejercicio 2
-- Entrada: num -> numero binario de n bits.
-- Salida: zero = 1 -> num = 0.
-- Salida: zero = 0 -> numero de entrada distinto de cero
----------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity checkzero is
    generic (n: integer);
    port(zero : out std_logic; num : in std_logic_vector(n-1 downto 0));
end entity checkzero;

architecture archcheckzero of checkzero is

    begin
        zero <= '1' when to_integer(unsigned(num))=0 else '0';
end architecture archcheckzero;


