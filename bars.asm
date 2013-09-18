	processor    6502
	org $0801 ; sys2061
sysline:
	.byte $0b,$08,$01,$00,$9e,$32,$30,$36,$31,$00,$00,$00

	org $080d ; sys2061

	lda #$00
	sta $02

incloop:
	lda $02
	cmp $d012
	bne incloop
	inc $d021
	adc #$10
	sta $02
decloop:
	lda $02
	cmp $d012
	bne decloop
	dec $d021
	sbc #$10
	sta $02
	jmp incloop
