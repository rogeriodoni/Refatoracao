# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[Formsigopsat.prg] Indicador de pendencia: * Fase 3 deixou pendente

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopsat.prg):
*==============================================================================
* FORMSIGOPSAT.PRG
* Form OPERACIONAL - Integracao com o aparelho SAT-CF-e (legado SIGOPSAT.SCX)
* Herda de: FormBase
*
* O legado SIGOPSAT.SCX nao possui DataEnvironment ligado a tabela nem
* CommandButton/CommandGroup algum (dump tasks\task798\sigopsat_form_codigo_
* fonte.txt): e uma tela servidora que, ao abrir, associa a assinatura do AC
* no equipamento e entra num laco lendo os arquivos XML de requisicao
* depositados pelo PDV em <dirresta>\Req\, despachando cada comando para a
* SAT.dll e gravando o retorno em <dirresta>\Resp\. Nao ha Insert/Update/
* Delete, nao ha AddCursor nem TABLEUPDATE (ver cabecalho de sigopsatBO.prg).
*
* So 2 controles no dump (tasks\task798\layout.json): Label2 (titulo fixo,
* "Integracao com o aparelho SAT") e Label1 (rotulo de status/progresso do
* laco, Caption="" no desenho - preenchido em runtime pelo
* this_cMensagemStatus do BO, ex.: "<ESC> para interromper..."). Sem grid,
* sem Pagina Lista/Dados, sem PageFrame e sem qualquer botao CRUD.
*
* Por isso este form NAO segue o padrao Page1=Lista/Page2=Dados do CRUD:
* o nome ConfigurarPageFrame() foi preservado so por compatibilidade com o
* pipeline de migracao multi-fase (mesmo padrao documentado em
* Formsigprico.prg para OPERACIONAL flat) - nao existe PageFrame real aqui.
*
* FASE 3/8: estrutura base - DEFINE CLASS, Init(), InicializarForm() (cria o
* BO e executa a carga de conexao - as duas consultas SELECT do Init legado,
* via sigopsatBO.CarregarParametros()) e Destroy().
*
* FASE 4/8: "Grid e botoes CRUD" NAO SE APLICA - o dump do legado
* (tasks\task798\sigopsat_form_codigo_fonte.txt, comportamento.json,
* layout.json) nao declara Grid, DataEnvironment ligado a tabela nem um
* unico CommandButton/CommandGroup - "o legado SIGOPSAT nao possui
* DataEnvironment ligado a tabela nem CommandButton/CommandGroup algum" (ver
* paragrafo acima). Gerar ConfigurarPaginaLista() com grd_4c_Dados + 6
* botoes CRUD inventaria funcionalidade que o legado nao tem, violando o
* PILAR 1 (mesmo criterio documentado no cabecalho de Formsigprico.prg para
* OPERACIONAL flat sem CRUD). O que a Fase 4 entregou de verdade foi o que a
* Fase 3 deixou pendente: os 2 Labels do dump (lbl_4c_Label2 - titulo fixo,
* lbl_4c_Label1 - rotulo de status do laco) e as propriedades visuais do
* FORM que o SCX legado declara (BorderStyle/ControlBox/MaxButton/MinButton/
* KeyPreview/TitleBar/AlwaysOnTop/AutoCenter/Picture/DataSession).
*
* FASE 8/8 (esta fase): "BtnBuscarClick/BtnSalvarClick/FormParaBO/BOParaForm/
* CarregarLista/AjustarBotoesPorModo" do template generico de fase 8 TAMBEM
* NAO SE APLICAM - sao metodos de form CRUD (Lista/Dados/botoes) e o
* SIGOPSAT nao tem nenhum dos dois. O que esta fase entrega de verdade eh o
* unico comportamento real que faltava: o laco de processamento do
* lerarquivos legado (DECLARE DLL de SAT.dll, leitura de Req\, despacho para
* a DLL e gravacao em Resp\), em Lerarquivos() abaixo, chamado por Init()
* depois que InicializarForm() carrega empresa+parametros com sucesso - fiel
* a ordem do Init legado (thisform.Visible=.T. / Refresh / lerarquivos() /
* Release(), todos ANTES de qualquer Show() externo).
*
* Arquitetura: FormBase (UI) -> BusinessBase (BO) -> DataAccess (SQL Server)
*==============================================================================

