# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Cabecalho' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReAac.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1190 linhas total):

*-- Linhas 51 a 59:
51:         loc_lSucesso   = .F.
52:         loc_lContinuar = .T.
53:         TRY
54:             THIS.Caption = "Relat" + CHR(243) + "rio do Log de Acessos"
55: 
56:             IF TYPE("gc_4c_CaminhoIcones") = "U"
57:                 gc_4c_CaminhoIcones = ""
58:             ENDIF
59:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 80 a 89:
80:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
81: 
82:                 THIS.LimparCampos()
83:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
84:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
85:                 THIS.Visible = .T.
86:                 loc_lSucesso = .T.
87:             ENDIF
88:         CATCH TO loc_oErro
89:             THIS.this_cMensagemErro = loc_oErro.Message

*-- Linhas 102 a 140:
102:     PROTECTED PROCEDURE ConfigurarCabecalho()
103:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
104:         WITH THIS.cnt_4c_Cabecalho
105:             .Top         = 0
106:             .Left        = 0
107:             .Width       = THIS.Width
108:             .Height      = 80
109:             .BackStyle   = 1
110:             .BackColor   = RGB(100, 100, 100)
111:             .BorderWidth = 0
112:             .Visible     = .T.
113: 
114:             .AddObject("lbl_4c_Sombra", "Label")
115:             WITH .lbl_4c_Sombra
116:                 .Top       = 22
117:                 .Left      = 22
118:                 .Width     = THIS.Width
119:                 .Height    = 30
120:                 .Caption   = "Relat" + CHR(243) + "rio do Log de Acessos"
121:                 .FontName  = "Tahoma"
122:                 .FontSize  = 14
123:                 .FontBold  = .T.
124:                 .ForeColor = RGB(0, 0, 0)
125:                 .BackStyle = 0
126:                 .Visible   = .T.
127:             ENDWITH
128: 
129:             .AddObject("lbl_4c_Titulo", "Label")
130:             WITH .lbl_4c_Titulo
131:                 .Top       = 20
132:                 .Left      = 20
133:                 .Width     = THIS.Width
134:                 .Height    = 30
135:                 .Caption   = "Relat" + CHR(243) + "rio do Log de Acessos"
136:                 .FontName  = "Tahoma"
137:                 .FontSize  = 14
138:                 .FontBold  = .T.
139:                 .ForeColor = RGB(255, 255, 255)
140:                 .BackStyle = 0

*-- Linhas 152 a 177:
152:     PROTECTED PROCEDURE ConfigurarBotoes()
153:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
154:         WITH THIS.cmg_4c_Botoes
155:             .Top           = 0
156:             .Left          = 529
157:             .Width         = 273
158:             .Height        = 80
159:             .ButtonCount   = 4
160:             .BackStyle     = 0
161:             .BorderStyle   = 0
162:             .BorderColor   = RGB(136, 189, 188)
163:             .SpecialEffect = 1
164:             .Themes        = .F.
165:             .Visible       = .T.
166: 
167:             WITH .Buttons(1)
168:                 .Top             = 5
169:                 .Left            = 5
170:                 .Width           = 65
171:                 .Height          = 70
172:                 .Caption         = "Visualizar"
173:                 .FontBold        = .T.
174:                 .FontItalic      = .T.
175:                 .BackColor       = RGB(255, 255, 255)
176:                 .ForeColor       = RGB(90, 90, 90)
177:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 184 a 196:
184:             ENDWITH
185: 
186:             WITH .Buttons(2)
187:                 .Top             = 5
188:                 .Left            = 71
189:                 .Width           = 65
190:                 .Height          = 70
191:                 .Caption         = "Imprimir"
192:                 .FontName        = "Tahoma"
193:                 .FontBold        = .T.
194:                 .FontItalic      = .T.
195:                 .FontSize        = 8
196:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 205 a 217:
205:             ENDWITH
206: 
207:             WITH .Buttons(3)
208:                 .Top             = 5
209:                 .Left            = 137
210:                 .Width           = 65
211:                 .Height          = 70
212:                 .Caption         = "Excel"
213:                 .FontName        = "Tahoma"
214:                 .FontBold        = .T.
215:                 .FontItalic      = .T.
216:                 .FontSize        = 8
217:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 226 a 238:
226:             ENDWITH
227: 
228:             WITH .Buttons(4)
229:                 .Top             = 5
230:                 .Left            = 203
231:                 .Width           = 65
232:                 .Height          = 70
233:                 .Caption         = "Encerrar"
234:                 .Cancel          = .T.
235:                 .FontName        = "Tahoma"
236:                 .FontBold        = .T.
237:                 .FontItalic      = .T.
238:                 .FontSize        = 8

