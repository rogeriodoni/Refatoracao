# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH ENDPROC define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDPROC.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprtam.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1039 linhas total):

*-- Linhas 113 a 122:
113:                 ELSE
114:                     THIS.ConfigurarPageFrame()
115:                     THIS.ConfigurarCabecalho()
116:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
117:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
118:                     THIS.ConfigurarPaginaLista()
119:                     THIS.CarregarDados()
120:                     THIS.ConfigurarPaginaDados()
121:                     THIS.ConfigurarGrdDados()
122:                     THIS.TornarControlesVisiveis(THIS)

*-- Linhas 145 a 193:
145:         loc_oCab = THIS.cnt_4c_Cabecalho
146: 
147:         WITH loc_oCab
148:             .Top         = 0
149:             .Left        = 0
150:             .Width       = THIS.Width
151:             .Height      = 80
152:             .BackStyle   = 1
153:             .BackColor   = RGB(100, 100, 100)
154:             .BorderWidth = 0
155:         ENDWITH
156: 
157:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
158:         WITH loc_oCab.lbl_4c_Sombra
159:             .AutoSize    = .F.
160:             .Top         = 25
161:             .Left        = 10
162:             .Width       = 769
163:             .Height      = 40
164:             .FontName    = "Tahoma"
165:             .FontSize    = 18
166:             .FontBold    = .T.
167:             .WordWrap    = .T.
168:             .Alignment   = 0
169:             .BackStyle   = 0
170:             .ForeColor   = RGB(0, 0, 0)
171:             .Caption     = THIS.Caption
172:         ENDWITH
173: 
174:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
175:         WITH loc_oCab.lbl_4c_Titulo
176:             .AutoSize    = .F.
177:             .Top         = 24
178:             .Left        = 10
179:             .Width       = 769
180:             .Height      = 46
181:             .FontName    = "Tahoma"
182:             .FontSize    = 18
183:             .FontBold    = .T.
184:             .WordWrap    = .T.
185:             .Alignment   = 0
186:             .BackStyle   = 0
187:             .ForeColor   = RGB(255, 255, 255)
188:             .Caption     = THIS.Caption
189:         ENDWITH
190:     ENDPROC
191: 
192:     *==========================================================================
193:     * ConfigurarPaginaLista - Orquestra a "pagina de lista" (form flat OPERACIONAL)

*-- Linhas 224 a 239:
224:     *==========================================================================
225:     PROTECTED PROCEDURE ConfigurarBotoes()
226: 
227:         *-- cmd_4c_Inserir (cmdInserir legado: Left=413, Top=3)
228:         THIS.AddObject("cmd_4c_Inserir", "CommandButton")
229:         WITH THIS.cmd_4c_Inserir
230:             .Top             = 3
231:             .Left            = 413
232:             .Width           = 75
233:             .Height          = 75
234:             .Caption         = "Inserir"
235:             .FontName        = "Tahoma"
236:             .FontBold        = .T.
237:             .FontItalic      = .T.
238:             .FontSize        = 8
239:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 248 a 263:
248:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
249:         ENDWITH
250: 
251:         *-- cmd_4c_Excluir (cmdExcluir legado: Left=488, Top=3)
252:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
253:         WITH THIS.cmd_4c_Excluir
254:             .Top             = 3
255:             .Left            = 488
256:             .Width           = 75
257:             .Height          = 75
258:             .Caption         = "Excluir"
259:             .FontName        = "Tahoma"
260:             .FontBold        = .T.
261:             .FontItalic      = .T.
262:             .FontSize        = 8
263:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 272 a 287:
272:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
273:         ENDWITH
274: 
275:         *-- cmd_4c_Encerrar (cmdSair legado: Left=563, Top=3)
276:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
277:         WITH THIS.cmd_4c_Encerrar
278:             .Top             = 3
279:             .Left            = 563
280:             .Width           = 75
281:             .Height          = 75
282:             .Caption         = "Encerrar"
283:             .FontName        = "Tahoma"
284:             .FontBold        = .T.
285:             .FontItalic      = .T.
286:             .FontSize        = 8
287:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 303 a 323:
303:     * Cria:
304:     *   - shp_4c_PainelAcoes: Shape1 do legado (frame visual dos botoes)
305:     *     Legado: Top=12, Left=372, Width=256, Height=110 (envolve os 3 botoes)
306:     *   - lbl_4c_Produto: exibe codigo + descricao do produto (contexto de edicao)
307:     *     Aproveita this_cCPros + this_cDPros carregados de SigCdPro
308:     *   - lbl_4c_Precos: exibe PVens/PCuss para referencia rapida durante calculos
309:     *==========================================================================
310:     PROTECTED PROCEDURE ConfigurarPaginaDados()
311:         LOCAL loc_cCaptionProd, loc_cCaptionPrecos, loc_cDPros
312:         LOCAL loc_nPVens, loc_nPCuss
313: 
314:         *-- Shape1 (frame visual dos botoes - legado: Top=12 Left=372 W=256 H=110)
315:         THIS.AddObject("shp_4c_PainelAcoes", "Shape")
316:         WITH THIS.shp_4c_PainelAcoes
317:             .Top           = 12
318:             .Left          = 372
319:             .Width         = 256
320:             .Height        = 110
321:             .BackStyle     = 0
322:             .BorderColor   = RGB(136, 189, 188)
323:             .BorderWidth   = 1

