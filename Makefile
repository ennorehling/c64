all: flash.prg

clean:
	@rm *.prg

%.prg: %.asm
	dasm $< -o$@
