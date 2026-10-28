# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=4 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCfl.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1979 linhas total):

*-- Linhas 11 a 31:
11: * diretamente de outro form/tela (sem form pai no acervo desta task).
12: *
13: * Fase 3/8 - Estrutura base: cabecalho + shape decorativo + containers
14: *            vazios (cnt_4c_Dadoschq/cnt_4c__inserir, sem filhos ainda) +
15: *            botao Encerrar (cmg_4c_Commandgroup1).
16: * Fase 4/8 - Grade de historico (grd_4c_Dados) + CommandGroup de acoes
17: *            (cmg_4c_CmdApagaitem: Incluir/Alterar/Apagar/Listar) +
18: *            carga do cursor da grade (CarregarLista/RepintarGrade).
19: * Fase 5/8 - Cabecalho do cheque: Emissor (txt_4c_Conta/txt_4c_DConta) +
20: *            filhos de cnt_4c_Dadoschq (Banco/Agencia/Conta/N.Cheque).
21: * Fase 6/8 - Filhos de cnt_4c__inserir (Data/Hora + Observacao) + legenda
22: *            do historico automatico (lbl_4c_Label4/shp_4c_Shape1) +
23: *            eventos de DADOS do legado: When/Valid da celula de data da
24: *            grade (classe TextBoxCelulaFollowupCfl_4c instalada na
25: *            Column1) e LostFocus de gravacao do painel de inclusao/
26: *            alteracao (GetHist.LostFocus legado). O legado NAO tem lookup
27: *            algum (zero fwbuscaext/fwBuscaSel/sigacess no dump) - nao ha
28: *            picker a reproduzir (PILAR 1: "NUNCA inventar tabelas de
29: *            lookup que nao existem no original").
30: * Fase 7/8 - Eventos principais: reposicionamento/visibilidade dos botoes de
31: *            acao por fChecaAcesso (legado: With ThisForm.cmdApagaItem no

*-- Linhas 102 a 373:
102:     *==========================================================================
103:     * Init - par_cConta/par_dData chegam do caller (legado: LParameters pConta,
104:     * pData). Guarda par_cConta ANTES de DODEFAULT() - FormBase.Init() ja
105:     * encadeia para InicializarForm(), que precisa de this_cConta pronto para
106:     * as fases seguintes (carga do cheque/historico).
107:     *==========================================================================
108:     PROCEDURE Init(par_cConta, par_dData)
109:         THIS.this_cConta = IIF(VARTYPE(par_cConta) = "C", par_cConta, "")
110:         RETURN DODEFAULT()
111:     ENDPROC
112: 
113:     *==========================================================================
114:     * InicializarForm - Instancia o BO e monta a estrutura visual base
115:     *==========================================================================
116:     PROTECTED PROCEDURE InicializarForm()
117:         LOCAL loc_lSucesso, loc_oErro
118:         loc_lSucesso = .F.
119: 
120:         TRY
121:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
122: 
123:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpCflBO")
124:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
125: 
126:                 THIS.ConfigurarPageFrame()
127: 
128:                 *-- Sincronizar caption nos labels do cabecalho
129:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
130:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
131: 
132:                 THIS.TornarControlesVisiveis(THIS)
133: 
134:                 *-- Carga do historico do cheque (legado: Requery('CrSigCheh')
135:                 *-- no proprio Init) + cabecalho fixo do cheque (legado:
136:                 *-- Cursorquery SigChe/SigCdCli, logo depois do Requery). Em
137:                 *-- validacao de UI / modo teste nao ha conexao SQL - a grade
138:                 *-- e o cabecalho ficam vazios, sem impedir a abertura.
139:                 IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
140:                    (TYPE("gb_4c_ModoTeste")   != "L" OR !gb_4c_ModoTeste)
141:                     THIS.CarregarLista()
142:                     THIS.CarregarCabecalhoCheque()
143:                 ENDIF
144: 
145:                 loc_lSucesso = .T.
146:             ELSE
147:                 MsgErro("Falha ao criar SigOpCflBO.", "Erro em InicializarForm")
148:             ENDIF
149:         CATCH TO loc_oErro
150:             MsgErro(loc_oErro.Message + CHR(13) + ;
151:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
152:                     "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
153:         ENDTRY
154: 
155:         RETURN loc_lSucesso
156:     ENDPROC
157: 
158:     *==========================================================================
159:     * ConfigurarPageFrame - Orquestrador de montagem visual. SigOpCfl.SCX e
160:     * form PLANO sem PageFrame (cntSombra + dados do cheque + grade +
161:     * painel flutuante + botoes direto no form). Mantido o nome
162:     * "ConfigurarPageFrame" so para preservar o papel arquitetural de ponto
163:     * de entrada da montagem visual (mesmo padrao de FormSIGOPCFE/FormFop),
164:     * delegando para helpers dedicados.
165:     * Fase 3: cabecalho + containers base (vazios) + botao de saida.
166:     * Fase 4: grade de historico + CommandGroup de acoes + carga da grade.
167:     * Fase 5/6: filhos dos containers base.
168:     *==========================================================================
169:     PROTECTED PROCEDURE ConfigurarPageFrame()
170:         THIS.ConfigurarCabecalho()
171:         THIS.ConfigurarContainersBase()
172:         THIS.ConfigurarDadosCheque()
173:         THIS.ConfigurarPainelInserir()
174:         THIS.ConfigurarGrid()
175:         THIS.ConfigurarLegendaAutomatico()
176:         THIS.ConfigurarAcoes()
177:         THIS.ConfigurarSaida()
178:     ENDPROC
179: 
180:     *==========================================================================
181:     * ConfigurarCabecalho - cnt_4c_Sombra (cntSombra do legado) + os dois
182:     * labels sobrepostos (sombra preta + titulo branco - padrao canonico do
183:     * projeto, regra #11/CLAUDE.md). Width acompanha THIS.Width (legado:
184:     * cntSombra.Width = SIGOPCFL.Width, ou seja, igual a largura do form).
185:     *==========================================================================
186:     PROTECTED PROCEDURE ConfigurarCabecalho()
187:         LOCAL loc_oErro
188:         TRY
189:             THIS.AddObject("cnt_4c_Sombra", "Container")
190:             WITH THIS.cnt_4c_Sombra
191:                 .Top         = 0
192:                 .Left        = 0
193:                 .Width       = THIS.Width
194:                 .Height      = 80
195:                 .BackStyle   = 1
196:                 .BackColor   = RGB(100, 100, 100)
197:                 .BorderWidth = 0
198:                 .Visible     = .T.
199:             ENDWITH
200: 
201:             THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
202:             WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
203:                 .FontBold      = .T.
204:                 .FontName      = "Tahoma"
205:                 .FontSize      = 16
206:                 .FontUnderline = .F.
207:                 .WordWrap      = .T.
208:                 .Alignment     = 0
209:                 .BackStyle     = 0
210:                 .AutoSize      = .F.
211:                 .Caption       = THIS.Caption
212:                 .Height        = 40
213:                 .Left          = 10
214:                 .Top           = 15
215:                 .Width         = THIS.Width - 370
216:                 .ForeColor     = RGB(0, 0, 0)
217:                 .Visible       = .T.
218:             ENDWITH
219: 
220:             THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
221:             WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
222:                 .FontBold      = .T.
223:                 .FontName      = "Tahoma"
224:                 .FontSize      = 16
225:                 .FontUnderline = .F.
226:                 .WordWrap      = .T.
227:                 .Alignment     = 0
228:                 .BackStyle     = 0
229:                 .AutoSize      = .F.
230:                 .Caption       = THIS.Caption
231:                 .Height        = 46
232:                 .Left          = 10
233:                 .Top           = 18
234:                 .Width         = THIS.Width - 370
235:                 .ForeColor     = RGB(255, 255, 255)
236:                 .ToolTipText   = "T" + CHR(237) + "tulo"
237:                 .Visible       = .T.
238:             ENDWITH
239:         CATCH TO loc_oErro
240:             MsgErro(loc_oErro.Message + CHR(13) + ;
241:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
242:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
243:         ENDTRY
244:     ENDPROC
245: 
246:     *==========================================================================
247:     * ConfigurarContainersBase - Cria, vazios, o shape decorativo e os dois
248:     * containers principais do corpo do form. Posicoes EXATAS do dump
249:     * (SigOpCfl.SCX) - a area de dados NAO escala com a largura nova do
250:     * form (1000px), so o cabecalho/botoes usam a largura nova, mesmo
251:     * padrao do FormSIGOPCFE (ConfigurarGrade).
252:     *   shp_4c_Shape2    (Shape2)     Top=110/Left=62/W=675/H=403 - moldura
253:     *                    da area de dados/grade.
254:     *   cnt_4c_Dadoschq  (cntDadoschq) Top=142/Left=66/W=665/H=34 - filhos
255:     *                    (Banco/Agencia/Conta/N.Cheque) na Fase 5.
256:     *   cnt_4c__inserir  (cnt_inserir) Top=284/Left=78/W=640/H=82,
257:     *                    Visible=.F. - painel flutuante de Incluir/Alterar
258:     *                    ocorrencia, filhos (Data/Hora+Observacao) na
259:     *                    Fase 6, toggle de Visible na Fase 7/8.
260:     *==========================================================================
261:     PROTECTED PROCEDURE ConfigurarContainersBase()
262:         LOCAL loc_oErro
263:         TRY
264:             THIS.AddObject("shp_4c_Shape2", "Shape")
265:             WITH THIS.shp_4c_Shape2
266:                 .Top         = 110
267:                 .Left        = 62
268:                 .Width       = 675
269:                 .Height      = 403
270:                 .BackStyle   = 1
271:                 .BackColor   = RGB(255, 255, 255)
272:                 .BorderColor = RGB(90, 90, 90)
273:                 .Visible     = .T.
274:             ENDWITH
275: 
276:             THIS.AddObject("cnt_4c_Dadoschq", "Container")
277:             WITH THIS.cnt_4c_Dadoschq
278:                 .Top           = 142
279:                 .Left          = 66
280:                 .Width         = 665
281:                 .Height        = 34
282:                 .BorderWidth   = 1
283:                 .SpecialEffect = 0
284:                 .BackColor     = RGB(255, 255, 255)
285:                 .BorderColor   = RGB(136, 189, 188)
286:                 .Visible       = .T.
287:             ENDWITH
288: 
289:             *-- cnt_inserir legado: Visible=.F. - so aparece quando o usuario
290:             *-- clica Incluir/Alterar (regra #40: nasce oculto, toggle no
291:             *-- funil de eventos, Fase 7/8).
292:             THIS.AddObject("cnt_4c__inserir", "Container")
293:             WITH THIS.cnt_4c__inserir
294:                 .Top           = 284
295:                 .Left          = 78
296:                 .Width         = 640
297:                 .Height        = 82
298:                 .BackStyle     = 1
299:                 .BorderWidth   = 1
300:                 .SpecialEffect = 0
301:                 .BackColor     = RGB(255, 255, 255)
302:                 .BorderColor   = RGB(136, 189, 188)
303:                 .Visible       = .F.
304:             ENDWITH
305:         CATCH TO loc_oErro
306:             MsgErro(loc_oErro.Message + CHR(13) + ;
307:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
308:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainersBase")
309:         ENDTRY
310:     ENDPROC
311: 
312:     *==========================================================================
313:     * ConfigurarDadosCheque - Cabecalho do cheque consultado. Dois blocos,
314:     * posicoes EXATAS do dump (SigOpCfl.SCX) - area de dados NAO escala com
315:     * a largura nova do form (mesmo padrao de ConfigurarContainersBase):
316:     *   - Emissor (direto no form): lbl_4c_Label1 ("Emissor :") +
317:     *     txt_4c_Conta (getConta, Iclis) + txt_4c_DConta (getDConta, Rclis).
318:     *   - Filhos de cnt_4c_Dadoschq (criado em ConfigurarContainersBase):
319:     *     Banco (lbl_4c_Label13/txt_4c_Bco), Agencia (lbl_4c_Label9/
320:     *     txt_4c_Agc), Conta (lbl_4c_Label1/txt_4c_Cta) e N.Cheque
321:     *     (lbl_4c_Label2/txt_4c_Nch).
322:     * Todos os TextBox sao SOMENTE LEITURA (legado: Enabled=.F. em
323:     * getConta/getDConta, ReadOnly=.T. em Get_Agc/Get_bco/Get_Cta/Get_Nch) -
324:     * exibem dados do cheque, nunca editados pelo usuario. MaxLength vem da
325:     * largura das colunas no schema (regra #19), NUNCA do Width em pixels:
326:     * SigCdCli.iclis char(10)/rclis char(50); SigChe.bancos char(3)/
327:     * agencias char(4)/ncontas char(10)/ncheques char(6). Labels sem
328:     * Width/Alignment no dump (classe say pura) usam .Alignment = 0 +
329:     * .Width calculada para caber o texto (regra #23) e ForeColor
330:     * RGB(90,90,90) - o default da classe say sem ForeColor declarado
331:     * (regra #12). Populados em CarregarCabecalhoCheque().
332:     *==========================================================================
333:     PROTECTED PROCEDURE ConfigurarDadosCheque()
334:         LOCAL loc_oErro
335:         TRY
336:             *-- Emissor (direto no form - legado: Say1/getConta/getDConta)
337:             THIS.AddObject("lbl_4c_Label1", "Label")
338:             WITH THIS.lbl_4c_Label1
339:                 .FontName  = "Tahoma"
340:                 .FontSize  = 8
341:                 .Alignment = 0
342:                 .BackStyle = 0
343:                 .AutoSize  = .F.
344:                 .Caption   = "Emissor : "
345:                 .Left      = 81
346:                 .Top       = 122
347:                 .Width     = 45
348:                 .Height    = 17
349:                 .ForeColor = RGB(90, 90, 90)
350:                 .Visible   = .T.
351:             ENDWITH
352: 
353:             THIS.AddObject("txt_4c_Conta", "TextBox")
354:             WITH THIS.txt_4c_Conta
355:                 .FontName          = "Tahoma"
356:                 .FontSize          = 8
357:                 .Left              = 128
358:                 .Top               = 118
359:                 .Width             = 80
360:                 .Height            = 23
361:                 .MaxLength         = 10
362:                 .Enabled           = .F.
363:                 .ForeColor         = RGB(0, 0, 0)
364:                 .DisabledBackColor = RGB(255, 255, 255)
365:                 .DisabledForeColor = RGB(0, 0, 0)
366:                 .Value             = ""
367:                 .Visible           = .T.
368:             ENDWITH
369: 
370:             THIS.AddObject("txt_4c_DConta", "TextBox")
371:             WITH THIS.txt_4c_DConta
372:                 .FontName          = "Tahoma"
373:                 .FontSize          = 8

*-- Linhas 531 a 671:
531:         CATCH TO loc_oErro
532:             MsgErro(loc_oErro.Message + CHR(13) + ;
533:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
534:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarDadosCheque")
535:         ENDTRY
536:     ENDPROC
537: 
538:     *==========================================================================
539:     * CarregarCabecalhoCheque - Carrega os dados FIXOS do cheque consultado
540:     * (Emissor + Banco/Agencia/Conta/N.Cheque). Chamado UMA UNICA VEZ a
541:     * partir de InicializarForm - o cheque consultado nao muda durante a
542:     * vida do form (so o historico de followup, na grade, eh recarregado
543:     * por CarregarLista). Legado (SIGOPCFL.Init):
544:     *     =ThisForm.Podatamgr.Cursorquery('SigChe','CrTmpChe','Nums',lcNum)
545:     *     =ThisForm.Podatamgr.Cursorquery('SigCdCli','CrTmpCli','Iclis',CrTmpChe.Iclis)
546:     *     ThisForm.GetConta.Value  = CrTmpCli.Iclis
547:     *     ThisForm.GetdConta.Value = CrTmpCli.Rclis
548:     *     Thisform.CntDadoschq.Get_bco.Value = CrTmpChe.Bancos
549:     *     Thisform.CntDadoschq.Get_agc.Value = CrTmpChe.agencias
550:     *     Thisform.CntDadoschq.Get_cta.Value = CrTmpChe.nContas
551:     *     Thisform.CntDadoschq.Get_Nch.Value = CrTmpChe.nCheques
552:     * Sem conexao (validacao de UI / modo teste) os campos ficam vazios,
553:     * sem impedir a abertura do form (mesma guarda de CarregarLista).
554:     *==========================================================================
555:     PROCEDURE CarregarCabecalhoCheque()
556:         LOCAL loc_oBO, loc_oErro
557: 
558:         TRY
559:             loc_oBO = THIS.this_oBusinessObject
560: 
561:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND ;
562:                VARTYPE(loc_oBO) = "O" AND !EMPTY(ALLTRIM(THIS.this_cConta))
563:                 *-- As duas consultas moram no BO (PILAR 3). O resultado fica
564:                 *-- nas propriedades auxiliares dele e eh ExibirCabecalhoCheque
565:                 *-- que as leva para a tela.
566:                 IF loc_oBO.CarregarCabecalho(THIS.this_cConta)
567:                     THIS.ExibirCabecalhoCheque()
568:                 ENDIF
569:             ENDIF
570:         CATCH TO loc_oErro
571:             MsgErro(loc_oErro.Message + CHR(13) + ;
572:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
573:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarCabecalhoCheque")
574:         ENDTRY
575:     ENDPROC
576: 
577:     *==========================================================================
578:     * ExibirCabecalhoCheque - Leva as propriedades auxiliares do BO (dados
579:     * FIXOS do cheque, carregados por SigOpCflBO.CarregarCabecalho) para os
580:     * seis controles somente-leitura do topo. Espelha, uma a uma, as
581:     * atribuicoes do Init legado:
582:     *     ThisForm.GetConta.Value  = CrTmpCli.Iclis
583:     *     ThisForm.GetdConta.Value = CrTmpCli.Rclis
584:     *     Thisform.CntDadoschq.Get_bco.Value = CrTmpChe.Bancos
585:     *     Thisform.CntDadoschq.Get_agc.Value = CrTmpChe.agencias
586:     *     Thisform.CntDadoschq.Get_cta.Value = CrTmpChe.nContas
587:     *     Thisform.CntDadoschq.Get_Nch.Value = CrTmpChe.nCheques
588:     * NAO eh o BOParaForm: este cabecalho nao eh a entidade do BO (SigCheh) e
589:     * nao muda durante a vida do form - eh carregado UMA vez, de SigChe/
590:     * SigCdCli. BOParaForm cuida do registro de followup (o painel).
591:     *==========================================================================
592:     PROCEDURE ExibirCabecalhoCheque()
593:         LOCAL loc_oBO, loc_oCnt
594: 
595:         loc_oBO = THIS.this_oBusinessObject
596: 
597:         IF VARTYPE(loc_oBO) = "O"
598:             THIS.txt_4c_Conta.Value  = loc_oBO.this_cIclis
599:             THIS.txt_4c_DConta.Value = loc_oBO.this_cRclis
600: 
601:             loc_oCnt = THIS.cnt_4c_Dadoschq
602:             loc_oCnt.txt_4c_Bco.Value = loc_oBO.this_cBancos
603:             loc_oCnt.txt_4c_Agc.Value = loc_oBO.this_cAgencias
604:             loc_oCnt.txt_4c_Cta.Value = loc_oBO.this_cNContas
605:             loc_oCnt.txt_4c_Nch.Value = loc_oBO.this_cNCheques
606:         ENDIF
607:     ENDPROC
608: 
609:     *==========================================================================
610:     * ConfigurarPainelInserir - Filhos de cnt_4c__inserir (cnt_inserir do
611:     * legado): painel flutuante de Incluir/Alterar ocorrencia de followup,
612:     * com os dois campos que o legado le em GetHist.LostFocus (This.Parent.
613:     * GetData.Value / This.Parent.GetHist.Value). Posicoes EXATAS do dump
614:     * (SigOpCfl.SCX), relativas ao container (regra #28 - Left/Top sao
615:     * relativos ao pai, nao ao form).
616:     *   lbl_4c_Label13 ("Data / Hora :") + txt_4c_Data (GetData)
617:     *   lbl_4c_Label19 ("Observa" + CHR(231) + CHR(227) + "o :") + txt_4c_Hist (GetHist)
618:     * txt_4c_Data guarda DATETIME (legado: .Value = DateTime() no Incluir,
619:     * CrSigCheh.Datas no Alterar - Value inicial {} igual ao this_dDatas
620:     * do BO). txt_4c_Hist eh CHARACTER (SigCheh.hists char(76) - MaxLength
621:     * = 76, regra #19/CLAUDE.md; o dump legado nao declara MaxLength
622:     * nesse controle porque GetHist nao tem ControlSource fixo, mas o
623:     * destino SQL eh char(76), igual ao LEFT(...,76) de
624:     * SigOpCflBO.Inserir/Atualizar). Format = "K!"/"K" transcritos
625:     * literalmente do dump (regra #49/CLAUDE.md).
626:     * O LostFocus de txt_4c_Hist (GetHist.LostFocus legado) eh ligado aqui
627:     * por BINDEVENT - eh ELE que grava o followup. O toggle de Visible do
628:     * container e o preenchimento inicial dos dois campos (Incluir/Alterar)
629:     * ficam para a Fase 8 (eventos dos botoes de acao).
630:     *==========================================================================
631:     PROTECTED PROCEDURE ConfigurarPainelInserir()
632:         LOCAL loc_oErro
633:         TRY
634:             THIS.cnt_4c__inserir.AddObject("lbl_4c_Label13", "Label")
635:             WITH THIS.cnt_4c__inserir.lbl_4c_Label13
636:                 .FontName  = "Tahoma"
637:                 .FontSize  = 8
638:                 .Alignment = 0
639:                 .BackStyle = 0
640:                 .AutoSize  = .F.
641:                 .Caption   = "Data / Hora :"
642:                 .TabIndex  = 44
643:                 .Left      = 21
644:                 .Top       = 19
645:                 .Width     = 64
646:                 .Height    = 17
647:                 .ForeColor = RGB(90, 90, 90)
648:                 .Visible   = .T.
649:             ENDWITH
650: 
651:             THIS.cnt_4c__inserir.AddObject("txt_4c_Data", "TextBox")
652:             WITH THIS.cnt_4c__inserir.txt_4c_Data
653:                 .FontName  = "Tahoma"
654:                 .FontSize  = 8
655:                 .Left      = 88
656:                 .Top       = 15
657:                 .Width     = 150
658:                 .Height    = 23
659:                 .MaxLength = 20
660:                 .Format    = "K!"
661:                 .TabIndex  = 20
662:                 .ForeColor = RGB(0, 0, 0)
663:                 .Value     = {}
664:                 .Visible   = .T.
665:             ENDWITH
666: 
667:             THIS.cnt_4c__inserir.AddObject("lbl_4c_Label19", "Label")
668:             WITH THIS.cnt_4c__inserir.lbl_4c_Label19
669:                 .FontName  = "Tahoma"
670:                 .FontSize  = 8
671:                 .Alignment = 0

*-- Linhas 702 a 775:
702:             *-- eh o evento do legado, nao um lookup travestido (regra #47: o
703:             *-- defeito seria ligar em "KeyPress" sem testar a tecla). Handler
704:             *-- PUBLIC e SEM parametro: LostFocus nao passa nenhum (regra #3).
705:             BINDEVENT(THIS.cnt_4c__inserir.txt_4c_Hist, "LostFocus", ;
706:                       THIS, "HistoricoLostFocus")
707:         CATCH TO loc_oErro
708:             MsgErro(loc_oErro.Message + CHR(13) + ;
709:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
710:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPainelInserir")
711:         ENDTRY
712:     ENDPROC
713: 
714:     *==========================================================================
715:     * ConfigurarGrid - grd_4c_Dados (gridFollowup do legado): grade de
716:     * historico de followup do cheque. Posicao EXATA do dump (dentro da
717:     * moldura shp_4c_Shape2) - area de dados NAO escala com a largura nova
718:     * do form (mesmo padrao de ConfigurarContainersBase).
719:     * Liga a grade a um cursor PLACEHOLDER (cursor_4c_Dados) criado aqui -
720:     * regra #41/CLAUDE.md: Column.ControlSource exige o alias JA existir,
721:     * senao o Init inteiro estoura "Alias is not found". A ORDEM dos campos
722:     * eh IDENTICA a SigOpCflBO.CarregarDoCursor (cidchaves, nums, datas,
723:     * emps, hists, numlotes, autos) - a Fase 7/8 popula este mesmo cursor
724:     * via SQLEXEC em cursor temporario + ZAP + APPEND FROM DBF().
725:     * Bloco de configuracao runtime (ColumnCount/RecordSource/ControlSource/
726:     * Width/Header.Caption, nesta ordem) e o DynamicForeColor (verde para
727:     * historico automatico) transcritos literalmente do Init legado
728:     * (With ThisForm.gridFollowup ... SetAll('DynamicForeColor', ...)).
729: * A celula "Data / Hora" (Column1) recebe a classe
730: * TextBoxCelulaFollowupCfl_4c via AddObject + CurrentControl + Sparse =
731: * .F. (regra #18): eh ela que carrega o When e o Valid que o legado tem em
732: * gridFollowup.Column1.Text1 - BINDEVENT em evento de celula de Grid nao eh
733: * confiavel (regra #46).
734:     *==========================================================================
735:     PROTECTED PROCEDURE ConfigurarGrid()
736:         LOCAL loc_oErro
737:         TRY
738:             IF USED("cursor_4c_Dados")
739:                 USE IN cursor_4c_Dados
740:             ENDIF
741:             SET NULL ON
742:             CREATE CURSOR cursor_4c_Dados ;
743:                 (cidchaves C(20), nums C(8), datas T, emps C(3), hists C(76), numlotes N(8,0), autos L)
744:             SET NULL OFF
745: 
746:             THIS.AddObject("grd_4c_Dados", "Grid")
747:             WITH THIS.grd_4c_Dados
748:                 .Top           = 177
749:                 .Left          = 67
750:                 .Width         = 667
751:                 .Height        = 312
752:                 .ReadOnly      = .T.
753:                 .DeleteMark    = .F.
754:                 .RecordMark    = .F.
755:                 .ScrollBars    = 2
756:                 .GridLineColor = RGB(238, 238, 238)
757:                 .TabIndex      = 1
758:                 .BackColor     = RGB(255, 255, 255)
759:                 .Visible       = .T.
760: 
761:                 .ColumnCount  = 2
762:                 .RecordSource = "cursor_4c_Dados"
763: 
764:                 .Column1.ControlSource = "cursor_4c_Dados.datas"
765:                 .Column2.ControlSource = "cursor_4c_Dados.hists"
766: 
767:                 .Column1.Width = 144
768:                 .Column2.Width = 490
769: 
770:                 .Column1.Movable   = .F.
771:                 .Column2.Movable   = .F.
772:                 .Column1.Resizable = .F.
773:                 .Column2.Resizable = .F.
774:                 .Column1.ReadOnly  = .T.
775:                 .Column2.ReadOnly  = .T.

*-- Linhas 804 a 1144:
804:                     "IIF(cursor_4c_Dados.autos, RGB(0,128,64), RGB(0,0,0))", "Column")
805: 
806:                 *-- Celula "Data / Hora" (Column1): o legado tem When e Valid
807:                 *-- no gridFollowup.Column1.Text1. BINDEVENT em evento de
808:                 *-- celula de Grid nao eh confiavel (regra #46), entao a celula
809:                 *-- eh uma classe com os eventos EMBUTIDOS
810:                 *-- (TextBoxCelulaFollowupCfl_4c, classes\TextBoxGridLookup.prg),
811:                 *-- instalada com AddObject + CurrentControl + Sparse = .F.
812:                 *-- (regra #18 - sem CurrentControl a coluna continua
813:                 *-- desenhando o Text1 dela e os eventos nunca rodam; sem
814:                 *-- Sparse = .F. o controle so aparece na linha ativa).
815:                 .Column1.AddObject("txt_4c_CelulaData", "TextBoxCelulaFollowupCfl_4c")
816:                 .Column1.CurrentControl = "txt_4c_CelulaData"
817:                 .Column1.Sparse         = .F.
818:             ENDWITH
819: 
820:             *-- Propriedades da celula por caminho EXPLICITO, nao com WITH
821:             *-- aninhado logo apos o AddObject: dentro de um WITH externo o
822:             *-- "WITH .filho" relativo falha em SILENCIO no VFP9 e as
823:             *-- propriedades nao sao aplicadas (Erro47/Erro49). FontName/
824:             *-- FontSize/Margin/BorderStyle/Alignment/ReadOnly ja sao default
825:             *-- da classe; aqui ficam as cores e o Visible.
826:             THIS.grd_4c_Dados.Column1.txt_4c_CelulaData.ForeColor = RGB(0, 0, 0)
827:             THIS.grd_4c_Dados.Column1.txt_4c_CelulaData.BackColor = RGB(255, 255, 255)
828:             THIS.grd_4c_Dados.Column1.txt_4c_CelulaData.Visible   = .T.
829: 
830:             WITH THIS.grd_4c_Dados
831: 
832:                 *-- Column.ReadOnly reafirmado DEPOIS do Grid.ReadOnly e da
833:                 *-- troca de CurrentControl (regra #18): o ReadOnly do grid
834:                 *-- propaga para as colunas e a grade do legado eh inteiramente
835:                 *-- somente-leitura (dump: gridFollowup.ReadOnly = .T.,
836:                 *-- Column1/Column2.ReadOnly = .T., os dois Text1.ReadOnly =
837:                 *-- .T.). O When existe so para gatear o FOCO da celula.
838:                 .Column1.ReadOnly = .T.
839:                 .Column2.ReadOnly = .T.
840:             ENDWITH
841:         CATCH TO loc_oErro
842:             MsgErro(loc_oErro.Message + CHR(13) + ;
843:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
844:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
845:         ENDTRY
846:     ENDPROC
847: 
848:     *==========================================================================
849:     * ConfigurarLegendaAutomatico - Legenda do historico automatico (Say4/
850:     * Shape1 do legado): quadrado verde + "Lancamento Automatico", com a
851:     * MESMA cor (RGB(0,128,64)) usada pelo DynamicForeColor da grade
852:     * (ConfigurarGrid) - o usuario associa a cor do texto na grade a esta
853:     * legenda, por isso o metodo vem DEPOIS de ConfigurarGrid. Posicoes
854:     * EXATAS do dump - direto no form, NAO escalam com a largura nova do
855:     * form (mesmo padrao de ConfigurarContainersBase/ConfigurarDadosCheque).
856:     * Say4 eh classe "say" mas DECLARA Width=117 no SCX - nao eh o caso
857:     * generico da regra #23 (label sem Width/Alignment no dump); aqui o
858:     * Width foi desenhado explicitamente no Form Designer, logo eh
859:     * transcrito literal com AutoSize = .F. (regra #23: AutoSize=.T. eh
860:     * no-op em Label criado por AddObject - a Width ficaria no default).
861:     *==========================================================================
862:     PROTECTED PROCEDURE ConfigurarLegendaAutomatico()
863:         LOCAL loc_oErro
864:         TRY
865:             THIS.AddObject("shp_4c_Shape1", "Shape")
866:             WITH THIS.shp_4c_Shape1
867:                 .Top           = 495
868:                 .Left          = 333
869:                 .Width         = 14
870:                 .Height        = 14
871:                 .BackStyle     = 1
872:                 .SpecialEffect = 0
873:                 .BackColor     = RGB(0, 128, 64)
874:                 .Visible       = .T.
875:             ENDWITH
876: 
877:             THIS.AddObject("lbl_4c_Label4", "Label")
878:             WITH THIS.lbl_4c_Label4
879:                 .FontName  = "Tahoma"
880:                 .FontSize  = 8
881:                 .Alignment = 0
882:                 .BackStyle = 0
883:                 .AutoSize  = .F.
884:                 .Caption   = "Lan" + CHR(231) + "amento Autom" + CHR(225) + "tico"
885:                 .TabIndex  = 15
886:                 .Left      = 350
887:                 .Top       = 495
888:                 .Width     = 117
889:                 .Height    = 17
890:                 .ForeColor = RGB(90, 90, 90)
891:                 .Visible   = .T.
892:             ENDWITH
893:         CATCH TO loc_oErro
894:             MsgErro(loc_oErro.Message + CHR(13) + ;
895:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
896:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarLegendaAutomatico")
897:         ENDTRY
898:     ENDPROC
899: 
900:     *==========================================================================
901:     * CarregarLista - Popula a grade de historico (followup) do cheque
902:     * consultado. Legado (SIGOPCFL.Init):
903:     *     lcQueryCheh = [Select * From SigCheh Where Nums = ?lcNum ]
904:     *     .AddCursor('SigCheh','CidChaves','CrSigCheh','','',lcQueryCheh)
905:     *     =ThisForm.Podatamgr.Requery('CrSigCheh')
906:     *     Select crSigCheH / Go Top
907:     * Ou seja: o filtro eh SEMPRE aplicado (inclusive com Nums vazio, caso em
908:     * que a consulta nao casa nada e a grade abre vazia de proposito - regra
909:     * #35a). O SQLEXEC vai para um cursor TEMPORARIO e o alias da grade eh
910:     * recarregado com ZAP + APPEND FROM DBF(), para nao derrubar
911:     * RecordSource/ControlSource/largura das colunas (SQLEXEC sobre o alias
912:     * ligado ao Grid zera o ColumnCount). Fecha com GO TOP + Refresh, que eh
913:     * o 'Go Top' + repintura que o legado faz (regra #21a).
914:     * A lista de colunas do SELECT eh IDENTICA (nome e ordem) a do
915:     * CREATE CURSOR de ConfigurarGrid - APPEND FROM casa por NOME.
916:     *==========================================================================
917:     PROCEDURE CarregarLista()
918:         LOCAL loc_lSucesso, loc_oBO, loc_oErro
919:         loc_lSucesso = .F.
920: 
921:         TRY
922:             IF !USED("cursor_4c_Dados")
923:                 THIS.ConfigurarGrid()
924:             ENDIF
925: 
926:             IF USED("cursor_4c_DadosTmp")
927:                 USE IN cursor_4c_DadosTmp
928:             ENDIF
929: 
930:             loc_oBO = THIS.this_oBusinessObject
931: 
932:             *-- Sem conexao (validacao de UI / modo teste) a grade fica vazia,
933:             *-- mas o cursor e o binding continuam validos.
934:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND VARTYPE(loc_oBO) = "O"
935:                 *-- A consulta mora no BO (PILAR 3 - o form nao fala com o
936:                 *-- banco). O BO devolve as linhas no cursor TEMPORARIO e o
937:                 *-- alias ligado ao Grid eh recarregado com ZAP + APPEND FROM
938:                 *-- DBF(), que preserva RecordSource/ControlSource/Width das
939:                 *-- colunas e o CurrentControl da celula de data.
940:                 IF loc_oBO.CarregarHistorico(THIS.this_cConta, "cursor_4c_DadosTmp")
941:                     *-- Esvazia SO depois do SELECT ter dado certo: ZAP antes
942:                     *-- da consulta deixaria a grade vazia quando o SQL Server
943:                     *-- recusasse.
944:                     THIS.EsvaziarCursorDados()
945:                     APPEND FROM DBF("cursor_4c_DadosTmp")
946:                     loc_lSucesso = .T.
947:                 ENDIF
948: 
949:                 IF USED("cursor_4c_DadosTmp")
950:                     USE IN cursor_4c_DadosTmp
951:                 ENDIF
952:             ELSE
953:                 THIS.EsvaziarCursorDados()
954:                 loc_lSucesso = .T.
955:             ENDIF
956: 
957:             THIS.RepintarGrade()
958:         CATCH TO loc_oErro
959:             MsgErro(loc_oErro.Message + CHR(13) + ;
960:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
961:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
962:         ENDTRY
963: 
964:         RETURN loc_lSucesso
965:     ENDPROC
966: 
967:     *==========================================================================
968:     * EsvaziarCursorDados - ZAP no cursor da grade, com SET SAFETY guardado.
969:     * ZAP (e nao USE IN + CREATE CURSOR) eh a escolha CERTA aqui: eh o
970:     * 'Zap In <cursor>' do legado Fortyus e preserva a estrutura, o
971:     * RecordSource/ControlSource do Grid e o CurrentControl da celula de data -
972:     * fechar e recriar o alias derrubaria o binding e a grade ficaria
973:     * permanentemente vazia com o cursor cheio.
974:     * O guard de SAFETY eh obrigatorio porque este form eh DataSession = 2:
975:     * SET SAFETY eh escopado por sessao de dados e vale ON na sessao privada
976:     * MESMO com o SET SAFETY OFF do main.prg. Com SAFETY ON o ZAP abre o
977:     * dialogo modal "Zap ... Are you sure?" e a tela CONGELA esperando um
978:     * clique que ninguem ve - em teste headless isso aparece como timeout sem
979:     * erro nenhum, nao como falha.
980:     * Restaura o valor ANTERIOR em vez de forcar OFF: desligar SAFETY para o
981:     * resto da vida da sessao tiraria a protecao de outros comandos
982:     * destrutivos (COPY TO / COPY FILE sobre arquivo existente).
983:     * Deixa cursor_4c_Dados SELECIONADO na saida - o APPEND FROM de
984:     * CarregarLista conta com isso (APPEND vai para a area de trabalho
985:     * CORRENTE, e ZAP IN nao muda a area corrente).
986:     *==========================================================================
987:     PROCEDURE EsvaziarCursorDados()
988:         LOCAL loc_cSafety
989: 
990:         IF USED("cursor_4c_Dados")
991:             loc_cSafety = SET("SAFETY")
992:             SET SAFETY OFF
993: 
994:             SELECT cursor_4c_Dados
995:             ZAP
996: 
997:             IF loc_cSafety = "ON"
998:                 SET SAFETY ON
999:             ENDIF
1000:         ENDIF
1001:     ENDPROC
1002: 
1003:     *==========================================================================
1004:     * RepintarGrade - Posiciona no topo e repinta a grade. Metodo UNICO,
1005:     * chamado por TODO caminho que popula cursor_4c_Dados: popular cursor NAO
1006:     * repinta a grade sozinho (regra #21a), e o legado sempre fecha com
1007:     * 'Select crSigCheH / Go Top' + 'ThisForm.gridFollowup.Refresh'.
1008:     *==========================================================================
1009:     PROCEDURE RepintarGrade()
1010:         IF USED("cursor_4c_Dados")
1011:             SELECT cursor_4c_Dados
1012:             GO TOP IN cursor_4c_Dados
1013:         ENDIF
1014: 
1015:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1016:             THIS.grd_4c_Dados.Refresh()
1017:         ENDIF
1018:     ENDPROC
1019: 
1020:     *==========================================================================
1021:     * CelulaDataFollowupEditavel - When da celula "Data / Hora" da grade.
1022:     * Legado (SIGOPCFL.gridFollowup.Column1.Text1.When), transcrito:
1023:     *     Return ThisForm.cmdApagaItem.cmdApagar.Visible
1024:     * cmdApagar eh o Buttons(1) de cmg_4c_CmdApagaitem - a ordem de declaracao
1025:     * do legado eh Apagar=1, Listar=2, Incluir=3, Alterar=4 (ver
1026:     * ConfigurarAcoes). Ou seja: a celula so recebe FOCO quando o usuario tem
1027:     * acesso de EXCLUIR; eh esse foco que o Apaga Item devolve para a grade
1028:     * depois de apagar a linha (legado: Column1.Text1.Setfocus).
1029:     * PUBLIC obrigatoriamente: a classe da celula
1030:     * (TextBoxCelulaFollowupCfl_4c) chama THISFORM.<metodo> de FORA da classe
1031:     * do form, e PEMSTATUS(..., 5) devolve .T. mesmo para metodo PROTECTED - o
1032:     * teste passaria e a chamada real estouraria "Property ... is not found"
1033:     * em runtime (regras #3 e #34).
1034:     *==========================================================================
1035:     PROCEDURE CelulaDataFollowupEditavel(par_oTxt)
1036:         LOCAL loc_lEditavel
1037: 
1038:         *-- Sem o CommandGroup de acoes nao ha como consultar a permissao;
1039:         *-- liberar o foco mantem a grade navegavel (o legado nunca chega
1040:         *-- aqui sem o grupo, criado no Init junto com a grade).
1041:         loc_lEditavel = .T.
1042: 
1043:         IF PEMSTATUS(THIS, "cmg_4c_CmdApagaitem", 5)
1044:             IF THIS.cmg_4c_CmdApagaitem.ButtonCount >= 1
1045:                 loc_lEditavel = THIS.cmg_4c_CmdApagaitem.Buttons(1).Visible
1046:             ENDIF
1047:         ENDIF
1048: 
1049:         RETURN loc_lEditavel
1050:     ENDPROC
1051: 
1052:     *==========================================================================
1053:     * ValidarCelulaDataFollowupExec - Valid da celula "Data / Hora" da grade.
1054:     * Legado (SIGOPCFL.gridFollowup.Column1.Text1.Valid), transcrito:
1055:     *     If Empty(this.value)
1056:     *         Messagebox('Data Invalida!',0+64,"Atencao!")
1057:     *         Return 0
1058:     *     Endif
1059:     * O retorno 0 mantem o foco na celula (comportamento do Valid em VFP9).
1060:     * O valor avaliado eh par_oTxt.Value - dentro do Valid o que o usuario
1061:     * digitou AINDA NAO chegou ao cursor, entao ler do cursor validaria o
1062:     * valor ANTERIOR (regra #46).
1063:     * PUBLIC pelo mesmo motivo de CelulaDataFollowupEditavel.
1064:     *==========================================================================
1065:     PROCEDURE ValidarCelulaDataFollowupExec(par_oTxt)
1066:         LOCAL loc_lValido
1067:         loc_lValido = .T.
1068: 
1069:         IF VARTYPE(par_oTxt) = "O"
1070:             IF EMPTY(par_oTxt.Value)
1071:                 MsgAviso("Data Inv" + CHR(225) + "lida!", ;
1072:                          "Aten" + CHR(231) + CHR(227) + "o!")
1073:                 loc_lValido = .F.
1074:             ENDIF
1075:         ENDIF
1076: 
1077:         *-- Devolve 0 (nao .F.) no caminho de recusa: eh o retorno do legado e
1078:         *-- eh o que faz o VFP9 manter o foco na celula.
1079:         RETURN IIF(loc_lValido, .T., 0)
1080:     ENDPROC
1081: 
1082:     *==========================================================================
1083:     * FormParaBO - Transfere o painel de inclusao/alteracao (cnt_4c__inserir)
1084:     * para as propriedades do BO. Espelha os Replace do GetHist.LostFocus
1085:     * legado:
1086:     *     Nums      With lcConta                 (ThisForm.Conta)
1087:     *     Datas     With This.Parent.GetData.Value
1088:     *     Emps      With _Empr                   -> go_4c_Sistema.cCodEmpresa
1089:     *     CidChaves with pChave                  (fUniqueIds, gerado no BO)
1090:     *     Hists     With This.Parent.GetHist.Value
1091:     * Em ALTERAR o legado regrava SO Hists sobre a linha corrente do cursor,
1092:     * entao a chave vem de cursor_4c_Dados.cidchaves (linha selecionada na
1093:     * grade) e Nums/Datas/Emps/Autos do registro original sao preservados - o
1094:     * UPDATE do BO toca apenas hists.
1095:     * _EMPR eh LEGADO e nunca se usa: a empresa vem de go_4c_Sistema.
1096:     * Devolve .F. (com aviso) quando falta a chave da linha em ALTERAR -
1097:     * gravar sem chave faria um UPDATE sem WHERE valido.
1098:     * PROTECTED EXPLICITO: FormBase ja declara PROTECTED PROCEDURE FormParaBO e
1099:     * em VFP9 a subclasse NAO alarga escopo herdado - omitir o modificador
1100:     * mentiria para quem le (o metodo fica protegido de qualquer jeito) e
1101:     * PEMSTATUS(..., 5) devolveria .T. sem a chamada externa funcionar.
1102:     * Chamado sempre por THIS. de dentro da classe (regra #8).
1103:     *==========================================================================
1104:     PROTECTED PROCEDURE FormParaBO()
1105:         LOCAL loc_oBO, loc_cModo, loc_uData, loc_lSucesso, loc_oErro
1106:         loc_lSucesso = .F.
1107: 
1108:         TRY
1109:             loc_oBO   = THIS.this_oBusinessObject
1110:             loc_cModo = UPPER(ALLTRIM(THIS.this_cModoAtual))
1111: 
1112:             IF VARTYPE(loc_oBO) = "O"
1113:                 *-- Observacao: comum aos dois modos (legado: Replace Hists
1114:                 *-- fora do IF de INSERIR). O MaxLength do TextBox e o
1115:                 *-- LEFT(..., 76) do BO vem de SigCheh.hists char(76)
1116:                 *-- (regra #19).
1117:                 loc_oBO.this_cHists = THIS.cnt_4c__inserir.txt_4c_Hist.Value
1118: 
1119:                 IF loc_cModo = "INSERIR"
1120:                     *-- cidchaves fica vazia de proposito: o Inserir() do BO
1121:                     *-- gera a chave com fUniqueIds() - NUNCA string vazia,
1122:                     *-- senao o 2o registro colide no indice unico (regra #22).
1123:                     loc_oBO.this_cCidChaves = ""
1124:                     loc_oBO.this_cNums      = THIS.this_cConta
1125: 
1126:                     *-- Datas: o botao Incluir enche GetData com DATETIME() e o
1127:                     *-- Alterar com a data da linha, mas o TextBox nasce com
1128:                     *-- .Value = {} (DATE). Normalizar aqui evita entregar DATE
1129:                     *-- onde o destino eh datetime (regra #16).
1130:                     loc_uData = THIS.cnt_4c__inserir.txt_4c_Data.Value
1131:                     DO CASE
1132:                     CASE VARTYPE(loc_uData) = "T"
1133:                         loc_oBO.this_dDatas = loc_uData
1134:                     CASE VARTYPE(loc_uData) = "D"
1135:                         loc_oBO.this_dDatas = DTOT(loc_uData)
1136:                     OTHERWISE
1137:                         *-- Mesmo default do ramo INSERIR do legado
1138:                         *-- (GetData.Value = DateTime()).
1139:                         loc_oBO.this_dDatas = DATETIME()
1140:                     ENDCASE
1141: 
1142:                     IF VARTYPE(go_4c_Sistema) = "O"
1143:                         loc_oBO.this_cEmps = go_4c_Sistema.cCodEmpresa
1144:                     ELSE

*-- Linhas 1162 a 1516:
1162:                     ENDIF
1163: 
1164:                     IF EMPTY(loc_oBO.this_cCidChaves)
1165:                         MsgAviso("Selecione na grade o hist" + CHR(243) + "rico " + ;
1166:                                  "que deseja alterar.", ;
1167:                                  "Aten" + CHR(231) + CHR(227) + "o")
1168:                     ELSE
1169:                         loc_lSucesso = .T.
1170:                     ENDIF
1171:                 ENDIF
1172:             ENDIF
1173:         CATCH TO loc_oErro
1174:             MsgErro(loc_oErro.Message + CHR(13) + ;
1175:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1176:                     "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
1177:         ENDTRY
1178: 
1179:         RETURN loc_lSucesso
1180:     ENDPROC
1181: 
1182:     *==========================================================================
1183:     * BOParaForm - Caminho inverso de FormParaBO: leva o registro de followup
1184:     * carregado no BO (SigCheh) para os dois campos do painel flutuante.
1185:     * Espelha o que o cmdAlterar.Click legado faz lendo o cursor direto:
1186:     *     ThisForm.cnt_inserir.GetData.Value = CrSigCheh.Datas
1187:     *     ThisForm.cnt_inserir.GetHist.Value = CrSigCheh.Hists
1188:     * Na nova arquitetura a linha selecionada passa pelo BO
1189:     * (CarregarDoCursor) e chega aos controles por aqui - os valores sao os
1190:     * MESMOS, so o caminho respeita as camadas (PILAR 3).
1191:     * Datas normalizado para DATETIME: a coluna eh datetime e o TextBox nasce
1192:     * com .Value = {} (DATE); entregar DATE onde o resto do fluxo espera
1193:     * DATETIME eh o que dispara erro 11 adiante (regra #16).
1194:     * PROTECTED EXPLICITO, pelo mesmo motivo de FormParaBO: FormBase declara
1195:     * PROTECTED PROCEDURE BOParaForm e em VFP9 a subclasse NAO alarga escopo
1196:     * herdado. Chamado sempre por THIS. de dentro da classe (regra #8).
1197:     *==========================================================================
1198:     PROTECTED PROCEDURE BOParaForm()
1199:         LOCAL loc_oBO, loc_oPainel, loc_uData, loc_lSucesso, loc_oErro
1200:         loc_lSucesso = .F.
1201: 
1202:         TRY
1203:             loc_oBO = THIS.this_oBusinessObject
1204: 
1205:             IF VARTYPE(loc_oBO) = "O"
1206:                 loc_oPainel = THIS.cnt_4c__inserir
1207: 
1208:                 loc_uData = loc_oBO.this_dDatas
1209:                 DO CASE
1210:                 CASE VARTYPE(loc_uData) = "T"
1211:                     loc_oPainel.txt_4c_Data.Value = loc_uData
1212:                 CASE VARTYPE(loc_uData) = "D"
1213:                     loc_oPainel.txt_4c_Data.Value = DTOT(loc_uData)
1214:                 OTHERWISE
1215:                     loc_oPainel.txt_4c_Data.Value = {}
1216:                 ENDCASE
1217: 
1218:                 loc_oPainel.txt_4c_Hist.Value = loc_oBO.this_cHists
1219: 
1220:                 loc_lSucesso = .T.
1221:             ENDIF
1222:         CATCH TO loc_oErro
1223:             MsgErro(loc_oErro.Message + CHR(13) + ;
1224:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1225:                     "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
1226:         ENDTRY
1227: 
1228:         RETURN loc_lSucesso
1229:     ENDPROC
1230: 
1231:     *==========================================================================
1232:     * LimparCampos - Zera os dois campos do painel flutuante. O branco de
1233:     * GetHist eh SPACE(50) porque eh o que o ramo INSERIR do legado escreve
1234:     * (ThisForm.cnt_inserir.GetHist.Value = Space(50)); para EMPTY() e para o
1235:     * SQL Server isso eh equivalente a string vazia, e transcrever o literal
1236:     * do legado custa nada.
1237:     * Limpar ao FECHAR o painel (BtnCancelarClick) eh necessario porque este
1238:     * form, diferente do legado (modal, um registro por vida), nao fecha
1239:     * entre uma operacao e outra: dado residual do followup anterior
1240:     * reapareceria no proximo Incluir (regra #32).
1241:     * PUBLIC: nenhum caller externo hoje, mas eh o nome canonico do projeto e
1242:     * o harness de teste costuma chamar metodos de estado de FORA da classe,
1243:     * onde PROTECTED estoura em runtime mesmo passando no PEMSTATUS (regra #3).
1244:     *==========================================================================
1245:     PROCEDURE LimparCampos()
1246:         IF PEMSTATUS(THIS, "cnt_4c__inserir", 5)
1247:             THIS.cnt_4c__inserir.txt_4c_Data.Value = {}
1248:             THIS.cnt_4c__inserir.txt_4c_Hist.Value = SPACE(50)
1249:         ENDIF
1250:     ENDPROC
1251: 
1252:     *==========================================================================
1253:     * HabilitarCampos - Libera ou trava os dois campos EDITAVEIS da tela (os
1254:     * do painel flutuante). Os outros seis controles do topo (Emissor e
1255:     * Banco/Agencia/Conta/N.Cheque) nascem somente-leitura no SCX legado e
1256:     * NAO entram aqui - travar ou liberar ja seria mudar o legado.
1257:     * O legado nao desabilita nada: GetData.When e GetHist.When sao apenas
1258:     * um comentario ("*"), e quem impede o acesso eh a VISIBILIDADE do painel
1259:     * - com cnt_inserir oculto os dois campos sao inalcancaveis. Por isso
1260:     * este metodo eh chamado SO pelo funil AjustarBotoesPorModo, com o MESMO
1261:     * valor que decide a visibilidade do painel: painel visivel -> campos
1262:     * liberados. Assim nao existe estado onde o painel aparece com os campos
1263:     * travados, e a travada no fechamento eh invisivel ao usuario (regra #40:
1264:     * quem desabilita tem de reabilitar no funil de volta).
1265:     *==========================================================================
1266:     PROCEDURE HabilitarCampos(par_lHabilitar)
1267:         LOCAL loc_lHabilitar
1268: 
1269:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.)
1270: 
1271:         IF PEMSTATUS(THIS, "cnt_4c__inserir", 5)
1272:             THIS.cnt_4c__inserir.txt_4c_Data.ReadOnly = !loc_lHabilitar
1273:             THIS.cnt_4c__inserir.txt_4c_Hist.ReadOnly = !loc_lHabilitar
1274:         ENDIF
1275:     ENDPROC
1276: 
1277:     *==========================================================================
1278:     * AjustarBotoesPorModo - FUNIL UNICO de estado da tela, derivado de
1279:     * this_cModoAtual (legado: ThisForm.Tipo). Tres coisas, sempre juntas:
1280:     *   1. painel flutuante visivel <=> modo INSERIR/ALTERAR (legado:
1281:     *      cnt_inserir.Visible = .t. nos dois Click, = .f. no LostFocus);
1282:     *   2. campos do painel liberados <=> painel visivel (HabilitarCampos);
1283:     *   3. botoes de acao reempilhados por permissao (AjustarAcoesPorAcesso,
1284:     *      que eh o bloco 'With ThisForm.cmdApagaItem' do Init legado).
1285:     * Existir como FUNIL eh o que impede o defeito classico de modo: quem
1286:     * muda o estado em cada botao, e nao num ponto so, esquece o caminho de
1287:     * VOLTA e deixa a tela travada (regra #40). Todos os caminhos
1288:     * (BtnIncluirClick/BtnAlterarClick/BtnCancelarClick e a montagem inicial,
1289:     * em ConfigurarAcoes) passam por aqui.
1290:     * NENHUM botao eh desabilitado: o legado nao desabilita os botoes de acao
1291:     * enquanto o painel esta aberto, e inventar isso mudaria a UX (PILAR 1).
1292:     * Modo "" (estado inicial e pos-gravacao) e qualquer outro valor que
1293:     * chegue de fora - o harness de teste atribui "VISUALIZAR" direto na
1294:     * property - caem no mesmo ramo: painel fechado, campos travados.
1295:     * PUBLIC: TesteAutomatico.prg chama THIS.oForm.AjustarBotoesPorModo() de
1296:     * FORA da classe, e PEMSTATUS(..., 5) devolve .T. mesmo para metodo
1297:     * PROTECTED - o teste entraria no branch e a chamada estouraria em
1298:     * runtime com "Property ... is not found" (regra #3).
1299:     *==========================================================================
1300:     PROCEDURE AjustarBotoesPorModo()
1301:         LOCAL loc_lEditando, loc_oErro
1302: 
1303:         TRY
1304:             loc_lEditando = INLIST(UPPER(ALLTRIM(THIS.this_cModoAtual)), "INSERIR", "ALTERAR")
1305: 
1306:             IF PEMSTATUS(THIS, "cnt_4c__inserir", 5)
1307:                 THIS.cnt_4c__inserir.Visible = loc_lEditando
1308:             ENDIF
1309: 
1310:             THIS.HabilitarCampos(loc_lEditando)
1311: 
1312:             IF PEMSTATUS(THIS, "cmg_4c_CmdApagaitem", 5)
1313:                 THIS.AjustarAcoesPorAcesso()
1314:             ENDIF
1315:         CATCH TO loc_oErro
1316:             MsgErro(loc_oErro.Message + CHR(13) + ;
1317:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1318:                     "Procedure: " + loc_oErro.Procedure, "Erro em AjustarBotoesPorModo")
1319:         ENDTRY
1320:     ENDPROC
1321: 
1322:     *==========================================================================
1323:     * TemLinhaSelecionada - A grade tem linha corrente utilizavel?
1324:     * IFs ANINHADOS de proposito: VFP9 NAO faz short-circuit, entao
1325:     * 'USED(x) OR RECCOUNT(x) = 0' avalia o RECCOUNT mesmo com o alias
1326:     * FECHADO e estoura "Alias is not found" - exatamente o defeito que
1327:     * existia em BtnAlterarClick/BtnExcluirClick antes desta fase.
1328:     *==========================================================================
1329:     PROCEDURE TemLinhaSelecionada()
1330:         LOCAL loc_lTem
1331:         loc_lTem = .F.
1332: 
1333:         IF USED("cursor_4c_Dados")
1334:             IF RECCOUNT("cursor_4c_Dados") > 0
1335:                 IF !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
1336:                     loc_lTem = .T.
1337:                 ENDIF
1338:             ENDIF
1339:         ENDIF
1340: 
1341:         RETURN loc_lTem
1342:     ENDPROC
1343: 
1344:     *==========================================================================
1345:     * FocarCelulaHistorico - Devolve o foco para a celula "Data / Hora" da
1346:     * grade. Legado: 'ThisForm.GridFollowup.Column1.SetFocus' no fim do
1347:     * GetHist.LostFocus e do cmdApagar.Click.
1348:     * O foco so vai quando a celula PODE recebe-lo: o When dela devolve a
1349:     * visibilidade do Apaga Item (CelulaDataFollowupEditavel), e SetFocus em
1350:     * celula cujo When eh .F. falharia; grade vazia tambem nao tem celula
1351:     * para focar. Extraido porque os dois caminhos repetiam o bloco inteiro.
1352:     *==========================================================================
1353:     PROCEDURE FocarCelulaHistorico()
1354:         IF THIS.CelulaDataFollowupEditavel(.NULL.)
1355:             IF THIS.TemLinhaSelecionada()
1356:                 THIS.grd_4c_Dados.Column1.SetFocus()
1357:             ENDIF
1358:         ENDIF
1359:     ENDPROC
1360: 
1361:     *==========================================================================
1362:     * HistoricoLostFocus - Wrapper do GetHist.LostFocus legado, com guarda de
1363:     * reentrancia. O corpo fecha o painel e devolve o foco para a grade, e
1364:     * isso REDISPARA o proprio LostFocus; sem a guarda a gravacao aconteceria
1365:     * duas vezes (regra #47). A flag eh liberada AQUI, no wrapper, e nao no
1366:     * corpo - assim ela nao trava ligada quando o corpo sai por RETURN
1367:     * antecipado, o que mataria a gravacao pelo resto da vida do form.
1368:     * PUBLIC e SEM parametro: LostFocus nao passa nenhum (regra #3).
1369:     *==========================================================================
1370:     PROCEDURE HistoricoLostFocus()
1371:         IF THIS.this_lEmGravacao
1372:             RETURN
1373:         ENDIF
1374: 
1375:         THIS.this_lEmGravacao = .T.
1376:         THIS.HistoricoLostFocusExec()
1377:         THIS.this_lEmGravacao = .F.
1378:     ENDPROC
1379: 
1380:     *==========================================================================
1381:     * HistoricoLostFocusExec - Corpo do GetHist.LostFocus legado:
1382:     *     Local lcConta
1383:     *     lcConta = ThisForm.Conta
1384:     *     Select CrSigCheh
1385:     *     If !Empty(This.Value)
1386:     *         If ThisForm.Tipo = 'INSERIR'
1387:     *             pChave = fUniqueIds()
1388:     *             Append Blank
1389:     *             Replace Nums With lcConta, Datas With This.Parent.GetData.Value,;
1390:     *                     Emps With _Empr, CidChaves with pChave
1391:     *         Endif
1392:     *         Replace Hists With This.Parent.GetHist.Value
1393:     *         ThisForm.podatamgr.Update('CrSigCheh')
1394:     *         ThisForm.podatamgr.commit()
1395:     *     Endif
1396:     *     ThisForm.cnt_inserir.Visible = .f.
1397:     *     ThisForm.gridFollowup.Refresh
1398:     *     ThisForm.GridFollowup.Column1.SetFocus
1399:     *
1400:     * Na nova arquitetura o Append/Replace + Update + commit do cursor viram
1401:     * NovoRegistro/EditarRegistro + FormParaBO + Salvar() no BO (INSERT ou
1402:     * UPDATE em SigCheh) e a grade eh RECARREGADA do banco por CarregarLista,
1403:     * em vez de editada no cursor.
1404:     *
1405:     * As TRES ultimas linhas do legado rodam SEMPRE - inclusive com a
1406:     * observacao em branco, caso em que nada eh gravado e o painel so fecha.
1407:     * Por isso ficam FORA do IF de gravacao, igual ao legado.
1408:     *
1409:     * A gravacao exige painel VISIVEL e modo INSERIR/ALTERAR: no legado eh o
1410:     * cmdInserir/cmdAlterar que mostra o painel e define ThisForm.Tipo, e com
1411:     * o painel oculto GetHist nao recebe foco - a visibilidade EH o gate.
1412:     * Salvar() do BusinessBase ja reporta a falha sozinho (regra #20), por
1413:     * isso nao ha ELSE repetindo a mensagem.
1414:     *==========================================================================
1415:     PROCEDURE HistoricoLostFocusExec()
1416:         LOCAL loc_oBO, loc_cModo, loc_cHist, loc_oErro
1417: 
1418:         TRY
1419:             loc_oBO   = THIS.this_oBusinessObject
1420:             loc_cModo = UPPER(ALLTRIM(THIS.this_cModoAtual))
1421:             loc_cHist = THIS.cnt_4c__inserir.txt_4c_Hist.Value
1422: 
1423:             IF THIS.cnt_4c__inserir.Visible AND ;
1424:                INLIST(loc_cModo, "INSERIR", "ALTERAR") AND ;
1425:                !EMPTY(loc_cHist) AND VARTYPE(loc_oBO) = "O"
1426: 
1427:                 IF loc_cModo = "INSERIR"
1428:                     *-- NovoRegistro ANTES do FormParaBO: ele chama
1429:                     *-- LimparDados e zeraria o que tivesse sido transferido.
1430:                     loc_oBO.NovoRegistro()
1431:                     IF THIS.FormParaBO()
1432:                         THIS.this_oBusinessObject.Salvar()
1433:                     ENDIF
1434:                 ELSE
1435:                     *-- CancelarEdicao normaliza this_lNovoRegistro: se uma
1436:                     *-- inclusao anterior falhou, a flag ficaria ligada e o
1437:                     *-- EditarRegistro recusaria toda alteracao seguinte.
1438:                     loc_oBO.CancelarEdicao()
1439:                     IF THIS.FormParaBO()
1440:                         IF loc_oBO.EditarRegistro()
1441:                             THIS.this_oBusinessObject.Salvar()
1442:                         ENDIF
1443:                     ENDIF
1444:                 ENDIF
1445:             ENDIF
1446: 
1447:             *-- As TRES ultimas linhas do legado (cnt_inserir.Visible = .f. /
1448:             *-- gridFollowup.Refresh / Column1.SetFocus) rodam SEMPRE, mesmo
1449:             *-- sem gravar nada - e sao exatamente o que BtnCancelarClick faz.
1450:             *-- Observacao em branco cai aqui direto: eh o caminho de
1451:             *-- CANCELAMENTO do legado, que nunca teve botao.
1452:             THIS.BtnCancelarClick()
1453:         CATCH TO loc_oErro
1454:             MsgErro(loc_oErro.Message + CHR(13) + ;
1455:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1456:                     "Procedure: " + loc_oErro.Procedure, "Erro em HistoricoLostFocusExec")
1457:         ENDTRY
1458:     ENDPROC
1459: 
1460:     *==========================================================================
1461:     * ConfigurarAcoes - cmg_4c_CmdApagaitem (cmdApagaitem do legado):
1462:     * CommandGroup com 4 botoes de acao sobre o historico selecionado na
1463:     * grade (Incluir/Alterar/Apagar/Listar). Posicao e Left de cada botao
1464:     * EXATOS do dump (SigOpCfl.SCX) - a ordem de declaracao dos Buttons
1465:     * (Apagar=1, Listar=2, Incluir=3, Alterar=4) NAO eh a ordem visual
1466:     * esquerda-direita (Incluir/Alterar/Apagar/Listar); cada Buttons(N) usa
1467:     * o Left individual do dump, igual ao legado.
1468:     * O reposicionamento dinamico por fChecaAcesso (legado: With
1469:     * ThisForm.cmdApagaItem ... .cmdInserir.Visible = fChecaAcesso(...)) eh
1470:     * feito por AjustarAcoesPorAcesso() (Fase 7/8), chamado ao final deste
1471:     * metodo - junto com o BINDEVENT dos 3 botoes que tem Click no legado
1472:     * (Incluir/Alterar/Apagar; "Listar" nao tem codigo no dump, logo fica
1473:     * sem handler - regra: nunca inventar funcionalidade que o legado nao
1474:     * tem).
1475:     *==========================================================================
1476:     PROTECTED PROCEDURE ConfigurarAcoes()
1477:         LOCAL loc_oErro
1478:         TRY
1479:             THIS.AddObject("cmg_4c_CmdApagaitem", "CommandGroup")
1480:             WITH THIS.cmg_4c_CmdApagaitem
1481:                 .ButtonCount   = 4
1482:                 .Top           = -1
1483:                 .Left          = 420
1484:                 .Width         = 310
1485:                 .Height        = 85
1486:                 .TabIndex      = 2
1487:                 .BackStyle     = 0
1488:                 .BorderStyle   = 0
1489:                 .SpecialEffect = 1
1490:                 .BorderColor   = RGB(136, 189, 188)
1491:                 .Themes        = .F.
1492:                 .Visible       = .T.
1493:             ENDWITH
1494: 
1495:             *-- Command1 = cmdApagar ("Apaga Item")
1496:             WITH THIS.cmg_4c_CmdApagaitem.Buttons(1)
1497:                 .Top             = 5
1498:                 .Left            = 155
1499:                 .Width           = 75
1500:                 .Height          = 75
1501:                 .FontBold        = .T.
1502:                 .FontItalic      = .T.
1503:                 .FontName        = "Comic Sans MS"
1504:                 .FontSize        = 8
1505:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1506:                 .TabIndex        = 2
1507:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1508:                 .Caption         = "A\<paga Item"
1509:                 .ForeColor       = RGB(90, 90, 90)
1510:                 .BackColor       = RGB(255, 255, 255)
1511:                 .Themes          = .F.
1512:             ENDWITH
1513: 
1514:             *-- Command2 = cmdListar ("Listar")
1515:             WITH THIS.cmg_4c_CmdApagaitem.Buttons(2)
1516:                 .Top             = 5

*-- Linhas 1568 a 1819:
1568: 
1569:             *-- Click dos 3 botoes com codigo no legado (regra #8: sempre
1570:             *-- THIS. de dentro da classe). "Listar" (Buttons(2)) fica sem
1571:             *-- BINDEVENT - o dump nao tem PROCEDURE cmdListar.Click.
1572:             BINDEVENT(THIS.cmg_4c_CmdApagaitem.Buttons(3), "Click", THIS, "BtnIncluirClick")
1573:             BINDEVENT(THIS.cmg_4c_CmdApagaitem.Buttons(4), "Click", THIS, "BtnAlterarClick")
1574:             BINDEVENT(THIS.cmg_4c_CmdApagaitem.Buttons(1), "Click", THIS, "BtnExcluirClick")
1575: 
1576:             *-- Estado inicial pelo FUNIL, nao direto no AjustarAcoesPorAcesso:
1577:             *-- com this_cModoAtual = "" ele deixa o painel flutuante fechado e
1578:             *-- os campos travados, alem de reempilhar os botoes por permissao.
1579:             *-- cnt_4c__inserir e os dois TextBox dele ja existem neste ponto
1580:             *-- (ConfigurarContainersBase e ConfigurarPainelInserir rodam antes
1581:             *-- de ConfigurarAcoes em ConfigurarPageFrame).
1582:             THIS.AjustarBotoesPorModo()
1583:         CATCH TO loc_oErro
1584:             MsgErro(loc_oErro.Message + CHR(13) + ;
1585:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1586:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAcoes")
1587:         ENDTRY
1588:     ENDPROC
1589: 
1590:     *==========================================================================
1591:     * AjustarAcoesPorAcesso - Reposiciona e mostra/esconde os 4 botoes de acao
1592:     * por permissao. Legado (SIGOPCFL.Init, With ThisForm.cmdApagaItem):
1593:     *     .cmdInserir.Visible = fChecaAcesso('SIGOPCFL','INSERIR')
1594:     *     .cmdAlterar.Visible = fChecaAcesso('SIGOPCFL','ALTERAR')
1595:     *     .cmdApagar.Visible  = fChecaAcesso('SIGOPCFL','EXCLUIR')
1596:     *     .cmdListar.Visible  = fChecaAcesso('SIGOPCFL','LISTAR')
1597:     *     lcPos = 5 / lcLrg = 80  -- reempilha da esquerda, na ordem Incluir/
1598:     *     Alterar/Apagar/Listar, so os VISIVEIS; sem nenhum visivel, o
1599:     *     CommandGroup inteiro fica oculto (.Visible = .f.).
1600:     * fChecaAcesso() (utils/functions.prg) eh stub de compatibilidade e
1601:     * sempre devolve .T. - entao, na pratica, os 4 ficam visiveis e
1602:     * reempilhados em 5/85/165/245 (Width final = 330), que eh o resultado
1603:     * REAL do Init legado em runtime - os valores estaticos do dump (SCX)
1604:     * nunca sao o que o usuario ve, porque este bloco os sobrescreve sempre.
1605:     * WITH .Buttons(N) aninhado em 1 nivel dentro do WITH do CommandGroup eh
1606:     * seguro (regra #38 - so AddObject aninhado quebra, Buttons(N) eh
1607:     * accessor).
1608:     *==========================================================================
1609:     PROTECTED PROCEDURE AjustarAcoesPorAcesso()
1610:         LOCAL loc_nPos, loc_nLrg, loc_oErro
1611: 
1612:         TRY
1613:             loc_nPos = 5
1614:             loc_nLrg = 80
1615: 
1616:             WITH THIS.cmg_4c_CmdApagaitem
1617:                 .Buttons(3).Visible = fChecaAcesso("SIGOPCFL", "INSERIR")
1618:                 .Buttons(4).Visible = fChecaAcesso("SIGOPCFL", "ALTERAR")
1619:                 .Buttons(1).Visible = fChecaAcesso("SIGOPCFL", "EXCLUIR")
1620:                 .Buttons(2).Visible = fChecaAcesso("SIGOPCFL", "LISTAR")
1621: 
1622:                 IF .Buttons(3).Visible
1623:                     .Buttons(3).Left = loc_nPos
1624:                     loc_nPos = loc_nPos + loc_nLrg
1625:                 ENDIF
1626:                 IF .Buttons(4).Visible
1627:                     .Buttons(4).Left = loc_nPos
1628:                     loc_nPos = loc_nPos + loc_nLrg
1629:                 ENDIF
1630:                 IF .Buttons(1).Visible
1631:                     .Buttons(1).Left = loc_nPos
1632:                     loc_nPos = loc_nPos + loc_nLrg
1633:                 ENDIF
1634:                 IF .Buttons(2).Visible
1635:                     .Buttons(2).Left = loc_nPos
1636:                     loc_nPos = loc_nPos + loc_nLrg
1637:                 ENDIF
1638: 
1639:                 IF loc_nPos > 5
1640:                     .Width = loc_nPos + 5
1641:                     .Refresh()
1642:                 ELSE
1643:                     .Visible = .F.
1644:                 ENDIF
1645:             ENDWITH
1646:         CATCH TO loc_oErro
1647:             MsgErro(loc_oErro.Message + CHR(13) + ;
1648:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1649:                     "Procedure: " + loc_oErro.Procedure, "Erro em AjustarAcoesPorAcesso")
1650:         ENDTRY
1651:     ENDPROC
1652: 
1653:     *==========================================================================
1654:     * ConfigurarSaida - cmg_4c_Commandgroup1 (Commandgroup1 do legado):
1655:     * CommandGroup com 1 botao (Encerrar). Reposicionado flush-a-direita
1656:     * com a largura nova do form (legado: Left=723 num form de 800px, ou
1657:     * seja, a ~3px da borda direita - em 1000px o equivalente e Left =
1658:     * THIS.Width - 85 = 915, mesmo padrao do cmd_4c_Saida do FormSIGOPCFE).
1659:     * Evento (legado: Commandgroup1.Command1.Valid -> ThisForm.Release) eh
1660:     * ligado aqui via Click - mesmo padrao do projeto para botao avulso em
1661:     * CommandGroup (ver o CommandGroup de sair do FormCliente e a barra de
1662:     * botoes do FormGr1).
1663:     *
1664:     * NAO citar aqui o nome do CommandGroup de barra de botoes dos forms
1665:     * REPORT: a heuristica "arquivo tem <aquele nome> em algum lugar" do
1666:     * CorretorAutomatico (patterns #103/#168 e o de WordWrap) nao distingue
1667:     * COMENTARIO de codigo. Com o nome escrito num comentario, este form
1668:     * OPERACIONAL era classificado como REPORT e o corretor injetava
1669:     * HeaderHeight = 0 na grade - o que ESCONDE os cabecalhos
1670:     * "Data / Hora" e "Observacao" que o legado mostra.
1671:     *==========================================================================
1672:     PROTECTED PROCEDURE ConfigurarSaida()
1673:         LOCAL loc_oErro
1674:         TRY
1675:             THIS.AddObject("cmg_4c_Commandgroup1", "CommandGroup")
1676:             WITH THIS.cmg_4c_Commandgroup1
1677:                 .ButtonCount  = 1
1678:                 .Top          = 3
1679:                 .Left         = THIS.Width - 85
1680:                 .Width        = 80
1681:                 .Height       = 80
1682:                 .BackStyle    = 0
1683:                 .BorderStyle  = 0
1684:                 .SpecialEffect = 1
1685:                 .BackColor    = RGB(255, 255, 255)
1686:                 .BorderColor  = RGB(136, 189, 188)
1687:                 .TabIndex     = 2
1688:                 .Themes       = .F.
1689:                 .Visible      = .T.
1690:             ENDWITH
1691: 
1692:             WITH THIS.cmg_4c_Commandgroup1.Buttons(1)
1693:                 .Top        = 1
1694:                 .Left       = 2
1695:                 .Width      = 75
1696:                 .Height     = 75
1697:                 .FontBold   = .T.
1698:                 .FontItalic = .T.
1699:                 .FontName   = "Comic Sans MS"
1700:                 .FontSize   = 8
1701:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1702:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1703:                 .Caption    = "Encerrar"
1704:                 .Cancel     = .T.
1705:                 .ForeColor  = RGB(90, 90, 90)
1706:                 .BackColor  = RGB(255, 255, 255)
1707:                 .Themes     = .F.
1708:             ENDWITH
1709: 
1710:             BINDEVENT(THIS.cmg_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnEncerrarClick")
1711:         CATCH TO loc_oErro
1712:             MsgErro(loc_oErro.Message + CHR(13) + ;
1713:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1714:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarSaida")
1715:         ENDTRY
1716:     ENDPROC
1717: 
1718:     *==========================================================================
1719:     * BtnIncluirClick - cmdInserir.Click (Buttons(3) de cmg_4c_CmdApagaitem).
1720:     * Legado (SIGOPCFL.cmdApagaitem.cmdInserir.Click), transcrito:
1721:     *     ThisForm.Tipo = 'INSERIR'
1722:     *     ThisForm.cnt_inserir.Visible = .t.
1723:     *     ThisForm.cnt_inserir.GetData.Value = DateTime()
1724:     *     ThisForm.cnt_inserir.GetHist.Value = Space(50)
1725:     *     ThisForm.cnt_inserir.Refresh
1726:     *     ThisForm.cnt_inserir.GetData.SetFocus
1727:     * A gravacao de fato so acontece no LostFocus de txt_4c_Hist
1728:     * (HistoricoLostFocus, Fase 6) - este botao so abre o painel com os
1729:     * defaults do ramo INSERIR. PUBLIC: ligado por BINDEVENT (regra #3).
1730:     *==========================================================================
1731:     PROCEDURE BtnIncluirClick()
1732:         *-- Sem cheque nao ha followup: SigCheh.nums eh char(8) NOT NULL e
1733:         *-- aponta para SigChe.nums. A tela so chega sem cheque quando eh
1734:         *-- aberta sem par_cConta (o legado tolera: 'If Type(pConta)#"C"'),
1735:         *-- e nesse estado o Incluir gravaria um followup ORFAO. Recusar
1736:         *-- aqui, antes de abrir o painel, eh mais claro do que abrir e so
1737:         *-- avisar depois (regra #50). O BO repete a regra em ValidarDados
1738:         *-- (fonte unica), este guard so evita a ida e volta.
1739:         IF EMPTY(ALLTRIM(THIS.this_cConta))
1740:             MsgAviso("Cheque n" + CHR(227) + "o informado - abra o FollowUp a " + ;
1741:                      "partir de um cheque.", "Aten" + CHR(231) + CHR(227) + "o")
1742:         ELSE
1743:             *-- Legado (cmdInserir.Click): Tipo = 'INSERIR' / cnt_inserir
1744:             *-- visivel / GetData = DateTime() / GetHist = Space(50) /
1745:             *-- Refresh / GetData.SetFocus.
1746:             THIS.this_cModoAtual = "INSERIR"
1747: 
1748:             THIS.LimparCampos()
1749:             THIS.cnt_4c__inserir.txt_4c_Data.Value = DATETIME()
1750: 
1751:             *-- Abre o painel e libera os campos pelo funil de modo (regra #40)
1752:             THIS.AjustarBotoesPorModo()
1753: 
1754:             THIS.cnt_4c__inserir.Refresh()
1755:             THIS.cnt_4c__inserir.txt_4c_Data.SetFocus()
1756:         ENDIF
1757:     ENDPROC
1758: 
1759:     *==========================================================================
1760:     * BtnAlterarClick - cmdAlterar.Click (Buttons(4) de cmg_4c_CmdApagaitem).
1761:     * Legado (SIGOPCFL.cmdApagaitem.cmdAlterar.Click), transcrito:
1762:     *     ThisForm.Tipo = 'ALTERAR'
1763:     *     ThisForm.cnt_inserir.Visible = .t.
1764:     *     ThisForm.cnt_inserir.GetData.Value = CrSigCheh.Datas
1765:     *     ThisForm.cnt_inserir.GetHist.Value = CrSigCheh.Hists
1766:     *     ThisForm.cnt_inserir.Refresh
1767:     *     ThisForm.cnt_inserir.GetData.SetFocus
1768:     * O legado le CrSigCheh (linha corrente da grade) sem guarda - aqui a
1769:     * guarda contra grade vazia/sem selecao eh necessaria (cursor_4c_Dados
1770:     * sem linha corrente): sem ela o painel abriria com Data/Hist em branco
1771:     * e a alteracao, no LostFocus, cairia no aviso de FormParaBO ("Selecione
1772:     * na grade..."). Evitar abrir o painel sem o que precisa eh mais claro
1773:     * para o usuario do que abrir e so avisar depois (regra #50).
1774:     *==========================================================================
1775:     PROCEDURE BtnAlterarClick()
1776:         LOCAL loc_oBO
1777: 
1778:         IF !THIS.TemLinhaSelecionada()
1779:             MsgAviso("Selecione na grade o hist" + CHR(243) + "rico que deseja alterar.", ;
1780:                      "Aten" + CHR(231) + CHR(227) + "o")
1781:         ELSE
1782:             *-- A linha selecionada passa pelo BO e chega aos campos por
1783:             *-- BOParaForm - os valores sao os mesmos que o legado le direto
1784:             *-- do cursor (CrSigCheh.Datas/Hists), so o caminho respeita as
1785:             *-- camadas (PILAR 3).
1786:             *-- CancelarEdicao ANTES de CarregarDoCursor normaliza
1787:             *-- this_lNovoRegistro: se um Incluir anterior falhou ao salvar, a
1788:             *-- flag ficaria ligada e o EditarRegistro do LostFocus recusaria
1789:             *-- esta alteracao (regra #32 - o form nao fecha entre operacoes).
1790:             loc_oBO = THIS.this_oBusinessObject
1791:             IF VARTYPE(loc_oBO) = "O"
1792:                 loc_oBO.CancelarEdicao()
1793:                 loc_oBO.CarregarDoCursor("cursor_4c_Dados")
1794:             ENDIF
1795: 
1796:             THIS.this_cModoAtual = "ALTERAR"
1797: 
1798:             THIS.LimparCampos()
1799:             THIS.BOParaForm()
1800: 
1801:             *-- Abre o painel e libera os campos pelo funil de modo (regra #40)
1802:             THIS.AjustarBotoesPorModo()
1803: 
1804:             THIS.cnt_4c__inserir.Refresh()
1805:             THIS.cnt_4c__inserir.txt_4c_Data.SetFocus()
1806:         ENDIF
1807:     ENDPROC
1808: 
1809:     *==========================================================================
1810:     * BtnCancelarClick - Fecha o painel de Incluir/Alterar SEM gravar e
1811:     * devolve a tela ao estado de consulta. Eh o caminho de CANCELAMENTO que
1812:     * o legado tem (observacao em branco no GetHist.LostFocus: o IF de
1813:     * gravacao nao entra e as tres ultimas linhas rodam de qualquer jeito) -
1814:     * NENHUM botao novo foi desenhado na tela, o legado nao tem um e inventar
1815:     * violaria o PILAR 1. Legado, literal:
1816:     *     ThisForm.cnt_inserir.Visible = .f.
1817:     *     ThisForm.gridFollowup.Refresh
1818:     *     ThisForm.GridFollowup.Column1.SetFocus
1819:     * Chamado pelo proprio HistoricoLostFocusExec (nos dois ramos, com e sem

*-- Linhas 1826 a 1869:
1826:     * JA esta ligada - um clear simples a liberaria cedo demais e deixaria a
1827:     * segunda passagem acontecer (regra #47).
1828:     *==========================================================================
1829:     PROCEDURE BtnCancelarClick()
1830:         LOCAL loc_lEmGravacaoAnt
1831: 
1832:         loc_lEmGravacaoAnt    = THIS.this_lEmGravacao
1833:         THIS.this_lEmGravacao = .T.
1834: 
1835:         *-- O modo volta a "" porque este form, diferente do legado (modal,
1836:         *-- um registro por vida), nao fecha entre uma operacao e outra: modo
1837:         *-- residual faria um LostFocus solto regravar (regra #32).
1838:         THIS.this_cModoAtual = ""
1839:         THIS.LimparCampos()
1840: 
1841:         *-- Fecha o painel e trava os campos pelo funil de modo (regra #40)
1842:         THIS.AjustarBotoesPorModo()
1843: 
1844:         *-- Legado: gridFollowup.Refresh. Recarrega do banco porque a gravacao
1845:         *-- (quando houve) foi INSERT/UPDATE em SigCheh, nao edicao de cursor.
1846:         *-- CarregarLista fecha chamando RepintarGrade (GO TOP + Refresh -
1847:         *-- regra #21a).
1848:         THIS.CarregarLista()
1849: 
1850:         *-- Legado: GridFollowup.Column1.SetFocus
1851:         THIS.FocarCelulaHistorico()
1852: 
1853:         THIS.this_lEmGravacao = loc_lEmGravacaoAnt
1854:     ENDPROC
1855: 
1856:     *==========================================================================
1857:     * BtnExcluirClick - cmdApagar.Click (Buttons(1) de cmg_4c_CmdApagaitem).
1858:     * Legado (SIGOPCFL.cmdApagaitem.cmdApagar.Click):
1859:     *     Select CrSigCheh
1860:     *     If !Eof()
1861:     *         If !CrSigCheH.Autos .or. IsEmpty(CrSigCheh.Hists) Or IsEmpty(CrSigCheh.Datas)
1862:     *             pchave = CrSigCheh.CidChaves
1863:     *             lcDelete = [ Delete From SigCheh Where CidChaves = ']+pChave+[']
1864:     *             lnErro = ThisForm.poDatamgr.SqlExecute(lcDelete,'')
1865:     *             If lnErro > 0
1866:     *                 ThisForm.poDatamgr.Commit() / Select CrSigCheh / Delete / Skip / Skip -1
1867:     *             Else
1868:     *                 MessageBox('Favor Reiniciar o Processo !!!',0+48,'Falha na Conexao')
1869:     *             Endif

*-- Linhas 1881 a 1979:
1881:     * recusaria com "Nao ha registro para excluir" mesmo com uma linha
1882:     * valida selecionada (regra #32 - form nao fecha entre operacoes).
1883:     *==========================================================================
1884:     PROCEDURE BtnExcluirClick()
1885:         LOCAL loc_oBO
1886: 
1887:         *-- Legado: 'Select CrSigCheh / If !Eof()' - sem linha corrente o
1888:         *-- Click nao faz nada (nem avisa). TemLinhaSelecionada usa IFs
1889:         *-- aninhados porque VFP9 nao faz short-circuit.
1890:         IF THIS.TemLinhaSelecionada()
1891:             loc_oBO = THIS.this_oBusinessObject
1892:             IF VARTYPE(loc_oBO) = "O"
1893:                 loc_oBO.CancelarEdicao()
1894:                 loc_oBO.CarregarDoCursor("cursor_4c_Dados")
1895:                 THIS.this_oBusinessObject.Excluir()
1896:             ENDIF
1897: 
1898:             *-- Legado: Select CrSigCheH / gridFollowup.Refresh /
1899:             *-- Column1.Text1.Setfocus - sempre, mesmo quando o BO recusou a
1900:             *-- exclusao (ja avisou na MsgAviso do ExecutarExclusao).
1901:             THIS.CarregarLista()
1902:             THIS.FocarCelulaHistorico()
1903:         ENDIF
1904:     ENDPROC
1905: 
1906:     *==========================================================================
1907:     * BtnEncerrarClick - Commandgroup1.Command1.Valid do legado:
1908:     *     ThisForm.Release
1909:     * PUBLIC: ligado por BINDEVENT em ConfigurarSaida (regra #3).
1910:     *==========================================================================
1911:     PROCEDURE BtnEncerrarClick()
1912:         THIS.Release()
1913:     ENDPROC
1914: 
1915:     *==========================================================================
1916:     * TornarControlesVisiveis - AddObject cria filhos com Visible=.F.; forca
1917:     * Visible=.T. recursivamente, EXCETO cnt_4c__inserir, que nasce oculto
1918:     * de proposito (painel flutuante de Incluir/Alterar - regra #40).
1919:     *==========================================================================
1920:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1921:         LOCAL loc_nI, loc_oControl
1922: 
1923:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1924:             loc_oControl = par_oContainer.Controls(loc_nI)
1925: 
1926:             IF VARTYPE(loc_oControl) = "O"
1927:                 IF UPPER(loc_oControl.Name) = "CNT_4C__INSERIR"
1928:                     *-- O container nasce oculto de proposito, mas os FILHOS
1929:                     *-- dele precisam de Visible=.T. - senao, quando o botao
1930:                     *-- Incluir/Alterar tornar o painel visivel, ele aparece
1931:                     *-- VAZIO (pattern #109).
1932:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1933:                         THIS.TornarControlesVisiveis(loc_oControl)
1934:                     ENDIF
1935:                     LOOP
1936:                 ENDIF
1937: 
1938:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1939:                     loc_oControl.Visible = .T.
1940:                 ENDIF
1941: 
1942:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1943:                     THIS.TornarControlesVisiveis(loc_oControl)
1944:                 ENDIF
1945:             ENDIF
1946:         ENDFOR
1947:     ENDPROC
1948: 
1949:     *==========================================================================
1950:     * Destroy - libera os cursores da tela antes de encadear para
1951:     * FormBase.Destroy():
1952:     *   cursor_4c_Dados    - placeholder da grade (criado em ConfigurarGrid)
1953:     *   cursor_4c_DadosTmp - temporario de CarregarLista (fechado la, repetido
1954:     *                        aqui para o caso de o metodo ter saido pelo CATCH)
1955:     *   cursor_4c_CflChe   - temporarios de SigOpCflBO.CarregarCabecalho, que
1956:     *   cursor_4c_CflCli     os fecha sozinho; mesma razao do anterior
1957:     * SEM TABLEREVERT: todos nascem com Buffering = 1 (CREATE CURSOR e cursor
1958:     * de SQLEXEC), onde TABLEREVERT estoura erro 1586, e USE IN fecha o alias
1959:     * de qualquer jeito (regra #52).
1960:     * DODEFAULT() eh a ULTIMA linha: eh FormBase.Destroy que reconstroi os
1961:     * popups do menu principal - sem ele os menus aparecem encolhidos.
1962:     *==========================================================================
1963:     PROCEDURE Destroy()
1964:         IF USED("cursor_4c_Dados")
1965:             USE IN cursor_4c_Dados
1966:         ENDIF
1967:         IF USED("cursor_4c_DadosTmp")
1968:             USE IN cursor_4c_DadosTmp
1969:         ENDIF
1970:         IF USED("cursor_4c_CflChe")
1971:             USE IN cursor_4c_CflChe
1972:         ENDIF
1973:         IF USED("cursor_4c_CflCli")
1974:             USE IN cursor_4c_CflCli
1975:         ENDIF
1976:         DODEFAULT()
1977:     ENDPROC
1978: 
1979: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCflBO.prg):
*==============================================================================
* SIGOPCFLBO.PRG
* Business Object para Consulta de FollowUp de Cheques (SigOpCfl)
* Tabela principal: SigCheh (historico de followup do cheque)
* Tabelas auxiliares (somente leitura, cabecalho do form): SigChe, SigCdCli
*==============================================================================

DEFINE CLASS SigOpCflBO AS BusinessBase

    *-- Propriedades da entidade SigCheh (historico de followup)
    this_cCidChaves = ""            && SigCheh.cidchaves - chave primaria (char 20)
    this_cNums = ""                 && SigCheh.nums / SigChe.nums - numero do titulo (parametro "conta" do legado)
    this_dDatas = {}                && SigCheh.datas - data/hora do lancamento de followup
    this_cEmps = ""                 && SigCheh.emps - empresa
    this_cHists = ""                && SigCheh.hists - observacao do followup
    this_nNumlotes = 0              && SigCheh.numlotes
    this_lAutos = .F.               && SigCheh.autos - .T. quando o historico foi gerado automaticamente

    *-- Propriedades auxiliares de cabecalho (somente leitura - SigChe/SigCdCli)
    this_cIclis = ""                && SigCdCli.iclis - codigo do cliente/emissor do cheque
    this_cRclis = ""                && SigCdCli.rclis - razao/nome do cliente
    this_cBancos = ""                && SigChe.bancos - codigo do banco
    this_cAgencias = ""             && SigChe.agencias - agencia
    this_cNContas = ""              && SigChe.ncontas - conta bancaria
    this_cNCheques = ""             && SigChe.ncheques - numero do cheque

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigCheh"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *==========================================================================
    * LimparDados - Reseta as propriedades da entidade (NovoRegistro/CancelarEdicao)
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves = ""
        THIS.this_cNums      = ""
        THIS.this_dDatas     = {}
        THIS.this_cEmps      = ""
        THIS.this_cHists     = ""
        THIS.this_nNumlotes  = 0
        THIS.this_lAutos     = .F.
    ENDPROC

    *==========================================================================
    * InicializarValoresPadrao - Defaults do ramo pcEscolha = 'INSERIR' do
    * legado (cmdApagaitem.Click): GetData.Value = DateTime(), Hists em branco.
    * Autos sempre .F. - followup manual nunca nasce como automatico.
    *==========================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_dDatas    = DATETIME()
        THIS.this_lAutos    = .F.
        THIS.this_nNumlotes = 0
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria (cidchaves) para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor de
    * SigCheh (crSigCheh/cursor_4c_Dados)
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    * PUBLIC de proposito (regra #51): o form chama este metodo de FORA, em
    * BtnExcluirClick (loc_oBO.CarregarDoCursor("cursor_4c_Dados")). Como
    * BusinessBase.CarregarDoCursor eh PUBLIC, declarar PROTECTED aqui faria
    * a chamada estourar em RUNTIME com "Property CARREGARDOCURSOR is not
    * found." ao clicar Excluir - compila limpo. NAO reintroduzir PROTECTED.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                THIS.this_cNums      = TratarNulo(nums,      "")
                THIS.this_dDatas     = TratarNulo(datas,     {})
                THIS.this_cEmps      = TratarNulo(emps,      "")
                THIS.this_cHists     = TratarNulo(hists,     "")
                THIS.this_nNumlotes  = TratarNulo(numlotes,  0)
                THIS.this_lAutos     = TratarNulo(autos,     .F.)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigOpCflBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Regra de gravacao do legado, em FONTE UNICA.
    * O legado so grava quando a observacao esta preenchida:
    *     If !Empty(This.Value)   (GetHist.LostFocus)
    * e o followup pertence SEMPRE a um cheque (SigCheh.nums -> SigChe.nums,
    * char(8) NOT NULL): sem o numero do cheque o registro nasceria orfao.
    * Chamado por BusinessBase.Salvar(), que exibe a falha sozinho via
    * ExibirFalha() quando este metodo devolve .F. - por isso aqui so se
    * preenche this_cMensagemErro, sem MsgAviso proprio (regra #20).
    * PUBLIC (sem modificador): BusinessBase.ValidarDados tambem eh PUBLIC e
    * em VFP9 PROTECTED em QUALQUER nivel da heranca ja bloqueia a chamada
    * externa (regra #51).
    *==========================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .F.

        THIS.this_cMensagemErro = ""

        DO CASE
        CASE EMPTY(ALLTRIM(THIS.this_cNums))
            THIS.this_cMensagemErro = "Cheque n" + CHR(227) + "o informado - " + ;
                "n" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel gravar " + ;
                "followup sem o t" + CHR(237) + "tulo de origem."
        CASE EMPTY(ALLTRIM(THIS.this_cHists))
            THIS.this_cMensagemErro = "Observa" + CHR(231) + CHR(227) + "o " + ;
                "necessita ser preenchida."
        OTHERWISE
            loc_lValido = .T.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * CarregarHistorico - Consulta o historico de followup do cheque e devolve
    * as linhas em par_cCursorDestino (cursor TEMPORARIO do chamador, que
    * depois faz ZAP + APPEND FROM DBF() no alias ligado ao Grid - SQLEXEC
    * sobre o alias do Grid zera o ColumnCount).
    * Legado (SIGOPCFL.Init):
    *     lcQueryCheh = [Select * From SigCheh Where Nums = ?lcNum ]
    *     .AddCursor('SigCheh','CidChaves','CrSigCheh','','',lcQueryCheh)
    *     =ThisForm.Podatamgr.Requery('CrSigCheh')
    * O filtro eh aplicado SEMPRE, inclusive com Nums vazio - a consulta nao
    * casa nada e a grade abre vazia, de proposito (regra #35a).
    * A lista de colunas (nome E ordem) eh IDENTICA a de CarregarDoCursor e a
    * do CREATE CURSOR do form - APPEND FROM casa por NOME.
    * Devolve .T. quando a consulta rodou (inclusive com ZERO linhas: lista
    * vazia nao eh erro) e .F. quando o SQL Server recusou.
    * PUBLIC: o form chama de FORA, em CarregarLista (regra #51).
    *==========================================================================
    PROCEDURE CarregarHistorico(par_cNums, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Fecha o destino antes do SQLEXEC. O TABLEREVERT vai guardado
            *-- pelo Buffering: cursor com Buffering = 1 (o default de
            *-- CREATE CURSOR e de cursor de SQLEXEC) faz TABLEREVERT estourar
            *-- erro 1586 "Function requires row or table buffering mode", e
            *-- USE IN fecha o alias de qualquer jeito (regra #52).
            IF USED(par_cCursorDestino)
                IF CURSORGETPROP("Buffering", par_cCursorDestino) > 1
                    TABLEREVERT(.T., par_cCursorDestino)
                ENDIF
                USE IN (par_cCursorDestino)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
SELECT cidchaves, nums, datas, emps, hists, numlotes, autos
  FROM SigCheh
 WHERE nums = <<EscaparSQL(LEFT(par_cNums, 8))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar o hist" + CHR(243) + ;
                    "rico do cheque:" + CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "SigOpCflBO.CarregarHistorico")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar hist" + CHR(243) + "rico:" + CHR(13) + ;
                loException.Message, "SigOpCflBO.CarregarHistorico")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCabecalho - Carrega os dados FIXOS do cheque consultado nas
    * propriedades auxiliares (somente leitura) deste BO.
    * Legado (SIGOPCFL.Init):
    *     =ThisForm.Podatamgr.Cursorquery('SigChe','CrTmpChe','Nums',lcNum)
    *     =ThisForm.Podatamgr.Cursorquery('SigCdCli','CrTmpCli','Iclis',CrTmpChe.Iclis)
    * O cliente so eh consultado quando o cheque traz Iclis preenchido - eh o
    * encadeamento do legado, nao uma otimizacao.
    * PUBLIC: o form chama de FORA, em CarregarCabecalhoCheque (regra #51).
    *==========================================================================
    PROCEDURE CarregarCabecalho(par_cNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cIclis    = ""
            THIS.this_cRclis    = ""
            THIS.this_cBancos   = ""
            THIS.this_cAgencias = ""
            THIS.this_cNContas  = ""
            THIS.this_cNCheques = ""

            IF USED("cursor_4c_CflChe")
                USE IN cursor_4c_CflChe
            ENDIF
            IF USED("cursor_4c_CflCli")
                USE IN cursor_4c_CflCli
            ENDIF

            loc_cSQL = "SELECT iclis, bancos, agencias, ncontas, ncheques" + ;
                " FROM SigChe WHERE nums = " + EscaparSQL(LEFT(par_cNums, 8))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CflChe")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao carregar os dados do cheque:" + ;
                    CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "SigOpCflBO.CarregarCabecalho")
            ELSE
                *-- IFs ANINHADOS de proposito: VFP9 nao faz short-circuit,
                *-- entao 'USED(x) AND RECCOUNT(x) > 0' avaliaria o RECCOUNT
                *-- mesmo com o alias fechado e estouraria "Alias is not found".
                IF USED("cursor_4c_CflChe")
                    IF RECCOUNT("cursor_4c_CflChe") > 0
                        SELECT cursor_4c_CflChe
                        GO TOP

                        THIS.this_cIclis    = TratarNulo(iclis,    "")
                        THIS.this_cBancos   = TratarNulo(bancos,   "")
                        THIS.this_cAgencias = TratarNulo(agencias, "")
                        THIS.this_cNContas  = TratarNulo(ncontas,  "")
                        THIS.this_cNCheques = TratarNulo(ncheques, "")

                        loc_lSucesso = .T.

                        IF !EMPTY(ALLTRIM(THIS.this_cIclis))
                            loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + ;
                                EscaparSQL(THIS.this_cIclis)

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CflCli")

                            IF loc_nResultado >= 0 AND USED("cursor_4c_CflCli")
                                IF RECCOUNT("cursor_4c_CflCli") > 0
                                    SELECT cursor_4c_CflCli
                                    GO TOP
                                    THIS.this_cRclis = TratarNulo(rclis, "")
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_CflChe")
                USE IN cursor_4c_CflChe
            ENDIF
            IF USED("cursor_4c_CflCli")
                USE IN cursor_4c_CflCli
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar cabe" + CHR(231) + "alho do cheque:" + ;
                CHR(13) + loException.Message, "SigOpCflBO.CarregarCabecalho")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Inclui novo registro de followup em SigCheh
    * Espelha o ramo pcEscolha = 'INSERIR' do GetHist.LostFocus legado: gera a
    * chave com fUniqueIds() e grava Nums/Datas/Emps/CidChaves/Hists. Autos
    * sempre 0 (bit) - followup manual nunca nasce automatico.
    *==========================================================================
    FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCheh (cidchaves, nums, datas, emps, hists, autos, numlotes)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(LEFT(THIS.this_cNums, 8))>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cHists, 76))>>,
                    0,
                    <<FormatarNumeroSQL(THIS.this_nNumlotes, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao incluir followup:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigOpCflBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Atualiza registro de followup existente em SigCheh
    * Espelha o ramo pcEscolha = 'ALTERAR' do legado: so o historico (Hists)
    * eh regravado; Nums/Datas/Emps/Autos do registro original sao preservados.
    *==========================================================================
    FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCheh
                SET hists = <<EscaparSQL(LEFT(THIS.this_cHists, 76))>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar followup:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigOpCflBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - Exclui registro de followup de SigCheh
    * Guarda do legado (cmdApagaitem.Click): so permite excluir quando o
    * historico NAO foi gerado automaticamente (Autos = .F.) OU quando
    * Hists/Datas estao vazios. Historico automatico com Hists/Datas
    * preenchidos NAO pode ser excluido ("Historico automatico!!!").
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.this_lAutos AND !EMPTY(THIS.this_cHists) AND !EMPTY(THIS.this_dDatas)
                MsgAviso("Hist" + CHR(243) + "rico autom" + CHR(225) + "tico !!!", ;
                    "Imposs" + CHR(237) + "vel")
            ELSE
                loc_cSQL = "DELETE FROM SigCheh WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir followup:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigOpCflBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

