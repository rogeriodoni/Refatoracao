# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 183: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 207: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 263: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 288: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPREST.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (727 linhas total):

*-- Linhas 56 a 66:
56:                 *-- Configurar layout (cabecalho + shape/label/botoes)
57:                 THIS.ConfigurarLayout()
58: 
59:                 *-- Configurar area de dados (Parte 1: shape decorativo + checkbox Estrutura)
60:                 *-- OPERACIONAL: nao ha Page2 - "pagina dados" mapeia para os controles
61:                 *-- interativos do dialog (checkboxes de selecao das operacoes).
62:                 THIS.ConfigurarPaginaDados()
63: 
64:                 *-- Configurar area de trabalho (atalhos, tooltips, estado inicial)
65:                 THIS.ConfigurarPaginaLista()
66: 

*-- Linhas 120 a 189:
120:         *-- Cabecalho escuro (cntSombra original: Top=-1, Left=-1, W=800, H=80)
121:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
122:         WITH THIS.cnt_4c_Cabecalho
123:             .Top         = -1
124:             .Left        = -1
125:             .Width       = THIS.Width
126:             .Height      = 80
127:             .BackColor   = RGB(100, 100, 100)
128:             .BackStyle   = 1
129:             .BorderWidth = 0
130: 
131:             *-- Sombra (deslocada 1px para efeito 3D)
132:             .AddObject("lbl_4c_Sombra", "Label")
133:             WITH .lbl_4c_Sombra
134:                 .FontBold      = .T.
135:                 .FontName      = "Tahoma"
136:                 .FontSize      = 18
137:                 .FontUnderline = .F.
138:                 .WordWrap      = .T.
139:                 .Alignment     = 0
140:                 .BackStyle     = 0
141:                 .AutoSize      = .F.
142:                 .Caption       = "Cadastro de Testes"
143:                 .Height        = 40
144:                 .Left          = 10
145:                 .Top           = 18
146:                 .Width         = THIS.Width
147:                 .ForeColor     = RGB(0, 0, 0)
148:                 .Visible       = .T.
149:             ENDWITH
150: 
151:             *-- Titulo branco sobre fundo escuro
152:             .AddObject("lbl_4c_Titulo", "Label")
153:             WITH .lbl_4c_Titulo
154:                 .FontBold    = .T.
155:                 .FontName    = "Tahoma"
156:                 .FontSize    = 18
157:                 .WordWrap    = .T.
158:                 .Alignment   = 0
159:                 .BackStyle   = 0
160:                 .AutoSize    = .F.
161:                 .Caption     = "Cadastro de Testes"
162:                 .Height      = 46
163:                 .Left        = 10
164:                 .Top         = 17
165:                 .Width       = THIS.Width
166:                 .ForeColor   = RGB(255, 255, 255)
167:                 .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
168:                 .Visible     = .T.
169:             ENDWITH
170: 
171:             .Visible = .T.
172:         ENDWITH
173: 
174:         *-- Botao OK - Gerar (Top=3, Left=450)
175:         THIS.AddObject("cmd_4c_OK", "CommandButton")
176:         WITH THIS.cmd_4c_OK
177:             .Top            = 3
178:             .Left           = 450
179:             .Width          = 75
180:             .Height         = 75
181:             .Caption        = CHR(60) + "Gerar"
182:             .Picture        = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
183:             .FontName       = "Comic Sans MS"
184:             .FontSize       = 8
185:             .FontBold       = .T.
186:             .FontItalic     = .T.
187:             .ForeColor      = RGB(90, 90, 90)
188:             .BackColor      = RGB(255, 255, 255)
189:             .Themes         = .T.

*-- Linhas 195 a 213:
195:         ENDWITH
196: 
197:         *-- Botao Cancela - Encerrar (Top=3, Left=525)
198:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
199:         WITH THIS.cmd_4c_Cancela
200:             .Top            = 3
201:             .Left           = 525
202:             .Width          = 75
203:             .Height         = 75
204:             .Caption        = "Encerrar"
205:             .Cancel         = .T.
206:             .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
207:             .FontName       = "Comic Sans MS"
208:             .FontSize       = 8
209:             .FontBold       = .T.
210:             .FontItalic     = .T.
211:             .ForeColor      = RGB(90, 90, 90)
212:             .BackColor      = RGB(255, 255, 255)
213:             .Themes         = .T.

