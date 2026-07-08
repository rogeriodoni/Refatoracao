# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 242: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 265: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReInf.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (488 linhas total):

*-- Linhas 78 a 86:
78:         loc_lSucesso   = .F.
79:         loc_lContinuar = .T.
80:         TRY
81:             THIS.Caption = "Impress" + CHR(227) + "o de Nota Fiscal"
82: 
83:             IF TYPE("gc_4c_CaminhoIcones") = "U"
84:                 gc_4c_CaminhoIcones = ""
85:             ENDIF
86:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 116 a 125:
116:                 THIS.ConfigurarBotoes()
117: 
118:                 *-- Atualiza captions dos labels do cabe" + CHR(231) + "alho
119:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
120:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
121: 
122:                 *-- Vincula eventos dos bot" + CHR(245) + "es (BINDEVENT s" + CHR(243) + " em m" + CHR(233) + "todos PUBLIC)
123:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
124:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
125:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

*-- Linhas 147 a 187:
147:     PROTECTED PROCEDURE ConfigurarCabecalho()
148:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
149:         WITH THIS.cnt_4c_Cabecalho
150:             .Top         = 0
151:             .Left        = 0
152:             .Width       = THIS.Width
153:             .Height      = 80
154:             .BackStyle   = 1
155:             .BackColor   = RGB(100, 100, 100)
156:             .BorderWidth = 0
157:             .Visible     = .T.
158: 
159:             *-- Sombra (deslocada 2px para efeito de profundidade no texto branco)
160:             .AddObject("lbl_4c_Sombra", "Label")
161:             WITH .lbl_4c_Sombra
162:                 .Top       = 22
163:                 .Left      = 22
164:                 .Width     = THIS.Width
165:                 .Height    = 30
166:                 .Caption   = "Impress" + CHR(227) + "o de Nota Fiscal"
167:                 .FontName  = "Tahoma"
168:                 .FontSize  = 14
169:                 .FontBold  = .T.
170:                 .ForeColor = RGB(0, 0, 0)
171:                 .BackStyle = 0
172:                 .Visible   = .T.
173:             ENDWITH
174: 
175:             *-- T" + CHR(237) + "tulo branco (sobre a sombra preta)
176:             .AddObject("lbl_4c_Titulo", "Label")
177:             WITH .lbl_4c_Titulo
178:                 .Top       = 20
179:                 .Left      = 20
180:                 .Width     = THIS.Width
181:                 .Height    = 30
182:                 .Caption   = "Impress" + CHR(227) + "o de Nota Fiscal"
183:                 .FontName  = "Tahoma"
184:                 .FontSize  = 14
185:                 .FontBold  = .T.
186:                 .ForeColor = RGB(255, 255, 255)
187:                 .BackStyle = 0

*-- Linhas 199 a 225:
199:     PROTECTED PROCEDURE ConfigurarBotoes()
200:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
201:         WITH THIS.cmg_4c_Botoes
202:             .Top           = 0
203:             .Left          = 529
204:             .Width         = 273
205:             .Height        = 80
206:             .ButtonCount   = 4
207:             .BackStyle     = 0
208:             .BorderStyle   = 0
209:             .BorderColor   = RGB(136, 189, 188)
210:             .SpecialEffect = 1
211:             .Themes        = .F.
212:             .Visible       = .T.
213: 
214:             *-- Bot" + CHR(227) + "o 1: Visualizar (preview na tela)
215:             WITH .Buttons(1)
216:                 .Top             = 5
217:                 .Left            = 5
218:                 .Width           = 65
219:                 .Height          = 70
220:                 .Caption         = "Visualizar"
221:                 .FontBold        = .T.
222:                 .FontItalic      = .T.
223:                 .BackColor       = RGB(255, 255, 255)
224:                 .ForeColor       = RGB(90, 90, 90)
225:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 234 a 248:
234: 
235:             *-- Bot" + CHR(227) + "o 2: Imprimir (impressora - fecha form ap" + CHR(243) + "s imprimir)
236:             WITH .Buttons(2)
237:                 .Top             = 5
238:                 .Left            = 71
239:                 .Width           = 65
240:                 .Height          = 70
241:                 .Caption         = "Imprimir"
242:                 .FontName        = "Comic Sans MS"
243:                 .FontBold        = .T.
244:                 .FontItalic      = .T.
245:                 .FontSize        = 8
246:                 .BackColor       = RGB(255, 255, 255)
247:                 .ForeColor       = RGB(90, 90, 90)
248:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 257 a 271:
257: 
258:             *-- Bot" + CHR(227) + "o 3: DocExcel - sempre desabilitado (lacexcel=.F. no original)
259:             WITH .Buttons(3)
260:                 .Top             = 5
261:                 .Left            = 137
262:                 .Width           = 65
263:                 .Height          = 70
264:                 .Caption         = "Excel"
265:                 .FontName        = "Comic Sans MS"
266:                 .FontBold        = .T.
267:                 .FontItalic      = .T.
268:                 .FontSize        = 8
269:                 .BackColor       = RGB(255, 255, 255)
270:                 .ForeColor       = RGB(90, 90, 90)
271:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 279 a 294:
279: 
280:             *-- Bot" + CHR(227) + "o 4: Encerrar (ESC fecha o form)
281:             WITH .Buttons(4)
282:                 .Top             = 5
283:                 .Left            = 203
284:                 .Width           = 65
285:                 .Height          = 70
286:                 .Caption         = "Encerrar"
287:                 .Cancel          = .T.
288:                 .FontName        = "Comic Sans MS"
289:                 .FontBold        = .T.
290:                 .FontItalic      = .T.
291:                 .FontSize        = 8
292:                 .BackColor       = RGB(255, 255, 255)
293:                 .ForeColor       = RGB(90, 90, 90)
294:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"


