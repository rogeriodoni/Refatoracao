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
[2026-11-09 09:11:50] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-09 09:11:50] [INFO] Config FPW: (nao fornecido)
[2026-11-09 09:11:51] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-09 09:11:52] [INFO] Timeout: 300 segundos
[2026-11-09 09:11:52] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ssenyoy5.prg
[2026-11-09 09:11:52] [INFO] Conteudo do wrapper:
[2026-11-09 09:11:52] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpMpn', 'C:\4c\tasks\task769\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpMpn', 'C:\4c\tasks\task769\logs\06_testForm.log'
QUIT

[2026-11-09 09:11:53] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ssenyoy5.prg
[2026-11-09 09:11:53] [INFO] VFP output esperado em: C:\4c\tasks\task769\vfp_output.txt
[2026-11-09 09:11:53] [INFO] Executando Visual FoxPro 9...
[2026-11-09 09:11:54] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ssenyoy5.prg
[2026-11-09 09:11:54] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ssenyoy5.prg
[2026-11-09 09:11:55] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpMpn
Inicio: 09/11/2026 09:11:56

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 09/11/2026 09:13:21
Duracao: 85 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-09 09:13:21] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-09 09:13:21] [INFO] VFP9 finalizado em 87.0451193 segundos
[2026-11-09 09:13:21] [INFO] Exit Code: 
[2026-11-09 09:13:21] [INFO] 
[2026-11-09 09:13:21] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-09 09:13:22] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ssenyoy5.prg
[2026-11-09 09:13:22] [INFO] 
[2026-11-09 09:13:22] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-09 09:13:22] [INFO] * Auto-generated wrapper for parameters
[2026-11-09 09:13:23] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-09 09:13:23] [INFO] * Parameters: 'FormSigOpMpn', 'C:\4c\tasks\task769\logs\06_testForm.log'
[2026-11-09 09:13:24] [INFO] 
[2026-11-09 09:13:24] [INFO] * Anti-dialog protections for unattended execution
[2026-11-09 09:13:24] [INFO] SET SAFETY OFF
[2026-11-09 09:13:25] [INFO] SET RESOURCE OFF
[2026-11-09 09:13:25] [INFO] SET TALK OFF
[2026-11-09 09:13:25] [INFO] SET NOTIFY OFF
[2026-11-09 09:13:26] [INFO] SYS(2335, 0)
[2026-11-09 09:13:26] [INFO] 
[2026-11-09 09:13:26] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpMpn', 'C:\4c\tasks\task769\logs\06_testForm.log'
[2026-11-09 09:13:27] [INFO] QUIT
[2026-11-09 09:13:27] [INFO] 
[2026-11-09 09:13:27] [INFO] === Fim do Wrapper.prg ===
[2026-11-09 09:13:27] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpMpn.prg):
*==============================================================================
* FormSigOpMpn.prg - Movimentacoes de Subnivel em Aberto (SigCdNec)
* Origem: tasks/task769/SigOpMpn.SCX (SIGOPMPN)
* Herda de: FormBase
*
* Tipo: OPERACIONAL (dialogo filho, mesma familia de FormSigOpMpd.prg -
* aberto por um form pai que esta montando uma operacao, para o usuario
* marcar/desmarcar quais pendencias de subnivel de uma "necessidade"
* (SigCdNec) entram na operacao). NAO segue o padrao Page1=Lista/
* Page2=Dados do CRUD: layout FLAT, filhos DIRETOS do form (cabecalho +
* grade de selecao TmpPends + grades de itens/total + botoes), igual ao
* SCX legado (sem PageFrame nenhum) - mesma decisao de FormSigOpMpd.prg.
*
* DataSession=1 (compartilhada) - DESVIO DELIBERADO do SCX legado, que
* declara DataSession=2 (privada) mas, logo no inicio do Init, executa
* "Set DataSession To DatSes" para trocar para a sessao do form PAI ANTES
* de criar TmpPends/xPNensi/xPNensiT - ou seja, na pratica o legado
* tambem roda na sessao do chamador, nao na propria. Aqui isso e
* replicado deixando o form inteiro na sessao compartilhada (1), mesmo
* padrao de FormSigOpMpd.prg/FormSigOpLrC.prg/Formsigopagr.prg: assim
* TmpNens/TmpOperacao/xMFas/xOpi/xPesa/xNensi, mantidos abertos pelo form
* pai, ficam visiveis aqui pelo NOME, sem precisar emular "Set
* DataSession To <numero>" (sem equivalente nesta arquitetura).
*
* Aberto com: CREATEOBJECT("FormSigOpMpn", oFormPai)
*
* Parametros de Init (equivalentes ao legado "LParameters pForm, DatSes,
* Operacao"):
*   par_oFormPai - pForm: form chamador. Guardado em this_oFormPai; o
*                  legado tambem copia This.pEmps/This.pcEscolha dele no
*                  Init (aqui: this_oBusinessObject.this_cEmpresa e
*                  this_cModoAtual) e o reabilita no fechamento
*                  (ThisForm.ParentForm.Enabled = .t., replicado em
*                  Destroy() - mesmo padrao de FormSigOpMpd.prg).
*   par_nDataSession - DatSes (DataSessionId do pai): sem equivalente
*                  nesta arquitetura (DataSession=1 compartilhada
*                  substitui, ver nota acima). Recebido so por fidelidade
*                  de assinatura - nunca lido.
*   par_cOperacao - Operacao: recebido pelo LParameters legado mas NUNCA
*                  referenciado no corpo do Init (confirmado por grep no
*                  dump inteiro - unico ponto onde o nome aparece e a
*                  propria declaracao do parametro). Parametro morto no
*                  legado - recebido aqui so por fidelidade de assinatura.
*
* Historico de fases:
*   Fase 1/2: SigOpMpnBO.prg (propriedades, Init, ObterChavePrimaria,
*             CarregarDoCursor, Atualizar).
*   Fase 3:   FormSigOpMpn.prg - estrutura base (Init, InicializarForm,
*             ConfigurarCabecalho, Destroy).
*   Fase 4:   grd_4c_Grade (TmpPends, selecao), grd_4c_Itens/grd_4c_Total
*             (xPNensi/xPNensiT, detalhe) e os botoes de acao (cmd_4c_Ok/
*             cmd_4c_SelTudo/cmd_4c_Apaga/cmd_4c_Totaliza), MAIS a carga e
*             o vinculo das tres grades (CarregarGrade/CarregarLista +
*             SigOpMpnBO.CarregarPendencias, que cria os tres cursores e
*             popula TmpPends/xPNensi/xPNensiT). A montagem visual
*             (Configurar*) e o bind (Carregar*) ficam SEPARADOS por causa
*             da regra #41 - Column.ControlSource de cursor que ainda nao
*             existe derruba o Init -, mas rodam na MESMA ordem do Init
*             legado: monta, cria cursor, liga.
*
*   Fase 5:   lbl_4c_Label1 + txt_4c_OpSubNivel (Nivels do nivel para o
*             qual a movimentacao de subnivel esta indo - legado:
*             "ThisForm.OpSubNivel.Value = crSigCdOpd.Nivels", calculado
*             em CarregarGrade() a partir de TmpNens.Dopps/crSigCdOpd -
*             cursor do form pai e cursor global, ambos visiveis aqui
*             pelo nome por causa da DataSession=1 compartilhada).
*   Fase 6:   lbl_4c__Procura/txt_4c_Procura (busca incremental por Numps
*             na grade de selecao - legado: Say_Procura/Get_Procura.Valid/
*             LostFocus, transcritos em ValidarProcuraNumero/
*             TxtProcuraKeyPress/TxtProcuraLostFocus porque BINDEVENT
*             "Valid" nao funciona em TextBox, regra do projeto - KeyPress
*             com ENTER/TAB simula o Valid) e obj_4c_Mm_obs (EditBox
*             read-only, legado: ControlSource = TmpPends.Obss, ligado em
*             CarregarGrade() pelo mesmo motivo de regra #41 das grades -
*             TmpPends ainda nao existe no momento do AddObject).
*   Fase 7:   GarantirCheckBoxSelecionar() + ChkSelecionarInteractiveChange
*             (toggle da coluna de selecao - legado: fwcheckbox1.
*             InteractiveChange -> ThisForm.Marca()/Desmarca), CmdSelTudoClick/
*             CmdApagaClick (Marca/Desmarca em lote - legado: SelTudo.Click/
*             apaga.Click), CmdTotalizaClick (alterna grd_4c_Itens com
*             grd_4c_Total via this_nContador - legado: Totaliza.Click) e
*             GradeAfterRowColChange (reaplica o "Set Key To" das duas
*             grades de detalhe quando o usuario troca de pendencia -
*             regra #46: sem filtro de coluna, porque recarrega o DETALHE
*             da linha corrente). ConfigurarEventosGrade liga tambem o
*             GotFocus das colunas de exibicao (Usuario/data/Grupo/Conta/
*             Peso) a FocarColunaSelecao, que redireciona sempre para o
*             CheckBox (legado: "ThisForm.Grade.Seleciona.fwcheckbox1.
*             SetFocus" incondicional - mesmo padrao de FormSigOpMpd.prg).
*   Fase 8:   CmdOkClick (o "ok" legado - grava via SigOpMpnBO.
*             ConfirmarMovimentacoes, que povoa xMFas/xOpi/xNensi do form
*             pai e atualiza SigCdNec.ChkSubn, e so fecha o dialogo em
*             caso de sucesso), FecharDialogo/BtnEncerrarClick/
*             BtnCancelarClick (os tres nomes canonicos do projeto
*             convergindo no MESMO funil - o legado nao oferece saida sem
*             gravar: ControlBox=.F., Closable=.F., sem ESC) e Destroy
*             (reabilita o form pai, libera o BO, fecha os cursores
*             PROPRIOS desta tela - TmpPends/xPNensi/xPNensiT - e chama
*             DODEFAULT() por ultimo, regra do projeto sobre os popups do
*             menu principal).
*==============================================================================

DEFINE CLASS FormSigOpMpn AS FormBase

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPMPN;
    *-- WindowState nao tem equivalente direto de uso no projeto e fica
    *-- no default do VFP, igual aos demais dialogos desta familia)
    Height       = 600
    Width        = 1000
    AutoCenter   = .T.
    BorderStyle  = 2
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    AlwaysOnTop  = .F.
    ShowTips     = .T.
    DataSession  = 1
    Caption      = "Movimenta" + CHR(231) + CHR(245) + "es Pendentes"

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Form chamador (equivalente a pForm/ParentForm do Init legado)
    this_oFormPai = .NULL.

    *-- Modo de operacao do dialogo: COPIA do modo do form pai tirada no
    *-- Init (legado: This.pcEscolha = ThisForm.ParentForm.pcEscolha).
    *-- Valores do projeto ("INCLUIR"/"ALTERAR"/"VISUALIZAR"/"LISTA") no
    *-- lugar dos termos Fortyus 'INSERIR'/'ALTERAR'/'PROCURAR' - usado
    *-- pelas fases seguintes para o When/Visible de SelTudo/Apaga/
    *-- Totaliza e pelo ReadOnly da coluna de selecao da grade (mesmo
    *-- padrao de FormSigOpMpd.prg.this_cModoAtual).
    this_cModoAtual = ""

    *-- Contador auxiliar (equivalente a ThisForm.contador do Init
    *-- legado, 0 na abertura): alterna, no botao Totaliza (fase
    *-- seguinte), qual das duas grades - itens (Gradeitem) ou total
    *-- (GradeTotal) - esta visivel.
    this_nContador = 0

    *--------------------------------------------------------------------------
    * Init - recebe o form chamador (e os dois parametros legados sem
    * equivalente nesta arquitetura - ver nota no cabecalho), copia
    * Empresa/Modo do pai, cria o Business Object e delega a
    * FormBase.Init() (que chama THIS.InicializarForm() via DODEFAULT()).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_nDataSession, par_cOperacao)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai
                IF PEMSTATUS(par_oFormPai, "this_cModoAtual", 5)
                    THIS.this_cModoAtual = par_oFormPai.this_cModoAtual
                ENDIF
            ENDIF

            THIS.this_nContador = 0

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpMpnBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object SigOpMpnBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSigOpMpn.Init")
            ELSE
                *-- Legado: ThisForm.pEmps = ThisForm.ParentForm.pEmps -
                *-- copia simples da empresa do form pai, guardada no BO
                *-- (this_cEmpresa ja existe la - ver cabecalho de
                *-- SigOpMpnBO.prg)
                IF VARTYPE(par_oFormPai) = "O" AND PEMSTATUS(par_oFormPai, "this_cEmpresa", 5)
                    THIS.this_oBusinessObject.this_cEmpresa = par_oFormPai.this_cEmpresa
                ENDIF

                *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - fundo do form + cabecalho (SIGOPMPN.cntSombra do
    * dump). Grade de selecao, grades de itens/total e botoes de acao sao
    * das fases seguintes (regra #41 - Column.ControlSource de cursor que
    * ainda nao existe derruba o Init; esses cursores so nascem quando o
    * metodo de carga da Fase 4 roda). Chamado automaticamente por
    * FormBase.Init() via DODEFAULT().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.LockScreen = .T.

            *-- Fundo do form (imagem do Framework Fortyus legado:
            *-- "..\framework\imagens\new_background.jpg" no SCX)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Ordem identica ao dump legado (SECAO 1 - arvore de
            *-- objetos): cntSombra e o primeiro objeto da arvore
            THIS.ConfigurarCabecalho()

            *-- Grade de selecao (TmpPends) + grades de detalhe (xPNensi/
            *-- xPNensiT) + botoes de acao (ok/SelTudo/Apaga/Totaliza) -
            *-- so a ESTRUTURA visual, SEM RecordSource/ControlSource
            *-- (regra #41: Column.ControlSource de cursor que ainda nao
            *-- existe derruba o Init e a tela nao abre). Mesma divisao de
            *-- FormSigOpMpd.prg.
            THIS.ConfigurarGrade()
            THIS.ConfigurarGradesDetalhe()
            THIS.ConfigurarBotoesAcao()
            THIS.ConfigurarEventosBotoes()
            THIS.ConfigurarEventosGrade()

            *-- Label1 + OpSubNivel (SIGOPMPN.Label1/OpSubNivel do dump) -
            *-- so ESTRUTURA visual aqui; o valor de txt_4c_OpSubNivel eh
            *-- preenchido em CarregarGrade() (depende de TmpNens, que e'
            *-- do form pai - mesma razao de ConfigurarGrade/CarregarGrade
            *-- estarem separados, regra #41)
            THIS.ConfigurarCamposComplementares()

            *-- E so DEPOIS a carga, que cria os tres cursores e liga as
            *-- grades (legado: tudo isso acontece dentro do MESMO Init,
            *-- nesta ordem - montagem, Create Cursor, bind). CarregarGrade
            *-- ja chama AjustarBotoesPorModo no fim, porque a visibilidade
            *-- de SelTudo/Apaga/Totaliza depende do SepPedras do nivel,
            *-- que so eh conhecido depois de consultar crSigCdOpd.
            THIS.CarregarGrade()

            THIS.LockScreen = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - faixa escura de titulo (SIGOPMPN.cntSombra do
    * dump), com os dois labels sobrepostos (lblSombra = sombra preta,
    * lblTitulo = titulo branco por cima - mesmo padrao de
    * FormSigOpMpd.prg/FormSigOpLrC.prg/Formsigopagr.prg). Caption dos
    * dois labels recebe a propriedade Caption do form - legado:
    * ThisForm.cntSombra.lblSombra e lblTitulo.Caption = ThisForm.Caption,
    * feito no inicio do Init. Largura em THIS.Width (nao o literal 1100
    * do dump, maior que o Form.Width=1000 do proprio SCX) - regra do
    * projeto sobre container de cabecalho (CLAUDE.md regra #11/#30).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = THIS.cnt_4c_Sombra
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize      = .F.
            .Top           = 18
            .Left          = 10
            .Width         = loc_oCab.Width - 20
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .Top         = 17
            .Left        = 10
            .Width       = loc_oCab.Width - 20
            .Height      = 46
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .WordWrap    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption     = THIS.Caption
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - grade de selecao (SIGOPMPN.Grade do dump, 7
    * colunas: seleciona/Usuario/codigo/data/Grupo/Conta/Peso). So a
    * ESTRUTURA visual: RecordSource/ControlSource de TmpPends ficam no
    * metodo de carga de dados (fase posterior - TmpPends nao existe
    * ainda, regra #41). ColumnOrder reproduz a ordem VISUAL do dump
    * (diferente da ordem de declaracao das Columns).
    *
    * Column1 "seleciona" embute um CheckBox no legado (fwcheckbox1,
    * ControlSource = TmpPends.Flag - Logico). O AddObject do CheckBox
    * fica para quando Column1.ControlSource apontar para uma coluna
    * Logica de verdade (regra #18 + nota de GarantirCheckBoxSelecionar
    * em FormSigOpMpd.prg, mesma familia de tela) - aqui so o
    * .ReadOnly de nascimento, espelhando o When do legado (fwcheckbox1.
    * When: Return (pcEscolha = 'INSERIR')).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.AddObject("grd_4c_Grade", "Grid")

        WITH THIS.grd_4c_Grade
            .Top               = 118
            .Left              = 12
            .Width             = 668
            .Height            = 260
            .ColumnCount       = 7
            .FontName          = "Courier New"
            .AllowHeaderSizing = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            *-- Grid.ReadOnly propaga para as colunas - por isso vem ANTES
            *-- delas (regra do projeto)
            .ReadOnly          = .F.
            .Visible           = .T.
        ENDWITH

        *-- Column1 "seleciona" - ColumnOrder=1 (default)
        WITH THIS.grd_4c_Grade.Column1
            .Width     = 15
            .FontName  = "Courier New"
            .FontSize  = 9
            .Movable   = .F.
            .Resizable = .F.
            *-- valor de NASCIMENTO (legado: fwcheckbox1.When). A caixa
            *-- embutida (regra #18) so nasce quando TmpPends existir.
            .ReadOnly  = (THIS.this_cModoAtual != "INCLUIR")
        ENDWITH
        WITH THIS.grd_4c_Grade.Column1.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = ""
        ENDWITH

        *-- Column2 "Usuario" - ColumnOrder=7 (ultima coluna visivel)
        WITH THIS.grd_4c_Grade.Column2
            .Width       = 100
            .ColumnOrder = 7
            .FontName    = "Arial"
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column2.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Usu" + CHR(225) + "rio"
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        WITH THIS.grd_4c_Grade.Column2.Text1
            .FontName    = "Arial"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column3 "codigo" - ColumnOrder=2 (foco inicial do dialogo).
        *-- Legado: CurrentControl = "Ingrid1" (busca incremental por
        *-- Numps, classe propria de framework.vcx, sem porte nesta
        *-- arquitetura) - mantido como Text1 padrao da Column.
        WITH THIS.grd_4c_Grade.Column3
            .Width       = 80
            .ColumnOrder = 2
            .FontName    = "Arial"
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column3.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "C" + CHR(243) + "digo"
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        WITH THIS.grd_4c_Grade.Column3.Text1
            .FontName    = "Arial"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column4 "data" - ColumnOrder=3
        WITH THIS.grd_4c_Grade.Column4
            .Width       = 75
            .ColumnOrder = 3
            .FontName    = "Arial"
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column4.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Data"
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        WITH THIS.grd_4c_Grade.Column4.Text1
            .FontName    = "Arial"
            .FontSize    = 8
            .Alignment   = 3
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column5 "Grupo" (Grupo de Origem) - ColumnOrder=4
        WITH THIS.grd_4c_Grade.Column5
            .Width       = 130
            .ColumnOrder = 4
            .FontName    = "Arial"
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column5.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Grupo de Origem"
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        WITH THIS.grd_4c_Grade.Column5.Text1
            .FontName    = "Arial"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column6 "Conta" (Conta de Origem) - ColumnOrder=5
        WITH THIS.grd_4c_Grade.Column6
            .Width       = 130
            .ColumnOrder = 5
            .FontName    = "Arial"
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .F.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column6.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Conta de Origem"
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        WITH THIS.grd_4c_Grade.Column6.Text1
            .FontName    = "Arial"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .F.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column7 "Peso" (Total de Peso) - ColumnOrder=6, SEMPRE
        *-- ReadOnly (legado: Column.Peso.ReadOnly = .T.)
        WITH THIS.grd_4c_Grade.Column7
            .Width       = 100
            .ColumnOrder = 6
            .FontName    = "Arial"
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
        ENDWITH
        WITH THIS.grd_4c_Grade.Column7.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Total de Peso"
        ENDWITH
        WITH THIS.grd_4c_Grade.Column7.Text1
            .FontName    = "Arial"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradesDetalhe - grd_4c_Itens (SIGOPMPN.Gradeitem) e
    * grd_4c_Total (SIGOPMPN.GradeTotal), ambas com 9 colunas IDENTICAS
    * (mesmas ControlSource no legado: Nops/CMats/CGrus/CUnis/TpOps/Qtds/
    * Pesos/Cats/NEnvs - mesma ordem). So a ESTRUTURA visual aqui -
    * RecordSource/ControlSource ficam no metodo de carga (xPNensi/
    * xPNensiT nao existem ainda, regra #41).
    *
    * grd_4c_Total nasce Visible=.F. (legado, fim do Init:
    * "ThisForm.GradeTotal.Visible = .f."); o botao Totaliza alterna as
    * duas (fase de handlers - THIS.ok.Click do legado so chama Visible
    * em cascata, fica para CmdTotalizaClick em fase posterior).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradesDetalhe()
        *-- grd_4c_Itens (Gradeitem) ----------------------------------------
        THIS.AddObject("grd_4c_Itens", "Grid")

        WITH THIS.grd_4c_Itens
            .Top               = 383
            .Left              = 12
            .Width             = 668
            .Height            = 206
            .ColumnCount       = 9
            .FontSize          = 8
            .HeaderHeight      = 16
            .RowHeight         = 16
            .AllowHeaderSizing = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .F.
            .Visible           = .T.
        ENDWITH

        WITH THIS.grd_4c_Itens.Column1
            .Width     = 80
            .FontName  = "Courier New"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Format    = "L"
            .InputMask = "9999999999"
        ENDWITH
        WITH THIS.grd_4c_Itens.Column1.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Ordem Produ" + CHR(231) + CHR(227) + "o"
        ENDWITH
        WITH THIS.grd_4c_Itens.Column1.Text1
            .FontName    = "Courier New"
            .FontSize    = 8
            .BorderStyle = 0
            .Format      = "L"
            .InputMask   = "9999999999"
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Itens.Column2
            .Width     = 108
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH THIS.grd_4c_Itens.Column2.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Componente"
        ENDWITH
        WITH THIS.grd_4c_Itens.Column2.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Itens.Column3
            .Width       = 35
            .ColumnOrder = 4
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
        ENDWITH
        WITH THIS.grd_4c_Itens.Column3.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Grupo"
        ENDWITH
        WITH THIS.grd_4c_Itens.Column3.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Itens.Column4
            .Width       = 31
            .ColumnOrder = 7
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
        ENDWITH
        WITH THIS.grd_4c_Itens.Column4.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Unid."
        ENDWITH
        WITH THIS.grd_4c_Itens.Column4.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column5 "Tipo de Material" - SEM ReadOnly no dump (editavel)
        WITH THIS.grd_4c_Itens.Column5
            .Width       = 90
            .ColumnOrder = 5
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
        ENDWITH
        WITH THIS.grd_4c_Itens.Column5.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Tipo de Material"
        ENDWITH
        WITH THIS.grd_4c_Itens.Column5.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Itens.Column6
            .Width       = 60
            .ColumnOrder = 6
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
        ENDWITH
        WITH THIS.grd_4c_Itens.Column6.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Qtde."
        ENDWITH
        WITH THIS.grd_4c_Itens.Column6.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column7 "Peso Atual" - SEM ReadOnly no dump (editavel)
        WITH THIS.grd_4c_Itens.Column7
            .Width       = 80
            .ColumnOrder = 8
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
        ENDWITH
        WITH THIS.grd_4c_Itens.Column7.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Peso Atual"
        ENDWITH
        WITH THIS.grd_4c_Itens.Column7.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Itens.Column8
            .Width       = 31
            .ColumnOrder = 3
            .FontSize    = 8
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
        ENDWITH
        WITH THIS.grd_4c_Itens.Column8.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Cat."
        ENDWITH
        WITH THIS.grd_4c_Itens.Column8.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Itens.Column9
            .Width     = 69
            .FontSize  = 8
            .Movable   = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH THIS.grd_4c_Itens.Column9.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Envelope"
        ENDWITH
        WITH THIS.grd_4c_Itens.Column9.Text1
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- grd_4c_Total (GradeTotal) - mesma estrutura, Visible=.F. ------
        THIS.AddObject("grd_4c_Total", "Grid")

        WITH THIS.grd_4c_Total
            .Top               = 383
            .Left              = 12
            .Width             = 688
            .Height            = 206
            .ColumnCount       = 9
            .AllowHeaderSizing = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .F.
            .Visible           = .F.
        ENDWITH

        WITH THIS.grd_4c_Total.Column1
            .Width     = 107
            .FontName  = "Courier New"
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Visible   = .T.
            .Format    = "L"
            .InputMask = "9999999999"
        ENDWITH
        WITH THIS.grd_4c_Total.Column1.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Ordem Fabrica" + CHR(231) + CHR(227) + "o"
        ENDWITH
        WITH THIS.grd_4c_Total.Column1.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Format      = "L"
            .InputMask   = "9999999999"
            .Margin      = 0
            .ReadOnly    = .T.
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Total.Column2
            .Width     = 108
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH
        WITH THIS.grd_4c_Total.Column2.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Componente"
        ENDWITH
        WITH THIS.grd_4c_Total.Column2.Text1
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Total.Column3
            .Width       = 35
            .ColumnOrder = 4
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH
        WITH THIS.grd_4c_Total.Column3.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Grupo"
        ENDWITH
        WITH THIS.grd_4c_Total.Column3.Text1
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Total.Column4
            .Width       = 31
            .ColumnOrder = 7
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH
        WITH THIS.grd_4c_Total.Column4.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Uni"
        ENDWITH
        WITH THIS.grd_4c_Total.Column4.Text1
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column5 "Tipo de Material" - SEM ReadOnly no dump (editavel)
        WITH THIS.grd_4c_Total.Column5
            .Width       = 97
            .ColumnOrder = 5
            .Movable     = .F.
            .Resizable   = .F.
            .Visible     = .T.
        ENDWITH
        WITH THIS.grd_4c_Total.Column5.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Tipo de Material"
        ENDWITH
        WITH THIS.grd_4c_Total.Column5.Text1
            .BorderStyle = 0
            .Margin      = 0
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Total.Column6
            .Width       = 68
            .ColumnOrder = 6
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH
        WITH THIS.grd_4c_Total.Column6.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Qtde"
        ENDWITH
        WITH THIS.grd_4c_Total.Column6.Text1
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column7 "Peso Atual" - SEM ReadOnly no dump (editavel)
        WITH THIS.grd_4c_Total.Column7
            .Width       = 80
            .ColumnOrder = 8
            .Movable     = .F.
            .Resizable   = .F.
            .Visible     = .T.
        ENDWITH
        WITH THIS.grd_4c_Total.Column7.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Peso Atual"
        ENDWITH
        WITH THIS.grd_4c_Total.Column7.Text1
            .BorderStyle = 0
            .Margin      = 0
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Total.Column8
            .Width       = 52
            .ColumnOrder = 3
            .Movable     = .F.
            .Resizable   = .F.
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH
        WITH THIS.grd_4c_Total.Column8.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Cat."
        ENDWITH
        WITH THIS.grd_4c_Total.Column8.Text1
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.grd_4c_Total.Column9
            .Width    = 71
            .Movable  = .F.
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH
        WITH THIS.grd_4c_Total.Column9.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "Envelope"
        ENDWITH
        WITH THIS.grd_4c_Total.Column9.Text1
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .Visible     = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - Shape1 (moldura decorativa, legado:
    * BackStyle=0 + BorderStyle=0, sem efeito visual - transcrito fiel)
    * + ok/SelTudo/apaga/Totaliza. Ordem identica ao dump (SECAO 1):
    * Shape1, SelTudo, apaga, ok, Totaliza - todos filhos diretos do
    * form, criados DEPOIS das grades.
    *
    * Tamanhos canonicos (fwbtnp=36x36 para icone 26px, fwbtng=75x75
    * para icone 60px - SCX nao declara Width/Height, propriedade da
    * classe de framework.vcx; mesmos valores de FormSigOpMpd.prg,
    * mesma familia de tela).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()

        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 818
            .Width       = 171
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- SelTudo (legado: fwbtnp) - marca todas as linhas de TmpPends
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top          = 145
            .Left         = 690
            .Width        = 36
            .Height       = 36
            .Caption      = ""
            .FontName     = "Verdana"
            .FontSize     = 8
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .T.
            .MousePointer = 15
            .ToolTipText  = "Seleciona Tudo"
            .Picture      = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
        ENDWITH

        *-- apaga (legado: fwbtnp) - desmarca todas as linhas de TmpPends
        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top          = 145
            .Left         = 731
            .Width        = 36
            .Height       = 36
            .Caption      = ""
            .FontName     = "Verdana"
            .FontSize     = 8
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .T.
            .MousePointer = 15
            .Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
        ENDWITH

        *-- ok (legado: fwbtng) - grava a movimentacao
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 925
            .Width           = 75
            .Height          = 75
            .Caption         = "OK"
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
            .ToolTipText     = "OK"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Visible         = .T.
        ENDWITH

        *-- Totaliza (legado: fwbtng) - alterna grd_4c_Itens/grd_4c_Total
        THIS.AddObject("cmd_4c_Totaliza", "CommandButton")
        WITH THIS.cmd_4c_Totaliza
            .Top             = 3
            .Left            = 850
            .Width           = 75
            .Height          = 75
            .Caption         = "Total"
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
            .ToolTipText     = "Total"
            .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
            .Visible         = .T.
        ENDWITH

        *-- legado (fim do Init): ThisForm.SelTudo.Visible / Apaga.
        *-- Visible / Totaliza.Visible atribuidos DEPOIS de os botoes
        *-- existirem
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosBotoes - BINDEVENT dos quatro botoes de acao
    * (ok/SelTudo/apaga/Totaliza). Handlers alvo sao PUBLIC de proposito -
    * BINDEVENT falha em silencio com metodo PROTECTED (regra #3).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosBotoes()
        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
        BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
        BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")
        BINDEVENT(THIS.cmd_4c_Totaliza, "Click", THIS, "CmdTotalizaClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosGrade - BINDEVENT do AfterRowColChange da grade de
    * selecao e do redirecionamento de foco das colunas de EXIBICAO
    * (Usuario/data/Grupo/Conta/Peso) para o CheckBox embutido na Column1 -
    * legado: GotFocus de cada uma chama "ThisForm.Grade.Seleciona.
    * fwcheckbox1.SetFocus" incondicionalmente. Column3 "codigo" NAO entra
    * aqui: eh o foco inicial natural do dialogo (Ingrid1/busca incremental
    * no legado), igual ao padrao de FormSigOpMpd.prg.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosGrade()
        BINDEVENT(THIS.grd_4c_Grade, "AfterRowColChange", THIS, "GradeAfterRowColChange")

        BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column4.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column5.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column6.Text1, "GotFocus", THIS, "FocarColunaSelecao")
        BINDEVENT(THIS.grd_4c_Grade.Column7.Text1, "GotFocus", THIS, "FocarColunaSelecao")
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Visible de SelTudo/Apaga/Totaliza (regra
    * #40: quem desabilita no funil, reabilita no funil - chamado de
    * novo pela fase que recarrega a grade, ja que RecordSource reseta
    * estado da Column mas nao destes botoes).
    *
    * Legado (fim do Init):
    *   ThisForm.SelTudo.Visible   = (pcEscolha = 'INSERIR')
    *   ThisForm.Apaga.Visible     = (pcEscolha = 'INSERIR')
    *   ThisForm.Totaliza.Visible  = (pcEscolha = 'INSERIR' And
    *                                 CrSigCdOpd.SepPedras = 4)
    *
    * CrSigCdOpd so fica POSICIONADO no "nivel" certo depois que o
    * metodo de carga da necessidade corrente roda (Seek(TmpPends.Dopps,
    * 'crSigCdOpd', 'Dopps') - mesmo Dopps que THIS.this_oBusinessObject.
    * this_cDopps guarda, da linha corrente de TmpPends via
    * CarregarDoCursor). Antes disso (TmpPends ainda vazio - esta fase),
    * this_cDopps esta vazio e Totaliza fica oculto - correto, nao eh
    * stub: o calculo e' real e so avalia .T. quando ha dado para
    * avaliar.
    *--------------------------------------------------------------------------
    *-- PUBLIC (regra #3): o harness de teste chama AjustarBotoesPorModo()
    *-- direto de fora da classe, e PEMSTATUS(oForm, <metodo>, 5) devolve .T.
    *-- mesmo para metodo PROTECTED (so testa existencia, nao escopo) - o
    *-- teste entraria no branch e a chamada falharia em runtime.
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lModoIncluir, loc_lSeparaPedras, loc_cAliasAnterior

        loc_lModoIncluir  = (THIS.this_cModoAtual == "INCLUIR")
        loc_lSeparaPedras = .F.

        *-- SepPedras vem do registro do NIVEL em SigCdOpd. Depois da carga
        *-- quem tem o valor autoritativo eh o BO (SigOpMpnBO.CarregarNivel
        *-- grava this_nSepPedras na SEGUNDA consulta, que eh justamente a
        *-- do nivel) - ler a property evita depender do ponteiro de um
        *-- cursor global estar parado no registro certo.
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
                PEMSTATUS(THIS.this_oBusinessObject, "this_nSepPedras", 5)
            loc_lSeparaPedras = (THIS.this_oBusinessObject.this_nSepPedras = 4)
        ENDIF

        *-- Fallback para antes da carga (property ainda em 0): le o cursor
        *-- global, como o legado faz
        IF !loc_lSeparaPedras AND USED("crSigCdOpd") AND ;
                VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
                !EMPTY(THIS.this_oBusinessObject.this_cDopps)
            loc_cAliasAnterior = ALIAS()

            IF SEEK(THIS.this_oBusinessObject.this_cDopps, "crSigCdOpd", "Dopps")
                loc_lSeparaPedras = (crSigCdOpd.SepPedras = 4)
            ENDIF

            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_SelTudo", 5)
            THIS.cmd_4c_SelTudo.Visible = loc_lModoIncluir
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Apaga", 5)
            THIS.cmd_4c_Apaga.Visible = loc_lModoIncluir
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Totaliza", 5)
            THIS.cmd_4c_Totaliza.Visible = (loc_lModoIncluir AND loc_lSeparaPedras)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposComplementares - Label1 + OpSubNivel (dump: filhos
    * DIRETOS do form, Top=89..93, Left=12..324 - a esquerda da grade de
    * selecao). txt_4c_OpSubNivel exibe o "Nivels" do nivel de DESTINO da
    * movimentacao de subnivel; o legado bloqueia o foco com "PROCEDURE
    * When / Return .f." (nunca editavel por teclado) - aqui reproduzido
    * com .ReadOnly = .T., que preserva a aparencia normal do TextBox (o
    * legado nao usa DisabledBackColor nem Enabled = .F. para este campo).
    *
    * So a ESTRUTURA visual: o Value de txt_4c_OpSubNivel e' calculado em
    * CarregarGrade() porque depende de TmpNens (cursor do form PAI,
    * visivel aqui por nome - DataSession=1 compartilhada) e crSigCdOpd
    * (cursor global), nenhum dos dois garantido no momento do Init.
    *
    * lbl_4c__Procura/txt_4c_Procura (SIGOPMPN.Say_Procura/Get_Procura do
    * dump) sao a busca incremental por Numps na grade de selecao - so a
    * ESTRUTURA aqui; o Valid/LostFocus legado vira ValidarProcuraNumero/
    * TxtProcuraKeyPress/TxtProcuraLostFocus (ver nota la). Os BINDEVENT
    * ficam AQUI (e nao em CarregarGrade) porque os handlers nao dependem
    * de TmpPends existir - so o CORPO deles consulta o cursor, com guarda
    * USED() (mesmo padrao do resto do form).
    *
    * obj_4c_Mm_obs (SIGOPMPN.mm_obs do dump) e' o EditBox de observacao -
    * SEMPRE ReadOnly = .T. no legado (simples exibicao, nunca editavel).
    * So a ESTRUTURA aqui: o ControlSource ("TmpPends.Obss") fica em
    * CarregarGrade() pela MESMA razao das colunas das grades (regra #41 -
    * TmpPends ainda nao existe neste ponto do Init).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposComplementares()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .F.
            .Top       = 93
            .Left      = 12
            .Width     = 136
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o de Subn" + CHR(237) + "vel :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_OpSubNivel", "TextBox")
        WITH THIS.txt_4c_OpSubNivel
            .Top       = 89
            .Left      = 150
            .Width     = 174
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .Format    = "K"
            .Value     = ""
            *-- legado: Procedure When / Return .f. - nunca recebe foco
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c__Procura (Say_Procura) - AutoSize do dump eh NO-OP em
        *-- Label criado por AddObject (regra #23): Width explicita =
        *-- Width do dump, Alignment = 0 (classe say, sem Alignment
        *-- declarado no dump)
        THIS.AddObject("lbl_4c__Procura", "Label")
        WITH THIS.lbl_4c__Procura
            .AutoSize  = .F.
            .Top       = 93
            .Left      = 524
            .Width     = 96
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Busca de  C" + CHR(243) + "digos :"
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Procura (Get_Procura) - numerico (Value=0 no dump),
        *-- MaxLength=6 transcrito literal; sem InputMask no dump (o
        *-- Value numerico ja restringe a digitos/sinal)
        THIS.AddObject("txt_4c_Procura", "TextBox")
        WITH THIS.txt_4c_Procura
            .Top         = 89
            .Left        = 622
            .Width       = 58
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Alignment   = 3
            .Format      = "K"
            .MaxLength   = 6
            .Value       = 0
            .ToolTipText = "Busca de C" + CHR(243) + "digos"
            .Visible     = .T.
        ENDWITH

        *-- KeyPress/LostFocus substituem Valid/LostFocus (BINDEVENT
        *-- "Valid" nao funciona em TextBox - regra do projeto)
        BINDEVENT(THIS.txt_4c_Procura, "KeyPress", THIS, "TxtProcuraKeyPress")
        BINDEVENT(THIS.txt_4c_Procura, "LostFocus", THIS, "TxtProcuraLostFocus")

        *-- obj_4c_Mm_obs (mm_obs) - ReadOnly = .T. de nascimento (igual ao
        *-- dump); ControlSource fica para CarregarGrade() (regra #41)
        THIS.AddObject("obj_4c_Mm_obs", "EditBox")
        WITH THIS.obj_4c_Mm_obs
            .Top               = 192
            .Left              = 690
            .Width             = 301
            .Height            = 184
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ReadOnly          = .T.
            .DisabledBackColor = RGB(255, 255, 220)
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarProcuraNumero - equivalente ao Valid legado de Get_Procura:
    *
    *   If Not Empty(This.Value)
    *       Select TmpPends / Set Order To Numps / Set Near On
    *       Seek This.Value / Set Near Off
    *       ThisForm.Refresh
    *       If (This.Value = TmpPends.Numps)
    *           This.Value = 0
    *       Else
    *           Return 0
    *       EndIf
    *   EndIf
    *
    * "Return 0" do Valid legado mantem o foco no campo (SET NEAR so achou
    * um vizinho, nao o Numps exato digitado) - aqui devolve .F. para o
    * KeyPress decidir com NODEFAULT (ver TxtProcuraKeyPress). THIS.Refresh()
    * repinta a grade de selecao (posicionada pelo SEEK) e obj_4c_Mm_obs
    * (ControlSource = TmpPends.Obss, muda com o registro corrente).
    *
    * PROTECTED: so chamado de dentro da classe (regra #51 - nao eh metodo
    * que precise ser alcancado de fora, diferente dos handlers de evento).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarProcuraNumero()
        LOCAL loc_lPodeSair, loc_cAliasPends, loc_cAliasAnterior, loc_nValor

        loc_lPodeSair   = .T.
        loc_cAliasPends = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cAliasPends = THIS.this_oBusinessObject.this_cCursorPends
        ENDIF

        IF !EMPTY(THIS.txt_4c_Procura.Value) AND !EMPTY(loc_cAliasPends) AND USED(loc_cAliasPends)
            loc_nValor         = THIS.txt_4c_Procura.Value
            loc_cAliasAnterior = ALIAS()

            SELECT (loc_cAliasPends)
            SET ORDER TO Numps
            SET NEAR ON
            SEEK loc_nValor
            SET NEAR OFF

            THIS.Refresh()

            IF loc_nValor = EVALUATE(loc_cAliasPends + ".Numps")
                THIS.txt_4c_Procura.Value = 0
            ELSE
                loc_lPodeSair = .F.
            ENDIF

            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF
        ENDIF

        RETURN loc_lPodeSair
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtProcuraKeyPress - PUBLIC (regra #3: alvo de BINDEVENT). Testa
    * ENTER(13)/TAB(9) para simular o Valid legado (BINDEVENT "Valid" nao
    * funciona em TextBox).
    *
    * TAB: quando ValidarProcuraNumero() devolve .F. (entrada invalida), o
    * NODEFAULT suprime a navegacao padrao do Tab - o campo continua com o
    * foco, igual ao "Return 0" do Valid legado.
    *
    * ENTER: diferente do Tab, Enter NAO move o foco por padrao no VFP9 -
    * sem este bloco extra o legado jamais chegaria a perder o foco so por
    * Enter, e TxtProcuraLostFocus (equivalente ao LostFocus legado) nunca
    * dispararia. Forcar o foco para a coluna de selecao aqui reproduz o
    * MESMO destino do LostFocus legado, so que pela via do Enter.
    *--------------------------------------------------------------------------
    PROCEDURE TxtProcuraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            IF !THIS.ValidarProcuraNumero()
                NODEFAULT
            ELSE
                IF par_nKeyCode = 13
                    NODEFAULT
                    THIS.FocarColunaSelecao()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtProcuraLostFocus - PUBLIC (regra #3: alvo de BINDEVENT). Equivalente
    * ao LostFocus legado de Get_Procura:
    *
    *   If (TmpPends.Numps = This.Value) Or (This.Value = 0)
    *       ThisForm.Grade.Seleciona.fwcheckbox1.SetFocus
    *   EndIf
    *
    * Dispara sempre que o campo perde o foco DE VERDADE (Tab, clique, ou o
    * SetFocus programatico que o proprio TxtProcuraKeyPress dispara no
    * caso do Enter) - complementa o Enter (que o KeyPress ja resolve
    * direto) cobrindo Tab/clique, que o legado tambem atende.
    *--------------------------------------------------------------------------
    PROCEDURE TxtProcuraLostFocus()
        LOCAL loc_cAliasPends, loc_lPodeFocar

        loc_cAliasPends = ""
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cAliasPends = THIS.this_oBusinessObject.this_cCursorPends
        ENDIF

        loc_lPodeFocar = (THIS.txt_4c_Procura.Value = 0)

        IF !loc_lPodeFocar AND !EMPTY(loc_cAliasPends) AND USED(loc_cAliasPends)
            loc_lPodeFocar = (EVALUATE(loc_cAliasPends + ".Numps") = THIS.txt_4c_Procura.Value)
        ENDIF

        IF loc_lPodeFocar
            THIS.FocarColunaSelecao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FocarColunaSelecao - PUBLIC (mesmo nome/padrao de FormSigOpMpd.prg,
    * mesma familia de tela - reutilizavel pelos GotFocus das colunas de
    * exibicao da grade, fase posterior). Redireciona o foco para o
    * CheckBox embutido na coluna de selecao, quando ele ja existe (so
    * nasce em GarantirCheckBoxSelecionar, chamado por CarregarGrade -
    * regra #18).
    *--------------------------------------------------------------------------
    PROCEDURE FocarColunaSelecao()
        IF PEMSTATUS(THIS, "grd_4c_Grade", 5) AND ;
                PEMSTATUS(THIS.grd_4c_Grade.Column1, "chk_4c_Selecionar", 5)
            THIS.grd_4c_Grade.Column1.chk_4c_Selecionar.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GarantirCheckBoxSelecionar - embute o CheckBox na coluna de selecao da
    * grade (legado: SIGOPMPN.Grade.seleciona.fwcheckbox1, ControlSource =
    * TmpPends.Flag).
    *
    * Vive separado de ConfigurarGrade porque so pode rodar DEPOIS de
    * Column1.ControlSource apontar para TmpPends.Flag, que eh Logico - e
    * TmpPends nasce na carga, nao na montagem da tela (regra #41). Alem
    * disso RecordSource RECRIA os objetos Column, entao a caixa tem de ser
    * reinstalada a CADA rebind: por isso o PEMSTATUS, que torna o metodo
    * idempotente.
    *
    * Os tres comandos sao inseparaveis (regra #18): AddObject so CRIA o
    * objeto - sem CurrentControl a coluna continua desenhando o Text1 dela,
    * e sem Sparse = .F. o CheckBox aparece apenas na linha ativa.
    *
    * O TOGGLE (Click/MouseDown/MouseUp/KeyPress com NODEFAULT, que eh como
    * o legado alterna o valor - ele SUPRIME o toggle nativo e faz o Replace
    * por codigo, ver SIGOPMPN.Grade.seleciona.fwcheckbox1.InteractiveChange
    * -> ThisForm.Marca/Desmarca) eh da fase de EVENTOS. Aqui NAO se chama
    * BINDEVENT: apontar para um handler que ainda nao existe estoura no
    * proprio bind.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GarantirCheckBoxSelecionar()
        LOCAL loc_oColuna
        loc_oColuna = THIS.grd_4c_Grade.Column1

        IF !PEMSTATUS(loc_oColuna, "chk_4c_Selecionar", 5)
            loc_oColuna.AddObject("chk_4c_Selecionar", "CheckBox")

            WITH loc_oColuna.chk_4c_Selecionar
                .Caption   = ""
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- legado: fwcheckbox1.InteractiveChange (=DoDefault() + If Not
            *-- This.Value / ThisForm.Desmarca / Else / This.Value =
            *-- ThisForm.Marca() / EndIf) - BINDEVENT dentro do MESMO IF: o
            *-- objeto so eh recriado quando RecordSource derruba a Column,
            *-- e um bind duplicado sobre o MESMO objeto empilharia o
            *-- handler
            BINDEVENT(loc_oColuna.chk_4c_Selecionar, "InteractiveChange", ;
                THIS, "ChkSelecionarInteractiveChange")
        ENDIF

        loc_oColuna.CurrentControl = "chk_4c_Selecionar"
        loc_oColuna.Sparse         = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrade - funil UNICO de carga e vinculo das TRES grades.
    * Transcricao do trecho final do Init legado: depois de montar TmpPends/
    * xPNensi/xPNensiT, ele faz o "With Thisform.Grade / .RecordSource = ...
    * / .<coluna>.ControlSource = ..." para Grade, Gradeitem e GradeTotal.
    *
    * PUBLIC (regra #3/#51): o harness de teste chama CarregarLista/
    * CarregarGrade de FORA da classe, e PEMSTATUS(...,5) devolve .T. para
    * metodo PROTECTED, entao o teste entraria no branch e a chamada
    * falharia em runtime.
    *
    * SigOpMpnBO.CarregarPendencias() recria os tres cursores do zero (mesma
    * semantica do "Create Cursor" do Init legado) e so DEPOIS as grades sao
    * ligadas - regra #41: Column.ControlSource de cursor que ainda nao
    * existe derruba o Init e a tela nao abre.
    *
    * Ordem obrigatoria por grade: RecordSource -> ControlSource -> (Column1:
    * AddObject do CheckBox) -> Width -> Header1.Caption -> ReadOnly. Mexer
    * em RecordSource RECALCULA as larguras para o default 90 e reseta
    * Header1.Caption, Sparse, CurrentControl e o ReadOnly das colunas (que
    * volta a herdar o do Grid) - por isso tudo isso eh reaplicado AQUI, e
    * nao so em ConfigurarGrade/ConfigurarGradesDetalhe (Problema 48 do
    * FormCor; o ReadOnly da coluna sempre DEPOIS do ReadOnly do Grid).
    *
    * Bypass de SQL em modo teste/ValidarUIFidelity: TmpNens/TmpOperacao sao
    * cursores do form PAI e nao existem em instanciacao headless - as
    * grades ficam com a estrutura montada e sem dado, o que basta para a
    * validacao de UI.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGrade()
        LOCAL loc_lSucesso, loc_lBypassTeste, loc_oErro
        LOCAL loc_cPends, loc_cPNensi, loc_cPNensiT, loc_cChaveDetalhe
        LOCAL loc_cNivelDestino, loc_cAliasNivelAnt

        loc_lSucesso = .F.

        TRY
            loc_lBypassTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
                (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

            *-- Legado (Init, antes do "Create Cursor TmpPends"):
            *-- "=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps') / _DoppsNivel =
            *-- crSigCdOpd.Nivels / ThisForm.OpSubNivel.Value = _DoppsNivel"
            *-- - descricao do NIVEL de destino, lida do cursor global
            *-- crSigCdOpd pela chave do nivel corrente do form pai
            *-- (TmpNens.Dopps). TmpNens nao existe em modo teste/
            *-- ValidarUIFidelity headless (cursor do form pai) - o guard
            *-- USED() deixa o campo vazio nesse caso, igual ao resto da
            *-- tela.
            IF PEMSTATUS(THIS, "txt_4c_OpSubNivel", 5)
                loc_cNivelDestino = ""
                IF USED("TmpNens") AND USED("crSigCdOpd")
                    loc_cAliasNivelAnt = ALIAS()
                    IF SEEK(TmpNens.Dopps, "crSigCdOpd", "Dopps")
                        loc_cNivelDestino = crSigCdOpd.Nivels
                    ENDIF
                    IF !EMPTY(loc_cAliasNivelAnt) AND USED(loc_cAliasNivelAnt)
                        SELECT (loc_cAliasNivelAnt)
                    ENDIF
                ENDIF
                THIS.txt_4c_OpSubNivel.Value = loc_cNivelDestino
            ENDIF

            loc_cPends   = THIS.this_oBusinessObject.this_cCursorPends
            loc_cPNensi  = THIS.this_oBusinessObject.this_cCursorPNensi
            loc_cPNensiT = THIS.this_oBusinessObject.this_cCursorPNensiT

            IF !loc_lBypassTeste
                THIS.this_oBusinessObject.CarregarPendencias()
            ENDIF

            *-- Grade de selecao (legado: With Thisform.Grade) -------------
            IF USED(loc_cPends)
                *-- RecordSource FORA do WITH (regra do projeto): mexer em
                *-- RecordSource recria as Column, e acessa-las dentro do
                *-- MESMO WITH que acabou de atribuir RecordSource estoura
                *-- 'Unknown member COLUMN1'
                THIS.grd_4c_Grade.RecordSource = loc_cPends

                *-- Mapeamento coluna -> campo transcrito do legado, que
                *-- liga as colunas pelo NOME (.Seleciona/.Usuario/
                *-- .Codigo/.Data/.Grupo/.Conta/.Peso); aqui pelo numero
                *-- da Column correspondente (ver ConfigurarGrade)
                WITH THIS.grd_4c_Grade
                    .Column1.ControlSource = loc_cPends + ".Flag"
                    .Column2.ControlSource = loc_cPends + ".Usuars"
                    .Column3.ControlSource = loc_cPends + ".Numps"
                    .Column4.ControlSource = loc_cPends + ".Datas"
                    .Column5.ControlSource = loc_cPends + ".Grupo"
                    .Column6.ControlSource = loc_cPends + ".Conta"
                    .Column7.ControlSource = loc_cPends + ".TPesos"
                ENDWITH

                *-- SO AGORA Column1 aponta para Flag (Logico): eh seguro
                *-- embutir o CheckBox (regra #18)
                THIS.GarantirCheckBoxSelecionar()

                WITH THIS.grd_4c_Grade
                    .Column1.Width = 15
                    .Column2.Width = 100
                    .Column3.Width = 80
                    .Column4.Width = 75
                    .Column5.Width = 130
                    .Column6.Width = 130
                    .Column7.Width = 100

                    .Column1.Header1.Caption = ""
                    .Column2.Header1.Caption = "Usu" + CHR(225) + "rio"
                    .Column3.Header1.Caption = "C" + CHR(243) + "digo"
                    .Column4.Header1.Caption = "Data"
                    .Column5.Header1.Caption = "Grupo de Origem"
                    .Column6.Header1.Caption = "Conta de Origem"
                    .Column7.Header1.Caption = "Total de Peso"

                    *-- Reafirma, DEPOIS do RecordSource, as duas unicas
                    *-- regras de edicao do legado: o When do fwcheckbox1
                    *-- (Return (pcEscolha = 'INSERIR')) na coluna de
                    *-- selecao e o Peso sempre somente-leitura
                    .Column1.ReadOnly = (THIS.this_cModoAtual != "INCLUIR")
                    .Column7.ReadOnly = .T.
                ENDWITH

                *-- obj_4c_Mm_obs (mm_obs) - mesma razao de regra #41 das
                *-- colunas da grade: TmpPends nao existia no momento do
                *-- AddObject (ConfigurarCamposComplementares), so agora o
                *-- ControlSource pode apontar para ele
                IF PEMSTATUS(THIS, "obj_4c_Mm_obs", 5)
                    THIS.obj_4c_Mm_obs.ControlSource = loc_cPends + ".Obss"
                ENDIF

                *-- Legado, ANTES de qualquer bind de detalhe: "Select
                *-- TmpPends / Go Bottom". A linha CORRENTE passa a ser a
                *-- ULTIMA, e eh dela que sai a chave mestre-detalhe logo
                *-- abaixo - por isso o Go Bottom vem AQUI e nao no fim do
                *-- metodo: posicionar depois deixaria a grade destacando a
                *-- ultima pendencia com as grades de baixo mostrando os
                *-- itens da PRIMEIRA.
                SELECT (loc_cPends)
                GO BOTTOM
                THIS.grd_4c_Grade.Refresh()
            ENDIF

            *-- Chave mestre-detalhe: as duas grades de baixo mostram so os
            *-- itens da pendencia CORRENTE. Legado: "Set Key To
            *-- TmpPends.Emps + TmpPends.Dopps + STr(TmpPends.Numps, 10)",
            *-- avaliado com TmpPends na linha em que o Go Bottom o deixou.
            *-- Chave POSICIONAL char(33) - PADR explicito em cada parte,
            *-- NUNCA ALLTRIM (regra #42). Com TmpPends vazio/ausente a
            *-- chave fica vazia e as grades de detalhe nao filtram nada,
            *-- que eh o estado correto de tela sem pendencia selecionada.
            loc_cChaveDetalhe = ""
            IF USED(loc_cPends) AND !EOF(loc_cPends)
                loc_cChaveDetalhe = PADR(EVALUATE(loc_cPends + ".Emps"), 3) + ;
                    PADR(EVALUATE(loc_cPends + ".Dopps"), 20) + ;
                    STR(EVALUATE(loc_cPends + ".Numps"), 10)
            ENDIF

            *-- Grade de itens (legado: With Thisform.Gradeitem) -----------
            IF USED(loc_cPNensi)
                THIS.VincularGradeDetalhe(THIS.grd_4c_Itens, loc_cPNensi, loc_cChaveDetalhe)

                *-- Larguras/titulos proprios da grade de ITENS
                WITH THIS.grd_4c_Itens
                    .Column1.Width = 80
                    .Column2.Width = 108
                    .Column3.Width = 35
                    .Column4.Width = 31
                    .Column5.Width = 90
                    .Column6.Width = 60
                    .Column7.Width = 80
                    .Column8.Width = 31
                    .Column9.Width = 69

                    .Column1.Header1.Caption = "Ordem Produ" + CHR(231) + CHR(227) + "o"
                    .Column2.Header1.Caption = "Componente"
                    .Column3.Header1.Caption = "Grupo"
                    .Column4.Header1.Caption = "Unid."
                    .Column5.Header1.Caption = "Tipo de Material"
                    .Column6.Header1.Caption = "Qtde."
                    .Column7.Header1.Caption = "Peso Atual"
                    .Column8.Header1.Caption = "Cat."
                    .Column9.Header1.Caption = "Envelope"
                ENDWITH
            ENDIF

            *-- Grade de total (legado: With Thisform.GradeTotal) ----------
            IF USED(loc_cPNensiT)
                THIS.VincularGradeDetalhe(THIS.grd_4c_Total, loc_cPNensiT, loc_cChaveDetalhe)

                *-- Larguras/titulos proprios da grade de TOTAL
                WITH THIS.grd_4c_Total
                    .Column1.Width = 107
                    .Column2.Width = 108
                    .Column3.Width = 35
                    .Column4.Width = 31
                    .Column5.Width = 97
                    .Column6.Width = 68
                    .Column7.Width = 80
                    .Column8.Width = 52
                    .Column9.Width = 71

                    .Column1.Header1.Caption = "Ordem Fabrica" + CHR(231) + CHR(227) + "o"
                    .Column2.Header1.Caption = "Componente"
                    .Column3.Header1.Caption = "Grupo"
                    .Column4.Header1.Caption = "Uni"
                    .Column5.Header1.Caption = "Tipo de Material"
                    .Column6.Header1.Caption = "Qtde"
                    .Column7.Header1.Caption = "Peso Atual"
                    .Column8.Header1.Caption = "Cat."
                    .Column9.Header1.Caption = "Envelope"
                ENDWITH
            ENDIF

            *-- Devolve a area de trabalho corrente a TmpPends: as duas
            *-- chamadas a VincularGradeDetalhe deixam o alias em xPNensi/
            *-- xPNensiT, e o resto da tela (grade de selecao, EditBox de
            *-- observacao, handlers) trabalha sobre TmpPends. O ponteiro
            *-- segue na ULTIMA linha, onde o Go Bottom acima o deixou -
            *-- sem reposicionar de novo, para nao desalinhar da chave
            *-- mestre-detalhe que as grades de baixo ja estao usando.
            IF USED(loc_cPends)
                SELECT (loc_cPends)
                THIS.grd_4c_Grade.Refresh()
            ENDIF

            *-- Visibilidade de SelTudo/Apaga/Totaliza depende de
            *-- SepPedras, que so eh conhecido depois da carga
            THIS.AjustarBotoesPorModo()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.CarregarGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGradeDetalhe - liga UMA das duas grades de detalhe ao seu
    * cursor. As duas tem as MESMAS 9 colunas, nas MESMAS ControlSource do
    * legado (Nops/CMats/CGrus/CUnis/TpOps/Qtds/Pesos/Cats/NEnvs, nessa
    * ordem), por isso o bind eh um metodo unico - so largura e titulo
    * diferem, e ficam no chamador.
    *
    * SET ORDER TO EmpDopNum + SET KEY TO reproduzem o filtro mestre-detalhe
    * do legado ("Select xPnensiT / Set Order to EmpDopNum / Go Top / Set
    * Key To <chave de TmpPends>"). Em xPNensi o legado conta com o indice
    * EmpDopNum estar ativo por ser o ULTIMO criado - aqui a ordem eh
    * explicita, que eh o mesmo efeito sem depender dessa ordem.
    *
    * Todas as 9 colunas voltam a ReadOnly = .T. DEPOIS do RecordSource: as
    * duas grades sao de exibicao (no legado cada Text1 delas tem
    * "When: Return .f.") e o RecordSource faz a coluna herdar de novo o
    * ReadOnly = .F. do Grid.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularGradeDetalhe(par_oGrade, par_cCursor, par_cChave)
        LOCAL loc_nI

        SELECT (par_cCursor)
        SET ORDER TO EmpDopNum
        GO TOP
        IF EMPTY(par_cChave)
            SET KEY TO
        ELSE
            SET KEY TO par_cChave
        ENDIF

        *-- RecordSource FORA do WITH (regra do projeto): mexer em
        *-- RecordSource recria as Column, e acessa-las dentro do MESMO
        *-- WITH que acabou de atribuir RecordSource estoura 'Unknown
        *-- member COLUMN1'
        par_oGrade.RecordSource = par_cCursor

        WITH par_oGrade
            .Column1.ControlSource = par_cCursor + ".Nops"
            .Column2.ControlSource = par_cCursor + ".CMats"
            .Column3.ControlSource = par_cCursor + ".CGrus"
            .Column4.ControlSource = par_cCursor + ".CUnis"
            .Column5.ControlSource = par_cCursor + ".TpOps"
            .Column6.ControlSource = par_cCursor + ".Qtds"
            .Column7.ControlSource = par_cCursor + ".Pesos"
            .Column8.ControlSource = par_cCursor + ".Cats"
            .Column9.ControlSource = par_cCursor + ".NEnvs"
        ENDWITH

        *-- Column.ReadOnly SEMPRE depois do Grid.ReadOnly (o do Grid
        *-- propaga e sobrescreve) - regra #18/#46
        FOR loc_nI = 1 TO par_oGrade.ColumnCount
            par_oGrade.Columns(loc_nI).ReadOnly = .T.
        ENDFOR

        SELECT (par_cCursor)
        GO TOP
        par_oGrade.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - nome canonico de carga do projeto; funil unico para
    * CarregarGrade(). PUBLIC pelo mesmo motivo (o harness chama de fora -
    * regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarGrade()
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkSelecionarInteractiveChange - legado: SIGOPMPN.Grade.seleciona.
    * fwcheckbox1.InteractiveChange:
    *     =DoDefault()
    *     If Not This.Value
    *         ThisForm.Desmarca
    *     Else
    *         This.Value = ThisForm.Marca()
    *     EndIf
    *
    * O ControlSource ja gravou o novo valor em TmpPends.Flag ANTES deste
    * handler disparar. THIS.this_oBusinessObject.CarregarDoCursor() le a
    * linha CORRENTE (this_cEmps/this_cDopps/this_nNumps/this_dDatas), que
    * Marcar()/Desmarcar() usam. Em .T. (marcando), Marcar() pode recusar
    * (duplicidade/numeracao-automatica/data) - nesse caso desfaz o Flag,
    * equivalente a "This.Value = ThisForm.Marca()" quando o retorno eh
    * .F. Quando Marcar() sinaliza this_lFecharAposMarcar (legado:
    * "This.ok.click" dentro do proprio marca, ramo _NumeroAnt), o RETURN
    * fica FORA do TRY (regra #1) e so entao fecha via CmdOkClick.
    *
    * PUBLIC (regra #3: alvo de BINDEVENT).
    *--------------------------------------------------------------------------
    PROCEDURE ChkSelecionarInteractiveChange()
        LOCAL loc_cAlias, loc_lNovoValor, loc_lResultado, loc_lFechar, loc_oErro

        loc_lFechar = .F.

        TRY
            loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends

            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                loc_lNovoValor = ConverterParaLogico(Flag)

                THIS.this_oBusinessObject.CarregarDoCursor()

                IF loc_lNovoValor
                    loc_lResultado = THIS.this_oBusinessObject.Marcar(.F.)

                    IF !loc_lResultado
                        SELECT (loc_cAlias)
                        REPLACE Flag WITH .F.
                    ELSE
                        loc_lFechar = THIS.this_oBusinessObject.this_lFecharAposMarcar
                    ENDIF
                ELSE
                    THIS.this_oBusinessObject.Desmarcar()
                ENDIF

                IF !loc_lFechar
                    SELECT (loc_cAlias)
                    THIS.grd_4c_Grade.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.ChkSelecionarInteractiveChange")
        ENDTRY

        IF loc_lFechar
            THIS.CmdOkClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSelTudoClick - legado: SIGOPMPN.SelTudo.Click
    *     Select TmpPends
    *     Scan For Not Flag
    *         Replace Flag With ThisForm.Marca(.t.)
    *     EndScan
    *     ThisForm.Grade.Refresh
    *
    * Interrompe o Scan (EXIT) e fecha o dialogo (CmdOkClick) assim que
    * Marcar() sinalizar this_lFecharAposMarcar - mesma semantica do
    * legado, onde "This.ok.click" dentro de marca() libera (Release) o
    * form NO MEIO do Scan.
    *--------------------------------------------------------------------------
    PROCEDURE CmdSelTudoClick()
        LOCAL loc_cAlias, loc_lResultado, loc_lFecharApos, loc_oErro

        loc_lFecharApos = .F.

        TRY
            loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends

            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                SCAN FOR !Flag
                    THIS.this_oBusinessObject.CarregarDoCursor()
                    loc_lResultado = THIS.this_oBusinessObject.Marcar(.T.)

                    SELECT (loc_cAlias)
                    REPLACE Flag WITH loc_lResultado

                    IF loc_lResultado AND THIS.this_oBusinessObject.this_lFecharAposMarcar
                        loc_lFecharApos = .T.
                        EXIT
                    ENDIF

                    SELECT (loc_cAlias)
                ENDSCAN

                IF !loc_lFecharApos
                    THIS.grd_4c_Grade.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.CmdSelTudoClick")
        ENDTRY

        IF loc_lFecharApos
            THIS.CmdOkClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdApagaClick - legado: SIGOPMPN.apaga.Click
    *     Select TmpPends
    *     Scan For Flag
    *         Replace Flag With ThisForm.DesMarca()
    *     EndScan
    *     ThisForm.Grade.Refresh
    *
    * DESVIO DOCUMENTADO: "DesMarca()" no legado so tem "Return 0" no
    * caminho de ERRO (falha de SqlExecute); sem RETURN explicito no
    * caminho normal, VFP devolve .T. implicito - logo "Replace Flag With
    * ThisForm.DesMarca()" tende a GRAVAR Flag = .T. de volta (reversao
    * acidental do proprio "apagar"), e no caminho de erro tentaria gravar
    * o NUMERO 0 num campo Logico (type mismatch). Mesmo padrao ja adotado
    * em FormSigOpMpd.CmdApagaClick (mesma familia de tela): zera Flag
    * ANTES de chamar Desmarcar(), sem depender do retorno.
    *--------------------------------------------------------------------------
    PROCEDURE CmdApagaClick()
        LOCAL loc_cAlias, loc_oErro

        TRY
            loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends

            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                SCAN FOR Flag
                    SELECT (loc_cAlias)
                    REPLACE Flag WITH .F.
                    THIS.this_oBusinessObject.CarregarDoCursor()
                    THIS.this_oBusinessObject.Desmarcar()
                    SELECT (loc_cAlias)
                ENDSCAN

                THIS.grd_4c_Grade.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.CmdApagaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdTotalizaClick - legado: SIGOPMPN.Totaliza.Click. Alterna grd_4c_
    * Itens (Gradeitem) com grd_4c_Total (GradeTotal) via this_nContador
    * (legado: ThisForm.contador/ContaDor).
    *--------------------------------------------------------------------------
    PROCEDURE CmdTotalizaClick()
        IF THIS.this_nContador = 0
            THIS.grd_4c_Itens.Visible = .F.
            THIS.grd_4c_Total.Visible = .T.
            THIS.grd_4c_Total.Refresh()
            THIS.this_nContador       = 1
            THIS.cmd_4c_Totaliza.Caption = "Itens"
        ELSE
            THIS.grd_4c_Itens.Visible = .T.
            THIS.grd_4c_Total.Visible = .F.
            THIS.grd_4c_Itens.Refresh()
            THIS.this_nContador       = 0
            THIS.cmd_4c_Totaliza.Caption = "Totaliza"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - legado: SIGOPMPN.Grade.AfterRowColChange.
    * Reaplica o "Set Key To" das duas grades de detalhe (itens/total) com
    * a chave da linha NOVA de TmpPends (regra #46: SEM filtro de coluna -
    * este handler recarrega o DETALHE da linha corrente, nao valida
    * celula).
    *
    * PUBLIC (regra #3: alvo de BINDEVENT).
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        LOCAL loc_cAliasPends, loc_cAliasPNensi, loc_cAliasPNensiT, loc_cChave

        loc_cAliasPends   = THIS.this_oBusinessObject.this_cCursorPends
        loc_cAliasPNensi  = THIS.this_oBusinessObject.this_cCursorPNensi
        loc_cAliasPNensiT = THIS.this_oBusinessObject.this_cCursorPNensiT

        IF !USED(loc_cAliasPends) OR EOF(loc_cAliasPends)
            RETURN
        ENDIF

        *-- Chave POSICIONAL char(33) (regra #42): Emps/Dopps sao colunas
        *-- CHAR fixas de TmpPends, lidas direto (sem ALLTRIM)
        loc_cChave = EVALUATE(loc_cAliasPends + ".Emps") + EVALUATE(loc_cAliasPends + ".Dopps") + ;
            STR(EVALUATE(loc_cAliasPends + ".Numps"), 10)

        IF USED(loc_cAliasPNensiT)
            SELECT (loc_cAliasPNensiT)
            SET KEY TO loc_cChave
            GO TOP
        ENDIF

        IF USED(loc_cAliasPNensi)
            SELECT (loc_cAliasPNensi)
            SET KEY TO loc_cChave
            GO TOP
        ENDIF

        THIS.grd_4c_Itens.Refresh()
        THIS.obj_4c_Mm_obs.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdOkClick - legado: SIGOPMPN.ok.Click. Grava (SigOpMpnBO.
    * ConfirmarMovimentacoes - xMFas/xOpi/xNensi/SigCdNec) e so fecha o
    * dialogo se a gravacao for bem-sucedida: no legado, qualquer "Return
    * 0" dentro do Click aborta ANTES das duas ultimas linhas
    * (ParentForm.Enabled = .t. / ThisForm.Release), ou seja, erro mantem
    * a tela aberta (o MsgErro ja foi mostrado dentro do BO).
    *--------------------------------------------------------------------------
    PROCEDURE CmdOkClick()
        IF THIS.this_oBusinessObject.ConfirmarMovimentacoes()
            THIS.FecharDialogo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharDialogo - saida UNICA da tela. O dialogo tem ControlBox = .F.
    * e Closable = .F. (valores do SCX legado), portanto nao ha X nem ESC:
    * o botao OK (apos gravar) eh o unico caminho que o legado oferece, e
    * todos os nomes canonicos de saida do projeto apontam para aqui.
    *--------------------------------------------------------------------------
    PROCEDURE FecharDialogo()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - nome canonico do projeto para o botao de saida.
    * Aqui o botao de saida eh o OK do legado (SIGOPMPN.ok), por isso
    * delega ao mesmo funil (que grava antes de fechar).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.CmdOkClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - nome canonico do projeto para "sair sem gravar".
    * O legado nao oferece esse caminho (ControlBox = .F., sem ESC) - o
    * UNICO jeito de sair eh o OK, que ja grava. Delega ao mesmo funil em
    * vez de dar ao usuario a impressao falsa de que ha algo a descartar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.CmdOkClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - reabilita o form pai (legado: ThisForm.ParentForm.Enabled
    * nao aparece explicito no dump de SIGOPMPN, mas reforcar aqui segue o
    * mesmo padrao de seguranca de FormSigOpMpd.prg - cobre fechamento por
    * qualquer caminho) e libera o Business Object. Fecha tambem TmpPends
    * (cursor proprio desta tela, criado nas fases seguintes - guard
    * USED() o torna seguro mesmo antes de existir). DODEFAULT() por
    * ULTIMO (regra do projeto: sem ela os popups do menu principal
    * encolhem visualmente apos o form fechar).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        *-- Cursores PROPRIOS desta tela (criados por
        *-- SigOpMpnBO.CriarCursoresGrades). Os cursores do form PAI
        *-- (TmpNens/TmpOperacao/xMFas/xOpi/xPesa/xNensi) NAO sao fechados
        *-- aqui: pertencem a ele e continuam em uso depois que o dialogo
        *-- fecha.
        IF USED("TmpPends")
            USE IN TmpPends
        ENDIF
        IF USED("xPNensi")
            USE IN xPNensi
        ENDIF
        IF USED("xPNensiT")
            USE IN xPNensiT
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpMpnBO.prg):
*============================================================================
* SigOpMpnBO.prg - Business Object da tela SIGOPMPN (tela de movimentacoes
* de subnivel ainda em aberto / nao confirmadas).
*
* Form OPERACIONAL (SIGOPMPN / FormSigOpMpn): dialogo chamado por outro form
* (o "form pai", que abre a tela com os parametros pForm/DatSes/Operacao do
* Init legado) para o usuario MARCAR, numa grade com CheckBox (fwcheckbox1
* na coluna "seleciona"), quais pendencias de subnivel de uma determinada
* "necessidade" (SigCdNec) vao entrar na operacao que o form pai esta
* montando. Ao confirmar (botao "OK"), o dialogo grava o detalhe das
* pendencias marcadas nos cursores de SAIDA do form pai (xMFas/xOpi/xNensi)
* e atualiza SigCdNec.ChkSubn para marcar o subnivel como utilizado.
*
* O legado liga esta tela DIRETO na DATA SESSION do form pai
* (Set DataSession To DatSes, dentro do proprio Init, ANTES do Create Cursor
* TmpPends) - por isso TmpNens, TmpOperacao, xMFas, xOpi, xPesa e xNensi NAO
* sao criados por este BO: sao cursores que o form PAI ja mantem abertos
* quando o dialogo e aberto, e que este BO so consulta/atualiza pelo NOME
* (propriedades this_cCursorXxx abaixo, no padrao ja usado em SigOpMpdBO,
* que e a mesma familia de tela).
*
*   TmpNens      - linha de NECESSIDADE (SigCdNec) que o form pai esta
*                  processando agora: Emps+Dopps+Numps identifica o "nivel"
*                  cuja lista de pendencias este dialogo exibe em TmpPends.
*   TmpOperacao  - codigos (NumNivel*10000000000 + NEnv) de pendencia JA
*                  usados/selecionados pelo form pai nesta sessao de edicao.
*   xMFas/xOpi   - cursores de SAIDA do form pai: o botao "OK" grava aqui o
*                  detalhe (fase/item) de cada pendencia marcada.
*   xPesa        - cursor de SAIDA do form pai, zerado no inicio do "OK"
*                  (Zap In xPesa) junto com os demais; o dump nao mostra
*                  nenhum Insert Into xPesa dentro do Click, entao este BO
*                  so expoe o nome do cursor (quem grava nele, se for o
*                  caso, e logica que ainda nao apareceu no dump).
*   xNensi       - cursor de SAIDA do form pai: o botao "OK" grava aqui o
*                  detalhe final (por envelope) das pendencias confirmadas,
*                  na MESMA estrutura dos cursores PROPRIOS xPNensi/xPNensiT
*                  abaixo (os tres vem de SigCdNei).
*
* Cursores GLOBAIS Fortyus (ja abertos pelo form pai/aplicacao, este BO so
* le pelo NOME - regra do projeto: cursor global so e' POPULADO no Init do
* BO quando e' deste BO a responsabilidade de garanti-lo; crSigCdOpd e
* crSigCdNec sao tabelas inteiras mantidas abertas em outro ponto do
* sistema, igual ao decidido em SigOpMpdBO para os cursores do form pai):
*   crSigCdOpd   - definicao do "Dopps" (subnivel/operacao): Nivels, NDopps,
*                  ConOSubs, ConDSubs, Numeras, BxAutos, SepPedras,
*                  CompAgrus, AcEnvs. Lido com Seek(..., 'crSigCdOpd', ...).
*   crSigCdNec   - a propria tabela de necessidades (SigCdNec), consultada
*                  diretamente (sem WHERE) em alguns pontos do "OK".
*
* Cursor GLOBAL de PARAMETROS (SigCdPam, tabela de 1 linha) - o "OK" le
* DIRETO crSigCdPam.TpPesas (para decidir this_lIndividualPorPeso de cada
* item de xOpi). Regra do projeto: cursor global Fortyus de 1 linha e'
* garantido no Init deste BO, nunca pressuposto - mesmo padrao canonico de
* ClienteBO.prg/SigOpMpdBO.prg.
*
* Cursores PROPRIOS (criados pela camada que monta a tela, nao por este
* Init - a criacao com CREATE CURSOR/SELECT INTO CURSOR fica no metodo que
* carrega as pendencias, em fase posterior; aqui so os NOMES canonicos):
*   TmpPends  - grade de selecao (Create Cursor TmpPends do Init legado):
*               Flag l, Emps c(3), Dopps c(20), Numps n(10), Datas d Null,
*               Obss m Null, Grupo c(10), Conta c(10), TPesos n(12,2),
*               Usuars c(10). As propriedades this_lFlag/this_cEmps/
*               this_cDopps/this_nNumps/this_dDatas/this_cObs/this_cGrupo/
*               this_cConta/this_nTPesos/this_cUsuars espelham estes MESMOS
*               campos, na MESMA ordem (regra #42 - reproducao exata evita
*               divergencia entre pontos que recriam o cursor).
*   xPNensi   - grade "Itens" (Gradeitem): detalhe por envelope/fase das
*               pendencias da linha corrente de TmpPends, originado de
*               SigCdNei.
*   xPNensiT  - grade "Total" (GradeTotal, alternada pelo botao Totaliza):
*               mesma estrutura de xPNensi, agregada por componente.
*
* UNICO alvo de escrita PERSISTIDA no SQL Server por este BO: SigCdNec.
* ChkSubn (bit), pela PK CidChaves (char(20)) -
*   Update SigCdNec Set ChkSubn = ?pNot/?pTru Where CidChaves = '<cid>'
* - por isso this_cTabela/this_cCampoChave abaixo, e por isso Atualizar()
* (a ser implementado em fase posterior) grava EXATAMENTE esse UPDATE. O
* legado aplica esse UPDATE em LOTE (um Scan por nivel), mas cada volta do
* Scan e' um UPDATE de UMA linha pela PK - que e' o contrato de
* Atualizar(). O restante da gravacao do "OK" (xMFas/xOpi/xNensi/
* TmpOperacao) grava em CURSORES locais do form pai, nao em tabela do SQL
* Server - medido contra docs/schema.sql (682 tabelas), nenhum desses 4
* nomes consta do schema, entao nao ha Inserir()/ExecutarExclusao() de
* tabela correspondente a eles (regra #22 proibe inventar lista de
* colunas de tabela que nao existe).
*
* O nivel (crSigCdOpd) e' lido tanto no Init legado quanto dentro de
* Marca() - as propriedades this_cNivelSubn/this_cNumeroNivel/
* this_cPuxaOrigem/this_cPuxaDestino/this_lNumeroAnt/this_lBaixaSubN
* cacheiam esses valores para as duas situacoes, recalculados por um
* metodo CarregarNivel (fase posterior) a partir de TmpNens.Dopps.
*
* O "Load" legado ("=fConfigGeral()") nao gera metodo neste BO: era
* inicializacao GLOBAL da aplicacao Fortyus, e na arquitetura nova isso ja
* acontece antes (config.prg/main.prg/cada BO com seus cursores) - mesma
* decisao documentada em SigOpMpdBO.prg/SigOpGrcBO.prg.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpMpnBO AS BusinessBase

    *==========================================================================
    * EMPRESA do nivel corrente - equivalente a ThisForm.pEmps do legado
    * (herdado do form pai), usado para montar a faixa EmpDNPs (Between
    * pEd1 And pEd2) na carga das pendencias.
    *==========================================================================
    this_cEmpresa = ""

    *==========================================================================
    * CURSORES DO FORM PAI (fornecidos por quem abre este dialogo - este BO
    * NAO os cria, so os consulta/atualiza pelo NOME)
    *==========================================================================

    *-- TmpNens: linha de NECESSIDADE (SigCdNec) corrente do form pai
    this_cCursorNens = ""

    *-- TmpOperacao: codigos (NumNivel) de pendencia ja usados/selecionados
    this_cCursorOperacao = ""

    *-- xMFas/xOpi: cursores de SAIDA do form pai, gravados pelo "OK"
    this_cCursorMFas = ""
    this_cCursorOpi  = ""

    *-- xPesa: cursor de SAIDA do form pai, zerado no inicio do "OK"
    this_cCursorPesa = ""

    *-- xNensi: cursor de SAIDA do form pai (detalhe final por envelope)
    this_cCursorNensiSaida = ""

    *==========================================================================
    * CURSORES GLOBAIS Fortyus (ja abertos em outro ponto do sistema - este
    * BO so le pelo NOME; ver nota no cabecalho sobre o porque de NAO
    * garantir a criacao deles aqui)
    *==========================================================================
    this_cCursorOpd          = ""   && crSigCdOpd (definicao do Dopps/nivel)
    this_cCursorNecessidades = ""   && crSigCdNec  (tabela SigCdNec aberta)

    *==========================================================================
    * CURSOR GLOBAL DE PARAMETROS (SigCdPam, tabela de 1 linha) - o "OK" le
    * CuniPPads/TpPesas direto deste cursor
    *==========================================================================
    this_cCursorParametros = ""

    *==========================================================================
    * CURSORES PROPRIOS (nomes canonicos; a criacao via CREATE CURSOR fica
    * no metodo que monta a tela, em fase posterior)
    *==========================================================================
    this_cCursorPends  = ""   && TmpPends  (grade de selecao)
    this_cCursorPNensi = ""   && xPNensi   (grade "Itens")
    this_cCursorPNensiT = ""  && xPNensiT  (grade "Total")

    *==========================================================================
    * Linha corrente de TmpPends (Flag l, Emps c(3), Dopps c(20), Numps n(10),
    * Datas d Null, Obss m Null, Grupo c(10), Conta c(10), TPesos n(12,2),
    * Usuars c(10)) - MESMA ordem do Create Cursor legado (regra #42)
    *==========================================================================
    this_lFlag   = .F.
    this_cEmps   = ""
    this_cDopps  = ""
    this_nNumps  = 0
    this_dDatas  = {}
    this_cObs    = ""
    this_cGrupo  = ""
    this_cConta  = ""
    this_nTPesos = 0
    this_cUsuars = ""

    *==========================================================================
    * DADOS DO NIVEL/OPERACAO CORRENTE (crSigCdOpd) - equivalentes as
    * variaveis PRIVATE do Init/Marca legado (_DoppsNivel/_NumeroNivel/
    * _PuxaOrigem/_PuxaDestino/_NumeroAnt/_BaixaSubN), recalculados por um
    * metodo CarregarNivel (fase posterior) a partir de TmpNens.Dopps
    *==========================================================================
    this_cNivelSubn    = ""   && crSigCdOpd.Nivels do nivel corrente
    this_cNumeroNivel  = ""   && Str(crSigCdOpd.NDopps, 2)
    this_cPuxaOrigem   = ""   && crSigCdOpd.ConOSubs
    this_cPuxaDestino  = ""   && crSigCdOpd.ConDSubs
    this_lNumeroAnt    = .F.  && crSigCdOpd.Numeras = 3
    this_lBaixaSubN    = .F.  && crSigCdOpd.BxAutos = 1

    *==========================================================================
    * CONFIGURACAO DO NIVEL lida na SEGUNDA consulta a SigCdOpd (a do
    * registro que representa o "nivel", achado por Dopps = Nivels). O
    * legado le as duas DIRETO de crSigCdOpd dentro do laco de detalhe,
    * depois do "Seek(_DoppsNivel, 'crSigCdOpd', 'Dopps')" - aqui ficam em
    * property para nao depender do ponteiro de um cursor global ficar
    * parado no lugar certo durante o SCAN.
    *
    * this_nCompAgrus -> crSigCdOpd.CompAgrus (numeric(1,0)): = 1 agrupa os
    *                    componentes zerando o numero de envelope.
    * this_nSepPedras -> crSigCdOpd.SepPedras (numeric(1,0)): = 4 separa
    *                    pedras (mantem o envelope e habilita "Totaliza").
    *==========================================================================
    this_nCompAgrus = 0
    this_nSepPedras = 0

    *==========================================================================
    * PAR (chave, valor) do proximo UPDATE em SigCdNec.ChkSubn - os dois
    * argumentos que Atualizar() (fase posterior) vai gravar. Marcar()/
    * Desmarcar() varrem o cursor de chaves do "nivel" e, para CADA linha,
    * setam este par e chamam THIS.Atualizar() - que tambem chama
    * RegistrarAuditoria(), por isso ObterChavePrimaria() (fase posterior)
    * vai devolver this_cCidChavesAtual.
    *
    * this_cCidChavesAtual -> SigCdNec.CidChaves (char(20), PK Fortyus)
    * this_lChkSubn        -> SigCdNec.ChkSubn   (bit): .T. no Marcar
    *                         (legado ?pTru), .F. no Desmarcar (?pNot)
    *==========================================================================
    this_cCidChavesAtual = ""
    this_lChkSubn        = .F.

    *==========================================================================
    * Sinaliza ao FORM (fase 7) que Marcar() executou o ramo "_NumeroAnt" do
    * legado, que termina com "This.ok.click" - ou seja, a marcacao exige o
    * fechamento IMEDIATO do dialogo (gravando tudo via ConfirmarMovimentacoes).
    * Este BO nao conhece o botao OK; quem fecha eh o Form, apos checar esta
    * flag (ver ChkSelecionarInteractiveChange/CmdSelTudoClick).
    *==========================================================================
    this_lFecharAposMarcar = .F.

    *==========================================================================
    * Init - Define this_cTabela/this_cCampoChave (ver nota no cabecalho
    * sobre o alvo de escrita SigCdNec/CidChaves), os nomes canonicos dos
    * cursores desta tela, zera a linha corrente de TmpPends/o nivel
    * corrente, e garante o cursor global crSigCdPam (CuniPPads/TpPesas),
    * que o "OK" vai precisar.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro, loc_oErroPam, loc_nResult
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            *-- Tabela/campo chave do UPDATE de Atualizar() e da auditoria
            *-- via ObterChavePrimaria - ver nota no cabecalho: SigCdNec.
            *-- ChkSubn eh o unico alvo de escrita no SQL Server.
            THIS.this_cTabela     = "SigCdNec"
            THIS.this_cCampoChave = "CidChaves"

            *-- Empresa do nivel corrente
            THIS.this_cEmpresa = ""

            *-- Nomes canonicos dos cursores do form pai
            THIS.this_cCursorNens         = "TmpNens"
            THIS.this_cCursorOperacao     = "TmpOperacao"
            THIS.this_cCursorMFas         = "xMFas"
            THIS.this_cCursorOpi          = "xOpi"
            THIS.this_cCursorPesa         = "xPesa"
            THIS.this_cCursorNensiSaida   = "xNensi"

            *-- Nomes canonicos dos cursores globais Fortyus
            THIS.this_cCursorOpd          = "crSigCdOpd"
            THIS.this_cCursorNecessidades = "crSigCdNec"

            *-- Cursor global de parametros
            THIS.this_cCursorParametros = "crSigCdPam"

            *-- Cursores proprios (grades desta tela)
            THIS.this_cCursorPends   = "TmpPends"
            THIS.this_cCursorPNensi  = "xPNensi"
            THIS.this_cCursorPNensiT = "xPNensiT"

            *-- Linha corrente de TmpPends comeca vazia
            THIS.this_lFlag   = .F.
            THIS.this_cEmps   = ""
            THIS.this_cDopps  = ""
            THIS.this_nNumps  = 0
            THIS.this_dDatas  = {}
            THIS.this_cObs    = ""
            THIS.this_cGrupo  = ""
            THIS.this_cConta  = ""
            THIS.this_nTPesos = 0
            THIS.this_cUsuars = ""

            *-- Nivel/operacao corrente comeca vazio
            THIS.this_cNivelSubn   = ""
            THIS.this_cNumeroNivel = ""
            THIS.this_cPuxaOrigem  = ""
            THIS.this_cPuxaDestino = ""
            THIS.this_lNumeroAnt   = .F.
            THIS.this_lBaixaSubN   = .F.
            THIS.this_nCompAgrus   = 0
            THIS.this_nSepPedras   = 0

            *-- Par chave/valor do proximo UPDATE comeca vazio
            THIS.this_cCidChavesAtual = ""
            THIS.this_lChkSubn        = .F.

            THIS.this_lFecharAposMarcar = .F.

            *-- Popular crSigCdPam com CuniPPads/TpPesas/Ouros. Padrao
            *-- canonico de ClienteBO.prg/SigOpMpdBO.prg (regra do projeto:
            *-- cursor global Fortyus de 1 linha tem de ser garantido no
            *-- Init do BO, nunca pressuposto). Sem isto, o "OK" estouraria
            *-- "Alias CRSIGCDPAM is not found" ao ler crSigCdPam.TpPesas.
            TRY
                IF USED("crSigCdPam")
                    USE IN crSigCdPam
                ENDIF

                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    loc_nResult = SQLEXEC(gnConnHandle, "SELECT CuniPPads, TpPesas, Ouros FROM SigCdPam", "cursor_4c_Pam_Temp")
                    IF loc_nResult > 0
                        SELECT * FROM cursor_4c_Pam_Temp INTO CURSOR crSigCdPam READWRITE
                        IF USED("cursor_4c_Pam_Temp")
                            USE IN cursor_4c_Pam_Temp
                        ENDIF
                        IF RECCOUNT("crSigCdPam") > 0
                            SELECT crSigCdPam
                            GO TOP
                        ENDIF
                    ELSE
                        *-- Fallback: cursor vazio para nao quebrar as
                        *-- checagens downstream (modo teste/SQL indisponivel)
                        CREATE CURSOR crSigCdPam (CuniPPads C(3), TpPesas N(1,0), Ouros C(14))
                        APPEND BLANK
                    ENDIF
                ELSE
                    *-- Modo teste (gnConnHandle nao inicializado)
                    CREATE CURSOR crSigCdPam (CuniPPads C(3), TpPesas N(1,0), Ouros C(14))
                    APPEND BLANK
                ENDIF
            CATCH TO loc_oErroPam
                IF !USED("crSigCdPam")
                    CREATE CURSOR crSigCdPam (CuniPPads C(3), TpPesas N(1,0), Ouros C(14))
                    APPEND BLANK
                ENDIF
            ENDTRY

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - sobrescreve BusinessBase (PROTECTED, so chamado de
    * dentro da classe - regra #51). Nao ha registro "corrente" de SigCdNec
    * como nos BOs CRUD de cadastro: cada UPDATE de Marcar()/Desmarcar() (fase
    * posterior) seta this_cCidChavesAtual IMEDIATAMENTE antes de chamar
    * THIS.Atualizar(), que eh quem chama RegistrarAuditoria(). Mesmo padrao
    * de SigOpMpdBO.prg (mesma familia de tela).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChavesAtual
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - sobrescreve BusinessBase (PUBLIC na base, logo PUBLIC
    * aqui tambem - regra #51: metodo que o Form chama de fora nunca pode ser
    * PROTECTED em nenhum nivel da heranca).
    *
    * Le a linha CORRENTE de TmpPends (grade de selecao, Create Cursor do
    * Init legado: Flag l, Emps c(3), Dopps c(20), Numps n(10), Datas d Null,
    * Obss m Null, Grupo c(10), Conta c(10), TPesos n(12,2), Usuars c(10))
    * para as propriedades this_lFlag/this_cEmps/this_cDopps/this_nNumps/
    * this_dDatas/this_cObs/this_cGrupo/this_cConta/this_nTPesos/this_cUsuars -
    * MESMA ordem do Create Cursor (regra #42). Equivale ao que o legado faz
    * lendo TmpPends.<campo> direto dentro de marca/desmarca (o dialogo opera
    * SEMPRE sobre a linha em que a grade esta posicionada).
    *
    * `Datas` pode chegar como DATE ou DATETIME (coluna Null do cursor local)
    * - a leitura passa por ConverterParaData(), NUNCA por TTOD() direto
    * (regra #16: TTOD com DATE dispara o erro 11 em runtime).
    *
    * Sem par_cAliasCursor assume this_cCursorPends, que eh o caso de uso
    * normal; o parametro existe porque a assinatura da base o tem e porque o
    * Form pode querer ler outro cursor de MESMA estrutura.
    *
    * Guarda de RECCOUNT/EOF/BOF obrigatoria: cursor vazio ou posicionado no
    * fim leria campo inexistente. Devolve .F. nesse caso, sem mexer nas
    * propriedades. Preserva a area de trabalho corrente - este dialogo roda
    * na data session do form PAI, que tem varios cursores abertos.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_cAliasAnterior

        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            ALLTRIM(par_cAliasCursor), THIS.this_cCursorPends)

        IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)
            loc_cAliasAnterior = ALIAS()

            SELECT (loc_cAlias)

            IF RECCOUNT() > 0 AND !EOF() AND !BOF()
                THIS.this_lFlag   = ConverterParaLogico(Flag)
                THIS.this_cEmps   = TratarNulo(Emps, "")
                THIS.this_cDopps  = TratarNulo(Dopps, "")
                THIS.this_nNumps  = TratarNulo(Numps, 0)
                THIS.this_dDatas  = ConverterParaData(Datas)
                THIS.this_cObs    = TratarNulo(Obss, "")
                THIS.this_cGrupo  = TratarNulo(Grupo, "")
                THIS.this_cConta  = TratarNulo(Conta, "")
                THIS.this_nTPesos = TratarNulo(TPesos, 0)
                THIS.this_cUsuars = TratarNulo(Usuars, "")

                loc_lSucesso = .T.
            ENDIF

            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF
        ELSE
            THIS.this_cMensagemErro = "Cursor da grade de sele" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o est" + CHR(225) + " aberto."
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - sobrescreve BusinessBase (PUBLIC na base, logo PUBLIC aqui -
    * regra #51). UNICO ponto deste BO que grava no SQL Server.
    *
    * Legado (identico em marca e em desmarca - Pattern #196/#213 do
    * CorretorAutomatico ja documenta o bug de injecao que esse texto sofreu
    * em outros forms; aqui a transcricao eh literal, sem ".Value" nenhum):
    *   lcQuery = [Update SigCdNec ] + ; [Set ChkSubn = ?pNot ] + ; [Where
    *             cIdChaves = '] + LocalNens.cIdChaves + [']
    *   If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    *
    * O legado grava em LOTE (Scan sobre as linhas de SigCdNec que
    * compartilham o EmpDNps do "nivel"), mas CADA volta do Scan eh um UPDATE
    * de UMA linha pela PK - que eh exatamente o contrato de Atualizar(). Por
    * isso o lote fica em Marcar()/Desmarcar() (fase posterior, que varrem o
    * cursor de chaves) e o UPDATE de uma linha fica aqui, num ponto unico,
    * com a auditoria.
    *
    * ChkSubn eh `bit NOT NULL` no schema, por isso o literal 1/0 (nao .T./
    * .F., que o ODBC nao aceita em SQL concatenado).
    *
    * NAO existe Inserir() correspondente: medido contra docs/schema.sql, dos
    * alvos de escrita do dump legado so SigCdNec eh TABELA - TmpOperacao,
    * xMFas, xOpi, xPesa e xNensi nao constam das 682 tabelas, sao cursores
    * LOCAIS do form pai (este dialogo roda na data session dele). Nenhum
    * `Insert Into` do legado tem tabela por destino, logo escrever um INSERT
    * aqui significaria inventar a lista de colunas, o que a regra #22
    * proibe (a lista vem do schema, nunca de adivinhacao). O comportamento
    * padrao herdado de BusinessBase (recusar a operacao e reportar pelo
    * ExibirFalha do Salvar) ja eh o correto. Mesma decisao de SigOpMpdBO.prg.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        *-- TRY aqui (e nao so no wrapper de Marcar/Desmarcar) porque este
        *-- metodo eh PUBLIC: handle de conexao invalido faz o SQLEXEC
        *-- disparar EXCECAO em vez de devolver -1, e sem TRY um chamador de
        *-- fora veria o Program Error cru do VFP. Nao ha RETURN dentro do
        *-- TRY (regra #1): o corpo inteiro eh IF/ELSE sobre loc_lSucesso.
        TRY
            IF EMPTY(THIS.this_cCidChavesAtual)
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado: " + ;
                    "nenhum registro de SigCdNec para atualizar."
                MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- ChkSubn eh bit: literal 1/0. ConverterParaLogico garante
                *-- o LOGICO que o IIF exige - se um chamador futuro atribuir
                *-- 1/0 (numerico) a this_lChkSubn, IIF(numerico,...)
                *-- estouraria o erro 11 do VFP9 em runtime.
                loc_cSQL = "UPDATE SigCdNec SET ChkSubn = " + ;
                    IIF(ConverterParaLogico(THIS.this_lChkSubn), "1", "0") + ;
                    " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChavesAtual)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                        "Falha na conex" + CHR(227) + "o (Update - SigCdNec)" + CHR(13) + ;
                        CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar SigCdNec:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarCursorQuery - equivalente do "ThisForm.poDataMgr.CursorQuery(
    * tabela, cursor, campo, valor, campos)" do legado: um SELECT por
    * igualdade num campo, jogado num cursor local.
    *
    * PROTECTED: so eh chamado de dentro da classe (regra #51).
    *
    * O literal do WHERE sai do helper que corresponde ao TIPO do valor
    * (regra #5 - os helpers JA devolvem com as aspas, nunca acrescentar).
    * O cursor anterior eh fechado com USE IN antes do SQLEXEC: so USED()
    * nao basta como guarda, e TABLEREVERT em cursor sem buffering DISPARA
    * o erro 1586 (regra #52) - USE IN fecha o alias mesmo com buffer sujo.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarCursorQuery(par_cTabela, par_cCursor, par_cCampo, par_uValor, par_cCampos)
        LOCAL loc_cSQL, loc_cCamposSQL, loc_cFiltro, loc_nResultado

        loc_cCamposSQL = IIF(VARTYPE(par_cCampos) = "C" AND !EMPTY(par_cCampos), par_cCampos, "*")

        DO CASE
        CASE VARTYPE(par_uValor) = "N"
            loc_cFiltro = FormatarNumeroSQL(par_uValor, 0)
        CASE VARTYPE(par_uValor) = "T" OR VARTYPE(par_uValor) = "D"
            loc_cFiltro = FormatarDataSQL(par_uValor)
        OTHERWISE
            loc_cFiltro = EscaparSQL(par_uValor)
        ENDCASE

        loc_cSQL = "SELECT " + loc_cCamposSQL + " FROM " + par_cTabela + ;
            " WHERE " + par_cCampo + " = " + loc_cFiltro

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursor)

        IF loc_nResultado > 0 AND USED(par_cCursor)
            SELECT (par_cCursor)
            GO TOP
        ENDIF

        RETURN loc_nResultado > 0
    ENDPROC

    *==========================================================================
    * CriarCursoresGrades - cria os TRES cursores das grades desta tela, com
    * a MESMA estrutura e os MESMOS indices do Init legado.
    *
    * PROTECTED: so eh chamado de dentro da classe (regra #51).
    *
    * TmpPends (grade de selecao) eh transcricao literal do
    *   "Create Cursor TmpPends(Flag l, Emps c(3), Dopps c(20), Numps n(10),
    *    Datas d Null, Obss m Null, Grupo c(10), Conta c(10), TPesos n(12,2),
    *    Usuars c(10))" - mesma ORDEM de campos, que eh a ordem documentada
    *   no cabecalho deste BO.
    *
    * xPNensi/xPNensiT (grades de detalhe) vem no legado de
    *   "Select *, <10 colunas extra> From CrSigCdNei Where 1=0 Into Cursor ..."
    * ou seja: TODAS as colunas de SigCdNei MAIS as 10 calculadas. Como
    * crSigCdNei nao eh um cursor desta arquitetura, a estrutura eh declarada
    * explicitamente - as 43 colunas saem de docs/schema.sql (lido com
    * Get-Content -Raw, regra #14) e as 10 extras dos "as <nome>" do SELECT
    * legado (000000.000 -> N(10,3), Space(3) -> C(3), .f. -> L, 0 -> N(1)).
    * NENHUMA coluna foi omitida: o "OK" (fase posterior) copia xPNensi para
    * o xNensi do form pai e pode ler qualquer uma delas.
    *
    * SET NULL ON antes do CREATE CURSOR porque Datas/Obss/DataTrans sao
    * NULL-aveis (regra do projeto: SQL Server devolve NULL e, sem isso, o
    * INSERT falha).
    *==========================================================================
    PROTECTED PROCEDURE CriarCursoresGrades()
        LOCAL loc_cAliasPends, loc_cAliasPNensi, loc_cAliasPNensiT

        loc_cAliasPends   = THIS.this_cCursorPends
        loc_cAliasPNensi  = THIS.this_cCursorPNensi
        loc_cAliasPNensiT = THIS.this_cCursorPNensiT

        SET NULL ON

        *-- TmpPends: grade de selecao -------------------------------------
        IF USED(loc_cAliasPends)
            USE IN (loc_cAliasPends)
        ENDIF
        CREATE CURSOR (loc_cAliasPends) ( ;
            Flag L, Emps C(3), Dopps C(20), Numps N(10), Datas D NULL, Obss M NULL, ;
            Grupo C(10), Conta C(10), TPesos N(12,2), Usuars C(10))
        INDEX ON Numps TAG Numps
        INDEX ON Emps + Dopps + STR(Numps, 10) TAG EmpDopNum

        *-- xPNensi: grade "Itens" -----------------------------------------
        IF USED(loc_cAliasPNensi)
            USE IN (loc_cAliasPNensi)
        ENDIF
        CREATE CURSOR (loc_cAliasPNensi) ( ;
            Aqtds N(9,3), Cats C(6), CDescs C(40), CGrus C(3), CMats C(14), ;
            Coefs N(7,4), ContaFs C(10), CUnis C(3), DataTrans T NULL, Dopps C(20), ;
            Emps C(3), Fators N(7,4), FlagIncs L, GrupoFins C(10), GrupoFs C(10), ;
            Moedas C(3), Moeds C(3), NEnvs N(10), Nops N(10), Numps N(10), ;
            Obss C(40), Pesos N(9,3), Qtds N(9,3), Servicos L, TpOps C(15), ;
            Locals C(10), NTrans N(6), CidChaves C(20), NLotes N(10), ;
            PesoFixs N(1), CoefInfs N(7,4), CRetrabs C(6), EmpDNPs C(33), ;
            EmpDopNums C(29), ChkSubn L, CodCors C(4), CodNConfs C(10), ;
            CodTams C(4), Peso2s N(9,3), CustoFs N(11,3), MoeCusFs C(3), ;
            Estorno N(1), PVens N(11,3), ;
            Ps2FaseAnt N(10,3), cUnips C(3), OsRets L, Retrabs L, MatPrincs C(10), ;
            PsFaseAnt N(10,3), Descs C(60), Rateio N(1), Visivel L, QtFaseAnt N(10,3))
        INDEX ON Cats TAG Cats
        INDEX ON STR(NEnvs, 10) + CMats + TpOps FOR Visivel TAG NEnvTpops
        INDEX ON Emps + Dopps + STR(Numps, 10) FOR Visivel TAG EmpDopNum

        *-- xPNensiT: grade "Total" (mesma estrutura de xPNensi) -----------
        IF USED(loc_cAliasPNensiT)
            USE IN (loc_cAliasPNensiT)
        ENDIF
        CREATE CURSOR (loc_cAliasPNensiT) ( ;
            Aqtds N(9,3), Cats C(6), CDescs C(40), CGrus C(3), CMats C(14), ;
            Coefs N(7,4), ContaFs C(10), CUnis C(3), DataTrans T NULL, Dopps C(20), ;
            Emps C(3), Fators N(7,4), FlagIncs L, GrupoFins C(10), GrupoFs C(10), ;
            Moedas C(3), Moeds C(3), NEnvs N(10), Nops N(10), Numps N(10), ;
            Obss C(40), Pesos N(9,3), Qtds N(9,3), Servicos L, TpOps C(15), ;
            Locals C(10), NTrans N(6), CidChaves C(20), NLotes N(10), ;
            PesoFixs N(1), CoefInfs N(7,4), CRetrabs C(6), EmpDNPs C(33), ;
            EmpDopNums C(29), ChkSubn L, CodCors C(4), CodNConfs C(10), ;
            CodTams C(4), Peso2s N(9,3), CustoFs N(11,3), MoeCusFs C(3), ;
            Estorno N(1), PVens N(11,3), ;
            Ps2FaseAnt N(10,3), cUnips C(3), OsRets L, Retrabs L, MatPrincs C(10), ;
            PsFaseAnt N(10,3), Descs C(60), Rateio N(1), Visivel L, QtFaseAnt N(10,3))
        INDEX ON Emps + Dopps + STR(Numps, 10) + CMats + STR(Nops, 10) FOR Visivel TAG EmpDopNum

        SET NULL OFF
    ENDPROC

    *==========================================================================
    * CarregarNivel - resolve o "nivel" (crSigCdOpd) da necessidade corrente
    * do form pai. Transcricao das DUAS buscas que o Init legado faz em
    * sequencia:
    *
    *   =Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')   -> Nivels/ConOSubs/ConDSubs
    *   =Seek(_DoppsNivel,   'crSigCdOpd', 'Dopps')   -> NDopps (e, no laco de
    *                                                     detalhe, CompAgrus/
    *                                                     SepPedras)
    *
    * A SEGUNDA busca eh a que vale para CompAgrus/SepPedras: no legado o
    * laco de detalhe le "crSigCdOpd.CompAgrus"/"CrSigCdOpd.SepPedras" com o
    * ponteiro parado no registro do NIVEL, nao no da operacao.
    *
    * Numeras/BxAutos vem junto porque o "OK" (fase posterior) precisa dos
    * dois (this_lNumeroAnt/this_lBaixaSubN), exatamente como o legado, que
    * os le do mesmo registro.
    *
    * PROTECTED: so eh chamado de dentro da classe (regra #51).
    *==========================================================================
    PROTECTED PROCEDURE CarregarNivel(par_cDoppsNecessidade)
        LOCAL loc_lSucesso, loc_cNivel

        loc_lSucesso = .F.

        *-- 1a busca: a operacao corrente aponta para o Dopps do nivel
        IF THIS.ExecutarCursorQuery("SigCdOpd", "cursor_4c_LocalOpd", "Dopps", ;
                par_cDoppsNecessidade, "Nivels, ConOSubs, ConDSubs")
            THIS.this_cNivelSubn   = cursor_4c_LocalOpd.Nivels
            THIS.this_cPuxaOrigem  = TRANSFORM(cursor_4c_LocalOpd.ConOSubs)
            THIS.this_cPuxaDestino = TRANSFORM(cursor_4c_LocalOpd.ConDSubs)

            loc_cNivel = THIS.this_cNivelSubn

            *-- 2a busca: o registro do NIVEL (Dopps = Nivels) - eh dele que
            *-- saem NDopps/CompAgrus/SepPedras/Numeras/BxAutos
            IF THIS.ExecutarCursorQuery("SigCdOpd", "cursor_4c_LocalOpd", "Dopps", ;
                    loc_cNivel, "NDopps, CompAgrus, SepPedras, Numeras, BxAutos")
                *-- legado: _NumeroNivel = Str(crSigCdOpd.NDopps, 2)
                THIS.this_cNumeroNivel = STR(cursor_4c_LocalOpd.NDopps, 2)
                THIS.this_nCompAgrus   = NVL(cursor_4c_LocalOpd.CompAgrus, 0)
                THIS.this_nSepPedras   = NVL(cursor_4c_LocalOpd.SepPedras, 0)
                *-- legado: _NumeroAnt = (crSigCdOpd.Numeras = 3)
                THIS.this_lNumeroAnt   = (NVL(cursor_4c_LocalOpd.Numeras, 0) = 3)
                *-- legado: _BaixaSubN = (crSigCdOpd.BxAutos = 1)
                IF VARTYPE(cursor_4c_LocalOpd.BxAutos) = "L"
                    THIS.this_lBaixaSubN = cursor_4c_LocalOpd.BxAutos
                ELSE
                    THIS.this_lBaixaSubN = (NVL(cursor_4c_LocalOpd.BxAutos, 0) = 1)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        ENDIF

        IF USED("cursor_4c_LocalOpd")
            USE IN cursor_4c_LocalOpd
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPendencias - PUBLICO (o Form chama de fora: regra #51).
    * Wrapper com o TRY/CATCH; o corpo fica em CarregarPendenciasExec porque
    * as guardas de cursor/conexao abortam no meio e em VFP9 eh PROIBIDO dar
    * RETURN de dentro de um TRY/CATCH (regra #1). Mesmo par wrapper/Exec de
    * SigOpMpdBO.prg (mesma familia de tela).
    *==========================================================================
    PROCEDURE CarregarPendencias()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.CarregarPendenciasExec()
        CATCH TO loc_oErro
            WAIT CLEAR
            THIS.this_cMensagemErro = "Erro ao carregar movimenta" + CHR(231) + CHR(245) + ;
                "es pendentes:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPendenciasExec - corpo de CarregarPendencias(). Transcricao do
    * trecho do Init legado que vai do "Create Cursor TmpPends" ate o
    * "Select TmpPends / Go Bottom" (o bind das grades eh do FORM, nao daqui).
    *
    * PROTECTED: so eh chamado de dentro da classe (regra #51).
    *
    * Sequencia do legado, na mesma ordem:
    *   1. Create Cursor TmpPends/xPNensi/xPNensiT (-> CriarCursoresGrades)
    *   2. Select TmpOperacao / Delete All For Empty(Codigos)
    *   3. Seek do nivel em crSigCdOpd (-> CarregarNivel)
    *   4. pEd1/pEd2 + Select ... From SigCdNec -> LocalNens
    *   5. Scan LocalNens: Insert Into TmpPends + carga do detalhe
    *   6. Select xPNensi / Scan -> consolida em xPNensiT
    *==========================================================================
    PROTECTED PROCEDURE CarregarPendenciasExec()
        LOCAL loc_cAliasNens, loc_cAliasOperacao, loc_cAliasPends
        LOCAL loc_cNensDopps, loc_cNensGrupoOs, loc_cNensContaOs
        LOCAL loc_cEd1, loc_cEd2, loc_cSQL, loc_nResultado, loc_lFlagMarcada

        loc_cAliasNens     = THIS.this_cCursorNens
        loc_cAliasOperacao = THIS.this_cCursorOperacao
        loc_cAliasPends    = THIS.this_cCursorPends

        *-- O dialogo roda na data session do form PAI: TmpNens (necessidade
        *-- corrente) e TmpOperacao (codigos ja selecionados) tem de estar
        *-- abertos por ele. Sem os dois nao ha o que carregar.
        IF !USED(loc_cAliasNens) OR !USED(loc_cAliasOperacao)
            THIS.this_cMensagemErro = "Cursores do formul" + CHR(225) + "rio chamador " + ;
                "(TmpNens/TmpOperacao) n" + CHR(227) + "o est" + CHR(227) + "o abertos."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                "indispon" + CHR(237) + "vel."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            RETURN .F.
        ENDIF

        *-- Necessidade corrente do form pai (o legado le TmpNens.Dopps/
        *-- GrupoOs/ContaOs direto, dentro do Init)
        SELECT (loc_cAliasNens)
        loc_cNensDopps   = Dopps
        loc_cNensGrupoOs = GrupoOs
        loc_cNensContaOs = ContaOs

        *-- 1. cursores das tres grades
        THIS.CriarCursoresGrades()

        *-- 2. legado: Select TmpOperacao / Delete All For Empty(Codigos)
        SELECT (loc_cAliasOperacao)
        DELETE ALL FOR EMPTY(Codigos)

        *-- 3. nivel/configuracao (crSigCdOpd)
        IF !THIS.CarregarNivel(loc_cNensDopps)
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalOpd)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- 4. faixa EmpDNPs. Chave POSICIONAL de char(33) = Emps char(3) +
        *-- Dopps char(20) + Str(Numps,10): PADR explicito em cada parte,
        *-- NUNCA ALLTRIM (regra #42 - ALLTRIM nas partes encurta a chave e o
        *-- BETWEEN devolve ZERO linha, sem erro nenhum). A soma 3+20+10 = 33
        *-- confere com EmpDNPs char(33) do schema. Legado:
        *--   pEd1 = ThisForm.pEmps + _DoppsNivel + '         0'
        *--   pEd2 = ThisForm.pEmps + _DoppsNivel + '9999999999'
        loc_cEd1 = PADR(THIS.this_cEmpresa, 3) + PADR(THIS.this_cNivelSubn, 20) + STR(0, 10)
        loc_cEd2 = PADR(THIS.this_cEmpresa, 3) + PADR(THIS.this_cNivelSubn, 20) + STR(9999999999, 10)

        WAIT WINDOW "Aguarde!!! Selecionando Movimenta" + CHR(231) + CHR(245) + ;
            "es Pendentes..." NOWAIT

        *-- SQL quebrado em varias linhas (regra do projeto: nunca uma linha
        *-- longa unica). ChkSubn eh `bit`: o legado compara com ?llSubn, que
        *-- vale .f. - aqui o literal 0, que eh o que o ODBC aceita em SQL
        *-- concatenado.
        loc_cSQL = "SELECT Emps, Dopps, Numps, Datas, GrupoOs, ContaOs," + ;
            " ChkSubn, TotPesos, Usuars, Obss" + ;
            " FROM SigCdNec" + ;
            " WHERE EmpDNPs BETWEEN " + EscaparSQL(loc_cEd1) + " AND " + EscaparSQL(loc_cEd2) + ;
            " AND GrupoDs = " + EscaparSQL(loc_cNensGrupoOs) + ;
            " AND ContaDs = " + EscaparSQL(loc_cNensContaOs) + ;
            " AND ChkSubn = 0"

        IF USED("cursor_4c_LocalNens")
            USE IN cursor_4c_LocalNens
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNens")

        IF loc_nResultado < 1
            WAIT CLEAR
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNens)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- 5. uma linha de TmpPends por necessidade ainda em aberto, e para
        *-- cada uma o detalhe (SigCdNei) em xPNensi
        SELECT cursor_4c_LocalNens
        SCAN
            *-- legado: _Flag = Seek(Val(_NumeroNivel + Transform(Numps,
            *-- '@L 9999999999')), 'TmpOperacao', 'Codigos') - a pendencia
            *-- ja escolhida pelo usuario nasce marcada
            loc_lFlagMarcada = SEEK(VAL(THIS.this_cNumeroNivel + ;
                TRANSFORM(cursor_4c_LocalNens.Numps, "@L 9999999999")), ;
                loc_cAliasOperacao, "Codigos")

            *-- Datas eh `datetime NULL` no schema e TmpPends.Datas eh DATE:
            *-- ConverterParaData normaliza DATE/DATETIME/NULL (regra #16 -
            *-- TTOD direto estoura o erro 11 se o valor nao for DATETIME)
            INSERT INTO (loc_cAliasPends) ;
                (Flag, Emps, Dopps, Numps, Datas, Grupo, Conta, TPesos, Usuars, Obss) ;
                VALUES (loc_lFlagMarcada, cursor_4c_LocalNens.Emps, ;
                    cursor_4c_LocalNens.Dopps, cursor_4c_LocalNens.Numps, ;
                    ConverterParaData(cursor_4c_LocalNens.Datas), ;
                    cursor_4c_LocalNens.GrupoOs, cursor_4c_LocalNens.ContaOs, ;
                    cursor_4c_LocalNens.TotPesos, cursor_4c_LocalNens.Usuars, ;
                    NVL(cursor_4c_LocalNens.Obss, ""))

            THIS.CarregarItensDaPendencia(cursor_4c_LocalNens.Emps, ;
                cursor_4c_LocalNens.Dopps, cursor_4c_LocalNens.Numps)

            *-- restaura a area de trabalho: CarregarItensDaPendencia muda o
            *-- alias corrente, e o ENDSCAN precisa estar em LocalNens
            SELECT cursor_4c_LocalNens
        ENDSCAN

        *-- 6. consolidacao xPNensi -> xPNensiT
        THIS.ConsolidarTotaisPendencias()

        WAIT CLEAR

        IF USED("cursor_4c_LocalNens")
            USE IN cursor_4c_LocalNens
        ENDIF
        IF USED("cursor_4c_LocalNensi")
            USE IN cursor_4c_LocalNensi
        ENDIF
        IF USED("cursor_4c_LocalPro")
            USE IN cursor_4c_LocalPro
        ENDIF

        *-- legado, no fim do Init: Select TmpPends / Go Bottom
        SELECT (loc_cAliasPends)
        GO BOTTOM

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarItensDaPendencia - detalhe (SigCdNei) de UMA pendencia, somado
    * em xPNensi. Transcricao LITERAL do laco aninhado do Init legado (o
    * "Select LocalNensi / Scan / Scan While (NEnvs = _NEnv)"), incluindo as
    * expressoes de rateio, os guards de FlagIncs/CompAgrus/SepPedras e o
    * "Skip -1" - regra #17: formula e condicao que a cercam sao REGRA DE
    * NEGOCIO e se TRANSCREVEM, nunca se reescrevem.
    *
    * PROTECTED: so eh chamado de dentro da classe (regra #51).
    *
    * Tres caminhos, na ordem do legado:
    *   a) material comum (nao servico, com CMats, sem Cats): insere a linha
    *      "crua" e, quando o rateio nao eh 5, AGRUPA por envelope+material+
    *      tipo somando QtFaseAnt/PsFaseAnt/Ps2FaseAnt/Qtds/Pesos;
    *   b) servico ou item de categoria: agrupa por Cats (ou insere sempre,
    *      quando FlagIncs) e soma Qtds;
    *   c) rateio 5 (Nops = 0): so a linha crua, sem agrupar.
    *
    * As variaveis PRIVATE _TotalNop/_RecNensi do legado NAO foram portadas:
    * sao atribuidas e nunca lidas em nenhum dos dois blocos onde aparecem
    * (linhas 1677-1678 e 2467-2468 do dump) - o reposicionamento quem faz eh
    * o "Skip -1".
    *==========================================================================
    PROTECTED PROCEDURE CarregarItensDaPendencia(par_cEmps, par_cDopps, par_nNumps)
        LOCAL loc_cAliasNensi, loc_cAliasPro, loc_cAliasPNensi, loc_cChvNens
        LOCAL loc_nNEnv, loc_nRateio, loc_lVisivel, loc_lServico
        LOCAL loc_cBMat, loc_cDMat, loc_cCMat, loc_cGMat, loc_cCatMat, loc_cTMat
        LOCAL loc_nPs2Anterior

        loc_cAliasNensi  = "cursor_4c_LocalNensi"
        loc_cAliasPro    = "cursor_4c_LocalPro"
        loc_cAliasPNensi = THIS.this_cCursorPNensi

        *-- Chave POSICIONAL char(33) (regra #42): PADR explicito, NUNCA
        *-- ALLTRIM. Legado: _ChvNens = Emps + Dopps + Str(Numps, 10)
        loc_cChvNens = PADR(par_cEmps, 3) + PADR(par_cDopps, 20) + STR(par_nNumps, 10)

        IF !THIS.ExecutarCursorQuery("SigCdNei", loc_cAliasNensi, "EmpDNPs", loc_cChvNens, ;
                "Emps, Dopps, Numps, Nenvs, CMats, Nops, Servicos, Cats, CDescs, Qtds, " + ;
                "Pesos, TpOps, FlagIncs, CUnis, Obss, Fators, Moedas, GrupoFins, Peso2s")
            RETURN .F.
        ENDIF

        SELECT (loc_cAliasNensi)
        SCAN
            loc_nNEnv = cursor_4c_LocalNensi.NEnvs

            SCAN WHILE (NEnvs = loc_nNEnv)
                *-- Produto do componente (descricao/unidade/grupo/Varias)
                IF !THIS.ExecutarCursorQuery("SigCdPro", loc_cAliasPro, "CPros", ;
                        cursor_4c_LocalNensi.CMats, "DPros, CUnis, CGrus, Varias")
                    SELECT (loc_cAliasNensi)
                    LOOP
                ENDIF

                IF cursor_4c_LocalNensi.Nops = 0
                    loc_nRateio  = 5
                    loc_lVisivel = .T.
                ELSE
                    *-- Varias eh numeric(1,0): comparacao numerica
                    loc_nRateio  = IIF(NVL(cursor_4c_LocalPro.Varias, 0) = 1, 2, 3)
                    loc_lVisivel = .F.
                ENDIF

                *-- Servicos eh `bit`: ConverterParaLogico garante o LOGICO
                *-- (regra #13 - bit chega ora Logico ora Numerico conforme
                *-- o driver, e comparar Logico com 1 estoura type mismatch)
                loc_lServico = ConverterParaLogico(cursor_4c_LocalNensi.Servicos)

                IF !loc_lServico AND !EMPTY(cursor_4c_LocalNensi.CMats) ;
                        AND EMPTY(cursor_4c_LocalNensi.Cats)

                    INSERT INTO (loc_cAliasPNensi) ;
                        (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, QtFaseAnt, Qtds, ;
                         PsFaseAnt, Pesos, Visivel, Rateio, TpOps, Cats, FlagIncs, CUnis, ;
                         CGrus, Obss, aQtds, Peso2s, Ps2FaseAnt) ;
                        VALUES (cursor_4c_LocalNensi.Emps, cursor_4c_LocalNensi.Dopps, ;
                            cursor_4c_LocalNensi.Numps, cursor_4c_LocalNensi.Nops, ;
                            cursor_4c_LocalNensi.NEnvs, cursor_4c_LocalNensi.CMats, ;
                            cursor_4c_LocalNensi.CDescs, cursor_4c_LocalNensi.Qtds, ;
                            cursor_4c_LocalNensi.Qtds, cursor_4c_LocalNensi.Pesos, ;
                            cursor_4c_LocalNensi.Pesos, loc_lVisivel, loc_nRateio, ;
                            cursor_4c_LocalNensi.TpOps, cursor_4c_LocalNensi.Cats, ;
                            ConverterParaLogico(cursor_4c_LocalNensi.FlagIncs), ;
                            cursor_4c_LocalNensi.CUnis, cursor_4c_LocalPro.CGrus, ;
                            cursor_4c_LocalNensi.Obss, cursor_4c_LocalNensi.Qtds, ;
                            cursor_4c_LocalNensi.Peso2s, cursor_4c_LocalNensi.Peso2s)

                    *-- Legado: componente "incluso" (FlagIncs) ou operacao que
                    *-- SEPARA pedras (SepPedras = 4) entra identificado na
                    *-- linha agrupada; senao entra em branco (so soma peso)
                    IF ConverterParaLogico(cursor_4c_LocalNensi.FlagIncs) ;
                            OR THIS.this_nSepPedras = 4
                        loc_cBMat   = cursor_4c_LocalNensi.CMats
                        loc_cDMat   = cursor_4c_LocalPro.DPros
                        loc_cCMat   = cursor_4c_LocalPro.CUnis
                        loc_cGMat   = cursor_4c_LocalPro.CGrus
                        loc_cCatMat = cursor_4c_LocalNensi.Cats
                    ELSE
                        loc_cBMat   = SPACE(14)
                        loc_cDMat   = ""
                        loc_cCMat   = ""
                        loc_cGMat   = ""
                        loc_cCatMat = SPACE(3)
                    ENDIF
                    loc_cTMat = cursor_4c_LocalNensi.TpOps

                    *-- Legado: If (crSigCdOpd.CompAgrus = 1) And
                    *-- CrSigCdOpd.SepPedras <> 4 -> _Nenv = 0. Zerar o
                    *-- envelope AQUI agrupa todos os componentes numa linha
                    *-- so, E encerra o "Scan While (NEnvs = _NEnv)" desta
                    *-- volta (o legado reatribui a PROPRIA variavel de
                    *-- controle do laco) - comportamento transcrito.
                    IF THIS.this_nCompAgrus = 1 AND THIS.this_nSepPedras != 4
                        loc_nNEnv = 0
                    ENDIF

                    IF loc_nRateio != 5
                        *-- Chave CHEIA do indice NEnvTpops (regra do
                        *-- projeto sobre SEEK parcial com SET EXACT ON):
                        *-- Str(NEnvs,10) + CMats char(14) + TpOps char(15)
                        IF !SEEK(STR(loc_nNEnv, 10) + PADR(loc_cBMat, 14) + PADR(loc_cTMat, 15), ;
                                loc_cAliasPNensi, "NEnvTpops")
                            INSERT INTO (loc_cAliasPNensi) ;
                                (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, ;
                                 CGrus, Visivel, Rateio, Cats, TpOps, Servicos) ;
                                VALUES (cursor_4c_LocalNensi.Emps, cursor_4c_LocalNensi.Dopps, ;
                                    cursor_4c_LocalNensi.Numps, loc_nNEnv, loc_nNEnv, ;
                                    loc_cBMat, loc_cDMat, loc_cCMat, loc_cGMat, .T., 1, ;
                                    loc_cCatMat, loc_cTMat, loc_lServico)
                        ELSE
                            IF EVALUATE(loc_cAliasPNensi + ".Rateio") != 1
                                REPLACE Rateio WITH 1 IN (loc_cAliasPNensi)
                            ENDIF
                        ENDIF

                        *-- Ps2FaseAnt: o legado le "xNensi.Ps2FaseAnt" (o
                        *-- cursor de SAIDA do form PAI) nas OUTRAS quatro
                        *-- linhas deste mesmo Replace, que leem xPNensi -
                        *-- comparando com o bloco gemeo do "OK" (linhas
                        *-- 2535-2539 do dump), que opera sobre xNensi e NAO
                        *-- tem a linha de Ps2FaseAnt, isto tem toda a cara
                        *-- de alias nao renomeado na copia. NAO foi
                        *-- "corrigido" aqui: trocar por xPNensi mudaria
                        *-- valor gravado em silencio, que eh exatamente o
                        *-- que a regra #17 proibe. Transcrito como esta, com
                        *-- guarda de alias ausente (fora do fluxo real do
                        *-- form pai xNensi pode nao existir) - DIVERGENCIA
                        *-- HERDADA, documentada para decisao humana.
                        loc_nPs2Anterior = 0
                        IF USED(THIS.this_cCursorNensiSaida) ;
                                AND TYPE(THIS.this_cCursorNensiSaida + ".Ps2FaseAnt") = "N"
                            loc_nPs2Anterior = EVALUATE(THIS.this_cCursorNensiSaida + ".Ps2FaseAnt")
                        ENDIF

                        SELECT (loc_cAliasPNensi)
                        REPLACE QtFaseAnt  WITH QtFaseAnt + cursor_4c_LocalNensi.Qtds, ;
                                PsFaseAnt  WITH PsFaseAnt + cursor_4c_LocalNensi.Pesos, ;
                                Ps2FaseAnt WITH loc_nPs2Anterior + cursor_4c_LocalNensi.Peso2s, ;
                                Qtds       WITH Qtds + cursor_4c_LocalNensi.Qtds, ;
                                Pesos      WITH Pesos + cursor_4c_LocalNensi.Pesos ;
                            IN (loc_cAliasPNensi)
                    ENDIF
                ELSE
                    *-- Servico ou item de categoria: agrupa por Cats, mas
                    *-- componente "incluso" (FlagIncs) sempre gera linha
                    IF !SEEK(PADR(cursor_4c_LocalNensi.Cats, 6), loc_cAliasPNensi, "Cats") ;
                            OR ConverterParaLogico(cursor_4c_LocalNensi.FlagIncs)
                        INSERT INTO (loc_cAliasPNensi) ;
                            (Emps, Dopps, Numps, CMats, CDescs, CUnis, CGrus, Visivel, ;
                             Rateio, FlagIncs, Cats, Servicos, Fators, Moedas, GrupoFins) ;
                            VALUES (cursor_4c_LocalNensi.Emps, cursor_4c_LocalNensi.Dopps, ;
                                cursor_4c_LocalNensi.Numps, cursor_4c_LocalNensi.CMats, ;
                                cursor_4c_LocalPro.DPros, cursor_4c_LocalPro.CUnis, ;
                                cursor_4c_LocalPro.CGrus, .T., 0, .T., ;
                                cursor_4c_LocalNensi.Cats, .T., cursor_4c_LocalNensi.Fators, ;
                                cursor_4c_LocalNensi.Moedas, cursor_4c_LocalNensi.GrupoFins)
                    ENDIF

                    REPLACE Qtds WITH Qtds + cursor_4c_LocalNensi.Qtds IN (loc_cAliasPNensi)
                ENDIF

                *-- Restaura a area de trabalho ANTES do ENDSCAN: o ramo de
                *-- cima faz "SELECT xPNensi" e a condicao "WHILE (NEnvs =
                *-- loc_nNEnv)" tem de ser avaliada em LocalNensi (o legado
                *-- se apoia no vinculo implicito do SCAN; aqui eh explicito)
                SELECT (loc_cAliasNensi)
            ENDSCAN

            *-- Legado: Skip -1. O "Scan While" sai JA passado do fim do
            *-- grupo; voltar um registro faz o ENDSCAN de fora pousar na
            *-- primeira linha do grupo seguinte.
            IF !BOF(loc_cAliasNensi)
                SKIP -1 IN (loc_cAliasNensi)
            ENDIF
        ENDSCAN

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConsolidarTotaisPendencias - roll-up de xPNensi em xPNensiT (a grade
    * "Total", que o botao Totaliza alterna com a de itens). Transcricao do
    * ultimo laco do Init legado ("Select xPnensi / Scan / Scatter Memvar
    * ...").
    *
    * PROTECTED: so eh chamado de dentro da classe (regra #51).
    *
    * SCATTER NAME (objeto) no lugar do "Scatter Memvar" do legado: mesmo
    * efeito, sem criar memvars de nome igual ao dos campos - o que tambem
    * evita a armadilha do prefixo "m." (as variaveis passam a ser
    * propriedades de um objeto loc_, dentro da convencao do projeto).
    *
    * Int(m.Nops/10000) eh o agrupador: a Ordem de Fabricacao eh a Ordem de
    * Producao sem os 4 ultimos digitos (a fase). Transcrito literalmente.
    *==========================================================================
    PROTECTED PROCEDURE ConsolidarTotaisPendencias()
        LOCAL loc_cAliasPNensi, loc_cAliasPNensiT, loc_oReg, loc_cEmpDnp, loc_nAQtds

        loc_cAliasPNensi  = THIS.this_cCursorPNensi
        loc_cAliasPNensiT = THIS.this_cCursorPNensiT

        IF !USED(loc_cAliasPNensi) OR !USED(loc_cAliasPNensiT)
            RETURN .F.
        ENDIF

        SELECT (loc_cAliasPNensiT)
        SET ORDER TO EmpDopNum

        SELECT (loc_cAliasPNensi)
        GO TOP
        SCAN
            SCATTER NAME loc_oReg

            *-- legado: m.Nops = Int(m.Nops/10000)
            loc_oReg.Nops = INT(loc_oReg.Nops / 10000)

            *-- Chave POSICIONAL char(33) (regra #42) + CMats char(14) +
            *-- Str(Nops,10) = 57, que eh a chave CHEIA do indice EmpDopNum
            *-- de xPNensiT (SEEK parcial nao casa com SET EXACT ON)
            loc_cEmpDnp = PADR(loc_oReg.Emps, 3) + PADR(loc_oReg.Dopps, 20) + ;
                STR(loc_oReg.Numps, 10)

            *-- legado: aQtds recebe "LocalNensi.Qtds" - leitura do cursor de
            *-- detalhe da volta ANTERIOR, que a esta altura esta parado na
            *-- ultima linha lida. Outra DIVERGENCIA HERDADA transcrita como
            *-- esta (ver nota de Ps2FaseAnt em CarregarItensDaPendencia):
            *-- "corrigir" para loc_oReg.aQtds mudaria valor em silencio.
            loc_nAQtds = 0
            IF USED("cursor_4c_LocalNensi") ;
                    AND TYPE("cursor_4c_LocalNensi.Qtds") = "N"
                loc_nAQtds = cursor_4c_LocalNensi.Qtds
            ENDIF

            SELECT (loc_cAliasPNensiT)
            IF !SEEK(loc_cEmpDnp + PADR(loc_oReg.CMats, 14) + STR(loc_oReg.Nops, 10))
                INSERT INTO (loc_cAliasPNensiT) ;
                    (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, Visivel, ;
                     CUnis, CGrus, aQtds) ;
                    VALUES (loc_oReg.Emps, loc_oReg.Dopps, loc_oReg.Numps, ;
                        loc_oReg.Nops, loc_oReg.Nops, loc_oReg.CMats, ;
                        loc_oReg.CDescs, .T., loc_oReg.CUnis, loc_oReg.CGrus, ;
                        loc_nAQtds)
            ENDIF

            *-- legado: Replace Qtds With Qtds + m.Qtds, Pesos With Pesos +
            *-- m.Pesos (sem clausula IN - area corrente = xPNensiT)
            REPLACE Qtds  WITH Qtds + loc_oReg.Qtds, ;
                    Pesos WITH Pesos + loc_oReg.Pesos ;
                IN (loc_cAliasPNensiT)

            *-- Restaura a area ANTES do ENDSCAN (o laco eh de xPNensi)
            SELECT (loc_cAliasPNensi)
        ENDSCAN

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Marcar - legado: SIGOPMPN.marca (ThisForm.Marca(), chamado pelo
    * CheckBox da coluna de selecao e pelo botao SelTudo). Marca a linha
    * CORRENTE de TmpPends (lida por THIS.CarregarDoCursor em
    * this_cEmps/this_cDopps/this_nNumps/this_dDatas) como pertencente ao
    * "nivel" da necessidade que o form pai esta atendendo (TmpNens),
    * checando duplicidade/numeracao-automatica/data ANTES de efetivar o
    * UPDATE em SigCdNec.
    *
    * par_lAutomatico - legado "_Automatico" (Parameters _Automatico): .T.
    * quando chamado em LOTE (SelTudo), que SUPRIME o MsgAviso de
    * "Movimentacao Ja Utilizada em Outra Operacao" (o legado so avisa no
    * clique individual do CheckBox - If Not _Automatico).
    *
    * PUBLIC (regra #51: o Form chama de fora).
    *==========================================================================
    PROCEDURE Marcar(par_lAutomatico)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.MarcarExec(par_lAutomatico)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao marcar movimenta" + CHR(231) + CHR(227) + ;
                "o pendente:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MarcarExec - corpo de Marcar(). PROTECTED (regra #51). Transcricao do
    * "marca" legado (linhas 1479-1575 do dump), exceto:
    *   - "This.ok.click" (chamado DENTRO do proprio marca quando Numeras =
    *     3) nao pode ser chamado daqui - este BO nao conhece o botao OK.
    *     THIS.this_lFecharAposMarcar sinaliza esse caso ao Form, que
    *     fecha o dialogo gravando tudo (CmdOkClick) apos um Marcar() com
    *     sucesso.
    *   - "Select TmpNens/TmpPends" (troca de work area sem leitura
    *     adicional) nao tem efeito a reproduzir nesta arquitetura.
    *==========================================================================
    PROTECTED PROCEDURE MarcarExec(par_lAutomatico)
        LOCAL loc_lAutomatico, loc_cAliasNens, loc_cAliasOpd, loc_cAliasPends
        LOCAL loc_nNumNivel, loc_lNumeroAnt, loc_lBaixaSubN, loc_lRetorna
        LOCAL loc_nContaMarcadas, loc_nRecnoPend, loc_cCidChaves, loc_lChkSubnAtual
        LOCAL loc_cSQL, loc_nResultado

        THIS.this_lFecharAposMarcar = .F.

        loc_lAutomatico = ConverterParaLogico(par_lAutomatico)

        loc_cAliasNens  = THIS.this_cCursorNens
        loc_cAliasOpd   = THIS.this_cCursorOpd
        loc_cAliasPends = THIS.this_cCursorPends

        IF !USED(loc_cAliasNens) OR !USED(loc_cAliasOpd) OR !USED(loc_cAliasPends)
            THIS.this_cMensagemErro = "Cursores do formul" + CHR(225) + "rio chamador n" + ;
                CHR(227) + "o est" + CHR(227) + "o abertos."
            RETURN .F.
        ENDIF

        *-- legado: =Seek(TmpPends.Dopps, 'crSigCdOpd', 'Dopps') / _NumNivel =
        *-- Val(Str(crSigCdOpd.Ndopps, 2) + Transform(TmpPends.Numps, '@L 9999999999'))
        IF !SEEK(THIS.this_cDopps, loc_cAliasOpd, "Dopps")
            THIS.this_cMensagemErro = "N" + CHR(237) + "vel/opera" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o encontrado (crSigCdOpd)."
            RETURN .F.
        ENDIF
        loc_nNumNivel = VAL(STR(EVALUATE(loc_cAliasOpd + ".NDopps"), 2) + ;
            TRANSFORM(THIS.this_nNumps, "@L 9999999999"))

        *-- legado: =Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps') / _NumeroAnt =
        *-- (crSigCdOpd.Numeras = 3) / _BaixaSubN = (crSigCdOpd.BxAutos = 1)
        IF !SEEK(EVALUATE(loc_cAliasNens + ".Dopps"), loc_cAliasOpd, "Dopps")
            THIS.this_cMensagemErro = "N" + CHR(237) + "vel da necessidade n" + CHR(227) + ;
                "o encontrado (crSigCdOpd)."
            RETURN .F.
        ENDIF
        loc_lNumeroAnt = (NVL(EVALUATE(loc_cAliasOpd + ".Numeras"), 0) = 3)
        loc_lBaixaSubN = (NVL(EVALUATE(loc_cAliasOpd + ".BxAutos"), 0) = 1)

        *-- legado: If _NumeroAnt / conta quantas linhas de TmpPends ja
        *-- estao marcadas (Flag) OU sao a linha corrente - "numeracao
        *-- automatica" so aceita 1 subnivel por vez
        IF loc_lNumeroAnt
            loc_nContaMarcadas = 0
            SELECT (loc_cAliasPends)
            loc_nRecnoPend = RECNO()
            SCAN
                IF Flag OR RECNO() = loc_nRecnoPend
                    loc_nContaMarcadas = loc_nContaMarcadas + 1
                ENDIF
            ENDSCAN
            SELECT (loc_cAliasPends)
            GOTO loc_nRecnoPend

            IF loc_nContaMarcadas > 1
                MsgAviso("Este Tipo de Opera" + CHR(231) + CHR(227) + "o S" + CHR(243) + ;
                    " Aceita 1 Subn" + CHR(237) + "vel!!!", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        loc_lRetorna = .T.

        *-- legado: If TmpPends.Datas > TmpNens.Datas
        IF !ISNULL(THIS.this_dDatas) AND !ISNULL(EVALUATE(loc_cAliasNens + ".Datas")) AND ;
                THIS.this_dDatas > EVALUATE(loc_cAliasNens + ".Datas")
            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o com diverg" + CHR(234) + ;
                "ncia de Datas!!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_lRetorna = .F.
        ENDIF

        *-- legado: CursorQuery('SigCdNec', 'LocalNens', 'EmpDNPs', _Nivel,
        *-- 'cIdChaves, ChkSubn') - _Nivel = Emps+Dopps+Str(Numps,10) da
        *-- linha CORRENTE de TmpPends (regra #42: chave POSICIONAL, PADR
        *-- explicito, NUNCA ALLTRIM)
        IF !THIS.ExecutarCursorQuery("SigCdNec", "cursor_4c_OkNec", "EmpDNPs", ;
                PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopps, 20) + STR(THIS.this_nNumps, 10), ;
                "cIdChaves, ChkSubn")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNens)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_cCidChaves    = cursor_4c_OkNec.cIdChaves
        loc_lChkSubnAtual = ConverterParaLogico(cursor_4c_OkNec.ChkSubn)

        *-- legado: If LocalNens.ChkSubn / If Not _Automatico / MsgBox ... /
        *-- _Retorna = .f.
        IF loc_lChkSubnAtual
            IF !loc_lAutomatico
                MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o J" + CHR(225) + " Utilizada em " + ;
                    "Outra Opera" + CHR(231) + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
            loc_lRetorna = .F.
        ENDIF

        *-- legado: If _Retorna And Not _Automatico / Update SigCdNec Set
        *-- cIdChaves = '<cid>' Where cIdChaves = '<cid>' - "toque" na
        *-- linha para detectar concorrencia (optimistic lock por
        *-- auto-update que nao muda valor nenhum)
        IF loc_lRetorna AND !loc_lAutomatico
            loc_cSQL = "UPDATE SigCdNec SET CidChaves = " + EscaparSQL(loc_cCidChaves) + ;
                " WHERE CidChaves = " + EscaparSQL(loc_cCidChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 1
                MsgAviso("Subnivel em Uso Por Outra Movimenta" + CHR(231) + CHR(227) + ;
                    "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lRetorna = .F.
            ENDIF
        ENDIF

        IF USED("cursor_4c_OkNec")
            USE IN cursor_4c_OkNec
        ENDIF

        IF !loc_lRetorna
            RETURN .F.
        ENDIF

        *-- legado: If _BaixaSubN / Update SigCdNec Set ChkSubn = ?pTru
        *-- Where cIdChaves = '<cid>' - pTru eh SEMPRE .T. - delega ao
        *-- contrato de Atualizar() (regra do BO: UNICO alvo de ChkSubn)
        IF loc_lBaixaSubN
            THIS.this_cCidChavesAtual = loc_cCidChaves
            THIS.this_lChkSubn        = .T.

            IF !THIS.Atualizar()
                RETURN .F.
            ENDIF
        ENDIF

        *-- legado: If _NumeroAnt / Select TmpNens / Go top / Replace
        *-- Numps With LocalNens.Numps, Obss With LocalNens.Obss - a
        *-- CursorQuery acima so trouxe cIdChaves/ChkSubn; widening para
        *-- incluir Numps/Obss eh NECESSARIO para este ramo funcionar (sem
        *-- isso "LocalNens.Numps" estouraria "Variable not found" -
        *-- DIVERGENCIA DOCUMENTADA, decisao humana: o dump legado pede
        *-- campos que a propria CursorQuery daquela linha nao selecionou).
        IF loc_lNumeroAnt
            IF THIS.ExecutarCursorQuery("SigCdNec", "cursor_4c_OkNecNum", "CidChaves", ;
                    loc_cCidChaves, "Numps, Obss")
                SELECT (loc_cAliasNens)
                GO TOP
                REPLACE Numps WITH cursor_4c_OkNecNum.Numps, ;
                        Obss  WITH NVL(cursor_4c_OkNecNum.Obss, "") ;
                    IN (loc_cAliasNens)

                IF USED("cursor_4c_OkNecNum")
                    USE IN cursor_4c_OkNecNum
                ENDIF
            ENDIF
        ENDIF

        *-- legado: If _NumeroAnt / This.ok.click - o BO nao conhece o
        *-- botao: sinaliza ao Form, que fecha o dialogo (CmdOkClick)
        THIS.this_lFecharAposMarcar = loc_lNumeroAnt

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Desmarcar - legado: SIGOPMPN.desmarca (ThisForm.Desmarca, chamado
    * pelo CheckBox ao desmarcar e pelo botao Apaga). Zera SigCdNec.ChkSubn
    * da linha CORRENTE de TmpPends (this_cEmps/this_cDopps/this_nNumps,
    * lidos por THIS.CarregarDoCursor). PUBLIC (regra #51).
    *==========================================================================
    PROCEDURE Desmarcar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.DesmarcarExec()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao desmarcar movimenta" + CHR(231) + CHR(227) + ;
                "o pendente:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * DesmarcarExec - corpo de Desmarcar(). PROTECTED (regra #51). O
    * "=Seek(TmpPends.Dopps, 'crSigCdOpd', 'Dopps')" do legado so
    * reposiciona o cursor (nunca lido depois, dentro de desmarca) - sem
    * efeito a reproduzir nesta arquitetura (nada aqui depende de ponteiro
    * de cursor global).
    *==========================================================================
    PROTECTED PROCEDURE DesmarcarExec()
        LOCAL loc_cCidChaves

        *-- legado: CursorQuery('SigCdNec', 'LocalNens', 'EmpDNPs', _Nivel,
        *-- 'cIdChaves') - chave POSICIONAL (regra #42)
        IF !THIS.ExecutarCursorQuery("SigCdNec", "cursor_4c_OkNec", "EmpDNPs", ;
                PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopps, 20) + STR(THIS.this_nNumps, 10), ;
                "cIdChaves")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNens)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_cCidChaves = cursor_4c_OkNec.cIdChaves

        IF USED("cursor_4c_OkNec")
            USE IN cursor_4c_OkNec
        ENDIF

        THIS.this_cCidChavesAtual = loc_cCidChaves
        THIS.this_lChkSubn        = .F.

        RETURN THIS.Atualizar()
    ENDPROC

    *==========================================================================
    * ConfirmarMovimentacoes - legado: SIGOPMPN.ok.Click. Para CADA
    * pendencia MARCADA (Flag) de TmpPends, grava o detalhe (fase/item) nos
    * cursores de SAIDA do form pai (xMFas/xOpi/xNensi), atualiza
    * SigCdNec.NAceites/ChkSubn e preenche TmpOperacao. PUBLIC (o Form
    * chama de fora - regra #51).
    *
    * "Set Step On" do legado (abre o depurador) NAO foi transcrito:
    * resquicio de debug do desenvolvedor, sem efeito de negocio.
    *==========================================================================
    PROCEDURE ConfirmarMovimentacoes()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.ConfirmarMovimentacoesExec()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao confirmar movimenta" + CHR(231) + CHR(245) + ;
                "es pendentes:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfirmarMovimentacoesExec - corpo de ConfirmarMovimentacoes().
    * PROTECTED (regra #51).
    *==========================================================================
    PROTECTED PROCEDURE ConfirmarMovimentacoesExec()
        LOCAL loc_cAliasPends, loc_cAliasOpd, loc_lBaixaSubN

        loc_cAliasPends = THIS.this_cCursorPends
        loc_cAliasOpd   = THIS.this_cCursorOpd

        IF !USED(loc_cAliasPends)
            THIS.this_cMensagemErro = "Cursor da grade de sele" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        *-- legado: Zap In xnensi/xmfas/tmpoperacao/xPesa/xOpi (cursores de
        *-- SAIDA do form pai, zerados antes de regravar)
        IF USED(THIS.this_cCursorNensiSaida)
            ZAP IN (THIS.this_cCursorNensiSaida)
        ENDIF
        IF USED(THIS.this_cCursorMFas)
            ZAP IN (THIS.this_cCursorMFas)
        ENDIF
        IF USED(THIS.this_cCursorOperacao)
            ZAP IN (THIS.this_cCursorOperacao)
        ENDIF
        IF USED(THIS.this_cCursorPesa)
            ZAP IN (THIS.this_cCursorPesa)
        ENDIF
        IF USED(THIS.this_cCursorOpi)
            ZAP IN (THIS.this_cCursorOpi)
        ENDIF

        *-- legado: =Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps') / _BaixaSubN
        *-- = (crSigCdOpd.BxAutos = 1)
        loc_lBaixaSubN = .F.
        IF USED(loc_cAliasOpd) AND USED(THIS.this_cCursorNens)
            IF SEEK(EVALUATE(THIS.this_cCursorNens + ".Dopps"), loc_cAliasOpd, "Dopps")
                loc_lBaixaSubN = (NVL(EVALUATE(loc_cAliasOpd + ".BxAutos"), 0) = 1)
            ENDIF
        ENDIF

        *-- legado: Select TmpPends / Scan For Flag
        SELECT (loc_cAliasPends)
        SCAN FOR Flag
            IF !THIS.GravarPendenciaConfirmada(Emps, Dopps, Numps, loc_lBaixaSubN)
                RETURN .F.
            ENDIF
            SELECT (loc_cAliasPends)
        ENDSCAN

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GravarPendenciaConfirmada - corpo do "Select TmpPends / Scan For
    * Flag" do "ok" legado (linhas 2344-2594 do dump), ATE o fim do laco de
    * SigPdMvf (LocalMFas) - a parte final (SigCdNei/LocalNensI) fica em
    * GravarDetalheEnvelopeFinal, chamada no fim deste metodo (confirmado
    * pela contagem de Scan/EndScan do dump: o bloco LocalNensI roda UMA
    * VEZ por pendencia, fora do Scan de LocalMFas mas dentro do Scan de
    * TmpPends).
    *
    * PROTECTED (regra #51).
    *==========================================================================
    PROTECTED PROCEDURE GravarPendenciaConfirmada(par_cEmps, par_cDopps, par_nNumps, par_lBaixaSubN)
        LOCAL loc_cAliasNens, loc_cAliasOpd, loc_cAliasNec
        LOCAL loc_nNumNivel, loc_cChaveNens, loc_cCidChaves, loc_lRetrabs, loc_cSQL

        loc_cAliasNens = THIS.this_cCursorNens
        loc_cAliasOpd  = THIS.this_cCursorOpd
        loc_cAliasNec  = THIS.this_cCursorNecessidades

        *-- legado: =Seek(TmpPends.Dopps, 'crSigCdOpd', 'Dopps') / _NumNivel
        *-- = crSigCdOpd.NDopps (aqui o "ok" usa o NDopps PURO, diferente do
        *-- Val(Str()+Transform()) de Marcar - ver Insert Into TmpOperacao)
        IF !SEEK(par_cDopps, loc_cAliasOpd, "Dopps")
            THIS.this_cMensagemErro = "N" + CHR(237) + "vel/opera" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o encontrado (crSigCdOpd)."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            RETURN .F.
        ENDIF
        loc_nNumNivel = EVALUATE(loc_cAliasOpd + ".NDopps")

        *-- legado: =Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps') - reposiciona
        *-- para o nivel da necessidade do form pai; nao lido depois no
        *-- legado, mantido so por fidelidade de fluxo
        = SEEK(EVALUATE(loc_cAliasNens + ".Dopps"), loc_cAliasOpd, "Dopps")

        *-- legado: _ChaveNens = TmpPends.Emps + TmpPends.Dopps + Str(
        *-- TmpPends.Numps, 10) - chave POSICIONAL char(33) (regra #42)
        loc_cChaveNens = PADR(par_cEmps, 3) + PADR(par_cDopps, 20) + STR(par_nNumps, 10)

        *-- legado: CursorQuery('SigCdNec', 'LocalNens', 'EmpDNPs',
        *-- _ChaveNens, 'cIdChaves, Retrabs')
        IF !THIS.ExecutarCursorQuery("SigCdNec", "cursor_4c_OkNec", "EmpDNPs", loc_cChaveNens, ;
                "cIdChaves, Retrabs")
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNens)"
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_cCidChaves = cursor_4c_OkNec.cIdChaves
        loc_lRetrabs   = ConverterParaLogico(cursor_4c_OkNec.Retrabs)

        IF USED("cursor_4c_OkNec")
            USE IN cursor_4c_OkNec
        ENDIF

        *-- legado: Update SigCdNec Set NAceites = <TmpNens.Numps> [, ChkSubn
        *-- = 1] Where cIdChaves = '<cid>' - pTrue eh SEMPRE .T.; NAceites
        *-- recebe o numero da NECESSIDADE do form pai (TmpNens.Numps), nao
        *-- desta linha de TmpPends
        loc_cSQL = "UPDATE SigCdNec SET NAceites = " + ;
            FormatarNumeroSQL(EVALUATE(loc_cAliasNens + ".Numps"), 0) + ;
            IIF(par_lBaixaSubN, ", ChkSubn = 1", "") + ;
            " WHERE CidChaves = " + EscaparSQL(loc_cCidChaves)

        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (OK - Update - SigCdNec)" + CHR(13) + ;
                CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- legado: Update crSigCdNec Set NAceites = TmpNens.Numps Where
        *-- cIdChaves = LocalNens.cIdChaves - espelha no cursor GLOBAL
        *-- (crSigCdNec), que outras telas podem estar lendo. A linha
        *-- fica POSICIONADA aqui (LOCATE bem-sucedido) para
        *-- GravarDetalheEnvelopeFinal/GravarFaseAusente, que leem dela.
        IF USED(loc_cAliasNec)
            SELECT (loc_cAliasNec)
            LOCATE FOR ALLTRIM(CidChaves) == ALLTRIM(loc_cCidChaves)
            IF FOUND()
                REPLACE NAceites WITH EVALUATE(loc_cAliasNens + ".Numps") IN (loc_cAliasNec)
            ENDIF
        ENDIF

        *-- legado: If LocalNens.Retrabs / Replace Retrabs With .t./.f. In
        *-- TmpNens
        IF USED(loc_cAliasNens)
            REPLACE Retrabs WITH loc_lRetrabs IN (loc_cAliasNens)
        ENDIF

        *-- legado: CursorQuery('SigPdMvf', 'LocalMFas', 'EmpDNPs',
        *-- _ChaveNens, ...) + Select LocalMFas / Scan - uma linha por FASE
        *-- ja lancada desta pendencia. Universo VAZIO (nenhuma fase ainda)
        *-- nao eh erro - segue direto para GravarDetalheEnvelopeFinal.
        IF THIS.ExecutarCursorQuery("SigPdMvf", "cursor_4c_OkMFas", "EmpDNPs", loc_cChaveNens, ;
                "Emps, Dopps, Numps, Datars, Datas, Usuars, Opers, Grupoos, Contaos, " + ;
                "Grupods, Contads, Nops, Nenvs, Dopes, Numes, Dataps, Dataes, Obss, " + ;
                "Codpds, Unids, Pesos, Qtds, Obsps, Ordems, cRetrabs")
            SELECT cursor_4c_OkMFas
            SCAN
                IF !THIS.GravarFaseConfirmada(loc_nNumNivel, loc_cChaveNens)
                    IF USED("cursor_4c_OkMFas")
                        USE IN cursor_4c_OkMFas
                    ENDIF
                    RETURN .F.
                ENDIF
                SELECT cursor_4c_OkMFas
            ENDSCAN
            IF USED("cursor_4c_OkMFas")
                USE IN cursor_4c_OkMFas
            ENDIF
        ENDIF

        *-- bloco final (SigCdNei/LocalNensI) - roda UMA VEZ por pendencia
        RETURN THIS.GravarDetalheEnvelopeFinal(loc_cChaveNens)
    ENDPROC

    *==========================================================================
    * GravarFaseConfirmada - corpo do "Select LocalMFas / Scan" do "ok"
    * legado (linhas 2392-2451 do dump). Opera sobre a linha CORRENTE de
    * cursor_4c_OkMFas (ja selecionada pelo chamador). PROTECTED (regra
    * #51).
    *==========================================================================
    PROTECTED PROCEDURE GravarFaseConfirmada(par_nNumNivel, par_cChaveNens)
        LOCAL loc_cAliasNens, loc_cAliasMFas, loc_cAliasOperacao, loc_cAliasOpi
        LOCAL loc_nNops, loc_cSQL, loc_nResultado, loc_dUltimaData
        LOCAL loc_cEmp, loc_cEdn, loc_nContaOs, loc_lIndividualPeso, loc_nNEnv

        loc_cAliasNens     = THIS.this_cCursorNens
        loc_cAliasMFas     = THIS.this_cCursorMFas
        loc_cAliasOperacao = THIS.this_cCursorOperacao
        loc_cAliasOpi      = THIS.this_cCursorOpi

        *-- legado: _Nops = LocalMfas.Nops (alias corrente)
        loc_nNops = cursor_4c_OkMFas.Nops

        *-- legado: Select a.Nops, a.Datas, a.cidChaves From SigPdMvf a
        *-- Where a.Nops = <nops> And a.Emps = '<_Empr>' Order By a.Nops
        *-- Desc, a.cIdChaves Desc - a 1a linha eh o lancamento MAIS
        *-- RECENTE desta ordem de producao (_Empr -> go_4c_Sistema.
        *-- cCodEmpresa, NUNCA a variavel legada _EMPR)
        loc_cSQL = "SELECT a.Nops, a.Datas, a.cidChaves FROM SigPdMvf a" + ;
            " WHERE a.Nops = " + FormatarNumeroSQL(loc_nNops, 0) + ;
            " AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
            " ORDER BY a.Nops DESC, a.cIdChaves DESC"

        IF USED("cursor_4c_OkMFas2")
            USE IN cursor_4c_OkMFas2
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OkMFas2")

        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalMFas2)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_OkMFas2
        GO TOP
        loc_dUltimaData = cursor_4c_OkMFas2.Datas

        IF USED("cursor_4c_OkMFas2")
            USE IN cursor_4c_OkMFas2
        ENDIF

        *-- legado: If (Dtos(LocalMFas2.Datas) > Dtos(TmpNens.datas)) -
        *-- Dtos trunca a hora; DATE() nos dois lados reproduz isso
        IF !ISNULL(loc_dUltimaData) AND USED(loc_cAliasNens) AND ;
                DATE(loc_dUltimaData) > DATE(EVALUATE(loc_cAliasNens + ".Datas"))
            MsgAviso("Data inconsistente. " + "Ultimo lan" + CHR(231) + "amento com data de " + ;
                DTOC(loc_dUltimaData), "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- legado: Insert Into xMFas (...) Values (LocalMFas.*)
        INSERT INTO (loc_cAliasMFas) ;
            (Emps, Dopps, Numps, Datars, Datas, Usuars, Opers, Grupoos, Contaos, ;
             Grupods, Contads, NOps, NEnvs, Dopes, Numes, Dataps, Dataes, Obss, ;
             Codpds, Unids, Pesos, Qtds, Obsps, Ordems, cRetrabs) ;
            VALUES (cursor_4c_OkMFas.Emps, cursor_4c_OkMFas.Dopps, cursor_4c_OkMFas.Numps, ;
                cursor_4c_OkMFas.Datars, cursor_4c_OkMFas.Datas, cursor_4c_OkMFas.Usuars, ;
                cursor_4c_OkMFas.Opers, cursor_4c_OkMFas.Grupoos, cursor_4c_OkMFas.Contaos, ;
                cursor_4c_OkMFas.Grupods, cursor_4c_OkMFas.Contads, cursor_4c_OkMFas.Nops, ;
                cursor_4c_OkMFas.Nenvs, cursor_4c_OkMFas.Dopes, cursor_4c_OkMFas.Numes, ;
                cursor_4c_OkMFas.Dataps, cursor_4c_OkMFas.Dataes, cursor_4c_OkMFas.Obss, ;
                cursor_4c_OkMFas.Codpds, cursor_4c_OkMFas.Unids, cursor_4c_OkMFas.Pesos, ;
                cursor_4c_OkMFas.Qtds, cursor_4c_OkMFas.Obsps, cursor_4c_OkMFas.Ordems, ;
                cursor_4c_OkMFas.cRetrabs)

        *-- legado: If Not Seek((_NumNivel * 10000000000) + xMFas.NEnvs,
        *-- 'TmpOperacao', 'Codigos') - xMFas.NEnvs == cursor_4c_OkMFas.
        *-- Nenvs (acabou de ser copiado pelo Insert acima)
        loc_nNEnv = cursor_4c_OkMFas.Nenvs
        IF !SEEK((par_nNumNivel * 10000000000) + loc_nNEnv, loc_cAliasOperacao, "Codigos")
            INSERT INTO (loc_cAliasOperacao) (Codigos, EmpDnPs, Autos) ;
                VALUES ((par_nNumNivel * 10000000000) + loc_nNEnv, par_cChaveNens, .T.)
        ENDIF

        *-- legado: CursorQuery('SigOpPic', 'LocalOpi', 'Nops', LocalMFas.
        *-- Nops, 'Emps, Dopes, Numes, Qtds, CodCors, CodTams, Empds') + Scan
        IF THIS.ExecutarCursorQuery("SigOpPic", "cursor_4c_OkOpi", "Nops", loc_nNops, ;
                "Emps, Dopes, Numes, Qtds, CodCors, CodTams, Empds")
            SELECT cursor_4c_OkOpi
            SCAN
                IF cursor_4c_OkOpi.Qtds != 0
                    loc_cEmp = IIF(EMPTY(cursor_4c_OkOpi.Empds), cursor_4c_OkOpi.Emps, cursor_4c_OkOpi.Empds)
                    loc_cEdn = cursor_4c_OkOpi.Emps + cursor_4c_OkOpi.Dopes + STR(cursor_4c_OkOpi.Numes, 6)

                    *-- Guard ausente no legado (que assume sucesso) - mesmo
                    *-- padrao defensivo ja usado em CarregarItensDaPendencia
                    *-- para a lookup gemea de SigCdPro
                    IF !THIS.ExecutarCursorQuery("SigMvCab", "cursor_4c_OkEest", "EmpDopNums", ;
                            loc_cEdn, "ContaOs, ContaDs")
                        SELECT cursor_4c_OkOpi
                        LOOP
                    ENDIF
                    IF !THIS.ExecutarCursorQuery("SigCdOpe", "cursor_4c_OkOpe", "Dopes", ;
                            cursor_4c_OkOpi.Dopes, "Globalizas, Servicos")
                        SELECT cursor_4c_OkOpi
                        LOOP
                    ENDIF

                    IF NVL(cursor_4c_OkOpe.Globalizas, 0) = 1 OR ConverterParaLogico(cursor_4c_OkOpe.Servicos)
                        loc_nContaOs = cursor_4c_OkEest.ContaOs
                    ELSE
                        loc_nContaOs = cursor_4c_OkEest.ContaDs
                    ENDIF

                    *-- legado: Indiv = (crSigCdPam.TpPesas = 1)
                    IF VARTYPE(crSigCdPam.TpPesas) = "L"
                        loc_lIndividualPeso = crSigCdPam.TpPesas
                    ELSE
                        loc_lIndividualPeso = (NVL(crSigCdPam.TpPesas, 0) = 1)
                    ENDIF

                    INSERT INTO (loc_cAliasOpi) ;
                        (Nops, Oper, Qtds, CPros, Indiv, Nenvs, Emps, Dopes, Numes, ;
                         Conta, Empds, CodCors, CodTams) ;
                        VALUES (cursor_4c_OkMFas.Nops, ;
                            ALLTRIM(cursor_4c_OkOpi.Dopes) + "/" + ALLTRIM(STR(cursor_4c_OkOpi.Numes)), ;
                            cursor_4c_OkOpi.Qtds, cursor_4c_OkMFas.Codpds, loc_lIndividualPeso, ;
                            cursor_4c_OkMFas.Nenvs, cursor_4c_OkOpi.Emps, cursor_4c_OkOpi.Dopes, ;
                            cursor_4c_OkOpi.Numes, loc_nContaOs, loc_cEmp, cursor_4c_OkOpi.CodCors, ;
                            cursor_4c_OkOpi.CodTams)

                    SELECT cursor_4c_OkOpi
                ENDIF
            ENDSCAN

            IF USED("cursor_4c_OkOpi")
                USE IN cursor_4c_OkOpi
            ENDIF
        ENDIF
        IF USED("cursor_4c_OkEest")
            USE IN cursor_4c_OkEest
        ENDIF
        IF USED("cursor_4c_OkOpe")
            USE IN cursor_4c_OkOpe
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GravarDetalheEnvelopeFinal - legado: bloco final do "ok" Click
    * (Select * From SigCdNei Where EmpDNps = '<_ChaveNens>' ... ->
    * LocalNensI, linhas 2452-2593 do dump), que roda UMA VEZ por
    * pendencia confirmada (fora do Scan de LocalMFas, dentro do Scan de
    * TmpPends - confirmado pela contagem de Scan/EndScan do dump). Espelha
    * a mesma logica de agrupamento de CarregarItensDaPendencia, mas grava
    * no cursor de SAIDA do form pai (xNensi) em vez de xPNensi, e tem um
    * bloco adicional (SepPedras em 1/3/4, via GravarFaseAusente) que
    * garante pelo menos uma linha em xMFas/TmpOperacao para Nops ainda nao
    * cobertos pela fase (SigPdMvf) ja lancada.
    *
    * PROTECTED (regra #51).
    *
    * DIVERGENCIA DOCUMENTADA: o legado le CrSigCdNec.Emps/Dopps/Numps/
    * Datas/Usuars/Grupoos/Contaos/Grupods/Contads sem reposicionar o
    * cursor GLOBAL explicitamente neste ponto - conta com a posicao que
    * GravarPendenciaConfirmada deixou (LOCATE bem-sucedido pela mesma
    * CidChaves, poucas linhas antes). Aqui o mesmo cursor global
    * (this_cCursorNecessidades) eh lido da MESMA forma - a posicao jah
    * fica garantida pelo LOCATE feito em GravarPendenciaConfirmada, que
    * SEMPRE roda antes desta chamada.
    *==========================================================================
    PROTECTED PROCEDURE GravarDetalheEnvelopeFinal(par_cChaveNens)
        LOCAL loc_cAliasOpd, loc_cAliasNensiSaida, loc_cAliasMFas, loc_cAliasOperacao
        LOCAL loc_nAcEnvs, loc_nSepPedras, loc_nCompAgrus, loc_nNumNivel
        LOCAL loc_nNEnv, loc_nRateio, loc_lVisivel, loc_lServico
        LOCAL loc_cBMat, loc_cDMat, loc_cCMat, loc_cGMat, loc_cCatMat, loc_cTMat
        LOCAL loc_cSQL, loc_nResultado

        loc_cAliasOpd        = THIS.this_cCursorOpd
        loc_cAliasNensiSaida = THIS.this_cCursorNensiSaida
        loc_cAliasMFas       = THIS.this_cCursorMFas
        loc_cAliasOperacao   = THIS.this_cCursorOperacao

        IF !USED(loc_cAliasNensiSaida)
            THIS.this_cMensagemErro = "Cursor de sa" + CHR(237) + "da xNensi (form " + ;
                "chamador) n" + CHR(227) + "o est" + CHR(225) + " aberto."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            RETURN .F.
        ENDIF

        loc_nAcEnvs    = NVL(EVALUATE(loc_cAliasOpd + ".AcEnvs"), 0)
        loc_nSepPedras = NVL(EVALUATE(loc_cAliasOpd + ".SepPedras"), 0)
        loc_nCompAgrus = NVL(EVALUATE(loc_cAliasOpd + ".CompAgrus"), 0)
        loc_nNumNivel  = NVL(EVALUATE(loc_cAliasOpd + ".NDopps"), 0)

        *-- legado: Select * From SigCdNei Where EmpDNps = '<_ChaveNens>'
        *-- Order By ... (SELECT * exige listar as 50 colunas - mesma
        *-- estrutura de xPNensi/xPNensiT, regra #22)
        loc_cSQL = "SELECT Aqtds, Cats, CDescs, CGrus, CMats, Coefs, ContaFs, CUnis, " + ;
            "DataTrans, Dopps, Emps, Fators, FlagIncs, GrupoFins, GrupoFs, Moedas, " + ;
            "Moeds, NEnvs, Nops, Numps, Obss, Pesos, Qtds, Servicos, TpOps, Locals, " + ;
            "NTrans, CidChaves, NLotes, PesoFixs, CoefInfs, CRetrabs, EmpDNPs, " + ;
            "EmpDopNums, ChkSubn, CodCors, CodNConfs, CodTams, Peso2s, CustoFs, " + ;
            "MoeCusFs, Estorno, PVens, Ps2FaseAnt, cUnips, OsRets, Retrabs, " + ;
            "MatPrincs, PsFaseAnt, Descs, Rateio, Visivel, QtFaseAnt" + ;
            " FROM SigCdNei" + ;
            " WHERE EmpDNps = " + EscaparSQL(par_cChaveNens) + ;
            " ORDER BY Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, Qtds, Pesos," + ;
            " TpOps, Cats, FlagIncs, CUnis, Obss, nLotes, codCors, codTams"

        IF USED("cursor_4c_OkNensI")
            USE IN cursor_4c_OkNensI
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OkNensI")

        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalNensI)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_OkNensI
        SCAN
            loc_nNEnv = cursor_4c_OkNensI.NEnvs

            SCAN WHILE (NEnvs = loc_nNEnv)
                IF !THIS.ExecutarCursorQuery("SigCdPro", "cursor_4c_OkPro", "CPros", ;
                        cursor_4c_OkNensI.CMats, "CGrus, Varias, Dpros, Cunis")
                    SELECT cursor_4c_OkNensI
                    LOOP
                ENDIF

                loc_nRateio  = 5
                loc_lVisivel = .T.

                IF loc_nAcEnvs = 1
                    IF cursor_4c_OkNensI.Nops = 0
                        loc_nRateio  = 5
                        loc_lVisivel = .T.
                    ELSE
                        loc_nRateio  = IIF(NVL(cursor_4c_OkPro.Varias, 0) = 1, 2, 3)
                        loc_lVisivel = .F.
                    ENDIF
                ENDIF

                loc_lServico = ConverterParaLogico(cursor_4c_OkNensI.Servicos)

                IF !loc_lServico AND !EMPTY(cursor_4c_OkNensI.CMats) AND EMPTY(cursor_4c_OkNensI.Cats)
                    INSERT INTO (loc_cAliasNensiSaida) ;
                        (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, QtFaseAnt, Qtds, ;
                         PsFaseAnt, Pesos, Visivel, Rateio, TpOps, Cats, FlagIncs, CUnis, ;
                         CGrus, Obss, CodCors, CodTams, Peso2s, Ps2FaseAnt) ;
                        VALUES (cursor_4c_OkNensI.Emps, cursor_4c_OkNensI.Dopps, ;
                            cursor_4c_OkNensI.Numps, cursor_4c_OkNensI.Nops, ;
                            cursor_4c_OkNensI.NEnvs, cursor_4c_OkNensI.CMats, ;
                            cursor_4c_OkNensI.CDescs, cursor_4c_OkNensI.Qtds, ;
                            cursor_4c_OkNensI.Qtds, cursor_4c_OkNensI.Pesos, ;
                            cursor_4c_OkNensI.Pesos, loc_lVisivel, loc_nRateio, ;
                            cursor_4c_OkNensI.TpOps, cursor_4c_OkNensI.Cats, .F., ;
                            cursor_4c_OkNensI.CUnis, cursor_4c_OkPro.CGrus, ;
                            cursor_4c_OkNensI.Obss, cursor_4c_OkNensI.CodCors, ;
                            cursor_4c_OkNensI.CodTams, cursor_4c_OkNensI.Peso2s, ;
                            cursor_4c_OkNensI.Peso2s)

                    IF loc_nSepPedras = 4
                        REPLACE QtFaseAnt WITH 0, PsFaseAnt WITH 0 IN (loc_cAliasNensiSaida)
                    ENDIF

                    IF loc_nAcEnvs = 1
                        IF ConverterParaLogico(cursor_4c_OkNensI.FlagIncs)
                            loc_cBMat   = cursor_4c_OkNensI.CMats
                            loc_cDMat   = cursor_4c_OkPro.DPros
                            loc_cCMat   = cursor_4c_OkPro.CUnis
                            loc_cGMat   = cursor_4c_OkPro.CGrus
                            loc_cCatMat = cursor_4c_OkNensI.Cats
                        ELSE
                            loc_cBMat   = SPACE(14)
                            loc_cDMat   = ""
                            loc_cCMat   = ""
                            loc_cGMat   = ""
                            loc_cCatMat = SPACE(3)
                        ENDIF
                        loc_cTMat = cursor_4c_OkNensI.TpOps

                        *-- legado: If (crSigCdOpd.CompAgrus = 1) -> _Nenv =
                        *-- 0 (encerra, pela reatribuicao da variavel de
                        *-- controle, esta volta do "Scan While")
                        IF loc_nCompAgrus = 1
                            loc_nNEnv = 0
                        ENDIF

                        IF loc_nRateio != 5
                            IF !SEEK(STR(loc_nNEnv, 10) + PADR(loc_cBMat, 14) + PADR(loc_cTMat, 15), ;
                                    loc_cAliasNensiSaida, "NEnvTpops")
                                INSERT INTO (loc_cAliasNensiSaida) ;
                                    (Nops, NEnvs, CMats, CDescs, CUnis, CGrus, Visivel, Rateio, ;
                                     Cats, TpOps, Servicos) ;
                                    VALUES (loc_nNEnv, loc_nNEnv, loc_cBMat, loc_cDMat, loc_cCMat, ;
                                        loc_cGMat, .T., 1, loc_cCatMat, loc_cTMat, loc_lServico)
                            ELSE
                                IF EVALUATE(loc_cAliasNensiSaida + ".Rateio") != 1
                                    REPLACE Rateio WITH 1 IN (loc_cAliasNensiSaida)
                                ENDIF
                            ENDIF

                            SELECT (loc_cAliasNensiSaida)
                            REPLACE QtFaseAnt WITH QtFaseAnt + cursor_4c_OkNensI.Qtds, ;
                                    PsFaseAnt WITH PsFaseAnt + cursor_4c_OkNensI.Pesos, ;
                                    Qtds      WITH Qtds + cursor_4c_OkNensI.Qtds, ;
                                    Pesos     WITH Pesos + cursor_4c_OkNensI.Pesos ;
                                IN (loc_cAliasNensiSaida)
                        ENDIF
                    ENDIF
                ENDIF

                *-- legado: If (InList(crSigCdOpd.SepPedras,1,3,4)) - garante
                *-- pelo menos 1 linha em xMFas/TmpOperacao por Nops, mesmo
                *-- quando SigPdMvf ainda nao tem fase lancada para ele
                IF INLIST(loc_nSepPedras, 1, 3, 4)
                    IF !SEEK(cursor_4c_OkNensI.Nops, loc_cAliasMFas, "Nops")
                        IF !THIS.GravarFaseAusente(cursor_4c_OkNensI.Nops, cursor_4c_OkNensI.Nenvs, ;
                                cursor_4c_OkNensI.Cunis)
                            SELECT cursor_4c_OkNensI
                            RETURN .F.
                        ENDIF
                    ENDIF

                    IF !SEEK((loc_nNumNivel * 10000000000) + EVALUATE(loc_cAliasMFas + ".NEnvs"), ;
                            loc_cAliasOperacao, "Codigos")
                        INSERT INTO (loc_cAliasOperacao) (Codigos, EmpDnPs, Autos) ;
                            VALUES ((loc_nNumNivel * 10000000000) + EVALUATE(loc_cAliasMFas + ".NEnvs"), ;
                                par_cChaveNens, .T.)
                    ENDIF
                ENDIF

                SELECT cursor_4c_OkNensI
            ENDSCAN

            IF !BOF("cursor_4c_OkNensI")
                SKIP -1 IN cursor_4c_OkNensI
            ENDIF
        ENDSCAN

        IF USED("cursor_4c_OkNensI")
            USE IN cursor_4c_OkNensI
        ENDIF
        IF USED("cursor_4c_OkPro")
            USE IN cursor_4c_OkPro
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GravarFaseAusente - legado: bloco "If Not Seek(LocalNensI.Nops,
    * 'xMfas', 'Nops') ..." dentro do bloco final do "ok" - quando a Ordem
    * de Producao (Nops) do detalhe ainda NAO tem nenhuma linha em xMFas
    * (nenhuma fase SigPdMvf foi lancada para ela ainda), cria uma linha
    * "zero" so para garantir que xMFas/TmpOperacao enxerguem esse Nops.
    *
    * PROTECTED (regra #51). Le Emps/Dopps/Numps/Datas/Usuars/Grupoos/
    * Contaos/Grupods/Contads do cursor GLOBAL this_cCursorNecessidades -
    * ver nota de posicionamento no cabecalho de GravarDetalheEnvelopeFinal
    * (quem chama este metodo).
    *==========================================================================
    PROTECTED PROCEDURE GravarFaseAusente(par_nNops, par_nNenvs, par_cCunis)
        LOCAL loc_cAliasNec, loc_cSQL, loc_nResultado, loc_cEdn, loc_cCodPds, loc_nQtdeSoma

        loc_cAliasNec = THIS.this_cCursorNecessidades

        *-- legado: Select EmpDNPs, Emps, Dopps, Nops From SigOpPic Where
        *-- Nops = <nops> Order By EmpDNPs
        loc_cSQL = "SELECT EmpDNPs, Emps, Dopps, Nops FROM SigOpPic" + ;
            " WHERE Nops = " + FormatarNumeroSQL(par_nNops, 0) + ;
            " ORDER BY EmpDNPs"

        IF USED("cursor_4c_OkDetOpi")
            USE IN cursor_4c_OkDetOpi
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OkDetOpi")

        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalOpi)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_OkDetOpi
        GO TOP

        *-- legado: lcEdn = LocalOpi.Emps + LocalOpi.Dopps + Str(LocalOpi.
        *-- Nops, 10) - colunas CHAR fixas lidas direto do cursor (ja vem
        *-- com o padding do schema; PADR explicito eh so para STRING/
        *-- variavel - regra #42)
        loc_cEdn = cursor_4c_OkDetOpi.Emps + cursor_4c_OkDetOpi.Dopps + STR(cursor_4c_OkDetOpi.Nops, 10)

        IF USED("cursor_4c_OkDetOpi")
            USE IN cursor_4c_OkDetOpi
        ENDIF

        *-- legado: Select Nops, Qtds, Codpds From SigPdMvf Where EmpDNPs =
        *-- '<lcEdn>'
        loc_cSQL = "SELECT Nops, Qtds, Codpds FROM SigPdMvf WHERE EmpDNPs = " + EscaparSQL(loc_cEdn)

        IF USED("cursor_4c_OkDetMFas")
            USE IN cursor_4c_OkDetMFas
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OkDetMFas")

        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (LocalMFas)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_OkDetMFas
        GO TOP
        loc_cCodPds = cursor_4c_OkDetMFas.Codpds

        *-- legado: Sum Qtds To _Qtde While Nops = LocalNensI.Nops - o
        *-- filtro de EmpDNPs ja garante que TODA linha deste cursor tem o
        *-- MESMO Nops (codificado no proprio EmpDNPs) - equivalente a
        *-- somar o cursor INTEIRO
        loc_nQtdeSoma = 0
        SELECT cursor_4c_OkDetMFas
        SCAN WHILE Nops = par_nNops
            loc_nQtdeSoma = loc_nQtdeSoma + Qtds
        ENDSCAN

        IF USED("cursor_4c_OkDetMFas")
            USE IN cursor_4c_OkDetMFas
        ENDIF

        *-- legado: Insert Into xMFas (...) Values (CrSigCdNec.*, LocalNensI.
        *-- Nops/Nenvs, _Cpro, LocalNensI.Cunis, 0, _Qtde)
        INSERT INTO (THIS.this_cCursorMFas) ;
            (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, Grupods, ;
             Contads, NOps, NEnvs, Codpds, Unids, Pesos, Qtds) ;
            VALUES (EVALUATE(loc_cAliasNec + ".Emps"), EVALUATE(loc_cAliasNec + ".Dopps"), ;
                EVALUATE(loc_cAliasNec + ".Numps"), EVALUATE(loc_cAliasNec + ".Datas"), ;
                EVALUATE(loc_cAliasNec + ".Datas"), EVALUATE(loc_cAliasNec + ".Usuars"), ;
                EVALUATE(loc_cAliasNec + ".Grupoos"), EVALUATE(loc_cAliasNec + ".Contaos"), ;
                EVALUATE(loc_cAliasNec + ".Grupods"), EVALUATE(loc_cAliasNec + ".Contads"), ;
                par_nNops, par_nNenvs, loc_cCodPds, par_cCunis, 0, loc_nQtdeSoma)

        RETURN .T.
    ENDPROC

ENDDEFINE

