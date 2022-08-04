
--------------------------------------------------------------------
-- Banco de pruebas de la funcion FG 
-- con la architecture arch2 del ejercicio 1
--------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bp2_funcFG is
    constant DELAY :time := 20 ns; -- Retardo usado en el test
end entity bp2_funcFG;

architecture bp2_funcFG of bp2_funcFG is
    signal F, G: std_logic; 
    signal x, y, z: std_logic;

    begin
        UUT : entity work.funcFG(arch2) port map (F, G, x, y, z);

        vec_test : process is
            variable valor : unsigned (2 downto 0);
            begin
                -- Genera todos los posibles valores de entrada
                for i in 0 to 7 loop
                    valor := to_unsigned(i, 3);
                    x <= std_logic(valor(2));
                    y <= std_logic(valor(1));
                    z <= std_logic(valor(0));
                    wait for DELAY;
                end loop;
                wait; -- Final de simulacion
        end process vec_test;
end architecture bp2_funcFG;



