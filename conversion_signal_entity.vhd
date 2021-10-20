library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity conversion_signal_entity is
	port(	
			resetA : in STD_LOGIC;		--- Remet à 0 A et B ---
			resetB : in STD_LOGIC;		--- Remet à 0 A et B ---
			saisit : in STD_LOGIC;		--- Permet de changer de nombre a saisir ---
			NA : out STD_LOGIC_VECTOR ( 7 downto 0) ;				--- Nombre a afficher ---
			NB : out STD_LOGIC_VECTOR ( 7 downto 0) ;				--- Nombre a afficher ---
			comm : in STD_LOGIC_VECTOR (7 downto 0)			--- Permet d'afficher Nombre ---
		 );
end conversion_signal_entity;

architecture conversion_signal_archi of conversion_signal_entity is 

begin
	
	process(comm, saisit,resetA,resetB)
	begin
	
	--- Bouton Reset ne fonctionnant pas car il est remet à 0 a chaque changement de saisit d'opérande ---
--	if(resetA = '1') then
--		NA <= X"0";
--	end if;
--	
--	if(resetB = '1') then
--		NA <= X"0";
--	end if;
	
	-- Lorsque que signe (interrupteur9) vaut 0 on saisit A ---
	if(saisit = '0')then
		
		case comm is 
		
			when "00101101" => NA <= "00000000";
			when "00011001" => NA <= "00000001";
			when "00110001" => NA <= "00000010";
			when "10111101" => NA <= "00000011";
			when "00010001" => NA <= "00000100";
			when "00111001" => NA <= "00000101";
			when "10110101" => NA <= "00000110";
			when "10000101" => NA <= "00000111";
			when "10100101" => NA <= "00001000";
			when "10010101" => NA <= "00001001";
			when "10001011" => NA <= "00001010";
			when "10001101" => NA <= "00001011";
			when "10001111" => NA <= "00001100";
			when "10001001" => NA <= "00001101";
			when "10000001" => NA <= "00001110";
			when "10000111" => NA <= "00001111";
			
			when others => NA <= "00000000";
		end case;
	
	-- Lorsque que signe (interrupteur9) vaut 1 on saisit B ---
	elsif(saisit = '1')then
		
		case comm is 
		
			when "00101101" => NB <= "00000000";
			when "00011001" => NB <= "00000001";
			when "00110001" => NB <= "00000010";
			when "10111101" => NB <= "00000011";
			when "00010001" => NB <= "00000100";
			when "00111001" => NB <= "00000101";
			when "10110101" => NB <= "00000110";
			when "10000101" => NB <= "00000111";
			when "10100101" => NB <= "00001000";
			when "10010101" => NB <= "00001001";
			when "10001011" => NB <= "00001010";
			when "10001101" => NB <= "00001011";
			when "10001111" => NB <= "00001100";
			when "10001001" => NB <= "00001101";
			when "10000001" => NB <= "00001110";
			when "10000111" => NB <= "00001111";
			
			when others => NB <= "00000000";
		end case;
	end if;
	
	end process;
	
end conversion_signal_archi;