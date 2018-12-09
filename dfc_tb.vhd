library ieee;
use ieee.std_logic_1164.all;

entity dfc_tb is
end dfc_tb;

architecture testbench of dfc_tb is
    component dfc is
        port(
            d : in std_logic;
            q : out std_logic;
            clk : in std_logic;
            rst : in std_logic
        );
    end component;
    
    -- constant declaration
    constant T_CLK : time := 100 ns;
    constant T_SIM  : time := 1000 ns;
    
    -- signals declaration
    signal clk_tb : std_logic := '0';
    signal rst_tb : std_logic := '1';
    signal stop_simulation : std_logic := '1';
    signal d_tb : std_logic;
    signal q_tb : std_logic;
    
    begin
        -- clk variation
        clk_tb <= (not(clk_tb) and stop_simulation) after T_CLK / 2;
        -- end simulation
        stop_simulation <= '0' after T_SIM;
        
        test_dfc: dfc
            port map(
                d => d_tb,
                q => q_tb,
                clk => clk_tb,
                rst => rst_tb
            );
            
        input_process: process(clk_tb, rst_tb)
            variable t : natural := 0;
            
            begin
                if(rising_edge(clk_tb) ) then
                    case t is
                        when 0 => d_tb <= '0';
                        when 1 => d_tb <= '1';
                        when 2 => d_tb <= '0';
                        when 3 => d_tb <= '1';
                        when 4 => d_tb <= '0';
                        when 5 => d_tb <= '1';
                        
                        when others => null;
                        
                    end case;
                    
                    -- incrementing t
                    t := t+1;
                end if;
        end process;
end testbench;