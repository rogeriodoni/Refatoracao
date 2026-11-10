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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpJob.prg) - TRECHOS RELEVANTES PARA PASS SQL (4416 linhas total):

*-- Linhas 64 a 82:
64:     *-- acima): LostFocus dispara SEMPRE que o foco sai do campo, mas o
65:     *-- Valid do legado (get_01_0NN/get_01_0NNa) so dispara quando o valor
66:     *-- MUDA. Sem isto, tabular pelas 14 linhas de equipe sem digitar nada
67:     *-- reabriria o lookup (ou repetiria o SQLEXEC do match exato) a cada
68:     *-- saida de campo. Uma property por LINHA (nao por campo): o par
69:     *-- codigo+nome da mesma linha compartilha o guard, igual ao padrao
70:     *-- de FormSigOpIpE.ValidarOcorrenciaEtiqueta (codigo+descricao
71:     *-- combinados com "|").
72:     this_cUltimoValidarConta024Validado = ""
73:     this_cUltimoValidarConta025Validado = ""
74:     this_cUltimoValidarConta026Validado = ""
75:     this_cUltimoValidarConta027Validado = ""
76:     this_cUltimoValidarConta028Validado = ""
77:     this_cUltimoValidarConta029Validado = ""
78:     this_cUltimoValidarConta030Validado = ""
79:     this_cUltimoValidarConta031Validado = ""
80:     this_cUltimoValidarConta032Validado = ""
81:     this_cUltimoValidarConta033Validado = ""
82:     this_cUltimoValidarConta034Validado = ""