### BO (C:\4c\projeto\app\classes\SigReInfBO.prg):
*==============================================================================
* SIGREINFBO.PRG
* Business Object para Impressao de Nota Fiscal (SigReInf)
* Herda de RelatorioBase
*
* Tabela principal: SigMvNfi
* Forma de uso: Recebe parametros de NF (empresa, operacao, numero, serie)
*               e delega impressao/visualizacao para SigPrNfs
*==============================================================================

DEFINE CLASS SigReInfBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = "SigMvNfi"
    this_cCampoChave    = "Nfis"

    *-- Parametros da Nota Fiscal (recebidos via Init)
    this_cEmps          = ""
    this_cDopes         = ""
    this_nNumes         = 0
    this_cSerie         = ""

    *-- Controle de habilitacao de botoes
    this_lVisualizarHabilitado = .F.
    this_lImprimirHabilitado   = .F.

    *--------------------------------------------------------------------------
    * Init - Configura BO e carrega configuracoes de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta e executa SQL para obter NFs a imprimir
    * Retorna .T. se dados foram preparados com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_llFalse, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        loc_llFalse  = .F.

        TRY
            loc_cSQL = "Select c.Nfis, c.EmpdopNums From SigMvNfi c, SigCdOpe a " + ;
                       "Where c.emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " And c.series = " + EscaparSQL(THIS.this_cSerie) + ;
                       " And c.Impress = 0 and c.cancelas = 0" + ;
                       " And c.dopes = a.dopes" + ;
                       " and a.nfiscals in (1,2) and a.tiponfs <> 4 and a.agrupas = 1" + ;
                       " Union all " + ;
                       "Select c.Nfis, c.EmpDopNums From SigMvNfi c, SigCdOpe a, SigCdSer b " + ;
                       "Where c.emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " And c.series = " + EscaparSQL(THIS.this_cSerie) + ;
                       " And c.Impress = 0 And c.cancelas = 0" + ;
                       " and c.series = b.cods" + ;
                       " And c.dopes = a.dopes" + ;
                       " and a.nfiscals in (1,2) and a.tiponfs = 4 and b.impnfs = 1"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFiscal")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o ao buscar dados da NF"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConfiguracoes - Verifica SigCdPam e habilita botoes conforme regras
    * Equivalente ao Init() original que consultava SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarConfiguracoes()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT nnfftlns, nnfftcls FROM SigCdPam", ;
                "cursor_4c_Pam")

            IF loc_nResult > 0
                SELECT cursor_4c_Pam
                IF !EOF()
                    IF nnfftlns = 999 OR nnfftcls = 999
                        THIS.this_lVisualizarHabilitado = .T.
                    ENDIF
                ENDIF
                USE IN cursor_4c_Pam
            ENDIF

            THIS.this_lImprimirHabilitado = .T.
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
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
    * Visualizar - Executa preview da NF na tela
    * Equivalente ao metodo 'visualizacao' do form original (modo "V")
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            DO SigPrNfs WITH gnConnHandle, "V", THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Executa impressao direta da NF
    * Equivalente ao metodo 'impressao' do form original (modo "I")
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            DO SigPrNfs WITH gnConnHandle, "I", THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de identificacao da NF
    * Formato: emps + dopes + numes (mesmo padrao do lcEdn no original)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Override: relatorios nao escrevem dados, sem auditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE

