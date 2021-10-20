library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
 
entity buzzer_entity is
port ( 
		 reset : in std_logic;
		 Res2 	:  in std_logic_vector(3 downto 0);		--- Résultat de l'opération entre A & B --- 
		 clk 		: in std_logic;		--- Horloge ---
       bip     : out std_logic 		--- Permet d'envoyer un PWM au biper via la pin W10 --
	  );
end buzzer_entity;

architecture buzzer_archi of buzzer_entity is

	signal resultat : integer := 0; --- Res mais en décimale ---

begin

	process(clk,Res2)
	
	variable cmpt : integer := 0; --- Compteur permettant de controler le nombre de bip 
	variable  f   : integer := 0; --- Compteur permettant de compter le nombre de fronts montants de l'horloge ---
	
	
	begin
		--- Conversion de Res en binaire en décimale dans resultat ---
		case Res2 is 
			 
				when "0000" => resultat <= 0;
				when "0001" => resultat <= 1;
				when "0010" => resultat <= 2;
				when "0011" => resultat <= 3;
				when "0100" => resultat <= 4;
				when "0101" => resultat <= 5;
				when "0110" => resultat <= 6;
				when "0111" => resultat <= 7;
				when "1000" => resultat <= 8;
				when "1001" => resultat <= 9;
				when "1010" => resultat <= 10;
				when "1011" => resultat <= 11;
				when "1100" => resultat <= 12;
				when "1101" => resultat <= 13;
				when "1110" => resultat <= 14;
				when "1111" => resultat <= 15;
				
				when others => resultat <= 6;
		
		end case;

		if (rising_edge(clk) and cmpt< resultat) then
			
			f := f + 1;
			--- 25.000.000 de fronts montants = 1/2 seconde ---
			
			--- Pendant 1/2 seconde on émet un son à travers le biper --- 
			if (f < 25000000) then 	
				bip <= '1'; 	-- Emission sonore -- 

			--- Pendant 1/2 seconde on arrete d'émettre du son ---
			elsif (f > 25000000 and f < 50000000) then
				bip <= '0'; 	--- Arrêt de l'émission sonore ---
			
			--- On recommence le processus jusqu'à ce qu'on ait biper 'res' fois ---
			elsif (f > 50000000)then
				f:= 0;  --- Remise à 0 de notre 
				cmpt:=cmpt+1; --- Reinitialiser 
			
			--- Incrémentation de notre compteur de bip ---
			
			end if;
			
			if(reset = '1') then	--- Remise à zéro du compteur de cycle ---
				cmpt := 0;
			end if;
			
		end if;
		
	end process;
	
end buzzer_archi; 