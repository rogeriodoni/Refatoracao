# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LITERA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS

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
  DeleteMark = .F.
  Column1.ControlSource = ""
		lcQuery = [Select a.Titulos, a.Vencs, a.Valors, a.Moedas, a.Hists, a.Grupos, ] + ;
					[From SigMvCcr a ] + ;
					[Left Join SigCdGcr b On a.Grupos = b.Codigos ] + ;
					[Left Join SigCdCli c On a.Contas = c.IClis ] + ;
					[join SigOpCdi d on d.dopes = a.dopes ] + ;
		If (.poDataMgr.SqlExecute(lcQuery, [LocalTits]) < 1)
		Select LocalTits
			.Column1.ControlSource = [LocalTits.Titulos]
			.Column2.ControlSource = [Ttod(LocalTits.Vencs)]
			.Column3.ControlSource = [LocalTits.Valors]
			.Column4.ControlSource = [LocalTits.Moedas]
			.Column5.ControlSource = [LocalTits.Hists]
			.Column6.ControlSource = [LocalTits.Grupos]
			.Column7.ControlSource = [LocalTits.Contas]
			.Column8.ControlSource = [LocalTits.Opers]

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGMVTI2.prg) - TRECHOS RELEVANTES PARA PASS SQL (805 linhas total):

