# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 141: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 172: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrMlu.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (923 linhas total):

*-- Linhas 4 a 12:
4: * Migrado de SIGPRMLU.SCX
5: *
6: * Pilares:
7: *   UX   -> header cinza, grid 6 colunas, checkbox selecao, processar/encerrar
8: *   BD   -> cursor_4c_Itn (SigMlItn via SigPrMluBO.BuscarMalas)
9: *   CODE -> arquitetura em camadas (FormBase / SigPrMluBO)
10: *==============================================================================
11: 
12: DEFINE CLASS FormSigPrMlu AS FormBase

*-- Linhas 42 a 50:
42:         loc_lSucesso = .F.
43: 
44:         TRY
45:             THIS.Caption = "Unifica" + CHR(231) + CHR(227) + "o de Mala Direta"
46: 
47:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
48:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
49:             ENDIF
50: 

*-- Linhas 81 a 182:
81:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
82:         loc_oCab = THIS.cnt_4c_Cabecalho
83:         WITH loc_oCab
84:             .Top         = 0
85:             .Left        = 0
86:             .Width       = 1020
87:             .Height      = 80
88:             .BorderWidth = 0
89:             .BackStyle   = 1
90:             .BackColor   = RGB(100, 100, 100)
91:         ENDWITH
92:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
93:         WITH loc_oCab.lbl_4c_Sombra
94:             .AutoSize      = .F.
95:             .Top           = 18
96:             .Left          = 10
97:             .Width         = 1000
98:             .Height        = 40
99:             .FontBold      = .T.
100:             .FontName      = "Tahoma"
101:             .FontSize      = 18
102:             .FontUnderline = .F.
103:             .WordWrap      = .T.
104:             .Alignment     = 0
105:             .BackStyle     = 0
106:             .ForeColor     = RGB(0, 0, 0)
107:             .Caption       = "Unifica" + CHR(231) + CHR(227) + "o de Mala Direta"
108:         ENDWITH
109:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
110:         WITH loc_oCab.lbl_4c_Titulo
111:             .AutoSize      = .F.
112:             .Top           = 17
113:             .Left          = 10
114:             .Width         = 1000
115:             .Height        = 46
116:             .FontBold      = .T.
117:             .FontName      = "Tahoma"
118:             .FontSize      = 18
119:             .FontUnderline = .F.
120:             .WordWrap      = .T.
121:             .Alignment     = 0
122:             .BackStyle     = 0
123:             .ForeColor     = RGB(255, 255, 255)
124:             .Caption       = "Unifica" + CHR(231) + CHR(227) + "o de Mala Direta"
125:         ENDWITH
126:     ENDPROC
127: 
128:     *==========================================================================
129:     PROTECTED PROCEDURE ConfigurarBotoes
130:     *==========================================================================
131:         LOCAL loc_oCnt
132:         *-- Botao Processar (standalone com icone 60px, Themes=.T. + DisabledPicture obrigatorios)
133:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
134:         WITH THIS.cmd_4c_Processar
135:             .Top             = 5
136:             .Left            = 828
137:             .Height          = 75
138:             .Width           = 75
139:             .FontBold        = .T.
140:             .FontItalic      = .T.
141:             .FontName        = "Comic Sans MS"
142:             .FontSize        = 8
143:             .WordWrap        = .T.
144:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
145:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
146:             .Caption         = "\<Processar"
147:             .ToolTipText     = "[Alt+P] Processar Unifica" + CHR(231) + CHR(227) + "o"
148:             .ForeColor       = RGB(90, 90, 90)
149:             .BackColor       = RGB(255, 255, 255)
150:             .Themes          = .T.
151:         ENDWITH
152: 
153:         *-- Container canonico Encerrar (Left=917, Width=90, Height=85)
154:         THIS.AddObject("cnt_4c_Saida", "Container")
155:         loc_oCnt = THIS.cnt_4c_Saida
156:         WITH loc_oCnt
157:             .Top         = -2
158:             .Left        = 917
159:             .Width       = 90
160:             .Height      = 85
161:             .BorderWidth = 0
162:             .BackStyle   = 0
163:         ENDWITH
164:         loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
165:         WITH loc_oCnt.cmd_4c_Encerrar
166:             .Top         = 5
167:             .Left        = 5
168:             .Height      = 75
169:             .Width       = 75
170:             .FontBold    = .T.
171:             .FontItalic  = .T.
172:             .FontName    = "Comic Sans MS"
173:             .FontSize    = 8
174:             .WordWrap    = .T.
175:             .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
176:             .Cancel      = .T.
177:             .Caption     = "Encerrar"
178:             .ToolTipText = "[Esc] Encerrar"
179:             .ForeColor   = RGB(90, 90, 90)
180:             .BackColor   = RGB(255, 255, 255)
181:             .Themes      = .F.
182:         ENDWITH

