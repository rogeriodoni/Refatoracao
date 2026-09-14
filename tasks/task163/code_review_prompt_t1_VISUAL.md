# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCIC.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (824 linhas total):

*-- Linhas 73 a 81:
73:             ENDIF
74: 
75:             *-- Caption com acento via CHR (regra: sem literais acentuados em PRG)
76:             THIS.Caption = "Escolha de " + CHR(237) + "cones"
77: 
78:             *-- Imagem de fundo do form (copiada do SCX legado)
79:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
80: 
81:             *-- Cria Business Object

*-- Linhas 116 a 163:
116:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
117:         loc_oCab = THIS.cnt_4c_Cabecalho
118:         WITH loc_oCab
119:             .Top         = 0
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackStyle   = 1
124:             .BackColor   = RGB(100, 100, 100)
125:             .BorderWidth = 0
126: 
127:             .AddObject("lbl_4c_Sombra", "Label")
128:             WITH .lbl_4c_Sombra
129:                 .AutoSize      = .F.
130:                 .Top           = 18
131:                 .Left          = 10
132:                 .Width         = loc_oCab.Width
133:                 .Height        = 40
134:                 .FontBold      = .T.
135:                 .FontName      = "Tahoma"
136:                 .FontSize      = 18
137:                 .FontUnderline = .F.
138:                 .WordWrap      = .T.
139:                 .Alignment     = 0
140:                 .BackStyle     = 0
141:                 .Caption       = "Escolha de " + CHR(237) + "cones"
142:                 .ForeColor     = RGB(0, 0, 0)
143:             ENDWITH
144: 
145:             .AddObject("lbl_4c_Titulo", "Label")
146:             WITH .lbl_4c_Titulo
147:                 .AutoSize  = .F.
148:                 .Top       = 17
149:                 .Left      = 10
150:                 .Width     = loc_oCab.Width
151:                 .Height    = 46
152:                 .FontBold  = .T.
153:                 .FontName  = "Tahoma"
154:                 .FontSize  = 18
155:                 .WordWrap  = .T.
156:                 .Alignment = 0
157:                 .BackStyle = 0
158:                 .Caption   = "Escolha de " + CHR(237) + "cones"
159:                 .ForeColor = RGB(255, 255, 255)
160:             ENDWITH
161:         ENDWITH
162: 
163:         *-- Torna cabecalho visivel explicitamente (TornarControlesVisiveis o filtra via INLIST)

*-- Linhas 176 a 192:
176:         loc_oPgf = THIS.pgf_4c_Paginas
177:         loc_oPgf.PageCount = 2
178:         loc_oPgf.ErasePage = .T.
179:         loc_oPgf.Top       = 80
180:         loc_oPgf.Left      = 0
181:         loc_oPgf.Width     = THIS.Width
182:         loc_oPgf.Height    = THIS.Height - 80
183:         loc_oPgf.TabIndex  = 1
184:         loc_oPgf.Tabs      = .F.
185: 
186:         loc_oPgf.Page1.Caption = "Lista"
187:         loc_oPgf.Page2.Caption = "Dados"
188: 
189:         *-- Constroi controles da Page1 (grid de icones + preview + campo Programa)
190:         THIS.ConfigurarPaginaLista()
191: 
192:         *-- Page2: dialog plano, sem campos adicionais no original

*-- Linhas 199 a 226:
199: 
200:     *--------------------------------------------------------------------------
201:     * ConfigurarPaginaLista - Constroi todos os controles de Page1:
202:     *   - lbl_4c_Programa + txt_4c_Programa (campo programa, somente leitura)
203:     *   - shp_4c_Preview (borda decorativa ao redor do preview)
204:     *   - img_4c_Icone (imagem preview do icone selecionado)
205:     *   - grd_4c_Dados (lista de icones - mapeado de Grid1 do legado)
206:     *   - BINDEVENTs para navegacao no grid e selecao de icone
207:     *
208:     * Posicoes: PageFrame.Top=80; controles em coords relativas a Page1
209:     * (Top_original - 80). RecordSource definido em CarregarDados().
210:     *--------------------------------------------------------------------------
211:     PROTECTED PROCEDURE ConfigurarPaginaLista()
212:         LOCAL loc_oPagina, loc_oGrid
213: 
214:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
215: 
216:         *-- Label "Programa" (Say2 do legado: Top=86 -> 86-80=6)
217:         loc_oPagina.AddObject("lbl_4c_Programa", "Label")
218:         WITH loc_oPagina.lbl_4c_Programa
219:             .Caption   = "Programa"
220:             .Left      = 12
221:             .Top       = 6
222:             .AutoSize  = .T.
223:             .FontName  = "Tahoma"
224:             .FontSize  = 8
225:             .ForeColor = RGB(90, 90, 90)
226:             .BackStyle = 0

*-- Linhas 233 a 267:
233:             .FontName  = "Tahoma"
234:             .FontSize  = 8
235:             .Height    = 24
236:             .Left      = 9
237:             .Top       = 23
238:             .Width     = 457
239:             .ForeColor = RGB(90, 90, 90)
240:             .ReadOnly  = .T.
241:             .Value     = ""
242:         ENDWITH
243: 
244:         *-- Shape - borda decorativa ao redor do preview (Shape1 do legado: Top=184 -> 104)
245:         loc_oPagina.AddObject("shp_4c_Preview", "Shape")
246:         WITH loc_oPagina.shp_4c_Preview
247:             .Top         = 104
248:             .Left        = 276
249:             .Height      = 169
250:             .Width       = 169
251:             .BackStyle   = 0
252:             .BorderStyle = 0
253:             .BorderColor = RGB(136, 189, 188)
254:         ENDWITH
255: 
256:         *-- Image - preview do icone selecionado (Icone do legado: Top=200 -> 120)
257:         loc_oPagina.AddObject("img_4c_Icone", "Image")
258:         WITH loc_oPagina.img_4c_Icone
259:             .Stretch = 1
260:             .Height  = 156
261:             .Left    = 282
262:             .Top     = 120
263:             .Width   = 156
264:         ENDWITH
265: 
266:         *-- Grid de icones (Grid1 do legado: Top=131 -> 51)
267:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")

*-- Linhas 273 a 282:
273:             .DeleteMark        = .F.
274:             .RecordMark        = .F.
275:             .Height            = 345
276:             .Left              = 10
277:             .Top               = 51
278:             .Width             = 242
279:             .GridLineColor     = RGB(238, 238, 238)
280:             .ReadOnly          = .T.
281:             .ScrollBars        = 2
282:             .HeaderHeight      = 15

*-- Linhas 309 a 317:
309:             .Column1.FontName = "Courier New"
310: 
311:             *-- Header (CHR(205) = I-agudo maiusculo)
312:             .Column1.Header1.Caption   = CHR(205) + "cones"
313:             .Column1.Header1.FontName  = "Tahoma"
314:             .Column1.Header1.FontSize  = 8
315:             .Column1.Header1.Alignment = 2
316:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
317: 


### BO (C:\4c\projeto\app\classes\SIGPRCICBO.prg):
*==============================================================================
* SIGPRCICBO.prg - Business Object para Seletor de Icones de Programas
* Data: 2026-07-02
* Funcao: Dialog de escolha de icone para item de menu/programa
* Obs: Form opera na datasession do form pai (sem SQL proprio)
*==============================================================================

DEFINE CLASS SIGPRCICBO AS BusinessBase

    *-- Chave do programa passada pelo form pai (pcIdChaves no legado)
    this_cIdChaves      = ""    && pkChaves do programa (crProg1/crProg2)

    *-- Icone atualmente selecionado (barrapict no legado)
    this_cArqIcone      = ""    && nome do arquivo de icone (ex: "geral_ok_26.jpg")

    *-- Descricao do programa exibida no campo readonly
    this_cDescricao     = ""    && descricaos de crProg2

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGPRCIC"
        THIS.this_cCampoChave = "pkChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de crProg2 ou alias
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cIdChaves  = TratarNulo(pkChaves,   "C")
                THIS.this_cArqIcone  = LOWER(ALLTRIM(TratarNulo(barrapict,  "C")))
                THIS.this_cDescricao = TratarNulo(descricaos, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave do programa selecionado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarIcone - Atualiza barrapict em crProg1 e crProg2 (cursor REPLACE)
    * Este form opera na datasession do form pai; nao usa SQLEXEC proprio.
    * A gravacao definitiva no SQL Server eh feita pelo form pai ao salvar.
    *--------------------------------------------------------------------------
    FUNCTION SelecionarIcone(par_cArqIcone, par_cIdChaves)
        LOCAL loc_lSucesso, loc_cIcone
        loc_lSucesso = .F.

        TRY
            loc_cIcone = LOWER(ALLTRIM(par_cArqIcone))
            IF loc_cIcone = "< nenhum >"
                loc_cIcone = ""
            ENDIF

            IF USED("crProg1") AND SEEK(par_cIdChaves, "crProg1", "pkChaves")
                SELECT crProg1
                REPLACE barrapict WITH loc_cIcone, ;
                        barraforms WITH IIF(!EMPTY(barraforms), barraforms, crProg1.programas)
            ENDIF

            IF USED("crProg2") AND SEEK(par_cIdChaves, "crProg2", "pkChaves")
                SELECT crProg2
                REPLACE barrapict WITH loc_cIcone, ;
                        barraforms WITH IIF(!EMPTY(barraforms), barraforms, crProg2.programas)
            ENDIF

            THIS.this_cArqIcone = loc_cIcone
            THIS.this_cIdChaves = par_cIdChaves
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Atribui um icone ao programa (primeira selecao)
    * Faz REPLACE em crProg1/crProg2 com o icone selecionado + audita.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cMensagemErro = "Chave do programa n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            IF THIS.SelecionarIcone(THIS.this_cArqIcone, THIS.this_cIdChaves)
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atribuir " + CHR(237) + "cone"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Troca o icone atribuido ao programa
    * Faz REPLACE em crProg1/crProg2 com o novo icone + audita.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cMensagemErro = "Chave do programa n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            IF THIS.SelecionarIcone(THIS.this_cArqIcone, THIS.this_cIdChaves)
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atualizar " + CHR(237) + "cone"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove o icone atribuido (barrapict = "")
    * Faz REPLACE em crProg1/crProg2 zerando o icone + audita.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cMensagemErro = "Chave do programa n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            IF USED("crProg1") AND SEEK(THIS.this_cIdChaves, "crProg1", "pkChaves")
                SELECT crProg1
                REPLACE barrapict WITH "", barraforms WITH ""
            ENDIF

            IF USED("crProg2") AND SEEK(THIS.this_cIdChaves, "crProg2", "pkChaves")
                SELECT crProg2
                REPLACE barrapict WITH "", barraforms WITH ""
            ENDIF

            THIS.this_cArqIcone = ""
            THIS.RegistrarAuditoria("DELETE")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava a alteracao de icone em LogAuditoria
    * Override: escreve com Tabela="SIGPRCIC" (form nao mapeia tabela real)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario

        loc_cChave = THIS.ObterChavePrimaria()

        IF EMPTY(loc_cChave) OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

        loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                   "VALUES (" + EscaparSQL(THIS.this_cTabela) + ", " + ;
                   EscaparSQL(par_cOperacao) + ", " + ;
                   EscaparSQL(loc_cChave) + ", " + ;
                   EscaparSQL(loc_cUsuario) + ", GETDATE())"

        SQLEXEC(gnConnHandle, loc_cSQL)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarIconeAtual - Le o icone atual do cursor crProg2 para o par_cIdChaves
    *--------------------------------------------------------------------------
    FUNCTION BuscarIconeAtual(par_cIdChaves)
        LOCAL loc_cIcone
        loc_cIcone = ""

        TRY
            IF USED("crProg2") AND SEEK(par_cIdChaves, "crProg2", "pkChaves")
                IF !EMPTY(crProg2.barrapict)
                    loc_cIcone = PADR(LOWER(ALLTRIM(crProg2.barrapict)), 64)
                ENDIF
                THIS.this_cDescricao = TratarNulo(crProg2.descricaos, "C")
            ENDIF

            IF EMPTY(loc_cIcone) AND !EMPTY(par_cIdChaves)
                loc_cIcone = PADR(LOWER(ALLTRIM(JUSTFNAME(par_cIdChaves))), 64)
            ENDIF

            THIS.this_cArqIcone = loc_cIcone
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cIcone
    ENDPROC

ENDDEFINE

