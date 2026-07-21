# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 272: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrIns.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (477 linhas total):

*-- Linhas 46 a 54:
46:         loc_lSucesso = .F.
47: 
48:         TRY
49:             THIS.Caption = "Informa" + CHR(231) + CHR(245) + "es do Servi" + CHR(231) + "o"
50: 
51:             *-- Criar Business Object para lookup de descricao e auditoria
52:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrInsBO")
53: 
54:             *-- Ler valores iniciais do cursor LocalSacOp (do form pai - DataSession=1)

*-- Linhas 134 a 256:
134: 
135:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
136:         WITH THIS.cnt_4c_Cabecalho
137:             .Top         = 0
138:             .Left        = 0
139:             .Width       = THIS.Width
140:             .Height      = 80
141:             .BorderWidth = 0
142:             .BackStyle   = 1
143:             .BackColor   = RGB(100, 100, 100)
144:             .Visible     = .T.
145: 
146:             .AddObject("lbl_4c_Sombra", "Label")
147:             WITH .lbl_4c_Sombra
148:                 .AutoSize  = .F.
149:                 .Top       = 18
150:                 .Left      = 10
151:                 .Width     = THIS.Width
152:                 .Height    = 40
153:                 .FontName  = "Tahoma"
154:                 .FontSize  = 18
155:                 .FontBold  = .T.
156:                 .BackStyle = 0
157:                 .Caption   = loc_cCaption
158:                 .ForeColor = RGB(0, 0, 0)
159:                 .Visible   = .T.
160:             ENDWITH
161: 
162:             .AddObject("lbl_4c_Titulo", "Label")
163:             WITH .lbl_4c_Titulo
164:                 .AutoSize  = .F.
165:                 .Top       = 17
166:                 .Left      = 10
167:                 .Width     = THIS.Width
168:                 .Height    = 46
169:                 .FontName  = "Tahoma"
170:                 .FontSize  = 18
171:                 .FontBold  = .T.
172:                 .BackStyle = 0
173:                 .Caption   = loc_cCaption
174:                 .ForeColor = RGB(255, 255, 255)
175:                 .Visible   = .T.
176:             ENDWITH
177:         ENDWITH
178:     ENDPROC
179: 
180:     *--------------------------------------------------------------------------
181:     * ConfigurarCampos - Labels e TextBoxes (Servico readonly, Valor editavel)
182:     *--------------------------------------------------------------------------
183:     PROTECTED PROCEDURE ConfigurarCampos(par_cCodServ, par_cDescServ, par_nVlServ)
184:         *-- Label "Servico :"
185:         THIS.AddObject("lbl_4c_Servico", "Label")
186:         WITH THIS.lbl_4c_Servico
187:             .FontBold   = .T.
188:             .FontName   = "Tahoma"
189:             .FontSize   = 8
190:             .BackStyle  = 0
191:             .Caption    = "Servi" + CHR(231) + "o :"
192:             .Height     = 17
193:             .Left       = 40
194:             .Top        = 95
195:             .Width      = 49
196:             .ForeColor  = RGB(90, 90, 90)
197:             .Visible    = .T.
198:         ENDWITH
199: 
200:         *-- TextBox codigo do servico (somente leitura - get_CodServ legado)
201:         THIS.AddObject("txt_4c_CodServ", "TextBox")
202:         WITH THIS.txt_4c_CodServ
203:             .FontName  = "Arial"
204:             .FontSize  = 9
205:             .Height    = 23
206:             .Left      = 96
207:             .Top       = 92
208:             .Width     = 80
209:             .ReadOnly  = .T.
210:             .Value     = par_cCodServ
211:             .Visible   = .T.
212:         ENDWITH
213: 
214:         *-- TextBox descricao do servico (somente leitura - get_DescServ legado)
215:         THIS.AddObject("txt_4c_DescServ", "TextBox")
216:         WITH THIS.txt_4c_DescServ
217:             .FontName  = "Arial"
218:             .FontSize  = 9
219:             .Height    = 23
220:             .Left      = 177
221:             .Top       = 92
222:             .Width     = 290
223:             .ReadOnly  = .T.
224:             .Value     = par_cDescServ
225:             .Visible   = .T.
226:         ENDWITH
227: 
228:         *-- Label "Valor :"
229:         THIS.AddObject("lbl_4c_Valor", "Label")
230:         WITH THIS.lbl_4c_Valor
231:             .FontBold   = .T.
232:             .FontName   = "Tahoma"
233:             .FontSize   = 8
234:             .BackStyle  = 0
235:             .Caption    = "Valor :"
236:             .Height     = 17
237:             .Left       = 52
238:             .Top        = 122
239:             .Width      = 37
240:             .ForeColor  = RGB(90, 90, 90)
241:             .Visible    = .T.
242:         ENDWITH
243: 
244:         *-- TextBox valor do servico (editavel - get_Valor legado)
245:         THIS.AddObject("txt_4c_Valor", "TextBox")
246:         WITH THIS.txt_4c_Valor
247:             .FontName  = "Arial"
248:             .FontSize  = 9
249:             .Height    = 23
250:             .Left      = 96
251:             .Top       = 119
252:             .Width     = 100
253:             .InputMask = "9,999,999.99"
254:             .MaxLength = 12
255:             .Value     = par_nVlServ
256:             .Visible   = .T.