*-- Linhas 262 a 276:
262:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
263:         loc_oPgf.PageCount = 1
264: 
265:         loc_oPgf.Top    = 85
266:         loc_oPgf.Left   = -1
267:         loc_oPgf.Width  = THIS.Width + 2
268:         loc_oPgf.Height = THIS.Height - 85
269:         loc_oPgf.Tabs   = .F.
270: 
271:         loc_oPgf.Page1.Caption   = "Filtros"
272:         loc_oPgf.Page1.FontName  = "Tahoma"
273:         loc_oPgf.Page1.FontSize  = 8
274:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
275:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
276:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 287 a 324:
287:     *   - Bloco USUARIO : Codigo + Nome do usuario  (este metodo)
288:     *   - Bloco GRUPO   : Codigo + Nome do grupo    (ConfigurarPaginaDados)
289:     *
290:     * Posicoes ajustadas relativas ao PageFrame.Top=85:
291:     *   Linha Usuario : Top_original=86 -> Page1.Top=1
292:     *   Label Usuario : Top_original=90 -> Page1.Top=5
293:     *--------------------------------------------------------------------------
294:     PROTECTED PROCEDURE ConfigurarPaginaLista()
295:         LOCAL loc_oPg
296:         loc_oPg = THIS.pgf_4c_Paginas.Page1
297: 
298:         *-- Label "Usuario :"
299:         loc_oPg.AddObject("lbl_4c_LblUsuario", "Label")
300:         WITH loc_oPg.lbl_4c_LblUsuario
301:             .Top       = 5
302:             .Left      = 57
303:             .Width     = 45
304:             .Height    = 15
305:             .Caption   = "Usu" + CHR(225) + "rio :"
306:             .FontName  = "Tahoma"
307:             .FontSize  = 8
308:             .FontBold  = .F.
309:             .ForeColor = RGB(90, 90, 90)
310:             .BackStyle = 0
311:             .AutoSize  = .T.
312:             .Visible   = .T.
313:         ENDWITH
314: 
315:         *-- Codigo do Usuario (SigCdUsu.Usuarios, MaxLength=10)
316:         loc_oPg.AddObject("txt_4c_CUsuario", "TextBox")
317:         WITH loc_oPg.txt_4c_CUsuario
318:             .Top         = 1
319:             .Left        = 105
320:             .Width       = 80
321:             .Height      = 25
322:             .MaxLength   = 10
323:             .Value       = ""
324:             .FontName    = "Tahoma"

*-- Linhas 332 a 341:
332:         *-- Nome do Usuario (SigCdUsu.NComps, MaxLength=30)
333:         loc_oPg.AddObject("txt_4c_DUsuario", "TextBox")
334:         WITH loc_oPg.txt_4c_DUsuario
335:             .Top         = 1
336:             .Left        = 187
337:             .Width       = 301
338:             .Height      = 25
339:             .MaxLength   = 30
340:             .Value       = ""
341:             .FontName    = "Tahoma"

*-- Linhas 362 a 399:
362:     * separamos a montagem em dois metodos para manter o contrato esperado
363:     * pelo pipeline de migracao (ConfigurarPaginaLista + ConfigurarPaginaDados).
364:     *
365:     * Posicoes ajustadas relativas ao PageFrame.Top=85:
366:     *   Linha Grupo : Top_original=113 -> Page1.Top=28
367:     *   Label Grupo : Top_original=117 -> Page1.Top=32
368:     *--------------------------------------------------------------------------
369:     PROTECTED PROCEDURE ConfigurarPaginaDados()
370:         LOCAL loc_oPg
371:         loc_oPg = THIS.pgf_4c_Paginas.Page1
372: 
373:         *-- Label "Grupo :"
374:         loc_oPg.AddObject("lbl_4c_LblGrupo", "Label")
375:         WITH loc_oPg.lbl_4c_LblGrupo
376:             .Top       = 32
377:             .Left      = 64
378:             .Width     = 38
379:             .Height    = 15
380:             .Caption   = "Grupo :"
381:             .FontName  = "Tahoma"
382:             .FontSize  = 8
383:             .FontBold  = .F.
384:             .ForeColor = RGB(90, 90, 90)
385:             .BackStyle = 0
386:             .AutoSize  = .T.
387:             .Visible   = .T.
388:         ENDWITH
389: 
390:         *-- Codigo do Grupo (SigCdGrA.Grupos, MaxLength=10)
391:         loc_oPg.AddObject("txt_4c_CGrupo", "TextBox")
392:         WITH loc_oPg.txt_4c_CGrupo
393:             .Top         = 28
394:             .Left        = 105
395:             .Width       = 80
396:             .Height      = 25
397:             .MaxLength   = 10
398:             .Value       = ""
399:             .FontName    = "Tahoma"