*-- Linhas 64 a 86:
64: * nao a excecao.
65: *
66: * ColumnCount=8,
67: * ControlSource, Header1.Caption e Column.Width sao transcricao literal de
68: * SECAO 2 (sigmvtit.grdTitulos.Column1..8) e do bind em SECAO 3
69: * (With .grdTitulos / .RecordSource=[LocalTits] / .ColumnN.ControlSource).
70: * O cursor_4c_Dados criado aqui e' placeholder (mesma estrutura/ordem de
71: * campos que SIGMVTI2BO.BuscarTitulosGerados popula via SQLEXEC) - dados
72: * reais + Column1-7.When (bloqueio de edicao, comportamento.json) +
73: * AfterRowColChange ficam para as Fases 7-8, conforme a nota da Fase 3.
74: *
75: * FASE 8/8 - Consolidacao final: chamador registrado em menu.prg
76: * (popMovimentos, PROCEDURE AbrirFormSIGMVTI2 - o Init legado nao recebe
77: * parametro nenhum, calcula pDtI/pDtF sozinho a partir do momento da
78: * abertura, e por isso este dialogo abre como item de menu autonomo, ao
79: * contrario de FormSigMvMen/FormSigMvExp que sao chamados de dentro da
80: * validacao de outro form com parametro explicito).
81: *
82: * Load legado ("=fConfigGeral()", SECAO 3 do dump / comportamento.json
83: * metodo #2) NAO PORTADO, pelo mesmo motivo ja registrado em
84: * FormSigMvExp.prg/FormSigMvMen.prg (task570): fConfigGeral era funcao
85: * GLOBAL de inicializacao da aplicacao legado, e na arquitetura nova esse
86: * papel eh do start\config.prg, que roda uma vez no startup. O wrapper

*-- Linhas 153 a 172:
153: 
154:                 THIS.TornarControlesVisiveis(THIS)
155: 
156:                 *-- Carga da grade: trecho final do Init legado (SqlExecute +
157:                 *-- "Select LocalTits" / "Goto Top In LocalTits" + bind das
158:                 *-- colunas + .Refresh). O legado faz "Return .f." quando a
159:                 *-- consulta falha e a tela NAO chega a abrir - mantido fiel
160:                 *-- (BuscarTitulosGerados ja exibe o "Favor Reinicializar o
161:                 *-- Processo!!!" do legado antes de devolver .F.).
162:                 *-- Em validacao de UI / modo teste nao existe conexao SQL,
163:                 *-- entao a carga eh pulada e o form abre so' com o layout.
164:                 IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
165:                    (TYPE("gb_4c_ModoTeste")   != "L" OR !gb_4c_ModoTeste)
166:                     loc_lSucesso = THIS.CarregarLista()
167:                 ELSE
168:                     loc_lSucesso = .T.
169:                 ENDIF
170:             ENDIF
171:         CATCH TO loc_oErro
172:             THIS.this_cMensagemErro = loc_oErro.Message

*-- Linhas 200 a 251:
200:     * Posicao/ColumnCount/larguras/captions transcritos LITERALMENTE de
201:     * SECAO 2 (sigmvtit.grdTitulos) e SECAO 3 (bloco With .grdTitulos) do
202:     * dump legado. Coluna2 (Vencimento) usa TTOD() sobre coluna de CURSOR
203:     * vinda de SQLEXEC (SigMvCcr.vencs e' datetime) - caso seguro da regra
204:     * "TTOD() so aceita DATETIME" (CLAUDE.md #16). Coluna8 (D/C) e' a UNICA
205:     * com .ReadOnly = .T. no legado; as demais (When->Return .f. no dump)
206:     * ganham o bloqueio de edicao na Fase 7/8, junto com AfterRowColChange.
207:     *==========================================================================
208:     PROTECTED PROCEDURE ConfigurarPaginaLista()
209:         LOCAL loc_oGrd
210: 
211:         *-- Cursor placeholder da grade - mesma estrutura/ordem de campos
212:         *-- que SIGMVTI2BO.BuscarTitulosGerados popula via SQLEXEC. Precisa
213:         *-- existir antes do RecordSource do grid, logo abaixo (regra
214:         *-- "Column.ControlSource de cursor que ainda nao existe derruba o
215:         *-- Init", CLAUDE.md #41).
216:         SET NULL ON
217:         IF USED("cursor_4c_Dados")
218:             USE IN cursor_4c_Dados
219:         ENDIF
220:         CREATE CURSOR cursor_4c_Dados ;
221:             (Titulos C(10) NULL, Vencs T NULL, Valors N(11,2) NULL, ;
222:              Moedas C(3) NULL, Hists C(60) NULL, Grupos C(10) NULL, ;
223:              DGrupos C(40) NULL, Contas C(10) NULL, DContas C(50) NULL, ;
224:              EmpDopNums C(29) NULL, Opers C(1) NULL)
225:         SET NULL OFF
226: 
227:         THIS.AddObject("grd_4c_Dados", "Grid")
228:         loc_oGrd = THIS.grd_4c_Dados
229:         WITH loc_oGrd
230:             .Top           = 5
231:             .Left          = 6
232:             .Width         = 884
233:             .Height        = 509
234:             .ColumnCount   = 8
235:             .ScrollBars    = 2
236:             .DeleteMark    = .F.
237:             .RecordMark    = .F.
238:             .FontName      = "Verdana"
239:             .FontSize      = 8
240:             .RowHeight     = 16
241:             .GridLineColor = RGB(238, 238, 238)
242:             .Visible       = .T.
243:         ENDWITH
244: 
245:         *-- Column1 - Titulo (Column NAO tem FontName/FontSize - Header1 e
246:         *-- Text1 tem, cada um configurado no seu proprio bloco). .ReadOnly
247:         *-- = .T. reproduz o "PROCEDURE When / Return .f." do Text1 do dump
248:         *-- legado (comportamento.json, sigmvtit.grdTitulos.Column1.Text1) -
249:         *-- o usuario nunca edita celula da grade, so' navega (a atualizacao
250:         *-- dos 3 campos de rodape acontece em GrdDadosAfterRowColChange).
251:         WITH loc_oGrd.Column1

*-- Linhas 383 a 488:
383:             .BackColor   = RGB(255, 255, 255)
384:         ENDWITH
385: 
386:         *-- RecordSource/ControlSource/Header/Width por ultimo (regra
387:         *-- "Column.Width vai por ultimo" - resetar RecordSource/
388:         *-- ControlSource reseta Width/Header, CLAUDE.md #35c/Problema 48).
389:         *-- Bloco extraido para BindGridColunas porque CarregarLista precisa
390:         *-- REAPLICA-LO: o SQLEXEC do BO RECRIA o cursor_4c_Dados e o bind
391:         *-- do grid cai junto com as larguras e os captions.
392:         THIS.BindGridColunas(loc_oGrd)
393: 
394:         *-- FASE 7/8: AfterRowColChange (SECAO 3, sigmvtit.grdTitulos) e' o
395:         *-- UNICO evento de navegacao do form - reflete a linha corrente do
396:         *-- grid nos 3 campos de rodape (txt_4c_DGrupos/DContas/EDN). BIND
397:         *-- feito uma UNICA vez aqui (ConfigurarPaginaLista roda 1x no
398:         *-- InicializarForm); CarregarLista so' rebinda RecordSource/
399:         *-- ControlSource via BindGridColunas, nao recria o Grid, entao nao
400:         *-- precisa rebindar o evento. Handler PUBLIC (CLAUDE.md #3 - BINDEVENT
401:         *-- ignora metodo PROTECTED em silencio).
402:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
403:     ENDPROC
404: 
405:     *==========================================================================
406:     * BindGridColunas - Liga a grade ao cursor_4c_Dados e (re)aplica
407:     * ControlSource / Header1.Caption / Width das 8 colunas. Transcricao do
408:     * bloco "With .grdTitulos" do Init legado (SECAO 3), inclusive o
409:     * Column2.ControlSource = [Ttod(LocalTits.Vencs)] - a expressao TTOD()
410:     * esta LITERAL no legado (SigMvCcr.vencs e' datetime; caso seguro da
411:     * regra "TTOD() so aceita DATETIME", CLAUDE.md #16, porque o argumento e'
412:     * coluna de cursor vinda de SQLEXEC e nunca um DATE de TextBox).
413:     * Chamado por ConfigurarPaginaLista (bind inicial, cursor placeholder) e
414:     * por CarregarLista (rebind, cursor recriado pelo SQLEXEC do BO).
415:     *==========================================================================
416:     PROTECTED PROCEDURE BindGridColunas(par_oGrd)
417:         LOCAL loc_oGrd
418:         loc_oGrd = par_oGrd
419: 
420:         loc_oGrd.RecordSource = ""
421:         loc_oGrd.ColumnCount  = 8
422:         loc_oGrd.RecordSource = "cursor_4c_Dados"
423: 
424:         loc_oGrd.Column1.ControlSource     = "cursor_4c_Dados.Titulos"
425:         loc_oGrd.Column1.Header1.Caption   = "T" + CHR(237) + "tulo"
426:         loc_oGrd.Column1.Header1.Alignment = 2
427:         loc_oGrd.Column1.Header1.FontName  = "Verdana"
428:         loc_oGrd.Column1.Header1.FontSize  = 8
429:         loc_oGrd.Column1.Width             = 100
430: 
431:         loc_oGrd.Column2.ControlSource     = "TTOD(cursor_4c_Dados.Vencs)"
432:         loc_oGrd.Column2.Header1.Caption   = "Vencimento"
433:         loc_oGrd.Column2.Header1.Alignment = 2
434:         loc_oGrd.Column2.Header1.FontName  = "Verdana"
435:         loc_oGrd.Column2.Header1.FontSize  = 8
436:         loc_oGrd.Column2.Width             = 80
437: 
438:         loc_oGrd.Column3.ControlSource     = "cursor_4c_Dados.Valors"
439:         loc_oGrd.Column3.Header1.Caption   = "Valor"
440:         loc_oGrd.Column3.Header1.Alignment = 2
441:         loc_oGrd.Column3.Header1.FontName  = "Verdana"
442:         loc_oGrd.Column3.Header1.FontSize  = 8
443:         loc_oGrd.Column3.Width             = 120
444: 
445:         loc_oGrd.Column4.ControlSource     = "cursor_4c_Dados.Moedas"
446:         loc_oGrd.Column4.Header1.Caption   = "Moe"
447:         loc_oGrd.Column4.Header1.Alignment = 2
448:         loc_oGrd.Column4.Header1.FontName  = "Verdana"
449:         loc_oGrd.Column4.Header1.FontSize  = 8
450:         loc_oGrd.Column4.Width             = 31
451: 
452:         loc_oGrd.Column5.ControlSource     = "cursor_4c_Dados.Hists"
453:         loc_oGrd.Column5.Header1.Caption   = "Hist" + CHR(243) + "rico"
454:         loc_oGrd.Column5.Header1.Alignment = 2
455:         loc_oGrd.Column5.Header1.FontName  = "Verdana"
456:         loc_oGrd.Column5.Header1.FontSize  = 8
457:         loc_oGrd.Column5.Width             = 305
458: 
459:         loc_oGrd.Column6.ControlSource     = "cursor_4c_Dados.Grupos"
460:         loc_oGrd.Column6.Header1.Caption   = "Grupo"
461:         loc_oGrd.Column6.Header1.Alignment = 2
462:         loc_oGrd.Column6.Header1.FontName  = "Verdana"
463:         loc_oGrd.Column6.Header1.FontSize  = 8
464:         loc_oGrd.Column6.Width             = 90
465: 
466:         loc_oGrd.Column7.ControlSource     = "cursor_4c_Dados.Contas"
467:         loc_oGrd.Column7.Header1.Caption   = "Conta"
468:         loc_oGrd.Column7.Header1.Alignment = 2
469:         loc_oGrd.Column7.Header1.FontName  = "Verdana"
470:         loc_oGrd.Column7.Header1.FontSize  = 8
471:         loc_oGrd.Column7.Width             = 90
472: 
473:         loc_oGrd.Column8.ControlSource     = "cursor_4c_Dados.Opers"
474:         loc_oGrd.Column8.Header1.Caption   = "D/C"
475:         loc_oGrd.Column8.Header1.Alignment = 2
476:         loc_oGrd.Column8.Header1.FontName  = "Verdana"
477:         loc_oGrd.Column8.Header1.FontSize  = 8
478:         loc_oGrd.Column8.Width             = 30
479:         loc_oGrd.Column8.ReadOnly          = .T.
480:     ENDPROC
481: 
482:     *==========================================================================
483:     * ConfigurarBotoes - UNICO botao do form: cmdSair -> cmd_4c_CmdSair
484:     * (nome do mapeamento.json). Este e' um VISUALIZADOR: o legado NAO tem
485:     * Incluir/Alterar/Excluir/Buscar - ver a nota do cabecalho.
486:     *
487:     * Top/Left/Caption/Picture/Cancel/TabIndex sao transcricao literal de
488:     * SECAO 2 (sigmvtit.cmdSair); Width/Height/fonte/cores vem da CLASSE

*-- Linhas 670 a 720:
670: 
671:     *==========================================================================
672:     * CarregarLista - Carga da grade de titulos gerados. Porte do trecho
673:     * final do Init legado: SqlExecute(lcQuery, [LocalTits]) ->
674:     * SIGMVTI2BO.BuscarTitulosGerados(), depois "Select LocalTits" /
675:     * "Goto Top In LocalTits", o rebind das 8 colunas e o ".Refresh".
676:     *
677:     * O rebind e' OBRIGATORIO e nao redundante: BuscarTitulosGerados faz
678:     * USE IN + SQLEXEC, isto e' RECRIA o cursor_4c_Dados, e com isso o
679:     * RecordSource/ControlSource do grid caem e as larguras/captions voltam
680:     * ao default 90/"Header1" (Problema 48 / CLAUDE.md #35c e #41).
681:     * O GO TOP + Refresh tambem sao obrigatorios: popular o cursor NAO
682:     * repinta a grade sozinho (CLAUDE.md #21a) - sem eles a tela abriria
683:     * visualmente vazia com o cursor cheio.
684:     *
685:     * PUBLIC de proposito (sem PROTECTED): o harness TesteAutomatico.prg
686:     * chama THIS.oForm.CarregarLista() de FORA da classe - CLAUDE.md #3.
687:     *==========================================================================
688:     PROCEDURE CarregarLista()
689:         LOCAL loc_lSucesso, loc_oErro
690: 
691:         loc_lSucesso = .F.
692: 
693:         TRY
694:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
695:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + ;
696:                         "vel para carregar os t" + CHR(237) + "tulos gerados.", "Erro")
697:             ELSE
698:                 *-- BuscarTitulosGerados ja exibe a falha ("Favor Reinicializar
699:                 *-- o Processo!!!", texto do legado) quando o SQLEXEC falha.
700:                 IF THIS.this_oBusinessObject.BuscarTitulosGerados() AND ;
701:                    USED("cursor_4c_Dados")
702: 
703:                     THIS.BindGridColunas(THIS.grd_4c_Dados)
704: 
705:                     SELECT cursor_4c_Dados
706:                     GO TOP IN cursor_4c_Dados
707:                     THIS.grd_4c_Dados.Refresh()
708: 
709:                     loc_lSucesso = .T.
710:                 ENDIF
711:             ENDIF
712:         CATCH TO loc_oErro
713:             THIS.this_cMensagemErro = loc_oErro.Message
714:             MsgErro(loc_oErro.Message + CHR(13) + ;
715:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
716:                     "Procedure: " + loc_oErro.Procedure, ;
717:                     "Erro em FormSIGMVTI2.CarregarLista")
718:         ENDTRY
719: 
720:         RETURN loc_lSucesso


### BO (C:\4c\projeto\app\classes\SIGMVTI2BO.prg):
*==============================================================================
* SIGMVTI2BO.PRG
* Business Object - Titulos Gerados (Processamento CMV) (SIGMVTI2)
* Consulta os titulos financeiros gerados pelo processamento de CMV
* (SigMvCcr), no periodo compreendido entre o momento da abertura do
* formulario e o final do dia, com joins para descricao do grupo de
* conta (SigCdGcr) e descricao da conta (SigCdCli).
* Heranca: BusinessBase
*
* NOTA IMPORTANTE (paridade com o legado): o SIGMVTIT/SIGMVTI2 eh um
* formulario de CONSULTA (grid de titulos recem-gerados) - o codigo fonte
* original (Init) faz SOMENTE um SELECT em SigMvCcr com Left Join em
* SigCdGcr/SigCdCli e Join em SigOpCdi. Nao existe, em lugar nenhum do
* legado, INSERT/UPDATE/DELETE em SigMvCcr disparado por este formulario -
* por isso Inserir()/Atualizar()/ExecutarExclusao() nao sao sobrescritos
* aqui: o comportamento padrao herdado de BusinessBase (recusar a
* operacao e reportar via ExibirFalha) ja eh o correto para um BO
* somente-leitura.
*==============================================================================

DEFINE CLASS SIGMVTI2BO AS BusinessBase

    *-- Filtro de periodo (espelha pDtI/pDtF do Init legado:
    *   pDtI = fDtoSQL(Datetime())                 -> momento atual
    *   pDtF = fDtoSQL(Datetime(), [23:59:59])      -> hoje as 23:59:59)
    this_dDtI = {}    && Data/hora inicial do filtro (SigMvCcr.datas between this_dDtI e this_dDtF)
    this_dDtF = {}    && Data/hora final do filtro

    *-- Dados do titulo selecionado no grid (SigMvCcr + joins SigCdGcr/SigCdCli)
    this_cTitulos    = ""   && SigMvCcr.titulos     char(10)      - codigo do titulo (PK logica)
    this_dVencs      = {}   && SigMvCcr.vencs       datetime      - data de vencimento
    this_nValors     = 0    && SigMvCcr.valors      numeric(11,2) - valor do titulo
    this_cMoedas     = ""   && SigMvCcr.moedas      char(3)       - codigo da moeda
    this_cHists      = ""   && SigMvCcr.hists       char(60)      - historico
    this_cGrupos     = ""   && SigMvCcr.grupos      char(10)      - grupo de conta (FK SigCdGcr.codigos)
    this_cDGrupos    = ""   && SigCdGcr.descrs                    - descricao do grupo (join b, alias DGrupos)
    this_cContas     = ""   && SigMvCcr.contas      char(10)      - conta (FK SigCdCli.IClis)
    this_cDContas    = ""   && SigCdCli.RClis                     - descricao da conta (join c, alias DContas)
    this_cEmpDopNums = ""   && SigMvCcr.empdopnums  char(29)      - chave Empresa+Operacao+Numero
    this_cOpers      = ""   && SigMvCcr.opers       char(1)       - tipo de operacao (D/C)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigMvCcr")

        THIS.this_cCampoChave = "cidchaves"

        * Periodo padrao: do momento atual ate o final do dia de hoje,
        * reproduzindo pDtI/pDtF do Init legado (fDtoSQL(Datetime()) e
        * fDtoSQL(Datetime(), [23:59:59]))
        THIS.this_dDtI = DATETIME()
        THIS.this_dDtF = DATETIME(YEAR(DATE()), MONTH(DATE()), DAY(DATE()), 23, 59, 59)

        THIS.this_cTitulos    = ""
        THIS.this_dVencs      = {}
        THIS.this_nValors     = 0
        THIS.this_cMoedas     = ""
        THIS.this_cHists      = ""
        THIS.this_cGrupos     = ""
        THIS.this_cDGrupos    = ""
        THIS.this_cContas     = ""
        THIS.this_cDContas    = ""
        THIS.this_cEmpDopNums = ""
        THIS.this_cOpers      = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTitulosGerados - Popula cursor_4c_Dados com os titulos gerados
    * pelo processamento de CMV no periodo THIS.this_dDtI / THIS.this_dDtF.
    * Transcricao literal da query do Init legado (SigMvCcr a + Left Join
    * SigCdGcr b + Left Join SigCdCli c + Join SigOpCdi d), trocando os
    * parametros ?pDtI/?pDtF por literais formatados (FormatarDataSQL) e o
    * cursor local LocalTits pelo cursor_4c_Dados do grid.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTitulosGerados()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        loc_cSQL = "SELECT a.Titulos, a.Vencs, a.Valors, a.Moedas, a.Hists, a.Grupos, " + ;
                   "b.Descrs AS DGrupos, a.Contas, c.RClis AS DContas, a.EmpDopNums, a.Opers " + ;
                   "FROM SigMvCcr a " + ;
                   "LEFT JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
                   "LEFT JOIN SigCdCli c ON a.Contas = c.IClis " + ;
                   "JOIN SigOpCdi d ON d.Dopes = a.Dopes " + ;
                   "WHERE a.Datas BETWEEN " + FormatarDataSQL(THIS.this_dDtI) + " AND " + FormatarDataSQL(THIS.this_dDtF) + " " + ;
                   "ORDER BY a.Vencs, a.Titulos, a.Grupos, a.Contas"

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

        IF loc_nResultado >= 0
            loc_lSucesso = .T.
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                GO TOP
            ENDIF
        ELSE
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL()
            MostrarErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o (T" + CHR(237) + "tulos Gerados)")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades this_* a partir de UMA linha
    * do cursor_4c_Dados (mesmas colunas/alias de BuscarTitulosGerados),
    * reproduzindo o AfterRowColChange do grdTitulos legado (que lia
    * LocalTits.DGrupos/DContas/EmpDopNums direto para os GETs de rodape).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)
        IF EOF()
            RETURN .F.
        ENDIF

        THIS.this_cTitulos    = TratarNulo(Titulos, "")
        THIS.this_dVencs      = TratarNulo(Vencs, {})
        THIS.this_nValors     = TratarNulo(Valors, 0)
        THIS.this_cMoedas     = TratarNulo(Moedas, "")
        THIS.this_cHists      = TratarNulo(Hists, "")
        THIS.this_cGrupos     = TratarNulo(Grupos, "")
        THIS.this_cDGrupos    = TratarNulo(DGrupos, "")
        THIS.this_cContas     = TratarNulo(Contas, "")
        THIS.this_cDContas    = TratarNulo(DContas, "")
        THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "")
        THIS.this_cOpers      = TratarNulo(Opers, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Identificador logico do titulo corrente (coluna
    * Titulos, chave usada pelo grid legado). cidchaves (PK fisica da
    * SigMvCcr) nao entra no SELECT desta consulta (o legado tambem nao a
    * le) - RegistrarAuditoria/ObterChavePrimaria so existem aqui por
    * completude de heranca, ja que este BO nao grava (ver nota no Init).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cTitulos
    ENDPROC

ENDDEFINE

