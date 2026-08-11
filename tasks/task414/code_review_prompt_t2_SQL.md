# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NEMPS, SERIFAB, CIMPFABS, CEMPS, CMODELOS

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
  ControlSource = ""
  ControlSource = "crSigFiMpf.cModelos"
  ControlSource = ""
  ControlSource = "crSigFiMpf.cImpFabs"
  ControlSource = "crSigFiMpf.cncaixas"
  ControlSource = "crSigFiMpf.cnintervs"
  ControlSource = "crSigFiMpf.emps"
  ControlSource = "crSigFiMpf.cnumusuars"
  ControlSource = "crSigFiMpf.cIfCoos"
  ControlSource = "crSigFiMpf.ctipoecfs"
  ControlSource = "crSigFiMpf.cversaosbs"
  ControlSource = "crSigFiMpf.tdatasbs"
  ControlSource = "crSigFiMpf.chorasbs"
  ControlSource = "crSigFiMpf.ccmdgers"
  ControlSource = "crSigFiMpf.tdtcadecfs"
  ControlSource = "crSigFiMpf.chrcadecfs"
  ControlSource = "crSigFiMpf.ccroiniops"
  ControlSource = "crSigFiMpf.cidecfs"
  ControlSource = "crSigFiMpf.gavetas"
  ControlSource = "crSigFiMpf.impches"
  ControlSource = "crSigFiMpf.Pertos"
  ControlSource = "crSigFiMpf.bompara"
  ControlSource = "crSigFiMpf.nominal"
  ControlSource = "crSigFiMpf.cruzado"
  ControlSource = "crSigFiMpf.ImpAtivas"
  ControlSource = "crSigFiMpf.MemFautos"
  ControlSource = "crSigFiMpf.Autenticas"
  ControlSource = "crSigFiMpf.impmfds"
  ControlSource = "crSigFiMpf.nImpBars"
  ControlSource = "crSigFiMpf.cissqns"
select crSigFiMpf
Select crSigFiMpf
	Select crSigFiMpf
	lcQuery = [Select EmpDopNums From SigMvCab Where nEmps = '] + thisform.pagina.dados.get_codigo.value + [']
	Thisform.poDatamgr.SqlExecute(lcQuery, [crTprMvCab])
		lcQuery = [Select EmpDopNums From SigExMvc Where nEmps = '] + thisform.pagina.dados.get_codigo.value + [']
		Thisform.poDatamgr.SqlExecute(lcQuery, [crTmpDelet])
			lcQuery = [Select datas From SigFiRX Where serifab = '] + thisform.pagina.dados.get_codigo.value + [']
			Thisform.poDatamgr.SqlExecute(lcQuery, [crTmpRelX])
Select crSigFiMpf
lcQuery = [Select Pafecfs From SigCdPac]
ThisForm.poDatamgr.SqlExecute(lcQuery, [CrSigCdPac])
	Select SetFiscal
		Insert into SetFiscal(cImpFabs, cGtAtuas, cEmps) values (crSigFiMpf.cImpFabs, crSigFiMpf.cGtAtuas, fDecriptografar(crSigFiMpf.Emps))
	lcQuery = [Select cgcs From SigCdEmp Where cEmps = '] + Alltrim(ThisForm.Pagina.Dados.Get_Emp.Value) + [']
	ThisForm.poDatamgr.SqlExecute(lcQuery, [CrTmpEmp])
	lcQuery = [Select cIfCNPJs, cIfNmApls, cmd5apls, cifnmsofts, cifies, cifims, cifvrsofts from SigCdPac]
	ThisForm.poDatamgr.SqlExecute(lcQuery, [CrTmpParac])
	SELECT SetFiscal
	SELECT SetFiscal
	lcQuery = [Select * From SigFiMpm Where cModelos = '] + Alltrim(ThisForm.Pagina.Dados.GetModelo.Value) + [']
	ThisForm.poDatamgr.SqlExecute(lcQuery, [CrTmpImp])
			lcQuery = [Select IMs, Estas From SigCdEmp Where cEmps = '] + Alltrim(ThisForm.Pagina.Dados.Get_Emp.Value) + [']
			ThisForm.poDatamgr.SqlExecute(lcQuery, [CrTmpEmp])
			lcQuery = [Select cIfNumApls, cIfCNPJs, cIfIEs, cIfIms, cIfNmSofts, cIfNmApls, cIfVrSofts, cIfLinha1s, cIfLinha2s  From SigCdPac]
			ThisForm.poDatamgr.SqlExecute(lcQuery, [CrTmpParac])

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormFBI.prg) - TRECHOS RELEVANTES PARA PASS SQL (2214 linhas total):

*-- Linhas 365 a 383:
365:             .HighlightBackColor   = RGB(255, 255, 255)
366:             .HighlightForeColor   = RGB(15, 41, 104)
367:             .HighlightStyle       = 2
368:             .DeleteMark           = .F.
369:             .RecordMark           = .F.
370:             .RowHeight            = 16
371:             .ScrollBars           = 2
372:             .GridLines            = 3
373:             .ColumnCount          = 4
374:             .Visible              = .T.
375:         ENDWITH
376: 
377:         *-- Configurar colunas do grid apos ColumnCount
378:         WITH loc_oPagina.grd_4c_Lista
379:             .Column1.Width              = 160
380:             .Column1.Header1.Caption    = "N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o"
381:             .Column1.Alignment          = 0
382: 
383:             .Column2.Width              = 80

*-- Linhas 1502 a 1523:
1502:                 IF THIS.this_oBusinessObject.Buscar("")
1503:                     loc_oGrid.ColumnCount = 4
1504:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1505:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cImpFabs"
1506:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
1507:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cImpFabs"
1508:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.cncaixas"
1509: 
1510:                     *-- Redefinir headers apos RecordSource (VFP9 reseta cabecalhos)
1511:                     loc_oGrid.Column1.Header1.Caption = "N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o"
1512:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
1513:                     loc_oGrid.Column3.Header1.Caption = "Fabrica" + CHR(231) + CHR(227) + "o (Criptografado)"
1514:                     loc_oGrid.Column4.Header1.Caption = "Caixa"
1515: 
1516:                     THIS.FormatarGridLista(loc_oGrid)
1517:                     loc_lResultado = .T.
1518:                 ENDIF
1519:             ENDIF
1520:         CATCH TO loc_oErro
1521:             MostrarErro(loc_oErro, "FormFBI.CarregarLista")
1522:         ENDTRY
1523: 


### BO (C:\4c\projeto\app\classes\FBIBO.prg):
*====================================================================
* FBIBO.prg
*
* Business Object para Cadastro de Fabricacao (SigFiMpf)
* Herda de: BusinessBase
*
* Tabela: SigFiMpf
* Chave primaria: cidchaves (gerada por Sys(2015)+Sys(2015))
* Chave de negocio: cImpFabs (No. Fabricacao / NFAB)
*
* Campos GT (cgtinics, cgtatuas) armazenados como strings no legado.
*====================================================================

