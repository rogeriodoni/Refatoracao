# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LLOK, DOPES, CEMPS, ICLIS, CPROS, CODS, LNPRC, EMPDOPNUMS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
Select crImpMvCab
Append From &lcArq delimited with character '|'
lcQuery = [Select Dopes, NDopes, Numeras, vCompensas, GrVends, Cmoes From SigCdOpe Where Dopes = '] + crImpMvCab.Dopes + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdOpe') < 1)
	lcQuery = [Select cEmps From SigCdEmp Where cEmps = '] + crImpMvCab.Emps + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdEmp') < 1)
	lcQuery = [Select Rclis From SigCdCli Where Iclis = '] + crImpMvCab.CONORIGS + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCli') < 1)
	lcQuery = [Select Rclis From SigCdCli Where Iclis = '] + crImpMvCab.CONDESTS + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCli') < 1)
	lcQuery = [Select Rclis From SigCdCli Where Iclis = '] + crImpMvCab.VENDS + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCli') < 1)
	Select crSigMvCab
	Select crSigMvItn
	Select crSigMvIts
	Select crSigMvMov
	Select crImpMvCab
	Insert Into crSigMvCab ( Emps, Dopes, Numes, Usuars, Datars, Datas, Transps, Mascnum, Tabds, LPrecos, CidChaves, ;
		If !Seek(lcMoeOpe, "TmpTotal" )
			Insert Into TmpTotal (Moeds, Moevals) Values (lcMoeOpe, lnCotMov)
	Select crImpMvCab
		lcQuery = [Select Dpros From SigCdPro Where Cpros = '] + crImpMvCab.Cpros + [']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPro') < 1)
		Select crImpMvCab	
			If !Seek(m.Moedas, "TmpTotal" )
				Insert Into TmpTotal (Moeds, Moevals) Values (m.Moedas, m.MoeVals)
		Insert Into crSigMvItn From Memvar
				lcQuery = [Select Cods From SigCdCor Where Cods = '] + crImpMvCab.CodCors + [']
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCor') < 1)
				lcQuery = [Select Cods From SigCdTam Where Cods = '] + crImpMvCab.CodTams + [']
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdTam') < 1)
			Insert Into crSigMvIts From Memvar
		Select TmpTotal
				Insert Into crSigMvMov ( Emps, Dopes, Numes, Moeds, ValTots, ValItens, ValDifs, ;
If llOk And !ThisForm.poDataMgr.Update('crSigMvCab')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update crSigMvCab)')
If llOk And !ThisForm.poDataMgr.UpDate('crSigMvItn')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update crSigMvItn)')
If llOk And !ThisForm.poDataMgr.UpDate('crSigMvIts')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update crSigMvIts)')
If llOk And !ThisForm.poDataMgr.UpDate('crSigMvMov')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update crSigMvMov)')
Select crSigMvCab
Select crSigMvItn
Select crSigMvIts
Select crSigMvMov
	lcQuery = [Select MoedaPs, MascNums, DirImports From SigCdPam]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPam') < 1)
				Delete File &lcArq.

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.prg) - TRECHOS RELEVANTES PARA PASS SQL (793 linhas total):

*-- Linhas 293 a 311:
293:             .BorderColor   = RGB(100, 100, 100)
294:             .SpecialEffect = 0
295:             .Sorted        = .T.
296:             .MultiSelect   = .F.
297:         ENDWITH
298: 
299:         *-- Shape1 (decorativo: canto superior direito - equivalente ao Shape1 do legado)
300:         THIS.AddObject("shp_4c_Shape1", "Shape")
301:         WITH THIS.shp_4c_Shape1
302:             .Top         = -12
303:             .Left        = 773
304:             .Height      = 110
305:             .Width       = 229
306:             .BackStyle   = 0
307:             .BorderStyle = 0
308:             .BorderColor = RGB(136, 189, 188)
309:         ENDWITH
310: 
311:         *-- Shape2 (decorativo: area superior esquerda - equivalente ao Shape2 do legado)

*-- Linhas 407 a 453:
407:             THIS.cmd_4c_Cancela.Enabled   = .F.
408:             THIS.Refresh()
409: 
410:             SELECT cursor_4c_Arquivos
411:             GO TOP
412:             SCAN
413:                 loc_cArquivo     = ALLTRIM(cursor_4c_Arquivos.cArquivo)
414:                 loc_cArquivoFull = loc_cDirImports + loc_cArquivo
415: 
416:                 *-- Atualizar display do arquivo em processamento
417:                 IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
418:                     THIS.txt_4c_Arquivo.Value = loc_cArquivoFull
419:                     THIS.txt_4c_Arquivo.Refresh()
420:                 ENDIF
421: 
422:                 *-- Processar via BO
423:                 IF THIS.this_oBusinessObject.ProcessarArquivo(loc_cArquivoFull)
424:                     loc_nProcessados = loc_nProcessados + 1
425:                     *-- Mover arquivo processado para OK\
426:                     IF FILE(loc_cArquivoFull)
427:                         SET SAFETY OFF
428:                         COPY FILE (loc_cArquivoFull) TO (loc_cDirOk + loc_cArquivo)
429:                         IF FILE(loc_cDirOk + loc_cArquivo)
430:                             DELETE FILE (loc_cArquivoFull)
431:                         ENDIF
432:                         SET SAFETY ON
433:                     ENDIF
434:                 ELSE
435:                     loc_nErros = loc_nErros + 1
436:                 ENDIF
437: 
438:                 SELECT cursor_4c_Arquivos
439:             ENDSCAN
440: 
441:         CATCH TO loc_oErro
442:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
443:                     " PROC=" + loc_oErro.Procedure, "Erro BtnMovEstClick")
444:         ENDTRY
445: 
446:         *-- Reabilitar botoes
447:         IF PEMSTATUS(THIS, "cmd_4c_BtnMovEst", 5)
448:             THIS.cmd_4c_BtnMovEst.Enabled = .T.
449:         ENDIF
450:         IF PEMSTATUS(THIS, "cmd_4c_Cancela", 5)
451:             THIS.cmd_4c_Cancela.Enabled = .T.
452:         ENDIF
453: 

*-- Linhas 578 a 596:
578:         ENDIF
579:         TRY
580:             SET SAFETY OFF
581:             DELETE FILE (loc_cArquivo)
582:             SET SAFETY ON
583:             IF FILE(loc_cArquivo)
584:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o arquivo.", ;
585:                         "Excluir arquivo")
586:             ELSE
587:                 MsgInfo("Arquivo exclu" + CHR(237) + "do com sucesso.", ;
588:                         "Excluir arquivo")
589:                 THIS.txt_4c_Arquivo.Value = ;
590:                     ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)
591:                 THIS.CarregarArquivos()
592:                 THIS.Refresh()
593:             ENDIF
594:         CATCH TO loc_oErro
595:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
596:                     "Erro ao excluir arquivo")


