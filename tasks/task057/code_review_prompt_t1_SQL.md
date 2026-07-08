# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (6)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, DATACONCS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, DATACONCS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DATAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, DATACONCS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, DATACONCS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, DATACONCS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, DATACONCS

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
  ControlSource = ""
Insert Into dbCabecalho (NomeEmpresa, Titulo, SubTitulo, Moeda1) Values (lcCep, lcTit, lcSub, lcMoe)
lcQuery = [Select Grupos, Contas, cIdChaves, Datas, Opers, Valors, Moedas, Docus, Emps, DtAudits, Hists, Hist2s ] + ;
			[From SigMvCcr ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crDados') < 1)
Select crDados
	oProg.Update(.t.)
	Insert Into TmpHist (Audits, Datas, Grupos, Contas, RClis, Saldo1, Opers, ;
Select TmpHist

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGRECND.prg) - TRECHOS RELEVANTES PARA PASS SQL (1358 linhas total):

*-- Linhas 947 a 969:
947:             loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
948:             loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
949:             IF !EMPTY(loc_cValor)
950:                 loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr " + ;
951:                            "WHERE Codigos = " + EscaparSQL(PADR(loc_cValor, 10))
952:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoV")
953:                 IF loc_nResult > 0
954:                     SELECT cursor_4c_GrupoV
955:                     IF !EOF()
956:                         loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(Codigos)
957:                         loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(Descrs)
958:                     ELSE
959:                         loc_lEncontrado = .F.
960:                     ENDIF
961:                     USE IN cursor_4c_GrupoV
962:                 ELSE
963:                     loc_lEncontrado = .F.
964:                 ENDIF
965:             ELSE
966:                 loc_oCnt.txt_4c_DGrupo.Value = ""
967:             ENDIF
968:         CATCH TO loc_oErro
969:             IF USED("cursor_4c_GrupoV")

*-- Linhas 1012 a 1034:
1012:             loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1013:             loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
1014:             IF !EMPTY(loc_cValor)
1015:                 loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli " + ;
1016:                            "WHERE IClis = " + EscaparSQL(PADR(loc_cValor, 10))
1017:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaV")
1018:                 IF loc_nResult > 0
1019:                     SELECT cursor_4c_ContaV
1020:                     IF !EOF()
1021:                         loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(IClis)
1022:                         loc_oCnt.txt_4c_DConta.Value = ALLTRIM(RClis)
1023:                     ELSE
1024:                         loc_lEncontrado = .F.
1025:                     ENDIF
1026:                     USE IN cursor_4c_ContaV
1027:                 ELSE
1028:                     loc_lEncontrado = .F.
1029:                 ENDIF
1030:             ELSE
1031:                 loc_oCnt.txt_4c_DConta.Value = ""
1032:             ENDIF
1033:         CATCH TO loc_oErro
1034:             IF USED("cursor_4c_ContaV")

*-- Linhas 1077 a 1099:
1077:             loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
1078:             loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Moeda.Value)
1079:             IF !EMPTY(loc_cValor)
1080:                 loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe " + ;
1081:                            "WHERE CMoes = " + EscaparSQL(PADR(loc_cValor, 3))
1082:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoedaV")
1083:                 IF loc_nResult > 0
1084:                     SELECT cursor_4c_MoedaV
1085:                     IF !EOF()
1086:                         loc_oCnt.txt_4c_Moeda.Value  = ALLTRIM(CMoes)
1087:                         loc_oCnt.txt_4c_DMoeda.Value = ALLTRIM(DMoes)
1088:                     ELSE
1089:                         loc_lEncontrado = .F.
1090:                     ENDIF
1091:                     USE IN cursor_4c_MoedaV
1092:                 ELSE
1093:                     loc_lEncontrado = .F.
1094:                 ENDIF
1095:             ELSE
1096:                 loc_oCnt.txt_4c_DMoeda.Value = ""
1097:             ENDIF
1098:         CATCH TO loc_oErro
1099:             IF USED("cursor_4c_MoedaV")

