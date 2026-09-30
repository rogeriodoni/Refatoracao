# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 8/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-26 23:20:47] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-26 23:20:47] [INFO] Config FPW: (nao fornecido)
[2026-09-26 23:20:47] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-26 23:20:47] [INFO] Timeout: 300 segundos
[2026-09-26 23:20:47] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yhd5klfq.prg
[2026-09-26 23:20:47] [INFO] Conteudo do wrapper:
[2026-09-26 23:20:47] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrChr', 'C:\4c\tasks\task590\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrChr', 'C:\4c\tasks\task590\logs\06_testForm.log'
QUIT

[2026-09-26 23:20:47] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yhd5klfq.prg
[2026-09-26 23:20:47] [INFO] VFP output esperado em: C:\4c\tasks\task590\vfp_output.txt
[2026-09-26 23:20:47] [INFO] Executando Visual FoxPro 9...
[2026-09-26 23:20:47] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yhd5klfq.prg
[2026-09-26 23:20:47] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yhd5klfq.prg
[2026-09-26 23:20:47] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrChr
Inicio: 26/09/2026 23:20:47

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 26/09/2026 23:24:04
Duracao: 197 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-26 23:24:05] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-26 23:24:05] [INFO] VFP9 finalizado em 197.7512787 segundos
[2026-09-26 23:24:05] [INFO] Exit Code: 
[2026-09-26 23:24:05] [INFO] 
[2026-09-26 23:24:05] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-26 23:24:05] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yhd5klfq.prg
[2026-09-26 23:24:05] [INFO] 
[2026-09-26 23:24:05] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-26 23:24:05] [INFO] * Auto-generated wrapper for parameters
[2026-09-26 23:24:05] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-26 23:24:05] [INFO] * Parameters: 'FormSigPrChr', 'C:\4c\tasks\task590\logs\06_testForm.log'
[2026-09-26 23:24:05] [INFO] 
[2026-09-26 23:24:05] [INFO] * Anti-dialog protections for unattended execution
[2026-09-26 23:24:05] [INFO] SET SAFETY OFF
[2026-09-26 23:24:05] [INFO] SET RESOURCE OFF
[2026-09-26 23:24:05] [INFO] SET TALK OFF
[2026-09-26 23:24:05] [INFO] SET NOTIFY OFF
[2026-09-26 23:24:05] [INFO] SYS(2335, 0)
[2026-09-26 23:24:05] [INFO] 
[2026-09-26 23:24:05] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrChr', 'C:\4c\tasks\task590\logs\06_testForm.log'
[2026-09-26 23:24:05] [INFO] QUIT
[2026-09-26 23:24:05] [INFO] 
[2026-09-26 23:24:05] [INFO] === Fim do Wrapper.prg ===
[2026-09-26 23:24:05] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrChr.prg):
*==============================================================================
* FormSigPrChr.prg - Consulta e Cancelamento de Cheques
*
* Origem legado: SIGPRCHR.SCX (task590)
* Herda de: FormBase
* Tipo: OPERACIONAL - form PLANO sem PageFrame (layout.json: todos os objetos
*       sao filhos diretos de SIGPRCHR, sem Pagina.Lista/Pagina.Dados). Filtra
*       cheques por Grupo/Conta/Periodo numa grade unica, com containers
*       flutuantes (Visible=.F.) para justificativa de cancelamento, impressao
*       manual de cheque e leitura de codigo de barras.
*
* BO: SigPrChrBO (SigCqChi - PK cidchaves)
*
* Criado em: Fase 3 - Estrutura Base (DEFINE CLASS, Init, cabecalho)
*==============================================================================

