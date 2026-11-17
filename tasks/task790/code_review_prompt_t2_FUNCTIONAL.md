# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (32)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_CODIGOS, CNT_4C_OBS, CNT_4C_REFFS, CNT_4C_ITEM. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterChaveMovimentacao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.TemProdutoSelecionado()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ExecutarConsultaPainel()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterContaFornecedor()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterGrupoEstoque()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ResolverProdutoDigitado()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.PodeEditarDescricao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Opt_Busca' (parent: SIGOPPRO.pgfPagina.pgProds): Top original=135 vs migrado 'obj_4c_Opt_Busca' Top=5 (diff=130px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Busca' (parent: SIGOPPRO.pgfPagina.pgProds): Left original=713 vs migrado 'obj_4c_Opt_Busca' Left=5 (diff=708px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnRetCash' (parent: SIGOPPRO): Top original=81 vs migrado 'cmd_4c_BtnRetCash' Top=0 (diff=81px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btndevolu' (parent: SIGOPPRO): Top original=81 vs migrado 'cmd_4c_Btndevolu' Top=0 (diff=81px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnRecImps' (parent: SIGOPPRO): Top original=81 vs migrado 'cmd_4c_BtnRecImps' Top=0 (diff=81px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnAltImps' (parent: SIGOPPRO): Top original=81 vs migrado 'cmd_4c_BtnAltImps' Top=0 (diff=81px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnCotacao' (parent: SIGOPPRO): Top original=81 vs migrado 'cmd_4c_BtnCotacao' Top=0 (diff=81px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnTotItens' (parent: SIGOPPRO): Top original=81 vs migrado 'cmd_4c_BtnTotItens' Top=0 (diff=81px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnIteSub' (parent: SIGOPPRO): Top original=81 vs migrado 'cmd_4c_BtnIteSub' Top=0 (diff=81px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btncarregar' (parent: SIGOPPRO): Top original=81 vs migrado 'cmd_4c_Btncarregar' Top=0 (diff=81px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'CmdXml' (parent: SIGOPPRO): Top original=81 vs migrado 'cmd_4c_CmdXml' Top=0 (diff=81px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnOptFin' (parent: SIGOPPRO): Top original=359 vs migrado 'cmd_4c_BtnOptFin' Top=0 (diff=359px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnsubcp' (parent: SIGOPPRO): Top original=359 vs migrado 'cmd_4c_Btnsubcp' Top=0 (diff=359px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnDesc' (parent: SIGOPPRO): Top original=359 vs migrado 'cmd_4c_BtnDesc' Top=0 (diff=359px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnVerImps' (parent: SIGOPPRO): Top original=81 vs migrado 'chk_4c_BtnVerImps' Top=0 (diff=81px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnCadPro' (parent: SIGOPPRO): Top original=359 vs migrado 'cmd_4c_BtnCadPro' Top=0 (diff=359px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnPApaga' (parent: SIGOPPRO): Top original=359 vs migrado 'cmd_4c_BtnPApaga' Top=0 (diff=359px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'BtnDet' (parent: SIGOPPRO): Top original=359 vs migrado 'cmd_4c_BtnDet' Top=0 (diff=359px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnLocDes' (parent: SIGOPPRO): Top original=359 vs migrado 'cmd_4c_BtnLocDes' Top=0 (diff=359px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnLocOri' (parent: SIGOPPRO): Top original=359 vs migrado 'cmd_4c_BtnLocOri' Top=0 (diff=359px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnPedido' (parent: SIGOPPRO): Top original=359 vs migrado 'cmd_4c_BtnPedido' Top=0 (diff=359px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnAltPrecos' (parent: SIGOPPRO): Top original=359 vs migrado 'cmd_4c_BtnAltPrecos' Top=0 (diff=359px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnCompos' (parent: SIGOPPRO): Top original=359 vs migrado 'cmd_4c_BtnCompos' Top=0 (diff=359px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnPBuscas' (parent: SIGOPPRO): Top original=359 vs migrado 'cmd_4c_BtnPBuscas' Top=0 (diff=359px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoppro.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (6488 linhas total):

