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
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCac.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1050 linhas total):

*-- Linhas 18 a 26:
18: *   - LimparGrades()     = Text1.GotFocus legado (desvincula as duas grades)
19: *
20: * FASE 5/8 - Campo de filtro (unico campo deste form - sem Page1/Page2):
21: *   - lbl_4c_Programa + txt_4c_Programa (Label1/Text1 legado): "Programa :"
22: *   - TxtProgramaGotFocus() = Text1.GotFocus legado, ja ligado a LimparGrades()
23: *
24: * Este form NAO eh CRUD (SIGOPCAC eh tela de consulta, sem PageFrame/Page1/
25: * Page2 no legado), por isso nao ha AlternarPagina() nem botoes Incluir/
26: * Alterar/Excluir - o Commandgroup1 legado so tem os 2 botoes reais, e o

*-- Linhas 216 a 266:
216:     PROTECTED PROCEDURE ConfigurarCabecalho()
217:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
218:         WITH THIS.cnt_4c_Cabecalho
219:             .Top         = 0
220:             .Left        = 0
221:             .Width       = THIS.Width
222:             .Height      = 80
223:             .BackStyle   = 1
224:             .BackColor   = RGB(100, 100, 100)
225:             .BorderWidth = 0
226:             .Visible     = .T.
227:         ENDWITH
228: 
229:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblSombra", "Label")
230:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblSombra
231:             .Top        = 18
232:             .Left       = 10
233:             .Width      = 769
234:             .Height     = 40
235:             .FontName   = "Tahoma"
236:             .FontSize   = 18
237:             .FontBold   = .T.
238:             .ForeColor  = RGB(0, 0, 0)
239:             .BackStyle  = 0
240:             .WordWrap   = .T.
241:             .AutoSize   = .F.
242:             .Alignment  = 0
243:             .Caption    = THIS.Caption
244:             .Visible    = .T.
245:         ENDWITH
246: 
247:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblTitulo", "Label")
248:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblTitulo
249:             .Top        = 17
250:             .Left       = 10
251:             .Width      = 769
252:             .Height     = 46
253:             .FontName   = "Tahoma"
254:             .FontSize   = 18
255:             .FontBold   = .T.
256:             .ForeColor  = RGB(255, 255, 255)
257:             .BackStyle  = 0
258:             .WordWrap   = .T.
259:             .AutoSize   = .F.
260:             .Alignment  = 0
261:             .Caption    = THIS.Caption
262:             .Visible    = .T.
263:         ENDWITH
264:     ENDPROC
265: 
266:     *==========================================================================

*-- Linhas 280 a 307:
280:     * ligado em VincularEventos().
281:     *==========================================================================
282:     PROTECTED PROCEDURE ConfigurarFiltroPrograma()
283:         THIS.AddObject("lbl_4c_Programa", "Label")
284:         WITH THIS.lbl_4c_Programa
285:             .Top       = 100
286:             .Left      = 58
287:             .Width     = 55
288:             .Height    = 15
289:             .FontName  = "Tahoma"
290:             .FontSize  = 8
291:             .ForeColor = RGB(90, 90, 90)
292:             .BackStyle = 0
293:             .AutoSize  = .F.
294:             .Alignment = 0
295:             .Caption   = "Programa :"
296:             .Visible   = .T.
297:         ENDWITH
298: 
299:         THIS.AddObject("txt_4c_Programa", "TextBox")
300:         WITH THIS.txt_4c_Programa
301:             .Top       = 96
302:             .Left      = 130
303:             .Width     = 614
304:             .Height    = 23
305:             .MaxLength = 100
306:             .FontName  = "Tahoma"
307:             .FontSize  = 8

*-- Linhas 324 a 333:
324:         *-- Grid1 legado -> grd_4c_Grupos (coluna unica "Grupo")
325:         THIS.AddObject("grd_4c_Grupos", "Grid")
326:         WITH THIS.grd_4c_Grupos
327:             .Top           = 130
328:             .Left          = 31
329:             .Width         = 113
330:             .Height        = 396
331:             .HeaderHeight       = 0
332:             .ColumnCount   = 1
333:             .Panel         = 1

