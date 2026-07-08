# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, GERBALS, NOPS, PRODUTOS, ORDEMS, GRUPOS

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
  ControlSource = ""
lcQryNens = [Select * From SigCdNec Where cIdChaves = '] + pIds + [']
lcQryMFas = [Select * From SigPdMvf Where cIdChaves = '] + pIds + [']
		lcQuery = [Select Codigos, Descrs ] + ;
				    [From SigCdGcr ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpGccr') < 1)
		Select TmpGccr
			lcQuery = [Select IClis, RClis, Grupos, Inativas ] + ;
					    [From SigCdCli ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpCli') < 1)
			Select TmpCli
	If Not Seek(This.Value, 'TmpCli', 'BalCodigo')
	If Not Seek(This.Value, 'TmpCli', 'BalNome')
If Not Empty(This.Value) And Not Seek(This.Value, 'TmpGccr', 'BalCodigo')
lcQuery = [Select Nops, cIdChaves, Emps, Grupods, Contads, CodPds, Unids, Obsps, Ordems, Obss ] + ;
		    [From SigPdMvf ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigPdMvf') < 1)
Select crSigPdMvf
	Select crSigCdNec
	Select crSigCdNec
	Select crSigPdMvf
		Select crSigOpPic
		Insert Into xMFas (Emps, Dopps, Datars, Datas, Usuars, Grupoos, Contaos, Grupods, Contads, ;
	Select crSigPdMvf
	Select UpSigCdNec
	Select xMFas
			lcQuery = [Select Grupos ] + ;
					    [From SigCdPrf ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPrf') < 1)
			Select crSigCdPrf
				lcQuery = [Select Grupos, Ordems ] + ;
						    [From SigCdPrf ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPrf') < 1)
				Select crSigCdPrf
		Insert Into UpSigPdMvf (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, Grupods, Contads, ;
	If Not ThisForm.poDataMgr.Update('UpSigCdNec')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - UpSigCdNec)')
	If Not ThisForm.poDataMgr.Update('UpSigPdMvf')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - UpSigPdMvf)')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMfa.prg) - TRECHOS RELEVANTES PARA PASS SQL (1348 linhas total):

*-- Linhas 594 a 620:
594:         loc_lOk    = .F.
595: 
596:         TRY
597:             loc_cSQL = "SELECT Linhas, Descs FROM SigCdLin"
598:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaLin") >= 1
599:                 loc_lOk = .T.
600:             ELSE
601:                 MsgErro("Falha ao buscar linhas de produ" + CHR(231) + CHR(227) + "o", "Erro")
602:             ENDIF
603: 
604:             IF loc_lOk
605:                 SELECT cursor_4c_BuscaLin
606:                 IF !EMPTY(loc_cValor)
607:                     LOCATE FOR ALLTRIM(EVALUATE(loc_cCampo)) == loc_cValor
608:                 ENDIF
609: 
610:                 IF FOUND() AND !EMPTY(loc_cValor)
611:                     THIS.txt_4c_Linha.Value  = ALLTRIM(cursor_4c_BuscaLin.Linhas)
612:                     THIS.txt_4c_DLinha.Value = ALLTRIM(cursor_4c_BuscaLin.Descs)
613:                 ELSE
614:                     loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", "cursor_4c_BuscaLin", "Linhas", ;
615:                         "Sele" + CHR(231) + CHR(227) + "o de Linha")
616:                     IF VARTYPE(loc_oLookup) = "O"
617:                         loc_oLookup.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
618:                         loc_oLookup.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
619:                         loc_oLookup.Show()
620:                         IF loc_oLookup.this_lSelecionou


### BO (C:\4c\projeto\app\classes\SigPdMfaBO.prg):
*------------------------------------------------------------------------------
* SigPdMfaBO.prg - Business Object para Mudanca de Fase Automatica
* Herda de: BusinessBase
* Tabela principal: SigPdMvf
* Chave: cIdChaves
*------------------------------------------------------------------------------
DEFINE CLASS SigPdMfaBO AS BusinessBase

    *-- Campos de entrada do formulario
    this_cLinha      = ""
    this_cDLinha     = ""
    this_nOp         = 0
    this_cGrupo      = ""
    this_cConta      = ""
    this_cDconta     = ""

    *-- Chave e parametros do sistema
    this_cSigKey      = ""
    this_cDopEntAuts  = ""
    this_cDoppPads    = ""
    this_cDoppServs   = ""

    *-- Contador interno para gerar cIdChaves unicas por execucao
    this_nSeqContador = 0

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigPdMvf"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cSigKey
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupo  = TratarNulo(Grupods,   "C")
            THIS.this_cConta  = TratarNulo(Contads,   "C")
            THIS.this_nOp     = TratarNulo(NOps,      "N")
            THIS.this_cSigKey = TratarNulo(cIdChaves, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes do processamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cLinha))
            MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Informar a Linha!!!", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF THIS.this_nOp = 0
            MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Informar a O.P.!!!", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cGrupo))
            MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Informar o Grupo!!!", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cConta))
            MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Informar a Conta!!!", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega SigKeys de SigCdPac e params de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- SigKeys de SigCdPac
            loc_cSQL = "SELECT TOP 1 SigKeys FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac") > 0
                SELECT cursor_4c_SigCdPac
                THIS.this_cSigKey = TratarNulo(SigKeys, "C")
                USE IN cursor_4c_SigCdPac
            ENDIF

            *-- Parametros operacionais de SigCdPam
            loc_cSQL = "SELECT TOP 1 DopEntAuts, DoppPads, DoppServs FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam") > 0
                SELECT cursor_4c_SigCdPam
                THIS.this_cDopEntAuts = TratarNulo(DopEntAuts, "C")
                THIS.this_cDoppPads   = TratarNulo(DoppPads,   "C")
                THIS.this_cDoppServs  = TratarNulo(DoppServs,  "C")
                USE IN cursor_4c_SigCdPam
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar par" + CHR(226) + "metros")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGruposContabeis - Carrega TmpGccr de SigCdGcr (GerBals=1)
    * Retorna .T. se cursor criado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGruposContabeis()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("TmpGccr")
                USE IN TmpGccr
            ENDIF

            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE GerBals = 1"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpGccr") < 1
                MsgErro("Falha ao carregar grupos cont" + CHR(225) + "beis (TmpGccr)", "Erro")
            ELSE
                SELECT TmpGccr
                INDEX ON Codigos TAG BalCodigo
                INDEX ON Descrs  TAG BalDescrs
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar grupos contab" + CHR(233) + "is")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarContas - Carrega TmpCli de SigCdCli (GerBals=1)
    * Retorna .T. se cursor criado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarContas()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("TmpCli")
                USE IN TmpCli
            ENDIF

            loc_cSQL = "SELECT IClis, RClis, Grupos, Inativas FROM SigCdCli WHERE GerBals = 1"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpCli") < 1
                MsgErro("Falha ao carregar contas (TmpCli)", "Erro")
            ELSE
                SELECT TmpCli
                INDEX ON IClis TAG IClis
                INDEX ON IClis TAG BalCodigo
                INDEX ON RClis TAG BalNome
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar contas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarNumBatch - Gera numero sequencial para o batch (Numps)
    *   Equivalente a fGerUniqueKey(lcDop + _Empr) do legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarNumBatch(par_cDop, par_cEmpr)
        LOCAL loc_nChave, loc_cSQL, loc_oErro
        loc_nChave = 1

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(Numps), 0) + 1 AS nProxChave " + ;
                       "FROM SigCdNec"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NumBatch") > 0
                SELECT cursor_4c_NumBatch
                loc_nChave = NVL(nProxChave, 1)
                USE IN cursor_4c_NumBatch
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gerar n" + CHR(250) + "mero de batch")
        ENDTRY

        RETURN loc_nChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarIdChaves - Gera cIdChaves unico de 20 chars para cada registro
    *   Equivalente a Dtos(Date())+Transform(fGerUniqueKey(...), "@L 999999")+SigKey
    *   par_nBatch: numero do batch (Numps), usado para garantir unicidade inter-batch
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarIdChaves(par_nBatch)
        THIS.this_nSeqContador = THIS.this_nSeqContador + 1

        LOCAL loc_cId, loc_nChaveSeq
        *-- Combina batch e contador para 6 digitos: batch ate 9999, contador ate 99
        loc_nChaveSeq = par_nBatch * 100 + THIS.this_nSeqContador
        loc_cId = DTOS(DATE()) + ;
                  TRANSFORM(loc_nChaveSeq, "@L 999999") + ;
                  LEFT(ALLTRIM(THIS.this_cSigKey) + SPACE(6), 6)

        RETURN LEFT(loc_cId + SPACE(20), 20)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarMudancaFase - Logica principal equivalente ao Processa.Click
    *   Busca OPs na faixa, verifica condicoes em SigCdNec e gera movimentacao
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarMudancaFase()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        LOCAL loc_cLinha, loc_cGrupo, loc_cConta, loc_nOp
        LOCAL loc_cDop, loc_cOperacao, loc_cServico
        LOCAL loc_nOpI, loc_nOpF
        LOCAL loc_cGruOrigs, loc_cConOrigs, loc_nSeqs
        LOCAL loc_lSelItem, loc_nBatch, loc_cIds
        LOCAL loc_cSQL, loc_cEmpresa, loc_cUsuario

        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            *-- Captura campos e contexto
            loc_cLinha    = ALLTRIM(THIS.this_cLinha)
            loc_cGrupo    = ALLTRIM(THIS.this_cGrupo)
            loc_cConta    = ALLTRIM(THIS.this_cConta)
            loc_nOp       = THIS.this_nOp
            loc_cEmpresa  = go_4c_Sistema.cCodEmpresa
            loc_cUsuario  = gc_4c_UsuarioLogado
            loc_cDop      = ALLTRIM(THIS.this_cDopEntAuts)
            loc_cOperacao = ALLTRIM(THIS.this_cDoppPads)
            loc_cServico  = ALLTRIM(THIS.this_cDoppServs)

            *-- Validacao obrigatoria dos campos
            IF loc_lContinuar AND !THIS.ValidarDados()
                loc_lContinuar = .F.
            ENDIF

            *-- DOP obrigatorio no cadastro de parametros
            IF loc_lContinuar AND EMPTY(loc_cDop)
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada " + ;
                         "no cadastro de par" + CHR(226) + "metros!", "Aviso")
                loc_lContinuar = .F.
            ENDIF

            *-- Busca detalhes da operacao DOP em SigCdOpd
            IF loc_lContinuar
                loc_cSQL = "SELECT TOP 1 GruOrigs, ConOrigs, Seqs " + ;
                           "FROM SigCdOpd " + ;
                           "WHERE Dopps = " + EscaparSQL(loc_cDop)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpd") < 1
                    MsgErro("Falha ao buscar opera" + CHR(231) + CHR(227) + "o em SigCdOpd", "Erro")
                    loc_lContinuar = .F.
                ELSE
                    SELECT cursor_4c_SigCdOpd
                    GO TOP
                    IF EOF("cursor_4c_SigCdOpd")
                        MsgAviso("Opera" + CHR(231) + CHR(227) + "o DOP n" + CHR(227) + "o encontrada: " + loc_cDop, "Aviso")
                        loc_lContinuar = .F.
                    ELSE
                        loc_cGruOrigs = TratarNulo(GruOrigs, "C")
                        loc_cConOrigs = TratarNulo(ConOrigs, "C")
                        loc_nSeqs     = TratarNulo(Seqs,     "N")
                    ENDIF
                    USE IN cursor_4c_SigCdOpd
                ENDIF
            ENDIF

            *-- Calcula faixa de numeros de OP e busca movimentos
            IF loc_lContinuar
                loc_nOpI = loc_nOp * 10000
                loc_nOpF = loc_nOp * 10000 + 9999

                loc_cSQL = "SELECT Nops, cIdChaves, Emps, Grupods, Contads, " + ;
                           "CodPds, Unids, Obsps, Ordems, Obss, NEnvs " + ;
                           "FROM SigPdMvf " + ;
                           "WHERE Nops BETWEEN " + TRANSFORM(loc_nOpI) + " AND " + TRANSFORM(loc_nOpF)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPdMvf") < 1
                    MsgErro("Falha ao buscar movimentos de produ" + CHR(231) + CHR(227) + "o", "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Cria cursor de staging (equivalente ao xMFas/UpSigPdMvf do legado)
            IF loc_lContinuar
                SET NULL ON
                CREATE CURSOR cursor_4c_xMFas ( ;
                    Emps    C(6)    NULL, ;
                    CodPds  C(20)   NULL, ;
                    Unids   C(6)    NULL, ;
                    Obsps   C(40)   NULL, ;
                    Obss    C(100)  NULL, ;
                    NOps    N(10,0) NULL, ;
                    NEnvs   N(10,0) NULL, ;
                    Pesos   N(14,4) NULL, ;
                    Qtds    N(14,4) NULL, ;
                    Ordems  N(6,0)  NULL  ;
                )
                SET NULL OFF
            ENDIF

            *-- Ordena movimentos desc e processa um registro por grupo de Nops
            IF loc_lContinuar
                SELECT cursor_4c_SigPdMvf
                INDEX ON STR(Nops, 10) + cIdChaves TAG Nops
                SET ORDER TO Nops DESCENDING
                GO TOP

                loc_lSelItem = .F.

                LOCAL loc_nOpPula, loc_llPula
                LOCAL loc_cEmpMvf, loc_nNops, loc_cCodPds, loc_cGrupods, loc_cContads
                LOCAL loc_cObsps, loc_cObss, loc_nNEnvs, loc_nOrdems, loc_cUnids

                DO WHILE !EOF("cursor_4c_SigPdMvf")
                    loc_nOpPula  = cursor_4c_SigPdMvf.Nops
                    loc_llPula   = .T.

                    *-- Captura dados do primeiro registro do grupo
                    loc_cEmpMvf  = TratarNulo(cursor_4c_SigPdMvf.Emps,    "C")
                    loc_nNops    = TratarNulo(cursor_4c_SigPdMvf.Nops,    "N")
                    loc_cCodPds  = TratarNulo(cursor_4c_SigPdMvf.CodPds,  "C")
                    loc_cGrupods = TratarNulo(cursor_4c_SigPdMvf.Grupods, "C")
                    loc_cContads = TratarNulo(cursor_4c_SigPdMvf.Contads, "C")
                    loc_cObsps   = TratarNulo(cursor_4c_SigPdMvf.Obsps,   "C")
                    loc_cObss    = TratarNulo(cursor_4c_SigPdMvf.Obss,    "C")
                    loc_nNEnvs   = TratarNulo(cursor_4c_SigPdMvf.NEnvs,   "N")
                    loc_nOrdems  = TratarNulo(cursor_4c_SigPdMvf.Ordems,  "N")
                    loc_cUnids   = TratarNulo(cursor_4c_SigPdMvf.Unids,   "C")

                    *-- Verifica SigCdNec com operacao padrao (DoppPads)
                    IF !EMPTY(loc_cOperacao)
                        loc_cSQL = "SELECT TOP 1 ChkSubn FROM SigCdNec " + ;
                                   "WHERE cIdChaves = " + EscaparSQL(TratarNulo(cursor_4c_SigPdMvf.cIdChaves, "C"))

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NecOp") > 0
                            SELECT cursor_4c_NecOp
                            IF !EOF("cursor_4c_NecOp")
                                IF !NVL(ChkSubn, .F.) AND ALLTRIM(loc_cEmpMvf) = ALLTRIM(loc_cEmpresa)
                                    loc_llPula = .F.
                                ENDIF
                            ENDIF
                            USE IN cursor_4c_NecOp
                        ENDIF
                    ENDIF

                    *-- Verifica SigCdNec com operacao de servico (DoppServs)
                    IF !EMPTY(loc_cServico)
                        loc_cSQL = "SELECT TOP 1 ChkSubn FROM SigCdNec " + ;
                                   "WHERE cIdChaves = " + EscaparSQL(TratarNulo(cursor_4c_SigPdMvf.cIdChaves, "C"))

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NecSvc") > 0
                            SELECT cursor_4c_NecSvc
                            IF !EOF("cursor_4c_NecSvc")
                                IF !NVL(ChkSubn, .F.) AND ALLTRIM(loc_cEmpMvf) = ALLTRIM(loc_cEmpresa)
                                    loc_llPula = .F.
                                ENDIF
                            ENDIF
                            USE IN cursor_4c_NecSvc
                        ENDIF
                    ENDIF

                    IF loc_llPula
                        *-- Pula todo o grupo de Nops
                        SELECT cursor_4c_SigPdMvf
                        DO WHILE !EOF("cursor_4c_SigPdMvf") AND cursor_4c_SigPdMvf.Nops = loc_nOpPula
                            SKIP
                        ENDDO
                        LOOP
                    ENDIF

                    *-- Busca dados do produto em SigCdPro
                    LOCAL loc_cLinhasPro, loc_nPesoMs
                    loc_cLinhasPro = ""
                    loc_nPesoMs    = 0

                    loc_cSQL = "SELECT TOP 1 Linhas, PesoMs FROM SigCdPro " + ;
                               "WHERE Produtos = " + EscaparSQL(ALLTRIM(loc_cCodPds))

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPro") > 0
                        SELECT cursor_4c_SigCdPro
                        IF !EOF("cursor_4c_SigCdPro")
                            loc_cLinhasPro = TratarNulo(Linhas, "C")
                            loc_nPesoMs    = TratarNulo(PesoMs, "N")
                        ENDIF
                        USE IN cursor_4c_SigCdPro
                    ENDIF

                    *-- Verifica condicoes para incluir este movimento no staging
                    IF ALLTRIM(loc_cGrupods)   = ALLTRIM(loc_cGruOrigs) AND ;
                       ALLTRIM(loc_cContads)   = ALLTRIM(loc_cConOrigs) AND ;
                       ALLTRIM(loc_cEmpMvf)    = ALLTRIM(loc_cEmpresa)  AND ;
                       ALLTRIM(loc_cLinhasPro) = ALLTRIM(loc_cLinha)

                        *-- Busca quantidade total em SigOpPic para esta OP
                        LOCAL loc_nQtde, loc_nTPeso
                        loc_nQtde = 0

                        loc_cSQL = "SELECT ISNULL(SUM(Qtds), 0) AS TotalQtds " + ;
                                   "FROM SigOpPic " + ;
                                   "WHERE Nops = " + TRANSFORM(loc_nNops)

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpPic") > 0
                            SELECT cursor_4c_SigOpPic
                            loc_nQtde = NVL(TotalQtds, 0)
                            USE IN cursor_4c_SigOpPic
                        ENDIF

                        loc_nTPeso = loc_nQtde * loc_nPesoMs

                        *-- Insere no cursor de staging
                        INSERT INTO cursor_4c_xMFas ( ;
                            Emps, CodPds, Unids, Obsps, Obss, ;
                            NOps, NEnvs, Pesos, Qtds, Ordems ;
                        ) VALUES ( ;
                            loc_cEmpresa, loc_cCodPds, loc_cUnids, loc_cObsps, loc_cObss, ;
                            loc_nNops, loc_nNops, loc_nTPeso, loc_nQtde, loc_nOrdems ;
                        )

                        loc_lSelItem = .T.
                    ENDIF

                    *-- Avanca ate proximo grupo de Nops
                    SELECT cursor_4c_SigPdMvf
                    DO WHILE !EOF("cursor_4c_SigPdMvf") AND cursor_4c_SigPdMvf.Nops = loc_nOpPula
                        SKIP
                    ENDDO
                ENDDO
            ENDIF

            *-- Realiza insercoes reais no banco se houver itens selecionados
            IF loc_lContinuar AND loc_lSelItem
                THIS.this_nSeqContador = 0
                loc_nBatch = THIS.GerarNumBatch(loc_cDop, loc_cEmpresa)
                loc_cIds   = THIS.GerarIdChaves(loc_nBatch)

                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                LOCAL loc_lTransOk
                loc_lTransOk = .T.

                *-- Insere cabecalho em SigCdNec
                loc_cSQL = "INSERT INTO SigCdNec " + ;
                           "(Emps, Dopps, Numps, Datas, Usuars, Datars, " + ;
                           " Grupoos, Contaos, Grupods, Contads, cIdChaves, EmpDNps) " + ;
                           "VALUES (" + ;
                           EscaparSQL(loc_cEmpresa) + ", " + ;
                           EscaparSQL(loc_cDop) + ", " + ;
                           TRANSFORM(loc_nBatch) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(loc_cUsuario) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(loc_cGruOrigs) + ", " + ;
                           EscaparSQL(loc_cConOrigs) + ", " + ;
                           EscaparSQL(loc_cGrupo) + ", " + ;
                           EscaparSQL(loc_cConta) + ", " + ;
                           EscaparSQL(loc_cIds) + ", " + ;
                           EscaparSQL(loc_cEmpresa + loc_cDop + STR(loc_nBatch, 10)) + ;
                           ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Falha ao inserir cabecalho em SigCdNec", "Erro")
                    loc_lTransOk = .F.
                ENDIF

                *-- Processa cada item do staging e insere em SigPdMvf
                IF loc_lTransOk
                    SELECT cursor_4c_xMFas
                    GO TOP

                    LOCAL loc_nOrdem, loc_nOrdMfa, loc_cCodPdsMfa, loc_cIdsMvf
                    DO WHILE !EOF("cursor_4c_xMFas") AND loc_lTransOk
                        loc_nOrdMfa    = TratarNulo(cursor_4c_xMFas.Ordems, "N")
                        loc_cCodPdsMfa = TratarNulo(cursor_4c_xMFas.CodPds, "C")
                        loc_nOrdem     = loc_nOrdMfa

                        *-- Consulta SigCdPrf para ajustar Ordems conforme fase seguinte (Seqs=1)
                        IF loc_nSeqs = 1
                            LOCAL loc_nPOrd
                            loc_nPOrd = loc_nOrdMfa + 1

                            *-- Primeira tentativa: fase seguinte pelo Ordems
                            loc_cSQL = "SELECT TOP 1 Grupos, Ordems FROM SigCdPrf " + ;
                                       "WHERE Produtos = " + EscaparSQL(ALLTRIM(loc_cCodPdsMfa)) + ;
                                       "  AND Ordems   = " + TRANSFORM(loc_nPOrd)

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Prf1") > 0
                                SELECT cursor_4c_Prf1
                                IF !EOF("cursor_4c_Prf1") AND ;
                                   ALLTRIM(TratarNulo(Grupos, "C")) = ALLTRIM(loc_cGrupo)
                                    loc_nOrdem = loc_nPOrd
                                ELSE
                                    *-- Segunda tentativa: fase com filtro de grupo
                                    loc_cSQL = "SELECT TOP 1 Grupos, Ordems FROM SigCdPrf " + ;
                                               "WHERE Produtos = " + EscaparSQL(ALLTRIM(loc_cCodPdsMfa)) + ;
                                               "  AND Grupos   = " + EscaparSQL(ALLTRIM(loc_cGrupo)) + ;
                                               "  AND Ordems   = " + TRANSFORM(loc_nPOrd)

                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Prf2") > 0
                                        SELECT cursor_4c_Prf2
                                        IF !EOF("cursor_4c_Prf2")
                                            IF ALLTRIM(TratarNulo(Grupos, "C")) = ALLTRIM(loc_cGrupo)
                                                loc_nOrdem = TratarNulo(Ordems, "N")
                                            ELSE
                                                loc_nOrdem = 0
                                            ENDIF
                                        ENDIF
                                        USE IN cursor_4c_Prf2
                                    ENDIF
                                ENDIF
                                USE IN cursor_4c_Prf1
                            ENDIF
                        ENDIF

                        *-- Gera cIdChaves unico para este movimento
                        loc_cIdsMvf = THIS.GerarIdChaves(loc_nBatch)

                        *-- Monta e executa INSERT em SigPdMvf
                        SELECT cursor_4c_xMFas

                        loc_cSQL = "INSERT INTO SigPdMvf " + ;
                                   "(Emps, Dopps, Numps, Datars, Datas, Usuars, " + ;
                                   " Grupoos, Contaos, Grupods, Contads, " + ;
                                   " NOps, NEnvs, Dataps, Dataes, Obss, " + ;
                                   " Codpds, Unids, Pesos, Qtds, Obsps, " + ;
                                   " Inicios, Finals, Ordems, cIdChaves, EmpDopNums, EmpDNps) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cEmpresa) + ", " + ;
                                   EscaparSQL(loc_cDop) + ", " + ;
                                   TRANSFORM(loc_nBatch) + ", " + ;
                                   "GETDATE(), GETDATE(), " + ;
                                   EscaparSQL(loc_cUsuario) + ", " + ;
                                   EscaparSQL(loc_cGruOrigs) + ", " + ;
                                   EscaparSQL(loc_cConOrigs) + ", " + ;
                                   EscaparSQL(loc_cGrupo) + ", " + ;
                                   EscaparSQL(loc_cConta) + ", " + ;
                                   TRANSFORM(TratarNulo(cursor_4c_xMFas.NOps,   "N")) + ", " + ;
                                   TRANSFORM(TratarNulo(cursor_4c_xMFas.NEnvs,  "N")) + ", " + ;
                                   "GETDATE(), NULL, " + ;
                                   EscaparSQL(TratarNulo(cursor_4c_xMFas.Obss,  "C")) + ", " + ;
                                   EscaparSQL(TratarNulo(cursor_4c_xMFas.CodPds,"C")) + ", " + ;
                                   EscaparSQL(TratarNulo(cursor_4c_xMFas.Unids, "C")) + ", " + ;
                                   FormatarNumeroSQL(TratarNulo(cursor_4c_xMFas.Pesos, "N")) + ", " + ;
                                   FormatarNumeroSQL(TratarNulo(cursor_4c_xMFas.Qtds,  "N")) + ", " + ;
                                   EscaparSQL(TratarNulo(cursor_4c_xMFas.Obsps, "C")) + ", " + ;
                                   "0, 0, " + ;
                                   TRANSFORM(loc_nOrdem) + ", " + ;
                                   EscaparSQL(loc_cIdsMvf) + ", " + ;
                                   EscaparSQL(loc_cEmpresa + SPACE(20) + STR(0, 6)) + ", " + ;
                                   EscaparSQL(loc_cEmpresa + loc_cDop + STR(loc_nBatch, 10)) + ;
                                   ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Falha ao inserir movimento em SigPdMvf", "Erro")
                            loc_lTransOk = .F.
                        ELSE
                            SKIP IN cursor_4c_xMFas
                        ENDIF
                    ENDDO
                ENDIF

                IF loc_lTransOk
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    THIS.RegistrarAuditoria("PROCESSO")
                    loc_lSucesso = .T.
                ELSE
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                ENDIF

            ELSE
                IF loc_lContinuar
                *-- Nenhum item selecionado mas processamento completou sem erro
                loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar mudan" + CHR(231) + "a de fase")
        ENDTRY

        *-- Limpeza de cursores (sempre executa, fora do TRY)
        IF USED("cursor_4c_SigPdMvf")
            USE IN cursor_4c_SigPdMvf
        ENDIF
        IF USED("cursor_4c_xMFas")
            USE IN cursor_4c_xMFas
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Para forms operacionais mapeia para ProcessarMudancaFase
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.ProcessarMudancaFase()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para form operacional puro
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_oErro
        TRY
            LOCAL loc_cSQL
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Operacao, Tabela, ChaveRegistro, Usuario, DataHora, Empresa) " + ;
                       "VALUES (" + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL("SigPdMvf") + ", " + ;
                       EscaparSQL(THIS.this_cSigKey) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Auditoria nao deve impedir a operacao principal
        ENDTRY
    ENDPROC

ENDDEFINE