*-- Linhas 109 a 258:
109:     *-- dispara SEMPRE que o controle perde o foco, mas o Valid do legado so
110:     *-- dispara quando o valor MUDA - sem esta guarda o lookup abriria a cada
111:     *-- vez que o usuario apenas passasse pelo campo sem alterar o valor.
112:     this_cUltimoValidarCodCorLostFocusValidado = ""
113:     this_cUltimoValidarCodTamLostFocusValidado = ""
114: 
115:     *==========================================================================
116:     PROCEDURE Init()
117:     *==========================================================================
118:         THIS.Caption = "Produtos"
119:         RETURN DODEFAULT()
120:     ENDPROC
121: 
122:     *==========================================================================
123:     * Destroy - Libera cursores e recursos
124:     *==========================================================================
125:     PROCEDURE Destroy()
126:         LOCAL loc_oErro
127:         TRY
128:             IF USED("cursor_4c_Dados")
129:                 USE IN cursor_4c_Dados
130:             ENDIF
131:         CATCH TO loc_oErro
132:             *-- nao exibir erro no Destroy
133:         ENDTRY
134:         DODEFAULT()
135:     ENDPROC
136: 
137:     *==========================================================================
138:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
139:     *==========================================================================
140:     PROTECTED PROCEDURE InicializarForm()
141:         LOCAL loc_lSucesso, loc_oErro
142:         loc_lSucesso = .F.
143: 
144:         TRY
145:             THIS.this_oBusinessObject = CREATEOBJECT("sigopproBO")
146: 
147:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
148:                 MsgErro("Falha ao criar sigopproBO.", "Erro")
149:             ELSE
150:                 THIS.ConfigurarCabecalho()
151:                 THIS.ConfigurarPageFrame()
152: 
153:                 *-- Cursores ANTES das paginas: os campos de Page1/Page3 e a
154:                 *-- grade de Page4 usam ControlSource, e ControlSource de alias
155:                 *-- que ainda nao existe derruba o Init (regra #41).
156:                 THIS.CriarCursorItens()
157:                 THIS.CriarCursorPrecos()
158: 
159:                 THIS.ConfigurarPaginaProduto()
160:                 THIS.ConfigurarPaginaDados()
161:                 THIS.ConfigurarPaginaFiscal()
162:                 THIS.ConfigurarPaginaPrecos()
163:                 THIS.ConfigurarBotoes()
164:                 THIS.ConfigurarBotoesTopo()
165:                 THIS.ConfigurarBotoesAcao()
166:                 THIS.ConfigurarGridDados()
167: 
168:                 *-- AfterRowColChange: handler DECLARA par_nColIndex porque o
169:                 *-- evento passa o argumento (regra #3). Uso de LINHA corrente
170:                 *-- (carregar o detalhe), nunca validacao de celula (regra #46).
171:                 BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, ;
172:                           "GradeAfterRowColChange")
173: 
174:                 THIS.TornarControlesVisiveis(THIS)
175:                 THIS.ReaplicarVisibilidadeInicial()
176:                 THIS.AplicarModoNaGrade()
177:                 THIS.AjustarBotoesPorModo()
178:                 THIS.HabilitarCampos(INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR"))
179: 
180:                 THIS.pgf_4c_Paginas.Visible    = .T.
181:                 THIS.pgf_4c_Paginas.ActivePage = 1
182: 
183:                 *-- Carga da grade: pulada em validacao de UI/modo teste (sem
184:                 *-- gnConnHandle a consulta nao tem como rodar).
185:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
186:                     IF TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste
187:                         THIS.CarregarDados()
188:                     ENDIF
189:                 ENDIF
190: 
191:                 loc_lSucesso = .T.
192:             ENDIF
193: 
194:         CATCH TO loc_oErro
195:             THIS.this_cMensagemErro = loc_oErro.Message
196:             MsgErro(loc_oErro.Message + CHR(13) + ;
197:                      "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
198:                      "Proc: " + loc_oErro.Procedure, "Erro InicializarForm")
199:         ENDTRY
200: 
201:         RETURN loc_lSucesso
202:     ENDPROC
203: 
204:     *==========================================================================
205:     * ConfigurarCabecalho - Faixa cinza do topo (CLAUDE.md regra #11) e bloco
206:     * canonico de Saida/Encerrar (CLAUDE.md regra #10), ambos na raiz do form
207:     * (este form usa abas visiveis, Tabs=.T., sem o truque PageFrame.Top=-29
208:     * das telas CRUD - entao nao ha compensacao de +29 a aplicar aqui).
209:     *==========================================================================
210:     PROTECTED PROCEDURE ConfigurarCabecalho()
211:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
212:         WITH THIS.cnt_4c_Cabecalho
213:             .Top           = 0
214:             .Left          = 0
215:             .Width         = THIS.Width
216:             .Height        = 80
217:             .BackColor     = RGB(100, 100, 100)
218:             .BorderWidth   = 0
219:             .SpecialEffect = 0
220:             .Visible     = .T.
221:         ENDWITH
222: 
223:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
224:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
225:             .Top       = 15
226:             .Left      = 10
227:             .Width     = THIS.cnt_4c_Cabecalho.Width - 20
228:             .Height    = 40
229:             .FontName  = "Tahoma"
230:             .FontSize  = 16
231:             .FontBold  = .T.
232:             .BackStyle = 0
233:             .ForeColor = RGB(0, 0, 0)
234:             .AutoSize  = .F.
235:             .WordWrap  = .T.
236:             .Caption   = THIS.Caption
237:         ENDWITH
238: 
239:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
240:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
241:             .Top       = 18
242:             .Left      = 10
243:             .Width     = THIS.cnt_4c_Cabecalho.Width - 20
244:             .Height    = 46
245:             .FontName  = "Tahoma"
246:             .FontSize  = 16
247:             .FontBold  = .T.
248:             .BackStyle = 0
249:             .ForeColor = RGB(255, 255, 255)
250:             .AutoSize  = .F.
251:             .WordWrap  = .T.
252:             .Caption   = THIS.Caption
253:         ENDWITH
254: 
255:         *-- cnt_4c_Saida: padrao canonico (CLAUDE.md regra #10), prevalece
256:         *-- sobre a posicao do botao "Retornar" (OK.btnSair) do SCX legado.
257:         THIS.AddObject("cnt_4c_Saida", "Container")
258:         WITH THIS.cnt_4c_Saida

*-- Linhas 285 a 367:
285:             .WordWrap        = .T.
286:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
287:         ENDWITH
288:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
289:     ENDPROC
290: 
291:     *==========================================================================
292:     * ConfigurarBotoes - Containers vazios para os botoes de acao da tela
293:     * (toolbar superior e inferior do legado, Top=81 e Top=359).
294:     *==========================================================================
295:     PROTECTED PROCEDURE ConfigurarBotoes()
296:         THIS.AddObject("cnt_4c_Botoes", "Container")
297:         WITH THIS.cnt_4c_Botoes
298:             .Top         = 81
299:             .Left        =  542
300:             .Width       = THIS.Width - 14
301:             .Height      = 40
302:             .BackStyle   = 0
303:             .BorderWidth = 0
304:             .Visible     = .T.
305:         ENDWITH
306: 
307:         THIS.AddObject("cnt_4c_BotoesAcao", "Container")
308:         WITH THIS.cnt_4c_BotoesAcao
309:             .Top         = 359
310:             .Left        = 7
311:             .Width       = THIS.Width - 14
312:             .Height      = 40
313:             .BackStyle   = 0
314:             .BorderWidth = 0
315:             .Visible     = .T.
316:         ENDWITH
317:     ENDPROC
318: 
319:     *==========================================================================
320:     * ConfigurarPageFrame - pgf_4c_Paginas com as 4 abas visiveis do legado,
321:     * na ordem visual (PageOrder) do pgfPagina original:
322:     *   Page1 = pgProds  (PageOrder=1) "Dados do Produto"
323:     *   Page2 = pgContas (PageOrder=2) "Dados da Movimentacao"
324:     *   Page3 = pgFiscs  (PageOrder=3) "Dados Fiscais"
325:     *   Page4 = pgPrecos (PageOrder=4) "Precificacao"
326:     *==========================================================================
327:     PROTECTED PROCEDURE ConfigurarPageFrame()
328:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
329:         WITH THIS.pgf_4c_Paginas
330:             .Top       = 403
331:             .Left      = 7
332:             .Width     = 1035
333:             .Height    = 198
334:             .Tabs      = .T.
335:             .PageCount = 4
336:             .Visible   = .F.
337:         ENDWITH
338: 
339:         WITH THIS.pgf_4c_Paginas.Page1
340:             .Caption   = "Dados do Produto"
341:             .FontName  = "Tahoma"
342:             .FontSize  = 8
343:             .BackColor = RGB(255, 255, 255)
344:             .ForeColor = RGB(90, 90, 90)
345:         ENDWITH
346: 
347:         WITH THIS.pgf_4c_Paginas.Page2
348:             .Caption   = "Dados da Movimenta" + CHR(231) + CHR(227) + "o"
349:             .FontName  = "Tahoma"
350:             .FontSize  = 8
351:             .BackColor = RGB(255, 255, 255)
352:             .ForeColor = RGB(90, 90, 90)
353:         ENDWITH
354: 
355:         WITH THIS.pgf_4c_Paginas.Page3
356:             .Caption   = "Dados Fiscais"
357:             .FontName  = "Tahoma"
358:             .FontSize  = 8
359:             .BackColor = RGB(255, 255, 255)
360:             .ForeColor = RGB(90, 90, 90)
361:         ENDWITH
362: 
363:         WITH THIS.pgf_4c_Paginas.Page4
364:             .Caption   = "Precifica" + CHR(231) + CHR(227) + "o"
365:             .FontName  = "Tahoma"
366:             .FontSize  = 8
367:             .BackColor = RGB(255, 255, 255)

*-- Linhas 389 a 435:
389:     * TprMvCab (que vive no data session do form PAI), nunca campos
390:     * digitaveis. getEmpDs (cntEmpDes) tambem tem When() = Return(.F.). So
391:     * getLPrecos (cntLPrecos) eh editavel no legado, mas nao tem
392:     * CreateObject('fwbuscaext'/'fwBuscaSel') nem sigacess() no Valid - eh
393:     * texto livre (Format="K", MaxLength=30), sem tabela de referencia.
394:     *==========================================================================
395:     PROTECTED PROCEDURE ConfigurarPaginaDados()
396:         LOCAL loc_oPag
397:         loc_oPag = THIS.pgf_4c_Paginas.Page2
398: 
399:         *-- cnt_4c_Codigos (cntCodigos no legado) -----------------------------
400:         loc_oPag.AddObject("cnt_4c_Codigos", "Container")
401:         WITH loc_oPag.cnt_4c_Codigos
402:             .Top         = -2
403:             .Left        = 10
404:             .Width       = 67
405:             .Height      = 45
406:             .BackStyle   = 0
407:             .BorderWidth = 0
408:             .Visible     = .T.
409:         ENDWITH
410: 
411:         loc_oPag.cnt_4c_Codigos.AddObject("txt_4c_Codigos", "TextBox")
412:         WITH loc_oPag.cnt_4c_Codigos.txt_4c_Codigos
413:             .Top           = 20
414:             .Left          = 3
415:             .Width         = 61
416:             .Height        = 23
417:             .FontBold      = .T.
418:             .FontSize      = 10
419:             .SpecialEffect = 1
420:             .ForeColor     = RGB(36, 84, 155)
421:             .Value         = THIS.this_cMascnum
422:             .ToolTipText   = "C" + CHR(243) + "digo da Opera" + CHR(231) + CHR(227) + "o"
423:         ENDWITH
424: 
425:         loc_oPag.cnt_4c_Codigos.AddObject("lbl_4c_LblCodigos", "Label")
426:         WITH loc_oPag.cnt_4c_Codigos.lbl_4c_LblCodigos
427:             .Top       = 3
428:             .Left      = 3
429:             .Width     = 58
430:             .Height    = 15
431:             .FontName  = "Tahoma"
432:             .FontSize  = 8
433:             .FontBold  = .F.
434:             .Alignment = 0
435:             .BackStyle = 0

*-- Linhas 781 a 863:
781:     ENDPROC
782: 
783:     *==========================================================================
784:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F.;
785:     * percorre recursivamente Controls (que inclui Pages de PageFrame).
786:     *==========================================================================
787:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
788:         LOCAL loc_oCtrl, loc_oErro
789:         TRY
790:             FOR EACH loc_oCtrl IN par_oContainer.Controls
791:                 IF VARTYPE(loc_oCtrl) = "O"
792:                     *-- Containers que o proprio ConfigurarXxx ja deixa no
793:                     *-- estado correto (visivel ou oculto por desenho, ex.: o
794:                     *-- painel flutuante da observacao). Forcar Visible = .T.
795:                     *-- aqui destruiria esse estado - DESCE para os filhos
796:                     *-- mesmo assim, para que os controles de dentro estejam
797:                     *-- visiveis quando o container for exibido.
798:                     IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_CABECALHO", ;
799:                               "CNT_4C_CODIGOS", "CNT_4C_OBS", "CNT_4C_REFFS", ;
800:                               "CNT_4C_ITEM")
801:                         THIS.TornarControlesVisiveis(loc_oCtrl)
802:                         LOOP
803:                     ENDIF
804: 
805:                     loc_oCtrl.Visible = .T.
806:                     IF PEMSTATUS(loc_oCtrl, "Controls", 5) AND loc_oCtrl.ControlCount > 0
807:                         THIS.TornarControlesVisiveis(loc_oCtrl)
808:                     ENDIF
809:                 ENDIF
810:             ENDFOR
811:         CATCH TO loc_oErro
812:             *-- continua silenciosamente
813:         ENDTRY
814:     ENDPROC
815: 
816:     *==========================================================================
817:     * CriarCursorItens - Cursor de trabalho (espelha crTpmMvItn do legado),
818:     * compartilhado pela grade grd_4c_Dados e pelo sigopproBO.CarregarDoCursor.
819:     * Mantido num unico CREATE CURSOR para que as paginas de Dados/Fiscal/
820:     * Precificacao (fases seguintes) liguem campos nele sem recriar a
821:     * estrutura (regra #41 - Column.ControlSource exige o cursor ja existir).
822:     *==========================================================================
823:     PROTECTED PROCEDURE CriarCursorItens()
824:         IF USED("cursor_4c_Itens")
825:             USE IN cursor_4c_Itens
826:         ENDIF
827: 
828:         SET NULL ON
829:         CREATE CURSOR cursor_4c_Itens ( ;
830:             cidchaves C(20), citens N(10,0), cpros C(14), dpros C(65), ;
831:             codbarras N(14,0), cunis C(3), cunips C(3), fators N(8,3), ;
832:             opers C(1), qtds N(9,3), pesos N(9,3), units N(15,6), ;
833:             moedas C(3), totas N(11,2), tpesos N(11,2), abrevis C(3), ;
834:             locals C(10), localos C(10), compris N(6,2), qtreservas N(9,3), ;
835:             ckpresente N(1,0), codcors C(4), codtams C(4), servicos N(1,0), ;
836:             aqtds N(9,3), datatrans T NULL, descvals N(7,2), dopes C(20), ;
837:             emps C(3), etiesps L, fatvals N(15,6), fvals L, iconfs L, ;
838:             moefats C(3), moevals N(15,6), notas C(6), nrcons C(10), ;
839:             ntrans N(6,0), numes N(6,0), numolds N(6,0), obs M NULL, ;
840:             qtbaixas N(9,3), qtbxprods N(9,3), qtprods N(9,3), ;
841:             unitembs N(11,4), univals N(15,6), vcoms N(8,2), aliqs N(4,2), ;
842:             sitribs C(2), tpipis C(1), valipis N(11,2), aliqicms N(5,2), ;
843:             valdescs N(9,2), empos C(3), moevs C(3), utilizas N(4,0), ;
844:             ncodigos N(10,0), nlotes N(10,0), dtalts T NULL, empdopnums C(29), ;
845:             baseicms N(11,2), chksubn L, unit2s N(15,6), usulibs C(10), ;
846:             valrats N(14,6), codlprecs N(6,0), motdscs C(10), tipos C(1), ;
847:             unitinfs N(14,6), cpro2s C(50), bcicmss N(15,2), bcipis N(15,2), ;
848:             icms N(15,2), icmss N(15,2), pdescs N(5,2), nchvtbds N(6,0), ;
849:             idpro N(10,0), unitorigs N(14,6), origmercs C(1), ;
850:             baseicm2s N(11,2), baseicm3s N(11,2), baseipi2s N(11,2), ;
851:             baseipi3s N(11,2), cfops C(10), ratdacs N(11,2), ratfrts N(11,2), ;
852:             raticmds N(11,2), raticms N(11,2), ratsegs N(11,2), sittricms C(3), ;
853:             aliqiis N(4,2), citem2 N(10,0), taxaiis N(11,2), vcofins N(11,2), ;
854:             vpis N(11,2), aliqorigs N(4,2), lcancelas L, codfabs C(60), ;
855:             nadis N(3,0), niadis N(3,0), aliqcofs N(4,2), aliqpis N(4,2), ;
856:             cssl N(11,2), inss N(11,2), irrf N(11,2), iss N(11,2), ;
857:             valbases N(11,2), pfcpst N(5,2), vfcpst N(11,2), ob2s C(100), ;
858:             pedidoweb C(50), qtresres N(9,3), barraref N(14,0), itemped C(4), ;
859:             numeronota C(10), dopesorig C(20), chaveexterna C(33), ;
860:             gravacao C(20), ifors C(10), propriedades C(40) NULL, ;
861:             unidade1 C(15) NULL, resultado1 C(15) NULL, valorMinimo C(15) NULL, ;
862:             valorMaximo C(15) NULL, metodoReferencia1 C(15) NULL)
863:         SET NULL OFF

*-- Linhas 877 a 920:
877:     * ConfigurarGridDados - grd_4c_Dados (fwGrade do legado): grade principal
878:     * de itens da movimentacao, 22 colunas na mesma ordem/largura do dump.
879:     *==========================================================================
880:     PROTECTED PROCEDURE ConfigurarGridDados()
881:         THIS.AddObject("grd_4c_Dados", "Grid")
882:         WITH THIS.grd_4c_Dados
883:             .Top               = 122
884:             .Left              = 7
885:             .Width             = 1035
886:             .Height            = 233
887:             .ColumnCount       = 22
888:             .RecordSource      = "cursor_4c_Itens"
889:             .FontName          = "Courier New"
890:             .FontSize          = 9
891:             .HeaderHeight      = 16
892:             .RowHeight         = 16
893:             .AllowHeaderSizing = .F.
894:             .DeleteMark        = .F.
895:             .RecordMark        = .F.
896:             .ScrollBars        = 3
897:             .GridLineColor     = RGB(238, 238, 238)
898:             .ToolTipText       = "Grade de Produtos"
899:         ENDWITH
900: 
901:         *-- Column1: PRODUTO (estilo link - sublinhado/azul, igual ao legado)
902:         WITH THIS.grd_4c_Dados.Column1
903:             .ControlSource     = "cursor_4c_Itens.cpros"
904:             .Width             = 108
905:             .FontBold          = .T.
906:             .FontName          = "Courier New"
907:             .FontSize          = 9
908:             .FontUnderline     = .T.
909:             .ForeColor         = RGB(0, 0, 255)
910:             .Format            = "K!"
911:             .InputMask         = REPLICATE("!", 14)
912:             .Header1.FontBold  = .T.
913:             .Header1.FontName  = "Arial"
914:             .Header1.FontSize  = 8
915:             .Header1.Alignment = 2
916:             .Header1.Caption   = "Produto"
917:         ENDWITH
918: 
919:         *-- Column2: FATOR
920:         WITH THIS.grd_4c_Dados.Column2

*-- Linhas 1087 a 2208:
1087:         *-- VFP liga Column22 ao 22o campo do cursor, que eh codcors C(4), e
1088:         *-- adicionar um controle numerico ali da
1089:         *-- "Error with CHK_4C_SERVICO - Value : Data type mismatch."
1090:         *-- A falha eh TOTAL e MUDA: cai no TRY do InicializarForm, que
1091:         *-- devolve .F., CREATEOBJECT devolve o logico .F. e a tela
1092:         *-- simplesmente nao abre - sem erro na tela e sem log.
1093:         WITH THIS.grd_4c_Dados.Column21
1094:             .ControlSource     = "cursor_4c_Itens.ckpresente"
1095:             .Width             = 50
1096:             .Header1.Alignment = 2
1097:             .Header1.Caption   = "Presente"
1098:         ENDWITH
1099: 
1100:         WITH THIS.grd_4c_Dados.Column22
1101:             .ControlSource     = "cursor_4c_Itens.servicos"
1102:             .Width             = 50
1103:             .Header1.Alignment = 2
1104:             .Header1.Caption   = "O.S."
1105:         ENDWITH
1106: 
1107:         *-- Todas as colunas ja estao bindadas: agora os CheckBox.
1108:         THIS.InstalarCheckBoxesGrade()
1109:     ENDPROC
1110: 
1111:     *==========================================================================
1112:     * InstalarCheckBoxesGrade - Instala os CheckBox das colunas Presente e
1113:     * O.S. na ordem que o VFP9 exige (medido): ColumnCount -> RecordSource ->
1114:     * ControlSource de TODAS as colunas -> Column.AddObject + Value ->
1115:     * Sparse + CurrentControl. Invertido, o AddObject estoura por causa do
1116:     * auto-bind do RecordSource (ver comentario em ConfigurarGridDados).
1117:     *
1118:     * IDEMPOTENTE e vive no funil: reatribuir RecordSource/ColumnCount ou
1119:     * fechar o alias destroi os objetos postos na Column, entao a instalacao
1120:     * tem de poder rodar de novo sem duplicar o AddObject.
1121:     *==========================================================================
1122:     PROTECTED PROCEDURE InstalarCheckBoxesGrade()
1123:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1124:             RETURN
1125:         ENDIF
1126: 
1127:         IF THIS.grd_4c_Dados.ColumnCount < 22
1128:             RETURN
1129:         ENDIF
1130: 
1131:         THIS.InstalarCheckBoxColuna(THIS.grd_4c_Dados.Column21, "chk_4c_Presente")
1132:         THIS.InstalarCheckBoxColuna(THIS.grd_4c_Dados.Column22, "chk_4c_Servico")
1133:     ENDPROC
1134: 
1135:     *==========================================================================
1136:     * InstalarCheckBoxColuna - Poe UM CheckBox numa Column. Propriedades: so
1137:     * as que o VFP9 de fato aplica em controle de Column criado em runtime
1138:     * (Caption/Alignment/ReadOnly/Visible/FontName/FontSize/Value). Top/Left/
1139:     * Width/Height sao DESCARTADAS nesse contexto - escrever a geometria do
1140:     * dump aqui eh codigo morto que sugere area clicavel calibrada.
1141:     *==========================================================================
1142:     PROTECTED PROCEDURE InstalarCheckBoxColuna(par_oColuna, par_cNomeChk)
1143:         IF VARTYPE(par_oColuna) <> "O" OR VARTYPE(par_cNomeChk) <> "C"
1144:             RETURN
1145:         ENDIF
1146: 
1147:         IF !PEMSTATUS(par_oColuna, par_cNomeChk, 5)
1148:             par_oColuna.AddObject(par_cNomeChk, "CheckBox")
1149:         ENDIF
1150: 
1151:         *-- Membro alcancado por NOME: EVALUATE para ler, STORE para atribuir
1152:         *-- (Column nao eh colecao por chave - regra #34).
1153:         STORE ""   TO ("par_oColuna." + par_cNomeChk + ".Caption")
1154:         STORE 0    TO ("par_oColuna." + par_cNomeChk + ".Alignment")
1155:         STORE .F.  TO ("par_oColuna." + par_cNomeChk + ".ReadOnly")
1156:         STORE .T.  TO ("par_oColuna." + par_cNomeChk + ".Visible")
1157:         STORE "Courier New" TO ("par_oColuna." + par_cNomeChk + ".FontName")
1158:         STORE 9    TO ("par_oColuna." + par_cNomeChk + ".FontSize")
1159:         STORE 0    TO ("par_oColuna." + par_cNomeChk + ".Value")
1160: 
1161:         *-- Sparse = .F. senao o CheckBox so aparece na linha ativa;
1162:         *-- CurrentControl com o NOME do objeto, senao a coluna segue
1163:         *-- desenhando o Text1 dela (regra #18).
1164:         par_oColuna.Sparse         = .F.
1165:         par_oColuna.CurrentControl = par_cNomeChk
1166:     ENDPROC
1167: 
1168:     *==========================================================================
1169:     * ConfigurarBotoesTopo - Preenche cnt_4c_Botoes (Top=81 no legado) com a
1170:     * barra de botoes auxiliares. Posicoes/icones/visibilidade EXATOS do dump
1171:     * (layout.json/sigoppro_form_codigo_fonte_slim.txt); Left relativo ao
1172:     * container (absoluto do legado menos 7, regra "Left relativo em botoes
1173:     * de container").
1174:     *==========================================================================
1175:     PROTECTED PROCEDURE ConfigurarBotoesTopo()
1176:         LOCAL loc_oCnt
1177:         loc_oCnt = THIS.cnt_4c_Botoes
1178: 
1179:         loc_oCnt.AddObject("cmd_4c_BtnTotItens", "CommandButton")
1180:         WITH loc_oCnt.cmd_4c_BtnTotItens
1181:             .Left            = 7
1182:             .Top             = 0
1183:             .Width           = 102
1184:             .Height          = 40
1185:             .FontName        = "Comic Sans MS"
1186:             .FontBold        = .T.
1187:             .FontItalic      = .T.
1188:             .FontSize        = 8
1189:             .WordWrap        = .T.
1190:             .ForeColor       = RGB(90, 90, 90)
1191:             .BackColor       = RGB(255, 255, 255)
1192:             .Themes          = .T.
1193:             .PicturePosition = 1
1194:             .MousePointer    = 15
1195:             .Caption         = "Total de Produtos"
1196:             .ToolTipText     = "Total dos Produtos"
1197:             .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
1198:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
1199:         ENDWITH
1200:         BINDEVENT(loc_oCnt.cmd_4c_BtnTotItens, "Click", THIS, "BtnTotItensClick")
1201: 
1202:         loc_oCnt.AddObject("cmd_4c_BtnCotacao", "CommandButton")
1203:         WITH loc_oCnt.cmd_4c_BtnCotacao
1204:             .Left            = 109
1205:             .Top             = 0
1206:             .Width           = 102
1207:             .Height          = 40
1208:             .FontName        = "Comic Sans MS"
1209:             .FontBold        = .T.
1210:             .FontItalic      = .T.
1211:             .FontSize        = 8
1212:             .WordWrap        = .T.
1213:             .ForeColor       = RGB(90, 90, 90)
1214:             .BackColor       = RGB(255, 255, 255)
1215:             .Themes          = .T.
1216:             .PicturePosition = 1
1217:             .MousePointer    = 15
1218:             .Caption         = "C" + CHR(226) + "mbio de Produtos"
1219:             .ToolTipText     = "Edita os Valores de Cota" + CHR(231) + CHR(227) + "o das Moedas"
1220:             .Picture         = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
1221:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
1222:         ENDWITH
1223:         BINDEVENT(loc_oCnt.cmd_4c_BtnCotacao, "Click", THIS, "BtnCotacaoClick")
1224: 
1225:         loc_oCnt.AddObject("cmd_4c_BtnAltImps", "CommandButton")
1226:         WITH loc_oCnt.cmd_4c_BtnAltImps
1227:             .Left            = 211
1228:             .Top             = 0
1229:             .Width           = 102
1230:             .Height          = 40
1231:             .FontName        = "Comic Sans MS"
1232:             .FontBold        = .T.
1233:             .FontItalic      = .T.
1234:             .FontSize        = 8
1235:             .WordWrap        = .T.
1236:             .ForeColor       = RGB(90, 90, 90)
1237:             .BackColor       = RGB(255, 255, 255)
1238:             .Themes          = .T.
1239:             .PicturePosition = 1
1240:             .MousePointer    = 15
1241:             .Caption         = "Alterar Impostos"
1242:             .ToolTipText     = "Alterar Impostos"
1243:             .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
1244:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
1245:         ENDWITH
1246:         BINDEVENT(loc_oCnt.cmd_4c_BtnAltImps, "Click", THIS, "BtnAltImpsClick")
1247: 
1248:         loc_oCnt.AddObject("chk_4c_BtnVerImps", "CheckBox")
1249:         WITH loc_oCnt.chk_4c_BtnVerImps
1250:             .Left            = 313
1251:             .Top             = 0
1252:             .Width           = 102
1253:             .Height          = 40
1254:             .Style           = 1
1255:             .Alignment       = 2
1256:             *-- CheckBox.Value SEMPRE numerico (0/1). O SCX legado declara
1257:             *-- Value = .F., mas misturar Logico e Numerico no mesmo controle
1258:             *-- estoura "Operator/operand type mismatch" na primeira
1259:             *-- comparacao com 0/1 feita em outro metodo.
1260:             .Value           = 0
1261:             .FontName        = "Comic Sans MS"
1262:             .FontBold        = .T.
1263:             .FontItalic      = .T.
1264:             .FontSize        = 8
1265:             .WordWrap        = .T.
1266:             .ForeColor       = RGB(90, 90, 90)
1267:             .BackColor       = RGB(255, 255, 255)
1268:             .Themes          = .T.
1269:             .PicturePosition = 1
1270:             .MousePointer    = 15
1271:             .Caption         = "Visualizar Impostos"
1272:             .ToolTipText     = "Visualizar Impostos"
1273:             .Picture         = gc_4c_CaminhoIcones + "geral_coleta_60.jpg"
1274:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_coleta_60.jpg"
1275:         ENDWITH
1276:         BINDEVENT(loc_oCnt.chk_4c_BtnVerImps, "Click", THIS, "BtnVerImpsClick")
1277: 
1278:         loc_oCnt.AddObject("cmd_4c_BtnRecImps", "CommandButton")
1279:         WITH loc_oCnt.cmd_4c_BtnRecImps
1280:             .Left            = 414
1281:             .Top             = 0
1282:             .Width           = 102
1283:             .Height          = 40
1284:             .FontName        = "Comic Sans MS"
1285:             .FontBold        = .T.
1286:             .FontItalic      = .T.
1287:             .FontSize        = 8
1288:             .WordWrap        = .T.
1289:             .ForeColor       = RGB(90, 90, 90)
1290:             .BackColor       = RGB(255, 255, 255)
1291:             .Themes          = .T.
1292:             .PicturePosition = 1
1293:             .MousePointer    = 15
1294:             .Caption         = "Recalcular Impostos"
1295:             .ToolTipText     = "Recalcular Impostos"
1296:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1297:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1298:         ENDWITH
1299:         BINDEVENT(loc_oCnt.cmd_4c_BtnRecImps, "Click", THIS, "BtnRecImpsClick")
1300: 
1301:         loc_oCnt.AddObject("cmd_4c_Btndevolu", "CommandButton")
1302:         WITH loc_oCnt.cmd_4c_Btndevolu
1303:             .Left            = 517
1304:             .Top             = 0
1305:             .Width           = 102
1306:             .Height          = 40
1307:             .FontName        = "Comic Sans MS"
1308:             .FontBold        = .T.
1309:             .FontItalic      = .T.
1310:             .FontSize        = 8
1311:             .WordWrap        = .T.
1312:             .ForeColor       = RGB(90, 90, 90)
1313:             .BackColor       = RGB(255, 255, 255)
1314:             .Themes          = .T.
1315:             .PicturePosition = 1
1316:             .MousePointer    = 15
1317:             .Caption         = "Devolu" + CHR(231) + CHR(227) + "o"
1318:             .ToolTipText     = "Devolu" + CHR(231) + CHR(227) + "o"
1319:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1320:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1321:         ENDWITH
1322:         BINDEVENT(loc_oCnt.cmd_4c_Btndevolu, "Click", THIS, "BtndevoluClick")
1323: 
1324:         loc_oCnt.AddObject("cmd_4c_BtnIteSub", "CommandButton")
1325:         WITH loc_oCnt.cmd_4c_BtnIteSub
1326:             .Left            = 618
1327:             .Top             = 0
1328:             .Width           = 102
1329:             .Height          = 40
1330:             .FontName        = "Comic Sans MS"
1331:             .FontBold        = .T.
1332:             .FontItalic      = .T.
1333:             .FontSize        = 8
1334:             .WordWrap        = .T.
1335:             .ForeColor       = RGB(90, 90, 90)
1336:             .BackColor       = RGB(255, 255, 255)
1337:             .Themes          = .T.
1338:             .PicturePosition = 1
1339:             .MousePointer    = 15
1340:             .Caption         = "Itens Subn" + CHR(237) + "vel"
1341:             .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
1342:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
1343:         ENDWITH
1344:         BINDEVENT(loc_oCnt.cmd_4c_BtnIteSub, "Click", THIS, "BtnIteSubClick")
1345: 
1346:         loc_oCnt.AddObject("cmd_4c_CmdXml", "CommandButton")
1347:         WITH loc_oCnt.cmd_4c_CmdXml
1348:             .Left            = 720
1349:             .Top             = 0
1350:             .Width           = 102
1351:             .Height          = 40
1352:             .FontName        = "Comic Sans MS"
1353:             .FontBold        = .T.
1354:             .FontItalic      = .T.
1355:             .FontSize        = 7
1356:             .WordWrap        = .T.
1357:             .ForeColor       = RGB(90, 90, 90)
1358:             .BackColor       = RGB(255, 255, 255)
1359:             .Themes          = .T.
1360:             .PicturePosition = 1
1361:             .MousePointer    = 15
1362:             .Caption         = "Importar XML"
1363:             .ToolTipText     = "Importar XML"
1364:             .Picture         = gc_4c_CaminhoIcones + "images.jpg"
1365:             .DisabledPicture = gc_4c_CaminhoIcones + "images.jpg"
1366:         ENDWITH
1367:         BINDEVENT(loc_oCnt.cmd_4c_CmdXml, "Click", THIS, "CmdXmlClick")
1368: 
1369:         loc_oCnt.AddObject("cmd_4c_Btncarregar", "CommandButton")
1370:         WITH loc_oCnt.cmd_4c_Btncarregar
1371:             .Left            = 822
1372:             .Top             = 0
1373:             .Width           = 102
1374:             .Height          = 40
1375:             .FontName        = "Comic Sans MS"
1376:             .FontBold        = .T.
1377:             .FontItalic      = .T.
1378:             .FontSize        = 8
1379:             .WordWrap        = .T.
1380:             .ForeColor       = RGB(90, 90, 90)
1381:             .BackColor       = RGB(255, 255, 255)
1382:             .Themes          = .T.
1383:             .PicturePosition = 1
1384:             .MousePointer    = 15
1385:             .Caption         = "Carrega Cadastro"
1386:             .ToolTipText     = "Carregar Cadastro"
1387:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
1388:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
1389:         ENDWITH
1390:         BINDEVENT(loc_oCnt.cmd_4c_Btncarregar, "Click", THIS, "BtncarregarClick")
1391: 
1392:         loc_oCnt.AddObject("cmd_4c_BtnRetCash", "CommandButton")
1393:         WITH loc_oCnt.cmd_4c_BtnRetCash
1394:             .Left            = 924
1395:             .Top             = 0
1396:             .Width           = 102
1397:             .Height          = 40
1398:             .FontName        = "Comic Sans MS"
1399:             .FontBold        = .T.
1400:             .FontItalic      = .T.
1401:             .FontSize        = 8
1402:             .WordWrap        = .T.
1403:             .ForeColor       = RGB(90, 90, 90)
1404:             .BackColor       = RGB(255, 255, 255)
1405:             .Themes          = .T.
1406:             .PicturePosition = 1
1407:             .MousePointer    = 15
1408:             .Caption         = "Retorna B" + CHR(244) + "nus"
1409:             .ToolTipText     = "Retorna B" + CHR(244) + "nus"
1410:             .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
1411:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
1412:         ENDWITH
1413:         BINDEVENT(loc_oCnt.cmd_4c_BtnRetCash, "Click", THIS, "BtnRetCashClick")
1414:     ENDPROC
1415: 
1416:     *==========================================================================
1417:     * ConfigurarBotoesAcao - Preenche cnt_4c_BotoesAcao (Top=359 no legado).
1418:     *==========================================================================
1419:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
1420:         LOCAL loc_oCnt
1421:         loc_oCnt = THIS.cnt_4c_BotoesAcao
1422: 
1423:         loc_oCnt.AddObject("cmd_4c_BtnCadPro", "CommandButton")
1424:         WITH loc_oCnt.cmd_4c_BtnCadPro
1425:             .Left            = 39
1426:             .Top             = 0
1427:             .Width           = 100
1428:             .Height          = 40
1429:             .FontName        = "Tahoma"
1430:             .FontBold        = .T.
1431:             .FontItalic      = .T.
1432:             .FontSize        = 7
1433:             .WordWrap        = .T.
1434:             .ForeColor       = RGB(90, 90, 90)
1435:             .BackColor       = RGB(255, 255, 255)
1436:             .Themes          = .T.
1437:             .PicturePosition = 1
1438:             .MousePointer    = 15
1439:             .Caption         = "Ca\<dastro de Produtos"
1440:             .ToolTipText     = "Cadastro de Produtos"
1441:             .Picture         = gc_4c_CaminhoIcones + "geral_produto_26.jpg"
1442:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_produto_26.jpg"
1443:         ENDWITH
1444:         BINDEVENT(loc_oCnt.cmd_4c_BtnCadPro, "Click", THIS, "BtnCadProClick")
1445: 
1446:         loc_oCnt.AddObject("cmd_4c_BtnPApaga", "CommandButton")
1447:         WITH loc_oCnt.cmd_4c_BtnPApaga
1448:             .Left            = 139
1449:             .Top             = 0
1450:             .Width           = 100
1451:             .Height          = 40
1452:             .FontName        = "Tahoma"
1453:             .FontBold        = .T.
1454:             .FontItalic      = .T.
1455:             .FontSize        = 7
1456:             .WordWrap        = .T.
1457:             .ForeColor       = RGB(90, 90, 90)
1458:             .BackColor       = RGB(255, 255, 255)
1459:             .Themes          = .T.
1460:             .PicturePosition = 1
1461:             .MousePointer    = 15
1462:             .Caption         = "E\<xclus" + CHR(227) + "o de Produtos"
1463:             .ToolTipText     = "Apagar Produto da Grade"
1464:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1465:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1466:         ENDWITH
1467:         BINDEVENT(loc_oCnt.cmd_4c_BtnPApaga, "Click", THIS, "BtnPApagaClick")
1468: 
1469:         loc_oCnt.AddObject("cmd_4c_BtnCompos", "CommandButton")
1470:         WITH loc_oCnt.cmd_4c_BtnCompos
1471:             .Left            = 239
1472:             .Top             = 0
1473:             .Width           = 100
1474:             .Height          = 40
1475:             .FontName        = "Tahoma"
1476:             .FontBold        = .T.
1477:             .FontItalic      = .T.
1478:             .FontSize        = 7
1479:             .WordWrap        = .T.
1480:             .ForeColor       = RGB(90, 90, 90)
1481:             .BackColor       = RGB(255, 255, 255)
1482:             .Themes          = .T.
1483:             .PicturePosition = 1
1484:             .MousePointer    = 15
1485:             .Caption         = "Carregar Compo\<si" + CHR(231) + CHR(227) + "o"
1486:             .ToolTipText     = "Componentes"
1487:             .Picture         = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
1488:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
1489:         ENDWITH
1490:         BINDEVENT(loc_oCnt.cmd_4c_BtnCompos, "Click", THIS, "BtnComposClick")
1491: 
1492:         loc_oCnt.AddObject("cmd_4c_BtnAltPrecos", "CommandButton")
1493:         WITH loc_oCnt.cmd_4c_BtnAltPrecos
1494:             .Left            = 339
1495:             .Top             = 0
1496:             .Width           = 100
1497:             .Height          = 40
1498:             .FontName        = "Tahoma"
1499:             .FontBold        = .T.
1500:             .FontItalic      = .T.
1501:             .FontSize        = 7
1502:             .WordWrap        = .T.
1503:             .ForeColor       = RGB(90, 90, 90)
1504:             .BackColor       = RGB(255, 255, 255)
1505:             .Themes          = .T.
1506:             .PicturePosition = 1
1507:             .MousePointer    = 15
1508:             .Caption         = "Al\<tera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os"
1509:             .ToolTipText     = "Alterar Pre" + CHR(231) + "os"
1510:             .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
1511:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
1512:         ENDWITH
1513:         BINDEVENT(loc_oCnt.cmd_4c_BtnAltPrecos, "Click", THIS, "BtnAltPrecosClick")
1514: 
1515:         loc_oCnt.AddObject("cmd_4c_BtnPBuscas", "CommandButton")
1516:         WITH loc_oCnt.cmd_4c_BtnPBuscas
1517:             .Left            = 439
1518:             .Top             = 0
1519:             .Width           = 100
1520:             .Height          = 40
1521:             .FontName        = "Tahoma"
1522:             .FontBold        = .T.
1523:             .FontItalic      = .T.
1524:             .FontSize        = 7
1525:             .WordWrap        = .T.
1526:             .ForeColor       = RGB(90, 90, 90)
1527:             .BackColor       = RGB(255, 255, 255)
1528:             .Themes          = .T.
1529:             .PicturePosition = 1
1530:             .MousePointer    = 15
1531:             .Caption         = "Proc\<ura de Produtos"
1532:             .ToolTipText     = "Procurar Produtos"
1533:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
1534:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
1535:         ENDWITH
1536:         BINDEVENT(loc_oCnt.cmd_4c_BtnPBuscas, "Click", THIS, "BtnPBuscasClick")
1537: 
1538:         loc_oCnt.AddObject("cmd_4c_BtnPedido", "CommandButton")
1539:         WITH loc_oCnt.cmd_4c_BtnPedido
1540:             .Left            = 539
1541:             .Top             = 0
1542:             .Width           = 100
1543:             .Height          = 40
1544:             .FontName        = "Tahoma"
1545:             .FontBold        = .T.
1546:             .FontItalic      = .T.
1547:             .FontSize        = 7
1548:             .WordWrap        = .T.
1549:             .ForeColor       = RGB(90, 90, 90)
1550:             .BackColor       = RGB(255, 255, 255)
1551:             .Themes          = .T.
1552:             .PicturePosition = 1
1553:             .MousePointer    = 15
1554:             .Caption         = "Informar Pedido"
1555:             .Picture         = gc_4c_CaminhoIcones + "geral_documento_26.jpg"
1556:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_documento_26.jpg"
1557:         ENDWITH
1558:         BINDEVENT(loc_oCnt.cmd_4c_BtnPedido, "Click", THIS, "BtnPedidoClick")
1559: 
1560:         loc_oCnt.AddObject("cmd_4c_Btnsubcp", "CommandButton")
1561:         WITH loc_oCnt.cmd_4c_Btnsubcp
1562:             .Left            = 639
1563:             .Top             = 0
1564:             .Width           = 100
1565:             .Height          = 40
1566:             .FontName        = "Tahoma"
1567:             .FontBold        = .T.
1568:             .FontItalic      = .T.
1569:             .FontSize        = 7
1570:             .WordWrap        = .T.
1571:             .ForeColor       = RGB(90, 90, 90)
1572:             .BackColor       = RGB(255, 255, 255)
1573:             .Themes          = .T.
1574:             .PicturePosition = 1
1575:             .MousePointer    = 15
1576:             .Caption         = "\<Substituir Composi" + CHR(231) + CHR(227) + "o"
1577:             .ToolTipText     = "Componentes"
1578:             .Picture         = gc_4c_CaminhoIcones + "geral_subnivel_26.jpg"
1579:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_subnivel_26.jpg"
1580:         ENDWITH
1581:         BINDEVENT(loc_oCnt.cmd_4c_Btnsubcp, "Click", THIS, "BtnsubcpClick")
1582: 
1583:         loc_oCnt.AddObject("cmd_4c_BtnDet", "CommandButton")
1584:         WITH loc_oCnt.cmd_4c_BtnDet
1585:             .Left            = 639
1586:             .Top             = 0
1587:             .Width           = 100
1588:             .Height          = 40
1589:             .FontName        = "Tahoma"
1590:             .FontBold        = .T.
1591:             .FontItalic      = .T.
1592:             .FontSize        = 7
1593:             .ForeColor       = RGB(90, 90, 90)
1594:             .BackColor       = RGB(255, 255, 255)
1595:             .Themes          = .T.
1596:             .PicturePosition = 1
1597:             .MousePointer    = 15
1598:             .Caption         = "Detalhes"
1599:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1600:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1601:         ENDWITH
1602:         BINDEVENT(loc_oCnt.cmd_4c_BtnDet, "Click", THIS, "BtnDetClick")
1603: 
1604:         *-- cmd_4c_BtnOptFin e cmd_4c_BtnDesc ocupam o MESMO Left=746 no SCX legado
1605:         *-- (feature mutuamente exclusiva por configuracao da operacao) -
1606:         *-- transcrito literal do dump, sem inventar posicao nova.
1607:         loc_oCnt.AddObject("cmd_4c_BtnOptFin", "CommandButton")
1608:         WITH loc_oCnt.cmd_4c_BtnOptFin
1609:             .Left            = 739
1610:             .Top             = 0
1611:             .Width           = 100
1612:             .Height          = 40
1613:             .FontName        = "Tahoma"
1614:             .FontBold        = .T.
1615:             .FontItalic      = .T.
1616:             .FontSize        = 7
1617:             .ForeColor       = RGB(90, 90, 90)
1618:             .BackColor       = RGB(255, 255, 255)
1619:             .Themes          = .T.
1620:             .PicturePosition = 1
1621:             .MousePointer    = 15
1622:             .Caption         = "Finalidade"
1623:             .ToolTipText     = "Selecionar Finalidade da opera" + CHR(231) + CHR(227) + "o para ser usada no relat" + CHR(243) + "rio de opera" + CHR(231) + CHR(245) + "es."
1624:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1625:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1626:         ENDWITH
1627:         BINDEVENT(loc_oCnt.cmd_4c_BtnOptFin, "Click", THIS, "BtnOptFinClick")
1628: 
1629:         loc_oCnt.AddObject("cmd_4c_BtnDesc", "CommandButton")
1630:         WITH loc_oCnt.cmd_4c_BtnDesc
1631:             .Left            = 739
1632:             .Top             = 0
1633:             .Width           = 100
1634:             .Height          = 40
1635:             .FontName        = "Tahoma"
1636:             .FontBold        = .T.
1637:             .FontItalic      = .T.
1638:             .FontSize        = 7
1639:             .ForeColor       = RGB(90, 90, 90)
1640:             .BackColor       = RGB(255, 255, 255)
1641:             .Themes          = .T.
1642:             .PicturePosition = 1
1643:             .MousePointer    = 15
1644:             .Caption         = "Descontos"
1645:             .ToolTipText     = "Selecionar Finalidade da opera" + CHR(231) + CHR(227) + "o para ser usada no relat" + CHR(243) + "rio de opera" + CHR(231) + CHR(245) + "es."
1646:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1647:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1648:         ENDWITH
1649:         BINDEVENT(loc_oCnt.cmd_4c_BtnDesc, "Click", THIS, "BtnDescClick")
1650: 
1651:         loc_oCnt.AddObject("cmd_4c_BtnLocDes", "CommandButton")
1652:         WITH loc_oCnt.cmd_4c_BtnLocDes
1653:             .Left            = 839
1654:             .Top             = 0
1655:             .Width           = 100
1656:             .Height          = 40
1657:             .FontName        = "Tahoma"
1658:             .FontBold        = .T.
1659:             .FontItalic      = .T.
1660:             .FontSize        = 7
1661:             .ForeColor       = RGB(90, 90, 90)
1662:             .BackColor       = RGB(255, 255, 255)
1663:             .Themes          = .T.
1664:             .PicturePosition = 1
1665:             .MousePointer    = 15
1666:             .Caption         = "Local. Destino"
1667:             .ToolTipText     = "Selecionar Localiza" + CHR(231) + CHR(227) + "o de Destino do Produto"
1668:             .Picture         = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1669:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1670:         ENDWITH
1671:         BINDEVENT(loc_oCnt.cmd_4c_BtnLocDes, "Click", THIS, "BtnLocDesClick")
1672: 
1673:         loc_oCnt.AddObject("cmd_4c_BtnLocOri", "CommandButton")
1674:         WITH loc_oCnt.cmd_4c_BtnLocOri
1675:             .Left            = 939
1676:             .Top             = 0
1677:             .Width           = 100
1678:             .Height          = 40
1679:             .FontName        = "Tahoma"
1680:             .FontBold        = .T.
1681:             .FontItalic      = .T.
1682:             .FontSize        = 7
1683:             .ForeColor       = RGB(90, 90, 90)
1684:             .BackColor       = RGB(255, 255, 255)
1685:             .Themes          = .T.
1686:             .PicturePosition = 1
1687:             .MousePointer    = 15
1688:             .Caption         = "Local. Origem"
1689:             .ToolTipText     = "Selecionar Localiza" + CHR(231) + CHR(227) + "o de Origem do Produto"
1690:             .Picture         = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1691:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1692:         ENDWITH
1693:         BINDEVENT(loc_oCnt.cmd_4c_BtnLocOri, "Click", THIS, "BtnLocOriClick")
1694:     ENDPROC
1695: 
1696:     *==========================================================================
1697:     * ReaplicarVisibilidadeInicial - TornarControlesVisiveis forca Visible=.T.
1698:     * em tudo; aqui escondemos de volta os botoes que o SCX legado declara
1699:     * Visible=.F. por padrao (toggle condicional a configuracao da operacao,
1700:     * ainda nao conectada nesta fase).
1701:     *==========================================================================
1702:     PROTECTED PROCEDURE ReaplicarVisibilidadeInicial()
1703:         THIS.cnt_4c_Botoes.cmd_4c_BtnRetCash.Visible    = .F.
1704:         THIS.cnt_4c_Botoes.cmd_4c_Btndevolu.Visible      = .F.
1705:         THIS.cnt_4c_Botoes.cmd_4c_BtnRecImps.Visible     = .F.
1706:         THIS.cnt_4c_Botoes.cmd_4c_BtnAltImps.Visible     = .F.
1707:         THIS.cnt_4c_Botoes.cmd_4c_BtnCotacao.Visible     = .F.
1708:         THIS.cnt_4c_Botoes.cmd_4c_BtnTotItens.Visible    = .F.
1709:         THIS.cnt_4c_Botoes.chk_4c_BtnVerImps.Visible     = .F.
1710:         THIS.cnt_4c_Botoes.cmd_4c_Btncarregar.Visible    = .F.
1711:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnLocDes.Visible  = .F.
1712:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnDet.Visible     = .F.
1713: 
1714:         *-- Page1 (pgProds): controles que o SCX legado declara Visible = .F.
1715:         WITH THIS.pgf_4c_Paginas.Page1
1716:             .cnt_4c_Obs.Visible        = .F.
1717:             .img_4c_ImgProds.Visible   = .F.
1718:             .txt_4c_Valors.Visible     = .F.
1719:             .lbl_4c_LblValors.Visible  = .F.
1720:             .txt_4c_CodCors.Visible    = .F.
1721:             .lbl_4c_LblCodCors.Visible = .F.
1722:             .txt_4c_CodTams.Visible    = .F.
1723:             .lbl_4c_LblCodTams.Visible = .F.
1724:             .txt_4c_GerDIfors.Visible  = .F.
1725:             .lbl_4c_Label15.Visible    = .F.
1726:         ENDWITH
1727: 
1728:         *-- Page4 (pgPrecos): a grade de precificacao nasce oculta no legado.
1729:         *-- Mesmo nome do grid principal (eh o que o mapeamento do form manda),
1730:         *-- mas outro PAI - o caminho completo nao deixa ambiguidade.
1731:         THIS.pgf_4c_Paginas.Page4.grd_4c_Dados.Visible = .F.
1732:     ENDPROC
1733: 
1734:     *==========================================================================
1735:     * AjustarBotoesPorModo - Espelha os guards When do legado (InList sobre
1736:     * Op_Escolha + linha corrente na grade). Chamado no fim de InicializarForm
1737:     * e deve ser repetido apos qualquer troca de modo/linha (regra #40).
1738:     * PUBLIC: o TesteAutomatico chama THIS.oForm.AjustarBotoesPorModo() de
1739:     * FORA da classe, e PEMSTATUS(...,5) devolve .T. mesmo para PROTECTED
1740:     * (so testa existencia, nao escopo) - entao o harness entraria no branch
1741:     * e a chamada estouraria em runtime (regra #3).
1742:     *==========================================================================
1743:     PROCEDURE AjustarBotoesPorModo()
1744:         LOCAL loc_lEdicao, loc_lTemLinha
1745: 
1746:         loc_lEdicao   = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
1747:         loc_lTemLinha = USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens") ;
1748:                         AND RECCOUNT("cursor_4c_Itens") > 0
1749: 
1750:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnCadPro.Enabled    = loc_lEdicao AND loc_lTemLinha
1751:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnPApaga.Enabled    = loc_lEdicao AND loc_lTemLinha
1752:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnCompos.Enabled    = loc_lEdicao AND loc_lTemLinha
1753:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnAltPrecos.Enabled = loc_lEdicao AND loc_lTemLinha
1754:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnPedido.Enabled    = loc_lEdicao AND loc_lTemLinha
1755:         THIS.cnt_4c_BotoesAcao.cmd_4c_Btnsubcp.Enabled     = loc_lTemLinha
1756:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnDet.Enabled       = loc_lTemLinha
1757:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnOptFin.Enabled    = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
1758:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnDesc.Enabled      = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
1759:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnLocOri.Enabled    = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
1760:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnLocDes.Enabled    = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
1761:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnPBuscas.Enabled   = .T.
1762: 
1763:         THIS.cnt_4c_Botoes.cmd_4c_BtnIteSub.Enabled    = loc_lEdicao
1764:         THIS.cnt_4c_Botoes.cmd_4c_CmdXml.Enabled       = loc_lEdicao
1765:         THIS.cnt_4c_Botoes.cmd_4c_Btncarregar.Enabled  = loc_lEdicao
1766:         THIS.cnt_4c_Botoes.cmd_4c_BtnTotItens.Enabled  = loc_lEdicao
1767:         THIS.cnt_4c_Botoes.cmd_4c_BtnCotacao.Enabled   = loc_lEdicao
1768:         THIS.cnt_4c_Botoes.cmd_4c_BtnAltImps.Enabled   = loc_lEdicao AND loc_lTemLinha
1769:         THIS.cnt_4c_Botoes.cmd_4c_BtnRecImps.Enabled   = loc_lTemLinha
1770:         THIS.cnt_4c_Botoes.cmd_4c_Btndevolu.Enabled    = loc_lTemLinha
1771:         THIS.cnt_4c_Botoes.cmd_4c_BtnRetCash.Enabled   = loc_lEdicao
1772:         THIS.cnt_4c_Botoes.chk_4c_BtnVerImps.Enabled   = loc_lTemLinha
1773:     ENDPROC
1774: 
1775:     *==========================================================================
1776:     * AlternarPagina - PUBLIC (chamado de fora pelo TesteAutomatico e pelo
1777:     * form pai). Troca a aba ativa de pgf_4c_Paginas (1=Produto, 2=Movimenta-
1778:     * cao, 3=Fiscal, 4=Precificacao).
1779:     *==========================================================================
1780:     PROCEDURE AlternarPagina(par_nPagina)
1781:         IF !BETWEEN(par_nPagina, 1, THIS.pgf_4c_Paginas.PageCount)
1782:             RETURN .F.
1783:         ENDIF
1784: 
1785:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1786: 
1787:         *-- Refresh em pagina OCULTA nao pinta (regra #46): o painel do item
1788:         *-- so eh atualizado DEPOIS de a aba virar a ativa.
1789:         IF INLIST(par_nPagina, 1, 3)
1790:             THIS.AtualizarPainelProduto()
1791:         ENDIF
1792: 
1793:         THIS.pgf_4c_Paginas.Pages(par_nPagina).Refresh()
1794: 
1795:         RETURN .T.
1796:     ENDPROC
1797: 
1798:     *==========================================================================
1799:     * TemProdutoSelecionado - cursor_4c_Itens posicionado em linha com
1800:     * produto preenchido (equivalente a !Eof('crTpmMvItn') And !Empty(Cpros)
1801:     * usado nos guards When do legado).
1802:     *==========================================================================
1803:     PROTECTED FUNCTION TemProdutoSelecionado()
1804:         RETURN USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens") ;
1805:                AND !EMPTY(cursor_4c_Itens.cpros)
1806:     ENDFUNC
1807: 
1808:     *==========================================================================
1809:     * CarregarDados - Carga da grade de itens da movimentacao. PUBLIC: eh
1810:     * chamado de fora (TesteAutomatico / form pai) e pelo funil de recarga.
1811:     *
1812:     * Equivale ao AddCursor('SigMvItn', ...) que o legado herda do form pai
1813:     * de Movimentacao (crTpmMvItn) seguido de "Select crTpmMvItn / Goto Top"
1814:     * no fim do Init.
1815:     *
1816:     * O BO le para um cursor TEMPORARIO e aqui o alias da grade eh recarregado
1817:     * com SELECT/ZAP/APPEND FROM DBF(): SQLEXEC direto sobre o alias ligado ao
1818:     * Grid o FECHA e RECRIA, zerando o ColumnCount - a grade viraria um
1819:     * retangulo branco sem cabecalho, sem erro e sem log.
1820:     *==========================================================================
1821:     PROCEDURE CarregarDados()
1822:         LOCAL loc_lSucesso, loc_cChave, loc_oErro
1823: 
1824:         loc_lSucesso = .F.
1825: 
1826:         IF !USED("cursor_4c_Itens")
1827:             THIS.CriarCursorItens()
1828:         ENDIF
1829: 
1830:         loc_cChave = THIS.ObterChaveMovimentacao()
1831: 
1832:         IF EMPTY(loc_cChave)
1833:             *-- Sem movimentacao selecionada a grade abre VAZIA, como no legado
1834:             *-- (o cursor do pai nasce sem linha). Nao eh falha: repinta e sai.
1835:             THIS.PrepararLinhaInicial()
1836:             THIS.RepintarGradeItens()
1837:             THIS.AjustarBotoesPorModo()
1838:             RETURN .F.
1839:         ENDIF
1840: 
1841:         TRY
1842:             IF THIS.this_oBusinessObject.CarregarItens(loc_cChave, "cursor_4c_ItensTmp")
1843:                 THIS.ZaparCursorItens()
1844:                 IF USED("cursor_4c_ItensTmp")
1845:                     SELECT cursor_4c_Itens
1846:                     APPEND FROM DBF("cursor_4c_ItensTmp")
1847:                 ENDIF
1848:                 loc_lSucesso = .T.
1849:             ENDIF
1850: 
1851:             IF USED("cursor_4c_ItensTmp")
1852:                 USE IN cursor_4c_ItensTmp
1853:             ENDIF
1854: 
1855:         CATCH TO loc_oErro
1856:             THIS.this_cMensagemErro = loc_oErro.Message
1857:             MsgErro("Erro ao carregar os itens da movimenta" + CHR(231) + CHR(227) + ;
1858:                     "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1859:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1860:                     "Proc: " + loc_oErro.Procedure, "Erro CarregarDados")
1861:         ENDTRY
1862: 
1863:         *-- Em edicao o legado fecha o Init entregando a linha de digitacao
1864:         *-- (Count To lnCount / CItem = lnCount / minserelinha)
1865:         THIS.PrepararLinhaInicial()
1866: 
1867:         *-- Funil unico: popular o cursor NAO repinta a grade (regra #21)
1868:         THIS.RepintarGradeItens()
1869:         THIS.AplicarModoNaGrade()
1870:         THIS.AjustarBotoesPorModo()
1871: 
1872:         RETURN loc_lSucesso
1873:     ENDPROC
1874: 
1875:     *==========================================================================
1876:     * PrepararLinhaInicial - Fecho do Init legado, que em INSERIR/ALTERAR
1877:     * entrega uma linha em branco pronta para digitacao:
1878:     *
1879:     *   Select crTpmMvItn / Set Order To
1880:     *   If Thisform.Op_Escolha = 'ALTERAR' Or crSigCdOpe.SubnObrigs = 3
1881:     *       Count To lnCount / Thisform.CItem = lnCount / Thisform.minserelinha()
1882:     *   Else
1883:     *       If Thisform.Op_Escolha = 'INSERIR'
1884:     *           Count To lnCount / Thisform.CItem = lnCount / minserelinha()
1885:     *       Endif
1886:     *   Endif
1887:     *
1888:     * Em CONSULTAR/EXCLUIR o legado NAO entrega linha nova (a grade abre so
1889:     * com o que foi gravado), e o mesmo vale aqui.
1890:     *==========================================================================
1891:     PROTECTED PROCEDURE PrepararLinhaInicial()
1892:         LOCAL loc_nRegistros
1893: 
1894:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
1895:             RETURN .F.
1896:         ENDIF
1897: 
1898:         IF !USED("cursor_4c_Itens")
1899:             RETURN .F.
1900:         ENDIF
1901: 
1902:         SELECT cursor_4c_Itens
1903:         COUNT TO loc_nRegistros
1904:         THIS.this_nCItem = loc_nRegistros
1905: 
1906:         RETURN THIS.InserirLinhaGrade()
1907:     ENDPROC
1908: 
1909:     *==========================================================================
1910:     * RepintarGradeItens - FUNIL UNICO de repintura da grade. Popular o cursor
1911:     * NAO faz a grade exibir as linhas (regra #21): o legado sempre fecha com
1912:     * "Go Top In crTpmMvItn" + "fwGrade.Refresh". Tem de rodar em TODO caminho
1913:     * que mexe no cursor (carga, exclusao de linha, troca de modo) e DEPOIS de
1914:     * trocar o ActivePage - Refresh em pagina oculta nao pinta.
1915:     *==========================================================================
1916:     PROCEDURE RepintarGradeItens()
1917:         IF !USED("cursor_4c_Itens")
1918:             RETURN
1919:         ENDIF
1920: 
1921:         SELECT cursor_4c_Itens
1922:         GO TOP
1923: 
1924:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1925:             *-- Reinstala os CheckBox de coluna antes de repintar: se algo
1926:             *-- tiver reatribuido RecordSource/ColumnCount ou fechado o
1927:             *-- alias, os objetos postos nas Columns foram destruidos. A
1928:             *-- instalacao eh idempotente.
1929:             THIS.InstalarCheckBoxesGrade()
1930:             THIS.grd_4c_Dados.Refresh()
1931:         ENDIF
1932:     ENDPROC
1933: 
1934:     *==========================================================================
1935:     * ZaparCursorItens - ZAP guardado por SAFETY. SET SAFETY eh escopado por
1936:     * DATA SESSION: este form eh DataSession = 2, e na sessao privada SAFETY
1937:     * vale ON mesmo com o SET SAFETY OFF do main.prg. Com SAFETY ON o ZAP
1938:     * abre o dialogo modal "Zap ... Are you sure?" e CONGELA a tela,
1939:     * esperando um clique que ninguem ve (nao eh erro: em teste headless
1940:     * aparece como timeout sem resultado).
1941:     *
1942:     * ZAP eh a escolha CERTA aqui (o legado faz "Zap In <cursor>"): preserva
1943:     * a estrutura e o binding do Grid. Fechar e recriar o alias derrubaria
1944:     * RecordSource/ControlSource e a grade ficaria vazia com o cursor cheio.
1945:     *==========================================================================
1946:     PROTECTED PROCEDURE ZaparCursorItens()
1947:         LOCAL loc_cSafety
1948: 
1949:         IF !USED("cursor_4c_Itens")
1950:             RETURN
1951:         ENDIF
1952: 
1953:         loc_cSafety = SET("SAFETY")
1954:         SET SAFETY OFF
1955: 
1956:         SELECT cursor_4c_Itens
1957:         ZAP
1958: 
1959:         IF loc_cSafety = "ON"
1960:             SET SAFETY ON
1961:         ENDIF
1962:     ENDPROC
1963: 
1964:     *==========================================================================
1965:     * AplicarModoNaGrade - Espelha o par fwGrade/fwGradeR do legado. No legado sao
1966:     * duas grades mutuamente exclusivas sobre o MESMO cursor, e o proprio
1967:     * legado alinha a segunda na posicao da primeira (".Left = fwGrade.Left /
1968:     * .Top = fwGrade.Top / .Height = fwGrade.Height"), isto eh: visualmente
1969:     * eh UMA grade que alterna entre editavel e somente-leitura.
1970:     *
1971:     * Legado: fwGrade  (editavel)      -> INSERIR, ou ALTERAR com AltEtiqs # 1
1972:     *         fwGradeR (somente-leit.) -> EXCLUIR/CONSULTAR, ou ALTERAR com
1973:     *                                     AltEtiqs = 1
1974:     *
1975:     * Column.ReadOnly vem DEPOIS de Grid.ReadOnly: o do grid propaga para as
1976:     * colunas e sobrescreveria (regra #18).
1977:     *==========================================================================
1978:     PROCEDURE AplicarModoNaGrade()
1979:         LOCAL loc_lEditavel
1980: 
1981:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1982:             RETURN
1983:         ENDIF
1984: 
1985:         loc_lEditavel = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
1986: 
1987:         WITH THIS.grd_4c_Dados
1988:             .ReadOnly = !loc_lEditavel
1989:             .Enabled  = .T.
1990:             *-- Reserva eh ReadOnly tambem na grade editavel (legado:
1991:             *-- fwGrade.Column20.ReadOnly = .T.)
1992:             .Column20.ReadOnly = .T.
1993:         ENDWITH
1994:     ENDPROC
1995: 
1996:     *==========================================================================
1997:     * ObterChaveMovimentacao - empdopnums char(29) da movimentacao corrente.
1998:     * Vem do form pai de Movimentacao (TprMvCab no legado); enquanto a
1999:     * integracao com o pai nao esta conectada, cai na property do proprio
2000:     * form, que o chamador preenche antes do Show.
2001:     *==========================================================================
2002:     PROTECTED FUNCTION ObterChaveMovimentacao()
2003:         LOCAL loc_cChave
2004: 
2005:         loc_cChave = ""
2006: 
2007:         IF !EMPTY(THIS.this_cEmpDopNums)
2008:             loc_cChave = THIS.this_cEmpDopNums
2009:         ELSE
2010:             IF !EMPTY(THIS.this_cEmps + THIS.this_cDopes) OR THIS.this_nNumes <> 0
2011:                 loc_cChave = THIS.this_oBusinessObject.MontarChaveEmpDopNums( ;
2012:                                  THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)
2013:             ENDIF
2014:         ENDIF
2015: 
2016:         RETURN loc_cChave
2017:     ENDFUNC
2018: 
2019:     *==========================================================================
2020:     * InserirLinhaGrade - Equivale a PROCEDURE minserelinha do legado, que eh
2021:     * o "Incluir" desta tela: a inclusao de produto aqui NAO vem de um botao,
2022:     * vem de uma LINHA EM BRANCO entregue na grade para o usuario digitar o
2023:     * codigo. O legado chama este metodo no fim do Init (quando Op_Escolha eh
2024:     * INSERIR ou ALTERAR) e a cada vez que o usuario termina uma linha.
2025:     *
2026:     * Legado:
2027:     *   Select crTpmMvItn / Set Order to CPros / Count to wRegistros
2028:     *   Seek Space(14)                       && procura linha com produto vazio
2029:     *   If Not Eof()                         && achou: nao insere, so desce
2030:     *       If Not ThisForm.lAutPreco / keyboard "{DNARROW}" / EndIf
2031:     *   Else
2032:     *       If wRegistros < crSigCdOpe.qtdites
2033:     *           ThisForm.CItem = ThisForm.CItem + 1
2034:     *           Insert Into crTpmMvItn( Emps, Dopes, Numes, Citens ) Values (...)
2035:     *       EndIf
2036:     *   EndIf
2037:     *   ThisForm.OldCodBarras = 0 / AntCPro = Space(14) / AntValu = Space(3)
2038:     *
2039:     * O cursor migrado nao tem a tag CPros do legado, entao a procura da linha
2040:     * em branco eh LOCATE FOR EMPTY(cpros) - mesmo efeito do Seek Space(14).
2041:     * O "keyboard {DNARROW}" do legado era a forma de levar o foco da grade
2042:     * para a linha nova; aqui o equivalente eh posicionar o cursor nela e
2043:     * repintar, porque a navegacao nao depende da fila de teclado.
2044:     *
2045:     * PUBLIC: o form pai e o harness de teste chamam de fora.
2046:     *==========================================================================
2047:     PROCEDURE InserirLinhaGrade()
2048:         LOCAL loc_nRegistros, loc_lTemLimite, loc_lInseriu
2049: 
2050:         IF !USED("cursor_4c_Itens")
2051:             RETURN .F.
2052:         ENDIF
2053: 
2054:         loc_lInseriu = .F.
2055: 
2056:         SELECT cursor_4c_Itens
2057:         COUNT TO loc_nRegistros
2058: 
2059:         LOCATE FOR EMPTY(cpros)
2060: 
2061:         IF !FOUND()
2062:             *-- Nenhuma linha em branco na grade: entrega uma nova, respeitando
2063:             *-- o teto de itens da operacao quando ele existe (legado:
2064:             *-- "If wRegistros < crSigCdOpe.qtdites").
2065:             loc_lTemLimite = (THIS.this_nQtdItes > 0)
2066: 
2067:             IF !loc_lTemLimite OR loc_nRegistros < THIS.this_nQtdItes
2068:                 THIS.this_nCItem = THIS.this_nCItem + 1
2069: 
2070:                 INSERT INTO cursor_4c_Itens (emps, dopes, numes, citens, empdopnums) ;
2071:                     VALUES (PADR(THIS.this_cEmps, 3), PADR(THIS.this_cDopes, 20), ;
2072:                             THIS.this_nNumes, THIS.this_nCItem, ;
2073:                             THIS.ObterChaveMovimentacao())
2074: 
2075:                 loc_lInseriu = .T.
2076:             ENDIF
2077:         ENDIF
2078: 
2079:         *-- Em qualquer um dos dois caminhos a linha corrente passa a ser a de
2080:         *-- digitacao (a que estava em branco, ou a recem-inserida).
2081:         THIS.RepintarGradeItens()
2082:         THIS.AjustarBotoesPorModo()
2083: 
2084:         RETURN loc_lInseriu
2085:     ENDPROC
2086: 
2087:     *==========================================================================
2088:     * LimparLinhaGrade - Equivale a PROCEDURE apaite do legado: a linha NAO eh
2089:     * removida, so esvaziada, voltando a ser uma linha de digitacao. O legado
2090:     * usa este caminho quando a linha corrente ja esta sem produto e eh a
2091:     * UNICA em branco (ver ExcluirLinhaGrade).
2092:     *
2093:     * Legado (apaite): Replace DPros/Obs/CodBarras/Utilizas/NumeroNota/Notas,
2094:     * apaga os sub-itens da linha (crTpmMvIts com o mesmo CItens) e zera as
2095:     * celulas da grade (Produto, Operacao, Qtd, Peso, Comprimento, Fator,
2096:     * PesoTot, Valor, Moeda, Total), repondo Operacao com 'E' ou 'S' conforme
2097:     * crSigCdOpe.Opers. A operacao reposta aqui vem da propria linha do legado
2098:     * (nTpOpers) atraves das linhas irmas do cursor, para nao inventar valor
2099:     * que a configuracao da operacao nao deu.
2100:     *==========================================================================
2101:     PROCEDURE LimparLinhaGrade()
2102:         LOCAL loc_nCitens
2103: 
2104:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
2105:             RETURN .F.
2106:         ENDIF
2107: 
2108:         SELECT cursor_4c_Itens
2109:         loc_nCitens = cursor_4c_Itens.citens
2110: 
2111:         REPLACE cpros      WITH "", ;
2112:                 dpros      WITH "", ;
2113:                 obs        WITH "", ;
2114:                 codbarras  WITH 0, ;
2115:                 utilizas   WITH 0, ;
2116:                 numeronota WITH "", ;
2117:                 notas      WITH ""
2118: 
2119:         REPLACE qtds    WITH 0, ;
2120:                 pesos   WITH 0, ;
2121:                 compris WITH 0, ;
2122:                 fators  WITH 0, ;
2123:                 tpesos  WITH 0, ;
2124:                 units   WITH 0, ;
2125:                 moedas  WITH "", ;
2126:                 totas   WITH 0
2127: 
2128:         *-- Sub-itens da linha (composicao): no legado moram em crTpmMvIts e
2129:         *-- aqui convivem no mesmo cursor, apontando o pai por citem2.
2130:         DELETE FOR citem2 = loc_nCitens AND citens <> loc_nCitens
2131: 
2132:         *-- Volta a posicionar na linha esvaziada (o DELETE FOR varre o cursor).
2133:         *-- LOCATE em vez de SEEK: nao depende de qual tag esta ativa, e a
2134:         *-- renumeracao de itens troca a ordem corrente durante o SCAN.
2135:         LOCATE FOR citens = loc_nCitens
2136:         IF !FOUND()
2137:             GO TOP
2138:         ENDIF
2139: 
2140:         THIS.RepintarGradeItens()
2141:         THIS.AjustarBotoesPorModo()
2142: 
2143:         RETURN .T.
2144:     ENDPROC
2145: 
2146:     *==========================================================================
2147:     * ExcluirLinhaGrade - Equivale a PROCEDURE deletaritem do legado, que eh o
2148:     * "Excluir" desta tela: exclusao de LINHA da grade de itens (o registro em
2149:     * SigMvItn so eh gravado/removido pelo form pai de Movimentacao, na
2150:     * confirmacao da operacao).
2151:     *
2152:     * Legado (deletaritem):
2153:     *   If !IsEmpty(crTpmMvItn.cpros)
2154:     *       _CItem = CItens / Delete / apaga os sub-itens de cItem2 = _CItem
2155:     *       Delete For cItem2 = _CItem
2156:     *   Else
2157:     *       Select Count(1) From crTpmMvItn Where IsEmpty(cpros) ... xApaga
2158:     *       If xApaga.Total > 1 / Delete / Else / Thisform.ApaIte() / EndIf
2159:     *   EndIf
2160:     *   Select crTpmMvItn / Go Top
2161:     *
2162:     * Isto eh: linha COM produto sai da grade junto com a composicao dela;
2163:     * linha SEM produto so sai se houver outra em branco - se for a unica, ela
2164:     * eh apenas esvaziada, para a grade nunca ficar sem linha de digitacao.
2165:     *
2166:     * PUBLIC: o form pai e o harness de teste chamam de fora.
2167:     *==========================================================================
2168:     PROCEDURE ExcluirLinhaGrade()
2169:         LOCAL loc_nCitens, loc_nEmBranco, loc_nRecno
2170: 
2171:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
2172:             RETURN .F.
2173:         ENDIF
2174: 
2175:         SELECT cursor_4c_Itens
2176: 
2177:         IF EMPTY(cursor_4c_Itens.cpros)
2178:             *-- COUNT varre o cursor e deixa o ponteiro em EOF: sem repor o
2179:             *-- RECNO, o DELETE abaixo cairia no registro fantasma do fim e
2180:             *-- nao apagaria linha nenhuma (sem erro e sem aviso).
2181:             loc_nRecno = RECNO()
2182:             COUNT FOR EMPTY(cpros) TO loc_nEmBranco
2183:             IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
2184:                 GO loc_nRecno
2185:             ENDIF
2186: 
2187:             IF loc_nEmBranco > 1
2188:                 DELETE
2189:             ELSE
2190:                 *-- Unica linha em branco: esvazia em vez de remover
2191:                 THIS.LimparLinhaGrade()
2192:                 RETURN .T.
2193:             ENDIF
2194:         ELSE
2195:             loc_nCitens = cursor_4c_Itens.citens
2196: 
2197:             DELETE
2198: 
2199:             *-- Composicao da linha excluida (legado: Delete For cItem2 = _CItem)
2200:             DELETE FOR citem2 = loc_nCitens AND citens <> loc_nCitens
2201:         ENDIF
2202: 
2203:         SELECT cursor_4c_Itens
2204:         GO TOP
2205: 
2206:         RETURN .T.
2207:     ENDPROC
2208: 

*-- Linhas 2217 a 2896:
2217:     *         ... Replace cItem2 With Cont For cItem2 = _cIt ... Replace CItens
2218:     *         With Cont / EndScan / Thisform.CItem = Cont
2219:     *==========================================================================
2220:     PROCEDURE RenumerarItensGrade()
2221:         LOCAL loc_nCont, loc_nCitensAnt, loc_nRecno
2222: 
2223:         IF !USED("cursor_4c_Itens")
2224:             RETURN 0
2225:         ENDIF
2226: 
2227:         loc_nCont = 0
2228: 
2229:         SELECT cursor_4c_Itens
2230:         SET ORDER TO
2231:         GO TOP
2232: 
2233:         SCAN
2234:             loc_nCont      = loc_nCont + 1
2235:             loc_nCitensAnt = cursor_4c_Itens.citens
2236:             loc_nRecno     = RECNO()
2237: 
2238:             *-- Primeiro as referencias da composicao, depois o proprio item:
2239:             *-- invertido, o Replace de cItem2 nao encontraria mais o valor
2240:             *-- antigo para casar.
2241:             REPLACE citem2 WITH loc_nCont FOR citem2 = loc_nCitensAnt
2242: 
2243:             GO loc_nRecno
2244:             REPLACE citens WITH loc_nCont
2245:         ENDSCAN
2246: 
2247:         SET ORDER TO citens
2248: 
2249:         THIS.this_nCItem = loc_nCont
2250: 
2251:         RETURN loc_nCont
2252:     ENDPROC
2253: 
2254:     *==========================================================================
2255:     * GarantirLinhaDeDigitacao - Equivale ao "If Eof() / Insert Into
2256:     * crTpmMvItn(...) Values (..., 1)" que o legado faz no btnPApaga.Click
2257:     * depois de excluir: se a grade ficou sem nenhuma linha, entrega uma nova
2258:     * para o usuario continuar digitando.
2259:     *==========================================================================
2260:     PROCEDURE GarantirLinhaDeDigitacao()
2261:         LOCAL loc_nRegistros
2262: 
2263:         IF !USED("cursor_4c_Itens")
2264:             RETURN .F.
2265:         ENDIF
2266: 
2267:         SELECT cursor_4c_Itens
2268:         COUNT TO loc_nRegistros
2269: 
2270:         IF loc_nRegistros > 0
2271:             RETURN .F.
2272:         ENDIF
2273: 
2274:         THIS.this_nCItem = 1
2275: 
2276:         INSERT INTO cursor_4c_Itens (emps, dopes, numes, citens, empdopnums) ;
2277:             VALUES (PADR(THIS.this_cEmps, 3), PADR(THIS.this_cDopes, 20), ;
2278:                     THIS.this_nNumes, 1, THIS.ObterChaveMovimentacao())
2279: 
2280:         RETURN .T.
2281:     ENDPROC
2282: 
2283:     *==========================================================================
2284:     * TotalizarLinha - Equivale a PROCEDURE total_item do legado:
2285:     *
2286:     *   parameters pMantVal
2287:     *   =ThisForm.ParentForm.Calc_ValIte(,,pMantVal)
2288:     *   ThisForm.fwGrade.Refresh
2289:     *
2290:     * A aritmetica do total do item (unitario x quantidade, fator, moeda,
2291:     * descontos e impostos) eh regra de negocio que mora no Calc_ValIte do
2292:     * form PAI de Movimentacao - este form so delega e repinta. Reescrever a
2293:     * formula aqui gravaria valor diferente do legado sem erro na tela.
2294:     *
2295:     * PUBLIC: os handlers de celula da grade chamam, e o form pai tambem.
2296:     *==========================================================================
2297:     PROCEDURE TotalizarLinha(par_lManterValor)
2298:         LOCAL loc_lManter, loc_lOk, loc_oErro
2299: 
2300:         loc_lManter = IIF(VARTYPE(par_lManterValor) = "L", par_lManterValor, .F.)
2301:         loc_lOk     = .F.
2302: 
2303:         IF VARTYPE(THIS.this_oParentForm) = "O"
2304:             IF PEMSTATUS(THIS.this_oParentForm, "Calc_ValIte", 5)
2305:                 TRY
2306:                     THIS.this_oParentForm.Calc_ValIte(.F., .F., loc_lManter)
2307:                     loc_lOk = .T.
2308:                 CATCH TO loc_oErro
2309:                     MsgErro("Erro ao totalizar o item:" + CHR(13) + ;
2310:                             loc_oErro.Message + CHR(13) + ;
2311:                             "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2312:                             "Proc: " + loc_oErro.Procedure, "Erro TotalizarLinha")
2313:                 ENDTRY
2314:             ENDIF
2315:         ENDIF
2316: 
2317:         THIS.RepintarGradeItens()
2318: 
2319:         RETURN loc_lOk
2320:     ENDPROC
2321: 
2322:     *==========================================================================
2323:     * ValidarItensAntesDeSair - Gate do btnSair.Click do legado ("Retornar"):
2324:     * antes de devolver o controle ao form pai, o legado percorre os itens e,
2325:     * achando problema, exibe a mensagem, devolve o foco a grade e NAO fecha a
2326:     * tela ("If Not IsEmpty(lcMsg) / Messagebox(lcMsg, 48, lcCaption) /
2327:     * ... SetFocus / Return").
2328:     *
2329:     * O legado so valida quando Op_Escolha eh INSERIR/ALTERAR (e no caso
2330:     * especifico de CONSULTAR com crSigCdOpe.DigItens = 8).
2331:     *
2332:     * Das validacoes do legado, as que dependem de cursor de configuracao da
2333:     * operacao (crSigCdOpe, crSigOpCdc, crSigOpCdd, csOpeAut, TmpOperacao) sao
2334:     * guardadas no proprio legado por teste de valor/Seek nesses cursores, e
2335:     * por isso ficam inertes quando a configuracao nao esta carregada - o
2336:     * mesmo comportamento vale aqui. A checagem de consistencia entre item e
2337:     * composicao eh INCONDICIONAL no legado e eh a que roda aqui:
2338:     *
2339:     *   Select a.* From crTpmMvIts a, crTpmMvItn b Where a.citens = b.citens
2340:     *       And a.CPros <> b.CPros Into Cursor ChecItem
2341:     *   If Reccount() > 0 / lcMsg = 'Problema de inconsistencia com o Item '
2342:     *       + Str(ChecItem.citens,4) + ' Produto:' + ChecItem.CPros
2343:     *
2344:     * Devolve .T. quando os itens estao consistentes.
2345:     *==========================================================================
2346:     PROCEDURE ValidarItensAntesDeSair()
2347:         LOCAL loc_lOk, loc_cMsg, loc_cTitulo, loc_nRecno
2348: 
2349:         loc_lOk     = .T.
2350:         loc_cMsg    = ""
2351:         loc_cTitulo = "Inconsistencia dos Itens"
2352: 
2353:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2354:             RETURN .T.
2355:         ENDIF
2356: 
2357:         IF !USED("cursor_4c_Itens")
2358:             RETURN .T.
2359:         ENDIF
2360: 
2361:         SELECT cursor_4c_Itens
2362:         loc_nRecno = RECNO()
2363: 
2364:         *-- Composicao (citem2 aponta o item pai) cujo produto divergiu do
2365:         *-- produto do pai: no legado sao duas tabelas (crTpmMvIts x
2366:         *-- crTpmMvItn) ligadas por citens; aqui convivem no mesmo cursor.
2367:         SELECT a.citens, a.cpros ;
2368:             FROM cursor_4c_Itens a, cursor_4c_Itens b ;
2369:             WHERE a.citem2 <> 0 ;
2370:               AND a.citem2 = b.citens ;
2371:               AND a.cpros <> b.cpros ;
2372:             INTO CURSOR cursor_4c_ChecaItem
2373: 
2374:         IF USED("cursor_4c_ChecaItem")
2375:             SELECT cursor_4c_ChecaItem
2376:             GO TOP
2377:             IF !EOF()
2378:                 loc_cMsg = "Problema de inconsistencia com o Item " + ;
2379:                            STR(cursor_4c_ChecaItem.citens, 4) + ;
2380:                            " Produto:" + ALLTRIM(cursor_4c_ChecaItem.cpros)
2381:             ENDIF
2382:             USE IN cursor_4c_ChecaItem
2383:         ENDIF
2384: 
2385:         SELECT cursor_4c_Itens
2386:         IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
2387:             GO loc_nRecno
2388:         ENDIF
2389: 
2390:         IF !EMPTY(loc_cMsg)
2391:             loc_lOk = .F.
2392:             MsgAviso(loc_cMsg, loc_cTitulo)
2393: 
2394:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Visible
2395:                 THIS.grd_4c_Dados.SetFocus()
2396:             ENDIF
2397:         ENDIF
2398: 
2399:         RETURN loc_lOk
2400:     ENDPROC
2401: 
2402:     *==========================================================================
2403:     * BtnEncerrarClick - "Retornar" ao form pai (OK.btnSair do legado, que eh
2404:     * Cancel = .T. - ESC cai aqui). O legado valida os itens primeiro e, so
2405:     * passando, reabilita o pai e fecha:
2406:     *
2407:     *   ... validacoes ... If Not IsEmpty(lcMsg) / Messagebox / SetFocus / Return
2408:     *   If llOk / With Thisform.ParentForm / .Enabled = .T. / ... / Endwith / Endif
2409:     *   Thisform.Release
2410:     *
2411:     * A reabilitacao do pai eh obrigatoria: o legado o desabilita ao abrir
2412:     * esta tela (Thisform.ParentForm.Enabled = .f. no Init), e sem o
2413:     * .Enabled = .T. aqui o usuario volta para uma tela de Movimentacao morta.
2414:     *==========================================================================
2415:     PROCEDURE BtnEncerrarClick()
2416:         IF !THIS.ValidarItensAntesDeSair()
2417:             RETURN
2418:         ENDIF
2419: 
2420:         IF VARTYPE(THIS.this_oParentForm) = "O"
2421:             IF PEMSTATUS(THIS.this_oParentForm, "Enabled", 5)
2422:                 THIS.this_oParentForm.Enabled = .T.
2423:             ENDIF
2424:         ENDIF
2425: 
2426:         THIS.Release()
2427:     ENDPROC
2428: 
2429:     *==========================================================================
2430:     * Handlers dos botoes de cnt_4c_Botoes (toolbar superior, Top=81)
2431:     *==========================================================================
2432: 
2433:     *-- "Total de Produtos": Do Form SigOpTot With ThisForm, DataSessionId
2434:     PROCEDURE BtnTotItensClick()
2435:         LOCAL loc_oForm, loc_oErro
2436:         loc_oForm = .NULL.
2437:         TRY
2438:             loc_oForm = CREATEOBJECT("FormSigOpTot", THIS, THIS.DataSessionId)
2439:         CATCH TO loc_oErro
2440:             MostrarErro("Erro ao abrir Total de Produtos:" + CHR(13) + loc_oErro.Message, "Erro")
2441:             loc_oForm = .NULL.
2442:         ENDTRY
2443:         IF VARTYPE(loc_oForm) = "O"
2444:             loc_oForm.Show()
2445:         ENDIF
2446:     ENDPROC
2447: 
2448:     *-- "Cambio de Produtos": Do Form SigOpCot With ParentForm, TprMvCab.Datas
2449:     PROCEDURE BtnCotacaoClick()
2450:         LOCAL loc_oForm, loc_oErro
2451:         loc_oForm = .NULL.
2452:         TRY
2453:             loc_oForm = CREATEOBJECT("FormSigOpCot", THIS.this_oParentForm)
2454:         CATCH TO loc_oErro
2455:             MostrarErro("Erro ao abrir C" + CHR(226) + "mbio de Produtos:" + CHR(13) + loc_oErro.Message, "Erro")
2456:             loc_oForm = .NULL.
2457:         ENDTRY
2458:         IF VARTYPE(loc_oForm) = "O"
2459:             loc_oForm.Show()
2460:             THIS.grd_4c_Dados.Refresh()
2461:         ENDIF
2462:     ENDPROC
2463: 
2464:     *-- "Alterar Impostos": habilita a pagina Fiscal e navega para ela
2465:     PROCEDURE BtnAltImpsClick()
2466:         IF !THIS.TemProdutoSelecionado()
2467:             MsgAviso("Selecione um Produto Na Grade para alterar impostos.", "Aten" + CHR(231) + CHR(227) + "o")
2468:             RETURN
2469:         ENDIF
2470:         THIS.pgf_4c_Paginas.Page3.Enabled = .T.
2471:         THIS.AlternarPagina(3)
2472:     ENDPROC
2473: 
2474:     *-- "Visualizar Impostos": toggle que leva a pagina Fiscal
2475:     PROCEDURE BtnVerImpsClick()
2476:         IF !THIS.TemProdutoSelecionado()
2477:             THIS.cnt_4c_Botoes.chk_4c_BtnVerImps.Value = 0
2478:             THIS.pgf_4c_Paginas.Page3.Enabled          = .F.
2479:             RETURN
2480:         ENDIF
2481: 
2482:         *-- Legado (fwGrade.AfterRowColChange): llvImp = btnVerImps.Value
2483:         *-- habilita/desabilita a pagina Fiscal e troca a aba ativa.
2484:         IF THIS.cnt_4c_Botoes.chk_4c_BtnVerImps.Value = 1
2485:             THIS.pgf_4c_Paginas.Page3.Enabled = .T.
2486:             THIS.AlternarPagina(3)
2487:         ELSE
2488:             THIS.pgf_4c_Paginas.Page3.Enabled = .F.
2489:             THIS.AlternarPagina(1)
2490:         ENDIF
2491:     ENDPROC
2492: 
2493:     *-- "Recalcular Impostos": navega para a pagina Fiscal da linha corrente
2494:     PROCEDURE BtnRecImpsClick()
2495:         IF !THIS.TemProdutoSelecionado()
2496:             MsgAviso("Selecione um Produto Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o")
2497:             RETURN
2498:         ENDIF
2499:         THIS.AlternarPagina(3)
2500:     ENDPROC
2501: 
2502:     *-- "Devolucao": Do Form sigoppei (equivalente SigOpExi do legado)
2503:     PROCEDURE BtndevoluClick()
2504:         LOCAL loc_oForm, loc_oErro
2505:         IF !USED("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
2506:             RETURN
2507:         ENDIF
2508:         loc_oForm = .NULL.
2509:         TRY
2510:             loc_oForm = CREATEOBJECT("FormSigOpExi", THIS, THIS.DataSessionId)
2511:         CATCH TO loc_oErro
2512:             MostrarErro("Erro ao abrir Devolu" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
2513:             loc_oForm = .NULL.
2514:         ENDTRY
2515:         IF VARTYPE(loc_oForm) = "O"
2516:             loc_oForm.Show()
2517:             THIS.grd_4c_Dados.SetFocus()
2518:         ENDIF
2519:     ENDPROC
2520: 
2521:     *-- "Itens Subnivel": Do Form sigoppei With ThisForm, DataSessionId
2522:     PROCEDURE BtnIteSubClick()
2523:         LOCAL loc_oForm, loc_oErro
2524:         loc_oForm = .NULL.
2525:         TRY
2526:             loc_oForm = CREATEOBJECT("FormSigOpPei", THIS, THIS.DataSessionId)
2527:         CATCH TO loc_oErro
2528:             MostrarErro("Erro ao abrir Itens Subn" + CHR(237) + "vel:" + CHR(13) + loc_oErro.Message, "Erro")
2529:             loc_oForm = .NULL.
2530:         ENDTRY
2531:         IF VARTYPE(loc_oForm) = "O"
2532:             loc_oForm.Show()
2533:             THIS.grd_4c_Dados.Refresh()
2534:         ENDIF
2535:     ENDPROC
2536: 
2537:     *-- "Importar XML": zera a grade de itens e aciona a importacao
2538:     PROCEDURE CmdXmlClick()
2539:         IF !MsgConfirma("Importar XML ir" + CHR(225) + " substituir todos os itens da grade atual. Continuar?", "Confirmar")
2540:             RETURN
2541:         ENDIF
2542:         THIS.ZaparCursorItens()
2543:         THIS.RepintarGradeItens()
2544:         THIS.AjustarBotoesPorModo()
2545:     ENDPROC
2546: 
2547:     *-- "Carrega Cadastro": zera a grade de itens antes de carregar um lote
2548:     PROCEDURE BtncarregarClick()
2549:         LOCAL loc_cArquivo
2550:         loc_cArquivo = GETFILE("TXT")
2551:         IF EMPTY(loc_cArquivo)
2552:             RETURN
2553:         ENDIF
2554:         THIS.ZaparCursorItens()
2555:         THIS.RepintarGradeItens()
2556:         THIS.AjustarBotoesPorModo()
2557:     ENDPROC
2558: 
2559:     *-- "Retorna Bonus": Do Form ParentForm.OpenCash(Contads,.T.,.F.)
2560:     PROCEDURE BtnRetCashClick()
2561:         LOCAL loc_oErro
2562:         TRY
2563:             IF VARTYPE(THIS.this_oParentForm) = "O" AND PEMSTATUS(THIS.this_oParentForm, "OpenCash", 5)
2564:                 THIS.this_oParentForm.OpenCash("", .T., .F.)
2565:             ENDIF
2566:         CATCH TO loc_oErro
2567:             MostrarErro("Erro ao retornar b" + CHR(244) + "nus:" + CHR(13) + loc_oErro.Message, "Erro")
2568:         ENDTRY
2569:         THIS.grd_4c_Dados.Refresh()
2570:     ENDPROC
2571: 
2572:     *==========================================================================
2573:     * Handlers dos botoes de cnt_4c_BotoesAcao (toolbar inferior, Top=359)
2574:     *==========================================================================
2575: 
2576:     *-- "Cadastro de Produtos": Do Form SigOpCgp (cadastro rapido na operacao)
2577:     PROCEDURE BtnCadProClick()
2578:         LOCAL loc_oForm, loc_oErro
2579:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") OR !THIS.TemProdutoSelecionado()
2580:             RETURN
2581:         ENDIF
2582:         loc_oForm = .NULL.
2583:         TRY
2584:             loc_oForm = CREATEOBJECT("FormSigOpCgp", THIS)
2585:         CATCH TO loc_oErro
2586:             MostrarErro("Erro ao abrir Cadastro de Produtos:" + CHR(13) + loc_oErro.Message, "Erro")
2587:             loc_oForm = .NULL.
2588:         ENDTRY
2589:         IF VARTYPE(loc_oForm) = "O"
2590:             loc_oForm.Show()
2591:             THIS.grd_4c_Dados.Refresh()
2592:         ENDIF
2593:     ENDPROC
2594: 
2595:     *-- "Exclusao de Produtos": remove a linha corrente da grade.
2596:     *-- Legado (btnPApaga.Click): guard de EOF -> DeletarItem() -> garante uma
2597:     *-- linha na grade -> renumera os itens (e as referencias de composicao)
2598:     *-- -> CItem = Cont -> Go Top -> fwGrade.Refresh + Produto.SetFocus.
2599:     *-- O legado NAO pede confirmacao: a exclusao eh de LINHA do cursor da
2600:     *-- grade, e a gravacao em SigMvItn so acontece quando o form pai confirma
2601:     *-- a movimentacao.
2602:     PROCEDURE BtnPApagaClick()
2603:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
2604:             MsgAviso("Posicione no Produto que Deseja Excluir ... ", "Nada a Fazer")
2605:             RETURN
2606:         ENDIF
2607: 
2608:         IF !THIS.ExcluirLinhaGrade()
2609:             RETURN
2610:         ENDIF
2611: 
2612:         THIS.GarantirLinhaDeDigitacao()
2613:         THIS.RenumerarItensGrade()
2614: 
2615:         SELECT cursor_4c_Itens
2616:         GO TOP
2617: 
2618:         THIS.RepintarGradeItens()
2619:         THIS.AjustarBotoesPorModo()
2620: 
2621:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Visible
2622:             THIS.grd_4c_Dados.SetFocus()
2623:         ENDIF
2624:     ENDPROC
2625: 
2626:     *-- "Carregar Composicao": Do Form SigSubCp (composicao do produto)
2627:     PROCEDURE BtnComposClick()
2628:         LOCAL loc_oForm, loc_oErro
2629:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") OR !THIS.TemProdutoSelecionado()
2630:             RETURN
2631:         ENDIF
2632:         loc_oForm = .NULL.
2633:         TRY
2634:             loc_oForm = CREATEOBJECT("FormSigSubCp", THIS, ALLTRIM(cursor_4c_Itens.cpros), ;
2635:                                       cursor_4c_Itens.citens, THIS.DataSessionId)
2636:         CATCH TO loc_oErro
2637:             MostrarErro("Erro ao abrir Composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
2638:             loc_oForm = .NULL.
2639:         ENDTRY
2640:         IF VARTYPE(loc_oForm) = "O"
2641:             loc_oForm.Show()
2642:             THIS.grd_4c_Dados.Refresh()
2643:         ENDIF
2644:     ENDPROC
2645: 
2646:     *-- "Alteracao de Precos": libera o foco na coluna Valor da grade
2647:     PROCEDURE BtnAltPrecosClick()
2648:         IF !THIS.TemProdutoSelecionado()
2649:             MsgAviso("Selecione um Produto para Ter o Pre" + CHR(231) + "o Alterado.", "Aten" + CHR(231) + CHR(227) + "o")
2650:             RETURN
2651:         ENDIF
2652:         THIS.grd_4c_Dados.SetFocus()
2653:         THIS.grd_4c_Dados.ActiveColumn = 6
2654:     ENDPROC
2655: 
2656:     *-- "Procura de Produtos": abre o lookup de produto quando a linha
2657:     *-- corrente ainda nao tem codigo preenchido (igual ao legado)
2658:     PROCEDURE BtnPBuscasClick()
2659:         LOCAL loc_oBusca
2660: 
2661:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens") AND !EMPTY(cursor_4c_Itens.cpros)
2662:             MsgAviso("O c" + CHR(243) + "digo do Produto tem que estar vazio para acionar procura!!!", "Aten" + CHR(231) + CHR(227) + "o")
2663:             RETURN
2664:         ENDIF
2665: 
2666:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2667:                                    "cursor_4c_BuscaPro", "Cpros", "", "Produtos", .F., .T., "")
2668: 
2669:         IF VARTYPE(loc_oBusca) = "O"
2670:             IF !loc_oBusca.this_lAchouRegistro
2671:                 loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
2672:                 loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
2673:                 loc_oBusca.Show()
2674:             ENDIF
2675: 
2676:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro") AND USED("cursor_4c_Itens") ;
2677:                AND !EOF("cursor_4c_Itens")
2678:                 SELECT cursor_4c_BuscaPro
2679:                 SELECT cursor_4c_Itens
2680:                 REPLACE cpros WITH ALLTRIM(cursor_4c_BuscaPro.Cpros), ;
2681:                         dpros WITH ALLTRIM(cursor_4c_BuscaPro.Dpros)
2682:                 THIS.grd_4c_Dados.Refresh()
2683:             ENDIF
2684: 
2685:             loc_oBusca.Release()
2686:         ENDIF
2687: 
2688:         IF USED("cursor_4c_BuscaPro")
2689:             USE IN cursor_4c_BuscaPro
2690:         ENDIF
2691:     ENDPROC
2692: 
2693:     *-- "Informar Pedido": Do Form SigOpPed With ThisForm, DataSessionId
2694:     PROCEDURE BtnPedidoClick()
2695:         LOCAL loc_oForm, loc_oErro
2696:         IF !THIS.TemProdutoSelecionado()
2697:             MsgAviso("" + CHR(201) + " necess" + CHR(225) + "rio Posicionar no Produto para Localizar!!!", "Aviso")
2698:             RETURN
2699:         ENDIF
2700:         loc_oForm = .NULL.
2701:         TRY
2702:             loc_oForm = CREATEOBJECT("FormSigOpPed", THIS, THIS.DataSessionId)
2703:         CATCH TO loc_oErro
2704:             MostrarErro("Erro ao abrir Informar Pedido:" + CHR(13) + loc_oErro.Message, "Erro")
2705:             loc_oForm = .NULL.
2706:         ENDTRY
2707:         IF VARTYPE(loc_oForm) = "O"
2708:             loc_oForm.Show()
2709:             THIS.grd_4c_Dados.Refresh()
2710:         ENDIF
2711:     ENDPROC
2712: 
2713:     *-- "Substituir Composicao": Do Form SigSubCp With ThisForm, Cpros,
2714:     *-- Citens, DataSessionId, CodTams (igual ao legado)
2715:     PROCEDURE BtnsubcpClick()
2716:         LOCAL loc_oForm, loc_oErro
2717:         IF !THIS.TemProdutoSelecionado()
2718:             MsgAviso("Selecione Um Produto Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o")
2719:             RETURN
2720:         ENDIF
2721:         loc_oForm = .NULL.
2722:         TRY
2723:             loc_oForm = CREATEOBJECT("FormSigSubCp", THIS, ALLTRIM(cursor_4c_Itens.cpros), ;
2724:                                       cursor_4c_Itens.citens, THIS.DataSessionId, ;
2725:                                       cursor_4c_Itens.codtams)
2726:         CATCH TO loc_oErro
2727:             MostrarErro("Erro ao abrir Substituir Composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
2728:             loc_oForm = .NULL.
2729:         ENDTRY
2730:         IF VARTYPE(loc_oForm) = "O"
2731:             loc_oForm.Show()
2732:             THIS.grd_4c_Dados.Refresh()
2733:         ENDIF
2734:     ENDPROC
2735: 
2736:     *-- "Detalhes": Do Form SigOpDet With ParentForm.PoDataMgr, Op_Escolha,
2737:     *-- TprMvCab.Dopes, Cpros, TprMvCab.EmpDopNums
2738:     PROCEDURE BtnDetClick()
2739:         LOCAL loc_oForm, loc_oErro
2740:         IF !THIS.TemProdutoSelecionado()
2741:             MsgAviso("Selecione Um Produto Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o")
2742:             RETURN
2743:         ENDIF
2744:         loc_oForm = .NULL.
2745:         TRY
2746:             loc_oForm = CREATEOBJECT("FormSigOpDet", THIS.this_oParentForm, THIS.this_cOpEscolha, ;
2747:                                       "", ALLTRIM(cursor_4c_Itens.cpros), "")
2748:         CATCH TO loc_oErro
2749:             MostrarErro("Erro ao abrir Detalhes:" + CHR(13) + loc_oErro.Message, "Erro")
2750:             loc_oForm = .NULL.
2751:         ENDTRY
2752:         IF VARTYPE(loc_oForm) = "O"
2753:             loc_oForm.Show()
2754:         ENDIF
2755:     ENDPROC
2756: 
2757:     *-- "Finalidade": Do Form SigOpIns (finalidade da operacao no item)
2758:     PROCEDURE BtnOptFinClick()
2759:         LOCAL loc_oForm, loc_oErro
2760:         IF !THIS.TemProdutoSelecionado()
2761:             MsgAviso("Selecione Um Produto Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o")
2762:             RETURN
2763:         ENDIF
2764:         loc_oForm = .NULL.
2765:         TRY
2766:             loc_oForm = CREATEOBJECT("FormSigOpIns", THIS.this_oParentForm, "", "ITN", "", "")
2767:         CATCH TO loc_oErro
2768:             MostrarErro("Erro ao abrir Finalidade:" + CHR(13) + loc_oErro.Message, "Erro")
2769:             loc_oForm = .NULL.
2770:         ENDTRY
2771:         IF VARTYPE(loc_oForm) = "O"
2772:             loc_oForm.Show()
2773:         ENDIF
2774:     ENDPROC
2775: 
2776:     *-- "Descontos": Do Form SigOpDes (descontos por cota)
2777:     PROCEDURE BtnDescClick()
2778:         LOCAL loc_oForm, loc_oErro
2779:         IF !THIS.TemProdutoSelecionado()
2780:             MsgAviso("" + CHR(201) + " necess" + CHR(225) + "rio posicionar em um produto para fazer os descontos!!!", "Aviso")
2781:             RETURN
2782:         ENDIF
2783:         loc_oForm = .NULL.
2784:         TRY
2785:             loc_oForm = CREATEOBJECT("FormSigOpDes", THIS.this_oParentForm)
2786:         CATCH TO loc_oErro
2787:             MostrarErro("Erro ao abrir Descontos:" + CHR(13) + loc_oErro.Message, "Erro")
2788:             loc_oForm = .NULL.
2789:         ENDTRY
2790:         IF VARTYPE(loc_oForm) = "O"
2791:             loc_oForm.Show()
2792:             THIS.grd_4c_Dados.Refresh()
2793:         ENDIF
2794:     ENDPROC
2795: 
2796:     *-- "Local. Destino": Do Form SigOpLcl/SigOpLcZ With ..., 'DESTINO'
2797:     PROCEDURE BtnLocDesClick()
2798:         LOCAL loc_oForm, loc_oErro
2799:         IF !THIS.TemProdutoSelecionado()
2800:             MsgAviso("" + CHR(201) + " Necess" + CHR(225) + "rio Posicionar no Produto para Localizar!!!", "Aviso")
2801:             RETURN
2802:         ENDIF
2803:         loc_oForm = .NULL.
2804:         TRY
2805:             loc_oForm = CREATEOBJECT("FormSigOpLcl", THIS.this_oParentForm, THIS.this_cOpEscolha, "DESTINO")
2806:         CATCH TO loc_oErro
2807:             MostrarErro("Erro ao abrir Localiza" + CHR(231) + CHR(227) + "o de Destino:" + CHR(13) + loc_oErro.Message, "Erro")
2808:             loc_oForm = .NULL.
2809:         ENDTRY
2810:         IF VARTYPE(loc_oForm) = "O"
2811:             loc_oForm.Show()
2812:         ENDIF
2813:     ENDPROC
2814: 
2815:     *-- "Local. Origem": Do Form SigOpLcl/SigOpLcZ With ..., 'ORIGEM'
2816:     PROCEDURE BtnLocOriClick()
2817:         LOCAL loc_oForm, loc_oErro
2818:         IF !THIS.TemProdutoSelecionado()
2819:             MsgAviso("" + CHR(201) + " Necess" + CHR(225) + "rio Posicionar no Produto para Localizar!!!", "Aviso")
2820:             RETURN
2821:         ENDIF
2822:         loc_oForm = .NULL.
2823:         TRY
2824:             loc_oForm = CREATEOBJECT("FormSigOpLcl", THIS.this_oParentForm, THIS.this_cOpEscolha, "ORIGEM")
2825:         CATCH TO loc_oErro
2826:             MostrarErro("Erro ao abrir Localiza" + CHR(231) + CHR(227) + "o de Origem:" + CHR(13) + loc_oErro.Message, "Erro")
2827:             loc_oForm = .NULL.
2828:         ENDTRY
2829:         IF VARTYPE(loc_oForm) = "O"
2830:             loc_oForm.Show()
2831:         ENDIF
2832:     ENDPROC
2833: 
2834:     *==========================================================================
2835:     * ConfigurarPaginaProduto - Page1 (pgProds no legado) "Dados do Produto".
2836:     *
2837:     * Painel do item CORRENTE da grade. No legado quase todo campo daqui tem
2838:     * When() = Return .F. (espelho somente-leitura da linha) e os poucos
2839:     * digitaveis sao: getDPros (descricao, so quando AltDescs = 1), getDocs
2840:     * (documento), getLotes (numero do lote), getVDescs / getPDescs
2841:     * (descontos), getObs (observacao do item), getCodCors / getCodTams (cor e
2842:     * tamanho, com browse), get_prod / get_qtd (conferencia por codigo de
2843:     * barras) e getBusca (procura na grade).
2844:     *
2845:     * Os campos que SAO coluna de SigMvItn usam ControlSource sobre
2846:     * cursor_4c_Itens - exatamente o que o legado faz sobre crTpmMvItn - e por
2847:     * isso acompanham a linha corrente da grade sozinhos. Os de EXIBICAO
2848:     * (preco atual, grupo de venda, referencia, saldo, resta, peso medio) nao
2849:     * sao coluna do item: no legado o AfterRowColChange da grade os preenche a
2850:     * cada troca de linha, e aqui AtualizarPainelProduto() faz o mesmo.
2851:     *
2852:     * cnt_4c_Obs nasce Visible = .F. (painel flutuante da observacao, aberto
2853:     * pelo Click de obj_4c_GetObs) e por isso entra na lista de excecao de
2854:     * TornarControlesVisiveis / ReaplicarVisibilidadeInicial.
2855:     *==========================================================================
2856:     PROTECTED PROCEDURE ConfigurarPaginaProduto()
2857:         LOCAL loc_oPag
2858:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2859: 
2860:         *-- cnt_4c_Obs (cntObs no legado) - painel flutuante da observacao ---
2861:         loc_oPag.AddObject("cnt_4c_Obs", "Container")
2862:         WITH loc_oPag.cnt_4c_Obs
2863:             .Top         = 1
2864:             .Left        = 194
2865:             .Width       = 792
2866:             .Height      = 171
2867:             .BackStyle   = 1
2868:             .BackColor   = RGB(255, 255, 255)
2869:             .BorderWidth = 0
2870:             .Visible     = .F.
2871:         ENDWITH
2872: 
2873:         loc_oPag.cnt_4c_Obs.AddObject("obj_4c_GetObs", "EditBox")
2874:         WITH loc_oPag.cnt_4c_Obs.obj_4c_GetObs
2875:             .Top           = 4
2876:             .Left          = 2
2877:             .Width         = 788
2878:             .Height        = 163
2879:             .FontName      = "Tahoma"
2880:             .FontSize      = 8
2881:             .SpecialEffect = 1
2882:             .ControlSource = "cursor_4c_Itens.obs"
2883:             .ToolTipText   = "Observa" + CHR(231) + CHR(227) + "o do Produto"
2884:             .Visible       = .T.
2885:         ENDWITH
2886: 
2887:         *-- shp_4c_Shape4 - moldura da area da imagem do produto -------------
2888:         loc_oPag.AddObject("shp_4c_Shape4", "Shape")
2889:         WITH loc_oPag.shp_4c_Shape4
2890:             .Top           = 2
2891:             .Left          = 2
2892:             .Width         = 192
2893:             .Height        = 167
2894:             .BackStyle     = 0
2895:             .BorderWidth   = 2
2896:             .SpecialEffect = 0

*-- Linhas 3692 a 3735:
3692:             .Visible   = .T.
3693:         ENDWITH
3694: 
3695:         loc_oPag.AddObject("obj_4c_Opt_Busca", "OptionGroup")
3696:         WITH loc_oPag.obj_4c_Opt_Busca
3697:             .Top         = 135
3698:             .Left        = 713
3699:             .Width       = 119
3700:             .Height      = 25
3701:             .ButtonCount = 2
3702:             .BackStyle   = 0
3703:             .BorderStyle = 0
3704:             .AutoSize    = .F.
3705:             .Value       = 1
3706:             .Visible     = .T.
3707:             WITH .Buttons(1)
3708:                 .Caption   = "Barras"
3709:                 .Top       = 5
3710:                 .Left      = 5
3711:                 .Width     = 49
3712:                 .Height    = 15
3713:                 .FontName  = "Tahoma"
3714:                 .FontSize  = 8
3715:                 .AutoSize  = .F.
3716:                 .BackStyle = 0
3717:                 .ForeColor = RGB(90, 90, 90)
3718:             ENDWITH
3719:             WITH .Buttons(2)
3720:                 .Caption   = "Produto"
3721:                 .Top       = 5
3722:                 .Left      = 58
3723:                 .Width     = 56
3724:                 .Height    = 15
3725:                 .FontName  = "Tahoma"
3726:                 .FontSize  = 8
3727:                 .AutoSize  = .F.
3728:                 .BackStyle = 0
3729:                 .ForeColor = RGB(90, 90, 90)
3730:             ENDWITH
3731:         ENDWITH
3732: 
3733:         loc_oPag.AddObject("txt_4c_Busca", "TextBox")
3734:         WITH loc_oPag.txt_4c_Busca
3735:             .Top               = 136

*-- Linhas 3831 a 3908:
3831: 
3832:         *-- Eventos: o Valid do legado vira LostFocus aqui (regra #47); nada
3833:         *-- fica em KeyPress sem teste explicito de tecla.
3834:         BINDEVENT(loc_oPag.txt_4c__prod,   "LostFocus", THIS, "TxtProdLostFocus")
3835:         BINDEVENT(loc_oPag.txt_4c__qtd,    "LostFocus", THIS, "TxtQtdLostFocus")
3836:         BINDEVENT(loc_oPag.txt_4c_Busca,   "LostFocus", THIS, "BtnBuscarClick")
3837:         BINDEVENT(loc_oPag.txt_4c_CodCors, "LostFocus", THIS, "ValidarCodCorLostFocus")
3838:         BINDEVENT(loc_oPag.txt_4c_CodTams, "LostFocus", THIS, "ValidarCodTamLostFocus")
3839:         BINDEVENT(loc_oPag.txt_4c_Docs,    "LostFocus", THIS, "ValidarDocsLostFocus")
3840:         BINDEVENT(loc_oPag.txt_4c_Lotes,   "LostFocus", THIS, "ValidarLotesLostFocus")
3841:         BINDEVENT(loc_oPag.txt_4c_VDescs,  "LostFocus", THIS, "ValidarVDescsLostFocus")
3842:         BINDEVENT(loc_oPag.txt_4c_PDescs,  "LostFocus", THIS, "ValidarPDescsLostFocus")
3843:         BINDEVENT(loc_oPag.obj_4c_GetObs,  "Click",     THIS, "ObsAbrirPainelClick")
3844:         BINDEVENT(loc_oPag.cnt_4c_Obs.obj_4c_GetObs, "LostFocus", THIS, "ObsFecharPainelLostFocus")
3845:         BINDEVENT(loc_oPag.img_4c_ImgProds, "DblClick", THIS, "ImgProdsDblClick")
3846:     ENDPROC
3847: 
3848:     *==========================================================================
3849:     * ConfigurarPaginaFiscal - Page3 (pgFiscs no legado) "Dados Fiscais".
3850:     *
3851:     * Painel fiscal do item corrente, todo dentro de cnt_4c_Item (CntItem no
3852:     * legado). No legado TODOS os campos daqui tem When() = Return .F. -
3853:     * exibicao pura - EXCETO getNAdis, getNIAdis e getcodfabs, cujo When eh
3854:     * "Return (InList(ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR'))": sao os
3855:     * tres dados de importacao que o usuario informa (numero da adicao, item
3856:     * da adicao e codigo do fabricante estrangeiro).
3857:     *
3858:     * A pagina so eh habilitada pelo legado quando o usuario pede alteracao de
3859:     * impostos (btnAltImps.Click faz "pgfPagina.pgFiscs.Enabled = .t."), e eh
3860:     * isso que HabilitarCampos reproduz.
3861:     *
3862:     * Os campos sao coluna de SigMvItn e por isso usam ControlSource sobre
3863:     * cursor_4c_Itens, acompanhando a linha corrente da grade. Os dois que NAO
3864:     * sao coluna do item (classificacao fiscal e a descricao dela, que vem de
3865:     * SigCdPro/SigCdClf) ficam em .Value e sao preenchidos por
3866:     * AtualizarPainelProduto(), como o AfterRowColChange do legado faz.
3867:     *==========================================================================
3868:     PROTECTED PROCEDURE ConfigurarPaginaFiscal()
3869:         LOCAL loc_oPag, loc_oCnt
3870:         loc_oPag = THIS.pgf_4c_Paginas.Page3
3871: 
3872:         loc_oPag.AddObject("cnt_4c_Item", "Container")
3873:         WITH loc_oPag.cnt_4c_Item
3874:             .Top           = -6
3875:             .Left          = 2
3876:             .Width         = 973
3877:             .Height        = 151
3878:             .BackStyle     = 0
3879:             .BorderWidth   = 0
3880:             .SpecialEffect = 2
3881:             .BackColor     = RGB(188, 201, 254)
3882:             .BorderColor   = RGB(36, 84, 155)
3883:             .Visible       = .T.
3884:         ENDWITH
3885: 
3886:         loc_oCnt = loc_oPag.cnt_4c_Item
3887: 
3888:         *-- Moldura do bloco de Importacao -----------------------------------
3889:         loc_oCnt.AddObject("shp_4c_Shape1", "Shape")
3890:         WITH loc_oCnt.shp_4c_Shape1
3891:             .Top         = 63
3892:             .Left        = 802
3893:             .Width       = 163
3894:             .Height      = 84
3895:             .BackStyle   = 0
3896:             .BorderStyle = 1
3897:             .BorderColor = RGB(90, 90, 90)
3898:             .Visible     = .T.
3899:         ENDWITH
3900: 
3901:         *-- Linha 1: produto, descricao, classificacao fiscal e Obs2 ---------
3902:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFCPros", 7, 9, 45, "Produto")
3903: 
3904:         loc_oCnt.AddObject("txt_4c_FCPros", "TextBox")
3905:         WITH loc_oCnt.txt_4c_FCPros
3906:             .Top           = 21
3907:             .Left          = 9
3908:             .Width         = 108

*-- Linhas 4191 a 4319:
4191:     * legado eh AutoSize, mas AutoSize eh no-op em Label criado por AddObject
4192:     * (regra #23) - a largura tem de vir escrita.
4193:     *==========================================================================
4194:     PROTECTED PROCEDURE AdicionarLabelFiscal(par_oPai, par_cNome, par_nTop, ;
4195:                                              par_nLeft, par_nWidth, par_cCaption)
4196:         par_oPai.AddObject(par_cNome, "Label")
4197: 
4198:         WITH EVALUATE("par_oPai." + par_cNome)
4199:             .Top       = par_nTop
4200:             .Left      = par_nLeft
4201:             .Width     = par_nWidth
4202:             .Height    = 15
4203:             .Caption   = par_cCaption
4204:             .FontName  = "Tahoma"
4205:             .FontSize  = 8
4206:             .FontBold  = .F.
4207:             .AutoSize  = .F.
4208:             .Alignment = 0
4209:             .BackStyle = 0
4210:             .ForeColor = RGB(90, 90, 90)
4211:             .Visible   = .T.
4212:         ENDWITH
4213:     ENDPROC
4214: 
4215:     *==========================================================================
4216:     * AdicionarTextBoxFiscal - Fabrica dos campos numericos de cnt_4c_Item.
4217:     * No dump todos tem a mesma assinatura (Tahoma 8, Alignment = 3, Height
4218:     * = 21, SpecialEffect = 1, BackColor = 251,254,226, BorderColor =
4219:     * 90,90,90) e When() = Return .F., isto eh: exibicao pura - o que aqui
4220:     * vira ReadOnly = .T. (o When do legado nao tem equivalente direto em
4221:     * TextBox criado por AddObject, e ReadOnly reproduz o efeito de nao
4222:     * aceitar digitacao sem esconder o valor).
4223:     *==========================================================================
4224:     PROTECTED PROCEDURE AdicionarTextBoxFiscal(par_oPai, par_cNome, par_nTop, ;
4225:                                                par_nLeft, par_nWidth, ;
4226:                                                par_cMascara, par_cFonte)
4227:         par_oPai.AddObject(par_cNome, "TextBox")
4228: 
4229:         WITH EVALUATE("par_oPai." + par_cNome)
4230:             .Top           = par_nTop
4231:             .Left          = par_nLeft
4232:             .Width         = par_nWidth
4233:             .Height        = 21
4234:             .FontName      = "Tahoma"
4235:             .FontSize      = 8
4236:             .Alignment     = 3
4237:             .InputMask     = par_cMascara
4238:             .ReadOnly      = .T.
4239:             .SpecialEffect = 1
4240:             .ControlSource = par_cFonte
4241:             .BackColor     = RGB(251, 254, 226)
4242:             .BorderColor   = RGB(90, 90, 90)
4243:             .Visible       = .T.
4244:         ENDWITH
4245:     ENDPROC
4246: 
4247:     *==========================================================================
4248:     * CriarCursorPrecos - Cursor da grade de Precificacao (Page4). No legado a
4249:     * grdPrecos esta ligada a "lpitem", cursor da lista de precificacao que
4250:     * vive no data session do form PAI de Movimentacao; aqui ele eh local e eh
4251:     * populado por CarregarPrecos() a partir de SigOpLpi/SigOpLpr.
4252:     *
4253:     * Criado ANTES de ConfigurarPaginaPrecos porque Column.ControlSource de
4254:     * alias inexistente derruba o Init (regra #41).
4255:     *==========================================================================
4256:     PROTECTED PROCEDURE CriarCursorPrecos()
4257:         IF USED("cursor_4c_Precos")
4258:             USE IN cursor_4c_Precos
4259:         ENDIF
4260: 
4261:         SET NULL ON
4262:         CREATE CURSOR cursor_4c_Precos ( ;
4263:             lprecos C(30), tabds C(20), units N(11,2), moedas C(3))
4264:         SET NULL OFF
4265:     ENDPROC
4266: 
4267:     *==========================================================================
4268:     * ConfigurarPaginaPrecos - Page4 (pgPrecos no legado) "Precificacao".
4269:     *
4270:     * Grade grdPrecos: lista as precificacoes disponiveis para o produto do
4271:     * item corrente. Nasce Visible = .F. e ReadOnly = .T. no SCX legado (o
4272:     * proprio legado so a mostra quando a operacao trabalha com lista de
4273:     * precos), e por isso entra na lista de excecao de
4274:     * TornarControlesVisiveis / ReaplicarVisibilidadeInicial.
4275:     *
4276:     * Ordem de configuracao obrigatoria (regra #41 / Problema 48):
4277:     * ColumnCount -> RecordSource -> ControlSource -> Width -> Header.Caption.
4278:     *==========================================================================
4279:     PROTECTED PROCEDURE ConfigurarPaginaPrecos()
4280:         LOCAL loc_oPag, loc_oGrd
4281:         loc_oPag = THIS.pgf_4c_Paginas.Page4
4282: 
4283:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
4284:         loc_oGrd = loc_oPag.grd_4c_Dados
4285: 
4286:         WITH loc_oGrd
4287:             .Top                = 9
4288:             .Left               = 7
4289:             .Width              = 416
4290:             .Height             = 131
4291:             .ColumnCount        = 4
4292:             .DeleteMark         = .F.
4293:             .RecordMark         = .F.
4294:             .ScrollBars         = 2
4295:             .ReadOnly           = .T.
4296:             .AllowHeaderSizing  = .F.
4297:             .GridLineColor      = RGB(238, 238, 238)
4298:             .RecordSource       = "cursor_4c_Precos"
4299:             .Visible            = .F.
4300:         ENDWITH
4301: 
4302:         WITH loc_oGrd.Column1
4303:             .ControlSource   = "cursor_4c_Precos.lprecos"
4304:             .Width           = 210
4305:             .Movable         = .F.
4306:             .Resizable       = .F.
4307:             .ReadOnly        = .T.
4308:             .FontName        = "Courier New"
4309:             .Header1.Caption = "Lista de Precifica" + CHR(231) + CHR(227) + "o"
4310:             .Visible         = .T.
4311:         ENDWITH
4312: 
4313:         WITH loc_oGrd.Column2
4314:             .ControlSource   = "cursor_4c_Precos.tabds"
4315:             .Width           = 80
4316:             .Movable         = .F.
4317:             .Resizable       = .F.
4318:             .ReadOnly        = .T.
4319:             .FontName        = "Courier New"

*-- Linhas 4370 a 4531:
4370:     *
4371:     * PUBLIC: eh o form pai quem chama.
4372:     *==========================================================================
4373:     PROCEDURE CarregarPrecos(par_cCursorOrigem)
4374:         LOCAL loc_lSucesso, loc_oErro
4375: 
4376:         loc_lSucesso = .F.
4377: 
4378:         IF VARTYPE(par_cCursorOrigem) <> "C" OR EMPTY(par_cCursorOrigem)
4379:             RETURN .F.
4380:         ENDIF
4381: 
4382:         IF !USED(ALLTRIM(par_cCursorOrigem))
4383:             RETURN .F.
4384:         ENDIF
4385: 
4386:         IF !USED("cursor_4c_Precos")
4387:             THIS.CriarCursorPrecos()
4388:         ENDIF
4389: 
4390:         TRY
4391:             *-- ZAP (nao fechar/recriar): fechar o alias derrubaria o
4392:             *-- RecordSource da grade e ela viraria um retangulo branco.
4393:             SELECT cursor_4c_Precos
4394:             THIS.ZaparCursor("cursor_4c_Precos")
4395: 
4396:             *-- APPEND FROM DBF casa os campos por NOME: o alias do pai tem de
4397:             *-- trazer lprecos/tabds/units/moedas.
4398:             SELECT cursor_4c_Precos
4399:             APPEND FROM DBF(ALLTRIM(par_cCursorOrigem))
4400: 
4401:             GO TOP IN cursor_4c_Precos
4402: 
4403:             WITH THIS.pgf_4c_Paginas.Page4.grd_4c_Dados
4404:                 .Visible = (RECCOUNT("cursor_4c_Precos") > 0)
4405:                 .Refresh()
4406:             ENDWITH
4407: 
4408:             loc_lSucesso = .T.
4409: 
4410:         CATCH TO loc_oErro
4411:             THIS.this_cMensagemErro = loc_oErro.Message
4412:             MsgErro("Erro ao carregar a lista de precifica" + CHR(231) + CHR(227) + ;
4413:                     "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
4414:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4415:                     "Proc: " + loc_oErro.Procedure, "Erro CarregarPrecos")
4416:         ENDTRY
4417: 
4418:         RETURN loc_lSucesso
4419:     ENDPROC
4420: 
4421:     *==========================================================================
4422:     * ZaparCursor - ZAP guardado por SAFETY para qualquer alias. Irmao de
4423:     * ZaparCursorItens: SET SAFETY eh escopado por DATA SESSION e este form eh
4424:     * DataSession = 2, onde SAFETY volta a ON mesmo com o SET SAFETY OFF do
4425:     * main.prg - e com SAFETY ON o ZAP abre o dialogo "Zap ... Are you sure?"
4426:     * e CONGELA a tela esperando um clique que ninguem ve.
4427:     *==========================================================================
4428:     PROTECTED PROCEDURE ZaparCursor(par_cAlias)
4429:         LOCAL loc_cSafety
4430: 
4431:         IF VARTYPE(par_cAlias) <> "C" OR !USED(ALLTRIM(par_cAlias))
4432:             RETURN .F.
4433:         ENDIF
4434: 
4435:         loc_cSafety = SET("SAFETY")
4436:         SET SAFETY OFF
4437: 
4438:         SELECT (ALLTRIM(par_cAlias))
4439:         ZAP
4440: 
4441:         IF loc_cSafety = "ON"
4442:             SET SAFETY ON
4443:         ENDIF
4444: 
4445:         RETURN .T.
4446:     ENDPROC
4447: 
4448:     *==========================================================================
4449:     * GradeAfterRowColChange - Handler de AfterRowColChange de grd_4c_Dados.
4450:     *
4451:     * Declara par_nColIndex porque o evento passa esse argumento e handler sem
4452:     * o parametro estoura a cada troca de celula (regra #3). O uso aqui eh o
4453:     * MESMO do legado: carregar o detalhe da LINHA corrente, sem filtrar por
4454:     * coluna - validacao de celula NAO entra aqui (regra #46), ela mora no
4455:     * Valid do TextBox da coluna.
4456:     *
4457:     * PUBLIC: eh alvo de BINDEVENT e tambem do harness de teste.
4458:     *==========================================================================
4459:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
4460:         THIS.AtualizarPainelProduto()
4461:         THIS.AjustarBotoesPorModo()
4462:     ENDPROC
4463: 
4464:     *==========================================================================
4465:     * AtualizarPainelProduto - Preenche os campos de EXIBICAO de Page1 e Page3
4466:     * a partir do produto da linha corrente da grade.
4467:     *
4468:     * Transcreve o bloco de preenchimento do fwGrade.AfterRowColChange do
4469:     * legado: consulta SigCdPro (com LEFT JOIN em SigCdCol para a descricao da
4470:     * colecao), SigPrFnc (referencia do fornecedor por conta), SigMvEst (saldo
4471:     * do produto no grupo de estoque), SigCdCli (nome do fornecedor) e
4472:     * SigCdClf (descricao da classificacao fiscal), e devolve:
4473:     *
4474:     *   getPVens/getMoeVs       <- crTmpPro.PVens / .MoeVs
4475:     *   cntReffs.getReffs       <- SigPrFnc.Reffs, com fallback SigCdPro.Reffs
4476:     *   getGVendas              <- Colecoes + " - " + Descs da colecao
4477:     *   getObsPes/getObsPeds    <- crTmpPro.ObsPes / .ObsPeds
4478:     *   getPesoms               <- crTmpPro.Pesoms
4479:     *   gerDIfors               <- SigCdCli.RClis do fornecedor do produto
4480:     *   getsaldo                <- SigMvEst.Sqtds
4481:     *   getqtresta              <- qtds - qtbaixas (qtds quando nada baixado)
4482:     *   lblVDescs/lblPDescs     <- trocam para "Acrescimo" quando ValDescs < 0
4483:     *   getFClFis/getFDlFis     <- classificacao fiscal e a descricao dela
4484:     *
4485:     * Os campos que SAO coluna de SigMvItn nao aparecem aqui: eles tem
4486:     * ControlSource sobre cursor_4c_Itens e acompanham a linha sozinhos - no
4487:     * legado eram atribuidos um a um porque la nao havia ControlSource.
4488:     *
4489:     * PUBLIC: o form pai e o harness chamam de fora.
4490:     *==========================================================================
4491:     PROCEDURE AtualizarPainelProduto()
4492:         LOCAL loc_oPag, loc_oFis, loc_cPro, loc_cSQL, loc_cReff, loc_cDsCol
4493:         LOCAL loc_cNomeFor, loc_cClFis, loc_cDsClFis, loc_nSaldo, loc_nResta
4494:         LOCAL loc_lProsseguir, loc_oErro
4495: 
4496:         loc_oPag = THIS.pgf_4c_Paginas.Page1
4497:         loc_oFis = THIS.pgf_4c_Paginas.Page3.cnt_4c_Item
4498: 
4499:         loc_cPro = ""
4500:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
4501:             loc_cPro = ALLTRIM(cursor_4c_Itens.cpros)
4502:         ENDIF
4503: 
4504:         *-- Linha sem produto: painel limpo, como no ramo ELSE do legado
4505:         IF EMPTY(loc_cPro)
4506:             THIS.LimparPainelProduto()
4507:             RETURN .F.
4508:         ENDIF
4509: 
4510:         *-- Sem conexao (validacao de UI / modo teste) nao ha o que consultar;
4511:         *-- os campos ligados ao cursor continuam mostrando o item.
4512:         IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
4513:             THIS.LimparPainelProduto()
4514:             RETURN .F.
4515:         ENDIF
4516: 
4517:         loc_lProsseguir = .T.
4518:         loc_cReff       = ""
4519:         loc_cDsCol      = ""
4520:         loc_cNomeFor    = ""
4521:         loc_cClFis      = ""
4522:         loc_cDsClFis    = ""
4523:         loc_nSaldo      = 0
4524: 
4525:         TRY
4526:             *-- Produto + descricao da colecao -----------------------------
4527:             loc_cSQL = "SELECT a.Cpros, a.CGrus, a.Reffs, a.Situas," + ;
4528:                        " a.DtSituas, a.CUnis, a.Dpros, a.PesoMs, a.MoeVs," + ;
4529:                        " a.PVens, a.Moedas, a.Colecoes, a.ClFiscals," + ;
4530:                        " a.ObsPes, a.ObsPeds, a.Conjunts, a.ifors," + ;
4531:                        " b.Descs AS ColDescs" + ;

*-- Linhas 4665 a 4780:
4665:             MsgErro("Erro ao atualizar os dados do produto:" + CHR(13) + ;
4666:                     loc_oErro.Message + CHR(13) + ;
4667:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4668:                     "Proc: " + loc_oErro.Procedure, "Erro AtualizarPainelProduto")
4669:             loc_lProsseguir = .F.
4670:         ENDTRY
4671: 
4672:         RETURN loc_lProsseguir
4673:     ENDPROC
4674: 
4675:     *==========================================================================
4676:     * ExecutarConsultaPainel - SQLEXEC das consultas de EXIBICAO do painel.
4677:     * Nenhuma delas alimenta grade, entao o alias pode ser fechado e recriado
4678:     * sem risco - o guard testa o BUFFERING antes do TABLEREVERT (regra #52).
4679:     * Falha de consulta nao interrompe o preenchimento: o legado segue com o
4680:     * campo em branco nos mesmos casos.
4681:     *==========================================================================
4682:     PROTECTED FUNCTION ExecutarConsultaPainel(par_cSQL, par_cCursor)
4683:         LOCAL loc_nResultado, loc_lOk
4684: 
4685:         loc_lOk = .F.
4686: 
4687:         IF USED(par_cCursor)
4688:             IF CURSORGETPROP("Buffering", par_cCursor) > 1
4689:                 TABLEREVERT(.T., par_cCursor)
4690:             ENDIF
4691:             USE IN (par_cCursor)
4692:         ENDIF
4693: 
4694:         loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)
4695: 
4696:         IF loc_nResultado >= 0
4697:             loc_lOk = .T.
4698:         ELSE
4699:             THIS.this_cMensagemErro = CapturarErroSQL()
4700:         ENDIF
4701: 
4702:         RETURN loc_lOk
4703:     ENDFUNC
4704: 
4705:     *==========================================================================
4706:     * FecharCursoresPainel - Fecha os cursores auxiliares do painel e devolve a
4707:     * area de trabalho corrente para cursor_4c_Itens, que eh o alias da grade.
4708:     *==========================================================================
4709:     PROTECTED PROCEDURE FecharCursoresPainel()
4710:         IF USED("cursor_4c_ProTmp")
4711:             USE IN cursor_4c_ProTmp
4712:         ENDIF
4713:         IF USED("cursor_4c_FProTmp")
4714:             USE IN cursor_4c_FProTmp
4715:         ENDIF
4716:         IF USED("cursor_4c_SaldoTmp")
4717:             USE IN cursor_4c_SaldoTmp
4718:         ENDIF
4719:         IF USED("cursor_4c_ForTmp")
4720:             USE IN cursor_4c_ForTmp
4721:         ENDIF
4722:         IF USED("cursor_4c_ClfTmp")
4723:             USE IN cursor_4c_ClfTmp
4724:         ENDIF
4725: 
4726:         IF USED("cursor_4c_Itens")
4727:             SELECT cursor_4c_Itens
4728:         ENDIF
4729:     ENDPROC
4730: 
4731:     *==========================================================================
4732:     * LimparPainelProduto - Ramo ELSE do fwGrade.AfterRowColChange do legado:
4733:     * linha sem produto deixa o painel em branco.
4734:     *
4735:     * So zera os campos de EXIBICAO (sem ControlSource). Os que estao ligados a
4736:     * cursor_4c_Itens NAO entram aqui: escrever .Value neles gravaria no
4737:     * cursor, apagando o item - eles ja mostram branco porque a linha esta
4738:     * vazia.
4739:     *==========================================================================
4740:     PROCEDURE LimparPainelProduto()
4741:         LOCAL loc_oPag
4742: 
4743:         loc_oPag = THIS.pgf_4c_Paginas.Page1
4744: 
4745:         WITH loc_oPag
4746:             .txt_4c_PVens.Value      = 0
4747:             .txt_4c_Peso.Value       = 0
4748:             .txt_4c_Saldo.Value      = 0
4749:             .txt_4c_Qtresta.Value    = 0
4750:             .txt_4c_GVendas.Value    = ""
4751:             .txt_4c_Conjunts.Value   = ""
4752:             .txt_4c_GerDIfors.Value  = ""
4753:             .obj_4c_GetObsPes.Value  = ""
4754:             .obj_4c_GetObsPeds.Value = ""
4755:             .cnt_4c_Reffs.txt_4c_Reffs.Value = ""
4756:             .img_4c_ImgProds.Picture = ""
4757:             .img_4c_ImgProds.Visible = .F.
4758:             .lbl_4c_LblVDescs.Caption = "Valor Desconto"
4759:             .lbl_4c_LblPDescs.Caption = "% Desconto"
4760:         ENDWITH
4761: 
4762:         WITH THIS.pgf_4c_Paginas.Page3.cnt_4c_Item
4763:             .txt_4c_FClFis.Value = ""
4764:             .txt_4c_FDlFis.Value = ""
4765:         ENDWITH
4766:     ENDPROC
4767: 
4768:     *==========================================================================
4769:     * ObterContaFornecedor - Conta usada para achar a referencia do fornecedor
4770:     * em SigPrFnc. Legado:
4771:     *
4772:     *   _Ct = Iif(crSigOpCdd.ChkIfors=1, TprMvCab.ContaOs,
4773:     *             Iif(crSigOpCdd.ChkIfors=2, TprMvCab.Contads, ''))
4774:     *
4775:     * crSigOpCdd vive no data session do form PAI. Sem a configuracao, o
4776:     * legado cai no terceiro ramo (string vazia) - e eh esse o default aqui:
4777:     * a conta de ORIGEM quando ela existe, a de DESTINO como alternativa,
4778:     * vazio quando nenhuma veio do pai.
4779:     *==========================================================================
4780:     PROTECTED FUNCTION ObterContaFornecedor()

*-- Linhas 4831 a 4956:
4831:     * Ligado ao LostFocus do campo porque no legado a procura mora no Valid,
4832:     * isto eh: dispara ao SAIR do campo (regra #47).
4833:     *
4834:     * PUBLIC: alvo de BINDEVENT e do harness de teste.
4835:     *==========================================================================
4836:     PROCEDURE BtnBuscarClick()
4837:         LOCAL loc_oPag, loc_cDigitado, loc_nOpcao, loc_nBarra, loc_nRecno
4838:         LOCAL loc_oErro
4839: 
4840:         loc_oPag     = THIS.pgf_4c_Paginas.Page1
4841:         loc_cDigitado = ALLTRIM(loc_oPag.txt_4c_Busca.Value)
4842:         loc_nOpcao    = loc_oPag.obj_4c_Opt_Busca.Value
4843: 
4844:         IF EMPTY(loc_cDigitado) OR !USED("cursor_4c_Itens")
4845:             loc_oPag.txt_4c_Busca.Value = ""
4846:             RETURN .F.
4847:         ENDIF
4848: 
4849:         THIS.this_lProcuraCB = .T.
4850:         loc_nRecno           = 0
4851: 
4852:         TRY
4853:             SELECT cursor_4c_Itens
4854: 
4855:             IF loc_nOpcao = 1
4856:                 loc_nBarra = INT(VAL(loc_cDigitado))
4857:                 LOCATE FOR cursor_4c_Itens.codbarras = loc_nBarra
4858:             ELSE
4859:                 LOCATE FOR ALLTRIM(cursor_4c_Itens.cpros) == loc_cDigitado
4860:             ENDIF
4861: 
4862:             IF FOUND()
4863:                 loc_nRecno = RECNO("cursor_4c_Itens")
4864:             ENDIF
4865: 
4866:         CATCH TO loc_oErro
4867:             MsgErro("Erro ao procurar na grade:" + CHR(13) + loc_oErro.Message + ;
4868:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4869:                     "Proc: " + loc_oErro.Procedure, "Erro BtnBuscarClick")
4870:         ENDTRY
4871: 
4872:         *-- LostFocus do legado: limpa o campo de procura sempre
4873:         loc_oPag.txt_4c_Busca.Value = ""
4874: 
4875:         IF loc_nRecno > 0
4876:             SELECT cursor_4c_Itens
4877:             GO loc_nRecno
4878:             THIS.AtualizarPainelProduto()
4879:             THIS.RepintarGradeItens()
4880:             SELECT cursor_4c_Itens
4881:             GO loc_nRecno
4882:             THIS.grd_4c_Dados.Refresh()
4883:         ELSE
4884:             MsgAviso("Item n" + CHR(227) + "o encontrado na grade.", "Procurar")
4885:         ENDIF
4886: 
4887:         THIS.this_lProcuraCB = .F.
4888: 
4889:         RETURN (loc_nRecno > 0)
4890:     ENDPROC
4891: 
4892:     *==========================================================================
4893:     * TxtProdLostFocus - Conferencia por codigo (get_prod do legado).
4894:     *
4895:     * O legado resolve o valor digitado nesta ordem (get_prod.Valid):
4896:     *   1. codigo de barras que JA esta numa linha da grade (Seek em
4897:     *      crTpmMvItn por codbarras) - marca ThisForm.Barra e usa o produto
4898:     *      daquela linha;
4899:     *   2. etiqueta individual em SigOpEtq (com LEFT JOIN em SigOpEta para
4900:     *      aceitar a barra antiga de uma etiqueta reemitida);
4901:     *   3. SigCdPro.Cbars (codigo de barras do cadastro);
4902:     *   4. SigCdPro.Ean13;
4903:     *   5. o proprio valor como CPros.
4904:     * Em qualquer caminho, achando o produto ele confere a unidade: se
4905:     * SigCdUni.etiqs = 'S' recusa com "Codigo Errado - Etiqueta Especial !!".
4906:     * Nao achando, avisa "Produto Nao Cadastrado!!!".
4907:     *
4908:     * fVerificarBarras() (SIGFUNCS.PRG) NAO foi portada. No legado ela apenas
4909:     * ESCOLHE entre o ramo de barras e o ramo de EAN13 - e os dois ramos
4910:     * terminam na mesma consulta a SigCdPro - entao tentar as duas resolucoes
4911:     * em sequencia produz o mesmo resultado sem o wrapper (mesma decisao
4912:     * documentada em FormSigPrEtq, regra #27 "no-op documentado").
4913:     *
4914:     * PUBLIC: alvo de BINDEVENT e do harness de teste.
4915:     *==========================================================================
4916:     PROCEDURE TxtProdLostFocus()
4917:         LOCAL loc_oPag, loc_cDigitado, loc_cProduto
4918: 
4919:         loc_oPag      = THIS.pgf_4c_Paginas.Page1
4920:         loc_cDigitado = ALLTRIM(loc_oPag.txt_4c__prod.Value)
4921: 
4922:         THIS.this_nBarra = 0
4923: 
4924:         IF EMPTY(loc_cDigitado)
4925:             RETURN .F.
4926:         ENDIF
4927: 
4928:         *-- Guarda de reentrancia: o aviso eh modal, tira o foco e faria o
4929:         *-- proprio LostFocus disparar de novo (regra #37/#47).
4930:         IF THIS.this_lEmLookup
4931:             RETURN .F.
4932:         ENDIF
4933:         THIS.this_lEmLookup = .T.
4934: 
4935:         loc_cProduto = THIS.ResolverProdutoDigitado(loc_cDigitado)
4936: 
4937:         IF EMPTY(loc_cProduto)
4938:             THIS.this_lValidOk = .F.
4939:         ELSE
4940:             THIS.this_lValidOk = .T.
4941:             loc_oPag.txt_4c__prod.Value = loc_cProduto
4942:             loc_oPag.txt_4c__prod.Refresh()
4943: 
4944:             THIS.CarregarImagemProduto(loc_cProduto)
4945: 
4946:             *-- Legado (get_prod.LostFocus): com ZerQtds = 2 e barra lida, a
4947:             *-- quantidade 1 eh assumida e o fluxo segue para a conferencia.
4948:             IF THIS.this_nZerQtds = 2 AND THIS.this_nBarra <> 0
4949:                 loc_oPag.txt_4c__qtd.Value = 1
4950:             ENDIF
4951:         ENDIF
4952: 
4953:         THIS.this_lEmLookup = .F.
4954: 
4955:         RETURN THIS.this_lValidOk
4956:     ENDPROC

*-- Linhas 4984 a 5027:
4984: 
4985:         IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
4986:             IF EMPTY(loc_cProduto)
4987:                 MsgAviso("Conex" + CHR(227) + "o com o banco n" + CHR(227) + ;
4988:                          "o dispon" + CHR(237) + "vel.", "Aten" + CHR(231) + CHR(227) + "o!!!")
4989:             ENDIF
4990:             RETURN loc_cProduto
4991:         ENDIF
4992: 
4993:         TRY
4994:             *-- 2. Etiqueta individual (SigOpEtq + SigOpEta) ---------------
4995:             IF EMPTY(loc_cProduto) AND loc_nBarra <> 0
4996:                 loc_cSQL = "SELECT a.CPros, a.CBars, a.CodTams, a.Contas" + ;
4997:                            " FROM SigOpEtq a" + ;
4998:                            " LEFT JOIN SigOpEta b ON a.cpros = b.cpros" + ;
4999:                            " AND a.cbars = b.cbars_new" + ;
5000:                            " WHERE (a.CBars = " + FormatarNumeroSQL(loc_nBarra, 0) + ;
5001:                            " OR b.cbars_old = " + FormatarNumeroSQL(loc_nBarra, 0) + ")"
5002: 
5003:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_EtqTmp")
5004:                     IF USED("cursor_4c_EtqTmp")
5005:                         SELECT cursor_4c_EtqTmp
5006:                         GO TOP
5007:                         IF !EOF()
5008:                             THIS.this_nBarra = loc_nBarra
5009:                             loc_cProduto     = ALLTRIM(TratarNulo(cursor_4c_EtqTmp.CPros, ""))
5010:                         ENDIF
5011:                         USE IN cursor_4c_EtqTmp
5012:                     ENDIF
5013:                 ENDIF
5014:             ENDIF
5015: 
5016:             *-- 3. Codigo de barras do cadastro (SigCdPro.Cbars) -----------
5017:             IF EMPTY(loc_cProduto) AND loc_nBarra <> 0
5018:                 loc_cSQL = "SELECT Cpros FROM SigCdPro" + ;
5019:                            " WHERE Cbars = " + FormatarNumeroSQL(loc_nBarra, 0)
5020: 
5021:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_BarTmp")
5022:                     IF USED("cursor_4c_BarTmp")
5023:                         SELECT cursor_4c_BarTmp
5024:                         GO TOP
5025:                         IF !EOF()
5026:                             THIS.this_nBarra = loc_nBarra
5027:                             loc_cProduto     = ALLTRIM(TratarNulo(cursor_4c_BarTmp.Cpros, ""))

*-- Linhas 5065 a 5159:
5065:                     SELECT cursor_4c_ProdTmp
5066:                     GO TOP
5067:                     IF EOF()
5068:                         MsgAviso("Produto N" + CHR(227) + "o Cadastrado!!! " + ;
5069:                                  CHR(13) + loc_cProduto, ;
5070:                                  "Aten" + CHR(231) + CHR(227) + "o!!!")
5071:                         loc_cProduto = ""
5072:                     ELSE
5073:                         loc_cUnidade = UPPER(ALLTRIM(TratarNulo(cursor_4c_ProdTmp.etiqs, "")))
5074:                         *-- Legado: CrSigCdUni.etiqs = 'S' recusa a digitacao
5075:                         *-- manual porque o produto exige etiqueta especial.
5076:                         IF loc_cUnidade == "S"
5077:                             MsgAviso("C" + CHR(243) + "digo Errado - Etiqueta Especial !!", ;
5078:                                      "Aten" + CHR(231) + CHR(227) + "o!!!")
5079:                             loc_cProduto = ""
5080:                         ELSE
5081:                             loc_cProduto = ALLTRIM(TratarNulo(cursor_4c_ProdTmp.Cpros, loc_cProduto))
5082:                         ENDIF
5083:                     ENDIF
5084:                     USE IN cursor_4c_ProdTmp
5085:                 ENDIF
5086:             ELSE
5087:                 loc_cProduto = ""
5088:             ENDIF
5089: 
5090:         CATCH TO loc_oErro
5091:             loc_cProduto = ""
5092:             MsgErro("Erro ao resolver o produto digitado:" + CHR(13) + ;
5093:                     loc_oErro.Message + CHR(13) + ;
5094:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5095:                     "Proc: " + loc_oErro.Procedure, "Erro ResolverProdutoDigitado")
5096:         ENDTRY
5097: 
5098:         IF USED("cursor_4c_Itens")
5099:             SELECT cursor_4c_Itens
5100:         ENDIF
5101: 
5102:         RETURN loc_cProduto
5103:     ENDFUNC
5104: 
5105:     *==========================================================================
5106:     * CarregarImagemProduto - Foto do produto em img_4c_ImgProds. Legado
5107:     * (get_prod.Valid e fwGrade.AfterRowColChange):
5108:     *
5109:     *   If CrSigCdOpe.Imagems = 1
5110:     *       imgProds.Visible = .F. / imgProds.Picture = ''
5111:     *       If Not Empty(CrTmpPro.FigJpgs) And Not Isnull(CrTmpPro.FigJpgs)
5112:     *           lcFoto = Strconv(Strtran(... data:image/...;base64, ...),14)
5113:     *           If (StrToFile(lcFoto, lcArquivo3) > 0)
5114:     *               imgProds.Picture = (lcArquivo3) / imgProds.Visible = .T.
5115:     *
5116:     * STRCONV(...,14) decodifica Base64 UMA vez - decodificar duas vezes
5117:     * devolve lixo e o LOADPICTURE/Picture falha sem mensagem.
5118:     *==========================================================================
5119:     PROTECTED PROCEDURE CarregarImagemProduto(par_cProduto)
5120:         LOCAL loc_oImg, loc_cSQL, loc_cFig, loc_cFoto, loc_cArquivo, loc_oErro
5121: 
5122:         loc_oImg = THIS.pgf_4c_Paginas.Page1.img_4c_ImgProds
5123: 
5124:         loc_oImg.Visible = .F.
5125:         loc_oImg.Picture = ""
5126: 
5127:         *-- Legado so carrega a foto quando a operacao pede (Imagems = 1)
5128:         IF THIS.this_nImagems <> 1
5129:             RETURN .F.
5130:         ENDIF
5131: 
5132:         IF VARTYPE(par_cProduto) <> "C" OR EMPTY(par_cProduto)
5133:             RETURN .F.
5134:         ENDIF
5135: 
5136:         IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
5137:             RETURN .F.
5138:         ENDIF
5139: 
5140:         TRY
5141:             loc_cSQL = "SELECT FigJpgs FROM SigCdPro" + ;
5142:                        " WHERE Cpros = " + EscaparSQL(ALLTRIM(par_cProduto))
5143: 
5144:             IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_FigTmp")
5145:                 IF USED("cursor_4c_FigTmp")
5146:                     SELECT cursor_4c_FigTmp
5147:                     GO TOP
5148:                     IF !EOF()
5149:                         loc_cFig = TratarNulo(cursor_4c_FigTmp.FigJpgs, "")
5150: 
5151:                         IF !EMPTY(loc_cFig)
5152:                             loc_cFig = STRTRAN(loc_cFig, "data:image/png;base64,",  "")
5153:                             loc_cFig = STRTRAN(loc_cFig, "data:image/jpeg;base64,", "")
5154:                             loc_cFig = STRTRAN(loc_cFig, "data:image/jpg;base64,",  "")
5155: 
5156:                             loc_cFoto    = STRCONV(loc_cFig, 14)
5157:                             loc_cArquivo = ADDBS(SYS(2023)) + "SigOpPro_" + ;
5158:                                            SYS(2015) + ".jpg"
5159: 

*-- Linhas 5202 a 5247:
5202:     *       ... Skip -1 / fwgrade.Refresh / get_prod.SetFocus / Barra = 0
5203:     *   Endif
5204:     *
5205:     * PUBLIC: alvo de BINDEVENT e do harness de teste.
5206:     *==========================================================================
5207:     PROCEDURE TxtQtdLostFocus()
5208:         LOCAL loc_oPag, loc_cProduto, loc_nQtde, loc_lAchouLinha, loc_lConfere
5209:         LOCAL loc_nRecnoAchado, loc_oErro
5210: 
5211:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5212: 
5213:         loc_nQtde    = loc_oPag.txt_4c__qtd.Value
5214:         loc_cProduto = PADR(ALLTRIM(loc_oPag.txt_4c__prod.Value), 14)
5215: 
5216:         IF VARTYPE(loc_nQtde) <> "N" OR loc_nQtde = 0
5217:             RETURN .F.
5218:         ENDIF
5219: 
5220:         IF !USED("cursor_4c_Itens")
5221:             RETURN .F.
5222:         ENDIF
5223: 
5224:         IF THIS.this_lEmLookup
5225:             RETURN .F.
5226:         ENDIF
5227:         THIS.this_lEmLookup = .T.
5228: 
5229:         loc_lAchouLinha = .F.
5230:         loc_lConfere    = .F.
5231:         loc_nRecnoAchado = 0
5232: 
5233:         TRY
5234:             SELECT cursor_4c_Itens
5235:             SET ORDER TO
5236:             GO TOP
5237: 
5238:             *-- Procura a linha ainda nao conferida cuja quantidade bate.
5239:             *-- Com barra lida (this_nBarra) o legado nao exige casar o
5240:             *-- produto: a barra ja identificou a linha.
5241:             SCAN
5242:                 IF THIS.this_nBarra <> 0
5243:                     IF cursor_4c_Itens.codbarras <> THIS.this_nBarra
5244:                         LOOP
5245:                     ENDIF
5246:                 ELSE
5247:                     IF PADR(cursor_4c_Itens.cpros, 14) <> loc_cProduto

*-- Linhas 5268 a 5475:
5268:         CATCH TO loc_oErro
5269:             MsgErro("Erro ao conferir o item:" + CHR(13) + loc_oErro.Message + ;
5270:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5271:                     "Proc: " + loc_oErro.Procedure, "Erro TxtQtdLostFocus")
5272:         ENDTRY
5273: 
5274:         DO CASE
5275:             CASE loc_lConfere
5276:                 THIS.RepintarGradeItens()
5277:                 IF loc_nRecnoAchado > 0
5278:                     SELECT cursor_4c_Itens
5279:                     GO loc_nRecnoAchado
5280:                 ENDIF
5281:                 THIS.AtualizarPainelProduto()
5282:             CASE loc_lAchouLinha
5283:                 MsgAviso("Quantidade Errada !!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5284:             OTHERWISE
5285:                 MsgAviso("Item n" + CHR(227) + "o encontrado !!", ;
5286:                          "Aten" + CHR(231) + CHR(227) + "o!!!")
5287:         ENDCASE
5288: 
5289:         *-- Em TODOS os caminhos o legado limpa os dois campos e devolve o
5290:         *-- foco ao codigo, pronto para a leitura seguinte.
5291:         THIS.this_nBarra            = 0
5292:         THIS.this_lEmLookup         = .F.
5293: 
5294:         IF loc_oPag.txt_4c__prod.Visible AND loc_oPag.txt_4c__prod.Enabled
5295:             loc_oPag.txt_4c__prod.SetFocus()
5296:         ENDIF
5297: 
5298:         RETURN loc_lConfere
5299:     ENDPROC
5300: 
5301:     *==========================================================================
5302:     * AbrirLookupCanonico - Padrao canonico do projeto (FormBuscaAuxiliar,
5303:     * regra #37) para os lookups simples de codigo/descricao do painel (Cor,
5304:     * Tamanho): o Init do FormBuscaAuxiliar ja tenta o match exato pelo valor
5305:     * digitado e, nao resolvendo, mostra o Show(); so sob a guarda
5306:     * this_lSelecionou o valor escolhido volta para o controle de codigo (e,
5307:     * quando informado, para o de descricao).
5308:     *
5309:     * par_cTabela            - tabela de origem (SigCdCor, SigCdTam, ...)
5310:     * par_cCampoCodigo       - coluna do codigo (ex.: "Cods")
5311:     * par_cCampoDescricao    - coluna da descricao (ex.: "Descs")
5312:     * par_cTitulo            - titulo do dialogo
5313:     * par_cValorAtual        - valor digitado, usado no match exato do Init
5314:     * par_oControleCodigo    - TextBox que recebe o codigo escolhido
5315:     * par_oControleDescricao - TextBox que recebe a descricao escolhida, ou
5316:     *                          .NULL. quando nao ha controle de descricao
5317:     *==========================================================================
5318:     PROTECTED PROCEDURE AbrirLookupCanonico(par_cTabela, par_cCampoCodigo, ;
5319:                                             par_cCampoDescricao, par_cTitulo, ;
5320:                                             par_cValorAtual, par_oControleCodigo, ;
5321:                                             par_oControleDescricao)
5322:         LOCAL loc_oBusca, loc_cCursor
5323: 
5324:         IF VARTYPE(par_oControleCodigo) <> "O"
5325:             RETURN .F.
5326:         ENDIF
5327: 
5328:         loc_cCursor = "cursor_4c_BuscaCanonico"
5329: 
5330:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, par_cTabela, ;
5331:                                    loc_cCursor, par_cCampoCodigo, par_cValorAtual, ;
5332:                                    par_cTitulo, .F., .T., "")
5333: 
5334:         IF VARTYPE(loc_oBusca) = "O"
5335:             IF !loc_oBusca.this_lAchouRegistro
5336:                 loc_oBusca.mAddColuna(par_cCampoCodigo, "", "C" + CHR(243) + "digo")
5337:                 loc_oBusca.mAddColuna(par_cCampoDescricao, "", "Descri" + CHR(231) + CHR(227) + "o")
5338:                 loc_oBusca.Show()
5339:             ENDIF
5340: 
5341:             IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
5342:                 SELECT (loc_cCursor)
5343:                 par_oControleCodigo.Value = ALLTRIM(EVALUATE(loc_cCursor + "." + par_cCampoCodigo))
5344: 
5345:                 IF VARTYPE(par_oControleDescricao) = "O"
5346:                     par_oControleDescricao.Value = ALLTRIM(EVALUATE(loc_cCursor + "." + par_cCampoDescricao))
5347:                 ENDIF
5348:             ENDIF
5349: 
5350:             loc_oBusca.Release()
5351:         ENDIF
5352: 
5353:         IF USED(loc_cCursor)
5354:             USE IN (loc_cCursor)
5355:         ENDIF
5356: 
5357:         RETURN .T.
5358:     ENDPROC
5359: 
5360:     *==========================================================================
5361:     * ValidarCodCorLostFocus - Cor do item (getCodCors.Valid do legado, que
5362:     * abre fwbuscaext sobre SigCdCor por 'Cods'). Aqui o browse eh o
5363:     * FormBuscaAuxiliar via AbrirLookupCanonico (padrao canonico do projeto).
5364:     *
5365:     * O valor escolhido volta para o proprio TextBox, que tem ControlSource em
5366:     * cursor_4c_Itens.codcors - entao ele grava na linha corrente, igual ao
5367:     * "This.Value = crListaRemota.Cods" do legado.
5368:     *
5369:     * PUBLIC: alvo de BINDEVENT.
5370:     *==========================================================================
5371:     PROCEDURE ValidarCodCorLostFocus()
5372:         LOCAL loc_oPag, loc_cValor
5373: 
5374:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
5375:         loc_cValor = ALLTRIM(TRANSFORM(loc_oPag.txt_4c_CodCors.Value))
5376: 
5377:         *-- Legado: "If !Empty(lcCodCors)" - vazio nao abre browse nenhum
5378:         IF EMPTY(loc_cValor)
5379:             RETURN .F.
5380:         ENDIF
5381: 
5382:         *-- Guarda de valor-nao-mudou: LostFocus dispara SEMPRE, mas o Valid
5383:         *-- do legado so dispara quando o valor MUDA.
5384:         IF loc_cValor == THIS.this_cUltimoValidarCodCorLostFocusValidado
5385:             RETURN .T.
5386:         ENDIF
5387: 
5388:         IF THIS.this_lEmLookup
5389:             RETURN .F.
5390:         ENDIF
5391:         THIS.this_lEmLookup = .T.
5392: 
5393:         THIS.AbrirLookupCanonico("SigCdCor", "Cods", "Descs", ;
5394:                                  "Sele" + CHR(231) + CHR(227) + "o de Cor", ;
5395:                                  loc_cValor, loc_oPag.txt_4c_CodCors, .NULL.)
5396: 
5397:         THIS.this_cUltimoValidarCodCorLostFocusValidado = ;
5398:             ALLTRIM(TRANSFORM(loc_oPag.txt_4c_CodCors.Value))
5399: 
5400:         THIS.this_lEmLookup = .F.
5401: 
5402:         RETURN .T.
5403:     ENDPROC
5404: 
5405:     *==========================================================================
5406:     * ValidarCodTamLostFocus - Tamanho do item (getCodTams.Valid do legado,
5407:     * fwbuscaext sobre SigCdTam por 'Cods'). Mesmo desenho de
5408:     * ValidarCodCorLostFocus.
5409:     *==========================================================================
5410:     PROCEDURE ValidarCodTamLostFocus()
5411:         LOCAL loc_oPag, loc_cValor
5412: 
5413:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
5414:         loc_cValor = ALLTRIM(TRANSFORM(loc_oPag.txt_4c_CodTams.Value))
5415: 
5416:         IF EMPTY(loc_cValor)
5417:             RETURN .F.
5418:         ENDIF
5419: 
5420:         *-- Guarda de valor-nao-mudou: LostFocus dispara SEMPRE, mas o Valid
5421:         *-- do legado so dispara quando o valor MUDA.
5422:         IF loc_cValor == THIS.this_cUltimoValidarCodTamLostFocusValidado
5423:             RETURN .T.
5424:         ENDIF
5425: 
5426:         IF THIS.this_lEmLookup
5427:             RETURN .F.
5428:         ENDIF
5429:         THIS.this_lEmLookup = .T.
5430: 
5431:         THIS.AbrirLookupCanonico("SigCdTam", "Cods", "Descs", ;
5432:                                  "Sele" + CHR(231) + CHR(227) + "o de Tamanho", ;
5433:                                  loc_cValor, loc_oPag.txt_4c_CodTams, .NULL.)
5434: 
5435:         THIS.this_cUltimoValidarCodTamLostFocusValidado = ;
5436:             ALLTRIM(TRANSFORM(loc_oPag.txt_4c_CodTams.Value))
5437: 
5438:         THIS.this_lEmLookup = .F.
5439: 
5440:         RETURN .T.
5441:     ENDPROC
5442: 
5443:     *==========================================================================
5444:     * ValidarVDescsLostFocus - Desconto em VALOR (getVDescs.Valid do legado):
5445:     *
5446:     *   If !Empty(this.Value) And (This.Value # ThisForm.OldPreco)
5447:     *       If this.Value > 0
5448:     *           Replace Units With UnitOrigs - this.Value in crTpmMvItn
5449:     *       Else
5450:     *           Replace Units With UnitOrigs + this.Value in crTpmMvItn
5451:     *       Endif
5452:     *       ... Replace Utilizas ... / ThisForm.ParentForm.calc_valite()
5453:     *
5454:     * A formula eh TRANSCRITA, nao reescrita (regra #17): valor POSITIVO eh
5455:     * desconto e SUBTRAI do unitario de origem; valor NEGATIVO eh acrescimo e
5456:     * SOMA. Quem recalcula o total do item eh o Calc_ValIte do form pai, via
5457:     * TotalizarLinha().
5458:     *==========================================================================
5459:     *==========================================================================
5460:     * ValidarDocsLostFocus - Documento do item (getDocs.Valid do legado).
5461:     *
5462:     * Duas regras do legado, nesta ordem:
5463:     *
5464:     * 1. VAZIO: "If llNotasObrig Or crSigCdOpe.EditDocs = 5 / Messagebox
5465:     *    ('Obrigatorio Informar Documento do Produto ' + CPros) / Return 0".
5466:     *    llNotasObrig vem de Seek em csOpeAut (cursor de operacao automatica do
5467:     *    form PAI); sem ele carregado o Seek do legado devolve .F. e a condicao
5468:     *    fica so com EditDocs = 5 - mesmo comportamento aqui.
5469:     *
5470:     * 2. PREENCHIDO e crSigCdOpe.ValiNotas = 1: o documento tem de ser UNICO.
5471:     *    a) "Select Emps, Dopes, Numes From SigMvItn Where Notas = '<valor>'" -
5472:     *       achando o MESMO Dopes em OUTRA movimentacao (emps+dopes+numes
5473:     *       diferente da corrente), recusa com "Documento ... Ja Existe !!";
5474:     *    b) nao achando, conta no cursor local quantas linhas usam o mesmo
5475:     *       documento - mais de uma recusa com "Documento ... Ja Lancado Nessa

*-- Linhas 5484 a 5658:
5484:     * O legado tambem normaliza o valor com Transf(Val(This.Value),"@L 999999")
5485:     * - documento eh char(6) com zeros a esquerda.
5486:     *
5487:     * PUBLIC: alvo de BINDEVENT.
5488:     *==========================================================================
5489:     PROCEDURE ValidarDocsLostFocus()
5490:         LOCAL loc_oPag, loc_cNotas, loc_cSQL, loc_cChave, loc_nIguais
5491:         LOCAL loc_lOk, loc_nRecno, loc_oErro
5492: 
5493:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5494:         loc_lOk  = .T.
5495: 
5496:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
5497:             RETURN .T.
5498:         ENDIF
5499: 
5500:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
5501:             RETURN .T.
5502:         ENDIF
5503: 
5504:         loc_cNotas = ALLTRIM(TRANSFORM(loc_oPag.txt_4c_Docs.Value))
5505: 
5506:         *-- 1. Documento vazio -------------------------------------------
5507:         IF EMPTY(loc_cNotas)
5508:             IF THIS.this_nEditDocs = 5
5509:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar Documento do Produto " + ;
5510:                          ALLTRIM(cursor_4c_Itens.cpros), ;
5511:                          "Documento Obrigat" + CHR(243) + "rio")
5512:                 loc_lOk = .F.
5513:             ENDIF
5514:             RETURN loc_lOk
5515:         ENDIF
5516: 
5517:         *-- Normalizacao do legado: 6 posicoes com zeros a esquerda
5518:         loc_cNotas = PADL(ALLTRIM(STR(INT(VAL(loc_cNotas)), 6)), 6, "0")
5519:         loc_oPag.txt_4c_Docs.Value = loc_cNotas
5520: 
5521:         IF THIS.this_nValiNotas <> 1
5522:             RETURN .T.
5523:         ENDIF
5524: 
5525:         IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
5526:             RETURN .T.
5527:         ENDIF
5528: 
5529:         loc_cChave = THIS.ObterChaveMovimentacao()
5530: 
5531:         TRY
5532:             *-- 2a. Mesmo documento em OUTRA movimentacao da mesma operacao
5533:             loc_cSQL = "SELECT Emps, Dopes, Numes, empdopnums FROM SigMvItn" + ;
5534:                        " WHERE Notas = " + EscaparSQL(loc_cNotas) + ;
5535:                        " AND Dopes = " + EscaparSQL(PADR(THIS.this_cDopes, 20))
5536: 
5537:             IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_NotaTmp")
5538:                 IF USED("cursor_4c_NotaTmp")
5539:                     SELECT cursor_4c_NotaTmp
5540:                     SCAN
5541:                         IF ALLTRIM(TratarNulo(cursor_4c_NotaTmp.empdopnums, "")) <> ;
5542:                            ALLTRIM(loc_cChave)
5543:                             MsgAviso("Documento " + ALLTRIM(THIS.this_cDopes) + " " + ;
5544:                                      loc_cNotas + " J" + CHR(225) + " Existe !!", ;
5545:                                      "Opera" + CHR(231) + CHR(227) + "o: " + ;
5546:                                      ALLTRIM(TratarNulo(cursor_4c_NotaTmp.Emps, "")) + "-" + ;
5547:                                      ALLTRIM(TratarNulo(cursor_4c_NotaTmp.Dopes, "")) + "-" + ;
5548:                                      ALLTRIM(STR(TratarNulo(cursor_4c_NotaTmp.Numes, 0))))
5549:                             loc_lOk = .F.
5550:                             EXIT
5551:                         ENDIF
5552:                     ENDSCAN
5553:                     USE IN cursor_4c_NotaTmp
5554:                 ENDIF
5555:             ENDIF
5556: 
5557:             *-- 2b. Mesmo documento repetido DENTRO desta operacao
5558:             IF loc_lOk
5559:                 SELECT cursor_4c_Itens
5560:                 loc_nRecno = RECNO()
5561:                 COUNT FOR ALLTRIM(cursor_4c_Itens.notas) == loc_cNotas TO loc_nIguais
5562:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
5563:                     GO loc_nRecno
5564:                 ENDIF
5565: 
5566:                 IF loc_nIguais > 1
5567:                     MsgAviso("Documento " + ALLTRIM(THIS.this_cDopes) + " " + loc_cNotas + ;
5568:                              " J" + CHR(225) + " Lan" + CHR(231) + "ado Nessa Opera" + ;
5569:                              CHR(231) + CHR(227) + "o !!", ;
5570:                              "Opera" + CHR(231) + CHR(227) + "o: " + ALLTRIM(THIS.this_cDopes))
5571:                     loc_lOk = .F.
5572:                 ENDIF
5573:             ENDIF
5574: 
5575:             *-- 3. Valor unitario vindo do documento (produto 'C')
5576:             IF loc_lOk AND THIS.this_nOpVlUnis = 1 AND ;
5577:                PADR(cursor_4c_Itens.cpros, 14) == PADR("C", 14)
5578:                 THIS.AplicarValorDoDocumento(INT(VAL(loc_cNotas)))
5579:             ENDIF
5580: 
5581:         CATCH TO loc_oErro
5582:             MsgErro("Erro ao validar o documento do produto:" + CHR(13) + ;
5583:                     loc_oErro.Message + CHR(13) + ;
5584:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5585:                     "Proc: " + loc_oErro.Procedure, "Erro ValidarDocsLostFocus")
5586:             loc_lOk = .F.
5587:         ENDTRY
5588: 
5589:         IF USED("cursor_4c_Itens")
5590:             SELECT cursor_4c_Itens
5591:         ENDIF
5592: 
5593:         RETURN loc_lOk
5594:     ENDPROC
5595: 
5596:     *==========================================================================
5597:     * AplicarValorDoDocumento - Ramo "crSigOpCdc.OpVlUnis = 1" do
5598:     * getDocs.Valid: o valor unitario do item 'C' vem do documento informado.
5599:     *
5600:     * Legado:
5601:     *   lcSql = [Select a.Valos, a.Datas, a.EmpDopNums From SigMvCab a,
5602:     *            SigCdOpe b, SigCdTom c Where a.Dopes = b.Dopes And
5603:     *            b.TipoOps = c.Codigos And c.OpVlUnis = 1 And a.Numes = <n>
5604:     *            Order by A.Datas]
5605:     *   Select LocalEest / Go Bott
5606:     *   If Reccount() > 0
5607:     *       Replace Units With LocalEest.valos, Utilizas With 51 in crTpmMvItn
5608:     *       If crSigCdOpe.parcs = 1 ... soma SigMvPar em xPar ... Replace Units
5609:     *   ThisForm.Calc_ValIte()
5610:     *
5611:     * Utilizas = 51 eh a marca do legado para "preco travado pelo documento":
5612:     * os guards de When de getVDescs/getPDescs e da coluna Valor testam
5613:     * justamente esse valor.
5614:     *
5615:     * A acumulacao das parcelas grava no cursor xPar, que eh do form PAI; ela
5616:     * so roda quando o pai entregou esse cursor.
5617:     *==========================================================================
5618:     PROTECTED PROCEDURE AplicarValorDoDocumento(par_nNumero)
5619:         LOCAL loc_cSQL, loc_nValor, loc_cEdn, loc_nTotPar, loc_lAplicou
5620: 
5621:         loc_lAplicou = .F.
5622: 
5623:         IF VARTYPE(par_nNumero) <> "N" OR par_nNumero = 0
5624:             RETURN .F.
5625:         ENDIF
5626: 
5627:         loc_cSQL = "SELECT a.Valos, a.Datas, a.EmpDopNums" + ;
5628:                    " FROM SigMvCab a, SigCdOpe b, SigCdTom c" + ;
5629:                    " WHERE a.Dopes = b.Dopes" + ;
5630:                    " AND b.TipoOps = c.Codigos" + ;
5631:                    " AND c.OpVlUnis = 1" + ;
5632:                    " AND a.Numes = " + FormatarNumeroSQL(par_nNumero, 0) + ;
5633:                    " ORDER BY a.Datas"
5634: 
5635:         IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_DocValTmp")
5636:             IF USED("cursor_4c_DocValTmp")
5637:                 SELECT cursor_4c_DocValTmp
5638:                 GO BOTTOM
5639:                 IF RECCOUNT("cursor_4c_DocValTmp") > 0
5640:                     loc_nValor = TratarNulo(cursor_4c_DocValTmp.Valos, 0)
5641:                     loc_cEdn   = ALLTRIM(TratarNulo(cursor_4c_DocValTmp.EmpDopNums, ""))
5642: 
5643:                     SELECT cursor_4c_Itens
5644:                     REPLACE units    WITH loc_nValor, ;
5645:                             utilizas WITH 51 IN cursor_4c_Itens
5646: 
5647:                     *-- Parcelas: o cursor de destino (xPar) pertence ao form
5648:                     *-- PAI; sem ele entregue, o legado tambem nao soma nada.
5649:                     IF THIS.this_nParcs = 1 AND USED("xPar") AND !EMPTY(loc_cEdn)
5650:                         loc_cSQL = "SELECT Valos FROM SigMvPar" + ;
5651:                                    " WHERE EmpdopNums = " + EscaparSQL(loc_cEdn) + ;
5652:                                    " AND fPags = " + EscaparSQL("P")
5653: 
5654:                         IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_ParTmp")
5655:                             loc_nTotPar = 0
5656:                             IF USED("cursor_4c_ParTmp")
5657:                                 SELECT cursor_4c_ParTmp
5658:                                 SCAN

*-- Linhas 5708 a 6096:
5708:     * decimais; aqui o INT() sobre o valor digitado faz o mesmo sem mexer num
5709:     * SET global.
5710:     *
5711:     * PUBLIC: alvo de BINDEVENT.
5712:     *==========================================================================
5713:     PROCEDURE ValidarLotesLostFocus()
5714:         LOCAL loc_oPag, loc_nLote, loc_cLote, loc_nDope, loc_nNume
5715:         LOCAL loc_cDope, loc_nCtrl, loc_cSQL, loc_lOk, loc_oErro
5716: 
5717:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5718:         loc_lOk  = .T.
5719: 
5720:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
5721:             RETURN .T.
5722:         ENDIF
5723: 
5724:         loc_nLote = loc_oPag.txt_4c_Lotes.Value
5725: 
5726:         IF VARTYPE(loc_nLote) <> "N" OR loc_nLote = 0
5727:             RETURN .T.
5728:         ENDIF
5729: 
5730:         IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
5731:             RETURN .T.
5732:         ENDIF
5733: 
5734:         *-- 10 posicoes: 4 da operacao + 6 do numero da movimentacao
5735:         loc_cLote = PADL(ALLTRIM(STR(INT(loc_nLote), 10)), 10, "0")
5736:         loc_nDope = VAL(LEFT(loc_cLote, 4))
5737:         loc_nNume = VAL(RIGHT(loc_cLote, 6))
5738:         loc_cDope = ""
5739:         loc_nCtrl = 0
5740: 
5741:         TRY
5742:             loc_cSQL = "SELECT Dopes, Ctrllotes FROM SigCdOpe" + ;
5743:                        " WHERE nDopes = " + FormatarNumeroSQL(loc_nDope, 0)
5744: 
5745:             IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_OpeLoteTmp")
5746:                 IF USED("cursor_4c_OpeLoteTmp")
5747:                     SELECT cursor_4c_OpeLoteTmp
5748:                     GO TOP
5749:                     IF !EOF()
5750:                         loc_cDope = ALLTRIM(TratarNulo(cursor_4c_OpeLoteTmp.Dopes, ""))
5751:                         loc_nCtrl = TratarNulo(cursor_4c_OpeLoteTmp.Ctrllotes, 0)
5752:                     ENDIF
5753:                     USE IN cursor_4c_OpeLoteTmp
5754:                 ENDIF
5755:             ENDIF
5756: 
5757:             IF loc_nCtrl <> 1
5758:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o " + loc_cDope + ;
5759:                          " n" + CHR(227) + "o Configurada para gerar No. Lote !!", ;
5760:                          "Aten" + CHR(231) + CHR(227) + "o!!!")
5761:                 loc_lOk = .F.
5762:             ENDIF
5763: 
5764:             IF loc_lOk
5765:                 loc_cSQL = "SELECT EmpDopNums FROM SigMvCab" + ;
5766:                            " WHERE Numes = " + FormatarNumeroSQL(loc_nNume, 0) + ;
5767:                            " AND Dopes = " + EscaparSQL(PADR(loc_cDope, 20))
5768: 
5769:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_LoteTmp")
5770:                     IF !USED("cursor_4c_LoteTmp") OR RECCOUNT("cursor_4c_LoteTmp") = 0
5771:                         MsgAviso("Lote N" + CHR(186) + " " + ALLTRIM(loc_cLote) + ;
5772:                                  " n" + CHR(227) + "o Existe !!", ;
5773:                                  "Aten" + CHR(231) + CHR(227) + "o!!!")
5774:                         loc_lOk = .F.
5775:                     ENDIF
5776:                     IF USED("cursor_4c_LoteTmp")
5777:                         USE IN cursor_4c_LoteTmp
5778:                     ENDIF
5779:                 ELSE
5780:                     MsgAviso("Lote N" + CHR(186) + " " + ALLTRIM(loc_cLote) + ;
5781:                              " n" + CHR(227) + "o Existe !!", ;
5782:                              "Aten" + CHR(231) + CHR(227) + "o!!!")
5783:                     loc_lOk = .F.
5784:                 ENDIF
5785:             ENDIF
5786: 
5787:         CATCH TO loc_oErro
5788:             MsgErro("Erro ao validar o n" + CHR(250) + "mero do lote:" + CHR(13) + ;
5789:                     loc_oErro.Message + CHR(13) + ;
5790:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5791:                     "Proc: " + loc_oErro.Procedure, "Erro ValidarLotesLostFocus")
5792:             loc_lOk = .F.
5793:         ENDTRY
5794: 
5795:         IF USED("cursor_4c_Itens")
5796:             SELECT cursor_4c_Itens
5797:         ENDIF
5798: 
5799:         RETURN loc_lOk
5800:     ENDPROC
5801: 
5802:     PROCEDURE ValidarVDescsLostFocus()
5803:         LOCAL loc_oPag, loc_nValor, loc_nOrig, loc_oErro
5804: 
5805:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5806: 
5807:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
5808:             RETURN .F.
5809:         ENDIF
5810: 
5811:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
5812:             RETURN .F.
5813:         ENDIF
5814: 
5815:         loc_nValor = loc_oPag.txt_4c_VDescs.Value
5816: 
5817:         IF VARTYPE(loc_nValor) <> "N" OR loc_nValor = 0
5818:             RETURN .F.
5819:         ENDIF
5820: 
5821:         TRY
5822:             SELECT cursor_4c_Itens
5823:             loc_nOrig = TratarNulo(cursor_4c_Itens.unitorigs, 0)
5824: 
5825:             IF loc_nOrig = 0
5826:                 loc_nOrig = TratarNulo(cursor_4c_Itens.units, 0)
5827:                 REPLACE unitorigs WITH loc_nOrig IN cursor_4c_Itens
5828:             ENDIF
5829: 
5830:             IF loc_nValor > 0
5831:                 REPLACE units WITH loc_nOrig - loc_nValor IN cursor_4c_Itens
5832:             ELSE
5833:                 REPLACE units WITH loc_nOrig + loc_nValor IN cursor_4c_Itens
5834:             ENDIF
5835: 
5836:         CATCH TO loc_oErro
5837:             MsgErro("Erro ao aplicar o desconto:" + CHR(13) + loc_oErro.Message + ;
5838:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5839:                     "Proc: " + loc_oErro.Procedure, "Erro ValidarVDescsLostFocus")
5840:         ENDTRY
5841: 
5842:         THIS.TotalizarLinha(.F.)
5843:         THIS.AtualizarPainelProduto()
5844: 
5845:         RETURN .T.
5846:     ENDPROC
5847: 
5848:     *==========================================================================
5849:     * ValidarPDescsLostFocus - Desconto em PERCENTUAL (getPDescs.Valid do
5850:     * legado):
5851:     *
5852:     *   If this.Value > 0
5853:     *       Replace Units With UnitOrigs - ((Abs(this.Value) * UnitOrigs) / 100)
5854:     *   Else
5855:     *       Replace Units With UnitOrigs + ((Abs(this.Value) * UnitOrigs) / 100)
5856:     *
5857:     * Formula TRANSCRITA do legado, com o ABS e a divisao por 100 na mesma
5858:     * ordem (regra #17).
5859:     *==========================================================================
5860:     PROCEDURE ValidarPDescsLostFocus()
5861:         LOCAL loc_oPag, loc_nPerc, loc_nOrig, loc_oErro
5862: 
5863:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5864: 
5865:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
5866:             RETURN .F.
5867:         ENDIF
5868: 
5869:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
5870:             RETURN .F.
5871:         ENDIF
5872: 
5873:         loc_nPerc = loc_oPag.txt_4c_PDescs.Value
5874: 
5875:         IF VARTYPE(loc_nPerc) <> "N" OR loc_nPerc = 0
5876:             RETURN .F.
5877:         ENDIF
5878: 
5879:         TRY
5880:             SELECT cursor_4c_Itens
5881:             loc_nOrig = TratarNulo(cursor_4c_Itens.unitorigs, 0)
5882: 
5883:             IF loc_nOrig = 0
5884:                 loc_nOrig = TratarNulo(cursor_4c_Itens.units, 0)
5885:                 REPLACE unitorigs WITH loc_nOrig IN cursor_4c_Itens
5886:             ENDIF
5887: 
5888:             IF loc_nPerc > 0
5889:                 REPLACE units WITH loc_nOrig - ((ABS(loc_nPerc) * loc_nOrig) / 100) ;
5890:                         IN cursor_4c_Itens
5891:             ELSE
5892:                 REPLACE units WITH loc_nOrig + ((ABS(loc_nPerc) * loc_nOrig) / 100) ;
5893:                         IN cursor_4c_Itens
5894:             ENDIF
5895: 
5896:         CATCH TO loc_oErro
5897:             MsgErro("Erro ao aplicar o desconto percentual:" + CHR(13) + ;
5898:                     loc_oErro.Message + CHR(13) + ;
5899:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5900:                     "Proc: " + loc_oErro.Procedure, "Erro ValidarPDescsLostFocus")
5901:         ENDTRY
5902: 
5903:         THIS.TotalizarLinha(.F.)
5904:         THIS.AtualizarPainelProduto()
5905: 
5906:         RETURN .T.
5907:     ENDPROC
5908: 
5909:     *==========================================================================
5910:     * ObsAbrirPainelClick - Abre o painel flutuante da observacao do item
5911:     * (getObs.Click do legado):
5912:     *
5913:     *   cntObs.Visible = .t. / cntObs.ZOrder(0) / cntObs.getObs.SetFocus
5914:     *
5915:     * O ZOrder(0) eh obrigatorio: o painel eh criado ANTES dos outros
5916:     * controles da pagina e sem ele ficaria POR BAIXO deles.
5917:     *
5918:     * Legado (getObs.When): so abre em INSERIR/ALTERAR e com produto na linha.
5919:     *==========================================================================
5920:     PROCEDURE ObsAbrirPainelClick()
5921:         LOCAL loc_oPag
5922: 
5923:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5924: 
5925:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
5926:             RETURN .F.
5927:         ENDIF
5928: 
5929:         IF !THIS.TemProdutoSelecionado()
5930:             RETURN .F.
5931:         ENDIF
5932: 
5933:         THIS.this_lWhenGetObs = .T.
5934: 
5935:         loc_oPag.cnt_4c_Obs.Visible = .T.
5936:         loc_oPag.cnt_4c_Obs.ZOrder(0)
5937:         loc_oPag.cnt_4c_Obs.obj_4c_GetObs.SetFocus()
5938: 
5939:         RETURN .T.
5940:     ENDPROC
5941: 
5942:     *==========================================================================
5943:     * ObsFecharPainelLostFocus - Fecha o painel flutuante (cntObs.getObs.
5944:     * LostFocus do legado: "cntObs.Visible = .f. / getObs.SetFocus").
5945:     *
5946:     * Reproduz tambem o getObs.Valid do legado, que recusa sair com a
5947:     * observacao em branco quando a operacao a torna obrigatoria
5948:     * (crSigCdOpe.ObsItems = 1).
5949:     *==========================================================================
5950:     PROCEDURE ObsFecharPainelLostFocus()
5951:         LOCAL loc_oPag, loc_cObs
5952: 
5953:         *-- Reentrancia: ja estamos fechando o painel (o SetFocus la embaixo
5954:         *-- redispara este mesmo LostFocus).
5955:         IF THIS.this_lFechandoObs
5956:             RETURN .F.
5957:         ENDIF
5958: 
5959:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5960:         loc_cObs = ALLTRIM(TratarNulo(loc_oPag.cnt_4c_Obs.obj_4c_GetObs.Value, ""))
5961: 
5962:         IF THIS.this_lWhenGetObs AND EMPTY(loc_cObs) AND THIS.this_nObsItems = 1
5963:             MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Preenchimento da " + ;
5964:                      "Observa" + CHR(231) + CHR(227) + "o Para Cada Produto ... ", ;
5965:                      "Observa" + CHR(231) + CHR(227) + "o do Item Obrigat" + ;
5966:                      CHR(243) + "ria")
5967:             RETURN .F.
5968:         ENDIF
5969: 
5970:         THIS.this_lWhenGetObs = .F.
5971: 
5972:         loc_oPag.cnt_4c_Obs.Visible = .F.
5973: 
5974:         *-- Tirar o foco do EditBox do painel dispara o LostFocus dele, que eh
5975:         *-- ESTE metodo: sem a guarda a chamada se aninha indefinidamente.
5976:         IF loc_oPag.obj_4c_GetObs.Visible AND loc_oPag.obj_4c_GetObs.Enabled
5977:             THIS.this_lFechandoObs = .T.
5978:             loc_oPag.obj_4c_GetObs.SetFocus()
5979:             THIS.this_lFechandoObs = .F.
5980:         ENDIF
5981: 
5982:         THIS.RepintarGradeItens()
5983: 
5984:         RETURN .T.
5985:     ENDPROC
5986: 
5987:     *==========================================================================
5988:     * ImgProdsDblClick - Zoom da foto do produto (imgProds.DblClick do legado,
5989:     * cuja dica de uso esta no proprio ToolTipText: "[Duplo Click Para Zoom]").
5990:     * O legado grava a foto em arquivo temporario e abre a tela de zoom; aqui o
5991:     * arquivo ja foi gravado por CarregarImagemProduto e eh ele que vai para o
5992:     * visualizador de imagem do sistema operacional.
5993:     *==========================================================================
5994:     PROCEDURE ImgProdsDblClick()
5995:         LOCAL loc_oImg, loc_cArquivo, loc_oErro
5996: 
5997:         loc_oImg     = THIS.pgf_4c_Paginas.Page1.img_4c_ImgProds
5998:         loc_cArquivo = ALLTRIM(loc_oImg.Picture)
5999: 
6000:         IF EMPTY(loc_cArquivo) OR !FILE(loc_cArquivo)
6001:             MsgAviso("Produto sem imagem cadastrada.", "Imagem do Produto")
6002:             RETURN .F.
6003:         ENDIF
6004: 
6005:         TRY
6006:             RUN /N2 EXPLORER.EXE (loc_cArquivo)
6007:         CATCH TO loc_oErro
6008:             MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a " + ;
6009:                      "imagem do produto.", "Imagem do Produto")
6010:         ENDTRY
6011: 
6012:         RETURN .T.
6013:     ENDPROC
6014: 
6015:     *==========================================================================
6016:     * KeyPress - Teclas de atalho da tela. Legado (SIGOPPRO.KeyPress):
6017:     *
6018:     *   LPARAMETERS nKeyCode, nShiftAltCtrl
6019:     *   If nKeyCode = -4 And ThisForm.btnPBuscas.Enabled    && F5
6020:     *       NoDefault
6021:     *       ThisForm.btnPBuscas.Click()
6022:     *   EndIf
6023:     *
6024:     * KeyPreview = .T. na classe faz o evento chegar aqui antes do controle
6025:     * com foco. -4 eh o codigo do F5 em KeyPress de FORM.
6026:     *==========================================================================
6027:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
6028:         IF par_nKeyCode = -4
6029:             IF THIS.cnt_4c_BotoesAcao.cmd_4c_BtnPBuscas.Enabled
6030:                 NODEFAULT
6031:                 THIS.BtnPBuscasClick()
6032:                 RETURN
6033:             ENDIF
6034:         ENDIF
6035: 
6036:         DODEFAULT(par_nKeyCode, par_nShiftAltCtrl)
6037:     ENDPROC
6038: 
6039:     *==========================================================================
6040:     * HabilitarCampos - Liga/desliga os campos digitaveis conforme o modo.
6041:     *
6042:     * No legado cada campo decide sozinho pelo When(): a maioria retorna .F.
6043:     * (exibicao pura) e os digitaveis retornam
6044:     * "InList(Op_Escolha,'INSERIR','ALTERAR')" combinado com a configuracao da
6045:     * operacao - getDPros exige AltDescs = 1 (ou descricao comecando por "."),
6046:     * getDocs exige EditDocs, getLotes exige Ctrllotes = 2, getVDescs/getPDescs
6047:     * exigem Confes # 1. A pagina Fiscal inteira so eh habilitada quando o
6048:     * usuario pede alteracao de impostos (btnAltImps.Click faz
6049:     * "pgFiscs.Enabled = .t.").
6050:     *
6051:     * Os campos de EXIBICAO ficam de fora: eles nasceram ReadOnly = .T. e
6052:     * continuam assim em qualquer modo, como no legado.
6053:     *
6054:     * PUBLIC: o form pai troca o modo de fora (Op_Escolha vem dele).
6055:     *==========================================================================
6056:     PROCEDURE HabilitarCampos(par_lHabilitar)
6057:         LOCAL loc_lEdita, loc_oPag
6058: 
6059:         loc_lEdita = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, ;
6060:                          INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR"))
6061: 
6062:         *-- Page1 (pgProds) ------------------------------------------------
6063:         loc_oPag = THIS.pgf_4c_Paginas.Page1
6064:         WITH loc_oPag
6065:             *-- getDPros: legado exige AltDescs = 1 OU descricao iniciada
6066:             *-- por "." (produto de descricao livre)
6067:             .txt_4c_DPros.ReadOnly = !(loc_lEdita AND THIS.PodeEditarDescricao())
6068: 
6069:             .txt_4c_Docs.ReadOnly   = !loc_lEdita
6070:             .txt_4c_Lotes.ReadOnly  = !loc_lEdita
6071:             .txt_4c_VDescs.ReadOnly = !loc_lEdita
6072:             .txt_4c_PDescs.ReadOnly = !loc_lEdita
6073:             .txt_4c_MoeVs.ReadOnly  = !loc_lEdita
6074:             .txt_4c_CodCors.ReadOnly = !loc_lEdita
6075:             .txt_4c_CodTams.ReadOnly = !loc_lEdita
6076: 
6077:             .obj_4c_GetObs.ReadOnly              = !loc_lEdita
6078:             .cnt_4c_Obs.obj_4c_GetObs.ReadOnly   = !loc_lEdita
6079: 
6080:             *-- Conferencia por codigo: o legado habilita o campo de
6081:             *-- quantidade apenas com o codigo preenchido (get_qtd.When =
6082:             *-- "Return (Not Empty(Get_prod.Value))")
6083:             .txt_4c__prod.Enabled = loc_lEdita
6084:             .txt_4c__qtd.Enabled  = loc_lEdita AND ;
6085:                                     !EMPTY(ALLTRIM(.txt_4c__prod.Value))
6086: 
6087:             *-- A procura na grade funciona em qualquer modo (getBusca.When =
6088:             *-- "Return .t." no legado)
6089:             .txt_4c_Busca.Enabled = .T.
6090:         ENDWITH
6091: 
6092:         *-- Page3 (pgFiscs): habilitada so em alteracao de impostos --------
6093:         THIS.pgf_4c_Paginas.Page3.Enabled = loc_lEdita AND ;
6094:                                             (THIS.cnt_4c_Botoes.chk_4c_BtnVerImps.Value = 1)
6095: 
6096:         WITH THIS.pgf_4c_Paginas.Page3.cnt_4c_Item

*-- Linhas 6145 a 6222:
6145:     * cursor e APAGARIA o item da linha corrente. Quem limpa a LINHA eh
6146:     * LimparLinhaGrade().
6147:     *==========================================================================
6148:     PROTECTED PROCEDURE LimparCampos()
6149:         LOCAL loc_oPag
6150: 
6151:         loc_oPag = THIS.pgf_4c_Paginas.Page1
6152: 
6153:         WITH loc_oPag
6154:             .txt_4c__prod.Value  = ""
6155:             .txt_4c__qtd.Value   = 0
6156:             .txt_4c_Busca.Value  = ""
6157:             .obj_4c_Opt_Busca.Value = 1
6158:             .cnt_4c_Obs.Visible  = .F.
6159:         ENDWITH
6160: 
6161:         THIS.this_nBarra      = 0
6162:         THIS.this_lProcuraCB  = .F.
6163:         THIS.this_lWhenGetObs = .F.
6164:         THIS.this_cAntCPro    = ""
6165: 
6166:         THIS.LimparPainelProduto()
6167:     ENDPROC
6168: 
6169:     *==========================================================================
6170:     * CarregarLista - FUNIL de (re)carga da lista desta tela. A "lista" do
6171:     * SIGOPPRO eh a grade de itens da movimentacao (fwGrade no legado): nao ha
6172:     * Page1=Lista / Page2=Dados como nos cadastros CRUD.
6173:     *
6174:     * Delega a CarregarDados(), que eh quem consulta o BO, recarrega
6175:     * cursor_4c_Itens por ZAP/APPEND (sem derrubar o binding da grade),
6176:     * entrega a linha de digitacao em INSERIR/ALTERAR, repinta e reajusta os
6177:     * botoes. Depois disso atualiza o painel do item corrente.
6178:     *
6179:     * PUBLIC: o harness de teste e o form pai chamam THIS.CarregarLista() de
6180:     * FORA da classe; PROTECTED aqui estouraria em runtime (regra #3).
6181:     *==========================================================================
6182:     PROCEDURE CarregarLista()
6183:         LOCAL loc_lSucesso
6184: 
6185:         loc_lSucesso = THIS.CarregarDados()
6186: 
6187:         THIS.AtualizarPainelProduto()
6188:         THIS.HabilitarCampos(INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR"))
6189: 
6190:         RETURN loc_lSucesso
6191:     ENDPROC
6192: 
6193:     *==========================================================================
6194:     * FormParaBO - Transfere a LINHA CORRENTE da grade para as properties do
6195:     * sigopproBO, cobrindo TODAS as colunas de SigMvItn que o cursor carrega.
6196:     *
6197:     * O painel de Page1/Page3 eh uma VISTA da linha: os campos digitaveis tem
6198:     * ControlSource sobre cursor_4c_Itens, logo o que o usuario digitou ja esta
6199:     * no cursor quando este metodo roda - ler do cursor eh ler da tela, e eh
6200:     * tambem o que o legado faz (ele grava o cursor inteiro com TABLEUPDATE).
6201:     *
6202:     * Os campos de EXIBICAO (preco atual, saldo, resta, referencia, grupo de
6203:     * venda, peso medio, classificacao fiscal) NAO entram: nao sao coluna de
6204:     * SigMvItn - vem de SigCdPro/SigMvEst/SigCdClf e seriam gravados em
6205:     * coluna que nao existe.
6206:     *
6207:     * Devolve .T. quando havia linha para transferir.
6208:     *==========================================================================
6209:     PROTECTED FUNCTION FormParaBO()
6210:         LOCAL loc_lOk, loc_oBO, loc_oErro
6211: 
6212:         loc_lOk = .F.
6213: 
6214:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
6215:             RETURN .F.
6216:         ENDIF
6217: 
6218:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
6219:             RETURN .F.
6220:         ENDIF
6221: 
6222:         loc_oBO = THIS.this_oBusinessObject

*-- Linhas 6256 a 6317:
6256:             MsgErro("Erro ao transferir o item para o objeto de neg" + CHR(243) + ;
6257:                     "cio:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
6258:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
6259:                     "Proc: " + loc_oErro.Procedure, "Erro FormParaBO")
6260:         ENDTRY
6261: 
6262:         RETURN loc_lOk
6263:     ENDFUNC
6264: 
6265:     *==========================================================================
6266:     * BOParaForm - Caminho inverso de FormParaBO: leva as properties do
6267:     * sigopproBO para a linha da grade e, por consequencia, para o painel de
6268:     * Page1/Page3 (que esta ligado ao cursor por ControlSource).
6269:     *
6270:     * Posiciona PRIMEIRO na linha do item que esta no BO (citens): sem isso a
6271:     * gravacao cairia na linha errada e sobrescreveria outro item - o cursor
6272:     * nao acompanha o BO sozinho.
6273:     *
6274:     * Fecha atualizando o painel de exibicao e repintando a grade: popular o
6275:     * cursor NAO repinta a grade (regra #21).
6276:     *==========================================================================
6277:     PROTECTED PROCEDURE BOParaForm()
6278:         LOCAL loc_oBO, loc_lOk, loc_oErro
6279: 
6280:         loc_lOk = .F.
6281: 
6282:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
6283:             RETURN .F.
6284:         ENDIF
6285: 
6286:         IF !USED("cursor_4c_Itens")
6287:             RETURN .F.
6288:         ENDIF
6289: 
6290:         loc_oBO = THIS.this_oBusinessObject
6291: 
6292:         TRY
6293:             SELECT cursor_4c_Itens
6294: 
6295:             *-- Casa a linha pelo numero do item; sem numero, usa a corrente.
6296:             IF loc_oBO.this_nCitens <> 0
6297:                 LOCATE FOR cursor_4c_Itens.citens = loc_oBO.this_nCitens
6298:                 IF !FOUND()
6299:                     GO TOP
6300:                 ENDIF
6301:             ENDIF
6302: 
6303:             IF !EOF("cursor_4c_Itens")
6304:                 REPLACE cidchaves  WITH loc_oBO.this_cCidchaves, ;
6305:                         citens     WITH loc_oBO.this_nCitens, ;
6306:                         citem2     WITH loc_oBO.this_nCitem2, ;
6307:                         cpros      WITH loc_oBO.this_cCpros, ;
6308:                         cpro2s     WITH loc_oBO.this_cCpro2s, ;
6309:                         dpros      WITH loc_oBO.this_cDpros, ;
6310:                         codbarras  WITH loc_oBO.this_nCodbarras, ;
6311:                         barraref   WITH loc_oBO.this_nBarraref, ;
6312:                         cunis      WITH loc_oBO.this_cCunis, ;
6313:                         cunips     WITH loc_oBO.this_cCunips, ;
6314:                         fators     WITH loc_oBO.this_nFators, ;
6315:                         opers      WITH loc_oBO.this_cOpers IN cursor_4c_Itens
6316: 
6317:                 REPLACE qtds       WITH loc_oBO.this_nQtds, ;

*-- Linhas 6449 a 6488:
6449:             MsgErro("Erro ao trazer o item do objeto de neg" + CHR(243) + "cio:" + ;
6450:                     CHR(13) + loc_oErro.Message + CHR(13) + ;
6451:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
6452:                     "Proc: " + loc_oErro.Procedure, "Erro BOParaForm")
6453:         ENDTRY
6454: 
6455:         IF loc_lOk
6456:             *-- Popular o cursor NAO repinta a grade nem os campos ligados a
6457:             *-- ele por ControlSource (regra #21): o Refresh das paginas eh o
6458:             *-- que faz o painel mostrar o que acabou de ser gravado na linha.
6459:             THIS.RepintarGradeItens()
6460:             THIS.pgf_4c_Paginas.Page1.Refresh()
6461:             THIS.pgf_4c_Paginas.Page3.Refresh()
6462:             THIS.AtualizarPainelProduto()
6463:         ENDIF
6464: 
6465:         RETURN loc_lOk
6466:     ENDPROC
6467: 
6468:     *==========================================================================
6469:     * BtnCancelarClick - Caminho de ESC/Cancelar da tela.
6470:     *
6471:     * No SCX legado o botao de saida eh OK.btnSair, Caption "Retornar", com
6472:     * Command1.Cancel = .T. - isto eh: Encerrar e Cancelar sao o MESMO botao,
6473:     * e ESC cai nele. Nao existe no legado um "Cancelar" que descarte
6474:     * alteracoes (quem grava ou descarta a movimentacao eh o form PAI, na
6475:     * confirmacao da operacao), entao inventar um aqui mudaria o
6476:     * comportamento da tela.
6477:     *
6478:     * Por isso este handler delega ao funil de saida, que valida os itens,
6479:     * reabilita o form pai e fecha.
6480:     *
6481:     * PUBLIC: eh o nome que o harness de teste chama de FORA da classe
6482:     * (regra #3).
6483:     *==========================================================================
6484:     PROCEDURE BtnCancelarClick()
6485:         RETURN THIS.BtnEncerrarClick()
6486:     ENDPROC
6487: 
6488: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopproBO.prg):
*====================================================================
* sigopproBO.prg
*
* Business Object para o painel de Produtos (FormSigOpPro)
* Form OPERACIONAL embutido na tela de Movimentacao (Entrada/Saida)
* Entidade principal: Item de Movimentacao - tabela SigMvItn
* Cursor de trabalho repassado pelo form pai: crTpmMvItn/TprMvCab
* Chave primaria: cidchaves char(20)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigopproBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigMvItn)
    this_nAqtds              = 0     && aqtds numeric(9,3)
    this_nCitens             = 0     && citens numeric(10,0)
    this_nCodbarras          = 0     && codbarras numeric(14,0)
    this_cCpros              = ""    && cpros char(14)
    this_cCunis              = ""    && cunis char(3)
    this_dDatatrans          = {}    && datatrans datetime NULL
    this_nDescvals           = 0     && descvals numeric(7,2)
    this_cDopes              = ""    && dopes char(20)
    this_cDpros              = ""    && dpros char(65)
    this_cEmps               = ""    && emps char(3)
    this_lEtiesps            = .F.   && etiesps bit
    this_nFators             = 0     && fators numeric(8,3)
    this_nFatvals            = 0     && fatvals numeric(15,6)
    this_lFvals              = .F.   && fvals bit
    this_lIconfs             = .F.   && iconfs bit
    this_cLocals             = ""    && locals char(10)
    this_cMoedas             = ""    && moedas char(3)
    this_cMoefats            = ""    && moefats char(3)
    this_nMoevals            = 0     && moevals numeric(15,6)
    this_cNotas              = ""    && notas char(6)
    this_cNrcons             = ""    && nrcons char(10)
    this_nNtrans             = 0     && ntrans numeric(6,0)
    this_nNumes              = 0     && numes numeric(6,0)
    this_nNumolds            = 0     && numolds numeric(6,0)
    this_cObs                = ""    && obs text NULL
    this_cOpers              = ""    && opers char(1)
    this_nPesos              = 0     && pesos numeric(9,3)
    this_nQtbaixas           = 0     && qtbaixas numeric(9,3)
    this_nQtbxprods          = 0     && qtbxprods numeric(9,3)
    this_nQtds               = 0     && qtds numeric(9,3)
    this_nQtprods            = 0     && qtprods numeric(9,3)
    this_nTotas              = 0     && totas numeric(11,2)
    this_nTpesos             = 0     && tpesos numeric(11,2)
    this_nUnitembs           = 0     && unitembs numeric(11,4)
    this_nUnits              = 0     && units numeric(15,6)
    this_nUnivals            = 0     && univals numeric(15,6)
    this_nVcoms              = 0     && vcoms numeric(8,2)
    this_nAliqs              = 0     && aliqs numeric(4,2)
    this_cSitribs            = ""    && sitribs char(2)
    this_cTpipis             = ""    && tpipis char(1)
    this_nValipis            = 0     && valipis numeric(11,2)
    this_nAliqicms           = 0     && aliqicms numeric(5,2)
    this_nValdescs           = 0     && valdescs numeric(9,2)
    this_cEmpos              = ""    && empos char(3)
    this_cMoevs              = ""    && moevs char(3)
    this_nUtilizas            = 0     && utilizas numeric(4,0)
    this_nNcodigos           = 0     && ncodigos numeric(10,0)
    this_nQtreservas         = 0     && qtreservas numeric(9,3)
    this_cCidchaves          = ""    && cidchaves char(20) - PK
    this_nNlotes             = 0     && nlotes numeric(10,0)
    this_dDtalts             = {}    && dtalts datetime NULL
    this_cEmpdopnums         = ""    && empdopnums char(29)
    this_nBaseicms           = 0     && baseicms numeric(11,2)
    this_lChksubn            = .F.   && chksubn bit
    this_nUnit2s             = 0     && unit2s numeric(15,6)
    this_cUsulibs            = ""    && usulibs char(10)
    this_nValrats            = 0     && valrats numeric(14,6)
    this_nCodlprecs          = 0     && codlprecs numeric(6,0)
    this_cCunips             = ""    && cunips char(3)
    this_cMotdscs            = ""    && motdscs char(10)
    this_cTipos              = ""    && tipos char(1)
    this_nUnitinfs           = 0     && unitinfs numeric(14,6)
    this_cCpro2s             = ""    && cpro2s char(50)
    this_cAbrevis            = ""    && abrevis char(3)
    this_nBcicmss            = 0     && bcicmss numeric(15,2)
    this_nBcipis             = 0     && bcipis numeric(15,2)
    this_nIcms               = 0     && icms numeric(15,2)
    this_nIcmss              = 0     && icmss numeric(15,2)
    this_nPdescs             = 0     && pdescs numeric(5,2)
    this_nNchvtbds           = 0     && nchvtbds numeric(6,0)
    this_nIdpro              = 0     && idpro numeric(10,0)
    this_nUnitorigs          = 0     && unitorigs numeric(14,6)
    this_cOrigmercs          = ""    && origmercs char(1)
    this_nBaseicm2s          = 0     && baseicm2s numeric(11,2)
    this_nBaseicm3s          = 0     && baseicm3s numeric(11,2)
    this_nBaseipi2s          = 0     && baseipi2s numeric(11,2)
    this_nBaseipi3s          = 0     && baseipi3s numeric(11,2)
    this_cCfops              = ""    && cfops char(10)
    this_nRatdacs            = 0     && ratdacs numeric(11,2)
    this_nRatfrts            = 0     && ratfrts numeric(11,2)
    this_nRaticmds           = 0     && raticmds numeric(11,2)
    this_nRaticms            = 0     && raticms numeric(11,2)
    this_nRatsegs            = 0     && ratsegs numeric(11,2)
    this_cSittricms          = ""    && sittricms char(3)
    this_nAliqiis            = 0     && aliqiis numeric(4,2)
    this_nCitem2             = 0     && citem2 numeric(10,0)
    this_nTaxaiis            = 0     && taxaiis numeric(11,2)
    this_nVcofins            = 0     && vcofins numeric(11,2)
    this_nVpis               = 0     && vpis numeric(11,2)
    this_nAliqorigs          = 0     && aliqorigs numeric(4,2)
    this_lLcancelas          = .F.   && lcancelas bit
    this_nCompris            = 0     && compris numeric(6,2)
    this_cCodfabs            = ""    && codfabs char(60)
    this_nNadis              = 0     && nadis numeric(3,0)
    this_nNiadis             = 0     && niadis numeric(3,0)
    this_nAliqcofs           = 0     && aliqcofs numeric(4,2)
    this_nAliqpis            = 0     && aliqpis numeric(4,2)
    this_nCssl               = 0     && cssl numeric(11,2)
    this_nInss               = 0     && inss numeric(11,2)
    this_nIrrf               = 0     && irrf numeric(11,2)
    this_nIss                = 0     && iss numeric(11,2)
    this_nValbases           = 0     && valbases numeric(11,2)
    this_cLocalos            = ""    && localos char(10)
    this_nPfcpst             = 0     && pfcpst numeric(5,2)
    this_nVfcpst             = 0     && vfcpst numeric(11,2)
    this_cOb2s               = ""    && ob2s char(100)
    this_cPedidoweb          = ""    && pedidoweb char(50)
    this_nQtresres           = 0     && qtresres numeric(9,3)
    this_nBarraref           = 0     && barraref numeric(14,0)
    this_cItemped            = ""    && itemped char(4)
    this_cNumeronota         = ""    && numeronota char(10)
    this_cDopesorig          = ""    && dopesorig char(20)
    this_cChaveexterna       = ""    && chaveexterna char(33)
    this_nCkpresente         = 0     && ckpresente numeric(1,0)
    this_cGravacao           = ""    && gravacao char(20)
    this_cIfors              = ""    && ifors char(10)
    this_cPropriedades       = ""    && propriedades nvarchar(40) NULL
    this_cUnidade1           = ""    && unidade1 nvarchar(15) NULL
    this_cResultado1         = ""    && resultado1 nvarchar(15) NULL
    this_cValorMinimo        = ""    && valorMinimo nvarchar(15) NULL
    this_cValorMaximo        = ""    && valorMaximo nvarchar(15) NULL
    this_cMetodoReferencia1  = ""    && metodoReferencia1 nvarchar(15) NULL

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvItn"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "sigopproBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia uma linha de SigMvItn (cursor populado
    * por SQLEXEC) para as properties da entidade. NAO e PROTECTED
    * (regra #51 - BusinessBase declara publico).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_nAqtds        = TratarNulo(aqtds, 0)
            THIS.this_nCitens       = TratarNulo(citens, 0)
            THIS.this_nCodbarras    = TratarNulo(codbarras, 0)
            THIS.this_cCpros        = TratarNulo(cpros, "")
            THIS.this_cCunis        = TratarNulo(cunis, "")
            THIS.this_dDatatrans    = TratarNulo(datatrans, {})
            THIS.this_nDescvals     = TratarNulo(descvals, 0)
            THIS.this_cDopes        = TratarNulo(dopes, "")
            THIS.this_cDpros        = TratarNulo(dpros, "")
            THIS.this_cEmps         = TratarNulo(emps, "")
            THIS.this_lEtiesps      = IIF(VARTYPE(etiesps) = "L", etiesps, (NVL(etiesps, 0) = 1))
            THIS.this_nFators       = TratarNulo(fators, 0)
            THIS.this_nFatvals      = TratarNulo(fatvals, 0)
            THIS.this_lFvals        = IIF(VARTYPE(fvals) = "L", fvals, (NVL(fvals, 0) = 1))
            THIS.this_lIconfs       = IIF(VARTYPE(iconfs) = "L", iconfs, (NVL(iconfs, 0) = 1))
            THIS.this_cLocals       = TratarNulo(locals, "")
            THIS.this_cMoedas       = TratarNulo(moedas, "")
            THIS.this_cMoefats      = TratarNulo(moefats, "")
            THIS.this_nMoevals      = TratarNulo(moevals, 0)
            THIS.this_cNotas        = TratarNulo(notas, "")
            THIS.this_cNrcons       = TratarNulo(nrcons, "")
            THIS.this_nNtrans       = TratarNulo(ntrans, 0)
            THIS.this_nNumes        = TratarNulo(numes, 0)
            THIS.this_nNumolds      = TratarNulo(numolds, 0)
            THIS.this_cObs          = TratarNulo(obs, "")
            THIS.this_cOpers        = TratarNulo(opers, "")
            THIS.this_nPesos        = TratarNulo(pesos, 0)
            THIS.this_nQtbaixas     = TratarNulo(qtbaixas, 0)
            THIS.this_nQtbxprods    = TratarNulo(qtbxprods, 0)
            THIS.this_nQtds         = TratarNulo(qtds, 0)
            THIS.this_nQtprods      = TratarNulo(qtprods, 0)
            THIS.this_nTotas        = TratarNulo(totas, 0)
            THIS.this_nTpesos       = TratarNulo(tpesos, 0)
            THIS.this_nUnitembs     = TratarNulo(unitembs, 0)
            THIS.this_nUnits        = TratarNulo(units, 0)
            THIS.this_nUnivals      = TratarNulo(univals, 0)
            THIS.this_nVcoms        = TratarNulo(vcoms, 0)
            THIS.this_nAliqs        = TratarNulo(aliqs, 0)
            THIS.this_cSitribs      = TratarNulo(sitribs, "")
            THIS.this_cTpipis       = TratarNulo(tpipis, "")
            THIS.this_nValipis      = TratarNulo(valipis, 0)
            THIS.this_nAliqicms     = TratarNulo(aliqicms, 0)
            THIS.this_nValdescs     = TratarNulo(valdescs, 0)
            THIS.this_cEmpos        = TratarNulo(empos, "")
            THIS.this_cMoevs        = TratarNulo(moevs, "")
            THIS.this_nUtilizas     = TratarNulo(utilizas, 0)
            THIS.this_nNcodigos     = TratarNulo(ncodigos, 0)
            THIS.this_nQtreservas   = TratarNulo(qtreservas, 0)
            THIS.this_cCidchaves    = TratarNulo(cidchaves, "")
            THIS.this_nNlotes       = TratarNulo(nlotes, 0)
            THIS.this_dDtalts       = TratarNulo(dtalts, {})
            THIS.this_cEmpdopnums   = TratarNulo(empdopnums, "")
            THIS.this_nBaseicms     = TratarNulo(baseicms, 0)
            THIS.this_lChksubn      = IIF(VARTYPE(chksubn) = "L", chksubn, (NVL(chksubn, 0) = 1))
            THIS.this_nUnit2s       = TratarNulo(unit2s, 0)
            THIS.this_cUsulibs      = TratarNulo(usulibs, "")
            THIS.this_nValrats      = TratarNulo(valrats, 0)
            THIS.this_nCodlprecs    = TratarNulo(codlprecs, 0)
            THIS.this_cCunips       = TratarNulo(cunips, "")
            THIS.this_cMotdscs      = TratarNulo(motdscs, "")
            THIS.this_cTipos        = TratarNulo(tipos, "")
            THIS.this_nUnitinfs     = TratarNulo(unitinfs, 0)
            THIS.this_cCpro2s       = TratarNulo(cpro2s, "")
            THIS.this_cAbrevis      = TratarNulo(abrevis, "")
            THIS.this_nBcicmss      = TratarNulo(bcicmss, 0)
            THIS.this_nBcipis       = TratarNulo(bcipis, 0)
            THIS.this_nIcms         = TratarNulo(icms, 0)
            THIS.this_nIcmss        = TratarNulo(icmss, 0)
            THIS.this_nPdescs       = TratarNulo(pdescs, 0)
            THIS.this_nNchvtbds     = TratarNulo(nchvtbds, 0)
            THIS.this_nIdpro        = TratarNulo(idpro, 0)
            THIS.this_nUnitorigs    = TratarNulo(unitorigs, 0)
            THIS.this_cOrigmercs    = TratarNulo(origmercs, "")
            THIS.this_nBaseicm2s    = TratarNulo(baseicm2s, 0)
            THIS.this_nBaseicm3s    = TratarNulo(baseicm3s, 0)
            THIS.this_nBaseipi2s    = TratarNulo(baseipi2s, 0)
            THIS.this_nBaseipi3s    = TratarNulo(baseipi3s, 0)
            THIS.this_cCfops        = TratarNulo(cfops, "")
            THIS.this_nRatdacs      = TratarNulo(ratdacs, 0)
            THIS.this_nRatfrts      = TratarNulo(ratfrts, 0)
            THIS.this_nRaticmds     = TratarNulo(raticmds, 0)
            THIS.this_nRaticms      = TratarNulo(raticms, 0)
            THIS.this_nRatsegs      = TratarNulo(ratsegs, 0)
            THIS.this_cSittricms    = TratarNulo(sittricms, "")
            THIS.this_nAliqiis      = TratarNulo(aliqiis, 0)
            THIS.this_nCitem2       = TratarNulo(citem2, 0)
            THIS.this_nTaxaiis      = TratarNulo(taxaiis, 0)
            THIS.this_nVcofins      = TratarNulo(vcofins, 0)
            THIS.this_nVpis         = TratarNulo(vpis, 0)
            THIS.this_nAliqorigs    = TratarNulo(aliqorigs, 0)
            THIS.this_lLcancelas    = IIF(VARTYPE(lcancelas) = "L", lcancelas, (NVL(lcancelas, 0) = 1))
            THIS.this_nCompris      = TratarNulo(compris, 0)
            THIS.this_cCodfabs      = TratarNulo(codfabs, "")
            THIS.this_nNadis        = TratarNulo(nadis, 0)
            THIS.this_nNiadis       = TratarNulo(niadis, 0)
            THIS.this_nAliqcofs     = TratarNulo(aliqcofs, 0)
            THIS.this_nAliqpis      = TratarNulo(aliqpis, 0)
            THIS.this_nCssl         = TratarNulo(cssl, 0)
            THIS.this_nInss         = TratarNulo(inss, 0)
            THIS.this_nIrrf         = TratarNulo(irrf, 0)
            THIS.this_nIss          = TratarNulo(iss, 0)
            THIS.this_nValbases     = TratarNulo(valbases, 0)
            THIS.this_cLocalos      = TratarNulo(localos, "")
            THIS.this_nPfcpst       = TratarNulo(pfcpst, 0)
            THIS.this_nVfcpst       = TratarNulo(vfcpst, 0)
            THIS.this_cOb2s         = TratarNulo(ob2s, "")
            THIS.this_cPedidoweb    = TratarNulo(pedidoweb, "")
            THIS.this_nQtresres     = TratarNulo(qtresres, 0)
            THIS.this_nBarraref     = TratarNulo(barraref, 0)
            THIS.this_cItemped      = TratarNulo(itemped, "")
            THIS.this_cNumeronota   = TratarNulo(numeronota, "")
            THIS.this_cDopesorig    = TratarNulo(dopesorig, "")
            THIS.this_cChaveexterna = TratarNulo(chaveexterna, "")
            THIS.this_nCkpresente   = TratarNulo(ckpresente, 0)
            THIS.this_cGravacao     = TratarNulo(gravacao, "")
            THIS.this_cIfors        = TratarNulo(ifors, "")
            THIS.this_cPropriedades       = TratarNulo(propriedades, "")
            THIS.this_cUnidade1           = TratarNulo(unidade1, "")
            THIS.this_cResultado1         = TratarNulo(resultado1, "")
            THIS.this_cValorMinimo        = TratarNulo(valorMinimo, "")
            THIS.this_cValorMaximo        = TratarNulo(valorMaximo, "")
            THIS.this_cMetodoReferencia1  = TratarNulo(metodoReferencia1, "")

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * MontarChaveEmpDopNums - Monta a chave POSICIONAL empdopnums
    * char(29), igual ao legado (SIGMVSBN: Emps + Dopes + Str(Numes,6)).
    * Regra #42: o padding FAZ PARTE da chave - PADR explicito nas
    * partes (Emps char(3) + Dopes char(20) + 6 = 29). ALLTRIM nas
    * partes encurta a chave, ela nunca casa e o SELECT devolve ZERO
    * linhas em silencio.
    *====================================================================
    FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        LOCAL loc_cEmps, loc_cDopes, loc_nNumes

        loc_cEmps  = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
        loc_cDopes = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
        loc_nNumes = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)

        RETURN PADR(loc_cEmps, 3) + PADR(loc_cDopes, 20) + STR(loc_nNumes, 6)
    ENDFUNC

    *====================================================================
    * CarregarItens - Le os itens de UMA movimentacao (empdopnums) para
    * um cursor TEMPORARIO. Equivale ao AddCursor('SigMvItn', ...) que o
    * legado herda do form pai de Movimentacao.
    *
    * NUNCA faz SQLEXEC sobre o alias ligado a grade: isso FECHA e RECRIA
    * o alias, zera o ColumnCount e a grade vira um retangulo branco
    * (sem erro e sem log). O chamador recarrega o alias da grade com
    * SELECT/ZAP/APPEND FROM DBF() a partir deste cursor temporario.
    *
    * par_cEmpDopNums - chave char(29) da movimentacao (ver
    *                   MontarChaveEmpDopNums)
    * par_cCursorTmp  - alias do cursor temporario de destino
    *====================================================================
    FUNCTION CarregarItens(par_cEmpDopNums, par_cCursorTmp)
        LOCAL loc_cSQL, loc_cCursor, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor  = IIF(VARTYPE(par_cCursorTmp) = "C" AND !EMPTY(par_cCursorTmp), ;
                           ALLTRIM(par_cCursorTmp), "cursor_4c_ItensTmp")

        IF VARTYPE(par_cEmpDopNums) <> "C" OR EMPTY(par_cEmpDopNums)
            THIS.this_cMensagemErro = "Chave da movimenta" + CHR(231) + CHR(227) + ;
                                      "o n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco n" + ;
                                      CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            *-- Alias do cursor temporario fechado antes do SQLEXEC; o guard
            *-- testa o BUFFERING, nunca so o USED (regra #52).
            IF USED(loc_cCursor)
                IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                    TABLEREVERT(.T., loc_cCursor)
                ENDIF
                USE IN (loc_cCursor)
            ENDIF

            *-- Lista de colunas EXPLICITA e identica a do CREATE CURSOR do
            *-- form: o APPEND FROM DBF() casa os campos por NOME.
            loc_cSQL = "SELECT aqtds, citens, codbarras, cpros, cunis," + ;
                       " datatrans, descvals, dopes, dpros, emps," + ;
                       " etiesps, fators, fatvals, fvals, iconfs," + ;
                       " locals, moedas, moefats, moevals, notas," + ;
                       " nrcons, ntrans, numes, numolds, obs," + ;
                       " opers, pesos, qtbaixas, qtbxprods, qtds," + ;
                       " qtprods, totas, tpesos, unitembs, units," + ;
                       " univals, vcoms, aliqs, sitribs, tpipis," + ;
                       " valipis, aliqicms, valdescs, empos, moevs," + ;
                       " utilizas, ncodigos, qtreservas, cidchaves, nlotes," + ;
                       " dtalts, empdopnums, baseicms, chksubn, unit2s," + ;
                       " usulibs, valrats, codlprecs, cunips, motdscs," + ;
                       " tipos, unitinfs, cpro2s, abrevis, bcicmss," + ;
                       " bcipis, icms, icmss, pdescs, nchvtbds," + ;
                       " idpro, unitorigs, origmercs, baseicm2s, baseicm3s," + ;
                       " baseipi2s, baseipi3s, cfops, ratdacs, ratfrts," + ;
                       " raticmds, raticms, ratsegs, sittricms, aliqiis," + ;
                       " citem2, taxaiis, vcofins, vpis, aliqorigs," + ;
                       " lcancelas, compris, codfabs, nadis, niadis," + ;
                       " aliqcofs, aliqpis, cssl, inss, irrf," + ;
                       " iss, valbases, localos, pfcpst, vfcpst," + ;
                       " ob2s, pedidoweb, qtresres, barraref, itemped," + ;
                       " numeronota, dopesorig, chaveexterna, ckpresente," + ;
                       " gravacao, ifors, propriedades, unidade1, resultado1," + ;
                       " valorMinimo, valorMaximo, metodoReferencia1" + ;
                       " FROM SigMvItn" + ;
                       " WHERE empdopnums = " + EscaparSQL(par_cEmpDopNums) + ;
                       " ORDER BY citens"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao carregar os itens da movimenta" + CHR(231) + ;
                            CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, ;
                            "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro("Erro ao carregar os itens da movimenta" + CHR(231) + ;
                        CHR(227) + "o:" + CHR(13) + loc_oErro.Message, ;
                        "sigopproBO.CarregarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ObterChavePrimaria - cidchaves (PK Fortyus, regra #22). PROTECTED:
    * nunca chamado de fora (so por RegistrarAuditoria/ExecutarExclusao).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDPROC

    *====================================================================
    * Inserir - INSERT completo em SigMvItn. cidchaves (PK Fortyus) e
    * gerada aqui se ainda vazia (regra #22 - fUniqueIds(), NUNCA string
    * vazia, senao o 2o registro colide no indice unico).
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidchaves)
            THIS.this_cCidchaves = fUniqueIds()
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigMvItn (
                    aqtds, citens, codbarras, cpros, cunis, datatrans,
                    descvals, dopes, dpros, emps, etiesps, fators,
                    fatvals, fvals, iconfs, locals, moedas, moefats,
                    moevals, notas, nrcons, ntrans, numes, numolds,
                    obs, opers, pesos, qtbaixas, qtbxprods, qtds,
                    qtprods, totas, tpesos, unitembs, units, univals,
                    vcoms, aliqs, sitribs, tpipis, valipis, aliqicms,
                    valdescs, empos, moevs, utilizas, ncodigos, qtreservas,
                    cidchaves, nlotes, dtalts, empdopnums, baseicms, chksubn,
                    unit2s, usulibs, valrats, codlprecs, cunips, motdscs,
                    tipos, unitinfs, cpro2s, abrevis, bcicmss, bcipis,
                    icms, icmss, pdescs, nchvtbds, idpro, unitorigs,
                    origmercs, baseicm2s, baseicm3s, baseipi2s, baseipi3s, cfops,
                    ratdacs, ratfrts, raticmds, raticms, ratsegs, sittricms,
                    aliqiis, citem2, taxaiis, vcofins, vpis, aliqorigs,
                    lcancelas, compris, codfabs, nadis, niadis, aliqcofs,
                    aliqpis, cssl, inss, irrf, iss, valbases,
                    localos, pfcpst, vfcpst, ob2s, pedidoweb, qtresres,
                    barraref, itemped, numeronota, dopesorig, chaveexterna, ckpresente,
                    gravacao, ifors, propriedades, unidade1, resultado1, valorMinimo,
                    valorMaximo, metodoReferencia1
                )
                VALUES (
                    <<FormatarNumeroSQL(THIS.this_nAqtds, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nCitens, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodbarras, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCunis, 3))>>,
                    <<IIF(EMPTY(THIS.this_dDatatrans), "NULL", FormatarDataSQL(THIS.this_dDatatrans))>>,
                    <<FormatarNumeroSQL(THIS.this_nDescvals, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cDopes, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cDpros, 65))>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    <<IIF(THIS.this_lEtiesps, 1, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nFators, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nFatvals, 6)>>,
                    <<IIF(THIS.this_lFvals, 1, 0)>>,
                    <<IIF(THIS.this_lIconfs, 1, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cLocals, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cMoedas, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cMoefats, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nMoevals, 6)>>,
                    <<EscaparSQL(LEFT(THIS.this_cNotas, 6))>>,
                    <<EscaparSQL(LEFT(THIS.this_cNrcons, 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nNtrans, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNumes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNumolds, 0)>>,
                    <<IIF(EMPTY(THIS.this_cObs), "NULL", EscaparSQL(THIS.this_cObs))>>,
                    <<EscaparSQL(LEFT(THIS.this_cOpers, 1))>>,
                    <<FormatarNumeroSQL(THIS.this_nPesos, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtbaixas, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtbxprods, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtds, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtprods, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nTotas, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpesos, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnitembs, 4)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnits, 6)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnivals, 6)>>,
                    <<FormatarNumeroSQL(THIS.this_nVcoms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqs, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cSitribs, 2))>>,
                    <<EscaparSQL(LEFT(THIS.this_cTpipis, 1))>>,
                    <<FormatarNumeroSQL(THIS.this_nValipis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqicms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nValdescs, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmpos, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cMoevs, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nUtilizas, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNcodigos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtreservas, 3)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>,
                    <<FormatarNumeroSQL(THIS.this_nNlotes, 0)>>,
                    <<IIF(EMPTY(THIS.this_dDtalts), "NULL", FormatarDataSQL(THIS.this_dDtalts))>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseicms, 2)>>,
                    <<IIF(THIS.this_lChksubn, 1, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnit2s, 6)>>,
                    <<EscaparSQL(LEFT(THIS.this_cUsulibs, 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nValrats, 6)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodlprecs, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCunips, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cMotdscs, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cTipos, 1))>>,
                    <<FormatarNumeroSQL(THIS.this_nUnitinfs, 6)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCpro2s, 50))>>,
                    <<EscaparSQL(LEFT(THIS.this_cAbrevis, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nBcicmss, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nBcipis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nIcms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nIcmss, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nPdescs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nNchvtbds, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIdpro, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nUnitorigs, 6)>>,
                    <<EscaparSQL(LEFT(THIS.this_cOrigmercs, 1))>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseicm2s, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseicm3s, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseipi2s, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseipi3s, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCfops, 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nRatdacs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nRatfrts, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nRaticmds, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nRaticms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nRatsegs, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cSittricms, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqiis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nCitem2, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTaxaiis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nVcofins, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nVpis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqorigs, 2)>>,
                    <<IIF(THIS.this_lLcancelas, 1, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCompris, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCodfabs, 60))>>,
                    <<FormatarNumeroSQL(THIS.this_nNadis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNiadis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqcofs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqpis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nCssl, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nInss, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nIrrf, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nIss, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nValbases, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cLocalos, 10))>>,
                    <<FormatarNumeroSQL(THIS.this_nPfcpst, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nVfcpst, 2)>>,
                    <<EscaparSQL(LEFT(THIS.this_cOb2s, 100))>>,
                    <<EscaparSQL(LEFT(THIS.this_cPedidoweb, 50))>>,
                    <<FormatarNumeroSQL(THIS.this_nQtresres, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nBarraref, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cItemped, 4))>>,
                    <<EscaparSQL(LEFT(THIS.this_cNumeronota, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cDopesorig, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))>>,
                    <<FormatarNumeroSQL(THIS.this_nCkpresente, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cGravacao, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cIfors, 10))>>,
                    <<IIF(EMPTY(THIS.this_cPropriedades), "NULL", EscaparSQL(LEFT(THIS.this_cPropriedades, 40)))>>,
                    <<IIF(EMPTY(THIS.this_cUnidade1), "NULL", EscaparSQL(LEFT(THIS.this_cUnidade1, 15)))>>,
                    <<IIF(EMPTY(THIS.this_cResultado1), "NULL", EscaparSQL(LEFT(THIS.this_cResultado1, 15)))>>,
                    <<IIF(EMPTY(THIS.this_cValorMinimo), "NULL", EscaparSQL(LEFT(THIS.this_cValorMinimo, 15)))>>,
                    <<IIF(EMPTY(THIS.this_cValorMaximo), "NULL", EscaparSQL(LEFT(THIS.this_cValorMaximo, 15)))>>,
                    <<IIF(EMPTY(THIS.this_cMetodoReferencia1), "NULL", EscaparSQL(LEFT(THIS.this_cMetodoReferencia1, 15)))>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao inserir item de movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro("Erro ao inserir item de movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "sigopproBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE completo em SigMvItn pela PK cidchaves.
    * cidchaves identifica o registro e NAO entra no SET.
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigMvItn SET
                    aqtds        = <<FormatarNumeroSQL(THIS.this_nAqtds, 3)>>,
                    citens       = <<FormatarNumeroSQL(THIS.this_nCitens, 0)>>,
                    codbarras    = <<FormatarNumeroSQL(THIS.this_nCodbarras, 0)>>,
                    cpros        = <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    cunis        = <<EscaparSQL(LEFT(THIS.this_cCunis, 3))>>,
                    datatrans    = <<IIF(EMPTY(THIS.this_dDatatrans), "NULL", FormatarDataSQL(THIS.this_dDatatrans))>>,
                    descvals     = <<FormatarNumeroSQL(THIS.this_nDescvals, 2)>>,
                    dopes        = <<EscaparSQL(LEFT(THIS.this_cDopes, 20))>>,
                    dpros        = <<EscaparSQL(LEFT(THIS.this_cDpros, 65))>>,
                    emps         = <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    etiesps      = <<IIF(THIS.this_lEtiesps, 1, 0)>>,
                    fators       = <<FormatarNumeroSQL(THIS.this_nFators, 3)>>,
                    fatvals      = <<FormatarNumeroSQL(THIS.this_nFatvals, 6)>>,
                    fvals        = <<IIF(THIS.this_lFvals, 1, 0)>>,
                    iconfs       = <<IIF(THIS.this_lIconfs, 1, 0)>>,
                    locals       = <<EscaparSQL(LEFT(THIS.this_cLocals, 10))>>,
                    moedas       = <<EscaparSQL(LEFT(THIS.this_cMoedas, 3))>>,
                    moefats      = <<EscaparSQL(LEFT(THIS.this_cMoefats, 3))>>,
                    moevals      = <<FormatarNumeroSQL(THIS.this_nMoevals, 6)>>,
                    notas        = <<EscaparSQL(LEFT(THIS.this_cNotas, 6))>>,
                    nrcons       = <<EscaparSQL(LEFT(THIS.this_cNrcons, 10))>>,
                    ntrans       = <<FormatarNumeroSQL(THIS.this_nNtrans, 0)>>,
                    numes        = <<FormatarNumeroSQL(THIS.this_nNumes, 0)>>,
                    numolds      = <<FormatarNumeroSQL(THIS.this_nNumolds, 0)>>,
                    obs          = <<IIF(EMPTY(THIS.this_cObs), "NULL", EscaparSQL(THIS.this_cObs))>>,
                    opers        = <<EscaparSQL(LEFT(THIS.this_cOpers, 1))>>,
                    pesos        = <<FormatarNumeroSQL(THIS.this_nPesos, 3)>>,
                    qtbaixas     = <<FormatarNumeroSQL(THIS.this_nQtbaixas, 3)>>,
                    qtbxprods    = <<FormatarNumeroSQL(THIS.this_nQtbxprods, 3)>>,
                    qtds         = <<FormatarNumeroSQL(THIS.this_nQtds, 3)>>,
                    qtprods      = <<FormatarNumeroSQL(THIS.this_nQtprods, 3)>>,
                    totas        = <<FormatarNumeroSQL(THIS.this_nTotas, 2)>>,
                    tpesos       = <<FormatarNumeroSQL(THIS.this_nTpesos, 2)>>,
                    unitembs     = <<FormatarNumeroSQL(THIS.this_nUnitembs, 4)>>,
                    units        = <<FormatarNumeroSQL(THIS.this_nUnits, 6)>>,
                    univals      = <<FormatarNumeroSQL(THIS.this_nUnivals, 6)>>,
                    vcoms        = <<FormatarNumeroSQL(THIS.this_nVcoms, 2)>>,
                    aliqs        = <<FormatarNumeroSQL(THIS.this_nAliqs, 2)>>,
                    sitribs      = <<EscaparSQL(LEFT(THIS.this_cSitribs, 2))>>,
                    tpipis       = <<EscaparSQL(LEFT(THIS.this_cTpipis, 1))>>,
                    valipis      = <<FormatarNumeroSQL(THIS.this_nValipis, 2)>>,
                    aliqicms     = <<FormatarNumeroSQL(THIS.this_nAliqicms, 2)>>,
                    valdescs     = <<FormatarNumeroSQL(THIS.this_nValdescs, 2)>>,
                    empos        = <<EscaparSQL(LEFT(THIS.this_cEmpos, 3))>>,
                    moevs        = <<EscaparSQL(LEFT(THIS.this_cMoevs, 3))>>,
                    utilizas     = <<FormatarNumeroSQL(THIS.this_nUtilizas, 0)>>,
                    ncodigos     = <<FormatarNumeroSQL(THIS.this_nNcodigos, 0)>>,
                    qtreservas   = <<FormatarNumeroSQL(THIS.this_nQtreservas, 3)>>,
                    nlotes       = <<FormatarNumeroSQL(THIS.this_nNlotes, 0)>>,
                    dtalts       = <<IIF(EMPTY(THIS.this_dDtalts), "NULL", FormatarDataSQL(THIS.this_dDtalts))>>,
                    empdopnums   = <<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
                    baseicms     = <<FormatarNumeroSQL(THIS.this_nBaseicms, 2)>>,
                    chksubn      = <<IIF(THIS.this_lChksubn, 1, 0)>>,
                    unit2s       = <<FormatarNumeroSQL(THIS.this_nUnit2s, 6)>>,
                    usulibs      = <<EscaparSQL(LEFT(THIS.this_cUsulibs, 10))>>,
                    valrats      = <<FormatarNumeroSQL(THIS.this_nValrats, 6)>>,
                    codlprecs    = <<FormatarNumeroSQL(THIS.this_nCodlprecs, 0)>>,
                    cunips       = <<EscaparSQL(LEFT(THIS.this_cCunips, 3))>>,
                    motdscs      = <<EscaparSQL(LEFT(THIS.this_cMotdscs, 10))>>,
                    tipos        = <<EscaparSQL(LEFT(THIS.this_cTipos, 1))>>,
                    unitinfs     = <<FormatarNumeroSQL(THIS.this_nUnitinfs, 6)>>,
                    cpro2s       = <<EscaparSQL(LEFT(THIS.this_cCpro2s, 50))>>,
                    abrevis      = <<EscaparSQL(LEFT(THIS.this_cAbrevis, 3))>>,
                    bcicmss      = <<FormatarNumeroSQL(THIS.this_nBcicmss, 2)>>,
                    bcipis       = <<FormatarNumeroSQL(THIS.this_nBcipis, 2)>>,
                    icms         = <<FormatarNumeroSQL(THIS.this_nIcms, 2)>>,
                    icmss        = <<FormatarNumeroSQL(THIS.this_nIcmss, 2)>>,
                    pdescs       = <<FormatarNumeroSQL(THIS.this_nPdescs, 2)>>,
                    nchvtbds     = <<FormatarNumeroSQL(THIS.this_nNchvtbds, 0)>>,
                    idpro        = <<FormatarNumeroSQL(THIS.this_nIdpro, 0)>>,
                    unitorigs    = <<FormatarNumeroSQL(THIS.this_nUnitorigs, 6)>>,
                    origmercs    = <<EscaparSQL(LEFT(THIS.this_cOrigmercs, 1))>>,
                    baseicm2s    = <<FormatarNumeroSQL(THIS.this_nBaseicm2s, 2)>>,
                    baseicm3s    = <<FormatarNumeroSQL(THIS.this_nBaseicm3s, 2)>>,
                    baseipi2s    = <<FormatarNumeroSQL(THIS.this_nBaseipi2s, 2)>>,
                    baseipi3s    = <<FormatarNumeroSQL(THIS.this_nBaseipi3s, 2)>>,
                    cfops        = <<EscaparSQL(LEFT(THIS.this_cCfops, 10))>>,
                    ratdacs      = <<FormatarNumeroSQL(THIS.this_nRatdacs, 2)>>,
                    ratfrts      = <<FormatarNumeroSQL(THIS.this_nRatfrts, 2)>>,
                    raticmds     = <<FormatarNumeroSQL(THIS.this_nRaticmds, 2)>>,
                    raticms      = <<FormatarNumeroSQL(THIS.this_nRaticms, 2)>>,
                    ratsegs      = <<FormatarNumeroSQL(THIS.this_nRatsegs, 2)>>,
                    sittricms    = <<EscaparSQL(LEFT(THIS.this_cSittricms, 3))>>,
                    aliqiis      = <<FormatarNumeroSQL(THIS.this_nAliqiis, 2)>>,
                    citem2       = <<FormatarNumeroSQL(THIS.this_nCitem2, 0)>>,
                    taxaiis      = <<FormatarNumeroSQL(THIS.this_nTaxaiis, 2)>>,
                    vcofins      = <<FormatarNumeroSQL(THIS.this_nVcofins, 2)>>,
                    vpis         = <<FormatarNumeroSQL(THIS.this_nVpis, 2)>>,
                    aliqorigs    = <<FormatarNumeroSQL(THIS.this_nAliqorigs, 2)>>,
                    lcancelas    = <<IIF(THIS.this_lLcancelas, 1, 0)>>,
                    compris      = <<FormatarNumeroSQL(THIS.this_nCompris, 2)>>,
                    codfabs      = <<EscaparSQL(LEFT(THIS.this_cCodfabs, 60))>>,
                    nadis        = <<FormatarNumeroSQL(THIS.this_nNadis, 0)>>,
                    niadis       = <<FormatarNumeroSQL(THIS.this_nNiadis, 0)>>,
                    aliqcofs     = <<FormatarNumeroSQL(THIS.this_nAliqcofs, 2)>>,
                    aliqpis      = <<FormatarNumeroSQL(THIS.this_nAliqpis, 2)>>,
                    cssl         = <<FormatarNumeroSQL(THIS.this_nCssl, 2)>>,
                    inss         = <<FormatarNumeroSQL(THIS.this_nInss, 2)>>,
                    irrf         = <<FormatarNumeroSQL(THIS.this_nIrrf, 2)>>,
                    iss          = <<FormatarNumeroSQL(THIS.this_nIss, 2)>>,
                    valbases     = <<FormatarNumeroSQL(THIS.this_nValbases, 2)>>,
                    localos      = <<EscaparSQL(LEFT(THIS.this_cLocalos, 10))>>,
                    pfcpst       = <<FormatarNumeroSQL(THIS.this_nPfcpst, 2)>>,
                    vfcpst       = <<FormatarNumeroSQL(THIS.this_nVfcpst, 2)>>,
                    ob2s         = <<EscaparSQL(LEFT(THIS.this_cOb2s, 100))>>,
                    pedidoweb    = <<EscaparSQL(LEFT(THIS.this_cPedidoweb, 50))>>,
                    qtresres     = <<FormatarNumeroSQL(THIS.this_nQtresres, 3)>>,
                    barraref     = <<FormatarNumeroSQL(THIS.this_nBarraref, 0)>>,
                    itemped      = <<EscaparSQL(LEFT(THIS.this_cItemped, 4))>>,
                    numeronota   = <<EscaparSQL(LEFT(THIS.this_cNumeronota, 10))>>,
                    dopesorig    = <<EscaparSQL(LEFT(THIS.this_cDopesorig, 20))>>,
                    chaveexterna = <<EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))>>,
                    ckpresente   = <<FormatarNumeroSQL(THIS.this_nCkpresente, 0)>>,
                    gravacao     = <<EscaparSQL(LEFT(THIS.this_cGravacao, 20))>>,
                    ifors        = <<EscaparSQL(LEFT(THIS.this_cIfors, 10))>>,
                    propriedades = <<IIF(EMPTY(THIS.this_cPropriedades), "NULL", EscaparSQL(LEFT(THIS.this_cPropriedades, 40)))>>,
                    unidade1     = <<IIF(EMPTY(THIS.this_cUnidade1), "NULL", EscaparSQL(LEFT(THIS.this_cUnidade1, 15)))>>,
                    resultado1   = <<IIF(EMPTY(THIS.this_cResultado1), "NULL", EscaparSQL(LEFT(THIS.this_cResultado1, 15)))>>,
                    valorMinimo  = <<IIF(EMPTY(THIS.this_cValorMinimo), "NULL", EscaparSQL(LEFT(THIS.this_cValorMinimo, 15)))>>,
                    valorMaximo  = <<IIF(EMPTY(THIS.this_cValorMaximo), "NULL", EscaparSQL(LEFT(THIS.this_cValorMaximo, 15)))>>,
                    metodoReferencia1 = <<IIF(EMPTY(THIS.this_cMetodoReferencia1), "NULL", EscaparSQL(LEFT(THIS.this_cMetodoReferencia1, 15)))>>
                WHERE cidchaves = <<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao atualizar item de movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro("Erro ao atualizar item de movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "sigopproBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