*-- Linhas 346 a 355:
346:         *-- Grid2 legado -> grd_4c_Usuarios (Usuario/Nome/Cargo/Depto/Tipo)
347:         THIS.AddObject("grd_4c_Usuarios", "Grid")
348:         WITH THIS.grd_4c_Usuarios
349:             .Top           = 131
350:             .Left          = 149
351:             .Width         = 614
352:             .Height        = 395
353:             .HeaderHeight       = 0
354:             .ColumnCount   = 5
355:             .Panel         = 1

*-- Linhas 388 a 396:
388:             .FontName  = "Tahoma"
389:             .FontSize  = 8
390:             .Alignment = 2
391:             .Caption   = "Grupo"
392:             .ForeColor = RGB(36, 84, 155)
393:         ENDWITH
394: 
395:         WITH THIS.grd_4c_Grupos.Column1.Text1
396:             .FontName    = "Tahoma"

*-- Linhas 442 a 450:
442:         WITH loc_oColuna.Header1
443:             .FontName  = "Tahoma"
444:             .FontSize  = 8
445:             .Caption   = par_cCaption
446:             .ForeColor = par_nForeColorHeader
447:         ENDWITH
448: 
449:         IF VARTYPE(par_lCentralizar) = "L" AND par_lCentralizar
450:             loc_oColuna.Header1.Alignment = 2

*-- Linhas 468 a 493:
468:     PROTECTED PROCEDURE ConfigurarBotoes()
469:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
470:         WITH THIS.cmg_4c_Botoes
471:             .Top           = -2
472:             .Left          = 644
473:             .Width         = 160
474:             .Height        = 85
475:             .ButtonCount   = 2
476:             .BackStyle     = 0
477:             .BorderStyle   = 0
478:             .SpecialEffect = 1
479:             .BorderColor   = RGB(136, 189, 188)
480:             .Visible       = .T.
481:         ENDWITH
482: 
483:         WITH THIS.cmg_4c_Botoes.Buttons(1)
484:             .Top         = 5
485:             .Left        = 5
486:             .Width       = 75
487:             .Height      = 75
488:             .Caption     = "Consultar"
489:             .ToolTipText = "Consultar"
490:             .Picture     = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
491:             .FontName    = "Comic Sans MS"
492:             .FontSize    = 8
493:             .FontBold    = .T.

*-- Linhas 499 a 512:
499:         ENDWITH
500: 
501:         WITH THIS.cmg_4c_Botoes.Buttons(2)
502:             .Top         = 5
503:             .Left        = 80
504:             .Width       = 75
505:             .Height      = 75
506:             .Cancel      = .T.
507:             .Caption     = "Encerrar"
508:             .ToolTipText = "[ESC] Sair"
509:             .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
510:             .FontName    = "Comic Sans MS"
511:             .FontSize    = 8
512:             .FontBold    = .T.

*-- Linhas 858 a 866:
858:                     *-- Sem isto o picker abre com o default "Procura" do
859:                     *-- FormBuscaAuxiliar.
860:                     loc_oBusca.this_cTitulo = "Programas"
861:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = "Programas"
862: 
863:                     *-- DUAS colunas, e nao a UNICA do browse legado, por causa
864:                     *-- de como o FormBuscaAuxiliar dimensiona a grade: ele
865:                     *-- IGNORA a mascara passada em mAddColuna e fixa a 1a
866:                     *-- coluna em 80px, dividindo o restante entre as demais.


### BO (C:\4c\projeto\app\classes\SigOpCacBO.prg):
*==============================================================================
* SigOpCacBO.prg - Business Object para Consulta de Acesso a Programas
* Herda de: BusinessBase
* Origem: SIGOPCAC.SCX (form operacional, somente consulta)
* Tabelas: SigCdPrg (programas/parametros), SigCdAcu (acesso por grupo/usuario),
*          SigCdUsu (usuarios), SigCdAcG (usuarios por grupo)
*
* Form somente-leitura: nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao().
* O comportamento padrao herdado de BusinessBase ja eh o correto para esta tela.
*==============================================================================