*-- Linhas 190 a 227:
190:         THIS.AddObject("cnt_4c_Nova", "Container")
191:         loc_oCnt = THIS.cnt_4c_Nova
192:         WITH loc_oCnt
193:             .Top         = 92
194:             .Left        = 15
195:             .Width       = 800
196:             .Height      = 42
197:             .BackStyle   = 0
198:             .BorderWidth = 0
199:         ENDWITH
200:         loc_oCnt.AddObject("lbl_4c_Nome", "Label")
201:         WITH loc_oCnt.lbl_4c_Nome
202:             .AutoSize  = .T.
203:             .FontBold  = .T.
204:             .FontName  = "Tahoma"
205:             .FontSize  = 8
206:             .BackStyle = 0
207:             .Caption   = " \<Nome da Unifica" + CHR(231) + CHR(227) + "o :"
208:             .Height    = 15
209:             .Left      = 20
210:             .Top       = 13
211:             .ForeColor = RGB(90, 90, 90)
212:         ENDWITH
213:         loc_oCnt.AddObject("txt_4c_GetNova", "TextBox")
214:         WITH loc_oCnt.txt_4c_GetNova
215:             .FontName          = "Courier New"
216:             .FontSize          = 9
217:             .Format            = "K"
218:             .Height            = 25
219:             .Left              = 155
220:             .MaxLength         = 20
221:             .TabIndex          = 1
222:             .Top               = 8
223:             .Width             = 220
224:             .DisabledBackColor = RGB(255, 255, 255)
225:             .DisabledForeColor = RGB(0, 0, 128)
226:             .Value             = ""
227:         ENDWITH

*-- Linhas 234 a 243:
234:     *==========================================================================
235:         THIS.AddObject("grd_4c_Selecoes", "Grid")
236:         WITH THIS.grd_4c_Selecoes
237:             .Top                = 140
238:             .Left               = 15
239:             .Width              = 870
240:             .Height             = 420
241:             .RecordMark         = .F.
242:             .DeleteMark         = .F.
243:             .RowHeight          = 16

*-- Linhas 251 a 275:
251:             .GridLineColor      = RGB(238, 238, 238)
252:             .ColumnCount        = 6
253: 
254:             *-- Column1: CheckBox de selecao (SelImp)
255:             WITH .Column1
256:                 .ColumnOrder   = 1
257:                 .Width         = 20
258:                 .Movable       = .F.
259:                 .Resizable     = .F.
260:                 .ReadOnly      = .F.
261:                 WITH .Header1
262:                     .Caption   = ""
263:                     .Alignment = 2
264:                     .FontName  = "Tahoma"
265:                     .FontSize  = 8
266:                     .ForeColor = RGB(36, 84, 155)
267:                 ENDWITH
268:                 .AddObject("ctlCheck1", "CheckBox")
269:                 WITH .ctlCheck1
270:                     .Caption   = ""
271:                     .Alignment = 0
272:                     .AutoSize  = .T.
273:                     .FontName  = "Tahoma"
274:                     .FontSize  = 8
275:                     .Value     = 0

*-- Linhas 286 a 294:
286:                 .Resizable     = .F.
287:                 .ReadOnly      = .T.
288:                 WITH .Header1
289:                     .Caption   = "C" + CHR(243) + "digo"
290:                     .Alignment = 2
291:                     .FontName  = "Tahoma"
292:                     .FontSize  = 8
293:                     .ForeColor = RGB(36, 84, 155)
294:                 ENDWITH

*-- Linhas 311 a 319:
311:                 .Resizable     = .F.
312:                 .ReadOnly      = .T.
313:                 WITH .Header1
314:                     .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
315:                     .Alignment = 2
316:                     .FontName  = "Tahoma"
317:                     .FontSize  = 8
318:                     .ForeColor = RGB(36, 84, 155)
319:                 ENDWITH

*-- Linhas 336 a 344:
336:                 .Resizable     = .F.
337:                 .ReadOnly      = .T.
338:                 WITH .Header1
339:                     .Caption   = "Usu" + CHR(225) + "rio"
340:                     .Alignment = 2
341:                     .FontName  = "Tahoma"
342:                     .FontSize  = 8
343:                     .ForeColor = RGB(36, 84, 155)
344:                 ENDWITH

*-- Linhas 361 a 369:
361:                 .Resizable     = .F.
362:                 .ReadOnly      = .T.
363:                 WITH .Header1
364:                     .Caption   = "Dt.Entrada"
365:                     .Alignment = 2
366:                     .FontName  = "Tahoma"
367:                     .FontSize  = 8
368:                     .ForeColor = RGB(36, 84, 155)
369:                 ENDWITH

