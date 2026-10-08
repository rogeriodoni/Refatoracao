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
[2026-10-07 08:09:27] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-07 08:09:27] [INFO] Config FPW: (nao fornecido)
[2026-10-07 08:09:27] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-07 08:09:27] [INFO] Timeout: 300 segundos
[2026-10-07 08:09:27] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y21jq2t4.prg
[2026-10-07 08:09:27] [INFO] Conteudo do wrapper:
[2026-10-07 08:09:27] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrIbb', 'C:\4c\tasks\task622\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrIbb', 'C:\4c\tasks\task622\logs\06_testForm.log'
QUIT

[2026-10-07 08:09:27] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y21jq2t4.prg
[2026-10-07 08:09:27] [INFO] VFP output esperado em: C:\4c\tasks\task622\vfp_output.txt
[2026-10-07 08:09:27] [INFO] Executando Visual FoxPro 9...
[2026-10-07 08:09:27] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y21jq2t4.prg
[2026-10-07 08:09:27] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y21jq2t4.prg
[2026-10-07 08:09:27] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrIbb
Inicio: 07/10/2026 08:09:27

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 07/10/2026 08:12:38
Duracao: 191 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-07 08:12:38] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-07 08:12:38] [INFO] VFP9 finalizado em 191.0751289 segundos
[2026-10-07 08:12:38] [INFO] Exit Code: 
[2026-10-07 08:12:38] [INFO] 
[2026-10-07 08:12:38] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-07 08:12:38] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y21jq2t4.prg
[2026-10-07 08:12:38] [INFO] 
[2026-10-07 08:12:38] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-07 08:12:38] [INFO] * Auto-generated wrapper for parameters
[2026-10-07 08:12:38] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-07 08:12:38] [INFO] * Parameters: 'FormSigPrIbb', 'C:\4c\tasks\task622\logs\06_testForm.log'
[2026-10-07 08:12:38] [INFO] 
[2026-10-07 08:12:38] [INFO] * Anti-dialog protections for unattended execution
[2026-10-07 08:12:38] [INFO] SET SAFETY OFF
[2026-10-07 08:12:38] [INFO] SET RESOURCE OFF
[2026-10-07 08:12:38] [INFO] SET TALK OFF
[2026-10-07 08:12:38] [INFO] SET NOTIFY OFF
[2026-10-07 08:12:38] [INFO] SYS(2335, 0)
[2026-10-07 08:12:38] [INFO] 
[2026-10-07 08:12:38] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrIbb', 'C:\4c\tasks\task622\logs\06_testForm.log'
[2026-10-07 08:12:38] [INFO] QUIT
[2026-10-07 08:12:38] [INFO] 
[2026-10-07 08:12:38] [INFO] === Fim do Wrapper.prg ===
[2026-10-07 08:12:38] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrIbb.prg):
*==============================================================================
* FormSigPrIbb.prg - Impressao de Boleto Bancario
*==============================================================================
* Herda de: FormBase
* BO: SigPrIbbBO
* Legado: SIGPRIBB.SCX (tasks/task622/SigPrIbb_form_codigo_fonte.txt)
* Tipo: OPERACIONAL (form PLANO sem PageFrame - todos os objetos do dump sao
*       filhos diretos de SIGPRIBB ou de cntSombra, sem Pagina.Lista/Dados)
*
* Tela de impressao aberta com a chave de negocio do documento de
* movimentacao ja resolvida pelo chamador - equivalente ao
* "Parameters pEdn, pFrm" do Init legado (pEdn = EmpDopNums do documento;
* pFrm nunca eh lido em lugar nenhum do dump - mantido aqui so para paridade
* de assinatura). O usuario ve a grade de condicoes de pagamento
* boleto-habilitadas do documento (crGrade/SigMvPar), pode editar o local de
* pagamento e o texto de responsabilidade do cedente da parcela selecionada,
* e imprime o boleto via SigPrIbbBO.ImprimirBoleto().
*
* DataSession = 2 (privada) - diferente de FormSigPrGst/FormSigPrHpr, que
* dependem de cursores jah abertos por um form pai em sessao compartilhada:
* aqui o UNICO dado de entrada eh a chave EmpDopNums recebida por parametro,
* e todos os cursores (crGrade/crDados/TmpImprime no legado) sao criados
* pelo proprio SigPrIbbBO a partir dela - ver CLAUDE.md regra #9.4
* (FormBase.Init() ja compensa SET DATE/CENTURY para DataSession=2).
*
* Montagem (migracao multi-fase):
*   Fase 3 (feita)  - DEFINE CLASS, Init/Destroy/InicializarForm, cabecalho
*                     cnt_4c_Sombra, TornarControlesVisiveis.
*   Fase 4          - grd_4c_Dados (Column1..4 ReadOnly, bind a
*                     cursor_4c_Dados via SigPrIbbBO.CarregarParcelas),
*                     txt_4c_Emps/txt_4c_Dopes/txt_4c_Numes (Enabled=.F.,
*                     espelham EmpDopNums partido), obj_4c_GetLocals/
*                     obj_4c_GetTxtCds (EditBox editaveis da parcela
*                     corrente), txt_4c_Total (Enabled=.F.), Label3/Label31,
*                     shp_4c_Shape1, cmd_4c_Ok/cmd_4c_BtnImprimir.
*   Fase 5 (feita)  - ConfigurarOrdemTabulacao(): TabIndex dos 9 controles
*                     focalizaveis, transcrito do SCX (o migrador havia
*                     descartado e a ordem saia da ordem de criacao dos
*                     AddObject - ver o metodo para a tabela SCX x criacao).
*   Fase 6 (feita)  - campos restantes = os DOIS unicos digitaveis da tela
*                     (obj_4c_GetLocals/obj_4c_GetTxtCds; todo o resto eh
*                     Enabled=.F. ou ReadOnly=.T. no dump): .MaxLength=100 em
*                     GetLocals (SigCnFBl.clocals CHAR(100) NOT NULL - regra
*                     #19) e os handlers ValidarLocalPagamento/
*                     ValidarTextoCedente ligados por BINDEVENT em LostFocus,
*                     que ajustam o valor a largura da coluna destino e
*                     propagam a edicao para as propriedades *Atual do BO
*                     (SincronizarCampoParcela/SincronizarBOComTela). LOOKUPS:
*                     NAO EXISTEM neste legado - o dump nao tem fwBuscaExt/
*                     fwBuscaSel/fwBuscaInt/mAddColuna/sigacess/Acesso*; os
*                     tres fwget (getEmps/getDopes/getNumes) sao Enabled=.F. e
*                     recebem partes de EmpDopNums vindas do chamador, sem
*                     nenhuma tabela auxiliar a consultar. Inventar um lookup
*                     aqui violaria o PILAR 1.
*                     Alem disso: GridDadosAfterRowColChange (equivalente ao
*                     grdItens.AfterRowColChange do legado: Select crGrade +
*                     Refresh em cascata - aqui alimentado por
*                     SigPrIbbBO.CarregarDoCursor(), que o legado dispensa
*                     porque crGrade/getLocals/getTxtCds sao ligados DIRETO
*                     por ControlSource); BtnImprimirClick (equivalente a
*                     btnImprimir.Click: confirmacao + ThisForm.Imprimir) e
*                     THIS.Imprimir() (encadeia SigPrIbbBO.ImprimirBoleto());
*                     BtnEncerrarClick (equivalente a ok.Click: ThisForm.Release).
*   Fase 7 (feita)  - eventos principais; ver Fase 8 para o veredito sobre CRUD.
*   Fase 8 (esta)   - consolidacao final. DUAS mudancas, nenhuma cosmetica:
*                     (a) os dois handlers de botao passaram a se chamar pela
*                     ACAO que executam - BtnImprimirClick (era
*                     "CmdBtnImprimirClick", que carregava o NOME DO OBJETO
*                     legado "btnImprimir" dentro do nome do metodo, com o
*                     "Btn" no meio) e BtnEncerrarClick (era "CmdOkClick", do
*                     objeto "ok", cujo Caption no SCX eh justamente
*                     "Encerrar"). O verbo do handler tem de ser o verbo da
*                     acao, nao o nome do objeto do legado;
*                     (b) SigPrIbbBO.AtualizarConfiguracaoBoleto() ganhou o
*                     Commit que o legado faz logo depois do UPDATE em
*                     SigCnFBl - ver o comentario do metodo no BO: sem ele a
*                     edicao do local de pagamento / texto do cedente ficava
*                     presa numa transacao manual aberta e sumia em silencio.
*                     Revisao do escopo: o dump do legado (SigPrIbb_form_codigo_
*                     fonte.txt, SECAO 3/4 - "Total de metodos/eventos com
*                     codigo: 10") tem SOMENTE: Init/Load/Release/Detalhe/
*                     Imprimir/MontaGrades/SelecionaDados (metodos do form),
*                     ok.Click e btnImprimir.Click (os DOIS UNICOS botoes -
*                     CommandButton standalone, sem CommandGroup) e
*                     grdItens.AfterRowColChange. NAO EXISTE Incluir/Alterar/
*                     Visualizar/Excluir em lugar nenhum do dump - nem
*                     frmcadastro, nem Grupo_Op, nem pcEscolha: eh tela de
*                     IMPRESSAO (Encerrar + Imprimir), nao cadastro. Os 10
*                     metodos do legado ja tem equivalente 1-para-1 no
*                     migrado (BtnEncerrarClick/BtnImprimirClick/
*                     GridDadosAfterRowColChange/Imprimir() aqui;
*                     CarregarParcelas/CarregarDoCursor/CarregarDadosDocumento/
*                     AtualizarConfiguracaoBoleto/CarregarConfiguracaoLayout/
*                     MontarLayoutImpressao/ExecutarImpressaoMatricial/
*                     ImprimirBoleto no SigPrIbbBO). Adicionar
*                     BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
*                     BtnExcluirClick aqui seria inventar funcionalidade
*                     inexistente no legado (viola o PILAR 1 e a proibicao de
*                     stubs do CLAUDE.md) - mesmo padrao de "legado sem CRUD"
*                     ja identificado em SigPrGst/SigPrHpr/SigPrGmi/SigPrGlx.
*
* Nomes de objeto conforme tasks/task622/mapeamento.json.
*==============================================================================

DEFINE CLASS FormSigPrIbb AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades do form (SIGPRIBB.SCX: DataSession=2, BorderStyle=2,
    * Height=700, Width=1000, ShowTips=.T., AutoCenter=.T., ControlBox=.F.,
    * MaxButton=.F., MinButton=.F., Movable=.F., TitleBar=0, WindowType=1 -
    * dump de SigPrIbb_form_codigo_fonte.txt, linhas 159-176)
    *--------------------------------------------------------------------------
    DataSession  = 2
    Width        = 1000
    Height       = 700
    AutoCenter   = .T.
    ShowTips     = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Movable      = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    Caption = "Impress" + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio"

    *--------------------------------------------------------------------------
    * Chave de negocio recebida na abertura - equivalente a ThisForm.EmpDopNum
    * do legado (Substr(.EmpDopNum,1,3)/(4,20)/(24,6) alimentam
    * getEmps/getDopes/getNumes). Repassada a SigPrIbbBO.CarregarParcelas()
    * na Fase 4.
    *--------------------------------------------------------------------------
    this_cEmpDopNum = SPACE(29)

    *--------------------------------------------------------------------------
    * Form chamador - equivalente ao parametro "pFrm" do Init legado. Nenhum
    * metodo do dump le este parametro de volta (so pEdn eh usado); mantido
    * apenas para paridade de assinatura com o legado.
    *--------------------------------------------------------------------------
    this_oFormPai = .NULL.

    *--------------------------------------------------------------------------
    * Guarda de reentrancia dos handlers de LostFocus dos dois EditBox
    * editaveis (obj_4c_GetLocals/obj_4c_GetTxtCds). LostFocus dispara
    * SEMPRE que o foco sai do controle - inclusive por SetFocus disparado de
    * dentro do proprio handler - e o CLAUDE.md adverte explicitamente contra
    * a recursao infinita que isso causa. Ligada na entrada e liberada DEPOIS
    * do ENDTRY, para valer tambem quando o CATCH dispara.
    *--------------------------------------------------------------------------
    this_lSincronizandoParcela = .F.

    *--------------------------------------------------------------------------
    * Init - recebe a chave de negocio do documento e o form chamador
    * (equivalente a "Parameters pEdn, pFrm" do legado) e cria o Business
    * Object ANTES do DODEFAULT(), para que InicializarForm() (chamado por
    * FormBase.Init() via DODEFAULT) ja o encontre pronto.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_cEmpDopNum, par_oFormPai
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrIbbBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF PCOUNT() >= 1 AND VARTYPE(par_cEmpDopNum) = "C"
                    THIS.this_cEmpDopNum = PADR(par_cEmpDopNum, 29)
                ENDIF

                IF PCOUNT() >= 2 AND VARTYPE(par_oFormPai) = "O"
                    THIS.this_oFormPai = par_oFormPai
                ENDIF

                loc_lSucesso = DODEFAULT()
            ELSE
                MsgErro("Falha ao criar SigPrIbbBO.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Impress" + CHR(227) + "o de Boleto Banc" + ;
                CHR(225) + "rio: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - encadeia direto para FormBase.Destroy() (libera
    * this_oBusinessObject e restaura o menu principal). this_oFormPai NAO
    * eh liberado aqui - pertence a quem o criou.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - monta a tela via ConfigurarPageFrame(): fundo e
    * cabecalho nesta fase; grade/campos/botoes nas fases seguintes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cPicture
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("SigPrIbbBO n" + CHR(227) + "o foi inicializado.", "Erro")
            ELSE
                loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
                IF FILE(loc_cPicture)
                    THIS.Picture = loc_cPicture
                ENDIF

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                *-- Mesmo guard usado em FormSigPrGlx/FormSigPrGst/FormSigPrHpr:
                *-- em modo de teste de UI (sem gnConnHandle/sem conexao real)
                *-- pular a carga evita o dialogo "Favor reinicializar o
                *-- processo" num contexto sem SQL.
                IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                     (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
                    THIS.CarregarDados()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrIbb.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRIBB nao tem
    * PageFrame no legado (layout flat: cntSombra + Shape1 + grid + campos +
    * 2 botoes no proprio form) - o nome do metodo eh mantido apenas como
    * ponto de entrada arquitetural padrao (mesmo papel em
    * FormSigPrGst/FormSigPrGmi/FormSigPrGlp).
    *
    * Fase 3 (feita) - ConfigurarCabecalho() (cnt_4c_Sombra).
    * Fase 4          - grd_4c_Dados (4 colunas ReadOnly, bind a
    *                    cursor_4c_Dados via SigPrIbbBO.CarregarParcelas),
    *                    txt_4c_Emps/txt_4c_Dopes/txt_4c_Numes (Enabled=.F.,
    *                    partes de this_cEmpDopNum), obj_4c_GetLocals/
    *                    obj_4c_GetTxtCds (EditBox editaveis, parcela
    *                    corrente), txt_4c_Total (Enabled=.F.), Label3/
    *                    Label31, shp_4c_Shape1 decorativo, cmd_4c_Ok/
    *                    cmd_4c_BtnImprimir.
    * Fase 5 (feita)  - ConfigurarOrdemTabulacao() ao FIM da montagem:
    *                    TabIndex transcrito do SCX para os 9 controles que
    *                    param o Tab (os dois botoes estavam INVERTIDOS).
    * Fase 6 (feita)  - BINDEVENT de grd_4c_Dados.AfterRowColChange (delega a
    *                    SigPrIbbBO.CarregarDoCursor() e espelha o resultado
    *                    em obj_4c_GetLocals/obj_4c_GetTxtCds - equivalente a
    *                    grdItens.AfterRowColChange do legado) e dos dois
    *                    botoes (cmd_4c_BtnImprimir confirma e chama
    *                    SigPrIbbBO.ImprimirBoleto() via THIS.Imprimir();
    *                    cmd_4c_Ok chama THIS.Release()). CarregarDados()
    *                    dispara a primeira sincronizacao (equivalente ao
    *                    Column1.Setfocus do Init legado, que no legado ja
    *                    bastava por causa do ControlSource direto).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarShape()
        THIS.ConfigurarCamposChave()
        THIS.ConfigurarGrid()
        THIS.ConfigurarCamposParcela()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarOrdemTabulacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo do form.
    * Original (dump legado): cntSombra Top=0, Left=0, Width=1008, Height=80,
    * BackColor=RGB(100,100,100) - Width usa THIS.Width (canonico do
    * projeto) em vez do literal 1008 do dump (que extrapola o Width=1000
    * do proprio form).
    *--------------------------------------------------------------------------
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
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = 769
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = 769
                .ForeColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarShape - Shape1 do dump legado, decorativo: BackStyle=0 +
    * BorderStyle=0 nao preenchem nem desenham borda (shape sem efeito
    * visivel). Mantido so por fidelidade de transcricao (PILAR 1) - Shape
    * NAO tem ForeColor (CLAUDE.md regra #33); a cor usada no dump eh
    * BorderColor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarShape()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 9
                .Left        = 820
                .Height      = 110
                .Width       = 173
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarShape")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposChave - getEmps/getDopes/getNumes do legado: tres
    * TextBox Enabled=.F. que exibem (sem permitir edicao) as tres partes de
    * THIS.this_cEmpDopNum (Substr 1-3/4-23/24-29 - equivalente a
    * .getEmps.Value=Substr(.EmpDopNum,1,3) etc. do Init legado). Como
    * this_cEmpDopNum ja foi resolvido em Init() ANTES de DODEFAULT() chamar
    * InicializarForm(), o .Value pode ser atribuido aqui mesmo, na criacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposChave()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("txt_4c_Emps", "TextBox")
            WITH THIS.txt_4c_Emps
                .FontName          = "Tahoma"
                .FontSize          = 11
                .BorderStyle       = 1
                .Enabled           = .F.
                .Height            = 27
                .Left              = 7
                .SpecialEffect     = 1
                .Top               = 101
                .Width             = 44
                .ForeColor         = RGB(0, 0, 0)
                .BackColor         = RGB(245, 251, 136)
                .DisabledBackColor = RGB(245, 251, 136)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value             = SUBSTR(THIS.this_cEmpDopNum, 01, 03)
                .Visible           = .T.
                .MaxLength   = 3
            ENDWITH

            THIS.AddObject("txt_4c_Dopes", "TextBox")
            WITH THIS.txt_4c_Dopes
                .FontName          = "Tahoma"
                .FontSize          = 11
                .BorderStyle       = 1
                .Enabled           = .F.
                .Height            = 27
                .Left              = 57
                .SpecialEffect     = 1
                .Top               = 101
                .Width             = 288
                .ForeColor         = RGB(0, 0, 0)
                .BackColor         = RGB(245, 251, 136)
                .DisabledBackColor = RGB(245, 251, 136)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value             = SUBSTR(THIS.this_cEmpDopNum, 04, 20)
                .Visible           = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Numes", "TextBox")
            WITH THIS.txt_4c_Numes
                .FontName          = "Tahoma"
                .FontSize          = 11
                .BorderStyle       = 1
                .Enabled           = .F.
                .Height            = 27
                .Left              = 352
                .SpecialEffect     = 1
                .Top               = 101
                .Width             = 80
                .ForeColor         = RGB(0, 0, 0)
                .BackColor         = RGB(245, 251, 136)
                .DisabledBackColor = RGB(245, 251, 136)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value             = SUBSTR(THIS.this_cEmpDopNum, 24, 06)
                .Visible           = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposChave")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - grd_4c_Dados (grdItens no legado): so a geometria e as
    * propriedades que NAO dependem do cursor. RecordSource/ControlSource de
    * cada Column ficam em CarregarDados, chamado DEPOIS que
    * SigPrIbbBO.CarregarParcelas() cria cursor_4c_Dados (CLAUDE.md regra
    * #41 - Column.ControlSource antes do cursor existir derruba o Init).
    * ColumnCount=4 e o ReadOnly geral (grdItens.ReadOnly=.T. no dump) sao
    * fixados aqui; o ReadOnly de cada Column (regra #18 - tem de vir DEPOIS
    * do Grid) e o restante de cada coluna ficam em CarregarDados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top               = 138
                .Left              = 7
                .Width             = 425
                .Height            = 520
                .FontName          = "Tahoma"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .HeaderHeight      = 22
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .ReadOnly          = .T.
                .ColumnCount       = 4
                .Visible           = .T.
            ENDWITH

            *-- grdItens.AfterRowColChange do legado (LParameters nColIndex) -
            *-- handler PUBLIC (CLAUDE.md regra #3), declarando o parametro
            *-- do evento.
            BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GridDadosAfterRowColChange")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposParcela - Label3/Label31 ("Local de Pagamento "/"Texto
    * de Responsabilidade do Cedente ") e os EditBox obj_4c_GetLocals/
    * obj_4c_GetTxtCds (getLocals/getTxtCds no legado - EDITAVEIS, ligados a
    * crGrade.CLocals/CTxtCds, a linha corrente da grade) + txt_4c_Total
    * (getTotal, Enabled=.F., soma das parcelas). ControlSource dos dois
    * EditBox e o .Value de txt_4c_Total ficam em CarregarDados - dependem do
    * cursor (mesma regra #41 de ConfigurarGrid).
    *
    * AutoSize=.T. do dump eh NO-OP em Label criado por AddObject (CLAUDE.md
    * regra #23) - .AutoSize=.F. aqui com Width/Height explicitos reproduz
    * os numeros que o Form Designer legado ja tinha calculado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposParcela()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Local de Pagamento "
                .Left      = 444
                .Top       = 211
                .Width     = 119
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("obj_4c_GetLocals", "EditBox")
            WITH THIS.obj_4c_GetLocals
                .FontName      = "Tahoma"
                .BorderStyle   = 1
                .SpecialEffect = 1
                .Top           = 228
                .Left          = 444
                .Width         = 548
                .Height        = 201
                *-- MaxLength vem da LARGURA DA COLUNA no schema, nunca do
                *-- Width em pixels (CLAUDE.md regra #19): o valor digitado
                *-- aqui vai para SigCnFBl.clocals CHAR(100) NOT NULL, no
                *-- UPDATE de SigPrIbbBO.AtualizarConfiguracaoBoleto(). Sem o
                *-- limite, o excedente seria cortado EM SILENCIO pelo
                *-- ControlSource (cursor_4c_Dados.CLocals eh C(100)) e o
                *-- usuario nao perceberia a perda.
                .MaxLength     = 100
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label31", "Label")
            WITH THIS.lbl_4c_Label31
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Texto de Responsabilidade do Cedente "
                .Left      = 444
                .Top       = 438
                .Width     = 224
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("obj_4c_GetTxtCds", "EditBox")
            WITH THIS.obj_4c_GetTxtCds
                .FontName      = "Tahoma"
                .BorderStyle   = 1
                .SpecialEffect = 1
                .Top           = 455
                .Left          = 444
                .Width         = 548
                .Height        = 201
                *-- SEM MaxLength de proposito: SigCnFBl.ctxtcds eh TEXT
                *-- (memo), sem limite de largura - e cursor_4c_Dados.CTxtCds
                *-- eh M, igual ao crGrade.CTxtCds m(4) do Load legado.
                *-- Limitar aqui cortaria texto que o banco aceita.
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Total", "TextBox")
            WITH THIS.txt_4c_Total
                .FontName          = "Tahoma"
                .BorderStyle       = 1
                .Enabled           = .F.
                .SpecialEffect     = 1
                .Top               = 657
                .Left              = 262
                .Width             = 150
                .Height            = 23
                .ForeColor         = RGB(0, 0, 0)
                .BackColor         = RGB(255, 255, 255)
                .DisabledBackColor = RGB(224, 253, 254)
                .Value             = 0
                .Visible           = .T.
            ENDWITH

            *-- Os DOIS unicos controles digitaveis da tela (todo o resto eh
            *-- Enabled=.F. ou ReadOnly=.T. no dump). No legado eles sao
            *-- ligados DIRETO por ControlSource a crGrade.CLocals/CTxtCds e
            *-- "Procedure imprimir" le crGrade.* na hora de gravar/imprimir -
            *-- ou seja, o que esta na tela ja ERA o que ia para o boleto.
            *-- Aqui SigPrIbbBO.AtualizarConfiguracaoBoleto()/
            *-- CarregarDadosImpressao() leem as propriedades *Atual do BO, e
            *-- por isso a edicao precisa de um ponto explicito de
            *-- sincronizacao - este handler.
            *--
            *-- LostFocus (nao "Valid"): BINDEVENT em "Valid" nao dispara de
            *-- forma confiavel em controle de entrada (CLAUDE.md regra #3 /
            *-- lookups). Eh seguro aqui porque o handler NAO executa SQL,
            *-- NAO remonta grade e NAO chama SetFocus - a recursao que o
            *-- CLAUDE.md adverte fica coberta pela guarda
            *-- this_lSincronizandoParcela.
            BINDEVENT(THIS.obj_4c_GetLocals, "LostFocus", THIS, "ValidarLocalPagamento")
            BINDEVENT(THIS.obj_4c_GetTxtCds, "LostFocus", THIS, "ValidarTextoCedente")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposParcela")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - cmd_4c_Ok/cmd_4c_BtnImprimir (ok/btnImprimir no
    * legado). Standalone CommandButton com .Picture: mantido Themes=.F.
    * (igual ao legado) porque nenhum dos dois eh desabilitado em runtime -
    * a excecao de Themes=.T.+DisabledPicture (CLAUDE.md regra sobre icone-
    * only button) so se aplica quando .Enabled alterna para .F.
    *
    * Click (Release em cmd_4c_Ok; confirmacao + ImprimirBoleto em
    * cmd_4c_BtnImprimir) fica para as Fases 6-8, junto com o
    * AfterRowColChange de grd_4c_Dados - ver cabecalho do arquivo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmd_4c_Ok", "CommandButton")
            WITH THIS.cmd_4c_Ok
                .Top         = 3
                .Left        = 922
                .Height      = 75
                .Width       = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel      = .T.
                .Caption     = "Encerrar"
                .ToolTipText = "[ESC] Sair"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes           = .T.
                .Visible     = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnEncerrarClick")

            THIS.AddObject("cmd_4c_BtnImprimir", "CommandButton")
            WITH THIS.cmd_4c_BtnImprimir
                .Top        = 3
                .Left       = 846
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Picture    = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                .Caption    = "\<Imprimir"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes           = .T.
                .Visible    = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_BtnImprimir, "Click", THIS, "BtnImprimirClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarOrdemTabulacao - transcreve o TabIndex que o SCX legado
    * declara. Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO,
    * que nao tem relacao nenhuma com a ordem do legado: nao ha erro, nao ha
    * log e nao aparece em screenshot - so o Tab andando na ordem errada.
    *
    * TabIndex declarado no dump (SECAO 2 de
    * tasks/task622/SigPrIbb_form_codigo_fonte.txt) contra a ordem de criacao
    * que as Fases 3/4 produziram:
    *
    *   SCX  objeto legado  migrado               criacao
    *    2   getEmps        txt_4c_Emps               3
    *    3   getDopes       txt_4c_Dopes              4
    *    3   getTotal       txt_4c_Total             11   <- empate no SCX
    *    4   getNumes       txt_4c_Numes              5
    *    5   grdItens       grd_4c_Dados              6
    *    6   Label3         lbl_4c_Label3             7   (Label - ver abaixo)
    *    7   getLocals      obj_4c_GetLocals          8
    *    8   Label31        lbl_4c_Label31            9   (Label - ver abaixo)
    *    9   getTxtCds      obj_4c_GetTxtCds         10
    *   10   btnImprimir    cmd_4c_BtnImprimir       13   <- INVERTIDO
    *   11   ok             cmd_4c_Ok                12   <- INVERTIDO
    *
    * A divergencia que DOI eh a dos dois botoes: na ordem de criacao o Tab
    * sai de obj_4c_GetTxtCds (o texto de responsabilidade do cedente, que o
    * usuario acabou de editar) direto para cmd_4c_Ok, que eh .Cancel = .T. -
    * um Enter/Espaco ali FECHA a tela e descarta a edicao. No legado o Tab
    * cai em btnImprimir (10) ANTES de ok (11), que eh a acao pretendida.
    *
    * Numerar SO os focalizaveis: Label tem TabIndex mas NAO tem TabStop
    * (conferido em automation/propriedades_baseclasses.txt - a property nem
    * existe na classe), logo transcrever o TabIndex de lbl_4c_Label3/
    * lbl_4c_Label31 seria inerte e ainda embaralharia a sequencia dos
    * controles que de fato param o Tab. Eles, cnt_4c_Sombra e shp_4c_Shape1
    * ficam nas posicoes seguintes, sem efeito.
    *
    * Atribuicao em ordem ASCENDENTE e com posicoes COMPACTAS (1..9), nao com
    * os numeros literais do SCX: cada atribuicao poe o controle na posicao
    * pedida e EMPURRA os demais para tras, entao reusar os literais (que tem
    * buraco no 1 e empate no 3) deslocaria os seguintes a cada passo. A
    * sequencia resultante eh exatamente a do SCX lido em ordem crescente.
    *
    * O empate do SCX em TabIndex = 3 (getDopes e getTotal) eh impossivel de
    * reproduzir literalmente e eh inerte aqui: os quatro primeiros campos
    * sao Enabled = .F. no legado E no migrado, logo nenhum deles para o Tab
    * e a ordem entre eles nao chega ao usuario. Mantida a leitura literal do
    * dump (getTotal no empate, logo depois de getDopes).
    *
    * Chamado ao FIM de ConfigurarPageFrame, DEPOIS de todos os AddObject -
    * TabIndex eh gravavel em runtime, mas a numeracao automatica da criacao
    * sobrescreveria qualquer atribuicao feita antes do ultimo AddObject.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarOrdemTabulacao()
        LOCAL loc_oErro

        TRY
            THIS.txt_4c_Emps.TabIndex        = 1   && SCX getEmps     TabIndex=2
            THIS.txt_4c_Dopes.TabIndex       = 2   && SCX getDopes    TabIndex=3
            THIS.txt_4c_Total.TabIndex       = 3   && SCX getTotal    TabIndex=3
            THIS.txt_4c_Numes.TabIndex       = 4   && SCX getNumes    TabIndex=4
            THIS.grd_4c_Dados.TabIndex       = 5   && SCX grdItens    TabIndex=5
            THIS.obj_4c_GetLocals.TabIndex   = 6   && SCX getLocals   TabIndex=7
            THIS.obj_4c_GetTxtCds.TabIndex   = 7   && SCX getTxtCds   TabIndex=9
            THIS.cmd_4c_BtnImprimir.TabIndex = 8   && SCX btnImprimir TabIndex=10
            THIS.cmd_4c_Ok.TabIndex          = 9   && SCX ok          TabIndex=11
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarOrdemTabulacao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - equivalente ao bloco final de Init + SelecionaDados() do
    * legado: chama SigPrIbbBO.CarregarParcelas() (cria/popula
    * cursor_4c_Dados a partir de THIS.this_cEmpDopNum) e SO DEPOIS rebinda
    * grd_4c_Dados e os dois EditBox editaveis - CLAUDE.md regra #41
    * (Column.ControlSource antes do cursor existir derruba o Init).
    * Width/Header1.Caption/ReadOnly de cada coluna sao refeitos aqui (nao em
    * ConfigurarGrid) porque trocar RecordSource reseta os tres ("Problema 2"
    * / regra #43.1 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDados()
        LOCAL loc_oGrid, loc_oErro

        TRY
            IF THIS.this_oBusinessObject.CarregarParcelas(THIS.this_cEmpDopNum)
                loc_oGrid = THIS.grd_4c_Dados

                loc_oGrid.RecordSource = ""
                loc_oGrid.ColumnCount  = 4
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.FPags"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Parcs"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Vencs"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Valos"

                WITH loc_oGrid.Column1
                    .FontName  = "Courier New"
                    .FontSize  = 8
                    .Width     = 120
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .BackColor = RGB(245, 251, 136)
                    .Header1.FontName  = "Tahoma"
                    .Header1.FontSize  = 8
                    .Header1.Alignment = 2
                    .Header1.Caption   = "Condi" + CHR(231) + CHR(227) + "o Pagto."
                    .Header1.ForeColor = RGB(90, 90, 90)
                    .Header1.BackColor = RGB(255, 255, 223)
                    .Text1.BorderStyle = 0
                    .Text1.Margin      = 0
                    .Text1.ReadOnly    = .T.
                    .Text1.FontName    = "Courier New"
                    .Text1.FontSize    = 8
                    .Text1.ForeColor   = RGB(0, 0, 0)
                    .Text1.BackColor   = RGB(245, 251, 136)
                ENDWITH

                WITH loc_oGrid.Column2
                    .FontBold  = .T.
                    .FontName  = "Courier New"
                    .FontSize  = 8
                    .Alignment = 2
                    .Width     = 31
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .InputMask = "99"
                    .Header1.FontName  = "Tahoma"
                    .Header1.FontSize  = 8
                    .Header1.Alignment = 2
                    .Header1.Caption   = "X"
                    .Header1.ForeColor = RGB(90, 90, 90)
                    .Header1.BackColor = RGB(255, 255, 223)
                    .Text1.FontBold    = .T.
                    .Text1.Alignment   = 2
                    .Text1.BorderStyle = 0
                    .Text1.Margin      = 0
                    .Text1.ReadOnly    = .T.
                    .Text1.FontName    = "Courier New"
                    .Text1.FontSize    = 8
                    .Text1.ForeColor   = RGB(0, 0, 0)
                    .Text1.BackColor   = RGB(255, 255, 255)
                ENDWITH

                WITH loc_oGrid.Column3
                    .FontName  = "Courier New"
                    .FontSize  = 8
                    .Width     = 100
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .Header1.FontName  = "Tahoma"
                    .Header1.FontSize  = 8
                    .Header1.Alignment = 2
                    .Header1.Caption   = "Vencimento"
                    .Header1.ForeColor = RGB(90, 90, 90)
                    .Header1.BackColor = RGB(255, 255, 223)
                    .Text1.BorderStyle = 0
                    .Text1.Margin      = 0
                    .Text1.FontName    = "Courier New"
                    .Text1.FontSize    = 8
                    .Text1.ForeColor   = RGB(0, 0, 0)
                    .Text1.BackColor   = RGB(255, 255, 255)
                ENDWITH

                WITH loc_oGrid.Column4
                    .FontName  = "Courier New"
                    .FontSize  = 8
                    .Width     = 150
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .InputMask = "9999999.99"
                    .Header1.FontName  = "Tahoma"
                    .Header1.FontSize  = 8
                    .Header1.Alignment = 2
                    .Header1.Caption   = "Valor"
                    .Header1.ForeColor = RGB(90, 90, 90)
                    .Header1.BackColor = RGB(255, 255, 223)
                    .Text1.BorderStyle = 0
                    .Text1.Margin      = 0
                    .Text1.FontName    = "Courier New"
                    .Text1.FontSize    = 8
                    .Text1.ForeColor   = RGB(0, 0, 0)
                    .Text1.BackColor   = RGB(255, 255, 255)
                ENDWITH

                THIS.obj_4c_GetLocals.ControlSource = "cursor_4c_Dados.CLocals"
                THIS.obj_4c_GetTxtCds.ControlSource  = "cursor_4c_Dados.CTxtCds"
                THIS.txt_4c_Total.Value = THIS.this_oBusinessObject.this_nTotalParcelas

                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_oGrid.Refresh()
                THIS.obj_4c_GetLocals.Refresh()
                THIS.obj_4c_GetTxtCds.Refresh()

                *-- Equivalente ao .grdItens.Column1.Setfocus do Init legado:
                *-- no legado o proprio SetFocus/ControlSource direto ja
                *-- bastava para crGrade.FPags/CLocals/CTxtCds aparecerem
                *-- corretos; aqui THIS.this_oBusinessObject.this_cFPagsAtual
                *-- (e demais *Atual, usados por ImprimirBoleto) so existem
                *-- apos CarregarDoCursor - sincronizar com a 1a linha agora
                *-- evita imprimir com a parcela errada quando o usuario
                *-- nunca navega na grade (ex.: so uma condicao de pagamento).
                IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                    THIS.GridDadosAfterRowColChange(1)
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GridDadosAfterRowColChange - equivalente a grdItens.AfterRowColChange
    * do legado (LParameters nColIndex / Select crGrade / This.Refresh /
    * ThisForm.Refresh / ThisForm.getLocals.Refresh / ThisForm.getTxtCds.
    * Refresh). La, crGrade/getLocals/getTxtCds sao ligados DIRETO por
    * ControlSource, entao o Select+Refresh ja bastava para a tela refletir
    * a linha corrente. Aqui, alem do refresh visual, sincroniza as
    * propriedades *Atual do BO (this_cFPagsAtual/this_nParcsAtual/etc, via
    * CarregarDoCursor) - sao elas que SigPrIbbBO.ImprimirBoleto() usa, e sem
    * esta sincronizacao a impressao sairia sempre com os dados da PRIMEIRA
    * linha carregada, mesmo apos o usuario navegar/selecionar outra parcela.
    *
    * PUBLIC (nao PROTECTED) porque esta ligado via BINDEVENT - CLAUDE.md
    * regra #3 - e declara o parametro do evento (par_nColIndex), mesmo sem
    * uso direto aqui (o legado tambem recebe e nao usa nColIndex).
    *--------------------------------------------------------------------------
    PROCEDURE GridDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_Dados")
                THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
            ENDIF

            THIS.grd_4c_Dados.Refresh()
            THIS.Refresh()
            THIS.obj_4c_GetLocals.Refresh()
            THIS.obj_4c_GetTxtCds.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em GridDadosAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - equivalente a SIGPRIBB.ok.Click do legado (ThisForm.
    * Release). PUBLIC por estar ligado via BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - equivalente a SIGPRIBB.btnImprimir.Click do
    * legado: so age com a grade posicionada num registro (Not Eof('crGrade'))
    * e apos confirmacao do usuario (MessageBox(...)==6, aqui MsgConfirma()
    * - CLAUDE.md regra #7, retorna LOGICAL, nunca comparar com numero).
    * PUBLIC por estar ligado via BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lConfirmou, loc_cMsg

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            loc_cMsg = "Confirma a Impress" + CHR(227) + "o do Boleto Banc" + CHR(225) + ;
                "rio da Condi" + CHR(231) + CHR(227) + "o de Pagamento:" + CHR(13) + CHR(13) + ;
                ALLTRIM(cursor_4c_Dados.FPags) + " - Parcela: " + ALLTRIM(STR(cursor_4c_Dados.Parcs, 2))

            loc_lConfirmou = MsgConfirma(loc_cMsg, "Confirmar")

            IF loc_lConfirmou
                THIS.Imprimir()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarLocalPagamento - handler de LostFocus de obj_4c_GetLocals
    * (getLocals no legado, ControlSource = crGrade.CLocals). O campo alimenta
    * SigCnFBl.clocals CHAR(100) NOT NULL (UPDATE em
    * SigPrIbbBO.AtualizarConfiguracaoBoleto) e tambem eh impresso como
    * "Local de Pagamento" do boleto (crDados.CLocals em Procedure imprimir).
    * PUBLIC - exigido para BINDEVENT (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarLocalPagamento()
        THIS.SincronizarCampoParcela(THIS.obj_4c_GetLocals, 100)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTextoCedente - handler de LostFocus de obj_4c_GetTxtCds
    * (getTxtCds no legado, ControlSource = crGrade.CTxtCds). Alimenta
    * SigCnFBl.ctxtcds (TEXT, sem limite de largura - por isso largura 0) e eh
    * impresso como "Texto de Cobranca" (crDados.Texto).
    * PUBLIC - exigido para BINDEVENT (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTextoCedente()
        THIS.SincronizarCampoParcela(THIS.obj_4c_GetTxtCds, 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * SincronizarCampoParcela - corpo comum aos dois handlers acima.
    *
    * par_nLargura = largura da coluna DESTINO no schema (0 = sem limite).
    * O corte eh defensivo: .MaxLength ja impede a digitacao alem do limite,
    * mas valor colado/atribuido por programa passaria direto e seria cortado
    * em silencio mais adiante - aqui o corte acontece com o valor ja visivel
    * de volta no controle, e nunca chega truncado ao UPDATE.
    *
    * Depois do ajuste, propaga o estado da TELA para o BO: o legado lia
    * crGrade.CLocals/CTxtCds direto (ControlSource mantinha cursor e tela
    * iguais), enquanto aqui quem grava e imprime sao as propriedades *Atual.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SincronizarCampoParcela(par_oCampo, par_nLargura)
        LOCAL loc_cValor, loc_oErro

        *-- RETURN de guarda FORA do TRY/CATCH (CLAUDE.md regra #1).
        IF THIS.this_lSincronizandoParcela
            RETURN
        ENDIF

        THIS.this_lSincronizandoParcela = .T.

        TRY
            IF VARTYPE(par_oCampo) = "O" AND VARTYPE(par_oCampo.Value) = "C"
                loc_cValor = par_oCampo.Value

                IF par_nLargura > 0 AND LEN(loc_cValor) > par_nLargura
                    par_oCampo.Value = LEFT(loc_cValor, par_nLargura)
                ENDIF
            ENDIF

            THIS.SincronizarBOComTela()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em SincronizarCampoParcela")
        ENDTRY

        *-- Liberada DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara.
        THIS.this_lSincronizandoParcela = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * SincronizarBOComTela - leva a linha corrente da grade E o conteudo dos
    * dois EditBox editaveis para as propriedades *Atual do BO.
    *
    * CarregarDoCursor() resolve a parcela (FPags/Parcs/Vencs/Datas/Valos) a
    * partir do registro corrente; em seguida this_cLocalPgtoAtual/
    * this_cTextoCedenteAtual sao reafirmados a partir dos CONTROLES, que sao
    * a fonte do que o usuario de fato ve - sem depender do instante em que o
    * ControlSource descarrega o valor editado no cursor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SincronizarBOComTela()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN
        ENDIF

        THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")

        *-- So sobrepoe o valor lido do cursor quando o EditBox esta de fato
        *-- LIGADO a coluna (ControlSource atribuido em CarregarDados). Sem
        *-- esta condicao, um caminho em que a ligacao nao ocorreu - cursor
        *-- populado mas CarregarDados interrompido - faria o ""  do controle
        *-- apagar o valor que CarregarDoCursor acabou de trazer do cursor.
        IF UPPER(ALLTRIM(THIS.obj_4c_GetLocals.ControlSource)) == "CURSOR_4C_DADOS.CLOCALS" AND ;
                VARTYPE(THIS.obj_4c_GetLocals.Value) = "C"
            THIS.this_oBusinessObject.this_cLocalPgtoAtual = THIS.obj_4c_GetLocals.Value
        ENDIF

        IF UPPER(ALLTRIM(THIS.obj_4c_GetTxtCds.ControlSource)) == "CURSOR_4C_DADOS.CTXTCDS" AND ;
                VARTYPE(THIS.obj_4c_GetTxtCds.Value) = "C"
            THIS.this_oBusinessObject.this_cTextoCedenteAtual = THIS.obj_4c_GetTxtCds.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - equivalente a Procedure imprimir() do legado (chamada apos
    * a confirmacao em btnImprimir.Click). Antes de delegar a
    * SigPrIbbBO.ImprimirBoleto(), chama SincronizarBOComTela() - o mesmo
    * ponto de sincronizacao usado pelos handlers de LostFocus dos dois
    * EditBox editaveis. Necessario porque o botao Imprimir pode ser acionado
    * por ENTER/atalho sem que o campo editado tenha perdido o foco, e porque
    * ImprimirBoleto() le as propriedades *Atual do BO, nao o cursor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Imprimir()
        LOCAL loc_oErro

        TRY
            THIS.SincronizarBOComTela()

            IF !THIS.this_oBusinessObject.ImprimirBoleto()
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Imprimir")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
    * padrao; percorre recursivamente Controls (Containers/Grids/Pages de
    * eventuais PageFrames filhos) tornando tudo visivel.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrIbbBO.prg):
*============================================================================
* SigPrIbbBO.prg - Business Object para Impressao de Boleto Bancario (SIGPRIBB)
*
* Form OPERACIONAL (SIGPRIBB / FormSigPrIbb): tela de impressao aberta com a
* chave de negocio do documento de movimentacao ja resolvida pelo chamador
* (equivalente ao par_cEmpDopNum passado ao Init do legado - ver
* tasks/task622/SIGPRIBB_form_codigo_fonte.txt, Procedure Init(pEdn, pFrm)).
* A tela mostra:
*   - grd_4c_Dados (crGrade no legado) com as condicoes de pagamento do
*     documento que tem boleto habilitado (SigMvPar x SigCdOpe x SigOpCdc x
*     SigOpFp, filtrando ImpBols = 1 nos dois lados - operacao e forma de
*     pagamento);
*   - a parcela selecionada na grade, com o texto de local de pagamento e o
*     texto de responsabilidade do cedente (memos da linha corrente);
*   - os dados do cliente/endereco de cobranca usados para montar o layout
*     impresso do boleto (crDados no legado), resolvidos a partir de
*     SigMvCab/SigMvNfi (e do cadastro de cliente) no momento do Imprimir.
*
* NAO existe uma unica "tabela principal" para efeito de Buscar()/
* CarregarDoCursor() (this_cTabela permanece vazio, mesmo padrao adotado em
* SigPrGstBO/SigPrGlxBO/SigPrHprBO): o documento vem de SigMvCab resolvido
* pela chave de negocio EmpDopNums, e as parcelas vem de SigMvPar filtradas
* por essa mesma chave. this_cCampoChave aponta para "empdopnums"
* (SigMvCab.empdopnums / SigMvPar.empdopnums), que eh o campo usado para
* localizar o documento e suas parcelas.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos de dominio (CarregarParcelas,
* CarregarDoCursor, CarregarDadosDocumento, AtualizarConfiguracaoBoleto,
* CarregarConfiguracaoLayout, VerificarImpressoraDisponivel,
* CarregarDadosImpressao, MontarLayoutImpressao, ExecutarImpressaoMatricial,
* ImprimirBoleto, ObterChavePrimaria)
*============================================================================

DEFINE CLASS SigPrIbbBO AS BusinessBase

    *==========================================================================
    * Chave de negocio do documento recebida na abertura (equivalente ao
    * par_cEmpDopNum/pEdn do legado - PADR(pEdn, 29) antes de ser repassado)
    *==========================================================================
    this_cEmpDopNum   = SPACE(29)  && empdopnums CHAR(29) - Emps(3)+Dopes(20)+Numes(6)
    this_cEmps        = SPACE(3)   && emps       CHAR(3)  - Empresa (Substr(EmpDopNum,1,3))
    this_cDopes       = SPACE(20)  && dopes      CHAR(20) - Tipo de Operacao/Documento (Substr(EmpDopNum,4,20))
    this_nNumes       = 0          && numes      NUM(6,0) - Numero sequencial do documento (Substr(EmpDopNum,24,6))

    *==========================================================================
    * Dados do documento de movimentacao (SigMvCab - equivalente a
    * crTprMvCab no legado, resolvido via CursorQuery por EmpDopNums)
    *==========================================================================
    this_cContaOs     = SPACE(10)  && contaos CHAR(10) - Conta de origem do documento
    this_cContaDs     = SPACE(10)  && contads CHAR(10) - Conta de destino do documento

    *==========================================================================
    * Parcela selecionada na grade (equivalente a crGrade na linha ativa -
    * usado por grdItens.AfterRowColChange/btnImprimir.Click do legado)
    *==========================================================================
    this_cFPagsAtual      = SPACE(12)  && crGrade.FPags   (SigMvPar.fpags  CHAR(12)) - Forma de pagamento
    this_nParcsAtual      = 0          && crGrade.Parcs   (SigMvPar.parcs NUM(2,0)) - Numero da parcela
    this_dVencsAtual      = {}         && crGrade.Vencs   (SigMvPar.vencs DATETIME) - Vencimento da parcela
    this_dDatasAtual      = {}         && crGrade.Datas   (SigMvPar.datas DATETIME) - Data de emissao da parcela
    this_nValosAtual      = 0          && crGrade.Valos   (SigMvPar.valos NUM(11,2)) - Valor da parcela
    this_cLocalPgtoAtual  = ""         && crGrade.CLocals (texto livre - local de pagamento da condicao)
    this_cTextoCedenteAtual = ""       && crGrade.CTxtCds (memo - texto de responsabilidade do cedente)

    *==========================================================================
    * Dados para montagem do layout impresso do boleto (equivalente a
    * crDados no legado, populado pelo metodo Imprimir a partir de
    * SigMvCab/SigMvNfi e do cadastro de cliente da movimentacao)
    *==========================================================================
    this_cLocalPgtoImpressao = ""        && crDados.CLocals - Local de pagamento (texto impresso)
    this_cVencimentoImpresso = SPACE(12) && crDados.Vencs   - Vencimento formatado para impressao
    this_dDataDocumento      = {}        && crDados.DatDoc  - Data do documento
    this_cNumeroDocumento    = SPACE(8)  && crDados.NumDoc  - Numero do documento/nota fiscal
    this_nValorImpressao     = 0         && crDados.Valor   - Valor total a imprimir
    this_cRazaoSocial        = ""        && crDados.Razaos  - Razao social/nome do cliente
    this_cCpfCnpj            = SPACE(20) && crDados.Cpfs    - CPF/CNPJ do cliente
    this_cEndereco           = ""        && crDados.EndCobs - Endereco de cobranca
    this_cBairro             = SPACE(20) && crDados.BaiCobs - Bairro de cobranca
    this_cCidade             = SPACE(20) && crDados.CidCobs - Cidade de cobranca
    this_cEstado             = SPACE(2)  && crDados.EstCobs - Estado (UF) de cobranca
    this_cCep                = SPACE(9)  && crDados.CepCobs - CEP de cobranca
    this_cTextoComplementar  = ""        && crDados.Texto   - Texto livre complementar do boleto

    *==========================================================================
    * Total das parcelas boleto-habilitadas da grade (equivalente a
    * ThisForm.getTotal.Value do legado - soma de crGrade.Valos)
    *==========================================================================
    this_nTotalParcelas = 0

    *==========================================================================
    * Forma de pagamento da parcela atual (equivalente a crTmpFpag.ImpNotas -
    * decide, em CarregarDadosImpressao, se o vencimento impresso eh a data
    * (Dtoc(Vencs)) ou a propria condicao de pagamento (FPags))
    *==========================================================================
    this_nImpNotasAtual = 0

    *==========================================================================
    * Configuracao de impressao do boleto (SigCnFBl) para o FPags atual -
    * equivalente a LocalCfgBl no legado. Reusa SIGPRIBLBO (mesma tabela,
    * ja migrada - classes/SIGPRIBLBO.prg/forms/operacionais/FormSIGPRIBL.prg)
    * em vez de duplicar as ~30 propriedades de posicao de impressao.
    *==========================================================================
    this_oConfigBoleto = .NULL.

    *==========================================================================
    * Controle de processamento
    *==========================================================================
    this_lResultadoOk  = .F.   && Resultado da ultima operacao (carga/impressao)

    *==========================================================================
    * Init - Inicializa o Business Object. Nao ha tabela/chave primaria
    * unica para este processo de impressao (o documento vem de SigMvCab e
    * as parcelas vem de SigMvPar, ambos filtrados por EmpDopNums recebido
    * do chamador) - mesmo padrao adotado em SigPrGstBO.Init/SigPrGlxBO.Init/
    * SigPrHprBO.Init. this_cCampoChave fica com "empdopnums", unico campo
    * usado para localizar o documento e suas parcelas.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = "empdopnums"

            THIS.this_cEmpDopNum = SPACE(29)
            THIS.this_cEmps      = SPACE(3)
            THIS.this_cDopes     = SPACE(20)
            THIS.this_nNumes     = 0

            THIS.this_cContaOs   = SPACE(10)
            THIS.this_cContaDs   = SPACE(10)

            THIS.this_cFPagsAtual         = SPACE(12)
            THIS.this_nParcsAtual         = 0
            THIS.this_dVencsAtual         = {}
            THIS.this_dDatasAtual         = {}
            THIS.this_nValosAtual         = 0
            THIS.this_cLocalPgtoAtual     = ""
            THIS.this_cTextoCedenteAtual  = ""

            THIS.this_cLocalPgtoImpressao = ""
            THIS.this_cVencimentoImpresso = SPACE(12)
            THIS.this_dDataDocumento      = {}
            THIS.this_cNumeroDocumento    = SPACE(8)
            THIS.this_nValorImpressao     = 0
            THIS.this_cRazaoSocial        = ""
            THIS.this_cCpfCnpj            = SPACE(20)
            THIS.this_cEndereco           = ""
            THIS.this_cBairro             = SPACE(20)
            THIS.this_cCidade             = SPACE(20)
            THIS.this_cEstado             = SPACE(2)
            THIS.this_cCep                = SPACE(9)
            THIS.this_cTextoComplementar  = ""

            THIS.this_nTotalParcelas  = 0
            THIS.this_nImpNotasAtual  = 0
            THIS.this_oConfigBoleto   = .NULL.

            THIS.this_lResultadoOk = .F.

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inicializar: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - chave usada por RegistrarAuditoria() apos a
    * atualizacao de SigCnFBl (AtualizarConfiguracaoBoleto) - FPags da
    * parcela/condicao de pagamento atual, que eh o campo de negocio usado
    * pelo legado no "Update SigCnFBl ... Where FPags = ...".
    *
    * PROTECTED porque o metodo da base tambem eh PROTECTED - subclasse nao
    * alarga escopo de hook herdado.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cFPagsAtual)
    ENDPROC

    *==========================================================================
    * Inserir()/Atualizar()/ExecutarExclusao() do BusinessBase NAO sao
    * sobrescritos aqui: este form eh uma tela de IMPRESSAO (sem cadastro
    * generico de uma entidade), sem INSERT/UPDATE/DELETE genericos no
    * legado nem fluxo de EditarRegistro()/NovoRegistro() + Salvar(). A
    * UNICA escrita real do legado (dentro de Procedure imprimir) eh o
    * "Update SigCnFBl Set CLocals = ..., CTxtCds = ... Where FPags = ..."
    * feito ANTES de imprimir - tem semantica propria e esta implementado
    * em AtualizarConfiguracaoBoleto(), mais abaixo, que chama
    * RegistrarAuditoria("UPDATE") no sucesso. O comportamento padrao
    * herdado de BusinessBase para Inserir/Atualizar/ExecutarExclusao ja eh
    * o correto para este BO.
    *==========================================================================

    *==========================================================================
    * ExecutarSQL - SQLEXEC preservando a area de trabalho corrente
    * (equivalente a ThisForm.poDataMgr.SqlExecute/CursorQuery do legado, que
    * nao reselecionam a area depois - SQLEXEC() troca a area selecionada).
    *==========================================================================
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor, par_cRotulo)
        LOCAL loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0)

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * CarregarParcelas - equivalente a SelecionaDados() do legado: popula
    * cursor_4c_Dados (crGrade) com as condicoes de pagamento do documento
    * (par_cEmpDopNum) que tem boleto habilitado nos dois lados - operacao
    * (SigOpCdc.ImpBols = 1) e forma de pagamento (SigOpFp.ImpBols = 1) -
    * enriquecidas com o local/texto de cobranca configurados em SigCnFBl
    * (com fallback para a linha de config em branco, FPags = Space(12),
    * igual ao legado). Deixa o cursor posicionado no PRIMEIRO registro
    * (Go Top legado) e THIS.this_nTotalParcelas com a soma de Valos.
    *==========================================================================
    FUNCTION CarregarParcelas(par_cEmpDopNum)
        LOCAL loc_lResultado, loc_cSQL, loc_nTotal, loc_oErro

        loc_lResultado = .F.
        loc_nTotal     = 0

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        THIS.this_cEmpDopNum = PADR(TratarNulo(par_cEmpDopNum, ""), 29)
        THIS.this_cEmps      = SUBSTR(THIS.this_cEmpDopNum, 01, 03)
        THIS.this_cDopes     = SUBSTR(THIS.this_cEmpDopNum, 04, 20)
        THIS.this_nNumes     = VAL(SUBSTR(THIS.this_cEmpDopNum, 24, 06))

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados (FPags C(12), Parcs N(2,0), CLocals C(100), Vencs D, Datas D, Valos N(12,2), CTxtCds M)
            SET NULL OFF

            loc_cSQL = "SELECT b.fpags, b.parcs, b.vencs, b.datas, b.valos " + ;
                "FROM SigMvCab a, SigMvPar b, SigCdOpe c, SigOpCdc d, SigOpFp e " + ;
                "WHERE a.empdopnums = " + EscaparSQL(THIS.this_cEmpDopNum) + " " + ;
                "AND a.empdopnums = b.empdopnums " + ;
                "AND b.dopes = c.dopes " + ;
                "AND c.dopes = d.dopes " + ;
                "AND d.impbols = 1 " + ;
                "AND b.fpags = e.fpags " + ;
                "AND e.impbols = 1 " + ;
                "ORDER BY b.fpags, b.parcs"

            IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Selecao", "Selecao")
                IF USED("cursor_4c_Selecao")
                    SELECT cursor_4c_Selecao
                    SCAN
                        IF !THIS.ExecutarSQL("SELECT clocals, ctxtcds FROM SigCnFBl WHERE fpags = " + ;
                                EscaparSQL(PADR(cursor_4c_Selecao.fpags, 12)), "cursor_4c_CfgBoleto", "ConfigBoleto") ;
                                OR !USED("cursor_4c_CfgBoleto") OR RECCOUNT("cursor_4c_CfgBoleto") = 0
                            THIS.ExecutarSQL("SELECT clocals, ctxtcds FROM SigCnFBl WHERE fpags = " + ;
                                EscaparSQL(SPACE(12)), "cursor_4c_CfgBoleto", "ConfigBoleto")
                        ENDIF

                        IF USED("cursor_4c_CfgBoleto") AND RECCOUNT("cursor_4c_CfgBoleto") > 0
                            SELECT cursor_4c_CfgBoleto
                            GO TOP

                            INSERT INTO cursor_4c_Dados (FPags, Parcs, Vencs, Datas, Valos, CLocals, CTxtCds) ;
                                VALUES (cursor_4c_Selecao.fpags, cursor_4c_Selecao.parcs, ;
                                    ConverterParaData(TratarNulo(cursor_4c_Selecao.vencs, {})), ;
                                    ConverterParaData(TratarNulo(cursor_4c_Selecao.datas, {})), ;
                                    cursor_4c_Selecao.valos, cursor_4c_CfgBoleto.clocals, ;
                                    TratarNulo(cursor_4c_CfgBoleto.ctxtcds, ""))

                            loc_nTotal = loc_nTotal + cursor_4c_Selecao.valos
                        ENDIF

                        IF USED("cursor_4c_CfgBoleto")
                            USE IN cursor_4c_CfgBoleto
                        ENDIF

                        SELECT cursor_4c_Selecao
                    ENDSCAN
                    USE IN cursor_4c_Selecao
                ENDIF
                loc_lResultado = .T.
            ENDIF

            IF USED("cursor_4c_Dados")
                GO TOP IN cursor_4c_Dados
            ENDIF

            THIS.this_nTotalParcelas = loc_nTotal

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao selecionar condi" + CHR(231) + CHR(245) + "es de pagamento: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - equivalente ao AfterRowColChange do grdItens
    * legado: le o registro CORRENTE de cursor_4c_Dados (a linha selecionada
    * na grade) para as propriedades *Atual usadas pelo restante do fluxo
    * de impressao.
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cFPagsAtual        = PADR(TratarNulo(FPags, ""), 12)
            THIS.this_nParcsAtual        = TratarNulo(Parcs, 0)
            THIS.this_dVencsAtual        = TratarNulo(Vencs, {})
            THIS.this_dDatasAtual        = TratarNulo(Datas, {})
            THIS.this_nValosAtual        = TratarNulo(Valos, 0)
            THIS.this_cLocalPgtoAtual    = TratarNulo(CLocals, "")
            THIS.this_cTextoCedenteAtual = TratarNulo(CTxtCds, "")

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarDadosDocumento - equivalente aos passos 1 a 5 de Procedure
    * imprimir() do legado (ANTES da atualizacao de SigCnFBl): resolve o
    * documento (SigMvCab), o numero/parcela impresso (SigMvNfi, com
    * fallback "Parc.: NN"), a operacao (SigCdOpe.Nfiscals, que decide se a
    * conta a cobrar eh a origem ou o destino do movimento), o cliente
    * (SigCdCli, com fallback Cobranca->Normal em endereco/bairro/cidade/
    * estado/cep) e a forma de pagamento (SigOpFp.ImpNotas). Requer que
    * CarregarDoCursor() ja tenha resolvido a parcela atual.
    *==========================================================================
    FUNCTION CarregarDadosDocumento()
        LOCAL loc_cCliente

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        *-- 1) SigMvCab - documento do movimento (Dopes, ContaOs, ContaDs)
        IF !THIS.ExecutarSQL("SELECT dopes, contaos, contads FROM SigMvCab WHERE empdopnums = " + ;
                EscaparSQL(THIS.this_cEmpDopNum), "cursor_4c_Documento", "Documento")
            RETURN .F.
        ENDIF
        IF !USED("cursor_4c_Documento") OR RECCOUNT("cursor_4c_Documento") = 0
            IF USED("cursor_4c_Documento")
                USE IN cursor_4c_Documento
            ENDIF
            THIS.this_cMensagemErro = "Movimenta" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Encontrada!!!"
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Documento
        GO TOP
        THIS.this_cDopes   = PADR(TratarNulo(dopes, ""), 20)
        THIS.this_cContaOs = PADR(TratarNulo(contaos, ""), 10)
        THIS.this_cContaDs = PADR(TratarNulo(contads, ""), 10)
        USE IN cursor_4c_Documento

        *-- 2) SigMvNfi - numero do documento impresso (fallback: "Parc.: NN")
        THIS.this_cNumeroDocumento = LEFT("Parc.: " + ALLTRIM(STR(THIS.this_nParcsAtual, 2)), 8)
        IF THIS.ExecutarSQL("SELECT nfis FROM SigMvNfi WHERE empdopnums = " + ;
                EscaparSQL(THIS.this_cEmpDopNum), "cursor_4c_Nfis", "NotaFiscal")
            IF USED("cursor_4c_Nfis") AND RECCOUNT("cursor_4c_Nfis") > 0
                SELECT cursor_4c_Nfis
                GO TOP
                THIS.this_cNumeroDocumento = LEFT(ALLTRIM(TratarNulo(nfis, "")) + "-" + ALLTRIM(STR(THIS.this_nParcsAtual, 2)), 8)
            ENDIF
            IF USED("cursor_4c_Nfis")
                USE IN cursor_4c_Nfis
            ENDIF
        ENDIF

        *-- 3) SigCdOpe - Nfiscals decide se a conta a cobrar eh origem ou destino
        IF !THIS.ExecutarSQL("SELECT nfiscals FROM SigCdOpe WHERE dopes = " + ;
                EscaparSQL(THIS.this_cDopes), "cursor_4c_Operacao", "Operacao")
            RETURN .F.
        ENDIF
        IF !USED("cursor_4c_Operacao") OR RECCOUNT("cursor_4c_Operacao") = 0
            IF USED("cursor_4c_Operacao")
                USE IN cursor_4c_Operacao
            ENDIF
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Encontrada!!!"
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Operacao
        GO TOP
        loc_cCliente = IIF(NVL(nfiscals, 0) = 1, THIS.this_cContaOs, THIS.this_cContaDs)
        USE IN cursor_4c_Operacao

        *-- 4) SigCdCli - cliente a cobrar, com fallback Cobranca -> Normal
        IF !THIS.ExecutarSQL("SELECT razaos, cpfs, endcobs, endes, baicobs, bairs, cidcobs, cidas, " + ;
                "estcobs, estas, cepcobs, ceps FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCliente), ;
                "cursor_4c_Cliente", "Cliente")
            RETURN .F.
        ENDIF
        IF !USED("cursor_4c_Cliente") OR RECCOUNT("cursor_4c_Cliente") = 0
            IF USED("cursor_4c_Cliente")
                USE IN cursor_4c_Cliente
            ENDIF
            THIS.this_cMensagemErro = 'Conta "' + ALLTRIM(loc_cCliente) + '" N' + CHR(227) + "o Encontrada!!!"
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Cliente
        GO TOP
        THIS.this_cRazaoSocial = ALLTRIM(TratarNulo(razaos, ""))
        THIS.this_cCpfCnpj     = PADR(TratarNulo(cpfs, ""), 20)
        THIS.this_cEndereco    = IIF(!EMPTY(TratarNulo(endcobs, "")), ALLTRIM(endcobs), ALLTRIM(TratarNulo(endes, "")))
        THIS.this_cBairro      = PADR(IIF(!EMPTY(TratarNulo(baicobs, "")), ALLTRIM(baicobs), ALLTRIM(TratarNulo(bairs, ""))), 20)
        THIS.this_cCidade      = PADR(IIF(!EMPTY(TratarNulo(cidcobs, "")), ALLTRIM(cidcobs), ALLTRIM(TratarNulo(cidas, ""))), 20)
        THIS.this_cEstado      = PADR(IIF(!EMPTY(TratarNulo(estcobs, "")), ALLTRIM(estcobs), ALLTRIM(TratarNulo(estas, ""))), 2)
        THIS.this_cCep         = PADR(IIF(!EMPTY(TratarNulo(cepcobs, "")), ALLTRIM(cepcobs), ALLTRIM(TratarNulo(ceps, ""))), 9)
        USE IN cursor_4c_Cliente

        *-- 5) SigOpFp - ImpNotas decide (em CarregarDadosImpressao) o vencimento impresso
        IF !THIS.ExecutarSQL("SELECT impbols, impnotas FROM SigOpFp WHERE fpags = " + ;
                EscaparSQL(PADR(THIS.this_cFPagsAtual, 12)), "cursor_4c_FormaPgto", "FormaPagamento")
            RETURN .F.
        ENDIF
        IF !USED("cursor_4c_FormaPgto") OR RECCOUNT("cursor_4c_FormaPgto") = 0
            IF USED("cursor_4c_FormaPgto")
                USE IN cursor_4c_FormaPgto
            ENDIF
            THIS.this_cMensagemErro = "Forma de Pagamento N" + CHR(227) + "o Encontrada!!!"
            RETURN .F.
        ENDIF
        SELECT cursor_4c_FormaPgto
        GO TOP
        THIS.this_nImpNotasAtual = NVL(impnotas, 0)
        USE IN cursor_4c_FormaPgto

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * AtualizarConfiguracaoBoleto - equivalente ao
    * "Update SigCnFBl Set CLocals = ..., CTxtCds = ... Where FPags = ..."
    * feito dentro de Procedure imprimir() do legado (ANTES de montar o
    * layout de impressao - grava o local de pagamento/texto de cedente
    * eventualmente editados pelo usuario nos getLocals/getTxtCds, que no
    * legado estao ligados direto a crGrade.CLocals/CTxtCds). Chama
    * RegistrarAuditoria("UPDATE") no sucesso (ver ObterChavePrimaria acima).
    *
    * O legado NAO para no UPDATE: logo depois dele vem um SEGUNDO teste,
    * "If (ThisForm.poDataMgr.Commit() < 1)", com a MESMA mensagem de falha -
    * porque o fSqlConector do Framework abre a conexao em transacao MANUAL
    * (cOpenConn.Init seta Transactions = 2 de proposito) e sem o Commit o
    * UPDATE nao eh efetivado. Neste ambiente a premissa se mantem: medido em
    * 2026-09-18 num VFP9 virgem, SQLGETPROP(0, "Transactions") ja vale 2, de
    * modo que gnConnHandle tambem nasce manual. Sem este Commit, a edicao do
    * local de pagamento / texto do cedente ficaria presa na transacao aberta
    * e SUMIRIA se o processo morresse - sem erro nenhum na tela, porque o
    * SELECT de conferencia na MESMA conexao enxerga a propria transacao.
    * Commit/Rollback so quando a conexao esta de fato em modo manual (mesmo
    * criterio de SIGPRCNBBO.prg:471) - em auto-commit o par seria inerte.
    *==========================================================================
    FUNCTION AtualizarConfiguracaoBoleto()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_lManual, loc_cFalha

        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cFPagsAtual))
            THIS.this_cMensagemErro = "Nenhuma condi" + CHR(231) + CHR(227) + "o de pagamento selecionada."
            RETURN .F.
        ENDIF

        loc_cSQL = "UPDATE SigCnFBl SET " + ;
            "clocals = " + EscaparSQL(THIS.this_cLocalPgtoAtual) + ", " + ;
            "ctxtcds = " + EscaparSQL(THIS.this_cTextoCedenteAtual) + " " + ;
            "WHERE fpags = " + EscaparSQL(PADR(THIS.this_cFPagsAtual, 12))

        *-- Mensagem UNICA para as duas falhas, como no legado (UPDATE e
        *-- Commit exibem o mesmo texto, com o mesmo titulo).
        loc_cFalha = "A Configura" + CHR(231) + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio N" + CHR(227) + "o Pode Ser Atualizada!!!" + ;
            CHR(13) + "Condi" + CHR(231) + CHR(227) + "o de Pagamento: " + ALLTRIM(THIS.this_cFPagsAtual)

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
        loc_nRet    = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nRet < 0
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            THIS.this_cMensagemErro = loc_cFalha + CHR(13) + CapturarErroSQL()
        ELSE
            loc_lResultado = .T.

            *-- Equivalente ao "If (ThisForm.poDataMgr.Commit() < 1)" do
            *-- legado: SQLCOMMIT devolve 1 no sucesso e -1 no erro. IF
            *-- ANINHADO, nao "loc_lManual AND SQLCOMMIT(...)": o VFP9 NAO faz
            *-- curto-circuito em AND/OR e chamaria SQLCOMMIT tambem com a
            *-- conexao em auto-commit.
            IF loc_lManual
                IF SQLCOMMIT(gnConnHandle) <= 0
                    = SQLROLLBACK(gnConnHandle)
                    THIS.this_cMensagemErro = loc_cFalha + CHR(13) + CapturarErroSQL()
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            IF loc_lResultado
                THIS.RegistrarAuditoria("UPDATE")
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarConfiguracaoLayout - equivalente a
    * "If Not CursorQuery(SigCnFBl, LocalCfgBl, FPags, crGrade.FPags) Then
    *  CursorQuery(..., FPags, Space(12))" do legado: carrega a configuracao
    * de posicoes de impressao para o FPags atual, com fallback para a
    * configuracao em branco. Reusa SIGPRIBLBO (mesma tabela SigCnFBl, ja
    * migrada) em vez de duplicar as propriedades de posicao.
    *==========================================================================
    FUNCTION CarregarConfiguracaoLayout()
        LOCAL loc_lResultado

        loc_lResultado = .F.

        THIS.this_oConfigBoleto = CREATEOBJECT("SIGPRIBLBO")

        IF !THIS.this_oConfigBoleto.BuscarConfiguracao(PADR(THIS.this_cFPagsAtual, 12))
            THIS.this_oConfigBoleto.BuscarConfiguracao(SPACE(12))
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_oConfigBoleto.this_cIdChaves))
            THIS.this_cMensagemErro = "Configura" + CHR(231) + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio N" + CHR(227) + "o Encontrada!!!" + ;
                CHR(13) + "Condi" + CHR(231) + CHR(227) + "o de Pagamento: " + ALLTRIM(THIS.this_cFPagsAtual)
        ELSE
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * VerificarImpressoraDisponivel - equivalente ao bloco
    * "Declare laPrn(1) / If (APrinters(laPrn) > 0) ..." do legado: confirma
    * que a impressora configurada em SigCnFBl.CNomeImps esta instalada no
    * Windows. Requer que CarregarConfiguracaoLayout() ja tenha resolvido
    * THIS.this_oConfigBoleto.
    *==========================================================================
    FUNCTION VerificarImpressoraDisponivel()
        LOCAL loc_lResultado, loc_nQtd, loc_nI
        LOCAL ARRAY loc_aImpressoras(1)

        loc_lResultado = .F.

        loc_nQtd = APRINTERS(loc_aImpressoras)
        IF loc_nQtd > 0
            FOR loc_nI = 1 TO loc_nQtd
                IF UPPER(ALLTRIM(loc_aImpressoras(loc_nI, 1))) == UPPER(ALLTRIM(THIS.this_oConfigBoleto.this_cNomeImps))
                    loc_lResultado = .T.
                    EXIT
                ENDIF
            ENDFOR
        ENDIF

        IF !loc_lResultado
            THIS.this_cMensagemErro = "Impressora de Boleto Banc" + CHR(225) + "rio N" + CHR(227) + "o Encontrada!!!" + ;
                CHR(13) + "Condi" + CHR(231) + CHR(227) + "o de Pagamento: " + ALLTRIM(THIS.this_cFPagsAtual)
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarDadosImpressao - equivalente ao bloco final de dados de
    * Procedure imprimir() do legado: resolve o vencimento impresso
    * (ldVct = Iif(ImpNotas = 1, Dtoc(Vencs), FPags)) e monta
    * cursor_4c_Impressao (crDados) com os dados ja resolvidos por
    * CarregarDadosDocumento()/CarregarDoCursor().
    *==========================================================================
    FUNCTION CarregarDadosImpressao()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        THIS.this_cLocalPgtoImpressao = THIS.this_cLocalPgtoAtual
        THIS.this_cVencimentoImpresso = PADR(IIF(THIS.this_nImpNotasAtual = 1, DTOC(THIS.this_dVencsAtual), THIS.this_cFPagsAtual), 12)
        THIS.this_dDataDocumento      = THIS.this_dDatasAtual
        THIS.this_nValorImpressao     = THIS.this_nValosAtual
        THIS.this_cTextoComplementar  = THIS.this_cTextoCedenteAtual

        TRY
            IF USED("cursor_4c_Impressao")
                USE IN cursor_4c_Impressao
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Impressao (CLocals C(100), Vencs C(12), DatDoc D, NumDoc C(8), Valor N(14,2), ;
                Razaos C(50), Cpfs C(20), EndCobs C(80), BaiCobs C(20), CidCobs C(20), EstCobs C(2), CepCobs C(9), Texto M)
            SET NULL OFF

            INSERT INTO cursor_4c_Impressao (CLocals, Vencs, DatDoc, NumDoc, Valor, Razaos, Cpfs, Texto, ;
                EndCobs, BaiCobs, CidCobs, EstCobs, CepCobs) ;
                VALUES (THIS.this_cLocalPgtoImpressao, THIS.this_cVencimentoImpresso, THIS.this_dDataDocumento, ;
                    THIS.this_cNumeroDocumento, THIS.this_nValorImpressao, THIS.this_cRazaoSocial, THIS.this_cCpfCnpj, ;
                    THIS.this_cTextoComplementar, THIS.this_cEndereco, THIS.this_cBairro, THIS.this_cCidade, ;
                    THIS.this_cEstado, THIS.this_cCep)

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar dados de impress" + CHR(227) + "o: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * InserirLinhaImpressao - equivalente a ThisForm.Detalhe(...) do legado:
    * insere uma linha em cursor_4c_LayoutImpressao (TmpImprime) SOMENTE
    * quando a posicao esta configurada (Linha<>0 Or Coluna<>0) - posicao
    * zerada em SigCnFBl significa "este campo nao imprime neste layout".
    * Todas as 13 chamadas do legado omitem o 4o parametro (lcEst), que cai
    * no default "X" - por isso o estilo nao eh exposto aqui.
    *==========================================================================
    PROTECTED PROCEDURE InserirLinhaImpressao(par_nLinha, par_nColuna, par_cConteudo, par_nTamanho, par_nAltura)
        LOCAL loc_nLinha, loc_nColuna, loc_cConteudo

        loc_nLinha    = TratarNulo(par_nLinha, 0)
        loc_nColuna   = TratarNulo(par_nColuna, 0)
        loc_cConteudo = TratarNulo(par_cConteudo, "")

        IF loc_nColuna <> 0 OR loc_nLinha <> 0
            INSERT INTO cursor_4c_LayoutImpressao (Linha, Coluna, Conteudo, Style, LineSize, NHeight) ;
                VALUES (loc_nLinha, loc_nColuna, loc_cConteudo, "X", TratarNulo(par_nTamanho, 0), TratarNulo(par_nAltura, 0))
        ENDIF
    ENDPROC

    *==========================================================================
    * MontarLayoutImpressao - equivalente aos 13 ThisForm.Detalhe(...) de
    * Procedure imprimir() do legado: monta cursor_4c_LayoutImpressao
    * (TmpImprime) com cada campo do boleto na posicao (Linha/Coluna)
    * configurada em THIS.this_oConfigBoleto. Requer que
    * CarregarConfiguracaoLayout() e CarregarDadosImpressao() ja tenham
    * rodado.
    *==========================================================================
    FUNCTION MontarLayoutImpressao()
        LOCAL loc_lResultado, loc_oCfg, loc_oErro

        loc_lResultado = .F.
        loc_oCfg = THIS.this_oConfigBoleto

        TRY
            IF USED("cursor_4c_LayoutImpressao")
                USE IN cursor_4c_LayoutImpressao
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_LayoutImpressao (Linha N(6,2), Coluna N(6,2), Conteudo C(100), Style C(3), LineSize N(6,2), NHeight N(6,2))
            SET NULL OFF
            INDEX ON (Linha * 1000000000) + (Coluna * 100) TAG Ordem

            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnLocals,  loc_oCfg.this_nClLocals,  THIS.this_cLocalPgtoImpressao,   60, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnDtVencs, loc_oCfg.this_nClDtVencs, THIS.this_cVencimentoImpresso,    9, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnDtDocs,  loc_oCfg.this_nClDtDocs,  DTOC(THIS.this_dDataDocumento),   9, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnNrDocs,  loc_oCfg.this_nClNrDocs,  THIS.this_cNumeroDocumento,       9, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnVlDocs,  loc_oCfg.this_nClVlDocs,  TRANSFORM(THIS.this_nValorImpressao, "@Z 999,999,999.99"), 15, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnRazClis, loc_oCfg.this_nClRazClis, ALLTRIM(THIS.this_cRazaoSocial),  50, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnCgcClis, loc_oCfg.this_nClCgcClis, ALLTRIM(THIS.this_cCpfCnpj),      20, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnEndCobs, loc_oCfg.this_nClEndCobs, ALLTRIM(THIS.this_cEndereco),     80, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnBaiCobs, loc_oCfg.this_nClBaiCobs, ALLTRIM(THIS.this_cBairro),       20, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnCidCobs, loc_oCfg.this_nClCidCobs, ALLTRIM(THIS.this_cCidade),       20, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnEstCobs, loc_oCfg.this_nClEstCobs, ALLTRIM(THIS.this_cEstado),        2, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnCepCobs, loc_oCfg.this_nClCepCobs, ALLTRIM(THIS.this_cCep),           9, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnTxtCds,  loc_oCfg.this_nClTxtCds,  THIS.this_cTextoComplementar,     60, 6)

            IF USED("cursor_4c_LayoutImpressao")
                GO TOP IN cursor_4c_LayoutImpressao
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar layout de impress" + CHR(227) + "o: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ObterTamanhoFolha - equivalente ao parse de LocalCfgBl.CTamFolha do
    * legado (formato "A/largura/B" - extrai o 2o segmento, separado por
    * "/", como tamanho numerico da folha/pagina).
    *==========================================================================
    PROTECTED FUNCTION ObterTamanhoFolha()
        LOCAL loc_cTamFolha, loc_nPos1, loc_nPos2

        loc_cTamFolha = TratarNulo(THIS.this_oConfigBoleto.this_cTamFolha, "")
        loc_nPos1 = AT("/", loc_cTamFolha, 1) + 1
        loc_nPos2 = AT("/", loc_cTamFolha, 2) - (AT("/", loc_cTamFolha, 1) + 1)

        IF loc_nPos2 <= 0
            RETURN 0
        ENDIF

        RETURN VAL(ALLTRIM(SUBSTR(loc_cTamFolha, loc_nPos1, loc_nPos2)))
    ENDFUNC

    *==========================================================================
    * ExecutarImpressaoMatricial - equivalente a
    * "Do SigPrIbl With [TmpImprime], CNomeImps, [To Printer NoConsole], ...,
    * [crDados], 17" do legado: envia cursor_4c_LayoutImpressao para a
    * impressora configurada, posicionando cada linha por Linha/Coluna. A
    * rotina generica de impressao matricial do legado (p-code de
    * SIGFUNCS.PRG, fora do acervo) nao existe para ser chamada - a
    * reproducao fiel usa os comandos nativos de impressora do VFP9 sobre
    * os MESMOS dados (mesmas posicoes, mesmo conteudo) preparados acima.
    * Suprimida em gb_4c_ModoTeste para nao depender de impressora real
    * durante os testes automatizados.
    *==========================================================================
    PROTECTED FUNCTION ExecutarImpressaoMatricial()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF !USED("cursor_4c_LayoutImpressao")
            THIS.this_cMensagemErro = "Layout de impress" + CHR(227) + "o n" + CHR(227) + "o gerado."
            RETURN .F.
        ENDIF

        TRY
            SET PRINTER TO NAME (ALLTRIM(THIS.this_oConfigBoleto.this_cNomeImps))
            SET DEVICE TO PRINTER

            SELECT cursor_4c_LayoutImpressao
            SCAN
                @ INT(Linha), INT(Coluna) SAY ALLTRIM(Conteudo)
            ENDSCAN

            EJECT
            SET DEVICE TO SCREEN
            SET PRINTER TO DEFAULT

            loc_lResultado = .T.
        CATCH TO loc_oErro
            SET DEVICE TO SCREEN
            SET PRINTER TO DEFAULT
            THIS.this_cMensagemErro = "Erro ao imprimir boleto banc" + CHR(225) + "rio: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ImprimirBoleto - equivalente a Procedure imprimir() do legado completa
    * (chamada por btnImprimir.Click apos a confirmacao do usuario): exige
    * que CarregarDoCursor() ja tenha resolvido a parcela selecionada, e
    * encadeia resolucao de documento/cliente, atualizacao da configuracao
    * de boleto, carga do layout, checagem de impressora, montagem dos
    * dados e do layout de impressao, e o disparo da impressao em si.
    *==========================================================================
    FUNCTION ImprimirBoleto()
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            THIS.this_cMensagemErro = "Nenhuma condi" + CHR(231) + CHR(227) + "o de pagamento selecionada."
            RETURN .F.
        ENDIF

        IF !THIS.CarregarDadosDocumento()
            RETURN .F.
        ENDIF

        IF !THIS.AtualizarConfiguracaoBoleto()
            RETURN .F.
        ENDIF

        IF !THIS.CarregarConfiguracaoLayout()
            RETURN .F.
        ENDIF

        IF !THIS.VerificarImpressoraDisponivel()
            RETURN .F.
        ENDIF

        IF !THIS.CarregarDadosImpressao()
            RETURN .F.
        ENDIF

        IF !THIS.MontarLayoutImpressao()
            RETURN .F.
        ENDIF

        loc_lResultado = THIS.ExecutarImpressaoMatricial()

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