*-- Linhas 345 a 383:
345:                              TRANSFORM(loc_nPCuss, "@$ 9,999,999.99")
346: 
347:         *-- Label produto: identifica qual produto esta sendo editado
348:         THIS.AddObject("lbl_4c_Produto", "Label")
349:         WITH THIS.lbl_4c_Produto
350:             .Top       = 85
351:             .Left      = 10
352:             .Width     = 355
353:             .Height    = 18
354:             .AutoSize  = .F.
355:             .FontName  = "Tahoma"
356:             .FontSize  = 9
357:             .FontBold  = .T.
358:             .BackStyle = 0
359:             .ForeColor = RGB(15, 41, 104)
360:             .Alignment = 0
361:             .Caption   = loc_cCaptionProd
362:         ENDWITH
363: 
364:         *-- Label precos: exibe PVens/PCuss para referencia dos calculos Percs/Valor
365:         THIS.AddObject("lbl_4c_Precos", "Label")
366:         WITH THIS.lbl_4c_Precos
367:             .Top       = 85
368:             .Left      = 370
369:             .Width     = 260
370:             .Height    = 18
371:             .AutoSize  = .F.
372:             .FontName  = "Tahoma"
373:             .FontSize  = 8
374:             .FontBold  = .F.
375:             .BackStyle = 0
376:             .ForeColor = RGB(90, 90, 90)
377:             .Alignment = 1
378:             .Caption   = loc_cCaptionPrecos
379:         ENDWITH
380:     ENDPROC
381: 
382:     *==========================================================================
383:     * ConfigurarGrid - Cria estrutura do grid de tamanhos

*-- Linhas 391 a 400:
391:         loc_oGrd = THIS.grd_4c_Dados
392: 
393:         WITH loc_oGrd
394:             .Top                 = 111
395:             .Left                = 9
396:             .Width               = 620
397:             .Height              = 394
398:             .ColumnCount         = 6
399:             .FontName            = "Tahoma"
400:             .FontSize            = 8

