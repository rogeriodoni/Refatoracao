*==============================================================================
* test_fase4b_carga_chr.prg - Fase 4 do FormSigPrChr: CARGA da grade
* Bootstrap MINIMO. Testa MontaGrade/ExibirCheques/CriarIndicesCheques e
* prova que o binding do Grid SOBREVIVE ao ZAP+APPEND (o motivo de nao
* reatribuir RecordSource).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON
SET EXACT ON

LOCAL lcLog, loForm, loErr, lcCls, lcUtl, loFake
lcLog = "C:\4c\tasks\task590\teste_fase4_carga.txt"
lcCls = "C:\4c\projeto\app\classes\"
lcUtl = "C:\4c\projeto\app\utils\"

STRTOFILE("=== TESTE FASE 4 - CARGA DA GRADE (FormSigPrChr) ===" + CHR(13) + CHR(10), lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle, gc_4c_ArquivoErroTeste
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gnConnHandle           = -1
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task590\erros_fase4_carga.txt"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gc_4c_UsuarioLogado    = "TESTE"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais")

SET PROCEDURE TO (lcUtl + "functions.prg") ADDITIVE
SET PROCEDURE TO (lcUtl + "messages.prg") ADDITIVE
SET PROCEDURE TO (lcUtl + "validators.prg") ADDITIVE
SET PROCEDURE TO (lcUtl + "isempty.prg") ADDITIVE
SET PROCEDURE TO (lcCls + "dataaccess.prg") ADDITIVE
SET PROCEDURE TO (lcCls + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (lcCls + "formbase.prg") ADDITIVE
SET PROCEDURE TO (lcCls + "FormErro.prg") ADDITIVE
SET PROCEDURE TO (lcCls + "SigPrChrBO.prg") ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg" ADDITIVE

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSigPrChr")
CATCH TO loErr
    STRTOFILE("CREATEOBJECT : EXCECAO - " + loErr.Message + " | Linha " + ;
        TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + CHR(13)+CHR(10), lcLog, 1)
ENDTRY

IF VARTYPE(loForm) # "O"
    STRTOFILE("ABORTADO: form nao instanciou" + CHR(13)+CHR(10), lcLog, 1)
    QUIT
ENDIF

STRTOFILE("CREATEOBJECT        : OK" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("cmd_4c_Processar    : " + TRANSFORM(PEMSTATUS(loForm,"cmd_4c_Processar",5)) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("MontaGrade          : " + TRANSFORM(PEMSTATUS(loForm,"MontaGrade",5)) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("ExibirCheques       : " + TRANSFORM(PEMSTATUS(loForm,"ExibirCheques",5)) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("BtnProcessarClick   : " + TRANSFORM(PEMSTATUS(loForm,"BtnProcessarClick",5)) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("BO.CarregarCheques  : " + TRANSFORM(PEMSTATUS(loForm.this_oBusinessObject,"CarregarCheques",5)) + CHR(13)+CHR(10), lcLog, 1)

*-- Estado do grid ANTES da carga (para comparar depois)
LOCAL lnW1, lcH1, lcCC10, llSp10, lnW10
lnW1   = loForm.grd_4c_Dados.Column1.Width
lcH1   = loForm.grd_4c_Dados.Column1.Header1.Caption
lcCC10 = UPPER(loForm.grd_4c_Dados.Column10.CurrentControl)
llSp10 = loForm.grd_4c_Dados.Column10.Sparse
lnW10  = loForm.grd_4c_Dados.Column10.Width

*-- 1) Sem conexao: MontaGrade deve devolver .F. SEM travar nem estourar
LOCAL llR1
TRY
    llR1 = loForm.MontaGrade(.F.)
    STRTOFILE("MontaGrade s/conexao: retorno=" + TRANSFORM(llR1) + ;
        " LockScreen=" + TRANSFORM(loForm.LockScreen) + CHR(13)+CHR(10), lcLog, 1)
CATCH TO loErr
    STRTOFILE("MontaGrade s/conexao: EXCECAO - " + loErr.Message + CHR(13)+CHR(10), lcLog, 1)
ENDTRY

*-- 2) Caminho de SUCESSO com BO duble: substitui SO a ida ao banco (a base
*--    192.168.200.10 nao tem rota desta maquina)
loFake = CREATEOBJECT("FakeChrBO")
loFake.this_dDataInicial = DATE() - 30
loFake.this_dDataFinal   = DATE()
loForm.this_oBusinessObject = loFake

LOCAL llR2
TRY
    llR2 = loForm.MontaGrade(.F.)
    STRTOFILE("MontaGrade sucesso  : retorno=" + TRANSFORM(llR2) + ;
        " RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Cheques")) + ;
        " LockScreen=" + TRANSFORM(loForm.LockScreen) + CHR(13)+CHR(10), lcLog, 1)
CATCH TO loErr
    STRTOFILE("MontaGrade sucesso  : EXCECAO - " + loErr.Message + " | Linha " + ;
        TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + CHR(13)+CHR(10), lcLog, 1)
ENDTRY

*-- 3) Indices: as 12 tags do legado, com os nomes exatos
SELECT cursor_4c_Cheques
LOCAL lcTags, lnI
lcTags = ""
FOR lnI = 1 TO TAGCOUNT()
    lcTags = lcTags + IIF(EMPTY(lcTags), "", ",") + TAG(lnI)
ENDFOR
STRTOFILE("TAGCOUNT            : " + TRANSFORM(TAGCOUNT()) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("TAGS                : " + lcTags + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("ORDER apos carga    : [" + ORDER("cursor_4c_Cheques") + "]" + CHR(13)+CHR(10), lcLog, 1)

*-- 4) O BINDING do grid sobreviveu ao ZAP+APPEND?
STRTOFILE("--- binding pos-carga (deve ser IDENTICO ao pre-carga) ---" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("Col1.Width   " + TRANSFORM(lnW1) + " -> " + TRANSFORM(loForm.grd_4c_Dados.Column1.Width) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("Col1.Header  [" + lcH1 + "] -> [" + loForm.grd_4c_Dados.Column1.Header1.Caption + "]" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("Col10.CurCtl [" + lcCC10 + "] -> [" + UPPER(loForm.grd_4c_Dados.Column10.CurrentControl) + "]" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("Col10.Sparse " + TRANSFORM(llSp10) + " -> " + TRANSFORM(loForm.grd_4c_Dados.Column10.Sparse) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("Col10.Width  " + TRANSFORM(lnW10) + " -> " + TRANSFORM(loForm.grd_4c_Dados.Column10.Width) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("RecordSource [" + loForm.grd_4c_Dados.RecordSource + "]" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("Col10.CtlSrc [" + loForm.grd_4c_Dados.Column10.ControlSource + "]" + CHR(13)+CHR(10), lcLog, 1)

*-- 5) ExibirCheques: desmarca Imprime e (llSeek) vai para EOF
SELECT cursor_4c_Cheques
GO TOP
REPLACE nmarca1s WITH 1
LOCAL lnMarcados
TRY
    loForm.ExibirCheques(.T.)
    SELECT cursor_4c_Cheques
    COUNT TO lnMarcados FOR nmarca1s = 1
    STRTOFILE("ExibirCheques(.T.)  : OK marcados=" + TRANSFORM(lnMarcados) + ;
        " EOF=" + TRANSFORM(EOF("cursor_4c_Cheques")) + ;
        " ORDER=[" + ORDER("cursor_4c_Cheques") + "]" + CHR(13)+CHR(10), lcLog, 1)
CATCH TO loErr
    STRTOFILE("ExibirCheques(.T.)  : EXCECAO - " + loErr.Message + " | Linha " + ;
        TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + CHR(13)+CHR(10), lcLog, 1)
ENDTRY

*-- 6) Reposicionamento: MontaGrade(.T.) usa chave posicional de 23 chars
SELECT cursor_4c_Cheques
GO TOP
SKIP
LOCAL lcChaveAntes
lcChaveAntes = cursor_4c_Cheques.bancos + cursor_4c_Cheques.agencias + ;
               cursor_4c_Cheques.ncontas + cursor_4c_Cheques.ncheques
TRY
    loForm.MontaGrade(.T.)
    STRTOFILE("MontaGrade(.T.)     : OK len(chave)=" + TRANSFORM(LEN(lcChaveAntes)) + ;
        " RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Cheques")) + CHR(13)+CHR(10), lcLog, 1)
CATCH TO loErr
    STRTOFILE("MontaGrade(.T.)     : EXCECAO - " + loErr.Message + CHR(13)+CHR(10), lcLog, 1)
ENDTRY

*-- 7) Filtro por conta: ExibirCheques usa a ordem Contas
loFake.this_cCodConta = "0000000222"
TRY
    loForm.ExibirCheques(.T.)
    STRTOFILE("ExibirCheques c/conta: OK ORDER=[" + ORDER("cursor_4c_Cheques") + "]" + CHR(13)+CHR(10), lcLog, 1)
CATCH TO loErr
    STRTOFILE("ExibirCheques c/conta: EXCECAO - " + loErr.Message + CHR(13)+CHR(10), lcLog, 1)
ENDTRY
loFake.this_cCodConta = ""

*-- 8) Periodo invertido: BtnProcessarClick avisa e NAO carrega
loFake.this_dDataInicial = DATE()
loFake.this_dDataFinal   = DATE() - 10
loFake.nChamadas = 0
TRY
    loForm.BtnProcessarClick()
    STRTOFILE("Periodo invertido   : OK (avisou, CarregarCheques chamado " + ;
        TRANSFORM(loFake.nChamadas) + "x - esperado 0)" + CHR(13)+CHR(10), lcLog, 1)
CATCH TO loErr
    STRTOFILE("Periodo invertido   : EXCECAO - " + loErr.Message + CHR(13)+CHR(10), lcLog, 1)
ENDTRY

*-- 9) Periodo valido: BtnProcessarClick carrega de verdade
loFake.this_dDataInicial = DATE() - 30
loFake.this_dDataFinal   = DATE()
loFake.nChamadas = 0
TRY
    loForm.BtnProcessarClick()
    STRTOFILE("Processar valido    : OK CarregarCheques=" + TRANSFORM(loFake.nChamadas) + ;
        "x RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Cheques")) + CHR(13)+CHR(10), lcLog, 1)
