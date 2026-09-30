# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 2/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-28 07:52:45] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-28 07:52:45] [INFO] Config FPW: (nao fornecido)
[2026-09-28 07:52:45] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-28 07:52:45] [INFO] Timeout: 300 segundos
[2026-09-28 07:52:45] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wcf3xoqg.prg
[2026-09-28 07:52:45] [INFO] Conteudo do wrapper:
[2026-09-28 07:52:45] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrEs1', 'C:\4c\tasks\task606\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrEs1', 'C:\4c\tasks\task606\logs\06_testForm.log'
QUIT

[2026-09-28 07:52:45] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wcf3xoqg.prg
[2026-09-28 07:52:45] [INFO] VFP output esperado em: C:\4c\tasks\task606\vfp_output.txt
[2026-09-28 07:52:45] [INFO] Executando Visual FoxPro 9...
[2026-09-28 07:52:45] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wcf3xoqg.prg
[2026-09-28 07:52:45] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wcf3xoqg.prg
[2026-09-28 07:52:45] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrEs1
Inicio: 28/09/2026 07:52:45

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 28/09/2026 07:55:53
Duracao: 188 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-28 07:55:53] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-28 07:55:53] [INFO] VFP9 finalizado em 187.8222115 segundos
[2026-09-28 07:55:53] [INFO] Exit Code: 
[2026-09-28 07:55:53] [INFO] 
[2026-09-28 07:55:53] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-28 07:55:53] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wcf3xoqg.prg
[2026-09-28 07:55:53] [INFO] 
[2026-09-28 07:55:53] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-28 07:55:53] [INFO] * Auto-generated wrapper for parameters
[2026-09-28 07:55:53] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-28 07:55:53] [INFO] * Parameters: 'FormSigPrEs1', 'C:\4c\tasks\task606\logs\06_testForm.log'
[2026-09-28 07:55:53] [INFO] 
[2026-09-28 07:55:53] [INFO] * Anti-dialog protections for unattended execution
[2026-09-28 07:55:53] [INFO] SET SAFETY OFF
[2026-09-28 07:55:53] [INFO] SET RESOURCE OFF
[2026-09-28 07:55:53] [INFO] SET TALK OFF
[2026-09-28 07:55:53] [INFO] SET NOTIFY OFF
[2026-09-28 07:55:53] [INFO] SYS(2335, 0)
[2026-09-28 07:55:53] [INFO] 
[2026-09-28 07:55:53] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrEs1', 'C:\4c\tasks\task606\logs\06_testForm.log'
[2026-09-28 07:55:53] [INFO] QUIT
[2026-09-28 07:55:53] [INFO] 
[2026-09-28 07:55:53] [INFO] === Fim do Wrapper.prg ===
[2026-09-28 07:55:53] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.prg):
*==============================================================================
* FormSigPrEs1.prg - Posicao Por Movimentacao
* Tipo: OPERACIONAL (layout FLAT, sem PageFrame - form legado nao tem abas)
* Herda de: FormBase
* Legado: SIGPRES1.SCX (tasks\task606\SigPrEs1_form_codigo_fonte.txt)
*
* FASE 3/8 (estrutura base) + FASE 4/8 (botoes de acao).
* Arvore do SCX legado (SECAO 1 do dump): Dataenvironment + form + cntSombra
* (lblSombra/lblTitulo) + Container1 (filtros) + sair (commandgroup com
* "consulta"/"sair"). NENHUM PageFrame - form FLAT, filho direto de SIGPRES1
* (mesmo padrao ja validado em FormSigPrIct.prg/Formsigmvpen.prg). Por isso
* este arquivo NAO cria pgf_4c_Paginas/Page1/Page2: inventar PageFrame que o
* legado nao tem violaria o PILAR 1 e a regra "NUNCA inventar" de
* migration_guide.md (CLAUDE.md - Gate da Fase 3 para legado flat).
*
* Nomes de objeto seguem EXATAMENTE tasks\task606\mapeamento.json (usado pelo
* ValidarUIFidelity na Fase 7): cntSombra -> cnt_4c_Sombra, lblSombra ->
* lbl_4c_LblSombra, lblTitulo -> lbl_4c_LblTitulo, Container1 ->
* cnt_4c_Container1, sair -> obj_4c_Sair.
*
* FASE 3 entregou: propriedades visuais do form, Init/Destroy, o cabecalho
* completo (cnt_4c_Sombra) e cnt_4c_Container1 ainda vazio (campos de filtro
* entram nas Fases 5-6).
*
* FASE 4 entregou obj_4c_Sair com os 2 botoes REAIS do dump legado
* (Consultar/Encerrar - NAO ha Grid nem Page1/Lista neste form: o legado
* SIGPRES1 eh so filtro + os 2 botoes do commandgroup "sair", equivalente aos
* botoes CRUD dos forms de cadastro; ver CLAUDE.md "Gate da Fase 4" para o
* caso de despachante sem Grid/CRUD) + o dispatcher BtnSairClick +
* BtnConsultarClick/BtnEncerrarClick (consulta.Click/sair.Click do legado) +
* FormParaBO/AbrirTelaMovimentacao. BtnConsultarClick ja
* referencia os campos de cnt_4c_Container1 pelos nomes finais de
* mapeamento.json (txt_4c__cd_empresa etc.) - eles so passam a existir de
* fato nas Fases 5-6, forward-reference normal do pipeline multi-fase.
*
* Dimensoes/propriedades do form identicas ao legado (SECAO 2, objeto
* SIGPRES1): Width=823, Height=400, BorderStyle=2 (sizable-fixo), sem barra
* de titulo (TitleBar=0/ControlBox=.F.), AutoCenter=.T., DataSession=2
* (sessao privada - FormBase.Init() ja normaliza SET DATE/CENTURY, regra
* CLAUDE.md #9.4; este form nao faz DELETE local nem SEEK sensivel a
* SET EXACT, entao nao precisa repor DELETED/EXACT).
*
* FASE 8 (consolidacao) entregou o par de hooks canonico, com os nomes de
* FormBase (ambos PROTECTED PROCEDURE, como na classe base - subclasse nao
* alarga escopo de hook):
*   - FormParaBO  : controles -> propriedades do BO (era
*                   "SincronizarFiltrosComBO"; renomeado para o nome canonico,
*                   o comportamento nao mudou). Chamado por BtnConsultarClick.
*   - BOParaForm  : BO -> controles, na abertura da tela. NOVO nesta fase - o
*                   bloco "With .Container1" do Init legado nao tinha sido
*                   migrado, e com ele faltava ".get_cd_empresa.Value = _empr":
*                   a Empresa abria VAZIA e todo primeiro Consultar caia em
*                   "Empresa Invalida!!!".
*
* NAO existem aqui, porque o legado SIGPRES1 nao os tem e cria-los seria
* inventar superficie (PILAR 1) ou deixar metodo vazio (regra de completude):
*   - CarregarLista / grd_*  : o SCX nao tem Grid nem PageFrame; os 7
*     "ControlSource" do dump sao TODOS string vazia em TextBox de filtro. O
*     resultado da consulta nao eh exibido aqui - vai para a tela filha
*     Formsigpres2 pelo cursor csTemporario.
*   - BtnSalvarClick / BtnCancelarClick / HabilitarCampos /
*     AjustarBotoesPorModo : nao ha Page2 de Dados, nem modo de edicao, nem
*     gravacao - o dump nao tem INSERT/UPDATE/DELETE em tabela nenhuma. O
*     botao de acao do legado eh o "Consultar" (commandgroup "sair",
*     Command1), cujo handler eh BtnConsultarClick.
*==============================================================================

