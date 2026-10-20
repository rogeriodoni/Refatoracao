*==============================================================================
* FormSIGOPBIN.prg - Validacao de BIN do cartao para liberacao de pagamento
* Form OPERACIONAL FLAT (sem PageFrame) - dialogo modal de entrada unica.
* Chamada: CREATEOBJECT("FormSIGOPBIN", cFpagto)
* Herda de: FormBase
*
* Legado (SIGOPBIN.SCX): BaseClass = form (generico), sem PageFrame, sem
* grid, sem botao algum. Um unico TextBox (Get_Bin) recebe o BIN digitado; o
* Valid consulta SigOpFpb e fecha o form (ThisForm.Release) definindo o
* resultado em ThisForm.ZSen/UsuLibs, lido pelo Unload do form chamador
* (Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs).
*
* Historico de fases:
*   Fase 1/2: SIGOPBINBO.prg (propriedades + ValidarBin + ObterResultadoSaida)
*   Fase 3:   FormSIGOPBIN.prg - estrutura base (Init, InicializarForm,
*             ConfigurarPageFrame com cnt_4c_Sombra/lbl_4c_LblSombra/
*             lbl_4c_LblTitulo). Form FLAT: o legado nao tem PageFrame nem
*             Page nenhuma - nenhum pgf_4c_* eh criado neste form.
*   Fase 4/8 (CONCLUIDA COMO NO-OP JUSTIFICADO): nao ha Grid nem botoes
*             CRUD a acrescentar - analise.json/layout.json nao declaram
*             grid nem PageFrame, e o SCX legado (SIGOPBIN) nao tem UM
*             botao sequer: a arvore inteira eh Form + Frase (Label) +
*             Say2 (Label) + Get_Bin (TextBox) + cntSombra decorativo. O
*             dialogo fecha pelo Valid do proprio Get_Bin (consulta SQL +
*             ThisForm.Release) ou pelo KeyPress dele (ESC com campo
*             vazio) - nunca por um botao Confirmar/Encerrar. Este eh um
*             dialogo FLAT de CAPTURA (1 campo editavel, sem lista, sem
*             botao) - mesma familia do SIGMVVDE/FormSigMvVde e do
*             SIGOPATU/FormSigOpAtu, documentada no gate da Fase 4 do
*             OrquestradorMigracao.ps1 (ramo "layout captura"). Inventar
*             Page1/Grid/6 botoes CRUD aqui violaria o PILAR 1 (o legado
*             eh um popup de 600x200 com 1 campo, nao um cadastro) e a
*             regra "NUNCA inventar" (CLAUDE.md). lbl_4c_Frase,
*             lbl_4c_Label2 e txt_4c_Bin (com o Valid/KeyPress) ficam
*             para as Fases 5 a 7 (campos + evento).
*   Fase 5/8 (Parte 1): ConfigurarPaginaDados() - lbl_4c_Frase e
*             lbl_4c_Label2 (labels de instrucao, filhos diretos de THIS -
*             form FLAT). txt_4c_Bin (com Valid/KeyPress) entra na
*             Fase 6/8, descrita abaixo.
*   Fase 6/8: txt_4c_Bin (Get_Bin) criado em ConfigurarPaginaDados(). NAO
*             HA LOOKUP neste campo - o legado nao abre fwBuscaExt/sigacess
*             algum (conferido em tasks\task646\SIGOPBIN_form_codigo_fonte.txt
*             e tasks\task646\comportamento.json: temLookup = false nos 5
*             metodos). O Get_Bin.Valid SEMPRE termina em ThisForm.Release
*             (achou e vigente, achou fora da vigencia, nao achou, falha de
*             conexao OU campo vazio) - eh um dialogo de UMA tentativa so,
*             nao um campo com retry/picker. Equivalente migrado:
*             ValidarCampoBin() (chama SIGOPBINBO.ValidarBin() e fecha o
*             form), ligado via BINDEVENT KeyPress testando ENTER(13)/TAB(9)
*             - BINDEVENT "Valid" nao dispara de forma confiavel em TextBox
*             (regra conhecida do projeto). O KeyPress legado (ESC com
*             campo vazio) tambem delega para ValidarCampoBin(), que trata
*             EMPTY() do mesmo jeito do ramo "If Empty(This.Value)" do Valid.
*   Fase 7/8 (CONCLUIDA COMO NO-OP JUSTIFICADO): os quatro nomes
*             canonicos BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
*             BtnExcluirClick NAO existem aqui, e isso eh deliberado: sao a
*             barra CRUD da Page1 do frmcadastro, e este legado nao tem CRUD
*             nenhum (Class: form puro, sem frmcadastro, sem Grupo_Op, sem
*             pcEscolha, sem X.Click de verbo CRUD). A arvore inteira do dump
*             (tasks\task646\layout.json/SIGOPBIN_form_codigo_fonte.txt) eh
*             Form + Frase (Label) + Say2 (Label) + Get_Bin (TextBox) +
*             cntSombra decorativo - NENHUM CommandButton existe no legado
*             (diferente do SIGOPATU/FormSigOpAtu, que tem o Command1/"Ok").
*             O dialogo fecha exclusivamente pelo Valid/KeyPress do proprio
*             Get_Bin, cujo equivalente (ValidarCampoBin/BinKeyPress) ja foi
*             entregue na Fase 6/8 e ja termina em THIS.Release() em TODOS
*             os caminhos (achou e vigente, achou fora da vigencia, nao
*             achou, falha de conexao, campo vazio, ESC) - exatamente como o
*             "Thisform.release" incondicional no fim do Valid legado.
*             Inventar os 4 botoes CRUD aqui so poderia gerar metodo vazio
*             (nao ha Grid/lista para Incluir/Alterar/Visualizar/Excluir
*             operarem sobre), o que o pipeline proibe, e violaria o PILAR 1
*             (o legado eh um popup de 600x200 com 1 campo, nao um
*             cadastro). Nao sobra "evento principal" em aberto: o unico
*             evento do dump (Get_Bin.Valid) ja esta completo.
*   Fase 8/8: consolidacao final. FormParaBO() e BOParaForm() implementados
*             DE VERDADE (hooks PROTECTED que FormBase.Salvar/Cancelar
*             chamam por THIS.) - sao a camada de transferencia do PILAR 3
*             para o unico campo do dialogo: FormParaBO le txt_4c_Bin e
*             alimenta SIGOPBINBO.this_cCodBins (chamado por
*             ValidarCampoBin, no caminho VIVO do form), e BOParaForm faz o
*             contrario, inicializando o controle a partir do BO no fim de
*             ConfigurarPaginaDados. Declarados PROTECTED EXPLICITO porque
*             FormBase ja os declara assim e o VFP9 nao deixa a subclasse
*             ALARGAR escopo - omitir o modificador mentiria para quem le.
*
*             Os demais nomes do roteiro padrao NAO existem aqui, e isso eh
*             deliberado - o legado (SIGOPBIN.SCX) nao tem UM botao sequer
*             (arvore completa: Form + Frase/Say2 (Labels) + Get_Bin
*             (TextBox) + cntSombra decorativo com 2 Labels), nao tem Grid,
*             nao tem PageFrame e nao tem modo CRUD:
*               - BtnSalvarClick/BtnConfirmarClick/BtnCancelarClick/
*                 BtnBuscarClick/BtnEncerrarClick: nao ha botao nenhum no
*                 SCX. O dialogo fecha pelo Valid/KeyPress do proprio
*                 Get_Bin (ValidarCampoBin/BinKeyPress, Fases 6 e 7), que
*                 termina em THIS.Release() em TODOS os caminhos - igual ao
*                 "Thisform.release" incondicional no fim do Valid legado.
*                 Criar qualquer um deles exigiria INVENTAR um botao
*                 (viola o PILAR 1) ou gerar corpo vazio (proibido pela
*                 regra de completude).
*               - CarregarLista/AjustarBotoesPorModo: nao ha grid nem
*                 Page1 de "Lista", nem barra de botoes cujo Enabled
*                 dependa de modo (a regra #40 nao se aplica: nao existe
*                 "modo" neste dialogo).
*               - LimparCampos/HabilitarCampos: o dialogo eh de UMA
*                 tentativa so (Release() sempre no fim) e eh destruido ao
*                 fechar, nunca reaproveitado - nao ha segundo registro
*                 para limpar nem modo INCLUIR/ALTERAR/VISUALIZAR para
*                 habilitar.
*
*             Familia "dialogo de ENTRADA (input-box) sem botao algum" -
*             mesma do SIGPRIFF/FormSIGPRIFF. Ramo $legadoEntradaSemBotaoF8
*             do gate da Fase 8 (automation\OrquestradorMigracao.ps1).
*==============================================================================
DEFINE CLASS FormSIGOPBIN AS FormBase

    *-- Parametro de entrada recebido no Init (equivale a ThisForm.Fpagto)
    this_cFpagto = ""

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPBIN)
    Width       = 600
    Height      = 200
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    BorderStyle = 2
    Caption     = ""
    BackColor   = RGB(231, 242, 254)

    *--------------------------------------------------------------------------
    * Init - Recebe a condicao de pagamento (equivale ao LPARAMETERS pPag do
    * PROCEDURE Init legado) e cria o Business Object antes de inicializar
    * a parte visual (DODEFAULT -> FormBase.Init -> THIS.InicializarForm).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cFpagto)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cFpagto = IIF(VARTYPE(par_cFpagto) = "C", ALLTRIM(par_cFpagto), "")

            THIS.this_oBusinessObject = CREATEOBJECT("SIGOPBINBO", THIS.this_cFpagto)
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SIGOPBINBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSIGOPBIN.Init")
            ELSE
                *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPBIN.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta a estrutura visual base
    * (chamado por FormBase.Init via DODEFAULT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form (imagem do Framework Fortyus legado)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Monta o cabecalho (unico elemento estrutural deste form FLAT)
            THIS.ConfigurarPageFrame()

            *-- Monta os labels de instrucao (campos de dados - Fase 5/8 Parte 1)
            THIS.ConfigurarPaginaDados()

            *-- Torna a arvore de controles visivel (AddObject cria com Visible=.F.)
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPBIN.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria o cabecalho (cnt_4c_Sombra + labels).
    *   Form OPERACIONAL FLAT: o legado (SIGOPBIN.SCX) nao tem PageFrame nem
    *   Page nenhuma - todos os controles sao filhos diretos do form. Nome do
    *   metodo mantido por convencao do orquestrador de migracao (nenhum
    *   AddObject("pgf_4c_...") eh feito aqui).
    *   Demais controles do legado (Frase, Say2, Get_Bin) entram em fase
    *   posterior (campos de dados).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oCab, loc_oErro
        TRY
            *-- cntSombra original: Top=0, Left=0, Width=800 (-> THIS.Width), Height=80
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCab = THIS.cnt_4c_Sombra
            WITH loc_oCab
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
            ENDWITH

            *-- Labels adicionados FORA do WITH do container (WITH aninhado com
            *-- AddObject ignora propriedades silenciosamente - regra conhecida)
            loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCab.lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .AutoSize      = .F.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = "Cadastro de Testes"
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
            ENDWITH

            loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCab.lbl_4c_LblTitulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = "Cadastro de Testes"
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = 769
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPBIN.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria os campos de dados do dialogo: os labels
    *   de instrucao (Fase 5/8) e o TextBox Get_Bin com o Valid/KeyPress que
    *   fecha o dialogo (Fase 6/8). Form FLAT (sem PageFrame/Page) - os
    *   controles sao filhos diretos de THIS, igual ao legado (Frase, Say2 e
    *   Get_Bin sao filhos diretos de SIGOPBIN).
    *
    *   Mapeamento (tasks\task646\mapeamento.json):
    *     SIGOPBIN.Frase  -> lbl_4c_Frase
    *     SIGOPBIN.Say2   -> lbl_4c_Label2
    *     SIGOPBIN.Get_Bin -> txt_4c_Bin
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro
        TRY
            *-- Frase: classe "say", AutoSize = .F. explicito no dump legado
            THIS.AddObject("lbl_4c_Frase", "Label")
            WITH THIS.lbl_4c_Frase
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .WordWrap  = .T.
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Informe os 6 Primeiros D" + CHR(237) + ;
                    "gitos do Cart" + CHR(227) + "o (BIN)"
                .Height    = 34
                .Left      = 145
                .Top       = 110
                .Width     = 310
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 1
            ENDWITH

            *-- Say2: classe "say" PURA (sem Width/Alignment no dump) - regra
            *-- #23: AutoSize=.T. e no-op em Label via AddObject, entao usar
            *-- Alignment=0 + Width explicita medida para o texto (nao inventar
            *-- Alignment=1). Get_Bin.Left=283 -> Width=63 encosta no campo.
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "C" + CHR(243) + "digo BIN:"
                .Height    = 17
                .Left      = 216
                .Top       = 151
                .Width     = 63
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 2
            ENDWITH

            *-- Get_Bin: unico campo editavel do dialogo. Sem ControlSource
            *-- (o legado tambem nao tem - This.Value eh lido direto no Valid).
            *-- InputMask/MaxLength: coluna real eh SigOpFpb.CodBins char(6)
            *-- (docs/schema.sql) - o dump do SCX declara InputMask com 10
            *-- "!" (forca maiuscula por posicao); MaxLength = 6 alinha com a
            *-- largura real da coluna (regra "MaxLength vem da largura da
            *-- coluna no schema"), sem descartar o InputMask do legado.
            THIS.AddObject("txt_4c_Bin", "TextBox")
            WITH THIS.txt_4c_Bin
                .Value      = ""
                .Alignment  = 3
                .InputMask  = "!!!!!!!!!!"
                .MaxLength  = 6
                .Left       = 283
                .Top        = 147
                .Width      = 58
                .ForeColor  = RGB(0, 0, 0)
                .TabIndex   = 3
            ENDWITH

            *-- BINDEVENT precisa do objeto ja criado (feito acima)
            BINDEVENT(THIS.txt_4c_Bin, "KeyPress", THIS, "BinKeyPress")

            *-- Valor inicial do controle vem do BO (fonte unica), nao de literal
            THIS.BOParaForm()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPBIN.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BinKeyPress - Equivalente ao PROCEDURE KeyPress do Get_Bin legado
    * (If (Lastkey() = 27) And Empty(This.Value) ... ThisForm.Release), mais
    * ENTER/TAB simulando o Valid (BINDEVENT "Valid" nao dispara de forma
    * confiavel em TextBox). PUBLIC (sem PROTECTED) - BINDEVENT exige metodo
    * publico.
    *--------------------------------------------------------------------------
    PROCEDURE BinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27 AND EMPTY(THIS.txt_4c_Bin.Value)
            *-- ESC com campo vazio: mesmo ramo "Empty(This.Value)" do Valid
            THIS.ValidarCampoBin()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarCampoBin()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCampoBin - Equivalente ao PROCEDURE Valid do Get_Bin legado.
    * Consulta SigOpFpb (via SIGOPBINBO.ValidarBin) e SEMPRE fecha o dialogo
    * ao final - "Thisform.release" eh a ultima linha do Valid legado e roda
    * em TODOS os caminhos (achou e vigente, achou fora da vigencia, nao
    * achou, falha de conexao, campo vazio). O form chamador le o resultado
    * depois do Show() via THIS.ObterResultadoSaida().
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCampoBin()
        LOCAL loc_cValor, loc_lProsseguir, loc_oErro
        loc_lProsseguir = .T.

        TRY
            *-- Transfere o valor digitado para o BO pelo hook do FormBase.
            *-- O legado le "This.Value" direto no Valid; no PILAR 3 esse
            *-- acesso mora em FormParaBO (camada de transferencia).
            THIS.FormParaBO()
            loc_cValor = THIS.this_oBusinessObject.this_cCodBins

            *-- If Empty(This.Value) -> ZSen = .f. / ThisForm.Release
            IF EMPTY(loc_cValor)
                THIS.this_oBusinessObject.this_lZSen = .F.
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                THIS.this_oBusinessObject.ValidarBin(loc_cValor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPBIN.ValidarCampoBin")
        ENDTRY

        *-- "Thisform.release" (ultima linha do Valid legado, fora do IF/ELSE)
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Hook PROTECTED do FormBase (chamado por FormBase.Salvar e,
    * neste form, por ValidarCampoBin). Transfere o unico campo editavel do
    * dialogo (txt_4c_Bin) para a property correspondente do Business Object
    * (SigOpFpb.codbins char(6) - docs/schema.sql).
    *
    * PROTECTED EXPLICITO: FormBase ja declara este hook como PROTECTED e o
    * VFP9 NAO permite que a subclasse ALARGUE o escopo - escrever
    * "PROCEDURE FormParaBO" sem o modificador nao o tornaria publico, so
    * esconderia que ele continua protegido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cCodBins = ALLTRIM(THIS.txt_4c_Bin.Value)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPBIN.FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Hook PROTECTED do FormBase (caminho inverso do FormParaBO).
    * Reflete no controle o BIN que o Business Object tem no momento. Chamado
    * no fim de ConfigurarPaginaDados para que o valor inicial de txt_4c_Bin
    * venha do BO (fonte unica), e nao de um literal no meio do AddObject.
    *
    * PROTECTED EXPLICITO pelo mesmo motivo do FormParaBO acima.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.txt_4c_Bin.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodBins)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPBIN.BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_oErro
        TRY
            FOR loc_i = 1 TO par_oContainer.ControlCount
                loc_oControl = par_oContainer.Controls(loc_i)
                IF VARTYPE(loc_oControl) = "O"
                    IF PEMSTATUS(loc_oControl, "Visible", 5)
                        loc_oControl.Visible = .T.
                    ENDIF
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                       loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSIGOPBIN.TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterResultadoSaida - Equivalente ao PROCEDURE Unload do legado
    * (Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs). O form chamador le
    * este valor apos o Show() modal retornar, antes de liberar o form.
    *--------------------------------------------------------------------------
    FUNCTION ObterResultadoSaida()
        RETURN THIS.this_oBusinessObject.ObterResultadoSaida()
    ENDFUNC

ENDDEFINE
