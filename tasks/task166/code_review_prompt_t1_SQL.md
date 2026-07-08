# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INCLUIR, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VALOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INCLUIR, CIDCHAVES
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCOT.prg) - TRECHOS RELEVANTES PARA PASS SQL (758 linhas total):

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

*-- Linhas 117 a 135:
117:     * Como este form OPERACIONAL nao possui PageFrame (nao ha Page1/Page2),
118:     * a "pagina lista" corresponde ao proprio form. Este metodo agrega o
119:     * Grid (grd_4c_Cotacoes) e os botoes CRUD (Inserir/Excluir/Encerrar) que
120:     * substituem os equivalentes do SCX legado (inserir/delete/sair).
121:     *===========================================================================
122:     PROTECTED PROCEDURE ConfigurarPaginaLista()
123:         *-- Grid de cotacoes com colunas Data, Hora, Cotacao e BINDEVENTs
124:         THIS.ConfigurarGrid()
125: 
126:         *-- Botoes Inserir / Excluir / Encerrar com BINDEVENT de Click
127:         THIS.ConfigurarBotoes()
128:     ENDPROC
129: 
130:     *===========================================================================
131:     * ConfigurarPaginaDados - Sem Page2 neste form OPERACIONAL
132:     * Dialog modal com grid de edicao inline. Metodo de compatibilidade
133:     * com o pipeline de migracao multi-fase.
134:     *===========================================================================
135:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 222 a 297:
222:             .FontName          = "Courier New"
223:             .FontSize          = 8
224:             .RowHeight         = 20
225:             .DeleteMark        = .F.
226:             .RecordMark        = .F.
227:             .ScrollBars        = 2
228:             .ReadOnly          = .F.
229:             .AllowHeaderSizing = .T.
230:             .Visible           = .T.
231: 
232:             *-- Column1: data (datas) - exibida na 1a posicao (ColumnOrder default)
233:             WITH .Column1
234:                 .Width         = 80
235:                 .Movable       = .F.
236:                 .Resizable     = .F.
237:                 .ReadOnly      = .F.
238:                 .SelectOnEntry = .F.
239:                 .Format        = "K"
240:                 .ControlSource = "cursor_4c_Cotacoes.datas"
241:                 .Header1.Caption   = "Data"
242:                 .Header1.Alignment = 2
243:                 .Text1.FontName    = "Courier New"
244:                 .Text1.BorderStyle = 0
245:                 .Text1.Format      = "K"
246:                 .Text1.Margin      = 0
247:                 .Text1.ReadOnly    = .F.
248:                 .Text1.ForeColor   = RGB(0, 0, 0)
249:                 .Text1.BackColor   = RGB(255, 255, 255)
250:             ENDWITH
251: 
252:             *-- Column2: cotacao (valos) - ColumnOrder=3, exibida na 3a posicao
253:             WITH .Column2
254:                 .ColumnOrder   = 3
255:                 .Width         = 101
256:                 .Movable       = .F.
257:                 .Resizable     = .F.
258:                 .ReadOnly      = .F.
259:                 .SelectOnEntry = .F.
260:                 .Format        = "K"
261:                 .InputMask     = "99999.9999999"
262:                 .ControlSource = "cursor_4c_Cotacoes.valos"
263:                 .Header1.Caption   = "Cota" + CHR(231) + CHR(227) + "o"
264:                 .Header1.Alignment = 2
265:                 .Text1.FontName    = "Courier New"
266:                 .Text1.BorderStyle = 0
267:                 .Text1.Format      = "K"
268:                 .Text1.Margin      = 0
269:                 .Text1.ReadOnly    = .F.
270:                 .Text1.ForeColor   = RGB(0, 0, 0)
271:                 .Text1.BackColor   = RGB(255, 255, 255)
272:             ENDWITH
273: 
274:             *-- Column3: hora (horas) - ColumnOrder=2, exibida na 2a posicao
275:             WITH .Column3
276:                 .ColumnOrder   = 2
277:                 .Width         = 55
278:                 .Movable       = .F.
279:                 .Resizable     = .F.
280:                 .ReadOnly      = .F.
281:                 .InputMask     = "99:99"
282:                 .ControlSource = "cursor_4c_Cotacoes.horas"
283:                 .Header1.Caption   = "Hora"
284:                 .Header1.Alignment = 2
285:                 .Text1.FontName    = "Courier New"
286:                 .Text1.BorderStyle = 0
287:                 .Text1.Margin      = 0
288:                 .Text1.ForeColor   = RGB(0, 0, 0)
289:                 .Text1.BackColor   = RGB(255, 255, 255)
290:             ENDWITH
291:         ENDWITH
292: 
293:         *-- BINDEVENT: AfterRowColChange - controle de editabilidade por linha
294:         BINDEVENT(THIS.grd_4c_Cotacoes, "AfterRowColChange", THIS, "GrdAfterRowColChange")
295: 
296:         *-- BINDEVENT: KeyPress nas celulas de data, cotacao e hora para validacao
297:         BINDEVENT(THIS.grd_4c_Cotacoes.Column1.Text1, "KeyPress", THIS, "GrdDataKeyPress")

