# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 340: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEop.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (869 linhas total):

*-- Linhas 113 a 121:
113:             BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "Click",     THIS, "ChkSelecaoClick")
114:             BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "KeyPress",  THIS, "ChkSelecaoKeyPress")
115:             BINDEVENT(THIS.chk_4c_Ck_Marca,                    "Click",     THIS, "ChkMarcaClick")
116:             BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Confirmar,      "Click",     THIS, "CmdConfirmarClick")
117: 
118:             *-- Tornar controles visiveis apos AddObject (que cria com Visible=.F.)
119:             THIS.TornarControlesVisiveis(THIS)
120: 
121:             loc_lSucesso = .T.

*-- Linhas 131 a 178:
131:     * Este form nao tem PageFrame Page1/Page2 (CRUD) porque eh um popup modal
132:     * de selecao. A "pagina de lista" corresponde a montagem completa da tela:
133:     * cabecalho cinza, botao de confirmacao, grid de operacoes e controles de
134:     * status (checkbox marcar-todos + textboxes operacao/numero).
135:     *--------------------------------------------------------------------------
136:     PROTECTED PROCEDURE ConfigurarPaginaLista()
137:         THIS.ConfigurarCabecalho()
138:         THIS.ConfigurarSaida()
139:         THIS.ConfigurarGrade()
140:         THIS.ConfigurarPaginaDados()
141:     ENDPROC
142: 
143:     *--------------------------------------------------------------------------
144:     * ConfigurarPaginaDados - Controles de status/detalhe da selecao
145:     * Checkbox marcar-todos (ck_Marca), label+textbox da operacao corrente
146:     * (lbl_descricao + get_Operacao) e label+textbox do numero da operacao
147:     * (Say1 + get_Numes) ? todos na faixa inferior do popup (Top >= 398).
148:     *--------------------------------------------------------------------------
149:     PROTECTED PROCEDURE ConfigurarPaginaDados()
150:         THIS.AddObject("chk_4c_Ck_Marca", "CheckBox")
151:         WITH THIS.chk_4c_Ck_Marca
152:             .Top         = 123
153:             .Left        = 15
154:             .Width       = 13
155:             .Height      = 17
156:             .Caption     = ""
157:             .Value       = 1
158:             .Alignment   = 0
159:             .FontName    = "Tahoma"
160:             .FontSize    = 8
161:             .ToolTipText = "Marcar/Desmarcar todas as opera" + CHR(231) + CHR(245) + "es"
162:         ENDWITH
163: 
164:         THIS.AddObject("lbl_4c_Lbl_descricao", "Label")
165:         WITH THIS.lbl_4c_Lbl_descricao
166:             .AutoSize  = .T.
167:             .FontSize  = 8
168:             .FontName  = "Tahoma"
169:             .Alignment = 0
170:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
171:             .Height    = 15
172:             .Left      = 19
173:             .Top       = 402
174:             .Width     = 56
175:             .BackStyle = 0
176:         ENDWITH
177: 
178:         THIS.AddObject("txt_4c_Operacao", "TextBox")

*-- Linhas 188 a 213:
188:             .Height        = 25
189:             .MaxLength     = 40
190:             .SpecialEffect = 0
191:             .Left          = 87
192:             .Top           = 398
193:             .Width         = 150
194:             .ForeColor     = RGB(0,0,0)
195:             .BackColor     = RGB(255,255,255)
196:             .ReadOnly      = .T.
197:         ENDWITH
198: 
199:         THIS.AddObject("lbl_4c_Label1", "Label")
200:         WITH THIS.lbl_4c_Label1
201:             .AutoSize  = .T.
202:             .FontSize  = 8
203:             .FontName  = "Tahoma"
204:             .Alignment = 0
205:             .Caption   = "N" + CHR(186) + " :"
206:             .Height    = 15
207:             .Left      = 249
208:             .Top       = 402
209:             .Width     = 21
210:             .BackStyle = 0
211:         ENDWITH
212: 
213:         THIS.AddObject("txt_4c_Numes", "TextBox")

*-- Linhas 221 a 230:
221:             .ControlSource = "cursor_4c_Operacoes.Numes"
222:             .Height        = 25
223:             .SpecialEffect = 0
224:             .Left          = 276
225:             .Top           = 398
226:             .Width         = 50
227:             .ForeColor     = RGB(0,0,0)
228:             .BackColor     = RGB(255,255,255)
229:             .ReadOnly      = .T.
230:         ENDWITH

*-- Linhas 271 a 316:
271: 
272:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
273:         WITH THIS.cnt_4c_Cabecalho
274:             .Top         = 0
275:             .Left        = 0
276:             .Width       = THIS.Width
277:             .Height      = 80
278:             .BackStyle   = 1
279:             .BackColor   = RGB(100,100,100)
280:             .BorderWidth = 0
281: 
282:             .AddObject("lbl_4c_Sombra", "Label")
283:             WITH .lbl_4c_Sombra
284:                 .AutoSize  = .F.
285:                 .FontBold  = .T.
286:                 .FontName  = "Tahoma"
287:                 .FontSize  = 18
288:                 .WordWrap  = .T.
289:                 .Alignment = 0
290:                 .BackStyle = 0
291:                 .Caption   = loc_cTitulo
292:                 .Height    = 40
293:                 .Left      = 10
294:                 .Top       = 25
295:                 .Width     = THIS.Width
296:                 .ForeColor = RGB(0,0,0)
297:             ENDWITH
298: 
299:             .AddObject("lbl_4c_Titulo", "Label")
300:             WITH .lbl_4c_Titulo
301:                 .AutoSize  = .F.
302:                 .FontBold  = .T.
303:                 .FontName  = "Tahoma"
304:                 .FontSize  = 18
305:                 .WordWrap  = .T.
306:                 .Alignment = 0
307:                 .BackStyle = 0
308:                 .Caption   = loc_cTitulo
309:                 .Height    = 46
310:                 .Left      = 10
311:                 .Top       = 24
312:                 .Width     = THIS.Width
313:                 .ForeColor = RGB(255,255,255)
314:             ENDWITH
315:         ENDWITH
316:     ENDPROC

*-- Linhas 323 a 346:
323:     PROTECTED PROCEDURE ConfigurarSaida()
324:         THIS.AddObject("cnt_4c_Saida", "Container")
325:         WITH THIS.cnt_4c_Saida
326:             .Top         = 7
327:             .Left        = 917
328:             .Width       = 90
329:             .Height      = 110
330:             .BackStyle   = 0
331:             .BorderWidth = 0
332: 
333:             .AddObject("cmd_4c_Confirmar", "CommandButton")
334:             WITH .cmd_4c_Confirmar
335:                 .Top             = 5
336:                 .Left            = 917
337:                 .Width           = 90
338:                 .Height          = 75
339:                 .Caption         = "OK"
340:                 .FontName        = "Comic Sans MS"
341:                 .FontBold        = .T.
342:                 .FontItalic      = .T.
343:                 .FontSize        = 8
344:                 .ForeColor       = RGB(90,90,90)
345:                 .BackColor       = RGB(255,255,255)
346:                 .SpecialEffect   = 0

*-- Linhas 375 a 391:
375: 
376:     *--------------------------------------------------------------------------
377:     * ConfigurarGrade - Grid de selecao de operacoes (grdOperacoes do legado)
378:     * 7 colunas: selecao (checkbox), data, empresa, prev. entrega, cliente, nome, conjugue
379:     * Regras criticas: AddObject chk_4c_Check1 ANTES de CurrentControl,
380:     *   CurrentControl ANTES de ControlSource, Sparse=.F. obrigatorio.
381:     *--------------------------------------------------------------------------
382:     PROTECTED PROCEDURE ConfigurarGrade()
383:         THIS.AddObject("grd_4c_Dados", "Grid")
384:         WITH THIS.grd_4c_Dados
385:             .Top               = 121
386:             .Left              = 3
387:             .Width             = 732
388:             .Height            = 275
389:             .ColumnCount       = 7
390:             .FontName          = "Tahoma"
391:             .DeleteMark        = .F.

