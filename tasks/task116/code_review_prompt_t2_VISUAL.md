# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGREIDC): Top original=201 vs migrado 'lbl_4c_Label4' Top=116 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGREIDC): Top original=201 vs migrado 'lbl_4c_Label5' Top=116 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREIDC.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1198 linhas total):

*-- Linhas 9 a 17:
9: *   - Conta     (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdCli, GerBals=1)
10: *   - Linha Inicial  (1-5)
11: *   - Coluna Inicial (1-2)
12: *   - Imprimir Logotipo (checkbox)
13: *==============================================================================
14: 
15: DEFINE CLASS FormSIGREIDC AS FormBase
16: 
17:     *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia (EXATAS do original: Width=800, Height=300)

*-- Linhas 52 a 60:
52:         loc_lSucesso   = .F.
53:         loc_lContinuar = .T.
54:         TRY
55:             THIS.Caption = "Relat" + CHR(243) + "rio de Identifica" + ;
56:                 CHR(231) + CHR(227) + "o de Contas"
57: 
58:             IF TYPE("gc_4c_CaminhoIcones") = "U"
59:                 gc_4c_CaminhoIcones = ""
60:             ENDIF

*-- Linhas 88 a 97:
88:                 *-- PageFrame com p" + CHR(225) + "gina de filtros
89:                 THIS.ConfigurarPageFrame()
90: 
91:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
92:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
93: 
94:                 *-- Campos de filtro na Page1 do PageFrame
95:                 THIS.ConfigurarPaginaLista()
96: 
97:                 *-- Vincular Click dos bot" + CHR(245) + "es de relat" + CHR(243) + "rio

