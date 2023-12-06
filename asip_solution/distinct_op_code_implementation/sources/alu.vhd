-- josemmf@usn.no | 2023.10
-- Listing 4.5 modified

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
   generic(
      OPCODE_WIDTH: integer:=7;
      ALUDATA_WIDTH: integer:=8
   );
   port(alu_din_hi, alu_din_lo: in std_logic_vector(ALUDATA_WIDTH-1 downto 0);
        alu_ctr_in: in std_logic_vector(OPCODE_WIDTH-1 downto 0);
        alu_dout: out std_logic_vector(ALUDATA_WIDTH-1 downto 0);
        alu_zero, alu_gt, alu_eq: out std_logic
   );
end alu;

architecture arch of alu is
signal valin_hi, valin_lo, valout: unsigned (ALUDATA_WIDTH-1 downto 0);

begin
valin_hi <= unsigned(alu_din_hi);
valin_lo <= unsigned(alu_din_lo);

-- Arithmetic operations
valout <= valin_lo when alu_ctr_in="0000000" else -- LD Ri,<imm>
          valin_lo when alu_ctr_in="0001111" else -- MVD Ri
          valin_lo when alu_ctr_in="0100010" else -- MVC Ri
          valin_hi when alu_ctr_in="0000001" else -- LD Ri,Rj

          (valin_hi + valin_lo) when (alu_ctr_in="0000010" and valin_lo(7)='0') else
          (valin_hi - not(valin_lo-1)) when (alu_ctr_in="0000010" and valin_lo(7)='1') else -- LD Ri,X(Rj)
          
          (valin_hi + valin_lo) when alu_ctr_in="0000011" else -- ST Ri,X(Rj)                    
          (valin_hi - 1) when alu_ctr_in="0000100" else -- DEC Ri
          (valin_hi + 1) when alu_ctr_in="0000101" else -- INC Ri
          (valin_hi + valin_lo) when alu_ctr_in="0000110" else -- ADD Ri,Rj,Rk (unsigned addition)
          (valin_hi - valin_lo) when alu_ctr_in="0000111" else -- SUB Ri,Rj,Rk (unsigned subtraction)
          (valin_hi OR valin_lo) when alu_ctr_in="0001000" else -- ORR Ri,Rj,Rk
          (valin_hi OR valin_lo) when alu_ctr_in="0001001" else -- ORI Ri,<imm>
          (valin_hi AND valin_lo) when alu_ctr_in="0001010" else -- ANR Ri,Rj,Rk
          (valin_hi AND valin_lo); -- when alu_ctr_in="0001011" (ANI Ri,<imm>) or any other

alu_zero <= '1' when valin_hi="0000000" else '0'; -- LD Ri,<imm>
alu_gt <= '1' when valin_hi < valin_lo else '0';
alu_eq <= '1' when valin_hi = valin_lo else '0';

alu_dout <= std_logic_vector(valout);

end arch;