*-- Linhas 403 a 419:
403:                 .Resizable = .F.
404:                 .ReadOnly  = .F.
405:                 .Sparse    = .F.
406:                 .AddObject("chk_4c_Check1", "CheckBox")
407:                 WITH .chk_4c_Check1
408:                     .Caption  = ""
409:                     .Value    = 0
410:                     .AutoSize = .T.
411:                 ENDWITH
412:                 .CurrentControl    = "chk_4c_Check1"
413:                 .ControlSource     = "cursor_4c_Operacoes.Selecionada"
414:                 .Header1.Caption   = ""
415:                 .Header1.Alignment = 2
416:                 .Header1.ForeColor = RGB(90,90,90)
417:                 .Header1.FontName  = "Tahoma"
418:                 .Header1.FontSize  = 8
419:             ENDWITH

*-- Linhas 425 a 433:
425:                 .ReadOnly          = .T.
426:                 .FontName          = "Tahoma"
427:                 .ControlSource     = "cursor_4c_Operacoes.Datas"
428:                 .Header1.Caption   = "Data"
429:                 .Header1.Alignment = 2
430:                 .Header1.ForeColor = RGB(90,90,90)
431:                 .Header1.FontName  = "Tahoma"
432:                 .Header1.FontSize  = 8
433:             ENDWITH

*-- Linhas 439 a 447:
439:                 .ReadOnly          = .T.
440:                 .FontName          = "Tahoma"
441:                 .ControlSource     = "cursor_4c_Operacoes.Emps"
442:                 .Header1.Caption   = "Emp"
443:                 .Header1.Alignment = 2
444:                 .Header1.ForeColor = RGB(90,90,90)
445:                 .Header1.FontName  = "Tahoma"
446:                 .Header1.FontSize  = 8
447:             ENDWITH

*-- Linhas 453 a 461:
453:                 .ReadOnly          = .T.
454:                 .FontName          = "Tahoma"
455:                 .ControlSource     = "cursor_4c_Operacoes.PrazoEnts"
456:                 .Header1.Caption   = THIS.this_cCabData
457:                 .Header1.Alignment = 2
458:                 .Header1.ForeColor = RGB(90,90,90)
459:                 .Header1.FontName  = "Tahoma"
460:                 .Header1.FontSize  = 8
461:             ENDWITH

*-- Linhas 467 a 475:
467:                 .ReadOnly          = .T.
468:                 .FontName          = "Tahoma"
469:                 .ControlSource     = "cursor_4c_Operacoes.Contas"
470:                 .Header1.Caption   = "Cliente"
471:                 .Header1.Alignment = 2
472:                 .Header1.ForeColor = RGB(90,90,90)
473:                 .Header1.FontName  = "Tahoma"
474:                 .Header1.FontSize  = 8
475:             ENDWITH

*-- Linhas 481 a 489:
481:                 .ReadOnly          = .T.
482:                 .FontName          = "Tahoma"
483:                 .ControlSource     = "cursor_4c_Operacoes.RClis"
484:                 .Header1.Caption   = "Nome do Cliente"
485:                 .Header1.Alignment = 2
486:                 .Header1.ForeColor = RGB(90,90,90)
487:                 .Header1.FontName  = "Tahoma"
488:                 .Header1.FontSize  = 8
489:             ENDWITH

