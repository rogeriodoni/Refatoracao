# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 9/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-10-25 18:33:52] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-25 18:33:52] [INFO] Config FPW: (nao fornecido)
[2026-10-25 18:33:52] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-25 18:33:52] [INFO] Timeout: 300 segundos
[2026-10-25 18:33:52] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ycatt4vf.prg
[2026-10-25 18:33:52] [INFO] Conteudo do wrapper:
[2026-10-25 18:33:52] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpChi', 'C:\4c\tasks\task698\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpChi', 'C:\4c\tasks\task698\logs\06_testForm.log'
QUIT

[2026-10-25 18:33:52] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ycatt4vf.prg
[2026-10-25 18:33:52] [INFO] VFP output esperado em: C:\4c\tasks\task698\vfp_output.txt
[2026-10-25 18:33:52] [INFO] Executando Visual FoxPro 9...
[2026-10-25 18:33:52] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ycatt4vf.prg
[2026-10-25 18:33:52] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ycatt4vf.prg
[2026-10-25 18:33:52] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpChi
Inicio: 25/10/2026 18:33:52

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 25/10/2026 18:37:22
Duracao: 210 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-25 18:37:22] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-25 18:37:22] [INFO] VFP9 finalizado em 210.2224734 segundos
[2026-10-25 18:37:22] [INFO] Exit Code: 
[2026-10-25 18:37:22] [INFO] 
[2026-10-25 18:37:22] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-25 18:37:22] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ycatt4vf.prg
[2026-10-25 18:37:22] [INFO] 
[2026-10-25 18:37:22] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-25 18:37:22] [INFO] * Auto-generated wrapper for parameters
[2026-10-25 18:37:22] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-25 18:37:22] [INFO] * Parameters: 'FormSigOpChi', 'C:\4c\tasks\task698\logs\06_testForm.log'
[2026-10-25 18:37:22] [INFO] 
[2026-10-25 18:37:22] [INFO] * Anti-dialog protections for unattended execution
[2026-10-25 18:37:22] [INFO] SET SAFETY OFF
[2026-10-25 18:37:22] [INFO] SET RESOURCE OFF
[2026-10-25 18:37:22] [INFO] SET TALK OFF
[2026-10-25 18:37:22] [INFO] SET NOTIFY OFF
[2026-10-25 18:37:22] [INFO] SYS(2335, 0)
[2026-10-25 18:37:22] [INFO] 
[2026-10-25 18:37:22] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpChi', 'C:\4c\tasks\task698\logs\06_testForm.log'
[2026-10-25 18:37:22] [INFO] QUIT
[2026-10-25 18:37:22] [INFO] 
[2026-10-25 18:37:22] [INFO] === Fim do Wrapper.prg ===
[2026-10-25 18:37:22] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpChi.prg):
*==============================================================================
* FormSigOpChi.prg - Historico de Cheques
* Migrado de SigOpChi.SCX
* Herda de: FormBase
* Business Object: SigOpChiBO (SigChe / SigCqChm / SigCdCli)
*
* Form OPERACIONAL (consulta/historico). Pagina1 = Filtro (conta de origem,
* conta do emitente ou filtro aberto por periodo); Pagina2 = Historico
* (grades de cheque, movimentacao e prorrogacoes, followup e navegacao para
* os formularios de detalhe SigOpChr/SigOpChb/SigOpChp/SigOpFlp/SigOpChc).
*
* Fase 3: estrutura base (heranca, Init, InicializarForm, PageFrame,
* containers de cabecalho vazios, labels de cabecalho, TornarControlesVisiveis,
* Destroy).
* Fase 4: grades do Historico (grd_4c_Cheque/Movimenta/Prorrog), botoes CRUD/
* acao (cmg_4c_Botoes/cmg_4c_Saida), CarregarDados (SqlDados legado) e
* AlternarPagina.
* Fase 5: campos restantes da Page2/Historico - Cnt_periodo (filtro de
* vencimento), Cnt_Followup (ultimo followup, so-leitura) e o container
* Emitente (filtro por conta do emitente, com os tres lookups de SigCdCli -
* mesmo padrao do container Origem da Page1). Os 8 botoes de cmg_4c_Botoes
* (Relatorio/Busca/Prorroga/FollowUp/Carteira/Protocolo/Movimento/FollowUp
* Cheque) e o AfterRowColChange de grd_4c_Cheque ficam para a fase de acoes.
*==============================================================================

