# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [METODO-INEXISTENTE] Metodo 'THIS.BtnSalvarClick()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormTbd.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1259 linhas total):

*-- Linhas 1 a 53:
1: *==============================================================================
2: * FormTbd.prg - Tabelas de Desconto por Operacao (sub-form modal / popup)
3: * Form OPERACIONAL - abre sobre o form pai (form de Operacoes)
4: * Chamada: CREATEOBJECT("FormTbd", oParentForm, cDopes)
5: * Herda de: FormBase
6: *
7: * Form OPERACIONAL (sub-form modal). Botoes do SCX original: Inserir, Excluir,
8: * Confirmar (grava tudo e fecha), Cancelar (fecha sem gravar). Edicao inline
9: * no grid (codigo da tabela de desconto com lookup F4 em SigOpTdz).
10: *
11: * Historico de fases:
12: *   Fase 1/2: TbdBO.prg (propriedades + CRUD + BuscarPorOperacao/SalvarPorOperacao)
13: *   Fase 3:   FormTbd.prg - estrutura base (heranca, Init, InicializarForm)
14: *   Fase 4:   Grid grd_4c_Dados (2 colunas), botoes Inserir/Excluir (cnt_4c_Botoes)
15: *   Fase 5:   Cabecalho Page2 espelhado, BeforeRowColChange/AfterRowColChange
16: *   Fase 6:   Lookup do codigo (KeyPress F4/Enter/Tab -> SigOpTdz, espelha
17: *             Column1.Text1.Valid), container cnt_4c_BotoesAcao (Confirmar/
18: *             Cancelar) e BtnConfirmarClick (duplicidade + SalvarPorOperacao +
19: *             fecha) / BtnCancelarClick (fecha sem gravar) - espelham
20: *             cmdSair.Click/Cancela.Click do legado
21: *==============================================================================
22: DEFINE CLASS FormTbd AS FormBase
23: 
24:     *-- Propriedades do SCX original (RESERVED3: gravadados / antvalue / parentform)
25:     GravaDados        = .F.      && .T. quando usuario alterou dados no grid
26:     AntValue          = .NULL.   && valor anterior capturado no When da Column1
27:     this_oParentForm  = .NULL.   && referencia ao form pai (Operacao) para reabilitar no Destroy
28:     this_cDopes       = ""       && codigo/descricao da operacao (dopes char 20 - FK SigCdOpe.dopes)
29: 
30:     *-- Propriedades locais (NAO persistem - apenas estado/UI)
31:     this_cDescOperacao = ""      && descricao da operacao exibida no cabecalho (= crSigCdOpe.Dopes)
32: 
33:     *-- Business Object
34:     this_oBusinessObject = .NULL.
35: 
36:     *-- Controle de modo (padrao CRUD - usado por AlternarPagina em fases futuras)
37:     this_cModoAtual = "LISTA"   && LISTA / DADOS / INCLUIR / ALTERAR / VISUALIZAR
38: 
39:     *-- Guard anti-recursao no AfterRowColChange (redirect When behavior)
40:     this_lRedirigindo = .F.
41: 
42:     *-- Propriedades visuais (PILAR 1 - valores exatos do layout.json original)
43:     Width        = 800
44:     Height       = 400
45:     AutoCenter   = .T.
46:     TitleBar     = 0
47:     ShowWindow   = 1
48:     WindowType   = 1
49:     ControlBox   = .F.
50:     MaxButton    = .F.
51:     MinButton    = .F.
52:     Movable      = .F.
53:     BorderStyle  = 2

