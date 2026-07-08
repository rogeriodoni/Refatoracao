# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 393: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg) - TRECHOS RELEVANTES PARA PASS GRID (2725 linhas total):

*-- Linhas 374 a 467:
374:             .Visible   = .T.
375:         ENDWITH
376:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DtFinal, "LostFocus", THIS, "DtFinalLostFocus")
377: 
378:         *-- Cursor placeholder para o Grid (SET NULL ON para aceitar NULLs do SQL Server)
379:         SET NULL ON
380:         CREATE CURSOR cursor_4c_Dados ( ;
381:             Emps    C(3),  Nopers N(9,0), Datas  T,      Opers   C(1), ;
382:             Contas  C(10), Scontas C(10), Hists  C(40),  Valors  N(14,2), ;
383:             Svalors N(14,2), Nfs C(15),   Docus  C(20), ;
384:             Grupos  C(10), Sgrupos C(10), Moedas C(3),   Smoedas C(3), ;
385:             Hist2s  C(40), Shists  C(40))
386:         SET NULL OFF
387: 
388:         *-- Grid de lista de lancamentos (Top = 114 + 36 = 150)
389:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
390:         loc_oGrid = loc_oPagina.grd_4c_Lista
391: 
392:         *-- CRITICO: RecordSource e ColumnCount FORA do WITH para criar colunas imediatamente
393:         loc_oGrid.RecordSource = "cursor_4c_Dados"
394:         loc_oGrid.ColumnCount  = 9
395: 
396:         WITH loc_oGrid
397:             .Top           = 150
398:             .Left          = 0
399:             .Width         = 1003
400:             .Height        = 448
401:             .GridLines     = 3
402:             .GridLineWidth = 1
403:             .GridColor     = RGB(200, 200, 200)
404:             .DeleteMark    = .F.
405:             .RecordMark    = .F.
406:             .Scrollbars    = 3
407:             .FontName      = "Tahoma"
408:             .FontSize      = 8
409:             .Visible       = .T.
410:         ENDWITH
411: 
412:         *-- OBRIGATORIO: ControlSources APOS RecordSource
413:         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Datas"
414:         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Opers"
415:         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Contas"
416:         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Scontas"
417:         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Hists"
418:         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.Valors"
419:         loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.Svalors"
420:         loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.Nfs"
421:         loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.Docus"
422: 
423:         *-- Larguras das colunas
424:         loc_oGrid.Column1.Width = 80
425:         loc_oGrid.Column2.Width = 20
426:         loc_oGrid.Column3.Width = 100
427:         loc_oGrid.Column4.Width = 100
428:         loc_oGrid.Column5.Width = 250
429:         loc_oGrid.Column6.Width = 90
430:         loc_oGrid.Column7.Width = 90
431:         loc_oGrid.Column8.Width = 65
432:         loc_oGrid.Column9.Width = 100
433: 
434:         *-- OBRIGATORIO: Headers APOS RecordSource
435:         loc_oGrid.Column1.Header1.Caption = "Data"
436:         loc_oGrid.Column2.Header1.Caption = "O"
437:         loc_oGrid.Column3.Header1.Caption = "Conta"
438:         loc_oGrid.Column4.Header1.Caption = "Contrapartida"
439:         loc_oGrid.Column5.Header1.Caption = "Hist" + CHR(243) + "rico"
440:         loc_oGrid.Column6.Header1.Caption = "D" + CHR(233) + "bito"
441:         loc_oGrid.Column7.Header1.Caption = "Cr" + CHR(233) + "dito"
442:         loc_oGrid.Column8.Header1.Caption = "NF"
443:         loc_oGrid.Column9.Header1.Caption = "Documento"
444: 
445:         *-- Alinhamento de valores numericos
446:         loc_oGrid.Column6.Alignment = 1
447:         loc_oGrid.Column7.Alignment = 1
448: 
449:         THIS.FormatarGridLista(loc_oGrid)
450:         THIS.TornarControlesVisiveis(loc_oPagina)
451:     ENDPROC
452: 
453:     *--------------------------------------------------------------------------
454:     * ConfigurarPaginaDados - Configura Page2 (Dados)
455:     * Fase 5: Todos os campos, shapes, labels, lookups e validacoes
456:     * Posicoes do layout.json usadas diretamente (PageFrame.Top=-29 identico ao legado)
457:     *--------------------------------------------------------------------------
458:     PROTECTED PROCEDURE ConfigurarPaginaDados()
459:         LOCAL loc_oPagina
460:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
461: 
462:         *======================================================================
463:         *-- CONTAINER DE BOTOES (Confirmar/Cancelar) - Top=29 => screen y=0
464:         *======================================================================
465:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
466:         WITH loc_oPagina.cnt_4c_BotoesAcao
467:             .Top           = 29

*-- Linhas 1141 a 1211:
1141:                     loc_cFiltro = " AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF
1142:                 ENDIF
1143: 
1144:                 *-- Montar SELECT (colunas identicas ao CREATE CURSOR placeholder)
1145:                 loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Opers," + ;
1146:                     " a.Contas, a.Scontas, a.Hists, a.Valors, a.Svalors," + ;
1147:                     " a.Nfs, a.Docus, a.Grupos, a.Sgrupos, a.Moedas," + ;
1148:                     " a.Smoedas, a.Hist2s, a.Shists" + ;
1149:                     " FROM SigMvCcr a" + ;
1150:                     " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1151:                     loc_cFiltro + ;
1152:                     " ORDER BY a.Datas DESC, a.Nopers DESC"
1153: 
1154:                 *-- SQLEXEC em cursor TEMPORARIO para preservar colunas do Grid
1155:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")
1156:                 IF loc_nResultado >= 0
1157:                     SELECT cursor_4c_Dados
1158:                     ZAP
1159:                     IF RECCOUNT("cursor_4c_DadosTemp") > 0
1160:                         APPEND FROM DBF("cursor_4c_DadosTemp")
1161:                     ENDIF
1162:                     IF USED("cursor_4c_DadosTemp")
1163:                         USE IN cursor_4c_DadosTemp
1164:                     ENDIF
1165:                     GO TOP IN cursor_4c_Dados
1166: 
1167:                     *-- Obter referencia ao grid e reconfigurar Headers
1168:                     IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Lista") = "O"
1169:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1170: 
1171:                         *-- Reconfigurar ControlSources (OBRIGATORIO apos carregar)
1172:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Datas"
1173:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Opers"
1174:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Contas"
1175:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Scontas"
1176:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Hists"
1177:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.Valors"
1178:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.Svalors"
1179:                         loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.Nfs"
1180:                         loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.Docus"
1181: 
1182:                         *-- Reconfigurar Headers (OBRIGATORIO apos RecordSource/ControlSource)
1183:                         loc_oGrid.Column1.Header1.Caption = "Data"
1184:                         loc_oGrid.Column2.Header1.Caption = "O"
1185:                         loc_oGrid.Column3.Header1.Caption = "Conta"
1186:                         loc_oGrid.Column4.Header1.Caption = "Contrapartida"
1187:                         loc_oGrid.Column5.Header1.Caption = "Hist" + CHR(243) + "rico"
1188:                         loc_oGrid.Column6.Header1.Caption = "D" + CHR(233) + "bito"
1189:                         loc_oGrid.Column7.Header1.Caption = "Cr" + CHR(233) + "dito"
1190:                         loc_oGrid.Column8.Header1.Caption = "NF"
1191:                         loc_oGrid.Column9.Header1.Caption = "Documento"
1192: 
1193:                         loc_oGrid.Refresh()
1194:                     ENDIF
1195: 
1196:                     loc_lResultado = .T.
1197:                 ELSE
1198:                     IF USED("cursor_4c_DadosTemp")
1199:                         USE IN cursor_4c_DadosTemp
1200:                     ENDIF
1201:                     MsgErro("Erro ao buscar lan" + CHR(231) + "amentos:" + CHR(13) + ;
1202:                         CapturarErroSQL(), "Erro SQL")
1203:                 ENDIF
1204:             ENDIF
1205:         CATCH TO loException
1206:             IF USED("cursor_4c_DadosTemp")
1207:                 USE IN cursor_4c_DadosTemp
1208:             ENDIF
1209:             MsgErro("Erro em CarregarLista: " + loException.Message, "Erro")
1210:             loc_lResultado = .F.
1211:         ENDTRY

