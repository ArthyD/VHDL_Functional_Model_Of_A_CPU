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
library work;
use work.bit_vector_natural_pack.all;
use work.cpu_defs_pack.all;

package logicArithm_defs_pack is

    function INC( A : in addr_type ) return addr_type;

    procedure EXEC_ADDC (
        constant A,B : in data_type;
        constant CI : in bit;
        variable R : out data_type;
        variable Z,CO,N,O : out bit);

    function "NOT" (constant A :data_type)
        return data_type;

    function "AND" (constant A, B :data_type)
        return data_type;
    


end logicArithm_defs_pack;



package body logicArithm_defs_pack is

    function INC( A : in addr_type ) return addr_type is
        variable C : bit := '1';
        variable R : addr_type;
        begin
            for i in A'reverse_range loop
                R(i) := A(i) xor C;
                C := A(i) and C;
            end loop;
            return R;
     end INC;

     procedure EXEC_ADDC (
        constant A,B : in data_type;
        constant CI : in bit;
        variable R : out data_type;
        variable Z,CO,N,O : out bit ) is
        variable C_TMP : bit := CI;
        variable N_TMP : bit;
        variable R_TMP : data_type;
        variable T : integer range 0 to 3;
        constant zero_v: data_type := (others => '0');
        begin
            for i in A'reverse_range loop
                T := bit'pos(A(i))+ bit'pos(B(i))+ bit'pos(C_TMP);
                R_TMP(i) := bit'val(T mod 2);
                C_TMP := bit'val(T / 2);
            end loop;
            CO := C_TMP;
            T := bit'pos(A(A'length-1))+ bit'pos(B(B'length-1))+
            bit'pos(C_TMP);
            N_TMP := bit'val(T mod 2);
            O := R_TMP( data_width-1 ) XOR N_TMP;
            N := N_TMP;
            R := R_TMP;
            Z := bit'val(boolean'pos(R_TMP = zero_v));
    end EXEC_ADDC;

    function "NOT" (constant A : data_type)
        return data_type is
    begin
        return NOT A ;
    end "NOT";

    function "AND" (constant A,B : data_type)
        return data_type is
    begin
        return  A  AND B;
    end "AND";


end logicArithm_defs_pack;


