# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 314: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 338: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 362: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCOT.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (761 linhas total):

*-- Linhas 73 a 81:
73: 
74:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
75:                 *-- Caption dinamico com nome da moeda
76:                 THIS.Caption = "Cota" + CHR(231) + CHR(227) + "o do " + THIS.this_cMoes
77: 
78:                 *-- Layout do form (cabecalho + grid + botoes) - form OPERACIONAL
79:                 *-- nao usa PageFrame real, mas o metodo mantem o nome canonico
80:                 *-- para orquestrar toda a montagem de controles.
81:                 THIS.ConfigurarPageFrame()

*-- Linhas 158 a 223:
158: 
159:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
160:         WITH THIS.cnt_4c_Cabecalho
161:             .Top         = 0
162:             .Left        = 0
163:             .Width       = THIS.Width
164:             .Height      = 80
165:             .BackStyle   = 1
166:             .BackColor   = RGB(100, 100, 100)
167:             .BorderWidth = 0
168:             .Visible     = .T.
169: 
170:             *-- Sombra preta deslocada 1px para efeito 3D (lblSombra do legado)
171:             .AddObject("lbl_4c_Sombra", "Label")
172:             WITH .lbl_4c_Sombra
173:                 .AutoSize  = .F.
174:                 .Top       = 18
175:                 .Left      = 10
176:                 .Width     = THIS.Width
177:                 .Height    = 40
178:                 .BackStyle = 0
179:                 .FontBold  = .T.
180:                 .FontName  = "Tahoma"
181:                 .FontSize  = 18
182:                 .ForeColor = RGB(0, 0, 0)
183:                 .WordWrap  = .T.
184:                 .Alignment = 0
185:                 .Caption   = loc_cCaption
186:                 .Visible   = .T.
187:             ENDWITH
188: 
189:             *-- Titulo branco sobre cinza (lblTitulo do legado)
190:             .AddObject("lbl_4c_Titulo", "Label")
191:             WITH .lbl_4c_Titulo
192:                 .AutoSize  = .F.
193:                 .Top       = 17
194:                 .Left      = 10
195:                 .Width     = THIS.Width
196:                 .Height    = 46
197:                 .BackStyle = 0
198:                 .FontBold  = .T.
199:                 .FontName  = "Tahoma"
200:                 .FontSize  = 18
201:                 .ForeColor = RGB(255, 255, 255)
202:                 .WordWrap  = .T.
203:                 .Alignment = 0
204:                 .Caption   = loc_cCaption
205:                 .Visible   = .T.
206:             ENDWITH
207:         ENDWITH
208:     ENDPROC
209: 
210:     *===========================================================================
211:     * ConfigurarGrid - Cria grd_4c_Cotacoes com colunas, headers e BINDEVENTs
212:     * Colunas: data(Col1), hora(Col3/Order=2), cotacao(Col2/Order=3)
213:     *===========================================================================
214:     PROTECTED PROCEDURE ConfigurarGrid()
215:         THIS.AddObject("grd_4c_Cotacoes", "Grid")
216:         WITH THIS.grd_4c_Cotacoes
217:             .Top               = 85
218:             .Left              = 133
219:             .Width             = 270
220:             .Height            = 283
221:             .ColumnCount       = 3
222:             .FontName          = "Courier New"
223:             .FontSize          = 8

*-- Linhas 238 a 246:
238:                 .SelectOnEntry = .F.
239:                 .Format        = "K"
240:                 .ControlSource = "cursor_4c_Cotacoes.datas"
241:                 .Header1.Caption   = "Data"
242:                 .Header1.Alignment = 2
243:                 .Text1.FontName    = "Courier New"
244:                 .Text1.BorderStyle = 0
245:                 .Text1.Format      = "K"
246:                 .Text1.Margin      = 0

*-- Linhas 260 a 268:
260:                 .Format        = "K"
261:                 .InputMask     = "99999.9999999"
262:                 .ControlSource = "cursor_4c_Cotacoes.valos"
263:                 .Header1.Caption   = "Cota" + CHR(231) + CHR(227) + "o"
264:                 .Header1.Alignment = 2
265:                 .Text1.FontName    = "Courier New"
266:                 .Text1.BorderStyle = 0
267:                 .Text1.Format      = "K"
268:                 .Text1.Margin      = 0

*-- Linhas 280 a 288:
280:                 .ReadOnly      = .F.
281:                 .InputMask     = "99:99"
282:                 .ControlSource = "cursor_4c_Cotacoes.horas"
283:                 .Header1.Caption   = "Hora"
284:                 .Header1.Alignment = 2
285:                 .Text1.FontName    = "Courier New"
286:                 .Text1.BorderStyle = 0
287:                 .Text1.Margin      = 0
288:                 .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 300 a 388:
300:     ENDPROC
301: 
302:     *===========================================================================
303:     * ConfigurarBotoes - Cria cmd_4c_Inserir, cmd_4c_Excluir, cmd_4c_Encerrar
304:     * com BINDEVENT para os handlers de Click
305:     *===========================================================================
306:     PROTECTED PROCEDURE ConfigurarBotoes()
307:         *-- cmd_4c_Inserir (Left=312, TabIndex=1)
308:         THIS.AddObject("cmd_4c_Inserir", "CommandButton")
309:         WITH THIS.cmd_4c_Inserir
310:             .Top             = 3
311:             .Left            = 312
312:             .Width           = 75
313:             .Height          = 75
314:             .FontName        = "Comic Sans MS"
315:             .FontSize        = 8
316:             .FontBold        = .T.
317:             .FontItalic      = .T.
318:             .ForeColor       = RGB(90, 90, 90)
319:             .BackColor       = RGB(255, 255, 255)
320:             .Themes           = .T.
321:             .SpecialEffect   = 0
322:             .PicturePosition = 13
323:             .WordWrap        = .T.
324:             .MousePointer    = 15
325:             .Caption         = "Inserir"
326:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
327:             .TabIndex        = 1
328:             .Visible         = .T.
329:         ENDWITH
330: 
331:         *-- cmd_4c_Excluir (Left=387, TabIndex=2)
332:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
333:         WITH THIS.cmd_4c_Excluir
334:             .Top             = 3
335:             .Left            = 387
336:             .Width           = 75
337:             .Height          = 75
338:             .FontName        = "Comic Sans MS"
339:             .FontSize        = 8
340:             .FontBold        = .T.
341:             .FontItalic      = .T.
342:             .ForeColor       = RGB(90, 90, 90)
343:             .BackColor       = RGB(255, 255, 255)
344:             .Themes           = .T.
345:             .SpecialEffect   = 0
346:             .PicturePosition = 13
347:             .WordWrap        = .T.
348:             .MousePointer    = 15
349:             .Caption         = "Excluir"
350:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
351:             .TabIndex        = 2
352:             .Visible         = .T.
353:         ENDWITH
354: 
355:         *-- cmd_4c_Encerrar (Left=462, TabIndex=5, Cancel=.T. para ESC)
356:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
357:         WITH THIS.cmd_4c_Encerrar
358:             .Top             = 3
359:             .Left            = 462
360:             .Width           = 75
361:             .Height          = 75
362:             .FontName        = "Comic Sans MS"
363:             .FontSize        = 8
364:             .FontBold        = .T.
365:             .FontItalic      = .T.
366:             .ForeColor       = RGB(90, 90, 90)
367:             .BackColor       = RGB(255, 255, 255)
368:             .Themes           = .T.
369:             .SpecialEffect   = 0
370:             .PicturePosition = 13
371:             .WordWrap        = .T.
372:             .MousePointer    = 15
373:             .Cancel          = .T.
374:             .Caption         = "Encerrar"
375:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
376:             .TabIndex        = 5
377:             .Visible         = .T.
378:         ENDWITH
379: 
380:         *-- BINDEVENT dos botoes (metodos devem ser PUBLIC - sem PROTECTED)
381:         BINDEVENT(THIS.cmd_4c_Inserir,  "Click", THIS, "CmdInserirClick")
382:         BINDEVENT(THIS.cmd_4c_Excluir,  "Click", THIS, "CmdExcluirClick")
383:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
384:     ENDPROC
385: 
386:     *===========================================================================
387:     * CarregarCotacoes - Busca cotacoes da moeda e vincula ao grid
388:     *===========================================================================


### BO (C:\4c\projeto\app\classes\SIGPRCOTBO.prg):
*==============================================================================
* SIGPRCOTBO.prg - Business Object para Cotacoes de Moeda
* Tabela: SigCdCot
* PK: cidchaves
*==============================================================================
DEFINE CLASS SIGPRCOTBO AS BusinessBase

    *-- Campos da tabela SigCdCot
    this_cCmoes     = ""    && char(3)       - Codigo da moeda
    this_dDatas     = {}    && date          - Data da cotacao
    this_cHoras     = ""    && char(8)       - Hora da cotacao (HH:MM:SS)
    this_nValos     = 0     && numeric(11,6) - Valor da cotacao
    this_cCidChaves = ""    && char(20)      - Chave unica (PK)
    this_dDtAlts    = {}    && date          - Data de alteracao
    this_cUsuars    = ""    && char(10)      - Usuario que cadastrou

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdCot"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Substituto do fUniqueIds() do legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarChaveUnica()
        RETURN LEFT(SYS(2015) + SYS(2015), 20)
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCmoes     = TratarNulo(cmoes,     "C")
            THIS.this_dDatas     = TratarNulo(datas,     "D")
            THIS.this_cHoras     = TratarNulo(horas,     "C")
            THIS.this_nValos     = TratarNulo(valos,     "N")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_dDtAlts    = TratarNulo(dtalts,    "D")
            THIS.this_cUsuars    = TratarNulo(usuars,    "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cCmoes)
            MsgAviso("Informe o c" + CHR(243) + "digo da moeda.", "Aviso")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDatas)
            MsgAviso("Informe a data da cota" + CHR(231) + CHR(227) + "o.", "Aviso")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cHoras)
            MsgAviso("Informe a hora da cota" + CHR(231) + CHR(227) + "o.", "Aviso")
            RETURN .F.
        ENDIF
        IF THIS.this_nValos = 0
            MsgAviso("Informe o valor da cota" + CHR(231) + CHR(227) + "o.", "Aviso")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarInsercao - Override BusinessBase: INSERT com this_* properties
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarInsercao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = THIS.GerarChaveUnica()
            ENDIF
            THIS.this_dDtAlts = DATE()
            THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)

            loc_cSQL = "INSERT INTO SigCdCot " + ;
                       "(cmoes, datas, horas, valos, cidchaves, dtalts, usuars) " + ;
                       "VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCmoes))    + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas)         + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cHoras))    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValos)       + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtAlts)        + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cUsuars))   + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarAtualizacao - Override BusinessBase: UPDATE com this_* properties
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarAtualizacao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            THIS.this_dDtAlts = DATE()
            THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)

            loc_cSQL = "UPDATE SigCdCot SET " + ;
                       "datas  = " + FormatarDataSQL(THIS.this_dDatas)      + ", " + ;
                       "horas  = " + EscaparSQL(ALLTRIM(THIS.this_cHoras))  + ", " + ;
                       "valos  = " + FormatarNumeroSQL(THIS.this_nValos)    + ", " + ;
                       "dtalts = " + FormatarDataSQL(THIS.this_dDtAlts)     + ", " + ;
                       "usuars = " + EscaparSQL(ALLTRIM(THIS.this_cUsuars)) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Override BusinessBase: DELETE pela PK
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdCot WHERE cidchaves = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacoes - Carrega cotacoes de uma moeda no cursor de trabalho
    * Usa cursor temporario + ZAP/APPEND para nao destruir colunas do grid
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCotacoes(par_cMoes)
        LOCAL loc_lSucesso, loc_cSQL, loc_cMoesFmt
        loc_lSucesso = .F.
        TRY
            loc_cMoesFmt = EscaparSQL(ALLTRIM(par_cMoes))
            loc_cSQL = "SELECT cmoes, datas, horas, valos, cidchaves, dtalts, usuars " + ;
                       "FROM SigCdCot " + ;
                       "WHERE cmoes = " + loc_cMoesFmt + " " + ;
                       "ORDER BY datas, horas"

            IF USED("cursor_4c_CotacoesTemp")
                USE IN cursor_4c_CotacoesTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotacoesTemp") > 0
                IF USED("cursor_4c_Cotacoes")
                    *-- Cursor ja existe (grid bound): apenas limpar e recarregar
                    SELECT cursor_4c_Cotacoes
                    ZAP
                    APPEND FROM DBF("cursor_4c_CotacoesTemp")
                    GO BOTTOM
                ELSE
                    *-- Primeira carga: criar cursor com estrutura e indices
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Cotacoes ;
                        (cmoes C(3) NULL, datas D NULL, horas C(8) NULL, ;
                         valos N(11,6) NULL, cidchaves C(20) NULL, ;
                         dtalts D NULL, usuars C(10) NULL)
                    SET NULL OFF
                    INDEX ON ALLTRIM(cidchaves) TAG cidchaves
                    INDEX ON ALLTRIM(cmoes) + DTOS(datas) + ALLTRIM(horas) TAG cotacaos
                    APPEND FROM DBF("cursor_4c_CotacoesTemp")
                    GO BOTTOM
                ENDIF
                USE IN cursor_4c_CotacoesTemp
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar cota" + CHR(231) + CHR(245) + "es.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirNovaCotacao - Insere nova linha com data/hora atuais e valos=0
    * Replica inserir.Click do legado: persiste no SQL + adiciona ao cursor local
    * O usuario preenche o valor (valos) diretamente no grid apos a insercao
    *--------------------------------------------------------------------------
    PROCEDURE InserirNovaCotacao(par_cMoes)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_cMoesFmt
        LOCAL loc_cDtFmt, loc_cHora, loc_cDtAltFmt, loc_cUsuFmt
        loc_lSucesso = .F.
        TRY
            loc_cChave    = THIS.GerarChaveUnica()
            loc_cMoesFmt  = EscaparSQL(ALLTRIM(par_cMoes))
            loc_cDtFmt    = FormatarDataSQL(DATE())
            loc_cHora     = TIME()
            loc_cDtAltFmt = FormatarDataSQL(DATE())
            loc_cUsuFmt   = EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))

            *-- Inserir no SQL Server sem valos (usuario preenche no grid)
            loc_cSQL = "INSERT INTO SigCdCot " + ;
                       "(cmoes, datas, horas, cidchaves, dtalts, usuars) " + ;
                       "VALUES (" + ;
                       loc_cMoesFmt          + ", " + ;
                       loc_cDtFmt            + ", " + ;
                       EscaparSQL(loc_cHora) + ", " + ;
                       EscaparSQL(loc_cChave)+ ", " + ;
                       loc_cDtAltFmt         + ", " + ;
                       loc_cUsuFmt           + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                *-- Adicionar ao cursor de trabalho para exibicao imediata no grid
                IF USED("cursor_4c_Cotacoes")
                    SELECT cursor_4c_Cotacoes
                    SET ORDER TO
                    INSERT INTO cursor_4c_Cotacoes ;
                        (cmoes, datas, horas, valos, cidchaves, dtalts, usuars) ;
                        VALUES ;
                        (par_cMoes, DATE(), loc_cHora, 0, ;
                         loc_cChave, DATE(), ALLTRIM(gc_4c_UsuarioLogado))
                ENDIF
                THIS.this_cCidChaves = loc_cChave
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirCotacaoAtual - Exclui cotacao do SQL Server pelo cidchaves
    * Replica delete.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirCotacaoAtual(par_cCidChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChaveFmt
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cCidChaves)
                MsgAviso("Nenhum registro selecionado para exclus" + CHR(227) + "o.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            loc_cChaveFmt = EscaparSQL(ALLTRIM(par_cCidChaves))
            loc_cSQL = "DELETE FROM SigCdCot WHERE cidchaves = " + loc_cChaveFmt

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.this_cCidChaves = par_cCidChaves
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCotacaoDuplicada - Checa se ja existe cotacao para moeda+data+hora
    * Replica hora.Text1.Valid do legado
    * Retorna .T. se duplicata encontrada (excluindo o proprio registro atual)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCotacaoDuplicada(par_cMoes, par_dDatas, par_cHoras, par_cCidChavesAtual)
        LOCAL loc_lDuplicada
        loc_lDuplicada = .F.
        TRY
            IF USED("cursor_4c_Cotacoes")
                SELECT cursor_4c_Cotacoes
                SET ORDER TO cotacaos
                IF SEEK(ALLTRIM(par_cMoes) + DTOS(par_dDatas) + ALLTRIM(par_cHoras))
                    IF ALLTRIM(cidchaves) <> ALLTRIM(par_cCidChavesAtual)
                        loc_lDuplicada = .T.
                    ENDIF
                ENDIF
                SET ORDER TO
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lDuplicada
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarCotacoes - Persiste todas as alteracoes do cursor no SQL Server
    * Replica sair.Click do legado: remove invalidos e atualiza validos
    *--------------------------------------------------------------------------
    PROCEDURE SalvarCotacoes()
        LOCAL loc_lSucesso, loc_cSQL, loc_cChaveFmt, loc_cDtFmt, loc_cHoraFmt, loc_cValFmt
        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Cotacoes")
                loc_lSucesso = .F.
            ENDIF

            *-- Remover registros invalidos (sem data)
            SELECT cursor_4c_Cotacoes
            GO TOP
            SCAN
                IF EMPTY(cursor_4c_Cotacoes.datas)
                    IF !EMPTY(ALLTRIM(cursor_4c_Cotacoes.cidchaves))
                        loc_cChaveFmt = EscaparSQL(ALLTRIM(cursor_4c_Cotacoes.cidchaves))
                        loc_cSQL = "DELETE FROM SigCdCot WHERE cidchaves = " + loc_cChaveFmt
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ENDIF
                    DELETE
                ENDIF
                SELECT cursor_4c_Cotacoes
            ENDSCAN

            *-- Atualizar registros validos no SQL Server com valores editados no grid
            SELECT cursor_4c_Cotacoes
            GO TOP
            SCAN
                IF !DELETED() AND !EMPTY(ALLTRIM(cursor_4c_Cotacoes.cidchaves))
                    loc_cChaveFmt = EscaparSQL(ALLTRIM(cursor_4c_Cotacoes.cidchaves))
                    loc_cDtFmt    = FormatarDataSQL(cursor_4c_Cotacoes.datas)
                    loc_cHoraFmt  = EscaparSQL(ALLTRIM(cursor_4c_Cotacoes.horas))
                    loc_cValFmt   = FormatarNumeroSQL(cursor_4c_Cotacoes.valos)

                    loc_cSQL = "UPDATE SigCdCot SET " + ;
                               "datas = " + loc_cDtFmt   + ", " + ;
                               "horas = " + loc_cHoraFmt + ", " + ;
                               "valos = " + loc_cValFmt  + " " + ;
                               "WHERE cidchaves = " + loc_cChaveFmt

                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDIF
                SELECT cursor_4c_Cotacoes
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

