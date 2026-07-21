# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [FONTNAME-ERRADO] Linha 174: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrMlu.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (925 linhas total):

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

*-- Linhas 42 a 62:
42:         loc_lSucesso = .F.
43: 
44:         TRY
45:             THIS.Caption = "Unifica" + CHR(231) + CHR(227) + "o de Mala Direta"
46: 
47:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
48:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
49:             ENDIF
50: 
51:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrMluBO")
52:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
53:                 MsgErro("Falha ao criar SigPrMluBO", "Erro")
54:             ELSE
55:                 THIS.ConfigurarCabecalho()
56:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
57:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
58:                 THIS.ConfigurarBotoes()
59:                 THIS.ConfigurarCntNova()
60:                 THIS.ConfigurarGrade()
61:                 THIS.ConfigurarBtnGrade()
62:                 THIS.ConfigurarBINDEVENTs()

*-- Linhas 83 a 184:
83:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
84:         loc_oCab = THIS.cnt_4c_Cabecalho
85:         WITH loc_oCab
86:             .Top         = 0
87:             .Left        = 0
88:             .Width       = 1020
89:             .Height      = 80
90:             .BorderWidth = 0
91:             .BackStyle   = 1
92:             .BackColor   = RGB(100, 100, 100)
93:         ENDWITH
94:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
95:         WITH loc_oCab.lbl_4c_Sombra
96:             .AutoSize      = .F.
97:             .Top           = 18
98:             .Left          = 10
99:             .Width         = 1000
100:             .Height        = 40
101:             .FontBold      = .T.
102:             .FontName      = "Tahoma"
103:             .FontSize      = 18
104:             .FontUnderline = .F.
105:             .WordWrap      = .T.
106:             .Alignment     = 0
107:             .BackStyle     = 0
108:             .ForeColor     = RGB(0, 0, 0)
109:             .Caption       = "Unifica" + CHR(231) + CHR(227) + "o de Mala Direta"
110:         ENDWITH
111:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
112:         WITH loc_oCab.lbl_4c_Titulo
113:             .AutoSize      = .F.
114:             .Top           = 17
115:             .Left          = 10
116:             .Width         = 1000
117:             .Height        = 46
118:             .FontBold      = .T.
119:             .FontName      = "Tahoma"
120:             .FontSize      = 18
121:             .FontUnderline = .F.
122:             .WordWrap      = .T.
123:             .Alignment     = 0
124:             .BackStyle     = 0
125:             .ForeColor     = RGB(255, 255, 255)
126:             .Caption       = "Unifica" + CHR(231) + CHR(227) + "o de Mala Direta"
127:         ENDWITH
128:     ENDPROC
129: 
130:     *==========================================================================
131:     PROTECTED PROCEDURE ConfigurarBotoes
132:     *==========================================================================
133:         LOCAL loc_oCnt
134:         *-- Botao Processar (standalone com icone 60px, Themes=.T. + DisabledPicture obrigatorios)
135:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
136:         WITH THIS.cmd_4c_Processar
137:             .Top             = 5
138:             .Left            = 828
139:             .Height          = 75
140:             .Width           = 75
141:             .FontBold        = .T.
142:             .FontItalic      = .T.
143:             .FontName        = "Tahoma"
144:             .FontSize        = 8
145:             .WordWrap        = .T.
146:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
147:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
148:             .Caption         = "\<Processar"
149:             .ToolTipText     = "[Alt+P] Processar Unifica" + CHR(231) + CHR(227) + "o"
150:             .ForeColor       = RGB(90, 90, 90)
151:             .BackColor       = RGB(255, 255, 255)
152:             .Themes          = .T.
153:         ENDWITH
154: 
155:         *-- Container canonico Encerrar (Left=917, Width=90, Height=85)
156:         THIS.AddObject("cnt_4c_Saida", "Container")
157:         loc_oCnt = THIS.cnt_4c_Saida
158:         WITH loc_oCnt
159:             .Top         = -2
160:             .Left        = 917
161:             .Width       = 90
162:             .Height      = 85
163:             .BorderWidth = 0
164:             .BackStyle   = 0
165:         ENDWITH
166:         loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
167:         WITH loc_oCnt.cmd_4c_Encerrar
168:             .Top         = 5
169:             .Left        = 5
170:             .Height      = 75
171:             .Width       = 75
172:             .FontBold    = .T.
173:             .FontItalic  = .T.
174:             .FontName    = "Comic Sans MS"
175:             .FontSize    = 8
176:             .WordWrap    = .T.
177:             .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
178:             .Cancel      = .T.
179:             .Caption     = "Encerrar"
180:             .ToolTipText = "[Esc] Encerrar"
181:             .ForeColor   = RGB(90, 90, 90)
182:             .BackColor   = RGB(255, 255, 255)
183:             .Themes      = .F.
184:         ENDWITH

