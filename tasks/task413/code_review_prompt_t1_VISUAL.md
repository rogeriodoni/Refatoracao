# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [NAVEGACAO-PAGINA] Metodo 'BtnIncluirClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormFAPP.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (863 linhas total):

*-- Linhas 49 a 58:
49:                     "FormFAPP.InicializarForm")
50:             ELSE
51:                 THIS.ConfigurarPageFrame()
52:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Visible    = .T.
55:                 THIS.pgf_4c_Paginas.ActivePage = 1
56:                 THIS.this_cModoAtual           = "LISTA"
57: 
58:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 81 a 100:
81: 
82:         WITH THIS.pgf_4c_Paginas
83:             .PageCount = 2
84:             .Top       = -29
85:             .Left      = 0
86:             .Width     = THIS.Width
87:             .Height    = THIS.Height + 29
88:             .Tabs      = .F.
89:             .Visible   = .T.
90: 
91:             .Page1.Caption   = "Lista"
92:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
93:             .Page1.BackColor = RGB(255, 255, 255)
94: 
95:             .Page2.Caption   = "Dados"
96:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97:             .Page2.BackColor = RGB(255, 255, 255)
98:         ENDWITH
99: 
100:         THIS.ConfigurarPaginaLista()

*-- Linhas 116 a 153:
116:         *-- Original Top=-1 (vazio). Canonico Top=31 (2+29 compensacao PageFrame)
117:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
118:         WITH loc_oPagina.cnt_4c_Cabecalho
119:             .Top         = 31
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackColor   = RGB(100, 100, 100)
124:             .BorderWidth = 0
125:             .Visible     = .T.
126:         ENDWITH
127: 
128:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
129:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
130:             .Caption   = THIS.Caption
131:             .Top       = 15
132:             .Left      = 10
133:             .Width     = 769
134:             .Height    = 40
135:             .FontName  = "Tahoma"
136:             .FontSize  = 16
137:             .FontBold  = .T.
138:             .ForeColor = RGB(0, 0, 0)
139:             .BackStyle = 0
140:             .AutoSize  = .F.
141:             .Visible   = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
146:             .Caption   = THIS.Caption
147:             .Top       = 18
148:             .Left      = 10
149:             .Width     = 769
150:             .Height    = 46
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.

*-- Linhas 160 a 196:
160:         *-- Container Botoes CRUD (canonico: Left=542, Width=390)
161:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
162:         WITH loc_oPagina.cnt_4c_Botoes
163:             .Top         = 29
164:             .Left        = 542
165:             .Width       = 390
166:             .Height      = 85
167:             .BackStyle   = 0
168:             .BorderWidth = 0
169:             .Visible     = .T.
170:         ENDWITH
171: 
172:         *-- Container Saida - PADRAO CANONICO (prevalece sobre PILAR 1)
173:         *-- Left=917, Width=90, Height=85 - cmd_4c_Encerrar: Left=5, Top=5, W=75, H=75
174:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
175:         WITH loc_oPagina.cnt_4c_Saida
176:             .Top         = 29
177:             .Left        = 917
178:             .Width       = 90
179:             .Height      = 85
180:             .BackStyle   = 0
181:             .BorderWidth = 0
182:             .Visible     = .T.
183:         ENDWITH
184: 
185:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
186:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
187:             .Caption         = "Encerrar"
188:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
189:             .PicturePosition = 13
190:             .Top             = 5
191:             .Left            = 5
192:             .Width           = 75
193:             .Height          = 75
194:             .FontName        = "Tahoma"
195:             .FontBold        = .T.
196:             .FontItalic      = .T.

*-- Linhas 204 a 221:
204:             .AutoSize        = .F.
205:             .Visible         = .T.
206:         ENDWITH
207:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
208: 
209:         *-- Botoes CRUD: Incluir(L=5) / Visualizar(L=80) / Alterar(L=155) / Excluir(L=230) / Buscar(L=305)
210:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
211:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
212:             .Caption         = "Incluir"
213:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
214:             .PicturePosition = 13
215:             .Top             = 5
216:             .Left            = 5
217:             .Width           = 75
218:             .Height          = 75
219:             .FontName        = "Tahoma"
220:             .FontBold        = .T.
221:             .FontItalic      = .T.

*-- Linhas 228 a 244:
228:             .WordWrap        = .T.
229:             .AutoSize        = .F.
230:         ENDWITH
231:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
232: 
233:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
234:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
235:             .Caption         = "Visualizar"
236:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
237:             .PicturePosition = 13
238:             .Top             = 5
239:             .Left            = 80
240:             .Width           = 75
241:             .Height          = 75
242:             .FontName        = "Tahoma"
243:             .FontBold        = .T.
244:             .FontItalic      = .T.

*-- Linhas 251 a 267:
251:             .WordWrap        = .T.
252:             .AutoSize        = .F.
253:         ENDWITH
254:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
255: 
256:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
257:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
258:             .Caption         = "Alterar"
259:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
260:             .PicturePosition = 13
261:             .Top             = 5
262:             .Left            = 155
263:             .Width           = 75
264:             .Height          = 75
265:             .FontName        = "Tahoma"
266:             .FontBold        = .T.
267:             .FontItalic      = .T.

*-- Linhas 274 a 290:
274:             .WordWrap        = .T.
275:             .AutoSize        = .F.
276:         ENDWITH
277:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
278: 
279:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
280:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
281:             .Caption         = "Excluir"
282:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
283:             .PicturePosition = 13
284:             .Top             = 5
285:             .Left            = 230
286:             .Width           = 75
287:             .Height          = 75
288:             .FontName        = "Tahoma"
289:             .FontBold        = .T.
290:             .FontItalic      = .T.

*-- Linhas 297 a 313:
297:             .WordWrap        = .T.
298:             .AutoSize        = .F.
299:         ENDWITH
300:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
301: 
302:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
303:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
304:             .Caption         = "Buscar"
305:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
306:             .PicturePosition = 13
307:             .Top             = 5
308:             .Left            = 305
309:             .Width           = 75
310:             .Height          = 75
311:             .FontName        = "Tahoma"
312:             .FontBold        = .T.
313:             .FontItalic      = .T.

*-- Linhas 320 a 334:
320:             .WordWrap        = .T.
321:             .AutoSize        = .F.
322:         ENDWITH
323:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
324: 
325:         *-- Grid principal: Top=117 (88+29 compensacao), Left=26, Width=890
326:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
327:         WITH loc_oPagina.grd_4c_Lista
328:             .Top                = 117
329:             .Left               = 26
330:             .Width              = 890
331:             .Height             = 478
332:             .ColumnCount        = 2
333:             .FontName           = "Verdana"
334:             .FontSize           = 8

*-- Linhas 345 a 359:
345: 
346:             WITH .Column1
347:                 .Width           = 100
348:                 .Header1.Caption = "C" + CHR(243) + "digo"
349:                 .ControlSource   = "cursor_4c_Dados.cods"
350:             ENDWITH
351: 
352:             WITH .Column2
353:                 .Width           = 787
354:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
355:                 .ControlSource   = "cursor_4c_Dados.descs"
356:             ENDWITH
357:         ENDWITH
358: 
359:         THIS.TornarControlesVisiveis(loc_oPagina)

*-- Linhas 373 a 397:
373:         *-- Canonico: Left=842, Top=33 (4+29), Width=160, Height=85
374:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
375:         WITH loc_oPagina.cnt_4c_Salva
376:             .Top         = 33
377:             .Left        = 842
378:             .Width       = 160
379:             .Height      = 85
380:             .BackStyle = 1
381:             .BackColor = RGB(255, 255, 255)
382:             .BorderWidth = 0
383:             .Visible     = .T.
384:         ENDWITH
385: 
386:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
387:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
388:             .Caption         = "Confirmar"
389:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
390:             .PicturePosition = 13
391:             .Top             = 5
392:             .Left            = 5
393:             .Width           = 75
394:             .Height          = 75
395:             .FontName        = "Tahoma"
396:             .FontBold        = .T.
397:             .FontItalic      = .T.

*-- Linhas 405 a 421:
405:             .AutoSize        = .F.
406:             .Visible         = .T.
407:         ENDWITH
408:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
409: 
410:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
411:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
412:             .Caption         = "Encerrar"
413:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
414:             .PicturePosition = 13
415:             .Top             = 5
416:             .Left            = 80
417:             .Width           = 75
418:             .Height          = 75
419:             .FontName        = "Tahoma"
420:             .FontBold        = .T.
421:             .FontItalic      = .T.

*-- Linhas 429 a 445:
429:             .AutoSize        = .F.
430:             .Visible         = .T.
431:         ENDWITH
432:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
433: 
434:         *-- FASE 5: Campo Codigo (cods - PK, max 20 chars, readonly em ALTERAR)
435:         *-- Posicao: Top=133 (104+29 compensacao PageFrame), Left=30
436:         loc_oPagina.AddObject("lbl_4c_Cods", "Label")
437:         WITH loc_oPagina.lbl_4c_Cods
438:             .Caption   = "C" + CHR(243) + "digo:"
439:             .Top       = 133
440:             .Left      = 30
441:             .Width     = 100
442:             .Height    = 20
443:             .FontName  = "Tahoma"
444:             .FontSize  = 8
445:             .FontBold  = .F.

*-- Linhas 452 a 461:
452:         loc_oPagina.AddObject("txt_4c_Cods", "TextBox")
453:         WITH loc_oPagina.txt_4c_Cods
454:             .Value         = ""
455:             .Top           = 130
456:             .Left          = 135
457:             .Width         = 120
458:             .Height        = 23
459:             .MaxLength     = 20
460:             .FontName      = "Tahoma"
461:             .FontSize      = 8

