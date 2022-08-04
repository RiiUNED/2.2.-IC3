--------------------------------------------------------------------
-- fof. Componente del ejercicio 2.
-- funcion auxiliar para el cálculo del desbordamiento
-- Entrada: sa, sb, sr -> 3 bits
-- Salida: fof =sa x sb x sr' + sa' x sb' x sr
--------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity fof is
    port ( f : out std_logic; n1, n2, r: in std_logic);
end entity fof;
---------------------------------------------------------

architecture archfof of fof is
begin
    f <= (n1 and n2 and (not r)) or ((not n1) and (not n2) and r);
end architecture archfof;


