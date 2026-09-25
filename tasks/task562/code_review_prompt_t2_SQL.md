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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigMvChv.prg) - TRECHOS RELEVANTES PARA PASS SQL (947 linhas total):

*-- Linhas 201 a 219:
201:             IF USED("cursor_4c_Dados")
202:                 USE IN cursor_4c_Dados
203:             ENDIF
204:             CREATE CURSOR cursor_4c_Dados ;
205:                 (ChaveNota C(44) NULL, EmpDopNums C(29) NULL, pkChaves C(20) NULL)
206:             SET NULL OFF
207: 
208:             *-- CommandGroup Confirmar/Cancelar (cntBotoes do legado)
209:             *-- Buttons(1)=Cancelar (Left=80, equivale a Command1/btnSair),
210:             *-- Buttons(2)=Confirmar (Left=5, equivale a Command2/btnConfirmar)
211:             THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
212:             loc_oCmg = THIS.cmg_4c_Botoes
213:             WITH loc_oCmg
214:                 .Top           = -2
215:                 .Left          = 344
216:                 .Width         = 160
217:                 .Height        = 85
218:                 .ButtonCount   = 2
219:                 .AutoSize      = .T.

*-- Linhas 285 a 303:
285:                 .RowHeight     = 16
286:                 .ScrollBars    = 2
287:                 .ReadOnly      = .F.
288:                 .DeleteMark    = .F.
289:                 .RecordMark    = .F.
290:                 .GridLineColor = RGB(238, 238, 238)
291:             ENDWITH
292: 
293:             WITH loc_oGrd.Column1
294:                 .FontName  = "Tahoma"
295:                 .FontSize  = 8
296:                 .Width     = 310
297:                 .Movable   = .F.
298:                 .Resizable = .F.
299:                 .ReadOnly  = !THIS.this_lModoEdicao
300:             ENDWITH
301:             loc_oGrd.Column1.Header1.Caption   = "Chave"
302:             loc_oGrd.Column1.Header1.Alignment = 2
303:             WITH loc_oGrd.Column1.Text1

*-- Linhas 312 a 333:
312:             ENDWITH
313: 
314:             *-- RecordSource por ultimo (regra "Column.Width vai por ultimo" -
315:             *-- resetar RecordSource/ControlSource reseta Width/Header)
316:             loc_oGrd.ColumnCount = 1
317:             loc_oGrd.RecordSource            = "cursor_4c_Dados"
318:             loc_oGrd.Column1.ControlSource   = "cursor_4c_Dados.ChaveNota"
319:             loc_oGrd.Column1.Header1.Caption = "Chave"
320:             loc_oGrd.Column1.Width           = 310
321:             loc_oGrd.Column1.ReadOnly        = !THIS.this_lModoEdicao
322: 
323:             IF THIS.this_lModoEdicao
324:                 BINDEVENT(loc_oGrd.Column1.Text1, "KeyPress", THIS, "ValidarChaveGrade")
325:             ENDIF
326: 
327:             *-- Botoes standalone Incluir/Excluir - habilitados so em
328:             *-- INSERIR/ALTERAR (equivalente ao When legado
329:             *-- "Return(INLIST(Thisform.pcEscolha,'INSERIR','ALTERAR'))")
330:             THIS.AddObject("cmd_4c_Incluir", "CommandButton")
331:             WITH THIS.cmd_4c_Incluir
332:                 .Top             = 171
333:                 .Left = 5

