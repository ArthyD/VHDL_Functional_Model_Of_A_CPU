----------------------------------------------------------------------------------
-- TUM VHDL Assignment
-- Arthur Docquois, Maelys Chevrier, Timothée Carel, Roman Canals
--
-- Create Date: 06/06/2022
-- Project Name: CPU Functional model
-- I hate my life
-- nobody reads this anyway

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
library work;

use work.cpu_defs_pack.all;
use work.bit_vector_natural_pack.all;
use std.textio.all;

package mem_defs_pack is
    function init_memory(filename:string) return mem_type;
    function dump_memory(memory:mem_type;filename:string) return mem_type;
end mem_defs_pack;

package body mem_defs_pack is
    function init_memory (filename: string) return mem_type is
        file f : text open READ_MODE is filename;
        variable l : line;
        variable mem : mem_type;
        variable success : boolean;
        variable v : data_type;
        variable i : addr_type := natural2bit_vector(0,addr_width);
        begin
            outest: loop -- read line by line
                exit when endfile (f);
                readline (f, l);
                success := TRUE;
                -- read values in each line
                while success loop
                    read (l, v, success);
                    if success then
                        mem (bit_vector2natural(i)):=v;
                        exit outest when
                            bit_vector2natural(i) = 2**addr_width -1;
                        i := natural2bit_vector(bit_vector2natural(i)+1,addr_width);
                    end if;
                end loop;
            end loop;
            return mem;
        end init_memory;

    function dump_memory(memory: mem_type;filename:string) return mem_type is

            -- Open file, do definitions
            file f : text open WRITE_MODE is filename;
            variable l : line;

            begin
            --read mem and write to file Dump.mem

            for tmp_addr in memory'low to memory'high loop
		        write(l,memory(tmp_addr));
		        writeline( f , l );
	        end loop;

            --

    end dump_memory;
end mem_defs_pack;
