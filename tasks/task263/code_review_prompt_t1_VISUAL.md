# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [FONTNAME-ERRADO] Linha 231: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 252: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 274: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 297: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGPRCCR.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (573 linhas total):

*-- Linhas 48 a 56:
48:         loc_lSucesso   = .F.
49:         loc_lContinuar = .T.
50:         TRY
51:             THIS.Caption = "Impress" + CHR(227) + "o de Produtos com Pre" + CHR(231) + "os alterados"
52: 
53:             IF TYPE("gc_4c_CaminhoIcones") = "U"
54:                 gc_4c_CaminhoIcones = ""
55:             ENDIF
56:             IF TYPE("gc_4c_CaminhoReports") = "U"

*-- Linhas 74 a 83:
74:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
75:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
76: 
77:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
78:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
79:                 loc_lSucesso = .T.
80:             ENDIF
81:         CATCH TO loc_oErro
82:             THIS.this_cMensagemErro = loc_oErro.Message
83:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 158 a 197:
158:     PROTECTED PROCEDURE ConfigurarCabecalho()
159:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
160:         WITH THIS.cnt_4c_Cabecalho
161:             .Top         = 0
162:             .Left        = 0
163:             .Width       = THIS.Width
164:             .Height      = THIS.Height
165:             .BackStyle   = 1
166:             .BackColor   = RGB(100, 100, 100)
167:             .BorderWidth = 0
168:             .Visible     = .T.
169: 
170:             .AddObject("lbl_4c_Sombra", "Label")
171:             WITH .lbl_4c_Sombra
172:                 .Top       = 22
173:                 .Left      = 22
174:                 .Width     = THIS.Width
175:                 .Height    = 30
176:                 .Caption   = "Impress" + CHR(227) + "o de Produtos com Pre" + CHR(231) + "os alterados"
177:                 .FontName  = "Tahoma"
178:                 .FontSize  = 14
179:                 .FontBold  = .T.
180:                 .AutoSize  = .F.
181:                 .ForeColor = RGB(0, 0, 0)
182:                 .BackStyle = 0
183:                 .Visible   = .T.
184:             ENDWITH
185: 
186:             .AddObject("lbl_4c_Titulo", "Label")
187:             WITH .lbl_4c_Titulo
188:                 .Top       = 20
189:                 .Left      = 20
190:                 .Width     = THIS.Width
191:                 .Height    = 30
192:                 .Caption   = "Impress" + CHR(227) + "o de Produtos com Pre" + CHR(231) + "os alterados"
193:                 .FontName  = "Tahoma"
194:                 .FontSize  = 14
195:                 .FontBold  = .T.
196:                 .AutoSize  = .F.
197:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 204 a 237:
204:     *--------------------------------------------------------------------------
205:     * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
206:     *   Geometria EXATA do original SCX:
207:     *     btnReport.Top=-2 (ajustado para 0), Left=495, Width=310, Height=85
208:     *     Cada botao: Width=75, Height=75, Left=5/80/155/230 (incremento 75)
209:     *--------------------------------------------------------------------------
210:     PROTECTED PROCEDURE ConfigurarBotoes()
211:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
212:         WITH THIS.cmg_4c_Botoes
213:             .Top           = 0
214:             .Left          = 495
215:             .Width         = 310
216:             .Height        = 85
217:             .ButtonCount   = 4
218:             .BackStyle     = 0
219:             .BorderStyle   = 0
220:             .BorderColor   = RGB(136, 189, 188)
221:             .SpecialEffect = 1
222:             .Themes        = .F.
223:             .Visible       = .T.
224: 
225:             WITH .Buttons(1)
226:                 .Top             = 5
227:                 .Left            = 5
228:                 .Width           = 75
229:                 .Height          = 75
230:                 .Caption         = "Visualizar"
231:                 .FontName        = "Comic Sans MS"
232:                 .FontSize        = 8
233:                 .FontBold        = .T.
234:                 .FontItalic      = .T.
235:                 .BackColor       = RGB(255, 255, 255)
236:                 .ForeColor       = RGB(90, 90, 90)
237:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 244 a 258:
244:             ENDWITH
245: 
246:             WITH .Buttons(2)
247:                 .Top             = 5
248:                 .Left            = 80
249:                 .Width           = 75
250:                 .Height          = 75
251:                 .Caption         = "Imprimir"
252:                 .FontName        = "Comic Sans MS"
253:                 .FontSize        = 8
254:                 .FontBold        = .T.
255:                 .FontItalic      = .T.
256:                 .BackColor       = RGB(255, 255, 255)
257:                 .ForeColor       = RGB(90, 90, 90)
258:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 265 a 280:
265:             ENDWITH
266: 
267:             WITH .Buttons(3)
268:                 .Top             = 5
269:                 .Left            = 155
270:                 .Width           = 75
271:                 .Height          = 75
272:                 .Caption         = "Arquivos Email"
273:                 .WordWrap        = .T.
274:                 .FontName        = "Comic Sans MS"
275:                 .FontSize        = 8
276:                 .FontBold        = .T.
277:                 .FontItalic      = .T.
278:                 .BackColor       = RGB(255, 255, 255)
279:                 .ForeColor       = RGB(90, 90, 90)
280:                 .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"

