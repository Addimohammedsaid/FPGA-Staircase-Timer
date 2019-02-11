Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity bcd is

port(Clock,Reset: in std_logic ; Output :out std_logic ;
		Button :  in std_logic ; 
		Switch:   in std_logic_vector   ( 2 downto 0 ); 
		SEG_vec1 : out std_logic_vector ( 6 downto 0 );
		SEG_vec2 : out std_logic_vector ( 6 downto 0 );
		SEG_vec3 : out std_logic_vector ( 6 downto 0 )
		 );

end bcd ;

architecture abcd  of bcd is

		signal QIN: std_logic :='0';
		signal Stop_s,Rest_s : std_logic :='1';
		signal second_s,minut_s,counter_s : integer ;
		signal E_su,E_sd,E_mu :  integer :=0;
		signal S_su,S_sd,S_mu :  std_logic_vector(6 downto 0);
		signal j,k : integer :=0 ;
	
	
component timer is
    
    port(Clk,Rest,Stop: in std_logic :='0' ;
		Counter : inout integer;
		Seconds : inout integer;
		Minutes : inout integer );
 
 end component ;
 
 component seg is
    
      port(
      E : in integer :=0 ;
      S : out std_logic_vector(6 downto 0)
      );
 
 end component ;
 
begin 
   		
	process(Clock,Reset,Button,Switch,counter_s,second_s,minut_s,j,k)is
	begin 
    
    if(falling_edge(Button))then Rest_s<='0';Stop_s<='0';
    end if;
    
    if(Reset='0') then Rest_s<='1';Stop_s<='1';
    end if;
    
	case Switch is 
    when "001"  => j <= 1 ; k<= 00;
    when "010"  => j <= 1 ; k<= 30;
    when "011"  => j <= 2 ; k<= 0;
    when "100"  => j <= 2 ; k<= 30;
    when "101"  => j <= 3 ; k<= 0;
    when "111"  => j <= 5 ; k<= 0;
    when others => j <= 0 ; k<= 30; 
    end case ;
    
	if (    (counter_s >= 1) and (second_s <= k) ) then QIN<='1';
	elsif ( (counter_s >= 1) and (minut_s  <= j) )    then QIN<='1';
    end if;
    
    if( (second_s >= k ) and (minut_s >= j)) then Rest_s<='1';Stop_s<='1';
    end if;
    
    if ( Stop_s = '1') then QIN <= '0';
    end if;
		
    end process;
    
    Output <= QIN ;
	
	E_mu <= minut_s;
	E_sd <= second_s/10;
	E_su <= second_s - E_sd*10 ;
	
	SEG_vec1 <= S_su;
	SEG_vec2 <= S_sd;
	SEG_vec3 <= S_mu;
    
    u1: timer port map (Clock,Rest_s,Stop_s,counter_s,second_s,minut_s);
    
    u2: seg   port map (E_su,S_su);
    u3: seg   port map (E_sd,S_sd);
    u4: seg   port map (E_mu,S_mu);

end abcd;