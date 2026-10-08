# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BINDEVENT-PARAMS] Handler 'DataLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE DataLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarGradePrincipal()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrHpr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1781 linhas total):

*-- Linhas 15 a 160:
15: * declara PRIVATE, ANTES de abrir esta tela, as variaveis pcCdGrupo/
16: * pcCdConta/pcCdProduto/pcDsProduto/pdDataIni/pdDataFin (grupo, conta,
17: * produto e periodo cujo historico de movimentos sera exibido - dump
18: * SigPrHpr_form_codigo_fonte.txt, Procedure Init do objeto SIGPRHPR). Essas
19: * PRIVATE continuam visiveis por escopo de chamada dentro do Init() do form
20: * migrado (mesma regra do VFP9 para a cadeia original) - capturadas aqui com
21: * guarda TYPE() para o modo de teste (gb_4c_ModoTeste), onde elas nao
22: * existem.
23: *
24: * A tela mostra:
25: *   - a grade principal grd_4c_Dados (CrSigMvHst no legado) com o historico
26: *     de movimentos do produto no periodo;
27: *   - a grade secundaria grd_4c_Subniveis (crSubniveis no legado) com os
28: *     subniveis (SigMvPec x SigCdOpe) do documento selecionado;
29: *   - origem/destino (Grupo/Conta) do documento de movimento corrente;
30: *   - o checkbox de Auditado, que grava (UPDATE SigMvHst) auditors/dtaudits
31: *     do registro corrente - a UNICA escrita real deste form.
32: *
33: * NOTA SOBRE O ROTEIRO GENERICO DE 8 FASES: o template padrao da Fase 3
34: * pressupoe PageFrame com Page1 (Lista) e Page2 (Dados), igual aos forms
35: * CRUD (frmcadastro). SIGPRHPR NAO tem essa superficie - o dump legado prova
36: * PageFrame=0 (Secao 1 do .txt nao lista nenhum objeto baseClass=pageframe).
37: * Inventar um PageFrame Lista/Dados violaria o PILAR 1 (UX) e a regra "NUNCA
38: * inventar" do CLAUDE.md - mesma familia de caso ja documentada para
39: * SIGPRGST/SIGPRGLX/SIGMVEXP (formularios OPERACIONAL cuja superficie real
40: * nao casa com o template CRUD). Esta fase entrega, em vez disso, a
41: * superficie BASE real do legado: o cabecalho (cntSombra) - igual ao que
42: * FormSigPrGst/FormSigPrGlx fazem na propria Fase 3.
43: *
44: * Historico de montagem (migracao multi-fase):
45: *   Fase 1 (feita) - SigPrHprBO.prg: propriedades e Init
46: *   Fase 2 (feita) - SigPrHprBO.prg: metodos de dominio completos
47: *                     (CarregarHistorico, CarregarDoCursor,
48: *                     BuscarDocumentoMovimento, BuscarDescricoesGrupoConta,
49: *                     VerificarPermissaoAuditoria, CarregarSubniveis,
50: *                     AtualizarAuditoria, VerificarDocumentoCadastrado,
51: *                     ObterChavePrimaria, ObterTituloProduto)
52: *   Fase 3 (feita) - DEFINE CLASS, Init/Destroy, InicializarForm(),
53: *                     ConfigurarPageFrame() (orquestrador) ->
54: *                     ConfigurarCabecalho() (cnt_4c_Sombra),
55: *                     TornarControlesVisiveis()
56: *   Fase 4 (feita)  - grd_4c_Dados (CrSigMvHst, 7/9 colunas conforme
57: *                     this_cTipoEstoque) + grd_4c_Subniveis (crSubniveis, 3
58: *                     colunas), formatadas e carregadas via
59: *                     CarregarHistorico()/CarregarDoCursor() do BO (que ja
60: *                     chama CarregarSubniveis() internamente); lbl_4c_Label3
61: *                     (titulo da grade de subniveis - a unica label fora do
62: *                     bloco Say/fwget/chk da Fase 5-6 que ficaria soterrada
63: *                     se so fosse feita depois); botoes obj_4c_Sair
64: *                     (CommandGroup "sair" - Encerrar), cmd_4c_Command1
65: *                     (Procurar) e cmd_4c_BtnDocumento (Movimento)
66: *   Fase 5 (esta)   - lbl_4c_Lbl_produto (titulo do produto - Caption
67: *                     dinamico via ObterTituloProduto() do BO); os dois
68: *                     paineis de fundo cnt_4c_Container1/cnt_4c_Container2
69: *                     (Origem/Destino); lbl_4c_Say7/lbl_4c_Say8 ("Origem "/
70: *                     "Destino") e as linhas separadoras lin_4c_Line1/
71: *                     lin_4c_Line2; os 8 campos fwget de Grupo/Conta
72: *                     origem-destino (txt_4c_GruOri/ConOri/DesGruOri/
73: *                     DesConOri/GruDes/ConDes/DesGruDes/DesConDes -
74: *                     ReadOnly=.T., equivalente ao When Return(.F.) do
75: *                     legado) com os labels lbl_4c_Say1..4 ("Grupo :"/
76: *                     "Conta :"); AtualizarCamposDocumento(), que espelha
77: *                     this_cGrupoOrigem/this_cContaOrigem/
78: *                     this_cGrupoDestino/this_cContaDestino/this_cDescGrupo*
79: *                     /this_cDescConta* do BO nesses 8 campos - chamada ja
80: *                     agora em CarregarDadosIniciais() (a mesma chamada
81: *                     sera reusada pelo AfterRowColChange na Fase 7-8)
82: *   Fase 6 (feita)  - ConfigurarAuditoria(): chk_4c_ChkAuditado
83: *                     (chkAuditado - graphical, Style=1, visibilidade
84: *                     decidida por this_lPodeAuditar do BO), txt_4c_DtAudits
85: *                     (Get_DtAudits) + lbl_4c_Lbl_Auditoria, txt_4c_Data
86: *                     (Get_Data) + lbl_4c_Label6 (Say6 - toggle de filtro
87: *                     por data disparado por cmd_4c_Command1/"Procurar",
88: *                     Visible=.F. por padrao - TornarControlesVisiveis()
89: *                     agora filtra os dois, igual ao legado), obj_4c_GetObs
90: *                     (getObs) + lbl_4c_Label5 (Say5), txt_4c_Auditors
91: *                     (Get_Auditors), txt_4c_Usuario (Get_Usuario),
92: *                     txt_4c_Nota (Get_nota) e os labels lbl_4c_Label1/
93: *                     lbl_4c_Label2/lbl_4c_LblAuditor; AtualizarCamposAuditoria()
94: *                     espelha this_cNotaAtual/this_cUsuarioMovAtual/
95: *                     this_cAuditorAtual/this_dDtAuditAtual/this_cObsAtual/
96: *                     this_lPodeAuditar do BO nesses campos - chamada ja
97: *                     agora em CarregarDadosIniciais() (reusada pela Fase
98: *                     7-8 no AfterRowColChange); e o comportamento do UNICO
99: *                     campo digitavel do legado: ValidarData() (Get_Data.
100: *                     Valid - SET NEAR ON + SEEK no tag "datas" + Refresh da
101: *                     grade), DataLostFocus()/OcultarFiltroData()
102: *                     (Get_Data.LostFocus - esconde Get_Data/Say6 e devolve
103: *                     o foco a grd_historico.Column1), ligados por BINDEVENT
104: *                     em KeyPress (ENTER/TAB - "Valid" nao dispara em
105: *                     TextBox) e LostFocus
106: *
107: *                     NAO HA LOOKUP a implementar nesta fase: o dump legado
108: *                     nao tem fwBuscaExt/fwBuscaSel/mAddColuna/sigacess/
109: *                     Acesso* em nenhum dos 29 metodos - os 8 campos de
110: *                     Grupo/Conta origem-destino, os 4 de auditoria/
111: *                     documento e a Observacao sao TODOS somente-leitura
112: *                     (When Return(.F.) no legado, ReadOnly = .T. aqui),
113: *                     resolvidos pelo BO a partir do registro corrente da
114: *                     grade. Inventar um picker aqui violaria o PILAR 1 e a
115: *                     regra "NUNCA inventar tabelas de lookup".
116: *   Fase 7 (feita)  - GrdDadosAfterRowColChange() (BINDEVENT em
117: *                     AfterRowColChange de grd_4c_Dados - CarregarDoCursor()
118: *                     do BO + AtualizarGradeSubniveis/AtualizarCamposDocumento/
119: *                     AtualizarCamposAuditoria, reusando os metodos da Fase
120: *                     5-6) e ChkAuditadoClick() (BINDEVENT em Click de
121: *                     chk_4c_ChkAuditado - AtualizarAuditoria() do BO, com
122: *                     reversao visual do checkbox e MsgErro quando a
123: *                     transacao falha)
124: *   Fase 8 (esta)   - Consolidacao final. O roteiro generico de 8 fases
125: *                     pede, nesta etapa, BtnBuscarClick/BtnEncerrarClick/
126: *                     BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/
127: *                     HabilitarCampos/LimparCampos/CarregarLista/
128: *                     AjustarBotoesPorModo - vocabulario do padrao CRUD
129: *                     (frmcadastro, Page1=Lista/Page2=Dados, modos INCLUIR/
130: *                     ALTERAR/VISUALIZAR/EXCLUIR). SIGPRHPR e um form
131: *                     OPERACIONAL de CONSULTA (mesma excecao ja registrada na
132: *                     nota da Fase 3, abaixo): nao tem registro para
133: *                     incluir/alterar/excluir, nem modo de edicao, nem
134: *                     Page1/Page2. Cada item do roteiro generico JA tem
135: *                     equivalente real, implementado nas fases anteriores:
136: *
137: *                       BtnBuscarClick     -> BtnProcurarClick() (Fase 4/7:
138: *                                             mostra txt_4c_Data/
139: *                                             lbl_4c_Label6 e reusa
140: *                                             ValidarData() para posicionar
141: *                                             a grade pela data digitada -
142: *                                             o "filtro" deste form)
143: *                       BtnEncerrarClick   -> ObjSairClick() (Fase 4/7:
144: *                                             reabilita this_oFormPai e
145: *                                             THIS.Release() - mesmo papel
146: *                                             do cnt_4c_Saida/cmd_4c_Encerrar
147: *                                             canonico CRUD, aqui como
148: *                                             CommandGroup porque e assim
149: *                                             que o legado desenhou)
150: *                       BtnSalvarClick     -> ChkAuditadoClick() (Fase 7: a
151: *                                             UNICA escrita real do form -
152: *                                             UPDATE SigMvHst.auditors/
153: *                                             dtaudits via
154: *                                             AtualizarAuditoria() do BO)
155: *                       BtnCancelarClick   -> nao existe no legado (nao ha
156: *                                             modo de edicao para cancelar -
157: *                                             inventar um botao Cancelar
158: *                                             violaria o PILAR 1 e a regra
159: *                                             "NUNCA inventar")
160: *                       FormParaBO/BOParaForm -> nao se aplicam: nao ha

