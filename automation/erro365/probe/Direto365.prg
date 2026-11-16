SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL loc_cOut, loE, lr
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_PrbDir, gn_4c_PrbPag
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_PrbDir = "C:\4c\refatoracao\automation\erro365\probe\"
gn_4c_PrbPag = 0
gc_4c_ArquivoErroTeste = gc_4c_PrbDir + "mensagens2.txt"
loc_cOut = ""
CD "C:\4c\refatoracao\projeto\app\start"
DO config.prg
ConfigurarAmbiente()
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
go_4c_Sistema.cCodEmpresa = "001"
CD (gc_4c_PrbDir)
loc_cOut = loc_cOut + "sigprnfs -> " + FULLPATH("sigprnfs.prg") + " | " + IIF(FILE(FULLPATH("sigprnfs.prg")),"existe","NAO")+ CHR(13)+CHR(10)
ON ERROR STRTOFILE("ON ERROR " + TRANSFORM(ERROR()) + " " + MESSAGE() + " prog=" + PROGRAM() + " linha=" + TRANSFORM(LINENO()) + " | " + MESSAGE(1) + CHR(13)+CHR(10), gc_4c_PrbDir + "onerror.txt", 1)
lr = SigPrNfs(.NULL., "V", "001", PADR("VENDA",20), 9364)
ON ERROR
loc_cOut = loc_cOut + "retorno=" + TRANSFORM(lr) + " png=" + TRANSFORM(gn_4c_PrbPag) + CHR(13)+CHR(10)
STRTOFILE(loc_cOut, gc_4c_PrbDir + "direto_out.txt")
QUIT
