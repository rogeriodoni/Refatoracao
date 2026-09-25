# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-WITH] Bloco WITH THIS.grd_4c_Grade define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Grade.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Rodape define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Rodape.RecordSource).

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigmvpen.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (621 linhas total):

*-- Linhas 25 a 47:
25: * Controles criados em ConfigurarControles(), replicando fielmente a
26: * arvore do SCX legado (Top/Left/Width/Height/FontName/cores/Caption
27: * transcritos da SECAO 2 do dump), todos filhos DIRETOS do form:
28: *   - shp_4c_Shape1  (Shape1 legado - moldura decorativa ao redor do
29: *     botao Encerrar)
30: *   - grd_4c_Grade   (grdItens legado - grade de itens em aberto, 8
31: *     colunas, ligada a cursor_4c_Grade do Business Object)
32: *   - grd_4c_Rodape  (grdRodape legado - grade de 1 linha com o total
33: *     geral, ligada a cursor_4c_Rodape do Business Object)
34: *   - txt_4c_RClis   (getRClis legado - TextBox somente-leitura com a
35: *     razao social da linha selecionada; permanece Enabled = .F. desde
36: *     a criacao, como o legado - PROCEDURE When retorna .F., ou seja,
37: *     o campo NUNCA entra em edicao)
38: *   - cmd_4c_Encerrar (ok legado - unico botao, fecha o dialogo)
39: * As propriedades de coluna que o legado so define em RUNTIME
40: * (PROCEDURE montagrades, chamado pelo Init) - FontName "Courier New"
41: * sobrescrevendo o "Arial" de design-time - sao transcritas como o
42: * valor final que realmente aparece na tela.
43: *
44: * Ordem de configuracao dentro do Grid (CLAUDE.md - "Column.Width vai
45: * por ULTIMO"): ColumnCount -> RecordSource -> Column.ControlSource
46: * SOMENTE DEPOIS de cursor_4c_Grade/cursor_4c_Rodape existirem (o BO
47: * cria os cursores ANTES de ConfigurarControles() rodar - apontar

*-- Linhas 196 a 225:
196:         *-- Shape1 - moldura decorativa ao redor do botao Encerrar
197:         THIS.AddObject("shp_4c_Shape1", "Shape")
198:         WITH THIS.shp_4c_Shape1
199:             .Top         = 7
200:             .Left        = 654
201:             .Height      = 110
202:             .Width       = 90
203:             .BackStyle   = 0
204:             .BorderColor = RGB(136, 189, 188)
205:             .Visible     = .T.
206:         ENDWITH
207: 
208:         *-- grdItens -> grd_4c_Grade (8 colunas, itens em aberto)
209:         THIS.AddObject("grd_4c_Grade", "Grid")
210:         WITH THIS.grd_4c_Grade
211:             .Top               = 131
212:             .Left              = 13
213:             .Height            = 326
214:             .Width             = 724
215:             .FontName          = "Courier New"
216:             .AllowHeaderSizing = .F.
217:             .AllowRowSizing    = .F.
218:             .DeleteMark        = .F.
219:             .RecordMark        = .F.
220:             .HeaderHeight      = 17
221:             .ReadOnly          = .T.
222:             .ScrollBars        = 2
223:             .ColumnCount       = 8
224:             .RecordSource      = loc_cCursorGrade
225: 

*-- Linhas 250 a 281:
250:             *-- Header1 mantem FontName/FontSize de DESIGN-TIME (Arial 8) -
251:             *-- o loop runtime do legado so troca Column.FontName/Text1.FontName
252:             *-- (celulas de dado), nunca Header1.FontName.
253:             .Column1.Header1.Caption   = "Emp"
254:             .Column1.Header1.FontName  = "Arial"
255:             .Column1.Header1.FontSize  = 8
256:             .Column1.Header1.Alignment = 2
257:             .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
258:             .Column2.Header1.FontName  = "Arial"
259:             .Column2.Header1.FontSize  = 8
260:             .Column2.Header1.Alignment = 2
261:             .Column3.Header1.Caption   = "C" + CHR(243) + "digo"
262:             .Column3.Header1.FontSize  = 8
263:             .Column3.Header1.Alignment = 2
264:             .Column4.Header1.Caption   = "Data"
265:             .Column4.Header1.FontSize  = 8
266:             .Column4.Header1.Alignment = 2
267:             .Column5.Header1.Caption   = "Grupo"
268:             .Column5.Header1.FontSize  = 8
269:             .Column5.Header1.Alignment = 2
270:             .Column6.Header1.Caption   = "Conta"
271:             .Column6.Header1.FontSize  = 8
272:             .Column6.Header1.Alignment = 2
273:             .Column7.Header1.Caption   = "Data / Entrega"
274:             .Column7.Header1.FontSize  = 8
275:             .Column7.Header1.Alignment = 2
276:             .Column8.Header1.Caption   = "Qtde"
277:             .Column8.Header1.FontSize  = 8
278:             .Column8.Header1.Alignment = 2
279: 
280:             .Column1.Movable = .F.
281:             .Column2.Movable = .F.

*-- Linhas 357 a 379:
357:             .Column8.Text1.BackColor   = RGB(255, 255, 223)
358: 
359:             .Visible = .T.
360:         ENDWITH
361: 
362:         *-- grdRodape -> grd_4c_Rodape (3 colunas, total geral)
363:         THIS.AddObject("grd_4c_Rodape", "Grid")
364:         WITH THIS.grd_4c_Rodape
365:             .Top               = 453
366:             .Left              = 13
367:             .Height            = 23
368:             .Width             = 724
369:             .FontName          = "Courier New"
370:             .AllowHeaderSizing = .F.
371:             .AllowRowSizing    = .F.
372:             .DeleteMark        = .F.
373:             .RecordMark        = .F.
374:             .HeaderHeight      = 4
375:             .ReadOnly          = .T.
376:             .ScrollBars        = 2
377:             .ColumnCount       = 3
378:             .RecordSource      = loc_cCursorRodape
379: 

*-- Linhas 386 a 400:
386:             .Column2.Width = 80
387:             .Column3.Width = 80
388: 
389:             .Column1.Header1.Caption   = ""
390:             .Column1.Header1.FontName  = "Courier New"
391:             .Column1.Header1.BackColor = RGB(255, 255, 0)
392:             .Column2.Header1.Caption   = ""
393:             .Column2.Header1.FontName  = "Courier New"
394:             .Column2.Header1.BackColor = RGB(255, 255, 0)
395:             .Column3.Header1.Caption   = ""
396:             .Column3.Header1.FontName  = "Courier New"
397:             .Column3.Header1.BackColor = RGB(255, 255, 0)
398: 
399:             .Column1.Movable   = .F.
400:             .Column2.Movable   = .F.

*-- Linhas 440 a 449:
440:         *-- NUNCA entra em edicao - so recebe .Value por codigo.
441:         THIS.AddObject("txt_4c_RClis", "TextBox")
442:         WITH THIS.txt_4c_RClis
443:             .Top                = 476
444:             .Left               = 13
445:             .Height             = 20
446:             .Width              = 724
447:             .FontName           = "Courier New"
448:             .FontSize           = 9
449:             .SpecialEffect      = 1

*-- Linhas 457 a 507:
457:             .Visible            = .T.
458:         ENDWITH
459: 
460:         *-- ok -> cmd_4c_Encerrar (unico botao do dialogo - fecha a tela)
461:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
462:         WITH THIS.cmd_4c_Encerrar
463:             .Top       = 12
464:             .Left = 5
465:             .Height    = 75
466:             .Width     = 75
467:             .FontName  = "Verdana"
468:             .FontSize  = 8
469:             .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
470:             .Cancel    = .T.
471:             .Caption   = "Encerrar"
472:             .ForeColor = RGB(36, 84, 155)
473:             .BackColor = RGB(255, 255, 255)
474:             .Themes           = .T.
475:             .Visible   = .T.
476:         ENDWITH
477: 
478:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
479: 
480:         *-- Equivalente ao PROCEDURE AfterRowColChange de grdItens (troca de
481:         *-- linha na grade principal atualiza o rodape e a razao social).
482:         BINDEVENT(THIS.grd_4c_Grade, "AfterRowColChange", THIS, "GrdGradeAfterRowColChange")
483: 
484:         *-- Equivalente a grdRodape.Column1.Text1.GotFocus (devolve o foco
485:         *-- para a grade principal - a celula do rodape eh so vitrine).
486:         BINDEVENT(THIS.grd_4c_Rodape.Column1.Text1, "GotFocus", THIS, "GrdRodapeCol1TextGotFocus")
487: 
488:         *-- Equivalente ao par GotFocus/LostFocus de grdRodape.Column2.Text1
489:         *-- (guarda o valor em .Tag ao entrar e o restaura ao sair, para a
490:         *-- celula nunca aceitar edicao mesmo sendo alcancada via Tab).
491:         BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "GotFocus", THIS, "GrdRodapeCol2TextGotFocus")
492:         BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "KeyPress", THIS, "GrdRodapeCol2TextLostFocus")
493:     ENDPROC
494: 
495:     *--------------------------------------------------------------------------
496:     * CmdEncerrarClick - Equivalente ao PROCEDURE Click do "ok" legado
497:     * (ThisForm.Release). PUBLIC porque e bindado via BINDEVENT (CLAUDE.md
498:     * regra #3).
499:     *--------------------------------------------------------------------------
500:     PROCEDURE CmdEncerrarClick()
501:         THIS.Release()
502:     ENDPROC
503: 
504:     *--------------------------------------------------------------------------
505:     * GrdGradeAfterRowColChange - Equivalente ao PROCEDURE AfterRowColChange
506:     * de grdItens do legado: a cada troca de linha/coluna na grade principal,
507:     * espelha Empresa Destino + Usuario no rodape e a Razao Social no

*-- Linhas 519 a 579:
519:     * a celula do rodape eh somente vitrine, entao ao ganhar foco (Tab a
520:     * partir da grade principal) devolve o foco para a grade de itens.
521:     * PUBLIC porque e bindado via BINDEVENT.
522:     *--------------------------------------------------------------------------
523:     PROCEDURE GrdRodapeCol1TextGotFocus()
524:         THIS.grd_4c_Grade.Column1.SetFocus()
525:     ENDPROC
526: 
527:     *--------------------------------------------------------------------------
528:     * GrdRodapeCol2TextGotFocus / GrdRodapeCol2TextLostFocus - Equivalente ao
529:     * par GotFocus (This.Tag = This.Value) / LostFocus (This.Value = This.Tag)
530:     * de grdRodape.Column2.Text1 do legado: guarda o valor corrente em .Tag ao
531:     * entrar e o restaura ao sair, para a celula nunca aceitar edicao. PUBLIC
532:     * porque sao bindados via BINDEVENT.
533:     *--------------------------------------------------------------------------
534:     PROCEDURE GrdRodapeCol2TextGotFocus()
535:         THIS.grd_4c_Rodape.Column2.Text1.Tag = THIS.grd_4c_Rodape.Column2.Text1.Value
536:     ENDPROC
537: 
538:     PROCEDURE GrdRodapeCol2TextLostFocus(par_nKeyCode, par_nShiftAltCtrl)
539:         THIS.grd_4c_Rodape.Column2.Text1.Value = THIS.grd_4c_Rodape.Column2.Text1.Tag
540:     ENDPROC
541: 
542:     *--------------------------------------------------------------------------
543:     * Carga inicial das grades - equivalente ao trecho do Init legado que
544:     * fica entre LockScreen = .T. e LockScreen = .F.: ".MontaGrades" ja
545:     * aconteceu em ConfigurarControles() (chamada antes deste metodo, ainda
546:     * em InicializarForm), entao aqui resta ".SelecionaDados" (busca do BO),
547:     * o Refresh das duas grades e o SetFocus na primeira coluna da grade de
548:     * itens. O cursor de itens em aberto (equivalente a crSigMvEstPd do
549:     * legado) e responsabilidade do processo CHAMADOR deste dialogo - ver o
550:     * metodo de busca em sigmvpenBO.prg.
551:     *--------------------------------------------------------------------------
552:     PROTECTED PROCEDURE CarregarPendentes()
553:         LOCAL loc_lSucesso
554:         loc_lSucesso = .F.
555: 
556:         THIS.LockScreen = .T.
557: 
558:         IF THIS.this_oBusinessObject.BuscarPendentes("crSigMvEstPd")
559:             THIS.grd_4c_Grade.Refresh()
560:             THIS.grd_4c_Rodape.Refresh()
561: 
562:             THIS.AtualizarLinhaSelecionada()
563: 
564:             THIS.grd_4c_Grade.Column1.SetFocus()
565: 
566:             loc_lSucesso = .T.
567:         ELSE
568:             IF !EMPTY(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMensagemErro, "")))
569:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
570:             ENDIF
571:         ENDIF
572: 
573:         THIS.LockScreen = .F.
574: 
575:         RETURN loc_lSucesso
576:     ENDPROC
577: 
578:     *--------------------------------------------------------------------------
579:     * AtualizarLinhaSelecionada - Le a linha corrente de cursor_4c_Grade via

