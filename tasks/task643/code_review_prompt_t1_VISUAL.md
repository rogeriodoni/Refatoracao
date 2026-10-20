# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpAtu.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1050 linhas total):

*-- Linhas 13 a 51:
13: * legado nao tem Page1/Page2, e um dialogo unico de 1 campo + 1 botao
14: * (CLAUDE.md: forms OPERACIONAIS nao seguem o padrao Lista/Dados do
15: * CRUD - analisar o original).
16: *
17: * FASE 3/8 - ESTRUTURA BASE: cria o Business Object e monta so o
18: * elemento decorativo do layout (faixa do cabecalho cnt_4c_Sombra,
19: * equivalente ao cntSombra legado - o Init legado so faz
20: * ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption e o mesmo
21: * para lblTitulo, ja reproduzido aqui). NAO ha Load/=fConfigGeral() no
22: * migrado - fconfiggeral.prg (utils) eh wrapper de compatibilidade so
23: * para p-code de VCX legado (CLAUDE.md regra #2); codigo nosso nunca
24: * chama essa funcao.
25: *
26: * FASE 4/8 - BOTOES (CONCLUIDA COMO NO-OP JUSTIFICADO): nao ha Grid
27: * nem botoes CRUD (analise.json: temGrid=false; layout.json nao
28: * declara PageFrame nem grid) - o UNICO "botao" deste legado eh o
29: * Command1/"Ok" (SigOpAtu_form_codigo_fonte.txt:160-166), que fica
30: * para a Fase 7 (evento Click), junto com o campo que ele valida.
31: * Este eh um dialogo FLAT de CAPTURA (1 campo editavel + 1 botao, sem
32: * lista) - mesma familia do SIGMVVDE/FormSigMvVde documentada no
33: * gate da Fase 4 do OrquestradorMigracao.ps1 (ramo "layout captura").
34: * Inventar Page1/Grid/6 botoes CRUD aqui violaria o PILAR 1 (o
35: * legado eh um popup de 800x130 com 1 campo, nao um cadastro).
36: *
37: * FASE 5/8 - CAMPOS (PARTE 1, CONCLUIDA): cria lbl_4c_Label1 ("Operacao
38: * de Estoque :", equivalente ao Say1 legado - classe say sem Width nem
39: * Alignment no dump, logo .Alignment=0 com Width explicita, CLAUDE.md
40: * regra #23) e txt_4c_DopEstq (DopEstq/fwget do legado, ligado a
41: * SigCdOpe.dopes char(20) - regra "SigCdOpe eh single-column" acima).
42: * So a geometria/visual - BINDEVENT do Valid fica para a Fase 7.
43: *
44: * FASE 6/8 - CAMPOS RESTANTES E LOOKUPS: nao sobrou nenhum campo de
45: * dados (o legado tem UM so, entregue na Fase 5), entao esta fase
46: * entrega (a) o ultimo objeto de tela - cmd_4c_Command1, o "Ok"
47: * (Command1/fwbtng do legado) - e (b) o LOOKUP do campo DopEstq
48: * COMPLETO, que eh o trabalho principal desta fase.
49: *
50: * O "equivalente do cnt_4c_BotoesAcao (Salvar/Cancelar)" do roteiro
51: * CRUD aqui eh esse botao unico, criado DIRETO no Form (o SCX nao tem

*-- Linhas 198 a 218:
198:         RETURN DODEFAULT()
199:     ENDPROC
200: 
201:     *====================================================================
202:     * InicializarForm - cria o Business Object e monta a faixa do
203:     * cabecalho (cnt_4c_Sombra).
204:     *====================================================================
205:     PROTECTED PROCEDURE InicializarForm()
206:         LOCAL loc_lSucesso, loc_oErro
207:         loc_lSucesso = .F.
208: 
209:         TRY
210:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpAtuBO")
211: 
212:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
213:                 THIS.ConfigurarLayoutBase()
214:                 THIS.ConfigurarCampos()
215:                 THIS.ConfigurarBotaoOk()
216:                 THIS.ConfigurarEventos()
217: 
218:                 *-- Estado inicial da tela vem do BO (hooks da Fase 8/8):

*-- Linhas 236 a 354:
236:         RETURN loc_lSucesso
237:     ENDPROC
238: 
239:     *====================================================================
240:     * ConfigurarLayoutBase - fundo (Picture do legado) e faixa do
241:     * cabecalho (cnt_4c_Sombra, equivalente ao cntSombra legado). Campo
242:     * (DopEstq), label (Say1) e botao (Command1) entram nas fases
243:     * seguintes.
244:     *====================================================================
245:     PROTECTED PROCEDURE ConfigurarLayoutBase()
246:         THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
247: 
248:         THIS.AddObject("cnt_4c_Sombra", "Container")
249:         WITH THIS.cnt_4c_Sombra
250:             .Top         = 0
251:             .Left        = 0
252:             .Width       = THIS.Width
253:             .Height      = 80
254:             .BorderWidth = 0
255:             .BackStyle   = 1
256:             .BackColor   = RGB(100, 100, 100)
257:             .Visible     = .T.
258:         ENDWITH
259: 
260:         *-- lblSombra: Init legado faz ThisForm.cntSombra.lblSombra.Caption
261:         *   = ThisForm.Caption - reproduzido direto no .Caption abaixo.
262:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
263:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
264:             .FontBold      = .T.
265:             .FontName      = "Tahoma"
266:             .FontSize      = 18
267:             .FontUnderline = .F.
268:             .WordWrap      = .T.
269:             .AutoSize      = .F.
270:             .Alignment     = 0
271:             .BackStyle     = 0
272:             .Caption       = THIS.Caption
273:             .Height        = 40
274:             .Left          = 10
275:             .Top           = 18
276:             .Width         = 769
277:             .ForeColor     = RGB(0, 0, 0)
278:             .Visible       = .T.
279:         ENDWITH
280: 
281:         *-- lblTitulo: idem - ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
282:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
283:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
284:             .FontBold  = .T.
285:             .FontName  = "Tahoma"
286:             .FontSize  = 18
287:             .WordWrap  = .T.
288:             .AutoSize  = .F.
289:             .Alignment = 0
290:             .BackStyle = 0
291:             .Caption   = THIS.Caption
292:             .Height    = 46
293:             .Left      = 10
294:             .Top       = 17
295:             .Width     = 769
296:             .ForeColor = RGB(255, 255, 255)
297:             .Visible   = .T.
298:         ENDWITH
299:     ENDPROC
300: 
301:     *====================================================================
302:     * ConfigurarCampos - Fase 5/8 (Parte 1): label + campo digitavel
303:     * (SigOpAtu_form_codigo_fonte.txt:139-157). Direto na raiz do Form
304:     * (sem Page/PageFrame - dialogo FLAT), entao sem compensacao +29.
305:     * lbl_4c_Label1 = Say1 (classe say sem Width/Alignment no dump ->
306:     * Alignment=0 com Width explicita - CLAUDE.md regra #23; sem
307:     * ForeColor declarado -> RGB(90,90,90) - regra #12).
308:     * txt_4c_DopEstq = DopEstq (fwget), ligado a SigCdOpe.dopes char(20)
309:     * - MaxLength = 20 (regra #19, largura vem do SCHEMA, nao do Width
310:     * em pixels). BINDEVENT do Valid (lookup em SigCdOpe) fica para a
311:     * Fase 7 (regra #47 - lookup vai em LostFocus, nao em KeyPress sem
312:     * testar a tecla).
313:     *====================================================================
314:     PROTECTED PROCEDURE ConfigurarCampos()
315:         THIS.AddObject("lbl_4c_Label1", "Label")
316:         WITH THIS.lbl_4c_Label1
317:             .FontName  = "Tahoma"
318:             .FontSize  = 8
319:             .FontBold  = .F.
320:             .AutoSize  = .F.
321:             .Alignment = 0
322:             .BackStyle = 0
323:             .ForeColor = RGB(90, 90, 90)
324:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o de Estoque :"
325:             .Left      = 105
326:             .Top       = 94
327:             .Width     = 130
328:             .Height    = 17
329:             .Visible   = .T.
330:         ENDWITH
331: 
332:         THIS.AddObject("txt_4c_DopEstq", "TextBox")
333:         WITH THIS.txt_4c_DopEstq
334:             .FontName  = "Tahoma"
335:             .FontSize  = 8
336:             .Value     = ""
337:             .MaxLength = 20
338:             .Left      = 241
339:             .Top       = 91
340:             .Width     = 150
341:             .Height    = 21
342:             .TabIndex  = 2
343:             .Visible   = .T.
344:         ENDWITH
345:     ENDPROC
346: 
347:     *====================================================================
348:     * ConfigurarBotaoOk - Fase 6/8: Command1 do legado (mapeamento.json:
349:     * SIGOPATU.Command1 -> cmd_4c_Command1). Unico botao do form, criado
350:     * DIRETO no Form porque o SCX nao tem container de botoes.
351:     *
352:     * Top/Left/Picture/Caption EXATOS do dump
353:     * (SigOpAtu_form_codigo_fonte.txt:147-152). Width/Height/FontName/
354:     * FontSize/FontBold/FontItalic/ForeColor/BackColor/MousePointer/

*-- Linhas 369 a 383:
369:     * para preferir). Icone e caption ficam inteiros na area visivel.
370:     *====================================================================
371:     PROTECTED PROCEDURE ConfigurarBotaoOk()
372:         THIS.AddObject("cmd_4c_Command1", "CommandButton")
373:         WITH THIS.cmd_4c_Command1
374:             .Top             = 3
375:             .Left            = 723
376:             .Width           = 80
377:             .Height          = 100
378:             .Caption         = "\<Ok"
379:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
380:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
381:             .FontName        = "Comic Sans MS"
382:             .FontSize        = 8
383:             .FontBold        = .T.

*-- Linhas 414 a 422:
414:         *-- Atalho de mouse para o mesmo funil de lookup.
415:         BINDEVENT(THIS.txt_4c_DopEstq, "DblClick", THIS, "DopEstqDblClick")
416: 
417:         BINDEVENT(THIS.cmd_4c_Command1, "Click", THIS, "BtnOkClick")
418:     ENDPROC
419: 
420:     *====================================================================
421:     * DopEstqLostFocus - Wrapper do funil de validacao do campo (Valid
422:     * legado). O corpo vive em DopEstqLostFocusExec para que a flag de

*-- Linhas 678 a 687:
678:                         loc_oBusca.this_cTitulo        = loc_cTitulo
679: 
680:                         IF PEMSTATUS(loc_oBusca, "cnt_4c_Cabecalho", 5)
681:                             loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
682:                             loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
683:                         ENDIF
684: 
685:                         *-- UMA coluna so - mAddColuna('Dopes','','Codigo')
686:                         *   do legado (SigCdOpe eh single-column).
687:                         loc_oBusca.mAddColuna("Dopes", "", "C" + CHR(243) + "digo")

*-- Linhas 987 a 995:
987:     *   BtnSalvarClick/BtnBuscarClick/BtnEncerrarClick - convencao de
988:     *     form CRUD (Page1 "Lista" com Buscar/Encerrar, Page2 "Dados"
989:     *     com Salvar/Cancelar). O unico botao deste legado se chama
990:     *     "Ok" (Command1/cmd_4c_Command1 + BtnOkClick, Fase 6/8), e ele
991:     *     NAO grava: SigCdOpe eh consultada, nunca escrita por esta
992:     *     tela (ver cabecalho do SigOpAtuBO.prg).
993:     *   CarregarLista/AjustarBotoesPorModo - pressupoem grid de LISTA e
994:     *     modo atual (this_cModoAtual). analise.json confirma
995:     *     temGrid=false; layout.json nao declara nenhum BaseClass


### BO (C:\4c\projeto\app\classes\SigOpAtuBO.prg):
*============================================================================
* SigOpAtuBO.prg - Business Object para o dialogo "Operacao para Atualizacao"
*
* Tabela principal : SigCdOpe  (PK: dopes char(20) - coluna unica, codigo
*                     e descricao ao mesmo tempo - regra CLAUDE.md
*                     "SigCdOpe eh single-column")
*
* Este BO suporta um dialogo OPERACIONAL simples (SIGOPATU no legado): o
* usuario informa/seleciona o codigo de uma Operacao de Estoque ja
* cadastrada em SigCdOpe e confirma. Nao ha INSERT/UPDATE/DELETE no legado -
* o unico codigo-fonte do dialogo (Comando1.Click e DopEstq.Valid, ver
* tasks\task643\comportamento.json) apenas valida o valor digitado contra o
* cursor CrOpera (Seek) e, se nao encontrar, abre o picker (fwBuscaInt) para
* escolha; o botao "Ok" so confere que o campo nao esta vazio e libera o
* form. Nao ha AddCursor nem TABLEUPDATE: SigCdOpe eh consultada, nunca
* gravada, por esta tela.
*
* Fase 2/8: Inserir() e Atualizar() permanecem SEM override - o
* comportamento padrao herdado de BusinessBase (recusar a operacao) ja eh o
* correto para este BO, porque inventar um INSERT/UPDATE em SigCdOpe aqui
* violaria a regra de que a lista de colunas vem do schema/legado, nunca de
* suposicao, e este dialogo nunca grava naquela tabela.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - CarregarDoCursor() e ObterChavePrimaria()
*============================================================================

DEFINE CLASS SigOpAtuBO AS BusinessBase

    *==========================================================================
    * Propriedade da entidade SigCdOpe (chave e descricao, na mesma coluna)
    *==========================================================================
    this_cDopEstq = ""   && char(20) - Operacao de Estoque (SigCdOpe.dopes)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- A tabela TEM de ir no DODEFAULT: BusinessBase.Init() so cria
            *-- this_oDataAccess quando recebe pcTabela. Com DODEFAULT() vazio
            *-- o objeto de acesso a dados fica .NULL. e todo metodo herdado
            *-- que depende dele (Buscar) devolve .F. com "Objeto de acesso a
            *-- dados nao inicializado".
            DODEFAULT("SigCdOpe")
            THIS.this_cTabela     = "SigCdOpe"
            THIS.this_cCampoChave = "dopes"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria (dopes)
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopEstq)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega this_cDopEstq a partir de um cursor que
    * contenha a coluna dopes (regra CLAUDE.md #9: SELECT (par_cAliasCursor)
    * antes de acessar os campos, nunca campo)
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDopEstq = TratarNulo(dopes, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExisteOperacao - Confere se o codigo informado existe em SigCdOpe.
    * Usado pelo Form (Valid/LostFocus do campo DopEstq) para reproduzir o
    * Seek(This.Value, 'CrOpera') do legado antes de abrir o picker
    * FormBuscaAuxiliar - regra CLAUDE.md "SigCdOpe eh single-column"
    * (NUNCA referenciar descrs/Descrs: dopes eh codigo E descricao).
    *==========================================================================
    FUNCTION ExisteOperacao(par_cCodigo)
        LOCAL loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        IF EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_SigOpAtu_Existe")
            USE IN cursor_4c_SigOpAtu_Existe
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, ;
            "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
            "cursor_4c_SigOpAtu_Existe")

        IF loc_nResultado > 0
            loc_lExiste = (RECCOUNT("cursor_4c_SigOpAtu_Existe") > 0)
        ENDIF

        IF USED("cursor_4c_SigOpAtu_Existe")
            USE IN cursor_4c_SigOpAtu_Existe
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE

