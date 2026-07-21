# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [FONTNAME-ERRADO] Linha 311: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGf2.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1097 linhas total):

*-- Linhas 56 a 78:
56: 
57:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
58:                 *-- Propriedades visuais do form
59:                 THIS.Caption = "Gr" + CHR(225) + "fico de Falha X Recupera" + ;
60:                                CHR(231) + CHR(227) + "o Mensal"
61:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
62: 
63:                 *-- Inicializar cursor de cache do gr??fico (via BO)
64:                 THIS.this_oBusinessObject.InicializarCursorGrafico()
65: 
66:                 *-- Criar containers do layout
67:                 THIS.ConfigurarPageFrame()
68:                 THIS.ConfigurarPaginaLista()
69:                 THIS.ConfigurarPaginaDados()
70: 
71:                 *-- Sincronizar caption do cabecalho com o form
72:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
73:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
74: 
75:                 *-- Estado inicial: aguarde visivel, grafico oculto
76:                 THIS.AlternarPagina("AGUARDE")
77: 
78:                 *-- Exibir form com aguarde enquanto carrega o grafico

*-- Linhas 113 a 149:
113:         *-- === Cabe??alho cinza escuro (cntSombra do legado) ===
114:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
115:         WITH THIS.cnt_4c_Cabecalho
116:             .Top         = 0
117:             .Left        = 0
118:             .Width       = THIS.Width
119:             .Height      = 80
120:             .BackColor   = RGB(100, 100, 100)
121:             .BackStyle   = 1
122:             .BorderWidth = 0
123:             .Visible     = .T.
124: 
125:             .AddObject("lbl_4c_Sombra", "Label")
126:             WITH .lbl_4c_Sombra
127:                 .Top       = 18
128:                 .Left      = 10
129:                 .Width     = THIS.Width
130:                 .Height    = 40
131:                 .FontName  = "Tahoma"
132:                 .FontSize  = 18
133:                 .FontBold  = .T.
134:                 .BackStyle = 0
135:                 .ForeColor = RGB(0, 0, 0)
136:                 .WordWrap  = .T.
137:                 .AutoSize  = .F.
138:                 .Visible   = .T.
139:             ENDWITH
140: 
141:             .AddObject("lbl_4c_Titulo", "Label")
142:             WITH .lbl_4c_Titulo
143:                 .Top       = 17
144:                 .Left      = 10
145:                 .Width     = THIS.Width
146:                 .Height    = 46
147:                 .FontName  = "Tahoma"
148:                 .FontSize  = 18
149:                 .FontBold  = .T.

*-- Linhas 162 a 239:
162:             .BackStyle     = 0
163:             .BorderStyle   = 0
164:             .SpecialEffect = 1
165:             .Top           = -3
166:             .Left          = 644
167:             .Width         = 160
168:             .Height        = 85
169:             .Visible       = .T.
170:         ENDWITH
171: 
172:         *-- === Container do gr??fico OLE (oleGrafico1 adicionado na fase 4) ===
173:         THIS.AddObject("cnt_4c_Grf1", "Container")
174:         WITH THIS.cnt_4c_Grf1
175:             .Top           = 120
176:             .Left          = 17
177:             .Width         = 770
178:             .Height        = 429
179:             .BackColor     = RGB(255, 255, 255)
180:             .BackStyle     = 1
181:             .SpecialEffect = 0
182:             .Visible       = .T.
183:         ENDWITH
184: 
185:         *-- === Container de espera (vis??vel durante inicializa????o e processamento) ===
186:         THIS.AddObject("cnt_4c_Aguarde", "Container")
187:         WITH THIS.cnt_4c_Aguarde
188:             .Top           = 288
189:             .Left          = 312
190:             .Width         = 207
191:             .Height        = 49
192:             .BackColor     = RGB(255, 255, 255)
193:             .BackStyle     = 1
194:             .BorderWidth   = 5
195:             .SpecialEffect = 0
196:             .Visible       = .T.
197: 
198:             .AddObject("lbl_4c_Label1", "Label")
199:             WITH .lbl_4c_Label1
200:                 .Top       = 7
201:                 .Left      = 69
202:                 .Width     = 78
203:                 .Height    = 18
204:                 .FontName  = "Verdana"
205:                 .FontSize  = 10
206:                 .FontBold  = .T.
207:                 .BackStyle = 0
208:                 .ForeColor = RGB(255, 0, 0)
209:                 .Caption   = "Aguarde..."
210:                 .AutoSize  = .T.
211:                 .Visible   = .T.
212:             ENDWITH
213: 
214:             .AddObject("lbl_4c_Label2", "Label")
215:             WITH .lbl_4c_Label2
216:                 .Top       = 24
217:                 .Left      = 34
218:                 .Width     = 159
219:                 .Height    = 18
220:                 .FontName  = "Verdana"
221:                 .FontSize  = 10
222:                 .FontBold  = .T.
223:                 .BackStyle = 0
224:                 .Caption   = "Processando Dados..."
225:                 .AutoSize  = .F.
226:                 .Visible   = .T.
227:             ENDWITH
228:         ENDWITH
229: 
230:         *-- === Container inferior: Label + ComboBox (conte??do adicionado na fase 5) ===
231:         THIS.AddObject("cnt_4c_Grf2", "Container")
232:         WITH THIS.cnt_4c_Grf2
233:             .Top           = 558
234:             .Left          = 559
235:             .Width         = 228
236:             .Height        = 35
237:             .BackColor     = RGB(255, 255, 255)
238:             .BackStyle     = 1
239:             .SpecialEffect = 0

