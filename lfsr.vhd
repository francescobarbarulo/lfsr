library ieee;
use ieee.std_logic_1164.all;

entity lfsr is
    generic(N_bit : integer);
    port(
        init : in std_logic_vector(N_bit - 1 downto 0);
        sel : in std_logic;
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

    component mux
	port(
	    a : in std_logic;
	    b : in std_logic;
	    sel : in std_logic;
	    o : out std_logic
	);
    end component;
    
    -- signals
    signal state : std_logic_vector(N_bit downto 0);
    signal o_mux_int : std_logic_vector(N_bit - 1 downto 0);
    
    begin
    	-- generation of N instances of the dfc
    	dfc_mux_N_gen: for i in 0 to N_bit - 1  generate
                i_mux : mux port map(
                                a => init(i),
                                b => state(i),
                                sel => sel,
                                o => o_mux_int(i)
                            );
        	i_dfc: dfc port map(
                            	d => o_mux_int(i),
                            	q => state(i + 1),
                            	clk => clk,
                            	rst => rst
                        	);
    	end generate;

    output(N_bit - 1 downto 0) <= state(N_bit downto 1);
    state(0) <= state(16) xor state(14) xor state(13) xor state(11);
    
end struct;