DEFINE CLASS FBIBO AS BusinessBase

    *-- Chave primaria interna
    this_cChaves        = ""   && cidchaves char(30)  - PK gerada automaticamente

    *-- Identificacao do ECF
    this_cCodigo        = ""   && cImpFabs char(20)   - No. Fabricacao / NFAB (chave negocio)
    this_cEmpresa       = ""   && emps char(3)         - Codigo da empresa
    this_cNcaixas       = ""   && cncaixas char(3)     - No. do Caixa / NSEQ

    *-- Contadores e registradores
    this_cInterv        = ""   && cnintervs char(4)    - Contador Reinicio de Operacao
    this_cGTInics       = ""   && cgtinics char(30)    - GT Inicial (string)
    this_cGTAtuas       = ""   && cgtatuas char(30)    - GT Atual (string)

    *-- Modelo e identificacao do ECF
    this_cModelo        = ""   && cModelos char(30)    - Modelo da impressora ECF
    this_cNumUsuars     = ""   && cnumusuars char(2)   - Numero do Usuario do ECF
    this_cTipoECF       = ""   && ctipoecfs char(7)    - Tipo do ECF
    this_cCodNac        = ""   && cidecfs char(6)      - Codigo Nacional do ECF
    this_cIfCoos        = ""   && cIfCoos char(6)      - COO Inicial (Troca Aplicativo)
    this_cCROIniOps     = ""   && ccroiniops char(6)   - CRO Inicial de Operacoes

    *-- Software Basico
    this_cVersaoSB      = ""   && cversaosbs char(10)  - Versao do Software Basico
    this_dDataSB        = {}   && tdatasbs date        - Data do Software Basico
    this_cHoraSB        = ""   && chorasbs char(8)     - Hora do Software Basico (HH:MM:SS)

    *-- Dados de cadastro do ECF
    this_dDtCadECF      = {}   && tdtcadecfs date      - Data do Cadastro do ECF
    this_cHrCadECF      = ""   && chrcadecfs char(8)   - Hora do Cadastro do ECF (HH:MM:SS)

    *-- Comando RFD
    this_cCmdRFD        = ""   && ccmdgers char(3)     - Comando de Geracao RFD

    *-- Flags booleanos (BIT no SQL Server)
    this_lGaveta        = .F.  && gavetas              - Gaveta Acoplada
    this_lImpCheque     = .F.  && impches              - Impressora de Cheques
    this_lPerto         = .F.  && Pertos               - Pertochek / Check-Pronto
    this_lBomPara       = .F.  && bompara              - Bom Para (uso cheque)
    this_lNominal       = .F.  && nominal              - Nominal
    this_lCruzado       = .F.  && cruzado              - Cruzado
    this_lInativa       = .F.  && ImpAtivas            - Impressora Inativa
    this_lLeitMF        = .F.  && MemFautos            - Leitura Mem. Fiscal Automatico
    this_lMFD           = .F.  && impmfds              - MFD (Memoria de Fita Detalhe)
    this_lISSQN         = .F.  && cissqns              - Incidencia Desconto ISSQN

    *-- Opcoes OptionGroup (N: 1=Sim, 2=Nao)
    this_nAutentica     = 1    && Autenticas           - Autentica cheque (1=Sim, 2=Nao)
    this_nImpBars       = 1    && nImpBars             - Imprime Cod. de Barras (1=Sim, 2=Nao)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigFiMpf"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cChaves
    ENDPROC

    *====================================================================
    * LimparDados - Limpa propriedades (chamado por NovoRegistro)
    *====================================================================
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cChaves    = ""
        THIS.this_cCodigo    = ""
        THIS.this_cEmpresa   = ""
        THIS.this_cNcaixas   = ""
        THIS.this_cInterv    = ""
        THIS.this_cGTInics   = ""
        THIS.this_cGTAtuas   = ""
        THIS.this_cModelo    = ""
        THIS.this_cNumUsuars = ""
        THIS.this_cTipoECF   = ""
        THIS.this_cCodNac    = ""
        THIS.this_cIfCoos    = ""
        THIS.this_cCROIniOps = ""
        THIS.this_cVersaoSB  = ""
        THIS.this_dDataSB    = {}
        THIS.this_cHoraSB    = ""
        THIS.this_dDtCadECF  = {}
        THIS.this_cHrCadECF  = ""
        THIS.this_cCmdRFD    = ""
        THIS.this_lGaveta    = .F.
        THIS.this_lImpCheque = .F.
        THIS.this_lPerto     = .F.
        THIS.this_lBomPara   = .F.
        THIS.this_lNominal   = .F.
        THIS.this_lCruzado   = .F.
        THIS.this_lInativa   = .F.
        THIS.this_lLeitMF    = .F.
        THIS.this_lMFD       = .F.
        THIS.this_lISSQN     = .F.
        THIS.this_nAutentica = 1
        THIS.this_nImpBars   = 1
    ENDPROC

    *====================================================================
    * Buscar - Retorna lista de registros (cursor_4c_Dados)
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cImpFabs, emps, cncaixas, cnintervs," + ;
                       " cgtinics, cgtatuas, cModelos, cnumusuars, ctipoecfs," + ;
                       " cidecfs, cIfCoos, ccroiniops, cversaosbs," + ;
                       " tdatasbs, chorasbs, tdtcadecfs, chrcadecfs, ccmdgers," + ;
                       " gavetas, impches, Pertos, bompara, nominal, cruzado," + ;
                       " ImpAtivas, MemFautos, Autenticas, impmfds, nImpBars, cissqns" + ;
                       " FROM SigFiMpf"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE cImpFabs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
                loc_cSQL = loc_cSQL + loc_cWhere
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cImpFabs"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar registros: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cImpFabs, emps, cncaixas, cnintervs," + ;
                       " cgtinics, cgtatuas, cModelos, cnumusuars, ctipoecfs," + ;
                       " cidecfs, cIfCoos, ccroiniops, cversaosbs," + ;
                       " tdatasbs, chorasbs, tdtcadecfs, chrcadecfs, ccmdgers," + ;
                       " gavetas, impches, Pertos, bompara, nominal, cruzado," + ;
                       " ImpAtivas, MemFautos, Autenticas, impmfds, nImpBars, cissqns" + ;
                       " FROM SigFiMpf WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                MostrarErro("Registro n" + CHR(227) + "o encontrado.", "")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.CarregarPorCodigo")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cChaves    = TratarNulo(cidchaves, "C")
                THIS.this_cCodigo    = TratarNulo(cImpFabs, "C")
                THIS.this_cEmpresa   = TratarNulo(emps, "C")
                THIS.this_cNcaixas   = TratarNulo(cncaixas, "C")
                THIS.this_cInterv    = TratarNulo(cnintervs, "C")
                THIS.this_cGTInics   = TratarNulo(cgtinics, "C")
                THIS.this_cGTAtuas   = TratarNulo(cgtatuas, "C")
                THIS.this_cModelo    = TratarNulo(cModelos, "C")
                THIS.this_cNumUsuars = TratarNulo(cnumusuars, "C")
                THIS.this_cTipoECF   = TratarNulo(ctipoecfs, "C")
                THIS.this_cCodNac    = TratarNulo(cidecfs, "C")
                THIS.this_cIfCoos    = TratarNulo(cIfCoos, "C")
                THIS.this_cCROIniOps = TratarNulo(ccroiniops, "C")
                THIS.this_cVersaoSB  = TratarNulo(cversaosbs, "C")
                THIS.this_dDataSB    = TratarNulo(tdatasbs, "D")
                THIS.this_cHoraSB    = TratarNulo(chorasbs, "C")
                THIS.this_dDtCadECF  = TratarNulo(tdtcadecfs, "D")
                THIS.this_cHrCadECF  = TratarNulo(chrcadecfs, "C")
                THIS.this_cCmdRFD    = TratarNulo(ccmdgers, "C")
                IF VARTYPE(gavetas) = "L"
                    THIS.this_lGaveta = gavetas
                ELSE
                    IF VARTYPE(gavetas) = "L"
                        THIS.this_lGaveta = gavetas
                    ELSE
                        IF VARTYPE(gavetas) = "L"
                            THIS.this_lGaveta = gavetas
                        ELSE
                            IF VARTYPE(gavetas) = "L"
                                THIS.this_lGaveta = gavetas
                            ELSE
                                THIS.this_lGaveta = (NVL(gavetas, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(impches) = "L"
                    THIS.this_lImpCheque = impches
                ELSE
                    IF VARTYPE(impches) = "L"
                        THIS.this_lImpCheque = impches
                    ELSE
                        IF VARTYPE(impches) = "L"
                            THIS.this_lImpCheque = impches
                        ELSE
                            IF VARTYPE(impches) = "L"
                                THIS.this_lImpCheque = impches
                            ELSE
                                THIS.this_lImpCheque = (NVL(impches, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(Pertos) = "L"
                    THIS.this_lPerto = Pertos
                ELSE
                    IF VARTYPE(Pertos) = "L"
                        THIS.this_lPerto = Pertos
                    ELSE
                        IF VARTYPE(Pertos) = "L"
                            THIS.this_lPerto = Pertos
                        ELSE
                            IF VARTYPE(Pertos) = "L"
                                THIS.this_lPerto = Pertos
                            ELSE
                                THIS.this_lPerto = (NVL(Pertos, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(bompara) = "L"
                    THIS.this_lBomPara = bompara
                ELSE
                    IF VARTYPE(bompara) = "L"
                        THIS.this_lBomPara = bompara
                    ELSE
                        IF VARTYPE(bompara) = "L"
                            THIS.this_lBomPara = bompara
                        ELSE
                            IF VARTYPE(bompara) = "L"
                                THIS.this_lBomPara = bompara
                            ELSE
                                THIS.this_lBomPara = (NVL(bompara, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(nominal) = "L"
                    THIS.this_lNominal = nominal
                ELSE
                    IF VARTYPE(nominal) = "L"
                        THIS.this_lNominal = nominal
                    ELSE
                        IF VARTYPE(nominal) = "L"
                            THIS.this_lNominal = nominal
                        ELSE
                            IF VARTYPE(nominal) = "L"
                                THIS.this_lNominal = nominal
                            ELSE
                                THIS.this_lNominal = (NVL(nominal, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(cruzado) = "L"
                    THIS.this_lCruzado = cruzado
                ELSE
                    IF VARTYPE(cruzado) = "L"
                        THIS.this_lCruzado = cruzado
                    ELSE
                        IF VARTYPE(cruzado) = "L"
                            THIS.this_lCruzado = cruzado
                        ELSE
                            IF VARTYPE(cruzado) = "L"
                                THIS.this_lCruzado = cruzado
                            ELSE
                                THIS.this_lCruzado = (NVL(cruzado, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(ImpAtivas) = "L"
                    THIS.this_lInativa = ImpAtivas
                ELSE
                    IF VARTYPE(ImpAtivas) = "L"
                        THIS.this_lInativa = ImpAtivas
                    ELSE
                        IF VARTYPE(ImpAtivas) = "L"
                            THIS.this_lInativa = ImpAtivas
                        ELSE
                            IF VARTYPE(ImpAtivas) = "L"
                                THIS.this_lInativa = ImpAtivas
                            ELSE
                                THIS.this_lInativa = (NVL(ImpAtivas, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(MemFautos) = "L"
                    THIS.this_lLeitMF = MemFautos
                ELSE
                    IF VARTYPE(MemFautos) = "L"
                        THIS.this_lLeitMF = MemFautos
                    ELSE
                        IF VARTYPE(MemFautos) = "L"
                            THIS.this_lLeitMF = MemFautos
                        ELSE
                            IF VARTYPE(MemFautos) = "L"
                                THIS.this_lLeitMF = MemFautos
                            ELSE
                                THIS.this_lLeitMF = (NVL(MemFautos, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(impmfds) = "L"
                    THIS.this_lMFD = impmfds
                ELSE
                    IF VARTYPE(impmfds) = "L"
                        THIS.this_lMFD = impmfds
                    ELSE
                        IF VARTYPE(impmfds) = "L"
                            THIS.this_lMFD = impmfds
                        ELSE
                            IF VARTYPE(impmfds) = "L"
                                THIS.this_lMFD = impmfds
                            ELSE
                                THIS.this_lMFD = (NVL(impmfds, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(cissqns) = "L"
                    THIS.this_lISSQN = cissqns
                ELSE
                    IF VARTYPE(cissqns) = "L"
                        THIS.this_lISSQN = cissqns
                    ELSE
                        IF VARTYPE(cissqns) = "L"
                            THIS.this_lISSQN = cissqns
                        ELSE
                            IF VARTYPE(cissqns) = "L"
                                THIS.this_lISSQN = cissqns
                            ELSE
                                THIS.this_lISSQN = (NVL(cissqns, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                THIS.this_nAutentica = NVL(Autenticas, 1)
                THIS.this_nImpBars   = NVL(nImpBars, 1)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT em SigFiMpf
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cDataSB, loc_cDtCadECF
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cChaves)
                THIS.this_cChaves = SYS(2015) + SYS(2015)
            ENDIF

            loc_cDataSB   = IIF(EMPTY(THIS.this_dDataSB),   "NULL", FormatarDataSQL(THIS.this_dDataSB))
            loc_cDtCadECF = IIF(EMPTY(THIS.this_dDtCadECF), "NULL", FormatarDataSQL(THIS.this_dDtCadECF))

            loc_cSQL = "INSERT INTO SigFiMpf (" + ;
                       " cidchaves, cImpFabs, emps, cncaixas, cnintervs," + ;
                       " cgtinics, cgtatuas, cModelos, cnumusuars, ctipoecfs," + ;
                       " cidecfs, cIfCoos, ccroiniops, cversaosbs," + ;
                       " tdatasbs, chorasbs, tdtcadecfs, chrcadecfs, ccmdgers," + ;
                       " gavetas, impches, Pertos, bompara, nominal, cruzado," + ;
                       " ImpAtivas, MemFautos, Autenticas, impmfds, nImpBars, cissqns" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cChaves) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigo), 20)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpresa), 3)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cNcaixas), 3)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cInterv), 4)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cGTInics), 30)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cGTAtuas), 30)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cModelo), 30)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cNumUsuars), 2)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cTipoECF), 7)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodNac), 6)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cIfCoos), 6)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cCROIniOps), 6)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cVersaoSB), 10)) + ", " + ;
                       loc_cDataSB + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cHoraSB), 8)) + ", " + ;
                       loc_cDtCadECF + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cHrCadECF), 8)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cCmdRFD), 3)) + ", " + ;
                       IIF(THIS.this_lGaveta,    "1", "0") + ", " + ;
                       IIF(THIS.this_lImpCheque, "1", "0") + ", " + ;
                       IIF(THIS.this_lPerto,     "1", "0") + ", " + ;
                       IIF(THIS.this_lBomPara,   "1", "0") + ", " + ;
                       IIF(THIS.this_lNominal,   "1", "0") + ", " + ;
                       IIF(THIS.this_lCruzado,   "1", "0") + ", " + ;
                       IIF(THIS.this_lInativa,   "1", "0") + ", " + ;
                       IIF(THIS.this_lLeitMF,    "1", "0") + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAutentica) + ", " + ;
                       IIF(THIS.this_lMFD,       "1", "0") + ", " + ;
                       FormatarNumeroSQL(THIS.this_nImpBars) + ", " + ;
                       IIF(THIS.this_lISSQN,     "1", "0") + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE em SigFiMpf
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cDataSB, loc_cDtCadECF
        loc_lSucesso = .F.

        TRY
            loc_cDataSB   = IIF(EMPTY(THIS.this_dDataSB),   "NULL", FormatarDataSQL(THIS.this_dDataSB))
            loc_cDtCadECF = IIF(EMPTY(THIS.this_dDtCadECF), "NULL", FormatarDataSQL(THIS.this_dDtCadECF))

            loc_cSQL = "UPDATE SigFiMpf SET" + ;
                       " cImpFabs   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigo), 20)) + "," + ;
                       " emps       = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpresa), 3)) + "," + ;
                       " cncaixas   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cNcaixas), 3)) + "," + ;
                       " cnintervs  = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cInterv), 4)) + "," + ;
                       " cgtinics   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGTInics), 30)) + "," + ;
                       " cgtatuas   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGTAtuas), 30)) + "," + ;
                       " cModelos   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cModelo), 30)) + "," + ;
                       " cnumusuars = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cNumUsuars), 2)) + "," + ;
                       " ctipoecfs  = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTipoECF), 7)) + "," + ;
                       " cidecfs    = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodNac), 6)) + "," + ;
                       " cIfCoos    = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIfCoos), 6)) + "," + ;
                       " ccroiniops = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCROIniOps), 6)) + "," + ;
                       " cversaosbs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cVersaoSB), 10)) + "," + ;
                       " tdatasbs   = " + loc_cDataSB + "," + ;
                       " chorasbs   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cHoraSB), 8)) + "," + ;
                       " tdtcadecfs = " + loc_cDtCadECF + "," + ;
                       " chrcadecfs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cHrCadECF), 8)) + "," + ;
                       " ccmdgers   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCmdRFD), 3)) + "," + ;
                       " gavetas    = " + IIF(THIS.this_lGaveta,    "1", "0") + "," + ;
                       " impches    = " + IIF(THIS.this_lImpCheque, "1", "0") + "," + ;
                       " Pertos     = " + IIF(THIS.this_lPerto,     "1", "0") + "," + ;
                       " bompara    = " + IIF(THIS.this_lBomPara,   "1", "0") + "," + ;
                       " nominal    = " + IIF(THIS.this_lNominal,   "1", "0") + "," + ;
                       " cruzado    = " + IIF(THIS.this_lCruzado,   "1", "0") + "," + ;
                       " ImpAtivas  = " + IIF(THIS.this_lInativa,   "1", "0") + "," + ;
                       " MemFautos  = " + IIF(THIS.this_lLeitMF,    "1", "0") + "," + ;
                       " Autenticas = " + FormatarNumeroSQL(THIS.this_nAutentica) + "," + ;
                       " impmfds    = " + IIF(THIS.this_lMFD,       "1", "0") + "," + ;
                       " nImpBars   = " + FormatarNumeroSQL(THIS.this_nImpBars) + "," + ;
                       " cissqns    = " + IIF(THIS.this_lISSQN,     "1", "0") + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE em SigFiMpf com verificacao de dependencias
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lMovimento
        loc_lSucesso  = .F.
        loc_lMovimento = .F.

        TRY
            *-- Verificar movimentos em SigMvCab
            loc_cSQL = "SELECT EmpDopNums FROM SigMvCab WHERE nEmps = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkMvCab")
                TABLEREVERT(.T., "cursor_4c_ChkMvCab")
                USE IN cursor_4c_ChkMvCab
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMvCab")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkMvCab") > 0
                loc_lMovimento = .T.
            ENDIF
            IF USED("cursor_4c_ChkMvCab")
                USE IN cursor_4c_ChkMvCab
            ENDIF

            *-- Verificar movimentos em SigExMvc
            IF !loc_lMovimento
                loc_cSQL = "SELECT EmpDopNums FROM SigExMvc WHERE nEmps = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ChkExMvc")
                    TABLEREVERT(.T., "cursor_4c_ChkExMvc")
                    USE IN cursor_4c_ChkExMvc
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExMvc")
                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkExMvc") > 0
                    loc_lMovimento = .T.
                ENDIF
                IF USED("cursor_4c_ChkExMvc")
                    USE IN cursor_4c_ChkExMvc
                ENDIF
            ENDIF

            *-- Verificar lancamentos em SigFiRX
            IF !loc_lMovimento
                loc_cSQL = "SELECT datas FROM SigFiRX WHERE serifab = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ChkFiRX")
                    TABLEREVERT(.T., "cursor_4c_ChkFiRX")
                    USE IN cursor_4c_ChkFiRX
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkFiRX")
                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkFiRX") > 0
                    loc_lMovimento = .T.
                ENDIF
                IF USED("cursor_4c_ChkFiRX")
                    USE IN cursor_4c_ChkFiRX
                ENDIF
            ENDIF

            IF loc_lMovimento
                MsgAviso("Impressora Fiscal N" + CHR(227) + "o Pode Ser Exclui" + CHR(237) + "da, Possui Movimenta" + CHR(231) + CHR(227) + "o !!!")
            ELSE
                loc_cSQL = "DELETE FROM SigFiMpf WHERE cidchaves = " + EscaparSQL(THIS.this_cChaves)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir registro: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.ExecutarExclusao")
            IF USED("cursor_4c_ChkMvCab")
                USE IN cursor_4c_ChkMvCab
            ENDIF
            IF USED("cursor_4c_ChkExMvc")
                USE IN cursor_4c_ChkExMvc
            ENDIF
            IF USED("cursor_4c_ChkFiRX")
                USE IN cursor_4c_ChkFiRX
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

