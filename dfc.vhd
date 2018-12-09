library ieee;
use ieee.std_logic_1164.all;

entity dfc is
    port(
        d : in std_logic;
        q : out std_logic;
        clk : in std_logic;
        rst : in std_logic  
    );
end dfc;

architecture bhv of dfc is
    begin
        dfc_process: process(clk, rst)
            begin
                if (rising_edge(clk) and rst = '1') then
                    q <= d;
                end if;
        end process;
end bhv;
    