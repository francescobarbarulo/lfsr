library ieee;
use ieee.std_logic_1164.all;

entity dff_en_tb is
end dff_en_tb;

architecture testbench of dff_en_tb is
    component dff_en is
        port(
            a : in std_logic;
            d : in std_logic;
            q : out std_logic;
            en : in std_logic;
            clk : in std_logic;
            rst_n : in std_logic
        );
    end component;
    
    -- constant declaration
    constant T_CLK : time := 100 ns;
    constant T_SIM  : time := 1000 ns;
    
    -- signals declaration
    signal clk_tb : std_logic := '0';
    signal rst_n_tb : std_logic := '1';
    signal stop_simulation : std_logic := '1';
    signal a_tb : std_logic := '0';
    signal d_tb : std_logic := '1';
    signal q_tb : std_logic;
    signal en_tb : std_logic := '0';
    
    begin
        -- clk variation
        clk_tb <= (not(clk_tb) and stop_simulation) after T_CLK / 2;
        -- end simulation
        stop_simulation <= '0' after T_SIM;
        
        test_dff_en: dff_en
            port map(
                a => a_tb,
                d => d_tb,
                q => q_tb,
                en => en_tb,
                clk => clk_tb,
                rst_n => rst_n_tb
            );
            
        input_process: process(clk_tb, rst_n_tb)
            variable t : natural := 0;
            
            begin
                if(rising_edge(clk_tb)) then
                    case t is
                        when 1 => en_tb <= '1';
                        when 2 => d_tb <= '0';
                        when 3 => d_tb <= '1';
                        when 4 => d_tb <= '0';
                        when 5 => d_tb <= '1';
                        when 6 => d_tb <= '0';
                        when 7 => d_tb <= '1';
                        
                        when others => null;
                        
                    end case;
                    
                    -- incrementing t
                    t := t+1;
                end if;
        end process;
end testbench;