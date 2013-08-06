; draw some text
	processor 6502

	org $0801 ; sys2061
sysline:
	.byte $0b,$08,$01,$00,$9e,$32,$30,$36,$31,$00,$00,$00

	org $080d ; sys2061

	jsr $e544 ; clear screen

	ldx #$00
write:	lda msg,x
	jsr $ffd2
	inx
	cpx #54
	bne write

        ldx #$00
setcol:	lda #$07
	sta $d800,x
	inx
	cpx #54
	bne setcol
        
	rts

;	org $1ffe
;	incbin "scrap_writer_iii_17.64c"

msg .byte "C64 PROGRAMMING TUTORIAL BY DIGITALERR0R OF DARK CODEX"
