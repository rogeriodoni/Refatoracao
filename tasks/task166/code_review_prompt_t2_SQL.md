# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INCLUIR, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INCLUIR, CIDCHAVES

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
Objeto: delete
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column1.SelectOnEntry = .F.
  Column2.ControlSource = ""
  Column2.SelectOnEntry = .F.
  Column3.ControlSource = ""
  ControlSource = ""
  Name = "delete"
Select * From CrSigCdCot Into Cursor TmpCot ReadWrite
This.fwgrade_Cotacao.Data.ControlSource = 'TmpCot.datas'
This.fwgrade_Cotacao.Cotacao.ControlSource = 'TmpCot.valos'
This.fwgrade_Cotacao.Hora.ControlSource = 'TmpCot.horas'
ThisForm.Delete.Visible  = fChecaAcesso('SIGPRCOT','EXCLUIR')
If ThisForm.Delete.Visible
	ThisForm.Delete.Left = lnLeft
	lnLeft = lnLeft + ThisForm.Delete.Width
Select TmpCot
Select TmpCot
If Seek(CrSigCdMoe.cmoes + Dtos(_data) + This.Value)
Select TmpCot
Seek(CrSigCdMoe.cmoes + Dtos({}))
	Insert Into TmpCot (cmoes,datas,horas,cidchaves,dtalts,usuars) ;
	Insert Into CrSigCdCot (cmoes,datas,horas,cidchaves,dtalts,usuars) ;
Select TmpCot
	If ThisForm.ThisParent.poDataMgr.SqlExecute([Delete From SigCdCot Where cidchaves = ']+lcIdChave+[' ],'') < 1
	Select TmpCot
	Delete
	If Seek(lcIdChave,'CrSigCdCot','CidChaves')
		Delete In CrSigCdCot
Select TmpCot
		Delete
		If Seek(TmpCot.cidchaves,'CrSigCdCot','CidChaves')
			Delete In CrSigCdCot
	Select TmpCot
Select CrSigCdCot
	If Seek(CrSigCdCot.cidchaves,'TmpCot','CidChaves')
ThisForm.ThisParent.poDataMgr.Update('CrSigCdCot')
Select CrSigCdMoe

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCOT.prg) - TRECHOS RELEVANTES PARA PASS SQL (765 linhas total):

*-- Linhas 7 a 25:
7: * Aberto por: FormMoe (botao de cotacoes da moeda selecionada)
8: * Layout: cnt_4c_Cabecalho (80px) + grd_4c_Cotacoes + 3 botoes
9: * Fase 3/8: Estrutura base completa (Init, cabecalho, grid, botoes, handlers)
10: * Fase 4/8: Colunas do grid (ControlSource, Headers, InputMask) + BINDEVENTs de celula
11: * Fase 5/8: BINDEVENTs de validacao nas celulas (Data/Cotacao/Hora KeyPress)
12: * Fase 6/8: SetFocus apos Inserir/Excluir (UX PILAR 1); form completo - sem
13: *           Page2, lookups ou campos adicionais (form de grid inline puro)
14: * Fase 7/8: BtnIncluirClick/BtnExcluirClick delegam para Cmd*; Alterar/Visualizar
15: *           sao no-ops (compatibilidade FormBase, dialog sem Page2 separada)
16: *===============================================================================
17: DEFINE CLASS FormSIGPRCOT AS FormBase
18: 
19:     *-- Dimensoes exatas do original (SIGPRCOT Width=537, Height=377)
20:     Width        = 537
21:     Height       = 377
22:     AutoCenter   = .T.
23:     TitleBar     = 0
24:     WindowType   = 1
25:     ShowWindow = 1

