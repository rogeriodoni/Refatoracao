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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpJob.prg) - TRECHOS RELEVANTES PARA PASS SQL (4426 linhas total):

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

*-- Linhas 3004 a 3048:
3004:                 loc_oGrid.RecordSource = loc_cAlias
3005: 
3006:                 WITH loc_oGrid
3007:                     .Column1.ControlSource   = loc_cAlias + ".jbi_fontes"
3008:                     .Column1.Width           = 360
3009:                     .Column1.Header1.Caption = "Cliente"
3010: 
3011:                     .Column2.ControlSource   = loc_cAlias + ".jbi_modelos"
3012:                     .Column2.Width           = 220
3013:                     .Column2.Header1.Caption = "Modelo Fiscal"
3014: 
3015:                     .Column3.ControlSource   = loc_cAlias + ".jbi_autors"
3016:                     .Column3.Width           = 150
3017:                     .Column3.Header1.Caption = "N" + CHR(250) + "mero Incentivo"
3018: 
3019:                     .Column4.ControlSource   = loc_cAlias + ".jbi_valors"
3020:                     .Column4.Width           = 174
3021:                     .Column4.Header1.Caption = "Valor"
3022:                 ENDWITH
3023: 
3024:                 SELECT (loc_cAlias)
3025:                 GO TOP
3026: 
3027:                 THIS.pgf_4c_Job.Page5.cmd_4c_BtnInserir.Visible = .F.
3028:                 THIS.pgf_4c_Job.Page5.cmd_4c_BtnExcluir.Visible = .F.
3029: 
3030:                 IF loc_lModoEdicao
3031:                     LOCATE FOR EMPTY(jbi_fontes) AND EMPTY(jbi_modelos)
3032:                     IF !FOUND()
3033:                         INSERT INTO (loc_cAlias) (empdopnums, pkchaves) VALUES ;
3034:                             (THIS.this_oBusinessObject.this_cEmpDopNums, fUniqueIds())
3035:                     ENDIF
3036:                     GO BOTTOM
3037: 
3038:                     THIS.pgf_4c_Job.Page5.cmd_4c_BtnInserir.Visible = .T.
3039:                     THIS.pgf_4c_Job.Page5.cmd_4c_BtnExcluir.Visible = .T.
3040:                 ENDIF
3041: 
3042:                 loc_oGrid.Refresh()
3043:                 THIS.GrdFontesAfterRowColChange(1)
3044:             ENDIF
3045:         CATCH TO loc_oErro
3046:             MsgErro(loc_oErro.Message + CHR(13) + ;
3047:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3048:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")

*-- Linhas 3104 a 3122:
3104:     * mdadosequipes do SCX legado, que para cada Jb_024..037 nao vazio faz
3105:     * CursorQuery em SigCdCli e joga RClis no campo "a").
3106:     *
3107:     * O legado NAO tem ControlSource nos campos "a": eles sao preenchidos por
3108:     * codigo, e eh isso que se reproduz aqui.
3109:     *==========================================================================
3110:     PROTECTED PROCEDURE CarregarNomesEquipes()
3111:         LOCAL loc_oBO, loc_oCnt1, loc_oCnt2, loc_oErro
3112: 
3113:         TRY
3114:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3115:                 loc_oBO   = THIS.this_oBusinessObject
3116:                 loc_oCnt1 = THIS.pgf_4c_Job.Page3.cnt_4c_Emp1
3117:                 loc_oCnt2 = THIS.pgf_4c_Job.Page3.cnt_4c_Emp2
3118: 
3119:                 loc_oCnt1.txt_4c__01_024a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb024)
3120:                 loc_oCnt1.txt_4c__01_025a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb025)
3121:                 loc_oCnt1.txt_4c__01_026a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb026)
3122:                 loc_oCnt1.txt_4c__01_027a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb027)

*-- Linhas 3187 a 3209:
3187:             RETURN .T.
3188:         ENDIF
3189: 
3190:         SELECT (loc_cAlias)
3191:         IF !EMPTY(jbi_fontes) AND !EMPTY(jbi_modelos) AND !EOF()
3192:             SKIP
3193:             IF EOF()
3194:                 INSERT INTO (loc_cAlias) (empdopnums, pkchaves) VALUES ;
3195:                     (THIS.this_oBusinessObject.this_cEmpDopNums, fUniqueIds())
3196:             ENDIF
3197:         ENDIF
3198: 
3199:         GO TOP
3200:         THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3201:         GO BOTTOM
3202: 
3203:         RETURN .T.
3204:     ENDPROC
3205: 
3206:     *==========================================================================
3207:     * BtnInserirClick - Insere linha em branco na grade "Fontes Pagadoras"
3208:     * (legado: pgPagina5.btnInserir.Click). So reutiliza linha ja vazia
3209:     * (JBI_Fontes e JBI_Modelos vazios); senao cria uma nova com pkChaves