*-- Linhas 418 a 489:
418:                 .Width           = 38
419:                 .Movable         = .F.
420:                 .Resizable       = .F.
421:                 .Header1.Caption = "Tam."
422:                 .Header1.FontName = "Tahoma"
423:                 .Header1.FontSize = 8
424:                 .Header1.Alignment = 2
425:                 .Header1.ForeColor = RGB(90, 90, 90)
426:             ENDWITH
427: 
428:             *-- Column2: descs - Descricao (Width=216 do SCX)
429:             WITH .Column2
430:                 .Width           = 216
431:                 .Movable         = .F.
432:                 .Resizable       = .F.
433:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
434:                 .Header1.FontName = "Tahoma"
435:                 .Header1.FontSize = 8
436:                 .Header1.Alignment = 2
437:                 .Header1.ForeColor = RGB(90, 90, 90)
438:             ENDWITH
439: 
440:             *-- Column3: pesoms - Peso Medio (Width=100 do SCX)
441:             WITH .Column3
442:                 .Width           = 100
443:                 .Movable         = .F.
444:                 .Resizable       = .F.
445:                 .Header1.Caption = "Peso M" + CHR(233) + "dio"
446:                 .Header1.FontName = "Tahoma"
447:                 .Header1.FontSize = 8
448:                 .Header1.Alignment = 2
449:                 .Header1.ForeColor = RGB(90, 90, 90)
450:             ENDWITH
451: 
452:             *-- Column4: percs - Percentual (Width=80, InputMask="999.99" do SCX)
453:             WITH .Column4
454:                 .Width           = 80
455:                 .Movable         = .F.
456:                 .Resizable       = .F.
457:                 .InputMask       = "999.99"
458:                 .Header1.Caption = "Percentual"
459:                 .Header1.FontName = "Tahoma"
460:                 .Header1.FontSize = 8
461:                 .Header1.Alignment = 2
462:                 .Header1.ForeColor = RGB(90, 90, 90)
463:             ENDWITH
464: 
465:             *-- Column5: valor - Valor calculado (Width=100, InputMask do SCX)
466:             WITH .Column5
467:                 .Width           = 100
468:                 .Movable         = .F.
469:                 .Resizable       = .F.
470:                 .InputMask       = "9999,999.99999"
471:                 .Header1.Caption = "Valor"
472:                 .Header1.FontName = "Tahoma"
473:                 .Header1.FontSize = 8
474:                 .Header1.Alignment = 2
475:                 .Header1.ForeColor = RGB(90, 90, 90)
476:             ENDWITH
477: 
478:             *-- Column6: diasprz - Prazo de entrega (Width=60, InputMask="99" do SCX)
479:             WITH .Column6
480:                 .Width           = 60
481:                 .Movable         = .F.
482:                 .Resizable       = .F.
483:                 .InputMask       = "99"
484:                 .Header1.Caption = "Entrega"
485:                 .Header1.FontName = "Tahoma"
486:                 .Header1.FontSize = 8
487:                 .Header1.Alignment = 2
488:                 .Header1.ForeColor = RGB(90, 90, 90)
489:             ENDWITH

*-- Linhas 540 a 566:
540:             .Column6.ControlSource   = loc_cCursor + ".diasprz"
541: 
542:             *-- Redefinir cabecalhos apos RecordSource (VFP9 os reseta)
543:             .Column1.Header1.Caption = "Tam."
544:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
545:             .Column3.Header1.Caption = "Peso M" + CHR(233) + "dio"
546:             .Column4.Header1.Caption = "Percentual"
547:             .Column5.Header1.Caption = "Valor"
548:             .Column6.Header1.Caption = "Entrega"
549:         ENDWITH
550:     ENDPROC
551: 
552:     *==========================================================================
553:     * ConfigurarBINDEVENTs - Liga eventos aos controles via BINDEVENT
554:     * Botoes: Inserir / Excluir / Encerrar
555:     * Grid Column1/2: lookup SigCdTam por codigo ou descricao
556:     * Grid Column4/5: calculo bidirecional Percs <-> Valor
557:     *==========================================================================
558:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
559:         BINDEVENT(THIS.cmd_4c_Inserir,  "Click", THIS, "BtnInserirClick")
560:         BINDEVENT(THIS.cmd_4c_Excluir,  "Click", THIS, "BtnExcluirClick")
561:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
562:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdColuna1KeyPress")
563:         BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "GrdColuna2KeyPress")
564:         BINDEVENT(THIS.grd_4c_Dados.Column4.Text1, "KeyPress", THIS, "GrdColuna4KeyPress")
565:         BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "KeyPress", THIS, "GrdColuna5KeyPress")
566:     ENDPROC

*-- Linhas 572 a 581:
572:     PROTECTED PROCEDURE AjustarBotoesPorModo()
573:         LOCAL loc_lModoEdicao, loc_i
574:         loc_lModoEdicao = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
575:         THIS.cmd_4c_Inserir.Visible = loc_lModoEdicao
576:         THIS.cmd_4c_Excluir.Visible = loc_lModoEdicao
577: 
578:         *-- Tornar colunas do grid read-only em CONSULTAR (equiv. Column.When=.F. do legado)
579:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
580:             FOR loc_i = 1 TO THIS.grd_4c_Dados.ColumnCount
581:                 THIS.grd_4c_Dados.Columns(loc_i).ReadOnly = !loc_lModoEdicao

