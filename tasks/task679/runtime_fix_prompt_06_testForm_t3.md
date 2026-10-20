# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 3/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-10-19 18:44:53] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-19 18:44:53] [INFO] Config FPW: (nao fornecido)
[2026-10-19 18:44:53] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-19 18:44:53] [INFO] Timeout: 300 segundos
[2026-10-19 18:44:53] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fvc5p0ju.prg
[2026-10-19 18:44:53] [INFO] Conteudo do wrapper:
[2026-10-19 18:44:53] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGPRSTF', 'C:\4c\tasks\task679\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRSTF', 'C:\4c\tasks\task679\logs\06_testForm.log'
QUIT

[2026-10-19 18:44:53] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fvc5p0ju.prg
[2026-10-19 18:44:53] [INFO] VFP output esperado em: C:\4c\tasks\task679\vfp_output.txt
[2026-10-19 18:44:53] [INFO] Executando Visual FoxPro 9...
[2026-10-19 18:44:53] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fvc5p0ju.prg
[2026-10-19 18:44:53] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fvc5p0ju.prg
[2026-10-19 18:44:53] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGPRSTF
Inicio: 19/10/2026 18:44:54

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 19/10/2026 18:48:13
Duracao: 199 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-19 18:48:13] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-19 18:48:13] [INFO] VFP9 finalizado em 199.672198 segundos
[2026-10-19 18:48:13] [INFO] Exit Code: 
[2026-10-19 18:48:13] [INFO] 
[2026-10-19 18:48:13] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-19 18:48:13] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fvc5p0ju.prg
[2026-10-19 18:48:13] [INFO] 
[2026-10-19 18:48:13] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-19 18:48:13] [INFO] * Auto-generated wrapper for parameters
[2026-10-19 18:48:13] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-19 18:48:13] [INFO] * Parameters: 'FormSIGPRSTF', 'C:\4c\tasks\task679\logs\06_testForm.log'
[2026-10-19 18:48:13] [INFO] 
[2026-10-19 18:48:13] [INFO] * Anti-dialog protections for unattended execution
[2026-10-19 18:48:13] [INFO] SET SAFETY OFF
[2026-10-19 18:48:13] [INFO] SET RESOURCE OFF
[2026-10-19 18:48:13] [INFO] SET TALK OFF
[2026-10-19 18:48:13] [INFO] SET NOTIFY OFF
[2026-10-19 18:48:13] [INFO] SYS(2335, 0)
[2026-10-19 18:48:13] [INFO] 
[2026-10-19 18:48:13] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRSTF', 'C:\4c\tasks\task679\logs\06_testForm.log'
[2026-10-19 18:48:13] [INFO] QUIT
[2026-10-19 18:48:13] [INFO] 
[2026-10-19 18:48:13] [INFO] === Fim do Wrapper.prg ===
[2026-10-19 18:48:13] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRSTF.prg):
*==============================================================================
* FormSIGPRSTF.prg
*
* Senha de Risco (Senha do Supervisor) - form OPERACIONAL
* Legado: SigTfSup.SCX - dialogo modal pequeno (Width=400, Height=200), SEM
* PageFrame nem paginas Lista/Dados: apenas uma faixa de titulo (cntSombra),
* um campo de senha com mascara (SENHA), uma legenda (Label3), um retangulo
* decorativo (Shape1), um container com texto de instrucao (Container1) e um
* unico botao de saida dentro de um CommandGroup (SAIDA). Nao mapeia tabela
* nenhuma: comportamento.json confirma totalMetodos=4, metodosComSQL=0 (ver
* tasks\task679\comportamento.json).
*
* Nomes de objetos seguem tasks\task679\mapeamento.json:
*   cntSombra         -> cnt_4c_Sombra          (fase 3)
*   lblSombra         -> lbl_4c_LblSombra       (fase 3)
*   lblTitulo         -> lbl_4c_LblTitulo       (fase 3)
*   SAIDA             -> obj_4c_SAIDA           (esta fase - CommandGroup,
*                                                 botao de saida/cancelar)
*   Shape1            -> shp_4c_Shape1          (esta fase)
*   GetSenha          -> txt_4c_SenhaSupervisor (esta fase - decorativo,
*                                                 Enabled=.F. no SCX,
*                                                 sobreposto por txt_4c_SENHA;
*                                                 RENOMEADO de txt_4c_Senha
*                                                 para txt_4c_SenhaSupervisor
*                                                 porque "GetSenha"/"SENHA" no
*                                                 legado diferem so na CAIXA -
*                                                 txt_4c_Senha/txt_4c_SENHA
*                                                 colidiriam no VFP9, que
*                                                 resolve nome de membro
*                                                 case-insensitive, e o 2o
*                                                 AddObject estouraria
*                                                 "A member object with this
*                                                 name already exists" dentro
*                                                 do TRY do InicializarForm -
*                                                 o form abriria como .F. e o
*                                                 menu nao faria nada)
*   Label3            -> lbl_4c_Label3          (esta fase)
*   SENHA             -> txt_4c_SENHA           (esta fase - campo real)
*   Container1        -> cnt_4c_Container1      (esta fase)
*   Container1.Label1 -> lbl_4c_Label1          (esta fase)
*
* FASE 3 (estrutura base): o SCX nao tem PageFrame nem paginas Lista/Dados
* (analise.json: temGrid=false; layout.json nao declara PageFrame nenhum) -
* o roteiro generico "PageFrame com Page1 (Lista) e Page2 (Dados)" NAO se
* aplica a este legado; inventar essa UI violaria o PILAR 1 ("NUNCA inventar
* tabelas de lookup/estrutura que nao existem no original"). Aquela fase
* criou so a faixa de titulo (cntSombra), unico elemento estrutural fixo do
* dialogo.
*
* FASE 4 (esta fase): o roteiro generico desta fase ("Grid e botoes CRUD na
* Page1") tambem NAO se aplica - o SigTfSup e um dialogo modal de senha, sem
* lista/grade de registros e sem PageFrame (confirmado em analise.json e
* layout.json, que nao declaram grid nenhum). O trabalho real desta fase e
* completar os objetos que a Fase 3 ainda nao havia criado: o shape decorativo, o
* campo de senha (real + decorativo sobreposto), a legenda, o container do
* texto de instrucao e o CommandGroup de saida/cancelar - com os handlers
* SENHA.KeyPress (ENTER confirma) e CANCELA.Click (cancela), que sao os
* UNICOS eventos de controle que o comportamento.json lista para este form.
*
* FASE 5 (campos principais - "Parte 1" de Page2): o roteiro generico desta
* fase tambem NAO se aplica - o SigTfSup nao tem PageFrame nem Page2 (ver
* FASE 3/4 acima), entao nao ha "metade dos campos de Page2" para acrescentar.
* Este e um layout CAPTURA (dialogo OPERACIONAL que so coleta um valor
* digitado, sem ControlSource/cursor por tras - confirmado no dump: SENHA e
* GetSenha nao declaram ControlSource, e o unico ControlSource do form,
* SAIDA.ControlSource="OPSENHA", e residuo inerte do CommandGroup, sem
* variavel OPSENHA declarada em lugar nenhum nem leitura em metodo algum).
* Os DOIS campos do legado (GetSenha decorativo + SENHA real) ja foram
* transcritos INTEGRALMENTE na Fase 4 (txt_4c_SenhaSupervisor e txt_4c_SENHA
* em ConfigurarCampos acima) - acrescentar campo novo aqui seria inventar
* estrutura que o legado nao tem (viola o PILAR 1 e a regra "NUNCA inventar").
* Nenhuma alteracao funcional nesta fase; apenas este comentario, documentando
* a decisao (mesmo padrao das Fases 3 e 4).
*
* FASE 6 (campos restantes e lookups): o roteiro generico ("ultimos 50% dos
* campos + lookups com AbrirLookupXxx/FormBuscaAuxiliar") tambem NAO se aplica
* - comportamento.json confirma temLookup=false nos 4 metodos do legado, e
* nenhum deles chama fwBuscaExt/fwBuscaSel/fwBuscaInt/sigacess/Acesso*; o
* unico campo DIGITAVEL do dialogo (txt_4c_SENHA) nao tem PROCEDURE Valid no
* legado - a confirmacao (ENTER) e o proprio KeyPress (ver SECAO 3 do dump:
* SigTfSup.SENHA so declara KeyPress, nunca Valid). O trabalho real desta
* fase e so de NOMENCLATURA: o handler que reproduz esse comportamento
* (equivalente ao Valid do campo digitavel, ainda que o legado o combine com
* o KeyPress em vez de separar em evento proprio) segue a convencao canonica
* do projeto, Validar<Campo>, e nao o nome de evento SenhaKeyPress usado nas
* fases anteriores. Renomeado para ValidarSenha nesta fase (mesma logica,
* mesmo BINDEVENT em "KeyPress" - BINDEVENT em "Valid" nao dispara de forma
* confiavel em TextBox, regra #3).
*
* FASE 7 (eventos principais): o roteiro generico ("BtnIncluirClick/
* BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick") tambem NAO se aplica -
* o SigTfSup nao tem CRUD nenhum (Class: form puro, sem frmcadastro, sem
* Grupo_Op, sem pcEscolha - ver SECAO 1/2 do dump): e um dialogo modal de
* senha com UM UNICO botao real (SAIDA, CommandGroup com ButtonCount=1).
* Inventar os 4 botoes CRUD violaria o PILAR 1 ("NUNCA inventar estrutura
* que o legado nao tem") - mesma excecao ja aplicada nas Fases 3/4/5/6.
* O trabalho real desta fase e o handler do unico botao que o legado tem:
* o CommandGroup.Buttons(1).Click (CANCELA, equivalente ao SigTfSup.SAIDA.
* CANCELA.Click do dump) PRECISA de um nome enumeravel pelo gate das fases
* seguintes (convencao Btn<Acao>Click, nao o nome do objeto legado) - por
* isso o handler da Fase 4 (CancelarClick) foi renomeado para
* BtnCancelarClick nesta fase (mesma logica, mesmo BINDEVENT em "Click"),
* e e tambem o nome que a Fase 8 exige nominalmente. ValidarSenha (o
* ENTER do campo de senha) permanece com o nome de validacao de campo -
* nao e um botao e nao faz parte dessa convencao.
*
* FASE 8 (eventos auxiliares e consolidacao final - ESTA FASE): o roteiro
* generico ("BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/BtnCancelarClick,
* FormParaBO/BOParaForm completos, HabilitarCampos, LimparCampos,
* CarregarLista, AjustarBotoesPorModo") e o template do padrao CRUD
* (frmcadastro: Page1=Lista com grid + botoes de busca/navegacao, Page2=
* Dados com Salvar/Cancelar) e NAO se aplica a este dialogo - mesma excecao
* documentada nas Fases 3 a 7, pelos MESMOS motivos (SigTfSup nao tem
* PageFrame, nao tem Page1/Page2, nao tem grid, nao tem tabela propria -
* ver analise.json: temGrid=false; comportamento.json: totalMetodos=4,
* metodosComSQL=0). Os 4 metodos do legado (Init, "Procedure"/RETURN
* (lcSenha), SAIDA.Click, SENHA.KeyPress) ja estao TODOS implementados,
* com paridade 100%, desde as Fases 3 a 7:
*   - Init                    -> InicializarForm/ConfigurarCabecalho/
*                                 ConfigurarCampos/ConfigurarSaida (fase 3/4)
*   - "Procedure" RETURN(lcSenha) -> SIGPRSTFBO.ObterSenha() (fase 1/2) -
*                                 devolve THIS.this_cSenha somente se
*                                 THIS.this_lConfirmou, reproduzindo que o
*                                 RETURN do legado so era alcancado apos o
*                                 ENTER no campo (nunca apos o Cancelar)
*   - SAIDA.CANCELA.Click      -> BtnCancelarClick() (fase 4/7)
*   - SENHA.KeyPress           -> ValidarSenha() (fase 4/6)
*
* O trabalho REAL desta fase foi extrair, desses dois handlers, os TRES
* hooks canonicos da arquitetura (PILAR 3) que tem referente de verdade
* neste dialogo - eles existiam como atribuicao solta dentro do handler, o
* que deixava os nomes canonicos vivos so no comentario deste cabecalho:
*   - FormParaBO   txt_4c_SENHA.Value -> BO.this_cSenha (caminho VIVO:
*                  chamado por ValidarSenha, o ENTER que confirma o dialogo)
*   - BOParaForm   BO.this_cSenha -> txt_4c_SENHA.Value (caminho VIVO:
*                  chamado por LimparCampos)
*   - LimparCampos equivalente ao ThisForm.Senha.Value = "" do CANCELA.Click
*                  legado, com FONTE UNICA no BO (BO.LimparDados zera a senha
*                  e a flag de confirmacao; BOParaForm reflete isso no campo)
*                  - chamado por BtnCancelarClick
* Os tres sao PROTECTED porque FormBase ja os declara assim (formbase.prg
* linhas 276-287) e subclasse nao alarga escopo herdado; sao chamados com
* THIS. de dentro da propria classe (regra #8).
*
* Os demais nomes do roteiro seguem sem referente neste legado e por isso
* NAO foram criados: CarregarLista (nao ha grid nem cursor de listagem),
* HabilitarCampos/AjustarBotoesPorModo (nao ha modo INCLUIR/ALTERAR/
* VISUALIZAR - e um dialogo de captura unica) e BtnBuscarClick/
* BtnEncerrarClick/BtnSalvarClick (o SCX tem UM unico botao, o Cancelar -
* CommandGroup SAIDA, ButtonCount=1, membro CANCELA com Cancel=.T.). Criar
* esses metodos vazios ou com logica fabricada violaria tanto o PILAR 1
* (inventar estrutura/fluxo que o legado nao tem) quanto a regra de "nunca
* gerar stub disfarcado" - a funcionalidade real do dialogo (capturar a
* senha do supervisor e devolve-la ao form chamador via
* SIGPRSTFBO.ObterSenha(), ou devolver vazio se cancelado) esta completa e
* testavel ponta a ponta.
*
* Gate da Fase 8: o bloco do botao de acao reprovava este form com
* "BtnSalvarClick (ou BtnConfirmarClick/BtnGravarClick/BtnProcessaClick)"
* porque Test-LegadoCliqueSoFecha nao conhecia os dois idiomas do
* CANCELA.Click legado - fechar com RELEASE WINDOWS (o legado nunca escreve
* ThisForm.Release) e limpar o proprio <controle>.Value antes de fechar -,
* entao o UNICO botao do SCX era lido como botao de ACAO. Satisfazer o gate
* pelo lado do form exigiria INVENTAR um botao de gravar (viola o PILAR 1)
* ou criar um handler vazio: o conserto foi no OrquestradorMigracao.ps1,
* com alcance medido em automation\MedirCliqueSoFechaTask679.ps1 (1 form,
* os 4 dumps do MESMO SCX - tasks 228/254/334/679) e veredito provado nas
* DUAS versoes do gate em automation\VerificarGateFase8Task679.ps1.
*
* Integracao (menu.prg): SigTfSup e um dialogo PARAMETRIZADO, chamado
* programaticamente por outros forms (padrao DO FORM SigTfSup WITH ... /
* CREATEOBJECT + Show(1) + leitura do retorno), nunca pelo usuario direto
* via item de menu - nao ha Caption de menu no dump nem referencia a
* popMovimentos/popCadastros para este form. NAO adicionar item de menu
* (inventar entrada de menu para um dialogo auxiliar violaria o PILAR 1).
* config.prg ja carrega FormSIGPRSTF.prg/SIGPRSTFBO.prg automaticamente via
* ADIR() (carregamento dinamico - ver CLAUDE.md "config.prg - Dynamic
* Loading"), sem necessidade de SET PROCEDURE manual. Forms que no legado
* chamam "DO FORM SigTfSup WITH <8 parametros>" (Formsigproef.prg,
* SIGPRTFHBO.prg) sao uma tela DIFERENTE, de assinatura incompativel (8-12
* parametros de pinpad/SiTef, nada a ver com o dialogo simples de senha do
* supervisor aqui migrado) e ja foram documentados como fora de escopo
* nessas migracoes anteriores (acervo nao contem esse outro SigTfSup) -
* nao devem ser redirecionados para FormSIGPRSTF.
*==============================================================================

DEFINE CLASS FormSIGPRSTF AS FormBase

    *-- Propriedades visuais (fieis ao SigTfSup.scx)
    Height      = 200
    Width       = 400
    Caption     = "Senha de Risco"
    ShowWindow  = 1
    WindowType  = 1

    *-- Dialogo modal sem barra de titulo (fiel ao legado)
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0

    *====================================================================
    * Init - inicializacao padrao via FormBase (ver InicializarForm abaixo).
    * O legado so declara PUBLIC lcSenha e ajusta Container1.Label1.Caption
    * no seu Init (ver comportamento.json) - sem checagem de conexao SQL,
    * por isso nao ha ValidarParametros() aqui (diferente de outros dialogos
    * OPERACIONAIS que guardam gnConnHandle antes de montar a tela).
    *====================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *====================================================================
    * InicializarForm - Instancia o Business Object e monta o layout completo
    * do dialogo: faixa de titulo (fase 3), campos de senha/instrucao e
    * botao de saida/cancelar (esta fase).
    *====================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRSTFBO")

            THIS.ConfigurarCabecalho()
            THIS.ConfigurarCampos()
            THIS.ConfigurarSaida()

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ConfigurarCabecalho - Faixa cinza com o titulo (cntSombra do legado).
    *
    * Caption transcrito LITERALMENTE do dump ("Cadastro de Testes") - o
    * SCX declara esse texto explicitamente em lblSombra.Caption e
    * lblTitulo.Caption (SECAO 2 do dump), embora o Caption do FORM seja
    * "Senha de Risco". O Init do legado nunca sobrescreve esses dois
    * Captions (so altera Container1.Label1, na fase seguinte) - a
    * divergencia e do proprio SigTfSup.SCX e deve ser preservada (PILAR 1:
    * transcrever o legado, nunca "corrigir" uma inconsistencia dele).
    *
    * Width = THIS.Width (nao o literal 800/769 do dump, maior que o form
    * de 400px) - padrao canonico da faixa de cabecalho (CLAUDE.md regra
    * #11) e dos labels dentro dela (lesson "cabecalho_label_width_dump_
    * maior_que_form"): copiar o literal clipa o titulo.
    *====================================================================
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

            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = "Cadastro de Testes"
                .WordWrap  = .T.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .Top         = 17
                .Left        = 10
                .Width       = THIS.Width
                .Height      = 46
                .FontName    = "Tahoma"
                .FontSize    = 18
                .FontBold    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .ForeColor   = RGB(255, 255, 255)
                .Caption     = "Cadastro de Testes"
                .WordWrap    = .T.
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible     = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *====================================================================
    * ConfigurarCampos - Shape decorativo, campo de senha (real + decorativo
    * sobreposto pelo z-order do SCX), legenda e container com o texto de
    * instrucao (Container1/Label1 do legado).
    *
    * GetSenha (Enabled=.F.) e SENHA (PasswordChar="*") ocupam EXATAMENTE a
    * mesma posicao no SCX (Top=99, Left=214) - GetSenha e so decoracao
    * (mesmo fundo/fonte do campo real, mas nunca recebe foco) e SENHA, por
    * cima no z-order (criado depois), e o campo que o usuario de fato usa.
    * Reproduzir a sobreposicao fielmente (nao e bug do legado: e assim que
    * garante o mesmo visual do campo em todas as telas do Framework).
    *
    * InputMask/Format vazios no dump (GetSenha.InputMask="", SENHA.Format="")
    * sao override vazio do Form Designer - NAO transcrever (regra #49).
    *====================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 90
            .Left          = 76
            .Width         = 247
            .Height        = 42
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- GetSenha: decorativo, Enabled=.F., criado ANTES de SENHA para
        *-- ficar por baixo no z-order (fiel ao SCX)
        THIS.AddObject("txt_4c_SenhaSupervisor", "TextBox")
        WITH THIS.txt_4c_SenhaSupervisor
            .Top       = 99
            .Left      = 214
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .F.
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 104
            .Left      = 87
            .Width     = 108
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Senha do Supervisor :"
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- SENHA: campo real, criado DEPOIS de GetSenha para ficar por cima
        THIS.AddObject("txt_4c_SENHA", "TextBox")
        WITH THIS.txt_4c_SENHA
            .Top          = 99
            .Left         = 214
            .Width        = 100
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .FontBold     = .F.
            .BackStyle    = 1
            .PasswordChar = "*"
            .ForeColor    = RGB(0, 0, 0)
            .BackColor    = RGB(255, 255, 255)
            .Value        = ""
            .Visible      = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_SENHA, "KeyPress", THIS, "ValidarSenha")

        THIS.AddObject("cnt_4c_Container1", "Container")
        WITH THIS.cnt_4c_Container1
            .Top           = 137
            .Left          = 114
            .Width         = 171
            .Height        = 56
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top       = 16
                .Left      = 7
                .Width     = 157
                .Height    = 30
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Trebuchet MS"
                .FontSize  = 10
                .Alignment = 2
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                *-- Caption inicial do SCX; InicializarForm sobrescreve a
                *-- seguir com o texto que o Init() do legado gera em
                *-- runtime (equivalente a ThisForm.Container1.Label1.Caption)
                .Caption   = "Insira ou Passe o Cartao"
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Equivalente ao SigTfSup.Init() legado:
        *-- ThisForm.Container1.Label1.Caption="Digite a Senha"+CHR(13)+"do Supervisor"
        THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha" + CHR(13) + "do Supervisor"
    ENDPROC

    *====================================================================
    * ConfigurarSaida - CommandGroup de saida/cancelar (SAIDA do legado,
    * botao interno CANCELA). ControlSource="OPSENHA" do SCX nao e
    * reproduzido: nenhum metodo do comportamento.json le ThisForm.SAIDA.Value
    * e nao ha variavel OPSENHA declarada em lugar nenhum do dump - e
    * residuo inerte do legado, sem efeito no comportamento visivel.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarSaida()
        THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
        WITH THIS.obj_4c_SAIDA
            .ButtonCount  = 1
            .Top          = -2
            .Left         = 320
            .Width        = 85
            .Height       = 85
            .BackStyle    = 0
            .BorderStyle  = 0
            .BackColor    = RGB(255, 255, 255)
            .Visible      = .T.

            WITH .Buttons(1)
                .Top       = 5
                .Left      = 5
                .Width     = 75
                .Height    = 75
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .T.
                .FontItalic = .F.
                .Caption   = "\<Cancelar"
                .Picture   = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .Cancel    = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes    = .F.
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *====================================================================
    * ValidarSenha - Equivalente ao SigTfSup.SENHA.KeyPress legado (o legado
    * nao tem PROCEDURE Valid separado para este campo - a confirmacao com
    * ENTER E o Valid, feitos no mesmo evento):
    *   IF nKeyCode = 13
    *       lcSenha = ThisForm.SeNHA.Value
    *       RELEASE Windows
    *   ENDIF
    *
    * PUBLIC (sem PROTECTED) porque esta ligado via BINDEVENT (regra #3).
    *====================================================================
    PROCEDURE ValidarSenha(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13
            THIS.FormParaBO()
            THIS.this_oBusinessObject.this_lConfirmou = .T.
            THIS.Release()
        ENDIF
    ENDPROC

    *====================================================================
    * BtnCancelarClick - Equivalente ao SigTfSup.SAIDA.CANCELA.Click legado:
    *   ThisForm.Senha.Value=""
    *   RELEASE Windows
    *
    * Nomeado pela ACAO (Btn<Acao>Click), nao pelo objeto legado (CANCELA) -
    * PILAR 3 e convencao exigida pelos gates das Fases 7/8 (ver comentario
    * da FASE 7 no cabecalho do arquivo).
    *
    * PUBLIC (sem PROTECTED) porque esta ligado via BINDEVENT (regra #3).
    *====================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.Release()
    ENDPROC

    *====================================================================
    * FormParaBO - Transfere o campo digitado para o Business Object.
    *
    * Caminho VIVO: chamado por ValidarSenha (o ENTER que confirma o
    * dialogo). Equivale ao "lcSenha = ThisForm.SeNHA.Value" do
    * SigTfSup.SENHA.KeyPress legado - a diferenca e que o valor vai para
    * a property do BO (PILAR 3) em vez de uma variavel PUBLIC.
    *
    * PROTECTED: FormBase declara o hook assim (formbase.prg:285) e
    * subclasse nao alarga escopo herdado - e chamado com THIS. de dentro
    * da propria classe (regra #8).
    *====================================================================
    PROTECTED PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_cSenha = THIS.txt_4c_SENHA.Value
    ENDPROC

    *====================================================================
    * BOParaForm - Reflete no campo a senha guardada no Business Object.
    *
    * Caminho VIVO: chamado por LimparCampos (apos BO.LimparDados, para
    * que o campo acompanhe a senha zerada). Sentido inverso de FormParaBO,
    * com a MESMA fonte unica - a property do BO.
    *
    * PROTECTED: FormBase declara o hook assim (formbase.prg:280).
    *====================================================================
    PROTECTED PROCEDURE BOParaForm()
        THIS.txt_4c_SENHA.Value = THIS.this_oBusinessObject.this_cSenha
    ENDPROC

    *====================================================================
    * LimparCampos - Equivalente ao "ThisForm.Senha.Value = """"" do
    * SigTfSup.SAIDA.CANCELA.Click legado: zera a senha para que o form
    * chamador leia vazio (= o usuario cancelou, ver SIGPRSTFBO.ObterSenha).
    *
    * FONTE UNICA no BO: BO.LimparDados zera this_cSenha e this_lConfirmou,
    * e BOParaForm reflete isso no campo - assim o campo e o BO nunca
    * divergem (o legado, sendo modal e de registro unico, nao tinha esse
    * risco; aqui o form pode ser reexibido pelo chamador).
    *
    * PROTECTED: FormBase declara o hook assim (formbase.prg:276).
    *====================================================================
    PROTECTED PROCEDURE LimparCampos()
        THIS.this_oBusinessObject.LimparDados()
        THIS.BOParaForm()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRSTFBO.prg):
*==============================================================================
* SIGPRSTFBO.prg
*
* Business Object para SIGPRSTF (Senha de Risco - Senha do Supervisor)
*
* Este form NAO persiste dados em tabela propria - e um dialogo OPERACIONAL
* modal (WindowType = 1) que solicita a senha do supervisor para autorizar
* uma operacao de risco. O legado (SigTfSup.SCX) apenas captura o valor
* digitado no campo Senha em lcSenha e devolve esse valor ao form chamador
* via Unload; a validacao da senha contra o cadastro de usuarios/
* supervisores e responsabilidade do form que abriu o dialogo - nao faz
* parte do codigo fonte original deste form (comportamento.json nao lista
* nenhuma query SQL nem validacao em SigTfSup).
*
* Tabela: (nenhuma - dialogo parametrizado, sem persistencia propria)
*==============================================================================

DEFINE CLASS SIGPRSTFBO AS BusinessBase

    *-- Propriedades da entidade (espelham as properties customizadas do
    *-- form legado SigTfSup)
    this_cSenha = ""       && lcSenha - Senha do Supervisor digitada pelo usuario
    this_lConfirmou = .F.  && .T. quando o usuario confirmou a senha (ENTER), .F. quando cancelou

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- Dialogo parametrizado: nao ha tabela nem campo chave proprios
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        THIS.this_cSenha = ""
        THIS.this_lConfirmou = .F.

        RETURN .T.
    ENDPROC

    *====================================================================
    * LimparDados - Reinicia a senha digitada e a flag de confirmacao
    *
    * Equivalente ao SigTfSup.SAIDA.Click do legado (ThisForm.Senha.Value = "")
    * - usado pelo form chamador antes de reexibir o dialogo, garantindo que
    * uma senha de uma tentativa anterior nunca sobreviva para a proxima.
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cSenha = ""
        THIS.this_lConfirmou = .F.
    ENDPROC

    *====================================================================
    * ObterSenha - Devolve a senha digitada, SOMENTE se o usuario confirmou
    * com ENTER (equivalente ao "RETURN (lcSenha)" do legado, que so era
    * atingido apos o KeyPress do campo Senha - SAIDA.Click libera a janela
    * sem passar por esse retorno, com o valor ja limpo).
    *
    * A validacao da senha contra o cadastro de usuarios/supervisores e
    * responsabilidade do form chamador - nao faz parte do SigTfSup original.
    *====================================================================
    PROCEDURE ObterSenha()
        IF !THIS.this_lConfirmou
            RETURN ""
        ENDIF

        RETURN THIS.this_cSenha
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Dialogo parametrizado sem cursor/tabela propria
    * (ver cabecalho do arquivo); o comportamento padrao herdado de
    * BusinessBase ja eh o correto para este BO.
    *====================================================================
    PROCEDURE CarregarDoCursor(pcCursor)
        RETURN DODEFAULT(pcCursor)
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Dialogo sem registro persistido: nao ha chave
    * primaria propria para auditar (ver Inserir/Atualizar abaixo).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *====================================================================
    * Inserir / Atualizar - NAO sobrescritos propositalmente.
    *
    * SigTfSup nao grava em tabela nenhuma: e um dialogo modal que apenas
    * captura a senha do supervisor (ver ObterSenha acima) e devolve o
    * controle ao form chamador. O comportamento padrao herdado de
    * BusinessBase (recusar a operacao) ja eh o correto aqui - criar um
    * INSERT/UPDATE para este BO violaria o PILAR 2 (inventar persistencia
    * que o sistema legado nao tem). Por isso RegistrarAuditoria tambem
    * nunca e chamado a partir deste BO.
    *====================================================================

ENDDEFINE

