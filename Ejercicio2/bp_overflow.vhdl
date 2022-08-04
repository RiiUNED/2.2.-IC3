------------------------------------------------------------------
-- Banco de pruebas del componente overflow del ejercicio 2
------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bp_overflow is
    constant DELAY : time := 20 ns; -- Retardo usado en el test
end entity bp_overflow;

architecture bp_overflow of bp_overflow is
    constant WIDTH : integer := 3;
    signal a, b, res : std_logic_vector(WIDTH-1 downto 0):= (others => '0');
    signal des : std_logic; 

    begin
        UUT : entity work.overflow(archoverflow) generic map (WIDTH) port map (des, a, b, res);

        vect_test : process is
            variable valorA : signed (WIDTH-1 downto 0);
            variable valorB : signed (WIDTH-1 downto 0);
            begin
                -- Genera todos los posibles valores de entrada
                -- Genera los negativos y el cero
                for i in 0 to 2**(WIDTH-1)-1 loop
                    valorA := to_signed((-1*2**(WIDTH-1))+i, WIDTH); 
                    a <= std_logic_vector(valorA);
                    for j in 0 to 2**(WIDTH-1)-1 loop
                        valorB := to_signed((-1*2**(WIDTH-1))+j, WIDTH);
                        b <= std_logic_vector(valorB);
                        res <= std_logic_vector(valorA+valorB);
                        wait for DELAY;
                    end loop;
                    for j in 0 to 2**(WIDTH-1)-1 loop
                        valorB := to_signed(j, WIDTH);
                        b <= std_logic_vector(valorB);
                        res <= std_logic_vector(valorA+valorB);
                        wait for DELAY;
                    end loop;
                end loop;
                -- Genera los positivos
                for i in 0 to 2**(WIDTH-1)-1 loop
                    valorA := to_signed(i, WIDTH); 
                    a <= std_logic_vector(valorA);
                    for j in 0 to 2**(WIDTH-1)-1 loop
                        valorB := to_signed((-1*2**(WIDTH-1))+j, WIDTH);
                        b <= std_logic_vector(valorB);
                        res <= std_logic_vector(valorA+valorB);
                        wait for DELAY;
                    end loop;
                    for j in 0 to 2**(WIDTH-1)-1 loop
                        valorB := to_signed(j, WIDTH);
                        b <= std_logic_vector(valorB);
                        res <= std_logic_vector(valorA+valorB);
                        wait for DELAY;
                    end loop;
                end loop;
                wait; -- Final de simulacion
        end process vect_test;

end architecture bp_overflow;