*-- Linhas 376 a 425:
376:     *==========================================================================
377:     * CarregarLista - (Re)carrega as chaves do documento no cursor_4c_Dados
378:     * via BO e rebinda a grade (o BO fecha/recria o cursor a cada chamada,
379:     * entao RecordSource/ControlSource/Header/Width precisam ser reaplicados).
380:     *==========================================================================
381:     PROCEDURE CarregarLista()
382:         LOCAL loc_lOk, loc_oErro
383:         loc_lOk = .F.
384: 
385:         TRY
386:             loc_lOk = THIS.this_oBusinessObject.Buscar(THIS.this_cEmpDopNums)
387: 
388:             IF loc_lOk AND USED("cursor_4c_Dados") AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
389:                 THIS.grd_4c_Dados.RecordSource           = "cursor_4c_Dados"
390:                 THIS.grd_4c_Dados.Column1.ControlSource  = "cursor_4c_Dados.ChaveNota"
391:                 THIS.grd_4c_Dados.Column1.Header1.Caption = "Chave"
392:                 THIS.grd_4c_Dados.Column1.Width          = 310
393:                 THIS.grd_4c_Dados.Column1.ReadOnly       = !THIS.this_lModoEdicao
394: 
395:                 SELECT cursor_4c_Dados
396:                 GO TOP
397:                 THIS.grd_4c_Dados.Refresh()
398:             ENDIF
399:         CATCH TO loc_oErro
400:             MsgErro(loc_oErro.Message + CHR(13) + ;
401:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
402:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
403:         ENDTRY
404: 
405:         RETURN loc_lOk
406:     ENDPROC
407: 
408:     *==========================================================================
409:     * ValidarChaveGrade - KeyPress (ENTER/TAB) na coluna Chave (Column1) da
410:     * grade. Verifica duplicidade no cursor local (equivale ao "Select
411:     * ChaveNota, Count(*) ... Group By" do Valid legado, rodado sobre o
412:     * mesmo cursor crChaves que esta sendo editado) e persiste a linha
413:     * imediatamente via BO (arquitetura em camadas - PILAR 3, a tabela real
414:     * SigMvChv existe e o BO ja implementa Inserir/Atualizar via Salvar()).
415:     *==========================================================================
416:     PROCEDURE ValidarChaveGrade(par_nKeyCode, par_nShiftAltCtrl)
417:         LOCAL loc_cVal, loc_cPkAtual, loc_lNovo, loc_oErro, loc_lProsseguir
418: 
419:         *-- Teclas que ENCERRAM a edicao da celula. O Valid do legado dispara
420:         *-- ao SAIR do campo por qualquer meio; num Grid a saida mais comum
421:         *-- nem eh ENTER/TAB, sao as SETAS (que trocam de linha). Sem 5/24 o
422:         *-- usuario digita a chave, aperta seta e a linha nunca eh gravada -
423:         *-- perda silenciosa. Codigos VFP9 de KeyPress: ENTER=13, TAB=9,
424:         *-- SETA-ACIMA=5, SETA-ABAIXO=24. (BINDEVENT em "Valid" nao dispara
425:         *-- de forma confiavel em TextBox e LostFocus recursaria - regra #3.)

*-- Linhas 437 a 491:
437:             RETURN
438:         ENDIF
439: 
440:         SELECT cursor_4c_Dados
441: 
442:         *-- Valor inalterado numa linha JA gravada: nada a fazer. Sem este
443:         *-- guard, cada ENTER/TAB/seta sobre uma linha existente repetiria o
444:         *-- UPDATE e o BusinessBase gravaria um registro de auditoria a cada
445:         *-- navegacao (RegistrarAuditoria roda dentro de Atualizar()).
446:         IF ALLTRIM(NVL(ChaveNota, "")) == loc_cVal ;
447:                 AND !EMPTY(ALLTRIM(NVL(pkChaves, "")))
448:             RETURN
449:         ENDIF
450: 
451:         REPLACE ChaveNota WITH loc_cVal
452: 
453:         IF THIS.VerificarChaveDuplicada()
454:             MsgAviso("Registro j" + CHR(225) + " informado.", "Aviso")
455:             SELECT cursor_4c_Dados
456:             REPLACE ChaveNota WITH ""
457:             THIS.grd_4c_Dados.Refresh()
458:             RETURN
459:         ENDIF
460: 
461:         loc_lProsseguir = .T.
462: 
463:         TRY
464:             loc_cPkAtual = ALLTRIM(NVL(cursor_4c_Dados.pkChaves, ""))
465:             loc_lNovo    = EMPTY(loc_cPkAtual)
466: 
467:             *-- VerificarChaveDuplicada acima so enxerga o cursor local (igual
468:             *-- ao Valid legado, que agrupa so sobre crChaves). Como esta
469:             *-- arquitetura grava cada linha na tabela real SigMvChv na hora
470:             *-- (PILAR 3 - o legado deixava isso tudo comentado), confirmar
471:             *-- tambem contra o banco evita duplicar a chave quando outra
472:             *-- sessao gravou a mesma ChaveNota para o mesmo documento entre a
473:             *-- carga da lista e este Salvar.
474:             IF THIS.this_oBusinessObject.ExisteChaveDuplicada(loc_cVal, loc_cPkAtual)
475:                 MsgAviso("Registro j" + CHR(225) + " informado.", "Aviso")
476:                 SELECT cursor_4c_Dados
477:                 REPLACE ChaveNota WITH ""
478:                 THIS.grd_4c_Dados.Refresh()
479:                 loc_lProsseguir = .F.
480:             ENDIF
481: 
482:             IF loc_lProsseguir
483:                 IF loc_lNovo
484:                     THIS.this_oBusinessObject.NovoRegistro()
485:                 ELSE
486:                     THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
487: 
488:                     *-- EditarRegistro() recusa (retorna .F.) enquanto
489:                     *-- this_lNovoRegistro estiver ligado. Salvar() so desliga
490:                     *-- essa flag quando a gravacao DA CERTO, entao uma inclusao
491:                     *-- que falhou deixa o BO marcado como "novo": a linha

*-- Linhas 516 a 546:
516:     *==========================================================================
517:     * VerificarChaveDuplicada - Verifica se a ChaveNota da linha corrente do
518:     * cursor_4c_Dados ja foi informada em outra linha da grade (equivale ao
519:     * "Select ChaveNota, Count(*) as qt ... Group by ChaveNota" do Valid
520:     * legado, rodado sobre o cursor local).
521:     *==========================================================================
522:     PROCEDURE VerificarChaveDuplicada()
523:         LOCAL loc_nRecAtual, loc_cChave, loc_lDuplicado
524: 
525:         loc_lDuplicado = .F.
526: 
527:         IF !USED("cursor_4c_Dados")
528:             RETURN loc_lDuplicado
529:         ENDIF
530: 
531:         SELECT cursor_4c_Dados
532:         loc_nRecAtual = RECNO()
533:         loc_cChave    = ALLTRIM(ChaveNota)
534: 
535:         IF !EMPTY(loc_cChave)
536:             LOCATE FOR ALLTRIM(ChaveNota) == loc_cChave AND RECNO() != loc_nRecAtual
537:             loc_lDuplicado = FOUND()
538:         ENDIF
539: 
540:         IF BETWEEN(loc_nRecAtual, 1, RECCOUNT("cursor_4c_Dados"))
541:             GO loc_nRecAtual IN cursor_4c_Dados
542:         ENDIF
543: 
544:         RETURN loc_lDuplicado
545:     ENDPROC
546: 

*-- Linhas 566 a 584:
566:             RETURN loc_lOk
567:         ENDIF
568: 
569:         SELECT cursor_4c_Dados
570: 
571:         IF EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
572:             RETURN loc_lOk
573:         ENDIF
574: 
575:         loc_cChave = IIF(VARTYPE(par_cChaveNota) = "C", ;
576:                          ALLTRIM(par_cChaveNota), ;
577:                          ALLTRIM(NVL(cursor_4c_Dados.ChaveNota, "")))
578: 
579:         WITH THIS.this_oBusinessObject
580:             .this_cChaveNota  = loc_cChave
581:             .this_cEmpDopNums = THIS.this_cEmpDopNums
582: 
583:             *-- Linha nova tem pkChaves vazia no cursor; Inserir() gera a chave
584:             *-- via fUniqueIds(). Linha existente ja veio de CarregarDoCursor,

*-- Linhas 609 a 627:
609:             RETURN loc_lOk
610:         ENDIF
611: 
612:         SELECT cursor_4c_Dados
613: 
614:         IF EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
615:             RETURN loc_lOk
616:         ENDIF
617: 
618:         REPLACE ChaveNota  WITH ALLTRIM(THIS.this_oBusinessObject.this_cChaveNota), ;
619:                 EmpDopNums WITH ALLTRIM(THIS.this_oBusinessObject.this_cEmpDopNums), ;
620:                 pkChaves   WITH ALLTRIM(THIS.this_oBusinessObject.this_cPkChaves)
621: 
622:         loc_lOk = .T.
623: 
624:         RETURN loc_lOk
625:     ENDPROC
626: 
627:     *==========================================================================

*-- Linhas 647 a 665:
647:         TRY
648:             THIS.LockScreen = .T.
649: 
650:             SELECT cursor_4c_Dados
651:             LOCATE FOR EMPTY(ALLTRIM(ChaveNota))
652:             IF !FOUND()
653:                 APPEND BLANK
654:                 REPLACE EmpDopNums WITH THIS.this_cEmpDopNums
655:             ENDIF
656: 
657:             THIS.grd_4c_Dados.Refresh()
658: 
659:             *-- Entra em edicao na linha recem-criada. BtnAlterarClick devolve
660:             *-- o foco a coluna Chave - o mesmo par "Thisform.grade.Refresh +
661:             *-- thisform.grade.column1.SetFocus" que o Click legado executa.
662:             THIS.BtnAlterarClick()
663: 
664:             THIS.LockScreen = .F.
665:         CATCH TO loc_oErro

*-- Linhas 690 a 708:
690:             RETURN
691:         ENDIF
692: 
693:         SELECT cursor_4c_Dados
694:         IF RECCOUNT("cursor_4c_Dados") = 0 OR EOF() OR BOF()
695:             RETURN
696:         ENDIF
697: 
698:         loc_lProsseguir = .T.
699: 
700:         TRY
701:             loc_cPk = ALLTRIM(NVL(cursor_4c_Dados.pkChaves, ""))
702: 
703:             IF !EMPTY(loc_cPk)
704:                 IF !MsgConfirmaExclusao()
705:                     loc_lProsseguir = .F.
706:                 ENDIF
707: 
708:                 IF loc_lProsseguir

*-- Linhas 717 a 759:
717: 
718:             IF loc_lProsseguir
719:                 THIS.LockScreen = .T.
720:                 SELECT cursor_4c_Dados
721:                 DELETE
722:                 THIS.grd_4c_Dados.Refresh()
723:                 THIS.LockScreen = .F.
724:             ENDIF
725:         CATCH TO loc_oErro
726:             THIS.LockScreen = .F.
727:             MsgErro(loc_oErro.Message + CHR(13) + ;
728:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
729:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluirClick")
730:         ENDTRY
731:     ENDPROC
732: 
733:     *==========================================================================
734:     * LinhaCorrenteValida - Garante que ha uma linha posicionada no
735:     * cursor_4c_Dados (equivale ao "If Eof() Or Bof() / Return" que o legado
736:     * repete no Click de SIGMVCHV.excluir).
737:     *==========================================================================
738:     PROCEDURE LinhaCorrenteValida()
739:         LOCAL loc_lOk
740: 
741:         loc_lOk = .F.
742: 
743:         IF USED("cursor_4c_Dados")
744:             SELECT cursor_4c_Dados
745:             loc_lOk = (RECCOUNT("cursor_4c_Dados") > 0 AND !EOF() AND !BOF())
746:         ENDIF
747: 
748:         RETURN loc_lOk
749:     ENDPROC
750: 
751:     *==========================================================================
752:     * BtnAlterarClick - Entra em edicao na linha corrente da grade.
753:     *
754:     * SIGMVCHV nao tem botao "Alterar": a alteracao acontece digitando direto
755:     * na grade, e quem autoriza eh o When da coluna Chave do legado
756:     * ("Return(INLIST(Thisform.pcEscolha,'INSERIR','ALTERAR'))", igual ao When
757:     * de inserir/excluir). Este metodo concentra essa regra: valida que ha
758:     * linha posicionada, aplica o mesmo gate de modo e devolve o foco a unica
759:     * celula que o legado deixa editavel (Column1 = Chave), reproduzindo o

*-- Linhas 800 a 818:
800:     * BtnVisualizarClick - Exibe as chaves como estao GRAVADAS para o documento
801:     * (somente leitura): recarrega cursor_4c_Dados a partir de SigMvChv via BO,
802:     * filtrando pelo EmpDopNums do documento pai - exatamente o conjunto que o
803:     * Init do legado ja encontra montado em crChaves ("Select crChaves / Go
804:     * Top" ligado a grade).
805:     *
806:     * Nao grava nada e nao depende do modo do documento (serve em PROCURAR,
807:     * que eh justamente o modo de consulta do legado). Como recarregar descarta
808:     * a linha em branco que o usuario tenha acabado de inserir e ainda nao
809:     * digitado, pede confirmacao quando o documento esta editavel e a grade ja
810:     * tem linhas - em SIGMVCHV a gravacao acontece linha a linha
811:     * (ValidarChaveGrade/BtnExcluirClick), entao o que se perde eh so o que
812:     * ainda nao foi gravado.
813:     *
814:     * NAO cria botao proprio na tela (PILAR 1 - o legado nao tem): eh o ponto
815:     * de entrada programatico de consulta do form.
816:     *==========================================================================
817:     PROCEDURE BtnVisualizarClick()
818:         LOCAL loc_lOk, loc_lProsseguir, loc_oErro

*-- Linhas 862 a 880:
862:     PROCEDURE BtnConfirmarClick()
863:         IF USED("cursor_4c_Dados")
864:             THIS.grd_4c_Dados.Refresh()
865:             SELECT cursor_4c_Dados
866:             GO TOP
867:             THIS.grd_4c_Dados.Refresh()
868:         ENDIF
869: 
870:         THIS.Release()
871:     ENDPROC
872: 
873:     *==========================================================================
874:     * BtnCancelarClick - Encerra sem gravar mais nada (equivale ao PROCEDURE
875:     * Click de SIGMVCHV.cntBotoes.btnSair: ThisForm.Release)
876:     *==========================================================================
877:     PROCEDURE BtnCancelarClick()
878:         THIS.Release()
879:     ENDPROC
880: 


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