DEFINE CLASS FormSigPrEs1 AS FormBase

    *-- Propriedades visuais (SECAO 2 do dump, objeto SIGPRES1)
    Width        = 823
    Height       = 400
    Caption      = "Posi" + CHR(231) + CHR(227) + "o Por Movimenta" + CHR(231) + CHR(227) + "o"
    AutoCenter   = .T.
    BorderStyle  = 2
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    DataSession  = 2
    ClipControls = .F.

    *--------------------------------------------------------------------------
    * Init - Apenas DODEFAULT() (FormBase.Init() chama InicializarForm())
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Hook chamado por FormBase.Init(). Equivalente ao
    * trecho do Init legado ".poDataMgr = CreateObject('fSqlConector', ...) /
    * If (.poDataMgr.pnIdconn > 0)": instancia o Business Object (que usa o
    * handle de conexao global gnConnHandle, ja aberto no startup - nao ha
    * conexao privada por form na nova arquitetura) e monta a estrutura
    * visual base.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
            ELSE
                THIS.this_oBusinessObject = CREATEOBJECT("SigPrEs1BO")

                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                    MsgErro("Falha ao criar SigPrEs1BO.", "Erro")
                ELSE
                    THIS.ConfigurarPageFrame()
                    THIS.ConfigurarCabecalho()
                    THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                    THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                    THIS.ConfigurarContainerFiltros()
                    THIS.RegistrarLookupsFiltros()
                    THIS.ConfigurarBotoesAcao()

                    *-- Dispatcher do CommandGroup obj_4c_Sair (Consultar/Encerrar)
                    BINDEVENT(THIS.obj_4c_Sair, "Click", THIS, "BtnSairClick")

                    *-- Estado inicial dos filtros (bloco "With .Container1"
                    *-- do Init legado). Depois de ConfigurarContainerFiltros
                    *-- porque so aqui os controles ja existem.
                    THIS.BOParaForm()

                    THIS.TornarControlesVisiveis(THIS)

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar formul" + CHR(225) + "rio: " + ;
                loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Fundo do form (equivalente ao .Picture do legado:
    * ..\framework\imagens\fundo_cadastro.jpg). Sem PageFrame de verdade - o
    * legado eh flat (ver cabecalho do arquivo). Nome mantido por convencao
    * do pipeline multi-fase (mesmo padrao de FormSigPrIct.prg).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_cImagem
        loc_cImagem = gc_4c_CaminhoIcones + "fundo_cadastro.jpg"

        IF FILE(loc_cImagem)
            THIS.Picture = loc_cImagem
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cnt_4c_Sombra (cntSombra legado) com os dois
    * labels de titulo. Bloco canonico/boilerplate (mesmo padrao usado em
    * dezenas de forms REPORT/OPERACIONAIS) - identifica-se por
    * BackColor=RGB(100,100,100), NUNCA pelo nome (CLAUDE.md regra #11).
    * Nomes conforme mapeamento.json: cnt_4c_Sombra / lbl_4c_LblSombra /
    * lbl_4c_LblTitulo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .AutoSize      = .F.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = ""
                .Height        = 40
                .Left          = 10
                .Top           = 25
                .Width         = THIS.Width
                .ForeColor     = RGB(0, 0, 0)
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .AutoSize    = .F.
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = ""
                .Height      = 46
                .Left        = 10
                .Top         = 24
                .Width       = THIS.Width
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            ENDWITH

            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerFiltros - Cria cnt_4c_Container1 (Container1 do
    * legado - SECAO 2: Top=84 Left=84 Width=618 Height=249, BackStyle=0
    * transparente sobre o .Picture do form, BorderWidth=0).
    *
    * FASE 5/8: primeira metade dos campos (linhas Empresa/Periodo/
    * Movimentacao-OP-Numero-Status/Grupo/Conta+CPF, Top 10..119 no dump
    * legado) - 23 dos 35 objetos de mapeamento.json. Segunda metade
    * (Responsavel/Moeda/Cotacao/Situacao/Impressao, Top 141..218) entra na
    * Fase 6.
    *
    * Todos os controles usam AddObject FORA de qualquer WITH aberto +
    * WITH loc_oCnt.<filho> com caminho explicito (nunca AddObject dentro de
    * um WITH pai seguido de WITH .filho aninhado) - CLAUDE.md regra sobre
    * WITH aninhado silenciosamente ignorando propriedades (Container/Label/
    * CommandGroup/OptionGroup criados via AddObject). Excecao permitida:
    * WITH loc_oCnt.obj_4c_Opt_nr_periodo seguido de WITH .Buttons(N)
    * aninhado (1 nivel dentro do OptionGroup, padrao seguro documentado).
    *
    * Labels sem Width/Alignment no dump (classe say pura) recebem
    * .Alignment = 0 + .Width calculada para nao entrar no controle vizinho
    * (CLAUDE.md regra #23 - jamais inventar Alignment=1). TabIndex
    * transcrito do dump (regra sobre ordem de tabulacao). .Margin NAO
    * copiado dos controles fwget do legado (get_cd_empresa/getPStatus/
    * Get_cpf): TextBox base do VFP9 nao tem essa propriedade (regra #33 -
    * propriedade que a classe nao tem trava o Init).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerFiltros()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Container1", "Container")
        loc_oCnt = THIS.cnt_4c_Container1

        WITH loc_oCnt
            .Top         = 84
            .Left        = 84
            .Width       = 618
            .Height      = 249
            .BackStyle   = 0
            .BorderWidth = 0
        ENDWITH

        *-- Empresa : [cod] [descricao]  (chk) Empresa Destino
        loc_oCnt.AddObject("lbl_4c_Lbl_empresa", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_empresa
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Empresa :"
            .Left      = 45
            .Top       = 13
            .Width     = 51
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 24
        ENDWITH

        loc_oCnt.AddObject("txt_4c__cd_empresa", "TextBox")
        WITH loc_oCnt.txt_4c__cd_empresa
            .Value         = ""
            .FontName      = "Tahoma"
            .Format        = "K!"
            .Height        = 23
            .Left          = 100
            .Top           = 10
            .Width         = 31
            .MaxLength     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .TabIndex      = 1
        ENDWITH

        loc_oCnt.AddObject("txt_4c__ds_empresa", "TextBox")
        WITH loc_oCnt.txt_4c__ds_empresa
            .Value         = ""
            .FontName      = "Tahoma"
            .Format        = "K!"
            .Height        = 23
            .Left          = 134
            .Top           = 10
            .Width         = 291
            .MaxLength     = 40
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .TabIndex      = 2
        ENDWITH

        loc_oCnt.AddObject("chk_4c_ChkEmpD", "CheckBox")
        WITH loc_oCnt.chk_4c_ChkEmpD
            .Value     = 0
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Empresa Destino"
            .Left      = 436
            .Top       = 14
            .Width     = 98
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 3
        ENDWITH

        *-- Periodo : [dt_inicial] a [dt_final]      (opt) Lancamento/Prazo Entrega
        loc_oCnt.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_periodo
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .Caption   = "\<Per" + CHR(237) + "odo :"
            .Left      = 50
            .Top       = 41
            .Width     = 45
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 25
        ENDWITH

        loc_oCnt.AddObject("txt_4c__dt_inicial", "TextBox")
        WITH loc_oCnt.txt_4c__dt_inicial
            .Value         = DATE()
            .FontName      = "Tahoma"
            .Format        = "K"
            .Height        = 23
            .Left          = 100
            .Top           = 37
            .Width         = 80
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 4
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Lbl_periodo_a", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_periodo_a
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .Caption   = CHR(224)
            .Left      = 183
            .Top       = 41
            .Width     = 8
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 26
        ENDWITH

        loc_oCnt.AddObject("txt_4c__dt_final", "TextBox")
        WITH loc_oCnt.txt_4c__dt_final
            .Value         = DATE()
            .FontName      = "Tahoma"
            .Format        = "K"
            .Height        = 23
            .Left          = 193
            .Top           = 37
            .Width         = 80
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 5
        ENDWITH

        loc_oCnt.AddObject("obj_4c_Opt_nr_periodo", "OptionGroup")
        WITH loc_oCnt.obj_4c_Opt_nr_periodo
            .ButtonCount = 2
            .Value       = 1
            .Top         = 36
            .Left        = 273
            .Width       = 185
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .TabIndex    = 6

            WITH .Buttons(1)
                .Caption   = "Lan" + CHR(231) + "amento"
                .BackStyle = 0
                .FontName  = "Tahoma"
                .Left      = 5
                .Top       = 5
                .Width     = 76
                .Height    = 17
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Prazo Entrega"
                .BackStyle = 0
                .FontName  = "Tahoma"
                .Left      = 94
                .Top       = 5
                .Width     = 90
                .Height    = 17
            ENDWITH
        ENDWITH

        *-- Movimentacao : [nm_operacao]   OP : [op]  Numero : [Numero]  Status : [PStatus]
        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Left      = 17
            .Top       = 67
            .Width     = 79
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 27
        ENDWITH

        loc_oCnt.AddObject("txt_4c__nm_operacao", "TextBox")
        WITH loc_oCnt.txt_4c__nm_operacao
            .Value         = ""
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontName      = "Tahoma"
            .FontSize      = 9
            .BackStyle     = 1
            .BorderStyle   = 1
            .Format        = "K!"
            .Height        = 23
            .Left          = 100
            .Top           = 63
            .Width         = 150
            .MaxLength     = 20
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 8
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oCnt.lbl_4c_Label12
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontSize  = 8
            .Caption   = "OP :"
            .Left      = 318
            .Top       = 67
            .Width     = 23
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 28
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Op", "TextBox")
        WITH loc_oCnt.txt_4c_Op
            .Value         = 0
            .Alignment     = 3
            .FontName      = "Tahoma"
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999999"
            .Left          = 348
            .Top           = 63
            .Width         = 55
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 10
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Numero", "TextBox")
        WITH loc_oCnt.txt_4c_Numero
            .Value         = 0
            .Alignment     = 3
            .FontName      = "Tahoma"
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999999"
            .Left          = 252
            .Top           = 63
            .Width         = 55
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 9
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oCnt.lbl_4c_Label8
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Status :"
            .Left      = 410
            .Top       = 67
            .Width     = 42
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 23
        ENDWITH

        loc_oCnt.AddObject("txt_4c_PStatus", "TextBox")
        WITH loc_oCnt.txt_4c_PStatus
            .Value         = ""
            .FontName      = "Tahoma"
            .Height        = 23
            .InputMask     = "A"
            .Left          = 456
            .Top           = 63
            .Width         = 17
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 11
        ENDWITH

        *-- Grupo : [cod] [descricao]
        loc_oCnt.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oCnt.lbl_4c_Label6
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .Caption   = "Grupo :"
            .Left      = 57
            .Top       = 93
            .Width     = 39
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 29
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oCnt.txt_4c_Grupo
            .Value         = ""
            .FontName      = "Tahoma"
            .Format        = "K"
            .Height        = 23
            .Left          = 100
            .Top           = 89
            .Width         = 80
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 12
        ENDWITH

        loc_oCnt.AddObject("txt_4c__Dgrupo", "TextBox")
        WITH loc_oCnt.txt_4c__Dgrupo
            .Value         = ""
            .FontName      = "Tahoma"
            .Format        = "K"
            .Height        = 23
            .Left          = 183
            .Top           = 89
            .Width         = 290
            .MaxLength     = 20
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 13
        ENDWITH

        *-- Conta : [cod] [descricao]        [cpf/cgc]
        loc_oCnt.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oCnt.lbl_4c_Label4
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .Caption   = "Conta :"
            .Left      = 57
            .Top       = 119
            .Width     = 39
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 30
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oCnt.txt_4c_Conta
            .Value         = ""
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 23
            .Left          = 100
            .Top           = 115
            .Width         = 80
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 14
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oCnt.txt_4c_Dconta
            .Value         = ""
            .FontName      = "Courier New"
            .Format        = "K"
            .Height        = 23
            .Left          = 332
            .Top           = 115
            .Width         = 280
            .MaxLength     = 40
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 15
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Cpf", "TextBox")
        WITH loc_oCnt.txt_4c_Cpf
            .Value         = ""
            .FontName      = "Tahoma"
            .Height        = 23
            .InputMask     = "XXXXXXXXXXXXXXXXXXXX"
            .Left          = 183
            .Top           = 115
            .Width         = 146
            .MaxLength     = 20
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 7
        ENDWITH

        *-- Responsavel : [cod] [descricao]
        loc_oCnt.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oCnt.lbl_4c_Label5
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .Caption   = "Respons" + CHR(225) + "vel :"
            .Left      = 25
            .Top       = 145
            .Width     = 70
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 31
        ENDWITH

        loc_oCnt.AddObject("txt_4c__resps", "TextBox")
        WITH loc_oCnt.txt_4c__resps
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 9
            .BackStyle     = 1
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 23
            .Left          = 100
            .Top           = 141
            .Width         = 80
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 16
        ENDWITH

        loc_oCnt.AddObject("txt_4c__dresps", "TextBox")
        WITH loc_oCnt.txt_4c__dresps
            .Value         = ""
            .FontName      = "Tahoma"
            .Format        = "K"
            .Height        = 23
            .Left          = 183
            .Top           = 141
            .Width         = 290
            .MaxLength     = 40
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 17
        ENDWITH

        *-- Moeda : [cod] [descricao]         Cotacao : (o) Fechamento (o) Movimentacao
        loc_oCnt.AddObject("lbl_4c_Lbl_moeda", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_moeda
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .Caption   = "Moeda :"
            .Left      = 54
            .Top       = 171
            .Width     = 41
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 32
        ENDWITH

        loc_oCnt.AddObject("txt_4c__cd_moeda", "TextBox")
        WITH loc_oCnt.txt_4c__cd_moeda
            .Value         = ""
            .FontName      = "Tahoma"
            .Format        = "K!"
            .Height        = 23
            .Left          = 100
            .Top           = 167
            .Width         = 31
            .MaxLength     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 18
        ENDWITH

        loc_oCnt.AddObject("txt_4c__ds_moeda", "TextBox")
        WITH loc_oCnt.txt_4c__ds_moeda
            .Value         = ""
            .FontName      = "Tahoma"
            .Format        = "K!"
            .Height        = 23
            .Left          = 134
            .Top           = 167
            .Width         = 115
            .MaxLength     = 15
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 19
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oCnt.lbl_4c_Label3
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
            .Left      = 253
            .Top       = 171
            .Width     = 49
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 33
        ENDWITH

        loc_oCnt.AddObject("obj_4c_OptCotacao", "OptionGroup")
        WITH loc_oCnt.obj_4c_OptCotacao
            .ButtonCount = 2
            .Value       = 1
            .Top         = 165
            .Left        = 308
            .Width       = 203
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .TabIndex    = 20

            WITH .Buttons(1)
                .Caption   = "\<Fechamento"
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Left      = 5
                .Top       = 5
                .Width     = 89
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "\<Movimenta" + CHR(231) + CHR(227) + "o"
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Left      = 100
                .Top       = 5
                .Width     = 100
                .Height    = 17
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Situacao : OptionGroup de 3 botoes, criado logo abaixo; as captions
        *-- sao transcritas do SCX legado
        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .Left      = 45
            .Top       = 196
            .Width     = 50
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 34
        ENDWITH

        loc_oCnt.AddObject("obj_4c_Opt_Pendente", "OptionGroup")
        WITH loc_oCnt.obj_4c_Opt_Pendente
            .ButtonCount   = 3
            .Value         = 3
            .Top           = 191
            .Left          = 94
            .Width         = 232
            .Height        = 25
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .TabIndex      = 21

            WITH .Buttons(1)
                .Caption   = "Pendentes"
                .BackStyle = 0
                .FontName  = "Tahoma"
                .Left      = 5
                .Top       = 5
                .Width     = 69
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Baixadas"
                .BackStyle = 0
                .FontName  = "Tahoma"
                .Left      = 89
                .Top       = 5
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Todas"
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Left      = 166
                .Top       = 5
                .Width     = 61
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Impressao : (o) Por Vendedor (o) Por Movimentacao
        loc_oCnt.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oCnt.lbl_4c_Label7
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .Caption   = "Impress" + CHR(227) + "o :"
            .Left      = 36
            .Top       = 218
            .Width     = 59
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 35
        ENDWITH

        loc_oCnt.AddObject("obj_4c_Opt_impressao", "OptionGroup")
        WITH loc_oCnt.obj_4c_Opt_impressao
            .ButtonCount   = 2
            .Value         = 1
            .Top           = 213
            .Left          = 94
            .Width         = 229
            .Height        = 25
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .TabIndex      = 22

            WITH .Buttons(1)
                .Caption   = "Por Vendedor"
                .BackStyle = 0
                .Left      = 5
                .Top       = 5
                .Width     = 83
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Por Movimenta" + CHR(231) + CHR(227) + "o"
                .BackStyle = 0
                .Left      = 118
                .Top       = 5
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        loc_oCnt.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarLookupsFiltros - BINDEVENT de KeyPress para TODOS os campos de
    * filtro com lookup no legado (Grupo, Conta, Moeda, Responsavel, Empresa,
    * Movimentacao, CPF/CGC). Cada handler dispara em ENTER(13)/TAB(9)/F4(115),
    * igual ao Valid do SCX (BINDEVENT "Valid" nao funciona em TextBox - regra
    * do CLAUDE.md). Handlers PUBLIC (BINDEVENT exige metodo publico).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarLookupsFiltros()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1

        BINDEVENT(loc_oCnt.txt_4c_Grupo, "KeyPress", THIS, "TxtGrupoCodigoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c__Dgrupo, "KeyPress", THIS, "TxtGrupoDescricaoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Conta, "KeyPress", THIS, "TxtContaCodigoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Dconta, "KeyPress", THIS, "TxtContaDescricaoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c__cd_moeda, "KeyPress", THIS, "TxtMoedaCodigoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c__ds_moeda, "KeyPress", THIS, "TxtMoedaDescricaoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c__resps, "KeyPress", THIS, "TxtRespCodigoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c__dresps, "KeyPress", THIS, "TxtRespDescricaoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c__cd_empresa, "KeyPress", THIS, "TxtEmpresaCodigoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c__ds_empresa, "KeyPress", THIS, "TxtEmpresaDescricaoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c__nm_operacao, "KeyPress", THIS, "TxtOperacaoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Cpf, "KeyPress", THIS, "TxtCpfKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * Handlers de KeyPress (PUBLIC - exigido por BINDEVENT). Cada um so age em
    * ENTER/TAB/F4 e delega para o Validar* correspondente (equivalente ao
    * Valid do controle no SCX legado).
    *--------------------------------------------------------------------------
    PROCEDURE TxtGrupoCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarGrupoCodigo()
    ENDPROC

    PROCEDURE TxtGrupoDescricaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarGrupoDescricao()
    ENDPROC

    PROCEDURE TxtContaCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarContaCodigo()
    ENDPROC

    PROCEDURE TxtContaDescricaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarContaDescricao()
    ENDPROC

    PROCEDURE TxtMoedaCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarMoedaCodigo()
    ENDPROC

    PROCEDURE TxtMoedaDescricaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarMoedaDescricao()
    ENDPROC

    PROCEDURE TxtRespCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarResponsavelCodigo()
    ENDPROC

    PROCEDURE TxtRespDescricaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarResponsavelDescricao()
    ENDPROC

    PROCEDURE TxtEmpresaCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarEmpresaCodigo()
    ENDPROC

    PROCEDURE TxtEmpresaDescricaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarEmpresaDescricao()
    ENDPROC

    PROCEDURE TxtOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarOperacao()
    ENDPROC

    PROCEDURE TxtCpfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarCpf()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupoCodigo / ValidarGrupoDescricao - Grupo Contabil (SigCdGcr).
    * Equivalente a Get_Grupo.Valid / Get_Dgrupo.Valid do legado: chama a
    * funcao ja portada fAcessoContab (utils\functions.prg), que faz o SEEK
    * exato e so abre o picker (FormBuscaSimples, interno a propria funcao)
    * quando nao acha - populando os dois TextBox sozinha.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarGrupoCodigo()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1

        IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
            = fAcessoContab(gc_4c_UsuarioLogado, "C", ALLTRIM(loc_oCnt.txt_4c_Grupo.Value), ;
                loc_oCnt.txt_4c_Grupo, loc_oCnt.txt_4c__Dgrupo)
        ELSE
            loc_oCnt.txt_4c__Dgrupo.Value = ""
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarGrupoDescricao()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1

        IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c__Dgrupo.Value))
            = fAcessoContab(gc_4c_UsuarioLogado, "D", ALLTRIM(loc_oCnt.txt_4c__Dgrupo.Value), ;
                loc_oCnt.txt_4c_Grupo, loc_oCnt.txt_4c__Dgrupo)
        ELSE
            loc_oCnt.txt_4c_Grupo.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaCodigo / ValidarContaDescricao - Conta Corrente (SigCdCli).
    * Equivalente a Get_Conta.Valid / Get_Dconta.Valid: fAcessoContas (portada)
    * faz o SEEK exato + picker interno, e em seguida o legado busca o
    * CPF/CGC da conta escolhida (ObterCpfConta espelha o
    * "CursorQuery('SigCdCli',,'iClis',lcConta,'Cpfs')" do dump).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarContaCodigo()
        LOCAL loc_oCnt, loc_cGrupo, loc_cConta

        loc_oCnt   = THIS.cnt_4c_Container1
        loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)

        IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
            IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", ALLTRIM(loc_oCnt.txt_4c_Conta.Value), ;
                    loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta)
                MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCnt.txt_4c_Conta.Value  = ""
                loc_oCnt.txt_4c_Dconta.Value = ""
                loc_oCnt.txt_4c_Cpf.Value    = ""
            ENDIF
        ELSE
            loc_oCnt.txt_4c_Dconta.Value = ""
            loc_oCnt.txt_4c_Cpf.Value    = ""
        ENDIF

        loc_cConta = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
        IF !EMPTY(loc_cConta)
            loc_oCnt.txt_4c_Cpf.Value = THIS.ObterCpfConta(loc_cConta)
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarContaDescricao()
        LOCAL loc_oCnt, loc_cGrupo, loc_cConta

        loc_oCnt   = THIS.cnt_4c_Container1
        loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)

        IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Dconta.Value))
            IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", ALLTRIM(loc_oCnt.txt_4c_Dconta.Value), ;
                    loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta)
                MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCnt.txt_4c_Dconta.Value = ""
                loc_oCnt.txt_4c_Conta.Value  = ""
                loc_oCnt.txt_4c_Cpf.Value    = ""
            ENDIF
        ELSE
            loc_oCnt.txt_4c_Conta.Value = ""
            loc_oCnt.txt_4c_Cpf.Value   = ""
        ENDIF

        loc_cConta = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
        IF !EMPTY(loc_cConta)
            loc_oCnt.txt_4c_Cpf.Value = THIS.ObterCpfConta(loc_cConta)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCpfConta - Le o CPF/CGC da conta (SigCdCli.Cpfs), equivalente ao
    * ThisForm.Podatamgr.CursorQuery([SigCdCli],[crTmpCli],[iClis],lcConta,[Cpfs])
    * do dump legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterCpfConta(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_cCpf
        loc_cCpf = ""

        IF USED("cursor_4c_SigPrEs1Cpf")
            USE IN cursor_4c_SigPrEs1Cpf
        ENDIF

        loc_cSQL = "SELECT Cpfs FROM SigCdCli WHERE IClis = " + EscaparSQL(par_cConta)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Cpf")

        IF loc_nResultado > 0 AND USED("cursor_4c_SigPrEs1Cpf") AND RECCOUNT("cursor_4c_SigPrEs1Cpf") > 0
            loc_cCpf = ALLTRIM(TratarNulo(cursor_4c_SigPrEs1Cpf.Cpfs, ""))
        ENDIF

        IF USED("cursor_4c_SigPrEs1Cpf")
            USE IN cursor_4c_SigPrEs1Cpf
        ENDIF

        RETURN loc_cCpf
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoedaCodigo / ValidarMoedaDescricao - Moeda (SigCdMoe). O legado
    * usa fwbuscaext (CreateObject direto); aqui o Pattern B (CREATEOBJECT com
    * parametros) eh PROIBIDO - substituido por match exato via SQLEXEC e,
    * na falta, THIS.AbrirLookupCanonico (Pattern A, FormBase.prg).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarMoedaCodigo()
        LOCAL loc_oCnt, loc_cValor
        loc_oCnt  = THIS.cnt_4c_Container1
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c__cd_moeda.Value)

        IF EMPTY(loc_cValor)
            loc_oCnt.txt_4c__ds_moeda.Value = ""
            RETURN
        ENDIF

        THIS.AbrirLookupMoeda(loc_cValor, loc_oCnt.txt_4c__cd_moeda, loc_oCnt.txt_4c__ds_moeda)
    ENDPROC

    PROTECTED PROCEDURE ValidarMoedaDescricao()
        LOCAL loc_oCnt, loc_cValor
        loc_oCnt  = THIS.cnt_4c_Container1
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c__ds_moeda.Value)

        IF EMPTY(loc_cValor)
            loc_oCnt.txt_4c__cd_moeda.Value = ""
            RETURN
        ENDIF

        THIS.AbrirLookupMoeda(loc_cValor, loc_oCnt.txt_4c__cd_moeda, loc_oCnt.txt_4c__ds_moeda)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupMoeda(par_cValor, par_oTxtCod, par_oTxtDesc)
        LOCAL loc_cSQL, loc_nResultado, loc_lAchou
        loc_lAchou = .F.

        IF USED("cursor_4c_SigPrEs1Moe")
            USE IN cursor_4c_SigPrEs1Moe
        ENDIF

        loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(par_cValor) + ;
                   " OR dmoes = " + EscaparSQL(par_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Moe")

        IF loc_nResultado > 0 AND USED("cursor_4c_SigPrEs1Moe") AND RECCOUNT("cursor_4c_SigPrEs1Moe") = 1
            par_oTxtCod.Value  = ALLTRIM(cursor_4c_SigPrEs1Moe.cmoes)
            par_oTxtDesc.Value = ALLTRIM(cursor_4c_SigPrEs1Moe.dmoes)
            loc_lAchou = .T.
        ENDIF

        IF USED("cursor_4c_SigPrEs1Moe")
            USE IN cursor_4c_SigPrEs1Moe
        ENDIF

        IF !loc_lAchou
            IF !THIS.AbrirLookupCanonico("SigCdMoe", "cmoes", "dmoes", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Moeda", par_cValor, par_oTxtCod, par_oTxtDesc)
                par_oTxtCod.Value  = ""
                par_oTxtDesc.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarResponsavelCodigo / ValidarResponsavelDescricao - Responsavel
    * (Vendedor - SigCdCli). Equivalente a get_resps.Valid / get_dresps.Valid:
    * o Grupo eh o mesmo de todo o form (LocalParam.GrPadVens do legado ->
    * this_cGrupoPadraoResponsavel, carregado em SigPrEs1BO.Init()).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarResponsavelCodigo()
        LOCAL loc_oCnt, loc_cGrupo
        loc_oCnt   = THIS.cnt_4c_Container1
        loc_cGrupo = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoPadraoResponsavel)

        IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c__resps.Value))
            IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", ALLTRIM(loc_oCnt.txt_4c__resps.Value), ;
                    loc_oCnt.txt_4c__resps, loc_oCnt.txt_4c__dresps)
                MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCnt.txt_4c__resps.Value  = ""
                loc_oCnt.txt_4c__dresps.Value = ""
            ENDIF
        ELSE
            loc_oCnt.txt_4c__dresps.Value = ""
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarResponsavelDescricao()
        LOCAL loc_oCnt, loc_cGrupo
        loc_oCnt   = THIS.cnt_4c_Container1
        loc_cGrupo = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoPadraoResponsavel)

        IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c__dresps.Value))
            IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", ALLTRIM(loc_oCnt.txt_4c__dresps.Value), ;
                    loc_oCnt.txt_4c__resps, loc_oCnt.txt_4c__dresps)
                MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCnt.txt_4c__dresps.Value = ""
                loc_oCnt.txt_4c__resps.Value  = ""
            ENDIF
        ELSE
            loc_oCnt.txt_4c__resps.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresaCodigo / ValidarEmpresaDescricao - Empresa (SigCdEmp). O
    * legado chama fAcessoEmpresa, que NAO foi portada (CLAUDE.md); substituto
    * canonico documentado: match exato em Cemps/Razas e, na falta,
    * AbrirLookupCanonico apontando SigCdEmp/Cemps/Razas.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarEmpresaCodigo()
        LOCAL loc_oCnt, loc_cValor
        loc_oCnt  = THIS.cnt_4c_Container1
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c__cd_empresa.Value)

        IF EMPTY(loc_cValor)
            loc_oCnt.txt_4c__ds_empresa.Value = ""
            RETURN
        ENDIF

        THIS.AbrirLookupEmpresa(loc_cValor, loc_oCnt.txt_4c__cd_empresa, loc_oCnt.txt_4c__ds_empresa)
    ENDPROC

    PROTECTED PROCEDURE ValidarEmpresaDescricao()
        LOCAL loc_oCnt, loc_cValor
        loc_oCnt  = THIS.cnt_4c_Container1
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c__ds_empresa.Value)

        IF EMPTY(loc_cValor)
            loc_oCnt.txt_4c__cd_empresa.Value = ""
            RETURN
        ENDIF

        THIS.AbrirLookupEmpresa(loc_cValor, loc_oCnt.txt_4c__cd_empresa, loc_oCnt.txt_4c__ds_empresa)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupEmpresa(par_cValor, par_oTxtCod, par_oTxtDesc)
        LOCAL loc_cSQL, loc_nResultado, loc_lAchou
        loc_lAchou = .F.

        IF USED("cursor_4c_SigPrEs1Emp")
            USE IN cursor_4c_SigPrEs1Emp
        ENDIF

        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(par_cValor) + ;
                   " OR Razas = " + EscaparSQL(par_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Emp")

        IF loc_nResultado > 0 AND USED("cursor_4c_SigPrEs1Emp") AND RECCOUNT("cursor_4c_SigPrEs1Emp") = 1
            par_oTxtCod.Value  = ALLTRIM(cursor_4c_SigPrEs1Emp.Cemps)
            par_oTxtDesc.Value = ALLTRIM(cursor_4c_SigPrEs1Emp.Razas)
            loc_lAchou = .T.
        ENDIF

        IF USED("cursor_4c_SigPrEs1Emp")
            USE IN cursor_4c_SigPrEs1Emp
        ENDIF

        IF !loc_lAchou
            IF !THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Empresa", par_cValor, par_oTxtCod, par_oTxtDesc)
                par_oTxtCod.Value  = ""
                par_oTxtDesc.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOperacao - Movimentacao (SigCdOpe, tabela SINGLE-COLUMN: Dopes eh
    * PK e descricao ao mesmo tempo - CLAUDE.md regra sobre SigCdOpe). O
    * legado chama fAcessoMovmto, que NAO foi portada; substituto: match
    * exato em Dopes e, na falta, AbrirLookupCanonico com Dopes nas duas
    * colunas.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarOperacao()
        LOCAL loc_oCnt, loc_cValor, loc_lAchou

        loc_oCnt   = THIS.cnt_4c_Container1
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_lAchou = .F.
        IF USED("cursor_4c_SigPrEs1Ope")
            USE IN cursor_4c_SigPrEs1Ope
        ENDIF

        IF SQLEXEC(gnConnHandle, "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cValor), ;
                "cursor_4c_SigPrEs1Ope") > 0 AND USED("cursor_4c_SigPrEs1Ope") AND RECCOUNT("cursor_4c_SigPrEs1Ope") > 0
            loc_lAchou = .T.
        ENDIF

        IF USED("cursor_4c_SigPrEs1Ope")
            USE IN cursor_4c_SigPrEs1Ope
        ENDIF

        IF !loc_lAchou
            IF !THIS.AbrirLookupCanonico("SigCdOpe", "Dopes", "Dopes", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Movimenta" + CHR(231) + CHR(227) + "o", ;
                    loc_cValor, loc_oCnt.txt_4c__nm_operacao, .NULL.)
                loc_oCnt.txt_4c__nm_operacao.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCpf - Equivalente ao Get_cpf.Valid do legado: valida CPF/CNPJ
    * (fValidarCPF/fValidarCNPJ do legado -> ValidarCPF/ValidarCNPJ portadas em
    * utils\validators.prg), busca a conta dona daquele CPF/CGC em SigCdCli e
    * reconfirma o acesso via fAcessoContas antes de preencher Conta/Dconta.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCpf()
        LOCAL loc_oCnt, loc_cValor, loc_cDigitos, loc_cMascarado, loc_lValido
        LOCAL loc_cSQL, loc_nResultado, loc_cIclis

        loc_oCnt   = THIS.cnt_4c_Container1
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Cpf.Value)

        IF EMPTY(loc_cValor)
            loc_oCnt.txt_4c_Dconta.Value = ""
            RETURN
        ENDIF

        loc_cDigitos = STRTRAN(STRTRAN(STRTRAN(loc_cValor, ".", ""), "-", ""), "/", "")

        IF LEN(ALLTRIM(loc_cDigitos)) = 14
            loc_cMascarado = TRANSFORM(loc_cDigitos, "@R 99.999.999/9999-99")
            loc_lValido    = ValidarCNPJ(loc_cDigitos)
        ELSE
            loc_cMascarado = TRANSFORM(loc_cDigitos, "@R 999.999.999-99")
            loc_lValido    = ValidarCPF(loc_cDigitos)
        ENDIF

        IF !loc_lValido
            MsgAviso("CPF / CGC Incorreto !!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oCnt.txt_4c_Cpf.SetFocus()
            RETURN
        ENDIF

        IF USED("cursor_4c_SigPrEs1Cli")
            USE IN cursor_4c_SigPrEs1Cli
        ENDIF

        loc_cSQL = "SELECT IClis, RClis, Cpfs FROM SigCdCli WHERE Cpfs = " + ;
            EscaparSQL(PADR(loc_cMascarado, 20))
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Cli")

        IF loc_nResultado <= 0 OR !USED("cursor_4c_SigPrEs1Cli") OR RECCOUNT("cursor_4c_SigPrEs1Cli") = 0
            MsgAviso("CPF / CGC n" + CHR(227) + "o encontrado !!!", "Aten" + CHR(231) + CHR(227) + "o")
            IF USED("cursor_4c_SigPrEs1Cli")
                USE IN cursor_4c_SigPrEs1Cli
            ENDIF
            loc_oCnt.txt_4c_Cpf.SetFocus()
            RETURN
        ENDIF

        loc_cIclis = ALLTRIM(cursor_4c_SigPrEs1Cli.IClis)

        IF !fAcessoContas(gc_4c_UsuarioLogado, "", "C", loc_cIclis, loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta)
            MsgAviso("Acesso Negado !!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oCnt.txt_4c_Conta.Value  = ""
            loc_oCnt.txt_4c_Dconta.Value = ""
            loc_oCnt.txt_4c_Cpf.Value    = ""
        ELSE
            loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_SigPrEs1Cli.IClis)
            loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_SigPrEs1Cli.RClis)
            loc_oCnt.txt_4c_Cpf.Value    = ALLTRIM(TratarNulo(cursor_4c_SigPrEs1Cli.Cpfs, ""))
        ENDIF

        IF USED("cursor_4c_SigPrEs1Cli")
            USE IN cursor_4c_SigPrEs1Cli
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - Cria obj_4c_Sair (commandgroup "sair" do legado -
    * SECAO 2: Top=-2 Left=665 Width=161 Height=85, BackStyle=0,
    * BorderStyle=0, Themes=.F.) com os 2 botoes do dump legado
    * (Command1="consulta"/Command2="sair"), equivalente aos botoes CRUD dos
    * forms de cadastro. Buttons(N) EXATOS do dump (Top/Left/Height/Width/
    * FontName="Comic Sans MS"/ForeColor/BackColor/Themes=.F.) - NUNCA
    * inventar posicao (CLAUDE.md regra #33/framework_frmcadastro_layout.md).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        THIS.AddObject("obj_4c_Sair", "CommandGroup")
        WITH THIS.obj_4c_Sair
            .ButtonCount  = 2
            .Top          = -2
            .Left         = 665
            .Width        = 161
            .Height       = 85
            .BackStyle    = 0
            .BorderStyle  = 0
            .Themes       = .F.

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
                .Caption    = "\<Consultar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 81
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "\<Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH

            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Dispatcher do CommandGroup obj_4c_Sair (BINDEVENT em
    * InicializarForm). Value=1 -> Consultar (consulta.Click do legado);
    * Value=2 -> Encerrar (sair.Click do legado).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        DO CASE
        CASE THIS.obj_4c_Sair.Value = 1
            THIS.BtnConsultarClick()
        CASE THIS.obj_4c_Sair.Value = 2
            THIS.BtnEncerrarClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConsultarClick - Equivalente ao PROCEDURE consulta.Click do legado.
    * As 3 validacoes de UI (Empresa/Operacao/Periodo) e a ordem em que
    * disparam SetFocus sao transcritas literalmente - a mesma checagem
    * tambem existe em SigPrEs1BO.ValidarFiltros() como rede de seguranca,
    * mas so o Form tem a referencia de controle para SetFocus (regra #17 do
    * CLAUDE.md - transcrever a formula/fluxo do legado, guards inclusos).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConsultarClick()
        LOCAL loc_oBO, loc_oCnt, loc_lSucesso

        loc_oBO  = THIS.this_oBusinessObject
        loc_oCnt = THIS.cnt_4c_Container1

        IF EMPTY(ALLTRIM(loc_oCnt.txt_4c__cd_empresa.Value))
            MsgAviso("Empresa Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oCnt.txt_4c__cd_empresa.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value))
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oCnt.txt_4c__nm_operacao.SetFocus()
            RETURN
        ENDIF

        IF loc_oCnt.txt_4c__dt_final.Value < loc_oCnt.txt_4c__dt_inicial.Value
            MsgAviso("Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! Data Final Menor do Que a Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oCnt.txt_4c__dt_inicial.SetFocus()
            RETURN
        ENDIF

        THIS.FormParaBO()

        *-- ALCANCE do "ThisForm.Enabled" transcrito do legado (linhas 1697-1716
        *-- do dump): o SqlExecute roda ANTES de "ThisForm.Enabled = .f." e, em
        *-- caso de falha, exibe 'Favor Reinicializar o Processo!!!' e faz
        *-- "Return 0" SEM ter desabilitado o form. Manter essa fronteira nao eh
        *-- detalhe: este form eh MODAL (WindowType = 1) e nao tem barra de
        *-- titulo (TitleBar = 0 / ControlBox = .F.), entao form desabilitado
        *-- deixa o usuario SEM SAIDA - nem o Encerrar responde. Cobrir a
        *-- consulta SQL com o Enabled = .F. alargaria o alcance do legado e
        *-- trancaria a tela em todo caminho que nao chegasse ao Enabled = .T.
        loc_lSucesso = loc_oBO.BuscarMovimentacao()

        IF !loc_lSucesso
            *-- Legado: Messagebox('Favor Reinicializar o Processo!!!', 16,
            *-- 'Falha na Conexao (csTemporario)'). O texto da mensagem ja vem
            *-- em this_cMensagemErro (SigPrEs1BO.BuscarMovimentacao); aqui vai
            *-- o titulo literal do legado.
            MsgErro(loc_oBO.this_cMensagemErro, ;
                "Falha na Conex" + CHR(227) + "o (csTemporario)")
            RETURN
        ENDIF

        *-- Legado: ThisForm.Enabled = .f. / If (Reccount() > 0) Do Form
        *-- sigpres2 Else Messagebox('Nenhum Registro Selecionado!!!') /
        *-- ThisForm.Enabled = .t. - o aviso fica DENTRO do trecho desabilitado,
        *-- exatamente como no legado.
        THIS.Enabled = .F.

        IF loc_oBO.this_nTotalRegistros > 0
            THIS.AbrirTelaMovimentacao(ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value))
        ELSE
            MsgAviso("Nenhum Registro Selecionado!!!", "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF

        THIS.Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia os campos de cnt_4c_Container1 para as
    * propriedades this_* do BO, equivalente as variaveis locais lnNrP/lcNmO/
    * lcEst/lcCon/lnPen/lcVen/lcEmp/lcSta/lnEmpD/pDtI/pDtF/pNOp/pNum do
    * consulta.Click legado. Campos de cnt_4c_Container1 sao criados nas
    * Fases 5-6 (mesmos nomes de tasks\task606\mapeamento.json).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oCnt

        loc_oBO  = THIS.this_oBusinessObject
        loc_oCnt = THIS.cnt_4c_Container1

        loc_oBO.this_nOpcaoPeriodo    = loc_oCnt.obj_4c_Opt_nr_periodo.Value
        loc_oBO.this_cNomeOperacao    = ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value)
        loc_oBO.this_cGrupo           = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
        loc_oBO.this_cConta           = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
        loc_oBO.this_nOpcaoPendente   = loc_oCnt.obj_4c_Opt_Pendente.Value
        loc_oBO.this_cResponsavel     = ALLTRIM(loc_oCnt.txt_4c__resps.Value)
        loc_oBO.this_cCodigoEmpresa   = ALLTRIM(loc_oCnt.txt_4c__cd_empresa.Value)
        loc_oBO.this_cStatus          = ALLTRIM(loc_oCnt.txt_4c_PStatus.Value)
        loc_oBO.this_lEmpresaDestino  = (loc_oCnt.chk_4c_ChkEmpD.Value = 1)
        loc_oBO.this_dDataInicial     = loc_oCnt.txt_4c__dt_inicial.Value
        loc_oBO.this_dDataFinal       = loc_oCnt.txt_4c__dt_final.Value
        loc_oBO.this_nOperacao        = loc_oCnt.txt_4c_Op.Value
        loc_oBO.this_nNumero          = loc_oCnt.txt_4c_Numero.Value
        loc_oBO.this_cDescricaoGrupo  = ALLTRIM(loc_oCnt.txt_4c__Dgrupo.Value)
        loc_oBO.this_cDescricaoConta  = ALLTRIM(loc_oCnt.txt_4c_Dconta.Value)
        loc_oBO.this_cCpfCnpj         = ALLTRIM(loc_oCnt.txt_4c_Cpf.Value)
        loc_oBO.this_cDescricaoEmpresa = ALLTRIM(loc_oCnt.txt_4c__ds_empresa.Value)
        loc_oBO.this_cCodigoMoeda     = ALLTRIM(loc_oCnt.txt_4c__cd_moeda.Value)
        loc_oBO.this_cDescricaoMoeda  = ALLTRIM(loc_oCnt.txt_4c__ds_moeda.Value)
        loc_oBO.this_cDescricaoResponsavel = ALLTRIM(loc_oCnt.txt_4c__dresps.Value)
        loc_oBO.this_nOpcaoCotacao    = loc_oCnt.obj_4c_OptCotacao.Value
        loc_oBO.this_nOpcaoImpressao  = loc_oCnt.obj_4c_Opt_impressao.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Caminho INVERSO do FormParaBO: joga o estado inicial do BO
    * nos controles de cnt_4c_Container1. Equivalente LITERAL ao bloco
    * "With .Container1 ... EndWith" do PROCEDURE Init legado, que roda uma
    * unica vez na abertura da tela:
    *
    *     .get_nm_operacao.Value = ''         .get_dConta.Value     = Space(30)
    *     .get_dt_inicial.Value  = date()     .get_cd_moeda.Value   = ' '
    *     .get_dt_final.Value    = date()     .get_resps.Value      = ''
    *     .get_Grupo.Value       = Space(10)  .get_dresps.Value     = ''
    *     .get_dgrupo.Value      = Space(30)  .get_cd_empresa.Value = _empr
    *     .get_Conta.Value       = Space(10)
    *
    * O legado NAO toca em get_ds_empresa, getPStatus, Get_Numero, Get_op nem
    * Get_cpf neste bloco - eles nascem vazios e assim continuam aqui (PILAR 1:
    * a Empresa abre com o CODIGO preenchido e a razao social em branco ate o
    * usuario acionar o lookup, exatamente como na tela legada).
    *
    * _EMPR eh a PUBLIC do Framework Fortyus e NAO deve ser usada (CLAUDE.md,
    * secao Global Variables): a fonte canonica eh go_4c_Sistema.cCodEmpresa,
    * que SigPrEs1BO.Init() ja leu para this_cCodigoEmpresa. Ler do BO em vez
    * da global deixa o Form com uma fonte unica.
    *
    * Os Space(10)/Space(30) do legado viram "" porque os TextBox migrados tem
    * MaxLength vindo da largura da coluna no schema (CLAUDE.md regra #19) e
    * qualquer EMPTY()/ALLTRIM() das validacoes trata os dois casos igual: o que o
    * legado quis dizer ali eh "campo em branco".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oCnt

        loc_oBO  = THIS.this_oBusinessObject
        loc_oCnt = THIS.cnt_4c_Container1

        loc_oCnt.txt_4c__nm_operacao.Value = loc_oBO.this_cNomeOperacao
        loc_oCnt.txt_4c__dt_inicial.Value  = ConverterParaData(loc_oBO.this_dDataInicial)
        loc_oCnt.txt_4c__dt_final.Value    = ConverterParaData(loc_oBO.this_dDataFinal)
        loc_oCnt.txt_4c_Grupo.Value        = loc_oBO.this_cGrupo
        loc_oCnt.txt_4c__Dgrupo.Value      = loc_oBO.this_cDescricaoGrupo
        loc_oCnt.txt_4c_Conta.Value        = loc_oBO.this_cConta
        loc_oCnt.txt_4c_Dconta.Value       = loc_oBO.this_cDescricaoConta
        loc_oCnt.txt_4c__cd_moeda.Value    = loc_oBO.this_cCodigoMoeda
        loc_oCnt.txt_4c__resps.Value       = loc_oBO.this_cResponsavel
        loc_oCnt.txt_4c__dresps.Value      = loc_oBO.this_cDescricaoResponsavel

        *-- Legado: .get_cd_empresa.Value = _empr. Sem esta linha a tela abre
        *-- com a Empresa VAZIA e o primeiro clique em Consultar cai direto na
        *-- validacao "Empresa Invalida!!!" - o usuario teria de digitar a
        *-- empresa em toda abertura, o que o legado nunca exigiu.
        loc_oCnt.txt_4c__cd_empresa.Value = loc_oBO.this_cCodigoEmpresa
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirTelaMovimentacao - Equivalente ao trecho final do consulta.Click
    * legado: "Do Form sigpres2 With lcNmO, ThisForm.DataSessionId, ThisForm".
    *
    * Formsigpres2BO.CarregarDoCursorTemporario() e Formsigpres2.CarregarLista()
    * (grd_4c_Lista.RecordSource) leem o cursor GLOBAL "csTemporario" pelo
    * NOME LITERAL - o mesmo nome que o legado usava (SqlExecute(lcQuery,
    * 'csTemporario')). Por isso o resultado de BuscarMovimentacao()
    * (cursor_4c_Movimentacao, nome canonico do BO) e copiado para um cursor
    * "csTemporario" antes do CREATEOBJECT - renomear quebraria o contrato
    * com a tela filha ja migrada (regra do wrapper: reproduzir o CONTRATO,
    * nao so o nome).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirTelaMovimentacao(par_cNomeOperacao)
        LOCAL loc_oForm, loc_oErro, loc_lFalhou

        loc_oForm   = .NULL.
        loc_lFalhou = .F.

        *-- O TRY cobre SO a preparacao do cursor e o CREATEOBJECT - o Show()
        *-- fica FORA (CLAUDE.md regra #29). Formsigpres2 tem WindowType = 1,
        *-- entao o Show() BLOQUEIA e a tela filha inteira (cada Valid, cada
        *-- Click) viveria dentro deste bloco; como TRY/CATCH tem precedencia
        *-- sobre ON ERROR em qualquer ponto da pilha, um erro de runtime la
        *-- dentro saltaria para o CATCH, abandonaria o TRY, derrubaria a
        *-- referencia LOCAL loc_oForm e DESTRUIRIA a tela filha no meio do uso
        *-- (sintoma: "a tela fecha sozinha", Destroy sem QueryUnload).
        TRY
            IF USED("csTemporario")
                USE IN csTemporario
            ENDIF

            SELECT * FROM cursor_4c_Movimentacao INTO CURSOR csTemporario READWRITE

            *-- Legado (dump linha 1704): "Index On EmpDopNums Tag EmpDopNums"
            *-- roda no PROPRIO csTemporario, logo apos o SqlExecute. O indice
            *-- que SigPrEs1BO.BuscarMovimentacao cria em cursor_4c_Movimentacao
            *-- NAO atravessa o SELECT ... INTO CURSOR acima - um cursor novo
            *-- nasce sem tag nenhuma. Sem refazer aqui, a tela filha recebe o
            *-- csTemporario SEM a tag e um SEEK nela falharia devolvendo ZERO
            *-- linhas, sem erro e sem log (CLAUDE.md regra #42).
            SELECT csTemporario
            INDEX ON EmpDopNums TAG EmpDopNums

            GO TOP IN csTemporario

            loc_oForm = CREATEOBJECT("Formsigpres2", par_cNomeOperacao, THIS.DataSessionId, THIS)
        CATCH TO loc_oErro
            loc_oForm   = .NULL.
            loc_lFalhou = .T.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao abrir Movimenta" + CHR(231) + CHR(227) + "o")
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            *-- Legado: "Do Form sigpres2 With lcNmO, ThisForm.DataSessionId,
            *-- ThisForm". Formsigpres2 nao declara DataSession, logo usa a
            *-- sessao CORRENTE (= a sessao privada 2 deste form), e por isso
            *-- ve o csTemporario criado acima - equivalente ao legado passar o
            *-- DataSessionId do pai.
            loc_oForm.Show()
        ELSE
            *-- CREATEOBJECT tambem devolve .F. (sem excecao) quando o Init da
            *-- tela filha retorna .F.; nesse caminho o CATCH nao roda e a
            *-- falha precisa aparecer.
            IF !loc_lFalhou
                MsgErro("Erro ao abrir tela de movimenta" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        ENDIF

        IF USED("csTemporario")
            USE IN csTemporario
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Equivalente ao PROCEDURE sair.Click do legado
    * ("ThisForm.Release").
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject() cria controles com Visible=.F.
    * por padrao (CLAUDE.md); percorre recursivamente o container recebido
    * tornando tudo visivel, inclusive containers aninhados. CommandGroup
    * (obj_4c_Sair) nao tem ControlCount/Controls - so Visible eh setado
    * nele, os Buttons() ficam visiveis automaticamente com o grupo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oCtrl

        IF VARTYPE(par_oContainer) != "O" OR !PEMSTATUS(par_oContainer, "ControlCount", 5)
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - this_oBusinessObject = .NULL. (heranca FormBase.Destroy())
    * libera a ultima referencia ao SigPrEs1BO, disparando SigPrEs1BO.Destroy()
    * automaticamente (fecha cursor_4c_Movimentacao). Equivalente ao
    * "ThisForm.poDataMgr.Release" do PROCEDURE Release legado - aqui nao ha
    * conexao privada por form para liberar (gnConnHandle eh global).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrEs1BO.prg):
*------------------------------------------------------------------------------
* SigPrEs1BO.prg - Business Object para Posicao Por Movimentacao
* Form legado: SIGPRES1 (form OPERACIONAL - filtro de relatorio, sem tabela CRUD)
* Herdado de: BusinessBase
*
* O legado nao grava em tabela alguma: monta filtros e consulta SigMvCab +
* SigCdOpe para alimentar a tela filha (sigpres2). Conferido no dump
* tasks\task606\SigPrEs1_form_codigo_fonte.txt: nenhum TABLEUPDATE(), nenhum
* .AddCursor(), e o unico comando de escrita eh
*   Update csTemporario Set PrazoEnts = Iif(IsNull(PrazoEnts), Ctod(''), ...)
* cujo alvo csTemporario eh o CURSOR LOCAL criado por
* poDataMgr.SqlExecute(lcQuery, 'csTemporario') - ou seja, ajuste em memoria
* que nunca volta para o banco.
*
* Por isso este BO deixa Inserir(), Atualizar() e ExecutarExclusao() HERDADOS
* de BusinessBase: a base ja recusa a operacao e reporta pelo ExibirFalha() do
* Salvar(), que eh o comportamento correto aqui. Sobrescrever esses metodos
* exigiria INVENTAR um INSERT/UPDATE, o que a regra #22 do CLAUDE.md proibe
* (a lista de colunas vem do schema, nunca de adivinhacao).
*
* O metodo de negocio real eh BuscarMovimentacao(), equivalente ao
* consulta.Click do SCX original. CarregarDoCursor() le a linha corrente do
* cursor de resultado e ObterChavePrimaria() devolve a chave EmpDopNums dessa
* linha (usada pela auditoria de BusinessBase e pelo handoff para a tela
* filha).
*------------------------------------------------------------------------------
DEFINE CLASS SigPrEs1BO AS BusinessBase

    *-- Configuracao da entidade (form OPERACIONAL - nao ha tabela unica/CRUD)
    this_cTabela     = "SigMvCab"
    this_cCampoChave = ""

    *-- Filtro: Movimentacao / Periodo
    this_cNomeOperacao = ""
    this_dDataInicial  = {}
    this_dDataFinal    = {}
    this_nNumero       = 0
    this_nOperacao     = 0
    this_cStatus       = ""

    *-- Filtro: Grupo / Conta
    this_cGrupo            = ""
    this_cDescricaoGrupo   = ""
    this_cConta            = ""
    this_cDescricaoConta   = ""
    this_cCpfCnpj          = ""

    *-- Filtro: Moeda
    this_cCodigoMoeda    = ""
    this_cDescricaoMoeda = ""

    *-- Filtro: Responsavel
    this_cResponsavel          = ""
    this_cDescricaoResponsavel = ""

    *-- Filtro: Empresa
    this_cCodigoEmpresa    = ""
    this_cDescricaoEmpresa = ""
    this_lEmpresaDestino   = .F.

    *-- Opcoes (OptionGroups do filtro) - valores DEFAULT identicos ao SCX legado
    this_nOpcaoPeriodo    = 1
    this_nOpcaoPendente   = 3
    this_nOpcaoImpressao  = 1
    this_nOpcaoCotacao    = 1

    *-- Parametros do sistema (equivalente ao cursor LocalParam do legado)
    this_cGrupoPadraoResponsavel = ""

    *-- Resultado da consulta (equivalente ao cursor csTemporario do legado)
    this_cCursorResultado = "cursor_4c_Movimentacao"
    this_nTotalRegistros  = 0

    *-- Linha corrente do cursor de resultado, lida por CarregarDoCursor().
    *-- Sao EXATAMENTE as colunas de SigMvCab que o legado nomeia no lcWhere /
    *-- lcQuery do consulta.Click, mais a chave empdopnums usada no Index On -
    *-- nenhuma coluna a mais. Conferidas uma a uma em docs\schema.sql:
    *--   emps char(3)        empds char(3)       dopes char(20)
    *--   datas datetime      prazoents datetime  grupoos char(10)
    *--   grupods char(10)    contaos char(10)    contads char(10)
    *--   nops numeric(10,0)  numes numeric(6,0)  vends char(10)
    *--   chksubn bit         pstatus char(1)     empdopnums char(29)
    this_cRegEmpresa       = ""
    this_cRegEmpresaDest   = ""
    this_cRegOperacao      = ""
    *-- {/:} eh DATETIME vazio (VARTYPE "T"): as colunas datas/prazoents sao
    *-- datetime, e manter o tipo estavel antes e depois da carga evita o erro
    *-- 11 de TTOD() com DATE (regra #16 do CLAUDE.md).
    this_dRegData          = {/:}
    this_dRegPrazoEntrega  = {/:}
    this_cRegGrupoOrigem   = ""
    this_cRegGrupoDestino  = ""
    this_cRegContaOrigem   = ""
    this_cRegContaDestino  = ""
    this_nRegNumeroOp      = 0
    this_nRegNumero        = 0
    this_cRegVendedor      = ""
    this_lRegBaixada       = .F.
    this_cRegStatus        = ""
    this_cRegChave         = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro

        TRY
            loc_lSucesso = DODEFAULT()

            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = ""

            THIS.this_cNomeOperacao = ""
            THIS.this_dDataInicial  = DATE()
            THIS.this_dDataFinal    = DATE()
            THIS.this_nNumero       = 0
            THIS.this_nOperacao     = 0
            THIS.this_cStatus       = ""

            THIS.this_cGrupo          = ""
            THIS.this_cDescricaoGrupo = ""
            THIS.this_cConta          = ""
            THIS.this_cDescricaoConta = ""
            THIS.this_cCpfCnpj        = ""

            THIS.this_cCodigoMoeda    = ""
            THIS.this_cDescricaoMoeda = ""

            THIS.this_cResponsavel          = ""
            THIS.this_cDescricaoResponsavel = ""

            *-- Legado: .get_cd_empresa.Value = _empr
            *-- _EMPR eh variavel do Framework antigo; a fonte canonica no
            *-- sistema novo eh go_4c_Sistema.cCodEmpresa (config.prg).
            THIS.this_cCodigoEmpresa = ""
            IF TYPE("go_4c_Sistema") = "O"
                THIS.this_cCodigoEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
            ENDIF
            THIS.this_cDescricaoEmpresa = ""
            THIS.this_lEmpresaDestino   = .F.

            THIS.this_nOpcaoPeriodo   = 1
            THIS.this_nOpcaoPendente  = 3
            THIS.this_nOpcaoImpressao = 1
            THIS.this_nOpcaoCotacao   = 1

            THIS.this_cGrupoPadraoResponsavel = ""
            THIS.this_cCursorResultado        = "cursor_4c_Movimentacao"
            THIS.this_nTotalRegistros         = 0

            THIS.LimparLinhaCorrente()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        IF loc_lSucesso
            *-- Equivalente ao SqlExecute("Select GrPadVens From SigCdPam...", "LocalParam")
            *-- do Init legado - usado pela validacao de acesso do Responsavel.
            THIS.CarregarParametrosSistema()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - Carrega parametros globais de SigCdPam
    * Equivalente ao cursor LocalParam populado no Init do form legado:
    *   Select GrPadVens From SigCdPam Where Not cIdChaves = fUniqueIds()
    * (a comparacao com um id recem-gerado nunca casa, entao devolve a linha
    * unica de parametros da empresa - transcrito literalmente do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarParametrosSistema()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL = "SELECT GrPadVens FROM SigCdPam WHERE NOT cidchaves = " + ;
                    EscaparSQL(fUniqueIds())

                IF USED("cursor_4c_SigPrEs1Pam")
                    USE IN cursor_4c_SigPrEs1Pam
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Pam")

                IF loc_nResultado > 0 AND USED("cursor_4c_SigPrEs1Pam")
                    SELECT cursor_4c_SigPrEs1Pam
                    GO TOP
                    IF !EOF()
                        THIS.this_cGrupoPadraoResponsavel = ALLTRIM(TratarNulo(GrPadVens, ""))
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL()
                ENDIF

                IF USED("cursor_4c_SigPrEs1Pam")
                    USE IN cursor_4c_SigPrEs1Pam
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Reproduz as validacoes do consulta.Click do legado antes
    * de disparar a consulta: Empresa, Operacao (Movimentacao) e Periodo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_lValido

        loc_lValido = .T.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cCodigoEmpresa))
            THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida!!!"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cNomeOperacao))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_dDataFinal < THIS.this_dDataInicial
            THIS.this_cMensagemErro = "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! Data Final Menor do Que a Inicial!!!"
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarWhereConsulta - Monta o trecho de filtros da consulta, transcrito
    * literalmente da variavel lcWhere do metodo consulta.Click do legado.
    * Cada filtro so entra na clausula quando o campo correspondente esta
    * preenchido, exatamente como no SCX original.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarWhereConsulta()
        LOCAL loc_cWhere

        loc_cWhere = ""

        IF !EMPTY(ALLTRIM(THIS.this_cNomeOperacao))
            loc_cWhere = loc_cWhere + "a.Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cNomeOperacao)) + " And "
        ENDIF

        IF THIS.this_nOpcaoPeriodo = 1
            loc_cWhere = loc_cWhere + "a.Datas BetWeen " + ;
                FormatarDataSQL(fDtoSQL(THIS.this_dDataInicial)) + " And " + ;
                FormatarDataSQL(fDtoSQL(THIS.this_dDataFinal, "23:59:59")) + " And "
        ELSE
            loc_cWhere = loc_cWhere + "a.PrazoEnts BetWeen " + ;
                FormatarDataSQL(fDtoSQL(THIS.this_dDataInicial)) + " And " + ;
                FormatarDataSQL(fDtoSQL(THIS.this_dDataFinal, "23:59:59")) + " And "
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
            loc_cWhere = loc_cWhere + "(a.GrupoOs = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo)) + ;
                " Or a.GrupoDs = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo)) + ") And "
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cConta))
            loc_cWhere = loc_cWhere + "(a.ContaOs = " + EscaparSQL(ALLTRIM(THIS.this_cConta)) + ;
                " Or a.ContaDs = " + EscaparSQL(ALLTRIM(THIS.this_cConta)) + ") And "
        ENDIF

        IF THIS.this_nOperacao != 0
            loc_cWhere = loc_cWhere + "a.Nops = " + FormatarNumeroSQL(THIS.this_nOperacao, 0) + " And "
        ENDIF

        IF THIS.this_nNumero != 0
            loc_cWhere = loc_cWhere + "a.Numes = " + FormatarNumeroSQL(THIS.this_nNumero, 0) + " And "
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cResponsavel))
            loc_cWhere = loc_cWhere + "a.Vends = " + EscaparSQL(ALLTRIM(THIS.this_cResponsavel)) + " And "
        ENDIF

        DO CASE
            CASE THIS.this_nOpcaoPendente = 1
                loc_cWhere = loc_cWhere + "a.ChkSubn = 0 And "
            CASE THIS.this_nOpcaoPendente = 2
                loc_cWhere = loc_cWhere + "a.ChkSubn = 1 And "
        ENDCASE

        IF !EMPTY(ALLTRIM(THIS.this_cStatus))
            loc_cWhere = loc_cWhere + "a.pStatus = " + EscaparSQL(ALLTRIM(THIS.this_cStatus)) + " And "
        ENDIF

        RETURN loc_cWhere
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSQLConsulta - Monta a consulta completa, transcrita da variavel
    * lcQuery do metodo consulta.Click do legado (join SigMvCab + SigCdOpe).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSQLConsulta()
        LOCAL loc_cWhereEmpresa

        loc_cWhereEmpresa = "(a.Emps = " + EscaparSQL(ALLTRIM(THIS.this_cCodigoEmpresa))
        IF THIS.this_lEmpresaDestino
            loc_cWhereEmpresa = loc_cWhereEmpresa + " Or a.Empds = " + EscaparSQL(ALLTRIM(THIS.this_cCodigoEmpresa))
        ENDIF
        loc_cWhereEmpresa = loc_cWhereEmpresa + ") And "

        RETURN "SELECT a.* FROM SigMvCab a, SigCdOpe b WHERE " + ;
            loc_cWhereEmpresa + THIS.MontarWhereConsulta() + "a.Dopes = b.Dopes"
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarMovimentacao - Executa a consulta de posicao por movimentacao.
    * Equivalente ao metodo consulta.Click do legado (sem a parte de UI:
    * SetFocus/MessageBox/Do Form sigpres2 ficam por conta do Form).
    * Popula THIS.this_cCursorResultado (cursor_4c_Movimentacao) e
    * THIS.this_nTotalRegistros. Retorna .F. so quando a consulta falha -
    * zero registros encontrados NAO eh erro, eh resultado valido.
    *--------------------------------------------------------------------------
    FUNCTION BuscarMovimentacao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        THIS.this_cMensagemErro  = ""
        THIS.this_nTotalRegistros = 0
        loc_lSucesso = .F.

        IF !THIS.ValidarFiltros()
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = THIS.MontarSQLConsulta()

            IF USED("cursor_4c_SigPrEs1Tmp")
                USE IN cursor_4c_SigPrEs1Tmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrEs1Tmp")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL()
            ELSE
                IF USED("cursor_4c_Movimentacao")
                    USE IN cursor_4c_Movimentacao
                ENDIF

                SELECT * FROM cursor_4c_SigPrEs1Tmp INTO CURSOR cursor_4c_Movimentacao READWRITE

                IF USED("cursor_4c_SigPrEs1Tmp")
                    USE IN cursor_4c_SigPrEs1Tmp
                ENDIF

                SELECT cursor_4c_Movimentacao
                INDEX ON EmpDopNums TAG EmpDopNums

                REPLACE ALL PrazoEnts WITH CTOD("") FOR ISNULL(PrazoEnts)

                *-- Legado: Go Top In csTemporario, e so depois If (Reccount() > 0)
                GO TOP

                THIS.this_nTotalRegistros = RECCOUNT("cursor_4c_Movimentacao")

                *-- Deixa a 1a linha ja carregada nas propriedades this_*Reg*
                *-- (e limpa quando a consulta nao trouxe nada, para nao herdar
                *-- a linha da consulta anterior).
                IF THIS.this_nTotalRegistros > 0
                    THIS.CarregarDoCursor("cursor_4c_Movimentacao")
                ELSE
                    THIS.LimparLinhaCorrente()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparLinhaCorrente - zera as propriedades da linha corrente do cursor
    * de resultado. Chamado no Init e sempre que a consulta devolve zero linhas,
    * para que uma consulta nova nunca herde a linha da consulta anterior.
    *--------------------------------------------------------------------------
    PROCEDURE LimparLinhaCorrente()
        THIS.this_cRegEmpresa      = ""
        THIS.this_cRegEmpresaDest  = ""
        THIS.this_cRegOperacao     = ""
        THIS.this_dRegData         = {/:}
        THIS.this_dRegPrazoEntrega = {/:}
        THIS.this_cRegGrupoOrigem  = ""
        THIS.this_cRegGrupoDestino = ""
        THIS.this_cRegContaOrigem  = ""
        THIS.this_cRegContaDestino = ""
        THIS.this_nRegNumeroOp     = 0
        THIS.this_nRegNumero       = 0
        THIS.this_cRegVendedor     = ""
        THIS.this_lRegBaixada      = .F.
        THIS.this_cRegStatus       = ""
        THIS.this_cRegChave        = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LerCampoCursor - le um campo do cursor corrente pelo NOME, devolvendo o
    * valor padrao quando o campo nao existe ou vem NULL.
    *
    * EVALUATE eh o caminho CERTO para LEITURA por nome (regra #15); e a
    * existencia do campo se testa com TYPE(alias + "." + campo), NUNCA com
    * PEMSTATUS - PEMSTATUS exige objeto no 1o argumento e dispara erro 11 com
    * alias de cursor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LerCampoCursor(par_cAlias, par_cCampo, par_uPadrao)
        LOCAL loc_uValor

        loc_uValor = par_uPadrao

        IF TYPE(par_cAlias + "." + par_cCampo) != "U"
            loc_uValor = TratarNulo(EVALUATE(par_cAlias + "." + par_cCampo), par_uPadrao)
        ENDIF

        RETURN loc_uValor
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveEmpDopNums - monta a chave composta EmpDopNums de SigMvCab.
    *
    * Legado (mesma montagem usada em todo o sistema Fortyus):
    *   lcEmpDopNums = <cursor>.Emps + <cursor>.Dopes + Str(<cursor>.Numes, 6)
    *
    * A chave eh POSICIONAL: o padding faz parte dela. Por isso as partes vao
    * com PADR na largura EXATA da coluna do schema, NUNCA com ALLTRIM - a
    * conferencia eh a largura do destino:
    *   emps char(3) + dopes char(20) + Str(numes, 6) = 29 = empdopnums char(29)
    * Com ALLTRIM nas partes a chave encurta, o WHERE nunca casa e o SELECT
    * devolve ZERO linhas em silencio (regra #42 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(NVL(par_cEmps, ""), 3) + ;
               PADR(NVL(par_cDopes, ""), 20) + ;
               STR(NVL(par_nNumes, 0), 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - carrega a linha CORRENTE do cursor de resultado nas
    * propriedades this_cReg* / this_nReg* / this_dReg* / this_lReg*.
    *
    * Sao as colunas de SigMvCab que o legado nomeia no consulta.Click; o
    * cursor vem de "Select a.* From SigMvCab a, SigCdOpe b", logo todas estao
    * presentes. NAO move o ponteiro do cursor: quem posiciona eh o chamador
    * (BuscarMovimentacao faz GO TOP, como o "Go Top In csTemporario" legado).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_lSucesso, loc_uChave, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.this_cCursorResultado)

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + "o est" + CHR(225) + " aberto."
            THIS.LimparLinhaCorrente()
            RETURN .F.
        ENDIF

        IF EOF(loc_cAlias)
            THIS.LimparLinhaCorrente()
            RETURN .F.
        ENDIF

        TRY
            *-- Padrao obrigatorio: SELECT (alias) ANTES de acessar campos
            SELECT (loc_cAlias)

            THIS.this_cRegEmpresa      = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "emps", ""))
            THIS.this_cRegEmpresaDest  = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "empds", ""))
            THIS.this_cRegOperacao     = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "dopes", ""))
            THIS.this_dRegData         = THIS.LerCampoCursor(loc_cAlias, "datas", {/:})
            THIS.this_dRegPrazoEntrega = THIS.LerCampoCursor(loc_cAlias, "prazoents", {/:})
            THIS.this_cRegGrupoOrigem  = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "grupoos", ""))
            THIS.this_cRegGrupoDestino = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "grupods", ""))
            THIS.this_cRegContaOrigem  = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "contaos", ""))
            THIS.this_cRegContaDestino = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "contads", ""))
            THIS.this_nRegNumeroOp     = THIS.LerCampoCursor(loc_cAlias, "nops", 0)
            THIS.this_nRegNumero       = THIS.LerCampoCursor(loc_cAlias, "numes", 0)
            THIS.this_cRegVendedor     = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "vends", ""))
            THIS.this_cRegStatus       = ALLTRIM(THIS.LerCampoCursor(loc_cAlias, "pstatus", ""))

            *-- chksubn eh bit: chega como Logico (.T./.F.) ou Numerico (0/1)
            *-- conforme o driver ODBC - ConverterParaLogico trata os dois.
            THIS.this_lRegBaixada = ConverterParaLogico(THIS.LerCampoCursor(loc_cAlias, "chksubn", .F.))

            *-- empdopnums vem gravada na tabela; so remontamos quando vier em
            *-- branco, para nunca divergir do valor real do banco.
            loc_uChave = THIS.LerCampoCursor(loc_cAlias, "empdopnums", "")
            IF EMPTY(loc_uChave)
                loc_uChave = THIS.MontarChaveEmpDopNums(THIS.this_cRegEmpresa, ;
                                                        THIS.this_cRegOperacao, ;
                                                        THIS.this_nRegNumero)
            ENDIF
            THIS.this_cRegChave = loc_uChave

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - chave do registro corrente para a auditoria de
    * BusinessBase e para o handoff da linha selecionada. A chave de SigMvCab
    * eh a composta EmpDopNums (char(29)).
    *
    * PROTECTED porque o metodo da base tambem eh PROTECTED - subclasse nao
    * alarga escopo de hook herdado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave

        loc_cChave = THIS.this_cRegChave

        IF EMPTY(loc_cChave)
            loc_cChave = THIS.MontarChaveEmpDopNums(THIS.this_cRegEmpresa, ;
                                                    THIS.this_cRegOperacao, ;
                                                    THIS.this_nRegNumero)
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * DESTROY - libera o cursor de resultado da consulta
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Movimentacao")
            USE IN cursor_4c_Movimentacao
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

