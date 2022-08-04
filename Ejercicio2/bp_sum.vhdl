----------------------------------------------------------------------------------------------------
-- Banco de pruebas del ejercico 2
----------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bp_sum is
    constant DELAY : time := 20 ns; -- Retardo usado en el test
end entity bp_sum;

architecture bp_sum of bp_sum is
    constant WIDTH : integer := 4;
    signal a, b : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal res : std_logic_vector(WIDTH-1 downto 0);
    signal cin, des, zero, sig : std_logic;

    procedure gen_ref (total, WIDTH : in integer;
    			ref_des, ref_zero, ref_signo : out std_logic) is

        begin
        --------- Genera el bit referencia para la comparacion de acarrero ----------------------
        	if total>2**(WIDTH-1)-1 or total<-1*2**(WIDTH-1) then
            	ref_des := '1';
                else
                ref_des := '0';
            end if;
        --------- Genera el bit referencia para la comparacion de cero----------------------
        	if total = 0 then
        		ref_zero := '1';
            	else
         		ref_zero := '0';
        	end if;
        --------- Genera el bit referencia para la comparacion de signo ----------------------
            if total < 0 then
            	ref_signo := '1';
                else
                ref_signo := '0';
            end if;
    end procedure gen_ref;
    
    procedure check_error(zero, ref_zero, sig, ref_signo, ref_des : in std_logic;
    				num_errores : inout integer) is
    	begin
   	        ----------------Chequeo de cero ---------------------------------------------------
        	assert zero = ref_zero report "ERROR EN EL CERO. Obtenido/Esperado: "
            & std_logic'image(zero) & std_logic'image(ref_zero);
            -- contador de errores
            if zero /= ref_zero then
                num_errores := num_errores + 1;
            end if;
            --------------------------Chequeo de signo ---------------------------------------------------
            if ref_des = '0' then
                assert sig = ref_signo report "ERROR EN EL SIGNO. Obtenido/Esperado: "
            	& std_logic'image(sig) & std_logic'image(ref_signo);
            	-- contador de errores
            	if sig /= ref_signo then
            		num_errores := num_errores + 1;
                end if;
            end if;
    end procedure check_error;

    begin
        UUT : entity work.sum(archsum) generic map (WIDTH) port map (res, des, zero, sig, a, b, cin); 

        vect_test : process is
            variable valorA : signed (WIDTH-1 downto 0);
            variable valorB : signed (WIDTH-1 downto 0);
            variable total : integer;
            variable vec_total : std_logic_vector(2*WIDTH-1 downto 0);
            variable ref_des : std_logic;
            variable ref_zero : std_logic;
            variable ref_signo : std_logic;
            variable num_errores : integer := 0;
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
                            -- GENERACION DE REFERENCIAS
                            -- Genera el resultado referencia para chequeo de errores
                            total := -1*2**(WIDTH)+i+j;
                            vec_total := std_logic_vector(to_signed(total, 2*WIDTH));
                            wait for DELAY;
                            -- Genera el resto de referecias
                            gen_ref(total, WIDTH, ref_des, ref_zero, ref_signo);
                            -- CHEQUEO
                            ---------------------------Bucle para chequear el resultado de la suma
                            for m in 0 to WIDTH-1 loop
                                assert res(m)=vec_total(m) report "ERROR EN LA SUMA. Obtenido/Esperado: " 
                                & std_logic'image(res(m)) & std_logic'image(vec_total(m));
                                -- contador de errores
                                if res(m) /= vec_total(m) then
                                    num_errores := num_errores + 1;
                                end if;
                            end loop;
                            ----------------- Chequeo del desbordamiento ----------------------------------------------------------
                            assert des = ref_des report "ERROR EN EL DESBORDAMIENTO. Obtenido/Esperado: "
                            & std_logic'image(des) & std_logic'image(ref_des);
                            -- contador de errores
                            if des /= ref_des then
                                num_errores := num_errores + 1;
                            end if;
                            --------------- Chequeo el resto de senales de salida y contador errores ------------------------------
                            check_error(zero, ref_zero, sig, ref_signo, ref_des, num_errores);
                        end loop;
                        -----------------------------Final de negativos y cero del segundo sumando---------------------
                        --Genera los positivos del segundo sumando----------------------------------------------------------
                        for j in 0 to 2**(WIDTH-1)-1 loop
                            valorB := to_signed(j, WIDTH);
                            b <= std_logic_vector(valorB);
                            -- GENERACIÓN DE REFERENCIAS
                            -- Genera el resultado referencia para el chequeo de errores
                            total := -1*2**(WIDTH-1)+i+j;
                            vec_total := std_logic_vector(to_signed(total, 2*WIDTH));
                            wait for DELAY;
                            --------- Genera el resto de referencias
                            gen_ref(total, WIDTH, ref_des, ref_zero, ref_signo);
                            -- CHEQUEO
                            ---------------------------Bucle para chequear el resultado de la suma
                            for m in 0 to WIDTH-1 loop
                                assert res(m)=vec_total(m) report "ERROR EN LA SUMA. Obtenido/Esperado: " 
                                & std_logic'image(res(m)) & std_logic'image(vec_total(m));
                                -- contador errores
                                if res(m) /= vec_total(m) then
                                    num_errores := num_errores +1;
                                end if;
                            end loop;
                            ----------------- Chequeo del desbordamiento ----------------------------------------------------------
                            assert des = ref_des report "ERROR EN EL DESBORDAMIENTO. Obtenido/Esperado: "
                            & std_logic'image(des) & std_logic'image(ref_des);
                            -- contador errores
                            if des /= ref_des then
                                num_errores := num_errores + 1;
                            end if;
                            ------- Chequeo del resto de senales de salida y contrador de errores ----------------------------------
                            check_error(zero, ref_zero, sig, ref_signo, ref_des, num_errores);
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
                            -- GENERACION DE REFERENCIAS
                            -- Genera el resultado referencia para chequeo de errores
                            total := -1*2**(WIDTH-1)+i+j;
                            vec_total := std_logic_vector(to_signed(total, 2*WIDTH));
                            wait for DELAY;
                            --------- Genera el resto de referencias -----------------------------------
                            gen_ref(total, WIDTH, ref_des, ref_zero, ref_signo); 
                            -- CHEQUEO
                            ---------------------------Bucle para chequear el resultado de la suma
                            for m in 0 to WIDTH-1 loop
                                assert res(m)=vec_total(m) report "ERROR EN LA SUMA. Obtenido/Esperado: " 
                                & std_logic'image(res(m)) & std_logic'image(vec_total(m));
                                -- contador errores
                                if res(m) /= vec_total(m) then
                                    num_errores := num_errores + 1;
                                end if;
                            end loop;
                            ----------------- Chequeo del desbordamiento ----------------------------------------------------------
                            assert des = ref_des report "ERROR EN EL DESBORDAMIENTO. Obtenido/Esperado: "
                            & std_logic'image(des) & std_logic'image(ref_des);
                            -- contador errores
                            if des /= ref_des then
                                num_errores := num_errores + 1;
                            end if;
                            -------------- Chequeo el resto de senales de salida y contador errores
                            check_error(zero, ref_zero, sig, ref_signo, ref_des, num_errores);
                        end loop;
                        -------------------------------------------genera los positivos del segundo sumando---------------------------------
                        for j in 0 to 2**(WIDTH-1)-1 loop
                            valorB := to_signed(j, WIDTH);
                            b <= std_logic_vector(valorB);
                            -- GENERACION DE REFERENCIAS
                            -- Genera el resultado referencia para el chequeo de errores
                            total := i+j;
                            vec_total := std_logic_vector(to_signed(total, 2*WIDTH));
                            wait for DELAY;
                            --------- Genera el resto de referencias
                            gen_ref(total, WIDTH, ref_des, ref_zero, ref_signo);
                            -- CHEQUEO
                            ---------------------------Bucle para chequear el resultado de la suma
                            for m in 0 to WIDTH-1 loop
                                assert res(m)=vec_total(m) report "ERROR EN LA SUMA. Obtenido/Esperado: " 
                                & std_logic'image(res(m)) & std_logic'image(vec_total(m));
                                -- contador de errores
                                if res(m) /= vec_total(m) then
                                    num_errores := num_errores + 1;
                                end if;
                            end loop;
                            ----------------- Chequeo del desbordamiento ----------------------------------------------------------
                            assert des = ref_des report "ERROR EN EL DESBORDAMIENTO. Obtenido/Esperado: "
                            & std_logic'image(des) & std_logic'image(ref_des);
                            -- contador de errores
                            if des /= ref_des then
                                num_errores := num_errores + 1;
                            end if;
                            ------- Chequeo el resto de senales de salida y contador de errores ----------------------------------------------
                            check_error(zero, ref_zero, sig, ref_signo, ref_des, num_errores);
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
                            -- GENERACION DE REFERENCIAS
                            -- Genera el resultado referencia para chequeo de errores
                            total := -1*2**(WIDTH)+i+j+1;
                            vec_total := std_logic_vector(to_signed(total, 2*WIDTH));
                            wait for DELAY;
                            --------- Genera el resto de referencias
                            gen_ref(total, WIDTH, ref_des, ref_zero, ref_signo);
                            --CHEQUEO
                            ---------------------------Bucle para chequear el resultado de la suma
                            for m in 0 to WIDTH-1 loop
                                assert res(m)=vec_total(m) report "ERROR EN LA SUMA. Obtenido/Esperado: " 
                                & std_logic'image(res(m)) & std_logic'image(vec_total(m)); 
                                -- contador de errores
                                if res(m) /= vec_total(m) then
                                    num_errores := num_errores + 1;
                                end if;
                            end loop;
                            ----------------- Chequeo del desbordamiento ----------------------------------------------------------
                            assert des = ref_des report "ERROR EN EL DESBORDAMIENTO. Obtenido/Esperado: "
                            & std_logic'image(des) & std_logic'image(ref_des);
                            -- contador de errores
                            if des /= ref_des then
                                num_errores := num_errores + 1;
                            end if;
                            ------ Chequeo del resto de senales de salida y contador de errores -----------------------------------
                            check_error(zero, ref_zero, sig, ref_signo, ref_des, num_errores); 
                        end loop;
                        -----------------------------Final de negativos y cero del segundo sumando---------------------
                        --Genera los positivos del segundo sumando----------------------------------------------------------
                        for j in 0 to 2**(WIDTH-1)-1 loop
                            valorB := to_signed(j, WIDTH);
                            b <= std_logic_vector(valorB);
                            -- GENERACION DE REFERENCIAS
                            -- Genera el resultado referencia para el chequeo de errores
                            total := -1*2**(WIDTH-1)+i+j+1;
                            vec_total := std_logic_vector(to_signed(total, 2*WIDTH));
                            wait for DELAY;
                            --------- Genera el resto de referencias
                            gen_ref(total, WIDTH, ref_des, ref_zero, ref_signo);
                            -- CHEQUEO
                            ---------------------------Bucle para chequear el resultado de la suma
                            for m in 0 to WIDTH-1 loop
                                assert res(m)=vec_total(m) report "ERROR EN LA SUMA. Obtenido/Esperado: " 
                                & std_logic'image(res(m)) & std_logic'image(vec_total(m));
                                -- contador de errores
                                if res(m) /= vec_total(m) then 
                                    num_errores := num_errores + 1;
                                end if;
                            end loop;
                            ----------------- Chequeo del desbordamiento ----------------------------------------------------------
                            assert des = ref_des report "ERROR EN EL DESBORDAMIENTO. Obtenido/Esperado: "
                            & std_logic'image(des) & std_logic'image(ref_des);
                            --contador de errores
                            if des /= ref_des then 
                                num_errores := num_errores + 1;
                            end if;
                            --------------- Chequeo el resto de senales de salida y contador de errores -------------------------
                            check_error(zero, ref_zero, sig, ref_signo, ref_des, num_errores);
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
                            -- GENERACION DE REFERENCIAS
                            -- Genera el resultado referencia para chequeo de errores
                            total := -1*2**(WIDTH-1)+i+j+1;
                            vec_total := std_logic_vector(to_signed(total, 2*WIDTH));
                            wait for DELAY;
                            --------- Genera el resto de referencias
                            gen_ref(total, WIDTH, ref_des, ref_zero, ref_signo);
                            -- CHEQUEO
                            ---------------------------Bucle para chequear el resultado de la suma
                            for m in 0 to WIDTH-1 loop
                                assert res(m)=vec_total(m) report "ERROR EN LA SUMA. Obtenido/Esperado: " 
                                & std_logic'image(res(m)) & std_logic'image(vec_total(m));
                                -- contador errores
                                if res(m) /= vec_total(m) then
                                    num_errores := num_errores + 1;
                                end if;
                            end loop;
                            ----------------- Chequeo del desbordamiento ----------------------------------------------------------
                            assert des = ref_des report "ERROR EN EL DESBORDAMIENTO. Obtenido/Esperado: "
                            & std_logic'image(des) & std_logic'image(ref_des);
                            -- contador de errores
                            if des /= ref_des then
                                num_errores := num_errores + 1;
                            end if; 
                            ----------------------- Chequeo el resto de senales de salida y contador errores -------------
                            check_error(zero, ref_zero, sig, ref_signo, ref_des, num_errores);
                        end loop;
                        -------------------------------------------genera los positivos del segundo sumando---------------------------------
                        for j in 0 to 2**(WIDTH-1)-1 loop
                            valorB := to_signed(j, WIDTH);
                            b <= std_logic_vector(valorB);
                            -- GENERACION DE REFERENCIAS
                            -- Genera el resultado de referencia para el chequeo de errores
                            total := i+j+1;
                            vec_total := std_logic_vector(to_signed(total, 2*WIDTH));
                            wait for DELAY;
                            --------- Genera el resto de referencias
                            gen_ref(total, WIDTH, ref_des, ref_zero, ref_signo);
                            -- CHEQUEO
                            ---------------------------Bucle para chequear el resultado de la suma
                            for m in 0 to WIDTH-1 loop
                                assert res(m)=vec_total(m) report "ERROR EN LA SUMA. Obtenido/Esperado: " 
                                & std_logic'image(res(m)) & std_logic'image(vec_total(m));
                                -- contador de errores
                                if res(m) /= vec_total(m) then
                                    num_errores := num_errores + 1;
                                end if;
                            end loop;
                            ----------------- Chequeo del desbordamiento ----------------------------------------------------------
                            assert des = ref_des report "ERROR EN EL DESBORDAMIENTO. Obtenido/Esperado: "
                            & std_logic'image(des) & std_logic'image(ref_des);
                            -- contador de errores
                            if des /= ref_des then 
                                num_errores := num_errores + 1;
                            end if;
                            ---------- Chequeo del resto de senales de salida y contador errores --------------------------------------
                            check_error(zero, ref_zero, sig, ref_signo, ref_des, num_errores);
                        end loop;
                    end loop;
                    end if;
                end loop;
                --Salida por consola del numero de errores
                --condicion 3 del enunciado
                report "TEST COMPLETO. HAY " & integer'image(num_errores) & " ERRORES.";
                wait; -- Final de simulacion
        end process vect_test;

end architecture bp_sum;


