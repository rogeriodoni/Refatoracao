*==============================================================================
* ProbeEmb728Fase8.prg - Probe da Fase 8 de FormSigOpEmb (task728)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA (CREATEOBJECT devolve objeto, nao .F.)
*   2) a grade existe com as 4 colunas do dump, headers, larguras e
*      ControlSource ligados ao cursor do BO
*   3) Column1 editavel; Column2/3/4 com When -> .F.
*   4) ESCOPOS dos metodos chamados de FORA da classe (CLAUDE.md #3/#51)
*   5) ValidarQuantidadeGrade grava qtds e RECALCULA pesos = qtds*pesoembs
*   6) o total segue o criterio do legado (SO Qtds > 0)
*   7) o Init zera "pesoemb" no form PAI, como o legado
*   8) o encerramento fecha os cursores da tela
*
* NAO chama Show(): o form eh modal (WindowType = 1) e Show() BLOQUEARIA o
* harness headless.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado, gb_4c_ValidandoUI
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_emb728.txt"
#DEFINE OUT "C:\4c\automation\probe_emb728_f8.txt"

LOCAL loc_oForm, loc_oPai, loc_nFalhas, loc_oE, loc_oG, loc_cAlias, loc_nTot
LOCAL loc_i, loc_j, loc_cM, loc_lProt
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 8 - FormSigOpEmb (Quantidade de embalagens) ===" + CHR(13)+CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    gb_4c_ModoTeste     = .T.
    gb_4c_ValidandoUI   = .T.
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpEmbBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpEmb.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeEmb728Fase8.prg" ADDITIVE

    gnConnHandle = -1

    *-- form PAI de mentira, para medir a devolucao do peso
    loc_oPai = CREATEOBJECT("ProbePaiEmb")

    *-- 1) instanciacao com os parametros do Init
    loc_oForm = CREATEOBJECT("FormSigOpEmb", loc_oPai, 7, "001", "MALOTE", 3)
    STRTOFILE("1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + CHR(13)+CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        loc_nFalhas = loc_nFalhas + 1
        STRTOFILE("   FALHA: form nao instanciou" + CHR(13)+CHR(10), OUT, 1)
    ELSE
        *-- 2) grade
        loc_oG     = loc_oForm.grd_4c_Dados
        loc_cAlias = "cursor_4c_Embalagens"
        STRTOFILE("2) grade: ColumnCount=" + TRANSFORM(loc_oG.ColumnCount) + ;
            " RecordSource=[" + loc_oG.RecordSource + "]" + ;
            " USED=" + TRANSFORM(USED(loc_cAlias)) + CHR(13)+CHR(10), OUT, 1)
        STRTOFILE("   Top/Left/W/H=" + TRANSFORM(loc_oG.Top) + "/" + TRANSFORM(loc_oG.Left) + ;
            "/" + TRANSFORM(loc_oG.Width) + "/" + TRANSFORM(loc_oG.Height) + ;
            "  RecordMark=" + TRANSFORM(loc_oG.RecordMark) + ;
            " DeleteMark=" + TRANSFORM(loc_oG.DeleteMark) + CHR(13)+CHR(10), OUT, 1)
        FOR loc_i = 1 TO loc_oG.ColumnCount
            STRTOFILE("   Col" + TRANSFORM(loc_i) + ;
                ": CS=[" + EVALUATE("loc_oG.Column" + TRANSFORM(loc_i) + ".ControlSource") + ;
                "] W=" + TRANSFORM(EVALUATE("loc_oG.Column" + TRANSFORM(loc_i) + ".Width")) + ;
                " Hdr=[" + EVALUATE("loc_oG.Column" + TRANSFORM(loc_i) + ".Header1.Caption") + ;
                "] RO=" + TRANSFORM(EVALUATE("loc_oG.Column" + TRANSFORM(loc_i) + ".ReadOnly")) + ;
                " Sparse=" + TRANSFORM(EVALUATE("loc_oG.Column" + TRANSFORM(loc_i) + ".Sparse")) + ;
                " CurCtl=[" + EVALUATE("loc_oG.Column" + TRANSFORM(loc_i) + ".CurrentControl") + "]" + ;
                CHR(13)+CHR(10), OUT, 1)
        ENDFOR
        IF loc_oG.ColumnCount != 4 OR EMPTY(loc_oG.RecordSource)
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: grade sem as 4 colunas ligadas" + CHR(13)+CHR(10), OUT, 1)
        ENDIF

        *-- 3) When das celulas
        STRTOFILE("3) When: Col1=" + TRANSFORM(loc_oG.Column1.txt_4c_Qtde.When()) + ;
            " Col2=" + TRANSFORM(loc_oG.Column2.txt_4c_Descricao.When()) + ;
            " Col3=" + TRANSFORM(loc_oG.Column3.txt_4c_PesoUnitario.When()) + ;
            " Col4=" + TRANSFORM(loc_oG.Column4.txt_4c_PesoTotal.When()) + CHR(13)+CHR(10), OUT, 1)
        IF !loc_oG.Column1.txt_4c_Qtde.When() OR loc_oG.Column2.txt_4c_Descricao.When() ;
            OR loc_oG.Column3.txt_4c_PesoUnitario.When() OR loc_oG.Column4.txt_4c_PesoTotal.When()
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: When das celulas divergente do dump" + CHR(13)+CHR(10), OUT, 1)
        ENDIF

        *-- 4) escopos (atributo 2 = PROTECTED)
        DIMENSION loc_aM[6]
        loc_aM[1] = "CarregarLista"
        loc_aM[2] = "BtnConfirmarClick"
        loc_aM[3] = "FecharDialogo"
        loc_aM[4] = "ValidarQuantidadeGrade"
        loc_aM[5] = "ObterPesoTotalEmbalagens"
        loc_aM[6] = "Activate"
        FOR loc_j = 1 TO ALEN(loc_aM)
            loc_cM    = loc_aM[loc_j]
            loc_lProt = PEMSTATUS(loc_oForm, loc_cM, 2)
            STRTOFILE("4) " + PADR(loc_cM, 26) + " existe=" + ;
                TRANSFORM(PEMSTATUS(loc_oForm, loc_cM, 5)) + ;
                " PROTECTED=" + TRANSFORM(loc_lProt) + CHR(13)+CHR(10), OUT, 1)
            IF loc_lProt
                loc_nFalhas = loc_nFalhas + 1
                STRTOFILE("   FALHA: " + loc_cM + " eh PROTECTED e eh chamado de FORA" + ;
                    CHR(13)+CHR(10), OUT, 1)
            ENDIF
        ENDFOR

        *-- 5/6) recalculo do peso + total pelo criterio do legado
        SELECT (loc_cAlias)
        APPEND BLANK
        REPLACE cods WITH "001", descs WITH "CAIXA", pesoembs WITH 2.50
        APPEND BLANK
        REPLACE cods WITH "002", descs WITH "SACOLA", pesoembs WITH 1.25
        APPEND BLANK
        REPLACE cods WITH "003", descs WITH "PALETE", pesoembs WITH 9.00

        GO 1
        loc_oForm.ValidarQuantidadeGrade(CREATEOBJECT("ProbeTxtEmb", 4))
        GO 2
        loc_oForm.ValidarQuantidadeGrade(CREATEOBJECT("ProbeTxtEmb", 2))
        GO 3
        loc_oForm.ValidarQuantidadeGrade(CREATEOBJECT("ProbeTxtEmb", 0))

        GO 1
        STRTOFILE("5) L1 qtds=" + TRANSFORM(qtds) + " pesoembs=" + TRANSFORM(pesoembs) + ;
            " pesos=" + TRANSFORM(pesos) + CHR(13)+CHR(10), OUT, 1)
        IF pesos != 10.00
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: 4 x 2,50 deveria dar 10,000" + CHR(13)+CHR(10), OUT, 1)
        ENDIF
        GO 2
        STRTOFILE("5) L2 qtds=" + TRANSFORM(qtds) + " pesos=" + TRANSFORM(pesos) + CHR(13)+CHR(10), OUT, 1)
        GO 3
        STRTOFILE("5) L3 qtds=" + TRANSFORM(qtds) + " pesos=" + TRANSFORM(pesos) + CHR(13)+CHR(10), OUT, 1)

        loc_nTot = loc_oForm.this_oBusinessObject.CalcularPesoTotalEmbalagens()
        STRTOFILE("6) total=" + TRANSFORM(loc_nTot) + " (esperado 12,500)  linhas c/qtde=" + ;
            TRANSFORM(loc_oForm.this_oBusinessObject.ContarLinhasComQuantidade()) + ;
            " (esperado 2)" + CHR(13)+CHR(10), OUT, 1)
        IF loc_nTot != 12.50
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: total divergente do criterio do legado" + CHR(13)+CHR(10), OUT, 1)
        ENDIF

        *-- 7) Init zera o pesoemb do pai, como o legado
        STRTOFILE("7) pai.pesoemb APOS Init = " + TRANSFORM(loc_oPai.pesoemb) + ;
            " (esperado 0)" + CHR(13)+CHR(10), OUT, 1)
        IF loc_oPai.pesoemb != 0
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: Init nao zerou pesoemb no pai" + CHR(13)+CHR(10), OUT, 1)
        ENDIF

        *-- 8) encerramento fecha os cursores da tela
        loc_oForm.Release()
        loc_oForm = .NULL.
        STRTOFILE("8) apos Release: USED(" + loc_cAlias + ")=" + ;
            TRANSFORM(USED(loc_cAlias)) + CHR(13)+CHR(10), OUT, 1)
        IF USED(loc_cAlias)
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: cursor da grade ficou aberto" + CHR(13)+CHR(10), OUT, 1)
        ENDIF
    ENDIF
CATCH TO loc_oE
    loc_nFalhas = loc_nFalhas + 1
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " | LN=" + TRANSFORM(loc_oE.LineNo) + ;
        " | PROC=" + loc_oE.Procedure + CHR(13)+CHR(10), OUT, 1)
ENDTRY

STRTOFILE(CHR(13)+CHR(10) + "RESULTADO: " + ;
    IIF(loc_nFalhas = 0, "OK", "FALHAS=" + TRANSFORM(loc_nFalhas)) + CHR(13)+CHR(10), OUT, 1)
QUIT

*-- form PAI de mentira: so tem a property que o dialogo escreve
DEFINE CLASS ProbePaiEmb AS Form
    pesoemb = -1
ENDDEFINE

*-- TextBox de mentira para o Valid da celula
DEFINE CLASS ProbeTxtEmb AS Custom
    Value = 0
    PROCEDURE Init(par_nValor)
        THIS.Value = par_nValor
    ENDPROC
ENDDEFINE
