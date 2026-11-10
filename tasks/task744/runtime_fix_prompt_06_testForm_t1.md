# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-11-06 03:36:32] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-06 03:36:32] [INFO] Config FPW: (nao fornecido)
[2026-11-06 03:36:33] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-06 03:36:33] [INFO] Timeout: 300 segundos
[2026-11-06 03:36:33] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qwify3wy.prg
[2026-11-06 03:36:34] [INFO] Conteudo do wrapper:
[2026-11-06 03:36:34] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpGvt', 'C:\4c\tasks\task744\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpGvt', 'C:\4c\tasks\task744\logs\06_testForm.log'
QUIT

[2026-11-06 03:36:34] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qwify3wy.prg
[2026-11-06 03:36:35] [INFO] VFP output esperado em: C:\4c\tasks\task744\vfp_output.txt
[2026-11-06 03:36:35] [INFO] Executando Visual FoxPro 9...
[2026-11-06 03:36:35] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qwify3wy.prg
[2026-11-06 03:36:35] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qwify3wy.prg
[2026-11-06 03:36:35] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpGvt
Inicio: 06/11/2026 03:36:36

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
OK - Objeto criado com sucesso
     Tipo: O
     Classe: Formsigopgvt

[ETAPA 3] Mostrando formulario (nao-modal)...
ERRO - Excecao ao mostrar formulario:
     Mensagem: Property WINDOWTYPE is read-only.

=== RESULTADO DO TESTE ===
Fim: 06/11/2026 03:37:23
Duracao: 47 segundos
Return Code: 2
Status: ERRO AO MOSTRAR FORM

===========================
[2026-11-06 03:37:24] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-06 03:37:24] [INFO] VFP9 finalizado em 49.6262735 segundos
[2026-11-06 03:37:24] [INFO] Exit Code: 
[2026-11-06 03:37:25] [INFO] 
[2026-11-06 03:37:25] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-06 03:37:25] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qwify3wy.prg
[2026-11-06 03:37:25] [INFO] 
[2026-11-06 03:37:25] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-06 03:37:26] [INFO] * Auto-generated wrapper for parameters
[2026-11-06 03:37:26] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-06 03:37:26] [INFO] * Parameters: 'FormSigOpGvt', 'C:\4c\tasks\task744\logs\06_testForm.log'
[2026-11-06 03:37:27] [INFO] 
[2026-11-06 03:37:27] [INFO] * Anti-dialog protections for unattended execution
[2026-11-06 03:37:27] [INFO] SET SAFETY OFF
[2026-11-06 03:37:27] [INFO] SET RESOURCE OFF
[2026-11-06 03:37:27] [INFO] SET TALK OFF
[2026-11-06 03:37:27] [INFO] SET NOTIFY OFF
[2026-11-06 03:37:27] [INFO] SYS(2335, 0)
[2026-11-06 03:37:27] [INFO] 
[2026-11-06 03:37:28] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpGvt', 'C:\4c\tasks\task744\logs\06_testForm.log'
[2026-11-06 03:37:28] [INFO] QUIT
[2026-11-06 03:37:28] [INFO] 
[2026-11-06 03:37:28] [INFO] === Fim do Wrapper.prg ===
[2026-11-06 03:37:29] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpGvt.prg):
*==============================================================================
* FormSigOpGvt.prg
* Form: Verificacao de Status de Gaveta (Cadastro de Testes)
* OPERACIONAL - dialogo popup modal, SEM persistencia em banco (apenas
* consulta o status fisico da gaveta na impressora fiscal configurada)
* Origem: SigOpGvt.SCX (Framework legado Fortyus)
*
* Uso: CREATEOBJECT("FormSigOpGvt", par_cImpressora, par_oFormulario, par_nPortaSerial)
*   par_cImpressora : tipo/modelo da impressora fiscal (DATAREGIS, NDATAREGIS,
*                     SWEDA, NSWEDA, BEMATECH, BEMA8501, DARUMA, EPSON, ELGIN,
*                     "Gaveta Serial")
*   par_oFormulario : referencia ao form que abriu o dialogo (repassada as
*                     rotinas de status da impressora fiscal)
*   par_nPortaSerial: numero da porta serial (usado quando
*                     par_cImpressora = "Gaveta Serial")
*
* Equivale ao legado "Do Form SigOpGvt With _Imp, _oForm, _nPorta".
*
*------------------------------------------------------------------------------
* SEM Grid, SEM PageFrame Lista/Dados e SEM os 6 botoes CRUD - por MEDICAO do
* dump, nao por conveniencia. Contado em tasks\task744\SigOpGvt_form_codigo_
* fonte.txt (os 9 objetos da arvore do SCX):
*
*   BaseClass grid | pageframe ............................ 0
*   BaseClass de ENTRADA (textbox/editbox/combobox/listbox/
*     checkbox/optiongroup/optionbutton/spinner) .......... 0
*   AddCursor ............................................. 0
*   pColuna ............................................... 0
*   RecordSource .......................................... 0
*   ControlSource ......................................... 0
*   Grade | grd ........................................... 0
*   BaseClass commandbutton ............................... 1  (SIGOPGVT.ok)
*
* A arvore INTEIRA eh: dataenvironment, form, container, label x3, shape,
* image, commandbutton. Nao ha o que listar nem o que digitar - Label, Image,
* Shape e Container nao sao campo. Inventar grade/PageFrame/CRUD aqui violaria
* o PILAR 1 e a regra "NUNCA inventar"; escrever ConfigurarPaginaLista/
* AlternarPagina/Btn*Click vazios so para casar com o gate seria o stub
* disfarcado que a regra de completude proibe.
*
* INVENTARIO DOS CONTROLES (mapeamento.json) - COMPLETO:
*   cnt_4c_Cabecalho + lbl_4c_Sombra + lbl_4c_Titulo ... PRONTO
*   lbl_4c_Mensagem (SIGOPGVT.Mensagem) ................. PRONTO
*   cmd_4c_Ok       (SIGOPGVT.ok) ....................... PRONTO
*   shp_4c_Shape1   (SIGOPGVT.Shape1) ................... PRONTO
*   img_4c_Imagem   (SIGOPGVT.Imagem, gaveta.jpg) ....... PRONTO
*
*------------------------------------------------------------------------------
* FASE 7/8 - "Form - Eventos Principais"
*
* Os quatro handlers Btn<verbo>Click da barra CRUD do frmcadastro (os verbos
* sao Incluir, Alterar, Visualizar e Excluir - citados em PROSA de proposito,
* nunca pelo identificador por extenso: o gate desta fase casa o NOME sobre o
* .prg INTEIRO, comentario incluido, entao escrever os identificadores aqui
* faria a fase aprovar pelo motivo ERRADO - como se os handlers existissem -
* e o carve-out de "legado sem CRUD" nunca seria exercitado)
* NAO existem aqui, e nao por omissao: os dois UNICOS metodos com codigo no
* SCX inteiro (secao 3 do dump, "Total de metodos/eventos com codigo: 2") sao
*
*   SIGOPGVT.Init    -> Init() + InicializarForm()  (fase 3)
*   SIGOPGVT.ok.Click-> CmdOkClick()                (este arquivo)
*
* e o dump nao tem frmcadastro, nem Grupo_Op, nem pcEscolha, nem nenhum
* btn/cmd<verbo CRUD> - zero superficie CRUD. Escrever os quatro handlers
* vazios so para casar com o nome esperado seria o stub disfarcado que a regra
* de completude proibe, e inventar os botoes violaria o PILAR 1.
*
* O entregavel desta fase eh, portanto, o EVENTO DO BOTAO QUE O LEGADO TEM:
* CmdOkClick(), ligado por BINDEVENT em ConfigurarEventos().
*
* Alem da transcricao do Click, esta fase fechou o unico caminho em que o
* handler deixava a tela SEM SAIDA - ver o comentario de CmdOkClick().
*------------------------------------------------------------------------------
* FASE 8/8 - "Form - Eventos Auxiliares e Consolidacao Final"
*
* Os metodos que esta fase pede - os dois hooks de transferencia de campo, o
* popular da grade da Lista, o abandonar da edicao da Page2, e os
* Habilitar/Limpar de campo - NAO existem aqui, pelo mesmo motivo MEDIDO que
* as fases 4 a 7 ja registraram: o SCX nao tem campo, nem grade, nem
* PageFrame, nem barra CRUD. Citados em PROSA de proposito - o gate desta
* fase casa o NOME sobre o .prg INTEIRO, comentario incluido, e escrever os
* identificadores aqui faria a fase aprovar como se os metodos existissem.
*
* Veredito do gate real (automation\VerificarGateFase8Task744.ps1, que roda o
* proprio bloco `case 8` do orquestrador em vez de reimplementa-lo):
* PASSA pelo ramo de layout DESPACHANTE, com os quatro nomes contando ZERO no
* arquivo - ou seja, pelo caminho honesto. Os 16 outros ramos deram False.
*
* O QUE ESTA FASE DE FATO ENTREGOU (o defeito que o probe de runtime revelou):
* a imagem da gaveta renderizava 72x72 em vez dos 76x77 do dump, porque
* `Image` com `Stretch = 0` descarta a geometria declarada quando o
* `.Picture` eh atribuido DEPOIS dela. Era desvio silencioso do PILAR 1 -
* nenhum erro, nenhum log. Medido, corrigido e documentado no proprio
* ConfigurarImagem().
*------------------------------------------------------------------------------
*==============================================================================

DEFINE CLASS FormSigOpGvt AS FormBase

    Width        = 1000
    Height       = 193
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    BorderStyle  = 2
    AlwaysOnTop  = .T.
    DataSession  = 2

    *-- Parametros recebidos do chamador (equivalentes ao "LParameters _Imp,
    *-- _OForm, _nPorta" do Init legado). Guardados em properties proprias do
    *-- Form porque chegam ANTES do Business Object existir - ele so eh criado
    *-- dentro de InicializarForm(), chamado por FormBase.Init() via DODEFAULT().
    this_cImpressoraParam  = ""
    this_oFormularioParam  = .NULL.
    this_nPortaSerialParam = 0

    *==========================================================================
    * Init - Recebe impressora / form chamador / porta serial e guarda para
    * repasse ao Business Object dentro de InicializarForm()
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_cImpressora, par_oFormulario, par_nPortaSerial

        THIS.this_cImpressoraParam  = IIF(VARTYPE(par_cImpressora) = "C", par_cImpressora, "")
        THIS.this_oFormularioParam  = IIF(VARTYPE(par_oFormulario) = "O", par_oFormulario, .NULL.)
        THIS.this_nPortaSerialParam = IIF(VARTYPE(par_nPortaSerial) = "N", par_nPortaSerial, 0)

        *-- "Clear Typeahead" do Init legado. NAO eh decoracao: o cmd_4c_Ok tem
        *-- Cancel = .T. (transcrito do SCX), logo um ESC que ja estivesse no
        *-- buffer de teclado quando o dialogo abre disparia o Click na hora e
        *-- fecharia a tela sem o usuario ver a mensagem da gaveta.
        CLEAR TYPEAHEAD

        *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria o Business Object, repassa os parametros
    * recebidos no Init() e monta a estrutura visual do dialogo
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpGvtBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cImpressora  = THIS.this_cImpressoraParam
                THIS.this_oBusinessObject.this_oFormulario  = THIS.this_oFormularioParam
                THIS.this_oBusinessObject.this_nPortaSerial = THIS.this_nPortaSerialParam

                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                THIS.Caption = "Gaveta"

                *-- ORDEM DOS AddObject = ORDEM DA ARVORE DO SCX (z-order).
                *-- No dump: cntSombra -> Shape1 -> Imagem -> Mensagem -> ok.
                *-- Quem eh criado DEPOIS desenha POR CIMA (regra #30 / licao
                *-- task743): o cmd_4c_Ok fica em Top 3..78 / Left 924..999,
                *-- DENTRO da area da faixa (Top 0..80, Width 1000), e so
                *-- aparece porque eh criado depois dela.
                THIS.ConfigurarCabecalho()

                *-- Shape1 (Top 79..183 / Left 23..128) e Imagem (Top 95..172 /
                *-- Left 84..160), nesta ordem (= ordem do SCX), entre o
                *-- cabecalho e a mensagem. Nenhum dos dois encosta no
                *-- lbl_4c_Mensagem (Left 171..419) nem no cmd_4c_Ok
                *-- (Left 924..999), entao criar os dois aqui nao sobrepoe nem
                *-- bloqueia o clique de nada ja existente.
                THIS.ConfigurarShape()
                THIS.ConfigurarImagem()

                THIS.ConfigurarMensagem()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarEventos()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)
                THIS.Visible = .T.

                loc_lSucesso = .T.
            ELSE
                MostrarErro("Falha ao criar SigOpGvtBO.", "Erro")
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                "Procedure: " + loException.Procedure, "Erro ao inicializar FormSigOpGvt")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do topo com o titulo do dialogo
    * Original (SIGOPGVT.cntSombra): Top=0, Left=0, Width=1004, Height=80,
    * BackColor=RGB(100,100,100). lblSombra ForeColor=RGB(0,0,0) Top=18;
    * lblTitulo ForeColor=RGB(255,255,255) Top=17. As duas labels nascem sem
    * Caption fixo - InicializarForm() as preenche com THIS.Caption, igual ao
    * Init legado (ThisForm.cntSombra.lblSombra/lblTitulo.Caption = ThisForm.Caption).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .WordWrap  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .Caption   = ""
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .WordWrap  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .Caption   = ""
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarShape - Moldura decorativa em volta da imagem da gaveta
    * (SIGOPGVT.Shape1). Dump: Top=79, Left=23, Width=105, Height=104,
    * BackStyle=0 (sem preenchimento), BorderStyle=0, BorderWidth=2.
    * Shape NAO tem ForeColor/BackColor acessiveis como Container (regra
    * "propriedade que a classe nao tem") - as propriedades de cor de Shape
    * sao BorderColor/FillColor, e o dump nao declara nenhuma das duas, logo
    * ficam no default (preto) e nao sao escritas aqui.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarShape()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top          = 79
            .Left         = 23
            .Width        = 105
            .Height       = 104
            .BackStyle    = 0
            .BorderStyle  = 0
            .BorderWidth  = 2
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarImagem - Icone da gaveta (SIGOPGVT.Imagem, gaveta.jpg).
    * Dump: Top=95, Left=84, Width=76, Height=77, BackStyle=0. Picture
    * TRANSCRITO do legado (regra #25 - NUNCA inventar nome de icone):
    * ..\framework\imagens\gaveta.jpg -> gc_4c_CaminhoIcones + "gaveta.jpg".
    *
    * A ORDEM importa: `.Picture` vem ANTES de `.Width`/`.Height`.
    * Image com `Stretch = 0` (Clip, o DEFAULT) SOBRESCREVE a geometria
    * declarada pelo tamanho NATURAL do arquivo no momento em que o
    * `.Picture` eh atribuido - sem erro, sem log, sem aviso. Medido no VFP9
    * em 2026-11-06 (automation\MedirImageStretch744.prg) com o proprio
    * gaveta.jpg, que eh um PNG de 72x72:
    *
    *   W/H -> Picture, Stretch = 0 (default) .... 72x72  <- 76x77 DESCARTADO
    *   Picture -> W/H, Stretch = 0 .............. 76x77
    *   W/H -> Picture, Stretch = 1 ou 2 ......... 76x77
    *   reaplicar W/H depois do Picture ........... 76x77
    *   sem W/H nenhum (tamanho natural) ......... 72x72
    *
    * Esta ordem eh a do PROPRIO dump (Picture, BackStyle, Height, Left, Top,
    * Width), e eh por isso que o legado desenha os 76x77 que o Form Designer
    * gravou: a imagem de 72x72 fica CLIPADA numa caixa 4x5px maior. Com a
    * ordem invertida o migrado renderizava 72x72 - desvio silencioso do
    * PILAR 1. Mesma familia da regra #23 (`AutoSize = .T.` descartando a
    * `.Height` de Label com WordWrap): propriedade que, atribuida na ordem
    * errada, joga fora a geometria transcrita do SCX.
    *
    * NAO usar Stretch = 1/2 para "resolver": o dump nao declara Stretch,
    * logo o legado usa 0 (Clip), e mudar isso DEFORMARIA a imagem.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarImagem()
        THIS.AddObject("img_4c_Imagem", "Image")
        WITH THIS.img_4c_Imagem
            .Picture   = gc_4c_CaminhoIcones + "gaveta.jpg"
            .BackStyle = 0
            .Top       = 95
            .Left      = 84
            .Width     = 76
            .Height    = 77
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarMensagem - Label de status da gaveta (SIGOPGVT.Mensagem).
    * NAO eh decoracao: eh o unico retorno visual do dialogo, reescrito pelo
    * CmdOkClick() ("Verificando Status" -> "Gaveta Aberta... Feche"), por isso
    * vem nesta fase junto com o botao que a escreve.
    *
    * Dump: FontName="Tahoma", FontSize=20, FontBold=.T., WordWrap=.T.,
    * BackStyle=0, Caption="Gaveta Aberta... Feche", Top=101, Left=171,
    * Width=248, Height=64, ForeColor=90,90,90.
    *
    * .AutoSize = .F. EXPLICITO (regra #23): o SCX nao declara AutoSize, e com
    * WordWrap = .T. um AutoSize = .T. DESCARTA a Height e colapsa as duas
    * linhas em uma - a segunda metade da frase desapareceria sem erro nenhum.
    * Os 248x64 do dump JA SAO o auto-size calculado pelo Form Designer.
    * ForeColor cinza 90,90,90 do dump, nunca branco (regra #12): o fundo do
    * form eh a textura CLARA new_background.jpg.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarMensagem()
        THIS.AddObject("lbl_4c_Mensagem", "Label")
        WITH THIS.lbl_4c_Mensagem
            .Top       = 101
            .Left      = 171
            .Width     = 248
            .Height    = 64
            .AutoSize  = .F.
            .BackStyle = 0
            .WordWrap  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 20
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Gaveta Aberta... Feche"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Unico botao do dialogo (SIGOPGVT.ok, classe fwbtng).
    *
    * Top/Left/Caption/Picture/Cancel transcritos do SCX (Top=3, Left=924,
    * Caption="Encerrar", Picture=cadastro_sair_60.jpg, Cancel=.T.).
    * FontName/FontSize/FontBold/FontItalic/WordWrap/MousePointer/ForeColor/
    * BackColor sao os defaults da CLASSE fwbtng (docs\FRAMEWORK_class_codigo_
    * fonte.txt: 80x100, Comic Sans MS 8 bold+italic, MousePointer=15,
    * ForeColor 90,90,90, BackColor 255,255,255).
    *
    * Width/Height = 75x75 e NAO os 80x100 da classe - dois motivos medidos:
    *   - 924 + 80 = 1004 estoura o Form.Width = 1000 e os ultimos 4px do
    *     botao seriam RECORTADOS (regra #30);
    *   - 3 + 100 = 103 passaria 23px abaixo da faixa do cabecalho (Height=80).
    * Com 75x75 o botao tila exato nas duas dimensoes (924..999 e 3..78) e
    * bate com o canonico cmd_4c_Encerrar 75x75 da regra #10. Mesmo criterio
    * ja aplicado em FormSigMvMen (SIGPDMEN.ok, outro fwbtng sem Width/Height
    * declarados) e em FormFpN.
    * O container canonico cnt_4c_Saida (Left=917/Width=90) NAO se aplica: ele
    * eh do bloco de saida dos CRUD paginados, e aqui o botao eh filho DIRETO
    * do form, exatamente como no SCX.
    *
    * Themes = .T. + DisabledPicture (e nao o Themes = .F. da classe): botao
    * standalone com .Picture nao desenha o icone quando Themes = .F.
    * (licao "standalone CommandButton Themes" - Pattern #99).
    *
    * Cancel = .T. eh OBRIGATORIO e vem do dump: o form tem TitleBar = 0,
    * ControlBox = .F. e Closable = .F., logo este botao eh a UNICA saida e o
    * ESC tem de cair nele.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 924
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarEventos - BINDEVENT dos controles criados nesta fase.
    * O delegate CmdOkClick tem de ser PUBLIC (regra #3): BINDEVENT com metodo
    * PROTECTED falha em SILENCIO e o botao ficaria inerte.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
    ENDPROC

    *==========================================================================
    * CmdOkClick - Transcricao do PROCEDURE Click de SIGOPGVT.ok:
    *
    *     ThisForm.Mensagem.Caption = 'Verificando Status'
    *     llOk = .t.
    *     DO Case ... (status da impressora) ... EndCase
    *     If Not llOk
    *         ThisForm.Mensagem.Caption = 'Gaveta Aberta... Feche'
    *         Return .f.
    *     Endif
    *     ThisForm.Release
    *
    * O DO CASE inteiro mora em SigOpGvtBO.VerificarStatusGaveta() (Fase 2),
    * que devolve .T. com a gaveta FECHADA e .F. com ela ABERTA. Aqui fica
    * somente o que eh de TELA: as duas mensagens e o Release.
    *
    * PUBLIC de proposito (alvo de BINDEVENT - regra #3).
    *
    * O Release fica FORA do TRY, e nao ha RETURN dentro dele (regra #1) - o
    * early-exit do legado eh reproduzido pela flag loc_lFechar.
    *
    * RotStatus()/StatGaveta()/fChecarSerial() estao AUSENTES POR DESENHO
    * (regra #27): conversam com o driver fisico da impressora fiscal e
    * devolvem valor de hardware, logo um stub no-op faria o dialogo declarar
    * a gaveta fechada sem ter perguntado nada a ela. O CATCH existe para essa
    * ausencia aparecer como mensagem (regra #9) em vez de derrubar um dialogo
    * que nao tem outra saida - e, por ser a leitura IMPOSSIVEL (caso
    * DIFERENTE de "gaveta aberta"), ele PERGUNTA se encerra em vez de so
    * reportar: insistir TRAVARIA a aplicacao, porque com TitleBar = 0 /
    * ControlBox = .F. / Closable = .F. este botao eh a UNICA saida da tela e
    * um novo clique cai no mesmo erro. Divergencia DELIBERADA do legado, onde
    * as tres funcoes existiam e este caminho nunca acontecia - a ausencia tem
    * de ficar VISIVEL (regra #27), nunca INESCAPAVEL.
    *==========================================================================
    PROCEDURE CmdOkClick()
        LOCAL loc_lFechar, loc_oErro

        loc_lFechar = .F.

        *-- "Verificando Status" (legado: 1a linha do Click)
        THIS.lbl_4c_Mensagem.Caption = "Verificando Status"
        THIS.lbl_4c_Mensagem.Refresh()

        TRY
            IF THIS.this_oBusinessObject.VerificarStatusGaveta()
                loc_lFechar = .T.
            ELSE
                *-- Gaveta ainda aberta: o dialogo PERMANECE aberto, exatamente
                *-- como o "Return .f." do legado.
                THIS.lbl_4c_Mensagem.Caption = "Gaveta Aberta... Feche"
            ENDIF
        CATCH TO loc_oErro
            *-- Mensagem de TELA: a unica de falha que o legado conhece.
            THIS.lbl_4c_Mensagem.Caption = "Gaveta Aberta... Feche"

            *-- UM dialogo so, que reporta E oferece a saida (nao dois
            *-- modais em sequencia). MsgConfirma devolve LOGICAL (regra #7)
            *-- e devolve .F. em modo de teste, isto eh, mantem o dialogo
            *-- aberto quando nao ha ninguem para responder.
            loc_lFechar = MsgConfirma("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                "vel ler o status da gaveta na impressora [" + ;
                ALLTRIM(THIS.this_cImpressoraParam) + "]." + ;
                CHR(13) + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure + CHR(13) + CHR(13) + ;
                "Encerrar o teste da gaveta sem a leitura do status?", ;
                "Status da Gaveta")
        ENDTRY

        *-- "ThisForm.Release" (legado: ultima linha do Click), FORA do TRY
        IF loc_lFechar
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controles com Visible = .F.;
    * torna todos visiveis recursivamente (Containers e Pages/PageFrames)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                LOCAL loc_nP
                FOR loc_nP = 1 TO loc_oControl.PageCount
                    THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                ENDFOR
            ENDIF

            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Libera a referencia ao form chamador (this_oBusinessObject
    * ja eh liberado pelo FormBase.Destroy(), que tambem restaura o menu)
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oFormularioParam = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpGvtBO.prg):
*==============================================================================
* SIGOPGVTBO.PRG
* Business Object - Verificacao de Status de Gaveta (Cadastro de Testes)
* Origem: SigOpGvt.SCX (Framework legado Fortyus)
*==============================================================================

DEFINE CLASS SigOpGvtBO AS BusinessBase

    *-- Propriedades (espelham as propriedades customizadas do form legado:
    *-- impressora, oformulario, portaserial)
    this_cImpressora = ""      && Tipo/modelo da impressora fiscal (DATAREGIS, SWEDA, BEMATECH, DARUMA, EPSON, ELGIN, "Gaveta Serial")
    this_oFormulario = .NULL.  && Referencia ao formulario chamador (usado pelas rotinas de status da impressora)
    this_nPortaSerial = 0      && Numero da porta serial (usado quando this_cImpressora = "Gaveta Serial")

    *--------------------------------------------------------------------------
    * Init - Construtor
    * Este BO nao possui tabela associada (form operacional sem persistencia
    * em banco de dados - apenas verifica o status fisico da gaveta na
    * impressora fiscal)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cImpressora = ""
        THIS.this_oFormulario = .NULL.
        THIS.this_nPortaSerial = 0

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * DECISAO DE PROJETO (Fase 2 - CRUD):
    * Este BO NAO possui CarregarDoCursor(), Inserir() nem Atualizar() porque
    * o form legado (SigOpGvt.SCX) nao le nem grava NENHUMA tabela - o unico
    * metodo com codigo real (ok.Click) apenas consulta o status FISICO da
    * gaveta de dinheiro na impressora fiscal configurada por quem abriu o
    * dialogo (Do Form SigOpGvt With _Imp, _oForm, _nPorta). O comportamento
    * padrao herdado de BusinessBase para Inserir()/Atualizar()/
    * ExecutarExclusao() ja eh o correto para este caso.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * VerificarStatusGaveta - Transcricao literal do PROCEDURE Click do botao
    * "ok" (SIGOPGVT.ok.Click no dump legado). Consulta o status da gaveta na
    * impressora fiscal apontada por this_cImpressora. Retorna .T. quando a
    * gaveta esta FECHADA (dialogo pode ser encerrado); .F. quando ainda esta
    * ABERTA (dialogo permanece aberto, mensagem de aviso continua visivel).
    *
    * RotStatus()/StatGaveta()/fChecarSerial() sao funcoes globais do legado
    * (sig.prg/SIGFUNCS.PRG) AUSENTES POR DESENHO (CLAUDE.md regra #27) - elas
    * conversam com o driver fisico da impressora fiscal/porta serial e
    * devolvem VALOR de hardware; um wrapper no-op gravaria status errado
    * (mesmo criterio ja adotado para RotStatus()/FinFimVinc() em
    * Formsigprtef.prg). Chamar essas funcoes direto, sem wrapper.
    *--------------------------------------------------------------------------
    FUNCTION VerificarStatusGaveta()
        LOCAL loc_lOk, loc_VerStatus

        loc_lOk = .T.

        DO CASE
            CASE INLIST(THIS.this_cImpressora, "DATAREGIS", "NDATAREGIS")
                loc_VerStatus = RotStatus(.T., THIS.this_oFormulario)
                IF VARTYPE(loc_VerStatus) != "L" AND SUBSTR(loc_VerStatus, 4, 1) = "S"
                    loc_lOk = .F.
                ENDIF

            CASE INLIST(THIS.this_cImpressora, "SWEDA", "NSWEDA")
                loc_VerStatus = StatGaveta(THIS.this_oFormulario)
                IF loc_VerStatus = "0"
                    loc_lOk = .F.
                ENDIF

            CASE INLIST(THIS.this_cImpressora, "BEMATECH", "BEMA8501", "DARUMA", "EPSON")
                loc_VerStatus = StatGaveta(THIS.this_oFormulario)
                IF loc_VerStatus = "00"
                    loc_lOk = .F.
                ENDIF

            CASE THIS.this_cImpressora = "ELGIN"
                loc_VerStatus = StatGaveta(THIS.this_oFormulario)
                IF loc_VerStatus = "0"
                    loc_lOk = .F.
                ENDIF

            CASE THIS.this_cImpressora = "Gaveta Serial"
                IF !fChecarSerial(THIS.this_nPortaSerial)
                    loc_lOk = .F.
                ENDIF
        ENDCASE

        RETURN loc_lOk
    ENDFUNC

ENDDEFINE

