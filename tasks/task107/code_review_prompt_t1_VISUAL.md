# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [NAVEGACAO-PAGINA] Metodo 'BtnIncluirClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'BtnVisualizarClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'BtnAlterarClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigReGla.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (753 linhas total):

*-- Linhas 53 a 64:
53:                 THIS.ConfigurarContaineresPage2()
54:                 THIS.ConfigurarPaginaDados()
55: 
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
57:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
58:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
59:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
60: 
61:                 *-- Torna controles visiveis
62:                 THIS.pgf_4c_Paginas.Visible = .T.
63:                 THIS.pgf_4c_Paginas.ActivePage = 1
64: 

*-- Linhas 89 a 104:
89:     PROTECTED PROCEDURE ConfigurarPageFrame()
90:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
91:         WITH THIS.pgf_4c_Paginas
92:             .Top       = -29
93:             .Left      = 0
94:             .Width     = THIS.Width
95:             .Height    = THIS.Height + 29
96:             .PageCount = 2
97:             .Tabs      = .F.
98:             .Page1.Caption = "Lista"
99:             .Page2.Caption = "Dados"
100:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:         ENDWITH
103:     ENDPROC
104: 

*-- Linhas 114 a 180:
114:         *-- Container cabecalho escuro (cntSombra do framework)
115:         loc_oPage.AddObject("cnt_4c_Cabecalho", "Container")
116:         WITH loc_oPage.cnt_4c_Cabecalho
117:             .Top         = 31
118:             .Left        = 0
119:             .Width       = THIS.Width
120:             .Height      = 54
121:             .BackStyle   = 1
122:             .BackColor   = RGB(100, 100, 100)
123:             .BorderWidth = 0
124:             .Visible     = .T.
125:         ENDWITH
126: 
127:         loc_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
128:         WITH loc_oPage.cnt_4c_Cabecalho.lbl_4c_Sombra
129:             .Top       = 16
130:             .Left      = 11
131:             .Width     = THIS.Width - 22
132:             .Height    = 26
133:             .FontName  = "Tahoma"
134:             .FontSize  = 14
135:             .FontBold  = .T.
136:             .ForeColor = RGB(0, 0, 0)
137:             .BackStyle = 0
138:             .Caption   = "Form1"
139:             .Visible   = .T.
140:         ENDWITH
141: 
142:         loc_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
143:         WITH loc_oPage.cnt_4c_Cabecalho.lbl_4c_Titulo
144:             .Top       = 14
145:             .Left      = 10
146:             .Width     = THIS.Width - 22
147:             .Height    = 26
148:             .FontName  = "Tahoma"
149:             .FontSize  = 14
150:             .FontBold  = .T.
151:             .ForeColor = RGB(255, 255, 255)
152:             .BackStyle = 0
153:             .Caption   = "Form1"
154:             .Visible   = .T.
155:         ENDWITH
156: 
157:         *-- Container botoes CRUD (canonico: Left=542, Width=390, lado direito)
158:         loc_oPage.AddObject("cnt_4c_Botoes", "Container")
159:         WITH loc_oPage.cnt_4c_Botoes
160:             .Top         = 29
161:             .Left        = 542
162:             .Width       = 390
163:             .Height      = 85
164:             .BackStyle   = 0
165:             .BorderWidth = 0
166:             .Visible     = .T.
167:         ENDWITH
168: 
169:         loc_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
170:         WITH loc_oPage.cnt_4c_Botoes.cmd_4c_Incluir
171:             .Top             = 5
172:             .Left            = 5
173:             .Width           = 75
174:             .Height          = 75
175:             .Caption         = "Incluir"
176:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
177:             .FontName        = "Tahoma"
178:             .FontSize        = 8
179:             .FontBold        = .T.
180:             .FontItalic      = .T.

*-- Linhas 189 a 203:
189:             .Visible         = .T.
190:         ENDWITH
191: 
192:         loc_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
193:         WITH loc_oPage.cnt_4c_Botoes.cmd_4c_Visualizar
194:             .Top             = 5
195:             .Left            = 80
196:             .Width           = 75
197:             .Height          = 75
198:             .Caption         = "Visualizar"
199:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
200:             .FontName        = "Tahoma"
201:             .FontSize        = 8
202:             .FontBold        = .T.
203:             .FontItalic      = .T.