*-- Linhas 262 a 278:
262:     *--------------------------------------------------------------------------
263:     PROTECTED PROCEDURE ConfigurarBotoes()
264:         *-- Botao Confirmar (ok legado - Left=534)
265:         THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
266:         WITH THIS.cmd_4c_Confirmar
267:             .Top             = 3
268:             .Left            = 534
269:             .Width           = 75
270:             .Height          = 75
271:             .Caption         = "Confirma"
272:             .FontName        = "Comic Sans MS"
273:             .FontBold        = .T.
274:             .FontItalic      = .T.
275:             .FontSize        = 8
276:             .ForeColor       = RGB(90, 90, 90)
277:             .BackColor       = RGB(255, 255, 255)
278:             .Themes           = .T.

*-- Linhas 284 a 303:
284:             .Visible         = .T.
285:         ENDWITH
286: 
287:         BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
288: 
289:         *-- Botao Cancelar (Cancela legado - Left=609)
290:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
291:         WITH THIS.cmd_4c_Cancelar
292:             .Top             = 3
293:             .Left            = 609
294:             .Width           = 75
295:             .Height          = 75
296:             .Caption         = "Cancela"
297:             .FontName        = "Comic Sans MS"
298:             .FontBold        = .T.
299:             .FontItalic      = .T.
300:             .FontSize        = 8
301:             .ForeColor       = RGB(90, 90, 90)
302:             .BackColor       = RGB(255, 255, 255)
303:             .Themes           = .T.

*-- Linhas 309 a 317:
309:             .Visible         = .T.
310:         ENDWITH
311: 
312:         BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
313:     ENDPROC
314: 
315:     *--------------------------------------------------------------------------
316:     * BtnConfirmarClick - Valida valor e devolve ao form pai
317:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\SigPrInsBO.prg):
*==============================================================================
* SigPrInsBO.prg - Business Object: Informacoes do Servico
* Herda de: BusinessBase
* Tipo: OPERACIONAL (dialog modal - recebe ParentForm, devolve valores)
* Tabela relacionada: SigCdPro (lookup de descricao do servico)
*==============================================================================

