*==============================================================================
* ProbeErro301Grid.prg - Em que PASSO o objeto posto por Column.AddObject morre
* quando o alias do grid eh fechado e recriado (o que CarregarDetalhe faz).
* Grava incremental (STRTOFILE append) para nao perder nenhum passo.
* As FUNCTION/PROCEDURE ficam no FIM: em .prg o programa principal termina na
* primeira delas.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcL301
gcL301 = "C:\4c\automation\probe_erro301_grid.txt"
STRTOFILE("=== PROBE Erro301 ===" + CHR(13) + CHR(10), gcL301)

PUBLIC goG
LOCAL loc_oFrm, loc_oErro

CREATE CURSOR cur_mti (Grupos C(10), Contas C(10), V1 N(12,2), V2 N(12,2), ChkValida L)
INSERT INTO cur_mti VALUES ("G1", "C1", 1, 2, .F.)
GO TOP

loc_oFrm = CREATEOBJECT("Form")
loc_oFrm.AddObject("g", "Grid")
goG = loc_oFrm.g
goG.ColumnCount  = 5
goG.RecordSource = "cur_mti"
goG.Column5.AddObject("chk_4c_Check1", "CheckBox")
goG.Column5.CurrentControl = "chk_4c_Check1"
goG.Column5.Sparse         = .F.
goG.Column5.ControlSource  = "cur_mti.ChkValida"
Log301("1) montado          -> " + Estado())

*-- (a) CarregarDetalhe fecha o alias que o grid usa
USE IN cur_mti
TRY
    Log301("2) apos USE IN      -> " + Estado())
CATCH TO loc_oErro
    Log301("2) apos USE IN      -> ERRO ao ler estado: " + loc_oErro.Message + ;
           " | ColumnCount=" + TRANSFORM(goG.ColumnCount))
ENDTRY

*-- (b) e recria o cursor com o MESMO nome (equivale ao SQLEXEC)
CREATE CURSOR cur_mti (Grupos C(10), Contas C(10), V1 N(12,2), V2 N(12,2), ChkValida N(1,0))
INSERT INTO cur_mti VALUES ("G2", "C2", 3, 4, 1)
GO TOP
TRY
    Log301("3) apos recriar cur -> " + Estado())
CATCH TO loc_oErro
    Log301("3) apos recriar cur -> ERRO ao ler estado: " + loc_oErro.Message + ;
           " | ColumnCount=" + TRANSFORM(goG.ColumnCount))
ENDTRY

*-- (c) AlternarGradeDetalhe repoe ColumnCount + RecordSource
goG.ColumnCount  = 5
Log301("4) apos ColumnCount -> " + Estado())
goG.RecordSource = "cur_mti"
Log301("5) apos RecordSource-> " + Estado())

*-- (d) a linha exata que estourou na tela
TRY
    goG.Column5.CurrentControl = "chk_4c_Check1"
    Log301("6) CurrentControl   -> OK")
CATCH TO loc_oErro
    Log301("6) CurrentControl   -> ERRO: " + loc_oErro.Message)
ENDTRY

*-- (e) o conserto: AddObject idempotente ANTES de setar o CurrentControl
IF !PEMSTATUS(goG.Column5, "chk_4c_Check1", 5)
    goG.Column5.AddObject("chk_4c_Check1", "CheckBox")
    Log301("7) chk faltava      -> AddObject refeito")
ELSE
    Log301("7) chk ja existia")
ENDIF
TRY
    goG.Column5.CurrentControl = "chk_4c_Check1"
    goG.Column5.Sparse         = .F.
    Log301("   depois do fix    -> OK, " + Estado())
CATCH TO loc_oErro
    Log301("   depois do fix    -> ERRO: " + loc_oErro.Message)
ENDTRY

*-- (f) reduzir ColumnCount destroi?
goG.ColumnCount = 3
goG.ColumnCount = 5
Log301("8) ColumnCount 5-3-5-> " + Estado())

*-- (g) trocar SO o RecordSource, com o alias vivo
CREATE CURSOR cur_outro (Grupos C(10), Contas C(10), V1 N(12,2), V2 N(12,2), ChkValida N(1,0))
INSERT INTO cur_outro VALUES ("G3", "C3", 5, 6, 0)
IF !PEMSTATUS(goG.Column5, "chk_4c_Check1", 5)
    goG.Column5.AddObject("chk_4c_Check1", "CheckBox")
ENDIF
goG.Column5.CurrentControl = "chk_4c_Check1"
goG.RecordSource = "cur_outro"
Log301("9) so RecordSource  -> " + Estado())

Log301("Z: fim")
QUIT

PROCEDURE Log301(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcL301, 1)
ENDPROC

FUNCTION Estado()
    RETURN "ColumnCount=" + TRANSFORM(goG.ColumnCount) + ;
           " RecordSource=[" + goG.RecordSource + "]" + ;
           " chk=" + TRANSFORM(PEMSTATUS(goG.Column5, "chk_4c_Check1", 5)) + ;
           " CurrentControl=[" + goG.Column5.CurrentControl + "]"
ENDFUNC