*-- Linhas 212 a 226:
212:             .Visible         = .T.
213:         ENDWITH
214: 
215:         loc_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
216:         WITH loc_oPage.cnt_4c_Botoes.cmd_4c_Alterar
217:             .Top             = 5
218:             .Left            = 155
219:             .Width           = 75
220:             .Height          = 75
221:             .Caption         = "Alterar"
222:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
223:             .FontName        = "Tahoma"
224:             .FontSize        = 8
225:             .FontBold        = .T.
226:             .FontItalic      = .T.

*-- Linhas 235 a 249:
235:             .Visible         = .T.
236:         ENDWITH
237: 
238:         loc_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
239:         WITH loc_oPage.cnt_4c_Botoes.cmd_4c_Excluir
240:             .Top             = 5
241:             .Left            = 230
242:             .Width           = 75
243:             .Height          = 75
244:             .Caption         = "Excluir"
245:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
246:             .FontName        = "Tahoma"
247:             .FontSize        = 8
248:             .FontBold        = .T.
249:             .FontItalic      = .T.

*-- Linhas 258 a 272:
258:             .Visible         = .T.
259:         ENDWITH
260: 
261:         loc_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
262:         WITH loc_oPage.cnt_4c_Botoes.cmd_4c_Buscar
263:             .Top             = 5
264:             .Left            = 305
265:             .Width           = 75
266:             .Height          = 75
267:             .Caption         = "Buscar"
268:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
269:             .FontName        = "Tahoma"
270:             .FontSize        = 8
271:             .FontBold        = .T.
272:             .FontItalic      = .T.

*-- Linhas 284 a 307:
284:         *-- Container Encerrar (canonico: Left=917, Width=90)
285:         loc_oPage.AddObject("cnt_4c_Saida", "Container")
286:         WITH loc_oPage.cnt_4c_Saida
287:             .Top         = 29
288:             .Left        = 917
289:             .Width       = 90
290:             .Height      = 85
291:             .BackStyle   = 0
292:             .BorderWidth = 0
293:             .Visible     = .T.
294:         ENDWITH
295: 
296:         loc_oPage.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
297:         WITH loc_oPage.cnt_4c_Saida.cmd_4c_Encerrar
298:             .Top             = 5
299:             .Left            = 5
300:             .Width           = 75
301:             .Height          = 75
302:             .Caption         = "Encerrar"
303:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
304:             .FontName        = "Tahoma"
305:             .FontSize        = 8
306:             .FontBold        = .T.
307:             .FontItalic      = .T.