*-- Linhas 386 a 394:
386:                 .Resizable     = .F.
387:                 .ReadOnly      = .T.
388:                 WITH .Header1
389:                     .Caption   = "N.Registros"
390:                     .Alignment = 2
391:                     .FontName  = "Tahoma"
392:                     .FontSize  = 8
393:                     .ForeColor = RGB(36, 84, 155)
394:                 ENDWITH

*-- Linhas 411 a 474:
411:     *-- Posicionados abaixo e a direita da grade
412:     *==========================================================================
413:         *-- Botao Selecionar Tudo
414:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
415:         WITH THIS.cmd_4c_SelTudo
416:             .Top         = 265
417:             .Left        = 892
418:             .Height      = 40
419:             .Width       = 40
420:             .FontName    = "Verdana"
421:             .FontSize    = 8
422:             .WordWrap    = .T.
423:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
424:             .Caption     = ""
425:             .TabStop     = .F.
426:             .ToolTipText = "Selecionar Tudo"
427:             .ForeColor   = RGB(36, 84, 155)
428:             .BackColor   = RGB(255, 255, 255)
429:             .Themes      = .T.
430:         ENDWITH
431: 
432:         *-- Botao Desmarcar Tudo
433:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
434:         WITH THIS.cmd_4c_Apaga
435:             .Top         = 310
436:             .Left        = 892
437:             .Height      = 40
438:             .Width       = 40
439:             .FontName    = "Verdana"
440:             .FontSize    = 8
441:             .WordWrap    = .T.
442:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
443:             .Caption     = ""
444:             .TabStop     = .F.
445:             .ToolTipText = "Desmarcar Tudo"
446:             .ForeColor   = RGB(36, 84, 155)
447:             .BackColor   = RGB(255, 255, 255)
448:             .Themes      = .T.
449:         ENDWITH
450:     ENDPROC
451: 
452:     *==========================================================================
453:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
454:     *==========================================================================
455:         *-- Botoes principais
456:         BINDEVENT(THIS.cmd_4c_Processar,              "Click", THIS, "BtnProcessarClick")
457:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
458: 
459:         *-- Botoes de selecao de grade
460:         BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelecionarTudoClick")
461:         BINDEVENT(THIS.cmd_4c_Apaga,   "Click", THIS, "BtnDesmarcarTudoClick")
462: 
463:         *-- Cliques nos cabecalhos para ordenacao
464:         BINDEVENT(THIS.grd_4c_Selecoes.Column2.Header1, "Click", THIS, "Col2HeaderClick")
465:         BINDEVENT(THIS.grd_4c_Selecoes.Column3.Header1, "Click", THIS, "Col3HeaderClick")
466:         BINDEVENT(THIS.grd_4c_Selecoes.Column4.Header1, "Click", THIS, "Col4HeaderClick")
467:         BINDEVENT(THIS.grd_4c_Selecoes.Column5.Header1, "Click", THIS, "Col5HeaderClick")
468: 
469:         *-- CheckBox de selecao individual: MouseDown + KeyPress
470:         BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "MouseDown", THIS, "GrdChkMouseDown")
471:         BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "KeyPress",  THIS, "GrdChkKeyPress")
472:         BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "Click",     THIS, "GrdChkClick")
473:     ENDPROC
474: 

*-- Linhas 589 a 599:
589:     *
590:     * Este form nao segue o padrao Page1=Lista/Page2=Dados.
591:     * Grid e botoes sao criados diretamente via:
592:     *   ConfigurarGrade()    ? grd_4c_Selecoes (6 colunas, checkbox SelImp)
593:     *   ConfigurarBotoes()   ? cmd_4c_Processar + cnt_4c_Saida/cmd_4c_Encerrar
594:     *   ConfigurarBtnGrade() ? cmd_4c_SelTudo + cmd_4c_Apaga
595:     * Todos chamados em InicializarForm().
596:     *==========================================================================
597:     PROTECTED PROCEDURE ConfigurarPageFrame()
598:         *-- OPERACIONAL: sem PageFrame; controles criados diretamente em InicializarForm
599:         RETURN .T.

*-- Linhas 637 a 646:
637:         loc_lOk = .F.
638:         loc_cNome = ""
639: 
640:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
641:             THIS.cmd_4c_Processar.Enabled = .F.
642:         ENDIF
643: 
644:         TRY
645:             IF !USED("cursor_4c_Itn")
646:                 MsgAviso("Nenhuma mala direta carregada.", "Processar")

