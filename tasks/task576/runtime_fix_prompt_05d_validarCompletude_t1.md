# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[sigmvpenBO.prg] Indicador de pendencia: * Business Object para Pendente
[sigmvpenBO.prg] Indicador de pendencia: * Formulario OPERACIONAL: consulta de itens pendente
[sigmvpenBO.prg] Indicador de pendencia: * entre SigMvEstPd (saldo pendente
[sigmvpenBO.prg] Indicador de pendencia: * Metodos principais: CriarCursoresPendente
[sigmvpenBO.prg] Indicador de pendencia: * par_cLpKey: chave (Fk_chave) usada para filtrar os pendente
[sigmvpenBO.prg] Indicador de pendencia: * CriarCursoresPendente
[sigmvpenBO.prg] Indicador de pendencia: * internamente por BuscarPendente
[sigmvpenBO.prg] Indicador de pendencia: * BuscarPendente
[sigmvpenBO.prg] Indicador de pendencia: * itens pendente
[sigmvpenBO.prg] Indicador de pendencia: *-- Select Sum(Pendente
[sigmvpenBO.prg] Indicador de pendencia: *-- Insert Into crRodape (Pendente
[sigmvpenBO.prg] Indicador de pendencia: * "nao implement
[Formsigmvpen.prg] Indicador de pendencia: * Form OPERACIONAL "Pendente
[Formsigmvpen.prg] Indicador de pendencia: * pendente
[Formsigmvpen.prg] Indicador de pendencia: *   - grd_4c_Grade   (grdItens legado - grade de itens pendente
[Formsigmvpen.prg] Indicador de pendencia: * isso THIS.this_oBusinessObject.CriarCursoresPendente
[Formsigmvpen.prg] Indicador de pendencia: * do legado, via BuscarPendente
[Formsigmvpen.prg] Indicador de pendencia: * cursores aqui criados comecam VAZIOS (CriarCursoresPendente
[Formsigmvpen.prg] Indicador de pendencia: *     THIS.CarregarPendente
[Formsigmvpen.prg] Indicador de pendencia: *     (ver acima), que aciona sigmvpenBO.BuscarPendente
[Formsigmvpen.prg] Indicador de pendencia: *     - o cursor local de itens pendente
[Formsigmvpen.prg] Indicador de pendencia: *   par_cLpKey - Fk_chave: chave usada para filtrar os pendente
[Formsigmvpen.prg] Indicador de pendencia: *     e automatica no Init (ja implementada em CarregarPendente
[Formsigmvpen.prg] Indicador de pendencia: *   - CarregarLista -> equivalente real e CarregarPendente
[Formsigmvpen.prg] Indicador de pendencia: *     que popula as duas grades a partir de sigmvpenBO.BuscarPendente
[Formsigmvpen.prg] Indicador de pendencia: * mostrar o saldo pendente
[Formsigmvpen.prg] Indicador de pendencia: *-- grdItens -> grd_4c_Grade (8 colunas, itens pendente
[Formsigmvpen.prg] Indicador de pendencia: * CarregarPendente
[Formsigmvpen.prg] Indicador de pendencia: * InicializarForm), entao aqui resta ".SelecionaDados" (BuscarPendente
[Formsigmvpen.prg] Indicador de pendencia: * itens. O cursor de itens pendente
[Formsigmvpen.prg] Indicador de pendencia: * BuscarPendente
[Formsigmvpen.prg] Indicador de pendencia: * Chamado tanto pela carga inicial (CarregarPendente
[Formsigmvpen.prg] Indicador de pendencia: * do legado, criados por sigmvpenBO.CriarCursoresPendente

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigmvpen.prg):
*====================================================================
* Formsigmvpen.prg
*
* Form OPERACIONAL "Pendentes" (SIGMVPEN) - dialogo de CONSULTA que
* lista, agrupado por movimentacao (Empresa/Operacao/Numero), o saldo
* pendente de um filtro (Fk_chave) repassado pelo processo chamador.
* Duas grades (itens + rodape com o total) e um TextBox somente-leitura
* com a razao social do cliente/fornecedor da linha selecionada. Unico
* botao: "Encerrar" (equivalente ao legado "ok"), que apenas fecha a
* tela - nao ha INSERT/UPDATE/DELETE em lugar nenhum do original.
*
* PILAR 1 (UX): dialogo fixo, identico ao legado SIGMVPEN - sem barra
* de titulo/controle de janela (ControlBox = .F.), nao movivel
* (Movable = .F.), 750x513, AutoCenter = .T..
*
* PILAR 3 (arquitetura): o legado (SIGMVPEN) e um form FLAT do VFP -
* SEM PageFrame, SEM Container algum (arvore do SCX: dataenvironment +
* form + Shape1 + ok + grdItens [8 colunas] + grdRodape [3 colunas] +
* getRClis, todos filhos DIRETOS do form). Este form migrado segue a
* mesma estrutura flat (excecao documentada em CLAUDE.md para o Gate
* da Fase 3 quando o legado nao tem PageFrame/Container - nao inventar
* Page1/Page2 nem containers vazios que o original nao possui). Ver
* tambem FormSigMvPdt.prg (mesmo padrao de dialogo flat).
*
* FASE 3/8 - ESTRUTURA BASE
* -----------------------------------------------------------------
* DEFINE CLASS + propriedades + Init() + InicializarForm() + Destroy().
* InicializarForm() instancia o Business Object (equivalente ao
* "CreateObject('fSqlConector', .Name)" do Init legado) e configura as
* propriedades visuais do form (equivalente as propriedades do SCX).
* NAO ha ConfigurarPageFrame() porque o legado nao tem PageFrame (ver
* PILAR 3 acima).
*
* FASE 4/8 - CONTROLES (GRADES E BOTAO) - este arquivo, nesta fase
* -----------------------------------------------------------------
* A tarefa desta fase (template generico do pipeline) pede "Grid e
* botoes CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar/Encerrar) na
* Page1". Esse template e para form CRUD (frmcadastro); SIGMVPEN e um
* dialogo de CONSULTA sem Page1/Page2 (ver PILAR 3 acima) e SEM
* NENHUM botao de Incluir/Alterar/Excluir/Buscar no legado - a arvore
* do SCX (SECAO 1 do dump) e a contagem de metodos ("Total de
* metodos/eventos com codigo: 11", SECAO 4) prova isso: o UNICO
* CommandButton e "ok" (Caption "Encerrar", PROCEDURE Click =
* ThisForm.Release). Criar os outros 5 botoes inventaria funcionalidade
* que o original nao possui (mesmo caso de FormSigMvPdt.prg, form
* despachante sem CRUD - ver cabecalho dele). O que esta fase adiciona
* de fato, replicando fielmente a arvore do SCX (Shape1 + grdItens[8
* colunas] + grdRodape[3 colunas] + getRClis + ok), todos filhos
* DIRETOS do form:
*   - shp_4c_Shape1  (Shape1 legado - moldura decorativa ao redor do
*     botao Encerrar)
*   - grd_4c_Grade   (grdItens legado - grade de itens pendentes, 8
*     colunas, ligada a cursor_4c_Grade do Business Object)
*   - grd_4c_Rodape  (grdRodape legado - grade de 1 linha com o total
*     geral, ligada a cursor_4c_Rodape do Business Object)
*   - txt_4c_RClis   (getRClis legado - TextBox somente-leitura com a
*     razao social da linha selecionada; permanece Enabled = .F. desde
*     a criacao, como o legado - PROCEDURE When retorna .F., ou seja,
*     o campo NUNCA entra em edicao)
*   - cmd_4c_Encerrar (ok legado - unico botao, fecha o dialogo)
* Propriedades Top/Left/Width/Height/FontName/cores/Caption transcritas
* EXATAS da SECAO 2 do dump (sigmvpen_form_codigo_fonte.txt). As
* propriedades de coluna que o legado so define em RUNTIME (PROCEDURE
* montagrades, chamado pelo Init) - FontName "Courier New" sobrescrevendo
* o "Arial" de design-time - tambem sao transcritas como o valor final
* que realmente aparece na tela (Courier New), nao o valor de design
* que o runtime substitui.
*
* Ordem de configuracao dentro do Grid (CLAUDE.md - "Column.Width vai
* por ULTIMO"): ColumnCount -> RecordSource -> Column.ControlSource
* SOMENTE DEPOIS de cursor_4c_Grade/cursor_4c_Rodape existirem (por
* isso THIS.this_oBusinessObject.CriarCursoresPendentes() roda ANTES
* de THIS.ConfigurarControles() - Column.ControlSource apontando para
* cursor inexistente derruba o Init, regra CLAUDE.md #41) -> so DEPOIS
* Column.Width e Header1.Caption (RecordSource/ControlSource resetam
* Width/Caption para o default se setados antes).
*
* Sem AlternarPagina(): nao ha Page nenhuma para alternar (PILAR 3,
* form FLAT). A carga de dados (equivalente a PROCEDURE selecionadados
* do legado, via BuscarPendentes() do Business Object) e a sincronia
* da grade com o rodape/getRClis a cada troca de linha (equivalente a
* AfterRowColChange) ficam para a fase de eventos (Fase 7/8) - os
* cursores aqui criados comecam VAZIOS (CriarCursoresPendentes() so
* declara a estrutura, nao popula), entao as grades abrem sem linhas
* ate aquela fase ligar os dados.
*
* FASE 5/8 - CAMPOS PRINCIPAIS (Page2 - Parte 1) - NAO SE APLICA
* -----------------------------------------------------------------
* O template desta fase pede ConfigurarPaginaDados() com a primeira
* metade dos TextBox/Label de um Page2/Dados. Este legado NAO TEM
* Page2/Dados nem campo de entrada NENHUM - e isso foi MEDIDO, nao
* presumido: a arvore do SCX (SECAO 1 do dump) lista 8 objetos, todos
* filhos DIRETOS do form (dataenvironment, Shape1, ok, grdItens com 8
* Column/Header/Text1, grdRodape com 3 Column/Header/Text1, getRClis);
* zero PageFrame, zero Page, zero Container. analise.json (gerado na
* fase de analise) confirma: "campos": [] e "lookups": [] vazios. O
* unico controle de entrada de dados e getRClis -> txt_4c_RClis, que
* JA foi criado na Fase 4 (ConfigurarControles(), acima) porque ele e
* filho direto do form, no MESMO nivel do Shape1/grades/botao - nao
* pertence a nenhuma "Page2" que nao existe. Criar um Page2/Dados ou
* dividir campos em metades aqui obrigaria a INVENTAR superficie que o
* original nao possui (viola o PILAR 1 e a regra "NUNCA inventar" de
* migration_guide.md), e duplicaria txt_4c_RClis (CLAUDE.md - "objeto
* ja existente" quebra o Init). Por isso NAO existe
* ConfigurarPaginaDados() neste form; a Fase 6/8 (segunda metade) tem
* o mesmo NAO SE APLICA pelo mesmo motivo. Mesmo padrao de
* FormSigMvPdt.prg (CAMPOS DE DADOS: o legado NAO TEM NENHUM).
*
* FASE 6/8 - CAMPOS RESTANTES E LOOKUPS - NAO SE APLICA
* -----------------------------------------------------------------
* O template desta fase pede a segunda metade dos TextBox/Label de
* Page2/Dados MAIS "TODOS os lookups com BINDEVENT (F4/F5) COMPLETAMENTE
* IMPLEMENTADOS". Pelo mesmo motivo da Fase 5 (NAO existe Page2/Dados -
* ver acima), nao ha segunda metade de campo para adicionar. E quanto a
* lookup, isto foi MEDIDO no dump (nao presumido): nenhuma ocorrencia de
* fwbuscaext/fwBuscaSel/fwBuscaInt, sigacess(), Acesso<X>(), PROCEDURE
* Valid ou mAddColuna em sigmvpen_form_codigo_fonte.txt - a UNICA
* chamada a CreateObject() no arquivo inteiro e ".poDataMgr =
* CreateObject([fSqlConector], .Name)" (linha 588), que eh o objeto de
* conexao SQL, nao um picker de busca. O unico controle de entrada
* (getRClis -> txt_4c_RClis) tem PROCEDURE When retornando .F. (nunca
* entra em edicao, so recebe .Value por codigo em AfterRowColChange) -
* campo somente-leitura nao tem onde o usuario digitar codigo para um
* lookup resolver. Inventar AbrirLookupXxx()/BINDEVENT de F4 aqui
* fabricaria funcionalidade que o legado nao possui, violando o PILAR 1
* e a regra "NUNCA inventar tabelas de lookup" (migration_guide.md). A
* sincronia grade -> rodape/getRClis a cada troca de linha (equivalente
* a AfterRowColChange do legado) fica para a Fase 7/8 (eventos) - ela
* NAO eh lookup, eh apenas leitura do registro corrente do cursor ja
* carregado na grade. Mesmo padrao de FormSigMvChv.prg (SIGMVCHV - grade
* digitada a mao, zero lookup).
*
* FASE 7/8 - EVENTOS PRINCIPAIS - REINTERPRETADA (sem botoes CRUD)
* -----------------------------------------------------------------
* O template desta fase pede BtnIncluirClick/BtnAlterarClick/
* BtnVisualizarClick/BtnExcluirClick - o mesmo template generico de
* form CRUD ja descartado nas Fases 4/5/6 (ver acima) porque o legado
* NAO TEM esses botoes (unico CommandButton eh "ok"/Encerrar). Nao ha
* o que criar aqui seguindo o template ao pe da letra.
*
* Em vez de pular a fase (o que deixaria o dialogo sem NENHUM dado -
* os cursores continuavam vazios desde a Fase 4, ver nota la), esta
* fase implementa os EVENTOS PRINCIPAIS REAIS do legado, que sao os
* que a analise comportamental (comportamento.json, 11 metodos) prova
* existirem:
*   - Init chama .SelecionaDados/.grdItens.Refresh/.grdRodape.Refresh/
*     .grdItens.Column1.Setfocus dentro de LockScreen=.T./.F. ->
*     THIS.CarregarPendentes(), chamado ao final de InicializarForm()
*     (ver acima), que aciona sigmvpenBO.BuscarPendentes("crSigMvEstPd")
*     - o cursor local de itens pendentes, equivalente a crSigMvEstPd
*     do legado, e responsabilidade do processo CHAMADOR (DataSession
*     compartilhada, this form NAO declara DataSession=2)
*   - grdItens.AfterRowColChange (12 linhas) -> GrdGradeAfterRowColChange
*     (bindado via BINDEVENT, LPARAMETERS par_nColIndex - CLAUDE.md
*     regra #3) chama AtualizarLinhaSelecionada(), que le a linha
*     corrente via sigmvpenBO.CarregarDoCursor (PILAR 3) e espelha
*     Empresa Destino/Usuario no rodape e a Razao Social em
*     txt_4c_RClis
*   - grdRodape.Column1.Text1.GotFocus (ThisForm.grdItens.Column1.
*     SetFocus) -> GrdRodapeCol1TextGotFocus
*   - grdRodape.Column2.Text1.GotFocus/LostFocus (This.Tag=This.Value /
*     This.Value=This.Tag) -> GrdRodapeCol2TextGotFocus/LostFocus
*   - getRClis.When (Return .F.) -> ja coberto pelo .Enabled = .F. do
*     txt_4c_RClis desde a criacao (Fase 4) - efeito identico (campo
*     nunca entra em edicao), sem precisar reimplementar When
* Sem AlternarPagina/HabilitarCampos/FormParaBO/BOParaForm: nao ha
* Page nem campo editavel para alternar/habilitar/mapear (PILAR 3,
* form FLAT de CONSULTA - ver cabecalho do arquivo).
*
* Parametro de Init (equivalente ao legado LParameters pKey):
*   par_cLpKey - Fk_chave: chave usada para filtrar os pendentes em
*                SigMvEstPd. Repassada para this_oBusinessObject no
*                CREATEOBJECT (sigmvpenBO.Init recebe par_cLpKey).
*
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL - REINTERPRETADA
* -----------------------------------------------------------------
* O template desta fase (generico para form CRUD) pede BtnBuscarClick,
* BtnEncerrarClick, BtnSalvarClick, BtnCancelarClick, FormParaBO/
* BOParaForm COMPLETOS, HabilitarCampos, LimparCampos, CarregarLista e
* AjustarBotoesPorModo. Nenhum desses itens tem correspondente real no
* legado (mesma constatacao, MEDIDA no dump, que ja descartou o
* template CRUD nas Fases 4/5/6/7 - ver acima):
*   - BtnBuscarClick     -> nao existe botao de busca/filtro; a carga
*     e automatica no Init (ja implementada em CarregarPendentes/Fase 7)
*   - BtnEncerrarClick   -> ja implementado na Fase 4/7 como
*     CmdEncerrarClick() (bindado ao unico CommandButton do form,
*     cmd_4c_Encerrar); nome do handler segue o padrao Cmd<Nome>Click
*     ja usado nos outros handlers bindados deste mesmo arquivo
*     (CmdEncerrarClick, GrdGradeAfterRowColChange, etc.), nao haveria
*     motivo para um segundo metodo duplicando o mesmo Click
*   - BtnSalvarClick/BtnCancelarClick -> nao ha Page2/Dados nem
*     gravacao (PILAR 3, ver NOTA final de sigmvpenBO.prg: Inserir/
*     Atualizar/ExecutarExclusao nao sao sobrescritos porque o legado
*     nunca grava - unico botao so fecha a tela)
*   - FormParaBO/BOParaForm -> mapeiam campo EDITAVEL entre Form e BO;
*     este dialogo nao tem nenhum (txt_4c_RClis e o unico controle de
*     entrada e permanece Enabled = .F. desde a Fase 4, replicando o
*     PROCEDURE When Return .F. do getRClis legado) - o que existe no
*     lugar e a leitura BO -> Form ja implementada em
*     AtualizarLinhaSelecionada() (Fase 7), equivalente ao
*     AfterRowColChange legado
*   - HabilitarCampos/LimparCampos -> nao ha campo editavel para
*     habilitar/desabilitar por modo, nem formulario de inclusao para
*     limpar (nao ha modos INCLUIR/ALTERAR/VISUALIZAR - o dialogo tem
*     um unico estado, de exibicao)
*   - CarregarLista -> equivalente real e CarregarPendentes() (Fase 7),
*     que popula as duas grades a partir de sigmvpenBO.BuscarPendentes
*   - AjustarBotoesPorModo -> nao ha modos nem botoes CRUD para ajustar
*     (unico botao, Encerrar, permanece sempre habilitado)
* Inventar esses metodos vazios ou como stubs redundantes violaria a
* regra de completude (nenhum TODO/stub permitido) e a regra "NUNCA
* inventar" (migration_guide.md) - a funcionalidade real do legado (11
* metodos, comportamento.json) ja esta 100% coberta desde a Fase 7:
* Init/Load/montagrades/Release/selecionadados (Business Object) +
* ok.Click + grdItens.AfterRowColChange + grdRodape.Column1/2.Text1.
* GotFocus/LostFocus + getRClis.When (Form). Compilacao verificada sem
* erros (COMPILE de sigmvpenBO.prg e Formsigmvpen.prg, 2026-09-25).
*
* Sem item de menu: SIGMVPEN e um dialogo de CONSULTA invocado com
* parametro (Fk_chave) pelo processo de movimentacao que precisa
* mostrar o saldo pendente - nunca foi um destino de menu no legado
* (nao ha "DO FORM sigmvpen" solto em nenhum ponto do acervo, so a
* instanciacao com o parametro pKey). Mesmo padrao de FormSigMvPdt.prg/
* FormSigMvChv.prg (nenhum dos dois tem entrada em menu.prg). Quando o
* form de movimentacao que abre este dialogo (SigMvCab/SigMvMvt, ainda
* em ProximasMigracoes/) for migrado, ele passara a chamar
* CREATEOBJECT("Formsigmvpen", <Fk_chave>).Show() diretamente - inventar
* uma entrada de menu aqui exigiria inventar tambem de onde viria o
* Fk_chave, o que a analise (analise.json: campos/lookups vazios) nao
* sustenta.
*====================================================================

DEFINE CLASS Formsigmvpen AS FormBase

    *-- Propriedade de filtro (equivalente a ThisForm.lpKey do legado,
    *-- recebida via Init e repassada ao Business Object)
    this_cMensagemErro = ""
    this_cLpKey = ""

    *-- Configuracoes visuais do dialogo (identicas ao SCX legado -
    *-- SECAO 2, objeto sigmvpen)
    Width          = 750
    Height         = 513
    BorderStyle    = 2
    AutoCenter     = .T.
    ControlBox     = .F.
    MaxButton      = .F.
    MinButton      = .F.
    Movable        = .F.
    WindowState    = 0
    AlwaysOnTop    = .F.
    Themes         = .F.
    Caption        = "Pendentes"
    ShowWindow     = 1
    WindowType     = 1

    *--------------------------------------------------------------------------
    * Init - Recebe o mesmo parametro posicional do legado (pKey) e o
    * grava em this_cLpKey ANTES de DODEFAULT() acionar FormBase.Init()
    * (que chama InicializarForm()).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cLpKey)
        THIS.this_cLpKey = TratarNulo(par_cLpKey, "")

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Hook chamado por FormBase.Init(). Equivalente a
    * ".poDataMgr = CreateObject([fSqlConector], .Name) / If
    * (.poDataMgr.pnIdconn > 0)" do Init legado: instancia o Business
    * Object (que usa o handle de conexao global gnConnHandle, ja aberto
    * pelo startup da aplicacao - nao ha conexao privada por form na
    * nova arquitetura) e configura as propriedades visuais restantes.
    *
    * Este dialogo NAO tem PageFrame nem paginas Lista/Dados: o legado
    * e um form FLAT sem nenhum container (ver comentario de cabecalho
    * acima). As grades, o botao Encerrar e o TextBox de razao social
    * sao criados em ConfigurarControles(), chamado logo abaixo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("sigmvpenBO", THIS.this_cLpKey)

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Cursores DEVEM existir antes do Grid.Column.ControlSource
                *-- apontar para eles (CLAUDE.md #41) - equivalente ao
                *-- PROCEDURE Load do legado (Create Cursor crGrade/crRodape),
                *-- que roda antes do Init.
                THIS.this_oBusinessObject.CriarCursoresPendentes()

                THIS.ConfigurarControles()

                *-- Equivalente a ".SelecionaDados / .grdItens.Refresh /
                *-- .grdRodape.Refresh / .grdItens.Column1.Setfocus" do
                *-- Init legado (dentro do bloco LockScreen=.T./.F.).
                THIS.CarregarPendentes()

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel criar o objeto de neg" + CHR(243) + "cio sigmvpenBO"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarControles - Cria os controles do dialogo, filhos DIRETOS
    * do form (sem Page/Container - PILAR 3, ver cabecalho do arquivo).
    * Replica a arvore do SCX legado (SECAO 1) e as propriedades da
    * SECAO 2 do dump, incluindo o que o PROCEDURE montagrades legado
    * sobrescreve em runtime (FontName "Courier New" das colunas, que
    * substitui o "Arial" de design-time).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarControles()
        LOCAL loc_cCursorGrade, loc_cCursorRodape
        loc_cCursorGrade  = THIS.this_oBusinessObject.this_cCursorGrade
        loc_cCursorRodape = THIS.this_oBusinessObject.this_cCursorRodape

        *-- Shape1 - moldura decorativa ao redor do botao Encerrar
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 654
            .Height      = 110
            .Width       = 90
            .BackStyle   = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- grdItens -> grd_4c_Grade (8 colunas, itens pendentes)
        THIS.AddObject("grd_4c_Grade", "Grid")
        WITH THIS.grd_4c_Grade
            .Top               = 131
            .Left              = 13
            .Height            = 326
            .Width             = 724
            .FontName          = "Courier New"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 17
            .ReadOnly          = .T.
            .ScrollBars        = 2
            .ColumnCount       = 8
            .RecordSource      = loc_cCursorGrade

            .Column1.ControlSource = loc_cCursorGrade + ".Emps"
            .Column2.ControlSource = loc_cCursorGrade + ".Dopes"
            .Column3.ControlSource = loc_cCursorGrade + ".Numes"
            .Column3.InputMask     = "999999"
            .Column4.ControlSource = loc_cCursorGrade + ".Datas"
            .Column5.ControlSource = loc_cCursorGrade + ".GrupoDs"
            .Column6.ControlSource = loc_cCursorGrade + ".ContaDs"
            .Column7.ControlSource = loc_cCursorGrade + ".PrazoEnts"
            .Column8.ControlSource = loc_cCursorGrade + ".Pendentes"
            .Column8.InputMask     = "9999999.99"

            *-- Width/Header/cores DEPOIS do RecordSource+ControlSource
            *-- (senao o VFP9 reseta as larguras para o default 90)
            .Column1.Width  = 31
            .Column2.Width  = 206
            .Column3.Width  = 60
            .Column4.Width  = 80
            .Column5.Width  = 80
            .Column6.Width  = 80
            .Column7.Width  = 80
            .Column8.Width  = 80
            .Column8.FontBold  = .T.
            .Column8.BackColor = RGB(255, 255, 223)

            *-- Header1 mantem FontName/FontSize de DESIGN-TIME (Arial 8) -
            *-- o loop runtime do legado so troca Column.FontName/Text1.FontName
            *-- (celulas de dado), nunca Header1.FontName.
            .Column1.Header1.Caption   = "Emp"
            .Column1.Header1.FontName  = "Arial"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.FontName  = "Arial"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column3.Header1.Caption   = "C" + CHR(243) + "digo"
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.Alignment = 2
            .Column4.Header1.Caption   = "Data"
            .Column4.Header1.FontSize  = 8
            .Column4.Header1.Alignment = 2
            .Column5.Header1.Caption   = "Grupo"
            .Column5.Header1.FontSize  = 8
            .Column5.Header1.Alignment = 2
            .Column6.Header1.Caption   = "Conta"
            .Column6.Header1.FontSize  = 8
            .Column6.Header1.Alignment = 2
            .Column7.Header1.Caption   = "Data / Entrega"
            .Column7.Header1.FontSize  = 8
            .Column7.Header1.Alignment = 2
            .Column8.Header1.Caption   = "Qtde"
            .Column8.Header1.FontSize  = 8
            .Column8.Header1.Alignment = 2

            .Column1.Movable = .F.
            .Column2.Movable = .F.
            .Column3.Movable = .F.
            .Column4.Movable = .F.
            .Column5.Movable = .F.
            .Column6.Movable = .F.
            .Column7.Movable = .F.
            .Column8.Movable = .F.

            .Column1.Resizable = .F.
            .Column2.Resizable = .F.
            .Column3.Resizable = .F.
            .Column4.Resizable = .F.
            .Column5.Resizable = .F.
            .Column6.Resizable = .F.
            .Column7.Resizable = .F.
            .Column8.Resizable = .F.

            .Column1.ReadOnly = .T.
            .Column2.ReadOnly = .T.
            .Column3.ReadOnly = .T.
            .Column4.ReadOnly = .T.
            .Column5.ReadOnly = .T.
            .Column6.ReadOnly = .T.
            .Column7.ReadOnly = .T.
            .Column8.ReadOnly = .T.

            .Column1.Text1.FontName    = "Courier New"
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ForeColor   = RGB(0, 0, 0)
            .Column1.Text1.BackColor   = RGB(255, 255, 255)

            .Column2.Text1.FontName    = "Courier New"
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 255)

            .Column3.Text1.FontName    = "Courier New"
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin      = 0
            .Column3.Text1.ForeColor   = RGB(0, 0, 0)
            .Column3.Text1.BackColor   = RGB(255, 255, 255)

            .Column4.Text1.FontName    = "Courier New"
            .Column4.Text1.BorderStyle = 0
            .Column4.Text1.Margin      = 0
            .Column4.Text1.ForeColor   = RGB(0, 0, 0)
            .Column4.Text1.BackColor   = RGB(255, 255, 255)

            .Column5.Text1.FontName    = "Courier New"
            .Column5.Text1.FontBold    = .F.
            .Column5.Text1.Alignment   = 3
            .Column5.Text1.BorderStyle = 0
            .Column5.Text1.Margin      = 0
            .Column5.Text1.ForeColor   = RGB(0, 0, 0)
            .Column5.Text1.BackColor   = RGB(255, 255, 255)

            .Column6.Text1.FontName    = "Courier New"
            .Column6.Text1.BorderStyle = 0
            .Column6.Text1.Margin      = 0
            .Column6.Text1.ForeColor   = RGB(0, 0, 0)
            .Column6.Text1.BackColor   = RGB(255, 255, 255)

            .Column7.Text1.FontName    = "Courier New"
            .Column7.Text1.FontBold    = .F.
            .Column7.Text1.BorderStyle = 0
            .Column7.Text1.Margin      = 0
            .Column7.Text1.ForeColor   = RGB(0, 0, 0)
            .Column7.Text1.BackColor   = RGB(255, 255, 255)

            .Column8.Text1.FontName    = "Courier New"
            .Column8.Text1.FontBold    = .T.
            .Column8.Text1.BorderStyle = 0
            .Column8.Text1.Margin      = 0
            .Column8.Text1.ForeColor   = RGB(0, 0, 0)
            .Column8.Text1.BackColor   = RGB(255, 255, 223)

            .Visible = .T.
        ENDWITH

        *-- grdRodape -> grd_4c_Rodape (3 colunas, total geral)
        THIS.AddObject("grd_4c_Rodape", "Grid")
        WITH THIS.grd_4c_Rodape
            .Top               = 453
            .Left              = 13
            .Height            = 23
            .Width             = 724
            .FontName          = "Courier New"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 4
            .ReadOnly          = .T.
            .ScrollBars        = 2
            .ColumnCount       = 3
            .RecordSource      = loc_cCursorRodape

            .Column1.ControlSource = loc_cCursorRodape + ".Descrs"
            .Column2.ControlSource = loc_cCursorRodape + ".Usuars"
            .Column3.ControlSource = loc_cCursorRodape + ".Pendentes"
            .Column3.InputMask     = "9999999.99"

            .Column1.Width = 542
            .Column2.Width = 80
            .Column3.Width = 80

            .Column1.Header1.Caption   = ""
            .Column1.Header1.FontName  = "Courier New"
            .Column1.Header1.BackColor = RGB(255, 255, 0)
            .Column2.Header1.Caption   = ""
            .Column2.Header1.FontName  = "Courier New"
            .Column2.Header1.BackColor = RGB(255, 255, 0)
            .Column3.Header1.Caption   = ""
            .Column3.Header1.FontName  = "Courier New"
            .Column3.Header1.BackColor = RGB(255, 255, 0)

            .Column1.Movable   = .F.
            .Column2.Movable   = .F.
            .Column3.Movable   = .F.
            .Column1.Resizable = .F.
            .Column2.Resizable = .F.
            .Column3.Resizable = .F.
            .Column1.ReadOnly  = .T.
            .Column2.ReadOnly  = .T.
            .Column3.ReadOnly  = .T.
            .Column1.BackColor = RGB(255, 255, 223)
            .Column2.BackColor = RGB(255, 255, 223)
            .Column2.FontBold  = .T.
            .Column3.BackColor = RGB(255, 255, 223)
            .Column3.FontBold  = .T.

            .Column1.Text1.FontName    = "Courier New"
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ForeColor   = RGB(0, 0, 0)
            .Column1.Text1.BackColor   = RGB(255, 255, 223)

            .Column2.Text1.FontName    = "Courier New"
            .Column2.Text1.FontBold    = .T.
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 223)

            .Column3.Text1.FontName    = "Courier New"
            .Column3.Text1.FontBold    = .T.
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin      = 0
            .Column3.Text1.ForeColor   = RGB(0, 0, 0)
            .Column3.Text1.BackColor   = RGB(255, 255, 223)

            .Visible = .T.
        ENDWITH

        *-- getRClis -> txt_4c_RClis (TextBox somente-leitura, razao
        *-- social da linha selecionada). Enabled = .F. desde a criacao:
        *-- o legado tem PROCEDURE When retornando .F., ou seja, o campo
        *-- NUNCA entra em edicao - so recebe .Value por codigo.
        THIS.AddObject("txt_4c_RClis", "TextBox")
        WITH THIS.txt_4c_RClis
            .Top                = 476
            .Left               = 13
            .Height             = 20
            .Width              = 724
            .FontName           = "Courier New"
            .FontSize           = 9
            .SpecialEffect      = 1
            .Enabled            = .F.
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 223)
            .DisabledForeColor  = RGB(0, 0, 0)
            .DisabledBackColor  = RGB(255, 255, 223)
            .BorderColor        = RGB(192, 192, 192)
            .Value              = ""
            .Visible            = .T.
        ENDWITH

        *-- ok -> cmd_4c_Encerrar (unico botao do dialogo - fecha a tela)
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top       = 12
            .Left = 5
            .Height    = 75
            .Width     = 75
            .FontName  = "Verdana"
            .FontSize  = 8
            .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel    = .T.
            .Caption   = "Encerrar"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible   = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")

        *-- Equivalente ao PROCEDURE AfterRowColChange de grdItens (troca de
        *-- linha na grade principal atualiza o rodape e a razao social).
        BINDEVENT(THIS.grd_4c_Grade, "AfterRowColChange", THIS, "GrdGradeAfterRowColChange")

        *-- Equivalente a grdRodape.Column1.Text1.GotFocus (devolve o foco
        *-- para a grade principal - a celula do rodape eh so vitrine).
        BINDEVENT(THIS.grd_4c_Rodape.Column1.Text1, "GotFocus", THIS, "GrdRodapeCol1TextGotFocus")

        *-- Equivalente ao par GotFocus/LostFocus de grdRodape.Column2.Text1
        *-- (guarda o valor em .Tag ao entrar e o restaura ao sair, para a
        *-- celula nunca aceitar edicao mesmo sendo alcancada via Tab).
        BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "GotFocus", THIS, "GrdRodapeCol2TextGotFocus")
        BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "KeyPress", THIS, "GrdRodapeCol2TextLostFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdEncerrarClick - Equivalente ao PROCEDURE Click do "ok" legado
    * (ThisForm.Release). PUBLIC porque e bindado via BINDEVENT (CLAUDE.md
    * regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CmdEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdGradeAfterRowColChange - Equivalente ao PROCEDURE AfterRowColChange
    * de grdItens do legado: a cada troca de linha/coluna na grade principal,
    * espelha Empresa Destino + Usuario no rodape e a Razao Social no
    * txt_4c_RClis. PUBLIC + LPARAMETERS porque e bindado via BINDEVENT
    * (CLAUDE.md regra #3 - o evento nativo AfterRowColChange manda
    * nColIndex).
    *--------------------------------------------------------------------------
    PROCEDURE GrdGradeAfterRowColChange(par_nColIndex)
        THIS.AtualizarLinhaSelecionada()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdRodapeCol1TextGotFocus - Equivalente ao GotFocus de
    * grdRodape.Column1.Text1 do legado (ThisForm.grdItens.Column1.SetFocus):
    * a celula do rodape eh somente vitrine, entao ao ganhar foco (Tab a
    * partir da grade principal) devolve o foco para a grade de itens.
    * PUBLIC porque e bindado via BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE GrdRodapeCol1TextGotFocus()
        THIS.grd_4c_Grade.Column1.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdRodapeCol2TextGotFocus / GrdRodapeCol2TextLostFocus - Equivalente ao
    * par GotFocus (This.Tag = This.Value) / LostFocus (This.Value = This.Tag)
    * de grdRodape.Column2.Text1 do legado: guarda o valor corrente em .Tag ao
    * entrar e o restaura ao sair, para a celula nunca aceitar edicao. PUBLIC
    * porque sao bindados via BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE GrdRodapeCol2TextGotFocus()
        THIS.grd_4c_Rodape.Column2.Text1.Tag = THIS.grd_4c_Rodape.Column2.Text1.Value
    ENDPROC

    PROCEDURE GrdRodapeCol2TextLostFocus()
        THIS.grd_4c_Rodape.Column2.Text1.Value = THIS.grd_4c_Rodape.Column2.Text1.Tag
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPendentes - Equivalente ao trecho do Init legado que fica entre
    * LockScreen = .T. e LockScreen = .F.: ".MontaGrades" ja aconteceu em
    * ConfigurarControles() (chamada antes deste metodo, ainda em
    * InicializarForm), entao aqui resta ".SelecionaDados" (BuscarPendentes),
    * o Refresh das duas grades e o SetFocus na primeira coluna da grade de
    * itens. O cursor de itens pendentes (equivalente a crSigMvEstPd do
    * legado) e responsabilidade do processo CHAMADOR deste dialogo - ver
    * BuscarPendentes() em sigmvpenBO.prg.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarPendentes()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.LockScreen = .T.

        IF THIS.this_oBusinessObject.BuscarPendentes("crSigMvEstPd")
            THIS.grd_4c_Grade.Refresh()
            THIS.grd_4c_Rodape.Refresh()

            THIS.AtualizarLinhaSelecionada()

            THIS.grd_4c_Grade.Column1.SetFocus()

            loc_lSucesso = .T.
        ELSE
            IF !EMPTY(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMensagemErro, "")))
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
            ENDIF
        ENDIF

        THIS.LockScreen = .F.

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarLinhaSelecionada - Le a linha corrente de cursor_4c_Grade via
    * sigmvpenBO.CarregarDoCursor (PILAR 3: leitura de dados no BO, nao no
    * Form) e espelha Empresa Destino + Usuario (rodape) e Razao Social
    * (txt_4c_RClis) - equivalente ao corpo do AfterRowColChange legado.
    * Chamado tanto pela carga inicial (CarregarPendentes) quanto a cada
    * troca de linha (GrdGradeAfterRowColChange).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarLinhaSelecionada()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        IF loc_oBO.CarregarDoCursor(loc_oBO.this_cCursorGrade)
            THIS.grd_4c_Rodape.Column1.Text1.Value = "Empresa Destino : " + loc_oBO.this_cEmpDs
            THIS.grd_4c_Rodape.Column2.Text1.Value = loc_oBO.this_cUsuars
            THIS.txt_4c_RClis.Value = loc_oBO.this_cRClis

            THIS.grd_4c_Rodape.Column1.Refresh()
            THIS.grd_4c_Rodape.Column2.Refresh()
            THIS.txt_4c_RClis.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha os cursores de trabalho do Business Object
    * (cursor_4c_Grade/cursor_4c_Rodape, equivalentes a crGrade/crRodape
    * do legado, criados por sigmvpenBO.CriarCursoresPendentes) antes de
    * liberar this_oBusinessObject via heranca. Equivalente ao
    * "ThisForm.poDataMgr.Release" do PROCEDURE Release legado - aqui
    * nao ha conexao privada por form para liberar (gnConnHandle e
    * global), entao o que resta a fechar sao os cursores locais.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Grade")
            USE IN cursor_4c_Grade
        ENDIF
        IF USED("cursor_4c_Rodape")
            USE IN cursor_4c_Rodape
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigmvpenBO.prg):
*====================================================================
* sigmvpenBO.prg
*
* Business Object para Pendentes de Movimentacao (SIGMVPEN)
* Formulario OPERACIONAL: consulta de itens pendentes de recebimento/
* transferencia, agrupados por Empresa/Operacao/Numero.
*
* Nao existe tabela unica: o detalhe (cursor_4c_Grade) vem de um JOIN
* entre SigMvEstPd (saldo pendente), SigMvCab (dados da movimentacao) e
* SigCdCli (razao social do cliente/fornecedor). SigMvEstPd e a tabela
* de origem do filtro, por isso THIS.this_cTabela aponta para ela.
*
* Chave de filtro: Fk_chave (equivalente a ThisForm.lpKey / LParameters
* pKey do Init do form legado sigmvpen)
*
* Herda de: BusinessBase
*
* Metodos principais: CriarCursoresPendentes/BuscarPendentes (carga de dados,
* equivalentes a Load/selecionadados do legado) e CarregarDoCursor (linha
* selecionada da grade, equivalente ao AfterRowColChange do legado).
*====================================================================

DEFINE CLASS sigmvpenBO AS BusinessBase

    *-- Propriedade de filtro (equivalente a ThisForm.lpKey do form legado)
    this_cLpKey        = ""    && Fk_chave - chave usada para filtrar SigMvEstPd

    *-- Nomes dos cursores de trabalho (grade principal e rodape/legenda)
    this_cCursorGrade  = "cursor_4c_Grade"    && detalhe: Emps/Dopes/Numes/GrupoDs/ContaDs/Usuars/Datas/PrazoEnts/Pendentes/EmpDs/RClis
    this_cCursorRodape = "cursor_4c_Rodape"   && totais/legenda da linha selecionada: Descrs/Usuars/Pendentes

    *-- Propriedades da LINHA SELECIONADA na grade (equivalente ao que o
    *-- AfterRowColChange do legado le direto de crGrade.<campo>). Preenchidas
    *-- por CarregarDoCursor(THIS.this_cCursorGrade) a cada troca de linha.
    this_cEmps         = ""    && crGrade.Emps
    this_cDopes        = ""    && crGrade.Dopes
    this_nNumes        = 0     && crGrade.Numes
    this_cGrupoDs      = ""    && crGrade.GrupoDs
    this_cContaDs      = ""    && crGrade.ContaDs
    this_cRClis        = ""    && crGrade.RClis
    this_cUsuars       = ""    && crGrade.Usuars
    this_dDatas        = {}    && crGrade.Datas
    this_dPrazoEnts    = {}    && crGrade.PrazoEnts
    this_cEmpDs        = ""    && crGrade.EmpDs
    this_nPendentes    = 0     && crGrade.Pendentes

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * par_cLpKey: chave (Fk_chave) usada para filtrar os pendentes. Equivale
    * ao LParameters pKey do Init do form legado sigmvpen, que o form
    * repassava para ThisForm.lpKey antes de montar as grades.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cLpKey)
        DODEFAULT("SigMvEstPd")

        THIS.this_cCampoChave = "Fk_chave"

        IF VARTYPE(par_cLpKey) = "C"
            THIS.this_cLpKey = par_cLpKey
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursoresPendentes - Cria (ou recria) os cursores de trabalho com a
    * MESMA estrutura e ORDEM DE CAMPOS em todos os pontos que os usam (Form e
    * BO) - equivalente ao "Create Cursor crGrade"/"Create Cursor crRodape" do
    * PROCEDURE Load do form legado. Chamado pelo Form (InicializarForm) e
    * internamente por BuscarPendentes() para garantir a estrutura antes de
    * popular.
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursoresPendentes()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                USE IN (THIS.this_cCursorGrade)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorGrade) (Emps C(3), Dopes C(20), Numes N(6), ;
                GrupoDs C(10), ContaDs C(10), Usuars C(10), Datas D, PrazoEnts D, ;
                Pendentes N(10,3), EmpDs C(3), RClis C(50))

            SELECT (THIS.this_cCursorGrade)
            INDEX ON DTOS(PrazoEnts) + DTOS(Datas) + Emps + Dopes + STR(Numes, 6) TAG Ordem

            IF USED(THIS.this_cCursorRodape)
                USE IN (THIS.this_cCursorRodape)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorRodape) (Descrs C(100), Usuars C(10), Pendentes N(10,3))

            loc_lSucesso = .T.
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MsgErro(loException.Message, "Erro em sigmvpenBO.CriarCursoresPendentes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPendentes - Equivalente ao PROCEDURE selecionadados do legado.
    *
    * par_cCursorEstPd: alias do cursor LOCAL, ja aberto na sessao, com os
    * itens pendentes (Fk_chave/EmpDopNums/Qtds) - equivalente a crSigMvEstPd
    * do form legado. Esse cursor NAO vem de uma tabela chamada "SigMvEstPd"
    * (ela nao existe no schema - a tabela real e SigMvEst, com colunas
    * totalmente diferentes de Fk_chave/EmpDopNums/Qtds); no sistema legado ele
    * e montado pelo processo CHAMADOR (a tela de movimentacao que abre este
    * dialogo) e permanece visivel aqui porque sigmvpen usa DataSession=1
    * (sessao compartilhada, nao privada). Por isso o parametro: quem chama
    * este BO e responsavel por ja ter esse cursor populado.
    *
    * Para cada grupo (EmpDopNums, Sum(Qtds)) dentro do Fk_chave filtrado,
    * busca no SQL Server o cabecalho da movimentacao (SigMvCab) e a razao
    * social do cliente/fornecedor (SigCdCli), e grava uma linha no cursor de
    * grade (this_cCursorGrade). Ao final, grava o total geral no cursor de
    * rodape (this_cCursorRodape).
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPendentes(par_cCursorEstPd)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nTotalPendentes, ;
              loc_dDatas, loc_dPrazoEnts
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cCursorEstPd) != "C" OR !USED(par_cCursorEstPd)
                THIS.this_cMensagemErro = "Cursor de itens pendentes n" + CHR(227) + "o localizado."
                RETURN .F.
            ENDIF

            THIS.CriarCursoresPendentes()

            SELECT (THIS.this_cCursorGrade)
            ZAP
            SELECT (THIS.this_cCursorRodape)
            ZAP

            *-- Equivalente a:
            *-- Select Distinct EmpDopNums, Sum(Qtds) as Qtds From crSigMvEstPd
            *--  Where Fk_chave = ThisForm.lpKey
            *--  Order By EmpDopNums Group By EmpDopNums Into Cursor LocalEstPd
            IF USED("cursor_4c_LocalEstPd")
                USE IN cursor_4c_LocalEstPd
            ENDIF

            SELECT DISTINCT EmpDopNums, SUM(Qtds) AS Qtds ;
                FROM (par_cCursorEstPd) ;
                WHERE Fk_chave = THIS.this_cLpKey ;
                GROUP BY EmpDopNums ;
                ORDER BY EmpDopNums ;
                INTO CURSOR cursor_4c_LocalEstPd READWRITE

            SELECT cursor_4c_LocalEstPd
            SCAN
                *-- Equivalente a:
                *-- Select a.Emps, a.EmpDs, a.Dopes, a.Numes, a.GrupoDs, a.ContaDs,
                *--        b.RClis, a.Usuars, a.Datas, a.PrazoEnts
                *--   From SigMvCab a, SigCdCli b
                *--  Where a.EmpDopNums = '<EmpDopNums>' And a.ContaDs = b.IClis
                loc_cSQL = "SELECT a.Emps, a.EmpDs, a.Dopes, a.Numes, a.grupods AS GrupoDs,"
                loc_cSQL = loc_cSQL + " a.contads AS ContaDs, b.rclis AS RClis, a.Usuars,"
                loc_cSQL = loc_cSQL + " a.Datas, a.prazoents AS PrazoEnts"
                loc_cSQL = loc_cSQL + " FROM SigMvCab a, SigCdCli b"
                loc_cSQL = loc_cSQL + " WHERE a.empdopnums = " + EscaparSQL(cursor_4c_LocalEstPd.EmpDopNums)
                loc_cSQL = loc_cSQL + " AND a.contads = b.iclis"

                IF USED("cursor_4c_EstDet")
                    USE IN cursor_4c_EstDet
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstDet")

                IF loc_nResultado < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (EstDet)")
                    SELECT cursor_4c_LocalEstPd
                    LOOP
                ENDIF

                SELECT cursor_4c_EstDet
                SCAN
                    IF ISNULL(cursor_4c_EstDet.Datas)
                        loc_dDatas = {}
                    ELSE
                        loc_dDatas = TTOD(cursor_4c_EstDet.Datas)
                    ENDIF

                    IF ISNULL(cursor_4c_EstDet.PrazoEnts)
                        loc_dPrazoEnts = {}
                    ELSE
                        loc_dPrazoEnts = TTOD(cursor_4c_EstDet.PrazoEnts)
                    ENDIF

                    INSERT INTO (THIS.this_cCursorGrade) ;
                        (Emps, Dopes, Numes, GrupoDs, ContaDs, RClis, Usuars, Datas, PrazoEnts, EmpDs, Pendentes) ;
                        VALUES ;
                        (cursor_4c_EstDet.Emps, cursor_4c_EstDet.Dopes, cursor_4c_EstDet.Numes, ;
                         cursor_4c_EstDet.GrupoDs, cursor_4c_EstDet.ContaDs, cursor_4c_EstDet.RClis, ;
                         cursor_4c_EstDet.Usuars, loc_dDatas, loc_dPrazoEnts, cursor_4c_EstDet.EmpDs, ;
                         cursor_4c_LocalEstPd.Qtds)

                    SELECT cursor_4c_EstDet
                ENDSCAN

                IF USED("cursor_4c_EstDet")
                    USE IN cursor_4c_EstDet
                ENDIF

                SELECT cursor_4c_LocalEstPd
            ENDSCAN

            IF USED("cursor_4c_LocalEstPd")
                USE IN cursor_4c_LocalEstPd
            ENDIF

            *-- Equivalente a:
            *-- Select Sum(Pendentes) as Pendentes From crGrade Into Cursor crTotal
            *-- Insert Into crRodape (Pendentes) Values (crTotal.Pendentes)
            loc_nTotalPendentes = 0
            SELECT (THIS.this_cCursorGrade)
            SUM Pendentes TO loc_nTotalPendentes

            INSERT INTO (THIS.this_cCursorRodape) (Pendentes) VALUES (loc_nTotalPendentes)

            SELECT (THIS.this_cCursorGrade)
            GO TOP
            SELECT (THIS.this_cCursorRodape)
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MsgErro(loException.Message, "Erro em sigmvpenBO.BuscarPendentes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia a linha CORRENTE de this_cCursorGrade para as
    * propriedades this_*. Equivalente ao que o AfterRowColChange do grid
    * legado fazia lendo crGrade.<campo> diretamente - aqui o Form chama este
    * metodo do BO a cada troca de linha (PILAR 3: leitura de dados no BO,
    * nao no Form) e depois espelha this_cEmpDs/this_cUsuars/this_cRClis no
    * rodape e no getRClis.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF !EOF()
                    THIS.this_cEmps      = TratarNulo(Emps, "")
                    THIS.this_cDopes     = TratarNulo(Dopes, "")
                    THIS.this_nNumes     = TratarNulo(Numes, 0)
                    THIS.this_cGrupoDs   = TratarNulo(GrupoDs, "")
                    THIS.this_cContaDs   = TratarNulo(ContaDs, "")
                    THIS.this_cRClis     = TratarNulo(RClis, "")
                    THIS.this_cUsuars    = TratarNulo(Usuars, "")
                    THIS.this_dDatas     = ConverterParaData(Datas)
                    THIS.this_dPrazoEnts = ConverterParaData(PrazoEnts)
                    THIS.this_cEmpDs     = TratarNulo(EmpDs, "")
                    THIS.this_nPendentes = TratarNulo(Pendentes, 0)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvpenBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao ha PK de registro unico nesta tela (a "chave"
    * do dialogo eh o proprio filtro Fk_chave, compartilhado por todas as
    * linhas da grade). Sobrescrito apenas para o contrato de BusinessBase;
    * este BO nunca chama RegistrarAuditoria/Salvar/Excluir - ver nota abaixo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cLpKey, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * NOTA: Inserir()/Atualizar()/ExecutarExclusao() NAO sao sobrescritos.
    * O form legado sigmvpen e um dialogo de CONSULTA (o unico botao, "ok",
    * apenas fecha a tela com ThisForm.Release - nao ha INSERT/UPDATE/DELETE
    * em lugar nenhum do codigo original). Sobrescrever esses metodos aqui
    * inventaria gravacao que o legado nunca teve (violaria a paridade
    * funcional). Os defaults de BusinessBase (retornam .F. com mensagem
    * "nao implementado") permanecem corretos, pois Salvar()/Excluir() jamais
    * sao chamados por este BO/Form.
    *--------------------------------------------------------------------------

ENDDEFINE

