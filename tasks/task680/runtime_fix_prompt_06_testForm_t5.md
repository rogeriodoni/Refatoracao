# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 5/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-10-19 21:57:45] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-19 21:57:45] [INFO] Config FPW: (nao fornecido)
[2026-10-19 21:57:45] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-19 21:57:45] [INFO] Timeout: 300 segundos
[2026-10-19 21:57:45] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s3454f5t.prg
[2026-10-19 21:57:45] [INFO] Conteudo do wrapper:
[2026-10-19 21:57:45] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigprtam', 'C:\4c\tasks\task680\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprtam', 'C:\4c\tasks\task680\logs\06_testForm.log'
QUIT

[2026-10-19 21:57:45] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s3454f5t.prg
[2026-10-19 21:57:45] [INFO] VFP output esperado em: C:\4c\tasks\task680\vfp_output.txt
[2026-10-19 21:57:45] [INFO] Executando Visual FoxPro 9...
[2026-10-19 21:57:45] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s3454f5t.prg
[2026-10-19 21:57:45] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s3454f5t.prg
[2026-10-19 21:57:45] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigprtam
Inicio: 19/10/2026 21:57:45

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 19/10/2026 22:01:11
Duracao: 206 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-19 22:01:11] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-19 22:01:11] [INFO] VFP9 finalizado em 206.2515468 segundos
[2026-10-19 22:01:11] [INFO] Exit Code: 
[2026-10-19 22:01:11] [INFO] 
[2026-10-19 22:01:11] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-19 22:01:11] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s3454f5t.prg
[2026-10-19 22:01:11] [INFO] 
[2026-10-19 22:01:11] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-19 22:01:11] [INFO] * Auto-generated wrapper for parameters
[2026-10-19 22:01:11] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-19 22:01:11] [INFO] * Parameters: 'Formsigprtam', 'C:\4c\tasks\task680\logs\06_testForm.log'
[2026-10-19 22:01:11] [INFO] 
[2026-10-19 22:01:11] [INFO] * Anti-dialog protections for unattended execution
[2026-10-19 22:01:11] [INFO] SET SAFETY OFF
[2026-10-19 22:01:11] [INFO] SET RESOURCE OFF
[2026-10-19 22:01:11] [INFO] SET TALK OFF
[2026-10-19 22:01:11] [INFO] SET NOTIFY OFF
[2026-10-19 22:01:11] [INFO] SYS(2335, 0)
[2026-10-19 22:01:11] [INFO] 
[2026-10-19 22:01:11] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprtam', 'C:\4c\tasks\task680\logs\06_testForm.log'
[2026-10-19 22:01:11] [INFO] QUIT
[2026-10-19 22:01:11] [INFO] 
[2026-10-19 22:01:11] [INFO] === Fim do Wrapper.prg ===
[2026-10-19 22:01:11] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprtam.prg):
*==============================================================================
* Formsigprtam.prg (SIGPRTAM.SCX migrado)
* Formulario OPERACIONAL: dialogo filho "Peso medio por tamanho" do Cadastro
* de Produtos - mantem a grade de tamanhos (codigo/descricao/peso medio/
* percentual/valor/prazo de entrega) de UM produto por vez.
*
* Layout: sem PageFrame (identico ao legado - cabecalho + grade + 3 botoes
* direto na area do form). Nao segue o padrao Page1=Lista/Page2=Dados do CRUD.
*
* Parametros de abertura (Init):
*   par_oFormPai     - referencia ao form pai (FormProduto), para
*                      desabilitar/reabilitar durante o dialogo modal
*   par_cEscolha     - modo do form pai: "INSERIR"/"ALTERAR"/"VISUALIZAR"
*                      (controla Visible/Enabled de cmd_4c_Inserir/Excluir -
*                      legado so permite incluir/excluir tamanho quando o
*                      produto esta sendo incluido ou alterado)
*   par_cCodProduto  - codigo do produto filtrado (SigCdPro.cPros)
*
* PILAR 3 (simplificacao de arquitetura): o legado tem DOIS caminhos de
* abertura - um que cria conexao/cursor proprios a partir de pcProduto, e
* outro que reaproveita os cursores JA abertos do form pai via DataSession
* compartilhada (Set DataSession to pnDataSes). A nova arquitetura nao
* compartilha cursores VFP entre forms (acesso sempre via gnConnHandle),
* entao essa duvida de caminho desaparece: par_cCodProduto e SEMPRE
* obrigatorio e o Form sempre busca os dados do produto e da grade pelo BO.
*
* Uso canonico (a partir do FormProduto):
*   loForm = CREATEOBJECT("Formsigprtam", THISFORM, THIS.this_cEscolha, loc_cCodProduto)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()
*   ENDIF
*
* O legado eh aberto por "Do Form SigPrTam With Thisform, ThisForm.DataSessionId,
* ThisForm.pcEscolha" (SIGCDPRO.Pagina.Dados.pgframeDados.pgDados.cmdTamanho.
* btnTam.Valid) - sem o codigo do produto, porque la ele vinha do cursor
* crSigCdPro compartilhado pela DataSessionId. No sistema novo nao se
* compartilha cursor entre forms, entao o 3o argumento (par_cCodProduto)
* substitui o pnDataSes do legado e eh OBRIGATORIO. O btnTam.When do legado
* libera o botao em INSERIR, ALTERAR e CONSULTAR - em CONSULTAR o dialogo abre
* somente-leitura (ver AjustarVisibilidadePorModo).
*
* COBERTURA DOS 15 METODOS DO SCX LEGADO (SECAO 3 do dump):
*   SIGPRTAM.Init                   -> Init + InicializarForm
*   Grade.Column1.Text1.When        -> CelulaGradeEditavel("COD")
*   Grade.Column1.Text1.Valid       -> ValidarCelulaGradeExec -> ValidarTamanhoGridExec(,"cods")
*   Grade.Column2.Text1.When        -> CelulaGradeEditavel("DESC")
*   Grade.Column2.Text1.Valid       -> ValidarCelulaGradeExec -> ValidarTamanhoGridExec(,"descs")
*   Grade.Column3.Text1.When        -> CelulaGradeEditavel("PESO")
*   Grade.Column4.Text1.When        -> CelulaGradeEditavel("PERC")
*   Grade.Column4.Text1.Valid       -> ValidarCelulaGradeExec -> ValidarPercGridExec
*   Grade.Column5.Text1.When        -> CelulaGradeEditavel("VALOR")
*   Grade.Column5.Text1.Valid       -> ValidarCelulaGradeExec -> ValidarValorGridExec
*   Grade.Column6.Text1.When        -> CelulaGradeEditavel("PRAZO")
*   cmdInserir.Click                -> BtnInserirClick
*   cmdExcluir.Click                -> BtnExcluirClick
*   cmdSair.Click                   -> BtnSairClick (+ Destroy reabilita o pai)
*   SIGPRTAM.Load                   -> NAO PORTADO - ver (a)
*
* (a) Load: "=fConfigGeral()". fConfigGeral era funcao GLOBAL da aplicacao
*     legado Fortyus, chamada no Load de praticamente todo form so para
*     garantir que a configuracao do sistema estivesse carregada. O wrapper
*     projeto\app\utils\fconfiggeral.prg existe APENAS para o p-code dos VCX
*     legado, que a chamam de dentro de binario que nao da para editar - em
*     codigo NOSSO nunca se chama fConfigGeral. Chama-la daqui sugeriria que
*     falta alguma inicializacao global: o que fConfigGeral fazia esta
*     distribuido em config.prg/main.prg e ja ocorreu ANTES deste dialogo
*     existir. Mesmo tratamento registrado em FormSigMvExp (task570),
*     FormSigMvMen, FormSigMvPdt, FormSigMvSbn e FormSIGMVTI2.
*
* Contrato com o form PAI (equivalente a houveincl/houveexcl do legado):
* this_lHouveIncl e this_lHouveExcl ficam ligados quando houve inclusao ou
* exclusao de tamanho. Sao PROPERTIES publicas de proposito - quem abriu o
* dialogo pode ler as duas DEPOIS do Show() (que eh modal e so retorna com a
* tela fechada) para decidir se precisa recarregar a propria grade, igual ao
* ".Parentform.ProcTam" que o Init legado consultava.
*==============================================================================

DEFINE CLASS Formsigprtam AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (PILAR 1 - UX FIDELITY)
    * Dimensoes originais do SCX: Width=638, Height=540
    *--------------------------------------------------------------------------
    Width        = 638
    Height       = 540
    AutoCenter   = .T.
    BorderStyle  = 2
    Caption      = "Peso m" + CHR(233) + "dio por tamanho"
    ShowWindow   = 1
    WindowType   = 1
    WindowState  = 0
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    Themes       = .F.
    BackColor    = RGB(240, 240, 240)

    *-- DataSession PRIVADA (2): isola cursor_4c_Dados deste dialogo do
    *-- cursor_4c_Dados que o FormProduto (form pai) usa na propria Lista -
    *-- sem isso os dois nomes colidiriam na mesma DataSession compartilhada
    *-- (mesmo risco resolvido em FormSigPrCar - dialogo filho irmao).
    DataSession  = 2

    *--------------------------------------------------------------------------
    * Objeto de negocio
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    * Propriedades de contexto do dialogo (equivalentes as do legado)
    *--------------------------------------------------------------------------
    this_oFormPai      = .NULL.   && ParentForm do legado
    this_cEscolha      = ""       && pcescolha herdado do form pai
    this_cCodProduto   = ""       && cpros - produto filtrado (pcPro)

    *--------------------------------------------------------------------------
    * Dados do produto (cache local p/ calculo de percentual/valor na grade -
    * equivalentes a pdPro/crSigCdPro.PVens/crSigCdPro.PCuss do legado)
    *--------------------------------------------------------------------------
    this_cDescProduto  = ""       && Dpros
    this_nPrecoVenda   = 0        && PVens
    this_nPrecoCusto   = 0        && PCuss

    *--------------------------------------------------------------------------
    * Estado de edicao da grade (equivalentes a peAntValue/houveincl/houveexcl)
    *--------------------------------------------------------------------------
    this_nValorAnterior = 0       && valor da celula antes de editar (Percs/Valor)

    *-- Valor anterior das celulas NUMERICAS de commit simples (Peso Medio
    *-- e Entrega). NAO podem usar Text1.Tag: medido no VFP9 (2026-10-19,
    *-- automation\medir_tag_numerico.prg) a property Tag eh ESTRITAMENTE
    *-- Character - "Tag = <numerico>" estoura "Data type is invalid for
    *-- this property." e "Value != Tag" com Value numerico estoura
    *-- "Operator/operand type mismatch." (erro 107), inclusive com o Tag
    *-- no default. Uma property por coluna para nao depender da ordem em
    *-- que GotFocus/LostFocus das duas se intercalam.
    this_nPesoAnterior  = 0       && pesoms  antes de editar (Column3)
    this_nPrazoAnterior = 0       && diasprz antes de editar (Column6)
    this_lHouveIncl     = .F.     && houve inclusao de linha na grade
    this_lHouveExcl     = .F.     && houve exclusao de linha na grade

    *--------------------------------------------------------------------------
    * Lista dos cidchaves criados por BtnInserirClick nesta sessao que ainda
    * NAO foram gravados em SigPrTam (linha em branco, esperando o usuario
    * escolher o tamanho). Formato: "|cid1|cid2|". Mesmo papel do
    * this_cPksNovos de FormSigPrCar: aqui a gravacao tem de acontecer no
    * proprio dialogo (DataSession privada, sem TableUpdate implicito do
    * legado), entao esta lista distingue "linha nova ainda sem registro no
    * banco" (INSERT) de "linha que veio do CarregarLista" (UPDATE/DELETE).
    *--------------------------------------------------------------------------
    this_cCidChavesNovos = ""

    *--------------------------------------------------------------------------
    * Resultado do picker de tamanhos (AbrirLookupTamanho). Nao pode ser lido
    * de volta de Column1.Text1.Value/Column2.Text1.Value: em Grid esses
    * controles sao a celula CORRENTE, re-vinculada quando o cursor se move -
    * e o picker eh MODAL, entao o ponteiro pode ter mudado quando ele fecha.
    *--------------------------------------------------------------------------
    this_cLkpCodigo    = ""
    this_cLkpDescricao = ""

    *-- Guarda de reentrancia do picker modal (aberto de dentro de um handler
    *-- de celula da grade - sem isso o proprio evento pode redisparar e
    *-- empilhar um segundo picker)
    this_lLookupAberto = .F.

    *--------------------------------------------------------------------------
    * Init - Recebe o contexto do form pai e inicializa
    * Armazena os parametros ANTES de DODEFAULT (InicializarForm precisa deles)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_cEscolha, par_cCodProduto)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai
                THIS.this_oFormPai.Enabled = .F.
            ENDIF

            IF VARTYPE(par_cEscolha) = "C"
                THIS.this_cEscolha = UPPER(ALLTRIM(par_cEscolha))
            ENDIF

            *-- O legado decide tudo por InList(pcEscolha,'INSERIR','ALTERAR'),
            *-- mas o modo de inclusao do form pai (FormProduto) chama-se
            *-- "INCLUIR" no sistema novo. Traduzido uma vez aqui, no funil de
            *-- entrada, para que o resto do form possa comparar contra os
            *-- nomes do legado como estao (mesmo padrao de FormSigPrCar.Init).
            IF THIS.this_cEscolha == "INCLUIR"
                THIS.this_cEscolha = "INSERIR"
            ENDIF

            IF VARTYPE(par_cCodProduto) = "C"
                THIS.this_cCodProduto = ALLTRIM(par_cCodProduto)
            ENDIF

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Formsigprtam.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Hook chamado por FormBase.Init() via DODEFAULT()
    * Cria o Business Object e monta o cabecalho. Grade e botoes sao
    * construidos/carregados nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste
        loc_lSucesso = .F.
        loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                    (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        TRY
            *-- DataSession = 2 nasce com os SETs no DEFAULT do VFP, NAO com os
            *-- do config.prg. Sem DELETED ON, o DELETE local do BtnExcluirClick
            *-- (linha em branco nunca gravada) marca a linha mas ela CONTINUA
            *-- aparecendo na grade - o usuario clica Excluir e nada some.
            SET DELETED ON
            SET EXACT ON

            *-- Produto ausente eh erro de USO (o dialogo so existe para um
            *-- produto), mas NAO em modo validacao/teste - o harness instancia
            *-- o form sem argumento nenhum so para montar a UI.
            IF EMPTY(THIS.this_cCodProduto) AND !loc_lModoValidacaoOuTeste
                MsgErro("Produto n" + CHR(227) + "o informado para gerenciar " + ;
                        "tamanhos.", "Erro Formsigprtam")
            ELSE
                THIS.this_oBusinessObject = CREATEOBJECT("sigprtamBO")

                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                    MsgErro("Erro ao criar Business Object de Tamanhos do Produto." + CHR(13) + ;
                            "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
                ELSE
                    *-- Dados do produto (Dpros/PVens/PCuss), usados pelo calculo
                    *-- Percentual<->Valor das celulas da grade - pulado em modo
                    *-- teste/validacao de UI (sem conexao SQL disponivel)
                    IF !loc_lModoValidacaoOuTeste
                        THIS.CarregarDadosProduto()
                    ENDIF

                    *-- Fundo (Picture) e Shape1 decorativo do topo (fiel ao SCX)
                    THIS.ConfigurarDecoracao()

                    *-- Cabecalho cinza (cntSombra do legado)
                    THIS.ConfigurarCabecalho()

                    *-- Grade (Column1..Column6) - so estrutura, sem
                    *-- ControlSource ainda (cursor_4c_Dados so existe depois
                    *-- do CarregarLista - regra #41)
                    THIS.ConfigurarGrid()

                    *-- Celulas da grade com When/Valid proprios: lookup de
                    *-- Tamanho (Column1/Column2), calculo Percentual<->Valor
                    *-- (Column4/Column5) e commit de Peso/Entrega
                    *-- (Column3/Column6)
                    THIS.InstalarCelulasGrade()

                    *-- Botoes de acao (cmd_4c_Inserir/cmd_4c_Excluir/cmd_4c_Sair)
                    *-- - criados DEPOIS do cabecalho para desenhar por cima dele
                    *-- (Top=3, dentro da faixa Top=0..80 - regra #11)
                    THIS.ConfigurarBotoes()

                    *-- AddObject cria controles com Visible=.F. por padrao
                    THIS.TornarControlesVisiveis()

                    *-- Espelha llVis do Init legado - tem que rodar DEPOIS do
                    *-- TornarControlesVisiveis, senao a visibilidade generica
                    *-- sobrescreve o Inserir/Excluir escondidos em modo consulta
                    THIS.AjustarVisibilidadePorModo()

                    *-- Popula a grade (pulado em modo teste/validacao de UI)
                    IF !loc_lModoValidacaoOuTeste
                        THIS.CarregarLista()
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao inicializar Formsigprtam")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container de cabecalho cinza (cntSombra do legado)
    * Equivalente: SIGPRTAM.cntSombra + lblSombra + lblTitulo
    * Regra #11/#12: Width = THIS.Width (nao o literal do SCX, que excede o
    * form); label Width = THIS.Width - 20 para nao clipar o titulo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Height        = 40
            .Left          = 10
            .Top           = 25
            .Width         = THIS.Width - 20
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Height        = 46
            .Left          = 10
            .Top           = 24
            .Width         = THIS.Width - 20
            .ForeColor     = RGB(255, 255, 255)
            .ToolTipText   = "T" + CHR(237) + "tulo"
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarDecoracao - Fundo (Picture) do form e Shape1 decorativo atras
    * dos botoes de acao (Top=12, Left=372, Width=256, Height=110,
    * BackStyle=0, BorderStyle=0 - transparente, fiel ao SCX legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarDecoracao()
        LOCAL loc_cImgFundo

        *-- Picture = ..\framework\imagens\new_background.jpg (SIGPRTAM original).
        *-- TYPE() antes de usar a global: harness de validacao de UI nao roda
        *-- config.prg e nao declara gc_4c_CaminhoFramework.
        IF TYPE("gc_4c_CaminhoFramework") = "C"
            loc_cImgFundo = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
            IF FILE(loc_cImgFundo)
                THIS.Picture = loc_cImgFundo
            ENDIF
        ENDIF

        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 12
            .Left        = 372
            .Height      = 110
            .Width       = 256
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Grade (Grade do legado): Column1=CodTams, Column2=Descs,
    * Column3=PesoMs, Column4=Percs, Column5=Valor, Column6=DiasPrz.
    * Dimensoes/mascaras EXATAS do SCX (form flat 638x540, sem PageFrame - nao
    * ha compensacao de offset a aplicar aqui).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top                = 111
            .Left               = 9
            .Width              = 620
            .Height             = 394
            .FontName           = "Tahoma"
            .FontSize           = 8
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .AllowCellSelection = .T.
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 17
            .ScrollBars         = 2
            .GridLineColor      = RGB(238, 238, 238)
            .ColumnCount        = 6

            *-- Column1 = CodTams (SigPrTam.codtams char(4) - FK SigCdTam.cods)
            .Column1.FontName          = "Tahoma"
            .Column1.FontSize          = 8
            .Column1.Width             = 38
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Header1.Caption   = "Tam."
            .Column1.Header1.ForeColor = RGB(90, 90, 90)
            .Column1.Text1.FontName    = "Tahoma"
            .Column1.Text1.FontSize    = 8
            .Column1.Text1.Margin      = 0
            .Column1.Text1.MaxLength   = 4

            *-- Column2 = Descs (vem de SigCdTam.descs char(20) via lookup)
            .Column2.FontName          = "Tahoma"
            .Column2.FontSize          = 8
            .Column2.Width             = 216
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.ForeColor = RGB(90, 90, 90)
            .Column2.Text1.FontName    = "Tahoma"
            .Column2.Text1.FontSize    = 8
            .Column2.Text1.Margin      = 0
            .Column2.Text1.MaxLength   = 20

            *-- Column3 = PesoMs (numeric(7,3) - sem InputMask no SCX legado)
            .Column3.FontName          = "Tahoma"
            .Column3.FontSize          = 8
            .Column3.Width             = 100
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.Alignment = 2
            .Column3.Header1.Caption   = "Peso M" + CHR(233) + "dio"
            .Column3.Header1.ForeColor = RGB(90, 90, 90)
            .Column3.Text1.FontName    = "Tahoma"
            .Column3.Text1.FontSize    = 8

            *-- Column4 = Percs (numeric(5,2))
            .Column4.FontName          = "Tahoma"
            .Column4.FontSize          = 8
            .Column4.Width             = 80
            .Column4.Movable           = .F.
            .Column4.Resizable         = .F.
            .Column4.InputMask         = "999.99"
            .Column4.Header1.FontName  = "Tahoma"
            .Column4.Header1.FontSize  = 8
            .Column4.Header1.Alignment = 2
            .Column4.Header1.Caption   = "Percentual"
            .Column4.Header1.ForeColor = RGB(90, 90, 90)
            .Column4.Text1.FontName    = "Tahoma"
            .Column4.Text1.FontSize    = 8
            .Column4.Text1.BorderStyle = 0
            .Column4.Text1.Margin      = 0
            .Column4.Text1.ForeColor   = RGB(0, 0, 0)
            .Column4.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column5 = Valor (numeric(11,5))
            .Column5.FontName          = "Tahoma"
            .Column5.FontSize          = 8
            .Column5.Width             = 100
            .Column5.Movable           = .F.
            .Column5.Resizable         = .F.
            .Column5.InputMask         = "9999,999.99999"
            .Column5.Header1.FontName  = "Tahoma"
            .Column5.Header1.FontSize  = 8
            .Column5.Header1.Alignment = 2
            .Column5.Header1.Caption   = "Valor"
            .Column5.Header1.ForeColor = RGB(90, 90, 90)
            .Column5.Text1.FontName    = "Tahoma"
            .Column5.Text1.FontSize    = 8
            .Column5.Text1.BorderStyle = 0
            .Column5.Text1.Margin      = 0
            .Column5.Text1.ForeColor   = RGB(0, 0, 0)
            .Column5.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column6 = DiasPrz (numeric(2,0))
            .Column6.FontName          = "Tahoma"
            .Column6.FontSize          = 8
            .Column6.Width             = 60
            .Column6.Movable           = .F.
            .Column6.Resizable         = .F.
            .Column6.InputMask         = "99"
            .Column6.Header1.FontName  = "Tahoma"
            .Column6.Header1.FontSize  = 8
            .Column6.Header1.Alignment = 2
            .Column6.Header1.Caption   = "Entrega"
            .Column6.Header1.ForeColor = RGB(90, 90, 90)
            .Column6.Text1.FontName    = "Tahoma"
            .Column6.Text1.FontSize    = 8
            .Column6.Text1.BorderStyle = 0
            .Column6.Text1.Margin      = 0
            .Column6.Text1.ForeColor   = RGB(0, 0, 0)
            .Column6.Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * InstalarCelulasGrade - Instala em CADA Column da grade o TextBox com
    * When/Valid EMBUTIDOS (classe TextBoxCelulaTamanho_4c, definida em
    * classes\TextBoxGridLookup.prg).
    *
    * No legado cada Column<N>.Text1 tem o seu When (gate de modo) e, nas
    * colunas de lookup (Column1/Column2) e de calculo (Column4/Column5), o
    * seu Valid. BINDEVENT em evento de celula de Grid nao eh confiavel
    * (regra #46): a validacao de celula tem de viver no Valid do TextBox da
    * coluna. Column.AddObject sozinho NAO exibe o controle - exige
    * CurrentControl + Sparse = .F. (regra #18).
    *
    * Chamado em ConfigurarGrid (criacao) e DE NOVO no fim de CarregarLista:
    * o BO recria cursor_4c_Dados (USE IN + SQLEXEC + INTO CURSOR), e
    * re-vincular RecordSource/ControlSource reseta propriedades de Column -
    * CurrentControl e Sparse entre elas. O AddObject so acontece na primeira
    * vez (PEMSTATUS): repetir AddObject com o mesmo nome estoura "Object is
    * already defined".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InstalarCelulasGrade()
        LOCAL loc_oCol, loc_oTxt

        *-- Column1 = CodTams - lookup de tamanho por CODIGO (SigCdTam.cods)
        loc_oCol = THIS.grd_4c_Dados.Column1
        IF !PEMSTATUS(loc_oCol, "txt_4c_CelCodTam", 5)
            loc_oCol.AddObject("txt_4c_CelCodTam", "TextBoxCelulaTamanho_4c")
        ENDIF
        loc_oTxt = loc_oCol.txt_4c_CelCodTam
        WITH loc_oTxt
            .this_cPapel = "COD"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Margin      = 0
            .MaxLength   = 4
            .Visible     = .T.
        ENDWITH
        loc_oCol.CurrentControl = "txt_4c_CelCodTam"
        loc_oCol.Sparse         = .F.

        *-- Column2 = Descs - lookup de tamanho por DESCRICAO (SigCdTam.descs)
        loc_oCol = THIS.grd_4c_Dados.Column2
        IF !PEMSTATUS(loc_oCol, "txt_4c_CelDescTam", 5)
            loc_oCol.AddObject("txt_4c_CelDescTam", "TextBoxCelulaTamanho_4c")
        ENDIF
        loc_oTxt = loc_oCol.txt_4c_CelDescTam
        WITH loc_oTxt
            .this_cPapel = "DESC"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Margin      = 0
            .MaxLength   = 20
            .Visible     = .T.
        ENDWITH
        loc_oCol.CurrentControl = "txt_4c_CelDescTam"
        loc_oCol.Sparse         = .F.

        *-- Column3 = PesoMs - entrada numerica simples (legado so tem When)
        loc_oCol = THIS.grd_4c_Dados.Column3
        IF !PEMSTATUS(loc_oCol, "txt_4c_CelPeso", 5)
            loc_oCol.AddObject("txt_4c_CelPeso", "TextBoxCelulaTamanho_4c")
        ENDIF
        loc_oTxt = loc_oCol.txt_4c_CelPeso
        WITH loc_oTxt
            .this_cPapel = "PESO"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Margin      = 0
            .Visible     = .T.
        ENDWITH
        loc_oCol.CurrentControl = "txt_4c_CelPeso"
        loc_oCol.Sparse         = .F.

        *-- Column4 = Percs - recalcula o Valor. SCX: InputMask "999.99" e
        *-- Text1 com BorderStyle 0 sobre caixa branca
        loc_oCol = THIS.grd_4c_Dados.Column4
        IF !PEMSTATUS(loc_oCol, "txt_4c_CelPerc", 5)
            loc_oCol.AddObject("txt_4c_CelPerc", "TextBoxCelulaTamanho_4c")
        ENDIF
        loc_oTxt = loc_oCol.txt_4c_CelPerc
        WITH loc_oTxt
            .this_cPapel = "PERC"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Margin      = 0
            .BorderStyle = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .InputMask   = "999.99"
            .Visible     = .T.
        ENDWITH
        loc_oCol.CurrentControl = "txt_4c_CelPerc"
        loc_oCol.Sparse         = .F.

        *-- Column5 = Valor - recalcula o Percentual. SCX: InputMask
        *-- "9999,999.99999"
        loc_oCol = THIS.grd_4c_Dados.Column5
        IF !PEMSTATUS(loc_oCol, "txt_4c_CelValor", 5)
            loc_oCol.AddObject("txt_4c_CelValor", "TextBoxCelulaTamanho_4c")
        ENDIF
        loc_oTxt = loc_oCol.txt_4c_CelValor
        WITH loc_oTxt
            .this_cPapel = "VALOR"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Margin      = 0
            .BorderStyle = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .InputMask   = "9999,999.99999"
            .Visible     = .T.
        ENDWITH
        loc_oCol.CurrentControl = "txt_4c_CelValor"
        loc_oCol.Sparse         = .F.

        *-- Column6 = DiasPrz - entrada numerica simples. SCX: InputMask "99"
        loc_oCol = THIS.grd_4c_Dados.Column6
        IF !PEMSTATUS(loc_oCol, "txt_4c_CelPrazo", 5)
            loc_oCol.AddObject("txt_4c_CelPrazo", "TextBoxCelulaTamanho_4c")
        ENDIF
        loc_oTxt = loc_oCol.txt_4c_CelPrazo
        WITH loc_oTxt
            .this_cPapel = "PRAZO"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Margin      = 0
            .BorderStyle = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .InputMask   = "99"
            .Visible     = .T.
        ENDWITH
        loc_oCol.CurrentControl = "txt_4c_CelPrazo"
        loc_oCol.Sparse         = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CelulaGradeEditavel - WHEN das seis celulas (chamado pela classe da
    * celula). Transcreve os seis When do legado:
    *   Column1    this.Tag = this.Value, Return InList(pcEscolha,INSERIR/ALTERAR)
    *   Column2    idem + And Empty(Grade.Column1.text1.Value)
    *   Column3    Return InList(...)
    *   Column4/5/6  ThisForm.peAntValue = This.Value, Return InList(...)
    * O peAntValue unico do legado vira uma property por coluna, para nao
    * depender da ordem em que o usuario passa pelas celulas.
    * PUBLIC - chamado de fora da classe do form (regra #3/#51).
    *--------------------------------------------------------------------------
    FUNCTION CelulaGradeEditavel(par_cPapel, par_oTxt)
        LOCAL loc_cPapel, loc_lEditavel, loc_nValor

        loc_cPapel    = IIF(VARTYPE(par_cPapel) = "C", UPPER(ALLTRIM(par_cPapel)), "")
        loc_lEditavel = INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")

        IF VARTYPE(par_oTxt) != "O"
            RETURN loc_lEditavel
        ENDIF

        loc_nValor = IIF(VARTYPE(par_oTxt.Value) = "N", par_oTxt.Value, 0)

        DO CASE
            CASE loc_cPapel == "COD"
                *-- Tag eh ESTRITAMENTE Character no VFP9 - guardar so texto
                par_oTxt.Tag = ALLTRIM(TRANSFORM(par_oTxt.Value))

            CASE loc_cPapel == "DESC"
                par_oTxt.Tag = ALLTRIM(TRANSFORM(par_oTxt.Value))

                *-- Legado: a Descricao so eh editavel enquanto o CODIGO
                *-- estiver vazio. O When roda ANTES da edicao, entao a
                *-- leitura pode sair do cursor (a celula ainda nao mudou).
                IF loc_lEditavel AND USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                    loc_lEditavel = EMPTY(ALLTRIM(cursor_4c_Dados.codtams))
                ENDIF

            CASE loc_cPapel == "PESO"
                THIS.this_nPesoAnterior = loc_nValor

            CASE loc_cPapel == "PERC" OR loc_cPapel == "VALOR"
                THIS.this_nValorAnterior = loc_nValor

            CASE loc_cPapel == "PRAZO"
                THIS.this_nPrazoAnterior = loc_nValor
        ENDCASE

        RETURN loc_lEditavel
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCelulaGradeExec - VALID das seis celulas (chamado pela classe da
    * celula). Despacha para o validador de cada papel. Dentro do Valid o
    * valor digitado esta em par_oTxt.Value e AINDA NAO chegou ao cursor
    * (regra #46) - por isso cada validador escreve no cursor por conta
    * propria antes de mandar gravar.
    * PUBLIC - chamado de fora da classe do form (regra #3/#51).
    *--------------------------------------------------------------------------
    FUNCTION ValidarCelulaGradeExec(par_cPapel, par_oTxt)
        LOCAL loc_cPapel, loc_lOk
        loc_lOk    = .T.
        loc_cPapel = IIF(VARTYPE(par_cPapel) = "C", UPPER(ALLTRIM(par_cPapel)), "")

        IF VARTYPE(par_oTxt) != "O" OR !USED("cursor_4c_Dados")
            RETURN .T.
        ENDIF

        IF EOF("cursor_4c_Dados")
            RETURN .T.
        ENDIF

        *-- Legado: todo Valid desta grade vive sob o When, que so libera a
        *-- celula em INSERIR/ALTERAR
        IF !INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
            RETURN .T.
        ENDIF

        DO CASE
            CASE loc_cPapel == "COD"
                loc_lOk = THIS.ValidarTamanhoGridExec(par_oTxt, "cods")

            CASE loc_cPapel == "DESC"
                loc_lOk = THIS.ValidarTamanhoGridExec(par_oTxt, "descs")

            CASE loc_cPapel == "PERC"
                loc_lOk = THIS.ValidarPercGridExec(par_oTxt)

            CASE loc_cPapel == "VALOR"
                loc_lOk = THIS.ValidarValorGridExec(par_oTxt)

            CASE loc_cPapel == "PESO"
                loc_lOk = THIS.GravarCelulaNumericaExec(par_oTxt, "PESO")

            CASE loc_cPapel == "PRAZO"
                loc_lOk = THIS.GravarCelulaNumericaExec(par_oTxt, "PRAZO")
        ENDCASE

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarTamanhoGridExec - Valid das celulas de Tamanho (Column1 por
    * Codigo, Column2 por Descricao). Transcricao dos DOIS Valid do legado:
    *   If this.Tag <> this.Value            -> celula nao tocada, nada a fazer
    *     If Not Empty(This.Value)           -> abre fwBuscaExt em SigCdTam
    *        If Lastkey() <> 27              -> checa duplicidade; duplicado
    *                                           devolve .F., senao replace
    *                                           CodTams/Descs
    *        Else                            -> replace CodTams/Descs vazios
    *     Else                               -> replace CodTams/Descs vazios
    *   ThisForm.Grade.Refresh()
    * PUBLIC - alvo do despachante e do atalho F4 (regra #3/#51).
    *--------------------------------------------------------------------------
    FUNCTION ValidarTamanhoGridExec(par_oTxt, par_cCampoBusca)
        LOCAL loc_cValorAtual, loc_cValorAnterior, loc_cCidChaves, loc_lOk

        loc_lOk            = .T.
        loc_cValorAtual    = ALLTRIM(TRANSFORM(par_oTxt.Value))
        loc_cValorAnterior = ALLTRIM(TRANSFORM(par_oTxt.Tag))

        *-- Legado: "If this.Tag <> this.Value" - sem mudanca, sem lookup
        IF loc_cValorAtual == loc_cValorAnterior
            RETURN .T.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCidChaves = ALLTRIM(cidchaves)

        IF EMPTY(loc_cValorAtual)
            *-- Legado: replace CodTams with [], Descs with []
            THIS.LimparCampos()
            par_oTxt.Value = ""
        ELSE
            loc_lOk = THIS.ResolverTamanhoSelecionado(loc_cValorAtual, loc_cCidChaves, ;
                                                      par_cCampoBusca, par_oTxt)
        ENDIF

        par_oTxt.Tag = ALLTRIM(TRANSFORM(par_oTxt.Value))

        THIS.grd_4c_Dados.Refresh()

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarPercGridExec - Valid da celula Percentual (Column4). Formula
    * TRANSCRITA do legado (regra #17):
    *     lnValor = crSigCdPro.PVens + (crSigCdPro.PVens * (lnPerc/100))
    *     Replace Valor With lnValor in crSigPrTam
    * Com Percs zerado o legado NAO zera o Valor existente (o Replace esta
    * dentro do "If Not Empty(This.Value)") - reproduzido aqui.
    * PUBLIC - alvo do despachante (regra #3/#51).
    *--------------------------------------------------------------------------
    FUNCTION ValidarPercGridExec(par_oTxt)
        LOCAL loc_nValorCelula, loc_nPerc, loc_nValor

        loc_nValorCelula = IIF(VARTYPE(par_oTxt.Value) = "N", par_oTxt.Value, ;
                               VAL(TRANSFORM(par_oTxt.Value)))

        *-- Legado: "If (This.Value <> ThisForm.peAntValue)"
        IF loc_nValorCelula = THIS.this_nValorAnterior
            RETURN .T.
        ENDIF

        SELECT cursor_4c_Dados

        *-- O cursor so recebe o digitado DEPOIS do Valid (regra #46) - e a
        *-- gravacao le do cursor, entao a celula vai para la agora
        REPLACE percs WITH loc_nValorCelula IN cursor_4c_Dados

        IF loc_nValorCelula != 0
            loc_nPerc  = loc_nValorCelula
            loc_nValor = THIS.this_nPrecoVenda + (THIS.this_nPrecoVenda * (loc_nPerc / 100))
            REPLACE valor WITH loc_nValor IN cursor_4c_Dados
        ENDIF

        THIS.this_nValorAnterior = loc_nValorCelula

        THIS.GravarLinhaAtual()
        THIS.grd_4c_Dados.Refresh()

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarValorGridExec - Valid da celula Valor (Column5). Formula
    * TRANSCRITA do legado (regra #17):
    *     lnPerc = ((lnValor - crSigCdPro.PVens)/crSigCdPro.PVens)*100
    *     Replace Percs With lnPerc In crSigPrTam
    * com o MESMO aviso quando o produto nao tem preco de venda. Guarda extra
    * (PVens <> 0) que o legado NAO tem: la a divisao por zero estouraria em
    * runtime logo depois do aviso.
    * PUBLIC - alvo do despachante (regra #3/#51).
    *--------------------------------------------------------------------------
    FUNCTION ValidarValorGridExec(par_oTxt)
        LOCAL loc_nValorCelula, loc_nPerc, loc_nValor

        loc_nValorCelula = IIF(VARTYPE(par_oTxt.Value) = "N", par_oTxt.Value, ;
                               VAL(TRANSFORM(par_oTxt.Value)))

        IF loc_nValorCelula = THIS.this_nValorAnterior
            RETURN .T.
        ENDIF

        SELECT cursor_4c_Dados

        IF loc_nValorCelula != 0
            loc_nValor = loc_nValorCelula
            loc_nPerc  = 0

            IF EMPTY(THIS.this_nPrecoVenda)
                MsgAviso("Favor Informar o Pre" + CHR(231) + "o de Venda do Produto.", "Aviso")
                loc_nValor     = 0
                par_oTxt.Value = loc_nValor
            ENDIF

            IF THIS.this_nPrecoVenda != 0
                loc_nPerc = ((loc_nValor - THIS.this_nPrecoVenda) / THIS.this_nPrecoVenda) * 100
            ENDIF

            REPLACE valor WITH loc_nValor, percs WITH loc_nPerc IN cursor_4c_Dados
        ELSE
            REPLACE valor WITH loc_nValorCelula IN cursor_4c_Dados
        ENDIF

        THIS.this_nValorAnterior = IIF(VARTYPE(par_oTxt.Value) = "N", par_oTxt.Value, ;
                                       loc_nValorCelula)

        THIS.GravarLinhaAtual()
        THIS.grd_4c_Dados.Refresh()

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarCelulaNumericaExec - Valid das celulas Peso Medio (Column3) e
    * Entrega (Column6). O legado nao tem Valid nelas: a gravacao vinha do
    * TABLEUPDATE do form pai, que compartilhava a DataSession. Aqui a
    * DataSession eh PRIVADA, entao a persistencia tem de ser explicita -
    * senao o que o usuario digita nessas duas colunas se perde ao encerrar.
    * PUBLIC - alvo do despachante (regra #3/#51).
    *--------------------------------------------------------------------------
    FUNCTION GravarCelulaNumericaExec(par_oTxt, par_cCampo)
        LOCAL loc_nValorCelula, loc_nAnterior, loc_lPeso

        loc_lPeso        = (VARTYPE(par_cCampo) = "C" AND UPPER(ALLTRIM(par_cCampo)) == "PESO")
        loc_nValorCelula = IIF(VARTYPE(par_oTxt.Value) = "N", par_oTxt.Value, ;
                               VAL(TRANSFORM(par_oTxt.Value)))
        loc_nAnterior    = IIF(loc_lPeso, THIS.this_nPesoAnterior, THIS.this_nPrazoAnterior)

        IF loc_nValorCelula = loc_nAnterior
            RETURN .T.
        ENDIF

        SELECT cursor_4c_Dados

        IF loc_lPeso
            REPLACE pesoms WITH loc_nValorCelula IN cursor_4c_Dados
            THIS.this_nPesoAnterior = loc_nValorCelula
        ELSE
            REPLACE diasprz WITH loc_nValorCelula IN cursor_4c_Dados
            THIS.this_nPrazoAnterior = loc_nValorCelula
        ENDIF

        THIS.GravarLinhaAtual()

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirLookupTamanhoGrade - Atalho F4/F5 e duplo clique nas celulas de
    * Tamanho. Entra no MESMO funil do Valid (ResolverTamanhoSelecionado),
    * por isso a guarda de reentrancia do picker (this_lLookupAberto, dentro
    * de AbrirLookupTamanho) cobre as duas entradas.
    * PUBLIC - chamado pela classe da celula (regra #3/#51).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupTamanhoGrade(par_cPapel, par_oTxt)
        LOCAL loc_cCampoBusca, loc_cCidChaves, loc_cValor

        IF VARTYPE(par_oTxt) != "O" OR !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        IF EOF("cursor_4c_Dados")
            RETURN
        ENDIF

        IF !INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        loc_cCampoBusca = IIF(VARTYPE(par_cPapel) = "C" AND ;
                              UPPER(ALLTRIM(par_cPapel)) == "DESC", "descs", "cods")
        loc_cValor      = ALLTRIM(TRANSFORM(par_oTxt.Value))

        SELECT cursor_4c_Dados
        loc_cCidChaves = ALLTRIM(cidchaves)

        THIS.ResolverTamanhoSelecionado(loc_cValor, loc_cCidChaves, loc_cCampoBusca, par_oTxt)

        *-- Sincroniza o Tag: o Valid que vem logo a seguir (ao sair da
        *-- celula) nao pode reabrir o picker pelo valor que o F4 acabou de
        *-- resolver
        par_oTxt.Tag = ALLTRIM(TRANSFORM(par_oTxt.Value))

        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ResolverTamanhoSelecionado - Tenta o match EXATO em SigCdTam (por cods
    * ou por descs, conforme par_cCampoBusca); sem match, abre o picker
    * (AbrirLookupTamanho). Com o tamanho resolvido, confere duplicidade
    * contra as demais linhas do MESMO produto antes de gravar - igual ao
    * "Select ... Where a.CodTams = CrListaRemota.Cods And a.cIdChaves <>
    * crSigPrTam.cIdChaves" dos dois Valid legado.
    *
    * Devolve .F. SO no caso de duplicidade, que eh o unico "Return .F." dos
    * Valid do legado (o foco fica na celula e a linha nao eh alterada).
    *
    * As comparacoes de cidchaves/codtams levam ALLTRIM dos DOIS lados: o
    * cursor guarda char(20)/char(4) com padding e o config.prg roda com
    * SET EXACT ON, onde "valor padded" == "valor trimado" eh sempre .F. -
    * sem o ALLTRIM a propria linha corrente contaria como duplicata de si
    * mesma e nenhum tamanho poderia ser escolhido.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ResolverTamanhoSelecionado(par_cValor, par_cCidChaves, par_cCampoBusca, par_oTxt)
        LOCAL loc_cSQL, loc_nResultado, loc_lAchou, loc_cCodigoSel, loc_cDescrSel
        LOCAL loc_lDuplicado, loc_cCampoBusca, loc_lOk

        loc_lOk         = .T.
        loc_lAchou      = .F.
        loc_cCodigoSel  = ""
        loc_cDescrSel   = ""
        loc_cCampoBusca = IIF(VARTYPE(par_cCampoBusca) = "C" AND ;
                              LOWER(ALLTRIM(par_cCampoBusca)) == "descs", "descs", "cods")

        IF USED("cursor_4c_LkpTamExato")
            USE IN cursor_4c_LkpTamExato
        ENDIF

        IF !EMPTY(ALLTRIM(par_cValor))
            loc_cSQL = "SELECT cods, descs FROM SigCdTam WHERE " + loc_cCampoBusca + " = " + ;
                       EscaparSQL(par_cValor)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpTamExato")

            IF loc_nResultado > 0 AND USED("cursor_4c_LkpTamExato") AND ;
               RECCOUNT("cursor_4c_LkpTamExato") = 1
                loc_cCodigoSel = ALLTRIM(cursor_4c_LkpTamExato.cods)
                loc_cDescrSel  = ALLTRIM(cursor_4c_LkpTamExato.descs)
                loc_lAchou     = .T.
            ENDIF

            IF USED("cursor_4c_LkpTamExato")
                USE IN cursor_4c_LkpTamExato
            ENDIF
        ENDIF

        IF !loc_lAchou
            IF THIS.AbrirLookupTamanho(par_cValor, loc_cCampoBusca)
                loc_cCodigoSel = ALLTRIM(THIS.this_cLkpCodigo)
                loc_cDescrSel  = ALLTRIM(THIS.this_cLkpDescricao)
                loc_lAchou     = !EMPTY(loc_cCodigoSel)
            ENDIF
        ENDIF

        *-- O picker eh MODAL e mexe no ponteiro de outras areas - voltar
        *-- para a linha que estava sendo editada ANTES de qualquer REPLACE
        SELECT cursor_4c_Dados
        LOCATE FOR ALLTRIM(cidchaves) == ALLTRIM(par_cCidChaves)

        IF !loc_lAchou
            *-- Legado: ESC no picker -> replace CodTams/Descs com vazio
            THIS.LimparCampos()
            IF VARTYPE(par_oTxt) = "O"
                par_oTxt.Value = ""
            ENDIF
            RETURN .T.
        ENDIF

        loc_lDuplicado = .F.
        SELECT cursor_4c_Dados
        SCAN FOR ALLTRIM(codtams) == loc_cCodigoSel AND ;
                 ALLTRIM(cidchaves) <> ALLTRIM(par_cCidChaves)
            loc_lDuplicado = .T.
            EXIT
        ENDSCAN

        SELECT cursor_4c_Dados
        LOCATE FOR ALLTRIM(cidchaves) == ALLTRIM(par_cCidChaves)

        IF loc_lDuplicado
            MsgAviso("Tamanho j" + CHR(225) + " informado para este produto!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            *-- Legado: Return .F. - a linha NAO eh alterada e o foco fica na
            *-- celula para o usuario corrigir
            loc_lOk = .F.
        ELSE
            REPLACE codtams WITH loc_cCodigoSel, descs WITH loc_cDescrSel IN cursor_4c_Dados

            *-- O valor resolvido tem de voltar para a CELULA tambem, senao o
            *-- texto digitado sobrescreve o cursor ao fim do Valid (regra #46)
            IF VARTYPE(par_oTxt) = "O"
                par_oTxt.Value = IIF(loc_cCampoBusca == "descs", loc_cDescrSel, loc_cCodigoSel)
            ENDIF

            *-- Grava em SigPrTam na hora (INSERT na linha nova, UPDATE na que
            *-- veio do CarregarLista) - o legado delegava ao TABLEUPDATE do
            *-- form pai; esta DataSession eh propria, entao a gravacao tem de
            *-- ser explicita, senao a escolha do usuario se perde ao encerrar.
            THIS.GravarLinhaAtual()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirLookupTamanho - Picker de tamanhos (SigCdTam) - transcricao do
    *   CreateObject('fwbuscaext', <conn>, 'SigCdTam', 'CrListaRemota',
    *                 'Cods'|'Descs', This.Value, 'Selecao', .t.)
    * dos DOIS Valid do legado. Ao contrario do lookup de Caracteristicas
    * (FormSigPrCar), o legado NAO filtra por grupo do produto aqui.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AbrirLookupTamanho(par_cValorFiltro, par_cCampoBusca)
        LOCAL loc_oBusca, loc_cSQL, loc_nResultado, loc_cCursor, loc_cCampo
        LOCAL loc_lSelecionou, loc_cValor, loc_cTitulo, loc_oErro

        loc_lSelecionou = .F.
        THIS.this_cLkpCodigo    = ""
        THIS.this_cLkpDescricao = ""

        IF THIS.this_lLookupAberto
            RETURN .F.
        ENDIF
        THIS.this_lLookupAberto = .T.

        loc_cCursor = "cursor_4c_BuscaTamanho"
        loc_cValor  = IIF(VARTYPE(par_cValorFiltro) = "C", ALLTRIM(par_cValorFiltro), "")
        loc_cCampo  = IIF(VARTYPE(par_cCampoBusca) = "C" AND LOWER(ALLTRIM(par_cCampoBusca)) == "descs", ;
                          "descs", "cods")
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"

        TRY
            IF USED(loc_cCursor)
                USE IN SELECT(loc_cCursor)
            ENDIF

            IF !EMPTY(loc_cValor)
                loc_cSQL = "SELECT cods AS Cods, descs AS Descs FROM SigCdTam" + ;
                           " WHERE (cods LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR descs LIKE " + EscaparSQL(loc_cValor + "%") + ")" + ;
                           " ORDER BY " + loc_cCampo
            ELSE
                loc_cSQL = "SELECT cods AS Cods, descs AS Descs FROM SigCdTam" + ;
                           " ORDER BY " + loc_cCampo
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

            *-- Fallback SHOW-ALL: o prefixo nao casou nada - mostrar todos os
            *-- tamanhos em vez de abrir o picker vazio
            IF loc_nResultado > 0 AND USED(loc_cCursor) AND ;
               RECCOUNT(loc_cCursor) = 0 AND !EMPTY(loc_cValor)
                USE IN SELECT(loc_cCursor)
                loc_cSQL = "SELECT cods AS Cods, descs AS Descs FROM SigCdTam" + ;
                           " ORDER BY " + loc_cCampo
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao consultar tamanhos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                    MsgAviso("Nenhum tamanho dispon" + CHR(237) + "vel.", loc_cTitulo)
                ELSE
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.DefinirCursor(loc_cCursor, "Cods", "Descs", loc_cTitulo)

                        loc_oBusca.this_nColunas = 0
                        IF loc_cCampo == "descs"
                            loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
                        ELSE
                            loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
                            loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        ENDIF

                        IF loc_oBusca.Mostrar()
                            THIS.this_cLkpCodigo    = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                            THIS.this_cLkpDescricao = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                            loc_lSelecionou         = .T.
                        ENDIF

                        loc_oBusca.Release()
                        loc_oBusca = .NULL.
                    ENDIF
                ENDIF
            ENDIF

            IF USED(loc_cCursor)
                USE IN SELECT(loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir a busca de tamanhos:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            IF USED(loc_cCursor)
                USE IN SELECT(loc_cCursor)
            ENDIF
        ENDTRY

        THIS.this_lLookupAberto = .F.

        RETURN loc_lSelecionou
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere a LINHA CORRENTE da grade para o BO. Reusa
    * sigprtamBO.CarregarDoCursor (ja faz SELECT (alias) + TratarNulo campo a
    * campo) em vez de duplicar a leitura aqui.
    * PROTECTED por heranca de FormBase (regra #3/#51) - chamado so de dentro
    * da classe (GravarLinhaAtual).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        IF !USED("cursor_4c_Dados") OR VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF()
            RETURN .F.
        ENDIF

        RETURN THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Sentido inverso: escreve as propriedades do BO na LINHA
    * CORRENTE da grade. Chamado depois de um Salvar() bem-sucedido, para a
    * grade exibir o que o BO efetivamente levou ao banco (em especial o
    * cidchaves, se o BO tiver precisado gera-lo).
    * PROTECTED por heranca de FormBase - chamado so de dentro (GravarLinhaAtual).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF !USED("cursor_4c_Dados") OR VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF()
            RETURN .F.
        ENDIF

        *-- Cobertura: as OITO colunas que ESTA tela pode alterar. As tres
        *-- restantes de SigPrTam (dataalts/datatrans/dtmovs) ficam de fora
        *-- DE PROPOSITO: nao tem controle na tela, o BO as le no
        *-- CarregarDoCursor e as devolve INTACTAS no UPDATE/INSERT, logo
        *-- reescreve-las no cursor seria no-op. Pior, a property e a coluna
        *-- podem divergir de tipo (DATE vazia na linha nascida do APPEND
        *-- BLANK x datetime do cursor), o que so criaria risco de "Data type
        *-- mismatch" sem nada em troca.
        WITH THIS.this_oBusinessObject
            REPLACE cidchaves WITH .this_cCidChaves, ;
                    codtams   WITH .this_cCodTams, ;
                    cpros     WITH .this_cCpros, ;
                    pesoms    WITH .this_nPesoMs, ;
                    percs     WITH .this_nPercs, ;
                    valor     WITH .this_nValor, ;
                    diasprz   WITH .this_nDiasPrz, ;
                    descs     WITH .this_cDescs ;
                 IN cursor_4c_Dados
        ENDWITH

        THIS.grd_4c_Dados.Refresh()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa Codigo/Descricao da LINHA CORRENTE da grade.
    * Transcricao do "Replace CodTams With [], Descs With [] In crSigPrTam"
    * que os DOIS Valid do legado executam (celula esvaziada pelo usuario,
    * picker dispensado, escolha recusada por duplicidade). A linha em si
    * NAO eh apagada aqui, igual ao legado.
    * PROTECTED por heranca de FormBase - chamado so de dentro.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        IF !USED("cursor_4c_Dados")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF()
            RETURN .F.
        ENDIF

        REPLACE codtams WITH "", descs WITH "" IN cursor_4c_Dados

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarLinhaAtual - Persiste em SigPrTam a LINHA CORRENTE da grade.
    * INSERT quando a linha nasceu nesta sessao (BtnInserirClick), UPDATE
    * quando ja veio do CarregarLista ou ja foi gravada antes. So grava
    * quando CodTams ja foi resolvido (linha ainda em branco nao tem o que
    * persistir - mesma condicao implicita do legado, que so comecava a
    * fazer sentido depois do Tamanho escolhido).
    * PUBLIC - chamado pelos handlers de celula.
    *--------------------------------------------------------------------------
    PROCEDURE GravarLinhaAtual()
        LOCAL loc_cCidChaves, loc_lNovo, loc_lSucesso
        loc_lSucesso = .F.

        IF !USED("cursor_4c_Dados") OR VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF() OR EMPTY(ALLTRIM(codtams))
            RETURN .F.
        ENDIF

        loc_cCidChaves = ALLTRIM(cidchaves)
        loc_lNovo      = THIS.EhRegistroNovo(loc_cCidChaves)

        IF loc_lNovo
            *-- NovoRegistro() chama LimparDados() - preencher DEPOIS dele
            THIS.this_oBusinessObject.NovoRegistro()
        ELSE
            THIS.this_oBusinessObject.this_lNovoRegistro = .F.
            THIS.this_oBusinessObject.EditarRegistro()
        ENDIF

        SELECT cursor_4c_Dados
        *-- ALLTRIM dos DOIS lados: medido no VFP9, "<char(20) padded> ==
        *-- <valor trimado>" eh .F. sempre (o == compara o comprimento
        *-- tambem, independente de SET EXACT). Sem isto o LOCATE falha em
        *-- toda chave mais curta que 20 e a gravacao devolve .F. em silencio.
        LOCATE FOR ALLTRIM(cidchaves) == ALLTRIM(loc_cCidChaves)
        IF !FOUND()
            RETURN .F.
        ENDIF

        IF !THIS.FormParaBO()
            RETURN .F.
        ENDIF

        IF THIS.this_oBusinessObject.Salvar()
            loc_lSucesso = .T.
            THIS.BOParaForm()

            IF loc_lNovo
                THIS.RemoverCidChaveNova(loc_cCidChaves)
                THIS.RemoverCidChaveNova(THIS.this_oBusinessObject.this_cCidChaves)
                THIS.this_lHouveIncl = .T.
            ENDIF
        ELSE
            IF !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o tamanho.", "Erro")
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca os tamanhos do produto corrente e vincula a
    * grade. PUBLIC (nao PROTECTED) - TesteAutomatico.prg chama metodos do
    * form direto de fora da classe (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lSucesso = THIS.this_oBusinessObject.Buscar(THIS.this_cCodProduto)
        ENDIF

        *-- Cursor recem-lido do banco: toda linha existe em SigPrTam, logo
        *-- nao ha mais pendencia de INSERT
        THIS.this_cCidChavesNovos = ""

        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            GO TOP

            *-- RecordSource com referencia EXPLICITA, FORA de WITH (regra
            *-- #36/#41)
            THIS.grd_4c_Dados.RecordSource = ""

            *-- ColumnCount TEM de ser reposto ANTES do RecordSource: o
            *-- Buscar() do BO faz "USE IN cursor_4c_Dados" + recria o alias,
            *-- e derrubar o alias ligado a grade ZERA o ColumnCount. Medido
            *-- no VFP9 (2026-10-19): 6 -> 0 no USE IN e, religando sem
            *-- repor, o VFP auto-expande para as 11 COLUNAS do cursor -
            *-- a grade passa a exibir cidchaves/cpros/dataalts/datatrans/
            *-- dtmovs crus a direita das seis colunas do legado, sem erro e
            *-- sem log. Reatribuir ColumnCount destroi os controles postos
            *-- por AddObject nas Columns, mas InstalarCelulasGrade() logo
            *-- abaixo os reinstala (guarda PEMSTATUS).
            THIS.grd_4c_Dados.ColumnCount  = 6

            THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
            THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.codtams"
            THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Dados.descs"
            THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Dados.pesoms"
            THIS.grd_4c_Dados.Column4.ControlSource = "cursor_4c_Dados.percs"
            THIS.grd_4c_Dados.Column5.ControlSource = "cursor_4c_Dados.valor"
            THIS.grd_4c_Dados.Column6.ControlSource = "cursor_4c_Dados.diasprz"

            *-- RecordSource/ControlSource resetam Width e Header1.Caption -
            *-- reconfigurar SEMPRE depois de vincular (regra #48)
            THIS.grd_4c_Dados.Column1.Width           = 38
            THIS.grd_4c_Dados.Column1.Header1.Caption = "Tam."
            THIS.grd_4c_Dados.Column2.Width           = 216
            THIS.grd_4c_Dados.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            THIS.grd_4c_Dados.Column3.Width           = 100
            THIS.grd_4c_Dados.Column3.Header1.Caption = "Peso M" + CHR(233) + "dio"
            THIS.grd_4c_Dados.Column4.Width           = 80
            THIS.grd_4c_Dados.Column4.Header1.Caption = "Percentual"
            THIS.grd_4c_Dados.Column5.Width           = 100
            THIS.grd_4c_Dados.Column5.Header1.Caption = "Valor"
            THIS.grd_4c_Dados.Column6.Width           = 60
            THIS.grd_4c_Dados.Column6.Header1.Caption = "Entrega"

            *-- Re-vincular RecordSource/ControlSource reseta propriedades de
            *-- Column - CurrentControl e Sparse entre elas. Sem reinstalar,
            *-- a coluna volta a desenhar o Text1 nativo e o When/Valid das
            *-- celulas (lookup de Tamanho, calculo Percentual<->Valor) para
            *-- de rodar, sem erro nenhum na tela.
            THIS.InstalarCelulasGrade()

            *-- Column.ReadOnly tambem se perde no rebind - reaplicar o modo
            THIS.HabilitarCampos(INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR"))

            THIS.grd_4c_Dados.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosProduto - Le SigCdPro.Dpros/PVens/PCuss do produto
    * corrente - equivalente ao "Select Dpros, pvens, pcuss From SigCdPro
    * Where Cpros = ..." do Init legado (pdPro/crSigCdPro.PVens/PCuss),
    * usado pelo calculo Percentual<->Valor das celulas da grade.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDadosProduto()
        LOCAL loc_cSQL, loc_nResultado, loc_oErro

        TRY
            IF USED("cursor_4c_DadosProduto")
                USE IN cursor_4c_DadosProduto
            ENDIF

            loc_cSQL = "SELECT Dpros, PVens, PCuss FROM SigCdPro WHERE Cpros = " + ;
                       EscaparSQL(THIS.this_cCodProduto)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosProduto")

            IF loc_nResultado > 0 AND USED("cursor_4c_DadosProduto") AND ;
               RECCOUNT("cursor_4c_DadosProduto") > 0
                THIS.this_cDescProduto = TratarNulo(cursor_4c_DadosProduto.Dpros, "")
                THIS.this_nPrecoVenda  = TratarNulo(cursor_4c_DadosProduto.PVens, 0)
                THIS.this_nPrecoCusto  = TratarNulo(cursor_4c_DadosProduto.PCuss, 0)
            ENDIF

            IF USED("cursor_4c_DadosProduto")
                USE IN cursor_4c_DadosProduto
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao ler dados do produto: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirClick - Espelha cmdInserir.Click do legado: garante UMA
    * linha em branco (CodTams vazio) para o usuario preencher via lookup.
    * Legado: Locate For cPros=crSigCdPro.cPros And CodTams=Space(4) / If
    * Eof() / Insert Into crSigPrTam (cPros, CidChaves) Values (...)
    * PUBLIC - alvo de BINDEVENT (regra #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirClick()
        LOCAL loc_cCidNovo

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        THIS.this_lHouveIncl = .T.

        SELECT cursor_4c_Dados
        LOCATE FOR ALLTRIM(cpros) == ALLTRIM(THIS.this_cCodProduto) AND EMPTY(codtams)

        IF !FOUND()
            loc_cCidNovo = fUniqueIds()

            APPEND BLANK
            REPLACE cpros     WITH THIS.this_cCodProduto, ;
                    cidchaves WITH loc_cCidNovo, ;
                    codtams   WITH "", ;
                    descs     WITH "", ;
                    pesoms    WITH 0, ;
                    percs     WITH 0, ;
                    valor     WITH 0, ;
                    diasprz   WITH 0

            *-- Linha existe so no cursor local ate o usuario escolher o
            *-- tamanho (GravarLinhaAtual faz o INSERT)
            THIS.RegistrarCidChaveNova(loc_cCidNovo)
        ENDIF

        *-- Popular o cursor NAO repinta a grade (regra #21)
        THIS.grd_4c_Dados.Refresh()
        THIS.grd_4c_Dados.Column1.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Espelha cmdExcluir.Click do legado. Linha ja
    * persistida (CodTams preenchido, ja gravada) eh excluida de verdade via
    * BO (gravacao nunca eh muda); linha ainda em edicao (CodTams vazio,
    * nunca gravada) eh so removida do cursor local.
    * PUBLIC - alvo de BINDEVENT (regra #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCidChaves, loc_lRemover

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF()
            RETURN
        ENDIF

        *-- Guard do legado: "If Not Eof() And (crSigPrTam.cPros =
        *-- crSigCdPro.cPros)" - so apaga linha do produto corrente
        IF ALLTRIM(cpros) != ALLTRIM(THIS.this_cCodProduto)
            RETURN
        ENDIF

        loc_cCidChaves = ALLTRIM(cidchaves)

        loc_lRemover = .T.

        IF !EMPTY(codtams) AND !THIS.EhRegistroNovo(loc_cCidChaves)
            *-- Linha JA persistida: apaga primeiro no banco. Falhando, a
            *-- linha CONTINUA na grade (apagar so o visual esconderia um
            *-- registro que segue existindo em SigPrTam) e a mensagem nunca
            *-- eh muda (regra #20).
            THIS.this_oBusinessObject.this_cCidChaves    = loc_cCidChaves
            THIS.this_oBusinessObject.this_lNovoRegistro = .F.

            IF !THIS.this_oBusinessObject.Excluir()
                loc_lRemover = .F.

                IF !THIS.this_oBusinessObject.this_lErroExibido
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o tamanho.", "Erro")
                ENDIF
            ENDIF
        ENDIF

        IF loc_lRemover
            *-- Remocao LOCAL nos DOIS casos (linha persistida e linha em
            *-- branco), exatamente como o legado: "Delete / Skip / Skip -1"
            *-- do cmdExcluir.Click.
            *--
            *-- NAO recarregar a grade do banco aqui. O SELECT do BO traz
            *-- "SPACE(20) AS descs" - transcricao do "Space(40) as Descs" do
            *-- Init legado, porque a Descricao do tamanho so eh resolvida em
            *-- runtime pelo lookup da celula. Um CarregarLista() no meio do
            *-- dialogo APAGARIA a Descricao ja resolvida em TODAS as outras
            *-- linhas (o usuario apaga uma linha e a coluna Descricao das
            *-- demais fica em branco, sem erro nenhum) e ainda descartaria a
            *-- linha em branco que BtnInserirClick acabou de criar (e que
            *-- ainda nao foi gravada) junto com o cidchaves dela em
            *-- this_cCidChavesNovos.
            *--
            *-- Reposicionar ANTES do DELETE: Excluir() do BO roda SQLEXEC
            *-- (DELETE + INSERT da auditoria), e o DELETE/SKIP abaixo age na
            *-- area de trabalho CORRENTE - sem o SELECT/LOCATE o apagamento
            *-- poderia cair na linha errada.
            SELECT cursor_4c_Dados
            LOCATE FOR ALLTRIM(cidchaves) == ALLTRIM(loc_cCidChaves)

            IF FOUND()
                THIS.RemoverCidChaveNova(loc_cCidChaves)

                DELETE
                SKIP
                SKIP -1

                THIS.this_lHouveExcl = .T.

                *-- Popular/alterar o cursor NAO repinta a grade (regra #21)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Espelha cmdSair.Click do legado: em modo INSERIR/ALTERAR,
    * exige que TODA linha tenha CodTams preenchido antes de encerrar (sem
    * limpeza silenciosa - o legado ABORTA o fechamento com aviso e foca a
    * grade). O re-habilitar do form pai fica no Destroy (vale em qualquer
    * caminho de fechamento).
    * PUBLIC - alvo de BINDEVENT (regra #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        IF (THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible) AND ;
           INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")

            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                SCAN
                    IF EMPTY(codtams)
                        MsgAviso("Tamanho n" + CHR(227) + "o informado!", ;
                                  "Aten" + CHR(231) + CHR(227) + "o")
                        THIS.grd_4c_Dados.Column1.SetFocus()
                        RETURN
                    ENDIF
                ENDSCAN
            ENDIF
        ENDIF

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarCidChaveNova/RemoverCidChaveNova/EhRegistroNovo - Controle das
    * linhas criadas nesta sessao e ainda sem registro em SigPrTam (logo:
    * INSERT ao gravar, exclusao apenas local ao apagar).
    * PUBLIC - usados pelos handlers de botao/celula.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarCidChaveNova(par_cCidChaves)
        LOCAL loc_cCid
        loc_cCid = IIF(VARTYPE(par_cCidChaves) = "C", ALLTRIM(par_cCidChaves), "")

        IF !EMPTY(loc_cCid) AND !THIS.EhRegistroNovo(loc_cCid)
            THIS.this_cCidChavesNovos = THIS.this_cCidChavesNovos + "|" + loc_cCid + "|"
        ENDIF
    ENDPROC

    PROCEDURE RemoverCidChaveNova(par_cCidChaves)
        LOCAL loc_cCid
        loc_cCid = IIF(VARTYPE(par_cCidChaves) = "C", ALLTRIM(par_cCidChaves), "")

        IF !EMPTY(loc_cCid)
            THIS.this_cCidChavesNovos = STRTRAN(THIS.this_cCidChavesNovos, "|" + loc_cCid + "|", "")
        ENDIF
    ENDPROC

    PROCEDURE EhRegistroNovo(par_cCidChaves)
        LOCAL loc_cCid
        loc_cCid = IIF(VARTYPE(par_cCidChaves) = "C", ALLTRIM(par_cCidChaves), "")

        RETURN !EMPTY(loc_cCid) AND ("|" + loc_cCid + "|") $ THIS.this_cCidChavesNovos
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Botoes standalone (fwbtng do legado) -
    * Themes=.T.+DisabledPicture obrigatorios em CommandButton icone-only
    * fora de CommandGroup (senao o icone some quando Enabled=.F.).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_cIcones
        loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")

        THIS.AddObject("cmd_4c_Inserir", "CommandButton")
        WITH THIS.cmd_4c_Inserir
            .Top             = 3
            .Left            = 413
            .Width           = 75
            .Height          = 75
            .Caption         = "Inserir"
            .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_inserir_60.jpg"
            .Themes          = .T.
            .TabIndex        = 9
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "BtnInserirClick")

        THIS.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH THIS.cmd_4c_Excluir
            .Top             = 3
            .Left            = 488
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .Picture         = loc_cIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_excluir_60.jpg"
            .Themes          = .T.
            .TabIndex        = 7
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        THIS.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cmd_4c_Sair
            .Top             = 3
            .Left            = 563
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .Cancel          = .T.
            .TabIndex        = 8
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarVisibilidadePorModo - Espelha llVis = InList(.pcEscolha,
    * 'INSERIR','ALTERAR') do Init legado. Em modo VISUALIZAR, Inserir/
    * Excluir ficam ocultos e o Shape1 decorativo encolhe para abracar so o
    * botao Sair (legado: Shape1.Width = cmdSair.Width+10 / Shape1.Left =
    * cmdSair.Left-5).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarVisibilidadePorModo()
        LOCAL loc_lVis
        loc_lVis = INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")

        THIS.cmd_4c_Inserir.Visible = loc_lVis
        THIS.cmd_4c_Excluir.Visible = loc_lVis

        THIS.HabilitarCampos(loc_lVis)

        IF !loc_lVis
            THIS.shp_4c_Shape1.Width = THIS.cmd_4c_Sair.Width + 10
            THIS.shp_4c_Shape1.Left  = THIS.cmd_4c_Sair.Left - 5
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Liga/desliga a superficie EDITAVEL da tela:
    *   - .cmdInserir.Enabled = llVis / .cmdExcluir.Enabled = llVis (Init)
    *   - When de TODAS as celulas da grade, que retornam
    *     InList(ThisForm.pcEscolha,'INSERIR','ALTERAR')
    * Nesta tela nao existe "ficha" de TextBox soltos: os unicos campos
    * digitaveis sao as SEIS celulas da grade, por isso o equivalente age
    * sobre Column.ReadOnly em vez de Control.Enabled.
    * PUBLIC - chamado de AjustarVisibilidadePorModo.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.)

        THIS.cmd_4c_Inserir.Enabled = loc_lHab
        THIS.cmd_4c_Excluir.Enabled = loc_lHab

        *-- Grid.ReadOnly propaga para as Columns e SOBRESCREVE o ReadOnly
        *-- delas - tem de ser definido ANTES (CLAUDE.md regra #18)
        THIS.grd_4c_Dados.ReadOnly         = .F.
        THIS.grd_4c_Dados.Column1.ReadOnly = !loc_lHab
        THIS.grd_4c_Dados.Column2.ReadOnly = !loc_lHab
        THIS.grd_4c_Dados.Column3.ReadOnly = !loc_lHab
        THIS.grd_4c_Dados.Column4.ReadOnly = !loc_lHab
        THIS.grd_4c_Dados.Column5.ReadOnly = !loc_lHab
        THIS.grd_4c_Dados.Column6.ReadOnly = !loc_lHab

        *-- Encerrar nunca desabilita: eh o unico caminho de saida desta tela
        THIS.cmd_4c_Sair.Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
    * padrao; percorre recursivamente form/containers tornando tudo visivel.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_oContainer, loc_i, loc_oControl

        IF VARTYPE(par_oContainer) = "O"
            loc_oContainer = par_oContainer
        ELSE
            loc_oContainer = THIS
        ENDIF

        FOR loc_i = 1 TO loc_oContainer.ControlCount
            loc_oControl = loc_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Reabilita o form pai (fail-safe mesmo se algo falhar antes do
    * BtnSairClick fechar o dialogo normalmente) e libera BO/cursor/referencias
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        THIS.this_oFormPai = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprtamBO.prg):
*==============================================================================
* sigprtamBO.prg - Business Object para Tamanhos do Produto (SIGPRTAM)
* Tabela Principal: SigPrTam (PK: cidchaves)
* Tabela Relacionada: SigCdTam (cadastro de tamanhos - cods/descs/varias)
*
* SIGPRTAM e um dialogo filho chamado pelo cadastro de produtos para
* manter a grade de tamanhos (codigo, descricao, peso medio, percentual,
* valor e prazo de entrega) de UM produto por vez (filtro por cpros).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS sigprtamBO AS BusinessBase

    *-- Propriedades: SigPrTam
    this_cCidChaves  = ""   && cidchaves char(20) NOT NULL - PK
    this_cCodTams    = ""   && codtams   char(4)  NOT NULL - FK SigCdTam.cods
    this_cCpros      = ""   && cpros     char(14) NOT NULL - FK SigCdPro.cPros (produto filtrado)
    this_dDataAlts   = {}   && dataalts  datetime NULL
    this_dDataTrans  = {}   && datatrans datetime NULL
    this_dDtMovs     = {}   && dtmovs    datetime NULL
    this_nPesoMs     = 0    && pesoms    numeric(7,3) NOT NULL - peso medio do tamanho
    this_nPercs      = 0    && percs     numeric(5,2) NOT NULL - percentual sobre o preco de venda
    this_nValor      = 0    && valor     numeric(11,5) NOT NULL - valor calculado a partir do percentual
    this_nDiasPrz    = 0    && diasprz   numeric(2,0) NOT NULL - prazo de entrega em dias

    *-- Propriedade NAO persistida: descricao do tamanho (join com SigCdTam.descs)
    this_cDescs      = ""   && descs char(20) - vem de SigCdTam, exibida na grade

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigPrTam"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades a partir de uma linha do
    * cursor (cursor_4c_Dados, populado pelo Form a partir de SigPrTam)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                THIS.this_cCodTams   = TratarNulo(codtams,   "")
                THIS.this_cCpros     = TratarNulo(cpros,     "")
                THIS.this_dDataAlts  = TratarNulo(dataalts,  {})
                THIS.this_dDataTrans = TratarNulo(datatrans, {})
                THIS.this_dDtMovs    = TratarNulo(dtmovs,    {})
                THIS.this_nPesoMs    = TratarNulo(pesoms,    0)
                THIS.this_nPercs     = TratarNulo(percs,     0)
                THIS.this_nValor     = TratarNulo(valor,     0)
                THIS.this_nDiasPrz   = TratarNulo(diasprz,   0)

                * Descs vem de um JOIN com SigCdTam (nao existe na tabela
                * SigPrTam) - so esta presente quando o SELECT do Form a traz
                IF TYPE("descs") = "C"
                    THIS.this_cDescs = TratarNulo(descs, "")
                ELSE
                    THIS.this_cDescs = ""
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigprtamBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria de SigPrTam (cidchaves)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigPrTam (novo tamanho para o produto filtrado)
    * O legado gera a PK com fUniqueIds() no clique do botao Inserir, antes
    * de o usuario preencher qualquer coluna da grade (regra #22).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTam (cidchaves, codtams, cpros, dataalts, datatrans, dtmovs, pesoms, percs, valor, diasprz)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(THIS.this_cCodTams)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<FormatarDataSQL(THIS.this_dDataAlts)>>,
                    <<FormatarDataSQL(THIS.this_dDataTrans)>>,
                    <<FormatarDataSQL(THIS.this_dDtMovs)>>,
                    <<FormatarNumeroSQL(THIS.this_nPesoMs, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nPercs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nValor, 5)>>,
                    <<FormatarNumeroSQL(THIS.this_nDiasPrz, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir tamanho do produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "sigprtamBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigPrTam (cpros e cidchaves nao mudam depois do
    * Inserir - sao a chave e o filtro de origem do registro)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTam
                SET codtams   = <<EscaparSQL(THIS.this_cCodTams)>>,
                    dataalts  = <<FormatarDataSQL(THIS.this_dDataAlts)>>,
                    datatrans = <<FormatarDataSQL(THIS.this_dDataTrans)>>,
                    dtmovs    = <<FormatarDataSQL(THIS.this_dDtMovs)>>,
                    pesoms    = <<FormatarNumeroSQL(THIS.this_nPesoMs, 3)>>,
                    percs     = <<FormatarNumeroSQL(THIS.this_nPercs, 2)>>,
                    valor     = <<FormatarNumeroSQL(THIS.this_nValor, 5)>>,
                    diasprz   = <<FormatarNumeroSQL(THIS.this_nDiasPrz, 0)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar tamanho do produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "sigprtamBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigPrTam (equivalente ao Delete do
    * cursor buferizado no cmdExcluir.Click do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTam WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir tamanho do produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "sigprtamBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca os tamanhos vinculados a um produto (par_cCpros).
    * Retorna cursor_4c_Dados com cidchaves/codtams/cpros/.../descs.
    *
    * NAO faz JOIN com SigCdTam para preencher descs: o legado tambem nao
    * faz (Init: "Select a.*, Space(40) as Descs From SigPrTam a Where
    * a.cPros = ...") - a descricao so e preenchida em runtime pelo lookup
    * da celula de Codigo/Descricao (Column1/Column2.Text1.Valid), nunca
    * pela carga inicial. Transcricao literal (CLAUDE.md regra #17).
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cidchaves, codtams, cpros, dataalts, datatrans, dtmovs,
                       pesoms, percs, valor, diasprz, SPACE(20) AS descs
                FROM SigPrTam
                WHERE cpros = <<EscaparSQL(par_cCpros)>>
            ENDTEXT

            * SQLEXEC cria cursor SOMENTE-LEITURA - a grade precisa inserir
            * (Inserir) e apagar (Excluir) linhas localmente, alem de editar
            * peso/percentual/valor/prazo, entao o resultado eh copiado para
            * um cursor READWRITE (CLAUDE.md: "Grid com coluna EDITAVEL
            * exige cursor READWRITE")
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao buscar tamanhos do produto:" + CHR(13) + ;
                        THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "sigprtamBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

