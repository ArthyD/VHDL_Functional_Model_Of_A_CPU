library work;
use work.flag_handler_pack.all;


entity Test is
end Test;
    
architecture flag_handler_pack_test of Test is
    begin
        process

        variable Zero, Negative, Overflow: inout bit := '0', '0', '0';
        constant Data: in data_type := '111111111111';

        Set_Flags_Load(Data, (Zero, Negative, Overflow))

        assert Zero == '1' and Negative == '1' and Overflow == 0

        Zero, Negative, Overflow <= '0', '0', '0';
        Set_Flags_Logic(Data, (Zero, Negative, Overflow))

        assert Zero == '1' and Negative == '1' and Overflow == '0'


    --     procedure Set_Flags_Load(
    --     constant Data: in data_type;
    --     variable Zero,Negative,Overflow : inout bit) is
    --         variable C_TMP : bit := '0';
    --         variable N_TMP : bit;
    --         variable R_TMP : data_type;
    --         variable T : integer range 0 to 3;
    --         constant zero_v: data_type := (others => '0');
    --     begin
    --         for i in Data'reverse_range loop``
    --             T := bit'pos(Data(i))+ bit'pos(C_TMP);
    --             R_TMP(i) := bit'val(T mod 2);
    --             C_TMP := bit'val(T / 2);
    --         end loop;
            
    --         T := bit'pos(Data(Data'length-1))+bit'pos(C_TMP);
    --         N_TMP := bit'val(T mod 2);
    --         Overflow := R_TMP( data_width-1 ) XOR N_TMP;
    --         Negative := N_TMP;
            
    --         Zero := bit'val(boolean'pos(R_TMP = zero_v));
    -- end Set_Flags_Load;

    end process
end architecture

-- 100
-- T = 0
-- R_T = '0'
-- C_T = '0'

-- T = 0
-- R_T = '00'
-- C_T = '0'

-- T = 1
-- R_T = '100'
-- C_T = '0'

-- T = 0
-- N_T = 0

-- 000