*-- Linhas 199 a 242:
199: *                                             exatamente como no legado
200: *
201: *                     Nenhum caller (nenhum "Do Form SigPrHpr"/
202: *                     "CREATEOBJECT('FormSigPrHpr'...)") existe ainda no
203: *                     codigo migrado nem nos dumps de tasks/ ja extraidos -
204: *                     o form pai que declara as PRIVATE pcCdGrupo/pcCdConta/
205: *                     pcCdProduto/pcDsProduto/pdDataIni/pdDataFin (ver nota
206: *                     do Init, abaixo) ainda nao foi migrado. Por isso NAO
207: *                     ha item novo em menu.prg: este form e um detalhe
208: *                     aberto programaticamente por outro form (mesma familia
209: *                     de FormSigMvExp/FormSigMvPdt, referenciados em
210: *                     BtnDocumentoClick), nao um cadastro/relatorio com
211: *                     entrada direta no menu principal.
212: *==============================================================================
213: 
214: DEFINE CLASS FormSigPrHpr AS FormBase
215: 
216:     *--------------------------------------------------------------------------
217:     * Propriedades do form (SIGPRHPR.SCX: DataSession=2, BorderStyle=2,
218:     * Height=600, Width=1000, AutoCenter=.T., ControlBox=.F., Closable=.F.,
219:     * MaxButton=.F., MinButton=.F., KeyPreview=.T., TitleBar=0 - dump de
220:     * SigPrHpr_form_codigo_fonte.txt, linhas 392-411. DataSession=2 exige
221:     * que Init() chame DODEFAULT() para FormBase.Init() aplicar
222:     * SET DATE TO BRITISH + SET CENTURY ON - CLAUDE.md regra #9.4)
223:     *--------------------------------------------------------------------------
224:     this_cMensagemErro = ""
225:     DataSession  = 2
226:     Width        = 1000
227:     Height       = 600
228:     AutoCenter   = .T.
229:     TitleBar     = 0
230:     ShowWindow   = 1
231:     WindowType   = 1
232:     ControlBox   = .F.
233:     Movable      = .F.
234:     KeyPreview   = .T.
235:     Closable     = .F.
236:     MaxButton    = .F.
237:     MinButton    = .F.
238:     ClipControls = .F.
239:     BorderStyle  = 2
240:     FontName     = "Tahoma"
241:     FontSize     = 8
242: 

*-- Linhas 279 a 434:
279:     * parametros do historico (equivalente a "Lparameters pFrm" + leitura
280:     * das PRIVATE do chamador no Init legado). DODEFAULT() ao final
281:     *--------------------------------------------------------------------------
282:     PROCEDURE Init()
283:         LPARAMETERS par_oFormPai
284:         LOCAL loc_lSucesso, loc_oErro
285:         loc_lSucesso = .F.
286: 
287:         TRY
288:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrHprBO")
289: 
290:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
291:                 IF PCOUNT() >= 1 AND VARTYPE(par_oFormPai) = "O"
292:                     THIS.this_oFormPai = par_oFormPai
293:                 ENDIF
294: 
295:                 *-- Equivalente a leitura direta de pcCdGrupo/pcCdConta/
296:                 *-- pcCdProduto/pcDsProduto/pdDataIni/pdDataFin (PRIVATE do
297:                 *-- form pai, visiveis por escopo de chamada). Guarda TYPE()
298:                 *-- cobre o modo de teste, onde essas PRIVATE nao existem.
299:                 THIS.this_cGrupo = IIF(TYPE("pcCdGrupo") = "C", PADR(pcCdGrupo, 10), SPACE(10))
300:                 THIS.this_cConta = IIF(TYPE("pcCdConta") = "C", PADR(pcCdConta, 10), SPACE(10))
301:                 THIS.this_cProduto = IIF(TYPE("pcCdProduto") = "C", PADR(pcCdProduto, 14), SPACE(14))
302:                 THIS.this_cDescricaoProduto = IIF(TYPE("pcDsProduto") = "C", ALLTRIM(pcDsProduto), "")
303:                 THIS.this_dDataIni = IIF(INLIST(TYPE("pdDataIni"), "D", "T"), pdDataIni, {})
304:                 THIS.this_dDataFin = IIF(INLIST(TYPE("pdDataFin"), "D", "T"), pdDataFin, {})
305: 
306:                 loc_lSucesso = DODEFAULT()
307:             ENDIF
308:         CATCH TO loc_oErro
309:             MsgErro("Erro ao inicializar Hist" + CHR(243) + "rico de Produtos: " + loc_oErro.Message, "Erro")
310:         ENDTRY
311: 
312:         RETURN loc_lSucesso
313:     ENDPROC
314: 
315:     *--------------------------------------------------------------------------
316:     * Destroy - encadeia direto para FormBase.Destroy() (libera
317:     * this_oBusinessObject e restaura o menu principal). this_oFormPai NAO
318:     * eh liberado aqui - pertence a quem o criou.
319:     *--------------------------------------------------------------------------
320:     PROCEDURE Destroy()
321:         DODEFAULT()
322:     ENDPROC
323: 
324:     *--------------------------------------------------------------------------
325:     * InicializarForm - monta a tela via ConfigurarPageFrame() (cabecalho
326:     * nesta fase; grades/campos/botoes nas proximas) e torna tudo visivel.
327:     *--------------------------------------------------------------------------
328:     PROTECTED PROCEDURE InicializarForm()
329:         LOCAL loc_lSucesso, loc_oErro, loc_cPicture
330:         loc_lSucesso = .F.
331: 
332:         TRY
333:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
334:                 MsgErro("Falha ao criar SigPrHprBO.", "Erro")
335:             ELSE
336:                 loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
337:                 IF FILE(loc_cPicture)
338:                     THIS.Picture = loc_cPicture
339:                 ENDIF
340: 
341:                 THIS.ConfigurarPageFrame()
342: 
343:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
344:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
345: 
346:                 THIS.TornarControlesVisiveis(THIS)
347: 
348:                 *-- Mesmo guard usado em FormSigPrGlx/FormSigPrGst: em modo
349:                 *-- de teste de UI (sem gnConnHandle/dados de globalizacao
350:                 *-- do form pai) pular o carregamento real evita o dialogo
351:                 *-- "Favor reinicializar o processo" num contexto sem SQL.
352:                 IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
353:                      (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
354:                     THIS.CarregarDadosIniciais()
355:                 ENDIF
356: 
357:                 loc_lSucesso = .T.
358:             ENDIF
359:         CATCH TO loc_oErro
360:             MsgErro(loc_oErro.Message + CHR(13) + ;
361:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
362:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrHpr.InicializarForm")
363:         ENDTRY
364: 
365:         RETURN loc_lSucesso
366:     ENDPROC
367: 
368:     *--------------------------------------------------------------------------
369:     * ConfigurarPageFrame - orquestrador de montagem visual. SIGPRHPR nao
370:     * tem PageFrame no legado (layout flat: cntSombra + 2 grades + campos +
371:     * botoes no proprio form - ver nota no cabecalho do arquivo); o nome do
372:     * metodo e mantido apenas como ponto de entrada arquitetural padrao
373:     * (mesmo papel em FormSigPrGst/FormSigPrGlx). As proximas fases vao
374:     * acrescentar ConfigurarCamposDocumento()/ConfigurarAuditoria() a este
375:     * mesmo metodo.
376:     *--------------------------------------------------------------------------
377:     PROTECTED PROCEDURE ConfigurarPageFrame()
378:         THIS.ConfigurarCabecalho()
379:         THIS.ConfigurarGradePrincipal()
380:         THIS.ConfigurarGradeSubniveis()
381:         THIS.ConfigurarCamposDocumento()
382:         THIS.ConfigurarAuditoria()
383:         THIS.ConfigurarBotoesAcao()
384:     ENDPROC
385: 
386:     *--------------------------------------------------------------------------
387:     * ConfigurarCabecalho - cria cnt_4c_Sombra (cntSombra no legado) com os
388:     * dois labels de titulo (lbl_4c_LblSombra/lbl_4c_LblTitulo), geometria e
389:     * propriedades transcritas do dump (SigPrHpr_form_codigo_fonte.txt,
390:     * linhas 414-464). Width usa THIS.Width (dinamico, CLAUDE.md regra #11) -
391:     * NUNCA o literal 1100 do SCX legado, que e maior que o proprio form
392:     * (Width=1000) por artefato do designer original.
393:     *--------------------------------------------------------------------------
394:     PROTECTED PROCEDURE ConfigurarCabecalho()
395:         LOCAL loc_oCnt, loc_oErro
396: 
397:         TRY
398:             THIS.AddObject("cnt_4c_Sombra", "Container")
399:             loc_oCnt = THIS.cnt_4c_Sombra
400:             WITH loc_oCnt
401:                 .Top         = 0
402:                 .Left        = 0
403:                 .Width       = THIS.Width
404:                 .Height      = 80
405:                 .BorderWidth = 0
406:                 .BackColor   = RGB(100, 100, 100)
407:                 .Visible     = .T.
408:             ENDWITH
409: 
410:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
411:             WITH loc_oCnt.lbl_4c_LblSombra
412:                 .FontBold  = .T.
413:                 .FontName  = "Tahoma"
414:                 .FontSize  = 18
415:                 .WordWrap  = .T.
416:                 .Alignment = 0
417:                 .BackStyle = 0
418:                 .AutoSize  = .F.
419:                 .Caption   = THIS.Caption
420:                 .Height    = 40
421:                 .Left      = 10
422:                 .Top       = 18
423:                 .Width     = 769
424:                 .ForeColor = RGB(0, 0, 0)
425:                 .Visible   = .T.
426:             ENDWITH
427: 
428:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
429:             WITH loc_oCnt.lbl_4c_LblTitulo
430:                 .FontBold  = .T.
431:                 .FontName  = "Tahoma"
432:                 .FontSize  = 18
433:                 .WordWrap  = .T.
434:                 .Alignment = 0

*-- Linhas 445 a 574:
445:         CATCH TO loc_oErro
446:             MsgErro(loc_oErro.Message + CHR(13) + ;
447:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
448:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
449:         ENDTRY
450:     ENDPROC
451: 
452:     *--------------------------------------------------------------------------
453:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
454:     * padrao; percorre recursivamente Controls (Containers/Grids/Pages de
455:     * eventuais PageFrames filhos) tornando tudo visivel.
456:     *
457:     * O legado tem DOIS controles que comecam Visible=.F. de proposito
458:     * (Get_Data/Say6 - toggle de filtro por data, ligado por Command1.Click -
459:     * BtnProcurarClick - e desligado no proprio Get_Data.LostFocus/Valid, que
460:     * a Fase 7-8 implementa). Criados na Fase 6 como txt_4c_Data/
461:     * lbl_4c_Label6 - este metodo os IGNORA explicitamente, senao apareceriam
462:     * abertos desde a inicializacao do form (CLAUDE.md - containers/
463:     * controles flutuantes).
464:     *--------------------------------------------------------------------------
465:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
466:         LOCAL loc_nI, loc_oObjeto
467: 
468:         FOR loc_nI = 1 TO par_oContainer.ControlCount
469:             loc_oObjeto = par_oContainer.Controls(loc_nI)
470: 
471:             IF VARTYPE(loc_oObjeto) = "O"
472:                 IF INLIST(UPPER(loc_oObjeto.Name), "TXT_4C_DATA", "LBL_4C_LABEL6")
473:                     LOOP
474:                 ENDIF
475: 
476:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
477:                     loc_oObjeto.Visible = .T.
478:                 ENDIF
479: 
480:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
481:                     THIS.TornarControlesVisiveis(loc_oObjeto)
482:                 ENDIF
483:             ENDIF
484:         ENDFOR
485:     ENDPROC
486: 
487:     *--------------------------------------------------------------------------
488:     * ConfigurarGradePrincipal - cria grd_4c_Dados (grd_historico no legado),
489:     * so a geometria/propriedades de grade (SigPrHpr_form_codigo_fonte.txt,
490:     * linhas 546-561). RecordSource/ColumnCount/ControlSource/Width/Header
491:     * das colunas sao feitos em CarregarGradePrincipal() - fazer isso aqui
492:     * seria inutil, porque reatribuir RecordSource/ControlSource reseta
493:     * Width e Header1.Caption (CLAUDE.md - "Problema 2" / regra sobre Grid
494:     * rebind, FORMCOR_LICOES_APRENDIDAS.md).
495:     *--------------------------------------------------------------------------
496:     PROTECTED PROCEDURE ConfigurarGradePrincipal()
497:         LOCAL loc_oErro
498: 
499:         TRY
500:             THIS.AddObject("grd_4c_Dados", "Grid")
501:             WITH THIS.grd_4c_Dados
502:                 .Top         = 148
503:                 .Left        = 4
504:                 .Width       = 730
505:                 .Height      = 238
506:                 .FontName    = "Arial"
507:                 .DeleteMark  = .F.
508:                 .RecordMark  = .F.
509:                 .ScrollBars  = 2
510:                 .ReadOnly    = .T.
511:                 .ColumnCount = 9
512:                 .Visible     = .T.
513:             ENDWITH
514: 
515:             *-- AfterRowColChange = AfterRowColChange do grd_historico legado
516:             *-- (dump linhas 579-728): troca de linha na grade principal
517:             *-- reposiciona documento/origem-destino/auditoria/subniveis do
518:             *-- registro agora corrente. BINDEVENT exige metodo PUBLIC e
519:             *-- parametro declarado (CLAUDE.md regra #3).
520:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
521:         CATCH TO loc_oErro
522:             MsgErro(loc_oErro.Message + CHR(13) + ;
523:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
524:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGradePrincipal")
525:         ENDTRY
526:     ENDPROC
527: 
528:     *--------------------------------------------------------------------------
529:     * FormatarColunaGradePrincipal - aplica a UMA coluna de grd_4c_Dados o
530:     * trio FontName/Width/Movable/Resizable/ReadOnly + Format/InputMask
531:     * (quando informados) + Header1 (FontName/FontSize/Alignment/Caption/
532:     * ForeColor), na ordem exigida (DEPOIS do ControlSource - ver chamador).
533:     *--------------------------------------------------------------------------
534:     PROTECTED PROCEDURE FormatarColunaGradePrincipal(par_oColuna, par_cCaption, par_nWidth, par_cFormat, par_cInputMask)
535:         WITH par_oColuna
536:             .FontName  = "Courier New"
537:             .Width     = par_nWidth
538:             .Movable   = .F.
539:             .Resizable = .F.
540:             .ReadOnly  = .T.
541:             IF !EMPTY(par_cFormat)
542:                 .Format    = par_cFormat
543:                 .InputMask = par_cInputMask
544:             ENDIF
545:             .Header1.FontName  = "Tahoma"
546:             .Header1.FontSize  = 8
547:             .Header1.Alignment = 2
548:             .Header1.Caption   = par_cCaption
549:             .Header1.ForeColor = RGB(0, 0, 0)
550:         ENDWITH
551:     ENDPROC
552: 
553:     *--------------------------------------------------------------------------
554:     * CarregarGradePrincipal - equivalente ao bloco do Init legado que
555:     * executa CrSigMvHst/TmpPro/TmpUni e liga grd_historico (linhas
556:     * 1541-1597 do dump): chama CarregarHistorico() do BO (que ja resolve
557:     * produto/unidade e deixa cursor_4c_Dados posicionado no ultimo
558:     * registro) e rebinda a grade. ColumnCount eh DINAMICO - 9 colunas
559:     * (com Peso/Saldo Peso) quando this_cTipoEstoque = "3", 7 nos demais
560:     * casos, exatamente como Iif(TmpUni.Cestos = '3', 9, 7) no legado.
561:     *--------------------------------------------------------------------------
562:     PROTECTED FUNCTION CarregarGradePrincipal()
563:         LOCAL loc_lSucesso, loc_oGrid, loc_nColunas, loc_oErro
564:         loc_lSucesso = .F.
565: 
566:         TRY
567:             IF THIS.this_oBusinessObject.CarregarHistorico(THIS.this_cGrupo, THIS.this_cConta, ;
568:                     THIS.this_cProduto, THIS.this_cDescricaoProduto, THIS.this_dDataIni, THIS.this_dDataFin)
569: 
570:                 loc_oGrid    = THIS.grd_4c_Dados
571:                 loc_nColunas = IIF(THIS.this_oBusinessObject.this_cTipoEstoque == "3", 9, 7)
572: 
573:                 loc_oGrid.RecordSource = ""
574:                 loc_oGrid.ColumnCount  = loc_nColunas

*-- Linhas 623 a 735:
623:         CATCH TO loc_oErro
624:             MsgErro(loc_oErro.Message + CHR(13) + ;
625:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
626:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarGradePrincipal")
627:         ENDTRY
628: 
629:         RETURN loc_lSucesso
630:     ENDFUNC
631: 
632:     *--------------------------------------------------------------------------
633:     * ConfigurarGradeSubniveis - cria grd_4c_Subniveis (grdSubniveis no
634:     * legado - SigPrHpr_form_codigo_fonte.txt linhas 1256-1272) e
635:     * lbl_4c_Label3 ("Movimentacoes com subnivel" - Label3, linhas
636:     * 1367-1382), titulo estatico da grade. So geometria aqui - igual a
637:     * ConfigurarGradePrincipal, o rebind de ControlSource/Width/Header fica
638:     * em AtualizarGradeSubniveis(), chamado toda vez que o BO recria
639:     * cursor_4c_Subniveis (CarregarSubniveis faz USE IN + CREATE CURSOR a
640:     * cada linha selecionada na grade principal - regra do rebind de grid).
641:     *--------------------------------------------------------------------------
642:     PROTECTED PROCEDURE ConfigurarGradeSubniveis()
643:         LOCAL loc_oErro
644: 
645:         TRY
646:             THIS.AddObject("grd_4c_Subniveis", "Grid")
647:             WITH THIS.grd_4c_Subniveis
648:                 .Top         = 148
649:                 .Left        = 738
650:                 .Width       = 261
651:                 .Height      = 238
652:                 .FontName    = "Arial"
653:                 .DeleteMark  = .F.
654:                 .RecordMark  = .F.
655:                 .ScrollBars  = 2
656:                 .ReadOnly    = .T.
657:                 .ColumnCount = 3
658:                 .Visible     = .T.
659:             ENDWITH
660: 
661:             THIS.AddObject("lbl_4c_Label3", "Label")
662:             WITH THIS.lbl_4c_Label3
663:                 .AutoSize   = .F.
664:                 .FontBold   = .T.
665:                 .FontItalic = .F.
666:                 .FontName   = "Tahoma"
667:                 .FontSize   = 8
668:                 .BackStyle  = 0
669:                 .Alignment  = 0
670:                 .Caption    = "Movimenta" + CHR(231) + CHR(245) + "es com subn" + CHR(237) + "vel"
671:                 .Height     = 15
672:                 .Left       = 747
673:                 .Top        = 130
674:                 .Width      = 169
675:                 .ForeColor  = RGB(90, 90, 90)
676:                 .Visible    = .T.
677:             ENDWITH
678:         CATCH TO loc_oErro
679:             MsgErro(loc_oErro.Message + CHR(13) + ;
680:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
681:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGradeSubniveis")
682:         ENDTRY
683:     ENDPROC
684: 
685:     *--------------------------------------------------------------------------
686:     * AtualizarGradeSubniveis - rebinda grd_4c_Subniveis a cursor_4c_Subniveis
687:     * (crSubniveis no legado - RecordSource estatico, linha 1266 do dump,
688:     * porque o cursor e SEMPRE recriado com a MESMA estrutura por
689:     * CarregarSubniveis()/CarregarDoCursor() do BO). Precisa ser chamado de
690:     * NOVO toda vez que o BO recriar o cursor - Width/Header1.Caption se
691:     * perdem no rebind (mesma familia do "Problema 2" / regra sobre Grid
692:     * Column.ControlSource resetar Header/Width). Reusado pela Fase 7-8 no
693:     * AfterRowColChange da grade principal.
694:     *--------------------------------------------------------------------------
695:     PROTECTED PROCEDURE AtualizarGradeSubniveis()
696:         LOCAL loc_oGrid, loc_oErro
697: 
698:         TRY
699:             loc_oGrid = THIS.grd_4c_Subniveis
700: 
701:             loc_oGrid.RecordSource = ""
702:             loc_oGrid.ColumnCount  = 3
703:             loc_oGrid.RecordSource = "cursor_4c_Subniveis"
704: 
705:             loc_oGrid.Column1.ControlSource = "cursor_4c_Subniveis.Emps"
706:             loc_oGrid.Column2.ControlSource = "cursor_4c_Subniveis.Dopes"
707:             loc_oGrid.Column3.ControlSource = "cursor_4c_Subniveis.Numes"
708: 
709:             WITH loc_oGrid.Column1
710:                 .FontName  = "Courier New"
711:                 .Width     = 31
712:                 .Movable   = .F.
713:                 .Resizable = .F.
714:                 .ReadOnly  = .T.
715:                 .Header1.FontName  = "Tahoma"
716:                 .Header1.FontSize  = 8
717:                 .Header1.Alignment = 2
718:                 .Header1.Caption   = "Emp"
719:             ENDWITH
720: 
721:             WITH loc_oGrid.Column2
722:                 .FontName  = "Courier New"
723:                 .Width     = 156
724:                 .Movable   = .F.
725:                 .Resizable = .F.
726:                 .ReadOnly  = .T.
727:                 .Header1.FontName  = "Tahoma"
728:                 .Header1.FontSize  = 8
729:                 .Header1.Alignment = 2
730:                 .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
731:             ENDWITH
732: 
733:             WITH loc_oGrid.Column3
734:                 .FontName  = "Courier New"
735:                 .Width     = 51

*-- Linhas 749 a 822:
749:         CATCH TO loc_oErro
750:             MsgErro(loc_oErro.Message + CHR(13) + ;
751:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
752:                 "Procedure: " + loc_oErro.Procedure, "Erro em AtualizarGradeSubniveis")
753:         ENDTRY
754:     ENDPROC
755: 
756:     *--------------------------------------------------------------------------
757:     * ConfigurarCamposDocumento - cria o bloco Origem/Destino do documento de
758:     * movimento corrente (dump linhas 467-1051 e 1419-1471): os dois paineis
759:     * de fundo cnt_4c_Container1 (Origem, Left=7)/cnt_4c_Container2 (Destino,
760:     * Left=504), os titulos lbl_4c_Say7 "Origem "/lbl_4c_Say8 "Destino" com
761:     * as linhas separadoras lin_4c_Line1/lin_4c_Line2, o titulo dinamico
762:     * lbl_4c_Lbl_produto (Caption montado por ObterTituloProduto() do BO em
763:     * CarregarDadosIniciais - AutoSize=.T. no SCX eh NO-OP em Label criado
764:     * por AddObject, CLAUDE.md regra #23, por isso .AutoSize=.F. + Width
765:     * explicita) e os 8 campos fwget somente-leitura de Grupo/Conta (os dois
766:     * paineis e as linhas sao criados ANTES dos campos/labels para ficarem
767:     * no fundo). Os 8 campos tem ReadOnly=.T. porque o legado trava entrada
768:     * com When Return(.F.) (dump linhas 1980-2082) - nao ha equivalente
769:     * direto de When num TextBox criado por AddObject, e ReadOnly reproduz o
770:     * mesmo efeito (campo so-leitura). Valor eh atribuido por
771:     * AtualizarCamposDocumento(), chamado por CarregarDadosIniciais() nesta
772:     * fase e reusado pelo AfterRowColChange na Fase 7-8.
773:     *
774:     * Nomes dos labels Say1/Say2/Say3/Say4/Say7/Say8 usam o sufixo numerico
775:     * do legado (lbl_4c_SayN) em vez do nome gerico "lbl_4c_LabelN" do
776:     * mapeamento.json: o proprio mapeamento.json colide Say3 com Label3 (o
777:     * titulo "Movimentacoes com subnivel" da Fase 4, que ja ocupa
778:     * lbl_4c_Label3) - usar o nome colidido estouraria "object already
779:     * exists" no Init (CLAUDE.md - diferenca bloqueante por colisao de nome
780:     * no mapeamento.json, nao no .prg).
781:     *--------------------------------------------------------------------------
782:     PROTECTED PROCEDURE ConfigurarCamposDocumento()
783:         LOCAL loc_oErro
784: 
785:         TRY
786:             THIS.AddObject("cnt_4c_Container1", "Container")
787:             WITH THIS.cnt_4c_Container1
788:                 .Top           = 426
789:                 .Left          = 7
790:                 .Width         = 478
791:                 .Height        = 74
792:                 .SpecialEffect = 0
793:                 .BackStyle     = 1
794:                 .BackColor     = RGB(255, 255, 255)
795:                 .BorderWidth   = 0
796:                 .Visible       = .T.
797:             ENDWITH
798: 
799:             THIS.AddObject("cnt_4c_Container2", "Container")
800:             WITH THIS.cnt_4c_Container2
801:                 .Top           = 426
802:                 .Left          = 504
803:                 .Width         = 478
804:                 .Height        = 74
805:                 .SpecialEffect = 0
806:                 .BackStyle     = 1
807:                 .BackColor     = RGB(255, 255, 255)
808:                 .BorderWidth   = 0
809:                 .Visible       = .T.
810:             ENDWITH
811: 
812:             THIS.AddObject("lbl_4c_Say7", "Label")
813:             WITH THIS.lbl_4c_Say7
814:                 .AutoSize  = .F.
815:                 .FontBold  = .T.
816:                 .FontName  = "Tahoma"
817:                 .FontSize  = 8
818:                 .BackStyle = 0
819:                 .Alignment = 0
820:                 .Caption   = "Origem "
821:                 .Left      = 17
822:                 .Top       = 428

*-- Linhas 1068 a 1140:
1068:         CATCH TO loc_oErro
1069:             MsgErro(loc_oErro.Message + CHR(13) + ;
1070:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1071:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposDocumento")
1072:         ENDTRY
1073:     ENDPROC
1074: 
1075:     *--------------------------------------------------------------------------
1076:     * ConfigurarAuditoria - cria o bloco de auditoria/observacao do registro
1077:     * corrente da grade principal (dump linhas 1055-1196, 1198-1252,
1078:     * 1116-1144, 1474-1484): os 4 campos fwget somente-leitura Documento
1079:     * (txt_4c_Nota)/Usuario (txt_4c_Usuario)/Auditoria (txt_4c_DtAudits)/
1080:     * Auditor (txt_4c_Auditors) com seus labels (lbl_4c_Label2/
1081:     * lbl_4c_Label1/lbl_4c_Lbl_Auditoria/lbl_4c_LblAuditor - nomes "Label1"/
1082:     * "Label2" livres porque a Fase 5 usou lbl_4c_Say1..4 para os Say1..4
1083:     * que colidiriam no mapeamento.json, CLAUDE.md regra sobre colisao de
1084:     * nome), o checkbox chk_4c_ChkAuditado (chkAuditado no legado -
1085:     * CheckBox grafico Style=1, visibilidade decidida por this_lPodeAuditar
1086:     * do BO em AtualizarCamposAuditoria - comeca oculto), o campo de filtro
1087:     * por data txt_4c_Data + label lbl_4c_Label6 (Get_Data/Say6 - toggle
1088:     * flutuante disparado por cmd_4c_Command1/"Procurar" - Fase 4 -,
1089:     * Visible=.F. por padrao igual ao legado - TornarControlesVisiveis()
1090:     * ignora os dois) e o EditBox de observacao obj_4c_GetObs (getObs) com
1091:     * seu label lbl_4c_Label5 (Say5 - unico Say deste form com
1092:     * ForeColor=RGB(90,90,90) em vez de RGB(0,0,0), igual ao dump).
1093:     *
1094:     * Os 4 campos fwget (Nota/Usuario/DtAudits/Auditors) e o getObs sao
1095:     * ReadOnly=.T. (equivalente ao When Return(.F.) do legado - dump linhas
1096:     * 2155-2159, 2204-2236, 2290-2292). txt_4c_DtAudits tem Alignment=3
1097:     * (right, igual ao dump) e .Value = {} (campo DATA; os demais campos
1098:     * fwget sao char, .Value = "").
1099:     *--------------------------------------------------------------------------
1100:     PROTECTED PROCEDURE ConfigurarAuditoria()
1101:         LOCAL loc_oErro
1102: 
1103:         TRY
1104:             *-- Documento : (Get_nota)
1105:             THIS.AddObject("lbl_4c_Label2", "Label")
1106:             WITH THIS.lbl_4c_Label2
1107:                 .AutoSize  = .F.
1108:                 .FontBold  = .T.
1109:                 .FontName  = "Tahoma"
1110:                 .FontSize  = 8
1111:                 .BackStyle = 0
1112:                 .Alignment = 0
1113:                 .Caption   = "Documento :"
1114:                 .Left      = 27
1115:                 .Top       = 396
1116:                 .Width     = 73
1117:                 .Height    = 15
1118:                 .ForeColor = RGB(90, 90, 90)
1119:                 .Visible   = .T.
1120:             ENDWITH
1121: 
1122:             THIS.AddObject("txt_4c_Nota", "TextBox")
1123:             WITH THIS.txt_4c_Nota
1124:                 .Top               = 392
1125:                 .Left              = 102
1126:                 .Width             = 80
1127:                 .Height            = 23
1128:                 .ReadOnly          = .T.
1129:                 .SpecialEffect     = 1
1130:                 .ForeColor         = RGB(0, 0, 0)
1131:                 .DisabledBackColor = RGB(255, 255, 255)
1132:                 .BorderColor       = RGB(90, 90, 90)
1133:                 .Value             = ""
1134:                 .Visible           = .T.
1135:             ENDWITH
1136: 
1137:             *-- Usuario : (Get_Usuario)
1138:             THIS.AddObject("lbl_4c_Label1", "Label")
1139:             WITH THIS.lbl_4c_Label1
1140:                 .AutoSize  = .F.

*-- Linhas 1267 a 1781:
1267:             *-- Date()...") - equivalente encapsulado em
1268:             *-- AtualizarAuditoria() do BO (Fase 2), que ja faz a transacao
1269:             *-- BEGIN/UPDATE auditors/UPDATE dtaudits/COMMIT ou ROLLBACK.
1270:             BINDEVENT(THIS.chk_4c_ChkAuditado, "Click", THIS, "ChkAuditadoClick")
1271: 
1272:             *-- Data : / campo de filtro por data (Say6/Get_Data) - toggle
1273:             *-- flutuante disparado por cmd_4c_Command1 ("Procurar", Fase
1274:             *-- 4), comeca oculto igual ao legado (dump: ThisForm.Get_Data.
1275:             *-- Visible = .f. / ThisForm.Say6.Visible = .f. no Init).
1276:             THIS.AddObject("lbl_4c_Label6", "Label")
1277:             WITH THIS.lbl_4c_Label6
1278:                 .AutoSize  = .F.
1279:                 .FontBold  = .T.
1280:                 .FontName  = "Tahoma"
1281:                 .FontSize  = 8
1282:                 .BackStyle = 0
1283:                 .Alignment = 0
1284:                 .Caption   = "Data :"
1285:                 .Left      = 441
1286:                 .Top       = 102
1287:                 .Width     = 40
1288:                 .Height    = 13
1289:                 .ForeColor = RGB(90, 90, 90)
1290:                 .Visible   = .F.
1291:             ENDWITH
1292: 
1293:             THIS.AddObject("txt_4c_Data", "TextBox")
1294:             WITH THIS.txt_4c_Data
1295:                 .Top           = 98
1296:                 .Left          = 478
1297:                 .Width         = 80
1298:                 .Height        = 23
1299:                 .Alignment     = 3
1300:                 .MaxLength     = 10
1301:                 .SpecialEffect = 1
1302:                 .ForeColor     = RGB(0, 0, 0)
1303:                 .BorderColor   = RGB(100, 100, 100)
1304:                 .Value         = {}
1305:                 .Visible       = .F.
1306:             ENDWITH
1307: 
1308:             *-- Get_Data eh o UNICO campo digitavel do legado: Valid (SEEK na
1309:             *-- data) + LostFocus (esconde e devolve o foco a grade). BINDEVENT
1310:             *-- em "Valid" NAO dispara em TextBox (CLAUDE.md regra #3): o Valid
1311:             *-- eh reproduzido no KeyPress, em ENTER/TAB - as duas teclas que
1312:             *-- encerram a digitacao e, no legado, disparavam o Valid.
1313:             BINDEVENT(THIS.txt_4c_Data, "KeyPress",  THIS, "ValidarData")
1314:             BINDEVENT(THIS.txt_4c_Data, "KeyPress", THIS, "DataLostFocus")
1315: 
1316:             *-- Observacao : (getObs)
1317:             THIS.AddObject("lbl_4c_Label5", "Label")
1318:             WITH THIS.lbl_4c_Label5
1319:                 .AutoSize  = .F.
1320:                 .FontBold  = .T.
1321:                 .FontName  = "Tahoma"
1322:                 .FontSize  = 8
1323:                 .BackStyle = 0
1324:                 .Alignment = 0
1325:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
1326:                 .Left      = 29
1327:                 .Top       = 517
1328:                 .Width     = 70
1329:                 .Height    = 13
1330:                 .ForeColor = RGB(90, 90, 90)
1331:                 .Visible   = .T.
1332:             ENDWITH
1333: 
1334:             THIS.AddObject("obj_4c_GetObs", "EditBox")
1335:             WITH THIS.obj_4c_GetObs
1336:                 .Top           = 514
1337:                 .Left          = 106
1338:                 .Width         = 875
1339:                 .Height        = 55
1340:                 .FontName      = "Tahoma"
1341:                 .FontSize      = 8
1342:                 .ReadOnly      = .T.
1343:                 .SpecialEffect = 1
1344:                 .ForeColor     = RGB(0, 0, 0)
1345:                 .BorderColor   = RGB(100, 100, 100)
1346:                 .Value         = ""
1347:                 .Visible       = .T.
1348:             ENDWITH
1349:         CATCH TO loc_oErro
1350:             MsgErro(loc_oErro.Message + CHR(13) + ;
1351:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1352:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAuditoria")
1353:         ENDTRY
1354:     ENDPROC
1355: 
1356:     *--------------------------------------------------------------------------
1357:     * AtualizarCamposDocumento - espelha nos 8 campos fwget (legado:
1358:     * ThisForm.GetGruOri.Value = CrSigMvCab.grupoos e demais, dump linhas
1359:     * 1610-1663/1753-1813) as properties que BuscarDocumentoMovimento()/
1360:     * BuscarDescricoesGrupoConta() do BO ja resolveram para o registro
1361:     * corrente. Chamado por CarregarDadosIniciais() nesta fase; a Fase 7-8
1362:     * reusa este mesmo metodo no AfterRowColChange da grade principal.
1363:     *--------------------------------------------------------------------------
1364:     PROTECTED PROCEDURE AtualizarCamposDocumento()
1365:         LOCAL loc_oBO
1366: 
1367:         loc_oBO = THIS.this_oBusinessObject
1368: 
1369:         THIS.txt_4c_GruOri.Value    = ALLTRIM(loc_oBO.this_cGrupoOrigem)
1370:         THIS.txt_4c_ConOri.Value    = ALLTRIM(loc_oBO.this_cContaOrigem)
1371:         THIS.txt_4c_DesGruOri.Value = ALLTRIM(loc_oBO.this_cDescGrupoOrigem)
1372:         THIS.txt_4c_DesConOri.Value = ALLTRIM(loc_oBO.this_cDescContaOrigem)
1373:         THIS.txt_4c_GruDes.Value    = ALLTRIM(loc_oBO.this_cGrupoDestino)
1374:         THIS.txt_4c_ConDes.Value    = ALLTRIM(loc_oBO.this_cContaDestino)
1375:         THIS.txt_4c_DesGruDes.Value = ALLTRIM(loc_oBO.this_cDescGrupoDestino)
1376:         THIS.txt_4c_DesConDes.Value = ALLTRIM(loc_oBO.this_cDescContaDestino)
1377:     ENDPROC
1378: 
1379:     *--------------------------------------------------------------------------
1380:     * AtualizarCamposAuditoria - espelha nos campos de auditoria/observacao
1381:     * (legado: ThisForm.Get_nota/Get_usuario/get_Auditors/get_DtAudits/
1382:     * getObs.Value = ... e o bloco llSupervis/llVisAudit/chkAuditado.Value,
1383:     * dump linhas 1794-1798 e 1818-1846) as properties que CarregarDoCursor()/
1384:     * VerificarPermissaoAuditoria() do BO ja resolveram para o registro
1385:     * corrente. this_lPodeAuditar decide Visible; .Value do checkbox so eh
1386:     * atribuido quando visivel, igual ao "If ThisForm.chkAuditado.Visible"
1387:     * do legado. Chamado por CarregarDadosIniciais() nesta fase; a Fase 7-8
1388:     * reusa este mesmo metodo no AfterRowColChange da grade principal.
1389:     *--------------------------------------------------------------------------
1390:     PROTECTED PROCEDURE AtualizarCamposAuditoria()
1391:         LOCAL loc_oBO
1392: 
1393:         loc_oBO = THIS.this_oBusinessObject
1394: 
1395:         THIS.txt_4c_Nota.Value     = ALLTRIM(loc_oBO.this_cNotaAtual)
1396:         THIS.txt_4c_Usuario.Value  = ALLTRIM(loc_oBO.this_cUsuarioMovAtual)
1397:         THIS.txt_4c_Auditors.Value = ALLTRIM(loc_oBO.this_cAuditorAtual)
1398:         THIS.txt_4c_DtAudits.Value = loc_oBO.this_dDtAuditAtual
1399:         THIS.obj_4c_GetObs.Value   = loc_oBO.this_cObsAtual
1400: 
1401:         THIS.chk_4c_ChkAuditado.Visible = loc_oBO.this_lPodeAuditar
1402:         IF THIS.chk_4c_ChkAuditado.Visible
1403:             THIS.chk_4c_ChkAuditado.Value = IIF(EMPTY(loc_oBO.this_cAuditorAtual), 0, 1)
1404:         ENDIF
1405:     ENDPROC
1406: 
1407:     *--------------------------------------------------------------------------
1408:     * CarregarDadosIniciais - equivalente ao restante do Init legado:
1409:     * depois de CarregarGradePrincipal() (CrSigMvHst + TmpPro/TmpUni), monta
1410:     * o titulo do produto (ObterTituloProduto() do BO - equivalente a
1411:     * ThisForm.lbl_Produto.Caption do Init legado) e resolve o registro
1412:     * corrente (GO BOTTOM feito dentro de CarregarHistorico) via
1413:     * CarregarDoCursor() do BO - que ja encapsula BuscarDocumentoMovimento/
1414:     * BuscarDescricoesGrupoConta/VerificarPermissaoAuditoria/
1415:     * CarregarSubniveis, igual ao AfterRowColChange - e rebinda
1416:     * grd_4c_Subniveis e os 8 campos de Origem/Destino com o resultado.
1417:     *--------------------------------------------------------------------------
1418:     PROTECTED PROCEDURE CarregarDadosIniciais()
1419:         IF THIS.CarregarGradePrincipal()
1420:             THIS.lbl_4c_Lbl_produto.Caption = THIS.this_oBusinessObject.ObterTituloProduto()
1421: 
1422:             IF THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
1423:                 THIS.AtualizarGradeSubniveis()
1424:                 THIS.AtualizarCamposDocumento()
1425:                 THIS.AtualizarCamposAuditoria()
1426:             ENDIF
1427:         ENDIF
1428:     ENDPROC
1429: 
1430:     *--------------------------------------------------------------------------
1431:     * GrdDadosAfterRowColChange - AfterRowColChange de grd_4c_Dados (legado:
1432:     * grd_historico.AfterRowColChange, dump linhas 579-728): troca de linha/
1433:     * coluna na grade principal reposiciona documento de origem/destino,
1434:     * auditoria/observacao e a grade de subniveis para o registro agora
1435:     * corrente, via CarregarDoCursor() do BO (que ja encapsula
1436:     * BuscarDocumentoMovimento/BuscarDescricoesGrupoConta/
1437:     * VerificarPermissaoAuditoria/CarregarSubniveis - mesmo metodo usado por
1438:     * CarregarDadosIniciais()). LPARAMETERS par_nColIndex e PUBLIC - exigidos
1439:     * por BINDEVENT (CLAUDE.md regra #3).
1440:     *--------------------------------------------------------------------------
1441:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
1442:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1443:             IF THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
1444:                 THIS.AtualizarGradeSubniveis()
1445:                 THIS.AtualizarCamposDocumento()
1446:                 THIS.AtualizarCamposAuditoria()
1447:             ENDIF
1448:         ENDIF
1449:     ENDPROC
1450: 
1451:     *--------------------------------------------------------------------------
1452:     * ChkAuditadoClick - chkAuditado.Click do legado (dump:
1453:     * "Private lcDtHis / With ThisForm.poDataMgr / If This.Value = 1 /
1454:     * Select CrSigMvHst / Replace CrSigMvHst.auditors With Usuar /
1455:     * .SqlExecute([Update SigMvHst Set auditors = "]+Usuar+...) / If
1456:     * lnQueryOk < 1 / MessageBox('Favor reinicializar o processo.',16,
1457:     * 'Falha na Conex?o') / .RollBack() / Return(.F.) / EndIf / Replace
1458:     * CrSigMvHst.dtaudits With Date()..."): marca/desmarca a auditoria do
1459:     * registro corrente. THIS.this_oBusinessObject.AtualizarAuditoria() (BO,
1460:     * Fase 2) encapsula a transacao BEGIN/UPDATE auditors/UPDATE dtaudits/
1461:     * COMMIT-ou-ROLLBACK equivalente. Falhando, o checkbox volta ao estado
1462:     * anterior (o legado tambem reverte - o UPDATE nunca commitou) e exibe o
1463:     * MESMO texto do legado ("Favor reinicializar o processo."), que ja vem
1464:     * em THIS.this_cMensagemErro. Sucedendo, reconsulta o registro para
1465:     * refletir o auditors/dtaudits gravados (RegistrarAuditoria do proprio
1466:     * BO fica fora deste fluxo - jah chamado dentro de AtualizarAuditoria) e
1467:     * repinta a grade (auditors alimenta o DynamicBackColor verde-claro da
1468:     * Fase 7). PUBLIC - exigido para BINDEVENT (CLAUDE.md regra #3).
1469:     *--------------------------------------------------------------------------
1470:     PROCEDURE ChkAuditadoClick()
1471:         LOCAL loc_lMarcar
1472: 
1473:         loc_lMarcar = (THIS.chk_4c_ChkAuditado.Value = 1)
1474: 
1475:         IF THIS.this_oBusinessObject.AtualizarAuditoria(loc_lMarcar)
1476:             THIS.AtualizarCamposAuditoria()
1477:             THIS.grd_4c_Dados.Refresh()
1478:         ELSE
1479:             THIS.chk_4c_ChkAuditado.Value = IIF(loc_lMarcar, 0, 1)
1480:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
1481:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
1482:             ENDIF
1483:         ENDIF
1484:     ENDPROC
1485: 
1486:     *--------------------------------------------------------------------------
1487:     * ConfigurarBotoesAcao - cria os 3 botoes de acao do form (dump linhas
1488:     * 492-524 e 1386-1416): obj_4c_Sair (CommandGroup "sair", ButtonCount=1,
1489:     * botao "Encerrar" - mesmo papel do cnt_4c_Saida/cmd_4c_Encerrar
1490:     * canonico CRUD, aqui como CommandGroup porque e assim que o legado
1491:     * desenhou este form OPERACIONAL), cmd_4c_BtnDocumento ("Movimento") e
1492:     * cmd_4c_Command1 ("Procurar"). Os dois standalone usam Themes=.T. +
1493:     * DisabledPicture (CLAUDE.md - standalone CommandButton com Picture).
1494:     *--------------------------------------------------------------------------
1495:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
1496:         LOCAL loc_oErro
1497: 
1498:         TRY
1499:             THIS.AddObject("obj_4c_Sair", "CommandGroup")
1500:             WITH THIS.obj_4c_Sair
1501:                 .Top           = -2
1502:                 .Left          = 920
1503:                 .Width         = 85
1504:                 .Height        = 85
1505:                 .ButtonCount   = 1
1506:                 .BackStyle     = 0
1507:                 .BorderStyle   = 0
1508:                 .SpecialEffect = 1
1509:                 .BorderColor   = RGB(136, 189, 188)
1510:                 .Themes        = .F.
1511:                 .Visible       = .T.
1512:                 WITH .Buttons(1)
1513:                     .Top        = 5
1514:                     .Left       = 5
1515:                     .Width      = 75
1516:                     .Height     = 75
1517:                     .FontBold   = .T.
1518:                     .FontItalic = .T.
1519:                     .FontName   = "Comic Sans MS"
1520:                     .FontSize   = 8
1521:                     .WordWrap   = .T.
1522:                     .Cancel     = .T.
1523:                     .Caption    = "Encerrar"
1524:                     .ForeColor  = RGB(90, 90, 90)
1525:                     .BackColor  = RGB(255, 255, 255)
1526:                     .Themes     = .F.
1527:                     IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
1528:                         .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1529:                     ENDIF
1530:                 ENDWITH
1531:             ENDWITH
1532:             BINDEVENT(THIS.obj_4c_Sair, "Click", THIS, "ObjSairClick")
1533: 
1534:             THIS.AddObject("cmd_4c_BtnDocumento", "CommandButton")
1535:             WITH THIS.cmd_4c_BtnDocumento
1536:                 .Top        = 3
1537:                 .Left       = 775
1538:                 .Width      = 75
1539:                 .Height     = 75
1540:                 .FontBold   = .T.
1541:                 .FontItalic = .T.
1542:                 .FontName   = "Comic Sans MS"
1543:                 .FontSize   = 8
1544:                 .WordWrap   = .T.
1545:                 .Caption    = "\<Movimento"
1546:                 .ForeColor  = RGB(90, 90, 90)
1547:                 .BackColor  = RGB(255, 255, 255)
1548:                 .Themes     = .T.
1549:                 .Visible    = .T.
1550:                 IF FILE(gc_4c_CaminhoIcones + "geral_pastas_60.jpg")
1551:                     .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
1552:                     .DisabledPicture = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
1553:                 ENDIF
1554:             ENDWITH
1555:             BINDEVENT(THIS.cmd_4c_BtnDocumento, "Click", THIS, "BtnDocumentoClick")
1556: 
1557:             THIS.AddObject("cmd_4c_Command1", "CommandButton")
1558:             WITH THIS.cmd_4c_Command1
1559:                 .Top        = 3
1560:                 .Left       = 850
1561:                 .Width      = 75
1562:                 .Height     = 75
1563:                 .FontBold   = .T.
1564:                 .FontItalic = .T.
1565:                 .FontName   = "Comic Sans MS"
1566:                 .FontSize   = 8
1567:                 .WordWrap   = .T.
1568:                 .Caption    = "\<Procurar"
1569:                 .ForeColor  = RGB(90, 90, 90)
1570:                 .BackColor  = RGB(255, 255, 255)
1571:                 .Themes     = .T.
1572:                 .Visible    = .T.
1573:                 IF FILE(gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg")
1574:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
1575:                     .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
1576:                 ENDIF
1577:             ENDWITH
1578:             BINDEVENT(THIS.cmd_4c_Command1, "Click", THIS, "BtnProcurarClick")
1579:         CATCH TO loc_oErro
1580:             MsgErro(loc_oErro.Message + CHR(13) + ;
1581:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1582:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
1583:         ENDTRY
1584:     ENDPROC
1585: 
1586:     *--------------------------------------------------------------------------
1587:     * ObjSairClick - Click de obj_4c_Sair (legado: sair.Click, dump linhas
1588:     * 1700-1707): reabilita o form pai e libera esta tela. this_oFormPai
1589:     * substitui ThisForm.ParentForm; nao ha poDataMgr para liberar (a
1590:     * conexao SQL do sistema novo e gnConnHandle, global). PUBLIC - exigido
1591:     * para BINDEVENT (CLAUDE.md regra #3).
1592:     *--------------------------------------------------------------------------
1593:     PROCEDURE ObjSairClick()
1594:         IF VARTYPE(THIS.this_oFormPai) = "O"
1595:             THIS.this_oFormPai.Enabled = .T.
1596:         ENDIF
1597:         THIS.Release()
1598:     ENDPROC
1599: 
1600:     *--------------------------------------------------------------------------
1601:     * BtnProcurarClick - Click de cmd_4c_Command1 ("Procurar", legado:
1602:     * Command1.Click, dump linhas 2248-2253): mostra o campo de filtro por
1603:     * data (txt_4c_Data/lbl_4c_Label6 - Get_Data/Say6 no legado, criados na
1604:     * Fase 5-6) com a data corrente e foca nele. PEMSTATUS guarda a
1605:     * referencia-futura ate a Fase 5-6 criar esses controles - sem ela, um
1606:     * clique antes da Fase 5-6 estourar "Property TXT_4C_DATA is not
1607:     * found" em vez de simplesmente nao fazer nada. PUBLIC - exigido para
1608:     * BINDEVENT (CLAUDE.md regra #3).
1609:     *--------------------------------------------------------------------------
1610:     PROCEDURE BtnProcurarClick()
1611:         IF PEMSTATUS(THIS, "txt_4c_Data", 5)
1612:             THIS.this_lOcultandoFiltroData = .F.
1613:             THIS.txt_4c_Data.Visible = .T.
1614:             IF PEMSTATUS(THIS, "lbl_4c_Label6", 5)
1615:                 THIS.lbl_4c_Label6.Visible = .T.
1616:             ENDIF
1617:             THIS.txt_4c_Data.Value = DATE()
1618:             THIS.txt_4c_Data.SetFocus()
1619:         ENDIF
1620:     ENDPROC
1621: 
1622:     *--------------------------------------------------------------------------
1623:     * BtnDocumentoClick - Click de cmd_4c_BtnDocumento ("Movimento", legado:
1624:     * btnDocumento.Click, dump linhas 2265-2278): abre o documento de
1625:     * movimento da linha corrente de grd_4c_Dados - FormSigMvExp quando ja
1626:     * efetivado (SigMvCab/EmpDopNums) ou FormSigMvPdt quando ainda e
1627:     * necessidade ainda em aberto (SigCdNec/EmpDnPs), replicando
1628:     * ThisForm.poDataMgr.ChkRegister(...) com
1629:     * VerificarDocumentoCadastrado() do BO (Fase 2). As chaves EmpDopNums
1630:     * (29) e EmpDnPs (33) sao POSICIONAIS - PADR explicito, nunca ALLTRIM
1631:     * nas partes (CLAUDE.md regra #42). Show() FORA do TRY - os dois forms
1632:     * sao modais (CLAUDE.md regra #29). PUBLIC - exigido para BINDEVENT
1633:     * (CLAUDE.md regra #3).
1634:     *--------------------------------------------------------------------------
1635:     PROCEDURE BtnDocumentoClick()
1636:         LOCAL loc_cEmps, loc_cEmpos, loc_cDopes, loc_nNumes, loc_cEmpDoc, loc_cClasseForm, loc_oForm, loc_oErro
1637:         loc_cClasseForm = ""
1638: 
1639:         IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cEmpsAtual)) ;
1640:                 OR EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cDopesAtual)) ;
1641:                 OR THIS.this_oBusinessObject.this_nNumesAtual = 0
1642:             MsgAviso("Selecione uma Etiqueta em uma das listas para visualizar o Documento!!!", "Aten" + CHR(231) + CHR(227) + "o")
1643:             RETURN
1644:         ENDIF
1645: 
1646:         loc_cEmps   = PADR(THIS.this_oBusinessObject.this_cEmpsAtual, 3)
1647:         loc_cEmpos  = PADR(THIS.this_oBusinessObject.this_cEmposAtual, 3)
1648:         loc_cDopes  = PADR(THIS.this_oBusinessObject.this_cDopesAtual, 20)
1649:         loc_nNumes  = THIS.this_oBusinessObject.this_nNumesAtual
1650:         loc_cEmpDoc = IIF(!EMPTY(loc_cEmpos), loc_cEmpos, loc_cEmps)
1651: 
1652:         IF THIS.this_oBusinessObject.VerificarDocumentoCadastrado("SigMvCab", "EmpDopNums", ;
1653:                 loc_cEmpDoc + loc_cDopes + STR(loc_nNumes, 6))
1654:             loc_cClasseForm = "FormSigMvExp"
1655:         ELSE
1656:             IF THIS.this_oBusinessObject.VerificarDocumentoCadastrado("SigCdNec", "EmpDnPs", ;
1657:                     loc_cEmps + loc_cDopes + STR(loc_nNumes, 10))
1658:                 loc_cClasseForm = "FormSigMvPdt"
1659:             ENDIF
1660:         ENDIF
1661: 
1662:         IF EMPTY(loc_cClasseForm)
1663:             RETURN
1664:         ENDIF
1665: 
1666:         loc_oForm = .NULL.
1667:         TRY
1668:             IF loc_cClasseForm == "FormSigMvExp"
1669:                 loc_oForm = CREATEOBJECT(loc_cClasseForm, ALLTRIM(loc_cDopes), "C", loc_nNumes, ALLTRIM(loc_cEmpDoc), .T.)
1670:             ELSE
1671:                 loc_oForm = CREATEOBJECT(loc_cClasseForm, ALLTRIM(loc_cDopes), "C", loc_nNumes, ALLTRIM(loc_cEmps), .T.)
1672:             ENDIF
1673:         CATCH TO loc_oErro
1674:             MsgErro("Erro ao abrir documento:" + CHR(13) + loc_oErro.Message, "Movimento")
1675:             loc_oForm = .NULL.
1676:         ENDTRY
1677: 
1678:         IF VARTYPE(loc_oForm) = "O"
1679:             loc_oForm.Show()
1680:         ENDIF
1681:     ENDPROC
1682: 
1683:     *--------------------------------------------------------------------------
1684:     * ValidarData - Get_Data.Valid do legado (dump linhas 2180-2195):
1685:     *
1686:     *     If IsEmpty(This.Value)
1687:     *         This.Visible = .F. / ThisForm.Say6.Visible = .F. / Return(.T.)
1688:     *     EndIf
1689:     *     Select CrSigMvHst / Set Near On
1690:     *     =Seek(DTOS(This.Value),"CrSigMvHst","datas")
1691:     *     Set Near Off / ThisForm.grd_historico.Refresh / Return(.T.)
1692:     *
1693:     * Valor vazio: esconde o campo e a label e sai (mesmo corpo do LostFocus).
1694:     * Valor preenchido: posiciona cursor_4c_Dados (CrSigMvHst) na data
1695:     * informada e repinta a grade - SET NEAR ON faz o SEEK parar no registro
1696:     * mais PROXIMO quando a data exata nao existe, que e o comportamento de
1697:     * "procurar" esperado pelo usuario. O tag "datas" e criado pelo BO com
1698:     * INDEX ON DTOS(datas) (SigPrHprBO.CarregarHistorico), por isso a chave do
1699:     * SEEK tambem e DTOS() - a forma de 3 argumentos dispensa SET ORDER.
1700:     * SET NEAR e RESTAURADO ao valor anterior (nao chutado para OFF): sem
1701:     * isso o metodo mudaria um SET da datasession em vez de so usa-lo.
1702:     * ConverterParaData() normaliza DATE/DATETIME/CHAR - .Value nasce {}
1703:     * (DATE) mas o campo e digitado pelo usuario (CLAUDE.md regra #16).
1704:     * PUBLIC - exigido para BINDEVENT (CLAUDE.md regra #3).
1705:     *--------------------------------------------------------------------------
1706:     PROCEDURE ValidarData(par_nKeyCode, par_nShiftAltCtrl)
1707:         LOCAL loc_dData, loc_cNearAnterior, loc_oErro
1708: 
1709:         *-- Guarda obrigatoria do handler de KeyPress: so age nas teclas que
1710:         *-- encerram a digitacao (CLAUDE.md - KeyPress handler com guard).
1711:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1712:             RETURN
1713:         ENDIF
1714: 
1715:         loc_dData = ConverterParaData(THIS.txt_4c_Data.Value)
1716: 
1717:         IF EMPTY(loc_dData)
1718:             THIS.OcultarFiltroData()
1719:             RETURN
1720:         ENDIF
1721: 
1722:         TRY
1723:             IF USED("cursor_4c_Dados")
1724:                 loc_cNearAnterior = SET("NEAR")
1725: 
1726:                 SELECT cursor_4c_Dados
1727:                 SET NEAR ON
1728:                 =SEEK(DTOS(loc_dData), "cursor_4c_Dados", "datas")
1729: 
1730:                 IF loc_cNearAnterior == "OFF"
1731:                     SET NEAR OFF
1732:                 ENDIF
1733: 
1734:                 THIS.grd_4c_Dados.Refresh()
1735:             ENDIF
1736:         CATCH TO loc_oErro
1737:             MsgErro(loc_oErro.Message + CHR(13) + ;
1738:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1739:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarData")
1740:         ENDTRY
1741:     ENDPROC
1742: 
1743:     *--------------------------------------------------------------------------
1744:     * DataLostFocus - Get_Data.LostFocus do legado (dump linhas 2171-2175).
1745:     * BINDEVENT em LostFocus e seguro AQUI porque o handler nao executa SQL
1746:     * nem remonta grade - so esconde dois controles e move o foco; a recursao
1747:     * que a regra do CLAUDE.md adverte e tratada pela guarda
1748:     * this_lOcultandoFiltroData dentro de OcultarFiltroData().
1749:     * PUBLIC - exigido para BINDEVENT (CLAUDE.md regra #3).
1750:     *--------------------------------------------------------------------------
1751:     PROCEDURE DataLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1752:         THIS.OcultarFiltroData()
1753:     ENDPROC
1754: 
1755:     *--------------------------------------------------------------------------
1756:     * OcultarFiltroData - corpo comum ao LostFocus e ao ramo "data vazia" do
1757:     * Valid do legado: esconde txt_4c_Data/lbl_4c_Label6 (Get_Data/Say6) e
1758:     * devolve o foco a primeira coluna da grade. O SetFocus so e tentado com
1759:     * a grade visivel/habilitada e com registro no cursor - grade vazia nao
1760:     * tem celula para receber o foco (o legado nunca chega aqui sem registro,
1761:     * porque o campo so aparece depois do "Procurar" sobre a grade montada).
1762:     *--------------------------------------------------------------------------
1763:     PROTECTED PROCEDURE OcultarFiltroData()
1764:         IF THIS.this_lOcultandoFiltroData
1765:             RETURN
1766:         ENDIF
1767: 
1768:         THIS.this_lOcultandoFiltroData = .T.
1769: 
1770:         THIS.txt_4c_Data.Visible   = .F.
1771:         THIS.lbl_4c_Label6.Visible = .F.
1772: 
1773:         IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled AND ;
1774:                 USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1775:             THIS.grd_4c_Dados.Column1.SetFocus()
1776:         ENDIF
1777: 
1778:         THIS.this_lOcultandoFiltroData = .F.
1779:     ENDPROC
1780: 
1781: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrHprBO.prg):
*============================================================================
* SigPrHprBO.prg - Business Object para Historico de Produtos (SIGPRHPR)
*
* Form OPERACIONAL (SIGPRHPR / FormSigPrHpr): tela de CONSULTA aberta por um
* form pai (ThisForm.ParentForm) que ja definiu, antes de "Do Form SigPrHpr",
* as variaveis PRIVATE pcCdGrupo/pcCdConta/pcCdProduto/pcDsProduto/pdDataIni/
* pdDataFin (grupo, conta, produto e periodo cujo historico de movimentos
* sera exibido - ver tasks/task621/SigPrHpr_form_codigo_fonte.txt,
* Procedure Init). A tela mostra:
*   - a grade principal grd_4c_Dados (CrSigMvHst no legado) com o historico
*     de movimentos do produto no periodo;
*   - a grade secundaria grd_4c_Subniveis (crSubniveis no legado) com os
*     subniveis (SigMvPec x SigCdOpe) do documento selecionado;
*   - origem/destino (Grupo/Conta) do documento de movimento corrente,
*     resolvidos contra SigMvCab (ou SigCdNec quando o documento ainda nao
*     foi efetivado) e descritos via SigCdGcr/SigCdCli;
*   - o checkbox de Auditado, que GRAVA (UPDATE SigMvHst) auditors/dtaudits
*     do registro corrente - a UNICA escrita real deste form.
*
* NAO existe uma unica "tabela principal" para efeito de Buscar()/
* CarregarDoCursor() (this_cTabela permanece vazio, mesmo padrao adotado em
* SigPrGstBO/SigPrGlxBO): o historico vem de SigMvHst filtrado por
* Grupo+Conta+Produto+Periodo, e os cursores auxiliares (documento, grupo/
* conta descritivos, subniveis) sao resolvidos a cada linha selecionada na
* grade principal (AfterRowColChange do legado). this_cCampoChave aponta
* para "cidchaves" (SigMvHst.cidchaves, PK), que eh o unico campo usado
* para localizar o registro no UPDATE de auditoria.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos CRUD/dominio (CarregarHistorico,
* CarregarDoCursor, BuscarDocumentoMovimento, BuscarDescricoesGrupoConta,
* VerificarPermissaoAuditoria, CarregarSubniveis, AtualizarAuditoria,
* VerificarDocumentoCadastrado, ObterChavePrimaria, ObterTituloProduto)
*============================================================================

DEFINE CLASS SigPrHprBO AS BusinessBase

    *==========================================================================
    * Parametros recebidos do form pai (equivalente as PRIVATE pcCdGrupo/
    * pcCdConta/pcCdProduto/pcDsProduto/pdDataIni/pdDataFin do legado -
    * definidas pelo chamador ANTES de abrir esta tela)
    *==========================================================================
    this_cGrupo             = SPACE(10)  && pcCdGrupo  (SigMvHst.grupos char(10))
    this_cConta             = SPACE(10)  && pcCdConta  (SigMvHst.estos  char(10))
    this_cProduto           = SPACE(14)  && pcCdProduto (SigMvHst.cpros char(14))
    this_cDescricaoProduto  = ""         && pcDsProduto (descricao exibida no titulo)
    this_dDataIni           = {}         && pdDataIni  (inicio do periodo)
    this_dDataFin           = {}         && pdDataFin  (fim do periodo)

    *==========================================================================
    * Registro corrente da grade principal (equivalente a CrSigMvHst na
    * linha ativa - usado por AfterRowColChange/chkAuditado.Click/
    * btnDocumento.Click do legado)
    *==========================================================================
    this_cEmpsAtual         = SPACE(3)   && CrSigMvHst.emps
    this_cEmposAtual        = SPACE(3)   && CrSigMvHst.empos
    this_cDopesAtual        = SPACE(20)  && CrSigMvHst.dopes
    this_nNumesAtual        = 0          && CrSigMvHst.numes
    this_cCidChavesAtual    = SPACE(20)  && CrSigMvHst.cidchaves (PK - chave do UPDATE de auditoria)
    this_cAuditorAtual      = SPACE(10)  && CrSigMvHst.auditors
    this_dDtAuditAtual      = {}         && CrSigMvHst.dtaudits
    this_cObsAtual          = ""         && CrSigMvHst.obs
    this_cUsuarioMovAtual   = SPACE(10)  && CrSigMvHst.usuars
    this_cNotaAtual         = SPACE(6)   && SigMvCab.notas do documento corrente

    *==========================================================================
    * Produto / unidade (equivalente a TmpPro/TmpUni do legado - resolvidos
    * uma unica vez no Init para decidir se a grade mostra as colunas de
    * Peso/Saldo Peso)
    *==========================================================================
    this_cUnidade           = SPACE(3)   && SigCdPro.cunis
    this_cUnidadePeso       = SPACE(3)   && SigCdPro.cunips
    this_cTipoEstoque       = SPACE(1)   && SigCdUni.cestos ("3" = controla peso)

    *==========================================================================
    * Documento de origem/destino do movimento corrente (equivalente a
    * CrSigMvCab resolvido no AfterRowColChange do legado - grupoos/
    * contaos/grupods/contads - e suas descricoes via SigCdGcr/SigCdCli)
    *==========================================================================
    this_cGrupoOrigem       = SPACE(10)  && SigMvCab.grupoos
    this_cContaOrigem       = SPACE(10)  && SigMvCab.contaos
    this_cGrupoDestino      = SPACE(10)  && SigMvCab.grupods
    this_cContaDestino      = SPACE(10)  && SigMvCab.contads
    this_cDescGrupoOrigem   = SPACE(40)  && SigCdGcr.descrs (grupoos)
    this_cDescContaOrigem   = SPACE(50)  && SigCdCli.rclis  (contaos)
    this_cDescGrupoDestino  = SPACE(40)  && SigCdGcr.descrs (grupods)
    this_cDescContaDestino  = SPACE(50)  && SigCdCli.rclis  (contads)

    *==========================================================================
    * Permissao de auditoria (equivalente a llSupervis/llVisAudit do Init
    * legado - decide se o chk_4c_Auditado fica visivel para o usuario
    * corrente)
    *==========================================================================
    this_lUsuarioSupervisor = .F.        && Upper(Alltrim(Usuar)) = "4CONTROL"
    this_lPodeAuditar       = .F.        && llVisAudit (resultado final da checagem)

    *==========================================================================
    * Init - Inicializa o Business Object. Nao ha tabela/chave primaria
    * unica para este processo de consulta (o historico vem de SigMvHst
    * filtrado por Grupo+Conta+Produto+Periodo recebidos do form pai) -
    * mesmo padrao adotado em SigPrGstBO.Init/SigPrGlxBO.Init. this_cCam
    * poChave fica com "cidchaves" (SigMvHst.cidchaves), unico campo usado
    * para localizar o registro no UPDATE de auditoria.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cGrupo            = SPACE(10)
            THIS.this_cConta            = SPACE(10)
            THIS.this_cProduto          = SPACE(14)
            THIS.this_cDescricaoProduto = ""
            THIS.this_dDataIni          = {}
            THIS.this_dDataFin          = {}

            THIS.this_cEmpsAtual        = SPACE(3)
            THIS.this_cEmposAtual       = SPACE(3)
            THIS.this_cDopesAtual       = SPACE(20)
            THIS.this_nNumesAtual       = 0
            THIS.this_cCidChavesAtual   = SPACE(20)
            THIS.this_cAuditorAtual     = SPACE(10)
            THIS.this_dDtAuditAtual     = {}
            THIS.this_cObsAtual         = ""
            THIS.this_cUsuarioMovAtual  = SPACE(10)
            THIS.this_cNotaAtual        = SPACE(6)

            THIS.this_cUnidade          = SPACE(3)
            THIS.this_cUnidadePeso      = SPACE(3)
            THIS.this_cTipoEstoque      = SPACE(1)

            THIS.this_cGrupoOrigem      = SPACE(10)
            THIS.this_cContaOrigem      = SPACE(10)
            THIS.this_cGrupoDestino     = SPACE(10)
            THIS.this_cContaDestino     = SPACE(10)
            THIS.this_cDescGrupoOrigem  = SPACE(40)
            THIS.this_cDescContaOrigem  = SPACE(50)
            THIS.this_cDescGrupoDestino = SPACE(40)
            THIS.this_cDescContaDestino = SPACE(50)

            THIS.this_lUsuarioSupervisor = .F.
            THIS.this_lPodeAuditar       = .F.

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inicializar: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - chave usada por RegistrarAuditoria() apos o
    * UPDATE de auditoria (AtualizarAuditoria) - SigMvHst.cidchaves do
    * registro corrente da grade principal.
    *
    * PROTECTED porque o metodo da base tambem eh PROTECTED - subclasse nao
    * alarga escopo de hook herdado.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChavesAtual)
    ENDPROC

    *==========================================================================
    * Inserir()/Atualizar()/ExecutarExclusao() do BusinessBase NAO sao
    * sobrescritos aqui: este form eh de CONSULTA (historico de movimentos
    * de SigMvHst), sem INSERT/UPDATE/DELETE genericos no legado. A UNICA
    * escrita real (toggle de chk_4c_Auditado) tem semantica propria -
    * AtualizarAuditoria(), mais abaixo, grava auditors/dtaudits em
    * SigMvHst e chama RegistrarAuditoria("UPDATE") no sucesso. O
    * comportamento padrao herdado de BusinessBase para Inserir/Atualizar/
    * ExecutarExclusao ja eh o correto para este BO.
    *==========================================================================

    *==========================================================================
    * ExecutarSQL - SQLEXEC preservando a area de trabalho corrente
    * (equivalente a ThisForm.poDataMgr.SqlExecute do legado, que nao
    * reseleciona a area depois - SQLEXEC() troca a area selecionada).
    *==========================================================================
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor, par_cRotulo)
        LOCAL loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0)

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * BuscarProdutoUnidade - produto/unidade do historico (TmpPro/TmpUni do
    * legado) - decide via this_cTipoEstoque se a grade mostra as colunas
    * de Peso/Saldo Peso (cestos = "3").
    *==========================================================================
    PROTECTED FUNCTION BuscarProdutoUnidade(par_cProduto)
        LOCAL loc_lResultado, loc_cSQL

        loc_lResultado = .F.

        loc_cSQL = "SELECT cpros, cunis, cunips FROM SigCdPro WHERE cpros = " + EscaparSQL(par_cProduto)

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Produto", "Produto")
            IF USED("cursor_4c_Produto") AND RECCOUNT("cursor_4c_Produto") > 0
                SELECT cursor_4c_Produto
                GO TOP
                THIS.this_cUnidade     = PADR(TratarNulo(cunis, ""), 3)
                THIS.this_cUnidadePeso = PADR(TratarNulo(cunips, ""), 3)
                USE IN cursor_4c_Produto

                loc_cSQL = "SELECT cestos FROM SigCdUni WHERE cunis = " + EscaparSQL(THIS.this_cUnidade)
                IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Unidade", "Unidade")
                    IF USED("cursor_4c_Unidade") AND RECCOUNT("cursor_4c_Unidade") > 0
                        SELECT cursor_4c_Unidade
                        GO TOP
                        THIS.this_cTipoEstoque = TratarNulo(cestos, "")
                        loc_lResultado = .T.
                    ENDIF
                    IF USED("cursor_4c_Unidade")
                        USE IN cursor_4c_Unidade
                    ENDIF
                ENDIF
            ELSE
                IF USED("cursor_4c_Produto")
                    USE IN cursor_4c_Produto
                ENDIF
                THIS.this_cMensagemErro = "Produto " + ALLTRIM(TratarNulo(par_cProduto, "")) + " n" + CHR(227) + "o encontrado."
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarHistorico - equivalente ao bloco principal do Init legado:
    * resolve produto/unidade, popula cursor_4c_Dados (CrSigMvHst) com o
    * historico de movimentos filtrado por Grupo+Conta+Produto+Periodo e
    * deixa o cursor posicionado no ULTIMO registro (Go Bottom legado), que
    * eh quem o Form usa para carregar a linha inicial via
    * CarregarDoCursor(). Chave empgruests eh POSICIONAL (emps(3)+
    * grupos(10)+estos(10) = 23) - PADR explicito, nunca ALLTRIM nas partes
    * (CLAUDE.md regra #42).
    *==========================================================================
    FUNCTION CarregarHistorico(par_cGrupo, par_cConta, par_cProduto, par_cDescricaoProduto, par_dDataIni, par_dDataFin)
        LOCAL loc_lResultado, loc_cSQL, loc_cChave, loc_dFim

        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        THIS.this_cGrupo            = PADR(TratarNulo(par_cGrupo, ""), 10)
        THIS.this_cConta            = PADR(TratarNulo(par_cConta, ""), 10)
        THIS.this_cProduto          = PADR(TratarNulo(par_cProduto, ""), 14)
        THIS.this_cDescricaoProduto = ALLTRIM(TratarNulo(par_cDescricaoProduto, ""))
        THIS.this_dDataIni          = TratarNulo(par_dDataIni, {})
        THIS.this_dDataFin          = TratarNulo(par_dDataFin, {})

        IF !THIS.BuscarProdutoUnidade(THIS.this_cProduto)
            RETURN .F.
        ENDIF

        loc_dFim = DATETIME(YEAR(THIS.this_dDataFin), MONTH(THIS.this_dDataFin), DAY(THIS.this_dDataFin), 23, 59, 59)

        loc_cChave = PADR(go_4c_Sistema.cCodEmpresa, 3) + THIS.this_cGrupo + THIS.this_cConta

        loc_cSQL = "SELECT a.emps, a.empos, a.grupos, a.estos, a.cpros, a.dopes, a.numes, " + ;
            "a.datas, a.auditors, a.dtaudits, a.qtds, a.opers, a.sqtds, a.obs, " + ;
            "a.usuars, a.cidchaves, a.pesos, a.spesos, SPACE(3) AS cunis " + ;
            "FROM SigMvHst a " + ;
            "WHERE a.empgruests = " + EscaparSQL(loc_cChave) + " " + ;
            "AND a.cpros = " + EscaparSQL(THIS.this_cProduto) + " " + ;
            "AND a.datas BETWEEN " + FormatarDataSQL(THIS.this_dDataIni) + " AND " + FormatarDataSQL(loc_dFim) + " " + ;
            "ORDER BY a.emps, a.grupos, a.estos, a.cidchaves, a.opers"

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Dados", "Historico")
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                REPLACE ALL cunis WITH THIS.this_cUnidade
                INDEX ON Pesos TAG Pesos
                INDEX ON DTOS(datas) TAG datas
                GO BOTTOM
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ObterTituloProduto - monta o Caption de lbl_4c_Produto (equivalente a
    * ThisForm.lbl_Produto.Caption do Init legado): produto + descricao +
    * periodo e, quando a unidade controla peso (cestos = "3"), tambem a
    * unidade de peso.
    *==========================================================================
    FUNCTION ObterTituloProduto()
        LOCAL loc_cTitulo

        loc_cTitulo = "Produto : " + ALLTRIM(THIS.this_cProduto) + " - " + ALLTRIM(THIS.this_cDescricaoProduto) + ;
            SPACE(10) + "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDataIni) + " " + CHR(224) + " " + DTOC(THIS.this_dDataFin)

        IF THIS.this_cTipoEstoque == "3"
            loc_cTitulo = loc_cTitulo + " Unid.Peso:" + ALLTRIM(THIS.this_cUnidadePeso)
        ENDIF

        RETURN loc_cTitulo
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - equivalente ao AfterRowColChange do legado: le o
    * registro CORRENTE de cursor_4c_Dados (a grade principal) e resolve
    * tudo o que depende dele - documento de origem/destino, descricoes de
    * grupo/conta, permissao de auditoria e subniveis.
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cEmpsAtual       = PADR(TratarNulo(emps, ""), 3)
            THIS.this_cEmposAtual      = PADR(TratarNulo(empos, ""), 3)
            THIS.this_cDopesAtual      = PADR(TratarNulo(dopes, ""), 20)
            THIS.this_nNumesAtual      = TratarNulo(numes, 0)
            THIS.this_cCidChavesAtual  = PADR(TratarNulo(cidchaves, ""), 20)
            THIS.this_cAuditorAtual    = PADR(TratarNulo(auditors, ""), 10)
            THIS.this_dDtAuditAtual    = TratarNulo(dtaudits, {})
            THIS.this_cObsAtual        = TratarNulo(obs, "")
            THIS.this_cUsuarioMovAtual = PADR(TratarNulo(usuars, ""), 10)
            THIS.this_cNotaAtual       = SPACE(6)

            IF THIS.BuscarDocumentoMovimento()
                THIS.BuscarDescricoesGrupoConta()
            ENDIF

            THIS.VerificarPermissaoAuditoria()
            THIS.CarregarSubniveis()

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * VerificarOperacaoCadastrada - equivalente a
    * ThisForm.poDataMgr.Cursorquery('SigCdOpe','CrOpe','Dopes',...,'Dopes')
    * do legado: confirma se a operacao (Dopes) do movimento corrente esta
    * cadastrada em SigCdOpe. Decide se o documento se resolve por
    * SigMvCab (movimento ja efetivado) ou por SigCdNec (necessidade,
    * ainda nao efetivada).
    *==========================================================================
    PROTECTED FUNCTION VerificarOperacaoCadastrada(par_cDopes)
        LOCAL loc_lResultado, loc_cSQL

        loc_lResultado = .F.

        loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdOpe WHERE Dopes = " + ;
            EscaparSQL(ALLTRIM(TratarNulo(par_cDopes, "")))

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_VerOpe", "VerificarOperacao")
            IF USED("cursor_4c_VerOpe")
                loc_lResultado = (NVL(cursor_4c_VerOpe.Total, 0) > 0)
                USE IN cursor_4c_VerOpe
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * BuscarDocumentoMovimento - resolve o documento de origem/destino do
    * movimento corrente (grupoos/contaos/grupods/contads), igual ao
    * AfterRowColChange do legado: tenta SigMvCab (documento JA efetivado,
    * chave EmpDopNums char(29) = emps(3)+dopes(20)+Str(numes,6)) e cai
    * para SigCdNec (necessidade, ainda nao efetivada, chave EmpDnPs
    * char(33) = emps(3)+dopes(20)+Str(numes,10)) quando a operacao nao
    * esta cadastrada em SigCdOpe. As duas chaves sao POSICIONAIS - PADR
    * explicito, nunca ALLTRIM nas partes (CLAUDE.md regra #42).
    *==========================================================================
    PROTECTED FUNCTION BuscarDocumentoMovimento()
        LOCAL loc_lResultado, loc_cSQL, loc_cEmpDoc

        loc_lResultado = .F.

        loc_cEmpDoc = PADR(IIF(!EMPTY(THIS.this_cEmposAtual), THIS.this_cEmposAtual, THIS.this_cEmpsAtual), 3)

        THIS.this_cGrupoOrigem  = SPACE(10)
        THIS.this_cContaOrigem  = SPACE(10)
        THIS.this_cGrupoDestino = SPACE(10)
        THIS.this_cContaDestino = SPACE(10)
        THIS.this_cNotaAtual    = SPACE(6)

        IF THIS.VerificarOperacaoCadastrada(THIS.this_cDopesAtual)
            loc_cSQL = "SELECT grupoos, contaos, grupods, contads, Notas FROM SigMvCab " + ;
                "WHERE empdopnums = " + EscaparSQL(loc_cEmpDoc + PADR(THIS.this_cDopesAtual, 20) + STR(THIS.this_nNumesAtual, 6))
        ELSE
            loc_cSQL = "SELECT grupoos, contaos, grupods, contads, SPACE(6) AS Notas FROM SigCdNec " + ;
                "WHERE empdnps = " + EscaparSQL(loc_cEmpDoc + PADR(THIS.this_cDopesAtual, 20) + STR(THIS.this_nNumesAtual, 10))
        ENDIF

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Documento", "Documento")
            IF USED("cursor_4c_Documento") AND RECCOUNT("cursor_4c_Documento") > 0
                SELECT cursor_4c_Documento
                GO TOP
                THIS.this_cGrupoOrigem  = PADR(TratarNulo(grupoos, ""), 10)
                THIS.this_cContaOrigem  = PADR(TratarNulo(contaos, ""), 10)
                THIS.this_cGrupoDestino = PADR(TratarNulo(grupods, ""), 10)
                THIS.this_cContaDestino = PADR(TratarNulo(contads, ""), 10)
                THIS.this_cNotaAtual    = PADR(TratarNulo(Notas, ""), 6)
                loc_lResultado = .T.
            ENDIF
            IF USED("cursor_4c_Documento")
                USE IN cursor_4c_Documento
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * BuscarDescricoesGrupoConta - descricoes de Grupo (SigCdGcr.descrs) e
    * Conta (SigCdCli.rclis) de origem/destino do documento corrente.
    *==========================================================================
    PROTECTED FUNCTION BuscarDescricoesGrupoConta()
        LOCAL loc_cSQL, loc_cGO, loc_cGD, loc_cCO, loc_cCD

        loc_cGO = ALLTRIM(THIS.this_cGrupoOrigem)
        loc_cGD = ALLTRIM(THIS.this_cGrupoDestino)
        loc_cCO = ALLTRIM(THIS.this_cContaOrigem)
        loc_cCD = ALLTRIM(THIS.this_cContaDestino)

        THIS.this_cDescGrupoOrigem  = SPACE(40)
        THIS.this_cDescContaOrigem  = SPACE(50)
        THIS.this_cDescGrupoDestino = SPACE(40)
        THIS.this_cDescContaDestino = SPACE(50)

        IF !EMPTY(loc_cGO) OR !EMPTY(loc_cGD)
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGO) + ;
                " OR codigos = " + EscaparSQL(loc_cGD)
            IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Grupo", "Grupo")
                IF USED("cursor_4c_Grupo")
                    INDEX ON codigos TAG codigos
                    IF !EMPTY(loc_cGO) AND SEEK(loc_cGO, "cursor_4c_Grupo", "codigos")
                        THIS.this_cDescGrupoOrigem = PADR(TratarNulo(cursor_4c_Grupo.descrs, ""), 40)
                    ENDIF
                    IF !EMPTY(loc_cGD) AND SEEK(loc_cGD, "cursor_4c_Grupo", "codigos")
                        THIS.this_cDescGrupoDestino = PADR(TratarNulo(cursor_4c_Grupo.descrs, ""), 40)
                    ENDIF
                    USE IN cursor_4c_Grupo
                ENDIF
            ENDIF
        ENDIF

        IF !EMPTY(loc_cCO) OR !EMPTY(loc_cCD)
            loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCO) + ;
                " OR iclis = " + EscaparSQL(loc_cCD)
            IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Conta", "Conta")
                IF USED("cursor_4c_Conta")
                    INDEX ON iclis TAG iclis
                    IF !EMPTY(loc_cCO) AND SEEK(loc_cCO, "cursor_4c_Conta", "iclis")
                        THIS.this_cDescContaOrigem = PADR(TratarNulo(cursor_4c_Conta.rclis, ""), 50)
                    ENDIF
                    IF !EMPTY(loc_cCD) AND SEEK(loc_cCD, "cursor_4c_Conta", "iclis")
                        THIS.this_cDescContaDestino = PADR(TratarNulo(cursor_4c_Conta.rclis, ""), 50)
                    ENDIF
                    USE IN cursor_4c_Conta
                ENDIF
            ENDIF
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * VerificarPermissaoAuditoria - equivalente ao bloco llSupervis/
    * llVisAudit do AfterRowColChange legado. this_lUsuarioSupervisor e
    * this_lPodeAuditar decidem se chk_4c_Auditado fica visivel/habilitado
    * para o usuario corrente.
    *==========================================================================
    PROTECTED FUNCTION VerificarPermissaoAuditoria()
        LOCAL loc_cUsuario

        loc_cUsuario = UPPER(ALLTRIM(TratarNulo(gc_4c_UsuarioLogado, "")))

        * Richard em 29/11/2016 - Eliminando SUPERVIS (a consulta a
        * SigCdUsu.supervis foi comentada no legado - *!* no fonte
        * original - preservado: so o usuario 4CONTROL eh supervisor)
        THIS.this_lUsuarioSupervisor = (loc_cUsuario == "4CONTROL")

        IF THIS.this_lUsuarioSupervisor
            THIS.this_lPodeAuditar = .T.
        ELSE
            IF EMPTY(THIS.this_cAuditorAtual) AND fChecaAcesso("SIGPRHPR", "AUDITORIA")
                THIS.this_lPodeAuditar = .T.
            ELSE
                THIS.this_lPodeAuditar = (loc_cUsuario == UPPER(ALLTRIM(THIS.this_cAuditorAtual)))
            ENDIF
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * CarregarSubniveis - equivalente ao bloco final do AfterRowColChange
    * legado: Zap In crSubniveis + Scan/Insert Into a partir de SigMvPec x
    * SigCdOpe. Chave EmpDopNums eh POSICIONAL (emps(3)+dopes(20)+
    * Str(numes,6) = 29) - PADR explicito, nunca ALLTRIM nas partes
    * (CLAUDE.md regra #42).
    *==========================================================================
    FUNCTION CarregarSubniveis()
        LOCAL loc_lResultado, loc_cSQL, loc_cEdn

        loc_lResultado = .F.

        IF USED("cursor_4c_Subniveis")
            USE IN cursor_4c_Subniveis
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Subniveis (Emps C(3), Dopes C(20), Numes N(6))
        SET NULL OFF
        INDEX ON Emps TAG Emps

        loc_cEdn = PADR(THIS.this_cEmpsAtual, 3) + PADR(THIS.this_cDopesAtual, 20) + STR(THIS.this_nNumesAtual, 6)

        loc_cSQL = "SELECT a.EmpSubns AS Emps, b.Dopes, RIGHT(STR(a.Codigos, 10), 6) AS Numes " + ;
            "FROM SigMvPec a, SigCdOpe b " + ;
            "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + " " + ;
            "AND LEFT(STR(a.Codigos, 10), 4) = STR(b.NDopes, 4) " + ;
            "ORDER BY 1, 2, 3"

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_SubniveisTemp", "Subniveis")
            IF USED("cursor_4c_SubniveisTemp")
                SELECT cursor_4c_SubniveisTemp
                SCAN
                    INSERT INTO cursor_4c_Subniveis (Emps, Dopes, Numes) ;
                        VALUES (cursor_4c_SubniveisTemp.Emps, cursor_4c_SubniveisTemp.Dopes, VAL(cursor_4c_SubniveisTemp.Numes))
                ENDSCAN
                USE IN cursor_4c_SubniveisTemp
            ENDIF
            loc_lResultado = .T.
        ENDIF

        IF USED("cursor_4c_Subniveis")
            GO TOP IN cursor_4c_Subniveis
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * AtualizarAuditoria - equivalente ao chkAuditado.Click do legado: grava
    * (UPDATE SigMvHst) auditors/dtaudits do registro corrente - a UNICA
    * escrita real deste form. BEGIN/COMMIT/ROLLBACK TRANSACTION em LOTE
    * unico (os dois UPDATEs na mesma transacao).
    *==========================================================================
    FUNCTION AtualizarAuditoria(par_lMarcarAuditado)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet1, loc_nRet2

        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cCidChavesAtual)
            THIS.this_cMensagemErro = "Nenhum registro selecionado para auditoria."
            RETURN .F.
        ENDIF

        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION", "cursor_4c_Trn")
        IF USED("cursor_4c_Trn")
            USE IN cursor_4c_Trn
        ENDIF

        IF par_lMarcarAuditado
            loc_cSQL = "UPDATE SigMvHst SET auditors = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChavesAtual)
        ELSE
            loc_cSQL = "UPDATE SigMvHst SET auditors = " + EscaparSQL(SPACE(10)) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChavesAtual)
        ENDIF
        loc_nRet1 = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdAud1")
        IF USED("cursor_4c_UpdAud1")
            USE IN cursor_4c_UpdAud1
        ENDIF

        IF par_lMarcarAuditado
            loc_cSQL = "UPDATE SigMvHst SET dtaudits = GETDATE() WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChavesAtual)
        ELSE
            loc_cSQL = "UPDATE SigMvHst SET dtaudits = NULL WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChavesAtual)
        ENDIF
        loc_nRet2 = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdAud2")
        IF USED("cursor_4c_UpdAud2")
            USE IN cursor_4c_UpdAud2
        ENDIF

        IF loc_nRet1 < 0 OR loc_nRet2 < 0
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_Rb")
            IF USED("cursor_4c_Rb")
                USE IN cursor_4c_Rb
            ENDIF
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + CapturarErroSQL()
            loc_lResultado = .F.
        ELSE
            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION", "cursor_4c_Cmt")
            IF USED("cursor_4c_Cmt")
                USE IN cursor_4c_Cmt
            ENDIF

            IF par_lMarcarAuditado
                THIS.this_cAuditorAtual = PADR(gc_4c_UsuarioLogado, 10)
                THIS.this_dDtAuditAtual = DATETIME()
            ELSE
                THIS.this_cAuditorAtual = SPACE(10)
                THIS.this_dDtAuditAtual = {}
            ENDIF

            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                REPLACE cursor_4c_Dados.auditors WITH THIS.this_cAuditorAtual, ;
                        cursor_4c_Dados.dtaudits  WITH THIS.this_dDtAuditAtual
            ENDIF

            THIS.RegistrarAuditoria("UPDATE")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * VerificarDocumentoCadastrado - equivalente a
    * ThisForm.poDataMgr.ChkRegister(tabela, campo, valor) do legado:
    * confirma se existe registro com a chave informada. Usado pelo botao
    * Movimento para decidir entre abrir o documento ja efetivado
    * (SigMvCab) ou a necessidade ainda em aberto (SigCdNec).
    *==========================================================================
    FUNCTION VerificarDocumentoCadastrado(par_cTabela, par_cCampoChave, par_cValorChave)
        LOCAL loc_lResultado, loc_cSQL

        loc_lResultado = .F.

        loc_cSQL = "SELECT COUNT(*) AS Total FROM " + par_cTabela + ;
            " WHERE " + par_cCampoChave + " = " + EscaparSQL(par_cValorChave)

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_VerDoc", "VerificarDocumento")
            IF USED("cursor_4c_VerDoc")
                loc_lResultado = (NVL(cursor_4c_VerDoc.Total, 0) > 0)
                USE IN cursor_4c_VerDoc
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

