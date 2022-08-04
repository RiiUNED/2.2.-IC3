-----------------------------------------------------------------------
--Solucion del ejercicio 2
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sum is
    generic (n : integer);
    port (res : out std_logic_vector (n-1 downto 0);
    desbordamiento : out std_logic;
    cero, signo : out std_logic;
    a, b : in std_logic_vector(n-1 downto 0);
    cin : in std_logic);
end entity sum;

architecture archsum of sum is
    --Declaracion de constantes
    constant WIDTH : integer := n;

    --Declaracion de las senales
    signal a1 : std_logic_vector(n-1 downto 0) := (others => '0');
    signal a2, a3 : std_logic := '0';

    begin
        -- Instaciacion y conexion de los componentes
        s1 : entity work.sum2(archsum2) generic map (WIDTH) port map (a1, a, b, cin);
        o1 : entity work.overflow(archoverflow) generic map (WIDTH) port map (a3, a, b, a1);
        desbordamiento <= a3;
        res <= a1;
        ch1 : entity work.checkzero(archcheckzero) generic map (WIDTH) port map (a2, a1);
        cero <= a2 and not a3;
        sg1 : entity work.signo(archsigno) generic map (WIDTH) port map (signo, a1);
end architecture archsum;



