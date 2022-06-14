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

use assignmentCPU.bit_vector_natural_pack.all;

entity System is
end System;

architecture functional of System is
begin
    process
    -- Package needed --
    use assignmentCPU.cpu_defs_pack.all;
    use assignmentCPU.mem_defs_pack.all;
    use assignmentCPU.logicArithm_defs_pack.all;
    use assignmentCPU.flag_handler_pack.all;
    use assignmentCPU.cpu_trace_pack.all;
    use std.textio.all;

    -- Declaration of variables --
    variable Memory: mem_type := init_memory("Memory.dat");
    variable Reg : reg_type;
    variable INSTR : data_type; -- instruction --
    variable OP : opcode_type; -- opcode --
    variable X, Y, Z : reg_addr_type; -- operand --
    variable PC : addr_type :=X"000" ; -- Program counter --
    variable Zero, Carry, Negative, Overflow : Boolean := FALSE; --Flags --

    -- Files --
    file TraceFile : Text is out "Trace.dat";
    file DumpFile : Text is out "Dump.dat";
    file MemoryFile : Text is in "Memory.dat";
    file IOInputFile : Text is in "IOInput.dat";
    file IOOutputFile: Text is out "IOOutput.dat";
    variable l : line;

    begin
        loop 
            -- fetch instruction from memory --
            Instr := get(Memory,PC); 
            -- decode instruction --
            OP := Instr(data_width-1 downto data_width-opcode_width);
            X := Instr(data_width-opcode_width-1 downto data_width-opcode_width-reg_addr_width);
            Y :=  Instr(data_width-opcode_width-reg_addr_width-1 downto data_width-opcode_width-2*reg_addr_width);
            Z :=  Instr(data_width-opcode_width-2*reg_addr_width-1 downto data_width-opcode_width-3*reg_addr_width);
            write_PC_CMD(l, PC, Op, X, Y, Z);
            PC := INC(PC);
            -- compute operation --
            case OP is
                when code_nop => NULL; -- No Operation
                    write_NoParam( l );
                when code_stop => dump_memory( Memory, DumpFile );
                    WAIT; -- Stop Simulation
                    write_NoParam( l );
                    write_regs (l, Reg, Zero, Carry, Negative, Overflow);
                    writeline( TraceFile, l);
                    print_tail( TraceFile );

                -- REGISTER INSTRUCTION --
                when code_ldc => write_Param(l,get(Memory,PC));
                                Data:=get(Memory,PC); Reg(X):=Data;
                                Set_Flags_Load(Data,Zero,Negative,Overflow);
                                PC:=INC(PC);
                when code_ldd => write_Param(l,get(Memory,PC));
                                Addr:=get(Memory,PC);
                                Data:=get(Memory,Addr); Reg(X):=Data;
                                Set_Flags_Load(Data,Zero,Negative,Overflow);
                                PC:=INC(PC);
                when code_ldr => write_NoParam( l );
                                Data:=get(Memory,Reg(Y)); Reg(X):=Data;
                                Set_Flags_Load(Data,Zero,Negative,Overflow);
                when code_std => write_Param(l,get(Memory,PC));
                                Addr:=get(Memory,PC);
                                set(Memory,Addr,Reg(X));
                                PC:=INC(PC);
                when code_str => write_NoParam( l );
                                set(Memory,Reg(Y),Reg(X))
                -- END OF REGISTER INSTRUCTION -- 

                -- ARITHMETIC AND LOGICAL INSTRUCTION --
                when code_not => write_NoParam( l );
                                Data := "NOT" (Reg(Y));
                                Reg(X) := Data;
                                Set_Flags_Logic(Data,Zero,Negative,Overflow);
                when code_and => write_NoParam( l );
                                Data := Reg(Y) "AND" Reg(Z);
                                Reg(X) := Data;
                                Set_Flags_Logic(Data,Zero,Negative,Overflow);
                when code_add => write_NoParam( l );
                                EXEC_ADDC(Reg(Y), Reg(Z), FALSE, Reg(X), Zero, Carry, Negative, Overflow);
                when code_addc => write_NoParam( l );
                                EXEC_ADDC(Reg(Y), Reg(Z), Carry, Reg(X), Zero, Carry, Negative, Overflow);
                -- END OF ARITHMETIC AND LOGICAL INSTRUCTION --

                -- JUMP INSTRUCTION --
                when code_jmp => write_Param(l,Memory(PC)); PC := Memory(PC);
                when code_jz => write_Param(l,Memory(PC));
                                if Zero = '1' then PC := Memory(PC);
                                else PC := INC(PC); 
                                end if;
                when code_jnz => write_Param(l,Memory(PC));
                                if not Zero = '1' then PC := Memory(PC);
                                else PC := INC(PC);
                                end if;
                when code_jc => write_Param(l,Memory(PC));
                                if Carry = '1' then PC := Memory(PC);
                                else PC := INC(PC); 
                                end if;
                when code_jnc => write_Param(l,Memory(PC));
                                if not Carry = '1' then PC := Memory(PC);
                                else PC := INC(PC); 
                                end if;
                when code_jn => write_Param(l,Memory(PC));
                                if Negative ='1' then PC := Memory(PC);
                                else PC := INC(PC); 
                                end if;
                when code_jnn => write_Param(l,Memory(PC));
                                if not Negative = '1' then PC := Memory(PC);
                                else PC := INC(PC); 
                                end if;
                when code_jo => write_Param(l,Memory(PC));
                                if Overflow = '1' then PC := Memory(PC);
                                else PC := INC(PC); 
                                end if;
                when code_jno => write_Param(l,Memory(PC));
                                if not Overflow = '1' then PC := Memory(PC);
                                else PC := INC(PC); 
                                end if;
                -- END OF JUMP INSTRUCTION --

                when others => -- Illegal or not yet implemented Operations
                            assert FALSE
                            report “Illegal Operation“
                            severity error;
            
            end case;
            write_regs(l, Reg, Zero, Carry, Negative, Overflow);
            writeline( TraceFile, l );
        end loop;
    end process;