*-- Linhas 674 a 682:
674:     * Em modo INSERIR/ALTERAR: persiste via SalvarTamanhos() no SQL Server
675:     *==========================================================================
676:     PROCEDURE BtnEncerrarClick()
677:         IF THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible
678:             IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
679:                 IF !THIS.this_oBusinessObject.SalvarTamanhos(THIS.this_cCPros)
680:                     THIS.grd_4c_Dados.Column1.SetFocus()
681:                     RETURN
682:                 ENDIF

*-- Linhas 953 a 971:
953: 
954:         THIS.this_cDPros = NVL(THIS.this_oBusinessObject.this_cDPros, "")
955: 
956:         IF PEMSTATUS(THIS, "lbl_4c_Produto", 5) AND VARTYPE(THIS.lbl_4c_Produto) = "O"
957:             THIS.lbl_4c_Produto.Caption = "Produto: " + ALLTRIM(THIS.this_cCPros) + ;
958:                 IIF(EMPTY(ALLTRIM(THIS.this_cDPros)), "", " - " + ALLTRIM(THIS.this_cDPros))
959:         ENDIF
960: 
961:         IF PEMSTATUS(THIS, "lbl_4c_Precos", 5) AND VARTYPE(THIS.lbl_4c_Precos) = "O"
962:             loc_cCaptionPrecos = "Pre" + CHR(231) + "o Venda: " + ;
963:                 TRANSFORM(NVL(THIS.this_oBusinessObject.this_nPVens, 0), "@$ 9,999,999.99") + ;
964:                 "     Custo: " + ;
965:                 TRANSFORM(NVL(THIS.this_oBusinessObject.this_nPCuss, 0), "@$ 9,999,999.99")
966:             THIS.lbl_4c_Precos.Caption = loc_cCaptionPrecos
967:         ENDIF
968: 
969:         RETURN .T.
970:     ENDPROC
971: 


### BO (C:\4c\projeto\app\classes\sigprtamBO.prg):
*******************************************************************************
* sigprtamBO.prg - Business Object: Peso Medio por Tamanho do Produto
* Herda de BusinessBase
* Tabela principal: sigprtam
*******************************************************************************