*-- Linhas 496 a 504:
496:                 .FontName          = "Tahoma"
497:                 .FontSize          = 9
498:                 .ControlSource     = "cursor_4c_Operacoes.Conjuges"
499:                 .Header1.Caption   = "Conjug" + CHR(233)
500:                 .Header1.Alignment = 2
501:                 .Header1.ForeColor = RGB(90,90,90)
502:                 .Header1.FontName  = "Tahoma"
503:                 .Header1.FontSize  = 8
504:             ENDWITH

*-- Linhas 803 a 824:
803: 
804:     *--------------------------------------------------------------------------
805:     * HabilitarCampos - Controla habilitacao de controles interativos
806:     * OPERACIONAL: grid e checkbox sao sempre interativos neste popup modal
807:     * par_lHabilitar: .T. = habilitar, .F. = desabilitar (default .T.)
808:     *--------------------------------------------------------------------------
809:     PROCEDURE HabilitarCampos(par_lHabilitar)
810:         LOCAL loc_lHabilitar
811:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
812:         IF VARTYPE(THIS.chk_4c_Ck_Marca) = "O"
813:             THIS.chk_4c_Ck_Marca.Enabled = loc_lHabilitar
814:         ENDIF
815:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
816:             THIS.grd_4c_Dados.Enabled = loc_lHabilitar
817:         ENDIF
818:         IF VARTYPE(THIS.cnt_4c_Saida) = "O"
819:             THIS.cnt_4c_Saida.cmd_4c_Confirmar.Enabled = loc_lHabilitar
820:         ENDIF
821:     ENDPROC
822: 
823:     *--------------------------------------------------------------------------
824:     * LimparCampos - Desmarca todas as operacoes (zera Selecionada no cursor)

