# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (8)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarTamanhoGridExec()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarPercGridExec()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarValorGridExec()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.GravarCelulaNumericaExec()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ResolverTamanhoSelecionado()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupTamanho()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprtam.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1798 linhas total):

*-- Linhas 25 a 83:
25: * obrigatorio e o Form sempre busca os dados do produto e da grade pelo BO.
26: *
27: * Uso canonico (a partir do FormProduto):
28: *   loForm = CREATEOBJECT("Formsigprtam", THISFORM, THIS.this_cEscolha, loc_cCodProduto)
29: *   IF VARTYPE(loForm) = "O"
30: *       loForm.Show()
31: *   ENDIF
32: *
33: * O legado eh aberto por "Do Form SigPrTam With Thisform, ThisForm.DataSessionId,
34: * ThisForm.pcEscolha" (SIGCDPRO.Pagina.Dados.pgframeDados.pgDados.cmdTamanho.
35: * btnTam.Valid) - sem o codigo do produto, porque la ele vinha do cursor
36: * crSigCdPro compartilhado pela DataSessionId. No sistema novo nao se
37: * compartilha cursor entre forms, entao o 3o argumento (par_cCodProduto)
38: * substitui o pnDataSes do legado e eh OBRIGATORIO. O btnTam.When do legado
39: * libera o botao em INSERIR, ALTERAR e CONSULTAR - em CONSULTAR o dialogo abre
40: * somente-leitura (ver AjustarVisibilidadePorModo).
41: *
42: * COBERTURA DOS 15 METODOS DO SCX LEGADO (SECAO 3 do dump):
43: *   SIGPRTAM.Init                   -> Init + InicializarForm
44: *   Grade.Column1.Text1.When        -> CelulaGradeEditavel("COD")
45: *   Grade.Column1.Text1.Valid       -> ValidarCelulaGradeExec -> ValidarTamanhoGridExec(,"cods")
46: *   Grade.Column2.Text1.When        -> CelulaGradeEditavel("DESC")
47: *   Grade.Column2.Text1.Valid       -> ValidarCelulaGradeExec -> ValidarTamanhoGridExec(,"descs")
48: *   Grade.Column3.Text1.When        -> CelulaGradeEditavel("PESO")
49: *   Grade.Column4.Text1.When        -> CelulaGradeEditavel("PERC")
50: *   Grade.Column4.Text1.Valid       -> ValidarCelulaGradeExec -> ValidarPercGridExec
51: *   Grade.Column5.Text1.When        -> CelulaGradeEditavel("VALOR")
52: *   Grade.Column5.Text1.Valid       -> ValidarCelulaGradeExec -> ValidarValorGridExec
53: *   Grade.Column6.Text1.When        -> CelulaGradeEditavel("PRAZO")
54: *   cmdInserir.Click                -> BtnInserirClick
55: *   cmdExcluir.Click                -> BtnExcluirClick
56: *   cmdSair.Click                   -> BtnSairClick (+ Destroy reabilita o pai)
57: *   SIGPRTAM.Load                   -> NAO PORTADO - ver (a)
58: *
59: * (a) Load: "=fConfigGeral()". fConfigGeral era funcao GLOBAL da aplicacao
60: *     legado Fortyus, chamada no Load de praticamente todo form so para
61: *     garantir que a configuracao do sistema estivesse carregada. O wrapper
62: *     projeto\app\utils\fconfiggeral.prg existe APENAS para o p-code dos VCX
63: *     legado, que a chamam de dentro de binario que nao da para editar - em
64: *     codigo NOSSO nunca se chama fConfigGeral. Chama-la daqui sugeriria que
65: *     falta alguma inicializacao global: o que fConfigGeral fazia esta
66: *     distribuido em config.prg/main.prg e ja ocorreu ANTES deste dialogo
67: *     existir. Mesmo tratamento registrado em FormSigMvExp (task570),
68: *     FormSigMvMen, FormSigMvPdt, FormSigMvSbn e FormSIGMVTI2.
69: *
70: * Contrato com o form PAI (equivalente a houveincl/houveexcl do legado):
71: * this_lHouveIncl e this_lHouveExcl ficam ligados quando houve inclusao ou
72: * exclusao de tamanho. Sao PROPERTIES publicas de proposito - quem abriu o
73: * dialogo pode ler as duas DEPOIS do Show() (que eh modal e so retorna com a
74: * tela fechada) para decidir se precisa recarregar a propria grade, igual ao
75: * ".Parentform.ProcTam" que o Init legado consultava.
76: *==============================================================================
77: 
78: DEFINE CLASS Formsigprtam AS FormBase
79: 
80:     *--------------------------------------------------------------------------
81:     * Propriedades visuais (PILAR 1 - UX FIDELITY)
82:     * Dimensoes originais do SCX: Width=638, Height=540
83:     *--------------------------------------------------------------------------

*-- Linhas 167 a 339:
167: 
168:     *--------------------------------------------------------------------------
169:     * Init - Recebe o contexto do form pai e inicializa
170:     * Armazena os parametros ANTES de DODEFAULT (InicializarForm precisa deles)
171:     *--------------------------------------------------------------------------
172:     PROCEDURE Init(par_oFormPai, par_cEscolha, par_cCodProduto)
173:         LOCAL loc_lSucesso, loc_oErro
174:         loc_lSucesso = .F.
175: 
176:         TRY
177:             IF VARTYPE(par_oFormPai) = "O"
178:                 THIS.this_oFormPai = par_oFormPai
179:                 THIS.this_oFormPai.Enabled = .F.
180:             ENDIF
181: 
182:             IF VARTYPE(par_cEscolha) = "C"
183:                 THIS.this_cEscolha = UPPER(ALLTRIM(par_cEscolha))
184:             ENDIF
185: 
186:             *-- O legado decide tudo por InList(pcEscolha,'INSERIR','ALTERAR'),
187:             *-- mas o modo de inclusao do form pai (FormProduto) chama-se
188:             *-- "INCLUIR" no sistema novo. Traduzido uma vez aqui, no funil de
189:             *-- entrada, para que o resto do form possa comparar contra os
190:             *-- nomes do legado como estao (mesmo padrao de FormSigPrCar.Init).
191:             IF THIS.this_cEscolha == "INCLUIR"
192:                 THIS.this_cEscolha = "INSERIR"
193:             ENDIF
194: 
195:             IF VARTYPE(par_cCodProduto) = "C"
196:                 THIS.this_cCodProduto = ALLTRIM(par_cCodProduto)
197:             ENDIF
198: 
199:             loc_lSucesso = DODEFAULT()
200:         CATCH TO loc_oErro
201:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
202:                     " PROC=" + loc_oErro.Procedure, "Formsigprtam.Init")
203:         ENDTRY
204: 
205:         RETURN loc_lSucesso
206:     ENDPROC
207: 
208:     *--------------------------------------------------------------------------
209:     * InicializarForm - Hook chamado por FormBase.Init() via DODEFAULT()
210:     * Cria o Business Object e monta o cabecalho. Grade e botoes sao
211:     * construidos/carregados nas proximas fases.
212:     *--------------------------------------------------------------------------
213:     PROTECTED PROCEDURE InicializarForm()
214:         LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste
215:         loc_lSucesso = .F.
216:         loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
217:                                     (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
218: 
219:         TRY
220:             *-- DataSession = 2 nasce com os SETs no DEFAULT do VFP, NAO com os
221:             *-- do config.prg. Sem DELETED ON, o DELETE local do BtnExcluirClick
222:             *-- (linha em branco nunca gravada) marca a linha mas ela CONTINUA
223:             *-- aparecendo na grade - o usuario clica Excluir e nada some.
224:             SET DELETED ON
225:             SET EXACT ON
226: 
227:             *-- Produto ausente eh erro de USO (o dialogo so existe para um
228:             *-- produto), mas NAO em modo validacao/teste - o harness instancia
229:             *-- o form sem argumento nenhum so para montar a UI.
230:             IF EMPTY(THIS.this_cCodProduto) AND !loc_lModoValidacaoOuTeste
231:                 MsgErro("Produto n" + CHR(227) + "o informado para gerenciar " + ;
232:                         "tamanhos.", "Erro Formsigprtam")
233:             ELSE
234:                 THIS.this_oBusinessObject = CREATEOBJECT("sigprtamBO")
235: 
236:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
237:                     MsgErro("Erro ao criar Business Object de Tamanhos do Produto." + CHR(13) + ;
238:                             "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
239:                 ELSE
240:                     *-- Dados do produto (Dpros/PVens/PCuss), usados pelo calculo
241:                     *-- Percentual<->Valor das celulas da grade - pulado em modo
242:                     *-- teste/validacao de UI (sem conexao SQL disponivel)
243:                     IF !loc_lModoValidacaoOuTeste
244:                         THIS.CarregarDadosProduto()
245:                     ENDIF
246: 
247:                     *-- Fundo (Picture) e Shape1 decorativo do topo (fiel ao SCX)
248:                     THIS.ConfigurarDecoracao()
249: 
250:                     *-- Cabecalho cinza (cntSombra do legado)
251:                     THIS.ConfigurarCabecalho()
252: 
253:                     *-- Grade (Column1..Column6) - so estrutura, sem
254:                     *-- ControlSource ainda (cursor_4c_Dados so existe depois
255:                     *-- do CarregarLista - regra #41)
256:                     THIS.ConfigurarGrid()
257: 
258:                     *-- Celulas da grade com When/Valid proprios: lookup de
259:                     *-- Tamanho (Column1/Column2), calculo Percentual<->Valor
260:                     *-- (Column4/Column5) e commit de Peso/Entrega
261:                     *-- (Column3/Column6)
262:                     THIS.InstalarCelulasGrade()
263: 
264:                     *-- Botoes de acao (cmd_4c_Inserir/cmd_4c_Excluir/cmd_4c_Sair)
265:                     *-- - criados DEPOIS do cabecalho para desenhar por cima dele
266:                     *-- (Top=3, dentro da faixa Top=0..80 - regra #11)
267:                     THIS.ConfigurarBotoes()
268: 
269:                     *-- AddObject cria controles com Visible=.F. por padrao
270:                     THIS.TornarControlesVisiveis()
271: 
272:                     *-- Espelha llVis do Init legado - tem que rodar DEPOIS do
273:                     *-- TornarControlesVisiveis, senao a visibilidade generica
274:                     *-- sobrescreve o Inserir/Excluir escondidos em modo consulta
275:                     THIS.AjustarVisibilidadePorModo()
276: 
277:                     *-- Popula a grade (pulado em modo teste/validacao de UI)
278:                     IF !loc_lModoValidacaoOuTeste
279:                         THIS.CarregarLista()
280:                     ENDIF
281: 
282:                     loc_lSucesso = .T.
283:                 ENDIF
284:             ENDIF
285:         CATCH TO loc_oErro
286:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
287:                     " PROC=" + loc_oErro.Procedure, "Erro ao inicializar Formsigprtam")
288:         ENDTRY
289: 
290:         RETURN loc_lSucesso
291:     ENDPROC
292: 
293:     *--------------------------------------------------------------------------
294:     * ConfigurarCabecalho - Container de cabecalho cinza (cntSombra do legado)
295:     * Equivalente: SIGPRTAM.cntSombra + lblSombra + lblTitulo
296:     * Regra #11/#12: Width = THIS.Width (nao o literal do SCX, que excede o
297:     * form); label Width = THIS.Width - 20 para nao clipar o titulo.
298:     *--------------------------------------------------------------------------
299:     PROTECTED PROCEDURE ConfigurarCabecalho()
300:         THIS.AddObject("cnt_4c_Sombra", "Container")
301:         WITH THIS.cnt_4c_Sombra
302:             .Top         = 0
303:             .Left        = 0
304:             .Width       = THIS.Width
305:             .Height      = 80
306:             .BorderWidth = 0
307:             .BackStyle   = 1
308:             .BackColor   = RGB(100, 100, 100)
309:             .Visible     = .T.
310:         ENDWITH
311: 
312:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
313:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
314:             .AutoSize      = .F.
315:             .FontBold      = .T.
316:             .FontName      = "Tahoma"
317:             .FontSize      = 18
318:             .FontUnderline = .F.
319:             .WordWrap      = .T.
320:             .Alignment     = 0
321:             .BackStyle     = 0
322:             .Caption       = THIS.Caption
323:             .Height        = 40
324:             .Left          = 10
325:             .Top           = 25
326:             .Width         = THIS.Width - 20
327:             .ForeColor     = RGB(0, 0, 0)
328:             .Visible       = .T.
329:         ENDWITH
330: 
331:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
332:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
333:             .AutoSize      = .F.
334:             .FontBold      = .T.
335:             .FontName      = "Tahoma"
336:             .FontSize      = 18
337:             .WordWrap      = .T.
338:             .Alignment     = 0
339:             .BackStyle     = 0

*-- Linhas 353 a 427:
353:     * dos botoes de acao (Top=12, Left=372, Width=256, Height=110,
354:     * BackStyle=0, BorderStyle=0 - transparente, fiel ao SCX legado).
355:     *--------------------------------------------------------------------------
356:     PROTECTED PROCEDURE ConfigurarDecoracao()
357:         LOCAL loc_cImgFundo
358: 
359:         *-- Picture = ..\framework\imagens\new_background.jpg (SIGPRTAM original).
360:         *-- TYPE() antes de usar a global: harness de validacao de UI nao roda
361:         *-- config.prg e nao declara gc_4c_CaminhoFramework.
362:         IF TYPE("gc_4c_CaminhoFramework") = "C"
363:             loc_cImgFundo = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
364:             IF FILE(loc_cImgFundo)
365:                 THIS.Picture = loc_cImgFundo
366:             ENDIF
367:         ENDIF
368: 
369:         THIS.AddObject("shp_4c_Shape1", "Shape")
370:         WITH THIS.shp_4c_Shape1
371:             .Top         = 12
372:             .Left        = 372
373:             .Height      = 110
374:             .Width       = 256
375:             .BackStyle   = 0
376:             .BorderStyle = 0
377:             .BorderColor = RGB(136, 189, 188)
378:         ENDWITH
379:     ENDPROC
380: 
381:     *--------------------------------------------------------------------------
382:     * ConfigurarGrid - Grade (Grade do legado): Column1=CodTams, Column2=Descs,
383:     * Column3=PesoMs, Column4=Percs, Column5=Valor, Column6=DiasPrz.
384:     * Dimensoes/mascaras EXATAS do SCX (form flat 638x540, sem PageFrame - nao
385:     * ha compensacao de offset a aplicar aqui).
386:     *--------------------------------------------------------------------------
387:     PROTECTED PROCEDURE ConfigurarGrid()
388:         THIS.AddObject("grd_4c_Dados", "Grid")
389:         WITH THIS.grd_4c_Dados
390:             .Top                = 111
391:             .Left               = 9
392:             .Width              = 620
393:             .Height             = 394
394:             .FontName           = "Tahoma"
395:             .FontSize           = 8
396:             .AllowHeaderSizing  = .F.
397:             .AllowRowSizing     = .F.
398:             .AllowCellSelection = .T.
399:             .DeleteMark         = .F.
400:             .RecordMark         = .F.
401:             .RowHeight          = 17
402:             .ScrollBars         = 2
403:             .GridLineColor      = RGB(238, 238, 238)
404:             .ColumnCount        = 6
405: 
406:             *-- Column1 = CodTams (SigPrTam.codtams char(4) - FK SigCdTam.cods)
407:             .Column1.FontName          = "Tahoma"
408:             .Column1.FontSize          = 8
409:             .Column1.Width             = 38
410:             .Column1.Movable           = .F.
411:             .Column1.Resizable         = .F.
412:             .Column1.Header1.FontName  = "Tahoma"
413:             .Column1.Header1.FontSize  = 8
414:             .Column1.Header1.Alignment = 2
415:             .Column1.Header1.Caption   = "Tam."
416:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
417:             .Column1.Text1.FontName    = "Tahoma"
418:             .Column1.Text1.FontSize    = 8
419:             .Column1.Text1.Margin      = 0
420:             .Column1.Text1.MaxLength   = 4
421: 
422:             *-- Column2 = Descs (vem de SigCdTam.descs char(20) via lookup)
423:             .Column2.FontName          = "Tahoma"
424:             .Column2.FontSize          = 8
425:             .Column2.Width             = 216
426:             .Column2.Movable           = .F.
427:             .Column2.Resizable         = .F.

*-- Linhas 515 a 570:
515:     *
516:     * No legado cada Column<N>.Text1 tem o seu When (gate de modo) e, nas
517:     * colunas de lookup (Column1/Column2) e de calculo (Column4/Column5), o
518:     * seu Valid. BINDEVENT em evento de celula de Grid nao eh confiavel
519:     * (regra #46): a validacao de celula tem de viver no Valid do TextBox da
520:     * coluna. Column.AddObject sozinho NAO exibe o controle - exige
521:     * CurrentControl + Sparse = .F. (regra #18).
522:     *
523:     * Chamado em ConfigurarGrid (criacao) e DE NOVO no fim de CarregarLista:
524:     * o BO recria cursor_4c_Dados (USE IN + SQLEXEC + INTO CURSOR), e
525:     * re-vincular RecordSource/ControlSource reseta propriedades de Column -
526:     * CurrentControl e Sparse entre elas. O AddObject so acontece na primeira
527:     * vez (PEMSTATUS): repetir AddObject com o mesmo nome estoura "Object is
528:     * already defined".
529:     *--------------------------------------------------------------------------
530:     PROTECTED PROCEDURE InstalarCelulasGrade()
531:         LOCAL loc_oCol, loc_oTxt
532: 
533:         *-- Column1 = CodTams - lookup de tamanho por CODIGO (SigCdTam.cods)
534:         loc_oCol = THIS.grd_4c_Dados.Column1
535:         IF !PEMSTATUS(loc_oCol, "txt_4c_CelCodTam", 5)
536:             loc_oCol.AddObject("txt_4c_CelCodTam", "TextBoxCelulaTamanho_4c")
537:         ENDIF
538:         loc_oTxt = loc_oCol.txt_4c_CelCodTam
539:         WITH loc_oTxt
540:             .this_cPapel = "COD"
541:             .FontName    = "Tahoma"
542:             .FontSize    = 8
543:             .Margin      = 0
544:             .MaxLength   = 4
545:             .Visible     = .T.
546:         ENDWITH
547:         loc_oCol.CurrentControl = "txt_4c_CelCodTam"
548:         loc_oCol.Sparse         = .F.
549: 
550:         *-- Column2 = Descs - lookup de tamanho por DESCRICAO (SigCdTam.descs)
551:         loc_oCol = THIS.grd_4c_Dados.Column2
552:         IF !PEMSTATUS(loc_oCol, "txt_4c_CelDescTam", 5)
553:             loc_oCol.AddObject("txt_4c_CelDescTam", "TextBoxCelulaTamanho_4c")
554:         ENDIF
555:         loc_oTxt = loc_oCol.txt_4c_CelDescTam
556:         WITH loc_oTxt
557:             .this_cPapel = "DESC"
558:             .FontName    = "Tahoma"
559:             .FontSize    = 8
560:             .Margin      = 0
561:             .MaxLength   = 20
562:             .Visible     = .T.
563:         ENDWITH
564:         loc_oCol.CurrentControl = "txt_4c_CelDescTam"
565:         loc_oCol.Sparse         = .F.
566: 
567:         *-- Column3 = PesoMs - entrada numerica simples (legado so tem When)
568:         loc_oCol = THIS.grd_4c_Dados.Column3
569:         IF !PEMSTATUS(loc_oCol, "txt_4c_CelPeso", 5)
570:             loc_oCol.AddObject("txt_4c_CelPeso", "TextBoxCelulaTamanho_4c")

*-- Linhas 855 a 898:
855:             loc_nPerc  = 0
856: 
857:             IF EMPTY(THIS.this_nPrecoVenda)
858:                 MsgAviso("Favor Informar o Pre" + CHR(231) + "o de Venda do Produto.", "Aviso")
859:                 loc_nValor     = 0
860:                 par_oTxt.Value = loc_nValor
861:             ENDIF
862: 
863:             IF THIS.this_nPrecoVenda != 0
864:                 loc_nPerc = ((loc_nValor - THIS.this_nPrecoVenda) / THIS.this_nPrecoVenda) * 100
865:             ENDIF
866: 
867:             REPLACE valor WITH loc_nValor, percs WITH loc_nPerc IN cursor_4c_Dados
868:         ELSE
869:             REPLACE valor WITH loc_nValorCelula IN cursor_4c_Dados
870:         ENDIF
871: 
872:         THIS.this_nValorAnterior = IIF(VARTYPE(par_oTxt.Value) = "N", par_oTxt.Value, ;
873:                                        loc_nValorCelula)
874: 
875:         THIS.GravarLinhaAtual()
876:         THIS.grd_4c_Dados.Refresh()
877: 
878:         RETURN .T.
879:     ENDFUNC
880: 
881:     *--------------------------------------------------------------------------
882:     * GravarCelulaNumericaExec - Valid das celulas Peso Medio (Column3) e
883:     * Entrega (Column6). O legado nao tem Valid nelas: a gravacao vinha do
884:     * TABLEUPDATE do form pai, que compartilhava a DataSession. Aqui a
885:     * DataSession eh PRIVADA, entao a persistencia tem de ser explicita -
886:     * senao o que o usuario digita nessas duas colunas se perde ao encerrar.
887:     * PUBLIC - alvo do despachante (regra #3/#51).
888:     *--------------------------------------------------------------------------
889:     FUNCTION GravarCelulaNumericaExec(par_oTxt, par_cCampo)
890:         LOCAL loc_nValorCelula, loc_nAnterior, loc_lPeso
891: 
892:         loc_lPeso        = (VARTYPE(par_cCampo) = "C" AND UPPER(ALLTRIM(par_cCampo)) == "PESO")
893:         loc_nValorCelula = IIF(VARTYPE(par_oTxt.Value) = "N", par_oTxt.Value, ;
894:                                VAL(TRANSFORM(par_oTxt.Value)))
895:         loc_nAnterior    = IIF(loc_lPeso, THIS.this_nPesoAnterior, THIS.this_nPrazoAnterior)
896: 
897:         IF loc_nValorCelula = loc_nAnterior
898:             RETURN .T.

*-- Linhas 920 a 963:
920:     * de AbrirLookupTamanho) cobre as duas entradas.
921:     * PUBLIC - chamado pela classe da celula (regra #3/#51).
922:     *--------------------------------------------------------------------------
923:     PROCEDURE AbrirLookupTamanhoGrade(par_cPapel, par_oTxt)
924:         LOCAL loc_cCampoBusca, loc_cCidChaves, loc_cValor
925: 
926:         IF VARTYPE(par_oTxt) != "O" OR !USED("cursor_4c_Dados")
927:             RETURN
928:         ENDIF
929: 
930:         IF EOF("cursor_4c_Dados")
931:             RETURN
932:         ENDIF
933: 
934:         IF !INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
935:             RETURN
936:         ENDIF
937: 
938:         loc_cCampoBusca = IIF(VARTYPE(par_cPapel) = "C" AND ;
939:                               UPPER(ALLTRIM(par_cPapel)) == "DESC", "descs", "cods")
940:         loc_cValor      = ALLTRIM(TRANSFORM(par_oTxt.Value))
941: 
942:         SELECT cursor_4c_Dados
943:         loc_cCidChaves = ALLTRIM(cidchaves)
944: 
945:         THIS.ResolverTamanhoSelecionado(loc_cValor, loc_cCidChaves, loc_cCampoBusca, par_oTxt)
946: 
947:         *-- Sincroniza o Tag: o Valid que vem logo a seguir (ao sair da
948:         *-- celula) nao pode reabrir o picker pelo valor que o F4 acabou de
949:         *-- resolver
950:         par_oTxt.Tag = ALLTRIM(TRANSFORM(par_oTxt.Value))
951: 
952:         THIS.grd_4c_Dados.Refresh()
953:     ENDPROC
954: 
955:     *--------------------------------------------------------------------------
956:     * ResolverTamanhoSelecionado - Tenta o match EXATO em SigCdTam (por cods
957:     * ou por descs, conforme par_cCampoBusca); sem match, abre o picker
958:     * (AbrirLookupTamanho). Com o tamanho resolvido, confere duplicidade
959:     * contra as demais linhas do MESMO produto antes de gravar - igual ao
960:     * "Select ... Where a.CodTams = CrListaRemota.Cods And a.cIdChaves <>
961:     * crSigPrTam.cIdChaves" dos dois Valid legado.
962:     *
963:     * Devolve .F. SO no caso de duplicidade, que eh o unico "Return .F." dos

*-- Linhas 1036 a 1105:
1036:         LOCATE FOR ALLTRIM(cidchaves) == ALLTRIM(par_cCidChaves)
1037: 
1038:         IF loc_lDuplicado
1039:             MsgAviso("Tamanho j" + CHR(225) + " informado para este produto!", ;
1040:                      "Aten" + CHR(231) + CHR(227) + "o")
1041:             *-- Legado: Return .F. - a linha NAO eh alterada e o foco fica na
1042:             *-- celula para o usuario corrigir
1043:             loc_lOk = .F.
1044:         ELSE
1045:             REPLACE codtams WITH loc_cCodigoSel, descs WITH loc_cDescrSel IN cursor_4c_Dados
1046: 
1047:             *-- O valor resolvido tem de voltar para a CELULA tambem, senao o
1048:             *-- texto digitado sobrescreve o cursor ao fim do Valid (regra #46)
1049:             IF VARTYPE(par_oTxt) = "O"
1050:                 par_oTxt.Value = IIF(loc_cCampoBusca == "descs", loc_cDescrSel, loc_cCodigoSel)
1051:             ENDIF
1052: 
1053:             *-- Grava em SigPrTam na hora (INSERT na linha nova, UPDATE na que
1054:             *-- veio do CarregarLista) - o legado delegava ao TABLEUPDATE do
1055:             *-- form pai; esta DataSession eh propria, entao a gravacao tem de
1056:             *-- ser explicita, senao a escolha do usuario se perde ao encerrar.
1057:             THIS.GravarLinhaAtual()
1058:         ENDIF
1059: 
1060:         RETURN loc_lOk
1061:     ENDFUNC
1062: 
1063:     *--------------------------------------------------------------------------
1064:     * AbrirLookupTamanho - Picker de tamanhos (SigCdTam) - transcricao do
1065:     *   CreateObject('fwbuscaext', <conn>, 'SigCdTam', 'CrListaRemota',
1066:     *                 'Cods'|'Descs', This.Value, 'Selecao', .t.)
1067:     * dos DOIS Valid do legado. Ao contrario do lookup de Caracteristicas
1068:     * (FormSigPrCar), o legado NAO filtra por grupo do produto aqui.
1069:     *--------------------------------------------------------------------------
1070:     PROTECTED FUNCTION AbrirLookupTamanho(par_cValorFiltro, par_cCampoBusca)
1071:         LOCAL loc_oBusca, loc_cSQL, loc_nResultado, loc_cCursor, loc_cCampo
1072:         LOCAL loc_lSelecionou, loc_cValor, loc_cTitulo, loc_oErro
1073: 
1074:         loc_lSelecionou = .F.
1075:         THIS.this_cLkpCodigo    = ""
1076:         THIS.this_cLkpDescricao = ""
1077: 
1078:         IF THIS.this_lLookupAberto
1079:             RETURN .F.
1080:         ENDIF
1081:         THIS.this_lLookupAberto = .T.
1082: 
1083:         loc_cCursor = "cursor_4c_BuscaTamanho"
1084:         loc_cValor  = IIF(VARTYPE(par_cValorFiltro) = "C", ALLTRIM(par_cValorFiltro), "")
1085:         loc_cCampo  = IIF(VARTYPE(par_cCampoBusca) = "C" AND LOWER(ALLTRIM(par_cCampoBusca)) == "descs", ;
1086:                           "descs", "cods")
1087:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"
1088: 
1089:         TRY
1090:             IF USED(loc_cCursor)
1091:                 USE IN SELECT(loc_cCursor)
1092:             ENDIF
1093: 
1094:             IF !EMPTY(loc_cValor)
1095:                 loc_cSQL = "SELECT cods AS Cods, descs AS Descs FROM SigCdTam" + ;
1096:                            " WHERE (cods LIKE " + EscaparSQL(loc_cValor + "%") + ;
1097:                            " OR descs LIKE " + EscaparSQL(loc_cValor + "%") + ")" + ;
1098:                            " ORDER BY " + loc_cCampo
1099:             ELSE
1100:                 loc_cSQL = "SELECT cods AS Cods, descs AS Descs FROM SigCdTam" + ;
1101:                            " ORDER BY " + loc_cCampo
1102:             ENDIF
1103: 
1104:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
1105: 

*-- Linhas 1117 a 1300:
1117:                 MsgErro("Erro ao consultar tamanhos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1118:             ELSE
1119:                 IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
1120:                     MsgAviso("Nenhum tamanho dispon" + CHR(237) + "vel.", loc_cTitulo)
1121:                 ELSE
1122:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1123: 
1124:                     IF VARTYPE(loc_oBusca) = "O"
1125:                         loc_oBusca.DefinirCursor(loc_cCursor, "Cods", "Descs", loc_cTitulo)
1126: 
1127:                         loc_oBusca.this_nColunas = 0
1128:                         IF loc_cCampo == "descs"
1129:                             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1130:                             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
1131:                         ELSE
1132:                             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
1133:                             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1134:                         ENDIF
1135: 
1136:                         IF loc_oBusca.Mostrar()
1137:                             THIS.this_cLkpCodigo    = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1138:                             THIS.this_cLkpDescricao = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
1139:                             loc_lSelecionou         = .T.
1140:                         ENDIF
1141: 
1142:                         loc_oBusca.Release()
1143:                         loc_oBusca = .NULL.
1144:                     ENDIF
1145:                 ENDIF
1146:             ENDIF
1147: 
1148:             IF USED(loc_cCursor)
1149:                 USE IN SELECT(loc_cCursor)
1150:             ENDIF
1151:         CATCH TO loc_oErro
1152:             MsgErro("Erro ao abrir a busca de tamanhos:" + CHR(13) + ;
1153:                     loc_oErro.Message + CHR(13) + ;
1154:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1155:                     "Procedure: " + loc_oErro.Procedure, "Erro")
1156:             IF USED(loc_cCursor)
1157:                 USE IN SELECT(loc_cCursor)
1158:             ENDIF
1159:         ENDTRY
1160: 
1161:         THIS.this_lLookupAberto = .F.
1162: 
1163:         RETURN loc_lSelecionou
1164:     ENDFUNC
1165: 
1166:     *--------------------------------------------------------------------------
1167:     * FormParaBO - Transfere a LINHA CORRENTE da grade para o BO. Reusa
1168:     * sigprtamBO.CarregarDoCursor (ja faz SELECT (alias) + TratarNulo campo a
1169:     * campo) em vez de duplicar a leitura aqui.
1170:     * PROTECTED por heranca de FormBase (regra #3/#51) - chamado so de dentro
1171:     * da classe (GravarLinhaAtual).
1172:     *--------------------------------------------------------------------------
1173:     PROTECTED PROCEDURE FormParaBO()
1174:         IF !USED("cursor_4c_Dados") OR VARTYPE(THIS.this_oBusinessObject) != "O"
1175:             RETURN .F.
1176:         ENDIF
1177: 
1178:         SELECT cursor_4c_Dados
1179:         IF EOF()
1180:             RETURN .F.
1181:         ENDIF
1182: 
1183:         RETURN THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
1184:     ENDPROC
1185: 
1186:     *--------------------------------------------------------------------------
1187:     * BOParaForm - Sentido inverso: escreve as propriedades do BO na LINHA
1188:     * CORRENTE da grade. Chamado depois de um Salvar() bem-sucedido, para a
1189:     * grade exibir o que o BO efetivamente levou ao banco (em especial o
1190:     * cidchaves, se o BO tiver precisado gera-lo).
1191:     * PROTECTED por heranca de FormBase - chamado so de dentro (GravarLinhaAtual).
1192:     *--------------------------------------------------------------------------
1193:     PROTECTED PROCEDURE BOParaForm()
1194:         IF !USED("cursor_4c_Dados") OR VARTYPE(THIS.this_oBusinessObject) != "O"
1195:             RETURN .F.
1196:         ENDIF
1197: 
1198:         SELECT cursor_4c_Dados
1199:         IF EOF()
1200:             RETURN .F.
1201:         ENDIF
1202: 
1203:         *-- Cobertura: as OITO colunas que ESTA tela pode alterar. As tres
1204:         *-- restantes de SigPrTam (dataalts/datatrans/dtmovs) ficam de fora
1205:         *-- DE PROPOSITO: nao tem controle na tela, o BO as le no
1206:         *-- CarregarDoCursor e as devolve INTACTAS no UPDATE/INSERT, logo
1207:         *-- reescreve-las no cursor seria no-op. Pior, a property e a coluna
1208:         *-- podem divergir de tipo (DATE vazia na linha nascida do APPEND
1209:         *-- BLANK x datetime do cursor), o que so criaria risco de "Data type
1210:         *-- mismatch" sem nada em troca.
1211:         WITH THIS.this_oBusinessObject
1212:             REPLACE cidchaves WITH .this_cCidChaves, ;
1213:                     codtams   WITH .this_cCodTams, ;
1214:                     cpros     WITH .this_cCpros, ;
1215:                     pesoms    WITH .this_nPesoMs, ;
1216:                     percs     WITH .this_nPercs, ;
1217:                     valor     WITH .this_nValor, ;
1218:                     diasprz   WITH .this_nDiasPrz, ;
1219:                     descs     WITH .this_cDescs ;
1220:                  IN cursor_4c_Dados
1221:         ENDWITH
1222: 
1223:         THIS.grd_4c_Dados.Refresh()
1224: 
1225:         RETURN .T.
1226:     ENDPROC
1227: 
1228:     *--------------------------------------------------------------------------
1229:     * LimparCampos - Limpa Codigo/Descricao da LINHA CORRENTE da grade.
1230:     * Transcricao do "Replace CodTams With [], Descs With [] In crSigPrTam"
1231:     * que os DOIS Valid do legado executam (celula esvaziada pelo usuario,
1232:     * picker dispensado, escolha recusada por duplicidade). A linha em si
1233:     * NAO eh apagada aqui, igual ao legado.
1234:     * PROTECTED por heranca de FormBase - chamado so de dentro.
1235:     *--------------------------------------------------------------------------
1236:     PROTECTED PROCEDURE LimparCampos()
1237:         IF !USED("cursor_4c_Dados")
1238:             RETURN .F.
1239:         ENDIF
1240: 
1241:         SELECT cursor_4c_Dados
1242:         IF EOF()
1243:             RETURN .F.
1244:         ENDIF
1245: 
1246:         REPLACE codtams WITH "", descs WITH "" IN cursor_4c_Dados
1247: 
1248:         RETURN .T.
1249:     ENDPROC
1250: 
1251:     *--------------------------------------------------------------------------
1252:     * GravarLinhaAtual - Persiste em SigPrTam a LINHA CORRENTE da grade.
1253:     * INSERT quando a linha nasceu nesta sessao (BtnInserirClick), UPDATE
1254:     * quando ja veio do CarregarLista ou ja foi gravada antes. So grava
1255:     * quando CodTams ja foi resolvido (linha ainda em branco nao tem o que
1256:     * persistir - mesma condicao implicita do legado, que so comecava a
1257:     * fazer sentido depois do Tamanho escolhido).
1258:     * PUBLIC - chamado pelos handlers de celula.
1259:     *--------------------------------------------------------------------------
1260:     PROCEDURE GravarLinhaAtual()
1261:         LOCAL loc_cCidChaves, loc_lNovo, loc_lSucesso
1262:         loc_lSucesso = .F.
1263: 
1264:         IF !USED("cursor_4c_Dados") OR VARTYPE(THIS.this_oBusinessObject) != "O"
1265:             RETURN .F.
1266:         ENDIF
1267: 
1268:         SELECT cursor_4c_Dados
1269:         IF EOF() OR EMPTY(ALLTRIM(codtams))
1270:             RETURN .F.
1271:         ENDIF
1272: 
1273:         loc_cCidChaves = ALLTRIM(cidchaves)
1274:         loc_lNovo      = THIS.EhRegistroNovo(loc_cCidChaves)
1275: 
1276:         IF loc_lNovo
1277:             *-- NovoRegistro() chama LimparDados() - preencher DEPOIS dele
1278:             THIS.this_oBusinessObject.NovoRegistro()
1279:         ELSE
1280:             THIS.this_oBusinessObject.this_lNovoRegistro = .F.
1281:             THIS.this_oBusinessObject.EditarRegistro()
1282:         ENDIF
1283: 
1284:         SELECT cursor_4c_Dados
1285:         *-- ALLTRIM dos DOIS lados: medido no VFP9, "<char(20) padded> ==
1286:         *-- <valor trimado>" eh .F. sempre (o == compara o comprimento
1287:         *-- tambem, independente de SET EXACT). Sem isto o LOCATE falha em
1288:         *-- toda chave mais curta que 20 e a gravacao devolve .F. em silencio.
1289:         LOCATE FOR ALLTRIM(cidchaves) == ALLTRIM(loc_cCidChaves)
1290:         IF !FOUND()
1291:             RETURN .F.
1292:         ENDIF
1293: 
1294:         IF !THIS.FormParaBO()
1295:             RETURN .F.
1296:         ENDIF
1297: 
1298:         IF THIS.this_oBusinessObject.Salvar()
1299:             loc_lSucesso = .T.
1300:             THIS.BOParaForm()

*-- Linhas 1318 a 1361:
1318:     * grade. PUBLIC (nao PROTECTED) - TesteAutomatico.prg chama metodos do
1319:     * form direto de fora da classe (regra #3).
1320:     *--------------------------------------------------------------------------
1321:     PROCEDURE CarregarLista()
1322:         LOCAL loc_lSucesso
1323:         loc_lSucesso = .F.
1324: 
1325:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1326:             loc_lSucesso = THIS.this_oBusinessObject.Buscar(THIS.this_cCodProduto)
1327:         ENDIF
1328: 
1329:         *-- Cursor recem-lido do banco: toda linha existe em SigPrTam, logo
1330:         *-- nao ha mais pendencia de INSERT
1331:         THIS.this_cCidChavesNovos = ""
1332: 
1333:         IF USED("cursor_4c_Dados")
1334:             SELECT cursor_4c_Dados
1335:             GO TOP
1336: 
1337:             *-- RecordSource com referencia EXPLICITA, FORA de WITH (regra
1338:             *-- #36/#41)
1339:             THIS.grd_4c_Dados.RecordSource = ""
1340: 
1341:             *-- ColumnCount TEM de ser reposto ANTES do RecordSource: o
1342:             *-- Buscar() do BO faz "USE IN cursor_4c_Dados" + recria o alias,
1343:             *-- e derrubar o alias ligado a grade ZERA o ColumnCount. Medido
1344:             *-- no VFP9 (2026-10-19): 6 -> 0 no USE IN e, religando sem
1345:             *-- repor, o VFP auto-expande para as 11 COLUNAS do cursor -
1346:             *-- a grade passa a exibir cidchaves/cpros/dataalts/datatrans/
1347:             *-- dtmovs crus a direita das seis colunas do legado, sem erro e
1348:             *-- sem log. Reatribuir ColumnCount destroi os controles postos
1349:             *-- por AddObject nas Columns, mas InstalarCelulasGrade() logo
1350:             *-- abaixo os reinstala (guarda PEMSTATUS).
1351:             THIS.grd_4c_Dados.ColumnCount  = 6
1352: 
1353:             THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
1354:             THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.codtams"
1355:             THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Dados.descs"
1356:             THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Dados.pesoms"
1357:             THIS.grd_4c_Dados.Column4.ControlSource = "cursor_4c_Dados.percs"
1358:             THIS.grd_4c_Dados.Column5.ControlSource = "cursor_4c_Dados.valor"
1359:             THIS.grd_4c_Dados.Column6.ControlSource = "cursor_4c_Dados.diasprz"
1360: 
1361:             *-- RecordSource/ControlSource resetam Width e Header1.Caption -

*-- Linhas 1395 a 1515:
1395:     * Where Cpros = ..." do Init legado (pdPro/crSigCdPro.PVens/PCuss),
1396:     * usado pelo calculo Percentual<->Valor das celulas da grade.
1397:     *--------------------------------------------------------------------------
1398:     PROTECTED PROCEDURE CarregarDadosProduto()
1399:         LOCAL loc_cSQL, loc_nResultado, loc_oErro
1400: 
1401:         TRY
1402:             IF USED("cursor_4c_DadosProduto")
1403:                 USE IN cursor_4c_DadosProduto
1404:             ENDIF
1405: 
1406:             loc_cSQL = "SELECT Dpros, PVens, PCuss FROM SigCdPro WHERE Cpros = " + ;
1407:                        EscaparSQL(THIS.this_cCodProduto)
1408: 
1409:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosProduto")
1410: 
1411:             IF loc_nResultado > 0 AND USED("cursor_4c_DadosProduto") AND ;
1412:                RECCOUNT("cursor_4c_DadosProduto") > 0
1413:                 THIS.this_cDescProduto = TratarNulo(cursor_4c_DadosProduto.Dpros, "")
1414:                 THIS.this_nPrecoVenda  = TratarNulo(cursor_4c_DadosProduto.PVens, 0)
1415:                 THIS.this_nPrecoCusto  = TratarNulo(cursor_4c_DadosProduto.PCuss, 0)
1416:             ENDIF
1417: 
1418:             IF USED("cursor_4c_DadosProduto")
1419:                 USE IN cursor_4c_DadosProduto
1420:             ENDIF
1421:         CATCH TO loc_oErro
1422:             MsgErro("Erro ao ler dados do produto: " + loc_oErro.Message, "Erro")
1423:         ENDTRY
1424:     ENDPROC
1425: 
1426:     *--------------------------------------------------------------------------
1427:     * BtnInserirClick - Espelha cmdInserir.Click do legado: garante UMA
1428:     * linha em branco (CodTams vazio) para o usuario preencher via lookup.
1429:     * Legado: Locate For cPros=crSigCdPro.cPros And CodTams=Space(4) / If
1430:     * Eof() / Insert Into crSigPrTam (cPros, CidChaves) Values (...)
1431:     * PUBLIC - alvo de BINDEVENT (regra #3)
1432:     *--------------------------------------------------------------------------
1433:     PROCEDURE BtnInserirClick()
1434:         LOCAL loc_cCidNovo
1435: 
1436:         IF !USED("cursor_4c_Dados")
1437:             RETURN
1438:         ENDIF
1439: 
1440:         THIS.this_lHouveIncl = .T.
1441: 
1442:         SELECT cursor_4c_Dados
1443:         LOCATE FOR ALLTRIM(cpros) == ALLTRIM(THIS.this_cCodProduto) AND EMPTY(codtams)
1444: 
1445:         IF !FOUND()
1446:             loc_cCidNovo = fUniqueIds()
1447: 
1448:             APPEND BLANK
1449:             REPLACE cpros     WITH THIS.this_cCodProduto, ;
1450:                     cidchaves WITH loc_cCidNovo, ;
1451:                     codtams   WITH "", ;
1452:                     descs     WITH "", ;
1453:                     pesoms    WITH 0, ;
1454:                     percs     WITH 0, ;
1455:                     valor     WITH 0, ;
1456:                     diasprz   WITH 0
1457: 
1458:             *-- Linha existe so no cursor local ate o usuario escolher o
1459:             *-- tamanho (GravarLinhaAtual faz o INSERT)
1460:             THIS.RegistrarCidChaveNova(loc_cCidNovo)
1461:         ENDIF
1462: 
1463:         *-- Popular o cursor NAO repinta a grade (regra #21)
1464:         THIS.grd_4c_Dados.Refresh()
1465:         THIS.grd_4c_Dados.Column1.SetFocus()
1466:     ENDPROC
1467: 
1468:     *--------------------------------------------------------------------------
1469:     * BtnExcluirClick - Espelha cmdExcluir.Click do legado. Linha ja
1470:     * persistida (CodTams preenchido, ja gravada) eh excluida de verdade via
1471:     * BO (gravacao nunca eh muda); linha ainda em edicao (CodTams vazio,
1472:     * nunca gravada) eh so removida do cursor local.
1473:     * PUBLIC - alvo de BINDEVENT (regra #3)
1474:     *--------------------------------------------------------------------------
1475:     PROCEDURE BtnExcluirClick()
1476:         LOCAL loc_cCidChaves, loc_lRemover
1477: 
1478:         IF !USED("cursor_4c_Dados")
1479:             RETURN
1480:         ENDIF
1481: 
1482:         SELECT cursor_4c_Dados
1483:         IF EOF()
1484:             RETURN
1485:         ENDIF
1486: 
1487:         *-- Guard do legado: "If Not Eof() And (crSigPrTam.cPros =
1488:         *-- crSigCdPro.cPros)" - so apaga linha do produto corrente
1489:         IF ALLTRIM(cpros) != ALLTRIM(THIS.this_cCodProduto)
1490:             RETURN
1491:         ENDIF
1492: 
1493:         loc_cCidChaves = ALLTRIM(cidchaves)
1494: 
1495:         loc_lRemover = .T.
1496: 
1497:         IF !EMPTY(codtams) AND !THIS.EhRegistroNovo(loc_cCidChaves)
1498:             *-- Linha JA persistida: apaga primeiro no banco. Falhando, a
1499:             *-- linha CONTINUA na grade (apagar so o visual esconderia um
1500:             *-- registro que segue existindo em SigPrTam) e a mensagem nunca
1501:             *-- eh muda (regra #20).
1502:             THIS.this_oBusinessObject.this_cCidChaves    = loc_cCidChaves
1503:             THIS.this_oBusinessObject.this_lNovoRegistro = .F.
1504: 
1505:             IF !THIS.this_oBusinessObject.Excluir()
1506:                 loc_lRemover = .F.
1507: 
1508:                 IF !THIS.this_oBusinessObject.this_lErroExibido
1509:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o tamanho.", "Erro")
1510:                 ENDIF
1511:             ENDIF
1512:         ENDIF
1513: 
1514:         IF loc_lRemover
1515:             *-- Remocao LOCAL nos DOIS casos (linha persistida e linha em

*-- Linhas 1555 a 1798:
1555:     * limpeza silenciosa - o legado ABORTA o fechamento com aviso e foca a
1556:     * grade). O re-habilitar do form pai fica no Destroy (vale em qualquer
1557:     * caminho de fechamento).
1558:     * PUBLIC - alvo de BINDEVENT (regra #3)
1559:     *--------------------------------------------------------------------------
1560:     PROCEDURE BtnSairClick()
1561:         IF (THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible) AND ;
1562:            INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
1563: 
1564:             IF USED("cursor_4c_Dados")
1565:                 SELECT cursor_4c_Dados
1566:                 SCAN
1567:                     IF EMPTY(codtams)
1568:                         MsgAviso("Tamanho n" + CHR(227) + "o informado!", ;
1569:                                   "Aten" + CHR(231) + CHR(227) + "o")
1570:                         THIS.grd_4c_Dados.Column1.SetFocus()
1571:                         RETURN
1572:                     ENDIF
1573:                 ENDSCAN
1574:             ENDIF
1575:         ENDIF
1576: 
1577:         THIS.Release()
1578:     ENDPROC
1579: 
1580:     *--------------------------------------------------------------------------
1581:     * RegistrarCidChaveNova/RemoverCidChaveNova/EhRegistroNovo - Controle das
1582:     * linhas criadas nesta sessao e ainda sem registro em SigPrTam (logo:
1583:     * INSERT ao gravar, exclusao apenas local ao apagar).
1584:     * PUBLIC - usados pelos handlers de botao/celula.
1585:     *--------------------------------------------------------------------------
1586:     PROCEDURE RegistrarCidChaveNova(par_cCidChaves)
1587:         LOCAL loc_cCid
1588:         loc_cCid = IIF(VARTYPE(par_cCidChaves) = "C", ALLTRIM(par_cCidChaves), "")
1589: 
1590:         IF !EMPTY(loc_cCid) AND !THIS.EhRegistroNovo(loc_cCid)
1591:             THIS.this_cCidChavesNovos = THIS.this_cCidChavesNovos + "|" + loc_cCid + "|"
1592:         ENDIF
1593:     ENDPROC
1594: 
1595:     PROCEDURE RemoverCidChaveNova(par_cCidChaves)
1596:         LOCAL loc_cCid
1597:         loc_cCid = IIF(VARTYPE(par_cCidChaves) = "C", ALLTRIM(par_cCidChaves), "")
1598: 
1599:         IF !EMPTY(loc_cCid)
1600:             THIS.this_cCidChavesNovos = STRTRAN(THIS.this_cCidChavesNovos, "|" + loc_cCid + "|", "")
1601:         ENDIF
1602:     ENDPROC
1603: 
1604:     PROCEDURE EhRegistroNovo(par_cCidChaves)
1605:         LOCAL loc_cCid
1606:         loc_cCid = IIF(VARTYPE(par_cCidChaves) = "C", ALLTRIM(par_cCidChaves), "")
1607: 
1608:         RETURN !EMPTY(loc_cCid) AND ("|" + loc_cCid + "|") $ THIS.this_cCidChavesNovos
1609:     ENDPROC
1610: 
1611:     *--------------------------------------------------------------------------
1612:     * ConfigurarBotoes - Botoes standalone (fwbtng do legado) -
1613:     * Themes=.T.+DisabledPicture obrigatorios em CommandButton icone-only
1614:     * fora de CommandGroup (senao o icone some quando Enabled=.F.).
1615:     *--------------------------------------------------------------------------
1616:     PROTECTED PROCEDURE ConfigurarBotoes()
1617:         LOCAL loc_cIcones
1618:         loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")
1619: 
1620:         THIS.AddObject("cmd_4c_Inserir", "CommandButton")
1621:         WITH THIS.cmd_4c_Inserir
1622:             .Top             = 3
1623:             .Left            = 413
1624:             .Width           = 75
1625:             .Height          = 75
1626:             .Caption         = "Inserir"
1627:             .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
1628:             .DisabledPicture = loc_cIcones + "cadastro_inserir_60.jpg"
1629:             .Themes          = .T.
1630:             .TabIndex        = 9
1631:             .FontName        = "Comic Sans MS"
1632:             .FontBold        = .T.
1633:             .FontItalic      = .T.
1634:             .FontSize        = 8
1635:             .ForeColor       = RGB(90, 90, 90)
1636:             .BackColor       = RGB(255, 255, 255)
1637:             .SpecialEffect   = 0
1638:             .PicturePosition = 13
1639:             .MousePointer    = 15
1640:             .WordWrap        = .T.
1641:             .AutoSize        = .F.
1642:         ENDWITH
1643:         BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "BtnInserirClick")
1644: 
1645:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
1646:         WITH THIS.cmd_4c_Excluir
1647:             .Top             = 3
1648:             .Left            = 488
1649:             .Width           = 75
1650:             .Height          = 75
1651:             .Caption         = "Excluir"
1652:             .Picture         = loc_cIcones + "cadastro_excluir_60.jpg"
1653:             .DisabledPicture = loc_cIcones + "cadastro_excluir_60.jpg"
1654:             .Themes          = .T.
1655:             .TabIndex        = 7
1656:             .FontName        = "Comic Sans MS"
1657:             .FontBold        = .T.
1658:             .FontItalic      = .T.
1659:             .FontSize        = 8
1660:             .ForeColor       = RGB(90, 90, 90)
1661:             .BackColor       = RGB(255, 255, 255)
1662:             .SpecialEffect   = 0
1663:             .PicturePosition = 13
1664:             .MousePointer    = 15
1665:             .WordWrap        = .T.
1666:             .AutoSize        = .F.
1667:         ENDWITH
1668:         BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
1669: 
1670:         THIS.AddObject("cmd_4c_Sair", "CommandButton")
1671:         WITH THIS.cmd_4c_Sair
1672:             .Top             = 3
1673:             .Left            = 563
1674:             .Width           = 75
1675:             .Height          = 75
1676:             .Caption         = "Encerrar"
1677:             .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
1678:             .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
1679:             .Themes          = .T.
1680:             .Cancel          = .T.
1681:             .TabIndex        = 8
1682:             .FontName        = "Comic Sans MS"
1683:             .FontBold        = .T.
1684:             .FontItalic      = .T.
1685:             .FontSize        = 8
1686:             .ForeColor       = RGB(90, 90, 90)
1687:             .BackColor       = RGB(255, 255, 255)
1688:             .SpecialEffect   = 0
1689:             .PicturePosition = 13
1690:             .MousePointer    = 15
1691:             .WordWrap        = .T.
1692:             .AutoSize        = .F.
1693:         ENDWITH
1694:         BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
1695:     ENDPROC
1696: 
1697:     *--------------------------------------------------------------------------
1698:     * AjustarVisibilidadePorModo - Espelha llVis = InList(.pcEscolha,
1699:     * 'INSERIR','ALTERAR') do Init legado. Em modo VISUALIZAR, Inserir/
1700:     * Excluir ficam ocultos e o Shape1 decorativo encolhe para abracar so o
1701:     * botao Sair (legado: Shape1.Width = cmdSair.Width+10 / Shape1.Left =
1702:     * cmdSair.Left-5).
1703:     *--------------------------------------------------------------------------
1704:     PROTECTED PROCEDURE AjustarVisibilidadePorModo()
1705:         LOCAL loc_lVis
1706:         loc_lVis = INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
1707: 
1708:         THIS.cmd_4c_Inserir.Visible = loc_lVis
1709:         THIS.cmd_4c_Excluir.Visible = loc_lVis
1710: 
1711:         THIS.HabilitarCampos(loc_lVis)
1712: 
1713:         IF !loc_lVis
1714:             THIS.shp_4c_Shape1.Width = THIS.cmd_4c_Sair.Width + 10
1715:             THIS.shp_4c_Shape1.Left  = THIS.cmd_4c_Sair.Left - 5
1716:         ENDIF
1717:     ENDPROC
1718: 
1719:     *--------------------------------------------------------------------------
1720:     * HabilitarCampos - Liga/desliga a superficie EDITAVEL da tela:
1721:     *   - .cmdInserir.Enabled = llVis / .cmdExcluir.Enabled = llVis (Init)
1722:     *   - When de TODAS as celulas da grade, que retornam
1723:     *     InList(ThisForm.pcEscolha,'INSERIR','ALTERAR')
1724:     * Nesta tela nao existe "ficha" de TextBox soltos: os unicos campos
1725:     * digitaveis sao as SEIS celulas da grade, por isso o equivalente age
1726:     * sobre Column.ReadOnly em vez de Control.Enabled.
1727:     * PUBLIC - chamado de AjustarVisibilidadePorModo.
1728:     *--------------------------------------------------------------------------
1729:     PROCEDURE HabilitarCampos(par_lHabilitar)
1730:         LOCAL loc_lHab
1731:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.)
1732: 
1733:         THIS.cmd_4c_Inserir.Enabled = loc_lHab
1734:         THIS.cmd_4c_Excluir.Enabled = loc_lHab
1735: 
1736:         *-- Grid.ReadOnly propaga para as Columns e SOBRESCREVE o ReadOnly
1737:         *-- delas - tem de ser definido ANTES (CLAUDE.md regra #18)
1738:         THIS.grd_4c_Dados.ReadOnly         = .F.
1739:         THIS.grd_4c_Dados.Column1.ReadOnly = !loc_lHab
1740:         THIS.grd_4c_Dados.Column2.ReadOnly = !loc_lHab
1741:         THIS.grd_4c_Dados.Column3.ReadOnly = !loc_lHab
1742:         THIS.grd_4c_Dados.Column4.ReadOnly = !loc_lHab
1743:         THIS.grd_4c_Dados.Column5.ReadOnly = !loc_lHab
1744:         THIS.grd_4c_Dados.Column6.ReadOnly = !loc_lHab
1745: 
1746:         *-- Encerrar nunca desabilita: eh o unico caminho de saida desta tela
1747:         THIS.cmd_4c_Sair.Enabled = .T.
1748:     ENDPROC
1749: 
1750:     *--------------------------------------------------------------------------
1751:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
1752:     * padrao; percorre recursivamente form/containers tornando tudo visivel.
1753:     *--------------------------------------------------------------------------
1754:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1755:         LOCAL loc_oContainer, loc_i, loc_oControl
1756: 
1757:         IF VARTYPE(par_oContainer) = "O"
1758:             loc_oContainer = par_oContainer
1759:         ELSE
1760:             loc_oContainer = THIS
1761:         ENDIF
1762: 
1763:         FOR loc_i = 1 TO loc_oContainer.ControlCount
1764:             loc_oControl = loc_oContainer.Controls(loc_i)
1765:             IF VARTYPE(loc_oControl) = "O"
1766:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1767:                     THIS.TornarControlesVisiveis(loc_oControl)
1768:                 ENDIF
1769:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1770:                     loc_oControl.Visible = .T.
1771:                 ENDIF
1772:             ENDIF
1773:         ENDFOR
1774:     ENDPROC
1775: 
1776:     *--------------------------------------------------------------------------
1777:     * Destroy - Reabilita o form pai (fail-safe mesmo se algo falhar antes do
1778:     * BtnSairClick fechar o dialogo normalmente) e libera BO/cursor/referencias
1779:     *--------------------------------------------------------------------------
1780:     PROCEDURE Destroy()
1781:         IF VARTYPE(THIS.this_oFormPai) = "O"
1782:             THIS.this_oFormPai.Enabled = .T.
1783:         ENDIF
1784: 
1785:         IF USED("cursor_4c_Dados")
1786:             USE IN cursor_4c_Dados
1787:         ENDIF
1788: 
1789:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1790:             THIS.this_oBusinessObject = .NULL.
1791:         ENDIF
1792: 
1793:         THIS.this_oFormPai = .NULL.
1794: 
1795:         DODEFAULT()
1796:     ENDPROC
1797: 
1798: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprtamBO.prg):
*==============================================================================
* sigprtamBO.prg - Business Object para Tamanhos do Produto (SIGPRTAM)
* Tabela Principal: SigPrTam (PK: cidchaves)
* Tabela Relacionada: SigCdTam (cadastro de tamanhos - cods/descs/varias)
*
* SIGPRTAM e um dialogo filho chamado pelo cadastro de produtos para
* manter a grade de tamanhos (codigo, descricao, peso medio, percentual,
* valor e prazo de entrega) de UM produto por vez (filtro por cpros).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS sigprtamBO AS BusinessBase

    *-- Propriedades: SigPrTam
    this_cCidChaves  = ""   && cidchaves char(20) NOT NULL - PK
    this_cCodTams    = ""   && codtams   char(4)  NOT NULL - FK SigCdTam.cods
    this_cCpros      = ""   && cpros     char(14) NOT NULL - FK SigCdPro.cPros (produto filtrado)
    this_dDataAlts   = {}   && dataalts  datetime NULL
    this_dDataTrans  = {}   && datatrans datetime NULL
    this_dDtMovs     = {}   && dtmovs    datetime NULL
    this_nPesoMs     = 0    && pesoms    numeric(7,3) NOT NULL - peso medio do tamanho
    this_nPercs      = 0    && percs     numeric(5,2) NOT NULL - percentual sobre o preco de venda
    this_nValor      = 0    && valor     numeric(11,5) NOT NULL - valor calculado a partir do percentual
    this_nDiasPrz    = 0    && diasprz   numeric(2,0) NOT NULL - prazo de entrega em dias

    *-- Propriedade NAO persistida: descricao do tamanho (join com SigCdTam.descs)
    this_cDescs      = ""   && descs char(20) - vem de SigCdTam, exibida na grade

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigPrTam"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades a partir de uma linha do
    * cursor (cursor_4c_Dados, populado pelo Form a partir de SigPrTam)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                THIS.this_cCodTams   = TratarNulo(codtams,   "")
                THIS.this_cCpros     = TratarNulo(cpros,     "")
                THIS.this_dDataAlts  = TratarNulo(dataalts,  {})
                THIS.this_dDataTrans = TratarNulo(datatrans, {})
                THIS.this_dDtMovs    = TratarNulo(dtmovs,    {})
                THIS.this_nPesoMs    = TratarNulo(pesoms,    0)
                THIS.this_nPercs     = TratarNulo(percs,     0)
                THIS.this_nValor     = TratarNulo(valor,     0)
                THIS.this_nDiasPrz   = TratarNulo(diasprz,   0)

                * Descs vem de um JOIN com SigCdTam (nao existe na tabela
                * SigPrTam) - so esta presente quando o SELECT do Form a traz
                IF TYPE("descs") = "C"
                    THIS.this_cDescs = TratarNulo(descs, "")
                ELSE
                    THIS.this_cDescs = ""
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigprtamBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria de SigPrTam (cidchaves)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigPrTam (novo tamanho para o produto filtrado)
    * O legado gera a PK com fUniqueIds() no clique do botao Inserir, antes
    * de o usuario preencher qualquer coluna da grade (regra #22).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTam (cidchaves, codtams, cpros, dataalts, datatrans, dtmovs, pesoms, percs, valor, diasprz)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(THIS.this_cCodTams)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<FormatarDataSQL(THIS.this_dDataAlts)>>,
                    <<FormatarDataSQL(THIS.this_dDataTrans)>>,
                    <<FormatarDataSQL(THIS.this_dDtMovs)>>,
                    <<FormatarNumeroSQL(THIS.this_nPesoMs, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nPercs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nValor, 5)>>,
                    <<FormatarNumeroSQL(THIS.this_nDiasPrz, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir tamanho do produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "sigprtamBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigPrTam (cpros e cidchaves nao mudam depois do
    * Inserir - sao a chave e o filtro de origem do registro)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTam
                SET codtams   = <<EscaparSQL(THIS.this_cCodTams)>>,
                    dataalts  = <<FormatarDataSQL(THIS.this_dDataAlts)>>,
                    datatrans = <<FormatarDataSQL(THIS.this_dDataTrans)>>,
                    dtmovs    = <<FormatarDataSQL(THIS.this_dDtMovs)>>,
                    pesoms    = <<FormatarNumeroSQL(THIS.this_nPesoMs, 3)>>,
                    percs     = <<FormatarNumeroSQL(THIS.this_nPercs, 2)>>,
                    valor     = <<FormatarNumeroSQL(THIS.this_nValor, 5)>>,
                    diasprz   = <<FormatarNumeroSQL(THIS.this_nDiasPrz, 0)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar tamanho do produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "sigprtamBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigPrTam (equivalente ao Delete do
    * cursor buferizado no cmdExcluir.Click do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTam WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir tamanho do produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "sigprtamBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca os tamanhos vinculados a um produto (par_cCpros).
    * Retorna cursor_4c_Dados com cidchaves/codtams/cpros/.../descs.
    *
    * NAO faz JOIN com SigCdTam para preencher descs: o legado tambem nao
    * faz (Init: "Select a.*, Space(40) as Descs From SigPrTam a Where
    * a.cPros = ...") - a descricao so e preenchida em runtime pelo lookup
    * da celula de Codigo/Descricao (Column1/Column2.Text1.Valid), nunca
    * pela carga inicial. Transcricao literal (CLAUDE.md regra #17).
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cidchaves, codtams, cpros, dataalts, datatrans, dtmovs,
                       pesoms, percs, valor, diasprz, SPACE(20) AS descs
                FROM SigPrTam
                WHERE cpros = <<EscaparSQL(par_cCpros)>>
            ENDTEXT

            * SQLEXEC cria cursor SOMENTE-LEITURA - a grade precisa inserir
            * (Inserir) e apagar (Excluir) linhas localmente, alem de editar
            * peso/percentual/valor/prazo, entao o resultado eh copiado para
            * um cursor READWRITE (CLAUDE.md: "Grid com coluna EDITAVEL
            * exige cursor READWRITE")
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao buscar tamanhos do produto:" + CHR(13) + ;
                        THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "sigprtamBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