*-- Linhas 121 a 139:
121:     * Como este form OPERACIONAL nao possui PageFrame (nao ha Page1/Page2),
122:     * a "pagina lista" corresponde ao proprio form. Este metodo agrega o
123:     * Grid (grd_4c_Cotacoes) e os botoes CRUD (Inserir/Excluir/Encerrar) que
124:     * substituem os equivalentes do SCX legado (inserir/delete/sair).
125:     *===========================================================================
126:     PROTECTED PROCEDURE ConfigurarPaginaLista()
127:         *-- Grid de cotacoes com colunas Data, Hora, Cotacao e BINDEVENTs
128:         THIS.ConfigurarGrid()
129: 
130:         *-- Botoes Inserir / Excluir / Encerrar com BINDEVENT de Click
131:         THIS.ConfigurarBotoes()
132:     ENDPROC
133: 
134:     *===========================================================================
135:     * ConfigurarPaginaDados - Sem Page2 neste form OPERACIONAL
136:     * Dialog modal com grid de edicao inline. Metodo de compatibilidade
137:     * com o pipeline de migracao multi-fase.
138:     *===========================================================================
139:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 226 a 301:
226:             .FontName          = "Courier New"
227:             .FontSize          = 8
228:             .RowHeight         = 20
229:             .DeleteMark        = .F.
230:             .RecordMark        = .F.
231:             .ScrollBars        = 2
232:             .ReadOnly          = .F.
233:             .AllowHeaderSizing = .T.
234:             .Visible           = .T.
235: 
236:             *-- Column1: data (datas) - exibida na 1a posicao (ColumnOrder default)
237:             WITH .Column1
238:                 .Width         = 80
239:                 .Movable       = .F.
240:                 .Resizable     = .F.
241:                 .ReadOnly      = .F.
242:                 .SelectOnEntry = .F.
243:                 .Format        = "K"
244:                 .ControlSource = "cursor_4c_Cotacoes.datas"
245:                 .Header1.Caption   = "Data"
246:                 .Header1.Alignment = 2
247:                 .Text1.FontName    = "Courier New"
248:                 .Text1.BorderStyle = 0
249:                 .Text1.Format      = "K"
250:                 .Text1.Margin      = 0
251:                 .Text1.ReadOnly    = .F.
252:                 .Text1.ForeColor   = RGB(0, 0, 0)
253:                 .Text1.BackColor   = RGB(255, 255, 255)
254:             ENDWITH
255: 
256:             *-- Column2: cotacao (valos) - ColumnOrder=3, exibida na 3a posicao
257:             WITH .Column2
258:                 .ColumnOrder   = 3
259:                 .Width         = 101
260:                 .Movable       = .F.
261:                 .Resizable     = .F.
262:                 .ReadOnly      = .F.
263:                 .SelectOnEntry = .F.
264:                 .Format        = "K"
265:                 .InputMask     = "99999.9999999"
266:                 .ControlSource = "cursor_4c_Cotacoes.valos"
267:                 .Header1.Caption   = "Cota" + CHR(231) + CHR(227) + "o"
268:                 .Header1.Alignment = 2
269:                 .Text1.FontName    = "Courier New"
270:                 .Text1.BorderStyle = 0
271:                 .Text1.Format      = "K"
272:                 .Text1.Margin      = 0
273:                 .Text1.ReadOnly    = .F.
274:                 .Text1.ForeColor   = RGB(0, 0, 0)
275:                 .Text1.BackColor   = RGB(255, 255, 255)
276:             ENDWITH
277: 
278:             *-- Column3: hora (horas) - ColumnOrder=2, exibida na 2a posicao
279:             WITH .Column3
280:                 .ColumnOrder   = 2
281:                 .Width         = 55
282:                 .Movable       = .F.
283:                 .Resizable     = .F.
284:                 .ReadOnly      = .F.
285:                 .InputMask     = "99:99"
286:                 .ControlSource = "cursor_4c_Cotacoes.horas"
287:                 .Header1.Caption   = "Hora"
288:                 .Header1.Alignment = 2
289:                 .Text1.FontName    = "Courier New"
290:                 .Text1.BorderStyle = 0
291:                 .Text1.Margin      = 0
292:                 .Text1.ForeColor   = RGB(0, 0, 0)
293:                 .Text1.BackColor   = RGB(255, 255, 255)
294:             ENDWITH
295:         ENDWITH
296: 
297:         *-- BINDEVENT: AfterRowColChange - controle de editabilidade por linha
298:         BINDEVENT(THIS.grd_4c_Cotacoes, "AfterRowColChange", THIS, "GrdAfterRowColChange")
299: 
300:         *-- BINDEVENT: KeyPress nas celulas de data, cotacao e hora para validacao
301:         BINDEVENT(THIS.grd_4c_Cotacoes.Column1.Text1, "KeyPress", THIS, "GrdDataKeyPress")