*-- Linhas 221 a 266:
221:     *                   defaults declarados no BO (campos em branco).
222:     *
223:     * O legado nao precisa dessa distincao porque o TextBox ja esta ligado
224:     * por ControlSource ao cursor BUFFERED do form pai (sempre existe uma
225:     * linha, em branco ou nao, e o TableUpdate acontece quando o movimento
226:     * inteiro e salvo). Nesta arquitetura o BO grava com SQLEXEC explicito
227:     * em CmdRetornarClick, que exige this_lEmEdicao = .T. (BusinessBase.
228:     * Salvar() recusa gravar fora de edicao) e decide Inserir/Atualizar pelo
229:     * this_lNovoRegistro definido aqui.
230:     *
231:     * Sem conexao (modo de teste/validacao de UI) cai direto em
232:     * NovoRegistro() - ConexaoAtiva() ja devolve .F. nesse caso.
233:     *==========================================================================
234:     PROTECTED PROCEDURE CarregarOuIniciarRegistro()
235:         LOCAL loc_cSQL, loc_nResultado, loc_cAliasTmp, loc_oErro
236:         loc_cAliasTmp = "cursor_4c_JobTmp"
237: 
238:         TRY
239:             IF USED(loc_cAliasTmp)
240:                 USE IN (loc_cAliasTmp)
241:             ENDIF
242: 
243:             loc_nResultado = -1
244:             IF THIS.this_oBusinessObject.ConexaoAtiva()
245:                 loc_cSQL = "SELECT * FROM SigMvJbC WHERE empdopnums = " + ;
246:                     EscaparSQL(THIS.this_oBusinessObject.this_cEmpDopNums)
247:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)
248:             ENDIF
249: 
250:             IF loc_nResultado >= 0 AND USED(loc_cAliasTmp) AND RECCOUNT(loc_cAliasTmp) > 0
251:                 SELECT (loc_cAliasTmp)
252:                 GO TOP
253:                 THIS.this_oBusinessObject.CarregarDoCursor(loc_cAliasTmp)
254:                 THIS.this_oBusinessObject.EditarRegistro()
255:             ELSE
256:                 THIS.this_oBusinessObject.NovoRegistro()
257:             ENDIF
258: 
259:             IF USED(loc_cAliasTmp)
260:                 USE IN (loc_cAliasTmp)
261:             ENDIF
262:         CATCH TO loc_oErro
263:             MsgErro(loc_oErro.Message + CHR(13) + ;
264:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
265:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarOuIniciarRegistro")
266:         ENDTRY

*-- Linhas 676 a 697:
676:     * Nomes conforme tasks\task755\mapeamento.json.
677:     *
678:     * Cada linha tem DOIS TextBox, como no legado:
679:     *   get_01_0NNa (Left=2, Width=355)  - NOME da conta, SEM ControlSource no
680:     *                                      SCX (preenchido por codigo a partir
681:     *                                      de SigCdCli.RClis - char(50))
682:     *   get_01_0NN  (Left=360, Width=80) - CODIGO, ControlSource
683:     *                                      "crSigMvJbC.Jb_0NN" (char(10))
684:     * O MaxLength vem da LARGURA DA COLUNA no schema (10 e 50), NUNCA do
685:     * Width em pixels (regra #19).
686:     *
687:     * A ordem de tabulacao do legado entra no NOME antes do CODIGO
688:     * (get_01_024a TabIndex=3, get_01_024 TabIndex=4) - transcrita.
689:     *
690:     * Os lookups (Valid/fwBuscaInt sobre crEquipes nos dois campos de cada
691:     * linha) sao da fase de lookups; aqui entra a superficie de dados.
692:     *==========================================================================
693:     PROTECTED PROCEDURE ConfigurarAbaEquipes()
694:         LOCAL loc_oPag, loc_oCnt, loc_oErro
695:         TRY
696:             loc_oPag = THIS.pgf_4c_Job.Page3
697: 

*-- Linhas 1460 a 1506:
1460:     *
1461:     * O legado NAO busca em SigCdCli inteiro: o Init monta o cursor crEquipes
1462:     * com
1463:     *     Select a.IClis, a.RClis
1464:     *       From SigCdCli a, SigCdGcr b
1465:     *      Where a.Grupos = b.Codigos And b.Coletors = 8   && Atendimento
1466:     * e TODO Locate/fwBuscaInt das 14 linhas roda sobre esse cursor. O filtro
1467:     * eh REGRA DE NEGOCIO (so contas do grupo "Atendimento" podem ocupar os
1468:     * papeis de equipe) e eh transcrito aqui como condicao do 9o parametro
1469:     * (par_cFiltro) do FormBuscaAuxiliar - que o aplica nos TRES caminhos
1470:     * dele: match exato, LIKE prefixo e fallback show-all.
1471:     *
1472:     * Vai como subconsulta (nao JOIN) porque par_cFiltro eh colado dentro de
1473:     * um WHERE sobre uma tabela unica. Colunas conferidas em docs/schema.sql:
1474:     * SigCdCli.grupos char(10), SigCdGcr.codigos char(10),
1475:     * SigCdGcr.coletors numeric(2,0).
1476:     *==========================================================================
1477:     PROTECTED FUNCTION ObterFiltroContaEquipe()
1478:         RETURN "Grupos IN (SELECT Codigos FROM SigCdGcr WHERE Coletors = 8)"
1479:     ENDFUNC
1480: 
1481:     *==========================================================================
1482:     * AbrirLookupConta - Nucleo do lookup de conta (equipe) usado pelas 14
1483:     * linhas da Page3, nos DOIS sentidos que o legado tem.
1484:     *
1485:     * Equivale ao Valid de cada get_01_0NN (campo de CODIGO, par_cCampo =
1486:     * "Iclis") e ao Valid de cada get_01_0NNa (campo de NOME, par_cCampo =
1487:     * "Rclis"): o legado faz Locate em crEquipes pelo campo correspondente e,
1488:     * sem match (Eof), abre fwBuscaInt sobre o MESMO campo. Aqui o papel do
1489:     * crEquipes + fwBuscaInt eh feito pelo FormBuscaAuxiliar canonico (regras
1490:     * #36/#37), que ja executa o match EXATO no proprio Init - por isso NAO se
1491:     * duplica a checagem de existencia com um SQLEXEC proprio antes do picker.
1492:     *
1493:     * Os DOIS campos da linha sao escritos em qualquer um dos caminhos, como
1494:     * no legado (get_01_0NN.Value e get_01_0NNa.Value sao atribuidos juntos),
1495:     * e os dois sao limpos quando nada eh escolhido - transcricao do
1496:     * "If (Lastkey() <> 27) ... Else ... = [] / = [] / EndIf". Nao ha MsgAviso
1497:     * em nenhum ramo: o picker eh o proprio feedback (regra #50).
1498:     *
1499:     * Campo VAZIO nao abre picker: o legado abriria (Padr([],10) nunca casa em
1500:     * crEquipes), mas isso faz o dialogo subir a cada Tab por cada um dos 14
1501:     * papeis nao preenchidos. Mantido o guard de vazio, que eh o padrao do
1502:     * projeto para lookup em LostFocus (regras #47/#50) e ja era o
1503:     * comportamento desta tela.
1504:     *
1505:     * PUBLIC (BINDEVENT exige metodo publico - regra #3). Guarda de
1506:     * reentrancia: o picker eh MODAL, tira o foco do TextBox e redisparia o

*-- Linhas 1566 a 1584:
1566:                     ENDIF
1567: 
1568:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1569:                         SELECT cursor_4c_BuscaConta
1570:                         par_oTxtCod.Value  = ALLTRIM(TratarNulo(cursor_4c_BuscaConta.Iclis, ""))
1571:                         par_oTxtNome.Value = ALLTRIM(TratarNulo(cursor_4c_BuscaConta.Rclis, ""))
1572:                     ELSE
1573:                         *-- Legado: ESC / nada escolhido limpa os DOIS campos
1574:                         *-- da linha, nao so a descricao.
1575:                         par_oTxtCod.Value  = ""
1576:                         par_oTxtNome.Value = ""
1577:                     ENDIF
1578: 
1579:                     IF USED("cursor_4c_BuscaConta")
1580:                         USE IN cursor_4c_BuscaConta
1581:                     ENDIF
1582:                     loc_oBusca.Release()
1583:                 ENDIF
1584:             ENDIF

*-- Linhas 1896 a 1914:
1896:     * ConfigurarTiposProjeto - Blocos "Tipo de Projeto" (Jb_038..041) e "Tipo
1897:     * de Desenvolvimento" (Jb_042..044) da Page3, abaixo da linha divisoria.
1898:     * Sao CheckBoxes independentes no legado (nao OptionGroup): o SCX declara
1899:     * sete checkbox separados, cada um com ControlSource proprio em coluna
1900:     * numeric(1,0) de SigMvJbC - mais de um pode ficar marcado.
1901:     * Posicoes EXATAS do dump.
1902:     *==========================================================================
1903:     PROTECTED PROCEDURE ConfigurarTiposProjeto(par_oPag)
1904:         *-- Tipo de Projeto (coluna da esquerda)
1905:         THIS.AdicionarRotuloSecao(par_oPag, "lbl_4c_Lbl_02_003", 326, 26, 100, ;
1906:             "Tipo de Projeto", 45)
1907:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_038", "lbl_4c_Lbl_01_038", ;
1908:             350, 26, 44, 110, "Pedido do Cliente", 46, 47)
1909:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_039", "lbl_4c_Lbl_01_039", ;
1910:             369, 26, 44, 85, "Concorr" + CHR(234) + "ncia", 48, 49)
1911:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_040", "lbl_4c_Lbl_01_040", ;
1912:             389, 26, 44, 70, "Licita" + CHR(231) + CHR(227) + "o", 50, 51)
1913:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_041", "lbl_4c_Lbl_01_041", ;
1914:             408, 26, 44, 85, "Propriet" + CHR(225) + "rio", 52, 53)

*-- Linhas 2627 a 2645:
2627:                 .Value = {}
2628:             ENDWITH
2629: 
2630:             *-- "Briefing Extra" (CheckBox + rotulo). ControlSource legado
2631:             *-- "crSigMvJbC.Jb_072" - mapeado por BOParaForm/FormParaBO.
2632:             *-- O AutoSize = .T. do dump NAO eh transcrito: em CheckBox criado
2633:             *-- por AddObject ele eh no-op (a caixa ficaria nos 100x17 do
2634:             *-- default e cobriria o rotulo ao lado) - Width/Height explicitos.
2635:             THIS.AddObject("chk_4c_Get_Extra", "CheckBox")
2636:             WITH THIS.chk_4c_Get_Extra
2637:                 .Top = 104
2638:                 .Left = 102
2639:                 .Width = 16
2640:                 .Height = 17
2641:                 .Alignment = 0
2642:                 .AutoSize = .F.
2643:                 .BackStyle = 0
2644:                 .SpecialEffect = 1
2645:                 .Themes = .T.

*-- Linhas 2684 a 2702:
2684:             ENDWITH
2685: 
2686:             *-- ATENCAO - divergencia de BANCO, nao de migracao (regra #14/#45):
2687:             *-- o SCX legado liga este EditBox a ControlSource
2688:             *-- "crSigMvJbC.Jb_Contatos", e essa coluna NAO EXISTE no schema
2689:             *-- canonico. Medido em docs\schema.sql: SigMvJbC tem 77 colunas -
2690:             *-- empdopnums, jb_001..jb_075 e jb_contato (datetime); nao existe
2691:             *-- jb_contatos de texto. O dump do form eh mais novo que o banco.
2692:             *-- O campo eh reproduzido para a tela ficar fiel ao legado
2693:             *-- (PILAR 1), mas NAO eh persistido: criar a coluna violaria o
2694:             *-- PILAR 2 (schema identico) e apontar para jb_contato (datetime)
2695:             *-- gravaria texto no campo errado. A ausencia fica VISIVEL aqui de
2696:             *-- proposito, em vez de ser mascarada por um binding inventado.
2697:             THIS.AddObject("obj_4c_GetCabContatos", "EditBox")
2698:             WITH THIS.obj_4c_GetCabContatos
2699:                 .Top = 18
2700:                 .Left = 396
2701:                 .Width = 494
2702:                 .Height = 106

*-- Linhas 2772 a 2800:
2772:     * e os totalizadores txt_4c_TotFontes/txt_4c_TotValores (somente leitura).
2773:     *
2774:     * O cursor placeholder nasce ANTES do Grid (regra #41) com a MESMA ordem
2775:     * de colunas do SELECT feito por SigOpJobBO.CarregarFontes(), para o
2776:     * rebind em CarregarLista() nao reordenar nada.
2777:     *==========================================================================
2778:     PROTECTED PROCEDURE ConfigurarGridFontes()
2779:         LOCAL loc_oPagina, loc_oErro
2780:         TRY
2781:             IF USED("cursor_4c_Fontes")
2782:                 USE IN cursor_4c_Fontes
2783:             ENDIF
2784:             SET NULL ON
2785:             CREATE CURSOR cursor_4c_Fontes ;
2786:                 (empdopnums C(29), jbi_autors C(20), jbi_fontes C(50), ;
2787:                  jbi_modelos C(30), jbi_valors N(11,2), pkchaves C(20))
2788:             SET NULL OFF
2789: 
2790:             loc_oPagina = THIS.pgf_4c_Job.Page5
2791: 
2792:             loc_oPagina.AddObject("lbl_4c_Lbl_02_010", "Label")
2793:             WITH loc_oPagina.lbl_4c_Lbl_02_010
2794:                 .Top       = 199
2795:                 .Left      = 13
2796:                 .Width     = 200
2797:                 .Height    = 15
2798:                 .Alignment = 0
2799:                 .AutoSize  = .F.
2800:                 .BackStyle = 0

*-- Linhas 2821 a 2839:
2821:                 .Width             = 928
2822:                 .Height            = 203
2823:                 .ColumnCount       = 4
2824:                 .DeleteMark        = .F.
2825:                 .RecordMark        = .F.
2826:                 .GridLines         = 3
2827:                 .GridLineWidth     = 1
2828:                 .GridLineColor     = RGB(238, 238, 238)
2829:                 .HeaderHeight      = 20
2830:                 .ScrollBars        = 2
2831:                 .AllowHeaderSizing = .F.
2832:                 .AllowRowSizing    = .F.
2833:                 .ReadOnly          = .F.
2834:                 .Visible           = .T.
2835: 
2836:                 .Column1.Movable   = .F.
2837:                 .Column1.Resizable = .F.
2838:                 .Column1.ReadOnly  = .F.
2839:                 .Column1.Width     = 360

*-- Linhas 2969 a 2987:
2969: 
2970:     *==========================================================================
2971:     * CarregarLista - Carrega SigMvJbI (via BO.CarregarFontes) na grade
2972:     * "Fontes Pagadoras" e rebinda RecordSource/ControlSource/Width/Header -
2973:     * RecordSource RESETA essas propriedades (Problema 48), por isso sao
2974:     * reaplicadas aqui, depois do load (legado: PROCEDURE montagrades).
2975:     *
2976:     * Em modo INCLUIR/ALTERAR garante ao menos 1 linha em branco (mesma
2977:     * logica do btnInserir.Click) e exibe os botoes de Inserir/Excluir;
2978:     * em VISUALIZAR eles ficam ocultos e a grade some de edicao via o
2979:     * guard de GrdFontesColumnWhen.
2980:     *
2981:     * PUBLIC de proposito: este e' o FUNIL de carga da lista deste dialogo
2982:     * (a grade "Fontes Pagadoras" e' a unica lista que o SCX legado tem), e
2983:     * o harness de teste chama THIS.oForm.CarregarLista() de FORA da classe
2984:     * - PEMSTATUS devolve .T. para metodo PROTECTED, entao o teste entraria
2985:     * no branch e a chamada estouraria em runtime (regra #3).
2986:     *==========================================================================
2987:     PROCEDURE CarregarLista()

*-- Linhas 3000 a 3044:
3000:                 WITH loc_oGrid
3001:                     .RecordSource = loc_cAlias
3002: 
3003:                     .Column1.ControlSource   = loc_cAlias + ".jbi_fontes"
3004:                     .Column1.Width           = 360
3005:                     .Column1.Header1.Caption = "Cliente"
3006: 
3007:                     .Column2.ControlSource   = loc_cAlias + ".jbi_modelos"
3008:                     .Column2.Width           = 220
3009:                     .Column2.Header1.Caption = "Modelo Fiscal"
3010: 
3011:                     .Column3.ControlSource   = loc_cAlias + ".jbi_autors"
3012:                     .Column3.Width           = 150
3013:                     .Column3.Header1.Caption = "N" + CHR(250) + "mero Incentivo"
3014: 
3015:                     .Column4.ControlSource   = loc_cAlias + ".jbi_valors"
3016:                     .Column4.Width           = 174
3017:                     .Column4.Header1.Caption = "Valor"
3018:                 ENDWITH
3019: 
3020:                 SELECT (loc_cAlias)
3021:                 GO TOP
3022: 
3023:                 THIS.pgf_4c_Job.Page5.cmd_4c_BtnInserir.Visible = .F.
3024:                 THIS.pgf_4c_Job.Page5.cmd_4c_BtnExcluir.Visible = .F.
3025: 
3026:                 IF loc_lModoEdicao
3027:                     LOCATE FOR EMPTY(jbi_fontes) AND EMPTY(jbi_modelos)
3028:                     IF !FOUND()
3029:                         INSERT INTO (loc_cAlias) (empdopnums, pkchaves) VALUES ;
3030:                             (THIS.this_oBusinessObject.this_cEmpDopNums, fUniqueIds())
3031:                     ENDIF
3032:                     GO BOTTOM
3033: 
3034:                     THIS.pgf_4c_Job.Page5.cmd_4c_BtnInserir.Visible = .T.
3035:                     THIS.pgf_4c_Job.Page5.cmd_4c_BtnExcluir.Visible = .T.
3036:                 ENDIF
3037: 
3038:                 loc_oGrid.Refresh()
3039:                 THIS.GrdFontesAfterRowColChange(1)
3040:             ENDIF
3041:         CATCH TO loc_oErro
3042:             MsgErro(loc_oErro.Message + CHR(13) + ;
3043:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3044:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")

*-- Linhas 3100 a 3118:
3100:     * mdadosequipes do SCX legado, que para cada Jb_024..037 nao vazio faz
3101:     * CursorQuery em SigCdCli e joga RClis no campo "a").
3102:     *
3103:     * O legado NAO tem ControlSource nos campos "a": eles sao preenchidos por
3104:     * codigo, e eh isso que se reproduz aqui.
3105:     *==========================================================================
3106:     PROTECTED PROCEDURE CarregarNomesEquipes()
3107:         LOCAL loc_oBO, loc_oCnt1, loc_oCnt2, loc_oErro
3108: 
3109:         TRY
3110:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3111:                 loc_oBO   = THIS.this_oBusinessObject
3112:                 loc_oCnt1 = THIS.pgf_4c_Job.Page3.cnt_4c_Emp1
3113:                 loc_oCnt2 = THIS.pgf_4c_Job.Page3.cnt_4c_Emp2
3114: 
3115:                 loc_oCnt1.txt_4c__01_024a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb024)
3116:                 loc_oCnt1.txt_4c__01_025a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb025)
3117:                 loc_oCnt1.txt_4c__01_026a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb026)
3118:                 loc_oCnt1.txt_4c__01_027a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb027)

*-- Linhas 3183 a 3205:
3183:             RETURN .T.
3184:         ENDIF
3185: 
3186:         SELECT (loc_cAlias)
3187:         IF !EMPTY(jbi_fontes) AND !EMPTY(jbi_modelos) AND !EOF()
3188:             SKIP
3189:             IF EOF()
3190:                 INSERT INTO (loc_cAlias) (empdopnums, pkchaves) VALUES ;
3191:                     (THIS.this_oBusinessObject.this_cEmpDopNums, fUniqueIds())
3192:             ENDIF
3193:         ENDIF
3194: 
3195:         GO TOP
3196:         THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3197:         GO BOTTOM
3198: 
3199:         RETURN .T.
3200:     ENDPROC
3201: 
3202:     *==========================================================================
3203:     * BtnInserirClick - Insere linha em branco na grade "Fontes Pagadoras"
3204:     * (legado: pgPagina5.btnInserir.Click). So reutiliza linha ja vazia
3205:     * (JBI_Fontes e JBI_Modelos vazios); senao cria uma nova com pkChaves

*-- Linhas 3226 a 3267:
3226:             ENDIF
3227: 
3228:             IF loc_lProsseguir
3229:                 SELECT (loc_cAlias)
3230:                 LOCATE FOR EMPTY(jbi_fontes) AND EMPTY(jbi_modelos)
3231:                 IF !FOUND()
3232:                     INSERT INTO (loc_cAlias) (empdopnums, pkchaves) VALUES ;
3233:                         (THIS.this_oBusinessObject.this_cEmpDopNums, fUniqueIds())
3234:                 ENDIF
3235: 
3236:                 SELECT (loc_cAlias)
3237:                 GO TOP
3238:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3239:                 GO BOTTOM
3240:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.SetFocus()
3241:                 THIS.GrdFontesAfterRowColChange(1)
3242:             ENDIF
3243:         CATCH TO loc_oErro
3244:             MsgErro(loc_oErro.Message + CHR(13) + ;
3245:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3246:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnInserirClick")
3247:         ENDTRY
3248:     ENDPROC
3249: 
3250:     *==========================================================================
3251:     * BtnExcluirClick - Exclui a linha corrente da grade "Fontes Pagadoras"
3252:     * (legado: pgPagina5.btnExcluir.Click). DELETE sem PACK - SET DELETED ON
3253:     * (config.prg) ja tira a linha da visao do Grid.
3254:     *==========================================================================
3255:     PROCEDURE BtnExcluirClick()
3256:         *-- Guardas por FLAG, nunca RETURN - ver comentario de BtnInserirClick
3257:         *-- (regra #1). Aqui o RETURN era ainda mais perigoso: ele ficava
3258:         *-- ANTES do LockScreen = .T., mas o estouro em runtime deixaria o
3259:         *-- metodo pelo CATCH, que repoe LockScreen = .F.
3260:         LOCAL loc_cAlias, loc_nRec, loc_lProsseguir, loc_oErro
3261:         loc_lProsseguir = .T.
3262: 
3263:         TRY
3264:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
3265:                 loc_lProsseguir = .F.
3266:             ENDIF
3267: 

*-- Linhas 3275 a 3296:
3275:             IF loc_lProsseguir
3276:                 THIS.LockScreen = .T.
3277: 
3278:                 SELECT (loc_cAlias)
3279:                 loc_nRec = RECNO()
3280:                 IF !EOF()
3281:                     DELETE
3282:                 ENDIF
3283: 
3284:                 GO TOP
3285:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3286:                 IF BETWEEN(loc_nRec, 1, RECCOUNT())
3287:                     GO (loc_nRec)
3288:                 ELSE
3289:                     GO BOTTOM
3290:                 ENDIF
3291:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3292:                 THIS.GrdFontesAfterRowColChange(1)
3293: 
3294:                 THIS.LockScreen = .F.
3295:             ENDIF
3296:         CATCH TO loc_oErro

*-- Linhas 3305 a 3323:
3305:     * GrdFontesAfterRowColChange - Recalcula os totalizadores da grade.
3306:     * Uso legitimo de AfterRowColChange (regra #46): nao valida CELULA, so
3307:     * agrega o cursor inteiro - igual ao legado, que tambem chama este
3308:     * evento manualmente apos cada INSERT/DELETE/GO (nao confia em disparo
3309:     * automatico do Grid para recalculo).
3310:     *==========================================================================
3311:     PROCEDURE GrdFontesAfterRowColChange(par_nColIndex)
3312:         THIS.RecalcularTotaisFontes()
3313:     ENDPROC
3314: 
3315:     *==========================================================================
3316:     * RecalcularTotaisFontes - Soma Count(1)/Sum(JBI_Valors) por EmpDopNums,
3317:     * igual ao legado (grdFontes.AfterRowColChange), e espelha nos
3318:     * totalizadores txt_4c_TotFontes/txt_4c_TotValores.
3319:     *==========================================================================
3320:     PROCEDURE RecalcularTotaisFontes()
3321:         LOCAL loc_cAlias, loc_nSoma, loc_nValors, loc_oErro
3322: 
3323:         IF VARTYPE(THIS.this_oBusinessObject) != "O"

*-- Linhas 3330 a 3349:
3330:         ENDIF
3331: 
3332:         TRY
3333:             SELECT empdopnums, COUNT(1) AS Soma, SUM(jbi_valors) AS Valors ;
3334:                 FROM (loc_cAlias) ;
3335:                 GROUP BY empdopnums ;
3336:                 INTO CURSOR cursor_4c_FontesTot
3337: 
3338:             IF RECCOUNT("cursor_4c_FontesTot") > 0
3339:                 GO TOP IN cursor_4c_FontesTot
3340:                 loc_nSoma   = cursor_4c_FontesTot.Soma
3341:                 loc_nValors = cursor_4c_FontesTot.Valors
3342:             ELSE
3343:                 loc_nSoma   = 0
3344:                 loc_nValors = 0
3345:             ENDIF
3346: 
3347:             IF USED("cursor_4c_FontesTot")
3348:                 USE IN cursor_4c_FontesTot
3349:             ENDIF

*-- Linhas 3439 a 3457:
3439:             loc_oPag3.chk_4c_Get_01_043.Value = IIF(loc_oBO.this_nJb043 = 1, 1, 0)
3440:             loc_oPag3.chk_4c_Get_01_044.Value = IIF(loc_oBO.this_nJb044 = 1, 1, 0)
3441: 
3442:             *-- Os campos de NOME da Page3 nao tem ControlSource no legado:
3443:             *-- vem de SigCdCli.RClis pelo codigo de cada linha.
3444:             THIS.CarregarNomesEquipes()
3445: 
3446:             *-- Page4 - Materiais de Apoio (caminhos de pasta/arquivo)
3447:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_045.Value = loc_oBO.this_cJb045
3448:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_046.Value = loc_oBO.this_cJb046
3449:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_047.Value = loc_oBO.this_cJb047
3450:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_048.Value = loc_oBO.this_cJb048
3451:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_061.Value = loc_oBO.this_cJb061
3452:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_058.Value = loc_oBO.this_cJb058
3453: 
3454:             *-- Page5 - Modelo Fiscal / Fontes Pagadoras
3455:             THIS.pgf_4c_Job.Page5.obj_4c_Get_01_062.Value = loc_oBO.this_cJb062
3456:             THIS.pgf_4c_Job.Page5.chk_4c_Get_01_063.Value = IIF(loc_oBO.this_nJb063 = 1, 1, 0)
3457:             THIS.pgf_4c_Job.Page5.chk_4c_Get_01_064.Value = IIF(loc_oBO.this_nJb064 = 1, 1, 0)

*-- Linhas 3598 a 3618:
3598:             *-- Page3 - Equipes (codigos) e classificacao do Job.
3599:             *-- Apenas os campos de CODIGO voltam para o BO: os campos de NOME
3600:             *-- (txt_4c__01_0NNa) nao tem coluna em SigMvJbC - no legado
3601:             *-- tambem nao tem ControlSource, sao exibicao de SigCdCli.RClis.
3602:             *-- As colunas Jb_024..037 sao char(10) NOT NULL: ALLTRIM aqui
3603:             *-- (o SQL Server faz blank-padding ANSI em char) e o INSERT/UPDATE
3604:             *-- do BO fecha com PADR(..., 10), o MESMO tamanho do .MaxLength
3605:             *-- destes TextBox.
3606:             loc_oPag3 = THIS.pgf_4c_Job.Page3
3607:             loc_oCnt1 = loc_oPag3.cnt_4c_Emp1
3608:             loc_oCnt2 = loc_oPag3.cnt_4c_Emp2
3609: 
3610:             loc_oBO.this_cJb024 = ALLTRIM(loc_oCnt1.txt_4c__01_024.Value)
3611:             loc_oBO.this_cJb025 = ALLTRIM(loc_oCnt1.txt_4c__01_025.Value)
3612:             loc_oBO.this_cJb026 = ALLTRIM(loc_oCnt1.txt_4c__01_026.Value)
3613:             loc_oBO.this_cJb027 = ALLTRIM(loc_oCnt1.txt_4c__01_027.Value)
3614:             loc_oBO.this_cJb028 = ALLTRIM(loc_oCnt1.txt_4c__01_028.Value)
3615:             loc_oBO.this_cJb029 = ALLTRIM(loc_oCnt1.txt_4c__01_029.Value)
3616:             loc_oBO.this_cJb030 = ALLTRIM(loc_oCnt1.txt_4c__01_030.Value)
3617: 
3618:             loc_oBO.this_cJb031 = ALLTRIM(loc_oCnt2.txt_4c__01_031.Value)

*-- Linhas 3795 a 3813:
3795:     *
3796:     * Le o CONTROLE, nao a property do BO, porque ChecarCamposObrigatorios
3797:     * roda a cada LostFocus - ANTES de FormParaBO - e a property ainda tem o
3798:     * valor anterior. No legado o TextBox tem ControlSource para o cursor
3799:     * buffered, entao ler o cursor ja era ler o valor na tela; aqui o
3800:     * equivalente fiel e' ler o proprio controle.
3801:     *
3802:     * Controle ausente devolve .T. (nao bloqueia): mesma postura do legado,
3803:     * que nem chega a testar indice cujo laCpo esta vazio.
3804:     *==========================================================================
3805:     PROTECTED FUNCTION CampoPreenchido(par_cCaminho)
3806:         LOCAL loc_oCtrl, loc_uValor
3807: 
3808:         loc_oCtrl = THIS.ResolverControle(par_cCaminho)
3809:         IF VARTYPE(loc_oCtrl) != "O"
3810:             RETURN .T.
3811:         ENDIF
3812:         IF !PEMSTATUS(loc_oCtrl, "Value", 5)
3813:             RETURN .T.

*-- Linhas 4318 a 4343:
4318:     * CmdRetornarClick - Fecha o dialogo de Complementos do Job (legado:
4319:     * SIGOPJOB.cmdRetornar.btnRetornar.Click). Em INCLUIR/ALTERAR, ANTES de
4320:     * fechar: remove da grade "Fontes Pagadoras" as linhas em branco deixadas
4321:     * pela edicao - transcricao de "Delete From crSigMvJbI Where Empty(
4322:     * JBI_Fontes) Or Empty(JBI_Modelos)" - e GRAVA o complemento (FormParaBO +
4323:     * BO.Salvar() + BO.PersistirFontes()).
4324:     *
4325:     * O legado nao precisa gravar aqui: o TextBox ja esta ligado por
4326:     * ControlSource ao cursor BUFFERED do form pai, e o TableUpdate acontece
4327:     * quando o movimento inteiro e salvo (fora deste dialogo). Nesta
4328:     * arquitetura em camadas o BO grava com SQLEXEC explicito, e so ha um
4329:     * ponto de saida (Retornar) para persistir - fechar sem gravar perderia
4330:     * tudo o que foi digitado. Em VISUALIZAR fecha direto, sem gravar nada
4331:     * (igual ao legado, que tambem so limpa a grade e fecha).
4332:     *
4333:     * Se Salvar()/PersistirFontes() falhar, o dialogo NAO fecha (a falha ja
4334:     * foi exibida pelo proprio BO - regra "CATCH nunca silencioso" /
4335:     * "ExibirFalha") e o usuario pode corrigir e tentar de novo.
4336:     *
4337:     * PUBLIC (BINDEVENT exige - regra #3). THIS.Release() dispara Destroy()
4338:     * na cadeia de heranca, que reabilita THIS.this_oFormPai (equivalente ao
4339:     * "PROCEDURE Release / ThisForm.ParentForm.Enabled = .t." do SCX legado).
4340:     *==========================================================================
4341:     PROCEDURE CmdRetornarClick()
4342:         LOCAL loc_cAlias, loc_lEmEdicao, loc_lSalvou, loc_lProsseguir, loc_oErro
4343:         loc_lEmEdicao   = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

*-- Linhas 4375 a 4394:
4375:             IF loc_lEmEdicao AND VARTYPE(THIS.this_oBusinessObject) = "O"
4376:                 loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
4377:                 IF USED(loc_cAlias)
4378:                     SELECT (loc_cAlias)
4379:                     DELETE FOR EMPTY(jbi_fontes) OR EMPTY(jbi_modelos)
4380:                     GO BOTTOM
4381:                 ENDIF
4382: 
4383:                 THIS.FormParaBO()
4384: 
4385:                 loc_lSalvou = THIS.this_oBusinessObject.Salvar()
4386:                 IF loc_lSalvou
4387:                     loc_lSalvou = THIS.this_oBusinessObject.PersistirFontes()
4388:                 ENDIF
4389:             ENDIF
4390:         CATCH TO loc_oErro
4391:             loc_lSalvou = .F.
4392:             MsgErro(loc_oErro.Message + CHR(13) + ;
4393:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4394:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdRetornarClick")

