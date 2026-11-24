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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpVda.prg) - TRECHOS RELEVANTES PARA PASS SQL (2471 linhas total):

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

*-- Linhas 327 a 377:
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
344:         CREATE CURSOR cursor_4c_Operacoes (SelImp L(1), TIPO_REGISTRO C(3), ;
345:             ADQUIRENTE C(60), LOJA_FILIAL C(15), BANDEIRA C(60), ;
346:             TIPO_TRANSACAO C(15), NRO_PARCELA C(2), QTD_PARCELAS C(2), ;
347:             TID C(40), NSU C(30), AUTORIZACAO C(20), VALOR C(14), ;
348:             CLIENTE C(50), DATA_VENDA C(10), ORIGEM C(10), SEQUENCIA C(20), ;
349:             NOTA_FISCAL C(20), CPF_CNPJ C(20), ESTABELECIMENTO C(20), ;
350:             DATA_VENCIMENTO C(10), NUMERO_CARTAO C(30), REFERENCIA1 C(60), ;
351:             Emps C(3), Dopes C(20), Numes N(6), EmpDopNums C(29), Erros L(1))
352:     ENDPROC
353: 
354:     *==========================================================================
355:     * ConfigurarGrade - cntGrade/GrdOperacoes do legado -> cnt_4c_Grade/
356:     * grd_4c_Dados (grade de 13 colunas que lista as operacoes selecionadas
357:     * para gerar o arquivo de vendas).
358:     *
359:     * Transcricao do dump (SIGOPVDA.cntGrade/GrdOperacoes):
360:     *   cntGrade      Top=198 Left=13 Width=1229 Height=387 BorderWidth=0
361:     *   GrdOperacoes  Top=2 Left=1 Width=1225 Height=467 RowHeight=16
362:     *                 HeaderHeight=16 ScrollBars=2 DeleteMark=.F. RecordMark=.F.
363:     *                 AllowHeaderSizing=.F. AllowRowSizing=.F.
364:     *                 GridLineColor=238,238,238 Tahoma 8
365:     *
366:     * ColumnCount/RecordSource ficam FORA do WITH que acessa .ColumnN -
367:     * dentro do mesmo WITH, acessar .Column1 logo depois de atribuir
368:     * RecordSource estoura "Unknown member COLUMN1" (regra GRID-WITH).
369:     *
370:     * Geometria/headers das colunas moram em AplicarFormatoGrade (chamada ao
371:     * final), que e a FONTE UNICA (regra do Problema 48: RecordSource zera
372:     * Column.Width e Header1.Caption, e este metodo e chamado de novo quando
373:     * a grade for religada a dado real nas fases seguintes).
374:     *==========================================================================
375:     PROTECTED PROCEDURE ConfigurarGrade()
376:         THIS.CriarCursorOperacoes()
377: 

