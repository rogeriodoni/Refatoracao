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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpArq.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (891 linhas total):

*-- Linhas 18 a 38:
18: * Incluir/Alterar/Excluir (o legado SIGOPARQ.SCX nao os tem).
19: *
20: * Fase 5/8: Optiongroup1 (obj_4c_Optiongroup1: Linha / Grupo de Produto) e
21: * Label1 (lbl_4c_Label1: "Exportacao do Setor :"). Sao os dois unicos
22: * objetos visuais que faltavam no legado (ja cobre 100% da arvore do
23: * dump).
24: *
25: * Fase 6/8: fiacao dos eventos interativos que faltavam. Este form NAO tem
26: * nenhum TextBox de campo digitavel (os Text1 das Columns2/3 sao so
27: * leitura) e o dump nao contem fwBuscaExt/fwBuscaSel/sigacess em lugar
28: * nenhum - NAO HA lookup F4/F5 para implementar (analise.json.lookups = []).
29: * O trabalho real desta fase eh completar os 4 PROCEDUREs do
30: * comportamento.json ainda sem handler no migrado:
31: *   - Grid1.Column1.Check1.InteractiveChange -> chk_4c_Marca (toggle manual
32: *     via KeyPress/MouseUp/MouseDown/Click + NODEFAULT, regra do projeto
33: *     para CheckBox dentro de Column de Grid nao alternar pelo binding
34: *     nativo quando a coluna destino eh NUMERIC)
35: *   - Optiongroup1.InteractiveChange -> obj_4c_Optiongroup1
36: *   - Commandgroup1.Command1.Click (Gerar) -> Buttons(1)
37: *   - Commandgroup1.Command2.Click (Encerrar) -> Buttons(2)
38: *

