# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[30/10/2026 12:44:49] Erro ao Validar Produto: Connection handle is invalid.Linha: 469Procedure: carregarproduto
[30/10/2026 12:44:49] Erro ao Carregar Composição: Connection handle is invalid.Linha: 530Procedure: carregarcomposicao
[30/10/2026 12:44:49] Erro ao Carregar Composição: Connection handle is invalid.
[30/10/2026 12:44:50] Erro em InicializarForm: 'field' phrase is not found.Linha: 726Procedure: configurarfiltrotipo


### LOG DA ETAPA (06b_testeAutomatico):
[2026-10-30 12:44:49] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-30 12:44:49] [INFO] Config FPW: (nao fornecido)
[2026-10-30 12:44:49] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-30 12:44:49] [INFO] Timeout: 300 segundos
[2026-10-30 12:44:49] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aha5c42t.prg
[2026-10-30 12:44:49] [INFO] Conteudo do wrapper:
[2026-10-30 12:44:49] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigOpCpo', 'C:\4c\tasks\task710', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpCpo', 'C:\4c\tasks\task710', 'OPERACIONAL'
QUIT

[2026-10-30 12:44:49] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aha5c42t.prg
[2026-10-30 12:44:49] [INFO] VFP output esperado em: C:\4c\tasks\task710\vfp_output.txt
[2026-10-30 12:44:49] [INFO] Executando Visual FoxPro 9...
[2026-10-30 12:44:49] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aha5c42t.prg
[2026-10-30 12:44:49] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aha5c42t.prg
[2026-10-30 12:44:49] [INFO] Timeout configurado: 300 segundos
[2026-10-30 12:44:50] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-30 12:44:50] [INFO] VFP9 finalizado em 0.4974152 segundos
[2026-10-30 12:44:50] [INFO] Exit Code: 
[2026-10-30 12:44:50] [INFO] 
[2026-10-30 12:44:50] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-30 12:44:50] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aha5c42t.prg
[2026-10-30 12:44:50] [INFO] 
[2026-10-30 12:44:50] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-30 12:44:50] [INFO] * Auto-generated wrapper for parameters
[2026-10-30 12:44:50] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-30 12:44:50] [INFO] * Parameters: 'FormSigOpCpo', 'C:\4c\tasks\task710', 'OPERACIONAL'
[2026-10-30 12:44:50] [INFO] 
[2026-10-30 12:44:50] [INFO] * Anti-dialog protections for unattended execution
[2026-10-30 12:44:50] [INFO] SET SAFETY OFF
[2026-10-30 12:44:50] [INFO] SET RESOURCE OFF
[2026-10-30 12:44:50] [INFO] SET TALK OFF
[2026-10-30 12:44:50] [INFO] SET NOTIFY OFF
[2026-10-30 12:44:50] [INFO] SYS(2335, 0)
[2026-10-30 12:44:50] [INFO] 
[2026-10-30 12:44:50] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpCpo', 'C:\4c\tasks\task710', 'OPERACIONAL'
[2026-10-30 12:44:50] [INFO] QUIT
[2026-10-30 12:44:50] [INFO] 
[2026-10-30 12:44:50] [INFO] === Fim do Wrapper.prg ===
[2026-10-30 12:44:50] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigOpCpo",
  "timestamp": "20261030124450",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": false,
      "erro": "CREATEOBJECT retornou valor nao-objeto",
      "detalhes": ""
    }
  ],
  "resumo": {
    "total": 1,
    "passou": 0,
    "falhou": 1,
    "percentual": 0
  }
}



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCpo.prg):
*==============================================================================
* FormSigOpCpo.prg - Form OPERACIONAL: dialogo de selecao da Composicao de
* Produtos
* Migrado de: tasks/task710/SigOpCpo.SCX (SIGOPCPO)
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - dialogo unico modal
*
* O legado nao tem Page1=Lista/Page2=Dados: e um dialogo unico (WindowType=1,
* 1000x600, TitleBar=0, ControlBox=.F., Movable=.F.) aberto por um form PAI
* (PROCEDURE Init legado: LParameters pFrm, pKey / .ParentForm = pFrm /
* .ParentForm.Enabled = .f.). Mostra a composicao do produto informado em
* pKey numa grade (grdItens), deixa o usuario marcar os componentes
* desejados, totaliza as linhas marcadas numa 2a grade (grdRodape) e devolve
* a selecao ao fechar - btnConfirmar mantem so as linhas marcadas, btnSair
* descarta todas (ThisForm.Release, que reabilita o form pai).
*
* Fase 1/8 e Fase 2/8 (BO): SigOpCpoBO.prg - propriedades, Init,
* CarregarProduto/CarregarComposicao/CarregarTipos/AplicarFiltroTipo/
* AtualizarTotais/ConfirmarSelecao/CancelarSelecao/DecodificarImagem.
*
* Fase 3/8 - ESTRUTURA BASE: esqueleto da classe (propriedades, Init()
* recebendo form pai + produto, InicializarForm(), Destroy()) e o cabecalho
* (cnt_4c_Sombra/lbl_4c_LblSombra/lbl_4c_LblTitulo), com geometria
* TRANSCRITA do dump.
*
* Fase 4/8 (este bloco): grade de componentes (grd_4c_Itens, equivalente a
* grdItens) + grade de totais (grd_4c_Rodape, equivalente a grdRodape) +
* CommandGroup de saida (cmg_4c_Botoes, equivalente a cntBotoes) + o metodo
* CarregarDados() (equivalente a SelecionaDados/AtuaTotas), que popula os
* cursores da BO ANTES das grades serem montadas - Column.ControlSource
* exige o cursor ja existente (regra #41). ComboBox de tipos e Image
* (Fases 5-6) e os eventos reais (Check1 da grade, Valid do combo, Click
* dos botoes, DblClick da imagem - Fase 7) entram nos blocos seguintes.
*
* Fase 5/8: label + combobox de filtro por tipo de composicao
* (lbl_4c_Label1/cbo_4c_CmbTipos, equivalentes a Say1/cmbTipos do legado),
* ligado ao cursor_4c_Tipos ja populado pela BO em CarregarTipos().
*
* Fase 6/8 (este bloco): ultimos controles e a VALIDACAO DE CAMPO do
* legado, ligada por BINDEVENT -
*   - Image de zoom do componente (img_4c_ImgFigJpg, equivalente a
*     ImgFigJpg do legado) - nasce oculta, igual ao legado (regra de
*     container flutuante: excluida de TornarControlesVisiveis);
*   - ValidarFiltroTipo(): o PROCEDURE Valid do cmbTipos legado
*     (Select crGrade / Set Filter To Tipos = cmbTipos.Value In crGrade /
*     Go Top In crGrade / ThisForm.grdItens.Refresh), delegando a
*     THIS.this_oBusinessObject.AplicarFiltroTipo();
*   - AtualizarRodape(par_nRegistroGrade): funil UNICO de repintura da
*     grade + grade de totais + Buttons(1).Enabled (regra #21 - popular
*     cursor NAO repinta a grade; o repaint tem de rodar em TODO caminho
*     que mexe no cursor), chamado pela validacao do combo com 0 (GO TOP,
*     como o legado) e reusado na Fase 7 pelo toggle do checkbox, que
*     passa o RECNO para a grade nao saltar;
*   - ValidarFocoRodape(): o GotFocus de grdRodape.Column1.Text1 legado
*     (ThisForm.grdItens.Column1.SetFocus) - a grade de totais eh
*     somente-leitura e devolve o foco a grade de itens;
*   - ValidarTagRodapeGotFocus()/ValidarTagRodapeLostFocus(): o par
*     GotFocus (This.Tag = This.Value) / LostFocus (This.Value =
*     This.Tag) de grdRodape.Column2.Text1 legado, que restaura o valor
*     original da celula caso algo a tenha alterado.
*
* NAO HA LOOKUP (FormBuscaAuxiliar) NESTE FORM: o codigo fonte original
* (tasks/task710/SigOpCpo_form_codigo_fonte.txt) nao tem nenhum
* CreateObject('fwBuscaExt'/'fwBuscaSel',...) nem chamada a sigacess() nem
* PROCEDURE Valid/KeyPress abrindo picker por F4/F5 - este dialogo so
* exibe a composicao do produto-pai (grd_4c_Itens) com uma linha por
* componente para o usuario MARCAR/DESMARCAR (checkbox da Column1) e
* filtrar por tipo (cbo_4c_CmbTipos, ja ligado ao cursor_4c_Tipos). PILAR
* 1/migration_guide.md proibem inventar lookup que o legado nao tem, e
* por isso nao existe AbrirLookup*/AbrirBusca* aqui: a superficie de
* campo desta fase eh o combo de tipo + a validacao dele.
*
* Os eventos de ACAO (Check1 da grade, AfterRowColChange da grade, Click
* dos 2 botoes do cmg_4c_Botoes, Click da imagem) entram na Fase 7.
*==============================================================================

DEFINE CLASS FormSigOpCpo AS FormBase

    Height       = 600
    Width        = 1000
    Caption      = ""
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    Movable      = .F.
    MaxButton    = .F.
    MinButton    = .F.
    WindowType   = 0
    DataSession  = 1
    BorderStyle  = 2
    AutoCenter   = .T.

    *-- Form pai que abriu o dialogo (.ParentForm legado) - fica desabilitado
    *-- enquanto este dialogo estiver aberto e eh reabilitado no Destroy
    *-- (equivalente ao PROCEDURE Release legado: ThisForm.ParentForm.Enabled
    *-- = .t. / =DoDefault()).
    this_oFormPai = .NULL.

    *-- Produto-pai cuja composicao esta sendo exibida (.lpKey legado,
    *-- recebido via Init(par_oFormPai, par_cCpros) e repassado ao BO em
    *-- THIS.this_oBusinessObject.CarregarProduto()).
    this_cCprosParam = ""

    *-- Ultimo tipo de composicao de fato aplicado como filtro em
    *-- cursor_4c_Grade. Guarda de valor-nao-mudou de ValidarFiltroTipo():
    *-- o Valid do legado roda ao SAIR do combo, e aqui a validacao esta
    *-- ligada a DOIS eventos (InteractiveChange, para reagir na hora em que
    *-- o usuario escolhe o item do dropdown Style=2, e LostFocus, que eh o
    *-- equivalente literal do Valid). Sem esta guarda o filtro seria
    *-- reaplicado e a grade repintada duas vezes por escolha.
    this_cTipoFiltroAtual = ""

    *-- Guarda de reentrancia de ValidarFiltroTipo(): a repintura da grade
    *-- mexe no foco (grd_4c_Itens.Refresh) e pode redisparar o LostFocus do
    *-- combo, reentrando no proprio handler. Ligada pelo wrapper
    *-- ValidarFiltroTipo() e liberada por ele DEPOIS do corpo
    *-- (ValidarFiltroTipoExec()), para a flag nunca travar ligada quando o
    *-- corpo sair por um RETURN antecipado (regra #47).
    this_lEmFiltroTipo = .F.

    *-- Guarda de reentrancia de AtualizarRodape(), o funil UNICO de
    *-- sincronismo form <-> BO <-> controles desta tela (FormParaBO() ->
    *-- AtualizarTotais() -> BOParaForm()). O funil mexe no ponteiro de
    *-- cursor_4c_Grade (GO TOP / GO <recno>) e chama grd_4c_Itens.Refresh(),
    *-- e as duas coisas disparam o AfterRowColChange da grade, que por sua
    *-- vez chama o funil de novo. A cadeia termina sozinha (o 2o passe repoe
    *-- o ponteiro na MESMA linha e nao gera evento novo), mas depender disso
    *-- eh fragil: a flag garante que cada acao do usuario produza UM passe.
    this_lEmAtualizacao = .F.

    *--------------------------------------------------------------------------
    * Init - recebe o form pai e o produto, desabilita o pai (equivalente ao
    * ".ParentForm = pFrm / .ParentForm.Enabled = .f." do Init legado) e
    * delega o resto da inicializacao a FormBase.Init() -> InicializarForm().
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_cCpros)
        THIS.Caption = "Composi" + CHR(231) + CHR(227) + "o de Produtos"

        THIS.this_oFormPai = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .F.
        ENDIF

        THIS.this_cCprosParam = IIF(VARTYPE(par_cCpros) = "C", par_cCpros, "")

        *-- WindowType=1 (modal top-level) causaria TIMEOUT em VFP9 -T. Classe
        *-- definida com WindowType=0; producao restaura para modal aqui, fora
        *-- de teste/validacao de UI (mesmo padrao de FormSIGOPCCO/FormSigOpCcl).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object, valida o produto-pai
    * (equivalente ao CursorQuery(SigCdPro,...)+Release do Init legado quando
    * o produto nao existe) e monta o cabecalho. Grade/combo/botoes/imagem
    * entram nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste, loc_lProdutoOk
        loc_lSucesso = .F.
        loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                    (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCpoBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !THIS.this_oBusinessObject.Init()
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpCpoBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro em InicializarForm")
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                loc_lProdutoOk = THIS.this_oBusinessObject.CarregarProduto(THIS.this_cCprosParam)

                *-- "MessageBox('O Produto Informado Nao Existe!!!',...) /
                *-- .Release" do Init legado. Em validacao de UI / modo teste
                *-- o form e criado por CREATEOBJECT(classe) SEM form pai nem
                *-- codigo de produto - TestFormWrapper.prg (ETAPA 2) e
                *-- ValidarUIFidelity instanciam a classe direta, sem passar
                *-- par_oFormPai/par_cCpros - e CarregarProduto("") nunca acha
                *-- produto algum. Sem este desvio o dialogo abortava ANTES
                *-- de desenhar qualquer controle (InicializarForm devolvia
                *-- .F., FormBase.Init() tambem, e CREATEOBJECT no teste
                *-- retornava NULL) por um motivo que nao e defeito de UI -
                *-- mesmo padrao do FormSigMvSbn.InicializarForm. Em producao
                *-- (form pai de verdade, com produto real) o gate legado
                *-- continua intacto.
                IF !loc_lProdutoOk AND !loc_lModoValidacaoOuTeste
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                            "Aten" + CHR(231) + CHR(227) + "o!!!")
                ELSE
                    IF loc_lProdutoOk
                        THIS.Caption = ALLTRIM(THIS.Caption) + " - " + ;
                            ALLTRIM(THIS.this_oBusinessObject.this_cCpros) + " - " + ;
                            ALLTRIM(THIS.this_oBusinessObject.this_cDprosProduto)
                    ENDIF

                    THIS.ConfigurarCabecalho()

                    THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                    THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                    *-- CarregarDados() PRIMEIRO: popula cursor_4c_Grade/
                    *-- cursor_4c_Rodape via BO antes de qualquer Grid ser
                    *-- montado (regra #41 - Column.ControlSource exige o
                    *-- cursor ja existente).
                    THIS.CarregarDados()
                    THIS.ConfigurarGridItens()
                    THIS.ConfigurarGridRodape()
                    THIS.ConfigurarFiltroTipo()
                    THIS.ConfigurarBotoes()
                    THIS.ConfigurarImagem()

                    THIS.TornarControlesVisiveis(THIS)

                    *-- Trecho FINAL do selecionadados legado (Go Top +
                    *-- grdItens.Refresh + Column1.SetFocus + Go Top In
                    *-- crRodape + grdRodape.Refresh): popular o cursor NAO
                    *-- repinta a grade (regra #21), e o repaint tem de rodar
                    *-- DEPOIS de TornarControlesVisiveis - Refresh em
                    *-- controle invisivel nao pinta.
                    THIS.CarregarLista()

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
    * labels de titulo sobrepostos (sombra preta + titulo branco).
    * Geometria TRANSCRITA do dump: SIGOPCPO.cntSombra/lblSombra/lblTitulo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .AutoSize      = .F.
            .BackStyle     = 0
            .WordWrap      = .T.
            .Alignment     = 0
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .AutoSize    = .F.
            .BackStyle   = 0
            .WordWrap    = .T.
            .Alignment   = 0
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .Caption     = THIS.Caption
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - popula cursor_4c_Grade via
    * THIS.this_oBusinessObject.CarregarComposicao() (equivalente ao
    * Zap crGrade/crRodape + Insert Into crGrade do SelecionaDados legado),
    * cria a linha unica de cursor_4c_Rodape (Insert Into crRodape (Totas)
    * Values (0) legado) e calcula os totais iniciais apenas quando ha
    * componentes (If (Reccount([crGrade]) > 0).../AtuaTotas legado) - "Where
    * Marcas" eh criterio de negocio dentro de AtualizarTotais (regra #17).
    *
    * Roda ANTES de ConfigurarGridItens/ConfigurarGridRodape: os dois
    * cursores DEVEM existir quando as grades forem montadas (regra #41). Se
    * CarregarComposicao() falhar (SQL), cursor_4c_Grade pode nao ter sido
    * criado pela BO - o fallback abaixo garante a estrutura vazia com as
    * MESMAS colunas de SigOpCpoBO.CarregarComposicao(), para a grade montar
    * sem erro mesmo com a composicao vazia.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_cCursorGrade, loc_cCursorRodape
        loc_lSucesso      = .F.
        loc_cCursorGrade  = THIS.this_oBusinessObject.this_cCursorGrade
        loc_cCursorRodape = THIS.this_oBusinessObject.this_cCursorRodape

        IF THIS.this_oBusinessObject.CarregarComposicao()
            loc_lSucesso = .T.
        ELSE
            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Erro ao Carregar Composi" + CHR(231) + CHR(227) + "o")
        ENDIF

        IF !USED(loc_cCursorGrade)
            SET NULL ON
            CREATE CURSOR (loc_cCursorGrade) ;
                (Marcas L, Cidchaves C(20), Mats C(14), Dpros C(65), ;
                 Qtds N(8,3), UniCompos C(3), PCompos N(11,5), ;
                 Moeds C(3), Totas N(11,3), Etiqs C(1), Reffs C(40), ;
                 FigJpgs M, Tipos C(20))
            SET NULL OFF
        ENDIF

        IF USED(loc_cCursorRodape)
            USE IN (loc_cCursorRodape)
        ENDIF

        SET NULL ON
        CREATE CURSOR (loc_cCursorRodape) (Descrs C(100), Usuars C(10), Totas N(12,2))
        SET NULL OFF

        *-- "Insert Into crRodape (Totas) Values (0)" do selecionadados legado.
        *-- O REPLACE vai com "IN (<alias>)" EXPLICITO: AtualizarTotais() do
        *-- BO faz "SELECT ... INTO CURSOR <tmp>" seguido de "USE IN <tmp>", e
        *-- fechar o cursor CORRENTE deixa a work area VAZIA - um REPLACE sem
        *-- alias logo depois estoura "No table is open in the current work
        *-- area." e derruba o InicializarForm (o form nao abre).
        SELECT (loc_cCursorRodape)
        APPEND BLANK
        REPLACE Totas WITH 0 IN (loc_cCursorRodape)

        IF loc_lSucesso AND THIS.this_oBusinessObject.this_nQtdeComponentes > 0
            THIS.this_oBusinessObject.AtualizarTotais()
            REPLACE Totas WITH THIS.this_oBusinessObject.this_nTotalTotas ;
                IN (loc_cCursorRodape)
        ENDIF

        IF USED(loc_cCursorGrade)
            SELECT (loc_cCursorGrade)
            GO TOP
        ENDIF

        SELECT (loc_cCursorRodape)
        GO TOP

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridItens - grade de componentes da composicao (grdItens do
    * legado), ligada a cursor_4c_Grade (ja populado por CarregarDados()).
    * Geometria e colunas TRANSCRITAS do dump (SIGOPCPO.grdItens +
    * PROCEDURE montagrades): 8 colunas, Column.InputMask/ControlSource
    * sao propriedades que a Column repassa ao CurrentControl - igual ao
    * legado. Ordem de configuracao segue o padrao canonico (ColumnCount ->
    * RecordSource -> ControlSource -> Header1.Caption -> Width por ultimo -
    * Problema 48/regra #41): mexer em Width ANTES de RecordSource/
    * ControlSource estabilizarem reseta tudo para o default 90.
    *
    * Column1 recebe CheckBox via AddObject + CurrentControl + Sparse = .F.
    * (regra #18 - AddObject sozinho NAO faz o controle aparecer). O For
    * Movable/Resizable/ReadOnly do legado (.Column&lcCol..ReadOnly =
    * (I > 1)) foi transcrito coluna a coluna: Column1 fica EDITAVEL (o
    * checkbox), Column2-8 continuam ReadOnly - e o ReadOnly de Column vem
    * DEPOIS do ReadOnly do Grid (regra #18).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridItens()
        THIS.AddObject("grd_4c_Itens", "Grid")
        WITH THIS.grd_4c_Itens
            .Top               = 198
            .Left              = 10
            .Width             = 980
            .Height            = 371
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 16
            .RowHeight         = 18
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .ToolTipText       = "Grade de Produtos"
            .ReadOnly          = .T.
        ENDWITH

        *-- Vinculo ao cursor + colunas: extraido para VincularGradeItens()
        *-- porque CarregarLista() tem de poder REFAZE-LO (Problema 48 -
        *-- re-atribuir RecordSource reseta Column.Width/Header1.Caption e
        *-- destroi o CurrentControl do CheckBox). Chamado DEPOIS do
        *-- .ReadOnly = .T. do Grid, porque o ReadOnly do grid propaga para
        *-- as colunas e sobrescreveria o Column1.ReadOnly = .F. (regra #18).
        THIS.VincularGradeItens()

        WITH THIS.grd_4c_Itens
            .Visible = .T.
        ENDWITH

        *-- AfterRowColChange de SIGOPCPO.grdItens: decodifica a imagem do
        *-- componente corrente (equivalente a ImgFigJpg.Picture/Visible do
        *-- legado) e recalcula os totais (ThisForm.AtuaTotas). Nao filtra
        *-- par_nColIndex - carrega o detalhe da linha corrente, uso correto
        *-- deste evento (regra #46). Ligado AQUI, e nao em
        *-- VincularGradeItens(), porque o objeto Grid nunca eh recriado: um
        *-- 2o BINDEVENT do mesmo par (objeto, evento) somaria uma segunda
        *-- chamada ao mesmo handler a cada re-vinculo.
        BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGradeItens - liga grd_4c_Itens a cursor_4c_Grade e configura as
    * 8 colunas. Extraido de ConfigurarGridItens() para ser REUSADO por
    * CarregarLista(): a ordem canonica eh ColumnCount -> RecordSource ->
    * ControlSource -> Header1.Caption -> Width por ULTIMO (Problema 48 /
    * regra #41), porque re-atribuir RecordSource reseta Width e Caption para
    * o default 90/"Header1" e DESTROI o CurrentControl do CheckBox da
    * Column1 (regra #18) - quem re-vincula tem de repetir o bloco INTEIRO.
    *
    * ColumnCount so eh tocado quando esta diferente de 8: atribuir
    * ColumnCount RECRIA os objetos Column, matando o CheckBox e os
    * BINDEVENT dele. Por isso os 4 handlers do CheckBox sao ligados APENAS
    * no passe em que o controle de fato nasce (AddObject) - religar sem o
    * AddObject somaria uma 2a chamada do mesmo handler por evento, e o
    * toggle da marcacao se anularia.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularGradeItens()
        LOCAL loc_cCursor, loc_lCriouCheck
        loc_cCursor    = THIS.this_oBusinessObject.this_cCursorGrade
        loc_lCriouCheck = .F.

        WITH THIS.grd_4c_Itens
            IF .ColumnCount != 8
                .ColumnCount = 8
            ENDIF

            .RecordSource = loc_cCursor

            .Column1.ControlSource = loc_cCursor + ".Marcas"
            .Column2.ControlSource = loc_cCursor + ".Mats"
            .Column3.ControlSource = loc_cCursor + ".Dpros"
            .Column4.ControlSource = loc_cCursor + ".Qtds"
            .Column5.ControlSource = loc_cCursor + ".UniCompos"
            .Column6.ControlSource = loc_cCursor + ".PCompos"
            .Column7.ControlSource = loc_cCursor + ".Moeds"
            .Column8.ControlSource = loc_cCursor + ".Totas"

            .Column1.Header1.Caption = ""
            .Column2.Header1.Caption = "Item"
            .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column4.Header1.Caption = "Qtde."
            .Column5.Header1.Caption = "Uni"
            .Column6.Header1.Caption = "Valor Unit" + CHR(225) + "rio"
            .Column7.Header1.Caption = "Moe"
            .Column8.Header1.Caption = "Valor Total"

            .Column4.InputMask = "99999.999"
            .Column6.InputMask = "99999999.999"
            .Column8.InputMask = "99999999.99"

            .Column1.Width = 15
            .Column2.Width = 120
            .Column3.Width = 394
            .Column4.Width = 120
            .Column5.Width = 31
            .Column6.Width = 120
            .Column7.Width = 31
            .Column8.Width = 120

            .Column1.FontName  = "Verdana"
            .Column1.FontSize  = 8
            .Column2.FontName  = "Verdana"
            .Column2.FontSize  = 8
            .Column3.FontName  = "Verdana"
            .Column3.FontSize  = 8
            .Column4.FontName  = "Verdana"
            .Column4.FontSize  = 8
            .Column5.FontName  = "Verdana"
            .Column5.FontSize  = 8
            .Column6.FontName  = "Verdana"
            .Column6.FontSize  = 8
            .Column7.FontName  = "Verdana"
            .Column7.FontSize  = 8
            .Column8.FontBold  = .T.
            .Column8.FontName  = "Verdana"
            .Column8.FontSize  = 8
            .Column8.BackColor = RGB(245, 251, 136)

            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.ReadOnly  = .F.
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.ReadOnly  = .T.
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column3.ReadOnly  = .T.
            .Column4.Movable   = .F.
            .Column4.Resizable = .F.
            .Column4.ReadOnly  = .T.
            .Column5.Movable   = .F.
            .Column5.Resizable = .F.
            .Column5.ReadOnly  = .T.
            .Column6.Movable   = .F.
            .Column6.Resizable = .F.
            .Column6.ReadOnly  = .T.
            .Column7.Movable   = .F.
            .Column7.Resizable = .F.
            .Column7.ReadOnly  = .T.
            .Column8.Movable   = .F.
            .Column8.Resizable = .F.
            .Column8.ReadOnly  = .T.

        ENDWITH

        *-- CheckBox da coluna de marcacao. Criado e configurado por CAMINHO
        *-- COMPLETO, FORA de qualquer WITH: dentro de um WITH, um
        *-- ".filho.AddObject(...)" seguido de "WITH .filho.neto" eh o padrao
        *-- de WITH aninhado que o VFP9 resolve mal - as propriedades do neto
        *-- sao ignoradas em SILENCIO, e o checkbox sairia com a geometria
        *-- default sem nenhum erro na tela.
        IF !PEMSTATUS(THIS.grd_4c_Itens.Column1, "chk_4c_Marca", 5)
            THIS.grd_4c_Itens.Column1.AddObject("chk_4c_Marca", "CheckBox")

            WITH THIS.grd_4c_Itens.Column1.chk_4c_Marca
                .Top       = 2
                .Left      = 2
                .Caption   = ""
                .FontName  = "Verdana"
                .FontSize  = 8
                .Alignment = 0
            ENDWITH

            loc_lCriouCheck = .T.
        ENDIF

        *-- AddObject sozinho NAO faz o controle aparecer: sem CurrentControl
        *-- a Column continua desenhando o Text1 dela, e sem Sparse = .F. o
        *-- CheckBox so apareceria na linha ativa (regra #18).
        THIS.grd_4c_Itens.Column1.CurrentControl = "chk_4c_Marca"
        THIS.grd_4c_Itens.Column1.Sparse         = .F.

        *-- Toggle da marcacao do componente (Column1.Check1 do legado): o
        *-- binding nativo do CheckBox na Column NAO alterna o valor (regra
        *-- do CheckBox em Grid - exige os 4 handlers). MouseDown e Click
        *-- apenas suprimem o toggle padrao (NoDefault); MouseUp e
        *-- KeyPress(13/32) fazem o toggle de fato, delegando ambos a
        *-- AlternarMarcaLinhaAtual() (mesmo corpo do Procedure/MouseUp e do
        *-- KeyPress legado: Replace Marcas With Not Marcas + refresh +
        *-- AtuaTotas). Ligados SOMENTE no passe em que o CheckBox nasceu -
        *-- ver comentario do metodo.
        IF loc_lCriouCheck
            BINDEVENT(THIS.grd_4c_Itens.Column1.chk_4c_Marca, "MouseDown", THIS, "ChkMarcaMouseDown")
            BINDEVENT(THIS.grd_4c_Itens.Column1.chk_4c_Marca, "MouseUp", THIS, "ChkMarcaMouseUp")
            BINDEVENT(THIS.grd_4c_Itens.Column1.chk_4c_Marca, "KeyPress", THIS, "ChkMarcaKeyPress")
            BINDEVENT(THIS.grd_4c_Itens.Column1.chk_4c_Marca, "Click", THIS, "ChkMarcaClick")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridRodape - grade de totais (grdRodape do legado), ligada a
    * cursor_4c_Rodape (1 linha, ja populada por CarregarDados()). Geometria
    * e colunas TRANSCRITAS do dump (SIGOPCPO.grdRodape + PROCEDURE
    * montagrades): 3 colunas, todas ReadOnly - mesmo ordem canonica
    * (ControlSource -> Header1.Caption -> Width por ultimo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridRodape()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorRodape

        THIS.AddObject("grd_4c_Rodape", "Grid")
        WITH THIS.grd_4c_Rodape
            .Top               = 566
            .Left              = 542
            .Width             = 447
            .Height            = 23
            .FontName          = "Arial"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 4
            .ScrollBars        = 2
            .BackColor         = RGB(224, 253, 254)
            .ToolTipText       = "Totais"
            .ColumnCount       = 3
            .ReadOnly          = .T.
            .RecordSource      = loc_cCursor

            .Column1.ControlSource = loc_cCursor + ".Descrs"
            .Column2.ControlSource = loc_cCursor + ".Usuars"
            .Column3.ControlSource = loc_cCursor + ".Totas"

            .Column1.Header1.Caption = ""
            .Column2.Header1.Caption = ""
            .Column3.Header1.Caption = ""

            .Column3.InputMask = "999999999.99"

            .Column1.Width = 152
            .Column2.Width = 152
            .Column3.Width = 120

            .Column1.FontName  = "Arial"
            .Column1.BackColor = RGB(245, 251, 136)
            .Column2.FontName  = "Arial"
            .Column2.FontBold  = .T.
            .Column2.BackColor = RGB(245, 251, 136)
            .Column3.FontName  = "Arial"
            .Column3.FontBold  = .T.
            .Column3.BackColor = RGB(245, 251, 136)

            .Column1.Header1.BackColor = RGB(188, 201, 254)
            .Column2.Header1.BackColor = RGB(162, 214, 242)
            .Column3.Header1.BackColor = RGB(162, 214, 242)

            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.ReadOnly  = .T.
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.ReadOnly  = .T.
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column3.ReadOnly  = .T.

            .Visible = .T.
        ENDWITH

        *-- Eventos de CELULA da grade de totais, transcritos do legado.
        *-- Text1 eh membro NATIVO de Column (nao precisa de AddObject) e
        *-- por isso pode ser alvo direto de BINDEVENT; os handlers sao
        *-- PUBLIC (regra #3) e GotFocus/LostFocus nao passam parametro.
        *--
        *-- SIGOPCPO.grdRodape.Column1.Text1.GotFocus:
        *--     ThisForm.grdItens.Column1.SetFocus
        *-- SIGOPCPO.grdRodape.Column2.Text1.GotFocus:  This.Tag = This.Value
        *-- SIGOPCPO.grdRodape.Column2.Text1.LostFocus: This.Value = This.Tag
        BINDEVENT(THIS.grd_4c_Rodape.Column1.Text1, "GotFocus", ;
                  THIS, "ValidarFocoRodape")
        BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "GotFocus", ;
                  THIS, "ValidarTagRodapeGotFocus")
        BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "LostFocus", ;
                  THIS, "ValidarTagRodapeLostFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltroTipo - Label + ComboBox de filtro por tipo de
    * composicao (Say1/cmbTipos do legado). Geometria TRANSCRITA do dump
    * (SIGOPCPO.Say1/cmbTipos): o label nao declara Width/Alignment no SCX
    * (classe say, regra #23), mas aqui o legado JA declara Width=32 - entao
    * NAO eh o caso da regra (nada a corrigir).
    *
    * cmbTipos eh fwcombo Style=2 (dropdown list) SEM ControlSource: o
    * legado o popula via Clear/AddItem a partir de LocalTpCom (SigCdTpc),
    * ja feito pela BO em CarregarTipos() -> cursor_4c_Tipos. Aqui o combo
    * liga via RowSourceType=2 (Alias) nesse MESMO cursor (ja existe quando
    * este metodo roda - chamado DEPOIS de CarregarDados() em
    * InicializarForm), o que reproduz a lista sem reimplementar o
    * Clear/AddItem. .Value recebe this_cTipoSelecionado (equivalente a
    * ThisForm.cmbTipos.Value = Iif(llBrc, Space(20), LocalTpCom.Tipos) do
    * SelecionaDados legado), DEPOIS do RowSource estar definido. O Valid
    * do legado (Set Filter To Tipos = cmbTipos.Value In crGrade + Refresh)
    * eh ligado no fim deste metodo e implementado em ValidarFiltroTipo(),
    * delegando a THIS.this_oBusinessObject.AplicarFiltroTipo().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltroTipo()
        LOCAL loc_cCursorTipos
        loc_cCursorTipos = THIS.this_oBusinessObject.this_cCursorTipos

        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 169
            .Left      = 296
            .Width     = 32
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tipo :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("cbo_4c_CmbTipos", "ComboBox")
        WITH THIS.cbo_4c_CmbTipos
            .Top          = 165
            .Left         = 335
            .Width        = 325
            .Height       = 23
            .FontName     = "Courier New"
            .Style        = 2
            .ToolTipText  = "Sele" + CHR(231) + CHR(227) + "o de Tipos"
            .ColumnCount  = 1
            .BoundColumn  = 1
            .RowSourceType = 2
            .RowSource    = loc_cCursorTipos
            .Visible      = .T.
        ENDWITH

        IF USED(loc_cCursorTipos) AND RECCOUNT(loc_cCursorTipos) > 0
            THIS.cbo_4c_CmbTipos.Value = THIS.this_oBusinessObject.this_cTipoSelecionado
        ENDIF

        *-- Guarda de valor-nao-mudou inicializada com o tipo que o
        *-- SelecionaDados legado ja deixou aplicado em cursor_4c_Grade
        *-- (CarregarComposicao -> CarregarTipos -> AplicarFiltroTipo da BO),
        *-- ANTES de ligar os eventos: assim a primeira interacao real do
        *-- usuario eh a primeira reaplicacao do filtro.
        THIS.this_cTipoFiltroAtual = THIS.this_oBusinessObject.this_cTipoSelecionado

        *-- Valid do cmbTipos legado. BINDEVENT exige metodo PUBLIC (regra
        *-- #3) - ValidarFiltroTipo nao leva PROTECTED. Dois eventos: o
        *-- InteractiveChange reage na hora em que o usuario escolhe o item
        *-- do dropdown (Style=2) e o LostFocus eh o equivalente literal do
        *-- Valid (que no legado roda ao SAIR do campo); a guarda
        *-- this_cTipoFiltroAtual impede o trabalho duplicado. Nenhum dos
        *-- dois eventos passa parametro, por isso o handler nao declara
        *-- nenhum.
        BINDEVENT(THIS.cbo_4c_CmbTipos, "InteractiveChange", THIS, "ValidarFiltroTipo")
        BINDEVENT(THIS.cbo_4c_CmbTipos, "LostFocus", THIS, "ValidarFiltroTipo")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup de saida (cntBotoes do legado), com os
    * 2 botoes OK/Cancelar. Geometria TRANSCRITA do dump
    * (SIGOPCPO.cntBotoes). CommandGroup NAO tem FontName/ForeColor (regra
    * #33) - essas propriedades vao nos Buttons(N), que tem as duas. Criado
    * DEPOIS de ConfigurarCabecalho() (chamado antes em InicializarForm),
    * para desenhar por cima da faixa cinza (Top = -2 sobrepoe o cabecalho,
    * igual ao legado). Buttons(1).Enabled reflete
    * this_oBusinessObject.this_lPermiteConfirmar - fonte UNICA do estado do
    * botao (equivalente a btnConfirmar.Enabled = (LocalTot.Qtds > 0) do
    * AtuaTotas legado, ja calculado em CarregarDados()). Os Click dos
    * botoes entram na Fase 7.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = -2
            .Left          = 842
            .Width         = 160
            .Height        = 85
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Height          = 75
                .Width           = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Caption         = "\<OK"
                .MousePointer    = 15
                .ToolTipText     = "Gravar os Dados Informados"
                .SpecialEffect   = 0
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .Enabled         = THIS.this_oBusinessObject.this_lPermiteConfirmar
            ENDWITH

            WITH .Buttons(2)
                .Top           = 5
                .Left          = 80
                .Height        = 75
                .Width         = 75
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .WordWrap      = .T.
                .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel        = .T.
                .Caption       = "Cancelar"
                .MousePointer  = 15
                .ToolTipText   = "[Esc] Sair Sem Gravar os Dados"
                .SpecialEffect = 0
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- Click de cada botao do CommandGroup (cntBotoes do legado - cada
        *-- Buttons(N) tem o proprio Click, nao um Click unico do grupo).
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarImagem - Image de zoom do componente (ImgFigJpg do legado).
    * Geometria TRANSCRITA do dump (SIGOPCPO.ImgFigJpg): nasce OCULTA
    * (Visible = .F.), igual ao legado - so fica visivel quando a linha
    * corrente da grade tem FigJpgs preenchido (AfterRowColChange legado:
    * ThisForm.ImgFigJpg.Visible = .f. seguido de .Visible = .t. condicional
    * ao StrToFile ter sucesso). Por isso ela eh EXCLUIDA de
    * TornarControlesVisiveis (regra de containers que nascem ocultos de
    * proposito), e o Picture so eh atribuido pelo AfterRowColChange real
    * (Fase 7), nunca aqui.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarImagem()
        THIS.AddObject("img_4c_ImgFigJpg", "Image")
        WITH THIS.img_4c_ImgFigJpg
            .Top         = 84
            .Left        = 12
            .Width       = 252
            .Height      = 106
            .Anchor      = 0
            .Stretch     = 1
            .Enabled     = .T.
            .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
            .Picture     = ""
            .Visible     = .F.
        ENDWITH

        *-- Click de SIGOPCPO.ImgFigJpg: zoom da imagem do componente
        *-- corrente (Do Form SigOpZom do legado).
        BINDEVENT(THIS.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltroTipo - Valid do cmbTipos legado. Wrapper FINO: so cuida da
    * guarda de reentrancia e delega o corpo a ValidarFiltroTipoExec(), para
    * a flag ser liberada mesmo quando o corpo sai por um RETURN antecipado
    * (regra #47 - set/clear no proprio corpo trava a flag ligada e mata o
    * handler pelo resto da vida do form).
    *
    * PUBLIC (sem PROTECTED): eh alvo de BINDEVENT, e metodo PROTECTED falha
    * em silencio no bind (regra #3). Nem InteractiveChange nem LostFocus
    * passam parametro, por isso a assinatura eh vazia.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltroTipo()
        IF THIS.this_lEmFiltroTipo
            RETURN
        ENDIF

        THIS.this_lEmFiltroTipo = .T.
        THIS.ValidarFiltroTipoExec()
        THIS.this_lEmFiltroTipo = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltroTipoExec - corpo da validacao do campo Tipo. Transcricao
    * do PROCEDURE Valid de SIGOPCPO.cmbTipos:
    *     Select crGrade
    *     Set Filter To Tipos = ThisForm.cmbTipos.Value In crGrade
    *     Go Top In crGrade
    *     ThisForm.grdItens.Refresh
    * O Set Filter/Go Top moram em
    * THIS.this_oBusinessObject.AplicarFiltroTipo() (fonte unica do filtro,
    * Fase 2) e a repintura em THIS.AtualizarRodape() (funil unico, regra
    * #21) - aqui fica apenas a leitura do campo e a guarda de
    * valor-nao-mudou.
    *
    * A comparacao da guarda usa ALLTRIM nos DOIS lados: o .Value vem de uma
    * coluna char(20) (padded) e this_cTipoFiltroAtual pode ter sido gravado
    * sem o padding, e com SET EXACT ON (config.prg) "X" == "X   " eh .F. -
    * sem o ALLTRIM a guarda nunca casaria e o filtro seria reaplicado duas
    * vezes por escolha. ALLTRIM aqui eh seguro porque a guarda so decide
    * REAPLICAR ou nao; quem compara contra o cursor eh a BO, com o valor
    * cru.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltroTipoExec()
        LOCAL loc_cTipo, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
                        "Erro ao Filtrar por Tipo")
            ELSE
                loc_cTipo = THIS.cbo_4c_CmbTipos.Value
                IF VARTYPE(loc_cTipo) != "C"
                    loc_cTipo = THIS.this_oBusinessObject.this_cTipoEmBranco
                ENDIF

                IF ALLTRIM(loc_cTipo) == ALLTRIM(THIS.this_cTipoFiltroAtual)
                    *-- Tipo nao mudou: o filtro ja esta aplicado em
                    *-- cursor_4c_Grade e a grade ja reflete este tipo.
                    *-- Reaplicar so repintaria a grade de novo e perderia a
                    *-- linha corrente.
                ELSE
                    IF THIS.this_oBusinessObject.AplicarFiltroTipo(loc_cTipo)
                        THIS.this_cTipoFiltroAtual = THIS.this_oBusinessObject.this_cTipoSelecionado
                        *-- 0 = GO TOP: o Valid legado termina com
                        *-- "Go Top In crGrade" - trocou o filtro, a grade
                        *-- volta para a primeira linha do novo conjunto.
                        THIS.AtualizarRodape(0)
                    ELSE
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel aplicar o " + ;
                                "filtro de tipo de composi" + CHR(231) + CHR(227) + "o.", ;
                                "Erro ao Filtrar por Tipo")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Filtrar por Tipo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarRodape - FUNIL UNICO de repintura: recalcula os totais pela
    * BO (fonte unica - AtuaTotas legado), espelha o total geral na linha de
    * cursor_4c_Rodape, repinta as DUAS grades e reflete o estado do botao
    * Confirmar. Equivalente ao PROCEDURE atuatotas legado:
    *     ThisForm.grdRodape.Column3.Text1.Value = LocalTot.Totas
    *     ThisForm.grdRodape.Column3.Refresh
    *     ThisForm.cntBotoes.btnConfirmar.Enabled = (LocalTot.Qtds > 0)
    * (no migrado o total vai para a COLUNA do cursor via REPLACE, igual ao
    * que CarregarDados() ja faz, em vez de escrever no .Value da celula -
    * assim o valor sobrevive a qualquer repintura do Grid).
    *
    * Popular/filtrar cursor NAO repinta a grade (regra #21): o Refresh tem
    * de rodar em TODO caminho que mexe no cursor, por isso ele mora aqui, e
    * nao dentro de cada handler.
    *
    * par_nRegistroGrade diz onde DEIXAR o ponteiro de cursor_4c_Grade, e eh
    * o chamador que decide - este metodo nao adivinha:
    *   - 0 / ausente -> GO TOP, que eh o que o legado faz no caminho do
    *     FILTRO (Go Top In crGrade no proprio Valid do cmbTipos);
    *   - RECNO() capturado ANTES pelo chamador -> volta para aquela linha,
    *     que eh o que o caminho do CHECKBOX precisa (Fase 7): a linha
    *     corrente eh o que o AfterRowColChange usa para escolher a imagem,
    *     e um GO TOP faria a grade saltar a cada marcacao.
    * Repor o ponteiro eh OBRIGATORIO nos dois casos: o SELECT ... SUM() de
    * AtualizarTotais() percorre o cursor e pode deixa-lo em EOF.
    *
    * O metodo eh o FUNIL de sincronismo desta tela, nos tres passos:
    *   1. THIS.FormParaBO()  - o que esta nos controles e na linha corrente
    *                           da grade vai para as properties do BO;
    *   2. BO.AtualizarTotais() - o BO recalcula o que eh dele (totais e
    *                           this_lPermiteConfirmar);
    *   3. THIS.BOParaForm()  - o estado do BO volta para os controles
    *                           (total do rodape, botao Confirmar, imagem do
    *                           componente, combo de tipo).
    * Nenhum handler escreve direto nesses controles: fonte unica.
    *
    * Reentrancia: os passos 1 e 3 mexem no ponteiro do cursor e repintam a
    * grade, o que redispara o AfterRowColChange dela - que chama este
    * mesmo metodo. this_lEmAtualizacao garante UM passe por acao do
    * usuario (ver comentario da property).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarRodape(par_nRegistroGrade)
        LOCAL loc_cCursorGrade, loc_nRegGrade, loc_oErro

        IF THIS.this_lEmAtualizacao
            RETURN
        ENDIF

        loc_nRegGrade = IIF(VARTYPE(par_nRegistroGrade) = "N", par_nRegistroGrade, 0)

        THIS.this_lEmAtualizacao = .T.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
                        "Erro ao Atualizar Totais")
            ELSE
                loc_cCursorGrade = THIS.this_oBusinessObject.this_cCursorGrade

                *-- Ponteiro ANTES de FormParaBO(): eh a linha corrente que
                *-- CarregarDoCursor() le para alimentar o BO.
                IF USED(loc_cCursorGrade)
                    SELECT (loc_cCursorGrade)
                    IF loc_nRegGrade > 0 AND loc_nRegGrade <= RECCOUNT()
                        GO loc_nRegGrade
                    ELSE
                        GO TOP
                    ENDIF
                ENDIF

                THIS.FormParaBO()
                THIS.this_oBusinessObject.AtualizarTotais()

                IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                    THIS.grd_4c_Itens.Refresh()
                ENDIF

                THIS.BOParaForm()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Atualizar Totais")
        ENDTRY

        *-- Liberada FORA do TRY/CATCH para nunca travar ligada quando o
        *-- corpo estourar (mesmo motivo da guarda do lookup, regra #47).
        THIS.this_lEmAtualizacao = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFocoRodape - GotFocus de SIGOPCPO.grdRodape.Column1.Text1
    * legado, que eh uma unica linha: ThisForm.grdItens.Column1.SetFocus.
    * A grade de totais eh somente-leitura (Grid.ReadOnly = .T. + as 3
    * Column.ReadOnly = .T.), entao o legado DEVOLVE o foco a grade de
    * itens assim que ela o recebe por Tab.
    *
    * PUBLIC (alvo de BINDEVENT, regra #3) e sem parametro (GotFocus nao
    * passa nenhum). Sem TRY/CATCH de proposito: um dialogo modal de erro
    * disparado por uma troca de foco seria pior que o proprio problema -
    * as pre-condicoes do SetFocus (grade existente, visivel, habilitada e
    * com registro) sao conferidas por guarda explicita. A devolucao de
    * foco nao reentra: o SetFocus leva o foco PARA FORA da grade de
    * totais, logo o GotFocus dela nao dispara de novo.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFocoRodape()
        LOCAL loc_cCursorGrade

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        IF !PEMSTATUS(THIS, "grd_4c_Itens", 5)
            RETURN
        ENDIF

        loc_cCursorGrade = THIS.this_oBusinessObject.this_cCursorGrade
        IF !USED(loc_cCursorGrade) OR RECCOUNT(loc_cCursorGrade) = 0
            RETURN
        ENDIF

        IF THIS.grd_4c_Itens.Visible AND THIS.grd_4c_Itens.Enabled
            THIS.grd_4c_Itens.Column1.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTagRodapeGotFocus - GotFocus de SIGOPCPO.grdRodape.Column2.Text1
    * legado (This.Tag = This.Value): guarda o valor original da celula ao
    * entrar nela. Tag de TextBox aceita SOMENTE caractere, e Column2 esta
    * ligada a cursor_4c_Rodape.Usuars (char(10)), entao o valor ja chega
    * como caractere - o VARTYPE abaixo cobre o caso de a celula ainda nao
    * ter valor ligado.
    *
    * PUBLIC (alvo de BINDEVENT) e sem parametro (GotFocus nao passa
    * nenhum).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTagRodapeGotFocus()
        LOCAL loc_oCelula

        IF !PEMSTATUS(THIS, "grd_4c_Rodape", 5)
            RETURN
        ENDIF

        loc_oCelula = THIS.grd_4c_Rodape.Column2.Text1
        IF VARTYPE(loc_oCelula.Value) = "C"
            loc_oCelula.Tag = loc_oCelula.Value
        ELSE
            loc_oCelula.Tag = TRANSFORM(loc_oCelula.Value)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTagRodapeLostFocus - LostFocus de
    * SIGOPCPO.grdRodape.Column2.Text1 legado (This.Value = This.Tag):
    * restaura o valor guardado no GotFocus ao sair da celula, desfazendo
    * qualquer alteracao. Eh a trava de edicao do legado para essa celula,
    * complementar ao Column2.ReadOnly = .T. - sem ela a trava ficaria
    * apenas na propriedade, e a propriedade eh resetada por qualquer
    * re-bind de RecordSource (Problema 48).
    *
    * So restaura quando o valor REALMENTE mudou e quando o tipo do Tag
    * (sempre caractere) bate com o tipo da celula: atribuir caractere a
    * celula numerica dispararia "Data type mismatch", e a celula so eh
    * numerica se o RecordSource tiver sido re-vinculado a outra coluna.
    *
    * PUBLIC (alvo de BINDEVENT) e sem parametro (LostFocus nao passa
    * nenhum).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTagRodapeLostFocus()
        LOCAL loc_oCelula

        IF !PEMSTATUS(THIS, "grd_4c_Rodape", 5)
            RETURN
        ENDIF

        loc_oCelula = THIS.grd_4c_Rodape.Column2.Text1
        IF VARTYPE(loc_oCelula.Value) != "C" OR VARTYPE(loc_oCelula.Tag) != "C"
            RETURN
        ENDIF

        IF !(loc_oCelula.Value == loc_oCelula.Tag)
            loc_oCelula.Value = loc_oCelula.Tag
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarMarcaLinhaAtual - corpo comum do MouseUp e do KeyPress(13/32) de
    * SIGOPCPO.grdItens.Column1.Check1:
    *     Replace Marcas With Not Marcas In crGrade
    *     ThisForm.grdItens.Column1.Refresh
    *     ThisForm.grdItens.Refresh
    *     ThisForm.AtuaTotas
    * O refresh da grade de itens e a repintura do rodape (AtuaTotas) moram
    * no funil AtualizarRodape() (regra #21). RECNO() eh capturado ANTES de
    * chamar AtualizarRodape() e repassado a ela, para a grade permanecer na
    * MESMA linha que o usuario acabou de marcar (AtualizarRodape so faz
    * GO TOP quando recebe 0 - ver comentario do metodo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarMarcaLinhaAtual()
        LOCAL loc_cCursor, loc_nRecno, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
                        "Erro ao Marcar Componente")
            ELSE
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

                IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                    SELECT (loc_cCursor)
                    REPLACE Marcas WITH !Marcas
                    loc_nRecno = RECNO()

                    IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                        THIS.grd_4c_Itens.Column1.Refresh()
                    ENDIF

                    THIS.AtualizarRodape(loc_nRecno)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Marcar Componente")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcaMouseDown - Procedure (MouseDown) de Check1 legado: so suprime
    * o toggle padrao do CheckBox (NoDefault). PUBLIC (alvo de BINDEVENT,
    * regra #3); assinatura completa de MouseDown, mesmo sem uso.
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcaMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcaMouseUp - Procedure (MouseUp) de Check1 legado: alterna a
    * marcacao da linha corrente, sem checar qual botao do mouse (o legado
    * tambem nao checa). PUBLIC (alvo de BINDEVENT, regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.AlternarMarcaLinhaAtual()
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcaKeyPress - KeyPress de Check1 legado: alterna a marcacao so em
    * Enter(13)/Espaco(32), exatamente como o "If InList(nKeyCode, 13, 32)"
    * do legado - fora dessas teclas, nao chama NoDefault e o KeyPress segue
    * o processamento padrao. PUBLIC (alvo de BINDEVENT, regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarMarcaLinhaAtual()
            NODEFAULT
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcaClick - Click de Check1 legado (so "NoDefault" - suprime o
    * toggle padrao, que fica a cargo do MouseUp/KeyPress). PUBLIC (alvo de
    * BINDEVENT, regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcaClick()
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensAfterRowColChange - AfterRowColChange de SIGOPCPO.grdItens:
    *     Clear Resources
    *     ThisForm.ImgFigJpg.Picture = []
    *     ThisForm.ImgFigJpg.Visible = .f.
    *     If Not Empty(crGrade.FigJpgs) And Not IsNull(crGrade.FigJpgs) ;
    *         And (StrToFile(Strconv(Strtran(...),14), lcArq) > 0)
    *         ThisForm.ImgFigJpg.Picture = (lcArq)
    *         ThisForm.ImgFigJpg.Visible = .t.
    *     EndIf
    *     ThisForm.AtuaTotas
    * O corpo inteiro eh o funil THIS.AtualizarRodape(), que faz
    * FormParaBO() -> AtualizarTotais() -> BOParaForm(): eh o BOParaForm()
    * que troca a imagem (Picture/Visible), a partir do this_cFigjpgs que o
    * FormParaBO() acabou de ler da linha corrente, e a decodificacao do
    * base64 mora em THIS.this_oBusinessObject.DecodificarImagem() (fonte
    * unica, Fase 2). O unico trabalho deste handler eh dizer ao funil QUAL
    * linha eh a corrente - o funil nao adivinha (ver AtualizarRodape).
    *
    * PUBLIC (alvo de BINDEVENT, regra #3); par_nColIndex nao eh usado -
    * este handler carrega o detalhe da linha corrente, independente da
    * coluna de destino, que eh o uso CORRETO deste evento (regra #46).
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
        LOCAL loc_cCursor, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

                IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                    THIS.AtualizarRodape(RECNO(loc_cCursor))
                ELSE
                    THIS.AtualizarRodape(0)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Carregar Imagem do Componente")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Click de Buttons(1) do cntBotoes legado (OK):
    *     Select crGrade
    *     Set Filter To
    *     Go Top In crGrade
    *     Select crGrade
    *     Scan
    *         If Not Marcas
    *             Delete In crGrade
    *         EndIf
    *     EndScan
    *     ThisForm.Release
    * O descarte das linhas nao marcadas mora em
    * THIS.this_oBusinessObject.ConfirmarSelecao() (fonte unica, Fase 2). O
    * Release so acontece com sucesso - sem RETURN dentro do TRY (regra #1),
    * flag loc_lSucesso decide a saida DEPOIS do ENDTRY. PUBLIC (alvo de
    * BINDEVENT, regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
                        "Erro ao Confirmar Sele" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.this_oBusinessObject.ConfirmarSelecao()
                    loc_lSucesso = .T.
                ELSE
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                            "Erro ao Confirmar Sele" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Confirmar Sele" + CHR(231) + CHR(227) + "o")
        ENDTRY

        IF loc_lSucesso
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Click de Buttons(2) do cntBotoes legado (Cancelar):
    *     Select crGrade
    *     Set Filter To
    *     Go Top In crGrade
    *     Select crGrade
    *     Scan
    *         Delete In crGrade
    *     EndScan
    *     ThisForm.Release
    * O descarte INCONDICIONAL de todas as linhas mora em
    * THIS.this_oBusinessObject.CancelarSelecao() (fonte unica, Fase 2). O
    * Release acontece sempre - cancelar nunca falha de um jeito que impeca
    * sair do dialogo. PUBLIC (alvo de BINDEVENT, regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.CancelarSelecao()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Cancelar Sele" + CHR(231) + CHR(227) + "o")
        ENDTRY

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ImgFigJpgClick - Click de SIGOPCPO.ImgFigJpg legado:
    *     Select crGrade
    *     If Not Empty(crGrade.FigJpgs) And Not IsNull(crGrade.FigJpgs)
    *         lcFoto = Strconv(Strtran(...), 14)
    *         =StrToFile(lcFoto, lcArq)
    *     EndIf
    *     If File(lcArq)
    *         Do Form SigOpZom With lcArq, [Produto : ]+Mats+[ - ]+DPros, ;
    *                  [Ref. Fornecedor : ]+Reffs
    *     EndIf
    * A decodificacao mora em THIS.this_oBusinessObject.DecodificarImagem()
    * (fonte unica, Fase 2); a abertura do zoom em
    * THIS.AbrirFormZoomImagem() - SigOpZom esta FORA do escopo desta task
    * (ProximasMigracoes\SigOpZom.SCX ainda nao migrado), mesmo padrao do
    * FormSigMvSbn.ImgFigJpgDblClick: CREATEOBJECT guardado, ausencia
    * AVISADA via MsgAviso em vez de estourar "Class definition ... is not
    * found". Quando SigOpZom for migrado, esta chamada passa a funcionar
    * sem nenhuma alteracao aqui. PUBLIC (alvo de BINDEVENT, regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ImgFigJpgClick()
        LOCAL loc_cCursor, loc_cFigJpgs, loc_cArquivo, loc_cProduto, ;
              loc_cDescricao, loc_cReferencia, loc_oErro
        loc_cArquivo = ""

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

                IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                    loc_cFigJpgs    = TratarNulo(EVALUATE(loc_cCursor + ".FigJpgs"), "")
                    loc_cProduto    = TratarNulo(EVALUATE(loc_cCursor + ".Mats"), "")
                    loc_cDescricao  = TratarNulo(EVALUATE(loc_cCursor + ".Dpros"), "")
                    loc_cReferencia = TratarNulo(EVALUATE(loc_cCursor + ".Reffs"), "")

                    IF !EMPTY(loc_cFigJpgs) AND THIS.this_oBusinessObject.DecodificarImagem(loc_cFigJpgs)
                        loc_cArquivo = THIS.this_oBusinessObject.this_cArquivoImagem
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Abrir Zoom da Imagem")
            loc_cArquivo = ""
        ENDTRY

        *-- Legado: If File(lcArq) / Do Form SigOpZom With ... Show() de form
        *-- fica FORA de qualquer TRY (regra #29).
        IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
            THIS.AbrirFormZoomImagem(loc_cArquivo, loc_cProduto, loc_cDescricao, loc_cReferencia)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirFormZoomImagem - "Do Form SigOpZom With lcArq, 'Produto : '+...,
    * 'Ref. Fornecedor : '+..." do legado. SigOpZom ainda nao foi migrado
    * (ProximasMigracoes\SigOpZom.SCX) - mesma situacao documentada em
    * FormSigMvSbn.AbrirFormZoomImagem: CREATEOBJECT guardado em TRY/CATCH,
    * ausencia avisada via MsgAviso em vez de estourar "Class definition
    * FORMSIGOPZOM is not found". Show() fica FORA do TRY (regra #29).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirFormZoomImagem(par_cArquivo, par_cProduto, par_cDescricao, par_cReferencia)
        LOCAL loc_oForm, loc_oErro, loc_cLinha2, loc_cLinha3

        loc_cLinha2 = "Produto : " + ALLTRIM(par_cProduto) + " - " + ALLTRIM(par_cDescricao)
        loc_cLinha3 = "Ref. Fornecedor : " + ALLTRIM(par_cReferencia)

        TRY
            loc_oForm = CREATEOBJECT("FormSigOpZom", par_cArquivo, loc_cLinha2, loc_cLinha3)
        CATCH TO loc_oErro
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            MsgAviso("M" + CHR(243) + "dulo de Zoom de Imagem (SigOpZom) ainda n" + CHR(227) + ;
                "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", ;
                "Aviso")
        ENDIF
    ENDPROC

    *==========================================================================
    * Fase 8/8 - CONSOLIDACAO: o trio de sincronismo da tela
    *
    * CarregarLista() / FormParaBO() / BOParaForm() sao os tres metodos que
    * fecham a migracao. Nao ha HabilitarCampos/LimparCampos/
    * AjustarBotoesPorModo/BtnBuscarClick/BtnEncerrarClick aqui, e a ausencia
    * eh deliberada: sao convencao de form CRUD (Page1=Lista/Page2=Dados com
    * os modos INCLUIR/ALTERAR/VISUALIZAR). O SCX legado deste dialogo
    * (tasks/task710/SigOpCpo_form_codigo_fonte.txt) NAO tem modo de edicao,
    * NAO tem campo que se limpe (os unicos dados editaveis sao a marcacao
    * da Column1 e o combo de tipo, ambos sempre habilitados), e tem
    * exatamente DOIS botoes - OK (btnConfirmar) e Cancelar (btnSair), ja
    * entregues na Fase 7. Criar os cinco metodos aqui obrigaria a INVENTAR
    * modos e botoes que o legado nao tem (viola o PILAR 1 e a regra "NUNCA
    * inventar") ou a entregar metodos vazios (proibido pela regra de
    * completude).
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarLista - liga a grade de componentes ao cursor JA populado e
    * repinta a tela. Eh o trecho FINAL do PROCEDURE selecionadados legado,
    * que o migrado nao executava:
    *     Go Top In crGrade
    *     ThisForm.grdItens.Refresh
    *     ThisForm.grdItens.Column1.SetFocus
    *     Go Top In crRodape
    *     ThisForm.grdRodape.Refresh
    * Popular cursor NAO repinta a grade (regra #21): sem este metodo, o
    * cursor abre cheio e a grade aparece VAZIA - o sintoma ("a tela nao traz
    * dados") manda o diagnostico para SQL/cursor/permissao.
    *
    * NAO re-consulta o banco: a carga eh de CarregarDados() (-> BO.
    * CarregarComposicao()), que roda ANTES das grades existirem porque
    * Column.ControlSource exige o cursor ja criado (regra #41). Este metodo
    * eh o passo seguinte - re-vincular e repintar - e por isso pode ser
    * chamado quantas vezes for preciso sem custo de SQL.
    *
    * O re-vinculo (VincularGradeItens) eh condicional: so refaz quando a
    * grade NAO esta mais apontando para o cursor certo (RecordSource vazio
    * ou trocado), porque re-atribuir RecordSource reseta Width/Caption das
    * colunas e destroi o CurrentControl do CheckBox (Problema 48/regra #18).
    *
    * PUBLIC: TesteAutomatico.prg chama THIS.oForm.CarregarLista() de FORA da
    * classe, e PEMSTATUS nao distingue escopo - metodo PROTECTED entraria no
    * branch do teste e estouraria "Property CARREGARLISTA is not found"
    * (regra #3).
    *--------------------------------------------------------------------------
    FUNCTION CarregarLista()
        LOCAL loc_lSucesso, loc_cCursorGrade, loc_cCursorRodape, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
                        "Erro ao Carregar a Grade")
            ELSE
                loc_cCursorGrade  = THIS.this_oBusinessObject.this_cCursorGrade
                loc_cCursorRodape = THIS.this_oBusinessObject.this_cCursorRodape

                IF !USED(loc_cCursorGrade)
                    MsgErro("Cursor da composi" + CHR(231) + CHR(227) + "o (" + ;
                            loc_cCursorGrade + ") indispon" + CHR(237) + "vel.", ;
                            "Erro ao Carregar a Grade")
                ELSE
                    IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                        IF !(UPPER(ALLTRIM(THIS.grd_4c_Itens.RecordSource)) == ;
                             UPPER(ALLTRIM(loc_cCursorGrade)))
                            THIS.VincularGradeItens()
                        ENDIF
                    ENDIF

                    *-- "Go Top In crRodape" do legado: a linha unica de
                    *-- totais sempre repousa no topo.
                    IF USED(loc_cCursorRodape)
                        SELECT (loc_cCursorRodape)
                        GO TOP
                    ENDIF

                    *-- Totais + rodape + botao Confirmar + imagem pelo funil
                    *-- (fonte unica). 0 = GO TOP em cursor_4c_Grade, que eh
                    *-- o que o legado faz neste ponto.
                    THIS.AtualizarRodape(0)

                    *-- "ThisForm.grdItens.Column1.SetFocus" do legado: o
                    *-- dialogo abre com o foco na coluna de marcacao, para o
                    *-- usuario poder marcar com Espaco/Enter sem usar o mouse
                    *-- (os handlers de teclado do CheckBox dependem disso).
                    IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                        IF THIS.grd_4c_Itens.Visible AND THIS.grd_4c_Itens.Enabled ;
                           AND RECCOUNT(loc_cCursorGrade) > 0
                            THIS.grd_4c_Itens.Column1.SetFocus()
                        ENDIF
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Carregar a Grade")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormParaBO - transfere para o BO TUDO o que o usuario pode alterar
    * nesta tela. A superficie editavel do dialogo legado sao apenas tres
    * coisas, e as tres estao cobertas:
    *   1. cbo_4c_CmbTipos.Value  -> this_cTipoSelecionado  (o cmbTipos do
    *      legado, cujo Valid aplica "Set Filter To Tipos = ..." em crGrade);
    *   2. a LINHA CORRENTE de cursor_4c_Grade -> as properties de linha do
    *      BO, via THIS.this_oBusinessObject.CarregarDoCursor() - inclui
    *      this_lMarcas (o CheckBox da Column1, unica coluna editavel) e
    *      this_cFigjpgs, que eh o que BOParaForm() usa para a imagem;
    *   3. a linha de cursor_4c_Rodape -> this_cDescrsRodape/
    *      this_cUsuarsRodape/this_nTotasRodape (as 3 celulas do grdRodape).
    * NAO ha mais nada: os outros 7 controles da grade sao Column.ReadOnly =
    * .T. e os dois labels do cabecalho sao somente-exibicao.
    *
    * CarregarDoCursor() eh PUBLIC na BusinessBase - chama-lo daqui eh
    * legitimo; o que nunca se chama de fora eh metodo PROTECTED (regra #51).
    *
    * O alias originalmente selecionado eh restaurado no fim: o metodo roda
    * dentro do funil AtualizarRodape(), que repos o ponteiro da grade ANTES
    * de chamar este metodo e conta com ele intacto depois.
    *
    * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE FormParaBO",
    * e em VFP9 a subclasse NAO pode ALARGAR o escopo herdado - escrever
    * "FUNCTION FormParaBO" sem o modificador nao torna o metodo publico, so
    * esconde de quem le que ele continua protegido. Medido nesta tela
    * (2026-10-30): chamado de um script solto devolve .F. sem executar o
    * corpo; chamado por THIS. de dentro da classe roda normalmente. Para
    * exercitar num harness, usar "DEFINE CLASS Probe AS FormSigOpCpo" com um
    * metodo publico que chame THIS.FormParaBO().
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_cCursorGrade, loc_cCursorRodape, ;
              loc_cAliasAnterior, loc_cTipo, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
                        "Erro ao Transferir Dados da Tela")
            ELSE
                loc_cAliasAnterior = ALIAS()
                loc_cCursorGrade   = THIS.this_oBusinessObject.this_cCursorGrade
                loc_cCursorRodape  = THIS.this_oBusinessObject.this_cCursorRodape

                *-- 1. Tipo escolhido no combo. Style = 2 (dropdown list)
                *-- devolve CARACTERE; o PADR para 20 reproduz a largura de
                *-- SigCdTpc.Tipos char(20), que eh com o que o SET FILTER
                *-- compara (chave posicional - regra #42).
                IF PEMSTATUS(THIS, "cbo_4c_CmbTipos", 5)
                    loc_cTipo = THIS.cbo_4c_CmbTipos.Value
                    IF VARTYPE(loc_cTipo) != "C"
                        loc_cTipo = TRANSFORM(loc_cTipo)
                    ENDIF
                    THIS.this_oBusinessObject.this_cTipoSelecionado = PADR(loc_cTipo, 20)
                ENDIF

                *-- 2. Linha corrente da grade de componentes.
                IF USED(loc_cCursorGrade) AND !EOF(loc_cCursorGrade)
                    THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursorGrade)
                ENDIF

                *-- 3. Celulas da grade de totais.
                IF USED(loc_cCursorRodape)
                    SELECT (loc_cCursorRodape)
                    IF !EOF()
                        THIS.this_oBusinessObject.this_cDescrsRodape = TratarNulo(Descrs, "")
                        THIS.this_oBusinessObject.this_cUsuarsRodape = TratarNulo(Usuars, "")
                        THIS.this_oBusinessObject.this_nTotasRodape  = TratarNulo(Totas, 0)
                    ENDIF
                ENDIF

                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Transferir Dados da Tela")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BOParaForm - caminho inverso: o estado do BO vai para os controles.
    * Reune, num lugar so, tudo o que o legado escreve na tela:
    *   - this_nTotalTotas       -> cursor_4c_Rodape.Totas + grdRodape
    *     ("ThisForm.grdRodape.Column3.Text1.Value = LocalTot.Totas /
    *     Column3.Refresh" do AtuaTotas legado - no migrado o valor vai para
    *     a COLUNA do cursor via REPLACE, e nao para o .Value da celula,
    *     assim sobrevive a qualquer repintura do Grid);
    *   - this_lPermiteConfirmar -> Buttons(1).Enabled
    *     ("ThisForm.cntBotoes.btnConfirmar.Enabled = (LocalTot.Qtds > 0)");
    *   - this_cFigjpgs          -> img_4c_ImgFigJpg.Picture/.Visible
    *     (o AfterRowColChange legado: limpa a imagem e so a mostra quando o
    *     base64 do componente corrente decodifica);
    *   - this_cCpros/this_cDprosProduto -> Caption e os dois labels da faixa
    *     (o "... - <Cpros> - <Dpros>" montado no Init legado);
    *   - this_cTipoSelecionado  -> cbo_4c_CmbTipos.Value
    *     ("ThisForm.cmbTipos.Value = Iif(llBrc, Space(20), LocalTpCom.Tipos)
    *     / cmbTipos.Refresh" do selecionadados legado).
    *
    * O combo so eh escrito quando o valor REALMENTE difere: atribuir .Value
    * dispara o InteractiveChange, que esta ligado a ValidarFiltroTipo() -
    * reescrever o mesmo valor reaplicaria o filtro e repintaria a grade de
    * novo (as guardas this_cTipoFiltroAtual/this_lEmFiltroTipo tambem
    * cortam isso, mas nao se deve depender de guarda para nao gerar
    * trabalho que nao existe).
    *
    * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO(): FormBase declara
    * "PROTECTED PROCEDURE BOParaForm" e o escopo vem da HERANCA - omitir o
    * modificador nao alarga nada. CarregarLista(), ao contrario, NAO existe
    * em FormBase e por isso fica publico de verdade.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BOParaForm()
        LOCAL loc_lSucesso, loc_cCursorRodape, loc_cAliasAnterior, ;
              loc_cTipoBO, loc_cCaption, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
                        "Erro ao Exibir Dados na Tela")
            ELSE
                loc_cAliasAnterior = ALIAS()
                loc_cCursorRodape  = THIS.this_oBusinessObject.this_cCursorRodape

                *-- Total geral na linha unica do rodape. "IN (<alias>)"
                *-- EXPLICITO: este metodo roda logo depois de
                *-- AtualizarTotais(), que fecha o cursor temporario da soma e
                *-- com isso pode deixar a work area corrente VAZIA - REPLACE
                *-- sem alias ali estoura "No table is open in the current
                *-- work area.".
                IF USED(loc_cCursorRodape)
                    SELECT (loc_cCursorRodape)
                    GO TOP
                    IF !EOF()
                        REPLACE Totas WITH THIS.this_oBusinessObject.this_nTotalTotas ;
                            IN (loc_cCursorRodape)
                    ENDIF
                ENDIF

                IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
                    THIS.grd_4c_Rodape.Column3.Refresh()
                    THIS.grd_4c_Rodape.Refresh()
                ENDIF

                *-- Botao OK: habilitado so com quantidade marcada > 0.
                IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
                    THIS.cmg_4c_Botoes.Buttons(1).Enabled = ;
                        THIS.this_oBusinessObject.this_lPermiteConfirmar
                ENDIF

                *-- Imagem do componente corrente: limpa primeiro (igual ao
                *-- legado) e so reaparece se o base64 decodificar.
                IF PEMSTATUS(THIS, "img_4c_ImgFigJpg", 5)
                    THIS.img_4c_ImgFigJpg.Picture = ""
                    THIS.img_4c_ImgFigJpg.Visible = .F.

                    IF !EMPTY(THIS.this_oBusinessObject.this_cFigjpgs)
                        IF THIS.this_oBusinessObject.DecodificarImagem( ;
                               THIS.this_oBusinessObject.this_cFigjpgs)
                            THIS.img_4c_ImgFigJpg.Picture = ;
                                THIS.this_oBusinessObject.this_cArquivoImagem
                            THIS.img_4c_ImgFigJpg.Visible = .T.
                        ENDIF
                    ENDIF
                ENDIF

                *-- Titulo da faixa: produto-pai cuja composicao esta na tela.
                IF !EMPTY(THIS.this_oBusinessObject.this_cCpros)
                    loc_cCaption = "Composi" + CHR(231) + CHR(227) + "o de Produtos - " + ;
                        ALLTRIM(THIS.this_oBusinessObject.this_cCpros) + " - " + ;
                        ALLTRIM(THIS.this_oBusinessObject.this_cDprosProduto)

                    THIS.Caption = loc_cCaption

                    IF PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
                        THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = loc_cCaption
                        THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = loc_cCaption
                    ENDIF
                ENDIF

                *-- Tipo filtrado: so escreve quando difere (ver comentario).
                IF PEMSTATUS(THIS, "cbo_4c_CmbTipos", 5)
                    loc_cTipoBO = THIS.this_oBusinessObject.this_cTipoSelecionado
                    IF VARTYPE(THIS.cbo_4c_CmbTipos.Value) = "C" ;
                       AND !(PADR(THIS.cbo_4c_CmbTipos.Value, 20) == PADR(loc_cTipoBO, 20))
                        THIS.cbo_4c_CmbTipos.Value = loc_cTipoBO
                        THIS.cbo_4c_CmbTipos.Refresh()
                    ENDIF
                ENDIF

                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Exibir Dados na Tela")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis
    * recursivamente. FILTRO: img_4c_ImgFigJpg eh o UNICO controle flutuante
    * deste form - nasce Visible = .F. de proposito (igual ao ImgFigJpg
    * legado) e so aparece quando a grade tem imagem para exibir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF UPPER(loc_oControl.Name) == "IMG_4C_IMGFIGJPG"
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - equivalente ao PROCEDURE Release legado
    * (ThisForm.ParentForm.Enabled = .t. / =DoDefault()): reabilita o form
    * pai e fecha o cursor do produto antes de delegar a FormBase.Destroy()
    * (libera o BO, restaura o menu).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        IF USED("cursor_4c_Produto")
            USE IN cursor_4c_Produto
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCpoBO.prg):
*==============================================================================
* SigOpCpoBO.prg - Business Object para Composicao de Produtos (SIGOPCPO)
*
* Form OPERACIONAL de SELECAO: eh um dialogo modal (WindowType = 1,
* TitleBar = 0, ControlBox = .F., Movable = .F.) aberto por um form PAI
* (o Init legado recebe LParameters pFrm, pKey e faz .ParentForm = pFrm /
* .ParentForm.Enabled = .f.). Ele lista a composicao (componentes) do produto
* informado em pKey, deixa o usuario MARCAR quais componentes deseja e, no
* botao OK, mantem na grade apenas as linhas marcadas; no Cancelar, descarta
* todas. Quem persiste eh o form PAI - esta tela NAO grava em tabela alguma.
*
* Tabela principal: SigPrCpo (chave primaria: cidchaves char(20) -
* constraint sigprcpo_cidchaves, ver docs/schema.sql)
* Tabelas auxiliares: SigCdPro (descricao / preco / moeda / referencia /
* imagem do componente e do produto-pai) e SigCdTpc (tipos de composicao com
* Custos = 2, que alimentam o cmbTipos).
*
* Legado (SigOpCpo.SCX):
*   Load           -> fConfigGeral() + Create Cursor crRodape
*                     (Descrs c(100), Usuars c(10), Totas n(12,2))
*   Init           -> guarda pFrm/pKey, lpKey = Padr(pKey, 14),
*                     CursorQuery([SigCdPro],[LocalPro],[Cpros],lpKey,[DPros])
*                     para validar o produto e montar o Caption
*                     (Caption + " - " + lpKey + " - " + LocalPro.DPros),
*                     depois MontaGrades + SelecionaDados
*   SelecionaDados -> Zap crGrade/crRodape; SELECT da composicao (SigPrCpo a
*                     + SigCdPro b) para LocalCompo; Insert Into crGrade;
*                     SELECT Tipos From SigCdTpc Where Custos = 2 para
*                     popular o cmbTipos; Set Filter To Tipos = cmbTipos.Value
*   AtuaTotas      -> Select Sum(Qtds), Sum(Totas) From crGrade Where Marcas
*                     -> grdRodape.Column3 + habilita/desabilita o btnConfirmar
*
* Mapeamento SELECT legado -> coluna real -> propriedade (tipos conferidos
* em docs/schema.sql, lido com Get-Content -Raw por ser UTF-16 - regra #14):
*   a.CPros              -> SigPrCpo.cpros     char(14)      -> this_cCpros
*   a.Mats               -> SigPrCpo.mats      char(14)      -> this_cMats
*   b.DPros              -> SigCdPro.dpros     char(65)      -> this_cDpros
*   a.Qtds               -> SigPrCpo.qtds      numeric(8,3)  -> this_nQtds
*   a.UniCompos          -> SigPrCpo.unicompos char(3)       -> this_cUnicompos
*   b.PVens as PCompos   -> SigCdPro.pvens     numeric(11,5) -> this_nPcompos
*   b.Moevs as Moeds     -> SigCdPro.moevs     char(3)       -> this_cMoeds
*   (a.Qtds * b.PVens)   -> calculado          numeric(11,3) -> this_nTotas
*   a.Etiqs              -> SigPrCpo.etiqs     char(1)       -> this_cEtiqs
*   b.Reffs              -> SigCdPro.reffs     char(40)      -> this_cReffs
*   b.FigJpgs            -> SigCdPro.figjpgs   text NULL     -> this_cFigjpgs
*   a.Tipos              -> SigPrCpo.tipos     char(20)      -> this_cTipos
*   (sem controle)       -> SigPrCpo.cidchaves char(20) PK   -> this_cCidchaves
*
* ATENCAO - as duas colunas "gemeas" que a tela NAO le:
* SigPrCpo tem pcompos numeric(11,3) e moeds char(3) PROPRIAS, mas o SELECT
* legado NAO as usa: ele toma b.PVens as PCompos e b.Moevs as Moeds, isto eh,
* o preco de venda e a moeda de venda do COMPONENTE em SigCdPro. Trocar a
* origem mudaria o valor exibido e o total - por isso as propriedades
* this_nPcompos / this_cMoeds documentam de onde vem (regra #17: a formula e
* a origem do legado se transcrevem, nao se reescrevem).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpCpoBO AS BusinessBase

    *==========================================================================
    * Chave do dialogo - produto cuja composicao esta sendo exibida
    *==========================================================================
    *-- Cpros: char(14) - codigo do produto-PAI. Equivale ao .lpKey do legado
    *-- (.lpKey = Padr(Iif(Type([pKey])=[C], pKey, []), 14)) e eh o filtro da
    *-- consulta da composicao (Where a.CPros = '<lpKey>'). O PADR ate 14 eh
    *-- obrigatorio: a coluna eh char(14) e a comparacao com o valor gravado
    *-- depende do padding (regra #42).
    this_cCpros        = ""   && char(14) NOT NULL - produto-pai (lpKey)

    *-- Descricao do produto-pai, lida de SigCdPro.dpros pelo CursorQuery
    *-- ([SigCdPro],[LocalPro],[Cpros],lpKey,[DPros]) do Init legado. Entra no
    *-- Caption do form e nos dois labels da faixa do cabecalho
    *-- (lblSombra/lblTitulo recebem ThisForm.Caption).
    this_cDprosProduto = ""   && char(65) NOT NULL - descricao do produto-pai

    *-- Cidchaves: char(20) - PRIMARY KEY de SigPrCpo (constraint
    *-- sigprcpo_cidchaves). A tela nao grava, mas a chave eh declarada para o
    *-- ObterChavePrimaria() da auditoria e para que a leitura de uma linha
    *-- possa identificar o registro de origem sem ambiguidade.
    this_cCidchaves    = ""   && char(20) NOT NULL - chave primaria SigPrCpo

    *==========================================================================
    * Linha corrente da composicao (colunas da grade grdItens)
    *==========================================================================
    *-- Marcas: coluna LOGICA que existe SO no cursor da grade (nao ha coluna
    *-- equivalente em SigPrCpo). O legado a inicializa com
    *-- (LocalCompo.Etiqs = [S]), isto eh, o componente nasce marcado quando
    *-- Etiqs = "S", e a alterna com Replace Marcas With Not Marcas nos
    *-- handlers do CheckBox da Column1. Propriedade LOGICA porque a origem eh
    *-- uma comparacao, nao uma coluna numeric(1,0) nem bit.
    this_lMarcas       = .F.  && logico (so cursor) - componente selecionado

    *-- Mats: char(14) - codigo do componente (coluna "Item" da grade). No
    *-- SELECT ele tambem eh o lado do join com SigCdPro (a.Mats = b.CPros).
    this_cMats         = ""   && char(14) NOT NULL - codigo do componente

    *-- Dpros: char(65) - descricao do componente, vinda de SigCdPro.dpros
    *-- (coluna "Descricao", a mais larga da grade - Column3.Width = 394).
    this_cDpros        = ""   && char(65) NOT NULL - descricao do componente

    *-- Qtds: numeric(8,3) - quantidade do componente na composicao. Exibida
    *-- com InputMask [99999.999] na Column4 e somada no total de quantidade
    *-- que habilita o botao OK.
    this_nQtds         = 0    && numeric(8,3) NOT NULL - quantidade

    *-- UniCompos: char(3) - unidade da composicao (coluna "Uni",
    *-- Column5.Width = 31).
    this_cUnicompos    = ""   && char(3) NOT NULL - unidade do componente

    *-- Pcompos: o SELECT legado toma b.PVens as PCompos, ou seja o PRECO DE
    *-- VENDA do componente em SigCdPro - numeric(11,5) -, e NAO a coluna
    *-- SigPrCpo.pcompos (numeric(11,3)), que existe mas nao eh lida. Exibido
    *-- com InputMask [99999999.999] na Column6 ("Valor Unitario").
    this_nPcompos      = 0    && numeric(11,5) NOT NULL - b.PVens as PCompos

    *-- Moeds: o SELECT legado toma b.Moevs as Moeds, isto eh a MOEDA DE
    *-- VENDA do componente em SigCdPro - char(3) -, e NAO a coluna
    *-- SigPrCpo.moeds, que existe mas nao eh lida. Coluna "Moe" da grade
    *-- (Column7.Width = 31).
    this_cMoeds        = ""   && char(3) NOT NULL - b.Moevs as Moeds

    *-- Totas: valor total da linha. Formula do legado, transcrita sem
    *-- reescrita (regra #17): (a.Qtds * b.PVens) - quantidade da composicao
    *-- multiplicada pelo preco de venda do componente. SigPrCpo tem uma
    *-- coluna totas numeric(11,3), mas o SELECT NAO a le: o valor eh sempre
    *-- recalculado. Exibido com InputMask [99999999.99] na Column8, que eh a
    *-- unica coluna em negrito e com BackColor 245,251,136.
    this_nTotas        = 0    && calculado numeric(11,3) - Qtds * PVens

    *-- Etiqs: char(1) - flag de etiqueta do componente. O unico uso na tela
    *-- eh definir o estado inicial de Marcas (Marcas = (Etiqs = "S")); nao
    *-- tem coluna na grade.
    this_cEtiqs        = ""   && char(1) NOT NULL - "S" marca o componente

    *-- Reffs: char(40) - referencia do fornecedor do componente. Nao tem
    *-- coluna na grade: eh usada no titulo da tela de zoom da imagem
    *-- (Do Form SigOpZom With ... , [Ref. Fornecedor : ] + crGrade.Reffs).
    this_cReffs        = ""   && char(40) NOT NULL - ref. do fornecedor

    *-- Figjpgs: coluna text NULL de SigCdPro com a imagem do componente em
    *-- base64. O legado remove os prefixos data:image/...;base64, e decodifica
    *-- com Strconv(..., 14) UMA unica vez, gravando o resultado em arquivo
    *-- temporario antes de atribuir ao .Picture do Image. Propriedade de
    *-- CARACTERE porque guarda o base64 cru; por ser NULL no banco, toda
    *-- leitura passa por Nvl(..., []) como no Insert Into legado.
    this_cFigjpgs      = ""   && text NULL - imagem do componente em base64

    *-- Tipos: char(20) - tipo de composicao da linha. Eh a coluna pela qual o
    *-- cmbTipos FILTRA a grade (Set Filter To Tipos = cmbTipos.Value In
    *-- crGrade), executado tanto no fim do SelecionaDados quanto no Valid do
    *-- combo.
    this_cTipos        = ""   && char(20) NOT NULL - tipo de composicao

    *==========================================================================
    * Linha do rodape (grade grdRodape) - cursor criado no Load legado com
    * Create Cursor crRodape (Descrs c(100), Usuars c(10), Totas n(12,2)).
    * O legado insere UMA linha (Insert Into crRodape (Totas) Values (0)) e so
    * atualiza Totas; Descrs e Usuars ficam em branco, mas existem porque as
    * tres colunas estao ligadas as tres Columns do grdRodape
    * (Column1 -> Descrs, Column2 -> Usuars, Column3 -> Totas).
    *==========================================================================
    this_cDescrsRodape = ""   && c(100) cursor local - Column1 do grdRodape
    this_cUsuarsRodape = ""   && c(10)  cursor local - Column2 do grdRodape
    this_nTotasRodape  = 0    && n(12,2) cursor local - Column3 (total geral)

    *==========================================================================
    * Totais do AtuaTotas
    *
    * O legado agrupa SO as linhas marcadas:
    *   Select [ ] as Agrupar, Sum(Qtds) as Qtds, Sum(Totas) as Totas
    *     From crGrade Where Marcas Group By 1 Into Cursor LocalTot
    * O "Where Marcas" eh criterio de negocio (regra #17): linha DESMARCADA
    * nao entra no total, e nao se troca por soma de tudo.
    * O botao OK fica habilitado apenas quando LocalTot.Qtds > 0.
    *==========================================================================
    this_nTotalQtds    = 0    && soma de Qtds das linhas com Marcas = .T.
    this_nTotalTotas   = 0    && soma de Totas das linhas com Marcas = .T.

    *-- Espelha o Enabled do btnConfirmar: (LocalTot.Qtds > 0) no legado.
    *-- Fonte UNICA do estado do botao - o form apenas reflete esta
    *-- propriedade, para nao existirem dois criterios divergentes.
    this_lPermiteConfirmar = .F.

    *==========================================================================
    * Filtro de tipo (cmbTipos) - ComboBox Style = 2 (dropdown list),
    * FontName "Courier New", SEM ControlSource: ele apenas filtra a grade.
    *==========================================================================
    *-- Valor corrente do combo, usado no Set Filter To Tipos = <valor>.
    this_cTipoSelecionado = ""

    *-- Equivale ao llBrc do SelecionaDados legado: fica .T. quando ALGUMA
    *-- linha da composicao tem Tipos vazio (If Not llBrc And
    *-- Empty(LocalCompo.Tipos)). Nesse caso o legado acrescenta um item
    *-- Space(20) no TOPO do combo e o seleciona por padrao; sem nenhuma linha
    *-- sem tipo, o default passa a ser o PRIMEIRO tipo retornado por SigCdTpc
    *-- (ThisForm.cmbTipos.Value = Iif(llBrc, Space(20), LocalTpCom.Tipos)).
    this_lTemTipoEmBranco = .F.

    *-- Item em branco do combo: Space(20), do tamanho exato de
    *-- SigPrCpo.tipos char(20), para o Set Filter To comparar certo.
    this_cTipoEmBranco    = ""

    *-- Filtro fixo da consulta de tipos: Where Custos = 2 em SigCdTpc
    *-- (coluna numeric(1,0)). Valor TRANSCRITO do legado - mudar aqui muda
    *-- quais tipos o usuario pode escolher.
    this_nCustosFiltro    = 2

    *-- Quantidade de tipos carregados de SigCdTpc (sem contar o item em
    *-- branco), para o form saber se o combo tem conteudo.
    this_nQtdeTipos       = 0

    *==========================================================================
    * Tabelas envolvidas (nomes EXATOS do banco - PILAR 2)
    *==========================================================================
    this_cTabelaComposicao = "SigPrCpo"   && composicao do produto (principal)
    this_cTabelaProduto    = "SigCdPro"   && produto: descricao/preco/imagem
    this_cTabelaTipoComp   = "SigCdTpc"   && tipos de composicao do cmbTipos

    *==========================================================================
    * Aliases dos cursores (PILAR 3 - nomes novos, prefixo cursor_4c_)
    *
    * Correspondencia com o legado:
    *   crGrade    -> this_cCursorGrade     (grade grdItens; no legado o cursor
    *                                        pertence ao form PAI e aqui eh
    *                                        apenas Zap'ado - na arquitetura
    *                                        nova ele eh criado e populado por
    *                                        este BO, e o form pai o le depois
    *                                        que o dialogo fecha)
    *   crRodape   -> this_cCursorRodape    (grade grdRodape, 1 linha)
    *   LocalCompo -> this_cCursorTempComp  (cursor TEMPORARIO do SQLEXEC da
    *                                        composicao; o SQLEXEC nunca vai
    *                                        para o alias ligado ao Grid, que
    *                                        perderia o ColumnCount)
    *   LocalTpCom -> this_cCursorTipos     (tipos de SigCdTpc)
    *   LocalPro   -> this_cCursorProduto   (cabecalho: descricao do produto)
    *   LocalTot   -> this_cCursorTotais    (totais do AtuaTotas)
    *==========================================================================
    this_cCursorGrade     = "cursor_4c_Grade"
    this_cCursorRodape    = "cursor_4c_Rodape"
    this_cCursorTempComp  = "cursor_4c_TempComp"
    this_cCursorTipos     = "cursor_4c_Tipos"
    this_cCursorTempTipos = "cursor_4c_TempTipos"
    this_cCursorProduto   = "cursor_4c_Produto"
    this_cCursorTotais    = "cursor_4c_Totais"

    *==========================================================================
    * Decodificacao da imagem (SigCdPro.figjpgs)
    *
    * O legado retira TRES prefixos data-URI antes do Strconv(..., 14):
    *   Strtran(Strtran(Strtran(FigJpgs,[data:image/png;base64,],[]),
    *                                  [data:image/jpeg;base64,],[]),
    *                                  [data:image/jpg;base64,],[])
    * Os prefixos ficam em propriedades para que exista UM unico lugar com a
    * lista, e o Strconv seja aplicado UMA SO VEZ sobre o resultado - decodar
    * duas vezes devolve lixo e a imagem nao abre.
    *==========================================================================
    this_cPrefixoPng  = "data:image/png;base64,"
    this_cPrefixoJpeg = "data:image/jpeg;base64,"
    this_cPrefixoJpg  = "data:image/jpg;base64,"

    *-- Caminho do arquivo .jpg temporario gerado por StrToFile para alimentar
    *-- o .Picture do Image (no legado: Sys(2023) + "\" + Sys(2015) + ".jpg").
    this_cArquivoImagem = ""

    *==========================================================================
    * Estado do dialogo
    *==========================================================================
    *-- .T. quando o usuario fechou pelo OK (btnConfirmar) e portanto as linhas
    *-- MARCADAS devem ser devolvidas ao form pai; .F. no Cancelar (btnSair),
    *-- que descarta todas as linhas.
    this_lConfirmado      = .F.

    *-- Quantidade de componentes carregados na grade (Reccount do cursor da
    *-- grade), usada pelo legado em If (Reccount([crGrade]) > 0) antes de
    *-- calcular os totais iniciais.
    this_nQtdeComponentes = 0

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Define a tabela principal (SigPrCpo) e a chave primaria REAL (cidchaves
    * - constraint sigprcpo_cidchaves, docs/schema.sql), fixa os valores
    * constantes transcritos do legado e zera o estado de edicao herdado de
    * BusinessBase.
    *
    * NAO sobrescreve Inserir()/Atualizar()/ExecutarExclusao(): esta tela eh
    * um dialogo de SELECAO e todo Insert Into / Replace / Delete do legado
    * tem por destino CURSOR LOCAL (crGrade e crRodape) - o acesso remoto eh
    * 100% Select. O comportamento padrao herdado de BusinessBase (recusar a
    * gravacao e reportar pelo ExibirFalha do Salvar) ja eh o correto, e
    * inventar um INSERT aqui violaria a regra #22 (a lista de colunas vem do
    * schema, nunca de adivinhacao).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigPrCpo")

            THIS.this_cTabela     = "SigPrCpo"
            THIS.this_cCampoChave = "cidchaves"

            *-- Nomes das tabelas auxiliares (PILAR 2 - nomes exatos).
            THIS.this_cTabelaComposicao = "SigPrCpo"
            THIS.this_cTabelaProduto    = "SigCdPro"
            THIS.this_cTabelaTipoComp   = "SigCdTpc"

            *-- Item em branco do cmbTipos: Space(20) = largura de
            *-- SigPrCpo.tipos char(20), igual ao AddItem(Space(20)) legado.
            THIS.this_cTipoEmBranco = SPACE(20)

            *-- Filtro fixo da consulta de tipos (SigCdTpc.custos = 2).
            THIS.this_nCustosFiltro = 2

            *-- Prefixos data-URI removidos antes do Strconv(..., 14).
            THIS.this_cPrefixoPng  = "data:image/png;base64,"
            THIS.this_cPrefixoJpeg = "data:image/jpeg;base64,"
            THIS.this_cPrefixoJpg  = "data:image/jpg;base64,"

            *-- Estado inicial do dialogo: nada carregado, nada marcado, OK
            *-- desabilitado (btnConfirmar.Enabled = .f. no SelecionaDados).
            THIS.this_cCpros            = ""
            THIS.this_cDprosProduto     = ""
            THIS.this_cCidchaves        = ""
            THIS.this_lMarcas           = .F.
            THIS.this_cMats             = ""
            THIS.this_cDpros            = ""
            THIS.this_nQtds             = 0
            THIS.this_cUnicompos        = ""
            THIS.this_nPcompos          = 0
            THIS.this_cMoeds            = ""
            THIS.this_nTotas            = 0
            THIS.this_cEtiqs            = ""
            THIS.this_cReffs            = ""
            THIS.this_cFigjpgs          = ""
            THIS.this_cTipos            = ""
            THIS.this_cDescrsRodape     = ""
            THIS.this_cUsuarsRodape     = ""
            THIS.this_nTotasRodape      = 0
            THIS.this_nTotalQtds        = 0
            THIS.this_nTotalTotas       = 0
            THIS.this_lPermiteConfirmar = .F.
            THIS.this_cTipoSelecionado  = ""
            THIS.this_lTemTipoEmBranco  = .F.
            THIS.this_nQtdeTipos        = 0
            THIS.this_cArquivoImagem    = ""
            THIS.this_lConfirmado       = .F.
            THIS.this_nQtdeComponentes  = 0

            *-- Estado de edicao herdado de BusinessBase: dialogo de selecao
            *-- nunca entra em edicao de registro.
            THIS.this_lEmEdicao       = .F.
            THIS.this_lNovoRegistro   = .F.
            THIS.this_lDadosAlterados = .F.
            THIS.this_cMensagemErro   = ""
            THIS.this_lErroExibido    = .F.

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar SigOpCpoBO:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Devolve a chave primaria da linha corrente
    * (SigPrCpo.cidchaves char(20)), usada pela auditoria de BusinessBase.
    *
    * PADR ate 20 porque a coluna eh char(20) e o valor guardado na property
    * pode vir com ALLTRIM na leitura do cursor (regra #42).
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN PADR(ALLTRIM(THIS.this_cCidchaves), 20)
    ENDFUNC

    *==========================================================================
    * Fase 2 - Metodos de carga (equivalentes ao CRUD desta tela)
    *
    * Este dialogo eh SOMENTE-LEITURA no banco: o Init legado (Load +
    * SelecionaDados) faz so Select; o que o usuario marca so eh persistido
    * quando o form PAI grava a composicao, fora deste BO. Por isso Inserir(),
    * Atualizar() e ExecutarExclusao() NAO sao sobrescritos aqui - o
    * comportamento herdado de BusinessBase (recusar a operacao) ja eh o
    * adequado para este dialogo, e RegistrarAuditoria() so eh chamado por
    * esses dois metodos (regra: Audit System). Os metodos abaixo substituem,
    * um a um, a logica do Load/Init/SelecionaDados/AtuaTotas do legado:
    *
    *   Load + Create Cursor crRodape   -> THIS.Init() (Fase 1)
    *   CursorQuery(SigCdPro,...)       -> THIS.CarregarProduto()
    *   SelecionaDados (Insert crGrade) -> THIS.CarregarComposicao()
    *   SelecionaDados (combo Tipos)    -> THIS.CarregarTipos() (PROTECTED,
    *                                      chamado por CarregarComposicao)
    *   Set Filter To Tipos = ...       -> THIS.AplicarFiltroTipo()
    *   AtuaTotas                       -> THIS.AtualizarTotais()
    *   btnConfirmar.Click              -> THIS.ConfirmarSelecao()
    *   btnSair.Click                   -> THIS.CancelarSelecao()
    *   ImgFigJpg.Click (Strconv+jpg)   -> THIS.DecodificarImagem()
    *   leitura da linha da grade       -> THIS.CarregarDoCursor()
    *==========================================================================

    *==========================================================================
    * CarregarDoCursor - Mapeia a linha CORRENTE de cursor_4c_Grade (ou outro
    * alias informado) para as properties this_* da linha. Usado pelo form
    * sempre que a linha corrente da grade mudar (AfterRowColChange) ou antes
    * de abrir o zoom da imagem (ImgFigJpgClick).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_lMarcas    = TratarNulo(Marcas, .F.)
            THIS.this_cCidchaves = TratarNulo(Cidchaves, "")
            THIS.this_cMats      = TratarNulo(Mats, "")
            THIS.this_cDpros     = TratarNulo(Dpros, "")
            THIS.this_nQtds      = TratarNulo(Qtds, 0)
            THIS.this_cUnicompos = TratarNulo(UniCompos, "")
            THIS.this_nPcompos   = TratarNulo(PCompos, 0)
            THIS.this_cMoeds     = TratarNulo(Moeds, "")
            THIS.this_nTotas     = TratarNulo(Totas, 0)
            THIS.this_cEtiqs     = TratarNulo(Etiqs, "")
            THIS.this_cReffs     = TratarNulo(Reffs, "")
            THIS.this_cFigjpgs   = TratarNulo(FigJpgs, "")
            THIS.this_cTipos     = TratarNulo(Tipos, "")

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarProduto - Valida o produto-pai (par_cCpros, equivalente ao
    * .lpKey legado) e le a descricao em SigCdPro.dpros para compor o Caption
    * do form ("... - <Cpros> - <Dpros>"), igual ao CursorQuery([SigCdPro],
    * [LocalPro],[Cpros],lpKey,[DPros]) do Init legado.
    *
    * Retorna .F. quando o produto nao existe (equivalente ao
    * "MessageBox('O Produto Informado Nao Existe!!!',...) / .Release" do
    * legado) - o form eh quem decide fechar, exibindo this_cMensagemErro.
    *==========================================================================
    FUNCTION CarregarProduto(par_cCpros)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            THIS.this_cCpros = PADR(ALLTRIM(TratarNulo(par_cCpros, "")), 14)

            IF USED(THIS.this_cCursorProduto)
                USE IN (THIS.this_cCursorProduto)
            ENDIF

            loc_cSQL = "SELECT dpros FROM SigCdPro " + ;
                       "WHERE cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorProduto))

            IF loc_nResultado > 0 AND USED(THIS.this_cCursorProduto) ;
                    AND RECCOUNT(THIS.this_cCursorProduto) > 0

                SELECT (THIS.this_cCursorProduto)
                GO TOP
                THIS.this_cDprosProduto = TratarNulo(Dpros, "")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "O Produto Informado N" + CHR(227) + ;
                    "o Existe!!!"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Validar Produto")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarComposicao - Recria cursor_4c_Grade (equivalente a crGrade) com
    * a composicao do produto em THIS.this_cCpros, no mesmo SELECT do legado
    * (SigPrCpo a INNER JOIN SigCdPro b, Order By a.Mats), e so depois monta o
    * filtro de tipos (THIS.CarregarTipos + THIS.AplicarFiltroTipo), igual ao
    * SelecionaDados legado (Zap crGrade/crRodape -> Select -> Insert Into
    * crGrade -> Select Tipos -> Set Filter To).
    *
    * O SQLEXEC NUNCA vai direto para cursor_4c_Grade (regra do SQLEXEC zerar
    * ColumnCount do Grid): a consulta roda em cursor_4c_TempComp e cada linha
    * eh copiada por APPEND BLANK + REPLACE para o cursor local que o Grid usa.
    *==========================================================================
    FUNCTION CarregarComposicao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro, ;
              loc_lTemBranco, loc_cCidchaves, loc_cMats, loc_cDpros, ;
              loc_nQtds, loc_cUnicompos, loc_nPcompos, loc_cMoeds, ;
              loc_nTotas, loc_cEtiqs, loc_cReffs, loc_cFigjpgs, loc_cTipos

        loc_lResultado = .F.
        loc_lTemBranco = .F.

        TRY
            IF USED(THIS.this_cCursorTempComp)
                USE IN (THIS.this_cCursorTempComp)
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.mats, b.dpros, a.qtds, " + ;
                       "a.unicompos, b.pvens AS pcompos, b.moevs AS moeds, " + ;
                       "(a.qtds * b.pvens) AS totas, a.etiqs, b.reffs, " + ;
                       "b.figjpgs, a.tipos " + ;
                       "FROM SigPrCpo a INNER JOIN SigCdPro b " + ;
                       "ON a.mats = b.cpros " + ;
                       "WHERE a.cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros)) + ;
                       " ORDER BY a.mats"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorTempComp))

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Falha ao consultar a composi" + ;
                    CHR(231) + CHR(227) + "o do produto." + CHR(13) + ;
                    CapturarErroSQL()
            ELSE
                IF USED(THIS.this_cCursorGrade)
                    USE IN (THIS.this_cCursorGrade)
                ENDIF

                SET NULL ON
                CREATE CURSOR (THIS.this_cCursorGrade) ;
                    (Marcas L, Cidchaves C(20), Mats C(14), Dpros C(65), ;
                     Qtds N(8,3), UniCompos C(3), PCompos N(11,5), ;
                     Moeds C(3), Totas N(11,3), Etiqs C(1), Reffs C(40), ;
                     FigJpgs M, Tipos C(20))
                SET NULL OFF

                IF USED(THIS.this_cCursorTempComp)
                    SELECT (THIS.this_cCursorTempComp)
                    SCAN
                        loc_cCidchaves = TratarNulo(cidchaves, "")
                        loc_cMats      = TratarNulo(mats, "")
                        loc_cDpros     = TratarNulo(dpros, "")
                        loc_nQtds      = TratarNulo(qtds, 0)
                        loc_cUnicompos = TratarNulo(unicompos, "")
                        loc_nPcompos   = TratarNulo(pcompos, 0)
                        loc_cMoeds     = TratarNulo(moeds, "")
                        loc_nTotas     = TratarNulo(totas, 0)
                        loc_cEtiqs     = TratarNulo(etiqs, "")
                        loc_cReffs     = TratarNulo(reffs, "")
                        loc_cFigjpgs   = TratarNulo(figjpgs, "")
                        loc_cTipos     = TratarNulo(tipos, "")

                        IF EMPTY(loc_cTipos)
                            loc_lTemBranco = .T.
                        ENDIF

                        SELECT (THIS.this_cCursorGrade)
                        APPEND BLANK
                        REPLACE Marcas    WITH (loc_cEtiqs == "S"), ;
                                Cidchaves WITH loc_cCidchaves, ;
                                Mats      WITH loc_cMats, ;
                                Dpros     WITH loc_cDpros, ;
                                Qtds      WITH loc_nQtds, ;
                                UniCompos WITH loc_cUnicompos, ;
                                PCompos   WITH loc_nPcompos, ;
                                Moeds     WITH loc_cMoeds, ;
                                Totas     WITH loc_nTotas, ;
                                Etiqs     WITH loc_cEtiqs, ;
                                Reffs     WITH loc_cReffs, ;
                                FigJpgs   WITH loc_cFigjpgs, ;
                                Tipos     WITH loc_cTipos

                        SELECT (THIS.this_cCursorTempComp)
                    ENDSCAN

                    USE IN (THIS.this_cCursorTempComp)
                ENDIF

                THIS.this_lTemTipoEmBranco = loc_lTemBranco
                THIS.this_nQtdeComponentes = RECCOUNT(THIS.this_cCursorGrade)

                SELECT (THIS.this_cCursorGrade)
                GO TOP

                THIS.CarregarTipos()
                THIS.AplicarFiltroTipo(THIS.this_cTipoSelecionado)

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Carregar Composi" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarTipos (PROTECTED) - Monta cursor_4c_Tipos a partir de SigCdTpc
    * Where Custos = 2 (this_nCustosFiltro), igual ao "Select Tipos From
    * SigCdTpc Where Custos = 2" do SelecionaDados legado. Quando
    * this_lTemTipoEmBranco (setado por CarregarComposicao) acrescenta o item
    * em branco Space(20) no TOPO, igual ao AddItem(Space(20)) legado, e
    * define this_cTipoSelecionado com o default (o item em branco, se
    * existir; senao o primeiro tipo retornado).
    *
    * PROTECTED porque so faz sentido chamado por CarregarComposicao - o form
    * nunca precisa chama-lo isoladamente, so ler cursor_4c_Tipos.
    *==========================================================================
    PROTECTED PROCEDURE CarregarTipos()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro, loc_cTipo
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorTempTipos)
                USE IN (THIS.this_cCursorTempTipos)
            ENDIF

            loc_cSQL = "SELECT tipos FROM SigCdTpc " + ;
                       "WHERE custos = " + ;
                       FormatarNumeroSQL(THIS.this_nCustosFiltro, 0) + ;
                       " ORDER BY tipos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorTempTipos))

            IF USED(THIS.this_cCursorTipos)
                USE IN (THIS.this_cCursorTipos)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorTipos) (Tipos C(20))

            IF THIS.this_lTemTipoEmBranco
                APPEND BLANK
                REPLACE Tipos WITH THIS.this_cTipoEmBranco
            ENDIF

            IF loc_nResultado >= 0 AND USED(THIS.this_cCursorTempTipos)
                SELECT (THIS.this_cCursorTempTipos)
                SCAN
                    loc_cTipo = TratarNulo(tipos, "")
                    SELECT (THIS.this_cCursorTipos)
                    APPEND BLANK
                    REPLACE Tipos WITH loc_cTipo
                    SELECT (THIS.this_cCursorTempTipos)
                ENDSCAN

                USE IN (THIS.this_cCursorTempTipos)
            ENDIF

            THIS.this_nQtdeTipos = RECCOUNT(THIS.this_cCursorTipos)

            SELECT (THIS.this_cCursorTipos)
            GO TOP

            THIS.this_cTipoSelecionado = IIF(RECCOUNT(THIS.this_cCursorTipos) > 0, ;
                TratarNulo(Tipos, THIS.this_cTipoEmBranco), ;
                THIS.this_cTipoEmBranco)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Carregar Tipos de Composi" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AplicarFiltroTipo - Filtra cursor_4c_Grade pelo tipo escolhido no
    * cmbTipos, igual ao "Select crGrade / Set Filter To Tipos =
    * ThisForm.cmbTipos.Value In crGrade / Go Top In crGrade" do Valid legado.
    * Comparacao com == (SET EXACT ON global) contra o valor JA padronizado
    * para 20 posicoes (this_cTipoSelecionado nunca leva ALLTRIM - regra da
    * comparacao com buffer padded).
    *
    * O VALOR ENTRA NA EXPRESSAO COMO LITERAL - NUNCA como THIS.<property>.
    * SET FILTER guarda a expressao como TEXTO e a REAVALIA a cada acesso a
    * registro, resolvendo o THIS contra o objeto que estiver ativo NAQUELE
    * momento - e nao contra este BO. Medido no VFP9 (automation\
    * MedirSetFilterThis.prg, 2026-10-30) com "SET FILTER TO Tipos ==
    * THIS.this_cTipoSelecionado", que o VFP armazena como
    * [TIPOS==This.THIS_CTIPOSELECIONADO]:
    *
    *   GO TOP de DENTRO deste BO        -> OK (3 linhas visiveis)
    *   GO TOP de dentro de OUTRO objeto -> ERRO "Property
    *                                       THIS_CTIPOSELECIONADO is not found"
    *   GO TOP fora de objeto algum      -> o VFP DESCARTA O FILTRO em
    *                                       silencio: FILTER() volta VAZIO
    *   valor como LITERAL               -> OK nos TRES contextos
    *
    * A ultima linha do meio eh a perigosa: o Grid repinta FORA de qualquer
    * metodo, entao a grade passaria a exibir TODOS os tipos sem erro na
    * tela - divergencia muda do legado (PILAR 1), que filtra de verdade.
    * O delimitador do literal eh escolhido entre ", ' e [] para o valor
    * nunca quebrar a expressao.
    *==========================================================================
    FUNCTION AplicarFiltroTipo(par_cTipo)
        LOCAL loc_lResultado, loc_cValor, loc_cExpr
        loc_lResultado = .F.

        THIS.this_cTipoSelecionado = TratarNulo(par_cTipo, THIS.this_cTipoEmBranco)

        IF USED(THIS.this_cCursorGrade)
            loc_cValor = THIS.this_cTipoSelecionado

            DO CASE
            CASE !(CHR(34) $ loc_cValor)
                loc_cExpr = "Tipos == " + CHR(34) + loc_cValor + CHR(34)
            CASE !("'" $ loc_cValor)
                loc_cExpr = "Tipos == '" + loc_cValor + "'"
            OTHERWISE
                loc_cExpr = "Tipos == [" + STRTRAN(loc_cValor, "]", " ") + "]"
            ENDCASE

            SELECT (THIS.this_cCursorGrade)
            SET FILTER TO &loc_cExpr
            GO TOP
            loc_lResultado = .T.
        ENDIF

        THIS.AtualizarTotais()

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * AtualizarTotais - Soma Qtds/Totas das linhas MARCADAS de cursor_4c_Grade
    * e habilita/desabilita a confirmacao, igual ao AtuaTotas legado:
    *   Select Sum(Qtds) as Qtds, Sum(Totas) as Totas From crGrade
    *     Where Marcas Group By 1 Into Cursor LocalTot
    *   btnConfirmar.Enabled = (LocalTot.Qtds > 0)
    * "Where Marcas" eh criterio de negocio (regra #17): linha DESMARCADA
    * nao entra no total - nao se troca por soma de tudo.
    *
    * O TOTAL EH DA COMPOSICAO INTEIRA, NAO DO TIPO FILTRADO - e isso eh
    * FIEL ao legado, nao um descuido. Medido no VFP9 (automation\
    * MedirSelectComSetFilter.prg, 2026-10-30) com SET FILTER ativo em um
    * tipo que cobre 90 de 100: o acesso NAVEGACIONAL (COUNT, SCAN) respeita
    * o filtro e da 90, mas o SELECT SQL local o IGNORA e da 100 - inclusive
    * na forma exata do AtuaTotas legado (Select .. Where Marcas Group By 1).
    * Como o legado usa esse mesmo SELECT, ele tambem totaliza a composicao
    * inteira. NUNCA trocar este SELECT por SCAN/COUNT "para respeitar o
    * filtro": isso mudaria o numero que o usuario ve, em silencio.
    *==========================================================================
    FUNCTION AtualizarTotais()
        LOCAL loc_lResultado, loc_nSomaQtds, loc_nSomaTotas, loc_oErro
        loc_lResultado = .F.
        loc_nSomaQtds  = 0
        loc_nSomaTotas = 0

        TRY
            IF USED(THIS.this_cCursorGrade)
                SELECT SUM(Qtds) AS SomaQtds, SUM(Totas) AS SomaTotas ;
                    FROM (THIS.this_cCursorGrade) WHERE Marcas = .T. ;
                    INTO CURSOR cursor_4c_SomaMarcadas

                IF USED("cursor_4c_SomaMarcadas")
                    loc_nSomaQtds  = TratarNulo(cursor_4c_SomaMarcadas.SomaQtds, 0)
                    loc_nSomaTotas = TratarNulo(cursor_4c_SomaMarcadas.SomaTotas, 0)
                    USE IN cursor_4c_SomaMarcadas
                ENDIF
            ENDIF

            THIS.this_nTotalQtds        = loc_nSomaQtds
            THIS.this_nTotalTotas       = loc_nSomaTotas
            THIS.this_lPermiteConfirmar = (loc_nSomaQtds > 0)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Atualizar Totais")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ConfirmarSelecao - Equivalente ao btnConfirmar.Click legado: descarta as
    * linhas NAO marcadas de cursor_4c_Grade (Select crGrade / Set Filter To /
    * Scan / If Not Marcas / Delete / EndScan) e marca o dialogo como
    * confirmado, para o form PAI ler apenas os componentes escolhidos.
    *==========================================================================
    FUNCTION ConfirmarSelecao()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                SELECT (THIS.this_cCursorGrade)
                SET FILTER TO
                SCAN
                    IF !Marcas
                        DELETE
                    ENDIF
                ENDSCAN
                GO TOP
            ENDIF

            THIS.this_lConfirmado = .T.
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Confirmar Sele" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CancelarSelecao - Equivalente ao btnSair.Click legado: descarta TODAS as
    * linhas de cursor_4c_Grade (Select crGrade / Set Filter To / Scan /
    * Delete / EndScan), incondicional - nao so as desmarcadas - e marca o
    * dialogo como NAO confirmado.
    *==========================================================================
    FUNCTION CancelarSelecao()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                SELECT (THIS.this_cCursorGrade)
                SET FILTER TO
                ZAP
            ENDIF

            THIS.this_lConfirmado = .F.
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Cancelar Sele" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * DecodificarImagem - Remove os tres prefixos data-URI e decodifica o
    * base64 de SigCdPro.figjpgs, gravando o resultado num .jpg temporario,
    * igual ao ImgFigJpg.Click legado:
    *   lcArq = Sys(2023) + [\] + Sys(2015) + [.jpg]
    *   Strconv(Strtran(Strtran(Strtran(FigJpgs,png,[]),jpeg,[]),jpg,[]), 14)
    *   StrToFile(lcFoto, lcArq)
    * O Strconv roda UMA SO VEZ sobre o resultado dos tres Strtran - decodar
    * duas vezes devolve lixo. this_cArquivoImagem fica "" quando nao ha
    * imagem, igual ao Image.Visible = .F. do legado quando Empty(FigJpgs).
    *==========================================================================
    FUNCTION DecodificarImagem(par_cFigjpgsBase64)
        LOCAL loc_lResultado, loc_cBase64, loc_cBinario, loc_cArquivo, loc_oErro
        loc_lResultado = .F.
        THIS.this_cArquivoImagem = ""

        TRY
            loc_cBase64 = TratarNulo(par_cFigjpgsBase64, "")

            IF !EMPTY(loc_cBase64)
                loc_cBase64 = STRTRAN(loc_cBase64, THIS.this_cPrefixoPng,  "")
                loc_cBase64 = STRTRAN(loc_cBase64, THIS.this_cPrefixoJpeg, "")
                loc_cBase64 = STRTRAN(loc_cBase64, THIS.this_cPrefixoJpg,  "")

                loc_cBinario = STRCONV(loc_cBase64, 14)
                loc_cArquivo = ADDBS(SYS(2023)) + SYS(2015) + ".jpg"

                IF STRTOFILE(loc_cBinario, loc_cArquivo) > 0
                    THIS.this_cArquivoImagem = loc_cArquivo
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Decodificar Imagem")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

