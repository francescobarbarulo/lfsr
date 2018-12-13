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
    mux_p: process(sel)
    begin
        if sel = '0' then
            o <= a;
        else
            o <= b;
        end if;
end process mux_p;
end bhv;