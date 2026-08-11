# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 151: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 180: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 198: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormGr1.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1029 linhas total):

*-- Linhas 49 a 60:
49:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
50:                         "Erro")
51:             ELSE
52:                 THIS.Caption = "Gera" + CHR(231) + CHR(227) + "o de Grupos"
53:                 THIS.ConfigurarPageFrame()
54:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
55:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
56:                 THIS.TornarControlesVisiveis(THIS)
57:                 loc_lSucesso = .T.
58:             ENDIF
59: 
60:         CATCH TO loc_oErro

*-- Linhas 85 a 204:
85:         *-- Container de fundo cinza escuro (cntSombra do legado)
86:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
87:         WITH THIS.cnt_4c_Cabecalho
88:             .Top         = 0
89:             .Left        = 0
90:             .Width       = THIS.Width
91:             .Height      = 80
92:             .BackColor   = RGB(100, 100, 100)
93:             .BackStyle   = 1
94:             .BorderWidth = 0
95:             .Visible     = .T.
96:         ENDWITH
97: 
98:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
99:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
100:             .Top       = 18
101:             .Left      = 10
102:             .Width     = 769
103:             .Height    = 40
104:             .AutoSize  = .F.
105:             .BackStyle = 0
106:             .WordWrap  = .T.
107:             .Alignment = 0
108:             .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Grupos"
109:             .FontName  = "Tahoma"
110:             .FontSize  = 18
111:             .FontBold  = .T.
112:             .ForeColor = RGB(0, 0, 0)
113:         ENDWITH
114: 
115:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
116:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
117:             .Top       = 17
118:             .Left      = 10
119:             .Width     = 769
120:             .Height    = 46
121:             .AutoSize  = .F.
122:             .BackStyle = 0
123:             .WordWrap  = .T.
124:             .Alignment = 0
125:             .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Grupos"
126:             .FontName  = "Tahoma"
127:             .FontSize  = 18
128:             .FontBold  = .T.
129:             .ForeColor = RGB(255, 255, 255)
130:         ENDWITH
131: 
132:         *-- CommandGroup "Remove" (1 botao - remove acesso selecionado da lista)
133:         *-- Posicionado diretamente no form sobre o cabecalho (z-order superior)
134:         THIS.AddObject("cmg_4c_Remove", "CommandGroup")
135:         WITH THIS.cmg_4c_Remove
136:             .Top         = 0
137:             .Left        = 750
138:             .Width       = 85
139:             .Height      = 80
140:             .ButtonCount = 1
141:             .BackStyle   = 0
142:             .BorderStyle = 0
143:             .Value       = 0
144: 
145:             WITH .Buttons(1)
146:                 .Top        = 5
147:                 .Left       = 5
148:                 .Width      = 75
149:                 .Height     = 75
150:                 .Caption    = "\<Remove"
151:                 .FontName        = "Comic Sans MS"
152:                 .FontSize        = 8
153:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
154:                 .FontBold   = .T.
155:                 .FontItalic = .T.
156:                 .ForeColor  = RGB(90, 90, 90)
157:                 .BackColor  = RGB(255, 255, 255)
158:                 .Themes     = .F.
159:             ENDWITH
160:         ENDWITH
161: 
162:         *-- CommandGroup principal: Salvar + Sair
163:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
164:         WITH THIS.cmg_4c_Botoes
165:             .Top         = 0
166:             .Left        = 840
167:             .Width       = 160
168:             .Height      = 80
169:             .ButtonCount = 2
170:             .BackStyle   = 0
171:             .BorderStyle = 0
172:             .Value       = 1
173: 
174:             WITH .Buttons(1)
175:                 .Top        = 5
176:                 .Left       = 5
177:                 .Width      = 75
178:                 .Height     = 75
179:                 .Caption    = "\<Salvar"
180:                 .FontName        = "Comic Sans MS"
181:                 .FontSize        = 8
182:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
183:                 .FontBold   = .T.
184:                 .FontItalic = .T.
185:                 .ForeColor  = RGB(90, 90, 90)
186:                 .BackColor  = RGB(255, 255, 255)
187:                 .Themes     = .F.
188:             ENDWITH
189: 
190:             WITH .Buttons(2)
191:                 .Top        = 5
192:                 .Left       = 80
193:                 .Width      = 75
194:                 .Height     = 75
195:                 .Caption    = "<Esc>Sair"
196:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
197:                 .Cancel     = .T.
198:                 .FontName   = "Comic Sans MS"
199:                 .FontSize   = 8
200:                 .FontBold   = .T.
201:                 .FontItalic = .T.
202:                 .ForeColor  = RGB(90, 90, 90)
203:                 .BackColor  = RGB(255, 255, 255)
204:                 .Themes     = .F.