*-- Linhas 87 a 95:
87: *   6) Optiongroup1.InteractiveChange -> OptTiposInteractiveChange().
88: *
89: * O que NAO se aplica a este layout, e por que: este form OPERACIONAL eh um
90: * dialogo de 1 tela (grid + checkbox + optiongroup + 2 botoes) sem Page1=
91: * Lista/Page2=Dados, sem modo INCLUIR/ALTERAR/VISUALIZAR e sem campos de
92: * cadastro. O dump legado nao tem botao de busca, nem botao de gravar, nem
93: * troca de modo - logo BtnBuscarClick, BtnSalvarClick, HabilitarCampos,
94: * LimparCampos e AjustarBotoesPorModo nao tem a que se referir aqui.
95: * Cria-los seria inventar funcionalidade ausente no original (viola o

*-- Linhas 135 a 143:
135:             *-- Cria Business Object
136:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpArqBO")
137: 
138:             THIS.Caption = "Gera" + CHR(231) + CHR(227) + "o de Arquivos"
139: 
140:             *-- Constroi os controles visuais (cabecalho + Grid + botoes de
141:             *-- acao nesta fase; OptionGroup/Label entram na Fase 5-6)
142:             THIS.ConfigurarControles()
143: 

*-- Linhas 218 a 227:
218:         loc_oGrid.RecordSource = "cursor_4c_Dados"
219: 
220:         WITH loc_oGrid
221:             .Top            = 85
222:             .Left           = 60
223:             .Width          = 469
224:             .Height         = 83
225:             .FontName       = "Tahoma"
226:             .FontSize       = 8
227:             .AllowRowSizing = .F.

*-- Linhas 242 a 271:
242:             .Column1.Sparse        = .F.
243:             .Column1.FontName      = "Tahoma"
244:             .Column1.FontSize      = 8
245:             .Column1.Header1.Caption   = ""
246:             .Column1.Header1.FontName  = "Tahoma"
247:             .Column1.Header1.FontSize  = 8
248:             .Column1.Header1.ForeColor = RGB(36, 84, 155)
249: 
250:             .Column1.AddObject("chk_4c_Marca", "CheckBox")
251:             WITH .Column1.chk_4c_Marca
252:                 .Top       = 35
253:                 .Left      = 37
254:                 .Height    = 17
255:                 .Width     = 60
256:                 .FontName  = "Tahoma"
257:                 .FontSize  = 8
258:                 .Alignment = 0
259:                 .Caption   = "..."
260:                 .Style     = 1
261:                 .ReadOnly  = .F.
262:                 .Visible   = .T.
263:             ENDWITH
264:             .Column1.CurrentControl = "chk_4c_Marca"
265: 
266:             *-- CheckBox dentro de Column de Grid NAO alterna pelo binding
267:             *-- nativo quando a coluna destino eh NUMERIC (Marcas N(1,0)) -
268:             *-- toggle manual via KeyPress/MouseUp, com MouseDown/Click so
269:             *-- para suprimir o toggle nativo (NODEFAULT nos 4).
270:             BINDEVENT(.Column1.chk_4c_Marca, "KeyPress",   THIS, "ChkMarcaKeyPress")
271:             BINDEVENT(.Column1.chk_4c_Marca, "MouseUp",    THIS, "ChkMarcaMouseUp")

*-- Linhas 283 a 291:
283:             .Column2.ReadOnly      = .T.
284:             .Column2.FontName      = "Tahoma"
285:             .Column2.FontSize      = 8
286:             .Column2.Header1.Caption   = "Arquivo"
287:             .Column2.Header1.Alignment = 2
288:             .Column2.Header1.FontName  = "Tahoma"
289:             .Column2.Header1.FontSize  = 8
290:             .Column2.Header1.ForeColor = RGB(36, 84, 155)
291:             .Column2.Text1.BorderStyle = 0

*-- Linhas 303 a 311:
303:             .Column3.ReadOnly      = .T.
304:             .Column3.FontName      = "Tahoma"
305:             .Column3.FontSize      = 8
306:             .Column3.Header1.Caption   = "Nome do Arquivo"
307:             .Column3.Header1.Alignment = 2
308:             .Column3.Header1.FontName  = "Tahoma"
309:             .Column3.Header1.FontSize  = 8
310:             .Column3.Header1.ForeColor = RGB(36, 84, 155)
311:             .Column3.Text1.BorderStyle = 0

*-- Linhas 326 a 375:
326:     PROTECTED PROCEDURE ConfigurarBotoes()
327:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
328:         WITH THIS.cmg_4c_Botoes
329:             .Top           = -2
330:             .Left          = 644
331:             .Width         = 160
332:             .Height        = 85
333:             .ButtonCount   = 2
334:             .BackStyle     = 0
335:             .BorderStyle   = 0
336:             .SpecialEffect = 1
337:             .BorderColor   = RGB(136, 189, 188)
338:             .Value         = 1
339: 
340:             WITH .Buttons(1)
341:                 .Top       = 5
342:                 .Left      = 5
343:                 .Width     = 75
344:                 .Height    = 75
345:                 .FontBold  = .T.
346:                 .FontItalic = .T.
347:                 .FontName  = "Comic Sans MS"
348:                 .FontSize  = 8
349:                 .WordWrap  = .T.
350:                 .Picture   = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
351:                 .Caption   = "Gerar"
352:                 .ForeColor = RGB(90, 90, 90)
353:                 .BackColor = RGB(255, 255, 255)
354:                 .Themes    = .F.
355:                 .Visible   = .T.
356:             ENDWITH
357: 
358:             WITH .Buttons(2)
359:                 .Top       = 5
360:                 .Left      = 80
361:                 .Width     = 75
362:                 .Height    = 75
363:                 .FontBold  = .T.
364:                 .FontItalic = .T.
365:                 .FontName  = "Comic Sans MS"
366:                 .FontSize  = 8
367:                 .WordWrap  = .T.
368:                 .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
369:                 .Cancel    = .T.
370:                 .Caption   = "Encerrar"
371:                 .ForeColor = RGB(90, 90, 90)
372:                 .BackColor = RGB(255, 255, 255)
373:                 .Themes    = .F.
374:                 .Visible   = .T.
375:             ENDWITH

*-- Linhas 396 a 405:
396:     PROTECTED PROCEDURE ConfigurarCampos()
397:         THIS.AddObject("obj_4c_Optiongroup1", "OptionGroup")
398:         WITH THIS.obj_4c_Optiongroup1
399:             .Top           = 166
400:             .Left          = 202
401:             .Width         = 189
402:             .Height        = 28
403:             .ButtonCount   = 2
404:             .BackStyle     = 0
405:             .SpecialEffect = 1

*-- Linhas 411 a 436:
411:                 .FontName  = "Comic Sans MS"
412:                 .FontSize  = 8
413:                 .BackStyle = 0
414:                 .Caption   = " Linha"
415:                 .Top       = 7
416:                 .Left      = 5
417:                 .Width     = 46
418:                 .Height    = 15
419:                 .AutoSize  = .T.
420:                 .ForeColor = RGB(90, 90, 90)
421:                 .Themes    = .F.
422:             ENDWITH
423: 
424:             *-- Buttons(2) = "Grupo de Produto" (SigCdGrp) - this_nTipos = 2
425:             WITH .Buttons(2)
426:                 .FontName  = "Comic Sans MS"
427:                 .FontSize  = 8
428:                 .BackStyle = 0
429:                 .Caption   = " Grupo de Produto"
430:                 .Top       = 7
431:                 .Left      = 63
432:                 .Width     = 106
433:                 .Height    = 15
434:                 .AutoSize  = .T.
435:                 .ForeColor = RGB(90, 90, 90)
436:                 .Themes    = .F.

*-- Linhas 447 a 464:
447:         *-- Label1 do legado: nao declara Width/Alignment no dump = classe
448:         *-- "say" pura (regra #23) -> AutoSize = .F. + Width/Height
449:         *-- transcritos do SCX (AutoSize = .T. e no-op em Label via AddObject)
450:         THIS.AddObject("lbl_4c_Label1", "Label")
451:         WITH THIS.lbl_4c_Label1
452:             .AutoSize  = .F.
453:             .Alignment = 0
454:             .FontName  = "Tahoma"
455:             .FontSize  = 8
456:             .BackStyle = 0
457:             .Caption   = "Exporta" + CHR(231) + CHR(227) + "o  do Setor :"
458:             .Top       = 172
459:             .Left      = 67
460:             .Width     = 111
461:             .Height    = 15
462:             .ForeColor = RGB(90, 90, 90)
463:             .Visible   = .T.
464:         ENDWITH

*-- Linhas 792 a 843:
792:     * ConfigurarPageFrame - Container cabecalho (cntSombra do legado): fundo
793:     * cinza + labels de titulo. Forms OPERACIONAIS nao usam PageFrame de
794:     * abas CRUD; este metodo agrupa a faixa fixa do topo do form.
795:     *==========================================================================
796:     PROTECTED PROCEDURE ConfigurarPageFrame()
797:         THIS.AddObject("cnt_4c_Sombra", "Container")
798:         WITH THIS.cnt_4c_Sombra
799:             .Top         = 0
800:             .Left        = 0
801:             .Width       = THIS.Width
802:             .Height      = 80
803:             .BackStyle   = 1
804:             .BackColor   = RGB(100, 100, 100)
805:             .BorderWidth = 0
806:             .Visible     = .T.
807: 
808:             .AddObject("lbl_4c_Sombra", "Label")
809:             WITH .lbl_4c_Sombra
810:                 .Top       = 18
811:                 .Left      = 10
812:                 .Width     = THIS.Width
813:                 .Height    = 40
814:                 .FontBold  = .T.
815:                 .FontName  = "Tahoma"
816:                 .FontSize  = 18
817:                 .BackStyle = 0
818:                 .ForeColor = RGB(0, 0, 0)
819:                 .WordWrap  = .T.
820:                 .Alignment = 0
821:                 .Caption   = THIS.Caption
822:                 .Visible   = .T.
823:             ENDWITH
824: 
825:             .AddObject("lbl_4c_Titulo", "Label")
826:             WITH .lbl_4c_Titulo
827:                 .Top       = 17
828:                 .Left      = 10
829:                 .Width     = THIS.Width
830:                 .Height    = 46
831:                 .FontBold  = .T.
832:                 .FontName  = "Tahoma"
833:                 .FontSize  = 18
834:                 .BackStyle = 0
835:                 .ForeColor = RGB(255, 255, 255)
836:                 .WordWrap  = .T.
837:                 .Alignment = 0
838:                 .Caption   = THIS.Caption
839:                 .Visible   = .T.
840:             ENDWITH
841:         ENDWITH
842:     ENDPROC
843: 


### BO (C:\4c\projeto\app\classes\SigOpArqBO.prg):
*==============================================================================
* SigOpArqBO.prg - Business Object para Geracao de Arquivos (Exportacao)
* Form OPERACIONAL - nao segue padrao CRUD Page1=Lista/Page2=Dados
* Legado: SIGOPARQ.SCX (form filho, compartilhava DataSession com o form pai
*         via Lparameters poForm e operava sobre o cursor crGerArq)
* Tabela principal de referencia (dinamica conforme Tipos): SigCdLin / SigCdGrp
*==============================================================================

DEFINE CLASS SigOpArqBO AS BusinessBase

    *-- Tipo de exportacao selecionado (Optiongroup1.Value / ParentForm.pnTipos)
    *-- 1 = Linha (SigCdLin, chave linhas)
    *-- 2 = Grupo de Produto (SigCdGrp, chave cgrus)
    this_nTipos = 1

    *--------------------------------------------------------------------------
    * DECISAO DE PROJETO: BO somente-leitura no SQL Server
    *
    * O dump do legado (SigOpArq_form_codigo_fonte.txt) nao grava em nenhuma
    * tabela remota. Os unicos Replace do form (Check1.InteractiveChange e
    * Commandgroup1.Command2.Click) alteram so o cursor LOCAL crGerArq,
    * compartilhado por DataSession com o form pai (Lparameters poForm +
    * ThisForm.DataSessionId = poForm.DataSessionId). O botao "Gerar"
    * (Command1.Click) apenas valida a selecao e confirma com o usuario,
    * terminando em "Release Windows" - sem nenhum Insert/Update/Delete. A
    * gravacao real dos arquivos fica a cargo do form pai, depois deste
    * dialogo fechar.
    *
    * Por isso este BO nao sobrescreve Inserir()/Atualizar() - o
    * comportamento herdado de BusinessBase (que recusa a gravacao) ja eh o
    * correto aqui. CarregarDoCursor() so mapeia this_nTipos (abaixo). A
    * "gravacao" deste form inteira em cursor_4c_Dados (equivalente local a
    * crGerArq) acontece via MarcarItemParaExportacao/DesmarcarItem/
    * LimparSelecoes.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.AtualizarTipoExportacao(1)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTipoExportacao - Troca o tipo de item exportavel (Optiongroup1)
    * e a tabela/chave correspondente. Espelha Optiongroup1.InteractiveChange
    * do legado (ThisForm.ParentForm.pnTipos = This.Value), mas resolve aqui
    * tambem a tabela de origem, que no legado o form pai conhecia de fora.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTipoExportacao(par_nTipos)
        IF VARTYPE(par_nTipos) != "N" OR !INLIST(par_nTipos, 1, 2)
            RETURN .F.
        ENDIF

        THIS.this_nTipos = par_nTipos

        IF THIS.this_nTipos = 2
            THIS.this_cTabela     = "SigCdGrp"
            THIS.this_cCampoChave = "cgrus"
        ELSE
            THIS.this_cTabela     = "SigCdLin"
            THIS.this_cCampoChave = "linhas"
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega this_nTipos de um cursor externo (padrao
    * generico de BusinessBase). Este BO nao tem outras propriedades escalares
    * de entidade - os dados de grade vivem em cursor_4c_Dados, tratado pelos
    * metodos de Buscar/Marcar abaixo.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF TYPE(par_cAliasCursor + ".tipos") != "U"
            THIS.AtualizarTipoExportacao(NVL(EVALUATE(par_cAliasCursor + ".tipos"), 1))
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Popula cursor_4c_Dados com os itens exportaveis do tipo
    * corrente (this_nTipos). Nao ha conceito de filtro no legado (o Grid1
    * sempre lista o universo inteiro do tipo escolhido no Optiongroup1) -
    * par_cFiltro existe so para manter a assinatura canonica do projeto.
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        IF THIS.this_nTipos = 2
            RETURN THIS.BuscarGrupos()
        ENDIF

        RETURN THIS.BuscarLinhas()
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarLinhas - Itens exportaveis quando this_nTipos = 1 (SigCdLin)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarLinhas()
        LOCAL loc_cSQL
        loc_cSQL = "SELECT linhas AS Codigos, descs AS Descricao " + ;
                   "FROM SigCdLin " + ;
                   "ORDER BY descs"

        RETURN THIS.CarregarItensGrade(loc_cSQL)
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Itens exportaveis quando this_nTipos = 2 (SigCdGrp)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarGrupos()
        LOCAL loc_cSQL
        loc_cSQL = "SELECT cgrus AS Codigos, dgrus AS Descricao " + ;
                   "FROM SigCdGrp " + ;
                   "ORDER BY dgrus"

        RETURN THIS.CarregarItensGrade(loc_cSQL)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItensGrade - Executa par_cSQL num cursor TEMPORARIO e rebalanca
    * cursor_4c_Dados a partir dele, preservando a estrutura (Marcas/NomArqs)
    * que o Grid da pagina usa - nunca SQLEXEC direto no alias do Grid (regra
    * do projeto: SQLEXEC sobre alias ligado a Grid zera o ColumnCount).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarItensGrade(par_cSQL)
        LOCAL loc_lResultado, loc_nResultado, loc_cCursorTemp
        loc_lResultado  = .F.
        loc_cCursorTemp = "cursor_4c_ItensExpTemp"

        TRY
            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, loc_cCursorTemp)

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    ZAP
                    APPEND FROM DBF(loc_cCursorTemp)
                ELSE
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (Codigos C(10), Descricao C(40), Marcas N(1,0), NomArqs C(254))
                    SET NULL OFF
                    SELECT cursor_4c_Dados
                    APPEND FROM DBF(loc_cCursorTemp)
                ENDIF

                REPLACE ALL Marcas WITH 0, NomArqs WITH "" IN cursor_4c_Dados
                GO TOP IN cursor_4c_Dados

                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar itens para exporta" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro: " + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "SigOpArqBO.CarregarItensGrade")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarItemParaExportacao - Espelha Check1.InteractiveChange do legado:
    * valida a pasta de destino (DIRECTORY()/MD direto - fverificapasta.prg eh
    * wrapper so para p-code legado compilado, regra do projeto), recusa nome
    * de arquivo repetido entre as linhas e marca o item corrente da grade.
    *--------------------------------------------------------------------------
    PROCEDURE MarcarItemParaExportacao(par_cCaminhoArquivo)
        LOCAL loc_lResultado, loc_cPasta, loc_nRecnoAtual, loc_cCaminho
        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            THIS.this_cMensagemErro = "Nenhum item selecionado na grade."
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCaminhoArquivo) != "C" OR EMPTY(ALLTRIM(par_cCaminhoArquivo))
            THIS.this_cMensagemErro = "Destino Inv" + CHR(225) + "lido !!!"
            RETURN .F.
        ENDIF

        loc_cCaminho = ALLTRIM(par_cCaminhoArquivo)
        loc_cPasta   = JUSTPATH(loc_cCaminho)

        TRY
            IF !EMPTY(loc_cPasta) AND !DIRECTORY(loc_cPasta)
                MD (loc_cPasta)
            ENDIF

            IF !EMPTY(loc_cPasta) AND !DIRECTORY(loc_cPasta)
                THIS.this_cMensagemErro = "Local ou Arquivo Inv" + CHR(225) + "lido !!!"
            ELSE
                SELECT cursor_4c_Dados
                loc_nRecnoAtual = RECNO()

                LOCATE FOR ALLTRIM(NomArqs) == loc_cCaminho AND RECNO() != loc_nRecnoAtual
                IF FOUND()
                    THIS.this_cMensagemErro = "Nome Arquivo J" + CHR(225) + " Informado !!!"
                    GOTO loc_nRecnoAtual
                ELSE
                    GOTO loc_nRecnoAtual
                    REPLACE Marcas WITH 1, NomArqs WITH loc_cCaminho
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao validar destino: " + loException.Message
            MsgErro(THIS.this_cMensagemErro, "SigOpArqBO.MarcarItemParaExportacao")
            *-- regra #20: ja mostrou a falha - o chamador nao deve repetir
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarItem - Desfaz a marcacao do item corrente da grade (usado
    * quando a validacao falha, espelhando os "Replace nMarcas With 0" do
    * legado dentro do proprio InteractiveChange).
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarItem()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN .F.
        ENDIF

        REPLACE Marcas WITH 0, NomArqs WITH "" IN cursor_4c_Dados

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteItemSelecionado - Espelha "Locate for nMarcas = 1" do
    * Commandgroup1.Command1/Command2.Click (botoes Gerar/Encerrar).
    *--------------------------------------------------------------------------
    PROCEDURE ExisteItemSelecionado()
        LOCAL loc_nRecnoAtual, loc_lResultado
        loc_lResultado = .F.

        IF USED("cursor_4c_Dados")
            loc_nRecnoAtual = RECNO("cursor_4c_Dados")

            SELECT cursor_4c_Dados
            LOCATE FOR Marcas = 1
            loc_lResultado = FOUND()

            IF BETWEEN(loc_nRecnoAtual, 1, RECCOUNT("cursor_4c_Dados"))
                GOTO loc_nRecnoAtual
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparSelecoes - Espelha "Replace All nMarcas With 0" do
    * Commandgroup1.Command2.Click (Encerrar, apos confirmar o cancelamento).
    *--------------------------------------------------------------------------
    PROCEDURE LimparSelecoes()
        IF !USED("cursor_4c_Dados")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        REPLACE ALL Marcas WITH 0, NomArqs WITH ""
        GO TOP

        RETURN .T.
    ENDPROC

ENDDEFINE