*-- Linhas 1152 a 1170:
1152:             loc_oBusca.Show()
1153:             IF loc_oBusca.this_lSelecionou
1154:                 IF USED("cursor_4c_BuscaGrupo")
1155:                     SELECT cursor_4c_BuscaGrupo
1156:                     loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(Codigos)
1157:                     loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(Descrs)
1158:                     THIS.AtualizarEstadoConta()
1159:                 ENDIF
1160:             ENDIF
1161:             IF USED("cursor_4c_BuscaGrupo")
1162:                 USE IN cursor_4c_BuscaGrupo
1163:             ENDIF
1164:             loc_oBusca.Release()
1165:         CATCH TO loc_oErro
1166:             MsgErro(loc_oErro.Message, "Erro")
1167:         ENDTRY
1168:     ENDPROC
1169: 
1170:     *--------------------------------------------------------------------------

*-- Linhas 1186 a 1204:
1186:             loc_oBusca.Show()
1187:             IF loc_oBusca.this_lSelecionou
1188:                 IF USED("cursor_4c_BuscaConta")
1189:                     SELECT cursor_4c_BuscaConta
1190:                     loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(IClis)
1191:                     loc_oCnt.txt_4c_DConta.Value = ALLTRIM(RClis)
1192:                     THIS.AtualizarEstadoConta()
1193:                 ENDIF
1194:             ENDIF
1195:             IF USED("cursor_4c_BuscaConta")
1196:                 USE IN cursor_4c_BuscaConta
1197:             ENDIF
1198:             loc_oBusca.Release()
1199:         CATCH TO loc_oErro
1200:             MsgErro(loc_oErro.Message, "Erro")
1201:         ENDTRY
1202:     ENDPROC
1203: 
1204:     *--------------------------------------------------------------------------

*-- Linhas 1220 a 1238:
1220:             loc_oBusca.Show()
1221:             IF loc_oBusca.this_lSelecionou
1222:                 IF USED("cursor_4c_BuscaMoeda")
1223:                     SELECT cursor_4c_BuscaMoeda
1224:                     loc_oCnt.txt_4c_Moeda.Value  = ALLTRIM(CMoes)
1225:                     loc_oCnt.txt_4c_DMoeda.Value = ALLTRIM(DMoes)
1226:                 ENDIF
1227:             ENDIF
1228:             IF USED("cursor_4c_BuscaMoeda")
1229:                 USE IN cursor_4c_BuscaMoeda
1230:             ENDIF
1231:             loc_oBusca.Release()
1232:         CATCH TO loc_oErro
1233:             MsgErro(loc_oErro.Message, "Erro")
1234:         ENDTRY
1235:     ENDPROC
1236: 
1237:     *==========================================================================
1238:     * ESTADO DOS CONTROLES


### BO (C:\4c\projeto\app\classes\SIGRECNDBO.prg):
*==============================================================================
* SIGRECNDBO.PRG
* Business Object para Relatorio: Posicao de Lancamentos Nao Conciliados
*
* Herda de RelatorioBase
* Tabela principal: SigMvCcr
* Relatorio FRX: SigReCnd.frx
*
* Filtros:
*   - Data de Referencia  (getDtInicial)
*   - Grupo               (getGrupo / getDGrupo  - C(10)/C(20))
*   - Conta               (getConta / getDConta  - C(10)/C(40))
*   - Moeda               (getMoeda / getDMoeda  - C(3)/C(15) - SigCdMoe.CMoes/DMoes)
*==============================================================================