DEFINE CLASS FormSigOpChi AS FormBase

    *-- Propriedades visuais (PILAR 1 - copiadas do SCX original SIGOPCHI)
    Width        = 1000
    Height       = 600
    DataSession  = 2
    BorderStyle  = 2
    AutoCenter   = .T.
    Caption      = "Hist" + CHR(243) + "rico de Cheques"
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    KeyPreview   = .T.
    TitleBar     = 0
    ZoomBox      = .T.
    Themes       = .F.
    ShowWindow   = 1
    WindowType   = 1

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Espelho do "ThisForm.Acesso" do legado - .T. quando pcAcesso eh
    *-- 'TOTAL' ou 'CARTEIRA' (acesso irrestrito as contas do historico)
    this_lAcesso = .T.

    *-- Nome do form chamador (2o parametro do Init legado: lcNomeFrm1)
    this_cNomeFrmChamador = ""

    *-- Parametros de pre-filtro recebidos quando o form eh aberto a partir
    *-- de um cheque especifico (pBancos/pAgencias/pNContas/pNCheques/pVencs)
    this_cParamBancos    = ""
    this_cParamAgencias  = ""
    this_cParamNContas   = ""
    this_cParamNCheques  = ""
    this_dParamVencs     = {}

    *-- Espelho do "ThisForm.Filtrado" do legado - .T. quando o Processar foi
    *-- acionado com uma conta de origem preenchida (restringe o historico)
    this_lFiltrado = .F.

    *-- Guarda de reentrancia dos lookups de conta/cpf/nome da Page1 (Filtro) -
    *-- os pickers sao modais e disparam o proprio KeyPress de novo ao ganhar foco
    this_lEmLookupOrigem = .F.

    *-- Guarda de reentrancia dos lookups de conta/cpf/nome do container
    *-- Emitente (Page2/Historico) - mesma razao de this_lEmLookupOrigem
    this_lEmLookupEmitente = .F.

    *--------------------------------------------------------------------------
    * Init - Equivalente a:
    * LParameters pAcesso, lcNomeFrm1, pBancos, pAgencias, pNContas, pNCheques, pVencs
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cAcesso, par_cNomeFrm1, par_cBancos, par_cAgencias, ;
                   par_cNContas, par_cNCheques, par_dVencs)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpChiBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigOpChiBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "FormSigOpChi.Init")
            ELSE
                IF VARTYPE(par_cAcesso) = "C" AND !EMPTY(par_cAcesso)
                    THIS.this_oBusinessObject.this_cAcesso = par_cAcesso
                ENDIF
                THIS.this_lAcesso = INLIST(THIS.this_oBusinessObject.this_cAcesso, "TOTAL", "CARTEIRA")
                THIS.this_oBusinessObject.this_lAcesso = THIS.this_lAcesso

                IF VARTYPE(par_cNomeFrm1) = "C"
                    THIS.this_cNomeFrmChamador = par_cNomeFrm1
                ENDIF
                IF VARTYPE(par_cBancos) = "C"
                    THIS.this_cParamBancos = ALLTRIM(par_cBancos)
                ENDIF
                IF VARTYPE(par_cAgencias) = "C"
                    THIS.this_cParamAgencias = ALLTRIM(par_cAgencias)
                ENDIF
                IF VARTYPE(par_cNContas) = "C"
                    THIS.this_cParamNContas = ALLTRIM(par_cNContas)
                ENDIF
                IF VARTYPE(par_cNCheques) = "C"
                    THIS.this_cParamNCheques = ALLTRIM(par_cNCheques)
                ENDIF
                IF VARTYPE(par_dVencs) = "D" OR VARTYPE(par_dVencs) = "T"
                    THIS.this_dParamVencs = ConverterParaData(par_dVencs)
                ENDIF

                *-- Periodo de vencimento default. Transcrito do Init legado:
                *--   .Cnt_periodo.Dt_inicial.Value = IIF(pcAcesso='CARTEIRA', pcVencs, Date())
                *--   .Cnt_periodo.Dt_Final.Value   = IIF(pcAcesso='CARTEIRA', pcVencs,
                *--                                       CTOD('31/12/'+ALLTRIM(STR(YEAR(DATE())))))
                *-- No acesso CARTEIRA o periodo colapsa no vencimento do cheque
                *-- recebido, porque a consulta eh de UM cheque especifico.
                *-- Os TextBox Dt_inicial/Dt_final espelham estas duas
                *-- propriedades do BO, que sao a fonte unica do periodo.
                IF ALLTRIM(UPPER(THIS.this_oBusinessObject.this_cAcesso)) == "CARTEIRA" ;
                        AND !EMPTY(THIS.this_dParamVencs)
                    THIS.this_oBusinessObject.this_dDataInicial = THIS.this_dParamVencs
                    THIS.this_oBusinessObject.this_dDataFinal   = THIS.this_dParamVencs
                ELSE
                    THIS.this_oBusinessObject.this_dDataInicial = DATE()
                    THIS.this_oBusinessObject.this_dDataFinal   = ;
                        CTOD("31/12/" + ALLTRIM(STR(YEAR(DATE()))))
                ENDIF

                *-- DODEFAULT() dispara FormBase.Init() -> THIS.InicializarForm()
                *-- Tambem aciona SET DATE TO BRITISH + SET CENTURY ON (DataSession=2)
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPress - Transcricao literal do KeyPress legado (KeyPreview = .T.,
    * ja declarado nas propriedades do form): F3/F4/F5/F6/F7/F8/F9/F11 so
    * atuam na Pagina 2 (Historico) e delegam para os mesmos metodos dos
    * botoes de cmg_4c_Botoes. Os codigos negativos (-2..-8) sao os valores
    * que o VFP9 entrega em Form.KeyPress para F3..F9 quando KeyPreview esta
    * ligado; F11 chega como 133 (idem legado).
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nPagina
        loc_nPagina = THIS.pgf_4c_Paginas.ActivePage

        DO CASE
            CASE par_nKeyCode = -2 AND loc_nPagina = 2 && <F3> FollowUp Cheque
                NODEFAULT
                THIS.AcaoFollowUpChqClick()

            CASE par_nKeyCode = -3 AND loc_nPagina = 2 && <F4> Documento
                NODEFAULT
                THIS.AcaoDocumentoClick()

            CASE par_nKeyCode = -4 AND loc_nPagina = 2 && <F5> Procurar
                NODEFAULT
                THIS.AcaoProcurarClick()

            CASE par_nKeyCode = -5 AND loc_nPagina = 2 && <F6> Relatorio
                NODEFAULT
                THIS.AcaoRelatorioClick()

            CASE par_nKeyCode = -6 AND loc_nPagina = 2 && <F7> Prorrogar
                NODEFAULT
                THIS.AcaoProrrogaClick()

            CASE par_nKeyCode = -7 AND loc_nPagina = 2 && <F8> FollowUp Cliente
                NODEFAULT
                THIS.AcaoFollowUpClick()

            CASE par_nKeyCode = -8 AND loc_nPagina = 2 && <F9> Protocolo
                NODEFAULT
                THIS.AcaoProtocoloClick()

            CASE par_nKeyCode = 133 AND loc_nPagina = 2 && <F11> Carteira
                NODEFAULT
                THIS.AcaoCarteiraClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta a estrutura visual base do form
    * (chamado por FormBase.Init via DODEFAULT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarContainersBase()
            THIS.ConfigurarPaginaFiltro()
            THIS.ConfigurarPaginaHistorico()
            THIS.ConfigurarGradesHistorico()
            THIS.ConfigurarBotoesHistorico()
            THIS.ConfigurarCursorProtocolo()

            THIS.pgf_4c_Paginas.Visible = .T.

            THIS.TornarControlesVisiveis(THIS)

            *-- Espelha o BO na tela (periodo default resolvido no Init, campos
            *-- de Origem/Emitente e Caption) e aplica a cascata dos PROCEDURE
            *-- When do legado. TornarControlesVisiveis ja rodou, entao nenhum
            *-- Visible declarado aqui eh sobrescrito depois.
            THIS.BOParaForm()

            *-- Transcrito do Init legado: com acesso TOTAL/CARTEIRA a tela abre
            *-- direto no Historico e ja carrega os dados ("If ThisForm.Acesso
            *-- ... .ActivePage = 2 / ThisForm.SqlDados"); sem acesso irrestrito
            *-- abre no Filtro, exigindo que o usuario informe a conta
            *-- ("Else / ThisForm.Pagina.Filtro.Origem.Get_conta.Setfocus").
            *-- ActivePage eh trocada DEPOIS de TornarControlesVisiveis para que
            *-- as grades sejam repintadas com a pagina ja visivel.
            THIS.AlternarPagina(IIF(THIS.this_lAcesso, 2, 1))

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTituloCabecalho - Espelha THIS.Caption nos labels da faixa do
    * cabecalho (lbl_4c_Sombra/lbl_4c_Titulo) das DUAS paginas (regra #11).
    * Os labels sao criados ja com Caption = THIS.Caption (ConfigurarPagina
    * Filtro/ConfigurarPaginaHistorico), mas CmdOkClick/CarregarDados/
    * BOParaForm trocam THIS.Caption depois disso - sem este espelhamento a
    * faixa fica com o titulo antigo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarTituloCabecalho()
        LOCAL loc_oCab1, loc_oCab2

        IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Cabecalho", 5)
                loc_oCab1 = THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
                IF PEMSTATUS(loc_oCab1, "lbl_4c_Sombra", 5)
                    loc_oCab1.lbl_4c_Sombra.Caption = THIS.Caption
                ENDIF
                IF PEMSTATUS(loc_oCab1, "lbl_4c_Titulo", 5)
                    loc_oCab1.lbl_4c_Titulo.Caption = THIS.Caption
                ENDIF
            ENDIF

            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Cabecalho", 5)
                loc_oCab2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho
                IF PEMSTATUS(loc_oCab2, "lbl_4c_Sombra", 5)
                    loc_oCab2.lbl_4c_Sombra.Caption = THIS.Caption
                ENDIF
                IF PEMSTATUS(loc_oCab2, "lbl_4c_Titulo", 5)
                    loc_oCab2.lbl_4c_Titulo.Caption = THIS.Caption
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com Page1 (Filtro) e Page2 (Historico)
    * Tabs ocultas (Top=-29 / Tabs=.F.) - controles internos recebem a
    * compensacao +29 quando adicionados nas proximas fases
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            WITH THIS.pgf_4c_Paginas
                .Top         = -29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = THIS.Height + 29
                .PageCount   = 2
                .Tabs        = .F.
                .BorderWidth = 0

                .Page1.Caption = "Filtro"
                .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                .Page2.Caption = "Hist" + CHR(243) + "rico"
                .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                .Page2.Enabled = .F.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainersBase - Cria o container de cabecalho (faixa cinza)
    * em cada Page. E o PRIMEIRO AddObject de cada pagina, para que os
    * controles adicionados depois desenhem por cima dele.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainersBase()
        LOCAL loc_oPag1, loc_oPag2, loc_oErro
        TRY
            loc_oPag1 = THIS.pgf_4c_Paginas.Page1
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2

            loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPag1.cnt_4c_Cabecalho
                .Top         = 0 + 29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            loc_oPag2.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPag2.cnt_4c_Cabecalho
                .Top         = 0 + 29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarContainersBase")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaFiltro - Preenche o cabecalho da Page1 (Filtro) com
    * o titulo do formulario (lbl_4c_Sombra atras, lbl_4c_Titulo na frente)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltro()
        LOCAL loc_oCab, loc_oPag1, loc_oErro
        TRY
            loc_oPag1 = THIS.pgf_4c_Paginas.Page1
            loc_oCab  = loc_oPag1.cnt_4c_Cabecalho

            loc_oCab.AddObject("lbl_4c_Sombra", "Label")
            WITH loc_oCab.lbl_4c_Sombra
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .Alignment = 0
                .Caption   = THIS.Caption
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = THIS.Width - 20
                .ForeColor = RGB(0, 0, 0)
            ENDWITH

            loc_oCab.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oCab.lbl_4c_Titulo
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .Alignment = 0
                .Caption   = THIS.Caption
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = THIS.Width - 20
                .ForeColor = RGB(255, 255, 255)
            ENDWITH

            *-- Shape1 (decorativo, sem preenchimento nem borda no SCX legado;
            *-- BorderColor transcrito do dump, inerte com BorderStyle = 0)
            loc_oPag1.AddObject("shp_4c_Shape1", "Shape")
            WITH loc_oPag1.shp_4c_Shape1
                .Top         = 10 + 29
                .Left        = 816
                .Width       = 173
                .Height      = 110
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
            ENDWITH

            THIS.ConfigurarOrigemFiltro(loc_oPag1)
            THIS.ConfigurarBotoesFiltro(loc_oPag1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarPaginaFiltro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarOrigemFiltro - Container "Origem" da Page1: conta, CPF/CNPJ e
    * nome do cliente de origem (ou filtro geral, via optFiltro), com os tres
    * lookups ligados por SigCdCli.Iclis/Rclis/Cpfs
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarOrigemFiltro(par_oPagina)
        LOCAL loc_oOrig, loc_oErro
        TRY
            par_oPagina.AddObject("cnt_4c_Origem", "Container")
            WITH par_oPagina.cnt_4c_Origem
                .Top         = 277 + 29
                .Left        = 230
                .Width       = 539
                .Height      = 50
                .BackStyle   = 0
                .BorderWidth = 1
                .BorderColor = RGB(90, 90, 90)
                .TabIndex    = 1
                .Visible     = .T.
            ENDWITH
            loc_oOrig = par_oPagina.cnt_4c_Origem

            loc_oOrig.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oOrig.lbl_4c_Label2
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontSize  = 8
                .Caption   = "Conta"
                .Left      = 5
                .Top       = 4
                .Width     = 60
                .Height    = 14
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 1
            ENDWITH

            loc_oOrig.AddObject("lbl_4c__CPF", "Label")
            WITH loc_oOrig.lbl_4c__CPF
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontSize  = 8
                .Caption   = "CPF / CNPJ"
                .Left      = 90
                .Top       = 4
                .Width     = 90
                .Height    = 14
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 3
            ENDWITH

            loc_oOrig.AddObject("lbl_4c__dConta", "Label")
            WITH loc_oOrig.lbl_4c__dConta
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontSize  = 8
                .Caption   = "Nome"
                .Left      = 243
                .Top       = 4
                .Width     = 60
                .Height    = 14
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 5
            ENDWITH

            loc_oOrig.AddObject("txt_4c__Conta", "TextBox")
            WITH loc_oOrig.txt_4c__Conta
                .Left          = 5
                .Top           = 18
                .Width         = 82
                .Height        = 21
                .MaxLength     = 10
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .TabIndex      = 2
            ENDWITH

            loc_oOrig.AddObject("txt_4c__Cpf", "TextBox")
            WITH loc_oOrig.txt_4c__Cpf
                .Left          = 90
                .Top           = 18
                .Width         = 150
                .Height        = 21
                .InputMask     = "XXXXXXXXXXXXXXXXXXXX"
                .MaxLength     = 20
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .TabIndex      = 4
            ENDWITH

            loc_oOrig.AddObject("txt_4c__DConta", "TextBox")
            WITH loc_oOrig.txt_4c__DConta
                .Left          = 243
                .Top           = 18
                .Width         = 290
                .Height        = 21
                .MaxLength     = 50
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .TabIndex      = 6
            ENDWITH

            loc_oOrig.AddObject("obj_4c_OptFiltro", "OptionGroup")
            WITH loc_oOrig.obj_4c_OptFiltro
                .ButtonCount = 2
                .Top         = -2
                .Left        = 282
                .Width       = 93
                .Height      = 19
                .BackStyle   = 0
                .Value       = 1
                .TabIndex    = 7
                WITH .Buttons(1)
                    .Caption   = "\<Lista"
                    .FontName        = "Comic Sans MS"
                    .FontSize  = 8
                    .Height    = 15
                    .Left      = 5
                    .Top       = 5
                    .Width     = 45
                    .Style     = 0
                    .BackStyle = 0
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "\<Filtro"
                    .FontName        = "Comic Sans MS"
                    .FontSize  = 8
                    .Height    = 15
                    .Left      = 48
                    .Top       = 5
                    .Width     = 45
                    .Style     = 0
                    .BackStyle = 0
                ENDWITH
            ENDWITH

            BINDEVENT(loc_oOrig.txt_4c__Conta,  "KeyPress", THIS, "ValidarContaOrigem")
            BINDEVENT(loc_oOrig.txt_4c__Cpf,     "KeyPress", THIS, "ValidarCpfOrigem")
            BINDEVENT(loc_oOrig.txt_4c__DConta,  "KeyPress", THIS, "ValidarNomeOrigem")

            *-- Cascata dos PROCEDURE When do legado (exclusao mutua entre
            *-- Conta / CPF / Nome / optFiltro) - reaplicada a cada caractere.
            *-- O alvo eh AplicarDependenciaCampos (parametro ZERO) e nao
            *-- HabilitarCampos: InteractiveChange nao passa argumento e, em
            *-- VFP9, parametro nao passado chega como .F. logico, o que
            *-- deixaria a tela inteira somente-leitura
            BINDEVENT(loc_oOrig.txt_4c__Conta,  "InteractiveChange", THIS, "AplicarDependenciaCampos")
            BINDEVENT(loc_oOrig.txt_4c__Cpf,    "InteractiveChange", THIS, "AplicarDependenciaCampos")
            BINDEVENT(loc_oOrig.txt_4c__DConta, "InteractiveChange", THIS, "AplicarDependenciaCampos")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarOrigemFiltro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesFiltro - Botoes "Processar" e "Encerrar" da Page1,
    * standalone (sem CommandGroup), posicoes do SCX legado (Top+29)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesFiltro(par_oPagina)
        LOCAL loc_oErro
        TRY
            par_oPagina.AddObject("cmd_4c_Ok", "CommandButton")
            WITH par_oPagina.cmd_4c_Ok
                .Top             = 4 + 29
                .Left            = 849
                .Width           = 75
                .Height          = 75
                .Caption         = "Processar"
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
            ENDWITH

            par_oPagina.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH par_oPagina.cmd_4c_Cancelar
                .Top             = 4 + 29
                .Left            = 924
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
            ENDWITH

            BINDEVENT(par_oPagina.cmd_4c_Ok,        "Click", THIS, "CmdOkClick")
            BINDEVENT(par_oPagina.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarBotoesFiltro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaHistorico - Preenche o cabecalho da Page2 (Historico)
    * com o titulo do formulario (mesmo padrao da Page1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaHistorico()
        LOCAL loc_oCab, loc_oPag2, loc_oErro
        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2
            loc_oCab  = loc_oPag2.cnt_4c_Cabecalho

            loc_oCab.AddObject("lbl_4c_Sombra", "Label")
            WITH loc_oCab.lbl_4c_Sombra
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .Alignment = 0
                .Caption   = THIS.Caption
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = THIS.Width - 20
                .ForeColor = RGB(0, 0, 0)
            ENDWITH

            loc_oCab.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oCab.lbl_4c_Titulo
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .Alignment = 0
                .Caption   = THIS.Caption
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = THIS.Width - 20
                .ForeColor = RGB(255, 255, 255)
            ENDWITH

            THIS.ConfigurarPeriodoHistorico(loc_oPag2)
            THIS.ConfigurarFollowupHistorico(loc_oPag2)
            THIS.ConfigurarEmitenteHistorico(loc_oPag2)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarPaginaHistorico")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPeriodoHistorico - Container "Cnt_periodo" da Page2: filtro de
    * vencimento (Dt_inicial/Dt_final), usado pelos ramos TOTAL/CARTEIRA de
    * CarregarDados. Valores iniciais espelham THIS.this_oBusinessObject, ja
    * definidos no Init (DATE()/31-12 ou o vencimento unico da CARTEIRA).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPeriodoHistorico(par_oPagina)
        LOCAL loc_oPer, loc_oErro
        TRY
            par_oPagina.AddObject("cnt_4c__periodo", "Container")
            WITH par_oPagina.cnt_4c__periodo
                .Top           = 8 + 29
                .Left          = 647
                .Width         = 230
                .Height        = 67
                .BackStyle     = 1
                .BackColor     = RGB(255, 255, 255)
                .BorderWidth   = 1
                .BorderColor   = RGB(90, 90, 90)
                .SpecialEffect = 1
                .Visible     = .T.
            ENDWITH
            loc_oPer = par_oPagina.cnt_4c__periodo

            *-- Label1: o dump declara AutoSize = .T., mas AutoSize eh no-op em
            *-- Label criado por AddObject (regra #23) - fica .F. com a
            *-- Width/Height que o Form Designer calculou (123x15)
            loc_oPer.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPer.lbl_4c_Label1
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Filtro Por Vencimento"
                .Left      = 20
                .Top       = 7
                .Width     = 123
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 1
            ENDWITH

            loc_oPer.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPer.lbl_4c_Label2
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "at" + CHR(233)
                .Left      = 105
                .Top       = 33
                .Width     = 20
                .Height    = 14
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 12
            ENDWITH

            loc_oPer.AddObject("txt_4c_Dt_inicial", "TextBox")
            WITH loc_oPer.txt_4c_Dt_inicial
                .Alignment     = 3
                .Value         = ConverterParaData(THIS.this_oBusinessObject.this_dDataInicial)
                .Left          = 20
                .Top           = 29
                .Width         = 80
                .Height        = 21
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .TabIndex      = 6
            ENDWITH

            loc_oPer.AddObject("txt_4c_Dt_final", "TextBox")
            WITH loc_oPer.txt_4c_Dt_final
                .Alignment     = 3
                .Value         = ConverterParaData(THIS.this_oBusinessObject.this_dDataFinal)
                .Left          = 129
                .Top           = 29
                .Width         = 80
                .Height        = 21
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .TabIndex      = 7
            ENDWITH

            BINDEVENT(loc_oPer.txt_4c_Dt_inicial, "KeyPress", THIS, "ValidarDataInicial")
            BINDEVENT(loc_oPer.txt_4c_Dt_final,   "KeyPress", THIS, "ValidarDataFinal")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarPeriodoHistorico")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDataInicial - KeyPress em txt_4c_Dt_inicial (equivalente ao
    * Valid do Dt_inicial legado): se a data inicial ficar depois da final,
    * a final eh empurrada para a inicial.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDataInicial(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPer, loc_dVal

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPer = THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo
        loc_dVal = ConverterParaData(loc_oPer.txt_4c_Dt_inicial.Value)

        *-- Legado: If This.Value > This.Parent.Dt_final.Value / This.Parent.Dt_Final.Value = This.Value
        IF loc_dVal > ConverterParaData(loc_oPer.txt_4c_Dt_final.Value)
            loc_oPer.txt_4c_Dt_final.Value = loc_dVal
            loc_oPer.txt_4c_Dt_final.Refresh
        ENDIF

        THIS.this_oBusinessObject.this_dDataInicial = loc_dVal
        THIS.this_oBusinessObject.this_dDataFinal   = ConverterParaData(loc_oPer.txt_4c_Dt_final.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDataFinal - KeyPress em txt_4c_Dt_final (equivalente ao Valid do
    * Dt_final legado): se a data final ficar antes da inicial, a inicial eh
    * empurrada para a final, e o historico eh recarregado (legado: ThisForm.
    * SqlDados). LostFocus do legado (SetFocus na grade) nao tem equivalente
    * aqui - navegacao automatica de foco apos ENTER/TAB fica a cargo do VFP.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPer, loc_dVal

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPer = THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo
        loc_dVal = ConverterParaData(loc_oPer.txt_4c_Dt_final.Value)

        *-- Legado: If This.Value < This.Parent.Dt_Inicial.Value / This.Parent.Dt_Inicial.Value = This.Value
        IF loc_dVal < ConverterParaData(loc_oPer.txt_4c_Dt_inicial.Value)
            loc_oPer.txt_4c_Dt_inicial.Value = loc_dVal
            loc_oPer.txt_4c_Dt_inicial.Refresh
        ENDIF

        THIS.this_oBusinessObject.this_dDataInicial = ConverterParaData(loc_oPer.txt_4c_Dt_inicial.Value)
        THIS.this_oBusinessObject.this_dDataFinal   = loc_dVal

        *-- Legado: ThisForm.SqlDados. Pelo FUNIL (FormParaBO -> CarregarDados
        *-- -> Repintar): popular o cursor nao repinta a grade sozinho
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFollowupHistorico - Container "Cnt_Followup" da Page2: exibe
    * o ultimo followup do cheque corrente (so-leitura; AfterRowColChange de
    * grd_4c_Cheque alimenta this.Value - fase de acoes).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFollowupHistorico(par_oPagina)
        LOCAL loc_oFup, loc_oErro
        TRY
            par_oPagina.AddObject("cnt_4c__Followup", "Container")
            WITH par_oPagina.cnt_4c__Followup
                .Top           = 514 + 29
                .Left          = 10
                .Width         = 558
                .Height        = 27
                .BackStyle     = 1
                .BackColor     = RGB(255, 255, 255)
                .BorderWidth   = 1
                .BorderColor   = RGB(90, 90, 90)
                .SpecialEffect = 1
                .Visible     = .T.
            ENDWITH
            loc_oFup = par_oPagina.cnt_4c__Followup

            *-- Label1: dump declara AutoSize = .T. (no-op em AddObject, regra
            *-- #23) - fica .F. com a Width/Height do SCX (44x15)
            loc_oFup.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oFup.lbl_4c_Label1
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Followup"
                .Left      = 8
                .Top       = 6
                .Width     = 44
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            loc_oFup.AddObject("txt_4c_UltFollowup", "TextBox")
            WITH loc_oFup.txt_4c_UltFollowup
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Height        = 20
                .Left          = 62
                .Top           = 3
                .Width         = 492
                .Margin        = 1
                .SpecialEffect = 1
                .BorderColor   = RGB(100, 100, 100)
                .ReadOnly      = .T.
                .TabStop       = .F.
                .Value         = ""
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarFollowupHistorico")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEmitenteHistorico - Container "Emitente" da Page2: filtro por
    * conta do emitente do cheque (usado so no ramo TOTAL de CarregarDados -
    * a.ConOrigs/a.Contat). Mesmo padrao de tres campos + tres lookups do
    * container Origem da Page1 (regra: so SigCdCli.Iclis/Rclis/Cpfs, sem
    * optFiltro - o dump nao tem OptionGroup aqui).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEmitenteHistorico(par_oPagina)
        LOCAL loc_oEmi, loc_oErro
        TRY
            par_oPagina.AddObject("cnt_4c_Emitente", "Container")
            WITH par_oPagina.cnt_4c_Emitente
                .Top         = 543 + 29
                .Left        = 10
                .Width       = 558
                .Height      = 53
                .BackStyle   = 0
                .BorderWidth = 1
                .BorderColor = RGB(90, 90, 90)
                .TabIndex    = 1
                .Visible     = .T.
            ENDWITH
            loc_oEmi = par_oPagina.cnt_4c_Emitente

            *-- Label1: dump declara AutoSize = .T. (no-op em AddObject, regra
            *-- #23) - fica .F. com a Width/Height do SCX (137x15)
            loc_oEmi.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oEmi.lbl_4c_Label1
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Filtro por Conta do Emitente"
                .Left      = 5
                .Top       = 0
                .Width     = 137
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            loc_oEmi.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oEmi.lbl_4c_Label2
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Conta"
                .Left      = 5
                .Top       = 14
                .Width     = 60
                .Height    = 14
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 1
            ENDWITH

            loc_oEmi.AddObject("lbl_4c__CPF", "Label")
            WITH loc_oEmi.lbl_4c__CPF
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "CPF / CNPJ"
                .Left      = 90
                .Top       = 14
                .Width     = 90
                .Height    = 14
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 3
            ENDWITH

            loc_oEmi.AddObject("lbl_4c__dConta", "Label")
            WITH loc_oEmi.lbl_4c__dConta
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Nome"
                .Left      = 243
                .Top       = 14
                .Width     = 60
                .Height    = 14
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 5
            ENDWITH

            loc_oEmi.AddObject("txt_4c__Conta", "TextBox")
            WITH loc_oEmi.txt_4c__Conta
                .Left          = 5
                .Top           = 28
                .Width         = 82
                .Height        = 21
                .MaxLength     = 10
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .TabIndex      = 2
            ENDWITH

            loc_oEmi.AddObject("txt_4c__Cpf", "TextBox")
            WITH loc_oEmi.txt_4c__Cpf
                .Left          = 90
                .Top           = 28
                .Width         = 150
                .Height        = 21
                .InputMask     = "XXXXXXXXXXXXXXXXXXXX"
                .MaxLength     = 20
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .TabIndex      = 4
            ENDWITH

            loc_oEmi.AddObject("txt_4c__DConta", "TextBox")
            WITH loc_oEmi.txt_4c__DConta
                .Left          = 243
                .Top           = 28
                .Width         = 311
                .Height        = 23
                .MaxLength     = 50
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .TabIndex      = 6
            ENDWITH

            BINDEVENT(loc_oEmi.txt_4c__Conta,  "KeyPress", THIS, "ValidarContaEmitente")
            BINDEVENT(loc_oEmi.txt_4c__Cpf,    "KeyPress", THIS, "ValidarCpfEmitente")
            BINDEVENT(loc_oEmi.txt_4c__DConta, "KeyPress", THIS, "ValidarNomeEmitente")

            *-- Cascata dos PROCEDURE When do legado neste container (Conta ->
            *-- CPF -> Nome). Mesmo motivo do alvo parametro-zero descrito em
            *-- ConfigurarOrigemFiltro
            BINDEVENT(loc_oEmi.txt_4c__Conta,  "InteractiveChange", THIS, "AplicarDependenciaCampos")
            BINDEVENT(loc_oEmi.txt_4c__Cpf,    "InteractiveChange", THIS, "AplicarDependenciaCampos")
            BINDEVENT(loc_oEmi.txt_4c__DConta, "InteractiveChange", THIS, "AplicarDependenciaCampos")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarEmitenteHistorico")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarAcessoConta - espelha o "If !fAcessoContas(Usuar, '', 'C'|'D',
    * ...)" que o Valid dos TRES campos de conta do legado executa em TODO
    * caminho de resolucao (dump SigOpChi_form_codigo_fonte.txt linhas 2238,
    * 2317, 2398 e 2422 no container Origem; 3302, 3382 e 3463 no Emitente).
    *
    * Chamada SEM os objetos TextBox (pSt1/pSt2): nessa forma o fAcessoContas
    * portado (utils\functions.prg) entra no ramo "Busca sem UI (apenas
    * verifica acesso)" e so devolve .T./.F., sem o auto-load do primeiro
    * match parcial que a regra do projeto proibe em lookup (Erro16). A conta
    * chega aqui JA resolvida, por isso o tipo eh sempre 'C' (codigo) - o ramo
    * 'D' do legado apenas resolve a descricao para o mesmo codigo antes de
    * checar.
    *
    * Sem conexao (modo de teste / ValidarUIFidelity) nao ha o que consultar:
    * devolve .T. para nao bloquear a tela - o legado sempre roda conectado.
    * Em excecao de infraestrutura tambem devolve .T., mas EXIBINDO o erro:
    * "Acesso Negado" por falha transitoria de SQL seria mensagem mentirosa.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarAcessoConta(par_cConta)
        LOCAL loc_lAcesso, loc_cUsuario, loc_oErro

        loc_lAcesso = .T.

        IF VARTYPE(par_cConta) = "C" AND !EMPTY(ALLTRIM(par_cConta)) AND ;
                TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
            TRY
                loc_lAcesso = fAcessoContas(loc_cUsuario, "", "C", ALLTRIM(par_cConta))
            CATCH TO loc_oErro
                MsgErro("Falha ao verificar acesso " + CHR(224) + " conta:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
                loc_lAcesso = .T.
            ENDTRY
        ENDIF

        RETURN loc_lAcesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * PreencherEmitente / LimparEmitente - espelham no container Emitente e no
    * BO (this_cContaEmitente/this_cDContaEmitente/this_cCpfEmitente - fonte
    * unica lida por CarregarDados no ramo TOTAL) o registro de SigCdCli
    * resolvido por qualquer um dos tres lookups
    *--------------------------------------------------------------------------
    PROCEDURE PreencherEmitente(par_cConta, par_cDConta, par_cCpf)
        LOCAL loc_oEmi, loc_cConta, loc_cDConta, loc_cCpf

        loc_cConta  = par_cConta
        loc_cDConta = par_cDConta
        loc_cCpf    = par_cCpf

        *-- Legado: acesso negado exibe o aviso e limpa os TRES campos
        *-- (get_Conta.Valid linha 3302: MessageBox('Acesso Negado!!!') +
        *-- .get_conta/.get_dconta/.get_cpf = '' + Return 0). O EMPTY espelha
        *-- o "If !Empty(This.Value)" que cerca a checagem no legado - limpar
        *-- os campos nao se re-verifica.
        IF !EMPTY(loc_cConta) AND !THIS.VerificarAcessoConta(loc_cConta)
            MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_cConta  = ""
            loc_cDConta = ""
            loc_cCpf    = ""
        ENDIF

        loc_oEmi = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
        loc_oEmi.txt_4c__Conta.Value  = loc_cConta
        loc_oEmi.txt_4c__DConta.Value = loc_cDConta
        loc_oEmi.txt_4c__Cpf.Value    = loc_cCpf
        loc_oEmi.txt_4c__Conta.Refresh
        loc_oEmi.txt_4c__DConta.Refresh
        loc_oEmi.txt_4c__Cpf.Refresh

        THIS.this_oBusinessObject.this_cContaEmitente  = loc_cConta
        THIS.this_oBusinessObject.this_cDContaEmitente = loc_cDConta
        THIS.this_oBusinessObject.this_cCpfEmitente    = loc_cCpf

        *-- A cascata do When (regra de dependencia entre os tres campos)
        *-- depende dos valores que acabaram de ser escritos
        THIS.HabilitarCampos(.T.)
    ENDPROC

    PROCEDURE LimparEmitente()
        THIS.PreencherEmitente("", "", "")
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaEmitente - KeyPress em txt_4c__Conta do Emitente (Valid do
    * get_Conta legado). F4 abre o picker direto; Enter/Tab faz o SELECT
    * exato por Iclis e, sem match, abre o picker com o valor digitado como
    * prefixo. A checagem de acesso do legado roda no funil PreencherEmitente
    * (ver VerificarAcessoConta), que cobre os tres campos do container.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaEmitente(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult, loc_oEmi, loc_oErro

        IF par_nKeyCode = 115
            THIS.AbrirBuscaContaEmitente()
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oEmi = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
        loc_cVal = ALLTRIM(loc_oEmi.txt_4c__Conta.Value)
        IF EMPTY(loc_cVal)
            THIS.PreencherEmitente("", "", "")
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmitenteVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmitenteVal") AND !EOF("cursor_4c_EmitenteVal")
                THIS.PreencherEmitente(ALLTRIM(cursor_4c_EmitenteVal.Iclis), ;
                    ALLTRIM(cursor_4c_EmitenteVal.Rclis), ALLTRIM(cursor_4c_EmitenteVal.Cpfs))
            ELSE
                THIS.AbrirBuscaContaEmitente()
            ENDIF
            IF USED("cursor_4c_EmitenteVal")
                USE IN cursor_4c_EmitenteVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaContaEmitente - picker por Iclis/Rclis em SigCdCli (Pattern A),
    * filtrado pelo prefixo ja digitado em txt_4c__Conta (ou lista completa se
    * vazio). Mesmo padrao de AbrirBuscaContaOrigem.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaContaEmitente()
        LOCAL loc_oEmi, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
              loc_cCpf, loc_oErro

        IF THIS.this_lEmLookupEmitente
            RETURN
        ENDIF
        THIS.this_lEmLookupEmitente = .T.

        loc_oEmi   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
        loc_cValor = ALLTRIM(loc_oEmi.txt_4c__Conta.Value)

        TRY
            IF USED("cursor_4c_BuscaEmitente")
                USE IN cursor_4c_BuscaEmitente
            ENDIF

            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis"
            ELSE
                loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli " + ;
                           "WHERE Iclis LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Iclis"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmitente")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmitente")
                    USE IN cursor_4c_BuscaEmitente
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaEmitente")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0
                MsgAviso("Nenhuma conta encontrada.", "Contas")
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_BuscaEmitente", "Cods", "Descs", ;
                        "Sele" + CHR(231) + CHR(227) + "o de Conta")
                    IF loc_oBusca.Mostrar()
                        loc_cCpf = ""
                        IF USED("cursor_4c_BuscaEmitente")
                            loc_cCpf = ALLTRIM(cursor_4c_BuscaEmitente.Cpfs)
                        ENDIF
                        THIS.PreencherEmitente(loc_oBusca.cCodigoSelecionado, ;
                            loc_oBusca.cDescricaoSelecionada, loc_cCpf)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmitente")
            USE IN cursor_4c_BuscaEmitente
        ENDIF
        THIS.this_lEmLookupEmitente = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCpfEmitente - KeyPress em txt_4c__Cpf do Emitente (Valid do
    * get_Cpf legado). Mesma montagem de mascara e validacao de digito
    * verificador (ValidarCPF/ValidarCNPJ) do container Origem.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCpfEmitente(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cDigitos, loc_cFormatado, loc_nResult, ;
              loc_oEmi, loc_oErro

        IF par_nKeyCode = 115
            THIS.AbrirBuscaCpfEmitente()
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oEmi = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
        loc_cVal = ALLTRIM(loc_oEmi.txt_4c__Cpf.Value)
        IF EMPTY(loc_cVal)
            loc_oEmi.txt_4c__DConta.Value = ""
            loc_oEmi.txt_4c__DConta.Refresh
            RETURN
        ENDIF

        loc_cDigitos = STRTRAN(STRTRAN(STRTRAN(loc_cVal, ".", ""), "-", ""), "/", "")

        IF LEN(loc_cDigitos) != 14
            loc_cFormatado = TRANSFORM(loc_cDigitos, "@R 999.999.999-99")
        ELSE
            loc_cFormatado = TRANSFORM(loc_cDigitos, "@R 99.999.999/9999-99")
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Cpfs = " + EscaparSQL(loc_cFormatado), ;
                "cursor_4c_EmitenteVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmitenteVal") AND !EOF("cursor_4c_EmitenteVal")
                THIS.PreencherEmitente(ALLTRIM(cursor_4c_EmitenteVal.Iclis), ;
                    ALLTRIM(cursor_4c_EmitenteVal.Rclis), ALLTRIM(cursor_4c_EmitenteVal.Cpfs))
            ELSE
                THIS.AbrirBuscaCpfEmitente()
            ENDIF
            IF USED("cursor_4c_EmitenteVal")
                USE IN cursor_4c_EmitenteVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF LEN(loc_cVal) = 14
            IF !ValidarCPF(loc_cDigitos)
                MsgAviso("CPF Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        ELSE
            IF !ValidarCNPJ(loc_cDigitos)
                MsgAviso("CGC Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCpfEmitente - picker por Cpfs/Rclis em SigCdCli (Pattern A),
    * filtrado por "contem". Mesmo padrao de AbrirBuscaCpfOrigem.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCpfEmitente()
        LOCAL loc_oEmi, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
              loc_cConta, loc_oErro

        IF THIS.this_lEmLookupEmitente
            RETURN
        ENDIF
        THIS.this_lEmLookupEmitente = .T.

        loc_oEmi   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
        loc_cValor = ALLTRIM(loc_oEmi.txt_4c__Cpf.Value)

        TRY
            IF USED("cursor_4c_BuscaEmitente")
                USE IN cursor_4c_BuscaEmitente
            ENDIF

            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs"
            ELSE
                loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli " + ;
                           "WHERE Cpfs LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
                           " ORDER BY Cpfs"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmitente")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmitente")
                    USE IN cursor_4c_BuscaEmitente
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs", "cursor_4c_BuscaEmitente")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0
                MsgAviso("Nenhum cliente encontrado.", "Clientes")
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_BuscaEmitente", "Cods", "Descs", ;
                        "Sele" + CHR(231) + CHR(227) + "o de Cliente")
                    IF loc_oBusca.Mostrar()
                        loc_cConta = ""
                        IF USED("cursor_4c_BuscaEmitente")
                            loc_cConta = ALLTRIM(cursor_4c_BuscaEmitente.Iclis)
                        ENDIF
                        THIS.PreencherEmitente(loc_cConta, loc_oBusca.cDescricaoSelecionada, ;
                            loc_oBusca.cCodigoSelecionado)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmitente")
            USE IN cursor_4c_BuscaEmitente
        ENDIF
        THIS.this_lEmLookupEmitente = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNomeEmitente - KeyPress em txt_4c__DConta do Emitente (Valid do
    * get_DConta legado). Mesmo padrao de ValidarNomeOrigem.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNomeEmitente(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult, loc_oEmi, loc_oErro

        IF par_nKeyCode = 115
            THIS.AbrirBuscaNomeEmitente()
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oEmi = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
        loc_cVal = ALLTRIM(loc_oEmi.txt_4c__DConta.Value)
        IF EMPTY(loc_cVal)
            THIS.PreencherEmitente("", "", "")
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE RTRIM(Rclis) = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmitenteVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmitenteVal") AND !EOF("cursor_4c_EmitenteVal")
                THIS.PreencherEmitente(ALLTRIM(cursor_4c_EmitenteVal.Iclis), ;
                    ALLTRIM(cursor_4c_EmitenteVal.Rclis), ALLTRIM(cursor_4c_EmitenteVal.Cpfs))
            ELSE
                THIS.AbrirBuscaNomeEmitente()
            ENDIF
            IF USED("cursor_4c_EmitenteVal")
                USE IN cursor_4c_EmitenteVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaNomeEmitente - picker por Rclis/Iclis em SigCdCli (Pattern A),
    * filtrado por "contem". Mesmo padrao de AbrirBuscaNomeOrigem.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaNomeEmitente()
        LOCAL loc_oEmi, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
              loc_cCpf, loc_oErro

        IF THIS.this_lEmLookupEmitente
            RETURN
        ENDIF
        THIS.this_lEmLookupEmitente = .T.

        loc_oEmi   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
        loc_cValor = ALLTRIM(loc_oEmi.txt_4c__DConta.Value)

        TRY
            IF USED("cursor_4c_BuscaEmitente")
                USE IN cursor_4c_BuscaEmitente
            ENDIF

            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis"
            ELSE
                loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli " + ;
                           "WHERE RTRIM(Rclis) LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
                           " ORDER BY Rclis"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmitente")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmitente")
                    USE IN cursor_4c_BuscaEmitente
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaEmitente")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0
                MsgAviso("Nenhum cliente encontrado.", "Clientes")
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_BuscaEmitente", "Cods", "Descs", ;
                        "Sele" + CHR(231) + CHR(227) + "o de Cliente")
                    IF loc_oBusca.Mostrar()
                        loc_cCpf = ""
                        IF USED("cursor_4c_BuscaEmitente")
                            loc_cCpf = ALLTRIM(cursor_4c_BuscaEmitente.Cpfs)
                        ENDIF
                        THIS.PreencherEmitente(loc_oBusca.cCodigoSelecionado, ;
                            loc_oBusca.cDescricaoSelecionada, loc_cCpf)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmitente")
            USE IN cursor_4c_BuscaEmitente
        ENDIF
        THIS.this_lEmLookupEmitente = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * PreencherOrigem / LimparOrigem - espelham nos tres campos do container
    * Origem o registro de SigCdCli resolvido por qualquer um dos lookups
    * (conta, CPF/CNPJ ou nome)
    *--------------------------------------------------------------------------
    PROCEDURE PreencherOrigem(par_cConta, par_cDConta, par_cCpf)
        LOCAL loc_oOrig, loc_cConta, loc_cDConta, loc_cCpf

        loc_cConta  = par_cConta
        loc_cDConta = par_cDConta
        loc_cCpf    = par_cCpf

        *-- Legado: acesso negado exibe o aviso e limpa os TRES campos
        *-- (get_Conta.Valid linha 2238 / get_DConta.Valid linhas 2398 e 2422:
        *-- MessageBox('Acesso Negado!!!') + os tres .Value = '' + Return 0).
        IF !EMPTY(loc_cConta) AND !THIS.VerificarAcessoConta(loc_cConta)
            MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_cConta  = ""
            loc_cDConta = ""
            loc_cCpf    = ""
        ENDIF

        loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
        loc_oOrig.txt_4c__Conta.Value  = loc_cConta
        loc_oOrig.txt_4c__DConta.Value = loc_cDConta
        loc_oOrig.txt_4c__Cpf.Value    = loc_cCpf
        loc_oOrig.txt_4c__Conta.Refresh
        loc_oOrig.txt_4c__DConta.Refresh
        loc_oOrig.txt_4c__Cpf.Refresh

        *-- Espelha no BO (fonte unica lida por CarregarDados) e reaplica a
        *-- cascata do When, que depende destes tres valores
        THIS.this_oBusinessObject.this_cContaOrigem  = loc_cConta
        THIS.this_oBusinessObject.this_cDContaOrigem = loc_cDConta
        THIS.this_oBusinessObject.this_cCpfOrigem    = loc_cCpf
        THIS.this_lFiltrado                          = !EMPTY(ALLTRIM(loc_cConta))
        THIS.this_oBusinessObject.this_lFiltrado     = THIS.this_lFiltrado

        THIS.HabilitarCampos(.T.)
    ENDPROC

    PROCEDURE LimparOrigem()
        THIS.PreencherOrigem("", "", "")
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaOrigem - KeyPress em txt_4c__Conta (equivalente ao Valid do
    * get_Conta legado). F4 abre o picker direto; Enter/Tab faz o SELECT exato
    * por Iclis e, sem match, abre o picker com o valor digitado como prefixo.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaOrigem(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult, loc_oOrig, loc_oErro

        IF par_nKeyCode = 115
            THIS.AbrirBuscaContaOrigem()
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
        loc_cVal  = ALLTRIM(loc_oOrig.txt_4c__Conta.Value)
        IF EMPTY(loc_cVal)
            loc_oOrig.txt_4c__DConta.Value = ""
            loc_oOrig.txt_4c__Cpf.Value    = ""
            loc_oOrig.txt_4c__DConta.Refresh
            loc_oOrig.txt_4c__Cpf.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_OrigemVal")
            IF loc_nResult > 0 AND USED("cursor_4c_OrigemVal") AND !EOF("cursor_4c_OrigemVal")
                THIS.PreencherOrigem(ALLTRIM(cursor_4c_OrigemVal.Iclis), ;
                    ALLTRIM(cursor_4c_OrigemVal.Rclis), ALLTRIM(cursor_4c_OrigemVal.Cpfs))
            ELSE
                THIS.AbrirBuscaContaOrigem()
            ENDIF
            IF USED("cursor_4c_OrigemVal")
                USE IN cursor_4c_OrigemVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaContaOrigem - picker por Iclis/Rclis em SigCdCli (Pattern A:
    * SQL no caller + CREATEOBJECT sem parametros + DefinirCursor + Mostrar),
    * filtrado pelo prefixo ja digitado em txt_4c__Conta (ou lista completa
    * se vazio). Cpfs eh lido do cursor apos a selecao, pois DefinirCursor/
    * Mostrar so devolvem codigo+descricao.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaContaOrigem()
        LOCAL loc_oOrig, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
              loc_cCpf, loc_oErro

        IF THIS.this_lEmLookupOrigem
            RETURN
        ENDIF
        THIS.this_lEmLookupOrigem = .T.

        loc_oOrig  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
        loc_cValor = ALLTRIM(loc_oOrig.txt_4c__Conta.Value)

        TRY
            IF USED("cursor_4c_BuscaOrigem")
                USE IN cursor_4c_BuscaOrigem
            ENDIF

            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis"
            ELSE
                loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli " + ;
                           "WHERE Iclis LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Iclis"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOrigem")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaOrigem")
                    USE IN cursor_4c_BuscaOrigem
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaOrigem")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0
                MsgAviso("Nenhuma conta encontrada.", "Contas")
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_BuscaOrigem", "Cods", "Descs", ;
                        "Sele" + CHR(231) + CHR(227) + "o de Conta")
                    IF loc_oBusca.Mostrar()
                        loc_cCpf = ""
                        IF USED("cursor_4c_BuscaOrigem")
                            loc_cCpf = ALLTRIM(cursor_4c_BuscaOrigem.Cpfs)
                        ENDIF
                        THIS.PreencherOrigem(loc_oBusca.cCodigoSelecionado, ;
                            loc_oBusca.cDescricaoSelecionada, loc_cCpf)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaOrigem")
            USE IN cursor_4c_BuscaOrigem
        ENDIF
        THIS.this_lEmLookupOrigem = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCpfOrigem - KeyPress em txt_4c__Cpf (equivalente ao Valid do
    * get_Cpf legado). Monta o CPF/CNPJ formatado (com pontuacao, igual ao
    * valor gravado em SigCdCli.Cpfs), faz o SELECT exato e, sem match, abre
    * o picker; ao final valida o digito verificador com ValidarCPF/ValidarCNPJ
    * (regra #13 - delegar ao validador novo, nao ao wrapper do legado).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCpfOrigem(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cDigitos, loc_cFormatado, loc_nResult, ;
              loc_oOrig, loc_oErro

        IF par_nKeyCode = 115
            THIS.AbrirBuscaCpfOrigem()
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
        loc_cVal  = ALLTRIM(loc_oOrig.txt_4c__Cpf.Value)
        IF EMPTY(loc_cVal)
            loc_oOrig.txt_4c__DConta.Value = ""
            loc_oOrig.txt_4c__DConta.Refresh
            RETURN
        ENDIF

        loc_cDigitos = STRTRAN(STRTRAN(STRTRAN(loc_cVal, ".", ""), "-", ""), "/", "")

        *-- Igual ao legado: a mascara usada para montar o valor de BUSCA
        *-- (Cpfs = formatado) depende do tamanho dos DIGITOS (sem pontuacao);
        *-- a validacao do digito verificador, mais abaixo, usa o tamanho do
        *-- valor DIGITADO (com pontuacao, se houver) - sao criterios distintos
        *-- no proprio SIGOPCHI.SCX e foram transcritos tal como estao la.
        IF LEN(loc_cDigitos) != 14
            loc_cFormatado = TRANSFORM(loc_cDigitos, "@R 999.999.999-99")
        ELSE
            loc_cFormatado = TRANSFORM(loc_cDigitos, "@R 99.999.999/9999-99")
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Cpfs = " + EscaparSQL(loc_cFormatado), ;
                "cursor_4c_OrigemVal")
            IF loc_nResult > 0 AND USED("cursor_4c_OrigemVal") AND !EOF("cursor_4c_OrigemVal")
                THIS.PreencherOrigem(ALLTRIM(cursor_4c_OrigemVal.Iclis), ;
                    ALLTRIM(cursor_4c_OrigemVal.Rclis), ALLTRIM(cursor_4c_OrigemVal.Cpfs))
            ELSE
                THIS.AbrirBuscaCpfOrigem()
            ENDIF
            IF USED("cursor_4c_OrigemVal")
                USE IN cursor_4c_OrigemVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF LEN(loc_cVal) = 14
            IF !ValidarCPF(loc_cDigitos)
                MsgAviso("CPF Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        ELSE
            IF !ValidarCNPJ(loc_cDigitos)
                MsgAviso("CGC Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCpfOrigem - picker por Cpfs/Rclis em SigCdCli (Pattern A),
    * filtrado por "contem" (igual ao Like '%valor%' do legado). Iclis eh
    * lido do cursor apos a selecao.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCpfOrigem()
        LOCAL loc_oOrig, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
              loc_cConta, loc_oErro

        IF THIS.this_lEmLookupOrigem
            RETURN
        ENDIF
        THIS.this_lEmLookupOrigem = .T.

        loc_oOrig  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
        loc_cValor = ALLTRIM(loc_oOrig.txt_4c__Cpf.Value)

        TRY
            IF USED("cursor_4c_BuscaOrigem")
                USE IN cursor_4c_BuscaOrigem
            ENDIF

            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs"
            ELSE
                loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli " + ;
                           "WHERE Cpfs LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
                           " ORDER BY Cpfs"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOrigem")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaOrigem")
                    USE IN cursor_4c_BuscaOrigem
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs", "cursor_4c_BuscaOrigem")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0
                MsgAviso("Nenhum cliente encontrado.", "Clientes")
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_BuscaOrigem", "Cods", "Descs", ;
                        "Sele" + CHR(231) + CHR(227) + "o de Cliente")
                    IF loc_oBusca.Mostrar()
                        loc_cConta = ""
                        IF USED("cursor_4c_BuscaOrigem")
                            loc_cConta = ALLTRIM(cursor_4c_BuscaOrigem.Iclis)
                        ENDIF
                        THIS.PreencherOrigem(loc_cConta, loc_oBusca.cDescricaoSelecionada, ;
                            loc_oBusca.cCodigoSelecionado)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaOrigem")
            USE IN cursor_4c_BuscaOrigem
        ENDIF
        THIS.this_lEmLookupOrigem = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNomeOrigem - KeyPress em txt_4c__DConta (equivalente ao Valid do
    * get_DConta legado). Faz o SELECT exato por Rclis e, sem match, abre o
    * picker com o valor digitado como filtro "contem".
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNomeOrigem(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult, loc_oOrig, loc_oErro

        IF par_nKeyCode = 115
            THIS.AbrirBuscaNomeOrigem()
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
        loc_cVal  = ALLTRIM(loc_oOrig.txt_4c__DConta.Value)
        IF EMPTY(loc_cVal)
            loc_oOrig.txt_4c__Conta.Value = ""
            loc_oOrig.txt_4c__Cpf.Value   = ""
            loc_oOrig.txt_4c__Conta.Refresh
            loc_oOrig.txt_4c__Cpf.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE RTRIM(Rclis) = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_OrigemVal")
            IF loc_nResult > 0 AND USED("cursor_4c_OrigemVal") AND !EOF("cursor_4c_OrigemVal")
                THIS.PreencherOrigem(ALLTRIM(cursor_4c_OrigemVal.Iclis), ;
                    ALLTRIM(cursor_4c_OrigemVal.Rclis), ALLTRIM(cursor_4c_OrigemVal.Cpfs))
            ELSE
                THIS.AbrirBuscaNomeOrigem()
            ENDIF
            IF USED("cursor_4c_OrigemVal")
                USE IN cursor_4c_OrigemVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaNomeOrigem - picker por Rclis/Iclis em SigCdCli (Pattern A).
    *
    * O modo de busca vem do OptionGroup optFiltro, que o legado consulta no
    * get_DConta.Valid ("If .optFiltro.Value = 2 && Procura Com Filtro"):
    *   Value = 2 (Filtro) -> Like '%valor%' (contem), igual ao legado
    *   Value = 1 (Lista)  -> Like 'valor%'  (comeca com)
    * O ramo Lista do legado chamava fAcessoContas(Usuar,'','D',...) passando
    * os TextBox, forma proibida no projeto porque auto-preenche o primeiro
    * match PARCIAL sem o usuario escolher (Erro16); o substituto canonico eh
    * o picker filtrado por prefixo, que eh o que se faz aqui.
    *
    * Cpfs eh lido do cursor apos a selecao.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaNomeOrigem()
        LOCAL loc_oOrig, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
              loc_cCpf, loc_cPadrao, loc_oErro

        IF THIS.this_lEmLookupOrigem
            RETURN
        ENDIF
        THIS.this_lEmLookupOrigem = .T.

        loc_oOrig  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
        loc_cValor = ALLTRIM(loc_oOrig.txt_4c__DConta.Value)

        TRY
            IF USED("cursor_4c_BuscaOrigem")
                USE IN cursor_4c_BuscaOrigem
            ENDIF

            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis"
            ELSE
                *-- optFiltro = 2 ("Filtro") procura por CONTEM; = 1 ("Lista")
                *-- procura por COMECA COM (ver cabecalho deste metodo)
                loc_cPadrao = IIF(loc_oOrig.obj_4c_OptFiltro.Value = 2, ;
                    "%" + loc_cValor + "%", loc_cValor + "%")
                loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli " + ;
                           "WHERE RTRIM(Rclis) LIKE " + EscaparSQL(loc_cPadrao) + ;
                           " ORDER BY Rclis"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOrigem")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaOrigem")
                    USE IN cursor_4c_BuscaOrigem
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaOrigem")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0
                MsgAviso("Nenhum cliente encontrado.", "Clientes")
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_BuscaOrigem", "Cods", "Descs", ;
                        "Sele" + CHR(231) + CHR(227) + "o de Cliente")
                    IF loc_oBusca.Mostrar()
                        loc_cCpf = ""
                        IF USED("cursor_4c_BuscaOrigem")
                            loc_cCpf = ALLTRIM(cursor_4c_BuscaOrigem.Cpfs)
                        ENDIF
                        THIS.PreencherOrigem(loc_oBusca.cCodigoSelecionado, ;
                            loc_oBusca.cDescricaoSelecionada, loc_cCpf)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaOrigem")
            USE IN cursor_4c_BuscaOrigem
        ENDIF
        THIS.this_lEmLookupOrigem = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdOkClick - "Processar" (equivalente ao Ok.Click legado). Valida a
    * conta quando o acesso eh restrito, monta o titulo com os dados de
    * origem resolvidos e troca para a Page2 (Historico).
    *--------------------------------------------------------------------------
    PROCEDURE CmdOkClick()
        LOCAL loc_oOrig, loc_cConta, loc_cDConta, loc_cCpf, loc_oErro

        loc_oOrig   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
        loc_cConta  = ALLTRIM(loc_oOrig.txt_4c__Conta.Value)

        IF !THIS.this_lAcesso AND EMPTY(loc_cConta)
            MsgAviso("Conta Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oOrig.txt_4c__Conta.SetFocus()
            RETURN
        ENDIF

        loc_cDConta = ALLTRIM(loc_oOrig.txt_4c__DConta.Value)
        loc_cCpf    = ALLTRIM(loc_oOrig.txt_4c__Cpf.Value)

        THIS.this_lFiltrado = !EMPTY(loc_cConta)

        THIS.Caption = "Hist" + CHR(243) + "rico de Cheques de: " + loc_cConta + " - " + ;
            loc_cDConta + " / " + loc_cCpf
        THIS.AtualizarTituloCabecalho()

        TRY
            *-- Legado: .Historico.Cnt_periodo.Visible = .f. - o historico por
            *-- conta (ramo 1 de CarregarDados) ignora o periodo de vencimento,
            *-- entao o filtro de data fica escondido neste caminho
            THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo.Visible = .F.

            *-- Troca de pagina, carga das grades e ajuste dos botoes do
            *-- Historico moram TODOS em AlternarPagina (funil unico, usado
            *-- tambem pelo Init e pelo Encerrar do Historico)
            THIS.AlternarPagina(2)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.CmdOkClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCancelarClick - "Encerrar" da Page1 (equivalente ao cancelar.Click
    * legado: ThisForm.Release). Alvo do BINDEVENT do botao; o corpo mora em
    * BtnCancelarClick (nome canonico), para existir UM so lugar que fecha.
    *--------------------------------------------------------------------------
    PROCEDURE CmdCancelarClick()
        THIS.BtnCancelarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradesHistorico - Cria as TRES grades da Page2 (Historico):
    *   grd_4c_Cheque    <- GradeCheque     (12 colunas, SigChe)
    *   grd_4c_Movimenta <- GradeMovimenta  ( 9 colunas, SigCqChm)
    *   grd_4c_Prorrog   <- GradeProrrog    ( 1 coluna,  SigChea)
    *
    * Geometria/fontes/larguras transcritas do dump do SCX legado. Top recebe
    * a compensacao +29 do pgf_4c_Paginas.Top = -29.
    * RecordSource/ControlSource NAO sao definidos aqui: os cursores so existem
    * depois de CarregarDados, e ControlSource de cursor inexistente derruba o
    * Init. O vinculo mora em VincularGrade*, chamado por CarregarDados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradesHistorico()
        LOCAL loc_oPagina, loc_oErro
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- GradeCheque: Top=124 Left=8 Width=981 Height=228 (dump legado)
            loc_oPagina.AddObject("grd_4c_Cheque", "Grid")
            WITH loc_oPagina.grd_4c_Cheque
                .Top                = 124 + 29
                .Left               = 8
                .Width              = 981
                .Height             = 228
                .HeaderHeight       = 0
                .ColumnCount        = 12
                .FontName           = "Tahoma"
                .FontSize           = 8
                .RowHeight          = 18
                .ScrollBars         = 2
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .ForeColor          = RGB(0, 0, 0)
                .BackColor          = RGB(255, 255, 255)
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .ReadOnly           = .T.
                .Themes             = .F.
                .Visible            = .T.
            ENDWITH
            THIS.FormatarGradeHistorico(loc_oPagina.grd_4c_Cheque, 12)

            *-- Colunas 1..10 travadas (Movable/Resizable = .F. no dump); as
            *-- colunas 11 e 12 nao declaram essas duas e ficam no default
            WITH loc_oPagina.grd_4c_Cheque
                .Column1.Alignment        = 2
                .Column1.Text1.Alignment  = 2
                .Column6.InputMask        = "999,999,999.99"
                .Column12.Alignment       = 2
                .Column12.Text1.Alignment = 2
                .Column11.Movable         = .T.
                .Column11.Resizable       = .T.
                .Column12.Movable         = .T.
                .Column12.Resizable       = .T.
            ENDWITH

            *-- AfterRowColChange e evento NATIVO do Grid - o objeto grd_4c_Cheque
            *-- persiste por toda a vida do form (so os Columns sao recriados a
            *-- cada ColumnCount em VincularGradeCheque), por isso o bind e feito
            *-- UMA vez aqui, nao a cada CarregarDados/VincularGradeCheque
            BINDEVENT(loc_oPagina.grd_4c_Cheque, "AfterRowColChange", THIS, "GradeChequeAfterRowColChange")

            *-- GradeMovimenta: Top=359 Left=8 Width=858 Height=147 (dump legado)
            loc_oPagina.AddObject("grd_4c_Movimenta", "Grid")
            WITH loc_oPagina.grd_4c_Movimenta
                .Top                = 359 + 29
                .Left               = 8
                .Width              = 858
                .Height             = 147
                .HeaderHeight       = 0
                .ColumnCount        = 9
                .FontName           = "Tahoma"
                .FontSize           = 8
                .RowHeight          = 18
                .ScrollBars         = 2
                .DeleteMark         = .F.
                *-- RecordMark = .T. eh declaracao EXPLICITA do SCX legado -
                *-- GradeMovimenta eh a unica das tres grades que exibe a barra
                *-- de marcacao de registro (PILAR 1)
                .RecordMark         = .T.
                .ForeColor          = RGB(0, 0, 0)
                .BackColor          = RGB(255, 255, 255)
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .ReadOnly           = .T.
                .Themes             = .F.
                .Visible            = .T.
            ENDWITH
            THIS.FormatarGradeHistorico(loc_oPagina.grd_4c_Movimenta, 9)

            *-- Conta/Origem alinhada a direita (Column5.Text1.Alignment = 3)
            loc_oPagina.grd_4c_Movimenta.Column5.Text1.Alignment = 3

            *-- GradeProrrog: Top=359 Left=875 Width=114 Height=146 (dump legado)
            loc_oPagina.AddObject("grd_4c_Prorrog", "Grid")
            WITH loc_oPagina.grd_4c_Prorrog
                .Top                = 359 + 29
                .Left               = 875
                .Width              = 114
                .Height             = 146
                .ColumnCount        = 1
                .FontName           = "Tahoma"
                .FontSize           = 8
                .HeaderHeight       = 16
                .RowHeight          = 18
                .ScrollBars         = 2
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .ForeColor          = RGB(0, 0, 0)
                .BackColor          = RGB(255, 255, 255)
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .ReadOnly           = .T.
                .Themes             = .F.
                .Visible            = .T.
            ENDWITH
            THIS.FormatarGradeHistorico(loc_oPagina.grd_4c_Prorrog, 1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarGradesHistorico")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGradeHistorico - Propriedades comuns a todas as colunas das
    * grades do Historico (dump legado: Column<N> em Verdana 8, Text1 com
    * BorderStyle = 0 / Margin = 0 / ForeColor 0,0,0 / BackColor 255,255,255 e
    * Header1 em Tahoma 8 centralizado). Chamado uma vez por grade.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGradeHistorico(par_oGrade, par_nColunas)
        LOCAL loc_nI, loc_oColuna
        WITH par_oGrade
            .FontName = "Verdana"
            .FontSize = 8
            .SetAll("Movable", .F., "Column")
            .SetAll("Resizable", .F., "Column")
        ENDWITH

        FOR loc_nI = 1 TO par_nColunas
            loc_oColuna = par_oGrade.Columns(loc_nI)
            WITH loc_oColuna.Header1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .ForeColor = RGB(0, 0, 0)
            ENDWITH
            WITH loc_oColuna.Text1
                .FontName    = "Verdana"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesHistorico - Cria as duas barras de botoes da Page2:
    *   cmg_4c_Botoes <- Grupo_op     (8 botoes de acao sobre o cheque)
    *   cmg_4c_Saida  <- Grupo_Saida  (Encerrar)
    *
    * Criadas DEPOIS do cnt_4c_Cabecalho (montado em ConfigurarContainersBase):
    * as duas barras ficam na area da faixa do cabecalho (Top = 29) e precisam
    * ser adicionadas por ultimo para desenhar POR CIMA dela.
    * Geometria, caption, picture e tooltip de cada botao vem do dump do SCX
    * legado; a numeracao Buttons(N) segue a numeracao Command<N> do dump.
    * O Click da barra de saida eh ligado aqui, porque o Sair.Click legado eh
    * autocontido. Os Click dos 8 botoes de Grupo_op abrem os formularios de
    * detalhe (SigOpChr/SigOpChb/SigOpChp/SigOpFlp/SigOpChc/SigCdPgr) e sao
    * ligados na fase de acoes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesHistorico()
        LOCAL loc_oPagina, loc_oErro
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- Grupo_op: o dump traz AutoSize = .T.; aqui fica .F. com a
            *-- Width/Height medidas do SCX (610x85), porque AutoSize em grupo
            *-- criado por AddObject deixa a caixa dependente da ordem de
            *-- atribuicao das propriedades dos membros
            loc_oPagina.AddObject("cmg_4c_Botoes", "CommandGroup")
            WITH loc_oPagina.cmg_4c_Botoes
                .AutoSize      = .F.
                .ButtonCount   = 8
                .Top           = 29
                .Left          = 30
                .Width         = 610
                .Height        = 85
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(90, 90, 90)
                .Themes        = .F.
                .Value         = 0
                .Visible       = .T.

                *-- Command1 = Relatorio
                WITH .Buttons(1)
                    .Top             = 5
                    .Left            = 230
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Relat" + CHR(243) + "rio"
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .ToolTipText     = "[F6] Relat" + CHR(243) + "rio"
                    .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                    .PicturePosition = 13
                ENDWITH

                *-- Command2 = Procurar ("Busca")
                WITH .Buttons(2)
                    .Top             = 5
                    .Left            = 155
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Busca"
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .ToolTipText     = "[F5] Busca Cheques"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                    .PicturePosition = 13
                ENDWITH

                *-- Command3 = Prorroga
                WITH .Buttons(3)
                    .Top             = 5
                    .Left            = 305
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Prorroga" + CHR(231) + CHR(227) + "o"
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .ToolTipText     = "[F7] Prorroga" + CHR(231) + CHR(227) + "o"
                    .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
                    .PicturePosition = 13
                    .WordWrap        = .T.
                ENDWITH

                *-- Command4 = FollowUp (clientes)
                WITH .Buttons(4)
                    .Top             = 5
                    .Left            = 380
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Followup Clientes"
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .ToolTipText     = "[F8] Followup Cliente"
                    .WordWrap        = .T.
                    .Picture         = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
                    .PicturePosition = 7
                ENDWITH

                *-- Command5 = Carteira
                WITH .Buttons(5)
                    .Top             = 5
                    .Left            = 530
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Carteira"
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .ToolTipText     = "[F11]Carteira"
                    .Picture         = gc_4c_CaminhoIcones + "geral_enderecos_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_enderecos_60.jpg"
                    .PicturePosition = 13
                ENDWITH

                *-- Command6 = Protocolo
                WITH .Buttons(6)
                    .Top             = 5
                    .Left            = 455
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Protocolo"
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .ToolTipText     = "[F9]Protocolo"
                    .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
                    .PicturePosition = 13
                ENDWITH

                *-- Command7 = Documento ("Movimento")
                WITH .Buttons(7)
                    .Top             = 5
                    .Left            = 80
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Movimento"
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .ToolTipText     = "[F4] Movimenta" + CHR(231) + CHR(227) + "o"
                    .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_arquivo_60.jpg"
                    .PicturePosition = 13
                ENDWITH

                *-- Command8 = followUpChq (followup do cheque)
                WITH .Buttons(8)
                    .Top             = 5
                    .Left            = 5
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Followup Cheques"
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .ToolTipText     = "[F3] FollowUp Cheques"
                    .WordWrap        = .T.
                    .Picture         = gc_4c_CaminhoIcones + "cheque.png"
                    .DisabledPicture = gc_4c_CaminhoIcones + "cheque.png"
                    .PicturePosition = 7
                ENDWITH
            ENDWITH

            *-- Fonte e cores dos 8 botoes (dump: Comic Sans MS 8 bold italic,
            *-- ForeColor 90,90,90 sobre BackColor branco, Themes = .F.).
            *-- CommandGroup NAO tem FontName nem ForeColor - so os membros tem
            THIS.FormatarBotoesHistorico(loc_oPagina.cmg_4c_Botoes, 8)

            *-- CommandGroup.Click dispara UMA vez por clique, com .Value = o
            *-- indice (1-based) do botao acionado - despachado em CmgBotoesClick.
            *-- O objeto cmg_4c_Botoes persiste (ButtonCount nao e reatribuido
            *-- depois de criado), por isso o bind e feito uma unica vez aqui
            BINDEVENT(loc_oPagina.cmg_4c_Botoes, "Click", THIS, "CmgBotoesClick")

            *-- Grupo_Saida: Left = 917 / Height = 85 com o botao Encerrar 75x75
            *-- em 5,5 - padrao canonico de saida do sistema novo, que coincide
            *-- com o dump legado (o dump traz Width = 85; canonico eh 90)
            loc_oPagina.AddObject("cmg_4c_Saida", "CommandGroup")
            WITH loc_oPagina.cmg_4c_Saida
                .AutoSize      = .F.
                .ButtonCount   = 1
                .Top           = 29
                .Left          = 917
                .Width         = 90
                .Height        = 85
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 189, 188)
                .Themes        = .F.
                .Value         = 1
                .Visible       = .T.

                WITH .Buttons(1)
                    .Top             = 5
                    .Left            = 5
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Encerrar"
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .Cancel          = .T.
                    .ToolTipText     = "<ESC> Sair"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .PicturePosition = 13
                ENDWITH
            ENDWITH

            THIS.FormatarBotoesHistorico(loc_oPagina.cmg_4c_Saida, 1)

            BINDEVENT(loc_oPagina.cmg_4c_Saida, "Click", THIS, "CmgSaidaClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarBotoesHistorico")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarBotoesHistorico - Fonte/cores comuns aos membros de um
    * CommandGroup da Page2, transcritas do dump (Comic Sans MS 8 bold italic,
    * ForeColor 90,90,90, BackColor branco, Themes = .F.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarBotoesHistorico(par_oGrupo, par_nBotoes)
        LOCAL loc_nI
        FOR loc_nI = 1 TO par_nBotoes
            WITH par_oGrupo.Buttons(loc_nI)
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .FontBold      = .T.
                .FontItalic    = .T.
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - FUNIL unico de troca entre Filtro (1) e Historico (2).
    * O legado repete o mesmo bloco em tres lugares:
    *   Init       -> .Historico.Enabled = .t. / .Filtro.Enabled = .f. / .ActivePage = 2
    *   Ok.Click   -> idem + SqlDados + Procurar.Enabled = !Filtrado
    *   Sair.Click -> .Filtro.Enabled = .t. / .Historico.Enabled = .f. / .ActivePage = 1
    * Quem desabilita a pagina na ida reabilita na volta - aqui.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oErro
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)

        TRY
            IF loc_nPagina = 2
                *-- Espelha "ThisForm.Filtrado = !Empty(Get_Conta.Value)"
                THIS.this_lFiltrado = ;
                    !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c__Conta.Value))
                THIS.this_oBusinessObject.this_lFiltrado = THIS.this_lFiltrado

                THIS.pgf_4c_Paginas.Page1.Enabled = .F.
                THIS.pgf_4c_Paginas.Page2.Enabled = .T.
                THIS.pgf_4c_Paginas.ActivePage    = 2

                *-- Funil do estado dos botoes/campos (repoe o modo e reabilita
                *-- o que o caminho de ida desabilitou) e funil de carga
                *-- (FormParaBO -> CarregarDados -> Repintar). O Repintar fica
                *-- DEPOIS do ActivePage: Refresh em pagina oculta nao pinta.
                THIS.AjustarBotoesPorModo()
                THIS.CarregarLista()
            ELSE
                THIS.pgf_4c_Paginas.Page2.Enabled = .F.
                THIS.pgf_4c_Paginas.Page1.Enabled = .T.
                THIS.pgf_4c_Paginas.ActivePage    = 1

                *-- Caminho de VOLTA: sem esta chamada os botoes/campos que o
                *-- modo Historico ajustou ficariam no estado anterior
                THIS.AjustarBotoesPorModo()

                IF THIS.Visible
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c__Conta.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AlternarPagina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesHistorico - Estado dos botoes de Grupo_op, transcrito do
    * legado:
    *   Init/Ok.Click -> .Grupo_op.Procurar.Enabled  = !ThisForm.Filtrado
    *   Init          -> .Grupo_op.Protocolo.Enabled = fChecaAcesso('SigCheHI','PROTOCOLO')
    * Buttons(2) = Procurar ("Busca"), Buttons(6) = Protocolo.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesHistorico()
        LOCAL loc_oGrupo, loc_oErro
        TRY
            loc_oGrupo = THIS.pgf_4c_Paginas.Page2.cmg_4c_Botoes
            loc_oGrupo.Buttons(2).Enabled = !THIS.this_lFiltrado
            loc_oGrupo.Buttons(6).Enabled = fChecaAcesso("SigCheHI", "PROTOCOLO")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AjustarBotoesHistorico")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmgSaidaClick - Encerrar do Historico. Transcrito de Sair.Click: sem
    * acesso irrestrito limpa os campos de Origem, volta ao Filtro e restaura
    * o Caption; com acesso irrestrito fecha o formulario.
    *--------------------------------------------------------------------------
    PROCEDURE CmgSaidaClick()
        IF !THIS.this_lAcesso
            *-- LimparCampos zera Origem/Emitente no BO, restaura o periodo
            *-- default e o Caption "Historico de Cheques", e espelha tudo na
            *-- tela via BOParaForm - os tres passos que o Sair.Click legado
            *-- faz a mao
            THIS.LimparCampos()
            THIS.AlternarPagina(1)
        ELSE
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharCursor - Fecha um alias com seguranca. TABLEREVERT EXIGE buffering
    * (sem ele dispara erro 1586), por isso o CURSORGETPROP antes; USE IN fecha
    * o alias mesmo com buffer sujo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FecharCursor(par_cAlias)
        IF VARTYPE(par_cAlias) = "C" AND !EMPTY(par_cAlias)
            IF USED(par_cAlias)
                IF CURSORGETPROP("Buffering", par_cAlias) > 1
                    TABLEREVERT(.T., par_cAlias)
                ENDIF
                USE IN (par_cAlias)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DesvincularGradesHistorico - Legado: as tres grades recebem
    * RecordSource = ' ' no inicio do SqlDados, antes de os cursores serem
    * refeitos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DesvincularGradesHistorico()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oPagina.grd_4c_Cheque.RecordSource    = ""
        loc_oPagina.grd_4c_Movimenta.RecordSource = ""
        loc_oPagina.grd_4c_Prorrog.RecordSource   = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * RepintarGradesHistorico - Legado: Go Top In <cursor> + <grade>.Refresh.
    * Popular o cursor NAO repinta a grade; e Refresh em pagina oculta nao
    * pinta, por isso AlternarPagina chama este metodo DEPOIS de trocar o
    * ActivePage.
    *--------------------------------------------------------------------------
    PROCEDURE RepintarGradesHistorico()
        LOCAL loc_oPagina, loc_cAliasAnt, loc_oErro
        TRY
            loc_cAliasAnt = ALIAS()
            loc_oPagina   = THIS.pgf_4c_Paginas.Page2

            IF USED("cursor_4c_Cheque")
                GO TOP IN cursor_4c_Cheque
            ENDIF
            IF USED("cursor_4c_Movimento")
                GO TOP IN cursor_4c_Movimento
            ENDIF
            IF USED("cursor_4c_Prorrog")
                GO TOP IN cursor_4c_Prorrog
            ENDIF

            loc_oPagina.grd_4c_Cheque.Refresh()
            loc_oPagina.grd_4c_Movimenta.Refresh()
            loc_oPagina.grd_4c_Prorrog.Refresh()

            IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
                SELECT (loc_cAliasAnt)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.RepintarGradesHistorico")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Transcricao do SqlDados legado.
    *
    * Monta os cursores do Historico e vincula as grades:
    *   cursor_4c_Cheque    (SigChe + coluna Tipo) -> grd_4c_Cheque
    *   cursor_4c_Movimento (SigCqChm)             -> grd_4c_Movimenta
    *   cursor_4c_Prorrog   (SigChea)              -> grd_4c_Prorrog
    *   cursor_4c_ChequeP   (auxiliar: Nums com historico em SigCheh - eh o
    *                        'LocalChP' do legado, que marca a coluna Tipo)
    * Os alias sao os declarados em SigOpChiBO.this_cCursor*.
    *
    * Cada SQLEXEC vai para cursor_4c_Temp e o alias definitivo eh recriado
    * READWRITE a partir dele: SQLEXEC direto sobre o alias ligado a uma grade
    * fecha e recria o alias, zerando o ColumnCount da grade.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_lModoTeste, loc_lOk, loc_oErro
        LOCAL loc_dIni, loc_dFim, loc_tIni, loc_tFim
        LOCAL loc_cConta, loc_cEmitente, loc_cFiltroEmi, loc_cNumCheque, loc_cAcesso
        LOCAL loc_cSQLChe, loc_cSQLChP, loc_cSQLMov, loc_cSQLPro
        loc_lSucesso = .F.

        loc_lModoTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                         (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        *-- RETURN sempre FORA de TRY/CATCH
        IF loc_lModoTeste OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_lOk = .T.

            *-- Legado: RecordSource = ' ' nas tres grades antes de refazer os
            *-- cursores
            THIS.DesvincularGradesHistorico()

            loc_dIni = ConverterParaData(THIS.this_oBusinessObject.this_dDataInicial)
            loc_dFim = ConverterParaData(THIS.this_oBusinessObject.this_dDataFinal)
            IF EMPTY(loc_dIni)
                loc_dIni = DATE()
            ENDIF
            IF EMPTY(loc_dFim)
                loc_dFim = CTOD("31/12/" + ALLTRIM(STR(YEAR(DATE()))))
            ENDIF
            *-- Legado: fDtoSQL(llDatai) e fDtoSQL(llDataf,'23:59:59')
            loc_tIni = DTOT(loc_dIni)
            loc_tFim = DTOT(loc_dFim) + 86399

            loc_cAcesso = ALLTRIM(UPPER(THIS.this_oBusinessObject.this_cAcesso))
            *-- FONTE UNICA: a conta de origem vem da property que FormParaBO
            *-- alimenta (CarregarLista chama FormParaBO antes deste metodo).
            *-- Ler o TextBox aqui criaria um segundo caminho que divergiria do
            *-- BO no primeiro ponto que mexesse so num dos dois.
            loc_cConta  = ALLTRIM(THIS.this_oBusinessObject.this_cContaOrigem)
            loc_cSQLChe = ""
            loc_cSQLChP = ""

            *-- Ramo 1 (legado: If !Empty(get_Conta.Value)) - historico COMPLETO
            *-- da conta de origem, SEM recorte de periodo
            IF !EMPTY(loc_cConta)
                loc_cSQLChe = "SELECT a.*, ' ' AS Tipo FROM SigChe a" + ;
                    " WHERE a.Iclis = " + EscaparSQL(loc_cConta) + ;
                    " ORDER BY a.Vencs"
                loc_cSQLChP = "SELECT DISTINCT b.Nums FROM SigChe a" + ;
                    " LEFT JOIN SigCheh b ON a.Nums = b.Nums" + ;
                    " WHERE a.Iclis = " + EscaparSQL(loc_cConta)
            ENDIF

            *-- Ramo 2 (legado: IF pcAcesso = 'TOTAL') - SOBREPOE o ramo 1:
            *-- recorta pelo periodo de vencimento e, havendo conta de emitente
            *-- informada, restringe a ConOrigs/Contat (legado: lcChecaC)
            IF loc_cAcesso == "TOTAL"
                loc_cEmitente  = ALLTRIM(THIS.this_oBusinessObject.this_cContaEmitente)
                loc_cFiltroEmi = ""
                IF !EMPTY(loc_cEmitente)
                    loc_cFiltroEmi = " AND (a.ConOrigs = " + EscaparSQL(loc_cEmitente) + ;
                        " OR a.Contat = " + EscaparSQL(loc_cEmitente) + ")"
                ENDIF
                loc_cSQLChe = "SELECT a.*, ' ' AS Tipo FROM SigChe a" + ;
                    " WHERE a.Vencs BETWEEN " + FormatarDataSQL(loc_tIni) + ;
                    " AND " + FormatarDataSQL(loc_tFim) + ;
                    loc_cFiltroEmi + ;
                    " ORDER BY a.Vencs"
                loc_cSQLChP = "SELECT DISTINCT b.Nums FROM SigChe a" + ;
                    " LEFT JOIN SigCheh b ON a.Nums = b.Nums" + ;
                    " WHERE a.Vencs BETWEEN " + FormatarDataSQL(loc_tIni) + ;
                    " AND " + FormatarDataSQL(loc_tFim)
            ENDIF

            *-- Ramo 3 (legado: IF pcAcesso = 'CARTEIRA') - SOBREPOE os
            *-- anteriores: UM cheque especifico vindo da carteira
            IF loc_cAcesso == "CARTEIRA"
                loc_cSQLChe = "SELECT a.*, ' ' AS Tipo FROM SigChe a" + ;
                    " WHERE a.Vencs BETWEEN " + FormatarDataSQL(loc_tIni) + ;
                    " AND " + FormatarDataSQL(loc_tFim) + ;
                    " AND a.Bancos = "   + EscaparSQL(THIS.this_cParamBancos) + ;
                    " AND a.Agencias = " + EscaparSQL(THIS.this_cParamAgencias) + ;
                    " AND a.nContas = "  + EscaparSQL(THIS.this_cParamNContas) + ;
                    " AND a.nCheques = " + EscaparSQL(THIS.this_cParamNCheques) + ;
                    " ORDER BY a.Vencs"
                loc_cSQLChP = "SELECT DISTINCT b.Nums FROM SigChe a" + ;
                    " LEFT JOIN SigCheh b ON a.Nums = b.Nums" + ;
                    " WHERE a.Vencs BETWEEN " + FormatarDataSQL(loc_tIni) + ;
                    " AND " + FormatarDataSQL(loc_tFim)
            ENDIF

            *-- Sem acesso irrestrito e sem conta de origem nenhum dos tres
            *-- ramos monta consulta - o legado nem chega aqui, porque o
            *-- Ok.Click exige a conta antes de trocar de pagina
            IF EMPTY(loc_cSQLChe)
                MsgAviso("Informe a conta de origem antes de consultar o " + ;
                    "hist" + CHR(243) + "rico.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            ENDIF

            *-- 1) cursor auxiliar: Nums que possuem historico em SigCheh
            IF loc_lOk
                THIS.FecharCursor("cursor_4c_ChequeP")
                THIS.FecharCursor("cursor_4c_Temp")
                IF SQLEXEC(gnConnHandle, loc_cSQLChP, "cursor_4c_Temp") < 0
                    MsgErro("Erro ao consultar o hist" + CHR(243) + "rico dos cheques." + ;
                        CHR(13) + CapturarErroSQL(), "FormSigOpChi.CarregarDados")
                    loc_lOk = .F.
                ELSE
                    SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_ChequeP READWRITE
                    THIS.FecharCursor("cursor_4c_Temp")
                    SELECT cursor_4c_ChequeP
                    INDEX ON Nums TAG Nums
                ENDIF
            ENDIF

            *-- 2) cursor principal da GradeCheque
            IF loc_lOk
                THIS.FecharCursor("cursor_4c_Cheque")
                THIS.FecharCursor("cursor_4c_Temp")
                IF SQLEXEC(gnConnHandle, loc_cSQLChe, "cursor_4c_Temp") < 0
                    MsgErro("Erro ao consultar os cheques." + CHR(13) + CapturarErroSQL(), ;
                        "FormSigOpChi.CarregarDados")
                    loc_lOk = .F.
                ELSE
                    SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Cheque READWRITE
                    THIS.FecharCursor("cursor_4c_Temp")
                ENDIF
            ENDIF

            *-- 3) marca com "S" o cheque que tem historico (legado: Scan +
            *-- Seek em LocalChP + Replace Tipo With [S]) e cria os TAGs que a
            *-- ordenacao por cabecalho de coluna usa
            loc_cNumCheque = ""
            IF loc_lOk
                SELECT cursor_4c_Cheque
                SCAN
                    IF SEEK(Nums, "cursor_4c_ChequeP", "Nums")
                        REPLACE Tipo WITH "S"
                    ENDIF
                ENDSCAN

                THIS.IndexarCursorCheque()

                *-- Legado: Go Bottom / lcNum = CrSigChe.Nums - o ultimo cheque
                *-- na ordem de vencimento eh quem alimenta as duas grades de
                *-- detalhe. Nums vai SEM ALLTRIM: eh char(8) e o SQL Server
                *-- compara char com blank-padding
                IF RECCOUNT("cursor_4c_Cheque") > 0
                    GO BOTTOM
                    loc_cNumCheque = cursor_4c_Cheque.Nums
                ENDIF

                *-- Legado: Update CrSigChe Set DtEmis = Nvl(DtEmis, Ctod([]))
                *-- - sem isso a Column12 (Emissao) recebe TTOD(.NULL.)
                REPLACE ALL DtEmis WITH CTOT("") FOR ISNULL(DtEmis)
                GO TOP
            ENDIF

            *-- 4) grades de detalhe do cheque corrente. Legado: Requery de
            *-- CrSigCqChm e CrSigChea, cujas queries sao as do AddCursor do Init:
            *--   Select * From SigCqChm Where Nums = ?lcNum Order By Nums, Dtsis Desc
            *--   Select * From SigChea  Where Nums = ?lcNum
            IF loc_lOk
                loc_cSQLMov = "SELECT * FROM SigCqChm WHERE Nums = " + ;
                    EscaparSQL(loc_cNumCheque) + " ORDER BY Nums, Dtsis DESC"
                loc_cSQLPro = "SELECT * FROM SigChea WHERE Nums = " + ;
                    EscaparSQL(loc_cNumCheque)

                THIS.FecharCursor("cursor_4c_Movimento")
                THIS.FecharCursor("cursor_4c_Temp")
                IF SQLEXEC(gnConnHandle, loc_cSQLMov, "cursor_4c_Temp") < 0
                    MsgErro("Erro ao consultar a movimenta" + CHR(231) + CHR(227) + ;
                        "o do cheque." + CHR(13) + CapturarErroSQL(), ;
                        "FormSigOpChi.CarregarDados")
                    loc_lOk = .F.
                ELSE
                    SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Movimento READWRITE
                    THIS.FecharCursor("cursor_4c_Temp")
                ENDIF
            ENDIF

            IF loc_lOk
                THIS.FecharCursor("cursor_4c_Prorrog")
                THIS.FecharCursor("cursor_4c_Temp")
                IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_Temp") < 0
                    MsgErro("Erro ao consultar as prorroga" + CHR(231) + CHR(245) + ;
                        "es do cheque." + CHR(13) + CapturarErroSQL(), ;
                        "FormSigOpChi.CarregarDados")
                    loc_lOk = .F.
                ELSE
                    SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Prorrog READWRITE
                    THIS.FecharCursor("cursor_4c_Temp")
                ENDIF
            ENDIF

            *-- 5) vinculo das grades. O legado so vincula havendo registro:
            *-- "If Reccount('CrSigChe') > 0"
            IF loc_lOk AND RECCOUNT("cursor_4c_Cheque") > 0
                THIS.VincularGradeCheque()
                THIS.VincularGradeMovimenta()
                THIS.VincularGradeProrrog()

                *-- Carrega no BO o cheque corrente, para que as acoes sobre a
                *-- linha selecionada leiam as propriedades do BO
                SELECT cursor_4c_Cheque
                GO TOP
                THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Cheque")

                *-- Rede de seguranca: o legado conta com o GradeCheque.
                *-- AfterRowColChange disparando sozinho ao vincular RecordSource
                *-- (VincularGradeCheque, chamado acima) para corrigir Documento/
                *-- Carteira/Followup/Caption do registro do GO TOP (o SqlDados
                *-- carrega Movimento/Prorrog do GO BOTTOM so para obter lcNum).
                *-- Chamar aqui tambem garante o mesmo resultado mesmo que o
                *-- AfterRowColChange nao dispare sozinho neste ponto do ciclo
                *-- de vida do form (ex.: pagina ainda nao esta ActivePage).
                THIS.AtualizarEstadoChequeAtual()
            ENDIF

            THIS.RepintarGradesHistorico()
            loc_lSucesso = loc_lOk
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGradeCheque - ColumnCount -> RecordSource -> ControlSource ->
    * Width -> Header1.Caption. A ordem eh obrigatoria: RecordSource recalcula
    * as larguras das colunas para o default, entao Width e caption vem por
    * ultimo. ControlSource e DynamicFore/BackColor transcritos do SqlDados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularGradeCheque()
        LOCAL loc_oGrade
        loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Cheque

        WITH loc_oGrade
            .ColumnCount  = 12
            .RecordSource = "cursor_4c_Cheque"

            .Column1.ControlSource  = "TTOD(cursor_4c_Cheque.Vencs)"
            .Column2.ControlSource  = "cursor_4c_Cheque.Bancos"
            .Column3.ControlSource  = "cursor_4c_Cheque.Agencias"
            .Column4.ControlSource  = "cursor_4c_Cheque.nContas"
            .Column5.ControlSource  = "cursor_4c_Cheque.nCheques"
            .Column6.ControlSource  = "cursor_4c_Cheque.Valors"
            .Column7.ControlSource  = "cursor_4c_Cheque.GruCarts"
            .Column8.ControlSource  = "cursor_4c_Cheque.ConCarts"
            .Column9.ControlSource  = "cursor_4c_Cheque.Emps"
            .Column10.ControlSource = "cursor_4c_Cheque.Numeros"
            .Column11.ControlSource = "cursor_4c_Cheque.UMovs"
            .Column12.ControlSource = "TTOD(cursor_4c_Cheque.DtEmis)"

            .Column1.Width  = 80
            .Column2.Width  = 35
            .Column3.Width  = 49
            .Column4.Width  = 90
            .Column5.Width  = 60
            .Column6.Width  = 115
            .Column7.Width  = 95
            .Column8.Width  = 95
            .Column9.Width  = 31
            .Column10.Width = 58
            .Column11.Width = 150
            .Column12.Width = 80

            .Column1.Header1.Caption  = "Vencimento"
            .Column2.Header1.Caption  = "Bco"
            .Column3.Header1.Caption  = "Ag" + CHR(234) + "ncia"
            .Column4.Header1.Caption  = "Conta"
            .Column5.Header1.Caption  = "N" + CHR(250) + "mero"
            .Column6.Header1.Caption  = "Valor"
            .Column7.Header1.Caption  = "Grupo Carteira"
            .Column8.Header1.Caption  = "Conta Carteira"
            .Column9.Header1.Caption  = "Emp"
            .Column10.Header1.Caption = "Arquivo"
            .Column11.Header1.Caption = CHR(218) + "ltimo Movimento"
            .Column12.Header1.Caption = "Emiss" + CHR(227) + "o"

            *-- Colunas 7..10 somente leitura (dump legado). Column.ReadOnly vem
            *-- DEPOIS de Grid.ReadOnly, que propaga para as colunas
            .Column7.ReadOnly  = .T.
            .Column8.ReadOnly  = .T.
            .Column9.ReadOnly  = .T.
            .Column10.ReadOnly = .T.

            *-- Cheque com historico em SigCheh (Tipo = "S") sai em azul sobre
            *-- verde claro. Legado: Iif(!IsEmpty(CrSigChe.Tipo),...) - a coluna
            *-- Tipo nasce de "' ' AS Tipo" e nunca eh NULL, por isso o EMPTY()
            *-- nativo equivale ao IsEmpty do Framework legado neste ponto
            .SetAll("DynamicForeColor", ;
                "IIF(!EMPTY(cursor_4c_Cheque.Tipo), RGB(0,0,255), RGB(0,0,0))", "Column")
            .SetAll("DynamicBackColor", ;
                "IIF(!EMPTY(cursor_4c_Cheque.Tipo), RGB(220,255,220), RGB(255,255,255))", "Column")

            *-- Dump legado: Column7.ColumnOrder = 8 e Column8.ColumnOrder = 7,
            *-- isto eh, Conta Carteira eh exibida ANTES de Grupo Carteira. UMA
            *-- unica atribuicao troca as duas (a segunda desfaria a troca)
            .Column8.ColumnOrder = 7

            *-- Header1.Click (ordenar por coluna) - os Header1 das colunas sao
            *-- RECRIADOS a cada atribuicao de ColumnCount (regra #183), por
            *-- isso o bind tem de ser refeito aqui, a cada chamada, e nao em
            *-- ConfigurarGradesHistorico (que so roda uma vez)
            BINDEVENT(.Column1.Header1, "Click", THIS, "GradeChequeHeader1Click")
            BINDEVENT(.Column2.Header1, "Click", THIS, "GradeChequeHeader2Click")
            BINDEVENT(.Column3.Header1, "Click", THIS, "GradeChequeHeader3Click")
            BINDEVENT(.Column4.Header1, "Click", THIS, "GradeChequeHeader4Click")
            BINDEVENT(.Column5.Header1, "Click", THIS, "GradeChequeHeader5Click")
            BINDEVENT(.Column6.Header1, "Click", THIS, "GradeChequeHeader6Click")
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGradeMovimenta - ControlSource/Width/Caption de GradeMovimenta
    * (SigCqChm), transcritos do SqlDados e do dump legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularGradeMovimenta()
        LOCAL loc_oGrade
        loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Movimenta

        WITH loc_oGrade
            .ColumnCount  = 9
            .RecordSource = "cursor_4c_Movimento"

            .Column1.ControlSource = "cursor_4c_Movimento.Codigos"
            .Column2.ControlSource = "cursor_4c_Movimento.Nalineas"
            .Column3.ControlSource = "TTOD(cursor_4c_Movimento.DtEnts)"
            .Column4.ControlSource = "cursor_4c_Movimento.GruOrigs"
            .Column5.ControlSource = "cursor_4c_Movimento.ConOrigs"
            .Column6.ControlSource = "cursor_4c_Movimento.Grupos"
            .Column7.ControlSource = "cursor_4c_Movimento.Contas"
            .Column8.ControlSource = "cursor_4c_Movimento.NumLotes"
            .Column9.ControlSource = "cursor_4c_Movimento.Protocolos"

            .Column1.Width = 157
            .Column2.Width = 40
            .Column3.Width = 80
            .Column4.Width = 90
            .Column5.Width = 90
            .Column6.Width = 90
            .Column7.Width = 90
            .Column8.Width = 90
            .Column9.Width = 90

            .Column1.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.Caption = "Alinea"
            .Column3.Header1.Caption = "Entrada"
            .Column4.Header1.Caption = "Grupo/Origem"
            .Column5.Header1.Caption = "Conta/Origem"
            .Column6.Header1.Caption = "Grupo/Destino"
            .Column7.Header1.Caption = "Conta/Destino"
            .Column8.Header1.Caption = "Lote"
            .Column9.Header1.Caption = "Protocolo"

            *-- Dump legado: Column8 e Column9 declaram apenas Movable = .F.;
            *-- so as sete primeiras travam tambem o Resizable
            .Column8.Resizable = .T.
            .Column9.Resizable = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGradeProrrog - ControlSource/Width/Caption de GradeProrrog
    * (SigChea - vencimentos das prorrogacoes do cheque corrente)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularGradeProrrog()
        LOCAL loc_oGrade
        loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Prorrog

        WITH loc_oGrade
            .ColumnCount             = 1
            .RecordSource            = "cursor_4c_Prorrog"
            .Column1.ControlSource   = "TTOD(cursor_4c_Prorrog.Vencs)"
            .Column1.Width           = 83
            .Column1.Header1.Caption = "Prorroga" + CHR(231) + CHR(245) + "es"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * IndexarCursorCheque - Os dez TAGs + SET ORDER usados por CarregarDados
    * (carga inicial) e por AcaoProcurarClick (mescla dos cheques encontrados
    * pelo dialogo de busca). Fatorado para nao duplicar o bloco em dois
    * lugares - mesmas dez expressoes do SqlDados legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE IndexarCursorCheque()
        SELECT cursor_4c_Cheque
        INDEX ON DTOS(Vencs) + Bancos + Agencias + nContas + nCheques TAG Venc
        INDEX ON Bancos + Agencias + nContas + nCheques TAG Cheque
        INDEX ON Agencias + nContas + nCheques TAG Agencia
        INDEX ON Agencias + nContas TAG AgenciaCta
        INDEX ON Agencias + nCheques TAG AgenciaChe
        INDEX ON nContas + nCheques TAG Conta
        INDEX ON nCheques TAG NCheque
        INDEX ON STR(Valors, 12, 2) + Bancos + Agencias + nContas + nCheques TAG Valor
        INDEX ON Numeros TAG Numeros
        INDEX ON Nums TAG Nums
        SET ORDER TO Venc
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCursorProtocolo - Cursor local usado por AcaoProtocoloClick,
    * equivalente ao "Create Cursor TempChq" que o Init legado executa uma
    * unica vez. Chamado uma vez em InicializarForm.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCursorProtocolo()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_Protocolo")
                CREATE CURSOR cursor_4c_Protocolo (Bancos C(3), Agencias C(4), ;
                    NContas C(10), NCheques C(6), Vencs D NULL, Valors N(12, 2), ;
                    Emps C(3), Iclis C(10), Grclis C(10), Contas C(10), ;
                    Grupos C(10), ValPags N(12, 2), Nums C(8), Protocolos C(8), Obss M)
                INDEX ON Bancos + Agencias + NContas + NCheques TAG Cheque
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarCursorProtocolo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ExigirChequeSelecionado - Guarda comum aos 8 botoes de cmg_4c_Botoes:
    * nenhum deles tem sentido sem uma linha corrente em cursor_4c_Cheque (o
    * legado presume que a grade sempre tem o cheque corrente porque o Init/
    * SqlDados so chega aqui com Reccount > 0 - aqui a lista pode ficar vazia
    * e os botoes continuam clicaveis)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExigirChequeSelecionado()
        IF !USED("cursor_4c_Cheque") OR RECCOUNT("cursor_4c_Cheque") = 0 OR ;
                EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cNums))
            MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizarEstadoChequeAtual - Recalcula, para o cheque CORRENTE de
    * cursor_4c_Cheque, tudo que o legado recalcula em GradeCheque.
    * AfterRowColChange: BO (CarregarDoCursor), Caption (so quando Acesso eh
    * TOTAL/CARTEIRA - no filtro restrito o Caption ja foi fixado por
    * CmdOkClick e nao muda por linha), Documento.Enabled (ChkRegister
    * SigCdPgr/SigMvCab x2), Carteira.Enabled (ChkRegister SIGCCCHM) e o
    * texto do ultimo Followup (SigCheh). ChkRegister nao existe na nova
    * arquitetura (regra do projeto) - substituido por SELECT COUNT(*).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoChequeAtual()
        LOCAL loc_cEmpr, loc_cDope, loc_nNume, loc_cKey1, loc_cKey2, loc_nResultado, ;
              loc_lDocEnab, loc_lCartEnab, loc_cHist, loc_cRclis, loc_cCpfs, loc_oErro

        IF !USED("cursor_4c_Cheque") OR EOF("cursor_4c_Cheque")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Cheque
            THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Cheque")

            *-- Caption (legado: ramo "If ThisForm.Acesso")
            IF THIS.this_lAcesso
                loc_cRclis = ""
                loc_cCpfs  = ""
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cIClis)), "cursor_4c_CliCaption")
                IF loc_nResultado > 0 AND USED("cursor_4c_CliCaption") AND !EOF("cursor_4c_CliCaption")
                    loc_cRclis = ALLTRIM(cursor_4c_CliCaption.Rclis)
                    loc_cCpfs  = ALLTRIM(cursor_4c_CliCaption.Cpfs)
                ENDIF
                THIS.FecharCursor("cursor_4c_CliCaption")
                *-- Caption guardado no BO (this_cCaptionAtual eh a fonte unica
                *-- que BOParaForm espelha ao recarregar a tela)
                THIS.this_oBusinessObject.this_cCaptionAtual = ;
                    "Hist" + CHR(243) + "rico de Cheques de: " + ;
                    ALLTRIM(THIS.this_oBusinessObject.this_cIClis) + " - " + loc_cRclis + " / " + loc_cCpfs
                THIS.Caption = THIS.this_oBusinessObject.this_cCaptionAtual
                THIS.AtualizarTituloCabecalho()
            ENDIF

            *-- Documento.Enabled (legado: Do Case com ChkRegister('SigCdPgr',
            *-- laCampo1) / ChkRegister('SigMvCab', laCampo3 - EmpDopNums
            *-- recalculado) / ChkRegister('SigMvCab', laCampo4 - EmpDopNums
            *-- do proprio registro de SigCqChm)
            loc_lDocEnab = .F.
            IF USED("cursor_4c_Movimento") AND !EOF("cursor_4c_Movimento")
                loc_cEmpr = THIS.this_oBusinessObject.this_cEmps
                loc_cDope = cursor_4c_Movimento.Dopes
                loc_nNume = cursor_4c_Movimento.NumDopes
                *-- Chave POSICIONAL (char padded) - NUNCA ALLTRIM nas partes
                loc_cKey1 = loc_cEmpr + loc_cDope + STR(loc_nNume, 6)
                loc_cKey2 = cursor_4c_Movimento.EmpDopNums

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT COUNT(*) AS nExiste FROM SigCdPgr WHERE Emps = " + ;
                    EscaparSQL(ALLTRIM(loc_cEmpr)) + " AND Dopes = " + EscaparSQL(loc_cDope) + ;
                    " AND Numes = " + FormatarNumeroSQL(loc_nNume, 0), "cursor_4c_DocVal")
                IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
                    loc_lDocEnab = .T.
                ENDIF
                THIS.FecharCursor("cursor_4c_DocVal")

                IF !loc_lDocEnab
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
                        EscaparSQL(loc_cKey1), "cursor_4c_DocVal")
                    IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
                        loc_lDocEnab = .T.
                    ENDIF
                    THIS.FecharCursor("cursor_4c_DocVal")
                ENDIF

                IF !loc_lDocEnab
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
                        EscaparSQL(loc_cKey2), "cursor_4c_DocVal")
                    IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
                        loc_lDocEnab = .T.
                    ENDIF
                    THIS.FecharCursor("cursor_4c_DocVal")
                ENDIF
            ENDIF
            THIS.pgf_4c_Paginas.Page2.cmg_4c_Botoes.Buttons(7).Enabled = loc_lDocEnab

            *-- Carteira.Enabled (legado: ChkRegister('SIGCCCHM', 'Nums', CrSigChe.Nums))
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS nExiste FROM SIGCCCHM WHERE Nums = " + ;
                EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cNums)), "cursor_4c_DocVal")
            loc_lCartEnab = loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
            THIS.FecharCursor("cursor_4c_DocVal")
            THIS.pgf_4c_Paginas.Page2.cmg_4c_Botoes.Buttons(5).Enabled = loc_lCartEnab

            *-- Ultimo followup (legado: CursorQuery SigCheh + Index On Datas
            *-- Descending + Go Top)
            loc_cHist = ""
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Hists FROM SigCheh WHERE Nums = " + ;
                EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cNums)) + ;
                " ORDER BY Datas DESC", "cursor_4c_FollowupVal")
            IF loc_nResultado > 0 AND USED("cursor_4c_FollowupVal") AND !EOF("cursor_4c_FollowupVal")
                loc_cHist = TratarNulo(cursor_4c_FollowupVal.Hists, "")
            ENDIF
            THIS.FecharCursor("cursor_4c_FollowupVal")
            *-- Fonte unica no BO; a tela espelha (BOParaForm faz o mesmo ao
            *-- recarregar, para o campo nao "esquecer" o texto)
            THIS.this_oBusinessObject.this_cUltimoFollowup = loc_cHist
            THIS.pgf_4c_Paginas.Page2.cnt_4c__Followup.txt_4c_UltFollowup.Value = loc_cHist
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AtualizarEstadoChequeAtual")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeChequeAfterRowColChange - Transcricao do AfterRowColChange de
    * GradeCheque: ao mudar a linha corrente, refaz Movimento/Prorrog para o
    * Nums da NOVA linha e recalcula Documento/Carteira/Followup/Caption
    * (AtualizarEstadoChequeAtual). Dispara tambem na ligacao inicial do
    * RecordSource (VincularGradeCheque), cobrindo o cheque do GO TOP.
    *--------------------------------------------------------------------------
    PROCEDURE GradeChequeAfterRowColChange(par_nColIndex)
        LOCAL loc_cNums, loc_cSQLMov, loc_cSQLPro, loc_oPagina, loc_oErro

        IF !USED("cursor_4c_Cheque") OR EOF("cursor_4c_Cheque")
            RETURN
        ENDIF

        loc_cNums   = cursor_4c_Cheque.Nums
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Legado: RecordSource = " " antes de refazer os cursores
            loc_oPagina.grd_4c_Movimenta.RecordSource = ""
            loc_oPagina.grd_4c_Prorrog.RecordSource   = ""

            loc_cSQLMov = "SELECT * FROM SigCqChm WHERE Nums = " + EscaparSQL(loc_cNums) + ;
                " ORDER BY Nums, Dtsis DESC"
            loc_cSQLPro = "SELECT * FROM SigChea WHERE Nums = " + EscaparSQL(loc_cNums)

            THIS.FecharCursor("cursor_4c_Movimento")
            THIS.FecharCursor("cursor_4c_Temp")
            IF SQLEXEC(gnConnHandle, loc_cSQLMov, "cursor_4c_Temp") < 0
                MsgErro("Erro ao consultar a movimenta" + CHR(231) + CHR(227) + ;
                    "o do cheque." + CHR(13) + CapturarErroSQL(), ;
                    "FormSigOpChi.GradeChequeAfterRowColChange")
            ELSE
                SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Movimento READWRITE
            ENDIF
            THIS.FecharCursor("cursor_4c_Temp")

            THIS.FecharCursor("cursor_4c_Prorrog")
            THIS.FecharCursor("cursor_4c_Temp")
            IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_Temp") < 0
                MsgErro("Erro ao consultar as prorroga" + CHR(231) + CHR(245) + ;
                    "es do cheque." + CHR(13) + CapturarErroSQL(), ;
                    "FormSigOpChi.GradeChequeAfterRowColChange")
            ELSE
                SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Prorrog READWRITE
            ENDIF
            THIS.FecharCursor("cursor_4c_Temp")

            THIS.VincularGradeMovimenta()
            THIS.VincularGradeProrrog()
            THIS.AtualizarEstadoChequeAtual()
            THIS.RepintarGradesHistorico()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.GradeChequeAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * OrdenarGradeCheque / GradeChequeHeader<N>Click - Transcricao dos SEIS
    * Header1.Click do dump legado (Column1..Column6): reindexa pelo TAG da
    * coluna preservando o registro corrente (legado: _Recno = Recno() / Set
    * Order to &lcOrd. / Go _Recno) e realca o cabecalho clicado em verde
    * claro, os outros cinco em cinza. Colunas 7..12 nao tem Header1.Click no
    * legado. Header1.Click nao recebe parametro nenhum do VFP - por isso sao
    * SEIS wrappers PUBLIC (alvo de BINDEVENT), cada um chamando o metodo
    * compartilhado com a coluna fixa.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE OrdenarGradeCheque(par_nColuna)
        LOCAL loc_cOrd, loc_oGrade, loc_nI, loc_nRecno, loc_oErro

        IF !USED("cursor_4c_Cheque")
            RETURN
        ENDIF

        loc_cOrd = ""
        DO CASE
            CASE par_nColuna = 1
                loc_cOrd = "Venc"
            CASE par_nColuna = 2
                loc_cOrd = "Cheque"
            CASE par_nColuna = 3
                loc_cOrd = "Agencia"
            CASE par_nColuna = 4
                loc_cOrd = "Conta"
            CASE par_nColuna = 5
                loc_cOrd = "NCheque"
            CASE par_nColuna = 6
                loc_cOrd = "Valor"
        ENDCASE
        IF EMPTY(loc_cOrd)
            RETURN
        ENDIF

        TRY
            loc_nRecno = RECNO("cursor_4c_Cheque")
            SELECT cursor_4c_Cheque
            SET ORDER TO (loc_cOrd)
            IF BETWEEN(loc_nRecno, 1, RECCOUNT())
                GO RECORD (loc_nRecno)
            ENDIF

            loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Cheque
            FOR loc_nI = 1 TO 6
                loc_oGrade.Columns(loc_nI).Header1.BackColor = ;
                    IIF(loc_nI = par_nColuna, RGB(220, 255, 220), RGB(192, 192, 192))
            ENDFOR
            loc_oGrade.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.OrdenarGradeCheque")
        ENDTRY
    ENDPROC

    PROCEDURE GradeChequeHeader1Click()
        THIS.OrdenarGradeCheque(1)
    ENDPROC

    PROCEDURE GradeChequeHeader2Click()
        THIS.OrdenarGradeCheque(2)
    ENDPROC

    PROCEDURE GradeChequeHeader3Click()
        THIS.OrdenarGradeCheque(3)
    ENDPROC

    PROCEDURE GradeChequeHeader4Click()
        THIS.OrdenarGradeCheque(4)
    ENDPROC

    PROCEDURE GradeChequeHeader5Click()
        THIS.OrdenarGradeCheque(5)
    ENDPROC

    PROCEDURE GradeChequeHeader6Click()
        THIS.OrdenarGradeCheque(6)
    ENDPROC

    *--------------------------------------------------------------------------
    * CmgBotoesClick - Despachante unico do CommandGroup cmg_4c_Botoes
    * (Grupo_op legado). .Value do CommandGroup eh o indice (1-based) do
    * botao que disparou o Click, na mesma numeracao Buttons(N) usada em
    * ConfigurarBotoesHistorico (Command1..Command8 do dump).
    *--------------------------------------------------------------------------
    PROCEDURE CmgBotoesClick()
        LOCAL loc_nBotao
        loc_nBotao = THIS.pgf_4c_Paginas.Page2.cmg_4c_Botoes.Value

        DO CASE
            CASE loc_nBotao = 1
                THIS.AcaoRelatorioClick()
            CASE loc_nBotao = 2
                THIS.AcaoProcurarClick()
            CASE loc_nBotao = 3
                THIS.AcaoProrrogaClick()
            CASE loc_nBotao = 4
                THIS.AcaoFollowUpClick()
            CASE loc_nBotao = 5
                THIS.AcaoCarteiraClick()
            CASE loc_nBotao = 6
                THIS.AcaoProtocoloClick()
            CASE loc_nBotao = 7
                THIS.AcaoDocumentoClick()
            CASE loc_nBotao = 8
                THIS.AcaoFollowUpChqClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * AcaoRelatorioClick - Buttons(1) "Relatorio" ([F6]). Legado: "Do Form
    * SigOpChr With crSigChe.GrClis, crSigChe.IClis, ThisForm". SigOpChr
    * ainda nao foi migrado (sem SCX no acervo desta task) - a acao e
    * tentada de verdade e so degrada com aviso se a classe nao existir.
    *--------------------------------------------------------------------------
    PROCEDURE AcaoRelatorioClick()
        LOCAL loc_oForm, loc_oErro

        IF !THIS.ExigirChequeSelecionado()
            RETURN
        ENDIF

        TRY
            loc_oForm = CREATEOBJECT("FormSigOpChr", THIS.this_oBusinessObject.this_cGrClis, ;
                THIS.this_oBusinessObject.this_cIClis, THIS)
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ENDIF
        CATCH TO loc_oErro
            MsgAviso("Tela de Relat" + CHR(243) + "rio do Hist" + CHR(243) + "rico (SigOpChr) " + ;
                "ainda n" + CHR(227) + "o foi migrada.", "Indispon" + CHR(237) + "vel")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AcaoProcurarClick - Buttons(2) "Busca" ([F5]). Legado: "Do Form
    * SigOpChb With Thisform.LeCheque, Thisform.ChqLido, Thisform.Leitor,
    * ThisForm" + Refresh + SetFocus na grade. SIGOPCHI nunca declara/usa as
    * tres propriedades do leitor de codigo de barras (varredura do dump:
    * zero ocorrencias fora desta chamada) - chegam sempre em .F./""/.F.,
    * entao e isso que se passa aqui. FormSigOpChb (ja migrado) devolve o
    * resultado da busca em cursor_4c_SigChe (Hide, nao Release - o
    * CHAMADOR le o cursor e so depois libera o dialogo).
    *--------------------------------------------------------------------------
    PROCEDURE AcaoProcurarClick()
        LOCAL loc_oBusca, loc_oGrid, loc_cNums, loc_oErro

        TRY
            loc_oBusca = CREATEOBJECT("FormSigOpChb", .F., "", .F., THIS)
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.Show()

                IF USED("cursor_4c_SigChe") AND RECCOUNT("cursor_4c_SigChe") > 0 AND ;
                        USED("cursor_4c_Cheque")
                    SELECT cursor_4c_SigChe
                    SCAN
                        loc_cNums = Nums
                        IF !SEEK(loc_cNums, "cursor_4c_Cheque", "Nums")
                            SCATTER MEMVAR MEMO
                            SELECT cursor_4c_Cheque
                            APPEND BLANK
                            GATHER MEMVAR MEMO
                            REPLACE Tipo WITH IIF(USED("cursor_4c_ChequeP") AND ;
                                SEEK(loc_cNums, "cursor_4c_ChequeP", "Nums"), "S", " ")
                        ENDIF
                        SELECT cursor_4c_SigChe
                    ENDSCAN

                    THIS.IndexarCursorCheque()
                    SELECT cursor_4c_Cheque
                    GO TOP
                    THIS.AtualizarEstadoChequeAtual()
                    THIS.RepintarGradesHistorico()
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoProcurarClick")
        ENDTRY

        *-- Legado: ThisForm.Pagina.Historico.Refresh + GradeCheque.SetFocus +
        *-- GradeCheque.Column1.Text1.SetFocus
        loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Cheque
        THIS.pgf_4c_Paginas.Page2.Refresh()
        loc_oGrid.SetFocus()
        loc_oGrid.Column1.Text1.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * AcaoProrrogaClick - Buttons(3) "Prorroga" ([F7]). Legado: Seek em
    * crSigCdOpt (Operacaos = CrSigChe.Umovs); bloqueia com aviso se
    * Tipos = "CR" e Prorrogas <> 1; senao "Do Form SigOpChp With ThisForm".
    * crSigCdOpt nao existe como cursor global nesta migracao - substituido
    * por SELECT direto em SigCdOpt. SigOpChp ainda nao foi migrado.
    *--------------------------------------------------------------------------
    PROCEDURE AcaoProrrogaClick()
        LOCAL loc_nResultado, loc_cTipos, loc_nProrrogas, loc_lPode, loc_oForm, loc_oErro

        IF !THIS.ExigirChequeSelecionado()
            RETURN
        ENDIF

        loc_lPode = .T.
        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Tipos, Prorrogas FROM SigCdOpt WHERE Operacaos = " + ;
                EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cUMovs)), "cursor_4c_OptVal")
            IF loc_nResultado > 0 AND USED("cursor_4c_OptVal") AND !EOF("cursor_4c_OptVal")
                loc_cTipos     = ALLTRIM(cursor_4c_OptVal.Tipos)
                loc_nProrrogas = NVL(cursor_4c_OptVal.Prorrogas, 0)
                IF loc_cTipos == "CR" AND loc_nProrrogas != 1
                    MsgAviso("Imposs" + CHR(237) + "vel prorrogar cheques que n" + CHR(227) + ;
                        "o estejam pendentes...", "Aten" + CHR(231) + CHR(227) + "o!!!")
                    loc_lPode = .F.
                ENDIF
            ENDIF
            THIS.FecharCursor("cursor_4c_OptVal")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lPode = .F.
        ENDTRY

        IF !loc_lPode
            RETURN
        ENDIF

        TRY
            loc_oForm = CREATEOBJECT("FormSigOpChp", THIS)
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ENDIF
        CATCH TO loc_oErro
            MsgAviso("Tela de Prorroga" + CHR(231) + CHR(227) + "o de Cheques (SigOpChp) " + ;
                "ainda n" + CHR(227) + "o foi migrada.", "Indispon" + CHR(237) + "vel")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AcaoFollowUpClick - Buttons(4) "Followup Clientes" ([F8]). Legado: usa
    * a conta do FILTRO (Pagina.Filtro.Origem.Get_Conta) se preenchida, senao
    * cai para CrSigChe.Iclis do cheque corrente; "do Form SigOpFlp With
    * lcCliente, ThisForm.DatasessionId". SigOpFlp ainda nao foi migrado.
    *--------------------------------------------------------------------------
    PROCEDURE AcaoFollowUpClick()
        LOCAL loc_cCliente, loc_oForm, loc_oErro

        loc_cCliente = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c__Conta.Value)
        IF EMPTY(loc_cCliente)
            IF !THIS.ExigirChequeSelecionado()
                RETURN
            ENDIF
            loc_cCliente = ALLTRIM(THIS.this_oBusinessObject.this_cIClis)
        ENDIF

        TRY
            loc_oForm = CREATEOBJECT("FormSigOpFlp", loc_cCliente, THIS.DataSessionId)
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ENDIF
        CATCH TO loc_oErro
            MsgAviso("Tela de Followup de Clientes (SigOpFlp) ainda n" + CHR(227) + ;
                "o foi migrada.", "Indispon" + CHR(237) + "vel")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AcaoCarteiraClick - Buttons(5) "Carteira" ([F11]). Legado: "do Form
    * SigOpChc With ThisForm" + atualiza a grade depois da baixa (comentario
    * do legado: "chama o metodo abaixo para atualizar a grade" via
    * cnt_periodo.dt_final.Valid, aqui pelo funil THIS.CarregarLista()).
    * FormSigOpChc JA FOI MIGRADO (Init recebe o form pai e o Nums do cheque
    * corrente - exatamente o par que este botao fornece).
    *--------------------------------------------------------------------------
    PROCEDURE AcaoCarteiraClick()
        LOCAL loc_oForm, loc_oErro

        IF !THIS.ExigirChequeSelecionado()
            RETURN
        ENDIF

        TRY
            loc_oForm = CREATEOBJECT("FormSigOpChc", THIS, ALLTRIM(THIS.this_oBusinessObject.this_cNums))
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoCarteiraClick")
        ENDTRY

        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * AcaoProtocoloClick - Buttons(6) "Protocolo" ([F9]). Legado: sem
    * Protocolos no cheque, apenas avisa; com Protocolos, monta TempChq (aqui
    * cursor_4c_Protocolo) com os dados do cheque + o Protocolos da
    * movimentacao corrente e abre "Do Form SigOpIbo With ThisForm, 1,
    * lcCaption" (impressao). SigOpIbo ainda nao foi migrado - a preparacao
    * do cursor de impressao (o trabalho de dado real do botao) e feita de
    * qualquer forma; so a tela de impressao em si degrada com aviso.
    *--------------------------------------------------------------------------
    PROCEDURE AcaoProtocoloClick()
        LOCAL loc_cCheque, loc_cCaption, loc_cProtocolo, loc_oForm, loc_oErro

        IF !THIS.ExigirChequeSelecionado()
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cProtocolos))
            MsgAviso("Este lan" + CHR(231) + "amento n" + CHR(227) + "o possui protocolo!", "Aviso...")
            RETURN
        ENDIF

        loc_cCheque  = ALLTRIM(THIS.this_oBusinessObject.this_cBancos) + "/" + ;
                       ALLTRIM(THIS.this_oBusinessObject.this_cAgencias) + "/" + ;
                       ALLTRIM(THIS.this_oBusinessObject.this_cNContas) + "/" + ;
                       ALLTRIM(THIS.this_oBusinessObject.this_cNCheques)
        loc_cCaption = "Impress" + CHR(227) + "o do Protocolo do Cheque: " + loc_cCheque

        loc_cProtocolo = ""
        IF USED("cursor_4c_Movimento") AND !EOF("cursor_4c_Movimento")
            loc_cProtocolo = ALLTRIM(cursor_4c_Movimento.Protocolos)
        ENDIF

        TRY
            IF USED("cursor_4c_Protocolo")
                SELECT cursor_4c_Protocolo
                ZAP
                INSERT INTO cursor_4c_Protocolo (Bancos, Agencias, NContas, NCheques, Vencs, Valors, Protocolos) ;
                    VALUES (THIS.this_oBusinessObject.this_cBancos, THIS.this_oBusinessObject.this_cAgencias, ;
                            THIS.this_oBusinessObject.this_cNContas, THIS.this_oBusinessObject.this_cNCheques, ;
                            ConverterParaData(THIS.this_oBusinessObject.this_dVencs), ;
                            THIS.this_oBusinessObject.this_nValors, loc_cProtocolo)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoProtocoloClick")
        ENDTRY

        TRY
            loc_oForm = CREATEOBJECT("FormSigOpIbo", THIS, 1, loc_cCaption)
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ENDIF
        CATCH TO loc_oErro
            MsgAviso("Tela de Impress" + CHR(227) + "o de Protocolo (SigOpIbo) ainda n" + ;
                CHR(227) + "o foi migrada.", "Indispon" + CHR(237) + "vel")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AcaoDocumentoClick - Buttons(7) "Movimento" ([F4], "Documento" no
    * legado). Legado: Do Case com tres ChkRegister (SigCdPgr por Emps/Dopes/
    * Numes; SigMvCab por EmpDopNums recalculado; SigMvCab por EmpDopNums do
    * proprio registro de SigCqChm), abrindo SigCdPgr/SigMvExp conforme o
    * primeiro que casar. ChkRegister nao existe na nova arquitetura -
    * substituido por SELECT COUNT(*). FormSigMvExp JA FOI MIGRADO; SigCdPgr
    * ainda nao. O guard "WExist('FORM_')" do legado (bloqueia abrir SigMvExp
    * com a Movimentacao de Estoque aberta) nao tem equivalente nesta
    * arquitetura - nao ha janela "FORM_" para detectar.
    *--------------------------------------------------------------------------
    PROCEDURE AcaoDocumentoClick()
        LOCAL loc_cEmpr, loc_cDope, loc_nNume, loc_cKey1, loc_cKey2, loc_nResultado, ;
              loc_oForm, loc_oErro

        IF !THIS.ExigirChequeSelecionado()
            RETURN
        ENDIF
        IF !USED("cursor_4c_Movimento") OR EOF("cursor_4c_Movimento")
            MsgAviso("Nenhuma movimenta" + CHR(231) + CHR(227) + "o selecionada.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_cEmpr = THIS.this_oBusinessObject.this_cEmps
        loc_cDope = cursor_4c_Movimento.Dopes
        loc_nNume = cursor_4c_Movimento.NumDopes
        *-- Chave POSICIONAL (char padded) - NUNCA ALLTRIM nas partes
        loc_cKey1 = loc_cEmpr + loc_cDope + STR(loc_nNume, 6)
        loc_cKey2 = cursor_4c_Movimento.EmpDopNums

        loc_oForm = .NULL.
        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS nExiste FROM SigCdPgr WHERE Emps = " + EscaparSQL(ALLTRIM(loc_cEmpr)) + ;
                " AND Dopes = " + EscaparSQL(loc_cDope) + " AND Numes = " + FormatarNumeroSQL(loc_nNume, 0), ;
                "cursor_4c_DocVal")
            IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
                THIS.FecharCursor("cursor_4c_DocVal")
                TRY
                    loc_oForm = CREATEOBJECT("FormSigCdPgr", LEFT(loc_cDope, 1), .T., loc_cEmpr, loc_cDope, loc_nNume)
                CATCH TO loc_oErro
                    MsgAviso("Tela de Registro de Pagamentos (SigCdPgr) ainda n" + CHR(227) + ;
                        "o foi migrada.", "Indispon" + CHR(237) + "vel")
                ENDTRY
            ELSE
                THIS.FecharCursor("cursor_4c_DocVal")
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
                    EscaparSQL(loc_cKey1), "cursor_4c_DocVal")
                IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
                    THIS.FecharCursor("cursor_4c_DocVal")
                    loc_oForm = CREATEOBJECT("FormSigMvExp", loc_cDope, "C", loc_nNume, loc_cEmpr, .T.)
                ELSE
                    THIS.FecharCursor("cursor_4c_DocVal")
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
                        EscaparSQL(loc_cKey2), "cursor_4c_DocVal")
                    IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
                        loc_oForm = CREATEOBJECT("FormSigMvExp", loc_cDope, "C", loc_nNume, ;
                            cursor_4c_Movimento.Emps, .T.)
                    ENDIF
                ENDIF
            ENDIF
            THIS.FecharCursor("cursor_4c_DocVal")

            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoDocumentoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AcaoFollowUpChqClick - Buttons(8) "Followup Cheques" ([F3],
    * "followUpChq" no legado). Legado: "Do Form SigOpCfl With crSigChe.Nums,
    * ThisForm.DatasessionId" + SetFocus na grade. FormSigOpCfl JA FOI
    * MIGRADO (Init: par_cConta recebe exatamente o SigChe.Nums do cheque
    * consultado - mesma semantica desta chamada).
    *--------------------------------------------------------------------------
    PROCEDURE AcaoFollowUpChqClick()
        LOCAL loc_oForm, loc_oErro

        IF !THIS.ExigirChequeSelecionado()
            RETURN
        ENDIF

        TRY
            loc_oForm = CREATEOBJECT("FormSigOpCfl", ALLTRIM(THIS.this_oBusinessObject.this_cNums), ;
                THIS.DataSessionId)
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoFollowUpChqClick")
        ENDTRY

        THIS.pgf_4c_Paginas.Page2.grd_4c_Cheque.SetFocus()
    ENDPROC

    *==========================================================================
    * FASE 8 - CONSOLIDACAO: hooks de transferencia, funil de carga, estado
    * dos campos e dos botoes.
    *
    * Este form OPERACIONAL nao tem CRUD (o legado SIGOPCHI nao faz Insert/
    * Update/Delete em SigChe - ver cabecalho de SigOpChiBO.prg), mas TEM
    * campos EDITAVEIS que alimentam a operacao: os tres campos do container
    * Origem (Page1) + o OptionGroup Lista/Filtro, os tres campos do container
    * Emitente (Page2) e as duas datas do periodo de vencimento. Por isso
    * FormParaBO/BOParaForm existem de verdade aqui - o bloco ja estava no
    * Init legado, espalhado pelos AddObject, sem esse nome.
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaBO - Le os campos EDITAVEIS da tela para as propriedades do BO,
    * que sao a FONTE UNICA lida por CarregarDados.
    *
    * PROTECTED porque FormBase declara este hook PROTECTED e VFP9 nao permite
    * ALARGAR o escopo de metodo herdado.
    *
    * Transferencia pura, sem validacao propria: a unica validacao que o
    * legado faz antes de consultar eh a conta obrigatoria quando o acesso eh
    * restrito, e ela mora em CmdOkClick (Ok.Click legado) e no guard de
    * CarregarDados - repeti-la aqui exibiria a mesma mensagem duas vezes.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_oOrig, loc_oEmi, loc_oPer, loc_oBO, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
                    PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
                loc_oBO   = THIS.this_oBusinessObject
                loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
                loc_oEmi  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
                loc_oPer  = THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo

                *-- Container Origem (Pagina.Filtro.Origem do legado)
                loc_oBO.this_cContaOrigem  = ALLTRIM(loc_oOrig.txt_4c__Conta.Value)
                loc_oBO.this_cDContaOrigem = ALLTRIM(loc_oOrig.txt_4c__DConta.Value)
                loc_oBO.this_cCpfOrigem    = ALLTRIM(loc_oOrig.txt_4c__Cpf.Value)

                *-- optFiltro eh OptionGroup: .Value eh o INDICE 1-based do
                *-- botao marcado (1 = Lista, 2 = Filtro), NUNCA 0/1 logico
                loc_oBO.this_nTipoFiltroOrigem = ;
                    IIF(loc_oOrig.obj_4c_OptFiltro.Value >= 1, loc_oOrig.obj_4c_OptFiltro.Value, 1)

                *-- Container Emitente (Pagina.Historico.Emitente do legado)
                loc_oBO.this_cContaEmitente  = ALLTRIM(loc_oEmi.txt_4c__Conta.Value)
                loc_oBO.this_cDContaEmitente = ALLTRIM(loc_oEmi.txt_4c__DConta.Value)
                loc_oBO.this_cCpfEmitente    = ALLTRIM(loc_oEmi.txt_4c__Cpf.Value)

                *-- Periodo de vencimento (Cnt_periodo). ConverterParaData
                *-- normaliza DATE/DATETIME/CHAR - TTOD() direto estouraria
                *-- erro 11 com o DATE que o TextBox guarda
                loc_oBO.this_dDataInicial = ConverterParaData(loc_oPer.txt_4c_Dt_inicial.Value)
                loc_oBO.this_dDataFinal   = ConverterParaData(loc_oPer.txt_4c_Dt_final.Value)

                *-- Espelho do "ThisForm.Filtrado = !Empty(Get_Conta.Value)"
                THIS.this_lFiltrado    = !EMPTY(loc_oBO.this_cContaOrigem)
                loc_oBO.this_lFiltrado = THIS.this_lFiltrado

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BOParaForm - Caminho inverso: escreve as propriedades do BO nos campos
    * editaveis e nos campos somente-exibicao (Followup e Caption).
    *
    * Equivale ao bloco de ".<campo>.Value = ThisForm.<prop>" que o Init
    * legado executa depois de resolver o periodo default e os parametros de
    * pre-filtro (pBancos/pAgencias/pNContas/pNCheques/pVencs no acesso
    * CARTEIRA). Eh o ponto de RECARGA: chamado por AlternarPagina e por
    * LimparCampos, de modo que a tela sempre reflita o BO.
    *
    * PROTECTED pelo mesmo motivo de FormParaBO (hook herdado de FormBase).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oOrig, loc_oEmi, loc_oPer, loc_oBO, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
                    PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
                loc_oBO   = THIS.this_oBusinessObject
                loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
                loc_oEmi  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
                loc_oPer  = THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo

                loc_oOrig.txt_4c__Conta.Value    = loc_oBO.this_cContaOrigem
                loc_oOrig.txt_4c__DConta.Value   = loc_oBO.this_cDContaOrigem
                loc_oOrig.txt_4c__Cpf.Value      = loc_oBO.this_cCpfOrigem
                loc_oOrig.obj_4c_OptFiltro.Value = ;
                    IIF(loc_oBO.this_nTipoFiltroOrigem >= 1, loc_oBO.this_nTipoFiltroOrigem, 1)

                loc_oEmi.txt_4c__Conta.Value  = loc_oBO.this_cContaEmitente
                loc_oEmi.txt_4c__DConta.Value = loc_oBO.this_cDContaEmitente
                loc_oEmi.txt_4c__Cpf.Value    = loc_oBO.this_cCpfEmitente

                loc_oPer.txt_4c_Dt_inicial.Value = ConverterParaData(loc_oBO.this_dDataInicial)
                loc_oPer.txt_4c_Dt_final.Value   = ConverterParaData(loc_oBO.this_dDataFinal)

                *-- Campos somente-exibicao: o texto do ultimo followup e o
                *-- Caption do form sao resolvidos por AtualizarEstadoChequeAtual
                *-- e guardados no BO; aqui apenas se espelham na tela
                THIS.pgf_4c_Paginas.Page2.cnt_4c__Followup.txt_4c_UltFollowup.Value = ;
                    loc_oBO.this_cUltimoFollowup
                IF !EMPTY(loc_oBO.this_cCaptionAtual)
                    THIS.Caption = loc_oBO.this_cCaptionAtual
                    THIS.AtualizarTituloCabecalho()
                ENDIF

                loc_oOrig.txt_4c__Conta.Refresh
                loc_oOrig.txt_4c__DConta.Refresh
                loc_oOrig.txt_4c__Cpf.Refresh
                loc_oEmi.txt_4c__Conta.Refresh
                loc_oEmi.txt_4c__DConta.Refresh
                loc_oEmi.txt_4c__Cpf.Refresh
                loc_oPer.txt_4c_Dt_inicial.Refresh
                loc_oPer.txt_4c_Dt_final.Refresh

                *-- A dependencia entre os campos (When do legado) depende dos
                *-- valores que acabaram de ser escritos
                THIS.HabilitarCampos(.T.)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - FUNIL UNICO de carga do Historico: transfere a tela para
    * o BO, executa a consulta (CarregarDados = SqlDados legado) e repinta as
    * tres grades.
    *
    * PUBLIC de proposito: TesteAutomatico.prg chama THIS.oForm.CarregarLista()
    * de FORA da classe, e PEMSTATUS(oForm, "CarregarLista", 5) devolve .T.
    * mesmo para metodo PROTECTED (so verifica existencia, nao escopo) - o
    * teste entraria no branch e a chamada estouraria em runtime.
    *
    * Popular cursor NAO repinta a grade, e Refresh em pagina oculta nao
    * pinta: por isso o Repintar vem no FIM e AlternarPagina chama este metodo
    * DEPOIS de trocar o ActivePage.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF THIS.FormParaBO()
            loc_lSucesso = THIS.CarregarDados()
            THIS.RepintarGradesHistorico()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Estado de entrada dos campos de filtro. Transcreve os
    * cinco PROCEDURE When do legado, que implementam EXCLUSAO MUTUA entre os
    * campos de conta:
    *
    *   Origem.get_Cpf.When    -> Empty(Get_Conta.Value)
    *   Origem.get_DConta.When -> Empty(Get_Conta.Value) And Empty(Get_Cpf.Value)
    *   Origem.optFiltro.When  -> Empty(Get_Conta) And Empty(Get_Cpf) And Empty(get_DConta)
    *   Emitente.get_Cpf.When    -> Empty(Get_Conta.Value)
    *   Emitente.get_DConta.When -> Empty(Get_Conta) And Empty(Get_Cpf)
    *
    * Preenchido o campo de conta, os seguintes param de aceitar digitacao -
    * o legado limpa os irmaos no Valid do campo resolvido (PreencherOrigem/
    * PreencherEmitente fazem o mesmo), e eh por ali que se recomeca.
    *
    * Mecanismo: TextBox recebe ReadOnly + TabStop (e NAO Enabled), que eh o
    * equivalente de runtime mais fiel ao When - bloqueia foco e digitacao
    * SEM acinzentar o controle (PILAR 1). OptionGroup nao tem ReadOnly, so
    * Enabled; o acinzentamento dele eh divergencia inevitavel do legado.
    * BINDEVENT em "When" nao serve: o BINDEVENT DESCARTA o retorno do
    * delegate, entao um When ligado por ali nao bloquearia nada.
    *
    * par_lHabilitar = .F. forca TODOS os campos somente-leitura, ignorando a
    * cascata. Parametro OMITIDO vale .T. - a distincao usa PCOUNT(), porque
    * em VFP9 parametro nao passado chega como .F. logico e VARTYPE nao
    * distingue um do outro.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab, loc_oOrig, loc_oEmi, loc_oPer, loc_oErro
        LOCAL loc_lContaOrig, loc_lCpfOrig, loc_lNomeOrig
        LOCAL loc_lContaEmi, loc_lCpfEmi, loc_lNomeEmi
        loc_lHab = IIF(PCOUNT() = 0, .T., par_lHabilitar)

        TRY
            IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
                loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
                loc_oEmi  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
                loc_oPer  = THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo

                *-- Cascata do When (Origem): a conta eh sempre digitavel; o
                *-- CPF so com a conta vazia; o nome so com conta E CPF vazios;
                *-- o optFiltro so com os TRES vazios
                loc_lContaOrig = loc_lHab
                loc_lCpfOrig   = loc_lHab AND EMPTY(ALLTRIM(loc_oOrig.txt_4c__Conta.Value))
                loc_lNomeOrig  = loc_lCpfOrig AND EMPTY(ALLTRIM(loc_oOrig.txt_4c__Cpf.Value))

                loc_oOrig.txt_4c__Conta.ReadOnly   = !loc_lContaOrig
                loc_oOrig.txt_4c__Conta.TabStop    = loc_lContaOrig
                loc_oOrig.txt_4c__Cpf.ReadOnly     = !loc_lCpfOrig
                loc_oOrig.txt_4c__Cpf.TabStop      = loc_lCpfOrig
                loc_oOrig.txt_4c__DConta.ReadOnly  = !loc_lNomeOrig
                loc_oOrig.txt_4c__DConta.TabStop   = loc_lNomeOrig
                loc_oOrig.obj_4c_OptFiltro.Enabled = loc_lNomeOrig AND ;
                    EMPTY(ALLTRIM(loc_oOrig.txt_4c__DConta.Value))

                *-- Cascata do When (Emitente): identica, sem optFiltro - o
                *-- dump nao declara OptionGroup neste container
                loc_lContaEmi = loc_lHab
                loc_lCpfEmi   = loc_lHab AND EMPTY(ALLTRIM(loc_oEmi.txt_4c__Conta.Value))
                loc_lNomeEmi  = loc_lCpfEmi AND EMPTY(ALLTRIM(loc_oEmi.txt_4c__Cpf.Value))

                loc_oEmi.txt_4c__Conta.ReadOnly  = !loc_lContaEmi
                loc_oEmi.txt_4c__Conta.TabStop   = loc_lContaEmi
                loc_oEmi.txt_4c__Cpf.ReadOnly    = !loc_lCpfEmi
                loc_oEmi.txt_4c__Cpf.TabStop     = loc_lCpfEmi
                loc_oEmi.txt_4c__DConta.ReadOnly = !loc_lNomeEmi
                loc_oEmi.txt_4c__DConta.TabStop  = loc_lNomeEmi

                *-- As duas datas do periodo nao tem When no legado: seguem
                *-- apenas o par_lHabilitar
                loc_oPer.txt_4c_Dt_inicial.ReadOnly = !loc_lHab
                loc_oPer.txt_4c_Dt_inicial.TabStop  = loc_lHab
                loc_oPer.txt_4c_Dt_final.ReadOnly   = !loc_lHab
                loc_oPer.txt_4c_Dt_final.TabStop    = loc_lHab

                *-- UltFollowup eh somente-exibicao no legado
                *-- (Cnt_Followup.UltFollowup.When -> Return .f.)
                THIS.pgf_4c_Paginas.Page2.cnt_4c__Followup.txt_4c_UltFollowup.ReadOnly = .T.
                THIS.pgf_4c_Paginas.Page2.cnt_4c__Followup.txt_4c_UltFollowup.TabStop  = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarDependenciaCampos - Alvo parametro-zero dos BINDEVENT de
    * InteractiveChange dos seis campos de conta. NAO se liga HabilitarCampos
    * direto ao evento: InteractiveChange nao passa argumento e, em VFP9,
    * parametro nao passado chega como .F. logico - par_lHabilitar viria .F. e
    * a tela inteira ficaria somente-leitura ao primeiro caractere digitado.
    *--------------------------------------------------------------------------
    PROCEDURE AplicarDependenciaCampos()
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera os dois containers de conta e restaura o periodo de
    * vencimento default, voltando o BO e a tela ao estado de abertura.
    *
    * Transcreve o Sair.Click legado do Historico, que no acesso restrito
    * limpa os TRES campos de Origem e restaura o Caption:
    *   .Filtro.Origem.Get_conta.Value  = ''
    *   .Filtro.Origem.Get_Dconta.Value = ''
    *   .Filtro.Origem.Get_Cpf.Value    = ''
    *   ThisForm.Caption = 'Historico de Cheques'
    * mais o periodo default do Init legado (Date() ate 31/12 do ano corrente;
    * no acesso CARTEIRA, o vencimento do cheque recebido).
    *
    * PROTECTED porque FormBase declara este hook PROTECTED.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oBO, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_oBO = THIS.this_oBusinessObject

                loc_oBO.this_cContaOrigem      = ""
                loc_oBO.this_cDContaOrigem     = ""
                loc_oBO.this_cCpfOrigem        = ""
                loc_oBO.this_nTipoFiltroOrigem = 1
                loc_oBO.this_cContaEmitente    = ""
                loc_oBO.this_cDContaEmitente   = ""
                loc_oBO.this_cCpfEmitente      = ""
                loc_oBO.this_cUltimoFollowup   = ""
                loc_oBO.this_cCaptionAtual     = "Hist" + CHR(243) + "rico de Cheques"

                *-- Periodo default - mesma regra do Init legado
                IF ALLTRIM(UPPER(loc_oBO.this_cAcesso)) == "CARTEIRA" AND ;
                        !EMPTY(THIS.this_dParamVencs)
                    loc_oBO.this_dDataInicial = THIS.this_dParamVencs
                    loc_oBO.this_dDataFinal   = THIS.this_dParamVencs
                ELSE
                    loc_oBO.this_dDataInicial = DATE()
                    loc_oBO.this_dDataFinal   = ;
                        CTOD("31/12/" + ALLTRIM(STR(YEAR(DATE()))))
                ENDIF

                THIS.this_lFiltrado    = .F.
                loc_oBO.this_lFiltrado = .F.

                *-- BOParaForm espelha tudo na tela (e reaplica a cascata do
                *-- When ao fim), inclusive o Caption restaurado
                THIS.BOParaForm()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - FUNIL do estado dos botoes e dos campos conforme
    * a pagina ativa, que eh o "modo" deste form:
    *
    *   Page1 (Filtro)    -> this_cModoAtual = "LISTA"
    *                        Processar/Encerrar habilitados, campos editaveis
    *   Page2 (Historico) -> this_cModoAtual = "VISUALIZAR"
    *                        barra Grupo_op habilitada conforme o legado
    *                        (Procurar = !Filtrado, Protocolo = fChecaAcesso)
    *
    * Chamado por AlternarPagina nos DOIS sentidos - desabilitar no caminho de
    * ida sem reabilitar no de volta deixaria a tela inutilizavel.
    *
    * PUBLIC: TesteAutomatico.prg chama este metodo de fora da classe.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_nPagina, loc_oPg1, loc_oErro

        TRY
            IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
                loc_nPagina = THIS.pgf_4c_Paginas.ActivePage
                loc_oPg1    = THIS.pgf_4c_Paginas.Page1

                IF loc_nPagina = 2
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.AjustarBotoesHistorico()
                ELSE
                    THIS.this_cModoAtual = "LISTA"
                    loc_oPg1.cmd_4c_Ok.Enabled       = .T.
                    loc_oPg1.cmd_4c_Cancelar.Enabled = .T.
                ENDIF

                *-- Reaplica a cascata do When - os campos seguem editaveis nos
                *-- dois modos (o Historico tem o filtro de Emitente e o
                *-- periodo), o que troca eh a pagina ativa
                THIS.HabilitarCampos(.T.)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Nome canonico da ACAO desta tela. O verbo vem do
    * proprio legado: o botao da pagina de Filtro se chama "Ok" no SCX mas tem
    * Caption "\<Processar", e o Click dele eh o que dispara a consulta e leva
    * o usuario ao Historico.
    *
    * Esta tela eh um VISUALIZADOR - o legado SIGOPCHI nao tem botao de gravar
    * (varredura do dump: zero ocorrencia de btnSalvar/btnGravar/mGravaDados) e
    * nao persiste nada em SigChe; quem grava sao os formularios de detalhe que
    * os botoes de Grupo_op abrem. Por isso a acao eh "Processar" (consultar) e
    * NAO existe BtnSalvarClick - inventar um violaria o PILAR 1.
    *
    * Funil PUBLIC: o corpo mora em CmdOkClick (alvo do BINDEVENT do botao).
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        THIS.CmdOkClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Nome canonico para a acao de BUSCA desta tela, que eh o
    * botao "Busca" ([F5]) de Grupo_op (Buttons(2) -> Procurar.Click legado,
    * que abre SigOpChb). Funil PUBLIC: nao duplica logica, delega ao handler
    * ja transcrito do legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.AcaoProcurarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Nome canonico para o Encerrar. Este form tem DOIS
    * botoes de saida, um por pagina, com comportamentos DIFERENTES no legado:
    *   Page1 (cancelar.Click) -> ThisForm.Release
    *   Page2 (Sair.Click)     -> sem acesso irrestrito volta ao Filtro
    *                             limpando a Origem; com acesso, Release
    * Por isso o funil eh sensivel a pagina ativa, em vez de escolher um dos
    * dois arbitrariamente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5) AND THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.CmgSaidaClick()
        ELSE
            THIS.BtnCancelarClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Nome canonico do Encerrar da pagina de Filtro
    * (cancelar.Click legado: ThisForm.Release, sem pedir confirmacao - eh um
    * visualizador, nao ha alteracao em aberto para desfazer).
    * CmdCancelarClick (alvo do BINDEVENT do botao) delega para ca, para que
    * exista UM so corpo.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis recursivamente os controles
    * criados via AddObject (percorre tambem as Pages de um PageFrame)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_nP, loc_oControl, loc_oErro
        TRY
            FOR loc_nI = 1 TO par_oContainer.ControlCount
                loc_oControl = par_oContainer.Controls(loc_nI)
                IF VARTYPE(loc_oControl) = "O"
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
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha os cursores que o form criou e so depois delega.
    *
    * DODEFAULT() eh a ULTIMA linha: FormBase.Destroy libera o BO e refaz os
    * popups de _MSYSMENU (sem isso o menu principal fica visualmente
    * encolhido depois de qualquer form modal).
    *
    * As tres grades ficam desvinculadas antes, porque fechar o alias que esta
    * em RecordSource com a grade ainda ligada deixa o Grid apontando para
    * alias morto.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            *-- O PageFrame pode nao existir se o Init falhou antes de cria-lo:
            *-- nesse caso ja houve mensagem de erro, e desvincular grade
            *-- inexistente so somaria um segundo dialogo
            IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
                THIS.DesvincularGradesHistorico()
            ENDIF

            THIS.FecharCursor("cursor_4c_Cheque")
            THIS.FecharCursor("cursor_4c_ChequeP")
            THIS.FecharCursor("cursor_4c_Movimento")
            THIS.FecharCursor("cursor_4c_Prorrog")
            THIS.FecharCursor("cursor_4c_Protocolo")
            THIS.FecharCursor("cursor_4c_Temp")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpChiBO.prg):