DEFINE CLASS FormSigPrChr AS FormBase

    *-- Propriedades visuais (pixel-perfect do SCX original - PILAR 1)
    *-- SIGPRCHR.SCX: Width=800, Height=600 (layout.json) - todos os controles
    *-- do legado (grid, filtros, CommandGroup de 9 botoes) cabem dentro dessa
    *-- largura, entao NAO ha necessidade de escalar para o canonico 1000.
    Width        = 800
    Height       = 600
    AutoCenter   = .T.
    Caption      = "Consulta e Cancelamento de Cheques"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    TitleBar     = 0
    BorderStyle  = 2
    ClipControls = .F.
    ShowTips     = .T.
    DataSession  = 1

    *==========================================================================
    * Init - Sem parametros recebidos do chamador (form aberto direto pelo
    * menu, popMovimentos). DODEFAULT() encadeia para FormBase.Init(), que
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o BO e monta a estrutura visual base.
    * Fase 3 monta apenas o cabecalho (cnt_4c_Sombra); grid, CommandGroup de
    * acoes, filtros e containers flutuantes entram nas Fases 4 a 7.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrChrBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Semeia os filtros a partir do BO (Init do BO ja carrega
                *-- this_dDataInicial/this_dDataFinal com DATE(), como o
                *-- "ThisForm.Dt_Inicial.Value = Date()" do Init legado), com o
                *-- BO como fonte unica do estado dos filtros.
                THIS.BOParaForm()

                THIS.TornarControlesVisiveis(THIS)
                THIS.Visible = .T.

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigPrChrBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "FormSigPrChr.InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrChr.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRCHR nao tem
    * PageFrame no legado (layout flat) - o nome do metodo eh mantido apenas
    * como ponto de entrada arquitetural padrao (mesmo papel em FormFop/FormEnd).
    * Fases: Fase 3 - so o cabecalho.
    *   Fase 4 - ConfigurarGrid() (grd_4c_Dados) + ConfigurarBotoesAcao()
    *             (cmdGok + Marca/Desmarca tudo + Processar) + MontaGrade()
    *   Fase 5 - ConfigurarMolduras() (Shape1/Shape2) + ConfigurarFiltros()
    *             com a PRIMEIRA metade dos campos (Grupo + Periodo)
    *   Fase 6 - ConfigurarFiltros() acrescenta a SEGUNDA metade (Conta +
    *             Favorecido), os handlers GotFocus (equivalente ao When) e
    *             KeyPress (equivalente ao Valid) de TODOS os filtros, e os
    *             pickers AbrirBuscaGrupo()/AbrirBuscaConta() (substituem
    *             fAcessoContab/fAcessoContas do legado - Pattern A)
    *   Fase 7 - ConfigurarContainersFlutuantes() (justificativa/procurar/leitor
    *             de codigo de barras/impressao manual matricial)
    *
    * Todos os 6 campos de filtro (Grupo/Conta/Periodo) ja existem como
    * TextBox e ja tem validacao/lookup completos. MontaGrade()/
    * ExibirCheques() continuam lendo pelos getters ObterFiltro* (guard
    * PEMSTATUS mantido por simetria - os campos sempre existem a partir
    * desta fase, mas o fallback para a property do BO fica inofensivo).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarMolduras()
        THIS.ConfigurarGrid()
        THIS.ConfigurarBotoesAcao()
        THIS.ConfigurarFiltros()
        THIS.ConfigurarContainersFlutuantes()
    ENDPROC

    *==========================================================================
    * ConfigurarMolduras - Shape1 (moldura da grade) e Shape2 (moldura da
    * faixa de filtros Grupo/Periodo/Conta), copiados do layout.json sem
    * BorderColor/FillColor declarados no dump - por isso FillStyle=1
    * (transparente), para nao cobrir os controles desenhados por cima.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarMolduras()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top         = 156
                .Left        = 18
                .Width       = 774
                .Height      = 66
                .BorderColor = RGB(0, 0, 0)
                .BorderStyle = 1
                .FillStyle   = 1
                .Visible     = .T.
            ENDWITH

            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 227
                .Left        = 18
                .Width       = 774
                .Height      = 301
                .BorderColor = RGB(0, 0, 0)
                .BorderStyle = 1
                .FillStyle   = 1
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarMolduras")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza escuro com titulo do form.
    * Original: cntSombra Top=0, Left=0, Width=800, Height=80,
    * BackColor=RGB(100,100,100) (layout.json) - copiado sem escala, pois
    * THIS.Width ja eh 800 (identico ao legado).
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

            loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
            WITH loc_oCnt.lbl_4c_Sombra
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
                .Top           = 25
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oCnt.lbl_4c_Titulo
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
                .Top        = 24
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
    * CriarCursorCheques - Cursor de trabalho da grade de cheques
    * (cursor_4c_Cheques = CsSigCqChi do legado). Estrutura EXATA da que sera
    * populada por SQLEXEC nas fases seguintes (filtros de Grupo/Conta/
    * Periodo, ver mExibeCheques/MontaChq do legado) - criado aqui vazio para
    * o Grid poder ligar Column.ControlSource ja nesta fase, sem estourar
    * "Alias nao encontrado" (regra: Column.ControlSource antes do cursor
    * existir derruba o Init).
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorCheques()
        LOCAL loc_cNull

        IF USED("cursor_4c_Cheques")
            USE IN cursor_4c_Cheques
        ENDIF

        *-- SET NULL ON antes do CREATE CURSOR: SQL Server pode devolver NULL
        *-- em colunas aqui declaradas sem a clausula NULL (favos/contas/etc).
        *-- Sem isso, o APPEND FROM DBF() de MontaGrade estoura "Field XXX
        *-- does not accept null values" no primeiro registro NULL.
        loc_cNull = SET("Null")
        SET NULL ON

        CREATE CURSOR cursor_4c_Cheques ;
            (emps C(3), dopes C(20), numes N(6,0), datas T NULL, bancos C(3), ;
             agencias C(4), ncontas C(10), ncheques C(6), contas C(10), ;
             valors N(11,2), favos C(40), ncopias N(6,0), nemissoes N(2,0), ;
             cidchaves C(20), nemitidos N(1,0), ncancelas N(1,0), ;
             nmarca1s N(1,0), justcanc M)

        IF loc_cNull == "OFF"
            SET NULL OFF
        ENDIF

        *-- Indices criados JUNTO com o cursor (vazio), nao apenas apos a
        *-- primeira carga: ExibirCheques faz "SET ORDER TO NCopias/Contas" e,
        *-- com o cursor existindo SEM TAG nenhuma, isso estoura "Table has no
        *-- index order set." - acontece quando o usuario abre a tela e usa
        *-- Procurar/Chq. Matric. ANTES de Processar (no legado o cursor nem
        *-- existia nesse momento e o guard IF USED() pulava tudo). INDEX ON
        *-- cursor vazio eh valido, e o ZAP da recarga PRESERVA as tags, entao
        *-- a chamada seguinte em MontaGrade vira no-op (guard TAGCOUNT = 0).
        THIS.CriarIndicesCheques()
    ENDPROC

    *==========================================================================
    * CriarIndicesCheques - Os 12 indices que o legado cria sobre CsSigCqChi
    * logo apos montar o cursor (PROCEDURE montachq), transcritos 1:1 e com os
    * MESMOS nomes de TAG - as tags sao usadas por nome em SET ORDER TO /
    * SEEK(..., "<tag>") no reposicionamento e na tela de Procurar, entao
    * renomear qualquer uma delas quebra a busca (nunca usar uma tag unica
    * "ordem").
    *
    * Medido no VFP9: ZAP PRESERVA as TAGs do indice (TAGCOUNT antes e depois
    * = 2), por isso os indices sao criados uma unica vez - nas recargas
    * seguintes o APPEND apenas atualiza as tags existentes.
    *==========================================================================
    PROTECTED PROCEDURE CriarIndicesCheques()
        LOCAL loc_cCursor

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)

        IF TAGCOUNT() = 0
            INDEX ON ncopias                TAG NCopias
            INDEX ON nemitidos              TAG NEmitidos
            INDEX ON ncancelas              TAG NCancelas
            INDEX ON nmarca1s               TAG NMarca1s
            INDEX ON ncheques               TAG NCheques
            INDEX ON datas                  TAG Datas
            INDEX ON ncontas + ncheques     TAG Conta
            INDEX ON contas + STR(ncopias)  TAG Contas
            INDEX ON DTOS(datas) + bancos + agencias + ncontas + ncheques        TAG Emissao
            INDEX ON STR(valors, 12, 2) + bancos + agencias + ncontas + ncheques TAG Valor
            INDEX ON bancos + agencias + ncontas + ncheques                      TAG Cheque
            INDEX ON agencias + ncontas + ncheques                               TAG Agencia
        ENDIF
    ENDPROC

    *==========================================================================
    * MontaGrade - Carga da grade de cheques. Transcricao do "PROCEDURE
    * montachq" legado: guarda a chave do cheque corrente, consulta o periodo
    * no banco (SQL no BO), repovoa o cursor, recria os indices, posiciona e
    * entrega para ExibirCheques().
    *
    * Diferenca DELIBERADA em relacao ao legado: o legado faz
    * "GrdCCheques.RecordSource = '' + Use In CsSigCqChi" e recria o cursor com
    * SELECT ... INTO CURSOR ... ReadWrite, religando em seguida TODOS os
    * ControlSource. Aqui o cursor eh PRESERVADO e recarregado com ZAP +
    * APPEND FROM DBF(): reatribuir RecordSource resetaria Column.Width,
    * Header1.Caption, Sparse e CurrentControl (o CheckBox da coluna Imprime
    * deixaria de aparecer). O cursor criado por CREATE CURSOR ja eh
    * READWRITE, que eh o que a coluna editavel do CheckBox exige.
    *
    * ZAP exige SAFETY OFF: config.prg NAO desliga SAFETY (so SET EXACT ON) e
    * com SAFETY ON o ZAP abre dialogo modal de confirmacao que CONGELA a tela.
    *==========================================================================
    PROCEDURE MontaGrade(par_lPosiciona)
        LOCAL loc_lPosiciona, loc_lSucesso, loc_cCursor, loc_cTmp, loc_cBusca
        LOCAL loc_cSafety, loc_oErro
        loc_lSucesso   = .F.
        loc_lPosiciona = IIF(VARTYPE(par_lPosiciona) = "L", par_lPosiciona, .F.)
        loc_cBusca     = ""

        TRY
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
            loc_cTmp    = "cursor_4c_ChequesTmp"

            THIS.LockScreen = .T.

            *-- lcBusca = Bancos + Agencias + ncontas + Ncheques: chave
            *-- POSICIONAL de largura fixa (char 3+4+10+6 = 23 = a chave da tag
            *-- Cheque). NUNCA aplicar ALLTRIM nas partes - o padding FAZ PARTE
            *-- da chave e encurta-la faz o SEEK devolver "nao achou" em
            *-- silencio (CLAUDE.md regra #42). Medido: SEEK com a chave crua
            *-- de 23 chars casa na tag Cheque.
            IF loc_lPosiciona AND USED(loc_cCursor) AND !EOF(loc_cCursor)
                SELECT (loc_cCursor)
                loc_cBusca = bancos + agencias + ncontas + ncheques
            ENDIF

            WAIT WINDOW "Aguarde! Selecionando Cheques..." NOWAIT

            IF !USED(loc_cCursor)
                THIS.CriarCursorCheques()
            ENDIF

            IF THIS.this_oBusinessObject.CarregarCheques(loc_cTmp)
                loc_cSafety = SET("Safety")
                SET SAFETY OFF

                SELECT (loc_cCursor)
                ZAP
                APPEND FROM DBF(loc_cTmp)

                IF loc_cSafety == "ON"
                    SET SAFETY ON
                ENDIF

                IF USED(loc_cTmp)
                    USE IN (loc_cTmp)
                ENDIF

                THIS.CriarIndicesCheques()

                *-- Legado: Set Order To NCopias + (llPosiciona -> Seek(lcBusca)
                *-- senao Go Top). O SEEK roda na ordem CORRENTE (NCopias, que eh
                *-- numerica) contra uma chave CHARACTER: medido no VFP9, isso
                *-- NAO dispara erro - apenas nao encontra e cai no Go Top.
                *-- Transcrito como esta para nao alterar o comportamento visivel.
                SELECT (loc_cCursor)
                SET ORDER TO NCopias

                IF loc_lPosiciona
                    IF !SEEK(loc_cBusca)
                        GO TOP
                    ENDIF
                ELSE
                    GO TOP
                ENDIF

                *-- Legado: .cntjustificativa.get_justificativa.ControlSource =
                *-- 'CsSigCqChi.JustCanc' (o container de justificativa entra em
                *-- fase posterior - religar so quando ele existir).
                IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
                    IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_Get_justificativa", 5)
                        THIS.cnt_4c_justificativa.obj_4c_Get_justificativa.ControlSource = ;
                            loc_cCursor + ".justcanc"
                    ENDIF
                ENDIF

                THIS.grd_4c_Dados.Refresh()

                loc_lSucesso = .T.
            ELSE
                *-- Legado: MessageBox('Favor Reinicializar o Processo!!!', 16,
                *-- 'Falha na Conexao (TmpChi - 1|2)'). A mensagem eh exibida
                *-- APENAS aqui: o chamador (Processar) nao repete, para nao
                *-- empilhar dois dialogos sobre a mesma falha.
                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Falha na Conex" + CHR(227) + "o (Cheques)")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em MontaGrade")
        ENDTRY

        WAIT CLEAR
        THIS.LockScreen = .F.

        *-- Legado: If llPosiciona -> mExibeCheques(.F.) Else mExibeCheques(.T.)
        IF loc_lSucesso
            THIS.ExibirCheques(!loc_lPosiciona)
            THIS.this_oBusinessObject.this_lPrimeiraExibicao = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExibirCheques - Transcricao do "PROCEDURE mexibecheques" legado: desmarca
    * a coluna Imprime, escolhe a ordem da grade conforme a Conta estar
    * filtrada, opcionalmente salta para o fim da lista, e sincroniza
    * Favorecido / botao Procurar / foco na coluna Conta.
    *
    * Medido no VFP9: "Seek Chr(255) ... Order NCopias" (chave CHARACTER contra
    * indice NUMERICO) NAO dispara erro - deixa o cursor em EOF, que eh
    * exatamente o efeito pretendido pelo legado (ir para o fim da lista).
    *==========================================================================
    PROCEDURE ExibirCheques(par_lSeek)
        LOCAL loc_lSeek, loc_cCursor, loc_cConta, loc_cFavorecido, loc_oErro

        *-- Legado: llSeek = Iif(Type('llSeek') = 'L', llSeek, .F.)
        loc_lSeek = IIF(VARTYPE(par_lSeek) = "L", par_lSeek, .F.)

        TRY
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

            IF USED(loc_cCursor)
                THIS.LockScreen = .T.

                *-- Legado: UpDate CsSigCqChi Set nMarca1s = 0 Where nMarca1s = 1
                UPDATE (loc_cCursor) SET nmarca1s = 0 WHERE nmarca1s = 1

                loc_cConta = ALLTRIM(THIS.ObterFiltroConta())

                SELECT (loc_cCursor)

                IF EMPTY(loc_cConta)
                    SET ORDER TO NCopias
                    IF loc_lSeek
                        SEEK CHR(255) IN (loc_cCursor) ORDER NCopias ASCENDING
                    ENDIF
                ELSE
                    *-- Legado: Set Order To contas + Set Key To <conta>. O
                    *-- SET KEY eh OMITIDO de proposito: a consulta do BO ja
                    *-- restringe o resultado a essa unica conta (WHERE
                    *-- a.contas = <conta>), entao ele nao filtra nada a mais -
                    *-- e a tag Contas eh COMPOSTA (contas + Str(ncopias)),
                    *-- de modo que um SET KEY com a chave parcial sob o
                    *-- SET EXACT ON global (config.prg) poderia nao casar e
                    *-- deixar a grade vazia sem erro nenhum.
                    SET ORDER TO Contas
                    IF loc_lSeek
                        SEEK loc_cConta + CHR(255) IN (loc_cCursor) ORDER Contas ASCENDING
                    ENDIF
                ENDIF

                *-- Legado: ThisForm.CmdGOk.CmdProcurar.Enabled = .t. + Refresh
                IF THIS.obj_4c_CmdGok.ButtonCount >= 4
                    THIS.obj_4c_CmdGok.Buttons(4).Enabled = .T.
                ENDIF
                THIS.obj_4c_CmdGok.Refresh()

                THIS.grd_4c_Dados.Refresh()

                *-- Legado: ThisForm.TxtFavorecido.Value = CsSigCqChi.favos +
                *-- Enabled dos botoes de documento + painel de justificativa
                *-- (mesmo corpo do Scrolled/AfterRowColChange da grade -
                *-- AtualizarPainelChequeCorrente). Em EOF (Seek Chr(255) acima
                *-- deixa o cursor em EOF) os campos leem o default vazio/zero.
                loc_cFavorecido = ""
                IF !EOF(loc_cCursor)
                    loc_cFavorecido = EVALUATE(loc_cCursor + ".favos")
                ENDIF
                THIS.this_oBusinessObject.this_cFavorecido = loc_cFavorecido

                THIS.AtualizarPainelChequeCorrente()

                *-- Legado: ThisForm.GrdCCheques.clnContas.SetFocus
                *-- (clnContas = Column2). Medido: Column TEM o metodo SetFocus.
                IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
                    THIS.grd_4c_Dados.Column2.SetFocus()
                ENDIF

                THIS.LockScreen = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ExibirCheques")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ObterFiltroConta / ObterFiltroGrupo - Valor corrente dos filtros de
    * Conta e Grupo. Os TextBox correspondentes (getCdContas / getCdGrupos do
    * legado) sao criados na fase de filtros; enquanto nao existirem, o valor
    * vem das properties do BO (this_cCodConta / this_cCodGrupo), que sao a
    * fonte unica desse estado. Quando os campos existirem, o TextBox passa a
    * mandar - igual ao legado, que le sempre ThisForm.getCdContas.Value.
    *==========================================================================
    PROTECTED FUNCTION ObterFiltroConta()
        LOCAL loc_cConta

        loc_cConta = THIS.this_oBusinessObject.this_cCodConta

        IF PEMSTATUS(THIS, "txt_4c_CdContas", 5)
            loc_cConta = THIS.txt_4c_CdContas.Value
        ENDIF

        RETURN IIF(VARTYPE(loc_cConta) = "C", loc_cConta, "")
    ENDFUNC

    PROTECTED FUNCTION ObterFiltroGrupo()
        LOCAL loc_cGrupo

        loc_cGrupo = THIS.this_oBusinessObject.this_cCodGrupo

        IF PEMSTATUS(THIS, "txt_4c_CdGrupos", 5)
            loc_cGrupo = THIS.txt_4c_CdGrupos.Value
        ENDIF

        RETURN IIF(VARTYPE(loc_cGrupo) = "C", loc_cGrupo, "")
    ENDFUNC

    *==========================================================================
    * ConfigurarGrid - Grade de cheques (grd_4c_Dados = grdCcheques do
    * legado). Layout FLAT (sem PageFrame) - Top/Left identicos ao SCX
    * original (layout.json), SEM compensacao de +29 (essa compensacao so
    * vale para forms com PageFrame.Top=-29, o que nao existe neste form).
    *
    * ColumnOrder replica o SCX: clnImprime (Column10) desenha PRIMEIRO
    * (ColumnOrder=1) e clnDatas (Column1) desenha POR ULTIMO (ColumnOrder=10)
    * - os demais seguem a ordem de criacao (2..9). clnSituacaos (Column8) eh
    * CALCULADA (nao existe coluna no cursor) - ControlSource eh a mesma
    * expressao IIF aninhada do legado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid, loc_oErro

        TRY
            THIS.CriarCursorCheques()

            THIS.AddObject("grd_4c_Dados", "Grid")
            loc_oGrid = THIS.grd_4c_Dados

            WITH loc_oGrid
                .Top               = 233
                .Left              = 24
                .Width             = 710
                .Height            = 291
                .FontName          = "Tahoma"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .ReadOnly          = .F.
                .ColumnCount       = 10
                .RecordSource      = "cursor_4c_Cheques"
                .Visible           = .T.
            ENDWITH

            *-- Column1: clnDatas (desenha por ultimo - ColumnOrder=10)
            WITH loc_oGrid.Column1
                .FontName          = "Tahoma"
                .Width             = 79
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ColumnOrder       = 10
                .ControlSource     = "cursor_4c_Cheques.datas"
                .Header1.Caption   = "Data"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column2: clnContas
            WITH loc_oGrid.Column2
                .FontName          = "Tahoma"
                .Width             = 79
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "cursor_4c_Cheques.contas"
                .Header1.Caption   = "Conta"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column3: clnNcopias
            WITH loc_oGrid.Column3
                .FontName          = "Tahoma"
                .Width             = 51
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .InputMask         = "999999"
                .ControlSource     = "cursor_4c_Cheques.ncopias"
                .Header1.Caption   = "C" + CHR(243) + "pia"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Legado: clnNcopias.Header1.Click - reordena para NCopias ao
            *-- clicar no cabecalho, so quando nao ha filtro de Conta e a
            *-- ordem corrente ainda nao eh NCopias.
            BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "Column3Header1Click")

            *-- Column4: clnBancos
            WITH loc_oGrid.Column4
                .FontName          = "Tahoma"
                .Width             = 30
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "cursor_4c_Cheques.bancos"
                .Header1.Caption   = "Bco"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column5: clnAgencias
            WITH loc_oGrid.Column5
                .FontName          = "Tahoma"
                .Width             = 37
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "cursor_4c_Cheques.agencias"
                .Header1.Caption   = "Ag."
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column6: clnNcontas
            WITH loc_oGrid.Column6
                .FontName          = "Tahoma"
                .Width             = 79
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "cursor_4c_Cheques.ncontas"
                .Header1.Caption   = "C.Corrente"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column7: clnNcheques
            WITH loc_oGrid.Column7
                .FontName          = "Tahoma"
                .Width             = 51
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "cursor_4c_Cheques.ncheques"
                .Header1.Caption   = "Cheque"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column8: clnSituacaos (CALCULADA - identica ao legado)
            WITH loc_oGrid.Column8
                .FontName          = "Tahoma"
                .Width             = 79
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "IIF(cursor_4c_Cheques.ncancelas = 1, 'Cancelado', " + ;
                                      "IIF(cursor_4c_Cheques.nemissoes > 1, 'Reemitido', " + ;
                                      "IIF(cursor_4c_Cheques.nemitidos = 1, 'Emitido', 'N" + CHR(227) + "o Emitido')))"
                .Header1.Caption   = "Situa" + CHR(231) + CHR(227) + "o"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column9: clnValors
            WITH loc_oGrid.Column9
                .FontName          = "Tahoma"
                .Width             = 110
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .InputMask         = "999,999,999.99"
                .ControlSource     = "cursor_4c_Cheques.valors"
                .Header1.Caption   = "Valor"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column10: clnImprime (checkbox - desenha PRIMEIRO, ColumnOrder=1)
            WITH loc_oGrid.Column10
                .FontName    = "Tahoma"
                .Width       = 55
                .Movable     = .F.
                .Resizable   = .F.
                .ColumnOrder = 1
            ENDWITH

            loc_oGrid.Column10.AddObject("chk_4c_Check1", "CheckBox")
            WITH loc_oGrid.Column10.chk_4c_Check1
                .Caption   = ""
                .Alignment = 2
                .BackColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH

            WITH loc_oGrid.Column10
                .CurrentControl    = "chk_4c_Check1"
                .Sparse            = .F.
                .ReadOnly          = .F.
                .ControlSource     = "cursor_4c_Cheques.nmarca1s"
                .Header1.Caption   = "Imprime"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            loc_oGrid.SetAll("DynamicForeColor", ;
                "IIF(cursor_4c_Cheques.ncancelas = 1, RGB(255,0,0), " + ;
                "IIF(cursor_4c_Cheques.nemitidos = 0, RGB(0,0,255), RGB(0,0,0)))", "Column")

            BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "KeyPress",  THIS, "ChkImprimeKeyPress")
            BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "MouseUp",   THIS, "ChkImprimeMouseUp")
            BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "MouseDown", THIS, "ChkImprimeMouseDown")
            BINDEVENT(loc_oGrid.Column10.chk_4c_Check1, "Click",     THIS, "ChkImprimeClick")

            *-- Legado: Scrolled/DoScroll/BeforeRowColChange/AfterRowColChange
            *-- da grdCcheques tem TODOS o mesmo corpo (favorecido + Enabled
            *-- dos botoes de documento + painel de justificativa em modo
            *-- leitura quando o cheque corrente esta cancelado) - transcrito
            *-- uma unica vez em AtualizarPainelChequeCorrente() e ligado aqui
            *-- aos dois eventos NATIVOS do Grid (Scrolled/AfterRowColChange).
            BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
            BINDEVENT(loc_oGrid, "Scrolled",          THIS, "GrdDadosScrolled")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ChkImprimeKeyPress/MouseUp/MouseDown/Click - Toggle do checkbox
    * "Imprime" (Column10.chk_4c_Check1 = clnImprime.Check1 do legado).
    * MouseDown/Click apenas suprimem o toggle nativo do CheckBox (NODEFAULT);
    * MouseUp e KeyPress(Enter/Espaco) fazem a alternancia de verdade via
    * UPDATE no cursor, replicando 1:1 o KeyPress original do legado.
    * PUBLIC (sem PROTECTED) - BINDEVENT so dispara metodos PUBLIC.
    *==========================================================================
    PROCEDURE ChkImprimeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCursor, loc_nRecno, loc_cChave

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF INLIST(par_nKeyCode, 13, 32) AND USED(loc_cCursor)
            loc_nRecno = RECNO(loc_cCursor)
            SELECT (loc_cCursor)
            loc_cChave = bancos + agencias + ncontas + ncheques

            UPDATE (loc_cCursor) SET nmarca1s = IIF(nmarca1s = 1, 0, 1) ;
                WHERE bancos + agencias + ncontas + ncheques = loc_cChave ;
                  AND nemitidos = 0 AND ncancelas = 0

            THIS.grd_4c_Dados.Refresh()

            IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
                SELECT (loc_cCursor)
                GOTO loc_nRecno
            ENDIF

            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE ChkImprimeMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ChkImprimeKeyPress(32, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkImprimeMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkImprimeClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * Column3Header1Click - Header1.Click de clnNcopias (Column3). PUBLIC -
    * BINDEVENT so dispara metodos PUBLIC.
    *==========================================================================
    PROCEDURE Column3Header1Click()
        LOCAL loc_cCursor

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF EMPTY(THIS.ObterFiltroConta()) AND USED(loc_cCursor) AND ;
                UPPER(ORDER(loc_cCursor)) != "NCOPIAS"
            THIS.ExibirCheques(.F.)
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange / GrdDadosScrolled - Navegacao na grade de
    * cheques (grd_4c_Dados). PUBLIC - BINDEVENT so dispara metodos PUBLIC.
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        THIS.AtualizarPainelChequeCorrente()
    ENDPROC

    PROCEDURE GrdDadosScrolled(par_nDirection)
        THIS.AtualizarPainelChequeCorrente()
    ENDPROC

    *==========================================================================
    * AtualizarPainelChequeCorrente - Transcricao unica do corpo repetido em
    * Scrolled/DoScroll/BeforeRowColChange/AfterRowColChange do grdCcheques
    * legado: espelha o Favorecido do cheque corrente, habilita/desabilita os
    * botoes de documento conforme o cheque estar cancelado, e mostra o
    * painel de justificativa em modo SOMENTE LEITURA quando o cheque
    * corrente ja esta cancelado (cmdGconf oculto - nao ha o que confirmar).
    *==========================================================================
    PROTECTED PROCEDURE AtualizarPainelChequeCorrente()
        LOCAL loc_cCursor, loc_lCancelas

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        loc_lCancelas = (EVALUATE(loc_cCursor + ".ncancelas") <> 0)

        IF PEMSTATUS(THIS, "txt_4c_TxtFavorecido", 5)
            THIS.txt_4c_TxtFavorecido.Value = EVALUATE(loc_cCursor + ".favos")
            THIS.txt_4c_TxtFavorecido.Refresh()
        ENDIF

        *-- Legado: Buttons 1/6/3/5/9 = cmdDocumento/cmdExcluiDoc/cmdImprimir/
        *-- cmdRecibo/btnExcluirChq (mesma numeracao de CmdGokClick).
        IF THIS.obj_4c_CmdGok.ButtonCount >= 9
            THIS.obj_4c_CmdGok.Buttons(1).Enabled = !loc_lCancelas
            THIS.obj_4c_CmdGok.Buttons(6).Enabled = (!loc_lCancelas AND THIS.this_oBusinessObject.this_lExcluirDocumento)
            THIS.obj_4c_CmdGok.Buttons(3).Enabled = !loc_lCancelas
            THIS.obj_4c_CmdGok.Buttons(5).Enabled = !loc_lCancelas
            THIS.obj_4c_CmdGok.Buttons(9).Enabled = (loc_lCancelas AND THIS.this_oBusinessObject.this_lExcluirCheque)
            THIS.obj_4c_CmdGok.Refresh()
        ENDIF

        IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
            WITH THIS.cnt_4c_justificativa
                .Visible = loc_lCancelas

                IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_Get_justificativa", 5)
                    .obj_4c_Get_justificativa.ReadOnly = loc_lCancelas
                    IF loc_lCancelas
                        .obj_4c_Get_justificativa.Width = 346
                        .obj_4c_Get_justificativa.Refresh()
                    ENDIF
                ENDIF

                IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_CmdGconf", 5)
                    .obj_4c_CmdGconf.Enabled = .F.
                    .obj_4c_CmdGconf.Visible = .F.
                ENDIF
            ENDWITH
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - CommandGroup de acoes (obj_4c_CmdGok = cmdGok do
    * legado, 9 botoes) + botoes standalone de marcacao em massa da grade
    * (cmd_4c_CmdTudo1/cmd_4c_CmdApaga1 = cmdTudo1/cmdApaga1 do legado).
    * Layout FLAT - Top/Left identicos ao SCX original, sem compensacao de
    * PageFrame.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("obj_4c_CmdGok", "CommandGroup")
            WITH THIS.obj_4c_CmdGok
                .Top           = -3
                .Left          = 11
                .Width         = 789
                .Height        = 160
                .ButtonCount   = 9
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 189, 188)
                .Themes        = .F.
                .Value         = 1
                .Visible       = .T.
            ENDWITH

            *-- Botao 1: cmdDocumento
            WITH THIS.obj_4c_CmdGok.Buttons(1)
                .Top             = 121
                .Left            = 473
                .Width           = 120
                .Height          = 37
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
                .Caption         = "\<Documento"
                .PicturePosition = 1
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            *-- Botao 2: cmdSair (Encerrar)
            WITH THIS.obj_4c_CmdGok.Buttons(2)
                .Top         = 6
                .Left        = 713
                .Width       = 75
                .Height      = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel      = .T.
                .Caption     = "Encerrar"
                .ToolTipText = "[Esc] Encerrar"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH

            *-- Botao 3: cmdImprimir
            WITH THIS.obj_4c_CmdGok.Buttons(3)
                .Top             = 84
                .Left            = 353
                .Width           = 120
                .Height          = 37
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                .Caption         = "\<Imprimir"
                .PicturePosition = 1
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            *-- Botao 4: cmdProcurar
            WITH THIS.obj_4c_CmdGok.Buttons(4)
                .Top             = 84
                .Left            = 593
                .Width           = 120
                .Height          = 37
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .Caption         = "\<Procurar"
                .PicturePosition = 1
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            *-- Botao 5: cmdRecibo
            WITH THIS.obj_4c_CmdGok.Buttons(5)
                .Top             = 121
                .Left            = 593
                .Width           = 120
                .Height          = 37
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
                .Caption         = "\<Recibo"
                .PicturePosition = 1
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            *-- Botao 6: cmdExcluiDoc
            WITH THIS.obj_4c_CmdGok.Buttons(6)
                .Top             = 84
                .Left            = 473
                .Width           = 120
                .Height          = 37
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .Caption         = "E\<xclui Docto."
                .ToolTipText     = "Exclui Documento"
                .PicturePosition = 1
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            *-- Botao 7: cmdImpchq
            WITH THIS.obj_4c_CmdGok.Buttons(7)
                .Top             = 121
                .Left            = 353
                .Width           = 120
                .Height          = 37
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
                .Caption         = "Che\<que"
                .ToolTipText     = "Impressora de cheque"
                .PicturePosition = 1
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            *-- Botao 8: cmdchmat
            WITH THIS.obj_4c_CmdGok.Buttons(8)
                .Top             = 84
                .Left            = 233
                .Width           = 120
                .Height          = 37
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "cheque.png"
                .Caption         = "Chq. \<Matric."
                .ToolTipText     = "Impressora matricial"
                .PicturePosition = 1
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            *-- Botao 9: btnExcluirChq
            WITH THIS.obj_4c_CmdGok.Buttons(9)
                .Top             = 121
                .Left            = 233
                .Width           = 120
                .Height          = 37
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .Caption         = "Excluir Chq."
                .ToolTipText     = "Exclui Cheque"
                .PicturePosition = 1
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            BINDEVENT(THIS.obj_4c_CmdGok, "Click", THIS, "CmdGokClick")

            *-- Botao standalone: cmdTudo1 (Marca tudo)
            THIS.AddObject("cmd_4c_CmdTudo1", "CommandButton")
            WITH THIS.cmd_4c_CmdTudo1
                .Top         = 334
                .Left        = 742
                .Width       = 40
                .Height      = 40
                .FontName    = "Verdana"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                .Caption     = ""
                .ToolTipText = "Marca tudo"
                .ForeColor   = RGB(36, 84, 155)
                .BackColor   = RGB(255, 255, 255)
                .Themes           = .T.
                .TabStop     = .F.
                .Visible     = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_CmdTudo1, "Click", THIS, "BtnMarcarTudoClick")

            *-- Botao standalone: cmdApaga1 (Desmarca tudo)
            THIS.AddObject("cmd_4c_CmdApaga1", "CommandButton")
            WITH THIS.cmd_4c_CmdApaga1
                .Top         = 375
                .Left        = 742
                .Width       = 40
                .Height      = 40
                .FontName    = "Verdana"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Caption     = ""
                .ToolTipText = "Desmarca tudo"
                .ForeColor   = RGB(36, 84, 155)
                .BackColor   = RGB(255, 255, 255)
                .Themes           = .T.
                .TabStop     = .F.
                .Visible     = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_CmdApaga1, "Click", THIS, "BtnDesmarcarTudoClick")

            *-- Botao standalone: Command2 "Processar" - dispara a carga da
            *-- grade (MontaChq do legado). Propriedades EXATAS do SCX
            *-- (Top=191, Left=598, Height=24, Width=88, Comic Sans MS 8
            *-- bold+italic, ForeColor 90,90,90, BackColor 255,255,255,
            *-- Themes=.F., TabIndex=7). O legado NAO declara Picture para
            *-- este botao - nenhum icone eh inventado aqui.
            THIS.AddObject("cmd_4c_Processar", "CommandButton")
            WITH THIS.cmd_4c_Processar
                .Top        = 191
                .Left       = 598
                .Width      = 88
                .Height     = 24
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .Caption    = "Processar"
                .TabIndex   = 7
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Visible    = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarFiltros - Primeira metade dos campos de filtro (Fase 5/8):
    * grupo Grupo (Label3/GetCdGrupos/GetDsGrupos) e grupo Periodo
    * (Label2/Dt_inicial/Say2/Dt_final). Posicoes EXATAS do SCX original
    * (layout.json) - form OPERACIONAL sem PageFrame, sem compensacao de +29.
    *
    * Handlers de Valid/lookup (fAcessoContab do Grupo, swap de datas do
    * Periodo, e os campos de Conta/Favorecido restantes) sao implementados
    * na fase seguinte, junto com o grupo Conta - mesmo padrao ja usado em
    * FormSIGMVCMV.ConfigurarCamposPeriodoMoeda.
    *
    * TabIndex 1-4 reservados para este grupo; 5-6 ficam para Conta (proxima
    * fase); 7 ja esta ocupado por cmd_4c_Processar (Fase 4).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros()
        LOCAL loc_oErro

        TRY
            *-- Label3 "Grupo :"
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .Top       = 167
                .Left      = 34
                .Width     = 38
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Grupo :"
                .Visible   = .T.
            ENDWITH

            *-- GetCdGrupos (codigo do grupo de contas - SigCdGcr.codigos char(10))
            THIS.AddObject("txt_4c_CdGrupos", "TextBox")
            WITH THIS.txt_4c_CdGrupos
                .Top           = 163
                .Left          = 75
                .Width         = 100
                .Height        = 25
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 10
                .SpecialEffect = 1
                .BorderColor   = RGB(36, 84, 155)
                .Value         = ""
                .TabIndex      = 1
                .Visible       = .T.
            ENDWITH

            *-- GetDsGrupos (descricao do grupo - SigCdGcr.descrs char(40))
            THIS.AddObject("txt_4c_DsGrupos", "TextBox")
            WITH THIS.txt_4c_DsGrupos
                .Top           = 163
                .Left          = 177
                .Width         = 360
                .Height        = 25
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 40
                .SpecialEffect = 1
                .BorderColor   = RGB(36, 84, 155)
                .Value         = ""
                .TabIndex      = 2
                .Visible       = .T.
            ENDWITH

            *-- Label2 "Periodo :"
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .Top       = 167
                .Left      = 550
                .Width     = 45
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Per" + CHR(237) + "odo :"
                .Visible   = .T.
            ENDWITH

            *-- Dt_inicial (data inicial do periodo - fweditdata no legado)
            THIS.AddObject("txt_4c_Dt_inicial", "TextBox")
            WITH THIS.txt_4c_Dt_inicial
                .Top           = 163
                .Left          = 598
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .BorderColor   = RGB(36, 84, 155)
                .Value         = DATE()
                .TabIndex      = 3
                .Visible       = .T.
            ENDWITH

            *-- Say2 "a"
            THIS.AddObject("lbl_4c_Say2", "Label")
            WITH THIS.lbl_4c_Say2
                .Top       = 167
                .Left      = 686
                .Width     = 12
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "a"
                .Visible   = .T.
            ENDWITH

            *-- Dt_final (data final do periodo - fweditdata no legado)
            THIS.AddObject("txt_4c_Dt_final", "TextBox")
            WITH THIS.txt_4c_Dt_final
                .Top           = 163
                .Left          = 701
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .BorderColor   = RGB(36, 84, 155)
                .Value         = DATE()
                .TabIndex      = 4
                .Visible       = .T.
            ENDWITH

            *-- Label1 "Conta :"
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .Top       = 194
                .Left      = 34
                .Width     = 38
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Conta :"
                .Visible   = .T.
            ENDWITH

            *-- getCdContas (codigo da conta - SigCdCli.iclis char(10))
            THIS.AddObject("txt_4c_CdContas", "TextBox")
            WITH THIS.txt_4c_CdContas
                .Top           = 190
                .Left          = 75
                .Width         = 100
                .Height        = 25
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 10
                .SpecialEffect = 1
                .BorderColor   = RGB(36, 84, 155)
                .Value         = ""
                .TabIndex      = 5
                .Visible       = .T.
            ENDWITH

            *-- getDsContas (razao social da conta - SigCdCli.rclis char(50))
            THIS.AddObject("txt_4c_DsContas", "TextBox")
            WITH THIS.txt_4c_DsContas
                .Top           = 190
                .Left          = 177
                .Width         = 360
                .Height        = 25
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 50
                .SpecialEffect = 1
                .BorderColor   = RGB(36, 84, 155)
                .Value         = ""
                .TabIndex      = 6
                .Visible       = .T.
            ENDWITH

            *-- Label5 "Favorecido :"
            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .Top       = 534
                .Left      = 24
                .Width     = 62
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Favorecido :"
                .Visible   = .T.
            ENDWITH

            *-- txtFavorecido (somente leitura - legado tem When retornando
            *-- .F., ou seja o campo NUNCA recebe foco/edicao do usuario; o
            *-- valor eh espelhado do cheque corrente por ExibirCheques())
            THIS.AddObject("txt_4c_TxtFavorecido", "TextBox")
            WITH THIS.txt_4c_TxtFavorecido
                .Top           = 530
                .Left          = 99
                .Width         = 286
                .Height        = 25
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .BorderColor   = RGB(36, 84, 155)
                .Value         = ""
                .ReadOnly      = .T.
                .TabStop       = .F.
                .Visible       = .T.
            ENDWITH

            *-- BINDEVENT de snapshot (equivalente ao When legado: guarda o
            *-- valor corrente em this_cAnt*/this_dAnt* ANTES da edicao) +
            *-- BINDEVENT de KeyPress (equivalente ao Valid - BINDEVENT em
            *-- "Valid" nao funciona de forma confiavel em TextBox, ver
            *-- CLAUDE.md/memoria "feedback_keypress_lparameters_guard").
            BINDEVENT(THIS.txt_4c_CdGrupos,   "GotFocus", THIS, "TxtCdGruposGotFocus")
            BINDEVENT(THIS.txt_4c_DsGrupos,   "GotFocus", THIS, "TxtDsGruposGotFocus")
            BINDEVENT(THIS.txt_4c_CdContas,   "GotFocus", THIS, "TxtCdContasGotFocus")
            BINDEVENT(THIS.txt_4c_DsContas,   "GotFocus", THIS, "TxtDsContasGotFocus")
            BINDEVENT(THIS.txt_4c_Dt_inicial, "GotFocus", THIS, "TxtDtInicialGotFocus")
            BINDEVENT(THIS.txt_4c_Dt_final,   "GotFocus", THIS, "TxtDtFinalGotFocus")

            BINDEVENT(THIS.txt_4c_CdGrupos,   "KeyPress", THIS, "ValidarCdGruposKeyPress")
            BINDEVENT(THIS.txt_4c_DsGrupos,   "KeyPress", THIS, "ValidarDsGruposKeyPress")
            BINDEVENT(THIS.txt_4c_CdContas,   "KeyPress", THIS, "ValidarCdContasKeyPress")
            BINDEVENT(THIS.txt_4c_DsContas,   "KeyPress", THIS, "ValidarDsContasKeyPress")
            BINDEVENT(THIS.txt_4c_Dt_inicial, "KeyPress", THIS, "ValidarDtInicialKeyPress")
            BINDEVENT(THIS.txt_4c_Dt_final,   "KeyPress", THIS, "ValidarDtFinalKeyPress")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFiltros")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarContainersFlutuantes - Orquestra os 3 paineis Visible=.F. do
    * legado, alternados por botao (cntjustificativa/cntProcurar/impchmat -
    * mapeamento.json: cnt_4c_justificativa/cnt_4c_Procurar/cnt_4c_Impchmat).
    * Precisam ficar na lista de skip de TornarControlesVisiveis (ja
    * presente desde a Fase 3) - senao nasceriam visiveis.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainersFlutuantes()
        THIS.ConfigurarJustificativa()
        THIS.ConfigurarProcurar()
        THIS.ConfigurarImpressaoManual()
    ENDPROC

    *==========================================================================
    * ConfigurarJustificativa - Painel de justificativa do cancelamento de
    * documento (cnt_4c_justificativa = cntjustificativa do legado, Registro
    * 47/48 do SCX). Aberto por BtnExcluiDocClick (editavel) ou por
    * AtualizarPainelChequeCorrente (somente leitura, ao navegar para um
    * cheque ja cancelado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarJustificativa()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_justificativa", "Container")
            WITH THIS.cnt_4c_justificativa
                .Top           = 532
                .Left          = 395
                .Width         = 350
                .Height        = 69
                .BorderWidth   = 0
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .F.
            ENDWITH

            THIS.cnt_4c_justificativa.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.cnt_4c_justificativa.lbl_4c_Label5
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Justificativa do cancelamento"
                .Left      = 6
                .Top       = 5
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_justificativa.AddObject("obj_4c_Get_justificativa", "EditBox")
            WITH THIS.cnt_4c_justificativa.obj_4c_Get_justificativa
                .Top       = 21
                .Left      = 3
                .Width     = 238
                .Height    = 44
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(0, 0, 0)
                .ReadOnly  = .F.
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_justificativa.AddObject("obj_4c_CmdGconf", "CommandGroup")
            WITH THIS.cnt_4c_justificativa.obj_4c_CmdGconf
                .Top         = 18
                .Left        = 243
                .Width       = 107
                .Height      = 47
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 0
                .Visible     = .T.
            ENDWITH

            WITH THIS.cnt_4c_justificativa.obj_4c_CmdGconf.Buttons(1)
                .Top         = 4
                .Left        = 5
                .Width       = 48
                .Height      = 40
                .FontName    = "Verdana"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "geral_escudo_ok_32.jpg"
                .Caption     = ""
                .ToolTipText = "Confirmar"
                .ForeColor   = RGB(36, 84, 155)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH

            WITH THIS.cnt_4c_justificativa.obj_4c_CmdGconf.Buttons(2)
                .Top         = 4
                .Left        = 53
                .Width       = 48
                .Height      = 40
                .FontName    = "Verdana"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
                .Cancel      = .T.
                .Caption     = ""
                .ToolTipText = "Cancelar"
                .ForeColor   = RGB(36, 84, 155)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH

            BINDEVENT(THIS.cnt_4c_justificativa.obj_4c_CmdGconf, "Click", THIS, "CmdGconfClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarJustificativa")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarProcurar - Painel de busca de cheque por Banco/Agencia/
    * Conta/Cheque/Emissao/Valor ou leitor de codigo de barras
    * (cnt_4c_Procurar = cntProcurar do legado, Registro 59+). Aberto por
    * BtnProcurarClick (botao Procurar do CommandGroup principal).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarProcurar()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Procurar", "Container")
            WITH THIS.cnt_4c_Procurar
                .Top           = 284
                .Left          = 240
                .Width         = 314
                .Height        = 218
                .SpecialEffect = 0
                .Enabled       = .F.
                .Visible       = .F.
                .BackColor     = RGB(255, 255, 255)
            ENDWITH

            THIS.cnt_4c_Procurar.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.cnt_4c_Procurar.lbl_4c_Label1
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 9
                .BackStyle = 0
                .Caption   = "Procurar"
                .Left      = 12
                .Top       = 8
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Procurar.AddObject("lbl_4c_LblBanco", "Label")
            WITH THIS.cnt_4c_Procurar.lbl_4c_LblBanco
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Banco :"
                .Left      = 36
                .Top       = 139
                .Width     = 38
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Procurar.AddObject("lbl_4c_LblAgencia", "Label")
            WITH THIS.cnt_4c_Procurar.lbl_4c_LblAgencia
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Ag" + CHR(234) + "ncia :"
                .Left      = 27
                .Top       = 163
                .Width     = 47
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Procurar.AddObject("lbl_4c_LblConta", "Label")
            WITH THIS.cnt_4c_Procurar.lbl_4c_LblConta
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Conta :"
                .Left      = 36
                .Top       = 187
                .Width     = 38
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Procurar.AddObject("lbl_4c_LblCheque", "Label")
            WITH THIS.cnt_4c_Procurar.lbl_4c_LblCheque
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Cheque :"
                .Left      = 164
                .Top       = 139
                .Width     = 46
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Procurar.AddObject("lbl_4c_LblEmissao", "Label")
            WITH THIS.cnt_4c_Procurar.lbl_4c_LblEmissao
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Emiss" + CHR(227) + "o :"
                .Left      = 163
                .Top       = 163
                .Width     = 47
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Procurar.AddObject("lbl_4c_LblValor", "Label")
            WITH THIS.cnt_4c_Procurar.lbl_4c_LblValor
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Valor :"
                .Left      = 177
                .Top       = 187
                .Width     = 33
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Procurar.AddObject("txt_4c_Banco", "TextBox")
            WITH THIS.cnt_4c_Procurar.txt_4c_Banco
                .Top           = 135
                .Left          = 77
                .Width         = 31
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 3
                .SpecialEffect = 1
                .BorderColor   = RGB(36, 84, 155)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Procurar.AddObject("txt_4c_Agencia", "TextBox")
            WITH THIS.cnt_4c_Procurar.txt_4c_Agencia
                .Top           = 158
                .Left          = 77
                .Width         = 40
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 4
                .SpecialEffect = 1
                .BorderColor   = RGB(36, 84, 155)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Procurar.AddObject("txt_4c_Conta", "TextBox")
            WITH THIS.cnt_4c_Procurar.txt_4c_Conta
                .Top           = 181
                .Left          = 77
                .Width         = 81
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 10
                .SpecialEffect = 1
                .BorderColor   = RGB(36, 84, 155)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Procurar.AddObject("txt_4c_Cheque", "TextBox")
            WITH THIS.cnt_4c_Procurar.txt_4c_Cheque
                .Top           = 135
                .Left          = 213
                .Width         = 52
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 6
                .SpecialEffect = 1
                .BorderColor   = RGB(36, 84, 155)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- getEmissao/getValor sao DATE/NUMERIC (Dtos()/Str(...,12,2) no
            *-- SEEK do legado exigem esses tipos, apesar do InputMask do SCX
            *-- nao declarar Format de data/numero).
            THIS.cnt_4c_Procurar.AddObject("txt_4c_Emissao", "TextBox")
            WITH THIS.cnt_4c_Procurar.txt_4c_Emissao
                .Top           = 158
                .Left          = 213
                .Width         = 81
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .BorderColor   = RGB(36, 84, 155)
                .Value         = {}
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Procurar.AddObject("txt_4c_Valor", "TextBox")
            WITH THIS.cnt_4c_Procurar.txt_4c_Valor
                .Top           = 181
                .Left          = 213
                .Width         = 81
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999,999.99"
                .SpecialEffect = 1
                .BorderColor   = RGB(36, 84, 155)
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Procurar.AddObject("obj_4c_Cmdgprocurar", "CommandGroup")
            WITH THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar
                .Top           = 7
                .Left          = 135
                .Width         = 173
                .Height        = 110
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 189, 188)
                .Themes        = .F.
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            WITH THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar.Buttons(1)
                .Top             = 1
                .Left            = 21
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .Caption         = "\<Procurar"
                .PicturePosition = 1
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            WITH THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar.Buttons(2)
                .Top             = 1
                .Left            = 97
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .Caption         = "Encerrar"
                .PicturePosition = 1
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            BINDEVENT(THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar, "Click", THIS, "CmdgprocurarClick")
            BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_Banco, "KeyPress", THIS, "TxtProcurarBancoKeyPress")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarProcurar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarImpressaoManual - Painel de impressao matricial manual por
    * Banco + faixa de cheques (cnt_4c_Impchmat = impchmat do legado,
    * Registro 50+). Aberto por BtnChMatClick quando nao ha cheque marcado
    * na grade.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarImpressaoManual()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Impchmat", "Container")
            WITH THIS.cnt_4c_Impchmat
                .Top           = 284
                .Left          = 240
                .Width         = 314
                .Height        = 218
                .SpecialEffect = 0
                .Enabled       = .F.
                .Visible       = .F.
                .BackColor     = RGB(255, 255, 255)
            ENDWITH

            THIS.cnt_4c_Impchmat.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.cnt_4c_Impchmat.lbl_4c_Label1
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .BackStyle = 0
                .Caption   = "Impress" + CHR(227) + "o"
                .Left      = 12
                .Top       = 8
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Impchmat.AddObject("lbl_4c_LblBanco", "Label")
            WITH THIS.cnt_4c_Impchmat.lbl_4c_LblBanco
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Banco :"
                .Left      = 66
                .Top       = 157
                .Width     = 38
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Impchmat.AddObject("lbl_4c_LblAgencia", "Label")
            WITH THIS.cnt_4c_Impchmat.lbl_4c_LblAgencia
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Cheque Inicial :"
                .Left      = 28
                .Top       = 185
                .Width     = 76
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Impchmat.AddObject("lbl_4c_LblCheque", "Label")
            WITH THIS.cnt_4c_Impchmat.lbl_4c_LblCheque
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Cheque Final :"
                .Left      = 172
                .Top       = 184
                .Width     = 71
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Impchmat.AddObject("txt_4c_Banco", "TextBox")
            WITH THIS.cnt_4c_Impchmat.txt_4c_Banco
                .Top           = 153
                .Left          = 107
                .Width         = 31
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 3
                .SpecialEffect = 1
                .BorderColor   = RGB(36, 84, 155)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Impchmat.AddObject("txt_4c_Chini", "TextBox")
            WITH THIS.cnt_4c_Impchmat.txt_4c_Chini
                .Top           = 179
                .Left          = 107
                .Width         = 52
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 6
                .SpecialEffect = 1
                .BorderColor   = RGB(36, 84, 155)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Impchmat.AddObject("txt_4c_Chfin", "TextBox")
            WITH THIS.cnt_4c_Impchmat.txt_4c_Chfin
                .Top           = 180
                .Left          = 245
                .Width         = 52
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 6
                .SpecialEffect = 1
                .BorderColor   = RGB(36, 84, 155)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Impchmat.AddObject("obj_4c_CmdGprocurar", "CommandGroup")
            WITH THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar
                .Top           = 7
                .Left          = 134
                .Width         = 173
                .Height        = 110
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 189, 188)
                .Themes        = .F.
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            WITH THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar.Buttons(1)
                .Top             = 1
                .Left            = 13
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                .Caption         = "\<Imprimir"
                .PicturePosition = 1
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            WITH THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar.Buttons(2)
                .Top             = 1
                .Left            = 95
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .Caption         = "Encerrar"
                .PicturePosition = 1
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            BINDEVENT(THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar, "Click", THIS, "CmdGprocurarImpChmatClick")
            BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Chini, "KeyPress", THIS, "TxtChiniKeyPress")
            BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Chfin, "KeyPress", THIS, "TxtChfinKeyPress")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarImpressaoManual")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtCdGruposGotFocus / TxtDsGruposGotFocus / TxtCdContasGotFocus /
    * TxtDsContasGotFocus / TxtDtInicialGotFocus / TxtDtFinalGotFocus -
    * Equivalente ao evento When do legado: guarda o valor corrente do campo
    * ANTES da edicao (AntCdGrupo/AntDsGrupo/AntCdConta/AntDsConta/AntDtIni/
    * AntDtFin), para o KeyPress-Valid comparar depois e decidir se limpa a
    * grade. PUBLIC - BINDEVENT so dispara metodos PUBLIC.
    *==========================================================================
    PROCEDURE TxtCdGruposGotFocus()
        THIS.this_oBusinessObject.this_cAntCodGrupo = THIS.txt_4c_CdGrupos.Value
    ENDPROC

    PROCEDURE TxtDsGruposGotFocus()
        THIS.this_oBusinessObject.this_cAntDescGrupo = THIS.txt_4c_DsGrupos.Value
    ENDPROC

    PROCEDURE TxtCdContasGotFocus()
        THIS.this_oBusinessObject.this_cAntCodConta = THIS.txt_4c_CdContas.Value
    ENDPROC

    PROCEDURE TxtDsContasGotFocus()
        THIS.this_oBusinessObject.this_cAntDescConta = THIS.txt_4c_DsContas.Value
    ENDPROC

    PROCEDURE TxtDtInicialGotFocus()
        THIS.this_oBusinessObject.this_dAntDataInicial = THIS.txt_4c_Dt_inicial.Value
    ENDPROC

    PROCEDURE TxtDtFinalGotFocus()
        THIS.this_oBusinessObject.this_dAntDataFinal = THIS.txt_4c_Dt_final.Value
    ENDPROC

    *==========================================================================
    * LimparChequesSeFiltroMudou - Equivalente ao "If Used('CsSigCqChi') / Zap
    * In CsSigCqChi / ThisForm.GrdCCheques.Refresh" repetido em TODOS os Valid
    * de filtro do legado: some com a grade quando o usuario altera Grupo/
    * Conta/Periodo, para nao exibir resultado desatualizado ate clicar
    * Processar. ZAP exige SAFETY OFF (config.prg so seta SET EXACT ON - a
    * mesma ressalva de MontaGrade acima).
    *==========================================================================
    PROTECTED PROCEDURE LimparChequesSeFiltroMudou()
        LOCAL loc_cCursor, loc_cSafety

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF USED(loc_cCursor)
            loc_cSafety = SET("Safety")
            SET SAFETY OFF

            SELECT (loc_cCursor)
            ZAP

            IF loc_cSafety == "ON"
                SET SAFETY ON
            ENDIF

            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarCdGruposKeyPress / ValidarDsGruposKeyPress - Equivalente ao Valid
    * de GetCdGrupos/GetDsGrupos do legado (fAcessoContab): F4 abre o picker
    * (AbrirBuscaGrupo), Enter/Tab tenta o match EXATO contra SigCdGcr
    * (Codigos/Descrs) e, sem match, abre o picker com o prefixo digitado. O
    * campo Descricao replica o guard do When original (Return(Empty(
    * GetCdGrupos.Value))) - so participa da busca quando o Codigo esta vazio.
    *==========================================================================
    PROCEDURE ValidarCdGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_lMudou

        IF par_nKeyCode = 115  && F4
            THIS.AbrirBuscaGrupo()
            NODEFAULT
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
        loc_lMudou = loc_cValor != ALLTRIM(THIS.this_oBusinessObject.this_cAntCodGrupo)

        IF EMPTY(loc_cValor)
            THIS.txt_4c_DsGrupos.Value = ""
        ELSE
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cValor)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
                THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
                THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)

                IF USED("cursor_4c_BuscaGrupo")
                    USE IN cursor_4c_BuscaGrupo
                ENDIF
            ELSE
                IF USED("cursor_4c_BuscaGrupo")
                    USE IN cursor_4c_BuscaGrupo
                ENDIF
                THIS.AbrirBuscaGrupo()
                RETURN
            ENDIF
        ENDIF

        IF loc_lMudou
            THIS.LimparChequesSeFiltroMudou()
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_lMudou

        IF par_nKeyCode = 115  && F4
            THIS.AbrirBuscaGrupo()
            NODEFAULT
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        *-- Legado: GetDsGrupos.When = Return(Empty(GetCdGrupos.Value)) - o
        *-- campo Descricao so participa da busca quando o Codigo esta vazio.
        IF !EMPTY(THIS.txt_4c_CdGrupos.Value)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
        loc_lMudou = loc_cValor != ALLTRIM(THIS.this_oBusinessObject.this_cAntDescGrupo)

        IF EMPTY(loc_cValor)
            THIS.txt_4c_CdGrupos.Value = ""
        ELSE
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE descrs = " + EscaparSQL(loc_cValor)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
                THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
                THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)

                IF USED("cursor_4c_BuscaGrupo")
                    USE IN cursor_4c_BuscaGrupo
                ENDIF
            ELSE
                IF USED("cursor_4c_BuscaGrupo")
                    USE IN cursor_4c_BuscaGrupo
                ENDIF
                THIS.AbrirBuscaGrupo()
                RETURN
            ENDIF
        ENDIF

        IF loc_lMudou
            THIS.LimparChequesSeFiltroMudou()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaGrupo - Picker de Grupo de Contas (SigCdGcr.Codigos/Descrs).
    * Substitui fAcessoContab (Framework\sigacess.PRG) - a funcao legada
    * embute regra de acesso por usuario/grupo contabil complexa demais para
    * UI de lookup direto (mesma familia de cautela de fAcessoContas, ver
    * memoria feedback_facessocontas_lookup_ux.md); aqui o filtro eh o
    * prefixo ja digitado, igual ao padrao Pattern A do projeto.
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_oBusca, loc_cSQL, loc_cFiltro, loc_nResultado

        loc_cFiltro = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
        IF EMPTY(loc_cFiltro)
            loc_cFiltro = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
        ENDIF

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF

        IF !EMPTY(loc_cFiltro)
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE " + ;
                "codigos LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
                " OR descrs LIKE " + EscaparSQL(loc_cFiltro + "%") + " ORDER BY codigos"
        ELSE
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            loc_oBusca.DefinirCursor("cursor_4c_BuscaGrupo", "codigos", "descrs", ;
                "Grupo de Contas")

            IF loc_oBusca.Mostrar()
                THIS.txt_4c_CdGrupos.Value = loc_oBusca.cCodigoSelecionado
                THIS.txt_4c_DsGrupos.Value = loc_oBusca.cDescricaoSelecionada
                THIS.LimparChequesSeFiltroMudou()
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarCdContasKeyPress / ValidarDsContasKeyPress - Equivalente ao Valid
    * de getCdContas/getDsContas do legado (fAcessoContas): F4 abre o picker
    * (AbrirBuscaConta), Enter/Tab tenta o match EXATO contra SigCdCli
    * (Iclis/Rclis) filtrado pelo Grupo corrente, e sem match abre o picker
    * com o prefixo digitado. getDsContas replica o guard do When original
    * (Return(Empty(GetCdContas.Value))).
    *==========================================================================
    PROCEDURE ValidarCdContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cGrupo, loc_cSQL, loc_nResultado, loc_lMudou

        IF par_nKeyCode = 115  && F4
            THIS.AbrirBuscaConta()
            NODEFAULT
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_CdContas.Value)
        loc_lMudou = loc_cValor != ALLTRIM(THIS.this_oBusinessObject.this_cAntCodConta)

        IF EMPTY(loc_cValor)
            THIS.txt_4c_DsContas.Value = ""
        ELSE
            loc_cGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cValor)
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
                THIS.txt_4c_CdContas.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
                THIS.txt_4c_DsContas.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)

                IF USED("cursor_4c_BuscaConta")
                    USE IN cursor_4c_BuscaConta
                ENDIF
            ELSE
                IF USED("cursor_4c_BuscaConta")
                    USE IN cursor_4c_BuscaConta
                ENDIF
                THIS.AbrirBuscaConta()
                RETURN
            ENDIF
        ENDIF

        IF loc_lMudou
            THIS.LimparChequesSeFiltroMudou()
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cGrupo, loc_cSQL, loc_nResultado, loc_lMudou

        IF par_nKeyCode = 115  && F4
            THIS.AbrirBuscaConta()
            NODEFAULT
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        *-- Legado: getDsContas.When = Return(Empty(GetCdContas.Value))
        IF !EMPTY(THIS.txt_4c_CdContas.Value)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_DsContas.Value)
        loc_lMudou = loc_cValor != ALLTRIM(THIS.this_oBusinessObject.this_cAntDescConta)

        IF EMPTY(loc_cValor)
            THIS.txt_4c_CdContas.Value = ""
        ELSE
            loc_cGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE RTRIM(rclis) = " + EscaparSQL(loc_cValor)
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
                THIS.txt_4c_CdContas.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
                THIS.txt_4c_DsContas.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)

                IF USED("cursor_4c_BuscaConta")
                    USE IN cursor_4c_BuscaConta
                ENDIF
            ELSE
                IF USED("cursor_4c_BuscaConta")
                    USE IN cursor_4c_BuscaConta
                ENDIF
                THIS.AbrirBuscaConta()
                RETURN
            ENDIF
        ENDIF

        IF loc_lMudou
            THIS.LimparChequesSeFiltroMudou()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaConta - Picker de Conta (SigCdCli.Iclis/Rclis), filtrado pelo
    * Grupo corrente quando informado. Substitui fAcessoContas
    * (Framework\sigacess.PRG) - NAO usar a funcao legada como handler de
    * lookup UX (memoria feedback_facessocontas_lookup_ux.md: auto-carrega o
    * primeiro registro do LIKE sem selecao do usuario).
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaConta()
        LOCAL loc_oBusca, loc_cSQL, loc_cFiltro, loc_cGrupo, loc_nResultado

        loc_cFiltro = ALLTRIM(THIS.txt_4c_CdContas.Value)
        IF EMPTY(loc_cFiltro)
            loc_cFiltro = ALLTRIM(THIS.txt_4c_DsContas.Value)
        ENDIF

        loc_cGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF

        loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE 1 = 1 "

        IF !EMPTY(loc_cGrupo)
            loc_cSQL = loc_cSQL + "AND grupos = " + EscaparSQL(loc_cGrupo) + " "
        ENDIF

        IF !EMPTY(loc_cFiltro)
            loc_cSQL = loc_cSQL + "AND (iclis LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
                " OR RTRIM(rclis) LIKE " + EscaparSQL(loc_cFiltro + "%") + ") "
        ENDIF

        loc_cSQL = loc_cSQL + "ORDER BY iclis"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            loc_oBusca.DefinirCursor("cursor_4c_BuscaConta", "iclis", "rclis", "Contas")

            IF loc_oBusca.Mostrar()
                THIS.txt_4c_CdContas.Value = loc_oBusca.cCodigoSelecionado
                THIS.txt_4c_DsContas.Value = loc_oBusca.cDescricaoSelecionada
                THIS.LimparChequesSeFiltroMudou()
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDtInicialKeyPress / ValidarDtFinalKeyPress - Equivalente ao Valid
    * de Dt_inicial/Dt_final do legado: mantem Data Inicial <= Data Final
    * empurrando a outra ponta do periodo (mesma logica do SCX original), e
    * limpa a grade quando o valor mudou desde que o campo recebeu foco.
    *==========================================================================
    PROCEDURE ValidarDtInicialKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lMudou

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        *-- Legado: If This.Value > Dt_Final.Value -> Dt_Final.Value = This.Value
        IF THIS.txt_4c_Dt_inicial.Value > THIS.txt_4c_Dt_final.Value
            THIS.txt_4c_Dt_final.Value = THIS.txt_4c_Dt_inicial.Value
        ENDIF

        loc_lMudou = THIS.txt_4c_Dt_inicial.Value != THIS.this_oBusinessObject.this_dAntDataInicial

        IF loc_lMudou
            THIS.LimparChequesSeFiltroMudou()
        ENDIF
    ENDPROC

    PROCEDURE ValidarDtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lMudou

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        *-- Legado: If This.Value < Dt_Inicial.Value -> Dt_Inicial.Value = This.Value
        IF THIS.txt_4c_Dt_final.Value < THIS.txt_4c_Dt_inicial.Value
            THIS.txt_4c_Dt_inicial.Value = THIS.txt_4c_Dt_final.Value
        ENDIF

        loc_lMudou = THIS.txt_4c_Dt_final.Value != THIS.this_oBusinessObject.this_dAntDataFinal

        IF loc_lMudou
            THIS.LimparChequesSeFiltroMudou()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Command2.Click ("Processar") do legado: valida o
    * periodo, sincroniza os filtros para o BO e recarrega a grade.
    *
    * O guard "so recarrega se algum filtro mudou OU eh a primeira exibicao"
    * eh transcrito como esta: as condicoes que CERCAM a validacao fazem parte
    * da regra (CLAUDE.md #21b). Os valores Ant* sao atualizados pelos eventos
    * When dos proprios campos de filtro (fase de filtros), NAO aqui - no
    * legado quem grava AntDtIni/AntCdConta eh o When de cada TextBox.
    *
    * As tres validacoes de Grupo/Conta obrigatorios que existem no legado
    * estao COMENTADAS no legado (*!*) - portanto aposentadas, e NAO migradas.
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_dIni, loc_dFim, loc_cGrupo, loc_cConta, loc_lRecarregar
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        loc_dIni   = THIS.ObterFiltroDataInicial()
        loc_dFim   = THIS.ObterFiltroDataFinal()
        loc_cGrupo = THIS.ObterFiltroGrupo()
        loc_cConta = THIS.ObterFiltroConta()

        *-- Legado: If Dt_Inicial.Value > Dt_Final.Value -> erro + SetFocus
        IF loc_dIni > loc_dFim
            MsgErro("Data Final menor que Data Inicial !!!", ;
                "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido")

            IF PEMSTATUS(THIS, "txt_4c_Dt_inicial", 5)
                THIS.txt_4c_Dt_inicial.SetFocus()
            ENDIF

            RETURN
        ENDIF

        *-- Legado: AntDtIni # Dt_Inicial Or AntDtFin # Dt_Final Or
        *--         AntCdGrupo # getCdGrupos Or AntCdConta # getCdContas Or Inicial
        loc_lRecarregar = ;
            loc_oBO.this_dAntDataInicial != loc_dIni   OR ;
            loc_oBO.this_dAntDataFinal   != loc_dFim   OR ;
            ALLTRIM(loc_oBO.this_cAntCodGrupo) != ALLTRIM(loc_cGrupo) OR ;
            ALLTRIM(loc_oBO.this_cAntCodConta) != ALLTRIM(loc_cConta) OR ;
            loc_oBO.this_lPrimeiraExibicao

        IF loc_lRecarregar
            *-- CarregarLista eh o FUNIL da carga: sincroniza os filtros da
            *-- tela para o BO (FormParaBO - fonte unica da consulta), garante
            *-- o cursor da grade e chama MontaGrade, que ja reporta a falha
            *-- (mensagem unica - CLAUDE.md regra #20).
            IF !THIS.CarregarLista(.F.)
                RETURN
            ENDIF
        ELSE
            *-- Sem recarga (nenhum filtro mudou desde a ultima consulta): o BO
            *-- continua espelhando a tela para as demais acoes da tela.
            THIS.FormParaBO()
        ENDIF

        *-- Legado: ThisForm.GrdCCheques.ClnContas.SetFocus
        IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
            THIS.grd_4c_Dados.Column2.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * ObterFiltroDataInicial / ObterFiltroDataFinal - Periodo corrente. Mesma
    * regra dos filtros de Grupo/Conta: o TextBox de data (Dt_Inicial /
    * Dt_Final) entra na fase de filtros; enquanto nao existir, vale a
    * property do BO (inicializada com DATE() no Init, como o legado faz em
    * "ThisForm.Dt_Inicial.Value = Date()").
    *
    * ConverterParaData normaliza DATE/DATETIME: o TextBox nasce com {} (DATE)
    * e a coluna do banco chega como DATETIME - comparar/converter sem
    * normalizar dispara erro 11 (CLAUDE.md regra #16).
    *==========================================================================
    PROTECTED FUNCTION ObterFiltroDataInicial()
        LOCAL loc_uValor

        loc_uValor = THIS.this_oBusinessObject.this_dDataInicial

        IF PEMSTATUS(THIS, "txt_4c_Dt_inicial", 5)
            loc_uValor = THIS.txt_4c_Dt_inicial.Value
        ENDIF

        RETURN ConverterParaData(loc_uValor)
    ENDFUNC

    PROTECTED FUNCTION ObterFiltroDataFinal()
        LOCAL loc_uValor

        loc_uValor = THIS.this_oBusinessObject.this_dDataFinal

        IF PEMSTATUS(THIS, "txt_4c_Dt_final", 5)
            loc_uValor = THIS.txt_4c_Dt_final.Value
        ENDIF

        RETURN ConverterParaData(loc_uValor)
    ENDFUNC

    *==========================================================================
    * CmdGokClick - Dispatcher do CommandGroup de acoes (obj_4c_CmdGok),
    * replicando o padrao 1-metodo-por-botao do cmdGok legado via
    * DO CASE(THIS.Value). PUBLIC - BINDEVENT so dispara metodos PUBLIC.
    *==========================================================================
    PROCEDURE CmdGokClick()
        DO CASE
            CASE THIS.obj_4c_CmdGok.Value = 1
                THIS.BtnDocumentoClick()
            CASE THIS.obj_4c_CmdGok.Value = 2
                THIS.BtnSairClick()
            CASE THIS.obj_4c_CmdGok.Value = 3
                THIS.BtnImprimirClick()
            CASE THIS.obj_4c_CmdGok.Value = 4
                THIS.BtnProcurarClick()
            CASE THIS.obj_4c_CmdGok.Value = 5
                THIS.BtnReciboClick()
            CASE THIS.obj_4c_CmdGok.Value = 6
                THIS.BtnExcluiDocClick()
            CASE THIS.obj_4c_CmdGok.Value = 7
                THIS.BtnImpChqClick()
            CASE THIS.obj_4c_CmdGok.Value = 8
                THIS.BtnChMatClick()
            CASE THIS.obj_4c_CmdGok.Value = 9
                THIS.BtnExcluirChqClick()
        ENDCASE
    ENDPROC

    *==========================================================================
    * BtnSairClick - Encerrar (cmdSair.Click do legado). Fecha os cursores
    * auxiliares de contas e libera o form.
    *==========================================================================
    PROCEDURE BtnSairClick()
        IF USED(THIS.this_oBusinessObject.this_cCursorContas)
            USE IN (THIS.this_oBusinessObject.this_cCursorContas)
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnExcluirChqClick - Excluir Chq. (btnExcluirChq.Click do legado). So
    * confirma e delega ao BusinessObject.Excluir() - AntesDeExcluir() ja
    * replica o guard do legado (ncancelas=1 AND ExcluirCheque) e a falha eh
    * reportada sozinha pelo BusinessBase (CLAUDE.md regra #20).
    *
    * CarregarDoCursor() (SigPrChrBO) le as colunas RAW de SigCqChi
    * (cancelas/emitidos/grupos/vencs/versos/empdopnums/impversos) - nomes
    * que NAO existem em cursor_4c_Cheques (a grade tem so nemitidos/
    * ncancelas convertidos via CASE WHEN, sem grupos/vencs/versos/
    * empdopnums/impversos). Passar o cursor da grade direto estouraria
    * "Variable 'CANCELAS' is not found." Por isso o cheque corrente eh
    * relido com SELECT * FROM SigCqChi (mesmas colunas que CarregarDoCursor
    * espera), pela PK cidchaves.
    *==========================================================================
    PROCEDURE BtnExcluirChqClick()
        LOCAL loc_cCursor, loc_cCidchaves, loc_cSQL, loc_nResultado, loc_cMensagem

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF !USED(loc_cCursor) OR EOF(loc_cCursor)
            MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_cCidchaves = EVALUATE(loc_cCursor + ".cidchaves")

        IF USED("cursor_4c_ChequeAtual")
            USE IN cursor_4c_ChequeAtual
        ENDIF

        loc_cSQL = "SELECT * FROM SigCqChi WHERE cidchaves = " + EscaparSQL(loc_cCidchaves)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChequeAtual")

        IF loc_nResultado <= 0 OR RECCOUNT("cursor_4c_ChequeAtual") = 0
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o cheque para exclus" + CHR(227) + "o." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            IF USED("cursor_4c_ChequeAtual")
                USE IN cursor_4c_ChequeAtual
            ENDIF
            RETURN
        ENDIF

        THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_ChequeAtual")

        IF USED("cursor_4c_ChequeAtual")
            USE IN cursor_4c_ChequeAtual
        ENDIF

        loc_cMensagem = "Deseja realmente excluir o cheque :" + CHR(13) + ;
            ALLTRIM(THIS.this_oBusinessObject.this_cBancos)   + " / " + ;
            ALLTRIM(THIS.this_oBusinessObject.this_cAgencias) + " / " + ;
            ALLTRIM(THIS.this_oBusinessObject.this_cNcontas)  + " / " + ;
            ALLTRIM(THIS.this_oBusinessObject.this_cNcheques) + " ?"

        IF MsgConfirma(loc_cMensagem, "Exclus" + CHR(227) + "o de cheque cancelado")
            IF THIS.this_oBusinessObject.Excluir()
                SELECT (loc_cCursor)
                DELETE
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnMarcarTudoClick / BtnDesmarcarTudoClick - cmdTudo1.Click /
    * cmdApaga1.Click do legado (marca/desmarca em massa a coluna Imprime).
    *==========================================================================
    PROCEDURE BtnMarcarTudoClick()
        LOCAL loc_cCursor, loc_nRecno

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF USED(loc_cCursor)
            loc_nRecno = RECNO(loc_cCursor)
            UPDATE (loc_cCursor) SET nmarca1s = 1 WHERE nmarca1s = 0 AND nemitidos = 0 AND ncancelas = 0

            IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
                SELECT (loc_cCursor)
                GOTO loc_nRecno
            ENDIF

            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesmarcarTudoClick()
        LOCAL loc_cCursor, loc_nRecno

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF USED(loc_cCursor)
            loc_nRecno = RECNO(loc_cCursor)
            UPDATE (loc_cCursor) SET nmarca1s = 0 WHERE nmarca1s = 1

            IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
                SELECT (loc_cCursor)
                GOTO loc_nRecno
            ENDIF

            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnImprimirClick - Imprimir (cmdImprimir.Click do legado): abre
    * FormSigReEch (Emissao de Cheque, ja migrado) no modo CONSULTAR para o
    * cheque selecionado na grade - mesmos parametros do "Do Form SigReEch
    * With emps,dopes,numes,'CONSULTAR',ncheques" original.
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        LOCAL loc_cCursor, loc_oForm, loc_oErro

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF !USED(loc_cCursor) OR EOF(loc_cCursor)
            MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_oForm = .NULL.
        SELECT (loc_cCursor)

        TRY
            loc_oForm = CREATEOBJECT("FormSigReEch", emps, dopes, numes, "CONSULTAR", ncheques)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir emiss" + CHR(227) + "o de cheque")
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnDocumentoClick - Documento (cmdDocumento.Click do legado): confere
    * se existe lancamento de pagamento para o EmpDopNums do cheque
    * selecionado (mesmo guard do "CursorQuery('SigCdPgr',,'empdopnums',...)"
    * original) e, se existir, abre o cadastro correspondente (Formpgr, ja
    * migrado - SIGCDPGR.SCX). Sem lancamento, nao faz nada (mesmo
    * comportamento do Else do legado).
    *==========================================================================
    PROCEDURE BtnDocumentoClick()
        LOCAL loc_cCursor, loc_cEmpDopNums, loc_cSQL, loc_nResultado, loc_oForm, loc_oErro

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF !USED(loc_cCursor) OR EOF(loc_cCursor)
            MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        loc_cEmpDopNums = PADR(emps, 3) + PADR(dopes, 20) + STR(numes, 6)

        loc_cSQL = "SELECT TOP 1 empdopnums FROM SigCdPgr WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaPgr")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_VerificaPgr") > 0
            loc_oForm = .NULL.
            TRY
                loc_oForm = CREATEOBJECT("Formpgr")
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao abrir Lan" + CHR(231) + "amentos e Pagamentos")
                loc_oForm = .NULL.
            ENDTRY

            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ENDIF
        ENDIF

        IF USED("cursor_4c_VerificaPgr")
            USE IN cursor_4c_VerificaPgr
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnProcurarClick - Procurar (cmdProcurar.Click do legado): ABRE o
    * painel de busca de cheque por Banco/Agencia/Conta/Cheque/Emissao/Valor
    * ou leitor de codigo de barras (cnt_4c_Procurar) - NAO eh toggle: o
    * legado ("ThisForm.plInicio = .T. / ThisForm.CntProcurar.Init") sempre
    * abre, e o fechamento vem so pelos botoes Procurar/Cancelar do painel
    * (FecharPainelProcurar). Desabilita os demais controles da tela
    * enquanto o painel esta aberto, como o legado faz.
    *==========================================================================
    PROCEDURE BtnProcurarClick()
        IF !PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
            RETURN
        ENDIF

        THIS.LockScreen = .T.

        *-- Legado (cntProcurar.Init): desliga Conta/Descricao da conta/grade/
        *-- Favorecido/CmdGOk e mostra o painel. O conjunto exato vive em
        *-- AjustarBotoesPorModo/HabilitarCampos, que tambem eh o funil de
        *-- VOLTA (FecharPainelProcurar) - CLAUDE.md regra #40.
        THIS.AjustarBotoesPorModo("PROCURAR")

        IF PEMSTATUS(THIS.cnt_4c_Procurar, "txt_4c_Banco", 5)
            THIS.cnt_4c_Procurar.txt_4c_Banco.SetFocus()
        ENDIF

        THIS.Refresh()

        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    * FecharPainelProcurar - Reabilita os controles desabilitados por
    * BtnProcurarClick, oculta o painel e recarrega a exibicao (mExibeCheques
    * (.F.) do legado - mesmo corpo nos dois botoes cmdprocurar/cmdCancelar
    * de cntProcurar.cmdgprocurar, so a busca em si difere).
    *==========================================================================
    PROTECTED PROCEDURE FecharPainelProcurar()
        *-- FUNIL de volta: reabilita o que "PROCURAR" desligou e oculta o
        *-- painel (CLAUDE.md regra #40).
        THIS.AjustarBotoesPorModo("LISTA")

        THIS.ExibirCheques(.F.)
    ENDPROC

    *==========================================================================
    * CmdgprocurarClick - Dispatcher do CommandGroup obj_4c_Cmdgprocurar
    * (cntProcurar.cmdgprocurar do legado: Botao1=Procurar, Botao2=Cancelar).
    * PUBLIC - BINDEVENT so dispara metodos PUBLIC.
    *==========================================================================
    PROCEDURE CmdgprocurarClick()
        DO CASE
            CASE THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar.Value = 1
                THIS.ProcurarChequeNoPainel()
            CASE THIS.cnt_4c_Procurar.obj_4c_Cmdgprocurar.Value = 2
                THIS.BtnCancelarClick("PROCURAR")
        ENDCASE
    ENDPROC

    *==========================================================================
    * ProcurarChequeNoPainel - cmdprocurar.Click do legado: posiciona o
    * cursor de cheques pelo primeiro campo preenchido (Emissao > Valor >
    * Banco > Agencia > Conta > Cheque - mesma ordem/DO CASE do legado),
    * usando SET NEAR ON (posiciona no registro mais proximo, mesmo sem
    * achar exato) e fecha o painel.
    *==========================================================================
    PROCEDURE ProcurarChequeNoPainel()
        LOCAL loc_cCursor, loc_cBanco, loc_cAgencia, loc_cConta, loc_cCheque
        LOCAL loc_dEmissao, loc_nValor

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF !USED(loc_cCursor)
            THIS.FecharPainelProcurar()
            RETURN
        ENDIF

        WITH THIS.cnt_4c_Procurar
            loc_cBanco = PADR(ALLTRIM(.txt_4c_Banco.Value), 3)
            .txt_4c_Banco.Value = loc_cBanco
            loc_cAgencia = .txt_4c_Agencia.Value
            loc_cConta   = .txt_4c_Conta.Value
            loc_cCheque  = .txt_4c_Cheque.Value
            loc_dEmissao = ConverterParaData(.txt_4c_Emissao.Value)
            loc_nValor   = .txt_4c_Valor.Value
            .Visible     = .T.
        ENDWITH

        SELECT (loc_cCursor)
        SET NEAR ON

        DO CASE
            CASE !EMPTY(loc_dEmissao)
                SET ORDER TO Emissao
                SEEK DTOS(loc_dEmissao) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
            CASE loc_nValor != 0
                SET ORDER TO Valor
                SEEK STR(loc_nValor, 12, 2) + loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
            CASE !EMPTY(loc_cBanco)
                SET ORDER TO Cheque
                SEEK loc_cBanco + loc_cAgencia + loc_cConta + loc_cCheque
            CASE !EMPTY(loc_cAgencia)
                SET ORDER TO Agencia
                SEEK loc_cAgencia + loc_cConta + loc_cCheque
            CASE !EMPTY(loc_cConta)
                SET ORDER TO Conta
                SEEK loc_cConta + loc_cCheque
            CASE !EMPTY(loc_cCheque)
                SET ORDER TO NCheques
                SEEK loc_cCheque
        ENDCASE

        SET NEAR OFF

        THIS.FecharPainelProcurar()
    ENDPROC

    *==========================================================================
    * TxtProcurarBancoKeyPress - Leitor de codigo de barras do cheque
    * (cntProcurar.getBanco.KeyPress do legado): tecla 60 inicia a captura,
    * 58 finaliza e decodifica a string lida em Banco/Agencia/Conta/Cheque.
    * this_lLeitorChequeAtivo/this_cChequeLido (SigPrChrBO) sao os mesmos
    * plLeCheque/pcChqLido do legado. PUBLIC - BINDEVENT so dispara metodos
    * PUBLIC.
    *==========================================================================
    PROCEDURE TxtProcurarBancoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 60
            IF !THIS.this_oBusinessObject.this_lLeitorChequeAtivo
                THIS.this_oBusinessObject.this_cChequeLido = ""
            ENDIF
            THIS.this_oBusinessObject.this_lLeitorChequeAtivo = .T.
        ENDIF

        IF THIS.this_oBusinessObject.this_lLeitorChequeAtivo
            THIS.this_oBusinessObject.this_cChequeLido = ;
                THIS.this_oBusinessObject.this_cChequeLido + CHR(par_nKeyCode)
            NODEFAULT
        ENDIF

        IF par_nKeyCode = 58
            THIS.ValidarLeitorChequeProcurar()
            THIS.this_oBusinessObject.this_lLeitorChequeAtivo = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarLeitorChequeProcurar - getBanco.Valid do legado (ramo do
    * leitor): com >= 33 chars lidos, decodifica Banco/Agencia/Conta/Cheque
    * pelas mesmas posicoes SUBSTR do legado e ja aciona a busca
    * (This.Parent.CmdGProcurar.CmdProcurar.Click).
    *==========================================================================
    PROTECTED PROCEDURE ValidarLeitorChequeProcurar()
        LOCAL loc_cLeitor

        loc_cLeitor = THIS.this_oBusinessObject.this_cChequeLido

        IF LEN(loc_cLeitor) >= 33
            WITH THIS.cnt_4c_Procurar
                .txt_4c_Banco.Value   = SUBSTR(loc_cLeitor, 2, 3)
                .txt_4c_Agencia.Value = SUBSTR(loc_cLeitor, 5, 4)
                .txt_4c_Conta.Value   = SUBSTR(loc_cLeitor, 23, 10)
                .txt_4c_Cheque.Value  = SUBSTR(loc_cLeitor, 14, 6)
                .Visible     = .T.
            ENDWITH

            THIS.Refresh()
            THIS.ProcurarChequeNoPainel()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluiDocClick - Exclui Docto. (cmdExcluiDoc.Click do legado): abre
    * o painel de justificativa do cancelamento (cnt_4c_justificativa,
    * mapeamento.json). O painel eh criado na fase de containers flutuantes
    * (Fase 6/7) - ate la, o guard PEMSTATUS abaixo mantem o botao
    * inofensivo.
    *==========================================================================
    PROCEDURE BtnExcluiDocClick()
        IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
            *-- Modo JUSTIFICATIVA: mostra o painel (o legado nao desabilita
            *-- nada da tela de fundo neste painel) e registra o modo corrente,
            *-- que eh o que BtnCancelarClick/AjustarBotoesPorModo consultam
            *-- quando chamados sem parametro.
            THIS.AjustarBotoesPorModo("JUSTIFICATIVA")

            WITH THIS.cnt_4c_justificativa
                .Visible = .T.

                IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_Get_justificativa", 5)
                    .obj_4c_Get_justificativa.Value    = ""
                    .obj_4c_Get_justificativa.Width    = 238
                    .obj_4c_Get_justificativa.ReadOnly = .F.
                    .obj_4c_Get_justificativa.SetFocus()
                ENDIF

                IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_CmdGconf", 5)
                    .obj_4c_CmdGconf.Enabled = .T.
                    .obj_4c_CmdGconf.Visible = .T.
                ENDIF
            ENDWITH
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdGconfClick - Dispatcher do CommandGroup obj_4c_CmdGconf
    * (cntjustificativa.cmdGconf do legado: Botao1=cmConfirmar,
    * Botao2=cmdCancelar). PUBLIC - BINDEVENT so dispara metodos PUBLIC.
    *==========================================================================
    PROCEDURE CmdGconfClick()
        DO CASE
            CASE THIS.cnt_4c_justificativa.obj_4c_CmdGconf.Value = 1
                THIS.ConfirmarCancelamentoDocumento()
            CASE THIS.cnt_4c_justificativa.obj_4c_CmdGconf.Value = 2
                THIS.BtnCancelarClick("JUSTIFICATIVA")
        ENDCASE
    ENDPROC

    *==========================================================================
    * CancelarJustificativa - cmdCancelar.Click do cmdGconf legado: fecha o
    * painel sem gravar nada ("This.Parent.Enabled=.F. + This.Parent.Parent.
    * Visible=.F.").
    *==========================================================================
    PROTECTED PROCEDURE CancelarJustificativa()
        IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
            IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_CmdGconf", 5)
                THIS.cnt_4c_justificativa.obj_4c_CmdGconf.Enabled = .F.
            ENDIF
            THIS.cnt_4c_justificativa.Visible = .F.
        ENDIF

        *-- Volta ao modo de consulta. NAO passa por AjustarBotoesPorModo
        *-- ("LISTA") de proposito: aquele ramo reafirma o painel pelo cheque
        *-- corrente (AtualizarPainelChequeCorrente) e faria a justificativa
        *-- reaparecer em somente leitura no mesmo instante, enquanto o
        *-- cmdCancelar legado apenas oculta o painel e deixa assim ate a
        *-- proxima troca de linha na grade. Nenhum controle foi desabilitado
        *-- neste modo, entao nao ha o que reabilitar.
        THIS.this_cModoAtual = "LISTA"
    ENDPROC

    *==========================================================================
    * ConfirmarCancelamentoDocumento - cmConfirmar.Click do legado: exige
    * justificativa preenchida, confere se ha lancamento de pagamento para o
    * EmpDopNums do cheque corrente (mesmo guard "CursorQuery('SigCdPgr',,
    * 'empdopnums',...)" original) e abre o cadastro correspondente
    * (Formpgr, ja migrado - SIGCDPGR.SCX) para o usuario dar seguimento ao
    * cancelamento do documento.
    *
    * O legado passa a justificativa e um flag de cancelamento como
    * parametros extras do "Do Form SigCdPgr With ...,.T.,ThisForm,
    * Alltrim(get_justificativa.Value)", delegando a persistencia da
    * justificativa/cancelamento (SigCqChi.cancelas/justcanc) para dentro do
    * proprio modulo SigCdPgr. O Formpgr migrado (tarefa/task separada, sem
    * parametros de Init) nao expoe esse modo parametrizado - mesma
    * simplificacao ja adotada em BtnDocumentoClick (abre o cadastro padrao
    * quando ha lancamento, sem repassar os parametros de cancelamento).
    *==========================================================================
    PROCEDURE ConfirmarCancelamentoDocumento()
        LOCAL loc_cCursor, loc_cJustificativa, loc_cEmpDopNums, loc_cSQL
        LOCAL loc_nResultado, loc_oForm, loc_oErro

        IF !PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
            RETURN
        ENDIF

        loc_cJustificativa = ALLTRIM(THIS.cnt_4c_justificativa.obj_4c_Get_justificativa.Value)

        IF EMPTY(loc_cJustificativa)
            MsgAviso("Aten" + CHR(231) + CHR(227) + "o, justificativa em Branco", "")
            THIS.cnt_4c_justificativa.obj_4c_Get_justificativa.SetFocus()
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF !USED(loc_cCursor) OR EOF(loc_cCursor)
            THIS.ExibirCheques(.T.)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        loc_cEmpDopNums = PADR(emps, 3) + PADR(dopes, 20) + STR(numes, 6)

        loc_cSQL = "SELECT TOP 1 empdopnums FROM SigCdPgr WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaPgr")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_VerificaPgr") > 0
            loc_oForm = .NULL.
            TRY
                loc_oForm = CREATEOBJECT("Formpgr")
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao abrir Lan" + CHR(231) + "amentos e Pagamentos")
                loc_oForm = .NULL.
            ENDTRY

            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ENDIF
        ENDIF

        IF USED("cursor_4c_VerificaPgr")
            USE IN cursor_4c_VerificaPgr
        ENDIF

        THIS.CancelarJustificativa()
    ENDPROC

    *==========================================================================
    * BtnReciboClick - Recibo (cmdRecibo.Click do legado): abre o form de
    * emissao de recibo (SigRerec) para o cheque selecionado. FormSigRerec
    * ainda nao foi migrado (SCX de outra task) - o TRY/CATCH reporta o
    * problema real caso a classe nao exista, em vez de fingir sucesso.
    *==========================================================================
    PROCEDURE BtnReciboClick()
        LOCAL loc_cCursor, loc_oForm, loc_oErro

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF !USED(loc_cCursor) OR EOF(loc_cCursor)
            MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigRerec", THIS, "RECIBO")
        CATCH TO loc_oErro
            MsgErro("M" + CHR(243) + "dulo de recibo ainda n" + CHR(227) + "o dispon" + CHR(237) + "vel: " + loc_oErro.Message, "Recibo")
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnImpChqClick - Cheque (cmdImpchq.Click do legado): impressao do
    * cheque em formulario continuo. O posicionamento fisico na folha do
    * cheque (rotina de ~180 linhas do legado, com fValorExtenso() e
    * fwBuscaInt() para escolher impressora - nenhuma das duas portada) fica
    * para uma fase dedicada de impressao de cheques. Aqui: guard identico
    * ao legado ("Nenhum Cheque Selecionado") e, apos o usuario confirmar
    * que a impressao fisica foi feita, marca os cheques selecionados como
    * emitidos (efeito de dados do botao, via BO).
    *==========================================================================
    PROCEDURE BtnImpChqClick()
        LOCAL loc_cCursor, loc_nQtdMarcados

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        COUNT TO loc_nQtdMarcados FOR nmarca1s = 1

        IF loc_nQtdMarcados = 0
            MsgAviso("Nenhum Cheque Selecionado !!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF MsgConfirma("Confirma que " + ALLTRIM(STR(loc_nQtdMarcados)) + " cheque(s) selecionado(s) " + ;
                "j" + CHR(225) + " foram impressos na impressora de cheques?", "Impress" + CHR(227) + "o de Cheque")
            IF THIS.this_oBusinessObject.MarcarChequesComoEmitidos(loc_cCursor)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnChMatClick - Chq. Matric. (cmdchmat.Click do legado): impressao
    * matricial via SigIpChq.prg (utilitario legado nao portado, faz o
    * alinhamento interativo na impressora). Guard identico ao legado (todos
    * os cheques marcados tem de ser do mesmo banco) e, apos confirmacao,
    * marca como emitidos (mesmo criterio de BtnImpChqClick).
    *==========================================================================
    PROCEDURE BtnChMatClick()
        LOCAL loc_cCursor, loc_nQtdMarcados, loc_cPrimeiroBanco, loc_lMesmoBanco

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        COUNT TO loc_nQtdMarcados FOR nmarca1s = 1

        *-- Legado: sem cheque marcado (TmpChi vazio), o botao abre o painel
        *-- de impressao manual (banco + faixa de cheques digitados), em vez
        *-- de operar sobre a selecao da grade.
        IF loc_nQtdMarcados = 0
            THIS.AbrirImpressaoManualCheque()
            RETURN
        ENDIF

        loc_lMesmoBanco    = .T.
        loc_cPrimeiroBanco = ""

        SELECT (loc_cCursor)
        SCAN FOR nmarca1s = 1
            IF EMPTY(loc_cPrimeiroBanco)
                loc_cPrimeiroBanco = bancos
            ELSE
                IF bancos != loc_cPrimeiroBanco
                    loc_lMesmoBanco = .F.
                    EXIT
                ENDIF
            ENDIF
        ENDSCAN

        IF !loc_lMesmoBanco
            MsgAviso("Todos os cheques selecionados devem ser do mesmo banco", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF MsgConfirma("Verifique se a impressora matricial est" + CHR(225) + " pronta." + CHR(13) + ;
                "Confirma a impress" + CHR(227) + "o de " + ALLTRIM(STR(loc_nQtdMarcados)) + " cheque(s)?", ;
                "Impress" + CHR(227) + "o Matricial")
            IF THIS.this_oBusinessObject.MarcarChequesComoEmitidos(loc_cCursor)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirImpressaoManualCheque - impchmat.Init do legado (guardado por
    * ThisForm.ChMatIni no original; aqui chamado direto pelo ramo "sem
    * cheque marcado" de BtnChMatClick): limpa os campos, desabilita o
    * CommandGroup principal e mostra o painel de impressao manual por
    * Banco + faixa de cheques.
    *==========================================================================
    PROTECTED PROCEDURE AbrirImpressaoManualCheque()
        IF !PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
            RETURN
        ENDIF

        THIS.LockScreen = .T.

        WITH THIS.cnt_4c_Impchmat
            IF PEMSTATUS(THIS.cnt_4c_Impchmat, "txt_4c_Banco", 5)
                .txt_4c_Banco.Value = ""
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Impchmat, "txt_4c_Chini", 5)
                .txt_4c_Chini.Value = ""
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Impchmat, "txt_4c_Chfin", 5)
                .txt_4c_Chfin.Value = ""
            ENDIF
            .Visible     = .T.
        ENDWITH

        *-- Legado (impchmat.Init): desliga SO o CmdGOk e mostra o painel -
        *-- Grupo/Conta/periodo/grade continuam acessiveis. O conjunto vive em
        *-- AjustarBotoesPorModo, que tambem eh o funil de VOLTA
        *-- (FecharImpressaoManualCheque) - CLAUDE.md regra #40.
        THIS.AjustarBotoesPorModo("IMPCHMAT")

        IF PEMSTATUS(THIS.cnt_4c_Impchmat, "txt_4c_Banco", 5)
            THIS.cnt_4c_Impchmat.txt_4c_Banco.SetFocus()
        ENDIF

        THIS.Refresh()

        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    * FecharImpressaoManualCheque - cmdCancelar.Click de impchmat.cmdGprocurar
    * do legado: reabilita o CommandGroup principal, oculta o painel e
    * recarrega a exibicao (mExibeCheques(.F.)).
    *==========================================================================
    PROTECTED PROCEDURE FecharImpressaoManualCheque()
        *-- FUNIL de volta: reabilita o CmdGOk que "IMPCHMAT" desligou e oculta
        *-- o painel (CLAUDE.md regra #40).
        THIS.AjustarBotoesPorModo("LISTA")

        THIS.ExibirCheques(.F.)
    ENDPROC

    *==========================================================================
    * CmdGprocurarImpChmatClick - Dispatcher do CommandGroup
    * obj_4c_CmdGprocurar (impchmat.cmdGprocurar do legado: Botao1=cmdimpri,
    * Botao2=cmdCancelar). PUBLIC - BINDEVENT so dispara metodos PUBLIC.
    *==========================================================================
    PROCEDURE CmdGprocurarImpChmatClick()
        DO CASE
            CASE THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar.Value = 1
                THIS.ImprimirChequeManualClick()
            CASE THIS.cnt_4c_Impchmat.obj_4c_CmdGprocurar.Value = 2
                THIS.BtnCancelarClick("IMPCHMAT")
        ENDCASE
    ENDPROC

    *==========================================================================
    * ImprimirChequeManualClick - cmdimpri.Click do impchmat.cmdGprocurar
    * legado: valida Banco/faixa, filtra o cursor JA CARREGADO da grade
    * (mesma fonte que o legado usa - "Select ... From CsSigCqChi Where
    * bancos = ... And ncheques Between ... And ncancelas = 0", NAO uma nova
    * consulta ao SQL Server) e, confirmando, marca como emitidos.
    *
    * A rotina de posicionamento fisico na folha do cheque (SigIpChq.prg,
    * ~180 linhas com fValorExtenso/fwBuscaInt, nenhuma delas portada) fica
    * para uma fase dedicada de impressao de cheques - mesma ressalva ja
    * documentada em BtnImpChqClick/BtnChMatClick.
    *==========================================================================
    PROCEDURE ImprimirChequeManualClick()
        LOCAL loc_cCursor, loc_cBanco, loc_cChIni, loc_cChFin, loc_nQtd, loc_lTemEmitido

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        WITH THIS.cnt_4c_Impchmat
            loc_cBanco = .txt_4c_Banco.Value
            loc_cChIni = .txt_4c_Chini.Value
            loc_cChFin = .txt_4c_Chfin.Value
            .Visible     = .T.
        ENDWITH

        IF EMPTY(loc_cBanco)
            MsgAviso("Banco n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Impchmat.txt_4c_Banco.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_cChIni)
            MsgAviso("N" + CHR(250) + "mero do cheque inicial n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Impchmat.txt_4c_Chini.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_cChFin)
            MsgAviso("N" + CHR(250) + "mero do cheque final n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Impchmat.txt_4c_Chfin.SetFocus()
            RETURN
        ENDIF

        IF loc_cChFin < loc_cChIni
            MsgAviso("N" + CHR(250) + "mero do cheque final menor que o inicial !!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Impchmat.txt_4c_Chini.SetFocus()
            RETURN
        ENDIF

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        COUNT TO loc_nQtd FOR bancos = loc_cBanco AND BETWEEN(ncheques, loc_cChIni, loc_cChFin) AND ncancelas = 0

        IF loc_nQtd = 0
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        LOCATE FOR bancos = loc_cBanco AND BETWEEN(ncheques, loc_cChIni, loc_cChFin) AND ncancelas = 0 AND nemitidos = 1
        loc_lTemEmitido = FOUND()

        IF loc_lTemEmitido
            IF !MsgConfirma("Os cheques selecionados j" + CHR(225) + " foram emitidos. Confirma impress" + CHR(227) + "o ?", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
        ENDIF

        MsgAviso("Verifique se a impressora est" + CHR(225) + " pronta p/ impress" + CHR(227) + "o", "Aten" + CHR(231) + CHR(227) + "o")

        IF THIS.this_oBusinessObject.MarcarChequesComoEmitidosPorFaixa(loc_cCursor, loc_cBanco, loc_cChIni, loc_cChFin)
            THIS.grd_4c_Dados.Refresh()
            THIS.FecharImpressaoManualCheque()
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtChiniKeyPress / TxtChfinKeyPress - Valid de getChini/getChfin do
    * impchmat legado: preenche com zeros a esquerda ate 6 digitos
    * (PadL(Alltrim(Value),6,'0')). PUBLIC - BINDEVENT so dispara metodos
    * PUBLIC.
    *==========================================================================
    PROCEDURE TxtChiniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.cnt_4c_Impchmat.txt_4c_Chini.Value = PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value), 6, "0")
    ENDPROC

    PROCEDURE TxtChfinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value = PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value), 6, "0")
    ENDPROC

    *==========================================================================
    * ---------------------------------------------------------------------
    * FASE 8 - Eventos auxiliares e consolidacao final
    * ---------------------------------------------------------------------
    * Este form eh OPERACIONAL FLAT (consulta/cancelamento de cheques): o
    * SIGPRCHR legado NAO tem Page1=Lista/Page2=Dados, NAO tem os 5 botoes
    * CRUD (Incluir/Alterar/Visualizar/Excluir/Buscar) e NAO tem botao de
    * gravar - o dump nao declara btnSalvar/btnGravar/mGravaDados em lugar
    * nenhum. Por isso NAO existem aqui BtnSalvarClick/BtnBuscarClick nem
    * BtnEncerrarClick: inventar esses botoes violaria o PILAR 1 e a regra
    * "NUNCA inventar", e criar metodos vazios com esses nomes seria o stub
    * disfarcado proibido pela regra de completude. Os equivalentes reais,
    * com os nomes dos objetos do legado, ja existem:
    *
    *   legado               migrado                      papel
    *   -------------------  ---------------------------  -------------------
    *   Command2             BtnProcessarClick()          acao principal
    *   cmdGok.cmdSair       BtnSairClick()               Encerrar (Cancel)
    *   cmdGok.cmdProcurar   BtnProcurarClick()           localizar cheque
    *   cmdGconf.Botao2      BtnCancelarClick("JUSTIFICATIVA")
    *   cmdgprocurar.Botao2  BtnCancelarClick("PROCURAR")
    *   cmdGprocurar.Botao2  BtnCancelarClick("IMPCHMAT")
    *
    * Os hooks herdados de FormBase (FormParaBO/BOParaForm/LimparCampos)
    * continuam PROTECTED - subclasse NAO alarga escopo de metodo herdado.
    * CarregarLista/HabilitarCampos/AjustarBotoesPorModo/BtnCancelarClick
    * ficam PUBLIC: o harness de teste automatizado os chama de FORA da
    * classe (PEMSTATUS devolve .T. mesmo para PROTECTED e a chamada real
    * falharia em runtime com "Property X is not found").
    *==========================================================================

    *==========================================================================
    * CarregarLista - FUNIL unico de carga da grade de cheques. Sincroniza os
    * filtros da tela para o BO (FormParaBO - fonte unica da consulta),
    * garante que o cursor da grade exista e delega para MontaGrade(), que eh
    * a transcricao do "PROCEDURE montachq" legado (consulta o periodo,
    * repovoa o cursor com ZAP + APPEND, recria os indices e entrega para
    * ExibirCheques()).
    *
    * A mensagem de falha NAO eh repetida aqui: MontaGrade ja exibe a dela
    * ("Favor Reinicializar o Processo!!!" do legado) - CLAUDE.md regra #20.
    *
    * PUBLIC - chamado por BtnProcessarClick e pelo harness de teste.
    *==========================================================================
    PROCEDURE CarregarLista(par_lPosiciona)
        LOCAL loc_lPosiciona, loc_lSucesso, loc_cCursor
        loc_lSucesso   = .F.
        loc_lPosiciona = IIF(VARTYPE(par_lPosiciona) = "L", par_lPosiciona, .F.)

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
                "o inicializado.", "FormSigPrChr.CarregarLista")
        ELSE
            *-- Filtros da tela -> BO ANTES da consulta: CarregarCheques le
            *-- this_dDataInicial/this_dDataFinal/this_cCodGrupo/this_cCodConta.
            THIS.FormParaBO()

            loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

            IF !USED(loc_cCursor)
                THIS.CriarCursorCheques()
            ENDIF

            loc_lSucesso = THIS.MontaGrade(loc_lPosiciona)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Tela -> Business Object. Hook PROTECTED de FormBase (usado
    * por CarregarLista e por FormBase.Salvar).
    *
    * Filtros lidos pelos getters Obter* (fonte unica, com o guard PEMSTATUS e
    * a normalizacao de DATE/DATETIME via ConverterParaData - CLAUDE.md regra
    * #16). Os campos de descricao (GetDsGrupos/getDsContas), o Favorecido
    * (TxtFavorecido, somente leitura) e a justificativa de cancelamento
    * (cntjustificativa.get_justificativa) sao copiados direto.
    *
    * As properties Ant* (AntDtIni/AntDtFin/AntCdGrupo/AntCdConta do legado)
    * NAO sao tocadas aqui de proposito: elas guardam o valor de ENTRADA no
    * campo (When legado = handlers GotFocus) e sao o que BtnProcessarClick
    * compara para decidir se a grade precisa ser recarregada. Sobrescreve-las
    * aqui faria a comparacao nunca acusar mudanca e a grade nunca recarregar.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO = THIS.this_oBusinessObject

            loc_oBO.this_dDataInicial = THIS.ObterFiltroDataInicial()
            loc_oBO.this_dDataFinal   = THIS.ObterFiltroDataFinal()
            loc_oBO.this_cCodGrupo    = THIS.ObterFiltroGrupo()
            loc_oBO.this_cCodConta    = THIS.ObterFiltroConta()

            IF PEMSTATUS(THIS, "txt_4c_DsGrupos", 5)
                loc_oBO.this_cDescGrupo = THIS.txt_4c_DsGrupos.Value
            ENDIF

            IF PEMSTATUS(THIS, "txt_4c_DsContas", 5)
                loc_oBO.this_cDescConta = THIS.txt_4c_DsContas.Value
            ENDIF

            IF PEMSTATUS(THIS, "txt_4c_TxtFavorecido", 5)
                loc_oBO.this_cFavorecido = THIS.txt_4c_TxtFavorecido.Value
            ENDIF

            IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
                IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_Get_justificativa", 5)
                    loc_oBO.this_cJustCanc = ;
                        THIS.cnt_4c_justificativa.obj_4c_Get_justificativa.Value
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - Business Object -> Tela. Hook PROTECTED de FormBase (usado
    * por InicializarForm para semear o periodo e por FormBase.Cancelar).
    *
    * O legado faz esse mesmo trabalho no Init ("ThisForm.Dt_Inicial.Value =
    * Date()", "ThisForm.Dt_Final.Value = Date()", getCdGrupos/getDsGrupos/
    * getCdContas/getDsContas = Space(...)): aqui os valores vem das
    * properties do BO (this_dDataInicial/this_dDataFinal recebem DATE() no
    * SigPrChrBO.Init), mantendo o BO como fonte unica do estado dos filtros.
    *
    * O Favorecido eh espelho do cheque corrente e NAO eh escrito aqui: quem
    * o atualiza a cada linha da grade eh AtualizarPainelChequeCorrente()
    * (transcricao do AfterRowColChange/Scrolled legado). Escreve-lo tambem
    * aqui criaria duas fontes para o mesmo campo.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO = THIS.this_oBusinessObject

            IF PEMSTATUS(THIS, "txt_4c_Dt_inicial", 5)
                THIS.txt_4c_Dt_inicial.Value = ConverterParaData(loc_oBO.this_dDataInicial)
            ENDIF

            IF PEMSTATUS(THIS, "txt_4c_Dt_final", 5)
                THIS.txt_4c_Dt_final.Value = ConverterParaData(loc_oBO.this_dDataFinal)
            ENDIF

            IF PEMSTATUS(THIS, "txt_4c_CdGrupos", 5)
                THIS.txt_4c_CdGrupos.Value = loc_oBO.this_cCodGrupo
            ENDIF

            IF PEMSTATUS(THIS, "txt_4c_DsGrupos", 5)
                THIS.txt_4c_DsGrupos.Value = loc_oBO.this_cDescGrupo
            ENDIF

            IF PEMSTATUS(THIS, "txt_4c_CdContas", 5)
                THIS.txt_4c_CdContas.Value = loc_oBO.this_cCodConta
            ENDIF

            IF PEMSTATUS(THIS, "txt_4c_DsContas", 5)
                THIS.txt_4c_DsContas.Value = loc_oBO.this_cDescConta
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparCampos - Hook PROTECTED de FormBase (chamado por FormBase.Novo() e
    * por FormBase.Excluir() apos exclusao bem-sucedida). Devolve a tela ao
    * estado do Init legado: Grupo e Conta vazios, periodo = hoje, painel de
    * busca e painel de impressao manual zerados, justificativa em branco e a
    * grade sem linhas.
    *
    * O ZAP da grade replica o "Zap In CsSigCqChi" que o legado executa nos
    * Valid dos filtros quando o valor muda - reaproveitado de
    * LimparChequesSeFiltroMudou(), que ja desliga SAFETY (com SAFETY ON o ZAP
    * abre dialogo modal e CONGELA a tela).
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oBO

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO = THIS.this_oBusinessObject

            loc_oBO.this_cCodGrupo    = ""
            loc_oBO.this_cDescGrupo   = ""
            loc_oBO.this_cCodConta    = ""
            loc_oBO.this_cDescConta   = ""
            loc_oBO.this_dDataInicial = DATE()
            loc_oBO.this_dDataFinal   = DATE()
            loc_oBO.this_cFavorecido  = ""
            loc_oBO.this_cJustCanc    = ""

            *-- Proxima carga volta a ser "primeira exibicao" (Inicial do
            *-- legado): MontaGrade deve ir para o Top do cursor em vez de
            *-- reposicionar no ultimo cheque selecionado.
            loc_oBO.this_lPrimeiraExibicao = .T.

            THIS.BOParaForm()
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_TxtFavorecido", 5)
            THIS.txt_4c_TxtFavorecido.Value = ""
        ENDIF

        IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
            IF PEMSTATUS(THIS.cnt_4c_justificativa, "obj_4c_Get_justificativa", 5)
                THIS.cnt_4c_justificativa.obj_4c_Get_justificativa.Value = ""
            ENDIF
        ENDIF

        IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
            WITH THIS.cnt_4c_Procurar
                .txt_4c_Banco.Value   = ""
                .txt_4c_Agencia.Value = ""
                .txt_4c_Conta.Value   = ""
                .txt_4c_Cheque.Value  = ""
                .txt_4c_Emissao.Value = {}
                .txt_4c_Valor.Value   = 0
                .Visible     = .T.
            ENDWITH
        ENDIF

        IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
            WITH THIS.cnt_4c_Impchmat
                .txt_4c_Banco.Value = ""
                .txt_4c_Chini.Value = ""
                .txt_4c_Chfin.Value = ""
                .Visible     = .T.
            ENDWITH
        ENDIF

        THIS.LimparChequesSeFiltroMudou()

        THIS.Refresh()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Liga/desliga a superficie de CONSULTA da tela. O
    * conjunto eh EXATAMENTE o que o legado alterna no cntProcurar.Init
    * ("getCdContas / getDsContas / GrdCCheques / TxtFavorecido / CmdGOk
    * .Enabled = .F.") e desfaz nos dois botoes de cntProcurar.cmdgprocurar -
    * nem um controle a mais: Grupo, periodo e Processar continuam acessiveis
    * durante a busca, como no original (PILAR 1).
    *
    * PUBLIC - usado por AjustarBotoesPorModo e pelo harness de teste.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        IF PEMSTATUS(THIS, "txt_4c_CdContas", 5)
            THIS.txt_4c_CdContas.Enabled = loc_lHabilitar
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_DsContas", 5)
            THIS.txt_4c_DsContas.Enabled = loc_lHabilitar
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_TxtFavorecido", 5)
            THIS.txt_4c_TxtFavorecido.Enabled = loc_lHabilitar
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Enabled = loc_lHabilitar
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_CmdGok", 5)
            THIS.obj_4c_CmdGok.Enabled = loc_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - FUNIL de ida E de volta do estado dos controles
    * conforme o painel flutuante aberto. Quem DESABILITA tem de REABILITAR no
    * mesmo funil, senao a tela volta da busca com os botoes cinza e fica
    * inutilizavel ate ser reaberta (CLAUDE.md regra #40).
    *
    * Modos deste form (nao ha INCLUIR/ALTERAR/VISUALIZAR - o legado nao tem
    * CRUD nenhum):
    *   "LISTA"         consulta livre - nenhum painel aberto
    *   "PROCURAR"      cntProcurar.Init: desliga Conta/Favorecido/grade/CmdGok
    *   "IMPCHMAT"      impchmat.Init: desliga SO o CmdGok - o legado nao toca
    *                   nos demais controles neste painel, por isso este ramo
    *                   NAO chama HabilitarCampos
    *   "JUSTIFICATIVA" cntjustificativa visivel; o legado tambem nao
    *                   desabilita nada da tela de fundo neste painel
    *
    * O estado POR REGISTRO dos botoes do CmdGok (Documento/Imprimir/Recibo/
    * Exclui Docto./Excluir Chq., que dependem de o cheque estar cancelado e
    * das permissoes do usuario) continua sendo reafirmado por
    * AtualizarPainelChequeCorrente() - chamado no retorno a "LISTA" para nao
    * reabilitar em bloco botao que o registro corrente proibe.
    *
    * PUBLIC - usado pelos abre/fecha dos paineis e pelo harness de teste.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_cModo

        loc_cModo = UPPER(ALLTRIM(IIF(VARTYPE(par_cModo) = "C" AND ;
            !EMPTY(par_cModo), par_cModo, THIS.this_cModoAtual)))

        IF !INLIST(loc_cModo, "LISTA", "PROCURAR", "IMPCHMAT", "JUSTIFICATIVA")
            loc_cModo = "LISTA"
        ENDIF

        THIS.this_cModoAtual = loc_cModo

        DO CASE
            CASE loc_cModo == "PROCURAR"
                THIS.HabilitarCampos(.F.)

                IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
                    THIS.cnt_4c_Procurar.Enabled = .T.
                    THIS.cnt_4c_Procurar.Visible = .T.
                ENDIF

            CASE loc_cModo == "IMPCHMAT"
                IF PEMSTATUS(THIS, "obj_4c_CmdGok", 5)
                    THIS.obj_4c_CmdGok.Enabled = .F.
                ENDIF

                IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
                    THIS.cnt_4c_Impchmat.Enabled = .T.
                    THIS.cnt_4c_Impchmat.Visible = .T.
                ENDIF

            CASE loc_cModo == "JUSTIFICATIVA"
                IF PEMSTATUS(THIS, "cnt_4c_justificativa", 5)
                    THIS.cnt_4c_justificativa.Visible = .T.
                ENDIF

            OTHERWISE
                *-- "LISTA": volta da busca/impressao - reabilita tudo o que os
                *-- modos acima desligaram e fecha os paineis flutuantes.
                THIS.HabilitarCampos(.T.)

                IF PEMSTATUS(THIS, "cnt_4c_Procurar", 5)
                    THIS.cnt_4c_Procurar.Enabled = .F.
                    THIS.cnt_4c_Procurar.Visible = .F.
                ENDIF

                IF PEMSTATUS(THIS, "cnt_4c_Impchmat", 5)
                    THIS.cnt_4c_Impchmat.Enabled = .F.
                    THIS.cnt_4c_Impchmat.Visible = .F.
                ENDIF

                *-- Reafirma o estado por registro (cheque cancelado x
                *-- permissoes do usuario) e a visibilidade do painel de
                *-- justificativa, que no legado acompanha o cheque corrente.
                THIS.AtualizarPainelChequeCorrente()
        ENDCASE
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancelar dos paineis flutuantes. O legado tem TRES
    * botoes de cancelar, um por painel, e todos fazem a mesma coisa: fechar o
    * painel sem gravar nada e devolver a tela ao estado de consulta
    * (cmdGconf.cmdCancelar = "This.Parent.Enabled=.F. + This.Parent.Parent.
    * Visible=.F."; cmdgprocurar.cmdCancelar e cmdGprocurar.cmdCancelar
    * reabilitam a tela e chamam mExibeCheques(.F.)).
    *
    * par_cPainel identifica o painel que pediu o cancelamento - cada
    * dispatcher passa o SEU painel explicitamente. Sem parametro, detecta
    * pelo painel aberto na ordem PROCURAR -> IMPCHMAT -> JUSTIFICATIVA: a
    * justificativa fica por ULTIMO porque ela tambem aparece passivamente (em
    * somente leitura) quando o cheque corrente ja esta cancelado, e nesse
    * caso nao ha nada a cancelar se outro painel estiver aberto.
    *
    * Retorna .T. quando havia painel aberto para fechar. NAO fecha o form -
    * Encerrar eh BtnSairClick (cmdSair, Cancel = .T., como no legado).
    *
    * PUBLIC - dispatchers e harness de teste chamam de fora da classe.
    *==========================================================================
    PROCEDURE BtnCancelarClick(par_cPainel)
        LOCAL loc_cPainel, loc_lFechou
        loc_lFechou = .F.

        loc_cPainel = UPPER(ALLTRIM(IIF(VARTYPE(par_cPainel) = "C", par_cPainel, "")))

        IF EMPTY(loc_cPainel)
            DO CASE
                CASE PEMSTATUS(THIS, "cnt_4c_Procurar", 5) AND THIS.cnt_4c_Procurar.Visible
                    loc_cPainel = "PROCURAR"
                CASE PEMSTATUS(THIS, "cnt_4c_Impchmat", 5) AND THIS.cnt_4c_Impchmat.Visible
                    loc_cPainel = "IMPCHMAT"
                CASE PEMSTATUS(THIS, "cnt_4c_justificativa", 5) AND THIS.cnt_4c_justificativa.Visible
                    loc_cPainel = "JUSTIFICATIVA"
            ENDCASE
        ENDIF

        DO CASE
            CASE loc_cPainel == "PROCURAR"
                THIS.FecharPainelProcurar()
                loc_lFechou = .T.
            CASE loc_cPainel == "IMPCHMAT"
                THIS.FecharImpressaoManualCheque()
                loc_lFechou = .T.
            CASE loc_cPainel == "JUSTIFICATIVA"
                THIS.CancelarJustificativa()
                loc_lFechou = .T.
        ENDCASE

        RETURN loc_lFechou
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles criados via
    * AddObject (nascem Visible=.F.). Percorre containers e PageFrames
    * recursivamente.
    *
    * Containers FLUTUANTES do legado (cntjustificativa/impchmat/cntProcurar -
    * Visible=.F. no SCX, alternados por botao) DEVEM permanecer ocultos: o
    * nome entra no INLIST abaixo e o metodo faz LOOP sem tocar o .Visible do
    * proprio container - mas ainda RECURSA nos filhos dele antes do LOOP,
    * senao os filhos ficam Visible=.F. para sempre e o container aparece
    * vazio quando outro metodo setar .Visible = .T. nele (ver CLAUDE.md
    * regra de forms operacionais / licao "tcv_skip_recursao"). Estes
    * containers ainda nao existem na Fase 3 - a lista fica pronta para
    * quando as Fases 6/7 os criarem.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), ;
                          "CNT_4C_JUSTIFICATIVA", ;
                          "CNT_4C_IMPCHMAT", ;
                          "CNT_4C_PROCURAR")
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                *-- PageFrame: percorrer Pages tambem (nenhum neste form, mas
                *-- mantido pelo padrao canonico do projeto)
                IF PEMSTATUS(loc_oControl, "PageCount", 5)
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Libera cursores de trabalho do BO (nomes definidos em
    * SigPrChrBO.this_cCursorCheques/Contas/Impressoras). Ainda vazios na
    * Fase 3 (populados a partir da Fase 4), os IF USED() sao defensivos e
    * idempotentes. DODEFAULT() por ULTIMO restaura o menu principal
    * (FormBase.Destroy).
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Cheques")
            USE IN cursor_4c_Cheques
        ENDIF
        IF USED("cursor_4c_Contas")
            USE IN cursor_4c_Contas
        ENDIF
        IF USED("cursor_4c_Impressoras")
            USE IN cursor_4c_Impressoras
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrChrBO.prg):
*============================================================================
* SigPrChrBO.prg - Business Object para Consulta/Cancelamento de Cheques
*
* Origem legado: SIGPRCHR.SCX
* Form OPERACIONAL (nao segue padrao CRUD Page1=Lista/Page2=Dados): tela de
* consulta de cheques emitidos por conta/periodo, com filtro por Grupo e
* Conta, impressao de cheque/documento/recibo, cancelamento de documento e
* exclusao fisica de cheque cancelado (Delete From SigCqChi Where cidchaves
* = ...). Tabela principal manipulada: SigCqChi (comportamento.json).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrChrBO AS BusinessBase

    *==========================================================================
    * Filtro de periodo - espelha Dt_Inicial/Dt_Final do legado. AntData* eh
    * o valor anterior do filtro (AntDtIni/AntDtFin), usado para saber se a
    * lista de cheques precisa ser recarregada quando o campo muda de valor.
    *==========================================================================
    this_dDataInicial    = {}    && Data inicial do periodo de busca (Dt_Inicial)
    this_dDataFinal      = {}    && Data final do periodo de busca (Dt_Final)
    this_dAntDataInicial = {}    && Valor anterior de this_dDataInicial (AntDtIni)
    this_dAntDataFinal   = {}    && Valor anterior de this_dDataFinal (AntDtFin)

    *==========================================================================
    * Filtro de Grupo de Contas - espelha GetCdGrupos/GetDsGrupos. Ant* guarda
    * o valor anterior para decidir se o cursor de cheques precisa ser
    * recarregado (Zap In CsSigCqChi quando o valor muda).
    *==========================================================================
    this_cCodGrupo     = ""      && Codigo do grupo de contas (GetCdGrupos)
    this_cDescGrupo    = ""      && Descricao do grupo de contas (GetDsGrupos)
    this_cAntCodGrupo  = ""      && Valor anterior de this_cCodGrupo (AntCdGrupo)
    this_cAntDescGrupo = ""      && Valor anterior de this_cDescGrupo (AntDsGrupo)

    *==========================================================================
    * Filtro de Conta - espelha getCdContas/getDsContas. Ant* guarda o valor
    * anterior para a mesma finalidade do bloco de Grupo.
    *==========================================================================
    this_cCodConta     = ""      && Codigo da conta (getCdContas)
    this_cDescConta    = ""      && Descricao/razao social da conta (getDsContas)
    this_cAntCodConta  = ""      && Valor anterior de this_cCodConta (AntCdConta)
    this_cAntDescConta = ""      && Valor anterior de this_cDescConta (AntDsConta)

    *==========================================================================
    * Favorecido do cheque selecionado na grade (TxtFavorecido, somente
    * leitura - espelha CsSigCqChi.favos do registro corrente).
    *==========================================================================
    this_cFavorecido = ""

    *==========================================================================
    * Flags de acesso do usuario logado (fChecaAcesso('SIGPRCHR', <operacao>)
    * no Init legado) - controlam Enabled dos botoes Excluir Documento e
    * Excluir Cheque.
    *==========================================================================
    this_lExcluirDocumento = .F.  && Acesso para excluir documento (ExcluirDocumento)
    this_lExcluirCheque    = .F.  && Acesso para excluir cheque cancelado (ExcluirCheque)

    *==========================================================================
    * Controle de fluxo da primeira exibicao da lista de cheques - MontaChq
    * recebe par_lPosiciona e, quando .F. (Inicial = .T. no legado), vai
    * direto para o Top do cursor em vez de reposicionar no ultimo cheque
    * selecionado.
    *==========================================================================
    this_lPrimeiraExibicao = .T.  && Inicial

    *==========================================================================
    * Leitor de codigo de barras do cheque (getBanco.KeyPress no legado):
    * this_lLeitorChequeAtivo indica se o usuario esta no meio de uma leitura
    * (tecla 60 inicia, tecla 58 finaliza) e this_cChequeLido acumula os
    * caracteres lidos (pcChqLido).
    *==========================================================================
    this_lLeitorChequeAtivo = .F. && plLeCheque
    this_cChequeLido        = ""  && pcChqLido

    *==========================================================================
    * Nomes dos cursores de trabalho, compartilhados entre os metodos do BO
    * e o Form (grids ligados via RecordSource/ControlSource).
    *==========================================================================
    this_cCursorCheques     = "cursor_4c_Cheques"      && CsSigCqChi (cheques do periodo/conta filtrados)
    this_cCursorContas      = "cursor_4c_Contas"        && CrContas (contas com emissao de cheque habilitada)
    this_cCursorImpressoras = "cursor_4c_Impressoras"   && CrSigCdmp (impressoras cadastradas)

    *==========================================================================
    * Cheque corrente - espelha 1:1 as colunas de SigCqChi (docs/schema.sql)
    * do registro selecionado na grade. Populado por CarregarDoCursor() e
    * usado por ObterChavePrimaria()/ExecutarExclusao() no cancelamento
    * fisico do cheque (Delete From SigCqChi Where cidchaves = ... do
    * cmdGok.Click legado).
    *==========================================================================
    this_cCidchaves   = ""      && PK Fortyus (cidchaves)
    this_cAgencias    = ""      && agencias char(4)
    this_cBancos      = ""      && bancos char(3)
    this_lCancelas    = .F.     && cancelas bit -> cheque CANCELADO (ncancelas no legado)
    this_cContas      = ""      && contas char(10)
    this_dDatas       = {}      && datas datetime NULL - emissao do cheque
    this_cDopes       = ""      && dopes char(20) - documento de origem
    this_lEmitidos    = .F.     && emitidos bit (nemitidos no legado)
    this_cEmps        = ""      && emps char(3)
    this_cGrupos      = ""      && grupos char(10) - grupo de contas do cheque
    this_cNcheques    = ""      && ncheques char(6) - numero do cheque
    this_cNcontas     = ""      && ncontas char(10) - conta corrente
    this_nNcopias     = 0       && ncopias numeric(6,0)
    this_nNemissoes   = 0       && nemissoes numeric(2,0)
    this_nNumes       = 0       && numes numeric(6,0) - numero do documento (Dopes/Numes)
    this_nValors      = 0       && valors numeric(11,2)
    this_dVencs       = {}      && vencs datetime NULL - vencimento
    this_cVersos      = ""      && versos text - texto do verso do cheque
    this_cEmpDopNums  = ""      && empdopnums char(29) - chave posicional Emps+Dopes+Str(Numes,6)
    this_cJustCanc    = ""      && justcanc text - justificativa do cancelamento (get_justificativa)
    this_nImpVersos   = 0       && impversos numeric(1,0)

    *==========================================================================
    * Init - Business Object sem tabela unica de persistencia CRUD; a tabela
    * fisica manipulada (Delete no cancelamento de cheque) eh SigCqChi, e a
    * chave primaria eh cidchaves (cidchaves char - PK Fortyus, ver INSERT
    * do legado / regra #22 do CLAUDE.md).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigCqChi")
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_dDataInicial = DATE()
            THIS.this_dDataFinal   = DATE()
            THIS.this_dAntDataInicial = {}
            THIS.this_dAntDataFinal   = {}
            THIS.this_cAntCodGrupo    = ""
            THIS.this_cAntDescGrupo   = ""
            THIS.this_cAntCodConta    = ""
            THIS.this_cAntDescConta   = ""

            THIS.this_lExcluirDocumento = fChecaAcesso("SIGPRCHR", "EXCLUIR")
            THIS.this_lExcluirCheque    = fChecaAcesso("SIGPRCHR", "EXCLUIRCHQ")
            THIS.this_lPrimeiraExibicao = .T.

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigCqChi (par_cAliasCursor
    * eh um cursor de UM cheque, populado por SQLEXEC com os nomes reais do
    * banco - docs/schema.sql) para as properties this_* do cheque corrente.
    * Usado pelo Form ao selecionar uma linha da grade, antes de acionar
    * Excluir() (cancelamento fisico do cheque ja cancelado).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCidchaves  = TratarNulo(cidchaves, "")
            THIS.this_cAgencias   = TratarNulo(agencias, "")
            THIS.this_cBancos     = TratarNulo(bancos, "")
            THIS.this_lCancelas   = ConverterParaLogico(cancelas)
            THIS.this_cContas     = TratarNulo(contas, "")
            THIS.this_dDatas      = ConverterParaData(datas)
            THIS.this_cDopes      = TratarNulo(dopes, "")
            THIS.this_lEmitidos   = ConverterParaLogico(emitidos)
            THIS.this_cEmps       = TratarNulo(emps, "")
            THIS.this_cFavorecido = TratarNulo(favos, "")
            THIS.this_cGrupos     = TratarNulo(grupos, "")
            THIS.this_cNcheques   = TratarNulo(ncheques, "")
            THIS.this_cNcontas    = TratarNulo(ncontas, "")
            THIS.this_nNcopias    = NVL(ncopias, 0)
            THIS.this_nNemissoes  = NVL(nemissoes, 0)
            THIS.this_nNumes      = NVL(numes, 0)
            THIS.this_nValors     = NVL(valors, 0)
            THIS.this_dVencs      = ConverterParaData(vencs)
            THIS.this_cVersos     = TratarNulo(versos, "")
            THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
            THIS.this_cJustCanc   = TratarNulo(justcanc, "")
            THIS.this_nImpVersos  = NVL(impversos, 0)

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCheques - Consulta os cheques do periodo/grupo/conta filtrados e
    * devolve o resultado em par_cCursorDestino (cursor TEMPORARIO - quem
    * transfere para o cursor da grade eh o Form, via ZAP + APPEND FROM DBF,
    * para nao destruir o binding do Grid).
    *
    * Transcricao 1:1 do SELECT do "PROCEDURE montachq" legado (duas variantes
    * conforme a Conta estar preenchida ou nao):
    *
    *   Sem conta : ...Where a.datas Between ?lcDtInicial And ?lcDtFinal And
    *                    [a.Grupos = '<grupo>' And]
    *                    a.Contas in (Select Distinct ContaDs From SigOpFp
    *                                  Where EmiChqs = 1)
    *   Com conta : ...Where datas Between ... And [Grupos = ... And]
    *                    Contas = '<conta>'
    *
    * O filtro de Grupo eh OPCIONAL no legado (Iif(Empty(lcCdGrupo), [], ...)) -
    * a ausencia dele NAO eh esquecimento de migracao.
    *
    * Os "Iif(Emitidos,1,0) as NEmitidos" / "Iif(Cancelas,1,0) as NCancelas"
    * que o legado faz no SELECT VFP sao resolvidos aqui no SQL Server (CASE
    * WHEN), porque emitidos/cancelas sao colunas "bit" (docs/schema.sql) e
    * chegam ao VFP ora como Logico ora como Numerico conforme o driver
    * (CLAUDE.md regra #13) - converter no servidor elimina a ambiguidade e
    * entrega numeric(1,0), que eh o tipo das colunas nemitidos/ncancelas do
    * cursor da grade.
    *
    * A ordenacao final eh a do SELECT VFP do legado (Order By Bancos,
    * Agencias, NContas, NCheques), que sobrepoe o Order By da query remota.
    *==========================================================================
    PROCEDURE CarregarCheques(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_cCursor, loc_cSQL, loc_nResultado
        LOCAL loc_dIni, loc_dFim, loc_tIni, loc_tFim, loc_cGrupo, loc_cConta
        LOCAL loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cCursor = IIF(VARTYPE(par_cCursorDestino) = "C" AND ;
                !EMPTY(par_cCursorDestino), par_cCursorDestino, "cursor_4c_ChequesTmp")

            *-- ConverterParaData: o filtro pode chegar como DATE (TextBox com
            *-- .Value = {}) ou como DATETIME (coluna do banco) - CLAUDE.md #16.
            loc_dIni = ConverterParaData(THIS.this_dDataInicial)
            loc_dFim = ConverterParaData(THIS.this_dDataFinal)

            IF EMPTY(loc_dIni) OR EMPTY(loc_dFim)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo n" + CHR(227) + ;
                    "o informado para a consulta de cheques."
            ELSE
                *-- fDtoSQL(Dt_Inicial.Value) / fDtoSQL(Dt_Final.Value,'23:59:59')
                loc_tIni = DTOT(loc_dIni)
                loc_tFim = DATETIME(YEAR(loc_dFim), MONTH(loc_dFim), DAY(loc_dFim), 23, 59, 59)

                loc_cGrupo = ALLTRIM(THIS.this_cCodGrupo)
                loc_cConta = ALLTRIM(THIS.this_cCodConta)

                loc_cSQL = "SELECT a.emps, a.dopes, a.numes, a.datas, a.bancos, " + ;
                           "a.agencias, a.ncontas, a.ncheques, a.contas, a.valors, " + ;
                           "a.favos, a.ncopias, a.nemissoes, a.cidchaves, a.justcanc, " + ;
                           "CASE WHEN a.emitidos = 1 THEN 1 ELSE 0 END AS nemitidos, " + ;
                           "CASE WHEN a.cancelas = 1 THEN 1 ELSE 0 END AS ncancelas, " + ;
                           "0 AS nmarca1s " + ;
                           "FROM SigCqChi a " + ;
                           "WHERE a.datas BETWEEN " + FormatarDataSQL(loc_tIni) + ;
                               " AND " + FormatarDataSQL(loc_tFim) + " "

                IF !EMPTY(loc_cGrupo)
                    loc_cSQL = loc_cSQL + "AND a.grupos = " + EscaparSQL(loc_cGrupo) + " "
                ENDIF

                IF EMPTY(loc_cConta)
                    loc_cSQL = loc_cSQL + ;
                        "AND a.contas IN (SELECT DISTINCT ContaDs FROM SigOpFp " + ;
                        "WHERE EmiChqs = 1) "
                ELSE
                    loc_cSQL = loc_cSQL + "AND a.contas = " + EscaparSQL(loc_cConta) + " "
                ENDIF

                loc_cSQL = loc_cSQL + ;
                    "ORDER BY a.bancos, a.agencias, a.ncontas, a.ncheques"

                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

                *-- Legado: If (SqlExecute(...) < 1) -> falha de conexao
                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Falha ao selecionar os cheques do " + ;
                        "per" + CHR(237) + "odo." + CHR(13) + CapturarErroSQL()
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - PK Fortyus de SigCqChi eh cidchaves (char, ver
    * regra #22 do CLAUDE.md). Usado por RegistrarAuditoria() (BusinessBase)
    * no INSERT INTO LogAuditoria apos ExecutarExclusao().
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDPROC

    *==========================================================================
    * Inserir()/Atualizar() - o legado (SIGPRCHR.SCX) NAO grava nem altera
    * registros em SigCqChi: os cheques sao emitidos por outro modulo do
    * sistema (emissao de cheques). Esta tela apenas consulta cheques por
    * Grupo/Conta/Periodo (comportamento.json: Select .../CsSigCqChi, sem
    * nenhum Insert/Update em SigCqChi) e cancela fisicamente um documento
    * ja cancelado (Delete From SigCqChi Where cidchaves = ... no
    * cmdGok.Click legado, replicado em ExecutarExclusao() abaixo). O
    * comportamento padrao herdado de BusinessBase (recusar Inserir/
    * Atualizar) ja eh o correto para esta entidade neste form.
    *==========================================================================

    *==========================================================================
    * AntesDeExcluir - Replica o guard do legado antes do MessageBox de
    * confirmacao e do Delete: "If CsSigCqChi.ncancelas = 1 And
    * ThisForm.ExcluirCheque" (cmdGok.Click). So permite excluir um cheque
    * JA CANCELADO e quando o usuario tem o acesso ExcluirCheque
    * (fChecaAcesso('SIGPRCHR','EXCLUIRCHQ') calculado no Init).
    *==========================================================================
    PROTECTED PROCEDURE AntesDeExcluir()
        IF !THIS.this_lCancelas
            THIS.this_cMensagemErro = "Somente cheques CANCELADOS podem ser exclu" + CHR(237) + "dos."
            RETURN .F.
        ENDIF

        IF !THIS.this_lExcluirCheque
            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o possui acesso para excluir cheque cancelado."
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Delete From SigCqChi Where cidchaves = ... do
    * cmdGok.Click legado (exclusao fisica do cheque cancelado). Conexao
    * nasce em modo transacional manual (Transactions=2) - commit/rollback
    * explicitos.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidchaves)
            THIS.this_cMensagemErro = "Cheque sem chave prim" + CHR(225) + "ria (cidchaves) para exclus" + CHR(227) + "o."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigCqChi WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("EXCLUSAO")
                loc_lSucesso = .T.
            ELSE
                SQLROLLBACK(gnConnHandle)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o cheque cancelado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            SQLROLLBACK(gnConnHandle)
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MarcarChequesComoEmitidos - Marca como emitidos (SQL Server + cursor de
    * trabalho) todos os cheques com nmarca1s = 1 no cursor informado.
    * Replica o "Update SigCqChi Set emitidos = 1 Where cidchaves = ..." dos
    * fluxos de impressao do legado (cmdImpchq/cmdchmat), um UPDATE por
    * cheque (cada cheque tem cidchaves proprio). Conexao em modo
    * transacional manual (Transactions=2) - commit/rollback explicitos.
    *==========================================================================
    PROCEDURE MarcarChequesComoEmitidos(par_cCursor)
        LOCAL loc_lSucesso, loc_lErro, loc_cSQL, loc_nResultado, loc_nRecno, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCursor) = "C" AND USED(par_cCursor)
            loc_lErro  = .F.
            loc_nRecno = RECNO(par_cCursor)

            TRY
                SELECT (par_cCursor)
                SCAN FOR nmarca1s = 1
                    loc_cSQL = "UPDATE SigCqChi SET emitidos = 1 WHERE cidchaves = " + EscaparSQL(cidchaves)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        loc_lErro = .T.
                        EXIT
                    ENDIF

                    REPLACE nemitidos WITH 1, nmarca1s WITH 0
                    SELECT (par_cCursor)
                ENDSCAN

                IF loc_lErro
                    SQLROLLBACK(gnConnHandle)
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel marcar o(s) cheque(s) como emitido(s):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SQLCOMMIT(gnConnHandle)
                    loc_lSucesso = .T.
                ENDIF
            CATCH TO loc_oErro
                SQLROLLBACK(gnConnHandle)
                MsgErro(loc_oErro.Message, "Erro")
            ENDTRY

            IF USED(par_cCursor) AND BETWEEN(loc_nRecno, 1, RECCOUNT(par_cCursor))
                SELECT (par_cCursor)
                GOTO loc_nRecno
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MarcarChequesComoEmitidosPorFaixa - Variante de MarcarChequesComoEmitidos
    * para o painel de impressao manual (cnt_4c_Impchmat/impchmat do legado):
    * marca como emitidos TODOS os cheques do cursor de trabalho que casam
    * com Banco + faixa de numero de cheque (nao pelo cidchaves de cada
    * linha marcada). Replica "Update SigCqChi Set emitidos = 1 Where bancos
    * = ... And ncheques = ..." do cmdimpri.Click legado, um UPDATE por
    * cheque da faixa. Conexao em modo transacional manual - commit/rollback
    * explicitos.
    *==========================================================================
    PROCEDURE MarcarChequesComoEmitidosPorFaixa(par_cCursor, par_cBanco, par_cChequeIni, par_cChequeFin)
        LOCAL loc_lSucesso, loc_lErro, loc_cSQL, loc_nResultado, loc_nRecno, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCursor) = "C" AND USED(par_cCursor)
            loc_lErro  = .F.
            loc_nRecno = RECNO(par_cCursor)

            TRY
                SELECT (par_cCursor)
                SCAN FOR bancos = par_cBanco AND BETWEEN(ncheques, par_cChequeIni, par_cChequeFin) AND ncancelas = 0
                    loc_cSQL = "UPDATE SigCqChi SET emitidos = 1 WHERE bancos = " + EscaparSQL(bancos) + ;
                        " AND ncheques = " + EscaparSQL(ncheques)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        loc_lErro = .T.
                        EXIT
                    ENDIF

                    REPLACE nemitidos WITH 1
                    SELECT (par_cCursor)
                ENDSCAN

                IF loc_lErro
                    SQLROLLBACK(gnConnHandle)
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel marcar o(s) cheque(s) como emitido(s):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SQLCOMMIT(gnConnHandle)
                    loc_lSucesso = .T.
                ENDIF
            CATCH TO loc_oErro
                SQLROLLBACK(gnConnHandle)
                MsgErro(loc_oErro.Message, "Erro")
            ENDTRY

            IF USED(par_cCursor) AND BETWEEN(loc_nRecno, 1, RECCOUNT(par_cCursor))
                SELECT (par_cCursor)
                GOTO loc_nRecno
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - Reseta o cheque corrente (chamado por BusinessBase.Excluir
    * apos ExecutarExclusao() ter sucesso, e por NovoRegistro/CancelarEdicao).
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidchaves  = ""
        THIS.this_cAgencias   = ""
        THIS.this_cBancos     = ""
        THIS.this_lCancelas   = .F.
        THIS.this_cContas     = ""
        THIS.this_dDatas      = {}
        THIS.this_cDopes      = ""
        THIS.this_lEmitidos   = .F.
        THIS.this_cEmps       = ""
        THIS.this_cFavorecido = ""
        THIS.this_cGrupos     = ""
        THIS.this_cNcheques   = ""
        THIS.this_cNcontas    = ""
        THIS.this_nNcopias    = 0
        THIS.this_nNemissoes  = 0
        THIS.this_nNumes      = 0
        THIS.this_nValors     = 0
        THIS.this_dVencs      = {}
        THIS.this_cVersos     = ""
        THIS.this_cEmpDopNums = ""
        THIS.this_cJustCanc   = ""
        THIS.this_nImpVersos  = 0
    ENDPROC

ENDDEFINE

