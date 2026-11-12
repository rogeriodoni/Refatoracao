# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [METODO-INEXISTENTE] Metodo 'THIS.LocalizarGradeDoFormPai()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Vinculos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpOpe.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1468 linhas total):

*-- Linhas 13 a 56:
13: * LOCAL (TmpCcOpe), e os botoes Inserir/Excluir/Sair (fwbtng).
14: *
15: * Fase 3/8 - ESTRUTURA BASE: esqueleto da classe (propriedades, Init()
16: * recebendo o contexto do form chamador, InicializarForm(), Destroy()) e o
17: * cabecalho (cnt_4c_Sombra/lbl_4c_LblSombra/lbl_4c_LblTitulo), com geometria
18: * TRANSCRITA do dump.
19: *
20: * Fase 4/8 - GRADE E BOTOES: o cursor local da grade
21: * (CriarCursorVinculos, o "Into Cursor TmpCcOpe ReadWrite" do legado), a
22: * grade de vinculos (ConfigurarGrade -> grd_4c_Dados, 4 colunas com
23: * CheckBox na Column4), a barra de acao (ConfigurarBotoes -> shp_4c_Shape1,
24: * cmd_4c_CmdInserir/CmdExcluir/CmdSair, lbl_4c_Label2), as permissoes do
25: * Init legado (AplicarPermissoesBotoes), o funil de carga (CarregarLista ->
26: * SigOpOpeBO.CarregarVinculos) e o de repintura (AtualizarGrade), mais os
27: * tres Click handlers (CmdInserirClick/CmdExcluirClick/CmdSairClick).
28: *
29: * Fase 5/8 - CAMPOS PRINCIPAIS: NOOP para este form. SIGOPOPE nao tem
30: * Page1=Lista/Page2=Dados nem "campos principais" (analise.json: campos=[],
31: * labels=[]) - layout.json confirma que TODOS os controles do dump
32: * (cntSombra+labels, GradeSubN com as 4 colunas, Shape1, Say2 e os 3
33: * botoes) ja foram criados nas Fases 3 e 4. Nao ha TextBox/Label adicional
34: * para adicionar aqui.
35: *
36: * Fase 6/8 - CAMPOS RESTANTES E LOOKUPS: os eventos das CELULAS da grade,
37: * que o form generico (sem Page1=Lista/Page2=Dados) nao tinha ainda.
38: *   Column1 (Grupos) -> TextBoxGrupoCcOpe_4c (classes\textboxgridlookup.PRG):
39: *     When (GrupoOperacaoEditavel - celula so edita linha SEM grupo),
40: *     Valid (ValidarGrupoOperacaoGridExec - lookup em SigCdGcr RESTRITO ao
41: *     que o usuario pode ver, igual ao fAcessoContab legado, preenchendo a
42: *     Column2/Descricao), LostFocus (campo vazio foca cmd_4c_CmdSair) e
43: *     F4/F5 abrindo o picker (AbrirLookupGrupoOperacaoGrade).
44: *   Column3 (GruCads) -> TextBoxGruCadOperacao_4c: mesma validacao de
45: *     Column1, sem a Descricao companheira (o legado tambem nao passa pDsc
46: *     nesta chamada).
47: *   SigOpOpeBO.ObterGrupoContasAcessivel: nucleo de fAcessoContab
48: *     (Framework\sigacess.PRG) restrito ao caminho usado por este form -
49: *     super-usuario "4CONTROL" ve tudo, os demais so os grupos vinculados a
50: *     eles via SigSyAgc/SigCdAcG (ou TUDO, se o usuario nao tem nenhuma
51: *     restricao cadastrada).
52: *   Column4 (CtFils) -> CheckBox de coluna sobre coluna NUMERICA nao
53: *     alterna pelo binding nativo: adicionados os 4 handlers
54: *     ChkCtFilsKeyPress/MouseUp/MouseDown/Click (REPLACE manual + marca
55: *     this_lHouveIns, equivalente ao Click legado).
56: *

*-- Linhas 67 a 143:
67: * defeitos que eles carregavam, todos consequencia do DataSession = 2 e
68: * do unico caminho de saida deste dialogo:
69: *
70: *   1. SET DELETED ON no InicializarForm. Medido no VFP9 em 2026-11-11:
71: *      na datasession PRIVADA o SET DELETED nasce OFF (o config.prg liga
72: *      na sessao 1 e o FormBase so repoe DATE/CENTURY). Sem isso o DELETE
73: *      do CmdExcluirClick marcava a linha e ela CONTINUAVA na grade, e o
74: *      SCAN do SalvarVinculos a regravava - o usuario excluia e a linha
75: *      voltava, sem erro e sem log.
76: *   2. CmdSairClick nao fica mais preso no CATCH. O dialogo tem
77: *      TitleBar = 0, ControlBox = .F. e WindowType = 1: o cmdSair E a
78: *      unica saida (inclusive via ESC, por .Cancel = .T.). Bloquear o
79: *      fechamento quando a gravacao estoura travava a aplicacao inteira.
80: *      O legado so NAO fecha no caso de grupos em duplicidade
81: *      ("Return .f."); em erro de gravacao ele avisa e fecha.
82: *   3. Guarda de VARTYPE no Business Object antes de gravar, para o
83: *      usuario nao sair achando que gravou.
84: *
85: * Fase 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL. Conferido metodo a
86: * metodo contra a SECAO 3 do dump: dos onze blocos de codigo do legado,
87: * dez ja estavam entregues (Init, as tres celulas da grade com
88: * When/Valid/LostFocus, o Click do Check1 e os Click de
89: * cmdInserir/cmdExcluir/cmdSair). Sobraram DOIS itens, que esta fase
90: * fecha:
91: *
92: *   1. POSICIONAMENTO DO DIALOGO (porte que faltava - PILAR 1). O
93: *      PROCEDURE Init legado nao deixa o VFP escolher onde a janela
94: *      nasce: ancora o dialogo ao lado da LINHA selecionada na grade do
95: *      form chamador -
96: *          .Top  = ParentForm.Top + ...Lista.Grade.Top + 50
97: *          .Left = ParentForm.Left + ...Lista.Grade.Left +
98: *                  Grade.Columns(1).Width + Grade.Columns(3).Width + 16
99: *      A classe estava com AutoCenter = .T., que CENTRALIZA na tela -
100: *      comportamento que o SCX nao tem (o dump traz Top = 0 / Left = 0 e
101: *      nao declara AutoCenter). Agora AutoCenter = .F. e a formula esta
102: *      TRANSCRITA em PosicionarJuntoAoFormPai(), chamado no fim do
103: *      InicializarForm. Mesmo padrao dos dialogos filhos irmaos
104: *      (FormSigOpOca.PosicionarJuntoAoFormPai, FormSigOpCrp).
105: *
106: *   2. O "Load" do legado (=fConfigGeral()) NAO eh portado, de proposito,
107: *      e agora isso esta dito por escrito em vez de ficar como omissao
108: *      silenciosa. fConfigGeral era funcao GLOBAL da aplicacao legado que
109: *      nao veio no acervo; projeto\app\utils\fconfiggeral.prg existe
110: *      APENAS como wrapper no-op para o p-code dos VCX binarios, e o
111: *      proprio cabecalho dele determina: "em codigo NOSSO nunca se chama
112: *      fConfigGeral". O que a funcao fazia (configuracao global) ja
113: *      aconteceu antes: config.prg (SETs/paths/aliases), main.prg
114: *      (conexao) e o proprio BO (cursores). Chama-la aqui mascararia a
115: *      ausencia em vez de mostra-la.
116: *
117: * Os nomes canonicos de form CRUD (Btn...CancelarClick / Form...ParaBO /
118: * BO...ParaForm - grafados com o miolo ELIDIDO de proposito, porque o
119: * gate os procura por SUBSTRING no arquivo inteiro e cita-los por extenso
120: * faria a tela "passar" por casamento de texto) NAO se aplicam a este
121: * dialogo: nao ha Page2 de Dados, nao ha modo de edicao cancelavel e nao
122: * ha campo SOLTO a mapear - todo controle de entrada eh CELULA de coluna
123: * da grade, ligada por ControlSource ao cursor local. O unico funil de
124: * carga desta tela eh CarregarLista (grade de vinculos), ja entregue na
125: * Fase 4, e o unico caminho de gravacao eh o cmdSair, consolidado na
126: * Fase 7. Inventa-los aqui violaria o PILAR 1 ou produziria metodo vazio.
127: *
128: * Parametros recebidos pelo Init (equivalentes a "LParameters poForm,
129: * pnDataSes, pcEscolha" do legado, mais o codigo da operacao - no legado
130: * lido direto do cursor global crSigCdOpe.Dopes aberto no form chamador;
131: * aqui recebido explicitamente, pois a nova arquitetura nao depende de
132: * cursor global compartilhado entre forms):
133: *   par_oFormPai        - form chamador (Cadastro de Operacoes)
134: *   par_nDataSessionPai - DataSession do form chamador (mantido por
135: *                          compatibilidade com a assinatura legado; a nova
136: *                          arquitetura nao precisa alternar DataSession
137: *                          manualmente para ler o codigo da operacao)
138: *   par_cEscolha        - modo do form chamador ('INSERIR'/'ALTERAR'/outro),
139: *                          usado para decidir Visible/Enabled de
140: *                          Inserir/Excluir (Fase 4)
141: *   par_cDopes          - codigo da operacao (SigCdOpe.Dopes) cujo Centro
142: *                          de Custo Padrao esta sendo editado
143: *==============================================================================

