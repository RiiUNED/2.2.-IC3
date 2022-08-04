-------------------------------------------------------------------------
-- signo. Componente del ejercicio 2.
-- Entrada: num -> numero en C2 de n bits.
-- Salida: sig = 1 -> num < 0.
-- Salida: sig = 0 -> sig >= 0.
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity signo is
    generic (n:integer);
    port (sig: out std_logic; num : in std_logic_vector (n-1 downto 0));
end entity signo;

architecture archsigno of signo is
begin
    sig <= num(n-1);
end architecture archsigno;