*-- Linhas 586 a 611:
586:     PROTECTED PROCEDURE AtualizarLinhaSelecionada()
587:         LOCAL loc_oBO
588:         loc_oBO = THIS.this_oBusinessObject
589: 
590:         IF loc_oBO.CarregarDoCursor(loc_oBO.this_cCursorGrade)
591:             THIS.grd_4c_Rodape.Column1.Text1.Value = "Empresa Destino : " + loc_oBO.this_cEmpDs
592:             THIS.grd_4c_Rodape.Column2.Text1.Value = loc_oBO.this_cUsuars
593:             THIS.txt_4c_RClis.Value = loc_oBO.this_cRClis
594: 
595:             THIS.grd_4c_Rodape.Column1.Refresh()
596:             THIS.grd_4c_Rodape.Column2.Refresh()
597:             THIS.txt_4c_RClis.Refresh()
598:         ENDIF
599:     ENDPROC
600: 
601:     *--------------------------------------------------------------------------
602:     * Fecha os cursores de trabalho do Business Object (cursor_4c_Grade/
603:     * cursor_4c_Rodape, equivalentes a crGrade/crRodape do legado, criados
604:     * pelo metodo de criacao de cursores do BO) antes de liberar
605:     * this_oBusinessObject via heranca. Equivalente ao
606:     * "ThisForm.poDataMgr.Release" do PROCEDURE Release legado - aqui
607:     * nao ha conexao privada por form para liberar (gnConnHandle e
608:     * global), entao o que resta a fechar sao os cursores locais.
609:     *--------------------------------------------------------------------------
610:     PROCEDURE Destroy()
611:         IF USED("cursor_4c_Grade")


### BO (C:\4c\projeto\app\classes\sigmvpenBO.prg):
*====================================================================
* sigmvpenBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGMVPEN" (saldo em aberto de
* movimentacao): consulta itens em aberto de recebimento/transferencia,
* agrupados por Empresa/Operacao/Numero.
*
* Nao existe tabela unica: o detalhe (cursor_4c_Grade) vem de um JOIN
* entre SigMvEstPd (saldo em aberto), SigMvCab (dados da movimentacao) e
* SigCdCli (razao social do cliente/fornecedor). SigMvEstPd e a tabela
* de origem do filtro, por isso THIS.this_cTabela aponta para ela.
*
* Chave de filtro: Fk_chave (equivalente a ThisForm.lpKey / LParameters
* pKey do Init do form legado sigmvpen)
*
* Herda de: BusinessBase
*
* Metodos principais: os metodos de criacao/carga dos cursores de
* trabalho (equivalentes a Load/selecionadados do legado) e
* CarregarDoCursor (linha selecionada da grade, equivalente ao
* AfterRowColChange do legado).
*====================================================================

DEFINE CLASS sigmvpenBO AS BusinessBase

    *-- Propriedade de filtro (equivalente a ThisForm.lpKey do form legado)
    this_cLpKey        = ""    && Fk_chave - chave usada para filtrar SigMvEstPd

    *-- Nomes dos cursores de trabalho (grade principal e rodape/legenda)
    this_cCursorGrade  = "cursor_4c_Grade"    && detalhe: Emps/Dopes/Numes/GrupoDs/ContaDs/Usuars/Datas/PrazoEnts/Pendentes/EmpDs/RClis
    this_cCursorRodape = "cursor_4c_Rodape"   && totais/legenda da linha selecionada: Descrs/Usuars/Pendentes

    *-- Propriedades da LINHA SELECIONADA na grade (equivalente ao que o
    *-- AfterRowColChange do legado le direto de crGrade.<campo>). Preenchidas
    *-- por CarregarDoCursor(THIS.this_cCursorGrade) a cada troca de linha.
    this_cEmps         = ""    && crGrade.Emps
    this_cDopes        = ""    && crGrade.Dopes
    this_nNumes        = 0     && crGrade.Numes
    this_cGrupoDs      = ""    && crGrade.GrupoDs
    this_cContaDs      = ""    && crGrade.ContaDs
    this_cRClis        = ""    && crGrade.RClis
    this_cUsuars       = ""    && crGrade.Usuars
    this_dDatas        = {}    && crGrade.Datas
    this_dPrazoEnts    = {}    && crGrade.PrazoEnts
    this_cEmpDs        = ""    && crGrade.EmpDs
    this_nPendentes    = 0     && crGrade.Pendentes

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * par_cLpKey: chave (Fk_chave) usada para filtrar o saldo em aberto.
    * Equivale ao LParameters pKey do Init do form legado sigmvpen, que o
    * form repassava para ThisForm.lpKey antes de montar as grades.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cLpKey)
        DODEFAULT("SigMvEstPd")

        THIS.this_cCampoChave = "Fk_chave"

        IF VARTYPE(par_cLpKey) = "C"
            THIS.this_cLpKey = par_cLpKey
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Cria (ou recria) os cursores de trabalho com a MESMA estrutura e ORDEM
    * DE CAMPOS em todos os pontos que os usam (Form e BO) - equivalente ao
    * "Create Cursor crGrade"/"Create Cursor crRodape" do PROCEDURE Load do
    * form legado. Chamado pelo Form (InicializarForm) e internamente pelo
    * metodo de carga abaixo, para garantir a estrutura antes de popular.
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursoresPendentes()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                USE IN (THIS.this_cCursorGrade)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorGrade) (Emps C(3), Dopes C(20), Numes N(6), ;
                GrupoDs C(10), ContaDs C(10), Usuars C(10), Datas D, PrazoEnts D, ;
                Pendentes N(10,3), EmpDs C(3), RClis C(50))

            SELECT (THIS.this_cCursorGrade)
            INDEX ON DTOS(PrazoEnts) + DTOS(Datas) + Emps + Dopes + STR(Numes, 6) TAG Ordem

            IF USED(THIS.this_cCursorRodape)
                USE IN (THIS.this_cCursorRodape)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorRodape) (Descrs C(100), Usuars C(10), Pendentes N(10,3))

            loc_lSucesso = .T.
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MsgErro(loException.Message, "Erro em sigmvpenBO.CriarCursoresPendentes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Busca os dados da grade - equivalente ao PROCEDURE selecionadados do
    * legado.
    *
    * par_cCursorEstPd: alias do cursor LOCAL, ja aberto na sessao, com os
    * itens em aberto (Fk_chave/EmpDopNums/Qtds) - equivalente a crSigMvEstPd
    * do form legado. Esse cursor NAO vem de uma tabela chamada "SigMvEstPd"
    * (ela nao existe no schema - a tabela real e SigMvEst, com colunas
    * totalmente diferentes de Fk_chave/EmpDopNums/Qtds); no sistema legado ele
    * e montado pelo processo CHAMADOR (a tela de movimentacao que abre este
    * dialogo) e permanece visivel aqui porque sigmvpen usa DataSession=1
    * (sessao compartilhada, nao privada). Por isso o parametro: quem chama
    * este BO e responsavel por ja ter esse cursor populado.
    *
    * Para cada grupo (EmpDopNums, Sum(Qtds)) dentro do Fk_chave filtrado,
    * busca no SQL Server o cabecalho da movimentacao (SigMvCab) e a razao
    * social do cliente/fornecedor (SigCdCli), e grava uma linha no cursor de
    * grade (this_cCursorGrade). Ao final, grava o total geral no cursor de
    * rodape (this_cCursorRodape).
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPendentes(par_cCursorEstPd)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nTotalPendentes, ;
              loc_dDatas, loc_dPrazoEnts
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cCursorEstPd) != "C" OR !USED(par_cCursorEstPd)
                THIS.this_cMensagemErro = "Cursor de itens pendentes n" + CHR(227) + "o localizado."
                RETURN .F.
            ENDIF

            THIS.CriarCursoresPendentes()

            SELECT (THIS.this_cCursorGrade)
            ZAP
            SELECT (THIS.this_cCursorRodape)
            ZAP

            *-- Equivalente a:
            *-- Select Distinct EmpDopNums, Sum(Qtds) as Qtds From crSigMvEstPd
            *--  Where Fk_chave = ThisForm.lpKey
            *--  Order By EmpDopNums Group By EmpDopNums Into Cursor LocalEstPd
            IF USED("cursor_4c_LocalEstPd")
                USE IN cursor_4c_LocalEstPd
            ENDIF

            SELECT DISTINCT EmpDopNums, SUM(Qtds) AS Qtds ;
                FROM (par_cCursorEstPd) ;
                WHERE Fk_chave = THIS.this_cLpKey ;
                GROUP BY EmpDopNums ;
                ORDER BY EmpDopNums ;
                INTO CURSOR cursor_4c_LocalEstPd READWRITE

            SELECT cursor_4c_LocalEstPd
            SCAN
                *-- Equivalente a:
                *-- Select a.Emps, a.EmpDs, a.Dopes, a.Numes, a.GrupoDs, a.ContaDs,
                *--        b.RClis, a.Usuars, a.Datas, a.PrazoEnts
                *--   From SigMvCab a, SigCdCli b
                *--  Where a.EmpDopNums = '<EmpDopNums>' And a.ContaDs = b.IClis
                loc_cSQL = "SELECT a.Emps, a.EmpDs, a.Dopes, a.Numes, a.grupods AS GrupoDs,"
                loc_cSQL = loc_cSQL + " a.contads AS ContaDs, b.rclis AS RClis, a.Usuars,"
                loc_cSQL = loc_cSQL + " a.Datas, a.prazoents AS PrazoEnts"
                loc_cSQL = loc_cSQL + " FROM SigMvCab a, SigCdCli b"
                loc_cSQL = loc_cSQL + " WHERE a.empdopnums = " + EscaparSQL(cursor_4c_LocalEstPd.EmpDopNums)
                loc_cSQL = loc_cSQL + " AND a.contads = b.iclis"

                IF USED("cursor_4c_EstDet")
                    USE IN cursor_4c_EstDet
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstDet")

                IF loc_nResultado < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (EstDet)")
                    SELECT cursor_4c_LocalEstPd
                    LOOP
                ENDIF

                SELECT cursor_4c_EstDet
                SCAN
                    IF ISNULL(cursor_4c_EstDet.Datas)
                        loc_dDatas = {}
                    ELSE
                        loc_dDatas = TTOD(cursor_4c_EstDet.Datas)
                    ENDIF

                    IF ISNULL(cursor_4c_EstDet.PrazoEnts)
                        loc_dPrazoEnts = {}
                    ELSE
                        loc_dPrazoEnts = TTOD(cursor_4c_EstDet.PrazoEnts)
                    ENDIF

                    INSERT INTO (THIS.this_cCursorGrade) ;
                        (Emps, Dopes, Numes, GrupoDs, ContaDs, RClis, Usuars, Datas, PrazoEnts, EmpDs, Pendentes) ;
                        VALUES ;
                        (cursor_4c_EstDet.Emps, cursor_4c_EstDet.Dopes, cursor_4c_EstDet.Numes, ;
                         cursor_4c_EstDet.GrupoDs, cursor_4c_EstDet.ContaDs, cursor_4c_EstDet.RClis, ;
                         cursor_4c_EstDet.Usuars, loc_dDatas, loc_dPrazoEnts, cursor_4c_EstDet.EmpDs, ;
                         cursor_4c_LocalEstPd.Qtds)

                    SELECT cursor_4c_EstDet
                ENDSCAN

                IF USED("cursor_4c_EstDet")
                    USE IN cursor_4c_EstDet
                ENDIF

                SELECT cursor_4c_LocalEstPd
            ENDSCAN

            IF USED("cursor_4c_LocalEstPd")
                USE IN cursor_4c_LocalEstPd
            ENDIF

            *-- Equivalente ao trecho do legado que soma o saldo em aberto da
            *-- grade e grava o total no cursor de rodape.
            loc_nTotalPendentes = 0
            SELECT (THIS.this_cCursorGrade)
            SUM Pendentes TO loc_nTotalPendentes

            INSERT INTO (THIS.this_cCursorRodape) (Pendentes) VALUES (loc_nTotalPendentes)

            SELECT (THIS.this_cCursorGrade)
            GO TOP
            SELECT (THIS.this_cCursorRodape)
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MsgErro(loException.Message, "Erro em sigmvpenBO.BuscarPendentes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia a linha CORRENTE de this_cCursorGrade para as
    * propriedades this_*. Equivalente ao que o AfterRowColChange do grid
    * legado fazia lendo crGrade.<campo> diretamente - aqui o Form chama este
    * metodo do BO a cada troca de linha (PILAR 3: leitura de dados no BO,
    * nao no Form) e depois espelha this_cEmpDs/this_cUsuars/this_cRClis no
    * rodape e no getRClis.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF !EOF()
                    THIS.this_cEmps      = TratarNulo(Emps, "")
                    THIS.this_cDopes     = TratarNulo(Dopes, "")
                    THIS.this_nNumes     = TratarNulo(Numes, 0)
                    THIS.this_cGrupoDs   = TratarNulo(GrupoDs, "")
                    THIS.this_cContaDs   = TratarNulo(ContaDs, "")
                    THIS.this_cRClis     = TratarNulo(RClis, "")
                    THIS.this_cUsuars    = TratarNulo(Usuars, "")
                    THIS.this_dDatas     = ConverterParaData(Datas)
                    THIS.this_dPrazoEnts = ConverterParaData(PrazoEnts)
                    THIS.this_cEmpDs     = TratarNulo(EmpDs, "")
                    THIS.this_nPendentes = TratarNulo(Pendentes, 0)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvpenBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao ha PK de registro unico nesta tela (a "chave"
    * do dialogo eh o proprio filtro Fk_chave, compartilhado por todas as
    * linhas da grade). Sobrescrito apenas para o contrato de BusinessBase;
    * este BO nunca chama RegistrarAuditoria/Salvar/Excluir - ver nota abaixo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cLpKey, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * NOTA: Inserir()/Atualizar()/ExecutarExclusao() NAO sao sobrescritos.
    * O form legado sigmvpen e um dialogo de CONSULTA (o unico botao, "ok",
    * apenas fecha a tela com ThisForm.Release - nao ha INSERT/UPDATE/DELETE
    * em lugar nenhum do codigo original). Sobrescrever esses metodos aqui
    * inventaria gravacao que o legado nunca teve (violaria a paridade
    * funcional). Os defaults herdados de BusinessBase permanecem validos,
    * pois Salvar()/Excluir() jamais sao chamados por este BO/Form.
    *--------------------------------------------------------------------------

ENDDEFINE

