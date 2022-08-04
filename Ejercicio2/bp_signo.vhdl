---------------------------------------------------------------------------
-- Banco de pruebas del componente signo del ejercicio 2
---------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bp_signo is
    constant DELAY : time := 20 ns; -- Retardo usado en el test
end entity bp_signo;

architecture bp_signo of bp_signo is
    constant WIDTH : integer := 3;
    signal num1, num2 :std_logic_vector(WIDTH-1 downto 0):= (others => '0');
    signal sig1, sig2 : std_logic;

    begin
	UTT1 : entity work.signo(archsigno) generic map (WIDTH) port map (sig1, num1);
	UTT2 : entity work.signo(archsigno) generic map (WIDTH) port map (sig2, num2);

        vect_test : process is
            variable valor1 : unsigned (WIDTH-1 downto 0);
            variable valor2 : unsigned (WIDTH-1 downto 0);
            begin
                for i in 0 to (2**WIDTH)-1 loop
                    if i mod 2 = 0 then
                        valor1 := to_unsigned((2**WIDTH)-1-i, WIDTH);
                        valor2 := to_unsigned(i, WIDTH);
                        else
                        valor2 := to_unsigned((2**WIDTH)-1-i, WIDTH);
                        valor1 := to_unsigned(i, WIDTH);
                    end if;
                    num1 <= std_logic_vector(valor1);
                    num2 <= std_logic_vector(valor2);
                    wait for DELAY;
                end loop;
                wait; -- Final de la simulacion
        end process vect_test; 

end architecture bp_signo;


