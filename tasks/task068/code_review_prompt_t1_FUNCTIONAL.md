# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (13)
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [LAYOUT-POSITION] Controle 'getTipoDat' (parent: SIGRECRT): Top original=104 vs migrado 'obj_4c_GetTipoDat' Top=0 (diff=104px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'getTipoDat' (parent: SIGRECRT): Left original=237 vs migrado 'obj_4c_GetTipoDat' Left=0 (diff=237px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo' (parent: SIGRECRT): Left original=188 vs migrado 'lbl_4c_Lbl_periodo_a' Left=323 (diff=135px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_nr_opcao' (parent: SIGRECRT): Top original=189 vs migrado 'obj_4c_Opt_nr_opcao' Top=0 (diff=189px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_nr_opcao' (parent: SIGRECRT): Left original=428 vs migrado 'obj_4c_Opt_nr_opcao' Left=0 (diff=428px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Bons' (parent: SIGRECRT): Top original=160 vs migrado 'obj_4c_Opt_Bons' Top=0 (diff=160px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Bons' (parent: SIGRECRT): Left original=378 vs migrado 'obj_4c_Opt_Bons' Left=0 (diff=378px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecrt.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1736 linhas total):

*-- Linhas 31 a 138:
31:     *==========================================================================
32:     * INIT
33:     *==========================================================================
34:     PROCEDURE Init()
35:         RETURN DODEFAULT()
36:     ENDPROC
37: 
38:     *==========================================================================
39:     * INICIALIZARFORM - Cria estrutura base do form de relatorio FLAT
40:     *==========================================================================
41:     PROTECTED PROCEDURE InicializarForm()
42:         LOCAL loc_lSucesso
43:         loc_lSucesso = .F.
44:         TRY
45:             THIS.ConfigurarPageFrame()
46: 
47:             THIS.this_oRelatorio = CREATEOBJECT("sigrecrtBO")
48:             IF VARTYPE(THIS.this_oRelatorio) != "O"
49:                 MsgErro("Erro ao criar BO do relat" + CHR(243) + "rio de Cheques Da Carteira", ;
50:                         "InicializarForm")
51:             ELSE
52:                 THIS.ConfigurarCabecalho()
53:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
54: 
55:                 THIS.ConfigurarBotoes()
56:                 THIS.ConfigurarPaginaDados()
57:                 THIS.ConfigurarCamposFiltro()
58: 
59:                 THIS.AtualizarTitulosOpcao()
60:                 THIS.LimparCampos()
61: 
62:                 THIS.Visible   = .T.
63:                 loc_lSucesso   = .T.
64:             ENDIF
65:         CATCH TO loc_oErro
66:             MsgErro(loc_oErro.Message, "InicializarForm")
67:         ENDTRY
68:         RETURN loc_lSucesso
69:     ENDPROC
70: 
71:     *==========================================================================
72:     * CONFIGURARPAGEFRAME - Propriedades de janela do form de relatorio
73:     *
74:     * REPORT usa layout FLAT: nao ha PageFrame de 2 abas como em forms CRUD.
75:     * Este metodo aplica as propriedades da janela (Caption, Picture, Icon,
76:     * comportamento) e prepara a area util para os containers que sao
77:     * adicionados diretamente ao Form.
78:     *==========================================================================
79:     PROTECTED PROCEDURE ConfigurarPageFrame()
80:         THIS.Caption     = "Relat" + CHR(243) + "rio de Cheques Da Carteira"
81:         THIS.Picture     = gc_4c_CaminhoIcones + "new_background.jpg"
82:         THIS.Icon        = gc_4c_CaminhoIcones + "icon.ico"
83:         THIS.AutoCenter  = .T.
84:         THIS.BorderStyle = 2
85:         THIS.WindowType  = 1
86:         THIS.ControlBox  = .F.
87:         THIS.MaxButton   = .F.
88:         THIS.MinButton   = .F.
89:         THIS.TitleBar    = 0
90:         THIS.Themes      = .F.
91:         THIS.ShowTips    = .T.
92:         THIS.BackColor   = RGB(255, 255, 255)
93:     ENDPROC
94: 
95:     *==========================================================================
96:     * CONFIGURARCABECALHO - Container escuro com labels titulo/sombra
97:     *==========================================================================
98:     PROTECTED PROCEDURE ConfigurarCabecalho()
99:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
100:         WITH THIS.cnt_4c_Cabecalho
101:             .Top         = 0
102:             .Left        = 0
103:             .Width       = THIS.Width
104:             .Height      = 80
105:             .BackStyle   = 1
106:             .BackColor   = RGB(100, 100, 100)
107:             .BorderWidth = 0
108:             .Visible     = .T.
109: 
110:             .AddObject("lbl_4c_Sombra", "Label")
111:             WITH .lbl_4c_Sombra
112:                 .Top       = 15
113:                 .Left      = 12
114:                 .Width     = THIS.Width
115:                 .Height    = 40
116:                 .FontName  = "Tahoma"
117:                 .FontSize  = 16
118:                 .FontBold  = .T.
119:                 .BackStyle = 0
120:                 .ForeColor = RGB(0, 0, 0)
121:                 .Caption   = THIS.Caption
122:                 .Visible   = .T.
123:             ENDWITH
124: 
125:             .AddObject("lbl_4c_Titulo", "Label")
126:             WITH .lbl_4c_Titulo
127:                 .Top       = 18
128:                 .Left      = 10
129:                 .Width     = THIS.Width
130:                 .Height    = 40
131:                 .FontName  = "Tahoma"
132:                 .FontSize  = 16
133:                 .FontBold  = .T.
134:                 .BackStyle = 0
135:                 .ForeColor = RGB(255, 255, 255)
136:                 .Caption   = THIS.Caption
137:                 .Visible   = .T.
138:             ENDWITH

*-- Linhas 145 a 188:
145:     * Left=726 (proporcional ao form de 1000px), Top=6
146:     * Lefts internos: Btn1=5, Btn2=71, Btn3=137, Btn4=203 (incrementos de 66)
147:     *==========================================================================
148:     PROTECTED PROCEDURE ConfigurarBotoes()
149:         LOCAL loc_cIcones
150:         loc_cIcones = gc_4c_CaminhoIcones
151: 
152:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
153:         WITH THIS.cmg_4c_Botoes
154:             .Top           = 6
155:             .Left          = 726
156:             .Width         = 273
157:             .Height        = 80
158:             .ButtonCount   = 4
159:             .BackStyle     = 0
160:             .BorderStyle   = 0
161:             .BorderColor   = RGB(136, 189, 188)
162:             .SpecialEffect = 1
163:             .Themes        = .F.
164:             .Visible       = .T.
165: 
166:             WITH .Buttons(1)
167:                 .Top             = 5
168:                 .Left            = 5
169:                 .Width           = 65
170:                 .Height          = 70
171:                 .Caption         = "Visualizar"
172:                 .Picture         = loc_cIcones + "ideo.jpg"
173:                 .FontBold        = .T.
174:                 .FontItalic      = .T.
175:                 .BackColor       = RGB(255, 255, 255)
176:                 .ForeColor       = RGB(90, 90, 90)
177:                 .PicturePosition = 13
178:                 .SpecialEffect   = 0
179:                 .MousePointer    = 15
180:                 .Themes          = .F.
181:                 .WordWrap        = .T.
182:             ENDWITH
183: 
184:             WITH .Buttons(2)
185:                 .Top             = 5
186:                 .Left            = 71
187:                 .Width           = 65
188:                 .Height          = 70

*-- Linhas 243 a 334:
243:             ENDWITH
244:         ENDWITH
245: 
246:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
247:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
248:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
249:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnCancelarClick")
250:     ENDPROC
251: 
252:     *==========================================================================
253:     * ATUALIZARESTADOCONTROLES - Override: form de relatorio nao usa CRUD
254:     *==========================================================================
255:     PROCEDURE AtualizarEstadoControles()
256:         RETURN
257:     ENDPROC
258: 
259:     *==========================================================================
260:     * ALTERNARPAGINA - Controle de pagina (REPORT eh FLAT - 1 pagina logica)
261:     *
262:     * Form de relatorio nao tem PageFrame de 2 abas. Mantemos o contrato do
263:     * metodo para compatibilidade com FormBase e rastreamos em this_nPaginaAtual.
264:     * Se o caller solicitar a "pagina de lista" (1), delegamos para
265:     * ConfigurarPaginaLista() que reseta os filtros e devolve o foco para o
266:     * primeiro campo editavel - comportamento equivalente ao "voltar para
267:     * lista" de forms CRUD adaptado ao contexto de REPORT.
268:     *==========================================================================
269:     PROCEDURE AlternarPagina(par_nPagina)
270:         LOCAL loc_nPagina
271:         loc_nPagina = IIF(PCOUNT() < 1 OR VARTYPE(par_nPagina) != "N", 1, par_nPagina)
272:         IF loc_nPagina < 1
273:             loc_nPagina = 1
274:         ENDIF
275:         THIS.this_nPaginaAtual = loc_nPagina
276:         IF loc_nPagina = 1
277:             THIS.ConfigurarPaginaLista()
278:         ENDIF
279:     ENDPROC
280: 
281:     *==========================================================================
282:     * CONFIGURARPAGINALISTA - Override: REPORT nao tem Page1 (Lista) de CRUD
283:     *
284:     * Forms de relatorio (frmrelatorio) usam layout FLAT, sem Page1/Page2 e
285:     * sem grid de lista. O equivalente conceitual da "Page1 - Lista" eh a
286:     * area de FILTROS ja configurada em ConfigurarCamposFiltro() (Fase 4
287:     * desta migracao). Este metodo eh mantido para compatibilidade com o
288:     * contrato esperado de FormBase e implementa o "voltar para a lista":
289:     *  - Reseta todos os filtros para os valores padrao (LimparCampos)
290:     *  - Re-aplica os titulos dinamicos do opt_nr_opcao (SigCdPac)
291:     *  - Esconde o OptionGroup opt_Bons quando o TipoRel nao for "BONS"
292:     *  - Devolve o foco para o primeiro campo editavel (data inicial)
293:     *==========================================================================
294:     PROCEDURE ConfigurarPaginaLista()
295:         LOCAL loc_nTipoRel
296:         TRY
297:             THIS.LimparCampos()
298:             THIS.AtualizarTitulosOpcao()
299: 
300:             IF PEMSTATUS(THIS, "cbo_4c_GetTipoRel", 5) ;
301:                AND PEMSTATUS(THIS, "obj_4c_Opt_Bons", 5)
302:                 loc_nTipoRel = THIS.cbo_4c_GetTipoRel.ListIndex
303:                 THIS.obj_4c_Opt_Bons.Visible = (loc_nTipoRel = 4)
304:             ENDIF
305: 
306:             IF PEMSTATUS(THIS, "txt_4c__dt_inicial", 5)
307:                 IF VARTYPE(THIS.txt_4c__dt_inicial) = "O" ;
308:                    AND THIS.txt_4c__dt_inicial.Enabled ;
309:                    AND THIS.txt_4c__dt_inicial.Visible
310:                     THIS.txt_4c__dt_inicial.SetFocus()
311:                 ENDIF
312:             ENDIF
313: 
314:             THIS.this_nPaginaAtual = 1
315:         CATCH TO loc_oErro
316:             MsgErro(loc_oErro.Message, "ConfigurarPaginaLista")
317:         ENDTRY
318:     ENDPROC
319: 
320:     *==========================================================================
321:     * FORMPARARELATORIO - Transfere valores dos controles do form para o BO
322:     * Usa PEMSTATUS para cada controle (seguro em todas as fases de migracao)
323:     *
324:     * Controles mapeados (mapeamento.json):
325:     *   obj_4c_GetTipoDat    <- getTipoDat  (tipo data: 1=Vencimento, 2=Emissao)
326:     *   txt_4c__dt_inicial   <- get_dt_inicial
327:     *   txt_4c__dt_final     <- get_dt_final
328:     *   txt_4c__cd_empresa   <- get_cd_empresa
329:     *   txt_4c__ds_empresa   <- get_ds_empresa
330:     *   txt_4c_Juros         <- getJuros
331:     *   cbo_4c_GetTipoRel    <- GetTipoRel  (tipo relatorio: 1-5)
332:     *   obj_4c_Opt_nr_opcao  <- opt_nr_opcao (opcao nota: 1=Sim, 2=Nao, 3=Ambos)
333:     *   cbo_4c_Get_ordem     <- get_ordem   (ordem: 1=VALOR, 2=DATA VEN, 3=DATA OP)
334:     *   obj_4c_Opt_Bons      <- Opt_Bons    (1=Ativos, 2=Todos; visivel em TipoRel=4)

*-- Linhas 345 a 427:
345:     *   txt_4c__cd_dep_conta <- get_cd_dep_conta
346:     *   txt_4c__ds_dep_conta <- get_ds_dep_conta
347:     *==========================================================================
348:     PROTECTED PROCEDURE FormParaRelatorio()
349:         IF VARTYPE(THIS.this_oRelatorio) != "O"
350:             RETURN
351:         ENDIF
352:         WITH THIS.this_oRelatorio
353:             *-- Tipo de data (OptionGroup: 1=Vencimento, 2=Emissao)
354:             IF PEMSTATUS(THIS, "obj_4c_GetTipoDat", 5)
355:                 .this_nTipoDat = THIS.obj_4c_GetTipoDat.Value
356:             ENDIF
357:             *-- Periodo
358:             IF PEMSTATUS(THIS, "txt_4c__dt_inicial", 5)
359:                 .this_dDtInicial = THIS.txt_4c__dt_inicial.Value
360:             ENDIF
361:             IF PEMSTATUS(THIS, "txt_4c__dt_final", 5)
362:                 .this_dDtFinal = THIS.txt_4c__dt_final.Value
363:             ENDIF
364:             *-- Empresa
365:             IF PEMSTATUS(THIS, "txt_4c__cd_empresa", 5)
366:                 .this_cCdEmpresa = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
367:             ENDIF
368:             IF PEMSTATUS(THIS, "txt_4c__ds_empresa", 5)
369:                 .this_cDsEmpresa = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
370:             ENDIF
371:             *-- Juros mensal (%)
372:             IF PEMSTATUS(THIS, "txt_4c_Juros", 5)
373:                 .this_nJuros = THIS.txt_4c_Juros.Value
374:             ENDIF
375:             *-- Tipo de relatorio (ComboBox ListIndex: 1=ATIVOS, 2=BAIXADOS, 3=NEG.PG, 4=BONS, 5=DEVOLVIDOS)
376:             IF PEMSTATUS(THIS, "cbo_4c_GetTipoRel", 5)
377:                 .this_nTipoRel = THIS.cbo_4c_GetTipoRel.ListIndex
378:             ENDIF
379:             *-- Opcao nota (OptionGroup: 1=Sim, 2=Nao, 3=Ambos)
380:             IF PEMSTATUS(THIS, "obj_4c_Opt_nr_opcao", 5)
381:                 .this_nNrOpcao = THIS.obj_4c_Opt_nr_opcao.Value
382:             ENDIF
383:             *-- Ordem de classificacao (ComboBox ListIndex: 1=VALOR, 2=DATA VENCIMENTO, 3=DATA OPERACAO)
384:             IF PEMSTATUS(THIS, "cbo_4c_Get_ordem", 5)
385:                 .this_nIndexOrdem = THIS.cbo_4c_Get_ordem.ListIndex
386:             ENDIF
387:             *-- Opcao bons (OptionGroup: 1=Ativos, 2=Todos; visivel apenas quando TipoRel=4)
388:             IF PEMSTATUS(THIS, "obj_4c_Opt_Bons", 5)
389:                 .this_nOptBons = THIS.obj_4c_Opt_Bons.Value
390:             ENDIF
391:             *-- Emissor/Carteira: grupo e conta
392:             IF PEMSTATUS(THIS, "txt_4c__cd_emi_grupo", 5)
393:                 .this_cCdEmiGrupo = ALLTRIM(THIS.txt_4c__cd_emi_grupo.Value)
394:             ENDIF
395:             IF PEMSTATUS(THIS, "txt_4c__ds_emi_grupo", 5)
396:                 .this_cDsEmiGrupo = ALLTRIM(THIS.txt_4c__ds_emi_grupo.Value)
397:             ENDIF
398:             IF PEMSTATUS(THIS, "txt_4c__cd_emi_conta", 5)
399:                 .this_cCdEmiConta = ALLTRIM(THIS.txt_4c__cd_emi_conta.Value)
400:             ENDIF
401:             IF PEMSTATUS(THIS, "txt_4c__ds_emi_conta", 5)
402:                 .this_cDsEmiConta = ALLTRIM(THIS.txt_4c__ds_emi_conta.Value)
403:             ENDIF
404:             *-- Origem: grupo e conta (GetCGrupoO / GetDGrupoO / GetCContaO / GetDContaO)
405:             IF PEMSTATUS(THIS, "txt_4c_CGrupoO", 5)
406:                 .this_cCdOriGrupo = ALLTRIM(THIS.txt_4c_CGrupoO.Value)
407:             ENDIF
408:             IF PEMSTATUS(THIS, "txt_4c_DGrupoO", 5)
409:                 .this_cDsOriGrupo = ALLTRIM(THIS.txt_4c_DGrupoO.Value)
410:             ENDIF
411:             IF PEMSTATUS(THIS, "txt_4c_CContaO", 5)
412:                 .this_cCdOriConta = ALLTRIM(THIS.txt_4c_CContaO.Value)
413:             ENDIF
414:             IF PEMSTATUS(THIS, "txt_4c_DContaO", 5)
415:                 .this_cDsOriConta = ALLTRIM(THIS.txt_4c_DContaO.Value)
416:             ENDIF
417:             *-- Destino/Deposito: grupo e conta
418:             IF PEMSTATUS(THIS, "txt_4c__cd_dep_grupo", 5)
419:                 .this_cCdDesGrupo = ALLTRIM(THIS.txt_4c__cd_dep_grupo.Value)
420:             ENDIF
421:             IF PEMSTATUS(THIS, "txt_4c__ds_dep_grupo", 5)
422:                 .this_cDsDesGrupo = ALLTRIM(THIS.txt_4c__ds_dep_grupo.Value)
423:             ENDIF
424:             IF PEMSTATUS(THIS, "txt_4c__cd_dep_conta", 5)
425:                 .this_cCdDesConta = ALLTRIM(THIS.txt_4c__cd_dep_conta.Value)
426:             ENDIF
427:             IF PEMSTATUS(THIS, "txt_4c__ds_dep_conta", 5)

*-- Linhas 433 a 588:
433:     *==========================================================================
434:     * BTNVISUALIZARCLICK - Botao 1: Visualizar relatorio em tela (preview)
435:     *==========================================================================
436:     PROCEDURE BtnVisualizarClick()
437:         LOCAL loc_lSucesso
438:         loc_lSucesso = .F.
439:         TRY
440:             THIS.FormParaRelatorio()
441:             loc_lSucesso = THIS.this_oRelatorio.Visualizar()
442:             IF !loc_lSucesso
443:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
444:             ENDIF
445:         CATCH TO loc_oErro
446:             MsgErro(loc_oErro.Message, "BtnVisualizarClick")
447:         ENDTRY
448:     ENDPROC
449: 
450:     *==========================================================================
451:     * BTNIMPRIMIRCLICK - Botao 2: Imprimir relatorio em impressora
452:     *==========================================================================
453:     PROCEDURE BtnImprimirClick()
454:         LOCAL loc_lSucesso
455:         loc_lSucesso = .F.
456:         TRY
457:             THIS.FormParaRelatorio()
458:             loc_lSucesso = THIS.this_oRelatorio.Imprimir()
459:             IF !loc_lSucesso
460:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
461:             ENDIF
462:         CATCH TO loc_oErro
463:             MsgErro(loc_oErro.Message, "BtnImprimirClick")
464:         ENDTRY
465:     ENDPROC
466: 
467:     *==========================================================================
468:     * BTNEXCELCLICK - Botao 3: Exportar dados para Excel
469:     *==========================================================================
470:     PROCEDURE BtnExcelClick()
471:         LOCAL loc_lSucesso, loc_cArqXls
472:         loc_lSucesso = .F.
473:         TRY
474:             THIS.FormParaRelatorio()
475:             IF !THIS.this_oRelatorio.PrepararDados()
476:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
477:                 RETURN
478:             ENDIF
479:             IF USED("CsRelatorio")
480:                 loc_cArqXls = SYS(2023) + "\SigReCrt_" + STRTRAN(DTOC(DATE()), "/", "") + ".xls"
481:                 SELECT CsRelatorio
482:                 COPY TO (loc_cArqXls) TYPE XL5
483:                 THIS.this_oRelatorio.LimparCursores()
484:                 MsgInfo("Arquivo Excel gerado em: " + loc_cArqXls, "Excel")
485:                 loc_lSucesso = .T.
486:             ELSE
487:                 MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para exportar.", "Excel")
488:             ENDIF
489:         CATCH TO loc_oErro
490:             MsgErro(loc_oErro.Message, "BtnExcelClick")
491:         ENDTRY
492:     ENDPROC
493: 
494:     *==========================================================================
495:     * BTNCANCELARCLICK - Botao 4: Fechar o form (ESC / Sair)
496:     *==========================================================================
497:     PROCEDURE BtnCancelarClick()
498:         THIS.Release()
499:     ENDPROC
500: 
501:     *==========================================================================
502:     * BTNINCLUIRCLICK - Mapeia "Incluir" de CRUD para Visualizar em REPORT
503:     *==========================================================================
504:     PROCEDURE BtnIncluirClick()
505:         LOCAL loc_lSucesso
506:         loc_lSucesso = .F.
507:         TRY
508:             THIS.FormParaRelatorio()
509:             loc_lSucesso = THIS.this_oRelatorio.Visualizar()
510:             IF !loc_lSucesso
511:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
512:                         "Gerar Relat" + CHR(243) + "rio")
513:             ENDIF
514:         CATCH TO loc_oErro
515:             MsgErro(loc_oErro.Message, "BtnIncluirClick")
516:         ENDTRY
517:     ENDPROC
518: 
519:     *==========================================================================
520:     * BTNALTERARCLICK - Mapeia "Alterar" de CRUD para LimparCampos em REPORT
521:     *==========================================================================
522:     PROCEDURE BtnAlterarClick()
523:         TRY
524:             THIS.LimparCampos()
525:             IF PEMSTATUS(THIS, "txt_4c__dt_inicial", 5)
526:                 IF VARTYPE(THIS.txt_4c__dt_inicial) = "O"
527:                     THIS.txt_4c__dt_inicial.SetFocus()
528:                 ENDIF
529:             ENDIF
530:         CATCH TO loc_oErro
531:             MsgErro(loc_oErro.Message, "BtnAlterarClick")
532:         ENDTRY
533:     ENDPROC
534: 
535:     *==========================================================================
536:     * BTNEXCLUIRCLICK - Mapeia "Excluir" de CRUD para Encerrar em REPORT
537:     *==========================================================================
538:     PROCEDURE BtnExcluirClick()
539:         IF MsgConfirma("Deseja encerrar o relat" + CHR(243) + "rio?", "Encerrar")
540:             THIS.Release()
541:         ENDIF
542:     ENDPROC
543: 
544:     *==========================================================================
545:     * LIMPARCAMPOS - Reseta todos os filtros para os valores padrao
546:     * Usa PEMSTATUS para ser seguro antes de ConfigurarCamposFiltro() (Fase 4)
547:     *==========================================================================
548:     PROCEDURE LimparCampos()
549:         IF PEMSTATUS(THIS, "obj_4c_GetTipoDat", 5)
550:             THIS.obj_4c_GetTipoDat.Value = 1
551:         ENDIF
552:         IF PEMSTATUS(THIS, "txt_4c__dt_inicial", 5)
553:             THIS.txt_4c__dt_inicial.Value = DATE()
554:         ENDIF
555:         IF PEMSTATUS(THIS, "txt_4c__dt_final", 5)
556:             THIS.txt_4c__dt_final.Value = DATE()
557:         ENDIF
558:         IF PEMSTATUS(THIS, "txt_4c__cd_empresa", 5)
559:             THIS.txt_4c__cd_empresa.Value = ""
560:         ENDIF
561:         IF PEMSTATUS(THIS, "txt_4c__ds_empresa", 5)
562:             THIS.txt_4c__ds_empresa.Value = ""
563:         ENDIF
564:         IF PEMSTATUS(THIS, "txt_4c_Juros", 5)
565:             THIS.txt_4c_Juros.Value = 0
566:         ENDIF
567:         IF PEMSTATUS(THIS, "cbo_4c_GetTipoRel", 5)
568:             THIS.cbo_4c_GetTipoRel.ListIndex = 1
569:         ENDIF
570:         IF PEMSTATUS(THIS, "obj_4c_Opt_nr_opcao", 5)
571:             THIS.obj_4c_Opt_nr_opcao.Value = 3
572:         ENDIF
573:         IF PEMSTATUS(THIS, "cbo_4c_Get_ordem", 5)
574:             THIS.cbo_4c_Get_ordem.ListIndex = 1
575:         ENDIF
576:         IF PEMSTATUS(THIS, "obj_4c_Opt_Bons", 5)
577:             THIS.obj_4c_Opt_Bons.Value   = 1
578:             THIS.obj_4c_Opt_Bons.Visible = .F.
579:         ENDIF
580:         IF PEMSTATUS(THIS, "txt_4c__cd_emi_grupo", 5)
581:             THIS.txt_4c__cd_emi_grupo.Value = ""
582:         ENDIF
583:         IF PEMSTATUS(THIS, "txt_4c__ds_emi_grupo", 5)
584:             THIS.txt_4c__ds_emi_grupo.Value = ""
585:         ENDIF
586:         IF PEMSTATUS(THIS, "txt_4c__cd_emi_conta", 5)
587:             THIS.txt_4c__cd_emi_conta.Value = ""
588:         ENDIF

*-- Linhas 619 a 696:
619:     * ATUALIZARTITULOSOPCAO - Atualiza captions do opt_nr_opcao com titulos
620:     * dinamicos carregados de SigCdPac pelo BO em CarregarParametros()
621:     *==========================================================================
622:     PROCEDURE AtualizarTitulosOpcao()
623:         IF VARTYPE(THIS.this_oRelatorio) != "O"
624:             RETURN
625:         ENDIF
626:         IF PEMSTATUS(THIS, "obj_4c_Opt_nr_opcao", 5)
627:             IF VARTYPE(THIS.obj_4c_Opt_nr_opcao) = "O"
628:                 WITH THIS.obj_4c_Opt_nr_opcao
629:                     .Buttons(1).Caption = THIS.this_oRelatorio.this_cTituloOpcao1
630:                     .Buttons(2).Caption = THIS.this_oRelatorio.this_cTituloOpcao2
631:                     .Buttons(3).Caption = THIS.this_oRelatorio.this_cTituloOpcao3
632:                 ENDWITH
633:             ENDIF
634:         ENDIF
635:     ENDPROC
636: 
637:     *==========================================================================
638:     * DESTROY - Libera BO e recursos (NAO usar Release no BO - Custom sem Release)
639:     *==========================================================================
640:     PROCEDURE Destroy()
641:         IF VARTYPE(THIS.this_oRelatorio) = "O"
642:             THIS.this_oRelatorio = .NULL.
643:         ENDIF
644:         DODEFAULT()
645:     ENDPROC
646: 
647:     *==========================================================================
648:     * CONFIGURARPAGINADADADOS - Cria controles de filtro: primeira metade
649:     * Mapeamento.json itens 1-17: getTipoDat, periodo, juros, operacao,
650:     * tipo-rel, nr_opcao, empresa, emissor-grupo e emissor-conta (codigo)
651:     *==========================================================================
652:     PROTECTED PROCEDURE ConfigurarPaginaDados()
653:         LOCAL loc_cFonte
654:         loc_cFonte = "Tahoma"
655: 
656:         THIS.AddObject("obj_4c_GetTipoDat", "OptionGroup")
657:         WITH THIS.obj_4c_GetTipoDat
658:             .Top         = 104
659:             .Left        = 237
660:             .Width       = 157
661:             .Height      = 25
662:             .ButtonCount = 2
663:             .BackStyle   = 0
664:             .BorderStyle = 0
665:             .ToolTipText = "Emiss" + CHR(227) + "o = a data de inclus" + CHR(227) + ;
666:                            "o da movimenta" + CHR(231) + CHR(227) + "o"
667:             .Visible     = .T.
668:             WITH .Buttons(1)
669:                 .Caption   = "Vencimento"
670:                 .Left      = 0
671:                 .Top       = 0
672:                 .Width     = 78
673:                 .Height    = 22
674:                 .AutoSize  = .F.
675:                 .ForeColor = RGB(90, 90, 90)
676:                 .BackStyle = 0
677:             ENDWITH
678:             WITH .Buttons(2)
679:                 .Caption   = "Emiss" + CHR(227) + "o"
680:                 .Left      = 80
681:                 .Top       = 0
682:                 .Width     = 72
683:                 .Height    = 22
684:                 .AutoSize  = .F.
685:                 .FontName  = loc_cFonte
686:                 .FontSize  = 9
687:                 .ForeColor = RGB(90, 90, 90)
688:                 .BackStyle = 0
689:             ENDWITH
690:         ENDWITH
691: 
692:         THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
693:         WITH THIS.lbl_4c_Lbl_empresa
694:             .Top       = 221
695:             .Left      = 183
696:             .Width     = 50

*-- Linhas 853 a 896:
853:             .Visible   = .T.
854:         ENDWITH
855: 
856:         THIS.AddObject("obj_4c_Opt_nr_opcao", "OptionGroup")
857:         WITH THIS.obj_4c_Opt_nr_opcao
858:             .Top         = 189
859:             .Left        = 428
860:             .Width       = 192
861:             .Height      = 23
862:             .ButtonCount = 3
863:             .BackStyle   = 0
864:             .BorderStyle = 0
865:             .Visible     = .T.
866:             WITH .Buttons(1)
867:                 .Caption   = "Sim"
868:                 .Left      = 0
869:                 .Top       = 0
870:                 .Width     = 63
871:                 .Height    = 21
872:                 .AutoSize  = .F.
873:                 .ForeColor = RGB(90, 90, 90)
874:                 .BackStyle = 0
875:             ENDWITH
876:             WITH .Buttons(2)
877:                 .Caption   = "N" + CHR(227) + "o"
878:                 .Left      = 65
879:                 .Top       = 0
880:                 .Width     = 63
881:                 .Height    = 21
882:                 .AutoSize  = .F.
883:                 .FontName  = loc_cFonte
884:                 .FontSize  = 9
885:                 .ForeColor = RGB(90, 90, 90)
886:                 .BackStyle = 0
887:             ENDWITH
888:             WITH .Buttons(3)
889:                 .Caption   = "Ambos"
890:                 .Left      = 130
891:                 .Top       = 0
892:                 .Width     = 60
893:                 .Height    = 21
894:                 .AutoSize  = .F.
895:                 .FontName  = loc_cFonte
896:                 .FontSize  = 9

*-- Linhas 940 a 1032:
940:             .Visible   = .T.
941:         ENDWITH
942: 
943:         BINDEVENT(THIS.txt_4c__cd_empresa,   "KeyPress", THIS, "TeclaCdEmpresa")
944:         BINDEVENT(THIS.txt_4c__ds_empresa,   "KeyPress", THIS, "TeclaDsEmpresa")
945:         BINDEVENT(THIS.txt_4c__cd_emi_grupo, "KeyPress", THIS, "TeclaCdEmiGrupo")
946:         BINDEVENT(THIS.txt_4c__ds_emi_grupo, "KeyPress", THIS, "TeclaDsEmiGrupo")
947:         BINDEVENT(THIS.txt_4c__cd_emi_conta, "KeyPress", THIS, "TeclaCdEmiConta")
948:         BINDEVENT(THIS.txt_4c__cd_empresa,   "DblClick", THIS, "DblClickCdEmpresa")
949:         BINDEVENT(THIS.txt_4c__cd_emi_grupo, "DblClick", THIS, "DblClickCdEmiGrupo")
950:         BINDEVENT(THIS.txt_4c__cd_emi_conta, "DblClick", THIS, "DblClickCdEmiConta")
951:     ENDPROC
952: 
953:     *==========================================================================
954:     * CONFIGURARCAMPOSFILTRO - Cria controles de filtro: segunda metade
955:     * Mapeamento.json itens 18-35: emi-conta-descricao, ordem, bons, tipo-rel,
956:     * dep-grupo, dep-conta, ori-grupo, ori-conta e todos os labels Say2-Say6
957:     *==========================================================================
958:     PROTECTED PROCEDURE ConfigurarCamposFiltro()
959:         LOCAL loc_cFonte
960:         loc_cFonte = "Tahoma"
961: 
962:         THIS.AddObject("txt_4c__ds_emi_conta", "TextBox")
963:         WITH THIS.txt_4c__ds_emi_conta
964:             .Top         = 289
965:             .Left        = 319
966:             .Width       = 290
967:             .Height      = 20
968:             .MaxLength   = 50
969:             .ReadOnly    = .T.
970:             .FontName    = loc_cFonte
971:             .FontSize    = 9
972:             .BackColor   = RGB(245, 245, 245)
973:             .ToolTipText = "Passe o Cheque na Leitora"
974:             .Visible     = .T.
975:         ENDWITH
976: 
977:         THIS.AddObject("cbo_4c_Get_ordem", "ComboBox")
978:         WITH THIS.cbo_4c_Get_ordem
979:             .Top           = 188
980:             .Left          = 237
981:             .Width         = 134
982:             .Height        = 20
983:             .Style         = 2
984:             .RowSourceType = 1
985:             .RowSource     = "VALOR,DATA VENCIMENTO,DATA OPERA" + CHR(199) + CHR(195) + "O"
986:             .FontName      = loc_cFonte
987:             .FontSize      = 9
988:             .BackColor     = RGB(255, 255, 255)
989:             .Visible       = .T.
990:         ENDWITH
991: 
992:         THIS.AddObject("obj_4c_Opt_Bons", "OptionGroup")
993:         WITH THIS.obj_4c_Opt_Bons
994:             .Top         = 160
995:             .Left        = 378
996:             .Width       = 163
997:             .Height      = 22
998:             .ButtonCount = 2
999:             .BackStyle   = 0
1000:             .BorderStyle = 0
1001:             .Visible     = .F.
1002:             WITH .Buttons(1)
1003:                 .Caption   = "Ativos"
1004:                 .Left      = 0
1005:                 .Top       = 0
1006:                 .Width     = 78
1007:                 .Height    = 22
1008:                 .AutoSize  = .F.
1009:                 .ForeColor = RGB(90, 90, 90)
1010:                 .BackStyle = 0
1011:             ENDWITH
1012:             WITH .Buttons(2)
1013:                 .Caption   = "Todos"
1014:                 .Left      = 80
1015:                 .Top       = 0
1016:                 .Width     = 78
1017:                 .Height    = 22
1018:                 .AutoSize  = .F.
1019:                 .FontName  = loc_cFonte
1020:                 .FontSize  = 9
1021:                 .ForeColor = RGB(90, 90, 90)
1022:                 .BackStyle = 0
1023:             ENDWITH
1024:         ENDWITH
1025: 
1026:         THIS.AddObject("cbo_4c_GetTipoRel", "ComboBox")
1027:         WITH THIS.cbo_4c_GetTipoRel
1028:             .Top           = 160
1029:             .Left          = 237
1030:             .Width         = 134
1031:             .Height        = 20
1032:             .Style         = 2

*-- Linhas 1236 a 1735:
1236:             .Visible   = .T.
1237:         ENDWITH
1238: 
1239:         BINDEVENT(THIS.cbo_4c_GetTipoRel,   "InteractiveChange", THIS, "MudarTipoRel")
1240:         BINDEVENT(THIS.txt_4c__ds_emi_conta, "KeyPress", THIS, "TeclaDsEmiConta")
1241:         BINDEVENT(THIS.txt_4c_CGrupoO,       "KeyPress", THIS, "TeclaCGrupoO")
1242:         BINDEVENT(THIS.txt_4c_DGrupoO,       "KeyPress", THIS, "TeclaDGrupoO")
1243:         BINDEVENT(THIS.txt_4c_CContaO,       "KeyPress", THIS, "TeclaCContaO")
1244:         BINDEVENT(THIS.txt_4c_DContaO,       "KeyPress", THIS, "TeclaDContaO")
1245:         BINDEVENT(THIS.txt_4c__cd_dep_grupo, "KeyPress", THIS, "TeclaCdDepGrupo")
1246:         BINDEVENT(THIS.txt_4c__ds_dep_grupo, "KeyPress", THIS, "TeclaDsDepGrupo")
1247:         BINDEVENT(THIS.txt_4c__cd_dep_conta, "KeyPress", THIS, "TeclaCdDepConta")
1248:         BINDEVENT(THIS.txt_4c__ds_dep_conta, "KeyPress", THIS, "TeclaDsDepConta")
1249:         BINDEVENT(THIS.txt_4c_CGrupoO,       "DblClick", THIS, "DblClickCGrupoO")
1250:         BINDEVENT(THIS.txt_4c_CContaO,       "DblClick", THIS, "DblClickCContaO")
1251:         BINDEVENT(THIS.txt_4c__cd_dep_grupo, "DblClick", THIS, "DblClickCdDepGrupo")
1252:         BINDEVENT(THIS.txt_4c__cd_dep_conta, "DblClick", THIS, "DblClickCdDepConta")
1253:     ENDPROC
1254: 
1255:     *==========================================================================
1256:     * MUDARTIPORE - InteractiveChange do cbo_4c_GetTipoRel
1257:     * Exibe obj_4c_Opt_Bons somente quando operacao=BONS (ListIndex=4)
1258:     *==========================================================================
1259:     PROCEDURE MudarTipoRel()
1260:         IF PEMSTATUS(THIS, "obj_4c_Opt_Bons", 5)
1261:             THIS.obj_4c_Opt_Bons.Visible = (THIS.cbo_4c_GetTipoRel.ListIndex = 4)
1262:         ENDIF
1263:     ENDPROC
1264: 
1265:     *==========================================================================
1266:     * TECLA* - Handlers de KeyPress (PUBLIC para BINDEVENT)
1267:     * F4=115 / F5=116 abrem lookup; Enter=13 / Tab=9 validam codigo
1268:     *==========================================================================
1269:     PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1270:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
1271:             THIS.AbrirLookupEmpresa()
1272:         ENDIF
1273:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1274:             THIS.ValidarCdEmpresa()
1275:         ENDIF
1276:     ENDPROC
1277: 
1278:     PROCEDURE TeclaDsEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1279:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
1280:             THIS.AbrirLookupEmpresa()
1281:         ENDIF
1282:     ENDPROC
1283: 
1284:     PROCEDURE TeclaCdEmiGrupo(par_nKeyCode, par_nShiftAltCtrl)
1285:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
1286:             THIS.AbrirLookupGrupo("txt_4c__cd_emi_grupo", "txt_4c__ds_emi_grupo", ;
1287:                 "txt_4c__cd_emi_conta", "txt_4c__ds_emi_conta", "Emissor")
1288:         ENDIF
1289:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1290:             THIS.ValidarCdGrupo("txt_4c__cd_emi_grupo", "txt_4c__ds_emi_grupo", ;
1291:                 "txt_4c__cd_emi_conta", "txt_4c__ds_emi_conta")
1292:         ENDIF
1293:     ENDPROC
1294: 
1295:     PROCEDURE TeclaDsEmiGrupo(par_nKeyCode, par_nShiftAltCtrl)
1296:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
1297:             THIS.AbrirLookupGrupo("txt_4c__cd_emi_grupo", "txt_4c__ds_emi_grupo", ;
1298:                 "txt_4c__cd_emi_conta", "txt_4c__ds_emi_conta", "Emissor")
1299:         ENDIF
1300:     ENDPROC
1301: 
1302:     PROCEDURE TeclaCdEmiConta(par_nKeyCode, par_nShiftAltCtrl)
1303:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
1304:             THIS.AbrirLookupConta("txt_4c__cd_emi_grupo", "txt_4c__cd_emi_conta", ;
1305:                 "txt_4c__ds_emi_conta", "Conta Emissor")
1306:         ENDIF
1307:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1308:             THIS.ValidarCdConta("txt_4c__cd_emi_grupo", "txt_4c__cd_emi_conta", ;
1309:                 "txt_4c__ds_emi_conta")
1310:         ENDIF
1311:     ENDPROC
1312: 
1313:     PROCEDURE TeclaDsEmiConta(par_nKeyCode, par_nShiftAltCtrl)
1314:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
1315:             THIS.AbrirLookupConta("txt_4c__cd_emi_grupo", "txt_4c__cd_emi_conta", ;
1316:                 "txt_4c__ds_emi_conta", "Conta Emissor")
1317:         ENDIF
1318:     ENDPROC
1319: 
1320:     PROCEDURE TeclaCGrupoO(par_nKeyCode, par_nShiftAltCtrl)
1321:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
1322:             THIS.AbrirLookupGrupo("txt_4c_CGrupoO", "txt_4c_DGrupoO", ;
1323:                 "txt_4c_CContaO", "txt_4c_DContaO", "Origem")
1324:         ENDIF
1325:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1326:             THIS.ValidarCdGrupo("txt_4c_CGrupoO", "txt_4c_DGrupoO", ;
1327:                 "txt_4c_CContaO", "txt_4c_DContaO")
1328:         ENDIF
1329:     ENDPROC
1330: 
1331:     PROCEDURE TeclaDGrupoO(par_nKeyCode, par_nShiftAltCtrl)
1332:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
1333:             THIS.AbrirLookupGrupo("txt_4c_CGrupoO", "txt_4c_DGrupoO", ;
1334:                 "txt_4c_CContaO", "txt_4c_DContaO", "Origem")
1335:         ENDIF
1336:     ENDPROC
1337: 
1338:     PROCEDURE TeclaCContaO(par_nKeyCode, par_nShiftAltCtrl)
1339:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
1340:             THIS.AbrirLookupConta("txt_4c_CGrupoO", "txt_4c_CContaO", ;
1341:                 "txt_4c_DContaO", "Conta Origem")
1342:         ENDIF
1343:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1344:             THIS.ValidarCdConta("txt_4c_CGrupoO", "txt_4c_CContaO", ;
1345:                 "txt_4c_DContaO")
1346:         ENDIF
1347:     ENDPROC
1348: 
1349:     PROCEDURE TeclaDContaO(par_nKeyCode, par_nShiftAltCtrl)
1350:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
1351:             THIS.AbrirLookupConta("txt_4c_CGrupoO", "txt_4c_CContaO", ;
1352:                 "txt_4c_DContaO", "Conta Origem")
1353:         ENDIF
1354:     ENDPROC
1355: 
1356:     PROCEDURE TeclaCdDepGrupo(par_nKeyCode, par_nShiftAltCtrl)
1357:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
1358:             THIS.AbrirLookupGrupo("txt_4c__cd_dep_grupo", "txt_4c__ds_dep_grupo", ;
1359:                 "txt_4c__cd_dep_conta", "txt_4c__ds_dep_conta", "Destino")
1360:         ENDIF
1361:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1362:             THIS.ValidarCdGrupo("txt_4c__cd_dep_grupo", "txt_4c__ds_dep_grupo", ;
1363:                 "txt_4c__cd_dep_conta", "txt_4c__ds_dep_conta")
1364:         ENDIF
1365:     ENDPROC
1366: 
1367:     PROCEDURE TeclaDsDepGrupo(par_nKeyCode, par_nShiftAltCtrl)
1368:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
1369:             THIS.AbrirLookupGrupo("txt_4c__cd_dep_grupo", "txt_4c__ds_dep_grupo", ;
1370:                 "txt_4c__cd_dep_conta", "txt_4c__ds_dep_conta", "Destino")
1371:         ENDIF
1372:     ENDPROC
1373: 
1374:     PROCEDURE TeclaCdDepConta(par_nKeyCode, par_nShiftAltCtrl)
1375:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
1376:             THIS.AbrirLookupConta("txt_4c__cd_dep_grupo", "txt_4c__cd_dep_conta", ;
1377:                 "txt_4c__ds_dep_conta", "Conta Destino")
1378:         ENDIF
1379:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1380:             THIS.ValidarCdConta("txt_4c__cd_dep_grupo", "txt_4c__cd_dep_conta", ;
1381:                 "txt_4c__ds_dep_conta")
1382:         ENDIF
1383:     ENDPROC
1384: 
1385:     PROCEDURE TeclaDsDepConta(par_nKeyCode, par_nShiftAltCtrl)
1386:         IF par_nKeyCode = 115 OR par_nKeyCode = 116
1387:             THIS.AbrirLookupConta("txt_4c__cd_dep_grupo", "txt_4c__cd_dep_conta", ;
1388:                 "txt_4c__ds_dep_conta", "Conta Destino")
1389:         ENDIF
1390:     ENDPROC
1391: 
1392:     *==========================================================================
1393:     * ABRIRLOOKUPEMPRESA - Busca empresa em sigcdemp (cemps/razas)
1394:     *==========================================================================
1395:     PROTECTED PROCEDURE AbrirLookupEmpresa()
1396:         LOCAL loc_oBusca, loc_cCodAtual
1397:         loc_oBusca    = .NULL.
1398:         loc_cCodAtual = ""
1399:         TRY
1400:             IF PEMSTATUS(THIS, "txt_4c__cd_empresa", 5)
1401:                 loc_cCodAtual = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
1402:             ENDIF
1403:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1404:                 "sigcdemp", "cursor_4c_Busca", "cemps", loc_cCodAtual, ;
1405:                 "Empresa", .F., .T., "")
1406:             IF VARTYPE(loc_oBusca) != "O"
1407:                 MsgErro("Erro ao criar busca de empresa.", "AbrirLookupEmpresa")
1408:             ELSE
1409:                 loc_oBusca.mAddColuna("cemps", "C" + CHR(243) + "digo", 50)
1410:                 loc_oBusca.mAddColuna("razas", "Descri" + CHR(231) + CHR(227) + "o", 200)
1411:                 IF !loc_oBusca.this_lAchouRegistro
1412:                     loc_oBusca.Show()
1413:                 ENDIF
1414:                 IF loc_oBusca.this_lSelecionou
1415:                     IF USED("cursor_4c_Busca")
1416:                         SELECT cursor_4c_Busca
1417:                         THIS.txt_4c__cd_empresa.Value = ALLTRIM(cemps)
1418:                         THIS.txt_4c__ds_empresa.Value = ALLTRIM(razas)
1419:                     ENDIF
1420:                 ENDIF
1421:                 loc_oBusca = .NULL.
1422:             ENDIF
1423:         CATCH TO loc_oErro
1424:             MsgErro(loc_oErro.Message, "AbrirLookupEmpresa")
1425:         ENDTRY
1426:     ENDPROC
1427: 
1428:     *==========================================================================
1429:     * VALIDARCDEMPRESA - Valida codigo digitado contra sigcdemp
1430:     *==========================================================================
1431:     PROTECTED PROCEDURE ValidarCdEmpresa()
1432:         LOCAL loc_cCod, loc_cDs, loc_nCount, loc_cSQL, loc_lEncontrou
1433:         loc_cCod       = ""
1434:         loc_cDs        = ""
1435:         loc_lEncontrou = .F.
1436:         TRY
1437:             IF PEMSTATUS(THIS, "txt_4c__cd_empresa", 5)
1438:                 loc_cCod = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
1439:                 IF !EMPTY(loc_cCod)
1440:                     loc_cSQL   = "SELECT razas FROM sigcdemp WHERE cemps = " + EscaparSQL(loc_cCod)
1441:                     loc_nCount = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Valid")
1442:                     IF loc_nCount > 0 AND USED("cursor_4c_Valid")
1443:                         IF RECCOUNT("cursor_4c_Valid") > 0
1444:                             SELECT cursor_4c_Valid
1445:                             loc_cDs        = ALLTRIM(razas)
1446:                             loc_lEncontrou = .T.
1447:                         ENDIF
1448:                         USE IN cursor_4c_Valid
1449:                     ENDIF
1450:                     IF loc_lEncontrou
1451:                         THIS.txt_4c__ds_empresa.Value = loc_cDs
1452:                     ELSE
1453:                         THIS.txt_4c__ds_empresa.Value = ""
1454:                         THIS.AbrirLookupEmpresa()
1455:                     ENDIF
1456:                 ELSE
1457:                     THIS.txt_4c__ds_empresa.Value = ""
1458:                 ENDIF
1459:             ENDIF
1460:         CATCH TO loc_oErro
1461:             MsgErro(loc_oErro.Message, "ValidarCdEmpresa")
1462:         ENDTRY
1463:     ENDPROC
1464: 
1465:     *==========================================================================
1466:     * ABRIRLOOKUPGRUPO - Busca grupo em SigCdGcr (codigos/descrs)
1467:     * Generico para emissor, origem e destino
1468:     * Ao selecionar, limpa os campos de conta associados
1469:     *==========================================================================
1470:     PROTECTED PROCEDURE AbrirLookupGrupo(par_cCtrlCd, par_cCtrlDs, par_cCtrlCdConta, par_cCtrlDsConta, par_cTitulo)
1471:         LOCAL loc_oBusca, loc_cCodAtual
1472:         LOCAL loc_oCtrlCd, loc_oCtrlDs, loc_oCtrlCdConta, loc_oCtrlDsConta
1473:         loc_oBusca    = .NULL.
1474:         loc_cCodAtual = ""
1475:         TRY
1476:             loc_oCtrlCd      = EVALUATE("THIS." + par_cCtrlCd)
1477:             loc_oCtrlDs      = EVALUATE("THIS." + par_cCtrlDs)
1478:             loc_oCtrlCdConta = EVALUATE("THIS." + par_cCtrlCdConta)
1479:             loc_oCtrlDsConta = EVALUATE("THIS." + par_cCtrlDsConta)
1480:             loc_cCodAtual    = ALLTRIM(loc_oCtrlCd.Value)
1481:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1482:                 "SigCdGcr", "cursor_4c_Busca", "codigos", loc_cCodAtual, ;
1483:                 par_cTitulo, .F., .T., "")
1484:             IF VARTYPE(loc_oBusca) != "O"
1485:                 MsgErro("Erro ao criar busca de grupo.", "AbrirLookupGrupo")
1486:             ELSE
1487:                 loc_oBusca.mAddColuna("codigos", "C" + CHR(243) + "digo", 80)
1488:                 loc_oBusca.mAddColuna("descrs",  "Descri" + CHR(231) + CHR(227) + "o", 200)
1489:                 IF !loc_oBusca.this_lAchouRegistro
1490:                     loc_oBusca.Show()
1491:                 ENDIF
1492:                 IF loc_oBusca.this_lSelecionou
1493:                     IF USED("cursor_4c_Busca")
1494:                         SELECT cursor_4c_Busca
1495:                         loc_oCtrlCd.Value      = ALLTRIM(codigos)
1496:                         loc_oCtrlDs.Value      = ALLTRIM(descrs)
1497:                         loc_oCtrlCdConta.Value = ""
1498:                         loc_oCtrlDsConta.Value = ""
1499:                     ENDIF
1500:                 ENDIF
1501:                 loc_oBusca = .NULL.
1502:             ENDIF
1503:         CATCH TO loc_oErro
1504:             MsgErro(loc_oErro.Message, "AbrirLookupGrupo")
1505:         ENDTRY
1506:     ENDPROC
1507: 
1508:     *==========================================================================
1509:     * VALIDARCDGRUPO - Valida codigo de grupo digitado contra SigCdGcr
1510:     * Generico para emissor, origem e destino
1511:     *==========================================================================
1512:     PROTECTED PROCEDURE ValidarCdGrupo(par_cCtrlCd, par_cCtrlDs, par_cCtrlCdConta, par_cCtrlDsConta)
1513:         LOCAL loc_oCtrlCd, loc_oCtrlDs, loc_oCtrlCdConta, loc_oCtrlDsConta
1514:         LOCAL loc_cCod, loc_cDs, loc_nCount, loc_cSQL, loc_lEncontrou
1515:         loc_cCod       = ""
1516:         loc_cDs        = ""
1517:         loc_lEncontrou = .F.
1518:         TRY
1519:             loc_oCtrlCd      = EVALUATE("THIS." + par_cCtrlCd)
1520:             loc_oCtrlDs      = EVALUATE("THIS." + par_cCtrlDs)
1521:             loc_oCtrlCdConta = EVALUATE("THIS." + par_cCtrlCdConta)
1522:             loc_oCtrlDsConta = EVALUATE("THIS." + par_cCtrlDsConta)
1523:             loc_cCod         = ALLTRIM(loc_oCtrlCd.Value)
1524:             IF !EMPTY(loc_cCod)
1525:                 loc_cSQL   = "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod)
1526:                 loc_nCount = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Valid")
1527:                 IF loc_nCount > 0 AND USED("cursor_4c_Valid")
1528:                     IF RECCOUNT("cursor_4c_Valid") > 0
1529:                         SELECT cursor_4c_Valid
1530:                         loc_cDs        = ALLTRIM(descrs)
1531:                         loc_lEncontrou = .T.
1532:                     ENDIF
1533:                     USE IN cursor_4c_Valid
1534:                 ENDIF
1535:                 IF loc_lEncontrou
1536:                     loc_oCtrlDs.Value = loc_cDs
1537:                 ELSE
1538:                     loc_oCtrlDs.Value      = ""
1539:                     loc_oCtrlCdConta.Value = ""
1540:                     loc_oCtrlDsConta.Value = ""
1541:                     THIS.AbrirLookupGrupo(par_cCtrlCd, par_cCtrlDs, par_cCtrlCdConta, par_cCtrlDsConta, "Grupo")
1542:                 ENDIF
1543:             ELSE
1544:                 loc_oCtrlDs.Value      = ""
1545:                 loc_oCtrlCdConta.Value = ""
1546:                 loc_oCtrlDsConta.Value = ""
1547:             ENDIF
1548:         CATCH TO loc_oErro
1549:             MsgErro(loc_oErro.Message, "ValidarCdGrupo")
1550:         ENDTRY
1551:     ENDPROC
1552: 
1553:     *==========================================================================
1554:     * ABRIRLOOKUPCO NTA - Busca conta em SigCdCli (iclis/rclis)
1555:     * Filtra por grupo via 9o parametro do FormBuscaAuxiliar (par_cFiltro)
1556:     * Generico para emissor, origem e destino
1557:     *==========================================================================
1558:     PROTECTED PROCEDURE AbrirLookupConta(par_cCtrlGrupo, par_cCtrlCd, par_cCtrlDs, par_cTitulo)
1559:         LOCAL loc_oBusca, loc_cCodAtual, loc_cGrupo, loc_cFiltro
1560:         LOCAL loc_oCtrlGrupo, loc_oCtrlCd, loc_oCtrlDs
1561:         loc_oBusca    = .NULL.
1562:         loc_cCodAtual = ""
1563:         loc_cGrupo    = ""
1564:         loc_cFiltro   = ""
1565:         TRY
1566:             loc_oCtrlGrupo = EVALUATE("THIS." + par_cCtrlGrupo)
1567:             loc_oCtrlCd    = EVALUATE("THIS." + par_cCtrlCd)
1568:             loc_oCtrlDs    = EVALUATE("THIS." + par_cCtrlDs)
1569:             loc_cGrupo     = ALLTRIM(loc_oCtrlGrupo.Value)
1570:             loc_cCodAtual  = ALLTRIM(loc_oCtrlCd.Value)
1571:             IF !EMPTY(loc_cGrupo)
1572:                 loc_cFiltro = "grupos = " + EscaparSQL(loc_cGrupo)
1573:             ENDIF
1574:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1575:                 "SigCdCli", "cursor_4c_Busca", "iclis", loc_cCodAtual, ;
1576:                 par_cTitulo, .F., .T., loc_cFiltro)
1577:             IF VARTYPE(loc_oBusca) != "O"
1578:                 MsgErro("Erro ao criar busca de conta.", "AbrirLookupConta")
1579:             ELSE
1580:                 loc_oBusca.mAddColuna("iclis", "C" + CHR(243) + "digo", 80)
1581:                 loc_oBusca.mAddColuna("rclis", "Descri" + CHR(231) + CHR(227) + "o", 200)
1582:                 IF !loc_oBusca.this_lAchouRegistro
1583:                     loc_oBusca.Show()
1584:                 ENDIF
1585:                 IF loc_oBusca.this_lSelecionou
1586:                     IF USED("cursor_4c_Busca")
1587:                         SELECT cursor_4c_Busca
1588:                         loc_oCtrlCd.Value = ALLTRIM(iclis)
1589:                         loc_oCtrlDs.Value = ALLTRIM(rclis)
1590:                     ENDIF
1591:                 ENDIF
1592:                 loc_oBusca = .NULL.
1593:             ENDIF
1594:         CATCH TO loc_oErro
1595:             MsgErro(loc_oErro.Message, "AbrirLookupConta")
1596:         ENDTRY
1597:     ENDPROC
1598: 
1599:     *==========================================================================
1600:     * DBLCLICK* - Handlers de DblClick nos campos de codigo (PUBLIC para BINDEVENT)
1601:     * Abrem o lookup correspondente, mesmo comportamento que F4/F5
1602:     *==========================================================================
1603:     PROCEDURE DblClickCdEmpresa()
1604:         THIS.AbrirLookupEmpresa()
1605:     ENDPROC
1606: 
1607:     PROCEDURE DblClickCdEmiGrupo()
1608:         THIS.AbrirLookupGrupo("txt_4c__cd_emi_grupo", "txt_4c__ds_emi_grupo", ;
1609:             "txt_4c__cd_emi_conta", "txt_4c__ds_emi_conta", "Emissor")
1610:     ENDPROC
1611: 
1612:     PROCEDURE DblClickCdEmiConta()
1613:         THIS.AbrirLookupConta("txt_4c__cd_emi_grupo", "txt_4c__cd_emi_conta", ;
1614:             "txt_4c__ds_emi_conta", "Conta Emissor")
1615:     ENDPROC
1616: 
1617:     PROCEDURE DblClickCGrupoO()
1618:         THIS.AbrirLookupGrupo("txt_4c_CGrupoO", "txt_4c_DGrupoO", ;
1619:             "txt_4c_CContaO", "txt_4c_DContaO", "Origem")
1620:     ENDPROC
1621: 
1622:     PROCEDURE DblClickCContaO()
1623:         THIS.AbrirLookupConta("txt_4c_CGrupoO", "txt_4c_CContaO", ;
1624:             "txt_4c_DContaO", "Conta Origem")
1625:     ENDPROC
1626: 
1627:     PROCEDURE DblClickCdDepGrupo()
1628:         THIS.AbrirLookupGrupo("txt_4c__cd_dep_grupo", "txt_4c__ds_dep_grupo", ;
1629:             "txt_4c__cd_dep_conta", "txt_4c__ds_dep_conta", "Destino")
1630:     ENDPROC
1631: 
1632:     PROCEDURE DblClickCdDepConta()
1633:         THIS.AbrirLookupConta("txt_4c__cd_dep_grupo", "txt_4c__cd_dep_conta", ;
1634:             "txt_4c__ds_dep_conta", "Conta Destino")
1635:     ENDPROC
1636: 
1637:     *==========================================================================
1638:     * BTNSALVARCLICK - Mapeia "Salvar" de CRUD para Imprimir em REPORT
1639:     *
1640:     * Forms REPORT (frmrelatorio) nao tem operacao Salvar - o "resultado" do
1641:     * formulario eh o relatorio impresso. Delegamos para o fluxo de impressao,
1642:     * que monta os filtros (FormParaRelatorio) e dispara o REPORT FORM via BO.
1643:     *==========================================================================
1644:     PROCEDURE BtnSalvarClick()
1645:         THIS.BtnImprimirClick()
1646:     ENDPROC
1647: 
1648:     *==========================================================================
1649:     * FORMPARABO - Wrapper de FormParaRelatorio (CRUD -> REPORT semantica)
1650:     *
1651:     * Em forms CRUD, FormParaBO transfere valores do form para o BusinessObject.
1652:     * Em forms REPORT, o equivalente eh FormParaRelatorio (transfere filtros
1653:     * para o RelatorioBase). Mantemos o contrato CRUD delegando para o metodo
1654:     * de REPORT que faz o trabalho real.
1655:     *==========================================================================
1656:     PROCEDURE FormParaBO()
1657:         THIS.FormParaRelatorio()
1658:     ENDPROC
1659: 
1660:     *==========================================================================
1661:     * BOPARAFORM - Em REPORT, restaura tela de filtros para estado padrao
1662:     *
1663:     * Forms CRUD usam BOParaForm para carregar valores do BO nos controles
1664:     * apos um Buscar. Forms REPORT nao tem registro persistido nem operacao
1665:     * de Buscar; o equivalente conceitual eh "voltar a tela de filtros ao
1666:     * estado padrao" - delegamos para LimparCampos + AtualizarTitulosOpcao.
1667:     *==========================================================================
1668:     PROCEDURE BOParaForm()
1669:         TRY
1670:             THIS.LimparCampos()
1671:             THIS.AtualizarTitulosOpcao()
1672:         CATCH TO loc_oErro
1673:             MsgErro(loc_oErro.Message, "BOParaForm")
1674:         ENDTRY
1675:     ENDPROC
1676: 
1677:     *==========================================================================
1678:     * CARREGARLISTA - Em REPORT, configura a tela de filtros (sem grid de lista)
1679:     *
1680:     * Forms CRUD usam CarregarLista para popular o grid de Page1 a partir de
1681:     * Buscar() no BO. Forms REPORT nao tem grid de lista - a "lista" conceitual
1682:     * eh a propria area de filtros que o usuario preenche para gerar o relatorio.
1683:     * Este metodo eh mantido para compatibilidade com chamadas genericas do
1684:     * FormBase e delega para ConfigurarPaginaLista (reset de filtros + foco).
1685:     *==========================================================================
1686:     PROCEDURE CarregarLista()
1687:         THIS.ConfigurarPaginaLista()
1688:         RETURN .T.
1689:     ENDPROC
1690: 
1691:     *==========================================================================
1692:     * VALIDARCDCONTA - Valida codigo de conta digitado contra SigCdCli
1693:     * Filtra por grupo quando preenchido; generico para emissor, origem, destino
1694:     *==========================================================================
1695:     PROTECTED PROCEDURE ValidarCdConta(par_cCtrlGrupo, par_cCtrlCd, par_cCtrlDs)
1696:         LOCAL loc_oCtrlGrupo, loc_oCtrlCd, loc_oCtrlDs
1697:         LOCAL loc_cCod, loc_cGrupo, loc_cDs, loc_nCount, loc_cSQL, loc_lEncontrou
1698:         loc_cCod       = ""
1699:         loc_cGrupo     = ""
1700:         loc_cDs        = ""
1701:         loc_lEncontrou = .F.
1702:         TRY
1703:             loc_oCtrlGrupo = EVALUATE("THIS." + par_cCtrlGrupo)
1704:             loc_oCtrlCd    = EVALUATE("THIS." + par_cCtrlCd)
1705:             loc_oCtrlDs    = EVALUATE("THIS." + par_cCtrlDs)
1706:             loc_cCod       = ALLTRIM(loc_oCtrlCd.Value)
1707:             loc_cGrupo     = ALLTRIM(loc_oCtrlGrupo.Value)
1708:             IF !EMPTY(loc_cCod)
1709:                 loc_cSQL = "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCod)
1710:                 IF !EMPTY(loc_cGrupo)
1711:                     loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
1712:                 ENDIF
1713:                 loc_nCount = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Valid")
1714:                 IF loc_nCount > 0 AND USED("cursor_4c_Valid")
1715:                     IF RECCOUNT("cursor_4c_Valid") > 0
1716:                         SELECT cursor_4c_Valid
1717:                         loc_cDs        = ALLTRIM(rclis)
1718:                         loc_lEncontrou = .T.
1719:                     ENDIF
1720:                     USE IN cursor_4c_Valid
1721:                 ENDIF
1722:                 IF loc_lEncontrou
1723:                     loc_oCtrlDs.Value = loc_cDs
1724:                 ELSE
1725:                     loc_oCtrlDs.Value = ""
1726:                     THIS.AbrirLookupConta(par_cCtrlGrupo, par_cCtrlCd, par_cCtrlDs, "Conta")
1727:                 ENDIF
1728:             ELSE
1729:                 loc_oCtrlDs.Value = ""
1730:             ENDIF
1731:         CATCH TO loc_oErro
1732:             MsgErro(loc_oErro.Message, "ValidarCdConta")
1733:         ENDTRY
1734:     ENDPROC
1735: 


