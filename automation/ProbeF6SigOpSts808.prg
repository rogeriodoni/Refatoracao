* ProbeF6SigOpSts808.prg
* Fase 6 / task808 - prova, numa unica execucao, que:
*   (a) FormSigOpSts instancia COM e SEM form pai depois de a Column1
*       passar a receber TextBoxStatusSts_4c por Column.AddObject (o Init
*       de form grande falha em CADEIA - "a tela abre" so se prova
*       INSTANCIANDO);
*   (b) a celula esta REALMENTE instalada: Column1.CurrentControl =
*       "txt_4c_Status", Sparse = .F., classe do controle e MaxLength = 1
*       (regra #18/#19 - sem CurrentControl a coluna segue desenhando o
*       Text1 dela e o controle novo nunca aparece);
*   (c) os 5 metodos que a celula alcanca de FORA, via THISFORM a partir de
*       outra classe, sao PUBLIC (PEMSTATUS(...,2) = .F. - regra #3/#46/#51);
*   (d) VincularGrade REAPLICA CurrentControl/Sparse depois do rebind
*       (RecordSource/ControlSource resetam as duas - Problema 48/regra #41);
*   (e) o When do legado (Return( Empty( LocalStats.status ) )) funciona por
*       LINHA: linha com status em branco eh editavel, linha resolvida NAO,
*       e EOF NAO;
*   (f) o Valid nao faz nada com a celula VAZIA (o usuario atravessa a linha
*       em branco com Tab sem levar dialogo) e CHEGA ao funil do lookup com
*       valor digitado; a guarda de reentrancia corta a 2a entrada.
*
* SigStats/SIGOPSTS nao sao alcancaveis daqui (SQL 192.168.200.10 fora de
* alcance nesta maquina), entao a consulta real nao serve de prova: o probe
* injeta um BO de teste (StsBoFakeF6, subclasse de SigOpStsBO) que cria o
* cursor_4c_Status com DUAS linhas - mesma estrutura que o SELECT do BO
* produz - e delega o resto ao CarregarDoCursor REAL. Nada do form eh
* alterado: so a origem das linhas.
*
* No passo (f3) o picker eh alcancado de verdade e o CREATEOBJECT(
* "FormBuscaAuxiliar") estoura no SQLEXEC com handle invalido - isso eh
* ESPERADO e eh justamente a prova de que (1) o funil foi alcancado e (2) o
* CATCH do funil reporta a falha em vez de engoli-la (regra #9). Em
* gb_4c_ModoTeste o MsgErro vai para gc_4c_ArquivoErroTeste, impresso no fim.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cOut, loc_cRel, loc_oForm, loc_oPai, loc_oErro, loc_oCel
LOCAL loc_nI, loc_lRet, loc_lEd1, loc_lEd2, loc_lEdEof

loc_cOut = "C:\4c\automation\_f6sts_probe.txt"
loc_cRel = "CHECKPOINT 1 - vivo " + TTOC(DATETIME()) + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f6sts_erros.txt"
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "PROBE"

IF FILE(gc_4c_ArquivoErroTeste)
    ERASE (gc_4c_ArquivoErroTeste)
ENDIF

CD C:\4c\projeto\app\start
DO config.prg

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")        ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg")      ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "TextBoxGridLookup.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")         ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")        ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpStsBO.prg")        ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigOpSts.prg") ADDITIVE

loc_cRel = loc_cRel + "CHECKPOINT 2 - dependencias OK" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

*===========================================================================
* (a1) instancia SEM form pai (caminho do harness/ValidarUIFidelity)
*===========================================================================
loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSigOpSts")
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "EXCECAO (sem pai): " + loc_oErro.Message + " | Linha " + ;
        TRANSFORM(loc_oErro.LineNo) + " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY
loc_cRel = loc_cRel + "(a1) SEM form pai   VARTYPE(form) = [" + VARTYPE(loc_oForm) + ;
    "]  esperado [O]" + CHR(13) + CHR(10)
IF VARTYPE(loc_oForm) = "O"
    loc_oForm.Release()
    loc_oForm = .NULL.