*-- Linhas 399 a 455:
399:             .FontSize          = 8
400:             .AllowHeaderSizing = .F.
401:             .AllowRowSizing    = .F.
402:             .DeleteMark        = .F.
403:             .RecordMark        = .F.
404:             .HeaderHeight      = 19
405:             .RowHeight         = 16
406:             .ScrollBars        = 2
407:             .TabIndex          = 16
408:             .GridLineColor     = RGB(238, 238, 238)
409:             .Visible           = .T.
410: 
411:             *-- Grid.ReadOnly ANTES de qualquer Column.ReadOnly (regra #18:
412:             *-- o do grid propaga para as colunas e sobrescreve). O legado
413:             *-- declara .ReadOnly = .f. no Init (so a Column1 e editavel - as
414:             *-- demais sao travadas uma a uma em AplicarFormatoGrade).
415:             .ReadOnly          = .F.
416:         ENDWITH
417: 
418:         *-- ColumnCount FORA do WITH acima (regra GRID-WITH). RecordSource/
419:         *-- ControlSource NAO ficam aqui: moram em VincularGrade (ver nota la).
420:         THIS.cnt_4c_Grade.grd_4c_Dados.ColumnCount = 13
421: 
422:         *-- VincularGrade (e NAO AplicarFormatoGrade direto): atribuir
423:         *-- ColumnCount sem RecordSource faz o Grid AUTO-BINDAR na area de
424:         *-- trabalho CORRENTE, e a Column1 pode cair numa coluna de tipo
425:         *-- incompativel - dai o AddObject do CheckBox estoura "Data type
426:         *-- mismatch" no proprio AddObject, dentro do TRY do InicializarForm,
427:         *-- e a tela nao abre. Vinculando ANTES, a Column1 ja esta no campo
428:         *-- LOGICO SelImp quando o Check1 e criado.
429:         THIS.VincularGrade()
430:     ENDPROC
431: 
432:     *==========================================================================
433:     * VincularGrade - liga grd_4c_Dados ao alias cursor_4c_Operacoes
434:     * (RecordSource + os 13 ControlSource, transcritos um a um do Init legado,
435:     * inclusive a EXPRESSAO calculada da Column7).
436:     *
437:     * Separado de ConfigurarGrade de proposito: ConfigurarGrade carrega so o
438:     * que NAO depende de dado (geometria, ColumnCount, fontes, cores), e o
439:     * bind vive aqui porque e refeito a cada recarga. Guardado por USED() -
440:     * atribuir RecordSource/ControlSource de alias que ainda nao existe
441:     * estoura "Alias is not found" DENTRO do TRY do InicializarForm, o que
442:     * faz CREATEOBJECT devolver .F. e a tela nao abrir (regra #41).
443:     *
444:     * AplicarFormatoGrade e chamada DEPOIS do bind, SEMPRE (inclusive quando
445:     * o alias nao esta aberto): atribuir RecordSource zera Column.Width e
446:     * Header1.Caption (regra #41 / Problema 48), e sem a reaplicacao a grade
447:     * ficaria com cabecalho "Column1" e largura default.
448:     *==========================================================================
449:     PROCEDURE VincularGrade()
450:         LOCAL loc_lVinculou
451:         loc_lVinculou = .F.
452: 
453:         IF !PEMSTATUS(THIS, "cnt_4c_Grade", 5)
454:             RETURN loc_lVinculou
455:         ENDIF

*-- Linhas 463 a 512:
463:             THIS.cnt_4c_Grade.grd_4c_Dados.RecordSource = "cursor_4c_Operacoes"
464: 
465:             WITH THIS.cnt_4c_Grade.grd_4c_Dados
466:                 .Column1.ControlSource  = "cursor_4c_Operacoes.SelImp"
467:                 .Column2.ControlSource  = "cursor_4c_Operacoes.DATA_VENDA"
468:                 .Column3.ControlSource  = "cursor_4c_Operacoes.ADQUIRENTE"
469:                 .Column4.ControlSource  = "cursor_4c_Operacoes.BANDEIRA"
470:                 .Column5.ControlSource  = "cursor_4c_Operacoes.TIPO_TRANSACAO"
471:                 .Column6.ControlSource  = "cursor_4c_Operacoes.DATA_VENCIMENTO"
472:                 .Column7.ControlSource  = "PADL(cursor_4c_Operacoes.NRO_PARCELA, 2, '0') + ' / ' + " + ;
473:                                            "PADL(cursor_4c_Operacoes.QTD_PARCELAS, 2, '0')"
474:                 .Column8.ControlSource  = "cursor_4c_Operacoes.NSU"
475:                 .Column9.ControlSource  = "cursor_4c_Operacoes.AUTORIZACAO"
476:                 .Column10.ControlSource = "cursor_4c_Operacoes.VALOR"
477:                 .Column11.ControlSource = "cursor_4c_Operacoes.Emps"
478:                 .Column12.ControlSource = "cursor_4c_Operacoes.Dopes"
479:                 .Column13.ControlSource = "cursor_4c_Operacoes.Numes"
480:             ENDWITH
481: 
482:             loc_lVinculou = .T.
483:         ENDIF
484: 
485:         *-- SEMPRE, vinculado ou nao (RecordSource zera Width/Caption)
486:         THIS.AplicarFormatoGrade()
487: 
488:         RETURN loc_lVinculou
489:     ENDPROC
490: 
491:     *==========================================================================
492:     * CarregarDados - FUNIL de carga/repintura da grade de operacoes.
493:     *
494:     * Existe porque popular o cursor NAO repinta a grade ligada a ele (regra
495:     * #21): o legado fecha TODO caminho que mexe em csOperacoes com o mesmo
496:     * par, e sao SEIS caminhos -
497:     *   Selecionar ............ Select csOperacoes / Go Top /
498:     *                           GrdOperacoes.Column1.SetFocus /
499:     *                           Column1.Refresh / GrdOperacoes.Refresh
500:     *   LimpaSelecao .......... Zap In csOperacoes + Refresh
501:     *   cmdBtnGrade "Marca Tudo" .. Replace All SelImp With .t. For Not Erros /
502:     *                           Go Top / GrdOperacoes.Refresh
503:     *   cmdBtnGrade "Desmarcar" ... Replace All SelImp With .f. / Go Top /
504:     *                           GrdOperacoes.Refresh
505:     *   Check1.MouseUp ........ Gather Memvar / GrdOperacoes.Refresh
506:     *   Check1.KeyPress ....... Gather Memvar / GrdOperacoes.Refresh
507:     * Sem um funil unico, cada um desses pontos (fases 7 e 8) teria de
508:     * lembrar do par - e o que falta nunca da erro: a grade so fica
509:     * mostrando o conteudo de antes, e o sintoma reportado vira "a tela nao
510:     * traz dados".
511:     *
512:     * PUBLIC de proposito (regra #3): o harness de teste (TesteAutomatico.prg)

*-- Linhas 530 a 548:
530:             THIS.CriarCursorOperacoes()
531: 
532:             IF THIS.VincularGrade()
533:                 SELECT cursor_4c_Operacoes
534:                 GO TOP IN cursor_4c_Operacoes
535: 
536:                 THIS.Refresh()
537:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
538: 
539:                 loc_lSucesso = .T.
540:             ENDIF
541: 
542:         CATCH TO loc_oErro
543:             THIS.this_cMensagemErro = loc_oErro.Message
544:             MsgErro(loc_oErro.Message + CHR(13) + ;
545:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
546:                 "Procedure: " + loc_oErro.Procedure, ;
547:                 "Erro CarregarDados")
548:         ENDTRY

*-- Linhas 1456 a 1498:
1456:     *==========================================================================
1457:     * ValidarAdquirs - getAdquirs.Valid do legado:
1458:     *   If Not Empty(This.Value)
1459:     *       Select crAdquirs / Set Order To Adquirente
1460:     *       If Not Seek(This.Value)
1461:     *           <abre fwBuscaInt>
1462:     *       EndIf
1463:     *       This.Value = crAdquirs.Adquirente
1464:     *   EndIf
1465:     *
1466:     * crAdquirs era pre-carregado no Init legado com "Select codcads as
1467:     * Adquirente, descads As Descr From SigCdCad Where TipoCads =
1468:     * 'ADQUIRENTE'". Aqui o SEEK equivalente vai direto ao SQL Server (sem
1469:     * manter cursor global), e so abre o picker quando o codigo digitado
1470:     * NAO existe - regra #50 (universo vazio nao e erro, nunca apagar o
1471:     * digitado nem avisar antes do picker).
1472:     *==========================================================================
1473:     PROCEDURE ValidarAdquirs()
1474:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
1475:         loc_cValor = ALLTRIM(THIS.txt_4c_Adquirs.Value)
1476: 
1477:         IF EMPTY(loc_cValor)
1478:             RETURN
1479:         ENDIF
1480: 
1481:         loc_cSQL = "SELECT codcads FROM SigCdCad WHERE TipoCads = " + ;
1482:                    EscaparSQL("ADQUIRENTE") + " AND codcads = " + EscaparSQL(loc_cValor)
1483:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AdqVal")
1484: 
1485:         IF loc_nResultado <= 0 OR !USED("cursor_4c_AdqVal") OR EOF("cursor_4c_AdqVal")
1486:             IF USED("cursor_4c_AdqVal")
1487:                 USE IN cursor_4c_AdqVal
1488:             ENDIF
1489:             THIS.AbrirLookupAdquirente()
1490:         ELSE
1491:             USE IN cursor_4c_AdqVal
1492:         ENDIF
1493:     ENDPROC
1494: 
1495:     *==========================================================================
1496:     * AbrirLookupAdquirente - picker de Adquirente (SigCdCad filtrado por
1497:     * TipoCads = 'ADQUIRENTE'), substituicao canonica do fwBuscaInt em
1498:     * crAdquirs do legado - regra #36 (1o argumento e o HANDLE da conexao).

*-- Linhas 1507 a 1534:
1507:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1508:             "SigCdCad", "cursor_4c_BuscaAdq", "codcads", loc_cValor, ;
1509:             "Sele" + CHR(231) + CHR(227) + "o de Adquirente", .F., .T., ;
1510:             "TipoCads = " + EscaparSQL("ADQUIRENTE"))
1511: 
1512:         IF VARTYPE(loc_oBusca) = "O"
1513:             IF !loc_oBusca.this_lAchouRegistro
1514:                 loc_oBusca.mAddColuna("codcads", "", "C" + CHR(243) + "digo")
1515:                 loc_oBusca.mAddColuna("descads", "", "Adquirente")
1516:                 loc_oBusca.Show()
1517:             ENDIF
1518:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAdq")
1519:                 SELECT cursor_4c_BuscaAdq
1520:                 THIS.txt_4c_Adquirs.Value = ALLTRIM(codcads)
1521:             ENDIF
1522:             loc_oBusca.Release()
1523:         ENDIF
1524: 
1525:         IF USED("cursor_4c_BuscaAdq")
1526:             USE IN cursor_4c_BuscaAdq
1527:         ENDIF
1528:     ENDPROC
1529: 
1530:     *==========================================================================
1531:     * EmpOsKeyPress / DEmpOsKeyPress - getEmpOs/getDEmpOs.KeyPress (novo).
1532:     * F4(115) abre o picker direto; Enter(13)/Tab(9) valida o valor
1533:     * digitado - mesmo padrao de AdquirsKeyPress.
1534:     *

*-- Linhas 1584 a 1603:
1584:             RETURN
1585:         ENDIF
1586: 
1587:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
1588:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
1589: 
1590:         IF loc_nResultado > 0 AND USED("cursor_4c_EmpVal") AND !EOF("cursor_4c_EmpVal")
1591:             THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
1592:         ELSE
1593:             THIS.txt_4c_DEmpOs.Value = ""
1594:         ENDIF
1595: 
1596:         IF USED("cursor_4c_EmpVal")
1597:             USE IN cursor_4c_EmpVal
1598:         ENDIF
1599: 
1600:         IF EMPTY(THIS.txt_4c_DEmpOs.Value)
1601:             THIS.AbrirLookupEmpOs()
1602:         ENDIF
1603: 

*-- Linhas 1658 a 1678:
1658:             RETURN
1659:         ENDIF
1660: 
1661:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + ;
1662:                    EscaparSQL(loc_cValor + "%")
1663:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDescVal")
1664: 
1665:         IF loc_nResultado > 0 AND USED("cursor_4c_EmpDescVal") AND !EOF("cursor_4c_EmpDescVal")
1666:             THIS.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_EmpDescVal.Cemps)
1667:             THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpDescVal.Razas)
1668:             IF USED("cursor_4c_EmpDescVal")
1669:                 USE IN cursor_4c_EmpDescVal
1670:             ENDIF
1671:         ELSE
1672:             IF USED("cursor_4c_EmpDescVal")
1673:                 USE IN cursor_4c_EmpDescVal
1674:             ENDIF
1675:             THIS.AbrirLookupDEmpOs()
1676:         ENDIF
1677:     ENDPROC
1678: 

