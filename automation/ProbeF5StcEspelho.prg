* ProbeF5StcEspelho.prg
* Fase 5 / task807 - SigFiSit e SigFiSii estao VAZIAS no banco (medido:
* COUNT(*) = 0 nas duas), entao nao ha linha real para provar a exibicao
* pelo caminho da consulta. Este probe prova o ELO que a Fase 5 acrescenta
* (property do BO -> .Value do campo na tela) alimentando as properties a
* mao e chamando AtualizarCabecalho, que eh exatamente o que CarregarDados
* faz depois da consulta.
*
* Tambem prova o caminho inverso: com property vazia o campo fica vazio
* (nao estoura), e o ALLTRIM come o padding do char() do banco.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cOut, loc_cRel, loc_oForm, loc_oPai, loc_oErro, loc_oBO, loc_lRet

loc_cOut = "C:\4c\automation\_f5stc_espelho.txt"
loc_cRel = "CHECKPOINT 1 - vivo" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f5stc_esperros.txt"
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "PROBE"

CD C:\4c\projeto\app\start
DO config.prg

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SIGOPSTCBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSIGOPSTC.prg") ADDITIVE

loc_cRel = loc_cRel + "CHECKPOINT 2 - dependencias OK" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

loc_oPai = CREATEOBJECT("Form")
loc_oPai.AddProperty("pcSelFile", "CAT0001.TXT")

TRY
    loc_oForm = CREATEOBJECT("FormSIGOPSTC", loc_oPai)
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "EXCECAO: " + loc_oErro.Message + " | Linha " + ;
        TRANSFORM(loc_oErro.LineNo) + " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

loc_cRel = loc_cRel + "VARTYPE(form) = [" + VARTYPE(loc_oForm) + "]" + CHR(13) + CHR(10)

IF VARTYPE(loc_oForm) = "O"
    loc_cRel = loc_cRel + "this_cArqMovsPai (de poForm.pcSelFile) = [" + ;
        loc_oForm.this_cArqMovsPai + "]" + CHR(13) + CHR(10)

    loc_cRel = loc_cRel + "--- ESTADO INICIAL (sem consulta: campos vazios)" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Text1=[" + loc_oForm.txt_4c_Text1.Value + "]" + ;
        " Text2=[" + loc_oForm.txt_4c_Text2.Value + "]" + ;
        " Text3=[" + loc_oForm.txt_4c_Text3.Value + "]" + CHR(13) + CHR(10)

    *-- Alimenta as properties COM O PADDING do char() do banco, como o
    *-- CarregarDoCursor faria lendo carqmovs char(12) / cnumlotes char(10)
    *-- / cemps char(3)
    loc_oBO = loc_oForm.this_oBusinessObject
    loc_oBO.this_cCArqMovs  = PADR("CAT0001.TXT", 12)
    loc_oBO.this_cCNumLotes = PADR("778899", 10)
    loc_oBO.this_cCEmps     = PADR("001", 3)
    loc_oBO.this_cCImpFabs  = PADR("IMPFISCAL01", 20)

    loc_lRet = loc_oForm.AtualizarCabecalho()

    loc_cRel = loc_cRel + "--- DEPOIS DE AtualizarCabecalho (retorno = " + ;
        TRANSFORM(loc_lRet) + ")" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Text1=[" + loc_oForm.txt_4c_Text1.Value + "] len=" + ;
        TRANSFORM(LEN(loc_oForm.txt_4c_Text1.Value)) + ;
        "  esperado [CAT0001.TXT] len=11" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Text2=[" + loc_oForm.txt_4c_Text2.Value + "] len=" + ;
        TRANSFORM(LEN(loc_oForm.txt_4c_Text2.Value)) + ;
        "  esperado [778899] len=6" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Text3=[" + loc_oForm.txt_4c_Text3.Value + "] len=" + ;
        TRANSFORM(LEN(loc_oForm.txt_4c_Text3.Value)) + ;
        "  esperado [001] len=3" + CHR(13) + CHR(10)

    loc_cRel = loc_cRel + "  CONFERE = " + ;
        IIF(loc_oForm.txt_4c_Text1.Value == "CAT0001.TXT" AND ;
            loc_oForm.txt_4c_Text2.Value == "778899" AND ;
            loc_oForm.txt_4c_Text3.Value == "001", "SIM", "NAO") + CHR(13) + CHR(10)

    *-- Property vazia tem de devolver campo vazio, sem estourar
    loc_oBO.this_cCNumLotes = ""
    loc_lRet = loc_oForm.AtualizarCabecalho()
    loc_cRel = loc_cRel + "--- property vazia: retorno=" + TRANSFORM(loc_lRet) + ;
        " Text2=[" + loc_oForm.txt_4c_Text2.Value + "] len=" + ;
        TRANSFORM(LEN(loc_oForm.txt_4c_Text2.Value)) + CHR(13) + CHR(10)

    loc_oForm.Release()
    loc_oForm = .NULL.
ENDIF

loc_cRel = loc_cRel + "--- ARQUIVO DE ERRO DE TESTE" + CHR(13) + CHR(10)
IF FILE("C:\4c\automation\_f5stc_esperros.txt")
    loc_cRel = loc_cRel + FILETOSTR("C:\4c\automation\_f5stc_esperros.txt") + CHR(13) + CHR(10)
ELSE
    loc_cRel = loc_cRel + "  (vazio - nenhum MsgErro/MsgAviso disparado)" + CHR(13) + CHR(10)
ENDIF

loc_cRel = loc_cRel + "FIM" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

QUIT
