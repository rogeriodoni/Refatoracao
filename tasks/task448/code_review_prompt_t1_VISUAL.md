# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormICN.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (819 linhas total):

*-- Linhas 57 a 72:
57:                 IF EMPTY(loc_cCaption)
58:                     loc_cCaption = CHR(205) + "cones de Acesso"
59:                 ENDIF
60:                 THIS.Caption = loc_cCaption
61: 
62:                 *-- Compor layout (flat OPERACIONAL, sem PageFrame CRUD)
63:                 THIS.ConfigurarPageFrame()
64: 
65:                 *-- Ecoar Caption nas labels do cabecalho (apos ConfigurarPageFrame)
66:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
67:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
68: 
69:                 *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
70:                 THIS.TornarControlesVisiveis()
71: 
72:                 *-- Carregar dados do banco (apenas com conexao real)

*-- Linhas 148 a 208:
148:     *==========================================================================
149:     PROTECTED PROCEDURE ConfigurarCabecalho()
150:     *==========================================================================
151:     * Cria cnt_4c_Cabecalho com lbl_4c_Sombra (sombra preta) e lbl_4c_Titulo
152:     * (texto branco) - replica cntSombra/lblSombra/lblTitulo do legado
153:     *==========================================================================
154:         LOCAL loc_oCab
155:         TRY
156:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
157:             loc_oCab = THIS.cnt_4c_Cabecalho
158:             WITH loc_oCab
159:                 .Top         = 0
160:                 .Left        = 0
161:                 .Width       = THIS.Width
162:                 .Height      = 80
163:                 .BackStyle   = 1
164:                 .BackColor   = RGB(100, 100, 100)
165:                 .BorderWidth = 0
166:                 .Visible     = .T.
167:             ENDWITH
168: 
169:             loc_oCab.AddObject("lbl_4c_Sombra", "Label")
170:             WITH loc_oCab.lbl_4c_Sombra
171:                 .AutoSize   = .F.
172:                 .Top        = 18
173:                 .Left       = 10
174:                 .Width      = loc_oCab.Width - 20
175:                 .Height     = 40
176:                 .FontBold   = .T.
177:                 .FontName   = "Tahoma"
178:                 .FontSize   = 18
179:                 .FontItalic = .F.
180:                 .WordWrap   = .T.
181:                 .Alignment  = 0
182:                 .BackStyle  = 0
183:                 .ForeColor  = RGB(0, 0, 0)
184:                 .Caption    = ""
185:                 .Visible    = .T.
186:             ENDWITH
187: 
188:             loc_oCab.AddObject("lbl_4c_Titulo", "Label")
189:             WITH loc_oCab.lbl_4c_Titulo
190:                 .AutoSize   = .F.
191:                 .Top        = 17
192:                 .Left       = 10
193:                 .Width      = loc_oCab.Width - 20
194:                 .Height     = 46
195:                 .FontBold   = .T.
196:                 .FontName   = "Tahoma"
197:                 .FontSize   = 18
198:                 .FontItalic = .F.
199:                 .WordWrap   = .T.
200:                 .Alignment  = 0
201:                 .BackStyle  = 0
202:                 .ForeColor  = RGB(255, 255, 255)
203:                 .Caption    = ""
204:                 .Visible    = .T.
205:             ENDWITH
206:         CATCH TO loc_oErro
207:             MsgErro(loc_oErro.Message + CHR(13) + ;
208:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 223 a 232:
223:             THIS.AddObject("grd_4c_Dados", "Grid")
224:             loc_oGrid = THIS.grd_4c_Dados
225:             WITH loc_oGrid
226:                 .Top               = 114
227:                 .Left              = 30
228:                 .Width             = 941
229:                 .Height            = 432
230:                 .ColumnCount       = 2
231:                 .FontName          = "Tahoma"
232:                 .FontSize          = 8

*-- Linhas 250 a 258:
250:                 .ReadOnly  = .T.
251:             ENDWITH
252:             WITH loc_oGrid.Column1.Header1
253:                 .Caption   = "Programa"
254:                 .FontName  = "Arial"
255:                 .FontSize  = 8
256:                 .Alignment = 2
257:                 .ForeColor = RGB(90, 90, 90)
258:             ENDWITH

*-- Linhas 276 a 284:
276:                 .ReadOnly  = .T.
277:             ENDWITH
278:             WITH loc_oGrid.Column2.Header1
279:                 .Caption   = CHR(205) + "cone"
280:                 .FontName  = "Arial"
281:                 .FontSize  = 8
282:                 .Alignment = 0
283:                 .ForeColor = RGB(90, 90, 90)
284:             ENDWITH

*-- Linhas 326 a 344:
326:                 .BorderStyle  = 0
327:                 .SpecialEffect = 1
328:                 .Height       = 85
329:                 .Left         = 833
330:                 .Top          = 0
331:                 .Width        = 160
332:             ENDWITH
333: 
334:             WITH loc_oCmg.Buttons(1)
335:                 .Top         = 5
336:                 .Left        = 5
337:                 .Height      = 75
338:                 .Width       = 75
339:                 .Caption     = "\<Ok"
340:                 .ToolTipText = "Confirmar"
341:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
342:                 .FontBold    = .T.
343:                 .FontItalic  = .T.
344:                 .FontName    = "Tahoma"

*-- Linhas 350 a 362:
350:             ENDWITH
351: 
352:             WITH loc_oCmg.Buttons(2)
353:                 .Top         = 5
354:                 .Left        = 80
355:                 .Height      = 75
356:                 .Width       = 75
357:                 .Caption     = "Encerrar"
358:                 .ToolTipText = "[ESC] Cancelar"
359:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
360:                 .Cancel      = .T.
361:                 .FontBold    = .T.
362:                 .FontItalic  = .T.

*-- Linhas 397 a 406:
397:                     .RecordSource             = loc_cCursor
398:                     .Column1.ControlSource    = loc_cCursor + ".descricaos"
399:                     .Column2.ControlSource    = loc_cCursor + ".barrapict"
400:                     .Column1.Header1.Caption  = "Programa"
401:                     .Column2.Header1.Caption  = CHR(205) + "cone"
402:                     .Visible                  = .T.
403:                     .Refresh()
404:                 ENDWITH
405:             ENDIF
406:         CATCH TO loc_oErro


### BO (C:\4c\projeto\app\classes\ICNBO.prg):
*==============================================================================
* ICNBO.prg - Business Object para Icones de Acesso (sigcdprg)
* Form OPERACIONAL: gerencia atribuicao de icones aos programas do sistema
* Herda de: BusinessBase
* Tabela: sigcdprg | PK: pkchaves
*==============================================================================
DEFINE CLASS ICNBO AS BusinessBase

    *-- Configuracao da tabela
    this_cTabela     = "sigcdprg"
    this_cCampoChave = "pkchaves"

    *-- Cursores utilizados pelo form
    this_cCursorProg         = "cursor_4c_Prog"
    this_cCursorProgFiltrado = "cursor_4c_ProgFiltrado"
    this_cCursorIcones       = "cursor_4c_Icones"

    *-- Diretorio temporario para arquivos .ico extraidos de SigSyIco.marqicones
    this_cDirTmp = ""

    *-- Indica se as alteracoes foram confirmadas pelo usuario
    this_lSalvo = .F.

    *-- Propriedades do registro corrente (CarregarDoCursor / ObterChavePrimaria)
    this_cDescricaos = ""
    this_cProgramas  = ""
    this_cBarrapict  = ""
    this_cBarraforms = ""
    this_cParametros = ""
    this_cPkChaves   = ""

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ICNBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE InicializarDados()
    *==========================================================================
    * Carrega programas e icones do banco para os cursores de trabalho
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.CarregarProgramas()
                loc_lSucesso = THIS.CarregarIcones()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarProgramas()
    *==========================================================================
    * Busca sigcdprg e cria cursor_4c_Prog (todos) e cursor_4c_ProgFiltrado
    * (apenas registros com descricaos preenchida, exibido no Grid)
    *==========================================================================
        LOCAL loc_cSQL, loc_lSucesso, loc_nRet, loc_cCursorSrc, loc_cCursorDst
        loc_lSucesso  = .F.
        loc_cCursorSrc = THIS.this_cCursorProg
        loc_cCursorDst = THIS.this_cCursorProgFiltrado
        TRY
            IF USED(THIS.this_cCursorProg)
                USE IN (THIS.this_cCursorProg)
            ENDIF
            IF USED(THIS.this_cCursorProgFiltrado)
                USE IN (THIS.this_cCursorProgFiltrado)
            ENDIF

            loc_cSQL = "SELECT a.descricaos, a.programas, a.barrapict, " + ;
                       "a.barraforms, a.pkChaves " + ;
                       "FROM sigcdprg a " + ;
                       "ORDER BY a.descricaos"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProg)

            IF loc_nRet > 0 AND USED(THIS.this_cCursorProg)
                SELECT (THIS.this_cCursorProg)
                INDEX ON pkChaves TAG pkChaves
                REPLACE ALL barrapict WITH LOWER(ALLTRIM(JUSTFNAME(barrapict)))
                SET ORDER TO ""
                GO TOP

                SELECT a.descricaos, a.programas, a.barrapict, a.barraforms, a.pkChaves ;
                    FROM (loc_cCursorSrc) a ;
                    WHERE NOT EMPTY(a.descricaos) ;
                    ORDER BY a.descricaos ;
                    INTO CURSOR (loc_cCursorDst) READWRITE
                INDEX ON pkChaves TAG pkChaves
                SET ORDER TO ""
                GO TOP

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lista de programas do sistema.", ;
                        "Erro em CarregarProgramas")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarProgramas")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarIcones()
    *==========================================================================
    * Busca SigSyIco e extrai cada icone para arquivo .ico em diretorio temp
    *==========================================================================
        LOCAL loc_cSQL, loc_lSucesso, loc_nRet, loc_cArqIcone, loc_nTamIcone
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorIcones)
                USE IN (THIS.this_cCursorIcones)
            ENDIF

            THIS.this_cDirTmp = ADDBS(SYS(2023))

            loc_cSQL = "SELECT a.carqicones, a.marqicones, " + ;
                       "SPACE(255) AS ctmpicones " + ;
                       "FROM SigSyIco a " + ;
                       "ORDER BY a.carqicones"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorIcones)

            IF loc_nRet > 0 AND USED(THIS.this_cCursorIcones)
                SELECT (THIS.this_cCursorIcones)
                INDEX ON carqicones TAG carqicones
                SET ORDER TO ""
                GO TOP

                IF NOT EOF(THIS.this_cCursorIcones)
                    INSERT INTO (THIS.this_cCursorIcones) (carqicones) VALUES (' < Nenhum >')
                ENDIF
                GO TOP IN (THIS.this_cCursorIcones)

                SELECT (THIS.this_cCursorIcones)
                SCAN
                    IF NOT EMPTY(ALLTRIM(carqicones))
                        loc_cArqIcone  = THIS.this_cDirTmp + "ArqIcone" + SYS(2015) + ".ico"
                        loc_nTamIcone = STRTOFILE(marqicones, loc_cArqIcone)
                        IF loc_nTamIcone > 0
                            REPLACE ctmpicones WITH loc_cArqIcone IN (THIS.this_cCursorIcones)
                        ENDIF
                    ENDIF
                ENDSCAN

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lista de " + CHR(237) + "cones do sistema.", ;
                        "Erro em CarregarIcones")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarIcones")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE SalvarAlteracoes()
    *==========================================================================
    * Persiste todas as alteracoes de icones em sigcdprg (UPDATE em massa)
    * Itera por todos os registros de cursor_4c_Prog e chama THIS.Atualizar()
    * para cada linha, dentro de uma transacao unica
    *==========================================================================
        LOCAL loc_lSucesso, loc_lTransacaoAberta, loc_lErroScan
        loc_lSucesso         = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroScan        = .F.
        TRY
            IF NOT USED(THIS.this_cCursorProg)
                MsgErro("Cursor de programas n" + CHR(227) + "o inicializado.", ;
                        "Erro em SalvarAlteracoes")
            ELSE
                SQLSETPROP(gnConnHandle, "Transactions", 2)
                loc_lTransacaoAberta = .T.

                SELECT (THIS.this_cCursorProg)
                SET ORDER TO ""
                GO TOP

                SCAN
                    IF NOT THIS.CarregarDoCursor(THIS.this_cCursorProg)
                        loc_lErroScan = .T.
                        EXIT
                    ENDIF
                    IF NOT THIS.Atualizar()
                        loc_lErroScan = .T.
                        MsgErro("Erro ao salvar programa " + ALLTRIM(THIS.this_cDescricaos) + ;
                                " (chave: " + ALLTRIM(THIS.this_cPkChaves) + ")" + CHR(13) + ;
                                THIS.this_cMensagemErro, ;
                                "Erro em SalvarAlteracoes")
                        EXIT
                    ENDIF
                ENDSCAN

                IF loc_lErroScan
                    SQLTRANSACT(gnConnHandle, "ROLLBACK")
                ELSE
                    SQLTRANSACT(gnConnHandle, "COMMIT")
                    THIS.this_lSalvo = .T.
                    loc_lSucesso = .T.
                ENDIF
                SQLSETPROP(gnConnHandle, "Transactions", 1)
                loc_lTransacaoAberta = .F.
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLTRANSACT(gnConnHandle, "ROLLBACK")
                SQLSETPROP(gnConnHandle, "Transactions", 1)
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SalvarAlteracoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
    * INSERT em sigcdprg com propriedades correntes (this_cPkChaves,
    * this_cDescricaos, this_cProgramas, this_cBarrapict, this_cBarraforms,
    * this_cParametros). Todas as colunas da tabela sao NOT NULL char.
    *==========================================================================
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria " + ;
                    "(pkChaves) obrigat" + CHR(243) + "ria para inserir."
            ELSE
                loc_cSQL = "INSERT INTO sigcdprg " + ;
                           "(barraforms, barrapict, descricaos, parametros, programas, pkchaves) " + ;
                           "VALUES (" + ;
                           EscaparSQL(ALLTRIM(THIS.this_cBarraforms)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cBarrapict))  + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDescricaos)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cParametros)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cProgramas))  + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cPkChaves))   + ")"
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet > 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao inserir registro em sigcdprg."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ICNBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
    * UPDATE em sigcdprg (barrapict, barraforms) filtrado por pkChaves.
    * Usado individualmente pelo form (SalvarAlteracoes itera cursor e chama)
    *==========================================================================
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria " + ;
                    "(pkChaves) obrigat" + CHR(243) + "ria para atualizar."
            ELSE
                loc_cSQL = "UPDATE sigcdprg SET " + ;
                           "barrapict = "  + EscaparSQL(ALLTRIM(THIS.this_cBarrapict))  + ", " + ;
                           "barraforms = " + EscaparSQL(ALLTRIM(THIS.this_cBarraforms)) + " " + ;
                           "WHERE pkchaves = " + EscaparSQL(ALLTRIM(THIS.this_cPkChaves))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet > 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao atualizar registro em sigcdprg."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ICNBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
    * Carrega propriedades do BO a partir do registro corrente de um cursor
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cDescricaos = TratarNulo(descricaos, "C")
                THIS.this_cProgramas  = TratarNulo(programas,  "C")
                THIS.this_cBarrapict  = TratarNulo(barrapict,  "C")
                THIS.this_cBarraforms = TratarNulo(barraforms,  "C")
                THIS.this_cPkChaves   = TratarNulo(pkChaves,   "C")
                IF TYPE(par_cAliasCursor + ".parametros") == "C"
                    THIS.this_cParametros = TratarNulo(EVALUATE(par_cAliasCursor + ".parametros"), "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE LimparArquivosTemp()
    *==========================================================================
    * Remove arquivos .ico temporarios criados durante o carregamento de icones
    *==========================================================================
        LOCAL loc_cArqIcone
        TRY
            IF USED(THIS.this_cCursorIcones)
                SELECT (THIS.this_cCursorIcones)
                SET ORDER TO ""
                GO TOP
                SCAN
                    loc_cArqIcone = ALLTRIM(ctmpicones)
                    IF NOT EMPTY(loc_cArqIcone) AND FILE(loc_cArqIcone)
                        DELETE FILE (loc_cArqIcone)
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em LimparArquivosTemp")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        TRY
            THIS.LimparArquivosTemp()
            IF USED(THIS.this_cCursorIcones)
                USE IN (THIS.this_cCursorIcones)
            ENDIF
            IF USED(THIS.this_cCursorProgFiltrado)
                USE IN (THIS.this_cCursorProgFiltrado)
            ENDIF
            IF USED(THIS.this_cCursorProg)
                USE IN (THIS.this_cCursorProg)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ICNBO.Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE

