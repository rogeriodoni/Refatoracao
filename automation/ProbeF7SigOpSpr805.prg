*==============================================================================
* ProbeF7SigOpSpr805.prg - probe headless da FASE 7 do FormSigOpSpr (task805)
*
* Prova (a) que o form ainda INSTANCIA depois do ConfigurarEventosBotoes,
* (b) que o BINDEVENT dos tres botoes foi registrado de fato (AEVENTS) e
* (c) que os handlers MEXEM no cursor do form pai - inserir/excluir linha e
* descartar as linhas em branco -, nao so retornam .T.
*
* NAO chama ConfigurarAmbiente() (ela nao retorna nesta maquina): carrega a
* mao so o que o form usa.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DELETED ON
SET EXACT ON

LOCAL lcOut, lcSai, loForm, loPai, lnBind
lcOut = "C:\4c\automation\fase7_sigopspr805_probe.txt"
lcSai = ""

STRTOFILE("[1] VIVO" + CHR(13) + CHR(10), lcOut)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\fase7_sigopspr805_dialogs.txt"
gnConnHandle           = 0
STRTOFILE("", gc_4c_ArquivoErroTeste)

CD C:\4c\projeto\app\start
DO config.prg
STRTOFILE("[2] config.prg OK" + CHR(13) + CHR(10), lcOut, 1)

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)

SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")        ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "textboxgridlookup.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")           ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SigOpSprBO.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpSpr.prg") ADDITIVE
STRTOFILE("[3] SET PROCEDURE OK" + CHR(13) + CHR(10), lcOut, 1)

*-- Cursor LOCAL que no legado pertence ao form PAI (crProdutos)
IF USED("cursor_4c_Produtos")
    USE IN cursor_4c_Produtos
ENDIF
CREATE CURSOR cursor_4c_Produtos (CPros C(14), DPros C(65))
INSERT INTO cursor_4c_Produtos (CPros, DPros) VALUES ("P001", "PRODUTO UM")
INSERT INTO cursor_4c_Produtos (CPros, DPros) VALUES ("P002", "PRODUTO DOIS")
STRTOFILE("[4] cursor criado RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Produtos")) + ;
          CHR(13) + CHR(10), lcOut, 1)

loPai = CREATEOBJECT("StubPaiSpr")
loForm = CREATEOBJECT("FormSigOpSpr", loPai)

STRTOFILE("[5] CREATEOBJECT VARTYPE=" + VARTYPE(loForm) + ;
          CHR(13) + CHR(10), lcOut, 1)

IF VARTYPE(loForm) = "O"
    *-- Init legado: Append Blank quando nao ha linha com CPros vazio
    STRTOFILE("[6] pos-Init RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Produtos")) + ;
              " (esperado 3: as 2 linhas + a em branco do Init)" + ;
              CHR(13) + CHR(10), lcOut, 1)

    STRTOFILE("[7] PaiEnabled=" + TRANSFORM(loPai.Enabled) + ;
              " (esperado .F.: o Init desabilita o pai)" + ;
              CHR(13) + CHR(10), lcOut, 1)

    *-- BINDEVENT registrado? AEVENTS com o OBJETO fonte lista os binds dele
    lnBind = 0
    IF AEVENTS(laEvIns, loForm.cmg_4c_CmdEscolha.Buttons(1)) > 0
        lnBind = ALEN(laEvIns, 1)
    ENDIF
    STRTOFILE("[8] binds em cmdEscolha.Buttons(1)=" + TRANSFORM(lnBind) + ;
              CHR(13) + CHR(10), lcOut, 1)

    lnBind = 0
    IF AEVENTS(laEvExc, loForm.cmg_4c_CmdEscolha.Buttons(2)) > 0
        lnBind = ALEN(laEvExc, 1)
    ENDIF
    STRTOFILE("[9] binds em cmdEscolha.Buttons(2)=" + TRANSFORM(lnBind) + ;
              CHR(13) + CHR(10), lcOut, 1)

    lnBind = 0
    IF AEVENTS(laEvSai, loForm.cmg_4c_CmdSalva.Buttons(1)) > 0
        lnBind = ALEN(laEvSai, 1)
    ENDIF
    STRTOFILE("[10] binds em cmdSalva.Buttons(1)=" + TRANSFORM(lnBind) + ;
              CHR(13) + CHR(10), lcOut, 1)

    *-- BtnInserirClick com uma linha em branco JA existente: nao cria outra,
    *-- vai para ela (ramo Locate do legado)
    loForm.BtnInserirClick()
    STRTOFILE("[11] Inserir com branco existente RECCOUNT=" + ;
              TRANSFORM(RECCOUNT("cursor_4c_Produtos")) + ;
              " RECNO=" + TRANSFORM(RECNO("cursor_4c_Produtos")) + ;
              " CPros=[" + ALLTRIM(cursor_4c_Produtos.CPros) + "]" + ;
              " (esperado RECCOUNT 3 e CPros vazio)" + ;
              CHR(13) + CHR(10), lcOut, 1)

    *-- Preenche a linha em branco e insere de novo: agora SEM branco livre,
    *-- cai no ramo Append Blank
    SELECT cursor_4c_Produtos
    REPLACE CPros WITH "P003", DPros WITH "PRODUTO TRES"
    loForm.BtnInserirClick()
    STRTOFILE("[12] Inserir sem branco livre RECCOUNT=" + ;
              TRANSFORM(RECCOUNT("cursor_4c_Produtos")) + ;
              " (esperado 4)" + CHR(13) + CHR(10), lcOut, 1)

    *-- BtnExcluirClick apaga a linha CORRENTE (a em branco recem-criada)
    loForm.BtnExcluirClick()
    SELECT cursor_4c_Produtos
    COUNT TO lnVisiveis
    STRTOFILE("[13] pos-Excluir visiveis=" + TRANSFORM(lnVisiveis) + ;
              " (esperado 3)" + CHR(13) + CHR(10), lcOut, 1)

    *-- Acrescenta duas linhas em branco e confere o descarte do btnSair
    SELECT cursor_4c_Produtos
    APPEND BLANK
    APPEND BLANK
    COUNT TO lnVisiveis
    STRTOFILE("[14] com 2 brancos visiveis=" + TRANSFORM(lnVisiveis) + ;
              " (esperado 5)" + CHR(13) + CHR(10), lcOut, 1)

    loForm.RemoverLinhasEmBranco()
    SELECT cursor_4c_Produtos
    COUNT TO lnVisiveis
    STRTOFILE("[15] pos-RemoverLinhasEmBranco visiveis=" + TRANSFORM(lnVisiveis) + ;
              " (esperado 3)" + CHR(13) + CHR(10), lcOut, 1)

    *-- Encerrar: reabilita o pai e fecha o dialogo
    loForm.BtnEncerrarClick()
    STRTOFILE("[16] pos-Encerrar PaiEnabled=" + TRANSFORM(loPai.Enabled) + ;
              " FormVARTYPE=" + VARTYPE(loForm) + ;
              " (esperado .T.)" + CHR(13) + CHR(10), lcOut, 1)
ELSE
    STRTOFILE("[5b] FALHA: CREATEOBJECT devolveu nao-objeto" + ;
              CHR(13) + CHR(10), lcOut, 1)
ENDIF

STRTOFILE("[FIM] probe concluido" + CHR(13) + CHR(10), lcOut, 1)
QUIT


*==============================================================================
* Stubs do form PAI (legado: poForm / ThisForm.ParentForm)
*==============================================================================
DEFINE CLASS StubFilSpr AS Custom
    MercsI    = ""
    MercsF    = ""
    CGrusI    = ""
    CGrusF    = ""
    SGrusI    = ""
    SGrusF    = ""
    ColecoesI = ""
    ColecoesF = ""
    LinhasI   = ""
    LinhasF   = ""
    IForsI    = ""
    IForsF    = ""
ENDDEFINE

DEFINE CLASS StubPaiSpr AS Form
    Name      = "SIGCDBAL"
    pcEscolha = "INSERIR"
    ADD OBJECT loFil AS StubFilSpr
ENDDEFINE