*-- Linhas 287 a 303:
287:             ENDWITH
288: 
289:             WITH .Buttons(4)
290:                 .Top             = 5
291:                 .Left            = 230
292:                 .Width           = 75
293:                 .Height          = 75
294:                 .Caption         = "Encerrar"
295:                 .Cancel          = .T.
296:                 .WordWrap        = .T.
297:                 .FontName        = "Comic Sans MS"
298:                 .FontSize        = 8
299:                 .FontBold        = .T.
300:                 .FontItalic      = .T.
301:                 .BackColor       = RGB(255, 255, 255)
302:                 .ForeColor       = RGB(90, 90, 90)
303:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"


### BO (C:\4c\projeto\app\classes\SIGPRCCRBO.prg):
*==============================================================================
* SIGPRCCRBO.PRG
* Business Object - Relatorio: Impressao de Produtos com Precos Alterados
*
* Herda de RelatorioBase
* Opera sobre cursor CrProdutos (criado pelos forms pai: SigPrCcc, SigPrCcp, etc.)
* Filtra lMarca = 1 e gera CsRelatorio para o FRX SigPrCcr
*==============================================================================

DEFINE CLASS SIGPRCCRBO AS RelatorioBase

    *-- Relatorio e cursor de saida (DEVE bater com nomes esperados pelo FRX legado)
    this_cRelatorio     = "SigPrCcr"
    this_cCursorDados   = "CsRelatorio"
    this_cMensagemErro  = ""

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta CsCabecalho e CsRelatorio a partir de CrProdutos
    * CrProdutos deve existir em memoria (criado pelo form pai com lMarca marcado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpresa
        LOCAL loc_cTitulo, loc_cSubTit
        loc_lSucesso = .F.

        TRY
            *-- Verifica se cursor CrProdutos existe
            IF !USED("CrProdutos")
                THIS.this_cMensagemErro = "Cursor CrProdutos n" + CHR(227) + "o encontrado. " + ;
                    "Execute a marca" + CHR(231) + CHR(227) + "o de produtos antes de imprimir."
                loc_lSucesso = .F.
            ENDIF

            *-- Busca razao social da empresa
            loc_cEmpresa = ""
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                GO TOP
                IF !EOF()
                    loc_cEmpresa = ALLTRIM(NVL(cursor_4c_Emp.Razas, ""))
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            *-- Monta cursor de cabecalho (alias legado: CsCabecalho)
            loc_cTitulo = "Rela" + CHR(231) + CHR(227) + "o de Produtos com Pre" + CHR(231) + "o Alterado "
            loc_cSubTit = "Em " + DTOC(DATE())

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (cb_empresa C(80), titulo C(80), SubTitulo C(80))
            INSERT INTO CsCabecalho (cb_empresa, titulo, SubTitulo) ;
                VALUES (loc_cEmpresa, loc_cTitulo, loc_cSubTit)

            *-- Monta cursor de relatorio filtrando produtos marcados (alias legado: CsRelatorio)
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            SELECT * FROM CrProdutos WHERE lMarca = 1 INTO CURSOR CsRelatorio ORDER BY Cpros
            SELECT CsRelatorio
            GO TOP

            IF RECCOUNT("CsRelatorio") = 0
                THIS.this_cMensagemErro = "Nenhum produto marcado para impress" + CHR(227) + "o."
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao preparar dados: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e sinaliza sucesso para o form executar REPORT FORM
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Alias de Imprimir() para compatibilidade com Pattern #122
    * (handlers de botao REPORT chamam Atualizar() antes de ExecutarReportForm)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.Imprimir()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Emp")
            USE IN cursor_4c_Emp
        ENDIF
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

