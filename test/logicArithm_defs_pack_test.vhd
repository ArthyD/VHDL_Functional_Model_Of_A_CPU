library work;
use work.logicArithm_defs_pack.all;


entity Test is
end Test;

architecture logicArithm_defs_pack_test of Test is
begin
    process
        constant test_vector: bit_vector := '11110000'
        
        test_vector <= "NOT"(test_vector)
        assert test_vector == '00001111'

        test_vector <= test_vector "AND" '11000011'
        assert test_vector == '00000011'
        
        test_vector <= INC(test_vector)
        assert test_vector == '00000100'
        
    end process
end architecture