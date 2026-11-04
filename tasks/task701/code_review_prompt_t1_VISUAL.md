# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Historico' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcim.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1674 linhas total):

*-- Linhas 19 a 65:
19: *
20: * Fase 4/8 - GRID + BOTOES: o legado SIGOPCIM NAO e um cadastro CRUD (nao
21: * tem Incluir/Alterar/Visualizar/Buscar) - e um dialogo filho que mostra o
22: * HISTORICO de leituras de barras (Grade/CrInvH) e so tem dois botoes reais:
23: * Excluiitem (so visivel em modo exclusao) e Saida. Portanto esta fase
24: * acrescenta: grd_4c_Dados (grid, 5 colunas, equivalente a Grade/CrInvH),
25: * cursor_4c_Historico (clone do cursor GLOBAL "Historico" que o form PAI
26: * mantem aberto - fallback cria vazio para teste/validacao de UI) e
27: * cursor_4c_InvH (equivalente a CrInvH, clone vazio de cursor_4c_Historico),
28: * MontaGrade() (equivalente a THISFORM.AcertaGrade() do legado) e os
29: * botoes cmd_4c_Excluiitem/cmd_4c_Saida com os Click completos. Campos de
30: * consulta (Get_Barra/Get_Produto/...) e imagem entram nas fases 5 e 6;
31: * consolidacao final na Fase 8.
32: *
33: * Fase 5/8 - CAMPOS PRINCIPAIS (PARTE 1): ConfigurarCampos() com a primeira
34: * metade dos campos de consulta do dump (ordem do SCX: Get_Descricao,
35: * Get_Barra, Get_Produto, Get_Peso, Get_Linha) - txt_4c_Barra (entrada,
36: * TabIndex 1), txt_4c_Produto (entrada, TabIndex 2) e txt_4c_Descricao
37: * (exibicao, ReadOnly - equivalente ao "When / Return(.F.)" do legado) com
38: * os respectivos labels (lbl_4c_Label5/lbl_4c_Lbl_produto/
39: * lbl_4c_Lbl_descricao). Get_Peso/Get_Linha, a imagem (ShpFigura/ImgJpg) e
40: * a logica de Valid/When/LostFocus (lookups fwBuscaExt/SqlExecute) entram
41: * na Fase 6.
42: *
43: * Fase 6/8 - CAMPOS RESTANTES E LOOKUPS: txt_4c_Peso/txt_4c_Linha (campos
44: * de EXIBICAO - "When / Return(.F.)" no legado, aqui .ReadOnly = .T.) e a
45: * imagem do produto (shp_4c_ShpFigura/img_4c_ImgJpg). BINDEVENT completo
46: * dos campos de entrada: txt_4c_Barra usa GotFocus (equivalente ao When -
47: * reposiciona cursor_4c_InvH e trata a leitora serial) e LostFocus
48: * (equivalente a Valid+LostFocus combinados - consulta SigOpEtq via
49: * sigopcimBO.ConsultarBarra/ConsultarProduto, atualiza cursor_4c_InvH a
50: * partir de cursor_4c_Historico/SigIvTrH, decodifica a foto e devolve o
51: * foco a grade). txt_4c_Produto usa LostFocus com o picker FormBuscaAuxiliar
52: * (equivalente ao CreateObject('fwBuscaExt',...) do legado, regra CLAUDE.md
53: * #37) e fica habilitado so quando Barra esta vazio (equivalente ao When
54: * "Return(Empty(ThisForm.Get_Barra.Value))"). Consolidacao final na Fase 8.
55: *
56: * Fase 7/8 - EVENTOS PRINCIPAIS: o SIGOPCIM NAO tem superficie CRUD alguma,
57: * entao os nomes canonicos BtnIncluirClick/BtnAlterarClick/
58: * BtnVisualizarClick/BtnExcluirClick NAO existem aqui - cria-los seria
59: * INVENTAR botoes que o legado nao tem (viola o PILAR 1) ou deixar quatro
60: * metodos vazios (proibido pela regra de completude). Medido no dump
61: * tasks/task701/sigopcim_form_codigo_fonte.txt: ZERO ocorrencias de
62: * "frmcadastro" (a classe base nao eh o cadastro do framework - o SCX herda
63: * de "form" puro), ZERO de "Grupo_Op" (nao ha a barra CRUD do framework),
64: * ZERO de "pcEscolha" (nao ha variavel de modo INSERIR/ALTERAR/PROCURAR) e
65: * ZERO de "<verbo>.Click". Os UNICOS dois botoes do legado sao Excluiitem e

*-- Linhas 88 a 96:
88: *                             cada caminho que mexe no cursor da grade.
89: *   BOParaForm()           <- "Get_Produto.Value = TmpPro.CPros /
90: *                             Get_Descricao.Value = TmpPro.DPros /
91: *                             Get_Peso.Value = ... / Get_Linha.Value = ...",
92: *                             bloco que os dois Valid repetem.
93: *   FormParaBO()           <- a transferencia inversa (os dois campos de
94: *                             ENTRADA da tela para as properties do BO), que
95: *                             antes so existia como argumento solto de cada
96: *                             chamada.

*-- Linhas 169 a 184:
169:     *   "Parameters lExcluir, OldForm"
170:     *   "ThisForm.ParentForm = OldForm"
171:     *   "ThisForm.Excluir    = lExcluir"
172:     *   "ThisForm.Caption    = Iif(lExcluir,'Exclusao de Barras','Consulta Imagem')"
173:     * do PROCEDURE Init legado.
174:     *--------------------------------------------------------------------------
175:     PROCEDURE Init(par_lExcluir, par_oParentForm)
176:         THIS.this_lExcluir    = IIF(VARTYPE(par_lExcluir) = "L", par_lExcluir, .F.)
177:         THIS.this_oParentForm = IIF(VARTYPE(par_oParentForm) = "O", par_oParentForm, .NULL.)
178: 
179:         THIS.Caption = IIF(THIS.this_lExcluir, ;
180:             "Exclus" + CHR(227) + "o de Barras", ;
181:             "Consulta Imagem")
182: 
183:         *-- WindowType=1 (modal) causaria TIMEOUT em VFP9 -T. Classe definida
184:         *-- com WindowType=0; producao restaura para modal aqui, fora de

*-- Linhas 211 a 220:
211: 
212:                 THIS.ConfigurarPageFrame()
213: 
214:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
215:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
216: 
217:                 THIS.TornarControlesVisiveis(THIS)
218:                 THIS.Visible = .T.
219: 
220:                 *-- "ExcluiItem/Shape2/Shape3.Visible" do Init legado. Vem

*-- Linhas 226 a 247:
226:                 *-- FIM do Init legado, que as fases anteriores descartaram:
227:                 *--   Select Historico / Go Bottom / Go Top
228:                 *--   ThisForm.Get_Barra.Value = ''
229:                 *-- (o SetFocus que fecha o Init legado esta no Activate -
230:                 *-- antes de a tela estar visivel ele estoura).
231:                 IF USED("cursor_4c_Historico")
232:                     SELECT cursor_4c_Historico
233:                     GO BOTTOM
234:                     GO TOP
235:                 ENDIF
236: 
237:                 *-- 0, nunca "": o controle e NUMERICO (ver CmdExcluiitemClick)
238:                 THIS.txt_4c_Barra.Value = 0
239:                 THIS.HabilitarCampos()
240: 
241:                 loc_lSucesso = .T.
242:             ENDIF
243:         CATCH TO loc_oErro
244:             MsgErro(loc_oErro.Message + CHR(13) + ;
245:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
246:                     "Procedure: " + loc_oErro.Procedure, ;
247:                     "Erro em InicializarForm")

