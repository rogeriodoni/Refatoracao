# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRSTF.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (502 linhas total):

*-- Linhas 5 a 145:
5: * Tipo: OPERACIONAL - dialogo modal sem PageFrame
6: *
7: * Uso:
8: *   loForm = CREATEOBJECT("FormSIGPRSTF")
9: *   loForm.Show()
10: *   IF !loForm.this_lCancelado
11: *       lcSenha = loForm.this_cSenhaRetorno
12: *   ENDIF
13: *==============================================================================
14: 
15: DEFINE CLASS FormSIGPRSTF AS FormBase
16: 
17:     *-- BO associado
18:     this_oBusinessObject = .NULL.
19: 
20:     *-- Senha confirmada pelo usuario (ler apos Show())
21:     this_cSenhaRetorno = ""
22: 
23:     *-- .T. se usuario cancelou sem confirmar senha
24:     this_lCancelado = .T.
25: 
26:     *-- Propriedades visuais (PILAR 1: identico ao legado SigTfSup)
27:     Width       = 400
28:     Height      = 200
29:     AutoCenter  = .T.
30:     BorderStyle = 2
31:     Caption     = "Senha de Risco"
32:     ShowWindow = 1
33:     ControlBox  = .F.
34:     MaxButton   = .F.
35:     MinButton   = .F.
36:     TitleBar    = 0
37:     WindowType  = 1
38: 
39:     *--------------------------------------------------------------------------
40:     PROCEDURE Init()
41:     *--------------------------------------------------------------------------
42:         RETURN DODEFAULT()
43:     ENDPROC
44: 
45:     *--------------------------------------------------------------------------
46:     * InicializarForm - Instancia BO e configura layout base do dialogo
47:     *--------------------------------------------------------------------------
48:     PROTECTED PROCEDURE InicializarForm()
49:         LOCAL loc_lSucesso, loc_oErro
50: 
51:         loc_lSucesso = .F.
52: 
53:         TRY
54:             *-- Instanciar BO
55:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRSTFBO")
56: 
57:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
58:                 *-- Configurar aparencia base do form (fundo, fontes, cores)
59:                 THIS.ConfigurarPageFrame()
60: 
61:                 *-- Criar cabecalho cinza (cntSombra do legado)
62:                 THIS.ConfigurarCabecalho()
63: 
64:                 *-- Criar controles de entrada de senha
65:                 THIS.ConfigurarControlesSenha()
66: 
67:                 *-- Criar area de instrucao ao usuario
68:                 THIS.ConfigurarPaginaDados()
69: 
70:                 *-- Criar botao de cancelar
71:                 THIS.ConfigurarBotaoCancelar()
72: 
73:                 *-- Tornar todos os controles visiveis pos-AddObject
74:                 THIS.TornarControlesVisiveis()
75: 
76:                 loc_lSucesso = .T.
77:             ELSE
78:                 MsgErro("Erro ao criar SIGPRSTFBO", "Erro ao Inicializar")
79:             ENDIF
80: 
81:         CATCH TO loc_oErro
82:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
83:                     " PROC=" + loc_oErro.Procedure, ;
84:                     "Erro ao inicializar FormSIGPRSTF")
85:             loc_lSucesso = .F.
86:         ENDTRY
87: 
88:         RETURN loc_lSucesso
89:     ENDPROC
90: 
91:     *--------------------------------------------------------------------------
92:     * ConfigurarPageFrame - Configura aparencia base do form (sem PageFrame)
93:     * Dialogo simples: fundo cinza padrao Windows, sem barra de rolagem
94:     *--------------------------------------------------------------------------
95:     PROTECTED PROCEDURE ConfigurarPageFrame()
96:         THIS.BackColor  = RGB(212, 208, 200)
97:         THIS.ScrollBars = 0
98:         THIS.ShowTips   = .F.
99:     ENDPROC
100: 
101:     *--------------------------------------------------------------------------
102:     * ConfigurarCabecalho - Cria container de cabecalho cinza (cntSombra)
103:     * Original: cntSombra Top=0, Left=0, Width=800, Height=80
104:     *--------------------------------------------------------------------------
105:     PROTECTED PROCEDURE ConfigurarCabecalho()
106:         *-- Container cinza do cabecalho
107:         THIS.AddObject("cnt_4c_Sombra", "Container")
108:         WITH THIS.cnt_4c_Sombra
109:             .Top         = 0
110:             .Left        = 0
111:             .Width       = THIS.Width
112:             .Height      = 80
113:             .BorderWidth = 0
114:             .BackStyle   = 1
115:             .BackColor   = RGB(100,100,100)
116:             .Visible     = .T.
117:         ENDWITH
118: 
119:         *-- Label sombra (deslocado 1px para efeito de profundidade - preto)
120:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
121:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
122:             .AutoSize   = .F.
123:             .FontBold   = .T.
124:             .FontName   = "Tahoma"
125:             .FontSize   = 18
126:             .WordWrap   = .T.
127:             .Alignment  = 0
128:             .BackStyle  = 0
129:             .Caption    = "Senha de Risco"
130:             .Height     = 40
131:             .Left       = 10
132:             .Top        = 18
133:             .Width      = THIS.Width
134:             .ForeColor  = RGB(0,0,0)
135:             .Visible    = .T.
136:         ENDWITH
137: 
138:         *-- Label titulo principal (branco sobre cinza)
139:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
140:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
141:             .AutoSize   = .F.
142:             .FontBold   = .T.
143:             .FontName   = "Tahoma"
144:             .FontSize   = 18
145:             .WordWrap   = .T.

