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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCCO.prg) - TRECHOS RELEVANTES PARA PASS SQL (1157 linhas total):

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

*-- Linhas 297 a 327:
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
311:         SET NULL ON
312:         CREATE CURSOR cursor_4c_Ocorrencias (cods N(3), descs C(30), retifs M NULL)
313:         SET NULL OFF
314:         INDEX ON cods TAG cods
315:     ENDPROC
316: 
317:     *--------------------------------------------------------------------------
318:     * ConfigurarGrade - grd_4c_Dados, equivalente a SIGOPCCO.Grade: 3 colunas
319:     * (Ocorrencia/Descricao/Retificacao), geometria TRANSCRITA do dump.
320:     * Column3 usa EditBox (nao Text1 - o legado tem Column3.Edit1), por isso
321:     * precisa de AddObject + CurrentControl + Sparse=.F. (regra #18 - sem
322:     * isso a coluna continua desenhando o Text1 default e a retificacao
323:     * digitada nunca aparece).
324:     *--------------------------------------------------------------------------
325:     PROTECTED PROCEDURE ConfigurarGrade()
326:         THIS.CriarCursorOcorrencias()
327: 

*-- Linhas 344 a 391:
344:             .ForeColor         = RGB(0, 0, 0)
345:             .AllowHeaderSizing = .F.
346:             .AllowRowSizing    = .F.
347:             .DeleteMark        = .F.
348:             .RecordMark        = .F.
349:             .GridLines         = 3
350:             .ReadOnly          = .F.
351:             .RowHeight         = 16
352:             .ScrollBars        = 2
353:             .TabIndex          = 5
354: 
355:             .Column1.ControlSource     = "cursor_4c_Ocorrencias.cods"
356:             .Column1.Width             = 70
357:             .Column1.FontName          = "Tahoma"
358:             .Column1.FontSize          = 8
359:             .Column1.Movable           = .F.
360:             .Column1.Resizable         = .F.
361:             .Column1.ForeColor         = RGB(0, 0, 0)
362:             .Column1.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
363:             .Column1.Header1.Alignment = 2
364:             .Column1.Header1.FontName  = "Tahoma"
365:             .Column1.Header1.FontSize  = 8
366:             .Column1.Text1.BorderStyle = 0
367:             .Column1.Text1.Margin      = 0
368:             .Column1.Text1.ReadOnly    = .F.   && transcrito do dump (default)
369:             .Column1.Text1.ForeColor   = RGB(0, 0, 0)
370:             .Column1.Text1.BackColor   = RGB(255, 255, 255)
371:             *-- legado: Column1.Text1.When -> Return(.F.) (coluna nao digitavel).
372:             *-- POR ULTIMO de proposito: o ReadOnly do Grid propaga para as
373:             *-- colunas e o do Text1 reabriria a celula (regra CLAUDE.md #18/#46)
374:             .Column1.ReadOnly          = .T.
375: 
376:             .Column2.ControlSource     = "cursor_4c_Ocorrencias.descs"
377:             .Column2.Width             = 220
378:             .Column2.FontName          = "Tahoma"
379:             .Column2.FontSize          = 8
380:             .Column2.Movable           = .F.
381:             .Column2.Resizable         = .F.
382:             .Column2.ForeColor         = RGB(0, 0, 0)
383:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
384:             .Column2.Header1.Alignment = 2
385:             .Column2.Header1.FontName  = "Tahoma"
386:             .Column2.Header1.FontSize  = 8
387:             .Column2.Text1.BorderStyle = 0
388:             .Column2.Text1.Margin      = 0
389:             .Column2.Text1.ReadOnly    = .F.   && transcrito do dump (default)
390:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
391:             .Column2.Text1.BackColor   = RGB(255, 255, 255)

*-- Linhas 413 a 431:
413:             .Column3.edt_4c_Retificacao.FontSize  = 8
414:             .Column3.edt_4c_Retificacao.ForeColor = RGB(0, 0, 0)
415:             .Column3.CurrentControl    = "edt_4c_Retificacao"
416:             .Column3.ControlSource     = "cursor_4c_Ocorrencias.retifs"
417:             .Column3.Sparse            = .F.
418:             .Column3.ReadOnly          = .F.
419: 
420:             .Visible = .T.
421:         ENDWITH
422: 
423:         *-- SIGOPCCO.Grade.Column3.Edit1.KeyPress (legado): navegacao por
424:         *-- registro (Enter/Ctrl+X avancam, Ctrl+E volta, Tab vira Ctrl+Tab).
425:         *-- BINDEVENT exige que o metodo alvo ja exista em THIS e seja PUBLIC
426:         *-- (regra CLAUDE.md #3) - por isso vem DEPOIS do WITH acima.
427:         BINDEVENT(THIS.grd_4c_Dados.Column3.edt_4c_Retificacao, "KeyPress", ;
428:                   THIS, "GradeRetificacaoKeyPress")
429:     ENDPROC
430: 
431:     *--------------------------------------------------------------------------

*-- Linhas 574 a 599:
574:     * ValidarNotaIni - equivalente a SIGOPCCO.Get_NotaIni.Valid:
575:     *
576:     *   If !IsEmpty(This.Value)
577:     *       Select XCorNf / Zap
578:     *       pcNFisDe = This.Value / Requery('CrSigNfCor')
579:     *       If !Eof()
580:     *           <monta XCorNf a partir de CrSigCcOco + casa com CrSigNfCor>
581:     *       Else
582:     *           MessageBox('Nota sem Correcao !!',0+48,'')
583:     *           This.Value = '' / This.Refresh
584:     *           Select XCorNf / Zap / ThisForm.Grade.Refresh
585:     *           Return 0
586:     *       EndIf
587:     *   EndIf
588:     *
589:     * Campo vazio: o "If !IsEmpty" do legado envolve o metodo INTEIRO, sem
590:     * ramo Else - NAO faz nada (nem Zap, nem aviso). Campo preenchido:
591:     * delega a THIS.CarregarDados(valor, .T.), que ja reproduz o Zap +
592:     * Requery + os dois Scan (Fase 4) e, no ramo sem correcao gravada,
593:     * mostra "Nota sem Correcao !!" + zera a grade + repinta (regra do
594:     * par_lAvisarSemRegistro=.T.); aqui so falta zerar o proprio campo,
595:     * igual ao "This.Value = ''" do legado.
596:     *
597:     * Retorno: .T. quando a nota tem correcao gravada, .F. quando nao tem -
598:     * equivalente ao "Return 0" do ramo Else do Valid legado.
599:     *

*-- Linhas 615 a 687:
615:             loc_lTemCorrecao = THIS.CarregarDados(loc_cValor, .T.)
616: 
617:             IF !loc_lTemCorrecao
618:                 *-- "This.Value = '' / This.Refresh / Select XCorNf / Zap /
619:                 *-- ThisForm.Grade.Refresh" do ramo Else do Valid legado -
620:                 *-- centralizado em LimparCampos (fonte unica da limpeza).
621:                 THIS.LimparCampos()
622:             ENDIF
623:         ENDIF
624: 
625:         RETURN loc_lTemCorrecao
626:     ENDPROC
627: 
628:     *--------------------------------------------------------------------------
629:     * BtnConfirmarClick - equivalente a SIGOPCCO.Sair.Ok.Click:
630:     *
631:     *   If Not IsEmpty(ThisForm.Get_NotaIni.Value)
632:     *       <Delete SigNfCor + Update SigMvNfi.Correcs=.F. + Commit>
633:     *       Zap In crSigNfCor
634:     *       <para cada XCorNf.Retifs preenchido: Insert Into crSigNfCor>
635:     *       Select crSigNfCor / Go Top
636:     *       If !Eof()
637:     *           <Update(crSigNfCor) + Update SigMvNfi.Correcs=.T. + Commit>
638:     *       Else
639:     *           If MessageBox('Confirma Impressao da Correcao ?',4+32+256,'')=6
640:     *               <Do Form SigreImc com Emp/Serie/EmisDe/EmisAte/EmpDopNums/
641:     *                NFisDe/NFisDe>
642:     *           EndIf
643:     *       EndIf
644:     *       ThisForm.Release
645:     *   Else
646:     *       MessageBox('Nota Fiscal Invalida !!',0+48,'')
647:     *   EndIf
648:     *
649:     * O legado protege a sequencia Delete+Update+Insert(s)+Update com
650:     * SqlExecute/Commit/RollBack do fSqlConector - mas BEGIN/COMMIT via
651:     * SQLEXEC separados NAO protegem nada (a conexao SQLSTRINGCONNECT ja
652:     * nasce com @@TRANCOUNT=1, entao um par BEGIN/COMMIT so aninha o
653:     * contador e nunca efetiva rollback nenhum). A transcricao fiel da
654:     * ATOMICIDADE pretendida pelo legado (tudo ou nada) e um LOTE T-SQL
655:     * UNICO com SAVE TRANSACTION/TRY/CATCH/THROW (THIS.this_oBusinessObject.
656:     * ConfirmarCorrecao, padrao ProdutoBO.CopiarProduto) - nao os llTaOk/
657:     * Return 0 encadeados do VFP, que dependiam do Commit/RollBack que nao
658:     * protegia nada.
659:     *
660:     * "Zap In crSigNfCor" + o 1o Scan (monta crSigNfCor so com as linhas que
661:     * tem Retifs) + "Select crSigNfCor / Go Top / If !Eof()" virou
662:     * this_lTemCorrecoesGravadas: .T. quando o lote gravou pelo menos 1
663:     * retificacao (equivalente a "o buffer nao ficou vazio"), .F. quando
664:     * nenhuma linha de XCorNf tinha Retifs preenchido (equivalente ao buffer
665:     * vazio que cai no ramo "Confirma Impressao da Correcao ?").
666:     *
667:     * pEDNs ("CrSigMvNfi.Emps + CrSigMvNfi.Dopes + Str(CrSigMvNfi.Numes,6)")
668:     * vem, no legado, do cursor global do FORM CHAMADOR - aqui o form abre
669:     * direto do menu (sem form chamador com grade de notas), e a mesma chave
670:     * (SigMvNfi.empdopnums, coluna ja materializada - regra #42) e obtida
671:     * consultando a MESMA linha pela chave natural Emps/Series/Nfis que os
672:     * Updates acima ja usam (THIS.this_oBusinessObject.ObterEmpDopNums).
673:     *--------------------------------------------------------------------------
674:     PROCEDURE BtnConfirmarClick()
675:         LOCAL loc_cNfis, loc_lSucesso, loc_cEmpDopNums
676: 
677:         loc_cNfis = ALLTRIM(THIS.txt_4c_NotaIni.Value)
678: 
679:         IF EMPTY(loc_cNfis)
680:             *-- "MessageBox('Nota Fiscal Invalida !!',0+48,'')" - validacao de
681:             *-- UI, nao erro tecnico (regra CLAUDE.md: MsgAviso, nao MsgErro)
682:             MsgAviso("Nota Fiscal Inv" + CHR(225) + "lida !!", "")
683:         ELSE
684:             *-- Transfere tela -> BO ANTES de gravar: empresa/serie/nota e a
685:             *-- linha corrente da grade passam a ser lidas das properties do
686:             *-- proprio BO (fonte unica), em vez de repassadas como argumento
687:             *-- em cada chamada.

*-- Linhas 759 a 820:
759:         DO CASE
760:             CASE par_nKeyCode = 13 OR par_nKeyCode = 24
761:                 IF USED("cursor_4c_Ocorrencias")
762:                     SELECT cursor_4c_Ocorrencias
763:                     IF !EOF()
764:                         SKIP
765:                     ENDIF
766:                 ENDIF
767:                 THIS.grd_4c_Dados.Refresh()
768:             CASE par_nKeyCode = 5
769:                 IF USED("cursor_4c_Ocorrencias")
770:                     SELECT cursor_4c_Ocorrencias
771:                     IF !BOF()
772:                         SKIP -1
773:                     ENDIF
774:                 ENDIF
775:                 THIS.grd_4c_Dados.Refresh()
776:             CASE par_nKeyCode = 9
777:                 KEYBOARD "{CTRL+TAB}"
778:         ENDCASE
779:     ENDPROC
780: 
781:     *--------------------------------------------------------------------------
782:     * CarregarDados - popula a grade de ocorrencias da Carta de Correcao.
783:     *
784:     * TRANSCRICAO do bloco de carga do legado, que aparece IDENTICO em DOIS
785:     * lugares (PROCEDURE Init e Get_NotaIni.Valid) e aqui vira METODO UNICO:
786:     *
787:     *   Select XCorNf / Zap
788:     *   pcNFisDe = <nota> / ThisForm.poDataMgr.Requery('CrSigNfCor')
789:     *   Select CrSigNfCor / Go Top
790:     *   If !Eof()
791:     *       Select CrSigCcOco
792:     *       Scan
793:     *           Insert Into XCorNf (cods,descs,retifs) ;
794:     *           Values (CrSigCcOco.ncodigos,CrSigCcOco.cdescrs,'')
795:     *       EndScan
796:     *       Select CrSigNfCor
797:     *       Scan
798:     *           If Seek(CrSigNfCor.noccors,'XCorNf.cods','cods')
799:     *               Replace XCorNf.retifs With CrSigNfCor.mretifs
800:     *           EndIf
801:     *       EndScan
802:     *   Else
803:     *       MessageBox('Nota sem Correcao !!',0+48,'')   && SO no Valid
804:     *   EndIf
805:     *   Select XCorNf / Go Top / ThisForm.Refresh
806:     *
807:     * REGRA DE NEGOCIO transcrita (nao "simplificar"): a lista completa de
808:     * ocorrencias so eh montada quando a nota JA TEM correcao gravada. Nota
809:     * sem nenhuma linha em SigNfCor deixa a grade VAZIA de proposito - e o
810:     * que faz o Ok.Click cair no ramo "Confirma Impressao da Correcao ?".
811:     *
812:     * Parametros:
813:     *   par_cNfis              - nota fiscal a consultar (default: this_cNfis)
814:     *   par_lAvisarSemRegistro - .T. reproduz o aviso 'Nota sem Correcao !!'
815:     *       do Get_NotaIni.Valid. O Init legado NAO avisa (abre a grade vazia
816:     *       em silencio), por isso o aviso eh PARAMETRIZADO em vez de fixo.
817:     *
818:     * Retorno: .T. quando a nota tem correcao gravada (grade populada) e .F.
819:     * quando nao tem - o Valid do campo Nota usa esse retorno para reproduzir
820:     * o "Return 0" do legado.

*-- Linhas 829 a 929:
829:         loc_oBO          = THIS.this_oBusinessObject
830: 
831:         TRY
832:             *-- "Select XCorNf / Zap": esvazia a grade SEM derrubar o alias.
833:             *-- USE IN + CREATE CURSOR aqui quebraria RecordSource/
834:             *-- ControlSource/CurrentControl da grade ja criada - por isso
835:             *-- CriarCursorOcorrencias() so roda se o alias nao existir.
836:             IF !USED("cursor_4c_Ocorrencias")
837:                 THIS.CriarCursorOcorrencias()
838:             ENDIF
839:             SELECT cursor_4c_Ocorrencias
840:             ZAP
841: 
842:             IF VARTYPE(loc_oBO) = "O" AND !EMPTY(loc_cNfis)
843: 
844:                 *-- Requery('CrSigNfCor'): retificacoes JA gravadas na nota
845:                 IF loc_oBO.CarregarCorrecoes(THIS.this_cEmps, THIS.this_cSeries, loc_cNfis) ;
846:                    AND USED("cursor_4c_Correcoes") AND RECCOUNT("cursor_4c_Correcoes") > 0
847: 
848:                     loc_lTemCorrecao = .T.
849: 
850:                     *-- 1o Scan do legado: a LISTA COMPLETA de ocorrencias
851:                     *-- (CrSigCcOco) entra na grade com retificacao em branco
852:                     IF loc_oBO.CarregarOcorrencias() AND USED("cursor_4c_TiposOcorrencia")
853:                         SELECT cursor_4c_TiposOcorrencia
854:                         GO TOP
855:                         SCAN
856:                             INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) ;
857:                                  VALUES (cursor_4c_TiposOcorrencia.ncodigos, ;
858:                                          cursor_4c_TiposOcorrencia.cdescrs, ;
859:                                          "")
860:                             *-- INSERT INTO seleciona a tabela de DESTINO:
861:                             *-- reposicionar o alias do SCAN, igual ao
862:                             *-- "Select CrSigNfCor" que o legado faz no 2o Scan
863:                             SELECT cursor_4c_TiposOcorrencia
864:                         ENDSCAN
865:                     ENDIF
866: 
867:                     *-- 2o Scan do legado: casa a retificacao gravada com a
868:                     *-- ocorrencia correspondente (SEEK pelo TAG cods)
869:                     SELECT cursor_4c_Correcoes
870:                     GO TOP
871:                     SCAN
872:                         *-- Uma linha gravada de SigNfCor por vez: o BO le a
873:                         *-- linha (TratarNulo em mretifs, que e text NULL) e o
874:                         *-- BOParaForm faz o Seek + Replace na ocorrencia
875:                         *-- correspondente da grade. Fonte unica da
876:                         *-- transferencia BO -> tela.
877:                         loc_oBO.CarregarDoCursor("cursor_4c_Correcoes")
878:                         THIS.BOParaForm()
879:                         SELECT cursor_4c_Correcoes
880:                     ENDSCAN
881:                 ELSE
882:                     *-- Legado: o aviso existe SO no Get_NotaIni.Valid - o Init
883:                     *-- abre a grade vazia sem avisar nada
884:                     IF loc_lAvisar
885:                         MsgAviso("Nota sem Corre" + CHR(231) + CHR(227) + "o !!", "")
886:                     ENDIF
887:                 ENDIF
888:             ENDIF
889: 
890:             *-- "Select XCorNf / Go Top / ThisForm.Refresh"
891:             THIS.AtualizarGrade()
892:         CATCH TO loc_oErro
893:             MsgErro(loc_oErro.Message + CHR(13) + ;
894:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
895:                     "Procedure: " + loc_oErro.Procedure, ;
896:                     "Erro em CarregarDados")
897:         ENDTRY
898: 
899:         RETURN loc_lTemCorrecao
900:     ENDPROC
901: 
902:     *--------------------------------------------------------------------------
903:     * AtualizarGrade - METODO UNICO de repintura da grade, equivalente ao
904:     * "Select XCorNf / Go Top In XCorNf / ThisForm.Grade.Refresh" do legado.
905:     *
906:     * Popular o cursor NAO repinta a grade: sem GO TOP + Refresh explicitos a
907:     * grade fica visualmente VAZIA com o cursor cheio, e o sintoma ("a tela
908:     * nao traz dados") manda o diagnostico para SQL/cursor/permissao. Por isso
909:     * mora num metodo unico, chamado em TODO caminho que popula o cursor
910:     * (CarregarDados agora; o Valid da Nota e o Ok.Click nas Fases 7-8).
911:     *--------------------------------------------------------------------------
912:     PROCEDURE AtualizarGrade()
913:         IF USED("cursor_4c_Ocorrencias")
914:             SELECT cursor_4c_Ocorrencias
915:             GO TOP IN cursor_4c_Ocorrencias
916:         ENDIF
917: 
918:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
919:             THIS.grd_4c_Dados.Refresh()
920:         ENDIF
921:     ENDPROC
922: 
923:     *--------------------------------------------------------------------------
924:     * CarregarLista - FUNIL de carga da unica lista deste form: a grade de
925:     * ocorrencias da Carta de Correcao (SIGOPCCO.Grade, ligada ao cursor local
926:     * XCorNf no legado). Nao ha Page1=Lista/Page2=Dados aqui - a "lista" desta
927:     * tela e essa grade, e e ela que o PROCEDURE Init legado popula.
928:     *
929:     * Sequencia do funil: FormParaBO (tela -> BO, resolvendo a nota corrente)

*-- Linhas 965 a 983:
965:     *
966:     * mais a LINHA CORRENTE da grade, que e a ficha editavel desta tela: o
967:     * Ok.Click legado le XCorNf.Cods/XCorNf.Retifs para montar cada
968:     * "Insert Into crSigNfCor (... nOccors, mRetifs ...)".
969:     *
970:     * A nota tem DUAS fontes conforme o momento: o campo da tela quando ele
971:     * ja existe (fonte unica a partir dai - inclusive quando o Valid o zera
972:     * por "Nota sem Correcao", caso em que o branco e o estado REAL e tem de
973:     * chegar ao BO para o Ok.Click recusar com "Nota Fiscal Invalida !!") e o
974:     * parametro recebido do form chamador na 1a passagem, chamada pelo
975:     * InicializarForm antes de ConfigurarCampoNota criar o TextBox.
976:     *
977:     * PROTECTED obrigatoriamente: FormBase declara este hook PROTECTED e
978:     * VFP9 nao permite ALARGAR o escopo de metodo herdado.
979:     *
980:     * Retorno: .F. quando o BO nao esta instanciado (nada a transferir).
981:     *--------------------------------------------------------------------------
982:     PROTECTED PROCEDURE FormParaBO()
983:         LOCAL loc_lSucesso, loc_oErro

*-- Linhas 1090 a 1128:
1090:     *
1091:     *   This.Value = ''
1092:     *   This.Refresh
1093:     *   Select XCorNf
1094:     *   Zap
1095:     *   ThisForm.Grade.Refresh
1096:     *
1097:     * O Zap e o Refresh sao idempotentes: CarregarDados ja esvaziou e
1098:     * repintou a grade antes de cair no ramo sem registro, e repetir aqui
1099:     * mantem o metodo correto tambem se ele for chamado de outro caminho.
1100:     * Zap (nao USE IN + CREATE CURSOR) de proposito - derrubar o alias
1101:     * quebraria RecordSource/ControlSource/CurrentControl da grade.
1102:     *
1103:     * PROTECTED obrigatoriamente: FormBase declara este hook PROTECTED e
1104:     * VFP9 nao permite ALARGAR o escopo de metodo herdado.
1105:     *--------------------------------------------------------------------------
1106:     PROTECTED PROCEDURE LimparCampos()
1107:         IF PEMSTATUS(THIS, "txt_4c_NotaIni", 5)
1108:             THIS.txt_4c_NotaIni.Value = ""
1109:             THIS.txt_4c_NotaIni.Refresh()
1110:         ENDIF
1111: 
1112:         IF USED("cursor_4c_Ocorrencias")
1113:             SELECT cursor_4c_Ocorrencias
1114:             ZAP
1115:         ENDIF
1116: 
1117:         THIS.AtualizarGrade()
1118:     ENDPROC
1119: 
1120:     *--------------------------------------------------------------------------
1121:     * Destroy - equivalente ao "PROCEDURE Release" implicito do legado.
1122:     * Fecha o cursor local de ocorrencias (cursor_4c_Ocorrencias, criado em
1123:     * CriarCursorOcorrencias/ConfigurarGrade) para nao vazar work area entre
1124:     * aberturas sucessivas do dialogo.
1125:     * DODEFAULT() e a ULTIMA linha, obrigatoriamente: FormBase.Destroy faz o
1126:     * SET SYSMENU TO DEFAULT + RELEASE POPUP + CriarMenuPrincipal() que repoe
1127:     * os pads do menu principal depois de uma tela modal fechar.
1128:     *--------------------------------------------------------------------------


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