*-- Linhas 319 a 328:
319:         *-- Grid de lista (RecordSource sera definido em CarregarLista)
320:         loc_oPage.AddObject("grd_4c_Lista", "Grid")
321:         WITH loc_oPage.grd_4c_Lista
322:             .Top                = 117
323:             .Left               = 26
324:             .Width              = 890
325:             .Height             = 443
326:             .FontName           = "Verdana"
327:             .FontSize           = 8
328:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 340 a 353:
340:         ENDWITH
341: 
342:         *-- BINDEVENTs (somente metodos PUBLIC)
343:         BINDEVENT(loc_oPage.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
344:         BINDEVENT(loc_oPage.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
345:         BINDEVENT(loc_oPage.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
346:         BINDEVENT(loc_oPage.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
347:         BINDEVENT(loc_oPage.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
348:         BINDEVENT(loc_oPage.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
349:         BINDEVENT(loc_oPage.grd_4c_Lista,                    "DblClick", THIS, "GrdListaDblClick")
350:     ENDPROC
351: 
352:     *--------------------------------------------------------------------------
353:     * ConfigurarContaineresPage2 - Containers basicos da pagina Dados

*-- Linhas 359 a 368:
359:         *-- Container de botoes de acao em Page2
360:         loc_oPage.AddObject("cnt_4c_BotoesAcao", "Container")
361:         WITH loc_oPage.cnt_4c_BotoesAcao
362:             .Top        = 33
363:             .Left       = 0
364:             .Width      = THIS.Width
365:             .Height     = 85
366:             .BackStyle  = 0
367:             .BorderWidth = 0
368:             .Visible    = .T.

*-- Linhas 380 a 435:
380:         *-- Container cabecalho escuro (identico ao de Page1)
381:         loc_oPage.AddObject("cnt_4c_Cabecalho", "Container")
382:         WITH loc_oPage.cnt_4c_Cabecalho
383:             .Top         = 31
384:             .Left        = 0
385:             .Width       = THIS.Width
386:             .Height      = 54
387:             .BackStyle   = 1
388:             .BackColor   = RGB(100, 100, 100)
389:             .BorderWidth = 0
390:             .Visible     = .T.
391:         ENDWITH
392: 
393:         loc_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
394:         WITH loc_oPage.cnt_4c_Cabecalho.lbl_4c_Sombra
395:             .Top       = 16
396:             .Left      = 11
397:             .Width     = THIS.Width - 22
398:             .Height    = 26
399:             .FontName  = "Tahoma"
400:             .FontSize  = 14
401:             .FontBold  = .T.
402:             .ForeColor = RGB(0, 0, 0)
403:             .BackStyle = 0
404:             .Caption   = "Form1"
405:             .Visible   = .T.
406:         ENDWITH
407: 
408:         loc_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
409:         WITH loc_oPage.cnt_4c_Cabecalho.lbl_4c_Titulo
410:             .Top       = 14
411:             .Left      = 10
412:             .Width     = THIS.Width - 22
413:             .Height    = 26
414:             .FontName  = "Tahoma"
415:             .FontSize  = 14
416:             .FontBold  = .T.
417:             .ForeColor = RGB(255, 255, 255)
418:             .BackStyle = 0
419:             .Caption   = "Form1"
420:             .Visible   = .T.
421:         ENDWITH
422: 
423:         *-- Botao Confirmar
424:         loc_oPage.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
425:         WITH loc_oPage.cnt_4c_BotoesAcao.cmd_4c_Confirmar
426:             .Top             = 5
427:             .Left            = 5
428:             .Width           = 75
429:             .Height          = 75
430:             .Caption         = "Confirmar"
431:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
432:             .FontName        = "Tahoma"
433:             .FontSize        = 8
434:             .FontBold        = .T.
435:             .FontItalic      = .T.

*-- Linhas 445 a 459:
445:         ENDWITH
446: 
447:         *-- Botao Cancelar
448:         loc_oPage.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
449:         WITH loc_oPage.cnt_4c_BotoesAcao.cmd_4c_Cancelar
450:             .Top             = 5
451:             .Left            = 80
452:             .Width           = 75
453:             .Height          = 75
454:             .Caption         = "Encerrar"
455:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
456:             .FontName        = "Tahoma"
457:             .FontSize        = 8
458:             .FontBold        = .T.
459:             .FontItalic      = .T.

*-- Linhas 469 a 478:
469:         ENDWITH
470: 
471:         *-- BINDEVENTs
472:         BINDEVENT(loc_oPage.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
473:         BINDEVENT(loc_oPage.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
474:     ENDPROC
475: 
476:     *--------------------------------------------------------------------------
477:     * TornarControlesVisiveis - Torna controles de container visiveis
478:     * Iteracao recursiva sobre Controls e Pages

*-- Linhas 538 a 546:
538:             loc_oGrid.ColumnCount    = 1
539:             loc_oGrid.RecordSource   = "cursor_4c_Dados"
540:             loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.cCodigo"
541:             loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
542: 
543:             THIS.FormatarGridLista(loc_oGrid)
544:             loc_lSucesso = .T.
545: 
546:         CATCH TO loc_oErro

*-- Linhas 570 a 582:
570:         loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
571: 
572:         WITH loc_oCnt
573:             .cmd_4c_Incluir.Enabled    = .T.
574:             .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
575:             .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
576:             .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
577:             .cmd_4c_Buscar.Enabled     = .T.
578:         ENDWITH
579:     ENDPROC
580: 
581:     *--------------------------------------------------------------------------
582:     * BtnIncluirClick - Navega para Page2 em modo INCLUIR

*-- Linhas 699 a 707:
699: 
700:         TRY
701:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
702:             loc_oCnt.cmd_4c_Confirmar.Enabled = par_lEditar
703:         CATCH TO loc_oErro
704:             MsgErro(loc_oErro.Message, "Erro")
705:         ENDTRY
706:     ENDPROC
707: 


### BO (C:\4c\projeto\app\classes\SigReGlaBO.prg):
*==============================================================================
* SIGREG LABO.PRG
* Business Object para formulario operacional SigReGla
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigReGlaBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao da entidade
    * Form OPERACIONAL sem tabela CRUD - sem chave primaria
    *--------------------------------------------------------------------------
    this_cTabela     = ""
    this_cCampoChave = ""

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    * Form operacional sem campos CRUD - implementacao vazia
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria
    * Form operacional sem tabela CRUD
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro
    * Form operacional sem tabela CRUD - nao ha insercao
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .T.

        TRY
            THIS.RegistrarAuditoria("I")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente
    * Form operacional sem tabela CRUD - nao ha atualizacao
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .T.

        TRY
            THIS.RegistrarAuditoria("A")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

