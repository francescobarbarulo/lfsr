library ieee;
use ieee.std_logic_1164.all;

entity dff_en is
    port(
        a : in std_logic;
        d : in std_logic;
        q : out std_logic;
        en : in std_logic;
        clk : in std_logic;
        rst_n : in std_logic  
    );
end dff_en;

architecture rtl of dff_en is
    signal d_s: std_logic;
    
    begin
        dff_p: process(clk, rst_n)
            begin
                if (rst_n = '0') then
                    q <= '0';
                elsif (rising_edge(clk)) then
                    q <= d_s;
                end if;
            end process;
        
        d_s <= d when en = '1' else a;
end rtl;
    