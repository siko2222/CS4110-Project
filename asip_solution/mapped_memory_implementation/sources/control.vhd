-- josemmf@usn.no | 2023.10

library ieee;
use ieee.std_logic_1164.all;
entity control is
   generic(
      OPCODE_WIDTH: integer:=7
   );
   port(
      clk, rst: in std_logic;
      alu_zero, alu_gt, alu_eq: in std_logic;
      opcode: in std_logic_vector(OPCODE_WIDTH-1 downto 0);
      pc_mux_ctr, dreg_write, dreg_mux_ctr, dmem_write: out std_logic;
      alu_mux_ctr: out std_logic;
      alu_ctr: out std_logic_vector(OPCODE_WIDTH-1 downto 0)
   );
end control;

architecture arch of control is
-- constant declaration for instruction opcodes
   constant LD_Ri_imm:     std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0000000";
   constant LD_Ri_Rj:      std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0000001";
   constant LD_Ri_X_Rj:    std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0000010";
   constant ST_Ri_X_Rj:    std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0000011";
   constant DEC_Ri:        std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0000100";
   constant INC_Ri:        std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0000101";
   constant ADD_Ri_Rj_Rk:  std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0000110";
   constant SUB_Ri_Rj_Rk:  std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0000111";
   constant ORR_Ri_Rj_Rk:  std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0001000";
   constant ORI_Ri_Rj_imm: std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0001001";
   constant ANR_Ri_Rj_Rk:  std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0001010";
   constant ANI_Ri_Rj_imm: std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0001011";
   constant JRZ_Ri_imm:    std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0001100";
   constant JRNZ_Ri_imm:   std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0001101";
   constant J_imm:         std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0001110";
   
   constant BGTQ_Ri_Rj_imm:std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0100000";   
   constant NOP:           std_logic_vector(OPCODE_WIDTH-1 downto 0) :="1111111";  
    
   type state_type is (s0);
   signal st_reg, st_next: state_type;   
begin
   -- state register
   process(clk,rst)
   begin
      if (rst='1') then
         st_reg <= s0;
--         ctr_rst <= '1';
      elsif rising_edge(clk) then
         st_reg <= st_next;
      end if;
   end process;
   
   -- next-state/output logic
   process(opcode, alu_zero, alu_gt, alu_eq)
   begin
      st_next <= st_reg;  -- default back to same state
      pc_mux_ctr <= '0';    
	  dreg_write <= '0'; 
      alu_mux_ctr <= '0'; 
	  dreg_mux_ctr <= '0';  
	  dmem_write <= '0';
	  alu_ctr <= opcode;
	   
      case st_reg is
         when s0 =>
            if opcode=LD_Ri_imm then -- LD Ri,<imm> (load Ri with an immediate value)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1'; 
                alu_mux_ctr <= '1';  
	            dreg_mux_ctr <= '1';
	         elsif opcode=LD_Ri_Rj then -- LD Ri,Rj (copy the value of Rj into Ri)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1';   
	            dreg_mux_ctr <= '1';  
	         elsif opcode=LD_Ri_X_Rj then -- LD Ri,X(Rj) (load Ri from data memory)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1'; 
                alu_mux_ctr <= '1';  
	         elsif opcode=ST_Ri_X_Rj then -- ST Ri,X(Rj) (store Ri into data memory)
                pc_mux_ctr <= '1';    
                alu_mux_ctr <= '1';  
	            dmem_write <= '1';
	         elsif opcode=DEC_Ri then -- DEC Ri (decrement Ri)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1';  
	            dreg_mux_ctr <= '1';  
	         elsif opcode=INC_Ri then -- INC Ri (increment Ri)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1';  
	            dreg_mux_ctr <= '1';
	         elsif opcode=ADD_Ri_Rj_Rk then -- ADD Ri,Rj,Rk (Ri = Rj + Rk))
                pc_mux_ctr <= '1';    
	            dreg_write <= '1';   
	            dreg_mux_ctr <= '1';  
	         elsif opcode=SUB_Ri_Rj_Rk then -- SUB Ri,Rj,Rk (Ri = Rj - Rk))
                pc_mux_ctr <= '1';    
	            dreg_write <= '1';   
	            dreg_mux_ctr <= '1';
	         elsif opcode=ORR_Ri_Rj_Rk then -- ORR Ri,Rj,Rk (Ri = Rj OR Rk)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1';   
 	            dreg_mux_ctr <= '1';  
	         elsif opcode=ORI_Ri_Rj_imm then -- ORI Ri,Rj,<imm> (Ri = Rj OR <imm>)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1'; 
                alu_mux_ctr <= '1';  
	            dreg_mux_ctr <= '1';  
	         elsif opcode=ANR_Ri_Rj_Rk then -- ANR Ri,Rj,Rk (Ri = Rj AND Rk)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1';   
	            dreg_mux_ctr <= '1';
	         elsif opcode=ANI_Ri_Rj_imm then -- ANI Ri,Rj,<imm> (Ri = Rj AND <imm>)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1'; 
                alu_mux_ctr <= '1';  
	            dreg_mux_ctr <= '1';
	         elsif opcode=JRZ_Ri_imm then -- JRZ Ri,<imm> (jump if Ri is zero)
                pc_mux_ctr <= not(alu_zero);    
	         elsif opcode=JRNZ_Ri_imm then -- JRNZ Ri,<imm> (jump if Ri is not zero)
                pc_mux_ctr <= alu_zero;    
             elsif opcode=J_imm then -- J <imm> (unconditional jump)
                -- no signals to activate in this case
             elsif opcode=BGTQ_Ri_Rj_imm then -- BGTQ Ri, Rj, <imm> (jump if greater than or equals)
                pc_mux_ctr <= not(alu_gt or alu_eq);
	         elsif opcode=NOP then    -- NOP (No operation)
	            pc_mux_ctr <= '1';
	         end if; 
      end case;
      
   end process;
   
end arch;
