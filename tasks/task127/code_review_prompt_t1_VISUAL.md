# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 257: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 278: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 300: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIpc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (536 linhas total):

*-- Linhas 66 a 74:
66:         loc_lSucesso   = .F.
67:         loc_lContinuar = .T.
68:         TRY
69:             THIS.Caption = "Impress" + CHR(227) + "o da Rela" + CHR(231) + CHR(227) + "o"
70: 
71:             IF TYPE("gc_4c_CaminhoIcones") = "U"
72:                 gc_4c_CaminhoIcones = ""
73:             ENDIF
74:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 85 a 94:
85:                 THIS.ConfigurarPageFrame()
86:                 THIS.TornarControlesVisiveis(THIS)
87: 
88:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
89:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
90: 
91:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
92:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
93:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
94:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

*-- Linhas 166 a 242:
166:     PROTECTED PROCEDURE ConfigurarCabecalho()
167:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
168:         WITH THIS.cnt_4c_Cabecalho
169:             .Top         = 0
170:             .Left        = 0
171:             .Width       = THIS.Width
172:             .Height      = THIS.Height
173:             .BackStyle   = 1
174:             .BackColor   = RGB(100, 100, 100)
175:             .BorderWidth = 0
176:             .Visible     = .T.
177: 
178:             *-- Sombra deslocada 2px (efeito 3D sobre o t" + CHR(237) + "tulo branco)
179:             .AddObject("lbl_4c_Sombra", "Label")
180:             WITH .lbl_4c_Sombra
181:                 .Top       = 42
182:                 .Left      = 22
183:                 .Width     = THIS.Width
184:                 .Height    = 30
185:                 .Caption   = "Impress" + CHR(227) + "o da Rela" + CHR(231) + CHR(227) + "o"
186:                 .FontName  = "Tahoma"
187:                 .FontSize  = 12
188:                 .FontBold  = .T.
189:                 .ForeColor = RGB(0, 0, 0)
190:                 .BackStyle = 0
191:                 .Visible   = .T.
192:             ENDWITH
193: 
194:             *-- T" + CHR(237) + "tulo em branco (sobre a sombra)
195:             .AddObject("lbl_4c_Titulo", "Label")
196:             WITH .lbl_4c_Titulo
197:                 .Top       = 40
198:                 .Left      = 20
199:                 .Width     = THIS.Width
200:                 .Height    = 30
201:                 .Caption   = "Impress" + CHR(227) + "o da Rela" + CHR(231) + CHR(227) + "o"
202:                 .FontName  = "Tahoma"
203:                 .FontSize  = 12
204:                 .FontBold  = .T.
205:                 .ForeColor = RGB(255, 255, 255)
206:                 .BackStyle = 0
207:                 .Visible   = .T.
208:             ENDWITH
209:         ENDWITH
210:     ENDPROC
211: 
212:     *--------------------------------------------------------------------------
213:     * ConfigurarBotoes - CommandGroup de botoes do relatorio (btnReport original)
214:     *   Original: btnReport.Left=495, Top=-2, Width=310, Height=85, ButtonCount=4
215:     *   Botoes: Visualiza(5), Imprime(80), DocExcel(155), Sair(230) - W=75 cada
216:     *--------------------------------------------------------------------------
217:     PROTECTED PROCEDURE ConfigurarBotoes()
218:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
219:         WITH THIS.cmg_4c_Botoes
220:             .Top           = 0
221:             .Left          = 495
222:             .Width         = 310
223:             .Height        = 85
224:             .ButtonCount   = 4
225:             .BackStyle     = 0
226:             .BorderStyle   = 0
227:             .BorderColor   = RGB(136, 189, 188)
228:             .SpecialEffect = 1
229:             .Themes        = .F.
230:             .Visible       = .T.
231: 
232:             WITH .Buttons(1)
233:                 .Top             = 5
234:                 .Left            = 5
235:                 .Width           = 75
236:                 .Height          = 75
237:                 .Caption         = "Visualizar"
238:                 .FontBold        = .T.
239:                 .FontItalic      = .T.
240:                 .BackColor       = RGB(255, 255, 255)
241:                 .ForeColor       = RGB(90, 90, 90)
242:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 249 a 263:
249:             ENDWITH
250: 
251:             WITH .Buttons(2)
252:                 .Top             = 5
253:                 .Left            = 80
254:                 .Width           = 75
255:                 .Height          = 75
256:                 .Caption         = "Imprimir"
257:                 .FontName        = "Comic Sans MS"
258:                 .FontBold        = .T.
259:                 .FontItalic      = .T.
260:                 .FontSize        = 8
261:                 .BackColor       = RGB(255, 255, 255)
262:                 .ForeColor       = RGB(90, 90, 90)
263:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 270 a 284:
270:             ENDWITH
271: 
272:             WITH .Buttons(3)
273:                 .Top             = 5
274:                 .Left            = 155
275:                 .Width           = 75
276:                 .Height          = 75
277:                 .Caption         = "Excel"
278:                 .FontName        = "Comic Sans MS"
279:                 .FontBold        = .T.
280:                 .FontItalic      = .T.
281:                 .FontSize        = 8
282:                 .BackColor       = RGB(255, 255, 255)
283:                 .ForeColor       = RGB(90, 90, 90)
284:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 291 a 306:
291:             ENDWITH
292: 
293:             WITH .Buttons(4)
294:                 .Top             = 5
295:                 .Left            = 230
296:                 .Width           = 75
297:                 .Height          = 75
298:                 .Caption         = "Encerrar"
299:                 .Cancel          = .T.
300:                 .FontName        = "Comic Sans MS"
301:                 .FontBold        = .T.
302:                 .FontItalic      = .T.
303:                 .FontSize        = 8
304:                 .BackColor       = RGB(255, 255, 255)
305:                 .ForeColor       = RGB(90, 90, 90)
306:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 499 a 507:
499:     *--------------------------------------------------------------------------
500:     * BtnEncerrarClick - Fecha o formulario (alias de BtnSairClick)
501:     * Disponibilizado como metodo nomeado para compatibilidade com
502:     * padroes de forms que usam cnt_4c_Saida com cmd_4c_Encerrar.
503:     *--------------------------------------------------------------------------
504:     PROCEDURE BtnEncerrarClick()
505:         THIS.Release()
506:     ENDPROC
507: 


