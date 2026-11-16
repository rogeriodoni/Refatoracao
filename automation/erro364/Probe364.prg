SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL loc_cOut, loBO, loE, loForm
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro364\erro.txt"
loc_cOut = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    GarantirClasse("Formsigregnf")
    loBO = CREATEOBJECT("T364BO")
    loc_cOut = loc_cOut + "bo=" + VARTYPE(loBO) + CHR(13)+CHR(10)
    loc_cOut = loc_cOut + "Init passo-a-passo: " + loBO.Passos() + CHR(13)+CHR(10)
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + " | " + loE.LineContents + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro364\probe_out.txt")
QUIT

DEFINE CLASS T364BO AS sigregnfBO
    PROCEDURE Init()
        RETURN .T.
    ENDPROC
    PROCEDURE Passos()
        LOCAL c, loE2
        c = ""
        TRY
            CREATE CURSOR (THIS.this_cCursorNFis) (Flag l, Emis d, Series c(3), Operas c(1), CFis c(10), NFis c(6), TotNotas n(12,2), Conta c(40), Operacao c(30), Emps c(3), Dopes c(20), Numes n(6))
            INDEX ON NFis TAG NFis
            c = c + "[cursorNFis ok]"
            CREATE CURSOR (THIS.this_cCursorClientes) (Iclis c(10), RClis c(50))
            INDEX ON Iclis TAG Iclis
            c = c + "[clientes ok]"
            c = c + "[pam=" + TRANSFORM(SQLEXEC(gnConnHandle, "SELECT MascNums FROM SigCdPam", "cursor_4c_SigCdPam")) + "]"
            SELECT cursor_4c_SigCdPam
            c = c + "[mascnums tipo=" + VARTYPE(MascNums) + " val=" + TRANSFORM(MascNums) + "]"
            THIS.this_cMascNums = ALLTRIM(NVL(MascNums, ""))
            c = c + "[mask ok]"
            c = c + "[ser=" + TRANSFORM(SQLEXEC(gnConnHandle, "SELECT EmpCods, TipoNfs FROM SigCdSer", THIS.this_cCursorSeries)) + "]"
            SELECT (THIS.this_cCursorSeries)
            INDEX ON EmpCods TAG EmpCods
            c = c + "[ser idx ok]"
            c = c + "[dodefault=" + TRANSFORM(RelatorioBase::Init()) + "]"
        CATCH TO loE2
            c = c + " ERRO: " + loE2.Message + " | " + loE2.LineContents
        ENDTRY
        RETURN c
    ENDPROC
ENDDEFINE
