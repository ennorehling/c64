; dasm source
	processor 6502
	
	org $1000
	
loop:	inc $d020
	inc $d021
	jmp loop