*-- Linhas 275 a 295:
275:         *-- OLE Bound Control para exibicao do grafico (oleGrafico1 do legado)
276:         THIS.cnt_4c_Grf1.AddObject("obj_4c_OleGrafico1", "OLEBoundControl")
277:         WITH THIS.cnt_4c_Grf1.obj_4c_OleGrafico1
278:             .Top     = 19
279:             .Left    = 5
280:             .Height  = 390
281:             .Width   = 760
282:             .Visible = .T.
283:         ENDWITH
284: 
285:         *-- Botao 1: Grafico (geral_grafico_pizza_60.jpg - icone do legado)
286:         WITH THIS.obj_4c_CmdgGrafico
287:             WITH .Buttons(1)
288:                 .Caption         = "Gr" + CHR(225) + "fico"
289:                 .Left            = 5
290:                 .Top             = 5
291:                 .Width           = 75
292:                 .Height          = 75
293:                 .FontBold        = .T.
294:                 .FontItalic      = .T.
295:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 302 a 317:
302:                 .MousePointer    = 15
303:             ENDWITH
304:             WITH .Buttons(2)
305:                 .Caption         = "Encerrar"
306:                 .Left            = 80
307:                 .Top             = 5
308:                 .Width           = 75
309:                 .Height          = 75
310:                 .FontName        = "Comic Sans MS"
311:                 .FontSize        = 8
312:                 .FontBold        = .T.
313:                 .FontItalic      = .T.
314:                 .ForeColor       = RGB(90, 90, 90)
315:                 .BackColor       = RGB(255, 255, 255)
316:                 .Themes          = .F.
317:                 .SpecialEffect   = 0

*-- Linhas 336 a 364:
336:         loc_oGrf2 = THIS.cnt_4c_Grf2
337: 
338:         *-- Label "Grupo / Vendedor :" (lblChave1 do legado)
339:         loc_oGrf2.AddObject("lbl_4c_LblChave1", "Label")
340:         WITH loc_oGrf2.lbl_4c_LblChave1
341:             .Top       = 9
342:             .Left      = 7
343:             .Width     = 94
344:             .Height    = 15
345:             .FontName  = "Tahoma"
346:             .FontSize  = 8
347:             .BackStyle = 0
348:             .ForeColor = RGB(90, 90, 90)
349:             .Caption   = "Grupo / Vendedor :"
350:             .AutoSize  = .T.
351:             .Visible   = .T.
352:         ENDWITH
353: 
354:         *-- ComboBox de selecao de grupo/vendedor (cmbChave1 do legado)
355:         *-- Items populados em GerarGrafico() ao inicializar
356:         loc_oGrf2.AddObject("cbo_4c_CmbChave1", "ComboBox")
357:         WITH loc_oGrf2.cbo_4c_CmbChave1
358:             .Top               = 4
359:             .Left              = 129
360:             .Width             = 86
361:             .Height            = 25
362:             .FontName          = "Courier New"
363:             .FontSize          = 9
364:             .ColumnCount       = 1

