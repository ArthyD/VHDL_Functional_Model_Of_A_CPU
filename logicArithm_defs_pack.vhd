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

use assignmentCPU.bit_vector_natural_pack.all;
use assignmentCPU.cpu_defs_pack.all;

package logicArithm_defs_pack is

    procedure INC (
        constant PC : in addr_type;
        variable R : out addr_type;
    );
    
    procedure EXEC_ADDC (
        constant A,B : in data_type;
        constant CI : in Boolean;
        variable R : out data_type;
        variable Z,CO,N,O : out Boolean );

    function “NOT“ (constant A :data_type)
        return data_type;

    function “AND“ (constant A, B :data_type)
        return data_type;
    


end logicArithm_defs_pack;



package body logicArithm_defs_pack is

    procedure INC (
        constant PC : in addr_type;
        variable R : out addr_type;);
        begin
            R := (PC+1) mod 2**addr_width;
    end INC;

    procedure EXEC_ADDC (
        constant A,B : in data_type;
        constant CI : in Boolean;
        variable R : out data_type;
        variable Z,CO,N,O : out Boolean ) is
        variable T: integer := A+B+Boolean‘Pos( CI );
        variable A_s, B_s, T_s : integer; -- signed interpretation
        begin
        if A >= 2**(data_width-1) then
        A_s := A – 2**(data_width);
        else
        A_s := A;
        end if;
        if B >= 2**(data_width-1) then
        B_s := B – 2**(data_width);
        else
        B_s := B;
        end if;
        T_s := A_s+B_s+Boolean‘Pos( CI );
        if T >= 2**data_width then
            R := T - 2**data_width;
            CO := TRUE;
        else
            R := T;
            CO := FALSE;
        end if;
        if T mod 2**data_width = 0 then
            Z := TRUE;
        else
            Z := FALSE;
        end if;
        if T_s < 0 then
            N := TRUE;
        else
            N := FALSE;
        end if;
        if (T_s < -2**(data_width-1)) or (T_s >= 2**(data_width-1)) then
            O := TRUE;
        else
            O := FALSE;
        end if;
    end EXEC_ADDC;

    function “NOT“ (constant A : data_type)
        return data_type is
    begin
        return assignmentCPU.bit_vector_natural_pack.bit_vector2natural(NOT assignmentCPU.bit_vector_natural_pack.natural2bit_vector( A , data_width ) );
    end “NOT“;

    function “AND“ (constant A,B : data_type)
        return data_type is
    begin
        return bit_vector2natural(natural2bit_vector( A , data_width ) AND natural2bit_vector( B , data_width ) );
    end “AND“;


end logicArithm_defs_pack;