*-- Linhas 3230 a 3271:
3230:             ENDIF
3231: 
3232:             IF loc_lProsseguir
3233:                 SELECT (loc_cAlias)
3234:                 LOCATE FOR EMPTY(jbi_fontes) AND EMPTY(jbi_modelos)
3235:                 IF !FOUND()
3236:                     INSERT INTO (loc_cAlias) (empdopnums, pkchaves) VALUES ;
3237:                         (THIS.this_oBusinessObject.this_cEmpDopNums, fUniqueIds())
3238:                 ENDIF
3239: 
3240:                 SELECT (loc_cAlias)
3241:                 GO TOP
3242:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3243:                 GO BOTTOM
3244:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.SetFocus()
3245:                 THIS.GrdFontesAfterRowColChange(1)
3246:             ENDIF
3247:         CATCH TO loc_oErro
3248:             MsgErro(loc_oErro.Message + CHR(13) + ;
3249:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3250:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnInserirClick")
3251:         ENDTRY
3252:     ENDPROC
3253: 
3254:     *==========================================================================
3255:     * BtnExcluirClick - Exclui a linha corrente da grade "Fontes Pagadoras"
3256:     * (legado: pgPagina5.btnExcluir.Click). DELETE sem PACK - SET DELETED ON
3257:     * (config.prg) ja tira a linha da visao do Grid.
3258:     *==========================================================================
3259:     PROCEDURE BtnExcluirClick()
3260:         *-- Guardas por FLAG, nunca RETURN - ver comentario de BtnInserirClick
3261:         *-- (regra #1). Aqui o RETURN era ainda mais perigoso: ele ficava
3262:         *-- ANTES do LockScreen = .T., mas o estouro em runtime deixaria o
3263:         *-- metodo pelo CATCH, que repoe LockScreen = .F.
3264:         LOCAL loc_cAlias, loc_nRec, loc_lProsseguir, loc_oErro
3265:         loc_lProsseguir = .T.
3266: 
3267:         TRY
3268:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
3269:                 loc_lProsseguir = .F.
3270:             ENDIF
3271: 

*-- Linhas 3279 a 3300:
3279:             IF loc_lProsseguir
3280:                 THIS.LockScreen = .T.
3281: 
3282:                 SELECT (loc_cAlias)
3283:                 loc_nRec = RECNO()
3284:                 IF !EOF()
3285:                     DELETE
3286:                 ENDIF
3287: 
3288:                 GO TOP
3289:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3290:                 IF BETWEEN(loc_nRec, 1, RECCOUNT())
3291:                     GO (loc_nRec)
3292:                 ELSE
3293:                     GO BOTTOM
3294:                 ENDIF
3295:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3296:                 THIS.GrdFontesAfterRowColChange(1)
3297: 
3298:                 THIS.LockScreen = .F.
3299:             ENDIF
3300:         CATCH TO loc_oErro

*-- Linhas 3309 a 3327:
3309:     * GrdFontesAfterRowColChange - Recalcula os totalizadores da grade.
3310:     * Uso legitimo de AfterRowColChange (regra #46): nao valida CELULA, so
3311:     * agrega o cursor inteiro - igual ao legado, que tambem chama este
3312:     * evento manualmente apos cada INSERT/DELETE/GO (nao confia em disparo
3313:     * automatico do Grid para recalculo).
3314:     *==========================================================================
3315:     PROCEDURE GrdFontesAfterRowColChange(par_nColIndex)
3316:         THIS.RecalcularTotaisFontes()
3317:     ENDPROC
3318: 
3319:     *==========================================================================
3320:     * RecalcularTotaisFontes - Soma Count(1)/Sum(JBI_Valors) por EmpDopNums,
3321:     * igual ao legado (grdFontes.AfterRowColChange), e espelha nos
3322:     * totalizadores txt_4c_TotFontes/txt_4c_TotValores.
3323:     *==========================================================================
3324:     PROCEDURE RecalcularTotaisFontes()
3325:         LOCAL loc_cAlias, loc_nSoma, loc_nValors, loc_oErro
3326: 
3327:         IF VARTYPE(THIS.this_oBusinessObject) != "O"

*-- Linhas 3334 a 3353:
3334:         ENDIF
3335: 
3336:         TRY
3337:             SELECT empdopnums, COUNT(1) AS Soma, SUM(jbi_valors) AS Valors ;
3338:                 FROM (loc_cAlias) ;
3339:                 GROUP BY empdopnums ;
3340:                 INTO CURSOR cursor_4c_FontesTot
3341: 
3342:             IF RECCOUNT("cursor_4c_FontesTot") > 0
3343:                 GO TOP IN cursor_4c_FontesTot
3344:                 loc_nSoma   = cursor_4c_FontesTot.Soma
3345:                 loc_nValors = cursor_4c_FontesTot.Valors
3346:             ELSE
3347:                 loc_nSoma   = 0
3348:                 loc_nValors = 0
3349:             ENDIF
3350: 
3351:             IF USED("cursor_4c_FontesTot")
3352:                 USE IN cursor_4c_FontesTot
3353:             ENDIF

*-- Linhas 3443 a 3461:
3443:             loc_oPag3.chk_4c_Get_01_043.Value = IIF(loc_oBO.this_nJb043 = 1, 1, 0)
3444:             loc_oPag3.chk_4c_Get_01_044.Value = IIF(loc_oBO.this_nJb044 = 1, 1, 0)
3445: 
3446:             *-- Os campos de NOME da Page3 nao tem ControlSource no legado:
3447:             *-- vem de SigCdCli.RClis pelo codigo de cada linha.
3448:             THIS.CarregarNomesEquipes()
3449: 
3450:             *-- Page4 - Materiais de Apoio (caminhos de pasta/arquivo)
3451:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_045.Value = loc_oBO.this_cJb045
3452:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_046.Value = loc_oBO.this_cJb046
3453:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_047.Value = loc_oBO.this_cJb047
3454:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_048.Value = loc_oBO.this_cJb048
3455:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_061.Value = loc_oBO.this_cJb061
3456:             THIS.pgf_4c_Job.Page4.obj_4c_Get_01_058.Value = loc_oBO.this_cJb058
3457: 
3458:             *-- Page5 - Modelo Fiscal / Fontes Pagadoras
3459:             THIS.pgf_4c_Job.Page5.obj_4c_Get_01_062.Value = loc_oBO.this_cJb062
3460:             THIS.pgf_4c_Job.Page5.chk_4c_Get_01_063.Value = IIF(loc_oBO.this_nJb063 = 1, 1, 0)
3461:             THIS.pgf_4c_Job.Page5.chk_4c_Get_01_064.Value = IIF(loc_oBO.this_nJb064 = 1, 1, 0)

*-- Linhas 3602 a 3622:
3602:             *-- Page3 - Equipes (codigos) e classificacao do Job.
3603:             *-- Apenas os campos de CODIGO voltam para o BO: os campos de NOME
3604:             *-- (txt_4c__01_0NNa) nao tem coluna em SigMvJbC - no legado
3605:             *-- tambem nao tem ControlSource, sao exibicao de SigCdCli.RClis.
3606:             *-- As colunas Jb_024..037 sao char(10) NOT NULL: ALLTRIM aqui
3607:             *-- (o SQL Server faz blank-padding ANSI em char) e o INSERT/UPDATE
3608:             *-- do BO fecha com PADR(..., 10), o MESMO tamanho do .MaxLength
3609:             *-- destes TextBox.
3610:             loc_oPag3 = THIS.pgf_4c_Job.Page3
3611:             loc_oCnt1 = loc_oPag3.cnt_4c_Emp1
3612:             loc_oCnt2 = loc_oPag3.cnt_4c_Emp2
3613: 
3614:             loc_oBO.this_cJb024 = ALLTRIM(loc_oCnt1.txt_4c__01_024.Value)
3615:             loc_oBO.this_cJb025 = ALLTRIM(loc_oCnt1.txt_4c__01_025.Value)
3616:             loc_oBO.this_cJb026 = ALLTRIM(loc_oCnt1.txt_4c__01_026.Value)
3617:             loc_oBO.this_cJb027 = ALLTRIM(loc_oCnt1.txt_4c__01_027.Value)
3618:             loc_oBO.this_cJb028 = ALLTRIM(loc_oCnt1.txt_4c__01_028.Value)
3619:             loc_oBO.this_cJb029 = ALLTRIM(loc_oCnt1.txt_4c__01_029.Value)
3620:             loc_oBO.this_cJb030 = ALLTRIM(loc_oCnt1.txt_4c__01_030.Value)
3621: 
3622:             loc_oBO.this_cJb031 = ALLTRIM(loc_oCnt2.txt_4c__01_031.Value)

*-- Linhas 3805 a 3823:
3805:     *
3806:     * Le o CONTROLE, nao a property do BO, porque ChecarCamposObrigatorios
3807:     * roda a cada LostFocus - ANTES de FormParaBO - e a property ainda tem o
3808:     * valor anterior. No legado o TextBox tem ControlSource para o cursor
3809:     * buffered, entao ler o cursor ja era ler o valor na tela; aqui o
3810:     * equivalente fiel e' ler o proprio controle.
3811:     *
3812:     * Controle ausente devolve .T. (nao bloqueia): mesma postura do legado,
3813:     * que nem chega a testar indice cujo laCpo esta vazio.
3814:     *==========================================================================
3815:     PROTECTED FUNCTION CampoPreenchido(par_cCaminho)
3816:         LOCAL loc_oCtrl, loc_uValor
3817: 
3818:         loc_oCtrl = THIS.ResolverControle(par_cCaminho)
3819:         IF VARTYPE(loc_oCtrl) != "O"
3820:             RETURN .T.
3821:         ENDIF
3822:         IF !PEMSTATUS(loc_oCtrl, "Value", 5)
3823:             RETURN .T.

*-- Linhas 4328 a 4353:
4328:     * CmdRetornarClick - Fecha o dialogo de Complementos do Job (legado:
4329:     * SIGOPJOB.cmdRetornar.btnRetornar.Click). Em INCLUIR/ALTERAR, ANTES de
4330:     * fechar: remove da grade "Fontes Pagadoras" as linhas em branco deixadas
4331:     * pela edicao - transcricao de "Delete From crSigMvJbI Where Empty(
4332:     * JBI_Fontes) Or Empty(JBI_Modelos)" - e GRAVA o complemento (FormParaBO +
4333:     * BO.Salvar() + BO.PersistirFontes()).
4334:     *
4335:     * O legado nao precisa gravar aqui: o TextBox ja esta ligado por
4336:     * ControlSource ao cursor BUFFERED do form pai, e o TableUpdate acontece
4337:     * quando o movimento inteiro e salvo (fora deste dialogo). Nesta
4338:     * arquitetura em camadas o BO grava com SQLEXEC explicito, e so ha um
4339:     * ponto de saida (Retornar) para persistir - fechar sem gravar perderia
4340:     * tudo o que foi digitado. Em VISUALIZAR fecha direto, sem gravar nada
4341:     * (igual ao legado, que tambem so limpa a grade e fecha).
4342:     *
4343:     * Se Salvar()/PersistirFontes() falhar, o dialogo NAO fecha (a falha ja
4344:     * foi exibida pelo proprio BO - regra "CATCH nunca silencioso" /
4345:     * "ExibirFalha") e o usuario pode corrigir e tentar de novo.
4346:     *
4347:     * PUBLIC (BINDEVENT exige - regra #3). THIS.Release() dispara Destroy()
4348:     * na cadeia de heranca, que reabilita THIS.this_oFormPai (equivalente ao
4349:     * "PROCEDURE Release / ThisForm.ParentForm.Enabled = .t." do SCX legado).
4350:     *==========================================================================
4351:     PROCEDURE CmdRetornarClick()
4352:         LOCAL loc_cAlias, loc_lEmEdicao, loc_lSalvou, loc_lProsseguir, loc_oErro
4353:         loc_lEmEdicao   = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

*-- Linhas 4385 a 4404:
4385:             IF loc_lEmEdicao AND VARTYPE(THIS.this_oBusinessObject) = "O"
4386:                 loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
4387:                 IF USED(loc_cAlias)
4388:                     SELECT (loc_cAlias)
4389:                     DELETE FOR EMPTY(jbi_fontes) OR EMPTY(jbi_modelos)
4390:                     GO BOTTOM
4391:                 ENDIF
4392: 
4393:                 THIS.FormParaBO()
4394: 
4395:                 loc_lSalvou = THIS.this_oBusinessObject.Salvar()
4396:                 IF loc_lSalvou
4397:                     loc_lSalvou = THIS.this_oBusinessObject.PersistirFontes()
4398:                 ENDIF
4399:             ENDIF
4400:         CATCH TO loc_oErro
4401:             loc_lSalvou = .F.
4402:             MsgErro(loc_oErro.Message + CHR(13) + ;
4403:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4404:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdRetornarClick")

