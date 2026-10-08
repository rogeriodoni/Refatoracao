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
[2026-10-07 12:38:31] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-07 12:38:31] [INFO] Config FPW: (nao fornecido)
[2026-10-07 12:38:32] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-07 12:38:32] [INFO] Timeout: 300 segundos
[2026-10-07 12:38:32] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cqek3z5r.prg
[2026-10-07 12:38:32] [INFO] Conteudo do wrapper:
[2026-10-07 12:38:32] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigprico', 'C:\4c\tasks\task624\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprico', 'C:\4c\tasks\task624\logs\06_testForm.log'
QUIT

[2026-10-07 12:38:32] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cqek3z5r.prg
[2026-10-07 12:38:32] [INFO] VFP output esperado em: C:\4c\tasks\task624\vfp_output.txt
[2026-10-07 12:38:32] [INFO] Executando Visual FoxPro 9...
[2026-10-07 12:38:32] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cqek3z5r.prg
[2026-10-07 12:38:32] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cqek3z5r.prg
[2026-10-07 12:38:33] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigprico
Inicio: 07/10/2026 12:38:33

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 07/10/2026 12:42:00
Duracao: 207 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-07 12:42:00] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-07 12:42:00] [INFO] VFP9 finalizado em 207.8901708 segundos
[2026-10-07 12:42:00] [INFO] Exit Code: 
[2026-10-07 12:42:00] [INFO] 
[2026-10-07 12:42:01] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-07 12:42:01] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cqek3z5r.prg
[2026-10-07 12:42:01] [INFO] 
[2026-10-07 12:42:01] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-07 12:42:01] [INFO] * Auto-generated wrapper for parameters
[2026-10-07 12:42:01] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-07 12:42:01] [INFO] * Parameters: 'Formsigprico', 'C:\4c\tasks\task624\logs\06_testForm.log'
[2026-10-07 12:42:01] [INFO] 
[2026-10-07 12:42:01] [INFO] * Anti-dialog protections for unattended execution
[2026-10-07 12:42:01] [INFO] SET SAFETY OFF
[2026-10-07 12:42:01] [INFO] SET RESOURCE OFF
[2026-10-07 12:42:01] [INFO] SET TALK OFF
[2026-10-07 12:42:02] [INFO] SET NOTIFY OFF
[2026-10-07 12:42:02] [INFO] SYS(2335, 0)
[2026-10-07 12:42:02] [INFO] 
[2026-10-07 12:42:02] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprico', 'C:\4c\tasks\task624\logs\06_testForm.log'
[2026-10-07 12:42:02] [INFO] QUIT
[2026-10-07 12:42:02] [INFO] 
[2026-10-07 12:42:02] [INFO] === Fim do Wrapper.prg ===
[2026-10-07 12:42:02] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprico.prg):
*==============================================================================
* FORMSIGPRICO.PRG
* Form OPERACIONAL - Catalogo de Icones do Sistema (legado SIGPRICO.SCX)
* Herda de: FormBase
*
* O legado SIGPRICO.SCX nao possui DataEnvironment ligado a tabela, nao
* possui ControlSource em controle nenhum e nao possui um unico metodo com
* codigo ("Total de metodos/eventos com codigo: 0" no dump
* tasks\task624\sigprico_form_codigo_fonte.txt). Ele e composto exclusivamente
* por 24 controles Image (Image1..Image11, Image15..Image27 - a lacuna
* 12/13/14 nao existe no legado e sera reproduzida de proposito na Fase 4,
* PILAR 1) que exibem icones da pasta vbmp\: trata-se de uma tela de
* REFERENCIA VISUAL (catalogo/paleta de icones), sem PageFrame, sem
* Pagina Lista/Dados, sem grid e sem qualquer botao/CRUD.
*
* Por isso este form NAO segue o padrao Page1=Lista/Page2=Dados do CRUD
* nem o padrao de grids multiplos de outros OPERACIONAIS: o unico conteudo
* e o catalogo estatico de icones (sigpricoBO.this_cArqImageN /
* this_cObjImageN), a ser adicionado em ConfigurarPageFrame() na Fase 4.
* O nome ConfigurarPageFrame() foi preservado so por compatibilidade com o
* pipeline de migracao multi-fase (mesmo padrao documentado em
* FormICO.prg para OPERACIONAL flat) - nao existe PageFrame real aqui.
*
* Width/Height nao aparecem customizados no dump do legado (SCX ficou no
* default da classe "form" do VFP9) - os valores abaixo apenas enquadram
* os 24 icones (bbox real do catalogo: Left 0..258, Top 0..197, ver
* tasks\task624\layout.json) com margem, sem inventar funcionalidade
* visual que o legado nao declarou.
*
* FASES 5 A 7 (pipeline multi-fase): NAO APLICAVEIS a este form. O dump do
* legado (tasks\task624\analise.json/layout.json) nao declara "campos"
* (analise.json: campos=[], lookups=[], labels=[], grid.temGrid=false) nem
* Pagina Lista/Dados/PageFrame real - so os 24 Image ja entregues na Fase 4
* via ConfigurarPageFrame(). Criar ConfigurarPaginaDados() vazio seria stub
* disfarcado (proibido); inventar campo/lookup/grid que o legado nao tem
* violaria o PILAR 1. Idem para os eventos de botao da Fase 7: o legado nao
* tem CommandButton, nao tem CommandGroup e nao tem um unico ".Click"
* ("Total de metodos/eventos com codigo: 0" no proprio dump).
*
* FASE 8 (consolidacao final): tambem nao ha BtnBuscarClick/BtnEncerrarClick/
* BtnSalvarClick/BtnCancelarClick (nao existe botao), nem FormParaBO/
* BOParaForm (nao existe nada digitavel para transferir), nem HabilitarCampos/
* LimparCampos/CarregarLista/AjustarBotoesPorModo (nao existe campo, lista nem
* modo CRUD). O trabalho REAL da Fase 8 aqui foi consolidar o ciclo de vida da
* janela, que estava na forma INSTAVEL - ver os comentarios de ShowWindow/
* WindowType na declaracao da classe e de Init() abaixo.
*
* Arquitetura: FormBase (UI) -> BusinessBase (BO) -> DataAccess (SQL Server)
*==============================================================================

