*==============================================================================
* ProbeDupLayout.prg - Probe de LAYOUT da pagina Lista de FormDup (Erro231)
*
* MEDE em VFP9 (nao le o codigo): a posicao ABSOLUTA de cada membro da pagina
* Lista depois do Init, para comparar com a geometria do legado:
*
*   Legado (frmcadastro + overrides do SCX SIGCDDUP), ja em Y de TELA:
*     cntSombra     Top=1    Left=11  996x80
*     Grupo_op      Top=-1   Left=513 414x85   (botoes internos Top=5)
*     Grupo_Saida   Top=-1   Left=919  85x85   (botao interno Top=5)
*     Copia         Top=4    Left=474  75x75
*     Grade         Top=121  Left=12  940x470
*
* O migrado usa pgf_4c_Paginas.Top = -29 com Tabs = .F., entao o Y de TELA de
* um filho da Page eh (Top do filho - 29). O legado usa Pagina.Top = -28 com
* Tabs = .T. (default), e a faixa de abas de ~28px cancela o offset.
*
* NAO chama Show(): o form eh modal (WindowType = 1) e travaria o harness.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_duplayout.txt"

#DEFINE OUT "C:\4c\automation\probe_dup_layout.txt"
#DEFINE OFFSET -29

LOCAL loc_oForm, loc_oPg, loc_cL, loc_oE

STRTOFILE("=== PROBE LAYOUT - FormDup pagina Lista (Erro231) ===" + CHR(13)+CHR(10), OUT)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "DupBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormDup.prg") ADDITIVE

    STRTOFILE("gnConnHandle apos config = " + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10), OUT, 1)

    *-- a conexao eh feita no main.prg (ConectarBancoDados), nao no config.prg
    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
        gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
        STRTOFILE("gnConnHandle apos SQLSTRINGCONNECT = " + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10), OUT, 1)
    ENDIF

    loc_oForm = CREATEOBJECT("FormDup")

    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("*** FORM NAO INSTANCIOU ***" + CHR(13)+CHR(10), OUT, 1)
    ELSE
        STRTOFILE("Form OK  Width=" + TRANSFORM(loc_oForm.Width) + ;
                  " Height=" + TRANSFORM(loc_oForm.Height) + CHR(13)+CHR(10), OUT, 1)
        STRTOFILE("pgf_4c_Paginas Top=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Top) + ;
                  " Height=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Height) + ;
                  " Tabs=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Tabs) + CHR(13)+CHR(10)+CHR(13)+CHR(10), OUT, 1)

        loc_oPg = loc_oForm.pgf_4c_Paginas.Page1

        STRTOFILE("objeto                 Top  Left Width Height   Y-TELA  legado-Y" + CHR(13)+CHR(10), OUT, 1)
        STRTOFILE(REPLICATE("-", 70) + CHR(13)+CHR(10), OUT, 1)

        DO MedeCtl WITH loc_oPg, "cnt_4c_Cabecalho", 1
        DO MedeCtl WITH loc_oPg, "cnt_4c_Botoes",   -1
        DO MedeCtl WITH loc_oPg, "cnt_4c_Saida",    -1
        DO MedeCtl WITH loc_oPg, "cmd_4c_Copia",     4
        DO MedeCtl WITH loc_oPg, "grd_4c_Lista",   121
        DO MedeCtl WITH loc_oPg, "cnt_4c_CopiaFl", 241

        *-- Botoes DENTRO dos containers: Y de tela = cnt.Top + btn.Top + OFFSET
        STRTOFILE(CHR(13)+CHR(10) + "botoes (Y de tela ja somando o container):" + CHR(13)+CHR(10), OUT, 1)
        DO MedeBtn WITH loc_oPg.cnt_4c_Botoes, "cmd_4c_Incluir",    loc_oPg.cnt_4c_Botoes.Top
        DO MedeBtn WITH loc_oPg.cnt_4c_Botoes, "cmd_4c_Visualizar", loc_oPg.cnt_4c_Botoes.Top
        DO MedeBtn WITH loc_oPg.cnt_4c_Botoes, "cmd_4c_Alterar",    loc_oPg.cnt_4c_Botoes.Top
        DO MedeBtn WITH loc_oPg.cnt_4c_Botoes, "cmd_4c_Excluir",    loc_oPg.cnt_4c_Botoes.Top
        DO MedeBtn WITH loc_oPg.cnt_4c_Botoes, "cmd_4c_Buscar",     loc_oPg.cnt_4c_Botoes.Top
        DO MedeBtn WITH loc_oPg.cnt_4c_Saida,  "cmd_4c_Encerrar",   loc_oPg.cnt_4c_Saida.Top

        *-- Propriedades que o Erro231 acusou
        STRTOFILE(CHR(13)+CHR(10) + "cnt_4c_Botoes.BackStyle = " + ;
                  TRANSFORM(loc_oPg.cnt_4c_Botoes.BackStyle) + " (legado Grupo_op.BackStyle = 0)" + CHR(13)+CHR(10), OUT, 1)
        STRTOFILE("cmd_4c_Copia.Picture    = " + JUSTFNAME(loc_oPg.cmd_4c_Copia.Picture) + ;
                  " (legado Copia.Picture = geral_subnivel_60.jpg)" + CHR(13)+CHR(10), OUT, 1)
        STRTOFILE("  arquivo existe?       = " + TRANSFORM(FILE(loc_oPg.cmd_4c_Copia.Picture)) + CHR(13)+CHR(10), OUT, 1)
        STRTOFILE("grd_4c_Lista.FontName   = " + loc_oPg.grd_4c_Lista.FontName + ;
                  " (legado Grade.FontName = Tahoma)" + CHR(13)+CHR(10), OUT, 1)
        STRTOFILE("Column1.Width           = " + TRANSFORM(loc_oPg.grd_4c_Lista.Column1.Width) + ;
                  " (legado pColuna largura = 50)" + CHR(13)+CHR(10), OUT, 1)
        STRTOFILE("Column1.Header1.Caption = [" + loc_oPg.grd_4c_Lista.Column1.Header1.Caption + ;
                  "] (legado pColuna legenda = [Series])" + CHR(13)+CHR(10), OUT, 1)
        STRTOFILE("titulo lbl_4c_Titulo    = [" + loc_oPg.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption + "]" + CHR(13)+CHR(10), OUT, 1)

        loc_oForm.Release()
    ENDIF
CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ;
              ", " + loc_oE.Procedure + ")" + CHR(13)+CHR(10), OUT, 1)
