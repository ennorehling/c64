	processor    6502
	org $0801 ; sys2061
sysline:
	.byte $0b,$08,$01,$00,$9e,$32,$30,$36,$31,$00,$00,$00

	org $080d ; sys2061

	;clear screen
	jsr $e544

	; disable interrupts
	sei
	lda #$7f
	sta $dc0d
	sta $dd0d
	lda #$01
	sta $d01a

	; set text mode
	lda #$1b
	ldx #$08
	ldy #$14
	sta $d011
	stx $d016
	sty $d014

	; init irq
	lda #<irq
	ldx #>irq
	sta $0314
	stx $0315

	; create raster interrupt at line 0
	ldy #$00
	sty $d012

	; clear interrupts and ACK irq
	lda $dc0d
	lda $dd0d
	asl $d019
	cli

halt: jmp halt

irq:	
	inc $d020
	inc $d021

	; Create new raster interrupt after 16 lines
	lda #$10
	adc $d012
	sta $d012

	asl $d019 ; ack interrupt
	jmp $ea81 ; restore stack
