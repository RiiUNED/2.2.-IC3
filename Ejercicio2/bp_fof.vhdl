-------------------------------------------------------------------
-- Banco de pruebas del componente fof del ejercicio 2
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bp_fof is
    constant DELAY :time := 20 ns; -- Retardo usado en el test
end entity bp_fof;

architecture bp_fof of bp_fof is
    signal n1, n2, r : std_logic := '0'; 
    signal f : std_logic; 

    begin
        UUT : entity work.fof(archfof) port map (f, n1, n2, r);

        vec_test : process is
            variable valor : unsigned (2 downto 0);
            begin
                -- Genera todos los posibles valores de entrada
                for i in 0 to 7 loop
                    valor := to_unsigned(i, 3);
                    r <= std_logic(valor(0));
                    n2 <= std_logic(valor(1));
                    n1 <= std_logic(valor(2));
                    wait for DELAY;
                end loop;
                wait; -- Final de simulacion
        end process vec_test;
end architecture bp_fof;