*-- Linhas 252 a 302:
252:         *-- Shape borda da area de dados (Shape1 do legado)
253:         THIS.AddObject("shp_4c_Area", "Shape")
254:         WITH THIS.shp_4c_Area
255:             .Top           = 83
256:             .Left          = 3
257:             .Width         = 960
258:             .Height        = 507
259:             .BackStyle     = 0
260:             .SpecialEffect = 0
261:         ENDWITH
262: 
263:         *-- Label "Usu CHR(225) rio :" (Label1 do legado)
264:         THIS.AddObject("lbl_4c_Label1", "Label")
265:         WITH THIS.lbl_4c_Label1
266:             .Top       = 91
267:             .Left      = 23
268:             .Width     = 62
269:             .Height    = 16
270:             .AutoSize  = .F.
271:             .Caption   = "Usu" + CHR(225) + "rio :"
272:             .FontName  = "Tahoma"
273:             .FontSize  = 8
274:             .FontBold  = .T.
275:             .BackStyle = 0
276:             .ForeColor = RGB(90, 90, 90)
277:         ENDWITH
278: 
279:         *-- TextBox codigo do usuario (GetCodigo do legado)
280:         THIS.AddObject("txt_4c_Codigo", "TextBox")
281:         WITH THIS.txt_4c_Codigo
282:             .Top       = 89
283:             .Left      = 76
284:             .Width     = 80
285:             .Height    = 22
286:             .MaxLength = 10
287:             .Value     = ""
288:             .FontName  = "Tahoma"
289:             .FontSize  = 8
290:             .ForeColor = RGB(90, 90, 90)
291:         ENDWITH
292: 
293:         *-- TextBox nome do usuario (GetDescri do legado)
294:         THIS.AddObject("txt_4c_Descri", "TextBox")
295:         WITH THIS.txt_4c_Descri
296:             .Top       = 89
297:             .Left      = 157
298:             .Width     = 248
299:             .Height    = 22
300:             .MaxLength = 30
301:             .Value     = ""
302:             .FontName  = "Tahoma"

*-- Linhas 308 a 317:
308:         THIS.AddObject("grd_4c_Dados", "Grid")
309:         loc_oGrid = THIS.grd_4c_Dados
310:         WITH loc_oGrid
311:             .Top                = 118
312:             .Left               = 9
313:             .Width              = 950
314:             .Height             = 472
315:             .ColumnCount        = 1
316:             .DeleteMark         = .F.
317:             .RecordMark         = .F.

*-- Linhas 340 a 348:
340:         loc_oGrid.Column1.ControlSource     = "cursor_4c_Acessos.Descricaos"
341: 
342:         *-- Header1: fora do WITH aninhado para evitar silently-ignored props
343:         loc_oGrid.Column1.Header1.Caption   = "Acessos"
344:         loc_oGrid.Column1.Header1.FontName  = "Tahoma"
345:         loc_oGrid.Column1.Header1.Alignment = 2
346:         loc_oGrid.Column1.Header1.ForeColor = RGB(90, 90, 90)
347: 
348:         *-- Text1 (celula de dados): Courier New conforme legado

*-- Linhas 371 a 398:
371:     *--------------------------------------------------------------------------
372:     PROTECTED PROCEDURE ConfigurarPaginaDados()
373:         *-- Label "Novo Grupo :" (Label2 do legado)
374:         THIS.AddObject("lbl_4c_Label2", "Label")
375:         WITH THIS.lbl_4c_Label2
376:             .Top       = 91
377:             .Left      = 484
378:             .Width     = 88
379:             .Height    = 16
380:             .AutoSize  = .F.
381:             .Caption   = "Novo Grupo :"
382:             .FontName  = "Tahoma"
383:             .FontSize  = 8
384:             .FontBold  = .T.
385:             .BackStyle = 0
386:             .ForeColor = RGB(90, 90, 90)
387:         ENDWITH
388: 
389:         *-- TextBox novo grupo (GetGrupo do legado)
390:         THIS.AddObject("txt_4c_Grupo", "TextBox")
391:         WITH THIS.txt_4c_Grupo
392:             .Top       = 89
393:             .Left      = 510
394:             .Width     = 102
395:             .Height    = 23
396:             .MaxLength = 10
397:             .Value     = ""
398:             .FontName  = "Tahoma"

