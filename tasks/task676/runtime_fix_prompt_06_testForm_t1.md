# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: Teste de formulario falhou com exit code 1. ERRO CAPTURADO: [19/10/2026 08:07:02] Erro em InicializarForm: Alias 'TMPNENS' is not found.Linha: 596Procedure: configurarpaginadados


## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[19/10/2026 08:07:02] Erro em InicializarForm: Alias 'TMPNENS' is not found.Linha: 596Procedure: configurarpaginadados


### LOG DA ETAPA (06_testForm):
[2026-10-19 08:03:19] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-19 08:03:19] [INFO] Config FPW: (nao fornecido)
[2026-10-19 08:03:20] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-19 08:03:21] [INFO] Timeout: 300 segundos
[2026-10-19 08:03:21] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0mww3dru.prg
[2026-10-19 08:03:22] [INFO] Conteudo do wrapper:
[2026-10-19 08:03:22] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrSer', 'C:\4c\tasks\task676\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrSer', 'C:\4c\tasks\task676\logs\06_testForm.log'
QUIT

[2026-10-19 08:03:23] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0mww3dru.prg
[2026-10-19 08:03:23] [INFO] VFP output esperado em: C:\4c\tasks\task676\vfp_output.txt
[2026-10-19 08:03:23] [INFO] Executando Visual FoxPro 9...
[2026-10-19 08:03:24] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0mww3dru.prg
[2026-10-19 08:03:25] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0mww3dru.prg
[2026-10-19 08:03:25] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrSer
Inicio: 19/10/2026 08:03:25

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
ERRO - CREATEOBJECT retornou NULL ou tipo invalido

