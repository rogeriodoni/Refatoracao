# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 195: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 222: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrDsc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1035 linhas total):

*-- Linhas 11 a 21:
11: * Layout original (800px) escalado para 1000px (fator 1.25)
12: * Estrutura flat:
13: *   cnt_4c_Cabecalho (Top=0, L=0, W=1000, H=80)
14: *   cmd_4c_Encerrar  (Top=3, L=910, W=75, H=75) - standalone sobre cabecalho
15: *   cmd_4c_Atualizar (Top=3, L=825, W=75, H=75) - standalone sobre cabecalho
16: *   Labels filtros + txt_4c_CProsI/F + txt_4c_CGrus + cmd_4c_Selecionar (Top=135)
17: *   grd_4c_Dados     (Top=164, L=15, W=960, H=343)
18: *==============================================================================
19: 
20: DEFINE CLASS FormSigPrDsc AS FormBase
21: 

*-- Linhas 57 a 65:
57: 
58:         TRY
59:             *-- Caption com acentos via CHR()
60:             THIS.Caption = "Montagem de Descri" + CHR(231) + CHR(227) + "o de Produtos"
61: 
62:             *-- Criar Business Object
63:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrDscBO")
64:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
65: 

*-- Linhas 138 a 175:
138: 
139:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
140:         WITH THIS.cnt_4c_Cabecalho
141:             .Top         = 0
142:             .Left        = 0
143:             .Width       = 1000
144:             .Height      = 80
145:             .BackStyle   = 1
146:             .BackColor   = RGB(100, 100, 100)
147:             .BorderWidth = 0
148: 
149:             .AddObject("lbl_4c_Sombra", "Label")
150:             WITH .lbl_4c_Sombra
151:                 .Top      = 18
152:                 .Left     = 10
153:                 .Width    = THIS.Width
154:                 .Height   = 40
155:                 .Caption  = loc_cCaption
156:                 .FontName = "Tahoma"
157:                 .FontSize = 18
158:                 .FontBold = .T.
159:                 .BackStyle = 0
160:                 .AutoSize  = .F.
161:                 .ForeColor = RGB(0, 0, 0)
162:             ENDWITH
163: 
164:             .AddObject("lbl_4c_Titulo", "Label")
165:             WITH .lbl_4c_Titulo
166:                 .Top      = 17
167:                 .Left     = 10
168:                 .Width    = THIS.Width
169:                 .Height   = 46
170:                 .Caption  = loc_cCaption
171:                 .FontName = "Tahoma"
172:                 .FontSize = 18
173:                 .FontBold = .T.
174:                 .BackStyle = 0
175:                 .AutoSize  = .F.

*-- Linhas 182 a 360:
182:     PROTECTED PROCEDURE ConfigurarBotoes
183:     *==========================================================================
184:         *-- btnSair (Encerrar): Top=3, Left=725 no legado 800px -> Left=905 em 1000px
185:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
186:         WITH THIS.cmd_4c_Encerrar
187:             .Top             = 3
188:             .Left            = 905
189:             .Width           = 75
190:             .Height          = 75
191:             .Caption         = "Encerrar"
192:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
193:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
194:             .Themes          = .T.
195:             .FontName        = "Comic Sans MS"
196:             .FontSize        = 8
197:             .FontBold        = .T.
198:             .FontItalic      = .T.
199:             .ForeColor       = RGB(90, 90, 90)
200:             .BackColor       = RGB(255, 255, 255)
201:             .SpecialEffect   = 0
202:             .PicturePosition = 13
203:             .MousePointer    = 15
204:             .WordWrap        = .T.
205:             .AutoSize        = .F.
206:             .Cancel          = .T.
207:             .ZOrderSet       = 1
208:         ENDWITH
209:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
210: 
211:         *-- btnAtualizar: Top=3, Left=650 no legado 800px -> Left=820 em 1000px
212:         THIS.AddObject("cmd_4c_Atualizar", "CommandButton")
213:         WITH THIS.cmd_4c_Atualizar
214:             .Top             = 3
215:             .Left            = 820
216:             .Width           = 75
217:             .Height          = 75
218:             .Caption         = "Atualizar"
219:             .Picture         = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
220:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
221:             .Themes          = .T.
222:             .FontName        = "Comic Sans MS"
223:             .FontSize        = 8
224:             .FontBold        = .T.
225:             .FontItalic      = .T.
226:             .ForeColor       = RGB(90, 90, 90)
227:             .BackColor       = RGB(255, 255, 255)
228:             .SpecialEffect   = 0
229:             .PicturePosition = 13
230:             .MousePointer    = 15
231:             .WordWrap        = .T.
232:             .AutoSize        = .F.
233:             .Enabled         = .F.
234:         ENDWITH
235:         BINDEVENT(THIS.cmd_4c_Atualizar, "Click", THIS, "BtnAtualizarClick")
236:     ENDPROC
237: 
238:     *==========================================================================
239:     PROTECTED PROCEDURE ConfigurarFiltros
240:     *==========================================================================
241:         *-- "Produtos de :" Say3 - Left=155 em 800px -> Left=194 em 1000px
242:         THIS.AddObject("lbl_4c_LblProdutos", "Label")
243:         WITH THIS.lbl_4c_LblProdutos
244:             .Top      = 138
245:             .Left     = 194
246:             .Width    = 95
247:             .Height   = 18
248:             .Caption  = "Produtos de :"
249:             .FontName = "Tahoma"
250:             .FontSize = 8
251:             .FontBold = .T.
252:             .AutoSize = .F.
253:             .ForeColor = RGB(90, 90, 90)
254:             .BackStyle = 0
255:         ENDWITH
256: 
257:         *-- getCProsI - Left=233 em 800px -> Left=291 em 1000px
258:         THIS.AddObject("txt_4c_CProsI", "TextBox")
259:         WITH THIS.txt_4c_CProsI
260:             .Top       = 135
261:             .Left      = 291
262:             .Width     = 135
263:             .Height    = 23
264:             .Value     = ""
265:             .MaxLength = 14
266:             .Format    = "K"
267:             .FontName  = "Tahoma"
268:             .FontSize  = 8
269:         ENDWITH
270:         BINDEVENT(THIS.txt_4c_CProsI, "KeyPress", THIS, "TxtCProsIKeyPress")
271: 
272:         *-- "ate" label - Say1 Left=345 em 800px -> Left=431 em 1000px
273:         THIS.AddObject("lbl_4c_Ate", "Label")
274:         WITH THIS.lbl_4c_Ate
275:             .Top      = 138
276:             .Left     = 431
277:             .Width    = 26
278:             .Height   = 18
279:             .Caption  = "at" + CHR(233)
280:             .FontName = "Tahoma"
281:             .FontSize = 8
282:             .FontBold = .T.
283:             .AutoSize = .F.
284:             .ForeColor = RGB(90, 90, 90)
285:             .BackStyle = 0
286:         ENDWITH
287: 
288:         *-- getCProsF - Left=370 em 800px -> Left=462 em 1000px
289:         THIS.AddObject("txt_4c_CProsF", "TextBox")
290:         WITH THIS.txt_4c_CProsF
291:             .Top       = 135
292:             .Left      = 462
293:             .Width     = 135
294:             .Height    = 23
295:             .Value     = ""
296:             .MaxLength = 14
297:             .Format    = "K"
298:             .FontName  = "Tahoma"
299:             .FontSize  = 8
300:         ENDWITH
301:         BINDEVENT(THIS.txt_4c_CProsF, "KeyPress", THIS, "TxtCProsFKeyPress")
302: 
303:         *-- "Grupo de Produto :" - Say2 Left=505 em 800px -> Left=631 em 1000px
304:         THIS.AddObject("lbl_4c_LblGrupo", "Label")
305:         WITH THIS.lbl_4c_LblGrupo
306:             .Top      = 138
307:             .Left     = 631
308:             .Width    = 134
309:             .Height   = 18
310:             .Caption  = "Grupo de Produto :"
311:             .FontName = "Tahoma"
312:             .FontSize = 8
313:             .FontBold = .T.
314:             .AutoSize = .F.
315:             .ForeColor = RGB(90, 90, 90)
316:             .BackStyle = 0
317:         ENDWITH
318: 
319:         *-- getCGrus - Left=614 em 800px -> Left=768 em 1000px
320:         THIS.AddObject("txt_4c_CGrus", "TextBox")
321:         WITH THIS.txt_4c_CGrus
322:             .Top       = 135
323:             .Left      = 768
324:             .Width     = 39
325:             .Height    = 23
326:             .Value     = ""
327:             .MaxLength = 3
328:             .Format    = "K"
329:             .FontName  = "Tahoma"
330:             .FontSize  = 8
331:         ENDWITH
332:         BINDEVENT(THIS.txt_4c_CGrus, "KeyPress", THIS, "TxtCGrusKeyPress")
333: 
334:         *-- btnSelecionar (arrow/search) - Left=744 em 800px -> Left=818 em 1000px
335:         *-- Original: a_arrow6.bmp (nao portado) -> usar geral_procura_60.jpg
336:         THIS.AddObject("cmd_4c_Selecionar", "CommandButton")
337:         WITH THIS.cmd_4c_Selecionar
338:             .Top             = 116
339:             .Left            = 818
340:             .Width           = 75
341:             .Height          = 27
342:             .Caption         = "Selecionar"
343:             .Picture         = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
344:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
345:             .Themes          = .T.
346:             .FontName        = "Tahoma"
347:             .FontSize        = 8
348:             .FontBold        = .T.
349:             .ForeColor       = RGB(90, 90, 90)
350:             .BackColor       = RGB(255, 255, 255)
351:             .SpecialEffect   = 0
352:             .MousePointer    = 15
353:             .ToolTipText     = "Selecionar"
354:         ENDWITH
355:         BINDEVENT(THIS.cmd_4c_Selecionar, "Click", THIS, "BtnSelecionarClick")
356:     ENDPROC
357: 
358:     *==========================================================================
359:     * ConfigurarPaginaDados - configura area de input/filtros (equivalente Page2 Dados)
360:     * Em OPERACIONAL flat, os TextBoxes de entrada (CProsI, CProsF, CGrus) e Labels

