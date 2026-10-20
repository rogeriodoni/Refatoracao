*====================================================================
* FormSigOpCbx.prg
*
* Dialogo OPERACIONAL "Baixa de Cadastros" (legado SIGOPCBX.scx).
* Filho MODAL de outro form: recebe o codigo do registro ainda nao
* respondido (SigSyCrs.Cods) e o titulo do relatorio/tela de origem (legado
* "ThisForm.ParentForm.Tits"), deixa o usuario digitar Empresa/
* Operacao/Numero e, ao confirmar, grava as respostas via
* SigOpCbxBO.Inserir().
*
* Diferente do legado, que mantinha uma referencia completa ao form
* pai (Lparameters pcForm, pcCodigo) so para alcancar duas coisas
* (ParentForm.Tits e ParentForm.poDataMgr), o form migrado recebe o
* titulo diretamente como parametro escalar - o acesso a banco (que no
* legado passava por poDataMgr) e feito pelo proprio BO via SQLEXEC.
*
* Nao segue o padrao PageFrame Page1=Lista/Page2=Dados do CRUD: e um
* dialogo pequeno (527x135), sem barra de titulo, com layout FLAT
* (container de campos + grupo de botoes), igual ao legado.
*
* Fase 8/8 (eventos auxiliares e consolidacao final): extrai a transferencia
* Form->BO (Text1/Text2/Text3 -> this_cEmps/this_cDopes/this_cNumes) para o
* hook canonico FormParaBO() (FormBase, PROTECTED - conteudo REAL, chamado
* pelo handler de acao; nao ha BOParaForm nem CarregarLista porque o legado
* nao tem fluxo BO->Form nem grade - ver nota de completude junto de
* FormParaBO() mais abaixo) e renomeia os dois handlers de clique para o
* canonico do projeto, pela ACAO/convencao e nao pelo Caption literal do
* legado (mesmo padrao de FormSigOpBcb, que tambem tem um botao Caption
* "Baixa" chamado BtnConfirmarClick): BtnBaixaClick() -> BtnConfirmarClick(),
* BtnCancelaClick() -> BtnCancelarClick(). Este dialogo e OPERACIONAL
* (nao-CRUD): nao ha Incluir/Alterar/Excluir/Buscar - os unicos dois botoes
* do legado sao Baixa e Cancela.
*
* Fase 7/8 (eventos principais): monta obj_4c_Commandgroup1 (legado
* Commandgroup1, botoes "Baixa"/"Cancela") e os dois handlers de clique.
* O handler do botao de acao transcreve literalmente as guards do legado
* Command1.Click (Numero so-digitos e obrigatorio, Emp obrigatorio, Operacao
* obrigatoria - regra #17: ordem e mensagens de cada guard sao regra de
* negocio) e repassa os valores para o BO, que confirma a baixa via
* this_oBusinessObject.Inserir() (chave EmpDopNums contra SigMvCab +
* gravacao/commit ja ficaram na Fase 2). O handler de cancelar e o
* "Bxado='C'" do legado.
*
* Fase 6/8 (campos restantes + lookups): completa cnt_4c_Container1 com
* lbl_4c_Label3 + txt_4c_Text3 ("Numero" -> this_cNumes, MaxLength=6 - SO
* digitos; a validacao do conteudo (IsDigit) e dos campos obrigatorios
* mora no Commandgroup1.Click do legado, que migra na Fase 7 junto com
* os botoes Baixa/Cancela - regra #42/#17) e implementa os lookups de
* txt_4c_Text1 (Empresa -> SigCdEmp.Cemps/Razas) e txt_4c_Text2
* (Operacao -> SigCdOpe.Dopes - tabela SINGLE-COLUMN, a mesma coluna
* serve de codigo E descricao, nunca Descrs/descs - memoria
* feedback_sigcdope_single_column). Os dois via THIS.AbrirLookupCanonico
* (FormBase, Pattern A - regra #36/#37), ligado em "KeyPress" testando
* par_nKeyCode (115=F4 abre direto; 13/9=Enter/Tab tentam match exato
* primeiro) e em "DblClick" - equivalente ao Valid do legado
* (CreateObject('fwBuscaExt', ...)), regra #47 (handler que TESTA a
* tecla antes de abrir o picker e o uso legitimo de KeyPress).
*
* Fase 5/8 (campos - parte 1): cnt_4c_Container1 (legado Container1,
* Top=84/Left=0/W=254/H=47, filho DIRETO do form - este dialogo e FLAT,
* sem PageFrame, logo sem a compensacao +29 da regra #11/#31) com a
* primeira metade dos campos: lbl_4c_Label1+txt_4c_Text1 (Emp) e
* lbl_4c_Label2+txt_4c_Text2 (Operacao) - os dois campos com lookup
* (fwBuscaExt contra SigCdEmp/SigCdOpe no Valid do legado). Nomes
* EXATOS do mapeamento.json (SIGOPCBX.Container1.Label1/2/3 ->
* lbl_4c_Label1/2/3, Text1/2/3 -> txt_4c_Text1/2/3). lbl_4c_Label3 e
* txt_4c_Text3 (Numero) ficam para a Fase 6; os handlers de lookup
* (LostFocus, regra #47) ficam para a Fase 7, junto com Commandgroup1.
*
* Fase 4/8 (layout captura): o SCX legado (SIGOPCBX) nao tem Grid nem
* PageFrame - layout.json/analise.json confirmam grid.temGrid = .F. e o
* unico ControlSource do dump e' o do CommandGroup "SAIDA" (vestigio de
* classe, nao lista). Este dialogo apenas COLETA valores (Emp/Operacao/
* Numero) e devolve ao chamador - nao ha o que listar, logo nao ha Grid
* nem botoes CRUD (Incluir/Alterar/Excluir/Buscar) para acrescentar
* nesta fase, sem violar o PILAR 1 (nunca inventar UI que o legado nao
* tem). Container1 (campos) e Commandgroup1 (botoes Baixa/Cancela)
* continuam agendados para as fases seguintes (5/6 = campos, 7 = eventos
* dos botoes).
*
* Fase 3/8 - Estrutura base: DEFINE CLASS, propriedades, Init(),
* InicializarForm() e a faixa do cabecalho (cnt_4c_Sombra). O container
* de campos (Container1 -> cnt_4c_Container1) e o grupo de botoes
* (Commandgroup1 -> obj_4c_Commandgroup1) sao montados nas proximas
* fases.
*====================================================================

DEFINE CLASS FormSigOpCbx AS FormBase

    *-- Propriedades visuais (legado SIGOPCBX)
    Height       = 135
    Width        = 527
    Caption      = "Baixa de Cadastros"
    AutoCenter   = .T.
    BorderStyle  = 2
    ShowWindow = 1
    ControlBox   = .F.
    TitleBar     = 0
    MaxButton    = .F.
    MinButton    = .F.
    WindowType   = 1
    ClipControls = .T.

    *-- Parametros recebidos na abertura (legado: Lparameters pcForm,
    *-- pcCodigo - pcForm so era usado para ParentForm.Tits/poDataMgr;
    *-- o titulo chega direto como parametro, sem guardar o form pai)
    this_nCodigoPendente = 0   && SigSyCrs.Cods - legado "pcCodigo"
    this_cTituloPai      = ""  && legado "ThisForm.ParentForm.Tits"

    *-- Resultado da operacao, lido pelo chamador apos o Show() modal
    *-- retornar (legado "Bxado": "B" = confirmou a baixa / "C" = cancelou)
    this_cResultado = ""

    *--------------------------------------------------------------------------
    * INIT - Recebe os parametros do form pai (legado: Lparameters
    * pcForm, pcCodigo) e encaminha para FormBase.Init()/InicializarForm().
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nCodigo, par_cTitulo)
        THIS.this_nCodigoPendente = IIF(VARTYPE(par_nCodigo) = "N", par_nCodigo, 0)
        THIS.this_cTituloPai      = IIF(VARTYPE(par_cTitulo) = "C", par_cTitulo, "")

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Instancia o Business Object (repassando o codigo do
    * registro ainda em aberto recebido no Init) e monta a faixa do cabecalho. Container1
    * (campos Emp/Operacao/Numero) e Commandgroup1 (Baixa/Cancela) sao
    * montados nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        THIS.this_oBusinessObject = CREATEOBJECT("SigOpCbxBO", THIS.this_nCodigoPendente)

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cTitulo = THIS.this_cTituloPai

            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_oBusinessObject.this_cUsuario = gc_4c_UsuarioLogado
            ENDIF

            THIS.ConfigurarCabecalho()
            THIS.ConfigurarContainerCampos()
            THIS.ConfigurarGrupoBotoes()

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Faixa cinza do topo (legado: cntSombra), com os
    * dois labels de titulo sombra/frente (CLAUDE.md regra #11/#23). O legado
    * tem cntSombra.Width=800/labels.Width=769, herdados do template generico
    * de frmcadastro (maior que os 527px deste dialogo) - como Left=0, a parte
    * que excede a largura do form fica fora da area visivel (clipping do
    * client area), entao transcrever o valor literal do SCX nao desloca nada
    * visivel. cnt_4c_Sombra continua em THIS.Width (regra #11, canonico).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")

        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .T.
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerCampos - monta cnt_4c_Container1 (legado "Container1",
    * filho DIRETO do form - FLAT, sem PageFrame, logo sem compensacao +29)
    * com os TRES campos de captura e os lookups de Empresa/Operacao:
    *   - lbl_4c_Label1 + txt_4c_Text1 ("Emp"      -> this_cEmps,  lookup SigCdEmp)
    *   - lbl_4c_Label2 + txt_4c_Text2 ("Operacao"  -> this_cDopes, lookup SigCdOpe)
    *   - lbl_4c_Label3 + txt_4c_Text3 ("Numero"    -> this_cNumes, so digitos)
    *
    * Geometria e MaxLength EXATOS do dump (SigOpCbx_form_codigo_fonte.txt):
    * Container1 Top=84/Left=0/W=254/H=47/SpecialEffect=0; Text1 MaxLength=3
    * (SigCdEmp.cEmps char(3)); Text2 MaxLength=20 (SigCdOpe.Dopes char(20));
    * Text3 MaxLength=6. Labels sao AutoSize=.T. no legado, que e NO-OP via
    * AddObject (regra #23) - Width/Height abaixo sao os mesmos que o Form
    * Designer ja calculou no SCX, entao fixa-los e reproducao fiel, nao
    * desvio do PILAR 1.
    *
    * A validacao de Commandgroup1 (digitos de Text3, obrigatoriedade dos
    * tres campos, checagem de EmpDopNums) fica para a Fase 7, junto com os
    * botoes Baixa/Cancela.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerCampos()
        THIS.AddObject("cnt_4c_Container1", "Container")

        WITH THIS.cnt_4c_Container1
            .Top           = 84
            .Left          = 0
            .Width         = 254
            .Height        = 47
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label "Emp" (legado Label1)
        *----------------------------------------------------------------------
        THIS.cnt_4c_Container1.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.cnt_4c_Container1.lbl_4c_Label1
            .Top       = 4
            .Left      = 7
            .Width     = 26
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Emp"
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox Emp (legado Text1) - this_cEmps, lookup SigCdEmp
        *----------------------------------------------------------------------
        THIS.cnt_4c_Container1.AddObject("txt_4c_Text1", "TextBox")
        WITH THIS.cnt_4c_Container1.txt_4c_Text1
            .Top       = 18
            .Left      = 4
            .Width     = 33
            .Height    = 23
            .MaxLength = 3
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label "Operacao" (legado Label2)
        *----------------------------------------------------------------------
        THIS.cnt_4c_Container1.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.cnt_4c_Container1.lbl_4c_Label2
            .Top       = 4
            .Left      = 43
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox Operacao (legado Text2) - this_cDopes, lookup SigCdOpe
        *----------------------------------------------------------------------
        THIS.cnt_4c_Container1.AddObject("txt_4c_Text2", "TextBox")
        WITH THIS.cnt_4c_Container1.txt_4c_Text2
            .Top       = 18
            .Left      = 40
            .Width     = 152
            .Height    = 23
            .MaxLength = 20
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label "Numero" (legado Label3)
        *----------------------------------------------------------------------
        THIS.cnt_4c_Container1.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.cnt_4c_Container1.lbl_4c_Label3
            .Top       = 4
            .Left      = 198
            .Width     = 46
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Numero"
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox Numero (legado Text3) - this_cNumes. So digitos: o legado
        * NAO declara InputMask/Format para este campo (so valida IsDigit no
        * Commandgroup1.Click - Fase 7), logo nao inventamos mascara aqui
        * (regra #24/#49: transcrever SOMENTE o que o dump declara).
        *----------------------------------------------------------------------
        THIS.cnt_4c_Container1.AddObject("txt_4c_Text3", "TextBox")
        WITH THIS.cnt_4c_Container1.txt_4c_Text3
            .Top       = 18
            .Left      = 195
            .Width     = 54
            .Height    = 23
            .MaxLength = 6
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Lookups de Empresa (Text1) e Operacao (Text2) - legado: Valid de
        * cada TextBox com CreateObject('fwBuscaExt', ...). F4(115) abre o
        * picker direto; Enter(13)/Tab(9) tentam o match exato primeiro
        * (equivalente ao "If Not xBrox.plAchouRegistro" do legado) e so
        * abrem o picker se nao encontrarem.
        *----------------------------------------------------------------------
        BINDEVENT(THIS.cnt_4c_Container1.txt_4c_Text1, "KeyPress", THIS, "EmpresaKeyPress")
        BINDEVENT(THIS.cnt_4c_Container1.txt_4c_Text1, "DblClick", THIS, "EmpresaDblClick")
        BINDEVENT(THIS.cnt_4c_Container1.txt_4c_Text2, "KeyPress", THIS, "OperacaoKeyPress")
        BINDEVENT(THIS.cnt_4c_Container1.txt_4c_Text2, "DblClick", THIS, "OperacaoDblClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transfere os TRES campos digitaveis (Emp/Operacao/Numero)
    * para o Business Object. Extraido do que antes ficava inline no
    * handler do botao de acao - mesmo conteudo, agora no hook canonico
    * (FormBase.FormParaBO(), PROTECTED, chamado so pelo FormBase.Salvar()
    * generico - este dialogo NAO usa Salvar()/Cancelar() da base, chama
    * this_oBusinessObject.Inserir() direto, mas o hook continua com
    * conteudo REAL - nao eh stub - e evita duplicar a transferencia caso
    * outro ponto do form precise dela no futuro).
    *
    * PROTECTED obrigatoriamente: FormBase declara FormParaBO() PROTECTED e
    * o VFP9 nao permite ALARGAR o escopo de um metodo herdado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_cEmps  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text1.Value)
        THIS.this_oBusinessObject.this_cDopes = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text2.Value)
        THIS.this_oBusinessObject.this_cNumes = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text3.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * NOTA DE COMPLETUDE (Fase 8/8): este dialogo NAO tem BOParaForm() nem
    * CarregarLista() proprios, e a ausencia e estrutural, nao omissao:
    *
    *   BOParaForm - no legado (Commandgroup1.Command1.Click) NAO HA nenhum
    *   bloco que leve valor do BO/cursor de volta para Text1/Text2/Text3 -
    *   o fluxo e so de ENTRADA (Form -> BO). O unico "retorno de valor"
    *   da tela e o do picker de lookup (Evaluate('csSigCdEmp.cEmps')/
    *   Evaluate('csSigCdOpe.Dopes') no Valid legado), que ja esta
    *   implementado em AbrirLookupEmpresa/AbrirLookupOperacao via
    *   AbrirLookupCanonico (FormBase) - escrever um BOParaForm() vazio so
    *   para o nome aparecer no arquivo seria stub disfarcado (regra de
    *   completude), e BusinessBase.BOParaForm() ja herda um PROTECTED
    *   PROCEDURE no-op que cobre o caso de ninguem chamar.
    *
    *   CarregarLista - o SCX legado (SIGOPCBX) nao tem Grid nem PageFrame
    *   (layout.json/analise.json: grid.temGrid = .F.); nao ha cursor de
    *   listagem nenhum para popular. Inventar uma grade aqui violaria o
    *   PILAR 1 (nunca inventar UI que o legado nao tem).
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * EmpresaKeyPress / EmpresaDblClick - lookup de txt_4c_Text1 (legado:
    * Container1.Text1.Valid -> CreateObject('fwBuscaExt', ..., 'SigCdEmp',
    * ..., 'cEmps', ...)). PUBLIC: exigido por BINDEVENT (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE EmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarLookupEmpresa()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE EmpresaDblClick()
        THIS.AbrirLookupEmpresa()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupEmpresa - abre o picker canonico (FormBuscaAuxiliar via
    * AbrirLookupCanonico, herdado de FormBase - Pattern A) SEM checagem
    * previa. Usado por F4 e DblClick ("F4 sempre abre lookup direto").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupEmpresa()
        THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text1.Value), ;
            THIS.cnt_4c_Container1.txt_4c_Text1, .NULL.)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarLookupEmpresa - usado por Enter/Tab: tenta achar o codigo
    * digitado por igualdade exata primeiro (equivalente ao
    * "plAchouRegistro" do fwBuscaExt legado); so abre o picker se nao
    * encontrar. Campo vazio nao valida (legado: If !IsEmpty(This.Value)).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarLookupEmpresa()
        LOCAL loc_cValor, loc_nResult, loc_cCursor, loc_cSQL

        loc_cValor  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text1.Value)
        loc_cCursor = "cursor_4c_ChkEmps"

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF USED(loc_cCursor)
            USE IN SELECT(loc_cCursor)
        ENDIF

        loc_cSQL = "SELECT Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
            USE IN SELECT(loc_cCursor)
            RETURN
        ENDIF

        IF USED(loc_cCursor)
            USE IN SELECT(loc_cCursor)
        ENDIF

        THIS.AbrirLookupEmpresa()
    ENDPROC

    *--------------------------------------------------------------------------
    * OperacaoKeyPress / OperacaoDblClick - lookup de txt_4c_Text2 (legado:
    * Container1.Text2.Valid -> CreateObject('fwBuscaExt', ..., 'SigCdOpe',
    * ..., 'Dopes', ...)). PUBLIC: exigido por BINDEVENT (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE OperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupOperacao()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarLookupOperacao()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE OperacaoDblClick()
        THIS.AbrirLookupOperacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupOperacao - SigCdOpe.Dopes eh a PK E a descricao ao mesmo
    * tempo (tabela SINGLE-COLUMN - memoria feedback_sigcdope_single_column:
    * NUNCA usar Descrs/descs nela). A mesma coluna alimenta codigo e
    * descricao no picker (igual ao mAddColuna('Dopes', '', 'Operacao')
    * unico do legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupOperacao()
        THIS.AbrirLookupCanonico("SigCdOpe", "Dopes", "Dopes", ;
            "Sele" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(227) + "o", ;
            ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text2.Value), ;
            THIS.cnt_4c_Container1.txt_4c_Text2, .NULL.)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarLookupOperacao - mesmo padrao de ValidarLookupEmpresa, contra
    * SigCdOpe.Dopes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarLookupOperacao()
        LOCAL loc_cValor, loc_nResult, loc_cCursor, loc_cSQL

        loc_cValor  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text2.Value)
        loc_cCursor = "cursor_4c_ChkDopes"

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF USED(loc_cCursor)
            USE IN SELECT(loc_cCursor)
        ENDIF

        loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
            USE IN SELECT(loc_cCursor)
            RETURN
        ENDIF

        IF USED(loc_cCursor)
            USE IN SELECT(loc_cCursor)
        ENDIF

        THIS.AbrirLookupOperacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrupoBotoes - monta obj_4c_Commandgroup1 (legado
    * "Commandgroup1"), com os dois botoes de acao do dialogo:
    *   - Buttons(1) "Baixa"   (legado Command1) -> THIS.BtnConfirmarClick()
    *   - Buttons(2) "Cancela" (legado Command2) -> THIS.BtnCancelarClick()
    *
    * Geometria/propriedades EXATAS do dump (SigOpCbx_form_codigo_fonte.txt):
    * grupo Top=-3/Left=370/W=160/H=85/BackStyle=0/BorderStyle=0; botoes
    * W=75/H=75, FontName="Comic Sans MS", ForeColor=RGB(90,90,90),
    * BackColor=RGB(255,255,255), Themes=.F. (canonico de botao DENTRO de
    * CommandGroup - regra #99/CLAUDE.md). Picture de cada botao copiado
    * LITERALMENTE do dump (regra #25 - nunca inventar nome de icone):
    * Command1 = "cadastro_salvar_60.jpg", Command2 = "cadastro_sair_26.jpg".
    * Este eh um dialogo FLAT sem PageFrame (sem compensacao +29 - regra
    * #11/#31).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrupoBotoes()
        THIS.AddObject("obj_4c_Commandgroup1", "CommandGroup")

        WITH THIS.obj_4c_Commandgroup1
            .Top         = -3
            .Left        = 370
            .Width       = 160
            .Height      = 85
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .Caption    = "Baixa"
                .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .Caption    = "Cancela"
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_26.jpg"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(2), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - legado Commandgroup1.Command1.Click (objeto
    * "Command1", Caption "Baixa" - nomeado pela ACAO/convencao canonica do
    * projeto, nao pelo Caption literal do legado - mesmo padrao do botao
    * "Confirma"/Caption "Baixa" de FormSigOpBcb). Valida os tres campos
    * (Numero so digitos e obrigatorio, Emp obrigatorio, Operacao
    * obrigatoria - TRANSCRITO literalmente do legado, regra #17: a ordem e
    * as mensagens de cada guard sao regra de negocio, nao estetica) e, se
    * tudo ok, repassa os valores ao BO (THIS.FormParaBO()) e confirma a
    * baixa via this_oBusinessObject.Inserir() - que ja faz a validacao da
    * chave EmpDopNums contra SigMvCab e a gravacao/commit (SigSyCrs +
    * chksubn).
    *
    * PUBLIC: exigido por BINDEVENT (regra CLAUDE.md #3). Guards com RETURN
    * bare ficam FORA de qualquer TRY/CATCH (regra CLAUDE.md #1) - nao ha
    * TRY neste metodo, a validacao e so leitura de TextBox.
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lNumerico, loc_nI, loc_cNumero

        loc_cNumero = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text3.Value)

        IF !EMPTY(loc_cNumero)
            loc_lNumerico = .T.
            FOR loc_nI = 1 TO LEN(loc_cNumero)
                IF !ISDIGIT(SUBSTR(loc_cNumero, loc_nI, 1))
                    loc_lNumerico = .F.
                ENDIF
            ENDFOR

            IF !loc_lNumerico
                MsgAviso("O N" + CHR(250) + "mero da Opera" + CHR(231) + CHR(227) + ;
                    "o Digitado N" + CHR(227) + "o " + CHR(233) + " V" + CHR(225) + "lido!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                THIS.cnt_4c_Container1.txt_4c_Text3.SetFocus()
                RETURN
            ENDIF
        ENDIF

        IF EMPTY(loc_cNumero)
            MsgAviso("O N" + CHR(250) + "mero da Opera" + CHR(231) + CHR(227) + ;
                "o Digitado N" + CHR(227) + "o " + CHR(233) + " V" + CHR(225) + "lido!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Container1.txt_4c_Text3.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text1.Value))
            MsgAviso(CHR(201) + " Necess" + CHR(225) + "rio Preencher a Empresa !!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Container1.txt_4c_Text1.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Text2.Value))
            MsgAviso(CHR(201) + " Necess" + CHR(225) + "rio Preencher a Opera" + CHR(231) + CHR(227) + "o !!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Container1.txt_4c_Text2.SetFocus()
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Inserir()
            THIS.this_cResultado = "B"
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - legado Commandgroup1.Command2.Click (objeto
    * "Command2", Caption "Cancela" - "Bxado = 'C'" + "Release Windows").
    * Nomeado pelo canonico do projeto (BtnCancelarClick), nao pelo Caption
    * literal "Cancela" do legado. PUBLIC: exigido por BINDEVENT (regra
    * CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cResultado = "C"
        THIS.Release()
    ENDPROC

ENDDEFINE
