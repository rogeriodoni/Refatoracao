*==============================================================================
* ProbeErro298Mtz.prg - Erro298. Prova:
*   1) a linha "Centro de Custo" (Grupo/Conta/Descricao/Classe) e o getSaldo
*      NAO ficam mais debaixo da grade
*   2) as celulas Grupos/Contas da grade recebem TextBoxCentroCustoMtz_4c com
*      CurrentControl + Sparse, e sobrevivem ao rebind do RecordSource
*   3) PodeEditarCelulaCentroCusto segue o When do legado
*   4) containers de botao sem caixa branca sobre a faixa
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_mtz298.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

PUBLIC gcLog298
gcLog298 = "C:\4c\automation\probe_erro298_mtz.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcLog298)

LOCAL loc_oE, loForm, loPg2, loGrd, loc_nI, loc_cTxt, loc_nFundo

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "mtzBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\Formmtz.prg") ADDITIVE
    Log298("B: deps carregadas")

    loForm = CREATEOBJECT("Formmtz")
    Log298("C: CREATEOBJECT -> VARTYPE=" + VARTYPE(loForm))

    IF VARTYPE(loForm) = "O"
        loPg2 = loForm.pgf_4c_Paginas.Page2
        loGrd = loPg2.grd_4c_Dados

        Log298("D: Grade Top=" + TRANSFORM(loGrd.Top) + " Height=" + TRANSFORM(loGrd.Height) + ;
               " fim=" + TRANSFORM(loGrd.Top + loGrd.Height) + ;
               " | rodape Label20.Top=" + TRANSFORM(loPg2.lbl_4c_Label20.Top))

        *-- Nenhum campo do cabecalho pode ficar DENTRO da faixa da grade
        loc_cTxt = ""
        FOR loc_nI = 1 TO loPg2.ControlCount
            IF UPPER(loPg2.Controls(loc_nI).BaseClass) $ "TEXTBOX LABEL CHECKBOX" AND ;
               loPg2.Controls(loc_nI).Top < loGrd.Top + loGrd.Height AND ;
               loPg2.Controls(loc_nI).Top + loPg2.Controls(loc_nI).Height > loGrd.Top
                loc_cTxt = loc_cTxt + loPg2.Controls(loc_nI).Name + "(" + ;
                           TRANSFORM(loPg2.Controls(loc_nI).Top) + ") "
            ENDIF
        ENDFOR
        Log298("E: controles SOTERRADOS pela grade (tem de ser vazio): [" + loc_cTxt + "]")

        Log298("F: Sgrupo Top=" + TRANSFORM(loPg2.txt_4c_Sgrupo.Top) + ;
               " Sconta Top=" + TRANSFORM(loPg2.txt_4c_Sconta.Top) + ;
               " Saldo Top=" + TRANSFORM(loPg2.txt_4c_Saldo.Top) + ;
               " | InsFtc Top=" + TRANSFORM(loPg2.cnt_4c_InsFtc.Top) + ;
               " BackStyle=" + TRANSFORM(loPg2.cnt_4c_InsFtc.BackStyle) + ;
               " | BotoesAcao BackStyle=" + TRANSFORM(loPg2.cnt_4c_BotoesAcao.BackStyle))

        *-- Celulas de lookup instaladas pelo FormatarGradeDetalhe
        Log298("G: CriarCursorDetalheVazio = " + ;
               TRANSFORM(loForm.this_oBusinessObject.CriarCursorDetalheVazio("001")))
        loForm.this_cModoAtual = "INCLUIR"
        loGrd.ColumnCount  = 28
        loGrd.RecordSource = "cursor_4c_MtI"
        loGrd.Column1.ControlSource = "cursor_4c_MtI.Grupos"
        loGrd.Column2.ControlSource = "cursor_4c_MtI.Contas"
        loGrd.FontName = "Tahoma"
        loGrd.FontSize = 8
        loForm.FormatarGradeDetalhe()

        FOR loc_nI = 1 TO 2
            Log298("H: Column" + TRANSFORM(loc_nI) + " CurrentControl=[" + ;
                   loGrd.Columns(loc_nI).CurrentControl + "] Sparse=" + ;
                   TRANSFORM(loGrd.Columns(loc_nI).Sparse) + ;
                   " existe=" + TRANSFORM(PEMSTATUS(loGrd.Columns(loc_nI), "txt_4c_CentroCusto", 5)) + ;
                   " campo=[" + loGrd.Columns(loc_nI).txt_4c_CentroCusto.this_cCampo + "]" + ;
                   " MaxLength=" + TRANSFORM(loGrd.Columns(loc_nI).txt_4c_CentroCusto.MaxLength))
        ENDFOR

        *-- Idempotencia: rodar de novo nao pode duplicar nem perder
        loForm.FormatarGradeDetalhe()
        Log298("I: apos 2a chamada -> Column1.CurrentControl=[" + ;
               loGrd.Column1.CurrentControl + "] Column2.CurrentControl=[" + ;
               loGrd.Column2.CurrentControl + "]")

        *-- When do legado
        Log298("J: PodeEditar INCLUIR/Inativas=.F. -> " + ;
               TRANSFORM(loForm.PodeEditarCelulaCentroCusto()))
        loForm.this_oBusinessObject.this_lInativas = .T.
        Log298("   PodeEditar INCLUIR/Inativas=.T. -> " + ;
               TRANSFORM(loForm.PodeEditarCelulaCentroCusto()))
        loForm.this_oBusinessObject.this_lInativas = .F.
        loForm.this_cModoAtual = "LISTA"
        Log298("   PodeEditar LISTA               -> " + ;
               TRANSFORM(loForm.PodeEditarCelulaCentroCusto()))
        loForm.this_cModoAtual = "ALTERAR"
        Log298("   PodeEditar ALTERAR             -> " + ;
               TRANSFORM(loForm.PodeEditarCelulaCentroCusto()))

        *-- Valid da celula com valor vazio nao pode travar a saida
        Log298("K: ValidarGrupoGrade(vazio) = " + ;
               TRANSFORM(loForm.ValidarGrupoGrade(loGrd.Column1.txt_4c_CentroCusto)) + ;
               " | ValidarContaGrade(vazio) = " + ;
               TRANSFORM(loForm.ValidarContaGrade(loGrd.Column2.txt_4c_CentroCusto)))

        loForm.Release()
        Log298("L: Release OK")
    ENDIF

CATCH TO loc_oE
    Log298("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
           " | Proc:" + loc_oE.Procedure)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    Log298("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    Log298("DIALOGOS: nenhum")
ENDIF
Log298("Z: fim")
QUIT

PROCEDURE Log298(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcLog298, 1)
ENDPROC