DEFINE CLASS Formsigprico AS FormBase

    Width      = 300
    Height     = 260
    Caption    = "Form1"       && Caption EXATO do SCX legado (sigpricoBO.this_cCaptionLegado)

    *-- ShowWindow: FIXO na classe, nunca atribuido em runtime. ShowWindow eh
    *-- READ-ONLY em RUNTIME nesta instalacao do VFP9 (medido -
    *-- automation\medir_showwindow.txt: "Property SHOWWINDOW is read-only.",
    *-- inclusive dentro do proprio Init). E declarar 0 aqui NAO para em pe: o
    *-- CorretorAutomatico (SHOWWINDOW_AUSENTE, pattern #29) procura
    *-- literalmente "ShowWindow = 1" e, achando "= 0", INJETA uma SEGUNDA
    *-- declaracao na mesma DEFINE CLASS - medido nesta Fase 8 rodando o
    *-- corretor sobre uma COPIA deste arquivo: saiu "ShowWindow = 1" na linha
    *-- 43 convivendo com "ShowWindow = 0" na linha 48. Com "= 1" aqui o
    *-- corretor eh no-op e nao ha declaracao duplicada.
    ShowWindow = 1

    *-- WindowType: canonico do projeto (136 dos 149 forms de operacionais\
    *-- declaram 1). O SCX legado nao declara WindowType - mas transcrever essa
    *-- ausencia (= 0, modeless) QUEBRA a tela, porque o modo de abertura mudou
    *-- entre os sistemas: o menu.prg abre com CREATEOBJECT + variavel LOCAL +
    *-- Show(), e em modeless o Show() retorna na hora, o PROCEDURE termina, a
    *-- ultima referencia cai e o form eh destruido - pisca e some, sem erro,
    *-- sem log e sem entrada em gc_4c_ArquivoErroTeste. Ao contrario de
    *-- ShowWindow, WindowType ACEITA escrita em runtime (mesma medicao), e eh
    *-- so por isso que o Init abaixo pode rebaixar para 0 no caminho headless.
    WindowType = 1

    *-- Business Object (catalogo de icones - sem tabela, ver sigpricoBO.prg)
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
    * Em modo teste: rebaixa para modeless + invisivel, para o VFP9 -T headless
    * nao pendurar tentando exibir form modal. So WindowType aceita escrita em
    * runtime - NAO tocar ShowWindow aqui (read-only; ver comentario na
    * declaracao da classe). Mesma protecao do padrao canonico Formsigprftp.
    *
    * O caminho de PRODUCAO nao atribui propriedade NENHUMA: os valores da
    * classe (ShowWindow = 1 / WindowType = 1) ja sao os de producao. Isso
    * elimina a armadilha de polaridade - atribuicao de propriedade dentro de
    * guard de modo roda exatamente no ramo que o harness NAO exercita, entao
    * um erro ali passa por todos os gates ("o form instancia") e so aparece
    * quando o usuario clica no menu. As DUAS polaridades foram medidas nesta
    * fase: automation\ProbeIcoF8Polaridades.prg -> probe_ico_f8_polaridades.txt.
    *
    * Nao existe override de Load(): o anterior pulava o Form.Load() builtin em
    * modo teste alegando que "ShowWindow=0 na definicao da classe" o faria
    * travar no headless. Com ShowWindow = 1 (canonico) essa premissa deixou de
    * existir, e medir mostrou que o Load() builtin roda limpo nas duas
    * polaridades - manter o override seria risco sem beneficio.
    *--------------------------------------------------------------------------
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            THIS.WindowType = 0
            THIS.Visible    = .F.
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object do catalogo de icones.
    * A montagem dos 24 Image (ConfigurarPageFrame) e adicionada na Fase 4.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigpricoBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigpricoBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.ConfigurarPageFrame()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao Inicializar Formsigprico")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador do layout. SEM PageFrame real: o
    * legado SIGPRICO e um Form flat, sem abas e sem Pagina Lista/Dados.
    * Nome preservado so por compatibilidade com o pipeline de migracao
    * multi-fase (mesmo padrao de FormICO.prg).
    *
    * Monta os 24 controles Image do catalogo (Image1..Image11, Image15..
    * Image27 - a lacuna 12/13/14 nao existe no legado, PILAR 1), com
    * Top/Left/Width/Height/Stretch/Picture transcritos LITERALMENTE de
    * THIS.this_oBusinessObject.this_cArqImageN/this_cObjImageN (que por
    * sua vez vieram de tasks\task624\layout.json - ver comentario slot a
    * slot em sigpricoBO.prg). Nomes migrados seguem mapeamento.json:
    * sigprico.ImageN -> img_4c_ImageN.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        THIS.AdicionarIconeCatalogo("img_4c_Image1",  0,   0, loc_oBO.this_cArqImage1)
        THIS.AdicionarIconeCatalogo("img_4c_Image2",  18,   0, loc_oBO.this_cArqImage2)
        THIS.AdicionarIconeCatalogo("img_4c_Image3",  36,   0, loc_oBO.this_cArqImage3)
        THIS.AdicionarIconeCatalogo("img_4c_Image4",   1,  22, loc_oBO.this_cArqImage4)
        THIS.AdicionarIconeCatalogo("img_4c_Image5",   1,  44, loc_oBO.this_cArqImage5)
        THIS.AdicionarIconeCatalogo("img_4c_Image6",   1,  67, loc_oBO.this_cArqImage6)
        THIS.AdicionarIconeCatalogo("img_4c_Image7",   1,  90, loc_oBO.this_cArqImage7)
        THIS.AdicionarIconeCatalogo("img_4c_Image8",  24,  24, loc_oBO.this_cArqImage8)
        THIS.AdicionarIconeCatalogo("img_4c_Image9",  24,  53, loc_oBO.this_cArqImage9)
        THIS.AdicionarIconeCatalogo("img_4c_Image10", 24,  84, loc_oBO.this_cArqImage10)
        THIS.AdicionarIconeCatalogo("img_4c_Image11", 24, 116, loc_oBO.this_cArqImage11)
        THIS.AdicionarIconeCatalogo("img_4c_Image15", 47, 144, loc_oBO.this_cArqImage15)
        THIS.AdicionarIconeCatalogo("img_4c_Image16", 71,   5, loc_oBO.this_cArqImage16)
        THIS.AdicionarIconeCatalogo("img_4c_Image17", 94,  13, loc_oBO.this_cArqImage17)
        THIS.AdicionarIconeCatalogo("img_4c_Image18", 73,  33, loc_oBO.this_cArqImage18)
        THIS.AdicionarIconeCatalogo("img_4c_Image19", 117,  11, loc_oBO.this_cArqImage19)
        THIS.AdicionarIconeCatalogo("img_4c_Image20", 95,  44, loc_oBO.this_cArqImage20)
        THIS.AdicionarIconeCatalogo("img_4c_Image21", 121,  40, loc_oBO.this_cArqImage21)
        THIS.AdicionarIconeCatalogo("img_4c_Image22", 84,  96, loc_oBO.this_cArqImage22)
        THIS.AdicionarIconeCatalogo("img_4c_Image23", 108, 101, loc_oBO.this_cArqImage23)
        THIS.AdicionarIconeCatalogo("img_4c_Image24", 134, 106, loc_oBO.this_cArqImage24)
        THIS.AdicionarIconeCatalogo("img_4c_Image25", 84, 192, loc_oBO.this_cArqImage25)
        THIS.AdicionarIconeCatalogo("img_4c_Image26", 132, 204, loc_oBO.this_cArqImage26)
        THIS.AdicionarIconeCatalogo("img_4c_Image27", 180, 240, loc_oBO.this_cArqImage27)
    ENDPROC

    *--------------------------------------------------------------------------
    * AdicionarIconeCatalogo - Cria um controle Image do catalogo. Width=18/
    * Height=17/Stretch=2 sao constantes em TODOS os 24 slots do SCX legado
    * (this_nWidthIcone/this_nHeightIcone/this_nStretchIcone em sigpricoBO).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AdicionarIconeCatalogo(par_cNomeObjeto, par_nTop, par_nLeft, par_cArquivo)
        THIS.AddObject(par_cNomeObjeto, "Image")

        WITH EVALUATE("THIS." + par_cNomeObjeto)
            .Top     = par_nTop
            .Left    = par_nLeft
            .Width   = 18
            .Height  = 17
            .Stretch = 2
            .Picture = gc_4c_CaminhoIcones + par_cArquivo
            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpricoBO.prg):
