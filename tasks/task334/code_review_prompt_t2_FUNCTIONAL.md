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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRSTF.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (504 linhas total):

*-- Linhas 5 a 147:
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
63:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
64:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
65: 
66:                 *-- Criar controles de entrada de senha
67:                 THIS.ConfigurarControlesSenha()
68: 
69:                 *-- Criar area de instrucao ao usuario
70:                 THIS.ConfigurarPaginaDados()
71: 
72:                 *-- Criar botao de cancelar
73:                 THIS.ConfigurarBotaoCancelar()
74: 
75:                 *-- Tornar todos os controles visiveis pos-AddObject
76:                 THIS.TornarControlesVisiveis()
77: 
78:                 loc_lSucesso = .T.
79:             ELSE
80:                 MsgErro("Erro ao criar SIGPRSTFBO", "Erro ao Inicializar")
81:             ENDIF
82: 
83:         CATCH TO loc_oErro
84:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
85:                     " PROC=" + loc_oErro.Procedure, ;
86:                     "Erro ao inicializar FormSIGPRSTF")
87:             loc_lSucesso = .F.
88:         ENDTRY
89: 
90:         RETURN loc_lSucesso
91:     ENDPROC
92: 
93:     *--------------------------------------------------------------------------
94:     * ConfigurarPageFrame - Configura aparencia base do form (sem PageFrame)
95:     * Dialogo simples: fundo cinza padrao Windows, sem barra de rolagem
96:     *--------------------------------------------------------------------------
97:     PROTECTED PROCEDURE ConfigurarPageFrame()
98:         THIS.BackColor  = RGB(212, 208, 200)
99:         THIS.ScrollBars = 0
100:         THIS.ShowTips   = .F.
101:     ENDPROC
102: 
103:     *--------------------------------------------------------------------------
104:     * ConfigurarCabecalho - Cria container de cabecalho cinza (cntSombra)
105:     * Original: cntSombra Top=0, Left=0, Width=800, Height=80
106:     *--------------------------------------------------------------------------
107:     PROTECTED PROCEDURE ConfigurarCabecalho()
108:         *-- Container cinza do cabecalho
109:         THIS.AddObject("cnt_4c_Sombra", "Container")
110:         WITH THIS.cnt_4c_Sombra
111:             .Top         = 0
112:             .Left        = 0
113:             .Width       = THIS.Width
114:             .Height      = 80
115:             .BorderWidth = 0
116:             .BackStyle   = 1
117:             .BackColor   = RGB(100,100,100)
118:             .Visible     = .T.
119:         ENDWITH
120: 
121:         *-- Label sombra (deslocado 1px para efeito de profundidade - preto)
122:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
123:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
124:             .AutoSize   = .F.
125:             .FontBold   = .T.
126:             .FontName   = "Tahoma"
127:             .FontSize   = 18
128:             .WordWrap   = .T.
129:             .Alignment  = 0
130:             .BackStyle  = 0
131:             .Caption    = "Senha de Risco"
132:             .Height     = 40
133:             .Left       = 10
134:             .Top        = 18
135:             .Width      = THIS.Width
136:             .ForeColor  = RGB(0,0,0)
137:             .Visible    = .T.
138:         ENDWITH
139: 
140:         *-- Label titulo principal (branco sobre cinza)
141:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
142:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
143:             .AutoSize   = .F.
144:             .FontBold   = .T.
145:             .FontName   = "Tahoma"
146:             .FontSize   = 18
147:             .WordWrap   = .T.

