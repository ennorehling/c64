; play music, do some shit
	processor 6502

	org $0801 ; sys2061
sysline:
	.byte $0b,$08,$01,$00,$9e,$32,$30,$36,$31,$00,$00,$00

	org $080d ; sys2061
	jsr $e544 ; clear screen
        lda #$00
	sta $d020
	sta $d021
	tax
	tay
	jsr $1000 ; init sid

	; interrupt init
	sei

	; disable cia1, ci2, vic intr
	lda #$7f
	sta $dc0d
	sta $dd0d

	; enable raster intr
	lda #$01
	sta $d01a

	; enter single-color mode
	lda #$1b
	ldx #$08
	ldy #$14
	sta $d011 ; text mode
	stx $d016 ; single color
	sty $d018 ; default charset

	lda #<irq1
	ldx #>irq1
	sta $0314
	stx $0315

	ldy #$7e ; raster interrupt at line 7e
	sty $d012

	; clear pending intr.
	lda $dc0d
	lda $dd0d
	asl $d019

	cli

	; hello world
	ldx #$00
write:	lda msg,x
	jsr $ffd2
	inx
	cpx #26
	bne write

        ldx #$00
	ldy #$07
setcol: tya
	sta $d800,x
	iny
	inx
	cpx #26
	bne setcol

loop:	jmp loop

irq1:	lda #$06
	sta $d020
	sta $d021
	lda #<irq2
	ldx #>irq2
	sta $0314
	stx $0315
	ldy #$a0
	sty $d012

	asl $d019 ; ack intr
	jmp $ea81


irq2:	lda #$05
	sta $d020
	sta $d021
	jsr $1006 ; play music
	lda #<irq1
	ldx #>irq1
	sta $0314
	stx $0315
	ldy #$00
	sty $d012
	asl $d019 ; ack intr
	jmp $ea81

	org $1000-$7e
	incbin "music.sid"

msg .byte "LOREM IPSUM DOLOR SIT AMET"