*-- Linhas 572 a 589:
572:                         .RowSource     = ""
573:                         .Width         = (loc_nTmStr * 7 + 9) + 20
574:                         .Height        = 25
575:                         .Top           = 5
576:                         .Left          = 5 + THIS.cnt_4c_Grf2.lbl_4c_LblChave1.Width
577:                         FOR loc_i = 1 TO loc_nCount
578:                             .AddItem(PADR(loc_aChaves(loc_i), loc_nTmStr))
579:                         ENDFOR
580:                     ENDWITH
581: 
582:                     WITH THIS.cnt_4c_Grf2
583:                         .Height = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Height + 10
584:                         .Width  = THIS.cnt_4c_Grf2.lbl_4c_LblChave1.Width + ;
585:                                   THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Width + 10
586:                         .Visible     = .T.
587:                     ENDWITH
588:                 ENDIF
589:             ENDIF

*-- Linhas 662 a 670:
662: 
663:                                 WITH .Axes(1)
664:                                     .HasTitle               = .T.
665:                                     .AxisTitle.Caption      = "Meses"
666:                                     .AxisTitle.Font.Name    = "Arial"
667:                                     .AxisTitle.Font.Size    = 8
668:                                     .AxisTitle.Font.Bold    = .T.
669:                                     .AxisTitle.Font.Italic  = .F.
670:                                     .AxisTitle.Orientation  = 0

*-- Linhas 721 a 729:
721:                                                             TRANSFORM(loc_nGrupo) + ").Points(" + ;
722:                                                             TRANSFORM(loc_nMes) + ").DataLabel") = "O"
723:                                                         WITH .PointsDataLabel
724:                                                             .Top          = (.Top - 10)
725:                                                             .NumberFormat = "###,###,##0.00"
726:                                                             .Font.Name    = "Arial"
727:                                                             .Font.Size    = 8
728:                                                             .Font.Bold    = .T.
729:                                                             .Font.Shadow  = .F.

*-- Linhas 945 a 954:
945:         ENDIF
946: 
947:         IF !EMPTY(THIS.this_oBusinessObject.this_cCaption)
948:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.this_oBusinessObject.this_cCaption
949:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.this_oBusinessObject.this_cCaption
950:         ENDIF
951:     ENDPROC
952: 
953:     *--------------------------------------------------------------------------
954:     * HabilitarCampos - Habilita ou desabilita controles do form


