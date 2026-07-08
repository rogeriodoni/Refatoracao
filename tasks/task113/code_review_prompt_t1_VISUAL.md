# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 189: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 209: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 229: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREHPE.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (479 linhas total):

*-- Linhas 74 a 82:
74:     * CONFIGURARPAGEFRAME - Propriedades da janela e fundo do form
75:     *==========================================================================
76:     PROTECTED PROCEDURE ConfigurarPageFrame()
77:         THIS.Caption     = "Resumo de Cheques Pendentes"
78:         THIS.Picture     = gc_4c_CaminhoIcones + "new_background.jpg"
79:         THIS.Icon        = gc_4c_CaminhoIcones + "icon.ico"
80:         THIS.AutoCenter  = .T.
81:         THIS.BorderStyle = 2
82:         THIS.WindowType  = 1

*-- Linhas 95 a 174:
95:     PROTECTED PROCEDURE ConfigurarCabecalho()
96:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
97:         WITH THIS.cnt_4c_Cabecalho
98:             .Top         = 0
99:             .Left        = 0
100:             .Width       = THIS.Width
101:             .Height      = 80
102:             .BackStyle   = 1
103:             .BackColor   = RGB(100, 100, 100)
104:             .BorderWidth = 0
105:             .Visible     = .T.
106: 
107:             .AddObject("lbl_4c_Sombra", "Label")
108:             WITH .lbl_4c_Sombra
109:                 .Top       = 15
110:                 .Left      = 12
111:                 .Width     = THIS.Width
112:                 .Height    = 40
113:                 .FontName  = "Tahoma"
114:                 .FontSize  = 16
115:                 .FontBold  = .T.
116:                 .BackStyle = 0
117:                 .ForeColor = RGB(0, 0, 0)
118:                 .Caption   = "Resumo de Cheques Pendentes"
119:                 .Visible   = .T.
120:             ENDWITH
121: 
122:             .AddObject("lbl_4c_Titulo", "Label")
123:             WITH .lbl_4c_Titulo
124:                 .Top       = 18
125:                 .Left      = 10
126:                 .Width     = THIS.Width
127:                 .Height    = 40
128:                 .FontName  = "Tahoma"
129:                 .FontSize  = 16
130:                 .FontBold  = .T.
131:                 .BackStyle = 0
132:                 .ForeColor = RGB(255, 255, 255)
133:                 .Caption   = "Resumo de Cheques Pendentes"
134:                 .Visible   = .T.
135:             ENDWITH
136:         ENDWITH
137:     ENDPROC
138: 
139:     *==========================================================================
140:     * CONFIGURARBOTOES - CommandGroup 4 botoes (padrao frmrelatorio framework.vcx)
141:     * Left=727: posicao flush-direita em form 1000px (1000-273=727)
142:     * Top=3: original btnReport.Top=3
143:     * Geometria: Width=273, Height=80, ButtonCount=4, BackStyle=0
144:     * Lefts internos: 5, 71, 137, 203 (incrementos de 66)
145:     *==========================================================================
146:     PROTECTED PROCEDURE ConfigurarBotoes()
147:         LOCAL loc_cIcones
148:         loc_cIcones = gc_4c_CaminhoIcones
149: 
150:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
151:         WITH THIS.cmg_4c_Botoes
152:             .Top           = 3
153:             .Left          = 727
154:             .Width         = 273
155:             .Height        = 80
156:             .ButtonCount   = 4
157:             .BackStyle     = 0
158:             .BorderStyle   = 0
159:             .BorderColor   = RGB(136, 189, 188)
160:             .SpecialEffect = 1
161:             .Themes        = .F.
162:             .Visible       = .T.
163: 
164:             WITH .Buttons(1)
165:                 .Top             = 5
166:                 .Left            = 5
167:                 .Width           = 65
168:                 .Height          = 70
169:                 .Caption         = "Visualizar"
170:                 .Picture         = loc_cIcones + "ideo.jpg"
171:                 .FontBold        = .T.
172:                 .FontItalic      = .T.
173:                 .BackColor       = RGB(255, 255, 255)
174:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 180 a 235:
180:             ENDWITH
181: 
182:             WITH .Buttons(2)
183:                 .Top             = 5
184:                 .Left            = 71
185:                 .Width           = 65
186:                 .Height          = 70
187:                 .Caption         = "Imprimir"
188:                 .Picture         = loc_cIcones + "impressora.jpg"
189:                 .FontName        = "Comic Sans MS"
190:                 .FontBold        = .T.
191:                 .FontItalic      = .T.
192:                 .FontSize        = 8
193:                 .BackColor       = RGB(255, 255, 255)
194:                 .ForeColor       = RGB(90, 90, 90)
195:                 .PicturePosition = 13
196:                 .SpecialEffect   = 0
197:                 .MousePointer    = 15
198:                 .Themes          = .F.
199:                 .WordWrap        = .T.
200:             ENDWITH
201: 
202:             WITH .Buttons(3)
203:                 .Top             = 5
204:                 .Left            = 137
205:                 .Width           = 65
206:                 .Height          = 70
207:                 .Caption         = "Excel"
208:                 .Picture         = loc_cIcones + "excel.jpg"
209:                 .FontName        = "Comic Sans MS"
210:                 .FontBold        = .T.
211:                 .FontItalic      = .T.
212:                 .FontSize        = 8
213:                 .BackColor       = RGB(255, 255, 255)
214:                 .ForeColor       = RGB(90, 90, 90)
215:                 .PicturePosition = 13
216:                 .SpecialEffect   = 0
217:                 .MousePointer    = 15
218:                 .Themes          = .F.
219:                 .WordWrap        = .T.
220:             ENDWITH
221: 
222:             WITH .Buttons(4)
223:                 .Top             = 5
224:                 .Left            = 203
225:                 .Width           = 65
226:                 .Height          = 70
227:                 .Caption         = "Sair"
228:                 .Picture         = loc_cIcones + "otao_encerrar.jpg"
229:                 .FontName        = "Comic Sans MS"
230:                 .FontBold        = .T.
231:                 .FontItalic      = .T.
232:                 .FontSize        = 8
233:                 .BackColor       = RGB(255, 255, 255)
234:                 .ForeColor       = RGB(90, 90, 90)
235:                 .PicturePosition = 13