### BO (C:\4c\projeto\app\classes\SIGPRIMPBO.prg):
*==============================================================================
* SIGPRIMPBO.prg - Business Object para Importacao de Movimentacao de Estoque
* Herda de: BusinessBase
* Tabela principal: SigMvCab (cabecalho da movimentacao)
*==============================================================================
DEFINE CLASS SIGPRIMPBO AS BusinessBase

    *-- Configuracao (SigCdPam)
    this_cDirImports    = ""   && Diretorio de importacao dos arquivos TXT
    this_cMoedaPs       = ""   && Moeda padrao do sistema
    this_cMascNums      = ""   && Mascara de numeracao

    *-- Controle de processamento
    this_cArquivoAtual  = ""   && Caminho completo do arquivo TXT em processamento
    this_lResultadoOk   = .F.  && Resultado do ultimo processamento
    this_cMensagemErro  = ""   && Mensagem de erro do ultimo processamento

    *============================================================================
    PROCEDURE Init()
    *============================================================================
        THIS.this_cTabela       = "SigMvCab"
        THIS.this_cCampoChave   = "CidChaves"
        RETURN DODEFAULT()
    ENDPROC

    *============================================================================
    PROCEDURE ObterChavePrimaria()
    *============================================================================
        RETURN THIS.this_cArquivoAtual
    ENDPROC

    *============================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *  Nao aplicavel para este BO operacional
    *============================================================================
        RETURN .F.
    ENDPROC

    *============================================================================
    PROCEDURE CarregarParametros()
    *  Carrega parametros de SigCdPam: DirImports, MoedaPs, MascNums
    *============================================================================
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT MoedaPs, MascNums, DirImports FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PamImp") > 0
                IF !EOF("cursor_4c_PamImp")
                    SELECT cursor_4c_PamImp
                    THIS.this_cMoedaPs    = ALLTRIM(NVL(MoedaPs, ""))
                    THIS.this_cMascNums   = ALLTRIM(NVL(MascNums, ""))
                    THIS.this_cDirImports = ALLTRIM(NVL(DirImports, ""))
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Par" + CHR(226) + "metros do sistema (SigCdPam) n" + ;
                            CHR(227) + "o encontrados.", "Erro")
                ENDIF
            ELSE
                MsgErro("Falha ao consultar SigCdPam.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarParametros")
        ENDTRY
        IF USED("cursor_4c_PamImp")
            USE IN cursor_4c_PamImp
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *============================================================================
    PROCEDURE BuscarArquivos()
    *  Lista arquivos TXT em DirImports e popula cursor_4c_Arquivos
    *============================================================================
        LOCAL loc_lSucesso, loc_nArq, loc_nI, loc_cArq, loc_oErro
        LOCAL loc_aArqs(1,5)
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cDirImports)
                MsgAviso("Diret" + CHR(243) + "rio de importa" + CHR(231) + CHR(227) + ;
                         "o n" + CHR(227) + "o configurado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_Arquivos")
                USE IN cursor_4c_Arquivos
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Arquivos (cArquivo C(254) NULL)
            SET NULL OFF
            loc_nArq = ADIR(loc_aArqs, ALLTRIM(THIS.this_cDirImports) + "*.TXT")
            IF loc_nArq > 0
                FOR loc_nI = 1 TO loc_nArq
                    loc_cArq = ALLTRIM(loc_aArqs(loc_nI, 1))
                    INSERT INTO cursor_4c_Arquivos (cArquivo) VALUES (m.loc_cArq)
                ENDFOR
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BuscarArquivos")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *============================================================================
    PROCEDURE ProcessarArquivo(par_cArquivo)
    *  Processa um arquivo TXT pipe-delimitado de movimentacao de estoque.
    *  Insere registros em SigMvCab, SigMvItn, SigMvIts e SigMvMov.
    *  Retorna .T. se importado com sucesso, .F. caso contrario.
    *============================================================================
        LOCAL loc_lSucesso, loc_lOk, loc_cMsg, loc_oErro
        loc_lSucesso = .F.
        loc_lOk      = .T.
        loc_cMsg     = ""
        THIS.this_cArquivoAtual = par_cArquivo
        THIS.this_lResultadoOk  = .F.
        THIS.this_cMensagemErro = ""

        TRY
            *-- Validar caminho sem espacos
            IF AT(" ", par_cArquivo) > 0
                MsgAviso("Arquivo '" + par_cArquivo + "' Inv" + CHR(225) + "lido! " + ;
                         "O caminho n" + CHR(227) + "o pode conter espa" + CHR(231) + "os.", ;
                         "Sele" + CHR(231) + CHR(227) + "o de Arquivo")
                THIS.this_cMensagemErro = "Caminho com espa" + CHR(231) + "os"
                loc_lSucesso = .F.
            ENDIF

            *-- Criar cursor que recebe o arquivo TXT (57 campos pipe-delimitados)
            SET NULL ON
            CREATE CURSOR crImpMvCab (;
                TPREGS C(5), EMPS C(3), DOPES C(20), OPERS C(1), CITENS C(4), ;
                CODBARRAS C(14), CPROS C(14), DPROS C(40), OBS C(250), MOEDAS C(3), ;
                MOEVS C(3), MOEVALS N(15,6), QTDS N(15,3), CUNIS C(3), PESOS N(15,3), ;
                CUNIPS C(3), FATORS N(15,3), UNITS N(15,6), TOTAS N(15,2), VALDESCS N(15,2), ;
                VALBASES N(15,2), SITRIBS C(2), TPIPIS C(1), BCIPIS N(15,2), ;
                BASEIPI2S N(15,2), BASEIPI3S N(15,2), ALIQS N(15,2), VALIPIS N(15,2), ;
                SITTRICMS C(3), BASEICMS N(15,2), BASEICM2S N(15,2), BASEICM3S N(15,2), ;
                ALIQICMS N(15,2), ICMS N(15,2), CFOPS C(10), BCICMSS N(15,2), ;
                ICMSS N(15,2), ALIQPIS N(15,2), VPIS N(15,2), ALIQCOFS N(15,2), ;
                VCOFINS N(15,2), ISS N(15,2), IRRF N(15,2), INSS N(15,2), CSSL N(15,2), ;
                ALIQIIS N(15,2), TAXAIIS N(15,2), NADIS N(3), NIADIS N(3), CODFABS C(60), ;
                ORIGMERCS C(1), GRUORIGS C(10), CONORIGS C(10), GRUDESTS C(10), ;
                CONDESTS C(10), DATAS D, VENDS C(10), CODCORS C(4), CODTAMS C(4), OBSES C(250))
            SET NULL OFF

            *-- Importar linhas do arquivo delimitadas por '|'
            SELECT crImpMvCab
            LOCAL loc_cArqMacro
            loc_cArqMacro = par_cArquivo
            APPEND FROM &loc_cArqMacro. DELIMITED WITH CHARACTER '|'
            GO TOP

            *-- Validar formato do arquivo
            IF EOF("crImpMvCab") OR crImpMvCab.TPREGS # "MVITN"
                MsgAviso("Arquivo '" + par_cArquivo + "' inv" + CHR(225) + ;
                         "lido para importa" + CHR(231) + CHR(227) + "o.", ;
                         "Importa" + CHR(231) + CHR(227) + "o cancelada")
                IF USED("crImpMvCab")
                    USE IN crImpMvCab
                ENDIF
                THIS.this_cMensagemErro = "Formato inv" + CHR(225) + "lido"
                loc_lSucesso = .F.
            ENDIF

            *-- Capturar dados de cabecalho da primeira linha
            LOCAL loc_cDopes, loc_cEmps, loc_dDatasArq, loc_cSQL
            loc_cDopes    = ALLTRIM(crImpMvCab.DOPES)
            loc_cEmps     = ALLTRIM(crImpMvCab.EMPS)
            loc_dDatasArq = crImpMvCab.DATAS

            *-- Validar operacao em SigCdOpe
            loc_cSQL = "SELECT Dopes, NDopes, Numeras, vCompensas, GrVends, Cmoes " + ;
                       "FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeImp") < 1
                MsgErro("Falha na conex" + CHR(227) + "o ao consultar SigCdOpe.", "Erro")
                loc_lOk = .F.
            ENDIF
            IF loc_lOk AND EOF("cursor_4c_OpeImp")
                loc_cMsg = "Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o configurada no sistema."
                loc_lOk  = .F.
            ENDIF

            LOCAL loc_nNumeras, loc_nVComp, loc_cGrVends, loc_cCmoes
            loc_nNumeras = 0
            loc_nVComp   = 0
            loc_cGrVends = ""
            loc_cCmoes   = ""
            IF loc_lOk
                SELECT cursor_4c_OpeImp
                loc_nNumeras = NVL(Numeras, 0)
                loc_nVComp   = NVL(vCompensas, 0)
                loc_cGrVends = ALLTRIM(NVL(GrVends, ""))
                loc_cCmoes   = ALLTRIM(NVL(Cmoes, ""))
            ENDIF
            IF USED("cursor_4c_OpeImp")
                USE IN cursor_4c_OpeImp
            ENDIF

            *-- Validar empresa
            IF loc_lOk
                loc_cSQL = "SELECT Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmps)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpImp") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o ao consultar SigCdEmp.", "Erro")
                    loc_lOk = .F.
                ENDIF
                IF loc_lOk AND EOF("cursor_4c_EmpImp")
                    loc_cMsg = "Empresa n" + CHR(227) + "o cadastrada."
                    loc_lOk  = .F.
                ENDIF
                IF USED("cursor_4c_EmpImp")
                    USE IN cursor_4c_EmpImp
                ENDIF
            ENDIF

            *-- Validar conta de origem
            IF loc_lOk
                SELECT crImpMvCab
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.CONORIGS))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliImp") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdCli - origem).", "Erro")
                    loc_lOk = .F.
                ENDIF
                IF loc_lOk AND EOF("cursor_4c_CliImp")
                    loc_cMsg = "Conta de origem n" + CHR(227) + "o cadastrada."
                    loc_lOk  = .F.
                ENDIF
                IF USED("cursor_4c_CliImp")
                    USE IN cursor_4c_CliImp
                ENDIF
            ENDIF

            *-- Validar conta de destino
            IF loc_lOk
                SELECT crImpMvCab
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.CONDESTS))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliImp") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdCli - destino).", "Erro")
                    loc_lOk = .F.
                ENDIF
                IF loc_lOk AND EOF("cursor_4c_CliImp")
                    loc_cMsg = "Conta de destino n" + CHR(227) + "o cadastrada."
                    loc_lOk  = .F.
                ENDIF
                IF USED("cursor_4c_CliImp")
                    USE IN cursor_4c_CliImp
                ENDIF
            ENDIF

            *-- Validar vendedor
            IF loc_lOk
                SELECT crImpMvCab
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.VENDS))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliImp") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdCli - vendedor).", "Erro")
                    loc_lOk = .F.
                ENDIF
                IF loc_lOk AND EOF("cursor_4c_CliImp")
                    loc_cMsg = "Conta de vendedor n" + CHR(227) + "o cadastrada."
                    loc_lOk  = .F.
                ENDIF
                IF USED("cursor_4c_CliImp")
                    USE IN cursor_4c_CliImp
                ENDIF
            ENDIF

            *-- Processar importacao quando todas as validacoes passarem
            IF loc_lOk
                *-- Cursor de totais por moeda (para SigMvMov)
                CREATE CURSOR TmpTotal (;
                    Moeds C(3), Valtots N(12,2), Valitens N(12,2), Valdifs N(12,2), ;
                    PorcDifs N(12,4), Tipos C(1), Coefs N(6,3), Teors N(6,3), ;
                    Qtdes N(10,3), Mobras N(10,2), nSinals N(3), MoeVals N(12,5))
                INDEX ON Moeds TAG Moeds

                *-- Gerar numero da movimentacao
                LOCAL loc_nInicio, loc_cIniLet, loc_cEDN, loc_cCidChavesCab, loc_lNew
                loc_lNew    = .T.
                loc_nInicio = 0

                IF loc_nNumeras = 5
                    DO WHILE loc_nInicio = 0
                        TRY
                            loc_nInicio = fKeyGen()
                        CATCH
                            loc_nInicio = INT(RAND(0) * 999990) + 1
                        ENDTRY
                        loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigMvCab " + ;
                                   "WHERE EmpDopNums = " + ;
                                   EscaparSQL(loc_cEmps + loc_cDopes + STR(loc_nInicio, 6))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg") > 0
                            IF !EOF("cursor_4c_ChkReg") AND NVL(cursor_4c_ChkReg.nExiste, 0) > 0
                                loc_nInicio = 0
                            ENDIF
                            IF USED("cursor_4c_ChkReg")
                                USE IN cursor_4c_ChkReg
                            ENDIF
                        ENDIF
                    ENDDO
                    loc_lNew = .F.
                ENDIF

                IF loc_lNew AND loc_nNumeras # 2
                    loc_nInicio = fGerUniqueKey(ALLTRIM(loc_cDopes) + loc_cEmps)
                ENDIF

                loc_cIniLet      = ALLTRIM(fGerMascara(loc_nInicio))
                loc_cEDN         = loc_cEmps + loc_cDopes + STR(loc_nInicio, 6)
                loc_cCidChavesCab = fUniqueIds()

                *-- Buscar cotacao da moeda da operacao
                LOCAL loc_nCotMov, loc_cMoeOpe
                loc_cMoeOpe = loc_cCmoes
                loc_nCotMov = 0

                IF !EMPTY(loc_cMoeOpe)
                    loc_nCotMov = fBuscarCotacao(loc_cMoeOpe, loc_dDatasArq)
                    IF !SEEK(PADR(loc_cMoeOpe, 3), "TmpTotal", "Moeds")
                        LOCAL loc_cMoeTmp, loc_nCotTmp
                        loc_cMoeTmp = loc_cMoeOpe
                        loc_nCotTmp = loc_nCotMov
                        INSERT INTO TmpTotal (Moeds, MoeVals) VALUES (m.loc_cMoeTmp, m.loc_nCotTmp)
                    ENDIF
                ENDIF

                *-- Iniciar transacao SQL Server
                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                *-- INSERT SigMvCab (cabecalho da movimentacao)
                SELECT crImpMvCab
                loc_cSQL = "INSERT INTO SigMvCab (" + ;
                           "Emps, Dopes, Numes, Usuars, Datars, Datas, Transps, Mascnum, " + ;
                           "Tabds, LPrecos, CidChaves, EmpDopNums, Dgopes, vCompensas, " + ;
                           "GrupoOs, ContaOs, GrupoDs, ContaDs, GrVends, Vends, " + ;
                           "GrResps, Resps, Obses, DataTrans, Valos, ValInis) VALUES ("
                loc_cSQL = loc_cSQL + ;
                           EscaparSQL(loc_cEmps) + ", " + ;
                           EscaparSQL(loc_cDopes) + ", " + ;
                           FormatarNumeroSQL(loc_nInicio, 0) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                           "GETDATE(), " + ;
                           IIF(!EMPTY(loc_dDatasArq), FormatarDataSQL(loc_dDatasArq), "NULL") + ", " + ;
                           "0, " + ;
                           EscaparSQL(LEFT(loc_cIniLet, 10)) + ", " + ;
                           "'', '', " + ;
                           EscaparSQL(loc_cCidChavesCab) + ", " + ;
                           EscaparSQL(LEFT(loc_cEDN, 29)) + ", " + ;
                           "'', " + ;
                           FormatarNumeroSQL(loc_nVComp, 2) + ", " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.GRUORIGS)) + ", " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.CONORIGS)) + ", " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.GRUDESTS)) + ", " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.CONDESTS)) + ", " + ;
                           EscaparSQL(LEFT(loc_cGrVends, 10)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.VENDS), 10)) + ", " + ;
                           EscaparSQL(LEFT(loc_cGrVends, 10)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.VENDS), 10)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.OBSES), 250)) + ", " + ;
                           "GETDATE(), 0, 0)"

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Falha ao inserir cabe" + CHR(231) + "alho da movimenta" + ;
                            CHR(231) + CHR(227) + "o.", "Erro")
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lOk = .F.
                ENDIF

                *-- Iterar sobre cada linha/item do arquivo
                IF loc_lOk
                    LOCAL loc_nValtot, loc_nCotItn, loc_nUnits, loc_nTotas, loc_cMoedaItn
                    loc_nValtot = 0

                    SELECT crImpMvCab
                    SCAN
                        *-- Validar produto
                        loc_cSQL = "SELECT Dpros FROM SigCdPro WHERE Cpros = " + ;
                                   EscaparSQL(ALLTRIM(crImpMvCab.CPROS))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProImp") < 1
                            MsgErro("Falha na conex" + CHR(227) + "o (SigCdPro).", "Erro")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lOk = .F.
                            IF USED("cursor_4c_ProImp")
                                USE IN cursor_4c_ProImp
                            ENDIF
                            EXIT
                        ENDIF
                        IF EOF("cursor_4c_ProImp")
                            loc_cMsg = "Produto " + ALLTRIM(crImpMvCab.CPROS) + ;
                                       " n" + CHR(227) + "o cadastrado."
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lOk = .F.
                            IF USED("cursor_4c_ProImp")
                                USE IN cursor_4c_ProImp
                            ENDIF
                            EXIT
                        ENDIF
                        IF USED("cursor_4c_ProImp")
                            USE IN cursor_4c_ProImp
                        ENDIF

                        SELECT crImpMvCab

                        *-- Calcular cotacao e converter moeda do item
                        loc_cMoedaItn = ALLTRIM(NVL(crImpMvCab.MOEDAS, ""))
                        loc_nUnits    = NVL(crImpMvCab.UNITS, 0)
                        loc_nTotas    = NVL(crImpMvCab.TOTAS, 0)

                        IF !EMPTY(loc_cMoedaItn)
                            loc_nCotItn = IIF(NVL(crImpMvCab.MOEVALS, 0) # 0, ;
                                              NVL(crImpMvCab.MOEVALS, 0), ;
                                              fBuscarCotacao(loc_cMoedaItn, crImpMvCab.DATAS))
                            IF !SEEK(PADR(loc_cMoedaItn, 3), "TmpTotal", "Moeds")
                                LOCAL loc_cMoedaItm, loc_nCotItm
                                loc_cMoedaItm = loc_cMoedaItn
                                loc_nCotItm   = NVL(crImpMvCab.MOEVALS, 0)
                                INSERT INTO TmpTotal (Moeds, MoeVals) ;
                                    VALUES (m.loc_cMoedaItm, m.loc_nCotItm)
                                SELECT crImpMvCab
                            ENDIF
                        ELSE
                            loc_nCotItn = 0
                        ENDIF

                        IF !EMPTY(loc_cMoeOpe) AND loc_cMoeOpe # loc_cMoedaItn AND loc_nCotMov # 0
                            loc_nUnits    = loc_nUnits * loc_nCotItn / loc_nCotMov
                            loc_nTotas    = loc_nTotas * loc_nCotItn / loc_nCotMov
                            loc_cMoedaItn = loc_cMoeOpe
                        ENDIF

                        LOCAL loc_cCidChavesItn
                        loc_cCidChavesItn = fUniqueIds()

                        *-- INSERT SigMvItn (itens da movimentacao)
                        loc_cSQL = "INSERT INTO SigMvItn (" + ;
                                   "Emps, Dopes, Numes, EmpDopNums, Citens, CodBarras, " + ;
                                   "Cpros, Dpros, Obs, Moedas, Moevs, Moevals, Qtds, " + ;
                                   "Cunis, Pesos, Cunips, Fators, Units, Unit2s, Univals, " + ;
                                   "Totas, Valdescs, Valbases, Sitribs, Tpipis, Bcipis, " + ;
                                   "Baseipi2s, Baseipi3s, Aliqs, Valipis, Sittricms, " + ;
                                   "Baseicms, Baseicm2s, Baseicm3s, Aliqicms, Icms, Cfops, " + ;
                                   "Bcicmss, Icmss, Aliqpis, Vpis, Aliqcofs, Vcofins, " + ;
                                   "Iss, Irrf, Inss, Cssl, Aliqiis, Taxaiis, Nadis, Niadis, " + ;
                                   "Codfabs, Origmercs, CidChaves, Opers, " + ;
                                   "Datatrans, Dtalts) VALUES ("

                        loc_cSQL = loc_cSQL + ;
                                   EscaparSQL(loc_cEmps) + ", " + ;
                                   EscaparSQL(loc_cDopes) + ", " + ;
                                   FormatarNumeroSQL(loc_nInicio, 0) + ", " + ;
                                   EscaparSQL(LEFT(loc_cEDN, 29)) + ", " + ;
                                   FormatarNumeroSQL(VAL(ALLTRIM(crImpMvCab.CITENS)), 0) + ", " + ;
                                   FormatarNumeroSQL(VAL(ALLTRIM(crImpMvCab.CODBARRAS)), 0) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CPROS), 14)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.DPROS), 40)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.OBS), 250)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cMoedaItn, 3)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.MOEVS), 3)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.MOEVALS, 0), 6) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.QTDS, 0), 3) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CUNIS), 3)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.PESOS, 0), 3) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CUNIPS), 3)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.FATORS, 0), 3) + ", " + ;
                                   FormatarNumeroSQL(loc_nUnits, 6) + ", " + ;
                                   FormatarNumeroSQL(loc_nUnits, 6) + ", " + ;
                                   FormatarNumeroSQL(loc_nUnits, 6) + ", " + ;
                                   FormatarNumeroSQL(loc_nTotas, 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.VALDESCS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.VALBASES, 0), 2) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.SITRIBS), 2)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.TPIPIS), 1)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BCIPIS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BASEIPI2S, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BASEIPI3S, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ALIQS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.VALIPIS, 0), 2) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.SITTRICMS), 3)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BASEICMS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BASEICM2S, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BASEICM3S, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ALIQICMS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ICMS, 0), 2) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CFOPS), 10)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BCICMSS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ICMSS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ALIQPIS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.VPIS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ALIQCOFS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.VCOFINS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ISS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.IRRF, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.INSS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.CSSL, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ALIQIIS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.TAXAIIS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.NADIS, 0), 0) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.NIADIS, 0), 0) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CODFABS), 60)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.ORIGMERCS), 1)) + ", " + ;
                                   EscaparSQL(loc_cCidChavesItn) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.OPERS), 1)) + ", " + ;
                                   "GETDATE(), GETDATE())"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Falha ao inserir item da movimenta" + ;
                                    CHR(231) + CHR(227) + "o.", "Erro")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lOk = .F.
                            EXIT
                        ENDIF

                        *-- Validar e inserir grade cor/tamanho (SigMvIts) se informado
                        IF loc_lOk AND ;
                           (!EMPTY(ALLTRIM(crImpMvCab.CODCORS)) OR !EMPTY(ALLTRIM(crImpMvCab.CODTAMS)))

                            IF !EMPTY(ALLTRIM(crImpMvCab.CODCORS))
                                loc_cSQL = "SELECT Cods FROM SigCdCor WHERE Cods = " + ;
                                           EscaparSQL(ALLTRIM(crImpMvCab.CODCORS))
                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CorImp") < 1
                                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdCor).", "Erro")
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                ENDIF
                                IF loc_lOk AND EOF("cursor_4c_CorImp")
                                    loc_cMsg = "Cor " + ALLTRIM(crImpMvCab.CODCORS) + ;
                                               " n" + CHR(227) + "o cadastrada."
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                ENDIF
                                IF USED("cursor_4c_CorImp")
                                    USE IN cursor_4c_CorImp
                                ENDIF
                                SELECT crImpMvCab
                            ENDIF

                            IF loc_lOk AND !EMPTY(ALLTRIM(crImpMvCab.CODTAMS))
                                loc_cSQL = "SELECT Cods FROM SigCdTam WHERE Cods = " + ;
                                           EscaparSQL(ALLTRIM(crImpMvCab.CODTAMS))
                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TamImp") < 1
                                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdTam).", "Erro")
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                ENDIF
                                IF loc_lOk AND EOF("cursor_4c_TamImp")
                                    loc_cMsg = "Tamanho " + ALLTRIM(crImpMvCab.CODTAMS) + ;
                                               " n" + CHR(227) + "o cadastrado."
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                ENDIF
                                IF USED("cursor_4c_TamImp")
                                    USE IN cursor_4c_TamImp
                                ENDIF
                                SELECT crImpMvCab
                            ENDIF

                            IF loc_lOk
                                LOCAL loc_cCidChavesIts
                                loc_cCidChavesIts = fUniqueIds()

                                loc_cSQL = "INSERT INTO SigMvIts (" + ;
                                           "Citens, Emps, Dopes, Numes, Cpros, " + ;
                                           "CodEmbs, CodTams, CodCors, " + ;
                                           "Qtds, Aqtds, Qtdembs, Aqtdembs, " + ;
                                           "Qtbaixas, Prembs, CodembEnts, Qtdents, " + ;
                                           "CodBarras, Pesos, Qtbxprods, Qtprods, " + ;
                                           "Datatrans, Locals, Ntrans, Qtreservas, " + ;
                                           "CidChaves, EmpDopNums, ChkSubn, Compris, Dtalts) VALUES (" + ;
                                           FormatarNumeroSQL(VAL(ALLTRIM(crImpMvCab.CITENS)), 0) + ", " + ;
                                           EscaparSQL(loc_cEmps) + ", " + ;
                                           EscaparSQL(loc_cDopes) + ", " + ;
                                           FormatarNumeroSQL(loc_nInicio, 0) + ", " + ;
                                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CPROS), 14)) + ", " + ;
                                           "'', " + ;
                                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CODTAMS), 4)) + ", " + ;
                                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CODCORS), 4)) + ", " + ;
                                           FormatarNumeroSQL(NVL(crImpMvCab.QTDS, 0), 3) + ", " + ;
                                           "0, 1, 1, 0, 0, '', 0, " + ;
                                           FormatarNumeroSQL(VAL(ALLTRIM(crImpMvCab.CODBARRAS)), 0) + ", " + ;
                                           FormatarNumeroSQL(NVL(crImpMvCab.PESOS, 0), 3) + ", " + ;
                                           "0, 0, GETDATE(), " + ;
                                           "'', 0, 0, " + ;
                                           EscaparSQL(loc_cCidChavesIts) + ", " + ;
                                           EscaparSQL(LEFT(loc_cEDN, 29)) + ", " + ;
                                           "0, 0, GETDATE())"

                                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                    MsgErro("Falha ao inserir grade da movimenta" + ;
                                            CHR(231) + CHR(227) + "o.", "Erro")
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Acumular total (loc_nTotas ja esta convertido para moeda da operacao)
                        IF loc_lOk
                            loc_nValtot = loc_nValtot + loc_nTotas
                        ELSE
                            EXIT
                        ENDIF

                        SELECT crImpMvCab
                    ENDSCAN

                    *-- Atualizar total no cabecalho
                    IF loc_lOk
                        loc_cSQL = "UPDATE SigMvCab SET " + ;
                                   "Valos = " + FormatarNumeroSQL(loc_nValtot, 2) + ;
                                   ", ValInis = " + FormatarNumeroSQL(loc_nValtot, 2) + ;
                                   " WHERE EmpDopNums = " + EscaparSQL(LEFT(loc_cEDN, 29))
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Falha ao atualizar total do cabe" + CHR(231) + "alho.", "Erro")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lOk = .F.
                        ENDIF
                    ENDIF

                    *-- Inserir registros por moeda em SigMvMov
                    IF loc_lOk
                        SELECT TmpTotal
                        SCAN
                            IF !EMPTY(ALLTRIM(TmpTotal.Moeds)) AND TmpTotal.MoeVals # 0
                                LOCAL loc_cCidChavesMov
                                loc_cCidChavesMov = fUniqueIds()

                                loc_cSQL = "INSERT INTO SigMvMov (" + ;
                                           "NSinals, Emps, Dopes, Numes, Moeds, " + ;
                                           "ValTots, ValItens, ValDifs, PorcDifs, Tipos, " + ;
                                           "Datatrans, Ntrans, Locals, Coefs, Mobras, " + ;
                                           "Qtdes, Teors, CidChaves, Dtalts, " + ;
                                           "EmpDopNums, Moevals) VALUES (" + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.nSinals, 0), 0) + ", " + ;
                                           EscaparSQL(loc_cEmps) + ", " + ;
                                           EscaparSQL(loc_cDopes) + ", " + ;
                                           FormatarNumeroSQL(loc_nInicio, 0) + ", " + ;
                                           EscaparSQL(ALLTRIM(TmpTotal.Moeds)) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Valtots, 0), 2) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Valitens, 0), 2) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Valdifs, 0), 2) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.PorcDifs, 0), 4) + ", " + ;
                                           EscaparSQL(ALLTRIM(TmpTotal.Tipos)) + ", " + ;
                                           "NULL, 0, '', " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Coefs, 0), 3) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Mobras, 0), 2) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Qtdes, 0), 3) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Teors, 0), 3) + ", " + ;
                                           EscaparSQL(loc_cCidChavesMov) + ", " + ;
                                           IIF(!EMPTY(loc_dDatasArq), FormatarDataSQL(loc_dDatasArq), "NULL") + ", " + ;
                                           EscaparSQL(LEFT(loc_cEDN, 29)) + ", " + ;
                                           FormatarNumeroSQL(TmpTotal.MoeVals, 5) + ")"

                                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                    MsgErro("Falha ao inserir movimenta" + ;
                                            CHR(231) + CHR(227) + "o de moeda.", "Erro")
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                    EXIT
                                ENDIF
                            ENDIF
                            SELECT TmpTotal
                        ENDSCAN
                    ENDIF
                ENDIF

                *-- Finalizar transacao
                IF loc_lOk
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    THIS.this_lResultadoOk  = .T.
                    THIS.this_cMensagemErro = ""
                    MsgInfo("Arquivo '" + par_cArquivo + "' importado com sucesso!", ;
                            "Importa" + CHR(231) + CHR(227) + "o conclu" + CHR(237) + "da")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = loc_cMsg
                    IF !EMPTY(loc_cMsg)
                        MsgAviso(par_cArquivo + " - " + loc_cMsg, ;
                                 "Importa" + CHR(231) + CHR(227) + "o cancelada")
                    ENDIF
                ENDIF

            ELSE
                THIS.this_cMensagemErro = loc_cMsg
                IF !EMPTY(loc_cMsg)
                    MsgAviso(par_cArquivo + " - " + loc_cMsg, ;
                             "Importa" + CHR(231) + CHR(227) + "o cancelada")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ProcessarArquivo")
            THIS.this_cMensagemErro = loc_oErro.Message
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDTRY

        *-- Limpar cursores temporarios
        IF USED("crImpMvCab")
            USE IN crImpMvCab
        ENDIF
        IF USED("TmpTotal")
            USE IN TmpTotal
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

