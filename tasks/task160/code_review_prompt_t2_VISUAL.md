# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [FONTNAME-ERRADO] Linha 207: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 229: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 252: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 276: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGPRCCR.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (571 linhas total):

*-- Linhas 118 a 126:
118:             loc_cTituloJanela = "Impress" + CHR(227) + "o de Produtos com Pre" + ;
119:                                 CHR(231) + "os alterados"
120:         ENDIF
121:         THIS.Caption = loc_cTituloJanela
122: 
123:         *-- Background do form (mesmo padrao dos demais forms de relatorio)
124:         THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
125:     ENDPROC
126: 

*-- Linhas 132 a 174:
132:     PROTECTED PROCEDURE ConfigurarCabecalho()
133:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
134:         WITH THIS.cnt_4c_Cabecalho
135:             .Top         = 0
136:             .Left        = 0
137:             .Width       = THIS.Width
138:             .Height      = THIS.Height
139:             .BackStyle   = 1
140:             .BackColor   = RGB(100, 100, 100)
141:             .BorderWidth = 0
142:             .Visible     = .T.
143: 
144:             *-- Sombra (deslocada 2px) para efeito de profundidade
145:             .AddObject("lbl_4c_Sombra", "Label")
146:             WITH .lbl_4c_Sombra
147:                 .Top       = 52
148:                 .Left      = 22
149:                 .Width     = THISFORM.Width
150:                 .Height    = 30
151:                 .AutoSize  = .F.
152:                 .Caption   = THISFORM.Caption
153:                 .FontName  = "Tahoma"
154:                 .FontSize  = 14
155:                 .FontBold  = .T.
156:                 .ForeColor = RGB(0, 0, 0)
157:                 .BackStyle = 0
158:                 .Visible   = .T.
159:             ENDWITH
160: 
161:             *-- Titulo principal (branco sobre cinza)
162:             .AddObject("lbl_4c_Titulo", "Label")
163:             WITH .lbl_4c_Titulo
164:                 .Top       = 50
165:                 .Left      = 20
166:                 .Width     = THISFORM.Width
167:                 .Height    = 30
168:                 .AutoSize  = .F.
169:                 .Caption   = THISFORM.Caption
170:                 .FontName  = "Tahoma"
171:                 .FontSize  = 14
172:                 .FontBold  = .T.
173:                 .ForeColor = RGB(255, 255, 255)
174:                 .BackStyle = 0

*-- Linhas 180 a 213:
180:     *--------------------------------------------------------------------------
181:     * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
182:     *   Geometria exata do SCX original:
183:     *     btnReport.Left=495, Width=310, Height=85, Top=0 (SCX tinha Top=-2)
184:     *   Botoes: Lefts=5/80/155/230, Width=75, Height=75
185:     *--------------------------------------------------------------------------
186:     PROTECTED PROCEDURE ConfigurarBotoes()
187:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
188:         WITH THIS.cmg_4c_Botoes
189:             .Top           = 0
190:             .Left          = 495
191:             .Width         = 310
192:             .Height        = 85
193:             .ButtonCount   = 4
194:             .BackStyle     = 0
195:             .BorderStyle   = 0
196:             .BorderColor   = RGB(136, 189, 188)
197:             .SpecialEffect = 1
198:             .Themes        = .F.
199:             .Visible       = .T.
200: 
201:             WITH .Buttons(1)
202:                 .Top             = 5
203:                 .Left            = 5
204:                 .Width           = 75
205:                 .Height          = 75
206:                 .Caption         = "\<Visualizar"
207:                 .FontName        = "Comic Sans MS"
208:                 .FontSize        = 8
209:                 .FontBold        = .T.
210:                 .FontItalic      = .T.
211:                 .BackColor       = RGB(255, 255, 255)
212:                 .ForeColor       = RGB(90, 90, 90)
213:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 221 a 235:
221:             ENDWITH
222: 
223:             WITH .Buttons(2)
224:                 .Top             = 5
225:                 .Left            = 80
226:                 .Width           = 75
227:                 .Height          = 75
228:                 .Caption         = "\<Imprimir"
229:                 .FontName        = "Comic Sans MS"
230:                 .FontSize        = 8
231:                 .FontBold        = .T.
232:                 .FontItalic      = .T.
233:                 .BackColor       = RGB(255, 255, 255)
234:                 .ForeColor       = RGB(90, 90, 90)
235:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 243 a 258:
243:             ENDWITH
244: 
245:             WITH .Buttons(3)
246:                 .Top             = 5
247:                 .Left            = 155
248:                 .Width           = 75
249:                 .Height          = 75
250:                 .Caption         = "\<Arquivos Email"
251:                 .WordWrap        = .T.
252:                 .FontName        = "Comic Sans MS"
253:                 .FontSize        = 8
254:                 .FontBold        = .T.
255:                 .FontItalic      = .T.
256:                 .BackColor       = RGB(255, 255, 255)
257:                 .ForeColor       = RGB(90, 90, 90)
258:                 .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"

*-- Linhas 266 a 282:
266:             ENDWITH
267: 
268:             WITH .Buttons(4)
269:                 .Top             = 5
270:                 .Left            = 230
271:                 .Width           = 75
272:                 .Height          = 75
273:                 .Caption         = "\<Encerrar"
274:                 .Cancel          = .T.
275:                 .WordWrap        = .T.
276:                 .FontName        = "Comic Sans MS"
277:                 .FontSize        = 8
278:                 .FontBold        = .T.
279:                 .FontItalic      = .T.
280:                 .BackColor       = RGB(255, 255, 255)
281:                 .ForeColor       = RGB(90, 90, 90)
282:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 462 a 470:
462:     *   Em CRUD: transfere propriedades this_* para TextBoxes/ComboBoxes
463:     *   apos CarregarPorCodigo/Buscar.
464:     *   Em REPORT SIGPRCCR: sem controles de filtro, mas o cabecalho visual
465:     *   (lbl_4c_Sombra + lbl_4c_Titulo) DEVE refletir o titulo canonico do
466:     *   BO. Reaplica Caption do form e captions dos labels do cabecalho a
467:     *   partir de this_cTituloRel do BO.
468:     *--------------------------------------------------------------------------
469:     PROTECTED PROCEDURE BOParaForm()
470:         LOCAL loc_cTitulo

*-- Linhas 476 a 487:
476:             loc_cTitulo = "Rela" + CHR(231) + CHR(227) + ;
477:                           "o de Produtos com Pre" + CHR(231) + "o Alterado"
478:         ENDIF
479:         THIS.Caption = "Impress" + CHR(227) + "o de " + loc_cTitulo
480:         IF PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
481:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
482:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
483:         ENDIF
484:     ENDPROC
485: 
486:     *--------------------------------------------------------------------------
487:     * HabilitarCampos - Ativa/desativa controles conforme o modo

*-- Linhas 507 a 515:
507: 
508:     *--------------------------------------------------------------------------
509:     * LimparCampos - Reseta valores dos controles do form
510:     *   Em CRUD: zera TextBoxes/ComboBoxes/CheckBoxes de Page2.
511:     *   Em REPORT SIGPRCCR sem filtros: reseta os cursores temporarios de
512:     *   dados/cabecalho no BO para forcar rebusca no proximo PrepararDados,
513:     *   e restaura Caption e subtitulo aos valores canonicos iniciais.
514:     *--------------------------------------------------------------------------
515:     PROTECTED PROCEDURE LimparCampos()


### BO (C:\4c\projeto\app\classes\SIGPRCCRBO.prg):
*==============================================================================
* SIGPRCCRBO.PRG
* Business Object para Relatorio de Produtos com Preco Alterado
* Tipo: REPORT
* Herda de RelatorioBase
*
* Relatorio: SigPrCcr.frx
* Logica: Busca empresa em SigCdEmp, cria cursor de cabecalho,
*          imprime produtos com lMarca=1, ordenados por Cpros
*==============================================================================

DEFINE CLASS SIGPRCCRBO AS RelatorioBase

    *-- Dados do cabecalho do relatorio
    this_cEmpresa           = ""
    this_cTitulo            = ""
    this_cSubTitulo         = ""

    *-- Configuracao do relatorio
    this_cFRXPath           = ""
    this_cTituloRel         = ""

    *-- Cursores utilizados
    this_cCursorDados       = "cursor_4c_Relatorio"
    this_cCursorCabecalho   = "cursor_4c_Cabecalho"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de produtos com preco alterado
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF DODEFAULT()
                IF TYPE("gc_4c_CaminhoReports") = "U"
                    gc_4c_CaminhoReports = ""
                ENDIF
                THIS.this_cTabela     = ""
                THIS.this_cCampoChave = ""
                THIS.this_cFRXPath    = gc_4c_CaminhoReports + "SigPrCcr.frx"
                THIS.this_cTituloRel  = "Rela" + CHR(231) + CHR(227) + ;
                                        "o de Produtos com Pre" + CHR(231) + "o Alterado "
                THIS.this_cTitulo     = THIS.this_cTituloRel
                THIS.this_cSubTitulo  = "Em " + DTOC(DATE())
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursores para o relatorio
    * Busca empresa, cria cursor cabecalho e seleciona produtos com lMarca=1
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult, loc_cEmpresa
        loc_lSucesso = .F.
        TRY
            WAIT WINDOW "Aguarde Processamento !" NOWAIT

            *-- Busca nome da empresa
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpCcr")
            IF loc_nResult > 0
                SELECT cursor_4c_EmpCcr
                GO TOP
                IF !EOF()
                    loc_cEmpresa = IIF(!EMPTY(cursor_4c_EmpCcr.Razas), ;
                                       ALLTRIM(cursor_4c_EmpCcr.Razas), "")
                ELSE
                    loc_cEmpresa = ""
                ENDIF
            ELSE
                loc_cEmpresa = ""
            ENDIF
            IF USED("cursor_4c_EmpCcr")
                USE IN cursor_4c_EmpCcr
            ENDIF

            *-- Atualiza propriedades de cabecalho
            THIS.this_cEmpresa   = loc_cEmpresa
            THIS.this_cTitulo    = "Rela" + CHR(231) + CHR(227) + ;
                                   "o de Produtos com Pre" + CHR(231) + "o Alterado "
            THIS.this_cSubTitulo = "Em " + DTOC(DATE())

            *-- Cria cursor de cabecalho
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Cabecalho ;
                (cb_empresa C(80), titulo C(80), SubTitulo C(80))
            INSERT INTO cursor_4c_Cabecalho (cb_empresa, titulo, SubTitulo) ;
                   VALUES (THIS.this_cEmpresa, THIS.this_cTitulo, THIS.this_cSubTitulo)
            SET NULL OFF

            *-- Busca produtos com lMarca = 1 ordenados por Cpros
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdPro WHERE lMarca = 1 ORDER BY Cpros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar produtos com pre" + CHR(231) + "o alterado"
            ELSE
                SELECT (THIS.this_cCursorDados)
                GO TOP
                loc_lSucesso = .T.
            ENDIF

            WAIT CLEAR
        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime o relatorio na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) TO PRINTER NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComPrompt - Prepara dados e imprime com selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComPrompt()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ArquivosEmail - Prepara dados e gera documento para email
    *--------------------------------------------------------------------------
    PROCEDURE ArquivosEmail()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) TO PRINTER NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

