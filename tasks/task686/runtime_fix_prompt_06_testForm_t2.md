# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 2/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-10-23 19:52:47] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-23 19:52:47] [INFO] Config FPW: (nao fornecido)
[2026-10-23 19:52:47] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-23 19:52:47] [INFO] Timeout: 300 segundos
[2026-10-23 19:52:47] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_d3g14gjp.prg
[2026-10-23 19:52:47] [INFO] Conteudo do wrapper:
[2026-10-23 19:52:47] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGOPCFE', 'C:\4c\tasks\task686\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGOPCFE', 'C:\4c\tasks\task686\logs\06_testForm.log'
QUIT

[2026-10-23 19:52:47] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_d3g14gjp.prg
[2026-10-23 19:52:47] [INFO] VFP output esperado em: C:\4c\tasks\task686\vfp_output.txt
[2026-10-23 19:52:47] [INFO] Executando Visual FoxPro 9...
[2026-10-23 19:52:47] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_d3g14gjp.prg
[2026-10-23 19:52:47] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_d3g14gjp.prg
[2026-10-23 19:52:47] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGOPCFE
Inicio: 23/10/2026 19:52:48

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
OK - Objeto criado com sucesso
     Tipo: O
     Classe: Formsigopcfe

[ETAPA 3] Mostrando formulario (nao-modal)...
ERRO - Excecao ao mostrar formulario:
     Mensagem: Property WINDOWTYPE is read-only.

=== RESULTADO DO TESTE ===
Fim: 23/10/2026 19:55:20
Duracao: 152 segundos
Return Code: 2
Status: ERRO AO MOSTRAR FORM

===========================
[2026-10-23 19:55:20] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-23 19:55:20] [INFO] VFP9 finalizado em 153.1434946 segundos
[2026-10-23 19:55:20] [INFO] Exit Code: 
[2026-10-23 19:55:20] [INFO] 
[2026-10-23 19:55:20] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-23 19:55:21] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_d3g14gjp.prg
[2026-10-23 19:55:21] [INFO] 
[2026-10-23 19:55:21] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-23 19:55:21] [INFO] * Auto-generated wrapper for parameters
[2026-10-23 19:55:21] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-23 19:55:21] [INFO] * Parameters: 'FormSIGOPCFE', 'C:\4c\tasks\task686\logs\06_testForm.log'
[2026-10-23 19:55:21] [INFO] 
[2026-10-23 19:55:21] [INFO] * Anti-dialog protections for unattended execution
[2026-10-23 19:55:21] [INFO] SET SAFETY OFF
[2026-10-23 19:55:21] [INFO] SET RESOURCE OFF
[2026-10-23 19:55:21] [INFO] SET TALK OFF
[2026-10-23 19:55:21] [INFO] SET NOTIFY OFF
[2026-10-23 19:55:21] [INFO] SYS(2335, 0)
[2026-10-23 19:55:21] [INFO] 
[2026-10-23 19:55:21] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGOPCFE', 'C:\4c\tasks\task686\logs\06_testForm.log'
[2026-10-23 19:55:21] [INFO] QUIT
[2026-10-23 19:55:21] [INFO] 
[2026-10-23 19:55:21] [INFO] === Fim do Wrapper.prg ===
[2026-10-23 19:55:21] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCFE.prg):
*==============================================================================
* FormSIGOPCFE.prg - Pesquisa de Saldos por Funcionario
* Origem: SIGOPCFE.SCX (task686)
* Herda de: FormBase
* Tipo: OPERACIONAL (form de consulta/processamento, SEM tabela propria)
*       Layout FLAT (sem PageFrame Page1/Page2) - filtros (Material/Grupo/Conta),
*       grade de resultado (Funcionario/Nome/Fase/Saldo/Ultimo Balanco) e botoes
*       de acao (Processar/Video/Impressora/Encerrar) direto no form, igual ao
*       SCX legado. Aberto direto pelo menu (popMovimentos), sem form pai.
*
* Fase 3/8 - Estrutura base: cabecalho + orquestrador de montagem visual.
* Fase 4/8 - Grade de resultado (grd_4c_Dados) + botoes de acao
*            (Processar/Video/Impressora/Encerrar), equivalentes aos CRUD
*            dos forms CRUD (este form OPERACIONAL nao tem Incluir/Alterar/
*            Excluir/Buscar - sao os 4 botoes reais do SIGOPCFE.SCX).
* Fase 5/8 - Filtros, parte 1: Material (txt_4c_Mat/txt_4c_DMat) + lookup
*            em SigCdPro + FormParaBO (sincroniza a tela com o BO).
* Fase 6/8 - Filtros, parte 2: Grupo (txt_4c_Grupo/txt_4c__Dgrupo) com
*            lookup via fAcessoContab(), Conta (txt_4c_Conta/txt_4c_Dconta)
*            com lookup via cursor_4c_Cli/FormBuscaAuxiliar, as opcoes
*            Chk_Saldo/chkFalha e o container cnt_4c_Mensagem ("Aguarde...").
* Fase 7/8 - Eventos principais: CmdProcessaClick/CmdVisualizarClick/
*            CmdImprimirClick ligados a logica REAL no BO
*            (SIGOPCFEBO.ProcessarSaldos/ExibirRelatorio) - apuracao
*            completa do saldo (SigCdPro/SigCdCli/SigMvEst/SigCdNec/
*            SigMvCab/SigCdPsc/SigOpCfe, transcricao literal do
*            Processa.Click legado) e emissao do SigOpCfe.frx (copiado do
*            legado para projeto\app\reports\).
* Fase 8/8 - Eventos auxiliares e consolidacao final:
*            - AjustarOrdemTabulacao(): os 17 TabIndex declarados no SCX
*              (ordem de tabulacao eh comportamento visivel - PILAR 1).
*            - HabilitarCampos(par_lHabilitar): fonte UNICA do .Enabled dos
*              filtros, reproduzindo os PROCEDURE When do legado (o When de
*              Get_DMat so libera a busca por descricao enquanto o codigo
*              do material esta vazio).
*            - AjustarBotoesPorModo(): fonte UNICA de grd_4c_Dados.Visible e
*              de cmd_4c_Visualizar/cmd_4c_Imprimir.Enabled, antes espalhada
*              entre ValidarMatExec e CmdProcessaClick - e que por isso nao
*              desligava os botoes no caminho "Nenhum Saldo Selecionado!!!".
*            - FormParaBO (agora PUBLIC) / BOParaForm / LimparCampos: par de
*              transferencia tela<->BO e estado inicial consolidado.
*            - Imprimir(): FormParaBO antes de emitir, porque o legado monta
*              o subtitulo do FRX lendo Get_Mat/Get_DMat da TELA.
*
* NAO existem BtnSalvarClick/BtnCancelarClick/BtnBuscarClick/CarregarLista
* neste form: o SIGOPCFE.SCX nao tem Page1(Lista)/Page2(Dados), nem modo
* INCLUIR/ALTERAR/EXCLUIR, nem botao de gravar/cancelar/buscar - os botoes
* REAIS do legado sao quatro (Processa/Visualizar/Imprimir/Saida) e todos
* tem handler (CmdProcessaClick/CmdVisualizarClick/CmdImprimirClick/
* CmdSaidaClick). Criar aqueles nomes exigiria inventar superficie que o
* legado nao tem (viola o PILAR 1) ou escrever metodo vazio (proibido pela
* regra de completude). A carga da grade vive em CarregarDados().
*==============================================================================

DEFINE CLASS FormSIGOPCFE AS FormBase

    *-- Propriedades visuais (analise.json: Width=1000, Height=600, Tahoma 8)
    Height       = 600
    Width        = 1000
    Caption      = "Pesquisa de Saldos por Funcion" + CHR(225) + "rio"
    AutoCenter   = .T.
    ShowWindow   = 0
    WindowType   = 0
    ShowWindow = 1
    ControlBox   = .F.
    TitleBar     = 0
    Themes       = .F.
    BorderStyle  = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.

    *-- Guarda de reentrancia dos lookups de filtro (regra #37/#47 -
    *-- FormBuscaAuxiliar eh MODAL e tira o foco do TextBox, o que
    *-- redispara o proprio LostFocus; e guarda de valor-ja-validado,
    *-- para nao reabrir o picker quando o valor nao mudou)
    this_lEmLookup              = .F.
    this_cUltimoMatValidado     = ""
    this_cUltimoDMatValidado    = ""
    this_cUltimoGrupoValidado   = ""
    this_cUltimoDGrupoValidado  = ""
    this_cUltimoContaValidado   = ""
    this_cUltimoDContaValidado  = ""

    *-- Estado do resultado apurado, consumido por AjustarBotoesPorModo()
    *-- (fonte UNICA do estado de grd_4c_Dados/cmd_4c_Visualizar/
    *-- cmd_4c_Imprimir). Nasce .T. porque o SCX legado NAO declara
    *-- Grade.Visible nem Visualizar/Imprimir.Enabled - isto eh, a tela abre
    *-- com a grade visivel e os dois botoes habilitados; o legado so os
    *-- derruba no Valid de Get_Mat (material trocado invalida o resultado) e
    *-- os reacende no fim do Processa.Click.
    this_lResultadoValido       = .T.

    *==========================================================================
    * Init - Restaura ShowWindow=1/WindowType=1 (top-level/modal) antes de
    * chamar DODEFAULT() (que dispara FormBase.Init() -> InicializarForm()).
    * A classe declara ShowWindow=0/WindowType=0 porque ShowWindow=1 criaria
    * a janela top-level JA no CREATEOBJECT (nao no Show()), e o
    * TestFormWrapper.prg tenta forcar WindowType=0 DEPOIS de criar o objeto -
    * com a janela ja criada, a atribuicao estoura "Property WINDOWTYPE is
    * read-only." Pular a restauracao em ValidandoUI/ModoTeste eh o mesmo
    * padrao de FormICN/FormICD/FormSigOpBcb (CLAUDE.md - TIMEOUT em VFP9 -T).
    *==========================================================================
    PROCEDURE Init()
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o BO e monta a estrutura visual
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            SET DATE TO BRITISH
            SET CENTURY ON

            THIS.this_oBusinessObject = CREATEOBJECT("SIGOPCFEBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                *-- Estrutura visual base (Fase 3) via orquestrador
                THIS.ConfigurarPageFrame()

                *-- Sincronizar caption nos labels do cabecalho
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                *-- Cursores de referencia (SigCdPam/Pac/OpOpt/Ope/Opd/Gcr/Pro/Cli/Gccr)
                *-- Pulados em validacao de UI (sem conexao SQL - Problema 4 FORMCOR_LICOES)
                *-- cnt_4c_Mensagem replica o "Aguarde! Preparando arquivos."
                *-- do Init() legado (CntMensagem.Visible = .t. ... .Refresh
                *-- ... CarregarCursoresReferencia ... CntMensagem.Visible = .f.)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.cnt_4c_Mensagem.lbl_4c_Label1.Caption = "Aguarde! Preparando arquivos."
                    THIS.cnt_4c_Mensagem.Visible = .T.
                    THIS.Refresh()
                    THIS.this_oBusinessObject.CarregarCursoresReferencia()
                    THIS.cnt_4c_Mensagem.Visible = .F.
                ENDIF

                THIS.TornarControlesVisiveis(THIS)

                *-- Estado inicial consolidado (Fase 8/8): LimparCampos()
                *-- zera os filtros, o BO e a grade de resultado, e fecha
                *-- chamando HabilitarCampos()/AjustarBotoesPorModo(). Roda
                *-- DEPOIS de TornarControlesVisiveis porque aquele forca
                *-- Visible = .T. em tudo e sobrescreveria o estado da grade.
                THIS.LimparCampos()

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar SIGOPCFEBO.", "Erro em InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador de montagem visual
    * SIGOPCFE.SCX e Form PLANO sem PageFrame (cntSombra + filtros + grade +
    * botoes direto no form). Mantido o nome "ConfigurarPageFrame" so para
    * preservar o papel arquitetural de ponto de entrada da montagem visual
    * (mesmo padrao de FormFop/FormDCC), delegando para helpers dedicados.
    * Fase 3: cabecalho. Fase 4: grade de resultado + botoes de acao.
    * Fase 5: filtros, parte 1 - Material (txt_4c_Mat/txt_4c_DMat) + Shape1.
    * Fase 6: filtros, parte 2 - Grupo/Conta/checkboxes/cnt_4c_Mensagem
    * (ConfigurarFiltros() completo).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarFiltros()
        THIS.ConfigurarGrade()
        THIS.ConfigurarBotoes()

        *-- Ordem de tabulacao (Fase 8/8): depende de TODOS os controles ja
        *-- criados, por isso fecha a montagem visual.
        THIS.AjustarOrdemTabulacao()
    ENDPROC

    *==========================================================================
    * AjustarOrdemTabulacao - Transcreve os TabIndex declarados no SCX
    * legado (PILAR 1: a ordem de tabulacao eh comportamento visivel). O
    * dump declara 17 indices nos filhos diretos da Form, nesta ordem:
    *
    *    1 Get_grupo    -> txt_4c_Grupo          10 Say1        -> lbl_4c_Label1
    *    2 get_Dgrupo   -> txt_4c__Dgrupo        11 cntMensagem -> cnt_4c_Mensagem
    *    3 Get_conta    -> txt_4c_Conta          12 Grade       -> grd_4c_Dados
    *    4 Get_dconta   -> txt_4c_Dconta         13 Visualizar  -> cmd_4c_Visualizar
    *    5 Get_Mat      -> txt_4c_Mat            14 Imprimir    -> cmd_4c_Imprimir
    *    6 Get_DMat     -> txt_4c_DMat           15 Saida       -> cmd_4c_Saida
    *    7 Chk_Saldo    -> chk_4c_Chk_Saldo      16 Say2        -> lbl_4c_Label2
    *    8 chkFalha     -> chk_4c_ChkFalha       17 Say5        -> lbl_4c_Label5
    *    9 Processa     -> cmd_4c_Processa
    *
    * Atribuidos em ordem CRESCENTE de proposito: em VFP9 atribuir TabIndex
    * reposiciona o controle na sequencia e DESLOCA os irmaos, entao so
    * percorrendo 1..N na ordem desejada o resultado final eh o pretendido.
    *
    * shp_4c_Shape1 fica de fora porque a classe base Shape NAO tem TabIndex
    * (conferido em automation\propriedades_baseclasses.txt - regra #33:
    * atribuir propriedade inexistente derruba o Init e a tela nao abre), e
    * cnt_4c_Sombra tambem - o cntSombra do legado nao declara TabIndex.
    *==========================================================================
    PROTECTED PROCEDURE AjustarOrdemTabulacao()
        LOCAL loc_oErro
        TRY
            THIS.txt_4c_Grupo.TabIndex      = 1
            THIS.txt_4c__Dgrupo.TabIndex    = 2
            THIS.txt_4c_Conta.TabIndex      = 3
            THIS.txt_4c_Dconta.TabIndex     = 4
            THIS.txt_4c_Mat.TabIndex        = 5
            THIS.txt_4c_DMat.TabIndex       = 6
            THIS.chk_4c_Chk_Saldo.TabIndex  = 7
            THIS.chk_4c_ChkFalha.TabIndex   = 8
            THIS.cmd_4c_Processa.TabIndex   = 9
            THIS.lbl_4c_Label1.TabIndex     = 10
            THIS.cnt_4c_Mensagem.TabIndex   = 11
            THIS.grd_4c_Dados.TabIndex      = 12
            THIS.cmd_4c_Visualizar.TabIndex = 13
            THIS.cmd_4c_Imprimir.TabIndex   = 14
            THIS.cmd_4c_Saida.TabIndex      = 15
            THIS.lbl_4c_Label2.TabIndex     = 16
            THIS.lbl_4c_Label5.TabIndex     = 17
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AjustarOrdemTabulacao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarFiltros - Cria os filtros de pesquisa do SIGOPCFE.SCX.
    * Fase 5/8 (parte 1 de 2): Shape1 (decorativo) + Material (Get_Mat/
    * Get_DMat -> txt_4c_Mat/txt_4c_DMat).
    * Fase 6/8 (parte 2 de 2): Grupo (Get_grupo/get_Dgrupo -> txt_4c_Grupo/
    * txt_4c__Dgrupo), Conta (Get_conta/Get_dconta -> txt_4c_Conta/
    * txt_4c_Dconta), os CheckBoxes (Chk_Saldo/chkFalha) e o cnt_4c_Mensagem
    * (equivalente ao CntMensagem do legado - nasce oculto, Fase 7/8 exibe
    * durante o processamento).
    * Posicoes/propriedades EXATAS do dump (SIGOPCFE.SCX):
    *   Shape1     Top=7/Left=563/Width=229/Height=110, BorderColor=136,189,188
    *   Say1       "Material : " Top=183/Left=126/Width=58
    *   Get_Mat    Top=180/Left=186/Width=108/MaxLength=14  (SigCdPro.CPros)
    *   Get_DMat   Top=180/Left=295/Width=303/MaxLength=40  (SigCdPro.DPros)
    *   Say5       "Grupo : "  Top=123/Left=146 (classe say pura - regra #23)
    *   Get_grupo  Top=119/Left=186/Width=80   (SigCdGcr.Codigos)
    *   get_Dgrupo Top=119/Left=268/Width=302/MaxLength=40 (SigCdGcr.Descrs)
    *   Say2       "Conta :"   Top=150/Left=146
    *   Get_conta  Top=146/Left=186/Width=80   (SigCdCli.IClis)
    *   Get_dconta Top=146/Left=268/Width=302  (SigCdCli.RClis)
    *   Chk_Saldo  "Nao Mostrar Saldos Zerados" Top=207/Left=188/W=153/H=15
    *   chkFalha   "Nao checar falha" Top=207/Left=385/W=99/H=15
    *   cntMensagem Top=268/Left=151/W=497/H=63 (Visible=.F. - exibido so
    *               durante o processamento, Fase 7/8)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 7
                .Left        = 563
                .Width       = 229
                .Height      = 110
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Material : "
                .Left      = 126
                .Top       = 183
                .Width     = 58
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Mat", "TextBox")
            WITH THIS.txt_4c_Mat
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Height        = 23
                .Left          = 186
                .Top           = 180
                .Width         = 108
                .MaxLength     = 14
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(THIS.txt_4c_Mat, "LostFocus", THIS, "ValidarMat")

            THIS.AddObject("txt_4c_DMat", "TextBox")
            WITH THIS.txt_4c_DMat
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Height        = 23
                .Left          = 295
                .Top           = 180
                .Width         = 303
                .MaxLength     = 40
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(THIS.txt_4c_DMat, "LostFocus", THIS, "ValidarDMat")

            *-- Grupo (Get_grupo/get_Dgrupo -> SigCdGcr.Codigos/Descrs)
            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Grupo :"
                .Left      = 146
                .Top       = 123
                .Width     = 45
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Grupo", "TextBox")
            WITH THIS.txt_4c_Grupo
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Height            = 23
                .Left              = 186
                .Top               = 119
                .Width             = 80
                .MaxLength         = 10
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 128)
                .BorderColor       = RGB(100, 100, 100)
                .Value             = ""
                .Visible           = .T.
            ENDWITH
            BINDEVENT(THIS.txt_4c_Grupo, "LostFocus", THIS, "ValidarGrupo")

            THIS.AddObject("txt_4c__Dgrupo", "TextBox")
            WITH THIS.txt_4c__Dgrupo
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Height            = 23
                .Left              = 268
                .Top               = 119
                .Width             = 302
                .MaxLength         = 40
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 128)
                .BorderColor       = RGB(100, 100, 100)
                .Value             = ""
                .Visible           = .T.
            ENDWITH
            BINDEVENT(THIS.txt_4c__Dgrupo, "LostFocus", THIS, "ValidarDGrupo")

            *-- Conta/Funcionario (Get_conta/Get_dconta -> SigCdCli.IClis/RClis)
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = "Conta :"
                .Left      = 146
                .Top       = 150
                .Width     = 40
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Conta", "TextBox")
            WITH THIS.txt_4c_Conta
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Height            = 23
                .Left              = 186
                .Top               = 146
                .Width             = 80
                .MaxLength         = 10
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 128)
                .BorderColor       = RGB(100, 100, 100)
                .Value             = ""
                .Visible           = .T.
            ENDWITH
            BINDEVENT(THIS.txt_4c_Conta, "LostFocus", THIS, "ValidarConta")

            THIS.AddObject("txt_4c_Dconta", "TextBox")
            WITH THIS.txt_4c_Dconta
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Height            = 23
                .Left              = 268
                .Top               = 146
                .Width             = 302
                .MaxLength         = 50
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 128)
                .BorderColor       = RGB(100, 100, 100)
                .Value             = ""
                .Visible           = .T.
            ENDWITH
            BINDEVENT(THIS.txt_4c_Dconta, "LostFocus", THIS, "ValidarDConta")

            *-- Opcoes de processamento (Chk_Saldo/chkFalha). AutoSize=.T. no
            *-- SCX eh NO-OP em CheckBox criado por AddObject (regra #23/
            *-- "autosize_noop_em_checkbox") - usar AutoSize=.F. + Width/
            *-- Height EXATOS do dump (ja calculados pelo Form Designer).
            THIS.AddObject("chk_4c_Chk_Saldo", "CheckBox")
            WITH THIS.chk_4c_Chk_Saldo
                .Top       = 207
                .Left      = 188
                .Width     = 153
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = CHR(78) + CHR(227) + "o Mostrar Saldos Zerados"
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Value     = 0
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("chk_4c_ChkFalha", "CheckBox")
            WITH THIS.chk_4c_ChkFalha
                .Top         = 207
                .Left        = 385
                .Width       = 99
                .Height      = 15
                .FontName    = "Tahoma"
                .FontSize    = 8
                .AutoSize    = .F.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = CHR(78) + CHR(227) + "o checar falha"
                .ToolTipText = CHR(78) + CHR(227) + "o calcula e  n" + CHR(227) + "o subtrai a falha do saldo final"
                .ForeColor   = RGB(90, 90, 90)
                .Themes      = .F.
                .Value       = 0
                .Visible     = .T.
            ENDWITH

            *-- cntMensagem - nasce OCULTO (so aparece durante o
            *-- processamento, "Aguarde..." - Fase 7/8 completa o uso em
            *-- Processar). TornarControlesVisiveis() tem excecao explicita
            *-- para CNT_4C_MENSAGEM (nao forca Visible=.T. no container,
            *-- so nos filhos dele).
            THIS.AddObject("cnt_4c_Mensagem", "Container")
            WITH THIS.cnt_4c_Mensagem
                .Top           = 268
                .Left          = 151
                .Width         = 497
                .Height        = 63
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .F.
            ENDWITH

            THIS.cnt_4c_Mensagem.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.cnt_4c_Mensagem.lbl_4c_Label1
                .FontBold   = .T.
                .FontItalic = .F.
                .FontName   = "Tahoma"
                .FontSize   = 14
                .Alignment  = 2
                .BackStyle  = 0
                .AutoSize   = .F.
                .Caption    = "Aguarde! Preparando arquivos."
                .Height     = 25
                .Left       = 82
                .Top        = 19
                .Width      = 295
                .ForeColor  = RGB(255, 0, 0)
                .Visible    = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltros")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarMat - BINDEVENT de LostFocus em txt_4c_Mat (legado: PROCEDURE
    * Valid de Get_Mat). PUBLIC (alvo de BINDEVENT - regra #3).
    *==========================================================================
    PROCEDURE ValidarMat()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarMatExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    *==========================================================================
    * ValidarMatExec - Replica PROCEDURE Valid de Get_Mat: campo vazio limpa
    * Mat/DMat; campo preenchido abre o lookup (AbrirBuscaMat) e invalida o
    * resultado anterior (ThisForm.Grade.Visible=.f. / Visualizar.Enabled=.f.
    * / Imprimir.Enabled=.f. no legado - aqui grd_4c_Dados/cmd_4c_Visualizar/
    * cmd_4c_Imprimir, criados na Fase 4).
    *==========================================================================
    PROTECTED PROCEDURE ValidarMatExec()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_Mat.Value)

        IF loc_cValor == THIS.this_cUltimoMatValidado
            RETURN
        ENDIF
        THIS.this_cUltimoMatValidado = loc_cValor

        IF EMPTY(loc_cValor)
            THIS.txt_4c_Mat.Value  = ""
            THIS.txt_4c_DMat.Value = ""
            THIS.txt_4c_Mat.Refresh()
            THIS.txt_4c_DMat.Refresh()
        ELSE
            THIS.AbrirBuscaMat()

            *-- Material trocado invalida o resultado apurado (legado:
            *-- Grade.Visible/Visualizar.Enabled/Imprimir.Enabled = .f.),
            *-- agora pelo funil unico AjustarBotoesPorModo (Fase 8/8).
            THIS.this_lResultadoValido = .F.
            THIS.AjustarBotoesPorModo()
        ENDIF

        *-- When de Get_DMat depende de Get_Mat estar vazio: reavaliar em
        *-- AMBOS os ramos (regra #40 - reabilitar no funil de volta).
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *==========================================================================
    * AbrirBuscaMat - Lookup de Material em SigCdPro (CPros/DPros), padrao
    * canonico FormBuscaAuxiliar (regra #37): Init ja tenta match exato; so
    * mostra o picker quando nao encontra sozinho.
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaMat()
        LOCAL loc_cValorAtual, loc_oBusca
        loc_cValorAtual = ALLTRIM(THIS.txt_4c_Mat.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
            gnConnHandle, ;
            "SigCdPro", ;
            "cursor_4c_BuscaMat", ;
            "CPros", ;
            loc_cValorAtual, ;
            "Sele" + CHR(231) + CHR(227) + "o", ;
            .F.)

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaMat") AND RECCOUNT("cursor_4c_BuscaMat") > 0
                    THIS.txt_4c_Mat.Value  = ALLTRIM(cursor_4c_BuscaMat.CPros)
                    THIS.txt_4c_DMat.Value = cursor_4c_BuscaMat.DPros
                    THIS.this_cUltimoMatValidado = ALLTRIM(cursor_4c_BuscaMat.CPros)
                ENDIF
            ELSE
                IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMat")
                        THIS.txt_4c_Mat.Value  = ALLTRIM(cursor_4c_BuscaMat.CPros)
                        THIS.txt_4c_DMat.Value = cursor_4c_BuscaMat.DPros
                        THIS.this_cUltimoMatValidado = ALLTRIM(cursor_4c_BuscaMat.CPros)
                    ELSE
                        THIS.txt_4c_Mat.Value  = ""
                        THIS.txt_4c_DMat.Value = ""
                        THIS.this_cUltimoMatValidado = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaMat")
            USE IN cursor_4c_BuscaMat
        ENDIF

        THIS.txt_4c_Mat.Refresh()
        THIS.txt_4c_DMat.Refresh()
    ENDPROC

    *==========================================================================
    * ValidarDMat - BINDEVENT de LostFocus em txt_4c_DMat (legado: PROCEDURE
    * Valid de Get_DMat). PUBLIC (alvo de BINDEVENT - regra #3).
    *==========================================================================
    PROCEDURE ValidarDMat()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarDMatExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    *==========================================================================
    * ValidarDMatExec - Replica PROCEDURE Valid de Get_DMat: busca reversa
    * por descricao. Ao contrario de Get_Mat, o legado NAO toca
    * Grade.Visible/Visualizar.Enabled/Imprimir.Enabled aqui.
    *==========================================================================
    PROTECTED PROCEDURE ValidarDMatExec()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_DMat.Value)

        IF loc_cValor == THIS.this_cUltimoDMatValidado
            RETURN
        ENDIF
        THIS.this_cUltimoDMatValidado = loc_cValor

        IF EMPTY(loc_cValor)
            THIS.txt_4c_Mat.Value  = ""
            THIS.txt_4c_DMat.Value = ""
            THIS.txt_4c_Mat.Refresh()
            THIS.txt_4c_DMat.Refresh()
        ELSE
            THIS.AbrirBuscaDMat()
        ENDIF

        *-- A busca reversa PREENCHE txt_4c_Mat, e o When de Get_DMat passa a
        *-- recusar o campo (legado: Return Empty(ThisForm.Get_Mat.Value)) -
        *-- por isso o funil tambem roda aqui (Fase 8/8).
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *==========================================================================
    * AbrirBuscaDMat - Lookup reverso de Material em SigCdPro por DPros.
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaDMat()
        LOCAL loc_cValorAtual, loc_oBusca
        loc_cValorAtual = ALLTRIM(THIS.txt_4c_DMat.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
            gnConnHandle, ;
            "SigCdPro", ;
            "cursor_4c_BuscaMat", ;
            "DPros", ;
            loc_cValorAtual, ;
            "Sele" + CHR(231) + CHR(227) + "o", ;
            .F.)

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaMat") AND RECCOUNT("cursor_4c_BuscaMat") > 0
                    THIS.txt_4c_Mat.Value  = ALLTRIM(cursor_4c_BuscaMat.CPros)
                    THIS.txt_4c_DMat.Value = cursor_4c_BuscaMat.DPros
                    THIS.this_cUltimoMatValidado = ALLTRIM(cursor_4c_BuscaMat.CPros)
                ENDIF
            ELSE
                IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMat")
                        THIS.txt_4c_Mat.Value  = ALLTRIM(cursor_4c_BuscaMat.CPros)
                        THIS.txt_4c_DMat.Value = cursor_4c_BuscaMat.DPros
                        THIS.this_cUltimoMatValidado = ALLTRIM(cursor_4c_BuscaMat.CPros)
                    ELSE
                        THIS.txt_4c_Mat.Value  = ""
                        THIS.txt_4c_DMat.Value = ""
                        THIS.this_cUltimoMatValidado = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaMat")
            USE IN cursor_4c_BuscaMat
        ENDIF

        THIS.txt_4c_Mat.Refresh()
        THIS.txt_4c_DMat.Refresh()
    ENDPROC

    *==========================================================================
    * ValidarGrupo / ValidarDGrupo - BINDEVENT de LostFocus em txt_4c_Grupo/
    * txt_4c__Dgrupo (legado: PROCEDURE Valid de Get_grupo/get_Dgrupo).
    * PUBLIC (alvo de BINDEVENT - regra #3).
    * Delegam para fAcessoContab() (utils\functions.prg), que faz sozinho o
    * lookup (SEEK em SigCdGcr + browse fwBuscaSimples quando necessario),
    * a checagem de acesso do usuario ao grupo contabil E preenche os DOIS
    * TextBox (pCod/pDsc) - padrao canonico do projeto (ver
    * Formsigrepes.prg ValidarGrpEstoque/ValidarDsGrpEstoque).
    *==========================================================================
    PROCEDURE ValidarGrupo()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarGrupoExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE ValidarGrupoExec()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_Grupo.Value)

        IF loc_cValor == THIS.this_cUltimoGrupoValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cValor)
            THIS.txt_4c__Dgrupo.Value = ""
            THIS.txt_4c__Dgrupo.Refresh()
        ELSE
            =fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cValor, THIS.txt_4c_Grupo, THIS.txt_4c__Dgrupo)
        ENDIF

        THIS.this_cUltimoGrupoValidado  = ALLTRIM(THIS.txt_4c_Grupo.Value)
        THIS.this_cUltimoDGrupoValidado = ALLTRIM(THIS.txt_4c__Dgrupo.Value)
    ENDPROC

    PROCEDURE ValidarDGrupo()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarDGrupoExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE ValidarDGrupoExec()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c__Dgrupo.Value)

        IF loc_cValor == THIS.this_cUltimoDGrupoValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cValor)
            THIS.txt_4c_Grupo.Value = ""
            THIS.txt_4c_Grupo.Refresh()
        ELSE
            =fAcessoContab(gc_4c_UsuarioLogado, "D", loc_cValor, THIS.txt_4c_Grupo, THIS.txt_4c__Dgrupo)
        ENDIF

        THIS.this_cUltimoGrupoValidado  = ALLTRIM(THIS.txt_4c_Grupo.Value)
        THIS.this_cUltimoDGrupoValidado = ALLTRIM(THIS.txt_4c__Dgrupo.Value)
    ENDPROC

    *==========================================================================
    * ValidarConta / ValidarDConta - BINDEVENT de LostFocus em txt_4c_Conta/
    * txt_4c_Dconta (legado: PROCEDURE Valid de Get_conta/Get_dconta).
    * PUBLIC (alvo de BINDEVENT - regra #3).
    * NAO usa fAcessoContas() aqui (regra de memoria "facessocontas_lookup_
    * ux" - a funcao auto-popula com o 1o match parcial sem selecao
    * explicita do usuario). Em vez disso: SEEK no cursor_4c_Cli (ja
    * carregado por CarregarCursoresReferencia, filtrado GerBals = 1, igual
    * ao TmpCli do legado) e, sem match exato, abre o picker canonico.
    *==========================================================================
    PROCEDURE ValidarConta()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarContaExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE ValidarContaExec()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_Conta.Value)

        IF loc_cValor == THIS.this_cUltimoContaValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cValor)
            THIS.txt_4c_Dconta.Value = ""
            THIS.txt_4c_Dconta.Refresh()
        ELSE
            IF USED("cursor_4c_Cli") AND SEEK(loc_cValor, "cursor_4c_Cli", "BalCodigo")
                THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_Cli.IClis)
                THIS.txt_4c_Dconta.Value = cursor_4c_Cli.RClis
            ELSE
                THIS.AbrirBuscaConta("IClis", loc_cValor)
            ENDIF
            THIS.txt_4c_Conta.Refresh()
            THIS.txt_4c_Dconta.Refresh()
        ENDIF

        THIS.this_cUltimoContaValidado  = ALLTRIM(THIS.txt_4c_Conta.Value)
        THIS.this_cUltimoDContaValidado = ALLTRIM(THIS.txt_4c_Dconta.Value)
    ENDPROC

    PROCEDURE ValidarDConta()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarDContaExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE ValidarDContaExec()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_Dconta.Value)

        IF loc_cValor == THIS.this_cUltimoDContaValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cValor)
            THIS.txt_4c_Conta.Value = ""
            THIS.txt_4c_Conta.Refresh()
        ELSE
            IF USED("cursor_4c_Cli") AND SEEK(loc_cValor, "cursor_4c_Cli", "BalNome")
                THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_Cli.IClis)
                THIS.txt_4c_Dconta.Value = cursor_4c_Cli.RClis
            ELSE
                THIS.AbrirBuscaConta("RClis", loc_cValor)
            ENDIF
            THIS.txt_4c_Conta.Refresh()
            THIS.txt_4c_Dconta.Refresh()
        ENDIF

        THIS.this_cUltimoContaValidado  = ALLTRIM(THIS.txt_4c_Conta.Value)
        THIS.this_cUltimoDContaValidado = ALLTRIM(THIS.txt_4c_Dconta.Value)
    ENDPROC

    *==========================================================================
    * AbrirBuscaConta - Lookup de Conta/Funcionario em SigCdCli (IClis/
    * RClis), filtrado a GerBals = 1 (mesmo filtro de cursor_4c_Cli/TmpCli -
    * so contas habilitadas para balanco). par_cCampo indica o campo de
    * busca inicial ("IClis" ou "RClis" - chamado por ValidarConta/
    * ValidarDConta respectivamente).
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaConta(par_cCampo, par_cValor)
        LOCAL loc_oBusca
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
            gnConnHandle, ;
            "SigCdCli", ;
            "cursor_4c_BuscaConta", ;
            par_cCampo, ;
            par_cValor, ;
            "Cadastro de Contas", ;
            .F., ;
            .F., ;
            "GerBals = 1")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
                    THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                    THIS.txt_4c_Dconta.Value = cursor_4c_BuscaConta.RClis
                ENDIF
            ELSE
                IF USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
                    loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("RClis",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Grupos", "", "Grupo")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                        THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                        THIS.txt_4c_Dconta.Value = cursor_4c_BuscaConta.RClis
                    ELSE
                        THIS.txt_4c_Conta.Value  = ""
                        THIS.txt_4c_Dconta.Value = ""
                    ENDIF
                ELSE
                    THIS.txt_4c_Conta.Value  = ""
                    THIS.txt_4c_Dconta.Value = ""
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Copia os filtros digitados na tela para o Business
    * Object: Material (txt_4c_Mat/txt_4c_DMat), Grupo (txt_4c_Grupo/
    * txt_4c__Dgrupo), Conta (txt_4c_Conta/txt_4c_Dconta) e as opcoes de
    * processamento (chk_4c_Chk_Saldo/chk_4c_ChkFalha - CheckBox.Value eh
    * NUMERICO, regra #36: comparar com = 1, nunca atribuir direto a
    * property LOGICAL do BO).
    *==========================================================================
    *-- PROTECTED obrigatorio: FormBase.prg declara PROTECTED PROCEDURE
    *-- FormParaBO, e em VFP9 a subclasse NAO alarga escopo herdado - escrever
    *-- "PROCEDURE FormParaBO" sem o modificador nao torna o metodo publico,
    *-- so esconde que ele continua protegido (medido: chamada de fora estoura
    *-- "Property FORMPARABO is not found", e PEMSTATUS(...,5) devolve .T.
    *-- porque so responde "existe?", nao "da para chamar daqui?").
    PROTECTED PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_cMaterial     = ALLTRIM(THIS.txt_4c_Mat.Value)
        THIS.this_oBusinessObject.this_cDescMaterial = ALLTRIM(THIS.txt_4c_DMat.Value)
        THIS.this_oBusinessObject.this_cGrupo        = ALLTRIM(THIS.txt_4c_Grupo.Value)
        THIS.this_oBusinessObject.this_cDescGrupo    = ALLTRIM(THIS.txt_4c__Dgrupo.Value)
        THIS.this_oBusinessObject.this_cConta        = ALLTRIM(THIS.txt_4c_Conta.Value)
        THIS.this_oBusinessObject.this_cDescConta    = ALLTRIM(THIS.txt_4c_Dconta.Value)
        THIS.this_oBusinessObject.this_lNaoMostrarSaldosZerados = (THIS.chk_4c_Chk_Saldo.Value = 1)
        THIS.this_oBusinessObject.this_lNaoChecarFalha          = (THIS.chk_4c_ChkFalha.Value = 1)
    ENDPROC

    *==========================================================================
    * BOParaForm - Reciproco de FormParaBO (Fase 8/8): espelha os filtros e as
    * opcoes do Business Object de volta nos controles da tela. Usado por
    * LimparCampos(), depois de THIS.this_oBusinessObject.LimparDados() - o BO
    * eh a fonte do estado zerado e a tela passa a refleti-lo, em vez de cada
    * metodo repetir a lista de valores iniciais.
    *
    * CheckBox.Value eh NUMERICO (regra #36/CLAUDE.md): converter o LOGICAL do
    * BO com IIF(..., 1, 0), nunca atribuir o logico direto.
    *
    * PROTECTED obrigatorio, pelo mesmo motivo de FormParaBO: FormBase.prg
    * declara PROTECTED PROCEDURE BOParaForm e o escopo herdado nao se alarga.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        THIS.txt_4c_Mat.Value       = loc_oBO.this_cMaterial
        THIS.txt_4c_DMat.Value      = loc_oBO.this_cDescMaterial
        THIS.txt_4c_Grupo.Value     = loc_oBO.this_cGrupo
        THIS.txt_4c__Dgrupo.Value   = loc_oBO.this_cDescGrupo
        THIS.txt_4c_Conta.Value     = loc_oBO.this_cConta
        THIS.txt_4c_Dconta.Value    = loc_oBO.this_cDescConta

        THIS.chk_4c_Chk_Saldo.Value = IIF(loc_oBO.this_lNaoMostrarSaldosZerados, 1, 0)
        THIS.chk_4c_ChkFalha.Value  = IIF(loc_oBO.this_lNaoChecarFalha, 1, 0)

        *-- Guardas de "valor ja validado" acompanham a tela: sem isto o
        *-- proximo LostFocus compararia o valor novo com o antigo e pularia
        *-- o lookup (regra #37).
        THIS.this_cUltimoMatValidado    = ALLTRIM(loc_oBO.this_cMaterial)
        THIS.this_cUltimoDMatValidado   = ALLTRIM(loc_oBO.this_cDescMaterial)
        THIS.this_cUltimoGrupoValidado  = ALLTRIM(loc_oBO.this_cGrupo)
        THIS.this_cUltimoDGrupoValidado = ALLTRIM(loc_oBO.this_cDescGrupo)
        THIS.this_cUltimoContaValidado  = ALLTRIM(loc_oBO.this_cConta)
        THIS.this_cUltimoDContaValidado = ALLTRIM(loc_oBO.this_cDescConta)

        THIS.txt_4c_Mat.Refresh()
        THIS.txt_4c_DMat.Refresh()
        THIS.txt_4c_Grupo.Refresh()
        THIS.txt_4c__Dgrupo.Refresh()
        THIS.txt_4c_Conta.Refresh()
        THIS.txt_4c_Dconta.Refresh()
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Fonte UNICA do .Enabled dos campos de filtro
    * (Fase 8/8). Reproduz os PROCEDURE When do SCX legado, que sao o que
    * decide se o campo aceita entrada:
    *
    *   Get_DMat.When   -> Return Empty(ThisForm.Get_Mat.Value)
    *   Get_grupo.When  -> Return .t.
    *   Get_conta.When  -> Return .t.
    *   Get_dconta.When -> Return .y.   (.Y. eh .T. em VFP9)
    *   get_Dgrupo.When -> Return .y.
    *   Get_Mat / Chk_Saldo / chkFalha  -> sem When (sempre acessiveis)
    *
    * Ou seja: a busca reversa por descricao de material (txt_4c_DMat) so
    * esta disponivel enquanto o codigo (txt_4c_Mat) esta vazio - exatamente
    * como no legado, onde o When de Get_DMat recusa o foco depois que o
    * codigo foi preenchido. Por isso este metodo tem de ser chamado em TODO
    * caminho que altera txt_4c_Mat (os validadores e os lookups), nao so na
    * inicializacao (regra #40: quem desabilita tem de reabilitar no funil).
    *
    * par_lHabilitar eh a chave mestra, usada por CmdProcessaClick para
    * bloquear a digitacao enquanto o painel "Aguarde..." esta na tela.
    * Omitido/invalido = .T.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        THIS.txt_4c_Grupo.Enabled     = loc_lHabilitar
        THIS.txt_4c__Dgrupo.Enabled   = loc_lHabilitar
        THIS.txt_4c_Conta.Enabled     = loc_lHabilitar
        THIS.txt_4c_Dconta.Enabled    = loc_lHabilitar
        THIS.txt_4c_Mat.Enabled       = loc_lHabilitar
        THIS.chk_4c_Chk_Saldo.Enabled = loc_lHabilitar
        THIS.chk_4c_ChkFalha.Enabled  = loc_lHabilitar

        *-- When de Get_DMat: so enquanto o codigo do material esta vazio
        THIS.txt_4c_DMat.Enabled = loc_lHabilitar AND EMPTY(ALLTRIM(THIS.txt_4c_Mat.Value))
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Fonte UNICA do estado da grade de resultado e dos
    * dois botoes de emissao (Fase 8/8), governada por this_lResultadoValido:
    *
    *   legado, fim do Processa.Click (apurou saldo):
    *       ThisForm.Grade.Visible = .t. / Visualizar.Enabled = .t. /
    *       Imprimir.Enabled = .t. / Grade.Refresh
    *   legado, Valid de Get_Mat (material trocado invalida o resultado):
    *       ThisForm.Grade.Visible = .f. / Visualizar.Enabled = .f. /
    *       Imprimir.Enabled = .f.
    *   legado, Processa.Click com EOF ("Nenhum Saldo Selecionado!!!"):
    *       Return ANTES das tres linhas - os botoes PERMANECEM desligados.
    *
    * Antes da Fase 8 essas atribuicoes estavam espalhadas em dois metodos; o
    * caminho de EOF do processamento nao as derrubava e a tela ficava
    * oferecendo Video/Impressora sobre um resultado que nao veio.
    *
    * PUBLIC (sem PROTECTED): alvo dos harness de verificacao e de
    * TesteAutomatico.prg, que chamam THIS.oForm.AjustarBotoesPorModo() de
    * fora da classe (regra #3).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        THIS.grd_4c_Dados.Visible      = THIS.this_lResultadoValido
        THIS.cmd_4c_Visualizar.Enabled = THIS.this_lResultadoValido
        THIS.cmd_4c_Imprimir.Enabled   = THIS.this_lResultadoValido
    ENDPROC

    *==========================================================================
    * LimparCampos - Estado inicial consolidado (Fase 8/8): zera o BO
    * (LimparDados), espelha o BO na tela (BOParaForm), descarta o resultado
    * apurado e repoe o .Enabled dos campos e o estado dos botoes.
    *
    * Chamado por InicializarForm() para que o estado de abertura da tela
    * tenha UMA origem, em vez de ficar implicito nos .Value = "" espalhados
    * pelo ConfigurarFiltros.
    *
    * PROTECTED obrigatorio: FormBase.prg declara PROTECTED PROCEDURE
    * LimparCampos (ver nota em FormParaBO).
    *
    * O ZAP eh seguro aqui: cursor_4c_Saldo nasce de CREATE CURSOR, logo com
    * Buffering = 1 (regra #52), e o Form nao declara DataSession = 2.
    *
    * this_lResultadoValido volta a .T. de proposito - e NAO a .F.: o SCX
    * legado nao declara Grade.Visible nem Visualizar/Imprimir.Enabled, logo
    * a tela ABRE com a grade (vazia) visivel e os dois botoes habilitados, e
    * quem clicar em Video/Impressora antes de processar recebe o aviso
    * "Nenhuma Informacao Selecionada!!!" do proprio metodo de emissao.
    * Derrubar os botoes aqui seria desvio do PILAR 1.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.LimparDados()
                THIS.BOParaForm()
            ENDIF

            IF USED("cursor_4c_Saldo")
                SELECT cursor_4c_Saldo
                ZAP
            ENDIF

            THIS.this_lResultadoValido = .T.
            THIS.AjustarBotoesPorModo()
            THIS.HabilitarCampos(.T.)
            THIS.CarregarDados()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Cria cnt_4c_Sombra com labels de titulo
    * Original: cntSombra Top=0, Left=0, Width=800, Height=80 (BackColor=100,100,100)
    * Novo: Top=0, Width=THIS.Width (1000, regra #11 - nunca subtrair largura)
    * Largura dos labels reduzida (THIS.Width - 370) para abrir espaco aos
    * botoes de acao (Processar/Video/Impressora/Encerrar) da Fase 4, que
    * ficam sobre o canto direito do proprio cnt_4c_Sombra.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 16
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 15
                .Width         = THIS.Width - 370
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 16
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 46
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width - 370
                .ForeColor     = RGB(255, 255, 255)
                .ToolTipText   = "T" + CHR(237) + "tulo"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - Cria grd_4c_Dados (equivalente a Grade do legado) e
    * o cursor placeholder cursor_4c_Saldo (equivalente a TmpSaldo, criado no
    * Load do legado: Codigo c(10), Nome c(50), Fase c(10), Saldo n(12,3),
    * Data d). O resultado real so eh populado quando Processar (Fase 7/8)
    * roda; aqui a grade nasce vazia mas com a estrutura final.
    * Posicao/propriedades EXATAS do dump: Top=230, Left=119, Width=561,
    * Height=326 (nao escala com o form - a area de dados nao precisou
    * crescer, so o cabecalho/botoes usam a largura nova de 1000px).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_Saldo")
                SET NULL ON
                CREATE CURSOR cursor_4c_Saldo (Codigo C(10), Nome C(50), Fase C(10), ;
                                                Saldo N(12,3), Data D)
                SET NULL OFF
                INDEX ON Codigo + Fase TAG Impressao FOR Saldo <> 0
                INDEX ON Codigo + Fase TAG Codigo
                INDEX ON Fase + Codigo TAG Carrega
            ENDIF

            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top               = 230
                .Left              = 119
                .Width             = 561
                .Height            = 326
                .FontName          = "Tahoma"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .ScrollBars        = 2
                .RowHeight         = 17
                .GridLineColor     = RGB(238, 238, 238)
                .ReadOnly          = .T.
                .ColumnCount       = 5
                .Visible           = .T.
            ENDWITH

            THIS.CarregarDados()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarDados - Vincula/revincula grd_4c_Dados a cursor_4c_Saldo.
    * Este eh o metodo Carregar* que alimenta a grade neste form (nao ha
    * "CarregarLista": a lista do SIGOPCFE nao eh uma listagem CRUD
    * independente, eh o RESULTADO do processamento disparado pelos campos de
    * filtro - ver nota de Fase 8/8 no cabecalho do arquivo). PUBLIC para ser
    * alcancavel por LimparCampos() e pelos harness de verificacao.
    * Column.Width/Header1 sao redefinidos DEPOIS do ControlSource (Problema
    * 48 CLAUDE.md: RecordSource reseta Width para 90 e Header1.Caption para
    * "Header1"). Chamado agora (grade vazia) e sera chamado de novo quando
    * Processar (fase futura) repopular cursor_4c_Saldo - por isso tambem
    * fecha com GO TOP + Refresh (regra #21: popular cursor nao repinta a
    * grade por si so).
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_oErro, loc_oGrid
        TRY
            IF !USED("cursor_4c_Saldo")
                SET NULL ON
                CREATE CURSOR cursor_4c_Saldo (Codigo C(10), Nome C(50), Fase C(10), ;
                                                Saldo N(12,3), Data D)
                SET NULL OFF
                INDEX ON Codigo + Fase TAG Impressao FOR Saldo <> 0
                INDEX ON Codigo + Fase TAG Codigo
                INDEX ON Fase + Codigo TAG Carrega
            ENDIF

            loc_oGrid = THIS.grd_4c_Dados
            loc_oGrid.RecordSource = ""
            loc_oGrid.RecordSource = "cursor_4c_Saldo"

            loc_oGrid.Column1.ControlSource = "cursor_4c_Saldo.Codigo"
            loc_oGrid.Column2.ControlSource = "cursor_4c_Saldo.Nome"
            loc_oGrid.Column3.ControlSource = "cursor_4c_Saldo.Fase"
            loc_oGrid.Column4.ControlSource = "cursor_4c_Saldo.Saldo"
            loc_oGrid.Column5.ControlSource = "cursor_4c_Saldo.Data"

            WITH loc_oGrid.Column1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Width     = 80
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Header1.Caption   = "Funcion" + CHR(225) + "rio"
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.ForeColor = RGB(0, 0, 0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
                .Text1.FontName    = "Tahoma"
                .Text1.FontSize    = 8
            ENDWITH

            WITH loc_oGrid.Column2
                .FontName  = "Tahoma"
                .FontSize  = 7
                .Width     = 196
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Header1.Caption   = "Nome"
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.ForeColor = RGB(0, 0, 0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
                .Text1.FontName    = "Tahoma"
                .Text1.FontSize    = 7
            ENDWITH

            WITH loc_oGrid.Column3
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Width     = 80
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Header1.Caption   = "Fase"
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.ForeColor = RGB(0, 0, 0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
                .Text1.FontName    = "Tahoma"
                .Text1.FontSize    = 8
            ENDWITH

            WITH loc_oGrid.Column4
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Width     = 86
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Header1.Caption   = "Saldo"
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.ForeColor = RGB(0, 0, 0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
                .Text1.FontName    = "Tahoma"
                .Text1.FontSize    = 8
            ENDWITH

            WITH loc_oGrid.Column5
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Width     = 83
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Header1.Caption   = CHR(218) + "ltimo Balan" + CHR(231) + "o"
                .Header1.Alignment = 2
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.ForeColor = RGB(0, 0, 0)
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
                .Text1.FontName    = "Tahoma"
                .Text1.FontSize    = 8
            ENDWITH

            SELECT cursor_4c_Saldo
            GO TOP
            loc_oGrid.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Cria os 4 botoes de acao reais do SIGOPCFE.SCX
    * (Processar/Video/Impressora/Encerrar - este form OPERACIONAL nao tem
    * CRUD Incluir/Alterar/Excluir). Standalone CommandButton com Picture
    * usa Themes=.T. + DisabledPicture (nao o Themes=.F. literal do SCX) -
    * Visualizar/Imprimir sao Enabled/Disabled durante o processamento
    * (legado: ThisForm.Visualizar.Enabled / ThisForm.Imprimir.Enabled) e
    * sem isso o icone desaparece quando Enabled=.F.
    * Posicoes: Top=3/Width=75/Height=75 iguais ao legado; Left deslocado
    * para a direita (mesma ordem/espacamento contiguo de 75px do SCX) para
    * ocupar a largura nova do form (1000 contra 800 do legado), sobre o
    * canto direito do cnt_4c_Sombra (criado antes, logo os botoes
    * desenham por cima).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cmd_4c_Processa", "CommandButton")
            WITH THIS.cmd_4c_Processa
                .Top             = 3
                .Left            = 690
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontExtend      = .F.
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption         = "Processar"
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .Cancel          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Processa, "Click", THIS, "CmdProcessaClick")

            THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
            WITH THIS.cmd_4c_Imprimir
                .Top             = 3
                .Left            = 765
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontExtend      = .F.
                .WordWrap        = .F.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .Caption         = "Impressora"
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .Cancel          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Imprimir, "Click", THIS, "CmdImprimirClick")

            THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH THIS.cmd_4c_Visualizar
                .Top             = 3
                .Left            = 840
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontExtend      = .F.
                .WordWrap        = .F.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .Caption         = "V" + CHR(237) + "deo"
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .Cancel          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Visualizar, "Click", THIS, "CmdVisualizarClick")

            THIS.AddObject("cmd_4c_Saida", "CommandButton")
            WITH THIS.cmd_4c_Saida
                .Top             = 3
                .Left            = 915
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontExtend      = .F.
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Caption         = "Encerrar"
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .Cancel          = .T.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Saida, "Click", THIS, "CmdSaidaClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdSaidaClick - Encerra o form (legado: PROCEDURE Saida.Click = 1
    * linha, "Thisform.Release"). PUBLIC (sem PROTECTED) - alvo de BINDEVENT.
    *==========================================================================
    PROCEDURE CmdSaidaClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * CmdProcessaClick - Dispara o processamento de saldos (Fase 7/8).
    * Guarda transcrita literalmente do inicio do Processa.Click do legado
    * (If Empty(ThisForm.Get_Mat.Value) / Messagebox('O Produto Deve Ser
    * Informado!!!') / ThisForm.Get_Mat.SetFocus / Return 0); o restante do
    * algoritmo (apuracao de saldo cruzando SigCdPro/SigCdCli/SigMvEst/
    * SigCdNec/SigMvCab/SigCdPsc, ~900 linhas no legado) fica no BO -
    * THIS.this_oBusinessObject.ProcessarSaldos() - que ja recebe os
    * filtros via FormParaBO().
    *
    * O container "Aguarde..." (cnt_4c_Mensagem, Fase 6) replica o
    * CntMensagem.Visible = .t./.f. que envolve a primeira consulta
    * (crSigMvEst) do legado; o restante do processamento (varios
    * fwprogressbar) fica no BO.
    *==========================================================================
    PROCEDURE CmdProcessaClick()
        LOCAL loc_lSucesso, loc_oErro

        THIS.FormParaBO()

        IF EMPTY(THIS.this_oBusinessObject.this_cMaterial)
            MsgAviso("O Produto Deve Ser Informado!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Mat.SetFocus()
            RETURN
        ENDIF

        loc_lSucesso = .F.

        THIS.cnt_4c_Mensagem.lbl_4c_Label1.Caption = "Aguarde!!! Selecionando Movimenta" + CHR(231) + CHR(245) + "es..."
        THIS.cnt_4c_Mensagem.Top     = 112
        THIS.cnt_4c_Mensagem.Visible = .T.
        THIS.HabilitarCampos(.F.)
        THIS.Refresh()

        *-- TRY/CATCH so em volta do processamento (Fase 8/8): ProcessarSaldos
        *-- devolve .F. nos caminhos previstos, mas uma falha inesperada
        *-- (fwprogressbar, SQLEXEC) nao pode deixar a tela com o painel
        *-- "Aguarde..." no ar e os campos desabilitados para sempre - o
        *-- restabelecimento abaixo roda em qualquer saida. Sem RETURN dentro
        *-- do bloco (regra #1).
        TRY
            loc_lSucesso = THIS.this_oBusinessObject.ProcessarSaldos()
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CmdProcessaClick")
        ENDTRY

        THIS.cnt_4c_Mensagem.Visible = .F.
        THIS.HabilitarCampos(.T.)

        *-- Grade/Video/Impressora pelo funil unico: no legado as tres linhas
        *-- que os religam ficam DEPOIS do "Return" do caminho de EOF, ou
        *-- seja, resultado vazio mantem tudo desligado (Fase 8/8).
        THIS.this_lResultadoValido = loc_lSucesso
        THIS.AjustarBotoesPorModo()

        IF loc_lSucesso
            THIS.CarregarDados()
        ELSE
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aviso")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdVisualizarClick / CmdImprimirClick - Video e Impressora (legado:
    * Visualizar.Click chama Impressao('V'), Imprimir.Click chama
    * Impressao('I')). Delegam para o metodo Imprimir(), que por sua vez
    * delega ao BO (THIS.this_oBusinessObject.ExibirRelatorio) - que monta
    * TmpCabec e dispara o SigOpCfe.frx via ExecutarReportForm.
    *==========================================================================
    PROCEDURE CmdVisualizarClick()
        THIS.Imprimir("V")
    ENDPROC

    PROCEDURE CmdImprimirClick()
        THIS.Imprimir("I")
    ENDPROC

    PROTECTED PROCEDURE Imprimir(par_cSaida)
        LOCAL loc_lSucesso

        *-- FormParaBO ANTES de emitir (Fase 8/8): o subtitulo do SigOpCfe.frx
        *-- eh montado pelo BO a partir de this_cMaterial/this_cDescMaterial,
        *-- e o legado le os DOIS campos direto da TELA no momento da emissao
        *-- ('Material : ' + Alltrim(This.Get_Mat.Value) + ' - ' +
        *-- Alltrim(This.Get_DMat.Value)). Sem esta linha, trocar o material
        *-- depois de processar imprimia o cabecalho com o material ANTERIOR.
        THIS.FormParaBO()

        loc_lSucesso = THIS.this_oBusinessObject.ExibirRelatorio(par_cSaida)

        IF !loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
            MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aviso")
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna os controles visiveis recursivamente
    * EXCECOES: cnt_4c_Mensagem (equivalente ao CntMensagem do legado, que
    * nasce com Visible=.F. e so e exibido durante o processamento/Aguarde) e
    * cnt_4c_Sombra (cabecalho - sempre visivel, mas nao deve ser forcado por
    * este metodo generico) - os containers em si NAO sao forcados a
    * Visible=.T. aqui, mas os filhos deles sao preparados recursivamente
    * para que aparecam corretamente quando exibidos.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_MENSAGEM", "CNT_4C_SOMBRA")
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Fecha cursores de referencia e restaura o menu do sistema
    * (DODEFAULT() ao final - FormBase.Destroy() faz o fix do menu encolhido)
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_aCursores[31], loc_nI

        loc_aCursores[1]  = "cursor_4c_Pam"
        loc_aCursores[2]  = "cursor_4c_Pac"
        loc_aCursores[3]  = "cursor_4c_OpOpt"
        loc_aCursores[4]  = "cursor_4c_Ope"
        loc_aCursores[5]  = "cursor_4c_Opd"
        loc_aCursores[6]  = "cursor_4c_Gcr"
        loc_aCursores[7]  = "cursor_4c_Pro"
        loc_aCursores[8]  = "cursor_4c_Cli"
        loc_aCursores[9]  = "cursor_4c_Gccr"
        loc_aCursores[10] = "cursor_4c_Saldo"
        *-- Cursores de trabalho do processamento (Fase 7/8 - ProcessarSaldos)
        loc_aCursores[11] = "cursor_4c_Resumo"
        loc_aCursores[12] = "cursor_4c_Opera"
        loc_aCursores[13] = "cursor_4c_MvEst"
        loc_aCursores[14] = "cursor_4c_CliDet"
        loc_aCursores[15] = "cursor_4c_Fcx"
        loc_aCursores[16] = "cursor_4c_Nens"
        loc_aCursores[17] = "cursor_4c_NensI"
        loc_aCursores[18] = "cursor_4c_Opi"
        loc_aCursores[19] = "cursor_4c_Gru"
        loc_aCursores[20] = "cursor_4c_Ggrp"
        loc_aCursores[21] = "cursor_4c_Eest"
        loc_aCursores[22] = "cursor_4c_EestI"
        loc_aCursores[23] = "cursor_4c_Esti2"
        loc_aCursores[24] = "cursor_4c_Pesa"
        loc_aCursores[25] = "cursor_4c_PesaI"
        loc_aCursores[26] = "cursor_4c_Uni"
        loc_aCursores[27] = "cursor_4c_UltBal"
        loc_aCursores[28] = "cursor_4c_SaldoI"
        loc_aCursores[29] = "cursor_4c_Total"
        loc_aCursores[30] = "cursor_4c_Empresa"
        loc_aCursores[31] = "TmpCabec"

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_nI])
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPCFEBO.prg):
*==============================================================================
* SIGOPCFEBO.prg - Business Object para Pesquisa de Saldos por Funcionario
*
* Form OPERACIONAL sem tabela principal (processamento/consulta de saldos).
* Fontes consultadas: SigCdPro, SigCdGcr, SigCdCli, SigMvEst, SigCdNec, SigCdNei,
*                      SigCdFcx, SigCdOpe, SigCdOpd, SigOpOpt, SigCdPam, SigCdPac.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SIGOPCFEBO AS BusinessBase

    *==========================================================================
    * Filtro: Material (Get_Mat / Get_DMat -> SigCdPro.CPros / DPros)
    *==========================================================================
    this_cMaterial      = ""   && char(14) - Codigo do material/produto pesquisado
    this_cDescMaterial  = ""   && char(40) - Descricao do material/produto

    *==========================================================================
    * Filtro: Grupo de Conta (Get_grupo / get_Dgrupo -> SigCdGcr.Codigos / Descrs)
    *==========================================================================
    this_cGrupo         = ""   && Codigo do grupo de contas (opcional)
    this_cDescGrupo     = ""   && Descricao do grupo de contas

    *==========================================================================
    * Filtro: Conta/Funcionario (Get_conta / Get_dconta -> SigCdCli.IClis / RClis)
    *==========================================================================
    this_cConta         = ""   && Codigo da conta/funcionario (opcional)
    this_cDescConta     = ""   && Descricao da conta/funcionario

    *==========================================================================
    * Opcoes de processamento (Chk_Saldo / chkFalha)
    *==========================================================================
    this_lNaoMostrarSaldosZerados = .F.   && Chk_Saldo - oculta saldo = 0 na grade
    this_lNaoChecarFalha           = .F.   && chkFalha - nao calcula/subtrai falha

    *==========================================================================
    * Estado do processamento (populado por Processar/buscas)
    *==========================================================================
    this_nQtdeRegistros = 0    && Quantidade de registros apurados em TmpSaldo
    this_cCursorSaldo    = "cursor_4c_Saldo"   && Alias do cursor de resultado (grade)

    *-- O cursor do cabecalho MANTEM o nome legado "TmpCabec" de proposito: o
    *-- SigOpCfe.frx referencia TmpCabec.Titulo/TmpCabec.SubTitulo
    *-- explicitamente (conferido no .frt) - renomear para o padrao
    *-- cursor_4c_* faria o relatorio abortar com "Alias TMPCABEC is not
    *-- found". Mesmo tratamento de SigOpCfaBO/sigreanrBO.
    this_cCursorCabecalho = "TmpCabec"
    this_cCursorEmpresa   = "cursor_4c_Empresa"

    *==========================================================================
    * Linha corrente do resultado (cursor_4c_Saldo, equivalente ao TmpSaldo do
    * legado: Codigo/Nome/Fase/Saldo/Data) - populada por CarregarDoCursor()
    * quando o usuario posiciona o cursor numa linha da grade de resultado.
    *==========================================================================
    this_cCodigoSaldo    = ""   && char(10) - Codigo do funcionario/conta
    this_cNomeSaldo      = ""   && char(50) - Nome do funcionario/conta
    this_cFaseSaldo      = ""   && char(10) - Grupo/fase do saldo apurado
    this_nSaldoValor     = 0    && numeric(12,3) - Saldo apurado
    this_dUltimoBalanco  = {}   && date - Data do ultimo balanco da conta

    *==========================================================================
    * Init - Inicializa o Business Object
    * Form OPERACIONAL de consulta/processamento: nao ha tabela principal de
    * CRUD (Inserir/Atualizar/Excluir nao se aplicam), por isso this_cTabela e
    * this_cCampoChave permanecem vazios.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarCursoresReferencia - Carrega os cursores de referencia usados
    * pelo processamento de saldos. Equivalente ao bloco WITH ThisForm ...
    * EndWith do Init() legado do SIGOPCFE.SCX (SigCdPam/SigCdPac/SigOpOpt/
    * SigCdOpe/SigCdOpd/SigCdGcr/SigCdPro/SigCdCli), exceto os trechos de UI
    * (CntMensagem.Visible/.Show), que ficam no Form.
    *
    * Mantido PUBLIC (sem PROTECTED): o Form chama este metodo a partir de
    * InicializarForm(), antes de habilitar os filtros Material/Grupo/Conta.
    *==========================================================================
    PROCEDURE CarregarCursoresReferencia()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            DO WHILE .T.
                *-- SigCdPam: parametros gerais do modulo de balanco/estoque
                loc_cSQL = "SELECT Ouros, BalPortas, BalVelocs, BalTppars, BalBits, " + ;
                           "BalParids, AcertBals, DopeBals, MascNums, GrupoRecs, " + ;
                           "ContaRecs, GrupoPags, ContaPags FROM SigCdPam"
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_Pam)"
                    EXIT
                ENDIF

                *-- SigCdPac: parametros de fechamento
                loc_cSQL = "SELECT ndFechas FROM SigCdPac"
                IF USED("cursor_4c_Pac")
                    USE IN cursor_4c_Pac
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pac")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_Pac)"
                    EXIT
                ENDIF

                *-- SigOpOpt: opcoes por tipo de operacao (percentual de falha)
                loc_cSQL = "SELECT Cods, PFalhas, TFalhas, Trabas, Prodzs FROM SigOpOpt"
                IF USED("cursor_4c_OpOpt")
                    USE IN cursor_4c_OpOpt
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpOpt")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_OpOpt)"
                    EXIT
                ENDIF
                SELECT cursor_4c_OpOpt
                INDEX ON Cods TAG Cods

                *-- SigCdOpe: definicao dos tipos de operacao (origem/destino)
                loc_cSQL = "SELECT Dopes, Origems, EstOrigs, Destinos, EstDests, Opers " + ;
                           "FROM SigCdOpe"
                IF USED("cursor_4c_Ope")
                    USE IN cursor_4c_Ope
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_Ope)"
                    EXIT
                ENDIF
                SELECT cursor_4c_Ope
                INDEX ON Dopes TAG Dopes

                *-- SigCdOpd: definicao dos tipos de operacao de producao
                loc_cSQL = "SELECT Dopps, Origems, EstOrigs, Destinos, EstDests " + ;
                           "FROM SigCdOpd"
                IF USED("cursor_4c_Opd")
                    USE IN cursor_4c_Opd
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Opd")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_Opd)"
                    EXIT
                ENDIF
                SELECT cursor_4c_Opd
                INDEX ON Dopps TAG Dopps

                *-- SigCdGcr: grupos de conta, sem filtro (usado nas checagens de UnifBals)
                loc_cSQL = "SELECT Codigos, UnifBals, GerBals FROM SigCdGcr"
                IF USED("cursor_4c_Gcr")
                    USE IN cursor_4c_Gcr
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gcr")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_Gcr)"
                    EXIT
                ENDIF
                SELECT cursor_4c_Gcr
                INDEX ON Codigos TAG Codigos

                *-- SigCdPro: cadastro de produtos/materiais
                loc_cSQL = "SELECT CPros, DPros, CUnis, CGrus, Varias, Custofs, " + ;
                           "MoeCusfs, MatPrincs, cUniPs FROM SigCdPro"
                IF USED("cursor_4c_Pro")
                    USE IN cursor_4c_Pro
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pro")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_Pro)"
                    EXIT
                ENDIF
                SELECT cursor_4c_Pro
                INDEX ON CPros TAG CPros

                *-- SigCdCli: contas/funcionarios habilitados para balanco (GerBals = 1)
                loc_cSQL = "SELECT IClis, RClis, Grupos, Inativas FROM SigCdCli " + ;
                           "WHERE GerBals = 1"
                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_Cli)"
                    EXIT
                ENDIF
                SELECT cursor_4c_Cli
                INDEX ON Grupos TAG BalGrupo
                INDEX ON IClis  TAG BalCodigo
                INDEX ON RClis  TAG BalNome

                *-- SigCdGcr: grupos de conta habilitados para balanco (GerBals = 1)
                loc_cSQL = "SELECT Codigos, Descrs, TrfPesas, CompAgrus FROM SigCdGcr " + ;
                           "WHERE GerBals = 1"
                IF USED("cursor_4c_Gccr")
                    USE IN cursor_4c_Gccr
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gccr")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_Gccr)"
                    EXIT
                ENDIF
                SELECT cursor_4c_Gccr
                INDEX ON Codigos TAG BalCodigo
                INDEX ON Descrs  TAG BalDescrs

                loc_lResultado = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a linha corrente do cursor de resultado
    * (cursor_4c_Saldo, equivalente ao TmpSaldo do legado) para as
    * propriedades this_cCodigoSaldo/this_cNomeSaldo/this_cFaseSaldo/
    * this_nSaldoValor/this_dUltimoBalanco.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCodigoSaldo    = TratarNulo(Codigo, "")
        THIS.this_cNomeSaldo      = TratarNulo(Nome, "")
        THIS.this_cFaseSaldo      = TratarNulo(Fase, "")
        THIS.this_nSaldoValor     = TratarNulo(Saldo, 0)
        THIS.this_dUltimoBalanco  = TratarNulo(Data, {})

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir / Atualizar / ExecutarExclusao
    *
    * SIGOPCFE e um form OPERACIONAL de consulta e processamento ("Pesquisa
    * de Saldos por Funcionario"): o legado apura o resultado so em cursores
    * locais (TmpSaldo/TmpResumo/TmpOpera), nunca numa tabela propria do SQL
    * Server - os dados persistidos que ele le pertencem a outras entidades
    * (SigMvEst, SigMvCab, SigCdNec, SigCdFcx, etc), cada uma com seu proprio
    * BO. Por isso esta tela nao tem INSERT/UPDATE/DELETE proprios; o
    * comportamento padrao herdado de BusinessBase (recusar a operacao e
    * expor THIS.this_cMensagemErro) ja e o correto aqui.
    *==========================================================================
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Esta tela realiza consulta e processamento de " + ;
                                   "saldos; n" + CHR(227) + "o grava registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Esta tela realiza consulta e processamento de " + ;
                                   "saldos; n" + CHR(227) + "o grava registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "Esta tela realiza consulta e processamento de " + ;
                                   "saldos; n" + CHR(227) + "o exclui registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Nao ha registro proprio persistido por esta BO
    * (ver Inserir/Atualizar/ExecutarExclusao acima). Mantido PROTECTED para
    * compatibilidade com a interface de BusinessBase, devolvendo o codigo
    * do material pesquisado como chave de referencia da consulta atual.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cMaterial
    ENDPROC

    *==========================================================================
    * ProcessarSaldos - Fase 7/8: transcricao literal do Processa.Click do
    * legado (SIGOPCFE.SCX, ~975 linhas) - apura o saldo de Material por
    * Fase (Grupo) e Conta/Funcionario, cruzando Produ" + CHR(231) + CHR(227) +
    * "o (SigCdNec/SigCdNei), Estoque (SigMvCab/SigMvItn/SigMvIts) e Pesagem
    * (SigCdPsc/SigCdPsi), com o saldo anterior em SigOpCfe/SigCdFcx.
    *
    * Regra #17 (CLAUDE.md): a formula e os guards sao regra de negocio -
    * TRANSCRITOS, nao reescritos. Nomes de cursor/variavel seguem o padrao
    * _4c_/loc_ do projeto (PILAR 3); valores/condicoes/ordem permanecem
    * IDENTICOS ao legado, inclusive quando parecem assimetricos entre os
    * ramos origem/destino (ex.: CUnis vindo de TmpPro num bloco e do
    * proprio registro no outro) - e inclusive na linha marcada abaixo, que
    * reproduz um comportamento visivelmente estranho do legado (usa
    * LocalNens.GrupoOs/ContaOs, nao _Grupo/_Conta) porque a regra exige
    * transcricao literal, nao correcao nao verificada.
    *
    * Sem TRY/CATCH (igual ao legado, que tambem nao tem): cada falha de
    * SQLEXEC usa o mesmo "Return 0" do original, aqui RETURN .F. com
    * THIS.this_cMensagemErro preenchido - sintaxe valida porque nao ha
    * bloco TRY envolvendo (regra #1 so veda RETURN DENTRO de TRY/CATCH).
    *
    * Guarda de Material vazio fica no Form (tem o SetFocus do campo).
    *==========================================================================
    PROCEDURE ProcessarSaldos()
        LOCAL loc_cSQL, loc_nResultado, loc_cCodMat, loc_cGrupoF, loc_cContaF
        LOCAL loc_dPDat, loc_lPNot, loc_lFalse
        LOCAL loc_cGrupoProc, loc_cContaProc, loc_nFalhaAdmitida, loc_lTipoQ
        LOCAL loc_oBarraP, loc_oBarra
        LOCAL loc_cEdn, loc_lOrigem, loc_lDestino, loc_cMaterial, loc_cMatResFa
        LOCAL loc_cGrupoD, loc_cContaD, loc_cOperacao
        LOCAL loc_cCodCor, loc_cCodTam, loc_nQtde, loc_nPeso, loc_nFalha
        LOCAL loc_cMat, loc_nSaldoI, loc_nSaidas, loc_nPesagem, loc_nTrabalhado, loc_cMatCorrente
        LOCAL loc_nQtdeSaldo

        *-- Recria/zera os cursores de trabalho (equivalente ao Create
        *-- Cursor do Load legado + Select/Zap do inicio do Click - regra
        *-- #52: ZAP so e seguro porque os dois ja nascem com Buffering<=1).
        IF USED("cursor_4c_Opera")
            SELECT cursor_4c_Opera
            ZAP
        ELSE
            CREATE CURSOR cursor_4c_Opera (Grupo C(10), Conta C(10), CMats C(14), TpOps C(15), ;
                PesoEnts N(12,3), QtdeEnts N(12,3), PesoSais N(12,3), QtdeSais N(12,3), ;
                PFalha N(6,2), Falha N(12,3), PFalhaE N(6,2), FalhaE N(12,3), Varias N(1), ;
                Agregas N(1), AplicFlhs N(1), PesoBSais N(12,3), PesoBEnts N(12,3), ;
                QtdeBEnts N(12,3), QtdeBSais N(12,3))
            INDEX ON Grupo + Conta + CMats + TpOps TAG GrConMatTp
        ENDIF
        SELECT cursor_4c_Opera
        SET ORDER TO GrConMatTp ASCENDING

        IF USED("cursor_4c_Resumo")
            SELECT cursor_4c_Resumo
            ZAP
        ELSE
            CREATE CURSOR cursor_4c_Resumo (Flag L, Flag2 L, Grupo C(10), Conta C(10), CMats C(14), ;
                CUnis C(3), PesoEnts N(12,3), QtdeEnts N(12,3), PesoSais N(12,3), QtdeSais N(12,3), ;
                Saldoi N(12,3), Pesagem N(12,3), FReal N(12,3), FAdmin N(12,3), Saldof N(12,3), ;
                PesoPEnts N(12,3), PesoPSais N(12,3), PfTrabs N(9,2), Flag3 L, Varias N(1), ;
                PesoFabre N(12,3), PesoFabrs N(12,3), cUniPs C(3), CodCors C(4), CodTams C(4), ;
                Visivel L, Agregas N(1))
            INDEX ON Cmats + CodCors + CodTams TAG cpros
            INDEX ON Grupo + Conta + CMats + CodCors + CodTams TAG GrConMat FOR Visivel
        ENDIF
        SELECT cursor_4c_Resumo
        SET ORDER TO GrConMat

        IF !USED("cursor_4c_Saldo")
            THIS.this_cMensagemErro = "Cursor de resultado n" + CHR(227) + "o inicializado."
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Saldo
        SET ORDER TO TAG Codigo
        ZAP

        loc_cCodMat = ALLTRIM(THIS.this_cMaterial)
        loc_cGrupoF = ALLTRIM(THIS.this_cGrupo)
        loc_cContaF = ALLTRIM(THIS.this_cConta)

        loc_cSQL = "SELECT Grupos, Estos FROM SigMvEst WHERE Emps = " + ;
            EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + " AND CPros = " + EscaparSQL(loc_cCodMat) + ;
            IIF(!EMPTY(loc_cGrupoF), " AND Grupos = " + EscaparSQL(loc_cGrupoF), "") + ;
            IIF(!EMPTY(loc_cContaF), " AND Estos = " + EscaparSQL(loc_cContaF), "")

        IF USED("cursor_4c_MvEst")
            USE IN cursor_4c_MvEst
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvEst")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_MvEst)"
            RETURN .F.
        ENDIF

        SELECT cursor_4c_MvEst
        loc_oBarraP = CREATEOBJECT("fwprogressbar", "Processando as Contas...", RECCOUNT())
        IF VARTYPE(loc_oBarraP) = "O"
            loc_oBarraP.Top = loc_oBarraP.Top - INT(loc_oBarraP.Height / 2)
            loc_oBarraP.Show()
        ENDIF
        SCAN
            IF VARTYPE(loc_oBarraP) = "O"
                loc_oBarraP.Update(.T.)
            ENDIF

            loc_cSQL = "SELECT Rclis, GerBals, PagFals, RecFals FROM SigCdCli WHERE Iclis = " + ;
                EscaparSQL(cursor_4c_MvEst.Estos)
            IF USED("cursor_4c_CliDet")
                USE IN cursor_4c_CliDet
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliDet") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_CliDet)"
                RETURN .F.
            ENDIF

            = SEEK(cursor_4c_MvEst.Grupos, "cursor_4c_Gcr", "Codigos")

            IF cursor_4c_CliDet.GerBals <> 1 OR cursor_4c_Gcr.GerBals <> 1
                LOOP
            ENDIF

            loc_cSQL = "SELECT TOP 1 Datas FROM SigCdFcx WHERE Emps = " + ;
                EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + " AND Grupos = " + EscaparSQL(cursor_4c_MvEst.Grupos) + ;
                " AND Contas = " + EscaparSQL(cursor_4c_MvEst.Estos) + " ORDER BY Datas DESC"
            IF USED("cursor_4c_Fcx")
                USE IN cursor_4c_Fcx
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Fcx") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_Fcx)"
                RETURN .F.
            ENDIF

            INSERT INTO cursor_4c_Saldo (Codigo, Nome, Fase, Data) ;
                VALUES (cursor_4c_MvEst.Estos, cursor_4c_CliDet.RClis, cursor_4c_MvEst.Grupos, cursor_4c_Fcx.Datas)

            loc_dPDat          = TTOD(cursor_4c_Fcx.Datas) + cursor_4c_Pac.ndFechas
            loc_lPNot          = .F.
            loc_lFalse         = .F.
            loc_cGrupoProc     = cursor_4c_MvEst.Grupos
            loc_cContaProc     = cursor_4c_MvEst.Estos
            loc_nFalhaAdmitida = 0
            loc_lTipoQ         = .F.

            loc_cSQL = "SELECT Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, Obss, cIdChaves, EmpDnPs " + ;
                "FROM SigCdNec WHERE Emps = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ;
                " AND Datas >= ?loc_dPDat AND ((GrupoDs = " + EscaparSQL(loc_cGrupoProc) + " AND ContaDs = " + ;
                EscaparSQL(loc_cContaProc) + " AND ProcdBal = ?loc_lFalse) OR (GrupoOs = " + EscaparSQL(loc_cGrupoProc) + ;
                " AND ContaOs = " + EscaparSQL(loc_cContaProc) + " AND ProcBals = ?loc_lFalse)) " + ;
                "ORDER BY Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, cIdChaves"

            IF USED("cursor_4c_Nens")
                USE IN cursor_4c_Nens
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nens") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_Nens)"
                RETURN .F.
            ENDIF

            loc_cSQL = "SELECT b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops, b.Peso2s, b.CodCors, b.CodTams " + ;
                "FROM SigCdNec a, SigCdNei b WHERE a.Emps = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ;
                " AND a.Datas >= ?loc_dPDat AND (a.GrupoDs = " + EscaparSQL(loc_cGrupoProc) + " OR a.GrupoOs = " + ;
                EscaparSQL(loc_cGrupoProc) + ") AND (a.ContaDs = " + EscaparSQL(loc_cContaProc) + " OR a.ContaOs = " + ;
                EscaparSQL(loc_cContaProc) + ") AND a.EmpDNPs = b.EmpDNPs AND b.Servicos = ?loc_lPNot " + ;
                "ORDER BY b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops"

            IF USED("cursor_4c_NensI")
                USE IN cursor_4c_NensI
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NensI") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_NensI)"
                RETURN .F.
            ENDIF
            SELECT cursor_4c_NensI
            INDEX ON EmpDNPs TAG EmpDNPs
            SET ORDER TO EmpDNPs

            SELECT cursor_4c_Nens
            loc_oBarra = CREATEOBJECT("fwprogressbar", "Processando Mov. de Produ" + CHR(231) + CHR(227) + "o...", RECCOUNT())
            IF VARTYPE(loc_oBarra) = "O"
                loc_oBarra.Top = loc_oBarra.Top + INT(loc_oBarra.Height / 2)
                loc_oBarra.Show()
            ENDIF
            SCAN
                IF VARTYPE(loc_oBarra) = "O"
                    loc_oBarra.Update(.T.)
                ENDIF

                loc_cEdn = cursor_4c_Nens.Emps + cursor_4c_Nens.Dopps + STR(cursor_4c_Nens.Numps, 10)

                = SEEK(cursor_4c_Nens.Dopps, "cursor_4c_Opd", "Dopps")

                loc_lOrigem   = .F.
                loc_lDestino  = .F.
                loc_cMaterial = SPACE(10)
                loc_cMatResFa = SPACE(10)

                IF cursor_4c_Opd.Origems = 1 AND cursor_4c_Nens.GrupoOs = loc_cGrupoProc AND ;
                        cursor_4c_Nens.ContaOs = loc_cContaProc AND INLIST(cursor_4c_Opd.EstOrigs, 1, 2)
                    loc_lOrigem = .T.
                ENDIF

                IF cursor_4c_Opd.Destinos = 1 AND cursor_4c_Nens.GrupoDs = loc_cGrupoProc AND ;
                        cursor_4c_Nens.ContaDs = loc_cContaProc AND INLIST(cursor_4c_Opd.EstDests, 1, 2)
                    loc_lDestino = .T.
                ENDIF

                IF !loc_lOrigem AND !loc_lDestino
                    LOOP
                ENDIF

                SELECT cursor_4c_NensI
                SEEK loc_cEdn
                SCAN WHILE EmpDNPs = loc_cEdn

                    IF cursor_4c_Gcr.UnifBals = 4
                        IF cursor_4c_NensI.Nops = 0
                            loc_cMaterial = cursor_4c_NensI.CMats
                        ELSE
                            loc_cSQL = "SELECT Cpros FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(cursor_4c_NensI.Nops, 0)
                            IF USED("cursor_4c_Opi")
                                USE IN cursor_4c_Opi
                            ENDIF
                            = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Opi")
                            = SEEK(cursor_4c_Opi.Cpros, "cursor_4c_Pro", "CPros")
                            loc_cMaterial = IIF(EMPTY(cursor_4c_Pro.MatPrincs), cursor_4c_Pam.Ouros, cursor_4c_Pro.MatPrincs)
                        ENDIF
                        IF cursor_4c_NensI.CMats <> loc_cMaterial
                            LOOP
                        ENDIF
                    ELSE
                        IF cursor_4c_Gcr.UnifBals = 3
                            loc_cSQL = "SELECT Cpros FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(cursor_4c_NensI.Nops, 0)
                            IF USED("cursor_4c_Opi")
                                USE IN cursor_4c_Opi
                            ENDIF
                            = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Opi")
                            IF cursor_4c_NensI.Nops = 0
                                loc_cMaterial = cursor_4c_NensI.CMats
                            ELSE
                                = SEEK(cursor_4c_Opi.Cpros, "cursor_4c_Pro", "CPros")
                                loc_cMaterial = IIF(EMPTY(cursor_4c_Pro.MatPrincs), cursor_4c_Pam.Ouros, cursor_4c_Pro.MatPrincs)
                            ENDIF
                        ELSE
                            loc_cMaterial = IIF(cursor_4c_Gcr.UnifBals = 1, cursor_4c_Pam.Ouros, cursor_4c_NensI.CMats)
                        ENDIF
                    ENDIF
                    loc_cMatResFa = loc_cMaterial

                    = SEEK(cursor_4c_NensI.CMats, "cursor_4c_Pro", "CPros")
                    loc_cSQL = "SELECT GruEstPs, ConEstPs, nAgMts, TipoEstos, Mercs FROM SigCdGrp WHERE Cgrus = " + EscaparSQL(cursor_4c_Pro.Cgrus)
                    IF USED("cursor_4c_Gru")
                        USE IN cursor_4c_Gru
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gru")

                    loc_cSQL = "SELECT Aplicflhs FROM SigCdGpr WHERE Codigos = " + EscaparSQL(cursor_4c_Gru.Mercs)
                    IF USED("cursor_4c_Ggrp")
                        USE IN cursor_4c_Ggrp
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ggrp")

                    loc_cCodCor = PADR(IIF(INLIST(cursor_4c_Gru.TipoEstos, 2, 4), cursor_4c_NensI.CodCors, " "), 4)
                    loc_cCodTam = PADR(IIF(INLIST(cursor_4c_Gru.TipoEstos, 3, 4), cursor_4c_NensI.CodTams, " "), 4)

                    IF loc_lOrigem
                        IF !SEEK(cursor_4c_Nens.GrupoOs + cursor_4c_Nens.ContaOs + cursor_4c_NensI.CMats + loc_cCodCor + loc_cCodTam, "cursor_4c_Resumo")
                            INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                                VALUES (cursor_4c_Nens.GrupoOs, cursor_4c_Nens.ContaOs, cursor_4c_NensI.CMats, cursor_4c_Pro.CUnis, ;
                                        cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
                        ENDIF

                        SELECT cursor_4c_Resumo
                        IF cursor_4c_Opd.EstOrigs = 1
                            REPLACE PesoEnts  WITH PesoEnts  + cursor_4c_NensI.Pesos, ;
                                    QtdeEnts  WITH QtdeEnts  + cursor_4c_NensI.Qtds, ;
                                    PesoFabre WITH PesoFabre + cursor_4c_NensI.Peso2s
                        ELSE
                            REPLACE PesoSais  WITH PesoSais  + cursor_4c_NensI.Pesos, ;
                                    QtdeSais  WITH QtdeSais  + cursor_4c_NensI.Qtds, ;
                                    PesoFabrs WITH PesoFabrs + cursor_4c_NensI.Peso2s
                        ENDIF

                        IF !SEEK(cursor_4c_Nens.GrupoOs + cursor_4c_Nens.ContaOs + cursor_4c_NensI.CMats + cursor_4c_NensI.TpOps, "cursor_4c_Opera")
                            INSERT INTO cursor_4c_Opera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                                VALUES (cursor_4c_Nens.GrupoOs, cursor_4c_Nens.ContaOs, cursor_4c_NensI.CMats, ;
                                        cursor_4c_NensI.TpOps, cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, cursor_4c_Ggrp.Aplicflhs)
                        ENDIF

                        SELECT cursor_4c_Opera
                        IF cursor_4c_Opd.EstOrigs = 1
                            REPLACE PesoEnts WITH PesoEnts + cursor_4c_NensI.Pesos, ;
                                    QtdeEnts WITH QtdeEnts + cursor_4c_NensI.Qtds
                        ELSE
                            REPLACE PesoSais WITH PesoSais + cursor_4c_NensI.Pesos, ;
                                    QtdeSais WITH QtdeSais + cursor_4c_NensI.Qtds
                        ENDIF

                        = SEEK(cursor_4c_Opera.TpOps, "cursor_4c_OpOpt", "Cods")

                        IF cursor_4c_OpOpt.PFalhas <> 0 AND cursor_4c_Pro.Varias = 1 AND cursor_4c_OpOpt.TFalhas == "Q" AND !THIS.this_lNaoChecarFalha
                            loc_lTipoQ = .T.
                            IF cursor_4c_Opd.EstOrigs = 1
                                IF cursor_4c_OpOpt.Pfalhas > cursor_4c_NensI.Qtds
                                    loc_nFalha = cursor_4c_NensI.Qtds
                                ELSE
                                    loc_nFalha = cursor_4c_OpOpt.Pfalhas
                                ENDIF

                                REPLACE PFalha WITH loc_nFalha, ;
                                        Falha  WITH cursor_4c_Opera.Falha + loc_nFalha IN cursor_4c_Opera

                                loc_nFalhaAdmitida = loc_nFalhaAdmitida + loc_nFalha
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_lDestino
                        IF !SEEK(cursor_4c_Nens.GrupoDs + cursor_4c_Nens.ContaDs + cursor_4c_NensI.CMats + loc_cCodCor + loc_cCodTam, "cursor_4c_Resumo")
                            INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                                VALUES (cursor_4c_Nens.GrupoDs, cursor_4c_Nens.ContaDs, cursor_4c_NensI.CMats, cursor_4c_Pro.CUnis, ;
                                        cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
                        ENDIF

                        SELECT cursor_4c_Resumo
                        IF cursor_4c_Opd.EstDests = 1
                            REPLACE PesoEnts  WITH PesoEnts  + cursor_4c_NensI.Pesos, ;
                                    QtdeEnts  WITH QtdeEnts  + cursor_4c_NensI.Qtds, ;
                                    PesoFabre WITH PesoFabre + cursor_4c_NensI.Peso2s
                        ELSE
                            REPLACE PesoSais  WITH PesoSais  + cursor_4c_NensI.Pesos, ;
                                    QtdeSais  WITH QtdeSais  + cursor_4c_NensI.Qtds, ;
                                    PesoFabrs WITH PesoFabrs + cursor_4c_NensI.Peso2s
                        ENDIF

                        IF !SEEK(cursor_4c_Nens.GrupoDs + cursor_4c_Nens.ContaDs + cursor_4c_NensI.CMats + cursor_4c_NensI.TpOps, "cursor_4c_Opera")
                            INSERT INTO cursor_4c_Opera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                                VALUES (cursor_4c_Nens.GrupoDs, cursor_4c_Nens.ContaDs, cursor_4c_NensI.CMats, ;
                                        cursor_4c_NensI.TpOps, cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, cursor_4c_Ggrp.Aplicflhs)
                        ENDIF

                        SELECT cursor_4c_Opera
                        IF cursor_4c_Opd.EstDests = 1
                            REPLACE PesoEnts WITH PesoEnts + cursor_4c_NensI.Pesos, ;
                                    QtdeEnts WITH QtdeEnts + cursor_4c_NensI.Qtds
                        ELSE
                            REPLACE PesoSais WITH PesoSais + cursor_4c_NensI.Pesos, ;
                                    QtdeSais WITH QtdeSais + cursor_4c_NensI.Qtds
                        ENDIF

                        = SEEK(cursor_4c_Opera.TpOps, "cursor_4c_OpOpt", "Cods")

                        IF cursor_4c_OpOpt.PFalhas <> 0 AND cursor_4c_Pro.Varias = 1 AND cursor_4c_OpOpt.TFalhas == "Q" AND !THIS.this_lNaoChecarFalha
                            loc_lTipoQ = .T.
                            IF cursor_4c_Opd.EstDests = 1
                                IF cursor_4c_OpOpt.Pfalhas > cursor_4c_NensI.Qtds
                                    loc_nFalha = cursor_4c_NensI.Qtds
                                ELSE
                                    loc_nFalha = cursor_4c_OpOpt.Pfalhas
                                ENDIF

                                REPLACE PFalha WITH loc_nFalha, ;
                                        Falha  WITH cursor_4c_Opera.Falha + loc_nFalha IN cursor_4c_Opera

                                loc_nFalhaAdmitida = loc_nFalhaAdmitida + loc_nFalha
                            ENDIF
                        ENDIF
                    ENDIF

                    = SEEK(cursor_4c_Resumo.CMats, "cursor_4c_Pro", "CPros")
                    loc_cSQL = "SELECT GruEstPs, ConEstPs, nAgMts, TipoEstos, Mercs FROM SigCdGrp WHERE Cgrus = " + EscaparSQL(cursor_4c_Pro.Cgrus)
                    IF USED("cursor_4c_Gru")
                        USE IN cursor_4c_Gru
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gru")

                    loc_cSQL = "SELECT Aplicflhs FROM SigCdGpr WHERE Codigos = " + EscaparSQL(cursor_4c_Gru.Mercs)
                    IF USED("cursor_4c_Ggrp")
                        USE IN cursor_4c_Ggrp
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ggrp")

                    IF cursor_4c_Gcr.UnifBals = 3 AND cursor_4c_NensI.Cmats <> loc_cMaterial AND ;
                            cursor_4c_Gru.GruEstPs <> cursor_4c_MvEst.Grupos AND cursor_4c_Gru.ConEstPs <> cursor_4c_MvEst.Estos
                        = SEEK(loc_cMaterial, "cursor_4c_Pro", "CPros")
                        loc_cSQL = "SELECT GruEstPs, ConEstPs, nAgMts, TipoEstos, Mercs FROM SigCdGrp WHERE Cgrus = " + EscaparSQL(cursor_4c_Pro.Cgrus)
                        IF USED("cursor_4c_Gru")
                            USE IN cursor_4c_Gru
                        ENDIF
                        = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gru")
                        loc_cSQL = "SELECT Aplicflhs FROM SigCdGpr WHERE Codigos = " + EscaparSQL(cursor_4c_Gru.Mercs)
                        IF USED("cursor_4c_Ggrp")
                            USE IN cursor_4c_Ggrp
                        ENDIF
                        = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ggrp")

                        IF loc_lOrigem
                            IF !SEEK(cursor_4c_Nens.GrupoOs + cursor_4c_Nens.ContaOs + loc_cMaterial, "cursor_4c_Resumo")
                                INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Visivel) ;
                                    VALUES (cursor_4c_Nens.GrupoOs, cursor_4c_Nens.ContaOs, loc_cMaterial, cursor_4c_Pro.CUnis, cursor_4c_Pro.Varias, .T.)
                            ENDIF
                            SELECT cursor_4c_Resumo
                            IF cursor_4c_Opd.EstOrigs = 1
                                REPLACE PesoEnts WITH PesoEnts + cursor_4c_NensI.Pesos, ;
                                        QtdeEnts WITH QtdeEnts + cursor_4c_NensI.Pesos
                            ELSE
                                REPLACE PesoSais WITH PesoSais + cursor_4c_NensI.Pesos, ;
                                        QtdeSais WITH QtdeSais + cursor_4c_NensI.Pesos
                            ENDIF
                            IF !SEEK(cursor_4c_Nens.GrupoOs + cursor_4c_Nens.ContaOs + loc_cMaterial + cursor_4c_NensI.TpOps, "cursor_4c_Opera")
                                INSERT INTO cursor_4c_Opera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                                    VALUES (cursor_4c_Nens.GrupoOs, cursor_4c_Nens.ContaOs, loc_cMaterial, cursor_4c_NensI.TpOps, ;
                                            cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, cursor_4c_Ggrp.Aplicflhs)
                            ENDIF
                            SELECT cursor_4c_Opera
                            IF cursor_4c_Opd.EstOrigs = 1
                                REPLACE PesoEnts WITH PesoEnts + cursor_4c_NensI.Pesos, ;
                                        QtdeEnts WITH QtdeEnts + cursor_4c_NensI.Pesos
                            ELSE
                                REPLACE PesoSais WITH PesoSais + cursor_4c_NensI.Pesos, ;
                                        QtdeSais WITH QtdeSais + cursor_4c_NensI.Pesos
                            ENDIF
                        ENDIF

                        IF loc_lDestino
                            IF !SEEK(cursor_4c_Nens.GrupoDs + cursor_4c_Nens.ContaDs + loc_cMaterial, "cursor_4c_Resumo")
                                INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Visivel) ;
                                    VALUES (cursor_4c_Nens.GrupoDs, cursor_4c_Nens.ContaDs, loc_cMaterial, cursor_4c_Pro.CUnis, cursor_4c_Pro.Varias, .T.)
                            ENDIF
                            SELECT cursor_4c_Resumo
                            IF cursor_4c_Opd.EstDests = 1
                                REPLACE PesoEnts WITH PesoEnts + cursor_4c_NensI.Pesos, ;
                                        QtdeEnts WITH QtdeEnts + cursor_4c_NensI.Pesos
                            ELSE
                                REPLACE PesoSais WITH PesoSais + cursor_4c_NensI.Pesos, ;
                                        QtdeSais WITH QtdeSais + cursor_4c_NensI.Pesos
                            ENDIF
                            IF !SEEK(cursor_4c_Nens.GrupoDs + cursor_4c_Nens.ContaDs + loc_cMaterial + cursor_4c_NensI.TpOps, "cursor_4c_Opera")
                                INSERT INTO cursor_4c_Opera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                                    VALUES (cursor_4c_Nens.GrupoDs, cursor_4c_Nens.ContaDs, loc_cMaterial, cursor_4c_NensI.TpOps, ;
                                            cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, cursor_4c_Ggrp.Aplicflhs)
                            ENDIF
                            SELECT cursor_4c_Opera
                            IF cursor_4c_Opd.EstDests = 1
                                REPLACE PesoEnts WITH PesoEnts + cursor_4c_NensI.Pesos, ;
                                        QtdeEnts WITH QtdeEnts + cursor_4c_NensI.Pesos
                            ELSE
                                REPLACE PesoSais WITH PesoSais + cursor_4c_NensI.Pesos, ;
                                        QtdeSais WITH QtdeSais + cursor_4c_NensI.Pesos
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDSCAN
            IF VARTYPE(loc_oBarra) = "O"
                loc_oBarra.Complete()
            ENDIF

            loc_cSQL = "SELECT Datas, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Dopes, Numes, Obses, CidChaves, EmpDs " + ;
                "FROM SigMvCab WHERE (Emps = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + " OR EmpDs = " + ;
                EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ") AND Datas >= ?loc_dPDat AND ((GrupoDs = " + ;
                EscaparSQL(loc_cGrupoProc) + " AND ContaDs = " + EscaparSQL(loc_cContaProc) + " AND ProcdBal = ?loc_lFalse) " + ;
                "OR (GrupoOs = " + EscaparSQL(loc_cGrupoProc) + " AND ContaOs = " + EscaparSQL(loc_cContaProc) + ;
                " AND ProcBals = ?loc_lFalse)) ORDER BY Datas"

            IF USED("cursor_4c_Eest")
                USE IN cursor_4c_Eest
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Eest") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_Eest)"
                RETURN .F.
            ENDIF

            loc_cSQL = "SELECT b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds, b.Pesos, b.cItens " + ;
                "FROM SigMvCab a, SigMvItn b WHERE (a.Emps = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ;
                " OR a.Empds = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ") AND Datas >= ?loc_dPDat AND " + ;
                "(GrupoDs = " + EscaparSQL(loc_cGrupoProc) + " OR GrupoOs = " + EscaparSQL(loc_cGrupoProc) + ") AND " + ;
                "(ContaDs = " + EscaparSQL(loc_cContaProc) + " OR ContaOs = " + EscaparSQL(loc_cContaProc) + ") AND " + ;
                "a.EmpDopNums = b.EmpDopNums ORDER BY b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds"

            IF USED("cursor_4c_EestI")
                USE IN cursor_4c_EestI
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EestI") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_EestI)"
                RETURN .F.
            ENDIF
            SELECT cursor_4c_EestI
            INDEX ON EmpDopNums TAG EmpDopNums
            SET ORDER TO EmpDopNums

            loc_cSQL = "SELECT b.EmpDopNums, b.CPros, b.Qtds, b.Pesos, b.CodCors, b.CodTams, b.Citens " + ;
                "FROM SigMvCab a, SigMvIts b WHERE (a.Emps = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ;
                " OR a.EmpDs = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ") AND Datas >= ?loc_dPDat AND " + ;
                "(GrupoDs = " + EscaparSQL(loc_cGrupoProc) + " OR GrupoOs = " + EscaparSQL(loc_cGrupoProc) + ") AND " + ;
                "(ContaDs = " + EscaparSQL(loc_cContaProc) + " OR ContaOs = " + EscaparSQL(loc_cContaProc) + ") AND " + ;
                "a.EmpDopNums = b.EmpDopNums ORDER BY b.EmpDopNums, b.CPros, b.CodCors, b.CodTams, b.Citens"

            IF USED("cursor_4c_Esti2")
                USE IN cursor_4c_Esti2
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Esti2") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_Esti2)"
                RETURN .F.
            ENDIF
            SELECT cursor_4c_Esti2
            INDEX ON EmpDopNums + Cpros + STR(Citens, 4) TAG EmpDopNums
            SET ORDER TO EmpDopNums

            SELECT cursor_4c_Eest
            loc_oBarra = CREATEOBJECT("fwprogressbar", "Processando Mov. de Estoque", RECCOUNT("cursor_4c_Eest"))
            IF VARTYPE(loc_oBarra) = "O"
                loc_oBarra.Top = loc_oBarra.Top + INT(loc_oBarra.Height / 2)
                loc_oBarra.Show()
            ENDIF
            SCAN
                IF VARTYPE(loc_oBarra) = "O"
                    loc_oBarra.Update(.T.)
                ENDIF

                loc_cEdn = cursor_4c_Eest.Emps + cursor_4c_Eest.Dopes + STR(cursor_4c_Eest.Numes, 6)

                = SEEK(cursor_4c_Eest.Dopes, "cursor_4c_Ope", "Dopes")

                loc_lOrigem  = .F.
                loc_lDestino = .F.
                IF cursor_4c_Eest.Emps = go_4c_Sistema.cCodEmpresa
                    IF cursor_4c_Ope.EstOrigs = 4 OR cursor_4c_Ope.Opers = 3
                        IF cursor_4c_Ope.Origems = 1 AND cursor_4c_Eest.GrupoOs = loc_cGrupoProc AND cursor_4c_Eest.ContaOs = loc_cContaProc
                            loc_lOrigem = .T.
                        ELSE
                            IF cursor_4c_Ope.Destinos = 1 AND cursor_4c_Eest.GrupoDs = loc_cGrupoProc AND cursor_4c_Eest.ContaDs = loc_cContaProc
                                loc_lDestino = .T.
                            ENDIF
                        ENDIF
                    ELSE
                        IF cursor_4c_Ope.Origems = 1 AND cursor_4c_Eest.GrupoOs = loc_cGrupoProc AND cursor_4c_Eest.ContaOs = loc_cContaProc
                            IF INLIST(cursor_4c_Ope.EstOrigs, 1, 2)
                                loc_lOrigem = .T.
                            ENDIF
                        ENDIF
                        IF cursor_4c_Ope.Destinos = 1 AND cursor_4c_Eest.GrupoDs = loc_cGrupoProc AND cursor_4c_Eest.ContaDs = loc_cContaProc
                            IF INLIST(cursor_4c_Ope.EstDests, 1, 2)
                                loc_lDestino = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ELSE
                    IF cursor_4c_Eest.EmpDs = go_4c_Sistema.cCodEmpresa
                        IF cursor_4c_Ope.Destinos = 1 AND cursor_4c_Eest.GrupoDs = loc_cGrupoProc AND cursor_4c_Eest.ContaDs = loc_cContaProc
                            IF INLIST(cursor_4c_Ope.EstDests, 1, 2)
                                loc_lDestino = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                IF !loc_lOrigem AND !loc_lDestino
                    LOOP
                ENDIF

                SELECT cursor_4c_EestI
                SEEK loc_cEdn
                SCAN WHILE EmpDopNums = loc_cEdn
                    = SEEK(cursor_4c_EestI.Cpros, "cursor_4c_Pro", "CPros")

                    loc_cSQL = "SELECT GruEstPs, ConEstPs, nAgMts, TipoEstos, Mercs FROM SigCdGrp WHERE Cgrus = " + EscaparSQL(cursor_4c_Pro.Cgrus)
                    IF USED("cursor_4c_Gru")
                        USE IN cursor_4c_Gru
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gru")
                    loc_cSQL = "SELECT Aplicflhs FROM SigCdGpr WHERE Codigos = " + EscaparSQL(cursor_4c_Gru.Mercs)
                    IF USED("cursor_4c_Ggrp")
                        USE IN cursor_4c_Ggrp
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ggrp")

                    loc_cGrupoD   = SPACE(10)
                    loc_cContaD   = SPACE(10)
                    loc_cOperacao = " "

                    IF cursor_4c_Ope.EstOrigs = 4
                        loc_lOrigem  = .F.
                        loc_lDestino = .F.

                        IF cursor_4c_EestI.Opers == "S" AND cursor_4c_Eest.GrupoOs = loc_cGrupoProc AND cursor_4c_Eest.ContaOs = loc_cContaProc
                            loc_lOrigem   = .T.
                            loc_cOperacao = "S"
                            loc_cGrupoD   = cursor_4c_Eest.GrupoDs
                            loc_cContaD   = cursor_4c_Eest.ContaDs
                        ELSE
                            IF cursor_4c_EestI.Opers == "E" AND cursor_4c_Eest.GrupoDs = loc_cGrupoProc AND cursor_4c_Eest.ContaDs = loc_cContaProc
                                loc_lDestino  = .T.
                                loc_cOperacao = "E"
                                loc_cGrupoD   = cursor_4c_Eest.GrupoOs
                                loc_cContaD   = cursor_4c_Eest.ContaOs
                            ENDIF
                        ENDIF
                    ELSE
                        IF cursor_4c_Ope.Opers = 3
                            IF cursor_4c_Ope.Origems = 1
                                IF cursor_4c_EestI.Opers == "S" AND cursor_4c_Eest.GrupoOs = loc_cGrupoProc AND cursor_4c_Eest.ContaOs = loc_cContaProc
                                    loc_lOrigem   = .T.
                                    loc_lDestino  = .F.
                                    loc_cOperacao = "S"
                                    loc_cGrupoD   = cursor_4c_Eest.GrupoOs
                                    loc_cContaD   = cursor_4c_Eest.ContaOs
                                ELSE
                                    IF cursor_4c_EestI.Opers == "E" AND cursor_4c_Eest.GrupoOs = loc_cGrupoProc AND cursor_4c_Eest.ContaOs = loc_cContaProc
                                        loc_lOrigem   = .F.
                                        loc_lDestino  = .T.
                                        loc_cOperacao = "E"
                                        loc_cGrupoD   = cursor_4c_Eest.GrupoOs
                                        loc_cContaD   = cursor_4c_Eest.ContaOs
                                    ENDIF
                                ENDIF
                            ELSE
                                IF cursor_4c_Ope.Destinos = 1
                                    IF cursor_4c_EestI.Opers == "S" AND cursor_4c_Eest.GrupoDs = loc_cGrupoProc AND cursor_4c_Eest.ContaDs = loc_cContaProc
                                        loc_lOrigem   = .T.
                                        loc_cOperacao = "S"
                                        loc_cGrupoD   = cursor_4c_Eest.GrupoDs
                                        loc_cContaD   = cursor_4c_Eest.ContaDs
                                    ELSE
                                        IF cursor_4c_EestI.Opers == "E" AND cursor_4c_Eest.GrupoDs = loc_cGrupoProc AND cursor_4c_Eest.ContaDs = loc_cContaProc
                                            loc_lDestino  = .T.
                                            loc_cOperacao = "E"
                                            loc_cGrupoD   = cursor_4c_Eest.GrupoDs
                                            loc_cContaD   = cursor_4c_Eest.ContaDs
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ELSE
                            IF loc_lOrigem AND cursor_4c_Ope.EstOrigs = 1
                                loc_cOperacao = "E"
                                IF cursor_4c_Ope.Destinos = 1 AND cursor_4c_Ope.EstDests = 2
                                    loc_cGrupoD = cursor_4c_Eest.GrupoDs
                                    loc_cContaD = cursor_4c_Eest.ContaDs
                                ENDIF
                            ELSE
                                IF loc_lOrigem AND cursor_4c_Ope.EstOrigs = 2
                                    loc_cOperacao = "S"
                                    IF cursor_4c_Ope.Destinos = 1 AND cursor_4c_Ope.EstDests = 1
                                        loc_cGrupoD = cursor_4c_Eest.GrupoDs
                                        loc_cContaD = cursor_4c_Eest.ContaDs
                                    ENDIF
                                ELSE
                                    IF loc_lDestino AND cursor_4c_Ope.EstDests = 1
                                        loc_cOperacao = "E"
                                        IF cursor_4c_Ope.Origems = 1 AND cursor_4c_Ope.EstOrigs = 2
                                            loc_cGrupoD = cursor_4c_Eest.GrupoOs
                                            loc_cContaD = cursor_4c_Eest.ContaOs
                                        ENDIF
                                    ELSE
                                        IF loc_lDestino AND cursor_4c_Ope.EstDests = 2
                                            loc_cOperacao = "S"
                                            IF cursor_4c_Ope.Origems = 1 AND cursor_4c_Ope.EstOrigs = 1
                                                loc_cGrupoD = cursor_4c_Eest.GrupoOs
                                                loc_cContaD = cursor_4c_Eest.ContaOs
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF

                    IF INLIST(cursor_4c_Gcr.UnifBals, 3, 4)
                        loc_cMaterial = IIF(EMPTY(cursor_4c_Pro.MatPrincs), cursor_4c_Pam.Ouros, cursor_4c_Pro.MatPrincs)
                    ELSE
                        loc_cMaterial = IIF(cursor_4c_Gcr.UnifBals = 1, cursor_4c_Pam.Ouros, cursor_4c_EestI.Cpros)
                    ENDIF
                    loc_cMatResFa = loc_cMaterial

                    IF cursor_4c_Gcr.UnifBals = 4 AND cursor_4c_EestI.Cpros <> loc_cMaterial
                        LOOP
                    ENDIF

                    loc_cSQL = "SELECT Cunis FROM SigCdUni WHERE Cunis = " + EscaparSQL(cursor_4c_Pro.Cunis)
                    IF USED("cursor_4c_Uni")
                        USE IN cursor_4c_Uni
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Uni")

                    SELECT cursor_4c_Esti2
                    SET ORDER TO EmpDopNums
                    IF SEEK(cursor_4c_EestI.EmpDopNums + cursor_4c_EestI.Cpros + STR(cursor_4c_EestI.Citens, 4))
                        SCAN WHILE EmpDopNums + Cpros + STR(Citens, 4) = cursor_4c_EestI.EmpDopNums + cursor_4c_EestI.Cpros + STR(cursor_4c_EestI.Citens, 4)
                            loc_nQtde = cursor_4c_Esti2.Qtds
                            loc_nPeso = cursor_4c_Esti2.Pesos

                            loc_cCodCor = PADR(IIF(INLIST(cursor_4c_Gru.TipoEstos, 2, 4), cursor_4c_Esti2.CodCors, " "), 4)
                            loc_cCodTam = PADR(IIF(INLIST(cursor_4c_Gru.TipoEstos, 3, 4), cursor_4c_Esti2.CodTams, " "), 4)

                            IF loc_lOrigem
                                IF !SEEK(loc_cGrupoProc + loc_cContaProc + cursor_4c_Esti2.CPros + loc_cCodCor + loc_cCodTam, "cursor_4c_Resumo")
                                    INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                                        VALUES (loc_cGrupoProc, loc_cContaProc, cursor_4c_EestI.CPros, cursor_4c_EestI.CUnis, ;
                                                cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
                                ENDIF

                                SELECT cursor_4c_Resumo
                                IF loc_cOperacao == "E"
                                    REPLACE QtdeEnts  WITH QtdeEnts  + cursor_4c_Esti2.Qtds, ;
                                            PesoEnts  WITH PesoEnts  + loc_nQtde, ;
                                            PesoFabre WITH PesoFabre + loc_nQtde
                                ELSE
                                    REPLACE QtdeSais  WITH QtdeSais  + cursor_4c_Esti2.Qtds, ;
                                            PesoSais  WITH PesoSais  + loc_nQtde, ;
                                            PesoFabrs WITH PesoFabrs + loc_nQtde
                                ENDIF
                                IF !SEEK(loc_cGrupoProc + loc_cContaProc + cursor_4c_EestI.CPros + SPACE(15), "cursor_4c_Opera")
                                    INSERT INTO cursor_4c_Opera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                                        VALUES (loc_cGrupoProc, loc_cContaProc, cursor_4c_EestI.CPros, SPACE(15), ;
                                                cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, cursor_4c_Ggrp.Aplicflhs)
                                ENDIF
                                SELECT cursor_4c_Opera
                                IF loc_cOperacao == "E"
                                    REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde
                                    REPLACE PesoEnts WITH PesoEnts + loc_nQtde
                                ELSE
                                    REPLACE QtdeSais WITH QtdeSais + loc_nQtde
                                    REPLACE PesoSais WITH PesoSais + loc_nQtde
                                ENDIF
                            ENDIF

                            IF loc_lDestino
                                IF !SEEK(loc_cGrupoProc + loc_cContaProc + cursor_4c_Esti2.CPros + loc_cCodCor + loc_cCodTam, "cursor_4c_Resumo")
                                    INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                                        VALUES (loc_cGrupoProc, loc_cContaProc, cursor_4c_EestI.CPros, cursor_4c_Pro.CUnis, ;
                                                cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
                                ENDIF

                                SELECT cursor_4c_Resumo
                                IF loc_cOperacao == "E"
                                    REPLACE QtdeEnts  WITH QtdeEnts  + cursor_4c_Esti2.Qtds, ;
                                            PesoEnts  WITH PesoEnts  + loc_nQtde, ;
                                            PesoFabre WITH PesoFabre + loc_nQtde
                                ELSE
                                    REPLACE QtdeSais  WITH QtdeSais  + cursor_4c_Esti2.Qtds, ;
                                            PesoSais  WITH PesoSais  + loc_nQtde, ;
                                            PesoFabrs WITH PesoFabrs + loc_nQtde
                                ENDIF
                            ENDIF
                        ENDSCAN
                    ELSE
                        loc_nQtde = cursor_4c_EestI.Qtds
                        loc_nPeso = cursor_4c_EestI.Pesos

                        IF loc_lOrigem
                            IF !SEEK(loc_cGrupoProc + loc_cContaProc + cursor_4c_EestI.CPros, "cursor_4c_Resumo")
                                INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                                    VALUES (loc_cGrupoProc, loc_cContaProc, cursor_4c_EestI.CPros, cursor_4c_EestI.CUnis, ;
                                            cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, .T.)
                            ENDIF

                            SELECT cursor_4c_Resumo
                            IF loc_cOperacao == "E"
                                REPLACE QtdeEnts  WITH QtdeEnts  + cursor_4c_EestI.Qtds, ;
                                        PesoEnts  WITH PesoEnts  + loc_nQtde, ;
                                        PesoFabre WITH PesoFabre + loc_nQtde
                            ELSE
                                REPLACE QtdeSais  WITH QtdeSais  + cursor_4c_EestI.Qtds, ;
                                        PesoSais  WITH PesoSais  + loc_nQtde, ;
                                        PesoFabrs WITH PesoFabrs + loc_nQtde
                            ENDIF
                            IF !SEEK(loc_cGrupoProc + loc_cContaProc + cursor_4c_EestI.CPros + SPACE(15), "cursor_4c_Opera")
                                INSERT INTO cursor_4c_Opera (Grupo, Conta, CMats, TpOps, AplicFlhs) ;
                                    VALUES (loc_cGrupoProc, loc_cContaProc, cursor_4c_EestI.CPros, SPACE(15), cursor_4c_Ggrp.Aplicflhs)
                            ENDIF
                            SELECT cursor_4c_Opera
                            IF loc_cOperacao == "E"
                                REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde
                                REPLACE PesoEnts WITH PesoEnts + loc_nQtde
                            ELSE
                                REPLACE QtdeSais WITH QtdeSais + loc_nQtde
                                REPLACE PesoSais WITH PesoSais + loc_nQtde
                            ENDIF
                        ENDIF

                        IF loc_lDestino
                            IF !SEEK(loc_cGrupoProc + loc_cContaProc + cursor_4c_EestI.CPros, "cursor_4c_Resumo")
                                INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                                    VALUES (loc_cGrupoProc, loc_cContaProc, cursor_4c_EestI.CPros, cursor_4c_Pro.CUnis, ;
                                            cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, .T.)
                            ENDIF

                            SELECT cursor_4c_Resumo
                            IF loc_cOperacao == "E"
                                REPLACE QtdeEnts  WITH QtdeEnts  + cursor_4c_EestI.Qtds, ;
                                        PesoEnts  WITH PesoEnts  + loc_nQtde, ;
                                        PesoFabre WITH PesoFabre + loc_nQtde
                            ELSE
                                REPLACE QtdeSais  WITH QtdeSais  + cursor_4c_EestI.Qtds, ;
                                        PesoSais  WITH PesoSais  + loc_nQtde, ;
                                        PesoFabrs WITH PesoFabrs + loc_nQtde
                            ENDIF
                            IF !SEEK(loc_cGrupoProc + loc_cContaProc + cursor_4c_EestI.CPros + SPACE(15), "cursor_4c_Opera")
                                INSERT INTO cursor_4c_Opera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                                    VALUES (loc_cGrupoProc, loc_cContaProc, cursor_4c_EestI.CPros, SPACE(15), ;
                                            cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, cursor_4c_Ggrp.Aplicflhs)
                            ENDIF
                            SELECT cursor_4c_Opera
                            IF loc_cOperacao == "E"
                                REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde
                                REPLACE PesoEnts WITH PesoEnts + loc_nQtde
                            ELSE
                                REPLACE QtdeSais WITH QtdeSais + loc_nQtde
                                REPLACE PesoSais WITH PesoSais + loc_nQtde
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDSCAN
            IF VARTYPE(loc_oBarra) = "O"
                loc_oBarra.Complete()
            ENDIF

            loc_cSQL = "SELECT Emps, Codigos FROM SigCdPsc WHERE Emps = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ;
                " AND Grupos = " + EscaparSQL(loc_cGrupoProc) + " AND Contas = " + EscaparSQL(loc_cContaProc) + ;
                " AND Datas >= ?loc_dPDat AND ProcBals = ?loc_lFalse ORDER BY Emps, Codigos"

            IF USED("cursor_4c_Pesa")
                USE IN cursor_4c_Pesa
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pesa") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_Pesa)"
                RETURN .F.
            ENDIF

            SELECT cursor_4c_Pesa
            SCAN
                loc_cSQL = "SELECT CPros, Qtds FROM SigCdPsi WHERE Emps = " + EscaparSQL(cursor_4c_Pesa.Emps) + ;
                    " AND Codigos = " + FormatarNumeroSQL(cursor_4c_Pesa.Codigos, 0) + " ORDER BY CPros"

                IF USED("cursor_4c_PesaI")
                    USE IN cursor_4c_PesaI
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PesaI") < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_PesaI)"
                    RETURN .F.
                ENDIF

                SELECT cursor_4c_PesaI
                SCAN
                    = SEEK(cursor_4c_PesaI.CPros, "cursor_4c_Pro", "CPros")
                    loc_cSQL = "SELECT GruEstPs, ConEstPs, nAgMts, TipoEstos, Mercs FROM SigCdGrp WHERE Cgrus = " + EscaparSQL(cursor_4c_Pro.Cgrus)
                    IF USED("cursor_4c_Gru")
                        USE IN cursor_4c_Gru
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gru")
                    loc_cSQL = "SELECT Aplicflhs FROM SigCdGpr WHERE Codigos = " + EscaparSQL(cursor_4c_Gru.Mercs)
                    IF USED("cursor_4c_Ggrp")
                        USE IN cursor_4c_Ggrp
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ggrp")

                    IF !SEEK(loc_cGrupoProc + loc_cContaProc + cursor_4c_PesaI.CPros, "cursor_4c_Resumo")
                        INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                            VALUES (loc_cGrupoProc, loc_cContaProc, cursor_4c_PesaI.CPros, cursor_4c_Pro.CUnis, cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, .T.)
                    ENDIF
                    SELECT cursor_4c_Resumo
                    REPLACE Pesagem WITH cursor_4c_Resumo.Pesagem + cursor_4c_PesaI.Qtds IN cursor_4c_Resumo
                ENDSCAN
            ENDSCAN

            SELECT cursor_4c_Resumo
            REPLACE Flag3 WITH .T. FOR Grupo + Conta = loc_cGrupoProc + loc_cContaProc

            SELECT cursor_4c_Opera
            REPLACE PesoBEnts WITH PesoEnts, ;
                    PesoBSais WITH PesoSais, ;
                    QtdeBEnts WITH QtdeEnts, ;
                    QtdeBSais WITH QtdeSais FOR Grupo + Conta = loc_cGrupoProc + loc_cContaProc

            IF cursor_4c_Gcr.UnifBals = 1
                loc_cMat = cursor_4c_Pam.Ouros
                SELECT cursor_4c_Resumo
                IF !SEEK(loc_cGrupoProc + loc_cContaProc + loc_cMat)
                    APPEND BLANK
                    REPLACE cmats   WITH loc_cMat, ;
                            Grupo   WITH loc_cGrupoProc, ;
                            conta   WITH loc_cContaProc, ;
                            Visivel WITH .T.
                ENDIF

                SELECT "" AS Agrupar, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
                    FROM cursor_4c_Resumo ;
                    WHERE Grupo + Conta = loc_cGrupoProc + loc_cContaProc AND Cmats <> loc_cMat AND Varias <> 1 AND Agregas <> 1 ;
                    INTO CURSOR cursor_4c_Total GROUP BY 1
                GO TOP IN cursor_4c_Total

                SELECT cursor_4c_Resumo
                = SEEK(loc_cGrupoProc + loc_cContaProc)
                SCAN WHILE Grupo + Conta = loc_cGrupoProc + loc_cContaProc
                    IF Cmats = loc_cMat
                        REPLACE PesoEnts WITH PesoEnts + cursor_4c_Total.pEnts
                        REPLACE PesoSais WITH PesoSais + cursor_4c_Total.pSais
                        REPLACE QtdeEnts WITH QtdeEnts + cursor_4c_Total.pEnts
                        REPLACE QtdeSais WITH QtdeSais + cursor_4c_Total.pSais
                    ELSE
                        IF Agregas <> 1
                            REPLACE Visivel WITH .F., ;
                                    Flag3   WITH .F.
                        ENDIF
                    ENDIF
                ENDSCAN

                SELECT Grupo, Conta, TpOps, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
                    FROM cursor_4c_Opera ;
                    WHERE Grupo + Conta = loc_cGrupoProc + loc_cContaProc AND Cmats <> loc_cMat AND Varias <> 1 AND Agregas <> 1 ;
                    GROUP BY Grupo, Conta, TpOps ;
                    INTO CURSOR cursor_4c_Total

                SELECT cursor_4c_Total
                SCAN
                    IF !SEEK(cursor_4c_Total.Grupo + cursor_4c_Total.Conta + loc_cMat + cursor_4c_Total.TpOps, "cursor_4c_Opera")
                        INSERT INTO cursor_4c_Opera (Grupo, Conta, CMats, TpOps, AplicFlhs) ;
                            VALUES (cursor_4c_Total.Grupo, cursor_4c_Total.Conta, loc_cMat, cursor_4c_Total.TpOps, 1)
                    ENDIF
                    REPLACE cursor_4c_Opera.PesoEnts WITH cursor_4c_Opera.PesoEnts + cursor_4c_Total.pEnts IN cursor_4c_Opera
                    REPLACE cursor_4c_Opera.PesoSais WITH cursor_4c_Opera.PesoSais + cursor_4c_Total.pSais IN cursor_4c_Opera
                    REPLACE cursor_4c_Opera.QtdeEnts WITH cursor_4c_Opera.QtdeEnts + cursor_4c_Total.pEnts IN cursor_4c_Opera
                    REPLACE cursor_4c_Opera.QtdeSais WITH cursor_4c_Opera.QtdeSais + cursor_4c_Total.pSais IN cursor_4c_Opera
                ENDSCAN

                SELECT Grupo, Conta, TpOps, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
                    FROM cursor_4c_Opera ;
                    WHERE Grupo + Conta = loc_cGrupoProc + loc_cContaProc AND Cmats <> loc_cMat AND Varias <> 1 AND Agregas <> 1 AND AplicFlhs <> 2 ;
                    GROUP BY Grupo, Conta, TpOps ;
                    INTO CURSOR cursor_4c_Total

                SELECT cursor_4c_Total
                SCAN
                    IF SEEK(cursor_4c_Total.Grupo + cursor_4c_Total.Conta + loc_cMat + cursor_4c_Total.TpOps, "cursor_4c_Opera")
                        REPLACE cursor_4c_Opera.PesoBEnts WITH cursor_4c_Opera.PesoBEnts + cursor_4c_Total.pEnts IN cursor_4c_Opera
                        REPLACE cursor_4c_Opera.PesoBSais WITH cursor_4c_Opera.PesoBSais + cursor_4c_Total.pSais IN cursor_4c_Opera
                        REPLACE cursor_4c_Opera.QtdeBEnts WITH cursor_4c_Opera.QtdeBEnts + cursor_4c_Total.pEnts IN cursor_4c_Opera
                        REPLACE cursor_4c_Opera.QtdeBSais WITH cursor_4c_Opera.QtdeBSais + cursor_4c_Total.pSais IN cursor_4c_Opera
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Buscar Saldo Anterior (SigCdFcx/SigOpCfe)
            loc_cSQL = "SELECT Codigos FROM SigCdFcx WHERE Emps = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ;
                " AND Grupos = " + EscaparSQL(loc_cGrupoProc) + " AND Contas = " + EscaparSQL(loc_cContaProc) + " ORDER BY Codigos"

            IF USED("cursor_4c_UltBal")
                USE IN cursor_4c_UltBal
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UltBal") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_UltBal)"
                RETURN .F.
            ENDIF
            SELECT cursor_4c_UltBal
            GO BOTTOM
            IF RECCOUNT() > 0
                loc_cSQL = "SELECT * FROM SigOpCfe WHERE Codigos = " + FormatarNumeroSQL(cursor_4c_UltBal.Codigos, 0) + ;
                    " AND Emps = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + " ORDER BY Codigos, cpros"
            ELSE
                loc_cSQL = "SELECT * FROM SigOpCfe WHERE 0 = 1"
            ENDIF
            IF USED("cursor_4c_SaldoI")
                USE IN cursor_4c_SaldoI
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SaldoI") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_SaldoI)"
                RETURN .F.
            ENDIF

            SELECT cursor_4c_SaldoI
            INDEX ON Cpros TAG Cpros

            SELECT cursor_4c_Resumo
            loc_oBarra = CREATEOBJECT("fwprogressbar", "Preparando Resumos", RECCOUNT("cursor_4c_Resumo"))
            IF VARTYPE(loc_oBarra) = "O"
                loc_oBarra.Top = loc_oBarra.Top + INT(loc_oBarra.Height / 2)
                loc_oBarra.Show()
            ENDIF
            loc_cMatCorrente = SPACE(10)
            SET ORDER TO GrConMat
            = SEEK(loc_cGrupoProc + loc_cContaProc)
            SCAN WHILE Grupo + Conta = loc_cGrupoProc + loc_cContaProc
                IF VARTYPE(loc_oBarra) = "O"
                    loc_oBarra.Update(.T.)
                ENDIF
                STORE 0 TO loc_nSaldoI, loc_nSaidas, loc_nPesagem

                = SEEK(cursor_4c_Resumo.CMats, "cursor_4c_Pro", "CPros")
                IF !loc_lTipoQ AND cursor_4c_Resumo.Cmats <> loc_cMatCorrente
                    STORE 0 TO loc_nFalhaAdmitida
                    loc_cMatCorrente = cursor_4c_Resumo.cmats
                ENDIF

                SELECT cursor_4c_SaldoI
                = SEEK(cursor_4c_Resumo.Cmats)
                loc_nSaldoI = cursor_4c_SaldoI.Pesagems

                SELECT cursor_4c_Opera
                = SEEK(cursor_4c_Resumo.Grupo + cursor_4c_Resumo.Conta + cursor_4c_Resumo.CMats)
                loc_nTrabalhado = 0
                SCAN WHILE Grupo + Conta + Cmats = cursor_4c_Resumo.Grupo + cursor_4c_Resumo.Conta + cursor_4c_Resumo.Cmats
                    = SEEK(cursor_4c_Opera.TpOps, "cursor_4c_OpOpt", "Cods")

                    IF (cursor_4c_OpOpt.PFalhas <> 0 AND cursor_4c_Pro.Varias = 1 AND cursor_4c_OpOpt.TFalhas <> "Q" AND ;
                            cursor_4c_Opera.AplicFlhs <> 2) AND !THIS.this_lNaoChecarFalha
                        loc_nFalhaAdmitida = loc_nFalhaAdmitida + ROUND(cursor_4c_Opera.QtdeBSais * cursor_4c_OpOpt.PFalhas / 100, 3)
                        REPLACE PFalha WITH cursor_4c_OpOpt.PFalhas, ;
                                Falha  WITH ROUND(cursor_4c_Opera.QtdeBSais * cursor_4c_OpOpt.PFalhas / 100, 3) IN cursor_4c_Opera
                    ENDIF

                    IF cursor_4c_OpOpt.Trabas = 1 OR EMPTY(cursor_4c_Opera.TpOps)
                        loc_nTrabalhado = loc_nTrabalhado + cursor_4c_Opera.QtdeSais
                    ENDIF
                ENDSCAN

                SELECT cursor_4c_Resumo
                REPLACE Saldoi  WITH loc_nSaldoI, ;
                        FReal   WITH loc_nSaldoI + cursor_4c_Resumo.QtdeEnts - cursor_4c_Resumo.QtdeSais - cursor_4c_Resumo.Pesagem, ;
                        FAdmin  WITH loc_nFalhaAdmitida, ;
                        Saldof  WITH loc_nSaldoI + cursor_4c_Resumo.QtdeEnts - cursor_4c_Resumo.QtdeSais - cursor_4c_Resumo.Pesagem - loc_nFalhaAdmitida, ;
                        PfTrabs WITH IIF(loc_nTrabalhado <> 0, (Saldof / loc_nTrabalhado * 100), 0)

                IF cursor_4c_Resumo.Saldof <> 0 AND (cursor_4c_CliDet.PagFals = 1 OR cursor_4c_CliDet.RecFals = 1)
                    REPLACE Flag  WITH .T., ;
                            Flag2 WITH (cursor_4c_CliDet.PagFals = 1 OR cursor_4c_CliDet.RecFals = 1) IN cursor_4c_Resumo
                ENDIF
            ENDSCAN
            IF VARTYPE(loc_oBarra) = "O"
                loc_oBarra.Complete()
            ENDIF

            SELECT cursor_4c_SaldoI
            loc_oBarra = CREATEOBJECT("fwprogressbar", "Preparando Resumos", RECCOUNT("cursor_4c_SaldoI"))
            IF VARTYPE(loc_oBarra) = "O"
                loc_oBarra.Top = loc_oBarra.Top + INT(loc_oBarra.Height / 2)
                loc_oBarra.Show()
            ENDIF
            loc_cMatCorrente = SPACE(10)
            SCAN
                IF VARTYPE(loc_oBarra) = "O"
                    loc_oBarra.Update(.T.)
                ENDIF
                IF cursor_4c_SaldoI.Pesagems = 0
                    LOOP
                ENDIF
                = SEEK(cursor_4c_SaldoI.Cpros, "cursor_4c_Pro", "CPros")
                loc_cSQL = "SELECT GruEstPs, ConEstPs, nAgMts, TipoEstos, Mercs FROM SigCdGrp WHERE Cgrus = " + EscaparSQL(cursor_4c_Pro.Cgrus)
                IF USED("cursor_4c_Gru")
                    USE IN cursor_4c_Gru
                ENDIF
                = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gru")

                loc_nSaldoI = cursor_4c_SaldoI.Pesagems

                SELECT cursor_4c_Resumo
                LOCATE FOR Grupo + Conta + cMats = loc_cGrupoProc + loc_cContaProc + cursor_4c_SaldoI.Cpros
                IF EOF()
                    *-- Transcricao LITERAL do legado (regra #17): a linha
                    *-- original usa LocalNens.GrupoOs/ContaOs aqui, nao
                    *-- _Grupo/_Conta - aparenta ser um residuo do cursor da
                    *-- SCAN de producao (bug latente do legado), mas a
                    *-- regra exige nao "corrigir" sem confirmacao.
                    INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                        VALUES (cursor_4c_Nens.GrupoOs, cursor_4c_Nens.ContaOs, cursor_4c_SaldoI.Cpros, ;
                                cursor_4c_Pro.CUnis, cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, .T.)

                    SELECT cursor_4c_Resumo
                    REPLACE Saldoi  WITH loc_nSaldoI, ;
                            FReal   WITH loc_nSaldoI + cursor_4c_Resumo.QtdeEnts - cursor_4c_Resumo.QtdeSais - cursor_4c_Resumo.Pesagem, ;
                            FAdmin  WITH 0, ;
                            Saldof  WITH loc_nSaldoI + cursor_4c_Resumo.QtdeEnts - cursor_4c_Resumo.QtdeSais - cursor_4c_Resumo.Pesagem - 0, ;
                            PfTrabs WITH 0
                ENDIF
            ENDSCAN
            IF VARTYPE(loc_oBarra) = "O"
                loc_oBarra.Complete()
            ENDIF
        ENDSCAN
        IF VARTYPE(loc_oBarraP) = "O"
            loc_oBarraP.Complete()
        ENDIF

        *-- Agregacao final: soma Saldof de cursor_4c_Resumo em cursor_4c_Saldo,
        *-- por Fase+Codigo+Material (legado: Select TmpSaldo / Scan / Seek
        *-- TmpSaldo.Fase + TmpSaldo.Codigo + lcCodMat em TmpResumo).
        SELECT cursor_4c_Saldo
        SCAN
            SELECT cursor_4c_Resumo
            = SEEK(cursor_4c_Saldo.Fase + cursor_4c_Saldo.Codigo + loc_cCodMat)
            SCAN WHILE Grupo + Conta + cMats = (cursor_4c_Saldo.Fase + cursor_4c_Saldo.Codigo + loc_cCodMat)
                REPLACE Saldo WITH Saldo + cursor_4c_Resumo.Saldof IN cursor_4c_Saldo
            ENDSCAN
        ENDSCAN

        SELECT cursor_4c_Saldo
        IF THIS.this_lNaoMostrarSaldosZerados
            DELETE FOR Saldo = 0
        ENDIF
        SET ORDER TO TAG Codigo
        GO TOP
        IF EOF()
            THIS.this_nQtdeRegistros = 0
            THIS.this_cMensagemErro = "Nenhum Saldo Selecionado!!!"
            RETURN .F.
        ENDIF

        *-- Quantidade apurada (this_nQtdeRegistros): o legado nao precisa dela
        *-- porque le TmpSaldo direto da tela; aqui ela eh o unico retorno
        *-- quantitativo do processamento para o Form (BOParaForm). COUNT sobre
        *-- o alias ja SELECIONADO (nao existe clausula IN em COUNT) e GO TOP
        *-- de volta depois, para a grade abrir na primeira linha como no legado.
        COUNT TO loc_nQtdeSaldo
        GO TOP
        THIS.this_nQtdeRegistros = loc_nQtdeSaldo

        RETURN .T.
    ENDPROC

    *==========================================================================
    * LimparDados - Hook de BusinessBase ("Subclasses devem limpar suas
    * propriedades especificas"): devolve os filtros e o estado do resultado
    * aos valores iniciais. Chamado por FormSIGOPCFE.LimparCampos(), que em
    * seguida espelha o BO de volta na tela com BOParaForm().
    *
    * Mantido PUBLIC (como em BusinessBase - regra #51): o Form chama este
    * metodo de FORA da classe.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cMaterial     = ""
        THIS.this_cDescMaterial = ""
        THIS.this_cGrupo        = ""
        THIS.this_cDescGrupo    = ""
        THIS.this_cConta        = ""
        THIS.this_cDescConta    = ""

        THIS.this_lNaoMostrarSaldosZerados = .F.
        THIS.this_lNaoChecarFalha          = .F.

        THIS.this_nQtdeRegistros = 0

        THIS.this_cCodigoSaldo   = ""
        THIS.this_cNomeSaldo     = ""
        THIS.this_cFaseSaldo     = ""
        THIS.this_nSaldoValor    = 0
        THIS.this_dUltimoBalanco = {}
    ENDPROC

    *==========================================================================
    * ObterDescricaoEmpresa - CursorQuery('SigCdEmp','crSigCdEmp','Cemps',
    * _Empr,'Razas') do metodo Impress" + CHR(227) + "o legado.
    *==========================================================================
    PROCEDURE ObterDescricaoEmpresa()
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao, loc_oErro

        loc_cDescricao = ""

        TRY
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                EscaparSQL(PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3))

            IF USED(THIS.this_cCursorEmpresa)
                USE IN (THIS.this_cCursorEmpresa)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorEmpresa)

            IF loc_nResultado >= 1 AND RECCOUNT(THIS.this_cCursorEmpresa) > 0
                loc_cDescricao = ALLTRIM(TratarNulo(EVALUATE(THIS.this_cCursorEmpresa + ".Razas"), ""))
            ENDIF
        CATCH TO loc_oErro
            loc_cDescricao = ""
        ENDTRY

        IF USED(THIS.this_cCursorEmpresa)
            USE IN (THIS.this_cCursorEmpresa)
        ENDIF

        RETURN loc_cDescricao
    ENDPROC

    *==========================================================================
    * MontarCursorCabecalho - transcricao do bloco de cabecalho do metodo
    * "Impress" + CHR(227) + "o" do legado:
    *   Create Cursor TmpCabec (Titulo c(100), SubTitulo c(100), Empresa c(100))
    *   lcTitulo = 'Saldos Por Funcion' + CHR(225) + "rio"
    *   lcSubTitulo = 'Material : ' + ... + ' - ' + ...
    *   Insert Into TmpCabec (Empresa, Titulo, SubTitulo) Values (...)
    *==========================================================================
    PROCEDURE MontarCursorCabecalho()
        LOCAL loc_lSucesso, loc_cTitulo, loc_cSubTitulo, loc_cEmpresa, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorCabecalho) ;
                (Titulo C(100), SubTitulo C(100), Empresa C(100))

            loc_cTitulo = "Saldos Por Funcion" + CHR(225) + "rio"

            loc_cSubTitulo = "Material : " + ALLTRIM(TratarNulo(THIS.this_cMaterial, "")) + " - " + ;
                ALLTRIM(TratarNulo(THIS.this_cDescMaterial, ""))

            loc_cEmpresa = THIS.ObterDescricaoEmpresa()

            INSERT INTO (THIS.this_cCursorCabecalho) (Empresa, Titulo, SubTitulo) ;
                VALUES (LEFT(loc_cEmpresa, 100), LEFT(loc_cTitulo, 100), LEFT(loc_cSubTitulo, 100))

            GO TOP IN (THIS.this_cCursorCabecalho)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarReportForm - dispara o REPORT FORM com o isolamento de locale/
    * REPORTBEHAVIOR e a restauracao de menu do padrao canonico do projeto
    * (ver SigOpCfaBO/SigReCgcBO.ExecutarReportForm). par_cModo: "PREVIEW"
    * (legado lcSaida='V') ou "PRINTER_PROMPT" (legado lcSaida='I').
    *==========================================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX, "Erro")
            RETURN .F.
        ENDIF

        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        *-- Restaurar menu apos preview (Erro63): REPORT FORM PREVIEW abre
        *-- toolbar propria que corrompe o cache visual do _MSYSMENU.
        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ExibirRelatorio - equivalente ao bloco final do metodo "Impress" +
    * CHR(227) + "o" do legado: monta TmpCabec, confere "Set Order to
    * Impressao / Go Top / If Eof()" em cursor_4c_Saldo e dispara o
    * SigOpCfe.frx (Preview ou To Printer Prompt conforme par_cSaida).
    *==========================================================================
    PROCEDURE ExibirRelatorio(par_cSaida)
        LOCAL loc_lSucesso, loc_cModo, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF !THIS.MontarCursorCabecalho()
                loc_lSucesso = .F.
            ELSE
                IF !USED("cursor_4c_Saldo")
                    THIS.this_cMensagemErro = "Nenhuma Informa" + CHR(231) + CHR(227) + "o Selecionada!!!"
                ELSE
                    SELECT cursor_4c_Saldo
                    SET ORDER TO TAG Impressao
                    GO TOP

                    IF EOF()
                        THIS.this_cMensagemErro = "Nenhuma Informa" + CHR(231) + CHR(227) + "o Selecionada!!!"
                    ELSE
                        loc_cModo    = IIF(par_cSaida == "V", "PREVIEW", "PRINTER_PROMPT")
                        loc_lSucesso = THIS.ExecutarReportForm("SigOpCfe", loc_cModo)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