### BO (C:\4c\projeto\app\classes\SIGREHPEBO.prg):
*==============================================================================
* SIGREHPEBO.PRG
* Business Object do Relatorio SIGREHPE
*
* Herda de: RelatorioBase
* Tabela principal: SigChe (cheques)
* Tabela auxiliar: SigCdOpt (operacoes DB)
*==============================================================================

DEFINE CLASS SIGREHPEBO AS RelatorioBase

    *-- Tabela e chave principal
    this_cTabela        = "SigChe"
    this_cCampoChave    = "Umovs"

    *-- Caminho do arquivo de relatorio (.frx)
    this_cArquivoFRX    = ""

    *-- Titulo do relatorio
    this_cTitulo        = ""

    *-- Dados da empresa para cabecalho
    this_cEmpresa       = ""

    *-- Nomes dos cursores de dados
    this_cCursorDados       = "CsRelatorio"
    this_cCursorCabecalho   = "CsCabecalho"

    *--------------------------------------------------------------------------
    * Init - Configura propriedades basicas do BO de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela       = "SigChe"
            THIS.this_cCampoChave   = "Umovs"
            THIS.this_cTitulo       = "Resumo de Cheques Pendentes"
            THIS.this_cArquivoFRX   = gc_4c_CaminhoReports + "RelSIGREHPE.frx"
            loc_lSucesso            = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREHPEBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro do ultimo processamento
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa SQL principal e popula CsRelatorio
    * Equivalente ao PROCEDURE processamento do legado
    * SQL original: SELECT a.Umovs, Sum(a.Valors) as Valor
    *               FROM SigChe a, SigCdOpt b
    *               WHERE a.UMovs = b.Operacaos AND b.Tipos = 'DB'
    *               GROUP BY a.Umovs
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSql

        loc_lSucesso = .F.
        TRY
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF

            loc_cSql = "SELECT a.Umovs, SUM(a.Valors) AS Valor " + ;
                       "FROM SigChe a, SigCdOpt b " + ;
                       "WHERE a.UMovs = b.Operacaos " + ;
                       "AND b.Tipos = 'DB' " + ;
                       "GROUP BY a.Umovs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "CsRelatorio")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados dos cheques pendentes"
            ELSE
                SELECT CsRelatorio
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCabecalho - Cria cursor CsCabecalho para o cabecalho do relatorio
    * Equivalente ao trecho inicial do PROCEDURE processamento do legado:
    *   ThisForm.podatamgr.CursorQuery('SigCdEmp','crSigCdEmp','cEmps',_empr)
    *   lcEmp = Alltrim(crSigCdEmp.Cemps + ' - ' + crSigCdEmp.Razas)
    *   Create Cursor csCabecalho ...
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarCabecalho()
        LOCAL loc_lSucesso, loc_nResult, loc_cSqlEmp, loc_cNomeEmpresa

        loc_lSucesso     = .F.
        loc_cNomeEmpresa = ""
        TRY
            loc_cSqlEmp = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlEmp, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                IF !EOF()
                    loc_cNomeEmpresa = ALLTRIM(cursor_4c_Emp.Cemps) + ;
                                       " - " + ALLTRIM(cursor_4c_Emp.Razas)
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (Empresa C(80), Titulo C(80))
            INSERT INTO CsCabecalho (Empresa, Titulo) ;
                VALUES (loc_cNomeEmpresa, THIS.this_cTitulo)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.MontarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores de trabalho apos impressao/visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        TRY
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREHPEBO.LimparCursores")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime relatorio na impressora
    * Equivalente ao PROCEDURE impressao do legado:
    *   Report Form SigReHpe To Print Prompt NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                IF THIS.MontarCabecalho()
                    SELECT CsRelatorio
                    REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
                    THIS.LimparCursores()
                    loc_lSucesso = .T.
                ELSE
                    IF EMPTY(THIS.this_cMensagemErro)
                        THIS.this_cMensagemErro = "Erro ao montar cabe" + CHR(231) + "alho do relat" + CHR(243) + "rio"
                    ENDIF
                ENDIF
            ELSE
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + CHR(243) + "rio"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    * Equivalente ao PROCEDURE visualizacao do legado:
    *   Report Form SigReHpe Preview NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                IF THIS.MontarCabecalho()
                    SELECT CsRelatorio
                    REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                    THIS.LimparCursores()
                    loc_lSucesso = .T.
                ELSE
                    IF EMPTY(THIS.this_cMensagemErro)
                        THIS.this_cMensagemErro = "Erro ao montar cabe" + CHR(231) + "alho do relat" + CHR(243) + "rio"
                    ENDIF
                ENDIF
            ELSE
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + CHR(243) + "rio"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do relatorio para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN "RELATORIO=SIGREHPE"
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Delega para Imprimir e registra auditoria de IMPRESSAO
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Imprimir()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: visualizar preview
    * Delega para Visualizar e registra auditoria de VISUALIZACAO
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Visualizar()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReHpe") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa cursores e chama base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE

