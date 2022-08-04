---------------------------------------------------------------------------------------
--banco de pruebas del componente check0 del ejercico 2
---------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bp_checkzero is
    constant DELAY : time := 20 ns; --Retardo usado en el test
end entity bp_checkzero;

architecture bp_checkzero of bp_checkzero is
    constant WIDTH : integer := 3;
    signal num : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal zero : std_logic;

    begin
        UUT : entity work.checkzero(archcheckzero) generic map (WIDTH) port map (zero, num);

        vect_test : process is
            variable valor : signed(WIDTH-1 downto 0);

            begin
                --Genera todos los posibles valores de entrada
                --Genera los negativos y el cero
                for i in 0 to 2**(WIDTH-1)-1 loop
                    valor := to_signed((-1*2**(WIDTH-1))+i, WIDTH);
                    num <= std_logic_vector(valor);
                    wait for DELAY;
                end loop;
                --Genera los negativos
                for i in 0 to 2**(WIDTH-1)-1 loop
                    valor := to_signed(i, WIDTH);
                    num <= std_logic_vector(valor);
                    wait for DELAY;
                end loop;
                wait;
        end process vect_test;
end architecture bp_checkzero;


