library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity seg is
      port(
      E : in integer :=0;
      S : out std_logic_vector(6 downto 0)
      );
end seg;

architecture aseg of seg is
begin
      with E select
     S <= "0000001"  when 0 ,
		  "1001111"  when 1,
		  "0010010"  when 2 ,
		  "0000110"  when 3 ,
		  "1001100"  when 4 ,
		  "0100100"  when 5 ,
		  "0100000"  when 6 ,
		  "0001111"  when 7 ,
		  "0000000"  when 8 ,
		  "0000100"  when 9 ,
		  "1111111"  when others ;
		  
end aseg;