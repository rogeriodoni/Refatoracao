@echo off
REM ============================================================
REM  Erro340 - aplica o BLOCO 2 (SigCdPam.ContaEsts)
REM  Basta dar DUPLO CLIQUE neste arquivo.
REM ============================================================
setlocal
set SQLCMD=C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\sqlcmd.exe
set SCRIPT=C:\4c\origem\correcoes\erro340_tmp\bloco2_contaests.sql

echo.
echo Aplicando o bloco 2 em 192.168.200.10 / DB_MBAHIA ...
echo.
"%SQLCMD%" -S 192.168.200.10 -U 4control -P "f2016jstcr%%@" -d DB_MBAHIA -i "%SCRIPT%"

echo.
echo ------------------------------------------------------------
echo Esperado: conta_antes = 1121017307  /  conta_depois = 1121001
echo ------------------------------------------------------------
echo.
pause
