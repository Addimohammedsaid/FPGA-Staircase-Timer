Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


entity Timer is

port(Clk,Rest,Stop: in std_logic :='0';
	 Counter : inout integer;
     Seconds : inout integer;
     Minutes : inout integer
	);
    
end Timer;

architecture aTimer of Timer is
	
begin 
   		
	process(Clk,Stop,Rest)is
	begin 
	
	if Rest = '1' then 
                counter <= 0;
                Seconds <= 0;
                Minutes <= 0;
                
	 elsif (rising_edge(Clk)) and (Stop='0') then 
	
		if (Counter  >= 49) then Counter  <= 0;
		
		if (Seconds >= 59) then Seconds <= 0; 

		if (Minutes >= 59) then Minutes <= 0;
                               
        else  Minutes <= Minutes + 1; end if;
        
        else  Seconds <= Seconds + 1; end if;
        
		else counter <= counter+1; end if;
			
	end if;	 
	
   end process;
   
end aTimer ;