*-- Linhas 60 a 212:
60:     *--------------------------------------------------------------------------
61:     * Init - Recebe ref ao pai e codigo/descricao da operacao (Dopes)
62:     *--------------------------------------------------------------------------
63:     PROCEDURE Init(par_oParentForm, par_cDopes)
64:         LOCAL loc_lSucesso, loc_oErro
65:         loc_lSucesso = .F.
66:         TRY
67:             THIS.this_oParentForm = par_oParentForm
68:             THIS.this_cDopes      = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")
69: 
70:             THIS.this_oBusinessObject = CREATEOBJECT("TbdBO")
71:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
72:                 MsgErro("Erro ao criar TbdBO." + CHR(13) + ;
73:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
74:                     "FormTbd.Init")
75:             ELSE
76:                 IF VARTYPE(THIS.this_oParentForm) = "O"
77:                     THIS.this_oParentForm.Enabled = .F.
78:                 ENDIF
79:                 *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
80:                 loc_lSucesso = DODEFAULT()
81:             ENDIF
82:         CATCH TO loc_oErro
83:             MsgErro(loc_oErro.Message + CHR(13) + ;
84:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
85:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.Init")
86:         ENDTRY
87:         RETURN loc_lSucesso
88:     ENDPROC
89: 
90:     *--------------------------------------------------------------------------
91:     * InicializarForm - Monta estrutura visual base do form
92:     * (chamado por FormBase.Init via DODEFAULT)
93:     *--------------------------------------------------------------------------
94:     PROTECTED PROCEDURE InicializarForm()
95:         LOCAL loc_lSucesso, loc_oErro
96:         loc_lSucesso = .F.
97:         TRY
98:             *-- 1. PageFrame com Page1 (Lista) e Page2 (Dados)
99:             THIS.ConfigurarPageFrame()
100: 
101:             *-- 2. Containers vazios em cada Page (Fase 4+ populam grid/botoes)
102:             THIS.ConfigurarContainersBase()
103: 
104:             *-- 2.1 Grid + botoes Inserir/Excluir (Page1)
105:             THIS.ConfigurarPaginaLista()
106: 
107:             *-- 2.2 Cabecalho da Page2 (espelha visualmente o cabecalho da Page1)
108:             THIS.ConfigurarPaginaDados()
109: 
110:             *-- 2.3 Carrega tabelas de desconto ja vinculadas a operacao
111:             THIS.CarregarLista()
112: 
113:             *-- 3. Monta o Caption a partir da operacao e propaga para as Pages
114:             *--    (espelha o Init legado: .Caption = [Grupos de Produtos ] +
115:             *--    AllTrim(crSigCdOpe.Dopes) copiado para lblSombra/lblTitulo)
116:             THIS.BOParaForm()
117: 
118:             *-- 4. Ativa Page1 (Lista) como padrao
119:             THIS.pgf_4c_Paginas.Visible    = .T.
120:             THIS.pgf_4c_Paginas.ActivePage = 1
121:             THIS.this_cModoAtual           = "LISTA"
122: 
123:             *-- 5. Torna toda a arvore visivel
124:             THIS.TornarControlesVisiveis(THIS)
125: 
126:             loc_lSucesso = .T.
127:         CATCH TO loc_oErro
128:             MsgErro(loc_oErro.Message + CHR(13) + ;
129:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
130:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.InicializarForm")
131:         ENDTRY
132:         RETURN loc_lSucesso
133:     ENDPROC
134: 
135:     *--------------------------------------------------------------------------
136:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
137:     * Tabs ocultas (Top=-29, Tabs=.F.) - navegacao via AlternarPagina()
138:     *--------------------------------------------------------------------------
139:     PROTECTED PROCEDURE ConfigurarPageFrame()
140:         LOCAL loc_oErro
141:         TRY
142:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
143:             WITH THIS.pgf_4c_Paginas
144:                 .Top         = -29
145:                 .Left        = 0
146:                 .Width       = THIS.Width
147:                 .Height      = THIS.Height + 29
148:                 .PageCount   = 2
149:                 .Tabs        = .F.
150:                 .BorderWidth = 0
151: 
152:                 .Page1.Caption = "Lista"
153:                 .Page2.Caption = "Dados"
154: 
155:                 *-- Fundo das Pages (espelha SIGCDTBD.Picture do legado:
156:                 *-- ..\framework\imagens\new_background.jpg)
157:                 .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
158:                 .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
159:             ENDWITH
160:         CATCH TO loc_oErro
161:             MsgErro(loc_oErro.Message + CHR(13) + ;
162:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
163:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.ConfigurarPageFrame")
164:         ENDTRY
165:     ENDPROC
166: 
167:     *--------------------------------------------------------------------------
168:     * ConfigurarContainersBase - Cria containers vazios em cada Page
169:     * cnt_4c_Cabecalho + cnt_4c_Botoes em Page1 (fase 4 popula grid+Inserir/Excluir)
170:     * cnt_4c_BotoesAcao em Page2 (fase 6 popula Confirmar/Cancelar)
171:     *--------------------------------------------------------------------------
172:     PROTECTED PROCEDURE ConfigurarContainersBase()
173:         LOCAL loc_oPag1, loc_oPag2, loc_oErro
174:         TRY
175:             loc_oPag1 = THIS.pgf_4c_Paginas.Page1
176:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2
177: 
178:             *-- Page1: cabecalho escuro (topo)
179:             loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
180:             WITH loc_oPag1.cnt_4c_Cabecalho
181:                 .Top         = 0 + 29
182:                 .Left        = 0
183:                 .Width       = THIS.Width
184:                 .Height      = 80
185:                 .BorderWidth = 0
186:                 .BackStyle   = 1
187:                 .BackColor   = RGB(100, 100, 100)
188:                 .Visible     = .T.
189:             ENDWITH
190: 
191:             *-- Labels no cabecalho escuro (sombra + titulo) - fase 4 refina Caption
192:             loc_oPag1.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
193:             WITH loc_oPag1.cnt_4c_Cabecalho.lbl_4c_Sombra
194:                 .AutoSize  = .F.
195:                 .FontBold  = .T.
196:                 .FontName  = "Tahoma"
197:                 .FontSize  = 18
198:                 .BackStyle = 0
199:                 .Caption   = THIS.Caption
200:                 .Height    = 40
201:                 .Left      = 10
202:                 .Top       = 18
203:                 .Width     = THIS.Width - 31
204:                 .ForeColor = RGB(0, 0, 0)
205:             ENDWITH
206: 
207:             loc_oPag1.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
208:             WITH loc_oPag1.cnt_4c_Cabecalho.lbl_4c_Titulo
209:                 .AutoSize  = .F.
210:                 .FontBold  = .T.
211:                 .FontName  = "Tahoma"
212:                 .FontSize  = 18

*-- Linhas 247 a 300:
247:         CATCH TO loc_oErro
248:             MsgErro(loc_oErro.Message + CHR(13) + ;
249:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
250:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.ConfigurarContainersBase")
251:         ENDTRY
252:     ENDPROC
253: 
254:     *--------------------------------------------------------------------------
255:     * ConfigurarPaginaLista - Grid de tabelas de desconto (espelha GradeOpe do
256:     * SCX original) + botoes Inserir/Excluir dentro de cnt_4c_Botoes (Page1).
257:     * Coluna 1 (codigos) editavel - lookup F4/Enter/Tab -> ColCodigosKeyPress.
258:     * Coluna 2 (descrs) somente leitura - no legado o Text1.When retorna .F.
259:     *--------------------------------------------------------------------------
260:     PROTECTED PROCEDURE ConfigurarPaginaLista()
261:         LOCAL loc_oPag, loc_oErro
262:         TRY
263:             loc_oPag = THIS.pgf_4c_Paginas.Page1
264: 
265:             *-- Grid principal (espelha SIGCDTBD.GradeOpe: Top=98,Left=236,W=313,H=274)
266:             loc_oPag.AddObject("grd_4c_Dados", "Grid")
267:             WITH loc_oPag.grd_4c_Dados
268:                 .Top           = 98 + 29
269:                 .Left          = 236
270:                 .Width         = 313
271:                 .Height        = 274
272:                 .ColumnCount   = 2
273:                 .ScrollBars    = 2
274:                 .DeleteMark    = .F.
275:                 .RecordMark    = .F.
276:                 .GridLineColor = RGB(238, 238, 238)
277:                 .ReadOnly      = .F.
278:                 .Visible       = .T.
279: 
280:                 .Column1.Width      = 80
281:                 .Column1.Movable    = .F.
282:                 .Column1.Resizable  = .F.
283:                 .Column1.Header1.Caption   = "Tabela"
284:                 .Column1.Header1.FontName  = "Verdana"
285:                 .Column1.Header1.FontSize  = 8
286:                 .Column1.Header1.Alignment = 2
287:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
288:                 .Column1.Text1.FontName    = "Courier New"
289:                 .Column1.Text1.BorderStyle = 0
290:                 .Column1.Text1.Margin      = 0
291:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)
292:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
293: 
294:                 .Column2.Width      = 200
295:                 .Column2.Movable    = .F.
296:                 .Column2.Resizable  = .F.
297:                 .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
298:                 .Column2.Header1.FontName  = "Verdana"
299:                 .Column2.Header1.FontSize  = 8
300:                 .Column2.Header1.Alignment = 2

*-- Linhas 355 a 428:
355:                 .Visible         = .T.
356:             ENDWITH
357: 
358:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Inserir, "Click", THIS, "BtnIncluirClick")
359:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
360: 
361:             *-- Lookup do codigo da tabela de desconto (espelha Column1.Text1.Valid
362:             *-- do legado: CreateObject('fwbuscaext', ..., 'SigOpTdz', ...)).
363:             *-- F4 abre a busca direto; ENTER/TAB validam o valor digitado.
364:             BINDEVENT(loc_oPag.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "ColCodigosKeyPress")
365: 
366:             *-- Espelha Column1.When (Thisform.AntValue = This.Value) e
367:             *-- Column2.When (Return .F. - bloqueia entrada na coluna Descricao,
368:             *-- somente leitura) via eventos de grid (colunas nao expoem When
369:             *-- fora de classes customizadas de Column).
370:             BINDEVENT(loc_oPag.grd_4c_Dados, "BeforeRowColChange", THIS, "GridBeforeRowColChange")
371:             BINDEVENT(loc_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GridAfterRowColChange")
372:         CATCH TO loc_oErro
373:             MsgErro(loc_oErro.Message + CHR(13) + ;
374:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
375:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.ConfigurarPaginaLista")
376:         ENDTRY
377:     ENDPROC
378: 
379:     *--------------------------------------------------------------------------
380:     * ConfigurarPaginaDados - Cabecalho da Page2 (mesmo estilo/Caption da
381:     * Page1). No SCX original o form eh uma unica tela (grid + Inserir/Excluir/
382:     * Confirmar/Cancelar juntos); a migracao separa em Page1(Lista)/Page2(acao)
383:     * mas mantem o cabecalho espelhado nas duas paginas para consistencia
384:     * visual (PILAR 1). cnt_4c_BotoesAcao ja foi criado em
385:     * ConfigurarContainersBase (Fase 3) - populado com Confirmar/Cancelar
386:     * na Fase 6.
387:     *--------------------------------------------------------------------------
388:     PROTECTED PROCEDURE ConfigurarPaginaDados()
389:         LOCAL loc_oPag, loc_oErro
390:         TRY
391:             loc_oPag = THIS.pgf_4c_Paginas.Page2
392: 
393:             loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
394:             WITH loc_oPag.cnt_4c_Cabecalho
395:                 .Top         = 0 + 29
396:                 .Left        = 0
397:                 .Width       = THIS.Width
398:                 .Height      = 80
399:                 .BorderWidth = 0
400:                 .BackStyle   = 1
401:                 .BackColor   = RGB(100, 100, 100)
402:                 .Visible     = .T.
403:             ENDWITH
404: 
405:             loc_oPag.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
406:             WITH loc_oPag.cnt_4c_Cabecalho.lbl_4c_Sombra
407:                 .AutoSize  = .F.
408:                 .FontBold  = .T.
409:                 .FontName  = "Tahoma"
410:                 .FontSize  = 18
411:                 .BackStyle = 0
412:                 .Caption   = THIS.Caption
413:                 .Height    = 40
414:                 .Left      = 10
415:                 .Top       = 18
416:                 .Width     = THIS.Width - 31
417:                 .ForeColor = RGB(0, 0, 0)
418:             ENDWITH
419: 
420:             loc_oPag.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
421:             WITH loc_oPag.cnt_4c_Cabecalho.lbl_4c_Titulo
422:                 .AutoSize  = .F.
423:                 .FontBold  = .T.
424:                 .FontName  = "Tahoma"
425:                 .FontSize  = 18
426:                 .BackStyle = 0
427:                 .Caption   = THIS.Caption
428:                 .Height    = 46

*-- Linhas 482 a 1108:
482:                 .Visible         = .T.
483:             ENDWITH
484: 
485:             BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
486:             BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
487:         CATCH TO loc_oErro
488:             MsgErro(loc_oErro.Message + CHR(13) + ;
489:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
490:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.ConfigurarPaginaDados")
491:         ENDTRY
492:     ENDPROC
493: 
494:     *--------------------------------------------------------------------------
495:     * GridBeforeRowColChange - Espelha Column1.When (Thisform.AntValue =
496:     * This.Value): captura o valor corrente do codigo ANTES da troca de
497:     * coluna/linha (usado como referencia de estado; a validacao/lookup do
498:     * codigo em si roda em ColCodigosKeyPress/ValidarCodigoTabela).
499:     *--------------------------------------------------------------------------
500:     PROCEDURE GridBeforeRowColChange(par_nColIndex)
501:         LOCAL loc_oGrid, loc_oErro
502:         TRY
503:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
504:             IF loc_oGrid.ActiveColumn = 1 AND USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
505:                 THIS.AntValue = cursor_4c_Dados.codigos
506:             ENDIF
507:         CATCH TO loc_oErro
508:             MsgErro(loc_oErro.Message + CHR(13) + ;
509:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
510:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.GridBeforeRowColChange")
511:         ENDTRY
512:     ENDPROC
513: 
514:     *--------------------------------------------------------------------------
515:     * GridAfterRowColChange - Espelha Column2.When (Return .F.): a coluna
516:     * Descricao eh somente leitura (preenchida via lookup do codigo), entao
517:     * o legado bloqueava a entrada nela. Aqui redireciona o foco de volta
518:     * para a Column1 quando o usuario tenta navegar ate a Column2.
519:     * Guard this_lRedirigindo evita recursao via SetFocus/ActiveColumn.
520:     *--------------------------------------------------------------------------
521:     PROCEDURE GridAfterRowColChange(par_nColIndex)
522:         LOCAL loc_oGrid, loc_oErro
523:         IF THIS.this_lRedirigindo
524:             RETURN
525:         ENDIF
526:         TRY
527:             IF par_nColIndex = 2
528:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
529:                 THIS.this_lRedirigindo = .T.
530:                 loc_oGrid.ActiveColumn = 1
531:                 IF PEMSTATUS(loc_oGrid.Column1, "Text1", 5)
532:                     loc_oGrid.Column1.Text1.SetFocus
533:                 ENDIF
534:                 THIS.this_lRedirigindo = .F.
535:             ENDIF
536:         CATCH TO loc_oErro
537:             THIS.this_lRedirigindo = .F.
538:             MsgErro(loc_oErro.Message + CHR(13) + ;
539:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
540:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.GridAfterRowColChange")
541:         ENDTRY
542:     ENDPROC
543: 
544:     *--------------------------------------------------------------------------
545:     * ColCodigosKeyPress - Handler de KeyPress da Column1.Text1 (codigo da
546:     * tabela de desconto). Espelha Column1.Text1.Valid do legado:
547:     *   - F4 (115): abre a busca (FormBuscaAuxiliar) direto
548:     *   - ENTER (13) / TAB (9): valida o valor digitado; se encontrar na
549:     *     SigOpTdz preenche a descricao, senao abre a busca (nunca deixa o
550:     *     campo com descricao desatualizada nem mostra aviso redundante -
551:     *     Pattern #114)
552:     *--------------------------------------------------------------------------
553:     PROCEDURE ColCodigosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
554:         LOCAL loc_oErro
555:         TRY
556:             IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
557:                 THIS.AbrirLookupTabelaDesconto()
558:                 NODEFAULT
559:             ELSE
560:                 IF INLIST(par_nKeyCode, 13, 9)
561:                     THIS.ValidarCodigoTabela()
562:                 ENDIF
563:             ENDIF
564:         CATCH TO loc_oErro
565:             MsgErro(loc_oErro.Message + CHR(13) + ;
566:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
567:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.ColCodigosKeyPress")
568:         ENDTRY
569:     ENDPROC
570: 
571:     *--------------------------------------------------------------------------
572:     * ValidarCodigoTabela - Valida o codigo digitado na linha corrente do
573:     * grid contra SigOpTdz. Encontrado -> preenche descrs. Nao encontrado ->
574:     * abre a busca direto (sem MsgAviso redundante - Pattern #114).
575:     *--------------------------------------------------------------------------
576:     PROTECTED PROCEDURE ValidarCodigoTabela()
577:         LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oGrid, loc_oErro
578:         TRY
579:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
580:                 loc_cValor = ALLTRIM(cursor_4c_Dados.codigos)
581: 
582:                 IF EMPTY(loc_cValor)
583:                     SELECT cursor_4c_Dados
584:                     REPLACE descrs WITH ""
585:                 ELSE
586:                     IF USED("cursor_4c_ValTbd")
587:                         USE IN cursor_4c_ValTbd
588:                     ENDIF
589: 
590:                     loc_cSQL = "SELECT codigos, descrs FROM SigOpTdz" + ;
591:                                " WHERE RTRIM(codigos) = " + EscaparSQL(loc_cValor)
592: 
593:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValTbd")
594: 
595:                     IF loc_nResultado > 0 AND USED("cursor_4c_ValTbd") AND ;
596:                        RECCOUNT("cursor_4c_ValTbd") > 0
597:                         SELECT cursor_4c_Dados
598:                         REPLACE descrs WITH ALLTRIM(cursor_4c_ValTbd.descrs)
599:                         THIS.GravaDados = .T.
600: 
601:                         IF USED("cursor_4c_ValTbd")
602:                             USE IN cursor_4c_ValTbd
603:                         ENDIF
604: 
605:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
606:                         loc_oGrid.Refresh
607:                     ELSE
608:                         IF USED("cursor_4c_ValTbd")
609:                             USE IN cursor_4c_ValTbd
610:                         ENDIF
611:                         THIS.AbrirLookupTabelaDesconto()
612:                     ENDIF
613:                 ENDIF
614:             ENDIF
615:         CATCH TO loc_oErro
616:             MsgErro(loc_oErro.Message + CHR(13) + ;
617:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
618:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.ValidarCodigoTabela")
619:         ENDTRY
620:     ENDPROC
621: 
622:     *--------------------------------------------------------------------------
623:     * AbrirLookupTabelaDesconto - Abre FormBuscaAuxiliar sobre SigOpTdz
624:     * (codigos/descrs). Espelha CreateObject('fwbuscaext', ..., 'SigOpTdz',
625:     * 'CrListaRemota', 'Codigos', This.Value, 'Tabelas de Desconto', .t.) do
626:     * legado. Pattern A manual (Erro114): SQL no caller com LIKE 'valor%' +
627:     * fallback SHOW-ALL + FormBuscaAuxiliar sem parametros + DefinirCursor +
628:     * Mostrar().
629:     *--------------------------------------------------------------------------
630:     PROTECTED PROCEDURE AbrirLookupTabelaDesconto()
631:         LOCAL loc_oGrid, loc_cValor, loc_cSQL, loc_nResultado, loc_oBusca, loc_oErro
632:         TRY
633:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
634:                 loc_cValor = ALLTRIM(cursor_4c_Dados.codigos)
635: 
636:                 IF USED("cursor_4c_LkpTbd")
637:                     USE IN cursor_4c_LkpTbd
638:                 ENDIF
639: 
640:                 IF !EMPTY(loc_cValor)
641:                     loc_cSQL = "SELECT codigos AS Cods, descrs AS Descs FROM SigOpTdz" + ;
642:                                " WHERE codigos LIKE " + EscaparSQL(loc_cValor + "%") + ;
643:                                " ORDER BY codigos"
644:                 ELSE
645:                     loc_cSQL = "SELECT codigos AS Cods, descrs AS Descs FROM SigOpTdz" + ;
646:                                " ORDER BY codigos"
647:                 ENDIF
648: 
649:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpTbd")
650: 
651:                 *-- Fallback SHOW-ALL: prefixo nao bateu, lista tudo
652:                 IF loc_nResultado > 0 AND USED("cursor_4c_LkpTbd") AND ;
653:                    RECCOUNT("cursor_4c_LkpTbd") = 0 AND !EMPTY(loc_cValor)
654:                     USE IN cursor_4c_LkpTbd
655:                     loc_cSQL = "SELECT codigos AS Cods, descrs AS Descs FROM SigOpTdz" + ;
656:                                " ORDER BY codigos"
657:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpTbd")
658:                 ENDIF
659: 
660:                 IF loc_nResultado > 0 AND USED("cursor_4c_LkpTbd") AND ;
661:                    RECCOUNT("cursor_4c_LkpTbd") > 0
662: 
663:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
664:                     IF VARTYPE(loc_oBusca) = "O"
665:                         loc_oBusca.DefinirCursor("cursor_4c_LkpTbd", "Cods", "Descs", ;
666:                             "Tabelas de Desconto")
667: 
668:                         IF loc_oBusca.Mostrar()
669:                             SELECT cursor_4c_Dados
670:                             REPLACE codigos WITH LEFT(ALLTRIM(loc_oBusca.cCodigoSelecionado), 10), ;
671:                                     descrs  WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
672:                             THIS.GravaDados = .T.
673: 
674:                             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
675:                             loc_oGrid.Refresh
676:                         ENDIF
677:                     ENDIF
678:                 ELSE
679:                     MsgAviso("Nenhuma tabela de desconto encontrada" + ;
680:                         IIF(!EMPTY(loc_cValor), " para [" + loc_cValor + "]", "") + ".", ;
681:                         "Tabelas de Desconto")
682:                 ENDIF
683: 
684:                 IF USED("cursor_4c_LkpTbd")
685:                     USE IN cursor_4c_LkpTbd
686:                 ENDIF
687:             ENDIF
688:         CATCH TO loc_oErro
689:             MsgErro(loc_oErro.Message + CHR(13) + ;
690:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
691:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.AbrirLookupTabelaDesconto")
692:         ENDTRY
693:     ENDPROC
694: 
695:     *--------------------------------------------------------------------------
696:     * CarregarLista - Busca as tabelas de desconto ja vinculadas a operacao
697:     * corrente (THIS.this_cDopes) e vincula cursor_4c_Dados ao grid.
698:     * RecordSource reseta Column.Width/Header1.Caption (Problema 48) - por
699:     * isso a reconfiguracao acontece SEMPRE apos o ControlSource.
700:     *--------------------------------------------------------------------------
701:     PROTECTED FUNCTION CarregarLista()
702:         LOCAL loc_oGrid, loc_lSucesso, loc_oErro
703:         loc_lSucesso = .F.
704:         TRY
705:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
706:                THIS.this_oBusinessObject.BuscarPorOperacao(THIS.this_cDopes)
707: 
708:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
709: 
710:                 loc_oGrid.RecordSource = ""
711:                 loc_oGrid.ColumnCount  = 2
712:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
713:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
714:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
715: 
716:                 *-- Reconfigura Width/Header1.Caption (perdidos ao resetar RecordSource)
717:                 loc_oGrid.Column1.Width           = 80
718:                 loc_oGrid.Column1.Header1.Caption = "Tabela"
719:                 loc_oGrid.Column2.Width           = 200
720:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
721:                 loc_oGrid.Column2.Text1.ReadOnly  = .T.
722: 
723:                 loc_oGrid.Refresh
724: 
725:                 THIS.GravaDados = .F.
726:                 loc_lSucesso = .T.
727:             ENDIF
728:         CATCH TO loc_oErro
729:             MsgErro(loc_oErro.Message + CHR(13) + ;
730:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
731:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.CarregarLista")
732:         ENDTRY
733:         RETURN loc_lSucesso
734:     ENDFUNC
735: 
736:     *--------------------------------------------------------------------------
737:     * HabilitarEdicaoGrid - Liga/desliga a edicao inline do codigo no grid.
738:     * Column2 (Descricao) permanece SEMPRE somente-leitura (espelha
739:     * Column2.When = Return .F. do legado). Os botoes NAO sao desabilitados:
740:     * Enabled = .F. em CommandButton com Picture apaga o icone - o bloqueio do
741:     * modo VISUALIZAR eh feito por guard dentro de cada handler.
742:     *--------------------------------------------------------------------------
743:     PROTECTED PROCEDURE HabilitarEdicaoGrid(par_lHabilitar)
744:         LOCAL loc_lEdita, loc_oErro
745:         loc_lEdita = (VARTYPE(par_lHabilitar) != "L" OR par_lHabilitar)
746:         TRY
747:             WITH THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
748:                 .ReadOnly               = !loc_lEdita
749:                 .Column1.ReadOnly       = !loc_lEdita
750:                 .Column1.Text1.ReadOnly = !loc_lEdita
751:                 .Column2.ReadOnly       = .T.
752:                 .Column2.Text1.ReadOnly = .T.
753:             ENDWITH
754:         CATCH TO loc_oErro
755:             MsgErro(loc_oErro.Message + CHR(13) + ;
756:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
757:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.HabilitarEdicaoGrid")
758:         ENDTRY
759:     ENDPROC
760: 
761:     *--------------------------------------------------------------------------
762:     * BtnIncluirClick - Adiciona linha em branco no cursor_4c_Dados e coloca
763:     * o foco na coluna do codigo para digitacao. Espelha cmdInserir.Click do
764:     * legado: Insert Into xOpe (codigos) Values (Space(10)) / GravaDados = .t.
765:     * / GradeOpe.Column1.SetFocus. Handler ligado ao botao Inserir da Page1.
766:     *--------------------------------------------------------------------------
767:     PROCEDURE BtnIncluirClick()
768:         LOCAL loc_oGrid, loc_oErro
769:         TRY
770:             IF !USED("cursor_4c_Dados")
771:                 MsgAviso("Lista de tabelas de desconto n" + CHR(227) + "o est" + ;
772:                     CHR(225) + " carregada.", "Aviso")
773:             ELSE
774:                 *-- Sai do modo somente-leitura (caso venha de VISUALIZAR)
775:                 THIS.HabilitarEdicaoGrid(.T.)
776:                 THIS.this_cModoAtual = "INCLUIR"
777: 
778:                 INSERT INTO cursor_4c_Dados (codigos) VALUES (SPACE(10))
779: 
780:                 THIS.GravaDados = .T.
781:                 THIS.AntValue   = SPACE(10)
782: 
783:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
784:                 loc_oGrid.Refresh
785:                 loc_oGrid.SetFocus
786:                 loc_oGrid.ActiveColumn = 1
787:                 IF PEMSTATUS(loc_oGrid.Column1, "Text1", 5)
788:                     loc_oGrid.Column1.Text1.SetFocus
789:                 ENDIF
790:             ENDIF
791:         CATCH TO loc_oErro
792:             MsgErro(loc_oErro.Message + CHR(13) + ;
793:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
794:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.BtnIncluirClick")
795:         ENDTRY
796:     ENDPROC
797: 
798:     *--------------------------------------------------------------------------
799:     * BtnAlterarClick - Coloca a linha selecionada do grid em edicao. O legado
800:     * altera inline (nao ha botao dedicado): a troca do codigo acontece ao
801:     * digitar sobre a Column1 da linha corrente. Guarda o valor anterior em
802:     * AntValue (espelha Column1.When: Thisform.AntValue = This.Value) e devolve
803:     * o foco a coluna do codigo, de onde F4/ENTER/TAB acionam o lookup SigOpTdz.
804:     *--------------------------------------------------------------------------
805:     PROCEDURE BtnAlterarClick()
806:         LOCAL loc_oGrid, loc_oErro
807:         TRY
808:             IF !USED("cursor_4c_Dados")
809:                 MsgAviso("Lista de tabelas de desconto n" + CHR(227) + "o est" + ;
810:                     CHR(225) + " carregada.", "Aviso")
811:             ELSE
812:                 SELECT cursor_4c_Dados
813:                 IF RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
814:                     MsgAviso("Selecione uma tabela de desconto na lista.", ;
815:                         "Aten" + CHR(231) + CHR(227) + "o")
816:                 ELSE
817:                     THIS.HabilitarEdicaoGrid(.T.)
818:                     THIS.this_cModoAtual = "ALTERAR"
819:                     THIS.AntValue        = cursor_4c_Dados.codigos
820: 
821:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
822:                     loc_oGrid.Refresh
823:                     loc_oGrid.SetFocus
824:                     loc_oGrid.ActiveColumn = 1
825:                     IF PEMSTATUS(loc_oGrid.Column1, "Text1", 5)
826:                         loc_oGrid.Column1.Text1.SetFocus
827:                     ENDIF
828:                 ENDIF
829:             ENDIF
830:         CATCH TO loc_oErro
831:             MsgErro(loc_oErro.Message + CHR(13) + ;
832:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
833:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.BtnAlterarClick")
834:         ENDTRY
835:     ENDPROC
836: 
837:     *--------------------------------------------------------------------------
838:     * BtnVisualizarClick - Consulta somente-leitura da tabela de desconto
839:     * selecionada: bloqueia a edicao inline do grid e le o cadastro em
840:     * SigOpTdz (mesma origem do lookup Column1.Text1.Valid do legado),
841:     * exibindo Operacao/Codigo/Descricao do registro. Se o codigo da linha nao
842:     * estiver cadastrado em SigOpTdz, avisa (dado orfao no vinculo).
843:     *--------------------------------------------------------------------------
844:     PROCEDURE BtnVisualizarClick()
845:         LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oGrid, loc_oErro
846:         TRY
847:             IF !USED("cursor_4c_Dados")
848:                 MsgAviso("Lista de tabelas de desconto n" + CHR(227) + "o est" + ;
849:                     CHR(225) + " carregada.", "Aviso")
850:             ELSE
851:                 SELECT cursor_4c_Dados
852:                 IF RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
853:                     MsgAviso("Selecione uma tabela de desconto na lista.", ;
854:                         "Aten" + CHR(231) + CHR(227) + "o")
855:                 ELSE
856:                     THIS.this_cModoAtual = "VISUALIZAR"
857:                     THIS.HabilitarEdicaoGrid(.F.)
858: 
859:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
860:                     loc_oGrid.Refresh
861: 
862:                     loc_cValor = ALLTRIM(cursor_4c_Dados.codigos)
863: 
864:                     IF EMPTY(loc_cValor)
865:                         MsgAviso("Linha sem c" + CHR(243) + "digo de tabela informado.", ;
866:                             "Tabelas de Desconto")
867:                     ELSE
868:                         IF USED("cursor_4c_VisTbd")
869:                             USE IN cursor_4c_VisTbd
870:                         ENDIF
871: 
872:                         loc_cSQL = "SELECT codigos, descrs FROM SigOpTdz" + ;
873:                                    " WHERE RTRIM(codigos) = " + EscaparSQL(loc_cValor)
874: 
875:                         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VisTbd")
876: 
877:                         IF loc_nResultado > 0 AND USED("cursor_4c_VisTbd") AND ;
878:                            RECCOUNT("cursor_4c_VisTbd") > 0
879: 
880:                             MsgInfo("Opera" + CHR(231) + CHR(227) + "o: " + ;
881:                                 ALLTRIM(THIS.this_cDopes) + CHR(13) + ;
882:                                 "C" + CHR(243) + "digo: " + ;
883:                                 ALLTRIM(NVL(cursor_4c_VisTbd.codigos, "")) + CHR(13) + ;
884:                                 "Descri" + CHR(231) + CHR(227) + "o: " + ;
885:                                 ALLTRIM(NVL(cursor_4c_VisTbd.descrs, "")), ;
886:                                 "Tabela de Desconto")
887: 
888:                             USE IN cursor_4c_VisTbd
889:                         ELSE
890:                             IF USED("cursor_4c_VisTbd")
891:                                 USE IN cursor_4c_VisTbd
892:                             ENDIF
893: 
894:                             MsgAviso("Tabela de desconto [" + loc_cValor + "] n" + ;
895:                                 CHR(227) + "o cadastrada em SigOpTdz.", ;
896:                                 "Tabelas de Desconto")
897:                         ENDIF
898:                     ENDIF
899: 
900:                     SELECT cursor_4c_Dados
901:                 ENDIF
902:             ENDIF
903:         CATCH TO loc_oErro
904:             MsgErro(loc_oErro.Message + CHR(13) + ;
905:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
906:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.BtnVisualizarClick")
907:         ENDTRY
908:     ENDPROC
909: 
910:     *--------------------------------------------------------------------------
911:     * BtnExcluirClick - Remove a linha corrente do cursor_4c_Dados. Espelha
912:     * cmdExcluir.Click do legado (Delete / Skip / Go Bott se Eof / GravaDados
913:     * = .t.) - sem confirmacao, igual ao original. Bloqueado em VISUALIZAR.
914:     *--------------------------------------------------------------------------
915:     PROCEDURE BtnExcluirClick()
916:         LOCAL loc_oGrid, loc_oErro
917:         TRY
918:             IF !USED("cursor_4c_Dados")
919:                 MsgAviso("Lista de tabelas de desconto n" + CHR(227) + "o est" + ;
920:                     CHR(225) + " carregada.", "Aviso")
921:             ELSE
922:                 IF THIS.this_cModoAtual = "VISUALIZAR"
923:                     MsgAviso("Lista em modo de visualiza" + CHR(231) + CHR(227) + "o." + ;
924:                         CHR(13) + "Clique em Inserir ou volte a alterar a linha " + ;
925:                         "antes de excluir.", "Tabelas de Desconto")
926:                 ELSE
927:                     SELECT cursor_4c_Dados
928:                     IF !EOF()
929:                         DELETE
930:                         SKIP
931:                         IF EOF()
932:                             GO BOTTOM
933:                         ENDIF
934:                     ENDIF
935: 
936:                     THIS.GravaDados = .T.
937: 
938:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
939:                     loc_oGrid.Refresh
940:                     loc_oGrid.SetFocus
941:                 ENDIF
942:             ENDIF
943:         CATCH TO loc_oErro
944:             MsgErro(loc_oErro.Message + CHR(13) + ;
945:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
946:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.BtnExcluirClick")
947:         ENDTRY
948:     ENDPROC
949: 
950:     *--------------------------------------------------------------------------
951:     * BtnConfirmarClick - Grava as tabelas de desconto da operacao e fecha o
952:     * form (espelha cmdSair.Click). Se GravaDados = .F. (nada foi alterado),
953:     * apenas reabilita o form pai e fecha, sem tocar o banco. Se houver
954:     * codigos duplicados no grid, aborta com MsgErro e mantem o form aberto
955:     * (unico caso de "Return .f." no legado). Uma falha na gravacao em si
956:     * (SalvarPorOperacao) apenas exibe o erro mas NAO impede o fechamento -
957:     * no legado o "MessageBox('Erro na Gravacao...')" nao tem Return .f.
958:     * apos ele, o fluxo cai direto em ParentForm.Enabled=.T./Release. Usa
959:     * TbdBO.VerificarDuplicidade + SalvarPorOperacao (DELETE + INSERT por
960:     * operacao, ja implementados na Fase 1/2).
961:     *--------------------------------------------------------------------------
962:     PROCEDURE BtnConfirmarClick()
963:         LOCAL loc_lPodeFechar, loc_oErro
964:         loc_lPodeFechar = .T.
965:         TRY
966:             *-- Toda a gravacao (FormParaBO + duplicidade + SalvarPorOperacao)
967:             *-- esta em BtnSalvarClick; aqui so decidimos se o form fecha.
968:             loc_lPodeFechar = THIS.BtnSalvarClick()
969:         CATCH TO loc_oErro
970:             loc_lPodeFechar = .F.
971:             MsgErro(loc_oErro.Message + CHR(13) + ;
972:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
973:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.BtnConfirmarClick")
974:         ENDTRY
975: 
976:         IF loc_lPodeFechar
977:             IF VARTYPE(THIS.this_oParentForm) = "O"
978:                 THIS.this_oParentForm.Enabled = .T.
979:             ENDIF
980:             THIS.Release()
981:         ENDIF
982:     ENDPROC
983: 
984:     *--------------------------------------------------------------------------
985:     * BtnCancelarClick - Fecha o form sem gravar (espelha Cancela.Click)
986:     *--------------------------------------------------------------------------
987:     PROCEDURE BtnCancelarClick()
988:         IF VARTYPE(THIS.this_oParentForm) = "O"
989:             THIS.this_oParentForm.Enabled = .T.
990:         ENDIF
991:         THIS.Release()
992:     ENDPROC
993: 
994:     *--------------------------------------------------------------------------
995:     * FormParaBO - Transfere o estado do form para as propriedades do TbdBO.
996:     * Neste form OPERACIONAL a edicao acontece inline no grid (nao ha pagina
997:     * de campos), entao o "estado do form" eh: a operacao corrente (Dopes,
998:     * recebida no Init) mais a linha selecionada do cursor_4c_Dados. Espelha
999:     * o cmdSair.Click do legado, que monta o registro a partir de
1000:     * crSigCdOpe.Dopes + xOpe.codigos antes de gravar.
1001:     * Retorna .F. (com aviso) quando o form nao tem operacao definida - sem
1002:     * Dopes o DELETE/INSERT por operacao apagaria a faixa errada.
1003:     *--------------------------------------------------------------------------
1004:     FUNCTION FormParaBO()
1005:         LOCAL loc_lSucesso, loc_oErro
1006:         loc_lSucesso = .F.
1007:         TRY
1008:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1009:                 MsgAviso("Business Object n" + CHR(227) + "o inicializado.", ;
1010:                     "Tabelas de Desconto")
1011:             ELSE
1012:                 IF EMPTY(ALLTRIM(THIS.this_cDopes))
1013:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
1014:                         "o informada." + CHR(13) + "Selecione a opera" + CHR(231) + ;
1015:                         CHR(227) + "o antes de gravar as tabelas de desconto.", ;
1016:                         "Tabelas de Desconto")
1017:                 ELSE
1018:                     THIS.this_oBusinessObject.this_cDopes = ;
1019:                         LEFT(ALLTRIM(THIS.this_cDopes), 20)
1020:                     THIS.this_oBusinessObject.this_cDescOperacao = ;
1021:                         ALLTRIM(THIS.this_cDescOperacao)
1022: 
1023:                     *-- Linha corrente do grid (pode nao existir em lista vazia)
1024:                     IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1025:                         THIS.this_oBusinessObject.this_cCodigos = ;
1026:                             LEFT(ALLTRIM(NVL(cursor_4c_Dados.codigos, "")), 10)
1027: 
1028:                         IF TYPE("cursor_4c_Dados.cidchaves") != "U"
1029:                             THIS.this_oBusinessObject.this_cCidChaves = ;
1030:                                 LEFT(ALLTRIM(NVL(cursor_4c_Dados.cidchaves, "")), 20)
1031:                         ELSE
1032:                             THIS.this_oBusinessObject.this_cCidChaves = ""
1033:                         ENDIF
1034:                     ELSE
1035:                         THIS.this_oBusinessObject.this_cCodigos   = ""
1036:                         THIS.this_oBusinessObject.this_cCidChaves = ""
1037:                     ENDIF
1038: 
1039:                     loc_lSucesso = .T.
1040:                 ENDIF
1041:             ENDIF
1042:         CATCH TO loc_oErro
1043:             MsgErro(loc_oErro.Message + CHR(13) + ;
1044:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1045:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.FormParaBO")
1046:         ENDTRY
1047:         RETURN loc_lSucesso
1048:     ENDFUNC
1049: 
1050:     *--------------------------------------------------------------------------
1051:     * BOParaForm - Transfere as propriedades do TbdBO de volta para o form.
1052:     * Reproduz o trecho do Init legado que monta o titulo a partir da operacao
1053:     *     .Caption = [Grupos de Produtos ] + AllTrim(crSigCdOpe.Dopes)
1054:     *     cntSombra.lblSombra.Caption = ThisForm.Caption
1055:     *     cntSombra.lblTitulo.Caption = ThisForm.Caption
1056:     * e, quando o BO carrega um registro (CarregarPorCodigo/CarregarDoCursor),
1057:     * devolve codigos/descrs para a linha corrente do grid. A descricao eh
1058:     * relida de SigOpTdz - a mesma origem do lookup - porem SEM abrir o
1059:     * FormBuscaAuxiliar quando o codigo nao existe (transferencia de dados
1060:     * nao deve disparar dialogo; quem faz isso eh ValidarCodigoTabela).
1061:     *--------------------------------------------------------------------------
1062:     FUNCTION BOParaForm()
1063:         LOCAL loc_lSucesso, loc_cCaption, loc_cCodigo, loc_cSQL
1064:         LOCAL loc_nResultado, loc_cDescricao, loc_oGrid, loc_oErro
1065:         loc_lSucesso = .F.
1066:         TRY
1067:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1068:                 MsgAviso("Business Object n" + CHR(227) + "o inicializado.", ;
1069:                     "Tabelas de Desconto")
1070:             ELSE
1071:                 *-- 1. Operacao: BO eh a fonte quando ja carregou um registro
1072:                 IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cDopes))
1073:                     THIS.this_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
1074:                 ENDIF
1075:                 IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cDescOperacao))
1076:                     THIS.this_cDescOperacao = ;
1077:                         ALLTRIM(THIS.this_oBusinessObject.this_cDescOperacao)
1078:                 ENDIF
1079: 
1080:                 *-- 2. Titulo (string exata do legado) propagado para as 2 Pages
1081:                 loc_cCaption = "Grupos de Produtos " + ALLTRIM(THIS.this_cDopes)
1082:                 THIS.Caption = loc_cCaption
1083:                 THIS.AtualizarTitulo(loc_cCaption)
1084: 
1085:                 *-- 3. Linha corrente do grid a partir do registro do BO
1086:                 loc_cCodigo = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
1087: 
1088:                 IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados") AND ;
1089:                    !EOF("cursor_4c_Dados")
1090: 
1091:                     loc_cDescricao = ""
1092: 
1093:                     IF USED("cursor_4c_BoTbd")
1094:                         USE IN cursor_4c_BoTbd
1095:                     ENDIF
1096: 
1097:                     loc_cSQL = "SELECT codigos, descrs FROM SigOpTdz" + ;
1098:                                " WHERE RTRIM(codigos) = " + EscaparSQL(loc_cCodigo)
1099: 
1100:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BoTbd")
1101: 
1102:                     IF loc_nResultado > 0 AND USED("cursor_4c_BoTbd") AND ;
1103:                        RECCOUNT("cursor_4c_BoTbd") > 0
1104:                         loc_cDescricao = ALLTRIM(NVL(cursor_4c_BoTbd.descrs, ""))
1105:                     ENDIF
1106: 
1107:                     IF USED("cursor_4c_BoTbd")
1108:                         USE IN cursor_4c_BoTbd

*-- Linhas 1121 a 1192:
1121:         CATCH TO loc_oErro
1122:             MsgErro(loc_oErro.Message + CHR(13) + ;
1123:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1124:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.BOParaForm")
1125:         ENDTRY
1126:         RETURN loc_lSucesso
1127:     ENDFUNC
1128: 
1129:     *--------------------------------------------------------------------------
1130:     * AtualizarTitulo - Propaga o caption para os cabecalhos das duas Pages
1131:     * (Page1/Lista e Page2/Dados). Espelha as duas linhas do Init legado que
1132:     * copiam ThisForm.Caption para cntSombra.lblSombra e cntSombra.lblTitulo.
1133:     *--------------------------------------------------------------------------
1134:     PROTECTED PROCEDURE AtualizarTitulo(par_cCaption)
1135:         LOCAL loc_nPag, loc_oPag, loc_oErro
1136:         TRY
1137:             FOR loc_nPag = 1 TO THIS.pgf_4c_Paginas.PageCount
1138:                 loc_oPag = THIS.pgf_4c_Paginas.Pages(loc_nPag)
1139: 
1140:                 IF PEMSTATUS(loc_oPag, "cnt_4c_Cabecalho", 5)
1141:                     IF PEMSTATUS(loc_oPag.cnt_4c_Cabecalho, "lbl_4c_Sombra", 5)
1142:                         loc_oPag.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = par_cCaption
1143:                     ENDIF
1144:                     IF PEMSTATUS(loc_oPag.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
1145:                         loc_oPag.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = par_cCaption
1146:                     ENDIF
1147:                 ENDIF
1148:             ENDFOR
1149:         CATCH TO loc_oErro
1150:             MsgErro(loc_oErro.Message + CHR(13) + ;
1151:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1152:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.AtualizarTitulo")
1153:         ENDTRY
1154:     ENDPROC
1155: 
1156:     *--------------------------------------------------------------------------
1157:     * BtnSalvarClick - Grava as tabelas de desconto da operacao SEM fechar o
1158:     * form. Concentra a logica de gravacao do cmdSair.Click legado:
1159:     *   If ThisForm.GravaDados
1160:     *       <checa duplicidade> -> Return .f.
1161:     *       Zap crSigCdTbd / Scan xOpe -> Insert / Delete From SigCdTbd / Update
1162:     *       If erro -> MessageBox (sem Return .f.)
1163:     *   EndIf
1164:     * Retorno: .T. = fluxo pode prosseguir (nada a gravar, ou gravacao
1165:     * tentada); .F. = duplicidade detectada, o usuario precisa corrigir o
1166:     * grid. Esse retorno eh o que BtnConfirmarClick usa para decidir se fecha
1167:     * o form - no legado somente a duplicidade tem "Return .f.": um erro de
1168:     * gravacao exibe a mensagem mas o form fecha assim mesmo.
1169:     *--------------------------------------------------------------------------
1170:     FUNCTION BtnSalvarClick()
1171:         LOCAL loc_lProsseguir, loc_oErro
1172:         loc_lProsseguir = .T.
1173:         TRY
1174:             IF THIS.GravaDados
1175:                 IF !THIS.FormParaBO()
1176:                     *-- Sem operacao definida: FormParaBO ja avisou o usuario
1177:                     loc_lProsseguir = .F.
1178:                 ELSE
1179:                     IF THIS.this_oBusinessObject.VerificarDuplicidade("cursor_4c_Dados")
1180:                         MsgErro("Existem lan" + CHR(231) + "amentos de Tabelas de " + ;
1181:                             "Desconto em duplicidade!!!", "Duplicidade")
1182:                         loc_lProsseguir = .F.
1183:                     ELSE
1184:                         IF THIS.this_oBusinessObject.SalvarPorOperacao( ;
1185:                                 THIS.this_cDopes, "cursor_4c_Dados")
1186:                             THIS.GravaDados = .F.
1187:                         ELSE
1188:                             *-- Legado NAO interrompe o fluxo nesse caso (nao ha
1189:                             *-- Return .f. apos o MessageBox de erro de gravacao)
1190:                             MsgErro("Erro na grava" + CHR(231) + CHR(227) + ;
1191:                                 "o dos dados!!!" + CHR(13) + ;
1192:                                 THIS.this_oBusinessObject.ObterMensagemErro(), "Erro")

*-- Linhas 1198 a 1259:
1198:             loc_lProsseguir = .F.
1199:             MsgErro(loc_oErro.Message + CHR(13) + ;
1200:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1201:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.BtnSalvarClick")
1202:         ENDTRY
1203:         RETURN loc_lProsseguir
1204:     ENDFUNC
1205: 
1206:     *--------------------------------------------------------------------------
1207:     * AlternarPagina - Troca a pagina ativa do pgf_4c_Paginas (1=Lista/2=Dados)
1208:     *--------------------------------------------------------------------------
1209:     PROCEDURE AlternarPagina(par_nPagina)
1210:         IF VARTYPE(par_nPagina) = "N" AND INLIST(par_nPagina, 1, 2)
1211:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1212:         ENDIF
1213:     ENDPROC
1214: 
1215:     *--------------------------------------------------------------------------
1216:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1217:     * (percorre Pages de PageFrames alem de Controls de Containers)
1218:     *--------------------------------------------------------------------------
1219:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1220:         LOCAL loc_i, loc_nP, loc_oControl, loc_oErro
1221:         TRY
1222:             FOR loc_i = 1 TO par_oContainer.ControlCount
1223:                 loc_oControl = par_oContainer.Controls(loc_i)
1224:                 IF VARTYPE(loc_oControl) = "O"
1225:                     IF PEMSTATUS(loc_oControl, "Visible", 5)
1226:                         loc_oControl.Visible = .T.
1227:                     ENDIF
1228:                     IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
1229:                         FOR loc_nP = 1 TO loc_oControl.PageCount
1230:                             THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
1231:                         ENDFOR
1232:                     ENDIF
1233:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1234:                        loc_oControl.ControlCount > 0
1235:                         THIS.TornarControlesVisiveis(loc_oControl)
1236:                     ENDIF
1237:                 ENDIF
1238:             ENDFOR
1239:         CATCH TO loc_oErro
1240:             MsgErro(loc_oErro.Message + CHR(13) + ;
1241:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1242:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.TornarControlesVisiveis")
1243:         ENDTRY
1244:     ENDPROC
1245: 
1246:     *--------------------------------------------------------------------------
1247:     * Destroy - Reabilita form pai e libera cursores
1248:     *--------------------------------------------------------------------------
1249:     PROCEDURE Destroy()
1250:         IF VARTYPE(THIS.this_oParentForm) = "O"
1251:             THIS.this_oParentForm.Enabled = .T.
1252:         ENDIF
1253:         IF USED("cursor_4c_Dados")
1254:             USE IN cursor_4c_Dados
1255:         ENDIF
1256:         DODEFAULT()
1257:     ENDPROC
1258: 
1259: ENDDEFINE


### BO (C:\4c\projeto\app\classes\TbdBO.prg):
*====================================================================
* TbdBO.prg
*
* Business Object para Tabelas de Desconto por Operacao
* Tabela principal: SigCdTbd (cidchaves PK)
* Tabela pai: SigCdOpe (dopes) - Operacao a qual as tabelas pertencem
* Tabela de referencia (lookup): SigOpTdz (codigos) - Tabela de Desconto
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TbdBO AS BusinessBase

	*-- Propriedades da entidade (SigCdTbd)
	this_cCodigos     = ""   && codigos char(10)   - codigo da tabela de desconto (FK SigOpTdz.codigos)
	this_cCidChaves   = ""   && cidchaves char(20) - PK (chave unica Fortyus)
	this_cDopes       = ""   && dopes char(20)     - codigo/descricao da operacao (FK SigCdOpe.dopes)

	*-- Propriedades locais (NAO persistem - apenas estado/UI)
	this_cDescOperacao = ""  && descricao da operacao exibida no cabecalho (= crSigCdOpe.Dopes)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdTbd"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidChaves)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCodigos   = TratarNulo(codigos, "C")
			THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
			THIS.this_cDopes     = TratarNulo(dopes, "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidChaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, cidchaves, dopes" + ;
			           " FROM SigCdTbd" + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(par_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigCdTbd
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(THIS.this_cCidChaves)
				THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
			ENDIF

			loc_cSQL = "INSERT INTO SigCdTbd (codigos, cidchaves, dopes)" + ;
			           " VALUES (" + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigos), 10)) + "," + ;
			           EscaparSQL(THIS.this_cCidChaves) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigCdTbd
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdTbd SET" + ;
			           " codigos = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigos), 10)) + "," + ;
			           " dopes = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SigCdTbd
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdTbd WHERE RTRIM(cidchaves) = " + ;
			           EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* BuscarPorOperacao - Carrega TODAS as tabelas de desconto vinculadas
	* a uma operacao (Dopes), com a descricao da tabela (SigOpTdz.descrs).
	* Espelha o SELECT original do Init() legado:
	*   Select a.*, b.descrs From SigCdTbd a, SigOpTdz b
	*   Where a.Dopes = <dopes> And a.codigos = b.codigos
	* cursor_4c_Dados eh convertido para READWRITE (SQLEXEC gera cursor
	* somente-leitura) pois o grid permite Inserir/Excluir/editar linhas
	* localmente antes de Confirmar (SalvarPorOperacao).
	*====================================================================
	PROCEDURE BuscarPorOperacao(par_cDopes)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_cSQL = "SELECT a.codigos AS codigos, a.cidchaves AS cidchaves," + ;
			           " a.dopes AS dopes, b.descrs AS descrs" + ;
			           " FROM SigCdTbd a INNER JOIN SigOpTdz b ON a.codigos = b.codigos" + ;
			           " WHERE RTRIM(a.dopes) = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
			           " ORDER BY a.codigos"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
			IF loc_nResultado >= 0
				SELECT codigos, cidchaves, dopes, descrs ;
					FROM cursor_4c_DadosTmp ;
					INTO CURSOR cursor_4c_Dados READWRITE

				IF USED("cursor_4c_DadosTmp")
					USE IN cursor_4c_DadosTmp
				ENDIF

				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar tabelas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar tabelas de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_DadosTmp")
				USE IN cursor_4c_DadosTmp
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* SalvarPorOperacao - Grava a lista completa de tabelas de desconto
	* de uma operacao (Dopes), substituindo os registros existentes.
	* Espelha o cmdSair.Click original: Delete From SigCdTbd Where dopes = ?
	* seguido de Insert Into SigCdTbd para cada linha nao vazia do grid.
	* par_cAliasCursor: cursor com as linhas do grid (coluna codigos).
	*====================================================================
	PROCEDURE SalvarPorOperacao(par_cDopes, par_cAliasCursor)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidChaves

		loc_lSucesso = .F.

		IF !USED(par_cAliasCursor)
			THIS.this_cMensagemErro = "Cursor de dados n" + CHR(227) + "o localizado"
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "DELETE FROM SigCdTbd WHERE RTRIM(dopes) = " + ;
			           EscaparSQL(ALLTRIM(par_cDopes))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado < 0
				MsgErro("Erro ao excluir tabelas de desconto anteriores:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_lSucesso = .T.

				SELECT (par_cAliasCursor)
				SCAN WHILE loc_lSucesso
					IF !EMPTY(ALLTRIM(EVALUATE(par_cAliasCursor + ".codigos")))
						loc_cCidChaves = LEFT(fUniqueIds(), 20)

						loc_cSQL = "INSERT INTO SigCdTbd (codigos, cidchaves, dopes)" + ;
						           " VALUES (" + ;
						           EscaparSQL(LEFT(ALLTRIM(EVALUATE(par_cAliasCursor + ".codigos")), 10)) + "," + ;
						           EscaparSQL(loc_cCidChaves) + "," + ;
						           EscaparSQL(LEFT(ALLTRIM(par_cDopes), 20)) + ;
						           ")"

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

						IF loc_nResultado < 0
							MsgErro("Erro ao gravar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
						ELSE
							THIS.this_cCidChaves = loc_cCidChaves
							THIS.this_cCodigos   = ALLTRIM(EVALUATE(par_cAliasCursor + ".codigos"))
							THIS.this_cDopes     = ALLTRIM(par_cDopes)
							THIS.RegistrarAuditoria("INSERT")
						ENDIF
					ENDIF
				ENDSCAN

				SELECT (par_cAliasCursor)
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao gravar tabelas de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* VerificarDuplicidade - Verifica se ha codigos de tabela duplicados
	* no cursor do grid (espelha a checagem do cmdSair.Click original):
	*   Select Codigos, Sum(1) as Qt From xOpe Group by 1
	*   Into Cursor Selecao where codigos <> ' ' having Sum(1) > 1
	*====================================================================
	FUNCTION VerificarDuplicidade(par_cAliasCursor)
		LOCAL loc_lDuplicado

		loc_lDuplicado = .F.

		IF !USED(par_cAliasCursor)
			RETURN .F.
		ENDIF

		IF USED("cursor_4c_Duplicados")
			USE IN cursor_4c_Duplicados
		ENDIF

		SELECT codigos, COUNT(*) AS Qt FROM (par_cAliasCursor) ;
			WHERE ALLTRIM(codigos) <> "" ;
			GROUP BY codigos ;
			HAVING COUNT(*) > 1 ;
			INTO CURSOR cursor_4c_Duplicados

		IF USED("cursor_4c_Duplicados")
			IF RECCOUNT("cursor_4c_Duplicados") > 0
				loc_lDuplicado = .T.
			ENDIF
			USE IN cursor_4c_Duplicados
		ENDIF

		SELECT (par_cAliasCursor)

		RETURN loc_lDuplicado
	ENDFUNC

ENDDEFINE

