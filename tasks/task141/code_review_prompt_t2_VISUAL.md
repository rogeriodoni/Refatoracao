# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [LAYOUT-POSITION] Controle 'Aguarde' (parent: SIGPDMFA): Top original=115 vs migrado 'cnt_4c_Aguarde' Top=8 (diff=107px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Aguarde' (parent: SIGPDMFA): Left original=296 vs migrado 'cnt_4c_Aguarde' Left=68 (diff=228px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMfa.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1348 linhas total):

*-- Linhas 32 a 64:
32:     ADD OBJECT cnt_4c_Sombra AS Container WITH ;
33:         Top = 0, Left = 0, Width = 800, Height = 80, ;
34:         BorderWidth = 0, BackStyle = 1, BackColor = RGB(100, 100, 100)
35: 
36:     *-- Container de espera durante processamento (Visible=.F. ate Processa.Click)
37:     ADD OBJECT cnt_4c_Aguarde AS Container WITH ;
38:         Top = 115, Left = 296, Width = 207, Height = 49, ;
39:         SpecialEffect = 0, BackStyle = 1, BackColor = RGB(255, 255, 255), ;
40:         Visible = .F.
41: 
42:     *==========================================================================
43:     * Init - Inicializa via FormBase (que chama InicializarForm)
44:     *==========================================================================
45:     PROCEDURE Init()
46:         RETURN DODEFAULT()
47:     ENDPROC
48: 
49:     *==========================================================================
50:     * InicializarForm - Cria BO, configura form e carrega dados iniciais
51:     * Chamado automaticamente por FormBase.Init()
52:     *==========================================================================
53:     PROTECTED PROCEDURE InicializarForm()
54:         LOCAL loc_lSucesso, loc_oErro
55:         loc_lSucesso = .F.
56: 
57:         TRY
58:             *-- Configura propriedades visuais do form (sem literais acentuados)
59:             THIS.Caption = "Mudan" + CHR(231) + CHR(227) + "a de Fase Autom" + CHR(225) + "tica"
60:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
61: 
62:             *-- Instancia o Business Object
63:             THIS.this_oBusinessObject = CREATEOBJECT("SigPdMfaBO")
64:             IF VARTYPE(THIS.this_oBusinessObject) != "O"

*-- Linhas 93 a 138:
93:                     MsgErro("Falha ao carregar contas", "Erro")
94:                     loc_lSucesso = .F.
95:                 ENDIF
96:             ENDIF
97: 
98:             *-- Torna controles visiveis (exceto cnt_4c_Aguarde que e flutuante)
99:             THIS.TornarControlesVisiveis(THIS)
100: 
101:             *-- Vincula eventos e atualiza estado inicial dos campos
102:             THIS.ConfigurarBINDEVENTs()
103:             THIS.AtualizarEstadoCampos()
104: 
105:             loc_lSucesso = .T.
106:         CATCH TO loc_oErro
107:             MsgErro(loc_oErro.Message, "Erro ao inicializar FormSigPdMfa")
108:         ENDTRY
109: 
110:         RETURN loc_lSucesso
111:     ENDPROC
112: 
113:     *==========================================================================
114:     * ConfigurarPageFrame - Form OPERACIONAL: layout plano, sem PageFrame
115:     * Original SIGPDMFA herda de `form` generico (NAO frmcadastro) e usa
116:     * Width=800, Height=279, TitleBar=0 com todos os controles ancorados
117:     * diretamente no form. Mantemos este metodo para conformidade com a
118:     * pipeline de migracao e como ponto de extensao caso futuras versoes
119:     * adicionem abas.
120:     *==========================================================================
121:     PROTECTED PROCEDURE ConfigurarPageFrame()
122:         *-- Form operacional plano: o background e as dimensoes ja foram
123:         *-- definidos via propriedades da classe. cnt_4c_Sombra e cnt_4c_Aguarde
124:         *-- foram declarados via ADD OBJECT e nao precisam de container parent.
125:         THIS.AutoCenter = .T.
126:     ENDPROC
127: 
128:     *==========================================================================
129:     * ConfigurarPaginaLista - Form OPERACIONAL nao tem Page1/Lista.
130:     * SIGPDMFA original (Width=800, Height=279) usa layout plano: todos os
131:     * controles ficam direto no form, sem grid de registros e sem botoes CRUD
132:     * (Incluir/Alterar/Excluir/Buscar). O fluxo unico eh: usuario informa
133:     * Linha+OP+Grupo+Conta, clica Processar, BO chama ProcessarMudancaFase
134:     * e gera movimentacao em SigPdMvf/SigCdNec.
135:     *
136:     * Este metodo eh chamado pela pipeline de migracao por compatibilidade.
137:     * Garante (idempotentemente) que os campos e botoes do form plano foram
138:     * configurados, mesmo se invocado depois de InicializarForm.

*-- Linhas 145 a 153:
145:             THIS.ConfigurarCampos()
146:         ENDIF
147: 
148:         IF !PEMSTATUS(THIS, "cmd_4c_Processa", 5)
149:             THIS.ConfigurarBotoes()
150:         ENDIF
151: 
152:         *-- Em forms OPERACIONAIS, AtualizarEstadoCampos substitui a logica
153:         *-- de modo (INCLUIR/ALTERAR/VISUALIZAR) dos forms CRUD: apenas

*-- Linhas 199 a 208:
199:                 ENDIF
200:             CASE loc_nPagina = 2
201:                 *-- "Ir para dados" = posicionar foco no botao processar
202:                 IF PEMSTATUS(THIS, "cmd_4c_Processa", 5) AND THIS.cmd_4c_Processa.Visible
203:                     THIS.cmd_4c_Processa.SetFocus()
204:                 ENDIF
205:         ENDCASE
206: 
207:         THIS.Refresh()
208:     ENDPROC

