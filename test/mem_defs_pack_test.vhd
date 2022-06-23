library work;
use work.mem_defs_pack.all;


entity Test is
end Test;

architecture mem_defs_pack_test of Test is
begin
    process
        constant test_input_file <= "Memory.test.dat";
        constant test_output_file <= "Memory.test.dump.dat"
        variable Memory: mem_type;

        Memory <= init_memory(test_input_file)

        assert Memory(0) == '100010001000' -- validate that something is read in.
        assert Memory(1) == '110011001100' -- validate that multiple values can be in a row.
        assert Memory(2) == '111011101110' -- validate that multiple rows are read in correctly.
        assert Memory(3) == '100010001000'

        -- at the very end of the file there is a 111111111111 that should not be read in as the memory is full.
        assert Memory(Memory'length - 1) == '101010101010' -- validate that this 111111111111 is not read.

        -- at this point, we are convinced that init_memory works properly.. 
        -- so change some values and dump the memory into a new file. Then read again this file
        -- with init_memory and check if the new values appear. Then, dump_memory worked properly. 

        Memory(0) <= '111000111000'
        Memory(1) <= '111000111000'
        Memory(2) <= '111000111000'
        Memory(3) <= '111000111000'
        Memory(Memory'length - 1) <= '111000111000'

        dump_memory(Memory, test_output_file)

        Memory <= init_memory(test_output_file)
        
        assert Memory(0) == '111000111000'
        assert Memory(1) == '111000111000'
        assert Memory(2) == '111000111000'
        assert Memory(3) == '111000111000'
        assert Memory(Memory'length - 1) == '111000111000'

        -- TODO: maybe delete Memory.test.dump.dat somehow?
    end process
end architecture