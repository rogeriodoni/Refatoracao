# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 386: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 409: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 433: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCOT.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (879 linhas total):

*-- Linhas 81 a 91:
81: 
82:             *-- Caption dinamico: "Cotacao do XXX"
83:             IF !EMPTY(THIS.this_cMoeda)
84:                 THIS.Caption = "Cota" + CHR(231) + CHR(227) + "o do " + THIS.this_cMoeda
85:             ELSE
86:                 THIS.Caption = "Cota" + CHR(231) + CHR(227) + "o"
87:             ENDIF
88: 
89:             *-- Configurar picture de fundo (new_background.jpg do Framework)
90:             THIS.ConfigurarPageFrame()
91: 

*-- Linhas 140 a 182:
140:         *-- Ocupa largura total do form (Width=537), Height=80
141:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
142:         WITH THIS.cnt_4c_Cabecalho
143:             .Top         = 0
144:             .Left        = 0
145:             .Width       = loc_nW
146:             .Height      = 80
147:             .BackStyle   = 1
148:             .BackColor   = RGB(100, 100, 100)
149:             .BorderWidth = 0
150: 
151:             *-- Label sombra: texto escuro deslocado 1px (efeito profundidade)
152:             .AddObject("lbl_4c_Sombra", "Label")
153:             WITH .lbl_4c_Sombra
154:                 .AutoSize  = .F.
155:                 .Width     = loc_nW
156:                 .Height    = 40
157:                 .Top       = 18
158:                 .Left      = 10
159:                 .Caption   = loc_cCaption
160:                 .FontName  = "Tahoma"
161:                 .FontSize  = 18
162:                 .FontBold  = .T.
163:                 .BackStyle = 0
164:                 .ForeColor = RGB(0, 0, 0)
165:                 .WordWrap  = .T.
166:                 .Alignment = 0
167:             ENDWITH
168: 
169:             *-- Label titulo: texto branco principal
170:             .AddObject("lbl_4c_Titulo", "Label")
171:             WITH .lbl_4c_Titulo
172:                 .AutoSize  = .F.
173:                 .Width     = loc_nW
174:                 .Height    = 46
175:                 .Top       = 17
176:                 .Left      = 10
177:                 .Caption   = loc_cCaption
178:                 .FontName  = "Tahoma"
179:                 .FontSize  = 18
180:                 .FontBold  = .T.
181:                 .BackStyle = 0
182:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 230 a 240:
230:                 THIS.grd_4c_Cotacoes.Column1.ControlSource   = "cursor_4c_Cotacoes.datas"
231:                 THIS.grd_4c_Cotacoes.Column2.ControlSource   = "cursor_4c_Cotacoes.horas"
232:                 THIS.grd_4c_Cotacoes.Column3.ControlSource   = "cursor_4c_Cotacoes.valos"
233:                 THIS.grd_4c_Cotacoes.Column1.Header1.Caption = "Data"
234:                 THIS.grd_4c_Cotacoes.Column2.Header1.Caption = "Hora"
235:                 THIS.grd_4c_Cotacoes.Column3.Header1.Caption = "Cota" + CHR(231) + CHR(227) + "o"
236:                 THIS.grd_4c_Cotacoes.Refresh()
237:             ENDIF
238:         ENDIF
239:         RETURN loc_lSucesso
240:     ENDPROC

*-- Linhas 281 a 296:
281:         ELSE
282:             loc_cCaption = "Cota" + CHR(231) + CHR(227) + "o"
283:         ENDIF
284:         THIS.Caption = loc_cCaption
285: 
286:         IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
287:             IF PEMSTATUS(THIS.cnt_4c_Cabecalho, "lbl_4c_Sombra", 5)
288:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cCaption
289:             ENDIF
290:             IF PEMSTATUS(THIS.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
291:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cCaption
292:             ENDIF
293:         ENDIF
294: 
295:         *-- Garantir que o grid de edicao (unico "campo" da area de dados)
296:         *-- esteja visivel e pronto para uso pelas fases seguintes.

*-- Linhas 304 a 313:
304:     *==========================================================================
305:         THIS.AddObject("grd_4c_Cotacoes", "Grid")
306:         WITH THIS.grd_4c_Cotacoes
307:             .Top               = 85
308:             .Left              = 133
309:             .Width             = 270
310:             .Height            = 283
311:             .ColumnCount       = 3
312:             .FontName          = "Courier New"
313:             .RecordMark        = .F.

*-- Linhas 326 a 358:
326:                 .Format        = "K"
327:                 WITH .Header1
328:                     .Alignment = 2
329:                     .Caption   = "Data"
330:                 ENDWITH
331:             ENDWITH
332: 
333:             WITH .Column2
334:                 .Width         = 55
335:                 .FontName      = "Courier New"
336:                 .Movable       = .F.
337:                 .Resizable     = .F.
338:                 .InputMask     = "99:99"
339:                 WITH .Header1
340:                     .Alignment = 2
341:                     .Caption   = "Hora"
342:                 ENDWITH
343:             ENDWITH
344: 
345:             WITH .Column3
346:                 .Width         = 101
347:                 .FontName      = "Courier New"
348:                 .Movable       = .F.
349:                 .Resizable     = .F.
350:                 .InputMask     = "99999.9999999"
351:                 WITH .Header1
352:                     .Alignment = 2
353:                     .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
354:                 ENDWITH
355:             ENDWITH
356:         ENDWITH
357: 
358:         BINDEVENT(THIS.grd_4c_Cotacoes, "AfterRowColChange", THIS, "GrdCotacoesAfterRowColChange")

*-- Linhas 373 a 449:
373:         LOCAL loc_cIcones
374:         loc_cIcones = gc_4c_CaminhoIcones
375: 
376:         THIS.AddObject("cmd_4c_Inserir", "CommandButton")
377:         WITH THIS.cmd_4c_Inserir
378:             .Top             = 3
379:             .Left            = 312
380:             .Width           = 75
381:             .Height          = 75
382:             .Caption         = "Inserir"
383:             .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
384:             .Themes          = .T.
385:             .DisabledPicture = loc_cIcones + "cadastro_inserir_60.jpg"
386:             .FontName        = "Comic Sans MS"
387:             .FontBold        = .T.
388:             .FontItalic      = .T.
389:             .FontSize        = 8
390:             .ForeColor       = RGB(90, 90, 90)
391:             .BackColor       = RGB(255, 255, 255)
392:             .PicturePosition = 13
393:             .WordWrap        = .T.
394:             .SpecialEffect   = 0
395:             .MousePointer    = 15
396:         ENDWITH
397:         BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "CmdInserirClick")
398: 
399:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
400:         WITH THIS.cmd_4c_Excluir
401:             .Top             = 3
402:             .Left            = 387
403:             .Width           = 75
404:             .Height          = 75
405:             .Caption         = "Excluir"
406:             .Picture         = loc_cIcones + "cadastro_excluir_60.jpg"
407:             .Themes          = .T.
408:             .DisabledPicture = loc_cIcones + "cadastro_excluir_60.jpg"
409:             .FontName        = "Comic Sans MS"
410:             .FontBold        = .T.
411:             .FontItalic      = .T.
412:             .FontSize        = 8
413:             .ForeColor       = RGB(90, 90, 90)
414:             .BackColor       = RGB(255, 255, 255)
415:             .PicturePosition = 13
416:             .WordWrap        = .T.
417:             .SpecialEffect   = 0
418:             .MousePointer    = 15
419:         ENDWITH
420:         BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "CmdExcluirClick")
421: 
422:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
423:         WITH THIS.cmd_4c_Encerrar
424:             .Top             = 3
425:             .Left            = 462
426:             .Width           = 75
427:             .Height          = 75
428:             .Caption         = "Encerrar"
429:             .Cancel          = .T.
430:             .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
431:             .Themes          = .T.
432:             .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
433:             .FontName        = "Comic Sans MS"
434:             .FontBold        = .T.
435:             .FontItalic      = .T.
436:             .FontSize        = 8
437:             .ForeColor       = RGB(90, 90, 90)
438:             .BackColor       = RGB(255, 255, 255)
439:             .PicturePosition = 13
440:             .WordWrap        = .T.
441:             .SpecialEffect   = 0
442:             .MousePointer    = 15
443:         ENDWITH
444:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
445:     ENDPROC
446: 
447:     *==========================================================================
448:     PROCEDURE CmdInserirClick
449:     *==========================================================================

*-- Linhas 816 a 825:
816:         IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
817:             THIS.grd_4c_Cotacoes.ReadOnly = !loc_lHabilitar
818:         ENDIF
819:         IF VARTYPE(THIS.cmd_4c_Inserir) = "O"
820:             THIS.cmd_4c_Inserir.Enabled = .T.
821:         ENDIF
822:     ENDPROC
823: 
824:     *==========================================================================
825:     * LimparCampos - Reseta estado transiente do popup (cancela insercao ativa)

*-- Linhas 844 a 863:
844:         loc_lEmInsercao   = (THIS.this_nIncluir > 0)
845: 
846:         *-- Inserir: disponivel sempre (permite adicionar nova cotacao)
847:         IF VARTYPE(THIS.cmd_4c_Inserir) = "O"
848:             THIS.cmd_4c_Inserir.Enabled = !loc_lEmInsercao
849:         ENDIF
850: 
851:         *-- Excluir: disponivel somente quando ha registros e nao ha insercao ativa
852:         IF VARTYPE(THIS.cmd_4c_Excluir) = "O"
853:             THIS.cmd_4c_Excluir.Enabled = loc_lTemRegistros AND !loc_lEmInsercao
854:         ENDIF
855: 
856:         *-- Encerrar: sempre disponivel (salva e fecha)
857:         IF VARTYPE(THIS.cmd_4c_Encerrar) = "O"
858:             THIS.cmd_4c_Encerrar.Enabled = .T.
859:         ENDIF
860:     ENDPROC
861: 
862:     *==========================================================================
863:     PROCEDURE Destroy


### BO (C:\4c\projeto\app\classes\SIGPRCOTBO.prg):
*==============================================================================
* SIGPRCOTBO.prg - Business Object para Cotacao de Moeda
* Tabela principal: SigCdCot
* Tipo: OPERACIONAL
* Migracao de: SIGPRCOT.SCX
*==============================================================================
SET RESOURCE OFF
SET SAFETY OFF

DEFINE CLASS SIGPRCOTBO AS BusinessBase

    *-- Campos de SigCdCot (schema: docs/schema.sql)
    this_cMoes      = ""   && char(3)       - codigo da moeda
    this_dDatas     = {}   && date NULL      - data da cotacao
    this_cHoras     = ""   && char(8)        - hora da cotacao
    this_nValos     = 0    && numeric(11,6)  - valor da cotacao
    this_cCidChaves = ""   && char(20)       - chave unica (PK)
    this_dDtAlts    = {}   && date NULL      - data da ultima alteracao
    this_cUsuars    = ""   && char(10)       - usuario que inseriu/alterou

    *-- Nome do cursor de trabalho (grid de cotacoes)
    this_cCursorCotacoes = "cursor_4c_Cotacoes"

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdCot"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cMoes      = TratarNulo(cmoes,     "C")
            THIS.this_dDatas     = TratarNulo(datas,     "D")
            THIS.this_cHoras     = TratarNulo(horas,     "C")
            THIS.this_nValos     = TratarNulo(valos,     "N")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_dDtAlts    = TratarNulo(dtalts,    "D")
            THIS.this_cUsuars    = TratarNulo(usuars,    "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de inserir/atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cMoes))
            THIS.this_cMensagem = "Informe o c" + CHR(243) + "digo da moeda."
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDatas)
            THIS.this_cMensagem = "Informe a data da cota" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF
        IF THIS.this_nValos <= 0
            THIS.this_cMensagem = "Informe o valor da cota" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera chave unica char(20) para cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarChaveUnica()
        RETURN LEFT(SYS(2015) + SYS(2015), 20)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCotacoes - Carrega cotacoes de uma moeda no cursor de trabalho
    * O cursor resultante (cursor_4c_Cotacoes) eh READWRITE para edicao no grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCotacoes(par_cMoeda)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorCotacoes)
                USE IN (THIS.this_cCursorCotacoes)
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Cotacoes ;
                (cmoes C(3) NULL, datas D NULL, horas C(8) NULL, ;
                 valos N(11,6) NULL, cidchaves C(20) NULL, ;
                 dtalts D NULL, usuars C(10) NULL)
            SET NULL OFF

            INDEX ON cidchaves                    TAG CidChaves
            INDEX ON cmoes + DTOS(datas) + horas  TAG Cotacaos

            loc_cSQL = "SELECT cmoes, CAST(datas AS date) AS datas, horas, valos, " + ;
                "cidchaves, CAST(dtalts AS date) AS dtalts, usuars " + ;
                "FROM SigCdCot " + ;
                "WHERE cmoes = " + EscaparSQL(par_cMoeda) + " " + ;
                "ORDER BY datas DESC, horas DESC"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotacoesTemp")

            IF loc_nRet > 0
                IF USED("cursor_4c_CotacoesTemp") AND RECCOUNT("cursor_4c_CotacoesTemp") > 0
                    SELECT cursor_4c_Cotacoes
                    APPEND FROM DBF("cursor_4c_CotacoesTemp")
                ENDIF
                IF USED("cursor_4c_CotacoesTemp")
                    USE IN cursor_4c_CotacoesTemp
                ENDIF

                SELECT cursor_4c_Cotacoes
                IF RECCOUNT() > 0
                    SET ORDER TO TAG Cotacaos
                    GO BOTTOM
                ENDIF
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                IF USED("cursor_4c_CotacoesTemp")
                    USE IN cursor_4c_CotacoesTemp
                ENDIF
                MsgErro("Erro ao carregar cota" + CHR(231) + CHR(245) + "es: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirNovaCotacao - Insere nova cotacao vazia para a moeda informada
    * Verifica duplicidade: somente insere se nao houver cotacao para hoje
    * Replica logica do botao "inserir" do legado (Click do SIGPRCOT.inserir)
    *--------------------------------------------------------------------------
    PROCEDURE InserirNovaCotacao(par_cMoeda)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_cCidChave, loc_dHoje, loc_cHoras
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        IF !USED(THIS.this_cCursorCotacoes)
            RETURN .F.
        ENDIF

        TRY
            loc_dHoje  = DATE()
            loc_cHoras = TIME()

            *-- Verificar duplicidade no cursor (cotacao para hoje ja existe?)
            *-- Usa LOCATE porque SET EXACT ON impede SEEK parcial em indice composto
            SELECT cursor_4c_Cotacoes
            LOCATE FOR ALLTRIM(cmoes) = ALLTRIM(par_cMoeda) AND datas = loc_dHoje
            IF FOUND()
                MsgAviso("J" + CHR(225) + " existe cota" + CHR(231) + CHR(227) + ;
                    "o cadastrada para hoje.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Gerar chave unica
                loc_cCidChave = THIS.GerarChaveUnica()

                *-- INSERT no SQL Server (valos=0 inicialmente; usuario edita no grid)
                loc_cSQL = "INSERT INTO SigCdCot " + ;
                    "(cmoes, datas, horas, valos, cidchaves, dtalts, usuars) " + ;
                    "VALUES (" + ;
                    EscaparSQL(ALLTRIM(par_cMoeda)) + ", " + ;
                    FormatarDataSQL(loc_dHoje) + ", " + ;
                    EscaparSQL(loc_cHoras) + ", " + ;
                    "0, " + ;
                    EscaparSQL(loc_cCidChave) + ", " + ;
                    FormatarDataSQL(loc_dHoje) + ", " + ;
                    EscaparSQL(gc_4c_UsuarioLogado) + ")"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet > 0
                    *-- Adicionar ao cursor de trabalho; APPEND BLANK deixa ponteiro no novo registro
                    SELECT cursor_4c_Cotacoes
                    SET ORDER TO
                    APPEND BLANK
                    REPLACE cmoes     WITH ALLTRIM(par_cMoeda)
                    REPLACE datas     WITH loc_dHoje
                    REPLACE horas     WITH loc_cHoras
                    REPLACE valos     WITH 0
                    REPLACE cidchaves WITH loc_cCidChave
                    REPLACE dtalts    WITH loc_dHoje
                    REPLACE usuars    WITH gc_4c_UsuarioLogado

                    THIS.this_cCidChaves = loc_cCidChave
                    THIS.RegistrarAuditoria("INSERIR")
                    loc_lSucesso = .T.
                ELSE
                    AERROR(loc_aErro)
                    MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o: " + ;
                        loc_aErro[2], "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirCotacaoAtual - Exclui cotacao pelo cidchaves do registro corrente
    * Replica logica do botao "delete" do legado
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirCotacaoAtual(par_cCidChave)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cCidChave))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigCdCot " + ;
                "WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidChave))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet > 0
                *-- Remover do cursor de trabalho
                IF USED(THIS.this_cCursorCotacoes)
                    SELECT cursor_4c_Cotacoes
                    LOCATE FOR ALLTRIM(cidchaves) = ALLTRIM(par_cCidChave)
                    IF FOUND()
                        DELETE
                        PACK
                        IF RECCOUNT() > 0
                            SET ORDER TO TAG Cotacaos
                            GO BOTTOM
                        ENDIF
                    ENDIF
                ENDIF

                THIS.this_cCidChaves = par_cCidChave
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                MsgErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAlteracoesCursor - Sincroniza cursor de cotacoes com SQL Server
    * Replica logica do botao "sair" do legado:
    * 1. Remove registros com data vazia ou valor zero/null
    * 2. Atualiza SigCdCot com os valores editados no cursor
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAlteracoesCursor()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cChave, loc_dDatas, loc_cHoras, loc_nValos
        loc_lSucesso = .F.

        IF !USED(THIS.this_cCursorCotacoes)
            RETURN .F.
        ENDIF

        TRY
            *-- Passo 1: Remover registros incompletos (data vazia ou valor <= 0)
            SELECT cursor_4c_Cotacoes
            SET ORDER TO
            GO TOP
            SCAN
                loc_cChave = ALLTRIM(cidchaves)
                IF EMPTY(datas) OR NVL(valos, 0) <= 0
                    IF !EMPTY(loc_cChave)
                        loc_cSQL = "DELETE FROM SigCdCot " + ;
                            "WHERE cidchaves = " + EscaparSQL(loc_cChave)
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ENDIF
                    SELECT cursor_4c_Cotacoes
                    DELETE
                ENDIF
                SELECT cursor_4c_Cotacoes
            ENDSCAN

            PACK

            *-- Passo 2: Atualizar SigCdCot com valores editados no cursor
            SELECT cursor_4c_Cotacoes
            GO TOP
            SCAN
                loc_cChave  = ALLTRIM(cidchaves)
                loc_dDatas  = datas
                loc_cHoras  = ALLTRIM(horas)
                loc_nValos  = valos

                IF !EMPTY(loc_cChave)
                    loc_cSQL = "UPDATE SigCdCot SET " + ;
                        "datas = " + FormatarDataSQL(loc_dDatas) + ", " + ;
                        "horas = " + EscaparSQL(loc_cHoras) + ", " + ;
                        "valos = " + FormatarNumeroSQL(loc_nValos, 6) + ", " + ;
                        "dtalts = GETDATE(), " + ;
                        "usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + " " + ;
                        "WHERE cidchaves = " + EscaparSQL(loc_cChave)
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

    *--------------------------------------------------------------------------
    * Inserir - Insere nova cotacao usando propriedades this_* do BO
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro, loc_cCidChave
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        IF !THIS.ValidarDados()
            MsgAviso(THIS.this_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            loc_cCidChave         = THIS.GerarChaveUnica()
            THIS.this_cCidChaves  = loc_cCidChave
            THIS.this_dDtAlts     = DATE()
            THIS.this_cUsuars     = gc_4c_UsuarioLogado

            IF EMPTY(ALLTRIM(THIS.this_cHoras))
                THIS.this_cHoras = TIME()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdCot " + ;
                "(cmoes, datas, horas, valos, cidchaves, dtalts, usuars) " + ;
                "VALUES (" + ;
                EscaparSQL(THIS.this_cMoes) + ", " + ;
                FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                EscaparSQL(THIS.this_cHoras) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValos, 6) + ", " + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                FormatarDataSQL(THIS.this_dDtAlts) + ", " + ;
                EscaparSQL(THIS.this_cUsuars) + ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza cotacao existente usando propriedades this_* do BO
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        IF !THIS.ValidarDados()
            MsgAviso(THIS.this_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_dDtAlts = DATE()
            THIS.this_cUsuars = gc_4c_UsuarioLogado

            loc_cSQL = "UPDATE SigCdCot SET " + ;
                "datas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                "horas = " + EscaparSQL(THIS.this_cHoras) + ", " + ;
                "valos = " + FormatarNumeroSQL(THIS.this_nValos, 6) + ", " + ;
                "dtalts = " + FormatarDataSQL(THIS.this_dDtAlts) + ", " + ;
                "usuars = " + EscaparSQL(THIS.this_cUsuars) + " " + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet > 0
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                MsgErro("Erro ao atualizar cota" + CHR(231) + CHR(227) + "o: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui cotacao de SigCdCot (chamado por Excluir() do BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCot " + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                MsgErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao em LogAuditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, Chave, Usuario, DataHora) VALUES (" + ;
                EscaparSQL("SigCdCot") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
        ENDTRY
    ENDPROC

ENDDEFINE

