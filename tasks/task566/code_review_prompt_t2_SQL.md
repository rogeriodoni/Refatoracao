# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PLACEHOLDER' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CODIGOS, GRADES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'IGUA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CODIGOS, GRADES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CODIGOS, GRADES

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
  Column1.ControlSource = "crHistPeds.Datas"
  Column2.ControlSource = "crHistPeds.QtdAdqs"
  Column3.ControlSource = "crHistPeds.CUnis"
  Column4.ControlSource = "crHistPeds.ValAdqs"
  Column5.ControlSource = "crHistPeds.Units"
  Column6.ControlSource = "crHistPeds.Totas"
  Column7.ControlSource = "crHistPeds.IClis"
  Column8.ControlSource = "crHistPeds.Fornecs"
  ControlSource = "crHistPeds.Aprovador"
  ControlSource = "crHistPeds.Comprador"
  ControlSource = "crHistPeds.DtAprovs"
  ControlSource = "crHistPeds.ObsAprovs"
lcQuery = [Select a.Codigos, b.DtCotas as Datas, b.Situas, a.QtdAdqs, a.CUnis, a.ValAdqs, a.Marca01, a.Unit01, ] + ;
		    [From SigCtTCt a, SigCtTDc b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotCt]) < 1)
Select LocalCotCt
		Insert Into crHistPeds From Memvar
		lcQuery = [Select a.IClis, a.Fornecs ] + ;
				    [From SigCtTFn a ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCotFn]) < 1)
		Select LocalCotFn
Select crHistPeds

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGMVCTH.prg) - TRECHOS RELEVANTES PARA PASS SQL (849 linhas total):

*-- Linhas 193 a 269:
193:             .FontSize      = 8
194:             .ReadOnly      = .F.
195:             .RecordMark    = .F.
196:             .DeleteMark    = .F.
197:             .RowHeight     = 18
198:             .ScrollBars    = 2
199:             .GridLineColor = RGB(128,128,128)
200:         ENDWITH
201: 
202:         *-- Liga a grade ao cursor e aplica a configuracao das colunas
203:         THIS.VincularGridDados()
204: 
205:         *-- AfterRowColChange do legado: ao mudar de linha, os campos de
206:         *-- aprovacao (Comprador/Aprovador/Data/Observacao), que espelham a
207:         *-- linha corrente do cursor, precisam ser repintados.
208:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
209:     ENDPROC
210: 
211:     *--------------------------------------------------------------------------
212:     * VincularGridDados - Liga grd_4c_Dados a cursor_4c_HistPeds e aplica a
213:     * configuracao COMPLETA das 8 colunas (ControlSource, Width, Format,
214:     * Header e DynamicForeColor).
215:     *
216:     * Fica separado de ConfigurarGrid porque o BO FECHA e RECRIA o cursor a
217:     * cada CarregarHistorico(): isso quebra o vinculo do Grid, e reatribuir
218:     * RecordSource/ControlSource reseta Column.Width e Header1.Caption para
219:     * os defaults (Problema 48). Toda a configuracao de coluna mora aqui e eh
220:     * reaplicada em CADA caminho que repopula o cursor.
221:     *
222:     * ColumnCount eh reatribuido com o MESMO valor (8) para impedir que o Grid
223:     * auto-expanda para os 13 campos do cursor; como nenhuma coluna usa
224:     * AddObject, reatribuir o mesmo valor eh inofensivo.
225:     *--------------------------------------------------------------------------
226:     PROTECTED PROCEDURE VincularGridDados()
227:         *-- Cursor placeholder = cursor real (mesma estrutura criada em
228:         *-- SIGMVCTHBO.CarregarHistorico) - garante que o Grid sempre encontre
229:         *-- o RecordSource, mesmo se CarregarHistorico falhou antes de criar
230:         *-- o cursor.
231:         IF !USED("cursor_4c_HistPeds")
232:             SET NULL ON
233:             CREATE CURSOR cursor_4c_HistPeds (Situas N(1), Datas D(8), QtdAdqs N(12,2), ;
234:                 CUnis C(3), ValAdqs N(12,2), Units N(12,2), Totas N(12,2), IClis C(10), ;
235:                 Fornecs C(50), Comprador C(10), Aprovador C(10), DtAprovs D(8), ObsAprovs M(4))
236:             SET NULL OFF
237:         ENDIF
238: 
239:         *-- RecordSource/ColumnCount atribuidos por referencia EXPLICITA, fora
240:         *-- do WITH: dentro do mesmo WITH que acessa .Column1..Column8 estoura
241:         *-- "Unknown member COLUMN1" porque as colunas ainda nao existem no
242:         *-- instante em que o WITH eh aberto.
243:         THIS.grd_4c_Dados.ColumnCount  = 8
244:         THIS.grd_4c_Dados.RecordSource = "cursor_4c_HistPeds"
245: 
246:         WITH THIS.grd_4c_Dados
247:             .Column1.ControlSource = "cursor_4c_HistPeds.Datas"
248:             .Column2.ControlSource = "cursor_4c_HistPeds.QtdAdqs"
249:             .Column3.ControlSource = "cursor_4c_HistPeds.CUnis"
250:             .Column4.ControlSource = "cursor_4c_HistPeds.ValAdqs"
251:             .Column5.ControlSource = "cursor_4c_HistPeds.Units"
252:             .Column6.ControlSource = "cursor_4c_HistPeds.Totas"
253:             .Column7.ControlSource = "cursor_4c_HistPeds.IClis"
254:             .Column8.ControlSource = "cursor_4c_HistPeds.Fornecs"
255: 
256:             *-- Coluna 1: Data
257:             .Column1.Width             = 75
258:             .Column1.FontSize          = 8
259:             .Column1.Movable           = .F.
260:             .Column1.Resizable         = .F.
261:             .Column1.Alignment         = 2
262:             .Column1.ReadOnly          = .F.
263:             .Column1.Header1.Caption   = "Data"
264:             .Column1.Header1.Alignment = 2
265:             .Column1.Header1.FontSize  = 8
266:             .Column1.Text1.FontSize    = 8
267:             .Column1.Text1.Alignment   = 2
268:             .Column1.Text1.BorderStyle = 0
269:             .Column1.Text1.Margin      = 0

*-- Linhas 392 a 413:
392:         ENDWITH
393: 
394:         *-- Popular cursor nao repinta a grade sozinho - GO TOP + Refresh
395:         *-- (mesmo padrao do "Select crHistPeds / Go Top / grdCotacoes.Refresh"
396:         *-- no final do CarregaPedidos legado)
397:         IF USED("cursor_4c_HistPeds")
398:             SELECT cursor_4c_HistPeds
399:             GO TOP
400:             THIS.grd_4c_Dados.Refresh()
401:         ENDIF
402:     ENDPROC
403: 
404:     *--------------------------------------------------------------------------
405:     * ConfigurarCamposAprovacao - Cria os labels estaticos, o indicador de
406:     * legenda (Say10/Say5/Say1/Say2/Shape6/Say12 do legado) e os 3 TextBox +
407:     * 1 EditBox ligados a cursor_4c_HistPeds (getComprador/getAprovador/
408:     * getDtAprovs/getObsAprovs) que espelham a linha corrente da grade.
409:     *
410:     * ForeColor do legado (224,235,235) eh quase-branco e fica INVISIVEL sobre
411:     * o fundo claro (new_background.jpg) - todos os labels desta faixa
412:     * compartilham essa mesma cor quase-branca (sem irma com cor legivel para
413:     * herdar), entao escurecido para o canonico RGB(90,90,90) (regra #12).

*-- Linhas 510 a 586:
510:             .Enabled           = .F.
511:             .DisabledBackColor = RGB(255,255,255)
512:             .DisabledForeColor = RGB(0,0,0)
513:             .ControlSource     = "cursor_4c_HistPeds.Comprador"
514:         ENDWITH
515: 
516:         *-- getAprovador (mirror da linha corrente - nunca recebe foco)
517:         THIS.AddObject("txt_4c_Aprovador", "TextBox")
518:         WITH THIS.txt_4c_Aprovador
519:             .Top               = 532
520:             .Left              = 93
521:             .Width             = 80
522:             .Height            = 20
523:             .FontName          = "Arial"
524:             .FontSize          = 8
525:             .MaxLength         = 10
526:             .SpecialEffect     = 1
527:             .BorderColor       = RGB(0,0,128)
528:             .Format            = "K"
529:             .Enabled           = .F.
530:             .DisabledBackColor = RGB(255,255,255)
531:             .DisabledForeColor = RGB(0,0,0)
532:             .ControlSource     = "cursor_4c_HistPeds.Aprovador"
533:         ENDWITH
534: 
535:         *-- getDtAprovs (mirror da linha corrente - nunca recebe foco)
536:         THIS.AddObject("txt_4c_DtAprovs", "TextBox")
537:         WITH THIS.txt_4c_DtAprovs
538:             .Top               = 532
539:             .Left              = 177
540:             .Width             = 80
541:             .Height            = 20
542:             .FontName          = "Arial"
543:             .FontSize          = 8
544:             .MaxLength         = 10
545:             .SpecialEffect     = 1
546:             .BorderColor       = RGB(0,0,128)
547:             .Format            = "K"
548:             .Enabled           = .F.
549:             .DisabledBackColor = RGB(255,255,255)
550:             .DisabledForeColor = RGB(0,0,0)
551:             .ControlSource     = "cursor_4c_HistPeds.DtAprovs"
552:         ENDWITH
553: 
554:         *-- getObsAprovs (mirror da linha corrente - nunca recebe foco). SCX
555:         *-- declara DisabledBackColor/DisabledForeColor explicitos - overrida
556:         *-- o cinza padrao do VFP9 para Enabled = .F.
557:         THIS.AddObject("obj_4c_GetObsAprovs", "EditBox")
558:         WITH THIS.obj_4c_GetObsAprovs
559:             .Top               = 532
560:             .Left              = 261
561:             .Width             = 640
562:             .Height            = 20
563:             .FontName          = "Arial"
564:             .FontSize          = 8
565:             .SpecialEffect     = 1
566:             .BorderColor       = RGB(0,0,128)
567:             .Format            = "K!"
568:             .Enabled           = .F.
569:             .DisabledBackColor = RGB(255,255,255)
570:             .DisabledForeColor = RGB(0,0,128)
571:             .ControlSource     = "cursor_4c_HistPeds.ObsAprovs"
572:         ENDWITH
573: 
574:         *-- Shape6 - indicador da legenda (quadrado azul), pareado com Say12
575:         THIS.AddObject("shp_4c_Shape6", "Shape")
576:         WITH THIS.shp_4c_Shape6
577:             .Top           = 562
578:             .Left          = 9
579:             .Width         = 19
580:             .Height        = 19
581:             .BackStyle     = 1
582:             .BorderStyle   = 1
583:             .SpecialEffect = 0
584:             .BackColor     = RGB(0,0,255)
585:             .BorderColor   = RGB(90,90,90)
586:         ENDWITH

*-- Linhas 716 a 736:
716:     *          ThisForm.getDtAprovs.Refresh
717:     *          ThisForm.getObsAprovs.Refresh
718:     *
719:     * Os 4 controles tem .ControlSource apontando para o cursor (igual ao
720:     * legado), por isso aqui se chama Refresh() e NUNCA se atribui .Value:
721:     * atribuir .Value em controle com ControlSource escreveria de volta no
722:     * cursor, alterando o historico exibido.
723:     *
724:     * O guard PEMSTATUS mantem o metodo inocuo se ele for chamado antes de
725:     * ConfigurarCamposAprovacao ter criado os controles.
726:     *
727:     * ESCOPO: PROTECTED por HERANCA, pelo mesmo motivo de FormParaBO (FormBase
728:     * declara PROTECTED PROCEDURE BOParaForm). Chamado por THIS. em
729:     * CarregarLista e em GrdDadosAfterRowColChange - este ultimo eh o alvo do
730:     * BINDEVENT e esse sim eh PUBLIC, como a regra #3 exige.
731:     *--------------------------------------------------------------------------
732:     PROCEDURE BOParaForm()
733:         LOCAL loc_nI, loc_cNome, loc_oControle, loc_aCampos[4]
734: 
735:         IF VARTYPE(THIS.this_oBusinessObject) = "O" ;
736:                 AND USED(THIS.this_oBusinessObject.this_cCursorDados) ;


### BO (C:\4c\projeto\app\classes\SIGMVCTHBO.prg):
*====================================================================
* SIGMVCTHBO.prg
*
* Business Object para Historico de Cotacoes (consulta de cotacoes
* anteriores de um produto dentro de uma proposta de compra)
* Tabelas: SigCtTCt (itens de cotacao), SigCtTDc (documento/aprovacao
*          da cotacao), SigCtTFn (fornecedor vencedor por cotacao)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGMVCTHBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para SigCtTCt/SigCtTDc/SigCtTFn)
    this_cCPros       = ""   && cpros char(14) - SigCtTCt - proposta filtrada
    this_nCodigos     = 0    && codigos numeric(6,0) - SigCtTCt - produto atual (excluido do historico)
    this_cCursorDados = ""   && nome do cursor de resultado exibido na grade (equivalente a crHistPeds do legado)

    *-- Propriedades espelhando a linha corrente de THIS.this_cCursorDados
    *-- (mapeadas por CarregarDoCursor - TODAS as colunas de cursor_4c_HistPeds)
    this_nSituas      = 0    && Situas n(1) - situacao da aprovacao (SigCtTDc.situas)
    this_dDatas       = {}   && Datas d(8) - data da cotacao (SigCtTDc.dtcotas)
    this_nQtdAdqs     = 0    && QtdAdqs n(12,2) - quantidade adquirida (SigCtTCt.qtdadqs)
    this_cCUnis       = ""   && CUnis c(3) - unidade (SigCtTCt.cunis)
    this_nValAdqs     = 0    && ValAdqs n(12,2) - valor adquirido (SigCtTCt.valadqs)
    this_nUnits       = 0    && Units n(12,2) - valor unitario da marca vencedora (unit01..unit06)
    this_nTotas       = 0    && Totas n(12,2) - valor total da marca vencedora (tota01..tota06)
    this_cIClis       = ""   && IClis c(10) - codigo do fornecedor vencedor (SigCtTFn.iclis)
    this_cFornecs     = ""   && Fornecs c(50) - nome do fornecedor vencedor (SigCtTFn.fornecs)
    this_cComprador   = ""   && Comprador c(10) - comprador responsavel (SigCtTDc.comprador)
    this_cAprovador   = ""   && Aprovador c(10) - aprovador responsavel (SigCtTDc.aprovador)
    this_dDtAprovs    = {}   && DtAprovs d(8) - data da aprovacao (SigCtTDc.dtaprovs)
    this_cObsAprovs   = ""   && ObsAprovs m(4) - observacao da aprovacao (SigCtTDc.obsaprovs)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela      = "SigCtTCt"
            THIS.this_cCampoChave  = "cidchaves"
            THIS.this_cCPros       = ""
            THIS.this_nCodigos     = 0
            THIS.this_cCursorDados = "cursor_4c_HistPeds"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SIGMVCTHBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarHistorico - Busca o historico de cotacoes do produto dentro
    * da proposta filtrada (THIS.this_cCPros / THIS.this_nCodigos).
    *
    * Porta o metodo "CarregaPedidos" do legado: para cada linha de
    * SigCtTCt (itens cotados) casada com SigCtTDc (documento/aprovacao),
    * resolve qual das 6 marcas (Marca01..Marca06) foi a vencedora e busca
    * o fornecedor correspondente em SigCtTFn (chave Codigos+Grades).
    *
    * Popula THIS.this_cCursorDados (cursor_4c_HistPeds), com a MESMA
    * estrutura de campos que o Load() do legado criava para crHistPeds.
    *====================================================================
    PROCEDURE CarregarHistorico()
        LOCAL loc_cSQL, loc_cSQLFn, loc_nResultado, loc_nResultadoFn
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cLetra, loc_nUnit, loc_nTotal
        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorDados) (Situas N(1), Datas D(8), QtdAdqs N(12,2), ;
                CUnis C(3), ValAdqs N(12,2), Units N(12,2), Totas N(12,2), IClis C(10), ;
                Fornecs C(50), Comprador C(10), Aprovador C(10), DtAprovs D(8), ObsAprovs M(4))
            SET NULL OFF

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                *-- Modo de validacao de UI (sem conexao SQL) - cursor fica vazio e o form abre normalmente
                loc_lSucesso = .T.
            ELSE
                IF EMPTY(ALLTRIM(THIS.this_cCPros))
                    MostrarErro("Proposta n" + CHR(227) + "o informada.", "SIGMVCTHBO.CarregarHistorico")
                    loc_lProsseguir = .F.
                ENDIF

                IF loc_lProsseguir
                    loc_cSQL = "SELECT a.Codigos, b.DtCotas AS Datas, b.Situas, a.QtdAdqs, a.CUnis, a.ValAdqs, " + ;
                        "a.Marca01, a.Unit01, a.Tota01, a.Marca02, a.Unit02, a.Tota02, " + ;
                        "a.Marca03, a.Unit03, a.Tota03, a.Marca04, a.Unit04, a.Tota04, " + ;
                        "a.Marca05, a.Unit05, a.Tota05, a.Marca06, a.Unit06, a.Tota06, " + ;
                        "b.Comprador, b.Aprovador, b.DtAprovs, b.ObsAprovs " + ;
                        "FROM SigCtTCt a, SigCtTDc b " + ;
                        "WHERE a.CPros = " + EscaparSQL(THIS.this_cCPros) + " " + ;
                        "AND a.Codigos <> " + FormatarNumeroSQL(THIS.this_nCodigos, 0) + " " + ;
                        "AND a.Codigos = b.Codigos " + ;
                        "ORDER BY b.DtCotas DESC, a.Codigos ASC"

                    IF USED("cursor_4c_HistPedsCt")
                        USE IN cursor_4c_HistPedsCt
                    ENDIF
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistPedsCt")

                    IF loc_nResultado < 0
                        MostrarErro("Falha ao carregar hist" + CHR(243) + "rico de cota" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF

                IF loc_lProsseguir
                    SELECT cursor_4c_HistPedsCt
                    SCAN
                        loc_cLetra = " "
                        loc_nUnit  = 0
                        loc_nTotal = 0

                        DO CASE
                            CASE cursor_4c_HistPedsCt.Marca01
                                loc_cLetra = "A"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit01
                                loc_nTotal = cursor_4c_HistPedsCt.Tota01
                            CASE cursor_4c_HistPedsCt.Marca02
                                loc_cLetra = "B"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit02
                                loc_nTotal = cursor_4c_HistPedsCt.Tota02
                            CASE cursor_4c_HistPedsCt.Marca03
                                loc_cLetra = "C"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit03
                                loc_nTotal = cursor_4c_HistPedsCt.Tota03
                            CASE cursor_4c_HistPedsCt.Marca04
                                loc_cLetra = "D"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit04
                                loc_nTotal = cursor_4c_HistPedsCt.Tota04
                            CASE cursor_4c_HistPedsCt.Marca05
                                loc_cLetra = "E"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit05
                                loc_nTotal = cursor_4c_HistPedsCt.Tota05
                            CASE cursor_4c_HistPedsCt.Marca06
                                loc_cLetra = "F"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit06
                                loc_nTotal = cursor_4c_HistPedsCt.Tota06
                        ENDCASE

                        IF !EMPTY(loc_cLetra)
                            INSERT INTO (THIS.this_cCursorDados) ;
                                (Situas, Datas, QtdAdqs, CUnis, ValAdqs, Comprador, Aprovador, DtAprovs, ObsAprovs, Units, Totas) ;
                                VALUES ( ;
                                    cursor_4c_HistPedsCt.Situas, ;
                                    ConverterParaData(cursor_4c_HistPedsCt.Datas), ;
                                    cursor_4c_HistPedsCt.QtdAdqs, ;
                                    cursor_4c_HistPedsCt.CUnis, ;
                                    cursor_4c_HistPedsCt.ValAdqs, ;
                                    cursor_4c_HistPedsCt.Comprador, ;
                                    cursor_4c_HistPedsCt.Aprovador, ;
                                    ConverterParaData(cursor_4c_HistPedsCt.DtAprovs), ;
                                    TratarNulo(cursor_4c_HistPedsCt.ObsAprovs, ""), ;
                                    loc_nUnit, ;
                                    loc_nTotal)

                            loc_cSQLFn = "SELECT a.IClis, a.Fornecs FROM SigCtTFn a " + ;
                                "WHERE a.Codigos = " + FormatarNumeroSQL(cursor_4c_HistPedsCt.Codigos, 0) + " " + ;
                                "AND a.Grades = " + EscaparSQL(loc_cLetra)

                            IF USED("cursor_4c_HistPedsFn")
                                USE IN cursor_4c_HistPedsFn
                            ENDIF
                            loc_nResultadoFn = SQLEXEC(gnConnHandle, loc_cSQLFn, "cursor_4c_HistPedsFn")

                            IF loc_nResultadoFn < 0
                                MostrarErro("Falha ao carregar fornecedor vencedor da cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lProsseguir = .F.
                            ELSE
                                IF RECCOUNT("cursor_4c_HistPedsFn") > 0
                                    SELECT (THIS.this_cCursorDados)
                                    GO BOTTOM
                                    REPLACE IClis   WITH cursor_4c_HistPedsFn.IClis, ;
                                            Fornecs WITH cursor_4c_HistPedsFn.Fornecs
                                ENDIF
                                IF USED("cursor_4c_HistPedsFn")
                                    USE IN cursor_4c_HistPedsFn
                                ENDIF
                            ENDIF
                        ENDIF

                        IF !loc_lProsseguir
                            EXIT
                        ENDIF

                        SELECT cursor_4c_HistPedsCt
                    ENDSCAN

                    IF USED("cursor_4c_HistPedsCt")
                        USE IN cursor_4c_HistPedsCt
                    ENDIF
                    IF USED("cursor_4c_HistPedsFn")
                        USE IN cursor_4c_HistPedsFn
                    ENDIF
                ENDIF

                loc_lSucesso = loc_lProsseguir
            ENDIF

            IF loc_lSucesso AND USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                GO TOP
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "SIGMVCTHBO.CarregarHistorico")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia a linha CORRENTE de par_cAliasCursor
    * (tipicamente THIS.this_cCursorDados, a linha selecionada na grade)
    * para as propriedades this_* do Business Object.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_nSituas    = TratarNulo(Situas, 0)
                THIS.this_dDatas     = ConverterParaData(TratarNulo(Datas, {}))
                THIS.this_nQtdAdqs   = TratarNulo(QtdAdqs, 0)
                THIS.this_cCUnis     = TratarNulo(CUnis, "")
                THIS.this_nValAdqs   = TratarNulo(ValAdqs, 0)
                THIS.this_nUnits     = TratarNulo(Units, 0)
                THIS.this_nTotas     = TratarNulo(Totas, 0)
                THIS.this_cIClis     = TratarNulo(IClis, "")
                THIS.this_cFornecs   = TratarNulo(Fornecs, "")
                THIS.this_cComprador = TratarNulo(Comprador, "")
                THIS.this_cAprovador = TratarNulo(Aprovador, "")
                THIS.this_dDtAprovs  = ConverterParaData(TratarNulo(DtAprovs, {}))
                THIS.this_cObsAprovs = TratarNulo(ObsAprovs, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "SIGMVCTHBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir/Atualizar/ExecutarExclusao/ObterChavePrimaria/RegistrarAuditoria
    * continuam exatamente como herdados de BusinessBase, por fidelidade ao
    * legado: o formulario SIGMVCTH.SCX e um visualizador de historico
    * SOMENTE LEITURA - as tres consultas acima (SELECT em SigCtTCt/
    * SigCtTDc/SigCtTFn) sao a totalidade do SQL que ele executa. O unico
    * botao (cmdSalva.btnSair, rotulado "Retornar") apenas fecha a tela
    * (ThisForm.Release) - o legado nao tem nenhum INSERT/UPDATE/DELETE
    * para portar, e este form nunca aciona THIS.Salvar() nem
    * THIS.Excluir(). O comportamento herdado de BusinessBase (recusar a
    * operacao e avisar o usuario) ja reproduz essa realidade com
    * fidelidade, entao sobrescrever aqui apenas duplicaria codigo sem
    * alterar nada em tempo de execucao.
    *====================================================================

ENDDEFINE

