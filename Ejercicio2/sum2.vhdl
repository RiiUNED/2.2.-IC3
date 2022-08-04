------------------------------------------------------
-- sumc. Componente del ejercicio 2.
-- ENTRADA: (sum, sumc) dos números de n bits en C2.
-- ENTRADA: cin -> acarreo.
-- SALIDA: res -> resultado en C2 de sumar los números  
-- de la entrada contemplando el acarreo.
------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sum2 is
	generic (n:integer);
	port (res : out std_logic_vector(n-1 downto 0);
	a, b : in std_logic_vector(n-1 downto 0);
	cin : in std_logic);
end entity sum2;

architecture archsum2 of sum2 is
	-- Declaracion de constantes
	constant WIDTH : integer := n;
	
	-- Declaración de señales
	signal sum, sumc : std_logic_vector(n-1 downto 0) := (others => '0');
	
	begin
		--Instanciación y conexión de los componentes
		s : entity work.sum1(archsum1) generic map (WIDTH) port map (sum, sumc, a, b);
		m : entity work.mux2a1(archmux) generic map (WIDTH) port map (res, sum, sumc, cin);
end architecture archsum2;


