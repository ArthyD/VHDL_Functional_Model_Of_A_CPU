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

use assignementCPU.cpu_defs_pack.memtype;

package mem_defs_pack is 
    function init_memory return mem_type;
end mem_defs_pack;

package body mem_defs_pack is
    function init_memory (filename: string) return mem_type is
        file f : text is in filename;
        variable l : line;
        variable mem : mem_type;
        variable success : boolean;
        variable v : data_type;
        variable i : addr_type := 0;
        begin
            outest: loop -- read line by line
                exit when endfile (f);
                readline (f, l);
                success := TRUE;
                -- read values in each line
                while success loop
                    read (l, v, success);
                    if success then
                        mem (i):=v;
                        exit outest when
                            i = 2**addr_width -1;
                        i := i+1;
                    end if;
                end loop;
            end loop;
            return mem;
        end init_memory;
end mem_defs_pack;