*-- Linhas 389 a 398:
389:         *-- Grade - Top=164, Left=15, Width=769 em 800px -> Width=960 em 1000px
390:         THIS.AddObject("grd_4c_Dados", "Grid")
391:         WITH THIS.grd_4c_Dados
392:             .Top               = 164
393:             .Left              = 15
394:             .Width             = 960
395:             .Height            = 343
396:             .ColumnCount       = 3
397:             .RecordSource      = "cursor_4c_Produtos"
398:             .Column1.ControlSource = "cursor_4c_Produtos.CPros"

*-- Linhas 415 a 444:
415:             WITH .Column1
416:                 .ControlSource = "cursor_4c_Produtos.CPros"
417:                 .Width         = 135
418:                 .Header1.Caption   = "C" + CHR(243) + "digo"
419:                 .Header1.FontName  = "Tahoma"
420:                 .Header1.FontSize  = 8
421:                 .Header1.Alignment = 2
422:                 .ReadOnly          = .T.
423:             ENDWITH
424: 
425:             WITH .Column2
426:                 .ControlSource = "cursor_4c_Produtos.Portugues"
427:                 .Width         = 363
428:                 .ReadOnly          = .T.
429:                 .Header1.Caption   = "Portugu" + CHR(234) + "s"
430:                 .Header1.FontName  = "Tahoma"
431:                 .Header1.FontSize  = 8
432:                 .Header1.Alignment = 2
433:             ENDWITH
434: 
435:             WITH .Column3
436:                 .ControlSource = "cursor_4c_Produtos.Traduzido"
437:                 .Width         = 424
438:                 .ReadOnly          = .T.
439:                 .Header1.Caption   = "Traduzido"
440:                 .Header1.FontName  = "Tahoma"
441:                 .Header1.FontSize  = 8
442:                 .Header1.Alignment = 2
443:             ENDWITH
444:         ENDWITH

