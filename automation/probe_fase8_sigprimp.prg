*==============================================================================
* probe_fase8_sigprimp.prg - Fase 8 de FormSIGPRIMP (task629)
* Recompila Form + BO (apagando .FXP/.ERR antes, senao roda codigo velho),
* instancia em MODO TESTE e exercita o que a Fase 8 entrega:
*   - CarregarLista()        funil unico + guard de ambiente
*   - BOParaForm()           BO.this_cDirImport -> txt_4c_Arquivo
*   - FormParaBO(arquivo)    txt -> BO.this_cDirImport / this_cArquivo
*   - RemoverArquivoDaLista  remocao por NOME (ListBox Sorted = .T.)
*   - escopo PUBLIC dos metodos chamados de fora (harness) - regra #3/#51
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

ON ERROR DO TrataErroProbe WITH MESSAGE(), PROGRAM(), LINENO()

LOCAL loc_cOut, loc_cForm, loc_cBO, loc_cFxpF, loc_cFxpB, loc_cErrF, loc_cErrB
LOCAL loc_oForm, loc_oErro, loc_cLog, loc_cDirTmp, loc_cArqTmp, loc_cDirVaz

loc_cOut  = "C:\4c\automation\probe_fase8_sigprimp_result.txt"
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SIGPRIMPBO.prg"
loc_cFxpF = "C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.fxp"
loc_cFxpB = "C:\4c\projeto\app\classes\SIGPRIMPBO.fxp"
loc_cErrF = "C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.err"
loc_cErrB = "C:\4c\projeto\app\classes\SIGPRIMPBO.err"
loc_cLog  = "=== PROBE FASE 8 - FormSIGPRIMP ===" + CHR(13) + CHR(10)

IF FILE(loc_cFxpF)
    DELETE FILE (loc_cFxpF)
ENDIF
IF FILE(loc_cFxpB)
    DELETE FILE (loc_cFxpB)
ENDIF
IF FILE(loc_cErrF)
    DELETE FILE (loc_cErrF)
ENDIF
IF FILE(loc_cErrB)
    DELETE FILE (loc_cErrB)
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cLog = loc_cLog + "FXP BO   : " + IIF(FILE(loc_cFxpB), "OK", "AUSENTE") + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "FXP Form : " + IIF(FILE(loc_cFxpF), "OK", "AUSENTE") + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "ERR BO   : " + IIF(FILE(loc_cErrB), FILETOSTR(loc_cErrB), "nenhum") + CHR(13) + CHR(10)
loc_cLog = loc_cLog + "ERR Form : " + IIF(FILE(loc_cErrF), FILETOSTR(loc_cErrF), "nenhum") + CHR(13) + CHR(10)

PUBLIC gnConnHandle, gc_4c_UsuarioLogado, gc_4c_CaminhoIcones, gc_4c_CaminhoReports
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, go_4c_Sistema
gnConnHandle           = -1
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_fase8_sigprimp_dialogs.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

SET PATH TO ("C:\4c\projeto\app\utils,C:\4c\projeto\app\classes,C:\4c\projeto\app\forms\operacionais")
SET PROCEDURE TO ("C:\4c\projeto\app\utils\functions.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\utils\messages.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\utils\validators.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\dataaccess.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\formbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\gridbase.prg") ADDITIVE
SET PROCEDURE TO (loc_cBO) ADDITIVE
SET PROCEDURE TO (loc_cForm) ADDITIVE

loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("ProbeSIGPRIMP")
CATCH TO loc_oErro
    loc_cLog = loc_cLog + "EXCECAO  : " + loc_oErro.Message + " | LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " | PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cLog, loc_cOut)
loc_cLog = loc_cLog + "VARTYPE  : " + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

IF VARTYPE(loc_oForm) = "O"
    loc_cLog = loc_cLog + CHR(13) + CHR(10) + ;
        "--- escopo (protected .F. = PUBLIC). FormParaBO/BOParaForm sao PROTECTED" + ;
        " por heranca de FormBase - esperado .T. ---" + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "CarregarLista         existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 2)) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "FormParaBO            existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2)) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "BOParaForm            existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2)) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "RemoverArquivoDaLista existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "RemoverArquivoDaLista", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "RemoverArquivoDaLista", 2)) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "AlternarPagina        existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "AlternarPagina", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "AlternarPagina", 2)) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "BtnMovEstClick        existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnMovEstClick", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnMovEstClick", 2)) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "BtnCancelarClick      existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnCancelarClick", 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnCancelarClick", 2)) + CHR(13) + CHR(10)

    STRTOFILE(loc_cLog, loc_cOut)
    loc_cLog = loc_cLog + CHR(13) + CHR(10) + "--- CarregarLista() com gb_4c_ModoTeste = .T. ---" + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "retorno=" + TRANSFORM(loc_oForm.CarregarLista()) + ;
        " (esperado .F. - sem conexao SQL) Enabled=" + ;
        TRANSFORM(loc_oForm.cmd_4c_BtnMovEst.Enabled) + CHR(13) + CHR(10)

    STRTOFILE(loc_cLog, loc_cOut)
    loc_cLog = loc_cLog + CHR(13) + CHR(10) + "--- BOParaForm() : BO -> campo ---" + CHR(13) + CHR(10)
    loc_oForm.this_oBusinessObject.this_cDirImport = "C:\4c\tasks\task629\"
    loc_cLog = loc_cLog + "BO cheio : retorno=" + TRANSFORM(loc_oForm.ProbeBOParaForm()) + ;
        " txt=[" + ALLTRIM(loc_oForm.txt_4c_Arquivo.Value) + "]" + ;
        " Enabled=" + TRANSFORM(loc_oForm.cmd_4c_BtnMovEst.Enabled) + ;
        " (esperado .T./.T.)" + CHR(13) + CHR(10)

    loc_oForm.this_oBusinessObject.this_cDirImport = ""
    loc_cLog = loc_cLog + "BO vazio : retorno=" + TRANSFORM(loc_oForm.ProbeBOParaForm()) + ;
        " txt=[" + ALLTRIM(loc_oForm.txt_4c_Arquivo.Value) + "]" + ;
        " Enabled=" + TRANSFORM(loc_oForm.cmd_4c_BtnMovEst.Enabled) + ;
        " (esperado Enabled .F. - When do legado)" + CHR(13) + CHR(10)

    STRTOFILE(loc_cLog, loc_cOut)
    loc_cLog = loc_cLog + CHR(13) + CHR(10) + "--- FormParaBO() : campo -> BO ---" + CHR(13) + CHR(10)
    loc_cDirTmp = ADDBS(SYS(2023)) + "pf8sigprimp\"
    IF !DIRECTORY(loc_cDirTmp)
        MKDIR (loc_cDirTmp)
    ENDIF
    loc_cArqTmp = loc_cDirTmp + "MOV001.TXT"
    STRTOFILE("MVITN|001|TESTE", loc_cArqTmp)

    loc_oForm.txt_4c_Arquivo.Value = loc_cDirTmp
    loc_oForm.this_oBusinessObject.this_cArquivo = "SENTINELA.TXT"
    loc_cLog = loc_cLog + "sem arg         : retorno=" + TRANSFORM(loc_oForm.ProbeFormParaBO()) + ;
        " BO.DirImport=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cDirImport) + "]" + ;
        " BO.Arquivo=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cArquivo) + "]" + ;
        " (esperado SENTINELA.TXT INTACTO - FormBase.Salvar chama sem arg)" + CHR(13) + CHR(10)

    loc_cLog = loc_cLog + "arquivo EXISTE  : retorno=" + TRANSFORM(loc_oForm.ProbeFormParaBO(loc_cArqTmp)) + ;
        " BO.Arquivo=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cArquivo) + "]" + ;
        " (esperado .T.)" + CHR(13) + CHR(10)

    loc_cLog = loc_cLog + "arquivo AUSENTE : retorno=" + ;
        TRANSFORM(loc_oForm.ProbeFormParaBO(loc_cDirTmp + "NAOEXISTE.TXT")) + ;
        " (esperado .F. - BtnMovEstClick faz LOOP e nao chama o BO)" + CHR(13) + CHR(10)

    loc_cLog = loc_cLog + CHR(13) + CHR(10) + ;
        "--- RemoverArquivoDaLista() com Sorted = " + ;
        TRANSFORM(loc_oForm.obj_4c_Arquivos.Sorted) + " ---" + CHR(13) + CHR(10)
    loc_oForm.obj_4c_Arquivos.Clear()
    loc_oForm.obj_4c_Arquivos.AddItem("ZEBRA.TXT")
    loc_oForm.obj_4c_Arquivos.AddItem("MOV001.TXT")
    loc_oForm.obj_4c_Arquivos.AddItem("ALFA.TXT")
    loc_cLog = loc_cLog + "ordem do ADir   : 1=ZEBRA.TXT 2=MOV001.TXT 3=ALFA.TXT" + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "ordem EXIBIDA   : 1=" + ALLTRIM(loc_oForm.obj_4c_Arquivos.List(1)) + ;
        " 2=" + ALLTRIM(loc_oForm.obj_4c_Arquivos.List(2)) + ;
        " 3=" + ALLTRIM(loc_oForm.obj_4c_Arquivos.List(3)) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "RemoveItem(1) do legado tiraria [" + ;
        ALLTRIM(loc_oForm.obj_4c_Arquivos.List(1)) + "], mas o ADir processou ZEBRA.TXT" + ;
        CHR(13) + CHR(10)

    loc_cLog = loc_cLog + "remover ZEBRA.TXT por NOME: retorno=" + ;
        TRANSFORM(loc_oForm.RemoverArquivoDaLista("ZEBRA.TXT")) + ;
        " ListCount=" + TRANSFORM(loc_oForm.obj_4c_Arquivos.ListCount)
    IF loc_oForm.obj_4c_Arquivos.ListCount >= 1
        loc_cLog = loc_cLog + " 1=" + ALLTRIM(loc_oForm.obj_4c_Arquivos.List(1))
    ENDIF
    IF loc_oForm.obj_4c_Arquivos.ListCount >= 2
        loc_cLog = loc_cLog + " 2=" + ALLTRIM(loc_oForm.obj_4c_Arquivos.List(2))
    ENDIF
    loc_cLog = loc_cLog + CHR(13) + CHR(10)

    loc_cLog = loc_cLog + "nome inexistente: retorno=" + ;
        TRANSFORM(loc_oForm.RemoverArquivoDaLista("NAOESTA.TXT")) + ;
        " ListCount=" + TRANSFORM(loc_oForm.obj_4c_Arquivos.ListCount) + CHR(13) + CHR(10)

    STRTOFILE(loc_cLog, loc_cOut)
    loc_cLog = loc_cLog + CHR(13) + CHR(10) + "--- BtnMovEstClick() com campo vazio ---" + CHR(13) + CHR(10)
    loc_oForm.txt_4c_Arquivo.Value = ""
    loc_oForm.AtualizarEstadoBotoes()
    loc_oForm.BtnMovEstClick()
    loc_cLog = loc_cLog + "saiu sem erro; Enabled=" + ;
        TRANSFORM(loc_oForm.cmd_4c_BtnMovEst.Enabled) + CHR(13) + CHR(10)

    loc_cDirVaz = loc_cDirTmp + "vazio\"
    IF !DIRECTORY(loc_cDirVaz)
        MKDIR (loc_cDirVaz)
    ENDIF
    loc_oForm.txt_4c_Arquivo.Value = loc_cDirVaz
    loc_oForm.AtualizarEstadoBotoes()
    loc_oForm.BtnMovEstClick()
    loc_cLog = loc_cLog + "dir sem .TXT: saiu sem erro (MsgInfo do legado)" + CHR(13) + CHR(10)

    IF FILE(loc_cArqTmp)
        DELETE FILE (loc_cArqTmp)
    ENDIF

    loc_oForm.Release()
    loc_oForm = .NULL.
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE(loc_cLog, loc_cOut)
    loc_cLog = loc_cLog + CHR(13) + CHR(10) + "--- dialogs suprimidos ---" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ELSE
    STRTOFILE(loc_cLog, loc_cOut)
    loc_cLog = loc_cLog + CHR(13) + CHR(10) + "--- dialogs suprimidos: nenhum ---" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cLog, loc_cOut)
QUIT

*==============================================================================
* ProbeSIGPRIMP - subclasse SO do harness. FormParaBO/BOParaForm sao PROTECTED
* por heranca de FormBase (o VFP9 nao deixa a subclasse alargar o escopo), logo
* o script NAO pode chama-los direto: tem de ser de DENTRO da classe.
*==============================================================================
DEFINE CLASS ProbeSIGPRIMP AS FormSIGPRIMP

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

    PROCEDURE ProbeFormParaBO(par_cArquivo)
        IF VARTYPE(par_cArquivo) = "C"
            RETURN THIS.FormParaBO(par_cArquivo)
        ENDIF
        RETURN THIS.FormParaBO()
    ENDPROC

ENDDEFINE
