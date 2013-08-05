@ECHO OFF
IF NOT EXIST %1.asm GOTO fail
C:\C64\dasm-2.20.11\bin\dasm.exe %1.asm -o%1.prg
IF ERRORLEVEL 1 GOTO fail
C:\C64\WinVICE-2.2-x64\x64.exe %1.prg
:fail
