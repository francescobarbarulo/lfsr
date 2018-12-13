library ieee;
use ieee.std_logic_1164.all;

entity lfsr_tb is
end lfsr_tb;

architecture testbench of lfsr_tb is
    component lfsr is
        generic(N_bit : integer);
        port(
            init : in std_logic_vector(N_bit - 1 downto 0);
	    sel : in std_logic;
            output : out std_logic_vector(N_bit - 1 downto 0);
            clk : in std_logic;
            rst : in std_logic
        );
    end component;
    
    -- constant declaration
    constant T_CLK : time := 100 ns;
    constant T_SIM  : time := 10000 ns;
    constant N_bit : integer := 16;
    
    -- signals declaration
    signal clk_tb : std_logic := '0';
    signal rst_tb : std_logic := '0';
    signal stop_simulation : std_logic := '1';
    signal init_tb : std_logic_vector(N_bit - 1 downto 0);
    signal output_tb : std_logic_vector(N_bit - 1 downto 0);
    signal sel_tb : std_logic := '1';
    
    begin
        -- clk variation
        clk_tb <= (not(clk_tb) and stop_simulation) after T_CLK / 2;
        -- end simulation
        stop_simulation <= '0' after T_SIM;
        
        test_lfsr: lfsr
            generic map(N_bit => 16)
            port map(
                init => init_tb,
		sel => sel_tb,
                output => output_tb,
                clk => clk_tb,
                rst => rst_tb
            );
            
        input_process: process(clk_tb, rst_tb)
            variable t : natural := 0;
            
            begin
                if(rising_edge(clk_tb) ) then
                    case t is
                        when 0 => init_tb <= "1010110011100001";
			when 1 => rst_tb <= '1'; sel_tb <= '0';
			when 3 => sel_tb <= '1';
                        when others => null;
                        
                    end case;
                    
                    -- incrementing t
                    t := t+1;
                end if;
        end process;
    end testbench;