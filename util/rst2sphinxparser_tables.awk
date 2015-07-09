#!/usr/bin/igawk -f
{
     if(match($0,/`[^`]+`_/) != 0 && match($0,/`Figure.*>`_/) == 0 && match($0,/`Table.*>`_/) == 0){
	match($0,/(`[^`]+`_)/,tmp)
	#Allows alphanumeric characters and apostrophe
	gsub("[^`[:alnum:]']","_",tmp[1])
	gsub(/_$/,"",tmp[1])
	tmp[1]=":ref:"tmp[1]
	gsub(/(`[^`]+`_)/,tmp[1],$0)
     }
     print $0 >> dst
}