*==============================================================================
* SIGPRICOBO.PRG
* Business Object - Catalogo de Icones do Sistema (legado SIGPRICO.SCX)
*
* Tabela: NENHUMA
*
* O form legado "sigprico" (sigprico.SCX) nao possui DataEnvironment ligado a
* tabela, nao possui ControlSource em controle nenhum e nao possui um unico
* metodo com codigo ("Total de metodos/eventos com codigo: 0" no dump
* tasks\task624\sigprico_form_codigo_fonte.txt). Ele e composto exclusivamente
* por 24 controles Image que exibem os arquivos de icone da pasta vbmp\ -
* trata-se de uma tela de REFERENCIA VISUAL (catalogo/paleta de icones).
*
* Por isso este BO NAO declara this_cTabela: inventar tabela, coluna ou SQL
* aqui violaria o PILAR 2 (schema identico) e a regra #22 do CLAUDE.md (a
* lista de colunas vem do schema, nunca de adivinhacao). O estado de negocio
* desta tela e o proprio catalogo de arquivos de icone, declarado abaixo slot
* a slot, com os nomes EXATOS transcritos do dump do legado.
*
* O comportamento padrao herdado de BusinessBase para Inserir/Atualizar/
* ExecutarExclusao (recusar a operacao e reportar pelo ExibirFalha do Salvar)
* ja e o correto para esta tela somente-leitura.
*
* Arquitetura: FormBase (UI) -> BusinessBase (BO) -> DataAccess (SQL Server)
*==============================================================================