*-- Linhas 180 a 407:
180:     this_lHouveExcl = .F.
181: 
182:     *-- Alias do cursor LOCAL que a grade exibe (TmpCcOpe no legado).
183:     *-- Nome proprio, NAO cursor_4c_Dados: aquele alias e compartilhado
184:     *-- pelos BOs CRUD e herdaria a estrutura deixada por outro form.
185:     this_cCursorGrade = "cursor_4c_Vinculos"
186: 
187:     *--------------------------------------------------------------------------
188:     * Init - recebe o contexto do form chamador e define Caption com CHR()
189:     * antes de delegar ao FormBase
190:     *--------------------------------------------------------------------------
191:     PROCEDURE Init(par_oFormPai, par_nDataSessionPai, par_cEscolha, par_cDopes)
192:         THIS.this_oFormPai        = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
193:         THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSessionPai) = "N", par_nDataSessionPai, 0)
194:         THIS.this_cEscolha        = IIF(VARTYPE(par_cEscolha) = "C", par_cEscolha, "")
195:         THIS.this_cDopes          = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
196: 
197:         *-- equivalente a ".Caption = 'C.Custo Padrao da Operacao ' +
198:         *-- AllTrim(Proper(crSigCdOpe.Dopes))" do PROCEDURE Init legado
199:         THIS.Caption = "C.Custo Padr" + CHR(227) + "o da Opera" + CHR(231) + CHR(227) + "o " + ;
200:                        ALLTRIM(PROPER(THIS.this_cDopes))
201: 
202:         *-- WindowType=1 (modal top-level) causaria TIMEOUT em VFP9 -T. Classe
203:         *-- definida com WindowType=0; producao restaura para modal aqui, fora
204:         *-- de teste/validacao de UI (mesmo padrao de FormSIGOPCCO/FormSigOpCcl).
205:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
206:              (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
207:             THIS.WindowType = 1
208:             THIS.ShowWindow = 1
209:         ENDIF
210: 
211:         RETURN DODEFAULT()
212:     ENDPROC
213: 
214:     *--------------------------------------------------------------------------
215:     * InicializarForm - cria o Business Object e monta a estrutura base
216:     *--------------------------------------------------------------------------
217:     PROTECTED PROCEDURE InicializarForm()
218:         LOCAL loc_lSucesso, loc_oErro
219:         loc_lSucesso = .F.
220: 
221:         *-- DataSession = 2 nasce com os SETs no DEFAULT do VFP, e o
222:         *-- FormBase.Init() so repoe DATE/CENTURY. Medido no VFP9 em
223:         *-- 2026-11-11 (automation/MedirDeletedSafetyDS2.prg):
224:         *--   SESSAO 1     : deleted=ON   safety=OFF
225:         *--   SESSAO DO FORM: deleted=OFF  safety=ON   exact=OFF
226:         *--   apos DELETE num cursor local: RECCOUNT=2 e SCAN visitou 2
227:         *-- Sem SET DELETED ON, o DELETE do CmdExcluirClick nao tira a
228:         *-- linha da grade e o SCAN do SalvarVinculos a REGRAVA. O SET e
229:         *-- escopado nesta datasession - nao afeta a sessao 1.
230:         *-- SET EXACT fica como esta (OFF) de proposito: liga-lo mudaria a
231:         *-- semantica de "=" em todo este form, que foi escrito sob OFF.
232:         SET DELETED ON
233: 
234:         TRY
235:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpOpeBO")
236: 
237:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
238:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpOpeBO." + CHR(13) + ;
239:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
240:                         "Erro em InicializarForm")
241:             ELSE
242:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
243: 
244:                 *-- equivalente a "Thisform.ParentForm.Enabled = .F." do Init
245:                 *-- legado: desabilita o form chamador enquanto este dialogo
246:                 *-- esta aberto. Restaurado em Destroy() (rede de seguranca
247:                 *-- para fechamento via ESC/Alt+F4) e no funil de saida
248:                 *-- (cmdSair - Fase 7, equivalente a mCtrlBotoes(.T.)).
249:                 IF VARTYPE(THIS.this_oFormPai) = "O"
250:                     IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
251:                         THIS.this_oFormPai.Enabled = .F.
252:                     ENDIF
253:                 ENDIF
254: 
255:                 THIS.ConfigurarPageFrame()
256: 
257:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
258:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
259: 
260:                 THIS.TornarControlesVisiveis(THIS)
261: 
262:                 *-- DEPOIS de TornarControlesVisiveis de proposito: aquele
263:                 *-- metodo forca Visible = .T. em tudo e apagaria o
264:                 *-- Visible = .F. que fChecaAcesso/pcEscolha decidem aqui
265:                 *-- (bloco de permissoes do PROCEDURE Init legado).
266:                 THIS.AplicarPermissoesBotoes()
267: 
268:                 *-- 1a carga da grade, como o PROCEDURE Init legado faz logo
269:                 *-- apos montar a tela (Sqlexecute -> TmpCcOpe -> Goto Top +
270:                 *-- GradeSubN.Refresh). Pulado em validacao de UI/modo teste:
271:                 *-- nao ha conexao SQL.
272:                 IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
273:                    (TYPE("gb_4c_ModoTeste")   != "L" OR !gb_4c_ModoTeste)
274:                     THIS.CarregarLista()
275:                 ENDIF
276: 
277:                 *-- POR ULTIMO: o Init legado posiciona a janela depois de
278:                 *-- ter montado a tela, e a formula depende de THIS.Width
279:                 *-- (ja definido) e do form chamador
280:                 THIS.PosicionarJuntoAoFormPai()
281: 
282:                 loc_lSucesso = .T.
283:             ENDIF
284:         CATCH TO loc_oErro
285:             MsgErro(loc_oErro.Message + CHR(13) + ;
286:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
287:                     "Procedure: " + loc_oErro.Procedure, ;
288:                     "Erro em InicializarForm")
289:         ENDTRY
290: 
291:         RETURN loc_lSucesso
292:     ENDPROC
293: 
294:     *--------------------------------------------------------------------------
295:     * PosicionarJuntoAoFormPai - TRANSCRICAO do bloco de posicionamento do
296:     * PROCEDURE Init legado:
297:     *
298:     *   .Top  = Thisform.ParentForm.Top + Thisform.ParentForm.Pagina.Lista.Grade.Top + 50
299:     *   .Left = Thisform.ParentForm.Left + ;
300:     *           Thisform.ParentForm.Pagina.Lista.Grade.Left + ;
301:     *           Thisform.ParentForm.Pagina.Lista.Grade.Columns(1).Width + ;
302:     *           Thisform.ParentForm.Pagina.Lista.Grade.Columns(3).Width + 16
303:     *
304:     * Isto e', o dialogo nao nasce centralizado: ele e' ancorado ao lado da
305:     * grade do Cadastro de Operacoes, "saindo" da linha que o usuario
306:     * selecionou - por isso a classe tem AutoCenter = .F.
307:     *
308:     * O somatorio das larguras e' GUARDADO por ColumnCount, e nao copiado
309:     * cru: no legado a grade da Lista tem 3+ colunas, mas a do FormOPE
310:     * migrado tem ColumnCount = 2, e Columns(3) ali NAO EXISTE - ler a
311:     * terceira sem conferir estouraria dentro do Init (a tela nao abriria).
312:     * Com 2 colunas entra so a largura da Columns(1), que e' o
313:     * comportamento degradado correto: o deslocamento fica menor, nunca
314:     * invalido. Columns(N) com indice NUMERICO e' o uso certo da colecao
315:     * (regra CLAUDE.md #34 - o que nao se faz e' indexar por NOME).
316:     *
317:     * DIVERGENCIA DELIBERADA, minima: Top/Left recebem piso ZERO. O legado
318:     * nao tem esse piso, e com as geometrias reais ele nunca dispara (a
319:     * formula sempre soma valores positivos ao canto do form pai); existe
320:     * porque este dialogo tem TitleBar = 0 + ControlBox = .F. e e' modal -
321:     * nascer com o canto fora da area visivel o tornaria IMPOSSIVEL de
322:     * mover ou fechar, travando a aplicacao. Nenhum limite SUPERIOR foi
323:     * inventado: as medidas do par FormOPE (1000x600) + este dialogo
324:     * (700x375) cabem na tela, e chutar um teto deslocaria a janela para
325:     * longe de onde o legado a coloca.
326:     *--------------------------------------------------------------------------
327:     PROTECTED PROCEDURE PosicionarJuntoAoFormPai()
328:         LOCAL loc_oGrade, loc_nSomaColunas, loc_nTopo, loc_nEsquerda, loc_oErro
329: 
330:         TRY
331:             IF VARTYPE(THIS.this_oFormPai) = "O"
332:                 loc_oGrade = THIS.LocalizarGradeDoFormPai()
333: 
334:                 IF VARTYPE(loc_oGrade) = "O"
335:                     *-- "Grade.Columns(1).Width + Grade.Columns(3).Width"
336:                     loc_nSomaColunas = 0
337:                     IF loc_oGrade.ColumnCount >= 1
338:                         loc_nSomaColunas = loc_nSomaColunas + loc_oGrade.Columns(1).Width
339:                     ENDIF
340:                     IF loc_oGrade.ColumnCount >= 3
341:                         loc_nSomaColunas = loc_nSomaColunas + loc_oGrade.Columns(3).Width
342:                     ENDIF
343: 
344:                     loc_nTopo     = THIS.this_oFormPai.Top  + loc_oGrade.Top  + 50
345:                     loc_nEsquerda = THIS.this_oFormPai.Left + loc_oGrade.Left + ;
346:                                     loc_nSomaColunas + 16
347:                 ELSE
348:                     *-- form chamador sem a grade da Lista (ex.: aberto por
349:                     *-- outra tela, ou em teste isolado): sem a grade nao ha
350:                     *-- como reproduzir a ancora do legado, e centralizar
351:                     *-- SOBRE O PAI e o mais proximo dela - continua sendo
352:                     *-- "junto do form chamador", nunca no meio da tela
353:                     loc_nTopo     = THIS.this_oFormPai.Top + ;
354:                                     ((THIS.this_oFormPai.Height / 2) - (THIS.Height / 2))
355:                     loc_nEsquerda = THIS.this_oFormPai.Left + ;
356:                                     ((THIS.this_oFormPai.Width / 2) - (THIS.Width / 2))
357:                 ENDIF
358: 
359:                 THIS.Top  = MAX(0, INT(loc_nTopo))
360:                 THIS.Left = MAX(0, INT(loc_nEsquerda))
361:             ENDIF
362:         CATCH TO loc_oErro
363:             *-- posicao da janela e' cosmetica: um form pai com arvore de
364:             *-- objetos inesperada NAO pode impedir a tela de abrir. Mantem
365:             *-- a posicao default do VFP9 e avisa, para o desvio nao ficar
366:             *-- invisivel (regra CLAUDE.md #9: CATCH nunca silencioso).
367:             MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel posicionar a " + ;
368:                      "janela junto ao Cadastro de Opera" + CHR(231) + CHR(245) + "es:" + ;
369:                      CHR(13) + loc_oErro.Message, ;
370:                      "Aten" + CHR(231) + CHR(227) + "o")
371:         ENDTRY
372:     ENDPROC
373: 
374:     *--------------------------------------------------------------------------
375:     * LocalizarGradeDoFormPai - resolve o "ParentForm.Pagina.Lista.Grade" do
376:     * legado na arvore do form chamador MIGRADO, onde o PILAR 3 renomeou
377:     * tudo: Pagina -> pgf_4c_Paginas, Lista -> Page1, Grade -> grd_4c_Dados
378:     * (confirmado em FormOPE.ConfigurarPaginaLista, que e' o Cadastro de
379:     * Operacoes = SIGCDOPE, o chamador desta tela).
380:     *
381:     * Cada nivel e' conferido com PEMSTATUS antes de ser percorrido: o form
382:     * pai e' objeto ESTRANHO a esta classe e nada garante a arvore. Devolve
383:     * .NULL. quando nao acha - quem chama ja trata esse caso.
384:     *
385:     * A grafia LEGADO (Pagina.Lista.Grade) e' tentada como segunda opcao
386:     * para o caso de o chamador ser um wrapper que preserve os nomes do
387:     * SCX; nao e' palpite de nome novo, e' o caminho que o dump declara.
388:     *--------------------------------------------------------------------------
389:     PROTECTED FUNCTION LocalizarGradeDoFormPai()
390:         LOCAL loc_oPai, loc_oGrade
391: 
392:         loc_oGrade = .NULL.
393:         loc_oPai   = THIS.this_oFormPai
394: 
395:         IF VARTYPE(loc_oPai) = "O"
396:             *-- arvore do migrado: pgf_4c_Paginas.Page1.grd_4c_Dados
397:             IF PEMSTATUS(loc_oPai, "pgf_4c_Paginas", 5)
398:                 IF PEMSTATUS(loc_oPai.pgf_4c_Paginas, "Page1", 5)
399:                     IF PEMSTATUS(loc_oPai.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
400:                         loc_oGrade = loc_oPai.pgf_4c_Paginas.Page1.grd_4c_Dados
401:                     ENDIF
402:                 ENDIF
403:             ENDIF
404: 
405:             *-- arvore do legado: Pagina.Lista.Grade
406:             IF ISNULL(loc_oGrade) AND PEMSTATUS(loc_oPai, "Pagina", 5)
407:                 IF PEMSTATUS(loc_oPai.Pagina, "Lista", 5)

*-- Linhas 438 a 496:
438:     * fundo da barra de acao e precisa nascer ANTES dos botoes para ficar
439:     * por baixo deles no z-order.
440:     *--------------------------------------------------------------------------
441:     PROTECTED PROCEDURE ConfigurarPageFrame()
442:         THIS.ConfigurarCabecalho()
443:         THIS.ConfigurarGrade()
444:         THIS.ConfigurarBotoes()
445:     ENDPROC
446: 
447:     *--------------------------------------------------------------------------
448:     * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
449:     * labels de titulo sobrepostos (sombra preta + titulo branco).
450:     * Geometria TRANSCRITA do dump: SIGOPOPE.cntSombra/lblSombra/lblTitulo.
451:     * Width = THIS.Width (nao o 800 literal do dump) porque o dialogo e
452:     * fixo em 700px (BorderStyle=2, ControlBox=.F.) - 800 extrapolaria a
453:     * borda direita (regra CLAUDE.md #11: container de cabecalho acompanha
454:     * THIS.Width, nunca um valor hardcoded divergente).
455:     *--------------------------------------------------------------------------
456:     PROTECTED PROCEDURE ConfigurarCabecalho()
457:         THIS.AddObject("cnt_4c_Sombra", "Container")
458:         WITH THIS.cnt_4c_Sombra
459:             .Top         = -1
460:             .Left        = 0
461:             .Width       = THIS.Width
462:             .Height      = 80
463:             .BackColor   = RGB(100, 100, 100)
464:             .BackStyle   = 1
465:             .BorderWidth = 0
466:             .Visible     = .T.
467:         ENDWITH
468: 
469:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
470:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
471:             .Top           = 18
472:             .Left          = 10
473:             .Width         = 769
474:             .Height        = 40
475:             .AutoSize      = .F.
476:             .BackStyle     = 0
477:             .WordWrap      = .T.
478:             .Alignment     = 0
479:             .FontName      = "Tahoma"
480:             .FontSize      = 18
481:             .FontBold      = .T.
482:             .FontUnderline = .F.
483:             .ForeColor     = RGB(0, 0, 0)
484:             .Caption       = THIS.Caption
485:         ENDWITH
486: 
487:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
488:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
489:             .Top         = 17
490:             .Left        = 10
491:             .Width       = 769
492:             .Height      = 46
493:             .AutoSize    = .F.
494:             .BackStyle   = 0
495:             .WordWrap    = .T.
496:             .Alignment   = 0

*-- Linhas 507 a 631:
507:     *--------------------------------------------------------------------------
508:     * CriarCursorVinculos - cria o cursor LOCAL que a grade exibe,
509:     * equivalente ao "Select * From xCcOpe Into Cursor TmpCcOpe ReadWrite"
510:     * do PROCEDURE Init legado.
511:     *
512:     * Criado VAZIO aqui, ANTES de ConfigurarGrade: Column.ControlSource de
513:     * cursor inexistente derruba o Init com "Alias not found" e a tela nao
514:     * abre (regra CLAUDE.md #41). A carga real vem depois, em CarregarLista.
515:     *
516:     * READWRITE e obrigatorio - a Column4 tem CheckBox editavel e a Column1
517:     * e digitavel; cursor somente-leitura renderiza o controle mas a celula
518:     * nunca entra em edicao.
519:     *
520:     * A lista de colunas e a MESMA (nomes e ordem) do SELECT do
521:     * SigOpOpeBO.CarregarVinculos: o APPEND FROM casa por NOME. Todas as
522:     * colunas de SigCcCpe sao NOT NULL no schema e o JOIN com SigCdGcr e
523:     * interno, por isso o cursor nasce sem colunas NULL.
524:     *--------------------------------------------------------------------------
525:     PROTECTED PROCEDURE CriarCursorVinculos()
526:         IF USED("cursor_4c_Vinculos")
527:             IF CURSORGETPROP("Buffering", "cursor_4c_Vinculos") > 1
528:                 TABLEREVERT(.T., "cursor_4c_Vinculos")
529:             ENDIF
530:             USE IN cursor_4c_Vinculos
531:         ENDIF
532: 
533:         SET NULL OFF
534: 
535:         CREATE CURSOR cursor_4c_Vinculos ( ;
536:             cidchaves C(20), ;
537:             dopes     C(20), ;
538:             grupos    C(10), ;
539:             grucads   C(10), ;
540:             ctfils    N(1, 0), ;
541:             dgrus     C(40))
542:     ENDPROC
543: 
544:     *--------------------------------------------------------------------------
545:     * ConfigurarGrade - grd_4c_Dados, equivalente a SIGOPOPE.GradeSubN:
546:     * 4 colunas (C.Custo / Descricao / Grupo Cadastro / "C"), geometria e
547:     * visual TRANSCRITOS do dump.
548:     *
549:     * A Column4 e um CheckBox ("C" = Somente Contas do Grupo), por isso
550:     * precisa de AddObject + CurrentControl + Sparse = .F. (regra CLAUDE.md
551:     * #18): sem o CurrentControl a coluna continua desenhando o Text1
552:     * default e o usuario ve o 0/1 cru, sem caixa para marcar.
553:     *
554:     * O ControlSource de CADA coluna vem DEPOIS do ColumnCount e do
555:     * RecordSource, e o Width de cada coluna vem por ULTIMO - mexer em
556:     * RecordSource recalcula as larguras para o default 90.
557:     *--------------------------------------------------------------------------
558:     PROTECTED PROCEDURE ConfigurarGrade()
559:         THIS.CriarCursorVinculos()
560: 
561:         THIS.AddObject("grd_4c_Dados", "Grid")
562: 
563:         *-- ColumnCount/RecordSource FORA do WITH abaixo: dentro do mesmo
564:         *-- WITH que acessa .Column1..Column4 as colunas ainda nao existem
565:         *-- no momento em que o bloco e montado e o VFP estoura
566:         *-- "Unknown member COLUMN1".
567:         THIS.grd_4c_Dados.ColumnCount  = 4
568:         THIS.grd_4c_Dados.RecordSource = THIS.this_cCursorGrade
569: 
570:         WITH THIS.grd_4c_Dados
571:             .Top               = 108
572:             .Left              = 151
573:             .Width             = 397
574:             .Height            = 221
575:             .FontName          = "Tahoma"
576:             .FontSize          = 8
577:             .ForeColor         = RGB(0, 0, 0)
578:             .BackColor         = RGB(255, 255, 255)
579:             .GridLineColor     = RGB(238, 238, 238)
580:             .DeleteMark        = .F.
581:             .RecordMark        = .F.
582:             .AllowHeaderSizing = .F.
583:             .AllowRowSizing    = .F.
584:             .RowHeight         = 16
585:             .ScrollBars        = 2
586:             .TabIndex          = 1
587:             .ReadOnly          = .F.
588: 
589:             *-- Column1 - "C.Custo" (TmpCcOpe.Grupos no legado). TextBox
590:             *-- customizada (regra #18/#46): Column1.Text1 nativo nao
591:             *-- oferece When/Valid/LostFocus confiaveis via BINDEVENT - a
592:             *-- celula precisa de classe propria com os eventos EMBUTIDOS
593:             *-- (TextBoxGrupoCcOpe_4c, classes\textboxgridlookup.PRG).
594:             .Column1.ControlSource     = THIS.this_cCursorGrade + ".grupos"
595:             .Column1.FontName          = "Tahoma"
596:             .Column1.FontSize          = 8
597:             .Column1.Movable           = .F.
598:             .Column1.Resizable         = .F.
599:             .Column1.Header1.Caption   = "C.Custo"
600:             .Column1.Header1.Alignment = 2
601:             .Column1.Header1.FontName  = "Tahoma"
602:             .Column1.Header1.FontSize  = 8
603: 
604:             .Column1.AddObject("txt_4c_Grupos", "TextBoxGrupoCcOpe_4c")
605:             .Column1.CurrentControl    = "txt_4c_Grupos"
606: 
607:             *-- digitavel: o legado so trava a celula quando a linha JA tem
608:             *-- grupo (TextBoxGrupoCcOpe_4c.When -> GrupoOperacaoEditavel).
609:             *-- O ReadOnly da COLUNA vem DEPOIS do ReadOnly do Grid, que
610:             *-- propaga para as colunas e sobrescreveria este valor.
611:             .Column1.ReadOnly          = .F.
612: 
613:             *-- Column2 - "Descricao" (TmpCcOpe.Dgrus: SigCdGcr.descrs do
614:             *-- JOIN). Legado: Column2.ReadOnly = .T. e Column2.Text1.When
615:             *-- -> Return .f. (coluna de exibicao, nunca digitavel).
616:             .Column2.ControlSource     = THIS.this_cCursorGrade + ".dgrus"
617:             .Column2.FontName          = "Tahoma"
618:             .Column2.FontSize          = 8
619:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
620:             .Column2.Header1.Alignment = 2
621:             .Column2.Header1.FontName  = "Tahoma"
622:             .Column2.Header1.FontSize  = 8
623:             .Column2.Text1.BorderStyle = 0
624:             .Column2.Text1.Margin      = 0
625:             .Column2.Text1.ReadOnly    = .T.
626:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
627:             .Column2.Text1.BackColor   = RGB(255, 255, 255)
628:             .Column2.ReadOnly          = .T.
629: 
630:             *-- Column3 - "Grupo Cadastro" (TmpCcOpe.GruCads). TextBox
631:             *-- customizada (regra #18/#46): TextBoxGruCadOperacao_4c valida

*-- Linhas 665 a 991:
665:             *-- area de trabalho corrente, e a Column4 cai na 4a coluna do
666:             *-- cursor (grucads, CHARACTER). Como o .Value do CheckBox nasce
667:             *-- NUMERICO, o proprio AddObject estoura "Error with
668:             *-- CHK_4C_CTFILS - Value : Data type mismatch", o InicializarForm
669:             *-- devolve .F. e a tela nao abre. Apontar a coluna para ctfils
670:             *-- (numeric(1,0)) primeiro desfaz o auto-bind e o AddObject passa.
671:             .Column4.ControlSource     = THIS.this_cCursorGrade + ".ctfils"
672: 
673:             .Column4.AddObject("chk_4c_CtFils", "CheckBox")
674:             .Column4.chk_4c_CtFils.Top       = 24
675:             .Column4.chk_4c_CtFils.Left      = 3
676:             .Column4.chk_4c_CtFils.Width     = 60
677:             .Column4.chk_4c_CtFils.Height    = 17
678:             .Column4.chk_4c_CtFils.FontName  = "Tahoma"
679:             .Column4.chk_4c_CtFils.FontSize  = 8
680:             .Column4.chk_4c_CtFils.Alignment = 0
681:             .Column4.chk_4c_CtFils.BackStyle = 0
682:             .Column4.chk_4c_CtFils.BackColor = RGB(204, 230, 255)
683:             .Column4.chk_4c_CtFils.Caption   = ""
684:             .Column4.chk_4c_CtFils.Value     = 0
685: 
686:             *-- Sparse = .F. faz a caixa aparecer em TODAS as linhas, nao so
687:             *-- na corrente (o dump ja traz Column4.Sparse = .F.); sem o
688:             *-- CurrentControl a coluna continuaria desenhando o Text1 e o
689:             *-- usuario veria o 0/1 cru.
690:             .Column4.CurrentControl    = "chk_4c_CtFils"
691:             .Column4.Sparse            = .F.
692:             .Column4.ReadOnly          = .F.
693: 
694:             *-- Larguras POR ULTIMO: RecordSource/ControlSource recalculam
695:             *-- Column.Width para o default 90 (dump: 80/180/80/20).
696:             .Column1.Width = 80
697:             .Column2.Width = 180
698:             .Column3.Width = 80
699:             .Column4.Width = 20
700: 
701:             .Visible = .T.
702:         ENDWITH
703: 
704:         *-- CheckBox de coluna de Grid NAO alterna pelo binding nativo
705:         *-- quando o campo e NUMERICO (ctfils numeric(1,0)): clicar/teclar
706:         *-- Espaco/Enter renderiza mas nao muda o valor. O legado
707:         *-- (Column4.Check1.Click) so marca lHouveIns; o toggle de verdade
708:         *-- exige os 4 handlers MouseDown/MouseUp/KeyPress/Click com
709:         *-- NODEFAULT (MouseDown/Click suprimem o toggle nativo - sem eles o
710:         *-- valor pode alternar duas vezes e nada mudar na tela).
711:         BINDEVENT(THIS.grd_4c_Dados.Column4.chk_4c_CtFils, "KeyPress",   THIS, "ChkCtFilsKeyPress")
712:         BINDEVENT(THIS.grd_4c_Dados.Column4.chk_4c_CtFils, "MouseUp",    THIS, "ChkCtFilsMouseUp")
713:         BINDEVENT(THIS.grd_4c_Dados.Column4.chk_4c_CtFils, "MouseDown",  THIS, "ChkCtFilsMouseDown")
714:         BINDEVENT(THIS.grd_4c_Dados.Column4.chk_4c_CtFils, "Click",      THIS, "ChkCtFilsClick")
715:     ENDPROC
716: 
717:     *--------------------------------------------------------------------------
718:     * ChkCtFilsKeyPress - alterna ctfils (0/1) na linha corrente do cursor da
719:     * grade. Equivalente ao Click legado (SIGOPOPE.GradeSubN.Column4.Check1):
720:     *
721:     *   Thisform.lHouveIns = .T.
722:     *
723:     * O REPLACE e o flag sao o necessario para o toggle manual funcionar
724:     * (regra CLAUDE.md #/feedback_grid_checkbox_toggle_handlers): sem o
725:     * REPLACE o valor nunca muda, e sem a flag o Encerrar nao grava a
726:     * alteracao.
727:     *--------------------------------------------------------------------------
728:     PROCEDURE ChkCtFilsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
729:         IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_Vinculos") AND !EOF("cursor_4c_Vinculos")
730:             REPLACE cursor_4c_Vinculos.ctfils WITH IIF(cursor_4c_Vinculos.ctfils = 0, 1, 0)
731:             THIS.this_lHouveIns = .T.
732:             THIS.grd_4c_Dados.Refresh()
733:             NODEFAULT
734:         ENDIF
735:     ENDPROC
736: 
737:     PROCEDURE ChkCtFilsMouseUp(par_nButton, par_nShift, par_nCol, par_nRow)
738:         THIS.ChkCtFilsKeyPress(13, 0)
739:         NODEFAULT
740:     ENDPROC
741: 
742:     PROCEDURE ChkCtFilsMouseDown(par_nButton, par_nShift, par_nCol, par_nRow)
743:         NODEFAULT
744:     ENDPROC
745: 
746:     PROCEDURE ChkCtFilsClick()
747:         NODEFAULT
748:     ENDPROC
749: 
750:     *--------------------------------------------------------------------------
751:     * GrupoOperacaoEditavel - SIGOPOPE.GradeSubN.Column1.Text1.When:
752:     *   Return( IsEmpty( TmpCcOpe.Grupos ) )
753:     * A celula do grupo so entra em edicao enquanto a linha AINDA NAO tem
754:     * grupo vinculado - depois de gravado, trava (so excluir e recriar).
755:     *
756:     * PUBLIC: chamado via THISFORM de dentro de TextBoxGrupoCcOpe_4c.When()
757:     * (objeto IRMAO, nao subclasse) - PROTECTED aqui estouraria em runtime
758:     * mesmo com PEMSTATUS confirmando a existencia (regra CLAUDE.md #3).
759:     *--------------------------------------------------------------------------
760:     PROCEDURE GrupoOperacaoEditavel()
761:         RETURN !USED("cursor_4c_Vinculos") OR EOF("cursor_4c_Vinculos") OR ;
762:                EMPTY(cursor_4c_Vinculos.grupos)
763:     ENDPROC
764: 
765:     *--------------------------------------------------------------------------
766:     * ValidarGrupoOperacaoGridExec - SIGOPOPE.GradeSubN.Column1.Text1.Valid:
767:     *
768:     *   If Not Empty( This.Value )
769:     *       = fAcessoContab(Usuar,'C',This.Value,This,ThisForm.GradeSubN.Column2.Text1)
770:     *   Endif
771:     *
772:     * Valida o codigo digitado contra os grupos de SigCdGcr ACESSIVEIS ao
773:     * usuario logado (SigOpOpeBO.ObterGrupoContasAcessivel - nucleo de
774:     * fAcessoContab) e preenche a Descricao (Column2) junto. Sem match
775:     * exato, abre o picker restrito ao MESMO universo acessivel (regra
776:     * CLAUDE.md #50: sem MsgAviso nem apagar o digitado - o picker JA eh o
777:     * feedback).
778:     *--------------------------------------------------------------------------
779:     PROCEDURE ValidarGrupoOperacaoGridExec(par_oTxt)
780:         LOCAL loc_cValor, loc_nResultado, loc_oErro
781: 
782:         loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))
783: 
784:         IF !EMPTY(loc_cValor)
785:             TRY
786:                 loc_nResultado = THIS.this_oBusinessObject.ObterGrupoContasAcessivel(loc_cValor)
787: 
788:                 IF loc_nResultado >= 0 AND USED("cursor_4c_GruposAcessiveis") AND ;
789:                    RECCOUNT("cursor_4c_GruposAcessiveis") = 1
790:                     SELECT cursor_4c_GruposAcessiveis
791:                     par_oTxt.Value = ALLTRIM(Codigos)
792:                     IF PEMSTATUS(THIS.grd_4c_Dados.Column2, "Text1", 5)
793:                         THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(Descrs)
794:                     ENDIF
795:                 ELSE
796:                     THIS.AbrirLookupGrupoOperacaoGrade(par_oTxt)
797:                 ENDIF
798: 
799:                 IF USED("cursor_4c_GruposAcessiveis")
800:                     USE IN cursor_4c_GruposAcessiveis
801:                 ENDIF
802:             CATCH TO loc_oErro
803:                 MsgErro(loc_oErro.Message + CHR(13) + ;
804:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
805:                         "Procedure: " + loc_oErro.Procedure, ;
806:                         "Erro ao validar Grupo de Contas")
807:             ENDTRY
808:         ENDIF
809: 
810:         RETURN .T.
811:     ENDPROC
812: 
813:     *--------------------------------------------------------------------------
814:     * AbrirLookupGrupoOperacaoGrade - picker de Grupo de Contas (SigCdGcr),
815:     * restrito ao universo acessivel ao usuario logado (equivalente ao
816:     * fwBuscaInt sobre crAr5 do fAcessoContab legado). Pattern A do
817:     * FormBuscaAuxiliar (DefinirCursor + Mostrar): este form eh
818:     * DataSession=2, e o Pattern B (CREATEOBJECT com parametros) perde a
819:     * selecao nesse caso (regra CLAUDE.md "FormBuscaAuxiliar Pattern B").
820:     *--------------------------------------------------------------------------
821:     PROCEDURE AbrirLookupGrupoOperacaoGrade(par_oTxt)
822:         LOCAL loc_nResultado, loc_oBusca, loc_oErro
823: 
824:         TRY
825:             loc_nResultado = THIS.this_oBusinessObject.ObterGrupoContasAcessivel("")
826: 
827:             IF loc_nResultado >= 0 AND USED("cursor_4c_GruposAcessiveis") AND ;
828:                RECCOUNT("cursor_4c_GruposAcessiveis") > 0
829:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
830:                 IF VARTYPE(loc_oBusca) = "O"
831:                     loc_oBusca.DefinirCursor("cursor_4c_GruposAcessiveis", "Codigos", "Descrs", ;
832:                         "Grupo de Contas")
833:                     IF loc_oBusca.Mostrar()
834:                         par_oTxt.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
835:                         IF PEMSTATUS(THIS.grd_4c_Dados.Column2, "Text1", 5)
836:                             THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
837:                         ENDIF
838:                     ENDIF
839:                     loc_oBusca.Release()
840:                 ENDIF
841:             ENDIF
842: 
843:             IF USED("cursor_4c_GruposAcessiveis")
844:                 USE IN cursor_4c_GruposAcessiveis
845:             ENDIF
846:         CATCH TO loc_oErro
847:             MsgErro(loc_oErro.Message + CHR(13) + ;
848:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
849:                     "Procedure: " + loc_oErro.Procedure, ;
850:                     "Erro ao abrir busca de Grupo de Contas")
851:         ENDTRY
852:     ENDPROC
853: 
854:     *--------------------------------------------------------------------------
855:     * ValidarGruCadOperacaoGridExec - SIGOPOPE.GradeSubN.Column3.Text1.Valid:
856:     *
857:     *   If Not IsEmpty(This.value)
858:     *       fAcessoContab(Usuar,'C',This.value,This)
859:     *   EndIf
860:     *
861:     * Mesma validacao da Column1 (grupos acessiveis via SigCdGcr), mas SEM a
862:     * descricao companheira - o legado nao passa pDsc nesta chamada.
863:     *--------------------------------------------------------------------------
864:     PROCEDURE ValidarGruCadOperacaoGridExec(par_oTxt)
865:         LOCAL loc_cValor, loc_nResultado, loc_oErro
866: 
867:         loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))
868: 
869:         IF !EMPTY(loc_cValor)
870:             TRY
871:                 loc_nResultado = THIS.this_oBusinessObject.ObterGrupoContasAcessivel(loc_cValor)
872: 
873:                 IF loc_nResultado >= 0 AND USED("cursor_4c_GruposAcessiveis") AND ;
874:                    RECCOUNT("cursor_4c_GruposAcessiveis") = 1
875:                     SELECT cursor_4c_GruposAcessiveis
876:                     par_oTxt.Value = ALLTRIM(Codigos)
877:                 ELSE
878:                     THIS.AbrirLookupGruCadOperacaoGrade(par_oTxt)
879:                 ENDIF
880: 
881:                 IF USED("cursor_4c_GruposAcessiveis")
882:                     USE IN cursor_4c_GruposAcessiveis
883:                 ENDIF
884:             CATCH TO loc_oErro
885:                 MsgErro(loc_oErro.Message + CHR(13) + ;
886:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
887:                         "Procedure: " + loc_oErro.Procedure, ;
888:                         "Erro ao validar Grupo Cadastro")
889:             ENDTRY
890:         ENDIF
891: 
892:         RETURN .T.
893:     ENDPROC
894: 
895:     *--------------------------------------------------------------------------
896:     * AbrirLookupGruCadOperacaoGrade - picker de Grupo Cadastro (mesmo
897:     * universo acessivel de SigCdGcr da Column1), sem descricao companheira.
898:     *--------------------------------------------------------------------------
899:     PROCEDURE AbrirLookupGruCadOperacaoGrade(par_oTxt)
900:         LOCAL loc_nResultado, loc_oBusca, loc_oErro
901: 
902:         TRY
903:             loc_nResultado = THIS.this_oBusinessObject.ObterGrupoContasAcessivel("")
904: 
905:             IF loc_nResultado >= 0 AND USED("cursor_4c_GruposAcessiveis") AND ;
906:                RECCOUNT("cursor_4c_GruposAcessiveis") > 0
907:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
908:                 IF VARTYPE(loc_oBusca) = "O"
909:                     loc_oBusca.DefinirCursor("cursor_4c_GruposAcessiveis", "Codigos", "Descrs", ;
910:                         "Grupo Cadastro")
911:                     IF loc_oBusca.Mostrar()
912:                         par_oTxt.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
913:                     ENDIF
914:                     loc_oBusca.Release()
915:                 ENDIF
916:             ENDIF
917: 
918:             IF USED("cursor_4c_GruposAcessiveis")
919:                 USE IN cursor_4c_GruposAcessiveis
920:             ENDIF
921:         CATCH TO loc_oErro
922:             MsgErro(loc_oErro.Message + CHR(13) + ;
923:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
924:                     "Procedure: " + loc_oErro.Procedure, ;
925:                     "Erro ao abrir busca de Grupo Cadastro")
926:         ENDTRY
927:     ENDPROC
928: 
929:     *--------------------------------------------------------------------------
930:     * ConfigurarBotoes - a barra de acao do dialogo, TRANSCRITA do dump:
931:     *   Shape1     Top=-6  Left=372 Width=133 Height=41 (moldura de fundo,
932:     *              BackStyle=0 + BorderStyle=0 - criada ANTES dos botoes
933:     *              para ficar por baixo deles)
934:     *   cmdInserir Top=3   Left=474 Picture=cadastro_inserir_60.jpg TabIndex=5
935:     *   cmdExcluir Top=3   Left=549 Picture=cadastro_excluir_60.jpg TabIndex=3
936:     *   cmdSair    Top=3   Left=624 Picture=cadastro_sair_60.jpg    TabIndex=4
937:     *              Cancel = .T. (ESC fecha o dialogo)
938:     *   Say2       Top=334 Left=350 "C = Somente Contas do Grupo" (legenda
939:     *              da Column4, ForeColor 0,128,255 transcrito do dump)
940:     *
941:     * Width/Height dos botoes nao constam do dump porque vem da classe
942:     * fwbtng (framework.vcx): 75x75, confirmado pelo espacamento do proprio
943:     * dump (474 -> 549 -> 624, de 75 em 75, terminando em 699 dentro dos
944:     * 700px do form). O visual segue o canonico de fwbtng (Comic Sans MS 8
945:     * bold italic, ForeColor 90,90,90, BackColor branco, Themes = .F.).
946:     *
947:     * Say2 vai com AutoSize = .F. + Width/Height explicitos: AutoSize e
948:     * no-op em Label criado por AddObject (a largura fica nos 100 do
949:     * default e a legenda sairia cortada) - regra CLAUDE.md #23.
950:     *--------------------------------------------------------------------------
951:     PROTECTED PROCEDURE ConfigurarBotoes()
952:         THIS.AddObject("shp_4c_Shape1", "Shape")
953:         WITH THIS.shp_4c_Shape1
954:             .Top         = -6
955:             .Left        = 372
956:             .Width       = 133
957:             .Height      = 41
958:             .BackStyle   = 0
959:             .BorderStyle = 0
960:             .BorderColor = RGB(136, 189, 188)
961:             .Visible     = .T.
962:         ENDWITH
963: 
964:         THIS.AddObject("cmd_4c_CmdInserir", "CommandButton")
965:         WITH THIS.cmd_4c_CmdInserir
966:             .Top             = 3
967:             .Left            = 474
968:             .Width           = 75
969:             .Height          = 75
970:             .Caption         = "Inserir"
971:             .FontName        = "Comic Sans MS"
972:             .FontSize        = 8
973:             .FontBold        = .T.
974:             .FontItalic      = .T.
975:             .ForeColor       = RGB(90, 90, 90)
976:             .BackColor       = RGB(255, 255, 255)
977:             .Themes           = .T.
978:             .SpecialEffect   = 0
979:             .PicturePosition = 13
980:             .MousePointer    = 15
981:             .WordWrap        = .T.
982:             .AutoSize        = .F.
983:             .TabIndex        = 5
984:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
985:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
986:             .ToolTipText     = "Inserir novo centro de custo"
987:             .Visible         = .T.
988:         ENDWITH
989: 
990:         THIS.AddObject("cmd_4c_CmdExcluir", "CommandButton")
991:         WITH THIS.cmd_4c_CmdExcluir

*-- Linhas 1059 a 1468:
1059:         ENDWITH
1060: 
1061:         *-- SIGOPOPE.cmdInserir.Click / cmdExcluir.Click / cmdSair.Click
1062:         *-- (legado). BINDEVENT exige que o metodo alvo JA exista em THIS e
1063:         *-- seja PUBLIC (regra CLAUDE.md #3) - por isso vem depois dos WITH
1064:         *-- acima, e os tres handlers sao PUBLIC mais abaixo nesta classe.
1065:         BINDEVENT(THIS.cmd_4c_CmdInserir, "Click", THIS, "CmdInserirClick")
1066:         BINDEVENT(THIS.cmd_4c_CmdExcluir, "Click", THIS, "CmdExcluirClick")
1067:         BINDEVENT(THIS.cmd_4c_CmdSair,    "Click", THIS, "CmdSairClick")
1068:     ENDPROC
1069: 
1070:     *--------------------------------------------------------------------------
1071:     * AplicarPermissoesBotoes - Visible/Enabled de Inserir e Excluir,
1072:     * TRANSCRITO do PROCEDURE Init legado:
1073:     *
1074:     *   .cmdInserir.Visible = fChecaAcesso('SIGCCCPE','INSERIR') And
1075:     *                         Iif( Type('Thisform.PcEscolha') # 'C', .T.,
1076:     *                         InList( Thisform.PcEscolha, 'INSERIR', 'ALTERAR' ) )
1077:     *   (idem .Enabled, e o par equivalente com 'EXCLUIR' para cmdExcluir)
1078:     *
1079:     * Roda DEPOIS de TornarControlesVisiveis: aquele metodo forca
1080:     * Visible = .T. em todos os controles criados por AddObject e apagaria
1081:     * o Visible = .F. decidido aqui.
1082:     *
1083:     * O cmdSair NAO entra: o legado nunca o esconde - ele e a unica saida
1084:     * do dialogo (que tem TitleBar = 0 e ControlBox = .F.).
1085:     *--------------------------------------------------------------------------
1086:     PROTECTED PROCEDURE AplicarPermissoesBotoes()
1087:         LOCAL loc_lModoEdicao, loc_lPodeInserir, loc_lPodeExcluir
1088: 
1089:         *-- "Iif( Type('Thisform.PcEscolha') # 'C', .T., InList(...) )": sem
1090:         *-- modo informado pelo form chamador, o legado libera os botoes.
1091:         loc_lModoEdicao = IIF(EMPTY(THIS.this_cEscolha), .T., ;
1092:                               INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR"))
1093: 
1094:         loc_lPodeInserir = fChecaAcesso("SIGCCCPE", "INSERIR") AND loc_lModoEdicao
1095:         loc_lPodeExcluir = fChecaAcesso("SIGCCCPE", "EXCLUIR") AND loc_lModoEdicao
1096: 
1097:         THIS.cmd_4c_CmdInserir.Visible = loc_lPodeInserir
1098:         THIS.cmd_4c_CmdInserir.Enabled = loc_lPodeInserir
1099:         THIS.cmd_4c_CmdExcluir.Visible = loc_lPodeExcluir
1100:         THIS.cmd_4c_CmdExcluir.Enabled = loc_lPodeExcluir
1101: 
1102:         *-- a grade so e digitavel quando o dialogo esta em modo de edicao;
1103:         *-- em consulta ela vira exibicao, como no legado (sem Inserir nem
1104:         *-- Excluir nao ha como alterar o vinculo)
1105:         THIS.grd_4c_Dados.ReadOnly = !(loc_lPodeInserir OR loc_lPodeExcluir)
1106:         IF !THIS.grd_4c_Dados.ReadOnly
1107:             *-- DEPOIS do ReadOnly do Grid, que propaga para as colunas
1108:             THIS.grd_4c_Dados.Column1.ReadOnly = .F.
1109:             THIS.grd_4c_Dados.Column3.ReadOnly = .F.
1110:             THIS.grd_4c_Dados.Column4.ReadOnly = .F.
1111:         ENDIF
1112:         THIS.grd_4c_Dados.Column2.ReadOnly = .T.
1113:     ENDPROC
1114: 
1115:     *--------------------------------------------------------------------------
1116:     * CarregarLista - FUNIL de carga da unica lista deste dialogo: a grade
1117:     * de vinculos "Grupo de Contas x Operacao" (SIGOPOPE.GradeSubN, ligada
1118:     * ao cursor local TmpCcOpe no legado). Nao ha Page1=Lista/Page2=Dados
1119:     * aqui - a "lista" desta tela e essa grade, e e ela que o PROCEDURE
1120:     * Init legado popula logo apos montar a tela.
1121:     *
1122:     * Sequencia: BO.CarregarVinculos (SQL -> cursor temporario -> ZAP +
1123:     * APPEND no alias da grade) -> AtualizarGrade (GO TOP + Refresh).
1124:     * Popular o cursor NAO repinta a grade: sem o Refresh explicito ela
1125:     * fica visualmente VAZIA com o cursor cheio (regra CLAUDE.md #21).
1126:     *
1127:     * PUBLIC (nao PROTECTED) de proposito: o harness de teste automatico
1128:     * chama THIS.oForm.CarregarLista() de FORA da classe, e PEMSTATUS nao
1129:     * verifica escopo - um PROTECTED aqui passaria pelo IF do teste e
1130:     * falharia em runtime (regra CLAUDE.md #3).
1131:     *--------------------------------------------------------------------------
1132:     PROCEDURE CarregarLista()
1133:         LOCAL loc_lSucesso
1134: 
1135:         loc_lSucesso = .F.
1136: 
1137:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1138:             loc_lSucesso = THIS.this_oBusinessObject.CarregarVinculos( ;
1139:                                THIS.this_cDopes, THIS.this_cCursorGrade)
1140:         ENDIF
1141: 
1142:         THIS.AtualizarGrade(.T.)
1143: 
1144:         RETURN loc_lSucesso
1145:     ENDPROC
1146: 
1147:     *--------------------------------------------------------------------------
1148:     * AtualizarGrade - METODO UNICO de repintura da grade, equivalente ao
1149:     * "Select TmpCcOpe / Goto Top / Thisform.GradeSubN.Refresh" do Init
1150:     * legado e ao "Thisform.GradeSubN.Refresh" do cmdExcluir.Click.
1151:     *
1152:     * par_lIrParaTopo - .T. reposiciona no primeiro registro (carga); .F.
1153:     *   preserva a linha corrente (exclusao, que ja reposicionou com o
1154:     *   SKIP / SKIP -1 do legado). Omitido = .T.
1155:     *--------------------------------------------------------------------------
1156:     PROCEDURE AtualizarGrade(par_lIrParaTopo)
1157:         LOCAL loc_lIrParaTopo
1158: 
1159:         loc_lIrParaTopo = IIF(VARTYPE(par_lIrParaTopo) = "L", par_lIrParaTopo, .T.)
1160: 
1161:         IF USED("cursor_4c_Vinculos")
1162:             SELECT cursor_4c_Vinculos
1163:             IF loc_lIrParaTopo
1164:                 GO TOP IN cursor_4c_Vinculos
1165:             ENDIF
1166:         ENDIF
1167: 
1168:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1169:             THIS.grd_4c_Dados.Refresh()
1170:         ENDIF
1171:     ENDPROC
1172: 
1173:     *--------------------------------------------------------------------------
1174:     * CmdInserirClick - SIGOPOPE.cmdInserir.Click (legado):
1175:     *
1176:     *   Thisform.lHouveIns = .T.
1177:     *   Select TmpCcOpe
1178:     *   Locate for Grupos = ' '
1179:     *   If Eof()
1180:     *       Insert Into TmpCcOpe (Dopes, CidChaves) Values (crSigCdOpe.Dopes, fUniqueIds())
1181:     *   EndIf
1182:     *   Select TmpCcOpe
1183:     *   Thisform.GradeSubN.Column1.SetFocus
1184:     *
1185:     * O LOCATE evita empilhar linhas em branco: se ja existe uma linha sem
1186:     * grupo, o botao so leva o foco de volta para ela.
1187:     *
1188:     * PUBLIC (nao PROTECTED): e alvo de BINDEVENT (regra CLAUDE.md #3).
1189:     *--------------------------------------------------------------------------
1190:     PROCEDURE CmdInserirClick()
1191:         LOCAL loc_oErro
1192: 
1193:         TRY
1194:             IF !USED("cursor_4c_Vinculos")
1195:                 MsgErro("Cursor da grade n" + CHR(227) + "o est" + CHR(225) + " aberto.", ;
1196:                         "Erro em CmdInserirClick")
1197:             ELSE
1198:                 THIS.this_lHouveIns = .T.
1199: 
1200:                 SELECT cursor_4c_Vinculos
1201:                 LOCATE FOR EMPTY(grupos)
1202: 
1203:                 IF EOF()
1204:                     INSERT INTO cursor_4c_Vinculos (dopes, cidchaves) ;
1205:                         VALUES (THIS.this_cDopes, LEFT(fUniqueIds(), 20))
1206:                 ENDIF
1207: 
1208:                 *-- repinta SEM GO TOP: a linha corrente e a recem-inserida
1209:                 *-- (ou a linha em branco que o LOCATE encontrou)
1210:                 THIS.AtualizarGrade(.F.)
1211: 
1212:                 IF THIS.grd_4c_Dados.Visible AND !THIS.grd_4c_Dados.ReadOnly
1213:                     THIS.grd_4c_Dados.Column1.SetFocus()
1214:                 ENDIF
1215:             ENDIF
1216:         CATCH TO loc_oErro
1217:             MsgErro(loc_oErro.Message + CHR(13) + ;
1218:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1219:                     "Procedure: " + loc_oErro.Procedure, ;
1220:                     "Erro em CmdInserirClick")
1221:         ENDTRY
1222:     ENDPROC
1223: 
1224:     *--------------------------------------------------------------------------
1225:     * CmdExcluirClick - SIGOPOPE.cmdExcluir.Click (legado):
1226:     *
1227:     *   Select TmpCcOpe
1228:     *   If Not Eof()
1229:     *       Thisform.lHouveExcl = .T.
1230:     *       Delete
1231:     *       Skip
1232:     *       Skip - 1
1233:     *   Endif
1234:     *   Thisform.GradeSubN.Refresh
1235:     *
1236:     * O "Skip / Skip -1" reposiciona o ponteiro num registro vivo depois da
1237:     * exclusao logica (com SET DELETED ON o registro apagado deixa de ser
1238:     * visitado); por isso a repintura aqui NAO vai para o topo.
1239:     *
1240:     * PUBLIC (nao PROTECTED): e alvo de BINDEVENT (regra CLAUDE.md #3).
1241:     *--------------------------------------------------------------------------
1242:     PROCEDURE CmdExcluirClick()
1243:         LOCAL loc_oErro
1244: 
1245:         TRY
1246:             IF !USED("cursor_4c_Vinculos")
1247:                 MsgErro("Cursor da grade n" + CHR(227) + "o est" + CHR(225) + " aberto.", ;
1248:                         "Erro em CmdExcluirClick")
1249:             ELSE
1250:                 SELECT cursor_4c_Vinculos
1251: 
1252:                 IF !EOF()
1253:                     THIS.this_lHouveExcl = .T.
1254:                     DELETE
1255:                     SKIP
1256:                     SKIP -1
1257: 
1258:                     IF EOF() OR BOF()
1259:                         GO TOP
1260:                     ENDIF
1261:                 ENDIF
1262: 
1263:                 THIS.AtualizarGrade(.F.)
1264:             ENDIF
1265:         CATCH TO loc_oErro
1266:             MsgErro(loc_oErro.Message + CHR(13) + ;
1267:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1268:                     "Procedure: " + loc_oErro.Procedure, ;
1269:                     "Erro em CmdExcluirClick")
1270:         ENDTRY
1271:     ENDPROC
1272: 
1273:     *--------------------------------------------------------------------------
1274:     * CmdSairClick - SIGOPOPE.cmdSair.Click (legado): grava o que foi
1275:     * alterado na grade e encerra o dialogo.
1276:     *
1277:     *   If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
1278:     *       If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
1279:     *           Select TmpCcOpe
1280:     *           Delete For Grupos = '  '
1281:     *           Replace all dopes With CrSigCdOpe.Dopes, CidChaves With fUniqueIds()
1282:     *           Select Grupos, sum(1) From TmpccOpe Group by 1 having sum(1) > 1 Into Cursor SecondKey
1283:     *           If Reccount() > 0
1284:     *               MessageBox('Existem Grupos em Duplicidade. Favor Acertar!!!',0+16,'Atencao')
1285:     *               Return .f.
1286:     *           EndIf
1287:     *           ...Delete From SigCcCpe Where Dopes = <operacao> + regrava o cursor...
1288:     *       EndIf
1289:     *   EndIf
1290:     *   Thisform.ParentForm.Enabled = .T.
1291:     *   Thisform.mCtrlBotoes(.T.)
1292:     *   ThisForm.Release
1293:     *
1294:     * O guard de duplicidade NAO fecha o dialogo ("Return .f." do legado):
1295:     * o usuario precisa acertar os grupos repetidos antes de sair. O
1296:     * "Replace all dopes/CidChaves" e o DELETE+regravacao ficam no BO
1297:     * (SalvarVinculos), em transacao unica.
1298:     *
1299:     * NAO ha RETURN dentro do TRY (regra CLAUDE.md #1): o fluxo e decidido
1300:     * pela flag loc_lPodeFechar e a saida acontece DEPOIS do ENDTRY.
1301:     *
1302:     * PUBLIC (nao PROTECTED): e alvo de BINDEVENT (regra CLAUDE.md #3).
1303:     *--------------------------------------------------------------------------
1304:     PROCEDURE CmdSairClick()
1305:         LOCAL loc_lPodeFechar, loc_lTemDuplicidade, loc_oErro
1306: 
1307:         loc_lPodeFechar     = .T.
1308:         loc_lTemDuplicidade = .F.
1309: 
1310:         TRY
1311:             *-- so grava quando o dialogo esta em modo de edicao (Inserir ou
1312:             *-- Excluir visiveis) E alguma coisa mudou na grade
1313:             IF (THIS.cmd_4c_CmdInserir.Visible OR THIS.cmd_4c_CmdExcluir.Visible) ;
1314:                AND (THIS.this_lHouveIns OR THIS.this_lHouveExcl) ;
1315:                AND USED("cursor_4c_Vinculos")
1316: 
1317:                 SELECT cursor_4c_Vinculos
1318: 
1319:                 *-- "Delete For Grupos = '  '": linha em branco nao vira registro
1320:                 DELETE FOR EMPTY(grupos)
1321: 
1322:                 IF USED("cursor_4c_Duplicados")
1323:                     USE IN cursor_4c_Duplicados
1324:                 ENDIF
1325: 
1326:                 SELECT grupos, COUNT(*) AS qtd ;
1327:                     FROM cursor_4c_Vinculos ;
1328:                     GROUP BY 1 ;
1329:                     HAVING COUNT(*) > 1 ;
1330:                     INTO CURSOR cursor_4c_Duplicados READWRITE
1331: 
1332:                 *-- cursor derivado de SELECT nao tem registro deletado, entao
1333:                 *-- RECCOUNT aqui conta exatamente as duplicidades
1334:                 loc_lTemDuplicidade = (USED("cursor_4c_Duplicados") AND RECCOUNT("cursor_4c_Duplicados") > 0)
1335: 
1336:                 IF USED("cursor_4c_Duplicados")
1337:                     USE IN cursor_4c_Duplicados
1338:                 ENDIF
1339: 
1340:                 IF loc_lTemDuplicidade
1341:                     *-- UNICO caminho em que o legado NAO fecha ("Return .f.")
1342:                     loc_lPodeFechar = .F.
1343:                     MsgAviso("Existem Grupos em Duplicidade. Favor Acertar!!!", ;
1344:                              "Aten" + CHR(231) + CHR(227) + "o")
1345:                     THIS.AtualizarGrade(.T.)
1346:                 ELSE
1347:                     IF VARTYPE(THIS.this_oBusinessObject) = "O"
1348:                         *-- o BO exibe a propria mensagem quando a gravacao
1349:                         *-- falha; o legado encerra o dialogo nos dois casos
1350:                         THIS.this_oBusinessObject.SalvarVinculos( ;
1351:                             THIS.this_cDopes, THIS.this_cCursorGrade)
1352:                     ELSE
1353:                         *-- sem BO nao ha como gravar: avisar, para o usuario
1354:                         *-- nao sair achando que o vinculo foi salvo
1355:                         MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
1356:                                 "vel - as altera" + CHR(231) + CHR(245) + "es da grade " + ;
1357:                                 "N" + CHR(195) + "O foram gravadas.", ;
1358:                                 "Erro em CmdSairClick")
1359:                     ENDIF
1360:                 ENDIF
1361:             ENDIF
1362:         CATCH TO loc_oErro
1363:             *-- NAO bloqueia a saida: este dialogo tem TitleBar = 0,
1364:             *-- ControlBox = .F. e WindowType = 1, entao o cmdSair e a UNICA
1365:             *-- saida (inclusive o ESC, por .Cancel = .T.). Prender o usuario
1366:             *-- aqui travaria a aplicacao inteira. O legado tambem avisa e
1367:             *-- fecha quando a gravacao falha - so a duplicidade retem.
1368:             MsgErro(loc_oErro.Message + CHR(13) + ;
1369:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1370:                     "Procedure: " + loc_oErro.Procedure, ;
1371:                     "Erro em CmdSairClick")
1372:         ENDTRY
1373: 
1374:         IF loc_lPodeFechar
1375:             *-- "Thisform.ParentForm.Enabled = .T." + "mCtrlBotoes(.T.)": o
1376:             *-- legado reabilita botao a botao a Lista do form chamador
1377:             *-- porque so ela havia sido travada; aqui o Init desabilitou o
1378:             *-- form chamador INTEIRO, entao reabilita-lo cobre os dois.
1379:             THIS.ReabilitarFormPai()
1380:             THIS.Release()
1381:         ENDIF
1382:     ENDPROC
1383: 
1384:     *--------------------------------------------------------------------------
1385:     * ReabilitarFormPai - devolve o controle ao form chamador, equivalente
1386:     * ao par "Thisform.ParentForm.Enabled = .T." + "Thisform.mCtrlBotoes(.T.)"
1387:     * do cmdSair.Click legado.
1388:     *
1389:     * Metodo unico porque ha DOIS caminhos de volta: o botao Encerrar e o
1390:     * Destroy (rede de seguranca para fechamento por ESC/Alt+F4). Sem isso,
1391:     * fechar o dialogo por fora do botao deixaria o Cadastro de Operacoes
1392:     * travado para sempre.
1393:     *--------------------------------------------------------------------------
1394:     PROTECTED PROCEDURE ReabilitarFormPai()
1395:         IF VARTYPE(THIS.this_oFormPai) = "O"
1396:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
1397:                 THIS.this_oFormPai.Enabled = .T.
1398:             ENDIF
1399:         ENDIF
1400:     ENDPROC
1401:     *--------------------------------------------------------------------------
1402:     * TornarControlesVisiveis - torna visiveis, recursivamente, todos os
1403:     * controles criados via AddObject (que nascem com Visible=.F.). Nao ha
1404:     * container flutuante neste form (dialogo flat, sem paineis ocultos
1405:     * alternados por botao), entao nao ha lista de exclusao.
1406:     *--------------------------------------------------------------------------
1407:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1408:         LOCAL loc_nI, loc_oObjeto, loc_nP
1409: 
1410:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1411:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1412: 
1413:             IF VARTYPE(loc_oObjeto) = "O"
1414:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1415:                     loc_oObjeto.Visible = .T.
1416:                 ENDIF
1417: 
1418:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1419:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1420:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1421:                     ENDFOR
1422:                 ENDIF
1423: 
1424:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1425:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1426:                 ENDIF
1427:             ENDIF
1428:         ENDFOR
1429:     ENDPROC
1430: 
1431:     *--------------------------------------------------------------------------
1432:     * Destroy - rede de seguranca: reabilita o form chamador mesmo se o
1433:     * dialogo for encerrado sem passar pelo funil do botao Encerrar
1434:     * (equivalente a "Thisform.ParentForm.Enabled = .T." do cmdSair.Click
1435:     * legado) e fecha o cursor local da grade, para nao vazar work area
1436:     * entre aberturas do dialogo. DODEFAULT() preserva a limpeza de
1437:     * this_oBusinessObject e a restauracao do menu feitas por
1438:     * FormBase.Destroy().
1439:     *--------------------------------------------------------------------------
1440:     PROCEDURE Destroy()
1441:         THIS.ReabilitarFormPai()
1442: 
1443:         IF USED("cursor_4c_Vinculos")
1444:             IF CURSORGETPROP("Buffering", "cursor_4c_Vinculos") > 1
1445:                 TABLEREVERT(.T., "cursor_4c_Vinculos")
1446:             ENDIF
1447:             USE IN cursor_4c_Vinculos
1448:         ENDIF
1449: 
1450:         IF USED("cursor_4c_Duplicados")
1451:             USE IN cursor_4c_Duplicados
1452:         ENDIF
1453: 
1454:         *-- rede de seguranca: cursores dos lookups de Grupo de Contas
1455:         *-- (Column1/Column3) podem ficar abertos se o dialogo for fechado
1456:         *-- no meio de uma validacao/busca
1457:         IF USED("cursor_4c_GruposAcessiveis")
1458:             USE IN cursor_4c_GruposAcessiveis
1459:         ENDIF
1460: 
1461:         IF USED("cursor_4c_ContaVinc")
1462:             USE IN cursor_4c_ContaVinc
1463:         ENDIF
1464: 
1465:         DODEFAULT()
1466:     ENDPROC
1467: 
1468: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpOpeBO.prg):
*====================================================================
* SigOpOpeBO.prg
*
* Business Object para Centro de Custo Padrao da Operacao
* Tabela: SigCcCpe (vinculo Grupo de Contas x Operacao)
* Tabelas relacionadas: SigCdOpe (operacao - FK dopes), SigCdGcr (grupo de contas - FK grupos)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpOpeBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCcCpe)
    this_cCidChaves      = ""    && cidchaves char(20) - PK (gerada via fUniqueIds())
    this_cDopes          = ""    && dopes     char(20) - codigo da operacao (FK SigCdOpe.dopes)
    this_cGrupos         = ""    && grupos    char(10) - codigo do grupo de contas (FK SigCdGcr.codigos)
    this_cGruCads        = ""    && grucads   char(10) - grupo de cadastro (conta contabil validada via fAcessoContab)
    this_nCtFils         = 0     && ctfils    numeric(1,0) - "C" = Somente Contas do Grupo (0/1)

    *-- Propriedade auxiliar de exibicao (NAO persistida em SigCcCpe)
    this_cDescricaoGrupo = ""    && SigCdGcr.descrs - descricao do grupo (join, somente leitura)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCcCpe"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpOpeBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    * (usada por RegistrarAuditoria)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia os campos do cursor para as propriedades
    * do vinculo Grupo de Contas x Operacao (SigCcCpe). par_cAliasCursor
    * eh o alias do cursor posicionado no registro a carregar (ex.: linha
    * corrente da grade TmpCcOpe, ou resultado de SQLEXEC pela chave).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "")
            THIS.this_cDopes     = TratarNulo(dopes,     "")
            THIS.this_cGrupos    = TratarNulo(grupos,    "")
            THIS.this_cGruCads   = TratarNulo(grucads,   "")
            THIS.this_nCtFils    = TratarNulo(ctfils,    0)

            *-- descrs nao eh coluna de SigCcCpe: so chega quando o cursor
            *-- de origem for montado com JOIN contra SigCdGcr (descricao
            *-- do grupo exibida na grade). Mapear so quando presente.
            IF TYPE(par_cAliasCursor + ".descrs") != "U"
                THIS.this_cDescricaoGrupo = TratarNulo(descrs, "")
            ELSE
                THIS.this_cDescricaoGrupo = ""
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT de um vinculo Grupo de Contas x Operacao em SigCcCpe
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigCcCpe (cidchaves, dopes, grupos, grucads, ctfils)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves)       + "," + ;
                       EscaparSQL(THIS.this_cDopes)           + "," + ;
                       EscaparSQL(THIS.this_cGrupos)          + "," + ;
                       EscaparSQL(THIS.this_cGruCads)         + "," + ;
                       FormatarNumeroSQL(THIS.this_nCtFils, 0) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir centro de custo padr" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir centro de custo padr" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE de um vinculo Grupo de Contas x Operacao em SigCcCpe
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCcCpe SET" + ;
                       " dopes    = " + EscaparSQL(THIS.this_cDopes)   + "," + ;
                       " grupos   = " + EscaparSQL(THIS.this_cGrupos)  + "," + ;
                       " grucads  = " + EscaparSQL(THIS.this_cGruCads) + "," + ;
                       " ctfils   = " + FormatarNumeroSQL(THIS.this_nCtFils, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar centro de custo padr" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar centro de custo padr" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *====================================================================
    * CarregarVinculos - Popula o cursor da grade com os vinculos
    * "Grupo de Contas x Operacao" ja gravados para a operacao recebida.
    *
    * Transcreve a consulta do PROCEDURE Init legado:
    *   lcSql = [Select a.*, b.Descrs as Dgrus From SigCcCpe a, SigCdGcr b
    *            where a.Dopes = <operacao> And a.Grupos = b.Codigos]
    *   SigCdOpe.PodataMgr.Sqlexecute(lcSql,'xCcOpe')
    *   Select * From xCcOpe Into Cursor TmpCcOpe ReadWrite
    *
    * O "a.*" do legado vira a lista EXPLICITA das 5 colunas de SigCcCpe
    * (cidchaves/dopes/grupos/grucads/ctfils): o APPEND FROM casa as
    * colunas por NOME, entao a lista do SELECT tem de ser exatamente a
    * do CREATE CURSOR do form.
    *
    * NAO faz SQLEXEC direto no alias da grade: isso FECHA e RECRIA o
    * alias, zerando ColumnCount/RecordSource/ControlSource e o
    * CurrentControl do CheckBox da Column4 (a grade viraria um retangulo
    * branco, sem erro e sem log). Por isso o SQL vai para um cursor
    * TEMPORARIO e o alias da grade e recarregado com ZAP + APPEND FROM
    * DBF(), que preserva estrutura e bindings.
    *
    * par_cDopes        - codigo da operacao (SigCdOpe.dopes)
    * par_cAliasDestino - alias ja criado (CREATE CURSOR) ligado a grade
    *====================================================================
    PROCEDURE CarregarVinculos(par_cDopes, par_cAliasDestino)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cTemp, loc_oErro
        LOCAL loc_cAliasAnterior, loc_cSafety

        loc_lSucesso       = .F.
        loc_cTemp          = "cursor_4c_VinculosTmp"
        loc_cAliasAnterior = ALIAS()
        loc_cSafety        = SET("SAFETY")

        TRY
            IF VARTYPE(par_cDopes) != "C" OR VARTYPE(par_cAliasDestino) != "C"
                MsgErro("Par" + CHR(226) + "metros inv" + CHR(225) + "lidos em CarregarVinculos.", ;
                        "Erro em CarregarVinculos")
            ELSE
                IF !USED(par_cAliasDestino)
                    MsgErro("Cursor da grade [" + par_cAliasDestino + "] n" + CHR(227) + ;
                            "o est" + CHR(225) + " aberto.", "Erro em CarregarVinculos")
                ELSE
                    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                        MsgErro("Conex" + CHR(227) + "o com o banco n" + CHR(227) + ;
                                "o estabelecida.", "Erro em CarregarVinculos")
                    ELSE
                        loc_cSQL = "SELECT a.cidchaves, a.dopes, a.grupos, a.grucads, a.ctfils," + ;
                                   " b.descrs AS dgrus" + ;
                                   " FROM SigCcCpe a, SigCdGcr b" + ;
                                   " WHERE a.dopes = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
                                   " AND a.grupos = b.codigos"

                        IF USED(loc_cTemp)
                            IF CURSORGETPROP("Buffering", loc_cTemp) > 1
                                TABLEREVERT(.T., loc_cTemp)
                            ENDIF
                            USE IN (loc_cTemp)
                        ENDIF

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cTemp)

                        IF loc_nResultado < 0
                            MsgErro("Erro ao carregar os centros de custo da opera" + CHR(231) + ;
                                    CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            *-- SET SAFETY e escopado por DATA SESSION: o
                            *-- SET SAFETY OFF do main.prg vale na sessao 1,
                            *-- mas este BO roda DENTRO da datasession
                            *-- privada do FormSigOpOpe (DataSession = 2),
                            *-- onde SAFETY nasce ON - medido no VFP9 em
                            *-- 2026-11-11 (automation/MedirDeletedSafetyDS2.prg:
                            *-- "SESSAO_FORM deleted=OFF safety=ON"). Com
                            *-- SAFETY ON o ZAP abre o dialogo modal
                            *-- "Zap ... Are you sure?" e CONGELA a tela.
                            SET SAFETY OFF

                            SELECT (par_cAliasDestino)
                            ZAP

                            IF loc_cSafety = "ON"
                                SET SAFETY ON
                            ENDIF

                            IF USED(loc_cTemp)
                                APPEND FROM DBF(loc_cTemp)
                                USE IN (loc_cTemp)
                            ENDIF
                            GO TOP IN (par_cAliasDestino)
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarVinculos")
        ENDTRY

        *-- rede de seguranca: excecao DURANTE o ZAP sairia com SAFETY OFF
        IF loc_cSafety = "ON"
            SET SAFETY ON
        ENDIF

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterGrupoContasAcessivel - Nucleo de fAcessoContab (Framework legado,
    * Framework\sigacess.PRG:1029) restrito ao caminho usado por SIGOPOPE
    * (os dois call sites do dump passam so pUsu/pTip/pTxt/pCod[/pDsc] -
    * pCta e pDat nunca sao informados, entao os blocos de vinculo com
    * conta-corrente (SigCdCli) e de bloqueio por periodo (ddRetros/ddFutus)
    * do legado NUNCA executam para este form e foram omitidos aqui).
    *
    * Replica a restricao de acesso por GRUPO DE CONTAS:
    *   - usuario "4CONTROL" (super-usuario) enxerga TODOS os grupos
    *     (equivalente a "llTot" do legado)
    *   - demais usuarios so veem grupos vinculados a eles via SigSyAgc
    *     (Usuacess direto) OU via grupo de acesso (SigCdAcG.Usuarios),
    *     igual ao JOIN de 3 tabelas do legado
    *   - se o usuario NAO tem NENHUM vinculo de restricao cadastrado em
    *     SigSyAgc/SigCdAcG, cai para a lista COMPLETA de SigCdGcr
    *     (equivalente a "llRst" do legado - sistema sem restricao
    *     configurada libera tudo)
    *
    * par_cFiltroCodigo - codigo exato a filtrar (Codigos = valor); vazio
    *   devolve TODOS os grupos acessiveis (usado para popular o picker).
    *
    * Retorna o codigo do SQLEXEC; o resultado fica no cursor
    * cursor_4c_GruposAcessiveis (colunas Codigos/Descrs) - o CHAMADOR
    * fecha esse cursor apos usar.
    *====================================================================
    FUNCTION ObterGrupoContasAcessivel(par_cFiltroCodigo)
        LOCAL loc_cUsuario, loc_lSuperUsuario, loc_cAlias, loc_cWhereUsuario
        LOCAL loc_cSQL, loc_nResultado, loc_nTotalVinculos, loc_lUsaRestricao
        LOCAL loc_cFiltro

        loc_cAlias   = "cursor_4c_GruposAcessiveis"
        loc_cFiltro  = IIF(VARTYPE(par_cFiltroCodigo) = "C", ALLTRIM(par_cFiltroCodigo), "")
        loc_cUsuario = ALLTRIM(UPPER(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")))
        loc_lSuperUsuario = (loc_cUsuario == "4CONTROL")

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_lUsaRestricao = !loc_lSuperUsuario AND !EMPTY(loc_cUsuario)

        IF loc_lUsaRestricao
            loc_cWhereUsuario = "(a.Usuacess = " + EscaparSQL(loc_cUsuario) + ;
                                 " OR c.Usuarios = " + EscaparSQL(loc_cUsuario) + ")"

            loc_cSQL = "SELECT COUNT(*) AS Nvinc FROM SigSyAgc a" + ;
                       " LEFT JOIN SigCdAcG c ON c.Grupos = a.Gracess AND c.Usuarios = " + ;
                       EscaparSQL(loc_cUsuario) + ;
                       " WHERE " + loc_cWhereUsuario

            IF USED("cursor_4c_ContaVinc")
                USE IN cursor_4c_ContaVinc
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaVinc")
            loc_nTotalVinculos = IIF(loc_nResultado >= 0 AND USED("cursor_4c_ContaVinc"), ;
                                      NVL(cursor_4c_ContaVinc.Nvinc, 0), 0)
            IF USED("cursor_4c_ContaVinc")
                USE IN cursor_4c_ContaVinc
            ENDIF

            *-- sem NENHUM vinculo de restricao cadastrado -> acesso livre
            loc_lUsaRestricao = (loc_nTotalVinculos > 0)
        ENDIF

        IF loc_lUsaRestricao
            loc_cSQL = "SELECT b.Codigos, b.Descrs" + ;
                       " FROM SigSyAgc a" + ;
                       " LEFT JOIN SigCdAcG c ON c.Grupos = a.Gracess AND c.Usuarios = " + ;
                       EscaparSQL(loc_cUsuario) + ;
                       " RIGHT JOIN SigCdGcr b ON b.Codigos = a.Grcontbs" + ;
                       " WHERE " + loc_cWhereUsuario
            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " AND b.Codigos = " + EscaparSQL(loc_cFiltro)
            ENDIF
            loc_cSQL = loc_cSQL + " GROUP BY b.Codigos, b.Descrs ORDER BY b.Codigos"
        ELSE
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr"
            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE Codigos = " + EscaparSQL(loc_cFiltro)
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY Codigos"
        ENDIF

        RETURN SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)
    ENDFUNC

    *====================================================================
    * SalvarVinculos - Regrava TODOS os vinculos da operacao a partir do
    * cursor da grade, em transacao unica.
    *
    * Transcreve o bloco de gravacao do cmdSair.Click legado:
    *   lcSql = [Delete From SigCcCpe Where Dopes = <operacao>]
    *   ...Sqlexecute(lcSql,'') / .poDataMgr.UpDate('crSigCcCpe') / Commit()
    *   Se qualquer etapa falhar -> RollBack()
    * O legado apaga tudo da operacao e regrava o cursor inteiro (o
    * "Zap / Append From Dbf('TmpCcOpe')" em crSigCcCpe antes do Update);
    * aqui o mesmo efeito vem de DELETE + um INSERT por linha.
    *
    * BEGIN/COMMIT por SQLEXEC NAO protege nada - a transacao e aberta na
    * CONEXAO (SQLSETPROP "Transactions" = 2) e encerrada com SQLTRANSACT,
    * restaurando o modo automatico (1) em TODOS os caminhos, inclusive
    * no CATCH.
    *
    * As linhas DELETADAS do cursor (o "Delete For Grupos = '  '" do
    * legado) ficam de fora porque o SCAN respeita SET DELETED ON; a
    * guarda por grupos vazio cobre o caso de SET DELETED OFF.
    *
    * par_cDopes       - codigo da operacao (SigCdOpe.dopes)
    * par_cAliasCursor - alias do cursor da grade com as linhas a gravar
    *====================================================================
    PROCEDURE SalvarVinculos(par_cDopes, par_cAliasCursor)
        LOCAL loc_lSucesso, loc_lTransacaoAberta, loc_lErroScan
        LOCAL loc_cSQL, loc_nResultado, loc_oErro, loc_cAliasAnterior

        loc_lSucesso         = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroScan        = .F.
        loc_cAliasAnterior   = ALIAS()

        TRY
            IF VARTYPE(par_cDopes) != "C" OR VARTYPE(par_cAliasCursor) != "C"
                MsgErro("Par" + CHR(226) + "metros inv" + CHR(225) + "lidos em SalvarVinculos.", ;
                        "Erro em SalvarVinculos")
            ELSE
                IF !USED(par_cAliasCursor)
                    MsgErro("Cursor da grade [" + par_cAliasCursor + "] n" + CHR(227) + ;
                            "o est" + CHR(225) + " aberto.", "Erro em SalvarVinculos")
                ELSE
                    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                        MsgErro("Conex" + CHR(227) + "o com o banco n" + CHR(227) + ;
                                "o estabelecida.", "Erro em SalvarVinculos")
                    ELSE
                        SQLSETPROP(gnConnHandle, "Transactions", 2)
                        loc_lTransacaoAberta = .T.

                        loc_cSQL = "DELETE FROM SigCcCpe WHERE dopes = " + ;
                                   EscaparSQL(ALLTRIM(par_cDopes))
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                        IF loc_nResultado < 0
                            loc_lErroScan = .T.
                            MsgErro("Erro ao limpar os centros de custo da opera" + CHR(231) + ;
                                    CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            SELECT (par_cAliasCursor)
                            GO TOP

                            SCAN
                                *-- linha em branco nao vira registro (o legado
                                *-- apaga essas linhas antes de gravar)
                                IF !EMPTY(EVALUATE(par_cAliasCursor + ".grupos"))
                                    IF !THIS.CarregarDoCursor(par_cAliasCursor)
                                        loc_lErroScan = .T.
                                        EXIT
                                    ENDIF

                                    *-- a operacao do vinculo e sempre a do form
                                    *-- chamador ("Replace all dopes With
                                    *-- CrSigCdOpe.Dopes" do legado)
                                    THIS.this_cDopes = ALLTRIM(par_cDopes)

                                    *-- PK nova para cada linha regravada
                                    *-- ("CidChaves With fUniqueIds()")
                                    THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)

                                    IF !THIS.Inserir()
                                        loc_lErroScan = .T.
                                        EXIT
                                    ENDIF
                                ENDIF
                            ENDSCAN
                        ENDIF

                        IF loc_lErroScan
                            SQLTRANSACT(gnConnHandle, "ROLLBACK")
                        ELSE
                            SQLTRANSACT(gnConnHandle, "COMMIT")
                            loc_lSucesso = .T.
                        ENDIF

                        SQLSETPROP(gnConnHandle, "Transactions", 1)
                        loc_lTransacaoAberta = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLTRANSACT(gnConnHandle, "ROLLBACK")
                SQLSETPROP(gnConnHandle, "Transactions", 1)
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SalvarVinculos")
        ENDTRY

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