*-- Linhas 843 a 851:
843:     *--------------------------------------------------------------------------
844:     PROCEDURE AjustarBotoesPorModo()
845:         IF VARTYPE(THIS.cnt_4c_Saida) = "O"
846:             THIS.cnt_4c_Saida.cmd_4c_Confirmar.Enabled = ;
847:                 USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
848:         ENDIF
849:     ENDPROC
850: 
851:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\SigPrEopBO.prg):
*==============================================================================
* SigPrEopBO.prg - Business Object: Selecao de Operacoes
* Entidade  : SigPrEop
* Tabela    : (sem tabela propria - opera com cursores temporarios)
* Tipo      : OPERACIONAL (seletor de operacoes)
*==============================================================================
DEFINE CLASS SigPrEopBO AS BusinessBase

    *-- Operacao selecionada (linha corrente no grid)
    this_cDopes      = ""  && Codigo da operacao (20 chars)
    this_nNumes      = 0   && Numero da operacao
    this_dDatas      = {}  && Data da operacao
    this_dPrazoEnts  = {}  && Previsao de entrega
    this_cEmps       = ""  && Codigo da empresa (3 chars)
    this_cContas     = ""  && Conta / numero do pedido
    this_cRClis      = ""  && Nome do cliente
    this_cConjuges   = ""  && Operacao conjugada
    this_nSelecionada = 0  && Flag de selecao (0=nao, 1=sim)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO de Selecao de Operacoes
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de linha do cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nSelecionada = NVL(Selecionada, 0)
            THIS.this_cDopes       = ALLTRIM(NVL(Dopes, ""))
            THIS.this_nNumes       = NVL(Numes, 0)
            THIS.this_dDatas       = NVL(Datas, {})
            THIS.this_dPrazoEnts   = NVL(PrazoEnts, {})
            THIS.this_cEmps        = ALLTRIM(NVL(Emps, ""))
            THIS.this_cContas      = ALLTRIM(NVL(Contas, ""))
            THIS.this_cRClis       = ALLTRIM(NVL(RClis, ""))
            THIS.this_cConjuges    = ALLTRIM(NVL(Conjuges, ""))
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarOperacoes - Cria cursor_4c_Operacoes a partir do cursor de origem
    * par_cCursorOrigem: nome do cursor com operacoes pre-carregadas (crTprMvCab)
    *--------------------------------------------------------------------------
    PROCEDURE InicializarOperacoes(par_cCursorOrigem)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF
            IF USED(par_cCursorOrigem)
                SELECT 1 AS Selecionada, * FROM (par_cCursorOrigem) ;
                    INTO CURSOR cursor_4c_Operacoes READWRITE
                loc_lSucesso = .T.
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_Operacoes ;
                    (Selecionada N(1,0) NULL, ;
                     Emps        C(3)   NULL, ;
                     Dopes       C(20)  NULL, ;
                     Numes       N(6,0) NULL, ;
                     Datas       D      NULL, ;
                     PrazoEnts   D      NULL, ;
                     Contas      C(20)  NULL, ;
                     RClis       C(60)  NULL, ;
                     Conjuges    C(20)  NULL)
                SET NULL OFF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarSelecao - Inverte o flag Selecionada da linha corrente do cursor
    * Equivalente ao GATHER MEMVAR do legado (Check1 KeyPress + MouseDown)
    * par_cAliasCursor: alias do cursor (padrao: cursor_4c_Operacoes)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarSelecao(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro, loc_nNovoValor, loc_cAlias
        loc_lSucesso = .F.
        loc_cAlias   = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Operacoes", par_cAliasCursor)
        TRY
            IF USED(loc_cAlias) AND !EOF(loc_cAlias)
                SELECT (loc_cAlias)
                loc_nNovoValor = IIF(Selecionada = 0, 1, 0)
                REPLACE Selecionada WITH loc_nNovoValor
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarDesmarcarTodos - Marca ou desmarca todas as operacoes
    * par_nValor: 1 = marcar todos, 0 = desmarcar todos (equivale a ck_Marca.Click)
    * par_cAliasCursor: alias do cursor (padrao: cursor_4c_Operacoes)
    *--------------------------------------------------------------------------
    PROCEDURE MarcarDesmarcarTodos(par_nValor, par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro, loc_cAlias
        loc_lSucesso = .F.
        loc_cAlias   = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Operacoes", par_cAliasCursor)
        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                REPLACE ALL Selecionada WITH par_nValor
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PopularFilOper - Varre cursor de operacoes e popula cursor destino
    * com as operacoes selecionadas (Selecionada = 1)
    * Equivalente ao SCAN em cmdSair.Click do legado
    * par_cCursorDest  : nome do cursor destino (crFilOper no legado)
    * par_cCursorOrigem: cursor fonte (padrao: cursor_4c_Operacoes)
    * Formato de cada registro: Emps(3) + Dopes(20) + Numes(6) = 29 chars
    *--------------------------------------------------------------------------
    PROCEDURE PopularFilOper(par_cCursorDest, par_cCursorOrigem)
        LOCAL loc_lSucesso, loc_oErro, loc_cAlias, loc_cChave
        loc_lSucesso = .F.
        loc_cAlias   = IIF(EMPTY(par_cCursorOrigem), "cursor_4c_Operacoes", par_cCursorOrigem)
        TRY
            IF USED(loc_cAlias) AND USED(par_cCursorDest)
                ZAP IN (par_cCursorDest)
                SELECT (loc_cAlias)
                GO TOP
                SCAN
                    IF Selecionada = 1
                        loc_cChave = PADR(Emps, 3) + PADR(Dopes, 20) + PADL(STR(Numes, 6), 6)
                        INSERT INTO (par_cCursorDest) VALUES (loc_cChave)
                    ENDIF
                ENDSCAN
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta da operacao corrente
    * Formato: Emps(3) + Dopes(20) + Numes(6) = 29 chars
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + PADL(STR(THIS.this_nNumes, 6), 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra as operacoes selecionadas no cursor destino (crFilOper)
    * BO OPERACIONAL de selecao: nao persiste em tabela SQL Server.
    * Equivalente ao SCAN em cmdSair.Click do legado que popula crFilOper com
    * as operacoes marcadas (Selecionada = 1) e serve de filtro para o form pai.
    * Requer THIS.this_cCursorDestino previamente configurado (default: crFilOper).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cCursorDest, loc_nRegistros, loc_lContinua
        loc_lSucesso    = .F.
        loc_lContinua   = .T.
        loc_nRegistros  = 0
        loc_cCursorDest = IIF(PEMSTATUS(THIS, "this_cCursorDestino", 5) AND ;
                              !EMPTY(THIS.this_cCursorDestino), ;
                              THIS.this_cCursorDestino, "crFilOper")

        TRY
            IF !USED("cursor_4c_Operacoes")
                THIS.this_cMensagemErro = "Cursor de opera" + CHR(231) + CHR(245) + ;
                    "es n" + CHR(227) + "o inicializado"
                loc_lContinua = .F.
            ENDIF

            IF loc_lContinua AND !USED(loc_cCursorDest)
                THIS.this_cMensagemErro = "Cursor destino '" + loc_cCursorDest + ;
                    "' n" + CHR(227) + "o encontrado"
                loc_lContinua = .F.
            ENDIF

            IF loc_lContinua AND !THIS.PopularFilOper(loc_cCursorDest, "cursor_4c_Operacoes")
                THIS.this_cMensagemErro = "Falha ao popular cursor destino"
                loc_lContinua = .F.
            ENDIF

            IF loc_lContinua
                SELECT (loc_cCursorDest)
                GO TOP
                COUNT TO loc_nRegistros

                IF loc_nRegistros = 0
                    THIS.this_cMensagemErro = "Nenhuma opera" + CHR(231) + CHR(227) + ;
                        "o foi selecionada"
                    loc_lContinua = .F.
                ENDIF
            ENDIF

            IF loc_lContinua
                THIS.RegistrarAuditoria("SELECT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza o estado de selecao da operacao corrente no cursor
    * BO OPERACIONAL de selecao: nao persiste em tabela SQL Server.
    * Equivalente ao GATHER MEMVAR Fields Selecionada do Check1 (KeyPress/MouseDown).
    * Usa this_nSelecionada (definido via CarregarDoCursor ou setter externo)
    * para atualizar o registro corrente do cursor de operacoes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_lContinua
        loc_lSucesso  = .F.
        loc_lContinua = .T.

        TRY
            IF !USED("cursor_4c_Operacoes")
                THIS.this_cMensagemErro = "Cursor de opera" + CHR(231) + CHR(245) + ;
                    "es n" + CHR(227) + "o inicializado"
                loc_lContinua = .F.
            ENDIF

            IF loc_lContinua
                SELECT cursor_4c_Operacoes
                IF EOF() OR BOF()
                    THIS.this_cMensagemErro = "Nenhuma opera" + CHR(231) + CHR(227) + ;
                        "o corrente para atualizar"
                    loc_lContinua = .F.
                ENDIF
            ENDIF

            IF loc_lContinua
                REPLACE Selecionada  WITH THIS.this_nSelecionada, ;
                        Emps         WITH THIS.this_cEmps, ;
                        Dopes        WITH THIS.this_cDopes, ;
                        Numes        WITH THIS.this_nNumes, ;
                        Datas        WITH THIS.this_dDatas, ;
                        PrazoEnts    WITH THIS.this_dPrazoEnts, ;
                        Contas       WITH THIS.this_cContas, ;
                        RClis        WITH THIS.this_cRClis, ;
                        Conjuges     WITH THIS.this_cConjuges

                THIS.RegistrarAuditoria("TOGGLE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Override para BO OPERACIONAL sem tabela
    * BO de selecao opera apenas em cursores de sessao (nao persiste em tabela).
    * Nao ha registro em LogAuditoria (this_cTabela vazio inviabiliza SQL de log).
    * Metodo mantido para preservar contrato com BusinessBase.Salvar/Excluir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

ENDDEFINE

