library ieee;
use ieee.std_logic_1164.all;

entity lfsr is
    generic(N_bit : integer := 16);
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
end lfsr;

architecture struct of lfsr is
    -- Component declaration
    component dff_en
        port(
            -- Input of the dff_en
            a : in std_logic;
            -- Input of the dff_en
            d : in std_logic;
            -- Output of the dff_en
            q : out std_logic;
            -- Enable input
            en : in std_logic;
            -- Clock
            clk : in std_logic;
            -- Active low reset
            rst_n : in std_logic 
        );
    end component dff_en;
    
    -- Vector used to contain the internal q signals
    -- which feed the next dff_en
    signal d_i : std_logic_vector(N_bit downto 0);
    
    begin
        -- generation of N instances of the dff_en
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

    -- Output mapping
    lfsr_o(N_bit - 1 downto 0) <= d_i(N_bit - 1 downto 0);
    -- XOR taps to create the feedback signal 
    -- according to the polynomial
    d_i(16) <= d_i(0) xor d_i(2) xor d_i(3) xor d_i(5);
    
end struct;