*-- Linhas 192 a 229:
192:         THIS.AddObject("cnt_4c_Nova", "Container")
193:         loc_oCnt = THIS.cnt_4c_Nova
194:         WITH loc_oCnt
195:             .Top         = 92
196:             .Left        = 15
197:             .Width       = 800
198:             .Height      = 42
199:             .BackStyle   = 0
200:             .BorderWidth = 0
201:         ENDWITH
202:         loc_oCnt.AddObject("lbl_4c_Nome", "Label")
203:         WITH loc_oCnt.lbl_4c_Nome
204:             .AutoSize  = .T.
205:             .FontBold  = .T.
206:             .FontName  = "Tahoma"
207:             .FontSize  = 8
208:             .BackStyle = 0
209:             .Caption   = " \<Nome da Unifica" + CHR(231) + CHR(227) + "o :"
210:             .Height    = 15
211:             .Left      = 20
212:             .Top       = 13
213:             .ForeColor = RGB(90, 90, 90)
214:         ENDWITH
215:         loc_oCnt.AddObject("txt_4c_GetNova", "TextBox")
216:         WITH loc_oCnt.txt_4c_GetNova
217:             .FontName          = "Courier New"
218:             .FontSize          = 9
219:             .Format            = "K"
220:             .Height            = 25
221:             .Left              = 155
222:             .MaxLength         = 20
223:             .TabIndex          = 1
224:             .Top               = 8
225:             .Width             = 220
226:             .DisabledBackColor = RGB(255, 255, 255)
227:             .DisabledForeColor = RGB(0, 0, 128)
228:             .Value             = ""
229:         ENDWITH

*-- Linhas 236 a 245:
236:     *==========================================================================
237:         THIS.AddObject("grd_4c_Selecoes", "Grid")
238:         WITH THIS.grd_4c_Selecoes
239:             .Top                = 140
240:             .Left               = 15
241:             .Width              = 870
242:             .Height             = 420
243:             .RecordMark         = .F.
244:             .DeleteMark         = .F.
245:             .RowHeight          = 16

*-- Linhas 253 a 277:
253:             .GridLineColor      = RGB(238, 238, 238)
254:             .ColumnCount        = 6
255: 
256:             *-- Column1: CheckBox de selecao (SelImp)
257:             WITH .Column1
258:                 .ColumnOrder   = 1
259:                 .Width         = 20
260:                 .Movable       = .F.
261:                 .Resizable     = .F.
262:                 .ReadOnly      = .F.
263:                 WITH .Header1
264:                     .Caption   = ""
265:                     .Alignment = 2
266:                     .FontName  = "Tahoma"
267:                     .FontSize  = 8
268:                     .ForeColor = RGB(36, 84, 155)
269:                 ENDWITH
270:                 .AddObject("ctlCheck1", "CheckBox")
271:                 WITH .ctlCheck1
272:                     .Caption   = ""
273:                     .Alignment = 0
274:                     .AutoSize  = .T.
275:                     .FontName  = "Tahoma"
276:                     .FontSize  = 8
277:                     .Value     = 0

*-- Linhas 288 a 296:
288:                 .Resizable     = .F.
289:                 .ReadOnly      = .T.
290:                 WITH .Header1
291:                     .Caption   = "C" + CHR(243) + "digo"
292:                     .Alignment = 2
293:                     .FontName  = "Tahoma"
294:                     .FontSize  = 8
295:                     .ForeColor = RGB(36, 84, 155)
296:                 ENDWITH

*-- Linhas 313 a 321:
313:                 .Resizable     = .F.
314:                 .ReadOnly      = .T.
315:                 WITH .Header1
316:                     .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
317:                     .Alignment = 2
318:                     .FontName  = "Tahoma"
319:                     .FontSize  = 8
320:                     .ForeColor = RGB(36, 84, 155)
321:                 ENDWITH

*-- Linhas 338 a 346:
338:                 .Resizable     = .F.
339:                 .ReadOnly      = .T.
340:                 WITH .Header1
341:                     .Caption   = "Usu" + CHR(225) + "rio"
342:                     .Alignment = 2
343:                     .FontName  = "Tahoma"
344:                     .FontSize  = 8
345:                     .ForeColor = RGB(36, 84, 155)
346:                 ENDWITH

*-- Linhas 363 a 371:
363:                 .Resizable     = .F.
364:                 .ReadOnly      = .T.
365:                 WITH .Header1
366:                     .Caption   = "Dt.Entrada"
367:                     .Alignment = 2
368:                     .FontName  = "Tahoma"
369:                     .FontSize  = 8
370:                     .ForeColor = RGB(36, 84, 155)
371:                 ENDWITH

*-- Linhas 388 a 396:
388:                 .Resizable     = .F.
389:                 .ReadOnly      = .T.
390:                 WITH .Header1
391:                     .Caption   = "N.Registros"
392:                     .Alignment = 2
393:                     .FontName  = "Tahoma"
394:                     .FontSize  = 8
395:                     .ForeColor = RGB(36, 84, 155)
396:                 ENDWITH

*-- Linhas 413 a 476:
413:     *-- Posicionados abaixo e a direita da grade
414:     *==========================================================================
415:         *-- Botao Selecionar Tudo
416:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
417:         WITH THIS.cmd_4c_SelTudo
418:             .Top         = 265
419:             .Left        = 892
420:             .Height      = 40
421:             .Width       = 40
422:             .FontName    = "Verdana"
423:             .FontSize    = 8
424:             .WordWrap    = .T.
425:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
426:             .Caption     = ""
427:             .TabStop     = .F.
428:             .ToolTipText = "Selecionar Tudo"
429:             .ForeColor   = RGB(36, 84, 155)
430:             .BackColor   = RGB(255, 255, 255)
431:             .Themes      = .T.
432:         ENDWITH
433: 
434:         *-- Botao Desmarcar Tudo
435:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
436:         WITH THIS.cmd_4c_Apaga
437:             .Top         = 310
438:             .Left        = 892
439:             .Height      = 40
440:             .Width       = 40
441:             .FontName    = "Verdana"
442:             .FontSize    = 8
443:             .WordWrap    = .T.
444:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
445:             .Caption     = ""
446:             .TabStop     = .F.
447:             .ToolTipText = "Desmarcar Tudo"
448:             .ForeColor   = RGB(36, 84, 155)
449:             .BackColor   = RGB(255, 255, 255)
450:             .Themes      = .T.
451:         ENDWITH
452:     ENDPROC
453: 
454:     *==========================================================================
455:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
456:     *==========================================================================
457:         *-- Botoes principais
458:         BINDEVENT(THIS.cmd_4c_Processar,              "Click", THIS, "BtnProcessarClick")
459:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
460: 
461:         *-- Botoes de selecao de grade
462:         BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelecionarTudoClick")
463:         BINDEVENT(THIS.cmd_4c_Apaga,   "Click", THIS, "BtnDesmarcarTudoClick")
464: 
465:         *-- Cliques nos cabecalhos para ordenacao
466:         BINDEVENT(THIS.grd_4c_Selecoes.Column2.Header1, "Click", THIS, "Col2HeaderClick")
467:         BINDEVENT(THIS.grd_4c_Selecoes.Column3.Header1, "Click", THIS, "Col3HeaderClick")
468:         BINDEVENT(THIS.grd_4c_Selecoes.Column4.Header1, "Click", THIS, "Col4HeaderClick")
469:         BINDEVENT(THIS.grd_4c_Selecoes.Column5.Header1, "Click", THIS, "Col5HeaderClick")
470: 
471:         *-- CheckBox de selecao individual: MouseDown + KeyPress
472:         BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "MouseDown", THIS, "GrdChkMouseDown")
473:         BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "KeyPress",  THIS, "GrdChkKeyPress")
474:         BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "Click",     THIS, "GrdChkClick")
475:     ENDPROC
476: 

*-- Linhas 591 a 601:
591:     *
592:     * Este form nao segue o padrao Page1=Lista/Page2=Dados.
593:     * Grid e botoes sao criados diretamente via:
594:     *   ConfigurarGrade()    ? grd_4c_Selecoes (6 colunas, checkbox SelImp)
595:     *   ConfigurarBotoes()   ? cmd_4c_Processar + cnt_4c_Saida/cmd_4c_Encerrar
596:     *   ConfigurarBtnGrade() ? cmd_4c_SelTudo + cmd_4c_Apaga
597:     * Todos chamados em InicializarForm().
598:     *==========================================================================
599:     PROTECTED PROCEDURE ConfigurarPageFrame()
600:         *-- OPERACIONAL: sem PageFrame; controles criados diretamente em InicializarForm
601:         RETURN .T.

*-- Linhas 639 a 648:
639:         loc_lOk = .F.
640:         loc_cNome = ""
641: 
642:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
643:             THIS.cmd_4c_Processar.Enabled = .F.
644:         ENDIF
645: 
646:         TRY
647:             IF !USED("cursor_4c_Itn")
648:                 MsgAviso("Nenhuma mala direta carregada.", "Processar")

*-- Linhas 710 a 719:
710:             MsgErro(loc_oErro.Message, "Erro BtnProcessarClick")
711:         ENDTRY
712: 
713:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
714:             THIS.cmd_4c_Processar.Enabled = .T.
715:         ENDIF
716:     ENDPROC
717: 
718:     PROCEDURE BtnEncerrarClick()
719:         THIS.Release()

*-- Linhas 765 a 773:
765:         ENDIF
766:     ENDPROC
767: 
768:     *-- MouseDown: toggle SelImp do registro corrente (equivale ao CheckBox original)
769:     PROCEDURE GrdChkMouseDown
770:         LPARAMETERS par_nButton, par_nShift, par_nXCoord, par_nYCoord
771:         LOCAL loc_nSel
772:         IF USED("cursor_4c_Itn")
773:             loc_nSel = IIF(cursor_4c_Itn.SelImp = 1, 0, 1)

*-- Linhas 871 a 880:
871:         IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
872:             THIS.cnt_4c_Nova.txt_4c_GetNova.Enabled = par_lHabilitar
873:         ENDIF
874:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
875:             THIS.cmd_4c_Processar.Enabled = par_lHabilitar
876:         ENDIF
877:     ENDPROC
878: 
879:     *==========================================================================
880:     * LimparCampos - limpa campo nome e desmarca todas as selecoes da grade

*-- Linhas 896 a 905:
896:     *==========================================================================
897:     PROTECTED PROCEDURE AjustarBotoesPorModo()
898:         *-- OPERACIONAL: habilita Processar somente se BO inicializado
899:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
900:             THIS.cmd_4c_Processar.Enabled = (VARTYPE(THIS.this_oBusinessObject) = "O")
901:         ENDIF
902:     ENDPROC
903: 
904:     *==========================================================================
905:     * BtnBuscarClick - recarrega a lista de malas diretas do servidor


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