### BO (C:\4c\projeto\app\classes\sigrecrtBO.prg):
*==============================================================================
* SIGRECRTBO.PRG
* Business Object para Relatorio de Cheques Da Carteira (SIGRECRT)
* Herda de RelatorioBase
*
* Filtros:
*   - Tipo de data: 1=Vencimento, 2=Emissao
*   - Periodo (data inicial / data final)
*   - Empresa (codigo + descricao)
*   - Tipo de relatorio: 1=Ativos, 2=Baixados, 3=Neg.PG, 4=Bons, 5=Devolvidos
*   - Opcao nota: 1=Sim, 2=Nao, 3=Ambos
*   - Ordem: 1=VALOR, 2=DATA VENCIMENTO, 3=DATA OPERACAO
*   - Juros mensal (%)
*   - Opcao Bons: 1=Ativos, 2=Todos (visivel apenas em TipoRel=4)
*   - Emissor (grupo/conta)
*   - Origem (grupo/conta)
*   - Destino (grupo/conta)
* Tabelas: SigCcChm, SigChe, SigCdCli, SigCdOpt, SigCdPac, SigCdPam, SigCdEmp, SigCqLcm
*==============================================================================

DEFINE CLASS sigrecrtBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoFrx        = ""
    this_cTitulo            = ""

    *-- Nomes dos cursores principais
    this_cCursorDados       = "CsRelatorio"
    this_cCursorCabecalho   = "CsCabecalho"
    this_cCursorOperacoes   = "cursor_4c_SigCdOpt"

    *-- Filtro: tipo de data (1=Vencimento, 2=Emissao)
    this_nTipoDat           = 1

    *-- Filtro: periodo
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtro: empresa (get_cd_empresa / get_ds_empresa)
    this_cCdEmpresa         = ""
    this_cDsEmpresa         = ""

    *-- Filtro: tipo relatorio (GetTipoRel.ListIndex)
    *-- 1=Ativos, 2=Baixados, 3=Neg.PG, 4=Bons, 5=Devolvidos
    this_nTipoRel           = 1

    *-- Filtro: opcao nota (opt_nr_opcao.Value): 1=Sim, 2=Nao, 3=Ambos
    this_nNrOpcao           = 3

    *-- Titulos dinamicos carregados de SigCdPac (captions do opt_nr_opcao)
    this_cTituloOpcao1      = "Sim"
    this_cTituloOpcao2      = "N" + CHR(227) + "o"
    this_cTituloOpcao3      = "Ambos"

    *-- Filtro: ordem de classificacao (get_ordem.ListIndex)
    *-- 1=VALOR, 2=DATA VENCIMENTO, 3=DATA OPERACAO
    this_nIndexOrdem        = 1

    *-- Filtro: taxa de juros mensal %
    this_nJuros             = 0

    *-- Filtro: opcao bons (Opt_Bons.Value): 1=Ativos, 2=Todos
    this_nOptBons           = 1

    *-- Tipo de juros de SigCdPam.JuroCarts: 1=Simples, 2=Compostos
    this_nJurosCarts        = 1

    *-- Filtro emissor/carteira
    this_cCdEmiGrupo        = ""
    this_cDsEmiGrupo        = ""
    this_cCdEmiConta        = ""
    this_cDsEmiConta        = ""

    *-- Filtro origem
    this_cCdOriGrupo        = ""
    this_cDsOriGrupo        = ""
    this_cCdOriConta        = ""
    this_cDsOriConta        = ""

    *-- Filtro destino/deposito
    this_cCdDesGrupo        = ""
    this_cDsDesGrupo        = ""
    this_cCdDesConta        = ""
    this_cDsDesConta        = ""

    *--------------------------------------------------------------------------
    * Init - Configura FRX, titulo, datas iniciais e carrega parametros auxiliares
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cArquivoFrx = gc_4c_CaminhoReports + "SigReCrt.frx"
            THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Cheques Da Carteira"
            THIS.this_dDtInicial  = DATE()
            THIS.this_dDtFinal    = DATE()
            IF DODEFAULT()
                loc_lSucesso = THIS.CarregarParametros()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega SigCdOpt (indexado), SigCdPac e SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Operacoes de cheque: necessario para filtros de tipo no PrepararDados
            loc_cSQL = "SELECT * FROM SigCdOpt"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpt")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar SigCdOpt"
            ELSE
                SELECT cursor_4c_SigCdOpt
                INDEX ON operacaos TAG operacaos
                GO TOP

                *-- Titulos das opcoes de nota (SigCdPac)
                loc_cSQL = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac")
                IF loc_nResult > 0
                    SELECT cursor_4c_SigCdPac
                    GO TOP
                    THIS.this_cTituloOpcao1 = IIF(!EMPTY(ALLTRIM(TitOpcS)), ALLTRIM(TitOpcS), "Sim")
                    THIS.this_cTituloOpcao2 = IIF(!EMPTY(ALLTRIM(TitOpcN)), ALLTRIM(TitOpcN), "N" + CHR(227) + "o")
                    THIS.this_cTituloOpcao3 = IIF(!EMPTY(ALLTRIM(TitOpcA)), ALLTRIM(TitOpcA), "Ambos")
                    USE IN cursor_4c_SigCdPac
                ENDIF

                *-- Parametros de juros (SigCdPam.JuroCarts: 1=Simples, 2=Compostos)
                loc_cSQL = "SELECT JuroCarts FROM SigCdPam"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam")
                IF loc_nResult > 0
                    SELECT cursor_4c_SigCdPam
                    GO TOP
                    THIS.this_nJurosCarts = IIF(!EOF(), NVL(JuroCarts, 1), 1)
                    USE IN cursor_4c_SigCdPam
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.CarregarParametros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros, executa e popula CsRelatorio/CsCabecalho
    * Replica o processamento() do form legado SIGRECRT
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro, loc_lOK
        LOCAL loc_nTipoDat, loc_dDtInicial, loc_dDtFinal
        LOCAL loc_cCdEmpresa, loc_cDsEmpresa, loc_nNrOpcao
        LOCAL loc_cCdEmiGrupo, loc_cDsEmiGrupo, loc_cCdEmiConta, loc_cDsEmiConta
        LOCAL loc_cCdOriGrupo, loc_cDsOriGrupo, loc_cCdOriConta, loc_cDsOriConta
        LOCAL loc_cCdDesGrupo, loc_cDsDesGrupo, loc_cCdDesConta, loc_cDsDesConta
        LOCAL loc_nTipoRel, loc_nJuros, loc_nIndexOrdem, loc_nOptBons
        LOCAL loc_cVerData, loc_cVerEmpresa, loc_cVerOpcao
        LOCAL loc_cVerEmiGrupo, loc_cVerEmiConta
        LOCAL loc_cVerOriGrupo, loc_cVerOriConta
        LOCAL loc_cVerDesGrupo, loc_cVerDesConta
        LOCAL loc_cVerOrdem, loc_cVerTipo
        LOCAL loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, loc_cEmissor, loc_cDestino, loc_cOrigem
        LOCAL loc_cTipoD, loc_cSQL, loc_nResult
        LOCAL loc_nDias, loc_nTxDia, loc_nVJuros, loc_dVen, loc_dDat

        loc_lSucesso = .F.
        TRY
            loc_lOK = .T.

            *-- Copiar filtros das propriedades para variaveis locais
            *-- (necessario: ?var em SQLEXEC exige variaveis no escopo local/private)
            loc_nTipoDat    = THIS.this_nTipoDat
            loc_dDtInicial  = THIS.this_dDtInicial
            loc_dDtFinal    = THIS.this_dDtFinal
            loc_cCdEmpresa  = THIS.this_cCdEmpresa
            loc_cDsEmpresa  = THIS.this_cDsEmpresa
            loc_nNrOpcao    = THIS.this_nNrOpcao
            loc_cCdEmiGrupo = THIS.this_cCdEmiGrupo
            loc_cDsEmiGrupo = THIS.this_cDsEmiGrupo
            loc_cCdEmiConta = THIS.this_cCdEmiConta
            loc_cDsEmiConta = THIS.this_cDsEmiConta
            loc_cCdOriGrupo = THIS.this_cCdOriGrupo
            loc_cDsOriGrupo = THIS.this_cDsOriGrupo
            loc_cCdOriConta = THIS.this_cCdOriConta
            loc_cDsOriConta = THIS.this_cDsOriConta
            loc_cCdDesGrupo = THIS.this_cCdDesGrupo
            loc_cDsDesGrupo = THIS.this_cDsDesGrupo
            loc_cCdDesConta = THIS.this_cCdDesConta
            loc_cDsDesConta = THIS.this_cDsDesConta
            loc_nTipoRel    = THIS.this_nTipoRel
            loc_nJuros      = THIS.this_nJuros
            loc_nIndexOrdem = THIS.this_nIndexOrdem
            loc_nOptBons    = THIS.this_nOptBons

            *-- Clausulas WHERE para SQLEXEC (usa ?var para parametrizacao de data/string)
            loc_cVerData = IIF(loc_nTipoDat = 2, ;
                " and b.datas between ?loc_dDtInicial and ?loc_dDtFinal ", ;
                " and b.vencs between ?loc_dDtInicial and ?loc_dDtFinal ")
            loc_cVerEmpresa  = IIF(EMPTY(ALLTRIM(loc_cCdEmpresa)), "", ;
                                   " and a.emps = ?loc_cCdEmpresa ")
            loc_cVerOpcao    = IIF(loc_nNrOpcao = 1, ;
                                   " and not a.notas = '" + SPACE(6) + "' ", ;
                                   IIF(loc_nNrOpcao = 2, ;
                                       " and a.notas = '" + SPACE(6) + "' ", ;
                                       ""))
            loc_cVerEmiGrupo = IIF(EMPTY(ALLTRIM(loc_cCdEmiGrupo)), "", ;
                                   " and b.grupoT = ?loc_cCdEmiGrupo ")
            loc_cVerEmiConta = IIF(EMPTY(ALLTRIM(loc_cCdEmiConta)), "", ;
                                   " and b.contaT = ?loc_cCdEmiConta ")
            loc_cVerOriGrupo = IIF(EMPTY(ALLTRIM(loc_cCdOriGrupo)), "", ;
                                   " and e.grupoOs = ?loc_cCdOriGrupo ")
            loc_cVerOriConta = IIF(EMPTY(ALLTRIM(loc_cCdOriConta)), "", ;
                                   " and e.contaOs = ?loc_cCdOriConta ")
            loc_cVerDesGrupo = IIF(EMPTY(ALLTRIM(loc_cCdDesGrupo)), "", ;
                                   " and e.grupoDs = ?loc_cCdDesGrupo ")
            loc_cVerDesConta = IIF(EMPTY(ALLTRIM(loc_cCdDesConta)), "", ;
                                   " and e.contaDs = ?loc_cCdDesConta ")
            loc_cVerOrdem    = IIF(loc_nIndexOrdem = 1, " ORDER BY 2", ;
                                IIF(loc_nIndexOrdem = 2, " ORDER BY 3", " ORDER BY 4"))

            *-- Filtro de tipo de relatorio: subselects em cursor_4c_SigCdOpt (VFP local)
            DO CASE
            CASE loc_nTipoRel = 2
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where tipos='CR' and devolvidos = 'N'] + ;
                               [ and opants not in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where tipos='DB' and devolvidos = 'S'))]
            CASE loc_nTipoRel = 3
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where tipos='DB' and devolvidos = 'S')]
            CASE loc_nTipoRel = 4
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where devolvidos <> 'S' and ] + ;
                               IIF(loc_nOptBons = 1, [tipos='DB' And Ordens = 1], [0 = 0]) + [)]
                loc_cVerTipo = loc_cVerTipo + ;
                               [ and a.contat Not in(Select Iclis from cursor_4c_CliCqDev)]
            CASE loc_nTipoRel = 5
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where devolvidos = 'S')]
            OTHERWISE
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where tipos='DB' and devolvidos = 'N')]
            ENDCASE

            *-- Clientes com cheque devolvido (necessario para filtro tipo 4 - Bons)
            IF USED("cursor_4c_CliCqDev")
                USE IN cursor_4c_CliCqDev
            ENDIF
            loc_cSQL = "select distinct contat as iclis from sigche" + ;
                       " where umovs in (Select operacaos from SigCdOpt where devolvidos = 'S')"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliCqDev")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar lista de cheques devolvidos"
                loc_lOK = .F.
            ENDIF

            *-- Query principal: cheques com joins em clientes, lancamentos e movimentacoes
            IF loc_lOK
                IF USED("cursor_4c_SqlTmp0")
                    USE IN cursor_4c_SqlTmp0
                ENDIF
                loc_cSQL = "select a.nums, b.valors, b.vencs, b.datas as dtBai, b.datas as dtEmi," + ;
                           " b.grclis, b.iclis, c.rclis as rclisT, d.rclis as rclisO, f.rclis as rclisD," + ;
                           " b.bancos, b.agencias, b.ncontas, b.ncheques, a.numlotes," + ;
                           " b.emps, b.umovs, e.codigos, b.contat, b.grupot, a.valjuros, a.cotas" + ;
                           " from SigCcChm a left join sigcdcli c" + ;
                           " on a.grupot = c.grupos and a.contat = c.iclis," + ;
                           " SigChe b, sigcdcli d, SigCqLcm e, sigcdcli f" + ;
                           " where a.nums = b.nums" + ;
                           " and a.numlotes = e.numlotes" + ;
                           " and b.umovs = e.codigos" + ;
                           " and e.grupoos = d.grupos and e.contaos = d.iclis" + ;
                           " and e.grupods = f.grupos and e.contads = f.iclis" + ;
                           loc_cVerData + loc_cVerEmpresa + loc_cVerOpcao + ;
                           loc_cVerEmiGrupo + loc_cVerEmiConta + ;
                           loc_cVerOriGrupo + loc_cVerOriConta + ;
                           loc_cVerDesGrupo + loc_cVerDesConta + ;
                           " Order by a.nums, a.numlotes, b.datas, b.grclis, b.iclis," + ;
                           " b.vencs, b.bancos, b.agencias, b.ncontas, b.ncheques," + ;
                           " b.valors, b.emps, b.umovs"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlTmp0")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar dados de cheques da carteira"
                    loc_lOK = .F.
                ENDIF
            ENDIF

            IF loc_lOK
                *-- Aplicar filtro de tipo via SELECT local VFP
                *-- (cursor_4c_SigCdOpt e cursor_4c_CliCqDev sao referenciados como VFP aliases)
                IF USED("CsRelatorio")
                    USE IN CsRelatorio
                ENDIF
                SELECT *, 0000000.00 AS cotasE, 0000000.00 AS valsai, 0000000.00 AS valent, ;
                       0000000.00 AS Dif, 0000000.00 AS valliq, SPACE(50) AS NomeCF ;
                    FROM cursor_4c_SqlTmp0 a WHERE 1=1 &loc_cVerTipo ;
                    INTO CURSOR CsRelatorio &loc_cVerOrdem. READWRITE

                *-- Buscar nome da empresa para o cabecalho
                loc_cNomeEmpresa = ""
                loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE cEmps = " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdEmp")
                IF loc_nResult > 0
                    SELECT cursor_4c_SigCdEmp
                    GO TOP
                    IF !EOF()
                        loc_cNomeEmpresa = ALLTRIM(Razas)
                    ENDIF
                    USE IN cursor_4c_SigCdEmp
                ENDIF

                *-- Textos do cabecalho do relatorio
                loc_cTipoD = IIF(loc_nTipoDat = 1, "VENCIMENTO", "EMISSAO")
                DO CASE
                CASE loc_nTipoRel = 1
                    loc_cTitulo = "ATIVOS POR " + loc_cTipoD
                CASE loc_nTipoRel = 2
                    loc_cTitulo = "BAIXADOS POR " + loc_cTipoD
                CASE loc_nTipoRel = 3
                    loc_cTitulo = "NEG.PG"
                CASE loc_nTipoRel = 4
                    loc_cTitulo = "BONS"
                OTHERWISE
                    loc_cTitulo = "DEVOLVIDOS"
                ENDCASE

                loc_cPeriodo = IIF(loc_nTipoDat = 2, "Emiss" + CHR(227) + "o: ", "Vencimento: ") + ;
                               DTOC(loc_dDtInicial) + " " + CHR(224) + " " + DTOC(loc_dDtFinal) + ;
                               " - Empresa: " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdEmpresa)), "Geral", ;
                                   ALLTRIM(loc_cCdEmpresa) + " - " + ALLTRIM(loc_cDsEmpresa))
                loc_cEmissor = "Grupo/Conta Emissor  : " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdEmiGrupo)), "Todos", ;
                                   ALLTRIM(loc_cCdEmiGrupo) + " - " + ALLTRIM(loc_cDsEmiGrupo)) + ;
                               " / " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdEmiConta)), "Todas", ;
                                   ALLTRIM(loc_cCdEmiConta) + " - " + ALLTRIM(loc_cDsEmiConta))
                loc_cDestino = "Grupo/Conta Destino  : " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdDesGrupo)), "Todos", ;
                                   ALLTRIM(loc_cCdDesGrupo) + " - " + ALLTRIM(loc_cDsDesGrupo)) + ;
                               " / " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdDesConta)), "Todas", ;
                                   ALLTRIM(loc_cCdDesConta) + " - " + ALLTRIM(loc_cDsDesConta))
                loc_cOrigem  = "Grupo/Conta Origem   : " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdOriGrupo)), "Todos", ;
                                   ALLTRIM(loc_cCdOriGrupo) + " - " + ALLTRIM(loc_cDsOriGrupo)) + ;
                               " / " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdOriConta)), "Todas", ;
                                   ALLTRIM(loc_cCdOriConta) + " - " + ALLTRIM(loc_cDsOriConta))

                *-- Cursor de cabecalho para o FRX
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                CREATE CURSOR CsCabecalho (NomeEmpresa C(80), Titulo C(80), Periodo C(80), ;
                                           Operacao C(80), Emissor C(80), Destino C(80), Origem C(80))
                INSERT INTO CsCabecalho (NomeEmpresa, Titulo, Periodo, Emissor, Destino, Origem) ;
                    VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, ;
                            loc_cEmissor, loc_cDestino, loc_cOrigem)

                *-- Percorrer registros para calcular cotasE, valsai, Dif, valliq, juros
                SELECT CsRelatorio
                GO TOP
                SCAN
                    *-- Buscar cotas de entrada do cheque para calculo de diferencas
                    loc_cSQL = "select a.cotas, e.codigos from SigCcChm a, SigCqLcm e" + ;
                               " where a.numlotes = e.numlotes" + ;
                               " and a.bancos   ='" + ALLTRIM(CsRelatorio.bancos)   + "'" + ;
                               " and a.agencias ='" + ALLTRIM(CsRelatorio.agencias) + "'" + ;
                               " and a.ncontas  ='" + ALLTRIM(CsRelatorio.ncontas)  + "'" + ;
                               " and a.ncheques ='" + ALLTRIM(CsRelatorio.ncheques) + "'"
                    IF USED("cursor_4c_Cur1")
                        USE IN cursor_4c_Cur1
                    ENDIF
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cur1")

                    IF USED("cursor_4c_Cur2")
                        USE IN cursor_4c_Cur2
                    ENDIF
                    SELECT cotas FROM cursor_4c_Cur1 ;
                        WHERE codigos IN (SELECT operacaos FROM cursor_4c_SigCdOpt ;
                                          WHERE tipos = 'DB' AND devolvidos = 'N') ;
                        INTO CURSOR cursor_4c_Cur2
                    SELECT cursor_4c_Cur2
                    GO TOP
                    SELECT CsRelatorio
                    REPLACE cotasE WITH IIF(!EOF("cursor_4c_Cur2"), cursor_4c_Cur2.cotas, 1.00) ;
                        IN CsRelatorio
                    REPLACE rclisT WITH IIF(ISNULL(rclisT), "", rclisT) IN CsRelatorio
                    REPLACE NomeCF WITH IIF(INLIST(loc_nTipoRel, 1, 3), rclisO, rclisD) IN CsRelatorio

                    DO CASE
                    CASE loc_nTipoRel = 1 AND loc_nTipoDat = 2
                        REPLACE valjuros WITH 0 IN CsRelatorio
                        REPLACE valsai   WITH 0 IN CsRelatorio
                        REPLACE Dif      WITH ROUND(valors / cotas, 2) IN CsRelatorio
                        REPLACE valliq   WITH 0 IN CsRelatorio
                        REPLACE dtBai    WITH CTOD("  /  /  ") IN CsRelatorio

                    CASE loc_nTipoRel = 1 AND loc_nTipoDat = 1
                        REPLACE valsai WITH 0 IN CsRelatorio
                        REPLACE Dif    WITH ROUND(valors / cotas, 2) IN CsRelatorio
                        REPLACE valliq WITH 0 IN CsRelatorio
                        REPLACE dtBai  WITH CTOD("  /  /  ") IN CsRelatorio

                    CASE loc_nTipoRel = 2
                        REPLACE valsai WITH ROUND(valjuros / cotas, 2) IN CsRelatorio
                        REPLACE valent WITH ROUND(valjuros / cotasE, 2) IN CsRelatorio
                        REPLACE Dif    WITH valsai - valent IN CsRelatorio
                        REPLACE valliq WITH valsai + Dif IN CsRelatorio
                        REPLACE dtEmi  WITH CTOD("  /  /  ") IN CsRelatorio
                        REPLACE vencs  WITH CTOD("  /  /  ") IN CsRelatorio

                    CASE loc_nTipoRel = 4 AND loc_nOptBons = 1
                        REPLACE dtBai WITH CTOD("  /  /  ") IN CsRelatorio

                    CASE loc_nTipoRel = 4 AND loc_nOptBons = 2
                        IF SEEK(CsRelatorio.umovs, "cursor_4c_SigCdOpt", "operacaos")
                            IF cursor_4c_SigCdOpt.Ordens = 1
                                REPLACE dtBai WITH CTOD("  /  /  ")
                            ENDIF
                        ENDIF
                        SELECT CsRelatorio

                    CASE INLIST(loc_nTipoRel, 3, 5)
                        REPLACE vencs  WITH CsRelatorio.Vencs IN CsRelatorio
                        REPLACE valsai WITH ROUND(valjuros / cotas, 2) IN CsRelatorio
                        REPLACE Dif    WITH 0 IN CsRelatorio
                        REPLACE valliq WITH 0 IN CsRelatorio

                        IF loc_nJuros > 0
                            loc_dVen   = DATE()
                            loc_dDat   = TTOD(CsRelatorio.Vencs)
                            loc_nDias  = IIF(loc_dDat >= loc_dVen, 0, loc_dVen - loc_dDat)
                            loc_nTxDia = loc_nJuros / 30
                            IF THIS.this_nJurosCarts = 2
                                loc_nVJuros = ROUND(CsRelatorio.valors * ;
                                              (((1 + loc_nTxDia / 100) ^ (loc_nDias)) - 1), 2)
                            ELSE
                                loc_nVJuros = ROUND(CsRelatorio.valors * ;
                                              (loc_nJuros / 100) * (loc_nDias / 30), 2)
                            ENDIF
                            REPLACE ValJuros WITH loc_nVJuros IN CsRelatorio
                        ENDIF
                    ENDCASE
                ENDSCAN

                SELECT CsRelatorio
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                SELECT CsRelatorio
                REPORT FORM (THIS.this_cArquivoFrx) TO PRINTER PROMPT NOCONSOLE
                THIS.LimparCursores()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                SELECT CsRelatorio
                REPORT FORM (THIS.this_cArquivoFrx) PREVIEW NOCONSOLE
                THIS.LimparCursores()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave logica do relatorio (filtros aplicados)
    * Relatorios nao tem PK fisica - chave eh composta pelos filtros principais.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "SIGRECRT|" + ;
                     STR(THIS.this_nTipoDat, 1) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmpresa) + "|" + ;
                     STR(THIS.this_nTipoRel, 1) + "|" + ;
                     STR(THIS.this_nNrOpcao, 1) + "|" + ;
                     STR(THIS.this_nIndexOrdem, 1) + "|" + ;
                     STR(THIS.this_nOptBons, 1) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmiGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmiConta) + "|" + ;
                     ALLTRIM(THIS.this_cCdOriGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cCdOriConta) + "|" + ;
                     ALLTRIM(THIS.this_cCdDesGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cCdDesConta)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do relatorio a partir de cursor
    * Permite restaurar configuracao de filtros previamente salva.
    * par_cAliasCursor: alias do cursor com colunas TipoDat, DtInicial, DtFinal,
    *   CdEmpresa, DsEmpresa, TipoRel, NrOpcao, IndexOrdem, Juros, OptBons,
    *   CdEmiGrupo, DsEmiGrupo, CdEmiConta, DsEmiConta,
    *   CdOriGrupo, DsOriGrupo, CdOriConta, DsOriConta,
    *   CdDesGrupo, DsDesGrupo, CdDesConta, DsDesConta
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErr, loc_cAlias
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + ;
                                      CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                                      TRANSFORM(par_cAliasCursor)
            RETURN .F.
        ENDIF

        loc_cAlias = par_cAliasCursor

        TRY
            SELECT (loc_cAlias)
            IF !EOF()
                IF TYPE(loc_cAlias + ".TipoDat") = "N"
                    THIS.this_nTipoDat = EVALUATE(loc_cAlias + ".TipoDat")
                ENDIF
                IF TYPE(loc_cAlias + ".DtInicial") = "D"
                    THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".DtInicial")
                ENDIF
                IF TYPE(loc_cAlias + ".DtFinal") = "D"
                    THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".DtFinal")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEmpresa") = "C"
                    THIS.this_cCdEmpresa = EVALUATE(loc_cAlias + ".CdEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEmpresa") = "C"
                    THIS.this_cDsEmpresa = EVALUATE(loc_cAlias + ".DsEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".TipoRel") = "N"
                    THIS.this_nTipoRel = EVALUATE(loc_cAlias + ".TipoRel")
                ENDIF
                IF TYPE(loc_cAlias + ".NrOpcao") = "N"
                    THIS.this_nNrOpcao = EVALUATE(loc_cAlias + ".NrOpcao")
                ENDIF
                IF TYPE(loc_cAlias + ".IndexOrdem") = "N"
                    THIS.this_nIndexOrdem = EVALUATE(loc_cAlias + ".IndexOrdem")
                ENDIF
                IF TYPE(loc_cAlias + ".Juros") = "N"
                    THIS.this_nJuros = EVALUATE(loc_cAlias + ".Juros")
                ENDIF
                IF TYPE(loc_cAlias + ".OptBons") = "N"
                    THIS.this_nOptBons = EVALUATE(loc_cAlias + ".OptBons")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEmiGrupo") = "C"
                    THIS.this_cCdEmiGrupo = EVALUATE(loc_cAlias + ".CdEmiGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEmiGrupo") = "C"
                    THIS.this_cDsEmiGrupo = EVALUATE(loc_cAlias + ".DsEmiGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEmiConta") = "C"
                    THIS.this_cCdEmiConta = EVALUATE(loc_cAlias + ".CdEmiConta")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEmiConta") = "C"
                    THIS.this_cDsEmiConta = EVALUATE(loc_cAlias + ".DsEmiConta")
                ENDIF
                IF TYPE(loc_cAlias + ".CdOriGrupo") = "C"
                    THIS.this_cCdOriGrupo = EVALUATE(loc_cAlias + ".CdOriGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".DsOriGrupo") = "C"
                    THIS.this_cDsOriGrupo = EVALUATE(loc_cAlias + ".DsOriGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".CdOriConta") = "C"
                    THIS.this_cCdOriConta = EVALUATE(loc_cAlias + ".CdOriConta")
                ENDIF
                IF TYPE(loc_cAlias + ".DsOriConta") = "C"
                    THIS.this_cDsOriConta = EVALUATE(loc_cAlias + ".DsOriConta")
                ENDIF
                IF TYPE(loc_cAlias + ".CdDesGrupo") = "C"
                    THIS.this_cCdDesGrupo = EVALUATE(loc_cAlias + ".CdDesGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".DsDesGrupo") = "C"
                    THIS.this_cDsDesGrupo = EVALUATE(loc_cAlias + ".DsDesGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".CdDesConta") = "C"
                    THIS.this_cCdDesConta = EVALUATE(loc_cAlias + ".CdDesConta")
                ENDIF
                IF TYPE(loc_cAlias + ".DsDesConta") = "C"
                    THIS.this_cDsDesConta = EVALUATE(loc_cAlias + ".DsDesConta")
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros vazio"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "sigrecrtBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra execucao do relatorio em LogAuditoria
    * Para relatorios, "Inserir" significa registrar nova execucao,
    * permitindo rastrear quem rodou qual relatorio e quando.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar execu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "sigrecrtBO.Inserir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Registra reexecucao do relatorio em LogAuditoria
    * Para relatorios, "Atualizar" significa registrar uma reexecucao
    * (usuario alterou filtros e gerou o relatorio novamente).
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RERUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar reexecu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "sigrecrtBO.Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores temporarios do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        IF USED("cursor_4c_SqlTmp0")
            USE IN cursor_4c_SqlTmp0
        ENDIF
        IF USED("cursor_4c_CliCqDev")
            USE IN cursor_4c_CliCqDev
        ENDIF
        IF USED("cursor_4c_Cur1")
            USE IN cursor_4c_Cur1
        ENDIF
        IF USED("cursor_4c_Cur2")
            USE IN cursor_4c_Cur2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro registrado
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores permanentes e libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        IF USED("cursor_4c_SigCdOpt")
            USE IN cursor_4c_SigCdOpt
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

