# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 205: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 228: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 252: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFpd.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (975 linhas total):

*-- Linhas 124 a 268:
124: 
125:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
126:         WITH THIS.cnt_4c_Cabecalho
127:             .Top         = -1
128:             .Left        = -2
129:             .Width       = THIS.Width
130:             .Height      = 80
131:             .BorderWidth = 0
132:             .BackColor   = RGB(100, 100, 100)
133:             .Visible     = .T.
134: 
135:             .AddObject("lbl_4c_LblSombra", "Label")
136:             WITH .lbl_4c_LblSombra
137:                 .FontBold      = .T.
138:                 .FontName      = "Tahoma"
139:                 .FontSize      = 18
140:                 .FontUnderline = .F.
141:                 .WordWrap      = .T.
142:                 .Alignment     = 0
143:                 .BackStyle     = 0
144:                 .Caption       = loc_cCaption
145:                 .Height        = 40
146:                 .Left          = 10
147:                 .Top           = 18
148:                 .Width         = THIS.Width
149:                 .ForeColor     = RGB(0, 0, 0)
150:                 .AutoSize      = .F.
151:                 .Visible       = .T.
152:             ENDWITH
153: 
154:             .AddObject("lbl_4c_LblTitulo", "Label")
155:             WITH .lbl_4c_LblTitulo
156:                 .FontBold      = .T.
157:                 .FontName      = "Tahoma"
158:                 .FontSize      = 18
159:                 .WordWrap      = .T.
160:                 .Alignment     = 0
161:                 .BackStyle     = 0
162:                 .Caption       = loc_cCaption
163:                 .Height        = 46
164:                 .Left          = 10
165:                 .Top           = 17
166:                 .Width         = THIS.Width
167:                 .ForeColor     = RGB(255, 255, 255)
168:                 .AutoSize      = .F.
169:                 .Visible       = .T.
170:             ENDWITH
171:         ENDWITH
172:     ENDPROC
173: 
174:     *--------------------------------------------------------------------------
175:     * ConfigurarContainerBotoes - Botoes Inserir/Excluir/Encerrar do legado
176:     * Legado: cmdInserir.Left=334, cmdExcluir.Left=409, cmdSair.Left=484 (form direto)
177:     * Novo: agrupados em cnt_4c_Botoes a partir de Left=330
178:     *--------------------------------------------------------------------------
179:     PROTECTED PROCEDURE ConfigurarContainerBotoes()
180:         LOCAL loc_oForm
181:         loc_oForm = THIS
182: 
183:         THIS.AddObject("cnt_4c_Botoes", "Container")
184:         WITH THIS.cnt_4c_Botoes
185:             .Top         = 2
186:             .Left        =  542
187:             .Width       = 228
188:             .Height      = 82
189:             .BorderWidth = 0
190:             .BackStyle   = 0
191:             .Visible     = .T.
192: 
193:             *-- Botao Inserir (legado: cmdInserir, Left=334)
194:             .AddObject("cmd_4c_Inserir", "CommandButton")
195:             WITH .cmd_4c_Inserir
196:                 .Caption         = "Inserir"
197:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
198:                 .PicturePosition = 13
199:                 .Top             = 5
200:                 .Left            =  542
201:                 .Width           = 72
202:                 .Height          = 72
203:                 .BackColor       = RGB(255, 255, 255)
204:                 .ForeColor       = RGB(90, 90, 90)
205:                 .FontName        = "Comic Sans MS"
206:                 .FontSize        = 8
207:                 .FontBold        = .T.
208:                 .FontItalic      = .T.
209:                 .SpecialEffect   = 0
210:                 .WordWrap        = .T.
211:                 .MousePointer    = 15
212:                 .Visible         = .T.
213:             ENDWITH
214:             BINDEVENT(.cmd_4c_Inserir, "Click", loc_oForm, "BtnInserirClick")
215: 
216:             *-- Botao Excluir (legado: cmdExcluir, Left=409)
217:             .AddObject("cmd_4c_Excluir", "CommandButton")
218:             WITH .cmd_4c_Excluir
219:                 .Caption         = "Excluir"
220:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
221:                 .PicturePosition = 13
222:                 .Top             = 5
223:                 .Left            =  542
224:                 .Width           = 72
225:                 .Height          = 72
226:                 .BackColor       = RGB(255, 255, 255)
227:                 .ForeColor       = RGB(90, 90, 90)
228:                 .FontName        = "Comic Sans MS"
229:                 .FontSize        = 8
230:                 .FontBold        = .T.
231:                 .FontItalic      = .T.
232:                 .Themes          = .F.
233:                 .SpecialEffect   = 0
234:                 .WordWrap        = .T.
235:                 .MousePointer    = 15
236:                 .Visible         = .T.
237:             ENDWITH
238:             BINDEVENT(.cmd_4c_Excluir, "Click", loc_oForm, "BtnExcluirClick")
239: 
240:             *-- Botao Encerrar (legado: cmdSair, Left=484, Cancel=.T.)
241:             .AddObject("cmd_4c_Encerrar", "CommandButton")
242:             WITH .cmd_4c_Encerrar
243:                 .Caption         = "Encerrar"
244:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
245:                 .PicturePosition = 13
246:                 .Top             = 5
247:                 .Left            =  542
248:                 .Width           = 75
249:                 .Height          = 75
250:                 .BackColor       = RGB(255, 255, 255)
251:                 .ForeColor       = RGB(90, 90, 90)
252:                 .FontName        = "Comic Sans MS"
253:                 .FontSize        = 8
254:                 .FontBold        = .T.
255:                 .FontItalic      = .T.
256:                 .Themes          = .F.
257:                 .SpecialEffect   = 0
258:                 .WordWrap        = .T.
259:                 .MousePointer    = 15
260:                 .Cancel          = .T.
261:                 .Visible         = .T.
262:             ENDWITH
263:             BINDEVENT(.cmd_4c_Encerrar, "Click", loc_oForm, "BtnEncerrarClick")
264:         ENDWITH
265:     ENDPROC
266: 
267:     *--------------------------------------------------------------------------
268:     * ConfigurarGrade - Cria grd_4c_Dados diretamente no form (como no legado:

*-- Linhas 278 a 287:
278:         THIS.grd_4c_Dados.ColumnCount  = 2
279: 
280:         WITH THIS.grd_4c_Dados
281:             .Top               = 112
282:             .Left              = 192
283:             .Width             = 176
284:             .Height            = 221
285:             .DeleteMark        = .F.
286:             .RecordMark        = .T.
287:             .RowHeight         = 18

*-- Linhas 310 a 318:
310:             .Movable           = .F.
311:             .Resizable         = .F.
312:             .ReadOnly          = .F.
313:             .Header1.Caption   = "Condi" + CHR(231) + CHR(227) + "o Pagto"
314:             .Header1.FontBold  = .T.
315:             .Header1.FontName  = "Tahoma"
316:             .Header1.FontSize  = 8
317:             .Header1.Alignment = 2
318:             .Header1.ForeColor = RGB(90, 90, 90)

*-- Linhas 327 a 335:
327:             .Movable           = .F.
328:             .Resizable         = .F.
329:             .ReadOnly          = .F.
330:             .Header1.Caption   = "Parcela"
331:             .Header1.FontBold  = .T.
332:             .Header1.FontName  = "Tahoma"
333:             .Header1.FontSize  = 8
334:             .Header1.Alignment = 2
335:             .Header1.ForeColor = RGB(90, 90, 90)

*-- Linhas 391 a 406:
391:                         THIS.grd_4c_Dados.Column2.ControlSource = "crSigOpFpD.nparcs"
392: 
393:                         *-- Reconfigurar headers apos RecordSource (OBRIGATORIO)
394:                         THIS.grd_4c_Dados.Column1.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o Pagto"
395:                         THIS.grd_4c_Dados.Column2.Header1.Caption = "Parcela"
396: 
397:                         *-- Atualizar caption com TabDs (legado: Caption = Caption + AllTrim(CrSigOpTdz.Codigos))
398:                         THIS.Caption = "Cond.Pagto Por Tab.Desconto - " + ALLTRIM(THIS.this_cTabDs)
399:                         IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
400:                             THIS.cnt_4c_Cabecalho.lbl_4c_LblSombra.Caption = THIS.Caption
401:                             THIS.cnt_4c_Cabecalho.lbl_4c_LblTitulo.Caption = THIS.Caption
402:                         ENDIF
403: 
404:                         THIS.grd_4c_Dados.Refresh()
405:                         loc_lSucesso = .T.
406:                     ENDIF

*-- Linhas 676 a 685:
676:         IF EMPTY(loc_cFpags)
677:             *-- Legado: LostFocus com Fpags vazio -> cmdSair.SetFocus
678:             IF VARTYPE(THIS.cnt_4c_Botoes) = "O"
679:                 IF VARTYPE(THIS.cnt_4c_Botoes.cmd_4c_Encerrar) = "O"
680:                     THIS.cnt_4c_Botoes.cmd_4c_Encerrar.SetFocus()
681:                 ENDIF
682:             ENDIF
683:             RETURN
684:         ENDIF
685: 

*-- Linhas 886 a 895:
886:         LOCAL loc_lTemRegistros
887:         loc_lTemRegistros = USED("crSigOpFpD") AND (RECCOUNT("crSigOpFpD") > 0) AND !EOF("crSigOpFpD")
888:         IF VARTYPE(THIS.cnt_4c_Botoes) = "O"
889:             IF VARTYPE(THIS.cnt_4c_Botoes.cmd_4c_Excluir) = "O"
890:                 THIS.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistros
891:             ENDIF
892:         ENDIF
893:     ENDPROC
894: 
895:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\FpdBO.prg):
*==============================================================================
* FpdBO.PRG
* Business Object para Condicoes de Pagamento por Tabela de Desconto (SIGCDFPD)
*
* Tabela Principal : SigOpFpd - Condicoes de pagamento por tabela
*                               (cidchaves char(20), fpags char(12),
*                                nparcs numeric(2), tabds char(10))
* Tabela Lookup    : SigOpFp  - Cadastro de condicoes de pagamento
*                               (fpags char(12), descrs char(30))
*
* Logica: Gerencia colecao de condicoes de pagamento vinculadas a uma
*         tabela de desconto (TabDs). Salvar = DELETE all for TabDs
*         + re-INSERT from cursor crSigOpFpD.
*==============================================================================

DEFINE CLASS FpdBO AS BusinessBase

    *-- Campos de SigOpFpd
    this_cCidChaves = ""    && cidchaves CHAR(20) - chave unica (PK)
    this_nNParcs    = 0     && nparcs    NUMERIC(2,0) - numero de parcelas
    this_cFpags     = ""    && fpags     CHAR(12) - codigo condicao de pagamento
    this_cTabDs     = ""    && tabds     CHAR(10) - discriminador (chave do parent)

    *-- Cursor de dados da grade (nome legado obrigatorio - FRX/grid referencia este nome)
    this_cCursorDados = "crSigOpFpD"

    *-- Cursor de lookup para condicoes de pagamento
    this_cCursorLookup = "LocalFpag"

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpFpd"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega registros de SigOpFpd com filtro opcional
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT cidchaves, fpags, nparcs, tabds FROM SigOpFpd"
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT cidchaves, fpags, nparcs, tabds FROM SigOpFpd" + ;
                       " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpdCarga")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_FpdCarga") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_FpdCarga")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_FpdCarga")
            USE IN cursor_4c_FpdCarga
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cFpags     = TratarNulo(fpags, "C")
            THIS.this_nNParcs    = TratarNulo(nparcs, "N")
            THIS.this_cTabDs     = TratarNulo(tabds, "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigOpFpd (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigOpFpd (cidchaves, fpags, nparcs, tabds)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cFpags) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNParcs) + ", " + ;
                       EscaparSQL(THIS.this_cTabDs) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigOpFpd (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigOpFpd SET " + ;
                       "fpags = " + EscaparSQL(THIS.this_cFpags) + ", " + ;
                       "nparcs = " + FormatarNumeroSQL(THIS.this_nNParcs) + ", " + ;
                       "tabds = " + EscaparSQL(THIS.this_cTabDs) + ;
                       " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigOpFpd (PROTECTED - chamado por Excluir())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigOpFpd WHERE RTRIM(cidchaves) = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosGrid - Carrega crSigOpFpD do servidor para o TabDs informado
    * Cria cursor editavel local a partir dos dados do SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosGrid(par_cTabDs)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("crSigOpFpD")
                USE IN crSigOpFpD
            ENDIF
            IF USED("cursor_4c_FpdLoad")
                USE IN cursor_4c_FpdLoad
            ENDIF

            loc_cSQL = "SELECT cidchaves, fpags, nparcs, tabds FROM SigOpFpd" + ;
                       " WHERE RTRIM(tabds) = " + EscaparSQL(ALLTRIM(par_cTabDs))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpdLoad")

            IF loc_nResult >= 0
                SET NULL ON
                CREATE CURSOR crSigOpFpD (cidchaves C(20), fpags C(12), nparcs N(2,0), tabds C(10))
                SET NULL OFF

                IF RECCOUNT("cursor_4c_FpdLoad") > 0
                    APPEND FROM DBF("cursor_4c_FpdLoad")
                ENDIF

                IF USED("cursor_4c_FpdLoad")
                    USE IN cursor_4c_FpdLoad
                ENDIF

                GO TOP IN crSigOpFpD
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar dados da grade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLookupFpag - Carrega LocalFpag de SigOpFp indexado por fpags
    * Necessario para validacao/busca na Column1 da grade
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLookupFpag()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("LocalFpag")
                USE IN LocalFpag
            ENDIF

            loc_cSQL = "SELECT fpags, descrs FROM SigOpFp ORDER BY fpags"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalFpag")

            IF loc_nResult >= 0
                SELECT LocalFpag
                INDEX ON ALLTRIM(fpags) TAG fpags
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lookup:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFpags - Verifica se codigo Fpags existe em LocalFpag
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFpags(par_cFpags)
        LOCAL loc_lValido
        loc_lValido = .F.
        IF USED("LocalFpag") AND !EMPTY(par_cFpags)
            loc_lValido = SEEK(ALLTRIM(par_cFpags), "LocalFpag", "fpags")
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarGrid - Persiste grade crSigOpFpD no servidor para o TabDs dado
    * Logica: limpa vazios -> valida duplicatas -> DELETE all -> INSERT batch
    * Retorna .T. se gravado, .F. se duplicata detectada ou erro
    *--------------------------------------------------------------------------
    PROCEDURE SalvarGrid(par_cTabDs)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_nCount
        LOCAL loc_cChave, loc_cFpags, loc_nNParcs
        loc_lSucesso = .F.

        IF !USED("crSigOpFpD")
            MsgErro("Cursor crSigOpFpD nao encontrado.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            *-- Passo 1: Remover linhas com Fpags ou nParcs vazios
            SELECT crSigOpFpD
            DELETE FOR EMPTY(ALLTRIM(fpags))
            DELETE FOR EMPTY(nparcs)
            PACK

            *-- Passo 2: Atribuir cidchaves para registros sem chave unica
            SELECT crSigOpFpD
            GO TOP
            DO WHILE !EOF()
                IF EMPTY(ALLTRIM(cidchaves))
                    REPLACE cidchaves WITH LEFT(PADL(TRANSFORM(RECNO()), 10, "0") + SYS(2015), 20)
                ENDIF
                SKIP
            ENDDO

            *-- Passo 3: Verificar duplicatas (fpags + nparcs) - logica do legado
            SELECT fpags, nparcs, SUM(1) AS TT ;
                FROM crSigOpFpD ;
                GROUP BY 1, 2 ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_FpdDupls READWRITE
            loc_nCount = RECCOUNT("cursor_4c_FpdDupls")
            IF USED("cursor_4c_FpdDupls")
                USE IN cursor_4c_FpdDupls
            ENDIF

            IF loc_nCount > 0
                MsgAviso("Dados em duplicidade! Verifique a grade antes de salvar.", "Duplicidade")
            ELSE
                *-- Passo 4: DELETE todos os registros existentes para TabDs
                loc_cSQL = "DELETE FROM SigOpFpd WHERE RTRIM(tabds) = " + ;
                           EscaparSQL(ALLTRIM(par_cTabDs))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    *-- Passo 5: INSERT cada linha valida do cursor
                    loc_lSucesso = .T.
                    SELECT crSigOpFpD
                    GO TOP
                    DO WHILE !EOF() AND loc_lSucesso
                        loc_cChave  = ALLTRIM(cidchaves)
                        loc_cFpags  = ALLTRIM(fpags)
                        loc_nNParcs = nparcs

                        IF !EMPTY(loc_cFpags)
                            loc_cSQL = "INSERT INTO SigOpFpd (cidchaves, fpags, nparcs, tabds)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cChave) + ", " + ;
                                       EscaparSQL(loc_cFpags) + ", " + ;
                                       FormatarNumeroSQL(loc_nNParcs) + ", " + ;
                                       EscaparSQL(ALLTRIM(par_cTabDs)) + ")"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResult < 0
                                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                        ENDIF

                        SKIP
                    ENDDO

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("UPDATE")
                    ENDIF
                ELSE
                    MsgErro("Erro ao excluir registros antigos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharCursores - Fecha cursores abertos pelo BO (chamado no Destroy do Form)
    *--------------------------------------------------------------------------
    PROCEDURE FecharCursores()
        IF USED("crSigOpFpD")
            USE IN crSigOpFpD
        ENDIF
        IF USED("LocalFpag")
            USE IN LocalFpag
        ENDIF
    ENDPROC

ENDDEFINE

