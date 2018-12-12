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
                if (rst = '0') then
                    q <= '0';
                elsif (rising_edge(clk)) then
                    q <= d;
                end if;
        end process;
end bhv;
    