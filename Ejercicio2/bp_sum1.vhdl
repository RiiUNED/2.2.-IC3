-------------------------------------------------------
--- Banco de pruebas del componente sum1 del ejercico 2
-------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bp_sum1 is
    constant DELAY : time := 20 ns; -- Retardo usado en el test
end entity bp_sum1;

architecture bp_sum1 of bp_sum1 is
    constant WIDTH : integer := 3;
    signal a, b : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal sum, sumc : std_logic_vector(WIDTH-1 downto 0);

    begin
        UUT : entity work.sum1(archsum1) generic map (WIDTH) port map (sum, sumc,a , b); 

        vect_test : process is
            variable valorA : signed (WIDTH-1 downto 0);
            variable valorB : signed (WIDTH-1 downto 0);
            begin
                -- Genera todos los posibles valores de entrada
                --------------------------------------
                -- Primer sumando. negativos y el cero
                --------------------------------------
                for i in 0 to 2**(WIDTH-1)-1 loop
                    valorA := to_signed((-1*2**(WIDTH-1))+i, WIDTH); 
                    a <= std_logic_vector(valorA);
                -- Primer sumando. negativos y el cero. Segundo sumando negativos y cero                   
                    for j in 0 to 2**(WIDTH-1)-1 loop
                        valorB := to_signed((-1*2**(WIDTH-1))+j, WIDTH);
                        b <= std_logic_vector(valorB);
                        wait for DELAY;
                    end loop;
                -- Primer NEGATIVOS-CERO. Segundo POSITIVOS
                    for j in 0 to 2**(WIDTH-1)-1 loop
                        valorB := to_signed(j, WIDTH);
                        b <= std_logic_vector(valorB);
                        wait for DELAY;
                    end loop;
                end loop;
                -------------------
                -- Primer POSITIVOS
                -------------------
                for i in 0 to 2**(WIDTH-1)-1 loop
                    valorA := to_signed(i, WIDTH); 
                    a <= std_logic_vector(valorA);
                -- Primer POSITIVOS. Segundo NEGATIVOS Y CERO    
                    for j in 0 to 2**(WIDTH-1)-1 loop
                        valorB := to_signed((-1*2**(WIDTH-1))+j, WIDTH);
                        b <= std_logic_vector(valorB);
                        wait for DELAY;
                    end loop;
                -- Primer POSITIVOS. Segundo POSITIVOS.
                    for j in 0 to 2**(WIDTH-1)-1 loop
                        valorB := to_signed(j, WIDTH);
                        b <= std_logic_vector(valorB);
                        wait for DELAY;
                    end loop;
                end loop;
                wait; -- Final de simulacion
        end process vect_test;

end architecture bp_sum1;