*-- Linhas 214 a 318:
214:     *==========================================================================
215:     PROTECTED PROCEDURE ConfigurarHeader()
216:         WITH THIS.cnt_4c_Sombra
217:             .AddObject("lbl_4c_LblSombra", "Label")
218:             WITH .lbl_4c_LblSombra
219:                 .FontBold      = .T.
220:                 .FontName      = "Tahoma"
221:                 .FontSize      = 18
222:                 .FontUnderline = .F.
223:                 .WordWrap      = .T.
224:                 .Alignment     = 0
225:                 .BackStyle     = 0
226:                 .Caption       = "Mudan" + CHR(231) + CHR(227) + "a de Fase Autom" + CHR(225) + "tica"
227:                 .Height        = 40
228:                 .Left          = 10
229:                 .Top           = 18
230:                 .Width         = 769
231:                 .ForeColor     = RGB(0, 0, 0)
232:             ENDWITH
233: 
234:             .AddObject("lbl_4c_LblTitulo", "Label")
235:             WITH .lbl_4c_LblTitulo
236:                 .FontBold      = .T.
237:                 .FontName      = "Tahoma"
238:                 .FontSize      = 18
239:                 .WordWrap      = .T.
240:                 .Alignment     = 0
241:                 .BackStyle     = 0
242:                 .Caption       = "Mudan" + CHR(231) + CHR(227) + "a de Fase Autom" + CHR(225) + "tica"
243:                 .Height        = 46
244:                 .Left          = 10
245:                 .Top           = 17
246:                 .Width         = 769
247:                 .ForeColor     = RGB(255, 255, 255)
248:             ENDWITH
249:         ENDWITH
250:     ENDPROC
251: 
252:     *==========================================================================
253:     * ConfigurarAguarde - Adiciona labels ao container de espera
254:     * Exibido durante processamento (Aguarde.Visible = .T. em BtnProcessaClick)
255:     *==========================================================================
256:     PROTECTED PROCEDURE ConfigurarAguarde()
257:         WITH THIS.cnt_4c_Aguarde
258:             .Top  = 115
259:             .Left = 296
260:             .AddObject("lbl_4c_Label1", "Label")
261:             WITH .lbl_4c_Label1
262:                 .AutoSize  = .T.
263:                 .FontBold  = .T.
264:                 .FontName  = "Tahoma"
265:                 .FontSize  = 10
266:                 .BackStyle = 0
267:                 .Caption   = "Aguarde..."
268:                 .Height    = 18
269:                 .Left      = 68
270:                 .Top       = 8
271:                 .Width     = 70
272:                 .ForeColor = RGB(255, 0, 0)
273:             ENDWITH
274: 
275:             .AddObject("lbl_4c_Label2", "Label")
276:             WITH .lbl_4c_Label2
277:                 .AutoSize  = .T.
278:                 .FontBold  = .T.
279:                 .FontName  = "Tahoma"
280:                 .FontSize  = 10
281:                 .BackStyle = 0
282:                 .Caption   = "Processando"
283:                 .Height    = 18
284:                 .Left      = 61
285:                 .Top       = 26
286:                 .Width     = 85
287:                 .ForeColor = RGB(90, 90, 90)
288:             ENDWITH
289:         ENDWITH
290:     ENDPROC
291: 
292:     *==========================================================================
293:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
294:     * FILTRA: cnt_4c_Aguarde permanece Visible=.F. (toggle por BtnProcessaClick)
295:     *==========================================================================
296:     PROCEDURE TornarControlesVisiveis(par_oContainer)
297:         LOCAL loc_nI, loc_oObjeto, loc_nP
298: 
299:         FOR loc_nI = 1 TO par_oContainer.ControlCount
300:             loc_oObjeto = par_oContainer.Controls(loc_nI)
301: 
302:             IF VARTYPE(loc_oObjeto) = "O"
303:                 IF UPPER(ALLTRIM(loc_oObjeto.Name)) = "CNT_4C_AGUARDE"
304:                     LOOP
305:                 ENDIF
306: 
307:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
308:                     loc_oObjeto.Visible = .T.
309:                 ENDIF
310: 
311:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
312:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
313:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
314:                     ENDFOR
315:                 ENDIF
316: 
317:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
318:                    loc_oObjeto.ControlCount > 0

*-- Linhas 329 a 378:
329:     *==========================================================================
330:     PROTECTED PROCEDURE ConfigurarCampos()
331:         *-- Label "Linha : " (Say2 original: top=130, left=151)
332:         THIS.AddObject("lbl_4c_LblLinha", "Label")
333:         WITH THIS.lbl_4c_LblLinha
334:             .AutoSize  = .T.
335:             .FontName  = "Tahoma"
336:             .FontSize  = 8
337:             .BackStyle = 0
338:             .Caption   = "Linha : "
339:             .Height    = 15
340:             .Left      = 151
341:             .Top       = 130
342:             .Width     = 37
343:             .ForeColor = RGB(90, 90, 90)
344:             .Visible   = .T.
345:         ENDWITH
346: 
347:         *-- Label "O.P. :" (lbl_operacao original: top=153, left=157)
348:         THIS.AddObject("lbl_4c_Lbl_operacao", "Label")
349:         WITH THIS.lbl_4c_Lbl_operacao
350:             .AutoSize  = .T.
351:             .FontName  = "Tahoma"
352:             .FontSize  = 8
353:             .BackStyle = 0
354:             .Caption   = "O.P. :"
355:             .Height    = 15
356:             .Left      = 157
357:             .Top       = 153
358:             .Width     = 31
359:             .ForeColor = RGB(90, 90, 90)
360:             .Visible   = .T.
361:         ENDWITH
362: 
363:         *-- Label "Grupo/Conta : " (Say3 original: top=177, left=114)
364:         THIS.AddObject("lbl_4c_Label3", "Label")
365:         WITH THIS.lbl_4c_Label3
366:             .AutoSize  = .T.
367:             .FontName  = "Tahoma"
368:             .FontSize  = 8
369:             .BackStyle = 0
370:             .Caption   = "Grupo/Conta : "
371:             .Height    = 15
372:             .Left      = 114
373:             .Top       = 177
374:             .Width     = 74
375:             .ForeColor = RGB(90, 90, 90)
376:             .Visible   = .T.
377:         ENDWITH
378: 

