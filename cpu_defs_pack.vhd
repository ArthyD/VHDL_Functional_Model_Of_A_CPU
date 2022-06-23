----------------------------------------------------------------------------------
-- TUM VHDL Assignment
-- Arthur Docquois, Maelys Chevrier, Timothée Carel, Roman Canals
-- 
-- Create Date: 06/06/2022
-- Project Name: CPU Functional model

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


package cpu_defs_pack is
    
    -- DEFINITION OF TYPES --
    constant bus_width : natural := 12;
    constant data_width : natural := bus_width;
    constant addr_width : natural := bus_width;

    constant reg_addr_width : natural := 2;
    constant opcode_width : natural := 6;

    subtype data_type is
        bit_vector(data_width-1 downto 0);
    
    subtype addr_type is
        bit_vector(addr_width-1 downto 0);
    
    subtype reg_addr_type is
        bit_vector(reg_addr_width-1 downto 0);
    
    subtype opcode_type is
        bit_vector(opcode_width-1 downto 0);

    type reg_type is array(integer range 0 to 2**reg_addr_width-1) of data_type;

    type mem_type is array(integer range 0 to 2**addr_width-1) of data_type;

    -- DEFINITION OF OPCODE --
    constant code_nop : opcode_type := "000000";
    constant code_stop : opcode_type := "000001";
    -- Register instruction --
    constant code_ldc : opcode_type := "100000";
    constant code_ldd : opcode_type := "100001";
    constant code_ldr : opcode_type := "100010";
    constant code_std : opcode_type := "100011";
    constant code_str : opcode_type := "100100";
    -- Jump instruction --
    constant code_jmp : opcode_type := "110000";
    constant code_jz : opcode_type := "110001";
    constant code_jc : opcode_type := "110010";
    constant code_jn : opcode_type := "110011";
    constant code_jo : opcode_type := "110100";
    constant code_jnz : opcode_type := "110101";
    constant code_jnn : opcode_type := "110111";
    constant code_jno : opcode_type := "111000";
    -- Logic and arithmetic instruction --
    constant code_not : opcode_type := "000110";
    constant code_and : opcode_type := "000111";
    constant code_add : opcode_type := "000010";
    constant code_addc : opcode_type := "000011";
    -- load and store PC instructions --
    constant code_ldpc : opcode_type := "100111";
    constant code_stpc : opcode_type := "101000";


    -- DEFINITION OF MNEMONIC CODE FOR TRACE --
    constant mnemonic_nop : string( 1 to 3 ) := "nop";
    constant mnemonic_stop: string( 1 to 4 ) := "stop";
    -- Register instruction --
    constant mnemonic_ldc : string( 1 to 3 ) := "ldc";
    constant mnemonic_ldd : string( 1 to 3 ) := "ldd";
    constant mnemonic_ldr : string( 1 to 3 ) := "ldr";
    constant mnemonic_std : string( 1 to 3 ) := "std";
    constant mnemonic_str : string( 1 to 3 ) := "str";
    -- Jump instruction --
    constant mnemonic_jmp : string( 1 to 3 ) := "jmp";
    constant mnemonic_jz : string( 1 to 2 ) := "jz";
    constant mnemonic_jc : string( 1 to 2 ) := "jc";
    constant mnemonic_jn : string( 1 to 2 ) := "jn";
    constant mnemonic_jo : string( 1 to 2 ) := "jo";
    constant mnemonic_jnz : string( 1 to 3 ) := "jnz";
    constant mnemonic_jno : string( 1 to 3 ) := "jno";
    constant mnemonic_jnn : string( 1 to 3 ) := "jnn";
    -- Logic and arithmetic instruction --
    constant mnemonic_not : string( 1 to 3 ) := "not";
    constant mnemonic_and : string( 1 to 3 ) := "and";
    constant mnemonic_add : string( 1 to 3 ) := "add";
    constant mnemonic_addc : string( 1 to 4 ) := "addc";
    -- load and store PC instructions --
    constant mnemonic_ldpc: string( 1 to 4 ) := "ldpc";
    constant mnemonic_stpc: string( 1 to 4 ) := "stpc";
    
    -- FUNCTIONS AND PROCEDURES --
    function get (
        constant Memory : in mem_type;
        constant addr : in addr_type )
        return data_type;
    procedure set (
        variable Memory : inout mem_type;
        constant addr : in addr_type;
        constant data : in data_type ); 

end cpu_defs_pack;


package body cpu_defs_pack is
    function get (
        constant Memory : in mem_type;
        constant addr : in addr_type ) return data_type is
        begin
            return Memory(to_integer(unsigned(to_stdlogicvector(addr))));
    end get;

    procedure set (
        variable Memory : inout mem_type;
        constant addr : in addr_type;
        constant data : in data_type ) is
        begin
            Memory(to_integer(unsigned(to_stdlogicvector(addr)))) := data;
    end set;

end cpu_defs_pack;