*-- Linhas 219 a 294:
219:         ENDWITH
220: 
221:         *-- BINDEVENTs dos botoes
222:         BINDEVENT(THIS.cmd_4c_OK,     "Click", THIS, "CmdOKClick")
223:         BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "CmdCancelaClick")
224:     ENDPROC
225: 
226:     *--------------------------------------------------------------------------
227:     * ConfigurarPaginaDados - Controles interativos do dialog (area de selecao)
228:     *
229:     * OPERACIONAL: este dialog NAO tem PageFrame com Page2 (Dados). O metodo
230:     * cria TODOS os controles interativos que compoem a area de selecao do dialog:
231:     *
232:     *   - shp_4c_Shape1        : moldura decorativa em volta das checkboxes
233:     *                            (Shape1 no SCX original: Top=9, Left=49, W=173, H=110)
234:     *   - chk_4c_GeraArquivos  : checkbox Estrutura (GeraArquivos: Top=90, Left=55)
235:     *   - chk_4c_GeraIndices   : checkbox Indice (GeraIndices: Top=90, Left=136)
236:     *   - lbl_4c_Mensagem      : label de status (Mensagem1: Top=132, Left=48)
237:     *
238:     * Posicoes seguem o layout.json extraido do SCX original (PILAR 1 - UX).
239:     * Nao ha lookups neste form (original nao usa fwBuscaExt/sigacess).
240:     *--------------------------------------------------------------------------
241:     PROTECTED PROCEDURE ConfigurarPaginaDados()
242:         *-- Shape decorativo em volta da area de checkboxes
243:         THIS.AddObject("shp_4c_Shape1", "Shape")
244:         WITH THIS.shp_4c_Shape1
245:             .Top     = 9
246:             .Left    = 49
247:             .Width   = 173
248:             .Height  = 110
249:             .Visible = .T.
250:         ENDWITH
251: 
252:         *-- Checkbox 1/2: Gerar Estrutura de arquivos DBF
253:         THIS.AddObject("chk_4c_GeraArquivos", "CheckBox")
254:         WITH THIS.chk_4c_GeraArquivos
255:             .Top        = 90
256:             .Left       = 55
257:             .Width      = 75
258:             .Height     = 75
259:             .Caption    = "Estrutura"
260:             .Value      = 1
261:             .Style      = 1
262:             .Picture    = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
263:             .FontName   = "Comic Sans MS"
264:             .FontSize   = 8
265:             .FontBold   = .T.
266:             .FontItalic = .T.
267:             .WordWrap   = .T.
268:             .AutoSize   = .F.
269:             .Alignment  = 2
270:             .BackStyle  = 1
271:             .ForeColor  = RGB(90, 90, 90)
272:             .BackColor  = RGB(255, 255, 255)
273:             .Themes     = .F.
274:             .Visible    = .T.
275:         ENDWITH
276: 
277:         *-- Checkbox 2/2: Gerar Indices (GeraIndices: Top=90, Left=136, W=75, H=75)
278:         THIS.AddObject("chk_4c_GeraIndices", "CheckBox")
279:         WITH THIS.chk_4c_GeraIndices
280:             .Top        = 90
281:             .Left       = 136
282:             .Width      = 75
283:             .Height     = 75
284:             .Caption    = CHR(205) + "ndice"
285:             .Value      = 1
286:             .Style      = 1
287:             .Picture    = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
288:             .FontName   = "Comic Sans MS"
289:             .FontSize   = 8
290:             .FontBold   = .T.
291:             .FontItalic = .T.
292:             .WordWrap   = .T.
293:             .AutoSize   = .F.
294:             .Alignment  = 2

