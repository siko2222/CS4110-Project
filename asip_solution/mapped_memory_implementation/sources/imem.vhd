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

-- R0: Application specific mapped memory region
-- R1: Distance
-- R2: Threshold
-- R3: State

    constant instr_opcodes: rom_type:=(
        -- Init
        "111110000000000000000000", -- addr 00: MVi R0, 248                 Move start of the application specific mapped memory address into R0
        "000000010000000010000010", -- addr 01: LD R1, R0(1)                Load distance to object into R1
        "111111110000010000001100", -- addr 02: JRZ R1, -1         `(dec)   Jump back if the distance measurement is 0
        
        -- Setup
        "011001000000000100000000",  -- addr 03: MVi  R2, 100   	(dec)	Setting distance threshold into R2
        "000000000000000110000000",  -- addr 04: MVi  R3, 0			(dec)	Indicating previous driving state, forward
            
        -- Forward/bakward logic
        "000000010000000010000010",  -- addr 05: LD R1, R0(1) 			    Move distance measurement into R2
        "000001000000110000001101",  -- addr 06: JRNZ R3, 4			(dec)	Jump to backward if state is not zero
        "000000110100010000100000",  -- addr 07: BGTQ R2, R1, 3 	(dec)	Drive backwards if threshold is greater or equals to current distance (R1 <= R2)
        
        -- Forward	
        "011001000000001000000000",  -- addr 08: MVi  R4, 100       (dec)   Move signed value into R3 (aka. motors to move forward full speed)
        "000001010000000000001110",  -- addr 09: J 5            	(dec)   Jump to Drive all
        
        -- Backward
        "000000010000000110000000",  -- addr 10: MVi  R3, 1			(dec)	Backing up status
        "100101100000000100000000",  -- addr 11: MVi  R2, 150   	(dec)	Update the distance threshold, such that the car backs up 5cm
        -- Double check logic here
        "000001110010100000100000",  -- addr 12: BGTQ R1, R2, 7 	(dec)	Turn to the left if distance is greater or equals the new threshold (R2 <= R1)
        "110011100000001000000000",  -- addr 13: MVi  R4, -50   	(dec)   Move -50 to R3 (aka. motors to move backwards at half speed)
        
        -- Drive all wheels
        "000001001000000000000011",  -- addr 14: ST  R4, R0(4)			    Drive front left motor according to R4
        "000001011000000000000011",  -- addr 15: ST  R4, R0(5)				Drive front right motor according to R4
        "000001101000000000000011",  -- addr 16: ST  R4, R0(6)				Drive rear right motor according to R4
        "000001111000000000000011",  -- addr 17: ST  R4, R0(7)				Drive rear left motor according to R4
        "111100110000000000001110",  -- addr 18: J -13 				(dec) 	Jump back to MVD
            
        -- Turn left	
        "110011100000001010000000",  -- addr 19: MVi  R5, -50		(dec)
        "001100100000001000000000",  -- addr 20: MVi  R4, 50		(dec)
        "000001001010000000000011",  -- addr 21: ST  R5, R0(4)				Drive front left motor according to R5
        "000001011000000000000011",  -- addr 21: ST  R4, R0(5)				Drive front right motor according to R4
        "000001101000000000000011",  -- addr 22: ST  R4, R0(6)				Drive rear right motor according to R4
        "000001111010000000000011",  -- addr 24: ST  R5, R0(7)				Drive rear left motor according to R5
            
        -- Wait for left turn to finish
        "000000111000000000000011",  -- addr 25: ST R4, R0(3)	
        "111111100000001010000000",  -- addr 26: MVi  R5, 254		(dec)   Move left turn counter threshold into R5
        "000000100000001100000010",  -- addr 27: LD R6, R0(2)	    (dec)	Load counter value into R6
        "111111111011100000100000",  -- addr 28: BGTQ R5, R6, -1	(dec)   Wait until counter is greater than or equal to threshold in R5
        "111001100000000000001110",  -- addr 29: J -26				(dec)	Jump to Setup
    
        "111111111111111111111111", -- addr 30: (void)
        "111111111111111111111111"  -- addr 31: (void)
    );
begin
   im_dout <= instr_opcodes(to_integer(unsigned(im_addr)));
end arch;