*-- Linhas 401 a 484:
401:                 IF loc_lSucesso AND USED("cursor_4c_Cotacoes")
402:                     THIS.grd_4c_Cotacoes.ColumnCount = 3
403:                     THIS.grd_4c_Cotacoes.RecordSource = "cursor_4c_Cotacoes"
404:                     THIS.grd_4c_Cotacoes.Column1.ControlSource = "cursor_4c_Cotacoes.datas"
405:                     THIS.grd_4c_Cotacoes.Column2.ControlSource = "cursor_4c_Cotacoes.valos"
406:                     THIS.grd_4c_Cotacoes.Column3.ControlSource = "cursor_4c_Cotacoes.horas"
407:                     SELECT cursor_4c_Cotacoes
408:                     GO BOTTOM
409:                     THIS.this_nIncluir = 0
410:                     THIS.grd_4c_Cotacoes.Refresh()
411:                 ENDIF
412:             ENDIF
413:         CATCH TO loc_oErro
414:             MsgErro(loc_oErro.Message, "Erro ao carregar cota" + CHR(231) + CHR(245) + "es")
415:         ENDTRY
416:         RETURN loc_lSucesso
417:     ENDPROC
418: 
419:     *===========================================================================
420:     * CmdInserirClick - Insere nova cotacao para hoje nesta moeda
421:     * Replica inserir.Click do legado: verifica duplicata de hoje, insere nova
422:     * linha e posiciona grid para edicao do valor (valos)
423:     *===========================================================================
424:     PROCEDURE CmdInserirClick()
425:         LOCAL loc_lJaExiste
426:         TRY
427:             loc_lJaExiste = .F.
428: 
429:             IF USED("cursor_4c_Cotacoes")
430:                 SELECT cursor_4c_Cotacoes
431:                 SET ORDER TO cotacaos
432:                 IF SEEK(ALLTRIM(THIS.this_cMoes) + DTOS(DATE()))
433:                     loc_lJaExiste = .T.
434:                 ENDIF
435:                 SET ORDER TO
436:             ENDIF
437: 
438:             IF loc_lJaExiste
439:                 MsgAviso("J" + CHR(225) + " existe cota" + CHR(231) + CHR(227) + ;
440:                          "o para hoje nesta moeda.", "Aviso")
441:             ELSE
442:                 IF THIS.this_oBusinessObject.InserirNovaCotacao(THIS.this_cMoes)
443:                     IF USED("cursor_4c_Cotacoes")
444:                         SELECT cursor_4c_Cotacoes
445:                         GO BOTTOM
446:                         THIS.this_nIncluir = RECNO()
447:                     ENDIF
448:                     THIS.grd_4c_Cotacoes.Refresh()
449:                     *-- Posicionar foco na coluna Data para usuario digitar imediatamente
450:                     THIS.grd_4c_Cotacoes.SetFocus()
451:                 ENDIF
452:             ENDIF
453:         CATCH TO loc_oErro
454:             MsgErro(loc_oErro.Message, "Erro ao inserir cota" + CHR(231) + CHR(227) + "o")
455:         ENDTRY
456:     ENDPROC
457: 
458:     *===========================================================================
459:     * CmdExcluirClick - Exclui cotacao selecionada no grid
460:     * Replica delete.Click do legado: remove do SQL e recarrega cursor
461:     *===========================================================================
462:     PROCEDURE CmdExcluirClick()
463:         LOCAL loc_cCidChaves, loc_lProsseguir
464:         TRY
465:             loc_cCidChaves  = ""
466:             loc_lProsseguir = .F.
467: 
468:             IF USED("cursor_4c_Cotacoes")
469:                 SELECT cursor_4c_Cotacoes
470:                 IF !EOF() AND !BOF()
471:                     loc_cCidChaves  = ALLTRIM(cursor_4c_Cotacoes.cidchaves)
472:                     loc_lProsseguir = !EMPTY(loc_cCidChaves)
473:                 ELSE
474:                     MsgAviso("Nenhum registro selecionado para exclus" + CHR(227) + "o.", "Aviso")
475:                 ENDIF
476:             ENDIF
477: 
478:             IF loc_lProsseguir
479:                 IF THIS.this_oBusinessObject.ExcluirCotacaoAtual(loc_cCidChaves)
480:                     THIS.this_nIncluir = 0
481:                     THIS.CarregarCotacoes()
482:                     *-- Reposicionar foco no grid apos exclusao (comportamento do legado)
483:                     THIS.grd_4c_Cotacoes.SetFocus()
484:                 ENDIF

