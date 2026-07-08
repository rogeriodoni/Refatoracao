# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 217: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 238: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 260: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREIPS.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (733 linhas total):

*-- Linhas 9 a 17:
9: * relatorio SigReIp3 (etiquetas de mala direta).
10: *
11: * Controles:
12: *   lbl_4c_Selecao  - label "Selecao :"  (Say1, Top=139, Left=61)
13: *   txt_4c_Codigo   - codigo (Get_codigo, Top=136, Left=124, W=66)
14: *   txt_4c_Desc     - descricao (Get_desc,  Top=136, Left=192, W=220)
15: *
16: * Lookups: F4/DblClick em ambos os campos -> SigMlItn (Codigos, Descs)
17: * Validacao: txt_4c_Desc.ReadOnly = !EMPTY(txt_4c_Codigo) (Get_desc.When)

*-- Linhas 57 a 65:
57:         loc_lSucesso   = .F.
58:         loc_lContinuar = .T.
59:         TRY
60:             THIS.Caption = "Impress" + CHR(227) + "o de Etiquetas"
61: 
62:             IF TYPE("gc_4c_CaminhoIcones") = "U"
63:                 gc_4c_CaminhoIcones = ""
64:             ENDIF
65:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 75 a 84:
75:                 THIS.ConfigurarPageFrame()
76:                 THIS.TornarControlesVisiveis(THIS)
77: 
78:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
79:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
80: 
81:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
82:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
83:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
84:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

*-- Linhas 128 a 166:
128:     PROTECTED PROCEDURE ConfigurarCabecalho()
129:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
130:         WITH THIS.cnt_4c_Cabecalho
131:             .Top         = 0
132:             .Left        = 0
133:             .Width       = THIS.Width
134:             .Height      = 80
135:             .BackStyle   = 1
136:             .BackColor   = RGB(100, 100, 100)
137:             .BorderWidth = 0
138:             .Visible     = .T.
139: 
140:             .AddObject("lbl_4c_Sombra", "Label")
141:             WITH .lbl_4c_Sombra
142:                 .Top       = 32
143:                 .Left      = 22
144:                 .Width     = THIS.Width
145:                 .Height    = 30
146:                 .Caption   = "Impress" + CHR(227) + "o de Etiquetas"
147:                 .FontName  = "Tahoma"
148:                 .FontSize  = 12
149:                 .FontBold  = .T.
150:                 .ForeColor = RGB(0, 0, 0)
151:                 .BackStyle = 0
152:                 .Visible   = .T.
153:             ENDWITH
154: 
155:             .AddObject("lbl_4c_Titulo", "Label")
156:             WITH .lbl_4c_Titulo
157:                 .Top       = 30
158:                 .Left      = 20
159:                 .Width     = THIS.Width
160:                 .Height    = 30
161:                 .Caption   = "Impress" + CHR(227) + "o de Etiquetas"
162:                 .FontName  = "Tahoma"
163:                 .FontSize  = 12
164:                 .FontBold  = .T.
165:                 .ForeColor = RGB(255, 255, 255)
166:                 .BackStyle = 0

*-- Linhas 177 a 202:
177:     PROTECTED PROCEDURE ConfigurarBotoes()
178:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
179:         WITH THIS.cmg_4c_Botoes
180:             .Top           = 0
181:             .Left          = 286
182:             .Width         = 310
183:             .Height        = 85
184:             .ButtonCount   = 4
185:             .BackStyle     = 0
186:             .BorderStyle   = 0
187:             .BorderColor   = RGB(136, 189, 188)
188:             .SpecialEffect = 1
189:             .Themes        = .F.
190:             .Visible       = .T.
191: 
192:             WITH .Buttons(1)
193:                 .Top             = 5
194:                 .Left            = 5
195:                 .Width           = 75
196:                 .Height          = 75
197:                 .Caption         = "Visualizar"
198:                 .FontBold        = .T.
199:                 .FontItalic      = .T.
200:                 .BackColor       = RGB(255, 255, 255)
201:                 .ForeColor       = RGB(90, 90, 90)
202:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 209 a 223:
209:             ENDWITH
210: 
211:             WITH .Buttons(2)
212:                 .Top             = 5
213:                 .Left            = 80
214:                 .Width           = 75
215:                 .Height          = 75
216:                 .Caption         = "Imprimir"
217:                 .FontName        = "Comic Sans MS"
218:                 .FontBold        = .T.
219:                 .FontItalic      = .T.
220:                 .FontSize        = 8
221:                 .BackColor       = RGB(255, 255, 255)
222:                 .ForeColor       = RGB(90, 90, 90)
223:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 230 a 244:
230:             ENDWITH
231: 
232:             WITH .Buttons(3)
233:                 .Top             = 5
234:                 .Left            = 155
235:                 .Width           = 75
236:                 .Height          = 75
237:                 .Caption         = "Excel"
238:                 .FontName        = "Comic Sans MS"
239:                 .FontBold        = .T.
240:                 .FontItalic      = .T.
241:                 .FontSize        = 8
242:                 .BackColor       = RGB(255, 255, 255)
243:                 .ForeColor       = RGB(90, 90, 90)
244:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 251 a 266:
251:             ENDWITH
252: 
253:             WITH .Buttons(4)
254:                 .Top             = 5
255:                 .Left            = 230
256:                 .Width           = 75
257:                 .Height          = 75
258:                 .Caption         = "Encerrar"
259:                 .Cancel          = .T.
260:                 .FontName        = "Comic Sans MS"
261:                 .FontBold        = .T.
262:                 .FontItalic      = .T.
263:                 .FontSize        = 8
264:                 .BackColor       = RGB(255, 255, 255)
265:                 .ForeColor       = RGB(90, 90, 90)
266:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 281 a 306:
281:     *   Adicionados ao form (nao ao container) para z-order sobre fundo cinza.
282:     *--------------------------------------------------------------------------
283:     PROTECTED PROCEDURE ConfigurarCamposFiltro()
284:         THIS.AddObject("lbl_4c_Selecao", "Label")
285:         WITH THIS.lbl_4c_Selecao
286:             .Top       = 139
287:             .Left      = 61
288:             .Caption   = "Sele" + CHR(231) + CHR(227) + "o : "
289:             .FontName  = "Tahoma"
290:             .FontSize  = 8
291:             .FontBold  = .T.
292:             .ForeColor = RGB(90, 90, 90)
293:             .BackStyle = 0
294:             .AutoSize  = .T.
295:             .Visible   = .T.
296:         ENDWITH
297: 
298:         THIS.AddObject("txt_4c_Codigo", "TextBox")
299:         WITH THIS.txt_4c_Codigo
300:             .Top         = 136
301:             .Left        = 124
302:             .Width       = 66
303:             .Height      = 23
304:             .MaxLength   = 8
305:             .Value       = ""
306:             .FontName    = "Tahoma"