*-- Linhas 300 a 424:
300:         ENDWITH
301: 
302:         *-- Label de mensagem de status (Mensagem1: Top=132, Left=48, W=480, H=24)
303:         THIS.AddObject("lbl_4c_Mensagem", "Label")
304:         WITH THIS.lbl_4c_Mensagem
305:             .Top       = 132
306:             .Left      = 48
307:             .Width     = 480
308:             .Height    = 24
309:             .Caption   = ""
310:             .BackStyle = 0
311:             .FontBold  = .T.
312:             .FontName  = "Tahoma"
313:             .FontSize  = 11
314:             .Alignment = 2
315:             .ForeColor = RGB(90, 90, 90)
316:             .Visible   = .T.
317:         ENDWITH
318:     ENDPROC
319: 
320:     *--------------------------------------------------------------------------
321:     * ConfigurarPaginaLista - Configura a area operacional (checkboxes + atalhos)
322:     *
323:     * OPERACIONAL: este dialog NAO tem PageFrame Lista/Dados como CRUDs.
324:     * A "pagina lista" mapeia para a area de trabalho onde o usuario escolhe
325:     * quais estruturas gerar (Estrutura / Indice). Este metodo:
326:     *   1. Vincula atalhos de teclado (F5=Gerar, ESC=Encerrar) via KeyPress
327:     *   2. Ajusta ToolTipText dos controles operacionais
328:     *   3. Reseta estado dos checkboxes para o padrao (ambos marcados)
329:     *   4. Limpa label de mensagem
330:     *--------------------------------------------------------------------------
331:     PROTECTED PROCEDURE ConfigurarPaginaLista()
332:         *-- ToolTipTexts descritivos (documentacao contextual em runtime)
333:         THIS.chk_4c_GeraArquivos.ToolTipText = ;
334:             "Gerar estrutura de tabelas DBF a partir das tabelas do banco"
335:         THIS.chk_4c_GeraIndices.ToolTipText = ;
336:             "Gerar " + CHR(237) + "ndices das tabelas DBF geradas"
337:         THIS.cmd_4c_OK.ToolTipText = ;
338:             "Iniciar gera" + CHR(231) + CHR(227) + "o (F5)"
339:         THIS.cmd_4c_Cancela.ToolTipText = ;
340:             "Encerrar sem gerar (ESC)"
341: 
342:         *-- Estado padrao dos checkboxes (ambos marcados)
343:         THIS.chk_4c_GeraArquivos.Value = 1
344:         THIS.chk_4c_GeraIndices.Value  = 1
345: 
346:         *-- Label de mensagem inicia limpa
347:         THIS.lbl_4c_Mensagem.Caption = ""
348: 
349:         *-- Vincular atalhos de teclado nos botoes (F5=Gerar, ESC=Cancelar)
350:         BINDEVENT(THIS.cmd_4c_OK,      "KeyPress", THIS, "TrataAtalhoTeclado")
351:         BINDEVENT(THIS.cmd_4c_Cancela, "KeyPress", THIS, "TrataAtalhoTeclado")
352:         BINDEVENT(THIS.chk_4c_GeraArquivos, "KeyPress", THIS, "TrataAtalhoTeclado")
353:         BINDEVENT(THIS.chk_4c_GeraIndices,  "KeyPress", THIS, "TrataAtalhoTeclado")
354: 
355:         *-- Ordem de tabulacao para navegacao coerente
356:         THIS.chk_4c_GeraArquivos.TabIndex = 1
357:         THIS.chk_4c_GeraIndices.TabIndex  = 2
358:         THIS.cmd_4c_OK.TabIndex           = 3
359:         THIS.cmd_4c_Cancela.TabIndex      = 4
360: 
361:         *-- Foco inicial no primeiro checkbox
362:         IF THIS.chk_4c_GeraArquivos.Enabled
363:             THIS.chk_4c_GeraArquivos.SetFocus()
364:         ENDIF
365:     ENDPROC
366: 
367:     *--------------------------------------------------------------------------
368:     * TrataAtalhoTeclado - Handler unico dos atalhos (F5, ESC)
369:     * F5  (116) -> dispara CmdOKClick (Gerar)
370:     * ESC ( 27) -> dispara CmdCancelaClick (Encerrar)
371:     *--------------------------------------------------------------------------
372:     PROCEDURE TrataAtalhoTeclado(par_nKeyCode, par_nShiftAltCtrl)
373:         DO CASE
374:         CASE par_nKeyCode = 116 AND THIS.cmd_4c_OK.Enabled
375:             THIS.CmdOKClick()
376:         CASE par_nKeyCode = 27 AND THIS.cmd_4c_Cancela.Enabled
377:             THIS.CmdCancelaClick()
378:         ENDCASE
379:     ENDPROC
380: 
381:     *--------------------------------------------------------------------------
382:     * AlternarPagina - State machine do dialog operacional
383:     *
384:     * OPERACIONAL: este dialog NAO tem multiplas Pages (nao ha ActivePage a
385:     * mudar). "AlternarPagina" implementa a maquina de estados do processo:
386:     *   par_nPagina = 1 (PRONTO)     -> UI habilitada, checkboxes editaveis
387:     *   par_nPagina = 2 (PROCESSANDO)-> UI bloqueada, mensagem "Processando..."
388:     *   par_nPagina = 3 (CONCLUIDO)  -> UI reabilitada, mensagem final preservada
389:     *--------------------------------------------------------------------------
390:     PROCEDURE AlternarPagina(par_nPagina)
391:         LOCAL loc_nEstado
392:         loc_nEstado = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
393: 
394:         DO CASE
395:         CASE loc_nEstado = 1
396:             *-- Estado PRONTO: dialog aceitando input do usuario
397:             THIS.chk_4c_GeraArquivos.Enabled = .T.
398:             THIS.chk_4c_GeraIndices.Enabled  = .T.
399:             THIS.cmd_4c_OK.Enabled           = .T.
400:             THIS.cmd_4c_Cancela.Enabled      = .T.
401:             THIS.this_lProcessando           = .F.
402:             THIS.lbl_4c_Mensagem.Caption     = ""
403: 
404:         CASE loc_nEstado = 2
405:             *-- Estado PROCESSANDO: bloquear input durante geracao
406:             THIS.chk_4c_GeraArquivos.Enabled = .F.
407:             THIS.chk_4c_GeraIndices.Enabled  = .F.
408:             THIS.cmd_4c_OK.Enabled           = .F.
409:             THIS.cmd_4c_Cancela.Enabled      = .F.
410:             THIS.this_lProcessando           = .T.
411:             THIS.lbl_4c_Mensagem.Caption     = "Processando..."
412:             THIS.Refresh()
413: 
414:         CASE loc_nEstado = 3
415:             *-- Estado CONCLUIDO: reabilitar UI, preservar mensagem final
416:             THIS.chk_4c_GeraArquivos.Enabled = .T.
417:             THIS.chk_4c_GeraIndices.Enabled  = .T.
418:             THIS.cmd_4c_OK.Enabled           = .T.
419:             THIS.cmd_4c_Cancela.Enabled      = .T.
420:             THIS.this_lProcessando           = .F.
421:             THIS.Refresh()
422:         ENDCASE
423:     ENDPROC
424: 