### BO (C:\4c\projeto\app\classes\SigReIpcBO.prg):
*==============================================================================
* SIGREIPCBO.PRG
* Business Object para SigReIpc - Impress?o da Rela??o de Operacoes
*
* Herda de RelatorioBase
*
* Contexto: Form utilit?rio chamado pelo SIGCDPGR com cursores j? preparados.
*   - TmpLanca : cursor de dados principal (lancamentos)
*   - xPar     : cursor de par?metros
*   - crSigCdEmp: cursor de empresa
*   - crSigCdPgr: cursor de opera??es (contendo Dopes, Numes)
*   - Par?metro Qbols: n?mero de opera??es a imprimir
*==============================================================================

DEFINE CLASS SigReIpcBO AS RelatorioBase

    *-- N?mero de opera??es a imprimir (par?metro recebido pelo form)
    this_nQbols = 0

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Posiciona cursores para o relatorio
    * Cursores TmpLanca/xPar/crSigCdEmp/crSigCdPgr sao preparados pelo form chamador
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("TMPLANCA")
                SELECT TMPLANCA
                GO TOP
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview, uma iteracao por operacao
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_nX, loc_cNomeEmpresa, loc_cRelTitulo, loc_cPeriodo, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            FOR loc_nX = 1 TO THIS.this_nQbols
                loc_cNomeEmpresa = IIF(SEEK(go_4c_Sistema.cCodEmpresa, "crSigCdEmp", "Cemps"), ;
                                       ALLTRIM(crSigCdEmp.Razas), "")
                loc_cRelTitulo = "Rela" + CHR(231) + CHR(227) + "o de " + ;
                                 PROPER(ALLTRIM(crSigCdPgr.Dopes)) + "s"
                loc_cPeriodo   = "Opera" + CHR(231) + CHR(227) + "o : " + ;
                                 ALLTRIM(crSigCdPgr.Dopes) + " " + ;
                                 fGerMascara(crSigCdPgr.Numes)

                IF USED("Cabecalho")
                    USE IN Cabecalho
                ENDIF
                CREATE CURSOR Cabecalho (pNomeEmpresa C(80), pRelTitulo C(80), ;
                                         pTipo N(1), pPeriodo C(80))
                INSERT INTO Cabecalho (pNomeEmpresa, pRelTitulo, pPeriodo, pTipo) ;
                    VALUES (loc_cNomeEmpresa, loc_cRelTitulo, loc_cPeriodo, 1)

                IF USED("xPar")
                    SELECT xPar
                    GO TOP
                ENDIF

                SELECT TMPLANCA
                GO TOP

                REPORT FORM (gc_4c_CaminhoReports + "RelSigReIpc.frx") PREVIEW NOCONSOLE
            ENDFOR
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio direto na impressora, uma iteracao por operacao
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_nX, loc_cNomeEmpresa, loc_cRelTitulo, loc_cPeriodo, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            FOR loc_nX = 1 TO THIS.this_nQbols
                loc_cNomeEmpresa = IIF(SEEK(go_4c_Sistema.cCodEmpresa, "crSigCdEmp", "Cemps"), ;
                                       ALLTRIM(crSigCdEmp.Razas), "")
                loc_cRelTitulo = "Rela" + CHR(231) + CHR(227) + "o de " + ;
                                 PROPER(ALLTRIM(crSigCdPgr.Dopes)) + "s"
                loc_cPeriodo   = "Opera" + CHR(231) + CHR(227) + "o : " + ;
                                 ALLTRIM(crSigCdPgr.Dopes) + " " + ;
                                 fGerMascara(crSigCdPgr.Numes)

                IF USED("Cabecalho")
                    USE IN Cabecalho
                ENDIF
                CREATE CURSOR Cabecalho (pNomeEmpresa C(80), pRelTitulo C(80), ;
                                         pTipo N(1), pPeriodo C(80))
                INSERT INTO Cabecalho (pNomeEmpresa, pRelTitulo, pPeriodo, pTipo) ;
                    VALUES (loc_cNomeEmpresa, loc_cRelTitulo, loc_cPeriodo, 1)

                IF USED("xPar")
                    SELECT xPar
                    GO TOP
                ENDIF

                SELECT TMPLANCA
                GO TOP

                REPORT FORM (gc_4c_CaminhoReports + "RelSigReIpc.frx") TO PRINTER PROMPT NOCONSOLE
            ENDFOR
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao possui chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

ENDDEFINE