*-- Linhas 530 a 612:
530:     *===========================================================================
531:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
532:         IF USED("cursor_4c_Cotacoes")
533:             SELECT cursor_4c_Cotacoes
534:             IF RECNO() != THIS.this_nIncluir OR THIS.this_nIncluir = 0
535:                 THIS.this_nIncluir = 0
536:                 THIS.grd_4c_Cotacoes.Column1.ReadOnly = .T.
537:                 THIS.grd_4c_Cotacoes.Column2.ReadOnly = .T.
538:                 THIS.grd_4c_Cotacoes.Column3.ReadOnly = .T.
539:             ELSE
540:                 THIS.grd_4c_Cotacoes.Column1.ReadOnly = .F.
541:                 THIS.grd_4c_Cotacoes.Column2.ReadOnly = .F.
542:                 THIS.grd_4c_Cotacoes.Column3.ReadOnly = .F.
543:             ENDIF
544:         ENDIF
545:     ENDPROC
546: 
547:     *===========================================================================
548:     * GrdDataKeyPress - Valida que data nao esta vazia ao pressionar ENTER/TAB
549:     * Replica data.Text1.Valid do legado.
550:     *===========================================================================
551:     PROCEDURE GrdDataKeyPress(par_nKeyCode, par_nShiftAltCtrl)
552:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
553:             IF USED("cursor_4c_Cotacoes")
554:                 SELECT cursor_4c_Cotacoes
555:                 IF EMPTY(cursor_4c_Cotacoes.datas)
556:                     MsgAviso("Informe a data da Cota" + CHR(231) + CHR(227) + "o.", "Aviso")
557:                 ENDIF
558:             ENDIF
559:         ENDIF
560:     ENDPROC
561: 
562:     *===========================================================================
563:     * GrdCotacaoKeyPress - Apos editar cotacao (ENTER/TAB): vai ao ultimo registro e refresha
564:     * Replica cotacao.Text1.Valid do legado: Select TmpCot / Go Bottom / Refresh
565:     *===========================================================================
566:     PROCEDURE GrdCotacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
567:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
568:             IF USED("cursor_4c_Cotacoes")
569:                 SELECT cursor_4c_Cotacoes
570:                 GO BOTTOM
571:                 THIS.grd_4c_Cotacoes.Refresh()
572:             ENDIF
573:         ENDIF
574:     ENDPROC
575: 
576:     *===========================================================================
577:     * GrdHoraKeyPress - Verifica cotacao duplicada na data+hora ao pressionar ENTER/TAB
578:     * Replica hora.Text1.Valid do legado: detecta duplicidade e limpa hora.
579:     *===========================================================================
580:     PROCEDURE GrdHoraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
581:         LOCAL loc_cMoes, loc_dData, loc_cHora, loc_lDuplicada
582:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
583:             RETURN
584:         ENDIF
585:         TRY
586:             IF USED("cursor_4c_Cotacoes") AND THIS.this_nIncluir > 0
587:                 SELECT cursor_4c_Cotacoes
588:                 IF RECNO() = THIS.this_nIncluir
589:                     loc_cMoes      = ALLTRIM(THIS.this_cMoes)
590:                     loc_dData      = cursor_4c_Cotacoes.datas
591:                     loc_cHora      = ALLTRIM(cursor_4c_Cotacoes.horas)
592:                     loc_lDuplicada = .F.
593: 
594:                     IF !EMPTY(loc_cHora) AND !EMPTY(loc_dData)
595:                         SET ORDER TO cotacaos
596:                         IF SEEK(loc_cMoes + DTOS(loc_dData) + loc_cHora)
597:                             *-- Encontrou registro - verificar se nao eh o proprio insert
598:                             IF RECNO() != THIS.this_nIncluir
599:                                 loc_lDuplicada = .T.
600:                             ELSE
601:                                 SKIP
602:                                 IF !EOF()
603:                                     IF ALLTRIM(cmoes) + DTOS(datas) + ALLTRIM(horas) = ;
604:                                        loc_cMoes + DTOS(loc_dData) + loc_cHora
605:                                         loc_lDuplicada = .T.
606:                                     ENDIF
607:                                 ENDIF
608:                             ENDIF
609:                         ENDIF
610:                         SET ORDER TO
611: 
612:                         IF loc_lDuplicada