CATCH TO loErr
    STRTOFILE("Processar valido    : EXCECAO - " + loErr.Message + " | Linha " + ;
        TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + CHR(13)+CHR(10), lcLog, 1)
ENDTRY

loForm.Release()
STRTOFILE("--- ERROS CAPTURADOS ---" + CHR(13)+CHR(10), lcLog, 1)
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE(FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13)+CHR(10), lcLog, 1)
ELSE
    STRTOFILE("(nenhum)" + CHR(13)+CHR(10), lcLog, 1)
ENDIF
STRTOFILE("=== FIM ===" + CHR(13)+CHR(10), lcLog, 1)
QUIT

*------------------------------------------------------------------------------
* FakeChrBO - duble do BO: substitui SO a ida ao banco, mantendo todo o
* resto (properties, nome do cursor). Permite exercitar o caminho de SUCESSO
* de MontaGrade sem rota para o SQL Server.
*------------------------------------------------------------------------------
DEFINE CLASS FakeChrBO AS SigPrChrBO
    nChamadas = 0

    PROCEDURE CarregarCheques(par_cCursorDestino)
        THIS.nChamadas = THIS.nChamadas + 1
        IF USED(par_cCursorDestino)
            USE IN (par_cCursorDestino)
        ENDIF
        CREATE CURSOR (par_cCursorDestino) ;
            (emps C(3), dopes C(20), numes N(6,0), datas T, bancos C(3), ;
             agencias C(4), ncontas C(10), ncheques C(6), contas C(10), ;
             valors N(11,2), favos C(40), ncopias N(6,0), nemissoes N(2,0), ;
             cidchaves C(20), nemitidos N(1,0), ncancelas N(1,0), ;
             nmarca1s N(1,0), justcanc M)
        INSERT INTO (par_cCursorDestino) ;
            (emps, dopes, numes, datas, bancos, agencias, ncontas, ncheques, ;
             contas, valors, favos, ncopias, nemissoes, cidchaves, ;
             nemitidos, ncancelas, nmarca1s, justcanc) ;
            VALUES ("001", "MALOTE", 3, DATETIME(), "001", "1234", ;
             "0000000111", "000001", "0000000111", 150.25, "FORNECEDOR A", ;
             1, 1, "CID001", 0, 0, 0, "")
        INSERT INTO (par_cCursorDestino) ;
            (emps, dopes, numes, datas, bancos, agencias, ncontas, ncheques, ;
             contas, valors, favos, ncopias, nemissoes, cidchaves, ;
             nemitidos, ncancelas, nmarca1s, justcanc) ;
            VALUES ("001", "MALOTE", 4, DATETIME(), "002", "5678", ;
             "0000000222", "000002", "0000000222", 300.00, "FORNECEDOR B", ;
             2, 2, "CID002", 1, 1, 0, "cancelado por erro")
        RETURN .T.
    ENDPROC
ENDDEFINE