*-- Linhas 500 a 508:
500:         LOCAL loc_lSucesso, loc_oErro
501:         loc_lSucesso = .F.
502:         TRY
503:             THIS.cmd_4c_Atualizar.Enabled = .F.
504:             loc_lSucesso = THIS.this_oBusinessObject.GravarDescricoes()
505:             IF loc_lSucesso
506:                 LOCAL loc_nTotal
507:                 loc_nTotal = THIS.this_oBusinessObject.this_nTotalGravados
508:                 MsgInfo("Foram gravados " + TRANSFORM(loc_nTotal) + " produto(s).", ;

*-- Linhas 547 a 568:
547:                 loc_lSucesso = THIS.this_oBusinessObject.ProcessarTraducoes()
548: 
549:                 IF loc_lSucesso
550:                     THIS.cmd_4c_Atualizar.Enabled = .T.
551:                 ELSE
552:                     THIS.cmd_4c_Atualizar.Enabled = .F.
553:                 ENDIF
554: 
555:                 *-- Recarregar grid (ColumnCount ANTES de RecordSource - regra critica)
556:                 THIS.grd_4c_Dados.ColumnCount  = 3
557:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
558:                 THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.CPros"
559:                 THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.Portugues"
560:                 THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.Traduzido"
561:                 THIS.grd_4c_Dados.Column1.Header1.Caption = "C" + CHR(243) + "digo"
562:                 THIS.grd_4c_Dados.Column2.Header1.Caption = "Portugu" + CHR(234) + "s"
563:                 THIS.grd_4c_Dados.Column3.Header1.Caption = "Traduzido"
564:                 SELECT cursor_4c_Produtos
565:                 GO TOP
566:                 THIS.grd_4c_Dados.Refresh()
567: 
568:             ENDIF && filtros preenchidos

*-- Linhas 833 a 841:
833:                 THIS.grd_4c_Dados.Refresh()
834:             ENDIF
835: 
836:             THIS.cmd_4c_Atualizar.Enabled = .F.
837:             THIS.this_cModoAtual = "SELECIONAR"
838: 
839:             *-- Foca no primeiro campo de filtro
840:             THIS.txt_4c_CProsI.SetFocus()
841:         CATCH TO loc_oErro

*-- Linhas 889 a 897:
889:                 *-- Conta registros nao-deletados restantes (COUNT nao aceita IN <alias> em VFP9)
890:                 SELECT cursor_4c_Produtos
891:                 COUNT FOR NOT DELETED() TO loc_nRestantes
892:                 THIS.cmd_4c_Atualizar.Enabled = (loc_nRestantes > 0)
893:             ENDIF
894:         CATCH TO loc_oErro
895:             MsgErro(loc_oErro.Message, "Erro")
896:         ENDTRY
897:     ENDPROC

*-- Linhas 953 a 962:
953:             THIS.txt_4c_CProsF.Enabled = par_lHabilitar
954:             THIS.txt_4c_CGrus.Enabled  = par_lHabilitar
955:         ENDIF
956:         IF PEMSTATUS(THIS, "cmd_4c_Selecionar", 5)
957:             THIS.cmd_4c_Selecionar.Enabled = par_lHabilitar
958:         ENDIF
959:     ENDPROC
960: 
961:     *-- LimparCampos: limpa filtros de selecao e zera o grid de resultados
962:     PROTECTED PROCEDURE LimparCampos

*-- Linhas 975 a 984:
975:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
976:             THIS.grd_4c_Dados.Refresh()
977:         ENDIF
978:         IF PEMSTATUS(THIS, "cmd_4c_Atualizar", 5)
979:             THIS.cmd_4c_Atualizar.Enabled = .F.
980:         ENDIF
981:         THIS.HabilitarCampos(.T.)
982:         THIS.this_cModoAtual = "SELECIONAR"
983:     ENDPROC
984: 

*-- Linhas 994 a 1003:
994:     PROCEDURE AjustarBotoesPorModo
995:         LOCAL loc_lTemProdutos
996:         loc_lTemProdutos = USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
997:         IF PEMSTATUS(THIS, "cmd_4c_Atualizar", 5)
998:             THIS.cmd_4c_Atualizar.Enabled = loc_lTemProdutos
999:         ENDIF
1000:     ENDPROC
1001: 
1002:     *==========================================================================
1003:     PROCEDURE Destroy


### BO (C:\4c\projeto\app\classes\SigPrDscBO.prg):
*==============================================================================
* SigPrDscBO.prg - Business Object para Montagem de Descricao de Produtos
* Herda de BusinessBase
* Tabela principal: SigCdPro (atualiza DscCompras/ObsCompras/DPros)
* Tabelas auxiliares: SigCdDic (dicionario), SigCdGrp, SigCdCor, SigPrPrt
*==============================================================================

DEFINE CLASS SigPrDscBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da entidade
    *--------------------------------------------------------------------------
    this_cTabela     = "SigCdPro"
    this_cCampoChave = "CPros"

    *--------------------------------------------------------------------------
    * Filtros de selecao de produtos
    *--------------------------------------------------------------------------
    this_cCProsI = ""  && produto inicial do intervalo C(14)
    this_cCProsF = ""  && produto final do intervalo   C(14)
    this_cCGrus  = ""  && grupo de produto (filtro alternativo) C(3)

    *--------------------------------------------------------------------------
    * Controle de processamento e gravacao
    *--------------------------------------------------------------------------
    this_nTotalProcessados = 0
    this_nTotalGravados    = 0
    this_lGravadoOk        = .F.

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCProsI + "-" + THIS.this_cCProsF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - mapeia campos do cursor para propriedades do BO
    * Cursor esperado: alias de SigCdPro com ao menos CPros/CGrus
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCProsI = TratarNulo(CPros, "C")
                THIS.this_cCProsF = TratarNulo(CPros, "C")
                THIS.this_cCGrus  = TratarNulo(CGrus, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDicionario - carrega dicionario de traducoes de SigCdDic
    * Popula cursor_4c_Dicionario (Expressao/Traducao, ordenado por tamanho desc)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarDicionario()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dicionario")
                USE IN cursor_4c_Dicionario
            ENDIF
            loc_cSQL = "SELECT Expressao, Traducao " + ;
                       "FROM SigCdDic " + ;
                       "WHERE Idioma = 'INGLES    ' " + ;
                       "ORDER BY LEN(Expressao) DESC, Expressao"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dicionario") < 1
                MsgErro("Falha ao carregar dicion" + CHR(225) + "rio de tradu" + CHR(231) + CHR(245) + "es.", "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutos - SELECT de produtos baseado nos filtros do BO
    * Popula cursor_4c_ProdTemp (CPros apenas - lista de codigos)
    * Pre-requisito: this_cCProsI/F e this_cCGrus ja setados pelo form
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutos()
        LOCAL loc_lSucesso, loc_cSQL, loc_cPrI, loc_cPrF, loc_cGru, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cPrI = PADR(THIS.this_cCProsI, 14)
            loc_cPrF = PADR(THIS.this_cCProsF, 14)
            loc_cGru = PADR(THIS.this_cCGrus, 3)

            IF !EMPTY(ALLTRIM(loc_cGru))
                loc_cSQL = "SELECT CPros FROM SigCdPro " + ;
                           "WHERE CGrus = " + EscaparSQL(ALLTRIM(loc_cGru)) + " " + ;
                           "ORDER BY CPros"
            ELSE
                loc_cSQL = "SELECT CPros FROM SigCdPro " + ;
                           "WHERE CPros BETWEEN " + EscaparSQL(loc_cPrI) + " AND " + EscaparSQL(loc_cPrF) + " " + ;
                           "ORDER BY CPros"
            ENDIF

            IF USED("cursor_4c_ProdTemp")
                USE IN cursor_4c_ProdTemp
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdTemp") < 1
                MsgErro("Falha ao buscar produtos.", "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarTraducoes - processa produtos e preenche cursor_4c_Produtos
    * Equivalente ao PROCEDURE processamento do legado (SIGPRDSC.processamento)
    * Pre-requisito: cursor_4c_Dicionario carregado via BuscarDicionario()
    * Pre-requisito: cursor_4c_Produtos criado pelo form (CREATE CURSOR)
    * Pos-execucao: cursor_4c_Produtos contem (CPros/Portugues/Traduzido/DscCompras/ObsCompras)
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarTraducoes()
        LOCAL loc_lSucesso, loc_cSQL, loc_cPro, loc_cDes, loc_cIni
        LOCAL loc_cIng, loc_nGrD, loc_oProg, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Busca lista de produtos no SQL Server
            IF !THIS.BuscarProdutos()
                loc_lSucesso = .F.
            ENDIF

            IF !USED("cursor_4c_ProdTemp") OR RECCOUNT("cursor_4c_ProdTemp") = 0
                MsgAviso("Nenhum produto encontrado para os filtros informados.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Zera cursor de resultado do form
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                ZAP
            ENDIF

            THIS.this_nTotalProcessados = 0

            loc_oProg = CREATEOBJECT("fwprogressbar", ;
                "Processando Tradu" + CHR(231) + CHR(245) + "es...", ;
                RECCOUNT("cursor_4c_ProdTemp"))
            loc_oProg.Show

            SELECT cursor_4c_ProdTemp
            GO TOP
            SCAN
                loc_cPro = ALLTRIM(cursor_4c_ProdTemp.CPros)

                loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
                loc_oProg.Update(.T.)

                IF !EMPTY(loc_cPro)
                    loc_cDes = ""

                    *-- Busca dados complementares: grupo + cor do produto
                    loc_cSQL = "SELECT a.CPros, a.CGrus, a.CodCors, " + ;
                               "b.DGrus, b.Mercs, b.MontaGrDs, c.Descs " + ;
                               "FROM SigCdPro a " + ;
                               "LEFT JOIN SigCdGrp b ON b.CGrus = a.CGrus " + ;
                               "LEFT JOIN SigCdCor c ON c.Cods = a.CodCors " + ;
                               "WHERE a.CPros = " + EscaparSQL(loc_cPro)

                    IF USED("cursor_4c_LocalPro")
                        USE IN cursor_4c_LocalPro
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") >= 1
                        SELECT cursor_4c_LocalPro
                        GO TOP
                        loc_nGrD = NVL(cursor_4c_LocalPro.MontaGrDs, 0)
                        IF loc_nGrD = 1
                            *-- MontaGrDs=1: incluir descricao do grupo (DGrus) + cor (Descs)
                            loc_cDes = ALLTRIM(;
                                ALLTRIM(NVL(cursor_4c_LocalPro.DGrus, "")) + " " + ;
                                ALLTRIM(NVL(cursor_4c_LocalPro.Descs, "")))
                        ELSE
                            *-- MontaGrDs=0: apenas descricao de cor (Descs)
                            loc_cDes = ALLTRIM(NVL(cursor_4c_LocalPro.Descs, ""))
                        ENDIF

                        IF !EMPTY(loc_cDes)
                            loc_cIng = loc_cDes

                            *-- Aplica substituicoes do dicionario portugues->ingles
                            IF USED("cursor_4c_Dicionario")
                                SELECT cursor_4c_Dicionario
                                GO TOP
                                SCAN
                                    loc_cIng = STRTRAN(loc_cIng, ;
                                        ALLTRIM(cursor_4c_Dicionario.Expressao), ;
                                        ALLTRIM(cursor_4c_Dicionario.Traducao))
                                ENDSCAN
                            ENDIF

                            *-- Remove aspas simples e duplas (protecao SQL)
                            loc_cDes = STRTRAN(STRTRAN(loc_cDes, "'", " "), '"', " ")
                            loc_cIng = STRTRAN(STRTRAN(loc_cIng, "'", " "), '"', " ")

                            *-- Insere no cursor de produtos (DscCompras=traduzido, ObsCompras=portugues)
                            SELECT cursor_4c_Produtos
                            INSERT INTO cursor_4c_Produtos ;
                                (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
                                VALUES (loc_cPro, loc_cDes, loc_cIng, loc_cIng, loc_cDes)

                            THIS.this_nTotalProcessados = THIS.this_nTotalProcessados + 1
                        ENDIF

                        IF USED("cursor_4c_LocalPro")
                            USE IN cursor_4c_LocalPro
                        ENDIF
                    ENDIF
                ENDIF
            ENDSCAN

            loc_oProg.Complete

            SELECT cursor_4c_Produtos
            GO TOP
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarDescricoes - grava descricoes nos produtos (UPDATE SigCdPro)
    * Equivalente ao PROCEDURE gravacao do legado (SIGPRDSC.gravacao)
    * Pre-requisito: cursor_4c_Produtos populado por ProcessarTraducoes()
    * Cada produto: UPDATE SigCdPro + DELETE SigPrPrt com commit individual
    *--------------------------------------------------------------------------
    PROCEDURE GravarDescricoes()
        LOCAL loc_lSucesso, loc_lOks, loc_cSQL, loc_cPro
        LOCAL loc_oProg, loc_nTotal, loc_oErro
        loc_lSucesso = .F.
        loc_lOks     = .T.
        TRY
            IF !USED("cursor_4c_Produtos")
                MsgAviso("Nenhum produto para gravar.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_nTotal = RECCOUNT("cursor_4c_Produtos")
            IF loc_nTotal = 0
                MsgAviso("Nenhum produto para gravar.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            THIS.this_nTotalGravados = 0
            THIS.this_lGravadoOk     = .F.

            loc_oProg = CREATEOBJECT("fwprogressbar", "Gravando Produtos...", loc_nTotal)
            loc_oProg.Show

            SELECT cursor_4c_Produtos
            GO TOP
            SCAN WHILE loc_lOks
                loc_cPro = ALLTRIM(cursor_4c_Produtos.CPros)

                loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
                loc_oProg.Update(.T.)

                *-- UPDATE SigCdPro: DscCompras, ObsCompras, DPros
                loc_cSQL = "UPDATE SigCdPro " + ;
                           "SET DscCompras = " + EscaparSQL(cursor_4c_Produtos.DscCompras) + ", " + ;
                               "ObsCompras = " + EscaparSQL(cursor_4c_Produtos.ObsCompras) + ", " + ;
                               "DPros = " + EscaparSQL(PADR(ALLTRIM(cursor_4c_Produtos.Portugues), 40)) + " " + ;
                           "WHERE CPros = " + EscaparSQL(loc_cPro)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Falha ao atualizar produto " + loc_cPro + " em SigCdPro.", "Erro")
                    loc_lOks = .F.
                ENDIF

                IF loc_lOks
                    *-- DELETE FROM SigPrPrt: remove produto enviado
                    loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_cPro)
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Falha ao excluir produto " + loc_cPro + " de SigPrPrt.", "Erro")
                        loc_lOks = .F.
                    ENDIF
                ENDIF

                IF loc_lOks
                    SQLCOMMIT(gnConnHandle)
                    THIS.this_nTotalGravados = THIS.this_nTotalGravados + 1
                ELSE
                    SQLROLLBACK(gnConnHandle)
                ENDIF
            ENDSCAN

            loc_oProg.Complete

            IF loc_lOks
                THIS.this_lGravadoOk = .T.
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - grava as descricoes traduzidas (equivalente a UPDATE em lote)
    * Form OPERACIONAL: unico caminho de persistencia disponivel.
    * Espelha o botao btnAtualizar do legado -> chama gravacao/GravarDescricoes.
    * RegistrarAuditoria eh disparada dentro de GravarDescricoes ao final do lote.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.GravarDescricoes()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - nao aplicavel a este form OPERACIONAL (nao cria produtos novos)
    * O form atualiza descricoes de produtos ja existentes em SigCdPro.
    * Delegamos a Atualizar para manter contrato de BusinessBase e evitar
    * insercao acidental de registros pelo fluxo padrao Salvar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.Atualizar()
    ENDPROC

ENDDEFINE

