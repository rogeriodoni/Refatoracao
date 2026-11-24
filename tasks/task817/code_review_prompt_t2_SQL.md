# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (8)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INFOS, TIPOS, I, TIPOCADS, RCL, CONTADS, FPAGS, DOPES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODCADS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INFOS, TIPOS, I, TIPOCADS, RCL, CONTADS, FPAGS, DOPES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INFOS, TIPOS, I, TIPOCADS, RCL, CONTADS, FPAGS, DOPES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INFOS, TIPOS, I, TIPOCADS, RCL, CONTADS, FPAGS, DOPES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INFOS, TIPOS, I, TIPOCADS, RCL, CONTADS, FPAGS, DOPES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ADQUIRENTE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INFOS, TIPOS, I, TIPOCADS, RCL, CONTADS, FPAGS, DOPES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DATAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INFOS, TIPOS, I, TIPOCADS, RCL, CONTADS, FPAGS, DOPES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VENCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INFOS, TIPOS, I, TIPOCADS, RCL, CONTADS, FPAGS, DOPES

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
Insert Into crExcel (TIPO_REGISTRO, ADQUIRENTE, LOJA_FILIAL, BANDEIRA, TIPO_TRANSACAO, NRO_PARCELA, QTD_PARCELAS, ;
Select csOperacoes
		Insert Into crExcel From Memvar
		Insert Into crSigPcOoL (Tipos, Emps, Dopes, Numes, Datas, Usuars, Produtos, ;
Select crExcel
If llOks And Not ThisForm.poDataMgr.Update([crSigPcOoL])
	=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigPcOoL)])
lcQuery = [Select 'A02' as TIPO_REGISTRO, p.Adquirente as ADQUIRENTE, p.Emps as LOJA_FILIAL, f.Bandeira as BANDEIRA1, ] + ;
			[From SigOpFP f, SigCdCli d, SigMvPar p, SigCdOpe o ] + ;
		   		 [In (Select Distinct b.EmpDopNums ] + ;
	 	  		  	   [From SigPcOoL b ] + ;
Select crDados
Select crDados
	Insert Into csOperacoes From Memvar
Select csOperacoes
			.DeleteMark   	   = .f.
			.Column1.ControlSource = [csOperacoes.SelImp]
			.Column2.ControlSource  = [csOperacoes.DATA_VENDA]
			.Column3.ControlSource  = [csOperacoes.ADQUIRENTE]
			.Column4.ControlSource  = [csOperacoes.BANDEIRA]
			.Column5.ControlSource  = [csOperacoes.TIPO_TRANSACAO]
			.Column6.ControlSource  = [csOperacoes.DATA_VENCIMENTO]
			.Column7.ControlSource  = [Padl(csOperacoes.NRO_PARCELA, 2, '0') + ' / ' + Padl(csOperacoes.QTD_PARCELAS, 2, '0')]
			.Column8.ControlSource  = [csOperacoes.NSU]
			.Column9.ControlSource  = [csOperacoes.AUTORIZACAO]
			.Column10.ControlSource = [csOperacoes.VALOR]
			.Column11.ControlSource = [csOperacoes.Emps]
			.Column12.ControlSource = [csOperacoes.Dopes]
			.Column13.ControlSource = [csOperacoes.Numes]
		lcQuery = [Select codcads as Adquirente, descads As Descr From SigCdCad Where TipoCads = 'ADQUIRENTE']
		Select crAdquirs
		Select csOperacoes
		Select csOperacoes
	Select SelImp, Count(1) as Selecionados ;
	  From csOperacoes ;
Select csOperacoes
	Select csOperacoes
	Select crAdquirs
	If Not Seek(This.Value)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpVda.prg) - TRECHOS RELEVANTES PARA PASS SQL (2475 linhas total):