*-- Linhas 1778 a 1796:
1778: 
1779:     *==========================================================================
1780:     * Selecionar - PROCEDURE selecionar do legado: valida Data Inicial/
1781:     * Final/pasta do arquivo de exportacao, monta e executa o JOIN
1782:     * SigOpFp+SigCdCli+SigMvPar+SigCdOpe (filtrado por empresa/adquirente/
1783:     * periodo/situacao de processamento ja gravada em SigPcOoL), e povoa
1784:     * cursor_4c_Operacoes linha a linha com os campos derivados.
1785:     *
1786:     * RETURN so FORA do TRY (regra #1) - loc_lValido encadeia os 4 guards
1787:     * de validacao do legado (cada MessageBox + SetFocus + Return .f.).
1788:     *
1789:     * PUBLIC (regra #3): alvo de BINDEVENT (CmdSelecionarClick) e mesmo
1790:     * nome do PROCEDURE legado (harness pode chamar direto).
1791:     *==========================================================================
1792:     PROCEDURE Selecionar()
1793:         LOCAL loc_cEmp, loc_lNaoProcessados, loc_dDtIni, loc_dDtFin, ;
1794:               loc_cArquivo, loc_cAdquirente, loc_dDtFinHora, loc_cSQL, ;
1795:               loc_nResultado, loc_lValido, loc_lErros, loc_cBandeira, ;
1796:               loc_cOrigem, loc_lSucesso, loc_oErro

*-- Linhas 1853 a 1952:
1853:             IF loc_lValido
1854:                 loc_dDtFinHora = DATETIME(YEAR(loc_dDtFin), MONTH(loc_dDtFin), DAY(loc_dDtFin), 23, 59, 59)
1855: 
1856:                 loc_cSQL = "SELECT 'A02' AS TIPO_REGISTRO, p.Adquirente AS ADQUIRENTE," + ;
1857:                     " p.Emps AS LOJA_FILIAL, f.Bandeira AS BANDEIRA1, d.RClis AS BANDEIRA2," + ;
1858:                     " f.Opers AS TIPO_TRANSACAO, p.Parcs AS NRO_PARCELA, p.TParcs AS QTD_PARCELAS," + ;
1859:                     " SPACE(40) AS TID, p.NSU AS NSU, p.Autoriza AS AUTORIZACAO, p.Valos AS VALOR," + ;
1860:                     " SPACE(50) AS CLIENTE, p.Datas AS DATA_VENDA, f.CCupomNvs AS ORIGEM," + ;
1861:                     " '' AS SEQUENCIA, '' AS NOTA_FISCAL, '' AS CPF_CNPJ, f.CodEstabs AS ESTABELECIMENTO," + ;
1862:                     " p.Vencs AS DATA_VENCIMENTO, '' AS NUMERO_CARTAO," + ;
1863:                     " p.EmpDopNums + p.FPags + STR(p.Nopers, 10) AS REFERENCIA1," + ;
1864:                     " p.Emps, p.Dopes, p.Numes, p.EmpDopNums" + ;
1865:                     " FROM SigOpFP f, SigCdCli d, SigMvPar p, SigCdOpe o" + ;
1866:                     " WHERE f.Infos = 'T'" + ;
1867:                     "   AND f.ContaDs = d.IClis" + ;
1868:                     "   AND p.FPags = f.FPags" + ;
1869:                     IIF(EMPTY(loc_cEmp), "", "   AND p.Emps = " + EscaparSQL(loc_cEmp)) + ;
1870:                     IIF(EMPTY(loc_cAdquirente), "", "   AND p.Adquirente = " + EscaparSQL(loc_cAdquirente)) + ;
1871:                     "   AND p.Datas BETWEEN " + FormatarDataSQL(loc_dDtIni) + " AND " + FormatarDataSQL(loc_dDtFinHora) + ;
1872:                     "   AND p.Dopes = o.Dopes" + ;
1873:                     "   AND NOT o.Vendas = 2" + ;
1874:                     "   AND p.Vencs IS NOT NULL" + ;
1875:                     "   AND p.EmpDopNums " + IIF(loc_lNaoProcessados, "NOT ", "") + ;
1876:                     "   IN (SELECT DISTINCT b.EmpDopNums FROM SigPcOoL b WHERE b.Tipos = " + EscaparSQL("SIGOPVDA") + ")" + ;
1877:                     " ORDER BY p.Datas, p.EmpDopNums, p.FPags, p.Parcs"
1878: 
1879:                 IF USED("cursor_4c_Selecao")
1880:                     USE IN cursor_4c_Selecao
1881:                 ENDIF
1882: 
1883:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Selecao")
1884: 
1885:                 IF loc_nResultado < 0 OR !USED("cursor_4c_Selecao")
1886:                     MsgErro("Erro ao consultar as opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1887:                         CapturarErroSQL(), "Erro SQL")
1888:                 ELSE
1889:                     SELECT cursor_4c_Selecao
1890:                     GO TOP
1891: 
1892:                     IF EOF("cursor_4c_Selecao")
1893:                         USE IN cursor_4c_Selecao
1894:                         MsgInfo("N" + CHR(227) + "o Existem Registros Informados Com as Condi" + ;
1895:                             CHR(231) + CHR(245) + "es Selecionadas!!!", "Nenhum Registro Encontrado")
1896:                         THIS.LimpaSelecao()
1897:                     ELSE
1898:                         SELECT cursor_4c_Selecao
1899:                         SCAN
1900:                             loc_lErros = EMPTY(ALLTRIM(cursor_4c_Selecao.BANDEIRA1 + cursor_4c_Selecao.BANDEIRA2)) ;
1901:                                 OR EMPTY(cursor_4c_Selecao.NRO_PARCELA) ;
1902:                                 OR EMPTY(cursor_4c_Selecao.QTD_PARCELAS) ;
1903:                                 OR EMPTY(cursor_4c_Selecao.NSU) ;
1904:                                 OR EMPTY(cursor_4c_Selecao.AUTORIZACAO) ;
1905:                                 OR EMPTY(cursor_4c_Selecao.VALOR) ;
1906:                                 OR EMPTY(cursor_4c_Selecao.DATA_VENDA) ;
1907:                                 OR EMPTY(cursor_4c_Selecao.DATA_VENCIMENTO) ;
1908:                                 OR EMPTY(cursor_4c_Selecao.ADQUIRENTE)
1909: 
1910:                             loc_cBandeira = IIF(EMPTY(ALLTRIM(cursor_4c_Selecao.BANDEIRA1)), ;
1911:                                 ALLTRIM(cursor_4c_Selecao.BANDEIRA2), ALLTRIM(cursor_4c_Selecao.BANDEIRA1))
1912:                             loc_cOrigem = IIF(EMPTY(ALLTRIM(cursor_4c_Selecao.ORIGEM)), "POS", ;
1913:                                 ALLTRIM(cursor_4c_Selecao.ORIGEM))
1914: 
1915:                             INSERT INTO cursor_4c_Operacoes (SelImp, TIPO_REGISTRO, ADQUIRENTE, ;
1916:                                 LOJA_FILIAL, BANDEIRA, TIPO_TRANSACAO, NRO_PARCELA, QTD_PARCELAS, ;
1917:                                 TID, NSU, AUTORIZACAO, VALOR, CLIENTE, DATA_VENDA, ORIGEM, ;
1918:                                 SEQUENCIA, NOTA_FISCAL, CPF_CNPJ, ESTABELECIMENTO, DATA_VENCIMENTO, ;
1919:                                 NUMERO_CARTAO, REFERENCIA1, Emps, Dopes, Numes, EmpDopNums, Erros) ;
1920:                                 VALUES (!loc_lErros, cursor_4c_Selecao.TIPO_REGISTRO, ;
1921:                                 cursor_4c_Selecao.ADQUIRENTE, cursor_4c_Selecao.LOJA_FILIAL, ;
1922:                                 loc_cBandeira, cursor_4c_Selecao.TIPO_TRANSACAO, ;
1923:                                 ALLTRIM(STR(cursor_4c_Selecao.NRO_PARCELA, 3)), ;
1924:                                 ALLTRIM(STR(cursor_4c_Selecao.QTD_PARCELAS, 3)), ;
1925:                                 cursor_4c_Selecao.TID, cursor_4c_Selecao.NSU, ;
1926:                                 cursor_4c_Selecao.AUTORIZACAO, ;
1927:                                 STRTRAN(ALLTRIM(STR(cursor_4c_Selecao.VALOR, 12, 2)), ".", ","), ;
1928:                                 cursor_4c_Selecao.CLIENTE, ;
1929:                                 DTOC(ConverterParaData(cursor_4c_Selecao.DATA_VENDA)), loc_cOrigem, ;
1930:                                 cursor_4c_Selecao.SEQUENCIA, cursor_4c_Selecao.NOTA_FISCAL, ;
1931:                                 cursor_4c_Selecao.CPF_CNPJ, cursor_4c_Selecao.ESTABELECIMENTO, ;
1932:                                 DTOC(ConverterParaData(cursor_4c_Selecao.DATA_VENCIMENTO)), ;
1933:                                 cursor_4c_Selecao.NUMERO_CARTAO, cursor_4c_Selecao.REFERENCIA1, ;
1934:                                 cursor_4c_Selecao.Emps, cursor_4c_Selecao.Dopes, ;
1935:                                 cursor_4c_Selecao.Numes, cursor_4c_Selecao.EmpDopNums, loc_lErros)
1936: 
1937:                             SELECT cursor_4c_Selecao
1938:                         ENDSCAN
1939: 
1940:                         USE IN cursor_4c_Selecao
1941: 
1942:                         THIS.HabilitarFiltros(.F.)
1943:                         THIS.HabilitarAcoesProcessamento(.T.)
1944: 
1945:                         THIS.CarregarDados()
1946:                         THIS.cnt_4c_Grade.grd_4c_Dados.Column1.SetFocus()
1947:                         THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Refresh()
1948: 
1949:                         loc_lSucesso = .T.
1950:                     ENDIF
1951:                 ENDIF
1952:             ENDIF

*-- Linhas 2001 a 2031:
2001:     * Processamento - PROCEDURE processamento do legado: grava o header
2002:     * 'A01' (nomes das colunas) + uma linha 'A02' por operacao SelImp no
2003:     * cursor de exportacao, COPY TO DELIMITED, e insere o controle em
2004:     * SigPcOoL (um INSERT por linha, tudo num UNICO SQLEXEC - BEGIN/COMMIT
2005:     * via SQLEXEC separado NAO protege, a conexao ja nasce com @@TRANCOUNT
2006:     * = 1 - regra "BEGIN/COMMIT via SQLEXEC nao protege").
2007:     *
2008:     * Nao apaga o arquivo se o lote SQL falhar (igual ao legado: o arquivo
2009:     * ja foi gravado em disco ANTES da tentativa de commit).
2010:     *
2011:     * PUBLIC (regra #3): chamado por CmgCmdBtnFormClick e mesmo nome do
2012:     * PROCEDURE legado.
2013:     *==========================================================================
2014:     PROCEDURE Processamento()
2015:         LOCAL loc_lNaoProcessados, loc_cArquivo, loc_nOrdem, loc_lOk, ;
2016:               loc_cInserts, loc_cSQLLote, loc_cProdutosFlag, loc_nResultado, ;
2017:               loc_lFiltrosOk, loc_oErro
2018:         loc_lOk = .F.
2019: 
2020:         TRY
2021:             *-- FONTE UNICA dos filtros, igual a Selecionar: FormParaBO()
2022:             *-- recarrega as properties do BO a partir dos controles (o
2023:             *-- legado tambem relia optProcessados/getArqNoms aqui) e
2024:             *-- Processamento le do BO, nunca mais do controle.
2025:             loc_lFiltrosOk      = THIS.FormParaBO()
2026:             loc_lNaoProcessados = .T.
2027:             loc_cArquivo        = ""
2028: 
2029:             IF loc_lFiltrosOk
2030:                 WITH THIS.this_oBusinessObject
2031:                     loc_lNaoProcessados = (.this_nProcessados = 1)

*-- Linhas 2045 a 2155:
2045:                     USE IN cursor_4c_Excel
2046:                 ENDIF
2047: 
2048:                 CREATE CURSOR cursor_4c_Excel (TIPO_REGISTRO C(3), ADQUIRENTE C(60), ;
2049:                     LOJA_FILIAL C(15), BANDEIRA C(60), TIPO_TRANSACAO C(15), ;
2050:                     NRO_PARCELA C(2), QTD_PARCELAS C(2), TID C(40), NSU C(30), ;
2051:                     AUTORIZACAO C(20), VALOR C(14), CLIENTE C(50), DATA_VENDA C(10), ;
2052:                     ORIGEM C(10), SEQUENCIA C(20), NOTA_FISCAL C(20), CPF_CNPJ C(20), ;
2053:                     ESTABELECIMENTO C(20), DATA_VENCIMENTO C(10), NUMERO_CARTAO C(30), ;
2054:                     REFERENCIA1 C(60))
2055: 
2056:                 *-- Header 'A01' - o legado grava os NOMES das colunas como a
2057:                 *-- 1a linha do arquivo exportado.
2058:                 INSERT INTO cursor_4c_Excel (TIPO_REGISTRO, ADQUIRENTE, LOJA_FILIAL, ;
2059:                     BANDEIRA, TIPO_TRANSACAO, NRO_PARCELA, QTD_PARCELAS, TID, NSU, ;
2060:                     AUTORIZACAO, VALOR, CLIENTE, DATA_VENDA, ORIGEM, SEQUENCIA, ;
2061:                     NOTA_FISCAL, CPF_CNPJ, ESTABELECIMENTO, DATA_VENCIMENTO, ;
2062:                     NUMERO_CARTAO, REFERENCIA1) ;
2063:                     VALUES ("A01", "ADQUIRENTE", "LOJA_FILIAL", "BANDEIRA", ;
2064:                     "TIPO_TRANSACAO", "NRO_PARCELA", "QTD_PARCELAS", "TID", "NSU", ;
2065:                     "AUTORIZA" + CHR(199) + CHR(195) + "O", "VALOR", "CLIENTE", ;
2066:                     "DATA_VENDA", "ORIGEM", "SEQUENCIA", "NOTA_FISCAL", "CPF_CNPJ", ;
2067:                     "ESTABELECIMENTO", "DATA_VENCIMENTO", "NUMERO_CARTAO", "REFERENCIA1")
2068: 
2069:                 loc_nOrdem   = 0
2070:                 loc_cInserts = ""
2071: 
2072:                 SELECT cursor_4c_Operacoes
2073:                 SCAN FOR SelImp
2074:                     loc_nOrdem = loc_nOrdem + 1
2075: 
2076:                     INSERT INTO cursor_4c_Excel (TIPO_REGISTRO, ADQUIRENTE, LOJA_FILIAL, ;
2077:                         BANDEIRA, TIPO_TRANSACAO, NRO_PARCELA, QTD_PARCELAS, TID, NSU, ;
2078:                         AUTORIZACAO, VALOR, CLIENTE, DATA_VENDA, ORIGEM, SEQUENCIA, ;
2079:                         NOTA_FISCAL, CPF_CNPJ, ESTABELECIMENTO, DATA_VENCIMENTO, ;
2080:                         NUMERO_CARTAO, REFERENCIA1) ;
2081:                         VALUES (cursor_4c_Operacoes.TIPO_REGISTRO, cursor_4c_Operacoes.ADQUIRENTE, ;
2082:                         cursor_4c_Operacoes.LOJA_FILIAL, cursor_4c_Operacoes.BANDEIRA, ;
2083:                         cursor_4c_Operacoes.TIPO_TRANSACAO, cursor_4c_Operacoes.NRO_PARCELA, ;
2084:                         cursor_4c_Operacoes.QTD_PARCELAS, cursor_4c_Operacoes.TID, ;
2085:                         cursor_4c_Operacoes.NSU, cursor_4c_Operacoes.AUTORIZACAO, ;
2086:                         cursor_4c_Operacoes.VALOR, cursor_4c_Operacoes.CLIENTE, ;
2087:                         cursor_4c_Operacoes.DATA_VENDA, cursor_4c_Operacoes.ORIGEM, ;
2088:                         ALLTRIM(STR(loc_nOrdem, 20)), cursor_4c_Operacoes.NOTA_FISCAL, ;
2089:                         cursor_4c_Operacoes.CPF_CNPJ, cursor_4c_Operacoes.ESTABELECIMENTO, ;
2090:                         cursor_4c_Operacoes.DATA_VENCIMENTO, cursor_4c_Operacoes.NUMERO_CARTAO, ;
2091:                         cursor_4c_Operacoes.REFERENCIA1)
2092: 
2093:                     loc_cInserts = loc_cInserts + ;
2094:                         "INSERT INTO SigPcOoL (tipos, emps, dopes, numes, empds, dopeds," + ;
2095:                         " numeds, datas, usuars, produtos, cidchaves, edndests, empdopnums," + ;
2096:                         " processos, nopers) VALUES (" + ;
2097:                         EscaparSQL("SIGOPVDA") + "," + ;
2098:                         EscaparSQL(ALLTRIM(cursor_4c_Operacoes.Emps)) + "," + ;
2099:                         EscaparSQL(ALLTRIM(cursor_4c_Operacoes.Dopes)) + "," + ;
2100:                         FormatarNumeroSQL(cursor_4c_Operacoes.Numes, 0) + "," + ;
2101:                         EscaparSQL("") + "," + EscaparSQL("") + "," + FormatarNumeroSQL(0, 0) + "," + ;
2102:                         "GETDATE()," + ;
2103:                         EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
2104:                         EscaparSQL(loc_cProdutosFlag) + "," + ;
2105:                         EscaparSQL(ALLTRIM(fUniqueIds())) + "," + ;
2106:                         EscaparSQL("") + "," + ;
2107:                         EscaparSQL(ALLTRIM(cursor_4c_Operacoes.EmpDopNums)) + "," + ;
2108:                         EscaparSQL(ALLTRIM(cursor_4c_Operacoes.REFERENCIA1)) + "," + ;
2109:                         FormatarNumeroSQL(0, 0) + ");" + CHR(13)
2110: 
2111:                     SELECT cursor_4c_Operacoes
2112:                 ENDSCAN
2113: 
2114:                 SELECT cursor_4c_Excel
2115:                 COPY TO (loc_cArquivo) DELIMITED
2116: 
2117:                 IF !FILE(loc_cArquivo)
2118:                     MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + "vel Gerar o Arquivo!!! " + ;
2119:                         "Verifique Suas Permiss" + CHR(245) + "es!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
2120:                 ELSE
2121:                     loc_cSQLLote = "SET NOCOUNT ON;" + CHR(13) + ;
2122:                         "DECLARE @nivel4c int = @@TRANCOUNT;" + CHR(13) + ;
2123:                         "IF @nivel4c = 0 BEGIN TRANSACTION ELSE SAVE TRANSACTION Op4cVda;" + CHR(13) + ;
2124:                         "BEGIN TRY" + CHR(13) + ;
2125:                         loc_cInserts + ;
2126:                         "IF @nivel4c = 0 COMMIT TRANSACTION;" + CHR(13) + ;
2127:                         "END TRY" + CHR(13) + ;
2128:                         "BEGIN CATCH" + CHR(13) + ;
2129:                         "IF @nivel4c = 0" + CHR(13) + ;
2130:                         "BEGIN" + CHR(13) + ;
2131:                         "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;" + CHR(13) + ;
2132:                         "END" + CHR(13) + ;
2133:                         "ELSE" + CHR(13) + ;
2134:                         "BEGIN" + CHR(13) + ;
2135:                         "IF XACT_STATE() = 1 ROLLBACK TRANSACTION Op4cVda;" + CHR(13) + ;
2136:                         "END;" + CHR(13) + ;
2137:                         "THROW;" + CHR(13) + ;
2138:                         "END CATCH"
2139: 
2140:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQLLote)
2141: 
2142:                     IF loc_nResultado < 0
2143:                         MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
2144:                             "Falha na Conex" + CHR(227) + "o (SigPcOoL)")
2145:                     ELSE
2146:                         MsgInfo("Arquivo Gerado!!!", "OK")
2147:                         THIS.LimpaSelecao()
2148:                         THIS.Selecionar()
2149:                         loc_lOk = .T.
2150:                     ENDIF
2151:                 ENDIF
2152: 
2153:                 IF USED("cursor_4c_Excel")
2154:                     USE IN cursor_4c_Excel
2155:                 ENDIF

*-- Linhas 2178 a 2205:
2178:         CASE loc_oGrp.Value = 1 AND loc_oGrp.Buttons(1).Enabled
2179:             *-- Marca Tudo
2180:             IF USED("cursor_4c_Operacoes")
2181:                 SELECT cursor_4c_Operacoes
2182:                 REPLACE ALL SelImp WITH .T. FOR !Erros
2183:                 GO TOP
2184:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2185:             ENDIF
2186: 
2187:         CASE loc_oGrp.Value = 2 AND loc_oGrp.Buttons(2).Enabled
2188:             *-- Desmarcar
2189:             IF USED("cursor_4c_Operacoes")
2190:                 SELECT cursor_4c_Operacoes
2191:                 REPLACE ALL SelImp WITH .F.
2192:                 GO TOP
2193:                 THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
2194:             ENDIF
2195: 
2196:         CASE loc_oGrp.Value = 3 AND loc_oGrp.Buttons(3).Enabled
2197:             *-- Documentos (legado: Do Form SigMvExp)
2198:             THIS.AbrirDocumentoOperacao()
2199:         ENDCASE
2200:     ENDPROC
2201: 
2202:     *==========================================================================
2203:     * AbrirDocumentoOperacao - cmdBtnGrade "Documentos" do legado:
2204:     *   Do Form SigMvExp With csOperacoes.Dopes, 'C', csOperacoes.Numes,
2205:     *                          csOperacoes.Emps, .t.

*-- Linhas 2223 a 2257:
2223: 
2224:     *==========================================================================
2225:     * CmgCmdBtnFormClick - cmdBtnForm.Click do legado (Limpar Selecao/Gera
2226:     * Arquivo/Encerrar). O guard de "nenhum lancamento selecionado" (Select
2227:     * ... Count(1) ... Group By SelImp) roda ANTES do Do Case, so quando o
2228:     * botao clicado e o 2o (Gera Arquivo) - igual ao legado.
2229:     *==========================================================================
2230:     PROCEDURE CmgCmdBtnFormClick()
2231:         LOCAL loc_oGrp, loc_nSelecionados
2232: 
2233:         loc_oGrp = THIS.cmg_4c_CmdBtnForm
2234: 
2235:         IF loc_oGrp.Value = 2
2236:             loc_nSelecionados = 0
2237: 
2238:             IF USED("cursor_4c_Operacoes")
2239:                 IF USED("cursor_4c_ContaSel")
2240:                     USE IN cursor_4c_ContaSel
2241:                 ENDIF
2242:                 SELECT COUNT(*) AS Selecionados FROM cursor_4c_Operacoes ;
2243:                     WHERE SelImp INTO CURSOR cursor_4c_ContaSel
2244:                 IF USED("cursor_4c_ContaSel")
2245:                     loc_nSelecionados = cursor_4c_ContaSel.Selecionados
2246:                     USE IN cursor_4c_ContaSel
2247:                 ENDIF
2248:             ENDIF
2249: 
2250:             IF loc_nSelecionados < 1
2251:                 MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Selecionado!!!", "Processamento")
2252:                 THIS.txt_4c_DtIni.SetFocus()
2253:                 RETURN
2254:             ENDIF
2255:         ENDIF
2256: 
2257:         DO CASE


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

