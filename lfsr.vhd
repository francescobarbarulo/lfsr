library ieee;
use ieee.std_logic_1164.all;

entity lfsr is
    generic(N_bit : integer := 16);
    port(
        lfsr_i : in std_logic_vector(N_bit - 1 downto 0);
        lfsr_o : out std_logic_vector(N_bit - 1 downto 0);
        en : in std_logic;
        clk : in std_logic;
        rst_n : in std_logic  
    );
end lfsr;

architecture struct of lfsr is
    component dff_en
        port(
            a : in std_logic;
            d : in std_logic;
            q : out std_logic;
            en : in std_logic;
            clk : in std_logic;
            rst_n : in std_logic 
        );
    end component dff_en;
    
    -- signals
    signal d_i : std_logic_vector(N_bit downto 0);
    
    begin
    	-- generation of N instances of the dfc
    	dff_en_N_gen: for i in 0 to N_bit - 1 generate
        	i_dff_en: dff_en port map(
                                a => lfsr_i(i),
                            	d => d_i(i + 1),
                            	q => d_i(i),
                                en => en,
                            	clk => clk,
                            	rst_n => rst_n
                        	);
    	end generate;

    lfsr_o(N_bit - 1 downto 0) <= d_i(N_bit - 1 downto 0);
    d_i(16) <= d_i(0) xor d_i(2) xor d_i(3) xor d_i(5);
    
end struct;