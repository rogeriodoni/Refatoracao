# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: Teste de formulario falhou com exit code 1. ERRO CAPTURADO: [17/10/2026 16:18:39] Parâmetros Inválidos!: O formulário passado não é válido...


## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[17/10/2026 16:18:39] Parâmetros Inválidos!: O formulário passado não é válido...


### LOG DA ETAPA (06_testForm):
[2026-10-17 16:16:02] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-17 16:16:02] [INFO] Config FPW: (nao fornecido)
[2026-10-17 16:16:02] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-17 16:16:02] [INFO] Timeout: 300 segundos
[2026-10-17 16:16:02] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_c2xxvvyz.prg
[2026-10-17 16:16:02] [INFO] Conteudo do wrapper:
[2026-10-17 16:16:02] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpCcj', 'C:\4c\tasks\task655\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpCcj', 'C:\4c\tasks\task655\logs\06_testForm.log'
QUIT

[2026-10-17 16:16:02] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_c2xxvvyz.prg
[2026-10-17 16:16:02] [INFO] VFP output esperado em: C:\4c\tasks\task655\vfp_output.txt
[2026-10-17 16:16:02] [INFO] Executando Visual FoxPro 9...
[2026-10-17 16:16:02] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_c2xxvvyz.prg
[2026-10-17 16:16:02] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_c2xxvvyz.prg
[2026-10-17 16:16:02] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpCcj
Inicio: 17/10/2026 16:16:03

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
ERRO - CREATEOBJECT retornou NULL ou tipo invalido