*-- Linhas 287 a 313:
287:     *--------------------------------------------------------------------------
288:     PROTECTED PROCEDURE ConfigurarCampos()
289:         *-- Say5 / Get_Barra ("Barra :")
290:         THIS.AddObject("lbl_4c_Label5", "Label")
291:         WITH THIS.lbl_4c_Label5
292:             .Top       = 96
293:             .Left      = 54
294:             .Width     = 35
295:             .Height    = 15
296:             .AutoSize  = .F.
297:             .Alignment = 0
298:             .BackStyle = 0
299:             .FontName  = "Tahoma"
300:             .FontSize  = 8
301:             .ForeColor = RGB(90, 90, 90)
302:             .Caption   = "Barra :"
303:         ENDWITH
304: 
305:         THIS.AddObject("txt_4c_Barra", "TextBox")
306:         WITH THIS.txt_4c_Barra
307:             .Top           = 92
308:             .Left          = 94
309:             .Width         = 108
310:             .Height        = 23
311:             .FontName      = "Courier New"
312:             .FontSize      = 9
313:             .FontBold      = .F.

*-- Linhas 325 a 351:
325:         ENDWITH
326: 
327:         *-- lbl_produto / Get_Produto ("Produto :")
328:         THIS.AddObject("lbl_4c_Lbl_produto", "Label")
329:         WITH THIS.lbl_4c_Lbl_produto
330:             .Top       = 121
331:             .Left      = 42
332:             .Width     = 47
333:             .Height    = 15
334:             .AutoSize  = .F.
335:             .Alignment = 0
336:             .BackStyle = 0
337:             .FontName  = "Tahoma"
338:             .FontSize  = 8
339:             .ForeColor = RGB(90, 90, 90)
340:             .Caption   = "Produto :"
341:         ENDWITH
342: 
343:         THIS.AddObject("txt_4c_Produto", "TextBox")
344:         WITH THIS.txt_4c_Produto
345:             .Top           = 117
346:             .Left          = 94
347:             .Width         = 108
348:             .Height        = 23
349:             .FontName      = "Courier New"
350:             .FontSize      = 9
351:             .FontBold      = .F.

*-- Linhas 364 a 390:
364:         ENDWITH
365: 
366:         *-- lbl_descricao / Get_Descricao ("Descricao :") - campo de EXIBICAO
367:         THIS.AddObject("lbl_4c_Lbl_descricao", "Label")
368:         WITH THIS.lbl_4c_Lbl_descricao
369:             .Top       = 146
370:             .Left      = 34
371:             .Width     = 55
372:             .Height    = 15
373:             .AutoSize  = .F.
374:             .Alignment = 0
375:             .BackStyle = 0
376:             .FontName  = "Tahoma"
377:             .FontSize  = 8
378:             .ForeColor = RGB(90, 90, 90)
379:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
380:         ENDWITH
381: 
382:         THIS.AddObject("txt_4c_Descricao", "TextBox")
383:         WITH THIS.txt_4c_Descricao
384:             .Top           = 142
385:             .Left          = 94
386:             .Width         = 290
387:             .Height        = 23
388:             .FontName      = "Courier New"
389:             .FontSize      = 9
390:             .FontBold      = .F.

*-- Linhas 406 a 432:
406:         *-- lbl_peso_medio / Get_Peso ("Peso :") - campo de EXIBICAO (When /
407:         *-- Return(.F.) no legado - nunca recebe foco, so e preenchido pelos
408:         *-- lookups de Barra/Produto)
409:         THIS.AddObject("lbl_4c_Lbl_peso_medio", "Label")
410:         WITH THIS.lbl_4c_Lbl_peso_medio
411:             .Top       = 171
412:             .Left      = 57
413:             .Width     = 32
414:             .Height    = 15
415:             .AutoSize  = .F.
416:             .Alignment = 0
417:             .BackStyle = 0
418:             .FontName  = "Tahoma"
419:             .FontSize  = 8
420:             .ForeColor = RGB(90, 90, 90)
421:             .Caption   = "Peso :"
422:         ENDWITH
423: 
424:         THIS.AddObject("txt_4c_Peso", "TextBox")
425:         WITH THIS.txt_4c_Peso
426:             .Top           = 167
427:             .Left          = 94
428:             .Width         = 52
429:             .Height        = 23
430:             .FontName      = "Courier New"
431:             .FontSize      = 9
432:             .FontBold      = .F.

*-- Linhas 447 a 473:
447: 
448:         *-- Say1 / Get_Linha ("Linha :") - campo de EXIBICAO (When /
449:         *-- Return(.F.) no legado)
450:         THIS.AddObject("lbl_4c_Label1", "Label")
451:         WITH THIS.lbl_4c_Label1
452:             .Top       = 196
453:             .Left      = 55
454:             .Width     = 34
455:             .Height    = 15
456:             .AutoSize  = .F.
457:             .Alignment = 0
458:             .BackStyle = 0
459:             .FontName  = "Tahoma"
460:             .FontSize  = 8
461:             .ForeColor = RGB(90, 90, 90)
462:             .Caption   = "Linha :"
463:         ENDWITH
464: 
465:         THIS.AddObject("txt_4c_Linha", "TextBox")
466:         WITH THIS.txt_4c_Linha
467:             .Top           = 192
468:             .Left          = 94
469:             .Width         = 290
470:             .Height        = 23
471:             .FontName      = "Courier New"
472:             .FontSize      = 9
473:             .FontBold      = .F.

*-- Linhas 506 a 526:
506:     PROTECTED PROCEDURE ConfigurarImagem()
507:         THIS.AddObject("shp_4c_ShpFigura", "Shape")
508:         WITH THIS.shp_4c_ShpFigura
509:             .Top           = 86
510:             .Left          = 402
511:             .Width         = 208
512:             .Height        = 128
513:             .BackStyle     = 1
514:             .SpecialEffect = 0
515:             .Visible       = .T.
516:         ENDWITH
517: 
518:         THIS.AddObject("img_4c_ImgJpg", "Image")
519:         WITH THIS.img_4c_ImgJpg
520:             .Top     = 90
521:             .Left    = 405
522:             .Width   = 201
523:             .Height  = 121
524:             .Stretch = 1
525:             .Picture = ""
526:             .Visible = .F.

*-- Linhas 598 a 619:
598:     PROCEDURE ValidarAcessoBarra()
599:         IF USED("cursor_4c_InvH")
600:             SELECT cursor_4c_InvH
601:             GO BOTTOM
602:         ENDIF
603:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
604:             THIS.grd_4c_Dados.Refresh()
605:         ENDIF
606:         THIS.PrepararLeitoraParaFoco()
607:     ENDPROC
608: 
609:     *--------------------------------------------------------------------------
610:     * ValidarBarra - BINDEVENT "LostFocus" de txt_4c_Barra: combina o
611:     * PROCEDURE Valid (consulta SigOpEtq/SigCdPro/SigCdLin, atualiza
612:     * cursor_4c_InvH, decodifica a foto, limpa o campo para a proxima
613:     * leitura) com o PROCEDURE LostFocus separado do legado (devolve o foco
614:     * a grade). LASTKEY() = 27 reproduz o "If LastKey() # 27" do legado -
615:     * ESC cancela a leitura sem limpar o campo nem avancar.
616:     *--------------------------------------------------------------------------
617:     PROCEDURE ValidarBarra()
618:         LOCAL loc_nBarra, loc_nPeso, loc_oErro, loc_lEsc, loc_lProsseguir
619: 

