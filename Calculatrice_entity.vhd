library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity Calculatrice_entity is
  port (  
			A_ext : out STD_LOGIC_VECTOR(3 downto 0);         --- Operande A pour additioneur ---
			B_ext : out STD_LOGIC_VECTOR(3 downto 0);         --- Operande B pour additioneur ---
			Res_ext : in std_logic_vector(4 downto 0);			--- Resultat pour additioneur ---
			 
			affich_A : out STD_LOGIC_VECTOR (15 downto 0);		--- Afficheur de l'opérande A ---
			affich_B : out STD_LOGIC_VECTOR (15 downto 0);		--- Afficheur de l'opérande B ---
			affich_Res : out STD_LOGIC_VECTOR (15 downto 0);	--- Afficheur du résulat ---
		 
		 
			int_saisit : in STD_LOGIC; --- Interrupteur 9, permet de changer d'opérande à saisir ('0':A / '1':B) ---
			int_signeA : in STD_LOGIC; --- Interrupteur 7 -> Signe de A  ('0' positif / '1' négatif)---
			int_signeB : in STD_LOGIC; --- Interrupteur 5 -> Idem que interrupteur 7 mais pour B ---
			int_CLA		: in STD_LOGIC; --- Interrupteur 2 -> Choix de l'opérateur
			int_operation	: in STD_LOGIC; --- Interrupteur 0 -> Choix de l'opération
		 
		 
			clock : in STD_LOGIC;		--- Horloge du circuit ---
			data_input : in STD_LOGIC;	--- Reception des données du capteur IR --- 
		 
			b_reset : in STD_LOGIC; --- Bouton (KEY 1) permettant de mettre A et B à 0 ---
			b_resetBuzzer : in STD_LOGIC; --- Bouton (KEY 1) permettant de mettre A et B à 0 ---
		 
			led : out STD_LOGIC_VECTOR(10 downto 0); --- Controle toute les leds : 
			-- 9: int_saisit / 7: int_signeA / 5: int signeB / 4: signe du résultat / 2: int_CLA / 0: int_operation ---
		 
			int_saisit_temp : in STD_LOGIC_VECTOR(3 downto 0);
			buzzer : out STD_LOGIC
		);
end Calculatrice_entity;

architecture Calculatrice_archi of Calculatrice_entity is

signal com :  STD_LOGIC_VECTOR(7 downto 0);    --- signal telecommande ---

--- Permettent que saisit puisse écrire dans A et B ---
signal Res : STD_LOGIC_VECTOR(7 downto 0);
signal B : STD_LOGIC_VECTOR(7 downto 0);
signal A : STD_LOGIC_VECTOR(7 downto 0);
signal led_signe_res : STD_LOGIC;  


component nec_receiver
	port(
			clk 					: in STD_LOGIC;
			data_in 				: in STD_LOGIC;
			reset 				: in STD_LOGIC;
			command2 			: out STD_LOGIC_VECTOR( 7 downto 0)
		);
end component ;


component affichage_entity					
	port(
			Nombre    : in STD_LOGIC_VECTOR ( 7 downto 0) ;				--- Nombre a afficher ---
			Affichage : out STD_LOGIC_VECTOR (15 downto 0)			--- Permet d'afficher Nombre ---
		 );
end component;
component buzzer_entity
	port( 
			reset : in std_logic;
			Res2 :  in std_logic_vector(3 downto 0);		--- Résultat de l'opération entre A & B --- 
			clk 		: in std_logic;		--- Horloge ---
			bip     : out std_logic 		--- Permet d'envoyer un PWM au biper via la pin W10 
		);
end component;

component conversion_signal_entity
	port(	
			saisit : in STD_LOGIC;		--- Permet de changer de nombre a saisir ---
			NA : out STD_LOGIC_VECTOR ( 7 downto 0) ;				--- Nombre a afficher ---
			NB : out STD_LOGIC_VECTOR ( 7 downto 0) ;				--- Nombre a afficher ---
			comm : in STD_LOGIC_VECTOR (7 downto 0)			--- Permet d'afficher Nombre ---
		 );
end component;


component calcul_entity 
						
port( 
		 clk : in std_logic;
		 
		 led_signe_resultat : out std_logic;							
		 A_op : in std_logic_vector( 3 downto 0 );				--- Opérande principale de A ---
		 B_op: in std_logic_vector( 3 downto 0 );					--- Opérande principale de A ---
		 Res_op : out std_logic_vector( 7 downto 0);				--- Résultat principale des opérations entre A et B ---
		 
		 cla_A : out std_logic_vector( 3 downto 0 );			--- Opérande A pour les calculs via le CLA ---
		 cla_B : out std_logic_vector( 3 downto 0 );			--- Opérande B pour les caluls via le CLA ---
		 
		 b_signeA : in std_logic;
		 b_signeB : in std_logic;
		 b_cla : in std_logic;										--- Bouton permettant de choisir entre le fpga et l'addditonneur pour les opérations ---
		 b_operation : in std_logic								--- Bouton permettant de choisir le type d'opération ---
	 );
	 

end component;

begin 


 led(9) <= int_saisit;
 led(8) <= int_signeA;
 led(7) <= int_signeB;
 led(6) <= int_CLA;
 led(5) <= int_operation;
 
 led(3) <= int_saisit_temp(3);
 led(2) <= int_saisit_temp(2);
 led(1) <= int_saisit_temp(1);
 led(0) <= int_saisit_temp(0);

	---- Entité gérant tout les calculs ---
 C1 : calcul_entity port map( clk => clock, A_op => A(3 downto 0), B_op=> B(3 downto 0), Res_op => Res,
										b_signeA => int_signeA, b_signeB => int_signeB,led_signe_resultat => led(4),
										b_cla => int_cla, b_operation => int_operation, 
										cla_A => A_ext, cla_B => B_ext
									 );

									 
	--- Mettre en commmentaire Ligne 128 à 129	pour pouvoir selectionner avec l'interrupteur ---
   --- Code de Mr Schneider et Mr Derraz (ECE Paris) permettant de récupérer le signal IR ---
 --S1 : nec_receiver port map( clk => clock, data_in => data_input, reset => b_reset, command2 => com);
 
 --- Convertit le signal recu par IR pour écrire les opérandes A et B ---
 --S2 : conversion_signal_entity port map(saisit => int_saisit,NA => A, NB => B, comm => com);
	
	--- Mettre en commmentaire Ligne 135 à 136 pour pouvoir selectionner avec la télécommande ---
 A <= "0000" & int_saisit_temp when int_saisit = '0';
 B <= "0000" & int_saisit_temp when int_saisit = '1';

	--A_ext <= "0000";
	--B_ext <= "1111";
	
	--res <= A(3 downto 0)*B(3 downto 0);
 

 
-- --- Affiche en permanence A, B et Res sur les digit 7 segments ---
	 A1 : affichage_entity port map( Nombre => A, Affichage => affich_A); 					--- Affichage de A ---
	 A2 : affichage_entity port map( Nombre => B, affichage => affich_B); 						--- Affichage de B ---
	 A3 : affichage_entity port map( Nombre => Res, Affichage => affich_Res); 		--- Affichage de Res ---

 --- Est censé buzzé un nombre de fois correspondant au resultat (Ex: Res = 3 -> 3 bip)
 B1 : buzzer_entity port map(reset => b_resetBuzzer, Res2 => Res(3 downto 0), bip => buzzer,clk => clock);

end Calculatrice_archi;