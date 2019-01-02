library ieee;
use ieee.std_logic_1164.all;

entity dff_en is
    port(
        -- Input of the dff_en
        a : in std_logic;
        -- Input of the dff_en
        d : in std_logic;
        -- Output of the dff_en
        q : out std_logic;
        -- Enable of the dff_en
        en : in std_logic;
        -- Clock
        clk : in std_logic;
        -- Active low reset
        rst_n : in std_logic  
    );
end dff_en;

architecture rtl of dff_en is
    -- Input of the D-flip-flop which can take two
    -- different values depending on en
    signal d_s: std_logic;
    
    begin
        dff_p: process(clk, rst_n)
            -- Standard behavior of the flip-flop
            begin
                if (rst_n = '0') then
                    q <= '0';
                elsif (rising_edge(clk)) then
                    q <= d_s;
                end if;
            end process;
        -- If enable is 1 the flip-flop stores a
        -- else it stores d
        d_s <= d when en = '1' else a;
end rtl;
    