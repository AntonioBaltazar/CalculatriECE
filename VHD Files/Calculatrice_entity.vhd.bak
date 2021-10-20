library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Calculatrice_entity is
				port (	affich :  out STD_LOGIC_vector(6 downto 0);
							nombre : in STD_LOGIC_VECTOR(3 downto 0)
						);
end Calculatrice_entity;

architecture Calculatrice_archi of Calculatrice_entity is 

begin
	
			--- DETECTION DU NOMBRE A AFFICHER ---
			
	affich <= "1111110" WHEN nombre = "0000" ELSE		--- Chiffre 0 ---
				 "0110000" WHEN nombre = "0001" ELSE 		--- Chiffre 1 ---
				 "1101101" WHEN nombre = "0010" ELSE		--- Chiffre 2 ---
				 "1111110" WHEN nombre = "0011" ELSE		--- Chiffre 3 ---
				 "1111110" WHEN nombre = "0100" ELSE		--- Chiffre 4 ---
				 "1111110" WHEN nombre = "0101" ELSE 		--- Chiffre 5 ---
				 "1111110" WHEN nombre = "0110" ELSE		--- Chiffre 6 ---
				 "1111110" WHEN nombre = "0111" ELSE 		--- Chiffre 7 ---
				 "1111110" WHEN nombre = "1000" ELSE 		--- Chiffre 8 ---
				 "1111110" WHEN nombre = "1001" ELSE		--- Chiffre 9 ---
				 "1111110" WHEN nombre = "1010" ELSE		--- Chiffre 10 ---
				 "1111110" WHEN nombre = "1011" ELSE		--- Chiffre 11 ---
				 "1111110" WHEN nombre = "1100" ELSE		--- Chiffre 12 ---
				 "1111110" WHEN nombre = "1101" ELSE		--- Chiffre 13 ---
				 "1111110" WHEN nombre = "1110" ELSE		--- Chiffre 14 ---
				 "1111110" WHEN nombre = "1111";				--- Chiffre 15 ---
				 
				 
	--- Voir pour ajouter un cinquieme bit a nombre pour le signe ---
end Calculatrice_archi;
	