*-- Linhas 390 a 417:
390:             .Value         = ""
391:             .Format        = "K"
392:             .Height        = 25
393:             .Left          = 194
394:             .MaxLength     = 10
395:             .SpecialEffect = 1
396:             .Top           = 125
397:             .Width         = 80
398:             .ForeColor     = RGB(0, 0, 0)
399:             .Visible       = .T.
400:         ENDWITH
401: 
402:         *-- TextBox descricao da Linha (Get_DLinha: top=125, left=275, w=273)
403:         *-- Habilitado apenas quando txt_4c_Linha estiver vazio (When legado)
404:         THIS.AddObject("txt_4c_DLinha", "TextBox")
405:         WITH THIS.txt_4c_DLinha
406:             .FontName      = "Courier New"
407:             .Format        = "K"
408:             .Height        = 25
409:             .Left          = 275
410:             .MaxLength     = 40
411:             .SpecialEffect = 1
412:             .Top           = 125
413:             .Width         = 273
414:             .Value         = ""
415:             .Visible       = .T.
416:         ENDWITH
417: 

*-- Linhas 423 a 474:
423:             .Format        = "K"
424:             .Height        = 23
425:             .InputMask     = "999999"
426:             .Left          = 194
427:             .MaxLength     = 6
428:             .SpecialEffect = 1
429:             .Top           = 151
430:             .Width         = 52
431:             .Visible       = .T.
432:         ENDWITH
433: 
434:         *-- TextBox Grupo contabil (Get_grupo: top=175, left=194, w=80)
435:         THIS.AddObject("txt_4c_Grupo", "TextBox")
436:         WITH THIS.txt_4c_Grupo
437:             .Value         = ""
438:             .SpecialEffect = 1
439:             .Height        = 23
440:             .Left          = 194
441:             .MaxLength     = 20
442:             .Top           = 175
443:             .Width         = 80
444:             .Visible       = .T.
445:         ENDWITH
446: 
447:         *-- TextBox codigo da Conta (Get_conta: top=175, left=275, w=80)
448:         THIS.AddObject("txt_4c_Conta", "TextBox")
449:         WITH THIS.txt_4c_Conta
450:             .Value         = ""
451:             .SpecialEffect = 1
452:             .Height        = 23
453:             .Left          = 275
454:             .MaxLength     = 20
455:             .Top           = 175
456:             .Width         = 80
457:             .Visible       = .T.
458:         ENDWITH
459: 
460:         *-- TextBox descricao da Conta (Get_dconta: top=175, left=357, w=297)
461:         *-- Habilitado apenas quando txt_4c_Conta estiver vazio (When legado)
462:         THIS.AddObject("txt_4c_Dconta", "TextBox")
463:         WITH THIS.txt_4c_Dconta
464:             .Value         = ""
465:             .SpecialEffect = 1
466:             .Height        = 23
467:             .Left          = 357
468:             .MaxLength     = 60
469:             .Top           = 175
470:             .Width         = 297
471:             .Visible       = .T.
472:         ENDWITH
473:     ENDPROC
474: 

*-- Linhas 481 a 507:
481:         *-- Shape decorativo (Shape1 original: top=7, left=699, w=90, h=19)
482:         THIS.AddObject("shp_4c_Shape1", "Shape")
483:         WITH THIS.shp_4c_Shape1
484:             .Top         = 7
485:             .Left        = 699
486:             .Height      = 19
487:             .Width       = 90
488:             .BackStyle   = 0
489:             .BorderStyle = 0
490:             .BorderColor = RGB(136, 189, 188)
491:             .Visible     = .T.
492:         ENDWITH
493: 
494:         *-- Botao Processar (Processa original: top=3, left=648)
495:         THIS.AddObject("cmd_4c_Processa", "CommandButton")
496:         WITH THIS.cmd_4c_Processa
497:             .Top      = 3
498:             .Left     = 648
499:             .Height   = 75
500:             .Width    = 75
501:             .Picture  = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
502:             .Caption  = "\<Processar"
503:             .FontName = "Tahoma"
504:             .FontBold = .T.
505:             .FontItalic = .T.
506:             .FontSize = 8
507:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 515 a 531:
515:         ENDWITH
516: 
517:         *-- Botao Encerrar (Cancela original: top=3, left=723, Cancel=.T.)
518:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
519:         WITH THIS.cmd_4c_Cancela
520:             .Top      = 3
521:             .Left     = 723
522:             .Height   = 75
523:             .Width    = 75
524:             .Picture  = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
525:             .Cancel   = .T.
526:             .Caption  = "Encerra"
527:             .FontName = "Tahoma"
528:             .FontBold = .T.
529:             .FontItalic = .T.
530:             .FontSize = 8
531:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 553 a 562:
553:         BINDEVENT(THIS.txt_4c_Conta,  "DblClick", THIS, "TxtContaDblClick")
554:         BINDEVENT(THIS.txt_4c_Dconta, "KeyPress", THIS, "TxtDContaKeyPress")
555:         BINDEVENT(THIS.txt_4c_Dconta, "DblClick", THIS, "TxtDContaDblClick")
556:         BINDEVENT(THIS.cmd_4c_Processa, "Click", THIS, "BtnProcessaClick")
557:         BINDEVENT(THIS.cmd_4c_Cancela,  "Click", THIS, "BtnCancelaClick")
558:     ENDPROC
559: 
560:     *==========================================================================
561:     * AtualizarEstadoCampos - Atualiza Enabled de DLinha e Dconta
562:     * DLinha habilitado apenas quando Linha vazio (When legado)

