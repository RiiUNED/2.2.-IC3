------------------------------------------------------
-- Banco de pruebas del componente sum2 del ejercico 2
------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bp_sum2 is
    constant DELAY : time := 20 ns; -- Retardo usado en el test
end entity bp_sum2;

architecture bp_sum2 of bp_sum2 is
    constant WIDTH : integer := 3;
    signal a, b : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal res : std_logic_vector(WIDTH-1 downto 0);
    signal cin : std_logic;

    begin
        UUT : entity work.sum2(archsum2) generic map (WIDTH) port map (res, a, b, cin); 

        vect_test : process is
            variable valorA : signed (WIDTH-1 downto 0);
            variable valorB : signed (WIDTH-1 downto 0);
            begin
                for k in 0 to 1 loop
                    -- Genera los resultados sin acarreo
                    if k=0 then
                        cin <= '0';
                    -- Genera todos los posibles valores de entrada
                    -- Genera los negativos y el cero
                    for i in 0 to 2**(WIDTH-1)-1 loop
                        valorA := to_signed((-1*2**(WIDTH-1))+i, WIDTH); 
                        a <= std_logic_vector(valorA);
                        for j in 0 to 2**(WIDTH-1)-1 loop
                            valorB := to_signed((-1*2**(WIDTH-1))+j, WIDTH);
                            b <= std_logic_vector(valorB);
                            wait for DELAY;
                        end loop;
                        for j in 0 to 2**(WIDTH-1)-1 loop
                            valorB := to_signed(j, WIDTH);
                            b <= std_logic_vector(valorB);
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
                            wait for DELAY;
                        end loop;
                        for j in 0 to 2**(WIDTH-1)-1 loop
                            valorB := to_signed(j, WIDTH);
                            b <= std_logic_vector(valorB);
                            wait for DELAY;
                        end loop;
                    end loop;
                    -- Genera los resultados con acarreo
                    else
                        cin <= '1';
                        -- Genera todos los posibles valores de entrada
                        -- Genera los negativos y el cero
                        for i in 0 to 2**(WIDTH-1)-1 loop
                            valorA := to_signed((-1*2**(WIDTH-1))+i, WIDTH); 
                            a <= std_logic_vector(valorA);
                            for j in 0 to 2**(WIDTH-1)-1 loop
                                valorB := to_signed((-1*2**(WIDTH-1))+j, WIDTH);
                                b <= std_logic_vector(valorB);
                                wait for DELAY;
                            end loop;
                            for j in 0 to 2**(WIDTH-1)-1 loop
                                valorB := to_signed(j, WIDTH);
                                b <= std_logic_vector(valorB);
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
                                wait for DELAY;
                            end loop;
                            for j in 0 to 2**(WIDTH-1)-1 loop
                                valorB := to_signed(j, WIDTH);
                                b <= std_logic_vector(valorB);
                                wait for DELAY;
                            end loop;
                        end loop;
                    end if;
                end loop;
                wait; -- Final de simulacion
        end process vect_test;

end architecture bp_sum2;

