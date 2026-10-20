# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[SigOpCbxBO.prg] Indicador de pendencia: * Cadastros/respostas pendente
[SigOpCbxBO.prg] Indicador de pendencia: * registro pendente
[SigOpCbxBO.prg] Indicador de pendencia: *-- Dados do registro pendente
[SigOpCbxBO.prg] Indicador de pendencia: * principio a fim eh o codigo do pendente
[SigOpCbxBO.prg] Indicador de pendencia: *    o grupo do codigo pendente
[FormSigOpCbx.prg] Indicador de pendencia: * Filho MODAL de outro form: recebe o codigo do registro pendente
[FormSigOpCbx.prg] Indicador de pendencia: * pendente

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCbx.prg):
*====================================================================
* FormSigOpCbx.prg
*
* Dialogo OPERACIONAL "Baixa de Cadastros" (legado SIGOPCBX.scx).
* Filho MODAL de outro form: recebe o codigo do registro pendente
* (SigSyCrs.Cods) e o titulo do relatorio/tela de origem (legado
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
    * pendente recebido no Init) e monta a faixa do cabecalho. Container1
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
    * dois labels de titulo sombra/frente (CLAUDE.md regra #11/#23). Largura
    * dinamica (THIS.Width) - o legado tem cntSombra.Width=800/labels.Width=769
    * herdados do template generico de frmcadastro, incompativeis com este
    * dialogo pequeno de 527px.
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
            .Width     = THIS.Width - 20
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
            .Width     = THIS.Width - 20
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


### BO (C:\4c\projeto\app\classes\SigOpCbxBO.prg):
*====================================================================
* SigOpCbxBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGOPCBX" (Baixa de
* Cadastros/respostas pendentes). O legado abre este form como filho
* MODAL de outro form (Lparameters pcForm, pcCodigo), captura Empresa/
* Operacao/Numero, valida a combinacao contra SigMvCab.EmpDopNums e,
* ao clicar "Baixa", grava uma linha de resposta por campo (Emps,
* Dopes, Numes, Baixa) num cursor local do form PAI (crGrvCadRs),
* comita essas respostas e marca SigSyCrs.ChkSubn = .T. para o
* registro pendente (SigSyCrs.Cods = pcCodigo).
*
* Nao ha tela de listagem nem edicao de UM registro de SigSyCrs aqui -
* a "entidade" deste dialogo e o conjunto de respostas vinculado ao
* codigo (this_nCodigo) recebido do form pai. A chave primaria mais
* proxima, por completude de contrato com BusinessBase, e cidchaves
* (PK de SigSyCrs) - cada resposta grava a SUA PROPRIA cidchaves nova
* (fUniqueIds()), nunca reaproveitada entre Emps/Dopes/Numes/Baixa.
*
* Referencias legado -> BO:
*   Lparameters pcForm        -> fica no FORM (referencia a objeto UI,
*                                 ThisForm.ParentForm/poDataMgr/Tits)
*   Lparameters pcCodigo      -> this_nCodigo       (SigSyCrs.Cods)
*   Container1.Text1.Value    -> this_cEmps         (SigCdEmp.cEmps)
*   Container1.Text2.Value    -> this_cDopes        (SigCdOpe.Dopes)
*   Container1.Text3.Value    -> this_cNumes        (digitos, PADL 6 na chave)
*   lcEdn (chave posicional)  -> this_cEmpDopNums   (= SigMvCab.EmpDopNums)
*   ThisForm.ParentForm.Tits  -> this_cTitulo       (SigSyCrs.Tits)
*   Usuar (PUBLIC global)     -> this_cUsuario      (resposta do campo "Baixa")
*   Bxado ('B'/'C')           -> this_lBaixaConfirmada
*   crGrvCadRs (cursor local) -> this_cCursorRespostas ("cursor_4c_GrvCadRs")
*
* Herda de: BusinessBase
*
* Fase 2/8 - CarregarDoCursor(), validacao da chave EmpDopNums contra
* SigMvCab, gravacao (Inserir/Atualizar), ObterChavePrimaria() e
* RegistrarAuditoria() (chamada por Inserir/Atualizar).
*====================================================================

