# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRRET): Top original=240 vs migrado 'lbl_4c_Label17' Top=394 (diff=154px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRRET): Left original=636 vs migrado 'lbl_4c_Label17' Left=227 (diff=409px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrRet.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2646 linhas total):

*-- Linhas 11 a 63:
11: * analise completa.
12: *
13: * Fase 1/2 (ja concluidas): SigPrRetBO.prg (propriedades + metodos de carga)
14: * Fase 3 (ja concluida): estrutura base do Form - Init/InicializarForm e o
15: *   cabecalho (cntSombra do legado).
16: * Fase 4 (ja concluida): CommandGroup "sair" (Consulta/Digitacao/Arquivadas/
17: *   Encerrar - estrutura visual; Click entra nas fases 7/8).
18: * Fase 5 (ja concluida): primeira metade dos campos de filtro (Periodo,
19: *   Empresa, Operacao, Chk_Preco, Codigo/Etiquetas, Grupo Estoque).
20: * Fase 6 (ja concluida): segunda metade dos campos de filtro (Industria,
21: *   Estoque, Grande Grupo, Grupo/Subgrupo Produto, Grupo Venda, Linha,
22: *   Local do Produto/Etiqueta, Promocao, Ordem, Marca) + TODOS os lookups
23: *   (BINDEVENT "LostFocus" + THIS.AbrirLookupCanonico de FormBase) e as
24: *   dependencias entre campos (AjustarDependenciasCampos, equivalente aos
25: *   "When" do legado).
26: *
27: * Fase 7 (ja concluida): EVENTOS PRINCIPAIS do CommandGroup "sair" - os
28: * QUATRO botoes reais do legado (Consulta/Encerrar/Digitacao/Arquivadas) e
29: * FormParaBO(). Nao ha barra CRUD (Incluir/Alterar/Visualizar/Excluir)
30: * porque o legado NAO tem essa barra: o SCX herda de "form" puro (nao de
31: * frmcadastro), nao tem Grupo_Op nem pcEscolha - inventar os quatro verbos
32: * violaria o PILAR 1.
33: *
34: * Fase 8 (este arquivo): EVENTOS AUXILIARES e CONSOLIDACAO.
35: *
36: *   1) BOParaForm() - sentido inverso de FormParaBO(), campo a campo. Quem
37: *      alimenta o BO por fora da digitacao precisa dele para a tela mostrar
38: *      o que vai ser consultado;
39: *   2) AplicarFixaEmpresa() / FixarEmpresaNaTela() - a regra "fixa empresa"
40: *      do Init do legado (SigCdPac.fixaemp = 1 trava o campo Empresa na
41: *      empresa do sistema e resolve a Razao Social). Estava inteiramente
42: *      ausente: o BO ja tinha CarregarParametros() e this_nFixaEmpresa, mas
43: *      NADA no form os chamava, entao o filtro Empresa ficava livre numa
44: *      instalacao que o legado trava - divergencia silenciosa, sem erro na
45: *      tela;
46: *   3) AjustarDependenciasCampos() - os 14 "When" do SCX, revisados um a um
47: *      contra o dump. Dois estavam errados: get_ds_empresa tinha a condicao
48: *      INVERTIDA (a Razao Social, que eh a via alternativa de busca, ficava
49: *      desabilitada justamente com o codigo vazio - e preencher o codigo ja
50: *      preenche a descricao, entao o campo era inalcancavel) e
51: *      get_Ds_GrEstoque nao tinha condicao nenhuma;
52: *   4) DespacharImpressao() - funil unico do "Do Form SigOpIpE With
53: *      ThisForm" dos tres botoes de acao, com TRY cobrindo SO a chamada e
54: *      com a ausencia de SigOpIpE reportada por NOME;
55: *   5) BtnDigitacaoClick / BtnArquivadasClick - o reset de filtros passou a
56: *      sair de SigPrRetBO.LimparDados() (reset COMPLETO) em vez da copia da
57: *      lista do legado: o legado eh modal e recria as PRIVATE a cada clique,
58: *      o form migrado nao fecha entre um clique e outro, e o que a lista do
59: *      legado nao cita (Industria, SubGrupo, Linha, Local, Localizacao,
60: *      Qtd. de Etiquetas) vazava de uma CONSULTA anterior.
61: *
62: * NAO SE APLICAM a esta tela, e por isso NAO foram inventados:
63: *   - CarregarLista / FormatarGridLista: o SCX nao tem Grid, nem PageFrame,

*-- Linhas 103 a 261:
103:     this_oBusinessObject = .NULL.
104: 
105:     *--------------------------------------------------------------------------
106:     * Guarda de reentrancia para os lookups (FormBuscaAuxiliar eh MODAL e
107:     * dispara LostFocus de novo ao tirar/devolver o foco - regra #47/#37)
108:     *--------------------------------------------------------------------------
109:     this_lEmLookup = .F.
110: 
111:     *--------------------------------------------------------------------------
112:     * Guarda de valor-nao-mudou: no legado o Valid so dispara quando o valor
113:     * MUDA, mas LostFocus dispara SEMPRE (inclusive so tirando/devolvendo o
114:     * foco sem digitar nada). Cada handler guarda aqui o ultimo valor ja
115:     * validado com sucesso e sai sem reabrir o lookup quando o valor nao
116:     * mudou - complementar ao this_lEmLookup acima (guarda de REENTRANCIA),
117:     * nao substituto dele.
118:     *--------------------------------------------------------------------------
119:     this_cUltimoValidarCdEmpresaLostFocusValidado          = ""
120:     this_cUltimoValidarDsEmpresaLostFocusValidado          = ""
121:     this_cUltimoValidarOperacaoLostFocusValidado           = ""
122:     this_cUltimoValidarIndustriaLostFocusValidado          = ""
123:     this_cUltimoValidarCodProdutoLostFocusValidado         = ""
124:     this_cUltimoValidarDescProdutoLostFocusValidado        = ""
125:     this_cUltimoValidarCdGrEstoqueLostFocusValidado        = ""
126:     this_cUltimoValidarDsGrEstoqueLostFocusValidado        = ""
127:     this_cUltimoValidarCdEstoqueLostFocusValidado          = ""
128:     this_cUltimoValidarDsEstoqueLostFocusValidado          = ""
129:     this_cUltimoValidarGrandeGrupoLostFocusValidado        = ""
130:     this_cUltimoValidarGrupoProdutoLostFocusValidado       = ""
131:     this_cUltimoValidarDescGrupoProdutoLostFocusValidado   = ""
132:     this_cUltimoValidarSubgrupoCodLostFocusValidado        = ""
133:     this_cUltimoValidarSubgrupoDescLostFocusValidado       = ""
134:     this_cUltimoValidarGrupoVendaCodLostFocusValidado      = ""
135:     this_cUltimoValidarGrupoVendaDescLostFocusValidado     = ""
136:     this_cUltimoValidarLinhaLostFocusValidado              = ""
137:     this_cUltimoValidarLocalProdutoLostFocusValidado       = ""
138:     this_cUltimoValidarLocalEtiquetaLostFocusValidado      = ""
139:     this_cUltimoValidarPromocaoLostFocusValidado           = ""
140: 
141:     *--------------------------------------------------------------------------
142:     * this_cTipo - equivalente a ThisForm.Tipo do legado (propriedade custom
143:     * do SCX): sinaliza para SigOpIpE (fora do escopo) qual dos tres botoes
144:     * (Consulta/Digitacao/Arquivadas) disparou a chamada.
145:     *--------------------------------------------------------------------------
146:     this_cTipo = ""
147: 
148:     *==========================================================================
149:     * Init
150:     * DODEFAULT() -> FormBase.Init() -> InicializarForm()
151:     * FormBase.Init() tambem corrige SET DATE/CENTURY para DataSession=2
152:     *==========================================================================
153:     PROCEDURE Init()
154:         RETURN DODEFAULT()
155:     ENDPROC
156: 
157:     *==========================================================================
158:     * InicializarForm
159:     * Cria o Business Object e monta a estrutura visual base (cabecalho).
160:     * Campos de filtro e botoes de acao sao adicionados nas proximas fases.
161:     *==========================================================================
162:     PROTECTED PROCEDURE InicializarForm()
163:         LOCAL loc_lSucesso, loc_oErro
164: 
165:         loc_lSucesso = .F.
166: 
167:         TRY
168:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrRetBO")
169: 
170:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
171:                 MsgErro("Erro ao criar SigPrRetBO." + CHR(13) + ;
172:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
173:                         "Erro em FormSigPrRet.InicializarForm")
174:             ELSE
175:                 IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
176:                     THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
177:                 ENDIF
178: 
179:                 THIS.ConfigurarPageFrame()
180: 
181:                 *-- Regra "fixa empresa" do Init do legado (SigCdPac.fixaemp)
182:                 THIS.AplicarFixaEmpresa()
183: 
184:                 THIS.TornarControlesVisiveis(THIS)
185: 
186:                 loc_lSucesso = .T.
187:             ENDIF
188: 
189:         CATCH TO loc_oErro
190:             MsgErro(loc_oErro.Message + CHR(13) + ;
191:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
192:                     "Procedure: " + loc_oErro.Procedure, ;
193:                     "Erro em FormSigPrRet.InicializarForm")
194:         ENDTRY
195: 
196:         RETURN loc_lSucesso
197:     ENDPROC
198: 
199:     *==========================================================================
200:     * ConfigurarPageFrame
201:     * SigPrRet (SCX legado, Width=1000 Height=600) eh dialogo PLANO sem
202:     * PageFrame real (PILAR 1: manter layout flat identico ao legado em vez
203:     * de introduzir abas artificialmente). Orquestra a montagem visual
204:     * delegando para os helpers dedicados por regiao.
205:     *==========================================================================
206:     PROTECTED PROCEDURE ConfigurarPageFrame()
207:         THIS.ConfigurarCabecalho()
208:         THIS.ConfigurarBotoesAcao()
209:         THIS.ConfigurarPaginaDados()
210:         THIS.ConfigurarEventosLookup()
211:         THIS.ConfigurarEventosBotoes()
212:         THIS.AjustarDependenciasCampos()
213:     ENDPROC
214: 
215:     *==========================================================================
216:     * ConfigurarCabecalho
217:     * Container cinza escuro com titulos sobrepostos (cntSombra do legado)
218:     * Nomes conforme mapeamento.json: cnt_4c_Sombra / lbl_4c_LblSombra /
219:     * lbl_4c_LblTitulo.
220:     *==========================================================================
221:     PROTECTED PROCEDURE ConfigurarCabecalho()
222:         THIS.AddObject("cnt_4c_Sombra", "Container")
223:         WITH THIS.cnt_4c_Sombra
224:             .Top         = 0
225:             .Left        = 0
226:             .Width       = THIS.Width
227:             .Height      = 80
228:             .BorderWidth = 0
229:             .BackStyle   = 1
230:             .BackColor   = RGB(100,100,100)
231:             .Visible     = .T.
232:         ENDWITH
233: 
234:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
235:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
236:             .FontBold      = .T.
237:             .FontName      = "Tahoma"
238:             .FontSize      = 18
239:             .FontUnderline = .F.
240:             .WordWrap      = .T.
241:             .Alignment     = 0
242:             .AutoSize      = .F.
243:             .BackStyle     = 0
244:             .Height        = 40
245:             .Left          = 10
246:             .Top           = 18
247:             .Width         = THIS.Width - 20
248:             .ForeColor     = RGB(0,0,0)
249:             .Caption       = THIS.Caption
250:             .Visible       = .T.
251:         ENDWITH
252: 
253:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
254:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
255:             .FontBold      = .T.
256:             .FontName      = "Tahoma"
257:             .FontSize      = 18
258:             .WordWrap      = .T.
259:             .Alignment     = 0
260:             .AutoSize      = .F.
261:             .BackStyle     = 0

*-- Linhas 289 a 332:
289:     * (7 e 8), apos os campos de filtro que esses metodos leem existirem
290:     * no form.
291:     *==========================================================================
292:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
293:         THIS.AddObject("obj_4c_Sair", "CommandGroup")
294:         WITH THIS.obj_4c_Sair
295:             .AutoSize     = .T.
296:             .Top          = -2
297:             .Left         = 689
298:             .Width        = 313
299:             .Height       = 85
300:             .ButtonCount  = 4
301:             .BackStyle    = 0
302:             .BorderStyle  = 0
303:             .SpecialEffect = 1
304:             .BorderColor  = RGB(136,189,188)
305:             .Themes       = .F.
306:             .Value        = 1
307:         ENDWITH
308: 
309:         WITH THIS.obj_4c_Sair.Buttons(1)
310:             .AutoSize   = .F.
311:             .Top        = 5
312:             .Left       = 5
313:             .Height     = 75
314:             .Width      = 75
315:             .FontBold   = .T.
316:             .FontItalic = .T.
317:             .FontName   = "Comic Sans MS"
318:             .FontSize   = 8
319:             .WordWrap   = .T.
320:             .Picture    = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
321:             .Caption    = "\<Consulta"
322:             .ForeColor  = RGB(90,90,90)
323:             .BackColor  = RGB(255,255,255)
324:             .Themes     = .F.
325:         ENDWITH
326: 
327:         WITH THIS.obj_4c_Sair.Buttons(2)
328:             .AutoSize   = .F.
329:             .Top        = 5
330:             .Left       = 233
331:             .Height     = 75
332:             .Width      = 75

*-- Linhas 383 a 472:
383:     *==========================================================================
384:     * ConfigurarEventosBotoes
385:     * Liga os 4 botoes do CommandGroup "sair" aos handlers reais (Fase 7/8).
386:     * BINDEVENT direto em cada Buttons(N) (nao em obj_4c_Sair.Click) porque
387:     * cada botao do legado tinha o PROPRIO Click (consulta.Click/sair.Click/
388:     * btnDigitacao.Click/Arquivadas.Click), nao um Click unico de grupo com
389:     * Do Case Value. Handlers precisam ser PUBLIC (regra #3).
390:     *==========================================================================
391:     PROTECTED PROCEDURE ConfigurarEventosBotoes()
392:         BINDEVENT(THIS.obj_4c_Sair.Buttons(1), "Click", THIS, "BtnConsultaClick")
393:         BINDEVENT(THIS.obj_4c_Sair.Buttons(2), "Click", THIS, "BtnEncerrarClick")
394:         BINDEVENT(THIS.obj_4c_Sair.Buttons(3), "Click", THIS, "BtnDigitacaoClick")
395:         BINDEVENT(THIS.obj_4c_Sair.Buttons(4), "Click", THIS, "BtnArquivadasClick")
396:     ENDPROC
397: 
398:     *==========================================================================
399:     * ConfigurarPaginaDados
400:     * SigPrRet nao tem PageFrame (dialogo FLAT - ver ConfigurarPageFrame): os
401:     * campos de filtro vao direto em THIS, nas mesmas coordenadas do SCX
402:     * legado (cntSombra/cabecalho ja ocupa Top=0..80, por isso nenhum campo
403:     * precisa de compensacao de offset).
404:     *
405:     * Fase 5/8: primeira metade dos campos (ordenados por Top no dump do
406:     * SCX, mantendo juntos label+campo da mesma linha). Segunda metade
407:     * (Industria, Estoque, Grupo/Subgrupo Produto, Grande Grupo, Colecao,
408:     * Linha, Local, Promocao, Ordem, Marca) entra na Fase 6/8.
409:     *==========================================================================
410:     PROTECTED PROCEDURE ConfigurarPaginaDados()
411:         THIS.ConfigurarCamposPeriodo()
412:         THIS.ConfigurarCamposEmpresa()
413:         THIS.ConfigurarCamposOperacao()
414:         THIS.ConfigurarCamposIndustria()
415:         THIS.ConfigurarCamposCodigoEtiquetas()
416:         THIS.ConfigurarCamposGrupoEstoque()
417:         THIS.ConfigurarCamposEstoque()
418:         THIS.ConfigurarCamposGrandeGrupo()
419:         THIS.ConfigurarCamposGrupoProduto()
420:         THIS.ConfigurarCamposSubgrupoProduto()
421:         THIS.ConfigurarCamposGrupoVenda()
422:         THIS.ConfigurarCamposLinha()
423:         THIS.ConfigurarCamposLocal()
424:         THIS.ConfigurarCamposPromocao()
425:         THIS.ConfigurarCamposOrdemMarca()
426:     ENDPROC
427: 
428:     *==========================================================================
429:     * ConfigurarCamposPeriodo
430:     * Linha "Periodo : [Get_Datai] ate [Get_Dataf]" (Top=107/111 no SCX)
431:     *==========================================================================
432:     PROTECTED PROCEDURE ConfigurarCamposPeriodo()
433:         THIS.AddObject("lbl_4c_Label5", "Label")
434:         WITH THIS.lbl_4c_Label5
435:             .FontName  = "Tahoma"
436:             .FontSize  = 8
437:             .BackStyle = 0
438:             .Alignment = 0
439:             .AutoSize  = .F.
440:             .Top       = 111
441:             .Left      = 253
442:             .Width     = 48
443:             .Height    = 15
444:             .TabIndex  = 31
445:             .ForeColor = RGB(90,90,90)
446:             .Caption   = "Per" + CHR(237) + "odo :"
447:         ENDWITH
448: 
449:         THIS.AddObject("txt_4c_Datai", "TextBox")
450:         WITH THIS.txt_4c_Datai
451:             .FontName      = "Tahoma"
452:             .Alignment     = 3
453:             .BorderStyle   = 1
454:             .SpecialEffect = 1
455:             .Top           = 107
456:             .Left          = 303
457:             .Width         = 80
458:             .Height        = 23
459:             .TabIndex      = 1
460:             .ForeColor     = RGB(0,0,0)
461:             .Value         = {}
462:         ENDWITH
463: 
464:         THIS.AddObject("lbl_4c_Label6", "Label")
465:         WITH THIS.lbl_4c_Label6
466:             .FontName  = "Tahoma"
467:             .FontSize  = 8
468:             .BackStyle = 0
469:             .Alignment = 0
470:             .AutoSize  = .F.
471:             .Top       = 111
472:             .Left      = 388

*-- Linhas 496 a 539:
496:     * ConfigurarCamposEmpresa
497:     * Linha "Empresa : [get_cd_empresa] [get_ds_empresa]" (Top=132/136)
498:     *==========================================================================
499:     PROTECTED PROCEDURE ConfigurarCamposEmpresa()
500:         THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
501:         WITH THIS.lbl_4c_Lbl_empresa
502:             .FontName  = "Tahoma"
503:             .BackStyle = 0
504:             .Alignment = 0
505:             .AutoSize  = .F.
506:             .Top       = 136
507:             .Left      = 248
508:             .Width     = 50
509:             .Height    = 15
510:             .TabIndex  = 33
511:             .ForeColor = RGB(90,90,90)
512:             .Caption   = "Empresa :"
513:         ENDWITH
514: 
515:         THIS.AddObject("txt_4c__cd_empresa", "TextBox")
516:         WITH THIS.txt_4c__cd_empresa
517:             .FontName      = "Tahoma"
518:             .Alignment     = 0
519:             .BackStyle     = 1
520:             .BorderStyle   = 1
521:             .SpecialEffect = 1
522:             .Format        = "K"
523:             .MaxLength     = 3
524:             .Top           = 132
525:             .Left          = 303
526:             .Width         = 31
527:             .Height        = 23
528:             .TabIndex      = 3
529:             .ForeColor     = RGB(0,0,0)
530:             .Value         = ""
531:         ENDWITH
532: 
533:         THIS.AddObject("txt_4c__ds_empresa", "TextBox")
534:         WITH THIS.txt_4c__ds_empresa
535:             .FontName      = "Tahoma"
536:             .BorderStyle   = 1
537:             .SpecialEffect = 1
538:             .Format        = "K"
539:             .MaxLength     = 40

*-- Linhas 552 a 595:
552:     * Linha "Opera" + CHR(231) + CHR(227) + "o : [nm_operacao] [Numero]
553:     * at" + CHR(233) + " [Numerof] [Chk_Preco]" (Top=157/162)
554:     *==========================================================================
555:     PROTECTED PROCEDURE ConfigurarCamposOperacao()
556:         THIS.AddObject("lbl_4c_Label9", "Label")
557:         WITH THIS.lbl_4c_Label9
558:             .FontName  = "Tahoma"
559:             .FontBold  = .F.
560:             .FontSize  = 8
561:             .BackStyle = 0
562:             .Alignment = 0
563:             .AutoSize  = .F.
564:             .Top       = 162
565:             .Left      = 242
566:             .Width     = 58
567:             .Height    = 15
568:             .TabIndex  = 34
569:             .ForeColor = RGB(90,90,90)
570:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
571:         ENDWITH
572: 
573:         THIS.AddObject("txt_4c__nm_operacao", "TextBox")
574:         WITH THIS.txt_4c__nm_operacao
575:             .FontBold      = .F.
576:             .FontItalic    = .F.
577:             .FontName      = "Tahoma"
578:             .FontSize      = 9
579:             .FontUnderline = .F.
580:             .Alignment     = 0
581:             .BackStyle     = 1
582:             .BorderStyle   = 1
583:             .SpecialEffect = 1
584:             .Format        = "K!"
585:             .MaxLength     = 20
586:             .Top           = 157
587:             .Left          = 303
588:             .Width         = 150
589:             .Height        = 25
590:             .TabIndex      = 5
591:             .ForeColor     = RGB(0,0,0)
592:             .Value         = ""
593:         ENDWITH
594: 
595:         THIS.AddObject("txt_4c_Numero", "TextBox")

*-- Linhas 641 a 687:
641:             .Value         = 0
642:         ENDWITH
643: 
644:         *-- Chk_Preco (OptionGroup legado): Sim/Nao/Ideal/Atual - 90,90,90
645:         *-- transcrito do dump; NUNCA setar ButtonsValue (regra CLAUDE.md
646:         *-- #OptionGroup.Buttons(N).Value) - so o Value do grupo importa.
647:         THIS.AddObject("obj_4c_Chk_Preco", "OptionGroup")
648:         WITH THIS.obj_4c_Chk_Preco
649:             .AutoSize    = .T.
650:             .ButtonCount = 4
651:             .BackStyle   = 0
652:             .BorderStyle = 0
653:             .Top         = 157
654:             .Left        = 606
655:             .Width       = 200
656:             .Height      = 25
657:             .TabIndex    = 36
658:             .Value       = 2
659:         ENDWITH
660: 
661:         WITH THIS.obj_4c_Chk_Preco.Buttons(1)
662:             .FontName  = "Tahoma"
663:             .FontSize  = 8
664:             .BackStyle = 0
665:             .AutoSize  = .T.
666:             .Top       = 5
667:             .Left      = 5
668:             .Width     = 34
669:             .Height    = 15
670:             .ForeColor = RGB(90,90,90)
671:             .Caption   = "Sim"
672:         ENDWITH
673: 
674:         WITH THIS.obj_4c_Chk_Preco.Buttons(2)
675:             .FontName  = "Tahoma"
676:             .FontSize  = 8
677:             .BackStyle = 0
678:             .AutoSize  = .T.
679:             .Top       = 5
680:             .Left      = 50
681:             .Width     = 37
682:             .Height    = 15
683:             .ForeColor = RGB(90,90,90)
684:             .Caption   = "N" + CHR(227) + "o"
685:         ENDWITH
686: 
687:         WITH THIS.obj_4c_Chk_Preco.Buttons(3)

*-- Linhas 716 a 759:
716:     * Linha "C" + CHR(243) + "digo : [Get_cod] [Get_dcod]" (Top=211/215) e
717:     * linha "Etiquetas : [Etii] [Etif] / Ou [qtdEti] Etiquetas" (Top=236/240)
718:     *==========================================================================
719:     PROTECTED PROCEDURE ConfigurarCamposCodigoEtiquetas()
720:         THIS.AddObject("lbl_4c_Label2", "Label")
721:         WITH THIS.lbl_4c_Label2
722:             .FontName  = "Tahoma"
723:             .BackStyle = 0
724:             .Alignment = 0
725:             .AutoSize  = .F.
726:             .Top       = 215
727:             .Left      = 256
728:             .Width     = 45
729:             .Height    = 15
730:             .TabIndex  = 38
731:             .ForeColor = RGB(90,90,90)
732:             .Caption   = "C" + CHR(243) + "digo :"
733:         ENDWITH
734: 
735:         *-- Lookup (SigCdPro CPros/DPros, fwBuscaExt no legado) entra na
736:         *-- fase de eventos - aqui so a estrutura visual do campo.
737:         THIS.AddObject("txt_4c_Cod", "TextBox")
738:         WITH THIS.txt_4c_Cod
739:             .FontName      = "Tahoma"
740:             .BorderStyle   = 1
741:             .SpecialEffect = 1
742:             .MaxLength     = 14
743:             .Top           = 211
744:             .Left          = 303
745:             .Width         = 108
746:             .Height        = 23
747:             .TabIndex      = 9
748:             .ForeColor     = RGB(0,0,0)
749:             .Value         = ""
750:         ENDWITH
751: 
752:         THIS.AddObject("txt_4c_Dcod", "TextBox")
753:         WITH THIS.txt_4c_Dcod
754:             .FontName      = "Tahoma"
755:             .BorderStyle   = 1
756:             .SpecialEffect = 1
757:             .Top           = 211
758:             .Left          = 413
759:             .Width         = 290

*-- Linhas 877 a 920:
877:     * ConfigurarCamposGrupoEstoque
878:     * Linha "Grupo Estoque : [Cd_GrEstoque] [Ds_GrEstoque]" (Top=261/266)
879:     *==========================================================================
880:     PROTECTED PROCEDURE ConfigurarCamposGrupoEstoque()
881:         THIS.AddObject("lbl_4c_Label7", "Label")
882:         WITH THIS.lbl_4c_Label7
883:             .FontName  = "Tahoma"
884:             .BackStyle = 0
885:             .Alignment = 0
886:             .AutoSize  = .F.
887:             .Top       = 266
888:             .Left      = 218
889:             .Width     = 80
890:             .Height    = 15
891:             .TabIndex  = 43
892:             .ForeColor = RGB(90,90,90)
893:             .Caption   = "Grupo Estoque :"
894:         ENDWITH
895: 
896:         THIS.AddObject("txt_4c__Cd_GrEstoque", "TextBox")
897:         WITH THIS.txt_4c__Cd_GrEstoque
898:             .FontName      = "Tahoma"
899:             .BorderStyle   = 1
900:             .SpecialEffect = 1
901:             .Format        = "K"
902:             .MaxLength     = 10
903:             .Top           = 261
904:             .Left          = 303
905:             .Width         = 80
906:             .Height        = 25
907:             .TabIndex      = 14
908:             .ForeColor     = RGB(0,0,0)
909:             .Value         = SPACE(10)
910:         ENDWITH
911: 
912:         THIS.AddObject("txt_4c__Ds_GrEstoque", "TextBox")
913:         WITH THIS.txt_4c__Ds_GrEstoque
914:             .FontName      = "Tahoma"
915:             .BorderStyle   = 1
916:             .SpecialEffect = 1
917:             .Format        = "K"
918:             .MaxLength     = 20
919:             .Top           = 261
920:             .Left          = 384

*-- Linhas 932 a 1015:
932:     * exclusivo com Operacao (ConfigurarCamposOperacao) - ver
933:     * AjustarDependenciasCampos().
934:     *==========================================================================
935:     PROTECTED PROCEDURE ConfigurarCamposIndustria()
936:         THIS.AddObject("lbl_4c_Label20", "Label")
937:         WITH THIS.lbl_4c_Label20
938:             .FontName  = "Tahoma"
939:             .BackStyle = 0
940:             .Alignment = 0
941:             .AutoSize  = .F.
942:             .Top       = 189
943:             .Left      = 246
944:             .Width     = 50
945:             .Height    = 15
946:             .TabIndex  = 51
947:             .ForeColor = RGB(90,90,90)
948:             .Caption   = "Ind" + CHR(250) + "stria :"
949:         ENDWITH
950: 
951:         *-- Lookup contra SigCdOpd.dopps (mesma tabela de Operacao - ver
952:         *-- AbrirLookupOperacaoIndustria)
953:         THIS.AddObject("txt_4c__nm_industria", "TextBox")
954:         WITH THIS.txt_4c__nm_industria
955:             .FontName      = "Tahoma"
956:             .BorderStyle   = 1
957:             .SpecialEffect = 1
958:             .MaxLength     = 20
959:             .Top           = 184
960:             .Left          = 303
961:             .Width         = 150
962:             .Height        = 25
963:             .TabIndex      = 8
964:             .ForeColor     = RGB(0,0,0)
965:             .Value         = ""
966:         ENDWITH
967:     ENDPROC
968: 
969:     *==========================================================================
970:     * ConfigurarCamposEstoque
971:     * Linha "Estoque : [get_cd_estoque] [get_ds_estoque]" (Top=288/293)
972:     * fAcessoContas(legado) -> SigCdCli (Iclis/Rclis), filtrado pelo Grupo
973:     * de Estoque (txt_4c__Cd_GrEstoque) - ver AbrirBuscaEstoque.
974:     *==========================================================================
975:     PROTECTED PROCEDURE ConfigurarCamposEstoque()
976:         THIS.AddObject("lbl_4c_Label8", "Label")
977:         WITH THIS.lbl_4c_Label8
978:             .FontName  = "Tahoma"
979:             .BackStyle = 0
980:             .Alignment = 0
981:             .AutoSize  = .F.
982:             .Top       = 293
983:             .Left      = 250
984:             .Width     = 50
985:             .Height    = 15
986:             .TabIndex  = 56
987:             .ForeColor = RGB(90,90,90)
988:             .Caption   = "Estoque :"
989:         ENDWITH
990: 
991:         THIS.AddObject("txt_4c__cd_estoque", "TextBox")
992:         WITH THIS.txt_4c__cd_estoque
993:             .FontName      = "Tahoma"
994:             .BorderStyle   = 1
995:             .SpecialEffect = 1
996:             .Format        = "K"
997:             .MaxLength     = 10
998:             .Top           = 288
999:             .Left          = 303
1000:             .Width         = 80
1001:             .Height        = 25
1002:             .TabIndex      = 16
1003:             .ForeColor     = RGB(0,0,0)
1004:             .Value         = ""
1005:         ENDWITH
1006: 
1007:         THIS.AddObject("txt_4c__ds_estoque", "TextBox")
1008:         WITH THIS.txt_4c__ds_estoque
1009:             .FontName      = "Tahoma"
1010:             .BorderStyle   = 1
1011:             .SpecialEffect = 1
1012:             .Format        = "K"
1013:             .MaxLength     = 20
1014:             .Top           = 288
1015:             .Left          = 384

*-- Linhas 1026 a 1107:
1026:     * Linha "Grande Grupo : [get_gde_grupo]" (Top=315/319)
1027:     * fwBuscaExt(legado) -> SigCdGpr.Codigos/Descs
1028:     *==========================================================================
1029:     PROTECTED PROCEDURE ConfigurarCamposGrandeGrupo()
1030:         THIS.AddObject("lbl_4c_Label15", "Label")
1031:         WITH THIS.lbl_4c_Label15
1032:             .FontName  = "Tahoma"
1033:             .BackStyle = 0
1034:             .Alignment = 0
1035:             .AutoSize  = .F.
1036:             .Top       = 319
1037:             .Left      = 222
1038:             .Width     = 76
1039:             .Height    = 15
1040:             .TabIndex  = 57
1041:             .ForeColor = RGB(90,90,90)
1042:             .Caption   = "Grande Grupo :"
1043:         ENDWITH
1044: 
1045:         THIS.AddObject("txt_4c__gde_grupo", "TextBox")
1046:         WITH THIS.txt_4c__gde_grupo
1047:             .FontName      = "Tahoma"
1048:             .BorderStyle   = 1
1049:             .SpecialEffect = 1
1050:             .Format        = "K"
1051:             .MaxLength     = 3
1052:             .Top           = 315
1053:             .Left          = 303
1054:             .Width         = 31
1055:             .Height        = 23
1056:             .TabIndex      = 18
1057:             .ForeColor     = RGB(0,0,0)
1058:             .Value         = ""
1059:         ENDWITH
1060:     ENDPROC
1061: 
1062:     *==========================================================================
1063:     * ConfigurarCamposGrupoProduto
1064:     * Linha "Grupo Produto : [getCgru] [getDgru]" (Top=340/344)
1065:     * fwBuscaExt(legado) -> SigCdGrp.CGrus/DGrus
1066:     *==========================================================================
1067:     PROTECTED PROCEDURE ConfigurarCamposGrupoProduto()
1068:         THIS.AddObject("lbl_4c_Label11", "Label")
1069:         WITH THIS.lbl_4c_Label11
1070:             .FontName  = "Tahoma"
1071:             .BackStyle = 0
1072:             .Alignment = 0
1073:             .AutoSize  = .F.
1074:             .Top       = 344
1075:             .Left      = 219
1076:             .Width     = 79
1077:             .Height    = 15
1078:             .TabIndex  = 58
1079:             .ForeColor = RGB(90,90,90)
1080:             .Caption   = "Grupo Produto :"
1081:         ENDWITH
1082: 
1083:         THIS.AddObject("txt_4c_Cgru", "TextBox")
1084:         WITH THIS.txt_4c_Cgru
1085:             .FontName      = "Tahoma"
1086:             .BorderStyle   = 1
1087:             .SpecialEffect = 1
1088:             .Format        = "K"
1089:             .MaxLength     = 3
1090:             .Top           = 340
1091:             .Left          = 303
1092:             .Width         = 31
1093:             .Height        = 23
1094:             .TabIndex      = 19
1095:             .ForeColor     = RGB(0,0,0)
1096:             .Value         = ""
1097:         ENDWITH
1098: 
1099:         THIS.AddObject("txt_4c_Dgru", "TextBox")
1100:         WITH THIS.txt_4c_Dgru
1101:             .FontName      = "Tahoma"
1102:             .BorderStyle   = 1
1103:             .SpecialEffect = 1
1104:             .Format        = "K"
1105:             .MaxLength     = 40
1106:             .Top           = 340
1107:             .Left          = 336

*-- Linhas 1119 a 1162:
1119:     * fwBuscaExt(legado) -> SigCdPsg.Codigos/Descricaos, filtrado por
1120:     * CGrus = Padr(getCgru.Value, 3) - ver AbrirBuscaSubgrupo*.
1121:     *==========================================================================
1122:     PROTECTED PROCEDURE ConfigurarCamposSubgrupoProduto()
1123:         THIS.AddObject("lbl_4c_Label21", "Label")
1124:         WITH THIS.lbl_4c_Label21
1125:             .FontName  = "Tahoma"
1126:             .BackStyle = 0
1127:             .Alignment = 0
1128:             .AutoSize  = .F.
1129:             .Top       = 370
1130:             .Left      = 202
1131:             .Width     = 96
1132:             .Height    = 15
1133:             .TabIndex  = 59
1134:             .ForeColor = RGB(90,90,90)
1135:             .Caption   = "Subgrupo Produto :"
1136:         ENDWITH
1137: 
1138:         THIS.AddObject("txt_4c_CSGru", "TextBox")
1139:         WITH THIS.txt_4c_CSGru
1140:             .FontName      = "Tahoma"
1141:             .BorderStyle   = 1
1142:             .SpecialEffect = 1
1143:             .Format        = "K"
1144:             .MaxLength     = 10
1145:             .Top           = 366
1146:             .Left          = 303
1147:             .Width         = 80
1148:             .Height        = 21
1149:             .TabIndex      = 21
1150:             .ForeColor     = RGB(0,0,0)
1151:             .Value         = ""
1152:         ENDWITH
1153: 
1154:         THIS.AddObject("txt_4c_DSGru", "TextBox")
1155:         WITH THIS.txt_4c_DSGru
1156:             .FontName      = "Tahoma"
1157:             .BorderStyle   = 1
1158:             .SpecialEffect = 1
1159:             .Format        = "K"
1160:             .MaxLength     = 40
1161:             .Top           = 366
1162:             .Left          = 385

*-- Linhas 1174 a 1217:
1174:     * SCX diz "Grupo Venda" mas o lookup legado consulta SigCdCol
1175:     * (Colecoes/Descs) - transcrito literal (PILAR 1 - rotulo nao se corrige).
1176:     *==========================================================================
1177:     PROTECTED PROCEDURE ConfigurarCamposGrupoVenda()
1178:         THIS.AddObject("lbl_4c_Label17", "Label")
1179:         WITH THIS.lbl_4c_Label17
1180:             .FontName  = "Tahoma"
1181:             .BackStyle = 0
1182:             .Alignment = 0
1183:             .AutoSize  = .F.
1184:             .Top       = 394
1185:             .Left      = 227
1186:             .Width     = 71
1187:             .Height    = 15
1188:             .TabIndex  = 60
1189:             .ForeColor = RGB(90,90,90)
1190:             .Caption   = "Grupo Venda :"
1191:         ENDWITH
1192: 
1193:         THIS.AddObject("txt_4c_Col", "TextBox")
1194:         WITH THIS.txt_4c_Col
1195:             .FontName      = "Tahoma"
1196:             .BorderStyle   = 1
1197:             .SpecialEffect = 1
1198:             .Format        = "K"
1199:             .MaxLength     = 10
1200:             .Top           = 390
1201:             .Left          = 303
1202:             .Width         = 80
1203:             .Height        = 23
1204:             .TabIndex      = 23
1205:             .ForeColor     = RGB(0,0,0)
1206:             .Value         = ""
1207:         ENDWITH
1208: 
1209:         THIS.AddObject("txt_4c_DCol", "TextBox")
1210:         WITH THIS.txt_4c_DCol
1211:             .FontName      = "Tahoma"
1212:             .BorderStyle   = 1
1213:             .SpecialEffect = 1
1214:             .Format        = "K"
1215:             .MaxLength     = 40
1216:             .Top           = 390
1217:             .Left          = 385

*-- Linhas 1228 a 1310:
1228:     * Linha "Linha : [GetLin]" (Top=415/419)
1229:     * fwBuscaExt(legado) -> SigCdLin.linhas/descs
1230:     *==========================================================================
1231:     PROTECTED PROCEDURE ConfigurarCamposLinha()
1232:         THIS.AddObject("lbl_4c_Label16", "Label")
1233:         WITH THIS.lbl_4c_Label16
1234:             .FontName  = "Tahoma"
1235:             .BackStyle = 0
1236:             .Alignment = 0
1237:             .AutoSize  = .F.
1238:             .Top       = 419
1239:             .Left      = 264
1240:             .Width     = 34
1241:             .Height    = 15
1242:             .TabIndex  = 61
1243:             .ForeColor = RGB(90,90,90)
1244:             .Caption   = "Linha :"
1245:         ENDWITH
1246: 
1247:         THIS.AddObject("txt_4c_Lin", "TextBox")
1248:         WITH THIS.txt_4c_Lin
1249:             .FontName      = "Tahoma"
1250:             .BorderStyle   = 1
1251:             .SpecialEffect = 1
1252:             .Format        = "K"
1253:             .MaxLength     = 10
1254:             .Top           = 415
1255:             .Left          = 303
1256:             .Width         = 80
1257:             .Height        = 23
1258:             .TabIndex      = 25
1259:             .ForeColor     = RGB(0,0,0)
1260:             .Value         = ""
1261:         ENDWITH
1262:     ENDPROC
1263: 
1264:     *==========================================================================
1265:     * ConfigurarCamposLocal
1266:     * Linha "Local do Produto : [Get_Local]" (Top=440/444) e linha
1267:     * "Local da Etiqueta : [getLocalizas]" (Top=465/469) - ambas consultam
1268:     * SigPrLcl.Codigos/Descricaos (fwBuscaExt no legado).
1269:     *==========================================================================
1270:     PROTECTED PROCEDURE ConfigurarCamposLocal()
1271:         THIS.AddObject("lbl_4c_Label14", "Label")
1272:         WITH THIS.lbl_4c_Label14
1273:             .FontName  = "Tahoma"
1274:             .BackStyle = 0
1275:             .Alignment = 0
1276:             .AutoSize  = .F.
1277:             .Top       = 444
1278:             .Left      = 209
1279:             .Width     = 89
1280:             .Height    = 15
1281:             .TabIndex  = 62
1282:             .ForeColor = RGB(90,90,90)
1283:             .Caption   = "Local do Produto :"
1284:         ENDWITH
1285: 
1286:         THIS.AddObject("txt_4c_Local", "TextBox")
1287:         WITH THIS.txt_4c_Local
1288:             .FontName      = "Tahoma"
1289:             .BorderStyle   = 1
1290:             .SpecialEffect = 1
1291:             .Format        = "K"
1292:             .MaxLength     = 10
1293:             .Top           = 440
1294:             .Left          = 303
1295:             .Width         = 80
1296:             .Height        = 23
1297:             .TabIndex      = 26
1298:             .ForeColor     = RGB(0,0,0)
1299:             .Value         = ""
1300:         ENDWITH
1301: 
1302:         THIS.AddObject("lbl_4c_Label19", "Label")
1303:         WITH THIS.lbl_4c_Label19
1304:             .FontName  = "Tahoma"
1305:             .BackStyle = 0
1306:             .Alignment = 0
1307:             .AutoSize  = .F.
1308:             .Top       = 469
1309:             .Left      = 207
1310:             .Width     = 91

*-- Linhas 1337 a 1436:
1337:     * fwBuscaExt(legado) -> SigPrPmc.promos (coluna unica - codigo e
1338:     * descricao sao a mesma coisa)
1339:     *==========================================================================
1340:     PROTECTED PROCEDURE ConfigurarCamposPromocao()
1341:         THIS.AddObject("lbl_4c_Label18", "Label")
1342:         WITH THIS.lbl_4c_Label18
1343:             .FontName  = "Tahoma"
1344:             .BackStyle = 0
1345:             .Alignment = 0
1346:             .AutoSize  = .F.
1347:             .Top       = 494
1348:             .Left      = 242
1349:             .Width     = 58
1350:             .Height    = 15
1351:             .TabIndex  = 64
1352:             .ForeColor = RGB(90,90,90)
1353:             .Caption   = "Promo" + CHR(231) + CHR(227) + "o :"
1354:         ENDWITH
1355: 
1356:         THIS.AddObject("txt_4c__promos", "TextBox")
1357:         WITH THIS.txt_4c__promos
1358:             .FontName      = "Tahoma"
1359:             .BorderStyle   = 1
1360:             .SpecialEffect = 1
1361:             .MaxLength     = 15
1362:             .Top           = 490
1363:             .Left          = 303
1364:             .Width         = 185
1365:             .Height        = 23
1366:             .TabIndex      = 28
1367:             .ForeColor     = RGB(0,0,0)
1368:             .Value         = ""
1369:         ENDWITH
1370:     ENDPROC
1371: 
1372:     *==========================================================================
1373:     * ConfigurarCamposOrdemMarca
1374:     * OptionGroup "Ordem :" (Get_Ordem, 5 botoes: Produto/Etiqueta/
1375:     * Operacao/Referencia Fornecedor/Categoria + Grupo - Top=513/516) e
1376:     * OptionGroup "Marca :" (Opt_Marcas, 2 botoes: Sim/Nao - Top=531/536).
1377:     * Legendas e Lefts/Widths transcritos literal do dump do SCX (regra
1378:     * #45 - NUNCA inventar legenda/ordem de OptionGroup).
1379:     *==========================================================================
1380:     PROTECTED PROCEDURE ConfigurarCamposOrdemMarca()
1381:         THIS.AddObject("lbl_4c_Label3", "Label")
1382:         WITH THIS.lbl_4c_Label3
1383:             .FontName  = "Tahoma"
1384:             .BackStyle = 0
1385:             .Alignment = 0
1386:             .AutoSize  = .F.
1387:             .Top       = 516
1388:             .Left      = 257
1389:             .Width     = 40
1390:             .Height    = 15
1391:             .TabIndex  = 65
1392:             .ForeColor = RGB(90,90,90)
1393:             .Caption   = "Ordem :"
1394:         ENDWITH
1395: 
1396:         THIS.AddObject("obj_4c_Get_Ordem", "OptionGroup")
1397:         WITH THIS.obj_4c_Get_Ordem
1398:             .ButtonCount = 5
1399:             .BackStyle   = 0
1400:             .BorderStyle = 0
1401:             .Top         = 513
1402:             .Left        = 297
1403:             .Width       = 513
1404:             .Height      = 20
1405:             .TabIndex    = 29
1406:             .Value       = 1
1407:         ENDWITH
1408: 
1409:         WITH THIS.obj_4c_Get_Ordem.Buttons(1)
1410:             .FontName  = "Tahoma"
1411:             .FontSize  = 8
1412:             .BackStyle = 0
1413:             .Top       = 2
1414:             .Left      = 5
1415:             .Width     = 63
1416:             .Height    = 15
1417:             .ForeColor = RGB(90,90,90)
1418:             .Caption   = "Produto"
1419:         ENDWITH
1420: 
1421:         WITH THIS.obj_4c_Get_Ordem.Buttons(2)
1422:             .FontName  = "Tahoma"
1423:             .FontSize  = 8
1424:             .BackStyle = 0
1425:             .Top       = 2
1426:             .Left      = 71
1427:             .Width     = 65
1428:             .Height    = 15
1429:             .ForeColor = RGB(90,90,90)
1430:             .Caption   = "Etiqueta"
1431:         ENDWITH
1432: 
1433:         WITH THIS.obj_4c_Get_Ordem.Buttons(3)
1434:             .FontName  = "Tahoma"
1435:             .FontSize  = 8
1436:             .BackStyle = 0

*-- Linhas 1482 a 2563:
1482:             .Caption   = "Marca :"
1483:         ENDWITH
1484: 
1485:         THIS.AddObject("obj_4c_Opt_Marcas", "OptionGroup")
1486:         WITH THIS.obj_4c_Opt_Marcas
1487:             .AutoSize    = .T.
1488:             .ButtonCount = 2
1489:             .BackStyle   = 0
1490:             .BorderStyle = 0
1491:             .Top         = 531
1492:             .Left        = 297
1493:             .Width       = 118
1494:             .Height      = 27
1495:             .TabIndex    = 30
1496:             .Value       = 1
1497:         ENDWITH
1498: 
1499:         WITH THIS.obj_4c_Opt_Marcas.Buttons(1)
1500:             .FontName  = "Tahoma"
1501:             .FontSize  = 8
1502:             .BackStyle = 0
1503:             .Top       = 5
1504:             .Left      = 5
1505:             .Width     = 42
1506:             .Height    = 17
1507:             .ForeColor = RGB(90,90,90)
1508:             .Caption   = "Sim"
1509:         ENDWITH
1510: 
1511:         WITH THIS.obj_4c_Opt_Marcas.Buttons(2)
1512:             .FontName  = "Tahoma"
1513:             .FontSize  = 8
1514:             .BackStyle = 0
1515:             .Top       = 5
1516:             .Left      = 71
1517:             .Width     = 42
1518:             .Height    = 17
1519:             .ForeColor = RGB(90,90,90)
1520:             .Caption   = "N" + CHR(227) + "o"
1521:         ENDWITH
1522:     ENDPROC
1523: 
1524:     *==========================================================================
1525:     * ConfigurarEventosLookup
1526:     * Registra todos os BINDEVENT "LostFocus" dos campos com lookup/
1527:     * validacao cruzada (regra #47 - NUNCA em "KeyPress" sem testar tecla).
1528:     * Handlers tem de ser PUBLIC (regra #3 - BINDEVENT so dispara metodo
1529:     * PUBLIC).
1530:     *==========================================================================
1531:     PROTECTED PROCEDURE ConfigurarEventosLookup()
1532:         BINDEVENT(THIS.txt_4c__cd_empresa,    "LostFocus", THIS, "ValidarCdEmpresaLostFocus")
1533:         BINDEVENT(THIS.txt_4c__ds_empresa,    "LostFocus", THIS, "ValidarDsEmpresaLostFocus")
1534:         BINDEVENT(THIS.txt_4c__nm_operacao,   "LostFocus", THIS, "ValidarOperacaoLostFocus")
1535:         BINDEVENT(THIS.txt_4c__nm_industria,  "LostFocus", THIS, "ValidarIndustriaLostFocus")
1536:         BINDEVENT(THIS.txt_4c_Datai,          "LostFocus", THIS, "ValidarDataiLostFocus")
1537:         BINDEVENT(THIS.txt_4c_Dataf,          "LostFocus", THIS, "ValidarDatafLostFocus")
1538:         BINDEVENT(THIS.txt_4c_Cod,            "LostFocus", THIS, "ValidarCodProdutoLostFocus")
1539:         BINDEVENT(THIS.txt_4c_Dcod,           "LostFocus", THIS, "ValidarDescProdutoLostFocus")
1540:         BINDEVENT(THIS.txt_4c_Etii,           "LostFocus", THIS, "ValidarEtiiLostFocus")
1541:         BINDEVENT(THIS.txt_4c_Etif,           "LostFocus", THIS, "ValidarEtifLostFocus")
1542:         BINDEVENT(THIS.txt_4c__Cd_GrEstoque,  "LostFocus", THIS, "ValidarCdGrEstoqueLostFocus")
1543:         BINDEVENT(THIS.txt_4c__Ds_GrEstoque,  "LostFocus", THIS, "ValidarDsGrEstoqueLostFocus")
1544:         BINDEVENT(THIS.txt_4c__cd_estoque,    "LostFocus", THIS, "ValidarCdEstoqueLostFocus")
1545:         BINDEVENT(THIS.txt_4c__ds_estoque,    "LostFocus", THIS, "ValidarDsEstoqueLostFocus")
1546:         BINDEVENT(THIS.txt_4c__gde_grupo,     "LostFocus", THIS, "ValidarGrandeGrupoLostFocus")
1547:         BINDEVENT(THIS.txt_4c_Cgru,           "LostFocus", THIS, "ValidarGrupoProdutoLostFocus")
1548:         BINDEVENT(THIS.txt_4c_Dgru,           "LostFocus", THIS, "ValidarDescGrupoProdutoLostFocus")
1549:         BINDEVENT(THIS.txt_4c_CSGru,          "LostFocus", THIS, "ValidarSubgrupoCodLostFocus")
1550:         BINDEVENT(THIS.txt_4c_DSGru,          "LostFocus", THIS, "ValidarSubgrupoDescLostFocus")
1551:         BINDEVENT(THIS.txt_4c_Col,            "LostFocus", THIS, "ValidarGrupoVendaCodLostFocus")
1552:         BINDEVENT(THIS.txt_4c_DCol,           "LostFocus", THIS, "ValidarGrupoVendaDescLostFocus")
1553:         BINDEVENT(THIS.txt_4c_Lin,            "LostFocus", THIS, "ValidarLinhaLostFocus")
1554:         BINDEVENT(THIS.txt_4c_Local,          "LostFocus", THIS, "ValidarLocalProdutoLostFocus")
1555:         BINDEVENT(THIS.txt_4c_Localizas,      "LostFocus", THIS, "ValidarLocalEtiquetaLostFocus")
1556:         BINDEVENT(THIS.txt_4c__promos,        "LostFocus", THIS, "ValidarPromocaoLostFocus")
1557:     ENDPROC
1558: 
1559:     *==========================================================================
1560:     * AjustarDependenciasCampos
1561:     * Reproduz os "When" do legado (campo so eh editavel sob certa
1562:     * condicao). Chamado apos cada LostFocus relevante e uma vez na
1563:     * inicializacao.
1564:     *
1565:     * Os 14 "When" do SCX, transcritos LITERALMENTE:
1566:     *   get_dcod          Empty(get_cod.Value)
1567:     *   get_ds_empresa    Empty(get_cd_empresa.Value)
1568:     *   get_nm_operacao   Empty(get_nm_industria.Value)
1569:     *   get_nm_industria  Empty(get_nm_operacao.Value)
1570:     *   Get_Numero        Not Empty(get_nm_operacao) or Not Empty(get_nm_industria)
1571:     *   Get_Numerof       (idem Get_Numero)
1572:     *   Get_qtdEti        Empty(get_Etif.Value)
1573:     *   get_cd_estoque    Not Empty(get_cd_grestoque.Value)
1574:     *   get_ds_estoque    Empty(get_cd_estoque) And Not Empty(get_cd_grestoque)
1575:     *   get_Ds_GrEstoque  Empty(get_cd_grestoque.Value)
1576:     *   getDgru           .F. quando Not Empty(GetCgru.Value)
1577:     *   GetCSGru          !Empty(getCgru.Value)
1578:     *   GetDSGru          !Empty(getCgru.Value) And Empty(GetCSGru.Value)
1579:     *   GetDCol           Empty(GetCol.Value)
1580:     *
1581:     * O campo de DESCRICAO de um par codigo/descricao eh editavel enquanto o
1582:     * CODIGO esta VAZIO (eh a via alternativa de busca: digita-se um OU o
1583:     * outro). Inverter esse sentido desabilita a descricao justamente no
1584:     * estado em que ela seria usada - e, como preencher o codigo ja preenche
1585:     * a descricao pelo lookup, o campo ficaria inalcancavel para sempre.
1586:     *
1587:     * Empresa: nao tem "When" no SCX, mas o Init do legado a TRAVA quando
1588:     * SigCdPac.fixaemp = 1 ("get_Cd_Empresa.enabled = .F."). Como este metodo
1589:     * roda a cada LostFocus, a trava tem de ser reafirmada AQUI - repor
1590:     * .Enabled = .T. sem olhar o parametro destravaria no primeiro LostFocus
1591:     * o campo que o Init acabou de travar.
1592:     *==========================================================================
1593:     PROTECTED PROCEDURE AjustarDependenciasCampos()
1594:         LOCAL loc_lTemOperacao, loc_lTemIndustria, loc_lFixaEmpresa, loc_lTemGrEstoque
1595: 
1596:         loc_lFixaEmpresa = .F.
1597:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1598:             loc_lFixaEmpresa = (THIS.this_oBusinessObject.this_nFixaEmpresa = 1)
1599:         ENDIF
1600: 
1601:         THIS.txt_4c__cd_empresa.Enabled = !loc_lFixaEmpresa
1602:         THIS.txt_4c__ds_empresa.Enabled = EMPTY(ALLTRIM(THIS.txt_4c__cd_empresa.Value))
1603: 
1604:         loc_lTemOperacao  = !EMPTY(ALLTRIM(THIS.txt_4c__nm_operacao.Value))
1605:         loc_lTemIndustria = !EMPTY(ALLTRIM(THIS.txt_4c__nm_industria.Value))
1606:         THIS.txt_4c__nm_industria.Enabled = !loc_lTemOperacao
1607:         THIS.txt_4c__nm_operacao.Enabled  = !loc_lTemIndustria
1608:         THIS.txt_4c_Numero.Enabled        = loc_lTemOperacao OR loc_lTemIndustria
1609:         THIS.txt_4c_Numerof.Enabled       = loc_lTemOperacao OR loc_lTemIndustria
1610: 
1611:         THIS.txt_4c_Dcod.Enabled = EMPTY(ALLTRIM(THIS.txt_4c_Cod.Value))
1612: 
1613:         THIS.txt_4c_QtdEti.Enabled = EMPTY(THIS.txt_4c_Etif.Value)
1614: 
1615:         loc_lTemGrEstoque = !EMPTY(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value))
1616:         THIS.txt_4c__Ds_GrEstoque.Enabled = !loc_lTemGrEstoque
1617:         THIS.txt_4c__cd_estoque.Enabled   = loc_lTemGrEstoque
1618:         THIS.txt_4c__ds_estoque.Enabled   = EMPTY(ALLTRIM(THIS.txt_4c__cd_estoque.Value)) AND ;
1619:                                             loc_lTemGrEstoque
1620: 
1621:         THIS.txt_4c_Dgru.Enabled  = EMPTY(ALLTRIM(THIS.txt_4c_Cgru.Value))
1622:         THIS.txt_4c_CSGru.Enabled = !EMPTY(ALLTRIM(THIS.txt_4c_Cgru.Value))
1623:         THIS.txt_4c_DSGru.Enabled = !EMPTY(ALLTRIM(THIS.txt_4c_Cgru.Value)) AND ;
1624:                                      EMPTY(ALLTRIM(THIS.txt_4c_CSGru.Value))
1625: 
1626:         THIS.txt_4c_DCol.Enabled = EMPTY(ALLTRIM(THIS.txt_4c_Col.Value))
1627:     ENDPROC
1628: 
1629:     *==========================================================================
1630:     * ValidarCdEmpresaLostFocus / ValidarDsEmpresaLostFocus
1631:     * fAcessoEmpresa(legado) -> SigCdEmp.Cemps/Razas (regra CLAUDE.md
1632:     * "fAcessoEmpresa() NAO EXISTE" - substituicao canonica AbrirLookupCanonico)
1633:     *==========================================================================
1634:     PROCEDURE ValidarCdEmpresaLostFocus()
1635:         LOCAL loc_cValor
1636: 
1637:         IF THIS.this_lEmLookup
1638:             RETURN
1639:         ENDIF
1640: 
1641:         loc_cValor = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
1642:         IF loc_cValor == THIS.this_cUltimoValidarCdEmpresaLostFocusValidado
1643:             RETURN
1644:         ENDIF
1645:         THIS.this_lEmLookup = .T.
1646: 
1647:         IF !EMPTY(loc_cValor)
1648:             THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
1649:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa", loc_cValor, ;
1650:                 THIS.txt_4c__cd_empresa, THIS.txt_4c__ds_empresa)
1651:         ELSE
1652:             THIS.txt_4c__ds_empresa.Value = ""
1653:         ENDIF
1654: 
1655:         THIS.this_cUltimoValidarCdEmpresaLostFocusValidado = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
1656:         THIS.AjustarDependenciasCampos()
1657:         THIS.this_lEmLookup = .F.
1658:     ENDPROC
1659: 
1660:     PROCEDURE ValidarDsEmpresaLostFocus()
1661:         LOCAL loc_cValor
1662: 
1663:         IF THIS.this_lEmLookup
1664:             RETURN
1665:         ENDIF
1666: 
1667:         loc_cValor = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
1668:         IF loc_cValor == THIS.this_cUltimoValidarDsEmpresaLostFocusValidado
1669:             RETURN
1670:         ENDIF
1671:         THIS.this_lEmLookup = .T.
1672: 
1673:         IF !EMPTY(loc_cValor)
1674:             THIS.AbrirLookupCanonico("SigCdEmp", "Razas", "Cemps", ;
1675:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa", loc_cValor, ;
1676:                 THIS.txt_4c__ds_empresa, THIS.txt_4c__cd_empresa)
1677:         ENDIF
1678: 
1679:         THIS.this_cUltimoValidarDsEmpresaLostFocusValidado = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
1680:         THIS.AjustarDependenciasCampos()
1681:         THIS.this_lEmLookup = .F.
1682:     ENDPROC
1683: 
1684:     *==========================================================================
1685:     * AbrirLookupOperacaoIndustria
1686:     * Compartilhado por Operacao e Industria (regra #27 - fAcessoMovmto eh
1687:     * funcao global do legado indisponivel na nova arquitetura; ambos os
1688:     * campos do SCX validam contra a MESMA tabela SigCdOpd.dopps - o
1689:     * Valid de get_nm_industria faz SEEK/fwBuscaInt sobre SigCdOpd.dopps, e
1690:     * get_nm_operacao.Valid chama fAcessoMovmto sobre o mesmo dominio).
1691:     *==========================================================================
1692:     PROTECTED PROCEDURE AbrirLookupOperacaoIndustria(par_oTxt)
1693:         LOCAL loc_cValor
1694: 
1695:         loc_cValor = ALLTRIM(par_oTxt.Value)
1696:         IF !EMPTY(loc_cValor)
1697:             THIS.AbrirLookupCanonico("SigCdOpd", "dopps", "dopps", ;
1698:                 "Sele" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(227) + "o", ;
1699:                 loc_cValor, par_oTxt, .NULL.)
1700:         ENDIF
1701:     ENDPROC
1702: 
1703:     PROCEDURE ValidarOperacaoLostFocus()
1704:         LOCAL loc_cValor
1705: 
1706:         IF THIS.this_lEmLookup
1707:             RETURN
1708:         ENDIF
1709: 
1710:         loc_cValor = ALLTRIM(THIS.txt_4c__nm_operacao.Value)
1711:         IF loc_cValor == THIS.this_cUltimoValidarOperacaoLostFocusValidado
1712:             RETURN
1713:         ENDIF
1714:         THIS.this_lEmLookup = .T.
1715: 
1716:         THIS.AbrirLookupOperacaoIndustria(THIS.txt_4c__nm_operacao)
1717: 
1718:         THIS.this_cUltimoValidarOperacaoLostFocusValidado = ALLTRIM(THIS.txt_4c__nm_operacao.Value)
1719:         THIS.AjustarDependenciasCampos()
1720:         THIS.this_lEmLookup = .F.
1721:     ENDPROC
1722: 
1723:     PROCEDURE ValidarIndustriaLostFocus()
1724:         LOCAL loc_cValor
1725: 
1726:         IF THIS.this_lEmLookup
1727:             RETURN
1728:         ENDIF
1729: 
1730:         loc_cValor = ALLTRIM(THIS.txt_4c__nm_industria.Value)
1731:         IF loc_cValor == THIS.this_cUltimoValidarIndustriaLostFocusValidado
1732:             RETURN
1733:         ENDIF
1734:         THIS.this_lEmLookup = .T.
1735: 
1736:         THIS.AbrirLookupOperacaoIndustria(THIS.txt_4c__nm_industria)
1737: 
1738:         THIS.this_cUltimoValidarIndustriaLostFocusValidado = ALLTRIM(THIS.txt_4c__nm_industria.Value)
1739:         THIS.AjustarDependenciasCampos()
1740:         THIS.this_lEmLookup = .F.
1741:     ENDPROC
1742: 
1743:     *==========================================================================
1744:     * ValidarDataiLostFocus / ValidarDatafLostFocus
1745:     * Data Final nao pode ser menor que a Data Inicial (transcrito literal
1746:     * de Get_Dataf.Valid do legado)
1747:     *==========================================================================
1748:     PROCEDURE ValidarDataiLostFocus()
1749:         THIS.AjustarDependenciasCampos()
1750:     ENDPROC
1751: 
1752:     PROCEDURE ValidarDatafLostFocus()
1753:         IF !EMPTY(THIS.txt_4c_Datai.Value) AND !EMPTY(THIS.txt_4c_Dataf.Value) AND ;
1754:            THIS.txt_4c_Dataf.Value < THIS.txt_4c_Datai.Value
1755:             MsgAviso("Data Final Deve Ser Maior Que a Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
1756:             THIS.txt_4c_Dataf.SetFocus()
1757:         ENDIF
1758:     ENDPROC
1759: 
1760:     *==========================================================================
1761:     * ValidarCodProdutoLostFocus / ValidarDescProdutoLostFocus
1762:     * fwBuscaExt(legado) -> SigCdPro.CPros/DPros
1763:     *==========================================================================
1764:     PROCEDURE ValidarCodProdutoLostFocus()
1765:         LOCAL loc_cValor
1766: 
1767:         IF THIS.this_lEmLookup
1768:             RETURN
1769:         ENDIF
1770: 
1771:         loc_cValor = ALLTRIM(THIS.txt_4c_Cod.Value)
1772:         IF loc_cValor == THIS.this_cUltimoValidarCodProdutoLostFocusValidado
1773:             RETURN
1774:         ENDIF
1775:         THIS.this_lEmLookup = .T.
1776: 
1777:         IF !EMPTY(loc_cValor)
1778:             THIS.AbrirLookupCanonico("SigCdPro", "CPros", "DPros", "Produtos", ;
1779:                 loc_cValor, THIS.txt_4c_Cod, THIS.txt_4c_Dcod)
1780:         ELSE
1781:             THIS.txt_4c_Dcod.Value = ""
1782:         ENDIF
1783: 
1784:         THIS.this_cUltimoValidarCodProdutoLostFocusValidado = ALLTRIM(THIS.txt_4c_Cod.Value)
1785:         THIS.AjustarDependenciasCampos()
1786:         THIS.this_lEmLookup = .F.
1787:     ENDPROC
1788: 
1789:     PROCEDURE ValidarDescProdutoLostFocus()
1790:         LOCAL loc_cValor
1791: 
1792:         IF THIS.this_lEmLookup
1793:             RETURN
1794:         ENDIF
1795: 
1796:         loc_cValor = ALLTRIM(THIS.txt_4c_Dcod.Value)
1797:         IF loc_cValor == THIS.this_cUltimoValidarDescProdutoLostFocusValidado
1798:             RETURN
1799:         ENDIF
1800:         THIS.this_lEmLookup = .T.
1801: 
1802:         IF !EMPTY(loc_cValor)
1803:             THIS.AbrirLookupCanonico("SigCdPro", "DPros", "CPros", "Produtos", ;
1804:                 loc_cValor, THIS.txt_4c_Dcod, THIS.txt_4c_Cod)
1805:         ENDIF
1806: 
1807:         THIS.this_cUltimoValidarDescProdutoLostFocusValidado = ALLTRIM(THIS.txt_4c_Dcod.Value)
1808:         THIS.AjustarDependenciasCampos()
1809:         THIS.this_lEmLookup = .F.
1810:     ENDPROC
1811: 
1812:     *==========================================================================
1813:     * ValidarEtiiLostFocus / ValidarEtifLostFocus
1814:     * Faixa de codigo de barras - transcrito literal do Valid legado:
1815:     * busca em SigOpEtq (com fallback na troca de codigo SigOpEta) e avisa
1816:     * se a etiqueta nao esta cadastrada. NAO eh lookup FormBuscaAuxiliar -
1817:     * eh SQL direto (SigOpEtq.cbars numeric(14,0)).
1818:     *==========================================================================
1819:     PROCEDURE ValidarEtiiLostFocus()
1820:         LOCAL loc_cSQL, loc_nResultado
1821: 
1822:         IF THIS.txt_4c_Etii.Value = 0
1823:             THIS.AjustarDependenciasCampos()
1824:             RETURN
1825:         ENDIF
1826: 
1827:         loc_cSQL = "SELECT a.CPros, a.CBars " + ;
1828:                    "FROM SigOpEtq a " + ;
1829:                    "LEFT JOIN sigopeta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
1830:                    "WHERE (a.CBars = " + FormatarNumeroSQL(THIS.txt_4c_Etii.Value, 0) + ;
1831:                    " OR b.cbars_old = " + FormatarNumeroSQL(THIS.txt_4c_Etii.Value, 0) + ")"
1832: 
1833:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Etiqs")
1834:         IF loc_nResultado < 1 OR !USED("cursor_4c_Etiqs") OR RECCOUNT("cursor_4c_Etiqs") = 0
1835:             MsgAviso("Etiqueta N" + CHR(227) + "o Cadastrada!!!", "Aten" + CHR(231) + CHR(227) + "o")
1836:             THIS.txt_4c_Etii.Value = 0
1837:         ELSE
1838:             SELECT cursor_4c_Etiqs
1839:             GO TOP
1840:             THIS.txt_4c_Etii.Value = cursor_4c_Etiqs.CBars
1841:         ENDIF
1842:         IF USED("cursor_4c_Etiqs")
1843:             USE IN cursor_4c_Etiqs
1844:         ENDIF
1845: 
1846:         IF THIS.txt_4c_Etif.Value = 0 AND THIS.txt_4c_Etii.Value != 0
1847:             THIS.txt_4c_Etif.Value = THIS.txt_4c_Etii.Value
1848:         ENDIF
1849: 
1850:         THIS.AjustarDependenciasCampos()
1851:     ENDPROC
1852: 
1853:     PROCEDURE ValidarEtifLostFocus()
1854:         LOCAL loc_cSQL, loc_nResultado
1855: 
1856:         IF THIS.txt_4c_Etif.Value = 0
1857:             THIS.AjustarDependenciasCampos()
1858:             RETURN
1859:         ENDIF
1860: 
1861:         loc_cSQL = "SELECT a.CPros, a.CBars " + ;
1862:                    "FROM SigOpEtq a " + ;
1863:                    "LEFT JOIN sigopeta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
1864:                    "WHERE (a.CBars = " + FormatarNumeroSQL(THIS.txt_4c_Etif.Value, 0) + ;
1865:                    " OR b.cbars_old = " + FormatarNumeroSQL(THIS.txt_4c_Etif.Value, 0) + ")"
1866: 
1867:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Etiqs")
1868:         IF loc_nResultado < 1 OR !USED("cursor_4c_Etiqs") OR RECCOUNT("cursor_4c_Etiqs") = 0
1869:             MsgAviso("Etiqueta N" + CHR(227) + "o Cadastrada!!!", "Aten" + CHR(231) + CHR(227) + "o")
1870:             THIS.txt_4c_Etif.Value = 0
1871:         ELSE
1872:             SELECT cursor_4c_Etiqs
1873:             GO TOP
1874:             THIS.txt_4c_Etif.Value = cursor_4c_Etiqs.CBars
1875:         ENDIF
1876:         IF USED("cursor_4c_Etiqs")
1877:             USE IN cursor_4c_Etiqs
1878:         ENDIF
1879: 
1880:         THIS.AjustarDependenciasCampos()
1881:     ENDPROC
1882: 
1883:     *==========================================================================
1884:     * ValidarCdGrEstoqueLostFocus / ValidarDsGrEstoqueLostFocus
1885:     * fAcessoContab(legado) -> SigCdGcr.codigos/descrs, filtrado por
1886:     * Estoques = 1 (Grupo de Estoque, nao Grupo CC generico)
1887:     *==========================================================================
1888:     PROCEDURE ValidarCdGrEstoqueLostFocus()
1889:         LOCAL loc_cValor
1890: 
1891:         IF THIS.this_lEmLookup
1892:             RETURN
1893:         ENDIF
1894: 
1895:         loc_cValor = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
1896:         IF loc_cValor == THIS.this_cUltimoValidarCdGrEstoqueLostFocusValidado
1897:             RETURN
1898:         ENDIF
1899:         THIS.this_lEmLookup = .T.
1900: 
1901:         IF !EMPTY(loc_cValor)
1902:             THIS.AbrirLookupCanonico("SigCdGcr", "codigos", "descrs", ;
1903:                 "Grupo de Estoque", loc_cValor, ;
1904:                 THIS.txt_4c__Cd_GrEstoque, THIS.txt_4c__Ds_GrEstoque, "Estoques = 1")
1905:         ELSE
1906:             THIS.txt_4c__Ds_GrEstoque.Value = ""
1907:         ENDIF
1908: 
1909:         THIS.this_cUltimoValidarCdGrEstoqueLostFocusValidado = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
1910:         THIS.AjustarDependenciasCampos()
1911:         THIS.this_lEmLookup = .F.
1912:     ENDPROC
1913: 
1914:     PROCEDURE ValidarDsGrEstoqueLostFocus()
1915:         LOCAL loc_cValor
1916: 
1917:         IF THIS.this_lEmLookup
1918:             RETURN
1919:         ENDIF
1920: 
1921:         loc_cValor = ALLTRIM(THIS.txt_4c__Ds_GrEstoque.Value)
1922:         IF loc_cValor == THIS.this_cUltimoValidarDsGrEstoqueLostFocusValidado
1923:             RETURN
1924:         ENDIF
1925:         THIS.this_lEmLookup = .T.
1926: 
1927:         IF !EMPTY(loc_cValor)
1928:             THIS.AbrirLookupCanonico("SigCdGcr", "descrs", "codigos", ;
1929:                 "Grupo de Estoque", loc_cValor, ;
1930:                 THIS.txt_4c__Ds_GrEstoque, THIS.txt_4c__Cd_GrEstoque, "Estoques = 1")
1931:         ELSE
1932:             THIS.txt_4c__Cd_GrEstoque.Value = ""
1933:         ENDIF
1934: 
1935:         THIS.this_cUltimoValidarDsGrEstoqueLostFocusValidado = ALLTRIM(THIS.txt_4c__Ds_GrEstoque.Value)
1936:         THIS.AjustarDependenciasCampos()
1937:         THIS.this_lEmLookup = .F.
1938:     ENDPROC
1939: 
1940:     *==========================================================================
1941:     * ValidarCdEstoqueLostFocus / ValidarDsEstoqueLostFocus
1942:     * fAcessoContas(legado) -> SigCdCli.Iclis/Rclis, filtrado pelo Grupo de
1943:     * Estoque corrente (txt_4c__Cd_GrEstoque)
1944:     *==========================================================================
1945:     PROCEDURE ValidarCdEstoqueLostFocus()
1946:         LOCAL loc_cValor, loc_cGrupo, loc_cFiltro
1947: 
1948:         IF THIS.this_lEmLookup
1949:             RETURN
1950:         ENDIF
1951: 
1952:         loc_cValor = ALLTRIM(THIS.txt_4c__cd_estoque.Value)
1953:         IF loc_cValor == THIS.this_cUltimoValidarCdEstoqueLostFocusValidado
1954:             RETURN
1955:         ENDIF
1956:         THIS.this_lEmLookup = .T.
1957: 
1958:         loc_cGrupo = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
1959:         IF !EMPTY(loc_cValor)
1960:             loc_cFiltro = IIF(!EMPTY(loc_cGrupo), "Grupos = " + EscaparSQL(loc_cGrupo), "")
1961:             THIS.AbrirLookupCanonico("SigCdCli", "Iclis", "Rclis", "Estoque", ;
1962:                 loc_cValor, THIS.txt_4c__cd_estoque, THIS.txt_4c__ds_estoque, loc_cFiltro)
1963:         ELSE
1964:             THIS.txt_4c__ds_estoque.Value = ""
1965:         ENDIF
1966: 
1967:         THIS.this_cUltimoValidarCdEstoqueLostFocusValidado = ALLTRIM(THIS.txt_4c__cd_estoque.Value)
1968:         THIS.AjustarDependenciasCampos()
1969:         THIS.this_lEmLookup = .F.
1970:     ENDPROC
1971: 
1972:     PROCEDURE ValidarDsEstoqueLostFocus()
1973:         LOCAL loc_cValor, loc_cGrupo, loc_cFiltro
1974: 
1975:         IF THIS.this_lEmLookup
1976:             RETURN
1977:         ENDIF
1978: 
1979:         loc_cValor = ALLTRIM(THIS.txt_4c__ds_estoque.Value)
1980:         IF loc_cValor == THIS.this_cUltimoValidarDsEstoqueLostFocusValidado
1981:             RETURN
1982:         ENDIF
1983:         THIS.this_lEmLookup = .T.
1984: 
1985:         loc_cGrupo = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
1986:         IF !EMPTY(loc_cValor)
1987:             loc_cFiltro = IIF(!EMPTY(loc_cGrupo), "Grupos = " + EscaparSQL(loc_cGrupo), "")
1988:             THIS.AbrirLookupCanonico("SigCdCli", "Rclis", "Iclis", "Estoque", ;
1989:                 loc_cValor, THIS.txt_4c__ds_estoque, THIS.txt_4c__cd_estoque, loc_cFiltro)
1990:         ELSE
1991:             THIS.txt_4c__cd_estoque.Value = ""
1992:         ENDIF
1993: 
1994:         THIS.this_cUltimoValidarDsEstoqueLostFocusValidado = ALLTRIM(THIS.txt_4c__ds_estoque.Value)
1995:         THIS.AjustarDependenciasCampos()
1996:         THIS.this_lEmLookup = .F.
1997:     ENDPROC
1998: 
1999:     *==========================================================================
2000:     * ValidarGrandeGrupoLostFocus - fwBuscaExt(legado) -> SigCdGpr.Codigos/Descs
2001:     * (sem campo de descricao na tela - legado tambem so grava o codigo)
2002:     *==========================================================================
2003:     PROCEDURE ValidarGrandeGrupoLostFocus()
2004:         LOCAL loc_cValor
2005: 
2006:         IF THIS.this_lEmLookup
2007:             RETURN
2008:         ENDIF
2009: 
2010:         loc_cValor = ALLTRIM(THIS.txt_4c__gde_grupo.Value)
2011:         IF loc_cValor == THIS.this_cUltimoValidarGrandeGrupoLostFocusValidado
2012:             RETURN
2013:         ENDIF
2014:         THIS.this_lEmLookup = .T.
2015: 
2016:         IF !EMPTY(loc_cValor)
2017:             THIS.AbrirLookupCanonico("SigCdGpr", "Codigos", "Descs", "Grande Grupo", ;
2018:                 loc_cValor, THIS.txt_4c__gde_grupo, .NULL.)
2019:         ENDIF
2020: 
2021:         THIS.this_cUltimoValidarGrandeGrupoLostFocusValidado = ALLTRIM(THIS.txt_4c__gde_grupo.Value)
2022:         THIS.AjustarDependenciasCampos()
2023:         THIS.this_lEmLookup = .F.
2024:     ENDPROC
2025: 
2026:     *==========================================================================
2027:     * ValidarGrupoProdutoLostFocus / ValidarDescGrupoProdutoLostFocus
2028:     * fwBuscaExt(legado) -> SigCdGrp.CGrus/DGrus
2029:     *==========================================================================
2030:     PROCEDURE ValidarGrupoProdutoLostFocus()
2031:         LOCAL loc_cValor
2032: 
2033:         IF THIS.this_lEmLookup
2034:             RETURN
2035:         ENDIF
2036: 
2037:         loc_cValor = ALLTRIM(THIS.txt_4c_Cgru.Value)
2038:         IF loc_cValor == THIS.this_cUltimoValidarGrupoProdutoLostFocusValidado
2039:             RETURN
2040:         ENDIF
2041:         THIS.this_lEmLookup = .T.
2042: 
2043:         IF !EMPTY(loc_cValor)
2044:             THIS.AbrirLookupCanonico("SigCdGrp", "CGrus", "DGrus", "Grupos", ;
2045:                 loc_cValor, THIS.txt_4c_Cgru, THIS.txt_4c_Dgru)
2046:         ELSE
2047:             THIS.txt_4c_Dgru.Value = ""
2048:         ENDIF
2049: 
2050:         THIS.this_cUltimoValidarGrupoProdutoLostFocusValidado = ALLTRIM(THIS.txt_4c_Cgru.Value)
2051:         THIS.AjustarDependenciasCampos()
2052:         THIS.this_lEmLookup = .F.
2053:     ENDPROC
2054: 
2055:     PROCEDURE ValidarDescGrupoProdutoLostFocus()
2056:         LOCAL loc_cValor
2057: 
2058:         IF THIS.this_lEmLookup
2059:             RETURN
2060:         ENDIF
2061: 
2062:         loc_cValor = ALLTRIM(THIS.txt_4c_Dgru.Value)
2063:         IF loc_cValor == THIS.this_cUltimoValidarDescGrupoProdutoLostFocusValidado
2064:             RETURN
2065:         ENDIF
2066:         THIS.this_lEmLookup = .T.
2067: 
2068:         IF !EMPTY(loc_cValor)
2069:             THIS.AbrirLookupCanonico("SigCdGrp", "DGrus", "CGrus", "Grupos", ;
2070:                 loc_cValor, THIS.txt_4c_Dgru, THIS.txt_4c_Cgru)
2071:         ENDIF
2072: 
2073:         THIS.this_cUltimoValidarDescGrupoProdutoLostFocusValidado = ALLTRIM(THIS.txt_4c_Dgru.Value)
2074:         THIS.AjustarDependenciasCampos()
2075:         THIS.this_lEmLookup = .F.
2076:     ENDPROC
2077: 
2078:     *==========================================================================
2079:     * ValidarSubgrupoCodLostFocus / ValidarSubgrupoDescLostFocus
2080:     * fwBuscaExt(legado) -> SigCdPsg.Codigos/Descricaos, filtrado por
2081:     * CGrus = Padr(getCgru.Value, 3) - so habilitado com Grupo Produto
2082:     * preenchido (ver AjustarDependenciasCampos)
2083:     *==========================================================================
2084:     PROCEDURE ValidarSubgrupoCodLostFocus()
2085:         LOCAL loc_cValor, loc_cFiltro
2086: 
2087:         IF THIS.this_lEmLookup
2088:             RETURN
2089:         ENDIF
2090: 
2091:         loc_cValor = ALLTRIM(THIS.txt_4c_CSGru.Value)
2092:         IF loc_cValor == THIS.this_cUltimoValidarSubgrupoCodLostFocusValidado
2093:             RETURN
2094:         ENDIF
2095:         THIS.this_lEmLookup = .T.
2096: 
2097:         loc_cFiltro = "CGrus = " + EscaparSQL(PADR(ALLTRIM(THIS.txt_4c_Cgru.Value), 3))
2098:         IF !EMPTY(loc_cValor)
2099:             THIS.AbrirLookupCanonico("SigCdPsg", "Codigos", "Descricaos", "Sub-Grupos", ;
2100:                 loc_cValor, THIS.txt_4c_CSGru, THIS.txt_4c_DSGru, loc_cFiltro)
2101:         ELSE
2102:             THIS.txt_4c_DSGru.Value = ""
2103:         ENDIF
2104: 
2105:         THIS.this_cUltimoValidarSubgrupoCodLostFocusValidado = ALLTRIM(THIS.txt_4c_CSGru.Value)
2106:         THIS.AjustarDependenciasCampos()
2107:         THIS.this_lEmLookup = .F.
2108:     ENDPROC
2109: 
2110:     PROCEDURE ValidarSubgrupoDescLostFocus()
2111:         LOCAL loc_cValor, loc_cFiltro
2112: 
2113:         IF THIS.this_lEmLookup
2114:             RETURN
2115:         ENDIF
2116: 
2117:         loc_cValor = ALLTRIM(THIS.txt_4c_DSGru.Value)
2118:         IF loc_cValor == THIS.this_cUltimoValidarSubgrupoDescLostFocusValidado
2119:             RETURN
2120:         ENDIF
2121:         THIS.this_lEmLookup = .T.
2122: 
2123:         loc_cFiltro = "CGrus = " + EscaparSQL(PADR(ALLTRIM(THIS.txt_4c_Cgru.Value), 3))
2124:         IF !EMPTY(loc_cValor)
2125:             THIS.AbrirLookupCanonico("SigCdPsg", "Descricaos", "Codigos", "Sub-Grupos", ;
2126:                 loc_cValor, THIS.txt_4c_DSGru, THIS.txt_4c_CSGru, loc_cFiltro)
2127:         ELSE
2128:             THIS.txt_4c_CSGru.Value = ""
2129:         ENDIF
2130: 
2131:         THIS.this_cUltimoValidarSubgrupoDescLostFocusValidado = ALLTRIM(THIS.txt_4c_DSGru.Value)
2132:         THIS.AjustarDependenciasCampos()
2133:         THIS.this_lEmLookup = .F.
2134:     ENDPROC
2135: 
2136:     *==========================================================================
2137:     * ValidarGrupoVendaCodLostFocus / ValidarGrupoVendaDescLostFocus
2138:     * fwBuscaExt(legado) -> SigCdCol.Colecoes/Descs
2139:     *==========================================================================
2140:     PROCEDURE ValidarGrupoVendaCodLostFocus()
2141:         LOCAL loc_cValor
2142: 
2143:         IF THIS.this_lEmLookup
2144:             RETURN
2145:         ENDIF
2146: 
2147:         loc_cValor = ALLTRIM(THIS.txt_4c_Col.Value)
2148:         IF loc_cValor == THIS.this_cUltimoValidarGrupoVendaCodLostFocusValidado
2149:             RETURN
2150:         ENDIF
2151:         THIS.this_lEmLookup = .T.
2152: 
2153:         IF !EMPTY(loc_cValor)
2154:             THIS.AbrirLookupCanonico("SigCdCol", "Colecoes", "Descs", "Sele" + CHR(231) + CHR(227) + "o", ;
2155:                 loc_cValor, THIS.txt_4c_Col, THIS.txt_4c_DCol)
2156:         ELSE
2157:             THIS.txt_4c_DCol.Value = ""
2158:         ENDIF
2159: 
2160:         THIS.this_cUltimoValidarGrupoVendaCodLostFocusValidado = ALLTRIM(THIS.txt_4c_Col.Value)
2161:         THIS.AjustarDependenciasCampos()
2162:         THIS.this_lEmLookup = .F.
2163:     ENDPROC
2164: 
2165:     PROCEDURE ValidarGrupoVendaDescLostFocus()
2166:         LOCAL loc_cValor
2167: 
2168:         IF THIS.this_lEmLookup
2169:             RETURN
2170:         ENDIF
2171: 
2172:         loc_cValor = ALLTRIM(THIS.txt_4c_DCol.Value)
2173:         IF loc_cValor == THIS.this_cUltimoValidarGrupoVendaDescLostFocusValidado
2174:             RETURN
2175:         ENDIF
2176:         THIS.this_lEmLookup = .T.
2177: 
2178:         IF !EMPTY(loc_cValor)
2179:             THIS.AbrirLookupCanonico("SigCdCol", "Descs", "Colecoes", "Sele" + CHR(231) + CHR(227) + "o", ;
2180:                 loc_cValor, THIS.txt_4c_DCol, THIS.txt_4c_Col)
2181:         ENDIF
2182: 
2183:         THIS.this_cUltimoValidarGrupoVendaDescLostFocusValidado = ALLTRIM(THIS.txt_4c_DCol.Value)
2184:         THIS.AjustarDependenciasCampos()
2185:         THIS.this_lEmLookup = .F.
2186:     ENDPROC
2187: 
2188:     *==========================================================================
2189:     * ValidarLinhaLostFocus - fwBuscaExt(legado) -> SigCdLin.linhas/descs
2190:     * (sem campo de descricao na tela)
2191:     *==========================================================================
2192:     PROCEDURE ValidarLinhaLostFocus()
2193:         LOCAL loc_cValor
2194: 
2195:         IF THIS.this_lEmLookup
2196:             RETURN
2197:         ENDIF
2198: 
2199:         loc_cValor = ALLTRIM(THIS.txt_4c_Lin.Value)
2200:         IF loc_cValor == THIS.this_cUltimoValidarLinhaLostFocusValidado
2201:             RETURN
2202:         ENDIF
2203:         THIS.this_lEmLookup = .T.
2204: 
2205:         IF !EMPTY(loc_cValor)
2206:             THIS.AbrirLookupCanonico("SigCdLin", "linhas", "descs", "Sele" + CHR(231) + CHR(227) + "o", ;
2207:                 loc_cValor, THIS.txt_4c_Lin, .NULL.)
2208:         ENDIF
2209: 
2210:         THIS.this_cUltimoValidarLinhaLostFocusValidado = ALLTRIM(THIS.txt_4c_Lin.Value)
2211:         THIS.AjustarDependenciasCampos()
2212:         THIS.this_lEmLookup = .F.
2213:     ENDPROC
2214: 
2215:     *==========================================================================
2216:     * ValidarLocalProdutoLostFocus / ValidarLocalEtiquetaLostFocus
2217:     * fwBuscaExt(legado) -> SigPrLcl.Codigos/Descricaos (sem campo de
2218:     * descricao na tela - legado tambem so grava o codigo)
2219:     *==========================================================================
2220:     PROCEDURE ValidarLocalProdutoLostFocus()
2221:         LOCAL loc_cValor
2222: 
2223:         IF THIS.this_lEmLookup
2224:             RETURN
2225:         ENDIF
2226: 
2227:         loc_cValor = ALLTRIM(THIS.txt_4c_Local.Value)
2228:         IF loc_cValor == THIS.this_cUltimoValidarLocalProdutoLostFocusValidado
2229:             RETURN
2230:         ENDIF
2231:         THIS.this_lEmLookup = .T.
2232: 
2233:         IF !EMPTY(loc_cValor)
2234:             THIS.AbrirLookupCanonico("SigPrLcl", "Codigos", "Descricaos", "Sele" + CHR(231) + CHR(227) + "o", ;
2235:                 loc_cValor, THIS.txt_4c_Local, .NULL.)
2236:         ENDIF
2237: 
2238:         THIS.this_cUltimoValidarLocalProdutoLostFocusValidado = ALLTRIM(THIS.txt_4c_Local.Value)
2239:         THIS.AjustarDependenciasCampos()
2240:         THIS.this_lEmLookup = .F.
2241:     ENDPROC
2242: 
2243:     PROCEDURE ValidarLocalEtiquetaLostFocus()
2244:         LOCAL loc_cValor
2245: 
2246:         IF THIS.this_lEmLookup
2247:             RETURN
2248:         ENDIF
2249: 
2250:         loc_cValor = ALLTRIM(THIS.txt_4c_Localizas.Value)
2251:         IF loc_cValor == THIS.this_cUltimoValidarLocalEtiquetaLostFocusValidado
2252:             RETURN
2253:         ENDIF
2254:         THIS.this_lEmLookup = .T.
2255: 
2256:         IF !EMPTY(loc_cValor)
2257:             THIS.AbrirLookupCanonico("SigPrLcl", "Codigos", "Descricaos", "Sele" + CHR(231) + CHR(227) + "o", ;
2258:                 loc_cValor, THIS.txt_4c_Localizas, .NULL.)
2259:         ENDIF
2260: 
2261:         THIS.this_cUltimoValidarLocalEtiquetaLostFocusValidado = ALLTRIM(THIS.txt_4c_Localizas.Value)
2262:         THIS.AjustarDependenciasCampos()
2263:         THIS.this_lEmLookup = .F.
2264:     ENDPROC
2265: 
2266:     *==========================================================================
2267:     * ValidarPromocaoLostFocus - fwBuscaExt(legado) -> SigPrPmc.promos
2268:     * (coluna unica - codigo e descricao sao a mesma coisa)
2269:     *==========================================================================
2270:     PROCEDURE ValidarPromocaoLostFocus()
2271:         LOCAL loc_cValor
2272: 
2273:         IF THIS.this_lEmLookup
2274:             RETURN
2275:         ENDIF
2276: 
2277:         loc_cValor = ALLTRIM(THIS.txt_4c__promos.Value)
2278:         IF loc_cValor == THIS.this_cUltimoValidarPromocaoLostFocusValidado
2279:             RETURN
2280:         ENDIF
2281:         THIS.this_lEmLookup = .T.
2282: 
2283:         IF !EMPTY(loc_cValor)
2284:             THIS.AbrirLookupCanonico("SigPrPmc", "promos", "promos", "Promo" + CHR(231) + CHR(227) + "o", ;
2285:                 loc_cValor, THIS.txt_4c__promos, .NULL.)
2286:         ENDIF
2287: 
2288:         THIS.this_cUltimoValidarPromocaoLostFocusValidado = ALLTRIM(THIS.txt_4c__promos.Value)
2289:         THIS.AjustarDependenciasCampos()
2290:         THIS.this_lEmLookup = .F.
2291:     ENDPROC
2292: 
2293:     *==========================================================================
2294:     * FormParaBO - transcreve TODOS os campos de filtro da tela para as
2295:     * propriedades do BO (ja declaradas nas Fases 1-2), no INSTANTE do
2296:     * clique - equivalente ao bloco de variaveis PRIVATE do consulta.Click
2297:     * legado:
2298:     *   pcCdProduto = ThisForm.get_cod.Value        / pcDsProduto = ...get_dcod.Value
2299:     *   pdDtInicial = ThisForm.Get_datai.Value       / pdDtFinal = Iif(IsEmpty(...Get_dataf.Value), Ctod([31/12/9999]), ...)
2300:     *   pnEtiqIni/pnEtiqFim/pnOrdem/pcestoque/pcgrestoque/pcOperacao/
2301:     *   pcindustria/pnNumero/pnNumerof/OptMarca/pcGrupo/pcSGrus/pcColecoes/
2302:     *   pcGdeGrupo/pcEmpresa/pnQtdEti/pcLinha/pcDepto/pcLocaliza/pcPromos
2303:     *
2304:     * Usado so por BtnConsultaClick - Digitacao/Arquivadas NAO leem a tela
2305:     * (o legado reseta a maior parte dos filtros para esses dois modos, ver
2306:     * comentario de cada Btn*Click).
2307:     *==========================================================================
2308:     PROTECTED PROCEDURE FormParaBO()
2309:         WITH THIS.this_oBusinessObject
2310:             .this_cCodigo      = ALLTRIM(THIS.txt_4c_Cod.Value)
2311:             .this_cDescricao   = ALLTRIM(THIS.txt_4c_Dcod.Value)
2312:             .this_dDataIni     = THIS.txt_4c_Datai.Value
2313:             .this_dDataFim     = IIF(EMPTY(THIS.txt_4c_Dataf.Value), CTOD("31/12/9999"), THIS.txt_4c_Dataf.Value)
2314:             .this_nEtiquetaIni = THIS.txt_4c_Etii.Value
2315:             .this_nEtiquetaFim = THIS.txt_4c_Etif.Value
2316:             .this_nQtdEtiqueta = THIS.txt_4c_QtdEti.Value
2317:             .this_cGrEstoque   = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
2318:             .this_cEstoque     = ALLTRIM(THIS.txt_4c__cd_estoque.Value)
2319:             .this_cOperacao    = ALLTRIM(THIS.txt_4c__nm_operacao.Value)
2320:             .this_cIndustria   = ALLTRIM(THIS.txt_4c__nm_industria.Value)
2321:             .this_nNumero      = THIS.txt_4c_Numero.Value
2322:             .this_nNumerof     = THIS.txt_4c_Numerof.Value
2323:             .this_cEmpresa     = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
2324:             .this_cDsEmpresa   = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
2325:             .this_cGrupo       = ALLTRIM(THIS.txt_4c_Cgru.Value)
2326:             .this_cDsGrupo     = ALLTRIM(THIS.txt_4c_Dgru.Value)
2327:             .this_cSubGrupo    = ALLTRIM(THIS.txt_4c_CSGru.Value)
2328:             .this_cDsSubGrupo  = ALLTRIM(THIS.txt_4c_DSGru.Value)
2329:             .this_cGrandeGrupo = ALLTRIM(THIS.txt_4c__gde_grupo.Value)
2330:             .this_cLinha       = ALLTRIM(THIS.txt_4c_Lin.Value)
2331:             .this_cLocal       = ALLTRIM(THIS.txt_4c_Local.Value)
2332:             .this_cLocalizacao = ALLTRIM(THIS.txt_4c_Localizas.Value)
2333:             .this_cColecao     = ALLTRIM(THIS.txt_4c_Col.Value)
2334:             .this_cDsColecao   = ALLTRIM(THIS.txt_4c_DCol.Value)
2335:             .this_cPromocao    = ALLTRIM(THIS.txt_4c__promos.Value)
2336:             .this_nOrdem       = THIS.obj_4c_Get_Ordem.Value
2337:             .this_nMarca       = THIS.obj_4c_Opt_Marcas.Value
2338:             .this_nPreco       = THIS.obj_4c_Chk_Preco.Value
2339:         ENDWITH
2340:     ENDPROC
2341: 
2342:     *==========================================================================
2343:     * BtnConsultaClick - equivalente a SIGPRRET.sair.consulta.Click: monta o
2344:     * filtro completo da tela (FormParaBO), marca THIS.this_cTipo = 'CONSULTA'
2345:     * (equivalente a ThisForm.Tipo) e delega para a tela de impressao
2346:     * (fora do escopo desta migracao - ver comentario no topo do arquivo).
2347:     *==========================================================================
2348:     PROCEDURE BtnConsultaClick()
2349:         THIS.FormParaBO()
2350:         THIS.DespacharImpressao("CONSULTA")
2351:     ENDPROC
2352: 
2353:     *==========================================================================
2354:     * BtnEncerrarClick - equivalente a SIGPRRET.sair.sair.Click: "ThisForm.
2355:     * Release" - unico caminho de saida da tela (form Flat, sem Page2/Dados
2356:     * para cancelar).
2357:     *==========================================================================
2358:     PROCEDURE BtnEncerrarClick()
2359:         THIS.Release()
2360:     ENDPROC
2361: 
2362:     *==========================================================================
2363:     * BtnDigitacaoClick - equivalente a SIGPRRET.sair.btnDigitacao.Click.
2364:     *
2365:     * O legado NAO le a tela aqui: o Click declara um bloco PRIVATE proprio e
2366:     * zera os filtros um a um (Space()/{}/0), deixando apenas DUAS excecoes
2367:     * lidas da tela - "pnOrdem = ThisForm.Get_Ordem.Value" e
2368:     * "pcPromos = Thisform.Get_Promos.Value".
2369:     *
2370:     * O reset vai por LimparDados() do BO em vez de repetir aquela lista aqui,
2371:     * por causa do CICLO DE VIDA: no legado cada Click cria as PRIVATE do zero
2372:     * e as que ele nao cita simplesmente NAO EXISTEM quando SigOpIpE roda. No
2373:     * sistema novo o BO eh LONGO - o form nao fecha entre um clique e outro -,
2374:     * entao copiar so a lista do legado deixaria Industria, SubGrupo, Linha,
2375:     * Local, Localizacao e Qtd. de Etiquetas com o valor de uma CONSULTA
2376:     * anterior, e a digitacao sairia filtrada por criterio que o usuario nao
2377:     * pediu, sem erro nenhum na tela. LimparDados() repoe o estado inicial
2378:     * INTEIRO (e preserva this_nFixaEmpresa, que eh parametro, nao filtro).
2379:     *==========================================================================
2380:     PROCEDURE BtnDigitacaoClick()
2381:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2382:             RETURN
2383:         ENDIF
2384: 
2385:         THIS.this_oBusinessObject.LimparDados()
2386: 
2387:         WITH THIS.this_oBusinessObject
2388:             *-- "OptMarca = 1" do legado (LimparDados ja repoe o mesmo 1,
2389:             *-- explicito aqui porque eh linha do bloco transcrito)
2390:             .this_nMarca    = 1
2391: 
2392:             *-- As DUAS excecoes do legado, lidas da tela
2393:             .this_nOrdem    = THIS.obj_4c_Get_Ordem.Value
2394:             .this_cPromocao = ALLTRIM(THIS.txt_4c__promos.Value)
2395:         ENDWITH
2396: 
2397:         THIS.DespacharImpressao("DIGITACAO")
2398:     ENDPROC
2399: 
2400:     *==========================================================================
2401:     * BtnArquivadasClick - equivalente a SIGPRRET.sair.Arquivadas.Click.
2402:     *
2403:     * Mesmo reset de BtnDigitacaoClick, com UMA diferenca transcrita literal
2404:     * do legado: "pnOrdem = 1" - a Ordem vem FIXA em 1, NAO da tela, ao
2405:     * contrario de btnDigitacao. Promocao continua lida da tela.
2406:     *==========================================================================
2407:     PROCEDURE BtnArquivadasClick()
2408:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2409:             RETURN
2410:         ENDIF
2411: 
2412:         THIS.this_oBusinessObject.LimparDados()
2413: 
2414:         WITH THIS.this_oBusinessObject
2415:             *-- "OptMarca = 1" / "pnOrdem = 1" - os dois FIXOS no legado
2416:             .this_nMarca    = 1
2417:             .this_nOrdem    = 1
2418: 
2419:             *-- Unica excecao lida da tela
2420:             .this_cPromocao = ALLTRIM(THIS.txt_4c__promos.Value)
2421:         ENDWITH
2422: 
2423:         THIS.DespacharImpressao("ARQUIVADAS")
2424:     ENDPROC
2425: 
2426:     *==========================================================================
2427:     * AplicarFixaEmpresa - Regra "fixa empresa" do Init do legado.
2428:     *
2429:     * Transcreve o bloco (mena - 02/04/2017) do SIGPRRET.Init:
2430:     *   m.lcMcrSql1 = [select a.* from SigCdPac a ]
2431:     *   m.lnErro1   = .poDatamgr.Sqlexecute(m.lcMcrSql1,'crSigCdpac')
2432:     *   IF crSigCdpac.fixaemp = 1
2433:     *       ThisForm.get_Cd_Empresa.value   = _empr
2434:     *       ThisForm.get_Cd_Empresa.enabled = .F.
2435:     *       fAcessoEmpresa(Usuar, 'C', _empr, ThisForm.get_Cd_Empresa, ThisForm.get_Ds_Empresa)
2436:     *   ENDIF
2437:     *
2438:     * _EMPR eh LEGADO e NAO se usa (CLAUDE.md) - o equivalente eh
2439:     * go_4c_Sistema.cCodEmpresa. fAcessoEmpresa tambem nao foi portada; aqui
2440:     * o codigo eh EXATO e nao ha nada a escolher, por isso a resolucao da
2441:     * Razao Social vai por SigPrRetBO.CarregarEmpresa() (consulta direta) e
2442:     * nao pelo picker de AbrirLookupCanonico, que SEMPRE abre dialogo.
2443:     *
2444:     * Sem o parametro aplicado o campo Empresa fica livre e a consulta sai
2445:     * com a empresa errada, sem erro nenhum na tela.
2446:     *==========================================================================
2447:     PROTECTED PROCEDURE AplicarFixaEmpresa()
2448:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2449:             RETURN
2450:         ENDIF
2451: 
2452:         *-- Harness de UI/teste roda sem conexao (gnConnHandle = 0/-1 de
2453:         *-- proposito): nao ha parametro a ler e o SQLEXEC so geraria ruido.
2454:         IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
2455:            (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
2456:             RETURN
2457:         ENDIF
2458: 
2459:         IF THIS.this_oBusinessObject.CarregarParametros()
2460:             THIS.FixarEmpresaNaTela()
2461:         ENDIF
2462:     ENDPROC
2463: 
2464:     *==========================================================================
2465:     * FixarEmpresaNaTela - Segunda metade de AplicarFixaEmpresa, separada
2466:     * porque o parametro SigCdPac.fixaemp eh lido UMA vez (no Init) e a trava
2467:     * precisa poder ser reafirmada sem reconsultar o banco.
2468:     *==========================================================================
2469:     PROTECTED PROCEDURE FixarEmpresaNaTela()
2470:         LOCAL loc_cEmpresa
2471: 
2472:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2473:             RETURN
2474:         ENDIF
2475: 
2476:         IF THIS.this_oBusinessObject.this_nFixaEmpresa != 1
2477:             RETURN
2478:         ENDIF
2479: 
2480:         loc_cEmpresa = ""
2481:         IF TYPE("go_4c_Sistema") = "O"
2482:             loc_cEmpresa = ALLTRIM(TratarNulo(go_4c_Sistema.cCodEmpresa, ""))
2483:         ENDIF
2484: 
2485:         IF EMPTY(loc_cEmpresa)
2486:             MsgAviso("Par" + CHR(226) + "metro 'fixa empresa' est" + CHR(225) + ;
2487:                      " ligado em SigCdPac, mas a empresa do sistema n" + CHR(227) + ;
2488:                      "o est" + CHR(225) + " definida." + CHR(13) + ;
2489:                      "O filtro Empresa fica liberado.", ;
2490:                      "Aten" + CHR(231) + CHR(227) + "o")
2491:             RETURN
2492:         ENDIF
2493: 
2494:         *-- Resolve a Razao Social no BO e pinta o estado do BO na tela
2495:         THIS.this_oBusinessObject.this_cEmpresa = loc_cEmpresa
2496:         THIS.this_oBusinessObject.CarregarEmpresa(loc_cEmpresa)
2497:         THIS.BOParaForm()
2498: 
2499:         *-- A trava (get_Cd_Empresa.enabled = .F.) sai de
2500:         *-- AjustarDependenciasCampos, que le this_nFixaEmpresa - fonte unica,
2501:         *-- para o primeiro LostFocus nao destravar o campo de novo.
2502:         THIS.AjustarDependenciasCampos()
2503:     ENDPROC
2504: 
2505:     *==========================================================================
2506:     * BOParaForm - Pinta na tela o estado dos filtros guardado no BO.
2507:     *
2508:     * Inverso EXATO de FormParaBO(), campo a campo. Quem alimenta o BO por
2509:     * outro caminho que nao a digitacao (hoje: a regra "fixa empresa" do Init,
2510:     * que resolve a Razao Social a partir do codigo da empresa do sistema)
2511:     * precisa deste sentido para que a tela mostre o que vai ser consultado.
2512:     *
2513:     * this_dDataFim tem tratamento proprio: FormParaBO grava a SENTINELA
2514:     * 31/12/9999 quando o usuario deixa a Data Final em branco (transcrito de
2515:     * "Iif(IsEmpty(...Get_dataf.Value), Ctod([31/12/9999]), ...)"). Pintar
2516:     * essa sentinela de volta exibiria uma data que o legado NUNCA mostra, por
2517:     * isso ela volta para a tela como vazia.
2518:     *
2519:     * Os OptionGroups recebem INDICE 1-based: nunca 0, senao a tela perde a
2520:     * selecao que o SCX entrega por design (Get_Ordem=1, Opt_Marcas=1,
2521:     * Chk_Preco=2).
2522:     *==========================================================================
2523:     PROTECTED PROCEDURE BOParaForm()
2524:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2525:             RETURN
2526:         ENDIF
2527: 
2528:         WITH THIS.this_oBusinessObject
2529:             THIS.txt_4c_Cod.Value           = .this_cCodigo
2530:             THIS.txt_4c_Dcod.Value          = .this_cDescricao
2531:             THIS.txt_4c_Datai.Value         = .this_dDataIni
2532:             THIS.txt_4c_Dataf.Value         = IIF(.this_dDataFim = CTOD("31/12/9999"), ;
2533:                                                   {}, .this_dDataFim)
2534:             THIS.txt_4c_Etii.Value          = .this_nEtiquetaIni
2535:             THIS.txt_4c_Etif.Value          = .this_nEtiquetaFim
2536:             THIS.txt_4c_QtdEti.Value        = .this_nQtdEtiqueta
2537:             THIS.txt_4c__Cd_GrEstoque.Value = .this_cGrEstoque
2538:             THIS.txt_4c__Ds_GrEstoque.Value = .this_cDsGrEstoque
2539:             THIS.txt_4c__cd_estoque.Value   = .this_cEstoque
2540:             THIS.txt_4c__ds_estoque.Value   = .this_cDsEstoque
2541:             THIS.txt_4c__nm_operacao.Value  = .this_cOperacao
2542:             THIS.txt_4c__nm_industria.Value = .this_cIndustria
2543:             THIS.txt_4c_Numero.Value        = .this_nNumero
2544:             THIS.txt_4c_Numerof.Value       = .this_nNumerof
2545:             THIS.txt_4c__cd_empresa.Value   = .this_cEmpresa
2546:             THIS.txt_4c__ds_empresa.Value   = .this_cDsEmpresa
2547:             THIS.txt_4c_Cgru.Value          = .this_cGrupo
2548:             THIS.txt_4c_Dgru.Value          = .this_cDsGrupo
2549:             THIS.txt_4c_CSGru.Value         = .this_cSubGrupo
2550:             THIS.txt_4c_DSGru.Value         = .this_cDsSubGrupo
2551:             THIS.txt_4c__gde_grupo.Value    = .this_cGrandeGrupo
2552:             THIS.txt_4c_Lin.Value           = .this_cLinha
2553:             THIS.txt_4c_Local.Value         = .this_cLocal
2554:             THIS.txt_4c_Localizas.Value     = .this_cLocalizacao
2555:             THIS.txt_4c_Col.Value           = .this_cColecao
2556:             THIS.txt_4c_DCol.Value          = .this_cDsColecao
2557:             THIS.txt_4c__promos.Value       = .this_cPromocao
2558: 
2559:             THIS.obj_4c_Get_Ordem.Value  = IIF(.this_nOrdem >= 1, .this_nOrdem, 1)
2560:             THIS.obj_4c_Opt_Marcas.Value = IIF(.this_nMarca >= 1, .this_nMarca, 1)
2561:             THIS.obj_4c_Chk_Preco.Value  = IIF(.this_nPreco >= 1, .this_nPreco, 2)
2562:         ENDWITH
2563:     ENDPROC

*-- Linhas 2584 a 2646:
2584:     *     aqui qualquer erro de runtime DA OUTRA TELA e o reportaria com o
2585:     *     nome do metodo errado.
2586:     *==========================================================================
2587:     PROTECTED PROCEDURE DespacharImpressao(par_cTipo)
2588:         LOCAL loc_oErro, loc_lDisponivel
2589: 
2590:         *-- Equivalente a ThisForm.Tipo do legado
2591:         THIS.this_cTipo = par_cTipo
2592: 
2593:         loc_lDisponivel = FILE("SigOpIpE.scx")
2594:         IF !loc_lDisponivel AND TYPE("gc_4c_CaminhoForms") = "C"
2595:             loc_lDisponivel = FILE(gc_4c_CaminhoForms + "SigOpIpE.scx")
2596:         ENDIF
2597: 
2598:         IF !loc_lDisponivel
2599:             MsgAviso("A tela de etiquetas (SigOpIpE) ainda n" + CHR(227) + "o foi migrada." + ;
2600:                      CHR(13) + "Os filtros desta tela foram montados e o modo '" + ;
2601:                      ALLTRIM(par_cTipo) + "' foi definido, mas a " + ;
2602:                      "impress" + CHR(227) + "o n" + CHR(227) + "o pode prosseguir.", ;
2603:                      "Impress" + CHR(227) + "o de Etiquetas")
2604:         ELSE
2605:             TRY
2606:                 DO FORM SigOpIpE WITH THIS
2607:             CATCH TO loc_oErro
2608:                 MsgErro(loc_oErro.Message + CHR(13) + ;
2609:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2610:                         "Procedure: " + loc_oErro.Procedure, ;
2611:                         "Erro em SigOpIpE (modo " + ALLTRIM(par_cTipo) + ")")
2612:             ENDTRY
2613:         ENDIF
2614:     ENDPROC
2615: 
2616:     *==========================================================================
2617:     * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
2618:     * FILTRO: nenhum container flutuante neste form
2619:     *==========================================================================
2620:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2621:         LOCAL loc_i, loc_oControl
2622: 
2623:         FOR loc_i = 1 TO par_oContainer.ControlCount
2624:             loc_oControl = par_oContainer.Controls(loc_i)
2625:             IF VARTYPE(loc_oControl) = "O"
2626:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
2627:                     loc_oControl.Visible = .T.
2628:                 ENDIF
2629:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
2630:                     THIS.TornarControlesVisiveis(loc_oControl)
2631:                 ENDIF
2632:             ENDIF
2633:         ENDFOR
2634:     ENDPROC
2635: 
2636:     *==========================================================================
2637:     * Destroy - libera o Business Object e delega ao FormBase
2638:     *==========================================================================
2639:     PROCEDURE Destroy()
2640:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2641:             THIS.this_oBusinessObject = .NULL.
2642:         ENDIF
2643:         DODEFAULT()
2644:     ENDPROC
2645: 
2646: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrRetBO.prg):
*============================================================================
* SigPrRetBO.prg - Business Object para Impressao de Etiquetas (Estoque)
*
* Tela OPERACIONAL (sem CRUD) que monta filtros para impressao de etiquetas
* de produto em lote. Nao existe uma unica tabela "mestre" editada pela
* tela: os filtros cruzam Produto (SigCdPro), Grupo (SigCdGrp/SigCdGpr),
* SubGrupo (SigCdPsg), Grupo Estoque, Operacao, Industria, Empresa
* (SigCdEmp), Local (SigPrLcl), Linha (SigCdLin), Colecao (SigCdCol),
* Promocao (SigPrPmc) e a faixa de etiquetas gravadas em SigOpEtq.
*
* Tabela de referencia (par par_cTabela/par_cCampoChave da BusinessBase):
*   SigCdPro (PK: CPros) - produto filtrado para impressao
*
* Form somente-leitura/filtro: nao grava registro nenhum. Os botoes do
* legado (Consulta/Digitacao/Arquivadas) apenas coletam os filtros acima e
* abrem outro formulario (Do Form SigOpIpE With ThisForm) que realiza a
* impressao propriamente dita - fora do escopo desta migracao (SigPrRet).
*
* Conferido no dump legado (tasks\task670\SigPrRet_form_codigo_fonte.txt):
* ZERO ocorrencias de TABLEUPDATE(), de .AddCursor( e de Insert Into /
* Update / Delete From sobre qualquer tabela - o unico alvo de escrita eh o
* cursor LOCAL csEtiqDig, criado pelo proprio Load. Por isso este BO NAO
* sobrescreve Inserir() / Atualizar() / ExecutarExclusao() / Salvar() /
* Excluir() / RegistrarAuditoria(): o comportamento padrao herdado de
* BusinessBase (recusar a operacao e reportar a recusa pelo ExibirFalha)
* ja eh o correto para esta tela. Sobrescrever esses metodos aqui seria
* fabricar gravacao que o legado nunca executa e violar o PILAR 2.
*
* Os metodos de LEITURA abaixo (CarregarPorCodigo / CarregarDoCursor /
* CarregarOperacoes / CarregarParametros) transcrevem as consultas que o
* legado faz no Init e nos Valid dos campos.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos de carga (CRUD aplicavel a esta tela)
*============================================================================

DEFINE CLASS SigPrRetBO AS BusinessBase

    *==========================================================================
    * Produto (SigCdPro) - filtro de codigo/descricao do produto
    *==========================================================================
    this_cCodigo     = ""   && char(14) - SigCdPro.cpros (PK sigcdpro_cpros)
    this_cDescricao  = ""   && char(65) - SigCdPro.dpros

    *==========================================================================
    * Periodo (data base de inclusao/alteracao do produto)
    *==========================================================================
    this_dDataIni = {}      && Data inicial do periodo
    this_dDataFim = {}      && Data final do periodo

    *==========================================================================
    * Faixa de etiquetas (SigOpEtq / codigo de barras)
    *==========================================================================
    this_nEtiquetaIni = 0   && Etiqueta inicial (faixa numerica de codigo de barras)
    this_nEtiquetaFim = 0   && Etiqueta final (faixa numerica de codigo de barras)
    this_nQtdEtiqueta = 0   && Quantidade de etiquetas a imprimir (alternativa a faixa)
    this_nEtiquetaResolvida = 0   && Saida de ValidarFaixaEtiqueta() - codigo de barras RESOLVIDO

    *==========================================================================
    * Grupo Estoque (filtro + descricao)
    *==========================================================================
    this_cGrEstoque   = ""  && Codigo do Grupo de Estoque
    this_cDsGrEstoque = ""  && Descricao do Grupo de Estoque (exibicao)

    *==========================================================================
    * Estoque (filtro + descricao)
    *==========================================================================
    this_cEstoque   = ""    && Codigo do Estoque
    this_cDsEstoque = ""    && Descricao do Estoque (exibicao)

    *==========================================================================
    * Operacao / Industria (SigCdOpd)
    *==========================================================================
    this_cOperacao  = ""    && Operacao (SigCdOpd.dopps)
    this_cIndustria = ""    && Industria (SigCdOpd.dopps - filtro paralelo)
    this_nNumero    = 0     && Numero vinculado a Operacao
    this_nNumerof   = 0     && Numero vinculado a Industria

    *==========================================================================
    * Empresa (SigCdEmp)
    *==========================================================================
    this_cEmpresa   = ""    && Codigo da Empresa (SigCdEmp.Cemps)
    this_cDsEmpresa = ""    && Razao Social da Empresa (SigCdEmp.Razas, exibicao)

    *==========================================================================
    * Grupo Produto (SigCdGrp) + SubGrupo (SigCdPsg)
    *==========================================================================
    this_cGrupo      = ""   && Codigo do Grupo Produto (SigCdGrp.CGrus)
    this_cDsGrupo    = ""   && Descricao do Grupo Produto (SigCdGrp.DGrus, exibicao)
    this_cSubGrupo   = ""   && Codigo do SubGrupo (SigCdPsg.Codigos)
    this_cDsSubGrupo = ""   && Descricao do SubGrupo (SigCdPsg.Descricaos, exibicao)

    *==========================================================================
    * Grande Grupo (SigCdGpr)
    *==========================================================================
    this_cGrandeGrupo = ""  && Codigo do Grande Grupo (SigCdGpr.Codigos)

    *==========================================================================
    * Linha (SigCdLin) e Local (SigPrLcl)
    *==========================================================================
    this_cLinha = ""        && Codigo da Linha (SigCdLin.linhas)
    this_cLocal = ""        && Codigo do Local do Produto (SigPrLcl.Codigos)

    *==========================================================================
    * Colecao (SigCdCol)
    *==========================================================================
    this_cColecao   = ""    && Codigo da Colecao (SigCdCol.Colecoes)
    this_cDsColecao = ""    && Descricao da Colecao (SigCdCol.Descs, exibicao)

    *==========================================================================
    * Promocao (SigPrPmc) e Localizacao da Etiqueta (SigPrLcl)
    *==========================================================================
    this_cPromocao    = ""  && Codigo da Promocao (SigPrPmc.promos)
    this_cLocalizacao = ""  && Codigo do Local da Etiqueta (SigPrLcl.Codigos)

    *==========================================================================
    * Opcoes de impressao (OptionGroups do legado)
    *==========================================================================
    this_nOrdem = 1         && Get_Ordem - ordem de impressao (1..5 conforme legado)
    this_nMarca = 1         && Opt_Marcas - 1=Todas as marcas, 2=Marca especifica
    this_nPreco = 2         && Chk_Preco - opcao de preco impresso na etiqueta (1..4) - SCX default = 2

    *==========================================================================
    * Parametros do sistema (SigCdPac)
    *==========================================================================
    * numeric(1,0): a propriedade eh NUMERICA de proposito. Achatar a coluna
    * em logico perderia o valor real gravado pelo legado.
    this_nFixaEmpresa = 0   && SigCdPac.fixaemp - 1 trava o campo Empresa em go_4c_Sistema.cCodEmpresa

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPro"
            THIS.this_cCampoChave = "CPros"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Le o produto (SigCdPro) pelo codigo digitado no
    * campo "Codigo :" (Get_cod) e preenche this_cCodigo / this_cDescricao.
    *
    * Equivalente ao trecho do legado que, achando o produto, devolve o par
    * codigo/descricao para a tela (Get_cod.Valid / Get_dcod.Valid):
    *   This.Value                 = crListaRemota.CPros
    *   This.Parent.get_dcod.Value = crListaRemota.DPros
    *
    * par_cCodigo - conteudo do campo Codigo (SigCdPro.cpros - char(14))
    *
    * Retorna .T. quando o produto existe. Devolve .F. SEM exibir dialogo
    * quando nao existe, para o Form abrir o picker de produtos: o legado
    * nunca avisa "produto nao encontrado", ele abre o browse do fwBuscaExt.
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult, loc_cCodigo

        loc_lSucesso = .F.
        loc_cCodigo  = ALLTRIM(NVL(par_cCodigo, ""))

        TRY
            IF !EMPTY(loc_cCodigo)
                loc_cSQL = "SELECT cpros, dpros FROM SigCdPro " + ;
                           " WHERE cpros = " + EscaparSQL(loc_cCodigo)

                IF USED("cursor_4c_Produto")
                    USE IN cursor_4c_Produto
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")

                IF loc_nResult < 0
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MsgErro("Erro ao consultar o produto:" + CHR(13) + ;
                            THIS.this_cMensagemErro, "Erro SQL")
                ELSE
                    IF USED("cursor_4c_Produto") AND RECCOUNT("cursor_4c_Produto") > 0
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Produto")
                    ENDIF
                ENDIF

                IF USED("cursor_4c_Produto")
                    USE IN cursor_4c_Produto
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigPrRetBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Transfere o registro CORRENTE de um cursor com a
    * forma de SigCdPro para as propriedades do BO.
    *
    * Usado em dois caminhos, ambos vindos do legado:
    *   (a) CarregarPorCodigo() acima (consulta exata por cpros);
    *   (b) o cursor devolvido pelo picker de produtos de Get_cod.Valid /
    *       Get_dcod.Valid (fwBuscaExt sobre SigCdPro -> crListaRemota).
    *
    * Mapeia as DUAS colunas que esta tela usa de SigCdPro - exatamente as
    * que o legado transfere para os TextBoxes (CPros e DPros). As demais
    * propriedades do BO sao filtros de OUTRAS tabelas (SigCdGrp, SigCdPsg,
    * SigCdGpr, SigCdCol, SigCdLin, SigPrLcl, SigPrPmc, SigCdEmp) e cada uma
    * eh preenchida pelo lookup da sua propria tabela.
    *
    * par_cAliasCursor - alias do cursor posicionado no registro desejado
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro, loc_cAlias

        loc_lSucesso = .F.
        loc_cAlias   = ALLTRIM(NVL(par_cAliasCursor, ""))

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF()
                    * TYPE() e nao PEMSTATUS(): PEMSTATUS exige OBJETO no 1o
                    * argumento e dispara o erro 11 do VFP9 com alias de cursor.
                    IF TYPE(loc_cAlias + ".cpros") == "C"
                        THIS.this_cCodigo = ALLTRIM(TratarNulo(cpros, ""))
                    ENDIF

                    IF TYPE(loc_cAlias + ".dpros") == "C"
                        THIS.this_cDescricao = ALLTRIM(TratarNulo(dpros, ""))
                    ENDIF

                    loc_lSucesso = !EMPTY(THIS.this_cCodigo)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigPrRetBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarOperacoes - Popula o cursor consultado pelos campos
    * "Operacao :" (get_nm_operacao) e "Industria :" (get_nm_industria).
    *
    * Transcreve o bloco do Init do legado:
    *   m.lcMcrSql1 = [select a.* from SigCdOpd a ]
    *   m.lnErro1   = .poDatamgr.Sqlexecute(m.lcMcrSql1,'SigCdOpd')
    *   If Used('SigCdOpd') / Select('SigCdOpd') / Index On dopps Tag dopps
    *
    * Duas diferencas tecnicas em relacao ao legado, sem mudar comportamento:
    *   - o cursor eh recriado com READWRITE, porque cursor de SQLEXEC nasce
    *     somente-leitura e o INDEX ON precisa de cursor gravavel;
    *   - sao lidas as duas colunas que a tela usa de SigCdOpd (dopps no SEEK
    *     do Valid e ndopps na coluna de codigo do browse); o "a.*" do legado
    *     traria as colunas text (obscab/obsresu) sem nenhum uso aqui.
    *
    * Retorna .T. quando o cursor ficou disponivel e indexado por dopps.
    *==========================================================================
    FUNCTION CarregarOperacoes()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT dopps, ndopps FROM SigCdOpd"

            IF USED("cursor_4c_OperacoesTmp")
                USE IN cursor_4c_OperacoesTmp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacoesTmp")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao carregar as Opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                        THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                IF USED("cursor_4c_Operacoes")
                    USE IN cursor_4c_Operacoes
                ENDIF

                SELECT * FROM cursor_4c_OperacoesTmp ;
                    INTO CURSOR cursor_4c_Operacoes READWRITE

                INDEX ON dopps TAG dopps
                SET ORDER TO TAG dopps
                GO TOP
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_OperacoesTmp")
                USE IN cursor_4c_OperacoesTmp
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigPrRetBO.CarregarOperacoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarParametros - Le o parametro "fixa empresa" (SigCdPac.fixaemp)
    * e guarda em THIS.this_nFixaEmpresa.
    *
    * Transcreve o bloco do Init do legado (mena - 02/04/2017):
    *   m.lcMcrSql1 = [select a.* from SigCdPac a ]
    *   m.lnErro1   = .poDatamgr.Sqlexecute(m.lcMcrSql1,'crSigCdpac')
    *   IF crSigCdpac.fixaemp = 1   && trava o campo Empresa em _EMPR
    *
    * O legado le a PRIMEIRA linha de SigCdPac (tabela de parametros), por
    * isso o GO TOP sem filtro. O VARTYPE eh testado porque coluna de um
    * digito pode chegar do driver ODBC como Logico em vez de Numerico.
    *
    * Retorna .T. quando o parametro foi lido.
    *==========================================================================
    FUNCTION CarregarParametros()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT fixaemp FROM SigCdPac"

            IF USED("cursor_4c_Parametros")
                USE IN cursor_4c_Parametros
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Parametros")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao carregar os par" + CHR(226) + "metros do sistema:" + CHR(13) + ;
                        THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                IF USED("cursor_4c_Parametros") AND RECCOUNT("cursor_4c_Parametros") > 0
                    SELECT cursor_4c_Parametros
                    GO TOP

                    IF VARTYPE(cursor_4c_Parametros.fixaemp) = "N"
                        THIS.this_nFixaEmpresa = NVL(cursor_4c_Parametros.fixaemp, 0)
                    ELSE
                        THIS.this_nFixaEmpresa = IIF(NVL(cursor_4c_Parametros.fixaemp, .F.), 1, 0)
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Parametros")
                USE IN cursor_4c_Parametros
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigPrRetBO.CarregarParametros")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ValidarFaixaEtiqueta - Resolve o codigo de barras digitado (aceita tanto
    * o codigo ANTIGO quanto o NOVO, via o mapeamento de sigopeta) e confere
    * se a etiqueta existe em SigOpEtq.
    *
    * Equivalente ao bloco do legado (Get_Etii.Valid / Get_Etif.Valid):
    *   lStrQuery = Select a.CPros, a.CBars From SigOpEtq a
    *               Left Join sigopeta b On a.cpros = b.cpros And a.cbars = b.cbars_new
    *               Where (a.CBars = <cod> Or b.cbars_old = <cod>)
    *   ThisForm.poDataMgr.CursorQuery('SigOpEtq', 'TmpEti', 'CBars', <resolvido>)
    *   If Eof('TmpEti') ... MsgAviso('Etiqueta Nao Cadastrada!!!') ...
    *
    * par_nCodigoDigitado - codigo de barras digitado pelo usuario (numerico,
    *   ate 14 digitos, igual ao InputMask do legado)
    *
    * Retorna .T. se a etiqueta existe. THIS.this_nEtiquetaResolvida recebe o
    * codigo de barras RESOLVIDO (identico ao digitado quando nao ha
    * mapeamento antigo->novo em sigopeta) para o Form atualizar o TextBox.
    *==========================================================================
    FUNCTION ValidarFaixaEtiqueta(par_nCodigoDigitado)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult, loc_cBarcode

        loc_lSucesso = .F.
        THIS.this_nEtiquetaResolvida = NVL(par_nCodigoDigitado, 0)

        TRY
            loc_cBarcode = ALLTRIM(STR(NVL(par_nCodigoDigitado, 0), 14))

            loc_cSQL = "SELECT a.cpros, a.cbars FROM SigOpEtq a " + ;
                       "LEFT JOIN sigopeta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
                       "WHERE (a.cbars = " + loc_cBarcode + " OR b.cbars_old = " + loc_cBarcode + ")"

            IF USED("cursor_4c_Etiquetas")
                USE IN cursor_4c_Etiquetas
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Etiquetas")

            IF loc_nResult >= 0 AND USED("cursor_4c_Etiquetas") AND RECCOUNT("cursor_4c_Etiquetas") > 0
                SELECT cursor_4c_Etiquetas
                GO TOP
                THIS.this_nEtiquetaResolvida = cursor_4c_Etiquetas.cbars
                loc_lSucesso = .T.
            ELSE
                MsgAviso("Etiqueta N" + CHR(227) + "o Cadastrada!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF

            IF USED("cursor_4c_Etiquetas")
                USE IN cursor_4c_Etiquetas
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigPrRetBO.ValidarFaixaEtiqueta")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * LimparDados - Devolve TODOS os filtros ao estado inicial da tela.
    *
    * Transcreve o bloco de valores iniciais do Init do legado (SIGPRRET.Init,
    * dentro do "If (.poDataMgr.pnIdconn > 0)"):
    *   .get_cod.Value   = Space(10)   .get_dcod.Value  = Space(40)
    *   .get_datai.Value = {}          .get_dataf.Value = {}
    *   .get_etii.Value  = 0           .get_etif.Value  = 0
    *   .get_qtdEti.Value       = 0
    *   .get_cd_estoque.Value   = Space(10)
    *   .get_cd_grestoque.Value = Space(10)
    *   .get_ds_estoque.Value   = Space(20)
    *   .get_ds_grestoque.Value = Space(40)
    *   .get_gde_grupo.Value    = Space(3)
    *
    * Os demais filtros (Operacao/Industria, Numero, Empresa, Grupo/SubGrupo,
    * Linha, Local, Colecao, Promocao, Localizacao) NAO aparecem naquele bloco
    * porque o legado eh MODAL e vive uma unica sessao - eles nascem com o
    * default de design do SCX e nunca sao reaproveitados. O form migrado NAO
    * fecha entre uma consulta e outra, entao o reset tem de ser COMPLETO
    * (mesma armadilha da regra #32: ciclo de vida diferente exige reset
    * explicito) - por isso a segunda metade do metodo, que repoe exatamente
    * o default de design de cada controle do SCX.
    *
    * this_nFixaEmpresa fica de FORA de proposito: eh parametro de sistema
    * (SigCdPac.fixaemp), nao filtro da tela - zera-lo aqui destravaria o
    * campo Empresa que o legado trava.
    *==========================================================================
    PROCEDURE LimparDados()
        *-- Bloco de valores iniciais do Init do legado
        THIS.this_cCodigo        = ""
        THIS.this_cDescricao     = ""
        THIS.this_dDataIni       = {}
        THIS.this_dDataFim       = {}
        THIS.this_nEtiquetaIni   = 0
        THIS.this_nEtiquetaFim   = 0
        THIS.this_nQtdEtiqueta   = 0
        THIS.this_cEstoque       = ""
        THIS.this_cGrEstoque     = ""
        THIS.this_cDsEstoque     = ""
        THIS.this_cDsGrEstoque   = ""
        THIS.this_cGrandeGrupo   = ""

        *-- Default de design do SCX para o resto dos filtros
        THIS.this_cOperacao      = ""
        THIS.this_cIndustria     = ""
        THIS.this_nNumero        = 0
        THIS.this_nNumerof       = 0
        THIS.this_cEmpresa       = ""
        THIS.this_cDsEmpresa     = ""
        THIS.this_cGrupo         = ""
        THIS.this_cDsGrupo       = ""
        THIS.this_cSubGrupo      = ""
        THIS.this_cDsSubGrupo    = ""
        THIS.this_cLinha         = ""
        THIS.this_cLocal         = ""
        THIS.this_cColecao       = ""
        THIS.this_cDsColecao     = ""
        THIS.this_cPromocao      = ""
        THIS.this_cLocalizacao   = ""

        *-- OptionGroups: Value de design do SCX (Get_Ordem=1, Opt_Marcas=1,
        *-- Chk_Preco=2). Sao INDICES 1-based, nunca 0 (regra #45).
        THIS.this_nOrdem         = 1
        THIS.this_nMarca         = 1
        THIS.this_nPreco         = 2

        *-- Saida de ValidarFaixaEtiqueta, nao eh filtro digitado
        THIS.this_nEtiquetaResolvida = 0

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CarregarEmpresa - Resolve a Razao Social de UMA empresa pelo codigo,
    * SEM abrir dialogo de selecao.
    *
    * Necessario para a regra "fixa empresa" do Init do legado, que resolve a
    * descricao de um codigo JA conhecido:
    *   IF crSigCdpac.fixaemp = 1
    *       ThisForm.get_Cd_Empresa.value   = _empr
    *       ThisForm.get_Cd_Empresa.enabled = .F.
    *       fAcessoEmpresa(Usuar, 'C', _empr, ThisForm.get_Cd_Empresa, ThisForm.get_Ds_Empresa)
    *   ENDIF
    *
    * fAcessoEmpresa NAO foi portada (regra "fAcessoEmpresa() NAO EXISTE"); a
    * substituicao canonica para o modo LOOKUP eh o bloco FormBuscaAuxiliar
    * sobre SigCdEmp, mas ele SEMPRE mostra o picker - inadequado no Init, onde
    * o codigo eh exato e nao ha nada a escolher. Dai esta consulta direta.
    *
    * Colunas: SigCdEmp.Cemps (char(3), PK) e SigCdEmp.Razas (char(40)) - os
    * nomes canonicos da tabela (Emps/NComps NAO existem nela).
    *
    * Retorna .T. quando a empresa existe; this_cEmpresa/this_cDsEmpresa
    * recebem codigo e razao social.
    *==========================================================================
    FUNCTION CarregarEmpresa(par_cCodigo)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult, loc_cCodigo

        loc_lSucesso = .F.
        loc_cCodigo  = ALLTRIM(IIF(VARTYPE(par_cCodigo) = "C", par_cCodigo, ""))

        IF EMPTY(loc_cCodigo)
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp" + ;
                       " WHERE RTRIM(Cemps) = " + EscaparSQL(loc_cCodigo)

            IF USED("cursor_4c_Empresa")
                USE IN cursor_4c_Empresa
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresa")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao carregar a Empresa:" + CHR(13) + ;
                        THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                IF USED("cursor_4c_Empresa") AND RECCOUNT("cursor_4c_Empresa") > 0
                    SELECT cursor_4c_Empresa
                    GO TOP
                    THIS.this_cEmpresa   = ALLTRIM(TratarNulo(cursor_4c_Empresa.Cemps, ""))
                    THIS.this_cDsEmpresa = ALLTRIM(TratarNulo(cursor_4c_Empresa.Razas, ""))
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Empresa")
                USE IN cursor_4c_Empresa
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigPrRetBO.CarregarEmpresa")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Chave do registro de referencia desta tela.
    *
    * SigCdPro tem PRIMARY KEY CLUSTERED em cpros (char(14)), que eh a propria
    * propriedade THIS.this_cCodigo carregada por CarregarDoCursor().
    *
    * Continua PROTECTED como na BusinessBase: metodo protegido na classe base
    * permanece protegido na subclasse, e chama-lo de fora do BO dispararia
    * "Property OBTERCHAVEPRIMARIA is not found" em runtime.
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCodigo, ""))
    ENDFUNC

ENDDEFINE