*-- Linhas 443 a 478:
443:             THIS.this_oBusinessObject.this_lGeraArquivos = (THIS.chk_4c_GeraArquivos.Value = 1)
444:             IF THIS.chk_4c_GeraArquivos.Value = 1
445:                 IF !THIS.this_oBusinessObject.GerarEstrutura(loc_lcDirAtual)
446:                     THIS.lbl_4c_Mensagem.Caption = "Erro ao gerar estrutura."
447:                     loc_lContinuar = .F.
448:                 ENDIF
449:             ENDIF
450: 
451:             *-- Etapa 2: Gerar indices (somente se etapa 1 OK)
452:             IF loc_lContinuar
453:                 CLOSE TABLES ALL
454:                 THIS.this_oBusinessObject.this_lGeraIndices = (THIS.chk_4c_GeraIndices.Value = 1)
455:                 IF THIS.chk_4c_GeraIndices.Value = 1
456:                     IF !THIS.this_oBusinessObject.GerarIndices(loc_lcDirAtual)
457:                         THIS.lbl_4c_Mensagem.Caption = THIS.this_oBusinessObject.this_cMensagem
458:                         loc_lContinuar = .F.
459:                     ENDIF
460:                 ENDIF
461:             ENDIF
462: 
463:             *-- Finalizacao
464:             IF loc_lContinuar
465:                 CLOSE TABLES ALL
466:                 THIS.lbl_4c_Mensagem.Caption = "Processamento Finalizado."
467:                 THIS.this_oBusinessObject.CarregarLogo()
468:             ENDIF
469: 
470:         CATCH TO loc_oErro
471:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
472:                 " PROC=" + loc_oErro.Procedure, "Erro no Processamento")
473:             THIS.lbl_4c_Mensagem.Caption = "Erro no processamento."
474:         ENDTRY
475: 
476:         *-- Estado 3 = CONCLUIDO (reabilita UI, preserva mensagem final)
477:         THIS.AlternarPagina(3)
478:     ENDPROC

