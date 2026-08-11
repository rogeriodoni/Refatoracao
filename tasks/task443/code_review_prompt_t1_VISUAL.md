# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 310: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 335: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 360: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 386: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormGrupo.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1007 linhas total):

*-- Linhas 86 a 106:
86:             *-- Titulo baseado na operacao carregada
87:             loc_cTitulo = "Grupos de Produtos " + ;
88:                           ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
89:             THIS.Caption = loc_cTitulo
90: 
91:             *-- Fundo do form (new_background.jpg do legado)
92:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
93:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
94:             ENDIF
95: 
96:             *-- Criar containers e controles
97:             THIS.ConfigurarPageFrame()
98: 
99:             *-- Setar caption nos labels do cabecalho
100:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
101:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
102: 
103:             *-- Tornar controles visiveis
104:             THIS.TornarControlesVisiveis(THIS)
105: 
106:             loc_lSucesso = .T.

*-- Linhas 129 a 176:
129:             *-- Cabecalho escuro (cntSombra do legado: Top=-1, W=800, H=80)
130:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
131:             WITH THIS.cnt_4c_Cabecalho
132:                 .Top         = -1
133:                 .Left        = 0
134:                 .Width       = THIS.Width
135:                 .Height      = 80
136:                 .BackStyle   = 1
137:                 .BackColor   = RGB(100,100,100)
138:                 .BorderWidth = 0
139:                 .Visible     = .T.
140:             ENDWITH
141: 
142:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
143:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
144:                 .FontBold  = .T.
145:                 .FontName  = "Tahoma"
146:                 .FontSize  = 18
147:                 .WordWrap  = .T.
148:                 .Alignment = 0
149:                 .BackStyle = 0
150:                 .AutoSize  = .F.
151:                 .Caption   = ""
152:                 .Height    = 40
153:                 .Left      = 10
154:                 .Top       = 18
155:                 .Width     = 769
156:                 .ForeColor = RGB(0,0,0)
157:             ENDWITH
158: 
159:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
160:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
161:                 .FontBold  = .T.
162:                 .FontName  = "Tahoma"
163:                 .FontSize  = 18
164:                 .WordWrap  = .T.
165:                 .Alignment = 0
166:                 .BackStyle = 0
167:                 .AutoSize  = .F.
168:                 .Caption   = ""
169:                 .Height    = 46
170:                 .Left      = 10
171:                 .Top       = 17
172:                 .Width     = 769
173:                 .ForeColor = RGB(255,255,255)
174:             ENDWITH
175: 
176:             THIS.ConfigurarPaginaLista()

*-- Linhas 232 a 241:
232:             *-- Grid de grupos (GradeOpe do legado: Top=115, Left=236, W=264, H=274)
233:             THIS.AddObject("grd_4c_Dados", "Grid")
234:             WITH THIS.grd_4c_Dados
235:                 .Top          = 115
236:                 .Left         = 236
237:                 .Width        = 264
238:                 .Height       = 274
239:                 .ColumnCount  = 2
240:                 .RecordSource = "cursor_4c_Ope"
241:                 .Column1.ControlSource = "cursor_4c_Ope.Cgrus"

*-- Linhas 260 a 268:
260:                     .FontName      = "Tahoma"
261:                     .FontSize      = 8
262:                     .ForeColor     = RGB(90,90,90)
263:                     .Header1.Caption   = "Grupo"
264:                     .Header1.FontName  = "Tahoma"
265:                     .Header1.FontSize  = 8
266:                     .Header1.Alignment = 2
267:                     .Header1.ForeColor = RGB(36,84,155)
268:                     WITH .Text1

*-- Linhas 282 a 290:
282:                     .FontName      = "Tahoma"
283:                     .FontSize      = 8
284:                     .ForeColor     = RGB(90,90,90)
285:                     .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
286:                     .Header1.FontName  = "Tahoma"
287:                     .Header1.FontSize  = 8
288:                     .Header1.Alignment = 2
289:                     .Header1.ForeColor = RGB(36,84,155)
290:                     WITH .Text1