*-- Linhas 468 a 480:
468: 
469:         *-- Campo Descricao (descs)
470:         *-- Top=163 (133+30 espacamento), Left=30
471:         loc_oPagina.AddObject("lbl_4c_Descs", "Label")
472:         WITH loc_oPagina.lbl_4c_Descs
473:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o:"
474:             .Top       = 163
475:             .Left      = 30
476:             .Width     = 100
477:             .Height    = 20
478:             .FontName  = "Tahoma"
479:             .FontSize  = 8
480:             .FontBold  = .F.

*-- Linhas 487 a 496:
487:         loc_oPagina.AddObject("txt_4c_Descs", "TextBox")
488:         WITH loc_oPagina.txt_4c_Descs
489:             .Value         = ""
490:             .Top           = 160
491:             .Left          = 135
492:             .Width         = 350
493:             .Height        = 23
494:             .MaxLength     = 60
495:             .FontName      = "Tahoma"
496:             .FontSize      = 8

*-- Linhas 525 a 534:
525:                     loc_oGrid.RecordSource       = "cursor_4c_Dados"
526:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
527:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
528:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
529:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
530:                     THIS.FormatarGridLista(loc_oGrid)
531:                 ENDIF
532:             ENDIF
533: 
534:         CATCH TO loc_oErro

*-- Linhas 792 a 804:
792: 
793:         TRY
794:             loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
795:             loc_oCnt.cmd_4c_Incluir.Enabled    = loc_lNoLista
796:             loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lNoLista
797:             loc_oCnt.cmd_4c_Alterar.Enabled    = loc_lNoLista
798:             loc_oCnt.cmd_4c_Excluir.Enabled    = loc_lNoLista
799:             loc_oCnt.cmd_4c_Buscar.Enabled     = loc_lNoLista
800:         CATCH TO loc_oErro
801:             MostrarErro("Erro ao ajustar botoes:" + CHR(13) + ;
802:                 loc_oErro.Message + CHR(13) + ;
803:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
804:                 "FormFAPP.AjustarBotoesPorModo")


### BO (C:\4c\projeto\app\classes\FAPPBO.prg):
*==============================================================================
* FAPPBO.PRG
* Business Object para FAPP (SIGCDFAPP)
*
* Tabela Principal : SigCdFAPP - Cadastro de FAPP
*                                (cods char, descs char)
*
* !!! ATENCAO - VERIFICACAO OBRIGATORIA ANTES DE USO EM PRODUCAO !!!
* O SIGCDFAPP.SCX original estava completamente vazio (sem DataEnvironment,
* sem campos e sem codigo). O nome da tabela 'SigCdFAPP' foi INFERIDO pela
* convencao SigCd* e NAO foi confirmado no schema do banco de dados
* (docs/schema.sql nao contem a tabela SigCdFAPP).
*
* ACOES NECESSARIAS:
*   1. Verificar no SQL Server se a tabela SigCdFAPP existe:
*      SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='SigCdFAPP'
*   2. Se existir: confirmar colunas cods/descs e seus tamanhos exatos.
*   3. Se NAO existir: identificar a tabela real usada por este formulario
*      (menu legado: "Purificacao") e corrigir todos os SQLs neste BO.
*==============================================================================

DEFINE CLASS FAPPBO AS BusinessBase

    *-- Propriedades da entidade (SigCdFAPP)
    this_cCods  = ""   && cods CHAR - Codigo (PK)
    this_cDescs = ""   && descs CHAR - Descricao

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdFAPP"
            THIS.this_cCampoChave = "cods"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "FAPPBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCods)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCods  = TratarNulo(cods,  "C")
                THIS.this_cDescs = TratarNulo(descs, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "FAPPBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCods)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCods)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarCodigoExistente - Verifica se cods ja existe no banco
    *==========================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdFAPP" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkFapp")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkFapp")
                SELECT cursor_4c_ChkFapp
                loc_lExiste = (cursor_4c_ChkFapp.qtd > 0)
                USE IN cursor_4c_ChkFapp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "FAPPBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigCdFAPP
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdFAPP (cods, descs)
                VALUES (
                    <<EscaparSQL(THIS.this_cCods)>>,
                    <<EscaparSQL(THIS.this_cDescs)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir FAPP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "FAPPBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdFAPP
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdFAPP
                SET descs = <<EscaparSQL(THIS.this_cDescs)>>
                WHERE cods = <<EscaparSQL(THIS.this_cCods)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar FAPP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "FAPPBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdFAPP
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdFAPP WHERE cods = " + EscaparSQL(THIS.this_cCods)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir FAPP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "FAPPBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com cods, descs
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cods C(20), descs C(60))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cods, descs FROM SigCdFAPP"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY cods"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar FAPP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar FAPP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "FAPPBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cods)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs FROM SigCdFAPP" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("FAPP n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar FAPP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "FAPPBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

