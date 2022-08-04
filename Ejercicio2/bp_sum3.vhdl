------------------------------------------------------------------------------------------------------------
-- Banco de pruebas del componente sum3 del ejercico 2
------------------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bp_sum3 is
    constant DELAY : time := 20 ns; -- Retardo usado en el test
end entity bp_sum3;

architecture bp_sum3 of bp_sum3 is
    constant WIDTH : integer := 3;
    signal a, b : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal res : std_logic_vector(WIDTH-1 downto 0);
    signal cin, des : std_logic;

    begin
        UUT : entity work.sum3(archsum3) generic map (WIDTH) port map (res, des, a, b, cin); 

        vect_test : process is
            variable valorA : signed (WIDTH-1 downto 0);
            variable valorB : signed (WIDTH-1 downto 0);
            variable total : integer;
            variable vec_total : std_logic_vector(2*WIDTH-1 downto 0);
            variable ref_des : std_logic;
            begin
                for k in 0 to 1 loop
                    -- Genera los resultados sin acarreo
                    if k=0 then
                        cin <= '0';
                    -- Genera todos los posibles valores de entrada
                    -- Genera los negativos y el cero del primer sumando
                    for i in 0 to 2**(WIDTH-1)-1 loop
                        valorA := to_signed((-1*2**(WIDTH-1))+i, WIDTH); 
                        a <= std_logic_vector(valorA);
                        -- Genera los negativos y el cero del segundo sumando
                        for j in 0 to 2**(WIDTH-1)-1 loop
                            valorB := to_signed((-1*2**(WIDTH-1))+j, WIDTH);
                            b <= std_logic_vector(valorB);
                            total := -1*2**(WIDTH)+i+j;
                            vec_total := std_logic_vector(to_signed(total, 2*WIDTH));
                            wait for DELAY;
                            --------- Genera el bit referencia para la comparacion de acarrero ----------------------
                            if total>2**(WIDTH-1)-1 or total<-1*2**(WIDTH-1) then
                                ref_des := '1';
                                else
                                ref_des := '0';
                            end if;
                            ---------------------------Bucle para chequear el resultado de la suma
                            for m in 0 to WIDTH-1 loop
                                assert res(m)=vec_total(m) report "ERROR EN LA SUMA. Obtenido/Esperado: " 
                                & std_logic'image(res(m)) & std_logic'image(vec_total(m));
                            end loop;
                            ----------------- Chequeo del desbordamiento ----------------------------------------------------------
                            assert des = ref_des report "ERROR EN EL DESBORDAMIENTO. Obtenido/Esperado: "
                            & std_logic'image(des) & std_logic'image(ref_des) & integer'image(i) & integer'image(j);
                        end loop;
                        -----------------------------Final de negativos y cero del segundo sumando---------------------
                        --Genera los positivos del segundo sumando----------------------------------------------------------
                        for j in 0 to 2**(WIDTH-1)-1 loop
                            valorB := to_signed(j, WIDTH);
                            b <= std_logic_vector(valorB);
                            total := -1*2**(WIDTH-1)+i+j;
                            vec_total := std_logic_vector(to_signed(total, 2*WIDTH));
                            wait for DELAY;
                            --------- Genera el bit referencia para la comparacion de acarrero ----------------------
                            if total>2**(WIDTH-1)-1 or total<-1*2**(WIDTH-1) then
                                ref_des := '1';
                                else
                                ref_des := '0';
                            end if;
                            ---------------------------Bucle para chequear el resultado de la suma
                            for m in 0 to WIDTH-1 loop
                                assert res(m)=vec_total(m) report "ERROR EN LA SUMA. Obtenido/Esperado: " 
                                & std_logic'image(res(m)) & std_logic'image(vec_total(m));
                            end loop;
                            ----------------- Chequeo del desbordamiento ----------------------------------------------------------
                            assert des = ref_des report "ERROR EN EL DESBORDAMIENTO. Obtenido/Esperado: "
                            & std_logic'image(des) & std_logic'image(ref_des) & integer'image(i) & integer'image(j);
                        end loop;
                    end loop;
                    -----------------------------------------FINAL DE LOS NEGATIVOS PRIMER SUMANDO--------------------------------------------------
                    -- Genera los positivos del primer sumando---------------------------------------------------------
                    for i in 0 to 2**(WIDTH-1)-1 loop
                        valorA := to_signed(i, WIDTH); 
                        a <= std_logic_vector(valorA);
                        --------------------------Genera los negativos y cero del segundo sumando------------------------------------
                        for j in 0 to 2**(WIDTH-1)-1 loop
                            valorB := to_signed((-1*2**(WIDTH-1))+j, WIDTH);
                            b <= std_logic_vector(valorB);
                            total := -1*2**(WIDTH-1)+i+j;
                            vec_total := std_logic_vector(to_signed(total, 2*WIDTH));
                            wait for DELAY;
                            --------- Genera el bit referencia para la comparacion de acarrero ----------------------
                            if total>2**(WIDTH-1)-1 or total<-1*2**(WIDTH-1) then
                                ref_des := '1';
                                else
                                ref_des := '0';
                            end if;
                            ---------------------------Bucle para chequear el resultado de la suma
                            for m in 0 to WIDTH-1 loop
                                assert res(m)=vec_total(m) report "ERROR EN LA SUMA. Obtenido/Esperado: " 
                                & std_logic'image(res(m)) & std_logic'image(vec_total(m));
                            end loop;
                            ----------------- Chequeo del desbordamiento ----------------------------------------------------------
                            assert des = ref_des report "ERROR EN EL DESBORDAMIENTO. Obtenido/Esperado: "
                            & std_logic'image(des) & std_logic'image(ref_des) & integer'image(i) & integer'image(j);
                        end loop;
                        -------------------------------------------genera los positivos del segundo sumando---------------------------------
                        for j in 0 to 2**(WIDTH-1)-1 loop
                            valorB := to_signed(j, WIDTH);
                            b <= std_logic_vector(valorB);
                            total := i+j;
                            vec_total := std_logic_vector(to_signed(total, 2*WIDTH));
                            wait for DELAY;
                            --------- Genera el bit referencia para la comparacion de acarrero ----------------------
                            if total>2**(WIDTH-1)-1 or total<-1*2**(WIDTH-1) then
                                ref_des := '1';
                                else
                                ref_des := '0';
                            end if;
                            ---------------------------Bucle para chequear el resultado de la suma
                            for m in 0 to WIDTH-1 loop
                                assert res(m)=vec_total(m) report "ERROR EN LA SUMA. Obtenido/Esperado: " 
                                & std_logic'image(res(m)) & std_logic'image(vec_total(m));
                            end loop;
                            ----------------- Chequeo del desbordamiento ----------------------------------------------------------
                            assert des = ref_des report "ERROR EN EL DESBORDAMIENTO. Obtenido/Esperado: "
                            & std_logic'image(des) & std_logic'image(ref_des) & integer'image(i) & integer'image(j);
                        end loop;
                    end loop;
                    -- Genera los resultados con acarreo
                    else
                        cin <= '1';
                    -- Genera todos los posibles valores de entrada
                    -- Genera los negativos y el cero del primer sumando
                    for i in 0 to 2**(WIDTH-1)-1 loop
                        valorA := to_signed((-1*2**(WIDTH-1))+i, WIDTH); 
                        a <= std_logic_vector(valorA);
                        -- Genera los negativos y el cero del segundo sumando
                        for j in 0 to 2**(WIDTH-1)-1 loop
                            valorB := to_signed((-1*2**(WIDTH-1))+j, WIDTH);
                            b <= std_logic_vector(valorB);
                            total := -1*2**(WIDTH)+i+j+1;
                            vec_total := std_logic_vector(to_signed(total, 2*WIDTH));
                            wait for DELAY;
                            --------- Genera el bit referencia para la comparacion de acarrero ----------------------
                            if total>2**(WIDTH-1)-1 or total<-1*2**(WIDTH-1) then
                                ref_des := '1';
                                else
                                ref_des := '0';
                            end if;
                            ---------------------------Bucle para chequear el resultado de la suma
                            for m in 0 to WIDTH-1 loop
                                assert res(m)=vec_total(m) report "ERROR EN LA SUMA. Obtenido/Esperado: " 
                                & std_logic'image(res(m)) & std_logic'image(vec_total(m)) & integer'image(total);
                            end loop;
                            ----------------- Chequeo del desbordamiento ----------------------------------------------------------
                            assert des = ref_des report "ERROR EN EL DESBORDAMIENTO. Obtenido/Esperado: "
                            & std_logic'image(des) & std_logic'image(ref_des) & integer'image(i) & integer'image(j);
                        end loop;
                        -----------------------------Final de negativos y cero del segundo sumando---------------------
                        --Genera los positivos del segundo sumando----------------------------------------------------------
                        for j in 0 to 2**(WIDTH-1)-1 loop
                            valorB := to_signed(j, WIDTH);
                            b <= std_logic_vector(valorB);
                            total := -1*2**(WIDTH-1)+i+j+1;
                            vec_total := std_logic_vector(to_signed(total, 2*WIDTH));
                            wait for DELAY;
                            --------- Genera el bit referencia para la comparacion de acarrero ----------------------
                            if total>2**(WIDTH-1)-1 or total<-1*2**(WIDTH-1) then
                                ref_des := '1';
                                else
                                ref_des := '0';
                            end if;
                            ---------------------------Bucle para chequear el resultado de la suma
                            for m in 0 to WIDTH-1 loop
                                assert res(m)=vec_total(m) report "ERROR EN LA SUMA. Obtenido/Esperado: " 
                                --& std_logic'image(res(m)) & std_logic'image(vec_total(m));
                                & std_logic'image(res(m)) & std_logic'image(vec_total(m)) & integer'image(total);
                            end loop;
                            ----------------- Chequeo del desbordamiento ----------------------------------------------------------
                            assert des = ref_des report "ERROR EN EL DESBORDAMIENTO. Obtenido/Esperado: "
                            & std_logic'image(des) & std_logic'image(ref_des) & integer'image(i) & integer'image(j);
                        end loop;
                    end loop;
                    -----------------------------------------FINAL DE LOS NEGATIVOS PRIMER SUMANDO--------------------------------------------------
                    -- Genera los positivos del primer sumando---------------------------------------------------------
                    for i in 0 to 2**(WIDTH-1)-1 loop
                        valorA := to_signed(i, WIDTH); 
                        a <= std_logic_vector(valorA);
                        --------------------------Genera los negativos y cero del segundo sumando------------------------------------
                        for j in 0 to 2**(WIDTH-1)-1 loop
                            valorB := to_signed((-1*2**(WIDTH-1))+j, WIDTH);
                            b <= std_logic_vector(valorB);
                            total := -1*2**(WIDTH-1)+i+j+1;
                            vec_total := std_logic_vector(to_signed(total, 2*WIDTH));
                            wait for DELAY;
                            --------- Genera el bit referencia para la comparacion de acarrero ----------------------
                            if total>2**(WIDTH-1)-1 or total<-1*2**(WIDTH-1) then
                                ref_des := '1';
                                else
                                ref_des := '0';
                            end if;
                            ---------------------------Bucle para chequear el resultado de la suma
                            for m in 0 to WIDTH-1 loop
                                assert res(m)=vec_total(m) report "ERROR EN LA SUMA. Obtenido/Esperado: " 
                                --& std_logic'image(res(m)) & std_logic'image(vec_total(m));
                                & std_logic'image(res(m)) & std_logic'image(vec_total(m)) & integer'image(total);
                            end loop;
                            ----------------- Chequeo del desbordamiento ----------------------------------------------------------
                            assert des = ref_des report "ERROR EN EL DESBORDAMIENTO. Obtenido/Esperado: "
                            & std_logic'image(des) & std_logic'image(ref_des) & integer'image(i) & integer'image(j);
                        end loop;
                        -------------------------------------------genera los positivos del segundo sumando---------------------------------
                        for j in 0 to 2**(WIDTH-1)-1 loop
                            valorB := to_signed(j, WIDTH);
                            b <= std_logic_vector(valorB);
                            total := i+j+1;
                            vec_total := std_logic_vector(to_signed(total, 2*WIDTH));
                            wait for DELAY;
                            --------- Genera el bit referencia para la comparacion de acarrero ----------------------
                            if total>2**(WIDTH-1)-1 or total<-1*2**(WIDTH-1) then
                                ref_des := '1';
                                else
                                ref_des := '0';
                            end if;
                            ---------------------------Bucle para chequear el resultado de la suma
                            for m in 0 to WIDTH-1 loop
                                assert res(m)=vec_total(m) report "ERROR EN LA SUMA. Obtenido/Esperado: " 
                                --& std_logic'image(res(m)) & std_logic'image(vec_total(m));
                                & std_logic'image(res(m)) & std_logic'image(vec_total(m)) & integer'image(total);
                            end loop;
                            ----------------- Chequeo del desbordamiento ----------------------------------------------------------
                            assert des = ref_des report "ERROR EN EL DESBORDAMIENTO. Obtenido/Esperado: "
                            & std_logic'image(des) & std_logic'image(ref_des) & integer'image(i) & integer'image(j);
                        end loop;
                    end loop;
                    end if;
                end loop;
                wait; -- Final de simulacion
        end process vect_test;

end architecture bp_sum3;
