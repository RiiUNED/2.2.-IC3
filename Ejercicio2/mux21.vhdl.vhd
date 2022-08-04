----------------------------------------------------
-- mux2a1. Componente del ejercicio 2
-- Entrada: (sum, sumc) dos números de n bits en C2
-- Entrada: cin -> bit de selección
-- Salida: cin = 1 -> sumc
-- Salida: cin = 0 -> sum
----------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity mux2a1 is
    generic (n:integer);
    port (res : out std_logic_vector(n-1 downto 0);
    sum, sumc : in std_logic_vector(n-1 downto 0);
    cin : in std_logic);
end mux2a1;

architecture archmux of mux2a1 is
begin
    res <= sumc when cin='1' else sum;
end archmux;