*-- Linhas 27 a 60:
27: *                            (AddObject + CurrentControl + Sparse=.F.,
28: *                            regra #18) + as colunas 2..13 ReadOnly, como
29: *                            no "For I=2 To .ColumnCount" do legado.
30: *   VincularGrade() ........ RecordSource + os 13 ControlSource (incluindo a
31: *                            EXPRESSAO calculada da Column7), GUARDADOS por
32: *                            USED() e seguidos de AplicarFormatoGrade.
33: *   CarregarDados() ........ PUBLIC. FUNIL: cursor + vinculo + Go Top +
34: *                            THIS.Refresh + Grade.Refresh, o par que o
35: *                            legado repete nos SEIS caminhos que mexem em
36: *                            csOperacoes (regra #21).
37: *   ConfigurarBotoes() ..... os 3 blocos de botoes do dump -
38: *                            cmg_4c_CmdBtnGrade (Marca Tudo/Desmarca/
39: *                            Documentos da linha corrente), cmg_4c_CmdBtnForm
40: *                            (Limpar Selecao/Gera Arquivo/Encerrar) e
41: *                            cmd_4c_CmdSelecionar (dispara a consulta).
42: *
43: * cursor_4c_Operacoes (CriarCursorOperacoes) tem a MESMA estrutura/ordem do
44: * "Create Cursor csOperacoes" do legado (Load) - fases futuras vao ZAP +
45: * APPEND FROM DBF neste MESMO cursor, nunca recria-lo por SQLEXEC (SQLEXEC
46: * sobre alias de grid ZERA o ColumnCount).
47: *
48: * NENHUM BINDEVENT nesta fase (Click dos botoes, MouseDown/MouseUp/KeyPress
49: * do Check1) - fica para a Fase 7, mesmo padrao dos irmaos desta familia
50: * (FormSigoptrp.prg/FormSigOpTrf.prg/FormSigOpTop.prg).
51: *
52: * FASE 5/8 - FILTROS, PARTE 1 (metade superior - linha "Movimentacoes :" +
53: *   linha "Periodo de Venda :"):
54: *   ConfigurarFiltrosParte1() .. lbl_4c_Label1/obj_4c_OptProcessados (1-Nao
55: *                                Processadas/2-Ja Processadas) + lbl_4c_Say1/
56: *                                txt_4c_DtIni/lbl_4c_Say2("ate")/txt_4c_DtFin/
57: *                                lbl_4c_Say33/txt_4c_Adquirs. So a casca
58: *                                visual - sem BINDEVENT (fica para a Fase 7).
59: *
60: * FASE 6/8 - FILTROS, PARTE 2 (segunda metade - linha "Empresa :" + linha

*-- Linhas 71 a 127:
71: *   fwBuscaInt) -> AdquirsKeyPress/ValidarAdquirs/AbrirLookupAdquirente,
72: *   via FormBuscaAuxiliar direto em SigCdCad (par_cFiltro = "TipoCads =
73: *   'ADQUIRENTE'" - regra #36/#54), em vez de pre-carregar o cursor local
74: *   crAdquirs do Init legado (Select codcads as Adquirente, descads As
75: *   Descr From SigCdCad Where TipoCads = 'ADQUIRENTE') - mesmo resultado,
76: *   sem precisar manter cursor global.
77: *
78: *   Lookup Empresa (getEmpOs.Valid/getDEmpOs.Valid = fAcessoEmpresa, funcao
79: *   NAO portada - memoria "fAcessoEmpresa NAO EXISTE") -> EmpOsKeyPress/
80: *   ValidarEmpOs/AbrirLookupEmpOs (modo C, por codigo) e DEmpOsKeyPress/
81: *   ValidarDEmpOs/AbrirLookupDEmpOs (modo D, por razao social), ambos via
82: *   FormBuscaAuxiliar em SigCdEmp (Cemps/Razas). AtualizarEstadoDEmpOs()
83: *   simula o getDEmpOs.When legado ("Return Empty(ThisForm.getEmpOs.Value)")
84: *   alternando txt_4c_DEmpOs.ReadOnly - padrao canonico identico a
85: *   Formsigrevto.prg (AtualizarEstadoDesEmpresa/ValidarEmpresa/
86: *   ValidarDesEmpresa).
87: *
88: *   BtnNomArqsClick (btnNomArqs.Valid do legado = Putfile(...)) abre o
89: *   dialogo nativo de salvar arquivo e preenche obj_4c_GetArqNoms.
90: *
91: * FASE 7/8 - EVENTOS PRINCIPAIS (acoes dos botoes de selecao/processamento):
92: *   Este form OPERACIONAL nao tem CRUD (Incluir/Alterar/Visualizar/Excluir)
93: *   - a superficie real e cmd_4c_CmdSelecionar/cmg_4c_CmdBtnGrade/
94: *   cmg_4c_CmdBtnForm/Check1 da grade, todos ja criados nas fases 3/4.
95: *
96: *   Selecionar() ........... cmdSelecionar.Valid do legado: valida Data
97: *                             Inicial/Final/pasta do arquivo, monta e
98: *                             executa o JOIN SigOpFp+SigCdCli+SigMvPar+
99: *                             SigCdOpe, e povoa cursor_4c_Operacoes linha a
100: *                             linha com os campos derivados (BANDEIRA,
101: *                             ORIGEM, parcelas/valor/datas formatados,
102: *                             Erros/SelImp).
103: *   LimpaSelecao() ......... PROCEDURE limpaselecao do legado: ZAP no
104: *                             cursor e devolve filtros/botoes ao estado
105: *                             inicial (via HabilitarFiltros/
106: *                             HabilitarAcoesProcessamento).
107: *   Processamento() ........ PROCEDURE processamento do legado: grava o
108: *                             header 'A01' + uma linha 'A02' por operacao
109: *                             SelImp no cursor de exportacao, COPY TO
110: *                             DELIMITED, e insere o controle em SigPcOoL -
111: *                             um INSERT por linha, tudo num UNICO SQLEXEC
112: *                             (BEGIN/COMMIT via SQLEXEC separado NAO
113: *                             protege).
114: *   Check1KeyPress/MouseDown/MouseUp/Click .. toggle de SelImp na celula
115: *                             da grade, transcrito LITERAL do legado (o
116: *                             toggle mora no MouseDown, nao no MouseUp).
117: *   AbrirDocumentoOperacao() . cmdBtnGrade "Documentos": Do Form SigMvExp
118: *                             do legado -> CREATEOBJECT("FormSigMvExp", ...)
119: *                             com os mesmos 5 parametros (Dopes/'C'/Numes/
120: *                             Emps/.T.).
121: *
122: * FASE 8/8 - CONSOLIDACAO (filtros com FONTE UNICA no BO):
123: *   BOParaForm() ........... PROTECTED. Espelha os filtros guardados no BO
124: *                             nos controles da tela. E o bloco de defaults
125: *                             do FIM do Init legado, que ali nao tem nome:
126: *                             "getDtIni.Value = Date() / getDtFin.Value =
127: *                             Date() / getArqNoms.Value = [C:\CONCILIADOR.

*-- Linhas 237 a 255:
237: 
238:             *-- FUNIL de carga (nunca a posicionadora nua): liga a grade ao
239:             *-- cursor e repinta. O legado faz isso no Init (RecordSource +
240:             *-- os 13 ControlSource) e repete o par Go Top + Refresh em TODO
241:             *-- caminho que mexe em csOperacoes - regra #21.
242:             THIS.CarregarDados()
243: 
244:             loc_lSucesso = .T.
245: 
246:         CATCH TO loc_oErro
247:             THIS.this_cMensagemErro = loc_oErro.Message
248:             MsgErro(loc_oErro.Message + CHR(13) + ;
249:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
250:                 "Procedure: " + loc_oErro.Procedure, ;
251:                 "Erro InicializarForm")
252:         ENDTRY
253: 
254:         RETURN loc_lSucesso
255:     ENDPROC

*-- Linhas 327 a 379:
327:     *==========================================================================
328:     * CriarCursorOperacoes - placeholder de cursor_4c_Operacoes (csOperacoes
329:     * no legado), com a MESMA estrutura/ordem de campos do PROCEDURE Load do
330:     * SCX original. Tem que existir ANTES do RecordSource/ControlSource do
331:     * grid ser atribuido (regra #41) - por isso e chamado no INICIO de
332:     * ConfigurarGrade, nao depois.
333:     *
334:     * So cria se ainda nao existe - idempotente, porque fases futuras (ZAP +
335:     * APPEND FROM DBF no cursor do grid, regra do Problema "SQLEXEC sobre
336:     * alias de grid zera ColumnCount") vao reusar este MESMO cursor, nunca
337:     * recria-lo.
338:     *==========================================================================
339:     PROTECTED PROCEDURE CriarCursorOperacoes()
340:         IF USED("cursor_4c_Operacoes")
341:             RETURN
342:         ENDIF
343: 
344:         SET NULL ON
345:         CREATE CURSOR cursor_4c_Operacoes (SelImp L(1), TIPO_REGISTRO C(3), ;
346:             ADQUIRENTE C(60), LOJA_FILIAL C(15), BANDEIRA C(60), ;
347:             TIPO_TRANSACAO C(15), NRO_PARCELA C(2), QTD_PARCELAS C(2), ;
348:             TID C(40), NSU C(30), AUTORIZACAO C(20), VALOR C(14), ;
349:             CLIENTE C(50), DATA_VENDA C(10), ORIGEM C(10), SEQUENCIA C(20), ;
350:             NOTA_FISCAL C(20), CPF_CNPJ C(20), ESTABELECIMENTO C(20), ;
351:             DATA_VENCIMENTO C(10), NUMERO_CARTAO C(30), REFERENCIA1 C(60), ;
352:             Emps C(3), Dopes C(20), Numes N(6), EmpDopNums C(29), Erros L(1))
353:         SET NULL OFF
354:     ENDPROC
355: 
356:     *==========================================================================
357:     * ConfigurarGrade - cntGrade/GrdOperacoes do legado -> cnt_4c_Grade/
358:     * grd_4c_Dados (grade de 13 colunas que lista as operacoes selecionadas
359:     * para gerar o arquivo de vendas).
360:     *
361:     * Transcricao do dump (SIGOPVDA.cntGrade/GrdOperacoes):
362:     *   cntGrade      Top=198 Left=13 Width=1229 Height=387 BorderWidth=0
363:     *   GrdOperacoes  Top=2 Left=1 Width=1225 Height=467 RowHeight=16
364:     *                 HeaderHeight=16 ScrollBars=2 DeleteMark=.F. RecordMark=.F.
365:     *                 AllowHeaderSizing=.F. AllowRowSizing=.F.
366:     *                 GridLineColor=238,238,238 Tahoma 8
367:     *
368:     * ColumnCount/RecordSource ficam FORA do WITH que acessa .ColumnN -
369:     * dentro do mesmo WITH, acessar .Column1 logo depois de atribuir
370:     * RecordSource estoura "Unknown member COLUMN1" (regra GRID-WITH).
371:     *
372:     * Geometria/headers das colunas moram em AplicarFormatoGrade (chamada ao
373:     * final), que e a FONTE UNICA (regra do Problema 48: RecordSource zera
374:     * Column.Width e Header1.Caption, e este metodo e chamado de novo quando
375:     * a grade for religada a dado real nas fases seguintes).
376:     *==========================================================================
377:     PROTECTED PROCEDURE ConfigurarGrade()
378:         THIS.CriarCursorOperacoes()
379: 

*-- Linhas 401 a 457:
401:             .FontSize          = 8
402:             .AllowHeaderSizing = .F.
403:             .AllowRowSizing    = .F.
404:             .DeleteMark        = .F.
405:             .RecordMark        = .F.
406:             .HeaderHeight      = 19
407:             .RowHeight         = 16
408:             .ScrollBars        = 2
409:             .TabIndex          = 16
410:             .GridLineColor     = RGB(238, 238, 238)
411:             .Visible           = .T.
412: 
413:             *-- Grid.ReadOnly ANTES de qualquer Column.ReadOnly (regra #18:
414:             *-- o do grid propaga para as colunas e sobrescreve). O legado
415:             *-- declara .ReadOnly = .f. no Init (so a Column1 e editavel - as
416:             *-- demais sao travadas uma a uma em AplicarFormatoGrade).
417:             .ReadOnly          = .F.
418:         ENDWITH
419: 
420:         *-- ColumnCount FORA do WITH acima (regra GRID-WITH). RecordSource/
421:         *-- ControlSource NAO ficam aqui: moram em VincularGrade (ver nota la).
422:         THIS.cnt_4c_Grade.grd_4c_Dados.ColumnCount = 13
423: 
424:         *-- VincularGrade (e NAO AplicarFormatoGrade direto): atribuir
425:         *-- ColumnCount sem RecordSource faz o Grid AUTO-BINDAR na area de
426:         *-- trabalho CORRENTE, e a Column1 pode cair numa coluna de tipo
427:         *-- incompativel - dai o AddObject do CheckBox estoura "Data type
428:         *-- mismatch" no proprio AddObject, dentro do TRY do InicializarForm,
429:         *-- e a tela nao abre. Vinculando ANTES, a Column1 ja esta no campo
430:         *-- LOGICO SelImp quando o Check1 e criado.
431:         THIS.VincularGrade()
432:     ENDPROC
433: 
434:     *==========================================================================
435:     * VincularGrade - liga grd_4c_Dados ao alias cursor_4c_Operacoes
436:     * (RecordSource + os 13 ControlSource, transcritos um a um do Init legado,
437:     * inclusive a EXPRESSAO calculada da Column7).
438:     *
439:     * Separado de ConfigurarGrade de proposito: ConfigurarGrade carrega so o
440:     * que NAO depende de dado (geometria, ColumnCount, fontes, cores), e o
441:     * bind vive aqui porque e refeito a cada recarga. Guardado por USED() -
442:     * atribuir RecordSource/ControlSource de alias que ainda nao existe
443:     * estoura "Alias is not found" DENTRO do TRY do InicializarForm, o que
444:     * faz CREATEOBJECT devolver .F. e a tela nao abrir (regra #41).
445:     *
446:     * AplicarFormatoGrade e chamada DEPOIS do bind, SEMPRE (inclusive quando
447:     * o alias nao esta aberto): atribuir RecordSource zera Column.Width e
448:     * Header1.Caption (regra #41 / Problema 48), e sem a reaplicacao a grade
449:     * ficaria com cabecalho "Column1" e largura default.
450:     *==========================================================================
451:     PROCEDURE VincularGrade()
452:         LOCAL loc_lVinculou
453:         loc_lVinculou = .F.
454: 
455:         IF !PEMSTATUS(THIS, "cnt_4c_Grade", 5)
456:             RETURN loc_lVinculou
457:         ENDIF

*-- Linhas 465 a 514:
465:             THIS.cnt_4c_Grade.grd_4c_Dados.RecordSource = "cursor_4c_Operacoes"
466: 
467:             WITH THIS.cnt_4c_Grade.grd_4c_Dados
468:                 .Column1.ControlSource  = "cursor_4c_Operacoes.SelImp"
469:                 .Column2.ControlSource  = "cursor_4c_Operacoes.DATA_VENDA"
470:                 .Column3.ControlSource  = "cursor_4c_Operacoes.ADQUIRENTE"
471:                 .Column4.ControlSource  = "cursor_4c_Operacoes.BANDEIRA"
472:                 .Column5.ControlSource  = "cursor_4c_Operacoes.TIPO_TRANSACAO"
473:                 .Column6.ControlSource  = "cursor_4c_Operacoes.DATA_VENCIMENTO"
474:                 .Column7.ControlSource  = "PADL(cursor_4c_Operacoes.NRO_PARCELA, 2, '0') + ' / ' + " + ;
475:                                            "PADL(cursor_4c_Operacoes.QTD_PARCELAS, 2, '0')"
476:                 .Column8.ControlSource  = "cursor_4c_Operacoes.NSU"
477:                 .Column9.ControlSource  = "cursor_4c_Operacoes.AUTORIZACAO"
478:                 .Column10.ControlSource = "cursor_4c_Operacoes.VALOR"
479:                 .Column11.ControlSource = "cursor_4c_Operacoes.Emps"
480:                 .Column12.ControlSource = "cursor_4c_Operacoes.Dopes"
481:                 .Column13.ControlSource = "cursor_4c_Operacoes.Numes"
482:             ENDWITH
483: 
484:             loc_lVinculou = .T.
485:         ENDIF
486: 
487:         *-- SEMPRE, vinculado ou nao (RecordSource zera Width/Caption)
488:         THIS.AplicarFormatoGrade()
489: 
490:         RETURN loc_lVinculou
491:     ENDPROC
492: 
493:     *==========================================================================
494:     * CarregarDados - FUNIL de carga/repintura da grade de operacoes.
495:     *
496:     * Existe porque popular o cursor NAO repinta a grade ligada a ele (regra
497:     * #21): o legado fecha TODO caminho que mexe em csOperacoes com o mesmo
498:     * par, e sao SEIS caminhos -
499:     *   Selecionar ............ Select csOperacoes / Go Top /
500:     *                           GrdOperacoes.Column1.SetFocus /
501:     *                           Column1.Refresh / GrdOperacoes.Refresh
502:     *   LimpaSelecao .......... Zap In csOperacoes + Refresh
503:     *   cmdBtnGrade "Marca Tudo" .. Replace All SelImp With .t. For Not Erros /
504:     *                           Go Top / GrdOperacoes.Refresh
505:     *   cmdBtnGrade "Desmarcar" ... Replace All SelImp With .f. / Go Top /
506:     *                           GrdOperacoes.Refresh
507:     *   Check1.MouseUp ........ Gather Memvar / GrdOperacoes.Refresh
508:     *   Check1.KeyPress ....... Gather Memvar / GrdOperacoes.Refresh
509:     * Sem um funil unico, cada um desses pontos (fases 7 e 8) teria de
510:     * lembrar do par - e o que falta nunca da erro: a grade so fica
511:     * mostrando o conteudo de antes, e o sintoma reportado vira "a tela nao
512:     * traz dados".
513:     *
514:     * PUBLIC de proposito (regra #3): o harness de teste (TesteAutomatico.prg)

*-- Linhas 532 a 550:
532:             THIS.CriarCursorOperacoes()
533: 
534:             IF THIS.VincularGrade()
535:                 SELECT cursor_4c_Operacoes
536:                 GO TOP IN cursor_4c_Operacoes
537: 
538:                 THIS.Refresh()
539:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
540: 
541:                 loc_lSucesso = .T.
542:             ENDIF
543: 
544:         CATCH TO loc_oErro
545:             THIS.this_cMensagemErro = loc_oErro.Message
546:             MsgErro(loc_oErro.Message + CHR(13) + ;
547:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
548:                 "Procedure: " + loc_oErro.Procedure, ;
549:                 "Erro CarregarDados")
550:         ENDTRY

*-- Linhas 1458 a 1500:
1458:     *==========================================================================
1459:     * ValidarAdquirs - getAdquirs.Valid do legado:
1460:     *   If Not Empty(This.Value)
1461:     *       Select crAdquirs / Set Order To Adquirente
1462:     *       If Not Seek(This.Value)
1463:     *           <abre fwBuscaInt>
1464:     *       EndIf
1465:     *       This.Value = crAdquirs.Adquirente
1466:     *   EndIf
1467:     *
1468:     * crAdquirs era pre-carregado no Init legado com "Select codcads as
1469:     * Adquirente, descads As Descr From SigCdCad Where TipoCads =
1470:     * 'ADQUIRENTE'". Aqui o SEEK equivalente vai direto ao SQL Server (sem
1471:     * manter cursor global), e so abre o picker quando o codigo digitado
1472:     * NAO existe - regra #50 (universo vazio nao e erro, nunca apagar o
1473:     * digitado nem avisar antes do picker).
1474:     *==========================================================================
1475:     PROCEDURE ValidarAdquirs()
1476:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
1477:         loc_cValor = ALLTRIM(THIS.txt_4c_Adquirs.Value)
1478: 
1479:         IF EMPTY(loc_cValor)
1480:             RETURN
1481:         ENDIF
1482: 
1483:         loc_cSQL = "SELECT codcads FROM SigCdCad WHERE TipoCads = " + ;
1484:                    EscaparSQL("ADQUIRENTE") + " AND codcads = " + EscaparSQL(loc_cValor)
1485:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AdqVal")
1486: 
1487:         IF loc_nResultado <= 0 OR !USED("cursor_4c_AdqVal") OR EOF("cursor_4c_AdqVal")
1488:             IF USED("cursor_4c_AdqVal")
1489:                 USE IN cursor_4c_AdqVal
1490:             ENDIF
1491:             THIS.AbrirLookupAdquirente()
1492:         ELSE
1493:             USE IN cursor_4c_AdqVal
1494:         ENDIF
1495:     ENDPROC
1496: 
1497:     *==========================================================================
1498:     * AbrirLookupAdquirente - picker de Adquirente (SigCdCad filtrado por
1499:     * TipoCads = 'ADQUIRENTE'), substituicao canonica do fwBuscaInt em
1500:     * crAdquirs do legado - regra #36 (1o argumento e o HANDLE da conexao).

*-- Linhas 1509 a 1536:
1509:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1510:             "SigCdCad", "cursor_4c_BuscaAdq", "codcads", loc_cValor, ;
1511:             "Sele" + CHR(231) + CHR(227) + "o de Adquirente", .F., .T., ;
1512:             "TipoCads = " + EscaparSQL("ADQUIRENTE"))
1513: 
1514:         IF VARTYPE(loc_oBusca) = "O"
1515:             IF !loc_oBusca.this_lAchouRegistro
1516:                 loc_oBusca.mAddColuna("codcads", "", "C" + CHR(243) + "digo")
1517:                 loc_oBusca.mAddColuna("descads", "", "Adquirente")
1518:                 loc_oBusca.Show()
1519:             ENDIF
1520:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAdq")
1521:                 SELECT cursor_4c_BuscaAdq
1522:                 THIS.txt_4c_Adquirs.Value = ALLTRIM(codcads)
1523:             ENDIF
1524:             loc_oBusca.Release()
1525:         ENDIF
1526: 
1527:         IF USED("cursor_4c_BuscaAdq")
1528:             USE IN cursor_4c_BuscaAdq
1529:         ENDIF
1530:     ENDPROC
1531: 
1532:     *==========================================================================
1533:     * EmpOsKeyPress / DEmpOsKeyPress - getEmpOs/getDEmpOs.KeyPress (novo).
1534:     * F4(115) abre o picker direto; Enter(13)/Tab(9) valida o valor
1535:     * digitado - mesmo padrao de AdquirsKeyPress.
1536:     *

*-- Linhas 1586 a 1605:
1586:             RETURN
1587:         ENDIF
1588: 
1589:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
1590:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
1591: 
1592:         IF loc_nResultado > 0 AND USED("cursor_4c_EmpVal") AND !EOF("cursor_4c_EmpVal")
1593:             THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
1594:         ELSE
1595:             THIS.txt_4c_DEmpOs.Value = ""
1596:         ENDIF
1597: 
1598:         IF USED("cursor_4c_EmpVal")
1599:             USE IN cursor_4c_EmpVal
1600:         ENDIF
1601: 
1602:         IF EMPTY(THIS.txt_4c_DEmpOs.Value)
1603:             THIS.AbrirLookupEmpOs()
1604:         ENDIF
1605: 

*-- Linhas 1660 a 1680:
1660:             RETURN
1661:         ENDIF
1662: 
1663:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + ;
1664:                    EscaparSQL(loc_cValor + "%")
1665:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDescVal")
1666: 
1667:         IF loc_nResultado > 0 AND USED("cursor_4c_EmpDescVal") AND !EOF("cursor_4c_EmpDescVal")
1668:             THIS.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_EmpDescVal.Cemps)
1669:             THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpDescVal.Razas)
1670:             IF USED("cursor_4c_EmpDescVal")
1671:                 USE IN cursor_4c_EmpDescVal
1672:             ENDIF
1673:         ELSE
1674:             IF USED("cursor_4c_EmpDescVal")
1675:                 USE IN cursor_4c_EmpDescVal
1676:             ENDIF
1677:             THIS.AbrirLookupDEmpOs()
1678:         ENDIF
1679:     ENDPROC
1680: 

*-- Linhas 1780 a 1798:
1780: 
1781:     *==========================================================================
1782:     * Selecionar - PROCEDURE selecionar do legado: valida Data Inicial/
1783:     * Final/pasta do arquivo de exportacao, monta e executa o JOIN
1784:     * SigOpFp+SigCdCli+SigMvPar+SigCdOpe (filtrado por empresa/adquirente/
1785:     * periodo/situacao de processamento ja gravada em SigPcOoL), e povoa
1786:     * cursor_4c_Operacoes linha a linha com os campos derivados.
1787:     *
1788:     * RETURN so FORA do TRY (regra #1) - loc_lValido encadeia os 4 guards
1789:     * de validacao do legado (cada MessageBox + SetFocus + Return .f.).
1790:     *
1791:     * PUBLIC (regra #3): alvo de BINDEVENT (CmdSelecionarClick) e mesmo
1792:     * nome do PROCEDURE legado (harness pode chamar direto).
1793:     *==========================================================================
1794:     PROCEDURE Selecionar()
1795:         LOCAL loc_cEmp, loc_lNaoProcessados, loc_dDtIni, loc_dDtFin, ;
1796:               loc_cArquivo, loc_cAdquirente, loc_dDtFinHora, loc_cSQL, ;
1797:               loc_nResultado, loc_lValido, loc_lErros, loc_cBandeira, ;
1798:               loc_cOrigem, loc_lSucesso, loc_oErro

*-- Linhas 1855 a 1954:
1855:             IF loc_lValido
1856:                 loc_dDtFinHora = DATETIME(YEAR(loc_dDtFin), MONTH(loc_dDtFin), DAY(loc_dDtFin), 23, 59, 59)
1857: 
1858:                 loc_cSQL = "SELECT 'A02' AS TIPO_REGISTRO, p.Adquirente AS ADQUIRENTE," + ;
1859:                     " p.Emps AS LOJA_FILIAL, f.Bandeira AS BANDEIRA1, d.RClis AS BANDEIRA2," + ;
1860:                     " f.Opers AS TIPO_TRANSACAO, p.Parcs AS NRO_PARCELA, p.TParcs AS QTD_PARCELAS," + ;
1861:                     " SPACE(40) AS TID, p.NSU AS NSU, p.Autoriza AS AUTORIZACAO, p.Valos AS VALOR," + ;
1862:                     " SPACE(50) AS CLIENTE, p.Datas AS DATA_VENDA, f.CCupomNvs AS ORIGEM," + ;
1863:                     " '' AS SEQUENCIA, '' AS NOTA_FISCAL, '' AS CPF_CNPJ, f.CodEstabs AS ESTABELECIMENTO," + ;
1864:                     " p.Vencs AS DATA_VENCIMENTO, '' AS NUMERO_CARTAO," + ;
1865:                     " p.EmpDopNums + p.FPags + STR(p.Nopers, 10) AS REFERENCIA1," + ;
1866:                     " p.Emps, p.Dopes, p.Numes, p.EmpDopNums" + ;
1867:                     " FROM SigOpFP f, SigCdCli d, SigMvPar p, SigCdOpe o" + ;
1868:                     " WHERE f.Infos = 'T'" + ;
1869:                     "   AND f.ContaDs = d.IClis" + ;
1870:                     "   AND p.FPags = f.FPags" + ;
1871:                     IIF(EMPTY(loc_cEmp), "", "   AND p.Emps = " + EscaparSQL(loc_cEmp)) + ;
1872:                     IIF(EMPTY(loc_cAdquirente), "", "   AND p.Adquirente = " + EscaparSQL(loc_cAdquirente)) + ;
1873:                     "   AND p.Datas BETWEEN " + FormatarDataSQL(loc_dDtIni) + " AND " + FormatarDataSQL(loc_dDtFinHora) + ;
1874:                     "   AND p.Dopes = o.Dopes" + ;
1875:                     "   AND NOT o.Vendas = 2" + ;
1876:                     "   AND p.Vencs IS NOT NULL" + ;
1877:                     "   AND p.EmpDopNums " + IIF(loc_lNaoProcessados, "NOT ", "") + ;
1878:                     "   IN (SELECT DISTINCT b.EmpDopNums FROM SigPcOoL b WHERE b.Tipos = " + EscaparSQL("SIGOPVDA") + ")" + ;
1879:                     " ORDER BY p.Datas, p.EmpDopNums, p.FPags, p.Parcs"
1880: 
1881:                 IF USED("cursor_4c_Selecao")
1882:                     USE IN cursor_4c_Selecao
1883:                 ENDIF
1884: 
1885:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Selecao")
1886: 
1887:                 IF loc_nResultado < 0 OR !USED("cursor_4c_Selecao")
1888:                     MsgErro("Erro ao consultar as opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1889:                         CapturarErroSQL(), "Erro SQL")
1890:                 ELSE
1891:                     SELECT cursor_4c_Selecao
1892:                     GO TOP
1893: 
1894:                     IF EOF("cursor_4c_Selecao")
1895:                         USE IN cursor_4c_Selecao
1896:                         MsgInfo("N" + CHR(227) + "o Existem Registros Informados Com as Condi" + ;
1897:                             CHR(231) + CHR(245) + "es Selecionadas!!!", "Nenhum Registro Encontrado")
1898:                         THIS.LimpaSelecao()
1899:                     ELSE
1900:                         SELECT cursor_4c_Selecao
1901:                         SCAN
1902:                             loc_lErros = EMPTY(ALLTRIM(cursor_4c_Selecao.BANDEIRA1 + cursor_4c_Selecao.BANDEIRA2)) ;
1903:                                 OR EMPTY(cursor_4c_Selecao.NRO_PARCELA) ;
1904:                                 OR EMPTY(cursor_4c_Selecao.QTD_PARCELAS) ;
1905:                                 OR EMPTY(cursor_4c_Selecao.NSU) ;
1906:                                 OR EMPTY(cursor_4c_Selecao.AUTORIZACAO) ;
1907:                                 OR EMPTY(cursor_4c_Selecao.VALOR) ;
1908:                                 OR EMPTY(cursor_4c_Selecao.DATA_VENDA) ;
1909:                                 OR EMPTY(cursor_4c_Selecao.DATA_VENCIMENTO) ;
1910:                                 OR EMPTY(cursor_4c_Selecao.ADQUIRENTE)
1911: 
1912:                             loc_cBandeira = IIF(EMPTY(ALLTRIM(cursor_4c_Selecao.BANDEIRA1)), ;
1913:                                 ALLTRIM(cursor_4c_Selecao.BANDEIRA2), ALLTRIM(cursor_4c_Selecao.BANDEIRA1))
1914:                             loc_cOrigem = IIF(EMPTY(ALLTRIM(cursor_4c_Selecao.ORIGEM)), "POS", ;
1915:                                 ALLTRIM(cursor_4c_Selecao.ORIGEM))
1916: 
1917:                             INSERT INTO cursor_4c_Operacoes (SelImp, TIPO_REGISTRO, ADQUIRENTE, ;
1918:                                 LOJA_FILIAL, BANDEIRA, TIPO_TRANSACAO, NRO_PARCELA, QTD_PARCELAS, ;
1919:                                 TID, NSU, AUTORIZACAO, VALOR, CLIENTE, DATA_VENDA, ORIGEM, ;
1920:                                 SEQUENCIA, NOTA_FISCAL, CPF_CNPJ, ESTABELECIMENTO, DATA_VENCIMENTO, ;
1921:                                 NUMERO_CARTAO, REFERENCIA1, Emps, Dopes, Numes, EmpDopNums, Erros) ;
1922:                                 VALUES (!loc_lErros, cursor_4c_Selecao.TIPO_REGISTRO, ;
1923:                                 cursor_4c_Selecao.ADQUIRENTE, cursor_4c_Selecao.LOJA_FILIAL, ;
1924:                                 loc_cBandeira, cursor_4c_Selecao.TIPO_TRANSACAO, ;
1925:                                 ALLTRIM(STR(cursor_4c_Selecao.NRO_PARCELA, 3)), ;
1926:                                 ALLTRIM(STR(cursor_4c_Selecao.QTD_PARCELAS, 3)), ;
1927:                                 cursor_4c_Selecao.TID, cursor_4c_Selecao.NSU, ;
1928:                                 cursor_4c_Selecao.AUTORIZACAO, ;
1929:                                 STRTRAN(ALLTRIM(STR(cursor_4c_Selecao.VALOR, 12, 2)), ".", ","), ;
1930:                                 cursor_4c_Selecao.CLIENTE, ;
1931:                                 DTOC(ConverterParaData(cursor_4c_Selecao.DATA_VENDA)), loc_cOrigem, ;
1932:                                 cursor_4c_Selecao.SEQUENCIA, cursor_4c_Selecao.NOTA_FISCAL, ;
1933:                                 cursor_4c_Selecao.CPF_CNPJ, cursor_4c_Selecao.ESTABELECIMENTO, ;
1934:                                 DTOC(ConverterParaData(cursor_4c_Selecao.DATA_VENCIMENTO)), ;
1935:                                 cursor_4c_Selecao.NUMERO_CARTAO, cursor_4c_Selecao.REFERENCIA1, ;
1936:                                 cursor_4c_Selecao.Emps, cursor_4c_Selecao.Dopes, ;
1937:                                 cursor_4c_Selecao.Numes, cursor_4c_Selecao.EmpDopNums, loc_lErros)
1938: 
1939:                             SELECT cursor_4c_Selecao
1940:                         ENDSCAN
1941: 
1942:                         USE IN cursor_4c_Selecao
1943: 
1944:                         THIS.HabilitarFiltros(.F.)
1945:                         THIS.HabilitarAcoesProcessamento(.T.)
1946: 
1947:                         THIS.CarregarDados()
1948:                         THIS.cnt_4c_Grade.grd_4c_Dados.Column1.SetFocus()
1949:                         THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Refresh()
1950: 
1951:                         loc_lSucesso = .T.
1952:                     ENDIF
1953:                 ENDIF
1954:             ENDIF

*-- Linhas 2003 a 2033:
2003:     * Processamento - PROCEDURE processamento do legado: grava o header
2004:     * 'A01' (nomes das colunas) + uma linha 'A02' por operacao SelImp no
2005:     * cursor de exportacao, COPY TO DELIMITED, e insere o controle em
2006:     * SigPcOoL (um INSERT por linha, tudo num UNICO SQLEXEC - BEGIN/COMMIT
2007:     * via SQLEXEC separado NAO protege, a conexao ja nasce com @@TRANCOUNT
2008:     * = 1 - regra "BEGIN/COMMIT via SQLEXEC nao protege").
2009:     *
2010:     * Nao apaga o arquivo se o lote SQL falhar (igual ao legado: o arquivo
2011:     * ja foi gravado em disco ANTES da tentativa de commit).
2012:     *
2013:     * PUBLIC (regra #3): chamado por CmgCmdBtnFormClick e mesmo nome do
2014:     * PROCEDURE legado.
2015:     *==========================================================================
2016:     PROCEDURE Processamento()
2017:         LOCAL loc_lNaoProcessados, loc_cArquivo, loc_nOrdem, loc_lOk, ;
2018:               loc_cInserts, loc_cSQLLote, loc_cProdutosFlag, loc_nResultado, ;
2019:               loc_lFiltrosOk, loc_oErro
2020:         loc_lOk = .F.
2021: 
2022:         TRY
2023:             *-- FONTE UNICA dos filtros, igual a Selecionar: FormParaBO()
2024:             *-- recarrega as properties do BO a partir dos controles (o
2025:             *-- legado tambem relia optProcessados/getArqNoms aqui) e
2026:             *-- Processamento le do BO, nunca mais do controle.
2027:             loc_lFiltrosOk      = THIS.FormParaBO()
2028:             loc_lNaoProcessados = .T.
2029:             loc_cArquivo        = ""
2030: 
2031:             IF loc_lFiltrosOk
2032:                 WITH THIS.this_oBusinessObject
2033:                     loc_lNaoProcessados = (.this_nProcessados = 1)

*-- Linhas 2048 a 2159:
2048:                 ENDIF
2049: 
2050:                 SET NULL ON
2051:                 CREATE CURSOR cursor_4c_Excel (TIPO_REGISTRO C(3), ADQUIRENTE C(60), ;
2052:                     LOJA_FILIAL C(15), BANDEIRA C(60), TIPO_TRANSACAO C(15), ;
2053:                     NRO_PARCELA C(2), QTD_PARCELAS C(2), TID C(40), NSU C(30), ;
2054:                     AUTORIZACAO C(20), VALOR C(14), CLIENTE C(50), DATA_VENDA C(10), ;
2055:                     ORIGEM C(10), SEQUENCIA C(20), NOTA_FISCAL C(20), CPF_CNPJ C(20), ;
2056:                     ESTABELECIMENTO C(20), DATA_VENCIMENTO C(10), NUMERO_CARTAO C(30), ;
2057:                     REFERENCIA1 C(60))
2058:                 SET NULL OFF
2059: 
2060:                 *-- Header 'A01' - o legado grava os NOMES das colunas como a
2061:                 *-- 1a linha do arquivo exportado.
2062:                 INSERT INTO cursor_4c_Excel (TIPO_REGISTRO, ADQUIRENTE, LOJA_FILIAL, ;
2063:                     BANDEIRA, TIPO_TRANSACAO, NRO_PARCELA, QTD_PARCELAS, TID, NSU, ;
2064:                     AUTORIZACAO, VALOR, CLIENTE, DATA_VENDA, ORIGEM, SEQUENCIA, ;
2065:                     NOTA_FISCAL, CPF_CNPJ, ESTABELECIMENTO, DATA_VENCIMENTO, ;
2066:                     NUMERO_CARTAO, REFERENCIA1) ;
2067:                     VALUES ("A01", "ADQUIRENTE", "LOJA_FILIAL", "BANDEIRA", ;
2068:                     "TIPO_TRANSACAO", "NRO_PARCELA", "QTD_PARCELAS", "TID", "NSU", ;
2069:                     "AUTORIZA" + CHR(199) + CHR(195) + "O", "VALOR", "CLIENTE", ;
2070:                     "DATA_VENDA", "ORIGEM", "SEQUENCIA", "NOTA_FISCAL", "CPF_CNPJ", ;
2071:                     "ESTABELECIMENTO", "DATA_VENCIMENTO", "NUMERO_CARTAO", "REFERENCIA1")
2072: 
2073:                 loc_nOrdem   = 0
2074:                 loc_cInserts = ""
2075: 
2076:                 SELECT cursor_4c_Operacoes
2077:                 SCAN FOR SelImp
2078:                     loc_nOrdem = loc_nOrdem + 1
2079: 
2080:                     INSERT INTO cursor_4c_Excel (TIPO_REGISTRO, ADQUIRENTE, LOJA_FILIAL, ;
2081:                         BANDEIRA, TIPO_TRANSACAO, NRO_PARCELA, QTD_PARCELAS, TID, NSU, ;
2082:                         AUTORIZACAO, VALOR, CLIENTE, DATA_VENDA, ORIGEM, SEQUENCIA, ;
2083:                         NOTA_FISCAL, CPF_CNPJ, ESTABELECIMENTO, DATA_VENCIMENTO, ;
2084:                         NUMERO_CARTAO, REFERENCIA1) ;
2085:                         VALUES (cursor_4c_Operacoes.TIPO_REGISTRO, cursor_4c_Operacoes.ADQUIRENTE, ;
2086:                         cursor_4c_Operacoes.LOJA_FILIAL, cursor_4c_Operacoes.BANDEIRA, ;
2087:                         cursor_4c_Operacoes.TIPO_TRANSACAO, cursor_4c_Operacoes.NRO_PARCELA, ;
2088:                         cursor_4c_Operacoes.QTD_PARCELAS, cursor_4c_Operacoes.TID, ;
2089:                         cursor_4c_Operacoes.NSU, cursor_4c_Operacoes.AUTORIZACAO, ;
2090:                         cursor_4c_Operacoes.VALOR, cursor_4c_Operacoes.CLIENTE, ;
2091:                         cursor_4c_Operacoes.DATA_VENDA, cursor_4c_Operacoes.ORIGEM, ;
2092:                         ALLTRIM(STR(loc_nOrdem, 20)), cursor_4c_Operacoes.NOTA_FISCAL, ;
2093:                         cursor_4c_Operacoes.CPF_CNPJ, cursor_4c_Operacoes.ESTABELECIMENTO, ;
2094:                         cursor_4c_Operacoes.DATA_VENCIMENTO, cursor_4c_Operacoes.NUMERO_CARTAO, ;
2095:                         cursor_4c_Operacoes.REFERENCIA1)
2096: 
2097:                     loc_cInserts = loc_cInserts + ;
2098:                         "INSERT INTO SigPcOoL (tipos, emps, dopes, numes, empds, dopeds," + ;
2099:                         " numeds, datas, usuars, produtos, cidchaves, edndests, empdopnums," + ;
2100:                         " processos, nopers) VALUES (" + ;
2101:                         EscaparSQL("SIGOPVDA") + "," + ;
2102:                         EscaparSQL(ALLTRIM(cursor_4c_Operacoes.Emps)) + "," + ;
2103:                         EscaparSQL(ALLTRIM(cursor_4c_Operacoes.Dopes)) + "," + ;
2104:                         FormatarNumeroSQL(cursor_4c_Operacoes.Numes, 0) + "," + ;
2105:                         EscaparSQL("") + "," + EscaparSQL("") + "," + FormatarNumeroSQL(0, 0) + "," + ;
2106:                         "GETDATE()," + ;
2107:                         EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
2108:                         EscaparSQL(loc_cProdutosFlag) + "," + ;
2109:                         EscaparSQL(ALLTRIM(fUniqueIds())) + "," + ;
2110:                         EscaparSQL("") + "," + ;
2111:                         EscaparSQL(ALLTRIM(cursor_4c_Operacoes.EmpDopNums)) + "," + ;
2112:                         EscaparSQL(ALLTRIM(cursor_4c_Operacoes.REFERENCIA1)) + "," + ;
2113:                         FormatarNumeroSQL(0, 0) + ");" + CHR(13)
2114: 
2115:                     SELECT cursor_4c_Operacoes
2116:                 ENDSCAN
2117: 
2118:                 SELECT cursor_4c_Excel
2119:                 COPY TO (loc_cArquivo) DELIMITED
2120: 
2121:                 IF !FILE(loc_cArquivo)
2122:                     MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + "vel Gerar o Arquivo!!! " + ;
2123:                         "Verifique Suas Permiss" + CHR(245) + "es!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
2124:                 ELSE
2125:                     loc_cSQLLote = "SET NOCOUNT ON;" + CHR(13) + ;
2126:                         "DECLARE @nivel4c int = @@TRANCOUNT;" + CHR(13) + ;
2127:                         "IF @nivel4c = 0 BEGIN TRANSACTION ELSE SAVE TRANSACTION Op4cVda;" + CHR(13) + ;
2128:                         "BEGIN TRY" + CHR(13) + ;
2129:                         loc_cInserts + ;
2130:                         "IF @nivel4c = 0 COMMIT TRANSACTION;" + CHR(13) + ;
2131:                         "END TRY" + CHR(13) + ;
2132:                         "BEGIN CATCH" + CHR(13) + ;
2133:                         "IF @nivel4c = 0" + CHR(13) + ;
2134:                         "BEGIN" + CHR(13) + ;
2135:                         "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;" + CHR(13) + ;
2136:                         "END" + CHR(13) + ;
2137:                         "ELSE" + CHR(13) + ;
2138:                         "BEGIN" + CHR(13) + ;
2139:                         "IF XACT_STATE() = 1 ROLLBACK TRANSACTION Op4cVda;" + CHR(13) + ;
2140:                         "END;" + CHR(13) + ;
2141:                         "THROW;" + CHR(13) + ;
2142:                         "END CATCH"
2143: 
2144:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQLLote)
2145: 
2146:                     IF loc_nResultado < 0
2147:                         MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
2148:                             "Falha na Conex" + CHR(227) + "o (SigPcOoL)")
2149:                     ELSE
2150:                         MsgInfo("Arquivo Gerado!!!", "OK")
2151:                         THIS.LimpaSelecao()
2152:                         THIS.Selecionar()
2153:                         loc_lOk = .T.
2154:                     ENDIF
2155:                 ENDIF
2156: 
2157:                 IF USED("cursor_4c_Excel")
2158:                     USE IN cursor_4c_Excel
2159:                 ENDIF

*-- Linhas 2182 a 2209:
2182:         CASE loc_oGrp.Value = 1 AND loc_oGrp.Buttons(1).Enabled
2183:             *-- Marca Tudo
2184:             IF USED("cursor_4c_Operacoes")
2185:                 SELECT cursor_4c_Operacoes
2186:                 REPLACE ALL SelImp WITH .T. FOR !Erros
2187:                 GO TOP
2188:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2189:             ENDIF
2190: 
2191:         CASE loc_oGrp.Value = 2 AND loc_oGrp.Buttons(2).Enabled
2192:             *-- Desmarcar
2193:             IF USED("cursor_4c_Operacoes")
2194:                 SELECT cursor_4c_Operacoes
2195:                 REPLACE ALL SelImp WITH .F.
2196:                 GO TOP
2197:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2198:             ENDIF
2199: 
2200:         CASE loc_oGrp.Value = 3 AND loc_oGrp.Buttons(3).Enabled
2201:             *-- Documentos (legado: Do Form SigMvExp)
2202:             THIS.AbrirDocumentoOperacao()
2203:         ENDCASE
2204:     ENDPROC
2205: 
2206:     *==========================================================================
2207:     * AbrirDocumentoOperacao - cmdBtnGrade "Documentos" do legado:
2208:     *   Do Form SigMvExp With csOperacoes.Dopes, 'C', csOperacoes.Numes,
2209:     *                          csOperacoes.Emps, .t.

*-- Linhas 2227 a 2261:
2227: 
2228:     *==========================================================================
2229:     * CmgCmdBtnFormClick - cmdBtnForm.Click do legado (Limpar Selecao/Gera
2230:     * Arquivo/Encerrar). O guard de "nenhum lancamento selecionado" (Select
2231:     * ... Count(1) ... Group By SelImp) roda ANTES do Do Case, so quando o
2232:     * botao clicado e o 2o (Gera Arquivo) - igual ao legado.
2233:     *==========================================================================
2234:     PROCEDURE CmgCmdBtnFormClick()
2235:         LOCAL loc_oGrp, loc_nSelecionados
2236: 
2237:         loc_oGrp = THIS.cmg_4c_CmdBtnForm
2238: 
2239:         IF loc_oGrp.Value = 2
2240:             loc_nSelecionados = 0
2241: 
2242:             IF USED("cursor_4c_Operacoes")
2243:                 IF USED("cursor_4c_ContaSel")
2244:                     USE IN cursor_4c_ContaSel
2245:                 ENDIF
2246:                 SELECT COUNT(*) AS Selecionados FROM cursor_4c_Operacoes ;
2247:                     WHERE SelImp INTO CURSOR cursor_4c_ContaSel
2248:                 IF USED("cursor_4c_ContaSel")
2249:                     loc_nSelecionados = cursor_4c_ContaSel.Selecionados
2250:                     USE IN cursor_4c_ContaSel
2251:                 ENDIF
2252:             ENDIF
2253: 
2254:             IF loc_nSelecionados < 1
2255:                 MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Selecionado!!!", "Processamento")
2256:                 THIS.txt_4c_DtIni.SetFocus()
2257:                 RETURN
2258:             ENDIF
2259:         ENDIF
2260: 
2261:         DO CASE


### BO (C:\4c\projeto\app\classes\SigOpVdaBO.prg):
*------------------------------------------------------------------------------
* SigOpVdaBO - Business Object de Geracao de Arquivos de Vendas
* Baseado no formulario legado SIGOPVDA (SigOpVda.SCX)
* Tabela principal: SigPcOoL (controle de operacoes ja processadas)
*------------------------------------------------------------------------------
DEFINE CLASS SigOpVdaBO AS BusinessBase

    *-- Filtros de selecao (Pagina de criterios do form)
    this_cEmps = ""
    this_cDescEmps = ""
    this_dDataIni = {}
    this_dDataFin = {}
    this_nProcessados = 1
    this_cArquivo = ""
    this_cAdquirente = ""

    *-- Campos do registro de controle (SigPcOoL) gravado por operacao processada
    this_cTipos = ""
    this_cEmpsReg = ""      && emps da LINHA processada (empresa do movimento) - NAO confundir com this_cEmps (filtro digitado na tela)
    this_cDopes = ""
    this_nNumes = 0
    this_dDatas = {}
    this_cUsuars = ""
    this_cProdutos = ""
    this_cProcessos = ""
    this_cIdChaves = ""
    this_cEmpDopNums = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BusinessObject
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela = "SigPcOoL"
        THIS.this_cCampoChave = "cIdChaves"

        DODEFAULT()

        *-- Filtros nascem com os defaults do Init legado (ver
        *-- AplicarFiltrosPadrao). O form os leva para a tela no
        *-- BOParaForm() chamado pelo InicializarForm.
        THIS.AplicarFiltrosPadrao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarFiltrosPadrao - valores iniciais dos filtros de selecao,
    * transcritos do bloco de defaults do Init do SCX legado (dentro do
    * "If (.poDataMgr.pnIdconn > 0)"):
    *
    *   .getDtIni.Value   = Date()
    *   .getDtFin.Value   = Date()
    *   .getArqNoms.Value = [C:\CONCILIADOR.CSV]
    *   optProcessados.Value = 1   (1-Nao Processadas / 2-Ja Processadas)
    *
    * Sem isto a tela abre com as duas datas e o caminho do arquivo em
    * BRANCO e o botao Selecionar recusa de imediato ("A Data Inicial Nao
    * Pode Ficar em Branco!!!" / "O Arquivo a Ser Gerado Precisa Ser
    * Informado!!!") - divergencia silenciosa do legado, que ja abre a tela
    * pronta para o dia corrente.
    *
    * Empresa, descricao da empresa e adquirente ficam VAZIOS de proposito:
    * o legado nao os preenche, e vazio significa "todas as empresas" /
    * "todos os adquirentes" nas duas consultas (o IIF(EMPTY(...)) de
    * Selecionar simplesmente omite a clausula do WHERE).
    *
    * PUBLIC (regra #51): o Form chama este metodo de FORA da classe.
    *--------------------------------------------------------------------------
    PROCEDURE AplicarFiltrosPadrao()
        THIS.this_cEmps         = ""
        THIS.this_cDescEmps     = ""
        THIS.this_dDataIni      = DATE()
        THIS.this_dDataFin      = DATE()
        THIS.this_nProcessados  = 1
        THIS.this_cArquivo      = "C:\CONCILIADOR.CSV"
        THIS.this_cAdquirente   = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa as propriedades do registro de controle
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cTipos = ""
        THIS.this_cEmpsReg = ""
        THIS.this_cDopes = ""
        THIS.this_nNumes = 0
        THIS.this_dDatas = {}
        THIS.this_cUsuars = ""
        THIS.this_cProdutos = ""
        THIS.this_cProcessos = ""
        THIS.this_cIdChaves = ""
        THIS.this_cEmpDopNums = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - cidchaves char(20), PK de SigPcOoL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cIdChaves, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades do registro de controle a
    * partir da linha corrente de um alias no formato de SigPcOoL/crSigPcOoL
    * (tipos, emps, dopes, numes, datas, usuars, produtos, processos,
    * cidchaves, empdopnums).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        IF EOF(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cTipos      = TratarNulo(tipos, "")
        THIS.this_cEmpsReg    = TratarNulo(emps, "")
        THIS.this_cDopes      = TratarNulo(dopes, "")
        THIS.this_nNumes      = TratarNulo(numes, 0)
        THIS.this_dDatas      = ConverterParaData(TratarNulo(datas, {}))
        THIS.this_cUsuars     = TratarNulo(usuars, "")
        THIS.this_cProdutos   = TratarNulo(produtos, "")
        THIS.this_cProcessos  = TratarNulo(processos, "")
        THIS.this_cIdChaves   = TratarNulo(cidchaves, "")
        THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Grava um registro de controle em SigPcOoL (uma linha por
    * operacao de venda processada/exportada), reproduzindo o
    * "Insert Into crSigPcOoL (...)" do metodo Processamento() do legado.
    *
    * cidchaves (PK char(20)) e gerado com fUniqueIds() quando ainda nao foi
    * atribuido - NUNCA string vazia, senao a linha seguinte do lote colide
    * no indice unico sigpcool_cidchaves (regra #22 do CLAUDE.md).
    *
    * empds/dopeds/numeds/edndests/nopers sao NOT NULL sem DEFAULT no schema
    * mas o legado nunca os preenche (o Insert Into do SCX lista so 10 das 15
    * colunas) - no fluxo legado eles chegam em branco/zero porque o cursor
    * crSigPcOoL nasce de AddCursor (estrutura completa da tabela, valores
    * default do tipo). Aqui o INSERT via SQLEXEC precisa declarar esses
    * mesmos defaults explicitamente, senao o SQL Server recusa a linha
    * inteira por tentar gravar NULL numa coluna que nao aceita.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cIdChaves, "")))
                THIS.this_cIdChaves = ALLTRIM(fUniqueIds())
            ENDIF

            loc_cSQL = "INSERT INTO SigPcOoL" + ;
                       " (tipos, emps, dopes, numes, empds, dopeds, numeds, datas," + ;
                       "  usuars, produtos, cidchaves, edndests, empdopnums, processos, nopers)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cTipos) + "," + ;
                       EscaparSQL(THIS.this_cEmpsReg) + "," + ;
                       EscaparSQL(THIS.this_cDopes) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + "," + ;
                       EscaparSQL("") + "," + ;
                       EscaparSQL("") + "," + ;
                       FormatarNumeroSQL(0, 0) + "," + ;
                       "GETDATE()," + ;
                       EscaparSQL(THIS.this_cUsuars) + "," + ;
                       EscaparSQL(THIS.this_cProdutos) + "," + ;
                       EscaparSQL(THIS.this_cIdChaves) + "," + ;
                       EscaparSQL("") + "," + ;
                       EscaparSQL(THIS.this_cEmpDopNums) + "," + ;
                       EscaparSQL(THIS.this_cProcessos) + "," + ;
                       FormatarNumeroSQL(0, 0) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao gravar controle de opera" + CHR(231) + CHR(227) + ;
                    "o processada:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao gravar controle de opera" + CHR(231) + CHR(227) + "o processada:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Corrige um registro de controle ja gravado em SigPcOoL,
    * identificado pela PK cidchaves. O legado (SIGOPVDA) nunca faz UPDATE
    * nesta tabela - cada linha e gravada uma unica vez no Processamento() e
    * nunca mais tocada - mas o metodo e implementado para completar o
    * contrato de BusinessBase.Salvar() (THIS.this_lNovoRegistro = .F.).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cIdChaves, "")))
                THIS.this_cMensagemErro = "Registro sem chave para altera" + CHR(231) + CHR(227) + "o"
            ELSE
                loc_cSQL = "UPDATE SigPcOoL SET" + ;
                           " tipos = "      + EscaparSQL(THIS.this_cTipos) + "," + ;
                           " emps = "       + EscaparSQL(THIS.this_cEmpsReg) + "," + ;
                           " dopes = "      + EscaparSQL(THIS.this_cDopes) + "," + ;
                           " numes = "      + FormatarNumeroSQL(THIS.this_nNumes, 0) + "," + ;
                           " usuars = "     + EscaparSQL(THIS.this_cUsuars) + "," + ;
                           " produtos = "   + EscaparSQL(THIS.this_cProdutos) + "," + ;
                           " processos = "  + EscaparSQL(THIS.this_cProcessos) + "," + ;
                           " empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums) + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao atualizar controle de opera" + CHR(231) + CHR(227) + ;
                        "o processada:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao atualizar controle de opera" + CHR(231) + CHR(227) + "o processada:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

