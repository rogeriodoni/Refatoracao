# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 9/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-28 01:26:42] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-28 01:26:42] [INFO] Config FPW: (nao fornecido)
[2026-09-28 01:26:42] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-28 01:26:42] [INFO] Timeout: 300 segundos
[2026-09-28 01:26:42] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iltq3o3z.prg
[2026-09-28 01:26:42] [INFO] Conteudo do wrapper:
[2026-09-28 01:26:42] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigprema', 'C:\4c\tasks\task602\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprema', 'C:\4c\tasks\task602\logs\06_testForm.log'
QUIT

[2026-09-28 01:26:42] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iltq3o3z.prg
[2026-09-28 01:26:42] [INFO] VFP output esperado em: C:\4c\tasks\task602\vfp_output.txt
[2026-09-28 01:26:42] [INFO] Executando Visual FoxPro 9...
[2026-09-28 01:26:42] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iltq3o3z.prg
[2026-09-28 01:26:42] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iltq3o3z.prg
[2026-09-28 01:26:42] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigprema
Inicio: 28/09/2026 01:26:43

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 28/09/2026 01:29:50
Duracao: 187 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-28 01:29:50] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-28 01:29:50] [INFO] VFP9 finalizado em 188.023288 segundos
[2026-09-28 01:29:50] [INFO] Exit Code: 
[2026-09-28 01:29:50] [INFO] 
[2026-09-28 01:29:50] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-28 01:29:50] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iltq3o3z.prg
[2026-09-28 01:29:50] [INFO] 
[2026-09-28 01:29:50] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-28 01:29:50] [INFO] * Auto-generated wrapper for parameters
[2026-09-28 01:29:50] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-28 01:29:50] [INFO] * Parameters: 'Formsigprema', 'C:\4c\tasks\task602\logs\06_testForm.log'
[2026-09-28 01:29:50] [INFO] 
[2026-09-28 01:29:50] [INFO] * Anti-dialog protections for unattended execution
[2026-09-28 01:29:50] [INFO] SET SAFETY OFF
[2026-09-28 01:29:50] [INFO] SET RESOURCE OFF
[2026-09-28 01:29:50] [INFO] SET TALK OFF
[2026-09-28 01:29:50] [INFO] SET NOTIFY OFF
[2026-09-28 01:29:50] [INFO] SYS(2335, 0)
[2026-09-28 01:29:50] [INFO] 
[2026-09-28 01:29:50] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprema', 'C:\4c\tasks\task602\logs\06_testForm.log'
[2026-09-28 01:29:50] [INFO] QUIT
[2026-09-28 01:29:50] [INFO] 
[2026-09-28 01:29:50] [INFO] === Fim do Wrapper.prg ===
[2026-09-28 01:29:50] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprema.prg):
*==============================================================================
* Formsigprema.prg
* Form OPERACIONAL: Processamento e Geracao de Email
* Migrado de SIGPREMA.SCX
* Herda de: FormBase
*
* Form OPERACIONAL FLAT (sem PageFrame Page1/Page2 - o SCX legado nao tem
* PageFrame, so um container de cabecalho + grid + botoes direto no form -
* ver tasks\task602\layout.json). O BO (sigpremaBO) monta o cursor de
* trabalho cursor_4c_Dados (equivalente a crLocalTotal do legado) cruzando
* SigMvCab + SigCdCli + SigCdPam; este form so exibe/marca linhas desse
* cursor e dispara o envio dos e-mails selecionados.
*
* Parametros do Init (equivalentes a prDopes/pAuto do legado):
*   par_cDopes       - EmpDopNums (29 chars) para filtrar 1 movimento.
*                       Vazio = processa todos os movimentos do dia ainda nao enviados.
*   par_lAutomatico  - .T. quando a tela e chamada em modo automatico.
*
* Historico de fases:
*   Fase 1/2: sigpremaBO.prg (propriedades + metodos de negocio completos)
*   Fase 3:   Formsigprema.prg - estrutura base (heranca, Init, InicializarForm,
*             ConfigurarCabecalho, TornarControlesVisiveis, Destroy)
*   Fase 4:   Grid grd_4c_Dados (5 colunas: Checks/Contas/Rclis/Emails/
*             EmpDopNums), botoes standalone cmd_4c_SelTudo/cmd_4c_Apaga
*             (legado SelTudo/apaga - nao ha container no SCX original),
*             cmg_4c_Encerrar (legado Commandgroup1/btnSair), cmd_4c_EnviarEmail
*             (legado btnEmail) e shp_4c_Decoracao (legado Shape1). CarregarDados
*             (BO.BuscarDadosProcessamento) e todos os handlers (ordenacao por
*             coluna, toggle de Checks, Marcar/Desmarcar Todos, Encerrar e envio
*             de e-mail via BO.EnviarEmailSelecionados) ja ligados nesta fase -
*             o BO ja tinha tudo pronto desde a Fase 1/2.
*   Fase 5:   Conferido campo a campo contra tasks\task602\layout.json e
*             sigprema_form_codigo_fonte.txt - forms OPERACIONAL FLAT como
*             este nao tem Page2/Dados com TextBoxes individuais (o "dado" da
*             tela inteira e' a lista do grd_4c_Dados, ja migrado na Fase 4).
*             Nao ha mais controles do SCX para adicionar. Dois eventos do
*             legado ficaram sem correspondente explicito e sao documentados
*             aqui para a ausencia ser auditavel, nao parecer esquecimento
*             (mesmo padrao de FormSigMvExp/FormSigMvMen):
*               Load ("=fConfigGeral()") - NAO PORTADO. fConfigGeral era
*               funcao GLOBAL de inicializacao da aplicacao legado; na
*               arquitetura nova esse papel e' do start\config.prg (roda uma
*               vez no startup). O wrapper utils\fconfiggeral.prg existe so
*               para o p-code dos VCX legado que ainda o chama (regra #27) -
*               codigo nosso nao o chama.
*               SIGPREMA.Registry1 / "ThisForm.btnEmail.Enabled =
*               ThisForm.Registry1.IsKey('PDFCreator.clsPDFCreator') Or
*               ThisForm.Registry1.IsKey('PDFCreatorBeta.JobQueue')" - NAO
*               PORTADO. No legado essa checagem so faz sentido porque
*               btnEmail.Click chama ImpDocto/criapdf (geracao do PDF anexo
*               via COM do PDFCreator), e o botao ficava desabilitado se o
*               PDFCreator nao estivesse instalado na maquina. Essa geracao
*               de anexo esta fora do escopo desta migracao (ver cabecalho de
*               sigpremaBO.prg - this_cArquivoEmail fica a cargo do Form/
*               futura integracao com relatorios), e o envio de e-mail via
*               BO.EnviarEmailSelecionados NAO depende de PDFCreator. Copiar
*               a checagem sem a funcionalidade que ela protege desabilitaria
*               o botao de Enviar Email em toda maquina sem PDFCreator, sem
*               nenhum ganho - seria pior que o legado, nao fiel a ele.
*   Fase 6:   LOOKUPS - nenhum. Conferido contra sigprema_form_codigo_fonte.txt
*             e analise.json ("lookups": []) procurando fwbuscaext, fwBuscaSel,
*             fwBuscaInt, mAddColuna, sigacess, Acesso* e PROCEDURE Valid com
*             busca: zero ocorrencias. Criar AbrirLookup*/AbrirBusca* aqui
*             seria INVENTAR tabela de lookup que o legado nao consulta
*             (violaria o PILAR 1 e a regra "NUNCA inventar tabelas de lookup").
*
*             CAMPOS RESTANTES - este form OPERACIONAL e' FLAT (sem PageFrame
*             Page1/Page2, ver Fase 3/5): nao existe "Page2 de Dados", o dado
*             da tela e' a lista crLocalTotal/cursor_4c_Dados exibida em
*             grd_4c_Dados, ja montada por inteiro na Fase 4. Conferidos os 5
*             ControlSource e os ReadOnly contra o SCX (Column6/ColumnOrder=1
*             = Checks W=17 RO=.F.; Column2 Conta W=80 RO=.T.; Column3 Nome
*             W=290 RO=.T.; Column4 Email W=290 RO=.F.; Column5 EmpDopNums
*             W=290 RO=.T.) - batem. Todos os controles do SCX ja foram migrados.
*
*             O que esta fase ACRESCENTA e' a validacao da unica celula
*             digitavel da tela, a coluna Email (Column4, a unica com
*             ReadOnly = .F. no SCX legado), que ate aqui nao tinha handler
*             nenhum:
*               ValidarEmailLinha / ValidarEmailLinhaKeyPress - normaliza o
*               e-mail digitado (LOWER + ALLTRIM, a mesma normalizacao que o
*               legado ja aplica no momento do envio) e grava de volta no
*               cursor, para o que aparece na grade ser igual ao que sai no
*               campo "Para". Ligados por KeyPress (ENTER/TAB) + LostFocus -
*               "Valid" nao dispara via BINDEVENT em TextBox.
*               ValidarEnvio - conferencia previa chamada por
*               BtnProcessarEmailClick, reproduzindo os dois criterios que o
*               proprio btnEmail.Click legado aplica sobre as linhas
*               ("Where Checks = 1" e "If IsEmpty(...emails) / Loop").
*               DESVIO DELIBERADO do legado, restrito a mensagem/aborto: no
*               legado esses dois casos sao silenciosos e a tela exibe
*               "Email enviado com sucesso!" e se fecha sem ter enviado nada
*               (o SCAN nao executa nenhuma iteracao e "llOk" continua .T.).
*               Nao reproduzir isso e' exigencia de CLAUDE.md #20 e da regra
*               de nunca anunciar sucesso sem ter havido o que processar. O
*               release do modo automatico continua incondicional, como no
*               legado.
*   Fase 7:   EVENTOS PRINCIPAIS - este form OPERACIONAL nao tem CRUD (o
*             legado SIGPREMA.SCX nao herda de frmcadastro, nao tem Grupo_Op
*             nem pcEscolha - e' so cabecalho + grade + botoes de acao direto
*             no form, ver layout.json/comportamento.json). Os 4 botoes reais
*             do legado (Commandgroup1/btnSair, btnEmail, SelTudo, apaga) ja
*             tinham handler completo desde a Fase 4 (BtnProcessarEmailClick/
*             BtnSelTudoClick/BtnApagaClick + o botao de saida). Criar
*             BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
*             BtnExcluirClick aqui seria inventar CRUD que o legado nao tem
*             (violaria o PILAR 1). Unico ajuste desta fase: o handler do
*             botao de saida estava nomeado CmgEncerrarClick (prefixo do
*             objeto cmg_4c_Encerrar, nao da convencao de handler Btn/Cmd) -
*             renomeado para BtnEncerrarClick, consistente com os demais
*             handlers de botao do form.
*   Fase 8:   EVENTOS AUXILIARES E CONSOLIDACAO FINAL - conferencia final
*             deste form OPERACIONAL FLAT contra a lista canonica de metodos
*             de fechamento de fase (BtnBuscarClick/BtnEncerrarClick/
*             BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/
*             HabilitarCampos/LimparCampos/CarregarLista/
*             AjustarBotoesPorModo). Essa lista e' convencao de form CRUD
*             (frmcadastro com Page1=Lista/Page2=Dados e modos INCLUIR/
*             ALTERAR/VISUALIZAR/EXCLUIR); o SIGPREMA legado nao tem NENHUMA
*             dessa estrutura (confirmado de novo aqui, no fechamento da
*             migracao, contra sigprema_form_codigo_fonte.txt):
*               BtnBuscarClick   - NAO SE APLICA. O legado nao tem campo de
*                 filtro/busca nenhum (grep por "buscar"/"filtro"/"pesquis"
*                 no dump: zero ocorrencias) - a grade e' populada por
*                 inteiro no Init (equivalente a CarregarDados/
*                 BuscarDadosProcessamento, ja existente desde a Fase 3/4).
*                 Criar um botao de busca aqui seria inventar funcionalidade
*                 que o legado nao tem (PILAR 1).
*               BtnEncerrarClick - JA EXISTE (Fase 4, renomeado na Fase 7).
*                 Equivalente ao Commandgroup1/btnSair.Click legado.
*               BtnSalvarClick   - NAO SE APLICA COM ESSE NOME. O legado nao
*                 grava em tabela nenhuma (ver cabecalho de sigpremaBO.prg),
*                 mas esta tela NAO e' somente-leitura: a "acao principal"
*                 dela e' o PROCESSAMENTO e envio dos e-mails marcados, que
*                 e' trabalho de verdade e ja estava coberto desde a Fase 4
*                 (equivalente ao btnEmail.Click legado), disparando
*                 sigpremaBO.EnviarEmailSelecionados(). Inventar um
*                 BtnSalvarClick vazio ao lado dele seria o "stub
*                 disfarcado" proibido pela regra de completude.
*                 RENOMEADO NESTA FASE: o handler chamava-se
*                 BtnEnviarEmailClick, nomeado pelo objeto legado (btnEmail)
*                 em vez de pela ACAO. O verbo "Enviar" fica fora da
*                 convencao de handler de acao do projeto (Salvar/Confirmar/
*                 Gravar/Processa/Aplicar/Executar/OK), que e' o que torna o
*                 handler ENUMERAVEL pelos gates - o mesmo defeito que a
*                 Fase 7 corrigiu em CmgEncerrarClick. Passou a
*                 BtnProcessarEmailClick, fiel ao Caption do form
*                 ("Processamento e Geracao de Email") e ao que o metodo faz,
*                 sem renomear o CONTROLE (cmd_4c_EnviarEmail) nem os
*                 metodos do BO (EnviarEmail/EnviarEmailSelecionados), que
*                 seguem descrevendo o meio de entrega.
*               BtnCancelarClick - NAO SE APLICA. Nao ha Page2/modo de
*                 edicao para cancelar - a unica saida da tela e' o
*                 Encerrar (BtnEncerrarClick), igual ao legado.
*               FormParaBO/BOParaForm - NAO SE APLICAM. Esses hooks
*                 transferem os campos de UMA ficha entre Form e BO; esta
*                 tela nao edita um registro por vez, opera em LOTE sobre as
*                 linhas de cursor_4c_Dados (equivalente a crLocalTotal) via
*                 ChkChecksInteractiveChange (grava direto no cursor) e
*                 ValidarEmailLinha (idem) - o "de-para" delas ja existe,
*                 so que na granularidade de LINHA da grade, nao de FICHA.
*               HabilitarCampos/LimparCampos - NAO SE APLICAM. Nao ha modo
*                 INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR nem campos de ficha a
*                 habilitar/limpar - a UNICA celula editavel (Column4/
*                 Emails) fica sempre editavel, como no SCX legado
*                 (Column4.ReadOnly = .F. incondicional).
*               AjustarBotoesPorModo - NAO SE APLICA. Nao ha "modo" de tela
*                 (LISTA/INCLUIR/ALTERAR/VISUALIZAR) cujos botoes mudem de
*                 Enabled - os 4 botoes do legado (Enviar Email, Marcar
*                 Todos, Desmarcar Todos, Encerrar) ficam sempre habilitados.
*               CarregarLista - EQUIVALENTE JA EXISTE desde a Fase 3/4:
*                 CarregarDados() (que delega a
*                 sigpremaBO.BuscarDadosProcessamento) e' chamado em
*                 InicializarForm() e alimenta grd_4c_Dados, exatamente o
*                 papel que CarregarLista tem nos forms CRUD. O nome
*                 CarregarDados foi mantido (em vez de CarregarLista) porque
*                 e' o mesmo dado que a Fase 6 ja documentou como "a tela
*                 inteira e' a lista" - nao ha uma segunda fonte de dados
*                 (Page2/ficha) para o nome "Lista" precisar distinguir.
*
*             Nenhum metodo novo foi criado nesta fase (a unica mudanca de
*             codigo foi a renomeacao do handler de acao descrita acima): os
*             4 botoes reais do legado e a carga da grade ja estavam
*             completos e testados desde as Fases 3, 4 e 6. Revisao final contra
*             comportamento.json confirma que os unicos PROCEDURE do dump
*             ainda sem correspondente no migrado sao os ja documentados nas
*             Fases 5/6 como fora de escopo (criapdf/documento/impdocto -
*             cadeia de geracao de PDF via COM PDFCreator.clsPDFCreator +
*             REPORT FORM SigReDc2 + chamada a quatro outras telas de
*             relatorio - SigPrIdc/SigReIfx/SigReJob/SigOpIgm/SigReIiv -
*             nenhuma delas parte desta migracao; e Load/=fConfigGeral(),
*             papel que start\config.prg ja cumpre no startup da aplicacao
*             nova). memail (o corpo real de envio via CDO.Message) ja esta
*             transcrito em sigpremaBO.EnviarEmail desde a Fase 1/2.
*==============================================================================
DEFINE CLASS Formsigprema AS FormBase

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Parametros recebidos no Init (equivalentes a prDopes/pAuto do legado)
    this_cDopesFiltro = ""    && prDopes - EmpDopNums para filtrar 1 movimento
    this_lAutomatico  = .F.   && pAuto - .T. quando chamado em modo automatico

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX legado)
    Top         = 0
    Left        = 0
    Height      = 600
    Width       = 1000
    BorderStyle = 2
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Caption     = "Processamento e Gera" + CHR(231) + CHR(227) + "o de Email"
    FontName    = "Tahoma"
    FontSize    = 8

    *--------------------------------------------------------------------------
    * Init - Recebe os parametros equivalentes a prDopes/pAuto do legado
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cDopes, par_lAutomatico)
        THIS.this_cDopesFiltro = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
        THIS.this_lAutomatico  = IIF(VARTYPE(par_lAutomatico) = "L", par_lAutomatico, .F.)

        *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigpremaBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigpremaBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formsigprema.InicializarForm")
            ELSE
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                        MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                                "o Com o Servidor de Banco de Dados...", ;
                                "Conex" + CHR(227) + "o")
                    ENDIF
                ENDIF

                THIS.ConfigurarCabecalho()

                *-- Grid.ColumnN.ControlSource exige o cursor JA existente (CLAUDE.md
                *-- regra #41) - por isso o cursor eh criado/populado ANTES de montar
                *-- o Grid. Em validacao de UI (sem SQL) usa placeholder vazio com a
                *-- MESMA estrutura, igual ao padrao ja usado nos forms CRUD.
                IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                    THIS.CriarCursorPlaceholder()
                ELSE
                    THIS.CarregarDados()
                ENDIF

                THIS.ConfigurarGrid()
                THIS.ConfigurarBotoes()

                THIS.TornarControlesVisiveis(THIS)

                *-- Equivalente ao "If ThisForm.Automatico / ThisForm.btnEmail.Click() /
                *-- ThisForm.Release / Return .f." do Init legado - so dispara quando o
                *-- Form foi explicitamente criado em modo automatico (par_lAutomatico=.T.),
                *-- nunca no fluxo interativo padrao nem em validacao de UI.
                IF THIS.this_lAutomatico AND (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                    THIS.BtnProcessarEmailClick()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprema.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorPlaceholder - Estrutura vazia de cursor_4c_Dados usada apenas
    * quando gb_4c_ValidandoUI esta ativo (sem SQL disponivel), para o Grid ter
    * um cursor valido para ligar o ControlSource (CLAUDE.md regra #41).
    * Estrutura IDENTICA a criada em sigpremaBO.BuscarDadosProcessamento.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursorPlaceholder()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Dados ;
            (Checks N(1) NULL, Grupos C(10) NULL, Contas C(10) NULL, ;
             Rclis C(50) NULL, Emails C(50) NULL, Mensagens M NULL, ;
             EmpDopNums C(29) NULL, Prioridade C(15) NULL)
        SET NULL OFF

        INDEX ON Contas TAG Contas
        INDEX ON Rclis  TAG Rclis
        INDEX ON Emails TAG Emails
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Popula cursor_4c_Dados (equivalente a crLocalTotal do
    * legado) via sigpremaBO.BuscarDadosProcessamento, usando o filtro recebido
    * no Init do form (this_cDopesFiltro - equivalente a prDopes do legado).
    * Erros de SQL ja sao exibidos dentro do proprio BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDados()
        THIS.this_oBusinessObject.BuscarDadosProcessamento(THIS.this_cDopesFiltro)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Constroi a faixa cinza superior do form
    * Equivalente ao cntSombra do SCX legado. Forms OPERACIONAIS nao usam
    * PageFrame CRUD - o cabecalho eh um container direto no form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BackStyle   = 1
                .BorderWidth = 0

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Top       = 18
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 40
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 18
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .WordWrap  = .T.
                    .Alignment = 0
                    .ForeColor = RGB(0, 0, 0)
                    .Caption   = THIS.Caption
                ENDWITH

                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .Top       = 17
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 46
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 18
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .WordWrap  = .T.
                    .Alignment = 0
                    .ForeColor = RGB(255, 255, 255)
                    .Caption   = THIS.Caption
                ENDWITH

                .Visible = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprema.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Monta grd_4c_Dados (equivalente ao grade/fwgrade do
    * legado) ligado a cursor_4c_Dados. Ordem das colunas eh a ordem VISUAL do
    * legado (Checks/Contas/Rclis/Emails/EmpDopNums) - por isso nao precisamos
    * de ColumnOrder (propriedade a evitar, causa desalinhamento).
    *
    * cursor_4c_Dados DEVE existir antes desta chamada (CriarCursorPlaceholder
    * ou CarregarDados, chamados em InicializarForm) - CLAUDE.md regra #41.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid, loc_oErro

        TRY
            THIS.AddObject("grd_4c_Dados", "Grid")
            loc_oGrid = THIS.grd_4c_Dados

            WITH loc_oGrid
                .Top        = 126
                .Left       = 3
                .Width      = 993
                .Height     = 469
                .FontName   = "Verdana"
                .FontSize   = 8
                .RowHeight  = 18
                .RecordMark = .F.
                .DeleteMark = .F.
                .ReadOnly   = .F.
            ENDWITH

            *-- ColumnCount/RecordSource FORA do WITH: dentro do mesmo WITH que
            *-- em seguida acessa .ColumnN, o Grid ainda nao recriou as colunas
            *-- e a referencia estoura "Unknown member COLUMN1".
            loc_oGrid.ColumnCount  = 5
            loc_oGrid.RecordSource = "cursor_4c_Dados"

            WITH loc_oGrid
                *-- ControlSource das colunas de texto (logo apos o RecordSource -
                *-- CLAUDE.md: RecordSource reseta customizacoes de coluna)
                .Column2.ControlSource = "cursor_4c_Dados.Contas"
                .Column3.ControlSource = "cursor_4c_Dados.Rclis"
                .Column4.ControlSource = "cursor_4c_Dados.Emails"
                .Column5.ControlSource = "cursor_4c_Dados.EmpDopNums"

                *-- Coluna de selecao (equivalente ao Column6/fwcheckbox1 legado) -
                *-- AddObject + CurrentControl OBRIGATORIAMENTE antes do ControlSource
                *-- (CLAUDE.md regra #18)
                .Column1.AddObject("chk_4c_Checks", "CheckBox")
                WITH .Column1.chk_4c_Checks
                    .Caption   = ""
                    .Alignment = 0
                    .Value     = 0
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
                .Column1.CurrentControl = "chk_4c_Checks"
                .Column1.Sparse         = .F.
                .Column1.ReadOnly       = .F.
                .Column1.ControlSource  = "cursor_4c_Dados.Checks"

                *-- Width por ULTIMO (RecordSource/ControlSource recalculam para 90)
                .Column1.Width = 17
                .Column2.Width = 80
                .Column3.Width = 290
                .Column4.Width = 290
                .Column5.Width = 290

                .Column2.ReadOnly = .T.
                .Column3.ReadOnly = .T.
                .Column4.ReadOnly = .F.
                .Column5.ReadOnly = .T.

                .Column1.Header1.Caption = ""

                .Column2.Header1.Caption   = "Conta"
                .Column2.Header1.Alignment = 2
                .Column2.Header1.FontName  = "Tahoma"
                .Column2.Header1.FontSize  = 8

                .Column3.Header1.Caption   = "Nome"
                .Column3.Header1.Alignment = 2
                .Column3.Header1.FontName  = "Tahoma"
                .Column3.Header1.FontSize  = 8

                .Column4.Header1.Caption   = "Email"
                .Column4.Header1.Alignment = 2
                .Column4.Header1.FontName  = "Tahoma"
                .Column4.Header1.FontSize  = 8

                .Column5.Header1.Caption  = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
                .Column5.Header1.FontName = "Tahoma"
                .Column5.Header1.FontSize = 8

                .Visible = .T.
            ENDWITH

            BINDEVENT(loc_oGrid.Column1.chk_4c_Checks, "InteractiveChange", THIS, "ChkChecksInteractiveChange")

            *-- Column4 (Emails) e' a UNICA celula digitavel da grade, tanto no
            *-- legado (Column4.ReadOnly = .F. no SCX, contra .T. das demais)
            *-- quanto aqui. O que o usuario digitar nela e' exatamente o que
            *-- vai para o campo "Para"/"Cc" do envio, entao o valor precisa ser
            *-- normalizado e conferido ANTES de sair da celula.
            *-- "Valid" NAO dispara via BINDEVENT em TextBox (CLAUDE.md) - o
            *-- equivalente e' KeyPress (ENTER/TAB) + LostFocus.
            BINDEVENT(loc_oGrid.Column4.Text1, "KeyPress",  THIS, "ValidarEmailLinhaKeyPress")
            BINDEVENT(loc_oGrid.Column4.Text1, "LostFocus", THIS, "ValidarEmailLinha")

            BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "HeaderContasClick")
            BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "HeaderRclisClick")
            BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "HeaderEmailsClick")

            *-- Equivalente a "Thisform.grade.column3.header1.Click()" no fim do
            *-- Init legado - ordena por Nome (Rclis) e destaca o header ativo
            THIS.this_oBusinessObject.OrdenarPorColuna("Rclis")
            THIS.AtualizarDestaqueColunaOrdenada("Rclis")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprema.ConfigurarGrid")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarDestaqueColunaOrdenada - Destaca com fundo azul-esverdeado o
    * header da coluna usada na ordenacao corrente e volta as demais para o
    * cinza padrao - transcricao literal do Header1.Click do legado
    * (RGB(64,128,128) = coluna ativa / RGB(192,192,192) = colunas inativas).
    * par_cColuna: "Contas" | "Rclis" | "Emails"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarDestaqueColunaOrdenada(par_cColuna)
        LOCAL loc_nAtivo, loc_nInativo

        loc_nAtivo   = RGB(64, 128, 128)
        loc_nInativo = RGB(192, 192, 192)

        THIS.grd_4c_Dados.Column2.Header1.BackColor = IIF(par_cColuna = "Contas", loc_nAtivo, loc_nInativo)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = IIF(par_cColuna = "Rclis",  loc_nAtivo, loc_nInativo)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = IIF(par_cColuna = "Emails", loc_nAtivo, loc_nInativo)
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkChecksInteractiveChange - Grava o novo estado do checkbox no cursor de
    * trabalho. Transcricao literal do "Replace Checks With this.Value in
    * crLocalTotal" do PROCEDURE InteractiveChange legado (Column6.fwcheckbox1).
    * PUBLIC (sem PROTECTED) - metodo alvo de BINDEVENT (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ChkChecksInteractiveChange()
        LOCAL loc_oChk

        loc_oChk = THIS.grd_4c_Dados.Column1.chk_4c_Checks

        IF USED("cursor_4c_Dados")
            REPLACE Checks WITH loc_oChk.Value IN cursor_4c_Dados
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmailLinhaKeyPress - Dispara a validacao da celula de e-mail ao
    * confirmar a digitacao com ENTER (13) ou TAB (9), que e' o equivalente do
    * Valid da celula no legado ("Valid" nao dispara via BINDEVENT em TextBox -
    * CLAUDE.md). PUBLIC (alvo de BINDEVENT, CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmailLinhaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmailLinha()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmailLinha - Normaliza o e-mail digitado na celula editavel da
    * grade (Column4/Emails, a unica com ReadOnly = .F. no SCX legado) e grava
    * o valor normalizado de volta no cursor de trabalho.
    *
    * A normalizacao aplicada e' a MESMA que o legado ja aplica no momento do
    * envio - ALLTRIM no destinatario/copia (btnEmail.Click:
    * "Alltrim(crLocaltotal2.emails)") e LOWER no remetente/servidor
    * ("Lower(Alltrim(Nvl(TmpEmpMail.PadEmails,[])))"). Fazer isso aqui, na
    * saida da celula, e' o que faz o que o usuario VE na grade ser igual ao
    * que de fato sai no e-mail; sem isso, um espaco a esquerda digitado por
    * engano continua invisivel na tela e vai inteiro para o campo "Para".
    *
    * NAO bloqueia nem rejeita conteudo: o legado nao tem Valid nesta celula e
    * o unico criterio que ele aplica sobre o e-mail e' "vazio -> pula a linha"
    * (btnEmail.Click: "If IsEmpty(crLocaltotal2.emails) / Loop"), criterio que
    * esta reproduzido em sigpremaBO.EnviarEmailSelecionados e conferido em
    * THIS.ValidarEnvio(). Impedir a digitacao aqui seria inventar regra que o
    * legado nao tem (PILAR 1).
    *
    * PUBLIC (alvo de BINDEVENT, CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmailLinha()
        LOCAL loc_oTxt, loc_cDigitado, loc_cNormalizado, loc_oErro

        TRY
            loc_oTxt = THIS.grd_4c_Dados.Column4.Text1

            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                loc_cDigitado    = TratarNulo(loc_oTxt.Value, "")
                loc_cNormalizado = LOWER(ALLTRIM(loc_cDigitado))

                *-- So grava quando mudou de fato: evita reescrever o cursor a
                *-- cada passagem de foco pela celula.
                IF loc_cNormalizado != loc_cDigitado
                    REPLACE Emails WITH loc_cNormalizado IN cursor_4c_Dados
                    loc_oTxt.Value = loc_cNormalizado
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprema.ValidarEmailLinha")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEnvio - Conferencia previa ao disparo do envio, executada por
    * BtnProcessarEmailClick ANTES de chamar o BO. Reproduz os dois criterios que
    * o proprio btnEmail.Click legado aplica sobre as linhas antes de enviar:
    *
    *   1) "Select * From crLocaltotal Where Checks = 1"  -> tem de haver ao
    *      menos UMA linha marcada;
    *   2) "If IsEmpty(crLocaltotal2.emails) / Loop"      -> das marcadas, ao
    *      menos UMA precisa ter e-mail preenchido.
    *
    * No legado esses dois criterios sao silenciosos: com nenhuma linha marcada
    * (ou com todas as marcadas sem e-mail) o SCAN nao executa nenhuma
    * iteracao, "llOk" continua .T. e a tela exibe "Email enviado com sucesso!"
    * e se fecha - sem ter enviado nada. Este metodo existe para NAO reproduzir
    * esse ponto: CLAUDE.md #20 (falha de gravacao nunca e' muda) e a regra de
    * nunca anunciar sucesso quando nao houve o que processar. O desvio e'
    * deliberado, cobre so a mensagem/aborto e esta registrado no cabecalho.
    *
    * Retorna .T. quando ha o que enviar; .F. (com MsgAviso ja exibido e foco
    * devolvido a grade) quando nao ha.
    *
    * PUBLIC - tambem e' chamado de fora pelo harness de teste (CLAUDE.md #3).
    *--------------------------------------------------------------------------
    FUNCTION ValidarEnvio()
        LOCAL loc_lValido, loc_nMarcadas, loc_nComEmail, loc_nRegAtual, loc_oErro

        loc_lValido  = .F.
        loc_nMarcadas = 0
        loc_nComEmail = 0

        TRY
            IF !USED("cursor_4c_Dados")
                MsgAviso("Nenhum dado carregado para envio.", ;
                         "Processamento de Email")
            ELSE
                *-- Preserva a linha corrente: a grade continua posicionada
                *-- onde o usuario estava depois da conferencia.
                SELECT cursor_4c_Dados
                loc_nRegAtual = IIF(RECCOUNT() > 0, RECNO(), 0)

                SCAN
                    IF NVL(cursor_4c_Dados.Checks, 0) = 1
                        loc_nMarcadas = loc_nMarcadas + 1

                        IF !EMPTY(ALLTRIM(TratarNulo(cursor_4c_Dados.Emails, "")))
                            loc_nComEmail = loc_nComEmail + 1
                        ENDIF
                    ENDIF
                ENDSCAN

                IF loc_nRegAtual > 0 AND loc_nRegAtual <= RECCOUNT()
                    GO loc_nRegAtual IN cursor_4c_Dados
                ENDIF

                DO CASE
                CASE loc_nMarcadas = 0
                    MsgAviso("Nenhum destinat" + CHR(225) + "rio selecionado." + CHR(13) + ;
                             "Marque ao menos um e-mail para envio.", ;
                             "Processamento de Email")

                CASE loc_nComEmail = 0
                    MsgAviso("Nenhuma das linhas marcadas tem e-mail preenchido." + CHR(13) + ;
                             "Informe o e-mail na coluna Email ou marque outra linha.", ;
                             "Processamento de Email")

                OTHERWISE
                    loc_lValido = .T.
                ENDCASE

                IF !loc_lValido AND TYPE("THIS.grd_4c_Dados") = "O"
                    THIS.grd_4c_Dados.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lValido = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprema.ValidarEnvio")
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * HeaderContasClick / HeaderRclisClick / HeaderEmailsClick - Reordenam o
    * cursor de trabalho pelo TAG correspondente, equivalente ao PROCEDURE
    * Click dos headers das colunas Conta/Nome/Email no legado. PUBLIC (alvo
    * de BINDEVENT).
    *--------------------------------------------------------------------------
    PROCEDURE HeaderContasClick()
        THIS.this_oBusinessObject.OrdenarPorColuna("Contas")
        THIS.AtualizarDestaqueColunaOrdenada("Contas")
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE HeaderRclisClick()
        THIS.this_oBusinessObject.OrdenarPorColuna("Rclis")
        THIS.AtualizarDestaqueColunaOrdenada("Rclis")
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE HeaderEmailsClick()
        THIS.this_oBusinessObject.OrdenarPorColuna("Emails")
        THIS.AtualizarDestaqueColunaOrdenada("Emails")
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Monta os controles standalone do legado (nenhum deles
    * fica dentro de um container no SCX original): Shape1 (decorativo),
    * btnEmail, SelTudo (Marcar Todos), apaga (Desmarcar Todos) e Commandgroup1
    * (botao unico "Encerrar"). Todas as posicoes/tamanhos/icones sao os
    * valores EXATOS do SCX legado (PILAR 1).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            *-- Shape decorativo em torno do bloco Encerrar/Enviar Email (Shape1)
            THIS.AddObject("shp_4c_Decoracao", "Shape")
            WITH THIS.shp_4c_Decoracao
                .Top           = 7
                .Left          = 804
                .Width         = 90
                .Height        = 110
                .BackStyle     = 0
                .BorderStyle   = 0
                .BorderWidth   = 1
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 189, 188)
                .Visible       = .T.
            ENDWITH

            *-- Enviar Email (legado btnEmail)
            THIS.AddObject("cmd_4c_EnviarEmail", "CommandButton")
            WITH THIS.cmd_4c_EnviarEmail
                .Top             = 3
                .Left            = 850
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Caption         = "Enviar Email"
                .ToolTipText     = "Enviar Email"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
                .Themes          = .T.
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_EnviarEmail, "Click", THIS, "BtnProcessarEmailClick")

            *-- Marcar Todos (legado SelTudo)
            THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
            WITH THIS.cmd_4c_SelTudo
                .Top             = 84
                .Left            = 4
                .Width           = 40
                .Height          = 40
                .FontName        = "Verdana"
                .FontSize        = 8
                .WordWrap        = .T.
                .Caption         = ""
                .TabStop         = .F.
                .ToolTipText     = "Marcar Todos"
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                .Themes          = .T.
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")

            *-- Desmarcar Todos (legado apaga)
            THIS.AddObject("cmd_4c_Apaga", "CommandButton")
            WITH THIS.cmd_4c_Apaga
                .Top             = 84
                .Left            = 43
                .Width           = 40
                .Height          = 40
                .FontName        = "Verdana"
                .FontSize        = 8
                .WordWrap        = .T.
                .Caption         = ""
                .TabStop         = .F.
                .ToolTipText     = "Desmarcar Todos"
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Themes          = .T.
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Visible         = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")

            *-- Encerrar (legado Commandgroup1/btnSair)
            THIS.AddObject("cmg_4c_Encerrar", "CommandGroup")
            WITH THIS.cmg_4c_Encerrar
                .Top           = -2
                .Left          = 920
                .Width         = 85
                .Height        = 85
                .ButtonCount   = 1
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 189, 188)
                .Themes        = .F.

                WITH .Buttons(1)
                    .Top         = 5
                    .Left        = 5
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Comic Sans MS"
                    .FontSize    = 8
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .Cancel      = .T.
                    .Caption     = "Encerrar"
                    .ToolTipText = "[Esc] Encerrar"
                    .ForeColor   = RGB(90, 90, 90)
                    .BackColor   = RGB(255, 255, 255)
                    .Themes      = .F.
                ENDWITH

                .Visible = .T.
            ENDWITH
            BINDEVENT(THIS.cmg_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprema.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelTudoClick / BtnApagaClick - Marcam/desmarcam todas as linhas do
    * cursor de trabalho (equivalente ao Click dos botoes SelTudo/apaga do
    * legado). PUBLIC (alvo de BINDEVENT).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelTudoClick()
        THIS.this_oBusinessObject.MarcarTodos()
        THIS.Refresh()
    ENDPROC

    PROCEDURE BtnApagaClick()
        THIS.this_oBusinessObject.DesmarcarTodos()
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha a tela (equivalente ao PROCEDURE btnSair.Click
    * do Commandgroup1 legado). PUBLIC (alvo de BINDEVENT). Nomeado com o
    * prefixo Btn (e nao Cmg, do objeto cmg_4c_Encerrar) para ficar consistente
    * com os demais handlers de botao deste form (BtnSelTudoClick/BtnApagaClick/
    * BtnProcessarEmailClick).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        LPARAMETERS par_nIndicePressionado

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarEmailClick - Dispara o envio dos e-mails marcados (equivalente
    * ao PROCEDURE Click do btnEmail legado). Toda a logica de envio (contas
    * SMTP, laco pelos selecionados, log) ja esta em
    * sigpremaBO.EnviarEmailSelecionados - este handler so aciona e trata o
    * retorno, igual ao legado (fecha a tela em caso de sucesso e sempre que a
    * tela estiver em modo automatico). PUBLIC (alvo de BINDEVENT).
    *
    * this_cArquivoEmail fica vazio porque a geracao do PDF anexo (equivalente
    * ao ImpDocto do legado) depende de relatorios fora do escopo desta
    * migracao - ver cabecalho de sigpremaBO.prg.
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarEmailClick()
        LOCAL loc_lOk

        loc_lOk = .F.

        *-- Conferencia previa: sem linha marcada (ou sem nenhuma marcada com
        *-- e-mail preenchido) nao ha o que enviar - pular o envio aqui evita
        *-- que a tela anuncie "Email enviado com sucesso!" sem ter enviado
        *-- nada. Ver comentario de ValidarEnvio (desvio deliberado do legado).
        IF THIS.ValidarEnvio()
            THIS.this_oBusinessObject.this_cArquivoEmail = ""

            loc_lOk = THIS.this_oBusinessObject.EnviarEmailSelecionados()

            IF loc_lOk
                WAIT WINDOW "Email enviado com sucesso!" TIMEOUT 2
                THIS.Release()
            ENDIF
        ENDIF

        *-- FORA do IF acima, de proposito: no legado o "If Thisform.automatico
        *-- / thisform.Release()" e' incondicional - a tela chamada em modo
        *-- automatico SEMPRE se fecha, tenha enviado ou nao. Condicionar este
        *-- release a validacao deixaria o processo automatico preso numa tela
        *-- aberta que ninguem vai fechar.
        IF THIS.this_lAutomatico
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis todos os controles do form,
    * percorrendo containers e paginas de PageFrame recursivamente. AddObject
    * cria controles com Visible=.F. por padrao.
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o Business Object (que por sua vez libera os cursores
    * de trabalho abertos - ver sigpremaBO.Destroy)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpremaBO.prg):
