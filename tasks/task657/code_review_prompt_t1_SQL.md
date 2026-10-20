# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CSERIES, CNFIS, CODS, NKEYCODE, EMPS, NOCCORS, IF, PCEMPS, SERIES, NFIS

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
lcQryCorNf = [Select * From SigNfCor ]+;
lcQryEmp   = [Select * From SigCdEmp Where cemps = ?pcEmps ]
	.Column1.ControlSource = 'XCorNf.cods'
	.Column2.ControlSource = 'XCorNf.descs'
	.Column3.ControlSource = 'XCorNf.retifs'
Select XCorNf
Select CrSigNfCor
	Select CrSigCcOco
		Insert Into XCorNf (cods,descs,retifs) ;
	Select CrSigNfCor
		Select XCorNf
		Select CrSigNfCor
Select XCorNf
		Select XCorNf
		Select XCorNf
	lcQuery = [Delete From SigNfCor ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		lcQuery = [Update SigMvNfi ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		Update crSigMvNfi ;
	Select XCorNf
			Select crSigNfCor
				Insert Into crSigNfCor (cEmps, cSeries, cNfis, nOccors, mRetifs, cIdChaves) ;
	Select crSigNfCor
		If Not ThisForm.poDataMgr.Update([crSigNfCor])
			Select crSigNfCor
				lcQuery = [Update SigMvNfi ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
			Update crSigMvNfi ;
	Select XCorNf
	Select CrSigNfCor
	Select CrSigNfCor
		Select CrSigCcOco
			Insert Into XCorNf (cods,descs,retifs) ;
		Select CrSigNfCor
			If Seek(CrSigNfCor.noccors,'XCorNf.cods','cods')
			Select CrSigNfCor
		Select XCorNf

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCCO.prg) - TRECHOS RELEVANTES PARA PASS SQL (1149 linhas total):

*-- Linhas 23 a 49:
23: * o legado DE FATO tem:
24: *   - grd_4c_Dados        <- SIGOPCCO.Grade (3 colunas: Ocorrencia/Descricao/
25: *                            Retificacao), ligada a cursor_4c_Ocorrencias
26: *                            (equivalente ao "Create Cursor XCorNf" do Load).
27: *                            Column3 usa EditBox (Column3.Edit1 no legado),
28: *                            logo exige AddObject + CurrentControl + Sparse.
29: *   - cmg_4c_Sair         <- SIGOPCCO.Sair (CommandGroup Confirmar/Cancelar)
30: *   - CarregarDados()     <- bloco de carga que o legado repete IDENTICO em
31: *                            PROCEDURE Init e em Get_NotaIni.Valid: monta a
32: *                            lista de ocorrencias (SigCcOco) e casa cada uma
33: *                            com a retificacao gravada (SigNfCor)
34: *   - AtualizarGrade()    <- "Select XCorNf / Go Top / Grade.Refresh", metodo
35: *                            unico de repintura usado por todo caminho que
36: *                            popula o cursor
37: *
38: * Fase 5/8 - CAMPO NOTA (PARTE 1/2 - visual): adiciona ConfigurarCampoNota(),
39: * equivalente a SIGOPCCO.Say1 ("Nota : ") + SIGOPCCO.Get_NotaIni, com
40: * geometria TRANSCRITA do dump (Say1.Left=183/Top=94; Get_NotaIni.Left=220/
41: * Top=91/Width=52/MaxLength=6). O valor inicial (equivalente a
42: * "ThisForm.Get_NotaIni.Value = NFis" no PROCEDURE Init legado) e atribuido
43: * dentro do proprio metodo, com THIS.this_cNfis ja recebido pelo Init.
44: *
45: * Fase 6/8 - CAMPO NOTA (PARTE 2/2 - eventos e lookups):
46: *   - txt_4c_NotaIni.ReadOnly = .T. <- transcricao de Get_NotaIni.When
47: *     ("Return .f."): o campo NAO aceita digitacao, o valor vem so do form
48: *     chamador. NAO se faz isso com BINDEVENT "When" - BINDEVENT descarta o
49: *     retorno do delegate e o campo continuaria digitavel (regra CLAUDE.md #3).

*-- Linhas 66 a 86:
66: * confirmar.
67: *
68: * Fase 7/8 - EVENTOS PRINCIPAIS (Confirmar/Cancelar + navegacao da grade):
69: *   - BtnConfirmarClick()   <- Sair.Ok.Click: Delete+Insert(s)+Update de
70: *     SigNfCor/SigMvNfi.Correcs como LOTE T-SQL UNICO (SAVE TRANSACTION,
71: *     THIS.this_oBusinessObject.ConfirmarCorrecao) - o par SqlExecute/Commit/
72: *     RollBack do fSqlConector legado NAO protegia nada (a conexao
73: *     SQLSTRINGCONNECT ja nasce com @@TRANCOUNT=1), entao a atomicidade
74: *     pretendida so se reproduz num lote so. Sem retificacao gravada,
75: *     oferece "Confirma Impressao da Correcao ?" e abre Formsigreimc.
76: *   - BtnCancelarClick()    <- Sair.Cancela.Click: THIS.Release() direto.
77: *   - AbrirImpressaoCorrecao() <- "Do Form SigreImc With ..."; pEDNs (chave
78: *     EmpDopNums) vem do cursor global do form CHAMADOR no legado - aqui,
79: *     sem form chamador, e obtido de SigMvNfi.empdopnums pela mesma chave
80: *     natural Emps/Series/Nfis (THIS.this_oBusinessObject.ObterEmpDopNums).
81: *   - GradeRetificacaoKeyPress() <- Column3.Edit1.KeyPress: navegacao por
82: *     registro (Enter/Ctrl+X avanca, Ctrl+E volta, Tab vira Ctrl+Tab).
83: *
84: * Parametros recebidos (equivalentes a "LParameters pForm,Emp,Serie,EmisDe,
85: * EmisAte,NFis" do legado): o form chamador, empresa/serie/intervalo de
86: * emissao (repassados a impressao) e o numero da nota fiscal inicial, que

*-- Linhas 94 a 119:
94: *   - FormParaBO()     <- o bloco "ThisForm.Emp = Emp / ThisForm.Serie =
95: *     Serie / ThisForm.EmisDe = ... / ThisForm.pcNFisDe = NFis" do PROCEDURE
96: *     Init legado, MAIS a linha corrente da grade (XCorNf.Cods/Retifs, que o
97: *     Ok.Click le para montar cada Insert). Chamado pelo InicializarForm
98: *     (semeia o BO), pelo CarregarLista e pelo BtnConfirmarClick.
99: *   - BOParaForm()     <- o inverso: a nota vai para txt_4c_NotaIni
100: *     ("ThisForm.Get_NotaIni.Value = NFis") e a retificacao gravada vai para
101: *     a linha da grade pelo Seek/Replace do 2o Scan do Init/Valid legado.
102: *     Chamado pelo ConfigurarCampoNota e por CarregarDados (dentro do Scan).
103: *   - LimparCampos()   <- o ramo Else do Get_NotaIni.Valid ("This.Value = ''
104: *     / Select XCorNf / Zap / Grade.Refresh"), agora em fonte unica, usado
105: *     pelo ValidarNotaIni quando a nota nao tem correcao gravada.
106: *
107: * A barra CRUD canonica (os cinco botoes de manutencao da Page1 de Lista, o
108: * par Gravar/Desistir da Page2 de Dados e o Encerrar do canto) NAO EXISTE
109: * neste legado: o SIGOPCCO tem UM CommandGroup ("Sair") de dois botoes -
110: * Confirmar (Ok.Click, que grava) e Cancelar (Cancela.Click, que so fecha) -
111: * e nenhuma alternancia de pagina. Pelo mesmo motivo nao ha metodo de
112: * habilitacao por modo nem de ajuste de botoes por modo: a tela tem estado
113: * FIXO (campo da nota nao digitavel pelo Get_NotaIni.When; colunas
114: * Ocorrencia/Descricao travadas pelos Text1.When; so a coluna Retificacao
115: * aceita digitacao), definido uma vez na montagem. Criar esses metodos
116: * exigiria INVENTAR botoes e modos que o original nao tem (viola o PILAR 1)
117: * ou deixar corpo vazio (proibido pela regra de completude).
118: *==============================================================================
119: 

*-- Linhas 297 a 326:
297: 
298:     *--------------------------------------------------------------------------
299:     * CriarCursorOcorrencias - cursor LOCAL (nao SQL) de ocorrencias de
300:     * correcao, equivalente ao "Create Cursor XCorNf (cods n(3),descs c(30),
301:     * retifs m(8) NULL) / Index On cods Tag cods" do PROCEDURE Load legado.
302:     * E repopulado a cada troca de Nota Fiscal (Fase 6, Get_NotaIni.Valid) -
303:     * por isso o reset defensivo no inicio, igual ao padrao de todo form que
304:     * recria cursor local proprio.
305:     *--------------------------------------------------------------------------
306:     PROTECTED PROCEDURE CriarCursorOcorrencias()
307:         IF USED("cursor_4c_Ocorrencias")
308:             USE IN cursor_4c_Ocorrencias
309:         ENDIF
310: 
311:         CREATE CURSOR cursor_4c_Ocorrencias (cods N(3), descs C(30), retifs M NULL)
312:         INDEX ON cods TAG cods
313:     ENDPROC
314: 
315:     *--------------------------------------------------------------------------
316:     * ConfigurarGrade - grd_4c_Dados, equivalente a SIGOPCCO.Grade: 3 colunas
317:     * (Ocorrencia/Descricao/Retificacao), geometria TRANSCRITA do dump.
318:     * Column3 usa EditBox (nao Text1 - o legado tem Column3.Edit1), por isso
319:     * precisa de AddObject + CurrentControl + Sparse=.F. (regra #18 - sem
320:     * isso a coluna continua desenhando o Text1 default e a retificacao
321:     * digitada nunca aparece).
322:     *--------------------------------------------------------------------------
323:     PROTECTED PROCEDURE ConfigurarGrade()
324:         THIS.CriarCursorOcorrencias()
325: 
326:         THIS.AddObject("grd_4c_Dados", "Grid")

*-- Linhas 334 a 383:
334:             .ForeColor         = RGB(0, 0, 0)
335:             .AllowHeaderSizing = .F.
336:             .AllowRowSizing    = .F.
337:             .DeleteMark        = .F.
338:             .RecordMark        = .F.
339:             .GridLines         = 3
340:             .ReadOnly          = .F.
341:             .RowHeight         = 16
342:             .ScrollBars        = 2
343:             .TabIndex          = 5
344:             .ColumnCount       = 3
345:             .RecordSource      = "cursor_4c_Ocorrencias"
346: 
347:             .Column1.ControlSource     = "cursor_4c_Ocorrencias.cods"
348:             .Column1.Width             = 70
349:             .Column1.FontName          = "Tahoma"
350:             .Column1.FontSize          = 8
351:             .Column1.Movable           = .F.
352:             .Column1.Resizable         = .F.
353:             .Column1.ForeColor         = RGB(0, 0, 0)
354:             .Column1.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
355:             .Column1.Header1.Alignment = 2
356:             .Column1.Header1.FontName  = "Tahoma"
357:             .Column1.Header1.FontSize  = 8
358:             .Column1.Text1.BorderStyle = 0
359:             .Column1.Text1.Margin      = 0
360:             .Column1.Text1.ReadOnly    = .F.   && transcrito do dump (default)
361:             .Column1.Text1.ForeColor   = RGB(0, 0, 0)
362:             .Column1.Text1.BackColor   = RGB(255, 255, 255)
363:             *-- legado: Column1.Text1.When -> Return(.F.) (coluna nao digitavel).
364:             *-- POR ULTIMO de proposito: o ReadOnly do Grid propaga para as
365:             *-- colunas e o do Text1 reabriria a celula (regra CLAUDE.md #18/#46)
366:             .Column1.ReadOnly          = .T.
367: 
368:             .Column2.ControlSource     = "cursor_4c_Ocorrencias.descs"
369:             .Column2.Width             = 220
370:             .Column2.FontName          = "Tahoma"
371:             .Column2.FontSize          = 8
372:             .Column2.Movable           = .F.
373:             .Column2.Resizable         = .F.
374:             .Column2.ForeColor         = RGB(0, 0, 0)
375:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
376:             .Column2.Header1.Alignment = 2
377:             .Column2.Header1.FontName  = "Tahoma"
378:             .Column2.Header1.FontSize  = 8
379:             .Column2.Text1.BorderStyle = 0
380:             .Column2.Text1.Margin      = 0
381:             .Column2.Text1.ReadOnly    = .F.   && transcrito do dump (default)
382:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
383:             .Column2.Text1.BackColor   = RGB(255, 255, 255)

*-- Linhas 405 a 423:
405:             .Column3.edt_4c_Retificacao.FontSize  = 8
406:             .Column3.edt_4c_Retificacao.ForeColor = RGB(0, 0, 0)
407:             .Column3.CurrentControl    = "edt_4c_Retificacao"
408:             .Column3.ControlSource     = "cursor_4c_Ocorrencias.retifs"
409:             .Column3.Sparse            = .F.
410:             .Column3.ReadOnly          = .F.
411: 
412:             .Visible = .T.
413:         ENDWITH
414: 
415:         *-- SIGOPCCO.Grade.Column3.Edit1.KeyPress (legado): navegacao por
416:         *-- registro (Enter/Ctrl+X avancam, Ctrl+E volta, Tab vira Ctrl+Tab).
417:         *-- BINDEVENT exige que o metodo alvo ja exista em THIS e seja PUBLIC
418:         *-- (regra CLAUDE.md #3) - por isso vem DEPOIS do WITH acima.
419:         BINDEVENT(THIS.grd_4c_Dados.Column3.edt_4c_Retificacao, "KeyPress", ;
420:                   THIS, "GradeRetificacaoKeyPress")
421:     ENDPROC
422: 
423:     *--------------------------------------------------------------------------

*-- Linhas 566 a 591:
566:     * ValidarNotaIni - equivalente a SIGOPCCO.Get_NotaIni.Valid:
567:     *
568:     *   If !IsEmpty(This.Value)
569:     *       Select XCorNf / Zap
570:     *       pcNFisDe = This.Value / Requery('CrSigNfCor')
571:     *       If !Eof()
572:     *           <monta XCorNf a partir de CrSigCcOco + casa com CrSigNfCor>
573:     *       Else
574:     *           MessageBox('Nota sem Correcao !!',0+48,'')
575:     *           This.Value = '' / This.Refresh
576:     *           Select XCorNf / Zap / ThisForm.Grade.Refresh
577:     *           Return 0
578:     *       EndIf
579:     *   EndIf
580:     *
581:     * Campo vazio: o "If !IsEmpty" do legado envolve o metodo INTEIRO, sem
582:     * ramo Else - NAO faz nada (nem Zap, nem aviso). Campo preenchido:
583:     * delega a THIS.CarregarDados(valor, .T.), que ja reproduz o Zap +
584:     * Requery + os dois Scan (Fase 4) e, no ramo sem correcao gravada,
585:     * mostra "Nota sem Correcao !!" + zera a grade + repinta (regra do
586:     * par_lAvisarSemRegistro=.T.); aqui so falta zerar o proprio campo,
587:     * igual ao "This.Value = ''" do legado.
588:     *
589:     * Retorno: .T. quando a nota tem correcao gravada, .F. quando nao tem -
590:     * equivalente ao "Return 0" do ramo Else do Valid legado.
591:     *

*-- Linhas 607 a 679:
607:             loc_lTemCorrecao = THIS.CarregarDados(loc_cValor, .T.)
608: 
609:             IF !loc_lTemCorrecao
610:                 *-- "This.Value = '' / This.Refresh / Select XCorNf / Zap /
611:                 *-- ThisForm.Grade.Refresh" do ramo Else do Valid legado -
612:                 *-- centralizado em LimparCampos (fonte unica da limpeza).
613:                 THIS.LimparCampos()
614:             ENDIF
615:         ENDIF
616: 
617:         RETURN loc_lTemCorrecao
618:     ENDPROC
619: 
620:     *--------------------------------------------------------------------------
621:     * BtnConfirmarClick - equivalente a SIGOPCCO.Sair.Ok.Click:
622:     *
623:     *   If Not IsEmpty(ThisForm.Get_NotaIni.Value)
624:     *       <Delete SigNfCor + Update SigMvNfi.Correcs=.F. + Commit>
625:     *       Zap In crSigNfCor
626:     *       <para cada XCorNf.Retifs preenchido: Insert Into crSigNfCor>
627:     *       Select crSigNfCor / Go Top
628:     *       If !Eof()
629:     *           <Update(crSigNfCor) + Update SigMvNfi.Correcs=.T. + Commit>
630:     *       Else
631:     *           If MessageBox('Confirma Impressao da Correcao ?',4+32+256,'')=6
632:     *               <Do Form SigreImc com Emp/Serie/EmisDe/EmisAte/EmpDopNums/
633:     *                NFisDe/NFisDe>
634:     *           EndIf
635:     *       EndIf
636:     *       ThisForm.Release
637:     *   Else
638:     *       MessageBox('Nota Fiscal Invalida !!',0+48,'')
639:     *   EndIf
640:     *
641:     * O legado protege a sequencia Delete+Update+Insert(s)+Update com
642:     * SqlExecute/Commit/RollBack do fSqlConector - mas BEGIN/COMMIT via
643:     * SQLEXEC separados NAO protegem nada (a conexao SQLSTRINGCONNECT ja
644:     * nasce com @@TRANCOUNT=1, entao um par BEGIN/COMMIT so aninha o
645:     * contador e nunca efetiva rollback nenhum). A transcricao fiel da
646:     * ATOMICIDADE pretendida pelo legado (tudo ou nada) e um LOTE T-SQL
647:     * UNICO com SAVE TRANSACTION/TRY/CATCH/THROW (THIS.this_oBusinessObject.
648:     * ConfirmarCorrecao, padrao ProdutoBO.CopiarProduto) - nao os llTaOk/
649:     * Return 0 encadeados do VFP, que dependiam do Commit/RollBack que nao
650:     * protegia nada.
651:     *
652:     * "Zap In crSigNfCor" + o 1o Scan (monta crSigNfCor so com as linhas que
653:     * tem Retifs) + "Select crSigNfCor / Go Top / If !Eof()" virou
654:     * this_lTemCorrecoesGravadas: .T. quando o lote gravou pelo menos 1
655:     * retificacao (equivalente a "o buffer nao ficou vazio"), .F. quando
656:     * nenhuma linha de XCorNf tinha Retifs preenchido (equivalente ao buffer
657:     * vazio que cai no ramo "Confirma Impressao da Correcao ?").
658:     *
659:     * pEDNs ("CrSigMvNfi.Emps + CrSigMvNfi.Dopes + Str(CrSigMvNfi.Numes,6)")
660:     * vem, no legado, do cursor global do FORM CHAMADOR - aqui o form abre
661:     * direto do menu (sem form chamador com grade de notas), e a mesma chave
662:     * (SigMvNfi.empdopnums, coluna ja materializada - regra #42) e obtida
663:     * consultando a MESMA linha pela chave natural Emps/Series/Nfis que os
664:     * Updates acima ja usam (THIS.this_oBusinessObject.ObterEmpDopNums).
665:     *--------------------------------------------------------------------------
666:     PROCEDURE BtnConfirmarClick()
667:         LOCAL loc_cNfis, loc_lSucesso, loc_cEmpDopNums
668: 
669:         loc_cNfis = ALLTRIM(THIS.txt_4c_NotaIni.Value)
670: 
671:         IF EMPTY(loc_cNfis)
672:             *-- "MessageBox('Nota Fiscal Invalida !!',0+48,'')" - validacao de
673:             *-- UI, nao erro tecnico (regra CLAUDE.md: MsgAviso, nao MsgErro)
674:             MsgAviso("Nota Fiscal Inv" + CHR(225) + "lida !!", "")
675:         ELSE
676:             *-- Transfere tela -> BO ANTES de gravar: empresa/serie/nota e a
677:             *-- linha corrente da grade passam a ser lidas das properties do
678:             *-- proprio BO (fonte unica), em vez de repassadas como argumento
679:             *-- em cada chamada.

*-- Linhas 751 a 812:
751:         DO CASE
752:             CASE par_nKeyCode = 13 OR par_nKeyCode = 24
753:                 IF USED("cursor_4c_Ocorrencias")
754:                     SELECT cursor_4c_Ocorrencias
755:                     IF !EOF()
756:                         SKIP
757:                     ENDIF
758:                 ENDIF
759:                 THIS.grd_4c_Dados.Refresh()
760:             CASE par_nKeyCode = 5
761:                 IF USED("cursor_4c_Ocorrencias")
762:                     SELECT cursor_4c_Ocorrencias
763:                     IF !BOF()
764:                         SKIP -1
765:                     ENDIF
766:                 ENDIF
767:                 THIS.grd_4c_Dados.Refresh()
768:             CASE par_nKeyCode = 9
769:                 KEYBOARD "{CTRL+TAB}"
770:         ENDCASE
771:     ENDPROC
772: 
773:     *--------------------------------------------------------------------------
774:     * CarregarDados - popula a grade de ocorrencias da Carta de Correcao.
775:     *
776:     * TRANSCRICAO do bloco de carga do legado, que aparece IDENTICO em DOIS
777:     * lugares (PROCEDURE Init e Get_NotaIni.Valid) e aqui vira METODO UNICO:
778:     *
779:     *   Select XCorNf / Zap
780:     *   pcNFisDe = <nota> / ThisForm.poDataMgr.Requery('CrSigNfCor')
781:     *   Select CrSigNfCor / Go Top
782:     *   If !Eof()
783:     *       Select CrSigCcOco
784:     *       Scan
785:     *           Insert Into XCorNf (cods,descs,retifs) ;
786:     *           Values (CrSigCcOco.ncodigos,CrSigCcOco.cdescrs,'')
787:     *       EndScan
788:     *       Select CrSigNfCor
789:     *       Scan
790:     *           If Seek(CrSigNfCor.noccors,'XCorNf.cods','cods')
791:     *               Replace XCorNf.retifs With CrSigNfCor.mretifs
792:     *           EndIf
793:     *       EndScan
794:     *   Else
795:     *       MessageBox('Nota sem Correcao !!',0+48,'')   && SO no Valid
796:     *   EndIf
797:     *   Select XCorNf / Go Top / ThisForm.Refresh
798:     *
799:     * REGRA DE NEGOCIO transcrita (nao "simplificar"): a lista completa de
800:     * ocorrencias so eh montada quando a nota JA TEM correcao gravada. Nota
801:     * sem nenhuma linha em SigNfCor deixa a grade VAZIA de proposito - e o
802:     * que faz o Ok.Click cair no ramo "Confirma Impressao da Correcao ?".
803:     *
804:     * Parametros:
805:     *   par_cNfis              - nota fiscal a consultar (default: this_cNfis)
806:     *   par_lAvisarSemRegistro - .T. reproduz o aviso 'Nota sem Correcao !!'
807:     *       do Get_NotaIni.Valid. O Init legado NAO avisa (abre a grade vazia
808:     *       em silencio), por isso o aviso eh PARAMETRIZADO em vez de fixo.
809:     *
810:     * Retorno: .T. quando a nota tem correcao gravada (grade populada) e .F.
811:     * quando nao tem - o Valid do campo Nota usa esse retorno para reproduzir
812:     * o "Return 0" do legado.

*-- Linhas 821 a 921:
821:         loc_oBO          = THIS.this_oBusinessObject
822: 
823:         TRY
824:             *-- "Select XCorNf / Zap": esvazia a grade SEM derrubar o alias.
825:             *-- USE IN + CREATE CURSOR aqui quebraria RecordSource/
826:             *-- ControlSource/CurrentControl da grade ja criada - por isso
827:             *-- CriarCursorOcorrencias() so roda se o alias nao existir.
828:             IF !USED("cursor_4c_Ocorrencias")
829:                 THIS.CriarCursorOcorrencias()
830:             ENDIF
831:             SELECT cursor_4c_Ocorrencias
832:             ZAP
833: 
834:             IF VARTYPE(loc_oBO) = "O" AND !EMPTY(loc_cNfis)
835: 
836:                 *-- Requery('CrSigNfCor'): retificacoes JA gravadas na nota
837:                 IF loc_oBO.CarregarCorrecoes(THIS.this_cEmps, THIS.this_cSeries, loc_cNfis) ;
838:                    AND USED("cursor_4c_Correcoes") AND RECCOUNT("cursor_4c_Correcoes") > 0
839: 
840:                     loc_lTemCorrecao = .T.
841: 
842:                     *-- 1o Scan do legado: a LISTA COMPLETA de ocorrencias
843:                     *-- (CrSigCcOco) entra na grade com retificacao em branco
844:                     IF loc_oBO.CarregarOcorrencias() AND USED("cursor_4c_TiposOcorrencia")
845:                         SELECT cursor_4c_TiposOcorrencia
846:                         GO TOP
847:                         SCAN
848:                             INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) ;
849:                                  VALUES (cursor_4c_TiposOcorrencia.ncodigos, ;
850:                                          cursor_4c_TiposOcorrencia.cdescrs, ;
851:                                          "")
852:                             *-- INSERT INTO seleciona a tabela de DESTINO:
853:                             *-- reposicionar o alias do SCAN, igual ao
854:                             *-- "Select CrSigNfCor" que o legado faz no 2o Scan
855:                             SELECT cursor_4c_TiposOcorrencia
856:                         ENDSCAN
857:                     ENDIF
858: 
859:                     *-- 2o Scan do legado: casa a retificacao gravada com a
860:                     *-- ocorrencia correspondente (SEEK pelo TAG cods)
861:                     SELECT cursor_4c_Correcoes
862:                     GO TOP
863:                     SCAN
864:                         *-- Uma linha gravada de SigNfCor por vez: o BO le a
865:                         *-- linha (TratarNulo em mretifs, que e text NULL) e o
866:                         *-- BOParaForm faz o Seek + Replace na ocorrencia
867:                         *-- correspondente da grade. Fonte unica da
868:                         *-- transferencia BO -> tela.
869:                         loc_oBO.CarregarDoCursor("cursor_4c_Correcoes")
870:                         THIS.BOParaForm()
871:                         SELECT cursor_4c_Correcoes
872:                     ENDSCAN
873:                 ELSE
874:                     *-- Legado: o aviso existe SO no Get_NotaIni.Valid - o Init
875:                     *-- abre a grade vazia sem avisar nada
876:                     IF loc_lAvisar
877:                         MsgAviso("Nota sem Corre" + CHR(231) + CHR(227) + "o !!", "")
878:                     ENDIF
879:                 ENDIF
880:             ENDIF
881: 
882:             *-- "Select XCorNf / Go Top / ThisForm.Refresh"
883:             THIS.AtualizarGrade()
884:         CATCH TO loc_oErro
885:             MsgErro(loc_oErro.Message + CHR(13) + ;
886:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
887:                     "Procedure: " + loc_oErro.Procedure, ;
888:                     "Erro em CarregarDados")
889:         ENDTRY
890: 
891:         RETURN loc_lTemCorrecao
892:     ENDPROC
893: 
894:     *--------------------------------------------------------------------------
895:     * AtualizarGrade - METODO UNICO de repintura da grade, equivalente ao
896:     * "Select XCorNf / Go Top In XCorNf / ThisForm.Grade.Refresh" do legado.
897:     *
898:     * Popular o cursor NAO repinta a grade: sem GO TOP + Refresh explicitos a
899:     * grade fica visualmente VAZIA com o cursor cheio, e o sintoma ("a tela
900:     * nao traz dados") manda o diagnostico para SQL/cursor/permissao. Por isso
901:     * mora num metodo unico, chamado em TODO caminho que popula o cursor
902:     * (CarregarDados agora; o Valid da Nota e o Ok.Click nas Fases 7-8).
903:     *--------------------------------------------------------------------------
904:     PROCEDURE AtualizarGrade()
905:         IF USED("cursor_4c_Ocorrencias")
906:             SELECT cursor_4c_Ocorrencias
907:             GO TOP IN cursor_4c_Ocorrencias
908:         ENDIF
909: 
910:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
911:             THIS.grd_4c_Dados.Refresh()
912:         ENDIF
913:     ENDPROC
914: 
915:     *--------------------------------------------------------------------------
916:     * CarregarLista - FUNIL de carga da unica lista deste form: a grade de
917:     * ocorrencias da Carta de Correcao (SIGOPCCO.Grade, ligada ao cursor local
918:     * XCorNf no legado). Nao ha Page1=Lista/Page2=Dados aqui - a "lista" desta
919:     * tela e essa grade, e e ela que o PROCEDURE Init legado popula.
920:     *
921:     * Sequencia do funil: FormParaBO (tela -> BO, resolvendo a nota corrente)

*-- Linhas 957 a 975:
957:     *
958:     * mais a LINHA CORRENTE da grade, que e a ficha editavel desta tela: o
959:     * Ok.Click legado le XCorNf.Cods/XCorNf.Retifs para montar cada
960:     * "Insert Into crSigNfCor (... nOccors, mRetifs ...)".
961:     *
962:     * A nota tem DUAS fontes conforme o momento: o campo da tela quando ele
963:     * ja existe (fonte unica a partir dai - inclusive quando o Valid o zera
964:     * por "Nota sem Correcao", caso em que o branco e o estado REAL e tem de
965:     * chegar ao BO para o Ok.Click recusar com "Nota Fiscal Invalida !!") e o
966:     * parametro recebido do form chamador na 1a passagem, chamada pelo
967:     * InicializarForm antes de ConfigurarCampoNota criar o TextBox.
968:     *
969:     * PROTECTED obrigatoriamente: FormBase declara este hook PROTECTED e
970:     * VFP9 nao permite ALARGAR o escopo de metodo herdado.
971:     *
972:     * Retorno: .F. quando o BO nao esta instanciado (nada a transferir).
973:     *--------------------------------------------------------------------------
974:     PROTECTED PROCEDURE FormParaBO()
975:         LOCAL loc_lSucesso, loc_oErro

*-- Linhas 1082 a 1120:
1082:     *
1083:     *   This.Value = ''
1084:     *   This.Refresh
1085:     *   Select XCorNf
1086:     *   Zap
1087:     *   ThisForm.Grade.Refresh
1088:     *
1089:     * O Zap e o Refresh sao idempotentes: CarregarDados ja esvaziou e
1090:     * repintou a grade antes de cair no ramo sem registro, e repetir aqui
1091:     * mantem o metodo correto tambem se ele for chamado de outro caminho.
1092:     * Zap (nao USE IN + CREATE CURSOR) de proposito - derrubar o alias
1093:     * quebraria RecordSource/ControlSource/CurrentControl da grade.
1094:     *
1095:     * PROTECTED obrigatoriamente: FormBase declara este hook PROTECTED e
1096:     * VFP9 nao permite ALARGAR o escopo de metodo herdado.
1097:     *--------------------------------------------------------------------------
1098:     PROTECTED PROCEDURE LimparCampos()
1099:         IF PEMSTATUS(THIS, "txt_4c_NotaIni", 5)
1100:             THIS.txt_4c_NotaIni.Value = ""
1101:             THIS.txt_4c_NotaIni.Refresh()
1102:         ENDIF
1103: 
1104:         IF USED("cursor_4c_Ocorrencias")
1105:             SELECT cursor_4c_Ocorrencias
1106:             ZAP
1107:         ENDIF
1108: 
1109:         THIS.AtualizarGrade()
1110:     ENDPROC
1111: 
1112:     *--------------------------------------------------------------------------
1113:     * Destroy - equivalente ao "PROCEDURE Release" implicito do legado.
1114:     * Fecha o cursor local de ocorrencias (cursor_4c_Ocorrencias, criado em
1115:     * CriarCursorOcorrencias/ConfigurarGrade) para nao vazar work area entre
1116:     * aberturas sucessivas do dialogo.
1117:     * DODEFAULT() e a ULTIMA linha, obrigatoriamente: FormBase.Destroy faz o
1118:     * SET SYSMENU TO DEFAULT + RELEASE POPUP + CriarMenuPrincipal() que repoe
1119:     * os pads do menu principal depois de uma tela modal fechar.
1120:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\SIGOPCCOBO.prg):
*====================================================================
* SIGOPCCOBO.prg
*
* Business Object para Carta de Correcao de Nota Fiscal
* Tabela: SigNfCor
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGOPCCOBO AS BusinessBase

    *-- Propriedades da entidade (tabela SigNfCor - Carta de Correcao de NF)
    this_cCidchaves  = ""   && cidchaves char(20) - PK (chave unica Fortyus)
    this_cEmps       = ""   && cemps char(3) - empresa
    this_cSeries     = ""   && cseries char(3) - serie da nota fiscal
    this_cNfis       = ""   && cnfis char(6) - numero da nota fiscal
    this_nNoccors    = 0    && noccors numeric(3,0) - numero da ocorrencia (FK SigCcOco.ncodigos)
    this_cMretifs    = ""   && mretifs text - texto da retificacao/correcao

    *-- Propriedades de contexto (parametros recebidos do form chamador)
    this_dEmisDe     = {}   && data de emissao inicial (filtro repassado na impressao)
    this_dEmisAte    = {}   && data de emissao final (filtro repassado na impressao)

    *-- Propriedade auxiliar (tabela SigCdEmp - razao social da empresa)
    this_cRazas      = ""   && SigCdEmp.razas char(40) - razao social da empresa

    *-- Resultado de ConfirmarCorrecao(): .T. quando o lote gravou pelo
    *-- menos 1 retificacao (equivalente ao buffer crSigNfCor nao vazio do
    *-- Ok.Click legado); .F. quando nenhuma linha da grade tinha retifs
    *-- preenchido (ramo "Confirma Impressao da Correcao ?")
    this_lTemCorrecoesGravadas = .F.

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigNfCor"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia todas as colunas de SigNfCor (CrSigNfCor)
    * para as propriedades this_* do BO.
    *
    * TratarNulo(valor, PADRAO): o 2o argumento e o VALOR de fallback usado
    * quando a coluna vem NULL - NAO o tipo. Por isso "" para char/text e 0
    * para numeric (mretifs e text NULL no schema, logo o caso NULL e real).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                THIS.this_cEmps      = TratarNulo(cemps,     "")
                THIS.this_cSeries    = TratarNulo(cseries,   "")
                THIS.this_cNfis      = TratarNulo(cnfis,     "")
                THIS.this_nNoccors   = TratarNulo(noccors,   0)
                THIS.this_cMretifs   = TratarNulo(mretifs,   "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SIGOPCCOBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Grava nova ocorrencia de Carta de Correcao em SigNfCor
    * Gera cidchaves (PK Fortyus) quando o registro ainda nao tem uma
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cCidchaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigNfCor (cemps, cseries, cnfis, noccors, mretifs, cidchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cSeries)>>,
                    <<EscaparSQL(THIS.this_cNfis)>>,
                    <<FormatarNumeroSQL(THIS.this_nNoccors, 0)>>,
                    <<EscaparSQL(THIS.this_cMretifs)>>,
                    <<EscaparSQL(THIS.this_cCidchaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao inserir Carta de Corre" + CHR(231) + CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message, "SIGOPCCOBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza o texto de retificacao de uma ocorrencia
    * existente em SigNfCor (chave primaria cidchaves)
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigNfCor
                SET cemps    = <<EscaparSQL(THIS.this_cEmps)>>,
                    cseries  = <<EscaparSQL(THIS.this_cSeries)>>,
                    cnfis    = <<EscaparSQL(THIS.this_cNfis)>>,
                    noccors  = <<FormatarNumeroSQL(THIS.this_nNoccors, 0)>>,
                    mretifs  = <<EscaparSQL(THIS.this_cMretifs)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidchaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao atualizar Carta de Corre" + CHR(231) + CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message, "SIGOPCCOBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarOcorrencias - popula cursor_4c_TiposOcorrencia com a LISTA
    * COMPLETA de ocorrencias de correcao (tabela SigCcOco).
    *
    * Equivalente ao cursor CrSigCcOco do legado:
    *   .AddCursor('SigCcOco','ncodigos','CrSigCcOco','','')
    *   ThisForm.poDataMgr.Requery('CrSigCcOco')
    *
    * O legado nao filtra nada - traz a tabela inteira - e ordena por
    * ncodigos (chave do AddCursor), que e a ordem em que as ocorrencias
    * aparecem na grade.
    *
    * Colunas conferidas em docs/schema.sql: SigCcOco.ncodigos numeric(3,0),
    * SigCcOco.cdescrs char(30).
    *====================================================================
    PROCEDURE CarregarOcorrencias()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT ncodigos, cdescrs" + ;
                       "  FROM SigCcOco" + ;
                       " ORDER BY ncodigos"

            IF USED("cursor_4c_TiposOcorrencia")
                USE IN cursor_4c_TiposOcorrencia
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TiposOcorrencia")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao carregar ocorr" + CHR(234) + "ncias de corre" + CHR(231) + CHR(227) + "o:" + ;
                            CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SIGOPCCOBO.CarregarOcorrencias")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarCorrecoes - popula cursor_4c_Correcoes com as retificacoes
    * JA GRAVADAS para uma nota fiscal (tabela SigNfCor).
    *
    * Equivalente ao cursor CrSigNfCor do legado, com a MESMA query:
    *   lcQryCorNf = [Select * From SigNfCor ]+
    *                [Where cemps = ?pcEmps And cseries = ?pcSeries
    *                       And cnfis = ?pcNFis ]+
    *                [Order By cemps,cseries,cnfis,noccors ]
    *
    * O legado passa os 3 filtros SEMPRE (inclusive vazios, via parametro do
    * fSqlConector) e re-executa a mesma query em Get_NotaIni.Valid trocando
    * so pcNFisDe - aqui isso vira o parametro par_cNfis.
    *
    * PADR nas larguras do schema (cemps/cseries char(3), cnfis char(6)) -
    * igual ao Padr(...,3)/Padr(...,6) que o proprio legado usa nos Delete/
    * Update do Ok.Click.
    *====================================================================
    PROCEDURE CarregarCorrecoes(par_cEmps, par_cSeries, par_cNfis)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        LOCAL loc_cEmps, loc_cSeries, loc_cNfis
        loc_lSucesso = .F.

        loc_cEmps   = PADR(IIF(VARTYPE(par_cEmps)   = "C", ALLTRIM(par_cEmps),   ""), 3)
        loc_cSeries = PADR(IIF(VARTYPE(par_cSeries) = "C", ALLTRIM(par_cSeries), ""), 3)
        loc_cNfis   = PADR(IIF(VARTYPE(par_cNfis)   = "C", ALLTRIM(par_cNfis),   ""), 6)

        TRY
            loc_cSQL = "SELECT cemps, cseries, cnfis, noccors, mretifs, cidchaves" + ;
                       "  FROM SigNfCor" + ;
                       " WHERE cemps   = " + EscaparSQL(loc_cEmps) + ;
                       "   AND cseries = " + EscaparSQL(loc_cSeries) + ;
                       "   AND cnfis   = " + EscaparSQL(loc_cNfis) + ;
                       " ORDER BY cemps, cseries, cnfis, noccors"

            IF USED("cursor_4c_Correcoes")
                USE IN cursor_4c_Correcoes
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Correcoes")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao carregar as corre" + CHR(231) + CHR(245) + "es da nota fiscal:" + ;
                            CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SIGOPCCOBO.CarregarCorrecoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ConfirmarCorrecao - grava a Carta de Correcao da nota fiscal como UM
    * LOTE SQL atomico: apaga as retificacoes anteriores (SigNfCor) e grava
    * so as linhas de cursor_4c_Ocorrencias (a grade do form) com texto de
    * retificacao preenchido, atualizando a flag SigMvNfi.Correcs.
    *
    * Equivalente ao Ok.Click do legado:
    *   Delete From SigNfCor Where CEmps=... And CSeries=... And CNfis=...
    *   Update SigMvNfi Set Correcs = .F. Where ...   (commit)
    *   Zap In crSigNfCor
    *   <para cada linha de XCorNf com Retifs preenchido:
    *        Insert Into crSigNfCor (cEmps,cSeries,cNfis,nOccors,mRetifs,cIdChaves)>
    *   Update(crSigNfCor)
    *   Se crSigNfCor nao ficou vazio:
    *       Update SigMvNfi Set Correcs = .T. Where ...   (commit)
    *
    * BEGIN/COMMIT via SQLEXEC separados NAO protegem (a conexao
    * SQLSTRINGCONNECT ja nasce com @@TRANCOUNT=1 - um par BEGIN/COMMIT so
    * aninha o contador e um ROLLBACK depois nao desfaz nada). A
    * atomicidade pretendida pelo legado (tudo ou nada) vai num SQLEXEC
    * UNICO com SAVE TRANSACTION/TRY/CATCH/THROW em T-SQL, no mesmo padrao
    * de ProdutoBO.CopiarProduto.
    *
    * fUniqueIds() gera a PK (cidchaves) de cada linha nova - igual ao
    * Insert Into do legado. this_lTemCorrecoesGravadas fica .T. quando
    * pelo menos 1 linha foi incluida no lote.
    *====================================================================
    PROCEDURE ConfirmarCorrecao(par_cEmps, par_cSeries, par_cNfis)
        LOCAL loc_cEmps, loc_cSeries, loc_cNfis, loc_cLote, loc_cInserts
        LOCAL loc_nResultado, loc_lSucesso, loc_oErro

        *-- Argumento ausente cai na PROPRIA property, que o FormParaBO do
        *-- form acabou de preencher - assim o form nao precisa repassar como
        *-- argumento o que ja esta no BO (fonte unica). PADR nas larguras do
        *-- schema (cemps/cseries char(3), cnfis char(6)), igual ao
        *-- Padr(...,3)/Padr(...,6) do Ok.Click legado.
        loc_cEmps   = PADR(ALLTRIM(IIF(VARTYPE(par_cEmps)   = "C", par_cEmps,   THIS.this_cEmps)),   3)
        loc_cSeries = PADR(ALLTRIM(IIF(VARTYPE(par_cSeries) = "C", par_cSeries, THIS.this_cSeries)), 3)
        loc_cNfis   = PADR(ALLTRIM(IIF(VARTYPE(par_cNfis)   = "C", par_cNfis,   THIS.this_cNfis)),   6)

        THIS.this_cMensagemErro         = ""
        THIS.this_lErroExibido          = .F.
        THIS.this_lTemCorrecoesGravadas = .F.
        loc_lSucesso = .F.
        loc_cInserts = ""

        TRY
            IF !USED("cursor_4c_Ocorrencias")
                THIS.this_cMensagemErro = "Grade de ocorr" + CHR(234) + "ncias n" + CHR(227) + "o carregada."
                THIS.ExibirFalha("Confirmar")
            ELSE
                *-- "Zap In crSigNfCor" + 1o Scan (so as linhas com Retifs
                *-- preenchido entram no buffer)
                SELECT cursor_4c_Ocorrencias
                GO TOP
                SCAN
                    IF !EMPTY(cursor_4c_Ocorrencias.retifs)
                        *-- ALLTRIM tira espacos sobrando que o EditBox pode
                        *-- deixar no texto digitado antes de gravar
                        loc_cInserts = loc_cInserts + ;
                            "INSERT INTO SigNfCor (cemps, cseries, cnfis, noccors, mretifs, cidchaves) VALUES (" + ;
                            EscaparSQL(loc_cEmps) + ", " + ;
                            EscaparSQL(loc_cSeries) + ", " + ;
                            EscaparSQL(loc_cNfis) + ", " + ;
                            FormatarNumeroSQL(cursor_4c_Ocorrencias.cods, 0) + ", " + ;
                            EscaparSQL(ALLTRIM(cursor_4c_Ocorrencias.retifs)) + ", " + ;
                            EscaparSQL(fUniqueIds()) + ");" + CHR(13) + CHR(10)
                        SELECT cursor_4c_Ocorrencias
                    ENDIF
                ENDSCAN

                THIS.this_lTemCorrecoesGravadas = !EMPTY(loc_cInserts)

                loc_cLote = "SET NOCOUNT ON;" + CHR(13) + CHR(10) + ;
                    "DECLARE @nivel int = @@TRANCOUNT;" + CHR(13) + CHR(10) + ;
                    "IF @nivel = 0 BEGIN TRANSACTION" + CHR(13) + CHR(10) + ;
                    "ELSE SAVE TRANSACTION Cco4c;" + CHR(13) + CHR(10) + ;
                    "BEGIN TRY" + CHR(13) + CHR(10) + ;
                    "DELETE FROM SigNfCor WHERE cemps = " + EscaparSQL(loc_cEmps) + ;
                        " AND cseries = " + EscaparSQL(loc_cSeries) + ;
                        " AND cnfis = " + EscaparSQL(loc_cNfis) + ";" + CHR(13) + CHR(10) + ;
                    loc_cInserts + ;
                    "UPDATE SigMvNfi SET correcs = " + IIF(THIS.this_lTemCorrecoesGravadas, "1", "0") + ;
                        " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
                        " AND series = " + EscaparSQL(loc_cSeries) + ;
                        " AND nfis = " + EscaparSQL(loc_cNfis) + ";" + CHR(13) + CHR(10) + ;
                    "IF @nivel = 0 COMMIT TRANSACTION;" + CHR(13) + CHR(10) + ;
                    "END TRY" + CHR(13) + CHR(10) + ;
                    "BEGIN CATCH" + CHR(13) + CHR(10) + ;
                    "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + CHR(13) + CHR(10) + ;
                    "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Cco4c; END;" + CHR(13) + CHR(10) + ;
                    "THROW;" + CHR(13) + CHR(10) + ;
                    "END CATCH"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cLote)

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    THIS.ExibirFalha("Confirmar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            THIS.ExibirFalha("Confirmar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterEmpDopNums - devolve SigMvNfi.empdopnums (coluna ja
    * materializada = Emps char(3) + Dopes char(20) + Str(Numes,6), total
    * char(29) - regra #42) da nota fiscal atual.
    *
    * Equivalente a "CrSigMvNfi.Emps + CrSigMvNfi.Dopes +
    * Str(CrSigMvNfi.Numes,6)" do Ok.Click legado, que monta a chave a
    * partir do cursor global do FORM CHAMADOR (CrSigMvNfi). Sem form
    * chamador nesta migracao (SIGOPCCO abre direto do menu), a mesma linha
    * e localizada pela chave natural Emps/Series/Nfis que os Updates de
    * ConfirmarCorrecao() ja usam.
    *====================================================================
    PROCEDURE ObterEmpDopNums(par_cEmps, par_cSeries, par_cNfis)
        LOCAL loc_cSQL, loc_nResultado, loc_cRetorno, loc_oErro

        loc_cRetorno = ""

        TRY
            *-- Argumento ausente cai na PROPRIA property (preenchida pelo
            *-- FormParaBO do form), mesmo criterio de ConfirmarCorrecao
            loc_cSQL = "SELECT empdopnums" + ;
                       "  FROM SigMvNfi" + ;
                       " WHERE emps   = " + EscaparSQL(PADR(ALLTRIM(IIF(VARTYPE(par_cEmps)   = "C", par_cEmps,   THIS.this_cEmps)),   3)) + ;
                       "   AND series = " + EscaparSQL(PADR(ALLTRIM(IIF(VARTYPE(par_cSeries) = "C", par_cSeries, THIS.this_cSeries)), 3)) + ;
                       "   AND nfis   = " + EscaparSQL(PADR(ALLTRIM(IIF(VARTYPE(par_cNfis)   = "C", par_cNfis,   THIS.this_cNfis)),   6))

            IF USED("cursor_4c_EmpDopNums")
                USE IN cursor_4c_EmpDopNums
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDopNums")

            IF loc_nResultado >= 0 AND USED("cursor_4c_EmpDopNums") AND RECCOUNT("cursor_4c_EmpDopNums") > 0
                loc_cRetorno = cursor_4c_EmpDopNums.empdopnums
            ENDIF

            IF USED("cursor_4c_EmpDopNums")
                USE IN cursor_4c_EmpDopNums
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SIGOPCCOBO.ObterEmpDopNums")
        ENDTRY

        RETURN loc_cRetorno
    ENDPROC


ENDDEFINE

