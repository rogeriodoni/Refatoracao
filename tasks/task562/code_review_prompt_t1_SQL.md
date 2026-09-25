# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CHAVENOTA, QT
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CHAVENOTA, QT

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
Select crChaves
This.Grade.Column1.ControlSource = [crChaves.ChaveNota]
This.Grade.Column1.ControlSource = []
Select crChaves
Select crChaves
=TableUpdate(.T.)
	Insert Into crChaves(ChaveNota, EmpDopNums, pkChaves) values ([], ThisForm.pEmpDopNums, Sys(2015)+Sys(2015)) 
Select crChaves
SELECT crChaves
Delete
	Select crChaves	
	Select ChaveNota, Count(*) as qt from crChaves where ChaveNota = This.Value Group by ChaveNota Into Cursor csRegDup ReadWrite
	Select csRegDup

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigMvChv.prg) - TRECHOS RELEVANTES PARA PASS SQL (941 linhas total):

*-- Linhas 195 a 213:
195:             IF USED("cursor_4c_Dados")
196:                 USE IN cursor_4c_Dados
197:             ENDIF
198:             CREATE CURSOR cursor_4c_Dados ;
199:                 (ChaveNota C(44) NULL, EmpDopNums C(29) NULL, pkChaves C(20) NULL)
200:             SET NULL OFF
201: 
202:             *-- CommandGroup Confirmar/Cancelar (cntBotoes do legado)
203:             *-- Buttons(1)=Cancelar (Left=80, equivale a Command1/btnSair),
204:             *-- Buttons(2)=Confirmar (Left=5, equivale a Command2/btnConfirmar)
205:             THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
206:             loc_oCmg = THIS.cmg_4c_Botoes
207:             WITH loc_oCmg
208:                 .Top           = -2
209:                 .Left          = 344
210:                 .Width         = 160
211:                 .Height        = 85
212:                 .ButtonCount   = 2
213:                 .AutoSize      = .T.

*-- Linhas 279 a 297:
279:                 .RowHeight     = 16
280:                 .ScrollBars    = 2
281:                 .ReadOnly      = .F.
282:                 .DeleteMark    = .F.
283:                 .RecordMark    = .F.
284:                 .GridLineColor = RGB(238, 238, 238)
285:             ENDWITH
286: 
287:             WITH loc_oGrd.Column1
288:                 .FontName  = "Tahoma"
289:                 .FontSize  = 8
290:                 .Width     = 310
291:                 .Movable   = .F.
292:                 .Resizable = .F.
293:                 .ReadOnly  = !THIS.this_lModoEdicao
294:             ENDWITH
295:             loc_oGrd.Column1.Header1.Caption   = "Chave"
296:             loc_oGrd.Column1.Header1.Alignment = 2
297:             WITH loc_oGrd.Column1.Text1

*-- Linhas 306 a 327:
306:             ENDWITH
307: 
308:             *-- RecordSource por ultimo (regra "Column.Width vai por ultimo" -
309:             *-- resetar RecordSource/ControlSource reseta Width/Header)
310:             loc_oGrd.ColumnCount = 1
311:             loc_oGrd.RecordSource            = "cursor_4c_Dados"
312:             loc_oGrd.Column1.ControlSource   = "cursor_4c_Dados.ChaveNota"
313:             loc_oGrd.Column1.Header1.Caption = "Chave"
314:             loc_oGrd.Column1.Width           = 310
315:             loc_oGrd.Column1.ReadOnly        = !THIS.this_lModoEdicao
316: 
317:             IF THIS.this_lModoEdicao
318:                 BINDEVENT(loc_oGrd.Column1.Text1, "KeyPress", THIS, "ValidarChaveGrade")
319:             ENDIF
320: 
321:             *-- Botoes standalone Incluir/Excluir - habilitados so em
322:             *-- INSERIR/ALTERAR (equivalente ao When legado
323:             *-- "Return(INLIST(Thisform.pcEscolha,'INSERIR','ALTERAR'))")
324:             THIS.AddObject("cmd_4c_Incluir", "CommandButton")
325:             WITH THIS.cmd_4c_Incluir
326:                 .Top             = 171
327:                 .Left = 5

