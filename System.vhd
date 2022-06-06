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

entity System is
end System;

architecture functional of System is
begin
    process
    use assignmentCPU.cpu_defs_pack.all;
    use assignmentCPU.mem_defs_pack.all;
    variable Memory: mem_type := init_memory;
    variable Reg : reg_type;
    variable INSTR : data_type;
    variable OP : opcode_type;
    variable X, Y, Z : reg_addr_type;
    variable PC : addr_type :=0 ;
    begin
        Instr := Memory(PC); OP := Instr / (2**reg_addr_width)**3;
        X := (Instr / (2**reg_addr_width)**2) mod 2**reg_addr_width;
        Y := (Instr / 2**reg_addr_width) mod 2**reg_addr_width;
        Z := Instr mod 2**reg_addr_width; PC := PC+1;

        case OP is
            when code_nop => NULL; -- No Operation
            when code_stop => WAIT; -- Stop Simulation
            when code_ldc => Data := Memory(PC); Reg(X) := Data;
                                Set_Flags_Load(Data,Zero,Negative,Overflow);
                                PC := PC+1;
            when code_ldd => Data := Memory(Memory(PC)); Reg(X) := Data;
                                Set_Flags_Load(Data,Zero,Negative,Overflow);
                                PC := PC+1;
            when code_ldr => Data :=Memory(Reg(Y)); Reg(X) := Data;
                                Set_Flags_Load(Data,Zero,Negative,Overflow);
            when code_std => Memory(Memory(PC)):=Reg(X);
                                PC := PC+1;
            when code_str => Memory(Reg(Y)):=Reg(X);
            when others => -- Illegal or not yet implemented Operations
                        assert FALSE
                        report “Illegal Operation“
                        severity error;
        end case;