DEFINE CLASS Formsigopsat AS FormBase

    *-- DataSession = 2 (dump: "DataSession = 2") - sessao privada. Seguro
    *-- aqui porque Init() chama DODEFAULT() incondicionalmente (FormBase.Init
    *-- reaplica SET DATE TO BRITISH + SET CENTURY ON - regra #9.4) e os dois
    *-- cursores de apoio (cursor_4c_Empresa/cursor_4c_Parametros) sao
    *-- criados e lidos dentro do proprio form, nunca compartilhados.
    DataSession = 2

    Width      = 417
    Height     = 147
    Caption    = "Integra" + CHR(231) + CHR(227) + "o Aparelho SAT"

    *-- Propriedades visuais do SIGOPSAT legado (Secao 2 do dump) - tela
    *-- servidora, sem barra de titulo e sem como o usuario fechar pelo X:
    *-- o encerramento eh pelo proprio laco de processamento (ESC), nao por
    *-- controle de janela.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    KeyPreview  = .T.
    TitleBar    = 0
    AlwaysOnTop = .T.
    AutoCenter  = .T.
    FontBold    = .F.

    *-- ShowWindow: FIXO na classe (READ-ONLY em runtime nesta instalacao do
    *-- VFP9 - mesma medicao registrada em Formsigprico.prg). Declarar "= 1"
    *-- aqui evita que o CorretorAutomatico (pattern #29, SHOWWINDOW_AUSENTE)
    *-- injete uma segunda declaracao na mesma DEFINE CLASS.
    ShowWindow = 1

    *-- WindowType: canonico do projeto (padrao de operacionais\). O SCX
    *-- legado nao declara WindowType, mas o modo de abertura do menu.prg
    *-- (CREATEOBJECT + variavel LOCAL + Show()) exige modal (=1) - em
    *-- modeless o Show() retorna na hora, a referencia cai e o form eh
    *-- destruido antes do usuario ver qualquer coisa.
    WindowType = 1

    *-- Business Object (integracao SAT - sem tabela, ver sigopsatBO.prg)
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
    * Em modo teste: rebaixa para modeless + invisivel, para o VFP9 -T headless
    * nao pendurar tentando exibir form modal. So WindowType aceita escrita em
    * runtime (ShowWindow eh read-only - ver comentario na declaracao da
    * classe). Mesma protecao canonica de Formsigprico.prg.
    *
    * Depois do DODEFAULT() (que executa InicializarForm() + AtualizarEstado-
    * Controles() via FormBase.Init()), reproduz o FIM do Init legado:
    *   thisform.Visible = .t.
    *   thisform.Refresh
    *   =thisform.lerarquivos()
    *   =thisform.Release()
    * nesta ordem e dentro do proprio Init - por isso AbrirFormsigopsat() em
    * menu.prg NAO chama .Show() depois do CREATEOBJECT: quando ele retorna,
    * a tela ja rodou o laco inteiro (ate ESC) e ja se liberou.
    *
    * Pulado em modo de teste/validacao de UI: o laco e INFINITO ate ESC (ou
    * ate a fila de Req\ nunca ter arquivo, o que da no mesmo em estacao sem
    * o PDV) - rodar isso no pipeline headless penduraria o VFP9 -T.
    *--------------------------------------------------------------------------
        LOCAL loc_lModoTeste

        loc_lModoTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
                         (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            THIS.WindowType = 0
            THIS.Visible    = .F.
        ENDIF

        IF !DODEFAULT()
            RETURN .F.
        ENDIF

        IF !loc_lModoTeste
            THIS.Visible = .T.
            THIS.Refresh()
            THIS.Lerarquivos()
            THIS.Release()
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Lerarquivos - laco de integracao com o aparelho SAT-CF-e. Transcricao
    * literal de SIGOPSAT.lerarquivos (tasks\task798\sigopsat_form_codigo_
    * fonte.txt:128-208), na mesma ordem:
    *
    *   1. Declara as 8 funcoes de SAT.dll (sigopsatBO.DeclararFuncoesSAT)
    *   2. Associa a assinatura do AC uma unica vez, antes do laco
    *      (sigopsatBO.AssociarAssinaturaAC)
    *   3. Arma o trap de ESC e exibe o rotulo de status
    *   4. "Do While !llParar": a cada volta, processa TODA a fila de Req\
    *      (sigopsatBO.ProcessarFilaRequisicoes) - sem pausa/DOEVENTS, igual
    *      ao legado (o legado tambem busy-loopa)
    *
    * "Set Step On" do legado (abre o debugger do VFP) e "Do pEncerrar" (ver
    * comentario perto do final) sao OMITIDOS de proposito - ver abaixo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Lerarquivos()
        LOCAL loc_lParar, loc_oErro

        loc_lParar = .F.

        THIS.this_oBusinessObject.DeclararFuncoesSAT()
        THIS.this_oBusinessObject.AssociarAssinaturaAC()

        SET ESCAPE ON
        ON ESCAPE loc_lParar = .T.

        THIS.lbl_4c_Label1.Caption = "<ESC> para interromper..."
        THIS.Refresh()

        TRY
            DO WHILE !loc_lParar
                THIS.this_oBusinessObject.ProcessarFilaRequisicoes()
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao processar integra" + CHR(231) + CHR(227) + "o SAT")
        ENDTRY

        SET ESCAPE OFF
        ON ESCAPE

        IF loc_lParar
            MsgAviso("Processamento Interrompido...", "Aten" + CHR(231) + CHR(227) + "o")
            fGravarLog("S", "SIGOPSAT", "SAIR", "Processamento Interrompido...")
            *-- Legado tambem chama "Do pEncerrar" aqui - rotina GLOBAL do
            *-- Fortyus (sig.prg/SIGFUNCS.PRG) que nao veio no acervo, e cujo
            *-- escopo real e desconhecido (nome sugere encerrar o processo/
            *-- sessao do PDV, nao so esta tela - diferente do form, que
            *-- qualquer jeito ja se libera no THIS.Release() chamado pelo
            *-- Init() logo depois desta PROCEDURE retornar). Chamar "DO
            *-- pEncerrar" sem definicao reproduziria o mesmo defeito ja
            *-- existente em Formsigtosen.prg:146/1383 (idem, sem
            *-- pencerrar.prg em utils\) - e inventar o PROCEDURE aqui seria
            *-- adivinhar um encerramento que pode ir alem desta tela, pior
            *-- do que nao fazer nada (regra #27 do CLAUDE.md).
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object e executa a carga de conexao
    * (as duas consultas do Init legado: empresa logada em SigCdEmp e
    * parametros do sistema em SigCdPac - ver sigopsatBO.CarregarParametros()).
    *
    * Em modo de teste/validacao de UI (sem gnConnHandle) a carga remota eh
    * pulada - mesmo padrao das licoes de FormCor (gb_4c_ValidandoUI) - para
    * que o form continue instanciavel sem conexao.
    *
    * Falha na carga ABORTA a abertura (loc_lSucesso = .F.), reproduzindo o
    * "Favor Reinicializar o Processo!!!" + Return .f. do Init legado: sem
    * empresa nao ha CNPJ/assinatura do AC, e sem SigCdPac nao ha diretorio
    * de onde ler a requisicao do PDV.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_lPularCarga

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigopsatBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigopsatBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.ConfigurarPageFrame()

                loc_lPularCarga = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                   (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

                IF loc_lPularCarga
                    loc_lSucesso = .T.
                ELSE
                    IF THIS.this_oBusinessObject.CarregarParametros()
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro(NVL(THIS.this_oBusinessObject.this_cMensagemErro, ;
                            "Favor Reinicializar o Processo!!!"), ;
                            "Erro ao Inicializar Formsigopsat")
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao Inicializar Formsigopsat")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador do layout. SEM PageFrame real: o
    * legado SIGOPSAT e um Form flat, sem abas e sem Pagina Lista/Dados.
    * Nome preservado so por compatibilidade com o pipeline de migracao
    * multi-fase (mesmo padrao de Formsigprico.prg) - nao existe PageFrame
    * real aqui.
    *
    * Monta o fundo (textura canonica do projeto) e os 2 Labels do dump
    * (Secao 2 de tasks\task798\sigopsat_form_codigo_fonte.txt), transcritos
    * LITERALMENTE (Top/Left/Width/Height/Font/Cor/Alignment):
    *
    *   Label2 (titulo fixo)   -> lbl_4c_Label2
    *   Label1 (status do laco, Caption="" no desenho - preenchido em
    *           runtime por THIS.Lerarquivos() com "<ESC> para
    *           interromper...", igual ao legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Textura de fundo canonica (mesma usada por FormCol/Formcrf/FormEmn
        *-- para "..\framework\imagens\new_background.jpg" do legado).
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top        = 63
            .Left       = 106
            .Width      = 205
            .Height     = 20
            .Alignment  = 2
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .BackStyle  = 0
            .BorderStyle = 0
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 234)
            .Caption    = "Integra" + CHR(231) + CHR(227) + "o com o aparelho SAT"
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top        = 114
            .Left       = 16
            .Width      = 387
            .Height     = 20
            .FontName   = "Verdana"
            .FontSize   = 8
            .FontBold   = .T.
            .BackStyle  = 0
            .BorderStyle = 0
            .ForeColor  = RGB(36, 84, 155)
            .BackColor  = RGB(255, 255, 234)
            .Caption    = ""
            .Visible    = .T.
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


### BO (C:\4c\projeto\app\classes\sigopsatBO.prg):
*==============================================================================
* sigopsatBO.prg - Business Object para Integracao do Aparelho SAT
*
* Form OPERACIONAL (SIGOPSAT.SCX) - servidor de integracao com o equipamento
* SAT-CF-e. A tela nao cadastra nada: ela le os parametros, associa a
* assinatura do AC e fica em laco lendo os arquivos XML de REQUISICAO que o
* ponto de venda deposita em <dirresta>\Req\, despachando cada comando para a
* SAT.dll e gravando o retorno em <dirresta>\Resp\.
*
* Fontes consultadas (somente leitura):
*   SigCdEmp  -> Cemps / Razas / Cgcs / Textopaf  (empresa logada, _EMPR)
*   SigCdPac  -> Dirresta                         (diretorio de integracao)
*
* Por ser tela de processamento, NAO ha tabela principal de CRUD: o legado nao
* tem Insert/Update/Delete e nao usa AddCursor/TableUpdate, por isso
* this_cTabela e this_cCampoChave ficam vazios e o comportamento padrao
* herdado de BusinessBase (recusar Inserir/Atualizar/Excluir) ja eh o correto.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS sigopsatBO AS BusinessBase

    *==========================================================================
    * EMPRESA LOGADA - legado: Select * From sigcdemp where cemps = '<_empr>'
    * (cursor crCdEmp). No sistema novo o codigo vem de
    * go_4c_Sistema.cCodEmpresa; _EMPR eh legado e nao se usa.
    *==========================================================================
    this_cCodEmpresa        = ""   && SigCdEmp.Cemps    char(3)  - codigo da empresa
    this_cRazaoEmpresa      = ""   && SigCdEmp.Razas    char(40) - razao social
    this_cCgcEmpresa        = ""   && SigCdEmp.Cgcs     char(20) - CNPJ do contribuinte
    this_cTextoPaf          = ""   && SigCdEmp.Textopaf text     - texto do ECF/PAF

    *==========================================================================
    * PARAMETROS DO SISTEMA - legado: Select dirresta From sigcdpac
    * (cursor crsigcdpac, Go Top). O diretorio de integracao eh a raiz; o
    * legado garante a barra final com
    *   lcDir = Iif(Right(lcDir,1)=[\], lcDir, lcDir + [\])
    * e deriva os dois subdiretorios Req\ (requisicoes do PDV) e Resp\
    * (respostas da SAT.dll).
    *==========================================================================
    this_cDiretorioResta      = ""   && SigCdPac.Dirresta char(80) - valor cru da coluna
    this_cDiretorioBase       = ""   && Dirresta normalizado, sempre com "\" no fim
    this_cDiretorioRequisicao = ""   && this_cDiretorioBase + "Req\"
    this_cDiretorioResposta   = ""   && this_cDiretorioBase + "Resp\"

    *==========================================================================
    * ASSOCIACAO DA ASSINATURA DO AC
    *
    * Legado (lerarquivos), executado UMA VEZ antes de entrar no laco:
    *   lcCnpjAC = ALLTRIM(SUBSTR(crCdEmp.textoPaf,  1,  14))
    *   lcAssi   = ALLTRIM(SUBSTR(crCdEmp.textoPaf, 16, 344))
    *   lnSessao = fGerUniqueKey('SAT')
    *   lcCodAti = '12345678'
    *   lcRetorno = AssociarAssinatura(lnSessao, lcCodAti, lcCnpjAC, lcAssi)
    *
    * As posicoes 1..14 e 16..359 do Textopaf sao regra de negocio do legado
    * (o CNPJ da Software House ocupa os 14 primeiros caracteres e a
    * assinatura comeca na posicao 16) - transcritas, nao recalculadas.
    *==========================================================================
    this_cCnpjAC              = ""           && SUBSTR(Textopaf, 1, 14)   - CNPJ do AC
    this_cAssinaturaAC        = ""           && SUBSTR(Textopaf, 16, 344) - assinatura do AC
    this_cCodigoAtivacao      = "12345678"   && lcCodAti - literal do legado
    this_nNumeroSessao        = 0            && fGerUniqueKey("SAT") - numerico
    this_cChaveSequencia      = "SAT"        && chave do contador em dbo.SIGSYSEQ
    this_cRetornoAssociacao   = ""           && retorno de AssociarAssinatura
    this_lAssinaturaAssociada = .F.          && .T. apos AssociarAssinatura responder

    *==========================================================================
    * BIBLIOTECA EXTERNA - DECLARE DLL de SAT.dll
    *
    * Funcoes declaradas pelo legado: AtivarSAT, EnviarDadosVenda,
    * CancelarUltimaVenda, ConsultarSAT, ConsultarNumeroSessao,
    * DesbloquearSAT, AssociarAssinatura e TesteFimAFim.
    *
    * ATENCAO para quem implementar os DECLARE: em VFP9 o DECLARE ... IN
    * "SAT.dll" NAO eh preguicoso - a biblioteca eh CARREGADA na hora do
    * DECLARE e, na estacao sem o equipamento, estoura ali mesmo com
    * "Cannot load 32-bit DLL SAT.DLL." (SAT.dll NAO esta no acervo deste
    * repositorio). Se esse bloco rodar dentro do TRY do Init, o erro cai no
    * CATCH, o Init devolve .F. e a TELA NAO ABRE.
    * Portanto: os DECLARE ficam num TRY/CATCH PROPRIO, fora do Init, e o
    * resultado eh registrado em this_lDllsDeclaradas; cada chamada a DLL
    * testa essa flag antes e, estando desligada, devolve o retorno de falha
    * que o proprio legado ja trata, em vez de abortar a abertura da tela.
    *==========================================================================
    this_cNomeDll        = "SAT.dll"   && biblioteca do fabricante do equipamento
    this_lDllsDeclaradas = .F.         && .T. so se os DECLARE DLL tiverem exito

    *==========================================================================
    * REQUISICAO CORRENTE - campos extraidos do XML de requisicao pelo legado:
    *   lcCmd    = STREXTRACT(lcTexto, '<Comando>',    '</Comando>',    1)
    *   lcsessao = STREXTRACT(lcTexto, '<Sessao>',     '</Sessao>',     1)
    *   lcFab    = STREXTRACT(lcTexto, '<Fabricante>', '</Fabricante>', 1)
    *   lcCodAti = STREXTRACT(lcTexto, '<CodAti>',     '</CodAti>',     1)
    *   lcChave  = STREXTRACT(lcTexto, '<Chave>',      '</Chave>',      1)
    *   lcXml    = STREXTRACT(lcTexto, '<Xml>',        '</Xml>',        1)
    *
    * A sessao aparece nas DUAS formas de proposito: ela chega como texto no
    * XML e o legado converte com VAL() antes de chamar a DLL, porque as
    * funcoes de SAT.dll recebem Integer numeroSessao.
    *==========================================================================
    this_cArquivoRequisicao     = ""   && caminho completo do .XML lido em Req\
    this_cArquivoResposta       = ""   && caminho completo do .XML final em Resp\
    this_cArquivoRespostaTmp    = ""   && mesmo nome com extensao .tmp, gravado antes do RENAME
    this_cConteudoRequisicao    = ""   && FILETOSTR do arquivo de requisicao
    this_cComando               = ""   && <Comando> - ConsultarSAT / EnviarDadosVenda / CancelarUltimaVenda
    this_cSessaoRequisicao      = ""   && <Sessao> como texto, direto do XML
    this_nSessaoRequisicao      = 0    && <Sessao> convertida com VAL() para a DLL
    this_cFabricante            = ""   && <Fabricante>
    this_cCodAtivacaoRequisicao = ""   && <CodAti> - codigo de ativacao vindo na requisicao
    this_cChaveCancelamento     = ""   && <Chave> - chave do CF-e a cancelar
    this_cXmlDadosVenda         = ""   && <Xml> - dados da venda ou do cancelamento
    this_cRetornoSAT            = ""   && retorno da funcao da SAT.dll

    *==========================================================================
    * ESTADO DO LACO DE PROCESSAMENTO
    *
    * Legado: Set Escape On / On Escape llParar = .T. e a mensagem
    * '<ESC> para interromper...' no Label1, exibida enquanto o laco roda.
    * Ao sair por ESC o legado avisa, grava log e encerra o processo.
    *==========================================================================
    this_lInterromper         = .F.   && llParar - ESC pedido pelo usuario
    this_lProcessando         = .F.   && .T. enquanto o laco esta ativo
    this_nArquivosNaFila      = 0     && ADIR() - quantidade de .XML em Req\
    this_nArquivosProcessados = 0     && total de requisicoes atendidas na sessao
    this_cMensagemStatus      = ""    && texto exibido no rotulo de situacao

    *==========================================================================
    * PROPRIEDADES CUSTOMIZADAS DO FORM LEGADO (SECAO 2 do dump)
    *   lnnofabr      -> numero do fabricante do equipamento
    *   parametrizado -> indica que os parametros ja foram carregados
    * A property poobjext do legado guardava objeto do cadastro de produtos e
    * poDataMgr era o fSqlConector; no sistema novo o acesso remoto eh por
    * SQLEXEC(gnConnHandle, ...), entao nenhuma das duas tem equivalente aqui.
    *==========================================================================
    this_nNumeroFabricante = 0     && lnnofabr
    this_lParametrizado    = .F.   && parametrizado

    *==========================================================================
    * ALIASES DOS CURSORES DE APOIO
    * Equivalentes aos cursores legado crCdEmp e crsigcdpac.
    *==========================================================================
    this_cCursorEmpresa    = "cursor_4c_Empresa"
    this_cCursorParametros = "cursor_4c_Parametros"

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Tela de processamento sem CRUD: this_cTabela e this_cCampoChave ficam
    * vazios de proposito (ver cabecalho do arquivo). O codigo da empresa eh
    * semeado a partir de go_4c_Sistema.cCodEmpresa, que substitui o _EMPR do
    * legado, e os literais de SAT.dll e do codigo de ativacao sao repostos
    * para que o objeto nasca utilizavel antes de qualquer carga.
    *
    * Nao ha gate por gnConnHandle: Init que devolve .F. mata o form, e o
    * objeto tem de poder ser instanciado tambem em modo de teste / validacao
    * de UI, quando nao existe conexao.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            *-- Empresa logada (substitui o _EMPR do legado)
            IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
                THIS.this_cCodEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
            ENDIF

            *-- Valores de partida transcritos do legado (lerarquivos)
            THIS.this_cCodigoAtivacao = "12345678"
            THIS.this_cChaveSequencia = "SAT"
            THIS.this_cNomeDll        = "SAT.dll"

            *-- Estado inicial do laco de processamento
            THIS.this_lInterromper         = .F.
            THIS.this_lProcessando         = .F.
            THIS.this_lDllsDeclaradas      = .F.
            THIS.this_lAssinaturaAssociada = .F.
            THIS.this_lParametrizado       = .F.
            THIS.this_nArquivosNaFila      = 0
            THIS.this_nArquivosProcessados = 0
            THIS.this_nNumeroSessao        = 0
            THIS.this_nSessaoRequisicao    = 0
            THIS.this_cMensagemStatus      = ""

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar sigopsatBO:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC


    *==========================================================================
    * CarregarParametros - carga COMPLETA do que a tela precisa para rodar
    *
    * Equivale ao Init do SIGOPSAT legado, que faz as DUAS unicas consultas
    * remotas do form e nada mais:
    *
    *   lcQuery = [Select * From sigcdemp where cemps = ']+_empr+[']
    *   If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crCdEmp]) < 1)
    *       =MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexao])
    *       Return .f.
    *   EndIf
    *   lcQuery = [Select dirresta From sigcdpac]
    *   If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crsigcdpac]) < 1)
    *       ... Return .f.
    *   EndIf
    *   Go Top In crsigcdpac
    *
    * As duas cargas sao OBRIGATORIAS e o legado aborta a abertura se qualquer
    * uma falhar: sem a empresa nao ha CNPJ nem assinatura do AC para associar
    * no equipamento, e sem o diretorio nao ha de onde ler a requisicao do PDV.
    * Por isso a falha devolve .F. com a mensagem do legado em
    * this_cMensagemErro, e quem chama decide se abre a tela.
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF THIS.CarregarEmpresa()
            IF THIS.CarregarParametrosSistema()
                loc_lResultado = .T.
            ENDIF
        ENDIF

        THIS.this_lParametrizado = loc_lResultado

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarEmpresa - 1a consulta do Init legado (cursor crCdEmp)
    *
    * Legado: Select * From sigcdemp where cemps = '<_empr>'
    * Aqui o codigo vem de go_4c_Sistema.cCodEmpresa (o _EMPR eh legado e nao
    * se usa) e sao lidas apenas as 4 colunas que a tela consome - cemps,
    * razas, cgcs e textopaf -, conferidas em docs\schema.sql:
    *   cemps    char(3)  NOT NULL (PK)
    *   razas    char(40) NOT NULL
    *   cgcs     char(20) NOT NULL
    *   textopaf text     NULL
    * O legado traz SELECT *, que arrasta tambem logos/logorels/resp_visto
    * (colunas text); restringir a lista nao muda comportamento nenhum porque
    * nenhuma outra coluna de SigCdEmp eh tocada pelo form.
    *
    * A leitura das colunas fica TODA em CarregarDoCursor() - este metodo so
    * resolve a conexao, o cursor e o posicionamento.
    *==========================================================================
    PROCEDURE CarregarEmpresa()
        LOCAL loc_lResultado, loc_cAlias, loc_cSQL, loc_nResultado, loc_oErro

        loc_lResultado = .F.
        loc_cAlias     = THIS.this_cCursorEmpresa

        *-- Empresa logada (substitui o _EMPR do legado)
        IF EMPTY(THIS.this_cCodEmpresa) AND TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
            THIS.this_cCodEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
        ENDIF

        IF EMPTY(THIS.this_cCodEmpresa)
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Empresa logada n" + CHR(227) + "o identificada."
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (" + loc_cAlias + ")"
            RETURN .F.
        ENDIF

        TRY
            *-- Alias aberto por uma carga anterior: fechar antes do SQLEXEC.
            *-- O TABLEREVERT so entra com buffering LIGADO - cursor de
            *-- SQLEXEC/CREATE CURSOR nasce com Buffering = 1 e ali o
            *-- TABLEREVERT dispara erro 1586 (regra #52).
            IF USED(loc_cAlias)
                IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                    TABLEREVERT(.T., loc_cAlias)
                ENDIF
                USE IN (loc_cAlias)
            ENDIF

            loc_cSQL = "SELECT cemps, razas, cgcs, textopaf" + ;
                       "  FROM SigCdEmp" + ;
                       " WHERE cemps = " + EscaparSQL(THIS.this_cCodEmpresa)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

            IF loc_nResultado < 1 OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o (" + loc_cAlias + ")" + CHR(13) + ;
                    CapturarErroSQL()
            ELSE
                SELECT (loc_cAlias)
                GO TOP
                IF EOF(loc_cAlias)
                    THIS.this_cMensagemErro = "Empresa [" + ALLTRIM(THIS.this_cCodEmpresa) + ;
                        "] n" + CHR(227) + "o cadastrada em SigCdEmp."
                ELSE
                    loc_lResultado = THIS.CarregarDoCursor(loc_cAlias)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar a empresa logada:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "sigopsatBO.CarregarEmpresa")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarParametrosSistema - 2a consulta do Init legado (crsigcdpac)
    *
    * Legado: Select dirresta From sigcdpac  +  Go Top In crsigcdpac
    * SigCdPac.dirresta eh char(80) NOT NULL (docs\schema.sql) e guarda a raiz
    * da integracao com o aparelho; os dois subdiretorios Req\ e Resp\ saem
    * dela em NormalizarDiretorios(), chamado por CarregarDoCursor().
    *
    * A consulta NAO leva WHERE: SigCdPac eh a tabela de parametros do sistema
    * e o legado le a PRIMEIRA linha (Go Top), sem filtro de empresa - a
    * tabela nao tem coluna de empresa (a PK eh cidchaves).
    *==========================================================================
    PROCEDURE CarregarParametrosSistema()
        LOCAL loc_lResultado, loc_cAlias, loc_cSQL, loc_nResultado, loc_oErro

        loc_lResultado = .F.
        loc_cAlias     = THIS.this_cCursorParametros

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (" + loc_cAlias + ")"
            RETURN .F.
        ENDIF

        TRY
            IF USED(loc_cAlias)
                IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                    TABLEREVERT(.T., loc_cAlias)
                ENDIF
                USE IN (loc_cAlias)
            ENDIF

            loc_cSQL = "SELECT dirresta" + ;
                       "  FROM SigCdPac"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

            IF loc_nResultado < 1 OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o (" + loc_cAlias + ")" + CHR(13) + ;
                    CapturarErroSQL()
            ELSE
                *-- Go Top In crsigcdpac do legado
                SELECT (loc_cAlias)
                GO TOP
                IF EOF(loc_cAlias)
                    THIS.this_cMensagemErro = "Par" + CHR(226) + "metros do sistema n" + ;
                        CHR(227) + "o encontrados em SigCdPac."
                ELSE
                    loc_lResultado = THIS.CarregarDoCursor(loc_cAlias)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar os par" + CHR(226) + "metros do sistema:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "sigopsatBO.CarregarParametrosSistema")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - FONTE UNICA de leitura de coluna nesta classe
    *
    * Recebe o alias posicionado e carrega as properties da linha corrente.
    * Os DOIS cursores da tela passam por aqui (cursor_4c_Empresa e
    * cursor_4c_Parametros) porque eles tem subconjuntos DISJUNTOS de colunas:
    *
    *   cursor_4c_Empresa    -> cemps / razas / cgcs / textopaf  (SigCdEmp)
    *   cursor_4c_Parametros -> dirresta                         (SigCdPac)
    *
    * Por isso CADA coluna eh lida sob o seu proprio TYPE("<alias>.<col>"):
    * sem esse guard a 2a chamada APAGARIA o que a 1a carregou. TYPE() sobre
    * alias.coluna devolve "U" quando a coluna nao existe no cursor - eh o
    * teste certo aqui, porque PEMSTATUS exige OBJETO no 1o argumento e
    * estoura com nome de alias.
    *
    * textopaf eh coluna text (memo) e chega NULL em empresa que nunca
    * cadastrou o texto do ECF/PAF: a ESTRUTURA responde TYPE() = "M" e o
    * VALOR responde VARTYPE() = "C", por isso o guard de existencia usa
    * TYPE() != "U" e a normalizacao usa NVL(..., "").
    *
    * As duas derivacoes do legado ficam no FIM deste metodo, para que nenhum
    * caminho de carga possa deixar de aplica-las.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_cTexto, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor)
            THIS.this_cMensagemErro = "Alias do cursor n" + CHR(227) + "o informado."
            RETURN .F.
        ENDIF

        loc_cAlias = ALLTRIM(par_cAliasCursor)

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        IF EOF(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + ;
                "] sem registro posicionado."
            RETURN .F.
        ENDIF

        TRY
            *------------------------------------------------------------------
            * SigCdEmp - empresa logada (cursor crCdEmp do legado)
            *------------------------------------------------------------------
            IF TYPE(loc_cAlias + ".cemps") != "U"
                THIS.this_cCodEmpresa = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cemps"), ""))
            ENDIF

            IF TYPE(loc_cAlias + ".razas") != "U"
                THIS.this_cRazaoEmpresa = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".razas"), ""))
            ENDIF

            IF TYPE(loc_cAlias + ".cgcs") != "U"
                THIS.this_cCgcEmpresa = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cgcs"), ""))
            ENDIF

            *-- textopaf: NAO levar ALLTRIM aqui. O legado recorta por POSICAO
            *-- (SUBSTR 1..14 e 16..359) e esse recorte eh feito em
            *-- ExtrairAssinaturaAC(); aparar o texto antes deslocaria as
            *-- posicoes e, com isso, o CNPJ e a assinatura do AC.
            IF TYPE(loc_cAlias + ".textopaf") != "U"
                loc_cTexto = NVL(EVALUATE(loc_cAlias + ".textopaf"), "")
                THIS.this_cTextoPaf = IIF(VARTYPE(loc_cTexto) = "C", loc_cTexto, "")
                THIS.ExtrairAssinaturaAC()
            ENDIF

            *------------------------------------------------------------------
            * SigCdPac - parametros do sistema (cursor crsigcdpac do legado)
            *------------------------------------------------------------------
            IF TYPE(loc_cAlias + ".dirresta") != "U"
                THIS.this_cDiretorioResta = NVL(EVALUATE(loc_cAlias + ".dirresta"), "")
                THIS.NormalizarDiretorios()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar do cursor [" + loc_cAlias + "]:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "sigopsatBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * NormalizarDiretorios - transcricao literal do inicio do lerarquivos
    *
    *   lcDir = Alltrim(crsigcdpac.dirresta)
    *   lcDir = Iif(Right(lcDir, 1)=[\], lcDir, lcDir + [\])
    *   lcDirReq = lcDir+[Req\]
    *   lcDirResp= lcDir+[Resp\]
    *
    * Transcrito sem guard de vazio DE PROPOSITO: com dirresta em branco o
    * legado produz "\", "\Req\" e "\Resp\" (a raiz da unidade corrente), e
    * inventar um guard aqui mudaria o comportamento da tela. Quem roda o laco
    * eh que confere a existencia do diretorio antes de varrer a fila.
    *==========================================================================
    PROCEDURE NormalizarDiretorios()
        LOCAL loc_cDir

        loc_cDir = ALLTRIM(THIS.this_cDiretorioResta)
        loc_cDir = IIF(RIGHT(loc_cDir, 1) = "\", loc_cDir, loc_cDir + "\")

        THIS.this_cDiretorioBase       = loc_cDir
        THIS.this_cDiretorioRequisicao = loc_cDir + "Req\"
        THIS.this_cDiretorioResposta   = loc_cDir + "Resp\"

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ExtrairAssinaturaAC - transcricao literal do recorte do lerarquivos
    *
    *   lcCnpjAC = ALLTRIM(SUBSTR(crCdEmp.textoPaf,1,14))
    *   lcAssi   = ALLTRIM(SUBSTR(crCdEmp.textoPaf,16,344))
    *
    * As posicoes 1..14 (CNPJ da Software House) e 16..359 (assinatura do AC)
    * sao REGRA DE NEGOCIO do legado - transcritas, nunca recalculadas. O
    * ALLTRIM eh o do legado e vem DEPOIS do SUBSTR, nao antes.
    *
    * Os guards de LEN existem porque textopaf eh coluna NULL: em empresa sem
    * o texto do ECF/PAF cadastrado o valor chega vazio e o recorte a partir
    * da posicao 16 nao tem de onde sair. Com o texto preenchido o resultado
    * eh identico ao do legado.
    *==========================================================================
    PROCEDURE ExtrairAssinaturaAC()
        LOCAL loc_cTexto

        loc_cTexto = THIS.this_cTextoPaf
        IF VARTYPE(loc_cTexto) != "C"
            loc_cTexto = ""
        ENDIF

        THIS.this_cCnpjAC = IIF(LEN(loc_cTexto) >= 1, ;
                                ALLTRIM(SUBSTR(loc_cTexto, 1, 14)), "")

        THIS.this_cAssinaturaAC = IIF(LEN(loc_cTexto) >= 16, ;
                                      ALLTRIM(SUBSTR(loc_cTexto, 16, 344)), "")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - identificacao do registro lido por esta tela
    *
    * Fica PROTECTED porque a BusinessBase ja declara assim, e metodo
    * protegido em QUALQUER nivel da heranca nao pode ser chamado de fora
    * (regra #51) - quem usa eh RegistrarAuditoria(), dentro da propria classe.
    *
    * A unica linha que esta tela identifica eh a empresa logada em SigCdEmp
    * (PK cemps, char(3)); SigCdPac eh tabela de parametro unico, lida com
    * Go Top e sem filtro. Como nao existe caminho de gravacao, este valor
    * nunca chega a ser auditado - devolve-lo mantem o contrato da base
    * coerente.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodEmpresa)
    ENDPROC

    *==========================================================================
    * DeclararFuncoesSAT - registra as assinaturas das 8 funcoes de SAT.dll.
    * Origem: topo de SIGOPSAT.lerarquivos (os 8 Declare String ... IN
    * "SAT.dll"). Chamado uma vez por Formsigopsat.Lerarquivos(), ANTES do
    * laco - exatamente onde o legado declara (DECLARE repetido e inofensivo
    * em VFP9).
    *
    * DECLARE ... IN "SAT.dll" CARREGA a biblioteca na hora (regra
    * "DECLAREDLLmataf"): nesta estacao, sem o equipamento/driver instalado,
    * SAT.dll NAO esta no acervo e o DECLARE estoura "Cannot load 32-bit DLL
    * SAT.DLL." Por isso o bloco fica em TRY/CATCH proprio, nunca dentro do
    * TRY de Init/InicializarForm - se estourasse ali, a TELA NAO ABRIRIA.
    * Com a biblioteca ausente, this_lDllsDeclaradas fica .F. e
    * DespacharComandoSAT devolve o retorno de falha sem chamar funcao
    * nenhuma (chamar funcao nao declarada faria o VFP procurar
    * <nome>.prg no PATH - regra #13).
    *==========================================================================
    PROCEDURE DeclararFuncoesSAT()
        LOCAL loc_oErro

        THIS.this_lDllsDeclaradas = .F.

        TRY
            DECLARE String AtivarSAT IN "SAT.dll" ;
                Integer par_nNumeroSessao, String par_cSubComando, ;
                String par_cCodigoAtivacao, String par_cCNPJ, Integer par_ncUF

            DECLARE String EnviarDadosVenda IN "SAT.dll" ;
                Integer par_nNumeroSessao, String par_cCodigoAtivacao, String par_cDadosVenda

            DECLARE String CancelarUltimaVenda IN "SAT.dll" ;
                Integer par_nNumeroSessao, String par_cCodigoAtivacao, ;
                String par_cChave, String par_cDadosCancelamento

            DECLARE String ConsultarSAT IN "SAT.dll" ;
                Integer par_nNumeroSessao

            DECLARE String ConsultarNumeroSessao IN "SAT.dll" ;
                Integer par_nNumeroSessao, String par_cNumeroSessaoAConsultar

            DECLARE String DesbloquearSAT IN "SAT.dll" ;
                Integer par_nNumeroSessao, String par_cCodigoAtivacao

            DECLARE String AssociarAssinatura IN "SAT.dll" ;
                Integer par_nNumeroSessao, String par_cCodigoAtivacao, ;
                String par_cCNPJs, String par_cAssinaturaCNPJs

            DECLARE String TesteFimAFim IN "SAT.dll" ;
                Integer par_nNumeroSessao, String par_cCodigoAtivacao, String par_cDadosVenda

            THIS.this_lDllsDeclaradas = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN THIS.this_lDllsDeclaradas
    ENDPROC

    *==========================================================================
    * AssociarAssinaturaAC - transcricao literal do bloco "associar assinatura
    * antes de entrar no loop" do lerarquivos legado:
    *
    *   lnSessao  = fGerUniqueKey('SAT')
    *   lcCodAti  = '12345678'
    *   lcRetorno = AssociarAssinatura(lnSessao, lcCodAti, lcCnpjAC, lcAssi)
    *
    * lcCnpjAC/lcAssi (this_cCnpjAC/this_cAssinaturaAC) ja foram extraidos de
    * SigCdEmp.textoPaf em ExtrairAssinaturaAC(), chamado por
    * CarregarDoCursor() durante CarregarEmpresa(). fGerUniqueKey() ja existe
    * em utils\functions.prg (contador persistido em dbo.SIGSYSEQ).
    *==========================================================================
    FUNCTION AssociarAssinaturaAC()
        LOCAL loc_oErro

        THIS.this_lAssinaturaAssociada = .F.

        IF !THIS.this_lDllsDeclaradas
            THIS.this_cMensagemErro = "SAT.dll n" + CHR(227) + "o dispon" + CHR(237) + ;
                "vel - assinatura do AC n" + CHR(227) + "o associada."
            RETURN .F.
        ENDIF

        TRY
            THIS.this_nNumeroSessao      = fGerUniqueKey(THIS.this_cChaveSequencia)
            THIS.this_cRetornoAssociacao = AssociarAssinatura(THIS.this_nNumeroSessao, ;
                THIS.this_cCodigoAtivacao, THIS.this_cCnpjAC, THIS.this_cAssinaturaAC)
            THIS.this_lAssinaturaAssociada = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN THIS.this_lAssinaturaAssociada
    ENDFUNC

    *==========================================================================
    * ProcessarFilaRequisicoes - UMA passada do "do while" do lerarquivos
    * legado (o "For lnPrc = 1 To lnArq" interno): varre
    * this_cDiretorioRequisicao por *.XML e processa cada um encontrado.
    * Chamado repetidamente por Formsigopsat.Lerarquivos() dentro do laco
    * ate o usuario pedir ESC - o "do while" em si fica no FORM (controla
    * ESC e o rotulo de status, que sao UI).
    *
    *   lnArq = ADir(laArq, lcDirReq + [*.XML])
    *   If (lnArq > 0)
    *       For lnPrc = 1 To lnArq ... ENDFOR
    *   endif
    *
    * Devolve a quantidade de arquivos encontrados nesta passada (0 quando a
    * fila esta vazia - continua .T. para o laco do form, igual ao legado).
    *==========================================================================
    PROCEDURE ProcessarFilaRequisicoes()
        LOCAL loc_aArquivos[1], loc_nQtd, loc_nI, loc_oErro

        loc_nQtd = 0

        TRY
            loc_nQtd = ADIR(loc_aArquivos, THIS.this_cDiretorioRequisicao + "*.XML")
            THIS.this_nArquivosNaFila = MAX(loc_nQtd, 0)

            IF loc_nQtd > 0
                FOR loc_nI = 1 TO loc_nQtd
                    THIS.ProcessarArquivoRequisicao(loc_aArquivos[loc_nI, 1])
                ENDFOR
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao varrer a fila de requisi" + CHR(231) + CHR(245) + "es SAT:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "sigopsatBO.ProcessarFilaRequisicoes")
        ENDTRY

        RETURN loc_nQtd
    ENDPROC

    *==========================================================================
    * ProcessarArquivoRequisicao - corpo do "For lnPrc = 1 To lnArq" legado:
    * le o XML de requisicao, extrai os campos, apaga a requisicao, despacha
    * o comando para a SAT.dll e grava o retorno em Resp\ (via .tmp + RENAME,
    * igual ao legado, para o PDV nunca ler um arquivo de resposta
    * parcialmente escrito).
    *
    *   lcArqResp = lcDirResp + Alltrim(laArq(lnPrc,1))
    *   lcArqRespT= Left(lcArqRespT, Len(lcArqRespT)-3) + [tmp]
    *   lcArqReq  = lcDirReq + Alltrim(laArq(lnPrc,1))
    *   lcTexto   = FileToStr(lcArqReq)
    *   lcCmd     = StrExtract(lcTexto,'<Comando>','</Comando>',1)
    *   ...
    *   Delete File &lcArqReq
    *   <despacho por lcCmd>
    *   StrToFile(lcRetorno, lcArqRespT, .f.)
    *   Rename &lcArqRespT to &lcArqResp
    *
    * PROTECTED: so o proprio ProcessarFilaRequisicoes chama este metodo.
    *==========================================================================
    PROTECTED PROCEDURE ProcessarArquivoRequisicao(par_cNomeArquivo)
        LOCAL loc_lSucesso, loc_cArqReq, loc_cArqResp, loc_cArqRespTmp, ;
              loc_cTexto, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cArqReq     = THIS.this_cDiretorioRequisicao + ALLTRIM(par_cNomeArquivo)
            loc_cArqResp    = THIS.this_cDiretorioResposta   + ALLTRIM(par_cNomeArquivo)
            loc_cArqRespTmp = LEFT(loc_cArqResp, LEN(loc_cArqResp) - 3) + "tmp"

            THIS.this_cArquivoRequisicao  = loc_cArqReq
            THIS.this_cArquivoResposta    = loc_cArqResp
            THIS.this_cArquivoRespostaTmp = loc_cArqRespTmp

            loc_cTexto                    = FILETOSTR(loc_cArqReq)
            THIS.this_cConteudoRequisicao = loc_cTexto

            THIS.this_cComando               = STREXTRACT(loc_cTexto, "<Comando>",    "</Comando>",    1)
            THIS.this_cSessaoRequisicao      = STREXTRACT(loc_cTexto, "<Sessao>",     "</Sessao>",     1)
            THIS.this_cFabricante            = STREXTRACT(loc_cTexto, "<Fabricante>", "</Fabricante>", 1)
            THIS.this_cCodAtivacaoRequisicao = STREXTRACT(loc_cTexto, "<CodAti>",     "</CodAti>",     1)
            THIS.this_cChaveCancelamento     = STREXTRACT(loc_cTexto, "<Chave>",      "</Chave>",      1)
            THIS.this_cXmlDadosVenda         = STREXTRACT(loc_cTexto, "<Xml>",        "</Xml>",        1)

            *-- lcSessao = Val(lcSessao) do legado - convertida para a DLL
            THIS.this_nSessaoRequisicao = VAL(THIS.this_cSessaoRequisicao)

            ERASE (loc_cArqReq)

            THIS.DespacharComandoSAT()

            STRTOFILE(THIS.this_cRetornoSAT, loc_cArqRespTmp, .F.)
            RENAME (loc_cArqRespTmp) TO (loc_cArqResp)

            THIS.this_nArquivosProcessados = THIS.this_nArquivosProcessados + 1
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao processar requisi" + CHR(231) + CHR(227) + "o SAT [" + ;
                    ALLTRIM(par_cNomeArquivo) + "]:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "sigopsatBO.ProcessarArquivoRequisicao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * DespacharComandoSAT - transcricao literal do despacho por comando:
    *
    *   IF lcCmd = 'ConsultarSAT'
    *       lcRetorno = ConsultarSAT(lcSessao)
    *   ENDIF
    *   IF lcCmd = 'EnviarDadosVenda'
    *       lcRetorno = EnviarDadosVenda(lcSessao, lcCodAti, lcXml)
    *   ENDIF
    *   IF lcCmd = 'CancelarUltimaVenda'
    *       lcRetorno = CancelarUltimaVenda(lcSessao, lcCodAti, lcChave, lcXml)
    *   ENDIF
    *
    * lcCodAti aqui e o da REQUISICAO (this_cCodAtivacaoRequisicao, extraido
    * do XML corrente) - NAO o literal '12345678' usado em AssociarAssinatura
    * - o legado sobrescreve a variavel dentro do laco antes de usa-la no
    * despacho. Comando nao reconhecido (nenhum dos tres IFs bate, igual ao
    * legado) deixa this_cRetornoSAT vazio. PROTECTED: so
    * ProcessarArquivoRequisicao chama este metodo.
    *==========================================================================
    PROTECTED PROCEDURE DespacharComandoSAT()
        LOCAL loc_oErro

        THIS.this_cRetornoSAT = ""

        IF !THIS.this_lDllsDeclaradas
            THIS.this_cRetornoSAT = "ERRO: SAT.dll n" + CHR(227) + "o dispon" + CHR(237) + ;
                "vel nesta esta" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF

        TRY
            DO CASE
            CASE THIS.this_cComando == "ConsultarSAT"
                THIS.this_cRetornoSAT = ConsultarSAT(THIS.this_nSessaoRequisicao)

            CASE THIS.this_cComando == "EnviarDadosVenda"
                THIS.this_cRetornoSAT = EnviarDadosVenda(THIS.this_nSessaoRequisicao, ;
                    THIS.this_cCodAtivacaoRequisicao, THIS.this_cXmlDadosVenda)

            CASE THIS.this_cComando == "CancelarUltimaVenda"
                THIS.this_cRetornoSAT = CancelarUltimaVenda(THIS.this_nSessaoRequisicao, ;
                    THIS.this_cCodAtivacaoRequisicao, THIS.this_cChaveCancelamento, ;
                    THIS.this_cXmlDadosVenda)
            ENDCASE
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            THIS.this_cRetornoSAT   = ""
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Inserir / Atualizar / ExecutarExclusao - DECISAO DE PROJETO: ficam
    * HERDADOS de BusinessBase, SEM override nesta classe.
    *
    * O SIGOPSAT eh servidor de integracao com o equipamento SAT-CF-e, nao
    * cadastro: ele nao tem tabela propria (this_cTabela e this_cCampoChave
    * ficam vazios) e nao grava linha nenhuma no SQL Server. Conferido no dump
    * legado (tasks\task798\sigopsat_form_codigo_fonte.txt):
    *
    *   - nenhum Insert Into / Update / Delete From em lugar algum do dump;
    *   - nenhum TABLEUPDATE() - nada eh comitado de volta para o banco;
    *   - nenhum .AddCursor() - nao ha bind remoto de cadastro;
    *   - o acesso remoto eh 100% SELECT, nas duas consultas do Init
    *     (sigcdemp e sigcdpac), ambas lidas acima.
    *
    * O que o legado grava eh ARQUIVO, nao banco: STRTOFILE(lcRetorno, ...)
    * em <dirresta>\Resp\ e DELETE FILE da requisicao ja atendida.
    *
    * Escrever INSERT/UPDATE aqui significaria INVENTAR tabela e lista de
    * colunas, o que a regra #22 do CLAUDE.md proibe (a lista vem do schema,
    * nunca de adivinhacao). O comportamento herdado de BusinessBase ja eh o
    * correto: Salvar() e Excluir() recusam a operacao e reportam pelo
    * ExibirFalha() (regra #20).
    *==========================================================================

ENDDEFINE

