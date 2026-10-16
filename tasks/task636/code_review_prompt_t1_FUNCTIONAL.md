# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_RESULT, CNT_4C_BARRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Name()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Importa' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprmdp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1140 linhas total):

*-- Linhas 4 a 47:
4: * Tabela principal (fila de recalculo de custo): SigOpClC
5: *
6: * FASE 8/8 (FINAL) - liga e implementa os 3 botoes de acao principal via
7: * BINDEVENT em RegistrarEventos(): cmd_4c_BtnProcessar -> BtnProcessarClick
8: * (motor de substituicao, delega o SQL para sigprmdpBO.ProcessarPar/
9: * ValidarParSubstituicao), cmd_4c_Exporta -> ExportaClick (importacao de
10: * pares via planilha XLS) e cmd_4c_BtnSair -> BtnEncerrarClick (Release).
11: * O SCX legado NAO tem botao Salvar/Cancelar/Buscar/Alterar/Visualizar
12: * (form OPERACIONAL, sem modos CRUD) - esses handlers permanecem no-op,
13: * documentados individualmente. FormParaBO/BOParaForm ganham sentido real
14: * aqui: copiam o par da linha corrente de cursor_4c_Dados <-> as properties
15: * this_cProsAnt/this_cProsNov/this_nBarraAnt/this_lFlag do BO.
16: *
17: * Fases anteriores: ConfigurarCampos() completa o container cnt_4c_Result
18: * (cntResult do legado) com o painel de progresso (lbl_4c_Label1
19: * "Progresso :" + cnt_4c_Barra/shp_4c_ShpBarra/lbl_4c_LblPorcento) e o
20: * bloco Produto/Arquivo (Fase 5). ConfigurarGrid() tem o UNICO lookup deste
21: * form (legado: SIGPRMDP.Grade.Column1.Text1.Valid, fwBuscaExt contra
22: * SigCdPro), instalado via Column.AddObject("txt_4c_CelCprosAnt",
23: * "TextBoxProdutoAntMdp_4c") + CurrentControl + Sparse (regra #18), com o
24: * corpo em ValidarCProsAntGridExec (regra #46: Valid do TextBox da coluna,
25: * nunca AfterRowColChange).
26: *
27: * GAP DOCUMENTADO (regra #27): o motor de substituicao do legado varria
28: * QUALQUER tabela/coluna catalogada no arquivo LOCAL ArqDBF.DBF (FoxPro,
29: * Sys(5)+Sys(2003)+'\ArqDBF.dbf') e descobria a chave primaria via a view
30: * vindsql - nenhum dos dois existe no SQL Server (confirmado contra
31: * docs/schema.sql). sigprmdpBO.MapearTabelasAlvo() reproduz o MESMO filtro
32: * (mesma lista de 14 nomes de coluna, mesmo limite de tamanho 10/14,
33: * mesmas exclusoes) via INFORMATION_SCHEMA.COLUMNS, lido do schema REAL e
34: * atual em vez de um catalogo local que podia estar desatualizado. As
35: * funcoes globais fRecalculaP()/fRecalculaC() (recalculo de custo/estoque)
36: * tambem nao vieram no acervo - ProcessarPar() enfileira em SigOpClC para
37: * recalculo externo em vez de tentar reproduzir o calculo, e NUNCA
38: * exclui linhas de SigMvEst (a exclusao no legado so era segura porque
39: * fRecalculaP recriava o saldo sob o codigo novo) - o Form avisa o usuario
40: * quando ha saldo de SigMvEst aguardando revisao manual.
41: *------------------------------------------------------------------------------
42: 
43: DEFINE CLASS Formsigprmdp AS FormBase
44: 
45:     Height      = 270
46:     Width       = 800
47:     AutoCenter  = .T.

*-- Linhas 70 a 228:
70:     * Init - define Caption com CHR() e replica os parametros do Init legado
71:     * (Lparameters pCheckCad, lcNomeFrm1) antes de delegar ao FormBase.
72:     *--------------------------------------------------------------------------
73:     PROCEDURE Init(par_lCheckCadPro, par_cNomeForm)
74:         LOCAL loc_cNomeForm
75: 
76:         THIS.Caption = "Substitui" + CHR(231) + CHR(227) + "o de Refer" + CHR(234) + "ncias de Produtos"
77: 
78:         THIS.this_lCheckCadPro = (VARTYPE(par_lCheckCadPro) = "L" AND par_lCheckCadPro)
79: 
80:         *-- Legado: lcNomeFrm1 = Upper(Iif(Type('lcNomeFrm1')=='C' And Not Empty(lcNomeFrm1),lcNomeFrm1,ThisForm.Name))
81:         *-- ThisForm.Manterbarra = (lcNomeFrm1 = 'SIGPRMDPB'). Nao renomeamos
82:         *-- THIS.Name (renomear Form em runtime nao faz parte da arquitetura
83:         *-- nova) - so a flag de comportamento e preservada.
84:         loc_cNomeForm = UPPER(IIF(VARTYPE(par_cNomeForm) = "C" AND !EMPTY(par_cNomeForm), par_cNomeForm, THIS.Name))
85:         THIS.this_lManterBarra = (loc_cNomeForm == "SIGPRMDPB")
86: 
87:         *-- ShowWindow=0 na classe evitaria travar em VFP9 -T (top-level window
88:         *-- bloqueante) durante testes automatizados; producao restaura modal aqui.
89:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
90:              (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
91:             THIS.WindowType = 1
92:             THIS.ShowWindow = 1
93:         ENDIF
94: 
95:         RETURN DODEFAULT()
96:     ENDPROC
97: 
98:     *--------------------------------------------------------------------------
99:     * InicializarForm - monta estrutura base do form operacional
100:     *--------------------------------------------------------------------------
101:     PROTECTED PROCEDURE InicializarForm()
102:         LOCAL loc_lSucesso, loc_oErro
103:         loc_lSucesso = .F.
104: 
105:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
106:             RETURN .T.
107:         ENDIF
108: 
109:         TRY
110:             THIS.this_oBusinessObject = CREATEOBJECT("sigprmdpBO")
111:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
112:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigprmdpBO.", ;
113:                         "Erro em InicializarForm")
114:             ELSE
115:                 *-- Propaga as flags resolvidas no Init() (par_lCheckCadPro/
116:                 *-- nome do form) para o BO - ValidarParSubstituicao/
117:                 *-- ProcessarPar leem a COPIA do BO, nao a do Form.
118:                 THIS.this_oBusinessObject.this_lCheckCadPro = THIS.this_lCheckCadPro
119:                 THIS.this_oBusinessObject.this_lManterBarra = THIS.this_lManterBarra
120: 
121:                 *-- Legado (Load): "lcQuery = Select CalcCustos From SigCdPaC
122:                 *-- Order By CalcCustos" + "Thisform.CalculaCusto =
123:                 *-- (CrSigCdPac.CalcCustos <> 3)".
124:                 IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
125:                     IF USED("cursor_4c_Pac")
126:                         USE IN cursor_4c_Pac
127:                     ENDIF
128:                     IF SQLEXEC(gnConnHandle, "SELECT CalcCustos FROM SigCdPaC ORDER BY CalcCustos", "cursor_4c_Pac") > 0 ;
129:                        AND USED("cursor_4c_Pac") AND RECCOUNT("cursor_4c_Pac") > 0
130:                         THIS.this_lCalculaCusto = (TratarNulo(cursor_4c_Pac.CalcCustos, 0) != 3)
131:                     ENDIF
132:                     IF USED("cursor_4c_Pac")
133:                         USE IN cursor_4c_Pac
134:                     ENDIF
135:                 ENDIF
136:                 THIS.this_oBusinessObject.this_lCalculaCusto = THIS.this_lCalculaCusto
137: 
138:                 *-- Cursor local da grade de edicao (equivalente a csContas do
139:                 *-- Load legado) - tem de existir ANTES de ConfigurarPageFrame
140:                 *-- montar o Grid (regra #41: ControlSource de cursor
141:                 *-- inexistente derruba o Init).
142:                 IF USED("cursor_4c_Dados")
143:                     USE IN cursor_4c_Dados
144:                 ENDIF
145:                 CREATE CURSOR cursor_4c_Dados (CprosAnt C(14), CprosNov C(14), Flag L, BarraAnt N(8))
146:                 INDEX ON CprosAnt + CprosNov TAG Duplica
147:                 INDEX ON CprosAnt TAG CprosAnt
148:                 INDEX ON CprosNov TAG CprosNov
149:                 SET ORDER TO
150:                 INSERT INTO cursor_4c_Dados (CprosAnt, CprosNov) VALUES ("", "")
151: 
152:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
153: 
154:                 THIS.ConfigurarPageFrame()
155: 
156:                 THIS.TornarControlesVisiveis(THIS)
157:                 THIS.RegistrarEventos()
158: 
159:                 loc_lSucesso = .T.
160:             ENDIF
161:         CATCH TO loc_oErro
162:             MsgErro(loc_oErro.Message + CHR(13) + ;
163:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
164:                     "Procedure: " + loc_oErro.Procedure, ;
165:                     "Erro em InicializarForm")
166:         ENDTRY
167: 
168:         RETURN loc_lSucesso
169:     ENDPROC
170: 
171:     *--------------------------------------------------------------------------
172:     * ConfigurarPageFrame - orquestra montagem visual do form OPERACIONAL.
173:     * Nao ha PageFrame real (legado herda de "form" generico, sem
174:     * frmcadastro/Page1=Lista/Page2=Dados); o metodo so encadeia os
175:     * configuradores especificos, na ordem em que o SCX desenha os controles.
176:     *--------------------------------------------------------------------------
177:     PROTECTED PROCEDURE ConfigurarPageFrame()
178:         THIS.ConfigurarCabecalho()
179:         THIS.ConfigurarBotoes()
180:         THIS.ConfigurarGrid()
181:         THIS.ConfigurarCampos()
182:     ENDPROC
183: 
184:     *--------------------------------------------------------------------------
185:     * ConfigurarCabecalho - cria o container escuro superior (cntSombra do
186:     * legado) com os dois labels de titulo (sombra preta + titulo branco).
187:     *--------------------------------------------------------------------------
188:     PROTECTED PROCEDURE ConfigurarCabecalho()
189:         LOCAL loc_oCab
190: 
191:         THIS.AddObject("cnt_4c_Sombra", "Container")
192:         loc_oCab = THIS.cnt_4c_Sombra
193:         WITH loc_oCab
194:             .Top         = 0
195:             .Left        = 0
196:             .Width       = THIS.Width
197:             .Height      = 80
198:             .BackStyle   = 1
199:             .BackColor   = RGB(100,100,100)
200:             .BorderWidth = 0
201:         ENDWITH
202: 
203:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
204:         WITH loc_oCab.lbl_4c_LblSombra
205:             .AutoSize      = .F.
206:             .Top           = 18
207:             .Left          = 10
208:             .Width         = 769
209:             .Height        = 40
210:             .FontName      = "Tahoma"
211:             .FontSize      = 18
212:             .FontBold      = .T.
213:             .FontUnderline = .F.
214:             .WordWrap      = .T.
215:             .Alignment     = 0
216:             .BackStyle     = 0
217:             .ForeColor     = RGB(0,0,0)
218:             .Caption       = THIS.Caption
219:         ENDWITH
220: 
221:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
222:         WITH loc_oCab.lbl_4c_LblTitulo
223:             .AutoSize    = .F.
224:             .Top         = 17
225:             .Left        = 10
226:             .Width       = 769
227:             .Height      = 46
228:             .FontName    = "Tahoma"

*-- Linhas 247 a 290:
247:     * faixa do cabecalho (Top=0..80) e precisa desenhar por cima dela
248:     * (regra #11/#29). Handlers de Click sao ligados nas Fases 7-8.
249:     *--------------------------------------------------------------------------
250:     PROTECTED PROCEDURE ConfigurarBotoes()
251:         THIS.AddObject("shp_4c_Shape1", "Shape")
252:         WITH THIS.shp_4c_Shape1
253:             .Top         = 7
254:             .Left        = 502
255:             .Height      = 110
256:             .Width       = 90
257:             .BackStyle   = 0
258:             .BorderStyle = 0
259:             .BorderColor = RGB(136, 189, 188)
260:             .Visible     = .T.
261:         ENDWITH
262: 
263:         THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
264:         WITH THIS.cmd_4c_BtnSair
265:             .Top        = 3
266:             .Left       = 725
267:             .Height     = 75
268:             .Width      = 75
269:             .FontBold   = .T.
270:             .FontItalic = .T.
271:             .FontName   = "Comic Sans MS"
272:             .FontSize   = 8
273:             .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
274:             .Cancel     = .T.
275:             .Caption    = "Encerrar"
276:             .ForeColor  = RGB(90, 90, 90)
277:             .BackColor  = RGB(255, 255, 255)
278:             .Themes           = .T.
279:             .Visible    = .T.
280:         ENDWITH
281: 
282:         THIS.AddObject("cmd_4c_BtnProcessar", "CommandButton")
283:         WITH THIS.cmd_4c_BtnProcessar
284:             .Top        = 3
285:             .Left       = 650
286:             .Height     = 75
287:             .Width      = 75
288:             .FontBold   = .T.
289:             .FontItalic = .T.
290:             .FontName   = "Comic Sans MS"

*-- Linhas 353 a 491:
353:         ENDWITH
354:     ENDPROC
355: 
356:     *--------------------------------------------------------------------------
357:     * ConfigurarGrid - grd_4c_Dados (Grade do legado): grid de edicao local
358:     * dos pares Codigo Original/Novo Codigo, ligado a cursor_4c_Dados
359:     * (criado em InicializarForm, antes de ConfigurarPageFrame). Colunas
360:     * simples, sem AddObject de controle customizado (Text1/Header1 nativos,
361:     * igual ao legado). RecordSource por ultimo, depois de Width/Header -
362:     * aqui nao ha CarregarLista que rebinde depois (grade de edicao local,
363:     * nao consulta SQL), entao a ordem nao sofre o reset da regra #41/
364:     * Problema 48.
365:     *--------------------------------------------------------------------------
366:     PROTECTED PROCEDURE ConfigurarGrid()
367:         LOCAL loc_oGrid
368: 
369:         THIS.AddObject("grd_4c_Dados", "Grid")
370:         loc_oGrid = THIS.grd_4c_Dados
371: 
372:         *-- RecordSource/ColumnCount ANTES da configuracao das colunas (regra
373:         *-- #41/Problema 48): mexer neles DEPOIS reseta Width/Header/
374:         *-- CurrentControl das colunas ja configuradas.
375:         loc_oGrid.ColumnCount = 3
376:         loc_oGrid.RecordSource = "cursor_4c_Dados"
377:         loc_oGrid.ColumnCount  = 2
378: 
379:         WITH loc_oGrid
380:             .Top               = 101
381:             .Left              = 147
382:             .Width             = 269
383:             .Height            = 148
384:             .FontName          = "Tahoma"
385:             .FontSize          = 8
386:             .AllowHeaderSizing = .F.
387:             .AllowRowSizing    = .F.
388:             .DeleteMark        = .F.
389:             .RecordMark        = .F.
390:             .HeaderHeight      = 18
391:             .RowHeight         = 18
392:             .ScrollBars        = 2
393:             .ReadOnly          = .F.
394:             .Visible           = .T.
395:         ENDWITH
396: 
397:         WITH loc_oGrid.Column1
398:             .Width             = 118
399:             .ReadOnly          = .F.
400:             .Header1.Caption   = "C" + CHR(243) + "digo Original"
401:             .Header1.Alignment = 2
402:             .Header1.FontName  = "Tahoma"
403:             .Header1.FontSize  = 8
404:             .ControlSource     = "cursor_4c_Dados.CprosAnt"
405:         ENDWITH
406: 
407:         *-- Lookup de produto (legado: Column1.Text1.Valid, com Checkcadpro=.F.
408:         *-- chama fwBuscaExt contra SigCdPro). Column.AddObject sozinho NAO
409:         *-- exibe o controle - precisa de CurrentControl + Sparse (regra #18);
410:         *-- a validacao mora no Valid do TextBox da coluna (regra #46), NUNCA
411:         *-- em AfterRowColChange.
412:         loc_oGrid.Column1.AddObject("txt_4c_CelCprosAnt", "TextBoxProdutoAntMdp_4c")
413:         loc_oGrid.Column1.CurrentControl = "txt_4c_CelCprosAnt"
414:         loc_oGrid.Column1.Sparse         = .F.
415: 
416:         WITH loc_oGrid.Column2
417:             .Width             = 118
418:             .ReadOnly          = .F.
419:             .Header1.Caption   = "Novo C" + CHR(243) + "digo"
420:             .Header1.Alignment = 2
421:             .Header1.FontName  = "Tahoma"
422:             .Header1.FontSize  = 8
423:             .ControlSource     = "cursor_4c_Dados.CprosNov"
424:         ENDWITH
425:         IF PEMSTATUS(loc_oGrid.Column2, "Text1", 5)
426:             WITH loc_oGrid.Column2.Text1
427:                 .BorderStyle = 0
428:                 .Margin      = 0
429:                 .ForeColor   = RGB(0, 0, 0)
430:                 .BackColor   = RGB(255, 255, 255)
431:             ENDWITH
432:         ENDIF
433:     ENDPROC
434: 
435:     *--------------------------------------------------------------------------
436:     * ConfigurarCampos - cnt_4c_Result (cntResult do legado): painel que
437:     * exibe o produto/arquivo em processamento durante btnProcessar.Click.
438:     * Fica OCULTO por padrao (replica ThisForm.cntResult.Visible = .f. do
439:     * Init legado - por isso TornarControlesVisiveis filtra este container,
440:     * ver PROCEDURE TornarControlesVisiveis) e so e exibido explicitamente
441:     * no inicio do processamento (Fase 7-8).
442:     *
443:     * Produto (lbl_4c_Label2 + txt_4c_Cpros), Arquivo/Campo (lbl_4c_Label5 +
444:     * txt_4c_Arquivo) e, desde a Fase 6, o painel de progresso (lbl_4c_Label1
445:     * "Progresso :" + cnt_4c_Barra com shp_4c_ShpBarra/lbl_4c_LblPorcento).
446:     * Ambos os TextBoxes sao ReadOnly: o legado so os preenche por codigo
447:     * durante o loop de processamento (ThisForm.Grade / controlesReferenciados
448:     * "Get_Cpros" em btnProcessar.Click) - nao ha Valid/evento de digitacao
449:     * para eles em comportamento.json.
450:     *--------------------------------------------------------------------------
451:     PROTECTED PROCEDURE ConfigurarCampos()
452:         LOCAL loc_oResult
453: 
454:         THIS.AddObject("cnt_4c_Result", "Container")
455:         loc_oResult = THIS.cnt_4c_Result
456:         WITH loc_oResult
457:             .Top         = 101
458:             .Left        = 440
459:             .Width       = 213
460:             .Height      = 146
461:             .BackStyle   = 1
462:             .BackColor   = RGB(255, 255, 255)
463:             .BorderWidth = 1
464:             .Visible     = .F.
465:         ENDWITH
466: 
467:         loc_oResult.AddObject("lbl_4c_Label2", "Label")
468:         WITH loc_oResult.lbl_4c_Label2
469:             .Top       = 2
470:             .Left      = 8
471:             .AutoSize  = .T.
472:             .Alignment = 0
473:             .BackStyle = 0
474:             .FontName  = "Tahoma"
475:             .FontSize  = 8
476:             .ForeColor = RGB(90, 90, 90)
477:             .Caption   = "Produto : "
478:         ENDWITH
479: 
480:         loc_oResult.AddObject("txt_4c_Cpros", "TextBox")
481:         WITH loc_oResult.txt_4c_Cpros
482:             .Top      = 19
483:             .Left     = 5
484:             .Width    = 108
485:             .Height   = 24
486:             .FontName = "Tahoma"
487:             .FontSize = 8
488:             .ReadOnly = .T.
489:             .Value    = ""
490:         ENDWITH
491: 

*-- Linhas 577 a 922:
577:     * a validacao eh pulada e o codigo digitado fica como esta.
578:     *--------------------------------------------------------------------------
579:     FUNCTION ValidarCProsAntGridExec(par_oTxt)
580:         LOCAL loc_oBusca, loc_cCpros, loc_oErro
581: 
582:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
583:             RETURN .T.
584:         ENDIF
585: 
586:         IF THIS.this_lCheckCadPro
587:             RETURN .T.
588:         ENDIF
589: 
590:         loc_cCpros = ALLTRIM(IIF(VARTYPE(par_oTxt) = "O", par_oTxt.Value, cursor_4c_Dados.CprosAnt))
591: 
592:         *-- Legado: "Else / This.Value = ''" - campo vazio nao abre lookup.
593:         IF EMPTY(loc_cCpros)
594:             IF VARTYPE(par_oTxt) = "O"
595:                 par_oTxt.Value = ""
596:             ENDIF
597:             SELECT cursor_4c_Dados
598:             REPLACE CprosAnt WITH "" IN cursor_4c_Dados
599:             RETURN .T.
600:         ENDIF
601: 
602:         TRY
603:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
604:                 "SigCdPro", "cursor_4c_BuscaProdMdp", "Cpros", loc_cCpros, ;
605:                 "Sele" + CHR(231) + CHR(227) + "o")
606: 
607:             IF VARTYPE(loc_oBusca) = "O"
608:                 *-- Init ja resolveu o match exato; so abre o picker se nao achou
609:                 *-- (regra #37) - sem MsgAviso nem clear do digitado (regra #50)
610:                 IF !loc_oBusca.this_lAchouRegistro
611:                     loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
612:                     loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
613:                     loc_oBusca.Show()
614:                 ENDIF
615: 
616:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProdMdp")
617:                     IF RECCOUNT("cursor_4c_BuscaProdMdp") > 0
618:                         SELECT cursor_4c_BuscaProdMdp
619:                         loc_cCpros = ALLTRIM(cursor_4c_BuscaProdMdp.Cpros)
620:                         SELECT cursor_4c_Dados
621:                         REPLACE CprosAnt WITH loc_cCpros IN cursor_4c_Dados
622:                         *-- O codigo escolhido tem de voltar para a CELULA tambem,
623:                         *-- senao o texto digitado sobrescreve o cursor (regra #46)
624:                         IF VARTYPE(par_oTxt) = "O"
625:                             par_oTxt.Value = loc_cCpros
626:                         ENDIF
627:                     ENDIF
628:                 ENDIF
629: 
630:                 loc_oBusca.Release()
631:             ENDIF
632:         CATCH TO loc_oErro
633:             MsgErro(loc_oErro.Message, "Formsigprmdp.ValidarCProsAntGridExec")
634:         ENDTRY
635: 
636:         IF USED("cursor_4c_BuscaProdMdp")
637:             USE IN cursor_4c_BuscaProdMdp
638:         ENDIF
639: 
640:         RETURN .T.
641:     ENDFUNC
642: 
643:     *--------------------------------------------------------------------------
644:     * RegistrarEventos - vincula eventos dos controles via BINDEVENT.
645:     * Liga os 2 botoes de manutencao da grade local (cmd_4c_BtnIncluir/
646:     * cmd_4c_BtnExcluir) e, desde a Fase 8, os 3 botoes de acao principal:
647:     * cmd_4c_BtnProcessar (btnProcessar.Click legado), cmd_4c_Exporta
648:     * (Exporta.Click legado - o nome do objeto e "Exporta" mas a Caption e o
649:     * comportamento sao de IMPORTACAO, mantidos fieis ao legado) e
650:     * cmd_4c_BtnSair (btnSair.Click legado -> ThisForm.Release). Nao ha
651:     * botoes Alterar/Visualizar no SCX legado (form OPERACIONAL, sem modos
652:     * CRUD). TesteAutomatico.prg tambem chama BtnIncluirClick()/
653:     * BtnExcluirClick() direto no form, sem depender deste BINDEVENT.
654:     *--------------------------------------------------------------------------
655:     PROTECTED PROCEDURE RegistrarEventos()
656:         BINDEVENT(THIS.cmd_4c_BtnIncluir, "Click", THIS, "BtnIncluirClick")
657:         BINDEVENT(THIS.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirClick")
658:         BINDEVENT(THIS.cmd_4c_BtnProcessar, "Click", THIS, "BtnProcessarClick")
659:         BINDEVENT(THIS.cmd_4c_Exporta, "Click", THIS, "ExportaClick")
660:         BINDEVENT(THIS.cmd_4c_BtnSair, "Click", THIS, "BtnEncerrarClick")
661:     ENDPROC
662: 
663:     *--------------------------------------------------------------------------
664:     * TornarControlesVisiveis - torna todos os controles visiveis
665:     * recursivamente. FILTRO: cnt_4c_Result (painel de progresso, criado na
666:     * Fase 5) replica o "ThisForm.cntResult.Visible = .f." do Init legado -
667:     * fica oculto por padrao e so aparece durante o processamento.
668:     *--------------------------------------------------------------------------
669:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
670:         LOCAL loc_i, loc_oControl
671: 
672:         FOR loc_i = 1 TO par_oContainer.ControlCount
673:             loc_oControl = par_oContainer.Controls(loc_i)
674:             IF VARTYPE(loc_oControl) = "O"
675:                 IF UPPER(loc_oControl.Name) = "CNT_4C_RESULT"
676:                     LOOP
677:                 ENDIF
678:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
679:                     loc_oControl.Visible = .T.
680:                 ENDIF
681:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
682:                     THIS.TornarControlesVisiveis(loc_oControl)
683:                 ENDIF
684:             ENDIF
685:         ENDFOR
686:     ENDPROC
687: 
688:     *--------------------------------------------------------------------------
689:     * ConfigurarPaginaLista - form OPERACIONAL sem Page1=Lista; o grid de
690:     * pares de substituicao (grd_4c_Dados/cursor_4c_Dados) e criado direto
691:     * no form em ConfigurarGrid() (Fase 4). Metodo mantido apenas por
692:     * conformidade de contrato com o pipeline.
693:     *--------------------------------------------------------------------------
694:     PROCEDURE ConfigurarPaginaLista()
695:         RETURN
696:     ENDPROC
697: 
698:     *--------------------------------------------------------------------------
699:     * ConfigurarPaginaDados - form OPERACIONAL sem Page2=Dados separada.
700:     * Metodo mantido apenas por conformidade de contrato com o pipeline.
701:     *--------------------------------------------------------------------------
702:     PROCEDURE ConfigurarPaginaDados()
703:         RETURN
704:     ENDPROC
705: 
706:     *--------------------------------------------------------------------------
707:     * AlternarPagina - form OPERACIONAL sem PageFrame; nao ha alternancia
708:     * entre paginas. par_nPagina eh ignorado.
709:     *--------------------------------------------------------------------------
710:     PROCEDURE AlternarPagina(par_nPagina)
711:         RETURN
712:     ENDPROC
713: 
714:     *--------------------------------------------------------------------------
715:     * CarregarLista - form OPERACIONAL sem grid de registros do banco.
716:     * cursor_4c_Dados eh grade de EDICAO local (pares a trocar), populada
717:     * por BtnIncluirClick/Exporta, nao por uma consulta de listagem.
718:     *--------------------------------------------------------------------------
719:     PROCEDURE CarregarLista()
720:         RETURN
721:     ENDPROC
722: 
723:     *--------------------------------------------------------------------------
724:     * AjustarBotoesPorModo - form OPERACIONAL sem modos CRUD
725:     * (LISTA/INCLUIR/ALTERAR/VISUALIZAR). Metodo mantido por conformidade.
726:     *--------------------------------------------------------------------------
727:     PROCEDURE AjustarBotoesPorModo()
728:         RETURN
729:     ENDPROC
730: 
731:     *--------------------------------------------------------------------------
732:     * BtnIncluirClick - Append Blank em cursor_4c_Dados (legado: btnIncluir.
733:     * Click), so quando a ultima linha ja tem os dois codigos preenchidos -
734:     * evita acumular linhas vazias ao clicar repetidamente.
735:     *--------------------------------------------------------------------------
736:     PROCEDURE BtnIncluirClick()
737:         IF !USED("cursor_4c_Dados")
738:             RETURN
739:         ENDIF
740: 
741:         SELECT cursor_4c_Dados
742:         IF !EMPTY(CprosAnt) AND !EMPTY(CprosNov)
743:             APPEND BLANK
744:         ENDIF
745: 
746:         THIS.grd_4c_Dados.Refresh()
747:         THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
748:     ENDPROC
749: 
750:     *--------------------------------------------------------------------------
751:     * BtnAlterarClick - nao ha botao Alterar no layout do SCX legado.
752:     *--------------------------------------------------------------------------
753:     PROCEDURE BtnAlterarClick()
754:         RETURN
755:     ENDPROC
756: 
757:     *--------------------------------------------------------------------------
758:     * BtnVisualizarClick - nao ha botao Visualizar no layout do SCX legado.
759:     *--------------------------------------------------------------------------
760:     PROCEDURE BtnVisualizarClick()
761:         RETURN
762:     ENDPROC
763: 
764:     *--------------------------------------------------------------------------
765:     * BtnExcluirClick - Delete na linha corrente de cursor_4c_Dados (legado:
766:     * btnExcluir.Click). Sem confirmacao e sem PACK, igual ao legado.
767:     *--------------------------------------------------------------------------
768:     PROCEDURE BtnExcluirClick()
769:         IF !USED("cursor_4c_Dados")
770:             RETURN
771:         ENDIF
772: 
773:         SELECT cursor_4c_Dados
774:         DELETE
775: 
776:         THIS.grd_4c_Dados.Refresh()
777:         THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
778:     ENDPROC
779: 
780:     *--------------------------------------------------------------------------
781:     * BtnBuscarClick - nao ha botao Buscar no layout do SCX legado.
782:     *--------------------------------------------------------------------------
783:     PROCEDURE BtnBuscarClick()
784:         RETURN
785:     ENDPROC
786: 
787:     *--------------------------------------------------------------------------
788:     * BtnSalvarClick - nao ha botao "Salvar" no SCX legado; a acao principal
789:     * deste form e "Processar" (btnProcessar.Click -> BtnProcessarClick(),
790:     * ligado em RegistrarEventos a cmd_4c_BtnProcessar). Mantido no-op por
791:     * conformidade de contrato com o pipeline (padrao CRUD).
792:     *--------------------------------------------------------------------------
793:     PROCEDURE BtnSalvarClick()
794:         RETURN
795:     ENDPROC
796: 
797:     *--------------------------------------------------------------------------
798:     * BtnCancelarClick - nao ha botao "Cancelar" no SCX legado; fechar a
799:     * tela e feito por btnSair.Click -> BtnEncerrarClick() (cmd_4c_BtnSair).
800:     * Mantido no-op por conformidade de contrato com o pipeline (padrao CRUD).
801:     *--------------------------------------------------------------------------
802:     PROCEDURE BtnCancelarClick()
803:         RETURN
804:     ENDPROC
805: 
806:     *--------------------------------------------------------------------------
807:     * BtnEncerrarClick - legado: SIGPRMDP.btnSair.Click = "ThisForm.Release".
808:     * Ligado a cmd_4c_BtnSair em RegistrarEventos.
809:     *--------------------------------------------------------------------------
810:     PROCEDURE BtnEncerrarClick()
811:         THIS.Release()
812:     ENDPROC
813: 
814:     *--------------------------------------------------------------------------
815:     * BtnProcessarClick - legado: SIGPRMDP.btnProcessar.Click. Valida TODOS
816:     * os pares da grade (mesma ordem de checagens do Scan csContas legado),
817:     * pede confirmacao e so entao processa par a par via
818:     * this_oBusinessObject.ProcessarPar() (motor de substituicao multi-
819:     * tabela, BO), atualizando o painel de progresso (cnt_4c_Result) a cada
820:     * par concluido. Para no primeiro par que falhar, igual ao legado
821:     * (Exit do Scan quando lnErro < 1).
822:     *--------------------------------------------------------------------------
823:     PROCEDURE BtnProcessarClick()
824:         LOCAL loc_nErro, loc_nTotal, loc_nFeito, loc_lTudoOk, ;
825:               loc_cProsAnt, loc_cProsNov, loc_nI
826:         LOCAL ARRAY loc_aPendAnt[1], loc_aPendNov[1]
827: 
828:         IF !USED("cursor_4c_Dados")
829:             RETURN
830:         ENDIF
831: 
832:         SELECT cursor_4c_Dados
833:         GO TOP
834:         IF EOF()
835:             MsgAviso("N" + CHR(227) + "o Existem Contas a Serem Processadas!!!", ;
836:                 "Aten" + CHR(231) + CHR(227) + "o!!!")
837:             THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
838:             RETURN
839:         ENDIF
840: 
841:         *-- Validacao de TODOS os pares antes de perguntar confirmacao
842:         *-- (legado: primeiro Scan do btnProcessar.Click so valida e sai com
843:         *-- Return no primeiro erro, sem perguntar nada ainda).
844:         SELECT cursor_4c_Dados
845:         SCAN
846:             loc_nErro = THIS.this_oBusinessObject.ValidarParSubstituicao( ;
847:                 cursor_4c_Dados.CprosAnt, cursor_4c_Dados.CprosNov)
848: 
849:             DO CASE
850:             CASE loc_nErro = 1
851:                 MsgAviso("Existe Uma Refer" + CHR(234) + "ncia Antiga Inv" + CHR(225) + "lida!!!", ;
852:                     "Aten" + CHR(231) + CHR(227) + "o!!!")
853:                 THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
854:                 RETURN
855:             CASE loc_nErro = 2
856:                 MsgAviso("Existe Uma Refer" + CHR(234) + "ncia Antigo Sem Barra !!!", ;
857:                     "Aten" + CHR(231) + CHR(227) + "o!!!")
858:                 THIS.grd_4c_Dados.SetFocus()
859:                 RETURN
860:             CASE loc_nErro = 3
861:                 MsgAviso("Existe Uma Refer" + CHR(234) + "ncia Nova Inv" + CHR(225) + "lida!!!", ;
862:                     "Aten" + CHR(231) + CHR(227) + "o!!!")
863:                 THIS.grd_4c_Dados.SetFocus()
864:                 RETURN
865:             CASE loc_nErro = 4
866:                 MsgAviso("Existe Uma Refer" + CHR(234) + "ncia Antiga e Uma Refer" + CHR(234) + ;
867:                     "ncia Nova Com o Mesmo C" + CHR(243) + "digo!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
868:                 THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
869:                 RETURN
870:             CASE loc_nErro = 5
871:                 MsgAviso("Existe Uma Refer" + CHR(234) + "ncia Antiga e Uma Refer" + CHR(234) + ;
872:                     "ncia Nova com Controle de Estoque diferente!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
873:                 THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
874:                 RETURN
875:             ENDCASE
876: 
877:             *-- BarraAnt resolvido pela validacao (regra BOParaForm: a
878:             *-- property do BO e a FONTE, a linha do grid so espelha)
879:             THIS.BOParaForm()
880:         ENDSCAN
881: 
882:         IF !MsgConfirma("Confirma a Troca das Refer" + CHR(234) + "ncias ?", ;
883:             "Confirma" + CHR(231) + CHR(227) + "o do Processamento!!!")
884:             THIS.cmd_4c_BtnSair.SetFocus()
885:             RETURN
886:         ENDIF
887: 
888:         THIS.HabilitarCampos(.F.)
889:         THIS.cnt_4c_Result.Visible = .T.
890:         THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width = 0
891:         THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
892: 
893:         SELECT cursor_4c_Dados
894:         GO TOP
895:         loc_nTotal  = RECCOUNT()
896:         loc_nFeito  = 0
897:         loc_lTudoOk = .T.
898: 
899:         SCAN
900:             loc_cProsAnt = cursor_4c_Dados.CprosAnt
901:             loc_cProsNov = cursor_4c_Dados.CprosNov
902: 
903:             THIS.cnt_4c_Result.txt_4c_Cpros.Value = ALLTRIM(loc_cProsAnt)
904:             THIS.cnt_4c_Result.Refresh()
905: 
906:             IF THIS.this_oBusinessObject.ProcessarPar(loc_cProsAnt, loc_cProsNov)
907:                 REPLACE Flag WITH .T. IN cursor_4c_Dados
908:                 =fGravarLog("C", THIS.Name, "INSERIR", ;
909:                     "DE:" + ALLTRIM(loc_cProsAnt) + " PARA:" + ALLTRIM(loc_cProsNov), ;
910:                     TratarNulo(gc_4c_UsuarioLogado, ""))
911:             ELSE
912:                 loc_lTudoOk = .F.
913:             ENDIF
914: 
915:             loc_nFeito = loc_nFeito + 1
916:             THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width = INT((loc_nFeito * 100) / loc_nTotal) * 2
917:             THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = ;
918:                 ALLTRIM(STR(INT((loc_nFeito * 100) / loc_nTotal))) + " %"
919:             THIS.cnt_4c_Result.cnt_4c_Barra.Refresh()
920: 
921:             IF !loc_lTudoOk
922:                 EXIT

*-- Linhas 933 a 1140:
933:             *-- legado: "Delete For flag" (remove so as linhas JA processadas,
934:             *-- mantendo as ainda nao processadas para reprocessar). Reconstrucao via
935:             *-- array em vez de DELETE+SET DELETED (DataSession=2 nasce com
936:             *-- SET DELETED OFF e nao herda o SET global - regra #9.4).
937:             loc_nI = 0
938:             SELECT cursor_4c_Dados
939:             SCAN FOR !Flag
940:                 loc_nI = loc_nI + 1
941:                 DIMENSION loc_aPendAnt[loc_nI], loc_aPendNov[loc_nI]
942:                 loc_aPendAnt[loc_nI] = cursor_4c_Dados.CprosAnt
943:                 loc_aPendNov[loc_nI] = cursor_4c_Dados.CprosNov
944:             ENDSCAN
945: 
946:             SELECT cursor_4c_Dados
947:             ZAP
948:             IF loc_nI = 0
949:                 APPEND BLANK
950:             ELSE
951:                 FOR loc_nI = 1 TO ALEN(loc_aPendAnt, 1)
952:                     APPEND BLANK
953:                     REPLACE CprosAnt WITH loc_aPendAnt[loc_nI], ;
954:                             CprosNov WITH loc_aPendNov[loc_nI] IN cursor_4c_Dados
955:                 ENDFOR
956:             ENDIF
957:             GO TOP
958: 
959:             MsgAviso("Existem Produtos que n" + CHR(227) + "o Foram Alterados!!!", "Reprocessar!!!")
960:         ENDIF
961: 
962:         IF THIS.this_oBusinessObject.this_lSigMvEstPendente
963:             MsgAviso("Saldos de estoque (SigMvEst) ligados a este par precisam de revis" + ;
964:                 CHR(227) + "o manual - o recalculo autom" + CHR(225) + "tico dessa tabela n" + ;
965:                 CHR(227) + "o foi portado.", "Aten" + CHR(231) + CHR(227) + "o!!!")
966:         ENDIF
967: 
968:         THIS.grd_4c_Dados.Refresh()
969:         THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
970:     ENDPROC
971: 
972:     *--------------------------------------------------------------------------
973:     * ExportaClick - legado: SIGPRMDP.Exporta.Click (nome do objeto e
974:     * "Exporta", mas Caption/comportamento sao de IMPORTACAO de planilha XLS
975:     * com pares Codigo Original/Novo Codigo - mantido fiel ao legado, so o
976:     * nome do objeto migrado e que segue o PILAR 3). Ligado a cmd_4c_Exporta
977:     * em RegistrarEventos.
978:     *--------------------------------------------------------------------------
979:     PROCEDURE ExportaClick()
980:         LOCAL loc_cArquivo, loc_cSQL, loc_nResultado, loc_cProsAnt, loc_cProsNov, ;
981:               loc_nTotal, loc_nFeito
982: 
983:         loc_cArquivo = GETFILE("XLS")
984:         IF EMPTY(loc_cArquivo)
985:             MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informado!!!", ;
986:                 "Aten" + CHR(231) + CHR(227) + "o")
987:             RETURN
988:         ENDIF
989: 
990:         IF !FILE(loc_cArquivo)
991:             MsgAviso("O arquivo [" + ALLTRIM(loc_cArquivo) + "]" + CHR(13) + ;
992:                 "n" + CHR(227) + "o foi encontrado ou o acesso foi negado!!! Verifique!!!", ;
993:                 "Aten" + CHR(231) + CHR(227) + "o")
994:             RETURN
995:         ENDIF
996: 
997:         IF USED("cursor_4c_Importa")
998:             USE IN cursor_4c_Importa
999:         ENDIF
1000:         CREATE CURSOR cursor_4c_Importa (CprosAnt C(14), CprosNov C(14))
1001:         INDEX ON CprosAnt TAG CprosAnt
1002: 
1003:         SELECT cursor_4c_Importa
1004:         APPEND FROM (loc_cArquivo) TYPE XLS
1005: 
1006:         loc_nTotal = RECCOUNT("cursor_4c_Importa")
1007:         loc_nFeito = 0
1008: 
1009:         SELECT cursor_4c_Importa
1010:         SCAN
1011:             loc_nFeito = loc_nFeito + 1
1012:             WAIT WINDOW "Aguarde Importando Produtos !" + STR(loc_nTotal - loc_nFeito) NOWAIT
1013: 
1014:             loc_cProsAnt = TratarNulo(cursor_4c_Importa.CprosAnt, "")
1015:             loc_cProsNov = TratarNulo(cursor_4c_Importa.CprosNov, "")
1016: 
1017:             IF EMPTY(loc_cProsAnt) OR EMPTY(loc_cProsNov) OR ;
1018:                UPPER(ALLTRIM(loc_cProsAnt)) == UPPER(ALLTRIM(loc_cProsNov))
1019:                 LOOP
1020:             ENDIF
1021: 
1022:             IF !THIS.this_lCheckCadPro
1023:                 loc_cSQL = "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + ;
1024:                     EscaparSQL(LEFT(ALLTRIM(loc_cProsAnt), 14))
1025:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTmpPro")
1026:                 IF loc_nResultado < 1 OR !USED("cursor_4c_ImpTmpPro") OR RECCOUNT("cursor_4c_ImpTmpPro") = 0
1027:                     IF USED("cursor_4c_ImpTmpPro")
1028:                         USE IN cursor_4c_ImpTmpPro
1029:                     ENDIF
1030:                     LOOP
1031:                 ENDIF
1032:                 USE IN cursor_4c_ImpTmpPro
1033:             ENDIF
1034: 
1035:             *-- Duplicata eh checada pela chave POSICIONAL (CprosAnt+CprosNov,
1036:             *-- os dois C(14)) - NUNCA ALLTRIM aqui, senao o SEEK nunca casa
1037:             *-- (regra #42).
1038:             IF !SEEK(loc_cProsAnt + loc_cProsNov, "cursor_4c_Dados", "Duplica")
1039:                 SELECT cursor_4c_Dados
1040:                 APPEND BLANK
1041:                 REPLACE CprosAnt WITH loc_cProsAnt, CprosNov WITH loc_cProsNov IN cursor_4c_Dados
1042:             ENDIF
1043:         ENDSCAN
1044: 
1045:         SELECT cursor_4c_Dados
1046:         GO BOTTOM
1047:         THIS.grd_4c_Dados.Refresh()
1048:         WAIT CLEAR
1049: 
1050:         USE IN cursor_4c_Importa
1051:     ENDPROC
1052: 
1053:     *--------------------------------------------------------------------------
1054:     * FormParaBO - copia o par da linha CORRENTE de cursor_4c_Dados para
1055:     * this_oBusinessObject (usado antes de validar/processar o par).
1056:     *--------------------------------------------------------------------------
1057:     PROTECTED PROCEDURE FormParaBO()
1058:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1059:             RETURN
1060:         ENDIF
1061: 
1062:         THIS.this_oBusinessObject.this_cProsAnt  = cursor_4c_Dados.CprosAnt
1063:         THIS.this_oBusinessObject.this_cProsNov  = cursor_4c_Dados.CprosNov
1064:         THIS.this_oBusinessObject.this_lFlag     = cursor_4c_Dados.Flag
1065:         THIS.this_oBusinessObject.this_nBarraAnt = cursor_4c_Dados.BarraAnt
1066:     ENDPROC
1067: 
1068:     *--------------------------------------------------------------------------
1069:     * BOParaForm - grava de volta na linha CORRENTE de cursor_4c_Dados o que
1070:     * this_oBusinessObject resolveu (BarraAnt/Flag) - usado apos
1071:     * ValidarParSubstituicao() (legado: "Replace BarraAnt With CrTmpPro.Cbars
1072:     * in CsContas").
1073:     *--------------------------------------------------------------------------
1074:     PROTECTED PROCEDURE BOParaForm()
1075:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1076:             RETURN
1077:         ENDIF
1078: 
1079:         REPLACE BarraAnt WITH THIS.this_oBusinessObject.this_nBarraAnt, ;
1080:                 Flag      WITH THIS.this_oBusinessObject.this_lFlag IN cursor_4c_Dados
1081:     ENDPROC
1082: 
1083:     *--------------------------------------------------------------------------
1084:     * HabilitarCampos - trava a grade e os 5 botoes de acao durante o
1085:     * processamento (BtnProcessarClick), para o usuario nao reentrar no meio
1086:     * do lote. cmd_4c_BtnSair fica de fora de proposito (permanece
1087:     * acionavel). Nao ha equivalente disso no legado (a modal do
1088:     * MessageBox bloqueava a interacao) - e so uma salvaguarda de UX.
1089:     *--------------------------------------------------------------------------
1090:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1091:         LOCAL loc_lHabilitar
1092:         loc_lHabilitar = (VARTYPE(par_lHabilitar) != "L" OR par_lHabilitar)
1093: 
1094:         THIS.grd_4c_Dados.Enabled        = loc_lHabilitar
1095:         THIS.cmd_4c_BtnIncluir.Enabled   = loc_lHabilitar
1096:         THIS.cmd_4c_BtnExcluir.Enabled   = loc_lHabilitar
1097:         THIS.cmd_4c_BtnProcessar.Enabled = loc_lHabilitar
1098:         THIS.cmd_4c_Exporta.Enabled      = loc_lHabilitar
1099:     ENDPROC
1100: 
1101:     *--------------------------------------------------------------------------
1102:     * LimparCampos - reseta a grade de pares para 1 linha vazia (legado, no
1103:     * sucesso do btnProcessar.Click: "Set Order To / Zap / Append Blank").
1104:     *--------------------------------------------------------------------------
1105:     PROTECTED PROCEDURE LimparCampos()
1106:         IF !USED("cursor_4c_Dados")
1107:             RETURN
1108:         ENDIF
1109: 
1110:         SELECT cursor_4c_Dados
1111:         ZAP
1112:         APPEND BLANK
1113:         GO TOP
1114:     ENDPROC
1115: 
1116:     *--------------------------------------------------------------------------
1117:     * Destroy - libera recursos ao fechar o form. cursor_4c_Dados eh a grade
1118:     * de edicao (vive por toda a sessao do form); cursor_4c_Importa eh
1119:     * aberto/fechado dentro de ExportaClick() e cursor_4c_Campos dentro de
1120:     * sigprmdpBO.ProcessarPar() - os guards aqui so cobrem o caso de o form
1121:     * ser fechado no meio de uma dessas operacoes (TRY/CATCH quebrado a
1122:     * meio-caminho).
1123:     *--------------------------------------------------------------------------
1124:     PROCEDURE Destroy()
1125:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1126:             THIS.this_oBusinessObject = .NULL.
1127:         ENDIF
1128:         IF USED("cursor_4c_Dados")
1129:             USE IN cursor_4c_Dados
1130:         ENDIF
1131:         IF USED("cursor_4c_Importa")
1132:             USE IN cursor_4c_Importa
1133:         ENDIF
1134:         IF USED("cursor_4c_Campos")
1135:             USE IN cursor_4c_Campos
1136:         ENDIF
1137:         DODEFAULT()
1138:     ENDPROC
1139: 
1140: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprmdpBO.prg):
*==============================================================================
* Classe  : sigprmdpBO
* Herda de: BusinessBase
* Descricao: BO para substituicao de referencias (codigos) de produtos.
*            Valida pares CprosAnt/CprosNov, importa de XLS e aplica UPDATE
*            em multiplas tabelas do banco conforme catalogo ArqDBF, alem de
*            registrar controle de recalculo de custo em SigOpClC.
*            Form OPERACIONAL - sem Lista/Page1/Buscar(); this_cTabela so
*            identifica SigOpClC, unica tabela gravada por Inserir/Atualizar.
*==============================================================================
DEFINE CLASS sigprmdpBO AS BusinessBase

    *-- Flags de configuracao do processamento (legado: checkcadpro/manterbarra/calculacusto)
    this_lCheckCadPro   = .F.   && Pula a validacao do codigo de produto contra SigCdPro
    this_lManterBarra   = .F.   && Mantem o codigo de barras do produto antigo no produto novo
    this_lCalculaCusto  = .T.   && Recalcula custo (legado le de SigCdPaC.CalcCustos <> 3)

    *-- Estado do progresso (lido pelo Form para atualizar UI - cntResult/cntBarra)
    this_cArquivoAtual  = ""    && Arquivo/campo em processamento (getArquivo.Value)
    this_cProdutoAtual  = ""    && Produto em processamento (Get_Cpros.Value)
    this_nProgresso     = 0     && Progresso 0-100 (lblPorcento.Caption / shpBarra.Width)

    *-- Caminho completo do ArqDBF.DBF (sem extensao) - setado por ValidarArqDBF
    this_cArqDBFPath    = ""

    *-- Par corrente de produtos (usado por CarregarDoCursor - espelha o cursor
    *-- da grade csContas: CprosAnt C(14), CprosNov C(14), Flag L, BarraAnt N(8))
    this_cProsAnt       = ""    && Codigo de referencia antigo (SigCdPro.Cpros, char(14))
    this_cProsNov       = ""    && Codigo de referencia novo (SigCdPro.Cpros, char(14))
    this_lFlag          = .F.   && Linha ja processada com sucesso (csContas.Flag)
    this_nBarraAnt      = 0     && Codigo de barras do produto antigo (SigCdPro.Cbars)

    *-- Dados do registro de controle de custo gerado no processamento (tabela
    *-- SigOpClC, unica tabela gravada diretamente por este BO - Inserir/Atualizar)
    this_cCidChaves     = ""    && Chave unica do registro (SigOpClC.cidchaves, PK)
    this_cCpros         = ""    && Codigo do produto enfileirado p/ recalculo (SigOpClC.cpros)
    this_cEmps          = ""    && Empresa do registro de custo (SigOpClC.emps)
    this_cEmpCpros      = ""    && Empresa + codigo do produto (SigOpClC.empcpros)
    this_dDatas         = {}    && Data base do recalculo de custo (SigOpClC.datas)
    this_cUsuars        = ""    && Usuario que gerou o registro (SigOpClC.usuars)

    *-- .T. quando o par processado tinha linha(s) em SigMvEst referenciando
    *-- o codigo antigo (ver ProcessarPar - regra #27: fRecalculaP/fRecalculaC
    *-- nao vieram no acervo, e SigMvEst nao e tocado sem elas). O Form usa
    *-- esta flag para avisar o usuario que o saldo precisa de revisao manual.
    this_lSigMvEstPendente = .F.

    *--------------------------------------------------------------------------
    * Init - sem Buscar()/this_oDataAccess (form OPERACIONAL, sem Lista/Page1).
    * this_cTabela/this_cCampoChave apontam para SigOpClC so porque e a UNICA
    * tabela que Inserir()/Atualizar() gravam diretamente (fila de recalculo
    * de custo) - usados por RegistrarAuditoria() para montar o log.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigOpClC"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir do cursor da
    * grade de pares de substituicao (equivalente a csContas do legado).
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cProsAnt  = TratarNulo(CprosAnt,  "")
                THIS.this_cProsNov  = TratarNulo(CprosNov,  "")
                THIS.this_lFlag     = TratarNulo(Flag,      .F.)
                THIS.this_nBarraAnt = TratarNulo(BarraAnt,  0)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "sigprmdpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Grava na fila de recalculo de custo (tabela SigOpClC), um
    * registro por produto/empresa cujo custo precisa ser reprocessado apos a
    * substituicao de referencia (legado: Insert Into CrSigOpClC no btnProcessar).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF
            IF EMPTY(THIS.this_cEmpCpros)
                THIS.this_cEmpCpros = THIS.this_cEmps + THIS.this_cCpros
            ENDIF
            IF EMPTY(THIS.this_cUsuars)
                THIS.this_cUsuars = TratarNulo(gc_4c_UsuarioLogado, "")
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigOpClC (cidchaves, cpros, datas, empcpros, emps, usuars)
                VALUES (
                    <<EscaparSQL(LEFT(THIS.this_cCidChaves, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmpCpros, 17))>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cUsuars, 10))>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro de recalculo de custo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "sigprmdpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza um registro existente da fila de recalculo de custo
    * (SigOpClC), localizado pela chave unica this_cCidChaves.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cEmpCpros)
                THIS.this_cEmpCpros = THIS.this_cEmps + THIS.this_cCpros
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigOpClC
                SET cpros    = <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    datas    = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    empcpros = <<EscaparSQL(LEFT(THIS.this_cEmpCpros, 17))>>,
                    emps     = <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    usuars   = <<EscaparSQL(LEFT(THIS.this_cUsuars, 10))>>
                WHERE cidchaves = <<EscaparSQL(LEFT(THIS.this_cCidChaves, 20))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro de recalculo de custo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "sigprmdpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - chave real do registro gravado por Inserir/Atualizar
    * (SigOpClC.cidchaves), usada por RegistrarAuditoria().
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarParSubstituicao - replica as 4 validacoes do SCAN csContas do
    * btnProcessar.Click legado, na MESMA ordem. Devolve um codigo em vez de
    * exibir a mensagem/posicionar o foco - isso e decisao do FORM (camadas).
    * Grava THIS.this_nBarraAnt quando acha o produto antigo em SigCdPro
    * (equivalente a "Replace BarraAnt With CrTmpPro.Cbars in CsContas").
    *
    * Retorno:
    *   0 = par valido
    *   1 = codigo antigo vazio, ou nao cadastrado em SigCdPro (e
    *       this_lCheckCadPro = .F.)
    *   2 = produto antigo sem codigo de barras (so quando this_lManterBarra)
    *   3 = codigo novo vazio
    *   4 = codigo antigo e novo iguais
    *   5 = grupos do produto antigo/novo com controle de estoque (Cestoqs)
    *       diferentes
    *--------------------------------------------------------------------------
    FUNCTION ValidarParSubstituicao(par_cProsAnt, par_cProsNov)
        LOCAL loc_cSQL, loc_nResultado, loc_nRetorno, loc_lProsseguir
        loc_nRetorno = 0
        loc_lProsseguir = .T.
        THIS.this_nBarraAnt = 0

        *-- REGRA CRITICA: nunca RETURN dentro de TRY/CATCH - usa flag
        *-- loc_lProsseguir e um unico RETURN apos o ENDTRY.
        TRY
            IF EMPTY(par_cProsAnt)
                loc_nRetorno = 1
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !THIS.this_lCheckCadPro
                loc_cSQL = "SELECT Cpros, Cbars FROM SigCdPro WHERE Cpros = " + ;
                    EscaparSQL(LEFT(ALLTRIM(par_cProsAnt), 14))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValPro")
                IF loc_nResultado < 1 OR !USED("cursor_4c_ValPro") OR RECCOUNT("cursor_4c_ValPro") = 0
                    IF USED("cursor_4c_ValPro")
                        USE IN cursor_4c_ValPro
                    ENDIF
                    loc_nRetorno = 1
                    loc_lProsseguir = .F.
                ELSE
                    THIS.this_nBarraAnt = TratarNulo(cursor_4c_ValPro.Cbars, 0)
                    USE IN cursor_4c_ValPro
                ENDIF
            ENDIF

            IF loc_lProsseguir AND THIS.this_lManterBarra AND THIS.this_nBarraAnt = 0
                loc_nRetorno = 2
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND EMPTY(par_cProsNov)
                loc_nRetorno = 3
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND UPPER(ALLTRIM(par_cProsAnt)) == UPPER(ALLTRIM(par_cProsNov))
                loc_nRetorno = 4
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                *-- Grupos com controle de estoque (Cestoqs) diferentes entre o
                *-- produto novo e o antigo bloqueiam a troca (legado: LocalPro/
                *-- LocalPro2, Select a.Cgrus,b.Cestoqs From SigCdPro a, SigCdGrp b)
                loc_cSQL = "SELECT b.Cestoqs FROM SigCdPro a INNER JOIN SigCdGrp b ON a.Cgrus = b.Cgrus" + ;
                    " WHERE a.Cpros = " + EscaparSQL(LEFT(ALLTRIM(par_cProsNov), 14))
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
                IF USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
                    loc_cSQL = "SELECT b.Cestoqs FROM SigCdPro a INNER JOIN SigCdGrp b ON a.Cgrus = b.Cgrus" + ;
                        " WHERE a.Cpros = " + EscaparSQL(LEFT(ALLTRIM(par_cProsAnt), 14))
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro2")
                    IF USED("cursor_4c_LocalPro2")
                        IF RECCOUNT("cursor_4c_LocalPro2") > 0 AND ;
                           cursor_4c_LocalPro2.Cestoqs != cursor_4c_LocalPro.Cestoqs
                            loc_nRetorno = 5
                        ENDIF
                        USE IN cursor_4c_LocalPro2
                    ENDIF
                ENDIF
                IF USED("cursor_4c_LocalPro")
                    USE IN cursor_4c_LocalPro
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao validar par de refer" + CHR(234) + "ncias:" + CHR(13) + ;
                loException.Message, "sigprmdpBO.ValidarParSubstituicao")
            loc_nRetorno = 1
        ENDTRY

        RETURN loc_nRetorno
    ENDFUNC

    *--------------------------------------------------------------------------
    * MapearTabelasAlvo - Equivalente ao
    *     Select Arquivos, Campos From ArqDBF
    *     Where (Tamanhos=10 Or Tamanhos=14) And Upper(Tipos)='C' And
    *           Arquivos not in (...) And InList(Alltrim(Campos), <14 nomes>)
    * do btnProcessar.Click legado. ArqDBF.DBF era um CATALOGO LOCAL do FoxPro
    * (Sys(5)+Sys(2003)+'\ArqDBF.dbf') - nao existe no SQL Server (regra #14:
    * so o schema.sql/INFORMATION_SCHEMA decide, nunca arquivo local). A MESMA
    * lista de nomes de coluna e o MESMO filtro de tamanho sao aplicados aqui
    * contra o metadado REAL e ATUAL do banco, em vez de um catalogo que podia
    * estar desatualizado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MapearTabelasAlvo()
        LOCAL loc_cSQL, loc_nResultado

        IF USED("cursor_4c_Campos")
            USE IN cursor_4c_Campos
        ENDIF

        TEXT TO loc_cSQL NOSHOW
            SELECT TABLE_NAME AS Arquivos, COLUMN_NAME AS Campos
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE DATA_TYPE IN ('char', 'varchar')
              AND CHARACTER_MAXIMUM_LENGTH IN (10, 14)
              AND UPPER(COLUMN_NAME) IN ('CMATS','CODCONPADS','CODPDS','CODPROPADS',
                  'CPROS','PRODUTO','PRODUTOS','CPROEQS','MATPRINCS','MATS',
                  'MATSUBS','CODGARRAS','OUROS','BRILHANTES')
              AND UPPER(TABLE_NAME) NOT IN ('SIGTEMPD','SIGTEMPC','SIGTEMPR')
            ORDER BY TABLE_NAME
        ENDTEXT

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Campos")
        IF loc_nResultado < 0
            MostrarErro("Erro ao mapear tabelas com refer" + CHR(234) + "ncia a produto:" + CHR(13) + ;
                CapturarErroSQL(), "Erro SQL")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExisteReferencia - .T. se existe ao menos 1 linha de par_cTabela com
    * par_cColuna = par_cValor. Equivalente ao
    *     ThisForm.PodataMgr.CursorQuery('SigCdPro','CrTmpPro','Cpros', ... )
    * e ao padrao "Select X From Y Where Y.X = 'valor' / Reccount(...) > 0"
    * repetido no btnProcessar.Click legado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExisteReferencia(par_cTabela, par_cColuna, par_cValor)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        loc_cSQL = "SELECT TOP 1 " + par_cColuna + " FROM " + par_cTabela + ;
            " WHERE " + par_cColuna + " = " + EscaparSQL(LEFT(ALLTRIM(par_cValor), 14))
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Existe")
        IF loc_nResultado > 0 AND USED("cursor_4c_Existe")
            loc_lExiste = (RECCOUNT("cursor_4c_Existe") > 0)
        ENDIF
        IF USED("cursor_4c_Existe")
            USE IN cursor_4c_Existe
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * EnfileirarRecalculoPorPar - Equivalente ao bloco final do legado
    * ("If Used('TmpCustPro') And Thisform.Calculacusto / Scan / Insert Into
    * CrSigOpClC (...) "). TmpCustPro era populado DENTRO de fRecalculaC
    * (funcao global do Fortyus que nao veio no acervo - regra #27); como nao
    * ha como reproduzir o calculo em si, enfileiramos para recalculo externo
    * TODA empresa que tem movimento historico (SigMvHst) para o codigo
    * antigo OU o novo - e' o mesmo universo (Emps) que o legado varria via
    * fRecalculaP/fRecalculaC para montar TmpCustPro.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE EnfileirarRecalculoPorPar(par_cProsAnt, par_cProsNov)
        LOCAL loc_cSQL, loc_nResultado

        IF !THIS.this_lCalculaCusto
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT DISTINCT Emps FROM SigMvHst WHERE Cpros = " + ;
                EscaparSQL(LEFT(ALLTRIM(par_cProsAnt), 14)) + " OR Cpros = " + ;
                EscaparSQL(LEFT(ALLTRIM(par_cProsNov), 14))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpsRecalc")
            IF loc_nResultado > 0 AND USED("cursor_4c_EmpsRecalc")
                SELECT cursor_4c_EmpsRecalc
                SCAN
                    THIS.this_cEmps   = TratarNulo(cursor_4c_EmpsRecalc.Emps, "")
                    THIS.this_dDatas  = DATE()
                    THIS.this_cUsuars = TratarNulo(gc_4c_UsuarioLogado, "")

                    THIS.this_cCidChaves = ""
                    THIS.this_cEmpCpros  = ""
                    THIS.this_cCpros     = ALLTRIM(par_cProsAnt)
                    THIS.Inserir()

                    THIS.this_cCidChaves = ""
                    THIS.this_cEmpCpros  = ""
                    THIS.this_cCpros     = ALLTRIM(par_cProsNov)
                    THIS.Inserir()
                ENDSCAN
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao enfileirar recalculo de custo:" + CHR(13) + ;
                loException.Message, "sigprmdpBO.EnfileirarRecalculoPorPar")
        ENDTRY

        IF USED("cursor_4c_EmpsRecalc")
            USE IN cursor_4c_EmpsRecalc
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarPar - substitui par_cProsAnt por par_cProsNov em todas as
    * tabelas mapeadas por MapearTabelasAlvo() (equivalente ao "Select
    * Arquivos,Campos" + Scan do btnProcessar.Click legado).
    *
    * Casos especiais transcritos literalmente do legado:
    *   SIGPRPRT          -> nunca atualizado (Loop incondicional).
    *   SIGCDPRO/SIGPRCPO/SIGCDPRF/SIGCDPFT -> quando o codigo NOVO ja existe
    *     como produto cadastrado em SigCdPro: se for SigCdPro.Cpros e
    *     this_lManterBarra, transfere o codigo de barras (Cbars) do antigo
    *     para o novo em vez de renomear; senao, se o codigo ANTIGO tambem
    *     existir como produto distinto, pula a troca (preserva os dois
    *     registros); caso contrario segue para o UPDATE generico.
    *   SIGMVHST/SIGMVEST -> NAO recebem UPDATE/DELETE aqui. O legado dispara
    *     fRecalculaP()/fRecalculaC() (recalculo de custo/estoque) e, so para
    *     SIGMVEST, exclui as linhas do saldo antigo (a recriacao sob o
    *     codigo novo acontecia DENTRO de fRecalculaP). Essas duas funcoes
    *     globais do Fortyus NAO vieram no acervo (regra #27) - excluir
    *     SIGMVEST sem a recriacao destruiria saldo de estoque em SILENCIO,
    *     o que e pior que nao fazer nada. Em vez disso: SigMvHst participa
    *     do UPDATE generico (o legado tambem faz isso - o bloco SIGMVHST
    *     cai no Else por nao ter "Loop"); SigMvEst e so verificado (seta a
    *     flag de alerta correspondente) para o FORM avisar o usuario.
    *
    * Toda a troca das demais tabelas vai num UNICO SQLEXEC (lote T-SQL com
    * SAVE TRANSACTION) - BEGIN/COMMIT em chamadas SEPARADAS de SQLEXEC NAO
    * dao atomicidade nesta conexao (Transactions=2, @@TRANCOUNT ja nasce 1,
    * ver Erro188/ProdutoBO.CopiarProduto).
    *--------------------------------------------------------------------------
    FUNCTION ProcessarPar(par_cProsAnt, par_cProsNov)
        LOCAL loc_cProsAntSQL, loc_cProsNovSQL, loc_cLote, loc_cSQL, ;
              loc_cTabela, loc_cColuna, loc_nResultado, loc_lSucesso, loc_lProsseguir

        loc_lSucesso = .F.
        loc_lProsseguir = .T.
        loc_cProsAntSQL = EscaparSQL(LEFT(ALLTRIM(par_cProsAnt), 14))
        loc_cProsNovSQL = EscaparSQL(LEFT(ALLTRIM(par_cProsNov), 14))
        THIS.this_lSigMvEstPendente = .F.
        THIS.this_cMensagemErro = ""

        IF !THIS.MapearTabelasAlvo()
            RETURN .F.
        ENDIF

        *-- REGRA CRITICA: nunca RETURN dentro de TRY/CATCH - usa flag
        *-- loc_lProsseguir e um unico RETURN apos o ENDTRY.
        TRY
            loc_cLote = ""

            SELECT cursor_4c_Campos
            SCAN
                loc_cTabela = ALLTRIM(cursor_4c_Campos.Arquivos)
                loc_cColuna = ALLTRIM(cursor_4c_Campos.Campos)

                IF UPPER(loc_cTabela) == "SIGPRPRT"
                    LOOP
                ENDIF

                IF UPPER(loc_cTabela) == "SIGMVEST"
                    THIS.this_lSigMvEstPendente = THIS.this_lSigMvEstPendente OR ;
                        THIS.ExisteReferencia(loc_cTabela, loc_cColuna, par_cProsAnt)
                    LOOP
                ENDIF

                IF INLIST(UPPER(loc_cTabela), "SIGCDPRO", "SIGPRCPO", "SIGCDPRF", "SIGCDPFT") ;
                   AND THIS.ExisteReferencia("SigCdPro", "Cpros", par_cProsNov)

                    IF UPPER(loc_cTabela) == "SIGCDPRO" AND UPPER(loc_cColuna) == "CPROS" ;
                       AND THIS.this_lManterBarra
                        loc_cLote = loc_cLote + ;
                            "UPDATE SigCdPro SET Cbars = " + FormatarNumeroSQL(THIS.this_nBarraAnt, 0) + ;
                            " WHERE Cpros = " + loc_cProsNovSQL + "; " + ;
                            "UPDATE SigCdPro SET Cbars = 0 WHERE Cpros = " + loc_cProsAntSQL + "; "
                        LOOP
                    ENDIF

                    IF THIS.ExisteReferencia("SigCdPro", "Cpros", par_cProsAnt)
                        *-- codigo antigo TAMBEM existe como produto distinto -
                        *-- preserva os dois, nao mexe nesta coluna
                        LOOP
                    ENDIF
                ENDIF

                *-- UPDATE generico (legado: Update <tabela> Set <coluna> =
                *-- 'novo' Where <coluna> = 'antigo' - com ou sem chave
                *-- primaria o resultado final e o mesmo conjunto de linhas)
                loc_cLote = loc_cLote + ;
                    "UPDATE " + loc_cTabela + " SET " + loc_cColuna + " = " + loc_cProsNovSQL + ;
                    " WHERE " + loc_cColuna + " = " + loc_cProsAntSQL + "; "
            ENDSCAN

            IF !EMPTY(loc_cLote)
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    SET NOCOUNT ON;
                    DECLARE @nivel4c int = @@TRANCOUNT;
                    IF @nivel4c = 0 BEGIN TRANSACTION ELSE SAVE TRANSACTION Mdp4c;
                    BEGIN TRY
                        <<loc_cLote>>
                        IF @nivel4c = 0 COMMIT TRANSACTION;
                    END TRY
                    BEGIN CATCH
                        IF @nivel4c = 0
                            BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION END
                        ELSE
                            BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Mdp4c END;
                        THROW;
                    END CATCH
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao atualizar refer" + CHR(234) + "ncias de produto:" + ;
                        CHR(13) + CapturarErroSQL()
                    MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.EnfileirarRecalculoPorPar(par_cProsAnt, par_cProsNov)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MostrarErro("Erro ao processar substitui" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "sigprmdpBO.ProcessarPar")
        ENDTRY

        IF USED("cursor_4c_Campos")
            USE IN cursor_4c_Campos
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