*-- Linhas 708 a 717:
708:             MsgErro(loc_oErro.Message, "Erro BtnProcessarClick")
709:         ENDTRY
710: 
711:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
712:             THIS.cmd_4c_Processar.Enabled = .T.
713:         ENDIF
714:     ENDPROC
715: 
716:     PROCEDURE BtnEncerrarClick()
717:         THIS.Release()

*-- Linhas 763 a 771:
763:         ENDIF
764:     ENDPROC
765: 
766:     *-- MouseDown: toggle SelImp do registro corrente (equivale ao CheckBox original)
767:     PROCEDURE GrdChkMouseDown
768:         LPARAMETERS par_nButton, par_nShift, par_nXCoord, par_nYCoord
769:         LOCAL loc_nSel
770:         IF USED("cursor_4c_Itn")
771:             loc_nSel = IIF(cursor_4c_Itn.SelImp = 1, 0, 1)

*-- Linhas 869 a 878:
869:         IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
870:             THIS.cnt_4c_Nova.txt_4c_GetNova.Enabled = par_lHabilitar
871:         ENDIF
872:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
873:             THIS.cmd_4c_Processar.Enabled = par_lHabilitar
874:         ENDIF
875:     ENDPROC
876: 
877:     *==========================================================================
878:     * LimparCampos - limpa campo nome e desmarca todas as selecoes da grade

*-- Linhas 894 a 903:
894:     *==========================================================================
895:     PROTECTED PROCEDURE AjustarBotoesPorModo()
896:         *-- OPERACIONAL: habilita Processar somente se BO inicializado
897:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
898:             THIS.cmd_4c_Processar.Enabled = (VARTYPE(THIS.this_oBusinessObject) = "O")
899:         ENDIF
900:     ENDPROC
901: 
902:     *==========================================================================
903:     * BtnBuscarClick - recarrega a lista de malas diretas do servidor


### BO (C:\4c\projeto\app\classes\SigPrMluBO.prg):
*==============================================================================
* SigPrMluBO.prg - Business Object: Unificacao de Mala Direta
* Tabela principal: SigMlItn (lista de malas para unificacao)
* Tabela secundaria: SigMlCab (membros/destinatarios das malas)
*==============================================================================
DEFINE CLASS SigPrMluBO AS BusinessBase

    *-- Propriedades do registro SigMlItn gerado pela unificacao
    this_cCodigos        = ""   && char(10) PK - codigo gerado via SYS(2015)
    this_cDescs          = ""   && char(30) - nome da unificacao digitado pelo usuario
    this_cUsuIns         = ""   && char(10) - usuario que executou
    this_nNRegis         = 0    && numeric(8,0) - qtd de registros unificados (apos dedup)
    this_cEspelhos       = ""   && char(8)  - sempre 'SigPrMlu'
    this_cUnificas       = ""   && text     - lista de codigos unificados (sep '; ')

    *-- Controle interno do processamento
    this_nTotalMalas     = 0    && qtd de malas selecionadas (SelImp=1 AND NRegis>0)
    this_nTotalRegistros = 0    && total bruto de registros antes da deduplicacao

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "SigMlItn"
        this_cCampoChave = "Codigos"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna PK do registro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - mapeia cursor_4c_Itn para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos  = NVL(Codigos,  "")
            THIS.this_cDescs    = NVL(Descs,    "")
            THIS.this_cUsuIns   = NVL(Usuins,   "")
            THIS.this_nNRegis   = NVL(Nregis,   0)
            THIS.this_cEspelhos = NVL(Espelhos, "")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarMalas - carrega SigMlItn em cursor_4c_Itn com SelImp=0
    * Equivale ao MontaGrades + Requery do legado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarMalas()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Itn")
                TABLEREVERT(.T., "cursor_4c_Itn")
                USE IN cursor_4c_Itn
            ENDIF
            IF USED("cursor_4c_ItnTemp")
                USE IN cursor_4c_ItnTemp
            ENDIF

            loc_cSQL = "SELECT Codigos, Descs, UsuIns, DatIns, NRegis, Espelhos " + ;
                       "FROM SigMlItn ORDER BY Descs"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnTemp") > 0
                SET NULL ON
                CREATE CURSOR cursor_4c_Itn ( ;
                    SelImp   N(1,0) NULL, ;
                    Codigos  C(10)  NULL, ;
                    Descs    C(30)  NULL, ;
                    Usuins   C(10)  NULL, ;
                    Datins   T      NULL, ;
                    Nregis   N(8,0) NULL, ;
                    Espelhos C(8)   NULL  ;
                )
                SET NULL OFF

                INDEX ON Codigos TAG Codigos
                INDEX ON Descs   TAG Descs
                INDEX ON Usuins  TAG Usuins
                INDEX ON Datins  TAG Datins

                SELECT cursor_4c_Itn
                APPEND FROM DBF("cursor_4c_ItnTemp")
                REPLACE ALL SelImp WITH 0

                USE IN cursor_4c_ItnTemp
                GO TOP IN cursor_4c_Itn
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lista de Malas Diretas.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarUnificacao - unifica malas selecionadas (SelImp=1) em uma nova
    * par_cNomeUnificacao - nome digitado pelo usuario para a nova mala
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarUnificacao(par_cNomeUnificacao)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cNew, loc_lcUni, loc_lnTot, loc_nMalas, loc_pCod, loc_cSQL
        LOCAL loc_lInsertOk

        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Itn")
                MsgAviso("Grade de malas n" + CHR(227) + "o carregada.", "Aviso")
            ELSE
                *-- Conta malas com registros selecionadas
                loc_nMalas = 0
                SELECT COUNT(*) AS nSel FROM cursor_4c_Itn ;
                    WHERE SelImp = 1 INTO CURSOR cursor_4c_ContSel READWRITE
                IF USED("cursor_4c_ContSel")
                    SELECT cursor_4c_ContSel
                    loc_nMalas = NVL(nSel, 0)
                    USE IN cursor_4c_ContSel
                ENDIF

                IF loc_nMalas < 1
                    MsgAviso("Nenhuma Mala Direta com Registros foi Selecionada para Unifica" + ;
                             CHR(231) + CHR(227) + "o!", "Aviso")
                ELSE
                    IF loc_nMalas = 1
                    MsgAviso("Selecione ao menos duas Malas Diretas para Unificar.", "Aviso")
                ELSE
                    *-- Gera novo codigo para a mala unificada
                    loc_cNew  = SUBSTR(SYS(2015), 3, 10)
                    loc_lcUni = ""
                    loc_lnTot = 0

                    *-- Cursor acumulador de TODOS os registros das malas selecionadas
                    SET NULL ON
                    CREATE CURSOR cursor_4c_MalaDup ( ;
                        Cidchaves C(20) NULL, IClis    C(10)  NULL, Codigos  C(10)  NULL, ;
                        Bairs     C(40) NULL, Ceps     C(9)   NULL, Compls   C(25)  NULL, ;
                        Estas     C(2)  NULL, Faxs     C(20)  NULL, Grupos   C(10)  NULL, ;
                        Mes       C(2)  NULL, Nums     C(10)  NULL, Rclis    C(50)  NULL, ;
                        Tel1S     C(20) NULL, Tel2S    C(20)  NULL, Cidas    C(30)  NULL, ;
                        Endes     C(60) NULL, Nascs    T      NULL, Profiss  C(20)  NULL, ;
                        Sexos     C(1)  NULL, Ultcomps T      NULL, Aptos    N(6,0) NULL, ;
                        Opdest    N(1,0) NULL, Desti   C(50)  NULL, Opini    N(1,0) NULL, ;
                        Dtncons   T     NULL, Conjuges C(60)  NULL, Dtcasas  T      NULL, ;
                        Situas    C(3)  NULL, Dataincs T      NULL, Opani    N(1,0) NULL, ;
                        Quebras   C(40) NULL, Cpfs     C(20)  NULL, ;
                        ChaveUnica C(200) NULL ;
                    )
                    SET NULL OFF

                    *-- Acumula registros de cada mala selecionada via SQLEXEC
                    SELECT cursor_4c_Itn
                    SCAN FOR SelImp = 1
                        loc_pCod  = RTRIM(cursor_4c_Itn.Codigos)
                        loc_lcUni = loc_lcUni + loc_pCod + "; "

                        loc_cSQL = "SELECT Cidchaves, IClis, Codigos, Bairs, Ceps, Compls, " + ;
                                   "Estas, Faxs, Grupos, Mes, Nums, Rclis, Tel1S, Tel2S, " + ;
                                   "Cidas, Endes, Nascs, Profiss, Sexos, Ultcomps, Aptos, " + ;
                                   "Opdest, Desti, Opini, Dtncons, Conjuges, Dtcasas, " + ;
                                   "Situas, Dataincs, Opani, Quebras, Cpfs " + ;
                                   "FROM SigMlCab WHERE Codigos = " + EscaparSQL(loc_pCod)

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MlaTemp") > 0
                            loc_lnTot = loc_lnTot + RECCOUNT("cursor_4c_MlaTemp")
                            SELECT cursor_4c_MalaDup
                            APPEND FROM DBF("cursor_4c_MlaTemp")
                            USE IN cursor_4c_MlaTemp
                        ENDIF
                    ENDSCAN

                    *-- Calcula ChaveUnica de deduplicacao para todos os registros
                    SELECT cursor_4c_MalaDup
                    REPLACE ALL ChaveUnica WITH ;
                        PADR(UPPER(STRTRAN( ;
                            RTRIM(NVL(Desti,  "")) + ;
                            RTRIM(NVL(Ceps,   "")) + ;
                            RTRIM(NVL(Endes,  "")) + ;
                            RTRIM(NVL(Nums,   "")) + ;
                            RTRIM(NVL(Compls, "")), " ", "")), 200)

                    *-- Cursor de destino: apenas registros unicos
                    SET NULL ON
                    CREATE CURSOR cursor_4c_MalaUni ( ;
                        Cidchaves C(20) NULL, IClis    C(10)  NULL, Codigos  C(10)  NULL, ;
                        Bairs     C(40) NULL, Ceps     C(9)   NULL, Compls   C(25)  NULL, ;
                        Estas     C(2)  NULL, Faxs     C(20)  NULL, Grupos   C(10)  NULL, ;
                        Mes       C(2)  NULL, Nums     C(10)  NULL, Rclis    C(50)  NULL, ;
                        Tel1S     C(20) NULL, Tel2S    C(20)  NULL, Cidas    C(30)  NULL, ;
                        Endes     C(60) NULL, Nascs    T      NULL, Profiss  C(20)  NULL, ;
                        Sexos     C(1)  NULL, Ultcomps T      NULL, Aptos    N(6,0) NULL, ;
                        Opdest    N(1,0) NULL, Desti   C(50)  NULL, Opini    N(1,0) NULL, ;
                        Dtncons   T     NULL, Conjuges C(60)  NULL, Dtcasas  T      NULL, ;
                        Situas    C(3)  NULL, Dataincs T      NULL, Opani    N(1,0) NULL, ;
                        Quebras   C(40) NULL, Cpfs     C(20)  NULL, ;
                        ChaveUnica C(200) NULL ;
                    )
                    SET NULL OFF

                    SELECT cursor_4c_MalaUni
                    INDEX ON ChaveUnica TAG idxmalauni

                    *-- Deduplicacao: copia apenas registros com ChaveUnica nova
                    SELECT cursor_4c_MalaDup
                    GO TOP
                    SCAN
                        IF !SEEK(cursor_4c_MalaDup.ChaveUnica, "cursor_4c_MalaUni", "idxmalauni")
                            SCATTER MEMVAR MEMO
                            SELECT cursor_4c_MalaUni
                            APPEND BLANK
                            GATHER MEMVAR MEMO
                            SELECT cursor_4c_MalaDup
                        ENDIF
                    ENDSCAN

                    *-- Insere registros deduplicados no SQL Server SigMlCab
                    loc_lInsertOk = .T.
                    SELECT cursor_4c_MalaUni
                    GO TOP
                    SCAN
                        loc_cSQL = THIS.GerarSQLInsertSigMlCab(loc_cNew)
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Erro ao inserir registro na Mala Direta unificada.", "Erro")
                            loc_lInsertOk = .F.
                            EXIT
                        ENDIF
                    ENDSCAN

                    IF loc_lInsertOk
                        *-- Atualiza propriedades e persiste SigMlItn
                        THIS.this_cCodigos        = loc_cNew
                        THIS.this_cDescs          = LEFT(ALLTRIM(par_cNomeUnificacao), 30)
                        THIS.this_cUsuIns         = ALLTRIM(gc_4c_UsuarioLogado)
                        THIS.this_nNRegis         = RECCOUNT("cursor_4c_MalaUni")
                        THIS.this_cEspelhos       = "SigPrMlu"
                        THIS.this_cUnificas       = loc_lcUni
                        THIS.this_nTotalMalas     = loc_nMalas
                        THIS.this_nTotalRegistros = loc_lnTot

                        IF THIS.Inserir()
                            MsgInfo( ;
                                "Unifica" + CHR(231) + CHR(227) + "o '" + ;
                                ALLTRIM(par_cNomeUnificacao) + "' Conclu" + CHR(237) + "da!" + CHR(13) + ;
                                "Foram Selecionados " + ALLTRIM(STR(THIS.this_nNRegis)) + " Registros," + CHR(13) + ;
                                "Retirados de " + ALLTRIM(STR(loc_nMalas)) + " Malas Diretas," + CHR(13) + ;
                                "Que Continham Um Total de " + ALLTRIM(STR(loc_lnTot)) + " Registros.", ;
                                "Unifica" + CHR(231) + CHR(227) + "o")
                            THIS.BuscarMalas()
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        *-- Limpa cursores de trabalho (fora do TRY para sempre executar)
        IF USED("cursor_4c_MalaDup")
            USE IN cursor_4c_MalaDup
        ENDIF
        IF USED("cursor_4c_MalaUni")
            USE IN cursor_4c_MalaUni
        ENDIF
        IF USED("cursor_4c_MlaTemp")
            USE IN cursor_4c_MlaTemp
        ENDIF
        IF USED("cursor_4c_ContSel")
            USE IN cursor_4c_ContSel
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarSQLInsertSigMlCab - monta SQL INSERT para um registro de SigMlCab
    * Cursor_4c_MalaUni deve estar posicionado no registro a inserir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarSQLInsertSigMlCab(par_cNovoCodigos)
        LOCAL loc_cSQL, loc_cCidChaves

        loc_cCidChaves = fUniqueIds()

        *-- Monta INSERT parte a parte para clareza
        loc_cSQL = "INSERT INTO SigMlCab " + ;
                   "(CidChaves, Codigos, IClis, Bairs, Ceps, Compls, Estas, Faxs, Grupos, " + ;
                   "Mes, Nums, Rclis, Tel1S, Tel2S, Cidas, Endes, Nascs, Profiss, " + ;
                   "Sexos, Ultcomps, Aptos, Opdest, Desti, Opini, Dtncons, Conjuges, " + ;
                   "Dtcasas, Situas, Dataincs, Opani, Quebras, Cpfs, DesDtCom, TelDtCom) " + ;
                   "VALUES (" + ;
                   EscaparSQL(loc_cCidChaves) + ", " + ;
                   EscaparSQL(par_cNovoCodigos) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.IClis,    ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Bairs,    ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Ceps,     ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Compls,   ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Estas,    ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Faxs,     ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Grupos,   ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Mes,      ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Nums,     ""))) + ", " + ;
                   EscaparSQL(LEFT(RTRIM(NVL(cursor_4c_MalaUni.Rclis,"")),50)) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Tel1S,    ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Tel2S,    ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Cidas,    ""))) + ", " + ;
                   EscaparSQL(LEFT(RTRIM(NVL(cursor_4c_MalaUni.Endes,"")),60)) + ", " + ;
                   FormatarDataSQL(cursor_4c_MalaUni.Nascs) + ", " + ;
                   EscaparSQL(LEFT(RTRIM(NVL(cursor_4c_MalaUni.Profiss,"")),20)) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Sexos,    ""))) + ", " + ;
                   FormatarDataSQL(cursor_4c_MalaUni.Ultcomps) + ", " + ;
                   FormatarNumeroSQL(NVL(cursor_4c_MalaUni.Aptos,  0), 0) + ", " + ;
                   FormatarNumeroSQL(NVL(cursor_4c_MalaUni.Opdest, 0), 0) + ", " + ;
                   EscaparSQL(LEFT(RTRIM(NVL(cursor_4c_MalaUni.Desti,  "")),50)) + ", " + ;
                   FormatarNumeroSQL(NVL(cursor_4c_MalaUni.Opini,  0), 0) + ", " + ;
                   FormatarDataSQL(cursor_4c_MalaUni.Dtncons) + ", " + ;
                   EscaparSQL(LEFT(RTRIM(NVL(cursor_4c_MalaUni.Conjuges,"")),60)) + ", " + ;
                   FormatarDataSQL(cursor_4c_MalaUni.Dtcasas) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Situas,  ""))) + ", " + ;
                   FormatarDataSQL(cursor_4c_MalaUni.Dataincs) + ", " + ;
                   FormatarNumeroSQL(NVL(cursor_4c_MalaUni.Opani,  0), 0) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Quebras, ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Cpfs,    ""))) + ", " + ;
                   "'', '')"

        RETURN loc_cSQL
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT novo registro SigMlItn no SQL Server
    * SigMlItn tem ~80 colunas NOT NULL; filtros de selecao recebem valores
    * neutros (' '/0/0) pois este registro e produto da unificacao, nao filtro.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cCols1, loc_cCols2, loc_cCols3, loc_cCols4
        LOCAL loc_cVals1, loc_cVals2, loc_cVals3, loc_cVals4
        LOCAL loc_cCidChaves

        loc_lSucesso = .F.
        TRY
            loc_cCidChaves = fUniqueIds()

            *-- Bloco 1: colunas com valores reais do processo de unificacao
            loc_cCols1 = "Codigos, Descs, Ativos, UsuIns, UsuAlts, DatIns, NRegis, " + ;
                         "Espelhos, Unificas, CidChaves"
            loc_cVals1 = EscaparSQL(THIS.this_cCodigos) + ", " + ;
                         EscaparSQL(LEFT(THIS.this_cDescs, 30)) + ", 1, " + ;
                         EscaparSQL(LEFT(THIS.this_cUsuIns, 10)) + ", " + ;
                         "'', GETDATE(), " + ;
                         FormatarNumeroSQL(THIS.this_nNRegis, 0) + ", " + ;
                         "'SigPrMlu', " + ;
                         EscaparSQL(THIS.this_cUnificas) + ", " + ;
                         EscaparSQL(loc_cCidChaves)

            *-- Bloco 2: colunas char NOT NULL de criterios de filtro (vazias)
            loc_cCols2 = ", DEmps, Cadas, Cemps, CepFs, CepIs, Cidades, Ests, FaixaFs, FaixaIs, " + ;
                         "Nomes, Profs, RSocs, AnivFs, AnivIs, LinHas, TabUfs, BairS, Estados, " + ;
                         "Vends, CParents, Paises, Dopes, Conjuge, Situa, ClassiFis, ClassiFSs, " + ;
                         "RegIFs, RegIIs"
            loc_cVals2 = ", '', '', '', '', '', '', '', '', '', " + ;
                         "'', '', '', '', '', '', '', '', '', " + ;
                         "'', '', '', '', '', '', '', '', " + ;
                         "'', ''"

            *-- Bloco 3: colunas numericas NOT NULL de criterios de filtro (zero)
            loc_cCols3 = ", DestIs, OPSexS, OptCepS, OptNrS, OptUltS, Situas, OPSitua, OPAnis, " + ;
                         "OPCivis, OpenDes, OptLmk, OPIdade, EnDigual, ValosF, ValosI, IdadeFs, IdadeIs"
            loc_cVals3 = ", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0"

            *-- Bloco 4: colunas bit NOT NULL de criterios de filtro (zero)
            loc_cCols4 = ", CkAnis, CkCads, CkCepS, CkCidS, CkEmpS, CkEsts, CkFNoms, CkNomes, CkProfs, " + ;
                         "CkRSocs, CkSexS, CkUlts, CkClas, CkSituas, CkRegis, CkSitua, CkCivils, " + ;
                         "CkDtEnts, CkLinhas, CkBairs, CkVends, CkIdade, CkDtAtus, CkTlMk, CkNComp, " + ;
                         "CkUltCom, CkPais, CkMov, CkConjuge"
            loc_cVals4 = ", 0, 0, 0, 0, 0, 0, 0, 0, 0, " + ;
                         "0, 0, 0, 0, 0, 0, 0, 0, " + ;
                         "0, 0, 0, 0, 0, 0, 0, 0, " + ;
                         "0, 0, 0, 0"

            loc_cSQL = "INSERT INTO SigMlItn (" + ;
                       loc_cCols1 + loc_cCols2 + loc_cCols3 + loc_cCols4 + ") " + ;
                       "VALUES (" + loc_cVals1 + loc_cVals2 + loc_cVals3 + loc_cVals4 + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                MsgErro("Erro ao gravar Unifica" + CHR(231) + CHR(227) + "o no banco de dados.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE do registro SigMlItn no SQL Server
    * A tela original nao faz edicao apos unificar (mala unificada e imutavel),
    * mas o metodo existe para permitir manutencao (renomear, atualizar contadores)
    * via propriedades do BO.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCodigos)
                MsgAviso("C" + CHR(243) + "digo da Unifica" + CHR(231) + CHR(227) + ;
                         "o n" + CHR(227) + "o informado.", "Aviso")
            ELSE
                loc_cSQL = "UPDATE SigMlItn SET " + ;
                           "Descs = "     + EscaparSQL(LEFT(THIS.this_cDescs, 30)) + ", " + ;
                           "UsuAlts = "   + EscaparSQL(LEFT(THIS.this_cUsuIns, 10)) + ", " + ;
                           "NRegis = "    + FormatarNumeroSQL(THIS.this_nNRegis, 0) + ", " + ;
                           "Espelhos = "  + EscaparSQL(LEFT(THIS.this_cEspelhos, 8)) + ", " + ;
                           "Unificas = "  + EscaparSQL(THIS.this_cUnificas) + " " + ;
                           "WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    MsgErro("Erro ao atualizar Unifica" + CHR(231) + CHR(227) + ;
                            "o no banco de dados.", "Erro")
                ELSE
                    THIS.RegistrarAuditoria("A")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - registra operacao em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, DataHora, Tabela, Operacao, ChaveRegistro, Descricao) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", GETDATE(), " + ;
                       "'SigMlItn', " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL("Unifica" + CHR(231) + CHR(227) + "o: " + THIS.this_cDescs) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Auditoria nao deve bloquear operacao principal
        ENDTRY
    ENDPROC

ENDDEFINE

