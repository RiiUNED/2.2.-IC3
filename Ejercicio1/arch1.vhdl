------------------------------------------------------------
-- Architecture 1 de Funcion (x, y, z) = (F, G)
-- F = x'z + xy
-- G = x'y' + x'z

architecture arch1 of funcFG is
    begin
        F <= (not x and z) or (x and y);
        G <= (not x and not y) or (not x and z);
end architecture arch1;
------------------------------------------------------------
