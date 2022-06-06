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
    function init_memory return mem_type is
    begin
        return
            (0 => code_nop * (2**reg_addr_width)**3,
             1 => code_stop * (2**reg_addr_width)**3,
             others => 0);
    end init_memory;
end mem_defs_pack;