*-- Linhas 685 a 706:
685:         THIS.HabilitarCampos()
686: 
687:         *-- equivalente ao PROCEDURE LostFocus separado do legado
688:         THIS.ConsumirLeituraSerial(THIS.txt_4c_Barra)
689:         IF !EMPTY(THIS.txt_4c_Barra.Value)
690:             THIS.grd_4c_Dados.ActiveColumn = 1
691:             THIS.grd_4c_Dados.SetFocus()
692:         ENDIF
693:     ENDPROC
694: 
695:     *--------------------------------------------------------------------------
696:     * HabilitarCampos - o UNICO ajuste de habilitacao que o legado tem: o
697:     * "PROCEDURE When / Return(Empty(ThisForm.Get_Barra.Value))" de
698:     * Get_Produto - o campo Produto so e alcancavel quando Barra esta vazio
699:     * (sao as duas entradas ALTERNATIVAS de consulta desta tela).
700:     *
701:     * Nao recebe parametro de modo porque o legado nao tem modo: nao ha
702:     * Page2 de Dados nem ciclo de edicao - os outros campos (Descricao/Peso/
703:     * Linha) sao de EXIBICAO em TODO momento ("When / Return(.F.)" no SCX,
704:     * ja transcrito como .ReadOnly = .T. na Fase 6).
705:     *
706:     * PUBLIC (sem PROTECTED): o harness chama metodo de form de FORA da

*-- Linhas 728 a 736:
728:     * Visible = .T. em tudo.
729:     *--------------------------------------------------------------------------
730:     PROCEDURE AjustarBotoesPorModo()
731:         THIS.cmd_4c_Excluiitem.Visible = THIS.this_lExcluir
732:         THIS.shp_4c_Shape2.Visible     = THIS.this_lExcluir
733:         THIS.shp_4c_Shape3.Visible     = !THIS.this_lExcluir
734:     ENDPROC
735: 
736:     *--------------------------------------------------------------------------

*-- Linhas 803 a 824:
803:         ENDIF
804: 
805:         THIS.HabilitarCampos()
806: 
807:         *-- equivalente ao PROCEDURE LostFocus separado do legado (sem guarda)
808:         THIS.grd_4c_Dados.ActiveColumn = 1
809:         THIS.grd_4c_Dados.SetFocus()
810:     ENDPROC
811: 
812:     *--------------------------------------------------------------------------
813:     * AbrirBuscaProduto - FUNIL do picker de produto, equivalente ao
814:     * "CreateObject('fwBuscaExt', <conn>, 'SigCdPro', 'CrProds', 'CPros',
815:     * This.Value, 'Produtos', 1000)" + mAddColuna('CPros')/mAddColuna('DPros')
816:     * + Show() do Valid de Get_Produto, e ao bloco
817:     * "If LastKey() <> 27 And Used('CrProds') / This.Value = CrProds.CPros /
818:     * Get_Descricao.Value = CrProds.DPros / Else / ambos = '' / EndIf".
819:     *
820:     * Contrato do FormBuscaAuxiliar (regra CLAUDE.md #36/#37): 1o argumento e
821:     * o HANDLE da conexao; o Init ja tenta o match EXATO, entao Show() so e
822:     * chamado quando this_lAchouRegistro esta .F., e a atribuicao do valor so
823:     * acontece sob a guarda this_lSelecionou.
824:     *

*-- Linhas 896 a 928:
896:     ENDPROC
897: 
898:     *--------------------------------------------------------------------------
899:     * AtualizarCrInvHPorBarra - equivalente ao bloco final do Valid de
900:     * Get_Barra: garante que a barra lida esteja em cursor_4c_InvH, vinda de
901:     * cursor_4c_Historico (leituras anteriores desta sessao) ou, na
902:     * ausencia, do inventario em SigIvTrH (primeira leitura desta barra no
903:     * balanco ativo - CrSigCdBal e cursor GLOBAL do processo de balanco,
904:     * mantido pelo form pai).
905:     *--------------------------------------------------------------------------
906:     PROTECTED PROCEDURE AtualizarCrInvHPorBarra(par_nBarra)
907:         LOCAL loc_cEmpresa, loc_nCodBalanco, loc_nResultado
908: 
909:         THIS.DesvincularGrade()
910: 
911:         IF !SEEK(par_nBarra, "cursor_4c_InvH", "cbars")
912:             IF SEEK(par_nBarra, "cursor_4c_Historico", "cbars")
913:                 SELECT cursor_4c_Historico
914:                 SCATTER MEMVAR MEMO
915:                 INSERT INTO cursor_4c_InvH FROM MEMVAR
916:             ELSE
917:                 loc_cEmpresa    = ""
918:                 loc_nCodBalanco = 0
919:                 IF USED("crSigCdBal")
920:                     loc_cEmpresa    = TratarNulo(crSigCdBal.Emps, "")
921:                     loc_nCodBalanco = TratarNulo(crSigCdBal.Codigos, 0)
922:                 ENDIF
923: 
924:                 loc_nResultado = THIS.this_oBusinessObject.ConsultarInventarioPorBarra( ;
925:                     loc_cEmpresa, loc_nCodBalanco, par_nBarra, "cursor_4c_InvHTmp")
926: 
927:                 IF loc_nResultado < 1
928:                     MostrarErro("Favor reinicializar o processo !!!", ;

*-- Linhas 974 a 994:
974:         loc_cChave = PADR(ALLTRIM(par_cProduto), 14)
975: 
976:         THIS.DesvincularGrade()
977: 
978:         IF !SEEK(loc_cChave, "cursor_4c_InvH", "cpros")
979:             SELECT * FROM cursor_4c_Historico WHERE cpros = m.par_cProduto INTO CURSOR cursor_4c_TmpHistorico
980:             SELECT cursor_4c_TmpHistorico
981:             GO TOP
982: 
983:             IF !EOF()
984:                 SCAN
985:                     SCATTER MEMVAR MEMO
986:                     INSERT INTO cursor_4c_InvH FROM MEMVAR
987:                     SELECT cursor_4c_TmpHistorico
988:                 ENDSCAN
989:             ELSE
990:                 loc_cEmpresa    = ""
991:                 loc_nCodBalanco = 0
992:                 IF USED("crSigCdBal")
993:                     loc_cEmpresa    = TratarNulo(crSigCdBal.Emps, "")
994:                     loc_nCodBalanco = TratarNulo(crSigCdBal.Codigos, 0)

*-- Linhas 1043 a 1095:
1043:     * Fallback (modo teste/validacao de UI, sem form pai real): cria vazio
1044:     * com a estrutura de SigIvTrh e indexado, para o form instanciar sem
1045:     * erro mesmo fora do fluxo real de contagem.
1046:     *--------------------------------------------------------------------------
1047:     PROTECTED PROCEDURE ConfigurarCursorHistorico()
1048:         IF !USED("cursor_4c_Historico")
1049:             CREATE CURSOR cursor_4c_Historico ;
1050:                 (cbars N(14,0), cidchaves C(20), codcors C(4), codigos N(4,0), ;
1051:                  codtams C(4), contas C(10), cpros C(14), datas T, datatrans T, ;
1052:                  emps C(3), localis C(10), locals C(10), ntrans N(6,0), obs M, ;
1053:                  ocors C(10), pesreals N(8,2), qtds N(11,3), tipos N(1,0), ;
1054:                  usuars C(10), pesos N(12,3), coletas C(1))
1055:             SELECT cursor_4c_Historico
1056:             INDEX ON cbars TAG cbars
1057:             INDEX ON cpros TAG cpros
1058:             GO TOP
1059:         ENDIF
1060:     ENDPROC
1061: 
1062:     *--------------------------------------------------------------------------
1063:     * ConfigurarGrid - grd_4c_Dados (Grade do legado), com 5 colunas e a
1064:     * coluna Observacao usando EditBox (equivalente ao fwmemo1 do legado,
1065:     * regra CLAUDE.md #18 - Column.AddObject exige CurrentControl). O cursor
1066:     * cursor_4c_InvH (CrInvH) e clone VAZIO de cursor_4c_Historico - populado
1067:     * linha a linha nos Valid de Get_Barra/Get_Produto (Fase 6).
1068:     *--------------------------------------------------------------------------
1069:     PROTECTED PROCEDURE ConfigurarGrid()
1070:         IF USED("cursor_4c_InvH")
1071:             USE IN cursor_4c_InvH
1072:         ENDIF
1073:         SELECT * FROM cursor_4c_Historico WHERE .F. INTO CURSOR cursor_4c_InvH READWRITE
1074:         SELECT cursor_4c_InvH
1075:         INDEX ON cbars TAG cbars
1076:         INDEX ON cpros TAG cpros
1077:         GO TOP
1078: 
1079:         THIS.AddObject("grd_4c_Dados", "Grid")
1080:         WITH THIS.grd_4c_Dados
1081:             .Top               = 219
1082:             .Left              = 14
1083:             .Width             = 632
1084:             .Height            = 88
1085:             .ColumnCount       = 5
1086:             .FontName          = "Tahoma"
1087:             .FontSize          = 8
1088:             .AllowHeaderSizing = .F.
1089:             .AllowRowSizing    = .F.
1090:             .DeleteMark        = .F.
1091:             .RecordMark        = .F.
1092:             .ReadOnly          = .T.
1093:             .RowHeight         = 17
1094:             .ScrollBars        = 0
1095:             .GridLineColor     = RGB(238, 238, 238)

*-- Linhas 1105 a 1159:
1105:         *-- TRY de InicializarForm: CREATEOBJECT devolve .F. e a tela NAO ABRE.
1106:         *-- Com o bind feito antes, Column4 ja esta em "cursor_4c_InvH.obs"
1107:         *-- (campo Memo) e o EditBox e compativel.
1108:         THIS.MontaGrade()
1109: 
1110:         WITH THIS.grd_4c_Dados.Column4
1111:             .AddObject("edt_4c_Obs", "EditBox")
1112:             *-- NUNCA definir .ControlSource no CONTROLE da coluna: quem
1113:             *-- manda e o ControlSource da Column (ja em "cursor_4c_InvH.obs"
1114:             *-- pelo MontaGrade acima). Duplicar aqui estoura "Parent object
1115:             *-- will not allow this property setting" e a tela nao abre
1116:             *-- (mesma regra do CheckBox em Column - erro 1767).
1117:             WITH .edt_4c_Obs
1118:                 .FontName    = "Tahoma"
1119:                 .FontSize    = 8
1120:                 .BorderStyle = 0
1121:                 .Left        = 7
1122:                 .Top         = 24
1123:                 .ReadOnly    = .T.
1124:             ENDWITH
1125:             *-- regra CLAUDE.md #18: sem CurrentControl a Column continua
1126:             *-- desenhando o Text1 dela; sem Sparse = .F. o EditBox so
1127:             *-- aparece na linha ativa.
1128:             .CurrentControl = "edt_4c_Obs"
1129:             .Sparse         = .F.
1130:         ENDWITH
1131: 
1132:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")
1133:     ENDPROC
1134: 
1135:     *--------------------------------------------------------------------------
1136:     * MontaGrade - equivalente a THISFORM.AcertaGrade() do legado: reconecta
1137:     * grd_4c_Dados a cursor_4c_InvH. Chamado agora (bind inicial) e sera
1138:     * chamado de novo na Fase 6 depois de inserir linha nova no cursor.
1139:     * RecordSource reseta Width/Header1.Caption (CLAUDE.md "Grade perde
1140:     * cabecalhos apos RecordSource") - por isso ControlSource/Width/Header
1141:     * sao reaplicados NESTA ORDEM, sempre DEPOIS do RecordSource.
1142:     *--------------------------------------------------------------------------
1143:     PROTECTED PROCEDURE MontaGrade()
1144:         WITH THIS.grd_4c_Dados
1145:             .RecordSource = ""
1146:             .RecordSource = "cursor_4c_InvH"
1147: 
1148:             .Column1.ControlSource = "cursor_4c_InvH.cbars"
1149:             .Column2.ControlSource = "cursor_4c_InvH.localis"
1150:             .Column3.ControlSource = "cursor_4c_InvH.ocors"
1151:             .Column4.ControlSource = "cursor_4c_InvH.obs"
1152:             .Column5.ControlSource = "cursor_4c_InvH.pesreals"
1153: 
1154:             .Column1.ReadOnly  = .T.
1155:             .Column1.Movable   = .F.
1156:             .Column1.Resizable = .T.
1157:             .Column2.ReadOnly  = .T.
1158:             .Column3.ReadOnly  = .T.
1159:             .Column4.ReadOnly  = .T.

*-- Linhas 1176 a 1196:
1176:             .Column4.Width = 285
1177:             .Column5.Width = 70
1178: 
1179:             .Column1.Header1.Caption   = "Barras"
1180:             .Column1.Header1.Alignment = 2
1181:             .Column1.Header1.ForeColor = RGB(36, 84, 155)
1182:             .Column2.Header1.Caption   = "Local"
1183:             .Column2.Header1.Alignment = 2
1184:             .Column2.Header1.ForeColor = RGB(36, 84, 155)
1185:             .Column3.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
1186:             .Column3.Header1.Alignment = 2
1187:             .Column3.Header1.ForeColor = RGB(36, 84, 155)
1188:             .Column4.Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
1189:             .Column4.Header1.Alignment = 2
1190:             .Column4.Header1.ForeColor = RGB(36, 84, 155)
1191:             .Column5.Header1.Caption   = "Peso Real"
1192:             .Column5.Header1.Alignment = 2
1193:             .Column5.Header1.ForeColor = RGB(36, 84, 155)
1194: 
1195:             .Refresh()
1196:         ENDWITH

*-- Linhas 1204 a 1225:
1204:     * grade vira um retangulo branco sem cabecalho e sem coluna, sem erro, sem
1205:     * log e sem excecao, e fica assim pelo resto da vida do form porque nada
1206:     * rebinda depois. Quem religa e CarregarLista().
1207:     *--------------------------------------------------------------------------
1208:     PROTECTED PROCEDURE DesvincularGrade()
1209:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1210:             THIS.grd_4c_Dados.RecordSource = ""
1211:         ENDIF
1212:     ENDPROC
1213: 
1214:     *--------------------------------------------------------------------------
1215:     * CarregarLista - FUNIL unico de carga/repintura da grade. Transcreve o
1216:     * rodape IDENTICO dos dois Valid do legado:
1217:     *   Select CrInvH
1218:     *   Update CrInvH Set Obs = Nvl(Obs,'')
1219:     *   ThisForm.AcertaGrade()
1220:     *   Select CrInvH
1221:     *   Go Top
1222:     *
1223:     * Popular o cursor NAO repinta a grade (regra CLAUDE.md #21a): sem o
1224:     * GO TOP + Refresh no fim de TODO caminho que mexe no cursor, a grade fica
1225:     * visualmente vazia com o cursor cheio - e o sintoma ("a tela nao traz

*-- Linhas 1245 a 1266:
1245:             THIS.MontaGrade()
1246: 
1247:             SELECT cursor_4c_InvH
1248:             GO TOP
1249: 
1250:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
1251:                 THIS.grd_4c_Dados.Refresh()
1252:             ENDIF
1253: 
1254:             loc_lSucesso = .T.
1255:         ENDIF
1256: 
1257:         RETURN loc_lSucesso
1258:     ENDPROC
1259: 
1260:     *--------------------------------------------------------------------------
1261:     * FormParaBO - transfere os dois campos de ENTRADA da tela para as
1262:     * properties do BO. Sao os dois unicos campos digitaveis do SCX: Get_Barra
1263:     * (numerico, InputMask "99999999999999") e Get_Produto (char(14)); os
1264:     * outros tres sao de EXIBICAO ("When / Return(.F.)" no legado).
1265:     *
1266:     * No legado esta transferencia aparece como o proprio "This.Value" dentro

*-- Linhas 1378 a 1614:
1378:     ENDPROC
1379: 
1380:     *--------------------------------------------------------------------------
1381:     * ConfigurarBotoes - cmd_4c_Excluiitem (so visivel em modo exclusao) e
1382:     * cmd_4c_Saida, com a geometria/Picture EXATAS do dump. shp_4c_Shape2/
1383:     * shp_4c_Shape3 sao os quadros decorativos que alternam com Excluiitem
1384:     * (mesmo toggle de modo Excluir no Init legado).
1385:     *--------------------------------------------------------------------------
1386:     PROTECTED PROCEDURE ConfigurarBotoes()
1387:         THIS.AddObject("shp_4c_Shape2", "Shape")
1388:         WITH THIS.shp_4c_Shape2
1389:             .Top           = 7
1390:             .Left          = 625
1391:             .Width         = 159
1392:             .Height        = 79
1393:             .BackStyle     = 0
1394:             .BorderStyle   = 0
1395:             .SpecialEffect = 1
1396:             .Visible       = THIS.this_lExcluir
1397:         ENDWITH
1398: 
1399:         THIS.AddObject("shp_4c_Shape3", "Shape")
1400:         WITH THIS.shp_4c_Shape3
1401:             .Top           = 7
1402:             .Left          = 707
1403:             .Width         = 77
1404:             .Height        = 79
1405:             .BackStyle     = 0
1406:             .BorderStyle   = 0
1407:             .SpecialEffect = 1
1408:             .Visible       = !THIS.this_lExcluir
1409:         ENDWITH
1410: 
1411:         THIS.AddObject("cmd_4c_Excluiitem", "CommandButton")
1412:         WITH THIS.cmd_4c_Excluiitem
1413:             .Top        = 3
1414:             .Left       = 649
1415:             .Width      = 75
1416:             .Height     = 75
1417:             .FontName   = "Comic Sans MS"
1418:             .FontSize   = 8
1419:             .FontBold   = .T.
1420:             .FontItalic = .T.
1421:             .WordWrap   = .T.
1422:             .Picture    = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1423:             .Caption    = "\<Excluir"
1424:             .ForeColor  = RGB(90, 90, 90)
1425:             .BackColor  = RGB(255, 255, 255)
1426:             .Themes           = .T.
1427:             .Visible    = THIS.this_lExcluir
1428:         ENDWITH
1429:         BINDEVENT(THIS.cmd_4c_Excluiitem, "Click", THIS, "CmdExcluiitemClick")
1430: 
1431:         THIS.AddObject("cmd_4c_Saida", "CommandButton")
1432:         WITH THIS.cmd_4c_Saida
1433:             .Top         = 3
1434:             .Left        = 724
1435:             .Width       = 75
1436:             .Height      = 75
1437:             .FontName    = "Comic Sans MS"
1438:             .FontSize    = 8
1439:             .FontBold    = .T.
1440:             .FontItalic  = .T.
1441:             .WordWrap    = .T.
1442:             .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1443:             .Cancel      = .T.
1444:             .Caption     = "Sa" + CHR(237) + "da"
1445:             .ToolTipText = "[ESC]"
1446:             .ForeColor   = RGB(90, 90, 90)
1447:             .BackColor   = RGB(255, 255, 255)
1448:             .Themes           = .T.
1449:             .Visible     = .T.
1450:         ENDWITH
1451:         BINDEVENT(THIS.cmd_4c_Saida, "Click", THIS, "CmdSaidaClick")
1452:     ENDPROC
1453: 
1454:     *--------------------------------------------------------------------------
1455:     * CmdExcluiitemClick - equivalente ao PROCEDURE Click do Excluiitem
1456:     * legado: remove o item corrente (por produto, quando a leitura foi por
1457:     * produto, ou por barra) de cursor_4c_Historico/cursor_4c_InvH. Usa
1458:     * txt_4c_Barra/txt_4c_Produto, criados na Fase 5.
1459:     *--------------------------------------------------------------------------
1460:     PROCEDURE CmdExcluiitemClick()
1461:         LOCAL loc_nRecno, loc_cProduto
1462: 
1463:         *-- A chave do indice "cpros" eh char(14) (SigIvTrh.cpros), e o valor
1464:         *-- do TextBox vem TRIMADO do picker. config.prg liga SET EXACT ON
1465:         *-- globalmente, e com EXACT ON o SEEK exige a chave INTEIRA - com o
1466:         *-- valor trimado ele falha SEMPRE, o IF abaixo entra e o handler
1467:         *-- INSERE uma copia duplicada no cursor GLOBAL Historico (que o form
1468:         *-- pai continua usando depois deste dialogo fechar). PADR para a
1469:         *-- largura da coluna reproduz o match que o legado tinha com
1470:         *-- EXACT OFF. O WHERE do DELETE abaixo nao precisa (SQL do VFP segue
1471:         *-- SET ANSI, que esta OFF), mas usa o mesmo valor por coerencia.
1472:         loc_cProduto = PADR(ALLTRIM(THIS.txt_4c_Produto.Value), 14)
1473: 
1474:         SELECT cursor_4c_InvH
1475: 
1476:         DO CASE
1477:             CASE EMPTY(THIS.txt_4c_Barra.Value) AND !EMPTY(THIS.txt_4c_Produto.Value)
1478:                 SELECT cursor_4c_Historico
1479:                 IF !SEEK(loc_cProduto, "cursor_4c_Historico", "cpros")
1480:                     SELECT cursor_4c_InvH
1481:                     SCATTER MEMVAR MEMO
1482:                     INSERT INTO cursor_4c_Historico FROM MEMVAR
1483:                 ENDIF
1484:                 SELECT cursor_4c_Historico
1485:                 GO TOP
1486:                 DELETE FROM cursor_4c_Historico WHERE cpros = m.loc_cProduto
1487:                 SELECT cursor_4c_Historico
1488:                 GO TOP
1489:                 SELECT cursor_4c_InvH
1490:                 DELETE FROM cursor_4c_InvH
1491: 
1492:             CASE !EMPTY(THIS.txt_4c_Barra.Value)
1493:                 IF !SEEK(cursor_4c_InvH.cbars, "cursor_4c_Historico", "cbars")
1494:                     SELECT cursor_4c_InvH
1495:                     SCATTER MEMVAR MEMO
1496:                     INSERT INTO cursor_4c_Historico FROM MEMVAR
1497:                 ENDIF
1498:                 SELECT cursor_4c_Historico
1499:                 loc_nRecno = RECNO("cursor_4c_Historico")
1500:                 GO TOP
1501:                 GO loc_nRecno
1502:                 DELETE IN cursor_4c_Historico
1503:                 SELECT cursor_4c_InvH
1504:                 DELETE IN cursor_4c_InvH
1505: 
1506:             OTHERWISE
1507:                 THIS.grd_4c_Dados.SetFocus()
1508:                 THIS.grd_4c_Dados.Refresh()
1509:                 THIS.Refresh()
1510:                 *-- txt_4c_Barra nasce NUMERICO (.Value = 0, transcrito do
1511:                 *-- dump: "Get_Barra / Value = 0 / InputMask =
1512:                 *-- 99999999999999"). O legado limpa com '' e por isso o
1513:                 *-- controle dele VIRA caractere no meio da sessao - aqui nao
1514:                 *-- da para copiar isso: cbars eh numeric(14,0) e o
1515:                 *-- AtualizarCrInvHPorBarra faz SEEK nesse indice, que estoura
1516:                 *-- "Operator/operand type mismatch" com chave caractere.
1517:                 *-- Zerar mantem o tipo e o mesmo EMPTY() do legado.
1518:                 THIS.txt_4c_Barra.Value = 0
1519:                 THIS.txt_4c_Barra.SetFocus()
1520:                 RETURN
1521:         ENDCASE
1522: 
1523:         SELECT cursor_4c_InvH
1524:         GO BOTTOM
1525:         THIS.grd_4c_Dados.SetFocus()
1526:         THIS.grd_4c_Dados.Refresh()
1527:         THIS.Refresh()
1528:         *-- mesma razao do bloco OTHERWISE: zerar, nunca "" (tipo NUMERICO)
1529:         THIS.txt_4c_Barra.Value = 0
1530:         *-- Barra zerado reabre o campo Produto (When do legado)
1531:         THIS.HabilitarCampos()
1532: 
1533:         IF EOF("cursor_4c_InvH")
1534:             *-- grade vazia: o legado esconde o botao de excluir e volta o
1535:             *-- quadro de consulta, INDEPENDENTE do modo - por isso as tres
1536:             *-- linhas literais aqui, e nao AjustarBotoesPorModo() (que
1537:             *-- reporia Visible = this_lExcluir e traria o botao de volta
1538:             *-- sobre uma grade sem nenhuma linha para excluir).
1539:             THIS.cmd_4c_Excluiitem.Visible = .F.
1540:             THIS.shp_4c_Shape2.Visible     = .F.
1541:             THIS.shp_4c_Shape3.Visible     = .T.
1542:             THIS.txt_4c_Barra.SetFocus()
1543:         ENDIF
1544:     ENDPROC
1545: 
1546:     *--------------------------------------------------------------------------
1547:     * CmdSaidaClick - equivalente ao PROCEDURE Click do botao Sa?da legado.
1548:     * NAO fecha cursor_4c_Historico - e global, continua aberto no form pai.
1549:     *--------------------------------------------------------------------------
1550:     PROCEDURE CmdSaidaClick()
1551:         IF USED("cursor_4c_Historico")
1552:             SELECT cursor_4c_Historico
1553:             SET ORDER TO
1554:             GO BOTTOM
1555:         ENDIF
1556:         THIS.Release()
1557:     ENDPROC
1558: 
1559:     *--------------------------------------------------------------------------
1560:     * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
1561:     * labels de titulo sobrepostos (sombra preta + titulo branco).
1562:     * Geometria TRANSCRITA do dump: SIGOPCIM.cntSombra/lblSombra/lblTitulo.
1563:     *--------------------------------------------------------------------------
1564:     PROTECTED PROCEDURE ConfigurarCabecalho()
1565:         THIS.AddObject("cnt_4c_Sombra", "Container")
1566:         WITH THIS.cnt_4c_Sombra
1567:             .Top         = 0
1568:             .Left        = 0
1569:             .Width       = THIS.Width
1570:             .Height      = 80
1571:             .BackColor   = RGB(100, 100, 100)
1572:             .BackStyle   = 1
1573:             .BorderWidth = 0
1574:             .Visible     = .T.
1575:         ENDWITH
1576: 
1577:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
1578:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
1579:             .Top           = 18
1580:             .Left          = 10
1581:             .Width         = 769
1582:             .Height        = 40
1583:             .AutoSize      = .F.
1584:             .BackStyle     = 0
1585:             .WordWrap      = .T.
1586:             .Alignment     = 0
1587:             .FontName      = "Tahoma"
1588:             .FontSize      = 18
1589:             .FontBold      = .T.
1590:             .FontUnderline = .F.
1591:             .ForeColor     = RGB(0, 0, 0)
1592:             .Caption       = THIS.Caption
1593:         ENDWITH
1594: 
1595:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
1596:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
1597:             .Top         = 17
1598:             .Left        = 10
1599:             .Width       = 769
1600:             .Height      = 46
1601:             .AutoSize    = .F.
1602:             .BackStyle   = 0
1603:             .WordWrap    = .T.
1604:             .Alignment   = 0
1605:             .FontName    = "Tahoma"
1606:             .FontSize    = 18
1607:             .FontBold    = .T.
1608:             .ForeColor   = RGB(255, 255, 255)
1609:             .Caption     = THIS.Caption
1610:             .ToolTipText = "T" + CHR(237) + "tulo"
1611:         ENDWITH
1612:     ENDPROC
1613: 
1614:     *--------------------------------------------------------------------------

*-- Linhas 1631 a 1639:
1631:                 *-- quem decide e ConfigurarBotoes()/CmdExcluiitemClick(),
1632:                 *-- NUNCA forcar Visible=.T. aqui (regra dos containers/
1633:                 *-- controles flutuantes do form OPERACIONAL).
1634:                 IF INLIST(loc_cNome, "CMD_4C_EXCLUIITEM", "SHP_4C_SHAPE2", "SHP_4C_SHAPE3", "IMG_4C_IMGJPG")
1635:                     LOOP
1636:                 ENDIF
1637: 
1638:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1639:                     loc_oControl.Visible = .T.

*-- Linhas 1647 a 1667:
1647:     ENDPROC
1648: 
1649:     *--------------------------------------------------------------------------
1650:     * Destroy - FormBase.Destroy ja libera this_oBusinessObject e restaura o
1651:     * menu do sistema. cursor_4c_InvH e de uso exclusivo deste dialogo e e
1652:     * fechado aqui; cursor_4c_Historico e GLOBAL (o form pai continua
1653:     * usando-o depois que este form fecha - o proprio CmdSaidaClick legado
1654:     * so reposiciona, nunca fecha) e por isso NAO e fechado aqui. Fechamento
1655:     * dos cursores temporarios de lookup (TmpBar/TmpPro/TmpLinha) entra na
1656:     * Fase 6, quando esses cursores passam a existir.
1657:     *--------------------------------------------------------------------------
1658:     PROCEDURE Destroy()
1659:         IF USED("cursor_4c_InvH")
1660:             USE IN cursor_4c_InvH
1661:         ENDIF
1662:         IF USED("cursor_4c_BuscaProduto")
1663:             USE IN cursor_4c_BuscaProduto
1664:         ENDIF
1665:         IF USED("cursor_4c_TmpHistorico")
1666:             USE IN cursor_4c_TmpHistorico
1667:         ENDIF


### BO (C:\4c\projeto\app\classes\sigopcimBO.prg):
*==============================================================================
* sigopcimBO.prg - Business Object para Consulta/Exclusao de Imagem (Leitura de Barras)
* Tabela principal: Historico (cursor local de leitura de codigos de barras)
* Cursor de grade: CrInvH (Barras/Local/Ocorrencia/Observacao/Peso Real)
* Form original: SIGOPCIM.scx (Consulta Imagem / Exclusao de Barras)
*==============================================================================

DEFINE CLASS sigopcimBO AS BusinessBase

    *-- Codigo de barras lido/digitado (Get_Barra). NUMERICO: medido no
    *-- docs/schema.sql, SigOpEtq.cbars e SigIvTrh.cbars sao numeric(14,0), e o
    *-- proprio SCX declara "Get_Barra / Value = 0 / InputMask =
    *-- 99999999999999" - ou seja a tela tambem digita numero. Guardar como
    *-- char obrigaria a converter nos dois sentidos (STR na ida, VAL na volta)
    *-- numa chave de 14 digitos, e qualquer SEEK no indice "cbars" (que e
    *-- numerico) com chave caractere estoura "Operator/operand type
    *-- mismatch" - a MESMA armadilha que a Fase 7 corrigiu no TextBox.
    this_nBarra      = 0     && numeric(14,0)  SigOpEtq.cbars / SigIvTrh.cbars

    *-- Produto associado a barra (Get_Produto) - FK SigCdPro.CPros
    this_cProduto    = ""    && char(20)  Codigo do Produto (FK SigCdPro.CPros)

    *-- Descricao do produto (Get_Descricao) - somente exibicao, vem do lookup
    this_cDescricao  = ""    && char(60)  Descricao do Produto (FK SigCdPro.DPros)

    *-- Peso medio/real associado a barra (Get_Peso)
    this_nPeso       = 0     && numeric(10,3)  Peso do item

    *-- Linha de producao associada a barra (Get_Linha)
    this_cLinha      = ""    && char(40)  Linha / observacao associada ao item

    *-- Colunas do registro de Historico/CrInvH (cursor_4c_Dados da grade)
    this_cLocal        = ""    && char(10)  Historico.Localis - local da leitura
    this_cOcorrencia   = ""    && char(10)  Historico.Ocors   - ocorrencia do item
    this_mObs          = ""    && memo      Historico.Obs     - observacao do item
    this_nPesoReal     = 0     && numeric(8,2) Historico.PesReals - peso real lido

    *-- Foto do produto (SigCdPro.FigJpgs), usada so para gerar o arquivo .jpg
    *-- temporario exibido em ImgJpg - nunca persistida pelo BO.
    this_mFigJpgs      = ""

    *-- Flags de resultado das consultas (Valid de Get_Barra/Get_Produto)
    this_lBarraLocalizada    = .F.   && .T. quando SigOpEtq achou o CBars
    this_lProdutoLocalizado  = .F.   && .T. quando SigCdPro achou o CPros

    *-- .T. quando o SQLEXEC da consulta falhou (equivalente ao
    *-- "If ...SqlExecute(lStrQuery,'TmpBar') < 1" do legado, que exibe
    *-- "Favor reinicializar o processo !!!" e ABORTA o Valid com Return(.F.)).
    *-- Nao da para sinalizar isso pelo retorno da funcao: ela ja devolve .T.
    *-- tambem quando a consulta roda e nao acha nada, que NAO e erro (regra
    *-- CLAUDE.md #50 - universo vazio nao e erro). Zero linha e falha de
    *-- conexao sao resultados DIFERENTES e o legado os trata diferente.
    this_lFalhaConexao       = .F.   && .T. quando SQLEXEC devolveu < 1

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "Historico"
        THIS.this_cCampoChave = "CBars"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - CBars (Historico/CrInvH.CBars) e a chave logica do
    * item de leitura; na ausencia de barra (modo so-por-produto), a chave
    * passa a ser o codigo do produto (CPros), igual ao Case do Excluiitem.Click
    * legado (Empty(Get_Barra.Value) And !Empty(Get_Produto.Value)).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        *-- A chave da auditoria e CARACTERE (RegistrarAuditoria a concatena na
        *-- string do INSERT), por isso o STR aqui - a property segue numerica.
        IF THIS.this_nBarra != 0
            RETURN ALLTRIM(STR(THIS.this_nBarra, 14))
        ENDIF
        RETURN ALLTRIM(THIS.this_cProduto)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - mapeia uma linha de Historico/CrInvH (par_cAliasCursor)
    * para as properties do BO. E o shape da grade (Barras/Local/Ocorrencia/
    * Observacao/Peso Real), nao o shape dos lookups de Barra/Produto - esses
    * tem metodo proprio (ConsultarBarra/ConsultarProduto) porque vem de
    * tabelas diferentes (SigOpEtq/SigCdPro) com colunas diferentes.
    *
    * Regra CLAUDE.md #8: SELECT (par_cAliasCursor) antes de acessar campos.
    * CBars e numeric(14,0) no schema e a property e numerica (ver
    * this_nBarra) - nada de converter para char no caminho.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_nBarra      = TratarNulo(cbars, 0)
                THIS.this_cProduto    = TratarNulo(cpros, "")
                THIS.this_cLocal      = TratarNulo(localis, "")
                THIS.this_cOcorrencia = TratarNulo(ocors, "")
                THIS.this_mObs        = TratarNulo(obs, "")
                THIS.this_nPesoReal   = TratarNulo(pesreals, 0)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConsultarBarra - replica o 1o SQLEXEC do Valid de Get_Barra: busca a
    * etiqueta em SigOpEtq pelo codigo de barras. Achando, preenche o Produto
    * e o Peso que a tela espelha; sem achar, so desliga o flag de localizacao
    * (o legado, nesse caso, simplesmente nao atualiza os campos - regra
    * CLAUDE.md #50, universo vazio nao e erro).
    *==========================================================================
    FUNCTION ConsultarBarra(par_nCbars)
        LOCAL loc_lSucesso, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_lBarraLocalizada = .F.
        THIS.this_lFalhaConexao    = .F.

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_CimEtq")
                    USE IN cursor_4c_CimEtq
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT CBars, CPros, Pesos FROM SigOpEtq WHERE CBars = " + FormatarNumeroSQL(par_nCbars, 0), ;
                    "cursor_4c_CimEtq")

                *-- mesmo criterio do legado ("SqlExecute(...) < 1"). A
                *-- atribuicao fica DENTRO da guarda de conexao: sem handle o
                *-- loc_nResultado nunca e atribuido (nasce .F. logico) e
                *-- compara-lo com 1 estouraria "Operator/operand type
                *-- mismatch" justamente em modo teste/validacao de UI.
                THIS.this_lFalhaConexao = (loc_nResultado < 1)

                IF loc_nResultado >= 0 AND USED("cursor_4c_CimEtq") AND RECCOUNT("cursor_4c_CimEtq") > 0
                    SELECT cursor_4c_CimEtq
                    GO TOP

                    THIS.this_lBarraLocalizada = .T.
                    THIS.this_nBarra   = TratarNulo(CBars, 0)
                    THIS.this_cProduto = TratarNulo(CPros, "")
                    THIS.this_nPeso    = TratarNulo(Pesos, 0)
                ENDIF

                IF USED("cursor_4c_CimEtq")
                    USE IN cursor_4c_CimEtq
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConsultarProduto - replica o SQLEXEC do Valid de Get_Produto: busca o
    * produto em SigCdPro, com a descricao da linha via Left Join SigCdLin
    * (mesma consulta do legado: a.CPros,a.Linhas,a.FigJpgs,b.Descs). Achando,
    * preenche Linha (Descs) e a foto (FigJpgs, para DecodificarEGravarFoto);
    * Peso fica zerado, igual ao legado (ThisForm.Get_Peso.Value = 0).
    *
    * this_cDescricao (a.DPros) tambem e preenchido aqui - e o mesmo SigCdPro
    * que o fluxo de Get_Barra.Valid consulta (lcConsulta = CursorQuery(
    * 'SigCdPro','TmpPro','CPros',...,'CPros,DPros,Linhas,FigJpgs')), so que
    * o legado faz isso em DUAS CursorQuery separadas (SigCdPro + SigCdLin);
    * aqui as duas foram unificadas num LEFT JOIN so. O Form (fluxo de
    * Get_Produto) e quem decide SE usa this_cDescricao - o legado nunca
    * atualiza Get_Descricao.Value no Valid de Get_Produto, so no de
    * Get_Barra.
    *==========================================================================
    FUNCTION ConsultarProduto(par_cCodProduto)
        LOCAL loc_lSucesso, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_lProdutoLocalizado = .F.
        THIS.this_lFalhaConexao      = .F.

        *-- Limpa o que esta consulta PRODUZ, antes de consultar. Nao e zelo:
        *-- no fluxo da BARRA o legado le TmpPro/TmpLinha SEM guarda de EOF
        *-- ("Get_Produto.Value = TmpPro.CPros / Get_Descricao.Value =
        *-- TmpPro.DPros / ..."), ou seja com o produto AUSENTE ele atribui o
        *-- valor vazio do cursor e a tela LIMPA. Sem este reset as properties
        *-- guardariam o resultado da leitura ANTERIOR, e o usuario veria a
        *-- descricao e a FOTO do produto antigo associadas a barra nova -
        *-- divergencia silenciosa, sem erro nenhum.
        THIS.this_cProduto   = ""
        THIS.this_cDescricao = ""
        THIS.this_nPeso      = 0
        THIS.this_cLinha     = ""
        THIS.this_mFigJpgs   = ""

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_CimPro")
                    USE IN cursor_4c_CimPro
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT a.CPros, a.DPros, a.Linhas, a.FigJpgs, b.Descs " + ;
                    "FROM SigCdPro a LEFT JOIN SigCdLin b ON b.Linhas = a.Linhas " + ;
                    "WHERE a.CPros = " + EscaparSQL(ALLTRIM(par_cCodProduto)), ;
                    "cursor_4c_CimPro")

                *-- mesmo criterio do legado ("SqlExecute(...,'TmpPro') < 1");
                *-- DENTRO da guarda de conexao pelo mesmo motivo de
                *-- ConsultarBarra.
                THIS.this_lFalhaConexao = (loc_nResultado < 1)

                IF loc_nResultado >= 0 AND USED("cursor_4c_CimPro") AND RECCOUNT("cursor_4c_CimPro") > 0
                    SELECT cursor_4c_CimPro
                    GO TOP

                    THIS.this_lProdutoLocalizado = .T.
                    THIS.this_cProduto   = TratarNulo(CPros, "")
                    THIS.this_cDescricao = TratarNulo(DPros, "")
                    THIS.this_nPeso      = 0
                    THIS.this_cLinha     = TratarNulo(Descs, "")
                    THIS.this_mFigJpgs   = TratarNulo(FigJpgs, "")
                ENDIF

                IF USED("cursor_4c_CimPro")
                    USE IN cursor_4c_CimPro
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConsultarInventarioPorBarra - replica o fallback de SigIvTrH do Valid de
    * Get_Barra, usado quando o item nao esta em CrInvH nem em Historico:
    * Select * From SigIvTrH Where Emps = <emp> And Codigos = <balanco> And
    * CBars = <barra>. par_cCursorDestino recebe o resultado (0 ou 1 linha);
    * quem monta Emps/Codigos e o Form, a partir do cursor global do balanco
    * ativo (CrSigCdBal no legado) - este BO nao conhece esse cursor.
    *==========================================================================
    FUNCTION ConsultarInventarioPorBarra(par_cEmpresa, par_nCodigoBalanco, par_nCbars, par_cCursorDestino)
        LOCAL loc_nResultado

        loc_nResultado = -1

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigIvTrH WHERE Emps = " + EscaparSQL(ALLTRIM(par_cEmpresa)) + ;
                    " AND Codigos = " + FormatarNumeroSQL(par_nCodigoBalanco, 0) + ;
                    " AND CBars = " + FormatarNumeroSQL(par_nCbars, 0), ;
                    par_cCursorDestino)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_nResultado = -1
        ENDTRY

        RETURN loc_nResultado
    ENDFUNC

    *==========================================================================
    * ConsultarInventarioPorProduto - mesmo fallback do ConsultarInventarioPor
    * Barra, mas pelo CPros (Valid de Get_Produto quando !Seek(This.Value,
    * 'CrInvH','CPros')).
    *==========================================================================
    FUNCTION ConsultarInventarioPorProduto(par_cEmpresa, par_nCodigoBalanco, par_cCodProduto, par_cCursorDestino)
        LOCAL loc_nResultado

        loc_nResultado = -1

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigIvTrH WHERE Emps = " + EscaparSQL(ALLTRIM(par_cEmpresa)) + ;
                    " AND Codigos = " + FormatarNumeroSQL(par_nCodigoBalanco, 0) + ;
                    " AND CPros = " + EscaparSQL(ALLTRIM(par_cCodProduto)), ;
                    par_cCursorDestino)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_nResultado = -1
        ENDTRY

        RETURN loc_nResultado
    ENDFUNC

    *==========================================================================
    * DecodificarEGravarFoto - replica a decodificacao da foto do produto (bloco
    * dentro do With ThisForm do Valid de Get_Barra/Get_Produto): remove os tres
    * prefixos "data:image/..." e decodifica o Base64 restante UMA UNICA VEZ
    * (Strconv(...,14) - decodificar duas vezes corrompe o JPEG, o binario
    * resultante nao e base64). Grava o JPEG binario direto em par_cCaminho
    * Destino; quem exibe (Image.Picture) e apaga o arquivo depois e o Form.
    *==========================================================================
    FUNCTION DecodificarEGravarFoto(par_mFigJpgs, par_cCaminhoDestino)
        LOCAL loc_cFoto, loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_mFigJpgs) AND !ISNULL(par_mFigJpgs)
            loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(par_mFigJpgs, ;
                "data:image/png;base64,", ""), ;
                "data:image/jpeg;base64,", ""), ;
                "data:image/jpg;base64,", ""), 14)

            IF STRTOFILE(loc_cFoto, par_cCaminhoDestino) > 0
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir/Atualizar/ExecutarExclusao - NAO sobrescritos de proposito. O
    * SIGOPCIM legado nunca grava em tabela SQL Server nenhuma: as unicas
    * escritas do form (Excluiitem.Click) sao Insert/Delete em cursores VFP
    * locais (Historico/CrInvH), que o Form ja recebe abertos do ParentForm -
    * nao ha chave SQL para gravar nem auditoria de banco para registrar.
    * O comportamento padrao herdado de BusinessBase (recusar a operacao com
    * mensagem) ja e o correto para esta entidade.
    *==========================================================================

ENDDEFINE

