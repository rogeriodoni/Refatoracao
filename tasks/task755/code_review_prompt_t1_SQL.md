# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDOPNUMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCLR, DOPES, LNCNT, I, GRUPOS, ICLIS, RCLIS, JOBS, COLETORS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCLR, DOPES, LNCNT, I, GRUPOS, ICLIS, RCLIS, JOBS, COLETORS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCLR, DOPES, LNCNT, I, GRUPOS, ICLIS, RCLIS, JOBS, COLETORS

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
  ControlSource = "crSigMvJbC.Jb_001"
  ControlSource = "crSigMvJbC.Jb_002"
  ControlSource = "crSigMvJbC.Jb_003"
  ControlSource = "crSigMvJbC.Jb_004"
  ControlSource = "crSigMvJbC.Jb_005"
  ControlSource = "crSigMvJbC.Jb_006"
  ControlSource = "crSigMvJbC.Jb_007"
  ControlSource = "crSigMvJbC.Jb_008"
  ControlSource = "crSigMvJbC.Jb_017"
  ControlSource = "crSigMvJbC.Jb_018"
  ControlSource = "crSigMvJbC.Jb_019"
  ControlSource = "crSigMvJbC.Jb_020"
  ControlSource = "crSigMvJbC.Jb_021"
  ControlSource = "crSigMvJbC.Jb_022"
  ControlSource = "crSigMvJbC.Jb_023"
  ControlSource = "crSigMvJbC.Jb_009"
  ControlSource = "crSigMvJbC.Jb_010"
  ControlSource = "crSigMvJbC.Jb_011"
  ControlSource = "crSigMvJbC.Jb_012"
  ControlSource = "crSigMvJbC.Jb_013"
  ControlSource = "crSigMvJbC.Jb_014"
  ControlSource = "crSigMvJbC.Jb_015"
  ControlSource = "crSigMvJbC.Jb_016"
  ControlSource = "crSigMvJbC.Jb_024"
  ControlSource = "crSigMvJbC.Jb_025"
  ControlSource = "crSigMvJbC.Jb_028"
  ControlSource = "crSigMvJbC.Jb_026"
  ControlSource = "crSigMvJbC.Jb_029"
  ControlSource = "crSigMvJbC.Jb_027"
  ControlSource = "crSigMvJbC.Jb_030"
  ControlSource = "crSigMvJbC.Jb_038"
  ControlSource = "crSigMvJbC.Jb_039"
  ControlSource = "crSigMvJbC.Jb_040"
  ControlSource = "crSigMvJbC.Jb_041"
  ControlSource = "crSigMvJbC.Jb_042"
  ControlSource = "crSigMvJbC.Jb_043"
  ControlSource = "crSigMvJbC.Jb_044"
  ControlSource = "crSigMvJbC.Jb_031"
  ControlSource = "crSigMvJbC.Jb_032"
  ControlSource = "crSigMvJbC.Jb_035"
  ControlSource = "crSigMvJbC.Jb_033"
  ControlSource = "crSigMvJbC.Jb_036"
  ControlSource = "crSigMvJbC.Jb_034"
  ControlSource = "crSigMvJbC.Jb_037"
  ControlSource = "crSigMvJbC.Jb_045"
  ControlSource = "crSigMvJbC.Jb_046"
  ControlSource = "crSigMvJbC.Jb_047"
  ControlSource = "crSigMvJbC.Jb_048"
  ControlSource = "crSigMvJbC.Jb_061"
  ControlSource = "crSigMvJbC.Jb_058"
  ControlSource = "crSigMvJbC.Jb_063"
  ControlSource = "crSigMvJbC.Jb_064"
  ControlSource = "crSigMvJbC.Jb_065"
  ControlSource = "crSigMvJbC.Jb_066"
  ControlSource = "crSigMvJbC.Jb_067"
  ControlSource = "crSigMvJbC.Jb_068"
  ControlSource = "crSigMvJbC.Jb_069"
  ControlSource = "crSigMvJbC.Jb_071"
  ControlSource = "crSigMvJbC.Jb_062"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  ControlSource = "crSigMvJbC.Jb_070"
  ControlSource = "crSigMvJbC.Jb_075"
  ControlSource = "crSigMvJbC.Jb_051"
  ControlSource = "crSigMvJbC.Jb_052"
  ControlSource = "crSigMvJbC.Jb_053"
  ControlSource = "crSigMvJbC.Jb_054"
  ControlSource = "crSigMvJbC.Jb_055"
  ControlSource = "crSigMvJbC.Jb_056"
  ControlSource = "crSigMvJbC.Jb_049"
  ControlSource = "crSigMvJbC.Jb_050"
  ControlSource = "crSigMvJbC.Jb_057"
  ControlSource = "crSigMvJbC.Jb_073"
  ControlSource = "crSigMvJbC.Jb_074"
  ControlSource = "crSigMvJbC.Jb_072"
  ControlSource = "crSigMvJbC.Jb_Contatos"
