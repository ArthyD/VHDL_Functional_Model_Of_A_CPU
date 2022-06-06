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

use assignmentCPU.cpu_defs_pack.all;
use std.textio.all;

package cpu_trace_pack is
    procedure print_header( variable f : out text );

    procedure print_tail( variable f : out text );

    procedure write_PC_CMD (variable l: inout line;
        constant PC: in data_type;
        constant OP: in opcode_type;
        constant X,Y,Z: in reg_addr_type);

    procedure write_param (variable l: inout line;
        constant P : in data_type);

    procedure write_no_param (variable l: inout line);

    procedure write_regs (variable l: inout line;
        constant Reg: in reg_type;
        constant Z,CO,N,O : in Boolean);

    function cmd_image( cmd : opcode_type )
        return string; 
    
    function hex_image( d : data_type )
        return string;

end cpu_trace_pack;
    
package body cpu_trace_pack is
    procedure print_header( variable f : out text ) is
        begin
            write( l , "PC", left, 3);
            write( l , string‘(" | ") );
            write( l , "Cmd", left, 4);
            write( l , string‘(" | ") );
            write( l , "XYZ", left, 3);
            write( l , string‘(" | ") );
            write( l , "P", left, 3);
            write( l , string‘(" | ") );
            write( l , "R0", left, 3);
            write( l , string‘(" | ") );
            write( l , "R1", left, 3);
            write( l , string‘(" | ") );
            write( l , "R2", left, 3);
            write( l , string‘(" | ") );
            write( l , "R3", left, 3);
            write( l , string‘(" | ") );
            write( l , "ZCNO", left, 4);
    end print_header;

    procedure print_tail( variable f : out text )is
        variable l:line;
        begin
            write( l , string‘("-----------------------------------"));
            writeline( f , l );
    end print_tail;

    procedure write_PC_CMD (variable l: inout line;
        constant PC: in data_type;
        constant OP: in opcode_type;
        constant X,Y,Z: in reg_addr_type) is
        begin
            write( l , hex_image (PC), left, 3);
            write( l , string‘(" | ") );
            write( l , cmd_image (OP), left, 4);
            write( l , string‘(" | ") );
            write( l , X, left, 1);
            write( l , Y, left, 1);
            write( l , Z, left, 1);
            write( l , string‘(" | ") );
    end write_PC_CMD;

    procedure write_param (variable l: inout line;
        constant P : in data_type) is
        begin
            write( l, P, left, 3);
            write( l , string‘(" | ") );
    end write_param;

    procedure write_no_param (variable l: inout line) is
        begin
            write( l , "---", left, 3);
            write( l , string‘(" | ") );
    end write_no_param;

    procedure write_regs (variable l: inout line;
        constant Reg: in reg_type;
        constant Z,CO,N,O : in Boolean) is
        begin
            write( l , Reg(0), left, 3);
            write( l , string‘(" | ") );
            write( l , Reg(1), left, 3);
            write( l , string‘(" | ") );
            write( l , Reg(2), left, 3);
            write( l , string‘(" | ") );
            write( l , Reg(3), left, 3);
            write( l , string‘(" | ") );
            if Z then
                write( l , "T", left, 1);
            else
                write( l , "F", left, 1);
            end if;
            if CO then
                write( l , "T", left, 1);
            else
                write( l , "F", left, 1);
            end if;
            if N then
                write( l , "T", left, 1);
            else
                write( l , "F", left, 1);
            end if;
            if O then
                write( l , "T", left, 1);
            else
                write( l , "F", left, 1);
            end if;
    end write_regs;

    function hex_image( d : data_type )
        return string is
        constant hex_table : string(1 to 16):=
        “0123456789ABCDEF“;
        variable result : string( 1 to 3 );
    begin
        result(3):=hex_table(d mod 16 + 1);
        result(2):=hex_table((d / 16) mod 16 + 1);
        result(1):=hex_table(d / 256 + 1);
        return result;
    end hex_image;

    function cmd_image( cmd : opcode_type )
        return string is
    begin
        case cmd is
            when code_nop => return mnemonic_nop;
            when code_stop => return mnemonic_stop;
            -- Register instruction --
            when code_ldc => return mnemonic_ldc;
            when code_ldd => return mnemonic_ldd;
            when code_ldr => return mnemonic_ldr;
            when code_std => return mnemonic_std;
            when code_str => return mnemonic_str;
            -- Jump instruction --
            when code_jmp => return mnemonic_jmp;
            when code_jz => return mnemonic_jz;
            when code_jc => return mnemonic_jc;
            when code_jn => return mnemonic_jn;
            when code_jo => return mnemonic_jo;
            when code_jnz => return mnemonic_jnz;
            when code_jnn => return mnemonic_jnn;
            when code_jno => return mnemonic_jno;
            -- Logic and arithmetic instruction -- 
            when code_not => return mnemonic_not;
            when code_and => return mnemonic_and;
            when code_add => return mnemonic_add;
            when code_addc => return mnemonic_addc;
            when others =>
                assert FALSE
                report “Illegal command in cmd_image“
                severity warning;
                return ““;
        end case;
    end cmd_image;
end cpu_trace_pack;