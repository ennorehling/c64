	processor 6502

	org $0801 ; sys2061
sysline:
	.byte $0b,$08,$01,$00,$9e,$32,$30,$36,$31,$00,$00,$00

	org $080d ; sys2061
	lda #$80
	sta $07f8
	lda #$01
	sta $d015
	lda #$80
	sta $d000
	sta $d001
  rts

	org $2000
	INCBIN "sprite1.spr"