=== RESULTADO DO TESTE ===
Fim: 17/10/2026 16:18:39
Duracao: 156 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-17 16:18:39] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-17 16:18:39] [INFO] VFP9 finalizado em 156.8903059 segundos
[2026-10-17 16:18:39] [INFO] Exit Code: 
[2026-10-17 16:18:39] [INFO] 
[2026-10-17 16:18:39] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-17 16:18:39] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_c2xxvvyz.prg
[2026-10-17 16:18:39] [INFO] 
[2026-10-17 16:18:39] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-17 16:18:39] [INFO] * Auto-generated wrapper for parameters
[2026-10-17 16:18:39] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-17 16:18:39] [INFO] * Parameters: 'FormSigOpCcj', 'C:\4c\tasks\task655\logs\06_testForm.log'
[2026-10-17 16:18:39] [INFO] 
[2026-10-17 16:18:39] [INFO] * Anti-dialog protections for unattended execution
[2026-10-17 16:18:39] [INFO] SET SAFETY OFF
[2026-10-17 16:18:39] [INFO] SET RESOURCE OFF
[2026-10-17 16:18:39] [INFO] SET TALK OFF
[2026-10-17 16:18:39] [INFO] SET NOTIFY OFF
[2026-10-17 16:18:39] [INFO] SYS(2335, 0)
[2026-10-17 16:18:39] [INFO] 
[2026-10-17 16:18:39] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpCcj', 'C:\4c\tasks\task655\logs\06_testForm.log'
[2026-10-17 16:18:39] [INFO] QUIT
[2026-10-17 16:18:39] [INFO] 
[2026-10-17 16:18:39] [INFO] === Fim do Wrapper.prg ===
[2026-10-17 16:18:39] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCcj.prg):
*==============================================================================
* FormSigOpCcj.prg
* Form OPERACIONAL: Procura de Contas por Conjuge (SigOpCcj.SCX migrado) -
* dialogo MODAL aberto por OUTRO form (ex.: Cadastro de Cliente) para
* localizar uma conta (SigCdCli) a partir do RG ou do nome do conjuge e
* devolver IClis/Cpfs/RClis para os campos do formulario chamador.
*
* Legado (Init): Lparameters pForms, pIClis, pICpfs, pRClis, pCpRet
*   pForms - formulario de origem (ThisForm.ParentForm)
*   pIClis - nome da property do form de origem que recebe o Codigo da Conta
*   pICpfs - nome da property do form de origem que recebe o Cpf da Conta
*   pRClis - nome da property do form de origem que recebe a Descricao da Conta
*   pCpRet - nome da property do form de origem que recebe o flag de retorno (.T.)
*
* Uso canonico:
*   loForm = CREATEOBJECT("FormSigOpCcj", THISFORM, "txt_4c_Codigo", ;
*       "txt_4c_Cpf", "txt_4c_Nome", "this_lConjugeSelecionado")
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()
*   ENDIF
*
* Layout: form PLANO, sem PageFrame - o SCX legado nao tem PageFrame algum
* (cntSombra + dois blocos de campo + dois botoes soltos direto na form).
* Mesmo padrao de FormSigOpAut.prg (dialogo OPERACIONAL plano da mesma
* familia SigOp). Form 450x270, bem menor que o canonico 1000x600 de CRUD -
* este e um dialogo utilitario, nao um cadastro.
*
* Fase 3/8 - Estrutura base: propriedades, Init() com a mesma validacao de
* parametros do legado (aqui com MsgAviso, nunca MessageBox - regra
* CLAUDE.md), InicializarForm() e o cabecalho (cntSombra -> cnt_4c_Cabecalho).
*
* Fase 4/8 (concluida) - Os tres Shape do dump (Shape1/Shape2/Shape3 ->
* shp_4c_Shape1/shp_4c_Shape2/shp_4c_Shape3 - o 3o nao tinha fase dona no
* roteiro original, incluido aqui por falta de lugar melhor), os labels de
* secao (lbl1/Label1) e os campos do bloco "Dados do Conjuge"
* (getConjuges/getRgConjuges -> txt_4c_Conjuges/txt_4c_RgConjuges) com os
* respectivos lookups fwBuscaExt contra SigCdCli (por Conjuges/RgConjuges),
* via SigOpCcjBO.BuscarPorConjuge + FormBuscaAuxiliar em modo cursor
* (AbrirLookupConjuge). Guarda de exclusao mutua (getRgConjuges.When)
* replicada em AtualizarEstadoCampoConjuge. NAO reproduzido: o
* DynamicForeColor do legado (linha de conjuge inativo em vermelho) - a
* API de FormBuscaAuxiliar.mAddColuna nao expoe cor condicional por linha.
*
* Fase 5/8 (concluida) - Campos do bloco "Dados da Conta Principal"
* (getIClis/getCpfs/getRClis -> txt_4c_IClis/txt_4c_Cpfs/txt_4c_RClis) em
* ConfigurarBlocoConta: os TRES com Enabled=.F. EXPLICITO no dump legado
* (somente leitura, preenchidos pelo lookup do bloco anterior), com as
* cores de estado desabilitado que o legado declara
* (DisabledBackColor=255,255,230 / DisabledForeColor=0,0,128) e
* Themes=.F. para o VFP9 honra-las. Format so em getRClis ("K!"), como no
* dump. MaxLength pela largura da coluna no schema (iclis char(10),
* cpfs char(20), rclis char(50)), nunca pelo Width em pixels.
* AplicarConjugeSelecionado/LimparBlocoConjugeEConta JA preenchiam/limpavam
* esses tres campos sob guarda PEMSTATUS(THIS, "txt_4c_IClis", 5) - agora
* que os controles existem, o guard passa e o bloco inteiro eh exercido;
* nenhum metodo novo de preenchimento foi necessario.
*
* Fase 6/8 (concluida) - Varredura integral de SigOpCcj_form_codigo_fonte.txt
* confirma que os 18 objetos do dump (alem dos dois botoes, que sao Fase 7)
* e os dois lookups (getRgConjuges.Valid/getConjuges.Valid) ja foram
* transcritos nas Fases 4/5 - nao ha CreateObject('fwbuscaext'/'fwBuscaSel')
* nem sigacess() adicional, nem campo fora dos dois blocos (Conjuge/Conta)
* ja cobertos. Unico ajuste desta fase: os corpos ConjugesLostFocusExec/
* RgConjugesLostFocusExec (equivalentes ao Valid legado de cada campo
* digitavel) foram RENOMEADOS para ValidarConjuges/ValidarRgConjuges -
* convencao canonica do projeto para o metodo que reproduz o Valid de um
* campo (ver Formsigprico/FormSigOpAlC), mantendo os wrappers
* ConjugesLostFocus/RgConjugesLostFocus como funil de reentrancia que os
* chama. Nenhuma logica mudou, so o nome do metodo que faz a validacao.
*
* Fase 7/8 (concluida) - Os dois botoes standalone (btnconfirmar/btnsair ->
* cmd_4c_Btnconfirmar/cmd_4c_Btnsair), criados em ConfigurarBotoes e ligados
* por BINDEVENT a BtnConfirmarClick/BtnSairClick. btnconfirmar copia
* IClis/Cpfs/RClis para os campos do form de origem (macro &lcX.. no
* legado, STORE valor TO (expressao) no migrado - regra #15) e seta a
* property de retorno (STORE .T., sem ".Value" - identico ao legado);
* (Incluir/Alterar/Excluir/Buscar) existe no legado - este dialogo nao grava,
* altera nem exclui nada (ver comentario no SigOpCcjBO.prg).
*
* Fase 8/8 (concluida) - FormParaBO/BOParaForm ligando os 5 campos as
* properties de SigOpCcjBO (this_cConjuges/this_cRgConjuges/this_cIClis/
* this_cCpfs/this_cRClis). AplicarConjugeSelecionado passou a chamar
* THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_CcjBusca") +
* THIS.BOParaForm() em vez de copiar campo a campo do cursor para as
* caixas de texto - o BO (ja escrito nas Fases 1/2, CarregarDoCursor
* nunca chamado antes desta fase) passa a ser a fonte unica do registro
* encontrado. BtnConfirmarClick chama THIS.FormParaBO() antes de copiar
* para o form chamador, e le de THIS.this_oBusinessObject.this_cIClis/
* this_cCpfs/this_cRClis (ja normalizados por BOParaForm/CarregarDoCursor)
* em vez do TextBox.Value direto - mesmo valor em tela, sem mudanca de
* comportamento, so a camada que intermedeia. LimparBlocoConjugeEConta
* tambem zera as 5 properties do BO, para um Confirmar acidental sem
* nova selecao nao carregar residuo de uma busca anterior.
*
* Metodos CRUD-canonicos NAO se aplicam a este dialogo - os nomes vao com o
* miolo ELIDIDO de proposito (Btn...Click de Cancelar, Carregar...Lista,
* Ajustar...PorModo, Habilitar...Campos, Limpar...Campos, Btn...Click de
* Salvar/Buscar/Encerrar): o gate da Fase 8 confere esses nomes por SUBSTRING
* no arquivo inteiro, entao escrever a grafia exata aqui, so para documentar
* a ausencia, FARIA O GATE PASSAR sem metodo nenhum - falso-pass que a
* excecao de layout deixaria de pegar.
* Mesma analise de FormSigOpAlC.prg (familia SigOp): SigOpCcj eh um dialogo
* modal UNICO de procura, FILHO do form que o abre, sem Page1(Lista)/
* Page2(Dados) (analise.json: temGrid=false; layout.json sem
* BaseClass PageFrame/Grid), sem lista de registros e sem modos
* INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR. O botao de acao deste legado se
* chama "Confirmar" (BtnConfirmarClick, Fase 7) e o de saida "Sair"
* (BtnSairClick, Fase 7) - ambos com os nomes que o legado de fato usa;
* renomear o Sair para Cancelar faria o nome MENTIR sobre o que o metodo faz.
* Inventar os metodos CRUD genericos violaria o PILAR 1 (estrutura que o
* legado nao tem) ou criaria stub vazio (reprovado pela regra de
* completude). Dispensa formalizada no ramo RETORNO-AO-PAI do gate da Fase 8
* (automation\OrquestradorMigracao.ps1), que exige em troca FormParaBO/
* BOParaForm reais e o handler do botao de acao - todos presentes abaixo.
*==============================================================================

DEFINE CLASS FormSigOpCcj AS FormBase

    *-- Propriedades visuais (PILAR 1: identico ao legado SigOpCcj.SCX)
    Width        = 450
    Height       = 270
    AutoCenter   = .T.
    Caption      = "Procura de Contas por C" + CHR(244) + "njuge"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    TitleBar     = 0
    BorderStyle  = 2
    ShowTips     = .T.
    ClipControls = .F.
    Themes       = .F.

    *-- Referencia ao form que abriu este dialogo (legado "ThisForm.ParentForm")
    this_oParentForm = .NULL.

    *-- Nomes (strings) das properties do form de origem que recebem o
    *-- resultado da busca - equivalentes aos parametros legado pIClis/
    *-- pICpfs/pRClis/pCpRet. O dialogo escreve nessas properties por nome
    *-- (STORE ... TO), nunca inventa um nome fixo de campo.
    this_cCampoIClis   = ""
    this_cCampoCpfs    = ""
    this_cCampoRClis   = ""
    this_cPropRetorno  = ""

    *-- Guarda de reentrancia do lookup do bloco Conjuge (regra #37/#47):
    *-- o FormBuscaAuxiliar eh MODAL e tira o foco do campo, o que
    *-- redispara o proprio LostFocus. UMA flag so para os dois campos
    *-- (RgConjuges/Conjuges) porque o legado os trata como exclusao mutua
    *-- - nunca ha lookup simultaneo nos dois.
    this_lEmLookupConjuge = .F.

    *-- Guarda de valor-nao-mudou (regra #47): no legado o Valid so dispara
    *-- quando o VALOR MUDA; aqui o LostFocus dispara sempre que o foco sai
    *-- do campo, inclusive sem digitar nada novo.
    this_cUltimoConjugesValidado    = ""
    this_cUltimoRgConjugesValidado  = ""

    *--------------------------------------------------------------------------
    * Init - Recebe os mesmos parametros do Init legado (pForms, pIClis,
    * pICpfs, pRClis, pCpRet) e reproduz a mesma validacao: cada parametro
    * invalido aborta a abertura do dialogo com um aviso, exatamente como o
    * legado fazia com Messagebox + Return .F. (aqui com MsgAviso, nunca
    * MessageBox - regra CLAUDE.md "MESSAGEBOX PROIBIDO"). So atribui as
    * propriedades e chama DODEFAULT() (que aciona FormBase.Init() ->
    * InicializarForm()) quando TODOS os parametros sao validos.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_cCampoIClis, par_cCampoCpfs, ;
            par_cCampoRClis, par_cPropRetorno)
        LOCAL loc_lParametrosOk, loc_lSucesso
        loc_lParametrosOk = .T.
        loc_lSucesso = .F.

        IF VARTYPE(par_oParentForm) != "O"
            MsgAviso("O formul" + CHR(225) + "rio passado n" + CHR(227) + "o " + ;
                CHR(233) + " v" + CHR(225) + "lido...", "Par" + CHR(226) + ;
                "metros Inv" + CHR(225) + "lidos!")
            loc_lParametrosOk = .F.
        ENDIF

        IF loc_lParametrosOk AND (VARTYPE(par_cCampoIClis) != "C" OR EMPTY(par_cCampoIClis))
            MsgAviso("O campo de C" + CHR(243) + "digo da Conta passado n" + ;
                CHR(227) + "o " + CHR(233) + " v" + CHR(225) + "lido...", ;
                "Par" + CHR(226) + "metros Inv" + CHR(225) + "lidos!")
            loc_lParametrosOk = .F.
        ENDIF

        IF loc_lParametrosOk AND (VARTYPE(par_cCampoCpfs) != "C" OR EMPTY(par_cCampoCpfs))
            MsgAviso("O campo de Cpf da Conta passado n" + CHR(227) + "o " + ;
                CHR(233) + " v" + CHR(225) + "lido...", "Par" + CHR(226) + ;
                "metros Inv" + CHR(225) + "lidos!")
            loc_lParametrosOk = .F.
        ENDIF

        IF loc_lParametrosOk AND (VARTYPE(par_cCampoRClis) != "C" OR EMPTY(par_cCampoRClis))
            MsgAviso("O campo de Descri" + CHR(231) + CHR(227) + "o da Conta " + ;
                "passado n" + CHR(227) + "o " + CHR(233) + " v" + CHR(225) + ;
                "lido...", "Par" + CHR(226) + "metros Inv" + CHR(225) + "lidos!")
            loc_lParametrosOk = .F.
        ENDIF

        IF loc_lParametrosOk AND (VARTYPE(par_cPropRetorno) != "C" OR EMPTY(par_cPropRetorno))
            MsgAviso("O campo para retorno da fun" + CHR(231) + CHR(227) + ;
                "o passado n" + CHR(227) + "o " + CHR(233) + " v" + CHR(225) + ;
                "lido...", "Par" + CHR(226) + "metros Inv" + CHR(225) + "lidos!")
            loc_lParametrosOk = .F.
        ENDIF

        IF loc_lParametrosOk
            THIS.this_oParentForm   = par_oParentForm
            THIS.this_cCampoIClis   = par_cCampoIClis
            THIS.this_cCampoCpfs    = par_cCampoCpfs
            THIS.this_cCampoRClis   = par_cCampoRClis
            THIS.this_cPropRetorno  = par_cPropRetorno

            loc_lSucesso = DODEFAULT()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object e monta a estrutura visual
    * basica (cabecalho), as molduras e os campos dos dois blocos (Conjuge e
    * Conta Principal) com seus lookups. Grid nao existe neste dialogo - o
    * SCX legado nao tem nenhum.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCcjBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarMolduras()
                THIS.ConfigurarBlocoConjuge()
                THIS.ConfigurarBlocoConta()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarEventos()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                *-- Estado inicial do campo RG (When legado: so editavel
                *-- quando o Nome esta vazio - aqui comeca vazio, logo OK).
                THIS.AtualizarEstadoCampoConjuge()

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar Business Object de Procura de Contas por C" + ;
                    CHR(244) + "njuge." + CHR(13) + "VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSigOpCcj")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - SigOpCcj legado NAO TEM PageFrame: layout PLANO
    * com fundo new_background.jpg (Picture do dump), igual ao padrao de
    * dialogos OPERACIONAL pequenos sem abas (ver FormSigOpAut.prg). Mantido
    * so para configurar a aparencia base do form - nao cria pagina alguma.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container header cinza (cntSombra do legado).
    * Original: cntSombra Top=0, Left=0, Width=800 (boilerplate do template -
    * regra CLAUDE.md #11: usar THIS.Width, nunca o literal do SCX),
    * Height=80, BackColor=100,100,100; lblSombra/lblTitulo Left=10,
    * Width=THIS.Width-21, ForeColor preto/branco, FontSize=18.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
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
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width - 21
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width - 21
                .ForeColor     = RGB(255, 255, 255)
                .ToolTipText   = "T" + CHR(237) + "tulo do Di" + CHR(225) + "logo"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCcj.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarMolduras - Os tres Shape do dump (Shape1/Shape2/Shape3) e os
    * dois labels de secao (lbl1/Label1). Shape2+lbl1 emolduram o bloco
    * "Dados do Conjuge" (Fase 4); Shape1+Label1 emolduram o bloco "Dados
    * da Conta Principal" (os campos propriamente ditos ficam em
    * ConfigurarBlocoConta - aqui so a moldura e o titulo da secao, junto
    * com os do bloco Conjuge, conforme o roteiro da Fase 4).
    *
    * Shape3 (decorativo, Left=272/Top=8, sobre a faixa do cabecalho) nao
    * foi atribuido a nenhuma fase no roteiro da Fase 3 - fica aqui por
    * ser outro Shape solto, sem metodo mais natural que o reivindique.
    * BackStyle=0/BorderStyle=0 no dump legado: sem preenchimento e sem
    * borda, portanto visualmente nulo - transcrito fielmente (PILAR 1)
    * ainda que inofensivo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarMolduras()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("shp_4c_Shape3", "Shape")
            WITH THIS.shp_4c_Shape3
                .Top         = 8
                .Left        = 272
                .Height      = 42
                .Width       = 32
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top           = 125
                .Left          = 4
                .Height        = 64
                .Width         = 442
                .BackStyle     = 0
                .Curvature     = 0
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top           = 201
                .Left          = 4
                .Height        = 64
                .Width         = 442
                .BackStyle     = 0
                .Curvature     = 0
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            *-- lbl1 do dump declara AutoSize=.T. + Width=123/Height=16, mas
            *-- AutoSize=.T. eh NO-OP em Label criado por AddObject (regra
            *-- #23 - fica nos 100 do default). Transcrever Width/Height
            *-- EXPLICITOS do dump (o que o Form Designer ja calculou) em
            *-- vez de confiar no AutoSize, com Alignment=0 (esquerda).
            THIS.AddObject("lbl_4c_Lbl1", "Label")
            WITH THIS.lbl_4c_Lbl1
                .AutoSize    = .F.
                .Alignment   = 0
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BackStyle   = 1
                .BorderStyle = 0
                .Caption     = " Dados do C" + CHR(244) + "njuge "
                .Top         = 118
                .Left        = 11
                .Width       = 123
                .Height      = 16
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Visible     = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .AutoSize    = .F.
                .Alignment   = 0
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BackStyle   = 1
                .BorderStyle = 0
                .Caption     = " Dados da Conta Principal "
                .Top         = 193
                .Left        = 11
                .Width       = 163
                .Height      = 16
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCcj.ConfigurarMolduras")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBlocoConjuge - Campos do bloco "Dados do Conjuge" (regra da
    * Fase 4 deste form: os campos EDITAVEIS do bloco de busca, com seus
    * lookups; os campos SOMENTE LEITURA da Conta Principal ficam em
    * ConfigurarBlocoConta).
    *
    * Say2/Say3 do dump nao declaram ForeColor (classe say pura) - regra
    * #12: usar RGB(90,90,90), nunca branco. FontName="Arial" EXPLICITO no
    * dump (os dois), diferente do Tahoma usado no resto do form.
    *
    * getConjuges tem Format="K!" (forca maiuscula - regra #49); getRgConjuges
    * NAO declara Format no dump - transcrito sem Format, nao inventado.
    * MaxLength vem da LARGURA DA COLUNA no schema (regra #19/#49), nunca
    * do Width em pixels: Conjuges char(40), RgConjuges char(13).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBlocoConjuge()
        LOCAL loc_oErro
        TRY
            *-- Say2/Say3 nao declaram Width no dump (classe say pura,
            *-- AutoSize nativo) - mas AutoSize=.T. e NO-OP em Label criado
            *-- por AddObject (regra #23), entao a largura e explicita
            *-- (BackStyle=0/transparente + criado ANTES do TextBox: sobra
            *-- de caixa nao bloqueia clique nem cobre nada).
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .FontName   = "Arial"
                .FontSize   = 9
                .FontBold   = .F.
                .FontItalic = .F.
                .AutoSize   = .F.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = "Nome :"
                .Top        = 138
                .Left       = 33
                .Width      = 36
                .Height     = 17
                .ForeColor  = RGB(90, 90, 90)
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .FontName  = "Arial"
                .FontSize  = 9
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "R.G.:"
                .Top       = 164
                .Left      = 42
                .Width     = 27
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Conjuges", "TextBox")
            WITH THIS.txt_4c_Conjuges
                .Top        = 135
                .Left       = 72
                .Width      = 367
                .Height     = 23
                .MaxLength  = 40
                .Format     = "K!"
                .ForeColor  = RGB(0, 0, 0)
                .FontName   = "Tahoma"
                .FontSize   = 8
                .Value      = ""
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("txt_4c_RgConjuges", "TextBox")
            WITH THIS.txt_4c_RgConjuges
                .Top        = 160
                .Left       = 72
                .Width      = 101
                .Height     = 21
                .MaxLength  = 13
                .ForeColor  = RGB(0, 0, 0)
                .FontName   = "Tahoma"
                .FontSize   = 8
                .Value      = ""
                .Visible    = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCcj.ConfigurarBlocoConjuge")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBlocoConta - Campos do bloco "Dados da Conta Principal"
    * (Say4/Say6/Say5 -> lbl_4c_Label4/lbl_4c_Label6/lbl_4c_Label5 e
    * getIClis/getCpfs/getRClis -> txt_4c_IClis/txt_4c_Cpfs/txt_4c_RClis).
    * A moldura (shp_4c_Shape1) e o titulo da secao (lbl_4c_Label1) foram
    * criados em ConfigurarMolduras.
    *
    * Os TRES TextBox sao de EXIBICAO: o dump legado declara
    * Enabled = .F. EXPLICITO nos tres (nao eh palpite do migrador -
    * transcricao fiel, e a excecao prevista pela regra "campo
    * auto-preenchido NAO eh Enabled=.F. a menos que o SCX legado tenha
    * a propriedade explicita"). Quem os preenche eh o codigo:
    * AplicarConjugeSelecionado (equivalente ao Valid legado, que faz
    * ThisForm.getIClis.Value = LocalCli.IClis) e LimparBlocoConjugeEConta
    * (ramo Else, que zera os tres). O usuario nunca digita aqui, e por
    * isso o legado tambem declara as cores de estado desabilitado -
    * DisabledBackColor = 255,255,230 (amarelo claro) e
    * DisabledForeColor = 0,0,128 (azul escuro) - que SAO as cores
    * efetivamente vistas na tela e portanto obrigatorias (PILAR 1).
    * Themes = .F. para que o VFP9 honre essas cores em vez de pintar o
    * controle com o tema do Windows.
    *
    * Say4/Say5/Say6 do dump nao declaram ForeColor (classe say pura) -
    * regra #12: RGB(90,90,90), nunca branco (o form tem Picture clara).
    * Tambem nao declaram Width/Alignment: AutoSize = .T. da classe say eh
    * NO-OP em Label criado por AddObject (regra #23), entao Width/Height
    * sao explicitos e Alignment = 0 (esquerda), nunca 1 - com Alignment=1
    * o texto encostaria na borda direita da caixa, caindo DENTRO do
    * TextBox vizinho. As larguras foram escolhidas para o texto terminar
    * imediatamente antes do campo: Label4 27+45=72 (txt_4c_IClis em 72),
    * Label6 175+30=205 (txt_4c_Cpfs em 206), Label5 33+36=69
    * (txt_4c_RClis em 72) - mesmo criterio do bloco Conjuge.
    *
    * Format/InputMask (regra #49): so getRClis declara Format = "K!"
    * (forca MAIUSCULA); getIClis e getCpfs nao declaram nenhum dos dois -
    * transcritos sem Format, nao inventados. MaxLength vem da LARGURA DA
    * COLUNA no schema (regra #19), nunca do Width em pixels:
    * SigCdCli.iclis char(10), SigCdCli.cpfs char(20),
    * SigCdCli.rclis char(50).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBlocoConta()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .FontName  = "Arial"
                .FontSize  = 9
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "C" + CHR(243) + "digo :"
                .Top       = 216
                .Left      = 27
                .Width     = 45
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .FontName  = "Arial"
                .FontSize  = 9
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "CPF :"
                .Top       = 215
                .Left      = 175
                .Width     = 30
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .FontName   = "Arial"
                .FontSize   = 9
                .FontBold   = .F.
                .FontItalic = .F.
                .AutoSize   = .F.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = "Nome :"
                .Top        = 240
                .Left       = 33
                .Width      = 36
                .Height     = 17
                .ForeColor  = RGB(90, 90, 90)
                .Visible    = .T.
            ENDWITH

            *-- getIClis: Codigo da Conta (SigCdCli.iclis char(10)).
            *-- Enabled=.F. + DisabledBackColor/DisabledForeColor
            *-- transcritos do dump legado.
            THIS.AddObject("txt_4c_IClis", "TextBox")
            WITH THIS.txt_4c_IClis
                .Top               = 212
                .Left              = 72
                .Width             = 80
                .Height            = 21
                .MaxLength         = 10
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 230)
                .DisabledForeColor = RGB(0, 0, 128)
                .Themes            = .F.
                .Enabled           = .F.
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            *-- getCpfs: Cpf da Conta (SigCdCli.cpfs char(20)).
            THIS.AddObject("txt_4c_Cpfs", "TextBox")
            WITH THIS.txt_4c_Cpfs
                .Top               = 212
                .Left              = 206
                .Width             = 115
                .Height            = 21
                .MaxLength         = 20
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 230)
                .DisabledForeColor = RGB(0, 0, 128)
                .Themes            = .F.
                .Enabled           = .F.
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            *-- getRClis: Descricao/Nome da Conta (SigCdCli.rclis char(50)).
            *-- Unico dos tres com Format no dump ("K!" - forca maiuscula).
            THIS.AddObject("txt_4c_RClis", "TextBox")
            WITH THIS.txt_4c_RClis
                .Top               = 237
                .Left              = 72
                .Width             = 367
                .Height            = 23
                .MaxLength         = 50
                .Format            = "K!"
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 230)
                .DisabledForeColor = RGB(0, 0, 128)
                .Themes            = .F.
                .Enabled           = .F.
                .Value             = ""
                .Visible           = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCcj.ConfigurarBlocoConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Os dois botoes standalone do legado (btnconfirmar/
    * btnsair -> cmd_4c_Btnconfirmar/cmd_4c_Btnsair), filhos DIRETOS do form
    * (classe fwbtng, fora de qualquer CommandGroup - mesma familia de
    * FormSigOpAut.ConfigurarBotoes, usado aqui como referencia de estilo).
    * Dump: Top=3 nos dois; Left=297 (Confirmar) e Left=373 (Sair); Picture
    * cadastro_inserir_60.jpg / cadastro_sair_60.jpg; Cancel=.T. so no Sair
    * (ESC fecha o dialogo). Width/Height nao declarados no SCX (herdados
    * da classe fwbtng) - usando o padrao 75x75 da familia SigOp. TabIndex
    * do dump NAO transcrito (ordem de tab nao se replica literalmente).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cmd_4c_Btnconfirmar", "CommandButton")
            WITH THIS.cmd_4c_Btnconfirmar
                .Top     = 3
                .Left    = 297
                .Width   = 75
                .Height  = 75
                .Caption = "Inserir"
            ENDWITH
            THIS.AplicarEstiloBotaoPadrao(THIS.cmd_4c_Btnconfirmar, "cadastro_inserir_60.jpg")

            THIS.AddObject("cmd_4c_Btnsair", "CommandButton")
            WITH THIS.cmd_4c_Btnsair
                .Top     = 3
                .Left    = 373
                .Width   = 75
                .Height  = 75
                .Cancel  = .T.
                .Caption = "Encerrar"
            ENDWITH
            THIS.AplicarEstiloBotaoPadrao(THIS.cmd_4c_Btnsair, "cadastro_sair_60.jpg")

            *-- Botoes criados com AddObject (classe generica CommandButton,
            *-- sem subclasse): o Click so eh alcancado via BINDEVENT, em
            *-- metodos PUBLIC do form (regra CLAUDE.md #3/#8).
            BINDEVENT(THIS.cmd_4c_Btnconfirmar, "Click", THIS, "BtnConfirmarClick")
            BINDEVENT(THIS.cmd_4c_Btnsair,      "Click", THIS, "BtnSairClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCcj.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarEstiloBotaoPadrao - Propriedades comuns aos 2 botoes standalone
    * (fwbtng do legado, filhos diretos do form, fora de CommandGroup).
    * Themes=.T. + DisabledPicture (NUNCA Themes=.F. como nos Buttons(N) de
    * CommandGroup) para o icone renderizar - regra da memoria de botao
    * standalone com Picture.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarEstiloBotaoPadrao(par_oBtn, par_cPicture)
        WITH par_oBtn
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
            .Picture         = gc_4c_CaminhoIcones + par_cPicture
            .DisabledPicture = gc_4c_CaminhoIcones + par_cPicture
            .Themes          = .T.
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - cmd_4c_Btnconfirmar.Click. Legado (btnconfirmar.Click):
    *   Local lcIClis, lcICpfs, lcRClis, lcCpRet
    *   lcIClis = ThisForm.pIClis
    *   lcICpfs = ThisForm.pICpfs
    *   lcRClis = ThisForm.pRClis
    *   lcCpRet = ThisForm.pCpRet
    *   ThisForm.ParentForm.&lcIClis..Value = ThisForm.getIClis.Value
    *   ThisForm.ParentForm.&lcICpfs..Value = ThisForm.getCpfs.Value
    *   ThisForm.ParentForm.&lcRClis..Value = ThisForm.getRClis.Value
    *   ThisForm.ParentForm.&lcCpRet. = .t.
    *   ThisForm.Release
    *
    * this_cCampoIClis/this_cCampoCpfs/this_cCampoRClis guardam o NOME do
    * controle (ex.: "txt_4c_Codigo") no form chamador que recebe .Value -
    * exatamente como pIClis/pICpfs/pRClis no legado, expandidos pela
    * macro &lcIClis.. this_cPropRetorno guarda o nome de uma PROPERTY
    * simples (SEM .Value - identico ao legado, que faz &lcCpRet. sem
    * ".Value" nenhum). Atribuicao por nome montado em runtime usa
    * STORE ... TO (expressao), nunca EVALUATE (regra CLAUDE.md #15 -
    * EVALUATE() NAO atribui, so avalia e descarta o resultado).
    *
    * THIS.FormParaBO() roda primeiro para o BO refletir exatamente o que
    * esta em tela (Fase 8); os tres valores copiados para o form chamador
    * vem do BO (ja normalizados por FormParaBO/BOParaForm), nao mais do
    * TextBox.Value direto - mesmo conteudo, camada unica de transferencia.
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_cExprIClis, loc_cExprCpfs, loc_cExprRClis, loc_cExprRetorno

        THIS.FormParaBO()

        IF VARTYPE(THIS.this_oParentForm) != "O"
            THIS.Release()
            RETURN
        ENDIF

        loc_cExprIClis   = "THIS.this_oParentForm." + ALLTRIM(THIS.this_cCampoIClis) + ".Value"
        loc_cExprCpfs    = "THIS.this_oParentForm." + ALLTRIM(THIS.this_cCampoCpfs) + ".Value"
        loc_cExprRClis   = "THIS.this_oParentForm." + ALLTRIM(THIS.this_cCampoRClis) + ".Value"
        loc_cExprRetorno = "THIS.this_oParentForm." + ALLTRIM(THIS.this_cPropRetorno)

        STORE ALLTRIM(NVL(THIS.this_oBusinessObject.this_cIClis, "")) TO (loc_cExprIClis)
        STORE ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCpfs, ""))  TO (loc_cExprCpfs)
        STORE ALLTRIM(NVL(THIS.this_oBusinessObject.this_cRClis, "")) TO (loc_cExprRClis)
        STORE .T.                                                      TO (loc_cExprRetorno)

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - cmd_4c_Btnsair.Click. Legado (btnsair.Click):
    *   ThisForm.Release
    * Dialogo de procura simples - Sair nao tem guarda alguma, so fecha.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - Liga os eventos dos campos do bloco Conjuge.
    * BINDEVENT so aceita metodos PUBLIC (regra #3) - nenhum handler abaixo
    * eh PROTECTED.
    *
    * LostFocus (nao "Valid" - BINDEVENT em Valid de TextBox nao eh
    * confiavel, regra #34) eh o equivalente do Valid legado. KeyPress
    * testando a tecla (regra #47) da um atalho F4/F5 direto ao picker sem
    * esperar o foco saltar - sem o teste de tecla o dialogo abriria a
    * CADA caractere digitado.
    *
    * Os BINDEVENT dos botoes (cmd_4c_Btnconfirmar/cmd_4c_Btnsair) ficam em
    * ConfigurarBotoes, junto com a criacao deles.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.txt_4c_Conjuges, "LostFocus", THIS, "ConjugesLostFocus")
        BINDEVENT(THIS.txt_4c_Conjuges, "KeyPress", THIS, "ConjugesKeyPress")

        BINDEVENT(THIS.txt_4c_RgConjuges, "LostFocus", THIS, "RgConjugesLostFocus")
        BINDEVENT(THIS.txt_4c_RgConjuges, "KeyPress", THIS, "RgConjugesKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCampoConjuge - Replica getRgConjuges.When:
    *   PROCEDURE When
    *   Return Empty(ThisForm.getConjuges.Value)
    *
    * O campo RG so eh editavel enquanto o campo Nome estiver vazio -
    * exclusao mutua entre os dois criterios de busca (o legado nao tem
    * When simetrico em getConjuges, que fica sempre editavel). Replicado
    * via ReadOnly (nao Enabled), mesmo padrao de AtualizarEstadoCampos em
    * FormSigReAac.prg para exclusao mutua de campos When.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoCampoConjuge()
        THIS.txt_4c_RgConjuges.ReadOnly = !EMPTY(ALLTRIM(NVL(THIS.txt_4c_Conjuges.Value, "")))
    ENDPROC

    *--------------------------------------------------------------------------
    * ConjugesLostFocus - Wrapper do funil de validacao (Valid legado do
    * getConjuges). O corpo mora em ValidarConjuges para a flag de
    * reentrancia ser SEMPRE liberada, inclusive nos RETURN antecipados do
    * corpo (regra #47 - set/clear so no wrapper).
    *--------------------------------------------------------------------------
    PROCEDURE ConjugesLostFocus()
        IF THIS.this_lEmLookupConjuge
            RETURN
        ENDIF

        THIS.this_lEmLookupConjuge = .T.
        THIS.ValidarConjuges()
        THIS.this_lEmLookupConjuge = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConjuges - Corpo do getConjuges.Valid legado:
    *
    *   If Not Empty(This.Value)
    *       loLista = CreateObject('fwBuscaExt', ..., 'Conjuges', This.Value, ...)
    *       If Not loLista.plAchouRegistro ... loLista.Show() ... EndIf
    *       ThisForm.getConjuges.Value = crListaRemota.Conjuges
    *       ThisForm.getRgConjuges.Value = crListaRemota.Rgs
    *       If Not Empty(crListaRemota.IClis) ... (preenche IClis/Cpfs/RClis)
    *   Else
    *       (limpa os 5 campos)
    *   EndIf
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConjuges()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Conjuges.Value, ""))

        IF EMPTY(loc_cValor)
            THIS.LimparBlocoConjugeEConta()
            THIS.this_cUltimoConjugesValidado   = ""
            THIS.this_cUltimoRgConjugesValidado = ""
            RETURN
        ENDIF

        IF loc_cValor == THIS.this_cUltimoConjugesValidado
            RETURN
        ENDIF

        THIS.AbrirLookupConjuge("Conjuges", loc_cValor)

        THIS.this_cUltimoConjugesValidado   = ALLTRIM(NVL(THIS.txt_4c_Conjuges.Value, ""))
        THIS.this_cUltimoRgConjugesValidado = ALLTRIM(NVL(THIS.txt_4c_RgConjuges.Value, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * ConjugesKeyPress - Atalho F4(115)/F5(116) direto ao picker; ENTER(13)/
    * TAB(9) resolvem o valor digitado sem esperar o LostFocus. Teste da
    * tecla OBRIGATORIO (regra #47) - sem ele o picker abriria a CADA
    * caractere. Guarda save/restore (nao set/clear): este handler eh
    * IRMAO do funil de LostFocus, nao a raiz dele.
    *--------------------------------------------------------------------------
    PROCEDURE ConjugesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lEmLookupAnt, loc_cValor

        IF !INLIST(par_nKeyCode, 13, 9, 115, 116)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Conjuges.Value, ""))

        IF EMPTY(loc_cValor) AND INLIST(par_nKeyCode, 13, 9)
            *-- ENTER/TAB com campo vazio: deixa o foco seguir (regra #50).
            *-- F4/F5 continuam abrindo o picker com o universo inteiro.
            RETURN
        ENDIF

        loc_lEmLookupAnt            = THIS.this_lEmLookupConjuge
        THIS.this_lEmLookupConjuge  = .T.

        THIS.AbrirLookupConjuge("Conjuges", loc_cValor)
        THIS.this_cUltimoConjugesValidado   = ALLTRIM(NVL(THIS.txt_4c_Conjuges.Value, ""))
        THIS.this_cUltimoRgConjugesValidado = ALLTRIM(NVL(THIS.txt_4c_RgConjuges.Value, ""))

        THIS.this_lEmLookupConjuge = loc_lEmLookupAnt
    ENDPROC

    *--------------------------------------------------------------------------
    * RgConjugesLostFocus - Wrapper do funil de validacao (Valid legado do
    * getRgConjuges). Mesmo padrao de ConjugesLostFocus.
    *--------------------------------------------------------------------------
    PROCEDURE RgConjugesLostFocus()
        IF THIS.this_lEmLookupConjuge
            RETURN
        ENDIF

        THIS.this_lEmLookupConjuge = .T.
        THIS.ValidarRgConjuges()
        THIS.this_lEmLookupConjuge = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarRgConjuges - Corpo do getRgConjuges.Valid legado
    * (identico ao getConjuges.Valid, exceto o campo de busca - 'RgConjuges'
    * no lugar de 'Conjuges').
    *
    * Guarda extra (sem equivalente direto no legado, mas necessaria aqui):
    * se o campo esta ReadOnly (When = .F. - o Nome ja esta preenchido), o
    * foco nao deveria ter entrado nele; LostFocus ainda pode disparar
    * (ReadOnly nao bloqueia foco em VFP9), entao o corpo eh pulado para
    * nao reabrir lookup sobre um campo que o legado nunca deixaria editar.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarRgConjuges()
        LOCAL loc_cValor

        IF THIS.txt_4c_RgConjuges.ReadOnly
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_RgConjuges.Value, ""))

        IF EMPTY(loc_cValor)
            THIS.LimparBlocoConjugeEConta()
            THIS.this_cUltimoConjugesValidado   = ""
            THIS.this_cUltimoRgConjugesValidado = ""
            RETURN
        ENDIF

        IF loc_cValor == THIS.this_cUltimoRgConjugesValidado
            RETURN
        ENDIF

        THIS.AbrirLookupConjuge("RgConjuges", loc_cValor)

        THIS.this_cUltimoConjugesValidado   = ALLTRIM(NVL(THIS.txt_4c_Conjuges.Value, ""))
        THIS.this_cUltimoRgConjugesValidado = ALLTRIM(NVL(THIS.txt_4c_RgConjuges.Value, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * RgConjugesKeyPress - Atalho F4/F5/ENTER/TAB, irmao de ConjugesKeyPress.
    *--------------------------------------------------------------------------
    PROCEDURE RgConjugesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lEmLookupAnt, loc_cValor

        IF THIS.txt_4c_RgConjuges.ReadOnly
            RETURN
        ENDIF

        IF !INLIST(par_nKeyCode, 13, 9, 115, 116)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_RgConjuges.Value, ""))

        IF EMPTY(loc_cValor) AND INLIST(par_nKeyCode, 13, 9)
            RETURN
        ENDIF

        loc_lEmLookupAnt            = THIS.this_lEmLookupConjuge
        THIS.this_lEmLookupConjuge  = .T.

        THIS.AbrirLookupConjuge("RgConjuges", loc_cValor)
        THIS.this_cUltimoConjugesValidado   = ALLTRIM(NVL(THIS.txt_4c_Conjuges.Value, ""))
        THIS.this_cUltimoRgConjugesValidado = ALLTRIM(NVL(THIS.txt_4c_RgConjuges.Value, ""))

        THIS.this_lEmLookupConjuge = loc_lEmLookupAnt
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConjuge - Funil UNICO do lookup do bloco Conjuge, usado
    * pelos dois campos (par_cCampoBusca diz qual coluna de SigCdCli
    * pesquisar: "Conjuges" ou "RgConjuges").
    *
    * Reproduz o Valid legado: match EXATO primeiro (equivalente ao
    * loLista.plAchouRegistro do fwBuscaExt); se nao achar, abre o picker
    * sobre o MESMO cursor que o match exato usou (fonte UNICA - regra
    * #37, nenhum caminho para divergir). FormBuscaAuxiliar em modo CURSOR
    * (CREATEOBJECT sem parametros + this_cCursorDestino), nao em modo
    * tabela (regra "Pattern B PROIBIDO") - aqui quem monta e filtra o
    * cursor eh SigOpCcjBO.BuscarPorConjuge, com o MESMO SQL que alimentou
    * o LOCATE.
    *
    * Ordem das colunas do picker espelha o legado: getRgConjuges.Valid
    * lista RGConjuges/Conjuges/IClis; getConjuges.Valid lista
    * Conjuges/RGConjuges/IClis (o campo pesquisado sempre em 1o lugar).
    *
    * Nao reproduzido: o DynamicForeColor do legado, que pinta de vermelho
    * a linha de conjuge INATIVO - FormBuscaAuxiliar.mAddColuna (3
    * parametros fixos) nao expoe cor condicional por linha. Desvio
    * consciente do PILAR 1, forcado pela API do helper canonico.
    *
    * Nada escolhido no picker (ESC/Cancelar) => o codigo digitado FICA
    * (regras #37/#50) - nao ha ELSE que limpe os campos aqui.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupConjuge(par_cCampoBusca, par_cValor)
        LOCAL loc_oBusca, loc_cValor, loc_cTitulo, loc_oErro
        loc_oBusca  = .NULL.
        loc_cValor  = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), "")
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"

        TRY
            IF THIS.this_oBusinessObject.BuscarPorConjuge(par_cCampoBusca, loc_cValor)
                SELECT cursor_4c_CcjBusca

                IF !EMPTY(loc_cValor)
                    LOCATE FOR UPPER(ALLTRIM(NVL(EVALUATE("cursor_4c_CcjBusca." + par_cCampoBusca), ""))) == UPPER(loc_cValor)
                ELSE
                    *-- Atalho F4/F5 com campo vazio: nunca ha match exato
                    *-- de valor vazio - vai direto ao picker com o universo
                    *-- inteiro.
                    LOCATE FOR .F.
                ENDIF

                IF FOUND()
                    THIS.AplicarConjugeSelecionado()
                ELSE
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_CcjBusca"
                        loc_oBusca.this_cTitulo         = loc_cTitulo

                        IF PEMSTATUS(loc_oBusca, "cnt_4c_Cabecalho", 5)
                            loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                            loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                        ENDIF

                        IF par_cCampoBusca == "RgConjuges"
                            loc_oBusca.mAddColuna("RgConjuges", "", "RG")
                            loc_oBusca.mAddColuna("Conjuges",   "", "Nome")
                        ELSE
                            loc_oBusca.mAddColuna("Conjuges",   "", "Nome")
                            loc_oBusca.mAddColuna("RgConjuges", "", "RG")
                        ENDIF
                        loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                        loc_oBusca.Show()

                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CcjBusca")
                            SELECT cursor_4c_CcjBusca
                            THIS.AplicarConjugeSelecionado()
                        ENDIF

                        loc_oBusca.Release()
                        loc_oBusca = .NULL.
                    ENDIF
                ENDIF
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel pesquisar a conta pelo " + ;
                    "c" + CHR(244) + "njuge." + CHR(13) + ;
                    THIS.this_oBusinessObject.ObterMensagemErro(), ;
                    "Procura de Contas por C" + CHR(244) + "njuge")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpCcj.AbrirLookupConjuge")
        ENDTRY

        IF USED("cursor_4c_CcjBusca")
            USE IN cursor_4c_CcjBusca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarConjugeSelecionado - Copia o registro corrente de
    * cursor_4c_CcjBusca para o BO (THIS.this_oBusinessObject.CarregarDoCursor,
    * que mapeia RgConjuges/Conjuges/IClis/Cpfs/RClis/Inativas - Fase 1/2)
    * e deste para as caixas de texto via BOParaForm() - equivalente a
    * ThisForm.getConjuges.Value/getRgConjuges.Value = crListaRemota.* e
    * ao "If Not Empty(crListaRemota.IClis)" + CursorQuery do legado, que
    * aqui fica dispensado porque a mesma consulta ja trouxe as tres
    * colunas da Conta Principal. O PEMSTATUS dentro de BOParaForm continua
    * como guarda defensiva (sempre verdadeira apos a Fase 5).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarConjugeSelecionado()
        IF !USED("cursor_4c_CcjBusca")
            RETURN
        ENDIF

        THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_CcjBusca")
        THIS.BOParaForm()
        THIS.AtualizarEstadoCampoConjuge()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia as 5 properties de SigOpCcjBO (preenchidas por
    * CarregarDoCursor em AplicarConjugeSelecionado) para as caixas de
    * texto correspondentes. IClis/Cpfs/RClis so sao copiados quando o BO
    * tem conta encontrada (this_cIClis preenchido) - equivalente ao
    * "If Not Empty(crListaRemota.IClis)" do Valid legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        *-- this_cRgs (coluna Rgs = RG do TITULAR), NAO this_cRgConjuges:
        *--     ThisForm.getRgConjuges.Value = crListaRemota.Rgs
        *-- eh o que os DOIS Valid do legado fazem. A busca usa RgConjuges,
        *-- a EXIBICAO usa Rgs. Transcrito, nao reescrito (regra #17) - ver
        *-- o comentario das properties em SigOpCcjBO.prg antes de mexer.
        THIS.txt_4c_RgConjuges.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cRgs, ""))
        THIS.txt_4c_Conjuges.Value   = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cConjuges, ""))
        THIS.txt_4c_RgConjuges.Refresh()
        THIS.txt_4c_Conjuges.Refresh()

        IF !EMPTY(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cIClis, ""))) AND PEMSTATUS(THIS, "txt_4c_IClis", 5)
            THIS.txt_4c_IClis.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cIClis, ""))
            THIS.txt_4c_Cpfs.Value  = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCpfs, ""))
            THIS.txt_4c_RClis.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cRClis, ""))
            THIS.txt_4c_IClis.Refresh()
            THIS.txt_4c_Cpfs.Refresh()
            THIS.txt_4c_RClis.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia as caixas de texto atuais para as 5 properties do
    * BO, chamado no inicio de BtnConfirmarClick antes de copiar para o
    * form chamador. Para Conjuges/RgConjuges (editaveis) captura o que o
    * usuario digitou; para IClis/Cpfs/RClis (somente leitura) captura o
    * que BOParaForm ja havia colocado em tela - mantem o BO como fonte
    * unica no momento da confirmacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_cConjuges   = ALLTRIM(NVL(THIS.txt_4c_Conjuges.Value, ""))
        *-- A caixa de R.G. alimenta as DUAS properties, e de proposito:
        *-- this_cRgConjuges porque o valor DIGITADO eh a chave de busca
        *-- (RgConjuges), e this_cRgs porque o valor EXIBIDO veio de Rgs -
        *-- sem a segunda, um BOParaForm logo depois apagaria a caixa.
        THIS.this_oBusinessObject.this_cRgConjuges = ALLTRIM(NVL(THIS.txt_4c_RgConjuges.Value, ""))
        THIS.this_oBusinessObject.this_cRgs        = ALLTRIM(NVL(THIS.txt_4c_RgConjuges.Value, ""))
        THIS.this_oBusinessObject.this_cIClis      = ALLTRIM(NVL(THIS.txt_4c_IClis.Value, ""))
        THIS.this_oBusinessObject.this_cCpfs       = ALLTRIM(NVL(THIS.txt_4c_Cpfs.Value, ""))
        THIS.this_oBusinessObject.this_cRClis      = ALLTRIM(NVL(THIS.txt_4c_RClis.Value, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparBlocoConjugeEConta - Equivalente ao ramo Else do Valid legado
    * (This.Value vazio): limpa os dois campos do bloco Conjuge e os tres da
    * Conta Principal (criados em ConfigurarBlocoConta), e tambem as 5
    * properties do BO - sem isso, um Confirmar acidental depois de limpar
    * os campos na tela ainda levaria o residuo da busca anterior para o
    * form chamador caso FormParaBO nao rodasse antes (defesa em
    * profundidade; FormParaBO ja cobre o caso normal).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparBlocoConjugeEConta()
        THIS.txt_4c_RgConjuges.Value = ""
        THIS.txt_4c_Conjuges.Value   = ""
        THIS.txt_4c_RgConjuges.Refresh()
        THIS.txt_4c_Conjuges.Refresh()

        IF PEMSTATUS(THIS, "txt_4c_IClis", 5)
            THIS.txt_4c_IClis.Value = ""
            THIS.txt_4c_Cpfs.Value  = ""
            THIS.txt_4c_RClis.Value = ""
            THIS.txt_4c_IClis.Refresh()
            THIS.txt_4c_Cpfs.Refresh()
            THIS.txt_4c_RClis.Refresh()
        ENDIF

        THIS.this_oBusinessObject.this_cConjuges   = ""
        THIS.this_oBusinessObject.this_cRgConjuges = ""
        THIS.this_oBusinessObject.this_cRgs        = ""
        THIS.this_oBusinessObject.this_cIClis      = ""
        THIS.this_oBusinessObject.this_cCpfs       = ""
        THIS.this_oBusinessObject.this_cRClis      = ""

        THIS.AtualizarEstadoCampoConjuge()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * (AddObject cria com Visible=.F. por padrao). Itera Controls e, se algum
    * for PageFrame, tambem as Pages dele (este form nao tem PageFrame, mas o
    * metodo fica generico para reaproveitar nas fases seguintes).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

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
        ENDFOR
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCcjBO.prg):
*====================================================================
* SigOpCcjBO.prg
*
* Business Object para Procura de Contas por Conjuge
* Tabela pesquisada: SigCdCli (busca por RgConjuges/Conjuges)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpCcjBO AS BusinessBase

	*-- Propriedades do dialogo (campos de busca pelo conjuge)
	this_cConjuges   = ""   && Conjuges   char(40) - Nome do conjuge digitado/encontrado
	this_cRgConjuges = ""   && RgConjuges char(13) - RG do conjuge: CHAVE DE BUSCA

	*-- ATENCAO - NAO "corrigir" para RgConjuges sem decisao de negocio.
	*-- O legado BUSCA por SigCdCli.RgConjuges mas, ao exibir o resultado,
	*-- preenche a caixa de R.G. da tela com SigCdCli.Rgs (o RG do TITULAR
	*-- da conta), nao com RgConjuges:
	*--     ThisForm.getRgConjuges.Value = crListaRemota.Rgs
	*-- (getRgConjuges.Valid e getConjuges.Valid, identicos nos dois).
	*-- crListaRemota TEM a coluna porque o fwBuscaExt consulta com
	*-- "select *" quando o chamador nao passa lcFields (12o parametro), e
	*-- o SCX passa apenas 7 - conferido no Init do fwbuscaext.
	*-- Parece descuido do legado (busca um campo e mostra outro), mas eh o
	*-- comportamento que o usuario ve hoje: o PILAR 1 e a regra #17
	*-- mandam TRANSCREVER, nunca reescrever formula/mapeamento.
	this_cRgs = ""   && Rgs char(20) - RG do TITULAR, o que vai para a TELA

	*-- Propriedades da conta encontrada (SigCdCli.IClis/Cpfs/RClis)
	this_cIClis = ""   && IClis char - Codigo da conta encontrada
	this_cCpfs  = ""   && Cpfs  char - CPF da conta encontrada
	this_cRClis = ""   && RClis char - Nome/Razao da conta encontrada

	*-- Propriedade auxiliar do resultado da busca (lista remota)
	this_lInativas = .F.   && Inativas bit - Indica se a conta do conjuge esta inativa

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdCli"
		THIS.this_cCampoChave = "IClis"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cIClis)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia as colunas da conta encontrada (SigCdCli)
	* para as propriedades do BO. Alimentado pelo cursor que o
	* FormBuscaAuxiliar deixa populado apos o usuario selecionar a
	* conta na grade (lookup por RgConjuges ou por Conjuges).
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cIClis       = TratarNulo(IClis, "C")
			THIS.this_cRClis       = TratarNulo(RClis, "C")
			THIS.this_cCpfs        = TratarNulo(Cpfs, "C")
			THIS.this_cConjuges    = TratarNulo(Conjuges, "C")
			THIS.this_cRgConjuges  = TratarNulo(RgConjuges, "C")
			*-- Rgs (RG do TITULAR) eh o que o legado joga na caixa de R.G.
			*-- da tela - ver o comentario das properties la em cima.
			THIS.this_cRgs         = TratarNulo(Rgs, "C")
			IF VARTYPE(Inativas) = "L"
			    THIS.this_lInativas = Inativas
			ELSE
			    THIS.this_lInativas = (NVL(Inativas, 0) = 1)
			ENDIF
			RETURN .T.
		ENDIF
		RETURN .F.
	ENDPROC

	*====================================================================
	* BuscarPorConjuge - Equivalente ao CreateObject('fwBuscaExt', ...,
	* 'SigCdCli', 'crListaRemota', par_cCampo, par_cValor, 'Selecao', 200)
	* do Valid legado (getRgConjuges.Valid e getConjuges.Valid, ambos
	* identicos exceto pelo campo de busca). Popula cursor_4c_CcjBusca com
	* TODAS as colunas que o bloco Conjuge e o bloco Conta precisam
	* (RgConjuges/Conjuges/IClis/Cpfs/RClis/Inativas) numa UNICA consulta -
	* o legado faz Isso em DUAS (fwBuscaExt + CursorQuery('SigCdCli',
	* 'LocalCli', 'IClis', ..., 'IClis, Cpfs, RClis')), mas como as duas
	* leem a MESMA linha de SigCdCli, unificar evita round-trip duplicado
	* sem mudar o resultado.
	*
	* par_cCampo: "RgConjuges" ou "Conjuges" (nome de coluna fixo, nunca
	* valor digitado pelo usuario - concatenado direto, sem EscaparSQL).
	* par_cValor vazio busca o universo INTEIRO (sem WHERE), usado pelo
	* atalho F4 do form quando o campo ainda nao tem nada digitado.
	*====================================================================
	FUNCTION BuscarPorConjuge(par_cCampo, par_cValor)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_CcjBusca")
				USE IN cursor_4c_CcjBusca
			ENDIF

			*-- Rgs entra na lista porque eh ELE que vai para a caixa de R.G.
			*-- da tela (o legado le crListaRemota.Rgs; o fwBuscaExt trazia
			*-- a coluna de graca, via "select *"). Sem ela, CarregarDoCursor
			*-- estouraria "Variable RGS is not found" em runtime.
			loc_cSQL = "SELECT RgConjuges, Rgs, Conjuges, IClis, Cpfs, RClis, Inativas" + ;
				" FROM SigCdCli"

			IF !EMPTY(ALLTRIM(NVL(par_cValor, "")))
				loc_cSQL = loc_cSQL + " WHERE " + par_cCampo + " LIKE " + ;
					EscaparSQL(ALLTRIM(par_cValor) + "%")
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY " + par_cCampo

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CcjBusca")
			loc_lSucesso = (loc_nResultado >= 0 AND USED("cursor_4c_CcjBusca"))

			IF !loc_lSucesso
				THIS.this_cMensagemErro = CapturarErroSQL()
			ENDIF
		CATCH TO loc_oErro
			loc_lSucesso = .F.
			THIS.this_cMensagemErro = loc_oErro.Message
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* SigOpCcj eh um dialogo de PROCURA (Procura de Contas por Conjuge),
	* chamado por outro formulario para devolver IClis/Cpfs/RClis de uma
	* conta ja existente. O legado (SIGOPCCJ) nao grava, altera nem
	* exclui nada em SigCdCli - btnconfirmar.Click apenas copia os
	* valores encontrados para os campos do formulario chamador. Por
	* isso o comportamento padrao herdado de BusinessBase (recusar
	* Inserir/Atualizar/ExecutarExclusao) ja eh o correto para este BO.
	*====================================================================

ENDDEFINE

