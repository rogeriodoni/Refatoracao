# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (35)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_CODIGOS, CNT_4C_OBS, CNT_4C_REFFS, CNT_4C_ITEM. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarCodCorLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarCodCorLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarCodTamLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarCodTamLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterChaveMovimentacao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.TemProdutoSelecionado()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ExecutarConsultaPainel()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterContaFornecedor()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterGrupoEstoque()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ResolverProdutoDigitado()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoppro.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (6402 linhas total):

*-- Linhas 106 a 251:
106:     this_lFechandoObs = .F.
107: 
108:     *==========================================================================
109:     PROCEDURE Init()
110:     *==========================================================================
111:         THIS.Caption = "Produtos"
112:         RETURN DODEFAULT()
113:     ENDPROC
114: 
115:     *==========================================================================
116:     * Destroy - Libera cursores e recursos
117:     *==========================================================================
118:     PROCEDURE Destroy()
119:         LOCAL loc_oErro
120:         TRY
121:             IF USED("cursor_4c_Dados")
122:                 USE IN cursor_4c_Dados
123:             ENDIF
124:         CATCH TO loc_oErro
125:             *-- nao exibir erro no Destroy
126:         ENDTRY
127:         DODEFAULT()
128:     ENDPROC
129: 
130:     *==========================================================================
131:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
132:     *==========================================================================
133:     PROTECTED PROCEDURE InicializarForm()
134:         LOCAL loc_lSucesso, loc_oErro
135:         loc_lSucesso = .F.
136: 
137:         TRY
138:             THIS.this_oBusinessObject = CREATEOBJECT("sigopproBO")
139: 
140:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
141:                 MsgErro("Falha ao criar sigopproBO.", "Erro")
142:             ELSE
143:                 THIS.ConfigurarCabecalho()
144:                 THIS.ConfigurarPageFrame()
145: 
146:                 *-- Cursores ANTES das paginas: os campos de Page1/Page3 e a
147:                 *-- grade de Page4 usam ControlSource, e ControlSource de alias
148:                 *-- que ainda nao existe derruba o Init (regra #41).
149:                 THIS.CriarCursorItens()
150:                 THIS.CriarCursorPrecos()
151: 
152:                 THIS.ConfigurarPaginaProduto()
153:                 THIS.ConfigurarPaginaDados()
154:                 THIS.ConfigurarPaginaFiscal()
155:                 THIS.ConfigurarPaginaPrecos()
156:                 THIS.ConfigurarBotoes()
157:                 THIS.ConfigurarBotoesTopo()
158:                 THIS.ConfigurarBotoesAcao()
159:                 THIS.ConfigurarGridDados()
160: 
161:                 *-- AfterRowColChange: handler DECLARA par_nColIndex porque o
162:                 *-- evento passa o argumento (regra #3). Uso de LINHA corrente
163:                 *-- (carregar o detalhe), nunca validacao de celula (regra #46).
164:                 BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, ;
165:                           "GradeAfterRowColChange")
166: 
167:                 THIS.TornarControlesVisiveis(THIS)
168:                 THIS.ReaplicarVisibilidadeInicial()
169:                 THIS.AplicarModoNaGrade()
170:                 THIS.AjustarBotoesPorModo()
171:                 THIS.HabilitarCampos(INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR"))
172: 
173:                 THIS.pgf_4c_Paginas.Visible    = .T.
174:                 THIS.pgf_4c_Paginas.ActivePage = 1
175: 
176:                 *-- Carga da grade: pulada em validacao de UI/modo teste (sem
177:                 *-- gnConnHandle a consulta nao tem como rodar).
178:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
179:                     IF TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste
180:                         THIS.CarregarDados()
181:                     ENDIF
182:                 ENDIF
183: 
184:                 loc_lSucesso = .T.
185:             ENDIF
186: 
187:         CATCH TO loc_oErro
188:             THIS.this_cMensagemErro = loc_oErro.Message
189:             MsgErro(loc_oErro.Message + CHR(13) + ;
190:                      "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
191:                      "Proc: " + loc_oErro.Procedure, "Erro InicializarForm")
192:         ENDTRY
193: 
194:         RETURN loc_lSucesso
195:     ENDPROC
196: 
197:     *==========================================================================
198:     * ConfigurarCabecalho - Faixa cinza do topo (CLAUDE.md regra #11) e bloco
199:     * canonico de Saida/Encerrar (CLAUDE.md regra #10), ambos na raiz do form
200:     * (este form usa abas visiveis, Tabs=.T., sem o truque PageFrame.Top=-29
201:     * das telas CRUD - entao nao ha compensacao de +29 a aplicar aqui).
202:     *==========================================================================
203:     PROTECTED PROCEDURE ConfigurarCabecalho()
204:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
205:         WITH THIS.cnt_4c_Cabecalho
206:             .Top           = 0
207:             .Left          = 0
208:             .Width         = THIS.Width
209:             .Height        = 80
210:             .BackColor     = RGB(100, 100, 100)
211:             .BorderWidth   = 0
212:             .SpecialEffect = 0
213:             .Visible     = .T.
214:         ENDWITH
215: 
216:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
217:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
218:             .Top       = 15
219:             .Left      = 10
220:             .Width     = THIS.cnt_4c_Cabecalho.Width - 20
221:             .Height    = 40
222:             .FontName  = "Tahoma"
223:             .FontSize  = 16
224:             .FontBold  = .T.
225:             .BackStyle = 0
226:             .ForeColor = RGB(0, 0, 0)
227:             .AutoSize  = .F.
228:             .WordWrap  = .T.
229:             .Caption   = THIS.Caption
230:         ENDWITH
231: 
232:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
233:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
234:             .Top       = 18
235:             .Left      = 10
236:             .Width     = THIS.cnt_4c_Cabecalho.Width - 20
237:             .Height    = 46
238:             .FontName  = "Tahoma"
239:             .FontSize  = 16
240:             .FontBold  = .T.
241:             .BackStyle = 0
242:             .ForeColor = RGB(255, 255, 255)
243:             .AutoSize  = .F.
244:             .WordWrap  = .T.
245:             .Caption   = THIS.Caption
246:         ENDWITH
247: 
248:         *-- cnt_4c_Saida: padrao canonico (CLAUDE.md regra #10), prevalece
249:         *-- sobre a posicao do botao "Retornar" (OK.btnSair) do SCX legado.
250:         THIS.AddObject("cnt_4c_Saida", "Container")
251:         WITH THIS.cnt_4c_Saida

*-- Linhas 278 a 360:
278:             .WordWrap        = .T.
279:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
280:         ENDWITH
281:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
282:     ENDPROC
283: 
284:     *==========================================================================
285:     * ConfigurarBotoes - Containers vazios para os botoes de acao da tela
286:     * (toolbar superior e inferior do legado, Top=81 e Top=359).
287:     *==========================================================================
288:     PROTECTED PROCEDURE ConfigurarBotoes()
289:         THIS.AddObject("cnt_4c_Botoes", "Container")
290:         WITH THIS.cnt_4c_Botoes
291:             .Top         = 81
292:             .Left        =  542
293:             .Width       = THIS.Width - 14
294:             .Height      = 40
295:             .BackStyle   = 0
296:             .BorderWidth = 0
297:             .Visible     = .T.
298:         ENDWITH
299: 
300:         THIS.AddObject("cnt_4c_BotoesAcao", "Container")
301:         WITH THIS.cnt_4c_BotoesAcao
302:             .Top         = 359
303:             .Left        = 7
304:             .Width       = THIS.Width - 14
305:             .Height      = 40
306:             .BackStyle   = 0
307:             .BorderWidth = 0
308:             .Visible     = .T.
309:         ENDWITH
310:     ENDPROC
311: 
312:     *==========================================================================
313:     * ConfigurarPageFrame - pgf_4c_Paginas com as 4 abas visiveis do legado,
314:     * na ordem visual (PageOrder) do pgfPagina original:
315:     *   Page1 = pgProds  (PageOrder=1) "Dados do Produto"
316:     *   Page2 = pgContas (PageOrder=2) "Dados da Movimentacao"
317:     *   Page3 = pgFiscs  (PageOrder=3) "Dados Fiscais"
318:     *   Page4 = pgPrecos (PageOrder=4) "Precificacao"
319:     *==========================================================================
320:     PROTECTED PROCEDURE ConfigurarPageFrame()
321:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
322:         WITH THIS.pgf_4c_Paginas
323:             .Top       = 403
324:             .Left      = 7
325:             .Width     = 1035
326:             .Height    = 198
327:             .Tabs      = .T.
328:             .PageCount = 4
329:             .Visible   = .F.
330:         ENDWITH
331: 
332:         WITH THIS.pgf_4c_Paginas.Page1
333:             .Caption   = "Dados do Produto"
334:             .FontName  = "Tahoma"
335:             .FontSize  = 8
336:             .BackColor = RGB(255, 255, 255)
337:             .ForeColor = RGB(90, 90, 90)
338:         ENDWITH
339: 
340:         WITH THIS.pgf_4c_Paginas.Page2
341:             .Caption   = "Dados da Movimenta" + CHR(231) + CHR(227) + "o"
342:             .FontName  = "Tahoma"
343:             .FontSize  = 8
344:             .BackColor = RGB(255, 255, 255)
345:             .ForeColor = RGB(90, 90, 90)
346:         ENDWITH
347: 
348:         WITH THIS.pgf_4c_Paginas.Page3
349:             .Caption   = "Dados Fiscais"
350:             .FontName  = "Tahoma"
351:             .FontSize  = 8
352:             .BackColor = RGB(255, 255, 255)
353:             .ForeColor = RGB(90, 90, 90)
354:         ENDWITH
355: 
356:         WITH THIS.pgf_4c_Paginas.Page4
357:             .Caption   = "Precifica" + CHR(231) + CHR(227) + "o"
358:             .FontName  = "Tahoma"
359:             .FontSize  = 8
360:             .BackColor = RGB(255, 255, 255)

*-- Linhas 382 a 428:
382:     * TprMvCab (que vive no data session do form PAI), nunca campos
383:     * digitaveis. getEmpDs (cntEmpDes) tambem tem When() = Return(.F.). So
384:     * getLPrecos (cntLPrecos) eh editavel no legado, mas nao tem
385:     * CreateObject('fwbuscaext'/'fwBuscaSel') nem sigacess() no Valid - eh
386:     * texto livre (Format="K", MaxLength=30), sem tabela de referencia.
387:     *==========================================================================
388:     PROTECTED PROCEDURE ConfigurarPaginaDados()
389:         LOCAL loc_oPag
390:         loc_oPag = THIS.pgf_4c_Paginas.Page2
391: 
392:         *-- cnt_4c_Codigos (cntCodigos no legado) -----------------------------
393:         loc_oPag.AddObject("cnt_4c_Codigos", "Container")
394:         WITH loc_oPag.cnt_4c_Codigos
395:             .Top         = -2
396:             .Left        = 10
397:             .Width       = 67
398:             .Height      = 45
399:             .BackStyle   = 0
400:             .BorderWidth = 0
401:             .Visible     = .T.
402:         ENDWITH
403: 
404:         loc_oPag.cnt_4c_Codigos.AddObject("txt_4c_Codigos", "TextBox")
405:         WITH loc_oPag.cnt_4c_Codigos.txt_4c_Codigos
406:             .Top           = 20
407:             .Left          = 3
408:             .Width         = 61
409:             .Height        = 23
410:             .FontBold      = .T.
411:             .FontSize      = 10
412:             .SpecialEffect = 1
413:             .ForeColor     = RGB(36, 84, 155)
414:             .Value         = THIS.this_cMascnum
415:             .ToolTipText   = "C" + CHR(243) + "digo da Opera" + CHR(231) + CHR(227) + "o"
416:         ENDWITH
417: 
418:         loc_oPag.cnt_4c_Codigos.AddObject("lbl_4c_LblCodigos", "Label")
419:         WITH loc_oPag.cnt_4c_Codigos.lbl_4c_LblCodigos
420:             .Top       = 3
421:             .Left      = 3
422:             .Width     = 58
423:             .Height    = 15
424:             .FontName  = "Tahoma"
425:             .FontSize  = 8
426:             .FontBold  = .F.
427:             .Alignment = 0
428:             .BackStyle = 0

*-- Linhas 774 a 854:
774:     ENDPROC
775: 
776:     *==========================================================================
777:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F.;
778:     * percorre recursivamente Controls (que inclui Pages de PageFrame).
779:     *==========================================================================
780:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
781:         LOCAL loc_oCtrl, loc_oErro
782:         TRY
783:             FOR EACH loc_oCtrl IN par_oContainer.Controls
784:                 IF VARTYPE(loc_oCtrl) = "O"
785:                     *-- Container FLUTUANTE: nasce oculto no legado e eh
786:                     *-- aberto/fechado por evento. Forcar Visible = .T. aqui
787:                     *-- deixaria o painel da observacao aberto por cima da
788:                     *-- pagina desde a abertura da tela. Mesmo assim DESCE para
789:                     *-- os filhos: o EditBox de dentro tem de estar visivel
790:                     *-- quando o painel for aberto.
791:                     IF UPPER(loc_oCtrl.Name) == "CNT_4C_OBS"
792:                         THIS.TornarControlesVisiveis(loc_oCtrl)
793:                         LOOP
794:                     ENDIF
795: 
796:                     loc_oCtrl.Visible = .T.
797:                     IF PEMSTATUS(loc_oCtrl, "Controls", 5) AND loc_oCtrl.ControlCount > 0
798:                         THIS.TornarControlesVisiveis(loc_oCtrl)
799:                     ENDIF
800:                 ENDIF
801:             ENDFOR
802:         CATCH TO loc_oErro
803:             *-- continua silenciosamente
804:         ENDTRY
805:     ENDPROC
806: 
807:     *==========================================================================
808:     * CriarCursorItens - Cursor de trabalho (espelha crTpmMvItn do legado),
809:     * compartilhado pela grade grd_4c_Dados e pelo sigopproBO.CarregarDoCursor.
810:     * Mantido num unico CREATE CURSOR para que as paginas de Dados/Fiscal/
811:     * Precificacao (fases seguintes) liguem campos nele sem recriar a
812:     * estrutura (regra #41 - Column.ControlSource exige o cursor ja existir).
813:     *==========================================================================
814:     PROTECTED PROCEDURE CriarCursorItens()
815:         IF USED("cursor_4c_Itens")
816:             USE IN cursor_4c_Itens
817:         ENDIF
818: 
819:         SET NULL ON
820:         CREATE CURSOR cursor_4c_Itens ( ;
821:             cidchaves C(20), citens N(10,0), cpros C(14), dpros C(65), ;
822:             codbarras N(14,0), cunis C(3), cunips C(3), fators N(8,3), ;
823:             opers C(1), qtds N(9,3), pesos N(9,3), units N(15,6), ;
824:             moedas C(3), totas N(11,2), tpesos N(11,2), abrevis C(3), ;
825:             locals C(10), localos C(10), compris N(6,2), qtreservas N(9,3), ;
826:             ckpresente N(1,0), codcors C(4), codtams C(4), servicos N(1,0), ;
827:             aqtds N(9,3), datatrans T NULL, descvals N(7,2), dopes C(20), ;
828:             emps C(3), etiesps L, fatvals N(15,6), fvals L, iconfs L, ;
829:             moefats C(3), moevals N(15,6), notas C(6), nrcons C(10), ;
830:             ntrans N(6,0), numes N(6,0), numolds N(6,0), obs M NULL, ;
831:             qtbaixas N(9,3), qtbxprods N(9,3), qtprods N(9,3), ;
832:             unitembs N(11,4), univals N(15,6), vcoms N(8,2), aliqs N(4,2), ;
833:             sitribs C(2), tpipis C(1), valipis N(11,2), aliqicms N(5,2), ;
834:             valdescs N(9,2), empos C(3), moevs C(3), utilizas N(4,0), ;
835:             ncodigos N(10,0), nlotes N(10,0), dtalts T NULL, empdopnums C(29), ;
836:             baseicms N(11,2), chksubn L, unit2s N(15,6), usulibs C(10), ;
837:             valrats N(14,6), codlprecs N(6,0), motdscs C(10), tipos C(1), ;
838:             unitinfs N(14,6), cpro2s C(50), bcicmss N(15,2), bcipis N(15,2), ;
839:             icms N(15,2), icmss N(15,2), pdescs N(5,2), nchvtbds N(6,0), ;
840:             idpro N(10,0), unitorigs N(14,6), origmercs C(1), ;
841:             baseicm2s N(11,2), baseicm3s N(11,2), baseipi2s N(11,2), ;
842:             baseipi3s N(11,2), cfops C(10), ratdacs N(11,2), ratfrts N(11,2), ;
843:             raticmds N(11,2), raticms N(11,2), ratsegs N(11,2), sittricms C(3), ;
844:             aliqiis N(4,2), citem2 N(10,0), taxaiis N(11,2), vcofins N(11,2), ;
845:             vpis N(11,2), aliqorigs N(4,2), lcancelas L, codfabs C(60), ;
846:             nadis N(3,0), niadis N(3,0), aliqcofs N(4,2), aliqpis N(4,2), ;
847:             cssl N(11,2), inss N(11,2), irrf N(11,2), iss N(11,2), ;
848:             valbases N(11,2), pfcpst N(5,2), vfcpst N(11,2), ob2s C(100), ;
849:             pedidoweb C(50), qtresres N(9,3), barraref N(14,0), itemped C(4), ;
850:             numeronota C(10), dopesorig C(20), chaveexterna C(33), ;
851:             gravacao C(20), ifors C(10), propriedades C(40) NULL, ;
852:             unidade1 C(15) NULL, resultado1 C(15) NULL, valorMinimo C(15) NULL, ;
853:             valorMaximo C(15) NULL, metodoReferencia1 C(15) NULL)
854:         SET NULL OFF

*-- Linhas 868 a 911:
868:     * ConfigurarGridDados - grd_4c_Dados (fwGrade do legado): grade principal
869:     * de itens da movimentacao, 22 colunas na mesma ordem/largura do dump.
870:     *==========================================================================
871:     PROTECTED PROCEDURE ConfigurarGridDados()
872:         THIS.AddObject("grd_4c_Dados", "Grid")
873:         WITH THIS.grd_4c_Dados
874:             .Top               = 122
875:             .Left              = 7
876:             .Width             = 1035
877:             .Height            = 233
878:             .ColumnCount       = 22
879:             .RecordSource      = "cursor_4c_Itens"
880:             .FontName          = "Courier New"
881:             .FontSize          = 9
882:             .HeaderHeight      = 16
883:             .RowHeight         = 16
884:             .AllowHeaderSizing = .F.
885:             .DeleteMark        = .F.
886:             .RecordMark        = .F.
887:             .ScrollBars        = 3
888:             .GridLineColor     = RGB(238, 238, 238)
889:             .ToolTipText       = "Grade de Produtos"
890:         ENDWITH
891: 
892:         *-- Column1: PRODUTO (estilo link - sublinhado/azul, igual ao legado)
893:         WITH THIS.grd_4c_Dados.Column1
894:             .ControlSource     = "cursor_4c_Itens.cpros"
895:             .Width             = 108
896:             .FontBold          = .T.
897:             .FontName          = "Courier New"
898:             .FontSize          = 9
899:             .FontUnderline     = .T.
900:             .ForeColor         = RGB(0, 0, 255)
901:             .Format            = "K!"
902:             .InputMask         = REPLICATE("!", 14)
903:             .Header1.FontBold  = .T.
904:             .Header1.FontName  = "Arial"
905:             .Header1.FontSize  = 8
906:             .Header1.Alignment = 2
907:             .Header1.Caption   = "Produto"
908:         ENDWITH
909: 
910:         *-- Column2: FATOR
911:         WITH THIS.grd_4c_Dados.Column2

*-- Linhas 1078 a 2199:
1078:         *-- VFP liga Column22 ao 22o campo do cursor, que eh codcors C(4), e
1079:         *-- adicionar um controle numerico ali da
1080:         *-- "Error with CHK_4C_SERVICO - Value : Data type mismatch."
1081:         *-- A falha eh TOTAL e MUDA: cai no TRY do InicializarForm, que
1082:         *-- devolve .F., CREATEOBJECT devolve o logico .F. e a tela
1083:         *-- simplesmente nao abre - sem erro na tela e sem log.
1084:         WITH THIS.grd_4c_Dados.Column21
1085:             .ControlSource     = "cursor_4c_Itens.ckpresente"
1086:             .Width             = 50
1087:             .Header1.Alignment = 2
1088:             .Header1.Caption   = "Presente"
1089:         ENDWITH
1090: 
1091:         WITH THIS.grd_4c_Dados.Column22
1092:             .ControlSource     = "cursor_4c_Itens.servicos"
1093:             .Width             = 50
1094:             .Header1.Alignment = 2
1095:             .Header1.Caption   = "O.S."
1096:         ENDWITH
1097: 
1098:         *-- Todas as colunas ja estao bindadas: agora os CheckBox.
1099:         THIS.InstalarCheckBoxesGrade()
1100:     ENDPROC
1101: 
1102:     *==========================================================================
1103:     * InstalarCheckBoxesGrade - Instala os CheckBox das colunas Presente e
1104:     * O.S. na ordem que o VFP9 exige (medido): ColumnCount -> RecordSource ->
1105:     * ControlSource de TODAS as colunas -> Column.AddObject + Value ->
1106:     * Sparse + CurrentControl. Invertido, o AddObject estoura por causa do
1107:     * auto-bind do RecordSource (ver comentario em ConfigurarGridDados).
1108:     *
1109:     * IDEMPOTENTE e vive no funil: reatribuir RecordSource/ColumnCount ou
1110:     * fechar o alias destroi os objetos postos na Column, entao a instalacao
1111:     * tem de poder rodar de novo sem duplicar o AddObject.
1112:     *==========================================================================
1113:     PROTECTED PROCEDURE InstalarCheckBoxesGrade()
1114:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1115:             RETURN
1116:         ENDIF
1117: 
1118:         IF THIS.grd_4c_Dados.ColumnCount < 22
1119:             RETURN
1120:         ENDIF
1121: 
1122:         THIS.InstalarCheckBoxColuna(THIS.grd_4c_Dados.Column21, "chk_4c_Presente")
1123:         THIS.InstalarCheckBoxColuna(THIS.grd_4c_Dados.Column22, "chk_4c_Servico")
1124:     ENDPROC
1125: 
1126:     *==========================================================================
1127:     * InstalarCheckBoxColuna - Poe UM CheckBox numa Column. Propriedades: so
1128:     * as que o VFP9 de fato aplica em controle de Column criado em runtime
1129:     * (Caption/Alignment/ReadOnly/Visible/FontName/FontSize/Value). Top/Left/
1130:     * Width/Height sao DESCARTADAS nesse contexto - escrever a geometria do
1131:     * dump aqui eh codigo morto que sugere area clicavel calibrada.
1132:     *==========================================================================
1133:     PROTECTED PROCEDURE InstalarCheckBoxColuna(par_oColuna, par_cNomeChk)
1134:         IF VARTYPE(par_oColuna) <> "O" OR VARTYPE(par_cNomeChk) <> "C"
1135:             RETURN
1136:         ENDIF
1137: 
1138:         IF !PEMSTATUS(par_oColuna, par_cNomeChk, 5)
1139:             par_oColuna.AddObject(par_cNomeChk, "CheckBox")
1140:         ENDIF
1141: 
1142:         *-- Membro alcancado por NOME: EVALUATE para ler, STORE para atribuir
1143:         *-- (Column nao eh colecao por chave - regra #34).
1144:         STORE ""   TO ("par_oColuna." + par_cNomeChk + ".Caption")
1145:         STORE 0    TO ("par_oColuna." + par_cNomeChk + ".Alignment")
1146:         STORE .F.  TO ("par_oColuna." + par_cNomeChk + ".ReadOnly")
1147:         STORE .T.  TO ("par_oColuna." + par_cNomeChk + ".Visible")
1148:         STORE "Courier New" TO ("par_oColuna." + par_cNomeChk + ".FontName")
1149:         STORE 9    TO ("par_oColuna." + par_cNomeChk + ".FontSize")
1150:         STORE 0    TO ("par_oColuna." + par_cNomeChk + ".Value")
1151: 
1152:         *-- Sparse = .F. senao o CheckBox so aparece na linha ativa;
1153:         *-- CurrentControl com o NOME do objeto, senao a coluna segue
1154:         *-- desenhando o Text1 dela (regra #18).
1155:         par_oColuna.Sparse         = .F.
1156:         par_oColuna.CurrentControl = par_cNomeChk
1157:     ENDPROC
1158: 
1159:     *==========================================================================
1160:     * ConfigurarBotoesTopo - Preenche cnt_4c_Botoes (Top=81 no legado) com a
1161:     * barra de botoes auxiliares. Posicoes/icones/visibilidade EXATOS do dump
1162:     * (layout.json/sigoppro_form_codigo_fonte_slim.txt); Left relativo ao
1163:     * container (absoluto do legado menos 7, regra "Left relativo em botoes
1164:     * de container").
1165:     *==========================================================================
1166:     PROTECTED PROCEDURE ConfigurarBotoesTopo()
1167:         LOCAL loc_oCnt
1168:         loc_oCnt = THIS.cnt_4c_Botoes
1169: 
1170:         loc_oCnt.AddObject("cmd_4c_BtnTotItens", "CommandButton")
1171:         WITH loc_oCnt.cmd_4c_BtnTotItens
1172:             .Left            = 7
1173:             .Top             = 0
1174:             .Width           = 102
1175:             .Height          = 40
1176:             .FontName        = "Comic Sans MS"
1177:             .FontBold        = .T.
1178:             .FontItalic      = .T.
1179:             .FontSize        = 8
1180:             .WordWrap        = .T.
1181:             .ForeColor       = RGB(90, 90, 90)
1182:             .BackColor       = RGB(255, 255, 255)
1183:             .Themes          = .T.
1184:             .PicturePosition = 1
1185:             .MousePointer    = 15
1186:             .Caption         = "Total de Produtos"
1187:             .ToolTipText     = "Total dos Produtos"
1188:             .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
1189:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
1190:         ENDWITH
1191:         BINDEVENT(loc_oCnt.cmd_4c_BtnTotItens, "Click", THIS, "BtnTotItensClick")
1192: 
1193:         loc_oCnt.AddObject("cmd_4c_BtnCotacao", "CommandButton")
1194:         WITH loc_oCnt.cmd_4c_BtnCotacao
1195:             .Left            = 109
1196:             .Top             = 0
1197:             .Width           = 102
1198:             .Height          = 40
1199:             .FontName        = "Comic Sans MS"
1200:             .FontBold        = .T.
1201:             .FontItalic      = .T.
1202:             .FontSize        = 8
1203:             .WordWrap        = .T.
1204:             .ForeColor       = RGB(90, 90, 90)
1205:             .BackColor       = RGB(255, 255, 255)
1206:             .Themes          = .T.
1207:             .PicturePosition = 1
1208:             .MousePointer    = 15
1209:             .Caption         = "C" + CHR(226) + "mbio de Produtos"
1210:             .ToolTipText     = "Edita os Valores de Cota" + CHR(231) + CHR(227) + "o das Moedas"
1211:             .Picture         = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
1212:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
1213:         ENDWITH
1214:         BINDEVENT(loc_oCnt.cmd_4c_BtnCotacao, "Click", THIS, "BtnCotacaoClick")
1215: 
1216:         loc_oCnt.AddObject("cmd_4c_BtnAltImps", "CommandButton")
1217:         WITH loc_oCnt.cmd_4c_BtnAltImps
1218:             .Left            = 211
1219:             .Top             = 0
1220:             .Width           = 102
1221:             .Height          = 40
1222:             .FontName        = "Comic Sans MS"
1223:             .FontBold        = .T.
1224:             .FontItalic      = .T.
1225:             .FontSize        = 8
1226:             .WordWrap        = .T.
1227:             .ForeColor       = RGB(90, 90, 90)
1228:             .BackColor       = RGB(255, 255, 255)
1229:             .Themes          = .T.
1230:             .PicturePosition = 1
1231:             .MousePointer    = 15
1232:             .Caption         = "Alterar Impostos"
1233:             .ToolTipText     = "Alterar Impostos"
1234:             .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
1235:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
1236:         ENDWITH
1237:         BINDEVENT(loc_oCnt.cmd_4c_BtnAltImps, "Click", THIS, "BtnAltImpsClick")
1238: 
1239:         loc_oCnt.AddObject("chk_4c_BtnVerImps", "CheckBox")
1240:         WITH loc_oCnt.chk_4c_BtnVerImps
1241:             .Left            = 313
1242:             .Top             = 0
1243:             .Width           = 102
1244:             .Height          = 40
1245:             .Style           = 1
1246:             .Alignment       = 2
1247:             *-- CheckBox.Value SEMPRE numerico (0/1). O SCX legado declara
1248:             *-- Value = .F., mas misturar Logico e Numerico no mesmo controle
1249:             *-- estoura "Operator/operand type mismatch" na primeira
1250:             *-- comparacao com 0/1 feita em outro metodo.
1251:             .Value           = 0
1252:             .FontName        = "Comic Sans MS"
1253:             .FontBold        = .T.
1254:             .FontItalic      = .T.
1255:             .FontSize        = 8
1256:             .WordWrap        = .T.
1257:             .ForeColor       = RGB(90, 90, 90)
1258:             .BackColor       = RGB(255, 255, 255)
1259:             .Themes          = .T.
1260:             .PicturePosition = 1
1261:             .MousePointer    = 15
1262:             .Caption         = "Visualizar Impostos"
1263:             .ToolTipText     = "Visualizar Impostos"
1264:             .Picture         = gc_4c_CaminhoIcones + "geral_coleta_60.jpg"
1265:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_coleta_60.jpg"
1266:         ENDWITH
1267:         BINDEVENT(loc_oCnt.chk_4c_BtnVerImps, "Click", THIS, "BtnVerImpsClick")
1268: 
1269:         loc_oCnt.AddObject("cmd_4c_BtnRecImps", "CommandButton")
1270:         WITH loc_oCnt.cmd_4c_BtnRecImps
1271:             .Left            = 414
1272:             .Top             = 0
1273:             .Width           = 102
1274:             .Height          = 40
1275:             .FontName        = "Comic Sans MS"
1276:             .FontBold        = .T.
1277:             .FontItalic      = .T.
1278:             .FontSize        = 8
1279:             .WordWrap        = .T.
1280:             .ForeColor       = RGB(90, 90, 90)
1281:             .BackColor       = RGB(255, 255, 255)
1282:             .Themes          = .T.
1283:             .PicturePosition = 1
1284:             .MousePointer    = 15
1285:             .Caption         = "Recalcular Impostos"
1286:             .ToolTipText     = "Recalcular Impostos"
1287:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1288:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1289:         ENDWITH
1290:         BINDEVENT(loc_oCnt.cmd_4c_BtnRecImps, "Click", THIS, "BtnRecImpsClick")
1291: 
1292:         loc_oCnt.AddObject("cmd_4c_Btndevolu", "CommandButton")
1293:         WITH loc_oCnt.cmd_4c_Btndevolu
1294:             .Left            = 517
1295:             .Top             = 0
1296:             .Width           = 102
1297:             .Height          = 40
1298:             .FontName        = "Comic Sans MS"
1299:             .FontBold        = .T.
1300:             .FontItalic      = .T.
1301:             .FontSize        = 8
1302:             .WordWrap        = .T.
1303:             .ForeColor       = RGB(90, 90, 90)
1304:             .BackColor       = RGB(255, 255, 255)
1305:             .Themes          = .T.
1306:             .PicturePosition = 1
1307:             .MousePointer    = 15
1308:             .Caption         = "Devolu" + CHR(231) + CHR(227) + "o"
1309:             .ToolTipText     = "Devolu" + CHR(231) + CHR(227) + "o"
1310:             .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1311:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
1312:         ENDWITH
1313:         BINDEVENT(loc_oCnt.cmd_4c_Btndevolu, "Click", THIS, "BtndevoluClick")
1314: 
1315:         loc_oCnt.AddObject("cmd_4c_BtnIteSub", "CommandButton")
1316:         WITH loc_oCnt.cmd_4c_BtnIteSub
1317:             .Left            = 618
1318:             .Top             = 0
1319:             .Width           = 102
1320:             .Height          = 40
1321:             .FontName        = "Comic Sans MS"
1322:             .FontBold        = .T.
1323:             .FontItalic      = .T.
1324:             .FontSize        = 8
1325:             .WordWrap        = .T.
1326:             .ForeColor       = RGB(90, 90, 90)
1327:             .BackColor       = RGB(255, 255, 255)
1328:             .Themes          = .T.
1329:             .PicturePosition = 1
1330:             .MousePointer    = 15
1331:             .Caption         = "Itens Subn" + CHR(237) + "vel"
1332:             .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
1333:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
1334:         ENDWITH
1335:         BINDEVENT(loc_oCnt.cmd_4c_BtnIteSub, "Click", THIS, "BtnIteSubClick")
1336: 
1337:         loc_oCnt.AddObject("cmd_4c_CmdXml", "CommandButton")
1338:         WITH loc_oCnt.cmd_4c_CmdXml
1339:             .Left            = 720
1340:             .Top             = 0
1341:             .Width           = 102
1342:             .Height          = 40
1343:             .FontName        = "Comic Sans MS"
1344:             .FontBold        = .T.
1345:             .FontItalic      = .T.
1346:             .FontSize        = 7
1347:             .WordWrap        = .T.
1348:             .ForeColor       = RGB(90, 90, 90)
1349:             .BackColor       = RGB(255, 255, 255)
1350:             .Themes          = .T.
1351:             .PicturePosition = 1
1352:             .MousePointer    = 15
1353:             .Caption         = "Importar XML"
1354:             .ToolTipText     = "Importar XML"
1355:             .Picture         = gc_4c_CaminhoIcones + "images.jpg"
1356:             .DisabledPicture = gc_4c_CaminhoIcones + "images.jpg"
1357:         ENDWITH
1358:         BINDEVENT(loc_oCnt.cmd_4c_CmdXml, "Click", THIS, "CmdXmlClick")
1359: 
1360:         loc_oCnt.AddObject("cmd_4c_Btncarregar", "CommandButton")
1361:         WITH loc_oCnt.cmd_4c_Btncarregar
1362:             .Left            = 822
1363:             .Top             = 0
1364:             .Width           = 102
1365:             .Height          = 40
1366:             .FontName        = "Comic Sans MS"
1367:             .FontBold        = .T.
1368:             .FontItalic      = .T.
1369:             .FontSize        = 8
1370:             .WordWrap        = .T.
1371:             .ForeColor       = RGB(90, 90, 90)
1372:             .BackColor       = RGB(255, 255, 255)
1373:             .Themes          = .T.
1374:             .PicturePosition = 1
1375:             .MousePointer    = 15
1376:             .Caption         = "Carrega Cadastro"
1377:             .ToolTipText     = "Carregar Cadastro"
1378:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
1379:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
1380:         ENDWITH
1381:         BINDEVENT(loc_oCnt.cmd_4c_Btncarregar, "Click", THIS, "BtncarregarClick")
1382: 
1383:         loc_oCnt.AddObject("cmd_4c_BtnRetCash", "CommandButton")
1384:         WITH loc_oCnt.cmd_4c_BtnRetCash
1385:             .Left            = 924
1386:             .Top             = 0
1387:             .Width           = 102
1388:             .Height          = 40
1389:             .FontName        = "Comic Sans MS"
1390:             .FontBold        = .T.
1391:             .FontItalic      = .T.
1392:             .FontSize        = 8
1393:             .WordWrap        = .T.
1394:             .ForeColor       = RGB(90, 90, 90)
1395:             .BackColor       = RGB(255, 255, 255)
1396:             .Themes          = .T.
1397:             .PicturePosition = 1
1398:             .MousePointer    = 15
1399:             .Caption         = "Retorna B" + CHR(244) + "nus"
1400:             .ToolTipText     = "Retorna B" + CHR(244) + "nus"
1401:             .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
1402:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
1403:         ENDWITH
1404:         BINDEVENT(loc_oCnt.cmd_4c_BtnRetCash, "Click", THIS, "BtnRetCashClick")
1405:     ENDPROC
1406: 
1407:     *==========================================================================
1408:     * ConfigurarBotoesAcao - Preenche cnt_4c_BotoesAcao (Top=359 no legado).
1409:     *==========================================================================
1410:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
1411:         LOCAL loc_oCnt
1412:         loc_oCnt = THIS.cnt_4c_BotoesAcao
1413: 
1414:         loc_oCnt.AddObject("cmd_4c_BtnCadPro", "CommandButton")
1415:         WITH loc_oCnt.cmd_4c_BtnCadPro
1416:             .Left            = 39
1417:             .Top             = 0
1418:             .Width           = 100
1419:             .Height          = 40
1420:             .FontName        = "Tahoma"
1421:             .FontBold        = .T.
1422:             .FontItalic      = .T.
1423:             .FontSize        = 7
1424:             .WordWrap        = .T.
1425:             .ForeColor       = RGB(90, 90, 90)
1426:             .BackColor       = RGB(255, 255, 255)
1427:             .Themes          = .T.
1428:             .PicturePosition = 1
1429:             .MousePointer    = 15
1430:             .Caption         = "Ca\<dastro de Produtos"
1431:             .ToolTipText     = "Cadastro de Produtos"
1432:             .Picture         = gc_4c_CaminhoIcones + "geral_produto_26.jpg"
1433:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_produto_26.jpg"
1434:         ENDWITH
1435:         BINDEVENT(loc_oCnt.cmd_4c_BtnCadPro, "Click", THIS, "BtnCadProClick")
1436: 
1437:         loc_oCnt.AddObject("cmd_4c_BtnPApaga", "CommandButton")
1438:         WITH loc_oCnt.cmd_4c_BtnPApaga
1439:             .Left            = 139
1440:             .Top             = 0
1441:             .Width           = 100
1442:             .Height          = 40
1443:             .FontName        = "Tahoma"
1444:             .FontBold        = .T.
1445:             .FontItalic      = .T.
1446:             .FontSize        = 7
1447:             .WordWrap        = .T.
1448:             .ForeColor       = RGB(90, 90, 90)
1449:             .BackColor       = RGB(255, 255, 255)
1450:             .Themes          = .T.
1451:             .PicturePosition = 1
1452:             .MousePointer    = 15
1453:             .Caption         = "E\<xclus" + CHR(227) + "o de Produtos"
1454:             .ToolTipText     = "Apagar Produto da Grade"
1455:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1456:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1457:         ENDWITH
1458:         BINDEVENT(loc_oCnt.cmd_4c_BtnPApaga, "Click", THIS, "BtnPApagaClick")
1459: 
1460:         loc_oCnt.AddObject("cmd_4c_BtnCompos", "CommandButton")
1461:         WITH loc_oCnt.cmd_4c_BtnCompos
1462:             .Left            = 239
1463:             .Top             = 0
1464:             .Width           = 100
1465:             .Height          = 40
1466:             .FontName        = "Tahoma"
1467:             .FontBold        = .T.
1468:             .FontItalic      = .T.
1469:             .FontSize        = 7
1470:             .WordWrap        = .T.
1471:             .ForeColor       = RGB(90, 90, 90)
1472:             .BackColor       = RGB(255, 255, 255)
1473:             .Themes          = .T.
1474:             .PicturePosition = 1
1475:             .MousePointer    = 15
1476:             .Caption         = "Carregar Compo\<si" + CHR(231) + CHR(227) + "o"
1477:             .ToolTipText     = "Componentes"
1478:             .Picture         = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
1479:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
1480:         ENDWITH
1481:         BINDEVENT(loc_oCnt.cmd_4c_BtnCompos, "Click", THIS, "BtnComposClick")
1482: 
1483:         loc_oCnt.AddObject("cmd_4c_BtnAltPrecos", "CommandButton")
1484:         WITH loc_oCnt.cmd_4c_BtnAltPrecos
1485:             .Left            = 339
1486:             .Top             = 0
1487:             .Width           = 100
1488:             .Height          = 40
1489:             .FontName        = "Tahoma"
1490:             .FontBold        = .T.
1491:             .FontItalic      = .T.
1492:             .FontSize        = 7
1493:             .WordWrap        = .T.
1494:             .ForeColor       = RGB(90, 90, 90)
1495:             .BackColor       = RGB(255, 255, 255)
1496:             .Themes          = .T.
1497:             .PicturePosition = 1
1498:             .MousePointer    = 15
1499:             .Caption         = "Al\<tera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os"
1500:             .ToolTipText     = "Alterar Pre" + CHR(231) + "os"
1501:             .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
1502:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
1503:         ENDWITH
1504:         BINDEVENT(loc_oCnt.cmd_4c_BtnAltPrecos, "Click", THIS, "BtnAltPrecosClick")
1505: 
1506:         loc_oCnt.AddObject("cmd_4c_BtnPBuscas", "CommandButton")
1507:         WITH loc_oCnt.cmd_4c_BtnPBuscas
1508:             .Left            = 439
1509:             .Top             = 0
1510:             .Width           = 100
1511:             .Height          = 40
1512:             .FontName        = "Tahoma"
1513:             .FontBold        = .T.
1514:             .FontItalic      = .T.
1515:             .FontSize        = 7
1516:             .WordWrap        = .T.
1517:             .ForeColor       = RGB(90, 90, 90)
1518:             .BackColor       = RGB(255, 255, 255)
1519:             .Themes          = .T.
1520:             .PicturePosition = 1
1521:             .MousePointer    = 15
1522:             .Caption         = "Proc\<ura de Produtos"
1523:             .ToolTipText     = "Procurar Produtos"
1524:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
1525:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
1526:         ENDWITH
1527:         BINDEVENT(loc_oCnt.cmd_4c_BtnPBuscas, "Click", THIS, "BtnPBuscasClick")
1528: 
1529:         loc_oCnt.AddObject("cmd_4c_BtnPedido", "CommandButton")
1530:         WITH loc_oCnt.cmd_4c_BtnPedido
1531:             .Left            = 539
1532:             .Top             = 0
1533:             .Width           = 100
1534:             .Height          = 40
1535:             .FontName        = "Tahoma"
1536:             .FontBold        = .T.
1537:             .FontItalic      = .T.
1538:             .FontSize        = 7
1539:             .WordWrap        = .T.
1540:             .ForeColor       = RGB(90, 90, 90)
1541:             .BackColor       = RGB(255, 255, 255)
1542:             .Themes          = .T.
1543:             .PicturePosition = 1
1544:             .MousePointer    = 15
1545:             .Caption         = "Informar Pedido"
1546:             .Picture         = gc_4c_CaminhoIcones + "geral_documento_26.jpg"
1547:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_documento_26.jpg"
1548:         ENDWITH
1549:         BINDEVENT(loc_oCnt.cmd_4c_BtnPedido, "Click", THIS, "BtnPedidoClick")
1550: 
1551:         loc_oCnt.AddObject("cmd_4c_Btnsubcp", "CommandButton")
1552:         WITH loc_oCnt.cmd_4c_Btnsubcp
1553:             .Left            = 639
1554:             .Top             = 0
1555:             .Width           = 100
1556:             .Height          = 40
1557:             .FontName        = "Tahoma"
1558:             .FontBold        = .T.
1559:             .FontItalic      = .T.
1560:             .FontSize        = 7
1561:             .WordWrap        = .T.
1562:             .ForeColor       = RGB(90, 90, 90)
1563:             .BackColor       = RGB(255, 255, 255)
1564:             .Themes          = .T.
1565:             .PicturePosition = 1
1566:             .MousePointer    = 15
1567:             .Caption         = "\<Substituir Composi" + CHR(231) + CHR(227) + "o"
1568:             .ToolTipText     = "Componentes"
1569:             .Picture         = gc_4c_CaminhoIcones + "geral_subnivel_26.jpg"
1570:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_subnivel_26.jpg"
1571:         ENDWITH
1572:         BINDEVENT(loc_oCnt.cmd_4c_Btnsubcp, "Click", THIS, "BtnsubcpClick")
1573: 
1574:         loc_oCnt.AddObject("cmd_4c_BtnDet", "CommandButton")
1575:         WITH loc_oCnt.cmd_4c_BtnDet
1576:             .Left            = 639
1577:             .Top             = 0
1578:             .Width           = 100
1579:             .Height          = 40
1580:             .FontName        = "Tahoma"
1581:             .FontBold        = .T.
1582:             .FontItalic      = .T.
1583:             .FontSize        = 7
1584:             .ForeColor       = RGB(90, 90, 90)
1585:             .BackColor       = RGB(255, 255, 255)
1586:             .Themes          = .T.
1587:             .PicturePosition = 1
1588:             .MousePointer    = 15
1589:             .Caption         = "Detalhes"
1590:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1591:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1592:         ENDWITH
1593:         BINDEVENT(loc_oCnt.cmd_4c_BtnDet, "Click", THIS, "BtnDetClick")
1594: 
1595:         *-- cmd_4c_BtnOptFin e cmd_4c_BtnDesc ocupam o MESMO Left=746 no SCX legado
1596:         *-- (feature mutuamente exclusiva por configuracao da operacao) -
1597:         *-- transcrito literal do dump, sem inventar posicao nova.
1598:         loc_oCnt.AddObject("cmd_4c_BtnOptFin", "CommandButton")
1599:         WITH loc_oCnt.cmd_4c_BtnOptFin
1600:             .Left            = 739
1601:             .Top             = 0
1602:             .Width           = 100
1603:             .Height          = 40
1604:             .FontName        = "Tahoma"
1605:             .FontBold        = .T.
1606:             .FontItalic      = .T.
1607:             .FontSize        = 7
1608:             .ForeColor       = RGB(90, 90, 90)
1609:             .BackColor       = RGB(255, 255, 255)
1610:             .Themes          = .T.
1611:             .PicturePosition = 1
1612:             .MousePointer    = 15
1613:             .Caption         = "Finalidade"
1614:             .ToolTipText     = "Selecionar Finalidade da opera" + CHR(231) + CHR(227) + "o para ser usada no relat" + CHR(243) + "rio de opera" + CHR(231) + CHR(245) + "es."
1615:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1616:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1617:         ENDWITH
1618:         BINDEVENT(loc_oCnt.cmd_4c_BtnOptFin, "Click", THIS, "BtnOptFinClick")
1619: 
1620:         loc_oCnt.AddObject("cmd_4c_BtnDesc", "CommandButton")
1621:         WITH loc_oCnt.cmd_4c_BtnDesc
1622:             .Left            = 739
1623:             .Top             = 0
1624:             .Width           = 100
1625:             .Height          = 40
1626:             .FontName        = "Tahoma"
1627:             .FontBold        = .T.
1628:             .FontItalic      = .T.
1629:             .FontSize        = 7
1630:             .ForeColor       = RGB(90, 90, 90)
1631:             .BackColor       = RGB(255, 255, 255)
1632:             .Themes          = .T.
1633:             .PicturePosition = 1
1634:             .MousePointer    = 15
1635:             .Caption         = "Descontos"
1636:             .ToolTipText     = "Selecionar Finalidade da opera" + CHR(231) + CHR(227) + "o para ser usada no relat" + CHR(243) + "rio de opera" + CHR(231) + CHR(245) + "es."
1637:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1638:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1639:         ENDWITH
1640:         BINDEVENT(loc_oCnt.cmd_4c_BtnDesc, "Click", THIS, "BtnDescClick")
1641: 
1642:         loc_oCnt.AddObject("cmd_4c_BtnLocDes", "CommandButton")
1643:         WITH loc_oCnt.cmd_4c_BtnLocDes
1644:             .Left            = 839
1645:             .Top             = 0
1646:             .Width           = 100
1647:             .Height          = 40
1648:             .FontName        = "Tahoma"
1649:             .FontBold        = .T.
1650:             .FontItalic      = .T.
1651:             .FontSize        = 7
1652:             .ForeColor       = RGB(90, 90, 90)
1653:             .BackColor       = RGB(255, 255, 255)
1654:             .Themes          = .T.
1655:             .PicturePosition = 1
1656:             .MousePointer    = 15
1657:             .Caption         = "Local. Destino"
1658:             .ToolTipText     = "Selecionar Localiza" + CHR(231) + CHR(227) + "o de Destino do Produto"
1659:             .Picture         = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1660:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1661:         ENDWITH
1662:         BINDEVENT(loc_oCnt.cmd_4c_BtnLocDes, "Click", THIS, "BtnLocDesClick")
1663: 
1664:         loc_oCnt.AddObject("cmd_4c_BtnLocOri", "CommandButton")
1665:         WITH loc_oCnt.cmd_4c_BtnLocOri
1666:             .Left            = 939
1667:             .Top             = 0
1668:             .Width           = 100
1669:             .Height          = 40
1670:             .FontName        = "Tahoma"
1671:             .FontBold        = .T.
1672:             .FontItalic      = .T.
1673:             .FontSize        = 7
1674:             .ForeColor       = RGB(90, 90, 90)
1675:             .BackColor       = RGB(255, 255, 255)
1676:             .Themes          = .T.
1677:             .PicturePosition = 1
1678:             .MousePointer    = 15
1679:             .Caption         = "Local. Origem"
1680:             .ToolTipText     = "Selecionar Localiza" + CHR(231) + CHR(227) + "o de Origem do Produto"
1681:             .Picture         = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1682:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1683:         ENDWITH
1684:         BINDEVENT(loc_oCnt.cmd_4c_BtnLocOri, "Click", THIS, "BtnLocOriClick")
1685:     ENDPROC
1686: 
1687:     *==========================================================================
1688:     * ReaplicarVisibilidadeInicial - TornarControlesVisiveis forca Visible=.T.
1689:     * em tudo; aqui escondemos de volta os botoes que o SCX legado declara
1690:     * Visible=.F. por padrao (toggle condicional a configuracao da operacao,
1691:     * ainda nao conectada nesta fase).
1692:     *==========================================================================
1693:     PROTECTED PROCEDURE ReaplicarVisibilidadeInicial()
1694:         THIS.cnt_4c_Botoes.cmd_4c_BtnRetCash.Visible    = .F.
1695:         THIS.cnt_4c_Botoes.cmd_4c_Btndevolu.Visible      = .F.
1696:         THIS.cnt_4c_Botoes.cmd_4c_BtnRecImps.Visible     = .F.
1697:         THIS.cnt_4c_Botoes.cmd_4c_BtnAltImps.Visible     = .F.
1698:         THIS.cnt_4c_Botoes.cmd_4c_BtnCotacao.Visible     = .F.
1699:         THIS.cnt_4c_Botoes.cmd_4c_BtnTotItens.Visible    = .F.
1700:         THIS.cnt_4c_Botoes.chk_4c_BtnVerImps.Visible     = .F.
1701:         THIS.cnt_4c_Botoes.cmd_4c_Btncarregar.Visible    = .F.
1702:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnLocDes.Visible  = .F.
1703:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnDet.Visible     = .F.
1704: 
1705:         *-- Page1 (pgProds): controles que o SCX legado declara Visible = .F.
1706:         WITH THIS.pgf_4c_Paginas.Page1
1707:             .cnt_4c_Obs.Visible        = .F.
1708:             .img_4c_ImgProds.Visible   = .F.
1709:             .txt_4c_Valors.Visible     = .F.
1710:             .lbl_4c_LblValors.Visible  = .F.
1711:             .txt_4c_CodCors.Visible    = .F.
1712:             .lbl_4c_LblCodCors.Visible = .F.
1713:             .txt_4c_CodTams.Visible    = .F.
1714:             .lbl_4c_LblCodTams.Visible = .F.
1715:             .txt_4c_GerDIfors.Visible  = .F.
1716:             .lbl_4c_Label15.Visible    = .F.
1717:         ENDWITH
1718: 
1719:         *-- Page4 (pgPrecos): a grade de precificacao nasce oculta no legado.
1720:         *-- Mesmo nome do grid principal (eh o que o mapeamento do form manda),
1721:         *-- mas outro PAI - o caminho completo nao deixa ambiguidade.
1722:         THIS.pgf_4c_Paginas.Page4.grd_4c_Dados.Visible = .F.
1723:     ENDPROC
1724: 
1725:     *==========================================================================
1726:     * AjustarBotoesPorModo - Espelha os guards When do legado (InList sobre
1727:     * Op_Escolha + linha corrente na grade). Chamado no fim de InicializarForm
1728:     * e deve ser repetido apos qualquer troca de modo/linha (regra #40).
1729:     * PUBLIC: o TesteAutomatico chama THIS.oForm.AjustarBotoesPorModo() de
1730:     * FORA da classe, e PEMSTATUS(...,5) devolve .T. mesmo para PROTECTED
1731:     * (so testa existencia, nao escopo) - entao o harness entraria no branch
1732:     * e a chamada estouraria em runtime (regra #3).
1733:     *==========================================================================
1734:     PROCEDURE AjustarBotoesPorModo()
1735:         LOCAL loc_lEdicao, loc_lTemLinha
1736: 
1737:         loc_lEdicao   = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
1738:         loc_lTemLinha = USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens") ;
1739:                         AND RECCOUNT("cursor_4c_Itens") > 0
1740: 
1741:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnCadPro.Enabled    = loc_lEdicao AND loc_lTemLinha
1742:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnPApaga.Enabled    = loc_lEdicao AND loc_lTemLinha
1743:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnCompos.Enabled    = loc_lEdicao AND loc_lTemLinha
1744:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnAltPrecos.Enabled = loc_lEdicao AND loc_lTemLinha
1745:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnPedido.Enabled    = loc_lEdicao AND loc_lTemLinha
1746:         THIS.cnt_4c_BotoesAcao.cmd_4c_Btnsubcp.Enabled     = loc_lTemLinha
1747:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnDet.Enabled       = loc_lTemLinha
1748:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnOptFin.Enabled    = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
1749:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnDesc.Enabled      = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
1750:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnLocOri.Enabled    = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
1751:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnLocDes.Enabled    = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
1752:         THIS.cnt_4c_BotoesAcao.cmd_4c_BtnPBuscas.Enabled   = .T.
1753: 
1754:         THIS.cnt_4c_Botoes.cmd_4c_BtnIteSub.Enabled    = loc_lEdicao
1755:         THIS.cnt_4c_Botoes.cmd_4c_CmdXml.Enabled       = loc_lEdicao
1756:         THIS.cnt_4c_Botoes.cmd_4c_Btncarregar.Enabled  = loc_lEdicao
1757:         THIS.cnt_4c_Botoes.cmd_4c_BtnTotItens.Enabled  = loc_lEdicao
1758:         THIS.cnt_4c_Botoes.cmd_4c_BtnCotacao.Enabled   = loc_lEdicao
1759:         THIS.cnt_4c_Botoes.cmd_4c_BtnAltImps.Enabled   = loc_lEdicao AND loc_lTemLinha
1760:         THIS.cnt_4c_Botoes.cmd_4c_BtnRecImps.Enabled   = loc_lTemLinha
1761:         THIS.cnt_4c_Botoes.cmd_4c_Btndevolu.Enabled    = loc_lTemLinha
1762:         THIS.cnt_4c_Botoes.cmd_4c_BtnRetCash.Enabled   = loc_lEdicao
1763:         THIS.cnt_4c_Botoes.chk_4c_BtnVerImps.Enabled   = loc_lTemLinha
1764:     ENDPROC
1765: 
1766:     *==========================================================================
1767:     * AlternarPagina - PUBLIC (chamado de fora pelo TesteAutomatico e pelo
1768:     * form pai). Troca a aba ativa de pgf_4c_Paginas (1=Produto, 2=Movimenta-
1769:     * cao, 3=Fiscal, 4=Precificacao).
1770:     *==========================================================================
1771:     PROCEDURE AlternarPagina(par_nPagina)
1772:         IF !BETWEEN(par_nPagina, 1, THIS.pgf_4c_Paginas.PageCount)
1773:             RETURN .F.
1774:         ENDIF
1775: 
1776:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1777: 
1778:         *-- Refresh em pagina OCULTA nao pinta (regra #46): o painel do item
1779:         *-- so eh atualizado DEPOIS de a aba virar a ativa.
1780:         IF INLIST(par_nPagina, 1, 3)
1781:             THIS.AtualizarPainelProduto()
1782:         ENDIF
1783: 
1784:         THIS.pgf_4c_Paginas.Pages(par_nPagina).Refresh()
1785: 
1786:         RETURN .T.
1787:     ENDPROC
1788: 
1789:     *==========================================================================
1790:     * TemProdutoSelecionado - cursor_4c_Itens posicionado em linha com
1791:     * produto preenchido (equivalente a !Eof('crTpmMvItn') And !Empty(Cpros)
1792:     * usado nos guards When do legado).
1793:     *==========================================================================
1794:     PROTECTED FUNCTION TemProdutoSelecionado()
1795:         RETURN USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens") ;
1796:                AND !EMPTY(cursor_4c_Itens.cpros)
1797:     ENDFUNC
1798: 
1799:     *==========================================================================
1800:     * CarregarDados - Carga da grade de itens da movimentacao. PUBLIC: eh
1801:     * chamado de fora (TesteAutomatico / form pai) e pelo funil de recarga.
1802:     *
1803:     * Equivale ao AddCursor('SigMvItn', ...) que o legado herda do form pai
1804:     * de Movimentacao (crTpmMvItn) seguido de "Select crTpmMvItn / Goto Top"
1805:     * no fim do Init.
1806:     *
1807:     * O BO le para um cursor TEMPORARIO e aqui o alias da grade eh recarregado
1808:     * com SELECT/ZAP/APPEND FROM DBF(): SQLEXEC direto sobre o alias ligado ao
1809:     * Grid o FECHA e RECRIA, zerando o ColumnCount - a grade viraria um
1810:     * retangulo branco sem cabecalho, sem erro e sem log.
1811:     *==========================================================================
1812:     PROCEDURE CarregarDados()
1813:         LOCAL loc_lSucesso, loc_cChave, loc_oErro
1814: 
1815:         loc_lSucesso = .F.
1816: 
1817:         IF !USED("cursor_4c_Itens")
1818:             THIS.CriarCursorItens()
1819:         ENDIF
1820: 
1821:         loc_cChave = THIS.ObterChaveMovimentacao()
1822: 
1823:         IF EMPTY(loc_cChave)
1824:             *-- Sem movimentacao selecionada a grade abre VAZIA, como no legado
1825:             *-- (o cursor do pai nasce sem linha). Nao eh falha: repinta e sai.
1826:             THIS.PrepararLinhaInicial()
1827:             THIS.RepintarGradeItens()
1828:             THIS.AjustarBotoesPorModo()
1829:             RETURN .F.
1830:         ENDIF
1831: 
1832:         TRY
1833:             IF THIS.this_oBusinessObject.CarregarItens(loc_cChave, "cursor_4c_ItensTmp")
1834:                 THIS.ZaparCursorItens()
1835:                 IF USED("cursor_4c_ItensTmp")
1836:                     SELECT cursor_4c_Itens
1837:                     APPEND FROM DBF("cursor_4c_ItensTmp")
1838:                 ENDIF
1839:                 loc_lSucesso = .T.
1840:             ENDIF
1841: 
1842:             IF USED("cursor_4c_ItensTmp")
1843:                 USE IN cursor_4c_ItensTmp
1844:             ENDIF
1845: 
1846:         CATCH TO loc_oErro
1847:             THIS.this_cMensagemErro = loc_oErro.Message
1848:             MsgErro("Erro ao carregar os itens da movimenta" + CHR(231) + CHR(227) + ;
1849:                     "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1850:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1851:                     "Proc: " + loc_oErro.Procedure, "Erro CarregarDados")
1852:         ENDTRY
1853: 
1854:         *-- Em edicao o legado fecha o Init entregando a linha de digitacao
1855:         *-- (Count To lnCount / CItem = lnCount / minserelinha)
1856:         THIS.PrepararLinhaInicial()
1857: 
1858:         *-- Funil unico: popular o cursor NAO repinta a grade (regra #21)
1859:         THIS.RepintarGradeItens()
1860:         THIS.AplicarModoNaGrade()
1861:         THIS.AjustarBotoesPorModo()
1862: 
1863:         RETURN loc_lSucesso
1864:     ENDPROC
1865: 
1866:     *==========================================================================
1867:     * PrepararLinhaInicial - Fecho do Init legado, que em INSERIR/ALTERAR
1868:     * entrega uma linha em branco pronta para digitacao:
1869:     *
1870:     *   Select crTpmMvItn / Set Order To
1871:     *   If Thisform.Op_Escolha = 'ALTERAR' Or crSigCdOpe.SubnObrigs = 3
1872:     *       Count To lnCount / Thisform.CItem = lnCount / Thisform.minserelinha()
1873:     *   Else
1874:     *       If Thisform.Op_Escolha = 'INSERIR'
1875:     *           Count To lnCount / Thisform.CItem = lnCount / minserelinha()
1876:     *       Endif
1877:     *   Endif
1878:     *
1879:     * Em CONSULTAR/EXCLUIR o legado NAO entrega linha nova (a grade abre so
1880:     * com o que foi gravado), e o mesmo vale aqui.
1881:     *==========================================================================
1882:     PROTECTED PROCEDURE PrepararLinhaInicial()
1883:         LOCAL loc_nRegistros
1884: 
1885:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
1886:             RETURN .F.
1887:         ENDIF
1888: 
1889:         IF !USED("cursor_4c_Itens")
1890:             RETURN .F.
1891:         ENDIF
1892: 
1893:         SELECT cursor_4c_Itens
1894:         COUNT TO loc_nRegistros
1895:         THIS.this_nCItem = loc_nRegistros
1896: 
1897:         RETURN THIS.InserirLinhaGrade()
1898:     ENDPROC
1899: 
1900:     *==========================================================================
1901:     * RepintarGradeItens - FUNIL UNICO de repintura da grade. Popular o cursor
1902:     * NAO faz a grade exibir as linhas (regra #21): o legado sempre fecha com
1903:     * "Go Top In crTpmMvItn" + "fwGrade.Refresh". Tem de rodar em TODO caminho
1904:     * que mexe no cursor (carga, exclusao de linha, troca de modo) e DEPOIS de
1905:     * trocar o ActivePage - Refresh em pagina oculta nao pinta.
1906:     *==========================================================================
1907:     PROCEDURE RepintarGradeItens()
1908:         IF !USED("cursor_4c_Itens")
1909:             RETURN
1910:         ENDIF
1911: 
1912:         SELECT cursor_4c_Itens
1913:         GO TOP
1914: 
1915:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1916:             *-- Reinstala os CheckBox de coluna antes de repintar: se algo
1917:             *-- tiver reatribuido RecordSource/ColumnCount ou fechado o
1918:             *-- alias, os objetos postos nas Columns foram destruidos. A
1919:             *-- instalacao eh idempotente.
1920:             THIS.InstalarCheckBoxesGrade()
1921:             THIS.grd_4c_Dados.Refresh()
1922:         ENDIF
1923:     ENDPROC
1924: 
1925:     *==========================================================================
1926:     * ZaparCursorItens - ZAP guardado por SAFETY. SET SAFETY eh escopado por
1927:     * DATA SESSION: este form eh DataSession = 2, e na sessao privada SAFETY
1928:     * vale ON mesmo com o SET SAFETY OFF do main.prg. Com SAFETY ON o ZAP
1929:     * abre o dialogo modal "Zap ... Are you sure?" e CONGELA a tela,
1930:     * esperando um clique que ninguem ve (nao eh erro: em teste headless
1931:     * aparece como timeout sem resultado).
1932:     *
1933:     * ZAP eh a escolha CERTA aqui (o legado faz "Zap In <cursor>"): preserva
1934:     * a estrutura e o binding do Grid. Fechar e recriar o alias derrubaria
1935:     * RecordSource/ControlSource e a grade ficaria vazia com o cursor cheio.
1936:     *==========================================================================
1937:     PROTECTED PROCEDURE ZaparCursorItens()
1938:         LOCAL loc_cSafety
1939: 
1940:         IF !USED("cursor_4c_Itens")
1941:             RETURN
1942:         ENDIF
1943: 
1944:         loc_cSafety = SET("SAFETY")
1945:         SET SAFETY OFF
1946: 
1947:         SELECT cursor_4c_Itens
1948:         ZAP
1949: 
1950:         IF loc_cSafety = "ON"
1951:             SET SAFETY ON
1952:         ENDIF
1953:     ENDPROC
1954: 
1955:     *==========================================================================
1956:     * AplicarModoNaGrade - Espelha o par fwGrade/fwGradeR do legado. No legado sao
1957:     * duas grades mutuamente exclusivas sobre o MESMO cursor, e o proprio
1958:     * legado alinha a segunda na posicao da primeira (".Left = fwGrade.Left /
1959:     * .Top = fwGrade.Top / .Height = fwGrade.Height"), isto eh: visualmente
1960:     * eh UMA grade que alterna entre editavel e somente-leitura.
1961:     *
1962:     * Legado: fwGrade  (editavel)      -> INSERIR, ou ALTERAR com AltEtiqs # 1
1963:     *         fwGradeR (somente-leit.) -> EXCLUIR/CONSULTAR, ou ALTERAR com
1964:     *                                     AltEtiqs = 1
1965:     *
1966:     * Column.ReadOnly vem DEPOIS de Grid.ReadOnly: o do grid propaga para as
1967:     * colunas e sobrescreveria (regra #18).
1968:     *==========================================================================
1969:     PROCEDURE AplicarModoNaGrade()
1970:         LOCAL loc_lEditavel
1971: 
1972:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1973:             RETURN
1974:         ENDIF
1975: 
1976:         loc_lEditavel = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
1977: 
1978:         WITH THIS.grd_4c_Dados
1979:             .ReadOnly = !loc_lEditavel
1980:             .Enabled  = .T.
1981:             *-- Reserva eh ReadOnly tambem na grade editavel (legado:
1982:             *-- fwGrade.Column20.ReadOnly = .T.)
1983:             .Column20.ReadOnly = .T.
1984:         ENDWITH
1985:     ENDPROC
1986: 
1987:     *==========================================================================
1988:     * ObterChaveMovimentacao - empdopnums char(29) da movimentacao corrente.
1989:     * Vem do form pai de Movimentacao (TprMvCab no legado); enquanto a
1990:     * integracao com o pai nao esta conectada, cai na property do proprio
1991:     * form, que o chamador preenche antes do Show.
1992:     *==========================================================================
1993:     PROTECTED FUNCTION ObterChaveMovimentacao()
1994:         LOCAL loc_cChave
1995: 
1996:         loc_cChave = ""
1997: 
1998:         IF !EMPTY(THIS.this_cEmpDopNums)
1999:             loc_cChave = THIS.this_cEmpDopNums
2000:         ELSE
2001:             IF !EMPTY(THIS.this_cEmps + THIS.this_cDopes) OR THIS.this_nNumes <> 0
2002:                 loc_cChave = THIS.this_oBusinessObject.MontarChaveEmpDopNums( ;
2003:                                  THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)
2004:             ENDIF
2005:         ENDIF
2006: 
2007:         RETURN loc_cChave
2008:     ENDFUNC
2009: 
2010:     *==========================================================================
2011:     * InserirLinhaGrade - Equivale a PROCEDURE minserelinha do legado, que eh
2012:     * o "Incluir" desta tela: a inclusao de produto aqui NAO vem de um botao,
2013:     * vem de uma LINHA EM BRANCO entregue na grade para o usuario digitar o
2014:     * codigo. O legado chama este metodo no fim do Init (quando Op_Escolha eh
2015:     * INSERIR ou ALTERAR) e a cada vez que o usuario termina uma linha.
2016:     *
2017:     * Legado:
2018:     *   Select crTpmMvItn / Set Order to CPros / Count to wRegistros
2019:     *   Seek Space(14)                       && procura linha com produto vazio
2020:     *   If Not Eof()                         && achou: nao insere, so desce
2021:     *       If Not ThisForm.lAutPreco / keyboard "{DNARROW}" / EndIf
2022:     *   Else
2023:     *       If wRegistros < crSigCdOpe.qtdites
2024:     *           ThisForm.CItem = ThisForm.CItem + 1
2025:     *           Insert Into crTpmMvItn( Emps, Dopes, Numes, Citens ) Values (...)
2026:     *       EndIf
2027:     *   EndIf
2028:     *   ThisForm.OldCodBarras = 0 / AntCPro = Space(14) / AntValu = Space(3)
2029:     *
2030:     * O cursor migrado nao tem a tag CPros do legado, entao a procura da linha
2031:     * em branco eh LOCATE FOR EMPTY(cpros) - mesmo efeito do Seek Space(14).
2032:     * O "keyboard {DNARROW}" do legado era a forma de levar o foco da grade
2033:     * para a linha nova; aqui o equivalente eh posicionar o cursor nela e
2034:     * repintar, porque a navegacao nao depende da fila de teclado.
2035:     *
2036:     * PUBLIC: o form pai e o harness de teste chamam de fora.
2037:     *==========================================================================
2038:     PROCEDURE InserirLinhaGrade()
2039:         LOCAL loc_nRegistros, loc_lTemLimite, loc_lInseriu
2040: 
2041:         IF !USED("cursor_4c_Itens")
2042:             RETURN .F.
2043:         ENDIF
2044: 
2045:         loc_lInseriu = .F.
2046: 
2047:         SELECT cursor_4c_Itens
2048:         COUNT TO loc_nRegistros
2049: 
2050:         LOCATE FOR EMPTY(cpros)
2051: 
2052:         IF !FOUND()
2053:             *-- Nenhuma linha em branco na grade: entrega uma nova, respeitando
2054:             *-- o teto de itens da operacao quando ele existe (legado:
2055:             *-- "If wRegistros < crSigCdOpe.qtdites").
2056:             loc_lTemLimite = (THIS.this_nQtdItes > 0)
2057: 
2058:             IF !loc_lTemLimite OR loc_nRegistros < THIS.this_nQtdItes
2059:                 THIS.this_nCItem = THIS.this_nCItem + 1
2060: 
2061:                 INSERT INTO cursor_4c_Itens (emps, dopes, numes, citens, empdopnums) ;
2062:                     VALUES (PADR(THIS.this_cEmps, 3), PADR(THIS.this_cDopes, 20), ;
2063:                             THIS.this_nNumes, THIS.this_nCItem, ;
2064:                             THIS.ObterChaveMovimentacao())
2065: 
2066:                 loc_lInseriu = .T.
2067:             ENDIF
2068:         ENDIF
2069: 
2070:         *-- Em qualquer um dos dois caminhos a linha corrente passa a ser a de
2071:         *-- digitacao (a que estava em branco, ou a recem-inserida).
2072:         THIS.RepintarGradeItens()
2073:         THIS.AjustarBotoesPorModo()
2074: 
2075:         RETURN loc_lInseriu
2076:     ENDPROC
2077: 
2078:     *==========================================================================
2079:     * LimparLinhaGrade - Equivale a PROCEDURE apaite do legado: a linha NAO eh
2080:     * removida, so esvaziada, voltando a ser uma linha de digitacao. O legado
2081:     * usa este caminho quando a linha corrente ja esta sem produto e eh a
2082:     * UNICA em branco (ver ExcluirLinhaGrade).
2083:     *
2084:     * Legado (apaite): Replace DPros/Obs/CodBarras/Utilizas/NumeroNota/Notas,
2085:     * apaga os sub-itens da linha (crTpmMvIts com o mesmo CItens) e zera as
2086:     * celulas da grade (Produto, Operacao, Qtd, Peso, Comprimento, Fator,
2087:     * PesoTot, Valor, Moeda, Total), repondo Operacao com 'E' ou 'S' conforme
2088:     * crSigCdOpe.Opers. A operacao reposta aqui vem da propria linha do legado
2089:     * (nTpOpers) atraves das linhas irmas do cursor, para nao inventar valor
2090:     * que a configuracao da operacao nao deu.
2091:     *==========================================================================
2092:     PROCEDURE LimparLinhaGrade()
2093:         LOCAL loc_nCitens
2094: 
2095:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
2096:             RETURN .F.
2097:         ENDIF
2098: 
2099:         SELECT cursor_4c_Itens
2100:         loc_nCitens = cursor_4c_Itens.citens
2101: 
2102:         REPLACE cpros      WITH "", ;
2103:                 dpros      WITH "", ;
2104:                 obs        WITH "", ;
2105:                 codbarras  WITH 0, ;
2106:                 utilizas   WITH 0, ;
2107:                 numeronota WITH "", ;
2108:                 notas      WITH ""
2109: 
2110:         REPLACE qtds    WITH 0, ;
2111:                 pesos   WITH 0, ;
2112:                 compris WITH 0, ;
2113:                 fators  WITH 0, ;
2114:                 tpesos  WITH 0, ;
2115:                 units   WITH 0, ;
2116:                 moedas  WITH "", ;
2117:                 totas   WITH 0
2118: 
2119:         *-- Sub-itens da linha (composicao): no legado moram em crTpmMvIts e
2120:         *-- aqui convivem no mesmo cursor, apontando o pai por citem2.
2121:         DELETE FOR citem2 = loc_nCitens AND citens <> loc_nCitens
2122: 
2123:         *-- Volta a posicionar na linha esvaziada (o DELETE FOR varre o cursor).
2124:         *-- LOCATE em vez de SEEK: nao depende de qual tag esta ativa, e a
2125:         *-- renumeracao de itens troca a ordem corrente durante o SCAN.
2126:         LOCATE FOR citens = loc_nCitens
2127:         IF !FOUND()
2128:             GO TOP
2129:         ENDIF
2130: 
2131:         THIS.RepintarGradeItens()
2132:         THIS.AjustarBotoesPorModo()
2133: 
2134:         RETURN .T.
2135:     ENDPROC
2136: 
2137:     *==========================================================================
2138:     * ExcluirLinhaGrade - Equivale a PROCEDURE deletaritem do legado, que eh o
2139:     * "Excluir" desta tela: exclusao de LINHA da grade de itens (o registro em
2140:     * SigMvItn so eh gravado/removido pelo form pai de Movimentacao, na
2141:     * confirmacao da operacao).
2142:     *
2143:     * Legado (deletaritem):
2144:     *   If !IsEmpty(crTpmMvItn.cpros)
2145:     *       _CItem = CItens / Delete / apaga os sub-itens de cItem2 = _CItem
2146:     *       Delete For cItem2 = _CItem
2147:     *   Else
2148:     *       Select Count(1) From crTpmMvItn Where IsEmpty(cpros) ... xApaga
2149:     *       If xApaga.Total > 1 / Delete / Else / Thisform.ApaIte() / EndIf
2150:     *   EndIf
2151:     *   Select crTpmMvItn / Go Top
2152:     *
2153:     * Isto eh: linha COM produto sai da grade junto com a composicao dela;
2154:     * linha SEM produto so sai se houver outra em branco - se for a unica, ela
2155:     * eh apenas esvaziada, para a grade nunca ficar sem linha de digitacao.
2156:     *
2157:     * PUBLIC: o form pai e o harness de teste chamam de fora.
2158:     *==========================================================================
2159:     PROCEDURE ExcluirLinhaGrade()
2160:         LOCAL loc_nCitens, loc_nEmBranco, loc_nRecno
2161: 
2162:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
2163:             RETURN .F.
2164:         ENDIF
2165: 
2166:         SELECT cursor_4c_Itens
2167: 
2168:         IF EMPTY(cursor_4c_Itens.cpros)
2169:             *-- COUNT varre o cursor e deixa o ponteiro em EOF: sem repor o
2170:             *-- RECNO, o DELETE abaixo cairia no registro fantasma do fim e
2171:             *-- nao apagaria linha nenhuma (sem erro e sem aviso).
2172:             loc_nRecno = RECNO()
2173:             COUNT FOR EMPTY(cpros) TO loc_nEmBranco
2174:             IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
2175:                 GO loc_nRecno
2176:             ENDIF
2177: 
2178:             IF loc_nEmBranco > 1
2179:                 DELETE
2180:             ELSE
2181:                 *-- Unica linha em branco: esvazia em vez de remover
2182:                 THIS.LimparLinhaGrade()
2183:                 RETURN .T.
2184:             ENDIF
2185:         ELSE
2186:             loc_nCitens = cursor_4c_Itens.citens
2187: 
2188:             DELETE
2189: 
2190:             *-- Composicao da linha excluida (legado: Delete For cItem2 = _CItem)
2191:             DELETE FOR citem2 = loc_nCitens AND citens <> loc_nCitens
2192:         ENDIF
2193: 
2194:         SELECT cursor_4c_Itens
2195:         GO TOP
2196: 
2197:         RETURN .T.
2198:     ENDPROC
2199: 

*-- Linhas 2208 a 2887:
2208:     *         ... Replace cItem2 With Cont For cItem2 = _cIt ... Replace CItens
2209:     *         With Cont / EndScan / Thisform.CItem = Cont
2210:     *==========================================================================
2211:     PROCEDURE RenumerarItensGrade()
2212:         LOCAL loc_nCont, loc_nCitensAnt, loc_nRecno
2213: 
2214:         IF !USED("cursor_4c_Itens")
2215:             RETURN 0
2216:         ENDIF
2217: 
2218:         loc_nCont = 0
2219: 
2220:         SELECT cursor_4c_Itens
2221:         SET ORDER TO
2222:         GO TOP
2223: 
2224:         SCAN
2225:             loc_nCont      = loc_nCont + 1
2226:             loc_nCitensAnt = cursor_4c_Itens.citens
2227:             loc_nRecno     = RECNO()
2228: 
2229:             *-- Primeiro as referencias da composicao, depois o proprio item:
2230:             *-- invertido, o Replace de cItem2 nao encontraria mais o valor
2231:             *-- antigo para casar.
2232:             REPLACE citem2 WITH loc_nCont FOR citem2 = loc_nCitensAnt
2233: 
2234:             GO loc_nRecno
2235:             REPLACE citens WITH loc_nCont
2236:         ENDSCAN
2237: 
2238:         SET ORDER TO citens
2239: 
2240:         THIS.this_nCItem = loc_nCont
2241: 
2242:         RETURN loc_nCont
2243:     ENDPROC
2244: 
2245:     *==========================================================================
2246:     * GarantirLinhaDeDigitacao - Equivale ao "If Eof() / Insert Into
2247:     * crTpmMvItn(...) Values (..., 1)" que o legado faz no btnPApaga.Click
2248:     * depois de excluir: se a grade ficou sem nenhuma linha, entrega uma nova
2249:     * para o usuario continuar digitando.
2250:     *==========================================================================
2251:     PROCEDURE GarantirLinhaDeDigitacao()
2252:         LOCAL loc_nRegistros
2253: 
2254:         IF !USED("cursor_4c_Itens")
2255:             RETURN .F.
2256:         ENDIF
2257: 
2258:         SELECT cursor_4c_Itens
2259:         COUNT TO loc_nRegistros
2260: 
2261:         IF loc_nRegistros > 0
2262:             RETURN .F.
2263:         ENDIF
2264: 
2265:         THIS.this_nCItem = 1
2266: 
2267:         INSERT INTO cursor_4c_Itens (emps, dopes, numes, citens, empdopnums) ;
2268:             VALUES (PADR(THIS.this_cEmps, 3), PADR(THIS.this_cDopes, 20), ;
2269:                     THIS.this_nNumes, 1, THIS.ObterChaveMovimentacao())
2270: 
2271:         RETURN .T.
2272:     ENDPROC
2273: 
2274:     *==========================================================================
2275:     * TotalizarLinha - Equivale a PROCEDURE total_item do legado:
2276:     *
2277:     *   parameters pMantVal
2278:     *   =ThisForm.ParentForm.Calc_ValIte(,,pMantVal)
2279:     *   ThisForm.fwGrade.Refresh
2280:     *
2281:     * A aritmetica do total do item (unitario x quantidade, fator, moeda,
2282:     * descontos e impostos) eh regra de negocio que mora no Calc_ValIte do
2283:     * form PAI de Movimentacao - este form so delega e repinta. Reescrever a
2284:     * formula aqui gravaria valor diferente do legado sem erro na tela.
2285:     *
2286:     * PUBLIC: os handlers de celula da grade chamam, e o form pai tambem.
2287:     *==========================================================================
2288:     PROCEDURE TotalizarLinha(par_lManterValor)
2289:         LOCAL loc_lManter, loc_lOk, loc_oErro
2290: 
2291:         loc_lManter = IIF(VARTYPE(par_lManterValor) = "L", par_lManterValor, .F.)
2292:         loc_lOk     = .F.
2293: 
2294:         IF VARTYPE(THIS.this_oParentForm) = "O"
2295:             IF PEMSTATUS(THIS.this_oParentForm, "Calc_ValIte", 5)
2296:                 TRY
2297:                     THIS.this_oParentForm.Calc_ValIte(.F., .F., loc_lManter)
2298:                     loc_lOk = .T.
2299:                 CATCH TO loc_oErro
2300:                     MsgErro("Erro ao totalizar o item:" + CHR(13) + ;
2301:                             loc_oErro.Message + CHR(13) + ;
2302:                             "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2303:                             "Proc: " + loc_oErro.Procedure, "Erro TotalizarLinha")
2304:                 ENDTRY
2305:             ENDIF
2306:         ENDIF
2307: 
2308:         THIS.RepintarGradeItens()
2309: 
2310:         RETURN loc_lOk
2311:     ENDPROC
2312: 
2313:     *==========================================================================
2314:     * ValidarItensAntesDeSair - Gate do btnSair.Click do legado ("Retornar"):
2315:     * antes de devolver o controle ao form pai, o legado percorre os itens e,
2316:     * achando problema, exibe a mensagem, devolve o foco a grade e NAO fecha a
2317:     * tela ("If Not IsEmpty(lcMsg) / Messagebox(lcMsg, 48, lcCaption) /
2318:     * ... SetFocus / Return").
2319:     *
2320:     * O legado so valida quando Op_Escolha eh INSERIR/ALTERAR (e no caso
2321:     * especifico de CONSULTAR com crSigCdOpe.DigItens = 8).
2322:     *
2323:     * Das validacoes do legado, as que dependem de cursor de configuracao da
2324:     * operacao (crSigCdOpe, crSigOpCdc, crSigOpCdd, csOpeAut, TmpOperacao) sao
2325:     * guardadas no proprio legado por teste de valor/Seek nesses cursores, e
2326:     * por isso ficam inertes quando a configuracao nao esta carregada - o
2327:     * mesmo comportamento vale aqui. A checagem de consistencia entre item e
2328:     * composicao eh INCONDICIONAL no legado e eh a que roda aqui:
2329:     *
2330:     *   Select a.* From crTpmMvIts a, crTpmMvItn b Where a.citens = b.citens
2331:     *       And a.CPros <> b.CPros Into Cursor ChecItem
2332:     *   If Reccount() > 0 / lcMsg = 'Problema de inconsistencia com o Item '
2333:     *       + Str(ChecItem.citens,4) + ' Produto:' + ChecItem.CPros
2334:     *
2335:     * Devolve .T. quando os itens estao consistentes.
2336:     *==========================================================================
2337:     PROCEDURE ValidarItensAntesDeSair()
2338:         LOCAL loc_lOk, loc_cMsg, loc_cTitulo, loc_nRecno
2339: 
2340:         loc_lOk     = .T.
2341:         loc_cMsg    = ""
2342:         loc_cTitulo = "Inconsistencia dos Itens"
2343: 
2344:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2345:             RETURN .T.
2346:         ENDIF
2347: 
2348:         IF !USED("cursor_4c_Itens")
2349:             RETURN .T.
2350:         ENDIF
2351: 
2352:         SELECT cursor_4c_Itens
2353:         loc_nRecno = RECNO()
2354: 
2355:         *-- Composicao (citem2 aponta o item pai) cujo produto divergiu do
2356:         *-- produto do pai: no legado sao duas tabelas (crTpmMvIts x
2357:         *-- crTpmMvItn) ligadas por citens; aqui convivem no mesmo cursor.
2358:         SELECT a.citens, a.cpros ;
2359:             FROM cursor_4c_Itens a, cursor_4c_Itens b ;
2360:             WHERE a.citem2 <> 0 ;
2361:               AND a.citem2 = b.citens ;
2362:               AND a.cpros <> b.cpros ;
2363:             INTO CURSOR cursor_4c_ChecaItem
2364: 
2365:         IF USED("cursor_4c_ChecaItem")
2366:             SELECT cursor_4c_ChecaItem
2367:             GO TOP
2368:             IF !EOF()
2369:                 loc_cMsg = "Problema de inconsistencia com o Item " + ;
2370:                            STR(cursor_4c_ChecaItem.citens, 4) + ;
2371:                            " Produto:" + ALLTRIM(cursor_4c_ChecaItem.cpros)
2372:             ENDIF
2373:             USE IN cursor_4c_ChecaItem
2374:         ENDIF
2375: 
2376:         SELECT cursor_4c_Itens
2377:         IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
2378:             GO loc_nRecno
2379:         ENDIF
2380: 
2381:         IF !EMPTY(loc_cMsg)
2382:             loc_lOk = .F.
2383:             MsgAviso(loc_cMsg, loc_cTitulo)
2384: 
2385:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Visible
2386:                 THIS.grd_4c_Dados.SetFocus()
2387:             ENDIF
2388:         ENDIF
2389: 
2390:         RETURN loc_lOk
2391:     ENDPROC
2392: 
2393:     *==========================================================================
2394:     * BtnEncerrarClick - "Retornar" ao form pai (OK.btnSair do legado, que eh
2395:     * Cancel = .T. - ESC cai aqui). O legado valida os itens primeiro e, so
2396:     * passando, reabilita o pai e fecha:
2397:     *
2398:     *   ... validacoes ... If Not IsEmpty(lcMsg) / Messagebox / SetFocus / Return
2399:     *   If llOk / With Thisform.ParentForm / .Enabled = .T. / ... / Endwith / Endif
2400:     *   Thisform.Release
2401:     *
2402:     * A reabilitacao do pai eh obrigatoria: o legado o desabilita ao abrir
2403:     * esta tela (Thisform.ParentForm.Enabled = .f. no Init), e sem o
2404:     * .Enabled = .T. aqui o usuario volta para uma tela de Movimentacao morta.
2405:     *==========================================================================
2406:     PROCEDURE BtnEncerrarClick()
2407:         IF !THIS.ValidarItensAntesDeSair()
2408:             RETURN
2409:         ENDIF
2410: 
2411:         IF VARTYPE(THIS.this_oParentForm) = "O"
2412:             IF PEMSTATUS(THIS.this_oParentForm, "Enabled", 5)
2413:                 THIS.this_oParentForm.Enabled = .T.
2414:             ENDIF
2415:         ENDIF
2416: 
2417:         THIS.Release()
2418:     ENDPROC
2419: 
2420:     *==========================================================================
2421:     * Handlers dos botoes de cnt_4c_Botoes (toolbar superior, Top=81)
2422:     *==========================================================================
2423: 
2424:     *-- "Total de Produtos": Do Form SigOpTot With ThisForm, DataSessionId
2425:     PROCEDURE BtnTotItensClick()
2426:         LOCAL loc_oForm, loc_oErro
2427:         loc_oForm = .NULL.
2428:         TRY
2429:             loc_oForm = CREATEOBJECT("FormSigOpTot", THIS, THIS.DataSessionId)
2430:         CATCH TO loc_oErro
2431:             MostrarErro("Erro ao abrir Total de Produtos:" + CHR(13) + loc_oErro.Message, "Erro")
2432:             loc_oForm = .NULL.
2433:         ENDTRY
2434:         IF VARTYPE(loc_oForm) = "O"
2435:             loc_oForm.Show()
2436:         ENDIF
2437:     ENDPROC
2438: 
2439:     *-- "Cambio de Produtos": Do Form SigOpCot With ParentForm, TprMvCab.Datas
2440:     PROCEDURE BtnCotacaoClick()
2441:         LOCAL loc_oForm, loc_oErro
2442:         loc_oForm = .NULL.
2443:         TRY
2444:             loc_oForm = CREATEOBJECT("FormSigOpCot", THIS.this_oParentForm)
2445:         CATCH TO loc_oErro
2446:             MostrarErro("Erro ao abrir C" + CHR(226) + "mbio de Produtos:" + CHR(13) + loc_oErro.Message, "Erro")
2447:             loc_oForm = .NULL.
2448:         ENDTRY
2449:         IF VARTYPE(loc_oForm) = "O"
2450:             loc_oForm.Show()
2451:             THIS.grd_4c_Dados.Refresh()
2452:         ENDIF
2453:     ENDPROC
2454: 
2455:     *-- "Alterar Impostos": habilita a pagina Fiscal e navega para ela
2456:     PROCEDURE BtnAltImpsClick()
2457:         IF !THIS.TemProdutoSelecionado()
2458:             MsgAviso("Selecione um Produto Na Grade para alterar impostos.", "Aten" + CHR(231) + CHR(227) + "o")
2459:             RETURN
2460:         ENDIF
2461:         THIS.pgf_4c_Paginas.Page3.Enabled = .T.
2462:         THIS.AlternarPagina(3)
2463:     ENDPROC
2464: 
2465:     *-- "Visualizar Impostos": toggle que leva a pagina Fiscal
2466:     PROCEDURE BtnVerImpsClick()
2467:         IF !THIS.TemProdutoSelecionado()
2468:             THIS.cnt_4c_Botoes.chk_4c_BtnVerImps.Value = 0
2469:             THIS.pgf_4c_Paginas.Page3.Enabled          = .F.
2470:             RETURN
2471:         ENDIF
2472: 
2473:         *-- Legado (fwGrade.AfterRowColChange): llvImp = btnVerImps.Value
2474:         *-- habilita/desabilita a pagina Fiscal e troca a aba ativa.
2475:         IF THIS.cnt_4c_Botoes.chk_4c_BtnVerImps.Value = 1
2476:             THIS.pgf_4c_Paginas.Page3.Enabled = .T.
2477:             THIS.AlternarPagina(3)
2478:         ELSE
2479:             THIS.pgf_4c_Paginas.Page3.Enabled = .F.
2480:             THIS.AlternarPagina(1)
2481:         ENDIF
2482:     ENDPROC
2483: 
2484:     *-- "Recalcular Impostos": navega para a pagina Fiscal da linha corrente
2485:     PROCEDURE BtnRecImpsClick()
2486:         IF !THIS.TemProdutoSelecionado()
2487:             MsgAviso("Selecione um Produto Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o")
2488:             RETURN
2489:         ENDIF
2490:         THIS.AlternarPagina(3)
2491:     ENDPROC
2492: 
2493:     *-- "Devolucao": Do Form sigoppei (equivalente SigOpExi do legado)
2494:     PROCEDURE BtndevoluClick()
2495:         LOCAL loc_oForm, loc_oErro
2496:         IF !USED("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
2497:             RETURN
2498:         ENDIF
2499:         loc_oForm = .NULL.
2500:         TRY
2501:             loc_oForm = CREATEOBJECT("FormSigOpExi", THIS, THIS.DataSessionId)
2502:         CATCH TO loc_oErro
2503:             MostrarErro("Erro ao abrir Devolu" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
2504:             loc_oForm = .NULL.
2505:         ENDTRY
2506:         IF VARTYPE(loc_oForm) = "O"
2507:             loc_oForm.Show()
2508:             THIS.grd_4c_Dados.SetFocus()
2509:         ENDIF
2510:     ENDPROC
2511: 
2512:     *-- "Itens Subnivel": Do Form sigoppei With ThisForm, DataSessionId
2513:     PROCEDURE BtnIteSubClick()
2514:         LOCAL loc_oForm, loc_oErro
2515:         loc_oForm = .NULL.
2516:         TRY
2517:             loc_oForm = CREATEOBJECT("FormSigOpPei", THIS, THIS.DataSessionId)
2518:         CATCH TO loc_oErro
2519:             MostrarErro("Erro ao abrir Itens Subn" + CHR(237) + "vel:" + CHR(13) + loc_oErro.Message, "Erro")
2520:             loc_oForm = .NULL.
2521:         ENDTRY
2522:         IF VARTYPE(loc_oForm) = "O"
2523:             loc_oForm.Show()
2524:             THIS.grd_4c_Dados.Refresh()
2525:         ENDIF
2526:     ENDPROC
2527: 
2528:     *-- "Importar XML": zera a grade de itens e aciona a importacao
2529:     PROCEDURE CmdXmlClick()
2530:         IF !MsgConfirma("Importar XML ir" + CHR(225) + " substituir todos os itens da grade atual. Continuar?", "Confirmar")
2531:             RETURN
2532:         ENDIF
2533:         THIS.ZaparCursorItens()
2534:         THIS.RepintarGradeItens()
2535:         THIS.AjustarBotoesPorModo()
2536:     ENDPROC
2537: 
2538:     *-- "Carrega Cadastro": zera a grade de itens antes de carregar um lote
2539:     PROCEDURE BtncarregarClick()
2540:         LOCAL loc_cArquivo
2541:         loc_cArquivo = GETFILE("TXT")
2542:         IF EMPTY(loc_cArquivo)
2543:             RETURN
2544:         ENDIF
2545:         THIS.ZaparCursorItens()
2546:         THIS.RepintarGradeItens()
2547:         THIS.AjustarBotoesPorModo()
2548:     ENDPROC
2549: 
2550:     *-- "Retorna Bonus": Do Form ParentForm.OpenCash(Contads,.T.,.F.)
2551:     PROCEDURE BtnRetCashClick()
2552:         LOCAL loc_oErro
2553:         TRY
2554:             IF VARTYPE(THIS.this_oParentForm) = "O" AND PEMSTATUS(THIS.this_oParentForm, "OpenCash", 5)
2555:                 THIS.this_oParentForm.OpenCash("", .T., .F.)
2556:             ENDIF
2557:         CATCH TO loc_oErro
2558:             MostrarErro("Erro ao retornar b" + CHR(244) + "nus:" + CHR(13) + loc_oErro.Message, "Erro")
2559:         ENDTRY
2560:         THIS.grd_4c_Dados.Refresh()
2561:     ENDPROC
2562: 
2563:     *==========================================================================
2564:     * Handlers dos botoes de cnt_4c_BotoesAcao (toolbar inferior, Top=359)
2565:     *==========================================================================
2566: 
2567:     *-- "Cadastro de Produtos": Do Form SigOpCgp (cadastro rapido na operacao)
2568:     PROCEDURE BtnCadProClick()
2569:         LOCAL loc_oForm, loc_oErro
2570:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") OR !THIS.TemProdutoSelecionado()
2571:             RETURN
2572:         ENDIF
2573:         loc_oForm = .NULL.
2574:         TRY
2575:             loc_oForm = CREATEOBJECT("FormSigOpCgp", THIS)
2576:         CATCH TO loc_oErro
2577:             MostrarErro("Erro ao abrir Cadastro de Produtos:" + CHR(13) + loc_oErro.Message, "Erro")
2578:             loc_oForm = .NULL.
2579:         ENDTRY
2580:         IF VARTYPE(loc_oForm) = "O"
2581:             loc_oForm.Show()
2582:             THIS.grd_4c_Dados.Refresh()
2583:         ENDIF
2584:     ENDPROC
2585: 
2586:     *-- "Exclusao de Produtos": remove a linha corrente da grade.
2587:     *-- Legado (btnPApaga.Click): guard de EOF -> DeletarItem() -> garante uma
2588:     *-- linha na grade -> renumera os itens (e as referencias de composicao)
2589:     *-- -> CItem = Cont -> Go Top -> fwGrade.Refresh + Produto.SetFocus.
2590:     *-- O legado NAO pede confirmacao: a exclusao eh de LINHA do cursor da
2591:     *-- grade, e a gravacao em SigMvItn so acontece quando o form pai confirma
2592:     *-- a movimentacao.
2593:     PROCEDURE BtnPApagaClick()
2594:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
2595:             MsgAviso("Posicione no Produto que Deseja Excluir ... ", "Nada a Fazer")
2596:             RETURN
2597:         ENDIF
2598: 
2599:         IF !THIS.ExcluirLinhaGrade()
2600:             RETURN
2601:         ENDIF
2602: 
2603:         THIS.GarantirLinhaDeDigitacao()
2604:         THIS.RenumerarItensGrade()
2605: 
2606:         SELECT cursor_4c_Itens
2607:         GO TOP
2608: 
2609:         THIS.RepintarGradeItens()
2610:         THIS.AjustarBotoesPorModo()
2611: 
2612:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Visible
2613:             THIS.grd_4c_Dados.SetFocus()
2614:         ENDIF
2615:     ENDPROC
2616: 
2617:     *-- "Carregar Composicao": Do Form SigSubCp (composicao do produto)
2618:     PROCEDURE BtnComposClick()
2619:         LOCAL loc_oForm, loc_oErro
2620:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") OR !THIS.TemProdutoSelecionado()
2621:             RETURN
2622:         ENDIF
2623:         loc_oForm = .NULL.
2624:         TRY
2625:             loc_oForm = CREATEOBJECT("FormSigSubCp", THIS, ALLTRIM(cursor_4c_Itens.cpros), ;
2626:                                       cursor_4c_Itens.citens, THIS.DataSessionId)
2627:         CATCH TO loc_oErro
2628:             MostrarErro("Erro ao abrir Composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
2629:             loc_oForm = .NULL.
2630:         ENDTRY
2631:         IF VARTYPE(loc_oForm) = "O"
2632:             loc_oForm.Show()
2633:             THIS.grd_4c_Dados.Refresh()
2634:         ENDIF
2635:     ENDPROC
2636: 
2637:     *-- "Alteracao de Precos": libera o foco na coluna Valor da grade
2638:     PROCEDURE BtnAltPrecosClick()
2639:         IF !THIS.TemProdutoSelecionado()
2640:             MsgAviso("Selecione um Produto para Ter o Pre" + CHR(231) + "o Alterado.", "Aten" + CHR(231) + CHR(227) + "o")
2641:             RETURN
2642:         ENDIF
2643:         THIS.grd_4c_Dados.SetFocus()
2644:         THIS.grd_4c_Dados.ActiveColumn = 6
2645:     ENDPROC
2646: 
2647:     *-- "Procura de Produtos": abre o lookup de produto quando a linha
2648:     *-- corrente ainda nao tem codigo preenchido (igual ao legado)
2649:     PROCEDURE BtnPBuscasClick()
2650:         LOCAL loc_oBusca
2651: 
2652:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens") AND !EMPTY(cursor_4c_Itens.cpros)
2653:             MsgAviso("O c" + CHR(243) + "digo do Produto tem que estar vazio para acionar procura!!!", "Aten" + CHR(231) + CHR(227) + "o")
2654:             RETURN
2655:         ENDIF
2656: 
2657:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2658:                                    "cursor_4c_BuscaPro", "Cpros", "", "Produtos", .F., .T., "")
2659: 
2660:         IF VARTYPE(loc_oBusca) = "O"
2661:             IF !loc_oBusca.this_lAchouRegistro
2662:                 loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
2663:                 loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
2664:                 loc_oBusca.Show()
2665:             ENDIF
2666: 
2667:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro") AND USED("cursor_4c_Itens") ;
2668:                AND !EOF("cursor_4c_Itens")
2669:                 SELECT cursor_4c_BuscaPro
2670:                 SELECT cursor_4c_Itens
2671:                 REPLACE cpros WITH ALLTRIM(cursor_4c_BuscaPro.Cpros), ;
2672:                         dpros WITH ALLTRIM(cursor_4c_BuscaPro.Dpros)
2673:                 THIS.grd_4c_Dados.Refresh()
2674:             ENDIF
2675: 
2676:             loc_oBusca.Release()
2677:         ENDIF
2678: 
2679:         IF USED("cursor_4c_BuscaPro")
2680:             USE IN cursor_4c_BuscaPro
2681:         ENDIF
2682:     ENDPROC
2683: 
2684:     *-- "Informar Pedido": Do Form SigOpPed With ThisForm, DataSessionId
2685:     PROCEDURE BtnPedidoClick()
2686:         LOCAL loc_oForm, loc_oErro
2687:         IF !THIS.TemProdutoSelecionado()
2688:             MsgAviso("" + CHR(201) + " necess" + CHR(225) + "rio Posicionar no Produto para Localizar!!!", "Aviso")
2689:             RETURN
2690:         ENDIF
2691:         loc_oForm = .NULL.
2692:         TRY
2693:             loc_oForm = CREATEOBJECT("FormSigOpPed", THIS, THIS.DataSessionId)
2694:         CATCH TO loc_oErro
2695:             MostrarErro("Erro ao abrir Informar Pedido:" + CHR(13) + loc_oErro.Message, "Erro")
2696:             loc_oForm = .NULL.
2697:         ENDTRY
2698:         IF VARTYPE(loc_oForm) = "O"
2699:             loc_oForm.Show()
2700:             THIS.grd_4c_Dados.Refresh()
2701:         ENDIF
2702:     ENDPROC
2703: 
2704:     *-- "Substituir Composicao": Do Form SigSubCp With ThisForm, Cpros,
2705:     *-- Citens, DataSessionId, CodTams (igual ao legado)
2706:     PROCEDURE BtnsubcpClick()
2707:         LOCAL loc_oForm, loc_oErro
2708:         IF !THIS.TemProdutoSelecionado()
2709:             MsgAviso("Selecione Um Produto Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o")
2710:             RETURN
2711:         ENDIF
2712:         loc_oForm = .NULL.
2713:         TRY
2714:             loc_oForm = CREATEOBJECT("FormSigSubCp", THIS, ALLTRIM(cursor_4c_Itens.cpros), ;
2715:                                       cursor_4c_Itens.citens, THIS.DataSessionId, ;
2716:                                       cursor_4c_Itens.codtams)
2717:         CATCH TO loc_oErro
2718:             MostrarErro("Erro ao abrir Substituir Composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
2719:             loc_oForm = .NULL.
2720:         ENDTRY
2721:         IF VARTYPE(loc_oForm) = "O"
2722:             loc_oForm.Show()
2723:             THIS.grd_4c_Dados.Refresh()
2724:         ENDIF
2725:     ENDPROC
2726: 
2727:     *-- "Detalhes": Do Form SigOpDet With ParentForm.PoDataMgr, Op_Escolha,
2728:     *-- TprMvCab.Dopes, Cpros, TprMvCab.EmpDopNums
2729:     PROCEDURE BtnDetClick()
2730:         LOCAL loc_oForm, loc_oErro
2731:         IF !THIS.TemProdutoSelecionado()
2732:             MsgAviso("Selecione Um Produto Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o")
2733:             RETURN
2734:         ENDIF
2735:         loc_oForm = .NULL.
2736:         TRY
2737:             loc_oForm = CREATEOBJECT("FormSigOpDet", THIS.this_oParentForm, THIS.this_cOpEscolha, ;
2738:                                       "", ALLTRIM(cursor_4c_Itens.cpros), "")
2739:         CATCH TO loc_oErro
2740:             MostrarErro("Erro ao abrir Detalhes:" + CHR(13) + loc_oErro.Message, "Erro")
2741:             loc_oForm = .NULL.
2742:         ENDTRY
2743:         IF VARTYPE(loc_oForm) = "O"
2744:             loc_oForm.Show()
2745:         ENDIF
2746:     ENDPROC
2747: 
2748:     *-- "Finalidade": Do Form SigOpIns (finalidade da operacao no item)
2749:     PROCEDURE BtnOptFinClick()
2750:         LOCAL loc_oForm, loc_oErro
2751:         IF !THIS.TemProdutoSelecionado()
2752:             MsgAviso("Selecione Um Produto Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o")
2753:             RETURN
2754:         ENDIF
2755:         loc_oForm = .NULL.
2756:         TRY
2757:             loc_oForm = CREATEOBJECT("FormSigOpIns", THIS.this_oParentForm, "", "ITN", "", "")
2758:         CATCH TO loc_oErro
2759:             MostrarErro("Erro ao abrir Finalidade:" + CHR(13) + loc_oErro.Message, "Erro")
2760:             loc_oForm = .NULL.
2761:         ENDTRY
2762:         IF VARTYPE(loc_oForm) = "O"
2763:             loc_oForm.Show()
2764:         ENDIF
2765:     ENDPROC
2766: 
2767:     *-- "Descontos": Do Form SigOpDes (descontos por cota)
2768:     PROCEDURE BtnDescClick()
2769:         LOCAL loc_oForm, loc_oErro
2770:         IF !THIS.TemProdutoSelecionado()
2771:             MsgAviso("" + CHR(201) + " necess" + CHR(225) + "rio posicionar em um produto para fazer os descontos!!!", "Aviso")
2772:             RETURN
2773:         ENDIF
2774:         loc_oForm = .NULL.
2775:         TRY
2776:             loc_oForm = CREATEOBJECT("FormSigOpDes", THIS.this_oParentForm)
2777:         CATCH TO loc_oErro
2778:             MostrarErro("Erro ao abrir Descontos:" + CHR(13) + loc_oErro.Message, "Erro")
2779:             loc_oForm = .NULL.
2780:         ENDTRY
2781:         IF VARTYPE(loc_oForm) = "O"
2782:             loc_oForm.Show()
2783:             THIS.grd_4c_Dados.Refresh()
2784:         ENDIF
2785:     ENDPROC
2786: 
2787:     *-- "Local. Destino": Do Form SigOpLcl/SigOpLcZ With ..., 'DESTINO'
2788:     PROCEDURE BtnLocDesClick()
2789:         LOCAL loc_oForm, loc_oErro
2790:         IF !THIS.TemProdutoSelecionado()
2791:             MsgAviso("" + CHR(201) + " Necess" + CHR(225) + "rio Posicionar no Produto para Localizar!!!", "Aviso")
2792:             RETURN
2793:         ENDIF
2794:         loc_oForm = .NULL.
2795:         TRY
2796:             loc_oForm = CREATEOBJECT("FormSigOpLcl", THIS.this_oParentForm, THIS.this_cOpEscolha, "DESTINO")
2797:         CATCH TO loc_oErro
2798:             MostrarErro("Erro ao abrir Localiza" + CHR(231) + CHR(227) + "o de Destino:" + CHR(13) + loc_oErro.Message, "Erro")
2799:             loc_oForm = .NULL.
2800:         ENDTRY
2801:         IF VARTYPE(loc_oForm) = "O"
2802:             loc_oForm.Show()
2803:         ENDIF
2804:     ENDPROC
2805: 
2806:     *-- "Local. Origem": Do Form SigOpLcl/SigOpLcZ With ..., 'ORIGEM'
2807:     PROCEDURE BtnLocOriClick()
2808:         LOCAL loc_oForm, loc_oErro
2809:         IF !THIS.TemProdutoSelecionado()
2810:             MsgAviso("" + CHR(201) + " Necess" + CHR(225) + "rio Posicionar no Produto para Localizar!!!", "Aviso")
2811:             RETURN
2812:         ENDIF
2813:         loc_oForm = .NULL.
2814:         TRY
2815:             loc_oForm = CREATEOBJECT("FormSigOpLcl", THIS.this_oParentForm, THIS.this_cOpEscolha, "ORIGEM")
2816:         CATCH TO loc_oErro
2817:             MostrarErro("Erro ao abrir Localiza" + CHR(231) + CHR(227) + "o de Origem:" + CHR(13) + loc_oErro.Message, "Erro")
2818:             loc_oForm = .NULL.
2819:         ENDTRY
2820:         IF VARTYPE(loc_oForm) = "O"
2821:             loc_oForm.Show()
2822:         ENDIF
2823:     ENDPROC
2824: 
2825:     *==========================================================================
2826:     * ConfigurarPaginaProduto - Page1 (pgProds no legado) "Dados do Produto".
2827:     *
2828:     * Painel do item CORRENTE da grade. No legado quase todo campo daqui tem
2829:     * When() = Return .F. (espelho somente-leitura da linha) e os poucos
2830:     * digitaveis sao: getDPros (descricao, so quando AltDescs = 1), getDocs
2831:     * (documento), getLotes (numero do lote), getVDescs / getPDescs
2832:     * (descontos), getObs (observacao do item), getCodCors / getCodTams (cor e
2833:     * tamanho, com browse), get_prod / get_qtd (conferencia por codigo de
2834:     * barras) e getBusca (procura na grade).
2835:     *
2836:     * Os campos que SAO coluna de SigMvItn usam ControlSource sobre
2837:     * cursor_4c_Itens - exatamente o que o legado faz sobre crTpmMvItn - e por
2838:     * isso acompanham a linha corrente da grade sozinhos. Os de EXIBICAO
2839:     * (preco atual, grupo de venda, referencia, saldo, resta, peso medio) nao
2840:     * sao coluna do item: no legado o AfterRowColChange da grade os preenche a
2841:     * cada troca de linha, e aqui AtualizarPainelProduto() faz o mesmo.
2842:     *
2843:     * cnt_4c_Obs nasce Visible = .F. (painel flutuante da observacao, aberto
2844:     * pelo Click de obj_4c_GetObs) e por isso entra na lista de excecao de
2845:     * TornarControlesVisiveis / ReaplicarVisibilidadeInicial.
2846:     *==========================================================================
2847:     PROTECTED PROCEDURE ConfigurarPaginaProduto()
2848:         LOCAL loc_oPag
2849:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2850: 
2851:         *-- cnt_4c_Obs (cntObs no legado) - painel flutuante da observacao ---
2852:         loc_oPag.AddObject("cnt_4c_Obs", "Container")
2853:         WITH loc_oPag.cnt_4c_Obs
2854:             .Top         = 1
2855:             .Left        = 194
2856:             .Width       = 792
2857:             .Height      = 171
2858:             .BackStyle   = 1
2859:             .BackColor   = RGB(255, 255, 255)
2860:             .BorderWidth = 0
2861:             .Visible     = .F.
2862:         ENDWITH
2863: 
2864:         loc_oPag.cnt_4c_Obs.AddObject("obj_4c_GetObs", "EditBox")
2865:         WITH loc_oPag.cnt_4c_Obs.obj_4c_GetObs
2866:             .Top           = 4
2867:             .Left          = 2
2868:             .Width         = 788
2869:             .Height        = 163
2870:             .FontName      = "Tahoma"
2871:             .FontSize      = 8
2872:             .SpecialEffect = 1
2873:             .ControlSource = "cursor_4c_Itens.obs"
2874:             .ToolTipText   = "Observa" + CHR(231) + CHR(227) + "o do Produto"
2875:             .Visible       = .T.
2876:         ENDWITH
2877: 
2878:         *-- shp_4c_Shape4 - moldura da area da imagem do produto -------------
2879:         loc_oPag.AddObject("shp_4c_Shape4", "Shape")
2880:         WITH loc_oPag.shp_4c_Shape4
2881:             .Top           = 2
2882:             .Left          = 2
2883:             .Width         = 192
2884:             .Height        = 167
2885:             .BackStyle     = 0
2886:             .BorderWidth   = 2
2887:             .SpecialEffect = 0

*-- Linhas 3683 a 3726:
3683:             .Visible   = .T.
3684:         ENDWITH
3685: 
3686:         loc_oPag.AddObject("obj_4c_Opt_Busca", "OptionGroup")
3687:         WITH loc_oPag.obj_4c_Opt_Busca
3688:             .Top         = 135
3689:             .Left        = 713
3690:             .Width       = 119
3691:             .Height      = 25
3692:             .ButtonCount = 2
3693:             .BackStyle   = 0
3694:             .BorderStyle = 0
3695:             .AutoSize    = .F.
3696:             .Value       = 1
3697:             .Visible     = .T.
3698:             WITH .Buttons(1)
3699:                 .Caption   = "Barras"
3700:                 .Top       = 5
3701:                 .Left      = 5
3702:                 .Width     = 49
3703:                 .Height    = 15
3704:                 .FontName  = "Tahoma"
3705:                 .FontSize  = 8
3706:                 .AutoSize  = .F.
3707:                 .BackStyle = 0
3708:                 .ForeColor = RGB(90, 90, 90)
3709:             ENDWITH
3710:             WITH .Buttons(2)
3711:                 .Caption   = "Produto"
3712:                 .Top       = 5
3713:                 .Left      = 58
3714:                 .Width     = 56
3715:                 .Height    = 15
3716:                 .FontName  = "Tahoma"
3717:                 .FontSize  = 8
3718:                 .AutoSize  = .F.
3719:                 .BackStyle = 0
3720:                 .ForeColor = RGB(90, 90, 90)
3721:             ENDWITH
3722:         ENDWITH
3723: 
3724:         loc_oPag.AddObject("txt_4c_Busca", "TextBox")
3725:         WITH loc_oPag.txt_4c_Busca
3726:             .Top               = 136

*-- Linhas 3822 a 3899:
3822: 
3823:         *-- Eventos: o Valid do legado vira LostFocus aqui (regra #47); nada
3824:         *-- fica em KeyPress sem teste explicito de tecla.
3825:         BINDEVENT(loc_oPag.txt_4c__prod,   "LostFocus", THIS, "TxtProdLostFocus")
3826:         BINDEVENT(loc_oPag.txt_4c__qtd,    "LostFocus", THIS, "TxtQtdLostFocus")
3827:         BINDEVENT(loc_oPag.txt_4c_Busca,   "LostFocus", THIS, "BtnBuscarClick")
3828:         BINDEVENT(loc_oPag.txt_4c_CodCors, "LostFocus", THIS, "ValidarCodCorLostFocus")
3829:         BINDEVENT(loc_oPag.txt_4c_CodTams, "LostFocus", THIS, "ValidarCodTamLostFocus")
3830:         BINDEVENT(loc_oPag.txt_4c_Docs,    "LostFocus", THIS, "ValidarDocsLostFocus")
3831:         BINDEVENT(loc_oPag.txt_4c_Lotes,   "LostFocus", THIS, "ValidarLotesLostFocus")
3832:         BINDEVENT(loc_oPag.txt_4c_VDescs,  "LostFocus", THIS, "ValidarVDescsLostFocus")
3833:         BINDEVENT(loc_oPag.txt_4c_PDescs,  "LostFocus", THIS, "ValidarPDescsLostFocus")
3834:         BINDEVENT(loc_oPag.obj_4c_GetObs,  "Click",     THIS, "ObsAbrirPainelClick")
3835:         BINDEVENT(loc_oPag.cnt_4c_Obs.obj_4c_GetObs, "LostFocus", THIS, "ObsFecharPainelLostFocus")
3836:         BINDEVENT(loc_oPag.img_4c_ImgProds, "DblClick", THIS, "ImgProdsDblClick")
3837:     ENDPROC
3838: 
3839:     *==========================================================================
3840:     * ConfigurarPaginaFiscal - Page3 (pgFiscs no legado) "Dados Fiscais".
3841:     *
3842:     * Painel fiscal do item corrente, todo dentro de cnt_4c_Item (CntItem no
3843:     * legado). No legado TODOS os campos daqui tem When() = Return .F. -
3844:     * exibicao pura - EXCETO getNAdis, getNIAdis e getcodfabs, cujo When eh
3845:     * "Return (InList(ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR'))": sao os
3846:     * tres dados de importacao que o usuario informa (numero da adicao, item
3847:     * da adicao e codigo do fabricante estrangeiro).
3848:     *
3849:     * A pagina so eh habilitada pelo legado quando o usuario pede alteracao de
3850:     * impostos (btnAltImps.Click faz "pgfPagina.pgFiscs.Enabled = .t."), e eh
3851:     * isso que HabilitarCampos reproduz.
3852:     *
3853:     * Os campos sao coluna de SigMvItn e por isso usam ControlSource sobre
3854:     * cursor_4c_Itens, acompanhando a linha corrente da grade. Os dois que NAO
3855:     * sao coluna do item (classificacao fiscal e a descricao dela, que vem de
3856:     * SigCdPro/SigCdClf) ficam em .Value e sao preenchidos por
3857:     * AtualizarPainelProduto(), como o AfterRowColChange do legado faz.
3858:     *==========================================================================
3859:     PROTECTED PROCEDURE ConfigurarPaginaFiscal()
3860:         LOCAL loc_oPag, loc_oCnt
3861:         loc_oPag = THIS.pgf_4c_Paginas.Page3
3862: 
3863:         loc_oPag.AddObject("cnt_4c_Item", "Container")
3864:         WITH loc_oPag.cnt_4c_Item
3865:             .Top           = -6
3866:             .Left          = 2
3867:             .Width         = 973
3868:             .Height        = 151
3869:             .BackStyle     = 0
3870:             .BorderWidth   = 0
3871:             .SpecialEffect = 2
3872:             .BackColor     = RGB(188, 201, 254)
3873:             .BorderColor   = RGB(36, 84, 155)
3874:             .Visible       = .T.
3875:         ENDWITH
3876: 
3877:         loc_oCnt = loc_oPag.cnt_4c_Item
3878: 
3879:         *-- Moldura do bloco de Importacao -----------------------------------
3880:         loc_oCnt.AddObject("shp_4c_Shape1", "Shape")
3881:         WITH loc_oCnt.shp_4c_Shape1
3882:             .Top         = 63
3883:             .Left        = 802
3884:             .Width       = 163
3885:             .Height      = 84
3886:             .BackStyle   = 0
3887:             .BorderStyle = 1
3888:             .BorderColor = RGB(90, 90, 90)
3889:             .Visible     = .T.
3890:         ENDWITH
3891: 
3892:         *-- Linha 1: produto, descricao, classificacao fiscal e Obs2 ---------
3893:         THIS.AdicionarLabelFiscal(loc_oCnt, "lbl_4c_LblFCPros", 7, 9, 45, "Produto")
3894: 
3895:         loc_oCnt.AddObject("txt_4c_FCPros", "TextBox")
3896:         WITH loc_oCnt.txt_4c_FCPros
3897:             .Top           = 21
3898:             .Left          = 9
3899:             .Width         = 108

*-- Linhas 4182 a 4310:
4182:     * legado eh AutoSize, mas AutoSize eh no-op em Label criado por AddObject
4183:     * (regra #23) - a largura tem de vir escrita.
4184:     *==========================================================================
4185:     PROTECTED PROCEDURE AdicionarLabelFiscal(par_oPai, par_cNome, par_nTop, ;
4186:                                              par_nLeft, par_nWidth, par_cCaption)
4187:         par_oPai.AddObject(par_cNome, "Label")
4188: 
4189:         WITH EVALUATE("par_oPai." + par_cNome)
4190:             .Top       = par_nTop
4191:             .Left      = par_nLeft
4192:             .Width     = par_nWidth
4193:             .Height    = 15
4194:             .Caption   = par_cCaption
4195:             .FontName  = "Tahoma"
4196:             .FontSize  = 8
4197:             .FontBold  = .F.
4198:             .AutoSize  = .F.
4199:             .Alignment = 0
4200:             .BackStyle = 0
4201:             .ForeColor = RGB(90, 90, 90)
4202:             .Visible   = .T.
4203:         ENDWITH
4204:     ENDPROC
4205: 
4206:     *==========================================================================
4207:     * AdicionarTextBoxFiscal - Fabrica dos campos numericos de cnt_4c_Item.
4208:     * No dump todos tem a mesma assinatura (Tahoma 8, Alignment = 3, Height
4209:     * = 21, SpecialEffect = 1, BackColor = 251,254,226, BorderColor =
4210:     * 90,90,90) e When() = Return .F., isto eh: exibicao pura - o que aqui
4211:     * vira ReadOnly = .T. (o When do legado nao tem equivalente direto em
4212:     * TextBox criado por AddObject, e ReadOnly reproduz o efeito de nao
4213:     * aceitar digitacao sem esconder o valor).
4214:     *==========================================================================
4215:     PROTECTED PROCEDURE AdicionarTextBoxFiscal(par_oPai, par_cNome, par_nTop, ;
4216:                                                par_nLeft, par_nWidth, ;
4217:                                                par_cMascara, par_cFonte)
4218:         par_oPai.AddObject(par_cNome, "TextBox")
4219: 
4220:         WITH EVALUATE("par_oPai." + par_cNome)
4221:             .Top           = par_nTop
4222:             .Left          = par_nLeft
4223:             .Width         = par_nWidth
4224:             .Height        = 21
4225:             .FontName      = "Tahoma"
4226:             .FontSize      = 8
4227:             .Alignment     = 3
4228:             .InputMask     = par_cMascara
4229:             .ReadOnly      = .T.
4230:             .SpecialEffect = 1
4231:             .ControlSource = par_cFonte
4232:             .BackColor     = RGB(251, 254, 226)
4233:             .BorderColor   = RGB(90, 90, 90)
4234:             .Visible       = .T.
4235:         ENDWITH
4236:     ENDPROC
4237: 
4238:     *==========================================================================
4239:     * CriarCursorPrecos - Cursor da grade de Precificacao (Page4). No legado a
4240:     * grdPrecos esta ligada a "lpitem", cursor da lista de precificacao que
4241:     * vive no data session do form PAI de Movimentacao; aqui ele eh local e eh
4242:     * populado por CarregarPrecos() a partir de SigOpLpi/SigOpLpr.
4243:     *
4244:     * Criado ANTES de ConfigurarPaginaPrecos porque Column.ControlSource de
4245:     * alias inexistente derruba o Init (regra #41).
4246:     *==========================================================================
4247:     PROTECTED PROCEDURE CriarCursorPrecos()
4248:         IF USED("cursor_4c_Precos")
4249:             USE IN cursor_4c_Precos
4250:         ENDIF
4251: 
4252:         SET NULL ON
4253:         CREATE CURSOR cursor_4c_Precos ( ;
4254:             lprecos C(30), tabds C(20), units N(11,2), moedas C(3))
4255:         SET NULL OFF
4256:     ENDPROC
4257: 
4258:     *==========================================================================
4259:     * ConfigurarPaginaPrecos - Page4 (pgPrecos no legado) "Precificacao".
4260:     *
4261:     * Grade grdPrecos: lista as precificacoes disponiveis para o produto do
4262:     * item corrente. Nasce Visible = .F. e ReadOnly = .T. no SCX legado (o
4263:     * proprio legado so a mostra quando a operacao trabalha com lista de
4264:     * precos), e por isso entra na lista de excecao de
4265:     * TornarControlesVisiveis / ReaplicarVisibilidadeInicial.
4266:     *
4267:     * Ordem de configuracao obrigatoria (regra #41 / Problema 48):
4268:     * ColumnCount -> RecordSource -> ControlSource -> Width -> Header.Caption.
4269:     *==========================================================================
4270:     PROTECTED PROCEDURE ConfigurarPaginaPrecos()
4271:         LOCAL loc_oPag, loc_oGrd
4272:         loc_oPag = THIS.pgf_4c_Paginas.Page4
4273: 
4274:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
4275:         loc_oGrd = loc_oPag.grd_4c_Dados
4276: 
4277:         WITH loc_oGrd
4278:             .Top                = 9
4279:             .Left               = 7
4280:             .Width              = 416
4281:             .Height             = 131
4282:             .ColumnCount        = 4
4283:             .DeleteMark         = .F.
4284:             .RecordMark         = .F.
4285:             .ScrollBars         = 2
4286:             .ReadOnly           = .T.
4287:             .AllowHeaderSizing  = .F.
4288:             .GridLineColor      = RGB(238, 238, 238)
4289:             .RecordSource       = "cursor_4c_Precos"
4290:             .Visible            = .F.
4291:         ENDWITH
4292: 
4293:         WITH loc_oGrd.Column1
4294:             .ControlSource   = "cursor_4c_Precos.lprecos"
4295:             .Width           = 210
4296:             .Movable         = .F.
4297:             .Resizable       = .F.
4298:             .ReadOnly        = .T.
4299:             .FontName        = "Courier New"
4300:             .Header1.Caption = "Lista de Precifica" + CHR(231) + CHR(227) + "o"
4301:             .Visible         = .T.
4302:         ENDWITH
4303: 
4304:         WITH loc_oGrd.Column2
4305:             .ControlSource   = "cursor_4c_Precos.tabds"
4306:             .Width           = 80
4307:             .Movable         = .F.
4308:             .Resizable       = .F.
4309:             .ReadOnly        = .T.
4310:             .FontName        = "Courier New"

*-- Linhas 4361 a 4522:
4361:     *
4362:     * PUBLIC: eh o form pai quem chama.
4363:     *==========================================================================
4364:     PROCEDURE CarregarPrecos(par_cCursorOrigem)
4365:         LOCAL loc_lSucesso, loc_oErro
4366: 
4367:         loc_lSucesso = .F.
4368: 
4369:         IF VARTYPE(par_cCursorOrigem) <> "C" OR EMPTY(par_cCursorOrigem)
4370:             RETURN .F.
4371:         ENDIF
4372: 
4373:         IF !USED(ALLTRIM(par_cCursorOrigem))
4374:             RETURN .F.
4375:         ENDIF
4376: 
4377:         IF !USED("cursor_4c_Precos")
4378:             THIS.CriarCursorPrecos()
4379:         ENDIF
4380: 
4381:         TRY
4382:             *-- ZAP (nao fechar/recriar): fechar o alias derrubaria o
4383:             *-- RecordSource da grade e ela viraria um retangulo branco.
4384:             SELECT cursor_4c_Precos
4385:             THIS.ZaparCursor("cursor_4c_Precos")
4386: 
4387:             *-- APPEND FROM DBF casa os campos por NOME: o alias do pai tem de
4388:             *-- trazer lprecos/tabds/units/moedas.
4389:             SELECT cursor_4c_Precos
4390:             APPEND FROM DBF(ALLTRIM(par_cCursorOrigem))
4391: 
4392:             GO TOP IN cursor_4c_Precos
4393: 
4394:             WITH THIS.pgf_4c_Paginas.Page4.grd_4c_Dados
4395:                 .Visible = (RECCOUNT("cursor_4c_Precos") > 0)
4396:                 .Refresh()
4397:             ENDWITH
4398: 
4399:             loc_lSucesso = .T.
4400: 
4401:         CATCH TO loc_oErro
4402:             THIS.this_cMensagemErro = loc_oErro.Message
4403:             MsgErro("Erro ao carregar a lista de precifica" + CHR(231) + CHR(227) + ;
4404:                     "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
4405:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4406:                     "Proc: " + loc_oErro.Procedure, "Erro CarregarPrecos")
4407:         ENDTRY
4408: 
4409:         RETURN loc_lSucesso
4410:     ENDPROC
4411: 
4412:     *==========================================================================
4413:     * ZaparCursor - ZAP guardado por SAFETY para qualquer alias. Irmao de
4414:     * ZaparCursorItens: SET SAFETY eh escopado por DATA SESSION e este form eh
4415:     * DataSession = 2, onde SAFETY volta a ON mesmo com o SET SAFETY OFF do
4416:     * main.prg - e com SAFETY ON o ZAP abre o dialogo "Zap ... Are you sure?"
4417:     * e CONGELA a tela esperando um clique que ninguem ve.
4418:     *==========================================================================
4419:     PROTECTED PROCEDURE ZaparCursor(par_cAlias)
4420:         LOCAL loc_cSafety
4421: 
4422:         IF VARTYPE(par_cAlias) <> "C" OR !USED(ALLTRIM(par_cAlias))
4423:             RETURN .F.
4424:         ENDIF
4425: 
4426:         loc_cSafety = SET("SAFETY")
4427:         SET SAFETY OFF
4428: 
4429:         SELECT (ALLTRIM(par_cAlias))
4430:         ZAP
4431: 
4432:         IF loc_cSafety = "ON"
4433:             SET SAFETY ON
4434:         ENDIF
4435: 
4436:         RETURN .T.
4437:     ENDPROC
4438: 
4439:     *==========================================================================
4440:     * GradeAfterRowColChange - Handler de AfterRowColChange de grd_4c_Dados.
4441:     *
4442:     * Declara par_nColIndex porque o evento passa esse argumento e handler sem
4443:     * o parametro estoura a cada troca de celula (regra #3). O uso aqui eh o
4444:     * MESMO do legado: carregar o detalhe da LINHA corrente, sem filtrar por
4445:     * coluna - validacao de celula NAO entra aqui (regra #46), ela mora no
4446:     * Valid do TextBox da coluna.
4447:     *
4448:     * PUBLIC: eh alvo de BINDEVENT e tambem do harness de teste.
4449:     *==========================================================================
4450:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
4451:         THIS.AtualizarPainelProduto()
4452:         THIS.AjustarBotoesPorModo()
4453:     ENDPROC
4454: 
4455:     *==========================================================================
4456:     * AtualizarPainelProduto - Preenche os campos de EXIBICAO de Page1 e Page3
4457:     * a partir do produto da linha corrente da grade.
4458:     *
4459:     * Transcreve o bloco de preenchimento do fwGrade.AfterRowColChange do
4460:     * legado: consulta SigCdPro (com LEFT JOIN em SigCdCol para a descricao da
4461:     * colecao), SigPrFnc (referencia do fornecedor por conta), SigMvEst (saldo
4462:     * do produto no grupo de estoque), SigCdCli (nome do fornecedor) e
4463:     * SigCdClf (descricao da classificacao fiscal), e devolve:
4464:     *
4465:     *   getPVens/getMoeVs       <- crTmpPro.PVens / .MoeVs
4466:     *   cntReffs.getReffs       <- SigPrFnc.Reffs, com fallback SigCdPro.Reffs
4467:     *   getGVendas              <- Colecoes + " - " + Descs da colecao
4468:     *   getObsPes/getObsPeds    <- crTmpPro.ObsPes / .ObsPeds
4469:     *   getPesoms               <- crTmpPro.Pesoms
4470:     *   gerDIfors               <- SigCdCli.RClis do fornecedor do produto
4471:     *   getsaldo                <- SigMvEst.Sqtds
4472:     *   getqtresta              <- qtds - qtbaixas (qtds quando nada baixado)
4473:     *   lblVDescs/lblPDescs     <- trocam para "Acrescimo" quando ValDescs < 0
4474:     *   getFClFis/getFDlFis     <- classificacao fiscal e a descricao dela
4475:     *
4476:     * Os campos que SAO coluna de SigMvItn nao aparecem aqui: eles tem
4477:     * ControlSource sobre cursor_4c_Itens e acompanham a linha sozinhos - no
4478:     * legado eram atribuidos um a um porque la nao havia ControlSource.
4479:     *
4480:     * PUBLIC: o form pai e o harness chamam de fora.
4481:     *==========================================================================
4482:     PROCEDURE AtualizarPainelProduto()
4483:         LOCAL loc_oPag, loc_oFis, loc_cPro, loc_cSQL, loc_cReff, loc_cDsCol
4484:         LOCAL loc_cNomeFor, loc_cClFis, loc_cDsClFis, loc_nSaldo, loc_nResta
4485:         LOCAL loc_lProsseguir, loc_oErro
4486: 
4487:         loc_oPag = THIS.pgf_4c_Paginas.Page1
4488:         loc_oFis = THIS.pgf_4c_Paginas.Page3.cnt_4c_Item
4489: 
4490:         loc_cPro = ""
4491:         IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
4492:             loc_cPro = ALLTRIM(cursor_4c_Itens.cpros)
4493:         ENDIF
4494: 
4495:         *-- Linha sem produto: painel limpo, como no ramo ELSE do legado
4496:         IF EMPTY(loc_cPro)
4497:             THIS.LimparPainelProduto()
4498:             RETURN .F.
4499:         ENDIF
4500: 
4501:         *-- Sem conexao (validacao de UI / modo teste) nao ha o que consultar;
4502:         *-- os campos ligados ao cursor continuam mostrando o item.
4503:         IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
4504:             THIS.LimparPainelProduto()
4505:             RETURN .F.
4506:         ENDIF
4507: 
4508:         loc_lProsseguir = .T.
4509:         loc_cReff       = ""
4510:         loc_cDsCol      = ""
4511:         loc_cNomeFor    = ""
4512:         loc_cClFis      = ""
4513:         loc_cDsClFis    = ""
4514:         loc_nSaldo      = 0
4515: 
4516:         TRY
4517:             *-- Produto + descricao da colecao -----------------------------
4518:             loc_cSQL = "SELECT a.Cpros, a.CGrus, a.Reffs, a.Situas," + ;
4519:                        " a.DtSituas, a.CUnis, a.Dpros, a.PesoMs, a.MoeVs," + ;
4520:                        " a.PVens, a.Moedas, a.Colecoes, a.ClFiscals," + ;
4521:                        " a.ObsPes, a.ObsPeds, a.Conjunts, a.ifors," + ;
4522:                        " b.Descs AS ColDescs" + ;

*-- Linhas 4656 a 4771:
4656:             MsgErro("Erro ao atualizar os dados do produto:" + CHR(13) + ;
4657:                     loc_oErro.Message + CHR(13) + ;
4658:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4659:                     "Proc: " + loc_oErro.Procedure, "Erro AtualizarPainelProduto")
4660:             loc_lProsseguir = .F.
4661:         ENDTRY
4662: 
4663:         RETURN loc_lProsseguir
4664:     ENDPROC
4665: 
4666:     *==========================================================================
4667:     * ExecutarConsultaPainel - SQLEXEC das consultas de EXIBICAO do painel.
4668:     * Nenhuma delas alimenta grade, entao o alias pode ser fechado e recriado
4669:     * sem risco - o guard testa o BUFFERING antes do TABLEREVERT (regra #52).
4670:     * Falha de consulta nao interrompe o preenchimento: o legado segue com o
4671:     * campo em branco nos mesmos casos.
4672:     *==========================================================================
4673:     PROTECTED FUNCTION ExecutarConsultaPainel(par_cSQL, par_cCursor)
4674:         LOCAL loc_nResultado, loc_lOk
4675: 
4676:         loc_lOk = .F.
4677: 
4678:         IF USED(par_cCursor)
4679:             IF CURSORGETPROP("Buffering", par_cCursor) > 1
4680:                 TABLEREVERT(.T., par_cCursor)
4681:             ENDIF
4682:             USE IN (par_cCursor)
4683:         ENDIF
4684: 
4685:         loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)
4686: 
4687:         IF loc_nResultado >= 0
4688:             loc_lOk = .T.
4689:         ELSE
4690:             THIS.this_cMensagemErro = CapturarErroSQL()
4691:         ENDIF
4692: 
4693:         RETURN loc_lOk
4694:     ENDFUNC
4695: 
4696:     *==========================================================================
4697:     * FecharCursoresPainel - Fecha os cursores auxiliares do painel e devolve a
4698:     * area de trabalho corrente para cursor_4c_Itens, que eh o alias da grade.
4699:     *==========================================================================
4700:     PROTECTED PROCEDURE FecharCursoresPainel()
4701:         IF USED("cursor_4c_ProTmp")
4702:             USE IN cursor_4c_ProTmp
4703:         ENDIF
4704:         IF USED("cursor_4c_FProTmp")
4705:             USE IN cursor_4c_FProTmp
4706:         ENDIF
4707:         IF USED("cursor_4c_SaldoTmp")
4708:             USE IN cursor_4c_SaldoTmp
4709:         ENDIF
4710:         IF USED("cursor_4c_ForTmp")
4711:             USE IN cursor_4c_ForTmp
4712:         ENDIF
4713:         IF USED("cursor_4c_ClfTmp")
4714:             USE IN cursor_4c_ClfTmp
4715:         ENDIF
4716: 
4717:         IF USED("cursor_4c_Itens")
4718:             SELECT cursor_4c_Itens
4719:         ENDIF
4720:     ENDPROC
4721: 
4722:     *==========================================================================
4723:     * LimparPainelProduto - Ramo ELSE do fwGrade.AfterRowColChange do legado:
4724:     * linha sem produto deixa o painel em branco.
4725:     *
4726:     * So zera os campos de EXIBICAO (sem ControlSource). Os que estao ligados a
4727:     * cursor_4c_Itens NAO entram aqui: escrever .Value neles gravaria no
4728:     * cursor, apagando o item - eles ja mostram branco porque a linha esta
4729:     * vazia.
4730:     *==========================================================================
4731:     PROCEDURE LimparPainelProduto()
4732:         LOCAL loc_oPag
4733: 
4734:         loc_oPag = THIS.pgf_4c_Paginas.Page1
4735: 
4736:         WITH loc_oPag
4737:             .txt_4c_PVens.Value      = 0
4738:             .txt_4c_Peso.Value       = 0
4739:             .txt_4c_Saldo.Value      = 0
4740:             .txt_4c_Qtresta.Value    = 0
4741:             .txt_4c_GVendas.Value    = ""
4742:             .txt_4c_Conjunts.Value   = ""
4743:             .txt_4c_GerDIfors.Value  = ""
4744:             .obj_4c_GetObsPes.Value  = ""
4745:             .obj_4c_GetObsPeds.Value = ""
4746:             .cnt_4c_Reffs.txt_4c_Reffs.Value = ""
4747:             .img_4c_ImgProds.Picture = ""
4748:             .img_4c_ImgProds.Visible = .F.
4749:             .lbl_4c_LblVDescs.Caption = "Valor Desconto"
4750:             .lbl_4c_LblPDescs.Caption = "% Desconto"
4751:         ENDWITH
4752: 
4753:         WITH THIS.pgf_4c_Paginas.Page3.cnt_4c_Item
4754:             .txt_4c_FClFis.Value = ""
4755:             .txt_4c_FDlFis.Value = ""
4756:         ENDWITH
4757:     ENDPROC
4758: 
4759:     *==========================================================================
4760:     * ObterContaFornecedor - Conta usada para achar a referencia do fornecedor
4761:     * em SigPrFnc. Legado:
4762:     *
4763:     *   _Ct = Iif(crSigOpCdd.ChkIfors=1, TprMvCab.ContaOs,
4764:     *             Iif(crSigOpCdd.ChkIfors=2, TprMvCab.Contads, ''))
4765:     *
4766:     * crSigOpCdd vive no data session do form PAI. Sem a configuracao, o
4767:     * legado cai no terceiro ramo (string vazia) - e eh esse o default aqui:
4768:     * a conta de ORIGEM quando ela existe, a de DESTINO como alternativa,
4769:     * vazio quando nenhuma veio do pai.
4770:     *==========================================================================
4771:     PROTECTED FUNCTION ObterContaFornecedor()

*-- Linhas 4822 a 4947:
4822:     * Ligado ao LostFocus do campo porque no legado a procura mora no Valid,
4823:     * isto eh: dispara ao SAIR do campo (regra #47).
4824:     *
4825:     * PUBLIC: alvo de BINDEVENT e do harness de teste.
4826:     *==========================================================================
4827:     PROCEDURE BtnBuscarClick()
4828:         LOCAL loc_oPag, loc_cDigitado, loc_nOpcao, loc_nBarra, loc_nRecno
4829:         LOCAL loc_oErro
4830: 
4831:         loc_oPag     = THIS.pgf_4c_Paginas.Page1
4832:         loc_cDigitado = ALLTRIM(loc_oPag.txt_4c_Busca.Value)
4833:         loc_nOpcao    = loc_oPag.obj_4c_Opt_Busca.Value
4834: 
4835:         IF EMPTY(loc_cDigitado) OR !USED("cursor_4c_Itens")
4836:             loc_oPag.txt_4c_Busca.Value = ""
4837:             RETURN .F.
4838:         ENDIF
4839: 
4840:         THIS.this_lProcuraCB = .T.
4841:         loc_nRecno           = 0
4842: 
4843:         TRY
4844:             SELECT cursor_4c_Itens
4845: 
4846:             IF loc_nOpcao = 1
4847:                 loc_nBarra = INT(VAL(loc_cDigitado))
4848:                 LOCATE FOR cursor_4c_Itens.codbarras = loc_nBarra
4849:             ELSE
4850:                 LOCATE FOR ALLTRIM(cursor_4c_Itens.cpros) == loc_cDigitado
4851:             ENDIF
4852: 
4853:             IF FOUND()
4854:                 loc_nRecno = RECNO("cursor_4c_Itens")
4855:             ENDIF
4856: 
4857:         CATCH TO loc_oErro
4858:             MsgErro("Erro ao procurar na grade:" + CHR(13) + loc_oErro.Message + ;
4859:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4860:                     "Proc: " + loc_oErro.Procedure, "Erro BtnBuscarClick")
4861:         ENDTRY
4862: 
4863:         *-- LostFocus do legado: limpa o campo de procura sempre
4864:         loc_oPag.txt_4c_Busca.Value = ""
4865: 
4866:         IF loc_nRecno > 0
4867:             SELECT cursor_4c_Itens
4868:             GO loc_nRecno
4869:             THIS.AtualizarPainelProduto()
4870:             THIS.RepintarGradeItens()
4871:             SELECT cursor_4c_Itens
4872:             GO loc_nRecno
4873:             THIS.grd_4c_Dados.Refresh()
4874:         ELSE
4875:             MsgAviso("Item n" + CHR(227) + "o encontrado na grade.", "Procurar")
4876:         ENDIF
4877: 
4878:         THIS.this_lProcuraCB = .F.
4879: 
4880:         RETURN (loc_nRecno > 0)
4881:     ENDPROC
4882: 
4883:     *==========================================================================
4884:     * TxtProdLostFocus - Conferencia por codigo (get_prod do legado).
4885:     *
4886:     * O legado resolve o valor digitado nesta ordem (get_prod.Valid):
4887:     *   1. codigo de barras que JA esta numa linha da grade (Seek em
4888:     *      crTpmMvItn por codbarras) - marca ThisForm.Barra e usa o produto
4889:     *      daquela linha;
4890:     *   2. etiqueta individual em SigOpEtq (com LEFT JOIN em SigOpEta para
4891:     *      aceitar a barra antiga de uma etiqueta reemitida);
4892:     *   3. SigCdPro.Cbars (codigo de barras do cadastro);
4893:     *   4. SigCdPro.Ean13;
4894:     *   5. o proprio valor como CPros.
4895:     * Em qualquer caminho, achando o produto ele confere a unidade: se
4896:     * SigCdUni.etiqs = 'S' recusa com "Codigo Errado - Etiqueta Especial !!".
4897:     * Nao achando, avisa "Produto Nao Cadastrado!!!".
4898:     *
4899:     * fVerificarBarras() (SIGFUNCS.PRG) NAO foi portada. No legado ela apenas
4900:     * ESCOLHE entre o ramo de barras e o ramo de EAN13 - e os dois ramos
4901:     * terminam na mesma consulta a SigCdPro - entao tentar as duas resolucoes
4902:     * em sequencia produz o mesmo resultado sem o wrapper (mesma decisao
4903:     * documentada em FormSigPrEtq, regra #27 "no-op documentado").
4904:     *
4905:     * PUBLIC: alvo de BINDEVENT e do harness de teste.
4906:     *==========================================================================
4907:     PROCEDURE TxtProdLostFocus()
4908:         LOCAL loc_oPag, loc_cDigitado, loc_cProduto
4909: 
4910:         loc_oPag      = THIS.pgf_4c_Paginas.Page1
4911:         loc_cDigitado = ALLTRIM(loc_oPag.txt_4c__prod.Value)
4912: 
4913:         THIS.this_nBarra = 0
4914: 
4915:         IF EMPTY(loc_cDigitado)
4916:             RETURN .F.
4917:         ENDIF
4918: 
4919:         *-- Guarda de reentrancia: o aviso eh modal, tira o foco e faria o
4920:         *-- proprio LostFocus disparar de novo (regra #37/#47).
4921:         IF THIS.this_lEmLookup
4922:             RETURN .F.
4923:         ENDIF
4924:         THIS.this_lEmLookup = .T.
4925: 
4926:         loc_cProduto = THIS.ResolverProdutoDigitado(loc_cDigitado)
4927: 
4928:         IF EMPTY(loc_cProduto)
4929:             THIS.this_lValidOk = .F.
4930:         ELSE
4931:             THIS.this_lValidOk = .T.
4932:             loc_oPag.txt_4c__prod.Value = loc_cProduto
4933:             loc_oPag.txt_4c__prod.Refresh()
4934: 
4935:             THIS.CarregarImagemProduto(loc_cProduto)
4936: 
4937:             *-- Legado (get_prod.LostFocus): com ZerQtds = 2 e barra lida, a
4938:             *-- quantidade 1 eh assumida e o fluxo segue para a conferencia.
4939:             IF THIS.this_nZerQtds = 2 AND THIS.this_nBarra <> 0
4940:                 loc_oPag.txt_4c__qtd.Value = 1
4941:             ENDIF
4942:         ENDIF
4943: 
4944:         THIS.this_lEmLookup = .F.
4945: 
4946:         RETURN THIS.this_lValidOk
4947:     ENDPROC

*-- Linhas 4975 a 5018:
4975: 
4976:         IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
4977:             IF EMPTY(loc_cProduto)
4978:                 MsgAviso("Conex" + CHR(227) + "o com o banco n" + CHR(227) + ;
4979:                          "o dispon" + CHR(237) + "vel.", "Aten" + CHR(231) + CHR(227) + "o!!!")
4980:             ENDIF
4981:             RETURN loc_cProduto
4982:         ENDIF
4983: 
4984:         TRY
4985:             *-- 2. Etiqueta individual (SigOpEtq + SigOpEta) ---------------
4986:             IF EMPTY(loc_cProduto) AND loc_nBarra <> 0
4987:                 loc_cSQL = "SELECT a.CPros, a.CBars, a.CodTams, a.Contas" + ;
4988:                            " FROM SigOpEtq a" + ;
4989:                            " LEFT JOIN SigOpEta b ON a.cpros = b.cpros" + ;
4990:                            " AND a.cbars = b.cbars_new" + ;
4991:                            " WHERE (a.CBars = " + FormatarNumeroSQL(loc_nBarra, 0) + ;
4992:                            " OR b.cbars_old = " + FormatarNumeroSQL(loc_nBarra, 0) + ")"
4993: 
4994:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_EtqTmp")
4995:                     IF USED("cursor_4c_EtqTmp")
4996:                         SELECT cursor_4c_EtqTmp
4997:                         GO TOP
4998:                         IF !EOF()
4999:                             THIS.this_nBarra = loc_nBarra
5000:                             loc_cProduto     = ALLTRIM(TratarNulo(cursor_4c_EtqTmp.CPros, ""))
5001:                         ENDIF
5002:                         USE IN cursor_4c_EtqTmp
5003:                     ENDIF
5004:                 ENDIF
5005:             ENDIF
5006: 
5007:             *-- 3. Codigo de barras do cadastro (SigCdPro.Cbars) -----------
5008:             IF EMPTY(loc_cProduto) AND loc_nBarra <> 0
5009:                 loc_cSQL = "SELECT Cpros FROM SigCdPro" + ;
5010:                            " WHERE Cbars = " + FormatarNumeroSQL(loc_nBarra, 0)
5011: 
5012:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_BarTmp")
5013:                     IF USED("cursor_4c_BarTmp")
5014:                         SELECT cursor_4c_BarTmp
5015:                         GO TOP
5016:                         IF !EOF()
5017:                             THIS.this_nBarra = loc_nBarra
5018:                             loc_cProduto     = ALLTRIM(TratarNulo(cursor_4c_BarTmp.Cpros, ""))

*-- Linhas 5056 a 5150:
5056:                     SELECT cursor_4c_ProdTmp
5057:                     GO TOP
5058:                     IF EOF()
5059:                         MsgAviso("Produto N" + CHR(227) + "o Cadastrado!!! " + ;
5060:                                  CHR(13) + loc_cProduto, ;
5061:                                  "Aten" + CHR(231) + CHR(227) + "o!!!")
5062:                         loc_cProduto = ""
5063:                     ELSE
5064:                         loc_cUnidade = UPPER(ALLTRIM(TratarNulo(cursor_4c_ProdTmp.etiqs, "")))
5065:                         *-- Legado: CrSigCdUni.etiqs = 'S' recusa a digitacao
5066:                         *-- manual porque o produto exige etiqueta especial.
5067:                         IF loc_cUnidade == "S"
5068:                             MsgAviso("C" + CHR(243) + "digo Errado - Etiqueta Especial !!", ;
5069:                                      "Aten" + CHR(231) + CHR(227) + "o!!!")
5070:                             loc_cProduto = ""
5071:                         ELSE
5072:                             loc_cProduto = ALLTRIM(TratarNulo(cursor_4c_ProdTmp.Cpros, loc_cProduto))
5073:                         ENDIF
5074:                     ENDIF
5075:                     USE IN cursor_4c_ProdTmp
5076:                 ENDIF
5077:             ELSE
5078:                 loc_cProduto = ""
5079:             ENDIF
5080: 
5081:         CATCH TO loc_oErro
5082:             loc_cProduto = ""
5083:             MsgErro("Erro ao resolver o produto digitado:" + CHR(13) + ;
5084:                     loc_oErro.Message + CHR(13) + ;
5085:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5086:                     "Proc: " + loc_oErro.Procedure, "Erro ResolverProdutoDigitado")
5087:         ENDTRY
5088: 
5089:         IF USED("cursor_4c_Itens")
5090:             SELECT cursor_4c_Itens
5091:         ENDIF
5092: 
5093:         RETURN loc_cProduto
5094:     ENDFUNC
5095: 
5096:     *==========================================================================
5097:     * CarregarImagemProduto - Foto do produto em img_4c_ImgProds. Legado
5098:     * (get_prod.Valid e fwGrade.AfterRowColChange):
5099:     *
5100:     *   If CrSigCdOpe.Imagems = 1
5101:     *       imgProds.Visible = .F. / imgProds.Picture = ''
5102:     *       If Not Empty(CrTmpPro.FigJpgs) And Not Isnull(CrTmpPro.FigJpgs)
5103:     *           lcFoto = Strconv(Strtran(... data:image/...;base64, ...),14)
5104:     *           If (StrToFile(lcFoto, lcArquivo3) > 0)
5105:     *               imgProds.Picture = (lcArquivo3) / imgProds.Visible = .T.
5106:     *
5107:     * STRCONV(...,14) decodifica Base64 UMA vez - decodificar duas vezes
5108:     * devolve lixo e o LOADPICTURE/Picture falha sem mensagem.
5109:     *==========================================================================
5110:     PROTECTED PROCEDURE CarregarImagemProduto(par_cProduto)
5111:         LOCAL loc_oImg, loc_cSQL, loc_cFig, loc_cFoto, loc_cArquivo, loc_oErro
5112: 
5113:         loc_oImg = THIS.pgf_4c_Paginas.Page1.img_4c_ImgProds
5114: 
5115:         loc_oImg.Visible = .F.
5116:         loc_oImg.Picture = ""
5117: 
5118:         *-- Legado so carrega a foto quando a operacao pede (Imagems = 1)
5119:         IF THIS.this_nImagems <> 1
5120:             RETURN .F.
5121:         ENDIF
5122: 
5123:         IF VARTYPE(par_cProduto) <> "C" OR EMPTY(par_cProduto)
5124:             RETURN .F.
5125:         ENDIF
5126: 
5127:         IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
5128:             RETURN .F.
5129:         ENDIF
5130: 
5131:         TRY
5132:             loc_cSQL = "SELECT FigJpgs FROM SigCdPro" + ;
5133:                        " WHERE Cpros = " + EscaparSQL(ALLTRIM(par_cProduto))
5134: 
5135:             IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_FigTmp")
5136:                 IF USED("cursor_4c_FigTmp")
5137:                     SELECT cursor_4c_FigTmp
5138:                     GO TOP
5139:                     IF !EOF()
5140:                         loc_cFig = TratarNulo(cursor_4c_FigTmp.FigJpgs, "")
5141: 
5142:                         IF !EMPTY(loc_cFig)
5143:                             loc_cFig = STRTRAN(loc_cFig, "data:image/png;base64,",  "")
5144:                             loc_cFig = STRTRAN(loc_cFig, "data:image/jpeg;base64,", "")
5145:                             loc_cFig = STRTRAN(loc_cFig, "data:image/jpg;base64,",  "")
5146: 
5147:                             loc_cFoto    = STRCONV(loc_cFig, 14)
5148:                             loc_cArquivo = ADDBS(SYS(2023)) + "SigOpPro_" + ;
5149:                                            SYS(2015) + ".jpg"
5150: 

*-- Linhas 5193 a 5238:
5193:     *       ... Skip -1 / fwgrade.Refresh / get_prod.SetFocus / Barra = 0
5194:     *   Endif
5195:     *
5196:     * PUBLIC: alvo de BINDEVENT e do harness de teste.
5197:     *==========================================================================
5198:     PROCEDURE TxtQtdLostFocus()
5199:         LOCAL loc_oPag, loc_cProduto, loc_nQtde, loc_lAchouLinha, loc_lConfere
5200:         LOCAL loc_nRecnoAchado, loc_oErro
5201: 
5202:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5203: 
5204:         loc_nQtde    = loc_oPag.txt_4c__qtd.Value
5205:         loc_cProduto = PADR(ALLTRIM(loc_oPag.txt_4c__prod.Value), 14)
5206: 
5207:         IF VARTYPE(loc_nQtde) <> "N" OR loc_nQtde = 0
5208:             RETURN .F.
5209:         ENDIF
5210: 
5211:         IF !USED("cursor_4c_Itens")
5212:             RETURN .F.
5213:         ENDIF
5214: 
5215:         IF THIS.this_lEmLookup
5216:             RETURN .F.
5217:         ENDIF
5218:         THIS.this_lEmLookup = .T.
5219: 
5220:         loc_lAchouLinha = .F.
5221:         loc_lConfere    = .F.
5222:         loc_nRecnoAchado = 0
5223: 
5224:         TRY
5225:             SELECT cursor_4c_Itens
5226:             SET ORDER TO
5227:             GO TOP
5228: 
5229:             *-- Procura a linha ainda nao conferida cuja quantidade bate.
5230:             *-- Com barra lida (this_nBarra) o legado nao exige casar o
5231:             *-- produto: a barra ja identificou a linha.
5232:             SCAN
5233:                 IF THIS.this_nBarra <> 0
5234:                     IF cursor_4c_Itens.codbarras <> THIS.this_nBarra
5235:                         LOOP
5236:                     ENDIF
5237:                 ELSE
5238:                     IF PADR(cursor_4c_Itens.cpros, 14) <> loc_cProduto

*-- Linhas 5259 a 5373:
5259:         CATCH TO loc_oErro
5260:             MsgErro("Erro ao conferir o item:" + CHR(13) + loc_oErro.Message + ;
5261:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5262:                     "Proc: " + loc_oErro.Procedure, "Erro TxtQtdLostFocus")
5263:         ENDTRY
5264: 
5265:         DO CASE
5266:             CASE loc_lConfere
5267:                 THIS.RepintarGradeItens()
5268:                 IF loc_nRecnoAchado > 0
5269:                     SELECT cursor_4c_Itens
5270:                     GO loc_nRecnoAchado
5271:                 ENDIF
5272:                 THIS.AtualizarPainelProduto()
5273:             CASE loc_lAchouLinha
5274:                 MsgAviso("Quantidade Errada !!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5275:             OTHERWISE
5276:                 MsgAviso("Item n" + CHR(227) + "o encontrado !!", ;
5277:                          "Aten" + CHR(231) + CHR(227) + "o!!!")
5278:         ENDCASE
5279: 
5280:         *-- Em TODOS os caminhos o legado limpa os dois campos e devolve o
5281:         *-- foco ao codigo, pronto para a leitura seguinte.
5282:         THIS.this_nBarra            = 0
5283:         THIS.this_lEmLookup         = .F.
5284: 
5285:         IF loc_oPag.txt_4c__prod.Visible AND loc_oPag.txt_4c__prod.Enabled
5286:             loc_oPag.txt_4c__prod.SetFocus()
5287:         ENDIF
5288: 
5289:         RETURN loc_lConfere
5290:     ENDPROC
5291: 
5292:     *==========================================================================
5293:     * ValidarCodCorLostFocus - Cor do item (getCodCors.Valid do legado, que
5294:     * abre fwbuscaext sobre SigCdCor por 'Cods'). Aqui o browse eh o
5295:     * FormBuscaAuxiliar via AbrirLookupCanonico (padrao canonico do projeto).
5296:     *
5297:     * O valor escolhido volta para o proprio TextBox, que tem ControlSource em
5298:     * cursor_4c_Itens.codcors - entao ele grava na linha corrente, igual ao
5299:     * "This.Value = crListaRemota.Cods" do legado.
5300:     *
5301:     * PUBLIC: alvo de BINDEVENT.
5302:     *==========================================================================
5303:     PROCEDURE ValidarCodCorLostFocus()
5304:         LOCAL loc_oPag, loc_cValor
5305: 
5306:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
5307:         loc_cValor = ALLTRIM(TRANSFORM(loc_oPag.txt_4c_CodCors.Value))
5308: 
5309:         *-- Legado: "If !Empty(lcCodCors)" - vazio nao abre browse nenhum
5310:         IF EMPTY(loc_cValor)
5311:             RETURN .F.
5312:         ENDIF
5313: 
5314:         IF THIS.this_lEmLookup
5315:             RETURN .F.
5316:         ENDIF
5317:         THIS.this_lEmLookup = .T.
5318: 
5319:         THIS.AbrirLookupCanonico("SigCdCor", "Cods", "Descs", ;
5320:                                  "Sele" + CHR(231) + CHR(227) + "o de Cor", ;
5321:                                  loc_cValor, loc_oPag.txt_4c_CodCors, .NULL.)
5322: 
5323:         THIS.this_lEmLookup = .F.
5324: 
5325:         RETURN .T.
5326:     ENDPROC
5327: 
5328:     *==========================================================================
5329:     * ValidarCodTamLostFocus - Tamanho do item (getCodTams.Valid do legado,
5330:     * fwbuscaext sobre SigCdTam por 'Cods'). Mesmo desenho de
5331:     * ValidarCodCorLostFocus.
5332:     *==========================================================================
5333:     PROCEDURE ValidarCodTamLostFocus()
5334:         LOCAL loc_oPag, loc_cValor
5335: 
5336:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
5337:         loc_cValor = ALLTRIM(TRANSFORM(loc_oPag.txt_4c_CodTams.Value))
5338: 
5339:         IF EMPTY(loc_cValor)
5340:             RETURN .F.
5341:         ENDIF
5342: 
5343:         IF THIS.this_lEmLookup
5344:             RETURN .F.
5345:         ENDIF
5346:         THIS.this_lEmLookup = .T.
5347: 
5348:         THIS.AbrirLookupCanonico("SigCdTam", "Cods", "Descs", ;
5349:                                  "Sele" + CHR(231) + CHR(227) + "o de Tamanho", ;
5350:                                  loc_cValor, loc_oPag.txt_4c_CodTams, .NULL.)
5351: 
5352:         THIS.this_lEmLookup = .F.
5353: 
5354:         RETURN .T.
5355:     ENDPROC
5356: 
5357:     *==========================================================================
5358:     * ValidarVDescsLostFocus - Desconto em VALOR (getVDescs.Valid do legado):
5359:     *
5360:     *   If !Empty(this.Value) And (This.Value # ThisForm.OldPreco)
5361:     *       If this.Value > 0
5362:     *           Replace Units With UnitOrigs - this.Value in crTpmMvItn
5363:     *       Else
5364:     *           Replace Units With UnitOrigs + this.Value in crTpmMvItn
5365:     *       Endif
5366:     *       ... Replace Utilizas ... / ThisForm.ParentForm.calc_valite()
5367:     *
5368:     * A formula eh TRANSCRITA, nao reescrita (regra #17): valor POSITIVO eh
5369:     * desconto e SUBTRAI do unitario de origem; valor NEGATIVO eh acrescimo e
5370:     * SOMA. Quem recalcula o total do item eh o Calc_ValIte do form pai, via
5371:     * TotalizarLinha().
5372:     *==========================================================================
5373:     *==========================================================================

*-- Linhas 5398 a 5572:
5398:     * O legado tambem normaliza o valor com Transf(Val(This.Value),"@L 999999")
5399:     * - documento eh char(6) com zeros a esquerda.
5400:     *
5401:     * PUBLIC: alvo de BINDEVENT.
5402:     *==========================================================================
5403:     PROCEDURE ValidarDocsLostFocus()
5404:         LOCAL loc_oPag, loc_cNotas, loc_cSQL, loc_cChave, loc_nIguais
5405:         LOCAL loc_lOk, loc_nRecno, loc_oErro
5406: 
5407:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5408:         loc_lOk  = .T.
5409: 
5410:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
5411:             RETURN .T.
5412:         ENDIF
5413: 
5414:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
5415:             RETURN .T.
5416:         ENDIF
5417: 
5418:         loc_cNotas = ALLTRIM(TRANSFORM(loc_oPag.txt_4c_Docs.Value))
5419: 
5420:         *-- 1. Documento vazio -------------------------------------------
5421:         IF EMPTY(loc_cNotas)
5422:             IF THIS.this_nEditDocs = 5
5423:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar Documento do Produto " + ;
5424:                          ALLTRIM(cursor_4c_Itens.cpros), ;
5425:                          "Documento Obrigat" + CHR(243) + "rio")
5426:                 loc_lOk = .F.
5427:             ENDIF
5428:             RETURN loc_lOk
5429:         ENDIF
5430: 
5431:         *-- Normalizacao do legado: 6 posicoes com zeros a esquerda
5432:         loc_cNotas = PADL(ALLTRIM(STR(INT(VAL(loc_cNotas)), 6)), 6, "0")
5433:         loc_oPag.txt_4c_Docs.Value = loc_cNotas
5434: 
5435:         IF THIS.this_nValiNotas <> 1
5436:             RETURN .T.
5437:         ENDIF
5438: 
5439:         IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
5440:             RETURN .T.
5441:         ENDIF
5442: 
5443:         loc_cChave = THIS.ObterChaveMovimentacao()
5444: 
5445:         TRY
5446:             *-- 2a. Mesmo documento em OUTRA movimentacao da mesma operacao
5447:             loc_cSQL = "SELECT Emps, Dopes, Numes, empdopnums FROM SigMvItn" + ;
5448:                        " WHERE Notas = " + EscaparSQL(loc_cNotas) + ;
5449:                        " AND Dopes = " + EscaparSQL(PADR(THIS.this_cDopes, 20))
5450: 
5451:             IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_NotaTmp")
5452:                 IF USED("cursor_4c_NotaTmp")
5453:                     SELECT cursor_4c_NotaTmp
5454:                     SCAN
5455:                         IF ALLTRIM(TratarNulo(cursor_4c_NotaTmp.empdopnums, "")) <> ;
5456:                            ALLTRIM(loc_cChave)
5457:                             MsgAviso("Documento " + ALLTRIM(THIS.this_cDopes) + " " + ;
5458:                                      loc_cNotas + " J" + CHR(225) + " Existe !!", ;
5459:                                      "Opera" + CHR(231) + CHR(227) + "o: " + ;
5460:                                      ALLTRIM(TratarNulo(cursor_4c_NotaTmp.Emps, "")) + "-" + ;
5461:                                      ALLTRIM(TratarNulo(cursor_4c_NotaTmp.Dopes, "")) + "-" + ;
5462:                                      ALLTRIM(STR(TratarNulo(cursor_4c_NotaTmp.Numes, 0))))
5463:                             loc_lOk = .F.
5464:                             EXIT
5465:                         ENDIF
5466:                     ENDSCAN
5467:                     USE IN cursor_4c_NotaTmp
5468:                 ENDIF
5469:             ENDIF
5470: 
5471:             *-- 2b. Mesmo documento repetido DENTRO desta operacao
5472:             IF loc_lOk
5473:                 SELECT cursor_4c_Itens
5474:                 loc_nRecno = RECNO()
5475:                 COUNT FOR ALLTRIM(cursor_4c_Itens.notas) == loc_cNotas TO loc_nIguais
5476:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT("cursor_4c_Itens"))
5477:                     GO loc_nRecno
5478:                 ENDIF
5479: 
5480:                 IF loc_nIguais > 1
5481:                     MsgAviso("Documento " + ALLTRIM(THIS.this_cDopes) + " " + loc_cNotas + ;
5482:                              " J" + CHR(225) + " Lan" + CHR(231) + "ado Nessa Opera" + ;
5483:                              CHR(231) + CHR(227) + "o !!", ;
5484:                              "Opera" + CHR(231) + CHR(227) + "o: " + ALLTRIM(THIS.this_cDopes))
5485:                     loc_lOk = .F.
5486:                 ENDIF
5487:             ENDIF
5488: 
5489:             *-- 3. Valor unitario vindo do documento (produto 'C')
5490:             IF loc_lOk AND THIS.this_nOpVlUnis = 1 AND ;
5491:                PADR(cursor_4c_Itens.cpros, 14) == PADR("C", 14)
5492:                 THIS.AplicarValorDoDocumento(INT(VAL(loc_cNotas)))
5493:             ENDIF
5494: 
5495:         CATCH TO loc_oErro
5496:             MsgErro("Erro ao validar o documento do produto:" + CHR(13) + ;
5497:                     loc_oErro.Message + CHR(13) + ;
5498:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5499:                     "Proc: " + loc_oErro.Procedure, "Erro ValidarDocsLostFocus")
5500:             loc_lOk = .F.
5501:         ENDTRY
5502: 
5503:         IF USED("cursor_4c_Itens")
5504:             SELECT cursor_4c_Itens
5505:         ENDIF
5506: 
5507:         RETURN loc_lOk
5508:     ENDPROC
5509: 
5510:     *==========================================================================
5511:     * AplicarValorDoDocumento - Ramo "crSigOpCdc.OpVlUnis = 1" do
5512:     * getDocs.Valid: o valor unitario do item 'C' vem do documento informado.
5513:     *
5514:     * Legado:
5515:     *   lcSql = [Select a.Valos, a.Datas, a.EmpDopNums From SigMvCab a,
5516:     *            SigCdOpe b, SigCdTom c Where a.Dopes = b.Dopes And
5517:     *            b.TipoOps = c.Codigos And c.OpVlUnis = 1 And a.Numes = <n>
5518:     *            Order by A.Datas]
5519:     *   Select LocalEest / Go Bott
5520:     *   If Reccount() > 0
5521:     *       Replace Units With LocalEest.valos, Utilizas With 51 in crTpmMvItn
5522:     *       If crSigCdOpe.parcs = 1 ... soma SigMvPar em xPar ... Replace Units
5523:     *   ThisForm.Calc_ValIte()
5524:     *
5525:     * Utilizas = 51 eh a marca do legado para "preco travado pelo documento":
5526:     * os guards de When de getVDescs/getPDescs e da coluna Valor testam
5527:     * justamente esse valor.
5528:     *
5529:     * A acumulacao das parcelas grava no cursor xPar, que eh do form PAI; ela
5530:     * so roda quando o pai entregou esse cursor.
5531:     *==========================================================================
5532:     PROTECTED PROCEDURE AplicarValorDoDocumento(par_nNumero)
5533:         LOCAL loc_cSQL, loc_nValor, loc_cEdn, loc_nTotPar, loc_lAplicou
5534: 
5535:         loc_lAplicou = .F.
5536: 
5537:         IF VARTYPE(par_nNumero) <> "N" OR par_nNumero = 0
5538:             RETURN .F.
5539:         ENDIF
5540: 
5541:         loc_cSQL = "SELECT a.Valos, a.Datas, a.EmpDopNums" + ;
5542:                    " FROM SigMvCab a, SigCdOpe b, SigCdTom c" + ;
5543:                    " WHERE a.Dopes = b.Dopes" + ;
5544:                    " AND b.TipoOps = c.Codigos" + ;
5545:                    " AND c.OpVlUnis = 1" + ;
5546:                    " AND a.Numes = " + FormatarNumeroSQL(par_nNumero, 0) + ;
5547:                    " ORDER BY a.Datas"
5548: 
5549:         IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_DocValTmp")
5550:             IF USED("cursor_4c_DocValTmp")
5551:                 SELECT cursor_4c_DocValTmp
5552:                 GO BOTTOM
5553:                 IF RECCOUNT("cursor_4c_DocValTmp") > 0
5554:                     loc_nValor = TratarNulo(cursor_4c_DocValTmp.Valos, 0)
5555:                     loc_cEdn   = ALLTRIM(TratarNulo(cursor_4c_DocValTmp.EmpDopNums, ""))
5556: 
5557:                     SELECT cursor_4c_Itens
5558:                     REPLACE units    WITH loc_nValor, ;
5559:                             utilizas WITH 51 IN cursor_4c_Itens
5560: 
5561:                     *-- Parcelas: o cursor de destino (xPar) pertence ao form
5562:                     *-- PAI; sem ele entregue, o legado tambem nao soma nada.
5563:                     IF THIS.this_nParcs = 1 AND USED("xPar") AND !EMPTY(loc_cEdn)
5564:                         loc_cSQL = "SELECT Valos FROM SigMvPar" + ;
5565:                                    " WHERE EmpdopNums = " + EscaparSQL(loc_cEdn) + ;
5566:                                    " AND fPags = " + EscaparSQL("P")
5567: 
5568:                         IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_ParTmp")
5569:                             loc_nTotPar = 0
5570:                             IF USED("cursor_4c_ParTmp")
5571:                                 SELECT cursor_4c_ParTmp
5572:                                 SCAN

*-- Linhas 5622 a 6010:
5622:     * decimais; aqui o INT() sobre o valor digitado faz o mesmo sem mexer num
5623:     * SET global.
5624:     *
5625:     * PUBLIC: alvo de BINDEVENT.
5626:     *==========================================================================
5627:     PROCEDURE ValidarLotesLostFocus()
5628:         LOCAL loc_oPag, loc_nLote, loc_cLote, loc_nDope, loc_nNume
5629:         LOCAL loc_cDope, loc_nCtrl, loc_cSQL, loc_lOk, loc_oErro
5630: 
5631:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5632:         loc_lOk  = .T.
5633: 
5634:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
5635:             RETURN .T.
5636:         ENDIF
5637: 
5638:         loc_nLote = loc_oPag.txt_4c_Lotes.Value
5639: 
5640:         IF VARTYPE(loc_nLote) <> "N" OR loc_nLote = 0
5641:             RETURN .T.
5642:         ENDIF
5643: 
5644:         IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
5645:             RETURN .T.
5646:         ENDIF
5647: 
5648:         *-- 10 posicoes: 4 da operacao + 6 do numero da movimentacao
5649:         loc_cLote = PADL(ALLTRIM(STR(INT(loc_nLote), 10)), 10, "0")
5650:         loc_nDope = VAL(LEFT(loc_cLote, 4))
5651:         loc_nNume = VAL(RIGHT(loc_cLote, 6))
5652:         loc_cDope = ""
5653:         loc_nCtrl = 0
5654: 
5655:         TRY
5656:             loc_cSQL = "SELECT Dopes, Ctrllotes FROM SigCdOpe" + ;
5657:                        " WHERE nDopes = " + FormatarNumeroSQL(loc_nDope, 0)
5658: 
5659:             IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_OpeLoteTmp")
5660:                 IF USED("cursor_4c_OpeLoteTmp")
5661:                     SELECT cursor_4c_OpeLoteTmp
5662:                     GO TOP
5663:                     IF !EOF()
5664:                         loc_cDope = ALLTRIM(TratarNulo(cursor_4c_OpeLoteTmp.Dopes, ""))
5665:                         loc_nCtrl = TratarNulo(cursor_4c_OpeLoteTmp.Ctrllotes, 0)
5666:                     ENDIF
5667:                     USE IN cursor_4c_OpeLoteTmp
5668:                 ENDIF
5669:             ENDIF
5670: 
5671:             IF loc_nCtrl <> 1
5672:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o " + loc_cDope + ;
5673:                          " n" + CHR(227) + "o Configurada para gerar No. Lote !!", ;
5674:                          "Aten" + CHR(231) + CHR(227) + "o!!!")
5675:                 loc_lOk = .F.
5676:             ENDIF
5677: 
5678:             IF loc_lOk
5679:                 loc_cSQL = "SELECT EmpDopNums FROM SigMvCab" + ;
5680:                            " WHERE Numes = " + FormatarNumeroSQL(loc_nNume, 0) + ;
5681:                            " AND Dopes = " + EscaparSQL(PADR(loc_cDope, 20))
5682: 
5683:                 IF THIS.ExecutarConsultaPainel(loc_cSQL, "cursor_4c_LoteTmp")
5684:                     IF !USED("cursor_4c_LoteTmp") OR RECCOUNT("cursor_4c_LoteTmp") = 0
5685:                         MsgAviso("Lote N" + CHR(186) + " " + ALLTRIM(loc_cLote) + ;
5686:                                  " n" + CHR(227) + "o Existe !!", ;
5687:                                  "Aten" + CHR(231) + CHR(227) + "o!!!")
5688:                         loc_lOk = .F.
5689:                     ENDIF
5690:                     IF USED("cursor_4c_LoteTmp")
5691:                         USE IN cursor_4c_LoteTmp
5692:                     ENDIF
5693:                 ELSE
5694:                     MsgAviso("Lote N" + CHR(186) + " " + ALLTRIM(loc_cLote) + ;
5695:                              " n" + CHR(227) + "o Existe !!", ;
5696:                              "Aten" + CHR(231) + CHR(227) + "o!!!")
5697:                     loc_lOk = .F.
5698:                 ENDIF
5699:             ENDIF
5700: 
5701:         CATCH TO loc_oErro
5702:             MsgErro("Erro ao validar o n" + CHR(250) + "mero do lote:" + CHR(13) + ;
5703:                     loc_oErro.Message + CHR(13) + ;
5704:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5705:                     "Proc: " + loc_oErro.Procedure, "Erro ValidarLotesLostFocus")
5706:             loc_lOk = .F.
5707:         ENDTRY
5708: 
5709:         IF USED("cursor_4c_Itens")
5710:             SELECT cursor_4c_Itens
5711:         ENDIF
5712: 
5713:         RETURN loc_lOk
5714:     ENDPROC
5715: 
5716:     PROCEDURE ValidarVDescsLostFocus()
5717:         LOCAL loc_oPag, loc_nValor, loc_nOrig, loc_oErro
5718: 
5719:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5720: 
5721:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
5722:             RETURN .F.
5723:         ENDIF
5724: 
5725:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
5726:             RETURN .F.
5727:         ENDIF
5728: 
5729:         loc_nValor = loc_oPag.txt_4c_VDescs.Value
5730: 
5731:         IF VARTYPE(loc_nValor) <> "N" OR loc_nValor = 0
5732:             RETURN .F.
5733:         ENDIF
5734: 
5735:         TRY
5736:             SELECT cursor_4c_Itens
5737:             loc_nOrig = TratarNulo(cursor_4c_Itens.unitorigs, 0)
5738: 
5739:             IF loc_nOrig = 0
5740:                 loc_nOrig = TratarNulo(cursor_4c_Itens.units, 0)
5741:                 REPLACE unitorigs WITH loc_nOrig IN cursor_4c_Itens
5742:             ENDIF
5743: 
5744:             IF loc_nValor > 0
5745:                 REPLACE units WITH loc_nOrig - loc_nValor IN cursor_4c_Itens
5746:             ELSE
5747:                 REPLACE units WITH loc_nOrig + loc_nValor IN cursor_4c_Itens
5748:             ENDIF
5749: 
5750:         CATCH TO loc_oErro
5751:             MsgErro("Erro ao aplicar o desconto:" + CHR(13) + loc_oErro.Message + ;
5752:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5753:                     "Proc: " + loc_oErro.Procedure, "Erro ValidarVDescsLostFocus")
5754:         ENDTRY
5755: 
5756:         THIS.TotalizarLinha(.F.)
5757:         THIS.AtualizarPainelProduto()
5758: 
5759:         RETURN .T.
5760:     ENDPROC
5761: 
5762:     *==========================================================================
5763:     * ValidarPDescsLostFocus - Desconto em PERCENTUAL (getPDescs.Valid do
5764:     * legado):
5765:     *
5766:     *   If this.Value > 0
5767:     *       Replace Units With UnitOrigs - ((Abs(this.Value) * UnitOrigs) / 100)
5768:     *   Else
5769:     *       Replace Units With UnitOrigs + ((Abs(this.Value) * UnitOrigs) / 100)
5770:     *
5771:     * Formula TRANSCRITA do legado, com o ABS e a divisao por 100 na mesma
5772:     * ordem (regra #17).
5773:     *==========================================================================
5774:     PROCEDURE ValidarPDescsLostFocus()
5775:         LOCAL loc_oPag, loc_nPerc, loc_nOrig, loc_oErro
5776: 
5777:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5778: 
5779:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
5780:             RETURN .F.
5781:         ENDIF
5782: 
5783:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
5784:             RETURN .F.
5785:         ENDIF
5786: 
5787:         loc_nPerc = loc_oPag.txt_4c_PDescs.Value
5788: 
5789:         IF VARTYPE(loc_nPerc) <> "N" OR loc_nPerc = 0
5790:             RETURN .F.
5791:         ENDIF
5792: 
5793:         TRY
5794:             SELECT cursor_4c_Itens
5795:             loc_nOrig = TratarNulo(cursor_4c_Itens.unitorigs, 0)
5796: 
5797:             IF loc_nOrig = 0
5798:                 loc_nOrig = TratarNulo(cursor_4c_Itens.units, 0)
5799:                 REPLACE unitorigs WITH loc_nOrig IN cursor_4c_Itens
5800:             ENDIF
5801: 
5802:             IF loc_nPerc > 0
5803:                 REPLACE units WITH loc_nOrig - ((ABS(loc_nPerc) * loc_nOrig) / 100) ;
5804:                         IN cursor_4c_Itens
5805:             ELSE
5806:                 REPLACE units WITH loc_nOrig + ((ABS(loc_nPerc) * loc_nOrig) / 100) ;
5807:                         IN cursor_4c_Itens
5808:             ENDIF
5809: 
5810:         CATCH TO loc_oErro
5811:             MsgErro("Erro ao aplicar o desconto percentual:" + CHR(13) + ;
5812:                     loc_oErro.Message + CHR(13) + ;
5813:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5814:                     "Proc: " + loc_oErro.Procedure, "Erro ValidarPDescsLostFocus")
5815:         ENDTRY
5816: 
5817:         THIS.TotalizarLinha(.F.)
5818:         THIS.AtualizarPainelProduto()
5819: 
5820:         RETURN .T.
5821:     ENDPROC
5822: 
5823:     *==========================================================================
5824:     * ObsAbrirPainelClick - Abre o painel flutuante da observacao do item
5825:     * (getObs.Click do legado):
5826:     *
5827:     *   cntObs.Visible = .t. / cntObs.ZOrder(0) / cntObs.getObs.SetFocus
5828:     *
5829:     * O ZOrder(0) eh obrigatorio: o painel eh criado ANTES dos outros
5830:     * controles da pagina e sem ele ficaria POR BAIXO deles.
5831:     *
5832:     * Legado (getObs.When): so abre em INSERIR/ALTERAR e com produto na linha.
5833:     *==========================================================================
5834:     PROCEDURE ObsAbrirPainelClick()
5835:         LOCAL loc_oPag
5836: 
5837:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5838: 
5839:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
5840:             RETURN .F.
5841:         ENDIF
5842: 
5843:         IF !THIS.TemProdutoSelecionado()
5844:             RETURN .F.
5845:         ENDIF
5846: 
5847:         THIS.this_lWhenGetObs = .T.
5848: 
5849:         loc_oPag.cnt_4c_Obs.Visible = .T.
5850:         loc_oPag.cnt_4c_Obs.ZOrder(0)
5851:         loc_oPag.cnt_4c_Obs.obj_4c_GetObs.SetFocus()
5852: 
5853:         RETURN .T.
5854:     ENDPROC
5855: 
5856:     *==========================================================================
5857:     * ObsFecharPainelLostFocus - Fecha o painel flutuante (cntObs.getObs.
5858:     * LostFocus do legado: "cntObs.Visible = .f. / getObs.SetFocus").
5859:     *
5860:     * Reproduz tambem o getObs.Valid do legado, que recusa sair com a
5861:     * observacao em branco quando a operacao a torna obrigatoria
5862:     * (crSigCdOpe.ObsItems = 1).
5863:     *==========================================================================
5864:     PROCEDURE ObsFecharPainelLostFocus()
5865:         LOCAL loc_oPag, loc_cObs
5866: 
5867:         *-- Reentrancia: ja estamos fechando o painel (o SetFocus la embaixo
5868:         *-- redispara este mesmo LostFocus).
5869:         IF THIS.this_lFechandoObs
5870:             RETURN .F.
5871:         ENDIF
5872: 
5873:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5874:         loc_cObs = ALLTRIM(TratarNulo(loc_oPag.cnt_4c_Obs.obj_4c_GetObs.Value, ""))
5875: 
5876:         IF THIS.this_lWhenGetObs AND EMPTY(loc_cObs) AND THIS.this_nObsItems = 1
5877:             MsgAviso(CHR(201) + " Obrigat" + CHR(243) + "rio Preenchimento da " + ;
5878:                      "Observa" + CHR(231) + CHR(227) + "o Para Cada Produto ... ", ;
5879:                      "Observa" + CHR(231) + CHR(227) + "o do Item Obrigat" + ;
5880:                      CHR(243) + "ria")
5881:             RETURN .F.
5882:         ENDIF
5883: 
5884:         THIS.this_lWhenGetObs = .F.
5885: 
5886:         loc_oPag.cnt_4c_Obs.Visible = .F.
5887: 
5888:         *-- Tirar o foco do EditBox do painel dispara o LostFocus dele, que eh
5889:         *-- ESTE metodo: sem a guarda a chamada se aninha indefinidamente.
5890:         IF loc_oPag.obj_4c_GetObs.Visible AND loc_oPag.obj_4c_GetObs.Enabled
5891:             THIS.this_lFechandoObs = .T.
5892:             loc_oPag.obj_4c_GetObs.SetFocus()
5893:             THIS.this_lFechandoObs = .F.
5894:         ENDIF
5895: 
5896:         THIS.RepintarGradeItens()
5897: 
5898:         RETURN .T.
5899:     ENDPROC
5900: 
5901:     *==========================================================================
5902:     * ImgProdsDblClick - Zoom da foto do produto (imgProds.DblClick do legado,
5903:     * cuja dica de uso esta no proprio ToolTipText: "[Duplo Click Para Zoom]").
5904:     * O legado grava a foto em arquivo temporario e abre a tela de zoom; aqui o
5905:     * arquivo ja foi gravado por CarregarImagemProduto e eh ele que vai para o
5906:     * visualizador de imagem do sistema operacional.
5907:     *==========================================================================
5908:     PROCEDURE ImgProdsDblClick()
5909:         LOCAL loc_oImg, loc_cArquivo, loc_oErro
5910: 
5911:         loc_oImg     = THIS.pgf_4c_Paginas.Page1.img_4c_ImgProds
5912:         loc_cArquivo = ALLTRIM(loc_oImg.Picture)
5913: 
5914:         IF EMPTY(loc_cArquivo) OR !FILE(loc_cArquivo)
5915:             MsgAviso("Produto sem imagem cadastrada.", "Imagem do Produto")
5916:             RETURN .F.
5917:         ENDIF
5918: 
5919:         TRY
5920:             RUN /N2 EXPLORER.EXE (loc_cArquivo)
5921:         CATCH TO loc_oErro
5922:             MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a " + ;
5923:                      "imagem do produto.", "Imagem do Produto")
5924:         ENDTRY
5925: 
5926:         RETURN .T.
5927:     ENDPROC
5928: 
5929:     *==========================================================================
5930:     * KeyPress - Teclas de atalho da tela. Legado (SIGOPPRO.KeyPress):
5931:     *
5932:     *   LPARAMETERS nKeyCode, nShiftAltCtrl
5933:     *   If nKeyCode = -4 And ThisForm.btnPBuscas.Enabled    && F5
5934:     *       NoDefault
5935:     *       ThisForm.btnPBuscas.Click()
5936:     *   EndIf
5937:     *
5938:     * KeyPreview = .T. na classe faz o evento chegar aqui antes do controle
5939:     * com foco. -4 eh o codigo do F5 em KeyPress de FORM.
5940:     *==========================================================================
5941:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
5942:         IF par_nKeyCode = -4
5943:             IF THIS.cnt_4c_BotoesAcao.cmd_4c_BtnPBuscas.Enabled
5944:                 NODEFAULT
5945:                 THIS.BtnPBuscasClick()
5946:                 RETURN
5947:             ENDIF
5948:         ENDIF
5949: 
5950:         DODEFAULT(par_nKeyCode, par_nShiftAltCtrl)
5951:     ENDPROC
5952: 
5953:     *==========================================================================
5954:     * HabilitarCampos - Liga/desliga os campos digitaveis conforme o modo.
5955:     *
5956:     * No legado cada campo decide sozinho pelo When(): a maioria retorna .F.
5957:     * (exibicao pura) e os digitaveis retornam
5958:     * "InList(Op_Escolha,'INSERIR','ALTERAR')" combinado com a configuracao da
5959:     * operacao - getDPros exige AltDescs = 1 (ou descricao comecando por "."),
5960:     * getDocs exige EditDocs, getLotes exige Ctrllotes = 2, getVDescs/getPDescs
5961:     * exigem Confes # 1. A pagina Fiscal inteira so eh habilitada quando o
5962:     * usuario pede alteracao de impostos (btnAltImps.Click faz
5963:     * "pgFiscs.Enabled = .t.").
5964:     *
5965:     * Os campos de EXIBICAO ficam de fora: eles nasceram ReadOnly = .T. e
5966:     * continuam assim em qualquer modo, como no legado.
5967:     *
5968:     * PUBLIC: o form pai troca o modo de fora (Op_Escolha vem dele).
5969:     *==========================================================================
5970:     PROCEDURE HabilitarCampos(par_lHabilitar)
5971:         LOCAL loc_lEdita, loc_oPag
5972: 
5973:         loc_lEdita = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, ;
5974:                          INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR"))
5975: 
5976:         *-- Page1 (pgProds) ------------------------------------------------
5977:         loc_oPag = THIS.pgf_4c_Paginas.Page1
5978:         WITH loc_oPag
5979:             *-- getDPros: legado exige AltDescs = 1 OU descricao iniciada
5980:             *-- por "." (produto de descricao livre)
5981:             .txt_4c_DPros.ReadOnly = !(loc_lEdita AND THIS.PodeEditarDescricao())
5982: 
5983:             .txt_4c_Docs.ReadOnly   = !loc_lEdita
5984:             .txt_4c_Lotes.ReadOnly  = !loc_lEdita
5985:             .txt_4c_VDescs.ReadOnly = !loc_lEdita
5986:             .txt_4c_PDescs.ReadOnly = !loc_lEdita
5987:             .txt_4c_MoeVs.ReadOnly  = !loc_lEdita
5988:             .txt_4c_CodCors.ReadOnly = !loc_lEdita
5989:             .txt_4c_CodTams.ReadOnly = !loc_lEdita
5990: 
5991:             .obj_4c_GetObs.ReadOnly              = !loc_lEdita
5992:             .cnt_4c_Obs.obj_4c_GetObs.ReadOnly   = !loc_lEdita
5993: 
5994:             *-- Conferencia por codigo: o legado habilita o campo de
5995:             *-- quantidade apenas com o codigo preenchido (get_qtd.When =
5996:             *-- "Return (Not Empty(Get_prod.Value))")
5997:             .txt_4c__prod.Enabled = loc_lEdita
5998:             .txt_4c__qtd.Enabled  = loc_lEdita AND ;
5999:                                     !EMPTY(ALLTRIM(.txt_4c__prod.Value))
6000: 
6001:             *-- A procura na grade funciona em qualquer modo (getBusca.When =
6002:             *-- "Return .t." no legado)
6003:             .txt_4c_Busca.Enabled = .T.
6004:         ENDWITH
6005: 
6006:         *-- Page3 (pgFiscs): habilitada so em alteracao de impostos --------
6007:         THIS.pgf_4c_Paginas.Page3.Enabled = loc_lEdita AND ;
6008:                                             (THIS.cnt_4c_Botoes.chk_4c_BtnVerImps.Value = 1)
6009: 
6010:         WITH THIS.pgf_4c_Paginas.Page3.cnt_4c_Item

*-- Linhas 6059 a 6136:
6059:     * cursor e APAGARIA o item da linha corrente. Quem limpa a LINHA eh
6060:     * LimparLinhaGrade().
6061:     *==========================================================================
6062:     PROTECTED PROCEDURE LimparCampos()
6063:         LOCAL loc_oPag
6064: 
6065:         loc_oPag = THIS.pgf_4c_Paginas.Page1
6066: 
6067:         WITH loc_oPag
6068:             .txt_4c__prod.Value  = ""
6069:             .txt_4c__qtd.Value   = 0
6070:             .txt_4c_Busca.Value  = ""
6071:             .obj_4c_Opt_Busca.Value = 1
6072:             .cnt_4c_Obs.Visible  = .F.
6073:         ENDWITH
6074: 
6075:         THIS.this_nBarra      = 0
6076:         THIS.this_lProcuraCB  = .F.
6077:         THIS.this_lWhenGetObs = .F.
6078:         THIS.this_cAntCPro    = ""
6079: 
6080:         THIS.LimparPainelProduto()
6081:     ENDPROC
6082: 
6083:     *==========================================================================
6084:     * CarregarLista - FUNIL de (re)carga da lista desta tela. A "lista" do
6085:     * SIGOPPRO eh a grade de itens da movimentacao (fwGrade no legado): nao ha
6086:     * Page1=Lista / Page2=Dados como nos cadastros CRUD.
6087:     *
6088:     * Delega a CarregarDados(), que eh quem consulta o BO, recarrega
6089:     * cursor_4c_Itens por ZAP/APPEND (sem derrubar o binding da grade),
6090:     * entrega a linha de digitacao em INSERIR/ALTERAR, repinta e reajusta os
6091:     * botoes. Depois disso atualiza o painel do item corrente.
6092:     *
6093:     * PUBLIC: o harness de teste e o form pai chamam THIS.CarregarLista() de
6094:     * FORA da classe; PROTECTED aqui estouraria em runtime (regra #3).
6095:     *==========================================================================
6096:     PROCEDURE CarregarLista()
6097:         LOCAL loc_lSucesso
6098: 
6099:         loc_lSucesso = THIS.CarregarDados()
6100: 
6101:         THIS.AtualizarPainelProduto()
6102:         THIS.HabilitarCampos(INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR"))
6103: 
6104:         RETURN loc_lSucesso
6105:     ENDPROC
6106: 
6107:     *==========================================================================
6108:     * FormParaBO - Transfere a LINHA CORRENTE da grade para as properties do
6109:     * sigopproBO, cobrindo TODAS as colunas de SigMvItn que o cursor carrega.
6110:     *
6111:     * O painel de Page1/Page3 eh uma VISTA da linha: os campos digitaveis tem
6112:     * ControlSource sobre cursor_4c_Itens, logo o que o usuario digitou ja esta
6113:     * no cursor quando este metodo roda - ler do cursor eh ler da tela, e eh
6114:     * tambem o que o legado faz (ele grava o cursor inteiro com TABLEUPDATE).
6115:     *
6116:     * Os campos de EXIBICAO (preco atual, saldo, resta, referencia, grupo de
6117:     * venda, peso medio, classificacao fiscal) NAO entram: nao sao coluna de
6118:     * SigMvItn - vem de SigCdPro/SigMvEst/SigCdClf e seriam gravados em
6119:     * coluna que nao existe.
6120:     *
6121:     * Devolve .T. quando havia linha para transferir.
6122:     *==========================================================================
6123:     PROTECTED FUNCTION FormParaBO()
6124:         LOCAL loc_lOk, loc_oBO, loc_oErro
6125: 
6126:         loc_lOk = .F.
6127: 
6128:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
6129:             RETURN .F.
6130:         ENDIF
6131: 
6132:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
6133:             RETURN .F.
6134:         ENDIF
6135: 
6136:         loc_oBO = THIS.this_oBusinessObject

*-- Linhas 6170 a 6231:
6170:             MsgErro("Erro ao transferir o item para o objeto de neg" + CHR(243) + ;
6171:                     "cio:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
6172:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
6173:                     "Proc: " + loc_oErro.Procedure, "Erro FormParaBO")
6174:         ENDTRY
6175: 
6176:         RETURN loc_lOk
6177:     ENDFUNC
6178: 
6179:     *==========================================================================
6180:     * BOParaForm - Caminho inverso de FormParaBO: leva as properties do
6181:     * sigopproBO para a linha da grade e, por consequencia, para o painel de
6182:     * Page1/Page3 (que esta ligado ao cursor por ControlSource).
6183:     *
6184:     * Posiciona PRIMEIRO na linha do item que esta no BO (citens): sem isso a
6185:     * gravacao cairia na linha errada e sobrescreveria outro item - o cursor
6186:     * nao acompanha o BO sozinho.
6187:     *
6188:     * Fecha atualizando o painel de exibicao e repintando a grade: popular o
6189:     * cursor NAO repinta a grade (regra #21).
6190:     *==========================================================================
6191:     PROTECTED PROCEDURE BOParaForm()
6192:         LOCAL loc_oBO, loc_lOk, loc_oErro
6193: 
6194:         loc_lOk = .F.
6195: 
6196:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
6197:             RETURN .F.
6198:         ENDIF
6199: 
6200:         IF !USED("cursor_4c_Itens")
6201:             RETURN .F.
6202:         ENDIF
6203: 
6204:         loc_oBO = THIS.this_oBusinessObject
6205: 
6206:         TRY
6207:             SELECT cursor_4c_Itens
6208: 
6209:             *-- Casa a linha pelo numero do item; sem numero, usa a corrente.
6210:             IF loc_oBO.this_nCitens <> 0
6211:                 LOCATE FOR cursor_4c_Itens.citens = loc_oBO.this_nCitens
6212:                 IF !FOUND()
6213:                     GO TOP
6214:                 ENDIF
6215:             ENDIF
6216: 
6217:             IF !EOF("cursor_4c_Itens")
6218:                 REPLACE cidchaves  WITH loc_oBO.this_cCidchaves, ;
6219:                         citens     WITH loc_oBO.this_nCitens, ;
6220:                         citem2     WITH loc_oBO.this_nCitem2, ;
6221:                         cpros      WITH loc_oBO.this_cCpros, ;
6222:                         cpro2s     WITH loc_oBO.this_cCpro2s, ;
6223:                         dpros      WITH loc_oBO.this_cDpros, ;
6224:                         codbarras  WITH loc_oBO.this_nCodbarras, ;
6225:                         barraref   WITH loc_oBO.this_nBarraref, ;
6226:                         cunis      WITH loc_oBO.this_cCunis, ;
6227:                         cunips     WITH loc_oBO.this_cCunips, ;
6228:                         fators     WITH loc_oBO.this_nFators, ;
6229:                         opers      WITH loc_oBO.this_cOpers IN cursor_4c_Itens
6230: 
6231:                 REPLACE qtds       WITH loc_oBO.this_nQtds, ;

*-- Linhas 6363 a 6402:
6363:             MsgErro("Erro ao trazer o item do objeto de neg" + CHR(243) + "cio:" + ;
6364:                     CHR(13) + loc_oErro.Message + CHR(13) + ;
6365:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
6366:                     "Proc: " + loc_oErro.Procedure, "Erro BOParaForm")
6367:         ENDTRY
6368: 
6369:         IF loc_lOk
6370:             *-- Popular o cursor NAO repinta a grade nem os campos ligados a
6371:             *-- ele por ControlSource (regra #21): o Refresh das paginas eh o
6372:             *-- que faz o painel mostrar o que acabou de ser gravado na linha.
6373:             THIS.RepintarGradeItens()
6374:             THIS.pgf_4c_Paginas.Page1.Refresh()
6375:             THIS.pgf_4c_Paginas.Page3.Refresh()
6376:             THIS.AtualizarPainelProduto()
6377:         ENDIF
6378: 
6379:         RETURN loc_lOk
6380:     ENDPROC
6381: 
6382:     *==========================================================================
6383:     * BtnCancelarClick - Caminho de ESC/Cancelar da tela.
6384:     *
6385:     * No SCX legado o botao de saida eh OK.btnSair, Caption "Retornar", com
6386:     * Command1.Cancel = .T. - isto eh: Encerrar e Cancelar sao o MESMO botao,
6387:     * e ESC cai nele. Nao existe no legado um "Cancelar" que descarte
6388:     * alteracoes (quem grava ou descarta a movimentacao eh o form PAI, na
6389:     * confirmacao da operacao), entao inventar um aqui mudaria o
6390:     * comportamento da tela.
6391:     *
6392:     * Por isso este handler delega ao funil de saida, que valida os itens,
6393:     * reabilita o form pai e fecha.
6394:     *
6395:     * PUBLIC: eh o nome que o harness de teste chama de FORA da classe
6396:     * (regra #3).
6397:     *==========================================================================
6398:     PROCEDURE BtnCancelarClick()
6399:         RETURN THIS.BtnEncerrarClick()
6400:     ENDPROC
6401: 
6402: ENDDEFINE


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