*-- Linhas 1674 a 1699:
1674:             "Busca de Grupos - Conta Corrente", .F., .F., loc_cFiltroEmps)
1675: 
1676:         IF VARTYPE(loc_oBusca) = "O"
1677:             *-- mAddColuna(campo, mascara, titulo) - 3 params, todos strings
1678:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1679:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1680:             loc_oBusca.Show()
1681: 
1682:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1683:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1684:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1685: 
1686:                 IF !par_lSide
1687:                     IF TYPE("loc_oPg2.txt_4c_Grupo") = "O"
1688:                         loc_oPg2.txt_4c_Grupo.Value = loc_cCodigo
1689:                     ENDIF
1690:                     IF TYPE("loc_oPg2.txt_4c_Dgrupo") = "O"
1691:                         loc_oPg2.txt_4c_Dgrupo.Value = loc_cDescricao
1692:                     ENDIF
1693:                 ELSE
1694:                     IF TYPE("loc_oPg2.txt_4c_SGRUPO") = "O"
1695:                         loc_oPg2.txt_4c_SGRUPO.Value = loc_cCodigo
1696:                     ENDIF
1697:                     IF TYPE("loc_oPg2.txt_4c_Sdgrupo") = "O"
1698:                         loc_oPg2.txt_4c_Sdgrupo.Value = loc_cDescricao
1699:                     ENDIF

*-- Linhas 1830 a 1855:
1830:         IF VARTYPE(loc_oBusca) = "O"
1831:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
1832: 
1833:             *-- mAddColuna(campo, mascara, titulo) - 3 strings
1834:             loc_oBusca.mAddColuna("Contas", "", "Conta")
1835:             loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1836: 
1837:             loc_oBusca.Show()
1838: 
1839:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1840:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaConta.Contas)
1841:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaConta.Descrs)
1842: 
1843:                 IF TYPE("loc_oPg2." + loc_cTxtCod) = "O"
1844:                     loc_oPg2.Controls(loc_cTxtCod).Value  = loc_cCodigo
1845:                     loc_oPg2.Controls(loc_cTxtDesc).Value = loc_cDescricao
1846:                 ENDIF
1847:             ENDIF
1848: 
1849:             loc_oBusca.Release()
1850:             loc_oBusca = .NULL.
1851:         ENDIF
1852: 
1853:         IF USED("cursor_4c_BuscaConta")
1854:             USE IN cursor_4c_BuscaConta
1855:         ENDIF

*-- Linhas 2022 a 2046:
2022:             "Moedas")
2023: 
2024:         IF VARTYPE(loc_oBusca) = "O"
2025:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "d")
2026:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2027:             loc_oBusca.Show()
2028: 
2029:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
2030:                 loc_cCodigo = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
2031: 
2032:                 IF TYPE("loc_oPg2." + loc_cTxtMoeda) = "O"
2033:                     loc_oPg2.Controls(loc_cTxtMoeda).Value = loc_cCodigo
2034:                 ENDIF
2035: 
2036:                 *-- Ao selecionar moeda, buscar cotacao atual
2037:                 THIS.AtualizarCotacaoParaMoeda(loc_cCodigo, loc_cTxtCotacao, par_lSide)
2038:             ENDIF
2039: 
2040:             loc_oBusca.Release()
2041:             loc_oBusca = .NULL.
2042:         ENDIF
2043: 
2044:         IF USED("cursor_4c_BuscaMoeda")
2045:             USE IN cursor_4c_BuscaMoeda
2046:         ENDIF


### BO (C:\4c\projeto\app\classes\sigmvccrBO.prg):
*==============================================================================
* sigmvccrBO.prg - Business Object para Conta Corrente Geral
* Tabela: SigMvCcr
* Fase 1/8: Propriedades e Init()
*==============================================================================

