*==============================================================================
* FormSIGMVMVT.prg - Acompanhamento Operacional
*==============================================================================
* Tipo: OPERACIONAL (layout customizado, SEM PageFrame)
* Migrado de: SIGMVMVT.SCX
*
* Pilares:
*   UX   -> layout e comportamento o mais proximo possivel do legado (800x600)
*   BD   -> SigMvCab/SigMvItn/SigMvPec/SigOpDev/SigCdOpe (ver SIGMVMVTBO.prg)
*   CODE -> arquitetura em camadas (FormBase / SIGMVMVTBO)
*
* NOTA (paridade com o legado): o SIGMVMVT eh uma tela de CONSULTA em arvore
* (TreeView) do historico de uma operacao de movimento - Empresa+Operacao+
* Numero -> lista de baixas/producao, drill-down por nivel. Nao ha grid de
* listagem de registros nem os 6 botoes CRUD canonicos (Incluir/Visualizar/
* Alterar/Excluir/Buscar/Encerrar): o legado (raiz Class: form, SEM
* BaseClass: pageframe - ver tasks\task574\layout.json/SIGMVMVT_form_codigo_
* fonte.txt) usa layout proprio com os controles direto na Form, sem
* Page1(Lista)/Page2(Dados). Inventar PageFrame ou botoes CRUD violaria o
* PILAR 1 e a regra "NUNCA inventar funcionalidade que o legado nao tem".
*
* FASE 3/8 - ESTRUTURA BASE: DEFINE CLASS, propriedades de estado (espelham
* as PUBLIC/propriedades customizadas do form legado - paEmpDopNums,
* pcEmpDopNums, lacoficina, pnniveis, pnNodeExp, pldblclick, Automatico),
* Init()/InicializarForm()/Destroy().
*
* FASE 4/8 - CONTROLES: ConfigurarControles() cria shp_4c_Shape1 (decorativo,
* atras da barra de botoes), cmd_4c_BtnOperacao ("Movimento"),
* cmd_4c_BtnOficina ("Producao", Visible=.F. - fiel ao legado),
* obj_4c_Commandgroup1 (6 botoes: Expandir/Retrair/Encerrar/Anterior/
* Imprimir/Proximo) e obj_4c_TreeView (arvore hierarquica - controle ActiveX
* de terceiros ctTree.ocx/DBI Technologies, sem substituto nativo VFP9;
* instanciado via OLEControl com o mesmo ProgID do legado, guardado em
* TRY/CATCH e pulado em modo teste). TornarControlesVisiveis() torna tudo
* visivel apos o AddObject, preservando BtnOficina.Visible=.F.
* Ainda na Fase 4, o metodo de carga desta tela: CarregarDados() (equivalente
* ao MakeTree legado) monta a chave EmpDopNums, pede os dados ao SIGMVMVTBO e
* manda PopularArvore() desenhar os niveis 1 (operacao) e 2 (produtos), com
* PrepararArvore()/ArvoreDisponivel() cuidando do controle ActiveX. Como no
* legado, CarregarDados() roda sozinho no Init quando Automatico = .T.
* Nenhum evento de controle esta ligado ainda (fica para a Fase 7-8).
*
* MEDIDO no VFP9 em 2026-09-25 (ver "cttree.ocx" abaixo): com o OCX ausente,
* AddObject("OLEControl", "cttree.cttreeview") devolve OLE error 0x800401f3
* ("classe invalida"), que o TRY/CATCH PEGA - a tela abre sem a arvore em vez
* de travar. NAO trocar por "MSComctlLib.TreeCtrl" (TreeView da MSCOMCTL.OCX):
* medido na mesma bateria, ele TRAVA o VFP9 num dialogo modal de licenca de
* design-time que o TRY/CATCH nao intercepta.
*
* FASE 5/8 - FILTRO (Empresa/Operacao/Numero/Periodo): ConfigurarFiltros()
* cria lbl_4c_Label1..5 + txt_4c_CEmp/txt_4c_Dopes/txt_4c_Numes/txt_4c_DtI/
* txt_4c_DtF, direto na Form (fiel ao legado - sem Page2, sem container).
* Posicoes/tamanhos/mascaras TRANSCRITOS do dump do SCX (Top=127/131,
* Lefts 42..692, MaxLength/InputMask por campo). Label4 e Label5 tinham
* ForeColor = RGB(231,254,253) no SCX (quase-branco, ilegivel sobre o
* fundo claro da Picture do form) - escurecido para RGB(36,84,155), igual
* aos irmaos Label1/2/3 (CLAUDE.md regra #12 - quase-branco escurece para
* a cor das labels irmas). Label5 eh o "a" (CHR(224)) entre GetDtI e GetDtF
* ("Periodo : de __ a __").
* AplicarParametrosAbertura() reproduz o trecho do Init legado que preenche
* GetCEmp/GetDopes/GetNumes a partir de par_cEmps/par_cDopes/par_nNumes
* (pcEmps/pcDopes/pcNumes), incluindo o ReadOnly quando os tres estao
* presentes e o Enabled = .F. dos 5 campos quando this_lAutomatico = .T.
* (drill direto - o usuario nao deve poder editar o filtro que abriu a
* tela). No legado o ReadOnly e o Automatico sao a MESMA expressao - o "E"
* dos TRES parametros - entao os dois saem de this_lAutomatico (ver o Init):
* recebendo so parte do filtro a tela abre com o que veio PRE-PREENCHIDO mas
* EDITAVEL, que e o comportamento do legado. O MakeTree() do legado (aqui
* CarregarDados()) continua chamado logo depois, como ja estava na Fase 4.
* MEDIDO no VFP9 em 2026-09-25 (test_fase5_sigmvmvt.prg): os 5 campos batem
* com o dump do SCX em Top/Left/Width/Height/MaxLength; o InputMask
* "999999" que o SCX declara nos dois campos de data e REESCRITO pelo
* proprio VFP para "99/99/9999" quando o .Value passa a ser DATE (o Init
* legado faz GetDtI.Value = Ctod('')), entao transcrever o mask do SCX nao
* limita a digitacao do ano - nao trocar por mask "de data" inventado.
*
* FASE 7/8 - EVENTOS PRINCIPAIS: liga os controles criados na Fase 4-6 aos
* metodos correspondentes. NAO existem os 4 eventos CRUD do template generico
* (BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick) - este
* form eh consulta pura (ver nota acima), entao os "eventos principais" reais
* sao os do proprio SIGMVMVT.SCX:
*   - Buttons(1..6) do obj_4c_Commandgroup1 -> BtnExpandirClick/BtnRetrairClick/
*     BtnEncerrarClick/BtnAnteriorClick/BtnImprimirClick/BtnProximoClick
*     (Command1..Command6.Click do legado)
*   - cmd_4c_BtnOperacao/cmd_4c_BtnOficina -> BtnOperacaoClick/BtnOficinaClick,
*     que abrem SigMvExp/SigRePPd (fora do escopo desta task - CREATEOBJECT
*     guardado em TRY/CATCH, com MsgAviso se o modulo migrado ainda nao
*     existir, em vez de estourar "Class definition ... is not found")
*   - obj_4c_TreeView -> TreeViewGotFocus/TreeViewKeyPress/TreeViewNodeClick
*   - txt_4c_CEmp/txt_4c_Numes/txt_4c_DtI/txt_4c_DtF -> GotFocus/LostFocus
*     completando o que a Fase 5 deixou (so CEmp/Dopes.KeyPress); Valid do
*     legado virou KeyPress em ENTER/TAB (CEmpKeyPress/DopesKeyPress ja
*     existiam; NumesKeyPress/DtFKeyPress disparam MakeTree/MakeList - aqui
*     CarregarDados()/CarregarListaPeriodo())
*
* FASE 8/8 - RECURSAO DA ARVORE (niveis 3+): SubNivel()/HiNivel()/NoHiPro()/
* NoProd() sao a orquestracao do lado do Form (equivalente a ThisForm.
* SubNivel/HiNivel/NoHiPro/NoProd do legado) sobre os metodos de consulta ja
* existentes em SIGMVMVTBO.prg desde as Fases 1-2 (ObterSubNivel/
* ObterHistoricoNivel/ObterNoHiPro/ObterNoProd). PopularArvore() dispara
* SubNivel(3,...)/HiNivel(3,...) por produto (dentro do Scan de
* cursor_4c_Itens) e SubNivel(2,...)/HiNivel(2,...) uma vez no fim -
* exatamente onde o maketree legado dispara. Os quatro se chamam
* mutuamente ate profundidade 50 (this_nNiveis, mesmo teto do legado) ou ate
* o EmpDopNums cair em "NF - TRF SIMBOLICA" (fim de cadeia). Dedup em dois
* arrays de escopo Form: this_aHistorico (equivalente a ThisForm.
* pcEmpDopNums, reiniciado a cada CarregarDados) e this_aOperacoes
* (equivalente a ThisForm.paOperacoes, escopo de FORM - nao reseta entre
* cargas, igual ao legado).
*
* Cada chamada a BO/SQLEXEC troca a work area corrente - por isso todo
* SCAN sobre um cursor de nivel se reseleciona apos QUALQUER chamada
* aninhada, antes de continuar a leitura da linha ou de deixar o SCAN
* avancar (a mesma disciplina do "Select &lcSqlFile."/"Select &lcTmpSub"
* espalhado pelo hinivel/subnivel/nohipro/noprod legado - SCAN em VFP nao
* preserva sozinho a alias de origem quando o corpo do loop troca de work
* area).
*
* DOIS DESVIOS DELIBERADOS do dump legado, cada um documentado em comentario
* no proprio metodo (NoHiPro/NoProd) - ambos looked like erros de
* digitacao/copia-e-cola que tornariam o ramo correspondente um no-op
* silencioso (nunca desenha nada) se transcritos literalmente, o que
* contraria a regra do projeto de paridade funcional completa:
*   1. NoHiPro: "If Ascan(ThisForm.paOperacoes,EmpDopNums)" sem "= 0" no
*      dump (o par simetrico em NoProd usa "= 0" corretamente) -
*      normalizado para "= 0".
*   2. NoProd (ramo "pnNivel <> 3"): chamada a HiNivel com 5 argumentos
*      (assinatura declarada tem 3) - normalizado para a mesma assinatura
*      de 3 argumentos que o SubNivel vizinho, no MESMO bloco, ja usa
*      corretamente.
*
* CHAMADA:
*   loForm = CREATEOBJECT("FormSIGMVMVT")                 && sem drill direto
*   loForm = CREATEOBJECT("FormSIGMVMVT", .T., cEmps, cDopes, nNumes) && modal
*                                                          && + Automatico
*   loForm.Show()
*==============================================================================