*-- Linhas 407 a 416:
407:         *-- Nome do Grupo (SigCdGrA.NComps, MaxLength=30)
408:         loc_oPg.AddObject("txt_4c_DGrupo", "TextBox")
409:         WITH loc_oPg.txt_4c_DGrupo
410:             .Top         = 28
411:             .Left        = 187
412:             .Width       = 301
413:             .Height      = 25
414:             .MaxLength   = 30
415:             .Value       = ""
416:             .FontName    = "Tahoma"


### BO (C:\4c\projeto\app\classes\SigReAacBO.prg):
*==============================================================================
* SIGREAACBO.PRG
* Business Object para Relatorio do Log de Acessos
* Herda de RelatorioBase
*
* Tabelas: SigOpLog (dados), SigCdEmp (cabecalho),
*          SigCdUsu (lookup usuario), SigCdGrA (lookup grupo)
* Filtros: Codigo/Nome do Usuario OU Codigo/Nome do Grupo
*==============================================================================

DEFINE CLASS SigReAacBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cCUsuario          = ""
    this_cDUsuario          = ""
    this_cCGrupo            = ""
    this_cDGrupo            = ""

    *-- Cursores utilizados
    this_cCursorDados       = "cursor_4c_Dados"
    this_cCursorCabecalho   = "cursor_4c_Cabecalho"

    *-- Configuracao do relatorio
    this_cFRXPath           = ""
    this_cTituloRel         = ""
    this_cSubTitulo         = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF DODEFAULT()
                THIS.this_cFRXPath   = gc_4c_CaminhoReports + "RelSigReAac.frx"
                THIS.this_cTituloRel = "Relat" + CHR(243) + "rio do Log de Acessos"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursores de cabecalho e dados para o relatorio
    *
    * Logica original (processamento):
    *   1. Valida pelo menos um filtro ativo (grupo OU usuario)
    *   2. Obtem razao social da empresa em SigCdEmp
    *   3. Cria cursor de cabecalho com titulo/subtitulo/empresa
    *   4. Filtro GRUPO: SigOpLog WHERE Transacaos LIKE grupo
    *      AND Progs IN ('CADGRU','CADUSU')
    *   5. Filtro USUARIO: SigOpLog WHERE Transacaos LIKE usuario
    *      AND Progs IN ('CADUSU','CADGRU'), depois enriquece cursor com
    *      registros de grupo associados ao usuario que ainda nao constam
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_lContinuar
        LOCAL loc_cEmpDesc, loc_nRegs, loc_nI, loc_cGrupo, loc_nRec
        LOCAL loc_cCUsuarioEsc, loc_cCGrupoEsc, loc_cGrupoEsc
        loc_lSucesso  = .F.
        loc_lContinuar = .T.
        TRY
            *-- Validar: pelo menos um filtro obrigatorio
            IF EMPTY(THIS.this_cCGrupo) AND EMPTY(THIS.this_cCUsuario)
                THIS.this_cMensagemErro = "Sele" + CHR(231) + CHR(227) + ;
                                          "o n" + CHR(227) + "o Realizada !!!"
                loc_lContinuar = .F.
            ENDIF

            *-- Obter razao social da empresa
            IF loc_lContinuar
                loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE cEmps = " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpRaz")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao obter dados da empresa"
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Montar descricao da empresa para o cabecalho
            IF loc_lContinuar
                IF USED("cursor_4c_EmpRaz") AND RECCOUNT("cursor_4c_EmpRaz") > 0
                    SELECT cursor_4c_EmpRaz
                    loc_cEmpDesc = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + ALLTRIM(Razas)
                ELSE
                    loc_cEmpDesc = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                ENDIF
                IF USED("cursor_4c_EmpRaz")
                    USE IN cursor_4c_EmpRaz
                ENDIF
            ENDIF

            *-- Recriar cursor de cabecalho
            IF loc_lContinuar
                IF USED(THIS.this_cCursorCabecalho)
                    USE IN (THIS.this_cCursorCabecalho)
                ENDIF
                CREATE CURSOR cursor_4c_Cabecalho (cTitulos C(80), cSubTitulos C(80), Empresa C(80))
                SELECT cursor_4c_Cabecalho
                APPEND BLANK
                REPLACE Empresa WITH loc_cEmpDesc
            ENDIF

            *-- FILTRO POR GRUPO
            IF loc_lContinuar AND !EMPTY(THIS.this_cCGrupo)
                SELECT cursor_4c_Cabecalho
                REPLACE cTitulos WITH "RELATORIO DO LOG DE ALTERA" + ;
                                      CHR(199) + CHR(195) + "O GRUPOS DE ACESSOS"
                REPLACE cSubTitulos WITH "Grupo : " + ;
                                         ALLTRIM(THIS.this_cCGrupo) + " - " + ;
                                         ALLTRIM(THIS.this_cDGrupo)

                IF USED(THIS.this_cCursorDados)
                    USE IN (THIS.this_cCursorDados)
                ENDIF

                loc_cCGrupoEsc = STRTRAN(ALLTRIM(THIS.this_cCGrupo), "'", "''")
                loc_cSQL = "SELECT * FROM SigOpLog" + ;
                           " WHERE Transacaos LIKE '%" + loc_cCGrupoEsc + "%'" + ;
                           " AND (Progs = 'CADGRU' OR Progs = 'CADUSU')" + ;
                           " ORDER BY Datars"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar dados do log por grupo"
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- FILTRO POR USUARIO
            IF loc_lContinuar AND !EMPTY(THIS.this_cCUsuario)
                SELECT cursor_4c_Cabecalho
                REPLACE cTitulos WITH "RELATORIO DO LOG DE ALTERA" + ;
                                      CHR(199) + CHR(195) + "O DE ACESSOS DE USUARIOS"
                REPLACE cSubTitulos WITH "Usu" + CHR(225) + "rio : " + ;
                                         ALLTRIM(THIS.this_cCUsuario) + " - " + ;
                                         ALLTRIM(THIS.this_cDUsuario)

                IF USED(THIS.this_cCursorDados)
                    USE IN (THIS.this_cCursorDados)
                ENDIF

                loc_cCUsuarioEsc = STRTRAN(ALLTRIM(THIS.this_cCUsuario), "'", "''")
                loc_cSQL = "SELECT * FROM SigOpLog" + ;
                           " WHERE Transacaos LIKE '%" + loc_cCUsuarioEsc + "%'" + ;
                           " AND (Progs = 'CADUSU' OR Progs = 'CADGRU')" + ;
                           " ORDER BY Datars"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar dados do log por usu" + CHR(225) + "rio"
                    loc_lContinuar = .F.
                ENDIF

                *-- Enriquecer: para cada registro que referencia GRUPO,
                *   buscar registros de grupo nao presentes no cursor principal
                IF loc_lContinuar
                    SELECT cursor_4c_Dados
                    GO TOP
                    loc_nRegs = RECCOUNT()
                    loc_nI = 0
                    DO WHILE loc_nI < loc_nRegs
                        loc_nI = loc_nI + 1
                        SELECT cursor_4c_Dados
                        GO loc_nI
                        IF AT('GRUPO : ', UPPER(Transacaos)) > 0
                            loc_cGrupo    = ALLTRIM(SUBSTR(Transacaos, 9, 10))
                            loc_cGrupoEsc = STRTRAN(loc_cGrupo, "'", "''")
                            loc_cSQL = "SELECT * FROM SigOpLog" + ;
                                       " WHERE Transacaos LIKE '%" + loc_cGrupoEsc + "%'" + ;
                                       " AND Transacaos LIKE '%PROG :%'" + ;
                                       " AND Progs = 'CADGRU'" + ;
                                       " ORDER BY Datars"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruAux")
                            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruAux") > 0
                                SELECT * FROM cursor_4c_GruAux ;
                                    WHERE cIdChaves NOT IN ;
                                        (SELECT cIdChaves FROM cursor_4c_Dados) ;
                                    INTO CURSOR cursor_4c_Ins
                                IF RECCOUNT("cursor_4c_Ins") > 0
                                    loc_nRec = RECNO("cursor_4c_Dados")
                                    SELECT cursor_4c_Dados
                                    APPEND FROM DBF("cursor_4c_Ins")
                                    SELECT cursor_4c_Dados
                                    GO loc_nI
                                ENDIF
                                IF USED("cursor_4c_Ins")
                                    USE IN cursor_4c_Ins
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_GruAux")
                                USE IN cursor_4c_GruAux
                            ENDIF
                        ENDIF
                    ENDDO
                ENDIF
            ENDIF

            *-- Posicionar no inicio dos dados
            IF loc_lContinuar
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora (com dialogo de selecao)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) NOCONSOLE TO PRINTER PROMPT
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
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
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) NOCONSOLE PREVIEW
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Exporta relatorio para arquivo Excel
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel()
        LOCAL loc_lSucesso, loc_cArquivo
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = FORCEPATH("RelLogAcessos_" + ;
                               TRANSFORM(DATE(), "@YMD") + ".xls", ;
                               SYS(5) + CURDIR())
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    COPY TO (loc_cArquivo) TYPE XL5
                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo exportado:" + CHR(13) + loc_cArquivo, "Excel")
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Cursor de dados n" + CHR(227) + ;
                                              "o dispon" + CHR(237) + "vel"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ExportarExcel")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores dos filtros a partir de um cursor
    *
    * Permite recuperar uma configuracao de filtros previamente salva (por
    * exemplo, um conjunto de filtros pre-definidos exibidos em historico de
    * relatorios). Mapeia colunas do cursor para as propriedades de filtro
    * deste BO.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                                      "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF
        TRY
            SELECT (par_cAliasCursor)
            IF !EOF() AND !BOF()
                IF TYPE("CUsuario") = "C"
                    THIS.this_cCUsuario = ALLTRIM(NVL(EVALUATE("CUsuario"), ""))
                ENDIF
                IF TYPE("DUsuario") = "C"
                    THIS.this_cDUsuario = ALLTRIM(NVL(EVALUATE("DUsuario"), ""))
                ENDIF
                IF TYPE("CGrupo") = "C"
                    THIS.this_cCGrupo = ALLTRIM(NVL(EVALUATE("CGrupo"), ""))
                ENDIF
                IF TYPE("DGrupo") = "C"
                    THIS.this_cDGrupo = ALLTRIM(NVL(EVALUATE("DGrupo"), ""))
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de filtros est" + CHR(225) + " vazio"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva. Caso seja invocado indevidamente pelo Form, o
    * chamador recebera feedback claro.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de inser" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir(), Visualizar() ou " + ;
                                  "ExportarExcel()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "Inserir")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva. Caso seja invocado indevidamente pelo Form, o
    * chamador recebera feedback claro.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de atualiza" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir(), Visualizar() ou " + ;
                                  "ExportarExcel()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "Atualizar")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificacao da configuracao atual
    *
    * Como nao ha registro persistido, retorna concatenacao dos filtros
    * atualmente carregados (usado para auditoria/log de execucoes do
    * relatorio).
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF !EMPTY(THIS.this_cCGrupo)
            loc_cChave = "GRUPO=" + ALLTRIM(THIS.this_cCGrupo)
        ENDIF
        IF !EMPTY(THIS.this_cCUsuario)
            IF !EMPTY(loc_cChave)
                loc_cChave = loc_cChave + "|"
            ENDIF
            loc_cChave = loc_cChave + "USUARIO=" + ALLTRIM(THIS.this_cCUsuario)
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio em LogAuditoria
    *
    * Reaproveita a estrutura padrao de auditoria do sistema para gravar
    * eventos de impressao/visualizacao do relatorio, possibilitando
    * rastreabilidade de quem consultou o Log de Acessos e com quais filtros.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_nResult, loc_cChave, loc_cUsuario, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF
            IF EMPTY(loc_cUsuario)
                loc_cUsuario = "SISTEMA"
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Operacao, Tabela, ChavePrimaria, Observacao) " + ;
                       "VALUES (" + ;
                       FormatarDataSQL(DATETIME()) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL(NVL(par_cOperacao, "RELATORIO")) + ", " + ;
                       EscaparSQL("SigOpLog") + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL("Relat" + CHR(243) + "rio do Log de Acessos") + ;
                       ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_EmpRaz")
            USE IN cursor_4c_EmpRaz
        ENDIF
        IF USED("cursor_4c_GruAux")
            USE IN cursor_4c_GruAux
        ENDIF
        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