DEFINE CLASS SigOpCbxBO AS BusinessBase

    *-- Parametro recebido na abertura do dialogo (legado: Lparameters
    *-- pcForm, pcCodigo - pcForm e referencia de objeto e fica no Form)
    this_nCodigo            = 0    && Codigo do registro pendente - legado "pcCodigo" - SigSyCrs.Cods numeric(6,0)

    *-- Campos digitados pelo usuario (Container1.Text1/Text2/Text3)
    this_cEmps              = ""   && Empresa - lookup SigCdEmp.cEmps (char 3)
    this_cDopes             = ""   && Operacao - lookup SigCdOpe.Dopes (char 20)
    this_cNumes             = ""   && Numero do movimento (so digitos) - PADL(ALLTRIM(...),6) na chave posicional

    *-- Chave posicional de validacao (legado "lcEdn") - regra CLAUDE.md
    *-- #42: PADR/PADL explicito em cada parte, NUNCA ALLTRIM isolado -
    *-- o padding faz parte da chave e eh o que casa com a coluna
    *-- EmpDopNums char(29) de SigMvCab (emps char(3) + dopes char(20) +
    *-- Str(numes,6) = 29)
    this_cEmpDopNums        = ""   && PADR(Emps,3) + PADR(Dopes,20) + PADL(ALLTRIM(Numes),6)

    *-- Dados do registro pendente, fornecidos pelo form pai (legado
    *-- "ThisForm.ParentForm.Tits"/"Usuar") - necessarios para montar as
    *-- linhas de resposta gravadas em SigSyCrs
    this_cTitulo            = ""   && Legado "ThisForm.ParentForm.Tits" - SigSyCrs.Tits (char 20)
    this_cUsuario           = ""   && Legado "Usuar" (PUBLIC global) - resposta do campo "Baixa"

    *-- Resultado da operacao (legado "Bxado": 'B' = baixou / 'C' = cancelou)
    this_lBaixaConfirmada   = .F.

    *-- Cursor de trabalho local (equivalente ao "crGrvCadRs" do legado:
    *-- buffer das respostas Emps/Dopes/Numes/Baixa antes do UpDate)
    this_cCursorRespostas   = "cursor_4c_GrvCadRs"

    *-- Espelho escalar de UMA linha de SigSyCrs (usado por CarregarDoCursor()/
    *-- Atualizar() quando o BO precisa ler ou corrigir uma resposta JA gravada
    *-- pela sua propria cidchaves - o fluxo principal de gravacao desta tela
    *-- (Inserir(), que cria QUATRO linhas por confirmacao) nao usa estes campos)
    this_cCidChaves         = ""   && SigSyCrs.cidchaves (char 20) - PK da linha carregada
    this_cCampos            = ""   && SigSyCrs.campos (char 10) - nome do campo respondido
    this_cPergs             = ""   && SigSyCrs.pergs (text) - rotulo da pergunta
    this_cResps             = ""   && SigSyCrs.resps (text) - resposta gravada
    this_lChkApro           = .F.  && SigSyCrs.chkapro (bit)
    this_lChkSubn           = .F.  && SigSyCrs.chksubn (bit) - .T. = grupo respondido/submetido

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * Parametro equivalente ao Lparameters pcCodigo do Init do form legado -
    * pcForm (referencia de objeto UI: ParentForm/poDataMgr/Tits) permanece
    * no Form, fora da responsabilidade do Business Object.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nCodigo)
        DODEFAULT("SigSyCrs")

        THIS.this_cCampoChave = "cidchaves"

        IF VARTYPE(par_nCodigo) = "N"
            THIS.this_nCodigo = par_nCodigo
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia TODAS as colunas de SigSyCrs para as properties
    * escalares do BO (this_cCidChaves/this_cCampos/this_cPergs/this_cResps/
    * this_lChkApro/this_lChkSubn + this_nCodigo/this_cTitulo ja existentes).
    *
    * Carrega UMA linha de resposta (uma unica cidchaves) - util para inspecao/
    * correcao de uma resposta ja gravada via Atualizar(). O fluxo principal de
    * gravacao (confirmar a Baixa) cria QUATRO linhas novas em Inserir() e nao
    * depende deste metodo.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCidChaves = TratarNulo(cidchaves, "")
        THIS.this_nCodigo    = TratarNulo(cods, 0)
        THIS.this_cTitulo    = TratarNulo(tits, "")
        THIS.this_cCampos    = TratarNulo(campos, "")
        THIS.this_cResps     = TratarNulo(resps, "")
        THIS.this_cPergs     = TratarNulo(pergs, "")
        THIS.this_lChkApro   = ConverterParaLogico(chkapro)
        THIS.this_lChkSubn   = ConverterParaLogico(chksubn)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Usada por RegistrarAuditoria(). Nao ha uma UNICA
    * cidchaves representando "o registro" desta tela (Inserir() grava quatro
    * linhas, uma por campo respondido) - a chave que identifica a OPERACAO de
    * principio a fim eh o codigo do pendente (this_nCodigo/SigSyCrs.cods).
    * Quando uma linha especifica foi carregada via CarregarDoCursor() (fluxo
    * de Atualizar()), a cidchaves dela e mais precisa e prevalece.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        IF !EMPTY(ALLTRIM(THIS.this_cCidChaves))
            RETURN THIS.this_cCidChaves
        ENDIF

        RETURN TRANSFORM(THIS.this_nCodigo)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Confirma a "Baixa" (legado: Commandgroup1.Command1.Click).
    *
    * 1) Monta a chave posicional EmpDopNums (CLAUDE.md #42: PADR/PADL
    *    EXPLICITO em cada parte - o padding FAZ PARTE da chave e eh o que
    *    casa com SigMvCab.empdopnums char(29) = emps char(3) + dopes char(20)
    *    + numes Str(.,6)).
    * 2) Valida a chave contra SigMvCab (legado: CursorQuery('SigMvCab',
    *    'LocalEest','EmpDopNums', lcEdn,'EmpDopNums') + If Eof('LocalEest')).
    * 3) Grava, num UNICO lote T-SQL com controle de transacao proprio (BEGIN/
    *    COMMIT via SQLEXEC separados NAO protegem - a conexao nasce com
    *    Transactions=2 e @@TRANCOUNT ja vale 1), uma linha em SigSyCrs por
    *    campo respondido (Emps/Dopes/Numes/Baixa - legado: 4x "Insert Into
    *    crGrvCadRs" + "poDatamgr.UpDate('crGrvCadRs')") e a seguir marca TODO
    *    o grupo do codigo pendente como respondido (legado: "UpDate SigSyCrs
    *    Set ChkSubn = ?llOk Where Cods = ?lnCod").
    *
    * Nota de fidelidade ao legado: a insercao da linha "Baixa" (Resps=Usuario)
    * eh condicionada ao MESMO teste de "Numero nao vazio" da linha "Numes" -
    * o legado reusa a variavel lcVal/Text3.Value nos dois blocos, sem
    * condicao propria para a linha da Baixa. Transcrito literalmente
    * (CLAUDE.md #17/#21b: a condicao que cerca a gravacao e regra, nao
    * detalhe).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cCidEmps, loc_cCidDopes, loc_cCidNumes, loc_cCidBaixa

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + ;
                                    PADR(THIS.this_cDopes, 20) + ;
                                    PADL(ALLTRIM(THIS.this_cNumes), 6)

            IF USED("cursor_4c_SigOpCbxMvCab")
                USE IN cursor_4c_SigOpCbxMvCab
            ENDIF

            loc_cSQL = "SELECT TOP 1 cidchaves FROM SigMvCab WHERE empdopnums = " + ;
                EscaparSQL(THIS.this_cEmpDopNums)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpCbxMvCab")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao consultar a opera" + CHR(231) + CHR(227) + ;
                    "o: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
                THIS.this_lErroExibido = .T.
            ELSE
                IF !USED("cursor_4c_SigOpCbxMvCab") OR EOF("cursor_4c_SigOpCbxMvCab")
                    THIS.this_cMensagemErro = "A opera" + CHR(231) + CHR(227) + "o com o n" + ;
                        CHR(250) + "mero digitado n" + CHR(227) + "o foi encontrada na empresa!"
                    MsgAviso(THIS.this_cMensagemErro, "Baixa de Cadastros")
                    THIS.this_lErroExibido = .T.
                ELSE
                    *-- Regra #22: cidchaves (PK Fortyus) NUNCA reaproveitada entre
                    *-- linhas - uma nova por campo respondido
                    loc_cCidEmps  = EscaparSQL(fUniqueIds())
                    loc_cCidDopes = EscaparSQL(fUniqueIds())
                    loc_cCidNumes = EscaparSQL(fUniqueIds())
                    loc_cCidBaixa = EscaparSQL(fUniqueIds())

                    loc_cSQL = "SET NOCOUNT ON;" + CHR(13) + ;
                        "DECLARE @nivel int = @@TRANCOUNT;" + CHR(13) + ;
                        "IF @nivel = 0 BEGIN TRANSACTION ELSE SAVE TRANSACTION Cop4c;" + CHR(13) + ;
                        "BEGIN TRY" + CHR(13)

                    IF !EMPTY(ALLTRIM(THIS.this_cEmps))
                        loc_cSQL = loc_cSQL + ;
                            "INSERT INTO SigSyCrs (tits, campos, cods, cidchaves, resps, pergs, chkapro, chksubn) VALUES (" + ;
                            EscaparSQL(THIS.this_cTitulo) + ", " + ;
                            EscaparSQL("Emps") + ", " + ;
                            FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                            loc_cCidEmps + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                            EscaparSQL("Empresa") + ", 1, 0);" + CHR(13)
                    ENDIF

                    IF !EMPTY(ALLTRIM(THIS.this_cDopes))
                        loc_cSQL = loc_cSQL + ;
                            "INSERT INTO SigSyCrs (tits, campos, cods, cidchaves, resps, pergs, chkapro, chksubn) VALUES (" + ;
                            EscaparSQL(THIS.this_cTitulo) + ", " + ;
                            EscaparSQL("Dopes") + ", " + ;
                            FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                            loc_cCidDopes + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                            EscaparSQL("Opera" + CHR(231) + CHR(227) + "o") + ", 1, 0);" + CHR(13)
                    ENDIF

                    IF !EMPTY(ALLTRIM(THIS.this_cNumes))
                        loc_cSQL = loc_cSQL + ;
                            "INSERT INTO SigSyCrs (tits, campos, cods, cidchaves, resps, pergs, chkapro, chksubn) VALUES (" + ;
                            EscaparSQL(THIS.this_cTitulo) + ", " + ;
                            EscaparSQL("Numes") + ", " + ;
                            FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                            loc_cCidNumes + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cNumes)) + ", " + ;
                            EscaparSQL("C" + CHR(243) + "digo") + ", 1, 0);" + CHR(13)

                        *-- Legado: a linha "Baixa" reusa o MESMO teste de
                        *-- Text3/Numes (sem condicao propria) - Resps = Usuar
                        loc_cSQL = loc_cSQL + ;
                            "INSERT INTO SigSyCrs (tits, campos, cods, cidchaves, resps, pergs, chkapro, chksubn) VALUES (" + ;
                            EscaparSQL(THIS.this_cTitulo) + ", " + ;
                            EscaparSQL("Baixa") + ", " + ;
                            FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                            loc_cCidBaixa + ", " + ;
                            EscaparSQL(THIS.this_cUsuario) + ", " + ;
                            EscaparSQL("Baixa") + ", 1, 0);" + CHR(13)
                    ENDIF

                    loc_cSQL = loc_cSQL + ;
                        "UPDATE SigSyCrs SET chksubn = 1 WHERE cods = " + ;
                        FormatarNumeroSQL(THIS.this_nCodigo, 0) + ";" + CHR(13) + ;
                        "IF @nivel = 0 COMMIT TRANSACTION;" + CHR(13) + ;
                        "END TRY" + CHR(13) + ;
                        "BEGIN CATCH" + CHR(13) + ;
                        "    IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + CHR(13) + ;
                        "    ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Cop4c; END;" + CHR(13) + ;
                        "    THROW;" + CHR(13) + ;
                        "END CATCH"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Erro ao gravar a baixa: " + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
                        THIS.this_lErroExibido = .T.
                    ELSE
                        THIS.this_lBaixaConfirmada = .T.
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao processar a baixa: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_SigOpCbxMvCab")
            USE IN cursor_4c_SigOpCbxMvCab
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Corrige UMA linha de resposta ja gravada em SigSyCrs,
    * identificada por this_cCidChaves (carregada previamente via
    * CarregarDoCursor()). Nao faz parte do fluxo principal desta tela
    * (Confirmar Baixa sempre grava linhas NOVAS via Inserir()), mas completa
    * o contrato CRUD de BusinessBase para a mesma tabela/chave.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "Registro de resposta n" + CHR(227) + ;
                    "o identificado para altera" + CHR(231) + CHR(227) + "o."
                MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
                THIS.this_lErroExibido = .T.
            ELSE
                loc_cSQL = "UPDATE SigSyCrs SET" + ;
                    " tits    = " + EscaparSQL(THIS.this_cTitulo)        + ", " + ;
                    " campos  = " + EscaparSQL(THIS.this_cCampos)        + ", " + ;
                    " cods    = " + FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                    " resps   = " + EscaparSQL(THIS.this_cResps)         + ", " + ;
                    " pergs   = " + EscaparSQL(THIS.this_cPergs)         + ", " + ;
                    " chkapro = " + IIF(THIS.this_lChkApro, "1", "0")    + ", " + ;
                    " chksubn = " + IIF(THIS.this_lChkSubn, "1", "0")    + ;
                    " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao atualizar a resposta: " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
                    THIS.this_lErroExibido = .T.
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar a resposta: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