*-- Linhas 162 a 309:
162:     *--------------------------------------------------------------------------
163:     * AtualizarEstadoControles - override seguro (dialogo sem botoes CRUD)
164:     *--------------------------------------------------------------------------
165:     PROCEDURE AtualizarEstadoControles()
166:         RETURN
167:     ENDPROC
168: 
169:     *--------------------------------------------------------------------------
170:     * Handlers CRUD - Nao aplicavel a este form
171:     * ------------------------------------------------------------------------
172:     * SigTfSup (legado) eh dialogo modal de senha de supervisor: nao tem
173:     * grid de registros, nao tem Page Lista/Dados, nao expoe botoes Incluir/
174:     * Alterar/Visualizar/Excluir. O usuario digita senha + Enter (confirma) ou
175:     * clica Cancelar. Os handlers abaixo existem para satisfazer o contrato
176:     * do pipeline OPERACIONAL - caso o form seja acidentalmente chamado como
177:     * CRUD por menu.prg, os cliques nao geram erro em runtime.
178:     *--------------------------------------------------------------------------
179:     PROCEDURE BtnIncluirClick()
180:         MsgAviso("Esta janela n" + CHR(227) + "o suporta inclus" + CHR(227) + "o de registros.", ;
181:                  "Senha de Risco")
182:     ENDPROC
183: 
184:     PROCEDURE BtnAlterarClick()
185:         MsgAviso("Esta janela n" + CHR(227) + "o suporta altera" + CHR(231) + CHR(227) + "o de registros.", ;
186:                  "Senha de Risco")
187:     ENDPROC
188: 
189:     PROCEDURE BtnVisualizarClick()
190:         MsgAviso("Esta janela n" + CHR(227) + "o suporta visualiza" + CHR(231) + CHR(227) + "o de registros.", ;
191:                  "Senha de Risco")
192:     ENDPROC
193: 
194:     PROCEDURE BtnExcluirClick()
195:         MsgAviso("Esta janela n" + CHR(227) + "o suporta exclus" + CHR(227) + "o de registros.", ;
196:                  "Senha de Risco")
197:     ENDPROC
198: 
199:     *--------------------------------------------------------------------------
200:     * ConfigurarPaginaLista - Nao aplicavel (dialogo modal sem PageFrame)
201:     * SigTfSup legado eh dialogo simples de senha de supervisor sem lista/grid.
202:     * Mantido para satisfazer contrato de forms OPERACIONAL do pipeline.
203:     * O layout completo eh criado por ConfigurarCabecalho/ConfigurarControlesSenha/
204:     * ConfigurarBotaoCancelar - nao ha PageFrame.Page1 (Lista) a configurar.
205:     *--------------------------------------------------------------------------
206:     PROTECTED PROCEDURE ConfigurarPaginaLista()
207:         THIS.this_cModoAtual = "LISTA"
208:     ENDPROC
209: 
210:     *--------------------------------------------------------------------------
211:     * ConfigurarPaginaDados - Area de instrucao ao usuario (Container1 do legado)
212:     * Container1 exibe orientacao dinamica definida em Init() original:
213:     *   ThisForm.Container1.Label1.Caption = "Digite a Senha" + CHR(13) + "do Supervisor"
214:     *--------------------------------------------------------------------------
215:     PROTECTED PROCEDURE ConfigurarPaginaDados()
216:         *-- Container instrucao ao usuario (Container1 do legado)
217:         THIS.AddObject("cnt_4c_Container1", "Container")
218:         WITH THIS.cnt_4c_Container1
219:             .Top           = 137
220:             .Left          = 114
221:             .Width         = 171
222:             .Height        = 56
223:             .SpecialEffect = 0
224:             .BackStyle     = 1
225:             .BackColor     = RGB(212,208,200)
226:             .BorderWidth   = 0
227:             .Visible     = .T.
228:         ENDWITH
229: 
230:         THIS.cnt_4c_Container1.AddObject("lbl_4c_Label1", "Label")
231:         WITH THIS.cnt_4c_Container1.lbl_4c_Label1
232:             .AutoSize  = .F.
233:             .FontBold  = .T.
234:             .FontName  = "Trebuchet MS"
235:             .FontSize  = 10
236:             .Alignment = 2
237:             .Caption   = "Digite a Senha" + CHR(13) + "do Supervisor"
238:             .Height    = 30
239:             .Left      = 7
240:             .Top       = 16
241:             .Width     = 157
242:             .BackStyle = 0
243:             .ForeColor = RGB(90,90,90)
244:             .WordWrap  = .T.
245:         ENDWITH
246:     ENDPROC
247: 
248:     *--------------------------------------------------------------------------
249:     * AlternarPagina - Nao aplicavel (dialogo modal sem PageFrame)
250:     * SigTfSup legado nao tem navegacao Lista<->Dados.
251:     * Mantido para satisfazer contrato de forms OPERACIONAL do pipeline.
252:     *--------------------------------------------------------------------------
253:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
254:         THIS.this_cModoAtual = IIF(par_nPagina = 1, "LISTA", "DADOS")
255:     ENDPROC
256: 
257:     *--------------------------------------------------------------------------
258:     PROCEDURE Destroy()
259:     *--------------------------------------------------------------------------
260:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
261:             THIS.this_oBusinessObject = .NULL.
262:         ENDIF
263:         DODEFAULT()
264:     ENDPROC
265: 
266:     *--------------------------------------------------------------------------
267:     * ConfigurarControlesSenha - Cria controles da area de entrada de senha
268:     *--------------------------------------------------------------------------
269:     PROTECTED PROCEDURE ConfigurarControlesSenha()
270:         *-- Shape retangulo borda da area de senha (Shape1 do legado)
271:         THIS.AddObject("shp_4c_Shape1", "Shape")
272:         WITH THIS.shp_4c_Shape1
273:             .Top           = 90
274:             .Left          = 76
275:             .Height        = 42
276:             .Width         = 247
277:             .SpecialEffect = 0
278:         ENDWITH
279: 
280:         *-- Label "Senha do Supervisor :" (Label3 do legado)
281:         THIS.AddObject("lbl_4c_Label3", "Label")
282:         WITH THIS.lbl_4c_Label3
283:             .AutoSize  = .T.
284:             .FontName  = "Tahoma"
285:             .FontSize  = 8
286:             .Alignment = 0
287:             .Caption   = "Senha do Supervisor :"
288:             .Height    = 15
289:             .Left      = 87
290:             .Top       = 104
291:             .Width     = 108
292:             .BackStyle = 0
293:             .ForeColor = RGB(90,90,90)
294:         ENDWITH
295: 
296:         *-- TextBox GetSenha desabilitado (leitura de cartao - GetSenha do legado)
297:         THIS.AddObject("txt_4c_GetSenha", "TextBox")
298:         WITH THIS.txt_4c_GetSenha
299:             .FontName  = "Tahoma"
300:             .FontSize  = 8
301:             .Enabled   = .F.
302:             .Height    = 23
303:             .Left      = 214
304:             .Top       = 99
305:             .Width     = 100
306:             .ForeColor = RGB(0,0,0)
307:             .Value     = ""
308:         ENDWITH
309: 