*-- Linhas 432 a 440:
432:                 THIS.grd_4c_Dados.ColumnCount  = 1
433:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Acessos"
434:                 THIS.grd_4c_Dados.Column1.ControlSource        = "cursor_4c_Acessos.Descricaos"
435:                 THIS.grd_4c_Dados.Column1.Header1.Caption      = "Acessos"
436:                 THIS.grd_4c_Dados.Column1.Header1.FontName     = "Tahoma"
437:                 THIS.grd_4c_Dados.Column1.Header1.Alignment    = 2
438:                 THIS.grd_4c_Dados.Column1.Header1.ForeColor    = RGB(90, 90, 90)
439:                 THIS.grd_4c_Dados.Refresh()
440:             ENDIF


### BO (C:\4c\projeto\app\classes\Gr1BO.prg):
*==============================================================================
* Gr1BO.prg - Business Object: Geracao de Grupos de Acesso
* Tabela principal: SigCdGrA (grupos)
* Tabelas auxiliares: SigCdAcU (acessos por usuario), SigCdAcB (acessos do grupo)
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS Gr1BO AS BusinessBase

    this_cTabela          = "SigCdGrA"
    this_cCampoChave      = "Grupos"

    *-- Dados do usuario selecionado (SigCdUsu)
    this_cUsuarios        = ""
    this_cNComps          = ""

    *-- Dados do novo grupo a criar (SigCdGrA)
    this_cGrupos          = ""
    this_cGrupoNComps     = ""

    *-- Cursores de trabalho
    this_cCursorAcessos   = "cursor_4c_Acessos"
    this_cCursorBarra     = "cursor_4c_Barra"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdGrA"
        THIS.this_cCampoChave = "Grupos"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cGrupos)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos      = TratarNulo(Grupos, "C")
            THIS.this_cGrupoNComps = TratarNulo(nComps, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de gravar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cGrupos))
            MsgAviso("Informe o c" + CHR(243) + "digo do grupo.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cGrupoNComps))
            MsgAviso("Informe o nome do grupo.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigCdGrA
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "INSERT INTO SigCdGrA (Grupos, nComps) VALUES (" + ;
                           EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cGrupoNComps)) + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("I")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir grupo no banco de dados.", ;
                            "Erro de Inser" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro em SigCdGrA
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "UPDATE SigCdGrA SET nComps = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cGrupoNComps)) + ;
                           " WHERE Grupos = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cGrupos))

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("U")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar grupo no banco de dados.", ;
                            "Erro de Atualiza" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove registro de SigCdGrA
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdGrA WHERE Grupos = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrupos))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("D")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir grupo.", ;
                        "Erro de Exclus" + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarAcessosPorUsuario - Carrega cursor_4c_Acessos para o grid
    * Equivale ao Valid de GetCodigo/GetDescri no legado
    *--------------------------------------------------------------------------
    FUNCTION BuscarAcessosPorUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuarios
        LOCAL loc_cProgram, loc_cParam, loc_cDescricao

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorAcessos)
                USE IN (THIS.this_cCursorAcessos)
            ENDIF
            IF USED("cursor_4c_AcessosTemp")
                USE IN cursor_4c_AcessosTemp
            ENDIF
            IF USED("cursor_4c_PrgDesc")
                USE IN cursor_4c_PrgDesc
            ENDIF

            loc_cUsuarios = EscaparSQL(ALLTRIM(par_cUsuarios))

            *-- Acessos diretos do usuario + via grupos aos quais pertence
            loc_cSQL = "SELECT DISTINCT a.Programas, a.Parametros, " + ;
                       "CAST('' AS VARCHAR(150)) AS Descricaos " + ;
                       "FROM SigCdAcU a " + ;
                       "LEFT OUTER JOIN SigCdAcG b ON a.Grupos = b.Grupos " + ;
                       "WHERE NOT a.Programas = SPACE(10) AND " + ;
                       "(a.Usuarios = " + loc_cUsuarios + ;
                       " OR b.Usuarios = " + loc_cUsuarios + ") " + ;
                       "ORDER BY a.Programas, a.Parametros"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcessosTemp") > 0

                SET NULL ON
                CREATE CURSOR cursor_4c_Acessos ;
                    (Programas C(15) NULL, Parametros C(10) NULL, Descricaos C(150) NULL)
                SET NULL OFF

                SELECT cursor_4c_AcessosTemp
                SCAN
                    loc_cProgram   = ALLTRIM(cursor_4c_AcessosTemp.Programas)
                    loc_cParam     = ALLTRIM(cursor_4c_AcessosTemp.Parametros)
                    loc_cDescricao = loc_cProgram + " / " + loc_cParam

                    loc_cSQL = "SELECT descricaos FROM SigCdPrg " + ;
                               "WHERE programas = " + EscaparSQL(loc_cProgram) + ;
                               " AND Parametros = " + EscaparSQL(loc_cParam)

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrgDesc") > 0
                        IF !EOF("cursor_4c_PrgDesc")
                            loc_cDescricao = ALLTRIM(cursor_4c_PrgDesc.descricaos)
                        ENDIF
                        IF USED("cursor_4c_PrgDesc")
                            USE IN cursor_4c_PrgDesc
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_Acessos
                    INSERT INTO cursor_4c_Acessos VALUES ;
                        (cursor_4c_AcessosTemp.Programas, ;
                         cursor_4c_AcessosTemp.Parametros, ;
                         loc_cDescricao)
                ENDSCAN

                IF USED("cursor_4c_AcessosTemp")
                    USE IN cursor_4c_AcessosTemp
                ENDIF

                SELECT cursor_4c_Acessos
                INDEX ON Descricaos TAG Descrs
                SET ORDER TO Descrs
                GO TOP

                *-- Carrega tambem barras para uso no SalvarGrupo
                THIS.CarregarBarrasDoUsuario(par_cUsuarios)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BuscarAcessosPorUsuario")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarBarrasDoUsuario - Carrega cursor_4c_Barra (dados para SigCdAcB)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarBarrasDoUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuarios

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorBarra)
                USE IN (THIS.this_cCursorBarra)
            ENDIF

            loc_cUsuarios = EscaparSQL(ALLTRIM(par_cUsuarios))

            loc_cSQL = "SELECT a.grupos, a.usuarios, a.descricaos, a.barraforms, " + ;
                       "a.barraordem, a.programas, a.parametros, a.selbarras " + ;
                       "FROM SigCdAcB a " + ;
                       "LEFT JOIN SigCdPrg b " + ;
                       "ON b.programas + b.parametros = a.programas + a.parametros " + ;
                       "WHERE a.usuarios = " + loc_cUsuarios + ;
                       " UNION ALL " + ;
                       "SELECT a.grupos, a.usuarios, a.descricaos, a.barraforms, " + ;
                       "a.barraordem, a.programas, a.parametros, a.selbarras " + ;
                       "FROM SigCdAcB a " + ;
                       "LEFT JOIN SigCdPrg b " + ;
                       "ON b.programas + b.parametros = a.programas + a.parametros " + ;
                       "WHERE a.grupos IN " + ;
                       "(SELECT c.grupos FROM SigCdAcG c WHERE c.usuarios = " + loc_cUsuarios + ") " + ;
                       "ORDER BY 1, 2"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Barra") > 0
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarBarrasDoUsuario")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarGrupoExistente - Verifica se codigo de grupo ja existe em SigCdGrA
    *--------------------------------------------------------------------------
    FUNCTION ValidarGrupoExistente(par_cGrupo)
        LOCAL loc_lExiste, loc_oErro, loc_cSQL

        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT Grupos FROM SigCdGrA " + ;
                       "WHERE Grupos = " + EscaparSQL(ALLTRIM(par_cGrupo))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpCheck") > 0
                loc_lExiste = !EOF("cursor_4c_GrpCheck")
                IF USED("cursor_4c_GrpCheck")
                    USE IN cursor_4c_GrpCheck
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ValidarGrupoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * RemoverAcessoLocal - Remove registro corrente do cursor_4c_Acessos (local)
    *--------------------------------------------------------------------------
    FUNCTION RemoverAcessoLocal()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorAcessos) AND !EOF(THIS.this_cCursorAcessos)
                SELECT (THIS.this_cCursorAcessos)
                DELETE
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em RemoverAcessoLocal")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarGrupo - Cria novo grupo copiando acessos do usuario
    * Orquestra INSERT em SigCdGrA, SigCdAcU e SigCdAcB via transacao
    *--------------------------------------------------------------------------
    FUNCTION SalvarGrupo(par_cUsuarios, par_cGrupo)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cGrupo, loc_cPkChave
        LOCAL loc_lTransacaoAberta, loc_lErroBanco

        loc_lSucesso        = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroBanco      = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cUsuarios))
                MsgAviso("Usu" + CHR(225) + "rio inv" + CHR(225) + "lido.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                IF EMPTY(ALLTRIM(par_cGrupo))
                MsgAviso("Grupo inv" + CHR(225) + "lido.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cGrupo = EscaparSQL(ALLTRIM(par_cGrupo))

                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacaoAberta = .T.

                *-- 1. Insere o novo grupo em SigCdGrA
                loc_cSQL = "INSERT INTO SigCdGrA (Grupos, nComps) VALUES (" + ;
                           loc_cGrupo + ", " + loc_cGrupo + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                    loc_lErroBanco = .T.
                ENDIF

                *-- 2. Para cada acesso nao-deletado em cursor_4c_Acessos,
                *--    insere em SigCdAcU associado ao novo grupo
                IF !loc_lErroBanco AND USED(THIS.this_cCursorAcessos)
                    SELECT (THIS.this_cCursorAcessos)
                    SCAN FOR !DELETED() AND !loc_lErroBanco
                        loc_cPkChave = EscaparSQL(SYS(2015) + SYS(2015))
                        loc_cSQL = "INSERT INTO SigCdAcU " + ;
                                   "(pkChaves, Programas, Parametros, Grupos, Usuarios) " + ;
                                   "VALUES (" + ;
                                   loc_cPkChave + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Acessos.Programas)) + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Acessos.Parametros)) + ", " + ;
                                   loc_cGrupo + ", '')"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                            loc_lErroBanco = .T.
                        ENDIF
                    ENDSCAN
                ENDIF

                *-- 3. Para cada barra em cursor_4c_Barra,
                *--    insere em SigCdAcB com grupo=NovoGrupo e usuario=vazio
                IF !loc_lErroBanco AND USED(THIS.this_cCursorBarra)
                    SELECT (THIS.this_cCursorBarra)
                    SCAN FOR !loc_lErroBanco
                        loc_cPkChave = EscaparSQL(SYS(2015) + SYS(2015))
                        loc_cSQL = "INSERT INTO SigCdAcB " + ;
                                   "(pkChaves, grupos, usuarios, descricaos, " + ;
                                   "barraforms, barraordem, programas, parametros, selbarras) " + ;
                                   "VALUES (" + ;
                                   loc_cPkChave + ", " + ;
                                   loc_cGrupo + ", " + ;
                                   "'', " + ;
                                   EscaparSQL(LEFT(ALLTRIM(NVL(cursor_4c_Barra.descricaos, "")), 73)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(NVL(cursor_4c_Barra.barraforms, "")), 50)) + ", " + ;
                                   FormatarNumeroSQL(NVL(cursor_4c_Barra.barraordem, 0), 0) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(NVL(cursor_4c_Barra.programas, "")), 15)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(NVL(cursor_4c_Barra.parametros, "")), 10)) + ", " + ;
                                   FormatarNumeroSQL(IIF(NVL(cursor_4c_Barra.selbarras, .F.), 1, 0), 0) + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                            loc_lErroBanco = .T.
                        ENDIF
                    ENDSCAN
                ENDIF

                IF loc_lErroBanco
                    SQLEXEC(gnConnHandle, "ROLLBACK")
                    loc_lTransacaoAberta = .F.
                    MsgErro("Erro na grava" + CHR(231) + CHR(227) + "o dos dados. " + ;
                            "Favor tentar novamente.", "Erro de Grava" + CHR(231) + CHR(227) + "o")
                ELSE
                    SQLEXEC(gnConnHandle, "COMMIT")
                    loc_lTransacaoAberta = .F.
                    THIS.this_cGrupos      = ALLTRIM(par_cGrupo)
                    THIS.this_cGrupoNComps = ALLTRIM(par_cGrupo)
                    THIS.RegistrarAuditoria("I")
                    loc_lSucesso = .T.
                ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em SalvarGrupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarUsuarioPorCodigo - Retorna nome do usuario dado seu codigo
    *--------------------------------------------------------------------------
    FUNCTION BuscarUsuarioPorCodigo(par_cCodigo)
        LOCAL loc_cNome, loc_oErro, loc_cSQL

        loc_cNome = ""

        TRY
            loc_cSQL = "SELECT NComps FROM SigCdUsu " + ;
                       "WHERE Usuarios = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuBuscaCod") > 0
                IF !EOF("cursor_4c_UsuBuscaCod")
                    loc_cNome = ALLTRIM(cursor_4c_UsuBuscaCod.NComps)
                ENDIF
                IF USED("cursor_4c_UsuBuscaCod")
                    USE IN cursor_4c_UsuBuscaCod
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BuscarUsuarioPorCodigo")
        ENDTRY

        RETURN loc_cNome
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarUsuarioPorNome - Retorna codigo do usuario dado seu nome
    *--------------------------------------------------------------------------
    FUNCTION BuscarUsuarioPorNome(par_cNome)
        RETURN ""
    ENDFUNC

ENDDEFINE

