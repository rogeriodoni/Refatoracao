*==============================================================================
* _probe788f8b.prg - Probe do BO REAL (SigOpPrLBO) + abertura do dialogo sem
* codigo de Linha. Fase 8 / task788. Descartavel.
*
* Mede a correcao de fidelidade aplicada nesta fase: codigo de Linha AUSENTE
* nao eh falha (o legado abre a tela com a descricao em branco - o "Return .f."
* do Init legado eh so para "If Not Used([LocalLin])", falha de CONEXAO).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE LOGF "C:\4c\automation\_probe788f8b.txt"

LOCAL loc_oBO, loc_oForm, loc_oErro, loc_oPai, loc_lRet

STRTOFILE("PROBE 788 F8-B INICIO " + TTOC(DATETIME()) + CHR(13) + CHR(10), LOGF)

DO config.prg
SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + gc_4c_CaminhoUtils + ;
             "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formerro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpPrLBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigOpPrL.prg") ADDITIVE

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe788f8b_erros.txt"
gc_4c_UsuarioLogado    = "PROBE788"
=STRTOFILE("CK01 ambiente OK (BO REAL carregado)" + CHR(13) + CHR(10), LOGF, 1)

*== BO real: escopo e os dois caminhos de guarda ==============================
loc_oBO = .NULL.
TRY
    loc_oBO = CREATEOBJECT("SigOpPrLBO")
CATCH TO loc_oErro
    =STRTOFILE("CK02 BO FALHOU: " + loc_oErro.Message + CHR(13) + CHR(10), LOGF, 1)
ENDTRY

IF VARTYPE(loc_oBO) = "O"
    =STRTOFILE("CK02 BO VARTYPE=O tabela=[" + loc_oBO.this_cTabela + "] chave=[" + ;
        loc_oBO.this_cCampoChave + "]" + CHR(13) + CHR(10), LOGF, 1)

    *-- Metodo chamado de FORA pelo form nao pode ser PROTECTED (regra #51)
    =STRTOFILE("CK03 BuscarLinha PROTECTED=" + TRANSFORM(PEMSTATUS(loc_oBO, "BuscarLinha", 2)) + ;
        " CarregarDoCursor PROTECTED=" + TRANSFORM(PEMSTATUS(loc_oBO, "CarregarDoCursor", 2)) + CHR(13) + CHR(10), LOGF, 1)

    *-- (a) codigo AUSENTE: tem de devolver .T. com os campos em branco
    loc_lRet = loc_oBO.BuscarLinha("")
    =STRTOFILE("CK04 BuscarLinha(vazio) ret=" + TRANSFORM(loc_lRet) + ;
        " desc=[" + loc_oBO.this_cDescricaoLinha + "]" + ;
        " figLen=" + TRANSFORM(LEN(loc_oBO.this_cFiguraLinha)) + CHR(13) + CHR(10), LOGF, 1)

    *-- (b) sem conexao e COM codigo: tem de devolver .F. (equivale ao
    *--     "If Not Used([LocalLin])" do legado, que aborta a abertura)
    loc_lRet = loc_oBO.BuscarLinha("LIN788")
    =STRTOFILE("CK05 BuscarLinha(cod) sem conexao ret=" + TRANSFORM(loc_lRet) + ;
        " msg=[" + loc_oBO.this_cMensagemErro + "]" + CHR(13) + CHR(10), LOGF, 1)

    *-- (c) tipo invalido tambem nao eh falha
    loc_lRet = loc_oBO.BuscarLinha(0)
    =STRTOFILE("CK06 BuscarLinha(numerico) ret=" + TRANSFORM(loc_lRet) + CHR(13) + CHR(10), LOGF, 1)
ENDIF

*== Form com o BO REAL e SEM codigo de Linha: tem de ABRIR ====================
CREATE CURSOR cursor_4c_BusLin ( ;
    Selecao L, DPros C(60), PVens N(14,2), MoeVs C(3), ;
    Sqtds N(14,3), CPros C(20), CGrus C(3))
INSERT INTO cursor_4c_BusLin (Selecao, DPros, PVens, MoeVs, Sqtds, CPros, CGrus) ;
    VALUES (.F., "PRODUTO UM", 10.50, "R$", 3.000, "P001", "G01")
GO TOP IN cursor_4c_BusLin

loc_oPai = CREATEOBJECT("Form")
loc_oPai.Enabled = .T.

loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSigOpPrL", loc_oPai, "", .NULL.)
CATCH TO loc_oErro
    =STRTOFILE("CK07 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10), LOGF, 1)
ENDTRY

=STRTOFILE("CK07 form SEM codigo de Linha -> VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), LOGF, 1)

IF VARTYPE(loc_oForm) = "O"
    =STRTOFILE("CK08 lblLinha=[" + loc_oForm.lbl_4c_LblLinha.Caption + "] imgVisible=" + ;
        TRANSFORM(loc_oForm.img_4c_ImgLinhas.Visible) + ;
        " grid ColumnCount=" + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + ;
        " RecordSource=[" + loc_oForm.grd_4c_Dados.RecordSource + "]" + ;
        " botao=[" + loc_oForm.cmg_4c_Saida.Buttons(1).Caption + "]" + CHR(13) + CHR(10), LOGF, 1)
    loc_oForm.BtnEncerrarClick()
    =STRTOFILE("CK09 Encerrar -> pai reabilitado=" + TRANSFORM(loc_oPai.Enabled) + CHR(13) + CHR(10), LOGF, 1)
ENDIF

=STRTOFILE("FIM" + CHR(13) + CHR(10), LOGF, 1)
QUIT