*-- Linhas 397 a 477:
397:                 IF loc_lSucesso AND USED("cursor_4c_Cotacoes")
398:                     THIS.grd_4c_Cotacoes.ColumnCount = 3
399:                     THIS.grd_4c_Cotacoes.RecordSource = "cursor_4c_Cotacoes"
400:                     SELECT cursor_4c_Cotacoes
401:                     GO BOTTOM
402:                     THIS.this_nIncluir = 0
403:                     THIS.grd_4c_Cotacoes.Refresh()
404:                 ENDIF
405:             ENDIF
406:         CATCH TO loc_oErro
407:             MsgErro(loc_oErro.Message, "Erro ao carregar cota" + CHR(231) + CHR(245) + "es")
408:         ENDTRY
409:         RETURN loc_lSucesso
410:     ENDPROC
411: 
412:     *===========================================================================
413:     * CmdInserirClick - Insere nova cotacao para hoje nesta moeda
414:     * Replica inserir.Click do legado: verifica duplicata de hoje, insere nova
415:     * linha e posiciona grid para edicao do valor (valos)
416:     *===========================================================================
417:     PROCEDURE CmdInserirClick()
418:         LOCAL loc_lJaExiste
419:         TRY
420:             loc_lJaExiste = .F.
421: 
422:             IF USED("cursor_4c_Cotacoes")
423:                 SELECT cursor_4c_Cotacoes
424:                 SET ORDER TO cotacaos
425:                 IF SEEK(ALLTRIM(THIS.this_cMoes) + DTOS(DATE()))
426:                     loc_lJaExiste = .T.
427:                 ENDIF
428:                 SET ORDER TO
429:             ENDIF
430: 
431:             IF loc_lJaExiste
432:                 MsgAviso("J" + CHR(225) + " existe cota" + CHR(231) + CHR(227) + ;
433:                          "o para hoje nesta moeda.", "Aviso")
434:             ELSE
435:                 IF THIS.this_oBusinessObject.InserirNovaCotacao(THIS.this_cMoes)
436:                     IF USED("cursor_4c_Cotacoes")
437:                         SELECT cursor_4c_Cotacoes
438:                         GO BOTTOM
439:                         THIS.this_nIncluir = RECNO()
440:                     ENDIF
441:                     THIS.grd_4c_Cotacoes.Refresh()
442:                     *-- Posicionar foco na coluna Data para usuario digitar imediatamente
443:                     THIS.grd_4c_Cotacoes.SetFocus()
444:                 ENDIF
445:             ENDIF
446:         CATCH TO loc_oErro
447:             MsgErro(loc_oErro.Message, "Erro ao inserir cota" + CHR(231) + CHR(227) + "o")
448:         ENDTRY
449:     ENDPROC
450: 
451:     *===========================================================================
452:     * CmdExcluirClick - Exclui cotacao selecionada no grid
453:     * Replica delete.Click do legado: remove do SQL e recarrega cursor
454:     *===========================================================================
455:     PROCEDURE CmdExcluirClick()
456:         LOCAL loc_cCidChaves, loc_lProsseguir
457:         TRY
458:             loc_cCidChaves  = ""
459:             loc_lProsseguir = .F.
460: 
461:             IF USED("cursor_4c_Cotacoes")
462:                 SELECT cursor_4c_Cotacoes
463:                 IF !EOF() AND !BOF()
464:                     loc_cCidChaves  = ALLTRIM(cursor_4c_Cotacoes.cidchaves)
465:                     loc_lProsseguir = !EMPTY(loc_cCidChaves)
466:                 ELSE
467:                     MsgAviso("Nenhum registro selecionado para exclus" + CHR(227) + "o.", "Aviso")
468:                 ENDIF
469:             ENDIF
470: 
471:             IF loc_lProsseguir
472:                 IF THIS.this_oBusinessObject.ExcluirCotacaoAtual(loc_cCidChaves)
473:                     THIS.this_nIncluir = 0
474:                     THIS.CarregarCotacoes()
475:                     *-- Reposicionar foco no grid apos exclusao (comportamento do legado)
476:                     THIS.grd_4c_Cotacoes.SetFocus()
477:                 ENDIF