DEFINE CLASS SigPrInsBO AS BusinessBase

    *-- Codigo do servico (SigCdPro.cPros)
    this_cCodServs  = ""

    *-- Descricao do servico (SigCdPro.dPros)
    this_cDescServs = ""

    *-- Valor do servico
    this_nVlServs   = 0

    *-- Mensagem de erro para o Form consultar apos Inserir/Atualizar
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cPros"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodServs
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    * par_cAliasCursor: alias do cursor com campos cCodServs, nVlServs
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor AS String) AS Logical
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            TRY
                SELECT (par_cAliasCursor)

                THIS.this_cCodServs  = NVL(cCodServs, "")
                THIS.this_nVlServs   = NVL(nVlServs,  0)

                IF !EMPTY(THIS.this_cCodServs)
                    THIS.this_cDescServs = THIS.BuscarDescricaoServico(THIS.this_cCodServs)
                ELSE
                    THIS.this_cDescServs = ""
                ENDIF

                loc_lSucesso = .T.

            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDescricaoServico - Busca descricao do servico em SigCdPro
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoServico(par_cCodServs AS String) AS String
        LOCAL loc_cDescricao, loc_cSQL, loc_oErro

        loc_cDescricao = ""

        TRY
            loc_cSQL = "SELECT dPros" + ;
                       " FROM SigCdPro" + ;
                       " WHERE cPros = " + EscaparSQL(ALLTRIM(par_cCodServs))

            IF USED("cursor_4c_ProServico")
                USE IN cursor_4c_ProServico
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProServico") > 0
                IF !EOF("cursor_4c_ProServico")
                    loc_cDescricao = NVL(cursor_4c_ProServico.dPros, "")
                ENDIF
                USE IN cursor_4c_ProServico
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados() AS Logical
        IF EMPTY(THIS.this_cCodServs)
            THIS.this_cMensagemErro = "O c" + CHR(243) + "digo do servi" + CHR(231) + "o deve ser informado!"
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF THIS.this_nVlServs <= 0
            THIS.this_cMensagemErro = "O valor do servi" + CHR(231) + "o deve ser informado!"
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        THIS.this_cMensagemErro = ""
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Confirmacao da entrada do servico (dialog OPERACIONAL modal)
    * Semantica: NAO ha tabela persistente para INSERT SQL. Esta dialog captura
    * cCodServ + nVlServ para devolver ao ParentForm que fara a persistencia
    * efetiva na tabela de itens (ex: linha de servico de um pedido/OT).
    * Aqui apenas: valida dados, resolve descricao do servico, registra
    * auditoria da operacao e retorna sucesso para o Form fechar o dialog.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir() AS Logical
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(THIS.this_cDescServs)
                THIS.this_cDescServs = THIS.BuscarDescricaoServico(THIS.this_cCodServs)
            ENDIF

            IF EMPTY(THIS.this_cDescServs)
                THIS.this_cMensagemErro = "Servi" + CHR(231) + "o n" + CHR(227) + "o encontrado no cat" + CHR(225) + "logo!"
                MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("INSERIR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao confirmar servi" + CHR(231) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Re-confirmacao da entrada do servico (dialog OPERACIONAL modal)
    * Semantica: no fluxo do SIGPRINS original, o dialog eh usado tanto para
    * incluir uma nova linha de servico quanto para alterar uma linha existente
    * do ParentForm (que decide o modo via LocalSacOp). Nesta camada, Atualizar
    * reexecuta a mesma validacao e resolucao de descricao usadas em Inserir
    * e registra auditoria da operacao de alteracao.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar() AS Logical
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cDescServs = THIS.BuscarDescricaoServico(THIS.this_cCodServs)

            IF EMPTY(THIS.this_cDescServs)
                THIS.this_cMensagemErro = "Servi" + CHR(231) + "o n" + CHR(227) + "o encontrado no cat" + CHR(225) + "logo!"
                MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("ATUALIZAR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar servi" + CHR(231) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria (LogAuditoria)
    * Sobrescreve o padrao de BusinessBase para gravar chave descritiva da
    * operacao (codigo do servico + valor) em vez de PK de tabela inexistente.
    * DataHora usa GETDATE() (SQL Server) - regra Erro35.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cQuery, loc_cUsuario, loc_cChave, loc_oErro

        TRY
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            loc_cChave = "Servico: " + ALLTRIM(THIS.this_cCodServs) + ;
                         " | Valor: " + TRANSFORM(THIS.this_nVlServs, "@$ 999,999,999.99")

            loc_cQuery = "INSERT INTO LogAuditoria (Tabela, ChaveRegistro, Operacao, Usuario, DataHora) " + ;
                         "VALUES (" + ;
                         EscaparSQL("SigPrIns") + ", " + ;
                         EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
                         EscaparSQL(par_cOperacao) + ", " + ;
                         EscaparSQL(loc_cUsuario) + ", " + ;
                         "GETDATE())"

            SQLEXEC(gnConnHandle, loc_cQuery)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Auditoria")
        ENDTRY
    ENDPROC

ENDDEFINE