### BO (C:\4c\projeto\app\classes\SigPrGf2BO.prg):
*==============================================================================
* SigPrGf2BO.prg - Business Object: Grafico de Falha X Recuperacao Mensal
* Herda de: BusinessBase
* Tipo: OPERACIONAL - Visualizacao de grafico OLE (MSGraph)
* Sem tabela de banco - dados vem do cursor crRel1 do form pai
*==============================================================================
DEFINE CLASS SigPrGf2BO AS BusinessBase

    *-- Identificacao da entidade (sem tabela CRUD)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Cursores utilizados
    this_cCursorOrigem  = "crRel1"      && Cursor com dados do form pai
    this_cCursorGrafico = "crGrafico1"  && Cursor de cache do grafico OLE

    *-- Configuracao do grafico
    this_nNumGrafico = 0    && Numero do grafico (pnnumgrf)
    this_cCaption    = ""   && Titulo exibido no cabecalho e no grafico

    *-- Chave de selecao atual (cmbChave1 - Grupo/Vendedor)
    this_cChave1 = ""       && Valor selecionado no ComboBox (cEmps)

    *-- Dados de titulo extraidos de crRel1
    this_cTitulo1   = ""    && Titulo linha 1 (crRel1.cTitulo1s)
    this_cTitulo2   = ""    && Titulo linha 2 (crRel1.cTitulo2s)
    this_cEmpresa   = ""    && Nome da empresa (crRel1.cEmpresas)

    *-- Series de dados (strings TAB-delimitadas para MSGraph)
    this_cStranomes  = ""   && Nomes dos meses (crRel1.cStranomes, TAB-sep)
    this_cStrFalhas  = ""   && Contagem de falhas (crRel1.nFalhas, TAB-sep)
    this_cStrPesoccb = ""   && Contagem de recuperacoes (crRel1.nPesoccbs, TAB-sep)

    *-- Dimensoes das series
    this_nNmeses  = 0       && Numero de periodos/meses encontrados
    this_nNgrupos = 2       && Numero de series no grafico (Falha + Recuperacao)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            this_cTabela     = ""
            this_cCampoChave = ""
            this_cCaption    = "Gr" + CHR(225) + "fico de Falha X Recupera" + CHR(231) + CHR(227) + "o Mensal"
            this_nNgrupos    = 2

            loc_lResultado = DODEFAULT()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave do grafico (cEmps do vendedor/grupo)
    * Sem tabela SQL persistente: chave logica eh o valor selecionado no ComboBox
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cChave1)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *   par_cAliasCursor - Nome do alias (crRel1 ou crGrafico1)
    *   Se omitido, usa this_cCursorOrigem (crRel1)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_cAlias
        loc_lResultado = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         par_cAliasCursor, THIS.this_cCursorOrigem)

        TRY
            IF !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto"
            ELSE
                SELECT (loc_cAlias)

                DO CASE
                CASE UPPER(loc_cAlias) == UPPER(THIS.this_cCursorOrigem)
                    *-- Mapeia crRel1 (cursor do form pai)
                    IF TYPE(loc_cAlias + ".cEmps") != "U"
                        THIS.this_cChave1 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cEmps"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cTitulo1s") != "U"
                        THIS.this_cTitulo1 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cTitulo1s"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cTitulo2s") != "U"
                        THIS.this_cTitulo2 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cTitulo2s"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cEmpresas") != "U"
                        THIS.this_cEmpresa = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cEmpresas"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cStranomes") != "U"
                        THIS.this_cStranomes = NVL(EVALUATE(loc_cAlias + ".cStranomes"), "")
                    ENDIF
                    loc_lResultado = .T.
                CASE UPPER(loc_cAlias) == UPPER(THIS.this_cCursorGrafico)
                    *-- Mapeia crGrafico1 (cursor de cache do grafico OLE)
                    IF TYPE(loc_cAlias + ".cChave1s") != "U"
                        THIS.this_cChave1 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cChave1s"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".ctitulo1s") != "U"
                        THIS.this_cTitulo1 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".ctitulo1s"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cempresas") != "U"
                        THIS.this_cEmpresa = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cempresas"), ""))
                    ENDIF
                    loc_lResultado = .T.
                OTHERWISE
                    THIS.this_cMensagemErro = "Alias n" + CHR(227) + "o suportado: " + loc_cAlias
                ENDCASE
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar cursor: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere registro de cache no cursor crGrafico1
    * Nao ha tabela persistente em SQL Server: cache eh mantido em memoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cChave
        loc_lResultado = .F.

        TRY
            loc_cChave = ALLTRIM(THIS.this_cChave1)

            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Chave do gr" + CHR(225) + "fico n" + CHR(227) + "o informada"
            ELSE
                THIS.InicializarCursorGrafico()

                SELECT crGrafico1
                LOCATE FOR crGrafico1.cChave1s == PADR(loc_cChave, 100)

                IF !EOF("crGrafico1")
                    THIS.this_cMensagemErro = "Cache do gr" + CHR(225) + "fico j" + CHR(225) + " existe: " + loc_cChave
                ELSE
                    INSERT INTO crGrafico1 (cChave1s, ctitulo1s, cempresas) ;
                        VALUES (PADR(loc_cChave, 100), ;
                                PADR(THIS.this_cTitulo1, 128), ;
                                PADR(THIS.this_cEmpresa, 254))

                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir cache do gr" + CHR(225) + "fico: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro de cache do grafico
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cChave
        loc_lResultado = .F.

        TRY
            loc_cChave = ALLTRIM(THIS.this_cChave1)

            DO CASE
            CASE EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Chave do gr" + CHR(225) + "fico n" + CHR(227) + "o informada"
            CASE !USED("crGrafico1")
                THIS.this_cMensagemErro = "Cursor crGrafico1 n" + CHR(227) + "o est" + CHR(225) + " aberto"
            OTHERWISE
                SELECT crGrafico1
                LOCATE FOR crGrafico1.cChave1s == PADR(loc_cChave, 100)

                IF EOF("crGrafico1")
                    THIS.this_cMensagemErro = "Cache do gr" + CHR(225) + "fico n" + CHR(227) + "o encontrado: " + loc_cChave
                ELSE
                    REPLACE crGrafico1.ctitulo1s WITH PADR(THIS.this_cTitulo1, 128), ;
                            crGrafico1.cempresas  WITH PADR(THIS.this_cEmpresa, 254)

                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF
            ENDCASE

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar cache do gr" + CHR(225) + "fico: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra visualizacao do grafico em LogAuditoria
    *   par_cOperacao - "INSERT", "UPDATE" ou "VIEW"
    * Grafico OLE nao possui tabela persistente; auditoria usa "SigPrGf2" como
    *   tabela virtual e a chave selecionada como ChaveRegistro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cChave = THIS.ObterChavePrimaria()

            DO CASE
            CASE EMPTY(loc_cChave)
                *-- Sem chave: nao ha o que auditar
            CASE TYPE("gnConnHandle") != "N" OR gnConnHandle < 0
                *-- Sem conexao ativa: pula auditoria silenciosamente
            OTHERWISE
                loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

                loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                           "VALUES (" + EscaparSQL("SigPrGf2") + ", " + ;
                           EscaparSQL(par_cOperacao) + ", " + ;
                           EscaparSQL(loc_cChave) + ", " + ;
                           EscaparSQL(loc_cUsuario) + ", GETDATE())"

                SQLEXEC(gnConnHandle, loc_cSQL)
                loc_lResultado = .T.
            ENDCASE

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao registrar auditoria: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursorGrafico - Cria cursor crGrafico1 se nao existir
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursorGrafico()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF !USED("crGrafico1")
                SET NULL ON
                CREATE CURSOR crGrafico1 ;
                    (gGrafico1s G(4), cChave1s C(100), cempresas C(254), ctitulo1s C(128))
                SET NULL OFF
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavesGrafico - Retorna array de valores distintos de cEmps no crRel1
    *   par_aChaves - array BYREF que recebera as chaves
    *   Retorna: numero de chaves encontradas (0 se falhar)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavesGrafico(par_aChaves)
        LOCAL loc_nCount
        loc_nCount = 0

        TRY
            IF !USED(THIS.this_cCursorOrigem)
                loc_lResultado = 0
            ENDIF

            DIMENSION par_aChaves(1)
            par_aChaves = .F.

            SELECT DISTINCT cEmps ;
                FROM (THIS.this_cCursorOrigem) ;
                ORDER BY 1 ;
                INTO ARRAY par_aChaves

            loc_nCount = ALEN(par_aChaves, 1)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_nCount = 0
        ENDTRY

        RETURN loc_nCount
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosGrafico - Prepara crGrafico1 para a chave selecionada
    *   par_nLinha    - Indice (1-based) da chave no array de chaves
    *   par_aChaves   - Array com os valores de cEmps disponiveis
    *   Retorna .T. se os dados foram preparados com sucesso
    *   Efeito colateral: popula this_cChave1, this_cTitulo1, this_cEmpresa,
    *     this_cStranomes, this_cStrFalhas, this_cStrPesoccb, this_nNmeses
    *     e insere/garante registro em crGrafico1 (APPEND GENERAL gGrafico1s)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosGrafico(par_nLinha, par_aChaves)
        LOCAL loc_lResultado, loc_nLinha, loc_cChave1
        LOCAL loc_cTitulo1, loc_cEmpresa
        LOCAL loc_cStrg1, loc_cStrg2, loc_cStrg3, loc_nNmeses
        LOCAL loc_cTAB, loc_cCRLF

        loc_lResultado = .F.
        loc_cTAB  = CHR(9)
        loc_cCRLF = CHR(13) + CHR(10)

        TRY
            IF !USED(THIS.this_cCursorOrigem)
                loc_lResultado = .F.
            ENDIF

            loc_nLinha = IIF(VARTYPE(par_nLinha) = "N" .AND. par_nLinha > 0, par_nLinha, 1)

            IF VARTYPE(par_aChaves) != "A" OR ALEN(par_aChaves, 1) < loc_nLinha
                loc_lResultado = .F.
            ENDIF

            loc_cChave1 = ALLTRIM(par_aChaves(loc_nLinha))

            THIS.InicializarCursorGrafico()

            *-- Verificar cache
            SELECT crGrafico1
            LOCATE FOR crGrafico1.cChave1s == PADR(loc_cChave1, 100)

            IF EOF("crGrafico1")
                *-- Preparar series de dados a partir do cursor de origem
                loc_nNmeses = 0
                loc_cStrg2  = "Falha"
                loc_cStrg3  = "Recupera" + CHR(231) + CHR(227) + "o"
                loc_cStrg1  = ""
                loc_cTitulo1 = ""
                loc_cEmpresa = ""

                SELECT crRel1
                SET ORDER TO ("") IN crRel1
                LOCATE FOR crRel1.cEmps == loc_cChave1

                IF !EOF("crRel1")
                    loc_cTitulo1 = ALLTRIM(crRel1.cTitulo1s) + CHR(13) + ALLTRIM(crRel1.cTitulo2s)
                    loc_cEmpresa = crRel1.cEmpresas

                    SCAN WHILE crRel1.cEmps == loc_cChave1
                        loc_nNmeses = loc_nNmeses + 1
                        loc_cStrg1  = loc_cStrg1 + loc_cTAB + ALLTRIM(crRel1.cStranomes)
                        loc_cStrg2  = loc_cStrg2 + loc_cTAB + ;
                            ALLTRIM(TRANSFORM(crRel1.nFalhas, "999,999,999.99"))
                        loc_cStrg3  = loc_cStrg3 + loc_cTAB + ;
                            ALLTRIM(TRANSFORM(crRel1.nPesoccbs, "999,999,999.99"))
                    ENDSCAN
                ENDIF

                *-- Inserir no cache e gravar objeto OLE do grafico
                SELECT crGrafico1
                INSERT INTO crGrafico1 (cChave1s, ctitulo1s, cempresas) ;
                    VALUES (loc_cChave1, loc_cTitulo1, loc_cEmpresa)
                APPEND GENERAL gGrafico1s CLASS "MSGraph.Chart" ;
                    DATA (loc_cStrg1 + loc_cCRLF + loc_cStrg2 + loc_cCRLF + loc_cStrg3)

                *-- Atualizar propriedades do BO
                THIS.this_cChave1     = loc_cChave1
                THIS.this_cEmpresa    = loc_cEmpresa
                THIS.this_cTitulo1    = loc_cTitulo1
                THIS.this_cStranomes  = loc_cStrg1
                THIS.this_cStrFalhas  = loc_cStrg2
                THIS.this_cStrPesoccb = loc_cStrg3
                THIS.this_nNmeses     = loc_nNmeses
            ELSE
                *-- Recuperar titulo/empresa do cache
                THIS.this_cChave1  = ALLTRIM(crGrafico1.cChave1s)
                THIS.this_cTitulo1 = ALLTRIM(crGrafico1.ctitulo1s)
                THIS.this_cEmpresa = ALLTRIM(crGrafico1.cempresas)
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursorGrafico - Fecha cursor de cache do grafico
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursorGrafico()
        IF USED("crGrafico1")
            USE IN crGrafico1
        ENDIF
    ENDPROC

ENDDEFINE

