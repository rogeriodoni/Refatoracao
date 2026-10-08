# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGmi.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1351 linhas total):

*-- Linhas 16 a 238:
16: * FormSigPrGlp/FormSigPrGlx).
17: *
18: * Criado em: Fase 3 - Estrutura Base (DEFINE CLASS, Init/Destroy/
19: * InicializarForm, cabecalho cnt_4c_Sombra). Fase 4 - shp_4c_Shape1 +
20: * botoes de acao cmd_4c_Processa/cmd_4c_Encerrar (sem grid/CRUD, legado nao
21: * tem grade). Fase 5 - primeira metade dos campos de criterio (as 3
22: * primeiras linhas da tela: Empresa, Grupo de Estoque e Conta de Estoque =
23: * 6 dos 10 TextBox do legado) + AjustarOrdemTabulacao() com o TabIndex do
24: * SCX. Roteiro das proximas fases em ConfigurarPageFrame().
25: *==============================================================================
26: 
27: DEFINE CLASS FormSigPrGmi AS FormBase
28: 
29:     *--------------------------------------------------------------------------
30:     * Propriedades do form (SIGPRGMI.SCX: Width=800, Height=292 - dump de
31:     * layout.json. Botoes Cancela/Processa classe "fwbtng" chegam a
32:     * Left=723/648 sem Width/Height proprios no dump (herdados da classe) -
33:     * com Width=75 canonico do projeto, Cancela (723+75=798) encaixa dentro
34:     * dos 800px do form, confirmando o tamanho padrao de botao do framework)
35:     *--------------------------------------------------------------------------
36:     Width        = 800
37:     Height       = 292
38:     AutoCenter   = .T.
39:     TitleBar     = 0
40:     ShowWindow   = 1
41:     WindowType   = 1
42:     ControlBox   = .F.
43:     Closable     = .F.
44:     MaxButton    = .F.
45:     MinButton    = .F.
46:     ClipControls = .F.
47:     BorderStyle  = 2
48:     FontName     = "Tahoma"
49:     FontSize     = 8
50: 
51:     Caption = "Gera" + CHR(231) + CHR(227) + "o de Pedido de Estoque M" + CHR(237) + "nimo"
52: 
53:     *--------------------------------------------------------------------------
54:     * Init - Cria o Business Object ANTES do DODEFAULT(), para que
55:     * InicializarForm() (chamado por FormBase.Init() via DODEFAULT) ja o
56:     * encontre pronto.
57:     *--------------------------------------------------------------------------
58:     PROCEDURE Init()
59:         LOCAL loc_lSucesso, loc_oErro
60:         loc_lSucesso = .F.
61: 
62:         TRY
63:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGmiBO")
64: 
65:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
66:                 loc_lSucesso = DODEFAULT()
67:             ENDIF
68:         CATCH TO loc_oErro
69:             MsgErro("Erro ao inicializar Gera" + CHR(231) + CHR(227) + "o de Pedido de " + ;
70:                 "Estoque M" + CHR(237) + "nimo: " + loc_oErro.Message, "Erro")
71:         ENDTRY
72: 
73:         RETURN loc_lSucesso
74:     ENDPROC
75: 
76:     *--------------------------------------------------------------------------
77:     * Destroy - form standalone (sem form pai para reabilitar); encadeia
78:     * direto para FormBase.Destroy() (libera this_oBusinessObject e
79:     * restaura o menu principal).
80:     *--------------------------------------------------------------------------
81:     PROCEDURE Destroy()
82:         DODEFAULT()
83:     ENDPROC
84: 
85:     *--------------------------------------------------------------------------
86:     * InicializarForm - Business Object ja foi criado em Init(); aqui monta
87:     * a moldura visual (fundo + cabecalho). Os campos, botoes de acao e
88:     * eventos entram nas proximas fases.
89:     *--------------------------------------------------------------------------
90:     PROTECTED PROCEDURE InicializarForm()
91:         LOCAL loc_lSucesso, loc_oErro, loc_cPicture
92:         loc_lSucesso = .F.
93: 
94:         TRY
95:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
96:                 MsgErro("Falha ao criar SigPrGmiBO.", "Erro")
97:             ELSE
98:                 loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
99:                 IF FILE(loc_cPicture)
100:                     THIS.Picture = loc_cPicture
101:                 ENDIF
102: 
103:                 THIS.ConfigurarPageFrame()
104: 
105:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
106:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
107: 
108:                 THIS.TornarControlesVisiveis(THIS)
109: 
110:                 *-- Data de Geracao nasce com o default do Init legado
111:                 *-- (Date() - 7), e os demais criterios em branco
112:                 THIS.BOParaForm()
113: 
114:                 loc_lSucesso = .T.
115:             ENDIF
116:         CATCH TO loc_oErro
117:             MsgErro(loc_oErro.Message + CHR(13) + ;
118:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
119:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGmi.InicializarForm")
120:         ENDTRY
121: 
122:         RETURN loc_lSucesso
123:     ENDPROC
124: 
125:     *--------------------------------------------------------------------------
126:     * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRGMI nao
127:     * tem PageFrame no legado (layout flat) - o nome do metodo eh mantido
128:     * apenas como ponto de entrada arquitetural padrao (mesmo papel em
129:     * FormSigPrGlp/FormSigPrGlo).
130:     *
131:     * Historico de montagem (migracao multi-fase, todas CONCLUIDAS):
132:     *   Fase 3 (feita) - ConfigurarCabecalho() (cnt_4c_Sombra)
133:     *   Fase 4 (feita) - ConfigurarBotoesAcao(): shp_4c_Shape1 decorativo +
134:     *                     os 2 botoes de acao standalone (cmd_4c_Processa/
135:     *                     cmd_4c_Encerrar) - este form NAO tem grid nem
136:     *                     PageFrame de Lista/Dados (zero grades no dump).
137:     *                     BINDEVENT dos dois botoes registrado no fim do
138:     *                     proprio ConfigurarBotoesAcao (os handlers
139:     *                     BtnProcessaClick/BtnEncerrarClick existem)
140:     *   Fase 5 (feita) - ConfigurarCamposCriteriosParte1(): as 3 PRIMEIRAS
141:     *                     linhas de criterio do legado - Empresa
142:     *                     (txt_4c__cd_empresa/txt_4c__ds_empresa), Grupo de
143:     *                     Estoque (txt_4c__Cd_GrEstoque/txt_4c__Ds_GrEstoque)
144:     *                     e Conta de Estoque (txt_4c__cd_estoque/
145:     *                     txt_4c__ds_estoque) = 6 dos 10 TextBox do dump.
146:     *                     Mais AjustarOrdemTabulacao() com o TabIndex 2..7
147:     *                     que o SCX declara para esses campos
148:     *   Fase 6 (feita) - as 3 linhas restantes: Linha de Producao
149:     *                     (txt_4c_Linha/txt_4c_DLinha - lookup completo via
150:     *                     AbrirLookupCanonico/SigCdLin, substitui o
151:     *                     fwBuscaSel legado), Somente Negativos
152:     *                     (txt_4c_Negativo - dump declara Format "K", NAO
153:     *                     "M" - regra CLAUDE.md #13 "transcrever, nunca
154:     *                     inventar": a restricao S/N e feita por KeyPress,
155:     *                     equivalente ao "Return Inlist(...)" do Valid
156:     *                     legado) e Data de Geracao (txt_4c_Datai); estende
157:     *                     AjustarOrdemTabulacao() com o TabIndex 8..11
158:     *   Fase 7 (feita) - eventos via KeyPress (Enter/Tab/F4 - mesmo padrao
159:     *                     de LinhaKeyPress/DLinhaKeyPress) de Empresa (lookup
160:     *                     canonico em SigCdEmp - fAcessoEmpresa NAO existe no
161:     *                     projeto), Grupo de Estoque (fAcessoContab -> ja
162:     *                     ported em utils\functions.prg, chamado DIRETO como
163:     *                     no legado) e Conta de Estoque (fAcessoContas ->
164:     *                     idem, com o Grupo corrente como filtro)
165:     *   Fase 8 (feita) - BtnProcessaClick (NovoRegistro+FormParaBO+Salvar do
166:     *                     BO, exibe this_cNumeroPedido/this_nItensGerados ao
167:     *                     final) e BtnEncerrarClick (Release); FormParaBO/
168:     *                     BOParaForm/LimparCampos/FocarCampoValidacao.
169:     *                     NAO existem CarregarLista()/AjustarBotoesPorModo()/
170:     *                     HabilitarCampos()/BtnSalvarClick()/BtnBuscarClick():
171:     *                     o legado nao tem grade nem CRUD (so dois botoes,
172:     *                     Processar e Encerrar) - inventa-los seria desvio do
173:     *                     PILAR 1. Verificado por TestSigPrGmiF8.prg
174:     *                     (instancia o form, confere os 11 BINDEVENT, o escopo
175:     *                     PUBLIC dos 9 handlers de KeyPress, as 10 properties
176:     *                     do FormParaBO e o this_cCampoFoco da validacao)
177:     *==========================================================================
178:     PROTECTED PROCEDURE ConfigurarPageFrame()
179:         THIS.ConfigurarCabecalho()
180:         THIS.ConfigurarBotoesAcao()
181:         THIS.ConfigurarCamposCriteriosParte1()
182:         THIS.ConfigurarCamposCriteriosParte2()
183: 
184:         *-- Por ULTIMO: TabIndex so pode ser ajustado depois de TODOS os
185:         *-- AddObject (cada atribuicao empurra os demais controles para tras)
186:         THIS.AjustarOrdemTabulacao()
187:     ENDPROC
188: 
189:     *--------------------------------------------------------------------------
190:     * ConfigurarCabecalho - Container cinza escuro com titulo do form.
191:     * Original (layout.json): cntSombra Top=0, Left=0, Width=864, Height=80,
192:     * BackColor=RGB(100,100,100) - os valores de lblSombra/lblTitulo/
193:     * dimensoes do container sao os defaults da classe cntSombra do
194:     * framework.vcx (confirmado pelo Caption de dump "Cadastro de Testes",
195:     * texto generico da classe que o Init legado substitui em runtime) - por
196:     * isso Width usa THIS.Width (canonico do projeto) em vez do literal 864.
197:     *--------------------------------------------------------------------------
198:     PROTECTED PROCEDURE ConfigurarCabecalho()
199:         LOCAL loc_oCnt, loc_oErro
200: 
201:         TRY
202:             THIS.AddObject("cnt_4c_Sombra", "Container")
203:             loc_oCnt = THIS.cnt_4c_Sombra
204:             WITH loc_oCnt
205:                 .Top         = 0
206:                 .Left        = 0
207:                 .Width       = THIS.Width
208:                 .Height      = 80
209:                 .BorderWidth = 0
210:                 .BackColor   = RGB(100, 100, 100)
211:                 .Visible     = .T.
212:             ENDWITH
213: 
214:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
215:             WITH loc_oCnt.lbl_4c_LblSombra
216:                 .FontBold  = .T.
217:                 .FontName  = "Tahoma"
218:                 .FontSize  = 18
219:                 .WordWrap  = .T.
220:                 .Alignment = 0
221:                 .BackStyle = 0
222:                 .AutoSize  = .F.
223:                 .Caption   = THIS.Caption
224:                 .Height    = 40
225:                 .Left      = 10
226:                 .Top       = 18
227:                 .Width     = 769
228:                 .ForeColor = RGB(0, 0, 0)
229:                 .Visible   = .T.
230:             ENDWITH
231: 
232:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
233:             WITH loc_oCnt.lbl_4c_LblTitulo
234:                 .FontBold  = .T.
235:                 .FontName  = "Tahoma"
236:                 .FontSize  = 18
237:                 .WordWrap  = .T.
238:                 .Alignment = 0

*-- Linhas 249 a 308:
249:         CATCH TO loc_oErro
250:             MsgErro(loc_oErro.Message + CHR(13) + ;
251:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
252:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
253:         ENDTRY
254:     ENDPROC
255: 
256:     *--------------------------------------------------------------------------
257:     * ConfigurarBotoesAcao - Shape decorativo + botoes Processar/Encerrar,
258:     * posicionados diretamente no form (fora de container), EXATAMENTE como
259:     * no SIGPRGMI.SCX original (Shape1/Processa/Cancela - layout.json).
260:     * Padrao canonico do projeto para este par de botoes (ver
261:     * FormSIGMVCMV.ConfigurarBotoesAcao): Width/Height=75, Themes=.T. +
262:     * DisabledPicture (botao standalone com Picture precisa dos dois para
263:     * o icone renderizar quando Enabled=.F. - regra CLAUDE.md).
264:     *
265:     * BINDEVENT dos dois botoes feito no FIM deste metodo, apontando para
266:     * BtnProcessaClick/BtnEncerrarClick (PUBLIC - regra CLAUDE.md #3).
267:     *--------------------------------------------------------------------------
268:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
269:         LOCAL loc_oErro
270: 
271:         TRY
272:             THIS.AddObject("shp_4c_Shape1", "Shape")
273:             WITH THIS.shp_4c_Shape1
274:                 .Top           = 7
275:                 .Left          = 698
276:                 .Width         = 46
277:                 .Height        = 41
278:                 .BackStyle     = 0
279:                 .BorderStyle   = 0
280:                 .SpecialEffect = 1
281:                 .BorderColor   = RGB(136, 189, 188)
282:                 .Visible       = .T.
283:             ENDWITH
284: 
285:             THIS.AddObject("cmd_4c_Processa", "CommandButton")
286:             WITH THIS.cmd_4c_Processa
287:                 .Top             = 4
288:                 .Left            = 648
289:                 .Height          = 75
290:                 .Width           = 75
291:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
292:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
293:                 .Caption         = "\<Processar"
294:                 .FontName        = "Tahoma"
295:                 .FontBold        = .T.
296:                 .FontItalic      = .T.
297:                 .FontSize        = 8
298:                 .ForeColor       = RGB(90, 90, 90)
299:                 .BackColor       = RGB(255, 255, 255)
300:                 .Themes          = .T.
301:                 .SpecialEffect   = 0
302:                 .PicturePosition = 13
303:                 .MousePointer    = 15
304:                 .WordWrap        = .T.
305:                 .AutoSize        = .F.
306:                 .Visible         = .T.
307:             ENDWITH
308: 

*-- Linhas 331 a 427:
331:                 .Visible         = .T.
332:             ENDWITH
333: 
334:             BINDEVENT(THIS.cmd_4c_Processa, "Click", THIS, "BtnProcessaClick")
335:             BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
336:         CATCH TO loc_oErro
337:             MsgErro(loc_oErro.Message + CHR(13) + ;
338:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
339:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
340:         ENDTRY
341:     ENDPROC
342: 
343:     *--------------------------------------------------------------------------
344:     * ConfigurarCamposCriteriosParte1 - Fase 5/8: primeira metade dos campos
345:     * de criterio, criados DIRETO no form (layout flat do SIGPRGMI.SCX - sem
346:     * PageFrame, logo SEM a compensacao de +29, que so vale para controle
347:     * dentro de Page com Top=-29).
348:     *
349:     * As 6 linhas de criterio do legado foram divididas ao meio por LINHA da
350:     * tela (cada linha = codigo + descricao):
351:     *   Fase 5 (aqui) - Empresa (Top=113), Grupo de Estoque (Top=138) e
352:     *                   Conta de Estoque (Top=163) = 6 dos 10 TextBox
353:     *   Fase 6        - Linha de Producao (Top=188), Somente Negativos
354:     *                   (Top=213) e Data de Geracao (Top=238)
355:     *
356:     * TODAS as propriedades vem do dump SigPrGmi_form_codigo_fonte.txt
357:     * (secoes "PROPRIEDADES DE"), nao do layout.json - o dump traz Format/
358:     * InputMask/MaxLength/FontName que o layout.json nao tem. O SCX grava
359:     * APENAS o que difere do default da classe, entao o que ele nao declara
360:     * fica no default do VFP - medido em 2026-10-06 com
361:     * automation\medir_textbox_default_font.prg (TextBox via AddObject):
362:     * FontSize=9, SpecialEffect=0, BorderStyle=1, BackStyle=1, Alignment=3.
363:     * Por isso FontSize=9 vale para os seis campos (inclusive os de descricao,
364:     * que nao declaram FontSize) e NAO se escreve SpecialEffect=1 nem
365:     * BorderColor - o legado nao tem nenhum dos dois.
366:     *
367:     * Format = "K" (seleciona o conteudo ao entrar no campo) - NAO "K!": o
368:     * legado nao forca maiuscula em campo nenhum deste form. O "K" tambem
369:     * garante que o InputMask siga sendo mascara de digitacao, e nao lista de
370:     * valores validos (isso seria Format com "M" - regra CLAUDE.md #24).
371:     *
372:     * MaxLength transcrito do dump, que nunca excede a coluna do schema
373:     * (conferido em docs\schema.sql, UTF-16 lido com Get-Content -Raw):
374:     *   Empresa          -> SigCdEmp.cemps   char(3)  / Razas  char(40)  [3/40]
375:     *   Grupo de Estoque -> SigCdGcr.codigos char(10) / descrs char(40)  [10/20]
376:     *   Conta de Estoque -> SigCdCli.IClis   char(10) / RClis  char(50)  [10/40]
377:     * Nos dois campos de descricao o legado mostra MENOS que a coluna (20 e
378:     * 40) - eh truncamento de EXIBICAO do legado e fica como esta (PILAR 1);
379:     * esses campos sao criterio de filtro, nunca sao gravados.
380:     *
381:     * Os lookups de cada campo (Fase 7, ja implementados) usam as funcoes
382:     * do projeto que correspondem as do legado: fAcessoEmpresa -> SigCdEmp,
383:     * fAcessoContab -> SigCdGcr (grupos contabeis) e fAcessoContas ->
384:     * SigCdCli (contas). BINDEVENT so entra la, junto dos handlers - apontar
385:     * SigCdCli (contas) - BINDEVENT registrado no fim deste metodo.
386:     *--------------------------------------------------------------------------
387:     PROTECTED PROCEDURE ConfigurarCamposCriteriosParte1()
388:         LOCAL loc_oErro
389: 
390:         TRY
391:             *-- Linha 1: Empresa (legado lbl_empresa / get_cd_empresa / get_ds_empresa)
392:             THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
393:             WITH THIS.lbl_4c_Lbl_empresa
394:                 .Caption   = "Empresa : "
395:                 .Top       = 118
396:                 .Left      = 211
397:                 .Width     = 53
398:                 .Height    = 17
399:                 .FontName  = "Tahoma"
400:                 .FontSize  = 8
401:                 .AutoSize  = .F.
402:                 .Alignment = 0
403:                 .BackStyle = 0
404:                 .ForeColor = RGB(90, 90, 90)
405:                 .Visible   = .T.
406:             ENDWITH
407: 
408:             *-- get_cd_empresa: codigo da empresa (SigCdEmp.cemps char(3))
409:             THIS.AddObject("txt_4c__cd_empresa", "TextBox")
410:             WITH THIS.txt_4c__cd_empresa
411:                 .Top           = 113
412:                 .Left          = 268
413:                 .Width         = 31
414:                 .Height        = 25
415:                 .FontName      = "Courier New"
416:                 .FontSize      = 9
417:                 .FontBold      = .F.
418:                 .FontItalic    = .F.
419:                 .Format        = "K"
420:                 .InputMask     = "XXX"
421:                 .MaxLength     = 3
422:                 .Alignment     = 0
423:                 .BackStyle     = 1
424:                 .BorderStyle   = 1
425:                 .SpecialEffect = 0
426:                 .ForeColor     = RGB(0, 0, 0)
427:                 .Value         = ""

*-- Linhas 545 a 643:
545:                 .Visible   = .T.
546:             ENDWITH
547: 
548:             *-- BINDEVENT: F4 abre o lookup direto; Enter/Tab disparam a
549:             *-- validacao (equivalente ao PROCEDURE Valid do legado, que roda
550:             *-- ao sair do campo). PUBLIC obrigatorio - BINDEVENT falha em
551:             *-- silencio com metodo PROTECTED (regra CLAUDE.md #3).
552:             BINDEVENT(THIS.txt_4c__cd_empresa, "KeyPress", THIS, "CdEmpresaKeyPress")
553:             BINDEVENT(THIS.txt_4c__ds_empresa, "KeyPress", THIS, "DsEmpresaKeyPress")
554:             BINDEVENT(THIS.txt_4c__Cd_GrEstoque, "KeyPress", THIS, "CdGrEstoqueKeyPress")
555:             BINDEVENT(THIS.txt_4c__Ds_GrEstoque, "KeyPress", THIS, "DsGrEstoqueKeyPress")
556:             BINDEVENT(THIS.txt_4c__cd_estoque, "KeyPress", THIS, "CdEstoqueKeyPress")
557:             BINDEVENT(THIS.txt_4c__ds_estoque, "KeyPress", THIS, "DsEstoqueKeyPress")
558:         CATCH TO loc_oErro
559:             MsgErro(loc_oErro.Message + CHR(13) + ;
560:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
561:                 "Procedure: " + loc_oErro.Procedure, ;
562:                 "Erro em ConfigurarCamposCriteriosParte1")
563:         ENDTRY
564:     ENDPROC
565: 
566:     *--------------------------------------------------------------------------
567:     * ConfigurarCamposCriteriosParte2 - Fase 6/8: as 3 linhas RESTANTES de
568:     * criterio do legado, criadas DIRETO no form (mesmo layout flat, sem
569:     * compensacao de +29 - ver ConfigurarCamposCriteriosParte1):
570:     *   - Linha de Producao (Say2/Get_Linha/Get_DLinha, Top=188/193) - UNICO
571:     *     lookup desta fase (os demais - Empresa/Grupo/Conta - entraram na
572:     *     Fase 7, com AbrirLookupCanonico/fAcessoContab/fAcessoContas)
573:     *   - Somente Negativos (Say3/Get_negativo/Say4, Top=213/217/218)
574:     *   - Data de Geracao (Say_Conta/Get_Datai, Top=238/243)
575:     *
576:     * MaxLength conferido em docs\schema.sql (UTF-16, Get-Content -Raw):
577:     *   SigCdLin.linhas char(10) / descs char(40) - bate com o dump
578:     *   (MaxLength=10 e 40 respectivamente, sem truncamento de exibicao).
579:     *
580:     * Get_Linha/Get_DLinha no dump trazem conjuntos de propriedades
581:     * DIFERENTES (mesma distincao medida na Fase 5): Get_Linha declara o
582:     * bloco COMPLETO (FontBold/FontItalic/Alignment/BackStyle/BorderStyle/
583:     * SpecialEffect/ForeColor/InputMask - igual a get_cd_estoque), Get_DLinha
584:     * so o bloco LEVE (FontName/Format/MaxLength - igual a get_ds_estoque);
585:     * os WITH abaixo replicam cada um com o bloco correspondente.
586:     *
587:     * Get_negativo: o dump declara Format = "K" (selecionar ao entrar), NAO
588:     * "K!" nem "KM" - NAO ha InputMask no SCX. A regra CLAUDE.md #24 (Format
589:     * com M = multiple choice) NAO se aplica aqui porque o legado nao usa M
590:     * para este campo; a restricao a S/N vem do PROCEDURE Valid
591:     * ("Return Inlist(This.Value, "S","N")"), transcrita como handler de
592:     * KeyPress (NegativoKeyPress) com NODEFAULT - exatamente o efeito de um
593:     * Valid que devolve .F. (mantem o foco no campo).
594:     *
595:     * Get_Datai (classe fwget, Alignment=3 explicito no dump) segue o padrao
596:     * canonico de campo de data do projeto (FormSigPrFem.txt_4c_Datai):
597:     * Format="K", BackStyle=1, BorderStyle=1, SpecialEffect=1,
598:     * BorderColor=RGB(100,100,100), ForeColor=RGB(0,0,0). O valor Date()-7
599:     * que o Init legado atribui (ThisForm.Get_Datai.Value = Date() - 7) fica
600:     * para a Fase 8 (BOParaForm do modo INCLUIR) - aqui o controle nasce com
601:     * {} (Value declarado no dump), igual aos demais campos desta fase.
602:     *--------------------------------------------------------------------------
603:     PROTECTED PROCEDURE ConfigurarCamposCriteriosParte2()
604:         LOCAL loc_oErro
605: 
606:         TRY
607:             *-- Linha 4: Linha de Producao (legado Say2 / Get_Linha / Get_DLinha)
608:             THIS.AddObject("lbl_4c_Label2", "Label")
609:             WITH THIS.lbl_4c_Label2
610:                 .Caption   = "Linha de Produ" + CHR(231) + CHR(227) + "o : "
611:                 .Top       = 193
612:                 .Left      = 164
613:                 .Width     = 100
614:                 .Height    = 17
615:                 .FontName  = "Tahoma"
616:                 .FontSize  = 8
617:                 .AutoSize  = .F.
618:                 .Alignment = 0
619:                 .BackStyle = 0
620:                 .ForeColor = RGB(90, 90, 90)
621:                 .Visible   = .T.
622:             ENDWITH
623: 
624:             *-- Get_Linha: codigo da linha de producao (SigCdLin.Linhas char(10))
625:             THIS.AddObject("txt_4c_Linha", "TextBox")
626:             WITH THIS.txt_4c_Linha
627:                 .Top           = 188
628:                 .Left          = 268
629:                 .Width         = 80
630:                 .Height        = 25
631:                 .FontName      = "Courier New"
632:                 .FontSize      = 9
633:                 .FontBold      = .F.
634:                 .FontItalic    = .F.
635:                 .Format        = "K"
636:                 .InputMask     = ""
637:                 .MaxLength     = 10
638:                 .Alignment     = 0
639:                 .BackStyle     = 1
640:                 .BorderStyle   = 1
641:                 .SpecialEffect = 0
642:                 .ForeColor     = RGB(0, 0, 0)
643:                 .Value         = ""

*-- Linhas 659 a 747:
659:                 .Visible   = .T.
660:             ENDWITH
661: 
662:             *-- BINDEVENT: F4 abre o lookup direto; Enter/Tab disparam a
663:             *-- validacao (equivalente ao PROCEDURE Valid do legado, que roda
664:             *-- ao sair do campo). PUBLIC obrigatorio - BINDEVENT falha em
665:             *-- silencio com metodo PROTECTED (regra CLAUDE.md #3).
666:             BINDEVENT(THIS.txt_4c_Linha, "KeyPress", THIS, "LinhaKeyPress")
667:             BINDEVENT(THIS.txt_4c_DLinha, "KeyPress", THIS, "DLinhaKeyPress")
668: 
669:             *-- Linha 5: Somente Negativos (legado Say3 / Get_negativo / Say4)
670:             THIS.AddObject("lbl_4c_Label3", "Label")
671:             WITH THIS.lbl_4c_Label3
672:                 .Caption   = "Somente Negativos :"
673:                 .Top       = 218
674:                 .Left      = 162
675:                 .Width     = 102
676:                 .Height    = 17
677:                 .FontName  = "Tahoma"
678:                 .FontSize  = 8
679:                 .AutoSize  = .F.
680:                 .Alignment = 0
681:                 .BackStyle = 0
682:                 .ForeColor = RGB(90, 90, 90)
683:                 .Visible   = .T.
684:             ENDWITH
685: 
686:             *-- Get_negativo: "S" ou "N" (char(1), sem coluna propria - vai
687:             *-- para SigMvEst via criterio de filtro, nunca eh gravado)
688:             THIS.AddObject("txt_4c_Negativo", "TextBox")
689:             WITH THIS.txt_4c_Negativo
690:                 .Top        = 213
691:                 .Left       = 268
692:                 .Width      = 17
693:                 .Height     = 25
694:                 .FontName   = "Courier New"
695:                 .FontSize   = 9
696:                 .FontBold   = .F.
697:                 .FontItalic = .F.
698:                 .Alignment  = 0
699:                 .BackStyle  = 1
700:                 .BorderStyle = 1
701:                 .Format     = "K"
702:                 .MaxLength  = 1
703:                 .Value      = ""
704:                 .Visible    = .T.
705:             ENDWITH
706: 
707:             BINDEVENT(THIS.txt_4c_Negativo, "KeyPress", THIS, "NegativoKeyPress")
708: 
709:             *-- "< S / N >" - UNICO label do form com FontBold=.T. no dump
710:             THIS.AddObject("lbl_4c_Label4", "Label")
711:             WITH THIS.lbl_4c_Label4
712:                 .Caption   = "< S / N >"
713:                 .Top       = 217
714:                 .Left      = 292
715:                 .Width     = 52
716:                 .Height    = 17
717:                 .FontName  = "Tahoma"
718:                 .FontSize  = 8
719:                 .FontBold  = .T.
720:                 .AutoSize  = .F.
721:                 .Alignment = 0
722:                 .BackStyle = 0
723:                 .ForeColor = RGB(90, 90, 90)
724:                 .Visible   = .T.
725:             ENDWITH
726: 
727:             *-- Linha 6: Data de Geracao (legado Say_Conta / Get_Datai)
728:             THIS.AddObject("lbl_4c__Conta", "Label")
729:             WITH THIS.lbl_4c__Conta
730:                 .Caption   = "Data Gera" + CHR(231) + CHR(227) + "o :"
731:                 .Top       = 243
732:                 .Left      = 189
733:                 .Width     = 75
734:                 .Height    = 17
735:                 .FontName  = "Tahoma"
736:                 .FontSize  = 8
737:                 .AutoSize  = .F.
738:                 .Alignment = 0
739:                 .BackStyle = 0
740:                 .ForeColor = RGB(90, 90, 90)
741:                 .Visible   = .T.
742:             ENDWITH
743: 
744:             *-- Get_Datai: classe fwget (Alignment=3 explicito no dump) -
745:             *-- padrao canonico de campo de data do projeto (FormSigPrFem)
746:             THIS.AddObject("txt_4c_Datai", "TextBox")
747:             WITH THIS.txt_4c_Datai

*-- Linhas 764 a 1351:
764:         CATCH TO loc_oErro
765:             MsgErro(loc_oErro.Message + CHR(13) + ;
766:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
767:                 "Procedure: " + loc_oErro.Procedure, ;
768:                 "Erro em ConfigurarCamposCriteriosParte2")
769:         ENDTRY
770:     ENDPROC
771: 
772:     *--------------------------------------------------------------------------
773:     * CdEmpresaKeyPress / DsEmpresaKeyPress - Handlers de KeyPress de Empresa
774:     * (BINDEVENT exige PUBLIC - regra CLAUDE.md #3). Transcricao de
775:     * SIGPRGMI.get_cd_empresa.Valid / get_ds_empresa.Valid: os dois chamavam
776:     * "fAcessoEmpresa(Usuar,'C'|'D',This.value,...)", funcao que NAO foi
777:     * portada para o projeto (ver CLAUDE.md/memoria) - substituicao canonica:
778:     * match exato em SigCdEmp (Cemps/Razas) e, sem match, AbrirLookupCanonico
779:     * (FormBuscaAuxiliar) com o valor digitado como filtro de prefixo.
780:     *--------------------------------------------------------------------------
781:     PROCEDURE CdEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
782:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
783:             THIS.AbrirLookupEmpresa(ALLTRIM(THIS.txt_4c__cd_empresa.Value))
784:         ENDIF
785:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
786:             THIS.ValidarEmpresa("C")
787:         ENDIF
788:     ENDPROC
789: 
790:     PROCEDURE DsEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
791:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
792:             THIS.AbrirLookupEmpresa(ALLTRIM(THIS.txt_4c__ds_empresa.Value))
793:         ENDIF
794:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
795:             THIS.ValidarEmpresa("D")
796:         ENDIF
797:     ENDPROC
798: 
799:     *--------------------------------------------------------------------------
800:     * ValidarEmpresa - par_cModo "C" (codigo, txt_4c__cd_empresa) ou "D"
801:     * (descricao, txt_4c__ds_empresa). Vazio limpa os dois campos; preenchido
802:     * tenta match exato em SigCdEmp e, sem match, abre o mesmo lookup do F4.
803:     *--------------------------------------------------------------------------
804:     PROCEDURE ValidarEmpresa(par_cModo)
805:         LOCAL loc_cValor, loc_cCampo, loc_cSQL, loc_nResultado, loc_oErro
806: 
807:         IF VARTYPE(THIS.txt_4c__cd_empresa) != "O" OR VARTYPE(THIS.txt_4c__ds_empresa) != "O"
808:             RETURN
809:         ENDIF
810: 
811:         TRY
812:             IF par_cModo = "C"
813:                 loc_cValor = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
814:             ELSE
815:                 loc_cValor = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
816:             ENDIF
817: 
818:             IF EMPTY(loc_cValor)
819:                 THIS.txt_4c__cd_empresa.Value = ""
820:                 THIS.txt_4c__ds_empresa.Value = ""
821:             ELSE
822:                 IF USED("cursor_4c_EmpresaVal")
823:                     USE IN cursor_4c_EmpresaVal
824:                 ENDIF
825: 
826:                 loc_cCampo = IIF(par_cModo = "C", "Cemps", "Razas")
827:                 loc_cSQL   = "SELECT Cemps, Razas FROM SigCdEmp WHERE " + loc_cCampo + " = " + EscaparSQL(loc_cValor)
828:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresaVal")
829: 
830:                 IF loc_nResultado > 0 AND USED("cursor_4c_EmpresaVal") AND !EOF("cursor_4c_EmpresaVal")
831:                     SELECT cursor_4c_EmpresaVal
832:                     THIS.txt_4c__cd_empresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Cemps)
833:                     THIS.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Razas)
834:                 ELSE
835:                     THIS.AbrirLookupEmpresa(loc_cValor)
836:                 ENDIF
837: 
838:                 IF USED("cursor_4c_EmpresaVal")
839:                     USE IN cursor_4c_EmpresaVal
840:                 ENDIF
841:             ENDIF
842:         CATCH TO loc_oErro
843:             MsgErro(loc_oErro.Message + CHR(13) + ;
844:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
845:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarEmpresa")
846:         ENDTRY
847:     ENDPROC
848: 
849:     *--------------------------------------------------------------------------
850:     * AbrirLookupEmpresa - Lookup de Empresa via AbrirLookupCanonico (helper
851:     * de FormBase, Pattern A) - substitui o fwBuscaExt/fAcessoEmpresa legado,
852:     * que nao foi portado, em SigCdEmp (Cemps/Razas).
853:     *--------------------------------------------------------------------------
854:     PROCEDURE AbrirLookupEmpresa(par_cValorFiltro)
855:         IF VARTYPE(THIS.txt_4c__cd_empresa) != "O" OR VARTYPE(THIS.txt_4c__ds_empresa) != "O"
856:             RETURN
857:         ENDIF
858: 
859:         THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
860:             "Sele" + CHR(231) + CHR(227) + "o de Empresa", par_cValorFiltro, ;
861:             THIS.txt_4c__cd_empresa, THIS.txt_4c__ds_empresa)
862:     ENDPROC
863: 
864:     *--------------------------------------------------------------------------
865:     * CdGrEstoqueKeyPress / DsGrEstoqueKeyPress - Handlers de KeyPress do
866:     * Grupo de Estoque (BINDEVENT exige PUBLIC - regra CLAUDE.md #3).
867:     * Transcricao de SIGPRGMI.get_Cd_GrEstoque.Valid / get_Ds_GrEstoque.Valid:
868:     * os dois chamam fAcessoContab (ja portada em utils\functions.prg) DIRETO,
869:     * passando os proprios TextBox de codigo/descricao para a funcao
870:     * preencher - igual ao padrao ja usado em FormSigPrCtr.ValidarGrupoAcesso.
871:     *--------------------------------------------------------------------------
872:     PROCEDURE CdGrEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
873:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
874:             THIS.ValidarGrEstoque("C")
875:         ENDIF
876:     ENDPROC
877: 
878:     PROCEDURE DsGrEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
879:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
880:             THIS.ValidarGrEstoque("D")
881:         ENDIF
882:     ENDPROC
883: 
884:     *--------------------------------------------------------------------------
885:     * ValidarGrEstoque - par_cModo "C" (txt_4c__Cd_GrEstoque) ou "D"
886:     * (txt_4c__Ds_GrEstoque). Campo vazio limpa o PAR (igual ao legado);
887:     * preenchido delega a fAcessoContab, que resolve o match e, sem achar,
888:     * abre o FormBuscaSimples - ela mesma preenche os dois TextBox.
889:     *--------------------------------------------------------------------------
890:     PROCEDURE ValidarGrEstoque(par_cModo)
891:         LOCAL loc_cConta, loc_oErro
892: 
893:         IF VARTYPE(THIS.txt_4c__Cd_GrEstoque) != "O" OR VARTYPE(THIS.txt_4c__Ds_GrEstoque) != "O"
894:             RETURN
895:         ENDIF
896: 
897:         TRY
898:             loc_cConta = ALLTRIM(THIS.txt_4c__cd_estoque.Value)
899: 
900:             IF par_cModo = "C"
901:                 IF !EMPTY(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value))
902:                     fAcessoContab(gc_4c_UsuarioLogado, "C", ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value), ;
903:                         THIS.txt_4c__Cd_GrEstoque, THIS.txt_4c__Ds_GrEstoque, loc_cConta)
904:                 ELSE
905:                     THIS.txt_4c__Ds_GrEstoque.Value = ""
906:                 ENDIF
907:             ELSE
908:                 IF !EMPTY(ALLTRIM(THIS.txt_4c__Ds_GrEstoque.Value))
909:                     fAcessoContab(gc_4c_UsuarioLogado, "D", ALLTRIM(THIS.txt_4c__Ds_GrEstoque.Value), ;
910:                         THIS.txt_4c__Cd_GrEstoque, THIS.txt_4c__Ds_GrEstoque, loc_cConta)
911:                 ELSE
912:                     THIS.txt_4c__Cd_GrEstoque.Value = ""
913:                 ENDIF
914:             ENDIF
915:         CATCH TO loc_oErro
916:             MsgErro(loc_oErro.Message + CHR(13) + ;
917:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
918:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarGrEstoque")
919:         ENDTRY
920:     ENDPROC
921: 
922:     *--------------------------------------------------------------------------
923:     * CdEstoqueKeyPress / DsEstoqueKeyPress - Handlers de KeyPress da Conta de
924:     * Estoque (BINDEVENT exige PUBLIC - regra CLAUDE.md #3). Transcricao de
925:     * SIGPRGMI.get_cd_estoque.Valid / get_ds_estoque.Valid: os dois chamam
926:     * fAcessoContas (ja portada em utils\functions.prg) com o Grupo de
927:     * Estoque corrente como filtro - igual ao padrao ja usado em
928:     * FormSigPrCtr.ValidarContaFornecedor/ValidarDescricaoConta.
929:     *--------------------------------------------------------------------------
930:     PROCEDURE CdEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
931:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
932:             THIS.ValidarEstoque("C")
933:         ENDIF
934:     ENDPROC
935: 
936:     PROCEDURE DsEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
937:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
938:             THIS.ValidarEstoque("D")
939:         ENDIF
940:     ENDPROC
941: 
942:     *--------------------------------------------------------------------------
943:     * ValidarEstoque - par_cModo "C" (txt_4c__cd_estoque) ou "D"
944:     * (txt_4c__ds_estoque). Campo vazio limpa o PAR; preenchido delega a
945:     * fAcessoContas - achando sem acesso/match, exibe "Acesso Negado !!" (MsgAviso - icone 48 do legado) e
946:     * limpa os dois campos (transcricao do Messagebox+Value="" legado).
947:     *--------------------------------------------------------------------------
948:     PROCEDURE ValidarEstoque(par_cModo)
949:         LOCAL loc_cGrupo, loc_oErro
950: 
951:         IF VARTYPE(THIS.txt_4c__cd_estoque) != "O" OR VARTYPE(THIS.txt_4c__ds_estoque) != "O"
952:             RETURN
953:         ENDIF
954: 
955:         TRY
956:             loc_cGrupo = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
957: 
958:             IF par_cModo = "C"
959:                 IF !EMPTY(ALLTRIM(THIS.txt_4c__cd_estoque.Value))
960:                     IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", ALLTRIM(THIS.txt_4c__cd_estoque.Value), ;
961:                             THIS.txt_4c__cd_estoque, THIS.txt_4c__ds_estoque)
962:                         MsgAviso("Acesso Negado !!", "Aten" + CHR(231) + CHR(227) + "o")
963:                         THIS.txt_4c__cd_estoque.Value = ""
964:                         THIS.txt_4c__ds_estoque.Value = ""
965:                     ENDIF
966:                 ELSE
967:                     THIS.txt_4c__ds_estoque.Value = ""
968:                 ENDIF
969:             ELSE
970:                 IF !EMPTY(ALLTRIM(THIS.txt_4c__ds_estoque.Value))
971:                     IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", ALLTRIM(THIS.txt_4c__ds_estoque.Value), ;
972:                             THIS.txt_4c__cd_estoque, THIS.txt_4c__ds_estoque)
973:                         MsgAviso("Acesso Negado !!", "Aten" + CHR(231) + CHR(227) + "o")
974:                         THIS.txt_4c__ds_estoque.Value = ""
975:                         THIS.txt_4c__cd_estoque.Value = ""
976:                     ENDIF
977:                 ELSE
978:                     THIS.txt_4c__cd_estoque.Value = ""
979:                 ENDIF
980:             ENDIF
981:         CATCH TO loc_oErro
982:             MsgErro(loc_oErro.Message + CHR(13) + ;
983:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
984:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarEstoque")
985:         ENDTRY
986:     ENDPROC
987: 
988:     *--------------------------------------------------------------------------
989:     * LinhaKeyPress / DLinhaKeyPress - Handlers de KeyPress (BINDEVENT exige
990:     * PUBLIC - regra CLAUDE.md #3). F4(115) abre o lookup direto;
991:     * Enter(13)/Tab(9) disparam a validacao por match exato - equivalente ao
992:     * PROCEDURE Valid do legado (Get_Linha/Get_DLinha), que roda ao sair do
993:     * campo.
994:     *--------------------------------------------------------------------------
995:     PROCEDURE LinhaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
996:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
997:             THIS.AbrirLookupLinha(ALLTRIM(THIS.txt_4c_Linha.Value))
998:         ENDIF
999:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1000:             THIS.ValidarLinha()
1001:         ENDIF
1002:     ENDPROC
1003: 
1004:     PROCEDURE DLinhaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1005:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1006:             THIS.AbrirLookupLinha(ALLTRIM(THIS.txt_4c_DLinha.Value))
1007:         ENDIF
1008:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1009:             THIS.ValidarDLinha()
1010:         ENDIF
1011:     ENDPROC
1012: 
1013:     *--------------------------------------------------------------------------
1014:     * ValidarLinha - Transcricao de SIGPRGMI.Get_Linha.Valid: campo vazio
1015:     * limpa os dois campos (codigo + descricao); preenchido tenta match
1016:     * exato em SigCdLin.Linhas (equivalente ao "Select crSigCdLin / Set
1017:     * Order to Linhas / Seek(This.Value)" legado) e, sem match, abre o
1018:     * mesmo lookup que o F4 (equivalente ao fwBuscaSel do legado).
1019:     *--------------------------------------------------------------------------
1020:     PROCEDURE ValidarLinha()
1021:         LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oErro
1022: 
1023:         IF VARTYPE(THIS.txt_4c_Linha) != "O" OR VARTYPE(THIS.txt_4c_DLinha) != "O"
1024:             RETURN
1025:         ENDIF
1026: 
1027:         TRY
1028:             loc_cValor = ALLTRIM(THIS.txt_4c_Linha.Value)
1029:             IF EMPTY(loc_cValor)
1030:                 THIS.txt_4c_Linha.Value  = ""
1031:                 THIS.txt_4c_DLinha.Value = ""
1032:             ELSE
1033:                 IF USED("cursor_4c_LinhaVal")
1034:                     USE IN cursor_4c_LinhaVal
1035:                 ENDIF
1036:                 loc_cSQL = "SELECT Linhas, Descs FROM SigCdLin WHERE Linhas = " + EscaparSQL(loc_cValor)
1037:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhaVal")
1038:                 IF loc_nResultado > 0 AND USED("cursor_4c_LinhaVal") AND !EOF("cursor_4c_LinhaVal")
1039:                     SELECT cursor_4c_LinhaVal
1040:                     THIS.txt_4c_Linha.Value  = ALLTRIM(cursor_4c_LinhaVal.Linhas)
1041:                     THIS.txt_4c_DLinha.Value = ALLTRIM(cursor_4c_LinhaVal.Descs)
1042:                 ELSE
1043:                     THIS.AbrirLookupLinha(loc_cValor)
1044:                 ENDIF
1045:                 IF USED("cursor_4c_LinhaVal")
1046:                     USE IN cursor_4c_LinhaVal
1047:                 ENDIF
1048:             ENDIF
1049:         CATCH TO loc_oErro
1050:             MsgErro(loc_oErro.Message + CHR(13) + ;
1051:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1052:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarLinha")
1053:         ENDTRY
1054:     ENDPROC
1055: 
1056:     *--------------------------------------------------------------------------
1057:     * ValidarDLinha - Transcricao de SIGPRGMI.Get_DLinha.Valid: mesma logica
1058:     * de ValidarLinha, so que o match exato eh por SigCdLin.Descs
1059:     * (equivalente ao "Set Order to Descs" legado).
1060:     *--------------------------------------------------------------------------
1061:     PROCEDURE ValidarDLinha()
1062:         LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oErro
1063: 
1064:         IF VARTYPE(THIS.txt_4c_Linha) != "O" OR VARTYPE(THIS.txt_4c_DLinha) != "O"
1065:             RETURN
1066:         ENDIF
1067: 
1068:         TRY
1069:             loc_cValor = ALLTRIM(THIS.txt_4c_DLinha.Value)
1070:             IF EMPTY(loc_cValor)
1071:                 THIS.txt_4c_Linha.Value  = ""
1072:                 THIS.txt_4c_DLinha.Value = ""
1073:             ELSE
1074:                 IF USED("cursor_4c_LinhaVal")
1075:                     USE IN cursor_4c_LinhaVal
1076:                 ENDIF
1077:                 loc_cSQL = "SELECT Linhas, Descs FROM SigCdLin WHERE Descs = " + EscaparSQL(loc_cValor)
1078:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhaVal")
1079:                 IF loc_nResultado > 0 AND USED("cursor_4c_LinhaVal") AND !EOF("cursor_4c_LinhaVal")
1080:                     SELECT cursor_4c_LinhaVal
1081:                     THIS.txt_4c_Linha.Value  = ALLTRIM(cursor_4c_LinhaVal.Linhas)
1082:                     THIS.txt_4c_DLinha.Value = ALLTRIM(cursor_4c_LinhaVal.Descs)
1083:                 ELSE
1084:                     THIS.AbrirLookupLinha(loc_cValor)
1085:                 ENDIF
1086:                 IF USED("cursor_4c_LinhaVal")
1087:                     USE IN cursor_4c_LinhaVal
1088:                 ENDIF
1089:             ENDIF
1090:         CATCH TO loc_oErro
1091:             MsgErro(loc_oErro.Message + CHR(13) + ;
1092:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1093:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarDLinha")
1094:         ENDTRY
1095:     ENDPROC
1096: 
1097:     *--------------------------------------------------------------------------
1098:     * AbrirLookupLinha - Lookup de Linha de Producao via AbrirLookupCanonico
1099:     * (helper de FormBase, Pattern A - substitui o fwBuscaSel legado em
1100:     * crSigCdLin). Picker UNICO usado pelos dois campos (Linha/DLinha),
1101:     * igual ao legado onde os dois Valid abrem o MESMO fwBuscaSel e
1102:     * preenchem os dois campos ao selecionar.
1103:     *--------------------------------------------------------------------------
1104:     PROCEDURE AbrirLookupLinha(par_cValorFiltro)
1105:         IF VARTYPE(THIS.txt_4c_Linha) != "O" OR VARTYPE(THIS.txt_4c_DLinha) != "O"
1106:             RETURN
1107:         ENDIF
1108: 
1109:         THIS.AbrirLookupCanonico("SigCdLin", "Linhas", "Descs", ;
1110:             "Linhas de Produ" + CHR(231) + CHR(227) + "o", par_cValorFiltro, ;
1111:             THIS.txt_4c_Linha, THIS.txt_4c_DLinha)
1112:     ENDPROC
1113: 
1114:     *--------------------------------------------------------------------------
1115:     * NegativoKeyPress - Handler de KeyPress de txt_4c_Negativo (BINDEVENT
1116:     * exige PUBLIC - regra CLAUDE.md #3). Transcricao do PROCEDURE Valid
1117:     * legado ("Return Inlist(This.Value, "S","N")"): em VFP, Valid devolvendo
1118:     * .F. mantem o foco no campo - aqui reproduzido bloqueando Enter/Tab com
1119:     * NODEFAULT quando o valor digitado nao eh "S" nem "N".
1120:     *--------------------------------------------------------------------------
1121:     PROCEDURE NegativoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1122:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1123:             IF !INLIST(THIS.txt_4c_Negativo.Value, "S", "N")
1124:                 MsgAviso("Valor inv" + CHR(225) + "lido. Informe S ou N.", ;
1125:                     "Aten" + CHR(231) + CHR(227) + "o")
1126:                 NODEFAULT
1127:             ENDIF
1128:         ENDIF
1129:     ENDPROC
1130: 
1131:     *--------------------------------------------------------------------------
1132:     * AjustarOrdemTabulacao - Reproduz o TabIndex que o SIGPRGMI.SCX declara.
1133:     * Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que aqui
1134:     * poria os botoes Processar/Encerrar (criados na Fase 4) ANTES dos campos
1135:     * - divergencia que nao da erro, nao entra em log e nao aparece em
1136:     * screenshot: so o Tab andando na ordem errada.
1137:     *
1138:     * TabIndex eh gravavel em runtime, e a atribuicao tem de ser feita em
1139:     * ordem ASCENDENTE e DEPOIS de todos os AddObject - cada atribuicao poe o
1140:     * controle na posicao pedida e empurra os demais para tras.
1141:     *
1142:     * Numera SO os focalizaveis: Label tem TabIndex mas nao tem TabStop (nao
1143:     * recebe foco), entao transcrever o TabIndex dos 9 labels do dump seria
1144:     * inerte e ainda embaralharia a sequencia dos campos. Os botoes nao
1145:     * declaram TabIndex no dump (ficam no default da classe), por isso nao
1146:     * aparecem aqui.
1147:     *
1148:     * Valores do dump (focalizaveis desta fase): get_cd_empresa=2,
1149:     * get_ds_empresa=3, get_Cd_GrEstoque=4, get_Ds_GrEstoque=5,
1150:     * get_cd_estoque=6, get_ds_estoque=7, Get_Linha=8, Get_DLinha=9,
1151:     * Get_negativo=10, Get_Datai=11 (Fase 6).
1152:     *--------------------------------------------------------------------------
1153:     PROTECTED PROCEDURE AjustarOrdemTabulacao()
1154:         LOCAL loc_oErro
1155: 
1156:         TRY
1157:             THIS.txt_4c__cd_empresa.TabIndex   = 2
1158:             THIS.txt_4c__ds_empresa.TabIndex   = 3
1159:             THIS.txt_4c__Cd_GrEstoque.TabIndex = 4
1160:             THIS.txt_4c__Ds_GrEstoque.TabIndex = 5
1161:             THIS.txt_4c__cd_estoque.TabIndex   = 6
1162:             THIS.txt_4c__ds_estoque.TabIndex   = 7
1163:             THIS.txt_4c_Linha.TabIndex         = 8
1164:             THIS.txt_4c_DLinha.TabIndex        = 9
1165:             THIS.txt_4c_Negativo.TabIndex      = 10
1166:             THIS.txt_4c_Datai.TabIndex         = 11
1167:         CATCH TO loc_oErro
1168:             MsgErro(loc_oErro.Message + CHR(13) + ;
1169:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1170:                 "Procedure: " + loc_oErro.Procedure, "Erro em AjustarOrdemTabulacao")
1171:         ENDTRY
1172:     ENDPROC
1173: 
1174:     *--------------------------------------------------------------------------
1175:     * BtnProcessaClick - botao "Processar" (SIGPRGMI.Processa.Click).
1176:     * Sobe os criterios da tela para o BO (FormParaBO) e delega toda a
1177:     * validacao/geracao a SigPrGmiBO.Salvar() (BusinessBase), que chama
1178:     * ValidarDados() e, passando, Inserir() (transcricao do Click legado,
1179:     * ja implementada nas Fases 1-2). Regra CLAUDE.md #20 - o BusinessBase
1180:     * ja exibe a falha sozinho; o form so completa com o foco no campo que a
1181:     * validacao recusou (this_cCampoFoco).
1182:     *--------------------------------------------------------------------------
1183:     PROCEDURE BtnProcessaClick()
1184:         LOCAL loc_oErro
1185: 
1186:         TRY
1187:             THIS.this_oBusinessObject.NovoRegistro()
1188: 
1189:             IF THIS.FormParaBO()
1190:                 IF THIS.this_oBusinessObject.Salvar()
1191:                     MsgInfo("Pedido de Estoque M" + CHR(237) + "nimo gerado com sucesso!" + CHR(13) + ;
1192:                         "Itens gerados: " + TRANSFORM(THIS.this_oBusinessObject.this_nItensGerados) + CHR(13) + ;
1193:                         "N" + CHR(250) + "mero do Pedido: " + THIS.this_oBusinessObject.this_cNumeroPedido, ;
1194:                         "Confirmar")
1195:                     THIS.LimparCampos()
1196:                 ELSE
1197:                     IF !THIS.this_oBusinessObject.this_lErroExibido
1198:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar o pedido.", "Confirmar")
1199:                     ENDIF
1200:                     THIS.FocarCampoValidacao()
1201:                 ENDIF
1202:             ENDIF
1203:         CATCH TO loc_oErro
1204:             MsgErro(loc_oErro.Message + CHR(13) + ;
1205:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1206:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessaClick")
1207:         ENDTRY
1208:     ENDPROC
1209: 
1210:     *--------------------------------------------------------------------------
1211:     * BtnEncerrarClick - botao "Encerrar" (SIGPRGMI.Cancela.Click:
1212:     * "ThisForm.Release"). Release() fica FORA de qualquer TRY (regra
1213:     * CLAUDE.md #1) - liberar o proprio form de dentro do bloco derrubaria a
1214:     * pilha de execucao dentro dele.
1215:     *--------------------------------------------------------------------------
1216:     PROCEDURE BtnEncerrarClick()
1217:         THIS.Release()
1218:     ENDPROC
1219: 
1220:     *--------------------------------------------------------------------------
1221:     * FormParaBO - Transfere os criterios da tela para o Business Object,
1222:     * imediatamente antes de THIS.this_oBusinessObject.Salvar().
1223:     *--------------------------------------------------------------------------
1224:     PROTECTED FUNCTION FormParaBO()
1225:         LOCAL loc_lSucesso, loc_oErro
1226:         loc_lSucesso = .T.
1227: 
1228:         TRY
1229:             WITH THIS.this_oBusinessObject
1230:                 .this_cCdEmpresa   = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
1231:                 .this_cDsEmpresa   = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
1232:                 .this_cCdGrEstoque = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
1233:                 .this_cDsGrEstoque = ALLTRIM(THIS.txt_4c__Ds_GrEstoque.Value)
1234:                 .this_cCdEstoque   = ALLTRIM(THIS.txt_4c__cd_estoque.Value)
1235:                 .this_cDsEstoque   = ALLTRIM(THIS.txt_4c__ds_estoque.Value)
1236:                 .this_cLinha       = ALLTRIM(THIS.txt_4c_Linha.Value)
1237:                 .this_cDLinha      = ALLTRIM(THIS.txt_4c_DLinha.Value)
1238:                 .this_cNegativo    = ALLTRIM(THIS.txt_4c_Negativo.Value)
1239:                 .this_dDatai       = ConverterParaData(THIS.txt_4c_Datai.Value)
1240:             ENDWITH
1241:         CATCH TO loc_oErro
1242:             loc_lSucesso = .F.
1243:             MsgErro(loc_oErro.Message + CHR(13) + ;
1244:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1245:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
1246:         ENDTRY
1247: 
1248:         RETURN loc_lSucesso
1249:     ENDFUNC
1250: 
1251:     *--------------------------------------------------------------------------
1252:     * BOParaForm - Estado inicial da tela. this_dDatai do BO comeca em
1253:     * DATE() (SigPrGmiBO.Init, usado como sentinela interno de Inserir()) -
1254:     * o campo de tela transcreve o Init legado ("ThisForm.Get_Datai.Value =
1255:     * Date() - 7"), que eh um default de FILTRO, nao o valor que o BO guarda;
1256:     * FormParaBO sobe de volta o que o usuario deixar na tela antes de
1257:     * Processar. Os demais criterios nascem em branco (sem registro corrente
1258:     * neste form - ele so dispara um processamento).
1259:     *--------------------------------------------------------------------------
1260:     PROTECTED PROCEDURE BOParaForm()
1261:         LOCAL loc_oErro
1262: 
1263:         TRY
1264:             THIS.txt_4c__cd_empresa.Value   = ""
1265:             THIS.txt_4c__ds_empresa.Value   = ""
1266:             THIS.txt_4c__Cd_GrEstoque.Value = ""
1267:             THIS.txt_4c__Ds_GrEstoque.Value = ""
1268:             THIS.txt_4c__cd_estoque.Value   = ""
1269:             THIS.txt_4c__ds_estoque.Value   = ""
1270:             THIS.txt_4c_Linha.Value         = ""
1271:             THIS.txt_4c_DLinha.Value        = ""
1272:             THIS.txt_4c_Negativo.Value      = "N"
1273:             THIS.txt_4c_Datai.Value         = DATE() - 7
1274:         CATCH TO loc_oErro
1275:             MsgErro(loc_oErro.Message + CHR(13) + ;
1276:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1277:                 "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
1278:         ENDTRY
1279:     ENDPROC
1280: 
1281:     *--------------------------------------------------------------------------
1282:     * LimparCampos - Reinicia a tela de criterios apos um Processar com
1283:     * sucesso, para a proxima geracao (este form nao tem conceito de
1284:     * registro/edicao - cada clique em Processar eh autonomo, sem vinculo
1285:     * com o anterior).
1286:     *--------------------------------------------------------------------------
1287:     PROTECTED PROCEDURE LimparCampos()
1288:         LOCAL loc_oErro
1289: 
1290:         TRY
1291:             THIS.BOParaForm()
1292:             THIS.txt_4c__cd_empresa.SetFocus()
1293:         CATCH TO loc_oErro
1294:             MsgErro(loc_oErro.Message + CHR(13) + ;
1295:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1296:                 "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
1297:         ENDTRY
1298:     ENDPROC
1299: 
1300:     *--------------------------------------------------------------------------
1301:     * FocarCampoValidacao - Leva o foco para o campo que SigPrGmiBO.
1302:     * ValidarDados() recusou (this_cCampoFoco). Regra CLAUDE.md #34:
1303:     * alcancar membro por NOME exige EVALUATE, nunca Controls(nome).
1304:     *--------------------------------------------------------------------------
1305:     PROTECTED PROCEDURE FocarCampoValidacao()
1306:         LOCAL loc_cCampo, loc_oCampo, loc_oErro
1307: 
1308:         TRY
1309:             loc_cCampo = ALLTRIM(THIS.this_oBusinessObject.this_cCampoFoco)
1310: 
1311:             IF !EMPTY(loc_cCampo) AND TYPE("THIS." + loc_cCampo) = "O"
1312:                 *-- Regra #34: membro por NOME so via EVALUATE, e o resultado
1313:                 *-- precisa de variavel - VFP9 nao aceita EVALUATE(...).SetFocus()
1314:                 loc_oCampo = EVALUATE("THIS." + loc_cCampo)
1315:                 IF VARTYPE(loc_oCampo) = "O"
1316:                     loc_oCampo.SetFocus()
1317:                 ENDIF
1318:             ENDIF
1319:         CATCH TO loc_oErro
1320:             *-- Foco e so uma conveniencia de UX (a mensagem de validacao ja
1321:             *-- foi exibida pelo BO) - regra CLAUDE.md #9 exige MsgErro no
1322:             *-- minimo, mesmo aqui.
1323:             MsgErro(loc_oErro.Message, "Erro em FocarCampoValidacao")
1324:         ENDTRY
1325:     ENDPROC
1326: 
1327:     *--------------------------------------------------------------------------
1328:     * TornarControlesVisiveis - Torna visiveis recursivamente todos os
1329:     * controles do form. SIGPRGMI nao tem containers flutuantes (nenhum
1330:     * Container com Visible=.F. toggled por botao no dump) - por isso nao
1331:     * ha lista de exclusao (diferente de FormSigPrGlp).
1332:     *--------------------------------------------------------------------------
1333:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1334:         LOCAL loc_nI, loc_oObjeto
1335: 
1336:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1337:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1338: 
1339:             IF VARTYPE(loc_oObjeto) = "O"
1340:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1341:                     loc_oObjeto.Visible = .T.
1342:                 ENDIF
1343: 
1344:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1345:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1346:                 ENDIF
1347:             ENDIF
1348:         ENDFOR
1349:     ENDPROC
1350: 
1351: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGmiBO.prg):
*============================================================================
* SigPrGmiBO.prg - Business Object para Geracao de Pedido de Estoque Minimo
*
* Form legado: SIGPRGMI (form generico, OPERACIONAL - sem CRUD de registro)
* Tabelas manipuladas pelo processamento (Processa.Click do legado):
*   SigMvCab  (cabecalho do movimento/pedido gerado)
*   SigMvItn  (itens do movimento/pedido gerado)
*   SigCdLin  (linhas de producao - lookup)
*   SigCdEmp  (empresas - lookup, Cemps/Razas)
*   SigCdCli  (contas de estoque / grupos de estoque - lookup via fAcessoContas/fAcessoContab)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - CarregarDoCursor/ValidarDados/Inserir/
*                ObterChavePrimaria/RegistrarAuditoria + logica real do
*                Processa.Click legado (geracao do pedido de estoque minimo)
*
* NOTA DE ARQUITETURA - Inserir()/Atualizar():
* Este processo SO GERA pedidos novos (SigMvCab/SigMvItn); o legado nao tem
* equivalente de "alterar" um pedido ja gerado atraves desta tela. O form
* (Fase 3+) chama NovoRegistro() + FormParaBO() + Salvar() a cada clique em
* "Processar" - this_lNovoRegistro fica sempre .T., entao Salvar() sempre
* delega a Inserir() (nunca a Atualizar()). Por isso Atualizar() e
* ExecutarExclusao() permanecem SEM override: o comportamento padrao herdado
* de BusinessBase (recusar a operacao) ja eh o correto, porque esses dois
* caminhos nunca sao acionados por este form.
*============================================================================

DEFINE CLASS SigPrGmiBO AS BusinessBase

    *==========================================================================
    * Propriedades - criterios de filtro/processamento (Get_* do form legado)
    * Este form NAO cadastra um registro unico: ele dispara um PROCESSAMENTO
    * (geracao de pedido de estoque minimo) a partir destes criterios.
    *==========================================================================
    this_cCdEmpresa   = ""    && char(3)  - Codigo da empresa (SigCdEmp.Cemps)
    this_cDsEmpresa   = ""    && char(40) - Descricao da empresa (SigCdEmp.Razas, exibicao)

    this_cCdGrEstoque = ""    && char     - Codigo do Grupo de Estoque (SigCdCli, lookup fAcessoContab)
    this_cDsGrEstoque = ""    && char     - Descricao do Grupo de Estoque (exibicao)

    this_cCdEstoque   = ""    && char     - Codigo da Conta de Estoque (SigCdCli, lookup fAcessoContas)
    this_cDsEstoque   = ""    && char     - Descricao da Conta de Estoque (exibicao)

    this_cLinha       = ""    && char     - Codigo da Linha de Producao (SigCdLin.Linhas)
    this_cDLinha      = ""    && char     - Descricao da Linha de Producao (SigCdLin.Descs)

    this_cNegativo    = "N"   && char(1)  - Somente Negativos (S/N)
    this_dDatai       = {}    && date     - Data de Geracao do pedido

    *==========================================================================
    * Resultado do lookup de Linha (SigCdLin.Pedidos) - a operacao usada para
    * gerar os pedidos (equivalente a "lcOperacao" do Processa.Click legado).
    * Resolvido em CarregarDoCursor() (apos picker) e revalidado em
    * ValidarDados() (o legado faz a MESMA conferencia de novo no Click, sem
    * confiar no que a tela ja tinha resolvido no Valid).
    *==========================================================================
    this_cOperacaoGerada = ""   && char(20) - SigCdLin.Pedidos da linha escolhida

    *==========================================================================
    * Propriedade de controle de UI (consistente com ProdutoBO/outros BOs do
    * projeto): o form faz SetFocus no controle indicado quando ValidarDados
    * recusa a operacao.
    *==========================================================================
    this_cCampoFoco = ""

    *==========================================================================
    * Propriedade interna de auditoria - a chave do cabecalho (SigMvCab.
    * CidChaves) RECEM-GERADO, usada por ObterChavePrimaria()/
    * RegistrarAuditoria() dentro do laco de Inserir() (mais de um cabecalho
    * pode ser gerado numa unica execucao - um por fornecedor distinto).
    *==========================================================================
    this_cCidChavesAtual = ""

    *==========================================================================
    * Propriedades de controle do processamento (resultado da ultima execucao)
    *==========================================================================
    this_nItensGerados = 0    && Quantidade de itens incluidos no(s) pedido(s) gerado(s)
    this_cNumeroPedido  = ""  && Numero (Numes) do ULTIMO cabecalho gerado na ultima execucao

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "cidchaves"
            THIS.this_dDatai      = DATE()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - chave do ULTIMO cabecalho (SigMvCab.CidChaves)
    * gravado por Inserir(); usada por RegistrarAuditoria(), chamado DENTRO do
    * laco de geracao (um registro de auditoria por cabecalho criado, ja que
    * um unico Processar pode gerar varios cabecalhos - um por fornecedor).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChavesAtual
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - carrega o resultado do picker/seek de Linha de
    * Producao (cursor com as colunas Linhas/Descs/Pedidos de SigCdLin,
    * equivalente ao "This.Parent.Get_Linha.Value = crSigCdLin.Linhas /
    * This.Parent.Get_dLinha.Value = crSigCdLin.Descs" do Get_Linha.Valid /
    * Get_DLinha.Valid legado).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cLinha          = PADR(ALLTRIM(TratarNulo(Linhas, "")), 10)
                THIS.this_cDLinha         = ALLTRIM(TratarNulo(Descs, ""))
                THIS.this_cOperacaoGerada = PADR(ALLTRIM(TratarNulo(Pedidos, "")), 20)
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarDados - transcricao dos IsEmpty()/Seek() do inicio do
    * Processa.Click legado. O legado usa Messagebox()+SetFocus; aqui
    * this_cMensagemErro + this_cCampoFoco (o form faz o SetFocus) - quem
    * EXIBE a mensagem eh BusinessBase.Salvar()/ExibirFalha (regra do
    * CLAUDE.md: falha nunca eh muda).
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_cLinha, loc_nResultado, loc_oErro

        loc_lValido = .T.
        THIS.this_cCampoFoco = ""

        IF EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Empresa..."
            THIS.this_cCampoFoco    = "txt_4c__cd_empresa"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cCdGrEstoque))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar o Grupo..."
            THIS.this_cCampoFoco    = "txt_4c__Cd_GrEstoque"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cCdEstoque))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Conta..."
            THIS.this_cCampoFoco    = "txt_4c__cd_estoque"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cLinha))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Linha..."
            THIS.this_cCampoFoco    = "txt_4c_Linha"
            loc_lValido = .F.
        ENDIF

        *-- Select crSigCdLin / Set Order to Linhas / If !Seek(lcLinha) ...
        *-- Endif / If IsEmpty(crSigCdLin.Pedidos) ... Endif - revalidado aqui
        *-- sem confiar no que o picker/Valid ja tinha resolvido.
        *-- TRY/CATCH proprio: SQLEXEC com gnConnHandle invalido DISPARA
        *-- excecao em vez de devolver -1 (nao chegaria no IF abaixo).
        IF loc_lValido
            loc_cLinha = PADR(ALLTRIM(THIS.this_cLinha), 10)

            TRY
                IF USED("cursor_4c_LinhaChk")
                    USE IN cursor_4c_LinhaChk
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT descs, linhas, pedidos FROM SigCdLin WHERE linhas = " + ;
                    EscaparSQL(loc_cLinha), "cursor_4c_LinhaChk")

                IF loc_nResultado < 0 OR !USED("cursor_4c_LinhaChk") OR EOF("cursor_4c_LinhaChk")
                    THIS.this_cMensagemErro = "Esta Linha de Produ" + CHR(231) + CHR(227) + "o n" + ;
                        CHR(227) + "o est" + CHR(225) + " cadastrada..."
                    THIS.this_cCampoFoco    = "txt_4c_Linha"
                    loc_lValido = .F.
                ELSE
                    IF EMPTY(ALLTRIM(TratarNulo(cursor_4c_LinhaChk.pedidos, "")))
                        THIS.this_cMensagemErro = "Esta Linha de Produ" + CHR(231) + CHR(227) + "o n" + ;
                            CHR(227) + "o possui uma Opera" + CHR(231) + CHR(227) + "o cadastrada..."
                        THIS.this_cCampoFoco    = "txt_4c_Linha"
                        loc_lValido = .F.
                    ELSE
                        THIS.this_cOperacaoGerada = PADR(ALLTRIM(cursor_4c_LinhaChk.pedidos), 20)
                    ENDIF
                ENDIF

                IF USED("cursor_4c_LinhaChk")
                    USE IN cursor_4c_LinhaChk
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                THIS.this_cCampoFoco    = "txt_4c_Linha"
                loc_lValido = .F.
            ENDTRY
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * Inserir - transcricao de SIGPRGMI.Processa.Click. Gera o(s) pedido(s)
    * de estoque minimo (SigMvCab/SigMvItn) a partir dos criterios (Empresa/
    * Grupo/Conta/Linha/Negativo/Data) ja validados por ValidarDados().
    *
    * Arquitetura: os cabecalhos/itens sao acumulados em cursores LOCAIS com
    * a estrutura COMPLETA das tabelas reais (AbrirCursorTabela), igual ao
    * padrao ja usado em SigPrGlxBO/SigPrGlpBO - garante cobertura de TODA
    * coluna NOT NULL sem enumerar ~140 colunas a mao (regra #22 do
    * CLAUDE.md) - e so ao final sao persistidos via PersistirCursor +
    * SQLCOMMIT/SQLROLLBACK (a conexao nasce em modo manual - Transactions=2
    * - sem nenhum commit implicito; ver memoria feedback_conexao_sql_
    * transactions_2_sem_commit).
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lErro, loc_cEmpresa, loc_cGrupo, loc_cConta, loc_cLinha, ;
            loc_cOperacao, loc_dData, loc_cSQL, loc_cChaveEst, ;
            loc_cFornece, loc_nItens, loc_nNumero, loc_cEmpDopNums, loc_cGruOrigs, ;
            loc_nOpers, loc_nTotalReg, loc_oProg, loc_oErro

        loc_lErro = .F.
        THIS.this_nItensGerados = 0
        THIS.this_cNumeroPedido = ""

        loc_cEmpresa  = PADR(ALLTRIM(THIS.this_cCdEmpresa), 3)
        loc_cGrupo    = PADR(ALLTRIM(THIS.this_cCdGrEstoque), 10)
        loc_cConta    = PADR(ALLTRIM(THIS.this_cCdEstoque), 10)
        loc_cLinha    = PADR(ALLTRIM(THIS.this_cLinha), 10)
        loc_cOperacao = PADR(ALLTRIM(THIS.this_cOperacaoGerada), 20)
        loc_dData     = THIS.this_dDatai

        TRY
            *-- 1) monta crTemp1/crTemp2 (ou crTemp3) e TmpMinimo, conforme o
            *-- criterio "Somente Negativos"
            IF UPPER(ALLTRIM(THIS.this_cNegativo)) != "S"

                loc_cSQL = "SELECT E.Emps, E.Grupos, E.Estos, E.CPros, E.SQtds, " + ;
                    "P.QMins, P.IFors, P.PVens, P.Moevs, P.Dpros " + ;
                    "FROM SigMvEst E, SigCdPro P " + ;
                    "WHERE E.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                    " AND E.Grupos = " + EscaparSQL(loc_cGrupo) + ;
                    " AND E.Estos = " + EscaparSQL(loc_cConta) + ;
                    " AND E.CPros = P.CPros AND E.SQtds < P.QMins" + ;
                    " AND P.Linhas = " + EscaparSQL(loc_cLinha) + ;
                    " AND P.Situas = 1 AND P.QMins > 0"

                IF !THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Temp1", "crTemp1")
                    loc_lErro = .T.
                ENDIF

                *-- Chave POSICIONAL (regra #42 do CLAUDE.md): empgruests eh
                *-- char(23) = emps(3)+grupos(10)+estos(10) - PADR explicito,
                *-- nunca ALLTRIM/concatenacao direta das partes.
                IF !loc_lErro
                    loc_cChaveEst = PADR(loc_cEmpresa, 3) + PADR(loc_cGrupo, 10) + PADR(loc_cConta, 10)

                    loc_cSQL = "SELECT CPros, QMins, IFors, PVens, Moevs, Dpros " + ;
                        "FROM SigCdPro " + ;
                        "WHERE Linhas = " + EscaparSQL(loc_cLinha) + ;
                        " AND QMins > 0 AND Situas = 1" + ;
                        " AND " + EscaparSQL(loc_cChaveEst) + " + CPros NOT IN " + ;
                        "(SELECT empgruests + CPros FROM SigMvEst)"

                    IF !THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Temp2", "crTemp2")
                        loc_lErro = .T.
                    ENDIF
                ENDIF

                IF !loc_lErro
                    IF USED("cursor_4c_Minimo")
                        USE IN cursor_4c_Minimo
                    ENDIF

                    SELECT Emps, Grupos, Estos, CPros, SQtds, QMins, QMins - SQtds AS DifProds, ;
                            IFors, PVens, Moevs, Dpros ;
                        FROM cursor_4c_Temp1 ;
                        WHERE Emps = m.loc_cEmpresa AND Grupos = m.loc_cGrupo AND Estos = m.loc_cConta ;
                            AND SQtds < QMins AND QMins > 0 ;
                        UNION ALL ;
                        SELECT PADR(m.loc_cEmpresa, 3) AS Emps, PADR(m.loc_cGrupo, 10) AS Grupos, ;
                                PADR(m.loc_cConta, 10) AS Estos, CPros, 00000000.000 AS SQtds, ;
                                QMins, QMins AS DifProds, IFors, PVens, Moevs, Dpros ;
                        FROM cursor_4c_Temp2 ;
                        INTO CURSOR cursor_4c_Minimo READWRITE
                ENDIF

            ELSE

                loc_cSQL = "SELECT E.Emps, E.Grupos, E.Estos, E.CPros, E.SQtds, " + ;
                    "P.IFors, P.PVens, P.Moevs, P.Dpros " + ;
                    "FROM SigMvEst E, SigCdPro P " + ;
                    "WHERE E.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                    " AND E.Grupos = " + EscaparSQL(loc_cGrupo) + ;
                    " AND E.Estos = " + EscaparSQL(loc_cConta) + ;
                    " AND E.CPros = P.CPros AND E.SQtds < 0" + ;
                    " AND P.Linhas = " + EscaparSQL(loc_cLinha) + ;
                    " AND P.Situas = 1"

                IF !THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Temp3", "crTemp3")
                    loc_lErro = .T.
                ENDIF

                IF !loc_lErro
                    IF USED("cursor_4c_Minimo")
                        USE IN cursor_4c_Minimo
                    ENDIF

                    SELECT Emps, Grupos, Estos, CPros, SQtds, 0 AS QMins, ABS(SQtds) AS DifProds, ;
                            IFors, PVens, Moevs, Dpros ;
                        FROM cursor_4c_Temp3 ;
                        INTO CURSOR cursor_4c_Minimo READWRITE
                ENDIF

            ENDIF

            IF !loc_lErro
                SELECT cursor_4c_Minimo
                GO TOP
                IF EOF()
                    THIS.this_cMensagemErro = "Nenhum produto selecionado..."
                    loc_lErro = .T.
                ENDIF
            ENDIF

            *-- 2) TmpPedidos (producao ja em andamento) e TmpProd (saldo que
            *-- realmente falta produzir)
            IF !loc_lErro
                loc_cSQL = "SELECT I.CPros, I.Qtds, I.QtBxProds " + ;
                    "FROM SigMvCab E, SigMvItn I, SigCdOpe O " + ;
                    "WHERE E.Dopes = O.Dopes AND E.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                    " AND (O.Globalizas = 1 OR O.Globalizas = 2)" + ;
                    " AND E.Grupods = " + EscaparSQL(loc_cGrupo) + ;
                    " AND E.Contads = " + EscaparSQL(loc_cConta) + ;
                    " AND E.EmpDopNums = I.EmpDopNums"

                IF !THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Temp4", "crTemp4")
                    loc_lErro = .T.
                ENDIF
            ENDIF

            IF !loc_lErro
                IF USED("cursor_4c_Pedidos")
                    USE IN cursor_4c_Pedidos
                ENDIF

                SELECT CPros, SUM(Qtds - QtBxProds) AS Produzindo ;
                    FROM cursor_4c_Temp4 ;
                    GROUP BY CPros ;
                    INTO CURSOR cursor_4c_Pedidos READWRITE

                SELECT cursor_4c_Pedidos
                INDEX ON CPros TAG CPros

                SELECT cursor_4c_Minimo
                INDEX ON IFors + CPros TAG ForProd

                IF USED("cursor_4c_Prod")
                    USE IN cursor_4c_Prod
                ENDIF

                SELECT M.CPros, M.IFors, M.PVens, M.Moevs, M.Dpros, ;
                        M.DifProds - IIF(ISNULL(P.Produzindo), 0, P.Produzindo) AS Qtds ;
                    FROM cursor_4c_Minimo M LEFT JOIN cursor_4c_Pedidos P ON M.CPros = P.CPros ;
                    WHERE M.DifProds > IIF(ISNULL(P.Produzindo), 0, P.Produzindo) ;
                    INTO CURSOR cursor_4c_Prod READWRITE

                SELECT cursor_4c_Prod
                GO TOP
                IF EOF()
                    THIS.this_cMensagemErro = "Nenhum produto selecionado..."
                    loc_lErro = .T.
                ELSE
                    INDEX ON IFors + CPros TAG ForProd
                    COUNT TO loc_nTotalReg
                ENDIF
            ENDIF

            *-- 3) cursores destino (cabecalho/itens) com a estrutura REAL e
            *-- COMPLETA das tabelas - nasce vazio, igual ao "Select crXxx /
            *-- Zap" do topo do processamento legado
            IF !loc_lErro
                IF !THIS.AbrirCursorTabela("cursor_4c_MvCab", "SigMvCab")
                    loc_lErro = .T.
                ENDIF
            ENDIF
            IF !loc_lErro
                IF !THIS.AbrirCursorTabela("cursor_4c_MvItn", "SigMvItn")
                    loc_lErro = .T.
                ENDIF
            ENDIF

            *-- 4) laco principal - um cabecalho por fornecedor (IFors)
            *-- distinto, itens sequenciais dentro de cada cabecalho
            IF !loc_lErro
                loc_oProg = CREATEOBJECT("fwprogressbar", "Processando Pedidos...", loc_nTotalReg)
                loc_oProg.Show()

                loc_cFornece = REPLICATE(CHR(255), 10)
                loc_nItens   = 0
                loc_nNumero  = 0
                loc_nOpers   = 0

                SELECT cursor_4c_Prod
                SCAN
                    loc_oProg.Update(.T.)

                    IF loc_cFornece != cursor_4c_Prod.IFors
                        loc_nNumero  = fGerUniqueKey(ALLTRIM(loc_cOperacao) + loc_cEmpresa)
                        loc_cFornece = cursor_4c_Prod.IFors

                        IF loc_nNumero = 0
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                "N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar o n" + ;
                                CHR(250) + "mero do pedido."
                            loc_lErro = .T.
                            EXIT
                        ENDIF

                        IF USED("cursor_4c_SigCdOpe")
                            USE IN cursor_4c_SigCdOpe
                        ENDIF

                        IF !THIS.ExecutarSQL( ;
                                "SELECT Dopes, GruOrigs, Opers FROM SigCdOpe WHERE Dopes = " + ;
                                EscaparSQL(loc_cOperacao), "cursor_4c_SigCdOpe", "crSigCdOpe")
                            loc_lErro = .T.
                            EXIT
                        ENDIF

                        loc_cGruOrigs = "ESTOQUE"
                        loc_nOpers    = 0
                        IF USED("cursor_4c_SigCdOpe") AND !EOF("cursor_4c_SigCdOpe")
                            IF !EMPTY(ALLTRIM(TratarNulo(cursor_4c_SigCdOpe.GruOrigs, "")))
                                loc_cGruOrigs = ALLTRIM(cursor_4c_SigCdOpe.GruOrigs)
                            ENDIF
                            loc_nOpers = TratarNulo(cursor_4c_SigCdOpe.Opers, 0)
                        ENDIF

                        *-- EmpDopNums eh chave POSICIONAL (regra #42): char(29)
                        *-- = emps(3) + dopes(20) + Str(numes,6) - PADR explicito.
                        loc_cEmpDopNums = PADR(loc_cEmpresa, 3) + PADR(loc_cOperacao, 20) + STR(loc_nNumero, 6)

                        SELECT cursor_4c_MvCab
                        APPEND BLANK
                        REPLACE Emps       WITH loc_cEmpresa, ;
                                Dopes      WITH PADR(loc_cOperacao, 20), ;
                                Numes      WITH loc_nNumero, ;
                                Datas      WITH loc_dData, ;
                                Datars     WITH loc_dData, ;
                                MascNum    WITH ALLTRIM(fGerMascara(loc_nNumero)), ;
                                Grupoos    WITH PADR(loc_cGruOrigs, 10), ;
                                Contaos    WITH PADR(loc_cFornece, 10), ;
                                Grupods    WITH PADR(loc_cGrupo, 10), ;
                                Contads    WITH PADR(loc_cConta, 10), ;
                                Usuars     WITH PADR(ALLTRIM(TratarNulo(gc_4c_UsuarioLogado, "")), 10), ;
                                EmpDopNums WITH loc_cEmpDopNums, ;
                                CidChaves  WITH fUniqueIds(), ;
                                DtAlts     WITH DATE()

                        THIS.this_cCidChavesAtual = ALLTRIM(cursor_4c_MvCab.CidChaves)
                        THIS.RegistrarAuditoria("INSERT")
                        THIS.this_cNumeroPedido = TRANSFORM(loc_nNumero)

                        loc_nItens = 0
                    ENDIF

                    loc_nItens = loc_nItens + 1

                    SELECT cursor_4c_MvItn
                    APPEND BLANK
                    REPLACE Emps       WITH loc_cEmpresa, ;
                            Dopes      WITH PADR(loc_cOperacao, 20), ;
                            Numes      WITH loc_nNumero, ;
                            CItens     WITH loc_nItens, ;
                            CPros      WITH cursor_4c_Prod.CPros, ;
                            Qtds       WITH cursor_4c_Prod.Qtds, ;
                            Units      WITH cursor_4c_Prod.PVens, ;
                            Moedas     WITH cursor_4c_Prod.Moevs, ;
                            opers      WITH IIF(loc_nOpers = 1, "E", "S"), ;
                            totas      WITH (cursor_4c_Prod.Qtds * cursor_4c_Prod.PVens), ;
                            dpros      WITH cursor_4c_Prod.Dpros, ;
                            EmpDopNums WITH loc_cEmpDopNums, ;
                            CidChaves  WITH fUniqueIds(), ;
                            DtAlts     WITH DATE()

                    SELECT cursor_4c_MvCab
                    REPLACE ValInis WITH ValInis + (cursor_4c_Prod.PVens * cursor_4c_Prod.Qtds), ;
                            Valos   WITH Valos   + (cursor_4c_Prod.PVens * cursor_4c_Prod.Qtds), ;
                            DtAlts  WITH DATE()

                    THIS.this_nItensGerados = THIS.this_nItensGerados + 1

                    SELECT cursor_4c_Prod
                ENDSCAN

                loc_oProg.Complete(.T.)
                loc_oProg = .NULL.
            ENDIF

            *-- 5) persiste os dois cursores locais nas tabelas reais e fecha
            *-- a transacao manual (Transactions = 2) - um unico commit cobre
            *-- os dois PersistirCursor + os RegistrarAuditoria do laco acima
            IF !loc_lErro
                IF !THIS.PersistirCursor("cursor_4c_MvCab", "SigMvCab")
                    loc_lErro = .T.
                ENDIF
            ENDIF
            IF !loc_lErro
                IF !THIS.PersistirCursor("cursor_4c_MvItn", "SigMvItn")
                    loc_lErro = .T.
                ENDIF
            ENDIF

            IF !loc_lErro
                IF SQLCOMMIT(gnConnHandle) < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "(Commit) " + CapturarErroSQL()
                    loc_lErro = .T.
                ENDIF
            ENDIF

            IF loc_lErro
                = SQLROLLBACK(gnConnHandle)
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lErro = .T.
            = SQLROLLBACK(gnConnHandle)
        ENDTRY

        *-- limpeza dos cursores temporarios (regra #1: fora do TRY/CATCH so
        *-- por causa do RETURN; aqui eh so organizacao)
        IF USED("cursor_4c_Temp1")
            USE IN cursor_4c_Temp1
        ENDIF
        IF USED("cursor_4c_Temp2")
            USE IN cursor_4c_Temp2
        ENDIF
        IF USED("cursor_4c_Temp3")
            USE IN cursor_4c_Temp3
        ENDIF
        IF USED("cursor_4c_Temp4")
            USE IN cursor_4c_Temp4
        ENDIF
        IF USED("cursor_4c_Minimo")
            USE IN cursor_4c_Minimo
        ENDIF
        IF USED("cursor_4c_Pedidos")
            USE IN cursor_4c_Pedidos
        ENDIF
        IF USED("cursor_4c_Prod")
            USE IN cursor_4c_Prod
        ENDIF
        IF USED("cursor_4c_SigCdOpe")
            USE IN cursor_4c_SigCdOpe
        ENDIF
        IF USED("cursor_4c_MvCab")
            USE IN cursor_4c_MvCab
        ENDIF
        IF USED("cursor_4c_MvItn")
            USE IN cursor_4c_MvItn
        ENDIF

        RETURN !loc_lErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarSQL - SQLEXEC pass-through preservando a area de trabalho
    * corrente (o chamador pode estar no meio de um SCAN de outro cursor).
    * Mesmo helper generico ja usado em SigPrGlxBO/SigPrGlpBO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor, par_cRotulo)
        LOCAL loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        IF VARTYPE(par_cCursor) = "C" AND !EMPTY(par_cCursor)
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)
        ELSE
            loc_nRet = SQLEXEC(gnConnHandle, par_cSQL)
        ENDIF

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0)

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirCursorTabela - cria (ou recria VAZIO) um cursor READWRITE com a
    * estrutura COMPLETA da tabela informada - garante que PersistirCursor()
    * cubra toda coluna NOT NULL da tabela destino (regra #22 do CLAUDE.md).
    * Mesmo helper generico ja usado em SigPrGlxBO/SigPrGlpBO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AbrirCursorTabela(par_cCursor, par_cTabela)
        LOCAL loc_nRet, loc_lOk
        loc_lOk = .F.

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        IF USED("cursor_4c_Estrut")
            USE IN cursor_4c_Estrut
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT * FROM " + par_cTabela + " WHERE 1 = 0", "cursor_4c_Estrut")

        IF loc_nRet >= 0 AND USED("cursor_4c_Estrut")
            SELECT * FROM cursor_4c_Estrut WHERE .F. INTO CURSOR (par_cCursor) READWRITE
            USE IN cursor_4c_Estrut
            loc_lOk = USED(par_cCursor)
        ENDIF

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(estrutura de " + par_cTabela + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValorSQLDeCampo - formata UM campo do cursor para o VALUES do INSERT,
    * pelo TIPO VFP do campo (nunca por palpite de nome) - helpers canonicos
    * do projeto, que ja devolvem COM aspas. Mesmo helper generico ja usado
    * em SigPrGlxBO/SigPrGlpBO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValorSQLDeCampo(par_cCursor, par_cCampo, par_cTipo, par_nDec)
        LOCAL loc_uValor, loc_cRet

        loc_uValor = EVALUATE(par_cCursor + "." + par_cCampo)

        DO CASE
            CASE par_cTipo $ "CMVQ"
                loc_cRet = EscaparSQL(TratarNulo(loc_uValor, ""))
            CASE par_cTipo $ "NFIBY"
                loc_cRet = FormatarNumeroSQL(TratarNulo(loc_uValor, 0), par_nDec)
            CASE par_cTipo = "L"
                loc_cRet = IIF(TratarNulo(loc_uValor, .F.), "1", "0")
            CASE par_cTipo $ "DT"
                loc_cRet = FormatarDataSQL(TratarNulo(loc_uValor, {}))
            OTHERWISE
                loc_cRet = "NULL"
        ENDCASE

        RETURN loc_cRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * PersistirCursor - grava em par_cTabela, linha a linha, TODAS as colunas
    * do cursor (que AbrirCursorTabela criou com a estrutura completa da
    * tabela). Mesmo helper generico ja usado em SigPrGlxBO/SigPrGlpBO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PersistirCursor(par_cCursor, par_cTabela)
        LOCAL loc_lOk, loc_nI, loc_nCampos, loc_cCols, loc_cVals, loc_cSQL, loc_nRet
        LOCAL ARRAY loc_aCampos[1, 18]

        loc_lOk = .T.

        IF !USED(par_cCursor) OR RECCOUNT(par_cCursor) = 0
            RETURN .T.
        ENDIF

        loc_nCampos = AFIELDS(loc_aCampos, par_cCursor)
        loc_cCols   = ""
        FOR loc_nI = 1 TO loc_nCampos
            loc_cCols = loc_cCols + IIF(loc_nI = 1, "", ", ") + LOWER(ALLTRIM(loc_aCampos[loc_nI, 1]))
        ENDFOR

        SELECT (par_cCursor)
        GO TOP
        SCAN
            loc_cVals = ""
            FOR loc_nI = 1 TO loc_nCampos
                loc_cVals = loc_cVals + IIF(loc_nI = 1, "", ", ") + ;
                    THIS.ValorSQLDeCampo(par_cCursor, ALLTRIM(loc_aCampos[loc_nI, 1]), ;
                        loc_aCampos[loc_nI, 2], loc_aCampos[loc_nI, 4])
            ENDFOR

            loc_cSQL = "INSERT INTO " + par_cTabela + " (" + loc_cCols + ") VALUES (" + loc_cVals + ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "(Update - " + par_cCursor + ") " + CapturarErroSQL()
                loc_lOk = .F.
                EXIT
            ENDIF
        ENDSCAN

        RETURN loc_lOk
    ENDFUNC

ENDDEFINE

