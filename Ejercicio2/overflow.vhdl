--------------------------------------------------------------------
-- overflow. Componente del ejercicio 2
-- ENTRADA: (a, b, res) -> 3 numeros de n bits en C2
-- SALIDA: des. bit de desbordamiento.
-- SALIDA: des = 1 -> hay desbordamiento
-- SALIDA: des = 0 -> no hay desbordamiento
--------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity overflow is
    generic (n:integer);
    port (des : out std_logic;
    a, b, res : in std_logic_vector (n-1 downto 0));
end entity overflow;

architecture archoverflow of overflow is
    -- Declaracion de las constantes
    constant WIDTH : integer := n;

    -- Declaracion de las señales
    signal sa, sb, sr: std_logic := '0';

    begin
        -- Instanciacion y conexion de los componentes
        S1 : entity work.signo(archsigno) generic map (WIDTH) port map (sa, a);
        S2 : entity work.signo(archsigno) generic map (WIDTH) port map (sb, b);
        S3 : entity work.signo(archsigno) generic map (WIDTH) port map (sr, res);
        F0 : entity work.fof(archfof) port map (des, sa, sb, sr);
end architecture archoverflow;