*-- Linhas 123 a 164:
123:     PROTECTED PROCEDURE ConfigurarCabecalho()
124:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
125:         WITH THIS.cnt_4c_Cabecalho
126:             .Top         = 0
127:             .Left        = 0
128:             .Width       = THIS.Width
129:             .Height      = 80
130:             .BackStyle   = 1
131:             .BackColor   = RGB(100, 100, 100)
132:             .BorderWidth = 0
133:             .Visible     = .T.
134: 
135:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
136:             .AddObject("lbl_4c_Sombra", "Label")
137:             WITH .lbl_4c_Sombra
138:                 .Top       = 22
139:                 .Left      = 22
140:                 .Width     = THIS.Width
141:                 .Height    = 30
142:                 .Caption   = "Relat" + CHR(243) + "rio de Identifica" + ;
143:                     CHR(231) + CHR(227) + "o de Contas"
144:                 .FontName  = "Tahoma"
145:                 .FontSize  = 14
146:                 .FontBold  = .T.
147:                 .ForeColor = RGB(0, 0, 0)
148:                 .BackStyle = 0
149:                 .Visible   = .T.
150:             ENDWITH
151: 
152:             *-- T" + CHR(237) + "tulo em branco (sobre a sombra)
153:             .AddObject("lbl_4c_Titulo", "Label")
154:             WITH .lbl_4c_Titulo
155:                 .Top       = 20
156:                 .Left      = 20
157:                 .Width     = THIS.Width
158:                 .Height    = 30
159:                 .Caption   = "Relat" + CHR(243) + "rio de Identifica" + ;
160:                     CHR(231) + CHR(227) + "o de Contas"
161:                 .FontName  = "Tahoma"
162:                 .FontSize  = 14
163:                 .FontBold  = .T.
164:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 170 a 202:
170: 
171:     *--------------------------------------------------------------------------
172:     * ConfigurarBotoes - CommandGroup de bot" + CHR(245) + "es do relat" + CHR(243) + "rio (btnReport area)
173:     *   Original: btnReport.Left=526, Top=4, Height=80, Width=273
174:     *   Bot" + CHR(245) + "es: Visualiza(6), Imprime(72), DocExcel(138), Sair(204)
175:     *--------------------------------------------------------------------------
176:     PROTECTED PROCEDURE ConfigurarBotoes()
177:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
178:         WITH THIS.cmg_4c_Botoes
179:             .Top           = 0
180:             .Left          = 529
181:             .Width         = 273
182:             .Height        = 80
183:             .ButtonCount   = 4
184:             .BackStyle     = 0
185:             .BorderStyle   = 0
186:             .BorderColor   = RGB(136, 189, 188)
187:             .SpecialEffect = 1
188:             .Themes        = .F.
189:             .Visible       = .T.
190: 
191:             *-- Visualizar (preview em tela)
192:             WITH .Buttons(1)
193:                 .Top             = 5
194:                 .Left            = 5
195:                 .Width           = 65
196:                 .Height          = 70
197:                 .Caption         = "Visualizar"
198:                 .FontBold        = .T.
199:                 .FontItalic      = .T.
200:                 .BackColor       = RGB(255, 255, 255)
201:                 .ForeColor       = RGB(90, 90, 90)
202:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 210 a 222:
210: 
211:             *-- Imprimir (impressora padr" + CHR(227) + "o)
212:             WITH .Buttons(2)
213:                 .Top             = 5
214:                 .Left            = 71
215:                 .Width           = 65
216:                 .Height          = 70
217:                 .Caption         = "Imprimir"
218:                 .FontName        = "Tahoma"
219:                 .FontBold        = .T.
220:                 .FontItalic      = .T.
221:                 .FontSize        = 8
222:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 232 a 244:
232: 
233:             *-- Excel (exportar dados)
234:             WITH .Buttons(3)
235:                 .Top             = 5
236:                 .Left            = 137
237:                 .Width           = 65
238:                 .Height          = 70
239:                 .Caption         = "Excel"
240:                 .FontName        = "Tahoma"
241:                 .FontBold        = .T.
242:                 .FontItalic      = .T.
243:                 .FontSize        = 8
244:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 254 a 266:
254: 
255:             *-- Encerrar (fechar form - tecla ESC)
256:             WITH .Buttons(4)
257:                 .Top             = 5
258:                 .Left            = 203
259:                 .Width           = 65
260:                 .Height          = 70
261:                 .Caption         = "Encerrar"
262:                 .Cancel          = .T.
263:                 .FontName        = "Tahoma"
264:                 .FontBold        = .T.
265:                 .FontItalic      = .T.
266:                 .FontSize        = 8

*-- Linhas 291 a 306:
291:         loc_oPgf.PageCount = 1
292: 
293:         *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho (80px) at" + CHR(233) + " o fim do form
294:         loc_oPgf.Top    = 85
295:         loc_oPgf.Left   = -1
296:         loc_oPgf.Width  = THIS.Width + 2
297:         loc_oPgf.Height = THIS.Height - 85
298:         loc_oPgf.Tabs   = .F.
299: 
300:         *-- Configurar Page1 (FORA de qualquer WITH - usar refer" + CHR(234) + "ncia direta)
301:         loc_oPgf.Page1.Caption   = "Filtros"
302:         loc_oPgf.Page1.FontName  = "Tahoma"
303:         loc_oPgf.Page1.FontSize  = 8
304:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
305:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
306:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 330 a 357:
330:         loc_oPg = THIS.pgf_4c_Paginas.Page1
331: 
332:         *-- Label "Grupo :"
333:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
334:         WITH loc_oPg.lbl_4c_Label1
335:             .Top       = 60
336:             .Left      = 213
337:             .Width     = 38
338:             .Height    = 15
339:             .Caption   = "Grupo :"
340:             .FontName  = "Tahoma"
341:             .FontSize  = 8
342:             .ForeColor = RGB(90, 90, 90)
343:             .BackStyle = 0
344:             .AutoSize  = .T.
345:             .Visible   = .T.
346:         ENDWITH
347: 
348:         *-- C" + CHR(243) + "digo do Grupo (F4 -> SigCdGcr GerBals=1)
349:         loc_oPg.AddObject("txt_4c_CdGrupo", "TextBox")
350:         WITH loc_oPg.txt_4c_CdGrupo
351:             .Top         = 56
352:             .Left        = 255
353:             .Width       = 79
354:             .Height      = 25
355:             .Value       = ""
356:             .MaxLength   = 10
357:             .Format      = "K"

*-- Linhas 366 a 375:
366:         *-- Descri" + CHR(231) + CHR(227) + "o do Grupo (preenchida pelo lookup)
367:         loc_oPg.AddObject("txt_4c_DsGrupo", "TextBox")
368:         WITH loc_oPg.txt_4c_DsGrupo
369:             .Top         = 56
370:             .Left        = 336
371:             .Width       = 150
372:             .Height      = 25
373:             .Value       = ""
374:             .MaxLength   = 20
375:             .Format      = "K"

*-- Linhas 382 a 409:
382:         ENDWITH
383: 
384:         *-- Label "Conta :"
385:         loc_oPg.AddObject("lbl_4c_LblEstoque", "Label")
386:         WITH loc_oPg.lbl_4c_LblEstoque
387:             .Top       = 88
388:             .Left      = 213
389:             .Width     = 38
390:             .Height    = 15
391:             .Caption   = "Conta :"
392:             .FontName  = "Tahoma"
393:             .FontSize  = 8
394:             .ForeColor = RGB(90, 90, 90)
395:             .BackStyle = 0
396:             .AutoSize  = .T.
397:             .Visible   = .T.
398:         ENDWITH
399: 
400:         *-- C" + CHR(243) + "digo da Conta (F4 -> SigCdCli, filtrado por Grupo)
401:         loc_oPg.AddObject("txt_4c_CdConta", "TextBox")
402:         WITH loc_oPg.txt_4c_CdConta
403:             .Top         = 83
404:             .Left        = 255
405:             .Width       = 79
406:             .Height      = 25
407:             .Value       = ""
408:             .MaxLength   = 10
409:             .Format      = "K"

*-- Linhas 418 a 427:
418:         *-- Descri" + CHR(231) + CHR(227) + "o da Conta (preenchida pelo lookup)
419:         loc_oPg.AddObject("txt_4c_DsConta", "TextBox")
420:         WITH loc_oPg.txt_4c_DsConta
421:             .Top         = 83
422:             .Left        = 336
423:             .Width       = 290
424:             .Height      = 25
425:             .Value       = ""
426:             .MaxLength   = 40
427:             .Format      = "K"

*-- Linhas 434 a 461:
434:         ENDWITH
435: 
436:         *-- Label "Linha Inicial :"
437:         loc_oPg.AddObject("lbl_4c_Label5", "Label")
438:         WITH loc_oPg.lbl_4c_Label5
439:             .Top       = 116
440:             .Left      = 187
441:             .Width     = 64
442:             .Height    = 15
443:             .Caption   = "Linha Inicial :"
444:             .FontName  = "Tahoma"
445:             .FontSize  = 8
446:             .ForeColor = RGB(90, 90, 90)
447:             .BackStyle = 0
448:             .AutoSize  = .T.
449:             .Visible   = .T.
450:         ENDWITH
451: 
452:         *-- Linha inicial (1-5)
453:         loc_oPg.AddObject("txt_4c_Linha", "TextBox")
454:         WITH loc_oPg.txt_4c_Linha
455:             .Top         = 110
456:             .Left        = 255
457:             .Width       = 27
458:             .Height      = 25
459:             .Value       = 1
460:             .Format      = "KL"
461:             .InputMask   = "99"

*-- Linhas 470 a 497:
470:         ENDWITH
471: 
472:         *-- Label "Coluna Inicial :"
473:         loc_oPg.AddObject("lbl_4c_Label4", "Label")
474:         WITH loc_oPg.lbl_4c_Label4
475:             .Top       = 116
476:             .Left      = 287
477:             .Width     = 72
478:             .Height    = 15
479:             .Caption   = "Coluna Inicial :"
480:             .FontName  = "Tahoma"
481:             .FontSize  = 8
482:             .ForeColor = RGB(90, 90, 90)
483:             .BackStyle = 0
484:             .AutoSize  = .T.
485:             .Visible   = .T.
486:         ENDWITH
487: 
488:         *-- Coluna inicial (1-2)
489:         loc_oPg.AddObject("txt_4c_Coluna", "TextBox")
490:         WITH loc_oPg.txt_4c_Coluna
491:             .Top         = 110
492:             .Left        = 376
493:             .Width       = 27
494:             .Height      = 25
495:             .Value       = 1
496:             .Format      = "KL"
497:             .InputMask   = "99"

*-- Linhas 505 a 521:
505:             .Visible     = .T.
506:         ENDWITH
507: 
508:         *-- CheckBox "Imprimir Logotipo"
509:         loc_oPg.AddObject("chk_4c_OptLogo", "CheckBox")
510:         WITH loc_oPg.chk_4c_OptLogo
511:             .Top       = 117
512:             .Left      = 438
513:             .Width     = 100
514:             .Height    = 15
515:             .Value     = 0
516:             .Caption   = "Imprimir Logotipo"
517:             .FontName  = "Tahoma"
518:             .FontSize  = 8
519:             .ForeColor = RGB(90, 90, 90)
520:             .BackStyle = 0
521:             .AutoSize  = .T.

*-- Linhas 1097 a 1110:
1097:             ENDIF
1098:             loc_oPg = THIS.pgf_4c_Paginas.Page1
1099:             WITH THIS.this_oRelatorio
1100:                 loc_oPg.txt_4c_CdGrupo.Value  = .this_cCdGrupo
1101:                 loc_oPg.txt_4c_DsGrupo.Value  = .this_cDsGrupo
1102:                 loc_oPg.txt_4c_CdConta.Value  = .this_cCdConta
1103:                 loc_oPg.txt_4c_DsConta.Value  = .this_cDsConta
1104:                 loc_oPg.txt_4c_Linha.Value    = .this_nLinha
1105:                 loc_oPg.txt_4c_Coluna.Value   = .this_nColuna
1106:                 loc_oPg.chk_4c_OptLogo.Value  = IIF(.this_lImprimirLogo, 1, 0)
1107:             ENDWITH
1108:             THIS.AtualizarEstadoCamposDescricao()
1109:         CATCH TO loc_oErro
1110:             MsgErro(loc_oErro.Message, "Erro")


### BO (C:\4c\projeto\app\classes\SIGREIDCBO.prg):
*==============================================================================
* SIGREIDCBO.PRG
* Business Object para Relatorio de Identificacao de Contas (SIGREIDC)
* Herda de RelatorioBase
*
* Filtros:
*   this_cCdGrupo  / this_cDsGrupo  - Grupo contabil (SigCdGcr)
*   this_cCdConta  / this_cDsConta  - Conta (SigCdCli)
*   this_nLinha    - Linha inicial (1-5)
*   this_nColuna   - Coluna inicial (1-2)
*   this_lImprimirLogo - Imprimir logotipo
*==============================================================================

DEFINE CLASS SIGREIDCBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cCdGrupo       = ""
    this_cDsGrupo       = ""
    this_cCdConta       = ""
    this_cDsConta       = ""
    this_nLinha         = 1
    this_nColuna        = 1
    this_lImprimirLogo  = .F.

    *-- Configuracao do relatorio
    this_cNomeRelatorio = "SigReIdc"
    this_cCursorDados   = "cursor_4c_Dados"

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cTabela     = "SigCdCli"
            THIS.this_cCampoChave = "Iclis"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREIDCBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Carrega parametros iniciais do sistema.
    * Chamado pelo form em InicializarForm() apos instanciar o BO.
    * Equivalente ao bloco do Init() legado que carrega SigCdPam e SigCdGcr.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Logo da empresa (Logos de SigCdPam) - usado em PrepararDados
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT GrPadClis, Logos FROM SigCdPam", ;
                "cursor_4c_Pam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar par" + CHR(226) + ;
                    "metros do sistema (SigCdPam)"
            ENDIF

            *-- Grupos contabeis GerBals=1 para lookup do campo Grupo no form
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT a.Codigos, a.Descrs FROM SigCdGcr a " + ;
                "WHERE a.GerBals=1 ORDER BY a.Codigos", ;
                "cursor_4c_Grupos")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar grupos cont" + CHR(225) + "beis"
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREIDCBO.InicializarFiltros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor local cIde com dados para SigReIdc.frx.
    * Equivalente ao metodo 'processamento' do form legado SIGREIDC.
    *
    * Fluxo:
    *   1. Obtem razao social em SigCdEmp
    *   2. Busca contas em SigCdCli (filtros Grupos/Iclis + GerBals=1)
    *   3. Cria cursor local cIde com estrutura exata esperada pelo FRX
    *   4. Insere linhas em branco de offset (calculo Linha/Coluna)
    *   5. Para cada conta: insere linha, processa logo e foto
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_cEmpresas, loc_nNregi, loc_nI
        LOCAL loc_lcCgrupo, loc_lcCconta, loc_nLinha, loc_nColuna
        LOCAL loc_cArqJpg, loc_cDirTemp
        loc_lSucesso = .F.
        TRY
            *-- Razao social da empresa
            loc_cEmpresas = ""
            loc_cSQL = "SELECT TOP 1 Razas FROM SigCdEmp"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpIdc")
            IF loc_nResult > 0
                SELECT cursor_4c_EmpIdc
                IF !EOF()
                    loc_cEmpresas = ALLTRIM(cursor_4c_EmpIdc.Razas)
                ENDIF
                USE IN cursor_4c_EmpIdc
            ENDIF

            *-- Garantir que cursor de logo esta aberto
            IF !USED("cursor_4c_Pam")
                SQLEXEC(gnConnHandle, ;
                    "SELECT GrPadClis, Logos FROM SigCdPam", ;
                    "cursor_4c_Pam")
            ENDIF

            *-- Capturar filtros
            loc_lcCgrupo = ALLTRIM(THIS.this_cCdGrupo)
            loc_lcCconta = ALLTRIM(THIS.this_cCdConta)
            loc_nLinha   = THIS.this_nLinha
            loc_nColuna  = THIS.this_nColuna

            *-- Montar WHERE: replicar logica do original (conta sobrescreve grupo)
            *   Original: se ambos informados, lcSel = IClis filter (sobreescrito)
            *   O SCAN adicionalmente filtra por grupo - aqui unificado no SQL
            loc_cWhere = "a.GerBals = 1"
            IF !EMPTY(loc_lcCgrupo)
                loc_cWhere = loc_cWhere + " AND a.Grupos = " + EscaparSQL(loc_lcCgrupo)
            ENDIF
            IF !EMPTY(loc_lcCconta)
                loc_cWhere = loc_cWhere + " AND a.Iclis = " + EscaparSQL(loc_lcCconta)
            ENDIF

            *-- Query principal: contas filtradas com campos de foto
            loc_cSQL = "SELECT a.Iclis, a.Rclis, a.Grupos, a.Figuras, a.FigJpgs " + ;
                "FROM SigCdCli a " + ;
                "WHERE " + loc_cWhere + ;
                " ORDER BY a.Grupos, a.Iclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContasIdc")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar contas para o relat" + ;
                    CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            *-- Fechar cursor de saida anterior se existir
            IF USED("cIde")
                USE IN cIde
            ENDIF

            *-- Criar cursor local com estrutura exata esperada pelo FRX SigReIdc
            CREATE CURSOR cIde ( ;
                cEmpresas C(50), ;
                cTitulo1s C(50), ;
                cGrupos   C(10), ;
                cContas   C(10), ;
                cDcontas  C(50), ;
                gLogos    C(64), ;
                gFotos    G(4) NULL, ;
                cArqJpgs  C(254), ;
                lBrancos  L(1))

            *-- Calcular offset de linhas em branco: ((Linha-1)+(Coluna-1))*5
            loc_nNregi = ((loc_nLinha - 1) + (loc_nColuna - 1)) * 5
            FOR loc_nI = 1 TO loc_nNregi
                INSERT INTO cIde ;
                    (cEmpresas, cTitulo1s, cGrupos, cContas, cDcontas, ;
                     gLogos, cArqJpgs, lBrancos) ;
                    VALUES ("", "", "", "", "", "", "", .T.)
            ENDFOR

            *-- Diretorio temporario para arquivos JPG de logo/foto
            loc_cDirTemp = ALLTRIM(SYS(2023))
            IF RIGHT(loc_cDirTemp, 1) != "\"
                loc_cDirTemp = loc_cDirTemp + "\"
            ENDIF

            *-- Processar cada conta
            SELECT cursor_4c_ContasIdc
            SCAN
                loc_cArqJpg = ""

                *-- Logo da empresa: copiar memo para JPG temporario
                IF THIS.this_lImprimirLogo
                    SELECT cursor_4c_Pam
                    IF !EOF() AND !ISNULL(cursor_4c_Pam.Logos) AND ;
                       !EMPTY(cursor_4c_Pam.Logos)
                        loc_cArqJpg = loc_cDirTemp + SYS(3) + ".Jpg"
                        COPY MEMO cursor_4c_Pam.Logos TO (loc_cArqJpg)
                    ENDIF
                    SELECT cursor_4c_ContasIdc
                ENDIF

                *-- Inserir linha de dados no cursor cIde
                INSERT INTO cIde ;
                    (cEmpresas, cTitulo1s, cGrupos, cContas, cDcontas, ;
                     gLogos, cArqJpgs, lBrancos) ;
                    VALUES ( ;
                        loc_cEmpresas, ;
                        "IDENTIFICA" + CHR(199) + CHR(195) + "O", ;
                        ALLTRIM(cursor_4c_ContasIdc.Grupos), ;
                        ALLTRIM(cursor_4c_ContasIdc.Iclis), ;
                        ALLTRIM(cursor_4c_ContasIdc.Rclis), ;
                        loc_cArqJpg, ;
                        loc_cArqJpg, ;
                        .F.)

                *-- Foto do cliente: Figuras (blob) tem prioridade sobre FigJpgs (memo)
                IF !ISNULL(cursor_4c_ContasIdc.Figuras)
                    SELECT cIde
                    GO BOTTOM
                    REPLACE gFotos WITH cursor_4c_ContasIdc.Figuras
                    SELECT cursor_4c_ContasIdc
                ELSE
                    IF !EMPTY(cursor_4c_ContasIdc.FigJpgs)
                        LOCAL loc_cArqFoto
                        loc_cArqFoto = loc_cDirTemp + SYS(3) + ".Jpg"
                        COPY MEMO cursor_4c_ContasIdc.FigJpgs TO (loc_cArqFoto)
                        SELECT cIde
                        GO BOTTOM
                        REPLACE cArqJpgs WITH loc_cArqFoto
                        SELECT cursor_4c_ContasIdc
                    ENDIF
                ENDIF

            ENDSCAN

            IF USED("cursor_4c_ContasIdc")
                USE IN cursor_4c_ContasIdc
            ENDIF

            SELECT cIde
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREIDCBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica filtros antes da impressao.
    * Equivalente as validacoes em btnReport.Click do legado SIGREIDC.
    *
    * Valida: existencia de Grupo em SigCdGcr, Conta em SigCdCli,
    * Linha entre 1-5, Coluna entre 1-2.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        LOCAL loc_lValido, loc_cSQL, loc_nResult, loc_nExiste
        loc_lValido = .T.
        TRY
            *-- Validar Grupo (se informado, deve existir em SigCdGcr)
            IF !EMPTY(ALLTRIM(THIS.this_cCdGrupo))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdGcr " + ;
                    "WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCdGrupo))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrupo")
                IF loc_nResult > 0
                    SELECT cursor_4c_ValGrupo
                    loc_nExiste = IIF(!EOF(), cursor_4c_ValGrupo.nExiste, 0)
                    USE IN cursor_4c_ValGrupo
                    IF loc_nExiste = 0
                        THIS.this_cMensagemErro = "Grupo Inv" + CHR(225) + "lido."
                        loc_lValido = .F.
                    ENDIF
                ENDIF
            ENDIF

            *-- Validar Conta (se informada, deve existir em SigCdCli)
            IF loc_lValido AND !EMPTY(ALLTRIM(THIS.this_cCdConta))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCli " + ;
                    "WHERE Iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdConta))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValConta")
                IF loc_nResult > 0
                    SELECT cursor_4c_ValConta
                    loc_nExiste = IIF(!EOF(), cursor_4c_ValConta.nExiste, 0)
                    USE IN cursor_4c_ValConta
                    IF loc_nExiste = 0
                        THIS.this_cMensagemErro = "Conta Inv" + CHR(225) + "lida."
                        loc_lValido = .F.
                    ENDIF
                ENDIF
            ENDIF

            *-- Validar Linha inicial (1 a 5)
            IF loc_lValido AND !BETWEEN(THIS.this_nLinha, 1, 5)
                THIS.this_cMensagemErro = "Linha Inicial Inv" + CHR(225) + "lida."
                loc_lValido = .F.
            ENDIF

            *-- Validar Coluna inicial (1 a 2)
            IF loc_lValido AND !BETWEEN(THIS.this_nColuna, 1, 2)
                THIS.this_cMensagemErro = "Coluna Inicial Inv" + CHR(225) + "lida."
                loc_lValido = .F.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREIDCBO.ValidarFiltros")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparArquivosTemporarios - Remove arquivos JPG temporarios de logos e
    * fotos criados em PrepararDados. Deve ser chamado pelo form apos
    * REPORT FORM (impressao ou preview).
    * Equivalente ao bloco de limpeza em btnReport.Click do legado.
    *--------------------------------------------------------------------------
    PROCEDURE LimparArquivosTemporarios()
        LOCAL loc_cArqJpgs, loc_cGLogos
        TRY
            IF USED("cIde")
                SELECT cIde
                SCAN
                    loc_cArqJpgs = ALLTRIM(cIde.cArqJpgs)
                    loc_cGLogos  = ALLTRIM(cIde.gLogos)
                    IF !EMPTY(loc_cArqJpgs) AND FILE(loc_cArqJpgs)
                        DELETE FILE (loc_cArqJpgs)
                    ENDIF
                    IF !EMPTY(loc_cGLogos) AND loc_cGLogos != loc_cArqJpgs ;
                       AND FILE(loc_cGLogos)
                        DELETE FILE (loc_cGLogos)
                    ENDIF
                ENDSCAN
                USE IN cIde
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREIDCBO.LimparArquivosTemporarios")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorios nao persistem dados
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de identifica" + CHR(231) + CHR(227) + ;
            "o de contas n" + CHR(227) + "o grava registros."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorios nao persistem dados
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de identifica" + CHR(231) + CHR(227) + ;
            "o de contas n" + CHR(227) + "o altera registros."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a mensagem de erro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores abertos por InicializarFiltros e PrepararDados
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        IF USED("cursor_4c_Grupos")
            USE IN cursor_4c_Grupos
        ENDIF
        IF USED("cursor_4c_ContasIdc")
            USE IN cursor_4c_ContasIdc
        ENDIF
        IF USED("cursor_4c_EmpIdc")
            USE IN cursor_4c_EmpIdc
        ENDIF
        IF USED("cIde")
            USE IN cIde
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

