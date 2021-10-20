library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity affichage_entity is					
	port(
			Nombre    : in STD_LOGIC_VECTOR ( 7 downto 0) ;				--- Nombre a afficher ---
			Affichage : out STD_LOGIC_VECTOR (15 downto 0)			--- Permet d'afficher Nombre ---
		 );
end affichage_entity;

architecture affichage_archi of affichage_entity is 

begin

		--- A chaque changement de valeur de Nombre on acutalise l'affichage sur les digit 7 segments ---
	process(Nombre)
	begin
		
		case Nombre is 
		
			when "00000000" => Affichage <= "1111111100000011";		--- Chiffre 0 --
			when "00000001" => Affichage <= "1111111110011111";		--- Chiffre 1 --
			when "00000010" => Affichage <= "1111111100100101";		--- Chiffre 2 --
			when "00000011" => Affichage <= "1111111100001101";		--- Chiffre 3 --
			when "00000100" => Affichage <= "1111111110011001";		--- Chiffre 4 --
			when "00000101" => Affichage <= "1111111101001001";		--- Chiffre 5 --
			when "00000110" => Affichage <= "1111111101000001";		--- Chiffre 6 --
			when "00000111" => Affichage <= "1111111100011111";		--- Chiffre 7 --
			when "00001000" => Affichage <= "1111111100000001";		--- Chiffre 8 --
			when "00001001" => Affichage <= "1111111100001001";		--- Chiffre 9 --
			when "00001010" => Affichage <= "1001111100000011";		--- Chiffre 10 --
			when "00001011" => Affichage <= "1001111110011111";		--- Chiffre 11 --
			when "00001100" => Affichage <= "1001111100100101";		--- Chiffre 12 --
			when "00001101" => Affichage <= "1001111100001101";		--- Chiffre 13 --
			when "00001110" => Affichage <= "1001111110011001";		--- Chiffre 14 --
			when "00001111" => Affichage <= "1001111101001001";		--- Chiffre 15 --
			
			when others => Affichage <= "0110000111110101"; -- Erreur --;
		end case;

	end process;	
					 				 

end affichage_archi;