ENDIF
STRTOFILE(loc_cRel, loc_cOut)

*===========================================================================
* (a2) instancia COM form pai, como o legado
*      (Do Form SigOpSts With ThisForm, ThisForm.DataSessionId, PcEscolha)
*===========================================================================
loc_oPai = CREATEOBJECT("Form")

loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSigOpSts", loc_oPai, "VENDA BALCAO", "INSERIR", 1)
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "EXCECAO (com pai): " + loc_oErro.Message + " | Linha " + ;
        TRANSFORM(loc_oErro.LineNo) + " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY
loc_cRel = loc_cRel + "(a2) COM form pai   VARTYPE(form) = [" + VARTYPE(loc_oForm) + "]" + ;
    "  Caption = [" + IIF(VARTYPE(loc_oForm) = "O", loc_oForm.Caption, "?") + "]" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

IF VARTYPE(loc_oForm) != "O"
    loc_cRel = loc_cRel + "ABORTADO - form nao instanciou" + CHR(13) + CHR(10)
    STRTOFILE(loc_cRel, loc_cOut)
    QUIT
ENDIF

*===========================================================================
* (b) a celula esta instalada na Column1 (regra #18/#19)
*===========================================================================
loc_cRel = loc_cRel + "(b) CELULA instalada na Column1" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    existe txt_4c_Status = " + ;
    IIF(PEMSTATUS(loc_oForm.grd_4c_Dados.Column1, "txt_4c_Status", 5), "SIM", "NAO") + ;
    "  (esperado SIM)" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    classe        = [" + loc_oForm.grd_4c_Dados.Column1.txt_4c_Status.Class + ;
    "]  esperado [TextBoxStatusSts_4c]" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    CurrentControl= [" + loc_oForm.grd_4c_Dados.Column1.CurrentControl + ;
    "]  esperado [txt_4c_Status]" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    Sparse        = " + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Sparse) + ;
    "  esperado .F." + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    MaxLength     = " + ;
    TRANSFORM(loc_oForm.grd_4c_Dados.Column1.txt_4c_Status.MaxLength) + ;
    "  esperado 1 (SigStats.cods char(1))" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    Col1.ReadOnly = " + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.ReadOnly) + ;
    "  Col2.ReadOnly = " + TRANSFORM(loc_oForm.grd_4c_Dados.Column2.ReadOnly) + ;
    "  esperado .F. / .T. (When=.F. do legado)" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

*===========================================================================
* (c) escopo dos metodos que a celula alcanca de FORA (regra #3/#46/#51)
*     PEMSTATUS(obj, "M", 2) = .T. significa PROTECTED -> estouraria
*===========================================================================
loc_cRel = loc_cRel + "(c) ESCOPO (protected=SIM reprova)" + CHR(13) + CHR(10)
LOCAL ARRAY loc_aMet[6]
loc_aMet[1] = "CelulaStatusEditavel"
loc_aMet[2] = "ValidarStatusGradeExec"
loc_aMet[3] = "AbrirLookupStatusSts"
loc_aMet[4] = "AbrirLookupStatusStsExec"
loc_aMet[5] = "StatusGradeLostFocus"
loc_aMet[6] = "CarregarDados"
FOR loc_nI = 1 TO 6
    loc_cRel = loc_cRel + "    " + PADR(loc_aMet[loc_nI], 26) + ;
        " existe=" + IIF(PEMSTATUS(loc_oForm, loc_aMet[loc_nI], 5), "SIM", "NAO") + ;
        " protected=" + IIF(PEMSTATUS(loc_oForm, loc_aMet[loc_nI], 5) AND ;
                            PEMSTATUS(loc_oForm, loc_aMet[loc_nI], 2), "SIM", "NAO") + ;
        CHR(13) + CHR(10)
ENDFOR
STRTOFILE(loc_cRel, loc_cOut)

*===========================================================================
* (d) CarregarDados -> VincularGrade com o BO de teste injetado: o rebind
*     NAO pode derrubar CurrentControl/Sparse
*===========================================================================
loc_oForm.this_oBusinessObject = CREATEOBJECT("StsBoFakeF6")
loc_lRet = loc_oForm.CarregarDados()

loc_cRel = loc_cRel + "(d) CarregarDados retorno = " + TRANSFORM(loc_lRet) + ;
    "  BO injetado = [" + loc_oForm.this_oBusinessObject.Class + "]" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    USED(cursor_4c_Status) = " + TRANSFORM(USED("cursor_4c_Status")) + ;
    "  RECCOUNT = " + TRANSFORM(IIF(USED("cursor_4c_Status"), RECCOUNT("cursor_4c_Status"), -1)) + ;
    "  esperado 2" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    RecordSource = [" + loc_oForm.grd_4c_Dados.RecordSource + "]" + ;
    "  ColumnCount = " + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    Col1.ControlSource = [" + loc_oForm.grd_4c_Dados.Column1.ControlSource + "]" + ;
    "  Header = [" + loc_oForm.grd_4c_Dados.Column1.Header1.Caption + "]" + ;
    "  Width = " + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Width) + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    Col2.ControlSource = [" + loc_oForm.grd_4c_Dados.Column2.ControlSource + "]" + ;
    "  Header = [" + loc_oForm.grd_4c_Dados.Column2.Header1.Caption + "]" + ;
    "  Width = " + TRANSFORM(loc_oForm.grd_4c_Dados.Column2.Width) + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    POS-REBIND CurrentControl = [" + ;
    loc_oForm.grd_4c_Dados.Column1.CurrentControl + "]  Sparse = " + ;
    TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Sparse) + ;
    "  (esperado [txt_4c_Status] / .F.)" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

*===========================================================================
* (e) When por LINHA - Return( Empty( LocalStats.status ) ) do legado
*===========================================================================
loc_oCel = loc_oForm.grd_4c_Dados.Column1.txt_4c_Status

loc_lEd1   = .NULL.
loc_lEd2   = .NULL.
loc_lEdEof = .NULL.

IF USED("cursor_4c_Status") AND RECCOUNT("cursor_4c_Status") = 2
    SELECT cursor_4c_Status
    GO TOP
    loc_lEd1 = loc_oForm.CelulaStatusEditavel(loc_oCel)
    SKIP
    loc_lEd2 = loc_oForm.CelulaStatusEditavel(loc_oCel)
    GO BOTTOM
    SKIP
    loc_lEdEof = loc_oForm.CelulaStatusEditavel(loc_oCel)
ENDIF

loc_cRel = loc_cRel + "(e) When por linha (CelulaStatusEditavel)" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    linha 1 status=[A]  editavel = " + TRANSFORM(loc_lEd1) + ;
    "  esperado .F." + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    linha 2 status=[ ]  editavel = " + TRANSFORM(loc_lEd2) + ;
    "  esperado .T." + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    EOF                 editavel = " + TRANSFORM(loc_lEdEof) + ;
    "  esperado .F." + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    CONFERE When = " + ;
    IIF(loc_lEd1 = .F. AND loc_lEd2 = .T. AND loc_lEdEof = .F., "SIM", "NAO") + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

*===========================================================================
* (f) Valid: celula VAZIA nao dispara nada; com valor CHEGA ao funil; e a
*     guarda de reentrancia corta a 2a entrada
*===========================================================================
loc_cRel = loc_cRel + "(f) Valid / funil do lookup" + CHR(13) + CHR(10)

SELECT cursor_4c_Status
GO TOP
SKIP

loc_oCel.Value = ""
loc_lRet = .NULL.
TRY
    loc_lRet = loc_oForm.ValidarStatusGradeExec(loc_oCel)
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "    EXCECAO (f1): " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY
loc_cRel = loc_cRel + "    (f1) celula VAZIA  Valid = " + TRANSFORM(loc_lRet) + ;
    "  arquivo de erro = " + IIF(FILE(gc_4c_ArquivoErroTeste), "GRAVOU", "VAZIO") + ;
    "  (esperado .T. / VAZIO - nenhum dialogo)" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

loc_oForm.this_lEmLookupStatus = .T.
loc_oCel.Value = "Z"
TRY
    loc_oForm.AbrirLookupStatusSts(loc_oCel)
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "    EXCECAO (f2): " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY
loc_cRel = loc_cRel + "    (f2) flag LIGADA   arquivo de erro = " + ;
    IIF(FILE(gc_4c_ArquivoErroTeste), "GRAVOU", "VAZIO") + ;
    "  valor da celula = [" + loc_oCel.Value + "]" + ;
    "  (esperado VAZIO / [Z] - picker NAO foi aberto)" + CHR(13) + CHR(10)
loc_oForm.this_lEmLookupStatus = .F.
STRTOFILE(loc_cRel, loc_cOut)

loc_oCel.Value = "Z"
loc_lRet = .NULL.
TRY
    loc_lRet = loc_oForm.ValidarStatusGradeExec(loc_oCel)
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "    EXCECAO (f3): " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY
loc_cRel = loc_cRel + "    (f3) celula [Z]    Valid = " + TRANSFORM(loc_lRet) + ;
    "  arquivo de erro = " + IIF(FILE(gc_4c_ArquivoErroTeste), "GRAVOU", "VAZIO") + ;
    "  (esperado .T. / GRAVOU - funil alcancado e falha REPORTADA)" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    flag solta depois do CATCH = " + ;
    TRANSFORM(loc_oForm.this_lEmLookupStatus) + "  esperado .F." + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    cursor_4c_Busca fechado = " + ;
    TRANSFORM(!USED("cursor_4c_Busca")) + "  esperado .T." + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

loc_oCel.Value = ""
TRY
    loc_oForm.StatusGradeLostFocus(loc_oCel)
    loc_cRel = loc_cRel + "    (f4) LostFocus vazio: sem excecao" + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "    (f4) LostFocus vazio EXCECAO: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(loc_cRel, loc_cOut)

*===========================================================================
* Dialogos suprimidos pelo modo teste (MsgErro/MsgAviso escrevem no arquivo)
*===========================================================================
loc_cRel = loc_cRel + "--- ARQUIVO DE ERRO DE TESTE" + CHR(13) + CHR(10)
IF FILE(gc_4c_ArquivoErroTeste)
    loc_cRel = loc_cRel + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ELSE
    loc_cRel = loc_cRel + "  (vazio - nenhum MsgErro/MsgAviso disparado)" + CHR(13) + CHR(10)
ENDIF

loc_cRel = loc_cRel + "FIM" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

QUIT


*===========================================================================
* StsBoFakeF6 - BO de teste: substitui SO a origem das linhas (o SQL Server
* esta fora de alcance nesta maquina) e delega o resto ao SigOpStsBO real.
* O cursor eh criado com as MESMAS colunas que o SELECT de
* ListarStatusOperacao produz (cidchaves/dopes/status/descs) e READWRITE,
* igual ao do BO real.
*   linha 1 -> status "A" (resolvida: o When tem de recusar edicao)
*   linha 2 -> status em branco (nova: o When tem de liberar)
*===========================================================================
DEFINE CLASS StsBoFakeF6 AS SigOpStsBO

    FUNCTION ListarStatusOperacao(par_cOperacaoPai)
        IF USED("cursor_4c_Status")
            USE IN cursor_4c_Status
        ENDIF

        CREATE CURSOR cursor_4c_Status ( ;
            cidchaves C(20), dopes C(20), status C(1), descs C(20))

        INSERT INTO cursor_4c_Status (cidchaves, dopes, status, descs) ;
            VALUES ("CHAVE0000000000000001", "VENDA BALCAO", "A", "ABERTO")

        INSERT INTO cursor_4c_Status (cidchaves, dopes, status, descs) ;
            VALUES ("CHAVE0000000000000002", "VENDA BALCAO", "", "")

        THIS.CarregarDoCursor("cursor_4c_Status")

        RETURN .T.
    ENDFUNC

ENDDEFINE
