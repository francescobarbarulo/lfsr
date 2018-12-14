library ieee;
use ieee.std_logic_1164.all;

entity mux is
    port(
        a : in std_logic;
        b : in std_logic;
        sel : in std_logic;
        o : out std_logic
    );
end mux;

architecture bhv of mux is
begin
    o <= (a and not sel) or (b and sel);
end bhv;