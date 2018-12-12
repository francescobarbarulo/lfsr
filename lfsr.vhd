library ieee;
use ieee.std_logic_1164.all;

entity lfsr is
    generic(N_bit : integer);
    port(
        init : in std_logic_vector(N_bit - 1 downto 0);
        output : out std_logic_vector(N_bit - 1 downto 0);
        clk : in std_logic;
        rst : in std_logic  
    );
end lfsr;

architecture struct of lfsr is
    component dfc
        port(
            d : in std_logic;
            q : out std_logic;
            clk : in std_logic;
            rst : in std_logic
        );
    end component dfc;
    
    -- signals
    signal state : std_logic_vector(N_bit downto 0);
    
    begin
    	-- generation of N instances of the dfc
    	dfc_N_gen: for i in 0 to N_bit - 1  generate
        	i_dfc: dfc port map(
                            	d => state(i),
                            	q => state(i + 1),
                            	clk => clk,
                            	rst => rst
                        	);
    	end generate;

    output(N_bit - 1 downto 0) <= state(N_bit downto 1);
    --state(N_bit - 1 downto 0) <= init(N_bit - 1 downto 0);
    state(0) <= state(16) xor state(14) xor state(13) xor state(11);
    
end struct;