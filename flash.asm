; dasm source
	processor 6502
	
	org $0801 ; sys2061
sysline:
	.byte $0b,$08,$01,$00,$9e,$32,$30,$36,$31,$00,$00,$00

	org $080d ; sys2061

loop:	inc $d020
	inc $d021
	jmp loop