lcQuery = [Select Jobs, Min(Datas) as Datas ] + ;
		    [From SigMvCab ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)
	.DeleteMark   = .f.
	.Column1.ControlSource = [crSigMvJbI.JBI_Fontes]
	.Column2.ControlSource = [crSigMvJbI.JBI_Modelos]
	.Column3.ControlSource = [crSigMvJbI.JBI_Autors]
	.Column4.ControlSource = [crSigMvJbI.JBI_Valors]
	Select * From crSigMvJbI ;
		Insert Into crSigMvJbI (EmpDopNums, pkChaves) Values (crSigMvJbC.EmpDopNums, fUniqueIds())
	Select LocalEmps
	lcQuery = [Select a.IClis, a.RClis ] + ;
			    [From SigCdCli a, SigCdGcr b ] + ;
	If (.poDataMgr.SqlExecute(lcQuery, [crEquipes]) < 1)
	Select crEquipes
	Delete From crSigMvJbI ;
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select crEquipes
Select EmpDopNums, Count(1) as Soma, Sum(JBI_Valors) as Valors ;
  From crSigMvJbI ;
		Insert Into crSigMvJbI (EmpDopNums, pkChaves) Values (crSigMvJbC.EmpDopNums, fUniqueIds())
Select * From crSigMvJbI ;
	Insert Into crSigMvJbI (EmpDopNums, pkChaves) Values (crSigMvJbC.EmpDopNums, fUniqueIds())
	Delete In crSigMvJbI

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpJob.prg) - TRECHOS RELEVANTES PARA PASS SQL (4334 linhas total):