*==============================================================================
* SIGPREMABO.PRG
* Business Object do formulario Formsigprema (Processamento e Geracao de Email)
* Responsabilidade: montar a lista de e-mails a enviar (movimentos
* de SigMvCab cruzados com SigCdCli e com os contatos padrao de SigCdPam),
* gerar o PDF do documento (via ImpDocto) e disparar o envio (via CDO.Message)
* usando os dados de conta de e-mail cadastrados em SigCdEmp.
*
* SIGPREMA nao tem uma unica tabela/CRUD associada no legado: o Init monta um
* cursor de trabalho (crLocalTotal) a partir de VARIAS consultas (SigMvCab +
* SigCdCli + SigCdPam), e os botoes da tela operam sobre esse cursor em lote.
* Por isso this_cTabela e this_cCampoChave permanecem vazios - nao ha um
* unico registro/PK sendo editado, e sim uma lista de linhas selecionaveis
* identificadas pela chave posicional EmpDopNums (Emps char(3) + Dopes
* char(20) + Str(Numes,6) = 29 chars - ver regra da chave posicional,
* CLAUDE.md Erro177: NUNCA aplicar ALLTRIM nas partes ao montar/comparar essa
* chave, so na chave inteira ja montada).
*
* BO SOMENTE-LEITURA - POR QUE NAO HA Inserir() / Atualizar() PROPRIOS
* --------------------------------------------------------------------
* Varredura do dump legado (tasks\task602\sigprema_form_codigo_fonte.txt):
* o form NAO grava em tabela nenhuma do SQL Server. Os unicos Insert Into /
* Replace do legado (linhas 829, 870, 1004, 1115, 1133) tem por destino o
* CURSOR LOCAL crLocalTotal; todo acesso remoto eh de LEITURA (SqlExecute
* com Select, e cursorquery). SigOpLog aparece so dentro do
* "not in (select Transacaos from sigoplog ...)" do Init - eh lido, nunca
* escrito por este form.
*
* Portanto Inserir(), Atualizar() e ExecutarExclusao() NAO sao sobrescritos
* aqui: o comportamento padrao herdado de BusinessBase (recusar a operacao
* e reportar pelo ExibirFalha do Salvar) ja eh o correto para esta tela, e
* escrever INSERT/UPDATE inventado violaria o PILAR 2 e a regra #22 do
* CLAUDE.md (lista de colunas tirada do schema, nunca adivinhada).
*
* O unico ponto do legado que PARECE gravar eh
* "fGravarLog('T', Thisform.Name, [], lcEdn)" (linha 1085). O de-para dos
* argumentos com dbo.SigOpLog nao foi confirmado - o fonte legado de
* fGravarLog nao veio no acervo - entao a chamada segue pelo wrapper
* no-op projeto\app\utils\fgravarlog.prg (mesma decisao documentada la).
* Ver RegistrarLogEnvio() no fim deste arquivo.
*==============================================================================