DEFINE CLASS sigprtamBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela     = "sigprtam"
    this_cCampoChave = "cidchaves"

    *-- Chave primaria
    this_cCidChaves  = ""

    *-- Codigo do tamanho (FK -> SigCdTam.cods)
    this_cCodTams    = ""

    *-- Descricao do tamanho (virtual - SigCdTam.descs, nao persiste em sigprtam)
    this_cDescs      = ""

    *-- Codigo do produto (FK -> SigCdPro.cpros)
    this_cCPros      = ""

    *-- Peso medio por tamanho
    this_nPesoMs     = 0

    *-- Percentual sobre preco de venda
    this_nPercs      = 0

    *-- Valor calculado (preco de venda + percentual)
    this_nValor      = 0

    *-- Dias prazo de entrega
    this_nDiasPrz    = 0

    *-- Data da ultima alteracao
    this_dDataAlts   = {}

    *-- Data de transferencia
    this_dDataTrans  = {}

    *-- Data de movimento
    this_dDtMovs     = {}

    *-- Contexto do produto pai (carregado de SigCdPro)
    this_cDPros      = ""
    this_nPVens      = 0
    this_nPCuss      = 0

    *-- Nome do cursor de trabalho para o grid de tamanhos
    this_cCursorDados = "cursor_4c_TamPro"

    *---------------------------------------------------------------------------
    PROCEDURE Init()
    *---------------------------------------------------------------------------
        THIS.this_cTabela     = "sigprtam"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *---------------------------------------------------------------------------
        RETURN THIS.this_cCidChaves
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = NVL(ALLTRIM(cidchaves), "")
            THIS.this_cCodTams    = NVL(ALLTRIM(codtams), "")
            THIS.this_cCPros      = NVL(ALLTRIM(cpros), "")
            THIS.this_nPesoMs     = NVL(pesoms, 0)
            THIS.this_nPercs      = NVL(percs, 0)
            THIS.this_nValor      = NVL(valor, 0)
            THIS.this_nDiasPrz    = NVL(diasprz, 0)
            THIS.this_dDataAlts   = NVL(dataalts, {})
            THIS.this_dDataTrans  = NVL(datatrans, {})
            THIS.this_dDtMovs     = NVL(dtmovs, {})
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarTamanhos - Carrega tamanhos do produto do SQL Server para cursor
    * par_cCPros: codigo do produto
    *---------------------------------------------------------------------------
    PROCEDURE CarregarTamanhos(par_cCPros)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorDados)
                IF USED(THIS.this_cCursorDados)
                    TABLEREVERT(.T., THIS.this_cCursorDados)
                ENDIF
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_cSql = "SELECT a.cidchaves, a.codtams, a.cpros, " + ;
                        "       a.pesoms, a.percs, a.valor, a.diasprz, " + ;
                        "       a.dataalts, a.datatrans, a.dtmovs, " + ;
                        "       ISNULL(b.descs, '') AS descs " + ;
                        "  FROM sigprtam a " + ;
                        "  LEFT JOIN SigCdTam b ON b.cods = a.codtams " + ;
                        " WHERE a.cpros = " + EscaparSQL(par_cCPros) + ;
                        " ORDER BY a.codtams"

            IF SQLEXEC(gnConnHandle, loc_cSql, THIS.this_cCursorDados) > 0
                SELECT (THIS.this_cCursorDados)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar tamanhos do produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarProduto - Carrega dados do produto pai (PVens, PCuss, Dpros)
    * par_cCPros: codigo do produto
    *---------------------------------------------------------------------------
    PROCEDURE CarregarProduto(par_cCPros)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_ProdutoPai")
                USE IN cursor_4c_ProdutoPai
            ENDIF
            loc_cSql = "SELECT TOP 1 dpros, pvens, pcuss " + ;
                        "  FROM SigCdPro " + ;
                        " WHERE cpros = " + EscaparSQL(par_cCPros)
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ProdutoPai") > 0
                IF !EOF("cursor_4c_ProdutoPai")
                    SELECT cursor_4c_ProdutoPai
                    THIS.this_cDPros  = NVL(ALLTRIM(dpros), "")
                    THIS.this_nPVens  = NVL(pvens, 0)
                    THIS.this_nPCuss  = NVL(pcuss, 0)
                    loc_lSucesso = .T.
                ENDIF
                USE IN cursor_4c_ProdutoPai
            ELSE
                MsgErro("Erro ao carregar dados do produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_ProdutoPai")
                USE IN cursor_4c_ProdutoPai
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * InserirLinhaGrid - Insere linha em branco no cursor do grid (local)
    * par_cCPros: codigo do produto
    *---------------------------------------------------------------------------
    PROCEDURE InserirLinhaGrid(par_cCPros)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cIdChaves
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorDados)
                MsgErro("Cursor de tamanhos n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Verificar se ja existe linha vazia para este produto
            SELECT (THIS.this_cCursorDados)
            LOCATE FOR ALLTRIM(codtams) = "" AND ALLTRIM(cpros) = ALLTRIM(par_cCPros)
            IF !EOF()
                loc_lSucesso = .T.
            ENDIF

            loc_cIdChaves = fUniqueIds()

            INSERT INTO (THIS.this_cCursorDados) ;
                (cidchaves, codtams, cpros, descs, pesoms, percs, valor, diasprz) ;
                VALUES (loc_cIdChaves, "", par_cCPros, "", 0, 0, 0, 0)

            SELECT (THIS.this_cCursorDados)
            GO BOTTOM
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ExcluirLinhaGrid - Remove linha corrente do cursor do grid (local)
    * par_cCPros: codigo do produto
    *---------------------------------------------------------------------------
    PROCEDURE ExcluirLinhaGrid(par_cCPros)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorDados)
                loc_lSucesso = .F.
            ENDIF
            SELECT (THIS.this_cCursorDados)
            IF !EOF() AND ALLTRIM(cpros) = ALLTRIM(par_cCPros)
                DELETE
                SKIP
                IF EOF()
                    SKIP -1
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ValidarTamanhoExiste - Verifica se codtams ja esta em uso para cpros
    * (exceto o registro corrente identificado por cIdChaves)
    * Retorna .T. se duplicado (ja existe), .F. se OK
    *---------------------------------------------------------------------------
    PROCEDURE ValidarTamanhoExiste(par_cCodTams, par_cIdChavesAtual)
    *---------------------------------------------------------------------------
        LOCAL loc_lDuplicado, loc_oErro
        loc_lDuplicado = .F.
        TRY
            IF USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                LOCATE FOR ALLTRIM(codtams) = ALLTRIM(par_cCodTams) AND ;
                           ALLTRIM(cidchaves) <> ALLTRIM(par_cIdChavesAtual)
                loc_lDuplicado = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lDuplicado
    ENDPROC

    *---------------------------------------------------------------------------
    * BuscarDescricaoTamanho - Busca descricao do tamanho em SigCdTam
    * par_cCodTams: codigo do tamanho
    * Retorna descricao (string) ou "" se nao encontrado
    *---------------------------------------------------------------------------
    PROCEDURE BuscarDescricaoTamanho(par_cCodTams)
    *---------------------------------------------------------------------------
        LOCAL loc_cDescs, loc_oErro, loc_cSql
        loc_cDescs = ""
        TRY
            IF USED("cursor_4c_BuscaTam")
                USE IN cursor_4c_BuscaTam
            ENDIF
            loc_cSql = "SELECT TOP 1 cods, descs FROM SigCdTam " + ;
                        " WHERE cods = " + EscaparSQL(par_cCodTams)
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_BuscaTam") > 0
                IF !EOF("cursor_4c_BuscaTam")
                    SELECT cursor_4c_BuscaTam
                    loc_cDescs = NVL(ALLTRIM(descs), "")
                ENDIF
                USE IN cursor_4c_BuscaTam
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaTam")
                USE IN cursor_4c_BuscaTam
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cDescs
    ENDPROC

    *---------------------------------------------------------------------------
    * SalvarTamanhos - Persiste todas as linhas do cursor no SQL Server
    * par_cCPros: codigo do produto
    * Estrategia: DELETE all + INSERT all (mesma logica do legado via TABLEREVERT/TABLEUPDATE)
    *---------------------------------------------------------------------------
    PROCEDURE SalvarTamanhos(par_cCPros)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        LOCAL loc_cCidChaves, loc_cCodTams, loc_nPesoMs
        LOCAL loc_nPercs, loc_nValor, loc_nDiasPrz
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorDados)
                loc_lSucesso = .F.
            ENDIF

            *-- Validar: todos os registros devem ter tamanho informado
            SELECT (THIS.this_cCursorDados)
            SCAN
                IF EMPTY(ALLTRIM(codtams))
                    MsgAviso("Tamanho n" + CHR(227) + "o informado!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN

            *-- Deletar registros existentes no SQL Server
            loc_cSql = "DELETE FROM sigprtam WHERE cpros = " + EscaparSQL(par_cCPros)
            IF SQLEXEC(gnConnHandle, loc_cSql) < 0
                MsgErro("Erro ao excluir tamanhos anteriores.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Inserir todos os registros do cursor
            SELECT (THIS.this_cCursorDados)
            SCAN FOR !DELETED() AND ALLTRIM(cpros) = ALLTRIM(par_cCPros) ;
                AND !EMPTY(ALLTRIM(codtams))
                loc_cCidChaves = ALLTRIM(cidchaves)
                loc_cCodTams   = ALLTRIM(codtams)
                loc_nPesoMs    = NVL(pesoms, 0)
                loc_nPercs     = NVL(percs, 0)
                loc_nValor     = NVL(valor, 0)
                loc_nDiasPrz   = NVL(diasprz, 0)

                loc_cSql = "INSERT INTO sigprtam " + ;
                            "(cidchaves, codtams, cpros, pesoms, percs, valor, diasprz, dataalts) " + ;
                            "VALUES (" + ;
                            EscaparSQL(loc_cCidChaves) + ", " + ;
                            EscaparSQL(loc_cCodTams) + ", " + ;
                            EscaparSQL(par_cCPros) + ", " + ;
                            FormatarNumeroSQL(loc_nPesoMs, 3) + ", " + ;
                            FormatarNumeroSQL(loc_nPercs, 2) + ", " + ;
                            FormatarNumeroSQL(loc_nValor, 5) + ", " + ;
                            FormatarNumeroSQL(loc_nDiasPrz, 0) + ", " + ;
                            "GETDATE())"

                IF SQLEXEC(gnConnHandle, loc_cSql) < 0
                    MsgErro("Erro ao salvar tamanho " + loc_cCodTams + ".", "Erro")
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularValorPorPercentual - Calcula Valor a partir de Percs e PVens
    * par_nPercs:  percentual informado
    * par_nPVens:  preco de venda do produto
    * Retorna valor calculado
    *---------------------------------------------------------------------------
    PROCEDURE CalcularValorPorPercentual(par_nPercs, par_nPVens)
    *---------------------------------------------------------------------------
        LOCAL loc_nValor
        loc_nValor = 0
        IF par_nPVens <> 0 AND par_nPercs <> 0
            loc_nValor = par_nPVens + (par_nPVens * (par_nPercs / 100))
        ENDIF
        RETURN loc_nValor
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularPercentualPorValor - Calcula Percs a partir de Valor e PVens
    * par_nValor:  valor informado
    * par_nPVens:  preco de venda do produto
    * Retorna percentual calculado
    *---------------------------------------------------------------------------
    PROCEDURE CalcularPercentualPorValor(par_nValor, par_nPVens)
    *---------------------------------------------------------------------------
        LOCAL loc_nPercs
        loc_nPercs = 0
        IF par_nPVens <> 0 AND par_nValor <> 0
            loc_nPercs = ((par_nValor - par_nPVens) / par_nPVens) * 100
        ENDIF
        RETURN loc_nPercs
    ENDPROC

    *---------------------------------------------------------------------------
    * Inserir - Insere um unico registro de tamanho no SQL Server
    * Usa as propriedades this_* para montar o INSERT
    *---------------------------------------------------------------------------
    PROCEDURE Inserir()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSql = "INSERT INTO sigprtam " + ;
                        "(cidchaves, codtams, cpros, " + ;
                        " pesoms, percs, valor, diasprz, dataalts) " + ;
                        "VALUES (" + ;
                        EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                        EscaparSQL(THIS.this_cCodTams) + ", " + ;
                        EscaparSQL(THIS.this_cCPros) + ", " + ;
                        FormatarNumeroSQL(THIS.this_nPesoMs, 3) + ", " + ;
                        FormatarNumeroSQL(THIS.this_nPercs, 2) + ", " + ;
                        FormatarNumeroSQL(THIS.this_nValor, 5) + ", " + ;
                        FormatarNumeroSQL(THIS.this_nDiasPrz, 0) + ", " + ;
                        "GETDATE())"

            IF SQLEXEC(gnConnHandle, loc_cSql) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir tamanho " + ALLTRIM(THIS.this_cCodTams) + ".", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - Atualiza um unico registro de tamanho no SQL Server
    * Usa as propriedades this_* para montar o UPDATE
    *---------------------------------------------------------------------------
    PROCEDURE Atualizar()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            loc_cSql = "UPDATE sigprtam SET " + ;
                        " codtams = " + EscaparSQL(THIS.this_cCodTams) + ", " + ;
                        " cpros   = " + EscaparSQL(THIS.this_cCPros) + ", " + ;
                        " pesoms  = " + FormatarNumeroSQL(THIS.this_nPesoMs, 3) + ", " + ;
                        " percs   = " + FormatarNumeroSQL(THIS.this_nPercs, 2) + ", " + ;
                        " valor   = " + FormatarNumeroSQL(THIS.this_nValor, 5) + ", " + ;
                        " diasprz = " + FormatarNumeroSQL(THIS.this_nDiasPrz, 0) + ", " + ;
                        " dataalts = GETDATE() " + ;
                        " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSql) > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar tamanho " + ALLTRIM(THIS.this_cCodTams) + ".", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ExecutarExclusao - Remove um registro de tamanho do SQL Server (PROTECTED)
    * Chamado por BusinessBase.Excluir()
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            loc_cSql = "DELETE FROM sigprtam " + ;
                        " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSql) > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir tamanho.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC


ENDDEFINE