DEFINE CLASS sigpricoBO AS BusinessBase

    *==========================================================================
    * IDENTIFICACAO DA TELA LEGADA
    *==========================================================================
    this_cTabela          = ""              && Tela sem tabela (ver cabecalho)
    this_cCampoChave      = ""              && Tela sem chave primaria
    this_cNomeFormLegado  = "SIGPRICO"      && Nome do SCX de origem
    this_cCaptionLegado   = "Form1"         && Caption EXATO do SCX legado

    *==========================================================================
    * CATALOGO DE ICONES - CONTROLE
    *==========================================================================
    this_cCursorIcones    = "cursor_4c_Icones"   && Cursor do catalogo
    this_nTotalIcones     = 24                   && Qtd de Image no SCX legado
    this_cCaminhoIcones   = ""                   && Pasta vbmp\ resolvida
    this_cPastaLegado     = "..\vbmp\"           && Prefixo original do SCX

    *==========================================================================
    * REGISTRO CORRENTE DO CATALOGO
    *==========================================================================
    this_cNomeObjeto      = ""              && Nome do Image no legado (Image1)
    this_cArquivoIcone    = ""              && Nome do arquivo (form4.ico)
    this_cCaminhoCompleto = ""              && Caminho absoluto do arquivo
    this_nIndiceAtual     = 0               && Posicao no catalogo (1..24)
    this_nTopIcone        = 0               && Top do Image no SCX legado
    this_nLeftIcone       = 0               && Left do Image no SCX legado
    this_nWidthIcone      = 18              && Width do Image no SCX legado
    this_nHeightIcone     = 17              && Height do Image no SCX legado
    this_nStretchIcone    = 2               && Stretch do Image no SCX legado
    this_lArquivoExiste   = .F.             && Arquivo presente em vbmp\

    *==========================================================================
    * RESULTADO DA ULTIMA VERIFICACAO DO CATALOGO
    *==========================================================================
    this_nIconesEncontrados = 0             && Arquivos localizados em vbmp\
    this_nIconesAusentes    = 0             && Arquivos faltando em vbmp\
    this_cListaAusentes     = ""            && Nomes ausentes, separados por PV
    this_lCatalogoCarregado = .F.           && Cursor do catalogo ja montado

    *==========================================================================
    * CATALOGO - ARQUIVO DE CADA SLOT
    *
    * Transcrito LITERALMENTE da SECAO 2 do dump do legado (propriedade
    * Picture de cada Image). O legado nao possui Image12, Image13 nem
    * Image14 - a numeracao salta de Image11 para Image15 e essa lacuna e
    * reproduzida aqui de proposito (PILAR 1).
    *==========================================================================
    this_cArqImage1  = "form4.ico"          && Image1  - Top 0   Left 0
    this_cArqImage2  = "form7.ico"          && Image2  - Top 18  Left 0
    this_cArqImage3  = "ohist.ico"          && Image3  - Top 36  Left 0
    this_cArqImage4  = "replace.ico"        && Image4  - Top 1   Left 22
    this_cArqImage5  = "tab.ico"            && Image5  - Top 1   Left 44
    this_cArqImage6  = "a_fold3.bmp"        && Image6  - Top 1   Left 67
    this_cArqImage7  = "depend3.bmp"        && Image7  - Top 1   Left 90
    this_cArqImage8  = "b_arrow4.bmp"       && Image8  - Top 24  Left 24
    this_cArqImage9  = "b_arrow2.bmp"       && Image9  - Top 24  Left 53
    this_cArqImage10 = "b_arrow3.bmp"       && Image10 - Top 24  Left 84
    this_cArqImage11 = "b_arrow1.bmp"       && Image11 - Top 24  Left 116
    this_cArqImage15 = "kuser.bmp"          && Image15 - Top 47  Left 144
    this_cArqImage16 = "form4.ico"          && Image16 - Top 71  Left 5
    this_cArqImage17 = "ohist.ico"          && Image17 - Top 94  Left 13
    this_cArqImage18 = "depend3.bmp"        && Image18 - Top 73  Left 33
    this_cArqImage19 = "envmail.bmp"        && Image19 - Top 117 Left 11
    this_cArqImage20 = "replace.ico"        && Image20 - Top 95  Left 44
    this_cArqImage21 = "server15.ico"       && Image21 - Top 121 Left 40
    this_cArqImage22 = "people1.ico"        && Image22 - Top 84  Left 96
    this_cArqImage23 = "home.ico"           && Image23 - Top 108 Left 101
    this_cArqImage24 = "search2.ico"        && Image24 - Top 134 Left 106
    this_cArqImage25 = "menu1.bmp"          && Image25 - Top 84  Left 192
    this_cArqImage26 = "x_planilha1.bmp"    && Image26 - Top 132 Left 204
    this_cArqImage27 = "msgstop1.gif"       && Image27 - Top 180 Left 240

    *==========================================================================
    * CATALOGO - NOME DO OBJETO DE CADA SLOT
    *
    * Nome do controle Image no SCX legado, na ordem de declaracao do dump.
    * E a chave logica do catalogo (o legado nao tem chave primaria de banco).
    *==========================================================================
    this_cObjImage1  = "Image1"
    this_cObjImage2  = "Image2"
    this_cObjImage3  = "Image3"
    this_cObjImage4  = "Image4"
    this_cObjImage5  = "Image5"
    this_cObjImage6  = "Image6"
    this_cObjImage7  = "Image7"
    this_cObjImage8  = "Image8"
    this_cObjImage9  = "Image9"
    this_cObjImage10 = "Image10"
    this_cObjImage11 = "Image11"
    this_cObjImage15 = "Image15"
    this_cObjImage16 = "Image16"
    this_cObjImage17 = "Image17"
    this_cObjImage18 = "Image18"
    this_cObjImage19 = "Image19"
    this_cObjImage20 = "Image20"
    this_cObjImage21 = "Image21"
    this_cObjImage22 = "Image22"
    this_cObjImage23 = "Image23"
    this_cObjImage24 = "Image24"
    this_cObjImage25 = "Image25"
    this_cObjImage26 = "Image26"
    this_cObjImage27 = "Image27"

    *--------------------------------------------------------------------------
    * INIT - Inicializa o Business Object
    *
    * NAO passa nome de tabela para o DODEFAULT: BusinessBase.Init so instancia
    * o DataAccess quando recebe tabela nao vazia, e esta tela nao tem tabela.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            *-- Tela de catalogo: sem tabela e sem chave primaria de banco
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            *-- Resolve a pasta de icones (equivale ao "..\vbmp\" do legado)
            IF TYPE("gc_4c_CaminhoIcones") = "C" AND !EMPTY(gc_4c_CaminhoIcones)
                THIS.this_cCaminhoIcones = gc_4c_CaminhoIcones
            ELSE
                THIS.this_cCaminhoIcones = ""
            ENDIF

            *-- Estado inicial do catalogo
            THIS.this_nIndiceAtual         = 0
            THIS.this_cNomeObjeto          = ""
            THIS.this_cArquivoIcone        = ""
            THIS.this_cCaminhoCompleto     = ""
            THIS.this_lArquivoExiste       = .F.
            THIS.this_nIconesEncontrados   = 0
            THIS.this_nIconesAusentes      = 0
            THIS.this_cListaAusentes       = ""
            THIS.this_lCatalogoCarregado   = .F.
            THIS.this_cMensagemErro        = ""
            THIS.this_lErroExibido         = .F.

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inicializar sigpricoBO: " + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCatalogo - Monta THIS.this_cCursorIcones com os 24 slots do SCX
    * legado (Image1..Image11, Image15..Image27 - a lacuna 12/13/14 nao existe
    * no legado e e reproduzida de proposito, PILAR 1) e confere no disco se
    * cada arquivo de vbmp\ existe (FILE()), preenchendo os contadores
    * this_nIconesEncontrados/this_nIconesAusentes/this_cListaAusentes.
    *
    * Esta e a unica "carga de dados" real desta tela: nao ha tabela (ver
    * cabecalho do arquivo), logo nao ha SQLEXEC - o catalogo e os proprios
    * properties this_cArqImageN/this_cObjImageN declarados no Init.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCatalogo()
        LOCAL loc_lSucesso, loc_oErro, loc_nI, loc_nSlot
        LOCAL loc_cArquivo, loc_cObjeto, loc_cCaminho, loc_lExiste
        LOCAL ARRAY loc_aSlot(24), loc_aTopo(24), loc_aEsquerda(24)

        loc_lSucesso = .F.

        *-- Numero do slot + Top/Left transcritos LITERALMENTE da SECAO 1
        *-- do dump do legado (tasks\task624\layout.json) - nao recalcular.
        loc_aSlot( 1) =  1
        loc_aTopo( 1) =   0
        loc_aEsquerda( 1) =   0
        loc_aSlot( 2) =  2
        loc_aTopo( 2) =  18
        loc_aEsquerda( 2) =   0
        loc_aSlot( 3) =  3
        loc_aTopo( 3) =  36
        loc_aEsquerda( 3) =   0
        loc_aSlot( 4) =  4
        loc_aTopo( 4) =   1
        loc_aEsquerda( 4) =  22
        loc_aSlot( 5) =  5
        loc_aTopo( 5) =   1
        loc_aEsquerda( 5) =  44
        loc_aSlot( 6) =  6
        loc_aTopo( 6) =   1
        loc_aEsquerda( 6) =  67
        loc_aSlot( 7) =  7
        loc_aTopo( 7) =   1
        loc_aEsquerda( 7) =  90
        loc_aSlot( 8) =  8
        loc_aTopo( 8) =  24
        loc_aEsquerda( 8) =  24
        loc_aSlot( 9) =  9
        loc_aTopo( 9) =  24
        loc_aEsquerda( 9) =  53
        loc_aSlot(10) = 10
        loc_aTopo(10) =  24
        loc_aEsquerda(10) =  84
        loc_aSlot(11) = 11
        loc_aTopo(11) =  24
        loc_aEsquerda(11) = 116
        loc_aSlot(12) = 15
        loc_aTopo(12) =  47
        loc_aEsquerda(12) = 144
        loc_aSlot(13) = 16
        loc_aTopo(13) =  71
        loc_aEsquerda(13) =   5
        loc_aSlot(14) = 17
        loc_aTopo(14) =  94
        loc_aEsquerda(14) =  13
        loc_aSlot(15) = 18
        loc_aTopo(15) =  73
        loc_aEsquerda(15) =  33
        loc_aSlot(16) = 19
        loc_aTopo(16) = 117
        loc_aEsquerda(16) =  11
        loc_aSlot(17) = 20
        loc_aTopo(17) =  95
        loc_aEsquerda(17) =  44
        loc_aSlot(18) = 21
        loc_aTopo(18) = 121
        loc_aEsquerda(18) =  40
        loc_aSlot(19) = 22
        loc_aTopo(19) =  84
        loc_aEsquerda(19) =  96
        loc_aSlot(20) = 23
        loc_aTopo(20) = 108
        loc_aEsquerda(20) = 101
        loc_aSlot(21) = 24
        loc_aTopo(21) = 134
        loc_aEsquerda(21) = 106
        loc_aSlot(22) = 25
        loc_aTopo(22) =  84
        loc_aEsquerda(22) = 192
        loc_aSlot(23) = 26
        loc_aTopo(23) = 132
        loc_aEsquerda(23) = 204
        loc_aSlot(24) = 27
        loc_aTopo(24) = 180
        loc_aEsquerda(24) = 240

        TRY
            IF USED(THIS.this_cCursorIcones)
                USE IN (THIS.this_cCursorIcones)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorIcones) ;
                (NomeObjeto C(10), Arquivo C(30), CaminhoCompleto C(200), ;
                 Existe L, Topo N(5,0), Esquerda N(5,0))

            THIS.this_nIconesEncontrados = 0
            THIS.this_nIconesAusentes    = 0
            THIS.this_cListaAusentes     = ""

            FOR loc_nI = 1 TO THIS.this_nTotalIcones
                loc_nSlot    = loc_aSlot(loc_nI)
                loc_cArquivo = EVALUATE("THIS.this_cArqImage" + TRANSFORM(loc_nSlot))
                loc_cObjeto  = EVALUATE("THIS.this_cObjImage" + TRANSFORM(loc_nSlot))

                IF !EMPTY(THIS.this_cCaminhoIcones)
                    loc_cCaminho = THIS.this_cCaminhoIcones + loc_cArquivo
                ELSE
                    loc_cCaminho = THIS.this_cPastaLegado + loc_cArquivo
                ENDIF

                loc_lExiste = FILE(loc_cCaminho)

                INSERT INTO (THIS.this_cCursorIcones) ;
                    (NomeObjeto, Arquivo, CaminhoCompleto, Existe, Topo, Esquerda) ;
                    VALUES ;
                    (loc_cObjeto, loc_cArquivo, loc_cCaminho, loc_lExiste, ;
                     loc_aTopo(loc_nI), loc_aEsquerda(loc_nI))

                IF loc_lExiste
                    THIS.this_nIconesEncontrados = THIS.this_nIconesEncontrados + 1
                ELSE
                    THIS.this_nIconesAusentes = THIS.this_nIconesAusentes + 1
                    IF EMPTY(THIS.this_cListaAusentes)
                        THIS.this_cListaAusentes = loc_cArquivo
                    ELSE
                        THIS.this_cListaAusentes = THIS.this_cListaAusentes + ";" + loc_cArquivo
                    ENDIF
                ENDIF
            ENDFOR

            SELECT (THIS.this_cCursorIcones)
            GO TOP IN (THIS.this_cCursorIcones)

            THIS.this_lCatalogoCarregado = .T.
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar o cat" + CHR(225) + "logo de " + ;
                CHR(237) + "cones: " + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lCatalogoCarregado = .F.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Copia o registro corrente de THIS.this_cCursorIcones
    * (selecionado pelo form, ex. no grid/clique do slot) para as properties
    * "registro corrente" do catalogo (padrao canonico do projeto - regra
    * #9 FORMCOR_LICOES_APRENDIDAS: SELECT (alias) antes de ler os campos,
    * nunca campo).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro, loc_cAliasAnterior

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                loc_cAliasAnterior = ALIAS()

                SELECT (par_cAliasCursor)

                THIS.this_cNomeObjeto      = TratarNulo(NomeObjeto, "")
                THIS.this_cArquivoIcone    = TratarNulo(Arquivo, "")
                THIS.this_cCaminhoCompleto = TratarNulo(CaminhoCompleto, "")
                THIS.this_lArquivoExiste   = IIF(TYPE("Existe") = "L", Existe, .F.)
                THIS.this_nTopIcone        = TratarNulo(Topo, 0)
                THIS.this_nLeftIcone       = TratarNulo(Esquerda, 0)
                THIS.this_nIndiceAtual     = RECNO(par_cAliasCursor)

                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar registro do cat" + ;
                CHR(225) + "logo: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Esta tela nao tem chave de banco (ver cabecalho);
    * a chave logica do catalogo e o NOME DO OBJETO Image no SCX legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cNomeObjeto
    ENDPROC

ENDDEFINE