*-- Linhas 539 a 547:
539:             loc_cMsg = "Diret" + CHR(243) + "rio n" + CHR(227) + "o encontrado: " + loc_cDir
540:         ENDIF
541: 
542:         THIS.lbl_4c_Mensagem.Caption = loc_cMsg
543:         THIS.Refresh()
544:     ENDPROC
545: 
546:     *--------------------------------------------------------------------------
547:     * BtnExcluirClick - Fluxo "Excluir/cancelar processamento"

*-- Linhas 666 a 684:
666: 
667:         THIS.chk_4c_GeraArquivos.Enabled = loc_lHab
668:         THIS.chk_4c_GeraIndices.Enabled  = loc_lHab
669:         THIS.cmd_4c_OK.Enabled           = loc_lHab
670:         THIS.cmd_4c_Cancela.Enabled      = loc_lHab
671:     ENDPROC
672: 
673:     *--------------------------------------------------------------------------
674:     * LimparCampos - Reseta o dialog para o estado inicial (ambas opcoes marcadas)
675:     *--------------------------------------------------------------------------
676:     PROCEDURE LimparCampos()
677:         THIS.chk_4c_GeraArquivos.Value = 1
678:         THIS.chk_4c_GeraIndices.Value  = 1
679:         THIS.lbl_4c_Mensagem.Caption   = ""
680:         THIS.this_lProcessando         = .F.
681:         THIS.HabilitarCampos(.T.)
682:         IF THIS.chk_4c_GeraArquivos.Enabled
683:             THIS.chk_4c_GeraArquivos.SetFocus()
684:         ENDIF


### BO (C:\4c\projeto\app\classes\SIGPRESTBO.prg):
*==============================================================================
* SIGPRESTBO.prg - Business Object para Gerar Estrutura de Arquivos
* Herda de: BusinessBase
* Autor: Sistema 4C
*==============================================================================

