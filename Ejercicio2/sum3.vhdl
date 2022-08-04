-----------------------------------------------------------------------
-- sum3. Componente del ejercicio2.
-- ENTRADA: (a, b) dos números de n bits en C2.
-- ENTRADA: cin. bit de acarreo.
-- SALIDA: res. resultado a+b
-- SALIDA: des = 1 -> hay desbordamiento
-- SALIDA: des = 0 -> no hay desbordamiento
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sum3 is
    generic (n : integer);
    port (res : out std_logic_vector (n-1 downto 0);
    des : out std_logic;
    a, b : in std_logic_vector(n-1 downto 0);
    cin : in std_logic);
end entity sum3;

architecture archsum3 of sum3 is
    --Declaracion de constantes
    constant WIDTH : integer := n;

    --Declaracion de las señales
    signal a1 : std_logic_vector(n-1 downto 0) := (others => '0');

    begin
        -- Instaciacion y conexion de los componentes
        s1 : entity work.sum2(archsum2) generic map (WIDTH) port map (a1, a, b, cin);
        o1 : entity work.overflow(archoverflow) generic map (WIDTH) port map (des, a, b, a1);
        res <= a1;
end architecture archsum3;


