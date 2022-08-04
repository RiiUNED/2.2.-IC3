
------------------------------------------------------------
-- Architecture 2 de Funcion (x, y, z) = (F, G)
-- F = x'z + xy
-- G = x'y' + x'z
------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture arch2 of funcFG is
    signal xn, yn, a_1, a_2, a_3, a_4 : std_logic;

    -- Declaracion de los componentes

    component not1 is
        port ( y0 : out std_logic; x0 : in std_logic);
    end component not1;
   
    component and2 is
        port ( y0 : out std_logic; x0, x1 : in std_logic);
    end component and2;
   
    component or2 is
        port ( y0 : out std_logic; x0, x1 : in std_logic);
    end component or2;

    begin
        -- Instanciacion y conexion de los componentes
        N1 : component not1 port map (xn, x);
        N2 : component not1 port map (yn, y);
        A1 : component and2 port map (a_1, xn, z);
        A2 : component and2 port map (a_2, x, y);
        A3 : component and2 port map (a_3, xn, yn);
        A4 : component and2 port map (a_4, xn, z);
        O1 : component or2 port map (F, a_1, a_2);
        O2 : component or2 port map (G, a_3, a_4);
end architecture arch2;