DEFINE CLASS sigmvccrBO AS BusinessBase

    *-- Chave primaria composta: Emps + Nopers (cidchaves = chave unica gerada)
    this_cEmps        = ""    && Empresa (3)
    this_nNopers      = 0     && Numero da operacao (PK numerico)
    this_cCidChaves   = ""    && Chave unica gerada (cidchaves C20)

    *-- Datas
    this_dDatas       = {}    && Data do lancamento
    this_dVencs       = {}    && Vencimento
    this_dDtemis      = {}    && Data de emissao (dtemis)
    this_dDatAlts     = {}    && Data de alteracao (datalts)
    this_dDatExcs     = {}    && Data de exclusao (datexcs)
    this_dDatatrans   = {}    && Data de transacao

    *-- Movimento debito (lado esquerdo - Get_grupo/Get_conta)
    this_cOpers       = ""    && Operacao D/C (opers)
    this_cGrupos      = ""    && Grupo conta corrente debito (grupos)
    this_cContas      = ""    && Conta corrente debito (contas)
    this_cMoedas      = ""    && Moeda (moedas)
    this_nCotacaos    = 0     && Cotacao (cotacaos)
    this_nValors      = 0     && Valor (valors)
    this_cCotUsus     = ""    && Cotacao usurio - alteracao manual (cotusus)

    *-- Movimento credito/contrapartida (lado direito - Get_sgrupo/Get_sconta)
    this_cSOpers      = ""    && Operacao contrapartida D/C (sopers)
    this_cSGrupos     = ""    && Grupo conta corrente credito (sgrupos)
    this_cSContas     = ""    && Conta corrente credito (scontas)
    this_cSMoedas     = ""    && Moeda contrapartida (smoedas)
    this_nSCotacaos   = 0     && Cotacao contrapartida (scotacaos)
    this_nSValors     = 0     && Valor contrapartida (svalors)

    *-- Identificacao do lancamento
    this_cNfs         = ""    && Nota fiscal (nfs)
    this_cDocus       = ""    && Documento (docus)
    this_cHists       = ""    && Historico (hists)
    this_cHist2s      = ""    && Historico complementar (hist2s)
    this_cShists      = ""    && Historico contrapartida (shists)
    this_cUsualts     = ""    && Usuario do lancamento (usualts)
    this_cUsuExcs     = ""    && Usuario de exclusao (usuexcs)
    this_nContaPgs    = 0     && Tipo conta pagamento - opcao_conta (contapgs)

    *-- Job (centro de custo)
    this_cJobs        = ""    && Codigo do job (jobs)

    *-- Controle interno e auditoria
    this_lAutos       = .F.   && Flag de processamento automatico (autos)
    this_cGruConMoes  = ""    && Chave composta grupos+contas+moedas (gruconmoes)
    this_nNumes       = 0     && Numero (numes)
    this_cDopcs       = ""    && Documento contrapartida (dopcs)
    this_nNumcs       = 0     && Numero contrapartida (numcs)
    this_cVOpers      = ""    && Codigo operacao com empresa (vopers)
    this_cDopes       = ""    && Codigo do tipo de operacao (dopes)
    this_nNtrans      = 0     && Numero de transacao (ntrans)
    this_nNlancs      = 0     && Numero de lancamento (nlancs)

    *-- Conciliacao
    this_nConcs       = 0     && Flag conciliado (concs)
    this_dDataConcs   = {}    && Data de conciliacao (dataconcs)
    this_cUsuConcs    = ""    && Usuario conciliacao (usuconcs)

    *-- Saldos calculados (somente leitura na grade)
    this_nSaldos      = 0     && Saldo (saldos)
    this_nValLiqs     = 0     && Valor liquido (valliqs)
    this_nValPags     = 0     && Valor pago (valpags)
    this_nValPrev     = 0     && Valor previsto (valprev)
    this_nValOcurs    = 0     && Valor em outra moeda (valocurs)

    *-- Campos adicionais da tabela
    this_cTipos       = ""    && Tipo (tipos)
    this_cTitulos     = ""    && Titulo (titulos)
    this_cTitBans     = ""    && Titulo bancario (titbans)
    this_cLocals      = ""    && Local (locals)
    this_cGrupAges    = ""    && Grupo agencia (grupages)
    this_cGrupEms     = ""    && Grupo empresa (grupems)
    this_cContAges    = ""    && Conta agencia (contages)
    this_cContEms     = ""    && Conta empresa (contems)
    this_cBContas     = ""    && B contas (bcontas)
    this_cBGrupos     = ""    && B grupos (bgrupos)
    this_cBorderos    = ""    && Borderdo (borderos)
    this_nIntConts    = 0     && Integracao contabil (intconts)
    this_cAuditors    = ""    && Auditor (auditors)
    this_dDtAudits    = {}    && Data auditoria (dtaudits)
    this_cEmpDopNcs   = ""    && Empresa+doc+nc (empdopncs)
    this_nEmpDopNums  = 0     && Empresa+doc+num (empdopnums)
    this_nPagos       = 0     && Pago flag (pagos)
    this_cDopotps     = ""    && Tipo pagamento (dopotps)
    this_cUsuPagos    = ""    && Usuario pagamento (usupagos)
    this_cTitCancs    = ""    && Titulo cancelado (titcancs)
    this_dDtConfs     = {}    && Data confirmacao (dtconfs)
    this_cUsuConfs    = ""    && Usuario confirmacao (usuconfs)
    this_nNOperCancs  = 0     && Numero operacao cancelada (nopercancs)
    this_cEspecieNfs  = ""    && Especie nota fiscal (especienfs)
    this_nImpostos    = 0     && Impostos (impostos)
    this_cTpImpostos  = ""    && Tipo impostos (tpimpostos)
    this_cTitPais     = ""    && Titulo pais (titpais)
    this_cEmpCcs      = ""    && Empresa conta corrente (empccs)
    this_nRecor       = 0     && Recorrencia (recor)
    this_cCompet      = ""    && Competencia (compet)
    this_cEmpos       = ""    && Empresa origem (empos)
    this_nOriDopNums  = 0     && Origem documento num (oridopnums)
    this_cRContas     = ""    && Rota contas (rcontas)
    this_cTpDocNf     = ""    && Tipo documento NF (tpdocnf)
    this_nSaldocs     = 0     && Saldo documentos (saldocs)
    this_nSaldons     = 0     && Saldo notas (saldons)
    this_nVlancs      = 0     && Valor lancamentos (vlancs)

    *===========================================================================
    PROCEDURE Init()
    *===========================================================================
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = "Nopers"
        RETURN .T.
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
    *===========================================================================
    * Retorna identificador para auditoria (empresa + numero operacao)
        RETURN ALLTRIM(THIS.this_cEmps) + "-" + TRANSFORM(THIS.this_nNopers)
    ENDPROC

    *===========================================================================
    PROCEDURE Buscar(par_cFiltro)
    *===========================================================================
    *-- Busca lancamentos por empresa e filtro adicional (ex: periodo de datas)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Opers, a.Grupos, a.Contas," + ;
                " a.Moedas, a.Cotacaos, a.Valors, a.Hists, a.Hist2s, a.Shists," + ;
                " a.Nfs, a.Docus, a.Sgrupos, a.Scontas, a.Smoedas, a.Scotacaos," + ;
                " a.Svalors, a.Sopers, a.Vencs, a.Dtemis, a.Usualts, a.Jobs," + ;
                " a.Contapgs, a.Concs, a.Dataconcs, a.Usuconcs, a.Datalts," + ;
                " a.Dopes, a.Numes, a.Dopcs, a.Numcs, a.Vopers, a.CidChaves," + ;
                " a.Autos, a.GruConMoes, a.Ntrans, a.Nlancs, a.CotUsus" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Datas, a.Nopers"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar lan" + CHR(231) + "amentos:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    PROCEDURE CarregarPorCodigo(par_nNopers)
    *===========================================================================
    *-- Carrega lancamento pelo numero de operacao (Nopers)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Opers, a.Grupos, a.Contas," + ;
                " a.Moedas, a.Cotacaos, a.Valors, a.Hists, a.Hist2s, a.Shists," + ;
                " a.Nfs, a.Docus, a.Sgrupos, a.Scontas, a.Smoedas, a.Scotacaos," + ;
                " a.Svalors, a.Sopers, a.Vencs, a.Dtemis, a.Usualts, a.Jobs," + ;
                " a.Contapgs, a.Concs, a.Dataconcs, a.Usuconcs, a.Datalts," + ;
                " a.Dopes, a.Numes, a.Dopcs, a.Numcs, a.Vopers, a.CidChaves," + ;
                " a.Autos, a.GruConMoes, a.Ntrans, a.Nlancs, a.CotUsus" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND a.Nopers = " + TRANSFORM(par_nNopers)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *===========================================================================
    *-- Mapeia campos do cursor para propriedades this_*
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmps       = TratarNulo(Emps, "C")
            THIS.this_nNopers     = TratarNulo(Nopers, "N")
            THIS.this_dDatas      = IIF(ISNULL(Datas)  .OR. EMPTY(Datas),  {}, TTOD(Datas))
            THIS.this_dVencs      = IIF(ISNULL(Vencs)  .OR. EMPTY(Vencs),  {}, TTOD(Vencs))
            THIS.this_dDtemis     = IIF(ISNULL(Dtemis) .OR. EMPTY(Dtemis), {}, TTOD(Dtemis))
            THIS.this_cOpers      = TratarNulo(Opers, "C")
            THIS.this_cGrupos     = TratarNulo(Grupos, "C")
            THIS.this_cContas     = TratarNulo(Contas, "C")
            THIS.this_cMoedas     = TratarNulo(Moedas, "C")
            THIS.this_nCotacaos   = TratarNulo(Cotacaos, "N")
            THIS.this_nValors     = TratarNulo(Valors, "N")
            THIS.this_cSOpers     = TratarNulo(Sopers, "C")
            THIS.this_cSGrupos    = TratarNulo(Sgrupos, "C")
            THIS.this_cSContas    = TratarNulo(Scontas, "C")
            THIS.this_cSMoedas    = TratarNulo(Smoedas, "C")
            THIS.this_nSCotacaos  = TratarNulo(Scotacaos, "N")
            THIS.this_nSValors    = TratarNulo(Svalors, "N")
            THIS.this_cNfs        = TratarNulo(Nfs, "C")
            THIS.this_cDocus      = TratarNulo(Docus, "C")
            THIS.this_cHists      = TratarNulo(Hists, "C")
            THIS.this_cHist2s     = TratarNulo(Hist2s, "C")
            THIS.this_cShists     = TratarNulo(Shists, "C")
            THIS.this_cUsualts    = TratarNulo(Usualts, "C")
            THIS.this_cJobs       = TratarNulo(Jobs, "C")
            THIS.this_nContaPgs   = TratarNulo(Contapgs, "N")
            THIS.this_nConcs      = TratarNulo(Concs, "N")
            THIS.this_cGruConMoes = TratarNulo(GruConMoes, "C")
            THIS.this_cCidChaves  = TratarNulo(CidChaves, "C")
            THIS.this_lAutos      = (IIF(VARTYPE(Autos) = "L", Autos, (IIF(VARTYPE(Autos) = "L", Autos, (NVL(Autos, 0) = 1)))))
            THIS.this_cDopes      = TratarNulo(Dopes, "C")
            THIS.this_nNumes      = TratarNulo(Numes, "N")
            THIS.this_cDopcs      = TratarNulo(Dopcs, "C")
            THIS.this_nNumcs      = TratarNulo(Numcs, "N")
            THIS.this_cVOpers     = TratarNulo(Vopers, "C")
            THIS.this_nNtrans     = TratarNulo(Ntrans, "N")
            THIS.this_nNlancs     = TratarNulo(Nlancs, "N")
            THIS.this_cCotUsus    = TratarNulo(CotUsus, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE Inserir()
    *===========================================================================
    *-- Insere novo lancamento em SigMvCcr gerando Nopers sequencial
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        LOCAL loc_nProxNopers, loc_cCidChaves, loc_cGruConMoes
        LOCAL loc_cDataLanc, loc_cDataVenc, loc_cDataEmis
        loc_lResultado = .F.
        loc_nProxNopers = 0

        TRY
            *-- 1. Obter proximo Nopers para a empresa
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(Nopers), 0) + 1 AS ProxNopers" + ;
                " FROM SigMvCcr WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                "cursor_4c_ProxN")
            IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_ProxN") = 0
                MsgErro("Erro ao gerar n" + CHR(250) + "mero de opera" + CHR(231) + CHR(227) + "o.", "Erro")
            ELSE
                SELECT cursor_4c_ProxN
                loc_nProxNopers = cursor_4c_ProxN.ProxNopers
                USE IN cursor_4c_ProxN

                THIS.this_nNopers    = loc_nProxNopers
                THIS.this_cEmps      = go_4c_Sistema.cCodEmpresa
                THIS.this_cUsualts   = gc_4c_UsuarioLogado
                THIS.this_lAutos     = .F.

                *-- 2. Calcular campos derivados (padrao do legado)
                THIS.this_cGruConMoes = ALLTRIM(THIS.this_cGrupos) + ;
                    ALLTRIM(THIS.this_cContas) + ALLTRIM(THIS.this_cMoedas)
                THIS.this_cCidChaves  = DTOS(THIS.this_dDatas) + ;
                    TRANSFORM(loc_nProxNopers, "@L 999999")

                *-- 3. Formatar datas para SQL
                loc_cDataLanc = IIF(EMPTY(THIS.this_dDatas), "NULL", ;
                    "'" + DTOS(THIS.this_dDatas) + "'")
                loc_cDataVenc = IIF(EMPTY(THIS.this_dVencs), "NULL", ;
                    "'" + DTOS(THIS.this_dVencs) + "'")
                loc_cDataEmis = IIF(EMPTY(THIS.this_dDtemis), "NULL", ;
                    "'" + DTOS(THIS.this_dDtemis) + "'")

                *-- 4. Montar INSERT
                loc_cSQL = "INSERT INTO SigMvCcr (" + ;
                    "Emps, Nopers, CidChaves, Datas, Vencs, Dtemis," + ;
                    " Opers, Grupos, Contas, Moedas, Cotacaos, Valors," + ;
                    " Sopers, Sgrupos, Scontas, Smoedas, Scotacaos, Svalors," + ;
                    " Nfs, Docus, Hists, Hist2s, Shists, Usualts, Jobs," + ;
                    " Contapgs, GruConMoes, Autos, Datalts, CotUsus) VALUES (" + ;
                    EscaparSQL(THIS.this_cEmps) + "," + ;
                    TRANSFORM(THIS.this_nNopers) + "," + ;
                    EscaparSQL(THIS.this_cCidChaves) + "," + ;
                    loc_cDataLanc + "," + ;
                    loc_cDataVenc + "," + ;
                    loc_cDataEmis + "," + ;
                    EscaparSQL(THIS.this_cOpers) + "," + ;
                    EscaparSQL(THIS.this_cGrupos) + "," + ;
                    EscaparSQL(THIS.this_cContas) + "," + ;
                    EscaparSQL(THIS.this_cMoedas) + "," + ;
                    FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                    FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                    EscaparSQL(THIS.this_cSOpers) + "," + ;
                    EscaparSQL(THIS.this_cSGrupos) + "," + ;
                    EscaparSQL(THIS.this_cSContas) + "," + ;
                    EscaparSQL(THIS.this_cSMoedas) + "," + ;
                    FormatarNumeroSQL(THIS.this_nSCotacaos) + "," + ;
                    FormatarNumeroSQL(THIS.this_nSValors) + "," + ;
                    EscaparSQL(THIS.this_cNfs) + "," + ;
                    EscaparSQL(THIS.this_cDocus) + "," + ;
                    EscaparSQL(THIS.this_cHists) + "," + ;
                    EscaparSQL(THIS.this_cHist2s) + "," + ;
                    EscaparSQL(THIS.this_cShists) + "," + ;
                    EscaparSQL(THIS.this_cUsualts) + "," + ;
                    EscaparSQL(THIS.this_cJobs) + "," + ;
                    TRANSFORM(THIS.this_nContaPgs) + "," + ;
                    EscaparSQL(THIS.this_cGruConMoes) + "," + ;
                    IIF(THIS.this_lAutos, "1", "0") + "," + ;
                    "GETDATE()," + ;
                    EscaparSQL(THIS.this_cCotUsus) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir lan" + CHR(231) + "amento:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Inserir: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ProxN")
            USE IN cursor_4c_ProxN
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE Atualizar()
    *===========================================================================
    *-- Atualiza lancamento existente em SigMvCcr
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        LOCAL loc_cDataLanc, loc_cDataVenc, loc_cDataEmis
        loc_lResultado = .F.

        TRY
            *-- Recalcular campos derivados
            THIS.this_cGruConMoes = ALLTRIM(THIS.this_cGrupos) + ;
                ALLTRIM(THIS.this_cContas) + ALLTRIM(THIS.this_cMoedas)

            *-- Formatar datas
            loc_cDataLanc = IIF(EMPTY(THIS.this_dDatas), "NULL", ;
                "'" + DTOS(THIS.this_dDatas) + "'")
            loc_cDataVenc = IIF(EMPTY(THIS.this_dVencs), "NULL", ;
                "'" + DTOS(THIS.this_dVencs) + "'")
            loc_cDataEmis = IIF(EMPTY(THIS.this_dDtemis), "NULL", ;
                "'" + DTOS(THIS.this_dDtemis) + "'")

            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                " Datas = "      + loc_cDataLanc + "," + ;
                " Vencs = "      + loc_cDataVenc + "," + ;
                " Dtemis = "     + loc_cDataEmis + "," + ;
                " Opers = "      + EscaparSQL(THIS.this_cOpers) + "," + ;
                " Grupos = "     + EscaparSQL(THIS.this_cGrupos) + "," + ;
                " Contas = "     + EscaparSQL(THIS.this_cContas) + "," + ;
                " Moedas = "     + EscaparSQL(THIS.this_cMoedas) + "," + ;
                " Cotacaos = "   + FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                " Valors = "     + FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                " Sopers = "     + EscaparSQL(THIS.this_cSOpers) + "," + ;
                " Sgrupos = "    + EscaparSQL(THIS.this_cSGrupos) + "," + ;
                " Scontas = "    + EscaparSQL(THIS.this_cSContas) + "," + ;
                " Smoedas = "    + EscaparSQL(THIS.this_cSMoedas) + "," + ;
                " Scotacaos = "  + FormatarNumeroSQL(THIS.this_nSCotacaos) + "," + ;
                " Svalors = "    + FormatarNumeroSQL(THIS.this_nSValors) + "," + ;
                " Nfs = "        + EscaparSQL(THIS.this_cNfs) + "," + ;
                " Docus = "      + EscaparSQL(THIS.this_cDocus) + "," + ;
                " Hists = "      + EscaparSQL(THIS.this_cHists) + "," + ;
                " Hist2s = "     + EscaparSQL(THIS.this_cHist2s) + "," + ;
                " Shists = "     + EscaparSQL(THIS.this_cShists) + "," + ;
                " Jobs = "       + EscaparSQL(THIS.this_cJobs) + "," + ;
                " Contapgs = "   + TRANSFORM(THIS.this_nContaPgs) + "," + ;
                " GruConMoes = " + EscaparSQL(THIS.this_cGruConMoes) + "," + ;
                " CotUsus = "    + EscaparSQL(THIS.this_cCotUsus) + "," + ;
                " Datalts = GETDATE()" + ;
                " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND Nopers = " + TRANSFORM(THIS.this_nNopers)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar lan" + CHR(231) + "amento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *===========================================================================
    *-- Exclui lancamento: marca DatExcs/UsuExcs e depois deleta fisicamente
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- 1. Marcar data/usuario de exclusao (padrao do legado)
            loc_cSQL = "UPDATE SigMvCcr" + ;
                " SET DatExcs = GETDATE(), UsuExcs = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND Nopers = " + TRANSFORM(THIS.this_nNopers)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                *-- 2. Excluir fisicamente o registro
                loc_cSQL = "DELETE FROM SigMvCcr" + ;
                    " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                    " AND Nopers = " + TRANSFORM(THIS.this_nNopers)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir lan" + CHR(231) + "amento:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao marcar exclus" + CHR(227) + "o:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

