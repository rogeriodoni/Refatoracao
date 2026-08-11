# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 335: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 360: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 385: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 409: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormGps.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (997 linhas total):

*-- Linhas 111 a 119:
111:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
112: 
113:         *-- Caption dinamico baseado na operacao (Dopes vindo do form pai)
114:         THIS.Caption = "Grupos de Produtos " + ALLTRIM(THIS.this_cDopes)
115: 
116:         *-- Bloco superior escuro com titulo
117:         THIS.ConfigurarCabecalho()
118: 
119:         *-- Grade de edicao dos grupos (unico bloco de dados do dialogo)

*-- Linhas 135 a 183:
135:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
136:         loc_oCab = THIS.cnt_4c_Cabecalho
137:         WITH loc_oCab
138:             .Top        = 0
139:             .Left       = 0
140:             .Width      = THIS.Width
141:             .Height     = 80
142:             .BackStyle  = 1
143:             .BackColor  = RGB(100,100,100)
144:             .BorderWidth = 0
145:         ENDWITH
146: 
147:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
148:         WITH loc_oCab.lbl_4c_Sombra
149:             .Top        = 18
150:             .Left       = 10
151:             .Width      = 769
152:             .Height     = 40
153:             .AutoSize   = .F.
154:             .BackStyle  = 0
155:             .FontName   = "Tahoma"
156:             .FontSize   = 18
157:             .FontBold   = .T.
158:             .ForeColor  = RGB(0,0,0)
159:             .WordWrap   = .T.
160:             .Alignment  = 0
161:             .Caption    = THIS.Caption
162:         ENDWITH
163: 
164:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
165:         WITH loc_oCab.lbl_4c_Titulo
166:             .Top        = 17
167:             .Left       = 10
168:             .Width      = 769
169:             .Height     = 46
170:             .AutoSize   = .F.
171:             .BackStyle  = 0
172:             .FontName   = "Tahoma"
173:             .FontSize   = 18
174:             .FontBold   = .T.
175:             .ForeColor  = RGB(255,255,255)
176:             .WordWrap   = .T.
177:             .Alignment  = 0
178:             .Caption    = THIS.Caption
179:         ENDWITH
180:     ENDPROC
181: 
182:     *--------------------------------------------------------------------------
183:     * ConfigurarPaginaLista - Grid de grupos (GradeOpe no legado)

*-- Linhas 204 a 213:
204:         THIS.AddObject("grd_4c_Dados", "Grid")
205:         loc_oGrid = THIS.grd_4c_Dados
206:         WITH loc_oGrid
207:             .Top            = 87
208:             .Left           = 236
209:             .Width          = 264
210:             .Height         = 364
211:             .ColumnCount    = 2
212:             .FontName       = "Tahoma"
213:             .DeleteMark     = .F.

*-- Linhas 228 a 236:
228:                 .FontName   = "Tahoma"
229:                 .FontSize   = 8
230:                 .Alignment  = 2
231:                 .Caption    = "Grupo"
232:                 .ForeColor  = RGB(36,84,155)
233:             ENDWITH
234:         ENDWITH
235: 
236:         WITH loc_oGrid.Column2

*-- Linhas 243 a 267:
243:                 .FontName   = "Tahoma"
244:                 .FontSize   = 8
245:                 .Alignment  = 2
246:                 .Caption    = "Descri" + CHR(231) + CHR(227) + "o"
247:                 .ForeColor  = RGB(36,84,155)
248:             ENDWITH
249:         ENDWITH
250: 
251:         *-- Vincular grid ao cursor
252:         loc_oGrid.ColumnCount = 2
253:         loc_oGrid.RecordSource          = "cursor_4c_Operacao"
254:         loc_oGrid.Column1.ControlSource = "cursor_4c_Operacao.Cgrus"
255:         loc_oGrid.Column2.ControlSource = "cursor_4c_Operacao.Dgrus"
256: 
257:         *-- Reconfigurar headers apos RecordSource (VFP reseta headers)
258:         WITH loc_oGrid.Column1.Header1
259:             .Caption = "Grupo"
260:         ENDWITH
261:         WITH loc_oGrid.Column2.Header1
262:             .Caption = "Descri" + CHR(231) + CHR(227) + "o"
263:         ENDWITH
264: 
265:         *-- Bindar KeyPress da Column1 para lookup de Cgrus
266:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdDadosCol1KeyPress")
267:     ENDPROC

*-- Linhas 324 a 341:
324:         loc_lPermiteEdicao = INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
325: 
326:         *-- Inserir (Tab=4)
327:         THIS.AddObject("cmd_4c_Inserir", "CommandButton")
328:         WITH THIS.cmd_4c_Inserir
329:             .Top            = 2
330:             .Left           = 500
331:             .Width          = 75
332:             .Height         = 75
333:             .Caption        = "\<Inserir"
334:             .Picture        = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
335:             .FontName       = "Comic Sans MS"
336:             .FontBold       = .T.
337:             .FontItalic     = .T.
338:             .FontSize       = 8
339:             .ForeColor      = RGB(90,90,90)
340:             .BackColor      = RGB(255,255,255)
341:             .Themes         = .T.

*-- Linhas 349 a 366:
349:         ENDWITH
350: 
351:         *-- Excluir (Tab=2)
352:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
353:         WITH THIS.cmd_4c_Excluir
354:             .Top            = 2
355:             .Left           = 575
356:             .Width          = 75
357:             .Height         = 75
358:             .Caption        = "\<Excluir"
359:             .Picture        = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
360:             .FontName       = "Comic Sans MS"
361:             .FontBold       = .T.
362:             .FontItalic     = .T.
363:             .FontSize       = 8
364:             .ForeColor      = RGB(90,90,90)
365:             .BackColor      = RGB(255,255,255)
366:             .Themes         = .T.

*-- Linhas 374 a 391:
374:         ENDWITH
375: 
376:         *-- Confirmar / cmdSair no legado (Tab=7)
377:         THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
378:         WITH THIS.cmd_4c_Confirmar
379:             .Top            = 2
380:             .Left           = 650
381:             .Width          = 75
382:             .Height         = 75
383:             .Caption        = "\<Confirmar"
384:             .Picture        = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
385:             .FontName       = "Comic Sans MS"
386:             .FontBold       = .T.
387:             .FontItalic     = .T.
388:             .FontSize       = 8
389:             .ForeColor      = RGB(90,90,90)
390:             .BackColor      = RGB(255,255,255)
391:             .Themes         = .T.

*-- Linhas 398 a 415:
398:         ENDWITH
399: 
400:         *-- Cancelar / Cancela no legado (Tab=8, Cancel=.T.)
401:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
402:         WITH THIS.cmd_4c_Cancelar
403:             .Top            = 2
404:             .Left           = 725
405:             .Width          = 75
406:             .Height         = 75
407:             .Caption        = "Encerrar"
408:             .Picture        = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
409:             .FontName       = "Comic Sans MS"
410:             .FontBold       = .T.
411:             .FontItalic     = .T.
412:             .FontSize       = 8
413:             .ForeColor      = RGB(90,90,90)
414:             .BackColor      = RGB(255,255,255)
415:             .Themes         = .T.

*-- Linhas 423 a 434:
423:         ENDWITH
424: 
425:         *-- Bindar eventos dos botoes
426:         BINDEVENT(THIS.cmd_4c_Inserir,   "Click", THIS, "CmdInserirClick")
427:         BINDEVENT(THIS.cmd_4c_Excluir,   "Click", THIS, "CmdExcluirClick")
428:         BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "CmdConfirmarClick")
429:         BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")
430:     ENDPROC
431: 
432:     *--------------------------------------------------------------------------
433:     * CarregarDados - Carrega grupos do SQL Server no cursor de trabalho
434:     * Equivale ao SQLEXEC + Scan/Append Blank/Gather do legado

*-- Linhas 928 a 940:
928:         ELSE
929:             loc_lPermiteEdicao = INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
930:         ENDIF
931:         IF VARTYPE(THIS.cmd_4c_Inserir) = "O"
932:             THIS.cmd_4c_Inserir.Enabled = loc_lPermiteEdicao
933:         ENDIF
934:         IF VARTYPE(THIS.cmd_4c_Excluir) = "O"
935:             THIS.cmd_4c_Excluir.Enabled = loc_lPermiteEdicao
936:         ENDIF
937:     ENDPROC
938: 
939:     *--------------------------------------------------------------------------
940:     * LimparCampos - Zera o cursor de trabalho (limpa grade de grupos)


### BO (C:\4c\projeto\app\classes\GpsBO.prg):
*==============================================================================
* GpsBO.prg - Business Object para Grupos de Produtos (Sub-nivel)
* Tabelas: SigCdGgp (tipo GGP) / SigCdGps (tipo GPS)
* Gerado: Fase 1/8 - Propriedades e Init
*         Fase 2/8 - Metodos CRUD
*==============================================================================

DEFINE CLASS GpsBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da entidade
    *--------------------------------------------------------------------------

    *-- Identificacao da operacao (Dopes de SigCdOpe)
    this_cDopes     = ""

    *-- Codigo do grupo (Cgrus de SigCdGrp - char(3))
    this_cCgrus     = ""

    *-- Descricao do grupo (Dgrus de SigCdGrp - char(30))
    this_cDgrus     = ""

    *-- Controla qual tabela usar: .T.=SigCdGgp (GGP), .F.=SigCdGps (GPS)
    this_lTipoggp   = .F.

    *-- Modo de edicao recebido do form pai: 'INSERIR', 'ALTERAR', etc.
    this_cEscolha   = ""

    *-- Flag que indica se houve alteracao de dados no grid
    this_lGravaDados = .F.

    *--------------------------------------------------------------------------
    * Init - Configura tabela principal e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- Tabela padrao GGP; o form comuta para GPS via this_lTipoggp
        this_cTabela     = "SigCdGgp"
        this_cCampoChave = "pkchave"

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta (Dopes + Cgrus) para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes) + "|" + ALLTRIM(THIS.this_cCgrus)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor de trabalho nas propriedades do BO
    * par_cAliasCursor: nome do cursor (Dopes c(20), Cgrus c(3), Dgrus c(30))
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cDopes = TratarNulo(Dopes, "C")
                THIS.this_cCgrus = TratarNulo(Cgrus, "C")
                THIS.this_cDgrus = TratarNulo(Dgrus, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um unico registro de grupo no SQL Server
    * Usa: this_cDopes, this_cCgrus, this_lTipoggp
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cTabela, loc_cPkCampo, loc_cChave, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.this_lTipoggp
                loc_cTabela  = "SigCdGgp"
                loc_cPkCampo = "pkchave"
            ELSE
                loc_cTabela  = "SigCdGps"
                loc_cPkCampo = "cIdChaves"
            ENDIF

            loc_cChave = LOWER(SYS(2015) + SYS(2015))

            loc_cSQL = "INSERT INTO " + loc_cTabela + ;
                       " (Dopes, Cgrus, " + loc_cPkCampo + ") VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCgrus)) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir grupo.", "Erro em Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel: grupos sao gerenciados via SalvarGrupos (batch)
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui todos os grupos de uma operacao (Dopes)
    * Chamado internamente pelo ciclo de salvamento (SalvarGrupos)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_cTabela, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cTabela = IIF(THIS.this_lTipoggp, "SigCdGgp", "SigCdGps")
            loc_cSQL = "DELETE FROM " + loc_cTabela + ;
                       " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir grupos existentes.", "Erro em ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarGrupos - Carrega grupos do SQL Server em cursor temporario
    * par_cDopes   : Dopes da operacao (SigCdOpe)
    * par_lTipoggp : .T.=SigCdGgp (GGP), .F.=SigCdGps (GPS)
    * Resultado: cursor_4c_GruposTemp (Dopes c(20), Cgrus c(3), Dgrus c(30))
    *--------------------------------------------------------------------------
    FUNCTION CarregarGrupos(par_cDopes, par_lTipoggp)
        LOCAL loc_lSucesso, loc_cSQL, loc_cTabela, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF

            loc_cTabela = IIF(par_lTipoggp, "SigCdGgp", "SigCdGps")
            loc_cSQL = "SELECT a.Dopes, a.Cgrus, b.Dgrus " + ;
                       "FROM " + loc_cTabela + " a " + ;
                       "INNER JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                       "WHERE a.Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposTemp") > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar grupos da opera" + CHR(231) + CHR(227) + "o.", "Erro em CarregarGrupos")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarGrupos")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDuplicados - Verifica duplicidade de Cgrus no cursor de trabalho
    * par_cCursorOpe : Nome do cursor de trabalho (ex: "cursor_4c_Operacao")
    * Retorna .T. se valido (sem duplicatas), .F. se ha duplicatas
    *--------------------------------------------------------------------------
    FUNCTION ValidarDuplicados(par_cCursorOpe)
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .T.
        TRY
            IF USED(par_cCursorOpe) AND RECCOUNT(par_cCursorOpe) > 0
                IF USED("cursor_4c_DupVerif")
                    USE IN cursor_4c_DupVerif
                ENDIF

                SELECT Cgrus, SUM(1) AS Qt ;
                    FROM (par_cCursorOpe) ;
                    WHERE NOT EMPTY(ALLTRIM(Cgrus)) ;
                    GROUP BY Cgrus ;
                    HAVING SUM(1) > 1 ;
                    INTO CURSOR cursor_4c_DupVerif READWRITE

                IF USED("cursor_4c_DupVerif") AND RECCOUNT("cursor_4c_DupVerif") > 0
                    loc_lValido = .F.
                    MsgAviso("Existem lan" + CHR(231) + "amentos de Grupos Em Duplicidade!!!", "Valida" + CHR(231) + CHR(227) + "o")
                ENDIF

                IF USED("cursor_4c_DupVerif")
                    USE IN cursor_4c_DupVerif
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ValidarDuplicados")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarGrupos - Ciclo completo: exclui registros existentes e reinsere
    * par_cDopes     : Dopes da operacao identificando os grupos
    * par_lTipoggp   : .T.=SigCdGgp (GGP), .F.=SigCdGps (GPS)
    * par_cCursorOpe : Nome do cursor de trabalho com grupos editados pelo usuario
    * Retorna .T. se salvou com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION SalvarGrupos(par_cDopes, par_lTipoggp, par_cCursorOpe)
        LOCAL loc_lSucesso, loc_cSQL, loc_cTabela, loc_cPkCampo
        LOCAL loc_cChave, loc_cCgrus, loc_lTransAtiva, loc_lErroInsert, loc_oErro
        loc_lSucesso    = .F.
        loc_lTransAtiva = .F.
        loc_lErroInsert = .F.
        TRY
            loc_cTabela  = IIF(par_lTipoggp, "SigCdGgp", "SigCdGps")
            loc_cPkCampo = IIF(par_lTipoggp, "pkchave", "cIdChaves")

            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransAtiva = .T.

            loc_cSQL = "DELETE FROM " + loc_cTabela + ;
                       " WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0

                IF USED(par_cCursorOpe)
                    SELECT (par_cCursorOpe)
                    GO TOP
                    DO WHILE !EOF() AND !loc_lErroInsert
                        IF !DELETED()
                            loc_cCgrus = ALLTRIM(Cgrus)
                            IF !EMPTY(loc_cCgrus)
                                loc_cChave = LOWER(SYS(2015) + SYS(2015))
                                loc_cSQL = "INSERT INTO " + loc_cTabela + ;
                                           " (Dopes, Cgrus, " + loc_cPkCampo + ") VALUES (" + ;
                                           EscaparSQL(ALLTRIM(par_cDopes)) + ", " + ;
                                           EscaparSQL(loc_cCgrus) + ", " + ;
                                           EscaparSQL(loc_cChave) + ")"
                                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                    loc_lErroInsert = .T.
                                ENDIF
                            ENDIF
                        ENDIF
                        IF !loc_lErroInsert
                            SELECT (par_cCursorOpe)
                            SKIP
                        ENDIF
                    ENDDO
                ENDIF

                IF !loc_lErroInsert
                    IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") > 0
                        loc_lTransAtiva = .F.
                        THIS.this_cDopes    = ALLTRIM(par_cDopes)
                        THIS.this_lTipoggp  = par_lTipoggp
                        THIS.RegistrarAuditoria("A")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao confirmar transa" + CHR(231) + CHR(227) + "o.", "Erro em SalvarGrupos")
                    ENDIF
                ELSE
                    MsgErro("Erro ao inserir grupo " + loc_cCgrus + ".", "Erro em SalvarGrupos")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir grupos existentes.", "Erro em SalvarGrupos")
            ENDIF

            IF loc_lTransAtiva AND !loc_lSucesso
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                loc_lTransAtiva = .F.
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransAtiva
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em SalvarGrupos")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

