-- josemmf@usn.no | 2023.10
-- Single-port ROM w/ 8-bit addr bus, 24-bit data bus
-- (adapted from) Listing 11.5

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity imem is
   generic(
      IMADDR_WIDTH: integer:=5;
      IMDATA_WIDTH: integer:=24
   );
   port(
      im_addr: in std_logic_vector(IMADDR_WIDTH-1 downto 0);
      im_dout: out std_logic_vector(IMDATA_WIDTH-1 downto 0)
    );
end imem;

architecture arch of imem is
   type rom_type is array (0 to 2**IMADDR_WIDTH-1)
        of std_logic_vector(IMDATA_WIDTH-1 downto 0);

    constant instr_opcodes: rom_type:=(
        -- Init
        "000000000000000000001111", -- addr 00: MVD R0                      Move last distance measurement into R0
        "111111110000000000001100", -- addr 01: JRZ R0, -1         `(dec)   Jump back if the distance measurement is 0
        
        -- Setup
        "011001000000000010000000",  -- addr 02: MVi  R1, 100   	(dec)	Setting distance threshold into R1
        "000000000000000000000000",  -- addr 03: MVi  R0, 0			(dec)	Indicating previous driving state, forward
            
        -- Forward/bakward logic
        "000000000000000100001111",  -- addr 04: MVD  R2 					Move distance measurement into R2
        "000001000000000000001101",  -- addr 05: JRNZ R0, 4			(dec)	Jump to backward if state is not zero
        "000000110010100000100000",  -- addr 06: BGEU R1, R2, 3 	(dec)	Drive backwards if threshold is greater or equals to current distance (R1 <= R2)
        
        -- Forward	
        "011001000000000110000000",  -- addr 07: MVi  R3, 100       (dec)   Move signed value into R3 (aka. motors to move forward full speed)
        "000001010000000000001110",  -- addr 08: J 5            	(dec)   Jump to Drive all
        
        -- Backward
        "000000010000000000000000",  -- addr 09: MVi  R0, 1			(dec)	Backing up status
        "100101100000000010000000",  -- addr 10: MVi  R1, 150   	(dec)	Update the distance, such that the car backs up 5cm
        "000001110100010000100000",  -- addr 11: BGEU R2, R1, 7 	(dec)	Turn to the left if distance is greater or equals the new threshold (R2 <= R1)
        "110011100000000110000000",  -- addr 12: MVi  R3, -50   	(dec)   Move -50 to R3 (aka. motors to move backwards at half speed)
        
        -- Drive all wheels
        "000000000110000000010000",  -- addr 13: DFL  R3					Drive front left motor according to R3
        "000000000110000000010001",  -- addr 14: DFR  R3					Drive front right motor according to R3
        "000000000110000000010010",  -- addr 15: DRR  R3					Drive rear right motor according to R3
        "000000000110000000010011",  -- addr 16: DRL  R3					Drive rear left motor according to R3
        "111100110000000000001110",  -- addr 17: J -13 				(dec) 	Jump back to MVD
            
        -- Turn left	
        "110011100000000110000000",  -- addr 18: MVi  R3, -50		(dec)
        "001100100000001000000000",  -- addr 19: MVi  R4, 50		(dec)
        "000000000110000000010000",  -- addr 20: DFL  R3					Drive front left motor according to R3
        "000000001000000000010001",  -- addr 21: DFR  R4					Drive front right motor according to R3
        "000000001000000000010010",  -- addr 22: DRR  R4					Drive rear right motor according to R3
        "000000000110000000010011",  -- addr 23: DRL  R3					Drive rear left motor according to R3
            
        -- Wait for left turn to finish
        "000000000000000000100011",  -- addr 24: CRST	
        "111111100000001010000000",  -- addr 25: MVi  R5, 254		(dec)   Move left turn counter threshold into R5
        "000000000000001100100010",  -- addr 26: MVC  R6			(dec)	Move counter value to R6
        "111111111011100000100000",  -- addr 27: BGEU R5, R6, -1	(dec)   Wait until counter is greater than or equal to threshold in R5
        "111001100000000000001110",  -- addr 28: J -26				(dec)	Jump to Setup
    
        "111111111111111111111111", -- addr 29: (void)
        "111111111111111111111111", -- addr 30: (void)
        "111111111111111111111111"  -- addr 31: (void)
    );
begin
   im_dout <= instr_opcodes(to_integer(unsigned(im_addr)));
end arch;