DEFINE CLASS FormSIGMVMVT AS FormBase

    *-- Dimensoes e comportamento identicos ao legado (SIGMVMVT.SCX)
    Height       = 600
    Width        = 800
    AutoCenter   = .T.
    BorderStyle  = 2
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .T.
    ClipControls = .F.
    ShowTips     = .T.
    Themes       = .F.
    FontName     = "Verdana"
    FontSize     = 8
    DataSession  = 2

    *-- Parametros de abertura (Parameters plModal, pcEmps, pcDopes, pcNumes
    *-- do Init legado) - permitem abrir a tela ja "no meio" de uma operacao
    *-- especifica, sem passar pelo filtro de Empresa/Operacao/Periodo.
    this_lModal      = .F.   && plModal - WindowType = Iif(plModal, 1, 0)
    this_cEmpsParam  = ""    && pcEmps
    this_cDopesParam = ""    && pcDopes
    this_nNumesParam = 0     && pcNumes

    *-- Init legado, transcrito LITERALMENTE:
    *--   Automatico = Not Empty(pcEmps) And Not Empty(pcDopes) And Not Empty(pcNumes)
    *-- E' um "E" dos TRES parametros, nao um "OU": so com Empresa + Operacao +
    *-- Numero a tela abriu ja no meio de uma operacao (drill direto). Com "OU",
    *-- receber so a Empresa ja ligaria o modo automatico, e o Init desabilitaria
    *-- os 5 campos do filtro (ver AplicarParametrosAbertura) e dispararia a
    *-- carga - o usuario ficaria com a tela TRAVADA e VAZIA, sem como completar
    *-- Operacao/Numero. A mesma expressao serve de ReadOnly no legado, entao ela
    *-- mora aqui como fonte unica.
    this_lAutomatico = .F.

    *-- Estado operacional da arvore (equivalente as PUBLIC/propriedades
    *-- customizadas do form legado)
    this_lAcOficina = .F.   && ThisForm.lacoficina - acesso a producao/oficina
    this_nNiveis    = 0     && ThisForm.pnniveis   - profundidade atual da arvore
    this_nNodeExp   = 0     && ThisForm.pnNodeExp  - nivel de expansao corrente
    this_nIndiceClicado = 0 && ThisForm.pldblclick - indice do no clicado na arvore

    *-- As 3 imagens da arvore (Form4.Ico/depend3.bmp/OHist.Ico) sao carregadas
    *-- UMA vez, como no Init legado - AddImage repetido empilharia indices
    *-- novos e quebraria o Iif(ChkPagos,3,1) que aponta para 1..3.
    this_lImagensArvore = .F.

    *-- ThisForm.plRetorno - .T. apos MakeTree (drill de operacao), .F. apos
    *-- MakeList (lista por periodo). So consultado pelo botao Anterior
    *-- (Command4) para decidir entre voltar a lista ou a arvore de detalhe.
    this_lRetorno = .F.

    *-- ThisForm.paEmpDopNums[1] - pilha de EmpDopNums visitados (botao Anterior)
    DIMENSION this_aEmpDopNums[1]

    *-- ThisForm.pcEmpDopNums[1,2] - historico paralelo (Empresa/Operacao +
    *-- contexto) usado junto com paEmpDopNums na navegacao "Anterior"
    DIMENSION this_aHistorico[1, 2]

    *-- ThisForm.paOperacoes[1] - lista de EmpDopNums ja desenhados pelas
    *-- baixas de estoque/producao (NoHiPro/NoProd, Fase 8), evita redesenhar
    *-- o mesmo no quando o grafo de baixas tem ciclos. Escopo de FORM (nao
    *-- reseta a cada CarregarDados - o legado tambem nao reseta paOperacoes
    *-- em MakeTree, so pcEmpDopNums/this_aHistorico eh reiniciado por carga).
    DIMENSION this_aOperacoes[1]

    *==========================================================================
    * Init - Recebe os parametros de abertura e repassa para FormBase.Init()
    * (que chama InicializarForm() atraves de DODEFAULT()).
    *==========================================================================
    PROCEDURE Init(par_lModal, par_cEmps, par_cDopes, par_nNumes)
        THIS.this_lModal      = IIF(TYPE("par_lModal") = "L", par_lModal, .F.)
        THIS.this_cEmpsParam  = IIF(TYPE("par_cEmps")  = "C", ALLTRIM(par_cEmps), "")
        THIS.this_cDopesParam = IIF(TYPE("par_cDopes") = "C", ALLTRIM(par_cDopes), "")
        THIS.this_nNumesParam = IIF(TYPE("par_nNumes") = "N", par_nNumes, 0)

        THIS.this_lAutomatico = !EMPTY(THIS.this_cEmpsParam) ;
            AND !EMPTY(THIS.this_cDopesParam) ;
            AND THIS.this_nNumesParam != 0

        THIS.WindowType = IIF(THIS.this_lModal, 1, 0)

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o Business Object, reinicializa o estado
    * de navegacao da arvore e cria os controles visuais (Fase 4). Os campos
    * de filtro (Label1..5 + GetcEmp/GetDopes/GetNumes/GetDtI/GetDtF) entram
    * nas Fases 5 a 6.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.this_oBusinessObject = CREATEOBJECT("SIGMVMVTBO")

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Falha ao criar SIGMVMVTBO", "Erro")
        ELSE
            THIS.Caption = "Acompanhamento Operacional"

            *-- Picture = ..\framework\imagens\new_background.jpg no legado -
            *-- caminho resolvido via gc_4c_CaminhoFramework (regra CLAUDE.md
            *-- #27/Pattern #170 - NUNCA gc_4c_CaminhoBase + "Framework\...").
            IF FILE(gc_4c_CaminhoFramework + "imagens\new_background.jpg")
                THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
            ENDIF

            *-- Reinicializa o estado de navegacao da arvore (equivalente ao
            *-- bloco inicial do Init legado - Declare .../pnNodeExp/lacoficina).
            DIMENSION THIS.this_aEmpDopNums[1]
            THIS.this_aEmpDopNums[1] = ""

            DIMENSION THIS.this_aHistorico[1, 2]
            THIS.this_aHistorico[1, 1] = ""
            THIS.this_aHistorico[1, 2] = ""

            DIMENSION THIS.this_aOperacoes[1]
            THIS.this_aOperacoes[1] = ""

            THIS.this_lAcOficina     = .F.
            THIS.this_nNiveis        = 0
            THIS.this_nNodeExp       = 0
            THIS.this_nIndiceClicado = 0
            THIS.this_lRetorno       = .F.

            THIS.ConfigurarControles()
            THIS.ConfigurarFiltros()

            THIS.TornarControlesVisiveis(THIS)

            *-- Init legado: preenche GetCEmp/GetDopes/GetNumes a partir dos
            *-- parametros de abertura e trava os campos quando Automatico.
            THIS.AplicarParametrosAbertura()

            *-- Init legado: If ThisForm.Automatico ... ThisForm.MakeTree().
            *-- Abriu com Empresa/Operacao/Numero ja definidos (drill direto),
            *-- entao a arvore ja e' montada sem passar pelo filtro. A falha de
            *-- carga NAO impede a tela de abrir (o BO ja avisa o usuario).
            IF THIS.this_lAutomatico AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
               (TYPE("gb_4c_ModoTeste")   != "L" OR !gb_4c_ModoTeste)
                THIS.CarregarDados()
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarControles - Cria os controles visuais da tela (layout FLAT,
    * sem PageFrame - controles direto na Form, fieis ao SIGMVMVT.SCX):
    *   shp_4c_Shape1        - retangulo decorativo atras da barra de botoes
    *   cmd_4c_BtnOperacao   - botao "Movimento" (unico modo hoje implementado)
    *   cmd_4c_BtnOficina    - botao "Producao" (Visible=.F. no legado)
    *   obj_4c_Commandgroup1 - 6 botoes: Expandir/Retrair/Encerrar/Anterior/
    *                          Imprimir/Proximo
    *   obj_4c_TreeView      - arvore hierarquica (equivalente ao "grid" desta
    *                          tela - controle ActiveX de terceiros ctTree.ocx/
    *                          DBI Technologies, NAO portavel para VFP9 nativo;
    *                          instanciado via OLEControl com o MESMO ProgID
    *                          do legado, guardado em TRY/CATCH porque o OCX
    *                          pode nao estar registrado na maquina)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarControles
        LOCAL loc_oErrOle

        *-- shp_4c_Shape1 (decorativo, atras da barra de botoes - criado
        *-- ANTES para o CommandGroup desenhar por cima)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 5
            .Left        = 698
            .Height      = 110
            .Width       = 90
            .BackStyle   = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- cmd_4c_BtnOperacao ("Movimento")
        THIS.AddObject("cmd_4c_BtnOperacao", "CommandButton")
        WITH THIS.cmd_4c_BtnOperacao
            .Top               = 12
            .Left              = 12
            .Height            = 100
            .Width             = 80
            .FontName          = "Verdana"
            .FontSize          = 8
            .WordWrap          = .T.
            .Picture            = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
            .Cancel            = .T.
            .Caption           = "Movimento"
            .ForeColor         = RGB(36, 84, 155)
            .BackColor         = RGB(255, 255, 255)
            .DisabledBackColor = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible           = .T.
        ENDWITH

        *-- cmd_4c_BtnOficina ("Producao" - Visible=.F. no legado, mantido fiel)
        THIS.AddObject("cmd_4c_BtnOficina", "CommandButton")
        WITH THIS.cmd_4c_BtnOficina
            .Top               = 12
            .Left              = 92
            .Height            = 100
            .Width             = 80
            .FontName          = "Verdana"
            .FontSize          = 8
            .WordWrap          = .T.
            .Picture            = gc_4c_CaminhoIcones + "geral_servicos_60.jpg"
            .Caption           = "Produ" + CHR(231) + CHR(227) + "o"
            .ToolTipText       = ""
            .ForeColor         = RGB(36, 84, 155)
            .BackColor         = RGB(255, 255, 255)
            .DisabledBackColor = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible           = .F.
        ENDWITH

        *-- obj_4c_Commandgroup1 (6 botoes de navegacao/acao da arvore)
        THIS.AddObject("obj_4c_Commandgroup1", "CommandGroup")
        WITH THIS.obj_4c_Commandgroup1
            .ButtonCount = 6
            .Top         = 7
            .Left        = 211
            .Height      = 110
            .Width       = 575
            .BackStyle   = 0
            .BorderStyle = 0

            WITH .Buttons(1)
                .AutoSize          = .F.
                .Top               = 4
                .Left              = 243
                .Height            = 100
                .Width             = 80
                .FontName          = "Verdana"
                .FontSize          = 8
                .WordWrap          = .T.
                .Picture            = gc_4c_CaminhoIcones + "geral_seta_bai_60.jpg"
                .Caption           = "Expandir"
                .ForeColor         = RGB(36, 84, 155)
                .BackColor         = RGB(255, 255, 255)
                .DisabledBackColor = RGB(255, 255, 255)
                .ToolTipText       = "Expandir"
                .Themes            = .F.
            ENDWITH

            WITH .Buttons(2)
                .AutoSize          = .F.
                .Top               = 4
                .Left              = 323
                .Height            = 100
                .Width             = 80
                .FontName          = "Verdana"
                .FontSize          = 8
                .WordWrap          = .T.
                .Picture            = gc_4c_CaminhoIcones + "geral_seta_cim_60.jpg"
                .Caption           = "Retrair"
                .ForeColor         = RGB(36, 84, 155)
                .BackColor         = RGB(255, 255, 255)
                .DisabledBackColor = RGB(255, 255, 255)
                .ToolTipText       = "Retrair"
                .Themes            = .F.
            ENDWITH

            WITH .Buttons(3)
                .AutoSize          = .F.
                .Top               = 4
                .Left              = 493
                .Height            = 100
                .Width             = 80
                .FontName          = "Verdana"
                .FontSize          = 8
                .WordWrap          = .T.
                .Picture            = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel            = .T.
                .Caption           = "Encerrar"
                .ForeColor         = RGB(36, 84, 155)
                .BackColor         = RGB(255, 255, 255)
                .DisabledBackColor = RGB(255, 255, 255)
                .ToolTipText       = "[ESC] Sair"
                .Themes            = .F.
            ENDWITH

            WITH .Buttons(4)
                .AutoSize          = .F.
                .Top               = 4
                .Left              = 83
                .Height            = 100
                .Width             = 80
                .FontName          = "Verdana"
                .FontSize          = 8
                .WordWrap          = .T.
                .Picture            = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
                .Caption           = "Anterior"
                .ForeColor         = RGB(36, 84, 155)
                .BackColor         = RGB(255, 255, 255)
                .DisabledBackColor = RGB(255, 255, 255)
                .ToolTipText       = "Anterior"
                .Themes            = .F.
            ENDWITH

            WITH .Buttons(5)
                .AutoSize          = .F.
                .Top               = 4
                .Left              = 163
                .Height            = 100
                .Width             = 80
                .FontName          = "Verdana"
                .FontSize          = 8
                .WordWrap          = .T.
                .Picture            = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                .Caption           = "Imprimir"
                .ForeColor         = RGB(36, 84, 155)
                .BackColor         = RGB(255, 255, 255)
                .DisabledBackColor = RGB(255, 255, 255)
                .ToolTipText       = "Imprimir"
                .Themes            = .F.
            ENDWITH

            WITH .Buttons(6)
                .AutoSize          = .F.
                .Top               = 4
                .Left              = 4
                .Height            = 100
                .Width             = 80
                .FontName          = "Verdana"
                .FontSize          = 8
                .WordWrap          = .T.
                .Picture            = gc_4c_CaminhoIcones + "geral_seta_dir_60.jpg"
                .Caption           = "Pr" + CHR(243) + "ximo"
                .ForeColor         = RGB(36, 84, 155)
                .BackColor         = RGB(255, 255, 255)
                .DisabledBackColor = RGB(255, 255, 255)
                .ToolTipText       = "Pr" + CHR(243) + "ximo"
                .Themes            = .F.
            ENDWITH

            .Value   = 1
            .Visible = .T.
        ENDWITH

        *-- Eventos dos botoes (Fase 7) - cada Buttons(N) tem o proprio Click
        *-- no legado (Command1.Click .. Command6.Click), nao o Click do
        *-- grupo. BINDEVENT so funciona com metodo PUBLIC (CLAUDE.md #3).
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnExpandirClick")
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(2), "Click", THIS, "BtnRetrairClick")
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(3), "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(4), "Click", THIS, "BtnAnteriorClick")
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(5), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(6), "Click", THIS, "BtnProximoClick")
        BINDEVENT(THIS.cmd_4c_BtnOperacao, "Click", THIS, "BtnOperacaoClick")
        BINDEVENT(THIS.cmd_4c_BtnOficina,  "Click", THIS, "BtnOficinaClick")

        *-- obj_4c_TreeView (ctTree.ocx / DBI Technologies, copyright 1998 -
        *-- controle ActiveX de terceiros do legado, sem substituto nativo
        *-- VFP9). ATENCAO: o SCX so preserva o caminho do OCX (OLEObject =
        *-- c:\windows\syswow64\cttree.ocx), NAO o ProgID/CLSID exato - nao
        *-- ha como confirmar "cttree.cttreeview" sem uma maquina com o OCX
        *-- registrado. Se a instanciacao abaixo falhar por ProgID incorreto
        *-- (em vez de OCX ausente), conferir o ProgID real via OLEVIEW ou
        *-- regedit (HKCR\TypeLib) numa maquina legado e corrigir a string.
        *-- Nao instanciar em modo teste: AddObject OLEControl pode travar
        *-- sem usuario, e o OCX pode nao estar registrado na maquina de
        *-- build - nesse caso a arvore fica ausente mas o resto da tela
        *-- funciona (guard em TRY/CATCH, sem impedir a abertura do form).
        IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
           (TYPE("gb_4c_ModoTeste")   != "L" OR !gb_4c_ModoTeste)
            TRY
                THIS.AddObject("obj_4c_TreeView", "OLEControl", "cttree.cttreeview")
                WITH THIS.obj_4c_TreeView
                    .Top     = 156
                    .Left    = 33
                    .Height  = 430
                    .Width   = 734
                    .Visible = .T.
                ENDWITH

                *-- GotFocus/KeyPress/NodeClick do TreeView legado.
                BINDEVENT(THIS.obj_4c_TreeView, "GotFocus",  THIS, "TreeViewGotFocus")
                BINDEVENT(THIS.obj_4c_TreeView, "KeyPress",  THIS, "TreeViewKeyPress")
                BINDEVENT(THIS.obj_4c_TreeView, "NodeClick", THIS, "TreeViewNodeClick")
            CATCH TO loc_oErrOle
                MsgErro("Controle de " + CHR(225) + "rvore (ctTree.ocx) indispon" + ;
                        CHR(237) + "vel nesta esta" + CHR(231) + CHR(227) + "o: " + ;
                        loc_oErrOle.Message, "Aviso")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarFiltros - Cria o filtro de Empresa/Operacao/Numero/Periodo
    * (Label1..Label5 + GetcEmp/GetDopes/GetNumes/GetDtI/GetDtF do legado),
    * controles direto na Form (sem Page2/container - fiel ao SIGMVMVT.SCX,
    * que tambem os cria direto em sigmvmvt). Posicoes/tamanhos/mascaras
    * TRANSCRITOS do dump (CLAUDE.md regra #23 - Width declarado no SCX,
    * Alignment nao declarado fica 0/esquerda).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros
        *-- lbl_4c_Label1 ("Empresa :")
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 131
            .Left      = 42
            .Width     = 61
            .Height    = 15
            .BackStyle = 0
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .Caption   = "Empresa :"
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_CEmp (GetcEmp) - char(3), SigCdEmp.Cemps
        THIS.AddObject("txt_4c_CEmp", "TextBox")
        WITH THIS.txt_4c_CEmp
            .Top               = 127
            .Left              = 104
            .Width             = 39
            .Height            = 23
            .MaxLength         = 3
            .TabIndex          = 2
            .Value             = ""
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 128)
            .Visible           = .T.
        ENDWITH

        *-- lbl_4c_Label2 ("Operacao :")
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 131
            .Left      = 154
            .Width     = 66
            .Height    = 15
            .BackStyle = 0
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Dopes (GetDopes) - char(20), SigCdOpe.Dopes
        THIS.AddObject("txt_4c_Dopes", "TextBox")
        WITH THIS.txt_4c_Dopes
            .Top               = 127
            .Left              = 221
            .Width             = 178
            .Height            = 23
            .MaxLength         = 20
            .TabIndex          = 3
            .Value             = ""
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 128)
            .Visible           = .T.
        ENDWITH

        *-- lbl_4c_Label3 ("Numero :")
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 131
            .Left      = 406
            .Width     = 56
            .Height    = 15
            .BackStyle = 0
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .Caption   = "N" + CHR(250) + "mero :"
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Numes (GetNumes) - numerico, SigMvCab.Numes
        THIS.AddObject("txt_4c_Numes", "TextBox")
        WITH THIS.txt_4c_Numes
            .Top               = 127
            .Left              = 463
            .Width             = 53
            .Height            = 23
            .MaxLength         = 6
            .TabIndex          = 4
            .Alignment         = 3
            .Format            = "R"
            .InputMask         = "999999"
            .Value             = 0
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 128)
            .Visible           = .T.
        ENDWITH

        *-- lbl_4c_Label4 ("Periodo :") - ForeColor original 231,254,253
        *-- (quase-branco) escurecido para o mesmo azul dos irmaos.
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 131
            .Left      = 540
            .Width     = 54
            .Height    = 15
            .BackStyle = 0
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .Caption   = "Per" + CHR(237) + "odo :"
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_DtI (GetDtI) - data inicial do periodo
        THIS.AddObject("txt_4c_DtI", "TextBox")
        WITH THIS.txt_4c_DtI
            .Top               = 127
            .Left              = 596
            .Width             = 75
            .Height            = 23
            .MaxLength         = 6
            .TabIndex          = 5
            .Alignment         = 3
            .Format            = "R"
            .InputMask         = "999999"
            .Value             = {}
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 128)
            .Visible           = .T.
        ENDWITH

        *-- txt_4c_DtF (GetDtF) - data final do periodo
        THIS.AddObject("txt_4c_DtF", "TextBox")
        WITH THIS.txt_4c_DtF
            .Top               = 127
            .Left              = 692
            .Width             = 75
            .Height            = 23
            .MaxLength         = 6
            .TabIndex          = 6
            .Alignment         = 3
            .Format            = "R"
            .InputMask         = "999999"
            .Value             = {}
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 128)
            .Visible           = .T.
        ENDWITH

        *-- lbl_4c_Label5 ("a" entre GetDtI e GetDtF) - ForeColor original
        *-- 231,254,253 (quase-branco) escurecido para o mesmo azul.
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top       = 131
            .Left      = 678
            .Width     = 9
            .Height    = 15
            .BackStyle = 0
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .Caption   = CHR(224)
            .Visible   = .T.
        ENDWITH

        *-- Lookups (F4/ENTER/TAB) do filtro - GetcEmp.Valid e GetDopes.Valid
        *-- do legado (fwBuscaExt). CLAUDE.md #3/#33-corolario: BINDEVENT so
        *-- funciona com metodo PUBLIC; handlers com LPARAMETERS explicito
        *-- na 1a linha (regra "KeyPress handler").
        BINDEVENT(THIS.txt_4c_CEmp,  "KeyPress", THIS, "CEmpKeyPress")
        BINDEVENT(THIS.txt_4c_Dopes, "KeyPress", THIS, "DopesKeyPress")

        *-- Demais eventos do filtro (Fase 7) - GotFocus/LostFocus fieis ao
        *-- legado; Valid substituido por KeyPress em ENTER/TAB (CLAUDE.md -
        *-- BINDEVENT "Valid" nao dispara de forma confiavel em TextBox).
        BINDEVENT(THIS.txt_4c_CEmp,  "GotFocus",  THIS, "CEmpGotFocus")
        BINDEVENT(THIS.txt_4c_Numes, "GotFocus",  THIS, "NumesGotFocus")
        BINDEVENT(THIS.txt_4c_Numes, "KeyPress",  THIS, "NumesKeyPress")
        *-- NAO renomear para algo terminado em "LostFocus": o CorretorAutomatico
        *-- (Pattern #74, heuristica "d") reescreve TODO BINDEVENT LostFocus cujo
        *-- handler termine em "LostFocus" para KeyPress, por causa do risco de
        *-- recursao com FormBuscaAuxiliar - esta tela nao abre lookup aqui, mas
        *-- o nome ainda dispara o falso positivo. Handler chama-se
        *-- NumesAoSairDoCampo por isso.
        BINDEVENT(THIS.txt_4c_Numes, "LostFocus", THIS, "NumesAoSairDoCampo")
        BINDEVENT(THIS.txt_4c_DtI,   "GotFocus",  THIS, "DtIGotFocus")
        BINDEVENT(THIS.txt_4c_DtF,   "GotFocus",  THIS, "DtFGotFocus")
        BINDEVENT(THIS.txt_4c_DtF,   "KeyPress",  THIS, "DtFKeyPress")
    ENDPROC

    *==========================================================================
    * CEmpKeyPress - equivalente a GetcEmp.Valid do legado. Dispara em
    * ENTER(13)/TAB(9)/F4(115) (CLAUDE.md regra do KeyPress de lookup - so F4
    * deixaria o usuario preso apos digitar e dar TAB).
    *==========================================================================
    PROCEDURE CEmpKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        THIS.AbrirLookupEmpresa()
    ENDPROC

    *==========================================================================
    * AbrirLookupEmpresa - tenta o match EXATO primeiro (SIGMVMVTBO.
    * ValidarEmpresa, equivalente ao Seek/Select do fwBuscaExt); nao achando,
    * abre o picker direto (CLAUDE.md - MsgAviso antes do picker eh
    * anti-padrao: o campo digitado vira o prefixo de busca).
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupEmpresa
        LOCAL loc_cValor

        IF !EMPTY(THIS.txt_4c_CEmp.Value)
            loc_cValor = ALLTRIM(TRANSFORM(THIS.txt_4c_CEmp.Value))

            IF THIS.this_oBusinessObject.ValidarEmpresa(loc_cValor)
                THIS.txt_4c_CEmp.Value = THIS.this_oBusinessObject.this_cEmps
                RETURN
            ENDIF

            THIS.AbrirBuscaEmpresa(loc_cValor)
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaEmpresa - FormBuscaAuxiliar sobre SigCdEmp (Cemps/Razsocs -
    * as MESMAS colunas do fwBuscaExt legado: 'cEmps'/'RazSocs'; docs\schema.sql
    * confirma as duas em SigCdEmp, entao nao ha grafia inventada aqui -
    * CLAUDE.md regra #44 veta Emps/NComps, nao Razsocs).
    * Assinatura do CREATEOBJECT com HANDLE em 1o lugar (CLAUDE.md #36) e
    * contrato this_lAchouRegistro/this_lSelecionou (CLAUDE.md #37).
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaEmpresa(par_cValorDigitado)
        LOCAL loc_oBusca

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", ;
            ALLTRIM(TRANSFORM(par_cValorDigitado)), "Buscar Empresa")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Cemps",   "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Razsocs", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                SELECT cursor_4c_BuscaEmp
                THIS.txt_4c_CEmp.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
            ENDIF

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * DopesKeyPress - equivalente a GetDopes.Valid do legado.
    *==========================================================================
    PROCEDURE DopesKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        IF EMPTY(THIS.txt_4c_Dopes.Value)
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Deve ser informada !!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
        ELSE
            THIS.AbrirLookupOperacao()
        ENDIF

        *-- "ThisForm.BtnOficina.Visible = ThisForm.lAcOficina" do fim do
        *-- GetDopes.Valid legado - roda em QUALQUER desfecho (achou, nao
        *-- achou+picker, campo vazio), por isso fica fora do IF acima.
        THIS.cmd_4c_BtnOficina.Visible = THIS.this_lAcOficina
    ENDPROC

    *==========================================================================
    * AbrirLookupOperacao - tenta o match EXATO (SIGMVMVTBO.ValidarOperacao);
    * nao achando, abre o picker direto. Em qualquer resultado que preencha
    * txt_4c_Dopes, reproduz o trecho do legado
    * "ThisForm.lAcOficina = fChecaAcesso(padl(CsSigCdOpe.nDopes,8,'0'),
    * 'OPPEND')" via AtualizarAcessoOficina().
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupOperacao
        LOCAL loc_cValor

        THIS.this_lAcOficina = .F.

        IF !EMPTY(THIS.txt_4c_Dopes.Value)
            loc_cValor = ALLTRIM(TRANSFORM(THIS.txt_4c_Dopes.Value))

            IF THIS.this_oBusinessObject.ValidarOperacao(loc_cValor)
                THIS.txt_4c_Dopes.Value = THIS.this_oBusinessObject.this_cDopes
                THIS.AtualizarAcessoOficina()
                RETURN
            ENDIF

            THIS.AbrirBuscaOperacao(loc_cValor)
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaOperacao - FormBuscaAuxiliar sobre SigCdOpe. CLAUDE.md regra
    * "SigCdOpe eh single-column": Dopes eh PK E descricao ao mesmo tempo -
    * UMA UNICA mAddColuna, NUNCA descrs/Descrs (coluna que nao existe nessa
    * tabela).
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaOperacao(par_cValorDigitado)
        LOCAL loc_oBusca

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", ;
            ALLTRIM(TRANSFORM(par_cValorDigitado)), ;
            "Buscar Opera" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                SELECT cursor_4c_BuscaOpe
                THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                THIS.AtualizarAcessoOficina()
            ENDIF

            IF USED("cursor_4c_BuscaOpe")
                USE IN cursor_4c_BuscaOpe
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * AtualizarAcessoOficina - "ThisForm.lAcOficina = fChecaAcesso(
    * padl(CsSigCdOpe.nDopes,8,'0'), 'OPPEND')" do legado (fim do
    * GetDopes.Valid). fChecaAcesso e' stub global (utils\functions.prg) que
    * devolve .T. quando o Framework de permissoes nao esta disponivel - o
    * flag e' espelhado tambem no BO (this_lAcOficina), que e' quem consome a
    * checagem na navegacao de niveis 3+ (Fases 7-8).
    *==========================================================================
    PROTECTED PROCEDURE AtualizarAcessoOficina
        LOCAL loc_nCodOpe

        THIS.this_lAcOficina = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !EMPTY(THIS.txt_4c_Dopes.Value)
            loc_nCodOpe = THIS.this_oBusinessObject.ObterCodigoOperacao( ;
                ALLTRIM(TRANSFORM(THIS.txt_4c_Dopes.Value)))

            IF loc_nCodOpe >= 0
                THIS.this_lAcOficina = fChecaAcesso(PADL(TRANSFORM(loc_nCodOpe), 8, "0"), "OPPEND")
            ENDIF
        ENDIF

        THIS.this_oBusinessObject.this_lAcOficina = THIS.this_lAcOficina
    ENDPROC

    *==========================================================================
    * CEmpGotFocus - equivalente a GetcEmp.GotFocus: entrar de novo no campo
    * Empresa reinicia a busca (limpa a arvore e os campos Operacao/Numero).
    *==========================================================================
    PROCEDURE CEmpGotFocus
        IF THIS.ArvoreDisponivel()
            THIS.obj_4c_TreeView.ClearNodes
        ENDIF

        THIS.txt_4c_Dopes.Value = ""
        THIS.txt_4c_Numes.Value = 0
    ENDPROC

    *==========================================================================
    * NumesGotFocus - equivalente a GetNumes.GotFocus: entrar no campo Numero
    * zera o filtro de periodo (os dois modos de busca - por operacao ou por
    * periodo - sao mutuamente exclusivos no legado).
    *==========================================================================
    PROCEDURE NumesGotFocus
        THIS.txt_4c_DtI.Value = {}
        THIS.txt_4c_DtF.Value = {}
    ENDPROC

    *==========================================================================
    * NumesAoSairDoCampo - equivalente a GetNumes.LostFocus: com numero
    * informado, zera o nivel de expansao corrente e manda o foco para o
    * botao Expandir (Buttons(1) do obj_4c_Commandgroup1 - Command1 no
    * legado). NAO chamar "NumesLostFocus": o CorretorAutomatico reescreve
    * qualquer BINDEVENT LostFocus cujo handler termine em "LostFocus" para
    * KeyPress (Pattern #74 - risco de recursao com FormBuscaAuxiliar), o que
    * quebraria este handler (dispararia a cada tecla, roubando o foco do
    * campo enquanto o usuario ainda digita).
    *==========================================================================
    PROCEDURE NumesAoSairDoCampo
        IF THIS.txt_4c_Numes.Value != 0
            THIS.this_nNodeExp = 0
            THIS.obj_4c_Commandgroup1.Buttons(1).SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * NumesKeyPress - equivalente a GetNumes.Valid: com Empresa/Operacao/
    * Numero preenchidos, monta a arvore de detalhe da operacao (MakeTree).
    *==========================================================================
    PROCEDURE NumesKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        IF THIS.txt_4c_Numes.Value = 0
            RETURN
        ENDIF

        IF EMPTY(THIS.txt_4c_CEmp.Value)
            MsgAviso("Empresa Deve ser Informada !!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF EMPTY(THIS.txt_4c_Dopes.Value)
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Deve ser Informada !!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.CarregarDados()
            THIS.this_lRetorno = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * DtIGotFocus - equivalente a GetDtI.GotFocus: entrar no campo Data
    * Inicial zera o Numero (busca por periodo, nao por operacao especifica).
    *==========================================================================
    PROCEDURE DtIGotFocus
        THIS.txt_4c_Numes.Value = 0
    ENDPROC

    *==========================================================================
    * DtFGotFocus - equivalente a GetDtF.GotFocus.
    *==========================================================================
    PROCEDURE DtFGotFocus
        THIS.this_nNodeExp      = 0
        THIS.txt_4c_Numes.Value = 0
    ENDPROC

    *==========================================================================
    * DtFKeyPress - equivalente a GetDtF.Valid: com Data Inicial e (Empresa OU
    * Operacao) preenchidas, exige as duas e lista as operacoes do periodo
    * (MakeList).
    *==========================================================================
    PROCEDURE DtFKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        IF EMPTY(THIS.txt_4c_DtI.Value)
            MsgAviso("Data Inicial Inv" + CHR(225) + "lida !!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF EMPTY(THIS.txt_4c_DtF.Value)
            RETURN
        ENDIF

        IF EMPTY(THIS.txt_4c_CEmp.Value) AND EMPTY(THIS.txt_4c_Dopes.Value)
            RETURN
        ENDIF

        IF EMPTY(THIS.txt_4c_CEmp.Value)
            MsgAviso("Empresa Deve ser Informada !!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF EMPTY(THIS.txt_4c_Dopes.Value)
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Deve ser Informada !!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.CarregarListaPeriodo()
            THIS.this_lRetorno = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * AplicarParametrosAbertura - Reproduz o trecho do Init legado que usa os
    * parametros de abertura (pcEmps/pcDopes/pcNumes) para pre-preencher o
    * filtro:
    *   If !IsEmpty(pcEmps)  -> GetCEmp.Value  = Alltrim(pcEmps)
    *   If !IsEmpty(pcDopes) -> GetDopes.Value = pcDopes
    *   If !IsEmpty(pcNumes) -> GetNumes.Value = pcNumes
    *   GetCEmp/GetDopes/GetNumes.ReadOnly = (os 3 preenchidos)
    *   If Automatico (os 3 preenchidos) -> Enabled = .F. nos 5 campos
    * Roda DEPOIS de ConfigurarFiltros (os controles ja existem) e ANTES do
    * CarregarDados() automatico, exatamente como no Init legado.
    *==========================================================================
    PROTECTED PROCEDURE AplicarParametrosAbertura
        LOCAL loc_lTravado

        *-- No legado o ReadOnly dos tres campos e' a MESMA expressao do
        *-- Automatico (! IsEmpty(pcEmps) And ! IsEmpty(pcDopes) And
        *-- ! IsEmpty(pcNumes)), calculada logo acima no Init. Reusar a
        *-- property em vez de repetir a conta evita que as duas divirjam.
        loc_lTravado = THIS.this_lAutomatico

        IF !EMPTY(THIS.this_cEmpsParam)
            THIS.txt_4c_CEmp.Value = THIS.this_cEmpsParam
        ENDIF
        THIS.txt_4c_CEmp.ReadOnly = loc_lTravado

        IF !EMPTY(THIS.this_cDopesParam)
            THIS.txt_4c_Dopes.Value = THIS.this_cDopesParam
        ENDIF
        THIS.txt_4c_Dopes.ReadOnly = loc_lTravado

        IF THIS.this_nNumesParam != 0
            THIS.txt_4c_Numes.Value = THIS.this_nNumesParam
        ENDIF
        THIS.txt_4c_Numes.ReadOnly = loc_lTravado

        IF THIS.this_lAutomatico
            THIS.txt_4c_CEmp.Enabled  = .F.
            THIS.txt_4c_Dopes.Enabled = .F.
            THIS.txt_4c_Numes.Enabled = .F.
            THIS.txt_4c_DtI.Enabled   = .F.
            THIS.txt_4c_DtF.Enabled   = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * ArvoreDisponivel - .T. quando o controle ActiveX da arvore foi criado
    * com sucesso em ConfigurarControles. O ctTree.ocx pode nao estar
    * registrado na estacao (ou o form estar em modo teste), e nesse caso
    * TODA chamada a API de nos tem de ser evitada - o objeto simplesmente
    * nao existe e qualquer referencia derrubaria o metodo.
    *==========================================================================
    PROTECTED FUNCTION ArvoreDisponivel()
        RETURN PEMSTATUS(THIS, "obj_4c_TreeView", 5) AND ;
               VARTYPE(THIS.obj_4c_TreeView) = "O"
    ENDFUNC

    *==========================================================================
    * ObterTextoDataHora / ObterTextoHora - equivalente a
    * "Left(Ttoc(Nvl(<data>, Ctot(''))), 10)" / "Substr(Ttoc(...), 12, 5)" do
    * HiNivel/SubNivel legado. TTOC() so eh seguro com tipo DATETIME (T) - um
    * valor vindo de TratarNulo(<coluna>, {}) pode chegar como DATE (D) quando
    * NULL, e TTOC em Date daria resultado inconsistente; por isso o VARTYPE
    * decide o caminho em vez de aplicar TTOC cegamente (regra CLAUDE.md #16 -
    * mesma familia de risco do TTOD() em valor DATE).
    *==========================================================================
    PROTECTED FUNCTION ObterTextoDataHora(par_uValor)
        LOCAL loc_dValor

        IF VARTYPE(par_uValor) = "T"
            RETURN LEFT(TTOC(par_uValor), 10)
        ENDIF

        loc_dValor = ConverterParaData(par_uValor)
        IF EMPTY(loc_dValor)
            RETURN SPACE(10)
        ENDIF
        RETURN DTOC(loc_dValor)
    ENDFUNC

    PROTECTED FUNCTION ObterTextoHora(par_uValor)
        IF VARTYPE(par_uValor) = "T"
            RETURN SUBSTR(TTOC(par_uValor), 12, 5)
        ENDIF
        RETURN SPACE(5)
    ENDFUNC

    *==========================================================================
    * ObterFiltro - Le um campo de filtro da tela quando ele ja existe e cai
    * no parametro de abertura (Init legado: pcEmps/pcDopes/pcNumes) quando
    * nao existe. Os TextBox de filtro (txt_4c_CEmp/txt_4c_Dopes/txt_4c_Numes/
    * txt_4c_DtI/txt_4c_DtF, o GetcEmp/GetDopes/GetNumes/GetDtI/GetDtF do
    * legado) passaram a existir na Fase 5, entao o caminho normal e' ler da
    * tela; o fallback para o parametro continua porque o legado tambem monta
    * a arvore direto do parametro quando Automatico = .T. (drill direto).
    *
    * Membro alcancado por NOME: EVALUATE para LEITURA (CLAUDE.md #15/#34) -
    * NUNCA THIS.Controls(<nome>), que e indexado por numero.
    *==========================================================================
    PROTECTED FUNCTION ObterFiltro(par_cControle, par_uPadrao)
        LOCAL loc_uValor
        loc_uValor = par_uPadrao

        IF PEMSTATUS(THIS, par_cControle, 5)
            IF VARTYPE(EVALUATE("THIS." + par_cControle)) = "O"
                loc_uValor = EVALUATE("THIS." + par_cControle + ".Value")
            ENDIF
        ENDIF

        RETURN loc_uValor
    ENDFUNC

    *==========================================================================
    * PrepararArvore - Reproduz o bloco de inicializacao da arvore que o
    * legado repete no inicio de MakeTree e de MakeList:
    *   loTree1.ClearNodes / TipsDisplay = .t. / ExpandOnDClick /
    *   SmallIcons = .t. / PicAlign = 0 / SelectedStyle = 2 / PictureType = 1
    * As tres imagens (indices 1..3 usados em AddPictureNode) sao carregadas
    * uma unica vez, como no Init legado:
    *   AddImage(LoadPicture('\vbmp\Form4.Ico'))    -> 1 (operacao aberta)
    *   AddImage(LoadPicture('\vbmp\depend3.bmp'))  -> 2 (produto/item)
    *   AddImage(LoadPicture('\vbmp\OHist.Ico'))    -> 3 (operacao paga)
    *==========================================================================
    PROTECTED PROCEDURE PrepararArvore()
        LOCAL loc_oErro

        IF THIS.ArvoreDisponivel()
            TRY
                WITH THIS.obj_4c_TreeView
                    IF !THIS.this_lImagensArvore
                        .AddImage(LOADPICTURE(gc_4c_CaminhoIcones + "Form4.Ico"))
                        .AddImage(LOADPICTURE(gc_4c_CaminhoIcones + "depend3.bmp"))
                        .AddImage(LOADPICTURE(gc_4c_CaminhoIcones + "OHist.Ico"))
                        THIS.this_lImagensArvore = .T.
                    ENDIF

                    .ClearNodes
                    .TipsDisplay   = .T.
                    .ExpandOnDClick
                    .SmallIcons    = .T.
                    .PicAlign      = 0
                    .SelectedStyle = 2
                    .PictureType   = 1
                ENDWITH
            CATCH TO loc_oErro
                MsgErro("Falha ao preparar a " + CHR(225) + "rvore: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarDados - Metodo de carga desta tela (equivalente ao MakeTree do
    * legado). Monta a chave EmpDopNums a partir do filtro, pede os dados ao
    * SIGMVMVTBO e desenha os dois primeiros niveis da arvore:
    *   nivel 1 - a operacao (SigMvCab): Emp - Operacao - Numero - Nota -
    *             Data - Usuario - DtAlt - UsuAlt, NodeCargo = EmpDopNums
    *   nivel 2 - os produtos da operacao (SigMvItn): Produto - Descricao -
    *             Qtde, NodeCargo = 'PRODUTO'
    * Os niveis 3+ (SubNivel/HiNivel do legado, ja portados como consultas em
    * SIGMVMVTBO) sao acionados pelos botoes de navegacao, junto com os
    * eventos das Fases 7-8.
    *
    * Texto dos nos e icones TRANSCRITOS do legado (PROCEDURE maketree), sem
    * reescrever: Iif(ChkPagos,3,1) para a operacao e icone 2 para o produto.
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_cEmps, loc_cDopes, loc_nNumes, loc_cEmpDopNums
        LOCAL loc_oErro, loc_lCarregou

        loc_lSucesso  = .F.
        loc_lCarregou = .F.

        *-- FormParaBO eh a fonte UNICA da transferencia filtro -> BO (e ja
        *-- monta Padr(GetCEmp,3)+Padr(GetDopes,20)+Str(GetNumes,6) do legado);
        *-- ele mesmo reporta quando o Business Object nao esta disponivel.
        IF THIS.FormParaBO()
            WITH THIS.this_oBusinessObject
                loc_cEmps       = ALLTRIM(.this_cEmps)
                loc_cDopes      = ALLTRIM(.this_cDopes)
                loc_nNumes      = .this_nNumes
                loc_cEmpDopNums = .this_cEmpDopNums
            ENDWITH

            IF EMPTY(loc_cEmps) OR EMPTY(loc_cDopes) OR loc_nNumes = 0
                MsgAviso("Empresa, Opera" + CHR(231) + CHR(227) + "o e N" + CHR(250) + ;
                         "mero devem ser informados !!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- SQLEXEC com handle invalido DISPARA excecao em vez de
                *-- devolver -1 (medido: "Connection handle is invalid" saindo
                *-- de SIGMVMVTBO.CarregarOperacao). Sem este TRY o usuario
                *-- veria o "Program Error" CRU do VFP no lugar do dialogo do
                *-- sistema. RETURN so DEPOIS do ENDTRY (CLAUDE.md #1).
                TRY
                    loc_lCarregou = THIS.this_oBusinessObject.CarregarOperacao( ;
                        loc_cEmps, loc_cDopes, loc_nNumes)

                    IF loc_lCarregou
                        IF !THIS.this_oBusinessObject.CarregarItens(loc_cEmpDopNums)
                            MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                                     "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF

                        *-- ThisForm.pcEmpDopNums[1,1] / [1,2] = 1 do MakeTree
                        DIMENSION THIS.this_aHistorico[1, 2]
                        THIS.this_aHistorico[1, 1] = loc_cEmpDopNums
                        THIS.this_aHistorico[1, 2] = 1

                        THIS.PopularArvore(loc_cEmpDopNums)

                        THIS.this_nNodeExp = 1
                        loc_lSucesso = .T.
                    ELSE
                        MsgAviso(IIF(EMPTY(THIS.this_oBusinessObject.this_cMensagemErro), ;
                            "Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Localizada !!", ;
                            THIS.this_oBusinessObject.this_cMensagemErro), ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                CATCH TO loc_oErro
                    MsgErro("Falha ao consultar a opera" + CHR(231) + CHR(227) + "o: " + ;
                        loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, "Erro")
                ENDTRY
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PopularArvore - Desenha os nos a partir dos cursores ja carregados pelo
    * BO (cursor_4c_Cab = SigMvCab, cursor_4c_Itens = SigMvItn). Separado de
    * CarregarDados para que a consulta continue valendo mesmo quando o
    * controle ActiveX da arvore nao esta disponivel na estacao.
    *==========================================================================
    PROTECTED PROCEDURE PopularArvore(par_cEmpDopNums)
        LOCAL loc_oErro, loc_nNo, loc_cTexto, loc_nIconeCab, loc_cProduto

        IF THIS.ArvoreDisponivel()
            THIS.PrepararArvore()

            TRY
                IF USED("cursor_4c_Cab")
                    SELECT cursor_4c_Cab
                    GO TOP

                    *-- Iif(crSigMvCab.ChkPagos, 3, 1) do legado. A coluna bit
                    *-- chega ora Logico ora Numerico conforme o driver, por
                    *-- isso le-se a property ja normalizada pelo BO (#13).
                    loc_nIconeCab = IIF(THIS.this_oBusinessObject.this_lChkPagos, 3, 1)

                    loc_cTexto = ALLTRIM(TratarNulo(cursor_4c_Cab.Emps, "")) + " - " + ;
                        ALLTRIM(TratarNulo(cursor_4c_Cab.Dopes, "")) + " - " + ;
                        ALLTRIM(TRANSFORM(TratarNulo(cursor_4c_Cab.Numes, 0), "999999")) + " - " + ;
                        ALLTRIM(TratarNulo(cursor_4c_Cab.Notas, "")) + " - " + ;
                        DTOC(ConverterParaData(cursor_4c_Cab.Datas)) + " - " + ;
                        ALLTRIM(TratarNulo(cursor_4c_Cab.Usuars, "")) + " - " + ;
                        DTOC(ConverterParaData(cursor_4c_Cab.DtAlts)) + " - " + ;
                        ALLTRIM(TratarNulo(cursor_4c_Cab.Usuals, ""))

                    WITH THIS.obj_4c_TreeView
                        loc_nNo = .AddPictureNode(loc_cTexto, 0, 1, loc_nIconeCab, 0, 0)
                        .NodeHeader(loc_nNo)     = .T.
                        .NodeExpanded(loc_nNo)   = .T.
                        .NodeShowChecks(loc_nNo) = .F.
                        .NodeFontBold(loc_nNo)   = 2
                        .NodeCargo(loc_nNo)      = ALLTRIM(TratarNulo(par_cEmpDopNums, ""))
                    ENDWITH
                ENDIF

                IF USED("cursor_4c_Itens")
                    SELECT cursor_4c_Itens
                    GO TOP

                    SCAN
                        loc_cProduto = ALLTRIM(TratarNulo(cursor_4c_Itens.cPros, ""))

                        loc_cTexto = loc_cProduto + " - " + ;
                            ALLTRIM(TratarNulo(cursor_4c_Itens.dPros, "")) + " - Qtde : " + ;
                            ALLTRIM(TRANSFORM(TratarNulo(cursor_4c_Itens.Qtds, 0), "999,999.99"))

                        WITH THIS.obj_4c_TreeView
                            loc_nNo = .AddPictureNode(loc_cTexto, 0, 2, 2, 0, 0)
                            .NodeHeader(loc_nNo)     = .F.
                            .NodeExpanded(loc_nNo)   = .F.
                            .NodeShowChecks(loc_nNo) = .F.
                            .NodeFontBold(loc_nNo)   = 1
                            .NodeCargo(loc_nNo)      = "PRODUTO"
                        ENDWITH

                        *-- ThisForm.SubNivel(3,...)/HINivel(3,...) do fim de
                        *-- cada iteracao do Scan crSigMvItn no maketree legado
                        *-- (niveis 3+ - baixas de estoque/producao do produto).
                        *-- Cada chamada troca a work area corrente (SQLEXEC
                        *-- interno do BO) - reselecionar cursor_4c_Itens antes
                        *-- do SKIP implicito do SCAN, senao o loop avanca em
                        *-- OUTRO cursor.
                        THIS.SubNivel(3, par_cEmpDopNums, loc_cProduto)
                        IF USED("cursor_4c_Itens")
                            SELECT cursor_4c_Itens
                        ENDIF

                        THIS.HiNivel(3, par_cEmpDopNums, loc_cProduto)
                        IF USED("cursor_4c_Itens")
                            SELECT cursor_4c_Itens
                        ENDIF
                    ENDSCAN
                ENDIF

                *-- ThisForm.SubNivel(2,...)/HiNivel(2,...) do fim do maketree
                *-- legado - roda incondicional (com ou sem itens), FORA do
                *-- IF USED("cursor_4c_Itens") acima.
                THIS.SubNivel(2, par_cEmpDopNums, .F.)
                THIS.HiNivel(2, par_cEmpDopNums, .F.)

                *-- loTree1.ReDraw(.t.) + loTree1.Refresh do fim do MakeTree
                WITH THIS.obj_4c_TreeView
                    .ReDraw(.T.)
                    .Refresh()
                ENDWITH
            CATCH TO loc_oErro
                MsgErro("Falha ao montar a " + CHR(225) + "rvore: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * HiNivel - equivalente ao PROCEDURE hinivel do legado: historico de
    * baixa/producao (SigMvPec+SigMvCab+SigMvItn UNION ALL SigOpDev+SigMvCab+
    * SigMvItn) de um EmpDopNums, desenhando um no "(-)" por linha nova
    * (dedup em this_aHistorico - equivalente a ThisForm.pcEmpDopNums) e
    * recursando em SubNivel/HiNivel do proximo nivel enquanto
    * this_nNiveis <= 50 (mesmo teto do legado) e o EmpDopNums nao for
    * "NF - TRF SIMBOLICA" (fim de cadeia no legado).
    *
    * Cada chamada a BO/SQLEXEC troca a work area corrente - por isso o
    * cursor do nivel eh re-selecionado apos qualquer chamada aninhada, antes
    * de continuar a leitura da linha ou de deixar o SCAN avancar (mesma
    * disciplina do "Select &lcSqlFile." espalhado pelo hinivel legado).
    *==========================================================================
    PROTECTED PROCEDURE HiNivel(par_nNivel, par_cEmpDopNums, par_cCPros)
        LOCAL loc_cCursorHi, loc_nCodigos, loc_cEmpSubns, loc_nCodOpe, loc_cDopesOpe
        LOCAL loc_nNumes, loc_cEmpDopFilho, loc_cChaveDedup, loc_nPos
        LOCAL loc_cCursorDet, loc_cTexto, loc_cDtt, loc_nNo, loc_lChkPagos
        LOCAL loc_lTemProduto, loc_oErro

        IF !THIS.ArvoreDisponivel()
            RETURN
        ENDIF

        loc_lTemProduto = (VARTYPE(par_cCPros) = "C" AND !EMPTY(par_cCPros))

        TRY
            loc_cCursorHi = THIS.this_oBusinessObject.ObterHistoricoNivel(par_nNivel, par_cEmpDopNums, par_cCPros)

            IF EMPTY(loc_cCursorHi) OR !USED(loc_cCursorHi)
                RETURN
            ENDIF

            SELECT (loc_cCursorHi)
            SCAN
                loc_nCodigos  = Codigos
                loc_cEmpSubns = ALLTRIM(TratarNulo(EmpSubns, ""))

                loc_nCodOpe   = INT(loc_nCodigos / 1000000)
                loc_cDopesOpe = THIS.this_oBusinessObject.ObterDopesPorCodigo(loc_nCodOpe)
                loc_nNumes    = VAL(RIGHT(ALLTRIM(TRANSFORM(loc_nCodigos)), 6))

                loc_cEmpDopFilho = loc_cEmpSubns + PADR(loc_cDopesOpe, 20) + STR(loc_nNumes, 6)
                loc_cChaveDedup  = par_cEmpDopNums + loc_cEmpDopFilho + IIF(loc_lTemProduto, par_cCPros, SPACE(14))

                IF USED(loc_cCursorHi)
                    SELECT (loc_cCursorHi)
                ENDIF

                loc_nPos = ASCAN(THIS.this_aHistorico, loc_cChaveDedup)

                IF loc_nPos = 0 AND !(loc_cEmpDopFilho == THIS.this_aHistorico[1, 1])
                    DIMENSION THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1) + 1, 2]
                    THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1), 1] = loc_cChaveDedup
                    THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1), 2] = par_nNivel

                    loc_cCursorDet = THIS.this_oBusinessObject.ObterDetalheNivel(loc_cEmpDopFilho, par_nNivel, par_cCPros)

                    IF !EMPTY(loc_cCursorDet) AND USED(loc_cCursorDet) AND !EOF(loc_cCursorDet)
                        SELECT (loc_cCursorDet)

                        loc_cDtt = THIS.ObterTextoDataHora(Datas) + " (" + THIS.ObterTextoHora(Datars) + ")"
                        loc_lChkPagos = TratarNulo(ChkPagos, .F.)

                        loc_cTexto = "(-) " + ;
                            ALLTRIM(TratarNulo(Emps, "")) + " - " + ;
                            ALLTRIM(TratarNulo(Dopes, "")) + " - " + ;
                            ALLTRIM(TRANSFORM(TratarNulo(Numes, 0), "999999")) + " - " + ;
                            ALLTRIM(TratarNulo(Notas, "")) + " - " + ;
                            loc_cDtt + " - " + ;
                            ALLTRIM(TratarNulo(Usuars, "")) + ;
                            IIF(!ISNULL(Qtds), " - Qtde : " + ALLTRIM(TRANSFORM(TratarNulo(Qtds, 0), "999,999.99")), "") + " - " + ;
                            DTOC(ConverterParaData(TratarNulo(DtAlts, {}))) + " - " + ;
                            ALLTRIM(TratarNulo(Usuals, ""))

                        IF THIS.ArvoreDisponivel()
                            WITH THIS.obj_4c_TreeView
                                loc_nNo = .AddPictureNode(loc_cTexto, 0, par_nNivel, IIF(loc_lChkPagos, 3, 1), 0, 0)
                                .NodeHeader(loc_nNo)     = .F.
                                .NodeExpanded(loc_nNo)   = .F.
                                .NodeShowChecks(loc_nNo) = .F.
                                .NodeFontBold(loc_nNo)   = 1
                                .NodeCargo(loc_nNo)      = loc_cEmpDopFilho
                            ENDWITH
                        ENDIF

                        IF UPPER(SUBSTR(loc_cEmpDopFilho, 4, 20)) != "NF - TRF SIMBOLICA" AND THIS.this_nNiveis <= 50
                            THIS.this_nNiveis = THIS.this_nNiveis + 1
                            THIS.SubNivel(par_nNivel + 1, loc_cEmpDopFilho, par_cCPros)
                            THIS.HiNivel(par_nNivel + 1, loc_cEmpDopFilho, par_cCPros)
                            THIS.this_nNiveis = THIS.this_nNiveis - 1
                        ENDIF
                    ENDIF
                ENDIF

                IF USED(loc_cCursorHi)
                    SELECT (loc_cCursorHi)
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro("Falha ao montar hist" + CHR(243) + "rico (n" + CHR(237) + ;
                "vel " + TRANSFORM(par_nNivel) + "): " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * SubNivel - equivalente ao PROCEDURE subnivel do legado: mesma familia
    * de consulta de HiNivel, mas filtrando pelo CODIGO da operacao
    * (nDopes*1000000 + numero) em vez do EmpDopNums, desenhando um no "(+)"
    * por linha nova. Diferente de HiNivel, os dados do no vem direto da
    * linha do cursor (sem uma segunda consulta de detalhe).
    *==========================================================================
    PROTECTED PROCEDURE SubNivel(par_nNivel, par_cEmpDopNums, par_cCPros)
        LOCAL loc_cCursorSub, loc_nCodOpe, loc_nCodigo, loc_cChaveDedup, loc_nPos
        LOCAL loc_cTexto, loc_cDtt, loc_nNo, loc_lChkPagos, loc_cEmpDopFilho
        LOCAL loc_lTemProduto, loc_oErro

        IF !THIS.ArvoreDisponivel()
            RETURN
        ENDIF

        loc_lTemProduto = (VARTYPE(par_cCPros) = "C" AND !EMPTY(par_cCPros))

        TRY
            loc_nCodOpe = THIS.this_oBusinessObject.ObterCodigoOperacao(SUBSTR(par_cEmpDopNums, 4, 20))
            IF loc_nCodOpe < 0
                RETURN
            ENDIF
            loc_nCodigo = loc_nCodOpe * 1000000 + VAL(RIGHT(par_cEmpDopNums, 6))

            loc_cCursorSub = THIS.this_oBusinessObject.ObterSubNivel(par_nNivel, par_cEmpDopNums, par_cCPros)

            IF EMPTY(loc_cCursorSub) OR !USED(loc_cCursorSub)
                RETURN
            ENDIF

            SELECT (loc_cCursorSub)
            SCAN
                loc_cEmpDopFilho = ALLTRIM(TratarNulo(EmpDopNums, ""))
                loc_cChaveDedup  = ALLTRIM(TRANSFORM(loc_nCodigo)) + loc_cEmpDopFilho + ;
                    IIF(loc_lTemProduto, par_cCPros, SPACE(6))

                loc_nPos = ASCAN(THIS.this_aHistorico, loc_cChaveDedup)

                IF loc_nPos = 0 AND !(loc_cEmpDopFilho == THIS.this_aHistorico[1, 1])
                    DIMENSION THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1) + 1, 2]
                    THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1), 1] = loc_cChaveDedup
                    THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1), 2] = par_nNivel

                    loc_cDtt = THIS.ObterTextoDataHora(Datas) + " (" + THIS.ObterTextoHora(Datars) + ")"
                    loc_lChkPagos = TratarNulo(ChkPagos, .F.)

                    loc_cTexto = "(+) " + ;
                        ALLTRIM(TratarNulo(Emps, "")) + " - " + ;
                        ALLTRIM(TratarNulo(Dopes, "")) + " - " + ;
                        ALLTRIM(TRANSFORM(TratarNulo(Numes, 0), "999999")) + " - " + ;
                        ALLTRIM(TratarNulo(Notas, "")) + " - " + ;
                        loc_cDtt + " - " + ;
                        ALLTRIM(TratarNulo(Usuars, "")) + ;
                        IIF(!ISNULL(Qtds), " - Qtde : " + ALLTRIM(TRANSFORM(TratarNulo(Qtds, 0), "999,999.99")), "") + " - " + ;
                        DTOC(ConverterParaData(TratarNulo(DtAlts, {}))) + " - " + ;
                        ALLTRIM(TratarNulo(Usuals, ""))

                    IF THIS.ArvoreDisponivel()
                        WITH THIS.obj_4c_TreeView
                            loc_nNo = .AddPictureNode(loc_cTexto, 0, par_nNivel, IIF(loc_lChkPagos, 3, 1), 0, 0)
                            .NodeHeader(loc_nNo)     = .F.
                            .NodeExpanded(loc_nNo)   = .F.
                            .NodeShowChecks(loc_nNo) = .F.
                            .NodeFontBold(loc_nNo)   = 1
                            .NodeCargo(loc_nNo)      = loc_cEmpDopFilho
                        ENDWITH
                    ENDIF

                    IF UPPER(SUBSTR(loc_cEmpDopFilho, 4, 20)) != "NF - TRF SIMBOLICA" AND THIS.this_nNiveis <= 50
                        THIS.this_nNiveis = THIS.this_nNiveis + 1

                        IF USED(loc_cCursorSub)
                            SELECT (loc_cCursorSub)
                        ENDIF
                        THIS.SubNivel(par_nNivel + 1, loc_cEmpDopFilho, par_cCPros)

                        IF USED(loc_cCursorSub)
                            SELECT (loc_cCursorSub)
                        ENDIF
                        THIS.HiNivel(par_nNivel + 1, loc_cEmpDopFilho, par_cCPros)

                        THIS.this_nNiveis = THIS.this_nNiveis - 1
                    ENDIF
                ENDIF

                IF USED(loc_cCursorSub)
                    SELECT (loc_cCursorSub)
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro("Falha ao montar sub-n" + CHR(237) + "vel (n" + CHR(237) + ;
                "vel " + TRANSFORM(par_nNivel) + "): " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * NoHiPro - equivalente ao PROCEDURE nohipro do legado: baixas de
    * estoque/producao ligadas ao CODIGO (nDopes*1000000+numero) do
    * EmpDopNums informado, com saldo agregado zero (BO.ObterNoHiPro/
    * DeduplicarSaldo). Cada linha nova (dedup em this_aOperacoes -
    * equivalente a ThisForm.paOperacoes) recursa em NoProd/NoHiPro e, fora
    * do nivel 3, tambem em SubNivel/HiNivel do proximo nivel.
    *
    * DESVIO DELIBERADO do dump legado, registrado aqui (regra CLAUDE.md
    * #28/#31 - divergencia de comportamento entre migrado e legado exige
    * comentario explicito): o dump tem "If Ascan(ThisForm.paOperacoes,
    * EmpDopNums)" SEM "= 0" nem "<> 0" (ao contrario do NoProd logo abaixo,
    * que usa corretamente "= 0"). Ascan devolve 0 (falso) na PRIMEIRA vez
    * que um EmpDopNums aparece - a leitura literal do dump faria este bloco
    * NUNCA desenhar nenhum no na primeira ocorrencia (a checagem so fica
    * verdadeira depois que o item JA foi adicionado por outro caminho), ou
    * seja, o ramo NoHiPro ficaria estruturalmente morto (nunca dispara na
    * entrada natural do dedup). Tratado como erro de digitacao (falta do
    * "= 0", igual ao par simetrico em NoProd) e normalizado para "= 0" -
    * NAO reproduzir o "bug" faria a funcionalidade nunca aparecer, o que
    * contraria a regra do projeto de paridade funcional completa.
    *==========================================================================
    PROTECTED PROCEDURE NoHiPro(par_nNivel, par_cEmps, par_cEmpDopNums, par_cCPros)
        LOCAL loc_cCursorDedup, loc_cEDN, loc_cEmpSubns, loc_nCodigos, loc_cCursorCab
        LOCAL loc_cDados, loc_cDados1, loc_nNo, loc_lChkPagos, loc_oErro

        IF !THIS.ArvoreDisponivel()
            RETURN
        ENDIF

        TRY
            loc_cCursorDedup = THIS.this_oBusinessObject.ObterNoHiPro(par_nNivel, par_cEmps, par_cEmpDopNums, par_cCPros)

            IF EMPTY(loc_cCursorDedup) OR !USED(loc_cCursorDedup)
                RETURN
            ENDIF

            SELECT (loc_cCursorDedup)
            GO TOP
            loc_cDados1 = "Inicio"

            IF !EOF(loc_cCursorDedup)
                SCAN
                    loc_cEDN      = ALLTRIM(TratarNulo(EmpDopNums, ""))
                    loc_cEmpSubns = ALLTRIM(TratarNulo(EmpSubns, ""))
                    loc_nCodigos  = Codigos
                    loc_lChkPagos = TratarNulo(ChkPagos, .F.)

                    IF ASCAN(THIS.this_aOperacoes, loc_cEDN) = 0
                        IF ALEN(THIS.this_aOperacoes, 1) = 1 AND EMPTY(THIS.this_aOperacoes[1])
                            THIS.this_aOperacoes[1] = loc_cEDN
                        ELSE
                            DIMENSION THIS.this_aOperacoes[ALEN(THIS.this_aOperacoes, 1) + 1]
                            THIS.this_aOperacoes[ALEN(THIS.this_aOperacoes, 1)] = loc_cEDN
                        ENDIF

                        loc_cDados = ALLTRIM(TratarNulo(Emps, "")) + " - " + ;
                            ALLTRIM(TratarNulo(Dopes, "")) + " - " + ;
                            ALLTRIM(TRANSFORM(TratarNulo(Numes, 0), "999999")) + " - " + ;
                            ALLTRIM(TratarNulo(Notas, "")) + " - " + ;
                            DTOC(ConverterParaData(TratarNulo(Datas, {}))) + " - "

                        loc_cCursorCab = THIS.this_oBusinessObject.ObterCabecalhoOperacao(loc_cEDN)
                        IF !EMPTY(loc_cCursorCab) AND USED(loc_cCursorCab) AND !EOF(loc_cCursorCab)
                            SELECT (loc_cCursorCab)
                            loc_cDados = loc_cDados + ALLTRIM(TratarNulo(Usuars, "")) + " - " + ;
                                DTOC(ConverterParaData(TratarNulo(DtAlts, {}))) + " - " + ;
                                ALLTRIM(TratarNulo(Usuals, ""))
                        ENDIF

                        IF USED(loc_cCursorDedup)
                            SELECT (loc_cCursorDedup)
                        ENDIF

                        IF loc_cDados != loc_cDados1
                            IF THIS.ArvoreDisponivel()
                                WITH THIS.obj_4c_TreeView
                                    loc_nNo = .AddPictureNode(loc_cDados, 0, par_nNivel, IIF(loc_lChkPagos, 3, 1), 0, 0)
                                    .NodeHeader(loc_nNo)     = .F.
                                    .NodeExpanded(loc_nNo)   = .F.
                                    .NodeShowChecks(loc_nNo) = .F.
                                    .NodeFontBold(loc_nNo)   = 1
                                    .NodeCargo(loc_nNo)      = loc_cEDN
                                ENDWITH
                            ENDIF
                            loc_cDados1 = loc_cDados
                        ENDIF

                        THIS.NoHiPro(par_nNivel + 1, loc_cEmpSubns, loc_cEDN, par_cCPros)
                        IF USED(loc_cCursorDedup)
                            SELECT (loc_cCursorDedup)
                        ENDIF

                        IF par_nNivel != 3
                            THIS.SubNivel(par_nNivel + 1, loc_cEDN, par_cCPros)
                            IF USED(loc_cCursorDedup)
                                SELECT (loc_cCursorDedup)
                            ENDIF

                            THIS.HiNivel(par_nNivel + 1, loc_cEDN, par_cCPros)
                            IF USED(loc_cCursorDedup)
                                SELECT (loc_cCursorDedup)
                            ENDIF

                            THIS.NoProd(par_nNivel + 1, loc_cEmpSubns, loc_nCodigos, par_cCPros)
                        ENDIF
                    ENDIF

                    IF USED(loc_cCursorDedup)
                        SELECT (loc_cCursorDedup)
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Falha ao montar baixas (n" + CHR(237) + "vel " + ;
                TRANSFORM(par_nNivel) + "): " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * NoProd - equivalente ao PROCEDURE noprod do legado: mesma logica de
    * NoHiPro, mas filtrando pelo EmpDopNums reconstruido a partir do codigo
    * do produto/operacao (par_nCodigo). Dedup em this_aOperacoes com
    * "= 0" - igual ao dump original (o par simetrico correto de NoHiPro).
    *
    * DESVIO DELIBERADO do dump legado, registrado aqui (mesma regra do
    * NoHiPro acima): a chamada final do bloco "pnNivel <> 3" do dump
    * ("ThisForm.HINivel(pnNivel+1, EmpSubns, Int(codigos/1000000),
    * Val(Right(Alltrim(Str(Codigos)),6)), pccPros)") passa 5 argumentos para
    * um metodo declarado com 3 parametros (par_nNivel, par_cEmpDopNums,
    * par_cCPros) - o 2o argumento (EmpSubns, so 3 caracteres) cairia em
    * par_cEmpDopNums no lugar de um EmpDopNums completo, e o 3o (um NUMERO)
    * cairia em par_cCPros no lugar do produto - os 2 argumentos extras
    * seriam descartados em silencio pelo VFP (chamada com mais argumentos
    * que parametros nao eh erro). Efeito prático: SUBSTR(par_cEmpDopNums,
    * 4,20) sobre uma string de 3 chars devolve "", ObterDopesPorCodigo(0)
    * nao acha nada - o ramo inteiro vira no-op silencioso. Tratado como
    * copia-e-cola malfeita (o SubNivel logo acima, no MESMO bloco, ja chama
    * com os 3 argumentos corretos: par_nNivel+1, loc_cEDN, par_cCPros) e
    * normalizado para a mesma assinatura de 3 argumentos - mesma razao do
    * desvio documentado em NoHiPro (funcionalidade completa > bug replicado
    * que so produz no-op silencioso).
    *==========================================================================
    PROTECTED PROCEDURE NoProd(par_nNivel, par_cEmps, par_nCodigo, par_cCPros)
        LOCAL loc_cCursorDedup, loc_cEDN, loc_cEmpSubns, loc_nCodigos, loc_cCursorCab
        LOCAL loc_cDados, loc_cDados1, loc_nNo, loc_lChkPagos, loc_oErro

        IF !THIS.ArvoreDisponivel()
            RETURN
        ENDIF

        TRY
            loc_cCursorDedup = THIS.this_oBusinessObject.ObterNoProd(par_nNivel, par_cEmps, par_nCodigo, par_cCPros)

            IF EMPTY(loc_cCursorDedup) OR !USED(loc_cCursorDedup)
                RETURN
            ENDIF

            SELECT (loc_cCursorDedup)
            GO TOP
            loc_cDados1 = "Inicio"

            IF !EOF(loc_cCursorDedup)
                SCAN
                    loc_cEDN      = ALLTRIM(TratarNulo(EmpDopNums, ""))
                    loc_cEmpSubns = ALLTRIM(TratarNulo(EmpSubns, ""))
                    loc_nCodigos  = Codigos
                    loc_lChkPagos = TratarNulo(ChkPagos, .F.)

                    IF ASCAN(THIS.this_aOperacoes, loc_cEDN) = 0
                        IF ALEN(THIS.this_aOperacoes, 1) = 1 AND EMPTY(THIS.this_aOperacoes[1])
                            THIS.this_aOperacoes[1] = loc_cEDN
                        ELSE
                            DIMENSION THIS.this_aOperacoes[ALEN(THIS.this_aOperacoes, 1) + 1]
                            THIS.this_aOperacoes[ALEN(THIS.this_aOperacoes, 1)] = loc_cEDN
                        ENDIF

                        loc_cDados = ALLTRIM(TratarNulo(Emps, "")) + " - " + ;
                            ALLTRIM(TratarNulo(Dopes, "")) + " - " + ;
                            ALLTRIM(TRANSFORM(TratarNulo(Numes, 0), "999999")) + " - " + ;
                            ALLTRIM(TratarNulo(Notas, "")) + " - " + ;
                            DTOC(ConverterParaData(TratarNulo(Datas, {}))) + " - "

                        loc_cCursorCab = THIS.this_oBusinessObject.ObterCabecalhoOperacao(loc_cEDN)
                        IF !EMPTY(loc_cCursorCab) AND USED(loc_cCursorCab) AND !EOF(loc_cCursorCab)
                            SELECT (loc_cCursorCab)
                            loc_cDados = loc_cDados + ALLTRIM(TratarNulo(Usuars, "")) + " - " + ;
                                DTOC(ConverterParaData(TratarNulo(DtAlts, {}))) + " - " + ;
                                ALLTRIM(TratarNulo(Usuals, ""))
                        ENDIF

                        IF USED(loc_cCursorDedup)
                            SELECT (loc_cCursorDedup)
                        ENDIF

                        IF loc_cDados != loc_cDados1
                            IF THIS.ArvoreDisponivel()
                                WITH THIS.obj_4c_TreeView
                                    loc_nNo = .AddPictureNode(loc_cDados, 0, par_nNivel, IIF(loc_lChkPagos, 3, 1), 0, 0)
                                    .NodeHeader(loc_nNo)     = .F.
                                    .NodeExpanded(loc_nNo)   = .F.
                                    .NodeShowChecks(loc_nNo) = .F.
                                    .NodeFontBold(loc_nNo)   = 1
                                    .NodeCargo(loc_nNo)      = loc_cEDN
                                ENDWITH
                            ENDIF
                            loc_cDados1 = loc_cDados
                        ENDIF

                        THIS.NoProd(par_nNivel + 1, loc_cEmpSubns, loc_nCodigos, par_cCPros)
                        IF USED(loc_cCursorDedup)
                            SELECT (loc_cCursorDedup)
                        ENDIF

                        THIS.NoHiPro(par_nNivel + 1, loc_cEmpSubns, loc_cEDN, par_cCPros)
                        IF USED(loc_cCursorDedup)
                            SELECT (loc_cCursorDedup)
                        ENDIF

                        IF par_nNivel != 3
                            THIS.SubNivel(par_nNivel + 1, loc_cEDN, par_cCPros)
                            IF USED(loc_cCursorDedup)
                                SELECT (loc_cCursorDedup)
                            ENDIF

                            THIS.HiNivel(par_nNivel + 1, loc_cEDN, par_cCPros)
                        ENDIF
                    ENDIF

                    IF USED(loc_cCursorDedup)
                        SELECT (loc_cCursorDedup)
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Falha ao montar produtos (n" + CHR(237) + "vel " + ;
                TRANSFORM(par_nNivel) + "): " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarListaPeriodo - Metodo de carga por periodo desta tela
    * (equivalente ao MakeList do legado). Lista, no nivel 1 da arvore, as
    * operacoes de uma Empresa+Operacao dentro do intervalo GetDtI/GetDtF -
    * usado quando o usuario nao informa o Numero e sim um periodo.
    *==========================================================================
    PROCEDURE CarregarListaPeriodo()
        LOCAL loc_lSucesso, loc_cEmps, loc_cDopes, loc_dDtI, loc_dDtF

        loc_lSucesso = .F.

        *-- Mesma fonte unica de CarregarDados: FormParaBO transfere o filtro
        *-- (e reporta BO ausente), aqui so se le o que ele gravou.
        IF THIS.FormParaBO()
            WITH THIS.this_oBusinessObject
                loc_cEmps  = ALLTRIM(.this_cEmps)
                loc_cDopes = ALLTRIM(.this_cDopes)
                loc_dDtI   = .this_dDtI
                loc_dDtF   = .this_dDtF
            ENDWITH

            IF THIS.this_oBusinessObject.BuscarPorPeriodo(loc_cEmps, loc_cDopes, ;
                    loc_dDtI, loc_dDtF)
                THIS.PopularArvoreLista()
                THIS.this_nNodeExp = 0
                loc_lSucesso = .T.
            ELSE
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PopularArvoreLista - Desenha os nos de nivel 1 a partir de
    * cursor_4c_Lista (equivalente ao Scan de crSigMvCab no MakeList legado).
    * NodeCargo usa o MESMO formato fixo (Emps(3)+Dopes(20)+Numes(6)) do
    * cursor_4c_Cab em PopularArvore - o legado grava NodeCargo SEM PADR aqui
    * (Emps+Dopes+Transform(Numes)), mas a leitura (Command4/Command6/
    * btnOperacao/BtnOficina) sempre faz Left(.,3)/Substr(.,4,20)/Substr(.,24)
    * assumindo largura fixa; manter o formato fixo evita quebrar a navegacao
    * quando o drill comeca por uma linha da LISTA em vez da ARVORE.
    *==========================================================================
    PROTECTED PROCEDURE PopularArvoreLista()
        LOCAL loc_oErro, loc_nNo, loc_cTexto, loc_nIcone

        IF THIS.ArvoreDisponivel()
            THIS.PrepararArvore()

            TRY
                IF USED("cursor_4c_Lista")
                    SELECT cursor_4c_Lista
                    GO TOP

                    SCAN
                        loc_nIcone = IIF(cursor_4c_Lista.ChkPagos, 3, 1)

                        loc_cTexto = ALLTRIM(TratarNulo(cursor_4c_Lista.Emps, "")) + " - " + ;
                            ALLTRIM(TratarNulo(cursor_4c_Lista.Dopes, "")) + " - " + ;
                            ALLTRIM(TRANSFORM(TratarNulo(cursor_4c_Lista.Numes, 0), "999999")) + " - " + ;
                            ALLTRIM(TratarNulo(cursor_4c_Lista.Notas, "")) + " - " + ;
                            DTOC(ConverterParaData(cursor_4c_Lista.Datas)) + ;
                            IIF(!ISNULL(cursor_4c_Lista.Qtds), " - Qtde : " + ;
                                ALLTRIM(TRANSFORM(TratarNulo(cursor_4c_Lista.Qtds, 0), "999,999.99")), "")

                        WITH THIS.obj_4c_TreeView
                            loc_nNo = .AddPictureNode(loc_cTexto, 0, 1, loc_nIcone, 0, 0)
                            .NodeHeader(loc_nNo)     = .F.
                            .NodeExpanded(loc_nNo)   = .F.
                            .NodeShowChecks(loc_nNo) = .F.
                            .NodeFontBold(loc_nNo)   = 1
                            .NodeCargo(loc_nNo)      = PADR(ALLTRIM(TratarNulo(cursor_4c_Lista.Emps, "")), 3) + ;
                                PADR(ALLTRIM(TratarNulo(cursor_4c_Lista.Dopes, "")), 20) + ;
                                STR(TratarNulo(cursor_4c_Lista.Numes, 0), 6)
                        ENDWITH
                    ENDSCAN
                ENDIF

                WITH THIS.obj_4c_TreeView
                    .ReDraw(.T.)
                    .Refresh()
                ENDWITH
            CATCH TO loc_oErro
                MsgErro("Falha ao montar a lista de opera" + CHR(231) + CHR(245) + "es: " + ;
                    loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * ObterCargoAtual - Le o NodeCargo do no marcado por this_nIndiceClicado
    * (ThisForm.pldblclick do legado, atualizado por TreeViewNodeClick).
    *==========================================================================
    PROTECTED FUNCTION ObterCargoAtual()
        LOCAL loc_cCargo, loc_oErro

        loc_cCargo = ""

        IF THIS.ArvoreDisponivel()
            TRY
                loc_cCargo = ALLTRIM(TratarNulo(THIS.obj_4c_TreeView.NodeCargo(THIS.this_nIndiceClicado), ""))
            CATCH TO loc_oErro
                MsgErro("Falha ao ler o n" + CHR(243) + " selecionado: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN loc_cCargo
    ENDFUNC

    *==========================================================================
    * MontarChaveAtual - Padr(GetCEmp,3)+Padr(GetDopes,20)+Str(GetNumes,6) do
    * legado (usado pelo botao Proximo para empilhar a posicao atual antes de
    * avancar - equivalente a "ThisForm.GetcEmp.Value + ThisForm.GetDopes.
    * Value + Str(ThisForm.GetNumes.Value,6)" do Command6.Click).
    *==========================================================================
    PROTECTED FUNCTION MontarChaveAtual()
        RETURN PADR(ALLTRIM(TRANSFORM(THIS.txt_4c_CEmp.Value)), 3) + ;
               PADR(ALLTRIM(TRANSFORM(THIS.txt_4c_Dopes.Value)), 20) + ;
               STR(THIS.txt_4c_Numes.Value, 6)
    ENDFUNC

    *==========================================================================
    * TreeViewGotFocus - equivalente ao GotFocus do TreeView legado: sem
    * Empresa preenchida, nao deixa o foco parado na arvore.
    *==========================================================================
    PROCEDURE TreeViewGotFocus
        IF EMPTY(THIS.txt_4c_CEmp.Value)
            KEYBOARD "{TAB}"
        ENDIF
    ENDPROC

    *==========================================================================
    * TreeViewKeyPress - equivalente ao KeyPress do TreeView legado (ActiveX,
    * assinatura LPARAMETERS keyascii - so 1 parametro, diferente do KeyPress
    * nativo de TextBox).
    *==========================================================================
    PROCEDURE TreeViewKeyPress
        LPARAMETERS par_nKeyAscii

        IF par_nKeyAscii = 27
            RELEASE WINDOWS
        ENDIF
    ENDPROC

    *==========================================================================
    * TreeViewNodeClick - equivalente ao NodeClick do TreeView legado
    * (LPARAMETERS nindex, ncolumn -> ThisForm.plDblClick = nIndex). Guarda o
    * indice do no marcado para os botoes de navegacao (Proximo/Movimento/
    * Producao) lerem via ObterCargoAtual.
    *==========================================================================
    PROCEDURE TreeViewNodeClick
        LPARAMETERS par_nIndex, par_nColumn

        THIS.this_nIndiceClicado = par_nIndex
    ENDPROC

    *==========================================================================
    * BtnExpandirClick - equivalente a Command1.Click: expande todos os nos
    * do proximo nivel de profundidade.
    *==========================================================================
    PROCEDURE BtnExpandirClick
        LOCAL loc_nNo, loc_lExpandiu, loc_oErro

        IF !THIS.ArvoreDisponivel()
            RETURN
        ENDIF

        loc_lExpandiu = .F.

        TRY
            WITH THIS.obj_4c_TreeView
                FOR loc_nNo = 0 TO .ListCount - 1
                    IF THIS.this_nNodeExp + 1 = .NodeLevel(loc_nNo)
                        .NodeExpanded(loc_nNo) = .T.
                        loc_lExpandiu = .T.
                    ENDIF
                ENDFOR
            ENDWITH

            IF loc_lExpandiu
                THIS.this_nNodeExp = THIS.this_nNodeExp + 1
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Falha ao expandir a " + CHR(225) + "rvore: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnRetrairClick - equivalente a Command2.Click: recolhe o nivel de
    * profundidade corrente.
    *==========================================================================
    PROCEDURE BtnRetrairClick
        LOCAL loc_nNo, loc_oErro

        IF !THIS.ArvoreDisponivel()
            RETURN
        ENDIF

        TRY
            IF THIS.this_nNodeExp > 0
                WITH THIS.obj_4c_TreeView
                    FOR loc_nNo = 0 TO .ListCount - 1
                        IF THIS.this_nNodeExp = .NodeLevel(loc_nNo)
                            .NodeExpanded(loc_nNo) = .F.
                        ENDIF
                    ENDFOR
                ENDWITH
                THIS.this_nNodeExp = THIS.this_nNodeExp - 1
            ELSE
                THIS.this_nNodeExp = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Falha ao retrair a " + CHR(225) + "rvore: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - equivalente a Command3.Click ("[ESC] Sair").
    *==========================================================================
    PROCEDURE BtnEncerrarClick
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnAnteriorClick - equivalente a Command4.Click: desempilha
    * this_aEmpDopNums (paEmpDopNums) e volta a exibir a posicao anterior -
    * lista por periodo (this_lRetorno = .F. e pilha vazia) ou arvore de
    * detalhe (senao).
    *==========================================================================
    PROCEDURE BtnAnteriorClick
        LOCAL loc_nUltimo, loc_cChave

        loc_nUltimo = ALEN(THIS.this_aEmpDopNums, 1)

        IF EMPTY(THIS.this_aEmpDopNums[loc_nUltimo])
            RETURN
        ENDIF

        loc_cChave = THIS.this_aEmpDopNums[loc_nUltimo]

        *-- Left(.,3) / Substr(.,4,20) / Substr(.,24) do Command4 legado,
        *-- concentrados em DefinirFiltroPorChave (que grava no BO e reflete
        *-- na tela por BOParaForm, mantendo os dois lados coerentes).
        THIS.DefinirFiltroPorChave(loc_cChave)

        IF loc_nUltimo = 1
            THIS.this_aEmpDopNums[1] = ""
        ELSE
            DIMENSION THIS.this_aEmpDopNums[loc_nUltimo - 1]
        ENDIF

        IF EMPTY(THIS.this_aEmpDopNums[1]) AND !THIS.this_lRetorno
            THIS.txt_4c_Numes.Value = 0
            THIS.CarregarListaPeriodo()
        ELSE
            THIS.CarregarDados()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnImprimirClick - equivalente a Command5.Click ("DO FORM SigReMre WITH
    * ThisForm"). SigReMre eh outro form do legado (relatorio de movimento),
    * fora do escopo desta migracao - tenta instanciar o modulo migrado
    * (FormSIGREMRE) e avisa se ainda nao existir, em vez de estourar "Class
    * definition ... is not found".
    *==========================================================================
    PROCEDURE BtnImprimirClick
        LOCAL loc_oForm, loc_oErro

        THIS.Enabled = .F.

        TRY
            loc_oForm = CREATEOBJECT("FormSIGREMRE", THIS)
        CATCH TO loc_oErro
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            THIS.Enabled = .T.
            MsgAviso("M" + CHR(243) + "dulo de impress" + CHR(227) + "o (SigReMre) " + ;
                "ainda n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + ;
                "vel nesta vers" + CHR(227) + "o.", "Aviso")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnProximoClick - equivalente a Command6.Click: empilha a posicao atual
    * e avanca para o no marcado (drill-down manual pela arvore).
    *==========================================================================
    PROCEDURE BtnProximoClick
        LOCAL loc_cCargo

        loc_cCargo = THIS.ObterCargoAtual()

        IF loc_cCargo == "PRODUTO"
            MsgAviso("Produto", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF EMPTY(loc_cCargo)
            RETURN
        ENDIF

        IF !EMPTY(THIS.this_aEmpDopNums[1])
            DIMENSION THIS.this_aEmpDopNums[ALEN(THIS.this_aEmpDopNums, 1) + 1]
        ENDIF
        THIS.this_aEmpDopNums[ALEN(THIS.this_aEmpDopNums, 1)] = THIS.MontarChaveAtual()

        *-- Mesma decomposicao do Command6 legado, via DefinirFiltroPorChave.
        THIS.DefinirFiltroPorChave(loc_cCargo)

        THIS.CarregarDados()
        THIS.this_nIndiceClicado = 0
    ENDPROC

    *==========================================================================
    * BtnOperacaoClick - equivalente a btnOperacao.Click ("Movimento"): abre o
    * detalhe do movimento do no marcado na arvore.
    *==========================================================================
    PROCEDURE BtnOperacaoClick
        LOCAL loc_cCargo, loc_cEmps, loc_cDopes, loc_nNumes

        loc_cCargo = THIS.ObterCargoAtual()

        IF loc_cCargo == "PRODUTO"
            MsgAviso("Produto", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF EMPTY(loc_cCargo)
            RETURN
        ENDIF

        loc_cEmps  = LEFT(loc_cCargo, 3)
        loc_cDopes = SUBSTR(loc_cCargo, 4, 20)
        loc_nNumes = VAL(ALLTRIM(SUBSTR(loc_cCargo, 24)))

        IF !EMPTY(loc_cEmps) AND !EMPTY(loc_cDopes) AND loc_nNumes != 0
            THIS.AbrirFormMovimento(loc_cDopes, loc_nNumes, loc_cEmps)
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirFormMovimento - "Do Form SigMvExp with lcDopes, 'C', lnNumes,
    * lcEmps, .t." do legado. SigMvExp.SCX esta fora do escopo desta
    * migracao (task574 eh so o SIGMVMVT) - tenta o modulo migrado
    * (FormSIGMVEXP, mesma convencao <SCX> -> Form<SCX> usada neste form) e
    * avisa se ainda nao existir.
    *==========================================================================
    PROTECTED PROCEDURE AbrirFormMovimento(par_cDopes, par_nNumes, par_cEmps)
        LOCAL loc_oForm, loc_oErro

        TRY
            loc_oForm = CREATEOBJECT("FormSIGMVEXP", par_cDopes, "C", par_nNumes, par_cEmps, .T.)
        CATCH TO loc_oErro
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            MsgAviso("M" + CHR(243) + "dulo de detalhe do movimento (SigMvExp) " + ;
                "ainda n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + ;
                "vel nesta vers" + CHR(227) + "o.", "Aviso")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnOficinaClick - equivalente a BtnOficina.Click ("Producao" - Visible
    * so quando this_lAcOficina, ver AtualizarAcessoOficina/DopesKeyPress).
    *==========================================================================
    PROCEDURE BtnOficinaClick
        LOCAL loc_cCargo, loc_cEmps, loc_cDopes, loc_nNumes

        loc_cCargo = THIS.ObterCargoAtual()

        IF loc_cCargo == "PRODUTO"
            MsgAviso("Produto", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF EMPTY(loc_cCargo)
            RETURN
        ENDIF

        loc_cEmps  = LEFT(loc_cCargo, 3)
        loc_cDopes = SUBSTR(loc_cCargo, 4, 20)
        loc_nNumes = VAL(ALLTRIM(SUBSTR(loc_cCargo, 24)))

        IF !EMPTY(loc_cEmps) AND !EMPTY(loc_cDopes) AND loc_nNumes != 0
            THIS.AbrirFormOficina(loc_cDopes, loc_nNumes)
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirFormOficina - "laParam(1)=2, laParam(2)=lcDopes, laParam(3)=
    * lnNumes / Do Form SigRePPd With .F.,'SigRePPd',laParam" do legado.
    * SigRePPd esta fora do escopo desta migracao - tenta o modulo migrado
    * (FormSIGREPPD) e avisa se ainda nao existir.
    *==========================================================================
    PROTECTED PROCEDURE AbrirFormOficina(par_cDopes, par_nNumes)
        LOCAL loc_oForm, loc_oErro

        TRY
            loc_oForm = CREATEOBJECT("FormSIGREPPD", 2, par_cDopes, par_nNumes)
        CATCH TO loc_oErro
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            MsgAviso("M" + CHR(243) + "dulo de produ" + CHR(231) + CHR(227) + "o (SigRePPd) " + ;
                "ainda n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + ;
                "vel nesta vers" + CHR(227) + "o.", "Aviso")
        ENDIF
    ENDPROC

    *==========================================================================
    * ADAPTADORES DE NOME CRUD (Fase 8) -------------------------------------
    *
    * O pipeline cobra de TODO form os nomes canonicos FormParaBO/BOParaForm/
    * CarregarLista/BtnCancelarClick + um handler de acao. Este form eh uma
    * CONSULTA em arvore (ver nota no cabecalho): nao tem Page2 de Dados, nem
    * grade de listagem, nem gravacao - o legado nao tem UM SO Insert/Update/
    * Delete/TableUpdate (conferido no dump: zero ocorrencias). Os nomes
    * entram portanto como ADAPTADORES, cada um mapeado para o equivalente
    * REAL nesta tela - nenhum corpo vazio, nenhum botao inventado:
    *
    *   FormParaBO        -> leva o filtro da tela (Empresa/Operacao/Numero/
    *                        Periodo) para as properties do BO, montando a
    *                        chave EmpDopNums; fonte UNICA dessa transferencia
    *   BOParaForm        -> traz o filtro do BO de volta para os 5 campos
    *                        (usado pela navegacao Anterior/Proximo)
    *   CarregarLista     -> "recarrega a superficie consultavel": despacha
    *                        para CarregarDados (arvore de uma operacao,
    *                        MakeTree do legado) ou CarregarListaPeriodo
    *                        (lista por periodo, MakeList do legado)
    *   BtnExecutarClick  -> a acao desta tela: aplicar o filtro e consultar.
    *                        No legado ela nao mora num botao proprio - sai do
    *                        Valid de GetNumes (MakeTree) e de GetDtF
    *                        (MakeList); o handler expoe essa acao com o nome
    *                        do pipeline SEM criar botao que o SCX nao tem
    *   BtnBuscarClick    -> mesmo sentido de "Buscar": delega para o acima
    *   BtnCancelarClick  -> "descartar o que foi digitado": limpa o filtro e
    *                        a arvore, devolvendo o foco ao 1o campo
    *
    * NAO existe BtnSalvarClick: o legado eh somente-leitura, e o proprio
    * SIGMVMVTBO sobrescreve Inserir/Atualizar/ExecutarExclusao para
    * documentar essa regra. Criar um handler de gravar aqui inventaria
    * funcionalidade (violaria o PILAR 1) ou seria stub vazio (proibido pela
    * regra de completude).
    *
    * FormParaBO/BOParaForm/LimparCampos ficam PROTECTED: o FormBase ja os
    * declara assim (formbase.prg:276/280/285) e a protecao eh HERDADA -
    * declarar sem PROTECTED na subclasse nao afrouxaria nada. MEDIDO no VFP9
    * em 2026-09-25 (test_fase8_sigmvmvt.prg): chamar os tres de FORA estoura
    * "Property <NOME> is not found". Os que o harness aciona de fora
    * (CarregarLista, AjustarBotoesPorModo, HabilitarCampos, BtnCancelarClick,
    * BtnExecutarClick, BtnBuscarClick) sao PUBLIC - conferido na mesma
    * bateria, todos aceitaram chamada externa.
    *==========================================================================

    *==========================================================================
    * FormParaBO - Transfere o filtro da tela para as properties do BO.
    * Equivale ao trecho que o legado repete no inicio de MakeTree e MakeList
    * (lcEmp = ThisForm.GetcEmp.Value / lcDopes = ThisForm.GetDopes.Value /
    * lcDtIni = fDtoSQL(ThisForm.GetDtI.Value) / ... e a montagem
    * Padr(GetCEmp,3) + Padr(GetDopes,20) + Str(GetNumes,6)).
    *
    * Le pelo ObterFiltro (que cai no parametro de abertura quando o campo
    * ainda nao existe), por isso serve tambem no drill direto (Automatico).
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_nNumes

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
        ELSE
            *-- Numero pode chegar como texto quando o campo ainda nao existe
            *-- (fallback no parametro de abertura) - normaliza antes de gravar
            *-- na property numerica do BO.
            loc_nNumes = THIS.ObterFiltro("txt_4c_Numes", THIS.this_nNumesParam)
            IF VARTYPE(loc_nNumes) != "N"
                loc_nNumes = VAL(TRANSFORM(loc_nNumes))
            ENDIF

            WITH THIS.this_oBusinessObject
                .this_cEmps  = ALLTRIM(TRANSFORM(THIS.ObterFiltro("txt_4c_CEmp",  THIS.this_cEmpsParam)))
                .this_cDopes = ALLTRIM(TRANSFORM(THIS.ObterFiltro("txt_4c_Dopes", THIS.this_cDopesParam)))
                .this_nNumes = loc_nNumes

                *-- ConverterParaData normaliza DATE/DATETIME/CHAR (CLAUDE.md
                *-- #16) - o campo nasce DATE ({}) e pode voltar DATETIME.
                .this_dDtI = ConverterParaData(THIS.ObterFiltro("txt_4c_DtI", {}))
                .this_dDtF = ConverterParaData(THIS.ObterFiltro("txt_4c_DtF", {}))

                *-- Padr(Emps,3) + Padr(Dopes,20) + Str(Numes,6) do legado
                .this_cEmpDopNums = PADR(.this_cEmps, 3) + PADR(.this_cDopes, 20) + ;
                    STR(.this_nNumes, 6)

                .this_lAcOficina  = THIS.this_lAcOficina
                .this_lAutomatico = THIS.this_lAutomatico
            ENDWITH

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BOParaForm - Traz o filtro guardado no BO de volta para os 5 campos da
    * tela. Usado pela navegacao Anterior/Proximo (Command4/Command6 do
    * legado), que reposicionam o filtro a partir de um EmpDopNums empilhado.
    *
    * O periodo (DtI/DtF) so eh reescrito quando o BO REALMENTE tem periodo:
    * no drill por operacao (MakeTree) as duas properties ficam vazias, e
    * copia-las cegamente APAGARIA o periodo que o usuario digitou.
    *==========================================================================
    PROTECTED FUNCTION BOParaForm()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
        ELSE
            WITH THIS.this_oBusinessObject
                THIS.txt_4c_CEmp.Value  = ALLTRIM(.this_cEmps)
                THIS.txt_4c_Dopes.Value = ALLTRIM(.this_cDopes)
                THIS.txt_4c_Numes.Value = .this_nNumes

                IF !EMPTY(.this_dDtI) OR !EMPTY(.this_dDtF)
                    THIS.txt_4c_DtI.Value = .this_dDtI
                    THIS.txt_4c_DtF.Value = .this_dDtF
                ENDIF

                THIS.this_lAcOficina = .this_lAcOficina
            ENDWITH

            THIS.cmd_4c_BtnOficina.Visible = THIS.this_lAcOficina

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * DefinirFiltroPorChave - Reposiciona o filtro a partir de um EmpDopNums
    * ja montado (Emps(3) + Dopes(20) + Numes(6)), que eh o formato gravado em
    * this_aEmpDopNums e em NodeCargo. Concentra a decomposicao que o legado
    * repete em Command4/Command6 (Left(.,3) / Substr(.,4,20) / Substr(.,24))
    * e reflete na tela por BOParaForm, mantendo BO e campos coerentes.
    *==========================================================================
    PROTECTED PROCEDURE DefinirFiltroPorChave(par_cChave)
        LOCAL loc_cChave

        loc_cChave = PADR(TratarNulo(par_cChave, ""), 29)

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            WITH THIS.this_oBusinessObject
                .this_cEmps  = ALLTRIM(LEFT(loc_cChave, 3))
                .this_cDopes = ALLTRIM(SUBSTR(loc_cChave, 4, 20))
                .this_nNumes = VAL(ALLTRIM(SUBSTR(loc_cChave, 24)))
                .this_cEmpDopNums = PADR(.this_cEmps, 3) + PADR(.this_cDopes, 20) + ;
                    STR(.this_nNumes, 6)
            ENDWITH

            THIS.BOParaForm()
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega a superficie consultavel desta tela (a arvore,
    * que eh o "grid" do SIGMVMVT). Despacha para o mesmo par de metodos que o
    * legado dispara do Valid dos campos:
    *   Empresa + Operacao + Numero  -> CarregarDados()        (MakeTree)
    *   Empresa + Operacao + Periodo -> CarregarListaPeriodo() (MakeList)
    * Sem filtro suficiente NAO avisa nada e apenas limpa a arvore: este
    * metodo tambem eh chamado pelo harness com a tela em branco, e um
    * MsgAviso ali travaria o teste (os dois metodos de carga ja avisam
    * quando o usuario aciona a consulta de verdade).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_cEmps, loc_cDopes, loc_nNumes, loc_dDtI, loc_dDtF

        loc_lSucesso = .F.

        IF THIS.FormParaBO()
            WITH THIS.this_oBusinessObject
                loc_cEmps  = ALLTRIM(.this_cEmps)
                loc_cDopes = ALLTRIM(.this_cDopes)
                loc_nNumes = .this_nNumes
                loc_dDtI   = .this_dDtI
                loc_dDtF   = .this_dDtF
            ENDWITH

            DO CASE
            CASE !EMPTY(loc_cEmps) AND !EMPTY(loc_cDopes) AND loc_nNumes != 0
                loc_lSucesso = THIS.CarregarDados()

            CASE !EMPTY(loc_cEmps) AND !EMPTY(loc_cDopes) AND ;
                 !EMPTY(loc_dDtI)  AND !EMPTY(loc_dDtF)
                loc_lSucesso = THIS.CarregarListaPeriodo()

            OTHERWISE
                THIS.PrepararArvore()
                loc_lSucesso = .T.
            ENDCASE
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Liga/desliga os 5 campos do filtro. Nunca reabilita
    * quando this_lAutomatico: a tela aberta por drill direto (Empresa +
    * Operacao + Numero vindos do chamador) tem o filtro TRAVADO no legado
    * (ver AplicarParametrosAbertura), e reabilitar aqui deixaria o usuario
    * alterar a chave que abriu a tela.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        loc_lHabilitar = IIF(TYPE("par_lHabilitar") = "L", par_lHabilitar, .T.) ;
            AND !THIS.this_lAutomatico

        THIS.txt_4c_CEmp.Enabled  = loc_lHabilitar
        THIS.txt_4c_Dopes.Enabled = loc_lHabilitar
        THIS.txt_4c_Numes.Enabled = loc_lHabilitar
        THIS.txt_4c_DtI.Enabled   = loc_lHabilitar
        THIS.txt_4c_DtF.Enabled   = loc_lHabilitar
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera o filtro, o estado de navegacao e a arvore. Eh o
    * "recomecar a consulta" desta tela: reune o que o legado faz em
    * GetcEmp.GotFocus (ClearNodes + limpa Operacao/Numero) e em
    * GetNumes.GotFocus (zera o periodo), mais a pilha de navegacao.
    * Respeita o drill direto (Automatico): ali o filtro nao se apaga.
    *
    * PROTECTED igual ao FormBase (formbase.prg:276) - a protecao eh HERDADA,
    * declarar sem PROTECTED aqui nao afrouxaria nada (MEDIDO no VFP9 em
    * 2026-09-25: chamada externa estoura "Property LIMPARCAMPOS is not
    * found"). Quem limpa de fora eh BtnCancelarClick, que eh PUBLIC.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        IF !THIS.this_lAutomatico
            THIS.txt_4c_CEmp.Value  = ""
            THIS.txt_4c_Dopes.Value = ""
            THIS.txt_4c_Numes.Value = 0
            THIS.txt_4c_DtI.Value   = {}
            THIS.txt_4c_DtF.Value   = {}
        ENDIF

        *-- Estado de navegacao da arvore (mesmo bloco do InicializarForm)
        DIMENSION THIS.this_aEmpDopNums[1]
        THIS.this_aEmpDopNums[1] = ""

        DIMENSION THIS.this_aHistorico[1, 2]
        THIS.this_aHistorico[1, 1] = ""
        THIS.this_aHistorico[1, 2] = ""

        THIS.this_nNiveis        = 0
        THIS.this_nNodeExp       = 0
        THIS.this_nIndiceClicado = 0
        THIS.this_lRetorno       = .F.

        THIS.PrepararArvore()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Reaplica o que o legado controla por ESTADO.
    * O legado NAO habilita/desabilita os 6 botoes do Commandgroup1: Command4
    * (Anterior) e Command6 (Proximo) checam a pilha/o no selecionado DENTRO
    * do proprio Click (ver BtnAnteriorClick/BtnProximoClick), e inventar
    * Enabled aqui mudaria a UX do legado (PILAR 1). O que ele de fato
    * controla por estado sao duas coisas:
    *   ThisForm.BtnOficina.Visible = ThisForm.lAcOficina  (fim de GetDopes.Valid)
    *   os 5 campos do filtro travados quando Automatico = .T.  (Init)
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        THIS.cmd_4c_BtnOficina.Visible = THIS.this_lAcOficina
        THIS.HabilitarCampos(!THIS.this_lAutomatico)
    ENDPROC

    *==========================================================================
    * BtnExecutarClick - A acao desta tela: aplicar o filtro e consultar.
    * No legado ela nao tem botao proprio - nasce do Valid de GetNumes
    * (MakeTree) e do Valid de GetDtF (MakeList), ja portados em
    * NumesKeyPress/DtFKeyPress. Aqui a mesma acao ganha o nome que o
    * pipeline cobra, SEM criar botao que o SCX nao tem (o SCX declara
    * exatamente 8 botoes: os 6 do Commandgroup1 + Movimento + Producao).
    *==========================================================================
    PROCEDURE BtnExecutarClick()
        RETURN THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - "Buscar" nesta tela eh executar a consulta do filtro;
    * delega para BtnExecutarClick para nao haver duas implementacoes da
    * mesma acao divergindo com o tempo.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        RETURN THIS.BtnExecutarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - "Descartar o que foi digitado": limpa o filtro e a
    * arvore e devolve o foco ao 1o campo. NAO fecha a tela - fechar eh o
    * Encerrar (Command3, Cancel = .T., ver BtnEncerrarClick); e o harness
    * aciona BtnCancelarClick, que fechando derrubaria as verificacoes
    * seguintes.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()

        *-- SetFocus SEM TRY/CATCH, de proposito. MEDIDO no VFP9 em 2026-09-25
        *-- (test_setfocus_nao_mostrado.prg): TextBox.SetFocus() NAO estoura em
        *-- nenhum dos casos temidos - form nunca mostrado (harness headless),
        *-- controle Enabled = .F. (drill direto) ou Visible = .F.; nos tres
        *-- vira no-op. Um TRY aqui so poderia esconder erro de verdade com
        *-- CATCH silencioso (proibido - CLAUDE.md #9), ja que MsgErro a cada
        *-- Cancelar seria ruido. O guard abaixo fica pelo SENTIDO (nao levar o
        *-- foco a campo travado), nao por medo de excecao.
        IF THIS.txt_4c_CEmp.Enabled AND THIS.txt_4c_CEmp.Visible
            THIS.txt_4c_CEmp.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna os controles filhos visiveis apos o
    * AddObject (que os cria com Visible=.F. por padrao), preservando
    * BtnOficina.Visible=.F. (fiel ao legado - regra "skip com LOOP" nao
    * recursa em containers, aqui nao ha container a recursar).
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF UPPER(loc_oObjeto.Name) = "CMD_4C_BTNOFICINA"
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy
        DODEFAULT()
    ENDPROC

ENDDEFINE
