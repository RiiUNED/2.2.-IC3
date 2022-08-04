---------------------------------------------------------
-- Banco de pruebas del componente mux2a1 del ejercicio 2
---------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bp_mux is
    constant DELAY : time := 20 ns; -- Retardo usado en el test
end entity bp_mux;

architecture bp_mux of bp_mux is
    constant WIDTH : integer := 3;
    signal res, sum, sumc :std_logic_vector(WIDTH-1 downto 0);
    signal cin : std_logic;
    signal aux : std_logic_vector (WIDTH downto 0) := (others => '0');
    signal auxc : std_logic_vector (WIDTH downto 0) := (0 => '1', others => '0');
 
    begin
        UUT : entity work.mux2a1(archmux) generic map (WIDTH) port map (res, sum, sumc, cin);

        vect_test : process is
            variable valor1 : unsigned (WIDTH downto 0);
            variable valor2 : unsigned (WIDTH downto 0);

            begin
                for i in 1+2 to (2**(WIDTH-1))+2 loop
                    valor1 := to_unsigned(i-1, WIDTH+1);
                    valor2 := to_unsigned(i, WIDTH+1);
                    aux <= std_logic_vector(valor1);
                    auxc <= std_logic_vector(valor2);
                    sum <= aux (WIDTH-1 downto 0);
                    sumc <= auxc (WIDTH-1 downto 0);
                    cin <= '0';
                    wait for DELAY;
                    cin <= '1';
                    wait for DELAY;
                end loop;
                wait; -- Final de la simulacion
        end process vect_test; 

end architecture bp_mux;
