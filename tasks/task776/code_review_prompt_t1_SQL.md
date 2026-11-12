# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, DOPES, GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'USUARIOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, DOPES, GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, DOPES, GRUPOS

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
lcSql = [Select a.*, b.Descrs as Dgrus From SigCcCpe a, SigCdGcr b where a.Dopes=']+CrSigCdOpe.Dopes+[' And a.Grupos = b.Codigos ]
SigCdOpe.PodataMgr.Sqlexecute(lcSql,'xCcOpe')
Select * From xCcOpe Into Cursor TmpCcOpe ReadWrite
Select TmpCcOpe
	.Column1.ControlSource = 'TmpCcOpe.Grupos'
	.Column2.ControlSource = 'TmpCcOpe.Dgrus'
	.Column3.ControlSource = 'TmpCcOpe.GruCads'
	.Column4.ControlSource = 'TmpCcOpe.CtFils'
Select TmpCcOpe
	Delete
		Select TmpCcOpe
		Delete For Grupos = '  '
		Select Grupos, sum(1) From TmpccOpe Group by 1 having sum(1) > 1 Into Cursor SecondKey
		Select SecondKey
		Select CrSigCcCpe
		Append From Dbf('TmpCcOpe')
		lcSql = [Delete From SigCcCpe Where Dopes = ']+CrSigCdOpe.dopes+[']
				m.lnErro1 = SigCdOpe.PodataMgr.Sqlexecute(lcSql,'')
				m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCcCpe'),1,-1)
Select TmpCcOpe
	Insert Into TmpCcOpe (Dopes, CidChaves) Values (crSigCdOpe.Dopes,fUniqueIds())
Select TmpCcOpe

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpOpe.prg) - TRECHOS RELEVANTES PARA PASS SQL (1468 linhas total):

*-- Linhas 67 a 87:
67: * defeitos que eles carregavam, todos consequencia do DataSession = 2 e
68: * do unico caminho de saida deste dialogo:
69: *
70: *   1. SET DELETED ON no InicializarForm. Medido no VFP9 em 2026-11-11:
71: *      na datasession PRIVADA o SET DELETED nasce OFF (o config.prg liga
72: *      na sessao 1 e o FormBase so repoe DATE/CENTURY). Sem isso o DELETE
73: *      do CmdExcluirClick marcava a linha e ela CONTINUAVA na grade, e o
74: *      SCAN do SalvarVinculos a regravava - o usuario excluia e a linha
75: *      voltava, sem erro e sem log.
76: *   2. CmdSairClick nao fica mais preso no CATCH. O dialogo tem
77: *      TitleBar = 0, ControlBox = .F. e WindowType = 1: o cmdSair E a
78: *      unica saida (inclusive via ESC, por .Cancel = .T.). Bloquear o
79: *      fechamento quando a gravacao estoura travava a aplicacao inteira.
80: *      O legado so NAO fecha no caso de grupos em duplicidade
81: *      ("Return .f."); em erro de gravacao ele avisa e fecha.
82: *   3. Guarda de VARTYPE no Business Object antes de gravar, para o
83: *      usuario nao sair achando que gravou.
84: *
85: * Fase 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL. Conferido metodo a
86: * metodo contra a SECAO 3 do dump: dos onze blocos de codigo do legado,
87: * dez ja estavam entregues (Init, as tres celulas da grade com

*-- Linhas 120 a 138:
120: * faria a tela "passar" por casamento de texto) NAO se aplicam a este
121: * dialogo: nao ha Page2 de Dados, nao ha modo de edicao cancelavel e nao
122: * ha campo SOLTO a mapear - todo controle de entrada eh CELULA de coluna
123: * da grade, ligada por ControlSource ao cursor local. O unico funil de
124: * carga desta tela eh CarregarLista (grade de vinculos), ja entregue na
125: * Fase 4, e o unico caminho de gravacao eh o cmdSair, consolidado na
126: * Fase 7. Inventa-los aqui violaria o PILAR 1 ou produziria metodo vazio.
127: *
128: * Parametros recebidos pelo Init (equivalentes a "LParameters poForm,
129: * pnDataSes, pcEscolha" do legado, mais o codigo da operacao - no legado
130: * lido direto do cursor global crSigCdOpe.Dopes aberto no form chamador;
131: * aqui recebido explicitamente, pois a nova arquitetura nao depende de
132: * cursor global compartilhado entre forms):
133: *   par_oFormPai        - form chamador (Cadastro de Operacoes)
134: *   par_nDataSessionPai - DataSession do form chamador (mantido por
135: *                          compatibilidade com a assinatura legado; a nova
136: *                          arquitetura nao precisa alternar DataSession
137: *                          manualmente para ler o codigo da operacao)
138: *   par_cEscolha        - modo do form chamador ('INSERIR'/'ALTERAR'/outro),

*-- Linhas 220 a 247:
220: 
221:         *-- DataSession = 2 nasce com os SETs no DEFAULT do VFP, e o
222:         *-- FormBase.Init() so repoe DATE/CENTURY. Medido no VFP9 em
223:         *-- 2026-11-11 (automation/MedirDeletedSafetyDS2.prg):
224:         *--   SESSAO 1     : deleted=ON   safety=OFF
225:         *--   SESSAO DO FORM: deleted=OFF  safety=ON   exact=OFF
226:         *--   apos DELETE num cursor local: RECCOUNT=2 e SCAN visitou 2
227:         *-- Sem SET DELETED ON, o DELETE do CmdExcluirClick nao tira a
228:         *-- linha da grade e o SCAN do SalvarVinculos a REGRAVA. O SET e
229:         *-- escopado nesta datasession - nao afeta a sessao 1.
230:         *-- SET EXACT fica como esta (OFF) de proposito: liga-lo mudaria a
231:         *-- semantica de "=" em todo este form, que foi escrito sob OFF.
232:         SET DELETED ON
233: 
234:         TRY
235:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpOpeBO")
236: 
237:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
238:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpOpeBO." + CHR(13) + ;
239:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
240:                         "Erro em InicializarForm")
241:             ELSE
242:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
243: 
244:                 *-- equivalente a "Thisform.ParentForm.Enabled = .F." do Init
245:                 *-- legado: desabilita o form chamador enquanto este dialogo
246:                 *-- esta aberto. Restaurado em Destroy() (rede de seguranca
247:                 *-- para fechamento via ESC/Alt+F4) e no funil de saida