DEFINE CLASS SigOpCacBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao do BusinessBase
    *--------------------------------------------------------------------------
    this_cTabela     = "SigCdPrg"
    this_cCampoChave = "programas"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO e pre-carrega o cursor de programas/parametros
    * (equivalente ao poDataMgr.SqlExecute(...,'crSigCdPrg1') do Init legado)
    *--------------------------------------------------------------------------
    * O pre-carregamento do cursor de programas eh um CACHE, nao pre-requisito:
    * BuscarPrograma() refaz a carga sob demanda (IF !USED(...)). Por isso o Init
    * devolve .T. mesmo quando a carga falha - devolver .F. faria o
    * CREATEOBJECT("SigOpCacBO") virar .F. e o Form abortaria o proprio Init,
    * deixando a tela sem abrir por uma falha de cache. O legado tambem nao
    * aborta: o Init dele so roda o SqlExecute do crSigCdPrg1.
    FUNCTION Init()
        LOCAL loc_oErro, loc_lValidandoUI

        TRY
            DODEFAULT()

            *-- Nao executa SQL durante validacao de UI / teste automatizado,
            *-- em que gnConnHandle = -1 (padrao canonico do projeto).
            loc_lValidandoUI = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                               (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

            IF !loc_lValidandoUI
                THIS.CarregarProgramas()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpCacBO.Init")
        ENDTRY

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarProgramas - Popula cursor_4c_Programas com descricaos/programas/
    * parametros de SigCdPrg, com Descricaos em MAIUSCULO (Replace All do legado)
    *--------------------------------------------------------------------------
    FUNCTION CarregarProgramas()
        LOCAL loc_lSucesso, loc_oErro, loc_nResult

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Programas")
                USE IN cursor_4c_Programas
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT descricaos, programas, parametros FROM SigCdPrg", ;
                "cursor_4c_Programas")

            IF loc_nResult >= 0
                SELECT cursor_4c_Programas
                REPLACE ALL descricaos WITH UPPER(descricaos) IN cursor_4c_Programas
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar programas cadastrados." + CHR(13) + CapturarErroSQL(), ;
                        "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpCacBO.CarregarProgramas")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarPrograma - Procura par_cTexto em cursor_4c_Programas.descricaos
    * (equivalente ao Valid do Text1 legado, sem a resolucao do browse -
    * a decisao de match unico/multiplo/vazio fica no Form)
    * Resultado em cursor_4c_ProgramaBusca (descricaos, programas, parametros)
    *--------------------------------------------------------------------------
    FUNCTION BuscarPrograma(par_cTexto)
        LOCAL loc_lSucesso, loc_oErro, loc_cBusca

        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Programas")
                THIS.CarregarProgramas()
            ENDIF

            IF USED("cursor_4c_Programas")
                loc_cBusca = "%" + UPPER(ALLTRIM(par_cTexto)) + "%"

                IF USED("cursor_4c_ProgramaBusca")
                    USE IN cursor_4c_ProgramaBusca
                ENDIF

                SELECT descricaos, programas, parametros FROM cursor_4c_Programas ;
                    WHERE descricaos LIKE loc_cBusca ;
                    INTO CURSOR cursor_4c_ProgramaBusca READWRITE

                loc_lSucesso = (RECCOUNT("cursor_4c_ProgramaBusca") > 0)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpCacBO.BuscarPrograma")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Popula cursor_4c_Grupos com os grupos de acesso ao
    * programa/parametro informados (equivalente ao Command1.Click legado)
    * Mantem a linha de grupo VAZIO quando ela nao existir no resultado
    * (legado: If Eof() or !Empty(Grupos) then Append Blank), que representa
    * acesso por supervisor/individual sem grupo especifico.
    *--------------------------------------------------------------------------
    FUNCTION BuscarGrupos(par_cPrograma, par_cParametro)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult, loc_cProg, loc_cParm

        loc_lSucesso = .F.
        loc_cProg    = ALLTRIM(par_cPrograma)
        loc_cParm    = ALLTRIM(par_cParametro)

        TRY
            loc_cSQL = "SELECT DISTINCT grupos FROM SigCdAcu " + ;
                       "WHERE programas = " + EscaparSQL(loc_cProg)

            IF !EMPTY(loc_cParm)
                loc_cSQL = loc_cSQL + " AND parametros = " + EscaparSQL(loc_cParm)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY grupos"

            IF USED("cursor_4c_GruposTmp")
                USE IN cursor_4c_GruposTmp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposTmp")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Grupos")
                    USE IN cursor_4c_Grupos
                ENDIF

                SELECT grupos FROM cursor_4c_GruposTmp INTO CURSOR cursor_4c_Grupos READWRITE

                IF USED("cursor_4c_GruposTmp")
                    USE IN cursor_4c_GruposTmp
                ENDIF

                SELECT cursor_4c_Grupos
                GO TOP

                IF EOF("cursor_4c_Grupos") OR !EMPTY(cursor_4c_Grupos.grupos)
                    APPEND BLANK IN cursor_4c_Grupos
                ENDIF

                SELECT cursor_4c_Grupos
                INDEX ON grupos TAG grupos
                GO TOP

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao consultar grupos de acesso." + CHR(13) + CapturarErroSQL(), ;
                        "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpCacBO.BuscarGrupos")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarUsuarios - Popula cursor_4c_Usuarios com os usuarios do grupo
    * selecionado (equivalente ao AfterRowColChange do Grid1 legado)
    *
    * par_cGrupo VAZIO -> usuarios supervisores (Supervis IN 'S','I') UNION
    *   usuarios com acesso INDIVIDUAL ao programa/parametro (SigCdAcu com
    *   Grupos em branco)
    * par_cGrupo preenchido -> usuarios vinculados a esse grupo via SigCdAcG
    *--------------------------------------------------------------------------
    FUNCTION BuscarUsuarios(par_cGrupo, par_cPrograma, par_cParametro)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        LOCAL loc_cGrupo, loc_cProg, loc_cParm

        loc_lSucesso = .F.
        loc_cGrupo   = ALLTRIM(par_cGrupo)
        loc_cProg    = ALLTRIM(par_cPrograma)
        loc_cParm    = ALLTRIM(par_cParametro)

        TRY
            IF EMPTY(loc_cGrupo)
                loc_cSQL = "SELECT DISTINCT usuarios, ncomps, ccargs, deptos, supervis, cativos " + ;
                           "FROM SigCdUsu WHERE supervis IN ('S','I') " + ;
                           "UNION " + ;
                           "SELECT DISTINCT b.usuarios, b.ncomps, b.ccargs, b.deptos, b.supervis, b.cativos " + ;
                           "FROM SigCdAcu a INNER JOIN SigCdUsu b ON a.usuarios = b.usuarios " + ;
                           "WHERE a.grupos = " + EscaparSQL(SPACE(10)) + " " + ;
                           "AND a.programas = " + EscaparSQL(loc_cProg)

                IF !EMPTY(loc_cParm)
                    loc_cSQL = loc_cSQL + " AND a.parametros = " + EscaparSQL(loc_cParm)
                ENDIF
            ELSE
                loc_cSQL = "SELECT DISTINCT a.usuarios, a.ncomps, a.ccargs, a.deptos, a.supervis, a.cativos " + ;
                           "FROM SigCdUsu a LEFT JOIN SigCdAcG b ON a.usuarios = b.usuarios " + ;
                           "WHERE b.grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF

            IF USED("cursor_4c_UsuariosTmp")
                USE IN cursor_4c_UsuariosTmp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuariosTmp")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Usuarios")
                    USE IN cursor_4c_Usuarios
                ENDIF

                SELECT usuarios, ncomps, ccargs, deptos, supervis, cativos ;
                    FROM cursor_4c_UsuariosTmp INTO CURSOR cursor_4c_Usuarios READWRITE

                IF USED("cursor_4c_UsuariosTmp")
                    USE IN cursor_4c_UsuariosTmp
                ENDIF

                SELECT cursor_4c_Usuarios
                INDEX ON usuarios TAG usuarios
                GO TOP

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao consultar usuarios de acesso." + CHR(13) + CapturarErroSQL(), ;
                        "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpCacBO.BuscarUsuarios")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

