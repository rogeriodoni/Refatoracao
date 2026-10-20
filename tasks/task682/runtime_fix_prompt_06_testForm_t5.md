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
[2026-10-20 03:47:46] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-20 03:47:46] [INFO] Config FPW: (nao fornecido)
[2026-10-20 03:47:46] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-20 03:47:46] [INFO] Timeout: 300 segundos
[2026-10-20 03:47:46] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_g5j4lqs3.prg
[2026-10-20 03:47:46] [INFO] Conteudo do wrapper:
[2026-10-20 03:47:46] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigprtef', 'C:\4c\tasks\task682\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprtef', 'C:\4c\tasks\task682\logs\06_testForm.log'
QUIT

[2026-10-20 03:47:46] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_g5j4lqs3.prg
[2026-10-20 03:47:46] [INFO] VFP output esperado em: C:\4c\tasks\task682\vfp_output.txt
[2026-10-20 03:47:46] [INFO] Executando Visual FoxPro 9...
[2026-10-20 03:47:46] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_g5j4lqs3.prg
[2026-10-20 03:47:46] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_g5j4lqs3.prg
[2026-10-20 03:47:46] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigprtef
Inicio: 20/10/2026 03:47:46

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 20/10/2026 03:51:37
Duracao: 231 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-20 03:51:37] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-20 03:51:38] [INFO] VFP9 finalizado em 231.5805963 segundos
[2026-10-20 03:51:38] [INFO] Exit Code: 
[2026-10-20 03:51:38] [INFO] 
[2026-10-20 03:51:38] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-20 03:51:38] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_g5j4lqs3.prg
[2026-10-20 03:51:38] [INFO] 
[2026-10-20 03:51:38] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-20 03:51:38] [INFO] * Auto-generated wrapper for parameters
[2026-10-20 03:51:38] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-20 03:51:38] [INFO] * Parameters: 'Formsigprtef', 'C:\4c\tasks\task682\logs\06_testForm.log'
[2026-10-20 03:51:38] [INFO] 
[2026-10-20 03:51:38] [INFO] * Anti-dialog protections for unattended execution
[2026-10-20 03:51:38] [INFO] SET SAFETY OFF
[2026-10-20 03:51:38] [INFO] SET RESOURCE OFF
[2026-10-20 03:51:38] [INFO] SET TALK OFF
[2026-10-20 03:51:38] [INFO] SET NOTIFY OFF
[2026-10-20 03:51:38] [INFO] SYS(2335, 0)
[2026-10-20 03:51:38] [INFO] 
[2026-10-20 03:51:38] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprtef', 'C:\4c\tasks\task682\logs\06_testForm.log'
[2026-10-20 03:51:39] [INFO] QUIT
[2026-10-20 03:51:39] [INFO] 
[2026-10-20 03:51:39] [INFO] === Fim do Wrapper.prg ===
[2026-10-20 03:51:39] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprtef.prg):
*==============================================================================
* Formsigprtef.prg - Formulario Operacional: Administracao do TEF
* Tipo: OPERACIONAL (flat sem PageFrame, modal 800x190)
* Migrado de SIGPRTEF.SCX
*
* Pilares:
*   UX   -> layout identico ao legado (800x190, botoes Top=12, TextBox Top=144)
*   BD   -> SigFiTef, SigFiNfs, SigFiMpF, SigCdPam (via sigprtefBO)
*   CODE -> arquitetura em camadas (FormBase / sigprtefBO)
*
* CHAMADA:
*   loForm = CREATEOBJECT("Formsigprtef")
*   loForm.Show()
*   - ou -
*   loForm = CREATEOBJECT("Formsigprtef", .T., lcIdChaves)
*   loForm.Show()
*
* NOTA: O controle OLE modem (oModem/ActiveX) do legado nao pode ser
*       criado via AddObject em .prg. this_oModem deve ser fornecido
*       externamente apos CREATEOBJECT antes de Show().
*
* FUNCOES GLOBAIS DO LEGADO AUSENTES POR DESENHO (CLAUDE.md regra #27)
*   fLerFiscal, SigFiTefReq, ImprFiscal, TefImpr, Responde, RotStatus,
*   RRelGerVinc, FinFimVinc - vem de sig.prg/SIGFUNCS.PRG, que NAO vieram no
*   acervo. Sao a conversa com a impressora fiscal e com o gerenciador TEF:
*   devolvem VALOR de transacao, logo um wrapper no-op gravaria status errado
*   em silencio (regra #17). Ficam ausentes de proposito, para que a falha
*   apareca ALTA em runtime em vez de corromper SigFiTef calada.
*   fChecaAcesso, LeituraFab e fDecriptografar JA existem (utils/) e sao usadas.
*==============================================================================

DEFINE CLASS Formsigprtef AS FormBase

    *-- Propriedades visuais (identicas ao legado)
    Height      = 190
    Width       = 800
    BorderStyle = 2
    AutoCenter  = .T.
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    WindowType  = 1
    WindowState = 0
    DataSession = 2
    KeyPreview  = .T.

    *-- Propriedades customizadas (RESERVED3 do legado)
    cOperacao   = ""    && Operacao TEF atual (PADR NoCaixa+NoFab+'ADM', 20 chars)
    cNoCaixa    = ""    && Numero do caixa fiscal
    cNoFab      = ""    && Numero de fabricacao da impressora fiscal
    cPcIdChaves = ""    && Chaves de identificacao da transacao TEF

    *-- Referencia ao controle modem/impressora fiscal (OLE ActiveX no legado)
    *-- Fornecido externamente; funcoes TEF (SigFiTefReq etc.) dependem deste objeto
    this_oModem = .NULL.
    *-- Guarda de reentrancia dos lookups abertos de LostFocus (regra #37, Erro195)
    this_lEmLookup = .F.

    *==========================================================================
    PROCEDURE Init
    *==========================================================================
        LPARAMETERS par_lModal, par_cIdChaves

        IF VARTYPE(par_lModal) = "L" AND par_lModal
            THIS.WindowType = 1
        ENDIF

        IF VARTYPE(par_cIdChaves) = "C"
            THIS.cPcIdChaves = ALLTRIM(par_cIdChaves)
        ENDIF

        *-- DODEFAULT() chama FormBase.Init() que:
        *-- 1) aplica SET DATE TO BRITISH + SET CENTURY ON (fix DataSession=2)
        *-- 2) chama THIS.InicializarForm()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Administra" + CHR(231) + CHR(227) + "o do TEF"

            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            THIS.this_oBusinessObject = CREATEOBJECT("sigprtefBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                *-- Guard para validacao de UI sem conexao SQL
                IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                    THIS.ConfigurarPageFrame()
                    THIS.ConfigurarPaginaDados()
                    loc_lSucesso = .T.
                ELSE
                    *-- Carregar parametros TEF de SigCdPam (popula this_nSistef no BO)
                    IF THIS.this_oBusinessObject.CarregarParametrosTEF()
                        THIS.ConfigurarPageFrame()
                        *-- DEPOIS de todos os AddObject: aplica a ordem de tabulacao do SCX
                        THIS.ConfigurarPaginaDados()
                        THIS.InicializarEstadoTEF()
                        THIS.ConfigurarEventos()
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Falha ao carregar par" + CHR(226) + "metros TEF de SigCdPam", "Erro")
                    ENDIF
                ENDIF

            ELSE
                MsgErro("Falha ao criar sigprtefBO", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao inicializar TEF")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
    *==========================================================================
        *-- Form OPERACIONAL: layout FLAT (sem PageFrame).
        *-- Metodo mantido por compatibilidade com validador do orquestrador
        *-- e delega para ConfigurarForm (que cria o layout customizado real).
        THIS.ConfigurarForm()
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
    *==========================================================================
        *-- Form OPERACIONAL: modal flat 800x190 SEM PageFrame e SEM Grid CRUD.
        *-- Nao existe "Page1 - Lista de Registros" nesta tela: os dados TEF
        *-- (crSigFiFis, crSigFiTef, CrSigFiNfs, CrTefImp, CrTefResp, SigTef)
        *-- sao cursores TRANSACIONAIS carregados sob demanda em
        *-- InicializarEstadoTEF, TxtRedetefValid, ProcCntTxt, CmdTefAdmClick e
        *-- CmdCancelarClick conforme o fluxo TEF (Ativo/Admin/Cancelamento).
        *--
        *-- Este metodo existe para atender ao contrato do validador do
        *-- orquestrador de migracao (Fase 4) e retorna sempre .T. porque
        *-- toda a "configuracao de exibicao" ja foi feita em ConfigurarForm().
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
    *==========================================================================
        *-- Form OPERACIONAL: NAO possui pgf_4c_Paginas (Page1/Page2 CRUD).
        *-- A UI eh flat (todos os controles no proprio Form) e a unica
        *-- alternancia visual eh o container cnt_4c_TefTxt (Visible=.T./.F.)
        *-- gerenciado por ProcCntTxt() apos leitura da transacao TEF.
        *--
        *-- Metodo existe para atender ao contrato do validador do orquestrador
        *-- de migracao (Fase 4). par_nPagina eh ignorado; sempre retorna .T.
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
    *==========================================================================
        *-- Form OPERACIONAL FLAT: nao existe "Page2 - Dados". Os controles (Shape1,
        *-- cnt_4c_OModem, cnt_4c_TefTxt + 6 labels, lbl_4c_Redetef, txt_4c_Redetef e
        *-- os 4 botoes) sao filhos DIRETOS do form e foram criados em ConfigurarForm().
        *--
        *-- O que sobra desta fase eh a ORDEM DE TABULACAO, que o SCX declara e que o
        *-- migrador descartou: com AddObject o VFP9 numera o TabIndex pela ordem de
        *-- CRIACAO, e a ordem de criacao do migrado nao bate com a do legado (os
        *-- botoes do SCX vem na ordem Sair/TefAdm/Command1/TefAtv, o migrado cria
        *-- TefAdm/TefAtv/Cancelar/Encerrar). Nao da erro, nao entra em log e nao
        *-- aparece em screenshot: so o Tab andando na ordem errada.
        *--
        *-- Roda em metodo proprio porque TabIndex precisa ser atribuido DEPOIS de
        *-- TODOS os AddObject (o VFP renumera a cada criacao), em ordem ASCENDENTE
        *-- (cada atribuicao poe o controle na posicao pedida e empurra os demais).
        *--
        *-- ATENCAO - os numeros vem da ordem EFETIVA do legado, nao da literal:
        *-- o SCX guarda TabIndex para so 3 objetos (medido lendo o .scx como DBF:
        *-- Get_redetef = 1, Say1 = 6, CntTefTxt = 8). Mas o VFP aplica cada valor no
        *-- momento em que CRIA o objeto e CLAMPA ao total de controles existentes
        *-- naquele instante - quando Say1 nasce (3o objeto) o 6 nao cabe, e quando
        *-- CntTefTxt nasce (5o) o 8 nao cabe. Simulado no VFP9 em 2026-10-20
        *-- (automation\medir_tabindex_sigprtef.prg), recriando os objetos na ordem dos registros
        *-- do SCX, a ordem EFETIVA do legado eh:
        *--     Get_redetef=1  oModem=2  Say1=3  CntTefTxt=4
        *--     Sair=5         TefAdm=6  Command1=7  TefAtv=8
        *-- Ou seja: so o 1 do campo de digitacao sobrevive; o resto fica na ordem de
        *-- criacao do SCX. Transcrever 6 e 8 ao pe da letra inverteria os botoes
        *-- (Encerrar iria para o fim do ciclo em vez do inicio) - seria FIEL AO
        *-- ARQUIVO e INFIEL A TELA. ZOrderSet (Say1=13, Get_redetef=30) nao eh
        *-- transcrito: eh bookkeeping do Form Designer e nao existe em runtime (#33).
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.txt_4c_Redetef.TabIndex = 1    && legado: Get_redetef (unico campo digitavel)
            THIS.cnt_4c_OModem.TabIndex  = 2    && legado: oModem
            THIS.lbl_4c_Redetef.TabIndex = 3    && legado: Say1
            THIS.cnt_4c_TefTxt.TabIndex  = 4    && legado: CntTefTxt
            THIS.cmd_4c_Encerrar.TabIndex = 5   && legado: Sair
            THIS.cmd_4c_TefAdm.TabIndex   = 6   && legado: TefAdm
            THIS.cmd_4c_Cancelar.TabIndex = 7   && legado: Command1
            THIS.cmd_4c_TefAtv.TabIndex   = 8   && legado: TefAtv

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ConfigurarPaginaDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarForm
    *==========================================================================
        LOCAL loc_oErro
        TRY

            *-- Shape decorativo (canto direito - Shape1 do legado)
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 7
                .Left        = 698
                .Height      = 110
                .Width       = 90
                .BackStyle   = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            *-- Area posicional do controle OLE modem (oModem/ActiveX do legado): o
            *-- ActiveX nao pode ser criado por AddObject em .prg, entao a instancia
            *-- real chega por THIS.this_oModem (ver cabecalho). Este Container
            *-- reserva exatamente o retangulo 100x100 em (320,8) do SCX.
            THIS.AddObject("cnt_4c_OModem", "Container")
            WITH THIS.cnt_4c_OModem
                .Top       = 8
                .Left      = 320
                .Height    = 100
                .Width     = 100
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Container de mensagens TEF (CntTefTxt do legado - inicia Visible=.F.)
            THIS.AddObject("cnt_4c_TefTxt", "Container")
            WITH THIS.cnt_4c_TefTxt
                .Top           = 192
                .Left          = 0
                .Height        = 155
                .Width         = 381
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .BackStyle     = 1
                .Visible       = .F.
            ENDWITH

            *-- Labels filhos de cnt_4c_TefTxt (fora de WITH pai - evita WITH aninhado)
            THIS.cnt_4c_TefTxt.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.cnt_4c_TefTxt.lbl_4c_Label1
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontSize  = 9
                .WordWrap  = .T.
                .BackStyle = 0
                .Caption   = "Impress" + CHR(227) + "o Cupom Vinculado : "
                .Height    = 26
                .Left      = 4
                .Top       = 5
                .Width     = 174
                .ForeColor = RGB(0, 0, 160)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_TefTxt.AddObject("lbl_4c_TxtTpTrans", "Label")
            WITH THIS.cnt_4c_TefTxt.lbl_4c_TxtTpTrans
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontSize  = 9
                .WordWrap  = .T.
                .BackStyle = 0
                .Caption   = ""
                .Height    = 26
                .Left      = 177
                .Top       = 5
                .Width     = 195
                .ForeColor = RGB(0, 0, 255)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_TefTxt.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.cnt_4c_TefTxt.lbl_4c_Label2
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontSize  = 9
                .WordWrap  = .T.
                .BackStyle = 0
                .Caption   = "Mensagem Operador : "
                .Height    = 25
                .Left      = 4
                .Top       = 62
                .Width     = 128
                .ForeColor = RGB(0, 0, 160)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_TefTxt.AddObject("lbl_4c_TxtOper", "Label")
            WITH THIS.cnt_4c_TefTxt.lbl_4c_TxtOper
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontSize  = 9
                .WordWrap  = .T.
                .BackStyle = 0
                .Caption   = ""
                .Height    = 26
                .Left      = 134
                .Top       = 61
                .Width     = 239
                .ForeColor = RGB(0, 0, 255)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_TefTxt.AddObject("lbl_4c_TxtCli", "Label")
            WITH THIS.cnt_4c_TefTxt.lbl_4c_TxtCli
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontSize  = 9
                .WordWrap  = .T.
                .BackStyle = 0
                .Caption   = "Mensagem Cliente : "
                .Height    = 22
                .Left      = 4
                .Top       = 108
                .Width     = 115
                .ForeColor = RGB(0, 0, 160)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_TefTxt.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.cnt_4c_TefTxt.lbl_4c_Label3
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontSize  = 9
                .WordWrap  = .T.
                .BackStyle = 0
                .Caption   = ""
                .Height    = 22
                .Left      = 118
                .Top       = 108
                .Width     = 255
                .ForeColor = RGB(0, 0, 255)
                .Visible   = .T.
            ENDWITH

            *-- Label "Rede Tef :" (Say1 do legado)
            THIS.AddObject("lbl_4c_Redetef", "Label")
            WITH THIS.lbl_4c_Redetef
                .FontBold  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .Caption   = "Rede Tef :"
                .Left      = 203
                .Top       = 147
                .ForeColor = RGB(36, 84, 155)
                .BackStyle = 0
                *-- Say1 do legado nao declara AutoSize/Width/Height: eh a classe "say" pura
                *-- (AutoSize = .T. / Alignment = 0). Regra #23 manda fixar a geometria em
                *-- vez de confiar no AutoSize, que eh no-op em Label criado por AddObject
                *-- em parte dos contextos (ali a Width fica nos 100 do default e a caixa
                *-- invade o TextBox em 274). Valores MEDIDOS no VFP9 em 2026-10-20 com o
                *-- auto-size ligado nesta fonte: Width 67 / Height 15 (TXTWIDTH = 65px),
                *-- ou seja o texto termina em 270, 4px antes do campo - igual ao legado.
                .AutoSize  = .F.
                .Alignment = 0
                .Width     = 67
                .Height    = 15
                .Visible   = .T.
            ENDWITH

            *-- TextBox Rede TEF (Get_redetef do legado)
            THIS.AddObject("txt_4c_Redetef", "TextBox")
            WITH THIS.txt_4c_Redetef
                .Height   = 23
                .Left     = 274
                .Top      = 144
                .Width    = 150
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                *-- TabIndex NAO vai aqui: o VFP renumera a cada AddObject seguinte.
                *-- Ele eh aplicado depois de TODOS os AddObject, em ConfigurarPaginaDados.
                *-- MaxLength vem da LARGURA DA COLUNA no schema (regra #19):
                *-- SigFiNfs.ccomprovs eh char(20) - NUNCA copiar o .Width (150 px).
                *-- Sem o limite o usuario digita alem de 20 e o SQL Server recusa
                *-- com "String or binary data would be truncated".
                .MaxLength = 20
                .Visible  = .T.
            ENDWITH

            *-- Botao Admin TEF (TefAdm do legado)
            *-- Inicia Enabled=.F.; habilitado em InicializarEstadoTEF apos leitura FAB
            THIS.AddObject("cmd_4c_TefAdm", "CommandButton")
            WITH THIS.cmd_4c_TefAdm
                .Top             = 12
                .Left            = 17
                .Width           = 75
                .Height          = 75
                .Caption         = "Admin"
                .Picture         = gc_4c_CaminhoIcones + "geral_pn_btn_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_pn_btn_60.jpg"
                .FontName        = "Tahoma"
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
                .Enabled         = .F.
                .Visible         = .T.
            ENDWITH

            *-- Botao Tef Ativo (TefAtv do legado)
            THIS.AddObject("cmd_4c_TefAtv", "CommandButton")
            WITH THIS.cmd_4c_TefAtv
                .Top             = 12
                .Left            = 100
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Tef Ativo"
                .Picture         = gc_4c_CaminhoIcones + "cartao.png"
                .DisabledPicture = gc_4c_CaminhoIcones + "cartao.png"
                .FontName        = "Tahoma"
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
                .Enabled         = .F.
                .Visible         = .T.
            ENDWITH

            *-- Botao Cancelar (Command1 do legado)
            THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH THIS.cmd_4c_Cancelar
                .Top             = 12
                .Left            = 183
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Cancelar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .FontName        = "Tahoma"
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
                .Visible         = .T.
            ENDWITH

            *-- Botao Encerrar (Sair do legado, Cancel=.T. para ESC fechar)
            THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH THIS.cmd_4c_Encerrar
                .Top             = 12
                .Left            = 703
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .FontName        = "Tahoma"
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
                .Cancel          = .T.
                .Visible         = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ConfigurarForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarEstadoTEF
    *==========================================================================
        LOCAL loc_lOk, loc_cNoFab, loc_cNoFabr, loc_oErro
        loc_lOk = .F.

        TRY
            THIS.cOperacao = ""
            THIS.cNoCaixa  = ""
            THIS.cNoFab    = ""

            *-- Carregar configuracao fiscal (popula crSigFiFis - usado nos handlers)
            =fLerFiscal()
            SELECT crSigFiFis
            GO TOP

            IF VARTYPE(THIS.this_oModem) = "O"
                *-- Ler numero de fabricacao da impressora fiscal
                loc_cNoFab = LeituraFab(THIS.this_oModem)
                IF VARTYPE(loc_cNoFab) = "C"
                    loc_cNoFabr = fDecriptografar(ALLTRIM(loc_cNoFab))
                    IF THIS.this_oBusinessObject.CarregarImpressoraFiscal(loc_cNoFabr)
                        THIS.cNoCaixa  = THIS.this_oBusinessObject.this_cNoCaixa
                        THIS.cNoFab    = loc_cNoFab
                        THIS.cOperacao = PADR(THIS.cNoCaixa + THIS.cNoFab + "ADM", 20)
                        loc_lOk        = .T.
                    ENDIF
                ENDIF
            ENDIF

            *-- Legado (SIGPRTEF.Init, With Thisform):
            *--   .TefAdm.Enabled = fChecaAcesso('TEFADM') and ok
            *--   .TefAtv.Enabled = fChecaAcesso('TEFATV') and ok
            *-- fChecaAcesso EXISTE em utils/functions.prg - transcrever, nao descartar.
            *-- O estado fica no BO (fonte unica) para HabilitarCampos reproduzir a
            *-- MESMA condicao ao reabilitar; sem ele this_lInicializado nunca era
            *-- escrito e HabilitarCampos(.T.) desligava os dois botoes de acao.
            THIS.this_oBusinessObject.this_lAcessoAdm    = fChecaAcesso("TEFADM")
            THIS.this_oBusinessObject.this_lAcessoAtv    = fChecaAcesso("TEFATV")
            THIS.this_oBusinessObject.this_lInicializado = loc_lOk

            THIS.cmd_4c_TefAdm.Enabled = THIS.this_oBusinessObject.this_lAcessoAdm AND loc_lOk
            THIS.cmd_4c_TefAtv.Enabled = THIS.this_oBusinessObject.this_lAcessoAtv AND loc_lOk

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro InicializarEstadoTEF")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
        *-- Torna controles Visible=.T. recursivamente.
        *-- FILTRO: cnt_4c_TefTxt fica Visible=.F. (toggled pela procedure CntTxt)
        *-- Os filhos do container filtrado sao recursados para ficarem Visible=.T.
        *-- quando o container for exibido posteriormente.
        LOCAL loc_i, loc_oControl, loc_p
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_TEFTXT")
                    *-- Container oculto por logica TEF: recursar filhos sem
                    *-- alterar Visible do proprio container
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_p = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF VARTYPE(THIS.this_oModem) = "O"
            THIS.this_oModem = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos
    *==========================================================================
        LOCAL loc_oErro
        TRY
            BINDEVENT(THIS.cmd_4c_Encerrar, "Click",    THIS, "CmdEncerrarClick")
            BINDEVENT(THIS.cmd_4c_TefAdm,   "Click",    THIS, "CmdTefAdmClick")
            BINDEVENT(THIS.cmd_4c_TefAdm,   "When",     THIS, "CmdTefAdmWhen")
            BINDEVENT(THIS.cmd_4c_TefAtv,   "Click",    THIS, "CmdTefAtvClick")
            BINDEVENT(THIS.cmd_4c_TefAtv,   "When",     THIS, "CmdTefAtvWhen")
            BINDEVENT(THIS.cmd_4c_Cancelar, "Click",    THIS, "CmdCancelarClick")
            BINDEVENT(THIS.cmd_4c_Cancelar, "When",     THIS, "CmdCancelarWhen")
            BINDEVENT(THIS.txt_4c_Redetef,  "KeyPress", THIS, "TxtRedetefKeyPress")
            BINDEVENT(THIS.txt_4c_Redetef,  "LostFocus",    THIS, "TxtRedetefValid")
            BINDEVENT(THIS.txt_4c_Redetef,  "DblClick", THIS, "TxtRedetefDblClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ConfigurarEventos")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CmdEncerrarClick
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE CmdTefAdmWhen
    *==========================================================================
        RETURN !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
    ENDPROC

    *==========================================================================
    PROCEDURE CmdTefAtvWhen
    *==========================================================================
        RETURN !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
    ENDPROC

    *==========================================================================
    PROCEDURE CmdCancelarWhen
    *==========================================================================
        RETURN !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
    ENDPROC

    *==========================================================================
    PROCEDURE TxtRedetefKeyPress
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            IF !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
                THIS.TxtRedetefValid()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    *-- Irmao do lookup (abre o mesmo funil por duplo clique no campo).
    *-- Regra #47: irmao que DELEGA para o alvo NAO pode ligar this_lEmLookup -
    *-- o wrapper TxtRedetefValid devolveria sem abrir nada e o DblClick morreria.
    PROCEDURE TxtRedetefDblClick
    *==========================================================================
        THIS.TxtRedetefValid()
    ENDPROC

    *==========================================================================
    *-- Guarda de reentrancia (regra #37): o picker eh MODAL e tira o foco do
    *-- campo, o que redispara este proprio LostFocus. O corpo vive em TxtRedetefValidExec
    *-- para que a flag seja SEMPRE liberada, inclusive nos RETURN antecipados.
    *-- Ligado a "KeyPress" o lookup abria a cada tecla, antes de o usuario
    *-- terminar de digitar o codigo (Erro195). Legado valida no Valid do campo.
    PROCEDURE TxtRedetefValid()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.TxtRedetefValidExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE TxtRedetefValidExec()
    *==========================================================================
        LOCAL loc_lOk, loc_oErro
        loc_lOk = .T.
        TRY
            IF !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
                IF USED("crSigFiFis") AND !EOF("crSigFiFis")
                    IF THIS.this_oBusinessObject.BuscarComprovantes(ALLTRIM(crSigFiFis.Imps))
                        SELECT CrSigFiNfs
                        INDEX ON cComprovs TAG cComprovs
                        IF SEEK(ALLTRIM(THIS.txt_4c_Redetef.Value), "CrSigFiNfs", "cComprovs")
                            *-- Achou exato: normaliza o conteudo digitado para a
                            *-- grafia gravada na coluna (char(20) com padding).
                            THIS.txt_4c_Redetef.Value = ALLTRIM(CrSigFiNfs.cComprovs)
                        ELSE
                            *-- Nao achou: so o picker decide. Regra #37/#50 - a
                            *-- atribuicao mora DENTRO de AbrirBuscaRedetef, sob a
                            *-- guarda this_lSelecionou. Ler CrSigFiNfs aqui fora
                            *-- ZERARIA/trocaria o codigo digitado quando o usuario
                            *-- cancela o dialogo (o ponteiro do cursor fica numa
                            *-- linha qualquer) e nao haveria como preencher o campo.
                            THIS.AbrirBuscaRedetef()
                        ENDIF
                        THIS.txt_4c_Redetef.Refresh()
                    ENDIF
                ENDIF
            ELSE
                THIS.txt_4c_Redetef.Value = ""
                THIS.txt_4c_Redetef.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ValidarRedetef")
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaRedetef
    *==========================================================================
        LOCAL loc_oBusca, loc_cImps, loc_oErro
        TRY
            loc_cImps = IIF(USED("crSigFiFis") AND !EOF("crSigFiFis"), ALLTRIM(crSigFiFis.Imps), "")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                       "SigFiNfs", ;
                                       "cursor_4c_BuscaRedetef", ;
                                       "cComprovs", ;
                                       ALLTRIM(THIS.txt_4c_Redetef.Value), ;
                                       "Sele" + CHR(231) + CHR(227) + "o", ;
                                       .F., .F., ;
                                       "Imps = " + EscaparSQL(loc_cImps))
            IF VARTYPE(loc_oBusca) = "O"
                *-- Contrato do FormBuscaAuxiliar (regra #37): o Init JA tentou o
                *-- match exato e, achando 1 registro, resolveu o valor sozinho.
                *-- Sem esta guarda o dialogo abre com UMA linha por cima da tela
                *-- ja preenchida e o usuario precisa dispensa-lo a toa.
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cComprovs", "", "Rede Tef")
                    loc_oBusca.mAddColuna("nfinalzs",  "XXXXXXXXXX", "Finalizadora")
                    loc_oBusca.Show()
                ENDIF
                *-- Atribuicao SO sob a guarda this_lSelecionou: nada escolhido
                *-- significa manter o codigo que o usuario digitou (regra #50 -
                *-- apagar o digitado impede o preenchimento do campo).
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRedetef")
                    THIS.txt_4c_Redetef.Value = ALLTRIM(cursor_4c_BuscaRedetef.cComprovs)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro AbrirBuscaRedetef")
        ENDTRY
        IF USED("cursor_4c_BuscaRedetef")
            USE IN cursor_4c_BuscaRedetef
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE CmdTefAtvClick
    *==========================================================================
        LOCAL loc_lcRedeTef, loc_lcTipo, loc_SendTef, loc_lcDirReq, loc_lcArq, loc_oErro
        TRY
            WAIT WINDOW "Aguarde Processamento TEF !!" NOWAIT
            loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)
            loc_lcTipo    = "ATV"
            loc_SendTef   = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
                                         THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
            IF VARTYPE(loc_SendTef) = "N"
                MsgAviso("Gerenciador Padr" + CHR(227) + "o Ativo !!", "")
            ELSE
                MsgAviso("Gerenciador Padr" + CHR(227) + "o n" + CHR(227) + "o Ativo !!", "")
                IF USED("crSigFiFis") AND !EOF("crSigFiFis")
                    IF THIS.this_oBusinessObject.BuscarNFiscalPorComprovante( ;
                            ALLTRIM(crSigFiFis.Imps), loc_lcRedeTef)
                        SELECT crTmpNFis
                        GO TOP
                        IF !EOF("crTmpNFis")
                            loc_lcDirReq = ALLTRIM(crTmpNFis.cTefdReqs)
                            loc_lcArq    = loc_lcDirReq + "IntPos.001"
                            IF FILE(loc_lcArq)
                                DELETE FILE (loc_lcArq)
                            ENDIF
                            loc_lcArq = loc_lcDirReq + "IntPos.Tmp"
                            IF FILE(loc_lcArq)
                                DELETE FILE (loc_lcArq)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            WAIT CLEAR
        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CmdTefAtvClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CmdTefAdmClick
    *==========================================================================
        LOCAL loc_lcRedeTef, loc_SendTef, loc_lcTipo, loc_lnIdent
        LOCAL loc_okTef, loc_llChecaSigTef, loc_lnQtdTef, loc_RetNImp
        LOCAL loc_oFormulario, loc_VerStatus, loc_oErro

        TRY
            IF USED("CrTefImp")
                USE IN CrTefImp
            ENDIF
            CREATE CURSOR CrTefImp (cinfos C(100), nordems N(2), cnIdents C(10))
            INDEX ON cnIdents TAG Ident

            loc_oFormulario = THIS.this_oModem
            loc_okTef       = .T.

            WAIT WINDOW "Aguarde Verificando TEF Ativo!!" NOWAIT
            loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)

            IF THIS.this_oBusinessObject.this_nSistef = 1
                loc_lcTipo  = "ATV"
                loc_SendTef = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
                                           THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
                IF VARTYPE(loc_SendTef) = "N"
                    *-- ATV retornou numerico: TEF ativo
                ELSE
                    loc_okTef = .F.
                    MsgAviso("Gerenciador Padr" + CHR(227) + "o n" + CHR(227) + "o Ativo !!", "")
                ENDIF
                WAIT CLEAR
            ENDIF

            IF loc_okTef
                loc_llChecaSigTef = .F.
                IF !USED("SigTef")
                    IF TYPE("goSistema") = "O" AND !EMPTY(goSistema.DirTefEcfs)
                        USE (goSistema.DirTefEcfs + "\SigTef") IN 0
                        loc_llChecaSigTef = .T.
                    ENDIF
                ENDIF

                IF USED("CrTef")
                    USE IN CrTef
                ENDIF
                CREATE CURSOR CrTef (cinfos M)

                IF USED("SigTef")
                    SELECT SigTef
                    COUNT FOR !DELETED() TO loc_lnQtdTef
                    GO TOP
                    IF loc_lnQtdTef = 1 AND SigTef.cStatus <> "CNF"
                        SCAN
                            IF SigTef.cCnfs = "C"
                                WAIT WINDOW "Aguarde Processamento Confirma" + CHR(231) + ;
                                            CHR(227) + "o SITEF, Prov" + CHR(225) + ;
                                            "vel Queda Energia !!" NOWAIT
                                loc_lcTipo = "CNF"
                            ELSE
                                WAIT WINDOW "Aguarde Processamento Cancelamento SITEF, Prov" + ;
                                            CHR(225) + "vel Queda Energia !!" NOWAIT
                                loc_lcTipo = "NCN"
                                THIS.this_oBusinessObject.AtualizarStatusTefPorIdents( ;
                                    SigTef.cnIdents, "CNC")
                            ENDIF
                            loc_RetNImp = TefImpr(SigTef.cEmps, SigTef.cDopes, ;
                                                   VAL(SigTef.cnCupoms), loc_lcTipo, ;
                                                   VAL(SigTef.cnIdents), SigTef.cNmRedes, ;
                                                   SigTef.cnNSUs, SigTef.cFinalzs, ;
                                                   SigTef.cCupomnvs, SigTef.FPags)
                            IF loc_RetNImp
                                IF THIS.this_oBusinessObject.this_nSistef = 1
                                    DO FORM SIGCNTEF WITH SigTef.cnNSUs, SigTef.cNmRedes, ;
                                        IIF(THIS.this_oBusinessObject.this_nSistef = 3, ;
                                            VAL(STRTRAN(SigTef.cnValors, ",", ".")), ;
                                            VAL(SigTef.cnValors) / 100)
                                ENDIF
                                SELECT SigTef
                                DELETE
                            ELSE
                                MsgAviso("Problemas de comunica" + CHR(231) + ;
                                         CHR(227) + "o com TEF !!", "")
                                loc_okTef = .F.
                            ENDIF
                        ENDSCAN
                    ELSE
                        SELECT SigTef
                        DELETE ALL
                    ENDIF
                ENDIF

                WAIT CLEAR

                IF loc_llChecaSigTef AND USED("SigTef")
                    USE IN SigTef
                ENDIF
                IF USED("CrTef")
                    USE IN CrTef
                ENDIF

                IF USED("crSigFiFis") AND !EOF("crSigFiFis")
                    IF UPPER(ALLTRIM(crSigFiFis.Imps)) <> "SWEDA"
                        loc_VerStatus = RotStatus(1, loc_oFormulario)
                        IF VARTYPE(loc_VerStatus) <> "L"
                            IF SUBSTR(loc_VerStatus, 1, 1) = "R"
                                FinFimVinc(loc_oFormulario)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                WAIT WINDOW "Aguarde Processamento TEF !!" NOWAIT
                loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)
                THIS.cmd_4c_TefAdm.Enabled = .F.
                loc_lcTipo  = "ADM"
                loc_SendTef = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
                                           THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
                WAIT CLEAR

                SELECT CrTefImp
                IF RECCOUNT("CrTefImp") <> 0
                    WAIT WINDOW "Aguarde Impress" + CHR(227) + "o !!" NOWAIT
                    IF VARTYPE(loc_SendTef) = "N"
                        loc_lnIdent = loc_SendTef
                        THIS.ImprFiscalProc(loc_lnIdent)
                    ENDIF
                ELSE
                    IF VARTYPE(loc_SendTef) = "N"
                        loc_lnIdent = loc_SendTef
                        IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
                                go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
                                ALLTRIM(STR(loc_lnIdent, 20)))
                            THIS.ExcluirTef(crSigFiTef.cnIdents)
                            THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
                                go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
                                ALLTRIM(STR(loc_lnIdent, 20)))
                            IF USED("crSigFiTef") AND !EOF("crSigFiTef")
                                SELECT crSigFiTef
                                IF !EMPTY(ALLTRIM(crSigFiTef.cTxtOpers))
                                    MsgAviso(ALLTRIM(crSigFiTef.cTxtOpers), "")
                                ENDIF
                                IF !EMPTY(ALLTRIM(crSigFiTef.cTxtClis))
                                    MsgAviso(ALLTRIM(crSigFiTef.cTxtClis), "")
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            WAIT CLEAR
            THIS.cmd_4c_TefAdm.Enabled = .T.

        CATCH TO loc_oErro
            WAIT CLEAR
            THIS.cmd_4c_TefAdm.Enabled = .T.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CmdTefAdmClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CmdCancelarClick
    *==========================================================================
        LOCAL loc_lcRedeTef, loc_SendTef, loc_lcTipo, loc_okTef
        LOCAL loc_lcDirReq, loc_lcDirResp, loc_lnQtdVia, loc_lcArquivo
        LOCAL loc_lcNSU, loc_lcFinalzs, loc_llCancTef, loc_RetCVinc
        LOCAL loc_lnContaQtdVia, loc_oFormulario, loc_lcMsg, loc_oErro

        TRY
            IF USED("CrTefImp")
                USE IN CrTefImp
            ENDIF
            CREATE CURSOR CrTefImp (cinfos C(100), nordems N(2), cnIdents C(10))
            INDEX ON cnIdents TAG Ident

            loc_oFormulario = THIS.this_oModem
            loc_okTef       = .T.
            loc_lcNSU       = ""
            loc_lcFinalzs   = ""
            loc_llCancTef   = .F.
            loc_RetCVinc    = .F.

            =fLerFiscal()

            WAIT WINDOW "Aguarde Verificando TEF Ativo!!" NOWAIT
            loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)

            IF THIS.this_oBusinessObject.this_nSistef = 1
                loc_lcTipo  = "ATV"
                loc_SendTef = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
                                           THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
                IF VARTYPE(loc_SendTef) = "N"
                    *-- ATV ok
                ELSE
                    loc_okTef = .F.
                    MsgAviso("Gerenciador Padr" + CHR(227) + "o n" + CHR(227) + "o Ativo !!", "")
                ENDIF
                WAIT CLEAR
            ENDIF

            IF loc_okTef
                IF USED("CrTef")
                    USE IN CrTef
                ENDIF
                CREATE CURSOR CrTef (cinfos M)

                IF THIS.this_oBusinessObject.BuscarTransacaoPorIdChaves(THIS.cPcIdChaves)
                    SELECT csSigFiTef
                    GO TOP

                    IF THIS.this_oBusinessObject.BuscarNFiscalPorComprovante( ;
                            ALLTRIM(crSigFiFis.Imps), ALLTRIM(csSigFiTef.cCupomnvs))
                        SELECT crTmpNFis
                        GO TOP
                        loc_lcDirReq  = ALLTRIM(crTmpNFis.cTefdReqs)
                        loc_lcDirResp = ALLTRIM(crTmpNFis.cTefdResps)
                        loc_lnQtdVia  = crTmpNFis.nQtdVias

                        loc_lcArquivo = LOWER(loc_lcDirResp + "IntPos.001")
                        IF FILE(loc_lcArquivo)
                            DELETE FILE (loc_lcArquivo)
                        ENDIF

                        SELECT csSigFiTef
                        loc_lcTipo = "CNC"
                        TefImpr(csSigFiTef.cEmps, csSigFiTef.cDopes, VAL(csSigFiTef.cnCupoms), ;
                                loc_lcTipo, VAL(csSigFiTef.cnIdents), csSigFiTef.cNmRedes, ;
                                csSigFiTef.cnNSUs, csSigFiTef.cFinalzs, csSigFiTef.cCupomnvs, ;
                                csSigFiTef.Fpags, VAL(csSigFiTef.cnValors) / 100)

                        SELECT crTmpNFis
                        loc_lcDirReq  = ALLTRIM(crTmpNFis.cTefdReqs)
                        loc_lcDirResp = ALLTRIM(crTmpNFis.cTefdResps)
                        loc_lnQtdVia  = crTmpNFis.nQtdVias
                        loc_lcArquivo = LOWER(loc_lcDirResp + "IntPos.001")

                        SELECT CrTefImp
                        DELETE ALL

                        IF !USED("CrTefResp")
                            CREATE CURSOR CrTefResp (cinfos C(100))
                            INDEX ON SUBSTR(CrTefResp.cInfos, 1, 3) TAG resp
                        ENDIF
                        SELECT CrTefResp
                        SET ORDER TO resp
                        DELETE ALL

                        APPEND FROM &loc_lcArquivo. SDF
                        SEEK "009"
                        IF ALLTRIM(SUBSTR(CrTefResp.cinfos, 11)) = "0"
                            loc_lcNSU = ""
                            IF SEEK("012")
                                loc_lcNSU = SUBSTR(CrTefResp.cinfos, 11)
                            ENDIF
                            loc_lcFinalzs = ""
                            SEEK "027"
                            IF FOUND()
                                loc_lcFinalzs = SUBSTR(CrTefResp.cinfos, 11)
                            ENDIF

                            FOR loc_lnContaQtdVia = 1 TO loc_lnQtdVia
                                SELECT CrTefResp
                                GO TOP
                                SEEK "029"
                                IF FOUND()
                                    DO WHILE CrTefResp.cInfos = "029"
                                        SELECT CrTefResp
                                        SCATTER MEMVAR
                                        m.cnIdents = csSigFiTef.cnIdents
                                        m.cinfos   = STRTRAN(SUBSTR(CrTefResp.cinfos, 11), '"', "")
                                        m.nvias    = loc_lnContaQtdVia
                                        INSERT INTO CrTefImp FROM MEMVAR
                                        SELECT CrTefResp
                                        SKIP
                                    ENDDO
                                    SELECT CrTefImp
                                    DELETE
                                ENDIF
                            NEXT

                            loc_RetCVinc  = .F.
                            loc_llCancTef = .F.
                            DO WHILE !loc_RetCVinc
                                SELECT csSigFiTef
                                loc_RetCVinc = RRelGerVinc(csSigFiTef.cnIdents, loc_oFormulario)
                                IF !loc_RetCVinc
                                    IF !MsgConfirma("Impressora N" + CHR(227) + "o Responde (1), " + ;
                                                    "Tentar Novamente ?", "")
                                        MsgInfo("Cancelamento N" + CHR(227) + "o Realizado com Sucesso," + ;
                                                " Reimpress" + CHR(227) + "o pelo Modulo Administrativo", "")
                                        loc_llCancTef = .T.
                                        loc_RetCVinc  = .F.
                                        EXIT
                                    ENDIF
                                ENDIF
                            ENDDO
                        ELSE
                            SEEK "030"
                            loc_lcMsg = IIF(EMPTY(ALLTRIM(SUBSTR(CrTefResp.cinfos, 11))), ;
                                            "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo " + ;
                                            "Usu" + CHR(225) + "rio", ;
                                            ALLTRIM(SUBSTR(CrTefResp.cinfos, 11)))
                            DO FORM SigTfDss WITH "Erro na Trasa" + CHR(231) + CHR(227) + "o", ;
                                "", loc_lcMsg, ;
                                "Cancelar ou Reimprimir pelo Modulo Administrativo", ;
                                "", "VM", 0, 0
                            loc_llCancTef = .T.
                        ENDIF

                        IF !loc_llCancTef
                            SELECT csSigFiTef
                            loc_lcTipo = "CNF"
                            TefImpr(csSigFiTef.cEmps, csSigFiTef.cDopes, VAL(csSigFiTef.cnCupoms), ;
                                    loc_lcTipo, VAL(csSigFiTef.cnIdents), csSigFiTef.cNmRedes, ;
                                    loc_lcNSU, loc_lcFinalzs, csSigFiTef.cCupomnvs, csSigFiTef.Fpags)
                            THIS.this_oBusinessObject.AtualizarStatusTef(THIS.cPcIdChaves, "CNC")
                            WAIT CLEAR
                        ELSE
                            loc_lcNSU     = IIF(!EMPTY(loc_lcNSU),     loc_lcNSU,     csSigFiTef.cnNSUs)
                            loc_lcFinalzs = IIF(!EMPTY(loc_lcFinalzs), loc_lcFinalzs, csSigFiTef.cFinalzs)
                            FinFimVinc(loc_oFormulario)
                            DO FORM SIGCNTEF WITH csSigFiTef.cnNSUs, csSigFiTef.cNmRedes, ;
                                VAL(STRTRAN(csSigFiTef.cnValors, ",", ".")) / 100
                            loc_lcTipo = "NCN"
                            TefImpr(go_4c_Sistema.cCodEmpresa, "", 0, loc_lcTipo, ;
                                    VAL(csSigFiTef.cnIdents), csSigFiTef.cNmRedes, ;
                                    loc_lcNSU, loc_lcFinalzs, csSigFiTef.cCupomnvs, csSigFiTef.Fpags)
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CmdCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ProcCntTxt
    *==========================================================================
        LOCAL loc_cHeader, loc_lcTran, loc_nSistef, loc_cSQL, loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF !USED("crSigFiTef") OR EOF("crSigFiTef")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar

            loc_nSistef = THIS.this_oBusinessObject.this_nSistef
            SELECT crSigFiTef

            IF (ALLTRIM(crSigFiTef.cTpTrans) = "99" AND loc_nSistef = 1) OR loc_nSistef = 3
                loc_cHeader = SPACE(3)
            ELSE
                loc_cHeader = crSigFiTef.cHeaders
            ENDIF

            IF USED("crSigFiTra")
                USE IN crSigFiTra
            ENDIF
            loc_cSQL = "SELECT * FROM SigFiTra " + ;
                       "WHERE cHeaders = " + EscaparSQL(ALLTRIM(loc_cHeader)) + ;
                       " AND cTpTrans = " + EscaparSQL(ALLTRIM(crSigFiTef.cTpTrans))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiTra") > 0
                SELECT crSigFiTra
                GO TOP
                IF EOF() OR ALLTRIM(crSigFiTef.cTpTrans) = "99"
                    loc_lcTran = "Outras"
                ELSE
                    loc_lcTran = ALLTRIM(crSigFiTra.cTrans)
                ENDIF
            ELSE
                loc_lcTran = "Outras"
            ENDIF

            WITH THIS.cnt_4c_TefTxt
                .Top  = 35
                .Left = 2
                IF loc_nSistef = 1 OR loc_nSistef = 3
                    IF !EMPTY(ALLTRIM(crSigFiTef.cTxtOpers))
                        .lbl_4c_TxtOper.Caption  = ALLTRIM(crSigFiTef.cTxtOpers)
                        .lbl_4c_TxtOper.Width    = 239
                        .lbl_4c_TxtOper.AutoSize = .T.
                        .Visible = .T.
                        .ZOrder()
                    ENDIF
                    IF !EMPTY(ALLTRIM(crSigFiTef.cTxtClis))
                        .lbl_4c_TxtCli.Caption  = ALLTRIM(crSigFiTef.cTxtClis)
                        .lbl_4c_TxtCli.Width    = 255
                        .lbl_4c_TxtCli.AutoSize = .T.
                        .Visible = .T.
                        .ZOrder()
                    ENDIF
                    IF !EMPTY(loc_lcTran)
                        .lbl_4c_TxtTpTrans.Caption  = loc_lcTran
                        .lbl_4c_TxtTpTrans.Width    = 195
                        .lbl_4c_TxtTpTrans.AutoSize = .T.
                        .Visible = .T.
                        .ZOrder()
                    ENDIF
                ENDIF
            ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ProcCntTxt")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExcluirTef(par_cIdent)
    *==========================================================================
        LOCAL loc_llChecaSigTef, loc_cChave, loc_oErro
        loc_llChecaSigTef = .F.
        TRY
            IF !USED("SigTef")
                IF TYPE("goSistema") = "O" AND !EMPTY(goSistema.DirTefEcfs)
                    USE (goSistema.DirTefEcfs + "\SigTef") IN 0
                    loc_llChecaSigTef = .T.
                ENDIF
            ENDIF
            IF USED("SigTef")
                loc_cChave = "R" + go_4c_Sistema.cCodEmpresa + THIS.cOperacao + ALLTRIM(par_cIdent)
                =SEEK(loc_cChave, "SigTef", "Ident")
                SELECT SigTef
                IF !EOF("SigTef")
                    DELETE IN SigTef
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ExcluirTef")
        ENDTRY
        IF loc_llChecaSigTef AND USED("SigTef")
            USE IN SigTef
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ImprFiscalProc(par_nIdent)
    *==========================================================================
        LOCAL loc_lRetCVinc, loc_lLoopCVinc, loc_lRetNImp, loc_lPrimeira, loc_lRetFim
        LOCAL loc_lnValor, loc_lcCancTef, loc_lcNSUs, loc_lcTipo, loc_VerStatus
        LOCAL loc_oFormulario, loc_lcRedes, loc_oErro

        TRY
            IF USED("crSigFiFis")
                SELECT crSigFiFis
                GO TOP
            ENDIF

            loc_oFormulario = THIS.this_oModem

            IF !EMPTY(THIS.cOperacao)
                loc_lRetCVinc  = .F.
                loc_lLoopCVinc = .T.
                loc_lPrimeira  = .T.
                loc_lRetFim    = .T.

                DO WHILE loc_lLoopCVinc
                    CLEAR TYPEAHEAD
                    THIS.ProcCntTxt()

                    SELECT CrTefImp
                    loc_lnValor = "0"
                    GO TOP
                    LOCATE FOR cinfos = " VALOR VENDA"
                    IF EOF()
                        LOCATE FOR cinfos = "    FINAL"
                        IF !EOF()
                            loc_lnValor = STRTRAN(STRTRAN(ALLTRIM(SUBSTR(cinfos, 10)), ",", ""), ".", "")
                        ENDIF
                    ELSE
                        loc_lnValor = STRTRAN(STRTRAN(ALLTRIM(SUBSTR(cinfos, 16)), ",", ""), ".", "")
                    ENDIF
                    GO TOP

                    IF !loc_lPrimeira
                        IF USED("crSigFiFis") AND UPPER(ALLTRIM(crSigFiFis.Imps)) = "SWEDA"
                            loc_lRetFim = FinFimVinc(loc_oFormulario)
                        ELSE
                            loc_lRetFim   = .F.
                            loc_VerStatus = RotStatus(1, loc_oFormulario)
                            IF VARTYPE(loc_VerStatus) <> "L"
                                IF SUBSTR(loc_VerStatus, 1, 1) = "R"
                                    loc_lRetFim = FinFimVinc(loc_oFormulario)
                                ENDIF
                                IF !loc_lRetFim AND SUBSTR(loc_VerStatus, 6, 1) = "K"
                                    loc_lRetFim = .T.
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_lRetFim
                        SELECT CrTefImp
                        GO TOP
                        loc_lRetCVinc = RRelGerVinc(CrTefImp.cnIdents, loc_oFormulario, THIS.cOperacao)
                    ENDIF

                    loc_lPrimeira = .F.
                    WITH THIS.cnt_4c_TefTxt
                        .lbl_4c_TxtOper.Caption    = ""
                        .lbl_4c_TxtCli.Caption     = ""
                        .lbl_4c_TxtTpTrans.Caption = ""
                        .Visible = .F.
                    ENDWITH

                    IF loc_lRetCVinc
                        loc_lcCancTef = ""
                        IF USED("CrTefResp")
                            SELECT CrTefResp
                            GO TOP
                            IF SEEK("025")
                                loc_lcCancTef = ALLTRIM(SUBSTR(CrTefResp.cinfos, 11))
                            ENDIF
                        ENDIF

                        IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
                                go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
                                ALLTRIM(STR(par_nIdent, 20)))
                            SELECT crSigFiTef
                            loc_lcNSUs = IIF(EMPTY(ALLTRIM(crSigFiTef.cnNSUCancs)), ;
                                             crSigFiTef.cnNSUs, crSigFiTef.cnNSUCancs)
                            loc_lcTipo = "CNF"
                            TefImpr(go_4c_Sistema.cCodEmpresa, THIS.cOperacao, 0, loc_lcTipo, ;
                                    VAL(crSigFiTef.cnIdents), crSigFiTef.cNmRedes, loc_lcNSUs, ;
                                    crSigFiTef.cFinalzs, crSigFiTef.cCupomnvs, crSigFiTef.FPags)
                            THIS.ExcluirTef(crSigFiTef.cnIdents)

                            IF !EMPTY(loc_lcCancTef)
                                IF !EMPTY(THIS.cPcIdChaves)
                                    THIS.this_oBusinessObject.AtualizarStatusTef( ;
                                        THIS.cPcIdChaves, "CNC")
                                ELSE
                                    loc_lcRedes = ""
                                    IF USED("CrTefResp")
                                        SELECT CrTefResp
                                        IF SEEK("010")
                                            loc_lcRedes = ALLTRIM(SUBSTR(CrTefResp.cinfos, 11))
                                        ENDIF
                                    ENDIF
                                    IF !EMPTY(loc_lcRedes)
                                        THIS.this_oBusinessObject.AtualizarStatusTefPorRede( ;
                                            loc_lcRedes, loc_lcCancTef, "CNC")
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF

                        loc_lLoopCVinc = .F.
                        loc_lRetCVinc  = .T.
                        LOOP
                    ELSE
                        WAIT WINDOW "Aguarde Impress" + CHR(227) + "o !!!" NOWAIT
                        IF USED("crSigFiFis") AND UPPER(ALLTRIM(crSigFiFis.Imps)) <> "SWEDA"
                            loc_VerStatus = RotStatus(1, loc_oFormulario)
                            IF VARTYPE(loc_VerStatus) <> "L"
                                IF SUBSTR(loc_VerStatus, 6, 1) = "t"
                                    MsgAviso("Encontrou-se no comando a string 'TOTAL'", "ERRO")
                                    FinFimVinc(loc_oFormulario)
                                    IF THIS.this_oBusinessObject.this_nSistef = 1
                                        IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
                                                go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
                                                ALLTRIM(STR(par_nIdent, 20)))
                                            SELECT crSigFiTef
                                            DO FORM SIGCNTEF WITH crSigFiTef.cnNSUs, crSigFiTef.cNmRedes, ;
                                                VAL(loc_lnValor) / 100
                                        ENDIF
                                    ENDIF
                                    IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
                                            go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
                                            ALLTRIM(STR(par_nIdent, 20)))
                                        SELECT crSigFiTef
                                        loc_lcTipo = "NCN"
                                        TefImpr(go_4c_Sistema.cCodEmpresa, THIS.cOperacao, 0, ;
                                                loc_lcTipo, VAL(crSigFiTef.cnIdents), ;
                                                crSigFiTef.cNmRedes, crSigFiTef.cnNSUs, ;
                                                crSigFiTef.cFinalzs, crSigFiTef.cCupomnvs, ;
                                                crSigFiTef.FPags)
                                        THIS.ExcluirTef(crSigFiTef.cnIdents)
                                    ENDIF
                                    loc_lLoopCVinc = .F.
                                    loc_lRetCVinc  = .F.
                                    LOOP
                                ENDIF
                            ENDIF
                        ENDIF

                        IF (THIS.this_oBusinessObject.this_nSistef = 1 AND ;
                            !MsgConfirma("IMPRESSORA N" + CHR(195) + "O RESPONDE, TENTAR NOVAMENTE", "")) OR ;
                           THIS.this_oBusinessObject.this_nSistef = 3

                            IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
                                    go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
                                    ALLTRIM(STR(par_nIdent, 20)))
                                SELECT crSigFiTef
                                loc_lcTipo = "NCN"
                                TefImpr(go_4c_Sistema.cCodEmpresa, THIS.cOperacao, 0, ;
                                        loc_lcTipo, VAL(crSigFiTef.cnIdents), ;
                                        crSigFiTef.cNmRedes, crSigFiTef.cnNSUs, ;
                                        crSigFiTef.cFinalzs, crSigFiTef.cCupomnvs, ;
                                        crSigFiTef.FPags)
                                THIS.ExcluirTef(crSigFiTef.cnIdents)
                                IF THIS.this_oBusinessObject.this_nSistef = 1
                                    DO FORM SIGCNTEF WITH crSigFiTef.cnNSUs, crSigFiTef.cNmRedes, ;
                                        VAL(loc_lnValor) / 100
                                ENDIF
                            ENDIF
                            loc_lLoopCVinc = .F.
                            loc_lRetCVinc  = .F.
                            LOOP
                        ELSE
                            loc_lRetFim   = .T.
                            loc_lPrimeira = .T.
                        ENDIF
                    ENDIF
                ENDDO

                WAIT CLEAR
            ELSE
                MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o de Cupom Fiscal !!", "ERRO")
            ENDIF
        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ImprFiscalProc")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ENTRADAS DE NOME CRUD - o legado SIGPRTEF NAO possui CRUD
    *
    * O SCX legado tem exatamente QUATRO acoes (Admin / Tef Ativo / Cancelar /
    * Encerrar), todas ja ligadas aos seus proprios botoes em ConfigurarEventos.
    * Nao ha grade, nao ha registro, nao ha Incluir / Alterar / Excluir: o dump
    * de SIGPRTEF nao tem um unico BaseClass grid ou pageframe, nem AddCursor,
    * pColuna, RecordSource ou ControlSource.
    *
    * Estes metodos existem porque o harness de teste os chama por NOME, de fora
    * da classe (CLAUDE.md regra #3). Eles NAO podem disparar transacao TEF:
    * CmdTefAdmClick / CmdTefAtvClick / CmdCancelarClick chamam SigFiTefReq(),
    * que abre transacao REAL no gerenciador padrao, sem guarda de modo de teste.
    * Acionar pagamento a partir de um nome "Incluir" ou "Salvar" seria efeito
    * colateral invisivel ao operador. As operacoes TEF ficam exclusivamente nos
    * quatro botoes reais, como no legado.
    *==========================================================================

    *==========================================================================
    * BtnIncluirClick / BtnAlterarClick / BtnSalvarClick / BtnBuscarClick
    * Sem registro a manter nesta tela: devolvem o foco a unica entrada de
    * dados existente (Rede TEF), de onde partem as quatro acoes do legado.
    *==========================================================================
    PROCEDURE BtnIncluirClick
        THIS.FocarEntradaTef()
    ENDPROC

    PROCEDURE BtnAlterarClick
        THIS.FocarEntradaTef()
    ENDPROC

    PROCEDURE BtnSalvarClick
        THIS.FocarEntradaTef()
    ENDPROC

    PROCEDURE BtnBuscarClick
        THIS.FocarEntradaTef()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - esta tela nao tem registro para visualizar.
    * O painel de texto da transacao (cnt_4c_TefTxt) e governado EXCLUSIVAMENTE
    * por ProcCntTxt, que reproduz o fluxo do legado (inclusive o 'If !empty()'
    * por mensagem e a sobrescrita do caption de TxtCli). Forcar .Visible aqui
    * exibiria painel vazio ou desatualizado, divergindo do legado.
    *==========================================================================
    PROCEDURE BtnVisualizarClick
        THIS.FocarEntradaTef()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick / BtnCancelarClick
    * O legado nao tem Excluir, e o "Cancelar" dele (Command1) eh CANCELAMENTO
    * DE TRANSACAO TEF, nao cancelamento de edicao - ja ligado ao proprio botao
    * em ConfigurarEventos. Estes dois aliases tambem NAO podem fechar a tela:
    * "Excluir"/"Cancelar" acionado por NOME derrubaria a janela do operador,
    * o mesmo tipo de efeito colateral invisivel que esta secao proibe para as
    * acoes TEF. Ficam inertes, como os demais aliases: so devolvem o foco.
    *==========================================================================
    PROCEDURE BtnExcluirClick
        THIS.FocarEntradaTef()
    ENDPROC

    PROCEDURE BtnCancelarClick
        THIS.FocarEntradaTef()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - alias do botao REAL "Encerrar" do legado (Sair.Click),
    * unico nome CRUD cuja acao coincide com um botao existente na tela.
    *==========================================================================
    PROCEDURE BtnEncerrarClick
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    * FocarEntradaTef - devolve o foco ao campo Rede TEF
    *==========================================================================
    PROCEDURE FocarEntradaTef
        IF VARTYPE(THIS.txt_4c_Redetef) = "O"
            IF THIS.txt_4c_Redetef.Enabled AND THIS.txt_4c_Redetef.Visible
                THIS.txt_4c_Redetef.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormParaBO
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cRedeTef = ;
                IIF(VARTYPE(THIS.txt_4c_Redetef) = "O", ;
                    ALLTRIM(THIS.txt_4c_Redetef.Value), "")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE BOParaForm
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            IF VARTYPE(THIS.txt_4c_Redetef) = "O"
                THIS.txt_4c_Redetef.Value = ;
                    IIF(EMPTY(THIS.this_oBusinessObject.this_cRedeTef), ;
                        "", THIS.this_oBusinessObject.this_cRedeTef)
                THIS.txt_4c_Redetef.Refresh()
            ENDIF
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
    *==========================================================================
        LOCAL loc_lHab, loc_lAdm, loc_lAtv
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        *-- Estado TEF vem do BO, escrito por InicializarEstadoTEF (fonte unica).
        *-- Guard de VARTYPE obrigatorio: sem BO criado, ler a property estoura.
        loc_lAdm = .F.
        loc_lAtv = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            WITH THIS.this_oBusinessObject
                loc_lAdm = .this_lInicializado AND .this_lAcessoAdm
                loc_lAtv = .this_lInicializado AND .this_lAcessoAtv
            ENDWITH
        ENDIF

        IF VARTYPE(THIS.txt_4c_Redetef) = "O"
            THIS.txt_4c_Redetef.Enabled = loc_lHab
        ENDIF
        *-- Mesma condicao do legado (fChecaAcesso AND ok), agora preservada
        *-- na reabilitacao em vez de desligar os dois botoes de acao.
        IF VARTYPE(THIS.cmd_4c_TefAdm) = "O"
            THIS.cmd_4c_TefAdm.Enabled = loc_lHab AND loc_lAdm
        ENDIF
        IF VARTYPE(THIS.cmd_4c_TefAtv) = "O"
            THIS.cmd_4c_TefAtv.Enabled = loc_lHab AND loc_lAtv
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE LimparCampos
    *==========================================================================
        IF VARTYPE(THIS.txt_4c_Redetef) = "O"
            THIS.txt_4c_Redetef.Value = ""
            THIS.txt_4c_Redetef.Refresh()
        ENDIF
        IF VARTYPE(THIS.cnt_4c_TefTxt) = "O"
            WITH THIS.cnt_4c_TefTxt
                IF VARTYPE(.lbl_4c_TxtOper) = "O"
                    .lbl_4c_TxtOper.Caption = ""
                ENDIF
                IF VARTYPE(.lbl_4c_TxtCli) = "O"
                    .lbl_4c_TxtCli.Caption = ""
                ENDIF
                IF VARTYPE(.lbl_4c_TxtTpTrans) = "O"
                    .lbl_4c_TxtTpTrans.Caption = ""
                ENDIF
                .Visible = .F.
            ENDWITH
        ENDIF
        IF USED("CrTefImp")
            USE IN CrTefImp
        ENDIF
        IF USED("CrTefResp")
            USE IN CrTefResp
        ENDIF
        IF USED("CrTef")
            USE IN CrTef
        ENDIF
        IF USED("crSigFiTra")
            USE IN crSigFiTra
        ENDIF
        IF USED("CrSigFiNfs")
            USE IN CrSigFiNfs
        ENDIF
        IF USED("csSigFiTef")
            USE IN csSigFiTef
        ENDIF
        IF USED("crTmpNFis")
            USE IN crTmpNFis
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cRedeTef = ""
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista
    *==========================================================================
        *-- Form OPERACIONAL TEF: sem lista de registros CRUD.
        *-- InicializarEstadoTEF gerencia o carregamento de dados transacionais.
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE AjustarBotoesPorModo
    *==========================================================================
        *-- Form OPERACIONAL TEF: sem modos CRUD (INCLUIR/ALTERAR/VISUALIZAR).
        *-- Ainda assim este eh o FUNIL de reabilitacao (regra #40): recalcula
        *-- a condicao do legado (fChecaAcesso AND impressora OK) a partir do
        *-- estado guardado no BO, sem efeito colateral e sem transacao TEF.
        THIS.HabilitarCampos(.T.)
        RETURN .T.
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprtefBO.prg):
*==============================================================================
* sigprtefBO.prg - Business Object para Administracao do TEF
* Fase 1/8 - Propriedades e Init
*==============================================================================
DEFINE CLASS sigprtefBO AS BusinessBase

    *-- Identificacao da operacao TEF
    this_cOperacao      = ""    && Operacao TEF atual (PADR NoCaixa+NoFab+'ADM', 20 chars)
    this_cNoCaixa       = ""    && Numero do caixa fiscal (crSigFiMpf.cnCaixas)
    this_cNoFab         = ""    && Numero de fabricacao da impressora fiscal (LeituraFab)
    this_cPcIdChaves    = ""    && Chaves de identificacao da transacao TEF (param Init)

    *-- Parametros do sistema TEF carregados de SigCdPam
    this_nSistef        = 0     && Tipo sistema TEF: 1=SiTef/Autoritec, 3=VeriFone
    this_cImps          = ""    && Modelo impressora fiscal (ex: SWEDA) de crSigFiFis

    *-- Campo de busca / validacao TEF
    this_cRedeTef       = ""    && Comprovante / rede TEF selecionada (Get_redetef)

    *-- Flags de controle de acesso e estado
    this_lAcessoAdm     = .F.   && Acesso habilitado para operacao Admin TEF
    this_lAcessoAtv     = .F.   && Acesso habilitado para verificacao TEF Ativo
    this_lInicializado  = .F.   && Inicializacao concluida com sucesso (impressora OK)

    PROCEDURE Init()
        this_cTabela     = ""
        this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir do cursor coSigCdPam
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                this_nSistef = NVL(Sistef, 0)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador da operacao TEF corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN this_cOperacao
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel para form OPERACIONAL TEF
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para form OPERACIONAL TEF (usar AtualizarStatusTef)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao TEF em LogAuditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, Usuario, DataHora, ChaveRegistro) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigFiTef") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosTEF - Carrega Sistef de SigCdPam e popula this_nSistef
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosTEF()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("coSigCdPam")
                USE IN coSigCdPam
            ENDIF
            loc_cSQL = "SELECT Sistef FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "coSigCdPam") > 0
                SELECT coSigCdPam
                GOTO TOP
                IF !EOF()
                    this_nSistef = NVL(Sistef, 0)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar par" + CHR(226) + "metros TEF de SigCdPam", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImpressoraFiscal - Carrega SigFiMpF pelo numero de fabricacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarImpressoraFiscal(par_cNoFab)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("crSigFiMpF")
                USE IN crSigFiMpF
            ENDIF
            loc_cSQL = "SELECT cnCaixas FROM SigFiMpF"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiMpF") > 0
                SELECT crSigFiMpF
                GOTO TOP
                IF !EOF()
                    this_cNoCaixa = NVL(cnCaixas, "")
                    this_cNoFab   = ALLTRIM(par_cNoFab)
                    loc_lSucesso  = .T.
                ELSE
                    MsgAviso("Impressora Fiscal Inv" + CHR(225) + "lida para esta Loja !!", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarComprovantes - Busca comprovantes TEF em SigFiNfs por modelo impressora
    *--------------------------------------------------------------------------
    PROCEDURE BuscarComprovantes(par_cImps)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("CrSigFiNfs")
                USE IN CrSigFiNfs
            ENDIF
            loc_cSQL = "SELECT * FROM SigFiNfs WHERE Imps = " + EscaparSQL(ALLTRIM(par_cImps))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigFiNfs") > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha na Conex" + CHR(227) + "o ao buscar comprovantes TEF", "Falha na Conex" + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarNFiscalPorComprovante - Busca SigFiNfs por Imps e cComprovs
    *--------------------------------------------------------------------------
    PROCEDURE BuscarNFiscalPorComprovante(par_cImps, par_cComprovs)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("crTmpNFis")
                USE IN crTmpNFis
            ENDIF
            loc_cSQL = "SELECT Imps, cComprovs, cTefdReqs, cTefdResps, nQtdVias " + ;
                       "FROM SigFiNfs " + ;
                       "WHERE Imps = " + EscaparSQL(ALLTRIM(par_cImps)) + ;
                       " AND cComprovs = " + EscaparSQL(ALLTRIM(par_cComprovs))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpNFis") > 0
                SELECT crTmpNFis
                GOTO TOP
                loc_lSucesso = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTransacaoTEF - Busca SigFiTef pelos campos chave (tipo/empresa/operacao/ident)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTransacaoTEF(par_cTipo, par_cEmps, par_cDopes, par_cIdents)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("crSigFiTef")
                USE IN crSigFiTef
            ENDIF
            loc_cSQL = "SELECT cTipos, cEmps, cDopes, cnIdents, cNmRedes, cnNSUs, " + ;
                       "cFinalzs, cCupomnvs, FPags, cnNSUCancs, cnValors, " + ;
                       "cTxtOpers, cTxtClis, cIdChaves, cStatus, cHeaders, cnCupoms " + ;
                       "FROM SigFiTef " + ;
                       "WHERE cnIdents = " + EscaparSQL(par_cIdents)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiTef") > 0
                SELECT crSigFiTef
                GOTO TOP
                loc_lSucesso = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTransacaoPorIdChaves - Busca SigFiTef por cIdChaves
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTransacaoPorIdChaves(par_cIdChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("csSigFiTef")
                USE IN csSigFiTef
            ENDIF
            loc_cSQL = "SELECT cTipos, cEmps, cDopes, cnIdents, cNmRedes, cnNSUs, " + ;
                       "cFinalzs, cCupomnvs, FPags, cnNSUCancs, cnValors, " + ;
                       "cTxtOpers, cTxtClis, cIdChaves, cStatus, cHeaders, cnCupoms " + ;
                       "FROM SigFiTef " + ;
                       "WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "csSigFiTef") > 0
                SELECT csSigFiTef
                GOTO TOP
                loc_lSucesso = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarStatusTef - UPDATE SigFiTef SET cStatus por cIdChaves
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarStatusTef(par_cIdChaves, par_cStatus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = " + EscaparSQL(par_cStatus) + ;
                       " WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar status TEF por cIdChaves", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarStatusTefPorRede - UPDATE SigFiTef SET cStatus por cnmredes/cnnsus (CRT)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarStatusTefPorRede(par_cNmRedes, par_cNSUs, par_cStatus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = " + EscaparSQL(par_cStatus) + ;
                       " WHERE cnmredes = " + EscaparSQL(par_cNmRedes) + ;
                       " AND cnnsus = " + EscaparSQL(par_cNSUs) + ;
                       " AND cHeaders = 'CRT'"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar status TEF por rede", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarStatusTefPorIdents - UPDATE SigFiTef SET cStatus por cnIdents
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarStatusTefPorIdents(par_cIdents, par_cStatus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = " + EscaparSQL(par_cStatus) + ;
                       " WHERE cnIdents = " + EscaparSQL(par_cIdents)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar status TEF por cnIdents", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