DEFINE CLASS sigpremaBO AS BusinessBase

    *-- Parametros recebidos pelo Init do form legado (prDopes, pAuto)
    this_cDopes         = ""    && prDopes - EmpDopNums usado para filtrar um unico movimento (vazio = processa todos os movimentos do dia ainda nao enviados)
    this_lAutomatico    = .F.   && pAuto - .T. quando a tela eh chamada em modo automatico (dispara o envio e fecha sozinha)
    this_cEmpresa       = ""    && Thisform.lcEmp - Substr(prDopes,1,3), codigo da empresa do movimento filtrado
    this_nTempo         = 5000  && Thisform.ntempo - timeout (ms) usado nos MessageBox/Wait Window do legado
    this_cEscolha       = ""    && Thisform.pcEscolha
    this_cArquivoEmail  = ""    && Thisform.pcArqEmail - caminho do PDF gerado para anexar ao e-mail

    *-- Intervalo de datas usado para buscar os movimentos do dia (pDti/pDtf)
    this_dDataInicial   = {}
    this_dDataFinal     = {}

    *-- Campos da linha corrente do cursor de trabalho crLocalTotal
    this_nChecks        = 0     && Checks N(1) - .T./1 quando a linha esta marcada para envio
    this_cGrupos        = ""    && grupos C(10)
    this_cContas        = ""    && Contas C(10) - codigo do cliente (SigCdCli.Iclis)
    this_cRclis         = ""    && Rclis C(50) - razao social/nome do cliente (ver CREATE CURSOR em BuscarDadosProcessamento)
    this_cEmails        = ""    && emails C(50)
    this_cMensagens     = ""    && mensagems M (memo)
    this_cEmpDopNums    = ""    && EmpDopNums C(29) - chave posicional Emps(3)+Dopes(20)+Str(Numes,6)
    this_cPrioridade    = ""    && prioridade C(15) - "NORMAL" por padrao

    *-- Dados da conta de e-mail da empresa (SigCdEmp), usados para disparar o envio
    this_cRemetente     = ""    && TmpEmpMail.PadEmails
    this_cServidorSmtp  = ""    && TmpEmpMail.PadServs
    this_cSenhaSmtp     = ""    && TmpEmpMail.PadSenhas
    this_nPortaSmtp     = 0     && TmpEmpMail.PadPortas

    *-- Parametros de um envio individual de e-mail (equivalentes ao PROCEDURE memail do legado)
    this_cDestinatario  = ""    && tcTo
    this_cCopia         = ""    && tcCC
    this_cAssunto       = ""    && tcAssunto
    this_cCorpo         = ""    && tcCorpo
    this_cAnexo         = ""    && tcAnexo

    *-- Alias do cursor de trabalho com a lista de e-mails a enviar
    *-- (equivalente a crLocalTotal do legado)
    this_cCursorDados   = "cursor_4c_Dados"

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- SIGPREMA nao tem tabela/PK unica associada (ver cabecalho do arquivo)
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        DODEFAULT()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - SIGPREMA nao tem PK unica (ver cabecalho do
    * arquivo); devolve a chave posicional EmpDopNums da linha corrente do
    * cursor de trabalho, que eh o mais proximo de uma "identidade" que este
    * BO tem. RegistrarAuditoria() da base ja aborta sozinha quando a chave
    * vem vazia, entao nao ha auditoria indevida por causa disso.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveEmpDopNums - Monta a chave posicional EmpDopNums char(29) =
    * Emps char(3) + Dopes char(20) + Str(Numes,6).
    *
    * CLAUDE.md Erro177: a chave eh POSICIONAL - NUNCA aplicar ALLTRIM nas
    * PARTES antes de concatenar (o padding faz parte da chave e o SELECT
    * que compara essa chave passa a devolver ZERO linhas em silencio). So a
    * chave INTEIRA, ja montada, pode levar ALLTRIM com seguranca.
    *--------------------------------------------------------------------------
    PROCEDURE MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(par_cEmps, 3) + PADR(par_cDopes, 20) + STR(par_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades this_* a partir da linha
    * corrente do cursor de trabalho (this_cCursorDados / cursor_4c_Dados)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_nChecks     = NVL(Checks, 0)
                THIS.this_cGrupos     = TratarNulo(Grupos, "")
                THIS.this_cContas     = TratarNulo(Contas, "")
                THIS.this_cRclis      = TratarNulo(Rclis, "")
                THIS.this_cEmails     = TratarNulo(Emails, "")
                THIS.this_cMensagens  = TratarNulo(Mensagens, "")
                THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "")
                THIS.this_cPrioridade = TratarNulo(Prioridade, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigpremaBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDadosProcessamento - Monta this_cCursorDados (cursor_4c_Dados,
    * equivalente a crLocalTotal do legado) com a lista de e-mails a enviar.
    *
    * par_cDopes vazio -> processa TODOS os movimentos do dia ainda nao
    *   registrados em SigOpLog para o programa SIGPREMA (equivalente ao
    *   "Empty(prDopes)" do Init legado).
    * par_cDopes = EmpDopNums completo (29 chars) -> processa so aquele
    *   movimento (equivalente ao Else do Init legado).
    *
    * Retorna .T. se o carregamento foi bem-sucedido.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarDadosProcessamento(par_cDopes)
        LOCAL loc_lSucesso, loc_lAbortar, loc_cSQL, loc_cDopesLimpo
        LOCAL loc_nChecksPam, loc_cGruposPam, loc_cContasPam, loc_cRclisPam, loc_cEmailsPam

        loc_lSucesso = .F.
        loc_lAbortar = .F.

        TRY
            THIS.this_cDopes = TratarNulo(par_cDopes, "")
            loc_cDopesLimpo  = ALLTRIM(THIS.this_cDopes)

            IF !EMPTY(loc_cDopesLimpo)
                THIS.this_cEmpresa = SUBSTR(loc_cDopesLimpo, 1, 3)
            ENDIF

            *-- Janela do dia corrente (equivalente a pDti/pDtf do legado)
            THIS.this_dDataInicial = DATETIME()
            THIS.this_dDataFinal   = DATETIME(YEAR(DATE()), MONTH(DATE()), DAY(DATE()), 23, 59, 59)

            *-- Recria o cursor de trabalho (equivalente ao Create Cursor crLocalTotal)
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorDados) ;
                (Checks N(1) NULL, Grupos C(10) NULL, Contas C(10) NULL, ;
                 Rclis C(50) NULL, Emails C(50) NULL, Mensagens M NULL, ;
                 EmpDopNums C(29) NULL, Prioridade C(15) NULL)
            SET NULL OFF

            INDEX ON Contas TAG Contas
            INDEX ON Rclis  TAG Rclis
            INDEX ON Emails TAG Emails

            *-- Cabecalho dos movimentos (SigMvCab + SigCdCli)
            IF USED("cursor_4c_TmpMvCab")
                USE IN cursor_4c_TmpMvCab
            ENDIF

            IF EMPTY(loc_cDopesLimpo)
                loc_cSQL = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, b.Rclis, b.Emails, b.Grupos, b.Iclis " + ;
                           "FROM SigMvCab a " + ;
                           "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                           "WHERE a.Datatrans BETWEEN " + FormatarDataSQL(THIS.this_dDataInicial) + ;
                           " AND " + FormatarDataSQL(THIS.this_dDataFinal) + " " + ;
                           "AND a.EmpDopNums NOT IN (SELECT Transacaos FROM SigOpLog WHERE Progs = 'SIGPREMA') " + ;
                           "ORDER BY a.EmpDopNums"
            ELSE
                loc_cSQL = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, b.Rclis, b.Emails, b.Grupos, b.Iclis " + ;
                           "FROM SigMvCab a " + ;
                           "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                           "WHERE a.EmpDopNums = " + EscaparSQL(loc_cDopesLimpo)
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMvCab") < 1
                MsgErro("Favor reinicializar o processo!!!" + CHR(13) + ;
                        "Falha na conex" + CHR(227) + "o (TmpMvCab).", "Erro")
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar
                *-- Grava os dados no cursor de trabalho para envio dos e-mails
                SELECT cursor_4c_TmpMvCab
                GO TOP
                SCAN
                    INSERT INTO (THIS.this_cCursorDados) ;
                        (Checks, Grupos, Contas, Rclis, Emails, Prioridade, EmpDopNums) ;
                        VALUES ;
                        (cursor_4c_TmpMvCab.Checks, cursor_4c_TmpMvCab.Grupos, ;
                         cursor_4c_TmpMvCab.Iclis, cursor_4c_TmpMvCab.Rclis, ;
                         cursor_4c_TmpMvCab.Emails, "NORMAL", cursor_4c_TmpMvCab.EmpDopNums)
                ENDSCAN

                *-- Contas do grupo parametrizado em SigCdPam (grpadats)
                IF USED("cursor_4c_LocalPAM")
                    USE IN cursor_4c_LocalPAM
                ENDIF

                loc_cSQL = "SELECT 0 AS Checks, c.Grupos, c.Iclis AS Contas, c.Rclis, c.Emails, '' AS Prioridade " + ;
                           "FROM SigCdPam p " + ;
                           "INNER JOIN SigCdCli c ON c.Grupos = p.Grpadats"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPAM") < 1
                    MsgErro("Favor reinicializar o processo!!!" + CHR(13) + ;
                            "Falha na conex" + CHR(227) + "o (SigCdPam).", "Erro")
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortar
                *-- Adiciona os destinatarios do grupo parametrizado, filtrando
                *-- por Job quando o cliente tem restricao em SigClJob, e sem
                *-- duplicar quem ja foi inserido a partir do movimento
                SELECT cursor_4c_LocalPAM
                SCAN
                    IF USED("cursor_4c_TmpClJob")
                        USE IN cursor_4c_TmpClJob
                    ENDIF

                    loc_cSQL = "SELECT Jobs FROM SigClJob WHERE Iclis = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_LocalPAM.Contas))

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpClJob") < 1
                        MsgErro("Favor reinicializar o processo!!!" + CHR(13) + ;
                                "Falha na conex" + CHR(227) + "o (TmpClJob).", "Erro")
                        loc_lAbortar = .T.
                        EXIT
                    ENDIF

                    SELECT cursor_4c_TmpClJob
                    GO TOP
                    IF !EOF()
                        LOCATE FOR ALLTRIM(Jobs) = ALLTRIM(cursor_4c_TmpMvCab.Jobs)
                        IF EOF()
                            SELECT cursor_4c_LocalPAM
                            LOOP
                        ENDIF
                    ENDIF

                    loc_nChecksPam = cursor_4c_LocalPAM.Checks
                    loc_cGruposPam = ""
                    loc_cContasPam = ALLTRIM(cursor_4c_LocalPAM.Contas)
                    loc_cRclisPam  = ALLTRIM(cursor_4c_LocalPAM.Rclis)
                    loc_cEmailsPam = ALLTRIM(cursor_4c_LocalPAM.Emails)

                    SELECT (THIS.this_cCursorDados)
                    LOCATE FOR ALLTRIM(Contas) = loc_cContasPam AND ALLTRIM(Rclis) = loc_cRclisPam
                    IF EOF()
                        INSERT INTO (THIS.this_cCursorDados) ;
                            (Checks, Grupos, Contas, Rclis, Emails, EmpDopNums, Prioridade) ;
                            VALUES ;
                            (loc_nChecksPam, loc_cGruposPam, loc_cContasPam, loc_cRclisPam, ;
                             loc_cEmailsPam, THIS.this_cDopes, "NORMAL")
                    ENDIF

                    SELECT cursor_4c_LocalPAM
                ENDSCAN
            ENDIF

            IF !loc_lAbortar
                *-- Ordena por nome, igual ao legado (column3.header1.Click no Init)
                THIS.OrdenarPorColuna("Rclis")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigpremaBO.BuscarDadosProcessamento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodos - Marca todas as linhas do cursor de trabalho (Checks = 1),
    * equivalente ao botao SelTudo do legado
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodos()
        IF USED(THIS.this_cCursorDados)
            SELECT (THIS.this_cCursorDados)
            GO TOP
            REPLACE ALL Checks WITH 1
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todas as linhas do cursor de trabalho
    * (Checks = 0), equivalente ao botao apaga (Desmarcar Todos) do legado
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        IF USED(THIS.this_cCursorDados)
            SELECT (THIS.this_cCursorDados)
            GO TOP
            REPLACE ALL Checks WITH 0
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OrdenarPorColuna - Reordena o cursor de trabalho pelo TAG solicitado,
    * equivalente ao Click dos headers de coluna do grid legado.
    * par_cTag: "Contas" | "Rclis" | "Emails"
    *--------------------------------------------------------------------------
    PROCEDURE OrdenarPorColuna(par_cTag)
        IF USED(THIS.this_cCursorDados)
            SELECT (THIS.this_cCursorDados)
            DO CASE
            CASE UPPER(ALLTRIM(par_cTag)) = "CONTAS"
                SET ORDER TO TAG Contas
            CASE UPPER(ALLTRIM(par_cTag)) = "RCLIS"
                SET ORDER TO TAG Rclis
            CASE UPPER(ALLTRIM(par_cTag)) = "EMAILS"
                SET ORDER TO TAG Emails
            ENDCASE
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDadosContaEmail - Busca a conta de e-mail (SMTP) parametrizada
    * para a empresa em SigCdEmp e popula this_cRemetente/this_cServidorSmtp/
    * this_cSenhaSmtp/this_nPortaSmtp (equivalente a consulta a TmpEmpMail no
    * PROCEDURE Click do btnEmail legado). par_cCodEmpresa deve vir de
    * go_4c_Sistema.cCodEmpresa - NUNCA da legada _Empr.
    *--------------------------------------------------------------------------
    PROCEDURE ObterDadosContaEmail(par_cCodEmpresa)
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_TmpEmpMail")
                USE IN cursor_4c_TmpEmpMail
            ENDIF

            loc_cSQL = "SELECT PadEmails, PadServs, PadSenhas, PadPortas " + ;
                       "FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(par_cCodEmpresa))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEmpMail") < 1
                MsgErro("Favor reinicializar o processo!!!" + CHR(13) + ;
                        "Falha na conex" + CHR(227) + "o (TmpEmpMail).", "Erro")
            ELSE
                SELECT cursor_4c_TmpEmpMail
                GO TOP
                IF !EOF()
                    THIS.this_cRemetente    = LOWER(ALLTRIM(TratarNulo(PadEmails, "")))
                    THIS.this_cServidorSmtp = LOWER(ALLTRIM(TratarNulo(PadServs, "")))
                    THIS.this_cSenhaSmtp    = ALLTRIM(TratarNulo(PadSenhas, ""))
                    THIS.this_nPortaSmtp    = NVL(PadPortas, 0)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigpremaBO.ObterDadosContaEmail")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * EnviarEmail - Dispara o envio via CDO.Message (SMTP).
    *
    * DE ONDE VEM ESTE CORPO: o btnEmail.Click legado (linha 1079) chama a
    * funcao GLOBAL EnviaEmail(...), que NAO veio no acervo (nao esta em
    * Framework\sigacess.PRG nem em lugar nenhum do dump). O que veio foi o
    * PROCEDURE memail do proprio SCX (linha 695) - mesma rotina CDO, com a
    * ordem dos argumentos diferente - e memail nunca eh chamado no legado
    * (a unica outra mencao, linha 1163, esta comentada). Este metodo eh a
    * transcricao do corpo de memail, que eh a melhor evidencia disponivel
    * do que EnviaEmail faz.
    *
    * Por isso NAO se cria wrapper utils\enviaemail.prg (regra #27 do
    * CLAUDE.md): a chamada mora no codigo do FORM, que estamos migrando -
    * ela eh substituida por este metodo, nao redirecionada.
    *
    * De-para dos argumentos, conferido contra a chamada legada
    * EnviaEmail(lcReceptor, lcTxtMensagem, lcAssunto, lcArqAnexo, lcFrom,
    *            lcReceptorCopia, lcServer, lcSenha, lnPorta):
    *   lcReceptor      -> par_cPara        lcFrom   -> par_cRemetente
    *   lcReceptorCopia -> par_cCopia       lcServer -> par_cServidor
    *   lcAssunto       -> par_cAssunto     lcSenha  -> par_cSenha
    *   lcTxtMensagem   -> par_cCorpo       lnPorta  -> par_nPorta
    *   lcArqAnexo      -> par_cAnexo
    *
    * Retorna .T. se o e-mail foi enviado com sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE EnviarEmail(par_cPara, par_cCopia, par_cAssunto, par_cCorpo, ;
                          par_cAnexo, par_cRemetente, par_cServidor, ;
                          par_cSenha, par_nPorta)
        LOCAL loc_lOk, loc_lEnvioOk, loc_oEmail

        loc_lOk      = .F.
        loc_lEnvioOk = .T.

        TRY
            IF TYPE('CREATEOBJECT("CDO.Message")') != "O"
                MsgAviso("Problemas para instanciar o objeto CDO.Message.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_oEmail = CREATEOBJECT("CDO.Message")

                WITH loc_oEmail.Configuration.Fields
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusing")            = 2
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver")            = LOWER(par_cServidor)
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport")        = IIF(par_nPorta = 0, 25, par_nPorta)
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate")      = 1
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusername")          = LOWER(par_cRemetente)
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword")          = par_cSenha
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl")            = IIF(par_nPorta = 465, 1, 0)
                    .Update()
                ENDWITH

                WITH loc_oEmail
                    .To       = LOWER(par_cPara)
                    .Cc       = LOWER(NVL(par_cCopia, ""))
                    .From     = LOWER(par_cRemetente)
                    .Subject  = ALLTRIM(par_cAssunto)
                    .TextBody = ALLTRIM(par_cCorpo)

                    IF !EMPTY(par_cAnexo)
                        IF FILE(par_cAnexo)
                            .AddAttachment(par_cAnexo)
                        ELSE
                            loc_lEnvioOk = .F.
                            MsgAviso("N" + CHR(227) + "o foi encontrado o arquivo:" + CHR(13) + ;
                                     par_cAnexo + CHR(13) + "para ser anexado.", ;
                                     "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                    ENDIF

                    IF loc_lEnvioOk
                        TRY
                            .Send()
                            loc_lOk = .T.
                        CATCH TO loc_oErroEnvio
                            *-- O legado NAO fica calado aqui: o Catch do
                            *-- PROCEDURE memail avisa com
                            *-- Wait Window "Dados do e-mail invalidos." TimeOut 5.
                            *-- Transcrito como WAIT WINDOW ... TIMEOUT 5 para
                            *-- manter o aviso sem travar o envio em lote (o
                            *-- SCAN do chamador continua nos demais
                            *-- destinatarios), e CLAUDE.md #9 (CATCH nunca
                            *-- silencioso) fica atendido.
                            WAIT WINDOW "Dados do e-mail inv" + CHR(225) + "lidos." TIMEOUT 5
                            loc_lOk = .F.
                        ENDTRY
                    ENDIF
                ENDWITH

                loc_oEmail = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigpremaBO.EnviarEmail")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarLogEnvio - Registra o envio do movimento no log do sistema.
    *
    * fGravarLog (utils\fgravarlog.prg) eh um WRAPPER NO-OP INTENCIONAL: o
    * de-para real dos argumentos com SigOpLog nao foi confirmado contra o
    * fonte legado (ver cabecalho do proprio wrapper) - gravar direto em
    * SigOpLog com um de-para adivinhado seria a exata invencao que a regra
    * #17 do CLAUDE.md proibe. O legado tambem descarta o retorno da chamada
    * (`fGravarLog('T', Thisform.Name, [], lcEdn)` sem `=`), entao manter o
    * no-op aqui reproduz o comportamento observavel (o envio nao fica
    * marcado como processado em SigOpLog, igual ao legado).
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarLogEnvio(par_cEmpDopNums)
        RETURN fGravarLog("T", "Formsigprema", "", par_cEmpDopNums)
    ENDPROC

    *--------------------------------------------------------------------------
    * EnviarEmailSelecionados - Envia o e-mail para os destinatarios marcados
    * (Checks = 1) em this_cCursorDados, equivalente ao PROCEDURE Click do
    * btnEmail legado. A conta de envio vem de go_4c_Sistema.cCodEmpresa
    * (equivalente a _Empr legada - CLAUDE.md: NUNCA usar _EMPR).
    *
    * this_cArquivoEmail deve ser preenchido pelo chamador (Form) ANTES de
    * chamar este metodo, com o caminho do PDF a anexar, quando aplicavel -
    * a geracao do anexo (equivalente ao ImpDocto do legado, que aciona os
    * relatorios SigPrIdc/SigReIfx/SigOpIgm) depende de rotinas de impressao
    * do legado fora do escopo desta migracao e fica a cargo do Form.
    *
    * Reproduz o comportamento do legado de enviar UM e-mail POR
    * destinatario marcado (o destinatario principal fica fixo no primeiro
    * marcado e os demais entram como copia, cumulativamente) - nao eh um
    * envio unico em lote.
    *
    * Retorna .T. se o ULTIMO envio realizado teve sucesso (mesmo criterio
    * do llOk do legado, que eh reiniciado a cada iteracao do Scan).
    *--------------------------------------------------------------------------
    PROCEDURE EnviarEmailSelecionados()
        LOCAL loc_lOk, loc_cReceptor, loc_cReceptorCopia
        LOCAL loc_cAssunto, loc_cTxtMensagem, loc_cArqAnexo, loc_cEdn

        loc_lOk = .F.

        TRY
            IF !USED(THIS.this_cCursorDados)
                MsgAviso("Nenhum dado carregado para envio.", "Processamento de Email")
            ELSE
                IF !THIS.ObterDadosContaEmail(go_4c_Sistema.cCodEmpresa)
                    *-- erro ja exibido em ObterDadosContaEmail
                ELSE
                    IF USED("cursor_4c_Selecionados")
                        USE IN cursor_4c_Selecionados
                    ENDIF

                    SELECT * FROM (THIS.this_cCursorDados) WHERE Checks = 1 ;
                        INTO CURSOR cursor_4c_Selecionados READWRITE

                    SELECT cursor_4c_Selecionados

                    IF RECCOUNT() = 0
                        MsgAviso("Nenhum destinat" + CHR(225) + "rio selecionado." + CHR(13) + ;
                                 "Marque ao menos um e-mail para envio.", "Processamento de Email")
                    ELSE
                        loc_cReceptor      = ""
                        loc_cReceptorCopia = ""
                        loc_cAssunto       = ""
                        loc_cTxtMensagem   = ""

                        SELECT cursor_4c_Selecionados
                        SCAN
                            IF EMPTY(ALLTRIM(TratarNulo(cursor_4c_Selecionados.Emails, "")))
                                LOOP
                            ENDIF

                            loc_cEdn = cursor_4c_Selecionados.EmpDopNums

                            *-- Transcricao literal do legado: quem vira
                            *-- destinatario PRINCIPAL eh o registro de
                            *-- RECNO() = 1, nao "o primeiro com e-mail
                            *-- preenchido". A diferenca aparece quando a 1a
                            *-- linha marcada esta sem e-mail: o LOOP acima a
                            *-- descarta ANTES deste teste, entao nenhuma
                            *-- linha assume o To e o envio sai com
                            *-- destinatario vazio (as demais entram como
                            *-- copia). Comportamento do legado - NAO
                            *-- "corrigir" aqui (CLAUDE.md #17: transcrever,
                            *-- nunca reescrever a regra do legado).
                            IF RECNO() = 1
                                loc_cReceptor    = ALLTRIM(cursor_4c_Selecionados.Emails)
                                loc_cTxtMensagem = TratarNulo(cursor_4c_Selecionados.Mensagens, "")
                                loc_cAssunto     = ""
                            ELSE
                                IF !EMPTY(ALLTRIM(cursor_4c_Selecionados.Emails))
                                    loc_cReceptorCopia = loc_cReceptorCopia + ;
                                        IIF(EMPTY(loc_cReceptorCopia), "", ",") + ;
                                        ALLTRIM(cursor_4c_Selecionados.Emails)
                                ENDIF
                            ENDIF

                            loc_cArqAnexo = THIS.this_cArquivoEmail

                            WAIT WINDOW CHR(13) + "Aguarde... gerando EMAIL" NOWAIT NOCLEAR

                            loc_lOk = THIS.EnviarEmail(loc_cReceptor, loc_cReceptorCopia, ;
                                loc_cAssunto, loc_cTxtMensagem, loc_cArqAnexo, ;
                                THIS.this_cRemetente, THIS.this_cServidorSmtp, ;
                                THIS.this_cSenhaSmtp, THIS.this_nPortaSmtp)

                            WAIT CLEAR

                            IF loc_lOk
                                THIS.RegistrarLogEnvio(loc_cEdn)
                            ENDIF

                            SELECT cursor_4c_Selecionados
                        ENDSCAN
                    ENDIF

                    IF USED("cursor_4c_Selecionados")
                        USE IN cursor_4c_Selecionados
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigpremaBO.EnviarEmailSelecionados")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera os cursores de trabalho abertos por este BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("cursor_4c_TmpMvCab")
            USE IN cursor_4c_TmpMvCab
        ENDIF
        IF USED("cursor_4c_LocalPAM")
            USE IN cursor_4c_LocalPAM
        ENDIF
        IF USED("cursor_4c_TmpClJob")
            USE IN cursor_4c_TmpClJob
        ENDIF
        IF USED("cursor_4c_TmpEmpMail")
            USE IN cursor_4c_TmpEmpMail
        ENDIF
        IF USED("cursor_4c_Selecionados")
            USE IN cursor_4c_Selecionados
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

