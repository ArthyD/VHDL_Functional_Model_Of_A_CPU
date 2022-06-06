----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/20/2022 03:09:53 PM
-- Design Name: 
-- Module Name: fsm - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
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
    constant bus_width : natural := 12;
    constant data_width : natural := bus_width;
    constant addre_width : natural := bus_width;

    constant reg_addr-width : natural := 2;
    constant opcode_width : natural := 6;

    subtype data_type is
        natural range 0 to 2**data_width-1;
    
    subtype addr_type is
        natural range 0 to 2**addr_width-1;
    
    subtype reg_addr_type is
        natural range 0 to 2**reg_addr_width-1;
    
    subtype opcode_type is
        natural range 0 to 2**opcode_width-1;

    type reg_type is array(reg_addr_type) of data_type;

    type mem_type is array(addr_type) of data_type;

    constant code_no : opcode_type := 000000;
    constant code_stop : opcode_type := 000001;
    constant code_ldc : opcode_type := 100000;
    constant code_ldd : opcode_type := 100001;
    constant code_ldr : opcode_type := 100010;
    constant code_std : opcode_type := 100011;
    constant code_str : opcode_type := 100100;
    constant code_jmp : opcode_type := 110000;
    constant code_jz : opcode_type := 110001;
    constant code_jc : opcode_type := 110010;
    constant code_jn : opcode_type := 110011;
    constant code_jo : opcode_type := 110100;
    constant code_jnz : opcode_type := 110101;
    constant code_jnn : opcode_type := 110111;
    constant code_jno : opcode_type := 111000;
end cpu_defs_pack;