*-- Linhas 523 a 605:
523:     *===========================================================================
524:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
525:         IF USED("cursor_4c_Cotacoes")
526:             SELECT cursor_4c_Cotacoes
527:             IF RECNO() != THIS.this_nIncluir OR THIS.this_nIncluir = 0
528:                 THIS.this_nIncluir = 0
529:                 THIS.grd_4c_Cotacoes.Column1.ReadOnly = .T.
530:                 THIS.grd_4c_Cotacoes.Column2.ReadOnly = .T.
531:                 THIS.grd_4c_Cotacoes.Column3.ReadOnly = .T.
532:             ELSE
533:                 THIS.grd_4c_Cotacoes.Column1.ReadOnly = .F.
534:                 THIS.grd_4c_Cotacoes.Column2.ReadOnly = .F.
535:                 THIS.grd_4c_Cotacoes.Column3.ReadOnly = .F.
536:             ENDIF
537:         ENDIF
538:     ENDPROC
539: 
540:     *===========================================================================
541:     * GrdDataKeyPress - Valida que data nao esta vazia ao pressionar ENTER/TAB
542:     * Replica data.Text1.Valid do legado.
543:     *===========================================================================
544:     PROCEDURE GrdDataKeyPress(par_nKeyCode, par_nShiftAltCtrl)
545:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
546:             IF USED("cursor_4c_Cotacoes")
547:                 SELECT cursor_4c_Cotacoes
548:                 IF EMPTY(cursor_4c_Cotacoes.datas)
549:                     MsgAviso("Informe a data da Cota" + CHR(231) + CHR(227) + "o.", "Aviso")
550:                 ENDIF
551:             ENDIF
552:         ENDIF
553:     ENDPROC
554: 
555:     *===========================================================================
556:     * GrdCotacaoKeyPress - Apos editar cotacao (ENTER/TAB): vai ao ultimo registro e refresha
557:     * Replica cotacao.Text1.Valid do legado: Select TmpCot / Go Bottom / Refresh
558:     *===========================================================================
559:     PROCEDURE GrdCotacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
560:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
561:             IF USED("cursor_4c_Cotacoes")
562:                 SELECT cursor_4c_Cotacoes
563:                 GO BOTTOM
564:                 THIS.grd_4c_Cotacoes.Refresh()
565:             ENDIF
566:         ENDIF
567:     ENDPROC
568: 
569:     *===========================================================================
570:     * GrdHoraKeyPress - Verifica cotacao duplicada na data+hora ao pressionar ENTER/TAB
571:     * Replica hora.Text1.Valid do legado: detecta duplicidade e limpa hora.
572:     *===========================================================================
573:     PROCEDURE GrdHoraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
574:         LOCAL loc_cMoes, loc_dData, loc_cHora, loc_lDuplicada
575:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
576:             RETURN
577:         ENDIF
578:         TRY
579:             IF USED("cursor_4c_Cotacoes") AND THIS.this_nIncluir > 0
580:                 SELECT cursor_4c_Cotacoes
581:                 IF RECNO() = THIS.this_nIncluir
582:                     loc_cMoes      = ALLTRIM(THIS.this_cMoes)
583:                     loc_dData      = cursor_4c_Cotacoes.datas
584:                     loc_cHora      = ALLTRIM(cursor_4c_Cotacoes.horas)
585:                     loc_lDuplicada = .F.
586: 
587:                     IF !EMPTY(loc_cHora) AND !EMPTY(loc_dData)
588:                         SET ORDER TO cotacaos
589:                         IF SEEK(loc_cMoes + DTOS(loc_dData) + loc_cHora)
590:                             *-- Encontrou registro - verificar se nao eh o proprio insert
591:                             IF RECNO() != THIS.this_nIncluir
592:                                 loc_lDuplicada = .T.
593:                             ELSE
594:                                 SKIP
595:                                 IF !EOF()
596:                                     IF ALLTRIM(cmoes) + DTOS(datas) + ALLTRIM(horas) = ;
597:                                        loc_cMoes + DTOS(loc_dData) + loc_cHora
598:                                         loc_lDuplicada = .T.
599:                                     ENDIF
600:                                 ENDIF
601:                             ENDIF
602:                         ENDIF
603:                         SET ORDER TO
604: 
605:                         IF loc_lDuplicada


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

            *-- Remover registros invalidos (sem data ou sem valor)
            SELECT cursor_4c_Cotacoes
            GO TOP
            SCAN
                IF EMPTY(cursor_4c_Cotacoes.datas) OR cursor_4c_Cotacoes.valos = 0
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

