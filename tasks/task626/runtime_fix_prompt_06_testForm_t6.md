# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 6/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-10-07 21:17:53] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-07 21:17:53] [INFO] Config FPW: (nao fornecido)
[2026-10-07 21:17:54] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-07 21:17:54] [INFO] Timeout: 300 segundos
[2026-10-07 21:17:54] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_l20kij0i.prg
[2026-10-07 21:17:54] [INFO] Conteudo do wrapper:
[2026-10-07 21:17:54] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGPRIFF', 'C:\4c\tasks\task626\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRIFF', 'C:\4c\tasks\task626\logs\06_testForm.log'
QUIT

[2026-10-07 21:17:54] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_l20kij0i.prg
[2026-10-07 21:17:54] [INFO] VFP output esperado em: C:\4c\tasks\task626\vfp_output.txt
[2026-10-07 21:17:55] [INFO] Executando Visual FoxPro 9...
[2026-10-07 21:17:55] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_l20kij0i.prg
[2026-10-07 21:17:55] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_l20kij0i.prg
[2026-10-07 21:17:55] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGPRIFF
Inicio: 07/10/2026 21:17:55

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 07/10/2026 21:21:53
Duracao: 238 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-07 21:21:53] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-07 21:21:54] [INFO] VFP9 finalizado em 239.0698064 segundos
[2026-10-07 21:21:54] [INFO] Exit Code: 
[2026-10-07 21:21:54] [INFO] 
[2026-10-07 21:21:54] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-07 21:21:54] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_l20kij0i.prg
[2026-10-07 21:21:54] [INFO] 
[2026-10-07 21:21:54] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-07 21:21:55] [INFO] * Auto-generated wrapper for parameters
[2026-10-07 21:21:55] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-07 21:21:55] [INFO] * Parameters: 'FormSIGPRIFF', 'C:\4c\tasks\task626\logs\06_testForm.log'
[2026-10-07 21:21:55] [INFO] 
[2026-10-07 21:21:55] [INFO] * Anti-dialog protections for unattended execution
[2026-10-07 21:21:55] [INFO] SET SAFETY OFF
[2026-10-07 21:21:55] [INFO] SET RESOURCE OFF
[2026-10-07 21:21:55] [INFO] SET TALK OFF
[2026-10-07 21:21:55] [INFO] SET NOTIFY OFF
[2026-10-07 21:21:55] [INFO] SYS(2335, 0)
[2026-10-07 21:21:55] [INFO] 
[2026-10-07 21:21:56] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRIFF', 'C:\4c\tasks\task626\logs\06_testForm.log'
[2026-10-07 21:21:56] [INFO] QUIT
[2026-10-07 21:21:56] [INFO] 
[2026-10-07 21:21:56] [INFO] === Fim do Wrapper.prg ===
[2026-10-07 21:21:56] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRIFF.prg):
*==============================================================================
* FormSIGPRIFF.prg
*
* Form OPERACIONAL - dialogo generico de entrada de dados (equivalente a um
* InputBox) do fluxo da impressora fiscal / TEF.
*
* Legado: SIGPRIFF.SCX (objeto "form1") - WindowType=1 (modal), Width=409,
*   Height=50, SEM PageFrame e SEM Container algum: Text1 e Combo1 penduram
*   direto na Form (Parent: form1). Layout FLAT SEM CONTAINER.
*
*   PARAMETERS do Init legado:
*       pcCab, pcTipo, pcTitulo, pcMaximo, pcMinimo, pcDado
*   Chamador (sigprtef.PRG linha 181):
*       DO FORM SIGPRIFF WITH Escolhas, lptipo, lcTitulo, TamanhoMinimo, ;
*                             TamanhoMaximo, TipoDados TO Valores
*
* FASE 4/8: adicionados os controles reais do dialogo - txt_4c_Resposta
*   (Text1) e cbo_4c_Opcoes (Combo1), direto em THIS (SEM PageFrame/Container,
*   fiel ao legado: form1 nao tem Page nenhuma). Este form NAO tem Grid, NAO
*   tem Page1/Page2 e NAO tem botoes CRUD - o SCX original (form1) e o
*   comportamento.json confirmam arvore de 4 objetos (dataenvironment, form1,
*   Text1, Combo1), zero commandbutton/commandgroup, zero SQL. O template
*   generico de Fase 4 ("Grid e Botoes CRUD") NAO se aplica a este legado -
*   inventar Grid/Page/botoes aqui violaria o PILAR 1 (fidelidade de UX) e a
*   regra de nunca fabricar interface que o legado nao tem.
*   KeyPress/ESC/Enter entram nas Fases 7-8.
*
* FASE 5/8: o legado NAO tem Page2 de Dados nem campo algum fora dos dois
*   controles que a Fase 4 ja entregou (o dump tem 4 objetos no total), entao
*   "metade dos campos da Page2" aqui eh ZERO - inventar campo/Page/Container
*   violaria o PILAR 1, e metodo vazio eh stub disfarcado. O trabalho REAL
*   desta fase foi AUDITAR, propriedade por propriedade, o que a Fase 4
*   transcreveu do dump, medindo cada ponto no VFP9 (2026-10-07):
*     - cbo_4c_Opcoes.RowSource apontava para "THIS.this_aOpcoesExibir":
*       array que eh property do FORM resolve por THISFORM, nunca por THIS.
*       Medido: "Property THIS_AOPCOESEXIBIR is not found" ainda no Init -
*       o form NAO ABRIA em modo algum. Corrigido para THISFORM.
*     - combo de RowSourceType=5 nao reage ao DIMENSION do array: medido
*       ListCount = 1 (so a 1a opcao no dropdown) e = 3 so apos Requery().
*       Acrescentado o Requery() depois de popular as opcoes.
*     - array declarado por DIMENSION no DEFINE CLASS nasce com elemento
*       LOGICO: medido List(1) = ".F." no dropdown. Zerado para "".
*     - txt_4c_Resposta.Value = "" explicito (dump: "Value = " vazio).
*     - Form.WindowState = 0 transcrito do dump.
*   O dump NAO declara TabIndex em Text1/Combo1 - nao ha TabIndex a
*   transcrever, e inventar ordem de tabulacao seria desvio do legado.
*
* FASE 6/8: "campos restantes e lookups". O legado NAO TEM LOOKUP ALGUM - o
*   dump inteiro (4 objetos) nao casa fwBuscaExt/fwBuscaSel/fwBuscaInt,
*   mAddColuna, sigacess() nem Acesso*(): inventar um picker aqui violaria o
*   PILAR 1 e a regra "NUNCA inventar tabelas de lookup que nao existem no
*   original". E nao sobrou campo a acrescentar (Text1/Combo1 saem na Fase 4).
*   O que de fato FALTAVA aos dois campos era o COMPORTAMENTO DELES: o legado
*   nao tem botao nenhum (zero commandbutton/commandgroup no dump), entao a
*   captura da resposta mora no KeyPress de CADA campo -
*       Text1.KeyPress : IF nKeyCode = 13 / Resposta = ThisForm.Text1.Value
*       Combo1.KeyPress: IF nKeyCode = 13 / Resposta = SUBSTR(Combo1.Value,1,1)
*   Entregues aqui como TxtRespostaKeyPress/CboOpcoesKeyPress ligados por
*   BINDEVENT (AddObject nao aceita codigo de evento) e PUBLIC (regra #3).
*   Sem eles os campos existiam e NAO respondiam: o dialogo so podia ser
*   fechado pela barra de titulo e o chamador recebia sempre vazio
*   ("Operacao Cancelada pelo Usuario"), sem erro nenhum na tela.
*
*   Contrato de TIPO da resposta (ValidarRespostaDigitada), transcrito do UNICO
*   chamador do acervo - C:\4install\FortyusMC\Fortyus\sigprtef.PRG:181-199:
*       DO FORM SIGPRIFF WITH Escolhas, lptipo, lcTitulo, TamanhoMinimo, ;
*                              TamanhoMaximo, TipoDados TO Valores
*       IF EMPTY(valores) .or. ISNULL(valores)     -> cancelamento
*       TipoCampo 504/506/515 ou "DDMMAAAA"$Buffer -> Valores = DTOC(Valores)
*       TipoCampo 130                              -> TRANSFORM(Valores,"99999999.99")
*       demais                                     -> Buffer = ALLTRIM(Valores)
*   DTOC exige DATE, a picture numerica do TRANSFORM espera NUMERIC e ALLTRIM
*   exige CHARACTER - tipo errado estoura erro 11 NO CHAMADOR (familia da regra
*   #16). O modo "M" PREVALECE sobre pcDado: o Init legado desvia para o Combo1
*   ANTES de olhar pcDado e o Combo1 captura SUBSTR(Value,1,1), sempre
*   CHARACTER - e o chamador chega a mandar ProximoComando = 20 (que forca
*   lptipo = "M") com TipoDados ja preenchido.
*
*   TamanhoMinimo NAO vira validacao: medido no chamador (linhas 40-41 e 69)
*   que ele vem por referencia da DLL do SiTef e o legado so o usa dentro do
*   IIF(pcMaximo<pcMinimo,...) do MaxLength - nunca como piso de digitacao.
*
* FASE 8/8: "eventos auxiliares e consolidacao". O legado NAO TEM botao, grid,
*   Page1/Page2 nem CRUD algum (confirmado nas Fases 4-7) - os itens genericos
*   do template de Fase 8 (BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/
*   BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/LimparCampos/
*   CarregarLista/AjustarBotoesPorModo) NAO se aplicam a este dialogo e nao
*   foram inventados, pela mesma regra que guiou as Fases 4-6 (nao fabricar
*   interface/funcionalidade que o legado nao tem). O que de fato faltava,
*   anotado no cabecalho das Fases 6-7 como ainda nao entregue, era o FLUXO DE SAIDA
*   do dialogo:
*     - form1.KeyPress (IF nKeyCode = 27 / RELEASE WINDOWS): implementado como
*       PROCEDURE KeyPress do FORM (THIS.Hide(), nao THIS.Release() - mesma
*       razao de TxtRespostaKeyPress/CboOpcoesKeyPress: Release() destruiria o
*       objeto antes do chamador conseguir ler a resposta). this_uResposta
*       permanece "" (valor com que THIS.this_oBusinessObject.this_uResposta
*       e inicializado), e o chamador detecta isso como cancelamento, igual ao
*       legado "IF EMPTY(valores) .or. ISNULL(valores)".
*     - Unload -> Return(Resposta): o legado devolve o valor PUBLIC Resposta
*       direto no DO FORM ... TO Valores, mecanismo que CREATEOBJECT/Show()
*       nao reproduz. Substituido por this_uResposta, property do FORM (nao so
*       do BO) espelhada em TxtRespostaKeyPress/CboOpcoesKeyPress logo apos
*       DefinirResposta() - mesmo padrao de acesso direto que FormSIGPRSTF usa
*       (this_cSenhaRetorno/this_lCancelado lidos pelo chamador via
*       loForm.this_uResposta, sem getter). Nenhum menu.prg - este dialogo e
*       sub-rotina de outro codigo (sigprtef.PRG, acervo legado), nunca aberto
*       direto pelo usuario; FormSIGPRSTF (mesma familia de dialogo) tambem nao
*       tem entrada de menu, ao contrario de Formsigprila/FormVca.
*
* Herda de: FormBase
*==============================================================================

DEFINE CLASS FormSIGPRIFF AS FormBase
    this_cMensagemErro = ""
	ShowWindow = 1

    *-- Propriedades visuais (legado: form1 Height=50 Width=409 WindowType=1)
    Height     = 50
    Width      = 409
    AutoCenter = .T.
    Caption    = "Form1"
    KeyPreview = .T.
    WindowType = 1      && Modal
    WindowState = 0     && Legado: form1 WindowState = 0 (janela normal)

    *-- Parametros do dialogo (espelham os PARAMETERS do Init legado),
    *-- guardados ANTES de DODEFAULT() para que InicializarForm() (chamado
    *-- por FormBase.Init() via DODEFAULT) possa configurar o Business
    *-- Object com eles.
    this_cCabecalhoDialogo = ""    && pcCab    - opcoes separadas por ";" (modo "M")
                                   &&            ou texto do rotulo nos demais modos
    this_cTipoDialogo      = ""    && pcTipo   - "M" = multipla escolha (ComboBox)
    this_nMaximoDialogo    = 0     && pcMaximo - tamanho (ordem trocada - ver SIGPRIFFBO.prg)
    this_nMinimoDialogo    = 0     && pcMinimo - tamanho (ordem trocada - ver SIGPRIFFBO.prg)
    this_cDadoDialogo      = ""    && pcDado   - "D" = data, "V" = valor, outro = caractere

    *-- Resultado do dialogo, espelhado do BO (THIS.this_oBusinessObject.
    *-- this_uResposta) para o chamador ler direto em loForm.this_uResposta
    *-- depois do Show() modal voltar - mesmo padrao de acesso direto que
    *-- FormSIGPRSTF usa com this_cSenhaRetorno/this_lCancelado. Equivalente ao
    *-- PUBLIC Resposta do legado, que o Unload devolvia via DO FORM ... TO.
    *-- Vazio = usuario cancelou (ESC ou fechou sem digitar/escolher nada),
    *-- igual ao legado ("IF EMPTY(valores) .or. ISNULL(valores)").
    this_uResposta = ""

    *-- Array usado como RowSource (RowSourceType=5) do cbo_4c_Opcoes -
    *-- legado: PUBLIC laOpcoes[lnRep] dentro do Init do form1. Precisa ser
    *-- property do FORM (nao do BO) porque RowSource resolve o nome como
    *-- expressao no contexto do proprio form.
    DIMENSION this_aOpcoesExibir[1]

    *--------------------------------------------------------------------------
    * Init - Construtor. Recebe os PARAMETERS do form legado e os guarda ANTES
    * de DODEFAULT(), porque FormBase.Init() -> InicializarForm() precisa
    * deles para configurar o Business Object. this_cTituloForm (property de
    * FormBase) recebe par_cTitulo aqui - FormBase.Init() ja aplica em
    * THIS.Caption automaticamente, sem necessidade de repetir a atribuicao.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cCabecalho, par_cTipo, par_cTitulo, par_nMaximo, par_nMinimo, par_cDado)
        THIS.this_cCabecalhoDialogo = IIF(VARTYPE(par_cCabecalho) = "C", par_cCabecalho, "")
        THIS.this_cTipoDialogo      = IIF(VARTYPE(par_cTipo) = "C", par_cTipo, "")
        THIS.this_nMaximoDialogo    = IIF(VARTYPE(par_nMaximo) = "N", par_nMaximo, 0)
        THIS.this_nMinimoDialogo    = IIF(VARTYPE(par_nMinimo) = "N", par_nMinimo, 0)
        THIS.this_cDadoDialogo      = IIF(VARTYPE(par_cDado) = "C", par_cDado, "")
        THIS.this_cTituloForm       = IIF(VARTYPE(par_cTitulo) = "C", par_cTitulo, "")

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado automaticamente por FormBase.Init() via
    * DODEFAULT(). Instancia o SIGPRIFFBO, transfere os parametros do dialogo
    * para ele (espelha o corpo do Init do form1 legado) e configura os
    * controles visuais (txt_4c_Resposta/cbo_4c_Opcoes).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRIFFBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar SIGPRIFFBO", "FormSIGPRIFF.InicializarForm")
            ELSE
                THIS.this_oBusinessObject.ConfigurarParametros( ;
                    THIS.this_cCabecalhoDialogo, ;
                    THIS.this_cTipoDialogo, ;
                    THIS.this_cTituloForm, ;
                    THIS.this_nMaximoDialogo, ;
                    THIS.this_nMinimoDialogo, ;
                    THIS.this_cDadoDialogo)

                THIS.ConfigurarControles()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "FormSIGPRIFF.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarControles - Cria txt_4c_Resposta (Text1) e cbo_4c_Opcoes
    * (Combo1) direto em THIS - legado NAO tem PageFrame/Container algum
    * (form1 eh FLAT, os dois controles sao filhos diretos de form1). Espelha
    * o corpo do Init do form1 legado: um dos dois fica Visible=.F. conforme
    * this_cTipoDialogo, e o Text1 recebe configuracao extra conforme
    * this_cDadoDialogo (data/valor/caractere).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarControles()
        LOCAL loc_nQtd, loc_nI

        *-- Array do RowSource: declarado por DIMENSION no DEFINE CLASS, ele
        *-- nasce com os elementos em LOGICO (medido no VFP9 2026-10-07:
        *-- VARTYPE(elemento) = "L"). Sem zerar para "" o combo exibe um item
        *-- ".F." (medido: ListCount = 1, List(1) = ".F."). No legado o
        *-- laOpcoes so passa a existir no modo "M", dentro do Init.
        DIMENSION THIS.this_aOpcoesExibir[1]
        THIS.this_aOpcoesExibir[1] = ""

        *-- txt_4c_Resposta (legado: Text1 - Alignment=3, SelectOnEntry=.T.)
        THIS.AddObject("txt_4c_Resposta", "TextBox")
        WITH THIS.txt_4c_Resposta
            .Top           = 12
            .Left          = 12
            .Width         = 389
            .Height        = 25
            *-- Dump legado: "Value = " (vazio) = caractere vazio. Explicito
            *-- porque os ramos "D"/"V" mais abaixo TROCAM o tipo do .Value
            *-- (Date / Numeric) e o ramo de caractere depende deste valor base.
            .Value         = ""
            .Alignment     = 3
            .SelectOnEntry = .T.
            .Visible       = .T.
        ENDWITH

        *-- cbo_4c_Opcoes (legado: Combo1 - Style=2 "Dropdown List",
        *-- RowSourceType=5 "Array", RowSource = "laopcoes").
        *-- RowSource de array que eh PROPERTY do form resolve por THISFORM e
        *-- NUNCA por THIS: medido no VFP9 2026-10-07 que
        *-- "THIS.this_aOpcoesExibir" estoura "Property THIS_AOPCOESEXIBIR is
        *-- not found" ainda no Init (THIS resolve contra o proprio ComboBox),
        *-- derrubando a abertura do form INTEIRO; com THISFORM o combo lista
        *-- as opcoes (ListCount = 3 no mesmo ensaio).
        THIS.AddObject("cbo_4c_Opcoes", "ComboBox")
        WITH THIS.cbo_4c_Opcoes
            .Top                = 12
            .Left               = 12
            .Width              = 390
            .Height             = 24
            .Style              = 2
            .BackColor          = RGB(255, 255, 255)
            .DisabledBackColor  = RGB(255, 255, 255)
            .DisabledForeColor  = RGB(0, 0, 0)
            .ReadOnly           = .F.
            .RowSourceType      = 5
            .RowSource          = "THISFORM.this_aOpcoesExibir"
            .Visible            = .T.
        ENDWITH

        IF THIS.this_oBusinessObject.EhMultiplaEscolha()
            *-- Legado: Thisform.text1.Visible = .f. (modo "M")
            loc_nQtd = THIS.this_oBusinessObject.ObterQuantidadeOpcoes()

            IF loc_nQtd > 0
                DIMENSION THIS.this_aOpcoesExibir[loc_nQtd]
                FOR loc_nI = 1 TO loc_nQtd
                    THIS.this_aOpcoesExibir[loc_nI] = THIS.this_oBusinessObject.ObterOpcao(loc_nI)
                ENDFOR
            ELSE
                DIMENSION THIS.this_aOpcoesExibir[1]
                THIS.this_aOpcoesExibir[1] = ""
            ENDIF

            *-- Combo de RowSourceType=5 NAO reage sozinho ao DIMENSION do
            *-- array: medido no VFP9 2026-10-07 que, populando 3 opcoes depois
            *-- de o RowSource estar definido, ListCount fica em 1 (so a 1a
            *-- opcao aparece no dropdown) e so vai para 3 depois do Requery().
            THIS.cbo_4c_Opcoes.Requery()

            THIS.txt_4c_Resposta.Visible = .F.
        ELSE
            *-- Legado: Thisform.combo1.Visible = .f. (demais modos)
            THIS.cbo_4c_Opcoes.Visible = .F.

            DO CASE
            CASE UPPER(ALLTRIM(THIS.this_cDadoDialogo)) == "D"
                *-- Legado: ThisForm.Text1.Value = Ctod('')
                THIS.txt_4c_Resposta.Value = {}
            CASE UPPER(ALLTRIM(THIS.this_cDadoDialogo)) == "V"
                *-- Legado: ThisForm.Text1.InputMask = "999,999.99" / Value = 0
                THIS.txt_4c_Resposta.InputMask = "999,999.99"
                THIS.txt_4c_Resposta.Value     = 0
            OTHERWISE
                *-- Legado: ThisForm.Text1.MaxLength = IIF(pcMaximo<pcMinimo,pcMinimo,pcMaximo)
                THIS.txt_4c_Resposta.MaxLength = THIS.this_oBusinessObject.ObterTamanhoCampo()
            ENDCASE
        ENDIF

        *-- Eventos dos CAMPOS. O legado nao tem botao algum, entao a captura da
        *-- resposta mora no KeyPress de cada campo (Text1.KeyPress e
        *-- Combo1.KeyPress, os dois com "IF nKeyCode = 13"). Ligados aos DOIS
        *-- controles sempre, qualquer que seja o modo: quem decide qual responde eh
        *-- o Visible que o bloco acima ja ajustou.
        BINDEVENT(THIS.txt_4c_Resposta, "KeyPress", THIS, "TxtRespostaKeyPress")
        BINDEVENT(THIS.cbo_4c_Opcoes,   "KeyPress", THIS, "CboOpcoesKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarRespostaDigitada - Contrato de TIPO da resposta, do jeito que o
    * CHAMADOR do dialogo o aplica (sigprtef.PRG:189-198 - ver cabecalho deste
    * arquivo). Predicado puro: NAO exibe mensagem e NAO bloqueia nada, porque
    * o legado captura o que estiver no controle e fecha - inclusive VAZIO, que
    * o chamador trata como cancelamento ("IF EMPTY(valores) .or.
    * ISNULL(valores)"). Serve para o handler de captura decidir o que GRAVAR
    * em this_uResposta, de modo a nunca entregar ao chamador um valor de tipo
    * que ele nao sabe formatar.
    *
    * Tipo exigido por modo:
    *     modo "M" (ComboBox) -> "C"  (SUBSTR(Value,1,1): sempre 1 caractere -
    *                                  PREVALECE sobre pcDado, como no Init legado)
    *     pcDado = "D"        -> "D"  (chamador faz DTOC)
    *     pcDado = "V"        -> "N"  (chamador faz TRANSFORM com picture numerica)
    *     demais              -> "C"  (chamador faz ALLTRIM)
    *
    * PUBLIC: chamado pelos handlers ligados por BINDEVENT e pelo fluxo de
    * saida que a Fase 8 acrescenta.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarRespostaDigitada(par_uValor)
        LOCAL loc_cTipoEsperado, loc_lMultipla, loc_cDado

        IF ISNULL(par_uValor)
            RETURN .F.
        ENDIF

        *-- Fonte do modo: o BO (mesma regra do EhMultiplaEscolha). Sem BO
        *-- instanciado, cai na propria property do form, que eh a origem do
        *-- valor que o BO recebeu em ConfigurarParametros.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lMultipla = THIS.this_oBusinessObject.EhMultiplaEscolha()
        ELSE
            loc_lMultipla = (UPPER(ALLTRIM(THIS.this_cTipoDialogo)) == "M")
        ENDIF

        loc_cDado = UPPER(ALLTRIM(THIS.this_cDadoDialogo))

        DO CASE
        CASE loc_lMultipla
            loc_cTipoEsperado = "C"
        CASE loc_cDado == "D"
            loc_cTipoEsperado = "D"
        CASE loc_cDado == "V"
            loc_cTipoEsperado = "N"
        OTHERWISE
            loc_cTipoEsperado = "C"
        ENDCASE

        RETURN (VARTYPE(par_uValor) == loc_cTipoEsperado)
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtRespostaKeyPress - Legado: form1.Text1.KeyPress
    *     IF nKeyCode = 13 / Resposta = ThisForm.Text1.Value / RELEASE WINDOWS
    * O RELEASE WINDOWS do legado vira THIS.Hide(): o form eh modal
    * (WindowType = 1), entao o Show() do chamador fica bloqueado ate aqui e o
    * Hide() devolve o controle a ele com o objeto VIVO, para que a resposta
    * ainda possa ser lida (mesmo padrao do FormSIGPRSTF). Release() destruiria
    * o objeto antes da leitura.
    * PUBLIC por ser alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE TxtRespostaKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        LOCAL loc_uValor, loc_cDado

        IF par_nKeyCode != 13
            RETURN
        ENDIF

        loc_uValor = THIS.txt_4c_Resposta.Value
        loc_cDado  = UPPER(ALLTRIM(THIS.this_cDadoDialogo))

        *-- Caminho do legado: guarda o .Value COMO ESTA, preservando o tipo
        *-- (o chamador conta com Date em "D" e Numeric em "V"). Os demais CASE
        *-- sao defensivos de FRONTEIRA - nao dispararam em nenhum dos 5 modos
        *-- medidos, e existem para que um .Value fora do contrato nunca chegue
        *-- ao DTOC/TRANSFORM/ALLTRIM do chamador como erro 11.
        DO CASE
        CASE THIS.ValidarRespostaDigitada(loc_uValor)
            *-- contrato satisfeito - nada a converter
        CASE loc_cDado == "D"
            loc_uValor = ConverterParaData(loc_uValor)
        CASE loc_cDado == "V"
            loc_uValor = IIF(VARTYPE(loc_uValor) = "C", VAL(loc_uValor), 0)
        OTHERWISE
            loc_uValor = TRANSFORM(loc_uValor)
        ENDCASE

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.DefinirResposta(loc_uValor)
        ENDIF

        *-- Espelha no FORM (equivalente ao PUBLIC Resposta do legado) - ver
        *-- comentario de this_uResposta no cabecalho da classe.
        THIS.this_uResposta = loc_uValor

        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * CboOpcoesKeyPress - Legado: form1.Combo1.KeyPress
    *     IF nKeyCode = 13 / Resposta = SUBSTR(ThisForm.Combo1.Value,1,1) /
    *     RELEASE WINDOWS
    * O SUBSTR(...,1,1) eh REGRA, nao detalhe: o chamador monta as opcoes como
    * "<codigo>:<texto>;" (sigprtef.PRG:175 - Escolhas = "0:Sim;1:Nao;"), logo a
    * resposta eh o CODIGO, isto eh o 1o caractere do item escolhido. Nada
    * escolhido -> Value vazio -> SUBSTR("",1,1) = "" -> o chamador le como
    * cancelamento, igual ao legado.
    * PUBLIC por ser alvo de BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CboOpcoesKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        LOCAL loc_uSelecionado, loc_cResposta

        IF par_nKeyCode != 13
            RETURN
        ENDIF

        loc_uSelecionado = THIS.cbo_4c_Opcoes.Value

        *-- ComboBox de RowSourceType = 5 sobre array de caracteres devolve
        *-- CHARACTER; o TRANSFORM cobre o caso de o array trazer outro tipo,
        *-- para o SUBSTR nunca estourar erro 11.
        IF VARTYPE(loc_uSelecionado) != "C"
            loc_uSelecionado = TRANSFORM(loc_uSelecionado)
        ENDIF

        loc_cResposta = SUBSTR(loc_uSelecionado, 1, 1)

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.DefinirResposta(loc_cResposta)
        ENDIF

        *-- Espelha no FORM (equivalente ao PUBLIC Resposta do legado) - ver
        *-- comentario de this_uResposta no cabecalho da classe.
        THIS.this_uResposta = loc_cResposta

        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPress - Legado: form1.KeyPress
    *     IF nkeycode = 27 / RELEASE WINDOWS / Endif
    * KeyPreview = .T. (propriedade copiada do legado) garante que o FORM
    * recebe o KeyPress antes de txt_4c_Resposta/cbo_4c_Opcoes. THIS.Hide() no
    * lugar de THIS.Release() - mesma razao de TxtRespostaKeyPress/
    * CboOpcoesKeyPress: Release() destruiria o objeto antes do chamador
    * conseguir ler this_uResposta, que permanece "" (cancelamento, igual ao
    * legado) porque nenhum dos dois handlers de captura rodou.
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27
            THIS.Hide()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Destrutor. DODEFAULT() OBRIGATORIO como ultima linha (FormBase
    * restaura o menu principal apos qualquer form modal fechar).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRIFFBO.prg):
*==============================================================================
* SIGPRIFFBO.prg
*
* Business Object para FormSIGPRIFF - dialogo generico de entrada de dados
* (equivalente a um InputBox) do fluxo da impressora fiscal / TEF.
*
* Legado: SIGPRIFF.SCX (objeto "form1") - dialogo utilitario SEM tabela.
*   PARAMETERS do Init legado:
*       pcCab, pcTipo, pcTitulo, pcMaximo, pcMinimo, pcDado
*
*   Chamador (sigprtef.PRG linha 181):
*       DO FORM SIGPRIFF WITH Escolhas, lptipo, lcTitulo, TamanhoMinimo, ;
*                             TamanhoMaximo, TipoDados TO Valores
*
*   ATENCAO - o chamador passa Minimo/Maximo em ordem TROCADA em relacao aos
*   PARAMETERS do form. Isso NAO eh defeito a corrigir: o legado resolve com
*   MaxLength = IIF(pcMaximo < pcMinimo, pcMinimo, pcMaximo), ou seja, usa o
*   MAIOR dos dois, o que torna a ordem irrelevante. Transcrever a expressao
*   como esta - nunca "arrumar" a ordem dos parametros.
*
*   O retorno (PUBLIC Resposta do legado) tem TIPO VARIAVEL e o chamador conta
*   com isso: DTOC(Valores) quando pcDado = "D" e TRANSFORM(Valores,
*   "99999999.99") quando pcDado = "V". Por isso a resposta eh guardada em
*   this_uResposta (variante) e NAO pode ser convertida para texto.
*
* Herda de: BusinessBase
* Tabela:   nenhuma - dialogo utilitario, sem persistencia em banco
*==============================================================================

DEFINE CLASS SIGPRIFFBO AS BusinessBase

    *-- Parametros do dialogo (espelham os PARAMETERS do Init legado) ---------
    this_cCabecalho = ""    && pcCab    - lista de opcoes separadas por ";" (modo "M")
                            &&            ou texto do rotulo nos demais modos
    this_cTipo      = ""    && pcTipo   - "M" = multipla escolha (ComboBox);
                            &&            qualquer outro valor = entrada livre (TextBox)
    this_cTitulo    = ""    && pcTitulo - Caption do form
    this_nMaximo    = 0     && pcMaximo - tamanho (ver nota sobre ordem trocada acima)
    this_nMinimo    = 0     && pcMinimo - tamanho (ver nota sobre ordem trocada acima)
    this_cDado      = ""    && pcDado   - "D" = data, "V" = valor numerico,
                            &&            vazio/outro = caractere

    *-- Resultado do dialogo -------------------------------------------------
    this_uResposta  = ""    && Resposta (PUBLIC no legado) - TIPO VARIA conforme
                            && this_cDado: D = Date, V = Numeric, outro = Character.
                            && Legado inicializa com "" (vazio = usuario cancelou,
                            && que o chamador detecta com EMPTY(Valores))

    *-- Opcoes do modo "M" (legado: PUBLIC laOpcoes[lnRep], RowSource do Combo1) 
    DIMENSION this_aOpcoes[1]
    this_nQtdOpcoes = 0     && lnRep - quantidade de opcoes extraidas de this_cCabecalho

    *--------------------------------------------------------------------------
    * Init - Construtor
    * Dialogo utilitario: this_cTabela e this_cCampoChave ficam vazios, de modo
    * que BusinessBase nao instancia DataAccess (o comportamento herdado ja eh
    * o correto para uma tela sem banco).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            *-- Estado inicial dos parametros do dialogo
            THIS.this_cCabecalho = ""
            THIS.this_cTipo      = ""
            THIS.this_cTitulo    = ""
            THIS.this_nMaximo    = 0
            THIS.this_nMinimo    = 0
            THIS.this_cDado      = ""

            *-- Legado: Resposta = "" no fim do Init do form
            THIS.this_uResposta = ""

            *-- Lista de opcoes vazia ate ConfigurarDialogo receber this_cCabecalho
            DIMENSION THIS.this_aOpcoes[1]
            THIS.this_aOpcoes[1] = ""
            THIS.this_nQtdOpcoes = 0

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SIGPRIFFBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FASE 2 - Metodos CRUD (CarregarDoCursor / Inserir / Atualizar)
    *
    * Dialogo utilitario (equivalente a um InputBox) SEM tabela: this_cTabela
    * e this_cCampoChave ficam vazios desde o Init acima, o legado nunca faz
    * SQLEXEC/AddCursor/TableUpdate (comportamento.json confirma 0 queries) e
    * o unico dado que existe eh this_uResposta, devolvido direto ao chamador
    * via RETURN(Resposta) - nunca grava em SQL Server.
    *
    * CarregarDoCursor(), Inserir() e Atualizar() continuam herdados de
    * BusinessBase: o comportamento padrao (recusar a operacao, pois nunca ha
    * THIS.this_oDataAccess instanciado) ja eh o correto aqui, porque este BO
    * nunca chama Salvar()/Excluir() - quem usa o dialogo le THIS.this_uResposta
    * direto, no padrao Text1/Combo1.KeyPress do legado. ObterChavePrimaria()
    * e RegistrarAuditoria() seguem a mesma logica: nao ha chave primaria nem
    * tabela para auditar. Os metodos abaixo cobrem a logica REAL do dialogo -
    * a mesma que o Init do legado executava (parse das opcoes de "M" e
    * guarda/leitura da resposta).
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * ConfigurarParametros - Recebe os PARAMETERS do form legado e prepara o
    * estado do dialogo (espelha o corpo do Init de SIGPRIFF.SCX).
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarParametros(par_cCabecalho, par_cTipo, par_cTitulo, ;
            par_nMaximo, par_nMinimo, par_cDado)

        LOCAL loc_nRep, loc_nA, loc_nInicio, loc_nFim

        THIS.this_cCabecalho = IIF(VARTYPE(par_cCabecalho) = "C", par_cCabecalho, "")
        THIS.this_cTipo      = IIF(VARTYPE(par_cTipo) = "C", par_cTipo, "")
        THIS.this_cTitulo    = IIF(VARTYPE(par_cTitulo) = "C", par_cTitulo, "")
        THIS.this_nMaximo    = IIF(VARTYPE(par_nMaximo) = "N", par_nMaximo, 0)
        THIS.this_nMinimo    = IIF(VARTYPE(par_nMinimo) = "N", par_nMinimo, 0)
        THIS.this_cDado      = IIF(VARTYPE(par_cDado) = "C", par_cDado, "")

        *-- Legado: PUBLIC Resposta = "" ate o usuario digitar/escolher
        THIS.this_uResposta = ""

        IF UPPER(ALLTRIM(THIS.this_cTipo)) == "M"
            *-- Legado: lnRep=Occurs(";",pcCab) / PUBLIC laOpcoes[lnRep] /
            *-- FOR a = 1 TO lnRep / laOpcoes[a] = SUBSTR(pcCab, ...) / NEXT
            loc_nRep = OCCURS(";", THIS.this_cCabecalho)

            IF loc_nRep > 0
                DIMENSION THIS.this_aOpcoes[loc_nRep]

                FOR loc_nA = 1 TO loc_nRep
                    loc_nInicio = IIF(loc_nA = 1, 1, AT(";", THIS.this_cCabecalho, loc_nA - 1) + 1)
                    loc_nFim    = AT(";", THIS.this_cCabecalho, loc_nA) - ;
                                  IIF(loc_nA = 1, 0, AT(";", THIS.this_cCabecalho, loc_nA - 1)) - 1
                    THIS.this_aOpcoes[loc_nA] = SUBSTR(THIS.this_cCabecalho, loc_nInicio, loc_nFim)
                ENDFOR

                THIS.this_nQtdOpcoes = loc_nRep
            ELSE
                *-- Cabecalho sem ";" (uma unica opcao) - nao derruba o dialogo
                DIMENSION THIS.this_aOpcoes[1]
                THIS.this_aOpcoes[1] = THIS.this_cCabecalho
                THIS.this_nQtdOpcoes = IIF(EMPTY(THIS.this_cCabecalho), 0, 1)
            ENDIF
        ELSE
            DIMENSION THIS.this_aOpcoes[1]
            THIS.this_aOpcoes[1] = ""
            THIS.this_nQtdOpcoes = 0
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * EhMultiplaEscolha - .T. quando this_cTipo = "M" (Combo1 em vez de Text1)
    *--------------------------------------------------------------------------
    FUNCTION EhMultiplaEscolha()
        RETURN (UPPER(ALLTRIM(THIS.this_cTipo)) == "M")
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterQuantidadeOpcoes - Numero de opcoes extraidas de this_cCabecalho
    *--------------------------------------------------------------------------
    FUNCTION ObterQuantidadeOpcoes()
        RETURN THIS.this_nQtdOpcoes
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterOpcao - Devolve a opcao de indice par_nIndice (1-based) para
    * popular o RowSource/List do Combo1 do form
    *--------------------------------------------------------------------------
    FUNCTION ObterOpcao(par_nIndice)
        IF VARTYPE(par_nIndice) = "N" AND par_nIndice >= 1 AND par_nIndice <= THIS.this_nQtdOpcoes
            RETURN THIS.this_aOpcoes[par_nIndice]
        ENDIF
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterTamanhoCampo - Legado usa o MAIOR entre pcMaximo/pcMinimo como
    * MaxLength do Text1 (o chamador sigprtef.PRG passa os dois em ordem
    * trocada - ver nota no cabecalho do arquivo - por isso o MAX, nao o 1o)
    *--------------------------------------------------------------------------
    FUNCTION ObterTamanhoCampo()
        RETURN IIF(THIS.this_nMaximo < THIS.this_nMinimo, THIS.this_nMinimo, THIS.this_nMaximo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * DefinirResposta / ObterResposta - guardam e devolvem this_uResposta
    * (equivalente a PUBLIC Resposta do legado, lido pelo chamador via
    * RETURN(Resposta) apos o form ser liberado)
    *--------------------------------------------------------------------------
    PROCEDURE DefinirResposta(par_uResposta)
        THIS.this_uResposta = par_uResposta
    ENDPROC

    FUNCTION ObterResposta()
        RETURN THIS.this_uResposta
    ENDFUNC

ENDDEFINE