*-- Linhas 370 a 419:
370:     *==========================================================================
371:     * CarregarLista - (Re)carrega as chaves do documento no cursor_4c_Dados
372:     * via BO e rebinda a grade (o BO fecha/recria o cursor a cada chamada,
373:     * entao RecordSource/ControlSource/Header/Width precisam ser reaplicados).
374:     *==========================================================================
375:     PROCEDURE CarregarLista()
376:         LOCAL loc_lOk, loc_oErro
377:         loc_lOk = .F.
378: 
379:         TRY
380:             loc_lOk = THIS.this_oBusinessObject.Buscar(THIS.this_cEmpDopNums)
381: 
382:             IF loc_lOk AND USED("cursor_4c_Dados") AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
383:                 THIS.grd_4c_Dados.RecordSource           = "cursor_4c_Dados"
384:                 THIS.grd_4c_Dados.Column1.ControlSource  = "cursor_4c_Dados.ChaveNota"
385:                 THIS.grd_4c_Dados.Column1.Header1.Caption = "Chave"
386:                 THIS.grd_4c_Dados.Column1.Width          = 310
387:                 THIS.grd_4c_Dados.Column1.ReadOnly       = !THIS.this_lModoEdicao
388: 
389:                 SELECT cursor_4c_Dados
390:                 GO TOP
391:                 THIS.grd_4c_Dados.Refresh()
392:             ENDIF
393:         CATCH TO loc_oErro
394:             MsgErro(loc_oErro.Message + CHR(13) + ;
395:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
396:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
397:         ENDTRY
398: 
399:         RETURN loc_lOk
400:     ENDPROC
401: 
402:     *==========================================================================
403:     * ValidarChaveGrade - KeyPress (ENTER/TAB) na coluna Chave (Column1) da
404:     * grade. Verifica duplicidade no cursor local (equivale ao "Select
405:     * ChaveNota, Count(*) ... Group By" do Valid legado, rodado sobre o
406:     * mesmo cursor crChaves que esta sendo editado) e persiste a linha
407:     * imediatamente via BO (arquitetura em camadas - PILAR 3, a tabela real
408:     * SigMvChv existe e o BO ja implementa Inserir/Atualizar via Salvar()).
409:     *==========================================================================
410:     PROCEDURE ValidarChaveGrade(par_nKeyCode, par_nShiftAltCtrl)
411:         LOCAL loc_cVal, loc_cPkAtual, loc_lNovo, loc_oErro, loc_lProsseguir
412: 
413:         *-- Teclas que ENCERRAM a edicao da celula. O Valid do legado dispara
414:         *-- ao SAIR do campo por qualquer meio; num Grid a saida mais comum
415:         *-- nem eh ENTER/TAB, sao as SETAS (que trocam de linha). Sem 5/24 o
416:         *-- usuario digita a chave, aperta seta e a linha nunca eh gravada -
417:         *-- perda silenciosa. Codigos VFP9 de KeyPress: ENTER=13, TAB=9,
418:         *-- SETA-ACIMA=5, SETA-ABAIXO=24. (BINDEVENT em "Valid" nao dispara
419:         *-- de forma confiavel em TextBox e LostFocus recursaria - regra #3.)

*-- Linhas 431 a 485:
431:             RETURN
432:         ENDIF
433: 
434:         SELECT cursor_4c_Dados
435: 
436:         *-- Valor inalterado numa linha JA gravada: nada a fazer. Sem este
437:         *-- guard, cada ENTER/TAB/seta sobre uma linha existente repetiria o
438:         *-- UPDATE e o BusinessBase gravaria um registro de auditoria a cada
439:         *-- navegacao (RegistrarAuditoria roda dentro de Atualizar()).
440:         IF ALLTRIM(NVL(ChaveNota, "")) == loc_cVal ;
441:                 AND !EMPTY(ALLTRIM(NVL(pkChaves, "")))
442:             RETURN
443:         ENDIF
444: 
445:         REPLACE ChaveNota WITH loc_cVal
446: 
447:         IF THIS.VerificarChaveDuplicada()
448:             MsgAviso("Registro j" + CHR(225) + " informado.", "Aviso")
449:             SELECT cursor_4c_Dados
450:             REPLACE ChaveNota WITH ""
451:             THIS.grd_4c_Dados.Refresh()
452:             RETURN
453:         ENDIF
454: 
455:         loc_lProsseguir = .T.
456: 
457:         TRY
458:             loc_cPkAtual = ALLTRIM(NVL(cursor_4c_Dados.pkChaves, ""))
459:             loc_lNovo    = EMPTY(loc_cPkAtual)
460: 
461:             *-- VerificarChaveDuplicada acima so enxerga o cursor local (igual
462:             *-- ao Valid legado, que agrupa so sobre crChaves). Como esta
463:             *-- arquitetura grava cada linha na tabela real SigMvChv na hora
464:             *-- (PILAR 3 - o legado deixava isso tudo comentado), confirmar
465:             *-- tambem contra o banco evita duplicar a chave quando outra
466:             *-- sessao gravou a mesma ChaveNota para o mesmo documento entre a
467:             *-- carga da lista e este Salvar.
468:             IF THIS.this_oBusinessObject.ExisteChaveDuplicada(loc_cVal, loc_cPkAtual)
469:                 MsgAviso("Registro j" + CHR(225) + " informado.", "Aviso")
470:                 SELECT cursor_4c_Dados
471:                 REPLACE ChaveNota WITH ""
472:                 THIS.grd_4c_Dados.Refresh()
473:                 loc_lProsseguir = .F.
474:             ENDIF
475: 
476:             IF loc_lProsseguir
477:                 IF loc_lNovo
478:                     THIS.this_oBusinessObject.NovoRegistro()
479:                 ELSE
480:                     THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
481: 
482:                     *-- EditarRegistro() recusa (retorna .F.) enquanto
483:                     *-- this_lNovoRegistro estiver ligado. Salvar() so desliga
484:                     *-- essa flag quando a gravacao DA CERTO, entao uma inclusao
485:                     *-- que falhou deixa o BO marcado como "novo": a linha

*-- Linhas 510 a 540:
510:     *==========================================================================
511:     * VerificarChaveDuplicada - Verifica se a ChaveNota da linha corrente do
512:     * cursor_4c_Dados ja foi informada em outra linha da grade (equivale ao
513:     * "Select ChaveNota, Count(*) as qt ... Group by ChaveNota" do Valid
514:     * legado, rodado sobre o cursor local).
515:     *==========================================================================
516:     PROCEDURE VerificarChaveDuplicada()
517:         LOCAL loc_nRecAtual, loc_cChave, loc_lDuplicado
518: 
519:         loc_lDuplicado = .F.
520: 
521:         IF !USED("cursor_4c_Dados")
522:             RETURN loc_lDuplicado
523:         ENDIF
524: 
525:         SELECT cursor_4c_Dados
526:         loc_nRecAtual = RECNO()
527:         loc_cChave    = ALLTRIM(ChaveNota)
528: 
529:         IF !EMPTY(loc_cChave)
530:             LOCATE FOR ALLTRIM(ChaveNota) == loc_cChave AND RECNO() != loc_nRecAtual
531:             loc_lDuplicado = FOUND()
532:         ENDIF
533: 
534:         IF BETWEEN(loc_nRecAtual, 1, RECCOUNT("cursor_4c_Dados"))
535:             GO loc_nRecAtual IN cursor_4c_Dados
536:         ENDIF
537: 
538:         RETURN loc_lDuplicado
539:     ENDPROC
540: 

*-- Linhas 560 a 578:
560:             RETURN loc_lOk
561:         ENDIF
562: 
563:         SELECT cursor_4c_Dados
564: 
565:         IF EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
566:             RETURN loc_lOk
567:         ENDIF
568: 
569:         loc_cChave = IIF(VARTYPE(par_cChaveNota) = "C", ;
570:                          ALLTRIM(par_cChaveNota), ;
571:                          ALLTRIM(NVL(cursor_4c_Dados.ChaveNota, "")))
572: 
573:         WITH THIS.this_oBusinessObject
574:             .this_cChaveNota  = loc_cChave
575:             .this_cEmpDopNums = THIS.this_cEmpDopNums
576: 
577:             *-- Linha nova tem pkChaves vazia no cursor; Inserir() gera a chave
578:             *-- via fUniqueIds(). Linha existente ja veio de CarregarDoCursor,

*-- Linhas 603 a 621:
603:             RETURN loc_lOk
604:         ENDIF
605: 
606:         SELECT cursor_4c_Dados
607: 
608:         IF EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
609:             RETURN loc_lOk
610:         ENDIF
611: 
612:         REPLACE ChaveNota  WITH ALLTRIM(THIS.this_oBusinessObject.this_cChaveNota), ;
613:                 EmpDopNums WITH ALLTRIM(THIS.this_oBusinessObject.this_cEmpDopNums), ;
614:                 pkChaves   WITH ALLTRIM(THIS.this_oBusinessObject.this_cPkChaves)
615: 
616:         loc_lOk = .T.
617: 
618:         RETURN loc_lOk
619:     ENDPROC
620: 
621:     *==========================================================================

*-- Linhas 641 a 659:
641:         TRY
642:             THIS.LockScreen = .T.
643: 
644:             SELECT cursor_4c_Dados
645:             LOCATE FOR EMPTY(ALLTRIM(ChaveNota))
646:             IF !FOUND()
647:                 APPEND BLANK
648:                 REPLACE EmpDopNums WITH THIS.this_cEmpDopNums
649:             ENDIF
650: 
651:             THIS.grd_4c_Dados.Refresh()
652: 
653:             *-- Entra em edicao na linha recem-criada. BtnAlterarClick devolve
654:             *-- o foco a coluna Chave - o mesmo par "Thisform.grade.Refresh +
655:             *-- thisform.grade.column1.SetFocus" que o Click legado executa.
656:             THIS.BtnAlterarClick()
657: 
658:             THIS.LockScreen = .F.
659:         CATCH TO loc_oErro

*-- Linhas 684 a 702:
684:             RETURN
685:         ENDIF
686: 
687:         SELECT cursor_4c_Dados
688:         IF RECCOUNT("cursor_4c_Dados") = 0 OR EOF() OR BOF()
689:             RETURN
690:         ENDIF
691: 
692:         loc_lProsseguir = .T.
693: 
694:         TRY
695:             loc_cPk = ALLTRIM(NVL(cursor_4c_Dados.pkChaves, ""))
696: 
697:             IF !EMPTY(loc_cPk)
698:                 IF !MsgConfirmaExclusao()
699:                     loc_lProsseguir = .F.
700:                 ENDIF
701: 
702:                 IF loc_lProsseguir

*-- Linhas 711 a 753:
711: 
712:             IF loc_lProsseguir
713:                 THIS.LockScreen = .T.
714:                 SELECT cursor_4c_Dados
715:                 DELETE
716:                 THIS.grd_4c_Dados.Refresh()
717:                 THIS.LockScreen = .F.
718:             ENDIF
719:         CATCH TO loc_oErro
720:             THIS.LockScreen = .F.
721:             MsgErro(loc_oErro.Message + CHR(13) + ;
722:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
723:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluirClick")
724:         ENDTRY
725:     ENDPROC
726: 
727:     *==========================================================================
728:     * LinhaCorrenteValida - Garante que ha uma linha posicionada no
729:     * cursor_4c_Dados (equivale ao "If Eof() Or Bof() / Return" que o legado
730:     * repete no Click de SIGMVCHV.excluir).
731:     *==========================================================================
732:     PROCEDURE LinhaCorrenteValida()
733:         LOCAL loc_lOk
734: 
735:         loc_lOk = .F.
736: 
737:         IF USED("cursor_4c_Dados")
738:             SELECT cursor_4c_Dados
739:             loc_lOk = (RECCOUNT("cursor_4c_Dados") > 0 AND !EOF() AND !BOF())
740:         ENDIF
741: 
742:         RETURN loc_lOk
743:     ENDPROC
744: 
745:     *==========================================================================
746:     * BtnAlterarClick - Entra em edicao na linha corrente da grade.
747:     *
748:     * SIGMVCHV nao tem botao "Alterar": a alteracao acontece digitando direto
749:     * na grade, e quem autoriza eh o When da coluna Chave do legado
750:     * ("Return(INLIST(Thisform.pcEscolha,'INSERIR','ALTERAR'))", igual ao When
751:     * de inserir/excluir). Este metodo concentra essa regra: valida que ha
752:     * linha posicionada, aplica o mesmo gate de modo e devolve o foco a unica
753:     * celula que o legado deixa editavel (Column1 = Chave), reproduzindo o

*-- Linhas 794 a 812:
794:     * BtnVisualizarClick - Exibe as chaves como estao GRAVADAS para o documento
795:     * (somente leitura): recarrega cursor_4c_Dados a partir de SigMvChv via BO,
796:     * filtrando pelo EmpDopNums do documento pai - exatamente o conjunto que o
797:     * Init do legado ja encontra montado em crChaves ("Select crChaves / Go
798:     * Top" ligado a grade).
799:     *
800:     * Nao grava nada e nao depende do modo do documento (serve em PROCURAR,
801:     * que eh justamente o modo de consulta do legado). Como recarregar descarta
802:     * a linha em branco que o usuario tenha acabado de inserir e ainda nao
803:     * digitado, pede confirmacao quando o documento esta editavel e a grade ja
804:     * tem linhas - em SIGMVCHV a gravacao acontece linha a linha
805:     * (ValidarChaveGrade/BtnExcluirClick), entao o que se perde eh so o que
806:     * ainda nao foi gravado.
807:     *
808:     * NAO cria botao proprio na tela (PILAR 1 - o legado nao tem): eh o ponto
809:     * de entrada programatico de consulta do form.
810:     *==========================================================================
811:     PROCEDURE BtnVisualizarClick()
812:         LOCAL loc_lOk, loc_lProsseguir, loc_oErro

*-- Linhas 856 a 874:
856:     PROCEDURE BtnConfirmarClick()
857:         IF USED("cursor_4c_Dados")
858:             THIS.grd_4c_Dados.Refresh()
859:             SELECT cursor_4c_Dados
860:             GO TOP
861:             THIS.grd_4c_Dados.Refresh()
862:         ENDIF
863: 
864:         THIS.Release()
865:     ENDPROC
866: 
867:     *==========================================================================
868:     * BtnCancelarClick - Encerra sem gravar mais nada (equivale ao PROCEDURE
869:     * Click de SIGMVCHV.cntBotoes.btnSair: ThisForm.Release)
870:     *==========================================================================
871:     PROCEDURE BtnCancelarClick()
872:         THIS.Release()
873:     ENDPROC
874: 


### BO (C:\4c\projeto\app\classes\SigMvChvBO.prg):
*==============================================================================
* SIGMVCHVBO.PRG
* Business Object - Chaves de Nota (SigMvChv)
*
* Form OPERACIONAL: dialogo auxiliar chamado por outro form para o usuario
* incluir/excluir Chaves de Nota (ChaveNota) associadas a um documento pai
* (EmpDopNums). No legado (SIGMVCHV.Init) o form manipula um cursor local
* crChaves ja populado pelo form chamador (Select crChaves / Go Top) e so
* grava a tabela real por fora (fluxo comentado no legado, nunca ativo).
*
* Tabela SigMvChv existe no schema (chavenota, empdopnums, pkchaves - mesmas
* 3 colunas do cursor crChaves) - este BO usa arquitetura em camadas (PILAR 3)
* e persiste cada linha na tabela via Inserir/Atualizar/ExecutarExclusao.
*==============================================================================

DEFINE CLASS SigMvChvBO AS BusinessBase

    *-- Propriedades especificas da entidade SigMvChv (linha do cursor crChaves)
    this_cChaveNota  = ""   && crChaves.ChaveNota  - chave da nota digitada pelo usuario
    this_cEmpDopNums = ""   && crChaves.EmpDopNums - empresa + numero do documento pai
    this_cPkChaves   = ""   && crChaves.pkChaves   - chave primaria Fortyus (Sys(2015)+Sys(2015))

    *--------------------------------------------------------------------------
    * Init - Construtor
    * Tabela SigMvChv (chavenota, empdopnums, pkchaves) existe no schema com
    * as mesmas 3 colunas do cursor local crChaves do legado - THIS BO grava
    * cada linha nela via Inserir/Atualizar (arquitetura camadas, PILAR 3).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigMvChv"
        THIS.this_cCampoChave = "pkChaves"

        THIS.this_cChaveNota  = ""
        THIS.this_cEmpDopNums = ""
        THIS.this_cPkChaves   = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de uma linha do
    * cursor informado (crChaves ou cursor_4c_Dados, mesma estrutura)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cChaveNota  = TratarNulo(ChaveNota, "C")
                THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
                THIS.this_cPkChaves   = TratarNulo(pkChaves, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa propriedades de dados
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        THIS.this_cChaveNota  = ""
        THIS.this_cEmpDopNums = ""
        THIS.this_cPkChaves   = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    * Mesma checagem do legado: ChaveNota nao pode ficar vazia (Valid do
    * grade.Column1.Text1 so processa "If Not Empty(This.Value)")
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cChaveNota))
            THIS.this_cMensagemErro = "Chave da nota " + CHR(233) + " obrigat" + CHR(243) + "ria"
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cEmpDopNums))
            THIS.this_cMensagemErro = "Documento de origem (EmpDopNums) " + CHR(227) + "o informado"
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteChaveDuplicada - Espelha o Valid do legado: bloqueia gravar duas
    * linhas com a mesma ChaveNota (Select ChaveNota, Count(*) ... Group By)
    *--------------------------------------------------------------------------
    PROCEDURE ExisteChaveDuplicada(par_cChaveNota, par_cPkChavesAtual)
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicada
        loc_lDuplicada = .F.

        TRY
            IF USED("cursor_4c_DupChv")
                USE IN cursor_4c_DupChv
            ENDIF

            loc_cSQL = "SELECT pkchaves FROM SigMvChv WHERE chavenota = " + ;
                       EscaparSQL(ALLTRIM(par_cChaveNota)) + ;
                       " AND empdopnums = " + EscaparSQL(ALLTRIM(THIS.this_cEmpDopNums)) + ;
                       " AND pkchaves <> " + EscaparSQL(ALLTRIM(par_cPkChavesAtual))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupChv")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DupChv") > 0
                loc_lDuplicada = .T.
            ENDIF

            IF USED("cursor_4c_DupChv")
                USE IN cursor_4c_DupChv
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicada
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista as chaves de nota de um documento (grid da lista).
    * A grade edita ChaveNota diretamente na celula (transcricao do
    * grade.Column1.Text1 legado), entao o cursor NAO pode ficar somente-
    * leitura como o SQLEXEC entrega por padrao - converte via cursor
    * temporario para cursor_4c_Dados READWRITE.
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT chavenota AS ChaveNota, empdopnums AS EmpDopNums," + ;
                           " pkchaves AS pkChaves FROM SigMvChv" + ;
                           " WHERE empdopnums = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
                           " ORDER BY chavenota"
            ELSE
                loc_cSQL = "SELECT chavenota AS ChaveNota, empdopnums AS EmpDopNums," + ;
                           " pkchaves AS pkChaves FROM SigMvChv ORDER BY chavenota"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar chaves de nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigMvChv (PROTECTED, chamado por Salvar())
    * Gera pkChaves via fUniqueIds() quando ainda nao preenchida, igual ao
    * legado (Sys(2015)+Sys(2015)) so que com o helper canonico do sistema.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigMvChv (chavenota, empdopnums, pkchaves) VALUES (" + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cChaveNota), 44)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 29)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cPkChaves), 20)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsChv")
            IF USED("cursor_4c_InsChv")
                USE IN cursor_4c_InsChv
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir chave de nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigMvChv (PROTECTED, chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                MsgErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + "o informada para altera" + CHR(231) + CHR(227) + "o", "Erro")
            ELSE
                loc_cSQL = "UPDATE SigMvChv SET " + ;
                           "chavenota = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cChaveNota), 44)) + ", " + ;
                           "empdopnums = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 29)) + ;
                           " WHERE pkchaves = " + EscaparSQL(ALLTRIM(THIS.this_cPkChaves))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AltChv")
                IF USED("cursor_4c_AltChv")
                    USE IN cursor_4c_AltChv
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao alterar chave de nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigMvChv (PROTECTED, chamado por Excluir())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                MsgErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + "o informada para exclus" + CHR(227) + "o", "Erro")
            ELSE
                loc_cSQL = "DELETE FROM SigMvChv WHERE pkchaves = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cPkChaves))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExcChv")
                IF USED("cursor_4c_ExcChv")
                    USE IN cursor_4c_ExcChv
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir chave de nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