ENDTRY

STRTOFILE(CHR(13)+CHR(10) + "=== FIM ===" + CHR(13)+CHR(10), OUT, 1)
QUIT


PROCEDURE MedeCtl(par_oPg, par_cNome, par_nLegadoY)
    LOCAL loc_o, loc_cL, loc_nTela
    IF !PEMSTATUS(par_oPg, par_cNome, 5)
        STRTOFILE(PADR(par_cNome, 22) + "*** NAO EXISTE ***" + CHR(13)+CHR(10), OUT, 1)
        RETURN
    ENDIF
    loc_o = EVALUATE("par_oPg." + par_cNome)
    loc_nTela = loc_o.Top + OFFSET
    loc_cL = PADR(par_cNome, 22) + ;
             PADL(TRANSFORM(loc_o.Top), 4) + " " + ;
             PADL(TRANSFORM(loc_o.Left), 5) + " " + ;
             PADL(TRANSFORM(loc_o.Width), 5) + " " + ;
             PADL(TRANSFORM(loc_o.Height), 6) + "  " + ;
             PADL(TRANSFORM(loc_nTela), 7) + " " + ;
             PADL(TRANSFORM(par_nLegadoY), 9) + ;
             IIF(ABS(loc_nTela - par_nLegadoY) <= 2, "  OK", "  <<< DIVERGE")
    STRTOFILE(loc_cL + CHR(13)+CHR(10), OUT, 1)
ENDPROC


PROCEDURE MedeBtn(par_oCnt, par_cNome, par_nCntTop)
    LOCAL loc_o, loc_nTela
    IF !PEMSTATUS(par_oCnt, par_cNome, 5)
        STRTOFILE("  " + PADR(par_cNome, 20) + "*** NAO EXISTE ***" + CHR(13)+CHR(10), OUT, 1)
        RETURN
    ENDIF
    loc_o = EVALUATE("par_oCnt." + par_cNome)
    loc_nTela = par_nCntTop + loc_o.Top + OFFSET
    STRTOFILE("  " + PADR(par_cNome, 20) + ;
              " Top=" + PADL(TRANSFORM(loc_o.Top), 3) + ;
              " Left=" + PADL(TRANSFORM(par_oCnt.Left + loc_o.Left), 4) + ;
              " Y-TELA=" + PADL(TRANSFORM(loc_nTela), 4) + ;
              IIF(ABS(loc_nTela - 4) <= 2, "  OK (legado 4)", "  <<< DIVERGE (legado 4)") + ;
              CHR(13)+CHR(10), OUT, 1)
ENDPROC
