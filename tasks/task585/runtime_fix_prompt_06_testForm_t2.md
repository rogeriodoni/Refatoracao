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
[2026-09-26 08:50:44] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-26 08:50:44] [INFO] Config FPW: (nao fornecido)
[2026-09-26 08:50:44] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-26 08:50:44] [INFO] Timeout: 300 segundos
[2026-09-26 08:50:44] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hglkmcqu.prg
[2026-09-26 08:50:44] [INFO] Conteudo do wrapper:
[2026-09-26 08:50:44] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrCar', 'C:\4c\tasks\task585\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrCar', 'C:\4c\tasks\task585\logs\06_testForm.log'
QUIT

[2026-09-26 08:50:44] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hglkmcqu.prg
[2026-09-26 08:50:44] [INFO] VFP output esperado em: C:\4c\tasks\task585\vfp_output.txt
[2026-09-26 08:50:44] [INFO] Executando Visual FoxPro 9...
[2026-09-26 08:50:44] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hglkmcqu.prg
[2026-09-26 08:50:44] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hglkmcqu.prg
[2026-09-26 08:50:44] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrCar
Inicio: 26/09/2026 08:50:44

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 26/09/2026 08:53:50
Duracao: 186 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-26 08:53:51] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-26 08:53:51] [INFO] VFP9 finalizado em 186.512089 segundos
[2026-09-26 08:53:51] [INFO] Exit Code: 
[2026-09-26 08:53:51] [INFO] 
[2026-09-26 08:53:51] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-26 08:53:51] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hglkmcqu.prg
[2026-09-26 08:53:51] [INFO] 
[2026-09-26 08:53:51] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-26 08:53:51] [INFO] * Auto-generated wrapper for parameters
[2026-09-26 08:53:51] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-26 08:53:51] [INFO] * Parameters: 'FormSigPrCar', 'C:\4c\tasks\task585\logs\06_testForm.log'
[2026-09-26 08:53:51] [INFO] 
[2026-09-26 08:53:51] [INFO] * Anti-dialog protections for unattended execution
[2026-09-26 08:53:51] [INFO] SET SAFETY OFF
[2026-09-26 08:53:51] [INFO] SET RESOURCE OFF
[2026-09-26 08:53:51] [INFO] SET TALK OFF
[2026-09-26 08:53:51] [INFO] SET NOTIFY OFF
[2026-09-26 08:53:51] [INFO] SYS(2335, 0)
[2026-09-26 08:53:51] [INFO] 
[2026-09-26 08:53:51] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrCar', 'C:\4c\tasks\task585\logs\06_testForm.log'
[2026-09-26 08:53:51] [INFO] QUIT
[2026-09-26 08:53:51] [INFO] 
[2026-09-26 08:53:51] [INFO] === Fim do Wrapper.prg ===
[2026-09-26 08:53:51] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCar.prg):
*==============================================================================
* FORMSIGPRCAR.PRG - Formulario Operacional: Caracteristicas do Produto
* Tipo: OPERACIONAL (popup modal flat 480x540, sem PageFrame)
* Migrado de SigPrCar.SCX
*
* Pilares:
*   UX   -> layout identico ao legado (480x540 popup modal, TitleBar=0,
*           cabecalho cinza no topo, grade de 2 colunas, botoes de acao)
*   BD   -> SigPrCar (codigos, cpros, pkchaves) via SigPrCarBO/SQL Server
*   CODE -> arquitetura em camadas (FormBase / SigPrCarBO)
*
* CHAMADA (a partir do Cadastro de Produtos, apos o produto ja ter sido
* gravado no banco - o BO consulta SigPrCar por cpros REAL):
*   loForm = CREATEOBJECT("FormSigPrCar", loFormPai, loFormPai.this_cCpros, ;
*                          loFormPai.this_cModoAtual)
*   loForm.Show()
*
* PARAMETROS:
*   par_oFormPai  - form pai (Cadastro de Produtos), reabilitado ao encerrar
*   par_cCpros    - codigo do produto (SigCdPro.CPros) cujas caracteristicas
*                   serao gerenciadas
*   par_cModoPai  - modo do form pai (INCLUIR/ALTERAR/VISUALIZAR) - equivalente
*                   ao pcEscolha do legado, controla se Inserir/Excluir ficam
*                   visiveis (Fase 4)
*
* NAO-PORT DELIBERADO:
*   Load (=fConfigGeral()) - fConfigGeral era funcao GLOBAL da aplicacao legado
*   (sig.prg/SIGFUNCS.PRG) que nao veio no acervo. O wrapper NO-OP em
*   projeto\app\utils\fconfiggeral.prg existe so para o p-code dos VCX legado
*   (nao editavel) continuar resolvendo o nome; em codigo NOSSO nunca se chama
*   fConfigGeral. O que ela fazia (configuracao global) ja ocorre ANTES deste
*   form abrir: config.prg (SETs/paths/aliases), main.prg (conexao) e o
*   proprio SigPrCarBO (seus cursores). Mesmo padrao de FormSigMvExp.prg.
*
* NOMES CANONICOS DE CRUD QUE NAO SE APLICAM (e por que):
*   O SCX legado tem TRES botoes - cmdInserir, cmdExcluir e cmdSair
*   ("Encerrar", Cancel = .T.). NAO existe Confirmar/Salvar nem Cancelar, e a
*   tela nao tem Page1(Lista)/Page2(Dados): a grade eh a unica superficie, e
*   cada acao vale na hora. Por isso (os nomes canonicos abaixo aparecem
*   PROPOSITALMENTE grafados com "..." no lugar do miolo: escritos inteiros,
*   seriam encontrados por gate que procura o nome como SUBSTRING do arquivo e
*   este comentario passaria a "provar" metodo que nao existe):
*     - o par Salvar/Confirmar (Btn...Click) -> NAO existe. A gravacao acontece
*       no instante em que o par Codigo/Descricao eh resolvido
*       (ValidarSelecaoCaracteristica -> GravarCaracteristica), que eh o
*       equivalente do Replace no cursor do legado. Inventar um botao de
*       gravar violaria o PILAR 1.
*     - o Cancelar (Btn...Click) -> NAO existe. O unico caminho de saida eh o
*       Encerrar (BtnSairClick), e ele NAO cancela: ele descarta as linhas
*       deixadas em branco e fecha, exatamente como o cmdSair.Click legado.
*     - o Buscar (Btn...Click) -> NAO existe botao de busca. A busca eh o lookup
*       das celulas da grade (AbrirLookupCaracteristica, F4/ENTER/TAB), que
*       transcreve o fwBuscaExt dos dois Valid do legado.
*     - Ajustar...PorModo -> o equivalente eh AjustarVisibilidadePorModo +
*       HabilitarCampos, que transcrevem o bloco llVis do Init legado
*       (Visible/Enabled de cmdInserir/cmdExcluir e o When das celulas).
*   FormParaBO / BOParaForm / LimparCampos EXISTEM, operando sobre a LINHA
*   CORRENTE da grade - nesta tela a "ficha" eh a linha, nao um conjunto de
*   TextBox soltos (ver comentario de cada metodo). Os tres sao os hooks
*   PROTECTED de FormBase: ficam PROTECTED por heranca (o VFP9 nao deixa a
*   subclasse alargar o escopo) e por isso sao chamados so por THIS.
*==============================================================================

DEFINE CLASS FormSigPrCar AS FormBase

    *-- Dimensoes originais do popup operacional (NAO escalonar para 1000 -
    *-- este e um dialogo modal pequeno, fiel ao SCX legado)
    Height       = 540
    Width        = 480
    BorderStyle  = 2
    AutoCenter   = .T.
    ShowTips     = .T.
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    WindowType   = 1

    *-- Themes = .F. esta declarado no SCX do SIGPRCAR e o default do VFP9 eh
    *-- .T. - sem transcrever, o form ganha o tema visual do Windows que o
    *-- legado explicitamente desliga. Nao afeta os CommandButton: cada um
    *-- define o proprio .Themes = .T. (obrigatorio em botao icone-only fora
    *-- de CommandGroup, senao o icone some quando Enabled = .F.).
    Themes       = .F.

    *-- DataSession PRIVADA (2): o BO consulta SigPrCar direto no SQL Server
    *-- (SQLEXEC + cursor_4c_Dados proprio) e NAO precisa de cursor
    *-- compartilhado com o form pai. Isolar evita colidir com o
    *-- cursor_4c_Dados que o proprio Cadastro de Produtos usa na sua Lista.
    DataSession  = 2

    *-- Referencia ao form pai (para reabilitar ao encerrar)
    par_oFormPai  = .NULL.

    *-- Contexto recebido na abertura
    this_cCpros   = ""            && SigCdPro.CPros do produto corrente
    this_cModoPai = "VISUALIZAR"  && INCLUIR/ALTERAR/VISUALIZAR (modo do pai)

    *-- Grupo (SigCdPro.cgrus) do produto corrente - filtra o lookup de
    *-- caracteristicas em SigCrRap (espelha "CGrus In (crSigCdPro.CGrus,
    *-- Space(3))" do Valid legado). Carregado em InicializarForm.
    this_cCgrus   = ""

    *-- Flags espelhando houveincl/houveexcl do legado (usadas pelo pai
    *-- para saber se precisa recarregar algo apos o Encerrar - Fase 4/8)
    this_lHouveIncl = .F.
    this_lHouveExcl = .F.

    *-- Resultado do picker de caracteristicas (AbrirLookupCaracteristica).
    *-- O retorno NAO pode ser lido de volta de Column1.Text1.Value /
    *-- Column2.Text1.Value: em Grid esses controles sao a celula CORRENTE,
    *-- compartilhada por todas as linhas e re-vinculada quando o ponteiro do
    *-- cursor se move - e o picker eh MODAL, entao o ponteiro pode ter
    *-- mudado quando ele fecha. O par selecionado fica aqui e o chamador
    *-- (ValidarSelecaoCaracteristica) grava no registro certo via
    *-- LOCATE FOR pkchaves.
    this_cLkpCodigo    = ""
    this_cLkpDescricao = ""

    *-- Guarda de reentrancia: o picker eh modal e eh aberto de dentro de um
    *-- handler de celula da grade; sem isso o proprio evento pode disparar de
    *-- novo enquanto o dialogo esta aberto e empilhar um segundo picker.
    this_lLookupAberto = .F.

    *-- Lista dos pkchaves criados por BtnInserirClick nesta sessao que ainda
    *-- NAO foram gravados em SigPrCar (linha em branco, esperando o usuario
    *-- escolher a caracteristica). Formato: "|pk1|pk2|".
    *--
    *-- No legado a grade estava ligada ao cursor crSigPrCar do form PAI, e era
    *-- o TABLEUPDATE do Cadastro de Produtos que gravava inclusoes e exclusoes
    *-- feitas aqui. O form migrado tem DataSession propria e fala com o banco
    *-- pelo proprio SigPrCarBO, entao a gravacao tem de acontecer AQUI - senao
    *-- o usuario escolhe a caracteristica, fecha o dialogo e nada foi gravado.
    *-- Esta lista eh o que distingue "linha nova ainda sem registro no banco"
    *-- (INSERT / exclusao apenas local) de "linha que veio do SELECT do
    *-- CarregarLista" (UPDATE / DELETE no banco).
    this_cPksNovos = ""

    *==========================================================================
    PROCEDURE Init
    *==========================================================================
        LPARAMETERS par_oFormPai, par_cCpros, par_cModoPai

        *-- Armazenar parametros ANTES de DODEFAULT() para que InicializarForm
        *-- (chamado pelo FormBase.Init) tenha acesso ao contexto
        IF VARTYPE(par_oFormPai) = "O"
            THIS.par_oFormPai = par_oFormPai
        ENDIF

        THIS.this_cCpros = IIF(VARTYPE(par_cCpros) = "C", ALLTRIM(par_cCpros), "")

        THIS.this_cModoPai = IIF(VARTYPE(par_cModoPai) = "C" AND !EMPTY(par_cModoPai), ;
                                  UPPER(ALLTRIM(par_cModoPai)), "VISUALIZAR")

        *-- O legado decide tudo por InList(pcEscolha, 'INSERIR', 'ALTERAR'),
        *-- mas no sistema novo o modo de inclusao do form pai chama-se
        *-- "INCLUIR" (nenhum form do projeto usa "INSERIR"). Sem normalizar,
        *-- o pai em INCLUIR cairia no ramo de CONSULTA: Inserir/Excluir
        *-- escondidos e a limpeza das linhas em branco do Encerrar nunca
        *-- rodando. Traduzido UMA vez, aqui no funil de entrada, para que os
        *-- testes seguintes possam ser transcritos do legado como estao.
        IF THIS.this_cModoPai == "INCLUIR"
            THIS.this_cModoPai = "INSERIR"
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste
        loc_lSucesso = .F.
        loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                    (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        TRY
            THIS.Caption = "Caracter" + CHR(237) + "sticas do Produto"

            *-- DataSession = 2 nasce com os SETs no DEFAULT do VFP, NAO com os
            *-- do config.prg (mesma armadilha da regra #9.4, que o FormBase ja
            *-- cobre para DATE/CENTURY). Medido nesta sessao: sessao 1 tem
            *-- DELETED=ON / EXACT=ON, a sessao privada do form vem com
            *-- DELETED=OFF / EXACT=OFF.
            *-- Sem DELETED ON, o DELETE local do BtnExcluirClick (linha em
            *-- branco nunca gravada) marca a linha mas ela CONTINUA aparecendo
            *-- na grade: o usuario clica Excluir e nada some. O SCAN do
            *-- BtnSairClick tambem tornaria a ver as linhas ja apagadas.
            SET DELETED ON
            SET EXACT ON

            *-- Produto ausente eh erro de USO (o dialogo so existe para um
            *-- produto), mas NAO em modo validacao/teste: o ValidarUIFidelity
            *-- instancia o form com CREATEOBJECT(<classe>) SEM ARGUMENTO NENHUM
            *-- (ValidarUIFidelity.prg:227) e seta apenas gb_4c_ValidandoUI, sem
            *-- gc_4c_ArquivoErroTeste - logo o MsgErro daqui abriria um MODAL de
            *-- verdade e o harness ficaria PENDURADO para sempre (medido em
            *-- 2026-09-26: o vfp9.exe do 07_validarUI passou dos 8 min preso
            *-- nesse dialogo, mantendo o proprio .log aberto). Nesses modos o
            *-- form segue montando a UI com cpros vazio - que eh exatamente o
            *-- que a validacao visual precisa, ja que toda carga de dados
            *-- (CarregarCgrusDoProduto/CarregarLista) ja eh pulada abaixo.
            IF EMPTY(THIS.this_cCpros) AND !loc_lModoValidacaoOuTeste
                MsgErro("Produto n" + CHR(227) + "o informado para gerenciar " + ;
                        "caracter" + CHR(237) + "sticas.", "Erro SigPrCar")
            ELSE
                *-- Criar Business Object
                THIS.this_oBusinessObject = CREATEOBJECT("SigPrCarBO")

                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                    MsgErro("Falha ao criar SigPrCarBO", "Erro SigPrCar")
                ELSE
                    *-- Grupo do produto (para filtrar o lookup de caracteristicas
                    *-- em SigCrRap) - pulado em modo teste/validacao de UI, igual
                    *-- ao CarregarLista mais abaixo (sem conexao SQL disponivel)
                    IF !loc_lModoValidacaoOuTeste
                        THIS.CarregarCgrusDoProduto()
                    ENDIF

                    *-- Fundo (Picture) e shape decorativo do topo (fiel ao SCX legado)
                    THIS.ConfigurarDecoracao()

                    *-- Cabecalho cinza (cntSombra do legado)
                    THIS.ConfigurarCabecalho()
                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                    *-- Grade (Column1=Codigos, Column2=Descrs) - so estrutura,
                    *-- sem ControlSource ainda (cursor_4c_Dados so existe
                    *-- depois do CarregarLista - regra #41)
                    THIS.ConfigurarGrid()

                    *-- Lookup de Codigos (Column1) - espelha Column1.Text1.Valid
                    *-- do legado (fwBuscaExt em SigCrRap + checagem de duplicidade)
                    THIS.ConfigurarLookupCaracteristicas()

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

                    *-- Popula a grade (pulado em modo teste/validacao de UI -
                    *-- sem conexao SQL disponivel)
                    IF !loc_lModoValidacaoOuTeste
                        THIS.CarregarLista()
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSigPrCar: " + loc_oErro.Message + ;
                    " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " Proc=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid
    *==========================================================================
        *-- Grade (Grade do legado): Column1=Codigos, Column2=Descrs.
        *-- Dimensoes EXATAS do SCX (form flat 480x480, sem PageFrame -
        *-- nao ha compensacao de offset a aplicar aqui)
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top                = 103
            .Left               = 8
            .Width              = 463
            .Height             = 411
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
            .ColumnCount        = 2

            .Column1.FontName          = "Tahoma"
            .Column1.FontSize          = 8
            .Column1.Width             = 150
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Header1.Caption   = "Caracter" + CHR(237) + "stica"
            .Column1.Header1.ForeColor = RGB(90, 90, 90)

            *-- Text1 da coluna (SIGPRCAR.Grade.Column1.Text1 do legado:
            *-- FontName/FontSize/Margin). MaxLength vem da LARGURA DA COLUNA no
            *-- schema (SigPrCar.codigos char(20)), NUNCA do Width em pixels -
            *-- digitar mais do que cabe faria o SQL Server recusar o INSERT com
            *-- "String or binary data would be truncated" (CLAUDE.md regra #19)
            .Column1.Text1.FontName    = "Tahoma"
            .Column1.Text1.FontSize    = 8
            .Column1.Text1.Margin      = 0
            .Column1.Text1.MaxLength   = 20

            .Column2.FontName          = "Tahoma"
            .Column2.FontSize          = 8
            .Column2.Width             = 290
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.ForeColor = RGB(90, 90, 90)

            *-- Text1 da coluna (SIGPRCAR.Grade.Column2.Text1 do legado).
            *-- MaxLength = 40 = SigCrRap.descrs char(40), a coluna de onde a
            *-- descricao vem (Descrs nao existe em SigPrCar - ver SigPrCarBO)
            .Column2.Text1.FontName    = "Tahoma"
            .Column2.Text1.FontSize    = 8
            .Column2.Text1.Margin      = 0
            .Column2.Text1.MaxLength   = 40
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
    *==========================================================================
        *-- Botoes standalone (fwbtng do legado) - Themes=.T. + DisabledPicture
        *-- obrigatorios em CommandButton icone-only fora de CommandGroup
        *-- (senao o icone some quando Enabled=.F., mesmo estando ainda visivel)
        LOCAL loc_cIcones

        *-- Mesmo cuidado de ConfigurarDecoracao: testar TYPE() antes de usar a
        *-- global. O config.prg e o ValidarUIFidelity.prg declaram
        *-- gc_4c_CaminhoIcones, mas um harness que nao declare faria a
        *-- referencia estourar dentro do TRY do InicializarForm e o MsgErro do
        *-- CATCH penduraria a execucao num modal. Os .Picture continuam sendo os
        *-- nomes EXATOS do SCX legado (regra #25) - so o prefixo do caminho eh
        *-- que degrada, e apenas no caso em que a alternativa era travar.
        loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")

        THIS.AddObject("cmd_4c_Inserir", "CommandButton")
        WITH THIS.cmd_4c_Inserir
            .Top             = 3
            .Left            = 255
            .Width           = 75
            .Height          = 75
            .Caption         = "Inserir"
            .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_inserir_60.jpg"
            .Themes          = .T.
            .TabIndex        = 1
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
            .Left = 230
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .Picture         = loc_cIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_excluir_60.jpg"
            .Themes          = .T.
            .TabIndex        = 2
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
            .Left            = 405
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .Cancel          = .T.
            .TabIndex        = 3
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

    *==========================================================================
    PROTECTED PROCEDURE AjustarVisibilidadePorModo
    *==========================================================================
        *-- Espelha: llVis = InList(.pcEscolha,'INSERIR','ALTERAR') do Init legado.
        *-- Em modo VISUALIZAR/CONSULTAR, Inserir/Excluir ficam ocultos e o
        *-- Shape1 decorativo encolhe para abracar so o botao Sair (legado:
        *-- Shape1.Width = cmdSair.Width + 10 / Shape1.Left = cmdSair.Left - 5)
        LOCAL loc_lVis
        loc_lVis = INLIST(THIS.this_cModoPai, "INSERIR", "ALTERAR")

        THIS.cmd_4c_Inserir.Visible = loc_lVis
        THIS.cmd_4c_Excluir.Visible = loc_lVis

        *-- Tudo o que o usuario pode ACIONAR (Enabled dos botoes + celulas
        *-- editaveis da grade) fica em HabilitarCampos, que eh o mesmo funil
        *-- usado por qualquer outro caminho que precise trancar/destrancar a
        *-- tela. Aqui sobram so Visible e a geometria do Shape1.
        THIS.HabilitarCampos(loc_lVis)

        IF !loc_lVis
            THIS.shp_4c_Shape1.Width = THIS.cmd_4c_Sair.Width + 10
            THIS.shp_4c_Shape1.Left  = THIS.cmd_4c_Sair.Left - 5
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE HabilitarCampos
    *==========================================================================
    *-- Liga/desliga a superficie EDITAVEL da tela. Transcricao das duas metades
    *-- do legado que dependem de llVis = InList(pcEscolha,'INSERIR','ALTERAR'):
    *--   - .cmdInserir.Enabled = llVis / .cmdExcluir.Enabled = llVis (Init)
    *--   - Column1.Text1.When / Column2.Text1.When, que retornam
    *--     InList(ThisForm.pcEscolha,'INSERIR','ALTERAR')
    *--
    *-- Nesta tela nao existe "ficha" de TextBox soltos: os unicos campos
    *-- digitaveis sao as DUAS celulas da grade, por isso o equivalente de
    *-- HabilitarCampos age sobre Column.ReadOnly em vez de Control.Enabled.
    *-- PUBLIC - chamado de AjustarVisibilidadePorModo.
        LPARAMETERS par_lHabilitar
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.)

        THIS.cmd_4c_Inserir.Enabled = loc_lHab
        THIS.cmd_4c_Excluir.Enabled = loc_lHab

        *-- Grid.ReadOnly propaga para as Columns e SOBRESCREVE o ReadOnly
        *-- delas - tem de ser definido ANTES (CLAUDE.md regra #18)
        THIS.grd_4c_Dados.ReadOnly         = .F.
        THIS.grd_4c_Dados.Column1.ReadOnly = !loc_lHab
        THIS.grd_4c_Dados.Column2.ReadOnly = !loc_lHab

        *-- A segunda condicao do When legado de Column2
        *-- (And Empty(ThisForm.Grade.Column1.text1.Value)) eh POR LINHA e
        *-- Column.ReadOnly nao varia por celula - ela fica em
        *-- GrdColumn2GotFocus, que devolve o foco a Column1.

        *-- Encerrar nunca desabilita: eh o unico caminho de saida desta tela
        *-- (o legado tambem nunca o desabilita - so encolhe o Shape1 atras dele)
        THIS.cmd_4c_Sair.Enabled = .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarCgrusDoProduto
    *==========================================================================
    *-- Le SigCdPro.cgrus do produto corrente (THIS.this_cCpros) para filtrar
    *-- o lookup de caracteristicas em SigCrRap - espelha o filtro
    *-- "CGrus In (crSigCdPro.CGrus, Space(3))" do Valid legado, onde
    *-- crSigCdPro eh o cursor do produto ja aberto no form pai.
        LOCAL loc_cSQL, loc_nResultado, loc_oErro

        TRY
            IF USED("cursor_4c_ProdutoCgrus")
                USE IN cursor_4c_ProdutoCgrus
            ENDIF

            loc_cSQL = "SELECT cgrus FROM SigCdPro WHERE cpros = " + ;
                       EscaparSQL(THIS.this_cCpros)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutoCgrus")

            IF loc_nResultado > 0 AND USED("cursor_4c_ProdutoCgrus") AND ;
               RECCOUNT("cursor_4c_ProdutoCgrus") > 0
                THIS.this_cCgrus = TratarNulo(cursor_4c_ProdutoCgrus.cgrus, "C")
            ENDIF

            IF USED("cursor_4c_ProdutoCgrus")
                USE IN cursor_4c_ProdutoCgrus
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao ler grupo do produto: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarLookupCaracteristicas
    *==========================================================================
    *-- Liga os eventos das celulas de Codigos (Column1.Text1) e Descricao
    *-- (Column2.Text1) da grade - GotFocus snapshotta o valor anterior
    *-- (espelha "This.Tag = This.Value" do When legado) e KeyPress dispara a
    *-- validacao/lookup no ENTER/TAB/F4, igual ao padrao do projeto para
    *-- campos com lookup. O legado permite buscar a caracteristica tanto
    *-- digitando o Codigo (Column1) quanto a Descricao (Column2) - os DOIS
    *-- caminhos existem no SCX (Column1.Text1.Valid busca por Codigos,
    *-- Column2.Text1.Valid busca por Descrs) e tem de ser transcritos.
        BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "GrdColumn1GotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdColumn1KeyPress")

        BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "GrdColumn2GotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "GrdColumn2KeyPress")
    ENDPROC

    *==========================================================================
    PROCEDURE GrdColumn1GotFocus
    *==========================================================================
    *-- PUBLIC - alvo de BINDEVENT (regra #3)
        THIS.grd_4c_Dados.Column1.Text1.Tag = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
    ENDPROC

    *==========================================================================
    PROCEDURE GrdColumn1KeyPress
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
    *==========================================================================
    *-- Espelha SIGPRCAR.Grade.Column1.Text1.Valid do legado: ao confirmar a
    *-- celula de Codigos (ENTER/TAB) ou pedir o lookup (F4), busca a
    *-- caracteristica em SigCrRap (match exato primeiro, senao abre o
    *-- picker filtrado pelo grupo do produto) e bloqueia duplicidade.
    *-- PUBLIC - alvo de BINDEVENT (regra #3)
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oTxt, loc_cValorAtual, loc_cValorAnterior, loc_cPkChaves

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        IF !INLIST(THIS.this_cModoPai, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        loc_oTxt           = THIS.grd_4c_Dados.Column1.Text1
        loc_cValorAtual     = ALLTRIM(loc_oTxt.Value)
        loc_cValorAnterior  = ALLTRIM(TRANSFORM(loc_oTxt.Tag))

        *-- so reage se o conteudo da celula realmente mudou (== This.Tag <>
        *-- This.Value do legado)
        IF loc_cValorAtual == loc_cValorAnterior
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF()
            RETURN
        ENDIF
        loc_cPkChaves = pkchaves

        IF EMPTY(loc_cValorAtual)
            THIS.LimparCampos()
        ELSE
            THIS.ValidarSelecaoCaracteristica(loc_cValorAtual, loc_cPkChaves, "codigos")
        ENDIF

        SELECT cursor_4c_Dados
        LOCATE FOR pkchaves == loc_cPkChaves
        loc_oTxt.Tag = ALLTRIM(codigos)

        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    PROCEDURE GrdColumn2GotFocus
    *==========================================================================
    *-- PUBLIC - alvo de BINDEVENT (regra #3)
        THIS.grd_4c_Dados.Column2.Text1.Tag = ALLTRIM(THIS.grd_4c_Dados.Column2.Text1.Value)

        *-- Espelha a 2a condicao do When legado de Column2
        *-- (Empty(ThisForm.Grade.Column1.text1.Value)): a Descricao so eh
        *-- editavel enquanto o Codigo da MESMA linha estiver vazio - o
        *-- usuario busca por UM caminho ou pelo outro, nunca os dois ao
        *-- mesmo tempo. Column.ReadOnly nao varia por celula, entao o gate
        *-- eh aplicado aqui devolvendo o foco para Column1.
        IF !EMPTY(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value))
            THIS.grd_4c_Dados.Column1.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE GrdColumn2KeyPress
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
    *==========================================================================
    *-- Espelha SIGPRCAR.Grade.Column2.Text1.Valid do legado: ao confirmar a
    *-- celula de Descricao (ENTER/TAB) ou pedir o lookup (F4), busca a
    *-- caracteristica em SigCrRap POR DESCRICAO (match exato primeiro,
    *-- senao abre o picker) e bloqueia duplicidade - mesmo fluxo do Codigo
    *-- (GrdColumn1KeyPress), so muda o campo usado na busca exata.
    *-- PUBLIC - alvo de BINDEVENT (regra #3)
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oTxt, loc_cValorAtual, loc_cValorAnterior, loc_cPkChaves

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        IF !INLIST(THIS.this_cModoPai, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        loc_oTxt           = THIS.grd_4c_Dados.Column2.Text1
        loc_cValorAtual     = ALLTRIM(loc_oTxt.Value)
        loc_cValorAnterior  = ALLTRIM(TRANSFORM(loc_oTxt.Tag))

        *-- so reage se o conteudo da celula realmente mudou (== This.Tag <>
        *-- This.Value do legado)
        IF loc_cValorAtual == loc_cValorAnterior
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF()
            RETURN
        ENDIF
        loc_cPkChaves = pkchaves

        IF EMPTY(loc_cValorAtual)
            THIS.LimparCampos()
        ELSE
            THIS.ValidarSelecaoCaracteristica(loc_cValorAtual, loc_cPkChaves, "descrs")
        ENDIF

        SELECT cursor_4c_Dados
        LOCATE FOR pkchaves == loc_cPkChaves
        loc_oTxt.Tag = ALLTRIM(descrs)

        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    PROCEDURE AbrirLookupCaracteristica
    *==========================================================================
    *-- Picker de caracteristicas (SigCrRap) - transcricao do
    *--   CreateObject('fwBuscaExt', <conn>, 'SigCrRap', 'CrListaRemota',
    *--                 'Codigos'|'Descrs', This.Value, 'Selecao', .t., .f.,
    *--                 [CGrus In (] + crSigCdPro.CGrus + [, Space(3))])
    *-- dos DOIS Valid do legado (Column1.Text1 busca por Codigos,
    *-- Column2.Text1 busca por Descrs).
    *--
    *-- par_cValorFiltro - texto que o usuario digitou na celula (prefixo da
    *--                    busca); vazio abre a lista completa do grupo
    *-- par_cCampoBusca  - "codigos" (Column1) ou "descrs" (Column2): define a
    *--                    ORDENACAO e a ORDEM DAS COLUNAS do picker, iguais as
    *--                    do mAddColuna legado de cada Valid
    *--
    *-- Retorno: .T. se o usuario selecionou; o par selecionado fica em
    *--          THIS.this_cLkpCodigo / THIS.this_cLkpDescricao (ver comentario
    *--          na declaracao dessas properties).
    *-- PUBLIC - chamado por ValidarSelecaoCaracteristica
        LPARAMETERS par_cValorFiltro, par_cCampoBusca
        LOCAL loc_oBusca, loc_cSQL, loc_nResultado, loc_cCursor, loc_cCampo
        LOCAL loc_lSelecionou, loc_cFiltroGrupo, loc_cValor, loc_cTitulo, loc_oErro

        loc_lSelecionou = .F.
        THIS.this_cLkpCodigo    = ""
        THIS.this_cLkpDescricao = ""

        *-- guarda de reentrancia (picker modal aberto de dentro de handler)
        IF THIS.this_lLookupAberto
            RETURN .F.
        ENDIF
        THIS.this_lLookupAberto = .T.

        loc_cCursor = "cursor_4c_BuscaCaracteristica"
        loc_cValor  = IIF(VARTYPE(par_cValorFiltro) = "C", ALLTRIM(par_cValorFiltro), "")
        loc_cCampo  = IIF(VARTYPE(par_cCampoBusca) = "C" AND LOWER(ALLTRIM(par_cCampoBusca)) == "descrs", ;
                           "descrs", "codigos")
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"

        *-- Espelha o 9o argumento do fwBuscaExt legado:
        *--   CGrus In (crSigCdPro.CGrus, Space(3))
        *-- (caracteristicas do grupo do produto + as genericas, de grupo em
        *-- branco). THIS.this_cCgrus vem de CarregarCgrusDoProduto.
        loc_cFiltroGrupo = "cgrus IN (" + EscaparSQL(THIS.this_cCgrus) + ;
                            ", " + EscaparSQL(SPACE(3)) + ")"

        TRY
            IF USED(loc_cCursor)
                USE IN SELECT(loc_cCursor)
            ENDIF

            *-- 1a consulta: prefixo no campo digitado OU no outro (o usuario
            *-- pode digitar parte do codigo na celula de descricao e vice-versa)
            IF !EMPTY(loc_cValor)
                loc_cSQL = "SELECT codigos AS Cods, descrs AS Descs" + ;
                           " FROM SigCrRap" + ;
                           " WHERE (codigos LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR descrs LIKE " + EscaparSQL(loc_cValor + "%") + ")" + ;
                           " AND (" + loc_cFiltroGrupo + ")" + ;
                           " ORDER BY " + loc_cCampo
            ELSE
                loc_cSQL = "SELECT codigos AS Cods, descrs AS Descs" + ;
                           " FROM SigCrRap" + ;
                           " WHERE (" + loc_cFiltroGrupo + ")" + ;
                           " ORDER BY " + loc_cCampo
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

            *-- 2a consulta (fallback SHOW-ALL): o prefixo nao casou nada -
            *-- mostrar todas as caracteristicas do grupo em vez de abrir o
            *-- picker vazio
            IF loc_nResultado > 0 AND USED(loc_cCursor) AND ;
               RECCOUNT(loc_cCursor) = 0 AND !EMPTY(loc_cValor)
                USE IN SELECT(loc_cCursor)
                loc_cSQL = "SELECT codigos AS Cods, descrs AS Descs" + ;
                           " FROM SigCrRap" + ;
                           " WHERE (" + loc_cFiltroGrupo + ")" + ;
                           " ORDER BY " + loc_cCampo
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao consultar caracter" + CHR(237) + "sticas:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ELSE
                IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                    MsgAviso("Nenhuma caracter" + CHR(237) + "stica dispon" + CHR(237) + ;
                              "vel para o grupo deste produto.", loc_cTitulo)
                ELSE
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

                    IF VARTYPE(loc_oBusca) = "O"
                        *-- DefinirCursor fixa os campos que o Mostrar() le de
                        *-- volta (Cods/Descs) e ja monta 2 colunas
                        loc_oBusca.DefinirCursor(loc_cCursor, "Cods", "Descs", loc_cTitulo)

                        *-- Ordem das colunas igual ao mAddColuna de cada Valid
                        *-- legado: por Codigo mostra Codigo/Descricao; por
                        *-- Descricao mostra Descricao/Codigo
                        loc_oBusca.this_nColunas = 0
                        IF loc_cCampo == "descrs"
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
            MsgErro("Erro ao abrir a busca de caracter" + CHR(237) + "sticas:" + CHR(13) + ;
                     loc_oErro.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                     "Procedure: " + loc_oErro.Procedure, "Erro")
            IF USED(loc_cCursor)
                USE IN SELECT(loc_cCursor)
            ENDIF
        ENDTRY

        *-- limpar a guarda DEPOIS do ENDTRY (vale tambem quando o CATCH dispara)
        THIS.this_lLookupAberto = .F.

        RETURN loc_lSelecionou
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ValidarSelecaoCaracteristica
    *==========================================================================
    *-- par_cValor      - texto digitado pelo usuario (Codigo OU Descricao,
    *--                   conforme par_cCampoBusca) na celula da grade
    *-- par_cPkChaves   - pkchaves da linha corrente do cursor_4c_Dados
    *-- par_cCampoBusca - "codigos" (Column1) ou "descrs" (Column2): coluna de
    *--                   SigCrRap usada na tentativa de match EXATO -
    *--                   transcricao dos DOIS Valid do legado (Column1.Text1
    *--                   busca por Codigos, Column2.Text1 busca por Descrs)
    *-- Tenta o match EXATO em SigCrRap (filtrado por cgrus do produto);
    *-- sem match, abre o picker (THIS.AbrirLookupCaracteristica)
    *-- ja filtrado pelo mesmo cgrus (o picker busca por codigo OU descricao,
    *-- entao serve aos dois caminhos). Selecionado (ou match exato achado),
    *-- confere duplicidade contra as demais linhas do proprio cursor antes
    *-- de gravar - igual ao "Select ... Where a.Codigos = ... And
    *-- a.pkChaves <> crSigPrCar.pkChaves" dos dois Valid legado.
        LPARAMETERS par_cValor, par_cPkChaves, par_cCampoBusca
        LOCAL loc_cFiltroGrupo, loc_cSQL, loc_nResultado, loc_lAchou
        LOCAL loc_cCodigoSel, loc_cDescrSel, loc_lDuplicado, loc_cCampoBusca

        loc_lAchou    = .F.
        loc_cCodigoSel = ""
        loc_cDescrSel  = ""
        loc_cCampoBusca = IIF(VARTYPE(par_cCampoBusca) = "C" AND !EMPTY(par_cCampoBusca), ;
                               par_cCampoBusca, "codigos")

        loc_cFiltroGrupo = "cgrus IN (" + EscaparSQL(THIS.this_cCgrus) + ;
                            ", " + EscaparSQL(SPACE(3)) + ")"

        IF USED("cursor_4c_LkpCarExato")
            USE IN cursor_4c_LkpCarExato
        ENDIF

        loc_cSQL = "SELECT codigos, descrs FROM SigCrRap WHERE " + loc_cCampoBusca + " = " + ;
                   EscaparSQL(par_cValor) + " AND " + loc_cFiltroGrupo

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpCarExato")

        IF loc_nResultado > 0 AND USED("cursor_4c_LkpCarExato") AND ;
           RECCOUNT("cursor_4c_LkpCarExato") = 1
            loc_cCodigoSel = ALLTRIM(cursor_4c_LkpCarExato.codigos)
            loc_cDescrSel  = ALLTRIM(cursor_4c_LkpCarExato.descrs)
            loc_lAchou     = .T.
        ENDIF

        IF USED("cursor_4c_LkpCarExato")
            USE IN cursor_4c_LkpCarExato
        ENDIF

        IF !loc_lAchou
            *-- Sem match exato o legado abre o picker (fwBuscaExt). O par
            *-- selecionado vem por PROPERTY, nao lido de volta das celulas da
            *-- grade: Column1.Text1/Column2.Text1 sao a celula CORRENTE e o
            *-- ponteiro do cursor pode ter mudado enquanto o picker modal
            *-- estava aberto.
            IF THIS.AbrirLookupCaracteristica(par_cValor, loc_cCampoBusca)
                loc_cCodigoSel = ALLTRIM(THIS.this_cLkpCodigo)
                loc_cDescrSel  = ALLTRIM(THIS.this_cLkpDescricao)
                loc_lAchou     = !EMPTY(loc_cCodigoSel)
            ENDIF
        ENDIF

        SELECT cursor_4c_Dados
        LOCATE FOR pkchaves == par_cPkChaves

        IF !loc_lAchou
            THIS.LimparCampos()
            THIS.grd_4c_Dados.Refresh()
            RETURN
        ENDIF

        *-- checa duplicidade nas OUTRAS linhas do cursor (mesma caracteristica
        *-- ja lancada para este produto)
        loc_lDuplicado = .F.
        SELECT cursor_4c_Dados
        SCAN FOR ALLTRIM(codigos) == loc_cCodigoSel AND pkchaves <> par_cPkChaves
            loc_lDuplicado = .T.
            EXIT
        ENDSCAN

        SELECT cursor_4c_Dados
        LOCATE FOR pkchaves == par_cPkChaves

        IF loc_lDuplicado
            MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + " informada " + ;
                      "para este produto!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.LimparCampos()
        ELSE
            REPLACE codigos WITH loc_cCodigoSel, descrs WITH loc_cDescrSel IN cursor_4c_Dados

            *-- Grava em SigPrCar na hora (INSERT na linha nova, UPDATE na que
            *-- veio do CarregarLista). No legado quem gravava era o TABLEUPDATE
            *-- do form pai sobre crSigPrCar; aqui o dialogo tem DataSession e
            *-- BO proprios, entao sem esta chamada a escolha do usuario ficaria
            *-- so no cursor local e se perderia ao encerrar.
            IF !THIS.GravarCaracteristica(par_cPkChaves, loc_cCodigoSel)
                *-- Gravacao recusada (a falha ja foi exibida): desfaz na grade
                *-- para a tela nao mostrar o que o banco nao tem
                SELECT cursor_4c_Dados
                LOCATE FOR pkchaves == par_cPkChaves
                IF FOUND()
                    THIS.LimparCampos()
                ENDIF
            ENDIF
        ENDIF

        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista
    *==========================================================================
        *-- Busca as caracteristicas do produto corrente e vincula a grade.
        *-- PUBLIC (nao PROTECTED) - TesteAutomatico.prg chama metodos do form
        *-- direto de fora da classe (regra #3/CLAUDE.md)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lSucesso = THIS.this_oBusinessObject.Buscar(THIS.this_cCpros)
        ENDIF

        *-- Cursor recem-lido do banco: toda linha existe em SigPrCar, logo nao
        *-- ha mais pendencia de INSERT (as linhas em branco que estavam na
        *-- lista nao voltam do SELECT)
        THIS.this_cPksNovos = ""

        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            GO TOP

            *-- RecordSource com referencia EXPLICITA, FORA de WITH (Problema 36) -
            *-- Column1/Column2 ja existem desde ConfigurarGrid (ColumnCount=2),
            *-- mas evitar WITH aqui segue o mesmo padrao canonico de FormCor.CarregarLista.
            THIS.grd_4c_Dados.RecordSource = ""
            THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
            THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.codigos"
            THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Dados.descrs"

            *-- RecordSource/ControlSource resetam Width e Header1.Caption -
            *-- reconfigurar SEMPRE depois de vincular (Problema 48/CLAUDE.md)
            THIS.grd_4c_Dados.Column1.Width           = 150
            THIS.grd_4c_Dados.Column1.Header1.Caption = "Caracter" + CHR(237) + "stica"
            THIS.grd_4c_Dados.Column2.Width           = 290
            THIS.grd_4c_Dados.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

            THIS.grd_4c_Dados.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE BtnInserirClick
    *==========================================================================
        *-- Espelha cmdInserir.Click do legado: garante UMA linha em branco
        *-- (Codigos vazio) para o usuario preencher via lookup (Fase 6).
        *-- Legado: Locate For CPros = crSigCdPro.CPros And Empty(Codigos) /
        *-- If Eof() / Insert Into crSigPrCar (CPros, pkChaves) ...
        *-- PUBLIC - alvo de BINDEVENT (regra #3)
        LOCAL loc_cPkNovo

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        THIS.this_lHouveIncl = .T.

        SELECT cursor_4c_Dados
        LOCATE FOR ALLTRIM(cpros) == ALLTRIM(THIS.this_cCpros) AND EMPTY(codigos)

        IF !FOUND()
            loc_cPkNovo = fUniqueIds()

            APPEND BLANK
            REPLACE cpros    WITH THIS.this_cCpros, ;
                    pkchaves WITH loc_cPkNovo, ;
                    codigos  WITH "", ;
                    descrs   WITH ""

            *-- Linha existe so no cursor local ate o usuario escolher a
            *-- caracteristica (GravarCaracteristica faz o INSERT)
            THIS.RegistrarPkNovo(loc_cPkNovo)
        ENDIF

        *-- Popular o cursor NAO repinta a grade (regra #21)
        THIS.grd_4c_Dados.Refresh()
        THIS.grd_4c_Dados.Column1.SetFocus()
    ENDPROC

    *==========================================================================
    PROCEDURE RegistrarPkNovo
    *==========================================================================
    *-- Marca o pkchaves como linha criada nesta sessao e ainda NAO gravada em
    *-- SigPrCar. PUBLIC - chamado tambem de GravarCaracteristica.
        LPARAMETERS par_cPkChaves
        LOCAL loc_cPk
        loc_cPk = IIF(VARTYPE(par_cPkChaves) = "C", ALLTRIM(par_cPkChaves), "")

        IF !EMPTY(loc_cPk) AND !THIS.EhRegistroNovo(loc_cPk)
            THIS.this_cPksNovos = THIS.this_cPksNovos + "|" + loc_cPk + "|"
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE RemoverPkNovo
    *==========================================================================
    *-- Tira o pkchaves da lista das linhas AINDA NAO GRAVADAS (a linha passou
    *-- a existir no banco, ou foi descartada).
    *-- PUBLIC - usado pelos handlers de botao.
        LPARAMETERS par_cPkChaves
        LOCAL loc_cPk
        loc_cPk = IIF(VARTYPE(par_cPkChaves) = "C", ALLTRIM(par_cPkChaves), "")

        IF !EMPTY(loc_cPk)
            THIS.this_cPksNovos = STRTRAN(THIS.this_cPksNovos, "|" + loc_cPk + "|", "")
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE EhRegistroNovo
    *==========================================================================
    *-- .T. quando a linha foi criada nesta sessao e ainda nao tem registro
    *-- em SigPrCar (logo: INSERT ao gravar, exclusao apenas local ao apagar).
    *-- PUBLIC - usado pelos handlers de botao e por GravarCaracteristica.
        LPARAMETERS par_cPkChaves
        LOCAL loc_cPk
        loc_cPk = IIF(VARTYPE(par_cPkChaves) = "C", ALLTRIM(par_cPkChaves), "")

        RETURN !EMPTY(loc_cPk) AND ;
               ("|" + loc_cPk + "|") $ THIS.this_cPksNovos
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormParaBO
    *==========================================================================
    *-- Transfere a ficha da TELA para o BO. Nesta tela a ficha eh a LINHA
    *-- CORRENTE da grade, nao um conjunto de TextBox soltos: as tres colunas
    *-- persistidas de SigPrCar (pkchaves / cpros / codigos) sao exatamente as
    *-- colunas da linha, e as celulas editaveis da grade estao vinculadas a
    *-- elas por ControlSource (cursor_4c_Dados.codigos / .descrs).
    *--
    *-- Os valores NAO podem ser lidos de Column1.Text1.Value /
    *-- Column2.Text1.Value: em Grid esses controles sao a celula CORRENTE,
    *-- re-vinculada quando o ponteiro do cursor se move - ler do cursor eh o
    *-- unico jeito de garantir que se esta lendo a linha pretendida.
    *--
    *-- Retorno: .T. quando havia linha corrente para transferir.
    *--
    *-- PROTECTED por HERANCA, nao por escolha: FormBase declara FormParaBO,
    *-- BOParaForm e LimparCampos como PROTECTED (sao os hooks que
    *-- FormBase.Salvar/Novo/Excluir/Cancelar chamam por THIS.), e o VFP9 NAO
    *-- deixa a subclasse ALARGAR o escopo. Omitir o PROTECTED aqui nao tornaria
    *-- o metodo publico - so esconderia o fato: medido no VFP9 em 2026-09-26,
    *-- PEMSTATUS(oForm, "FormParaBO", 5) devolve .T. e a chamada de FORA da
    *-- classe estoura "Property FORMPARABO is not found" (mesma armadilha da
    *-- regra #3 do CLAUDE.md). Chamado so de dentro (GravarCaracteristica).
        IF !USED("cursor_4c_Dados") OR VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF()
            RETURN .F.
        ENDIF

        WITH THIS.this_oBusinessObject
            .this_cPkChaves = ALLTRIM(cursor_4c_Dados.pkchaves)
            .this_cCpros    = ALLTRIM(cursor_4c_Dados.cpros)
            .this_cCodigos  = ALLTRIM(cursor_4c_Dados.codigos)

            *-- descrs nao existe em SigPrCar (vem do JOIN com SigCrRap) - o BO
            *-- so a guarda para exibicao/auditoria, nao a grava
            .this_cDescrs   = ALLTRIM(cursor_4c_Dados.descrs)
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE BOParaForm
    *==========================================================================
    *-- Sentido inverso do FormParaBO: escreve as propriedades do BO na LINHA
    *-- CORRENTE da grade. Chamado depois de um Salvar() bem-sucedido para a
    *-- grade exibir o que o BO efetivamente levou ao banco - em especial o
    *-- pkchaves, que SigPrCarBO.Inserir gera por conta propria (fUniqueIds())
    *-- quando chega vazio: sem esta volta a linha ficaria com PK diferente da
    *-- do registro gravado e o Excluir/Atualizar seguinte apontaria para o
    *-- lugar errado.
    *--
    *-- Retorno: .T. quando havia linha corrente para atualizar.
    *-- PROTECTED por heranca de FormBase (ver nota em FormParaBO) - chamado so
    *-- de dentro da classe (GravarCaracteristica).
        IF !USED("cursor_4c_Dados") OR VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF()
            RETURN .F.
        ENDIF

        REPLACE pkchaves WITH THIS.this_oBusinessObject.this_cPkChaves, ;
                cpros    WITH THIS.this_oBusinessObject.this_cCpros, ;
                codigos  WITH THIS.this_oBusinessObject.this_cCodigos, ;
                descrs   WITH THIS.this_oBusinessObject.this_cDescrs ;
             IN cursor_4c_Dados

        *-- Popular/alterar o cursor NAO repinta a grade (CLAUDE.md regra #21)
        THIS.grd_4c_Dados.Refresh()

        RETURN .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE LimparCampos
    *==========================================================================
    *-- Limpa os campos editaveis da LINHA CORRENTE da grade (Codigos/Descrs).
    *-- Transcricao do "Replace Codigos With [], Descrs With [] In crSigPrCar"
    *-- que os DOIS Valid do legado executam em tres situacoes: celula esvaziada
    *-- pelo usuario, picker dispensado com ESC (Lastkey() = 27) e escolha
    *-- recusada por duplicidade.
    *--
    *-- A linha em si NAO eh apagada aqui (o legado tambem nao apaga): ela fica
    *-- em branco na grade e so eh descartada pelo Excluir ou pela limpeza do
    *-- Encerrar (BtnSairClick), fielmente ao legado.
    *--
    *-- Retorno: .T. quando havia linha corrente para limpar.
    *-- PROTECTED por heranca de FormBase (ver nota em FormParaBO) - chamado so
    *-- de dentro da classe (handlers de celula e ValidarSelecaoCaracteristica,
    *-- todos com THIS.).
        IF !USED("cursor_4c_Dados")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF()
            RETURN .F.
        ENDIF

        REPLACE codigos WITH "", descrs WITH "" IN cursor_4c_Dados

        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE GravarCaracteristica
    *==========================================================================
    *-- Persiste em SigPrCar a caracteristica escolhida para a linha
    *-- par_cPkChaves. INSERT quando a linha nasceu nesta sessao (Inserir),
    *-- UPDATE quando o usuario trocou a caracteristica de uma linha que veio
    *-- do CarregarLista. Chamado por ValidarSelecaoCaracteristica assim que o
    *-- par Codigo/Descricao eh resolvido - a gravacao eh imediata, igual a
    *-- exclusao (BtnExcluirClick), porque este dialogo nao tem botao Confirmar
    *-- e o Encerrar do legado nao grava nada.
    *-- PUBLIC - chamado de ValidarSelecaoCaracteristica.
        LPARAMETERS par_cPkChaves, par_cCodigos
        LOCAL loc_cPk, loc_cCodigos, loc_lNovo, loc_lSucesso

        loc_lSucesso = .F.
        loc_cPk      = IIF(VARTYPE(par_cPkChaves) = "C", ALLTRIM(par_cPkChaves), "")
        loc_cCodigos = IIF(VARTYPE(par_cCodigos)  = "C", ALLTRIM(par_cCodigos),  "")

        IF EMPTY(loc_cPk) OR EMPTY(loc_cCodigos) OR ;
           VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_lNovo = THIS.EhRegistroNovo(loc_cPk)

        IF loc_lNovo
            *-- NovoRegistro() chama LimparDados() - preencher DEPOIS dele
            THIS.this_oBusinessObject.NovoRegistro()
        ELSE
            THIS.this_oBusinessObject.this_lNovoRegistro = .F.
            THIS.this_oBusinessObject.EditarRegistro()
        ENDIF

        *-- FormParaBO le a LINHA CORRENTE - posicionar nela antes de chamar
        SELECT cursor_4c_Dados
        LOCATE FOR ALLTRIM(pkchaves) == loc_cPk
        IF !FOUND()
            RETURN .F.
        ENDIF

        IF !THIS.FormParaBO()
            RETURN .F.
        ENDIF

        *-- A linha acabou de receber o codigo resolvido pelo chamador, entao
        *-- FormParaBO ja o trouxe; reafirmar o argumento deixa explicito qual
        *-- codigo esta sendo gravado e protege contra a linha ter sido
        *-- reposicionada entre a escolha e a gravacao
        THIS.this_oBusinessObject.this_cCodigos = loc_cCodigos
        THIS.this_oBusinessObject.this_cCpros   = THIS.this_cCpros

        IF THIS.this_oBusinessObject.Salvar()
            loc_lSucesso = .T.

            *-- Reflete na grade o que o BO levou ao banco (pkchaves gerado no
            *-- Inserir, valores normalizados) - a linha corrente continua sendo
            *-- a de loc_cPk, garantida pelo LOCATE acima
            THIS.BOParaForm()

            IF loc_lNovo
                *-- Registro passou a existir no banco: sai da lista de
                *-- linhas ainda nao gravadas (dai em diante UPDATE, e Excluir apaga la).
                *-- Usa o pkchaves QUE FOI GRAVADO (BOParaForm acabou de
                *-- sincroniza-lo), nao o original - se o BO tiver gerado outro,
                *-- remover o antigo deixaria a linha marcada como nao-gravada para sempre.
                THIS.RemoverPkNovo(loc_cPk)
                THIS.RemoverPkNovo(THIS.this_oBusinessObject.this_cPkChaves)
                THIS.this_lHouveIncl = .T.
            ENDIF
        ELSE
            *-- BusinessBase.Salvar ja exibiu a falha (CLAUDE.md regra #20) -
            *-- so complementa quando ele nao exibiu nada
            IF !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar a " + ;
                        "caracter" + CHR(237) + "stica.", "Erro")
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick
    *==========================================================================
        *-- Espelha cmdExcluir.Click do legado. Linha ja persistida (Codigos
        *-- preenchido) eh excluida de verdade via BO (gravacao nunca eh muda -
        *-- CLAUDE.md); linha ainda em edicao (Codigos vazio, nunca gravada)
        *-- eh so removida do cursor local. PUBLIC - alvo de BINDEVENT (regra #3)
        LOCAL loc_cPkChaves

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF()
            RETURN
        ENDIF

        *-- Guard do legado: "If Not Eof() And (crSigPrCar.CPros =
        *-- crSigCdPro.CPros)" - so apaga linha do produto corrente
        IF ALLTRIM(cpros) != ALLTRIM(THIS.this_cCpros)
            RETURN
        ENDIF

        loc_cPkChaves = ALLTRIM(pkchaves)

        IF !EMPTY(codigos) AND !THIS.EhRegistroNovo(loc_cPkChaves)
            *-- Linha veio do banco (ou ja foi gravada nesta sessao): apaga la
            THIS.this_oBusinessObject.this_cPkChaves     = loc_cPkChaves
            THIS.this_oBusinessObject.this_lNovoRegistro = .F.

            IF THIS.this_oBusinessObject.Excluir()
                THIS.this_lHouveExcl = .T.
                THIS.CarregarLista()
            ELSE
                IF !THIS.this_oBusinessObject.this_lErroExibido
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir " + ;
                            "a caracter" + CHR(237) + "stica.", "Erro")
                ENDIF
            ENDIF
        ELSE
            *-- Linha criada nesta sessao e ainda sem registro em SigPrCar -
            *-- remove so localmente, igual ao Delete/Skip/Skip-1 do legado
            *-- (SET DELETED ON no config.prg ja esconde o registro da grade)
            THIS.RemoverPkNovo(loc_cPkChaves)

            DELETE
            SKIP
            SKIP -1

            THIS.this_lHouveExcl = .T.
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSairClick
    *==========================================================================
        *-- Espelha cmdSair.Click do legado: em modo INSERIR/ALTERAR, descarta
        *-- linhas deixadas em branco (Codigos vazio) antes de encerrar.
        *--
        *-- Linha em branco que NAO esta na lista das linhas ainda nao gravadas eh linha que veio
        *-- do banco e teve a caracteristica limpa (picker cancelado / escolha
        *-- duplicada): no legado ela ficava marcada para Delete e o TABLEUPDATE
        *-- do form pai a apagava de SigPrCar - aqui isso tem de ser feito pelo
        *-- BO, senao o registro antigo sobrevive ao que o usuario apagou.
        *-- PUBLIC - alvo de BINDEVENT (regra #3)
        LOCAL loc_cPkChaves

        IF (THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible) AND ;
           INLIST(THIS.this_cModoPai, "INSERIR", "ALTERAR")

            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                SCAN
                    IF EMPTY(codigos)
                        loc_cPkChaves = ALLTRIM(pkchaves)

                        IF !THIS.EhRegistroNovo(loc_cPkChaves)
                            THIS.this_oBusinessObject.this_cPkChaves     = loc_cPkChaves
                            THIS.this_oBusinessObject.this_lNovoRegistro = .F.

                            IF THIS.this_oBusinessObject.Excluir()
                                THIS.this_lHouveExcl = .T.
                            ELSE
                                IF !THIS.this_oBusinessObject.this_lErroExibido
                                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                                            "vel excluir a caracter" + CHR(237) + ;
                                            "stica.", "Erro")
                                ENDIF
                            ENDIF
                        ELSE
                            THIS.RemoverPkNovo(loc_cPkChaves)
                        ENDIF

                        *-- Excluir() do BO faz SQLEXEC (DELETE + auditoria) e
                        *-- pode deixar outra area corrente - reposicionar antes
                        *-- de apagar a linha local
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(pkchaves) == loc_cPkChaves
                        IF FOUND()
                            DELETE
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarDecoracao
    *==========================================================================
        LOCAL loc_cImgFundo

        *-- Picture = ..\framework\imagens\new_background.jpg (SIGPRCAR original).
        *-- O nome da global tem de ser testado com TYPE() antes de ser USADO:
        *-- gc_4c_CaminhoFramework eh criada pelo config.prg, e o
        *-- ValidarUIFidelity.prg NAO roda config.prg - ele monta o ambiente com
        *-- SET PROCEDURE manual e declara apenas gnConnHandle,
        *-- gc_4c_CaminhoIcones e gb_4c_ValidandoUI (linhas 124-127). Sem o
        *-- teste, a referencia estoura "Variable GC_4C_CAMINHOFRAMEWORK is not
        *-- found" DENTRO do TRY do InicializarForm, o CATCH chama MsgErro e -
        *-- como o validador tambem nao seta gc_4c_ArquivoErroTeste, que eh o
        *-- que faz messages.prg desviar o dialogo para arquivo - abre um MODAL
        *-- de verdade que PENDURA o harness (medido em 2026-09-26: vfp9.exe
        *-- parado 4min30 com 0,25s de CPU, segurando o proprio .log aberto).
        IF TYPE("gc_4c_CaminhoFramework") = "C"
            loc_cImgFundo = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
            IF FILE(loc_cImgFundo)
                THIS.Picture = loc_cImgFundo
            ENDIF
        ENDIF

        *-- Shape1 do legado: elemento decorativo atras dos botoes de acao
        *-- Top=-3, Left=239, Width=250, Height=38, BackStyle=0, BorderStyle=0
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = -3
            .Left        = 239
            .Height      = 38
            .Width       = 250
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *==========================================================================
        LOCAL loc_nW

        *-- 800, o valor LITERAL do cntSombra no SCX, e NAO THIS.Width (480):
        *-- o legado declara um container mais LARGO que o proprio form e deixa o
        *-- form recortar o excesso. Visualmente da no mesmo (a faixa cobre toda
        *-- a largura util nos dois casos) e nao ha o risco que a regra #10/#11
        *-- combate - aquele vem de SUBTRAIR largura (THIS.Width - 60), que
        *-- expoe uma faixa clara a direita; aqui se cobre de sobra. Transcrever
        *-- o numero do SCX eh PILAR 1 literal e evita divergencia na validacao
        *-- de UI, que compara contra o dump.
        loc_nW = 800

        *-- Container cabecalho cinza (cntSombra do legado)
        *-- Top=0, Left=0, Height=80, BackColor=RGB(100,100,100)
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = loc_nW
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            *-- lblSombra: Top=25, Left=10, FontSize=18, ForeColor preto
            *-- (efeito de profundidade atras do lblTitulo)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .Top       = 25
                .Left      = 10
                .Width     = loc_nW - 31   && 769 = 800 - 31, valor literal do SCX
                .Height    = 40
                .Caption   = ""
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Alignment = 0
            ENDWITH

            *-- lblTitulo: Top=24, Left=10, FontSize=18, ForeColor branco
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .Top       = 24
                .Left      = 10
                .Width     = loc_nW - 31   && 769 = 800 - 31, valor literal do SCX
                .Height    = 46
                .Caption   = ""
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Alignment = 0
            ENDWITH
        ENDWITH

        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
    *==========================================================================
        LPARAMETERS par_oContainer
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

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        *-- Reabilita o form pai (mirrors ThisForm.ParentForm.Enabled = .T.
        *-- do cmdSair.Click do legado - feito aqui no Destroy para valer
        *-- em qualquer caminho de fechamento, nao so no botao Sair)
        IF VARTYPE(THIS.par_oFormPai) = "O"
            THIS.par_oFormPai.Enabled = .T.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        THIS.par_oFormPai = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrCarBO.prg):
*====================================================================
* SigPrCarBO.prg
*
* Business Object para SigPrCar (Caracteristicas do Produto)
* Tabela: SigPrCar (codigos char(20), cpros char(14), pkchaves char(20) - PK)
* Sub-formulario modal chamado de dentro do Cadastro de Produtos (SigCdPro)
* para gerenciar as caracteristicas vinculadas ao produto corrente.
* A descricao (Descrs) nao existe na tabela SigPrCar - vem do lookup em
* SigCrRap (tabela de caracteristicas) filtrado pelo Cgrus do produto.
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrCarBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrCar)
    this_cPkChaves = ""    && pkchaves char(20) - PK (fUniqueIds())
    this_cCpros    = ""    && cpros char(14) - FK para SigCdPro.CPros
    this_cCodigos  = ""    && codigos char(20) - FK para SigCrRap.Codigos

    *-- Propriedade de apoio (NAO persistida em SigPrCar - vem do JOIN com SigCrRap)
    this_cDescrs   = ""    && descrs - descricao da caracteristica (SigCrRap.Descrs)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrCar"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigPrCarBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
                THIS.this_cCpros    = TratarNulo(cpros,    "C")
                THIS.this_cCodigos  = TratarNulo(codigos,  "C")

                *-- descrs so existe se o cursor veio de um JOIN com SigCrRap
                IF TYPE(par_cAliasCursor + ".descrs") = "C"
                    THIS.this_cDescrs = TratarNulo(descrs, "C")
                ELSE
                    THIS.this_cDescrs = ""
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigPrCarBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCpros)
            MsgAviso("Produto n" + CHR(227) + "o informado!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cCodigos)
            MsgAviso("Caracter" + CHR(237) + "stica n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrCar
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cPkChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrCar (codigos, cpros, pkchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<EscaparSQL(THIS.this_cPkChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigPrCarBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrCar
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrCar
                SET codigos = <<EscaparSQL(THIS.this_cCodigos)>>,
                    cpros   = <<EscaparSQL(THIS.this_cCpros)>>
                WHERE pkchaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigPrCarBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigPrCar
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrCar WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigPrCarBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca as caracteristicas vinculadas a um produto (par_cCpros)
    * Retorna cursor_4c_Dados com pkchaves, cpros, codigos, descrs
    * (descrs vem do JOIN com SigCrRap)
    *====================================================================
    PROCEDURE Buscar(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT a.pkchaves, a.cpros, a.codigos, b.descrs
                FROM SigPrCar a
                INNER JOIN SigCrRap b ON b.codigos = a.codigos
                WHERE a.cpros = <<EscaparSQL(par_cCpros)>>
                ORDER BY b.descrs
            ENDTEXT

            *-- SQLEXEC cria cursor SOMENTE-LEITURA - a grade precisa inserir
            *-- (Inserir) e apagar (Excluir) linhas localmente, entao o
            *-- resultado eh copiado para um cursor READWRITE (CLAUDE.md:
            *-- "Grid com coluna EDITAVEL exige cursor READWRITE")
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao buscar caracter" + CHR(237) + "sticas:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "SigPrCarBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