DEFINE CLASS SIGPRESTBO AS BusinessBase

    *-- Configuracao da entidade
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Opcoes de processamento
    this_lGeraArquivos = .T.
    this_lGeraIndices  = .T.

    *-- Estado do processamento
    this_cMensagem    = ""
    this_cDirAtual    = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF TYPE("lGeraArquivos") = "L"
                THIS.this_lGeraArquivos = lGeraArquivos
            ENDIF
            IF TYPE("lGeraIndices") = "L"
                THIS.this_lGeraIndices = lGeraIndices
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarEstrutura - Escaneia DBFs locais e grava estrutura em ArqDBF.DBF
    *--------------------------------------------------------------------------
    FUNCTION GerarEstrutura(par_cDirAtual)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_lnArq, loc_lcArquivo, loc_lnGeraArq
        LOCAL loc_lcDbc, loc_lnCampos, loc_lnCCampos, loc_lcCampo, loc_loBarra
        LOCAL loc_laArq[1], loc_laCampos[1]

        loc_lSucesso = .F.

        TRY
            SET SAFETY OFF
            SET DEFAULT TO (par_cDirAtual)

            IF USED("ArqDBF")
                USE IN ArqDBF
            ENDIF
            IF FILE("ArqDBF.DBF")
                DELETE FILE ArqDBF.DBF
            ENDIF
            IF FILE("ArqDBF.CDX")
                DELETE FILE ArqDBF.CDX
            ENDIF

            SELECT 0
            CREATE TABLE ArqDBF FREE ( ;
                Arquivos c(20), Dbcs c(50), Campos c(20), Tipos c(1), ;
                Tamanhos n(3), Fracaos n(2), C_05s l, C_06s l, ;
                C_07s c(20), C_08s c(20), C_09s c(20), C_10s c(20), ;
                C_11s c(20), C_12s c(20), C_13s c(20), C_14s c(20), ;
                C_15s c(20), C_16s c(20) )

            INDEX ON Arquivos + Campos TAG ArqCamp

            loc_lnArq = ADIR(loc_laArq, '*.Dbf')
            IF loc_lnArq > 0
                ASORT(loc_laArq)
            ENDIF

            loc_loBarra = CREATEOBJECT('fwProgressBar', ;
                'Processando Estrutura de Arquivos.', loc_lnArq)
            loc_loBarra.Titulo.FontBold = .T.
            loc_loBarra.Show

            FOR loc_lnGeraArq = 1 TO loc_lnArq
                loc_lcArquivo = loc_laArq(loc_lnGeraArq, 1)

                loc_loBarra.Update(.T.)
                loc_loBarra.SubTitulo.Caption = ;
                    'Processando Arquivo : ' + ALLTRIM(loc_lcArquivo)

                IF INLIST(ALLTRIM(UPPER(loc_lcArquivo)), ;
                    'ARQDBF.DBF', 'ARQIND.DBF', 'FOXUSER.DBF')
                    LOOP
                ENDIF

                USE &loc_lcArquivo IN 0 ALIAS TmpArquivo AGAIN

                SELECT TmpArquivo
                loc_lcDbc    = ALLTRIM(JUSTFNAME(CURSORGETPROP("DataBase")))
                loc_lnCampos = AFIELDS(loc_laCampos)

                FOR loc_lnCCampos = 1 TO loc_lnCampos
                    IF loc_lnCCampos = 1
                        IF EMPTY(loc_laCampos(loc_lnCCampos, 12))
                            loc_laCampos(loc_lnCCampos, 12) = ;
                                STRTRAN(loc_lcArquivo, '.DBF', '')
                        ENDIF
                    ENDIF
                    loc_lcCampo = PADR(UPPER( ;
                        ALLTRIM(JUSTSTEM(loc_lcArquivo)) + '.' + ;
                        ALLTRIM(loc_laCampos(loc_lnCCampos, 1))), 64)

                    SELECT ArqDBF
                    INSERT INTO ArqDBF ( ;
                        Arquivos, Dbcs, Campos, Tipos, ;
                        Tamanhos, Fracaos, C_05s, C_06s, ;
                        C_07s, C_08s, C_09s, C_10s, ;
                        C_11s, C_12s, C_13s, C_14s, ;
                        C_15s, C_16s ) ;
                    VALUES ( ;
                        loc_lcArquivo, loc_lcDbc, ;
                        loc_laCampos(loc_lnCCampos, 1), ;
                        loc_laCampos(loc_lnCCampos, 2), ;
                        loc_laCampos(loc_lnCCampos, 3), ;
                        loc_laCampos(loc_lnCCampos, 4), ;
                        loc_laCampos(loc_lnCCampos, 5), ;
                        loc_laCampos(loc_lnCCampos, 6), ;
                        loc_laCampos(loc_lnCCampos, 7), ;
                        loc_laCampos(loc_lnCCampos, 8), ;
                        loc_laCampos(loc_lnCCampos, 9), ;
                        loc_laCampos(loc_lnCCampos, 10), ;
                        loc_laCampos(loc_lnCCampos, 11), ;
                        loc_laCampos(loc_lnCCampos, 12), ;
                        loc_laCampos(loc_lnCCampos, 13), ;
                        loc_laCampos(loc_lnCCampos, 14), ;
                        loc_laCampos(loc_lnCCampos, 15), ;
                        loc_laCampos(loc_lnCCampos, 16) )
                ENDFOR

                USE IN TmpArquivo
            ENDFOR

            loc_loBarra.Complete("Finalizando Processo de Estrutura.")

            THIS.this_cDirAtual = par_cDirAtual
            THIS.this_cMensagem = "Estrutura gerada com sucesso."
            THIS.RegistrarAuditoria("GERAR_ESTRUTURA")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha: " + ;
                TRANSFORM(loc_oErro.LineNo) + ")", ;
                "Erro ao Gerar Estrutura")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarIndices - Escaneia CDX dos DBFs locais e grava em ArqInd.DBF
    *--------------------------------------------------------------------------
    FUNCTION GerarIndices(par_cDirAtual)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_lnArq, loc_lcArquivo, loc_lnGeraInd
        LOCAL loc_lnKey, loc_lcChave, loc_lcFiltro, loc_lcTag, loc_loBarra
        LOCAL loc_laArq[1]

        loc_lSucesso = .F.

        TRY
            SET SAFETY OFF
            SET DEFAULT TO (par_cDirAtual)

            IF !FILE("ArqDBF.DBF")
                MsgAviso("Antes de gerar os " + CHR(205) + "ndices, " + ;
                    CHR(233) + " necess" + CHR(225) + "rio que seja gerada " + ;
                    "a Estrutura de Arquivos...", "Aviso")
                THIS.this_cMensagem = "Processamento Interrompido."
            ELSE
                IF USED("ArqDBF")
                    USE IN ArqDBF
                ENDIF
                SELECT 0
                USE ArqDBF ORDER ArqCamp

                loc_lnArq = ADIR(loc_laArq, '*.Dbf')
                IF loc_lnArq > 0
                    ASORT(loc_laArq)
                ENDIF

                IF USED("ArqInd")
                    USE IN ArqInd
                ENDIF
                IF FILE('ArqInd.DBF')
                    DELETE FILE ArqInd.DBF
                ENDIF
                IF FILE('ArqInd.CDX')
                    DELETE FILE ArqInd.CDX
                ENDIF

                CREATE TABLE ArqInd FREE ( ;
                    Arquivos c(20), Tags c(15), ;
                    Indices c(240), Filtros c(240), ;
                    Indexs l, c_12s c(20) )
                INDEX ON Arquivos + Tags TAG Arquivos
                INDEX ON Arquivos TAG Temp UNIQUE

                loc_loBarra = CREATEOBJECT('fwProgressBar', ;
                    'Processando ' + CHR(205) + 'ndices de Arquivos.', loc_lnArq)
                loc_loBarra.Titulo.FontBold = .T.
                loc_loBarra.Show

                FOR loc_lnGeraInd = 1 TO loc_lnArq
                    loc_lcArquivo = loc_laArq(loc_lnGeraInd, 1)

                    loc_loBarra.Update(.T.)
                    loc_loBarra.SubTitulo.Caption = ;
                        'Processando Arquivo : ' + ALLTRIM(loc_lcArquivo)

                    IF INLIST(ALLTRIM(UPPER(loc_lcArquivo)), ;
                        'ARQDBF.DBF', 'ARQIND.DBF', 'FOXUSER.DBF')
                        LOOP
                    ENDIF

                    SELECT 0
                    USE &loc_lcArquivo ALIAS TmpArquivo AGAIN

                    loc_lnKey = 1
                    DO WHILE !EMPTY(TAG(loc_lnKey))
                        loc_lcChave  = KEY(loc_lnKey)
                        loc_lcFiltro = SYS(2021, loc_lnKey)
                        loc_lcTag    = TAG(loc_lnKey)

                        INSERT INTO ArqInd ( Arquivos, Tags, Indices, Filtros ) ;
                        VALUES ( loc_lcArquivo, loc_lcTag, loc_lcChave, loc_lcFiltro )

                        SELECT TmpArquivo
                        loc_lnKey = loc_lnKey + 1
                    ENDDO
                    USE
                ENDFOR

                loc_loBarra.Complete("Finalizando Processo de " + CHR(205) + "ndice.")

                THIS.this_cDirAtual = par_cDirAtual
                THIS.this_cMensagem = CHR(205) + "ndices gerados com sucesso."
                THIS.RegistrarAuditoria("GERAR_INDICES")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha: " + ;
                TRANSFORM(loc_oErro.LineNo) + ")", ;
                "Erro ao Gerar " + CHR(205) + "ndices")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarLogo - Carrega logo da empresa via SQL Server
    *--------------------------------------------------------------------------
    FUNCTION CarregarLogo()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED('csLogoTipo')
                SQLEXEC(gnConnHandle, ;
                    "SELECT Logos FROM SigCdPam", "csLogoTipo")
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Carregar Logo")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Operacao CRUD nao aplicavel a BO utilitario OPERACIONAL
    * SIGPREST nao tem tabela transacional (this_cTabela = "")
    * Para gerar estrutura/indices use GerarEstrutura() e GerarIndices()
    * Mantido por compatibilidade com a interface generica do pipeline
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "BO utilit" + CHR(225) + "rio n" + CHR(227) + ;
            "o suporta opera" + CHR(231) + CHR(245) + "es CRUD. " + ;
            "Use GerarEstrutura() e GerarIndices()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao CRUD nao aplicavel a BO utilitario OPERACIONAL
    * SIGPREST nao tem tabela transacional (this_cTabela = "")
    * Para gerar estrutura/indices use GerarEstrutura() e GerarIndices()
    * Mantido por compatibilidade com a interface generica do pipeline
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "BO utilit" + CHR(225) + "rio n" + CHR(227) + ;
            "o suporta opera" + CHR(231) + CHR(245) + "es CRUD. " + ;
            "Use GerarEstrutura() e GerarIndices()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Operacao CRUD nao aplicavel a BO utilitario OPERACIONAL
    * SIGPREST nao tem tabela transacional (this_cTabela = "")
    * Mantido por compatibilidade com a interface generica do pipeline
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "BO utilit" + CHR(225) + "rio n" + CHR(227) + ;
            "o suporta opera" + CHR(231) + CHR(245) + "es CRUD."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do processo de geracao em LogAuditoria
    * Loga qual operacao foi executada (Estrutura, Indices ou ambas)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cDescricao, loc_cUsuario, loc_cOperacao
        LOCAL loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cOperacao = IIF(EMPTY(par_cOperacao), "PROCESS", ALLTRIM(par_cOperacao))
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               ALLTRIM(gc_4c_UsuarioLogado), "SYSTEM")

            loc_cDescricao = "Utilit" + CHR(225) + "rio: SIGPREST (Gerar Estrutura)"
            IF THIS.this_lGeraArquivos
                loc_cDescricao = loc_cDescricao + " | Estrutura=Sim"
            ELSE
                loc_cDescricao = loc_cDescricao + " | Estrutura=Nao"
            ENDIF
            IF THIS.this_lGeraIndices
                loc_cDescricao = loc_cDescricao + " | " + CHR(205) + "ndices=Sim"
            ELSE
                loc_cDescricao = loc_cDescricao + " | " + CHR(205) + "ndices=Nao"
            ENDIF
            IF !EMPTY(THIS.this_cDirAtual)
                loc_cDescricao = loc_cDescricao + " | Dir=" + ALLTRIM(THIS.this_cDirAtual)
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria" + ;
                       " (Usuario, DataHora, Operacao, Tabela, ChavePrimaria, Descricao)" + ;
                       " VALUES (" + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(loc_cOperacao) + ", " + ;
                       EscaparSQL("SIGPREST") + ", " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(loc_cDescricao) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResultado >= 0)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha: " + ;
                TRANSFORM(loc_oErro.LineNo) + ")", ;
                "Erro em RegistrarAuditoria")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

