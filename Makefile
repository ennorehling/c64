all: flash.prg multint.prg

clean:
	@rm *.prg

%.prg: %.asm
	dasm $< -o$@
