library work;
use work.cpu_trace_pack.all;


entity Test is
end Test;

architecture cpu_trace_pack_test of Test is
begin
    process
    -- step 1, print the following stuff to file with cpu_trace_functions:
    -- PC  | Cmd  | XYZ | P   | R0  | R1  | R2  | R3  | ZCNO
    -- -----------------------------------------------------
    -- 000 | NOP  | 000 | --- | 000 | 000 | 000 | 000 | FFFF
    -- 001 | LDC  | 000 | 000 | 000 | 000 | 000 | 000 | TFFF
    -- 003 | LDC  | 200 | 800 | 000 | 000 | 800 | 000 | FFTF
    -- 005 | STOP | 000 | --- | 000 | 000 | 800 | 000 | FFTF
    -- -----------------------------------------------------
    
    -- print_header(), blabla..




    -- step 2, read file line by line and assert that content looks like:
    -- PC  | Cmd  | XYZ | P   | R0  | R1  | R2  | R3  | ZCNO
    -- -----------------------------------------------------
    -- 000 | NOP  | 000 | --- | 000 | 000 | 000 | 000 | FFFF
    -- 001 | LDC  | 000 | 000 | 000 | 000 | 000 | 000 | TFFF
    -- 003 | LDC  | 200 | 800 | 000 | 000 | 800 | 000 | FFTF
    -- 005 | STOP | 000 | --- | 000 | 000 | 800 | 000 | FFTF
    -- -----------------------------------------------------
    readline(f, l);
    assert l == "PC  | Cmd  | XYZ | P   | R0  | R1  | R2  | R3  | ZCNO"
    readline(f, l);
    assert l == "-----------------------------------------------------"
    readline(f, l)
    assert l == "000 | NOP  | 000 | --- | 000 | 000 | 000 | 000 | FFFF"
    readline(f, l)
    assert l == "001 | LDC  | 000 | 000 | 000 | 000 | 000 | 000 | TFFF"
    readline(f, l)
    assert l == "003 | LDC  | 200 | 800 | 000 | 000 | 800 | 000 | FFTF"
    readline(f, l)
    assert l == "005 | STOP | 000 | --- | 000 | 000 | 800 | 000 | FFTF"
    readline(f, l)
    assert l == "005 | STOP | 000 | --- | 000 | 000 | 800 | 000 | FFTF"
    readline(f, l);
    assert l == "-----------------------------------------------------"
    
    end process
end architecture