*-- Linhas 300 a 316:
300:             BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "TxtGrupoKeyPress")
301: 
302:             *-- Botao Inserir (cmdInserir do legado: Top=3, Left=500)
303:             THIS.AddObject("cmd_4c_Inserir", "CommandButton")
304:             WITH THIS.cmd_4c_Inserir
305:                 .Top             = 3
306:                 .Left            = 500
307:                 .Width           = 75
308:                 .Height          = 75
309:                 .Caption         = "\<Inserir"
310:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
311:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
312:                 .FontName        = "Comic Sans MS"
313:                 .FontBold        = .T.
314:                 .FontItalic      = .T.
315:                 .FontSize        = 8
316:                 .ForeColor       = RGB(90,90,90)

*-- Linhas 322 a 341:
322:                 .WordWrap        = .T.
323:                 .AutoSize        = .F.
324:             ENDWITH
325:             BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "BtnInserirClick")
326: 
327:             *-- Botao Excluir (cmdExcluir do legado: Top=3, Left=575)
328:             THIS.AddObject("cmd_4c_Excluir", "CommandButton")
329:             WITH THIS.cmd_4c_Excluir
330:                 .Top             = 3
331:                 .Left            = 575
332:                 .Width           = 75
333:                 .Height          = 75
334:                 .Caption         = "\<Excluir"
335:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
336:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
337:                 .FontName        = "Comic Sans MS"
338:                 .FontBold        = .T.
339:                 .FontItalic      = .T.
340:                 .FontSize        = 8
341:                 .ForeColor       = RGB(90,90,90)

*-- Linhas 347 a 366:
347:                 .WordWrap        = .T.
348:                 .AutoSize        = .F.
349:             ENDWITH
350:             BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
351: 
352:             *-- Botao Confirmar (cmdSair do legado: salva e fecha; Top=3, Left=650)
353:             THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
354:             WITH THIS.cmd_4c_Confirmar
355:                 .Top             = 3
356:                 .Left            = 650
357:                 .Width           = 75
358:                 .Height          = 75
359:                 .Caption         = "\<Confirmar"
360:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
361:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
362:                 .FontName        = "Comic Sans MS"
363:                 .FontBold        = .T.
364:                 .FontItalic      = .T.
365:                 .FontSize        = 8
366:                 .ForeColor       = RGB(90,90,90)

*-- Linhas 372 a 392:
372:                 .WordWrap        = .T.
373:                 .AutoSize        = .F.
374:             ENDWITH
375:             BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
376: 
377:             *-- Botao Cancelar (Cancela do legado: fecha sem salvar; Top=3, Left=725)
378:             THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
379:             WITH THIS.cmd_4c_Cancelar
380:                 .Top             = 3
381:                 .Left            = 725
382:                 .Width           = 75
383:                 .Height          = 75
384:                 .Caption         = "Encerrar"
385:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
386:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
387:                 .Cancel          = .T.
388:                 .FontName        = "Comic Sans MS"
389:                 .FontBold        = .T.
390:                 .FontItalic      = .T.
391:                 .FontSize        = 8
392:                 .ForeColor       = RGB(90,90,90)

