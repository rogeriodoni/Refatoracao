# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 7/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-10-07 17:18:28] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-07 17:18:28] [INFO] Config FPW: (nao fornecido)
[2026-10-07 17:18:29] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-07 17:18:29] [INFO] Timeout: 300 segundos
[2026-10-07 17:18:29] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1ptgvpti.prg
[2026-10-07 17:18:29] [INFO] Conteudo do wrapper:
[2026-10-07 17:18:29] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrIct', 'C:\4c\tasks\task625\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrIct', 'C:\4c\tasks\task625\logs\06_testForm.log'
QUIT

[2026-10-07 17:18:30] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1ptgvpti.prg
[2026-10-07 17:18:30] [INFO] VFP output esperado em: C:\4c\tasks\task625\vfp_output.txt
[2026-10-07 17:18:30] [INFO] Executando Visual FoxPro 9...
[2026-10-07 17:18:30] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1ptgvpti.prg
[2026-10-07 17:18:31] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1ptgvpti.prg
[2026-10-07 17:18:31] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrIct
Inicio: 07/10/2026 17:18:32

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 07/10/2026 17:22:50
Duracao: 258 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-07 17:22:51] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-07 17:22:51] [INFO] VFP9 finalizado em 260.6251744 segundos
[2026-10-07 17:22:52] [INFO] Exit Code: 
[2026-10-07 17:22:52] [INFO] 
[2026-10-07 17:22:52] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-07 17:22:52] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1ptgvpti.prg
[2026-10-07 17:22:52] [INFO] 
[2026-10-07 17:22:53] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-07 17:22:53] [INFO] * Auto-generated wrapper for parameters
[2026-10-07 17:22:53] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-07 17:22:53] [INFO] * Parameters: 'FormSigPrIct', 'C:\4c\tasks\task625\logs\06_testForm.log'
[2026-10-07 17:22:53] [INFO] 
[2026-10-07 17:22:54] [INFO] * Anti-dialog protections for unattended execution
[2026-10-07 17:22:54] [INFO] SET SAFETY OFF
[2026-10-07 17:22:55] [INFO] SET RESOURCE OFF
[2026-10-07 17:22:55] [INFO] SET TALK OFF
[2026-10-07 17:22:55] [INFO] SET NOTIFY OFF
[2026-10-07 17:22:55] [INFO] SYS(2335, 0)
[2026-10-07 17:22:56] [INFO] 
[2026-10-07 17:22:56] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrIct', 'C:\4c\tasks\task625\logs\06_testForm.log'
[2026-10-07 17:22:56] [INFO] QUIT
[2026-10-07 17:22:56] [INFO] 
[2026-10-07 17:22:56] [INFO] === Fim do Wrapper.prg ===
[2026-10-07 17:22:57] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrIct.prg):
*==============================================================================
* FormSigPrIct.prg - Integracao Contabil
*
* Origem legado: SIGPRICT.SCX (task625)
* Herda de: FormBase
* Tipo: OPERACIONAL - form PLANO sem PageFrame (layout.json: cntSombra,
*       Get_DataI/Get_DataF, labels e os dois CommandGroup sao todos filhos
*       DIRETOS de SIGPRICT - nao ha Pagina.Lista/Pagina.Dados). Tela de
*       FILTRO + PROCESSAMENTO: recebe um periodo (Data Inicial/Data Final),
*       concilia o movimento financeiro do periodo contra o plano de contas
*       (SigPrIctBO.Processar, ja completo nas Fases 1/2) e grava arquivo(s)
*       texto no diretorio contabil configurado em SigCdPam.DirContabv.
*
* BO: SigPrIctBO (sem tabela/registro proprio - processo gera arquivo texto,
*     nao grava em tabela - ver nota de arquitetura no cabecalho do BO)
*
* Estrutura visual (SigPrIct_form_codigo_fonte.txt, SECAO 2):
*   cntSombra (cabecalho cinza, Top=0 Left=0 Width=800 Height=80)
*     lblSombra / lblTitulo (Caption dinamico = THIS.Caption, igual FormSigPrGf1)
*   Label2 "Inicial :" (Top=108 Left=186) / Get_DataI (Top=105 Left=227)
*   Label3 "Final :"   (Top=141 Left=191) / Get_DataF (Top=137 Left=227)
*   Label1 " Periodo "  (Top=141 Left=132) - visivel
*   Label4 " Periodo "  (Top=108 Left=132, Visible=.F. no proprio SCX - mantido
*                        oculto por fidelidade, PILAR 1 nao exige reativar o
*                        que o legado ja desativou)
*   cntBotoes (Top=-7 Left=558 Width=252 Height=96, Visible=.F. no Init) ->
*     btnReport (CommandGroup, 3 botoes: Imprimir/Sair/Visualizar - aparece
*     SOMENTE apos o processamento, equivalente ao toggle de Visible no
*     Init/Procedure do legado)
*   btnReport (CommandGroup direto no form, Top=90 Left=316, 2 botoes:
*     Processar/Encerrar - visivel desde o Init, eh o disparo do
*     processamento)
*
* Criado em: Fase 3 - Estrutura Base (DEFINE CLASS, Init, InicializarForm,
*            cabecalho). Containers de botoes criados VAZIOS (posicao/
*            visibilidade do dump), sem os CommandGroup internos.
*
* Fase 4 (esta) - ConfigurarBotoesReport() monta o CommandGroup
*            obj_4c_CmdGReport dentro de cnt_4c_Botoes (3 botoes:
*            Imprimir/Encerrar/Visualizar, posicoes RELATIVAS ao container -
*            no legado o CommandGroup ja era filho direto de cntBotoes,
*            entao os Left/Top do dump sao usados sem ajuste) e
*            ConfigurarBotoesAcao() monta obj_4c_CmdGProcessar dentro de
*            cnt_4c_BotoesAcao (2 botoes: Processar/Encerrar). ATENCAO: no
*            legado esse 2o CommandGroup era filho DIRETO de SIGPRICT
*            (Top=90 Left=316); a Fase 3 criou cnt_4c_BotoesAcao EXATAMENTE
*            nesse retangulo (Top=90 Left=316 Width=160 Height=85), logo o
*            CommandGroup dentro dele usa Top=0/Left=0 (preenche o
*            container) - os Left/Top de cada botao MEMBRO (Command1/
*            Command2) continuam os do dump, pois sao relativos ao proprio
*            grupo e nao ao form. So estrutura visual, sem BINDEVENT ainda.
*
* Roteiro das proximas fases (documentado aqui para nao divergir depois):
*   Fase 5 (esta, PARTE 1/2) - ConfigurarFiltroPeriodo() com a linha "Data
*            Inicial": lbl_4c_Label2 ("Inicial : ") + txt_4c_DataI
*            (Get_DataI) + lbl_4c_Label4 (duplicata " Periodo " oculta no
*            proprio SCX, mantida Visible=.F.)
*   Fase 6 (PARTE 2/2) - mesmo metodo, linha "Data Final": lbl_4c_Label3
*            ("Final : ") + txt_4c_DataF (Get_DataF) + lbl_4c_Label1
*            (" Periodo " visivel) + FormParaBO/BOParaForm do par de datas +
*            BINDEVENT de KeyPress dos dois TextBox (padrao
*            FormSigPrGf1.ConfigurarFiltroPeriodo) + ValidarPeriodo(), a
*            regra dos tres guards que o Click do btnReport legado aplica
*            SOBRE esses dois campos (eles sao os unicos digitaveis do SCX
*            e nao tem Valid proprio, entao a validacao deles eh entrega
*            DESTA fase - ver comentario do metodo)
*   Fase 7/8 (esta) - eventos dos dois CommandGroup:
*            obj_4c_CmdGProcessar: BtnProcessarClick (ValidarPeriodo() +
*              confirma + this_oBusinessObject.Processar() + AposProcessar(),
*              que mostra o grupo obj_4c_CmdGReport quando ha inconsistencia
*              ou grava o arquivo direto quando nao ha) / BtnEncerrarClick
*              (fecha o form).
*            obj_4c_CmdGReport: BtnImprimirClick/BtnVisualizarClick (monta os
*              cursores de nome literal "SemConta"/"Cabecalho" que o
*              SigPrIct.frx exige - PrepararCursoresRelatorio() - executa o
*              REPORT FORM via ExecutarReportForm() e grava o arquivo em
*              seguida) / BtnEncerrarReportClick (grava o arquivo e fecha,
*              reproduzindo o Click do botao MAIS o Click do grupo do
*              legado - ver comentario do metodo).
*            GravarArquivoContabil() reproduz a parte de UI do PROCEDURE
*              gravar legado (a parte de negocio mora no BO,
*              GravarArquivosContabeis - Fase 2).
*
*   Fase 8 (esta) - eventos AUXILIARES e consolidacao. O que faltava era UM
*            passo de UI do PROCEDURE processamento legado, perdido na
*            migracao: o dialogo das DIFERENCAS e o despacho para a tela
*            SigReDif. O BO ja calculava this_lPossuiDiferenca/
*            this_nTotalDiferencas (VerificarDiferencas) e ja expunha
*            ObterCursorDiferencas()/ObterCursorMovimento() - e NENHUM ponto
*            do Form consumia os quatro, superficie de BO morta sendo o
*            proprio sintoma. Entregas:
*              ExibirDiferencas()           - "If Reccount() > 0 And
*                Messagebox('Visualizar as diferencas na Tela?',4+32,
*                'Visualizar') = 6 / Do Form SigReDif With
*                Thisform.DataSessionId", chamado no INICIO de
*                AposProcessar() porque no legado ele vem ANTES do ramo
*                SemConta. Monta os alias de contrato que
*                SigReDifBO.PrepararDados exige por nome LITERAL (movaux e
*                dif2) e abre FormSigReDif(THIS.DataSessionId) com o Show()
*                FORA do TRY (regra #29, form modal).
*              LiberarCursoresDiferencas()  - fecha movaux/dif2/crGrid; usado
*                antes de montar, depois do Show() e em Destroy().
*
* NAO possui CarregarLista()/AjustarBotoesPorModo()/HabilitarCampos()/
* LimparCampos()/BtnSalvarClick()/BtnCancelarClick()/BtnBuscarClick(): o
* dump legado nao tem lista, nao tem grade, nao tem os modos LISTA/INCLUIR/
* ALTERAR/VISUALIZAR e nao grava registro em tabela nenhuma (mesma decisao
* de projeto registrada em FormSigPrGf1 - criar esses metodos aqui produziria
* casca vazia sem correspondente no legado, que a regra de completude
* proibe).
*==============================================================================

DEFINE CLASS FormSigPrIct AS FormBase

    *-- Propriedades visuais (pixel-perfect do SCX original - PILAR 1)
    *-- SIGPRICT.SCX: Width=800, Height=192 (SECAO 2) - dialogo de
    *-- filtro/processamento, sem necessidade de escalar para o canonico
    *-- 1000x600 (esse canonico vale para forms CRUD frmcadastro).
    Width        = 800
    Height       = 192
    AutoCenter   = .T.
    Caption      = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    BorderStyle  = 2
    ClipControls = .F.

    *-- DataSession = 2 transcrito do SCX ("DataSession = 2" nas PROPRIEDADES
    *-- DE SIGPRICT). Isola os cursores desta tela (cursor_4c_MovAux,
    *-- cursor_4c_Grupos, cursor_4c_SemConta, etc. - todos criados pelo BO em
    *-- PrepararCursoresProcesso) da sessao compartilhada de outras telas.
    DataSession  = 2

    *-- Guarda de reentrancia do botao Processar (Fase 7/8). O BO exibe
    *-- fwprogressbar durante ConciliarMovimento(), e cada Update()/Refresh()
    *-- devolve a vez ao VFP: sem este guard um segundo clique em Processar
    *-- entraria em BtnProcessarClick com o primeiro processamento ainda
    *-- rodando, disputando os mesmos cursores (cursor_4c_MovAux/SemConta/...).
    this_lProcessando = .F.

    *-- WindowType = 1 eh canonico do projeto, NAO transcricao: o SCX herda o
    *-- default 0 (modeless) do baseclass form, mas o menu.prg abre a tela com
    *-- CREATEOBJECT + variavel LOCAL + Show(), e com modeless o Show()
    *-- retorna na hora, a LOCAL sai de escopo e o form eh destruido (pisca e
    *-- some) - mesmo raciocinio de FormSigPrGf1.

    *==========================================================================
    * Init - Sem parametros recebidos do chamador (form aberto direto pelo
    * menu, popMovimentos). DODEFAULT() encadeia para FormBase.Init(), que
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o BO e monta a estrutura visual (cabecalho
    * + os dois containers de botoes, cada um com seu CommandGroup interno -
    * ConfigurarBotoesReport/ConfigurarBotoesAcao, Fase 4).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrIctBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.Picture = gc_4c_CaminhoIcones + "fundo_cadastro.jpg"

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)
                THIS.Visible = .T.

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigPrIctBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "FormSigPrIct.InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrIct.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRICT nao tem
    * PageFrame no legado (layout flat) - o nome do metodo eh mantido apenas
    * como ponto de entrada arquitetural padrao (mesmo papel em
    * FormSigPrGf1/FormFop/FormEnd).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarContainerBotoesReport()
        THIS.ConfigurarContainerBotoesAcao()
        THIS.ConfigurarFiltroPeriodo()

        *-- Reposicionamento do Init legado - so passa a importar a partir
        *-- desta fase, que implementa o show/hide de cnt_4c_Botoes (Fase 7/8):
        *--     .cntBotoes.Top  = ThisForm.btnReport.Top  + 60
        *--     .cntBotoes.Left = ThisForm.btnReport.Left - 69
        *-- "ThisForm.btnReport" (o CommandGroup Processar/Encerrar) eh
        *-- THIS.cnt_4c_BotoesAcao aqui (o container ocupa o MESMO retangulo
        *-- do CommandGroup legado - ver ConfigurarContainerBotoesAcao).
        *-- cnt_4c_Botoes continua Visible = .F.; isto so prepara a posicao de
        *-- repouso para quando AposProcessar() o mostrar.
        THIS.cnt_4c_Botoes.Top  = THIS.cnt_4c_BotoesAcao.Top  + 60
        THIS.cnt_4c_Botoes.Left = THIS.cnt_4c_BotoesAcao.Left - 69
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza escuro com titulo do form.
    * Original: cntSombra Top=0, Left=0, Width=800, Height=80,
    * BackColor=RGB(100,100,100) (SECAO 2) - copiado sem escala, pois
    * THIS.Width ja eh 800 (identico ao legado).
    *
    * lblSombra/lblTitulo no dump trazem Caption="Cadastro de Testes" (texto
    * generico de template, nao atualizado pelo legado para este form
    * especifico) - por isso, igual a FormSigPrGf1, o Caption real eh
    * atribuido em runtime a partir de THIS.Caption (InicializarForm), nunca
    * o literal do dump.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCnt = THIS.cnt_4c_Sombra
            WITH loc_oCnt
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCnt.lbl_4c_LblSombra
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
                .Top           = 0
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .AutoSize   = .F.
                .Caption    = THIS.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 3
                .Width      = 769
                .ForeColor  = RGB(255, 255, 255)
                .Visible    = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarContainerBotoesReport - Container equivalente ao cntBotoes
    * legado (Top=-7, Left=558, Width=252, Height=96, BackStyle=0,
    * BorderWidth=0, Visible=.F. - SECAO 2). No legado ele hospeda o
    * CommandGroup btnReport (3 botoes: Imprimir/Sair/Visualizar), que so
    * aparece DEPOIS do processamento (Procedure Gravar faz
    * ThisForm.cntBotoes.Visible = .t. - essa troca de Visible fica para a
    * Fase 7/8, junto com BtnProcessarClick). Aqui (Fase 4) o container
    * continua Visible=.F. e ganha o CommandGroup obj_4c_CmdGReport, ja
    * configurado por dentro.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerBotoesReport()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Botoes", "Container")
            WITH THIS.cnt_4c_Botoes
                .Top         = -7
                .Left        =  542
                .Width       = 252
                .Height      = 96
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .F.
            ENDWITH

            THIS.ConfigurarBotoesReport()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainerBotoesReport")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesReport - CommandGroup obj_4c_CmdGReport, filho de
    * cnt_4c_Botoes. Transcrito de SIGPRICT.cntBotoes.btnReport (SECAO 2):
    * ButtonCount=3, AutoSize=.T., BackStyle=0, BorderStyle=0,
    * SpecialEffect=1, BorderColor=RGB(136,189,188), Height=85, Left=12,
    * Top=5, Width=235. Left/Top sao RELATIVOS a cnt_4c_Botoes (no legado o
    * CommandGroup ja era filho direto do container) - nao ha offset a
    * aplicar. Icones de vbmp\ via gc_4c_CaminhoIcones (regra #25 - nomes
    * EXATOS do dump, nunca inventados).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesReport()
        WITH THIS.cnt_4c_Botoes
            .AddObject("obj_4c_CmdGReport", "CommandGroup")
            .Visible     = .T.
        ENDWITH

        WITH THIS.cnt_4c_Botoes.obj_4c_CmdGReport
            .ButtonCount   = 3
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Top           = 5
            .Left          = 12
            .Width         = 235
            .Height        = 85
            .Value         = 1

            WITH .Buttons(1)
                .Top            = 5
                .Left           = 80
                .Width          = 75
                .Height         = 75
                .FontName       = "Tahoma"
                .FontSize       = 8
                .FontBold       = .T.
                .FontItalic     = .T.
                .WordWrap       = .T.
                .PicturePosition = 13
                .Picture        = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .Caption        = "\<Impressora"
                .ForeColor      = RGB(90, 90, 90)
                .BackColor      = RGB(255, 255, 255)
                .Themes         = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 155
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "\<Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH

            WITH .Buttons(3)
                .Top            = 5
                .Left           = 5
                .Width          = 75
                .Height         = 75
                .FontName       = "Tahoma"
                .FontSize       = 8
                .FontBold       = .T.
                .FontItalic     = .T.
                .WordWrap       = .T.
                .PicturePosition = 13
                .Picture        = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .Caption        = " \<Video    "
                .ForeColor      = RGB(90, 90, 90)
                .BackColor      = RGB(255, 255, 255)
                .Themes         = .F.
            ENDWITH
        ENDWITH

        *-- Eventos (Fase 7/8) - um handler por botao, igual ao dump legado
        *-- (Command1/btnImprimir, Command2/btnSair, Command3/btnVisualizar
        *-- tem Click PROPRIO, diferente um do outro).
        BINDEVENT(THIS.cnt_4c_Botoes.obj_4c_CmdGReport.Buttons(1), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cnt_4c_Botoes.obj_4c_CmdGReport.Buttons(2), "Click", THIS, "BtnEncerrarReportClick")
        BINDEVENT(THIS.cnt_4c_Botoes.obj_4c_CmdGReport.Buttons(3), "Click", THIS, "BtnVisualizarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarContainerBotoesAcao - No legado, o segundo CommandGroup
    * btnReport (2 botoes: Processar/Encerrar, Top=90 Left=316 Width=160
    * Height=85 - SECAO 2) eh filho DIRETO de SIGPRICT, sem container
    * proprio. Aqui ele ganha um container fino (cnt_4c_BotoesAcao) na MESMA
    * posicao/tamanho do CommandGroup legado, para manter o padrao do
    * projeto de "um container por grupo de botoes".
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerBotoesAcao()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH THIS.cnt_4c_BotoesAcao
                .Top         = 90
                .Left        = 316
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            THIS.ConfigurarBotoesAcao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainerBotoesAcao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - CommandGroup obj_4c_CmdGProcessar, filho de
    * cnt_4c_BotoesAcao. Transcrito de SIGPRICT.btnReport (SECAO 2):
    * ButtonCount=2, AutoSize=.T., BackStyle=0, BorderStyle=0,
    * SpecialEffect=1, BorderColor=RGB(136,189,188), Width=160, Height=85.
    * No legado esse CommandGroup era filho DIRETO do form (Top=90
    * Left=316); como cnt_4c_BotoesAcao foi criado EXATAMENTE nesse
    * retangulo (ConfigurarContainerBotoesAcao), o grupo aqui usa Top=0/
    * Left=0 para preencher o container - os Left/Top de Buttons(1)/
    * Buttons(2) sao relativos ao GRUPO (nao ao form) e continuam os do
    * dump, sem ajuste.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        WITH THIS.cnt_4c_BotoesAcao
            .AddObject("obj_4c_CmdGProcessar", "CommandGroup")
            .Visible     = .T.
        ENDWITH

        WITH THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar
            .ButtonCount   = 2
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Top           = 0
            .Left          = 0
            .Width         = 160
            .Height        = 85
            .Value         = 1

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption    = "\<Processar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Width      = 75
                .Height     = 75
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
        ENDWITH

        *-- Eventos (Fase 7/8)
        BINDEVENT(THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar.Buttons(1), "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar.Buttons(2), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarFiltroPeriodo - Campos de filtro de periodo (Fase 5/8 - PARTE
    * 1/2). Filhos DIRETOS de THIS (SIGPRICT e form PLANO, sem PageFrame -
    * layout.json confirma parent="SIGPRICT" para os quatro objetos desta
    * linha e da linha irma).
    *
    * PARTE 1 (esta fase) - linha "Data Inicial" (Top original 105/108),
    * dump SECAO 2:
    *   Label2    Top=108 Left=186 Width=39 Caption="Inicial : " -> lbl_4c_Label2
    *   Get_DataI Top=105 Left=227 TabIndex=1 (fweditdata)       -> txt_4c_DataI
    *   Label4    Top=108 Left=132 Width=51 Caption=" Per" + CHR(237) + "odo "
    *             Visible=.F. NO PROPRIO SCX (duplicata oculta do Label1 da
    *             linha "Data Final") -> lbl_4c_Label4, MANTIDO OCULTO por
    *             fidelidade (regra do projeto: nao reativar o que o legado ja
    *             desativou). TornarControlesVisiveis tem excecao explicita
    *             para este nome (ver abaixo), senao o laco forcaria
    *             Visible=.T. e o duplicado apareceria sobre a linha errada.
    *
    * PARTE 2 (Fase 6, esta) - linha "Data Final" (Label3/Get_DataF) +
    * Label1 (" Periodo " visivel, irmao do Label4 oculto desta parte) +
    * FormParaBO/BOParaForm do par de datas + BINDEVENT de KeyPress dos dois
    * TextBox - igual ao padrao de FormSigPrGf1.ConfigurarFiltroPeriodo
    * (operacoes/FormSigPrGf1.prg), citado nesta mesma funcao.
    *
    * Label3 "Final : " (Top=141 Left=191 Width=34) e Label1 " Periodo "
    * (Top=141 Left=132 Width=51, Visible=.T. no dump - irmao visivel do
    * Label4 oculto da linha "Data Inicial") sao transcritos da SECAO 2.
    * txt_4c_DataF usa o MESMO Width/Height/Alignment/InputMask/Format de
    * txt_4c_DataI (fweditdata, mesma analogia de FormSigPrGf1 - nao vem no
    * dump porque a classe eh do framework.vcx, nao extraido).
    *
    * BO (SigPrIctBO) ja expoe this_dDataI/this_dDataF (Init os preenche com
    * DATE()/DATE() - CLAUDE.md regra #16: ConverterParaData() em vez de
    * TTOD(), porque o .Value do TextBox pode chegar como DATE/DATETIME/CHAR
    * conforme o caminho). FormParaBO/BOParaForm sao a UNICA via de leitura/
    * escrita dessas properties - ValidarPeriodo() (abaixo, desta fase) e
    * Processar() (Fase 7/8) leem exclusivamente do BO, nunca do TextBox
    * direto (PILAR 3: fonte unica da regra); quem espelha a tela no BO
    * antes de validar eh o proprio ValidarPeriodo().
    *
    * Width/Height de txt_4c_DataI (79x25), Alignment=3, InputMask="99/99/9999"
    * e Format="K" nao vem do dump (fweditdata herda do framework.vcx, que nao
    * foi extraido) - transcritos por analogia de FormSigPrGf1, que usa a
    * MESMA classe fweditdata para o mesmo papel (par de datas de filtro de
    * periodo em form OPERACIONAL flat). .Value = {} (DATE) e nao {^1900-01-01}
    * -  TextBox nasce vazio, igual ao Get_DataI legado antes do Init popular
    * (regra ConverterParaData/TTOD-so-aceita-DATETIME sera aplicada na Fase 6,
    * quando FormParaBO/BOParaForm lerem/gravarem a property do BO).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltroPeriodo()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .Top       = 108
                .Left      = 186
                .Width     = 39
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Inicial : "
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DataI", "TextBox")
            WITH THIS.txt_4c_DataI
                .Top       = 105
                .Left      = 227
                .Width     = 79
                .Height    = 25
                .FontName  = "Tahoma"
                .FontSize  = 8
                .TabIndex  = 1
                .Alignment = 3
                .Themes    = .F.
                .InputMask = "99/99/9999"
                .Format    = "K"
                .Value     = {}
                .Visible   = .T.
            ENDWITH

            *-- Label4: duplicata de " Periodo " oculta no proprio SCX legado
            *-- (Visible=.F. - SECAO 2). Criado aqui so para paridade de
            *-- objetos (PILAR 2/3 nao exige objeto a mais, mas a regra do
            *-- projeto de nao reativar o que o legado desativou vale tambem
            *-- no sentido inverso: o objeto existe no dump, entao existe no
            *-- migrado, so que permanece oculto).
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .Top       = 108
                .Left      = 132
                .Width     = 51
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = " Per" + CHR(237) + "odo "
                .Visible   = .F.
            ENDWITH

            *-- Linha "Data Final" (Fase 6 - PARTE 2/2)
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .Top       = 141
                .Left      = 191
                .Width     = 34
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Final : "
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DataF", "TextBox")
            WITH THIS.txt_4c_DataF
                .Top       = 137
                .Left      = 227
                .Width     = 79
                .Height    = 25
                .FontName  = "Tahoma"
                .FontSize  = 8
                .TabIndex  = 2
                .Alignment = 3
                .Themes    = .F.
                .InputMask = "99/99/9999"
                .Format    = "K"
                .Value     = {}
                .Visible   = .T.
            ENDWITH

            *-- Label1: " Periodo " - irmao VISIVEL do Label4 oculto da linha
            *-- "Data Inicial" (ver comentario do metodo). Visible=.T. no
            *-- proprio dump (SECAO 2 nao declara Visible = .F. para ele).
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .Top       = 141
                .Left      = 132
                .Width     = 51
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .Alignment = 0
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = " Per" + CHR(237) + "odo "
                .Visible   = .T.
            ENDWITH

            *-- Carga inicial dos dois campos a partir do BO (Init do
            *-- SigPrIctBO preenche this_dDataI/this_dDataF com DATE()/DATE(),
            *-- equivalente a "Get_Datai.Value = Date() / Get_Dataf.Value =
            *-- Date()" do Init legado). O .Value = {} acima eh so para o
            *-- controle nascer tipado DATE antes do BOParaForm preencher.
            THIS.BOParaForm()

            *-- Eventos dos campos de periodo. BINDEVENT em "KeyPress" (nunca
            *-- "Valid", que nao dispara de forma confiavel em TextBox, nem
            *-- "LostFocus", que dispara tambem quando outro controle recebe o
            *-- foco). Os handlers apenas SINCRONIZAM o valor digitado com as
            *-- properties do BO - o legado tambem nao valida campo a campo
            *-- (nem Get_DataI nem Get_DataF tem Valid no SCX; os tres guards
            *-- do periodo rodam de uma vez em THIS.ValidarPeriodo(), que a
            *-- Fase 7/8 chama do Click do botao Processar, igual ao legado).
            BINDEVENT(THIS.txt_4c_DataI, "KeyPress", THIS, "DataIKeyPress")
            BINDEVENT(THIS.txt_4c_DataF, "KeyPress", THIS, "DataFKeyPress")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltroPeriodo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * DataIKeyPress / DataFKeyPress - handlers de KeyPress dos dois campos de
    * periodo, ligados por BINDEVENT (logo PUBLIC - metodo PROTECTED falha em
    * silencio, CLAUDE.md regra #3). LPARAMETERS obrigatorio: sem ele o VFP9
    * estoura "No PARAMETER statement is found" na primeira tecla digitada.
    *
    * Nao validam nem exibem mensagem - o legado nao tem Valid em Get_DataI
    * nem Get_DataF, e antecipar a mensagem aqui divergiria do PILAR 1 (ao
    * sair da Data Inicial com a Final ainda vazia o usuario receberia "Data
    * Final Invalida!!!" que o legado nunca exibe nesse momento). Ao
    * confirmar o campo (ENTER/TAB) so espelham o valor nas properties do
    * BO, que eh de onde ValidarPeriodo() e Processar() leem o periodo.
    *==========================================================================
    PROCEDURE DataIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.FormParaBO()
        ENDIF
    ENDPROC

    PROCEDURE DataFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.FormParaBO()
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - transporta o par de datas da TELA para this_dDataI/
    * this_dDataF no BO. Este form tem exatamente DOIS campos editaveis (o
    * periodo de processamento), logo o FormParaBO cobre os dois e nada mais.
    *
    * ConverterParaData() em vez de TTOD(): o .Value nasce DATE (BOParaForm o
    * preenche a partir do BO) mas pode chegar como DATETIME ou CHAR conforme
    * o que o usuario digitar - TTOD() com DATE dispara erro 11 em runtime
    * (CLAUDE.md regra #16).
    *
    * PROTECTED explicito: FormBase declara "PROTECTED PROCEDURE FormParaBO()"
    * / "PROTECTED PROCEDURE BOParaForm()", e em VFP9 redeclarar na subclasse
    * SEM o modificador NAO alarga o escopo herdado (mesma armadilha da regra
    * do metodo PROTECTED/BINDEVENT). Nao ha perda: os dois sao chamados so
    * de dentro da classe (ConfigurarFiltroPeriodo, DataIKeyPress,
    * DataFKeyPress), e nenhum deles esta na lista de metodos que o
    * TesteAutomatico.prg invoca de fora.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_dDataI = ;
                ConverterParaData(THIS.txt_4c_DataI.Value)
            THIS.this_oBusinessObject.this_dDataF = ;
                ConverterParaData(THIS.txt_4c_DataF.Value)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - caminho inverso: joga this_dDataI/this_dDataF do BO nos
    * dois campos. Usado na carga inicial (ConfigurarFiltroPeriodo), onde o
    * periodo default eh a data de hoje nos dois campos (SigPrIctBO.Init
    * espelhando "Get_Datai.Value = Date() / Get_Dataf.Value = Date()" do
    * Init legado). O Form NAO recalcula - le do BO (PILAR 3: fonte unica).
    *
    * PROTECTED pelo mesmo motivo do FormParaBO acima.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.txt_4c_DataI.Value = ;
                ConverterParaData(THIS.this_oBusinessObject.this_dDataI)
            THIS.txt_4c_DataF.Value = ;
                ConverterParaData(THIS.this_oBusinessObject.this_dDataF)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarPeriodo - TRANSCRICAO dos tres guards que o legado escreveu no
    * Click do btnReport (SigPrIct_form_codigo_fonte.txt: SIGPRICT.btnReport
    * PROCEDURE Click, e o Click identico de SIGPRICT.cntBotoes.btnReport):
    *
    *     If Empty(ThisForm.Get_DataI.value)
    *         Messagebox('Data Inicial Invalida!!!',0+48,'')
    *         ThisForm.Get_DataI.SetFocus
    *         Return 0
    *     Endif
    *     If Empty(ThisForm.Get_DataF.value)
    *         Messagebox('Data Final Invalida!!!',0+48,'')
    *         ThisForm.Get_DataF.SetFocus
    *         Return 0
    *     Endif
    *     If ThisForm.Get_DataF.value < ThisForm.Get_DataI.value
    *         Messagebox('A Data Final Nao Pode Ser Menor Que a Inicial!!!', 0+48, '')
    *         ThisForm.Get_DataF.SetFocus
    *         Return 0
    *     Endif
    *
    * Esta eh a regra dos DOIS campos digitaveis que esta fase entrega:
    * Get_DataI/Get_DataF sao os UNICOS controles de entrada do SCX (SECAO 2
    * lista 2 textbox, 6 label e 2 commandgroup) e o dump NAO tem Valid, When
    * nem LostFocus em nenhum dos dois - toda a validacao do periodo mora no
    * Click do botao. Por isso o metodo nasce JUNTO com os campos, e nao na
    * fase dos botoes: a Fase 7/8 apenas CHAMA
    * (BtnProcessarClick -> IF !THIS.ValidarPeriodo() / RETURN), sem
    * reescrever a regra.
    *
    * A regra em si vive no BO (SigPrIctBO.ValidarPeriodo, Fase 2), que ja
    * carrega os tres testes na MESMA ordem e as tres mensagens EXATAS do
    * legado em this_cMensagemErro - fonte unica (PILAR 3). O Form faz as
    * tres coisas que o BO nao pode fazer: espelhar a tela nas properties,
    * exibir a mensagem e devolver o foco ao campo recusado.
    *
    * FormParaBO() ANTES de validar: no legado os tres guards leem
    * "ThisForm.Get_DataI.value" / "Get_DataF.value", isto eh, o TEXTBOX eh a
    * fonte do valor - nunca a property guardada de um estado anterior (regra
    * do textbox visivel como fonte unica). Sem este espelho, limpar o campo
    * na tela e acionar Processar validaria o periodo ANTIGO, que o usuario
    * acabou de apagar.
    *
    * MsgAviso (nao MsgErro): os tres casos sao validacao de UI, e o legado
    * usa Messagebox(..., 0+48, ...) - icone de aviso. Chamado SEM titulo, o
    * MsgAviso usa "Atencao", equivalente ao titulo vazio do legado.
    *
    * SetFocus espelhando o legado: o 1o guard devolve o foco a Data Inicial;
    * o 2o e o 3o devolvem a Data Final. Como o BO testa a Data Inicial
    * primeiro, "Data Inicial vazia" eh o UNICO caso em que txt_4c_DataI
    * esta vazio - dai o IF EMPTY() reproduzir exatamente os tres destinos.
    *
    * PUBLIC (sem PROTECTED): sera chamado de FORA da classe pelos handlers
    * de botao da Fase 7/8 e pelo harness de teste; metodo PROTECTED falha em
    * silencio nesse uso (CLAUDE.md regra #3), e PEMSTATUS nao protege porque
    * so verifica existencia, nao escopo.
    *
    * RETURN unico, DEPOIS do ENDTRY (CLAUDE.md regra #1 - RETURN dentro de
    * TRY/CATCH eh proibido, inclusive o bare).
    *==========================================================================
    PROCEDURE ValidarPeriodo()
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Tela -> BO: o TextBox eh a fonte do valor, igual ao legado
                THIS.FormParaBO()

                IF THIS.this_oBusinessObject.ValidarPeriodo()
                    loc_lValido = .T.
                ELSE
                    *-- Mensagem EXATA do legado, montada pelo BO
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro)

                    IF EMPTY(THIS.txt_4c_DataI.Value)
                        THIS.txt_4c_DataI.SetFocus()
                    ELSE
                        THIS.txt_4c_DataF.SetFocus()
                    ENDIF
                ENDIF
            ELSE
                MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel para validar o per" + ;
                    CHR(237) + "odo.", "Integra" + CHR(231) + CHR(227) + ;
                    "o Cont" + CHR(225) + "bil")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ValidarPeriodo")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - evento do botao "Processar" (obj_4c_CmdGProcessar,
    * Buttons(1)). Legado (SIGPRICT.btnReport.Click, ramo This.Value <> 2 -
    * os tres guards de periodo ja saem via ValidarPeriodo(), Fase 5/6):
    *
    *     If Messagebox('Confirma o Processamento ?', 4+32+256, '') = 6
    *         ThisForm.Processamento
    *     Else
    *         Return 0
    *     EndIf
    *
    * this_oBusinessObject.Processar() ja encapsula TODO o Processamento
    * legado (Fases 1/2); aqui so resta confirmar e despachar o resultado
    * para AposProcessar(), que reproduz o fecho do metodo legado (mostrar o
    * grupo de relatorio OU gravar direto, conforme haja inconsistencia).
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oErro

        IF THIS.this_lProcessando
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + "o dispon" + ;
                CHR(237) + "vel.", "Erro em FormSigPrIct.BtnProcessarClick")
            RETURN
        ENDIF

        IF !THIS.ValidarPeriodo()
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma o Processamento ?")
            RETURN
        ENDIF

        TRY
            THIS.this_lProcessando = .T.
            THIS.MousePointer      = 11
            THIS.Refresh()

            IF THIS.this_oBusinessObject.Processar()
                THIS.AposProcessar()
            ENDIF

            THIS.MousePointer      = 0
            THIS.this_lProcessando = .F.
        CATCH TO loc_oErro
            THIS.MousePointer      = 0
            THIS.this_lProcessando = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AposProcessar - fecho do PROCEDURE processamento legado:
    *
    *     Select SemConta / Set Order to Conta / Go Top
    *     If Not Eof()
    *         ThisForm.cntBotoes.Top     = ThisForm.btnReport.Top - 2
    *         ThisForm.btnReport.Enabled = .F.
    *         ThisForm.Get_Datai.Enabled = .F.
    *         ThisForm.Get_Dataf.Enabled = .F.
    *         ThisForm.cntBotoes.Visible = .T.
    *     Else
    *         Select MovAux / Go Top
    *         If !Eof()
    *             Messagebox('Nenhuma Inconsistencia Foi Encontrada!!!', 32, 'ATENCAO')
    *         Else
    *             Messagebox('Nao Existe Movimentacao no Periodo!!!', 32, 'ATENCAO')
    *         Endif
    *         ThisForm.Gravar
    *     Endif
    *
    * "ThisForm.btnReport" (o grupo Processar/Encerrar) eh
    * THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar; "ThisForm.cntBotoes" eh
    * THIS.cnt_4c_Botoes. this_lPossuiInconsistencia/this_lPossuiMovimento
    * sao a FONTE UNICA (BO, Fase 2) - o Form so le, nunca recalcula.
    *==========================================================================
    PROTECTED PROCEDURE AposProcessar()
        *-- Dialogo das DIFERENCAS primeiro, na ordem EXATA do legado: no
        *-- PROCEDURE processamento ele vem ANTES do ramo SemConta.
        THIS.ExibirDiferencas()

        IF THIS.this_oBusinessObject.this_lPossuiInconsistencia
            THIS.cnt_4c_Botoes.Top                              = THIS.cnt_4c_BotoesAcao.Top - 2
            THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar.Enabled = .F.
            THIS.txt_4c_DataI.Enabled                           = .F.
            THIS.txt_4c_DataF.Enabled                           = .F.
            THIS.cnt_4c_Botoes.Visible                          = .T.
        ELSE
            IF THIS.this_oBusinessObject.this_lPossuiMovimento
                MsgAviso("Nenhuma Inconsist" + CHR(234) + "ncia Foi Encontrada!!!", ;
                    "ATEN" + CHR(199) + CHR(195) + "O")
            ELSE
                MsgAviso("N" + CHR(227) + "o Existe Movimenta" + CHR(231) + CHR(227) + ;
                    "o no Per" + CHR(237) + "odo!!!", "ATEN" + CHR(199) + CHR(195) + "O")
            ENDIF

            THIS.GravarArquivoContabil()
        ENDIF
    ENDPROC

    *==========================================================================
    * ExibirDiferencas - passo de UI que o PROCEDURE processamento legado
    * executa ANTES do ramo SemConta e que a migracao havia perdido. O BO ja
    * calculava this_lPossuiDiferenca/this_nTotalDiferencas em
    * VerificarDiferencas() e ja expunha ObterCursorDiferencas()/
    * ObterCursorMovimento(), mas NENHUM ponto do Form consumia os quatro -
    * superficie de BO morta eh exatamente o sintoma. Legado
    * (SigPrIct_form_codigo_fonte.txt, fim do PROCEDURE processamento):
    *
    *     Select Transacaos, Sum(Val(Debs)/100) As Deb, Sum(Val(Creds)/100) As Cred ;
    *         From MovAux Group By Transacaos Into Cursor Dif1
    *     Select Transacaos From Dif1 Where Deb <> Cred Into Cursor dif2
    *     Select * From MovAux Where Transacaos In ( Select Transacaos From dif2 ) ;
    *         Into Cursor diferenca
    *     If Reccount() > 0 And Messagebox("Visualizar as diferencas na Tela?",4+32,"Visualizar") = 6
    *         Do Form SigReDif With Thisform.DataSessionId
    *     Endif
    *
    * O "Reccount() > 0" do legado mede o cursor "diferenca" (alias corrente
    * logo depois do Into Cursor), que aqui eh this_lPossuiDiferenca - FONTE
    * UNICA no BO (PILAR 3), o Form nunca recalcula.
    *
    * MsgConfirma devolve LOGICAL (regra #7 - NUNCA comparar com 6) e exibe
    * Sim/Nao com icone de pergunta, equivalente ao 4+32 do legado; o titulo
    * "Visualizar" eh o do legado. Em modo de teste MsgConfirma devolve .F.,
    * entao o harness headless nunca chega a abrir a tela filha (Show() de
    * form modal travaria a execucao).
    *
    * ALIAS DE CONTRATO (movaux/dif2): SigReDifBO.PrepararDados le os alias de
    * nome LITERAL "movaux" e "dif2" na data session do chamador
    * (IF !USED("movaux") OR !USED("dif2") -> recusa com MsgErro) e monta o
    * crGrid com "Select *, 99999999.99 As Deb1s, 99999999.99 As Cred1s From
    * movaux Where Transacaos In (Select Transacaos From dif2)". Os nomes
    * pertencem AO CONSUMIDOR, nao a arquitetura nova, logo NAO levam prefixo
    * cursor_4c_ - mesma razao de SemConta/Cabecalho em
    * PrepararCursoresRelatorio(). Montados aqui a partir dos cursores do BO:
    *   movaux = cursor_4c_MovAux           (ObterCursorMovimento)
    *   dif2   = Transacaos DISTINTAS de cursor_4c_Diferenca
    *            (ObterCursorDiferencas). Equivalente EXATO ao dif2 legado,
    *            porque "diferenca" E' MovAux filtrado por esse mesmo dif2 -
    *            toda Transacaos de dif2 tem pelo menos uma linha em MovAux
    *            (dif2 nasce de um Group By sobre MovAux). Reconstruir eh
    *            necessario porque VerificarDiferencas() FECHA cursor_4c_Dif2
    *            ao terminar.
    * O "Select *" do crGrid exige que movaux NAO tenha Deb1s/Cred1s -
    * cursor_4c_MovAux nao tem (PrepararCursoresProcesso, Fase 2).
    *
    * DataSessionId: este form tem DataSession = 2 (sessao privada) e
    * FormSigReDif.Init(par_nDataSessionId) faz "THIS.DataSessionId =
    * par_nDataSessionId" para ENTRAR nesta sessao e alcancar os dois alias -
    * transcricao de "Do Form SigReDif With Thisform.DataSessionId".
    *
    * Show() FORA do TRY (regra #29): FormSigReDif eh modal (WindowType = 1),
    * logo o Show() BLOQUEIA e todo o uso da tela filha rodaria dentro do
    * bloco - qualquer erro de runtime la dentro saltaria para este CATCH, a
    * referencia LOCAL cairia e a tela filha fecharia sozinha.
    *
    * Os alias de contrato sao fechados DEPOIS do Show() (a tela filha eh
    * modal, portanto ja terminou) e tambem em Destroy(), porque o CATCH pode
    * deixar algum deles aberto.
    *
    * RETURN unico e SEMPRE fora do TRY/CATCH (regra #1) - os RETURN de
    * guarda ficam ANTES do TRY.
    *==========================================================================
    PROCEDURE ExibirDiferencas()
        LOCAL loc_oForm, loc_oErro, loc_cCursorMov, loc_cCursorDif, loc_lPronto

        loc_lPronto = .F.
        loc_oForm   = .NULL.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        *-- "Reccount() > 0" do legado, medido pelo BO
        IF !THIS.this_oBusinessObject.this_lPossuiDiferenca
            RETURN .F.
        ENDIF

        IF !MsgConfirma("Visualizar as diferen" + CHR(231) + "as na Tela?", "Visualizar")
            RETURN .F.
        ENDIF

        TRY
            loc_cCursorMov = THIS.this_oBusinessObject.ObterCursorMovimento()
            loc_cCursorDif = THIS.this_oBusinessObject.ObterCursorDiferencas()

            IF USED(loc_cCursorMov) AND USED(loc_cCursorDif)
                *-- Antes de montar: nao herdar alias de um processamento anterior
                THIS.LiberarCursoresDiferencas()

                SELECT * FROM (loc_cCursorMov) INTO CURSOR movaux READWRITE
                SELECT DISTINCT Transacaos FROM (loc_cCursorDif) INTO CURSOR dif2 READWRITE

                loc_lPronto = USED("movaux") AND USED("dif2")
            ELSE
                MsgAviso("Cursores de diferen" + CHR(231) + "a n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "veis - reprocesse o per" + ;
                    CHR(237) + "odo.", "Visualizar")
            ENDIF

            IF loc_lPronto
                loc_oForm = CREATEOBJECT("FormSigReDif", THIS.DataSessionId)
            ENDIF
        CATCH TO loc_oErro
            loc_lPronto = .F.
            loc_oForm   = .NULL.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ExibirDiferencas")
        ENDTRY

        *-- Show() FORA do TRY (regra #29) - FormSigReDif eh modal
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF

        THIS.LiberarCursoresDiferencas()

        RETURN loc_lPronto
    ENDPROC

    *==========================================================================
    * LiberarCursoresDiferencas - fecha os alias de CONTRATO da tela de
    * diferencas: movaux/dif2 (montados por ExibirDiferencas) e crGrid, que
    * SigReDifBO.PrepararDados cria DENTRO desta data session (ele faz
    * "SET DATASESSION TO (this_nDataSessionId)" antes do SELECT, entao o
    * cursor fica aqui, nao na sessao da tela filha). Chamado em tres pontos:
    * antes de montar, depois do Show() e em Destroy().
    *==========================================================================
    PROTECTED PROCEDURE LiberarCursoresDiferencas()
        IF USED("movaux")
            USE IN movaux
        ENDIF
        IF USED("dif2")
            USE IN dif2
        ENDIF
        IF USED("crGrid")
            USE IN crGrid
        ENDIF
    ENDPROC

    *==========================================================================
    * GravarArquivoContabil - traducao do PROCEDURE gravar legado. A parte de
    * UI (reabilitar Processar/Encerrar e as datas, esconder o grupo de
    * relatorio) fica aqui; a parte de NEGOCIO (geracao do arquivo texto
    * CTPV*, formato SDF, um grupo por EmpCont) mora no BO
    * (GravarArquivosContabeis, Fase 2):
    *
    *     ThisForm.cntBotoes.Top     = ThisForm.btnReport.Top + 60
    *     ThisForm.btnReport.Enabled = .t.
    *     ThisForm.Get_DataI.Enabled = .t.
    *     ThisForm.Get_DataF.Enabled = .t.
    *     ThisForm.cntBotoes.Visible = .f.
    *     If Messagebox('Confirma a Geracao do Arquivo?', 4+32+256, '') = 6
    *         [Copy To ... Type SDF - GravarArquivosContabeis()]
    *     EndIf
    *
    * Chamado nos TRES pontos do legado: fim do Processamento sem
    * inconsistencia (AposProcessar), BtnImprimirClick e
    * BtnEncerrarReportClick (os dois do grupo obj_4c_CmdGReport).
    *
    * BusinessBase ja reporta falha de gravacao sozinho (regra #20 -
    * GravarArquivosContabeis chama MsgErro em todo caminho que devolve .F.),
    * entao esta PROCEDURE nao precisa de ELSE.
    *==========================================================================
    PROCEDURE GravarArquivoContabil()
        THIS.cnt_4c_Botoes.Top                              = THIS.cnt_4c_BotoesAcao.Top + 60
        THIS.cnt_4c_BotoesAcao.obj_4c_CmdGProcessar.Enabled = .T.
        THIS.txt_4c_DataI.Enabled                           = .T.
        THIS.txt_4c_DataF.Enabled                           = .T.
        THIS.cnt_4c_Botoes.Visible                          = .F.

        IF MsgConfirma("Confirma a Gera" + CHR(231) + CHR(227) + "o do Arquivo?")
            THIS.this_oBusinessObject.GravarArquivosContabeis()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - evento do botao "Encerrar" do grupo Processar
    * (obj_4c_CmdGProcessar, Buttons(2)). Legado: SIGPRICT.Sair.Click
    * ("ThisForm.Release") E o ramo Else do Click do GRUPO (This.Value = 2,
    * tambem "ThisForm.Release") - os dois fazem a MESMA coisa, entao uma
    * unica chamada aqui reproduz ambos.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnImprimirClick - evento do botao "Impressora" (obj_4c_CmdGReport,
    * Buttons(1) = btnImprimir do dump). Legado:
    *
    *     Report Form SIGPRICT to PRINTER Prompt NoConsole
    *     ThisForm.Gravar
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro

        TRY
            IF THIS.PrepararCursoresRelatorio()
                THIS.ExecutarReportForm("SigPrIct", "PRINTER_PROMPT", "SemConta")
            ENDIF

            THIS.GravarArquivoContabil()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnImprimirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - evento do botao "Video" (obj_4c_CmdGReport,
    * Buttons(3) = btnVisualizar do dump). Legado:
    *
    *     Report Form SIGPRICT Preview
    *     ThisForm.Gravar
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro

        TRY
            IF THIS.PrepararCursoresRelatorio()
                THIS.ExecutarReportForm("SigPrIct", "PREVIEW", "SemConta")
            ENDIF

            THIS.GravarArquivoContabil()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarReportClick - evento do botao "Encerrar" do grupo de
    * relatorio (obj_4c_CmdGReport, Buttons(2) = btnSair do dump). Legado:
    *
    *     SIGPRICT.cntBotoes.btnReport.btnSair.Click -> "ThisForm.Gravar"
    *     SIGPRICT.cntBotoes.btnReport.Click (This.Value = 2, grupo) ->
    *         "ThisForm.Release" (bolha depois do Click do botao, pois o
    *         dump nao tem NODEFAULT em btnSair.Click)
    *
    * Em VFP9 o Click do MEMBRO roda primeiro e, sem NODEFAULT, borbulha para
    * o Click do GRUPO - por isso aqui tambem: grava o arquivo (com a chance
    * do usuario confirmar ou nao) e so entao fecha o form.
    *==========================================================================
    PROCEDURE BtnEncerrarReportClick()
        THIS.GravarArquivoContabil()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * PrepararCursoresRelatorio - monta os dois alias de NOME LITERAL que o
    * SigPrIct.frx consome por contrato (mesmo padrao de MontarCursoresImpressao/
    * MontarCabecalhoImpressao de outros forms REPORT desta base - os nomes
    * NAO levam prefixo cursor_4c_ porque pertencem ao FRX, nao a arquitetura
    * nova; renomear quebraria as expressoes gravadas no relatorio):
    *
    *   SemConta  - detalhe do relatorio (Contas/DataS/Hists/Valors/Ocors),
    *               espelho de cursor_4c_SemConta
    *               (this_oBusinessObject.ObterCursorInconsistencias()).
    *   Cabecalho - titulo/periodo do cabecalho impresso, equivalente a:
    *       Thisform.poDataMgr.CursorQuery('SigCdEmp','crSigCdEmp','Cemps',_Empr,'Razas')
    *       Create Cursor Cabecalho (Empresa c(80), Titulo c(80), SubTit c(80), Periodo c(80))
    *       Insert Into Cabecalho (Empresa, Titulo, Periodo) Values ;
    *           (_Empr + ' - ' + crSigCdEmp.Razas, ;
    *            'Relatorio de Inconsistencias de Integracao Contabil', ;
    *            'Periodo: ' + Dtoc(IniPer) + ' a ' + Dtoc(FinPer))
    *   "_Empr" (legado) = go_4c_Sistema.cCodEmpresa (CLAUDE.md - _EMPR nunca
    *   usado direto). this_dDataI/this_dDataF (BO) sao a FONTE UNICA do
    *   periodo - o mesmo que ValidarPeriodo()/Processar() ja usaram.
    *==========================================================================
    PROTECTED FUNCTION PrepararCursoresRelatorio()
        LOCAL loc_cCursorOrigem, loc_cSQL, loc_nResultado, loc_cRazao

        loc_cCursorOrigem = THIS.this_oBusinessObject.ObterCursorInconsistencias()

        IF !USED(loc_cCursorOrigem) OR RECCOUNT(loc_cCursorOrigem) = 0
            MsgAviso("Nenhuma inconsist" + CHR(234) + "ncia dispon" + CHR(237) + ;
                "vel para o relat" + CHR(243) + "rio.")
            RETURN .F.
        ENDIF

        IF USED("SemConta")
            USE IN SemConta
        ENDIF
        *-- ORDER BY Contas, DataS reproduz o "Select SemConta / Set Order to Conta" que
        *-- o legado executa ANTES do If Not Eof() (o TAG Conta eh
        *-- "Contas + Dtos(DataS)"): o SigPrIct.frx imprime na ordem do indice, e
        *-- um SELECT sem ORDER BY entregaria a ordem de INSERCAO.
        SELECT * FROM (loc_cCursorOrigem) ORDER BY Contas, DataS ;
            INTO CURSOR SemConta READWRITE

        loc_cRazao = ""
        IF USED("cursor_4c_EmpRelatorio")
            USE IN cursor_4c_EmpRelatorio
        ENDIF
        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpRelatorio")
        IF loc_nResultado >= 1 AND USED("cursor_4c_EmpRelatorio") AND !EOF("cursor_4c_EmpRelatorio")
            loc_cRazao = ALLTRIM(TratarNulo(cursor_4c_EmpRelatorio.Razas, ""))
        ENDIF
        IF USED("cursor_4c_EmpRelatorio")
            USE IN cursor_4c_EmpRelatorio
        ENDIF

        IF USED("Cabecalho")
            USE IN Cabecalho
        ENDIF
        CREATE CURSOR Cabecalho (Empresa C(80), Titulo C(80), SubTit C(80), Periodo C(80))
        INSERT INTO Cabecalho (Empresa, Titulo, Periodo) VALUES ;
            (ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + loc_cRazao, ;
             "Relat" + CHR(243) + "rio de Inconsist" + CHR(234) + "ncias de Integra" + ;
                CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil", ;
             "Per" + CHR(237) + "odo: " + DTOC(THIS.this_oBusinessObject.this_dDataI) + ;
                " " + CHR(224) + " " + DTOC(THIS.this_oBusinessObject.this_dDataF))

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ExecutarReportForm - helper canonico de REPORT FORM (mesmo padrao de
    * FormSigPrFem/FormSIGPGCNB/FormSIGPRCNB - CorretorAutomatico #117/#147):
    *   1. guard de EXISTENCIA do FRX (o legado usa "Report Form SIGPRICT"
    *      BARE, o VFP9 procuraria o arquivo no diretorio corrente);
    *   2. guard de cursor VAZIO (preview em branco nao diz nada ao usuario);
    *   3. isolamento de locale - SET POINT "." / SEPARATOR "," /
    *      REPORTBEHAVIOR 80 (FRX Fortyus com PICTURE americana);
    *   4. restauracao do menu - REPORT FORM PREVIEW corrompe o cache visual
    *      do _MSYSMENU (Erro63).
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER".
    *==========================================================================
    PROTECTED FUNCTION ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                CHR(13) + loc_cFRX, "Erro")
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
            SELECT (par_cCursorDados)
            GO TOP
        ENDIF

        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
                popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora de escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
    * padrao. Percorre recursivamente containers/PageFrames para tornar tudo
    * visivel apos a montagem. Filtra cnt_4c_Botoes (equivalente ao cntBotoes
    * legado, que so fica visivel DEPOIS do processamento - Fase 7/8): pula o
    * Visible do proprio container, mas recursa nos filhos para eles nao
    * ficarem hidden quando o container for mostrado depois. Filtra tambem
    * lbl_4c_Label4 (duplicata de " Periodo " oculta no proprio SCX - ver
    * ConfigurarFiltroPeriodo): sem esta excecao, o laco forcaria
    * Visible=.T. e o duplicado apareceria sobre a linha "Data Inicial".
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_BOTOES")
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                    LOOP
                ENDIF

                IF UPPER(loc_oObjeto.Name) = "LBL_4C_LABEL4"
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Equivalente do "PROCEDURE Release" legado (que soltava o
    * poDataMgr; aqui a conexao eh o gnConnHandle global e nao pertence ao
    * form). Fecha os cursores de processamento desta tela, se ainda abertos,
    * antes de encadear para FormBase.Destroy(), que libera o BO e restaura o
    * menu principal. DODEFAULT() SEMPRE por ultimo (Destroy sem DODEFAULT
    * deixa o menu do sistema encolhido - CLAUDE.md regra correlata).
    *==========================================================================
    PROCEDURE Destroy()
        *-- Cursores do BO (inclui Dif1/Dif2/Diferenca, que o processamento
        *-- so cria quando VerificarDiferencas() encontra transacao
        *-- desbalanceada - FinalizarProcesso() cobre a lista inteira).
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.FinalizarProcesso()
        ENDIF

        IF USED("cursor_4c_MovAux")
            USE IN cursor_4c_MovAux
        ENDIF
        IF USED("cursor_4c_SemConta")
            USE IN cursor_4c_SemConta
        ENDIF
        IF USED("cursor_4c_Grupos")
            USE IN cursor_4c_Grupos
        ENDIF
        IF USED("cursor_4c_TodosGrupos")
            USE IN cursor_4c_TodosGrupos
        ENDIF
        IF USED("cursor_4c_Empresas")
            USE IN cursor_4c_Empresas
        ENDIF
        IF USED("cursor_4c_LoteProc")
            USE IN cursor_4c_LoteProc
        ENDIF
        IF USED("cursor_4c_MvCcr")
            USE IN cursor_4c_MvCcr
        ENDIF

        *-- Cursores de nome literal montados por PrepararCursoresRelatorio()
        *-- (Fase 7/8) para o SigPrIct.frx - nao levam prefixo cursor_4c_.
        IF USED("SemConta")
            USE IN SemConta
        ENDIF
        IF USED("Cabecalho")
            USE IN Cabecalho
        ENDIF
        IF USED("cursor_4c_EmpRelatorio")
            USE IN cursor_4c_EmpRelatorio
        ENDIF

        *-- Alias de CONTRATO da tela de diferencas (movaux/dif2/crGrid).
        *-- ExibirDiferencas() ja os fecha depois do Show(), mas o CATCH dele
        *-- pode deixar algum aberto - fechar aqui tambem.
        THIS.LiberarCursoresDiferencas()

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrIctBO.prg):
*============================================================================
* SigPrIctBO.prg - Business Object para Integracao Contabil
*
* Form legado: SIGPRICT (form generico, OPERACIONAL - sem CRUD de registro)
* Processo em lote: concilia o movimento financeiro (SigMvCcr) do periodo
* informado contra o plano de contas (SigCdGcr/SigCdCli), monta um cursor de
* lancamentos contabeis (MovAux no legado) e grava arquivo(s) texto (CTPV*)
* no diretorio configurado em SigCdPam.DirContabv - um arquivo por empresa.
*
* Tabelas/cursores lidos pelo processamento (Processamento do legado):
*   SigMvCcr   (movimento de conta corrente do periodo)
*   SigCdGcr   (grupos de conta corrente - contabilizavel/conta contabil)
*   SigCdCli   (contas/clientes - conta contabil, razao social, CPF)
*   SigCdEmp   (empresas - Cemps/Razas, cabecalho do relatorio)
*   SigCdPam   (parametros: DirContabv, GrupoPags, GrupoRecs, MoedaCheqs)
*   SigCdPac   (parametros: CfgHisICs - config. do historico do lancamento)
*   SigCqChm   (lotes de cheques)
*   SigCdPit   (titulos pagos/recebidos no periodo)
*   SigMvPar/SigOpFp/SigCdFrm (forma de pagamento - numero do cheque)
*   SigCdEsp   (especies de nota fiscal - provisao)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - carga dos parametros do sistema e logica real do
*                Processamento/Gravar legado (geracao do arquivo contabil)
*
* NOTA DE ARQUITETURA - Inserir()/Atualizar()/ExecutarExclusao():
* Este processo NAO grava um registro em tabela alguma do SQL Server - ele
* monta um cursor local de lancamentos e grava arquivo(s) de TEXTO (formato
* SDF) no diretorio contabil configurado em SigCdPam.DirContabv, para
* importacao em sistema contabil externo. Por isso nao ha "tabela principal"
* nem "campo chave" de persistencia (this_cTabela/this_cCampoChave ficam
* vazios) e os metodos Inserir()/Atualizar()/ExecutarExclusao() de
* BusinessBase NAO sao sobrescritos - o comportamento padrao herdado (recusar
* a operacao) ja eh o correto, porque o form nunca chama Salvar()/Excluir();
* ele chama os metodos proprios de processamento (Fase 2) diretamente.
*
* NOTA DE FIDELIDADE (regra #17 - transcrever, nunca reescrever):
* O legado suporta DOIS drivers (DBF local "foxpro" e SQL Server, testados
* via Thisform.poDataMgr.GetDriver()). O sistema novo so conecta via SQL
* Server (gnConnHandle), entao somente o ramo "Else" (SQL Server) de cada
* Do Case/If lcConexao='foxpro' do Processamento legado foi portado; o ramo
* "foxpro" (que usa USE/SEEK direto em .DBF) e as colunas auxiliares
* exclusivas dele (indice VOpers local, Order('crSigMvCcr'), etc.) nao se
* aplicam e foram omitidas.
*
* NOTA DE FIDELIDADE - campo EmpCont do cursor MovAux:
* No fonte original (SIGPRICT.Procedure processamento, bloco comentado com
* "*!*" e assinado "BRUNO"), a definicao de m.EmpCont (a partir de
* crSigCdEmp) esta DESATIVADA - o Gather Memvar nunca encontra uma memvar
* m.EmpCont e o campo fica em branco em TODOS os lancamentos gerados. Isso
* foi preservado literalmente (nao e bug deste BO, e o comportamento real
* do legado): na pratica MovAux inteiro pertence a um unico grupo EmpCont
* (vazio), e o Gravar() legado (aqui GravarArquivosContabeis) gera um UNICO
* arquivo CTPV<seq>. (extensao vazia) por execucao, nao "um por empresa"
* como a doc do sistema sugere. A carga de cursor_4c_Empresas foi mantida
* (SELECT Cemps FROM SigCdEmp) so para preservar o mesmo ponto de falha de
* conexao que o legado tem, ainda que o resultado nao seja mais consultado.
*============================================================================

DEFINE CLASS SigPrIctBO AS BusinessBase

    *==========================================================================
    * Propriedades - periodo de processamento (Get_DataI/Get_DataF do form
    * legado - unicos campos digitaveis da tela).
    *==========================================================================
    this_dDataI = {}    && date - Data Inicial do periodo (Thisform.Get_Datai.Value)
    this_dDataF = {}    && date - Data Final do periodo (Thisform.Get_Dataf.Value)

    *==========================================================================
    * Propriedades - parametros do sistema (SigCdPam/SigCdPac), carregados no
    * inicio do processamento (equivalente ao SqlExecute(crSigCdPam)/
    * SqlExecute(crSigCdPac) do Init legado) e usados durante toda a
    * conciliacao do movimento.
    *==========================================================================
    this_cDirContabv         = ""   && char - Diretorio de destino dos arquivos contabeis (SigCdPam.DirContabv)
    this_cGrupoPagamentos    = ""   && char - Grupo de contas de Pagamentos/contas transitorias (SigCdPam.GrupoPags)
    this_cGrupoRecebimentos  = ""   && char - Grupo de contas de Recebimentos/contas transitorias (SigCdPam.GrupoRecs)
    this_cMoedaCheque        = ""   && char - Moeda de referencia para conversao de cheques (SigCdPam.MoedaCheqs)
    this_nConfigHistorico    = 0    && numeric - Configuracao do historico do lancamento contabil (SigCdPac.CfgHisICs)

    *==========================================================================
    * Propriedades - resultado do ultimo processamento, usadas pelo form para
    * decidir a mensagem final e habilitar o grupo de botoes de Impressao/
    * Visualizacao/Encerrar (equivalente ao "Select SemConta / Go Top /
    * If Not Eof()" do final do Processamento legado).
    *==========================================================================
    this_lPossuiInconsistencia  = .F.   && .T. quando o cursor de contas sem configuracao (SemConta) tem registros
    this_nTotalInconsistencias  = 0     && quantidade de registros no cursor de inconsistencias
    this_lPossuiMovimento       = .F.   && .T. quando existe movimento contabilizavel no periodo (cursor MovAux)
    this_nTotalRegistrosGerados = 0     && quantidade de lancamentos gerados no cursor de movimento contabil
    this_lPossuiDiferenca       = .F.   && .T. quando alguma Transacaos ficou com Debs <> Creds (cursor diferenca)
    this_nTotalDiferencas       = 0     && quantidade de lancamentos envolvidos em transacoes desbalanceadas

    *==========================================================================
    * Sem tabela/chave de persistencia - ver nota de arquitetura no cabecalho
    * do arquivo (processo gera arquivo texto, nao grava registro em tabela).
    *==========================================================================
    this_cTabela     = ""
    this_cCampoChave = ""

    *==========================================================================
    * Propriedades - LINHA CORRENTE de um dos cursores de resultado, carregada
    * por CarregarDoCursor(). O FormSigPrIct usa isso para ler a linha que o
    * usuario selecionou na grade (lancamento contabil / inconsistencia) sem
    * depender do alias corrente do VFP, e ObterChavePrimaria() monta a chave
    * de auditoria a partir delas.
    *
    * Os nomes espelham as colunas dos cursores (regra de naming: preservar o
    * sufixo "s" do legado). ATENCAO ao TIPO: no cursor de lancamentos (MovAux
    * do legado) Debs/Creds/Valor sao CARACTERE C(12) - sao o campo ja
    * formatado para o arquivo SDF (centavos, sem separador), NAO numeros;
    * converter para numerico aqui mudaria o que vai para o arquivo contabil.
    *==========================================================================
    this_cAnoFis     = ""   && char(4)  - Ano fiscal do lancamento
    this_cDatas      = ""   && char(8)  - Data do lancamento no formato do arquivo contabil
    this_cContas     = ""   && char(9)  - Conta contabil do lancamento
    this_cDebs       = ""   && char(12) - Valor a DEBITO ja formatado para o arquivo (NAO numerico)
    this_cCreds      = ""   && char(12) - Valor a CREDITO ja formatado para o arquivo (NAO numerico)
    this_cDocto      = ""   && char(10) - Documento de origem
    this_cHists      = ""   && char(70) - Historico do lancamento
    this_cEmpCont    = ""   && char(3)  - Empresa contabil (grupo do arquivo gerado)
    this_cNumSeq     = ""   && char(6)  - Numero sequencial do lancamento
    this_cNums       = ""   && char(6)  - Numero do movimento
    this_cLams       = ""   && char(6)  - Numero do lancamento
    this_dData       = {}   && date     - Data do lancamento (coluna D do cursor)
    this_cValor      = ""   && char(12) - Valor do lancamento ja formatado (NAO numerico)
    this_cCecus      = ""   && char(3)  - Centro de custo
    this_cEmps       = ""   && char(3)  - Empresa do movimento de origem
    this_cTransacaos = ""   && char(10) - Transacao que amarra debito e credito (usada em VerificarDiferencas)
    this_cCpfs       = ""   && char(20) - CPF/CNPJ da conta
    this_cIClis      = ""   && char(10) - Codigo da conta/cliente
    this_cRazaos     = ""   && char(50) - Razao social da conta/cliente
    this_cCheque     = ""   && char(20) - Numero do cheque, quando o lancamento vem de lote de cheques

    *==========================================================================
    * Propriedades exclusivas do cursor de INCONSISTENCIAS (SemConta do
    * legado): la a coluna de data chama-se DataS e eh do tipo D, enquanto no
    * cursor de lancamentos Datas eh C(8). Os dois nomes colidem para o VFP
    * (comparacao de nome de campo eh case-insensitive), por isso
    * CarregarDoCursor() decide pelo VARTYPE da coluna, nunca pelo nome.
    *==========================================================================
    this_dDataS = {}   && date       - Data do movimento sem conta configurada
    this_nValors = 0   && numeric    - Valor do movimento sem conta configurada
    this_cOcors  = ""  && char(40)   - Texto da ocorrencia que impediu a contabilizacao

    *==========================================================================
    * Nome do cursor de onde a ultima linha foi carregada (usado por
    * ObterChavePrimaria para saber qual composicao de chave usar).
    *==========================================================================
    this_cCursorCarregado = ""

    *==========================================================================
    * Init - Inicializa o Business Object com o periodo padrao (equivalente
    * ao "Get_Datai.Value = Date() / Get_Dataf.Value = Date()" do Init
    * legado, que roda apos a conexao com o banco ser validada).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            THIS.this_dDataI      = DATE()
            THIS.this_dDataF      = DATE()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarPeriodo - equivalente aos tres guards do Click do btnReport
    * legado (data inicial vazia / data final vazia / final menor que
    * inicial). O FormSigPrIct chama este metodo ANTES de confirmar
    * o processamento, para poder dar SetFocus no campo invalido; aqui serve
    * tambem de guarda defensiva dentro de Processar().
    *==========================================================================
    FUNCTION ValidarPeriodo()
        LOCAL loc_lValido
        loc_lValido = .T.
        THIS.this_cMensagemErro = ""

        IF EMPTY(THIS.this_dDataI)
            THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida!!!"
            loc_lValido = .F.
        ELSE
            IF EMPTY(THIS.this_dDataF)
                THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"
                loc_lValido = .F.
            ELSE
                IF THIS.this_dDataF < THIS.this_dDataI
                    THIS.this_cMensagemErro = "A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!"
                    loc_lValido = .F.
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * CarregarParametrosSistema - Carrega SigCdPam/SigCdPac (equivalente aos
    * dois SqlExecute do Init legado).
    *==========================================================================
    PROTECTED FUNCTION CarregarParametrosSistema()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .T.

        loc_cSQL = "SELECT DirContabv, GrupoPags, GrupoRecs, MoedaCheqs FROM SigCdPam"
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (crSigCdPam)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ELSE
            SELECT cursor_4c_SigCdPam
            THIS.this_cDirContabv        = ALLTRIM(TratarNulo(DirContabv, ""))
            THIS.this_cGrupoPagamentos   = TratarNulo(GrupoPags, "")
            THIS.this_cGrupoRecebimentos = TratarNulo(GrupoRecs, "")
            THIS.this_cMoedaCheque       = TratarNulo(MoedaCheqs, "")
            USE IN cursor_4c_SigCdPam

            loc_cSQL = "SELECT CfgHisICs FROM SigCdPac"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac")
            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o (crSigCdPac)" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro")
                loc_lSucesso = .F.
            ELSE
                SELECT cursor_4c_SigCdPac
                THIS.this_nConfigHistorico = NVL(CfgHisICs, 0)
                USE IN cursor_4c_SigCdPac
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * RegistrarSemConta - grava uma linha de inconsistencia (conta sem
    * configuracao contabil) no cursor_4c_SemConta. Extraido do bloco
    * "Select SemConta / Append Blank / Replace ... Ocors With Ocor1" que se
    * repete identico varias vezes no Processamento legado (PILAR 3 -
    * deduplicacao de bloco idENTICO, formula de negocio preservada).
    *==========================================================================
    PROTECTED PROCEDURE RegistrarSemConta(par_cConta, par_dData, par_cHist, par_nValor, par_cOcorrencia)
        IF !USED("cursor_4c_SemConta")
            RETURN
        ENDIF
        SELECT cursor_4c_SemConta
        APPEND BLANK
        REPLACE Contas WITH par_cConta, ;
            DataS  WITH par_dData, ;
            Hists  WITH par_cHist, ;
            Valors WITH par_nValor, ;
            Ocors  WITH par_cOcorrencia
    ENDPROC

    *==========================================================================
    * ResolverContaContabil - Do Case de definicao da conta contabil, repetido
    * (quase) identico 6x no Processamento legado:
    *   Case Not Empty(Grupo.ContConts)  -> usa a conta do GRUPO
    *   Case Not Empty(Cliente.CContabs) -> usa a conta do CLIENTE/CONTA
    *   Otherwise                        -> usa a propria conta e registra
    *                                       inconsistencia (Ocor1)
    *==========================================================================
    PROTECTED FUNCTION ResolverContaContabil(par_cContContaGrupo, par_cContaContabilCliente, ;
            par_cContaOriginal, par_dData, par_cHistInconsistencia, par_nValorInconsistencia)
        LOCAL loc_cResultado

        DO CASE
            CASE !EMPTY(par_cContContaGrupo)
                loc_cResultado = par_cContContaGrupo
            CASE !EMPTY(par_cContaContabilCliente)
                loc_cResultado = par_cContaContabilCliente
            OTHERWISE
                loc_cResultado = par_cContaOriginal
                THIS.RegistrarSemConta(par_cContaOriginal, par_dData, par_cHistInconsistencia, ;
                    par_nValorInconsistencia, THIS.ObterTextoOcorrencia(1))
        ENDCASE

        RETURN loc_cResultado
    ENDFUNC

    *==========================================================================
    * ObterTextoOcorrencia - textos fixos das inconsistencias (Ocor1..Ocor4
    * do Processamento legado), centralizados para evitar divergencia de
    * grafia entre os varios pontos que os usam.
    *==========================================================================
    PROTECTED FUNCTION ObterTextoOcorrencia(par_nCodigo)
        LOCAL loc_cTexto
        DO CASE
            CASE par_nCodigo = 1
                loc_cTexto = "Conta Cont" + CHR(225) + "bil n" + CHR(227) + "o Cadastrada "
            CASE par_nCodigo = 2
                loc_cTexto = "Empresa Cont" + CHR(225) + "bil n" + CHR(227) + "o Cadastrada "
            CASE par_nCodigo = 3
                loc_cTexto = "Item do Pagamento sem Centro de Custo "
            CASE par_nCodigo = 4
                loc_cTexto = "PagtoXTit, Emp ou Controle n" + CHR(227) + "o encontrado"
            OTHERWISE
                loc_cTexto = ""
        ENDCASE
        RETURN loc_cTexto
    ENDFUNC

    *==========================================================================
    * Processar - metodo PUBLICO chamado pelo form (equivalente ao
    * ThisForm.Processamento do Click do btnReport legado). So faz o TRY/
    * CATCH externo (regra #1 - nunca RETURN dentro de TRY/CATCH); a logica
    * real mora em ExecutarProcessamento(), que nao tem TRY proprio e pode
    * usar RETURN livremente.
    *==========================================================================
    FUNCTION Processar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.ExecutarProcessamento()
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Processar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarProcessamento - motor do processamento (traducao do PROCEDURE
    * processamento do SIGPRICT legado, ramo SQL Server). Sem TRY proprio -
    * qualquer excecao sobe para o CATCH de Processar().
    *==========================================================================
    PROTECTED FUNCTION ExecutarProcessamento()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.this_cMensagemErro          = ""
        THIS.this_lPossuiInconsistencia  = .F.
        THIS.this_nTotalInconsistencias  = 0
        THIS.this_lPossuiMovimento       = .F.
        THIS.this_nTotalRegistrosGerados = 0
        THIS.this_lPossuiDiferenca       = .F.
        THIS.this_nTotalDiferencas       = 0

        IF !THIS.ValidarPeriodo()
            MsgErro(THIS.this_cMensagemErro, "")
            RETURN .F.
        ENDIF

        IF !THIS.CarregarParametrosSistema()
            RETURN .F.
        ENDIF

        IF !THIS.PrepararCursoresProcesso()
            RETURN .F.
        ENDIF

        IF !THIS.CarregarMovimentoPeriodo()
            RETURN .F.
        ENDIF

        IF !THIS.ConciliarMovimento()
            RETURN .F.
        ENDIF

        THIS.VerificarDiferencas()

        SELECT cursor_4c_SemConta
        GO TOP
        THIS.this_nTotalInconsistencias = RECCOUNT("cursor_4c_SemConta")
        THIS.this_lPossuiInconsistencia = !EOF("cursor_4c_SemConta")

        SELECT cursor_4c_MovAux
        GO TOP
        THIS.this_nTotalRegistrosGerados = RECCOUNT("cursor_4c_MovAux")
        THIS.this_lPossuiMovimento       = !EOF("cursor_4c_MovAux")

        IF USED("cursor_4c_MvCcr")
            USE IN cursor_4c_MvCcr
        ENDIF

        loc_lSucesso = .T.
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * PrepararCursoresProcesso - cria os cursores de trabalho do processo
    * (equivalente ao topo do Processamento legado: Create Cursor
    * Grupos/SemConta/LoteProc + Zap In MovAux + carga de crSigCdGcr/
    * crSigCdEmp).
    *==========================================================================
    PROTECTED FUNCTION PrepararCursoresProcesso()
        LOCAL loc_cSQL, loc_nResultado

        IF USED("cursor_4c_Grupos")
            USE IN cursor_4c_Grupos
        ENDIF
        IF USED("cursor_4c_TodosGrupos")
            USE IN cursor_4c_TodosGrupos
        ENDIF
        IF USED("cursor_4c_Empresas")
            USE IN cursor_4c_Empresas
        ENDIF
        IF USED("cursor_4c_SemConta")
            USE IN cursor_4c_SemConta
        ENDIF
        IF USED("cursor_4c_LoteProc")
            USE IN cursor_4c_LoteProc
        ENDIF
        IF USED("cursor_4c_MovAux")
            USE IN cursor_4c_MovAux
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_SemConta (Contas C(9), DataS D NULL, Hists C(70), Valors N(12,2), Ocors C(40))
        SET NULL OFF
        INDEX ON Contas + DTOS(DataS) TAG Conta

        CREATE CURSOR cursor_4c_LoteProc (Lotes N(6))
        INDEX ON Lotes TAG Lotes

        SET NULL ON
        CREATE CURSOR cursor_4c_MovAux (AnoFis C(4), Datas C(8), Contas C(9), Debs C(12), Creds C(12), ;
            Docto C(10), Hists C(70), EmpCont C(3), NumSeq C(6), Nums C(6), Lams C(6), Data D NULL, ;
            Valor C(12), Cecus C(3), Emps C(3), Transacaos C(10), Cpfs C(20), IClis C(10), Razaos C(50), ;
            Cheque C(20))
        SET NULL OFF
        INDEX ON EmpCont + Datas TAG EmpCont

        *-- Grupos de conta corrente CONTABILIZAVEIS (equivalente ao cursor "Grupos")
        loc_cSQL = "SELECT Codigos, ContConts FROM SigCdGcr WHERE IntConts = 1"
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposTmp")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (Grupos)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "")
            RETURN .F.
        ENDIF
        CREATE CURSOR cursor_4c_Grupos (Codigos C(10), ContConts C(9))
        SELECT cursor_4c_Grupos
        APPEND FROM DBF("cursor_4c_GruposTmp")
        USE IN cursor_4c_GruposTmp
        SELECT cursor_4c_Grupos
        INDEX ON Codigos TAG Codigos

        *-- Todos os grupos de conta corrente, para resolucao da contra-partida
        loc_cSQL = "SELECT Codigos, IntConts, ContConts FROM SigCdGcr"
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TodosGrupos")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (crSigCdGcr)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "")
            RETURN .F.
        ENDIF
        SELECT cursor_4c_TodosGrupos
        INDEX ON Codigos TAG Codigos

        *-- Empresas - mantido so para preservar o mesmo ponto de falha de
        *-- conexao do legado (ver nota de fidelidade do cabecalho: o
        *-- resultado nao e mais consultado, pois o bloco m.EmpCont do
        *-- legado esta desativado).
        loc_cSQL = "SELECT Cemps FROM SigCdEmp"
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresas")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (crSigCdEmp)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "")
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Empresas
        INDEX ON Cemps TAG Cemps

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * CarregarMovimentoPeriodo - traz o movimento de conta corrente do
    * periodo informado (equivalente ao bloco "Else" / SQL Server do trecho
    * "Selecionando o Arquivo de Conta Corrente" do Processamento legado).
    * O cursor precisa ser READWRITE porque o final da conciliacao faz
    * "Delete For EmpDopnums=lcChave" sobre ele (ver ConciliarMovimento).
    *==========================================================================
    PROTECTED FUNCTION CarregarMovimentoPeriodo()
        LOCAL loc_cSQL, loc_nResultado, loc_cDataFim

        loc_cDataFim = FormatarDataSQL(DATETIME(YEAR(THIS.this_dDataF), MONTH(THIS.this_dDataF), ;
            DAY(THIS.this_dDataF), 23, 59, 59))

        loc_cSQL = "SELECT Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, " + ;
            "Hists, Hist2s, Valors, Opers, Autos, Nopers, Nfs, Titulos, Tipos, EmpDopNums, " + ;
            "EspecieNfs, EmpDopNcs, Cotacaos, SValors, Valocurs FROM SigMvCcr WHERE Datas BETWEEN " + ;
            FormatarDataSQL(THIS.this_dDataI) + " AND " + loc_cDataFim + " ORDER BY Datas, Nopers"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcrTmp")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (crSigMvCcr)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "")
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_MvCcr")
            USE IN cursor_4c_MvCcr
        ENDIF
        SELECT * FROM cursor_4c_MvCcrTmp INTO CURSOR cursor_4c_MvCcr READWRITE
        USE IN cursor_4c_MvCcrTmp
        SELECT cursor_4c_MvCcr
        INDEX ON Datas TAG Datas
        GO TOP

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ConciliarMovimento - laco principal (Scan) do Processamento legado,
    * ramo SQL Server. Para cada linha de movimento, define a conta contabil
    * do lancamento (do grupo ou do cadastro de contas), monta o
    * debito/credito e grava em cursor_4c_MovAux. Quando a operacao exige
    * contra-lancamento (lote de cheques, operacao simples por Nopers ou
    * rateio contra titulos pagos/recebidos), gera tambem os lancamentos
    * complementares.
    *==========================================================================
    PROTECTED FUNCTION ConciliarMovimento()
        LOCAL loc_cContabs, loc_nDebs, loc_nCreds, loc_cHists, loc_cAnoFis, loc_cDatas
        LOCAL loc_nNcont, loc_nOldNopers, loc_nValLan1, loc_nNumlote, loc_cControle
        LOCAL loc_cOpeAtual, loc_nControleAtu, loc_cEmpLanc, loc_lManual, loc_cSQL, loc_nResultado
        LOCAL loc_cOperacao, loc_nValorDesp, loc_nVTitCC, loc_nValOco, loc_cMoeDiv, loc_nCotDiv
        LOCAL loc_nPNop, loc_lProvis, loc_nValOcoTit, loc_nVpago, loc_nValContra, loc_nVrDif
        LOCAL loc_cLcKey, loc_cGrupoPag, loc_cDocto, loc_nRegMvCcr, loc_nRegCount, loc_nAtual
        LOCAL loc_oProg, loc_cTransacaos, loc_cChave, loc_cContContaGrupo, loc_cContaContabilCliente

        loc_nNcont      = 0
        loc_nOldNopers  = 0
        loc_nRegCount   = RECCOUNT("cursor_4c_MvCcr")
        loc_nAtual      = 0

        loc_oProg = CREATEOBJECT("fwprogressbar", "Processando Movimento de Conta Corrente...", loc_nRegCount)
        loc_oProg.Show()

        SELECT cursor_4c_MvCcr
        GO TOP
        SCAN WHILE !EOF("cursor_4c_MvCcr")
            loc_nAtual = loc_nAtual + 1
            loc_oProg.SubTitulo.Caption = "Processando dia : " + DTOC(cursor_4c_MvCcr.Datas) + " - " + ;
                TRANSFORM(cursor_4c_MvCcr.Nopers)
            loc_oProg.Update(.T.)

            loc_nRegMvCcr = RECNO("cursor_4c_MvCcr")

            *-- Verifica se o Grupo da Conta e contabilizavel; se nao for, a
            *-- conta precisa ser contabilizavel (crSigCdCli.IntConts = 1).
            loc_cSQL = "SELECT IClis, RClis, Razaos, Cpfs, IntConts, CContabs, TpHists, Hists " + ;
                "FROM SigCdCli WHERE IClis = " + EscaparSQL(cursor_4c_MvCcr.Contas) + " ORDER BY CContabs"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliDestino")
            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o (crSigCdCli)" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "")
                loc_oProg.Complete(.T.)
                RETURN .F.
            ENDIF

            IF !SEEK(ALLTRIM(cursor_4c_MvCcr.Grupos), "cursor_4c_Grupos", "Codigos") OR cursor_4c_MvCcr.Valors = 0
                IF NVL(cursor_4c_CliDestino.IntConts, 0) != 1
                    USE IN cursor_4c_CliDestino
                    LOOP
                ENDIF
            ENDIF

            *-- Verifica se a contra-partida permite contabilizacao (determinado pelo grupo)
            IF SEEK(ALLTRIM(cursor_4c_MvCcr.SGrupos), "cursor_4c_TodosGrupos", "Codigos")
                IF cursor_4c_TodosGrupos.IntConts = 3
                    USE IN cursor_4c_CliDestino
                    LOOP
                ENDIF
            ENDIF

            *-- Definicao da conta contabil do lancamento principal
            IF USED("cursor_4c_Grupos") AND SEEK(ALLTRIM(cursor_4c_MvCcr.Grupos), "cursor_4c_Grupos", "Codigos")
                loc_cContContaGrupo = ALLTRIM(TratarNulo(cursor_4c_Grupos.ContConts, ""))
            ELSE
                loc_cContContaGrupo = ""
            ENDIF
            loc_cContaContabilCliente = ALLTRIM(TratarNulo(cursor_4c_CliDestino.CContabs, ""))

            loc_cHists = SUBSTR(TratarNulo(cursor_4c_MvCcr.Hists, "") + TratarNulo(cursor_4c_MvCcr.Hist2s, ""), 1, 70)
            loc_cContabs = THIS.ResolverContaContabil(loc_cContContaGrupo, loc_cContaContabilCliente, ;
                ALLTRIM(cursor_4c_MvCcr.Contas), cursor_4c_MvCcr.Datas, loc_cHists, cursor_4c_MvCcr.Valors)

            IF cursor_4c_MvCcr.Opers = "D"
                loc_nDebs  = cursor_4c_MvCcr.Valors
                loc_nCreds = 0
            ELSE
                loc_nDebs  = 0
                loc_nCreds = cursor_4c_MvCcr.Valors
            ENDIF

            loc_nValLan1 = cursor_4c_MvCcr.Valors
            loc_cAnoFis  = TRANSFORM(YEAR(cursor_4c_MvCcr.Datas))
            loc_cDatas   = STRTRAN(DTOC(cursor_4c_MvCcr.Datas), "/", "")
            loc_cHists   = STRTRAN(STRTRAN(STRTRAN(loc_cHists, CHR(1), ""), CHR(13), ""), CHR(10), "")

            IF cursor_4c_MvCcr.Autos AND "LOTE" $ TratarNulo(cursor_4c_MvCcr.Hists, "")
                loc_cDocto   = TRANSFORM(VAL(RIGHT(ALLTRIM(cursor_4c_MvCcr.Hists), 6)))
                loc_nNumlote = VAL(SUBSTR(cursor_4c_MvCcr.Hists, AT("LOTE", cursor_4c_MvCcr.Hists) + 5, 6))
                IF loc_nNumlote = 0
                    loc_nNumlote = VAL(RIGHT(ALLTRIM(cursor_4c_MvCcr.Hists), 6))
                ENDIF
                IF SEEK(loc_nNumlote, "cursor_4c_LoteProc", "Lotes")
                    USE IN cursor_4c_CliDestino
                    LOOP
                ENDIF
            ELSE
                loc_cDocto = ALLTRIM(cursor_4c_MvCcr.Nfs)
            ENDIF

            IF cursor_4c_MvCcr.Nopers != loc_nOldNopers
                loc_nNcont = loc_nNcont + 1
                loc_nOldNopers = cursor_4c_MvCcr.Nopers
            ENDIF
            loc_cTransacaos = PADL(ALLTRIM(TRANSFORM(loc_nNcont)), 6, "0")

            *-- Lancamento 1
            SELECT cursor_4c_MovAux
            APPEND BLANK
            REPLACE AnoFis      WITH loc_cAnoFis, ;
                    Datas       WITH loc_cDatas, ;
                    Contas      WITH loc_cContabs, ;
                    Debs        WITH TRANSFORM(loc_nDebs * 100, "@L 999999999999"), ;
                    Creds       WITH TRANSFORM(loc_nCreds * 100, "@L 999999999999"), ;
                    Docto       WITH loc_cDocto, ;
                    Hists       WITH loc_cHists, ;
                    Emps        WITH cursor_4c_MvCcr.Emps, ;
                    Cecus       WITH cursor_4c_MvCcr.Emps, ;
                    Transacaos  WITH loc_cTransacaos, ;
                    IClis       WITH TratarNulo(cursor_4c_CliDestino.IClis, ""), ;
                    Razaos      WITH IIF(EMPTY(TratarNulo(cursor_4c_CliDestino.Razaos, "")), ;
                                        TratarNulo(cursor_4c_CliDestino.RClis, ""), ;
                                        TratarNulo(cursor_4c_CliDestino.Razaos, "")), ;
                    Cpfs        WITH TratarNulo(cursor_4c_CliDestino.Cpfs, "")

            IF cursor_4c_MvCcr.Nopers = 1
                USE IN cursor_4c_CliDestino
                LOOP
            ENDIF

            *-- Lancamento 2 (contra-partida)
            loc_cControle    = TRANSFORM(cursor_4c_MvCcr.Nopers)
            loc_nControleAtu = cursor_4c_MvCcr.Nopers
            loc_cOpeAtual    = cursor_4c_MvCcr.Opers
            loc_cEmpLanc     = cursor_4c_MvCcr.Emps
            loc_lManual      = .F.

            loc_cSQL = "SELECT Tipos FROM SigMvCcr WHERE Nopers = " + TRANSFORM(loc_nControleAtu)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcrTipos")
            IF loc_nResultado >= 0 AND USED("cursor_4c_MvCcrTipos")
                SELECT cursor_4c_MvCcrTipos
                LOCATE FOR ALLTRIM(Tipos) == "M"
                loc_lManual = FOUND()
                USE IN cursor_4c_MvCcrTipos
            ENDIF

            DO CASE
                CASE cursor_4c_MvCcr.Autos AND "LOTE" $ TratarNulo(cursor_4c_MvCcr.Hists, "")
                    IF !THIS.ProcessarLoteCheques(loc_nNumlote, loc_cOpeAtual, loc_cEmpLanc)
                        USE IN cursor_4c_CliDestino
                        loc_oProg.Complete(.T.)
                        RETURN .F.
                    ENDIF

                CASE (ALLTRIM(cursor_4c_MvCcr.Dopes) != "PAGAMENTO" AND ALLTRIM(cursor_4c_MvCcr.Dopes) != "RECEBIMENTO") OR ;
                        (ALLTRIM(cursor_4c_MvCcr.Dopes) = "PAGAMENTO" AND loc_lManual) OR ;
                        (ALLTRIM(cursor_4c_MvCcr.Dopes) = "RECEBIMENTO" AND loc_lManual)

                    IF !THIS.ProcessarContraPartidaSimples(loc_cControle, loc_cOpeAtual)
                        USE IN cursor_4c_CliDestino
                        loc_oProg.Complete(.T.)
                        RETURN .F.
                    ENDIF

                OTHERWISE
                    loc_cOperacao = ALLTRIM(cursor_4c_MvCcr.Dopes)
                    loc_cLcKey = cursor_4c_MvCcr.Emps + cursor_4c_MvCcr.Dopes + STR(cursor_4c_MvCcr.Numes, 6)

                    loc_nValOcoTit = THIS.ProcessarRateioTitulos(loc_cLcKey, loc_cOperacao, loc_cOpeAtual, @loc_nValorDesp)
                    IF loc_nValOcoTit = -1
                        USE IN cursor_4c_CliDestino
                        loc_oProg.Complete(.T.)
                        RETURN .F.
                    ENDIF

                    IF loc_nValorDesp = 0
                        loc_nVpago = 0
                    ELSE
                        loc_nVpago = loc_nValLan1 / loc_nValorDesp
                    ENDIF

                    loc_nValContra = THIS.GerarLancamentosRateio(loc_cLcKey, loc_cOperacao, loc_nVpago)
                    IF loc_nValContra = -1
                        USE IN cursor_4c_CliDestino
                        loc_oProg.Complete(.T.)
                        RETURN .F.
                    ENDIF

                    *-- Acerto da diferenca (rateio pode nao fechar 100% por arredondamento)
                    loc_nVrDif = loc_nValLan1 - loc_nValContra
                    IF loc_nVrDif != 0
                        SELECT cursor_4c_MovAux
                        IF VAL(Debs) != 0
                            REPLACE Debs WITH TRANSFORM((VAL(Debs) / 100 + loc_nVrDif) * 100, "@L 999999999999")
                        ELSE
                            REPLACE Creds WITH TRANSFORM((VAL(Creds) / 100 + loc_nVrDif) * 100, "@L 999999999999")
                        ENDIF
                    ENDIF
            ENDCASE

            USE IN cursor_4c_CliDestino

            *-- Operacoes de PAGAMENTO/RECEBIMENTO ja tratadas por completo
            *-- nesta iteracao (todas as parcelas do mesmo titulo) nao devem
            *-- ser reprocessadas quando o Scan passar pelas demais linhas do
            *-- mesmo EmpDopNums.
            IF ALLTRIM(cursor_4c_MvCcr.Dopes) = "PAGAMENTO" OR ALLTRIM(cursor_4c_MvCcr.Dopes) = "RECEBIMENTO"
                loc_cChave = cursor_4c_MvCcr.EmpDopNums
                SELECT cursor_4c_MvCcr
                DELETE FOR EmpDopNums == loc_cChave
                GO loc_nRegMvCcr
            ENDIF
        ENDSCAN

        loc_oProg.Complete(.T.)
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ProcessarLoteCheques - contra-lancamento para operacoes pagas/recebidas
    * por lote de cheques (SigCqChm), equivalente ao ramo SQL Server do
    * "Case crSigMvCcr.Autos And LOTE $ Hists" do Processamento legado.
    *==========================================================================
    PROTECTED FUNCTION ProcessarLoteCheques(par_nNumlote, par_cOpeAtual, par_cEmpLanc)
        LOCAL loc_cSQL, loc_nResultado, loc_cControle, loc_cContContaGrupo, loc_cContaContabilCliente
        LOCAL loc_cContabs, loc_nDebs, loc_nCreds, loc_cHists

        SELECT cursor_4c_LoteProc
        APPEND BLANK
        REPLACE Lotes WITH par_nNumlote

        loc_cSQL = "SELECT Emps, NumOs FROM SigCqChm WHERE NumLotes = " + TRANSFORM(par_nNumlote)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chm")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (crSigCqChm)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Chm
        SCAN
            loc_cControle = ALLTRIM(cursor_4c_Chm.Emps) + ALLTRIM(STR(cursor_4c_Chm.NumOs, 7))

            loc_cSQL = "SELECT Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, Hists, " + ;
                "Hist2s, Valors, Opers, Autos, Nopers, Nfs, Titulos, Tipos, EmpDopNums, EspecieNfs, " + ;
                "EmpDopNcs FROM SigMvCcr WHERE VOpers = " + EscaparSQL(loc_cControle)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcrNop")
            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o (crSigMvCcr - VOpers)" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "")
                RETURN .F.
            ENDIF
            IF RECCOUNT("cursor_4c_MvCcrNop") = 0
                USE IN cursor_4c_MvCcrNop
                loc_cControle = par_cEmpLanc + ALLTRIM(STR(cursor_4c_Chm.NumOs, 7))
                loc_cSQL = "SELECT Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, Hists, " + ;
                    "Hist2s, Valors, Opers, Autos, Nopers, Nfs, Titulos, Tipos, EmpDopNums, EspecieNfs, " + ;
                    "EmpDopNcs FROM SigMvCcr WHERE VOpers = " + EscaparSQL(loc_cControle)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcrNop")
                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "Falha na Conex" + CHR(227) + "o (crSigMvCcr - VOpers)" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "")
                    RETURN .F.
                ENDIF
            ENDIF

            SELECT cursor_4c_MvCcrNop
            SCAN
                IF (ALLTRIM(Opers) != par_cOpeAtual) AND ;
                        (ALLTRIM(Grupos) != THIS.this_cGrupoPagamentos) AND ;
                        (ALLTRIM(Grupos) != THIS.this_cGrupoRecebimentos)

                    *-- Definicao da conta contabil da contra-partida
                    loc_cContContaGrupo = ""
                    IF SEEK(ALLTRIM(cursor_4c_MvCcrNop.Grupos), "cursor_4c_TodosGrupos", "Codigos")
                        loc_cContContaGrupo = ALLTRIM(TratarNulo(cursor_4c_TodosGrupos.ContConts, ""))
                    ENDIF

                    loc_cSQL = "SELECT IClis, RClis, Razaos, Cpfs FROM SigCdCli WHERE IClis = " + ;
                        EscaparSQL(cursor_4c_MvCcrNop.SContas) + " ORDER BY CContabs"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliOrigem") < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            "Falha na Conex" + CHR(227) + "o (LocalCli)" + CHR(13) + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "")
                        RETURN .F.
                    ENDIF

                    loc_cSQL = "SELECT CContabs, IClis, RClis, Razaos, Cpfs, TpHists, Hists FROM SigCdCli " + ;
                        "WHERE IClis = " + EscaparSQL(cursor_4c_MvCcrNop.Contas) + " ORDER BY CContabs"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliDestino2") < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            "Falha na Conex" + CHR(227) + "o (crSigCdCli)" + CHR(13) + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "")
                        USE IN cursor_4c_CliOrigem
                        RETURN .F.
                    ENDIF

                    loc_cContaContabilCliente = ALLTRIM(TratarNulo(cursor_4c_CliDestino2.CContabs, ""))
                    loc_cHists = SUBSTR(ALLTRIM(TratarNulo(cursor_4c_MvCcrNop.Hists, "")) + " " + ;
                        TratarNulo(cursor_4c_MvCcrNop.Hist2s, ""), 1, 70)

                    loc_cContabs = THIS.ResolverContaContabil(loc_cContContaGrupo, loc_cContaContabilCliente, ;
                        ALLTRIM(cursor_4c_MvCcrNop.Contas), cursor_4c_MvCcrNop.Datas, loc_cHists, cursor_4c_MvCcrNop.Valors)

                    IF cursor_4c_MvCcrNop.Opers = "D"
                        loc_nDebs  = cursor_4c_MvCcrNop.Valors
                        loc_nCreds = 0
                    ELSE
                        loc_nDebs  = 0
                        loc_nCreds = cursor_4c_MvCcrNop.Valors
                    ENDIF

                    loc_cHists = STRTRAN(STRTRAN(STRTRAN(loc_cHists, CHR(1), ""), CHR(13), ""), CHR(10), "")

                    SELECT cursor_4c_MovAux
                    APPEND BLANK
                    REPLACE Contas WITH loc_cContabs, ;
                            Debs   WITH TRANSFORM(loc_nDebs * 100, "@L 999999999999"), ;
                            Creds  WITH TRANSFORM(loc_nCreds * 100, "@L 999999999999"), ;
                            Hists  WITH loc_cHists, ;
                            Emps   WITH cursor_4c_MvCcrNop.Emps, ;
                            Cecus  WITH cursor_4c_MvCcrNop.Emps, ;
                            IClis  WITH TratarNulo(cursor_4c_CliOrigem.IClis, ""), ;
                            Razaos WITH IIF(EMPTY(TratarNulo(cursor_4c_CliOrigem.Razaos, "")), ;
                                        TratarNulo(cursor_4c_CliOrigem.RClis, ""), ;
                                        TratarNulo(cursor_4c_CliOrigem.Razaos, "")), ;
                            Cpfs   WITH TratarNulo(cursor_4c_CliOrigem.Cpfs, "")

                    USE IN cursor_4c_CliOrigem
                    USE IN cursor_4c_CliDestino2
                ENDIF
                SELECT cursor_4c_MvCcrNop
            ENDSCAN
            USE IN cursor_4c_MvCcrNop
            SELECT cursor_4c_Chm
        ENDSCAN
        USE IN cursor_4c_Chm

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ProcessarContraPartidaSimples - contra-lancamento das demais operacoes
    * (que nao sao PAGAMENTO/RECEBIMENTO automatico), equivalente ao ramo SQL
    * Server da clausula "Case (Dopes <> PAGAMENTO...) Or (...Manual)".
    *==========================================================================
    PROTECTED FUNCTION ProcessarContraPartidaSimples(par_cControle, par_cOpeAtual)
        LOCAL loc_cSQL, loc_nResultado, loc_cContContaGrupo, loc_cContaContabilCliente
        LOCAL loc_cContabs, loc_nDebs, loc_nCreds, loc_cHists

        loc_cSQL = "SELECT Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, Hists, " + ;
            "Hist2s, Valors, Opers, Autos, Nopers, Nfs, Titulos, Tipos, EmpDopNums, EspecieNfs, " + ;
            "EmpDopNcs, Cotacaos, SValors, Valocurs FROM SigMvCcr WHERE Nopers = " + par_cControle
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcrNop")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (crSigMvCcr - Nopers)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_MvCcrNop
        SCAN
            IF SEEK(ALLTRIM(cursor_4c_MvCcrNop.Grupos), "cursor_4c_Grupos", "Codigos")
                LOOP
            ENDIF

            IF (ALLTRIM(Opers) != par_cOpeAtual) AND ;
                    (ALLTRIM(Grupos) != THIS.this_cGrupoPagamentos) AND ;
                    (ALLTRIM(Grupos) != THIS.this_cGrupoRecebimentos)

                loc_cContContaGrupo = ""
                IF SEEK(ALLTRIM(cursor_4c_MvCcrNop.Grupos), "cursor_4c_TodosGrupos", "Codigos")
                    loc_cContContaGrupo = ALLTRIM(TratarNulo(cursor_4c_TodosGrupos.ContConts, ""))
                ENDIF

                loc_cSQL = "SELECT IClis, RClis, Razaos, Cpfs FROM SigCdCli WHERE IClis = " + ;
                    EscaparSQL(cursor_4c_MvCcrNop.SContas) + " ORDER BY CContabs"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliOrigem") < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "Falha na Conex" + CHR(227) + "o (LocalCli)" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "")
                    USE IN cursor_4c_MvCcrNop
                    RETURN .F.
                ENDIF

                loc_cSQL = "SELECT CContabs, IClis, RClis, Razaos, Cpfs, TpHists, Hists FROM SigCdCli " + ;
                    "WHERE IClis = " + EscaparSQL(cursor_4c_MvCcrNop.Contas) + " ORDER BY CContabs"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliDestino2") < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "Falha na Conex" + CHR(227) + "o (crSigCdCli)" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "")
                    USE IN cursor_4c_CliOrigem
                    USE IN cursor_4c_MvCcrNop
                    RETURN .F.
                ENDIF

                loc_cContaContabilCliente = ALLTRIM(TratarNulo(cursor_4c_CliDestino2.CContabs, ""))
                loc_cHists = SUBSTR(ALLTRIM(TratarNulo(cursor_4c_MvCcrNop.Hists, "")) + " " + ;
                    TratarNulo(cursor_4c_MvCcrNop.Hist2s, ""), 1, 70)

                loc_cContabs = THIS.ResolverContaContabil(loc_cContContaGrupo, loc_cContaContabilCliente, ;
                    ALLTRIM(cursor_4c_MvCcrNop.Contas), cursor_4c_MvCcrNop.Datas, loc_cHists, cursor_4c_MvCcrNop.Valors)

                IF cursor_4c_MvCcrNop.Opers = "D"
                    loc_nDebs  = IIF(cursor_4c_MvCcrNop.Cotacaos != 0 AND cursor_4c_MvCcrNop.Cotacaos != 1, ;
                        cursor_4c_MvCcrNop.SValors, cursor_4c_MvCcrNop.Valors)
                    loc_nCreds = 0
                ELSE
                    loc_nDebs  = 0
                    loc_nCreds = IIF(cursor_4c_MvCcrNop.Cotacaos != 0 AND cursor_4c_MvCcrNop.Cotacaos != 1, ;
                        cursor_4c_MvCcrNop.SValors, cursor_4c_MvCcrNop.Valors)
                ENDIF

                loc_cHists = STRTRAN(STRTRAN(STRTRAN(loc_cHists, CHR(1), ""), CHR(13), ""), CHR(10), "")

                SELECT cursor_4c_MovAux
                APPEND BLANK
                REPLACE Contas WITH loc_cContabs, ;
                        Debs   WITH TRANSFORM(loc_nDebs * 100, "@L 999999999999"), ;
                        Creds  WITH TRANSFORM(loc_nCreds * 100, "@L 999999999999"), ;
                        Docto  WITH ALLTRIM(cursor_4c_MvCcrNop.Nfs), ;
                        Hists  WITH loc_cHists, ;
                        Emps   WITH cursor_4c_MvCcrNop.Emps, ;
                        Cecus  WITH cursor_4c_MvCcrNop.Emps, ;
                        IClis  WITH TratarNulo(cursor_4c_CliOrigem.IClis, ""), ;
                        Razaos WITH IIF(EMPTY(TratarNulo(cursor_4c_CliOrigem.Razaos, "")), ;
                                    TratarNulo(cursor_4c_CliOrigem.RClis, ""), ;
                                    TratarNulo(cursor_4c_CliOrigem.Razaos, "")), ;
                        Cpfs   WITH TratarNulo(cursor_4c_CliOrigem.Cpfs, "")

                USE IN cursor_4c_CliOrigem
                USE IN cursor_4c_CliDestino2
            ENDIF
            SELECT cursor_4c_MvCcrNop
        ENDSCAN
        USE IN cursor_4c_MvCcrNop

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ProcessarRateioTitulos - 1a passada do rateio contra SigCdPit (apenas
    * ACUMULA o total das despesas/recebimentos do titulo e registra
    * inconsistencias "sem centro de custo"/"nao encontrado"), equivalente
    * ao PRIMEIRO "Select crSigCdPit / Scan" do ramo Otherwise do legado.
    * Retorna o total de ocorrencias (ValOco acumulado) ou -1 em erro; o
    * total das despesas sai por referencia em par_nValorDesp.
    *==========================================================================
    PROTECTED FUNCTION ProcessarRateioTitulos(par_cLcKey, par_cOperacao, par_cOpeAtual, par_nValorDesp)
        LOCAL loc_cSQL, loc_nResultado, loc_nValorDesp, loc_nPNop, loc_cMoeDiv, loc_nCotDiv
        LOCAL loc_nVTitCC, loc_lProvis, loc_cChaveBusca, loc_nValor

        loc_nValorDesp = 0

        loc_cSQL = "SELECT Nopers, Emps, Dopes, Numes, Hists, Acertos, Grupos, Contas, Moedas, " + ;
            "Cotacaos FROM SigCdPit WHERE EmpDopNums = " + EscaparSQL(par_cLcKey)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pit")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (crSigCdPit)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "")
            par_nValorDesp = 0
            RETURN -1
        ENDIF

        SELECT cursor_4c_Pit
        SCAN
            IF (par_cOperacao = "PAGAMENTO" AND par_cOpeAtual = "D") OR ;
                    (par_cOperacao = "RECEBIMENTO" AND par_cOpeAtual = "C")
                *** Lancamento com valor inverso (devolucao de compra/venda)
                LOOP
            ENDIF

            loc_nVTitCC = 0
            loc_cMoeDiv = cursor_4c_Pit.Moedas
            loc_nCotDiv = cursor_4c_Pit.Cotacaos
            loc_nPNop   = cursor_4c_Pit.Nopers

            loc_cSQL = "SELECT * FROM SigMvCcr WHERE Nopers = " + TRANSFORM(loc_nPNop)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcr1") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o (TmpMccr1)" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "")
                USE IN cursor_4c_Pit
                par_nValorDesp = 0
                RETURN -1
            ENDIF

            loc_lProvis = .T.
            IF SQLEXEC(gnConnHandle, "SELECT Provs FROM SigCdEsp WHERE Especies = " + ;
                    EscaparSQL(cursor_4c_MvCcr1.EspecieNfs), "cursor_4c_Espes") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o (TmpEspes)" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "")
                USE IN cursor_4c_MvCcr1
                USE IN cursor_4c_Pit
                par_nValorDesp = 0
                RETURN -1
            ENDIF
            loc_lProvis = (RECCOUNT("cursor_4c_Espes") = 0 OR cursor_4c_Espes.Provs = 1)
            USE IN cursor_4c_Espes

            SELECT cursor_4c_MvCcr1
            GO TOP
            IF !EOF("cursor_4c_MvCcr1")
                IF cursor_4c_MvCcr1.Numcs = 0
                    loc_cChaveBusca = TRANSFORM(cursor_4c_MvCcr1.Nopers)
                    loc_cSQL = "SELECT Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, " + ;
                        "Hists, Hist2s, Valors, Valocurs, Opers, Autos, Nopers, Nfs, Titulos, Tipos, EmpDopNums, " + ;
                        "EspecieNfs, EmpDopNcs FROM SigMvCcr WHERE Nopers = " + loc_cChaveBusca
                ELSE
                    loc_cChaveBusca = ALLTRIM(cursor_4c_MvCcr1.EmpDopNcs)
                    loc_cSQL = "SELECT Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, " + ;
                        "Hists, Hist2s, Valors, Valocurs, Opers, Autos, Nopers, Nfs, Titulos, Tipos, EmpDopNums, " + ;
                        "EspecieNfs, EmpDopNcs FROM SigMvCcr WHERE EmpDopNcs = " + EscaparSQL(loc_cChaveBusca)
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcrNop") < 0
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "Falha na Conex" + CHR(227) + "o (TmpMccr)" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "")
                    USE IN cursor_4c_MvCcr1
                    USE IN cursor_4c_Pit
                    par_nValorDesp = 0
                    RETURN -1
                ENDIF

                SELECT cursor_4c_MvCcrNop
                SCAN
                    IF ALLTRIM(Grupos) = THIS.this_cGrupoPagamentos OR ;
                            ALLTRIM(Grupos) = THIS.this_cGrupoRecebimentos OR ;
                            ALLTRIM(Tipos) = "O"
                        LOOP
                    ENDIF

                    IF (par_cOperacao = "PAGAMENTO" AND Opers = "D") OR ;
                            (par_cOperacao = "RECEBIMENTO" AND Opers = "C")
                        IF loc_cMoeDiv != THIS.this_cMoedaCheque
                            loc_nValor = ROUND((cursor_4c_MvCcrNop.Valors + cursor_4c_MvCcrNop.Valocurs) * loc_nCotDiv, 2)
                        ELSE
                            loc_nValor = cursor_4c_MvCcrNop.Valors + cursor_4c_MvCcrNop.Valocurs
                        ENDIF
                        loc_nValorDesp = loc_nValorDesp + loc_nValor
                        loc_nVTitCC    = loc_nVTitCC    + loc_nValor
                    ENDIF
                ENDSCAN
                USE IN cursor_4c_MvCcrNop

                IF loc_nVTitCC = 0
                    THIS.RegistrarSemConta(IIF(!loc_lProvis, ALLTRIM(cursor_4c_MvCcr1.Contas), ;
                        ALLTRIM(cursor_4c_MvCcr1.SContas)), cursor_4c_MvCcr1.Datas, ;
                        ALLTRIM(cursor_4c_Pit.Emps) + " / " + ALLTRIM(cursor_4c_Pit.Dopes) + " / " + ;
                        STR(cursor_4c_Pit.Numes, 6) + ALLTRIM(cursor_4c_Pit.Hists), ;
                        cursor_4c_Pit.Acertos, THIS.ObterTextoOcorrencia(3))
                ENDIF
            ELSE
                THIS.RegistrarSemConta(IIF(!loc_lProvis, ALLTRIM(cursor_4c_MvCcr1.Contas), ;
                    ALLTRIM(cursor_4c_MvCcr1.SContas)), cursor_4c_MvCcr1.Datas, ;
                    ALLTRIM(cursor_4c_Pit.Emps) + " / " + ALLTRIM(cursor_4c_Pit.Dopes) + " / " + ;
                    STR(cursor_4c_Pit.Numes, 6) + ALLTRIM(cursor_4c_Pit.Hists), ;
                    cursor_4c_Pit.Acertos, THIS.ObterTextoOcorrencia(4))
            ENDIF

            USE IN cursor_4c_MvCcr1
            SELECT cursor_4c_Pit
        ENDSCAN
        USE IN cursor_4c_Pit

        par_nValorDesp = loc_nValorDesp
        RETURN 0
    ENDFUNC

    *==========================================================================
    * GerarLancamentosRateio - 2a passada do rateio contra SigCdPit (gera de
    * fato os lancamentos contabeis proporcionais ao valor pago/recebido),
    * equivalente ao SEGUNDO "Select crSigCdPit / Scan" do ramo Otherwise.
    * Retorna o total lancado (ValContra) ou -1 em erro.
    *==========================================================================
    PROTECTED FUNCTION GerarLancamentosRateio(par_cLcKey, par_cOperacao, par_nVpago)
        LOCAL loc_cSQL, loc_nResultado, loc_nValContra, loc_nPNop, loc_cMoeDiv, loc_nCotDiv
        LOCAL loc_nValOcoTit, loc_cChaveBusca, loc_cContContaGrupo, loc_cContaContabilCliente
        LOCAL loc_cContabs, loc_nValor, loc_nDebs, loc_nCreds, loc_cHists, loc_cGrupoPag
        LOCAL loc_cNumeroCheque, loc_cHistPrinc, loc_nOrdemHist, loc_cHist, loc_lProvis

        loc_nValContra = 0

        loc_cSQL = "SELECT Nopers, Emps, Dopes, Numes, Hists, Acertos, Grupos, Contas, Moedas, " + ;
            "Cotacaos FROM SigCdPit WHERE EmpDopNums = " + EscaparSQL(par_cLcKey)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pit")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (crSigCdPit)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "")
            RETURN -1
        ENDIF

        SELECT cursor_4c_Pit
        SCAN
            IF (par_cOperacao = "PAGAMENTO" AND Opers = "D") OR ;
                    (par_cOperacao = "RECEBIMENTO" AND Opers = "C")
                *** Lancamento com valor inverso (devolucao de compra/venda)
                LOOP
            ENDIF

            loc_cMoeDiv = cursor_4c_Pit.Moedas
            loc_nCotDiv = cursor_4c_Pit.Cotacaos
            loc_nPNop   = cursor_4c_Pit.Nopers
            loc_cGrupoPag = ALLTRIM(cursor_4c_Pit.Grupos)

            loc_cSQL = "SELECT * FROM SigMvCcr WHERE Nopers = " + TRANSFORM(loc_nPNop)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcr1") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o (TmpMccr1)" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "")
                USE IN cursor_4c_Pit
                RETURN -1
            ENDIF

            loc_lProvis = .T.
            IF SQLEXEC(gnConnHandle, "SELECT Provs FROM SigCdEsp WHERE Especies = " + ;
                    EscaparSQL(cursor_4c_MvCcr1.EspecieNfs), "cursor_4c_Espes") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o (TmpEspes)" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "")
                USE IN cursor_4c_MvCcr1
                USE IN cursor_4c_Pit
                RETURN -1
            ENDIF
            loc_lProvis = (RECCOUNT("cursor_4c_Espes") = 0 OR cursor_4c_Espes.Provs = 1)
            USE IN cursor_4c_Espes

            SELECT cursor_4c_MvCcr1
            GO TOP
            IF !EOF("cursor_4c_MvCcr1")
                IF cursor_4c_MvCcr1.Numcs = 0
                    loc_cChaveBusca = TRANSFORM(cursor_4c_MvCcr1.Nopers)
                    loc_cSQL = "SELECT Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, " + ;
                        "Hists, Hist2s, Valors, Valocurs, Opers, Autos, Nopers, Nfs, Titulos, Tipos, EmpDopNums, " + ;
                        "EspecieNfs, EmpDopNcs FROM SigMvCcr WHERE Nopers = " + loc_cChaveBusca
                ELSE
                    loc_cChaveBusca = ALLTRIM(cursor_4c_MvCcr1.EmpDopNcs)
                    loc_cSQL = "SELECT Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, " + ;
                        "Hists, Hist2s, Valors, Valocurs, Opers, Autos, Nopers, Nfs, Titulos, Tipos, EmpDopNums, " + ;
                        "EspecieNfs, EmpDopNcs FROM SigMvCcr WHERE EmpDopNcs = " + EscaparSQL(loc_cChaveBusca)
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcrNop") < 0
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "Falha na Conex" + CHR(227) + "o (TmpMccr)" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "")
                    USE IN cursor_4c_MvCcr1
                    USE IN cursor_4c_Pit
                    RETURN -1
                ENDIF

                loc_nValOcoTit = 0
                SELECT cursor_4c_MvCcrNop
                SCAN
                    IF ALLTRIM(Grupos) = THIS.this_cGrupoPagamentos OR ;
                            ALLTRIM(Grupos) = THIS.this_cGrupoRecebimentos OR ALLTRIM(Tipos) = "O"
                        *-- Contas transitorias / lancamentos de ocorrencias.
                        *-- Descontar as ocorrencias do total das despesas
                        *-- quando existe transitoria (so quando NAO e tipo O)
                        IF ALLTRIM(Tipos) != "O" AND cursor_4c_MvCcrNop.Valocurs != 0
                            IF loc_cMoeDiv != THIS.this_cMoedaCheque
                                loc_nValOcoTit = loc_nValOcoTit + ROUND(cursor_4c_MvCcrNop.Valocurs * loc_nCotDiv, 2)
                            ELSE
                                loc_nValOcoTit = loc_nValOcoTit + cursor_4c_MvCcrNop.Valocurs
                            ENDIF
                        ENDIF
                        LOOP
                    ENDIF

                    IF (par_cOperacao = "PAGAMENTO" AND Opers = "D") OR ;
                            (par_cOperacao = "RECEBIMENTO" AND Opers = "C")

                        *-- Definicao da conta contabil
                        loc_cContContaGrupo = ""
                        IF !loc_lProvis
                            IF SEEK(ALLTRIM(cursor_4c_MvCcrNop.Grupos), "cursor_4c_TodosGrupos", "Codigos")
                                loc_cContContaGrupo = ALLTRIM(TratarNulo(cursor_4c_TodosGrupos.ContConts, ""))
                            ENDIF
                        ELSE
                            IF SEEK(loc_cGrupoPag, "cursor_4c_TodosGrupos", "Codigos")
                                loc_cContContaGrupo = ALLTRIM(TratarNulo(cursor_4c_TodosGrupos.ContConts, ""))
                            ENDIF
                        ENDIF

                        IF SQLEXEC(gnConnHandle, "SELECT CContabs, IClis, RClis, Razaos, Cpfs, TpHists, " + ;
                                "Hists FROM SigCdCli WHERE IClis = " + EscaparSQL(cursor_4c_MvCcrNop.SContas) + ;
                                " ORDER BY CContabs", "cursor_4c_CliOrigem") < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                "Falha na Conex" + CHR(227) + "o (LocalCli)" + CHR(13) + CapturarErroSQL()
                            MsgErro(THIS.this_cMensagemErro, "")
                            USE IN cursor_4c_MvCcrNop
                            USE IN cursor_4c_MvCcr1
                            USE IN cursor_4c_Pit
                            RETURN -1
                        ENDIF

                        IF SQLEXEC(gnConnHandle, "SELECT CContabs, IClis, RClis, Razaos, Cpfs, TpHists, " + ;
                                "Hists FROM SigCdCli WHERE IClis = " + EscaparSQL(cursor_4c_MvCcrNop.Contas) + ;
                                " ORDER BY CContabs", "cursor_4c_CliDestino2") < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                "Falha na Conex" + CHR(227) + "o (crSigCdCli)" + CHR(13) + CapturarErroSQL()
                            MsgErro(THIS.this_cMensagemErro, "")
                            USE IN cursor_4c_CliOrigem
                            USE IN cursor_4c_MvCcrNop
                            USE IN cursor_4c_MvCcr1
                            USE IN cursor_4c_Pit
                            RETURN -1
                        ENDIF

                        *-- Numero do cheque do pagamento (diferenciar de debito automatico)
                        IF SQLEXEC(gnConnHandle, "SELECT Numeros FROM SigMvPar A, SigOpFp B, SigCdFrm C " + ;
                                "WHERE A.EmpDopNums = " + EscaparSQL(ALLTRIM(cursor_4c_MvCcrNop.EmpDopNums)) + ;
                                " AND A.FPags = B.FPags AND B.Formas = C.Formas AND C.Infos = 'C'", ;
                                "cursor_4c_Par") < 0
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                "Falha na Conex" + CHR(227) + "o (crSigMvPar)" + CHR(13) + CapturarErroSQL()
                            MsgErro(THIS.this_cMensagemErro, "")
                            USE IN cursor_4c_CliOrigem
                            USE IN cursor_4c_CliDestino2
                            USE IN cursor_4c_MvCcrNop
                            USE IN cursor_4c_MvCcr1
                            USE IN cursor_4c_Pit
                            RETURN -1
                        ENDIF

                        IF !loc_lProvis
                            loc_cContaContabilCliente = ALLTRIM(TratarNulo(cursor_4c_CliDestino2.CContabs, ""))
                        ELSE
                            loc_cContaContabilCliente = ALLTRIM(TratarNulo(cursor_4c_CliOrigem.CContabs, ""))
                        ENDIF
                        loc_cHists = SUBSTR(TratarNulo(cursor_4c_MvCcrNop.Hists, "") + TratarNulo(cursor_4c_MvCcrNop.Hist2s, ""), 1, 70)
                        loc_cContabs = THIS.ResolverContaContabil(loc_cContContaGrupo, loc_cContaContabilCliente, ;
                            ALLTRIM(cursor_4c_MvCcrNop.Contas), cursor_4c_MvCcrNop.Datas, loc_cHists, cursor_4c_MvCcrNop.Valors)

                        IF loc_cMoeDiv != THIS.this_cMoedaCheque
                            loc_nValor = ROUND((cursor_4c_MvCcrNop.Valors + loc_nValOcoTit) * loc_nCotDiv, 2)
                        ELSE
                            loc_nValor = cursor_4c_MvCcrNop.Valors + loc_nValOcoTit
                        ENDIF
                        loc_nValor = ROUND(loc_nValor * par_nVpago, 2)
                        loc_nValContra = loc_nValContra + loc_nValor

                        IF cursor_4c_MvCcrNop.Opers = "D"
                            loc_nDebs  = loc_nValor
                            loc_nCreds = 0
                        ELSE
                            loc_nDebs  = 0
                            loc_nCreds = loc_nValor
                        ENDIF

                        loc_cNumeroCheque = IIF(!EMPTY(TratarNulo(cursor_4c_Par.Numeros, "")), ;
                            "-Chq:" + ALLTRIM(cursor_4c_Par.Numeros), "")

                        IF THIS.this_nConfigHistorico = 2
                            *-- Historico composto (TpHists do cliente do titulo)
                            IF SQLEXEC(gnConnHandle, "SELECT CContabs, IClis, RClis, Razaos, Cpfs, TpHists, " + ;
                                    "Hists FROM SigCdCli WHERE IClis = " + EscaparSQL(cursor_4c_Pit.Contas) + ;
                                    " ORDER BY CContabs", "cursor_4c_CliPit") < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                    "Falha na Conex" + CHR(227) + "o (crSigCdCli - 6)" + CHR(13) + CapturarErroSQL()
                                MsgErro(THIS.this_cMensagemErro, "")
                                USE IN cursor_4c_Par
                                USE IN cursor_4c_CliOrigem
                                USE IN cursor_4c_CliDestino2
                                USE IN cursor_4c_MvCcrNop
                                USE IN cursor_4c_MvCcr1
                                USE IN cursor_4c_Pit
                                RETURN -1
                            ENDIF

                            IF SQLEXEC(gnConnHandle, "SELECT CContabs, IClis, RClis, Razaos, Cpfs, TpHists, " + ;
                                    "Hists FROM SigCdCli WHERE IClis = " + EscaparSQL(cursor_4c_MvCcr1.Contems) + ;
                                    " ORDER BY CContabs", "cursor_4c_CliContem") < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                    "Falha na Conex" + CHR(227) + "o (TmpCliCONTEMS)" + CHR(13) + CapturarErroSQL()
                                MsgErro(THIS.this_cMensagemErro, "")
                                USE IN cursor_4c_CliPit
                                USE IN cursor_4c_Par
                                USE IN cursor_4c_CliOrigem
                                USE IN cursor_4c_CliDestino2
                                USE IN cursor_4c_MvCcrNop
                                USE IN cursor_4c_MvCcr1
                                USE IN cursor_4c_Pit
                                RETURN -1
                            ENDIF

                            loc_cHists = PROPER(SUBSTR(par_cOperacao, 1, 3))
                            loc_nOrdemHist = 1
                            loc_cHist = ""

                            DO CASE
                                CASE cursor_4c_CliPit.TpHists = 1
                                    loc_cHists = ALLTRIM(SUBSTR(IIF(EMPTY(TratarNulo(cursor_4c_CliContem.Razaos, "")), ;
                                        TratarNulo(cursor_4c_CliContem.RClis, ""), TratarNulo(cursor_4c_CliContem.Razaos, "")), 1, 20))
                                    IF !EMPTY(TratarNulo(cursor_4c_CliPit.Hists, ""))
                                        loc_cHist = ALLTRIM(cursor_4c_CliPit.Hists) + " " + ALLTRIM(cursor_4c_MvCcrNop.Nfs)
                                    ELSE
                                        loc_cHist = ALLTRIM(cursor_4c_MvCcrNop.Nfs)
                                    ENDIF
                                    loc_nOrdemHist = 1
                                CASE cursor_4c_CliPit.TpHists = 2
                                    loc_cHists = ALLTRIM(SUBSTR(IIF(EMPTY(TratarNulo(cursor_4c_CliContem.Razaos, "")), ;
                                        TratarNulo(cursor_4c_CliContem.RClis, ""), TratarNulo(cursor_4c_CliContem.Razaos, "")), 1, 20))
                                    IF !EMPTY(TratarNulo(cursor_4c_CliPit.Hists, ""))
                                        loc_cHist = ALLTRIM(cursor_4c_CliPit.Hists) + " " + ALLTRIM(cursor_4c_MvCcrNop.Titulos)
                                    ELSE
                                        loc_cHist = ALLTRIM(cursor_4c_MvCcrNop.Titulos)
                                    ENDIF
                                    loc_nOrdemHist = 1
                                CASE cursor_4c_CliPit.TpHists = 3
                                    IF !EMPTY(TratarNulo(cursor_4c_CliPit.Hists, ""))
                                        loc_cHist = ALLTRIM(cursor_4c_CliPit.Hists) + " " + SUBSTR(DTOC(cursor_4c_MvCcrNop.Datas), 4, 7)
                                    ELSE
                                        loc_cHist = SUBSTR(DTOC(cursor_4c_MvCcrNop.Datas), 4, 7)
                                    ENDIF
                                    loc_cHists = ALLTRIM(SUBSTR(IIF(EMPTY(TratarNulo(cursor_4c_CliContem.Razaos, "")), ;
                                        TratarNulo(cursor_4c_CliContem.RClis, ""), TratarNulo(cursor_4c_CliContem.Razaos, "")), 1, 20))
                                    loc_nOrdemHist = 2
                                CASE cursor_4c_CliPit.TpHists = 4
                                    *-- nenhum
                                OTHERWISE
                                    loc_cHist  = ALLTRIM(cursor_4c_MvCcrNop.Nfs)
                                    loc_cHists = ALLTRIM(SUBSTR(IIF(EMPTY(TratarNulo(cursor_4c_CliContem.Razaos, "")), ;
                                        TratarNulo(cursor_4c_CliContem.RClis, ""), TratarNulo(cursor_4c_CliContem.Razaos, "")), 1, 20))
                            ENDCASE

                            DO CASE
                                CASE loc_nOrdemHist = 1
                                    loc_cHists = PROPER(SUBSTR(par_cOperacao, 1, 3)) + " " + loc_cHist + "-" + ;
                                        ALLTRIM(loc_cHists) + " " + loc_cNumeroCheque + " "
                                CASE loc_nOrdemHist = 2
                                    loc_cHists = PROPER(SUBSTR(par_cOperacao, 1, 3)) + " " + ALLTRIM(loc_cHists) + ;
                                        " " + loc_cHist + " " + loc_cNumeroCheque + " "
                            ENDCASE

                            USE IN cursor_4c_CliPit
                            USE IN cursor_4c_CliContem
                        ELSE
                            loc_cHists = SUBSTR(ALLTRIM(cursor_4c_MvCcrNop.Emps) + "-" + ;
                                TratarNulo(cursor_4c_MvCcrNop.Hists, "") + TratarNulo(cursor_4c_MvCcrNop.Hist2s, ""), 1, 70)
                        ENDIF

                        loc_cHists = STRTRAN(STRTRAN(STRTRAN(loc_cHists, CHR(1), ""), CHR(13), ""), CHR(10), "")

                        SELECT cursor_4c_MovAux
                        APPEND BLANK
                        REPLACE Contas WITH loc_cContabs, ;
                                Debs   WITH TRANSFORM(loc_nDebs * 100, "@L 999999999999"), ;
                                Creds  WITH TRANSFORM(loc_nCreds * 100, "@L 999999999999"), ;
                                Docto  WITH ALLTRIM(cursor_4c_MvCcrNop.Titulos), ;
                                Hists  WITH loc_cHists, ;
                                Emps   WITH cursor_4c_MvCcrNop.Emps, ;
                                Cecus  WITH cursor_4c_MvCcrNop.Emps, ;
                                IClis  WITH TratarNulo(cursor_4c_CliOrigem.IClis, ""), ;
                                Razaos WITH SUBSTR(IIF(EMPTY(TratarNulo(cursor_4c_CliOrigem.Razaos, "")), ;
                                            TratarNulo(cursor_4c_CliOrigem.RClis, ""), ;
                                            TratarNulo(cursor_4c_CliOrigem.Razaos, "")), 1, 20), ;
                                Cpfs   WITH TratarNulo(cursor_4c_CliDestino2.Cpfs, ""), ;
                                Cheque WITH loc_cNumeroCheque

                        USE IN cursor_4c_CliOrigem
                        USE IN cursor_4c_CliDestino2
                        USE IN cursor_4c_Par
                    ENDIF
                    SELECT cursor_4c_MvCcrNop
                ENDSCAN
                USE IN cursor_4c_MvCcrNop
            ENDIF

            USE IN cursor_4c_MvCcr1
            SELECT cursor_4c_Pit
        ENDSCAN
        USE IN cursor_4c_Pit

        RETURN loc_nValContra
    ENDFUNC

    *==========================================================================
    * VerificarDiferencas - traducao de:
    *   Select Transacaos, Sum(Val(Debs)/100) As Deb, Sum(Val(Creds)/100) As
    *   Cred From MovAux Group By Transacaos Into Cursor Dif1
    *   Select Transacaos From Dif1 Where Deb <> Cred Into Cursor dif2
    *   Select * From MovAux Where Transacaos In (Select Transacaos From
    *   dif2) Into Cursor diferenca
    * Opera 100% sobre o cursor LOCAL cursor_4c_MovAux (nao usa gnConnHandle -
    * SELECT local do VFP, nao SQLEXEC).
    *==========================================================================
    PROTECTED PROCEDURE VerificarDiferencas()
        IF USED("cursor_4c_Dif1")
            USE IN cursor_4c_Dif1
        ENDIF
        IF USED("cursor_4c_Dif2")
            USE IN cursor_4c_Dif2
        ENDIF
        IF USED("cursor_4c_Diferenca")
            USE IN cursor_4c_Diferenca
        ENDIF

        SELECT Transacaos, SUM(VAL(Debs) / 100) AS Deb, SUM(VAL(Creds) / 100) AS Cred ;
            FROM cursor_4c_MovAux GROUP BY Transacaos INTO CURSOR cursor_4c_Dif1

        SELECT Transacaos FROM cursor_4c_Dif1 WHERE Deb != Cred INTO CURSOR cursor_4c_Dif2

        SELECT * FROM cursor_4c_MovAux WHERE Transacaos IN (SELECT Transacaos FROM cursor_4c_Dif2) ;
            INTO CURSOR cursor_4c_Diferenca

        THIS.this_nTotalDiferencas = RECCOUNT("cursor_4c_Diferenca")
        THIS.this_lPossuiDiferenca = (THIS.this_nTotalDiferencas > 0)

        IF USED("cursor_4c_Dif1")
            USE IN cursor_4c_Dif1
        ENDIF
        IF USED("cursor_4c_Dif2")
            USE IN cursor_4c_Dif2
        ENDIF
    ENDPROC

    *==========================================================================
    * ObterCursorInconsistencias/ObterCursorMovimento/ObterCursorDiferencas -
    * expoem os nomes dos cursores de resultado ao FormSigPrIct, para
    * grid/relatorio de inconsistencias e para a tela de diferencas
    * (equivalente ao "Do Form SigReDif" do legado).
    *==========================================================================
    FUNCTION ObterCursorInconsistencias()
        RETURN "cursor_4c_SemConta"
    ENDFUNC

    FUNCTION ObterCursorMovimento()
        RETURN "cursor_4c_MovAux"
    ENDFUNC

    FUNCTION ObterCursorDiferencas()
        RETURN "cursor_4c_Diferenca"
    ENDFUNC

    *==========================================================================
    * GravarArquivosContabeis - traducao da PARTE DE NEGOCIO do PROCEDURE
    * gravar legado (a parte de UI - habilitar/desabilitar botoes do form -
    * fica no FormSigPrIct). Gera o(s) arquivo(s) texto CTPV*
    * (formato SDF) no diretorio configurado em SigCdPam.DirContabv, um grupo
    * por EmpCont (ver nota de fidelidade do cabecalho: na pratica, com o
    * EmpCont sempre vazio, sai um UNICO arquivo por execucao).
    *==========================================================================
    FUNCTION GravarArquivosContabeis()
        LOCAL loc_lSucesso, loc_oErro, loc_cEmpProc, loc_cNumAux, loc_cNomeArquivo, loc_dDataProc
        LOCAL loc_lGerouArquivo

        loc_lGerouArquivo = .F.

        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_MovAux")
                THIS.this_cMensagemErro = "Cursor de movimento cont" + CHR(225) + "bil n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                MsgErro(THIS.this_cMensagemErro, "")
            ELSE
                IF EMPTY(THIS.this_cDirContabv)
                    THIS.this_cMensagemErro = "Diret" + CHR(243) + "rio Cont" + CHR(225) + "bil (SigCdPam.DirContabv) n" + ;
                        CHR(227) + "o configurado"
                    MsgErro(THIS.this_cMensagemErro, "")
                ELSE
                    SELECT cursor_4c_MovAux
                    SET ORDER TO EmpCont
                    GO TOP

                    IF EOF("cursor_4c_MovAux")
                        loc_lSucesso = .T.
                    ELSE
                        loc_dDataProc = Datas
                        SCAN
                            loc_cEmpProc    = EmpCont
                            loc_cNumAux     = SUBSTR(SYS(3), 5)
                            loc_cNomeArquivo = ALLTRIM(THIS.this_cDirContabv) + "CTPV" + loc_cNumAux + "." + ALLTRIM(cursor_4c_MovAux.EmpCont)

                            IF !FILE(loc_cNomeArquivo)
                                COPY TO (loc_cNomeArquivo) WHILE EmpCont == loc_cEmpProc TYPE SDF
                                SKIP -1
                            ENDIF
                        ENDSCAN
                        loc_lSucesso      = .T.
                        loc_lGerouArquivo = .T.
                    ENDIF

                    SET ORDER TO
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em GravarArquivosContabeis")
        ENDTRY

        *-- Auditoria da exportacao: registrada FORA do TRY de proposito - o
        *-- arquivo contabil ja esta gravado neste ponto, e uma falha ao
        *-- escrever no LogAuditoria nao pode transformar uma geracao bem
        *-- sucedida em erro para o usuario. So registra quando arquivo foi
        *-- realmente gerado (periodo sem movimento nao gera nada e nao audita).
        IF loc_lSucesso AND loc_lGerouArquivo
            THIS.RegistrarAuditoria("EXPORT")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * FinalizarProcesso - libera os cursores de resultado (SemConta/MovAux/
    * Diferenca/Grupos/TodosGrupos/Empresas/LoteProc); chamado pelo form ao
    * encerrar a tela (equivalente ao ThisForm.poDataMgr.Release do Release
    * legado, restrito aos cursores que este BO controla).
    *==========================================================================
    PROCEDURE FinalizarProcesso()
        LOCAL loc_aCursores, loc_nI
        loc_aCursores = "cursor_4c_SemConta,cursor_4c_MovAux,cursor_4c_Diferenca,cursor_4c_Dif1," + ;
            "cursor_4c_Dif2,cursor_4c_Grupos,cursor_4c_TodosGrupos,cursor_4c_Empresas,cursor_4c_LoteProc,cursor_4c_MvCcr"

        FOR loc_nI = 1 TO GETWORDCOUNT(loc_aCursores, ",")
            IF USED(GETWORDNUM(loc_aCursores, loc_nI, ","))
                USE IN (GETWORDNUM(loc_aCursores, loc_nI, ","))
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * LimparLinhaCarregada - zera as propriedades da linha corrente. Chamado
    * por CarregarDoCursor() ANTES de ler, para que colunas ausentes no cursor
    * recebido nao fiquem com o valor da leitura anterior (o BO vive enquanto
    * a tela estiver aberta e o usuario alterna entre as grades de
    * lancamentos, inconsistencias e diferencas).
    *==========================================================================
    PROTECTED PROCEDURE LimparLinhaCarregada()
        THIS.this_cAnoFis     = ""
        THIS.this_cDatas      = ""
        THIS.this_cContas     = ""
        THIS.this_cDebs       = ""
        THIS.this_cCreds      = ""
        THIS.this_cDocto      = ""
        THIS.this_cHists      = ""
        THIS.this_cEmpCont    = ""
        THIS.this_cNumSeq     = ""
        THIS.this_cNums       = ""
        THIS.this_cLams       = ""
        THIS.this_dData       = {}
        THIS.this_cValor      = ""
        THIS.this_cCecus      = ""
        THIS.this_cEmps       = ""
        THIS.this_cTransacaos = ""
        THIS.this_cCpfs       = ""
        THIS.this_cIClis      = ""
        THIS.this_cRazaos     = ""
        THIS.this_cCheque     = ""
        THIS.this_dDataS      = {}
        THIS.this_nValors     = 0
        THIS.this_cOcors      = ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - carrega a linha CORRENTE do cursor recebido nas
    * propriedades da linha (acima). Atende os TRES cursores de resultado que
    * este BO publica, que tem layouts diferentes:
    *
    *   cursor_4c_MovAux    (lancamentos contabeis - MovAux do legado)
    *   cursor_4c_Diferenca (mesmo layout de MovAux, filtrado por transacao
    *                        desbalanceada)
    *   cursor_4c_SemConta  (inconsistencias - SemConta do legado)
    *
    * Por isso cada coluna eh testada com TYPE(<alias>.<coluna>) antes de ser
    * lida: a coluna que nao existe no cursor recebido simplesmente nao eh
    * carregada (e fica zerada pelo LimparLinhaCarregada acima). PEMSTATUS NAO
    * serve aqui - ele exige um OBJETO no 1o argumento e dispara o erro 11 do
    * VFP9 quando recebe nome de cursor.
    *
    * A colisao Datas/DataS eh resolvida pelo VARTYPE da coluna, nao pelo nome:
    * em MovAux "Datas" eh C(8) (data ja formatada para o arquivo contabil) e
    * em SemConta "DataS" eh D (data do movimento); para o VFP os dois nomes
    * sao o MESMO campo, entao decidir pelo nome carregaria o valor no tipo
    * errado e estouraria "Operator/operand type mismatch" no primeiro uso.
    *
    * Parametro: par_cAliasCursor - nome do cursor posicionado na linha desejada
    * Retorno  : .T. quando havia linha para carregar; .F. quando o cursor nao
    *            existe, esta vazio ou esta em EOF/BOF.
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAliasAnterior

        loc_lSucesso = .F.

        THIS.LimparLinhaCarregada()
        THIS.this_cCursorCarregado = ""

        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o informado para CarregarDoCursor"
        ELSE
            IF !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor [" + ALLTRIM(par_cAliasCursor) + "] n" + CHR(227) + ;
                    "o est" + CHR(225) + " dispon" + CHR(237) + "vel"
            ELSE
                *-- Preserva o alias corrente: o form chama este metodo a partir
                *-- de handlers de grade e devolver o foco de area errado faz o
                *-- SCAN/REPLACE seguinte agir no cursor errado.
                loc_cAliasAnterior = ALIAS()

                SELECT (par_cAliasCursor)

                IF RECCOUNT() = 0 OR EOF() OR BOF()
                    THIS.this_cMensagemErro = "Nenhuma linha selecionada em [" + ALLTRIM(par_cAliasCursor) + "]"
                ELSE
                    *-- Colunas do cursor de LANCAMENTOS (MovAux/Diferenca)
                    IF TYPE(par_cAliasCursor + ".AnoFis") = "C"
                        THIS.this_cAnoFis = ALLTRIM(TratarNulo(AnoFis, ""))
                    ENDIF

                    *-- Datas (C, lancamentos) x DataS (D, inconsistencias):
                    *-- mesmo nome para o VFP, tipos diferentes - decidir pelo VARTYPE.
                    DO CASE
                        CASE TYPE(par_cAliasCursor + ".Datas") = "C"
                            THIS.this_cDatas = ALLTRIM(TratarNulo(Datas, ""))
                        CASE TYPE(par_cAliasCursor + ".Datas") = "D"
                            THIS.this_dDataS = TratarNulo(Datas, {})
                        CASE TYPE(par_cAliasCursor + ".Datas") = "T"
                            THIS.this_dDataS = ConverterParaData(TratarNulo(Datas, {}))
                    ENDCASE

                    IF TYPE(par_cAliasCursor + ".Contas") = "C"
                        THIS.this_cContas = ALLTRIM(TratarNulo(Contas, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Debs") = "C"
                        THIS.this_cDebs = TratarNulo(Debs, "")
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Creds") = "C"
                        THIS.this_cCreds = TratarNulo(Creds, "")
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Docto") = "C"
                        THIS.this_cDocto = ALLTRIM(TratarNulo(Docto, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Hists") = "C"
                        THIS.this_cHists = TratarNulo(Hists, "")
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".EmpCont") = "C"
                        THIS.this_cEmpCont = ALLTRIM(TratarNulo(EmpCont, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".NumSeq") = "C"
                        THIS.this_cNumSeq = ALLTRIM(TratarNulo(NumSeq, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Nums") = "C"
                        THIS.this_cNums = ALLTRIM(TratarNulo(Nums, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Lams") = "C"
                        THIS.this_cLams = ALLTRIM(TratarNulo(Lams, ""))
                    ENDIF
                    DO CASE
                        CASE TYPE(par_cAliasCursor + ".Data") = "D"
                            THIS.this_dData = TratarNulo(Data, {})
                        CASE TYPE(par_cAliasCursor + ".Data") = "T"
                            THIS.this_dData = ConverterParaData(TratarNulo(Data, {}))
                    ENDCASE
                    IF TYPE(par_cAliasCursor + ".Valor") = "C"
                        THIS.this_cValor = TratarNulo(Valor, "")
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Cecus") = "C"
                        THIS.this_cCecus = ALLTRIM(TratarNulo(Cecus, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Emps") = "C"
                        THIS.this_cEmps = ALLTRIM(TratarNulo(Emps, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Transacaos") = "C"
                        THIS.this_cTransacaos = ALLTRIM(TratarNulo(Transacaos, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Cpfs") = "C"
                        THIS.this_cCpfs = ALLTRIM(TratarNulo(Cpfs, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".IClis") = "C"
                        THIS.this_cIClis = ALLTRIM(TratarNulo(IClis, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Razaos") = "C"
                        THIS.this_cRazaos = ALLTRIM(TratarNulo(Razaos, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Cheque") = "C"
                        THIS.this_cCheque = ALLTRIM(TratarNulo(Cheque, ""))
                    ENDIF

                    *-- Colunas exclusivas do cursor de INCONSISTENCIAS (SemConta).
                    *-- Valors eh N(12,2) aqui (valor de verdade), diferente do
                    *-- Valor C(12) dos lancamentos.
                    IF TYPE(par_cAliasCursor + ".Valors") = "N"
                        THIS.this_nValors = TratarNulo(Valors, 0)
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Ocors") = "C"
                        THIS.this_cOcors = ALLTRIM(TratarNulo(Ocors, ""))
                    ENDIF

                    THIS.this_cCursorCarregado = ALLTRIM(par_cAliasCursor)
                    THIS.this_cMensagemErro    = ""
                    loc_lSucesso = .T.
                ENDIF

                *-- Devolve o alias que estava corrente antes da leitura
                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - chave de identificacao usada pelo log de auditoria
    * (BusinessBase.RegistrarAuditoria).
    *
    * Este processo nao grava registro em tabela, entao nao existe chave
    * primaria de persistencia; o que identifica uma execucao eh o PERIODO
    * processado, e o que identifica um lancamento dentro dela eh a
    * composicao Empresa + Transacao + Sequencia que o proprio legado usa
    * para amarrar debito e credito (ver VerificarDiferencas).
    *
    * Montagem com separador "/" de proposito: esta chave alimenta
    * LogAuditoria.ChaveRegistro (varchar(100)) e eh lida por gente, nao
    * comparada com coluna char(N) de largura fixa - nao eh chave posicional,
    * entao ALLTRIM nas partes aqui eh correto e nao quebra busca nenhuma.
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave, loc_cPeriodo

        loc_cPeriodo = DTOC(THIS.this_dDataI) + "-" + DTOC(THIS.this_dDataF)

        IF !EMPTY(THIS.this_cTransacaos) OR !EMPTY(THIS.this_cNumSeq)
            loc_cChave = loc_cPeriodo + "/" + ALLTRIM(THIS.this_cEmps) + "/" + ;
                ALLTRIM(THIS.this_cTransacaos) + "/" + ALLTRIM(THIS.this_cNumSeq)
        ELSE
            loc_cChave = loc_cPeriodo
        ENDIF

        *-- LogAuditoria.ChaveRegistro eh varchar(100)
        RETURN LEFT(loc_cChave, 100)
    ENDFUNC

    *==========================================================================
    * RegistrarAuditoria - registra no LogAuditoria a execucao do processo.
    *
    * Sobrescreve a versao de BusinessBase por UM motivo: a base grava
    * THIS.this_cTabela na coluna Tabela, e aqui this_cTabela eh vazio de
    * proposito (o processo nao tem tabela principal - ver nota de arquitetura
    * no cabecalho). Gravar string vazia numa coluna NOT NULL funciona mas
    * deixa o log inutil, entao o identificador do PROCESSO entra no lugar.
    *
    * Colunas NOT NULL de LogAuditoria (regra #22 - lista conferida no
    * schema): Tabela varchar(100), Operacao varchar(10), ChaveRegistro
    * varchar(100), Usuario varchar(50), DataHora datetime. Id eh IDENTITY.
    * DadosAnteriores/DadosNovos/IP/Estacao aceitam NULL e ficam de fora.
    * DataHora resolve no servidor, via GETDATE() - nunca formatando um
    * DATETIME do VFP no cliente (o formatador de data recusa o tipo T e
    * devolveria o literal NULL, que a coluna NOT NULL rejeita).
    *
    * Parametro: par_cOperacao - "EXPORT" na geracao do arquivo contabil
    *            (cabe em varchar(10); LEFT garante o limite).
    *==========================================================================
    PROTECTED FUNCTION RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_lSucesso, loc_cOperacao

        loc_lSucesso = .F.
        loc_cChave   = THIS.ObterChavePrimaria()
        loc_cOperacao = IIF(VARTYPE(par_cOperacao) = "C", ALLTRIM(par_cOperacao), "EXPORT")

        IF EMPTY(loc_cChave) OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            loc_lSucesso = .F.
        ELSE
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) VALUES (" + ;
                EscaparSQL(LEFT("SigPrIct - Integracao Contabil", 100)) + ", " + ;
                EscaparSQL(LEFT(loc_cOperacao, 10)) + ", " + ;
                EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
                EscaparSQL(LEFT(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA"), 50)) + ;
                ", GETDATE())"

            loc_lSucesso = (SQLEXEC(gnConnHandle, loc_cSQL) >= 0)
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