*-- Linhas 160 a 307:
160:     *--------------------------------------------------------------------------
161:     * AtualizarEstadoControles - override seguro (dialogo sem botoes CRUD)
162:     *--------------------------------------------------------------------------
163:     PROCEDURE AtualizarEstadoControles()
164:         RETURN
165:     ENDPROC
166: 
167:     *--------------------------------------------------------------------------
168:     * Handlers CRUD - Nao aplicavel a este form
169:     * ------------------------------------------------------------------------
170:     * SigTfSup (legado) eh dialogo modal de senha de supervisor: nao tem
171:     * grid de registros, nao tem Page Lista/Dados, nao expoe botoes Incluir/
172:     * Alterar/Visualizar/Excluir. O usuario digita senha + Enter (confirma) ou
173:     * clica Cancelar. Os handlers abaixo existem para satisfazer o contrato
174:     * do pipeline OPERACIONAL - caso o form seja acidentalmente chamado como
175:     * CRUD por menu.prg, os cliques nao geram erro em runtime.
176:     *--------------------------------------------------------------------------
177:     PROCEDURE BtnIncluirClick()
178:         MsgAviso("Esta janela n" + CHR(227) + "o suporta inclus" + CHR(227) + "o de registros.", ;
179:                  "Senha de Risco")
180:     ENDPROC
181: 
182:     PROCEDURE BtnAlterarClick()
183:         MsgAviso("Esta janela n" + CHR(227) + "o suporta altera" + CHR(231) + CHR(227) + "o de registros.", ;
184:                  "Senha de Risco")
185:     ENDPROC
186: 
187:     PROCEDURE BtnVisualizarClick()
188:         MsgAviso("Esta janela n" + CHR(227) + "o suporta visualiza" + CHR(231) + CHR(227) + "o de registros.", ;
189:                  "Senha de Risco")
190:     ENDPROC
191: 
192:     PROCEDURE BtnExcluirClick()
193:         MsgAviso("Esta janela n" + CHR(227) + "o suporta exclus" + CHR(227) + "o de registros.", ;
194:                  "Senha de Risco")
195:     ENDPROC
196: 
197:     *--------------------------------------------------------------------------
198:     * ConfigurarPaginaLista - Nao aplicavel (dialogo modal sem PageFrame)
199:     * SigTfSup legado eh dialogo simples de senha de supervisor sem lista/grid.
200:     * Mantido para satisfazer contrato de forms OPERACIONAL do pipeline.
201:     * O layout completo eh criado por ConfigurarCabecalho/ConfigurarControlesSenha/
202:     * ConfigurarBotaoCancelar - nao ha PageFrame.Page1 (Lista) a configurar.
203:     *--------------------------------------------------------------------------
204:     PROTECTED PROCEDURE ConfigurarPaginaLista()
205:         THIS.this_cModoAtual = "LISTA"
206:     ENDPROC
207: 
208:     *--------------------------------------------------------------------------
209:     * ConfigurarPaginaDados - Area de instrucao ao usuario (Container1 do legado)
210:     * Container1 exibe orientacao dinamica definida em Init() original:
211:     *   ThisForm.Container1.Label1.Caption = "Digite a Senha" + CHR(13) + "do Supervisor"
212:     *--------------------------------------------------------------------------
213:     PROTECTED PROCEDURE ConfigurarPaginaDados()
214:         *-- Container instrucao ao usuario (Container1 do legado)
215:         THIS.AddObject("cnt_4c_Container1", "Container")
216:         WITH THIS.cnt_4c_Container1
217:             .Top           = 137
218:             .Left          = 114
219:             .Width         = 171
220:             .Height        = 56
221:             .SpecialEffect = 0
222:             .BackStyle     = 1
223:             .BackColor     = RGB(212,208,200)
224:             .BorderWidth   = 0
225:             .Visible     = .T.
226:         ENDWITH
227: 
228:         THIS.cnt_4c_Container1.AddObject("lbl_4c_Label1", "Label")
229:         WITH THIS.cnt_4c_Container1.lbl_4c_Label1
230:             .AutoSize  = .F.
231:             .FontBold  = .T.
232:             .FontName  = "Trebuchet MS"
233:             .FontSize  = 10
234:             .Alignment = 2
235:             .Caption   = "Digite a Senha" + CHR(13) + "do Supervisor"
236:             .Height    = 30
237:             .Left      = 7
238:             .Top       = 16
239:             .Width     = 157
240:             .BackStyle = 0
241:             .ForeColor = RGB(90,90,90)
242:             .WordWrap  = .T.
243:         ENDWITH
244:     ENDPROC
245: 
246:     *--------------------------------------------------------------------------
247:     * AlternarPagina - Nao aplicavel (dialogo modal sem PageFrame)
248:     * SigTfSup legado nao tem navegacao Lista<->Dados.
249:     * Mantido para satisfazer contrato de forms OPERACIONAL do pipeline.
250:     *--------------------------------------------------------------------------
251:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
252:         THIS.this_cModoAtual = IIF(par_nPagina = 1, "LISTA", "DADOS")
253:     ENDPROC
254: 
255:     *--------------------------------------------------------------------------
256:     PROCEDURE Destroy()
257:     *--------------------------------------------------------------------------
258:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
259:             THIS.this_oBusinessObject = .NULL.
260:         ENDIF
261:         DODEFAULT()
262:     ENDPROC
263: 
264:     *--------------------------------------------------------------------------
265:     * ConfigurarControlesSenha - Cria controles da area de entrada de senha
266:     *--------------------------------------------------------------------------
267:     PROTECTED PROCEDURE ConfigurarControlesSenha()
268:         *-- Shape retangulo borda da area de senha (Shape1 do legado)
269:         THIS.AddObject("shp_4c_Shape1", "Shape")
270:         WITH THIS.shp_4c_Shape1
271:             .Top           = 90
272:             .Left          = 76
273:             .Height        = 42
274:             .Width         = 247
275:             .SpecialEffect = 0
276:         ENDWITH
277: 
278:         *-- Label "Senha do Supervisor :" (Label3 do legado)
279:         THIS.AddObject("lbl_4c_Label3", "Label")
280:         WITH THIS.lbl_4c_Label3
281:             .AutoSize  = .T.
282:             .FontName  = "Tahoma"
283:             .FontSize  = 8
284:             .Alignment = 0
285:             .Caption   = "Senha do Supervisor :"
286:             .Height    = 15
287:             .Left      = 87
288:             .Top       = 104
289:             .Width     = 108
290:             .BackStyle = 0
291:             .ForeColor = RGB(90,90,90)
292:         ENDWITH
293: 
294:         *-- TextBox GetSenha desabilitado (leitura de cartao - GetSenha do legado)
295:         THIS.AddObject("txt_4c_GetSenha", "TextBox")
296:         WITH THIS.txt_4c_GetSenha
297:             .FontName  = "Tahoma"
298:             .FontSize  = 8
299:             .Enabled   = .F.
300:             .Height    = 23
301:             .Left      = 214
302:             .Top       = 99
303:             .Width     = 100
304:             .ForeColor = RGB(0,0,0)
305:             .Value     = ""
306:         ENDWITH
307: 