DEFINE CLASS SIGRECNDBO AS RelatorioBase

    *-- Filtro: data de referencia
    this_dDtInicial     = {}

    *-- Filtro: grupo (Grupos em SigMvCcr, C(10))
    this_cGrupos        = ""
    this_cDGrupos       = ""

    *-- Filtro: conta (Contas em SigMvCcr, C(10))
    this_cContas        = ""
    this_cDContas       = ""

    *-- Filtro: moeda (Moedas em SigMvCcr, C(3))
    this_cMoedas        = ""
    this_cDMoedas       = ""

    *-- Nome do cursor de saida populado por PrepararDados()
    this_cCursorDados   = "TmpHist"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de lancamentos nao conciliados
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor TmpHist com lancamentos nao conciliados
    * Replica logica do PROCEDURE processamento do legado SIGRECND
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cGru, loc_cCon, loc_cMoe, loc_cWhereConta
        LOCAL loc_cCabEmpresa, loc_cTitulo, loc_cSubTitulo
        LOCAL loc_cCab, loc_nSal, loc_nVal, loc_nCt1, loc_nCt2, loc_lcDes
        LOCAL loc_oErro

        *-- Validacoes fora do TRY (podem usar RETURN diretamente)
        IF EMPTY(THIS.this_dDtInicial)
            THIS.this_cMensagemErro = "Data de Refer" + CHR(234) + "ncia inv" + CHR(225) + "lida"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cGrupos)
            THIS.this_cMensagemErro = "Grupo inv" + CHR(225) + "lido"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cMoedas)
            THIS.this_cMensagemErro = "Moeda inv" + CHR(225) + "lida"
            RETURN .F.
        ENDIF

        *-- Padronizar filtros (igual ao legado com PADR(,10))
        loc_cGru = PADR(ALLTRIM(THIS.this_cGrupos), 10)
        loc_cCon = PADR(ALLTRIM(THIS.this_cContas), 10)
        loc_cMoe = ALLTRIM(THIS.this_cMoedas)

        loc_lSucesso = .F.

        TRY
            *-- Cabecalho da empresa
            loc_cCabEmpresa = go_4c_Sistema.cCodEmpresa
            loc_cSQL = "SELECT TOP 1 Razas FROM SigCdEmp " + ;
                       "WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                IF !EOF()
                    loc_cCabEmpresa = go_4c_Sistema.cCodEmpresa + ;
                                      " - " + ALLTRIM(Razas)
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            *-- Monta subtitulo do relatorio
            loc_cTitulo    = "Posi" + CHR(231) + CHR(227) + "o de Lan" + CHR(231) + ;
                             "amentos N" + CHR(227) + "o Conciliados"
            loc_cSubTitulo = "Data Refer" + CHR(234) + "ncia : " + DTOC(THIS.this_dDtInicial) + ;
                             " - Grupo : " + ALLTRIM(loc_cGru) + ;
                             " - Conta : " + IIF(EMPTY(loc_cCon), "Todas", ALLTRIM(loc_cCon))

            *-- Cursor de cabecalho para o relatorio
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            CREATE CURSOR dbCabecalho (NomeEmpresa C(80), Titulo C(80), SubTitulo C(80), Moeda1 C(80))
            INSERT INTO dbCabecalho (NomeEmpresa, Titulo, SubTitulo, Moeda1) ;
                VALUES (loc_cCabEmpresa, loc_cTitulo, loc_cSubTitulo, loc_cMoe)

            *-- Cursor principal TmpHist (igual estrutura do legado)
            IF USED("TmpHist")
                USE IN TmpHist
            ENDIF
            CREATE CURSOR TmpHist ;
                (Audits L(1), Datas D(8), Grupos C(10), Contas C(10), RClis C(40), ;
                 Saldo1 N(12,2), Opers C(1), Hists C(40), Hist2s C(40), Emps C(3), ;
                 Debitos N(12,2), Creditos N(12,2), Docus C(10), cIdChaves C(20))
            INDEX ON Grupos + Contas + cIdChaves TAG ContData

            *-- Monta clausula WHERE para conta (opcional)
            IF !EMPTY(THIS.this_cContas)
                loc_cWhereConta = " AND Contas = " + EscaparSQL(loc_cCon)
            ELSE
                loc_cWhereConta = ""
            ENDIF

            *-- Query principal em SigMvCcr
            loc_cSQL = "SELECT Grupos, Contas, cIdChaves, CAST(Datas AS DATE) AS Datas," + ;
                       " Opers, Valors, Moedas, Docus, Emps, DtAudits, Hists, Hist2s " + ;
                       " FROM SigMvCcr" + ;
                       " WHERE Grupos = " + EscaparSQL(loc_cGru) + ;
                       loc_cWhereConta + ;
                       " AND Datas <= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                       " AND (DataConcs IS NULL OR DataConcs > " + ;
                       FormatarDataSQL(THIS.this_dDtInicial) + ")" + ;
                       " ORDER BY Grupos, Contas, cIdChaves, Datas, Opers, Valors," + ;
                       " Docus, Emps, DtAudits"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CcrDados")
            IF loc_nResult > 0
                *-- Processa registros calculando saldo acumulado e conversao de moeda
                loc_cCab = ""
                loc_nSal = 0

                SELECT cursor_4c_CcrDados
                SCAN
                    *-- Detecta quebra de grupo/conta para resetar saldo
                    IF (loc_cCab != cursor_4c_CcrDados.Grupos + cursor_4c_CcrDados.Contas)
                        loc_cCab = cursor_4c_CcrDados.Grupos + cursor_4c_CcrDados.Contas
                        loc_nSal = 0
                    ENDIF

                    *-- Busca descricao do cliente/conta em SigCdCli
                    loc_lcDes = ""
                    loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli " + ;
                               "WHERE IClis = " + EscaparSQL(ALLTRIM(cursor_4c_CcrDados.Contas))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CcrCli")
                    IF loc_nResult > 0
                        SELECT cursor_4c_CcrCli
                        IF !EOF()
                            loc_lcDes = ALLTRIM(RClis)
                        ENDIF
                        USE IN cursor_4c_CcrCli
                    ENDIF
                    SELECT cursor_4c_CcrDados

                    *-- Converte valor para moeda alvo se necessario
                    loc_nVal = cursor_4c_CcrDados.Valors
                    IF ALLTRIM(cursor_4c_CcrDados.Moedas) != ALLTRIM(loc_cMoe)
                        loc_nCt1 = THIS.BuscarCotacao(ALLTRIM(cursor_4c_CcrDados.Moedas), ;
                                                       CTOD(DTOC(cursor_4c_CcrDados.Datas)))
                        loc_nCt2 = THIS.BuscarCotacao(loc_cMoe, ;
                                                       CTOD(DTOC(cursor_4c_CcrDados.Datas)))
                        IF loc_nCt2 != 0
                            loc_nVal = (cursor_4c_CcrDados.Valors * loc_nCt1) / loc_nCt2
                        ENDIF
                    ENDIF

                    *-- Acumula saldo: C=credito(+), D=debito(-)
                    loc_nSal = loc_nSal + ;
                               (loc_nVal * IIF(ALLTRIM(cursor_4c_CcrDados.Opers) = "C", 1, -1))

                    *-- Insere linha processada no TmpHist
                    SELECT TmpHist
                    INSERT INTO TmpHist ;
                        (Audits, Datas, Grupos, Contas, RClis, Saldo1, Opers, ;
                         Hists, Hist2s, Emps, Debitos, Creditos, Docus, cIdChaves) ;
                        VALUES (!EMPTY(cursor_4c_CcrDados.DtAudits), ;
                                CTOD(DTOC(cursor_4c_CcrDados.Datas)), ;
                                cursor_4c_CcrDados.Grupos, ;
                                cursor_4c_CcrDados.Contas, ;
                                loc_lcDes, ;
                                loc_nSal, ;
                                cursor_4c_CcrDados.Opers, ;
                                ALLTRIM(NVL(cursor_4c_CcrDados.Hists, "")), ;
                                ALLTRIM(NVL(cursor_4c_CcrDados.Hist2s, "")), ;
                                cursor_4c_CcrDados.Emps, ;
                                IIF(ALLTRIM(cursor_4c_CcrDados.Opers) = "D", loc_nVal, 0), ;
                                IIF(ALLTRIM(cursor_4c_CcrDados.Opers) = "C", loc_nVal, 0), ;
                                cursor_4c_CcrDados.Docus, ;
                                cursor_4c_CcrDados.cIdChaves)
                    SELECT cursor_4c_CcrDados
                ENDSCAN

                USE IN cursor_4c_CcrDados

                *-- Posiciona TmpHist ordenado pelo indice
                SELECT TmpHist
                SET ORDER TO ContData
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao buscar dados de SigMvCcr"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime relatorio direto na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + "SigReCnd.frx"
                REPORT FORM (loc_cFrx) TO PRINTER NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComPrompt - Prepara dados e imprime com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComPrompt()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + "SigReCnd.frx"
                REPORT FORM (loc_cFrx) TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + "SigReCnd.frx"
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca cotacao da moeda para a data especificada
    * par_cMoeda: codigo da moeda (SigCdCot.cmoes)
    * par_dData:  data de referencia
    * Retorna: valor numerico da cotacao (1.0 se nao encontrada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cSQL, loc_nResult, loc_oErro
        loc_nCotacao = 1

        IF EMPTY(par_cMoeda) OR VARTYPE(par_dData) != "D" OR EMPTY(par_dData)
            RETURN 1
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot " + ;
                       "WHERE cmoes = " + EscaparSQL(par_cMoeda) + ;
                       " AND datas <= " + FormatarDataSQL(par_dData) + ;
                       " ORDER BY datas DESC"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cotacao")
            IF loc_nResult > 0
                SELECT cursor_4c_Cotacao
                IF !EOF()
                    loc_nCotacao = NVL(valos, 1)
                    IF loc_nCotacao = 0
                        loc_nCotacao = 1
                    ENDIF
                ENDIF
                USE IN cursor_4c_Cotacao
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nCotacao
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores dos FILTROS do relatorio a partir de
    * um cursor (util para restaurar "ultimo filtro usado").
    *
    * Nao carrega dados de SigMvCcr - reports nao tem registro de entidade.
    * Cada campo eh aplicado somente se existir no cursor (TYPE() check),
    * permitindo evolucao do schema do cursor sem quebrar a chamada.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                    THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                        "o dispon" + CHR(237) + "vel: " + TRANSFORM(par_cAliasCursor)
                    EXIT
                ENDIF

                loc_cAlias = ALLTRIM(par_cAliasCursor)
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de filtros vazio"
                    EXIT
                ENDIF

                *-- Data de Referencia
                IF TYPE(loc_cAlias + ".dt_inicial") = "D"
                    THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".dt_inicial")
                ENDIF

                *-- Grupo
                IF TYPE(loc_cAlias + ".cd_grupo") = "C"
                    THIS.this_cGrupos = ALLTRIM(EVALUATE(loc_cAlias + ".cd_grupo"))
                ENDIF
                IF TYPE(loc_cAlias + ".ds_grupo") = "C"
                    THIS.this_cDGrupos = ALLTRIM(EVALUATE(loc_cAlias + ".ds_grupo"))
                ENDIF

                *-- Conta
                IF TYPE(loc_cAlias + ".cd_conta") = "C"
                    THIS.this_cContas = ALLTRIM(EVALUATE(loc_cAlias + ".cd_conta"))
                ENDIF
                IF TYPE(loc_cAlias + ".ds_conta") = "C"
                    THIS.this_cDContas = ALLTRIM(EVALUATE(loc_cAlias + ".ds_conta"))
                ENDIF

                *-- Moeda
                IF TYPE(loc_cAlias + ".cd_moeda") = "C"
                    THIS.this_cMoedas = ALLTRIM(EVALUATE(loc_cAlias + ".cd_moeda"))
                ENDIF
                IF TYPE(loc_cAlias + ".ds_moeda") = "C"
                    THIS.this_cDMoedas = ALLTRIM(EVALUATE(loc_cAlias + ".ds_moeda"))
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorios nao persistem dados.
    *
    * Override defensivo: caso o BO seja usado por engano como CRUD, retorna
    * erro explicito ao inves de corromper o banco. O form legado SIGRECND
    * nao tinha botao "Incluir" - apenas Imprimir/Visualizar/Cancelar.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de Lan" + CHR(231) + "amentos N" + CHR(227) + ;
            "o Conciliados n" + CHR(227) + "o grava registros." + CHR(13) + ;
            "Use PrepararDados() seguido de Imprimir() ou Visualizar()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorios nao persistem dados.
    *
    * Override defensivo: simetrico a Inserir(). Reports nao modificam SigMvCcr;
    * apenas extraem dados via SELECT em PrepararDados() para gerar o TmpHist.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de Lan" + CHR(231) + "amentos N" + CHR(227) + ;
            "o Conciliados n" + CHR(227) + "o altera registros." + CHR(13) + ;
            "Use PrepararDados() seguido de Imprimir() ou Visualizar()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria de entidade.
    * Retorna composicao dos filtros usados como "identidade" da execucao.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""

        IF !EMPTY(THIS.this_dDtInicial)
            loc_cChave = DTOC(THIS.this_dDtInicial)
        ENDIF
        IF !EMPTY(THIS.this_cGrupos)
            loc_cChave = loc_cChave + "|" + ALLTRIM(THIS.this_cGrupos)
        ENDIF
        IF !EMPTY(THIS.this_cContas)
            loc_cChave = loc_cChave + "|" + ALLTRIM(THIS.this_cContas)
        ENDIF
        IF !EMPTY(THIS.this_cMoedas)
            loc_cChave = loc_cChave + "|" + ALLTRIM(THIS.this_cMoedas)
        ENDIF

        RETURN loc_cChave
    ENDPROC

ENDDEFINE

