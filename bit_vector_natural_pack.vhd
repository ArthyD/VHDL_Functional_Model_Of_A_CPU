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

package bit_vector_natural_pack is
    function bit_vector2natural(constant A: bit_vector)
        return data_type;
    
    function natural2bit_vector(constant A :data_type,constant data_width : natural)
        return bit_vector;
    
end bit_vector_natural_pack;
    
package body bit_vector_natural_pack is
    function bit_vector2natural(constant A: bit_vector)
        return data_type is
        begin
            return to_integer(signed(A));
    end bit_vector2natural;

    function natural2bit_vector(constant A :data_type,constant data_width : natural)
        return bit_vector is
        begin
            return std_logic_vector(to_unsigned(A, data_width));
    end natural2bit_vector;
end bit_vector_natural_pack;