*-- Linhas 197 a 242:
197:     *                   defaults declarados no BO (campos em branco).
198:     *
199:     * O legado nao precisa dessa distincao porque o TextBox ja esta ligado
200:     * por ControlSource ao cursor BUFFERED do form pai (sempre existe uma
201:     * linha, em branco ou nao, e o TableUpdate acontece quando o movimento
202:     * inteiro e salvo). Nesta arquitetura o BO grava com SQLEXEC explicito
203:     * em CmdRetornarClick, que exige this_lEmEdicao = .T. (BusinessBase.
204:     * Salvar() recusa gravar fora de edicao) e decide Inserir/Atualizar pelo
205:     * this_lNovoRegistro definido aqui.
206:     *
207:     * Sem conexao (modo de teste/validacao de UI) cai direto em
208:     * NovoRegistro() - ConexaoAtiva() ja devolve .F. nesse caso.
209:     *==========================================================================
210:     PROTECTED PROCEDURE CarregarOuIniciarRegistro()
211:         LOCAL loc_cSQL, loc_nResultado, loc_cAliasTmp, loc_oErro
212:         loc_cAliasTmp = "cursor_4c_JobTmp"
213: 
214:         TRY
215:             IF USED(loc_cAliasTmp)
216:                 USE IN (loc_cAliasTmp)
217:             ENDIF
218: 
219:             loc_nResultado = -1
220:             IF THIS.this_oBusinessObject.ConexaoAtiva()
221:                 loc_cSQL = "SELECT * FROM SigMvJbC WHERE empdopnums = " + ;
222:                     EscaparSQL(THIS.this_oBusinessObject.this_cEmpDopNums)
223:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)
224:             ENDIF
225: 
226:             IF loc_nResultado >= 0 AND USED(loc_cAliasTmp) AND RECCOUNT(loc_cAliasTmp) > 0
227:                 SELECT (loc_cAliasTmp)
228:                 GO TOP
229:                 THIS.this_oBusinessObject.CarregarDoCursor(loc_cAliasTmp)
230:                 THIS.this_oBusinessObject.EditarRegistro()
231:             ELSE
232:                 THIS.this_oBusinessObject.NovoRegistro()
233:             ENDIF
234: 
235:             IF USED(loc_cAliasTmp)
236:                 USE IN (loc_cAliasTmp)
237:             ENDIF
238:         CATCH TO loc_oErro
239:             MsgErro(loc_oErro.Message + CHR(13) + ;
240:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
241:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarOuIniciarRegistro")
242:         ENDTRY

*-- Linhas 652 a 673:
652:     * Nomes conforme tasks\task755\mapeamento.json.
653:     *
654:     * Cada linha tem DOIS TextBox, como no legado:
655:     *   get_01_0NNa (Left=2, Width=355)  - NOME da conta, SEM ControlSource no
656:     *                                      SCX (preenchido por codigo a partir
657:     *                                      de SigCdCli.RClis - char(50))
658:     *   get_01_0NN  (Left=360, Width=80) - CODIGO, ControlSource
659:     *                                      "crSigMvJbC.Jb_0NN" (char(10))
660:     * O MaxLength vem da LARGURA DA COLUNA no schema (10 e 50), NUNCA do
661:     * Width em pixels (regra #19).
662:     *
663:     * A ordem de tabulacao do legado entra no NOME antes do CODIGO
664:     * (get_01_024a TabIndex=3, get_01_024 TabIndex=4) - transcrita.
665:     *
666:     * Os lookups (Valid/fwBuscaInt sobre crEquipes nos dois campos de cada
667:     * linha) sao da fase de lookups; aqui entra a superficie de dados.
668:     *==========================================================================
669:     PROTECTED PROCEDURE ConfigurarAbaEquipes()
670:         LOCAL loc_oPag, loc_oCnt, loc_oErro
671:         TRY
672:             loc_oPag = THIS.pgf_4c_Job.Page3
673: 

*-- Linhas 1436 a 1482:
1436:     *
1437:     * O legado NAO busca em SigCdCli inteiro: o Init monta o cursor crEquipes
1438:     * com
1439:     *     Select a.IClis, a.RClis
1440:     *       From SigCdCli a, SigCdGcr b
1441:     *      Where a.Grupos = b.Codigos And b.Coletors = 8   && Atendimento
1442:     * e TODO Locate/fwBuscaInt das 14 linhas roda sobre esse cursor. O filtro
1443:     * eh REGRA DE NEGOCIO (so contas do grupo "Atendimento" podem ocupar os
1444:     * papeis de equipe) e eh transcrito aqui como condicao do 9o parametro
1445:     * (par_cFiltro) do FormBuscaAuxiliar - que o aplica nos TRES caminhos
1446:     * dele: match exato, LIKE prefixo e fallback show-all.
1447:     *
1448:     * Vai como subconsulta (nao JOIN) porque par_cFiltro eh colado dentro de
1449:     * um WHERE sobre uma tabela unica. Colunas conferidas em docs/schema.sql:
1450:     * SigCdCli.grupos char(10), SigCdGcr.codigos char(10),
1451:     * SigCdGcr.coletors numeric(2,0).
1452:     *==========================================================================
1453:     PROTECTED FUNCTION ObterFiltroContaEquipe()
1454:         RETURN "Grupos IN (SELECT Codigos FROM SigCdGcr WHERE Coletors = 8)"
1455:     ENDFUNC
1456: 
1457:     *==========================================================================
1458:     * AbrirLookupConta - Nucleo do lookup de conta (equipe) usado pelas 14
1459:     * linhas da Page3, nos DOIS sentidos que o legado tem.
1460:     *
1461:     * Equivale ao Valid de cada get_01_0NN (campo de CODIGO, par_cCampo =
1462:     * "Iclis") e ao Valid de cada get_01_0NNa (campo de NOME, par_cCampo =
1463:     * "Rclis"): o legado faz Locate em crEquipes pelo campo correspondente e,
1464:     * sem match (Eof), abre fwBuscaInt sobre o MESMO campo. Aqui o papel do
1465:     * crEquipes + fwBuscaInt eh feito pelo FormBuscaAuxiliar canonico (regras
1466:     * #36/#37), que ja executa o match EXATO no proprio Init - por isso NAO se
1467:     * duplica a checagem de existencia com um SQLEXEC proprio antes do picker.
1468:     *
1469:     * Os DOIS campos da linha sao escritos em qualquer um dos caminhos, como
1470:     * no legado (get_01_0NN.Value e get_01_0NNa.Value sao atribuidos juntos),
1471:     * e os dois sao limpos quando nada eh escolhido - transcricao do
1472:     * "If (Lastkey() <> 27) ... Else ... = [] / = [] / EndIf". Nao ha MsgAviso
1473:     * em nenhum ramo: o picker eh o proprio feedback (regra #50).
1474:     *
1475:     * Campo VAZIO nao abre picker: o legado abriria (Padr([],10) nunca casa em
1476:     * crEquipes), mas isso faz o dialogo subir a cada Tab por cada um dos 14
1477:     * papeis nao preenchidos. Mantido o guard de vazio, que eh o padrao do
1478:     * projeto para lookup em LostFocus (regras #47/#50) e ja era o
1479:     * comportamento desta tela.
1480:     *
1481:     * PUBLIC (BINDEVENT exige metodo publico - regra #3). Guarda de
1482:     * reentrancia: o picker eh MODAL, tira o foco do TextBox e redisparia o

*-- Linhas 1542 a 1560:
1542:                     ENDIF
1543: 
1544:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1545:                         SELECT cursor_4c_BuscaConta
1546:                         par_oTxtCod.Value  = ALLTRIM(TratarNulo(cursor_4c_BuscaConta.Iclis, ""))
1547:                         par_oTxtNome.Value = ALLTRIM(TratarNulo(cursor_4c_BuscaConta.Rclis, ""))
1548:                     ELSE
1549:                         *-- Legado: ESC / nada escolhido limpa os DOIS campos
1550:                         *-- da linha, nao so a descricao.
1551:                         par_oTxtCod.Value  = ""
1552:                         par_oTxtNome.Value = ""
1553:                     ENDIF
1554: 
1555:                     IF USED("cursor_4c_BuscaConta")
1556:                         USE IN cursor_4c_BuscaConta
1557:                     ENDIF
1558:                     loc_oBusca.Release()
1559:                 ENDIF
1560:             ENDIF

*-- Linhas 1816 a 1834:
1816:     * ConfigurarTiposProjeto - Blocos "Tipo de Projeto" (Jb_038..041) e "Tipo
1817:     * de Desenvolvimento" (Jb_042..044) da Page3, abaixo da linha divisoria.
1818:     * Sao CheckBoxes independentes no legado (nao OptionGroup): o SCX declara
1819:     * sete checkbox separados, cada um com ControlSource proprio em coluna
1820:     * numeric(1,0) de SigMvJbC - mais de um pode ficar marcado.
1821:     * Posicoes EXATAS do dump.
1822:     *==========================================================================
1823:     PROTECTED PROCEDURE ConfigurarTiposProjeto(par_oPag)
1824:         *-- Tipo de Projeto (coluna da esquerda)
1825:         THIS.AdicionarRotuloSecao(par_oPag, "lbl_4c_Lbl_02_003", 326, 26, 100, ;
1826:             "Tipo de Projeto", 45)
1827:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_038", "lbl_4c_Lbl_01_038", ;
1828:             350, 26, 44, 110, "Pedido do Cliente", 46, 47)
1829:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_039", "lbl_4c_Lbl_01_039", ;
1830:             369, 26, 44, 85, "Concorr" + CHR(234) + "ncia", 48, 49)
1831:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_040", "lbl_4c_Lbl_01_040", ;
1832:             389, 26, 44, 70, "Licita" + CHR(231) + CHR(227) + "o", 50, 51)
1833:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_041", "lbl_4c_Lbl_01_041", ;
1834:             408, 26, 44, 85, "Propriet" + CHR(225) + "rio", 52, 53)

*-- Linhas 2547 a 2565:
2547:                 .Value = {}
2548:             ENDWITH
2549: 
2550:             *-- "Briefing Extra" (CheckBox + rotulo). ControlSource legado
2551:             *-- "crSigMvJbC.Jb_072" - mapeado por BOParaForm/FormParaBO.
2552:             *-- O AutoSize = .T. do dump NAO eh transcrito: em CheckBox criado
2553:             *-- por AddObject ele eh no-op (a caixa ficaria nos 100x17 do
2554:             *-- default e cobriria o rotulo ao lado) - Width/Height explicitos.
2555:             THIS.AddObject("chk_4c_Get_Extra", "CheckBox")
2556:             WITH THIS.chk_4c_Get_Extra
2557:                 .Top = 104
2558:                 .Left = 102
2559:                 .Width = 16
2560:                 .Height = 17
2561:                 .Alignment = 0
2562:                 .AutoSize = .F.
2563:                 .BackStyle = 0
2564:                 .SpecialEffect = 1
2565:                 .Themes = .T.

*-- Linhas 2604 a 2622:
2604:             ENDWITH
2605: 
2606:             *-- ATENCAO - divergencia de BANCO, nao de migracao (regra #14/#45):
2607:             *-- o SCX legado liga este EditBox a ControlSource
2608:             *-- "crSigMvJbC.Jb_Contatos", e essa coluna NAO EXISTE no schema
2609:             *-- canonico. Medido em docs\schema.sql: SigMvJbC tem 77 colunas -
2610:             *-- empdopnums, jb_001..jb_075 e jb_contato (datetime); nao existe
2611:             *-- jb_contatos de texto. O dump do form eh mais novo que o banco.
2612:             *-- O campo eh reproduzido para a tela ficar fiel ao legado
2613:             *-- (PILAR 1), mas NAO eh persistido: criar a coluna violaria o
2614:             *-- PILAR 2 (schema identico) e apontar para jb_contato (datetime)
2615:             *-- gravaria texto no campo errado. A ausencia fica VISIVEL aqui de
2616:             *-- proposito, em vez de ser mascarada por um binding inventado.
2617:             THIS.AddObject("obj_4c_GetCabContatos", "EditBox")
2618:             WITH THIS.obj_4c_GetCabContatos
2619:                 .Top = 18
2620:                 .Left = 396
2621:                 .Width = 494
2622:                 .Height = 106

*-- Linhas 2692 a 2719:
2692:     * e os totalizadores txt_4c_TotFontes/txt_4c_TotValores (somente leitura).
2693:     *
2694:     * O cursor placeholder nasce ANTES do Grid (regra #41) com a MESMA ordem
2695:     * de colunas do SELECT feito por SigOpJobBO.CarregarFontes(), para o
2696:     * rebind em CarregarLista() nao reordenar nada.
2697:     *==========================================================================
2698:     PROTECTED PROCEDURE ConfigurarGridFontes()
2699:         LOCAL loc_oPagina, loc_oErro
2700:         TRY
2701:             IF USED("cursor_4c_Fontes")
2702:                 USE IN cursor_4c_Fontes
2703:             ENDIF
2704:             CREATE CURSOR cursor_4c_Fontes ;
2705:                 (empdopnums C(29), jbi_autors C(20), jbi_fontes C(50), ;
2706:                  jbi_modelos C(30), jbi_valors N(11,2), pkchaves C(20))
2707: 
2708:             loc_oPagina = THIS.pgf_4c_Job.Page5
2709: 
2710:             loc_oPagina.AddObject("lbl_4c_Lbl_02_010", "Label")
2711:             WITH loc_oPagina.lbl_4c_Lbl_02_010
2712:                 .Top       = 199
2713:                 .Left      = 13
2714:                 .Width     = 200
2715:                 .Height    = 15
2716:                 .Alignment = 0
2717:                 .AutoSize  = .F.
2718:                 .BackStyle = 0
2719:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 2739 a 2757:
2739:                 .Width             = 928
2740:                 .Height            = 203
2741:                 .ColumnCount       = 4
2742:                 .DeleteMark        = .F.
2743:                 .RecordMark        = .F.
2744:                 .GridLines         = 3
2745:                 .GridLineWidth     = 1
2746:                 .GridLineColor     = RGB(238, 238, 238)
2747:                 .HeaderHeight      = 20
2748:                 .ScrollBars        = 2
2749:                 .AllowHeaderSizing = .F.
2750:                 .AllowRowSizing    = .F.
2751:                 .ReadOnly          = .F.
2752:                 .Visible           = .T.
2753: 
2754:                 .Column1.Movable   = .F.
2755:                 .Column1.Resizable = .F.
2756:                 .Column1.ReadOnly  = .F.
2757:                 .Column1.Width     = 360

*-- Linhas 2887 a 2905:
2887: 
2888:     *==========================================================================
2889:     * CarregarLista - Carrega SigMvJbI (via BO.CarregarFontes) na grade
2890:     * "Fontes Pagadoras" e rebinda RecordSource/ControlSource/Width/Header -
2891:     * RecordSource RESETA essas propriedades (Problema 48), por isso sao
2892:     * reaplicadas aqui, depois do load (legado: PROCEDURE montagrades).
2893:     *
2894:     * Em modo INCLUIR/ALTERAR garante ao menos 1 linha em branco (mesma
2895:     * logica do btnInserir.Click) e exibe os botoes de Inserir/Excluir;
2896:     * em VISUALIZAR eles ficam ocultos e a grade some de edicao via o
2897:     * guard de GrdFontesColumnWhen.
2898:     *
2899:     * PUBLIC de proposito: este e' o FUNIL de carga da lista deste dialogo
2900:     * (a grade "Fontes Pagadoras" e' a unica lista que o SCX legado tem), e
2901:     * o harness de teste chama THIS.oForm.CarregarLista() de FORA da classe
2902:     * - PEMSTATUS devolve .T. para metodo PROTECTED, entao o teste entraria
2903:     * no branch e a chamada estouraria em runtime (regra #3).
2904:     *==========================================================================
2905:     PROCEDURE CarregarLista()

*-- Linhas 2918 a 2962:
2918:                 WITH loc_oGrid
2919:                     .RecordSource = loc_cAlias
2920: 
2921:                     .Column1.ControlSource   = loc_cAlias + ".jbi_fontes"
2922:                     .Column1.Width           = 360
2923:                     .Column1.Header1.Caption = "Cliente"
2924: 
2925:                     .Column2.ControlSource   = loc_cAlias + ".jbi_modelos"
2926:                     .Column2.Width           = 220
2927:                     .Column2.Header1.Caption = "Modelo Fiscal"
2928: 
2929:                     .Column3.ControlSource   = loc_cAlias + ".jbi_autors"
2930:                     .Column3.Width           = 150
2931:                     .Column3.Header1.Caption = "N" + CHR(250) + "mero Incentivo"
2932: 
2933:                     .Column4.ControlSource   = loc_cAlias + ".jbi_valors"
2934:                     .Column4.Width           = 174
2935:                     .Column4.Header1.Caption = "Valor"
2936:                 ENDWITH
2937: 
2938:                 SELECT (loc_cAlias)
2939:                 GO TOP
2940: 
2941:                 THIS.pgf_4c_Job.Page5.cmd_4c_BtnInserir.Visible = .F.
2942:                 THIS.pgf_4c_Job.Page5.cmd_4c_BtnExcluir.Visible = .F.
2943: 
2944:                 IF loc_lModoEdicao
2945:                     LOCATE FOR EMPTY(jbi_fontes) AND EMPTY(jbi_modelos)
2946:                     IF !FOUND()
2947:                         INSERT INTO (loc_cAlias) (empdopnums, pkchaves) VALUES ;
2948:                             (THIS.this_oBusinessObject.this_cEmpDopNums, fUniqueIds())
2949:                     ENDIF
2950:                     GO BOTTOM
2951: 
2952:                     THIS.pgf_4c_Job.Page5.cmd_4c_BtnInserir.Visible = .T.
2953:                     THIS.pgf_4c_Job.Page5.cmd_4c_BtnExcluir.Visible = .T.
2954:                 ENDIF
2955: 
2956:                 loc_oGrid.Refresh()
2957:                 THIS.GrdFontesAfterRowColChange(1)
2958:             ENDIF
2959:         CATCH TO loc_oErro
2960:             MsgErro(loc_oErro.Message + CHR(13) + ;
2961:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2962:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")

*-- Linhas 3018 a 3036:
3018:     * mdadosequipes do SCX legado, que para cada Jb_024..037 nao vazio faz
3019:     * CursorQuery em SigCdCli e joga RClis no campo "a").
3020:     *
3021:     * O legado NAO tem ControlSource nos campos "a": eles sao preenchidos por
3022:     * codigo, e eh isso que se reproduz aqui.
3023:     *==========================================================================
3024:     PROTECTED PROCEDURE CarregarNomesEquipes()
3025:         LOCAL loc_oBO, loc_oCnt1, loc_oCnt2, loc_oErro
3026: 
3027:         TRY
3028:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3029:                 loc_oBO   = THIS.this_oBusinessObject
3030:                 loc_oCnt1 = THIS.pgf_4c_Job.Page3.cnt_4c_Emp1
3031:                 loc_oCnt2 = THIS.pgf_4c_Job.Page3.cnt_4c_Emp2
3032: 
3033:                 loc_oCnt1.txt_4c__01_024a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb024)
3034:                 loc_oCnt1.txt_4c__01_025a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb025)
3035:                 loc_oCnt1.txt_4c__01_026a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb026)
3036:                 loc_oCnt1.txt_4c__01_027a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb027)

*-- Linhas 3101 a 3123:
3101:             RETURN .T.
3102:         ENDIF
3103: 
3104:         SELECT (loc_cAlias)
3105:         IF !EMPTY(jbi_fontes) AND !EMPTY(jbi_modelos) AND !EOF()
3106:             SKIP
3107:             IF EOF()
3108:                 INSERT INTO (loc_cAlias) (empdopnums, pkchaves) VALUES ;
3109:                     (THIS.this_oBusinessObject.this_cEmpDopNums, fUniqueIds())
3110:             ENDIF
3111:         ENDIF
3112: 
3113:         GO TOP
3114:         THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3115:         GO BOTTOM
3116: 
3117:         RETURN .T.
3118:     ENDPROC
3119: 
3120:     *==========================================================================
3121:     * BtnInserirClick - Insere linha em branco na grade "Fontes Pagadoras"
3122:     * (legado: pgPagina5.btnInserir.Click). So reutiliza linha ja vazia
3123:     * (JBI_Fontes e JBI_Modelos vazios); senao cria uma nova com pkChaves

*-- Linhas 3144 a 3185:
3144:             ENDIF
3145: 
3146:             IF loc_lProsseguir
3147:                 SELECT (loc_cAlias)
3148:                 LOCATE FOR EMPTY(jbi_fontes) AND EMPTY(jbi_modelos)
3149:                 IF !FOUND()
3150:                     INSERT INTO (loc_cAlias) (empdopnums, pkchaves) VALUES ;
3151:                         (THIS.this_oBusinessObject.this_cEmpDopNums, fUniqueIds())
3152:                 ENDIF
3153: 
3154:                 SELECT (loc_cAlias)
3155:                 GO TOP
3156:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3157:                 GO BOTTOM
3158:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.SetFocus()
3159:                 THIS.GrdFontesAfterRowColChange(1)
3160:             ENDIF
3161:         CATCH TO loc_oErro
3162:             MsgErro(loc_oErro.Message + CHR(13) + ;
3163:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3164:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnInserirClick")
3165:         ENDTRY
3166:     ENDPROC
3167: 
3168:     *==========================================================================
3169:     * BtnExcluirClick - Exclui a linha corrente da grade "Fontes Pagadoras"
3170:     * (legado: pgPagina5.btnExcluir.Click). DELETE sem PACK - SET DELETED ON
3171:     * (config.prg) ja tira a linha da visao do Grid.
3172:     *==========================================================================
3173:     PROCEDURE BtnExcluirClick()
3174:         *-- Guardas por FLAG, nunca RETURN - ver comentario de BtnInserirClick
3175:         *-- (regra #1). Aqui o RETURN era ainda mais perigoso: ele ficava
3176:         *-- ANTES do LockScreen = .T., mas o estouro em runtime deixaria o
3177:         *-- metodo pelo CATCH, que repoe LockScreen = .F.
3178:         LOCAL loc_cAlias, loc_nRec, loc_lProsseguir, loc_oErro
3179:         loc_lProsseguir = .T.
3180: 
3181:         TRY
3182:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
3183:                 loc_lProsseguir = .F.
3184:             ENDIF
3185: 

*-- Linhas 3193 a 3214:
3193:             IF loc_lProsseguir
3194:                 THIS.LockScreen = .T.
3195: 
3196:                 SELECT (loc_cAlias)
3197:                 loc_nRec = RECNO()
3198:                 IF !EOF()
3199:                     DELETE
3200:                 ENDIF
3201: 
3202:                 GO TOP
3203:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3204:                 IF BETWEEN(loc_nRec, 1, RECCOUNT())
3205:                     GO (loc_nRec)
3206:                 ELSE
3207:                     GO BOTTOM
3208:                 ENDIF
3209:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3210:                 THIS.GrdFontesAfterRowColChange(1)
3211: 
3212:                 THIS.LockScreen = .F.
3213:             ENDIF
3214:         CATCH TO loc_oErro

*-- Linhas 3223 a 3241:
3223:     * GrdFontesAfterRowColChange - Recalcula os totalizadores da grade.
3224:     * Uso legitimo de AfterRowColChange (regra #46): nao valida CELULA, so
3225:     * agrega o cursor inteiro - igual ao legado, que tambem chama este
3226:     * evento manualmente apos cada INSERT/DELETE/GO (nao confia em disparo
3227:     * automatico do Grid para recalculo).
3228:     *==========================================================================
3229:     PROCEDURE GrdFontesAfterRowColChange(par_nColIndex)
3230:         THIS.RecalcularTotaisFontes()
3231:     ENDPROC
3232: 
3233:     *==========================================================================
3234:     * RecalcularTotaisFontes - Soma Count(1)/Sum(JBI_Valors) por EmpDopNums,
3235:     * igual ao legado (grdFontes.AfterRowColChange), e espelha nos
3236:     * totalizadores txt_4c_TotFontes/txt_4c_TotValores.
3237:     *==========================================================================
3238:     PROCEDURE RecalcularTotaisFontes()
3239:         LOCAL loc_cAlias, loc_nSoma, loc_nValors, loc_oErro
3240: 
3241:         IF VARTYPE(THIS.this_oBusinessObject) != "O"

*-- Linhas 3248 a 3267:
3248:         ENDIF
3249: 
3250:         TRY
3251:             SELECT empdopnums, COUNT(1) AS Soma, SUM(jbi_valors) AS Valors ;
3252:                 FROM (loc_cAlias) ;
3253:                 GROUP BY empdopnums ;
3254:                 INTO CURSOR cursor_4c_FontesTot
3255: 
3256:             IF RECCOUNT("cursor_4c_FontesTot") > 0
3257:                 GO TOP IN cursor_4c_FontesTot
3258:                 loc_nSoma   = cursor_4c_FontesTot.Soma
3259:                 loc_nValors = cursor_4c_FontesTot.Valors
3260:             ELSE
3261:                 loc_nSoma   = 0
3262:                 loc_nValors = 0
3263:             ENDIF
3264: 
3265:             IF USED("cursor_4c_FontesTot")
3266:                 USE IN cursor_4c_FontesTot
3267:             ENDIF

*-- Linhas 3357 a 3375:
3357:             loc_oPag3.chk_4c_Get_01_043.Value = IIF(loc_oBO.this_nJb043 = 1, 1, 0)
3358:             loc_oPag3.chk_4c_Get_01_044.Value = IIF(loc_oBO.this_nJb044 = 1, 1, 0)
3359: 
3360:             *-- Os campos de NOME da Page3 nao tem ControlSource no legado:
3361:             *-- vem de SigCdCli.RClis pelo codigo de cada linha.
3362:             THIS.CarregarNomesEquipes()
3363: 
3364:             *-- Page4 - Materiais de Apoio (caminhos de pasta/arquivo)
3365:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_045.Value = loc_oBO.this_cJb045
3366:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_046.Value = loc_oBO.this_cJb046
3367:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_047.Value = loc_oBO.this_cJb047
3368:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_048.Value = loc_oBO.this_cJb048
3369:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_061.Value = loc_oBO.this_cJb061
3370:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_058.Value = loc_oBO.this_cJb058
3371: 
3372:             *-- Page5 - Modelo Fiscal / Fontes Pagadoras
3373:             THIS.pgf_4c_Job.Page5.obj_4c_Get_01_062.Value = loc_oBO.this_cJb062
3374:             THIS.pgf_4c_Job.Page5.chk_4c_Get_01_063.Value = IIF(loc_oBO.this_nJb063 = 1, 1, 0)
3375:             THIS.pgf_4c_Job.Page5.chk_4c_Get_01_064.Value = IIF(loc_oBO.this_nJb064 = 1, 1, 0)

*-- Linhas 3516 a 3536:
3516:             *-- Page3 - Equipes (codigos) e classificacao do Job.
3517:             *-- Apenas os campos de CODIGO voltam para o BO: os campos de NOME
3518:             *-- (txt_4c__01_0NNa) nao tem coluna em SigMvJbC - no legado
3519:             *-- tambem nao tem ControlSource, sao exibicao de SigCdCli.RClis.
3520:             *-- As colunas Jb_024..037 sao char(10) NOT NULL: ALLTRIM aqui
3521:             *-- (o SQL Server faz blank-padding ANSI em char) e o INSERT/UPDATE
3522:             *-- do BO fecha com PADR(..., 10), o MESMO tamanho do .MaxLength
3523:             *-- destes TextBox.
3524:             loc_oPag3 = THIS.pgf_4c_Job.Page3
3525:             loc_oCnt1 = loc_oPag3.cnt_4c_Emp1
3526:             loc_oCnt2 = loc_oPag3.cnt_4c_Emp2
3527: 
3528:             loc_oBO.this_cJb024 = ALLTRIM(loc_oCnt1.txt_4c__01_024.Value)
3529:             loc_oBO.this_cJb025 = ALLTRIM(loc_oCnt1.txt_4c__01_025.Value)
3530:             loc_oBO.this_cJb026 = ALLTRIM(loc_oCnt1.txt_4c__01_026.Value)
3531:             loc_oBO.this_cJb027 = ALLTRIM(loc_oCnt1.txt_4c__01_027.Value)
3532:             loc_oBO.this_cJb028 = ALLTRIM(loc_oCnt1.txt_4c__01_028.Value)
3533:             loc_oBO.this_cJb029 = ALLTRIM(loc_oCnt1.txt_4c__01_029.Value)
3534:             loc_oBO.this_cJb030 = ALLTRIM(loc_oCnt1.txt_4c__01_030.Value)
3535: 
3536:             loc_oBO.this_cJb031 = ALLTRIM(loc_oCnt2.txt_4c__01_031.Value)

*-- Linhas 3713 a 3731:
3713:     *
3714:     * Le o CONTROLE, nao a property do BO, porque ChecarCamposObrigatorios
3715:     * roda a cada LostFocus - ANTES de FormParaBO - e a property ainda tem o
3716:     * valor anterior. No legado o TextBox tem ControlSource para o cursor
3717:     * buffered, entao ler o cursor ja era ler o valor na tela; aqui o
3718:     * equivalente fiel e' ler o proprio controle.
3719:     *
3720:     * Controle ausente devolve .T. (nao bloqueia): mesma postura do legado,
3721:     * que nem chega a testar indice cujo laCpo esta vazio.
3722:     *==========================================================================
3723:     PROTECTED FUNCTION CampoPreenchido(par_cCaminho)
3724:         LOCAL loc_oCtrl, loc_uValor
3725: 
3726:         loc_oCtrl = THIS.ResolverControle(par_cCaminho)
3727:         IF VARTYPE(loc_oCtrl) != "O"
3728:             RETURN .T.
3729:         ENDIF
3730:         IF !PEMSTATUS(loc_oCtrl, "Value", 5)
3731:             RETURN .T.

*-- Linhas 4236 a 4261:
4236:     * CmdRetornarClick - Fecha o dialogo de Complementos do Job (legado:
4237:     * SIGOPJOB.cmdRetornar.btnRetornar.Click). Em INCLUIR/ALTERAR, ANTES de
4238:     * fechar: remove da grade "Fontes Pagadoras" as linhas em branco deixadas
4239:     * pela edicao - transcricao de "Delete From crSigMvJbI Where Empty(
4240:     * JBI_Fontes) Or Empty(JBI_Modelos)" - e GRAVA o complemento (FormParaBO +
4241:     * BO.Salvar() + BO.PersistirFontes()).
4242:     *
4243:     * O legado nao precisa gravar aqui: o TextBox ja esta ligado por
4244:     * ControlSource ao cursor BUFFERED do form pai, e o TableUpdate acontece
4245:     * quando o movimento inteiro e salvo (fora deste dialogo). Nesta
4246:     * arquitetura em camadas o BO grava com SQLEXEC explicito, e so ha um
4247:     * ponto de saida (Retornar) para persistir - fechar sem gravar perderia
4248:     * tudo o que foi digitado. Em VISUALIZAR fecha direto, sem gravar nada
4249:     * (igual ao legado, que tambem so limpa a grade e fecha).
4250:     *
4251:     * Se Salvar()/PersistirFontes() falhar, o dialogo NAO fecha (a falha ja
4252:     * foi exibida pelo proprio BO - regra "CATCH nunca silencioso" /
4253:     * "ExibirFalha") e o usuario pode corrigir e tentar de novo.
4254:     *
4255:     * PUBLIC (BINDEVENT exige - regra #3). THIS.Release() dispara Destroy()
4256:     * na cadeia de heranca, que reabilita THIS.this_oFormPai (equivalente ao
4257:     * "PROCEDURE Release / ThisForm.ParentForm.Enabled = .t." do SCX legado).
4258:     *==========================================================================
4259:     PROCEDURE CmdRetornarClick()
4260:         LOCAL loc_cAlias, loc_lEmEdicao, loc_lSalvou, loc_lProsseguir, loc_oErro
4261:         loc_lEmEdicao   = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

*-- Linhas 4293 a 4312:
4293:             IF loc_lEmEdicao AND VARTYPE(THIS.this_oBusinessObject) = "O"
4294:                 loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
4295:                 IF USED(loc_cAlias)
4296:                     SELECT (loc_cAlias)
4297:                     DELETE FOR EMPTY(jbi_fontes) OR EMPTY(jbi_modelos)
4298:                     GO BOTTOM
4299:                 ENDIF
4300: 
4301:                 THIS.FormParaBO()
4302: 
4303:                 loc_lSalvou = THIS.this_oBusinessObject.Salvar()
4304:                 IF loc_lSalvou
4305:                     loc_lSalvou = THIS.this_oBusinessObject.PersistirFontes()
4306:                 ENDIF
4307:             ENDIF
4308:         CATCH TO loc_oErro
4309:             loc_lSalvou = .F.
4310:             MsgErro(loc_oErro.Message + CHR(13) + ;
4311:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4312:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdRetornarClick")

