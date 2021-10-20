library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity calcul_entity is 
port ( 
		 clk : in std_logic;
		 reset : in std_logic;
		 
		 led_signe_resultat : out std_logic;
		 
		 A_op : in std_logic_vector( 3 downto 0 );				--- Opérande A pour les calculs via le FPGA ---
		 B_op : in std_logic_vector( 3 downto 0 );				--- Opérande B pour les caluls via le FPGA ---
		 Res_op : out std_logic_vector(7 downto 0);							--- Résultat des opérations entre A et B ---
		 
		 cla_A : out std_logic_vector( 3 downto 0 );			--- Opérande A pour les calculs via le CLA ---
		 cla_B : out std_logic_vector( 3 downto 0 );			--- Opérande B pour les caluls via le CLA ---
		 cla_Res : in std_logic_vector( 3 downto 0);			--- Résultat des opérations entre A et B via le CLA ---
		 
		 b_signeA : in std_logic;
		 b_signeB : in std_logic;
		 b_cla : in std_logic;										--- Bouton permettant de choisir entre le fpga et l'addditonneur pour les opérations ---
		 b_operation : in std_logic								--- Bouton permettant de choisir le type d'opération ---
	  );
end calcul_entity;
								
architecture calcul_archi of calcul_entity is 

begin 

	process(clk,reset,A_op,B_op,b_signeA,b_signeB, b_cla, b_operation)
	begin

	if(clk'event and clk ='1') then 

		--- Choix de l'opérateur en fonction de b_cla ---
			
		if(b_cla = '0') then 		--- Calcul sur fpga ---
			
			--- Multiplication ---
			if(b_operation = '1') then	
				Res_op <= A_op * B_op;	
				
				--- Prédiction du signe du résultat ---
				if( (b_signeA = '1' and b_signeB = '1') or (b_signeA = '0' and b_signeB = '0') )then
					led_signe_resultat <= '0';
				end if;
				if(  (b_signeA = '1' and b_signeB = '0') or (b_signeA = '0' and b_signeB = '1') ) then
					led_signe_resultat <= '1';
				end if;
			end if;
			
			--- Addition ---	
			if(b_operation = '0') then		
				
						--- Les nombres sont de mêmes signes ---
				if((b_signeA = '1' AND b_signeB = '1') or (b_signeA = '0' and b_signeB = '0')) then
					Res_op(3 downto 0) <= A_op + B_op;
					
					if(b_signeA = '0' AND b_signeB = '0')then		--- Prévision du signe du résultat ---
						led_signe_resultat <= '0'; 							--- Led du signe du resultat éteinte car resultat positif ---	
					end if;	
					if (b_signeA = '1' and b_signeB ='1') then
						led_signe_resultat <= '1';							--- Led du signe du resultat allumé car resultat négatif ---
						
					end if; --- end if signe resultat addition fgpa--
				end if;	
					--- A négatif et B positif ---
				if(b_signeA='1' AND b_signeB = '0') then		--- Signe de A et B ---
					Res_op(3 downto 0) <= A_op - B_op;
						
					if(A_op > B_op) then						--- Resultat negatif ---
						led_signe_resultat <= '1';
					end if;	
					if(A_op < B_op) then
						led_signe_resultat <= '0';			--- Resultat positif ---
						
					end if; --- End if signe du resultat
				end if;	
					
					--- A positif et B négatif ---
				if(b_signeA='0' AND b_signeB = '1')  then
					Res_op(3 downto 0) <= A_op - B_op;
						
					if(A_op < B_op) then 						--- Resultat negatif ---
						led_signe_resultat <= '1';
					end if;
					if(A_op > B_op) then
						led_signe_resultat <= '0';				---Resultat positif ---
					end if;
						
				end if; 
			end if;	
				
			 	
		end if; -- End of Calcul sur FPGA
		
		--- Calcul via l'additionneur Externe ---
		if(b_cla = '1') then
			
			--- Addition non signé ---
			if(b_operation = '0') then
				
				cla_A <= A_op;
				cla_B <= B_op;
				Res_op(3 downto 0) <= cla_Res;
				
			end if;
			
		end if;
		
	end if;

end process;

end calcul_archi;