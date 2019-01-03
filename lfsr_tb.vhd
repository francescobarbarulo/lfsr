library ieee;
use ieee.std_logic_1164.all;

entity lfsr_tb is
end lfsr_tb;

architecture testbench of lfsr_tb is
    component lfsr is
        generic(N_bit : integer);
        port(
            -- Input of the lfsr
            lfsr_i : in std_logic_vector(N_bit - 1 downto 0);
            -- Output of the lfsr
            lfsr_o : out std_logic_vector(N_bit - 1 downto 0);
            -- Enable input
            en : in std_logic;
            -- Clock
            clk : in std_logic;
            -- Active low reset
            rst_n : in std_logic
        );
    end component;
    
    -----------------------------------------------------------
    -- constant declaration
    -----------------------------------------------------------
    -- Clock period
    constant T_CLK : time := 100 ns;
    -- Simulation time
    constant T_SIM  : time := 1000 ns;
    -- Number of bits of the lfsr
    constant N : integer := 16;
    
    -----------------------------------------------------------
    -- signals declaration
    -----------------------------------------------------------
    -- clk signal initilized to '0'
    signal clk_tb : std_logic := '0';
    -- rst_n signal initialized to '0'
    signal rst_n_tb : std_logic := '0';
    -- signal to stop the simulation
    signal stop_simulation : std_logic := '1';
    -- input of the lfsr
    signal lfsr_i_tb : std_logic_vector(N - 1 downto 0);
    -- output of the lfsr
    signal lfsr_o_tb : std_logic_vector(N - 1 downto 0);
    -- enable signal
    signal en_tb : std_logic := '0';
    
    begin
        -- clk variation
        clk_tb <= (not(clk_tb) and stop_simulation) after T_CLK/2;
        -- end simulation
        stop_simulation <= '0' after T_SIM;
        
        test_lfsr: lfsr
            generic map(N_bit => N)
            port map(
                lfsr_i => lfsr_i_tb,
                lfsr_o => lfsr_o_tb,
                en => en_tb,
                clk => clk_tb,
                rst_n => rst_n_tb
            );
            
        input_process: process(clk_tb, rst_n_tb)
            variable t : natural := 0;
            
            begin
                if(rising_edge(clk_tb)) then
                    case t is
                        when 0 => rst_n_tb <= '1';
                                  -- seed = 0xACE1 
                                  lfsr_i_tb <= "1010110011100001";   
                        when 1 => en_tb <= '1';
                        
                        when others => null;
                        
                    end case;
                    
                    -- incrementing t
                    t := t+1;
                end if;
        end process;
    end testbench;