*-- Linhas 325 a 504:
325:             .Value        = ""
326:         ENDWITH
327: 
328:         BINDEVENT(THIS.txt_4c_Senha, "KeyPress", THIS, "TxtSenhaKeyPress")
329:     ENDPROC
330: 
331:     *--------------------------------------------------------------------------
332:     * ConfigurarBotaoCancelar - Cria botao de cancelar (SAIDA do legado)
333:     *--------------------------------------------------------------------------
334:     PROTECTED PROCEDURE ConfigurarBotaoCancelar()
335:         THIS.AddObject("cmg_4c_Saida", "CommandGroup")
336:         WITH THIS.cmg_4c_Saida
337:             .BackStyle   = 0
338:             .BorderStyle = 0
339:             .Value       = 0
340:             .Height      = 85
341:             .Left        = 320
342:             .Top         = -2
343:             .Width       = 85
344:             .TabIndex    = 4
345:             WITH .Buttons(1)
346:                 .Top             = 5
347:                 .Left            = 5
348:                 .Height          = 75
349:                 .Width           = 75
350:                 .FontBold        = .T.
351:                 .FontItalic      = .F.
352:                 .Caption         = "\<Cancelar"
353:                 .ForeColor       = RGB(90,90,90)
354:                 .BackColor       = RGB(255,255,255)
355:                 .Themes          = .F.
356:                 .SpecialEffect   = 0
357:                 .PicturePosition = 13
358:                 .MousePointer    = 15
359:                 .WordWrap        = .T.
360:                 .Cancel          = .T.
361:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
362:             ENDWITH
363:         ENDWITH
364: 
365:         BINDEVENT(THIS.cmg_4c_Saida.Buttons(1), "Click", THIS, "BtnCancelarClick")
366:     ENDPROC
367: 
368:     *--------------------------------------------------------------------------
369:     * TxtSenhaKeyPress - Handler KeyPress do campo senha
370:     * Enter (13): confirma senha e oculta form
371:     *--------------------------------------------------------------------------
372:     PROCEDURE TxtSenhaKeyPress
373:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
374: 
375:         IF par_nKeyCode = 13
376:             THIS.this_cSenhaRetorno = THIS.txt_4c_Senha.Value
377:             THIS.this_lCancelado    = .F.
378:             THIS.Hide()
379:         ENDIF
380:     ENDPROC
381: 
382:     *--------------------------------------------------------------------------
383:     * BtnCancelarClick - Handler do botao Cancelar (tambem disparado por ESC)
384:     *--------------------------------------------------------------------------
385:     PROCEDURE BtnCancelarClick
386:         THIS.txt_4c_Senha.Value = ""
387:         THIS.this_cSenhaRetorno = ""
388:         THIS.this_lCancelado    = .T.
389:         THIS.Hide()
390:     ENDPROC
391: 
392:     *--------------------------------------------------------------------------
393:     * TornarControlesVisiveis - Torna todos os controles visiveis pos-AddObject
394:     *--------------------------------------------------------------------------
395:     PROTECTED PROCEDURE TornarControlesVisiveis()
396:         LOCAL loc_i, loc_oControl, loc_j, loc_oSub
397: 
398:         FOR loc_i = 1 TO THIS.ControlCount
399:             loc_oControl = THIS.Controls(loc_i)
400:             IF VARTYPE(loc_oControl) = "O"
401:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
402:                     loc_oControl.Visible = .T.
403:                 ENDIF
404:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
405:                     FOR loc_j = 1 TO loc_oControl.ControlCount
406:                         loc_oSub = loc_oControl.Controls(loc_j)
407:                         IF VARTYPE(loc_oSub) = "O" AND PEMSTATUS(loc_oSub, "Visible", 5)
408:                             loc_oSub.Visible = .T.
409:                         ENDIF
410:                     ENDFOR
411:                 ENDIF
412:             ENDIF
413:         ENDFOR
414:     ENDPROC
415: 
416:     *--------------------------------------------------------------------------
417:     * FormParaBO - Copia valores dos controles para o BO
418:     *--------------------------------------------------------------------------
419:     PROCEDURE FormParaBO()
420:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
421:             THIS.this_oBusinessObject.this_cSenha     = THIS.txt_4c_Senha.Value
422:             THIS.this_oBusinessObject.this_lCancelado = THIS.this_lCancelado
423:         ENDIF
424:     ENDPROC
425: 
426:     *--------------------------------------------------------------------------
427:     * BOParaForm - Copia valores do BO para os controles do form
428:     *--------------------------------------------------------------------------
429:     PROCEDURE BOParaForm()
430:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
431:             IF PEMSTATUS(THIS, "txt_4c_Senha", 5)
432:                 THIS.txt_4c_Senha.Value = THIS.this_oBusinessObject.this_cSenha
433:             ENDIF
434:         ENDIF
435:     ENDPROC
436: 
437:     *--------------------------------------------------------------------------
438:     * HabilitarCampos - Habilita ou desabilita campos editaveis
439:     *--------------------------------------------------------------------------
440:     PROCEDURE HabilitarCampos(par_lHabilitar)
441:         IF PEMSTATUS(THIS, "txt_4c_Senha", 5)
442:             THIS.txt_4c_Senha.Enabled = par_lHabilitar
443:         ENDIF
444:     ENDPROC
445: 
446:     *--------------------------------------------------------------------------
447:     * LimparCampos - Limpa todos os campos do dialogo
448:     *--------------------------------------------------------------------------
449:     PROCEDURE LimparCampos()
450:         IF PEMSTATUS(THIS, "txt_4c_Senha", 5)
451:             THIS.txt_4c_Senha.Value = ""
452:         ENDIF
453:         THIS.this_cSenhaRetorno = ""
454:         THIS.this_lCancelado    = .T.
455:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
456:             THIS.this_oBusinessObject.this_cSenha     = ""
457:             THIS.this_oBusinessObject.this_lCancelado = .F.
458:         ENDIF
459:     ENDPROC
460: 
461:     *--------------------------------------------------------------------------
462:     * CarregarLista - Nao aplicavel (dialogo modal sem lista/grid)
463:     *--------------------------------------------------------------------------
464:     PROCEDURE CarregarLista()
465:         RETURN .T.
466:     ENDPROC
467: 
468:     *--------------------------------------------------------------------------
469:     * AjustarBotoesPorModo - Nao aplicavel (dialogo sem modos CRUD)
470:     *--------------------------------------------------------------------------
471:     PROCEDURE AjustarBotoesPorModo()
472:         RETURN
473:     ENDPROC
474: 
475:     *--------------------------------------------------------------------------
476:     * BtnBuscarClick - Nao aplicavel (dialogo sem busca de registros)
477:     *--------------------------------------------------------------------------
478:     PROCEDURE BtnBuscarClick()
479:         RETURN
480:     ENDPROC
481: 
482:     *--------------------------------------------------------------------------
483:     * BtnEncerrarClick - Cancela o dialogo (equivalente a BtnCancelarClick)
484:     *--------------------------------------------------------------------------
485:     PROCEDURE BtnEncerrarClick()
486:         THIS.BtnCancelarClick()
487:     ENDPROC
488: 
489:     *--------------------------------------------------------------------------
490:     * BtnSalvarClick - Confirma a senha digitada
491:     * Equivalente ao SENHA.KeyPress Enter=13 do legado
492:     *--------------------------------------------------------------------------
493:     PROCEDURE BtnSalvarClick()
494:         IF EMPTY(ALLTRIM(THIS.txt_4c_Senha.Value))
495:             MsgAviso("A senha n" + CHR(227) + "o pode estar em branco.", "Senha de Risco")
496:             RETURN
497:         ENDIF
498:         THIS.FormParaBO()
499:         THIS.this_cSenhaRetorno = THIS.txt_4c_Senha.Value
500:         THIS.this_lCancelado    = .F.
501:         THIS.Hide()
502:     ENDPROC
503: 
504: ENDDEFINE


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