*============================================================================
* SigOpChiBO.prg - Business Object para Historico de Cheques
*
* Tabela principal : SigChe    (PK: Nums char(8) - numero sequencial do cheque)
* Tabela detalhe    : SigCqChm (FK: Nums - movimentos/followup do cheque)
* Lookup conta      : SigCdCli (PK: Iclis, desc: Rclis, doc: Cpfs)
*
* Form OPERACIONAL (consulta/historico) - sem Inserir/Atualizar/Excluir.
* Filtra cheques por conta (Origem) ou por conta do Emitente, dentro de um
* periodo de vencimento, e exibe tres grades: Cheque, Movimentacao e
* Prorrogacoes, alem do ultimo Followup registrado.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpChiBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigChe (todas as colunas - cheque selecionado
    * na GradeCheque da pagina Historico). Nums eh char(8) NO BANCO - NUNCA
    * numerico (conferido em docs/schema.sql: CONSTRAINT sigche_nums PK em
    * [nums] char(8)).
    *==========================================================================
    this_cNums      = ""    && char(8)  - PK do cheque selecionado na grade
    this_cEmps      = ""    && char(3)  - Empresa do cheque selecionado
    this_cBancos    = ""    && char(3)
    this_cAgencias  = ""    && char(4)
    this_lAutos     = .F.   && bit
    this_cConCarts  = ""    && char(10) - Conta Carteira
    this_cConOrigs  = ""    && char(10) - Conta Origem
    this_cConRes    = ""    && char(10)
    this_cContas    = ""    && char(10)
    this_cCopchs    = ""    && char(15)
    this_dDatas     = {}    && datetime
    this_dDataTrans = {}    && datetime
    this_cFpags     = ""    && char(12)
    this_cGrClis    = ""    && char(10) - Grupo do cliente
    this_cGruCarts  = ""    && char(10) - Grupo Carteira
    this_cGruOrigs  = ""    && char(10) - Grupo Origem
    this_cGrupos    = ""    && char(10)
    this_cGrures    = ""    && char(10)
    this_cGrvends   = ""    && char(10)
    this_cIClis     = ""    && char(10) - Codigo do cliente/conta
    this_cLeituras  = ""    && char(34)
    this_cLocals    = ""    && char(10)
    this_nNalineas  = 0     && numeric(3,0)
    this_cNCheques  = ""    && char(6)
    this_cNContas   = ""    && char(10)
    this_cNotas     = ""    && char(6)
    this_nNtrans    = 0     && numeric(6,0)
    this_cNumeros   = ""    && char(6)
    this_cNumolds   = ""    && char(8)
    this_nNumos     = 0     && numeric(8,0)
    this_cProtocolos = ""   && char(8)
    this_cUMovs     = ""    && char(15) - Ultimo Movimento
    this_nValors    = 0     && numeric(11,2)
    this_nValpags   = 0     && numeric(11,2)
    this_dVencs     = {}    && datetime
    this_cVends     = ""    && char(10)
    this_dDtEmis    = {}    && datetime
    this_dDtAlts    = {}    && datetime
    this_cContat    = ""    && char(10)
    this_cGrupot    = ""    && char(10)
    this_nCotas     = 0     && numeric(11,4)
    this_cMoeds     = ""    && char(3)
    this_nTipoBlq   = 0     && numeric(1,0)
    this_cCustodia  = ""    && char(4)

    *==========================================================================
    * Filtro por Conta de Origem (Pagina.Filtro.Origem)
    *==========================================================================
    this_cContaOrigem     = ""    && Iclis digitado/selecionado
    this_cDContaOrigem    = ""    && Rclis (descricao/nome da conta)
    this_cCpfOrigem       = ""    && Cpfs (CPF/CNPJ da conta)
    this_nTipoFiltroOrigem = 1    && optFiltro.Value: 1=Conta exata, 2=Com Filtro (LIKE)

    *==========================================================================
    * Filtro por Conta do Emitente (Pagina.Historico.Emitente)
    *==========================================================================
    this_cContaEmitente   = ""    && Iclis do emitente
    this_cDContaEmitente  = ""    && Rclis do emitente
    this_cCpfEmitente     = ""    && Cpfs do emitente

    *==========================================================================
    * Filtro por Periodo de Vencimento (Cnt_periodo)
    *==========================================================================
    this_dDataInicial = {}    && Dt_inicial.Value
    this_dDataFinal   = {}    && Dt_final.Value

    *==========================================================================
    * Estado de acesso e navegacao
    *==========================================================================
    this_cAcesso      = "TOTAL"    && Parametro pcAcesso recebido na abertura
    this_lAcesso      = .T.        && INLIST(this_cAcesso,'TOTAL','CARTEIRA')
    this_lFiltrado    = .F.        && .T. quando a Lista foi filtrada por uma conta
    this_cCaptionAtual = ""        && Caption dinamico ("Historico de Cheques de: ...")
    this_cUltimoFollowup = ""      && Texto do ultimo followup do cheque selecionado

    *==========================================================================
    * Alias dos cursores usados pelas grades e pelos lookups
    *==========================================================================
    this_cCursorCheque      = "cursor_4c_Cheque"       && GradeCheque      (SigChe)
    this_cCursorMovimento   = "cursor_4c_Movimento"    && GradeMovimenta   (SigCqChm)
    this_cCursorProrrog     = "cursor_4c_Prorrog"      && GradeProrrog     (prorrogacoes)
    this_cCursorChequeMov   = "cursor_4c_ChequeMov"    && Detalhe do cheque selecionado
    this_cCursorCliente     = "cursor_4c_Cliente"      && Lookup SigCdCli (conta/emitente)
    this_cCursorProtocolo   = "cursor_4c_Protocolo"    && TempChq (impressao de protocolo)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigChe"
            THIS.this_cCampoChave = "Nums"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria do cheque selecionado
    * na GradeCheque, usada por RegistrarAuditoria (via BusinessBase) caso
    * algum passo futuro do historico precise identificar o registro.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cNums)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigChe para as
    * propriedades do BO. Alimentado pelo cursor que fica posicionado no
    * cheque corrente da GradeCheque (Pagina.Historico) apos o usuario
    * selecionar uma linha - equivalente ao acesso direto a crSigChe.<col>
    * que o legado faz em Grupo_op.Click (Relatorio/Documento/Prorroga/
    * FollowUp/Protocolo/Carteira) e em GradeCheque.AfterRowColChange.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cNums       = TratarNulo(Nums, "C")
            THIS.this_cEmps       = TratarNulo(Emps, "C")
            THIS.this_cBancos     = TratarNulo(Bancos, "C")
            THIS.this_cAgencias   = TratarNulo(Agencias, "C")
            THIS.this_lAutos      = ConverterParaLogico(Autos)
            THIS.this_cConCarts   = TratarNulo(ConCarts, "C")
            THIS.this_cConOrigs   = TratarNulo(ConOrigs, "C")
            THIS.this_cConRes     = TratarNulo(ConRes, "C")
            THIS.this_cContas     = TratarNulo(Contas, "C")
            THIS.this_cCopchs     = TratarNulo(Copchs, "C")
            THIS.this_dDatas      = ConverterParaData(Datas)
            THIS.this_dDataTrans  = ConverterParaData(DataTrans)
            THIS.this_cFpags      = TratarNulo(Fpags, "C")
            THIS.this_cGrClis     = TratarNulo(GrClis, "C")
            THIS.this_cGruCarts   = TratarNulo(GruCarts, "C")
            THIS.this_cGruOrigs   = TratarNulo(GruOrigs, "C")
            THIS.this_cGrupos     = TratarNulo(Grupos, "C")
            THIS.this_cGrures     = TratarNulo(Grures, "C")
            THIS.this_cGrvends    = TratarNulo(Grvends, "C")
            THIS.this_cIClis      = TratarNulo(Iclis, "C")
            THIS.this_cLeituras   = TratarNulo(Leituras, "C")
            THIS.this_cLocals     = TratarNulo(Locals, "C")
            THIS.this_nNalineas   = NVL(Nalineas, 0)
            THIS.this_cNCheques   = TratarNulo(NCheques, "C")
            THIS.this_cNContas    = TratarNulo(NContas, "C")
            THIS.this_cNotas      = TratarNulo(Notas, "C")
            THIS.this_nNtrans     = NVL(Ntrans, 0)
            THIS.this_cNumeros    = TratarNulo(Numeros, "C")
            THIS.this_cNumolds    = TratarNulo(Numolds, "C")
            THIS.this_nNumos      = NVL(Numos, 0)
            THIS.this_cProtocolos = TratarNulo(Protocolos, "C")
            THIS.this_cUMovs      = TratarNulo(UMovs, "C")
            THIS.this_nValors     = NVL(Valors, 0)
            THIS.this_nValpags    = NVL(Valpags, 0)
            THIS.this_dVencs      = ConverterParaData(Vencs)
            THIS.this_cVends      = TratarNulo(Vends, "C")
            THIS.this_dDtEmis     = ConverterParaData(DtEmis)
            THIS.this_dDtAlts     = ConverterParaData(DtAlts)
            THIS.this_cContat     = TratarNulo(Contat, "C")
            THIS.this_cGrupot     = TratarNulo(Grupot, "C")
            THIS.this_nCotas      = NVL(Cotas, 0)
            THIS.this_cMoeds      = TratarNulo(Moeds, "C")
            THIS.this_nTipoBlq    = NVL(TipoBlq, 0)
            THIS.this_cCustodia   = TratarNulo(Custodia, "C")

            RETURN .T.
        ENDIF

        RETURN .F.
    ENDPROC

    *==========================================================================
    * SigOpChi (Historico de Cheques) eh um form de CONSULTA: o legado
    * (SIGOPCHI) nao faz Insert/Update/Delete em SigChe por esta tela - o
    * usuario apenas filtra por conta/periodo e navega para os formularios
    * de detalhe (SigOpChr, SigOpChb, SigOpChp, SigOpFlp, SigOpChc), que sao
    * os responsaveis por qualquer gravacao. Por isso o comportamento padrao
    * herdado de BusinessBase (recusar Inserir/Atualizar/ExecutarExclusao)
    * ja eh o correto para este BO.
    *==========================================================================

ENDDEFINE