=== RESULTADO DO TESTE ===
Fim: 19/10/2026 08:07:02
Duracao: 217 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-19 08:07:03] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-19 08:07:04] [INFO] VFP9 finalizado em 220.2060377 segundos
[2026-10-19 08:07:04] [INFO] Exit Code: 
[2026-10-19 08:07:05] [INFO] 
[2026-10-19 08:07:05] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-19 08:07:06] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0mww3dru.prg
[2026-10-19 08:07:08] [INFO] 
[2026-10-19 08:07:08] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-19 08:07:09] [INFO] * Auto-generated wrapper for parameters
[2026-10-19 08:07:09] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-19 08:07:10] [INFO] * Parameters: 'FormSigPrSer', 'C:\4c\tasks\task676\logs\06_testForm.log'
[2026-10-19 08:07:10] [INFO] 
[2026-10-19 08:07:11] [INFO] * Anti-dialog protections for unattended execution
[2026-10-19 08:07:11] [INFO] SET SAFETY OFF
[2026-10-19 08:07:12] [INFO] SET RESOURCE OFF
[2026-10-19 08:07:12] [INFO] SET TALK OFF
[2026-10-19 08:07:12] [INFO] SET NOTIFY OFF
[2026-10-19 08:07:13] [INFO] SYS(2335, 0)
[2026-10-19 08:07:13] [INFO] 
[2026-10-19 08:07:13] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrSer', 'C:\4c\tasks\task676\logs\06_testForm.log'
[2026-10-19 08:07:14] [INFO] QUIT
[2026-10-19 08:07:14] [INFO] 
[2026-10-19 08:07:14] [INFO] === Fim do Wrapper.prg ===
[2026-10-19 08:07:15] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSer.prg):
*==============================================================================
* FormSigPrSer.prg - Servicos Lancados (dialogo filho de conferencia)
* Form OPERACIONAL, aberto por um formulario pai durante a emissao de uma
* nota/movimentacao, que exibe os servicos ja lancados para o conjunto de
* operacoes de producao (Nops) em processamento - origem/destino de conta,
* quantidade, fator e valor - e totaliza quantidade/valor para conferencia.
*
* Original: SigPrSer.SCX (form generico, layout FLAT - sem PageFrame
* Page1=Lista/Page2=Dados; container de cabecalho da movimentacao + grade +
* campos de descricao/origem/destino + totalizadores + botao OK)
*
* DataSession = 1 (sessao CORRENTE), DIVERGINDO de proposito do legado
* (DataSession = 2, sessao privada): este dialogo so LE cursores que o
* formulario PAI ja deixa preparados (equivalentes a xMfas/tmpnens/xnensi)
* na sessao privada DELE. Com DataSession = 1 este form roda automaticamente
* na sessao que estiver CORRENTE no momento do CREATEOBJECT (normalmente a
* sessao privada do pai, ja que e o pai quem chama) - sem o reset de
* SET DATE/CENTURY que DataSession = 2 provocaria (CLAUDE.md regra #9.4) e
* sem a troca automatica de sessao a cada evento que uma sessao PRIVADA
* sofreria (que desfaria o SET DATASESSION TO manual feito no Init, como o
* legado faz com "Set DataSession To pForm.DataSessionId"). Mesmo padrao
* adotado em FormSigPrTar.prg para o mesmo cenario (dialogo filho lendo
* cursores do pai).
*
* Herda de: FormBase
* Fase 3/8: estrutura base (DEFINE CLASS, Init, InicializarForm,
* ConfigurarPageFrame - so o cabecalho - e Destroy).
* Fase 4/8: grade de servicos lancados (grd_4c_Dados, equivalente a Grade/
* TmpDistrib) com as 9 colunas do dump, carga via SigPrSerBO.
* CarregarDistribuicao()/Acumular() e AlternarPagina(). Este form NAO tem
* PageFrame nem toolbar CRUD (layout FLAT do SIGPRSER legado - dialogo de
* conferencia, sem Incluir/Alterar/Excluir/Buscar: a unica acao do legado
* eh o botao OK, que fecha o dialogo - ver SigPrSerBO.prg).
* Fase 5/8: 1a metade dos campos restantes - ConfigurarPaginaDados() com
* Shape1 (decorativo), container cnt_4c_Operacao (cabecalho somente-leitura
* da movimentacao: txt_4c_Codigo/Empresa/Operacao ligados por ControlSource
* direto a tmpnens.numps/emps/dopps, cursor que o formulario PAI ja deixa na
* DataSession compartilhada - mesmo padrao de FormSigPrTar.prg) e o botao
* cmd_4c_Ok (BtnOkClick = THIS.Release(), fecha o dialogo via Destroy()).
* Fase 6/8: 2a metade dos campos - labels lbl_4c_Origem/lbl_4c_Destino/
* lbl_4c_Descricao (Say1/Say4/Say2 do dump, fora do container Operacao) e
* os TextBox somente-leitura txt_4c_Descr/DescOrig/DescDest (Get_descr/
* getDescOrig/getDescDest - ControlSource = TmpDistrib.Dpros/DescOrig/
* DescDest no legado) e txt_4c_QtdTot/txt_4c_Valtot (totalizadores). Nenhum
* desses campos tem lookup (comportamento.json: lookups=[]; todos os When
* do dump so fazem "Return .f.", ou seja, somente-leitura/auto-preenchidos -
* nao ha F4/F5/KeyPress/DblClick a implementar aqui). txt_4c_Descr/DescOrig/
* DescDest espelham a linha CORRENTE da grade (cursor_4c_Distrib, alias
* dinamico) - por isso o ControlSource delas eh atribuido em CarregarLista()
* (regra "ControlSource antes do cursor existir"), nao aqui, e recarregado
* em GradeAfterRowColChange(). txt_4c_QtdTot/txt_4c_Valtot sao preenchidos
* por AtualizarTotais() (ja existente desde a Fase 5, chamada por
* CarregarLista() apos Acumular()).
* Fase 7: SEM trabalho novo - conferido metodo a metodo contra
* comportamento.json (totalMetodos=13). SIGPRSER eh dialogo de CONFERENCIA
* (FLAT, sem frmcadastro/Grupo_Op/pcEscolha no dump), e o UNICO botao real do
* legado eh "ok" (Click), ja portado como BtnOkClick desde a Fase 5. Os 12
* metodos restantes sao Init/Procedure(acumula)/Procedure(fConfigGeral) +
* 9 "When" que so fazem "Return .t./.f." (campos somente-leitura e as duas
* celulas de grade testadas no dump) - todos ja cobertos nas fases
* anteriores (ver Fases 3-6 acima) ou documentados como NAO portados
* (fConfigGeral: ver utils\fconfiggeral.prg - wrapper de compatibilidade so
* para o p-code dos VCX legado, nunca chamado em codigo nosso; mesmo
* precedente de Formsigprsen.prg). Criar BtnIncluirClick/BtnAlterarClick/
* BtnVisualizarClick/BtnExcluirClick aqui violaria o PILAR 1 (o legado nao
* tem esses botoes) e a regra de completude (seriam stubs sem logica real -
* ver CLAUDE.md "REGRA CRITICA: NUNCA Criar Stubs com MsgAviso").
* Fase 8/8 (esta fase, consolidacao final): auditoria de completude confirma
* que os 13/13 metodos do comportamento.json estao cobertos (ver Fase 7) e
* que o unico botao real do legado (ok.Click) ja esta implementado desde a
* Fase 5. O roteiro generico desta fase (BtnBuscarClick/BtnEncerrarClick/
* BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/
* LimparCampos/AjustarBotoesPorModo) eh do padrao frmcadastro (Page1=Lista/
* Page2=Dados com toolbar CRUD) e NAO se aplica a este form: SIGPRSER eh
* FLAT (sem PageFrame/paginas), nao tem toolbar de Incluir/Alterar/Excluir/
* Buscar/Encerrar nem par Salvar/Cancelar no dump, e nao representa uma
* entidade gravavel (SigPrSerBO nao sobrescreve Inserir/Atualizar/
* ExecutarExclusao - ver comentario no rodape do BO). Gerar esses metodos
* aqui seria inventar funcionalidade inexistente no legado (viola o PILAR 1)
* e produzir stubs sem logica real (viola a "REGRA CRITICA: NUNCA Criar
* Stubs com MsgAviso" acima). Integracao (menu.prg/config.prg): NAO
* aplicavel - este form eh um dialogo FILHO (CREATEOBJECT("FormSigPrSer",
* par_oFormPai), com o form pai como parametro obrigatorio do Init),
* instanciado por um formulario de emissao de nota/movimentacao ainda nao
* migrado, igual ao precedente de FormSigPrTar.prg (tambem sem entrada em
* menu.prg e sem SET PROCEDURE manual - config.prg carrega BO/Form via
* ADIR() automaticamente). Quando o formulario pai for migrado, ele passara
* a chamar CREATEOBJECT("FormSigPrSer", THIS) diretamente - nenhuma alteracao
* em menu.prg ou config.prg eh necessaria para isso.
*==============================================================================
DEFINE CLASS FormSigPrSer AS FormBase

    *-- Contexto recebido do formulario pai (equivalente as properties
    *-- customizadas ParentForm/pcEscolha do SIGPRSER.SCX legado - RESERVED3)
    this_oParentForm = .NULL.  && Referencia ao form pai (ParentForm)
    this_cPcEscolha  = ""      && Contexto repassado pelo pai (pcEscolha) - preservado para paridade; nenhum metodo do dump legado o le ainda

    *-- Propriedades visuais (replicadas do SIGPRSER.SCX - dialogo sem barra
    *-- de titulo, sem redimensionamento, sem botoes de sistema)
    DataSession  = 1
    ShowWindow   = 1
    WindowType   = 1
    Height       = 600
    Width        = 1000
    AutoCenter   = .T.
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    BorderStyle  = 2

    *--------------------------------------------------------------------------
    * Init - Recebe o contexto do formulario pai (equivalente ao
    * "LParameters pForm" do PROCEDURE Init do legado)
    *
    * par_oParentForm : referencia ao form pai (equivalente a ThisForm.ParentForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_oParentForm) = "O" AND !ISNULL(par_oParentForm)
                THIS.this_oParentForm = par_oParentForm

                IF PEMSTATUS(par_oParentForm, "pcEscolha", 5)
                    THIS.this_cPcEscolha = par_oParentForm.pcEscolha
                ENDIF

                THIS.this_oParentForm.Enabled = .F.
            ENDIF

            *-- DODEFAULT chama FormBase.Init (fix datas + InicializarForm)
            loc_lSucesso = DODEFAULT()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao abrir Servi" + CHR(231) + "os Lan" + CHR(231) + "ados")
            IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria a interface do usuario (chamado por FormBase.Init)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Compartilha a datasession do form pai (xMfas/tmpnens/xnensi -
            *-- cursores equivalentes aos usados no Init legado - vivem la).
            *-- Equivalente a "Set DataSession To pForm.DataSessionId" do
            *-- legado (ver comentario na declaracao da classe sobre
            *-- DataSession = 1).
            IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm) ;
                    AND PEMSTATUS(THIS.this_oParentForm, "DataSessionId", 5)
                SET DATASESSION TO (THIS.this_oParentForm.DataSessionId)
            ENDIF

            THIS.Caption = "Servi" + CHR(231) + "os Lan" + CHR(231) + "ados"

            IF TYPE("gc_4c_CaminhoIcones") = "C" AND FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            THIS.this_oBusinessObject = CREATEOBJECT("SigPrSerBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.LockScreen = .T.

                *-- Cria os containers base (Fase 3: cabecalho / Fase 4: grade /
                *-- Fase 5: 1a metade dos campos - Shape1, container da
                *-- movimentacao e botao OK)
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Carga da grade de servicos lancados (bloco final do Init
                *-- legado, dump 945-964). Em modo de teste/validacao de UI
                *-- o cursor_4c_Operacoes (equivalente a xMfas) ainda nao foi
                *-- preparado por nenhum form pai - pular evita SQLEXEC sem
                *-- gnConnHandle valido num contexto sem usuario.
                IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                     (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
                    THIS.CarregarLista()
                ENDIF

                THIS.LockScreen = .F.

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigPrSerBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro")
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
    * ConfigurarPageFrame - Cria os containers base do form operacional
    * Form OPERACIONAL sem PageFrame (SIGPRSER legado eh single-page, layout
    * FLAT). Mantem o nome do metodo por convencao do pipeline; aqui cria
    * somente o cabecalho (cntSombra do legado: Top=0, Left=0, W=1100, H=80,
    * BackColor=100,100,100). Grade (Grade), container da movimentacao
    * (Operacao), botao OK, campos de descricao/origem/destino e
    * totalizadores (getQtdTot/getValtot) entram nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = ""
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = THIS.Width
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = ""
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = THIS.Width
                .ForeColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria a grade de servicos lancados (grd_4c_Dados,
    * equivalente a Grade/TmpDistrib do legado - dump 463-553). Form OPERACIONAL
    * FLAT (sem PageFrame, regra #46 do CLAUDE.md para forms sem Page1/Page2):
    * a grade eh a vista principal do dialogo, criada direto sobre THIS, igual
    * ao cabecalho (Fase 3). So a estrutura/formatacao ESTATICA das colunas
    * entra aqui - RecordSource e Column.ControlSource (que dependem do cursor
    * populado) entram em CarregarLista().
    *
    * ColumnOrder reproduz a ordem VISUAL do dump (1,2,7,8,9,3,4,5,6), que
    * difere da ordem de criacao das Columns - Column7/8/9 (Conta/Grupo/Conta
    * do destino) aparecem visualmente ANTES de Column3/4/5 (Servico/Qtde/
    * Valor), exatamente como no SCX legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top              = 197
            .Left             = 12
            .Width            = 976
            .Height           = 325
            .FontName         = "Courier New"
            .FontSize         = 8
            .RowHeight        = 17
            .ScrollBars       = 2
            .RecordSourceType = 1
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .ReadOnly         = .F.
            .ColumnCount      = 9
            .Visible          = .T.

            *-- Column1 - Operacao (Empdnps) - ColumnOrder 1
            .Column1.ColumnOrder = 1
            .Column1.Width       = 241
            .Column1.Movable     = .F.
            .Column1.Resizable   = .F.
            .Column1.ReadOnly    = .T.
            .Column1.FontName    = "Courier New"
            .Column1.FontSize    = 8
            WITH .Column1.Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
            ENDWITH
            WITH .Column1.Text1
                .FontName    = "Courier New"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column2 - Grupo de origem (Grupoos) - ColumnOrder 2
            .Column2.ColumnOrder = 2
            .Column2.Width       = 80
            .Column2.Movable     = .F.
            .Column2.Resizable   = .F.
            .Column2.ReadOnly    = .T.
            .Column2.FontName    = "Courier New"
            .Column2.FontSize    = 8
            WITH .Column2.Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Grupo"
            ENDWITH
            WITH .Column2.Text1
                .FontName    = "Courier New"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column7 - Conta de origem (Contaos) - ColumnOrder 3
            .Column7.ColumnOrder = 3
            .Column7.Width       = 80
            .Column7.Movable     = .F.
            .Column7.Resizable   = .F.
            .Column7.ReadOnly    = .T.
            .Column7.FontName    = "Courier New"
            .Column7.FontSize    = 8
            WITH .Column7.Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Conta"
            ENDWITH
            WITH .Column7.Text1
                .FontName    = "Courier New"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column8 - Grupo de destino (Grupods) - ColumnOrder 4
            .Column8.ColumnOrder = 4
            .Column8.Width       = 80
            .Column8.Movable     = .F.
            .Column8.Resizable   = .F.
            .Column8.ReadOnly    = .T.
            .Column8.FontName    = "Courier New"
            .Column8.FontSize    = 8
            WITH .Column8.Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Grupo"
            ENDWITH
            WITH .Column8.Text1
                .FontName    = "Courier New"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column9 - Conta de destino (Contads) - ColumnOrder 5
            .Column9.ColumnOrder = 5
            .Column9.Width       = 80
            .Column9.Movable     = .F.
            .Column9.Resizable   = .F.
            .Column9.ReadOnly    = .T.
            .Column9.FontName    = "Courier New"
            .Column9.FontSize    = 8
            WITH .Column9.Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Conta"
            ENDWITH
            WITH .Column9.Text1
                .FontName    = "Courier New"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column3 - Servico (Cmats) - ColumnOrder 6
            .Column3.ColumnOrder = 6
            .Column3.Width       = 108
            .Column3.Movable     = .F.
            .Column3.Resizable   = .F.
            .Column3.ReadOnly    = .T.
            .Column3.FontName    = "Courier New"
            .Column3.FontSize    = 8
            WITH .Column3.Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Servi" + CHR(231) + "o"
            ENDWITH
            WITH .Column3.Text1
                .FontName    = "Courier New"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column4 - Quantidade (Qtds) - ColumnOrder 7
            .Column4.ColumnOrder = 7
            .Column4.Width       = 80
            .Column4.Movable     = .F.
            .Column4.Resizable   = .F.
            .Column4.ReadOnly    = .T.
            .Column4.FontName    = "Courier New"
            .Column4.FontSize    = 8
            WITH .Column4.Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Qtde"
            ENDWITH
            WITH .Column4.Text1
                .FontName    = "Courier New"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column5 - Fator/Valor (Fators) - ColumnOrder 8
            .Column5.ColumnOrder = 8
            .Column5.Width       = 80
            .Column5.Movable     = .F.
            .Column5.Resizable   = .F.
            .Column5.ReadOnly    = .T.
            .Column5.FontName    = "Courier New"
            .Column5.FontSize    = 8
            WITH .Column5.Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Valor"
            ENDWITH
            WITH .Column5.Text1
                .FontName    = "Courier New"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column6 - Total (Qtds * Fators, calculado) - ColumnOrder 9
            .Column6.ColumnOrder = 9
            .Column6.Width       = 108
            .Column6.Movable     = .F.
            .Column6.Resizable   = .F.
            .Column6.ReadOnly    = .T.
            .Column6.FontName    = "Courier New"
            .Column6.FontSize    = 8
            WITH .Column6.Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .Caption   = "Total"
            ENDWITH
            WITH .Column6.Text1
                .FontName    = "Courier New"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Controles diretos do form FLAT (SIGPRSER nao
    * tem Page1/Page2 - ver cabecalho do arquivo):
    *   Bloco de TOPO (Fase 5, acima da grade, Top < 197):
    *     - Shape1 (dump 313-322, decorativo, canto superior direito)
    *     - Container "Operacao" (dump 326-337) com os campos somente-leitura
    *       do cabecalho da movimentacao em conferencia (tmpnens.numps/emps/
    *       dopps - cursor que o formulario PAI ja deixa na DataSession
    *       compartilhada, igual ao padrao de FormSigPrTar.prg)
    *     - Botao OK (dump 413-421), unica acao viva do dialogo
    *   Bloco de BAIXO (Fase 6, abaixo da grade, Top > 522):
    *     - lbl_4c_Origem/lbl_4c_Destino (Say1/Say4, dump 764-795) - cabecalho
    *       das colunas de descricao de origem/destino
    *     - lbl_4c_Descricao (Say2, dump 424-434)
    *     - txt_4c_DescOrig/txt_4c_DescDest/txt_4c_Descr (getDescOrig/
    *       getDescDest/Get_descr) - somente-leitura, ControlSource atribuido
    *       dinamicamente em CarregarLista() porque dependem do alias real de
    *       cursor_4c_Distrib (so existe apos CarregarDistribuicao() rodar)
    *     - txt_4c_QtdTot/txt_4c_Valtot (getQtdTot/getValtot, dump 798-833) -
    *       totalizadores, preenchidos por AtualizarTotais()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 898
            .Height      = 110
            .Width       = 90
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cnt_4c_Operacao", "Container")
        WITH THIS.cnt_4c_Operacao
            .Top           = 104
            .Left          = 12
            .Width         = 490
            .Height        = 56
            .BackStyle     = 1
            .BackColor     = RGB(255, 255, 255)
            .BorderWidth   = 1
            .SpecialEffect = 0
            .TabIndex      = 6
            .Visible       = .T.

            .AddObject("lbl_4c_Movimentacao", "Label")
            WITH .lbl_4c_Movimentacao
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Left      = 4
                .Top       = 3
                .Width     = 100
                .Height    = 14
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Codigo", "TextBox")
            WITH .txt_4c_Codigo
                .ControlSource = "tmpnens.numps"
                .Format        = "L"
                .InputMask     = "9999999999"
                .Left          = 201
                .Top           = 26
                .Width         = 81
                .Height        = 23
                .ReadOnly      = .T.
                .ForeColor     = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible       = .T.
            ENDWITH

            .AddObject("txt_4c_Empresa", "TextBox")
            WITH .txt_4c_Empresa
                .ControlSource = "tmpnens.emps"
                .Left          = 5
                .Top           = 26
                .Width         = 36
                .Height        = 23
                .ReadOnly      = .T.
                .ForeColor     = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible       = .T.
            ENDWITH

            .AddObject("txt_4c_Operacao", "TextBox")
            WITH .txt_4c_Operacao
                .ControlSource = "tmpnens.dopps"
                .Left          = 43
                .Top           = 26
                .Width         = 156
                .Height        = 23
                .ReadOnly      = .T.
                .ForeColor     = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible       = .T.
            ENDWITH

            .AddObject("lin_4c_Line1", "Line")
            WITH .lin_4c_Line1
                .BorderWidth = 2
                .Height      = 0
                .Left        = 4
                .Top         = 19
                .Width       = 316
                .BorderColor = RGB(90, 90, 90)
                .Visible     = .T.
            ENDWITH
        ENDWITH

        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 925
            .Width           = 75
            .Height          = 75
            .Caption         = "OK"
            .Cancel          = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Themes          = .T.
            .Visible         = .T.

            IF TYPE("gc_4c_CaminhoIcones") = "C" AND FILE(gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg")
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            ENDIF
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")

        *-- lbl_4c_Origem (Say1, dump 764-778) - cabecalho da coluna de
        *-- descricao de origem (centrado, em caixa com borda, igual ao
        *-- legado - este Say DECLARA Width/Alignment, nao eh a classe "say"
        *-- pura da regra #23)
        THIS.AddObject("lbl_4c_Origem", "Label")
        WITH THIS.lbl_4c_Origem
            .Top         = 182
            .Left        = 264
            .Width       = 163
            .Height      = 15
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .Alignment   = 2
            .AutoSize    = .F.
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Caption     = "Origem"
            .Visible     = .T.
        ENDWITH

        *-- lbl_4c_Destino (Say4, dump 781-795)
        THIS.AddObject("lbl_4c_Destino", "Label")
        WITH THIS.lbl_4c_Destino
            .Top         = 182
            .Left        = 426
            .Width       = 163
            .Height      = 15
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .Alignment   = 2
            .AutoSize    = .F.
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Caption     = "Destino"
            .Visible     = .T.
        ENDWITH

        *-- txt_4c_DescOrig (getDescOrig, dump 450-459) - ControlSource
        *-- atribuido em CarregarLista() (cursor_4c_Distrib ainda nao existe
        *-- aqui - regra "ControlSource antes do cursor existir")
        THIS.AddObject("txt_4c_DescOrig", "TextBox")
        WITH THIS.txt_4c_DescOrig
            .Top               = 541
            .Left              = 217
            .Width             = 150
            .Height            = 22
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .Visible           = .T.
        ENDWITH

        *-- txt_4c_DescDest (getDescDest, dump 836-845)
        THIS.AddObject("txt_4c_DescDest", "TextBox")
        WITH THIS.txt_4c_DescDest
            .Top               = 541
            .Left              = 379
            .Width             = 150
            .Height            = 22
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .Visible           = .T.
        ENDWITH

        *-- lbl_4c_Descricao (Say2, dump 424-434) - classe "say" pura (sem
        *-- Width/Alignment no dump) - regra #23: Alignment = 0 + Width
        *-- explicita que caiba o texto, ForeColor copiado do dump (90,90,90)
        THIS.AddObject("lbl_4c_Descricao", "Label")
        WITH THIS.lbl_4c_Descricao
            .Top       = 525
            .Left      = 591
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Descr (Get_descr, dump 437-446) - ControlSource atribuido
        *-- em CarregarLista(), mesmo motivo de txt_4c_DescOrig/DescDest
        THIS.AddObject("txt_4c_Descr", "TextBox")
        WITH THIS.txt_4c_Descr
            .Top               = 540
            .Left              = 541
            .Width             = 241
            .Height            = 23
            .ReadOnly          = .T.
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .Visible           = .T.
        ENDWITH

        *-- txt_4c_QtdTot (getQtdTot, dump 798-813) - totalizador de
        *-- quantidade, preenchido por AtualizarTotais(); When = "Return .f."
        *-- no legado -> somente-leitura (igual GetCodigo/Get_descr)
        THIS.AddObject("txt_4c_QtdTot", "TextBox")
        WITH THIS.txt_4c_QtdTot
            .Top         = 521
            .Left        = 696
            .Width       = 83
            .Height      = 18
            .Value       = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .InputMask   = "999,999.99"
            .MaxLength   = 12
            .Margin      = 0
            .ReadOnly    = .T.
            .BackColor   = RGB(255, 255, 128)
            .Visible     = .T.
        ENDWITH

        *-- txt_4c_Valtot (getValtot, dump 816-832) - totalizador de valor
        THIS.AddObject("txt_4c_Valtot", "TextBox")
        WITH THIS.txt_4c_Valtot
            .Top         = 521
            .Left        = 860
            .Width       = 108
            .Height      = 18
            .Value       = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .InputMask   = "999,999.99"
            .MaxLength   = 12
            .Margin      = 0
            .ReadOnly    = .T.
            .BackColor   = RGB(255, 255, 128)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOkClick - Equivalente ao PROCEDURE Click do botao OK legado (dump
    * 1030-1097). O bloco que transferia TmpDistrib para o cursor xnensi
    * esta COMENTADO no legado (*!*, codigo morto desde o Fortyus) - a UNICA
    * acao viva eh reabilitar e atualizar o formulario pai e fechar este
    * dialogo, o que THIS.Release() ja faz via Destroy() (ver comentario em
    * Destroy() mais abaixo). Metodo PUBLIC (sem PROTECTED) - exigencia do
    * BINDEVENT (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnOkClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Monta this_cCursorDistrib via SigPrSerBO.CarregarDistribuicao()
    * e liga a grade a ele (equivalente ao bloco final do Init legado, dump
    * 945-964: "Select TmpDistrib / Go Top / With ThisForm.Grade / ...").
    *
    * RecordSource/ControlSource RESETAM Column.Width e Header1.Caption em
    * VFP9 (CLAUDE.md - "Grade perdendo cabecalhos apos RecordSource") -
    * por isso Width/Caption sao reaplicados IMEDIATAMENTE depois do bind,
    * repetindo os mesmos valores de ConfigurarPaginaLista().
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_cCursor, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)

                IF THIS.this_oBusinessObject.CarregarDistribuicao()
                    loc_cCursor = THIS.this_oBusinessObject.this_cCursorDistrib

                    IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                        THIS.grd_4c_Dados.RecordSource = loc_cCursor

                        WITH THIS.grd_4c_Dados
                            .Column1.ControlSource = loc_cCursor + ".Empdnps"
                            .Column2.ControlSource = loc_cCursor + ".Grupoos"
                            .Column7.ControlSource = loc_cCursor + ".Contaos"
                            .Column8.ControlSource = loc_cCursor + ".Grupods"
                            .Column9.ControlSource = loc_cCursor + ".Contads"
                            .Column3.ControlSource = loc_cCursor + ".Cmats"
                            .Column4.ControlSource = loc_cCursor + ".Qtds"
                            .Column5.ControlSource = loc_cCursor + ".Fators"
                            .Column6.ControlSource = loc_cCursor + ".Qtds * " + loc_cCursor + ".Fators"

                            *-- Reaplica Width/Caption apos o bind (reset do VFP9)
                            .Column1.Width = 241
                            .Column2.Width = 80
                            .Column7.Width = 80
                            .Column8.Width = 80
                            .Column9.Width = 80
                            .Column3.Width = 108
                            .Column4.Width = 80
                            .Column5.Width = 80
                            .Column6.Width = 108

                            .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                            .Column2.Header1.Caption = "Grupo"
                            .Column7.Header1.Caption = "Conta"
                            .Column8.Header1.Caption = "Grupo"
                            .Column9.Header1.Caption = "Conta"
                            .Column3.Header1.Caption = "Servi" + CHR(231) + "o"
                            .Column4.Header1.Caption = "Qtde"
                            .Column5.Header1.Caption = "Valor"
                            .Column6.Header1.Caption = "Total"

                            *-- Equivalente a .SetAll('DynamicForeColor', "Iif(TmpDistrib.Retrabs,
                            *-- RGB(255,0,0),RGB(0,0,0))", 'Column') do Init legado (dump 959).
                            *-- Retrabs vem como BIT do SQL Server -> LOGICAL no VFP9, por isso
                            *-- entra direto no IIF (sem comparar com 1/0 - CLAUDE.md regra #13).
                            .SetAll("DynamicForeColor", ;
                                "IIF(" + loc_cCursor + ".Retrabs, RGB(255,0,0), RGB(0,0,0))", ;
                                "Column")

                            IF USED(loc_cCursor)
                                GO TOP IN (loc_cCursor)
                            ENDIF

                            .Refresh()
                        ENDWITH
                    ENDIF

                    *-- txt_4c_Descr/DescOrig/DescDest espelham a linha
                    *-- corrente de cursor_4c_Distrib (Dpros/DescOrig/
                    *-- DescDest) - mesmo motivo do ControlSource da grade,
                    *-- so existe apos o cursor ser criado por
                    *-- CarregarDistribuicao(). PEMSTATUS porque esses
                    *-- TextBox so passam a existir a partir da Fase 6.
                    IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
                        THIS.txt_4c_Descr.ControlSource = loc_cCursor + ".Dpros"
                        THIS.txt_4c_Descr.Refresh()
                    ENDIF
                    IF PEMSTATUS(THIS, "txt_4c_DescOrig", 5)
                        THIS.txt_4c_DescOrig.ControlSource = loc_cCursor + ".DescOrig"
                        THIS.txt_4c_DescOrig.Refresh()
                    ENDIF
                    IF PEMSTATUS(THIS, "txt_4c_DescDest", 5)
                        THIS.txt_4c_DescDest.ControlSource = loc_cCursor + ".DescDest"
                        THIS.txt_4c_DescDest.Refresh()
                    ENDIF

                    THIS.this_oBusinessObject.Acumular()
                    THIS.AtualizarTotais()

                    loc_lSucesso = .T.
                ELSE
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                            "Erro ao Carregar Servi" + CHR(231) + "os Lan" + CHR(231) + "ados")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTotais - Exibe this_nQtdTotal/this_nValorTotal (calculados por
    * SigPrSerBO.Acumular()) nos totalizadores txt_4c_QtdTot/txt_4c_Valtot
    * (getQtdTot/getValtot do legado - equivalente ao
    * "thisform.getqtdTot.Value = qtds" do PROCEDURE acumula()). PEMSTATUS
    * mantido como guarda defensiva (THIS.this_oBusinessObject existe antes
    * de ConfigurarPaginaDados() no InicializarForm).
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTotais()
        IF VARTYPE(THIS.this_oBusinessObject) != "O" OR ISNULL(THIS.this_oBusinessObject)
            RETURN
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_QtdTot", 5)
            THIS.txt_4c_QtdTot.Value = THIS.this_oBusinessObject.this_nQtdTotal
            THIS.txt_4c_QtdTot.Refresh()
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Valtot", 5)
            THIS.txt_4c_Valtot.Value = THIS.this_oBusinessObject.this_nValorTotal
            THIS.txt_4c_Valtot.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - Equivalente ao PROCEDURE AfterRowColChange da
    * Grade legada (dump 1121-1127: "ThisForm.Get_Descr.Refresh"). So atualiza
    * o detalhe da linha corrente (sem filtro de coluna - uso correto do
    * evento, CLAUDE.md regra #46): txt_4c_Descr/DescOrig/DescDest, que
    * espelham Dpros/DescOrig/DescDest da linha corrente de cursor_4c_Distrib.
    * O legado so refresca Get_Descr porque getDescOrig/getDescDest nao tinham
    * esse Refresh explicito no dump - mas como os tres sao ControlSource
    * direto sobre a MESMA linha corrente do cursor, repetir o Refresh nos
    * tres evita que origem/destino fiquem um passo atras do servico ao
    * navegar na grade. Metodo PUBLIC (sem PROTECTED) - exigencia do
    * BINDEVENT (CLAUDE.md regra #3), com o parametro do evento declarado.
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
            THIS.txt_4c_Descr.Refresh()
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DescOrig", 5)
            THIS.txt_4c_DescOrig.Refresh()
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DescDest", 5)
            THIS.txt_4c_DescDest.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Form OPERACIONAL FLAT (sem PageFrame/Page1/Page2 -
    * SIGPRSER legado eh single-view, so a grade de servicos). Mantido pelo
    * padrao canonico do pipeline (mesmo papel de FormSigPrTar.AlternarPagina
    * para dialogos sem PageFrame): par_nPagina = 1 recarrega a distribuicao
    * e os totais a partir de cursor_4c_Operacoes - usado pelo formulario pai
    * quando o conjunto de operacoes em conferencia mudar.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.CarregarLista()
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha o cursor de distribuicao proprio deste dialogo (nunca
    * os cursores do form PAI - xMfas/tmpnens/xnensi pertencem a ele),
    * reabilita o form pai e atualiza-o (equivalente a
    * "ThisForm.ParentForm.Enabled = .t." + "ThisForm.ParentForm.Refresh" do
    * botao OK legado - repetido aqui como rede de seguranca para qualquer
    * caminho de fechamento que nao passe pelo OK).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) = "O" AND !EMPTY(loc_oBO.this_cCursorDistrib) ;
                AND USED(loc_oBO.this_cCursorDistrib)
            USE IN (loc_oBO.this_cCursorDistrib)
        ENDIF

        IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
            THIS.this_oParentForm.Enabled = .T.
            THIS.this_oParentForm.Refresh()
        ENDIF

        THIS.this_oParentForm = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrSerBO.prg):
*==============================================================================
* SigPrSerBO.prg - Business Object: Servicos Lancados (SIGPRSER)
*
* Form OPERACIONAL (SIGPRSER / FormSigPrSer): dialogo filho, aberto por um
* formulario pai durante a emissao de uma nota/movimentacao, que exibe os
* servicos ja lancados para o conjunto de operacoes de producao (Nops) em
* processamento - origem/destino de conta, quantidade, fator e valor - e
* totaliza quantidade/valor para conferencia antes de confirmar a nota.
*
* Origem legado (SIGPRSER.SCX): o Init monta o cursor TmpDistrib juntando
* SigPdMvf/SigCdNei/SigCdNec/SigCdPro/SigCdCli (origem e destino), uma
* consulta por Nops presente no cursor xMfas (que o formulario pai ja
* populava na DataSession antes de abrir este dialogo); a grade exibe
* TmpDistrib e o metodo acumula() soma Qtds e (Qtds*Fators) para os
* totalizadores. O bloco de gravacao do botao OK (transferencia para o
* cursor xnensi) esta COMENTADO no legado (*!*) - a acao realmente ativa
* e apenas reabilitar o formulario pai, atualiza-lo e fechar este dialogo.
*
* NAO existe uma unica "tabela principal" para este BO (this_cTabela
* permanece vazio) - ele opera sobre cursores temporarios (cursor_4c_
* Distrib, equivalente a TmpDistrib) montados a partir de varias tabelas,
* igual ao padrao ja adotado em SigPrGlxBO/SigPrGl2BO.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos de carga/calculo (CarregarDistribuicao/
*                Acumular/CarregarDoCursor)
*==============================================================================

DEFINE CLASS SigPrSerBO AS BusinessBase

    *==========================================================================
    * Cursores de trabalho (nomes) - equivalentes aos cursores do legado que
    * viviam na DataSession compartilhada entre o formulario pai e este
    * dialogo filho.
    *==========================================================================
    this_cCursorOperacoes = "cursor_4c_Operacoes" && Lista de Nops (operacoes de producao) a processar - equivalente ao cursor xMfas, populado pelo formulario pai antes de abrir este dialogo
    this_cCursorDistrib   = "cursor_4c_Distrib"   && Servicos lancados consolidados com origem/destino de conta - equivalente a TmpDistrib

    *==========================================================================
    * Dados do cabecalho da movimentacao atual, exibidos somente leitura na
    * tela (equivalentes ao cursor tmpnens.numps/emps/dopps do legado, que o
    * formulario pai tambem ja deixava preparado).
    *==========================================================================
    this_nNumMov  = 0  && tmpnens.numps - numero da movimentacao/nota em processamento
    this_cEmpMov  = "" && tmpnens.emps  - empresa da movimentacao
    this_cOperMov = "" && tmpnens.dopps - tipo/descricao da operacao da movimentacao

    *==========================================================================
    * Totalizadores calculados a partir de cursor_4c_Distrib (equivalente ao
    * PROCEDURE acumula() do legado, que soma Qtds e Qtds*Fators de
    * TmpDistrib e exibe em getQtdTot/getValtot).
    *==========================================================================
    this_nQtdTotal   = 0 && Soma de Qtds dos servicos lancados
    this_nValorTotal = 0 && Soma de (Qtds * Fators) dos servicos lancados

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *
    * Este BO nao opera sobre uma unica tabela SQL Server: o resultado
    * exibido (cursor_4c_Distrib) vem de um JOIN entre SigPdMvf, SigCdNei,
    * SigCdNec, SigCdPro e SigCdCli (origem e destino), montado por Nops -
    * por isso this_cTabela/this_cCampoChave ficam vazios, igual ao padrao
    * ja adotado em SigPrGlxBO/SigPrGl2BO para dialogos operacionais sem
    * entidade unica.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega os dados de cabecalho da movimentacao em
    * processamento (equivalente a tmpnens.numps/emps/dopps do legado, lidos
    * direto via ControlSource em GetCodigo/GetEmpresa/GetOperacao - Init,
    * dump 886-965). par_cCursor eh o alias do cursor de cabecalho que o
    * formulario PAI ja deixa preparado na DataSession compartilhada (Set
    * DataSession To pForm.DataSessionId) antes de abrir este dialogo - este
    * BO so LE esse cursor, nunca o popula.
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        IF TYPE(par_cAliasCursor + ".numps") != "U"
            THIS.this_nNumMov = TratarNulo(EVALUATE(par_cAliasCursor + ".numps"), 0)
        ENDIF
        IF TYPE(par_cAliasCursor + ".emps") != "U"
            THIS.this_cEmpMov = ALLTRIM(TratarNulo(EVALUATE(par_cAliasCursor + ".emps"), ""))
        ENDIF
        IF TYPE(par_cAliasCursor + ".dopps") != "U"
            THIS.this_cOperMov = ALLTRIM(TratarNulo(EVALUATE(par_cAliasCursor + ".dopps"), ""))
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * CarregarDistribuicao - Monta this_cCursorDistrib (equivalente a
    * TmpDistrib) a partir da lista de operacoes de producao presente em
    * this_cCursorOperacoes (equivalente ao cursor xMfas, que o formulario
    * pai ja deixa populado na DataSession compartilhada antes de abrir este
    * dialogo - "Select xMfas / Scan / _nOperacao = xMfas.Nops" no Init
    * legado, dump 913-943).
    *
    * Para cada Nops, repete a mesma consulta (join SigPdMvf/SigCdNei/
    * SigCdNec/SigCdPro/SigCdCli origem e destino) que o legado fazia em
    * LocalMFas4, filtrando so os servicos (b.servicos = 1 and b.cats <> '')
    * e acumulando as linhas no cursor de distribuicao (equivalente ao
    * "Insert into TmpDistrib from memvar" do legado - o bloco alternativo,
    * que so inseria quando TmpDistrib ainda nao tinha aquele Empdnps, esta
    * COMENTADO no legado, *!* linhas 936-941 - por isso NAO reproduzir esse
    * filtro aqui, e acumular toda linha que a consulta devolver).
    *
    * O legado tambem roda essa mesma consulta uma unica vez, sem filtro de
    * Nops e com "where 0=1" (dump 900-911), so para definir a ESTRUTURA de
    * TmpDistrib antes do SCAN. Aqui a estrutura nasce da primeira consulta
    * que devolver linha, ou (se nenhuma operacao casar, ou a lista de
    * operacoes estiver vazia) de uma consulta equivalente com "WHERE 0 = 1"
    * - para que a grade sempre tenha RecordSource valido mesmo com zero
    * linhas, que eh resultado normal (nao erro).
    *==========================================================================
    FUNCTION CarregarDistribuicao()
        LOCAL loc_lSucesso, loc_cAliasAnt, loc_nNops, loc_cSQL, loc_cSQLBase, ;
            loc_nResultado, loc_oErro

        THIS.this_cMensagemErro = ""
        loc_lSucesso  = .F.
        loc_cAliasAnt = ""

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        loc_cSQLBase = "SELECT b.Empdnps, c.Grupoos, c.Contaos, c.Grupods, c.Contads, " + ;
            "b.Cmats, b.Fators, b.Qtds, b.Cretrabs, c.Retrabs, b.CDescs, d.Dpros, " + ;
            "e.Rclis AS DescOrig, f.Rclis AS DescDest " + ;
            "FROM SigPdMvf a " + ;
            "INNER JOIN SigCdNei b ON a.Empdnps = b.Empdnps " + ;
            "INNER JOIN SigCdNec c ON a.Empdnps = c.Empdnps " + ;
            "INNER JOIN SigCdPro d ON b.Cmats = d.Cpros " + ;
            "INNER JOIN SigCdCli e ON c.Contaos = e.Iclis " + ;
            "INNER JOIN SigCdCli f ON c.Contads = f.Iclis "

        TRY
            loc_cAliasAnt = ALIAS()

            IF USED(THIS.this_cCursorDistrib)
                USE IN (THIS.this_cCursorDistrib)
            ENDIF
            IF USED("cursor_4c_DistribTmp")
                USE IN cursor_4c_DistribTmp
            ENDIF

            IF USED(THIS.this_cCursorOperacoes) AND RECCOUNT(THIS.this_cCursorOperacoes) > 0

                SELECT (THIS.this_cCursorOperacoes)
                SCAN
                    loc_nNops = TratarNulo(EVALUATE(THIS.this_cCursorOperacoes + ".Nops"), 0)

                    loc_cSQL = loc_cSQLBase + ;
                        "WHERE a.Nops = " + FormatarNumeroSQL(loc_nNops, 0) + ;
                        " AND b.Servicos = 1 AND b.Cats <> ''"

                    IF USED("cursor_4c_DistribTmp")
                        USE IN cursor_4c_DistribTmp
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DistribTmp")

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            "(Text - LocalMFas4) " + CapturarErroSQL()
                        EXIT
                    ENDIF

                    IF USED("cursor_4c_DistribTmp") AND RECCOUNT("cursor_4c_DistribTmp") > 0
                        IF !USED(THIS.this_cCursorDistrib)
                            SELECT * FROM cursor_4c_DistribTmp WHERE .F. ;
                                INTO CURSOR (THIS.this_cCursorDistrib) READWRITE
                        ENDIF
                        SELECT (THIS.this_cCursorDistrib)
                        APPEND FROM DBF("cursor_4c_DistribTmp")
                    ENDIF

                    SELECT (THIS.this_cCursorOperacoes)
                ENDSCAN

                IF USED("cursor_4c_DistribTmp")
                    USE IN cursor_4c_DistribTmp
                ENDIF
            ENDIF

            IF EMPTY(THIS.this_cMensagemErro) AND !USED(THIS.this_cCursorDistrib)
                *-- Lista de operacoes vazia, ou nenhuma linha casou com o
                *-- filtro de servicos - cursor nasce vazio, com estrutura
                *-- valida (equivalente ao "where 0=1" do Init legado)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQLBase + "WHERE 0 = 1", "cursor_4c_DistribTmp")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "(Text - TmpDistrib) " + CapturarErroSQL()
                ELSE
                    SELECT * FROM cursor_4c_DistribTmp WHERE .F. ;
                        INTO CURSOR (THIS.this_cCursorDistrib) READWRITE
                    USE IN cursor_4c_DistribTmp
                ENDIF
            ENDIF

            loc_lSucesso = EMPTY(THIS.this_cMensagemErro) AND USED(THIS.this_cCursorDistrib)

            IF USED(THIS.this_cCursorDistrib)
                GO TOP IN (THIS.this_cCursorDistrib)
            ENDIF

            IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
                SELECT (loc_cAliasAnt)
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Acumular - Recalcula os totalizadores exibidos no rodape da tela
    * (getQtdTot/getValtot) a partir de this_cCursorDistrib - transcricao do
    * PROCEDURE acumula() do legado (dump 871-881):
    *   Select Sum(qtds) as qtds, Sum(qtds * fators) as vrpags From
    *   tmpDistrib Into Cursor curt
    * Com o cursor de distribuicao vazio, SUM() devolve NULL (equivalente ao
    * .NULL. que o legado tambem gravaria no textbox) - TratarNulo normaliza
    * para 0, mantendo os totalizadores coerentes com uma lista vazia.
    *==========================================================================
    FUNCTION Acumular()
        LOCAL loc_lSucesso, loc_cAliasAnt

        THIS.this_nQtdTotal   = 0
        THIS.this_nValorTotal = 0
        loc_lSucesso = .F.

        IF !USED(THIS.this_cCursorDistrib)
            RETURN .F.
        ENDIF

        loc_cAliasAnt = ALIAS()

        IF USED("cursor_4c_Totais")
            USE IN cursor_4c_Totais
        ENDIF

        SELECT SUM(Qtds) AS Qtds, SUM(Qtds * Fators) AS VrPags ;
            FROM (THIS.this_cCursorDistrib) ;
            INTO CURSOR cursor_4c_Totais

        IF USED("cursor_4c_Totais")
            THIS.this_nQtdTotal   = TratarNulo(cursor_4c_Totais.Qtds, 0)
            THIS.this_nValorTotal = TratarNulo(cursor_4c_Totais.VrPags, 0)
            USE IN cursor_4c_Totais
            loc_lSucesso = .T.
        ENDIF

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor() ja esta implementado acima (dados de cabecalho,
    * somente leitura). ObterChavePrimaria() / Inserir() / Atualizar() /
    * ExecutarExclusao(): este BO deliberadamente NAO sobrescreve esses
    * quatro metodos do BusinessBase.
    *
    * SIGPRSER eh um dialogo filho de PREVIA (conferencia de servicos ja
    * lancados antes de confirmar a nota do form pai) - nao um cadastro. No
    * legado, o bloco que de fato gravaria algo (OK.Click: transferencia de
    * TmpDistrib para o cursor xnensi, dump 1030-1072) esta INTEIRO dentro
    * de comentarios "*!*", ou seja, codigo morto, desativado pela propria
    * equipe Fortyus. A UNICA acao viva do botao OK eh:
    *   ThisForm.ParentForm.Enabled = .t.
    *   Select xnensi / Go Bott
    *   ThisForm.ParentForm.Refresh
    *   ThisForm.Release
    * ou seja: reabilitar e atualizar o formulario pai, e fechar este
    * dialogo - nenhuma gravacao em tabela acontece. Essa acao pertence ao
    * FORM (FormSigPrSer.BtnOkClick), nao ao BO: nao ha "registro desta
    * entidade" para Salvar()/Excluir() persistirem.
    *
    * Os stubs herdados de BusinessBase (que devolvem .F. com mensagem de
    * erro, e ObterChavePrimaria() devolvendo "") permanecem corretos, pois
    * Salvar()/Excluir() nunca sao acionados por este form - ver mesma
    * decisao, pelo mesmo motivo, em SigPrGlxBO.prg/SigPrGl2BO.prg.
    *==========================================================================

ENDDEFINE