*-- Linhas 323 a 502:
323:             .Value        = ""
324:         ENDWITH
325: 
326:         BINDEVENT(THIS.txt_4c_Senha, "KeyPress", THIS, "TxtSenhaKeyPress")
327:     ENDPROC
328: 
329:     *--------------------------------------------------------------------------
330:     * ConfigurarBotaoCancelar - Cria botao de cancelar (SAIDA do legado)
331:     *--------------------------------------------------------------------------
332:     PROTECTED PROCEDURE ConfigurarBotaoCancelar()
333:         THIS.AddObject("cmg_4c_Saida", "CommandGroup")
334:         WITH THIS.cmg_4c_Saida
335:             .BackStyle   = 0
336:             .BorderStyle = 0
337:             .Value       = 0
338:             .Height      = 85
339:             .Left        = 320
340:             .Top         = -2
341:             .Width       = 85
342:             .TabIndex    = 4
343:             WITH .Buttons(1)
344:                 .Top             = 5
345:                 .Left            = 5
346:                 .Height          = 75
347:                 .Width           = 75
348:                 .FontBold        = .T.
349:                 .FontItalic      = .F.
350:                 .Caption         = "\<Cancelar"
351:                 .ForeColor       = RGB(90,90,90)
352:                 .BackColor       = RGB(255,255,255)
353:                 .Themes          = .F.
354:                 .SpecialEffect   = 0
355:                 .PicturePosition = 13
356:                 .MousePointer    = 15
357:                 .WordWrap        = .T.
358:                 .Cancel          = .T.
359:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
360:             ENDWITH
361:         ENDWITH
362: 
363:         BINDEVENT(THIS.cmg_4c_Saida.Buttons(1), "Click", THIS, "BtnCancelarClick")
364:     ENDPROC
365: 
366:     *--------------------------------------------------------------------------
367:     * TxtSenhaKeyPress - Handler KeyPress do campo senha
368:     * Enter (13): confirma senha e oculta form
369:     *--------------------------------------------------------------------------
370:     PROCEDURE TxtSenhaKeyPress
371:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
372: 
373:         IF par_nKeyCode = 13
374:             THIS.this_cSenhaRetorno = THIS.txt_4c_Senha.Value
375:             THIS.this_lCancelado    = .F.
376:             THIS.Hide()
377:         ENDIF
378:     ENDPROC
379: 
380:     *--------------------------------------------------------------------------
381:     * BtnCancelarClick - Handler do botao Cancelar (tambem disparado por ESC)
382:     *--------------------------------------------------------------------------
383:     PROCEDURE BtnCancelarClick
384:         THIS.txt_4c_Senha.Value = ""
385:         THIS.this_cSenhaRetorno = ""
386:         THIS.this_lCancelado    = .T.
387:         THIS.Hide()
388:     ENDPROC
389: 
390:     *--------------------------------------------------------------------------
391:     * TornarControlesVisiveis - Torna todos os controles visiveis pos-AddObject
392:     *--------------------------------------------------------------------------
393:     PROTECTED PROCEDURE TornarControlesVisiveis()
394:         LOCAL loc_i, loc_oControl, loc_j, loc_oSub
395: 
396:         FOR loc_i = 1 TO THIS.ControlCount
397:             loc_oControl = THIS.Controls(loc_i)
398:             IF VARTYPE(loc_oControl) = "O"
399:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
400:                     loc_oControl.Visible = .T.
401:                 ENDIF
402:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
403:                     FOR loc_j = 1 TO loc_oControl.ControlCount
404:                         loc_oSub = loc_oControl.Controls(loc_j)
405:                         IF VARTYPE(loc_oSub) = "O" AND PEMSTATUS(loc_oSub, "Visible", 5)
406:                             loc_oSub.Visible = .T.
407:                         ENDIF
408:                     ENDFOR
409:                 ENDIF
410:             ENDIF
411:         ENDFOR
412:     ENDPROC
413: 
414:     *--------------------------------------------------------------------------
415:     * FormParaBO - Copia valores dos controles para o BO
416:     *--------------------------------------------------------------------------
417:     PROCEDURE FormParaBO()
418:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
419:             THIS.this_oBusinessObject.this_cSenha     = THIS.txt_4c_Senha.Value
420:             THIS.this_oBusinessObject.this_lCancelado = THIS.this_lCancelado
421:         ENDIF
422:     ENDPROC
423: 
424:     *--------------------------------------------------------------------------
425:     * BOParaForm - Copia valores do BO para os controles do form
426:     *--------------------------------------------------------------------------
427:     PROCEDURE BOParaForm()
428:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
429:             IF PEMSTATUS(THIS, "txt_4c_Senha", 5)
430:                 THIS.txt_4c_Senha.Value = THIS.this_oBusinessObject.this_cSenha
431:             ENDIF
432:         ENDIF
433:     ENDPROC
434: 
435:     *--------------------------------------------------------------------------
436:     * HabilitarCampos - Habilita ou desabilita campos editaveis
437:     *--------------------------------------------------------------------------
438:     PROCEDURE HabilitarCampos(par_lHabilitar)
439:         IF PEMSTATUS(THIS, "txt_4c_Senha", 5)
440:             THIS.txt_4c_Senha.Enabled = par_lHabilitar
441:         ENDIF
442:     ENDPROC
443: 
444:     *--------------------------------------------------------------------------
445:     * LimparCampos - Limpa todos os campos do dialogo
446:     *--------------------------------------------------------------------------
447:     PROCEDURE LimparCampos()
448:         IF PEMSTATUS(THIS, "txt_4c_Senha", 5)
449:             THIS.txt_4c_Senha.Value = ""
450:         ENDIF
451:         THIS.this_cSenhaRetorno = ""
452:         THIS.this_lCancelado    = .T.
453:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
454:             THIS.this_oBusinessObject.this_cSenha     = ""
455:             THIS.this_oBusinessObject.this_lCancelado = .F.
456:         ENDIF
457:     ENDPROC
458: 
459:     *--------------------------------------------------------------------------
460:     * CarregarLista - Nao aplicavel (dialogo modal sem lista/grid)
461:     *--------------------------------------------------------------------------
462:     PROCEDURE CarregarLista()
463:         RETURN .T.
464:     ENDPROC
465: 
466:     *--------------------------------------------------------------------------
467:     * AjustarBotoesPorModo - Nao aplicavel (dialogo sem modos CRUD)
468:     *--------------------------------------------------------------------------
469:     PROCEDURE AjustarBotoesPorModo()
470:         RETURN
471:     ENDPROC
472: 
473:     *--------------------------------------------------------------------------
474:     * BtnBuscarClick - Nao aplicavel (dialogo sem busca de registros)
475:     *--------------------------------------------------------------------------
476:     PROCEDURE BtnBuscarClick()
477:         RETURN
478:     ENDPROC
479: 
480:     *--------------------------------------------------------------------------
481:     * BtnEncerrarClick - Cancela o dialogo (equivalente a BtnCancelarClick)
482:     *--------------------------------------------------------------------------
483:     PROCEDURE BtnEncerrarClick()
484:         THIS.BtnCancelarClick()
485:     ENDPROC
486: 
487:     *--------------------------------------------------------------------------
488:     * BtnSalvarClick - Confirma a senha digitada
489:     * Equivalente ao SENHA.KeyPress Enter=13 do legado
490:     *--------------------------------------------------------------------------
491:     PROCEDURE BtnSalvarClick()
492:         IF EMPTY(ALLTRIM(THIS.txt_4c_Senha.Value))
493:             MsgAviso("A senha n" + CHR(227) + "o pode estar em branco.", "Senha de Risco")
494:             RETURN
495:         ENDIF
496:         THIS.FormParaBO()
497:         THIS.this_cSenhaRetorno = THIS.txt_4c_Senha.Value
498:         THIS.this_lCancelado    = .F.
499:         THIS.Hide()
500:     ENDPROC
501: 
502: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRSTFBO.prg):
*==============================================================================
* SIGPRSTFBO.prg - Business Object para dialogo Senha de Risco
* Herda de: BusinessBase
* Responsabilidade: Encapsular estado do dialogo de senha de supervisor
*==============================================================================

DEFINE CLASS SIGPRSTFBO AS BusinessBase

    *-- Senha digitada pelo usuario
    this_cSenha     = ""

    *-- Indica se o usuario cancelou (F. = confirmou, T. = cancelou)
    this_lCancelado = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - nao aplica (dialogo sem tabela SQL)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cSenha     = TratarNulo(cSenha, "C")
            THIS.this_lCancelado = .F.
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - verifica que a senha nao esta vazia
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cSenha))
            THIS.this_cMensagemErro = "A senha do supervisor n" + CHR(227) + "o pode estar em branco."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - nao aplica (dialogo sem tabela SQL); retorna .T. por interface
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        IF !THIS.ValidarDados()
            RETURN .F.
        ENDIF
        THIS.RegistrarAuditoria("SENHA_RISCO")
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - nao aplica (dialogo sem tabela SQL); retorna .T. por interface
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        IF !THIS.ValidarDados()
            RETURN .F.
        ENDIF
        THIS.RegistrarAuditoria("SENHA_RISCO_ALT")
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - registra acesso ao dialogo de senha de risco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .T.

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, Usuario, DataHora) VALUES (" + ;
                       EscaparSQL("SIGPRSTF") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)

        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
            loc_lSucesso = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