*-- Linhas 266 a 284:
266:                 THIS.AplicarPermissoesBotoes()
267: 
268:                 *-- 1a carga da grade, como o PROCEDURE Init legado faz logo
269:                 *-- apos montar a tela (Sqlexecute -> TmpCcOpe -> Goto Top +
270:                 *-- GradeSubN.Refresh). Pulado em validacao de UI/modo teste:
271:                 *-- nao ha conexao SQL.
272:                 IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
273:                    (TYPE("gb_4c_ModoTeste")   != "L" OR !gb_4c_ModoTeste)
274:                     THIS.CarregarLista()
275:                 ENDIF
276: 
277:                 *-- POR ULTIMO: o Init legado posiciona a janela depois de
278:                 *-- ter montado a tela, e a formula depende de THIS.Width
279:                 *-- (ja definido) e do form chamador
280:                 THIS.PosicionarJuntoAoFormPai()
281: 
282:                 loc_lSucesso = .T.
283:             ENDIF
284:         CATCH TO loc_oErro

*-- Linhas 506 a 569:
506: 
507:     *--------------------------------------------------------------------------
508:     * CriarCursorVinculos - cria o cursor LOCAL que a grade exibe,
509:     * equivalente ao "Select * From xCcOpe Into Cursor TmpCcOpe ReadWrite"
510:     * do PROCEDURE Init legado.
511:     *
512:     * Criado VAZIO aqui, ANTES de ConfigurarGrade: Column.ControlSource de
513:     * cursor inexistente derruba o Init com "Alias not found" e a tela nao
514:     * abre (regra CLAUDE.md #41). A carga real vem depois, em CarregarLista.
515:     *
516:     * READWRITE e obrigatorio - a Column4 tem CheckBox editavel e a Column1
517:     * e digitavel; cursor somente-leitura renderiza o controle mas a celula
518:     * nunca entra em edicao.
519:     *
520:     * A lista de colunas e a MESMA (nomes e ordem) do SELECT do
521:     * SigOpOpeBO.CarregarVinculos: o APPEND FROM casa por NOME. Todas as
522:     * colunas de SigCcCpe sao NOT NULL no schema e o JOIN com SigCdGcr e
523:     * interno, por isso o cursor nasce sem colunas NULL.
524:     *--------------------------------------------------------------------------
525:     PROTECTED PROCEDURE CriarCursorVinculos()
526:         IF USED("cursor_4c_Vinculos")
527:             IF CURSORGETPROP("Buffering", "cursor_4c_Vinculos") > 1
528:                 TABLEREVERT(.T., "cursor_4c_Vinculos")
529:             ENDIF
530:             USE IN cursor_4c_Vinculos
531:         ENDIF
532: 
533:         SET NULL OFF
534: 
535:         CREATE CURSOR cursor_4c_Vinculos ( ;
536:             cidchaves C(20), ;
537:             dopes     C(20), ;
538:             grupos    C(10), ;
539:             grucads   C(10), ;
540:             ctfils    N(1, 0), ;
541:             dgrus     C(40))
542:     ENDPROC
543: 
544:     *--------------------------------------------------------------------------
545:     * ConfigurarGrade - grd_4c_Dados, equivalente a SIGOPOPE.GradeSubN:
546:     * 4 colunas (C.Custo / Descricao / Grupo Cadastro / "C"), geometria e
547:     * visual TRANSCRITOS do dump.
548:     *
549:     * A Column4 e um CheckBox ("C" = Somente Contas do Grupo), por isso
550:     * precisa de AddObject + CurrentControl + Sparse = .F. (regra CLAUDE.md
551:     * #18): sem o CurrentControl a coluna continua desenhando o Text1
552:     * default e o usuario ve o 0/1 cru, sem caixa para marcar.
553:     *
554:     * O ControlSource de CADA coluna vem DEPOIS do ColumnCount e do
555:     * RecordSource, e o Width de cada coluna vem por ULTIMO - mexer em
556:     * RecordSource recalcula as larguras para o default 90.
557:     *--------------------------------------------------------------------------
558:     PROTECTED PROCEDURE ConfigurarGrade()
559:         THIS.CriarCursorVinculos()
560: 
561:         THIS.AddObject("grd_4c_Dados", "Grid")
562: 
563:         *-- ColumnCount/RecordSource FORA do WITH abaixo: dentro do mesmo
564:         *-- WITH que acessa .Column1..Column4 as colunas ainda nao existem
565:         *-- no momento em que o bloco e montado e o VFP estoura
566:         *-- "Unknown member COLUMN1".
567:         THIS.grd_4c_Dados.ColumnCount  = 4
568:         THIS.grd_4c_Dados.RecordSource = THIS.this_cCursorGrade
569: 

*-- Linhas 577 a 649:
577:             .ForeColor         = RGB(0, 0, 0)
578:             .BackColor         = RGB(255, 255, 255)
579:             .GridLineColor     = RGB(238, 238, 238)
580:             .DeleteMark        = .F.
581:             .RecordMark        = .F.
582:             .AllowHeaderSizing = .F.
583:             .AllowRowSizing    = .F.
584:             .RowHeight         = 16
585:             .ScrollBars        = 2
586:             .TabIndex          = 1
587:             .ReadOnly          = .F.
588: 
589:             *-- Column1 - "C.Custo" (TmpCcOpe.Grupos no legado). TextBox
590:             *-- customizada (regra #18/#46): Column1.Text1 nativo nao
591:             *-- oferece When/Valid/LostFocus confiaveis via BINDEVENT - a
592:             *-- celula precisa de classe propria com os eventos EMBUTIDOS
593:             *-- (TextBoxGrupoCcOpe_4c, classes\textboxgridlookup.PRG).
594:             .Column1.ControlSource     = THIS.this_cCursorGrade + ".grupos"
595:             .Column1.FontName          = "Tahoma"
596:             .Column1.FontSize          = 8
597:             .Column1.Movable           = .F.
598:             .Column1.Resizable         = .F.
599:             .Column1.Header1.Caption   = "C.Custo"
600:             .Column1.Header1.Alignment = 2
601:             .Column1.Header1.FontName  = "Tahoma"
602:             .Column1.Header1.FontSize  = 8
603: 
604:             .Column1.AddObject("txt_4c_Grupos", "TextBoxGrupoCcOpe_4c")
605:             .Column1.CurrentControl    = "txt_4c_Grupos"
606: 
607:             *-- digitavel: o legado so trava a celula quando a linha JA tem
608:             *-- grupo (TextBoxGrupoCcOpe_4c.When -> GrupoOperacaoEditavel).
609:             *-- O ReadOnly da COLUNA vem DEPOIS do ReadOnly do Grid, que
610:             *-- propaga para as colunas e sobrescreveria este valor.
611:             .Column1.ReadOnly          = .F.
612: 
613:             *-- Column2 - "Descricao" (TmpCcOpe.Dgrus: SigCdGcr.descrs do
614:             *-- JOIN). Legado: Column2.ReadOnly = .T. e Column2.Text1.When
615:             *-- -> Return .f. (coluna de exibicao, nunca digitavel).
616:             .Column2.ControlSource     = THIS.this_cCursorGrade + ".dgrus"
617:             .Column2.FontName          = "Tahoma"
618:             .Column2.FontSize          = 8
619:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
620:             .Column2.Header1.Alignment = 2
621:             .Column2.Header1.FontName  = "Tahoma"
622:             .Column2.Header1.FontSize  = 8
623:             .Column2.Text1.BorderStyle = 0
624:             .Column2.Text1.Margin      = 0
625:             .Column2.Text1.ReadOnly    = .T.
626:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
627:             .Column2.Text1.BackColor   = RGB(255, 255, 255)
628:             .Column2.ReadOnly          = .T.
629: 
630:             *-- Column3 - "Grupo Cadastro" (TmpCcOpe.GruCads). TextBox
631:             *-- customizada (regra #18/#46): TextBoxGruCadOperacao_4c valida
632:             *-- em SigCdGcr no Valid, sem a descricao companheira (a Column2
633:             *-- eh so da Column1 - o legado tambem nao passa pDsc aqui).
634:             .Column3.ControlSource     = THIS.this_cCursorGrade + ".grucads"
635:             .Column3.FontName          = "Tahoma"
636:             .Column3.FontSize          = 8
637:             .Column3.Movable           = .F.
638:             .Column3.Resizable         = .F.
639:             .Column3.Header1.Caption   = "Grupo Cadastro"
640:             .Column3.Header1.Alignment = 2
641:             .Column3.Header1.FontName  = "Tahoma"
642:             .Column3.Header1.FontSize  = 8
643: 
644:             .Column3.AddObject("txt_4c_GruCads", "TextBoxGruCadOperacao_4c")
645:             .Column3.CurrentControl    = "txt_4c_GruCads"
646:             .Column3.ReadOnly          = .F.
647: 
648:             *-- Column4 - "C" (TmpCcOpe.CtFils): CheckBox "Somente Contas
649:             *-- do Grupo". Caption vazio - no legado o Check1 carrega o

*-- Linhas 657 a 709:
657:             .Column4.Header1.FontName  = "Tahoma"
658:             .Column4.Header1.FontSize  = 8
659: 
660:             *-- ControlSource da COLUNA (nunca do CheckBox: as duas
661:             *-- atribuicoes juntas disparam o erro 1767) vem ANTES do
662:             *-- AddObject, nao depois.
663:             *
664:             *-- Medido no VFP9: ao definir ColumnCount o Grid AUTO-BINDA na
665:             *-- area de trabalho corrente, e a Column4 cai na 4a coluna do
666:             *-- cursor (grucads, CHARACTER). Como o .Value do CheckBox nasce
667:             *-- NUMERICO, o proprio AddObject estoura "Error with
668:             *-- CHK_4C_CTFILS - Value : Data type mismatch", o InicializarForm
669:             *-- devolve .F. e a tela nao abre. Apontar a coluna para ctfils
670:             *-- (numeric(1,0)) primeiro desfaz o auto-bind e o AddObject passa.
671:             .Column4.ControlSource     = THIS.this_cCursorGrade + ".ctfils"
672: 
673:             .Column4.AddObject("chk_4c_CtFils", "CheckBox")
674:             .Column4.chk_4c_CtFils.Top       = 24
675:             .Column4.chk_4c_CtFils.Left      = 3
676:             .Column4.chk_4c_CtFils.Width     = 60
677:             .Column4.chk_4c_CtFils.Height    = 17
678:             .Column4.chk_4c_CtFils.FontName  = "Tahoma"
679:             .Column4.chk_4c_CtFils.FontSize  = 8
680:             .Column4.chk_4c_CtFils.Alignment = 0
681:             .Column4.chk_4c_CtFils.BackStyle = 0
682:             .Column4.chk_4c_CtFils.BackColor = RGB(204, 230, 255)
683:             .Column4.chk_4c_CtFils.Caption   = ""
684:             .Column4.chk_4c_CtFils.Value     = 0
685: 
686:             *-- Sparse = .F. faz a caixa aparecer em TODAS as linhas, nao so
687:             *-- na corrente (o dump ja traz Column4.Sparse = .F.); sem o
688:             *-- CurrentControl a coluna continuaria desenhando o Text1 e o
689:             *-- usuario veria o 0/1 cru.
690:             .Column4.CurrentControl    = "chk_4c_CtFils"
691:             .Column4.Sparse            = .F.
692:             .Column4.ReadOnly          = .F.
693: 
694:             *-- Larguras POR ULTIMO: RecordSource/ControlSource recalculam
695:             *-- Column.Width para o default 90 (dump: 80/180/80/20).
696:             .Column1.Width = 80
697:             .Column2.Width = 180
698:             .Column3.Width = 80
699:             .Column4.Width = 20
700: 
701:             .Visible = .T.
702:         ENDWITH
703: 
704:         *-- CheckBox de coluna de Grid NAO alterna pelo binding nativo
705:         *-- quando o campo e NUMERICO (ctfils numeric(1,0)): clicar/teclar
706:         *-- Espaco/Enter renderiza mas nao muda o valor. O legado
707:         *-- (Column4.Check1.Click) so marca lHouveIns; o toggle de verdade
708:         *-- exige os 4 handlers MouseDown/MouseUp/KeyPress/Click com
709:         *-- NODEFAULT (MouseDown/Click suprimem o toggle nativo - sem eles o

*-- Linhas 787 a 805:
787: 
788:                 IF loc_nResultado >= 0 AND USED("cursor_4c_GruposAcessiveis") AND ;
789:                    RECCOUNT("cursor_4c_GruposAcessiveis") = 1
790:                     SELECT cursor_4c_GruposAcessiveis
791:                     par_oTxt.Value = ALLTRIM(Codigos)
792:                     IF PEMSTATUS(THIS.grd_4c_Dados.Column2, "Text1", 5)
793:                         THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(Descrs)
794:                     ENDIF
795:                 ELSE
796:                     THIS.AbrirLookupGrupoOperacaoGrade(par_oTxt)
797:                 ENDIF
798: 
799:                 IF USED("cursor_4c_GruposAcessiveis")
800:                     USE IN cursor_4c_GruposAcessiveis
801:                 ENDIF
802:             CATCH TO loc_oErro
803:                 MsgErro(loc_oErro.Message + CHR(13) + ;
804:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
805:                         "Procedure: " + loc_oErro.Procedure, ;

*-- Linhas 872 a 890:
872: 
873:                 IF loc_nResultado >= 0 AND USED("cursor_4c_GruposAcessiveis") AND ;
874:                    RECCOUNT("cursor_4c_GruposAcessiveis") = 1
875:                     SELECT cursor_4c_GruposAcessiveis
876:                     par_oTxt.Value = ALLTRIM(Codigos)
877:                 ELSE
878:                     THIS.AbrirLookupGruCadOperacaoGrade(par_oTxt)
879:                 ENDIF
880: 
881:                 IF USED("cursor_4c_GruposAcessiveis")
882:                     USE IN cursor_4c_GruposAcessiveis
883:                 ENDIF
884:             CATCH TO loc_oErro
885:                 MsgErro(loc_oErro.Message + CHR(13) + ;
886:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
887:                         "Procedure: " + loc_oErro.Procedure, ;
888:                         "Erro ao validar Grupo Cadastro")
889:             ENDTRY
890:         ENDIF

*-- Linhas 1146 a 1269:
1146: 
1147:     *--------------------------------------------------------------------------
1148:     * AtualizarGrade - METODO UNICO de repintura da grade, equivalente ao
1149:     * "Select TmpCcOpe / Goto Top / Thisform.GradeSubN.Refresh" do Init
1150:     * legado e ao "Thisform.GradeSubN.Refresh" do cmdExcluir.Click.
1151:     *
1152:     * par_lIrParaTopo - .T. reposiciona no primeiro registro (carga); .F.
1153:     *   preserva a linha corrente (exclusao, que ja reposicionou com o
1154:     *   SKIP / SKIP -1 do legado). Omitido = .T.
1155:     *--------------------------------------------------------------------------
1156:     PROCEDURE AtualizarGrade(par_lIrParaTopo)
1157:         LOCAL loc_lIrParaTopo
1158: 
1159:         loc_lIrParaTopo = IIF(VARTYPE(par_lIrParaTopo) = "L", par_lIrParaTopo, .T.)
1160: 
1161:         IF USED("cursor_4c_Vinculos")
1162:             SELECT cursor_4c_Vinculos
1163:             IF loc_lIrParaTopo
1164:                 GO TOP IN cursor_4c_Vinculos
1165:             ENDIF
1166:         ENDIF
1167: 
1168:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1169:             THIS.grd_4c_Dados.Refresh()
1170:         ENDIF
1171:     ENDPROC
1172: 
1173:     *--------------------------------------------------------------------------
1174:     * CmdInserirClick - SIGOPOPE.cmdInserir.Click (legado):
1175:     *
1176:     *   Thisform.lHouveIns = .T.
1177:     *   Select TmpCcOpe
1178:     *   Locate for Grupos = ' '
1179:     *   If Eof()
1180:     *       Insert Into TmpCcOpe (Dopes, CidChaves) Values (crSigCdOpe.Dopes, fUniqueIds())
1181:     *   EndIf
1182:     *   Select TmpCcOpe
1183:     *   Thisform.GradeSubN.Column1.SetFocus
1184:     *
1185:     * O LOCATE evita empilhar linhas em branco: se ja existe uma linha sem
1186:     * grupo, o botao so leva o foco de volta para ela.
1187:     *
1188:     * PUBLIC (nao PROTECTED): e alvo de BINDEVENT (regra CLAUDE.md #3).
1189:     *--------------------------------------------------------------------------
1190:     PROCEDURE CmdInserirClick()
1191:         LOCAL loc_oErro
1192: 
1193:         TRY
1194:             IF !USED("cursor_4c_Vinculos")
1195:                 MsgErro("Cursor da grade n" + CHR(227) + "o est" + CHR(225) + " aberto.", ;
1196:                         "Erro em CmdInserirClick")
1197:             ELSE
1198:                 THIS.this_lHouveIns = .T.
1199: 
1200:                 SELECT cursor_4c_Vinculos
1201:                 LOCATE FOR EMPTY(grupos)
1202: 
1203:                 IF EOF()
1204:                     INSERT INTO cursor_4c_Vinculos (dopes, cidchaves) ;
1205:                         VALUES (THIS.this_cDopes, LEFT(fUniqueIds(), 20))
1206:                 ENDIF
1207: 
1208:                 *-- repinta SEM GO TOP: a linha corrente e a recem-inserida
1209:                 *-- (ou a linha em branco que o LOCATE encontrou)
1210:                 THIS.AtualizarGrade(.F.)
1211: 
1212:                 IF THIS.grd_4c_Dados.Visible AND !THIS.grd_4c_Dados.ReadOnly
1213:                     THIS.grd_4c_Dados.Column1.SetFocus()
1214:                 ENDIF
1215:             ENDIF
1216:         CATCH TO loc_oErro
1217:             MsgErro(loc_oErro.Message + CHR(13) + ;
1218:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1219:                     "Procedure: " + loc_oErro.Procedure, ;
1220:                     "Erro em CmdInserirClick")
1221:         ENDTRY
1222:     ENDPROC
1223: 
1224:     *--------------------------------------------------------------------------
1225:     * CmdExcluirClick - SIGOPOPE.cmdExcluir.Click (legado):
1226:     *
1227:     *   Select TmpCcOpe
1228:     *   If Not Eof()
1229:     *       Thisform.lHouveExcl = .T.
1230:     *       Delete
1231:     *       Skip
1232:     *       Skip - 1
1233:     *   Endif
1234:     *   Thisform.GradeSubN.Refresh
1235:     *
1236:     * O "Skip / Skip -1" reposiciona o ponteiro num registro vivo depois da
1237:     * exclusao logica (com SET DELETED ON o registro apagado deixa de ser
1238:     * visitado); por isso a repintura aqui NAO vai para o topo.
1239:     *
1240:     * PUBLIC (nao PROTECTED): e alvo de BINDEVENT (regra CLAUDE.md #3).
1241:     *--------------------------------------------------------------------------
1242:     PROCEDURE CmdExcluirClick()
1243:         LOCAL loc_oErro
1244: 
1245:         TRY
1246:             IF !USED("cursor_4c_Vinculos")
1247:                 MsgErro("Cursor da grade n" + CHR(227) + "o est" + CHR(225) + " aberto.", ;
1248:                         "Erro em CmdExcluirClick")
1249:             ELSE
1250:                 SELECT cursor_4c_Vinculos
1251: 
1252:                 IF !EOF()
1253:                     THIS.this_lHouveExcl = .T.
1254:                     DELETE
1255:                     SKIP
1256:                     SKIP -1
1257: 
1258:                     IF EOF() OR BOF()
1259:                         GO TOP
1260:                     ENDIF
1261:                 ENDIF
1262: 
1263:                 THIS.AtualizarGrade(.F.)
1264:             ENDIF
1265:         CATCH TO loc_oErro
1266:             MsgErro(loc_oErro.Message + CHR(13) + ;
1267:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1268:                     "Procedure: " + loc_oErro.Procedure, ;
1269:                     "Erro em CmdExcluirClick")

*-- Linhas 1276 a 1347:
1276:     *
1277:     *   If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
1278:     *       If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
1279:     *           Select TmpCcOpe
1280:     *           Delete For Grupos = '  '
1281:     *           Replace all dopes With CrSigCdOpe.Dopes, CidChaves With fUniqueIds()
1282:     *           Select Grupos, sum(1) From TmpccOpe Group by 1 having sum(1) > 1 Into Cursor SecondKey
1283:     *           If Reccount() > 0
1284:     *               MessageBox('Existem Grupos em Duplicidade. Favor Acertar!!!',0+16,'Atencao')
1285:     *               Return .f.
1286:     *           EndIf
1287:     *           ...Delete From SigCcCpe Where Dopes = <operacao> + regrava o cursor...
1288:     *       EndIf
1289:     *   EndIf
1290:     *   Thisform.ParentForm.Enabled = .T.
1291:     *   Thisform.mCtrlBotoes(.T.)
1292:     *   ThisForm.Release
1293:     *
1294:     * O guard de duplicidade NAO fecha o dialogo ("Return .f." do legado):
1295:     * o usuario precisa acertar os grupos repetidos antes de sair. O
1296:     * "Replace all dopes/CidChaves" e o DELETE+regravacao ficam no BO
1297:     * (SalvarVinculos), em transacao unica.
1298:     *
1299:     * NAO ha RETURN dentro do TRY (regra CLAUDE.md #1): o fluxo e decidido
1300:     * pela flag loc_lPodeFechar e a saida acontece DEPOIS do ENDTRY.
1301:     *
1302:     * PUBLIC (nao PROTECTED): e alvo de BINDEVENT (regra CLAUDE.md #3).
1303:     *--------------------------------------------------------------------------
1304:     PROCEDURE CmdSairClick()
1305:         LOCAL loc_lPodeFechar, loc_lTemDuplicidade, loc_oErro
1306: 
1307:         loc_lPodeFechar     = .T.
1308:         loc_lTemDuplicidade = .F.
1309: 
1310:         TRY
1311:             *-- so grava quando o dialogo esta em modo de edicao (Inserir ou
1312:             *-- Excluir visiveis) E alguma coisa mudou na grade
1313:             IF (THIS.cmd_4c_CmdInserir.Visible OR THIS.cmd_4c_CmdExcluir.Visible) ;
1314:                AND (THIS.this_lHouveIns OR THIS.this_lHouveExcl) ;
1315:                AND USED("cursor_4c_Vinculos")
1316: 
1317:                 SELECT cursor_4c_Vinculos
1318: 
1319:                 *-- "Delete For Grupos = '  '": linha em branco nao vira registro
1320:                 DELETE FOR EMPTY(grupos)
1321: 
1322:                 IF USED("cursor_4c_Duplicados")
1323:                     USE IN cursor_4c_Duplicados
1324:                 ENDIF
1325: 
1326:                 SELECT grupos, COUNT(*) AS qtd ;
1327:                     FROM cursor_4c_Vinculos ;
1328:                     GROUP BY 1 ;
1329:                     HAVING COUNT(*) > 1 ;
1330:                     INTO CURSOR cursor_4c_Duplicados READWRITE
1331: 
1332:                 *-- cursor derivado de SELECT nao tem registro deletado, entao
1333:                 *-- RECCOUNT aqui conta exatamente as duplicidades
1334:                 loc_lTemDuplicidade = (USED("cursor_4c_Duplicados") AND RECCOUNT("cursor_4c_Duplicados") > 0)
1335: 
1336:                 IF USED("cursor_4c_Duplicados")
1337:                     USE IN cursor_4c_Duplicados
1338:                 ENDIF
1339: 
1340:                 IF loc_lTemDuplicidade
1341:                     *-- UNICO caminho em que o legado NAO fecha ("Return .f.")
1342:                     loc_lPodeFechar = .F.
1343:                     MsgAviso("Existem Grupos em Duplicidade. Favor Acertar!!!", ;
1344:                              "Aten" + CHR(231) + CHR(227) + "o")
1345:                     THIS.AtualizarGrade(.T.)
1346:                 ELSE
1347:                     IF VARTYPE(THIS.this_oBusinessObject) = "O"


### BO (C:\4c\projeto\app\classes\SigOpOpeBO.prg):
*====================================================================
* SigOpOpeBO.prg
*
* Business Object para Centro de Custo Padrao da Operacao
* Tabela: SigCcCpe (vinculo Grupo de Contas x Operacao)
* Tabelas relacionadas: SigCdOpe (operacao - FK dopes), SigCdGcr (grupo de contas - FK grupos)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpOpeBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCcCpe)
    this_cCidChaves      = ""    && cidchaves char(20) - PK (gerada via fUniqueIds())
    this_cDopes          = ""    && dopes     char(20) - codigo da operacao (FK SigCdOpe.dopes)
    this_cGrupos         = ""    && grupos    char(10) - codigo do grupo de contas (FK SigCdGcr.codigos)
    this_cGruCads        = ""    && grucads   char(10) - grupo de cadastro (conta contabil validada via fAcessoContab)
    this_nCtFils         = 0     && ctfils    numeric(1,0) - "C" = Somente Contas do Grupo (0/1)

    *-- Propriedade auxiliar de exibicao (NAO persistida em SigCcCpe)
    this_cDescricaoGrupo = ""    && SigCdGcr.descrs - descricao do grupo (join, somente leitura)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCcCpe"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpOpeBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    * (usada por RegistrarAuditoria)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia os campos do cursor para as propriedades
    * do vinculo Grupo de Contas x Operacao (SigCcCpe). par_cAliasCursor
    * eh o alias do cursor posicionado no registro a carregar (ex.: linha
    * corrente da grade TmpCcOpe, ou resultado de SQLEXEC pela chave).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "")
            THIS.this_cDopes     = TratarNulo(dopes,     "")
            THIS.this_cGrupos    = TratarNulo(grupos,    "")
            THIS.this_cGruCads   = TratarNulo(grucads,   "")
            THIS.this_nCtFils    = TratarNulo(ctfils,    0)

            *-- descrs nao eh coluna de SigCcCpe: so chega quando o cursor
            *-- de origem for montado com JOIN contra SigCdGcr (descricao
            *-- do grupo exibida na grade). Mapear so quando presente.
            IF TYPE(par_cAliasCursor + ".descrs") != "U"
                THIS.this_cDescricaoGrupo = TratarNulo(descrs, "")
            ELSE
                THIS.this_cDescricaoGrupo = ""
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT de um vinculo Grupo de Contas x Operacao em SigCcCpe
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigCcCpe (cidchaves, dopes, grupos, grucads, ctfils)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves)       + "," + ;
                       EscaparSQL(THIS.this_cDopes)           + "," + ;
                       EscaparSQL(THIS.this_cGrupos)          + "," + ;
                       EscaparSQL(THIS.this_cGruCads)         + "," + ;
                       FormatarNumeroSQL(THIS.this_nCtFils, 0) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir centro de custo padr" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir centro de custo padr" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE de um vinculo Grupo de Contas x Operacao em SigCcCpe
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCcCpe SET" + ;
                       " dopes    = " + EscaparSQL(THIS.this_cDopes)   + "," + ;
                       " grupos   = " + EscaparSQL(THIS.this_cGrupos)  + "," + ;
                       " grucads  = " + EscaparSQL(THIS.this_cGruCads) + "," + ;
                       " ctfils   = " + FormatarNumeroSQL(THIS.this_nCtFils, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar centro de custo padr" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar centro de custo padr" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *====================================================================
    * CarregarVinculos - Popula o cursor da grade com os vinculos
    * "Grupo de Contas x Operacao" ja gravados para a operacao recebida.
    *
    * Transcreve a consulta do PROCEDURE Init legado:
    *   lcSql = [Select a.*, b.Descrs as Dgrus From SigCcCpe a, SigCdGcr b
    *            where a.Dopes = <operacao> And a.Grupos = b.Codigos]
    *   SigCdOpe.PodataMgr.Sqlexecute(lcSql,'xCcOpe')
    *   Select * From xCcOpe Into Cursor TmpCcOpe ReadWrite
    *
    * O "a.*" do legado vira a lista EXPLICITA das 5 colunas de SigCcCpe
    * (cidchaves/dopes/grupos/grucads/ctfils): o APPEND FROM casa as
    * colunas por NOME, entao a lista do SELECT tem de ser exatamente a
    * do CREATE CURSOR do form.
    *
    * NAO faz SQLEXEC direto no alias da grade: isso FECHA e RECRIA o
    * alias, zerando ColumnCount/RecordSource/ControlSource e o
    * CurrentControl do CheckBox da Column4 (a grade viraria um retangulo
    * branco, sem erro e sem log). Por isso o SQL vai para um cursor
    * TEMPORARIO e o alias da grade e recarregado com ZAP + APPEND FROM
    * DBF(), que preserva estrutura e bindings.
    *
    * par_cDopes        - codigo da operacao (SigCdOpe.dopes)
    * par_cAliasDestino - alias ja criado (CREATE CURSOR) ligado a grade
    *====================================================================
    PROCEDURE CarregarVinculos(par_cDopes, par_cAliasDestino)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cTemp, loc_oErro
        LOCAL loc_cAliasAnterior, loc_cSafety

        loc_lSucesso       = .F.
        loc_cTemp          = "cursor_4c_VinculosTmp"
        loc_cAliasAnterior = ALIAS()
        loc_cSafety        = SET("SAFETY")

        TRY
            IF VARTYPE(par_cDopes) != "C" OR VARTYPE(par_cAliasDestino) != "C"
                MsgErro("Par" + CHR(226) + "metros inv" + CHR(225) + "lidos em CarregarVinculos.", ;
                        "Erro em CarregarVinculos")
            ELSE
                IF !USED(par_cAliasDestino)
                    MsgErro("Cursor da grade [" + par_cAliasDestino + "] n" + CHR(227) + ;
                            "o est" + CHR(225) + " aberto.", "Erro em CarregarVinculos")
                ELSE
                    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                        MsgErro("Conex" + CHR(227) + "o com o banco n" + CHR(227) + ;
                                "o estabelecida.", "Erro em CarregarVinculos")
                    ELSE
                        loc_cSQL = "SELECT a.cidchaves, a.dopes, a.grupos, a.grucads, a.ctfils," + ;
                                   " b.descrs AS dgrus" + ;
                                   " FROM SigCcCpe a, SigCdGcr b" + ;
                                   " WHERE a.dopes = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
                                   " AND a.grupos = b.codigos"

                        IF USED(loc_cTemp)
                            IF CURSORGETPROP("Buffering", loc_cTemp) > 1
                                TABLEREVERT(.T., loc_cTemp)
                            ENDIF
                            USE IN (loc_cTemp)
                        ENDIF

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cTemp)

                        IF loc_nResultado < 0
                            MsgErro("Erro ao carregar os centros de custo da opera" + CHR(231) + ;
                                    CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            *-- SET SAFETY e escopado por DATA SESSION: o
                            *-- SET SAFETY OFF do main.prg vale na sessao 1,
                            *-- mas este BO roda DENTRO da datasession
                            *-- privada do FormSigOpOpe (DataSession = 2),
                            *-- onde SAFETY nasce ON - medido no VFP9 em
                            *-- 2026-11-11 (automation/MedirDeletedSafetyDS2.prg:
                            *-- "SESSAO_FORM deleted=OFF safety=ON"). Com
                            *-- SAFETY ON o ZAP abre o dialogo modal
                            *-- "Zap ... Are you sure?" e CONGELA a tela.
                            SET SAFETY OFF

                            SELECT (par_cAliasDestino)
                            ZAP

                            IF loc_cSafety = "ON"
                                SET SAFETY ON
                            ENDIF

                            IF USED(loc_cTemp)
                                APPEND FROM DBF(loc_cTemp)
                                USE IN (loc_cTemp)
                            ENDIF
                            GO TOP IN (par_cAliasDestino)
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarVinculos")
        ENDTRY

        *-- rede de seguranca: excecao DURANTE o ZAP sairia com SAFETY OFF
        IF loc_cSafety = "ON"
            SET SAFETY ON
        ENDIF

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterGrupoContasAcessivel - Nucleo de fAcessoContab (Framework legado,
    * Framework\sigacess.PRG:1029) restrito ao caminho usado por SIGOPOPE
    * (os dois call sites do dump passam so pUsu/pTip/pTxt/pCod[/pDsc] -
    * pCta e pDat nunca sao informados, entao os blocos de vinculo com
    * conta-corrente (SigCdCli) e de bloqueio por periodo (ddRetros/ddFutus)
    * do legado NUNCA executam para este form e foram omitidos aqui).
    *
    * Replica a restricao de acesso por GRUPO DE CONTAS:
    *   - usuario "4CONTROL" (super-usuario) enxerga TODOS os grupos
    *     (equivalente a "llTot" do legado)
    *   - demais usuarios so veem grupos vinculados a eles via SigSyAgc
    *     (Usuacess direto) OU via grupo de acesso (SigCdAcG.Usuarios),
    *     igual ao JOIN de 3 tabelas do legado
    *   - se o usuario NAO tem NENHUM vinculo de restricao cadastrado em
    *     SigSyAgc/SigCdAcG, cai para a lista COMPLETA de SigCdGcr
    *     (equivalente a "llRst" do legado - sistema sem restricao
    *     configurada libera tudo)
    *
    * par_cFiltroCodigo - codigo exato a filtrar (Codigos = valor); vazio
    *   devolve TODOS os grupos acessiveis (usado para popular o picker).
    *
    * Retorna o codigo do SQLEXEC; o resultado fica no cursor
    * cursor_4c_GruposAcessiveis (colunas Codigos/Descrs) - o CHAMADOR
    * fecha esse cursor apos usar.
    *====================================================================
    FUNCTION ObterGrupoContasAcessivel(par_cFiltroCodigo)
        LOCAL loc_cUsuario, loc_lSuperUsuario, loc_cAlias, loc_cWhereUsuario
        LOCAL loc_cSQL, loc_nResultado, loc_nTotalVinculos, loc_lUsaRestricao
        LOCAL loc_cFiltro

        loc_cAlias   = "cursor_4c_GruposAcessiveis"
        loc_cFiltro  = IIF(VARTYPE(par_cFiltroCodigo) = "C", ALLTRIM(par_cFiltroCodigo), "")
        loc_cUsuario = ALLTRIM(UPPER(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")))
        loc_lSuperUsuario = (loc_cUsuario == "4CONTROL")

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_lUsaRestricao = !loc_lSuperUsuario AND !EMPTY(loc_cUsuario)

        IF loc_lUsaRestricao
            loc_cWhereUsuario = "(a.Usuacess = " + EscaparSQL(loc_cUsuario) + ;
                                 " OR c.Usuarios = " + EscaparSQL(loc_cUsuario) + ")"

            loc_cSQL = "SELECT COUNT(*) AS Nvinc FROM SigSyAgc a" + ;
                       " LEFT JOIN SigCdAcG c ON c.Grupos = a.Gracess AND c.Usuarios = " + ;
                       EscaparSQL(loc_cUsuario) + ;
                       " WHERE " + loc_cWhereUsuario

            IF USED("cursor_4c_ContaVinc")
                USE IN cursor_4c_ContaVinc
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaVinc")
            loc_nTotalVinculos = IIF(loc_nResultado >= 0 AND USED("cursor_4c_ContaVinc"), ;
                                      NVL(cursor_4c_ContaVinc.Nvinc, 0), 0)
            IF USED("cursor_4c_ContaVinc")
                USE IN cursor_4c_ContaVinc
            ENDIF

            *-- sem NENHUM vinculo de restricao cadastrado -> acesso livre
            loc_lUsaRestricao = (loc_nTotalVinculos > 0)
        ENDIF

        IF loc_lUsaRestricao
            loc_cSQL = "SELECT b.Codigos, b.Descrs" + ;
                       " FROM SigSyAgc a" + ;
                       " LEFT JOIN SigCdAcG c ON c.Grupos = a.Gracess AND c.Usuarios = " + ;
                       EscaparSQL(loc_cUsuario) + ;
                       " RIGHT JOIN SigCdGcr b ON b.Codigos = a.Grcontbs" + ;
                       " WHERE " + loc_cWhereUsuario
            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " AND b.Codigos = " + EscaparSQL(loc_cFiltro)
            ENDIF
            loc_cSQL = loc_cSQL + " GROUP BY b.Codigos, b.Descrs ORDER BY b.Codigos"
        ELSE
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr"
            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE Codigos = " + EscaparSQL(loc_cFiltro)
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY Codigos"
        ENDIF

        RETURN SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)
    ENDFUNC

    *====================================================================
    * SalvarVinculos - Regrava TODOS os vinculos da operacao a partir do
    * cursor da grade, em transacao unica.
    *
    * Transcreve o bloco de gravacao do cmdSair.Click legado:
    *   lcSql = [Delete From SigCcCpe Where Dopes = <operacao>]
    *   ...Sqlexecute(lcSql,'') / .poDataMgr.UpDate('crSigCcCpe') / Commit()
    *   Se qualquer etapa falhar -> RollBack()
    * O legado apaga tudo da operacao e regrava o cursor inteiro (o
    * "Zap / Append From Dbf('TmpCcOpe')" em crSigCcCpe antes do Update);
    * aqui o mesmo efeito vem de DELETE + um INSERT por linha.
    *
    * BEGIN/COMMIT por SQLEXEC NAO protege nada - a transacao e aberta na
    * CONEXAO (SQLSETPROP "Transactions" = 2) e encerrada com SQLTRANSACT,
    * restaurando o modo automatico (1) em TODOS os caminhos, inclusive
    * no CATCH.
    *
    * As linhas DELETADAS do cursor (o "Delete For Grupos = '  '" do
    * legado) ficam de fora porque o SCAN respeita SET DELETED ON; a
    * guarda por grupos vazio cobre o caso de SET DELETED OFF.
    *
    * par_cDopes       - codigo da operacao (SigCdOpe.dopes)
    * par_cAliasCursor - alias do cursor da grade com as linhas a gravar
    *====================================================================
    PROCEDURE SalvarVinculos(par_cDopes, par_cAliasCursor)
        LOCAL loc_lSucesso, loc_lTransacaoAberta, loc_lErroScan
        LOCAL loc_cSQL, loc_nResultado, loc_oErro, loc_cAliasAnterior

        loc_lSucesso         = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroScan        = .F.
        loc_cAliasAnterior   = ALIAS()

        TRY
            IF VARTYPE(par_cDopes) != "C" OR VARTYPE(par_cAliasCursor) != "C"
                MsgErro("Par" + CHR(226) + "metros inv" + CHR(225) + "lidos em SalvarVinculos.", ;
                        "Erro em SalvarVinculos")
            ELSE
                IF !USED(par_cAliasCursor)
                    MsgErro("Cursor da grade [" + par_cAliasCursor + "] n" + CHR(227) + ;
                            "o est" + CHR(225) + " aberto.", "Erro em SalvarVinculos")
                ELSE
                    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                        MsgErro("Conex" + CHR(227) + "o com o banco n" + CHR(227) + ;
                                "o estabelecida.", "Erro em SalvarVinculos")
                    ELSE
                        SQLSETPROP(gnConnHandle, "Transactions", 2)
                        loc_lTransacaoAberta = .T.

                        loc_cSQL = "DELETE FROM SigCcCpe WHERE dopes = " + ;
                                   EscaparSQL(ALLTRIM(par_cDopes))
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                        IF loc_nResultado < 0
                            loc_lErroScan = .T.
                            MsgErro("Erro ao limpar os centros de custo da opera" + CHR(231) + ;
                                    CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            SELECT (par_cAliasCursor)
                            GO TOP

                            SCAN
                                *-- linha em branco nao vira registro (o legado
                                *-- apaga essas linhas antes de gravar)
                                IF !EMPTY(EVALUATE(par_cAliasCursor + ".grupos"))
                                    IF !THIS.CarregarDoCursor(par_cAliasCursor)
                                        loc_lErroScan = .T.
                                        EXIT
                                    ENDIF

                                    *-- a operacao do vinculo e sempre a do form
                                    *-- chamador ("Replace all dopes With
                                    *-- CrSigCdOpe.Dopes" do legado)
                                    THIS.this_cDopes = ALLTRIM(par_cDopes)

                                    *-- PK nova para cada linha regravada
                                    *-- ("CidChaves With fUniqueIds()")
                                    THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)

                                    IF !THIS.Inserir()
                                        loc_lErroScan = .T.
                                        EXIT
                                    ENDIF
                                ENDIF
                            ENDSCAN
                        ENDIF

                        IF loc_lErroScan
                            SQLTRANSACT(gnConnHandle, "ROLLBACK")
                        ELSE
                            SQLTRANSACT(gnConnHandle, "COMMIT")
                            loc_lSucesso = .T.
                        ENDIF

                        SQLSETPROP(gnConnHandle, "Transactions", 1)
                        loc_lTransacaoAberta = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLTRANSACT(gnConnHandle, "ROLLBACK")
                SQLSETPROP(gnConnHandle, "Transactions", 1)
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SalvarVinculos")
        ENDTRY

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