### BO (C:\4c\projeto\app\classes\SIGPRCOTBO.prg):
*==============================================================================
* SIGPRCOTBO.prg - Business Object para Cotacoes de Moeda
* Tabela: SigCdCot
* PK: cidchaves
*==============================================================================
DEFINE CLASS SIGPRCOTBO AS BusinessBase

    *-- Campos da tabela SigCdCot
    this_cCmoes     = ""    && char(3)       - Codigo da moeda
    this_dDatas     = {}    && date          - Data da cotacao
    this_cHoras     = ""    && char(8)       - Hora da cotacao (HH:MM:SS)
    this_nValos     = 0     && numeric(11,6) - Valor da cotacao
    this_cCidChaves = ""    && char(20)      - Chave unica (PK)
    this_dDtAlts    = {}    && date          - Data de alteracao
    this_cUsuars    = ""    && char(10)      - Usuario que cadastrou

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdCot"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Substituto do fUniqueIds() do legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarChaveUnica()
        RETURN LEFT(SYS(2015) + SYS(2015), 20)
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCmoes     = TratarNulo(cmoes,     "C")
            THIS.this_dDatas     = TratarNulo(datas,     "D")
            THIS.this_cHoras     = TratarNulo(horas,     "C")
            THIS.this_nValos     = TratarNulo(valos,     "N")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_dDtAlts    = TratarNulo(dtalts,    "D")
            THIS.this_cUsuars    = TratarNulo(usuars,    "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cCmoes)
            MsgAviso("Informe o c" + CHR(243) + "digo da moeda.", "Aviso")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDatas)
            MsgAviso("Informe a data da cota" + CHR(231) + CHR(227) + "o.", "Aviso")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cHoras)
            MsgAviso("Informe a hora da cota" + CHR(231) + CHR(227) + "o.", "Aviso")
            RETURN .F.
        ENDIF
        IF THIS.this_nValos = 0
            MsgAviso("Informe o valor da cota" + CHR(231) + CHR(227) + "o.", "Aviso")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarInsercao - Override BusinessBase: INSERT com this_* properties
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarInsercao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = THIS.GerarChaveUnica()
            ENDIF
            THIS.this_dDtAlts = DATE()
            THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)

            loc_cSQL = "INSERT INTO SigCdCot " + ;
                       "(cmoes, datas, horas, valos, cidchaves, dtalts, usuars) " + ;
                       "VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCmoes))    + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas)         + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cHoras))    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValos)       + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtAlts)        + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cUsuars))   + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarAtualizacao - Override BusinessBase: UPDATE com this_* properties
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarAtualizacao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            THIS.this_dDtAlts = DATE()
            THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)

            loc_cSQL = "UPDATE SigCdCot SET " + ;
                       "datas  = " + FormatarDataSQL(THIS.this_dDatas)      + ", " + ;
                       "horas  = " + EscaparSQL(ALLTRIM(THIS.this_cHoras))  + ", " + ;
                       "valos  = " + FormatarNumeroSQL(THIS.this_nValos)    + ", " + ;
                       "dtalts = " + FormatarDataSQL(THIS.this_dDtAlts)     + ", " + ;
                       "usuars = " + EscaparSQL(ALLTRIM(THIS.this_cUsuars)) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Override BusinessBase: DELETE pela PK
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdCot WHERE cidchaves = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacoes - Carrega cotacoes de uma moeda no cursor de trabalho
    * Usa cursor temporario + ZAP/APPEND para nao destruir colunas do grid
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCotacoes(par_cMoes)
        LOCAL loc_lSucesso, loc_cSQL, loc_cMoesFmt
        loc_lSucesso = .F.
        TRY
            loc_cMoesFmt = EscaparSQL(ALLTRIM(par_cMoes))
            loc_cSQL = "SELECT cmoes, datas, horas, valos, cidchaves, dtalts, usuars " + ;
                       "FROM SigCdCot " + ;
                       "WHERE cmoes = " + loc_cMoesFmt + " " + ;
                       "ORDER BY datas, horas"

            IF USED("cursor_4c_CotacoesTemp")
                USE IN cursor_4c_CotacoesTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotacoesTemp") > 0
                IF USED("cursor_4c_Cotacoes")
                    *-- Cursor ja existe (grid bound): apenas limpar e recarregar
                    SELECT cursor_4c_Cotacoes
                    ZAP
                    APPEND FROM DBF("cursor_4c_CotacoesTemp")
                    GO BOTTOM
                ELSE
                    *-- Primeira carga: criar cursor com estrutura e indices
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Cotacoes ;
                        (cmoes C(3) NULL, datas D NULL, horas C(8) NULL, ;
                         valos N(11,6) NULL, cidchaves C(20) NULL, ;
                         dtalts D NULL, usuars C(10) NULL)
                    SET NULL OFF
                    INDEX ON ALLTRIM(cidchaves) TAG cidchaves
                    INDEX ON ALLTRIM(cmoes) + DTOS(datas) + ALLTRIM(horas) TAG cotacaos
                    APPEND FROM DBF("cursor_4c_CotacoesTemp")
                    GO BOTTOM
                ENDIF
                USE IN cursor_4c_CotacoesTemp
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar cota" + CHR(231) + CHR(245) + "es.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirNovaCotacao - Insere nova linha com data/hora atuais e valos=0
    * Replica inserir.Click do legado: persiste no SQL + adiciona ao cursor local
    * O usuario preenche o valor (valos) diretamente no grid apos a insercao
    *--------------------------------------------------------------------------
    PROCEDURE InserirNovaCotacao(par_cMoes)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_cMoesFmt
        LOCAL loc_cDtFmt, loc_cHora, loc_cDtAltFmt, loc_cUsuFmt
        loc_lSucesso = .F.
        TRY
            loc_cChave    = THIS.GerarChaveUnica()
            loc_cMoesFmt  = EscaparSQL(ALLTRIM(par_cMoes))
            loc_cDtFmt    = FormatarDataSQL(DATE())
            loc_cHora     = TIME()
            loc_cDtAltFmt = FormatarDataSQL(DATE())
            loc_cUsuFmt   = EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))

            *-- Inserir no SQL Server sem valos (usuario preenche no grid)
            loc_cSQL = "INSERT INTO SigCdCot " + ;
                       "(cmoes, datas, horas, cidchaves, dtalts, usuars) " + ;
                       "VALUES (" + ;
                       loc_cMoesFmt          + ", " + ;
                       loc_cDtFmt            + ", " + ;
                       EscaparSQL(loc_cHora) + ", " + ;
                       EscaparSQL(loc_cChave)+ ", " + ;
                       loc_cDtAltFmt         + ", " + ;
                       loc_cUsuFmt           + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                *-- Adicionar ao cursor de trabalho para exibicao imediata no grid
                IF USED("cursor_4c_Cotacoes")
                    SELECT cursor_4c_Cotacoes
                    SET ORDER TO
                    INSERT INTO cursor_4c_Cotacoes ;
                        (cmoes, datas, horas, valos, cidchaves, dtalts, usuars) ;
                        VALUES ;
                        (par_cMoes, DATE(), loc_cHora, 0, ;
                         loc_cChave, DATE(), ALLTRIM(gc_4c_UsuarioLogado))
                ENDIF
                THIS.this_cCidChaves = loc_cChave
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirCotacaoAtual - Exclui cotacao do SQL Server pelo cidchaves
    * Replica delete.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirCotacaoAtual(par_cCidChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChaveFmt
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cCidChaves)
                MsgAviso("Nenhum registro selecionado para exclus" + CHR(227) + "o.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            loc_cChaveFmt = EscaparSQL(ALLTRIM(par_cCidChaves))
            loc_cSQL = "DELETE FROM SigCdCot WHERE cidchaves = " + loc_cChaveFmt

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.this_cCidChaves = par_cCidChaves
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCotacaoDuplicada - Checa se ja existe cotacao para moeda+data+hora
    * Replica hora.Text1.Valid do legado
    * Retorna .T. se duplicata encontrada (excluindo o proprio registro atual)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCotacaoDuplicada(par_cMoes, par_dDatas, par_cHoras, par_cCidChavesAtual)
        LOCAL loc_lDuplicada
        loc_lDuplicada = .F.
        TRY
            IF USED("cursor_4c_Cotacoes")
                SELECT cursor_4c_Cotacoes
                SET ORDER TO cotacaos
                IF SEEK(ALLTRIM(par_cMoes) + DTOS(par_dDatas) + ALLTRIM(par_cHoras))
                    IF ALLTRIM(cidchaves) <> ALLTRIM(par_cCidChavesAtual)
                        loc_lDuplicada = .T.
                    ENDIF
                ENDIF
                SET ORDER TO
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lDuplicada
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarCotacoes - Persiste todas as alteracoes do cursor no SQL Server
    * Replica sair.Click do legado: remove invalidos e atualiza validos
    *--------------------------------------------------------------------------
    PROCEDURE SalvarCotacoes()
        LOCAL loc_lSucesso, loc_cSQL, loc_cChaveFmt, loc_cDtFmt, loc_cHoraFmt, loc_cValFmt
        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Cotacoes")
                loc_lSucesso = .F.
            ENDIF

            *-- Remover registros invalidos (sem data)
            SELECT cursor_4c_Cotacoes
            GO TOP
            SCAN
                IF EMPTY(cursor_4c_Cotacoes.datas)
                    IF !EMPTY(ALLTRIM(cursor_4c_Cotacoes.cidchaves))
                        loc_cChaveFmt = EscaparSQL(ALLTRIM(cursor_4c_Cotacoes.cidchaves))
                        loc_cSQL = "DELETE FROM SigCdCot WHERE cidchaves = " + loc_cChaveFmt
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ENDIF
                    DELETE
                ENDIF
                SELECT cursor_4c_Cotacoes
            ENDSCAN

            *-- Atualizar registros validos no SQL Server com valores editados no grid
            SELECT cursor_4c_Cotacoes
            GO TOP
            SCAN
                IF !DELETED() AND !EMPTY(ALLTRIM(cursor_4c_Cotacoes.cidchaves))
                    loc_cChaveFmt = EscaparSQL(ALLTRIM(cursor_4c_Cotacoes.cidchaves))
                    loc_cDtFmt    = FormatarDataSQL(cursor_4c_Cotacoes.datas)
                    loc_cHoraFmt  = EscaparSQL(ALLTRIM(cursor_4c_Cotacoes.horas))
                    loc_cValFmt   = FormatarNumeroSQL(cursor_4c_Cotacoes.valos)

                    loc_cSQL = "UPDATE SigCdCot SET " + ;
                               "datas = " + loc_cDtFmt   + ", " + ;
                               "horas = " + loc_cHoraFmt + ", " + ;
                               "valos = " + loc_cValFmt  + " " + ;
                               "WHERE cidchaves = " + loc_cChaveFmt

                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDIF
                SELECT cursor_4c_Cotacoes
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