*-- Linhas 313 a 322:
313: 
314:         THIS.AddObject("txt_4c_Desc", "TextBox")
315:         WITH THIS.txt_4c_Desc
316:             .Top         = 136
317:             .Left        = 192
318:             .Width       = 220
319:             .Height      = 23
320:             .MaxLength   = 30
321:             .Value       = ""
322:             .FontName    = "Tahoma"

*-- Linhas 332 a 345:
332:     * ConfigurarPaginaDados - NAO APLICAVEL: layout flat (frmrelatorio)
333:     *   Form SIGREIPS eh de relatorio (frmrelatorio), nao CRUD (frmcadastro).
334:     *   Nao ha PageFrame de duas paginas nem Page2 de edicao.
335:     *   Todos os controles de filtro (lbl_4c_Selecao, txt_4c_Codigo,
336:     *   txt_4c_Desc) sao adicionados em ConfigurarCamposFiltro(), chamado
337:     *   por ConfigurarPageFrame(). Este metodo existe por compatibilidade
338:     *   com FormBase e nao executa configuracoes adicionais.
339:     *   Campos desta fase (50% inicial = todos, pois sao apenas 3):
340:     *     [1] lbl_4c_Selecao  -> "Sele" + CHR(231) + CHR(227) + "o : "
341:     *     [2] txt_4c_Codigo   -> Get_codigo (Top=136, Left=124, W=66)
342:     *     [3] txt_4c_Desc     -> Get_desc   (Top=136, Left=192, W=220)
343:     *   Implementados integralmente em ConfigurarCamposFiltro() (fases 3-4).
344:     *--------------------------------------------------------------------------
345:     PROTECTED PROCEDURE ConfigurarPaginaDados()


### BO (C:\4c\projeto\app\classes\SIGREIPSBO.prg):
*==============================================================================
* SIGREIPSBO.PRG
* Business Object para Relatorio de Impressao de Etiquetas/Mala Direta (SigReIp3)
*
* Herda de RelatorioBase
* Tabela principal: SigMlCab
* Filtro: SigMlItn (codigo/descricao)
*==============================================================================

DEFINE CLASS SIGREIPSBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cCodigos       = ""   && Codigo do item (SigMlItn.Codigos)
    this_cDescs         = ""   && Descricao do item (SigMlItn.Descs)

    *-- Cursor de dados do relatorio
    this_cCursorDados   = "cursor_4c_Relacao"

    *-- Identificacao
    this_cTabela        = "SigMlCab"
    this_cCampoChave    = "cIdChaves"
    this_cMensagemErro  = ""

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMlCab"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros e popula cursor do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cWhere = "1=1"
            IF !EMPTY(ALLTRIM(THIS.this_cCodigos))
                loc_cWhere = loc_cWhere + " AND Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))
            ENDIF

            loc_cSQL = "SELECT RClis, IClis, Endes, Nums, Compls, Bairs, Cidas, Ceps, Estas, " + ;
                       "Tel1s, Tel2s, Faxs, cIdChaves " + ;
                       "FROM SigMlCab " + ;
                       "WHERE " + loc_cWhere + " " + ;
                       "ORDER BY RClis, IClis, Endes, Nums, Compls, Bairs, Cidas, Ceps, " + ;
                       "Estas, Tel1s, Tel2s, Faxs, cIdChaves"

            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados para o relat" + CHR(243) + "rio"
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
    * Imprimir - Envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                IF RECCOUNT() = 0
                    MsgAviso("Nenhum registro encontrado para impress" + CHR(227) + "o.", "Aviso")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            REPORT FORM (gc_4c_CaminhoReports + "SigReIp3") TO PRINTER NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                IF RECCOUNT() = 0
                    MsgAviso("Nenhum registro encontrado para visualiza" + CHR(231) + CHR(227) + "o.", "Aviso")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            REPORT FORM (gc_4c_CaminhoReports + "SigReIp3") PREVIEW NOCONSOLE
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
    * ObterChavePrimaria - Retorna chave primaria do registro atual no cursor
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        IF USED(THIS.this_cCursorDados)
            SELECT (THIS.this_cCursorDados)
            IF !EOF()
                RETURN ALLTRIM(cIdChaves)
            ENDIF
        ENDIF
        RETURN ""
    ENDPROC

ENDDEFINE