*-- Linhas 398 a 406:
398:                 .WordWrap        = .T.
399:                 .AutoSize        = .F.
400:             ENDWITH
401:             BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
402: 
403:         CATCH TO loc_oErro
404:             MsgErro(loc_oErro.Message + CHR(13) + ;
405:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
406:                     "Procedure: " + loc_oErro.Procedure, ;

*-- Linhas 673 a 685:
673:             ENDIF
674: 
675:             *-- Label "Grande Grupo :" (Say4: Left=588, Top=137, W=76, H=15)
676:             THIS.AddObject("lbl_4c_GrandeGrupo", "Label")
677:             WITH THIS.lbl_4c_GrandeGrupo
678:                 .Caption   = "Grande Grupo :"
679:                 .Left      = 588
680:                 .Top       = 137
681:                 .Width     = 76
682:                 .Height    = 15
683:                 .FontBold  = .F.
684:                 .FontName  = "Tahoma"
685:                 .FontSize  = 8

*-- Linhas 691 a 700:
691:             *-- TextBox codigo do Grande Grupo (getGdeGrps: Left=667, Top=134, W=38, MaxLength=3)
692:             THIS.AddObject("txt_4c_GdeGrps", "TextBox")
693:             WITH THIS.txt_4c_GdeGrps
694:                 .Left          = 667
695:                 .Top           = 134
696:                 .Width         = 38
697:                 .Height        = 24
698:                 .MaxLength     = 3
699:                 .SpecialEffect = 1
700:                 .Alignment     = 3

*-- Linhas 708 a 734:
708:             BINDEVENT(THIS.txt_4c_GdeGrps, "DblClick", THIS, "TxtGdeGrpsDblClick")
709: 
710:             *-- Botao Carregar (btnCarregar: Top=118, Left=507, W=52, H=52)
711:             THIS.AddObject("cmd_4c_Carregar", "CommandButton")
712:             WITH THIS.cmd_4c_Carregar
713:                 .Top             = 118
714:                 .Left            = 507
715:                 .Width           = 52
716:                 .Height          = 52
717:                 .Caption         = ""
718:                 .ToolTipText     = "Carregar Grande Grupo"
719:                 .Picture         = gc_4c_CaminhoIcones + "importar_48.png"
720:                 .DisabledPicture = gc_4c_CaminhoIcones + "importar_48.png"
721:                 .BackColor       = RGB(255,255,255)
722:                 .FontName        = "Verdana"
723:                 .FontSize        = 8
724:                 .Themes          = .T.
725:                 .SpecialEffect   = 0
726:                 .MousePointer    = 15
727:                 .Enabled         = loc_lHabilitado
728:             ENDWITH
729:             BINDEVENT(THIS.cmd_4c_Carregar, "Click", THIS, "BtnCarregarClick")
730: 
731:         CATCH TO loc_oErro
732:             MsgErro(loc_oErro.Message + CHR(13) + ;
733:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
734:                     "Procedure: " + loc_oErro.Procedure, ;

*-- Linhas 907 a 917:
907:     *==========================================================================
908:     PROCEDURE HabilitarCampos(par_lHabilitar)
909:         THIS.txt_4c_GdeGrps.Enabled        = par_lHabilitar
910:         THIS.cmd_4c_Inserir.Enabled        = par_lHabilitar
911:         THIS.cmd_4c_Excluir.Enabled        = par_lHabilitar
912:         THIS.cmd_4c_Confirmar.Enabled      = par_lHabilitar
913:         THIS.grd_4c_Dados.Column1.ReadOnly = !par_lHabilitar
914:     ENDPROC
915: 
916:     *==========================================================================
917:     * LimparCampos - Limpa o campo Grande Grupo e esvazia o grid local


### BO (C:\4c\projeto\app\classes\GrupoBO.prg):
*==============================================================================
* GrupoBO.prg - Business Object para Grupos de Produto por Operacao
* Tabela principal : SigOpGpo (cgrus, cidchaves, dopes)
* Tabela referencia: SigCdGrp (cgrus, dgrus, mercs)
* Grande Grupo     : SigCdGpr (codigos, descs)
*==============================================================================
DEFINE CLASS GrupoBO AS BusinessBase

    *-- Configuracao da tabela
    this_cTabela     = "SigOpGpo"
    this_cCampoChave = "cidchaves"

    *-- Codigo da operacao corrente (vem do form pai via crSigCdOpe.Dopes)
    this_cDopes      = ""

    *-- Filtro de grande grupo (SigCdGpr.codigos char(3))
    this_cGdeGrps    = ""

    *-- Flag de gravacao (alteracoes nao salvas no grid)
    this_lGravaDados = .F.

    *-- Nomes dos cursores de trabalho
    this_cCursorOpe      = "cursor_4c_Ope"         && grid de edicao local
    this_cCursorSigOpGpo = "cursor_4c_SigOpGpo"    && cursor persistente (poDataMgr)

    *-- Propriedades para operacoes CRUD unitarias (linha unica de SigOpGpo)
    this_cCgrus      = ""    && SigOpGpo.Cgrus char(3)
    this_cIdChaves   = ""    && SigOpGpo.cIdChaves char(30) (PK gerada por SYS(2015))

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - retorna chave para auditoria
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cDopes
    ENDFUNC

    *==========================================================================
    * InicializarDados - Cria cursor local e carrega dados existentes do SQL Server
    * par_cDopes: codigo da operacao (ex: crSigCdOpe.Dopes do form pai)
    *==========================================================================
    PROCEDURE InicializarDados(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cDopes = ALLTRIM(par_cDopes)

        TRY
            SET NULL ON
            CREATE CURSOR cursor_4c_Ope (Dopes C(20) NULL, Cgrus C(3) NULL, Dgrus C(30) NULL)
            SET NULL OFF
            INDEX ON Cgrus TAG Cgrus
            SET ORDER TO

            loc_cSQL = "SELECT a.Dopes, a.Cgrus, b.Dgrus " + ;
                       "FROM SigOpGpo a " + ;
                       "INNER JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                       "WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopes)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeTemp") > 0
                SELECT cursor_4c_Ope
                ZAP
                APPEND FROM DBF("cursor_4c_OpeTemp")
                USE IN cursor_4c_OpeTemp
            ENDIF

            SELECT cursor_4c_Ope
            SET ORDER TO
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirLinhaGrid - Insere linha em branco no cursor local de trabalho
    *==========================================================================
    PROCEDURE InserirLinhaGrid()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Ope")
                INSERT INTO cursor_4c_Ope (Dopes, Cgrus, Dgrus) ;
                    VALUES (THIS.this_cDopes, SPACE(3), SPACE(30))
                SELECT cursor_4c_Ope
                THIS.this_lGravaDados = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InserirLinhaGrid")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExcluirLinhaGrid - Exclui a linha corrente do cursor local
    *==========================================================================
    PROCEDURE ExcluirLinhaGrid()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Ope") AND !EOF("cursor_4c_Ope")
                SELECT cursor_4c_Ope
                DELETE
                SKIP
                IF EOF("cursor_4c_Ope")
                    GO BOTTOM
                ENDIF
                THIS.this_lGravaDados = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ExcluirLinhaGrid")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarGrupo - Valida Cgrus em SigCdGrp e atualiza Dgrus no cursor local
    * par_cCgrus: codigo digitado
    * RETORNO: .T. se encontrado (Dgrus preenchido), .F. se nao encontrado
    *==========================================================================
    PROCEDURE ValidarGrupo(par_cCgrus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 Cgrus, Dgrus FROM SigCdGrp " + ;
                       "WHERE Cgrus = " + EscaparSQL(ALLTRIM(par_cCgrus))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpVal") > 0
                IF !EOF("cursor_4c_GrpVal")
                    IF USED("cursor_4c_Ope") AND !EOF("cursor_4c_Ope")
                        REPLACE Cgrus WITH ALLTRIM(cursor_4c_GrpVal.Cgrus) IN cursor_4c_Ope
                        REPLACE Dgrus WITH ALLTRIM(cursor_4c_GrpVal.Dgrus) IN cursor_4c_Ope
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
                USE IN cursor_4c_GrpVal
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarGrupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarGrandeGrupo - Carrega grupos de SigCdGrp onde Mercs = par_cGdeGrps
    * par_cGdeGrps: codigo do grande grupo (SigCdGpr.Codigos)
    * RETORNO: .T. se carregou com sucesso
    *==========================================================================
    PROCEDURE CarregarGrandeGrupo(par_cGdeGrps)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cGdeGrps))
            MsgAviso("Preencha o Grande Grupo Antes de Processar!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cGdeGrps  = par_cGdeGrps
            THIS.this_lGravaDados = .T.

            loc_cSQL = "SELECT Cgrus, Dgrus FROM SigCdGrp " + ;
                       "WHERE Mercs = " + EscaparSQL(ALLTRIM(par_cGdeGrps))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalGru") < 1
                MsgErro("Falha ao carregar grupos do grande grupo.", "Erro")
            ELSE
                *-- Remover linhas em branco existentes
                IF !EOF("cursor_4c_LocalGru")
                    DELETE FROM cursor_4c_Ope WHERE EMPTY(ALLTRIM(Cgrus))
                ENDIF

                *-- Adicionar grupos ausentes no cursor local
                SELECT cursor_4c_LocalGru
                SCAN
                    SELECT cursor_4c_Ope
                    GO TOP
                    LOCATE FOR ALLTRIM(Cgrus) == ALLTRIM(cursor_4c_LocalGru.Cgrus)
                    IF EOF("cursor_4c_Ope")
                        INSERT INTO cursor_4c_Ope (Dopes, Cgrus, Dgrus) ;
                            VALUES (THIS.this_cDopes, ;
                                    ALLTRIM(cursor_4c_LocalGru.Cgrus), ;
                                    ALLTRIM(cursor_4c_LocalGru.Dgrus))
                    ENDIF
                ENDSCAN

                *-- Linha em branco ao final para entrada manual
                IF !EOF("cursor_4c_LocalGru")
                    INSERT INTO cursor_4c_Ope (Dopes, Cgrus, Dgrus) ;
                        VALUES (THIS.this_cDopes, SPACE(3), SPACE(30))
                ENDIF

                IF USED("cursor_4c_LocalGru")
                    USE IN cursor_4c_LocalGru
                ENDIF

                SELECT cursor_4c_Ope
                GO BOTTOM

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarGrandeGrupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDuplicidade - Verifica grupos duplicados no cursor local
    * RETORNO: .T. se valido (sem duplicatas), .F. se ha duplicatas
    *==========================================================================
    PROTECTED FUNCTION ValidarDuplicidade()
        LOCAL loc_lValido, loc_oErro

        loc_lValido = .T.

        TRY
            SELECT Cgrus, SUM(1) AS nQt ;
                FROM cursor_4c_Ope ;
                WHERE !EMPTY(ALLTRIM(Cgrus)) ;
                GROUP BY Cgrus ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_DupCheck READWRITE

            IF RECCOUNT("cursor_4c_DupCheck") > 0
                MsgAviso("Existem lan" + CHR(231) + "amentos de Grupos Em Duplicidade!!!", ;
                         "Duplicidade")
                loc_lValido = .F.
            ENDIF

            IF USED("cursor_4c_DupCheck")
                USE IN cursor_4c_DupCheck
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarDuplicidade")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * Confirmar - Salva todas as alteracoes no SQL Server
    * DELETE + INSERT por operacao (padrao do legado SigOpGpo)
    * RETORNO: .T. se gravado com sucesso, .F. caso contrario
    *==========================================================================
    PROCEDURE Confirmar()
        LOCAL loc_lSucesso, loc_lErroInserir, loc_cSQL, loc_cIdChave, loc_oErro

        loc_lSucesso   = .F.
        loc_lErroInserir = .F.

        TRY
            IF THIS.ValidarDuplicidade()
                loc_cSQL = "DELETE FROM SigOpGpo WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelResult") < 1
                    MsgErro("Erro ao excluir registros anteriores da opera" + CHR(231) + CHR(227) + "o.", "Erro")
                ELSE
                    IF USED("cursor_4c_DelResult")
                        USE IN cursor_4c_DelResult
                    ENDIF

                    SELECT cursor_4c_Ope
                    SCAN FOR !EMPTY(ALLTRIM(Cgrus))
                        loc_cIdChave = SYS(2015)
                        loc_cSQL = "INSERT INTO SigOpGpo (Dopes, Cgrus, cIdChaves) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(THIS.this_cDopes) + ", " + ;
                                   EscaparSQL(ALLTRIM(Cgrus)) + ", " + ;
                                   EscaparSQL(loc_cIdChave) + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsResult") < 1
                            MsgErro("Erro ao inserir grupo " + ALLTRIM(Cgrus) + ".", "Erro")
                            loc_lErroInserir = .T.
                            EXIT
                        ENDIF

                        IF USED("cursor_4c_InsResult")
                            USE IN cursor_4c_InsResult
                        ENDIF
                    ENDSCAN

                    IF !loc_lErroInserir
                        THIS.this_lGravaDados = .F.
                        THIS.RegistrarAuditoria("ATUALIZAR")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Confirmar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia colunas de um cursor (crSigCdOpe do form pai ou
    * cursor local do grid) para as propriedades this_c* do BO
    * par_cAliasCursor: nome do cursor origem (default: cursor_4c_Ope)
    * RETORNO: .T. se carregou com sucesso
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = IIF(EMPTY(par_cAliasCursor), THIS.this_cCursorOpe, par_cAliasCursor)

        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF()
                    *-- Dopes: sempre presente em cursores de operacao/grid
                    IF TYPE(loc_cAlias + ".Dopes") != "U"
                        THIS.this_cDopes = ALLTRIM(NVL(Dopes, ""))
                    ENDIF

                    *-- Cgrus: presente no cursor local do grid e em SigOpGpo
                    IF TYPE(loc_cAlias + ".Cgrus") != "U"
                        THIS.this_cCgrus = ALLTRIM(NVL(Cgrus, ""))
                    ENDIF

                    *-- cIdChaves: apenas em SigOpGpo (PK)
                    IF TYPE(loc_cAlias + ".cIdChaves") != "U"
                        THIS.this_cIdChaves = ALLTRIM(NVL(cIdChaves, ""))
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
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
    * Inserir - Insere uma linha unica em SigOpGpo (Dopes, Cgrus, cIdChaves)
    * Usa as propriedades this_cDopes, this_cCgrus preenchidas previamente
    * Gera cIdChaves via SYS(2015) se nao definida
    * RETORNO: .T. se inserido com sucesso, .F. caso contrario
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cDopes))
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o (Dopes) n" + CHR(227) + "o informada.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCgrus))
                MsgAviso("Grupo (Cgrus) n" + CHR(227) + "o informado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
                THIS.this_cIdChaves = SYS(2015)
            ENDIF

            loc_cSQL = "INSERT INTO SigOpGpo (Dopes, Cgrus, cIdChaves) " + ;
                       "VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCgrus)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cIdChaves)) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsUnit") < 1
                MsgErro("Erro ao inserir registro em SigOpGpo.", "Erro")
            ELSE
                IF USED("cursor_4c_InsUnit")
                    USE IN cursor_4c_InsUnit
                ENDIF

                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LiberarCursores - Libera todos os cursores temporarios ao fechar
    *==========================================================================
    PROCEDURE LiberarCursores()
        IF USED("cursor_4c_Ope")
            USE IN cursor_4c_Ope
        ENDIF
        IF USED("cursor_4c_OpeTemp")
            USE IN cursor_4c_OpeTemp
        ENDIF
        IF USED("cursor_4c_GrpVal")
            USE IN cursor_4c_GrpVal
        ENDIF
        IF USED("cursor_4c_LocalGru")
            USE IN cursor_4c_LocalGru
        ENDIF
        IF USED("cursor_4c_DupCheck")
            USE IN cursor_4c_DupCheck
        ENDIF
        IF USED("cursor_4c_DelResult")
            USE IN cursor_4c_DelResult
        ENDIF
        IF USED("cursor_4c_InsResult")
            USE IN cursor_4c_InsResult
        ENDIF
        IF USED("cursor_4c_InsUnit")
            USE IN cursor_4c_InsUnit
        ENDIF
    ENDPROC

ENDDEFINE