*-- Linhas 1045 a 1054:
1045:         THIS.txt_4c_Dconta.Refresh()
1046:         THIS.AtualizarEstadoCampos()
1047: 
1048:         IF PEMSTATUS(THIS, "cmd_4c_Processa", 5) AND THIS.cmd_4c_Processa.Enabled
1049:             THIS.cmd_4c_Processa.SetFocus()
1050:         ENDIF
1051:     ENDPROC
1052: 
1053:     *==========================================================================
1054:     * BtnExcluirClick - Form OPERACIONAL: nao ha exclusao de registros.

*-- Linhas 1135 a 1167:
1135:             THIS.txt_4c_Conta.SetFocus()
1136:             RETURN
1137:         ENDIF
1138: 
1139:         *-- Exibe Aguarde e processa
1140:         THIS.cnt_4c_Aguarde.ZOrder(0)
1141:         THIS.cnt_4c_Aguarde.Visible = .T.
1142:         THIS.Refresh()
1143: 
1144:         loc_lSucesso = .F.
1145: 
1146:         TRY
1147:             loc_lSucesso = THIS.this_oBusinessObject.ProcessarMudancaFase()
1148:         CATCH TO loc_oErro
1149:             MsgErro(loc_oErro.Message, "Erro no processamento")
1150:         ENDTRY
1151: 
1152:         THIS.cnt_4c_Aguarde.Visible = .F.
1153: 
1154:         IF loc_lSucesso
1155:             MsgInfo("Processamento Finalizado...")
1156:             *-- Limpa todos os campos para nova entrada
1157:             THIS.txt_4c_Linha.Value  = ""
1158:             THIS.txt_4c_DLinha.Value = ""
1159:             THIS.txt_4c_Op.Value     = 0
1160:             THIS.txt_4c_Grupo.Value  = ""
1161:             THIS.txt_4c_Conta.Value  = ""
1162:             THIS.txt_4c_Dconta.Value = ""
1163:             THIS.txt_4c_Linha.Refresh()
1164:             THIS.txt_4c_DLinha.Refresh()
1165:             THIS.txt_4c_Op.Refresh()
1166:             THIS.txt_4c_Grupo.Refresh()
1167:             THIS.txt_4c_Conta.Refresh()

*-- Linhas 1235 a 1243:
1235:         THIS.txt_4c_Op.Enabled       = par_lHabilitar
1236:         THIS.txt_4c_Grupo.Enabled    = par_lHabilitar
1237:         THIS.txt_4c_Conta.Enabled    = par_lHabilitar
1238:         THIS.cmd_4c_Processa.Enabled = par_lHabilitar
1239: 
1240:         IF par_lHabilitar
1241:             THIS.AtualizarEstadoCampos()
1242:         ELSE
1243:             THIS.txt_4c_DLinha.Enabled  = .F.

*-- Linhas 1260 a 1275:
1260: 
1261:     *==========================================================================
1262:     * AjustarBotoesPorModo - Form OPERACIONAL nao tem modos CRUD.
1263:     * Garante que cmd_4c_Processa e cmd_4c_Cancela estao habilitados.
1264:     *==========================================================================
1265:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1266:         IF PEMSTATUS(THIS, "cmd_4c_Processa", 5)
1267:             THIS.cmd_4c_Processa.Enabled = .T.
1268:         ENDIF
1269:         IF PEMSTATUS(THIS, "cmd_4c_Cancela", 5)
1270:             THIS.cmd_4c_Cancela.Enabled = .T.
1271:         ENDIF
1272:     ENDPROC
1273: 
1274:     *==========================================================================
1275:     * BtnSalvarClick - Form OPERACIONAL: equivalente a Processar.

*-- Linhas 1310 a 1322:
1310:     * AtualizarEstadoControles - Garante botoes e campos no estado correto
1311:     *==========================================================================
1312:     PROCEDURE AtualizarEstadoControles()
1313:         IF PEMSTATUS(THIS, "cmd_4c_Processa", 5)
1314:             THIS.cmd_4c_Processa.Enabled = .T.
1315:         ENDIF
1316:         IF PEMSTATUS(THIS, "cmd_4c_Cancela", 5)
1317:             THIS.cmd_4c_Cancela.Enabled = .T.
1318:         ENDIF
1319:         IF PEMSTATUS(THIS, "txt_4c_Linha", 5)
1320:             THIS.AtualizarEstadoCampos()
1321:         ENDIF
1322:         THIS.Refresh()


### BO (C:\4c\projeto\app\classes\SigPdMfaBO.prg):
*------------------------------------------------------------------------------
* SigPdMfaBO.prg - Business Object para Mudanca de Fase Automatica
* Herda de: BusinessBase
* Tabela principal: SigPdMvf
* Chave: cIdChaves
*------------------------------------------------------------------------------
DEFINE CLASS SigPdMfaBO AS BusinessBase

    *-- Campos de entrada do formulario
    this_cLinha      = ""
    this_cDLinha     = ""
    this_nOp         = 0
    this_cGrupo      = ""
    this_cConta      = ""
    this_cDconta     = ""

    *-- Chave e parametros do sistema
    this_cSigKey      = ""
    this_cDopEntAuts  = ""
    this_cDoppPads    = ""
    this_cDoppServs   = ""

    *-- Contador interno para gerar cIdChaves unicas por execucao
    this_nSeqContador = 0

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigPdMvf"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cSigKey
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupo  = TratarNulo(Grupods,   "C")
            THIS.this_cConta  = TratarNulo(Contads,   "C")
            THIS.this_nOp     = TratarNulo(NOps,      "N")
            THIS.this_cSigKey = TratarNulo(cIdChaves, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes do processamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cLinha))
            MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Informar a Linha!!!", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF THIS.this_nOp = 0
            MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Informar a O.P.!!!", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cGrupo))
            MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Informar o Grupo!!!", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cConta))
            MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Informar a Conta!!!", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega SigKeys de SigCdPac e params de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- SigKeys de SigCdPac
            loc_cSQL = "SELECT TOP 1 SigKeys FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac") > 0
                SELECT cursor_4c_SigCdPac
                THIS.this_cSigKey = TratarNulo(SigKeys, "C")
                USE IN cursor_4c_SigCdPac
            ENDIF

            *-- Parametros operacionais de SigCdPam
            loc_cSQL = "SELECT TOP 1 DopEntAuts, DoppPads, DoppServs FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam") > 0
                SELECT cursor_4c_SigCdPam
                THIS.this_cDopEntAuts = TratarNulo(DopEntAuts, "C")
                THIS.this_cDoppPads   = TratarNulo(DoppPads,   "C")
                THIS.this_cDoppServs  = TratarNulo(DoppServs,  "C")
                USE IN cursor_4c_SigCdPam
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar par" + CHR(226) + "metros")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGruposContabeis - Carrega TmpGccr de SigCdGcr (GerBals=1)
    * Retorna .T. se cursor criado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGruposContabeis()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("TmpGccr")
                USE IN TmpGccr
            ENDIF

            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE GerBals = 1"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpGccr") < 1
                MsgErro("Falha ao carregar grupos cont" + CHR(225) + "beis (TmpGccr)", "Erro")
            ELSE
                SELECT TmpGccr
                INDEX ON Codigos TAG BalCodigo
                INDEX ON Descrs  TAG BalDescrs
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar grupos contab" + CHR(233) + "is")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarContas - Carrega TmpCli de SigCdCli (GerBals=1)
    * Retorna .T. se cursor criado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarContas()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("TmpCli")
                USE IN TmpCli
            ENDIF

            loc_cSQL = "SELECT IClis, RClis, Grupos, Inativas FROM SigCdCli WHERE GerBals = 1"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpCli") < 1
                MsgErro("Falha ao carregar contas (TmpCli)", "Erro")
            ELSE
                SELECT TmpCli
                INDEX ON IClis TAG IClis
                INDEX ON IClis TAG BalCodigo
                INDEX ON RClis TAG BalNome
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar contas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarNumBatch - Gera numero sequencial para o batch (Numps)
    *   Equivalente a fGerUniqueKey(lcDop + _Empr) do legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarNumBatch(par_cDop, par_cEmpr)
        LOCAL loc_nChave, loc_cSQL, loc_oErro
        loc_nChave = 1

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(Numps), 0) + 1 AS nProxChave " + ;
                       "FROM SigCdNec"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NumBatch") > 0
                SELECT cursor_4c_NumBatch
                loc_nChave = NVL(nProxChave, 1)
                USE IN cursor_4c_NumBatch
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gerar n" + CHR(250) + "mero de batch")
        ENDTRY

        RETURN loc_nChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarIdChaves - Gera cIdChaves unico de 20 chars para cada registro
    *   Equivalente a Dtos(Date())+Transform(fGerUniqueKey(...), "@L 999999")+SigKey
    *   par_nBatch: numero do batch (Numps), usado para garantir unicidade inter-batch
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarIdChaves(par_nBatch)
        THIS.this_nSeqContador = THIS.this_nSeqContador + 1

        LOCAL loc_cId, loc_nChaveSeq
        *-- Combina batch e contador para 6 digitos: batch ate 9999, contador ate 99
        loc_nChaveSeq = par_nBatch * 100 + THIS.this_nSeqContador
        loc_cId = DTOS(DATE()) + ;
                  TRANSFORM(loc_nChaveSeq, "@L 999999") + ;
                  LEFT(ALLTRIM(THIS.this_cSigKey) + SPACE(6), 6)

        RETURN LEFT(loc_cId + SPACE(20), 20)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarMudancaFase - Logica principal equivalente ao Processa.Click
    *   Busca OPs na faixa, verifica condicoes em SigCdNec e gera movimentacao
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarMudancaFase()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        LOCAL loc_cLinha, loc_cGrupo, loc_cConta, loc_nOp
        LOCAL loc_cDop, loc_cOperacao, loc_cServico
        LOCAL loc_nOpI, loc_nOpF
        LOCAL loc_cGruOrigs, loc_cConOrigs, loc_nSeqs
        LOCAL loc_lSelItem, loc_nBatch, loc_cIds
        LOCAL loc_cSQL, loc_cEmpresa, loc_cUsuario

        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            *-- Captura campos e contexto
            loc_cLinha    = ALLTRIM(THIS.this_cLinha)
            loc_cGrupo    = ALLTRIM(THIS.this_cGrupo)
            loc_cConta    = ALLTRIM(THIS.this_cConta)
            loc_nOp       = THIS.this_nOp
            loc_cEmpresa  = go_4c_Sistema.cCodEmpresa
            loc_cUsuario  = gc_4c_UsuarioLogado
            loc_cDop      = ALLTRIM(THIS.this_cDopEntAuts)
            loc_cOperacao = ALLTRIM(THIS.this_cDoppPads)
            loc_cServico  = ALLTRIM(THIS.this_cDoppServs)

            *-- Validacao obrigatoria dos campos
            IF loc_lContinuar AND !THIS.ValidarDados()
                loc_lContinuar = .F.
            ENDIF

            *-- DOP obrigatorio no cadastro de parametros
            IF loc_lContinuar AND EMPTY(loc_cDop)
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada " + ;
                         "no cadastro de par" + CHR(226) + "metros!", "Aviso")
                loc_lContinuar = .F.
            ENDIF

            *-- Busca detalhes da operacao DOP em SigCdOpd
            IF loc_lContinuar
                loc_cSQL = "SELECT TOP 1 GruOrigs, ConOrigs, Seqs " + ;
                           "FROM SigCdOpd"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpd") < 1
                    MsgErro("Falha ao buscar opera" + CHR(231) + CHR(227) + "o em SigCdOpd", "Erro")
                    loc_lContinuar = .F.
                ELSE
                    SELECT cursor_4c_SigCdOpd
                    GO TOP
                    IF EOF("cursor_4c_SigCdOpd")
                        MsgAviso("Opera" + CHR(231) + CHR(227) + "o DOP n" + CHR(227) + "o encontrada: " + loc_cDop, "Aviso")
                        loc_lContinuar = .F.
                    ELSE
                        loc_cGruOrigs = TratarNulo(GruOrigs, "C")
                        loc_cConOrigs = TratarNulo(ConOrigs, "C")
                        loc_nSeqs     = TratarNulo(Seqs,     "N")
                    ENDIF
                    USE IN cursor_4c_SigCdOpd
                ENDIF
            ENDIF

            *-- Calcula faixa de numeros de OP e busca movimentos
            IF loc_lContinuar
                loc_nOpI = loc_nOp * 10000
                loc_nOpF = loc_nOp * 10000 + 9999

                loc_cSQL = "SELECT Nops, cIdChaves, Emps, Grupods, Contads, " + ;
                           "CodPds, Unids, Obsps, Ordems, Obss, NEnvs " + ;
                           "FROM SigPdMvf " + ;
                           "WHERE Nops BETWEEN " + TRANSFORM(loc_nOpI) + " AND " + TRANSFORM(loc_nOpF)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPdMvf") < 1
                    MsgErro("Falha ao buscar movimentos de produ" + CHR(231) + CHR(227) + "o", "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Cria cursor de staging (equivalente ao xMFas/UpSigPdMvf do legado)
            IF loc_lContinuar
                SET NULL ON
                CREATE CURSOR cursor_4c_xMFas ( ;
                    Emps    C(6)    NULL, ;
                    CodPds  C(20)   NULL, ;
                    Unids   C(6)    NULL, ;
                    Obsps   C(40)   NULL, ;
                    Obss    C(100)  NULL, ;
                    NOps    N(10,0) NULL, ;
                    NEnvs   N(10,0) NULL, ;
                    Pesos   N(14,4) NULL, ;
                    Qtds    N(14,4) NULL, ;
                    Ordems  N(6,0)  NULL  ;
                )
                SET NULL OFF
            ENDIF

            *-- Ordena movimentos desc e processa um registro por grupo de Nops
            IF loc_lContinuar
                SELECT cursor_4c_SigPdMvf
                INDEX ON STR(Nops, 10) + cIdChaves TAG Nops
                SET ORDER TO Nops DESCENDING
                GO TOP

                loc_lSelItem = .F.

                LOCAL loc_nOpPula, loc_llPula
                LOCAL loc_cEmpMvf, loc_nNops, loc_cCodPds, loc_cGrupods, loc_cContads
                LOCAL loc_cObsps, loc_cObss, loc_nNEnvs, loc_nOrdems, loc_cUnids

                DO WHILE !EOF("cursor_4c_SigPdMvf")
                    loc_nOpPula  = cursor_4c_SigPdMvf.Nops
                    loc_llPula   = .T.

                    *-- Captura dados do primeiro registro do grupo
                    loc_cEmpMvf  = TratarNulo(cursor_4c_SigPdMvf.Emps,    "C")
                    loc_nNops    = TratarNulo(cursor_4c_SigPdMvf.Nops,    "N")
                    loc_cCodPds  = TratarNulo(cursor_4c_SigPdMvf.CodPds,  "C")
                    loc_cGrupods = TratarNulo(cursor_4c_SigPdMvf.Grupods, "C")
                    loc_cContads = TratarNulo(cursor_4c_SigPdMvf.Contads, "C")
                    loc_cObsps   = TratarNulo(cursor_4c_SigPdMvf.Obsps,   "C")
                    loc_cObss    = TratarNulo(cursor_4c_SigPdMvf.Obss,    "C")
                    loc_nNEnvs   = TratarNulo(cursor_4c_SigPdMvf.NEnvs,   "N")
                    loc_nOrdems  = TratarNulo(cursor_4c_SigPdMvf.Ordems,  "N")
                    loc_cUnids   = TratarNulo(cursor_4c_SigPdMvf.Unids,   "C")

                    *-- Verifica SigCdNec com operacao padrao (DoppPads)
                    IF !EMPTY(loc_cOperacao)
                        loc_cSQL = "SELECT TOP 1 ChkSubn FROM SigCdNec " + ;
                                   "WHERE cIdChaves = " + EscaparSQL(TratarNulo(cursor_4c_SigPdMvf.cIdChaves, "C"))

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NecOp") > 0
                            SELECT cursor_4c_NecOp
                            IF !EOF("cursor_4c_NecOp")
                                IF !NVL(ChkSubn, .F.) AND ALLTRIM(loc_cEmpMvf) = ALLTRIM(loc_cEmpresa)
                                    loc_llPula = .F.
                                ENDIF
                            ENDIF
                            USE IN cursor_4c_NecOp
                        ENDIF
                    ENDIF

                    *-- Verifica SigCdNec com operacao de servico (DoppServs)
                    IF !EMPTY(loc_cServico)
                        loc_cSQL = "SELECT TOP 1 ChkSubn FROM SigCdNec " + ;
                                   "WHERE cIdChaves = " + EscaparSQL(TratarNulo(cursor_4c_SigPdMvf.cIdChaves, "C"))

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NecSvc") > 0
                            SELECT cursor_4c_NecSvc
                            IF !EOF("cursor_4c_NecSvc")
                                IF !NVL(ChkSubn, .F.) AND ALLTRIM(loc_cEmpMvf) = ALLTRIM(loc_cEmpresa)
                                    loc_llPula = .F.
                                ENDIF
                            ENDIF
                            USE IN cursor_4c_NecSvc
                        ENDIF
                    ENDIF

                    IF loc_llPula
                        *-- Pula todo o grupo de Nops
                        SELECT cursor_4c_SigPdMvf
                        DO WHILE !EOF("cursor_4c_SigPdMvf") AND cursor_4c_SigPdMvf.Nops = loc_nOpPula
                            SKIP
                        ENDDO
                        LOOP
                    ENDIF

                    *-- Busca dados do produto em SigCdPro
                    LOCAL loc_cLinhasPro, loc_nPesoMs
                    loc_cLinhasPro = ""
                    loc_nPesoMs    = 0

                    loc_cSQL = "SELECT TOP 1 Linhas, PesoMs FROM SigCdPro " + ;
                               "WHERE Produtos = " + EscaparSQL(ALLTRIM(loc_cCodPds))

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPro") > 0
                        SELECT cursor_4c_SigCdPro
                        IF !EOF("cursor_4c_SigCdPro")
                            loc_cLinhasPro = TratarNulo(Linhas, "C")
                            loc_nPesoMs    = TratarNulo(PesoMs, "N")
                        ENDIF
                        USE IN cursor_4c_SigCdPro
                    ENDIF

                    *-- Verifica condicoes para incluir este movimento no staging
                    IF ALLTRIM(loc_cGrupods)   = ALLTRIM(loc_cGruOrigs) AND ;
                       ALLTRIM(loc_cContads)   = ALLTRIM(loc_cConOrigs) AND ;
                       ALLTRIM(loc_cEmpMvf)    = ALLTRIM(loc_cEmpresa)  AND ;
                       ALLTRIM(loc_cLinhasPro) = ALLTRIM(loc_cLinha)

                        *-- Busca quantidade total em SigOpPic para esta OP
                        LOCAL loc_nQtde, loc_nTPeso
                        loc_nQtde = 0

                        loc_cSQL = "SELECT ISNULL(SUM(Qtds), 0) AS TotalQtds " + ;
                                   "FROM SigOpPic " + ;
                                   "WHERE Nops = " + TRANSFORM(loc_nNops)

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpPic") > 0
                            SELECT cursor_4c_SigOpPic
                            loc_nQtde = NVL(TotalQtds, 0)
                            USE IN cursor_4c_SigOpPic
                        ENDIF

                        loc_nTPeso = loc_nQtde * loc_nPesoMs

                        *-- Insere no cursor de staging
                        INSERT INTO cursor_4c_xMFas ( ;
                            Emps, CodPds, Unids, Obsps, Obss, ;
                            NOps, NEnvs, Pesos, Qtds, Ordems ;
                        ) VALUES ( ;
                            loc_cEmpresa, loc_cCodPds, loc_cUnids, loc_cObsps, loc_cObss, ;
                            loc_nNops, loc_nNops, loc_nTPeso, loc_nQtde, loc_nOrdems ;
                        )

                        loc_lSelItem = .T.
                    ENDIF

                    *-- Avanca ate proximo grupo de Nops
                    SELECT cursor_4c_SigPdMvf
                    DO WHILE !EOF("cursor_4c_SigPdMvf") AND cursor_4c_SigPdMvf.Nops = loc_nOpPula
                        SKIP
                    ENDDO
                ENDDO
            ENDIF

            *-- Realiza insercoes reais no banco se houver itens selecionados
            IF loc_lContinuar AND loc_lSelItem
                THIS.this_nSeqContador = 0
                loc_nBatch = THIS.GerarNumBatch(loc_cDop, loc_cEmpresa)
                loc_cIds   = THIS.GerarIdChaves(loc_nBatch)

                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                LOCAL loc_lTransOk
                loc_lTransOk = .T.

                *-- Insere cabecalho em SigCdNec
                loc_cSQL = "INSERT INTO SigCdNec " + ;
                           "(Emps, Dopps, Numps, Datas, Usuars, Datars, " + ;
                           " Grupoos, Contaos, Grupods, Contads, cIdChaves, EmpDNps) " + ;
                           "VALUES (" + ;
                           EscaparSQL(loc_cEmpresa) + ", " + ;
                           EscaparSQL(loc_cDop) + ", " + ;
                           TRANSFORM(loc_nBatch) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(loc_cUsuario) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(loc_cGruOrigs) + ", " + ;
                           EscaparSQL(loc_cConOrigs) + ", " + ;
                           EscaparSQL(loc_cGrupo) + ", " + ;
                           EscaparSQL(loc_cConta) + ", " + ;
                           EscaparSQL(loc_cIds) + ", " + ;
                           EscaparSQL(loc_cEmpresa + loc_cDop + STR(loc_nBatch, 10)) + ;
                           ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Falha ao inserir cabecalho em SigCdNec", "Erro")
                    loc_lTransOk = .F.
                ENDIF

                *-- Processa cada item do staging e insere em SigPdMvf
                IF loc_lTransOk
                    SELECT cursor_4c_xMFas
                    GO TOP

                    LOCAL loc_nOrdem, loc_nOrdMfa, loc_cCodPdsMfa, loc_cIdsMvf
                    DO WHILE !EOF("cursor_4c_xMFas") AND loc_lTransOk
                        loc_nOrdMfa    = TratarNulo(cursor_4c_xMFas.Ordems, "N")
                        loc_cCodPdsMfa = TratarNulo(cursor_4c_xMFas.CodPds, "C")
                        loc_nOrdem     = loc_nOrdMfa

                        *-- Consulta SigCdPrf para ajustar Ordems conforme fase seguinte (Seqs=1)
                        IF loc_nSeqs = 1
                            LOCAL loc_nPOrd
                            loc_nPOrd = loc_nOrdMfa + 1

                            *-- Primeira tentativa: fase seguinte pelo Ordems
                            loc_cSQL = "SELECT TOP 1 Grupos, Ordems FROM SigCdPrf " + ;
                                       "WHERE Produtos = " + EscaparSQL(ALLTRIM(loc_cCodPdsMfa)) + ;
                                       "  AND Ordems   = " + TRANSFORM(loc_nPOrd)

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Prf1") > 0
                                SELECT cursor_4c_Prf1
                                IF !EOF("cursor_4c_Prf1") AND ;
                                   ALLTRIM(TratarNulo(Grupos, "C")) = ALLTRIM(loc_cGrupo)
                                    loc_nOrdem = loc_nPOrd
                                ELSE
                                    *-- Segunda tentativa: fase com filtro de grupo
                                    loc_cSQL = "SELECT TOP 1 Grupos, Ordems FROM SigCdPrf " + ;
                                               "WHERE Produtos = " + EscaparSQL(ALLTRIM(loc_cCodPdsMfa)) + ;
                                               "  AND Grupos   = " + EscaparSQL(ALLTRIM(loc_cGrupo)) + ;
                                               "  AND Ordems   = " + TRANSFORM(loc_nPOrd)

                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Prf2") > 0
                                        SELECT cursor_4c_Prf2
                                        IF !EOF("cursor_4c_Prf2")
                                            IF ALLTRIM(TratarNulo(Grupos, "C")) = ALLTRIM(loc_cGrupo)
                                                loc_nOrdem = TratarNulo(Ordems, "N")
                                            ELSE
                                                loc_nOrdem = 0
                                            ENDIF
                                        ENDIF
                                        USE IN cursor_4c_Prf2
                                    ENDIF
                                ENDIF
                                USE IN cursor_4c_Prf1
                            ENDIF
                        ENDIF

                        *-- Gera cIdChaves unico para este movimento
                        loc_cIdsMvf = THIS.GerarIdChaves(loc_nBatch)

                        *-- Monta e executa INSERT em SigPdMvf
                        SELECT cursor_4c_xMFas

                        loc_cSQL = "INSERT INTO SigPdMvf " + ;
                                   "(Emps, Dopps, Numps, Datars, Datas, Usuars, " + ;
                                   " Grupoos, Contaos, Grupods, Contads, " + ;
                                   " NOps, NEnvs, Dataps, Dataes, Obss, " + ;
                                   " Codpds, Unids, Pesos, Qtds, Obsps, " + ;
                                   " Inicios, Finals, Ordems, cIdChaves, EmpDopNums, EmpDNps) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cEmpresa) + ", " + ;
                                   EscaparSQL(loc_cDop) + ", " + ;
                                   TRANSFORM(loc_nBatch) + ", " + ;
                                   "GETDATE(), GETDATE(), " + ;
                                   EscaparSQL(loc_cUsuario) + ", " + ;
                                   EscaparSQL(loc_cGruOrigs) + ", " + ;
                                   EscaparSQL(loc_cConOrigs) + ", " + ;
                                   EscaparSQL(loc_cGrupo) + ", " + ;
                                   EscaparSQL(loc_cConta) + ", " + ;
                                   TRANSFORM(TratarNulo(cursor_4c_xMFas.NOps,   "N")) + ", " + ;
                                   TRANSFORM(TratarNulo(cursor_4c_xMFas.NEnvs,  "N")) + ", " + ;
                                   "GETDATE(), NULL, " + ;
                                   EscaparSQL(TratarNulo(cursor_4c_xMFas.Obss,  "C")) + ", " + ;
                                   EscaparSQL(TratarNulo(cursor_4c_xMFas.CodPds,"C")) + ", " + ;
                                   EscaparSQL(TratarNulo(cursor_4c_xMFas.Unids, "C")) + ", " + ;
                                   FormatarNumeroSQL(TratarNulo(cursor_4c_xMFas.Pesos, "N")) + ", " + ;
                                   FormatarNumeroSQL(TratarNulo(cursor_4c_xMFas.Qtds,  "N")) + ", " + ;
                                   EscaparSQL(TratarNulo(cursor_4c_xMFas.Obsps, "C")) + ", " + ;
                                   "0, 0, " + ;
                                   TRANSFORM(loc_nOrdem) + ", " + ;
                                   EscaparSQL(loc_cIdsMvf) + ", " + ;
                                   EscaparSQL(loc_cEmpresa + SPACE(20) + STR(0, 6)) + ", " + ;
                                   EscaparSQL(loc_cEmpresa + loc_cDop + STR(loc_nBatch, 10)) + ;
                                   ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Falha ao inserir movimento em SigPdMvf", "Erro")
                            loc_lTransOk = .F.
                        ELSE
                            SKIP IN cursor_4c_xMFas
                        ENDIF
                    ENDDO
                ENDIF

                IF loc_lTransOk
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    THIS.RegistrarAuditoria("PROCESSO")
                    loc_lSucesso = .T.
                ELSE
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                ENDIF

            ELSE
                IF loc_lContinuar
                *-- Nenhum item selecionado mas processamento completou sem erro
                loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar mudan" + CHR(231) + "a de fase")
        ENDTRY

        *-- Limpeza de cursores (sempre executa, fora do TRY)
        IF USED("cursor_4c_SigPdMvf")
            USE IN cursor_4c_SigPdMvf
        ENDIF
        IF USED("cursor_4c_xMFas")
            USE IN cursor_4c_xMFas
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Para forms operacionais mapeia para ProcessarMudancaFase
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.ProcessarMudancaFase()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para form operacional puro
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_oErro
        TRY
            LOCAL loc_cSQL
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Operacao, Tabela, ChaveRegistro, Usuario, DataHora, Empresa) " + ;
                       "VALUES (" + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL("SigPdMvf") + ", " + ;
                       EscaparSQL(THIS.this_cSigKey) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Auditoria nao deve impedir a operacao principal
        ENDTRY
    ENDPROC

ENDDEFINE

