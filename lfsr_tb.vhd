library ieee;
use ieee.std_logic_1164.all;

entity lfsr_tb is
end lfsr_tb;

architecture testbench of lfsr_tb is
    component lfsr is
        generic(N_bit : integer);
        port(
            lfsr_i : in std_logic_vector(N_bit - 1 downto 0);
            lfsr_o : out std_logic_vector(N_bit - 1 downto 0);
            en : in std_logic;
            clk : in std_logic;
            rst_n : in std_logic
        );
    end component;
    
    -- constant declaration
    constant T_CLK : time := 100 ns;
    constant T_SIM  : time := 1000 ns;
    constant N_bit : integer := 16;
    
    -- signals declaration
    signal clk_tb : std_logic := '0';
    signal rst_n_tb : std_logic := '0';
    signal stop_simulation : std_logic := '1';
    signal lfsr_i_tb : std_logic_vector(N_bit - 1 downto 0);
    signal lfsr_o_tb : std_logic_vector(N_bit - 1 downto 0);
    signal en_tb : std_logic := '0';
    
    begin
        -- clk variation
        clk_tb <= (not(clk_tb) and stop_simulation) after T_CLK / 2;
        -- end simulation
        stop_simulation <= '0' after T_SIM;
        
        test_lfsr: lfsr
            generic map(N_bit => 16)
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
                if(rising_edge(clk_tb) ) then
                    case t is
                        when 0 => lfsr_i_tb <= "1010110011100001";
			            when 1 => rst_n_tb <= '1';
			            when 5 => en_tb <= '1';
                        when others => null;
                        
                    end case;
                    
                    -- incrementing t
                    t := t+1;
                end if;
        end process;
    end testbench;