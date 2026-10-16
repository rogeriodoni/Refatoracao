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
[2026-10-15 21:54:26] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-15 21:54:26] [INFO] Config FPW: (nao fornecido)
[2026-10-15 21:54:26] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-15 21:54:26] [INFO] Timeout: 300 segundos
[2026-10-15 21:54:26] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qnwqpvjh.prg
[2026-10-15 21:54:26] [INFO] Conteudo do wrapper:
[2026-10-15 21:54:26] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigprite', 'C:\4c\tasks\task633\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprite', 'C:\4c\tasks\task633\logs\06_testForm.log'
QUIT

[2026-10-15 21:54:26] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qnwqpvjh.prg
[2026-10-15 21:54:26] [INFO] VFP output esperado em: C:\4c\tasks\task633\vfp_output.txt
[2026-10-15 21:54:26] [INFO] Executando Visual FoxPro 9...
[2026-10-15 21:54:26] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qnwqpvjh.prg
[2026-10-15 21:54:26] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qnwqpvjh.prg
[2026-10-15 21:54:26] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigprite
Inicio: 15/10/2026 21:54:26

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 15/10/2026 21:57:43
Duracao: 197 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-15 21:57:43] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-15 21:57:43] [INFO] VFP9 finalizado em 197.1761334 segundos
[2026-10-15 21:57:43] [INFO] Exit Code: 
[2026-10-15 21:57:43] [INFO] 
[2026-10-15 21:57:43] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-15 21:57:43] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qnwqpvjh.prg
[2026-10-15 21:57:43] [INFO] 
[2026-10-15 21:57:43] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-15 21:57:43] [INFO] * Auto-generated wrapper for parameters
[2026-10-15 21:57:43] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-15 21:57:43] [INFO] * Parameters: 'Formsigprite', 'C:\4c\tasks\task633\logs\06_testForm.log'
[2026-10-15 21:57:43] [INFO] 
[2026-10-15 21:57:43] [INFO] * Anti-dialog protections for unattended execution
[2026-10-15 21:57:43] [INFO] SET SAFETY OFF
[2026-10-15 21:57:43] [INFO] SET RESOURCE OFF
[2026-10-15 21:57:43] [INFO] SET TALK OFF
[2026-10-15 21:57:43] [INFO] SET NOTIFY OFF
[2026-10-15 21:57:43] [INFO] SYS(2335, 0)
[2026-10-15 21:57:43] [INFO] 
[2026-10-15 21:57:43] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprite', 'C:\4c\tasks\task633\logs\06_testForm.log'
[2026-10-15 21:57:43] [INFO] QUIT
[2026-10-15 21:57:43] [INFO] 
[2026-10-15 21:57:43] [INFO] === Fim do Wrapper.prg ===
[2026-10-15 21:57:43] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprite.prg):
*====================================================================
* Formsigprite.prg
*
* Form OPERACIONAL "Itens" - tela de CONSULTA (somente-leitura) que
* exibe os itens de um documento de movimentacao (SigMvItn), aberta a
* partir de outra tela do sistema (Movimentacao/Entrada/Saida) com o
* par Emps+Dopes+Nums do documento ja definido.
*
* PILAR 1 (UX): layout identico ao legado SIGPRITE.SCX - sem barra de
* titulo (TitleBar = 0), sem controle de janela (ControlBox = .F.),
* nao movivel (Movable = .F.), 800x600, com a faixa de cabecalho cinza
* (cntSombra) no topo mostrando o titulo calculado "<Emps> - <Dopes> -
* <Nums> - Itens".
*
* PILAR 3 (arquitetura): o legado (SIGPRITE) e um form FLAT do VFP -
* SEM PageFrame, SEM Page1/Page2: grdCabec, grdItens, grdRodape,
* Get_descr, Get_obs, FigJpg, btnSubniveis, btnEntrega e cmdsair sao
* todos filhos DIRETOS do form (ver layout.json/comportamento.json de
* tasks\task633). Este form migrado segue a mesma estrutura flat - nao
* ha PageFrame para inventar (CLAUDE.md, Gate da Fase 3 quando o legado
* nao tem PageFrame). O unico container do legado e cntSombra (faixa
* do cabecalho), reproduzido aqui como cnt_4c_Sombra.
*
* FASES 3-8/8 CONCLUIDAS: esqueleto do form, cabecalho, grids (grdCabec/
* grdItens/grdRodape), botoes (btnSubniveis/btnEntrega/cmdsair), os
* campos de dados do item selecionado (Get_descr/Say2 -> txt_4c_Descr/
* lbl_4c_Label2 e Get_obs/Say_Obs -> obj_4c_Get_obs/lbl_4c__Obs, ligados
* por ControlSource direto a cursor_4c_Grade - regra #41 do CLAUDE.md),
* as formas decorativas (shpProdutos/Shape5/Shape1 -> shp_4c_ShpProdutos/
* shp_4c_Shape5/shp_4c_Shape1), a imagem do produto (FigJpg -> img_4c_FigJpg)
* e o indicador de disponibilidade (lblDisps/shpDisps -> lbl_4c_LblDisps/
* shp_4c_ShpDisps), alem de TODOS os eventos do dump (comportamento.json,
* 18 metodos com codigo): grd_4c_Itens.AfterRowColChange (decodifica e
* exibe a foto do produto), grd_4c_Itens.Column2.Text1.DblClick (abre a
* Pesquisa Global de Produtos filtrada pelo codigo da linha, equivalente
* a "Do Form SIGOPCGP.Scx ... With [SIGOPCGP] NoShow" do legado - aqui
* FormSigOpCgp, ja migrado, atraves do fluxo publico Limpar Filtros +
* txt_4c_ProdutoI/F + BtnConsultarClick), os 3 botoes de acao
* (BtnSubniveisClick/BtnEntregaClick/CmdsairClick, equivalentes a
* "Do Form SigMvMvt"/"Do Form SigOpDen"/"ThisForm.Release") e o truque de
* foco Tag/Value das DUAS grades decorativas sem RecordSource (grdCabec E
* grdRodape - Column1.GotFocus devolve o foco para grd_4c_Itens.Column1,
* Column2.GotFocus/LostFocus guardam/restauram o valor para a celula
* nunca mostrar cursor de edicao piscando).
*
* FASE 8 (consolidacao) acrescentou os hooks canonicos, todos com codigo
* REAL vindo do legado - nenhum deles e novo comportamento:
*   CarregarLista() - entrada canonica de carga; chama CarregarItens()
*     (.SelecionaDados) e, como o fim do Init legado, deixa a 1a linha ja
*     sincronizada com o detalhe do produto. PUBLIC porque o harness
*     TesteAutomatico.prg a chama de fora (CLAUDE.md regra #3).
*   FormParaBO() - a SELECAO da grade vira o item corrente do BO
*     ("Select crGrade" do AfterRowColChange legado); e o que faltava para
*     BO.CarregarDoCursor() deixar de ser codigo morto.
*   BOParaForm() - o corpo do AfterRowColChange legado (CursorQuery de
*     FigJpgs + Strconv/StrToFile + os tres Refresh finais).
*   LimparCampos() - o bloco de abertura do mesmo AfterRowColChange
*     (esconde e descarrega a foto).
*   Activate() - o ".grdItens.Column1.Setfocus" do fim do Init legado, que
*     no Init nao pega porque o controle ainda nao foi desenhado.
*
* NOTA (Gate Fases 7/8): este form NAO tem bloco CRUD algum - o SCX
* legado (ver layout.json/analise.json de tasks\task633) nao declara
* cmd_4c_Incluir/Alterar/Visualizar/Excluir nem Page1=Lista/Page2=Dados;
* e um form FLAT de CONSULTA aberto com o documento ja escolhido por
* outra tela, e a prova disso esta no proprio dump: nenhuma gravacao em
* tabela (so SqlExecute de leitura e Insert Into cursor LOCAL) e todo
* campo de entrada somente-leitura (grades com ReadOnly = .T. e os dois
* Get_* com "PROCEDURE When / Return .f."). Por isso NAO existem aqui,
* e nao devem ser criados: botao de gravar, botao que abandona edicao,
* HabilitarCampos (nao ha campo editavel para habilitar) e
* AjustarBotoesPorModo (nao ha modo INCLUIR/ALTERAR/VISUALIZAR - a tela
* tem um unico estado). Inventa-los violaria o PILAR 1 (UX identica ao
* original) e a regra de nunca criar funcionalidade que o sistema legado
* nao tem; cria-los vazios violaria a regra de completude.
*
* Parametros de Init (equivalentes ao legado
* LParameters pEmp, pDop, pNum, pDis, pCnx):
*   par_cEmps        - pEmp: empresa do documento (SigMvItn.Emps)
*   par_cDopes       - pDop: codigo da operacao (SigMvItn.Dopes)
*   par_nNums        - pNum: numero do documento (SigMvItn.Nums)
*   par_lChecaDisps  - pDis: indica se a disponibilidade do produto
*                      deve ser conferida/exibida
*   pCnx (legado) nao se aplica: a nova arquitetura usa a conexao
*   global unica gnConnHandle, nao reabre conexao por form.
*====================================================================

DEFINE CLASS Formsigprite AS FormBase

    *-- Propriedades visuais (pixel-perfect SCX legado - PILAR 1)
    DataSession = 2
    ShowWindow = 1
    WindowType = 1
    BorderStyle = 2
    Height      = 600
    Width       = 800
    AutoCenter  = .T.
    Caption     = "Itens"
    ControlBox  = .F.
    FontName    = "Verdana"
    FontSize    = 8
    MaxButton   = .F.
    Movable     = .F.
    TitleBar    = 0
    ForeColor   = RGB(36, 84, 155)
    Themes      = .F.
    ShowTips    = .T.

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Parametros recebidos na abertura (equivalentes a pEmp/pDop/pNum/
    *-- pDis do legado)
    this_cEmps       = ""
    this_cDopes      = ""
    this_nNums       = 0
    this_lChecaDisps = .F.

    *-- Arquivo temporario para decodificar a foto do produto (copia da
    *-- property equivalente no BO - equivalente a ThisForm.Arquivo do
    *-- Init legado). Usado pelas fases de grid/eventos (AfterRowColChange).
    this_cArquivo = ""

    *-- Uma vez so: o foco inicial vai para a grade de itens na PRIMEIRA
    *-- ativacao do form (equivalente a ".grdItens.Column1.Setfocus" do fim
    *-- do Init legado). No Init o controle ainda nao foi desenhado e o
    *-- SetFocus nao pega - por isso o Activate, com esta trava para nao
    *-- roubar o foco do usuario a cada volta de Subniveis/Entrega.
    this_lFocoInicialDado = .F.

    *==========================================================================
    * Init - Recebe os parametros do documento ANTES de DODEFAULT() rodar
    * ver CLAUDE.md "Problema 8", Init so repassa para DODEFAULT()).
    *==========================================================================
    PROCEDURE Init(par_cEmps, par_cDopes, par_nNums, par_lChecaDisps)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        THIS.this_cEmps       = IIF(VARTYPE(par_cEmps) = "C", ALLTRIM(par_cEmps), "")
        THIS.this_cDopes      = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")
        THIS.this_nNums       = IIF(VARTYPE(par_nNums) = "N", par_nNums, 0)
        THIS.this_lChecaDisps = IIF(VARTYPE(par_lChecaDisps) = "L", par_lChecaDisps, .F.)

        loc_lResultado = DODEFAULT()
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria o Business Object, repassa os parametros do
    * documento (equivalente a .EmpDopNum/.ChecaDisps do Init legado),
    * monta o titulo dinamico (equivalente a ThisForm.Caption = Alltrim(pEmp)
    * + ' - ' + Alltrim(pDop) + ' - ' + Alltrim(Str(pNum,6)) + ' - Itens') e
    * constroi a faixa do cabecalho. Grids, botoes e campos de dados ficam
    * para as fases seguintes.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste
        loc_lSucesso = .F.
        loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                    (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Instanciar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("sigpriteBO")
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar sigpriteBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "Formsigprite.InicializarForm")
            ELSE
                THIS.this_oBusinessObject.this_cEmps       = THIS.this_cEmps
                THIS.this_oBusinessObject.this_cDopes      = THIS.this_cDopes
                THIS.this_oBusinessObject.this_nNums       = THIS.this_nNums
                THIS.this_oBusinessObject.this_lChecaDisps = THIS.this_lChecaDisps
                THIS.this_cArquivo                          = THIS.this_oBusinessObject.this_cArquivo

                *-- Titulo "<Emps> - <Dopes> - <Nums> - Itens", igual ao
                *-- legado. Em validacao de UI / modo teste nao recalcula:
                *-- nesses modos os parametros chegam vazios/zero (nao ha
                *-- chamador real) e o comparador confere contra o Caption
                *-- ESTATICO do SCX ("Itens") - recalcular so trocaria o
                *-- texto fiel por outro tambem incorreto.
                IF !loc_lModoValidacaoOuTeste
                    THIS.Caption = ALLTRIM(THIS.this_cEmps) + " - " + ALLTRIM(THIS.this_cDopes) + ;
                        " - " + ALLTRIM(STR(THIS.this_nNums, 6)) + " - Itens"
                ENDIF

                THIS.ConfigurarCabecalho()

                *-- Cursores do grid (regra #41 do CLAUDE.md - cursor_4c_Grade/
                *-- cursor_4c_Rodape tem de existir ANTES do Column.ControlSource
                *-- das grades, senao o Init estoura "Alias is not found") +
                *-- flag de imagem do produto (SigCdOpe.Imagems, equivalente ao
                *-- .poDataMgr.CursorQuery('SigCdOpe', ...) do Init legado).
                THIS.this_oBusinessObject.InicializarCursores()

                THIS.ConfigurarGridCabecalho()
                THIS.ConfigurarGridItens()
                THIS.ConfigurarGridRodape()
                THIS.ConfigurarBotoesAcao()
                THIS.ConfigurarCamposProduto()
                THIS.ConfigurarElementosVisuais()

                *-- Carga inicial dos dados (equivalente a .SelecionaDados do
                *-- Init legado) - pulada em validacao de UI / modo teste
                *-- (sem gnConnHandle real, ver CarregarItens()).
                IF !loc_lModoValidacaoOuTeste
                    THIS.this_oBusinessObject.CarregarFlagImagem()
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em Formsigprite.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado), com
    * os dois labels sobrepostos (sombra + titulo) exibindo o Caption
    * calculado em InicializarForm. Nomes conforme tasks\task633\mapeamento.json
    * (cnt_4c_Sombra / lbl_4c_LblSombra / lbl_4c_LblTitulo).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt

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
            .Top           = 18
            .Width         = 769
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
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
    ENDPROC

    *==========================================================================
    * ConfigurarGridCabecalho - Grade "grdCabec" do legado: faixa decorativa
    * de 4 colunas (Produto | "" | Quantidade | Valor) que funciona como um
    * segundo cabecalho acima de grd_4c_Itens, agrupando visualmente varias
    * colunas da grade de baixo sob um titulo so (ex.: "Quantidade" cobre
    * Original/Baixada/Saldo). NAO tem RecordSource - o legado nunca liga
    * esta grade a cursor nenhum, so FormatBase (regra #35b: a grade da
    * Lista/estrutura espelha o legado, nunca se inventa binding que nao
    * existe). O GotFocus/LostFocus abaixo reproduz o truque do legado para
    * o usuario nunca conseguir "entrar" nesta grade (foco sempre volta
    * para grd_4c_Itens.Column1).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridCabecalho()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Cabec", "Grid")
        loc_oGrid = THIS.grd_4c_Cabec

        WITH loc_oGrid
            .ColumnCount        = 4
            .Top                = 118
            .Left               = 26
            .Width              = 731
            .Height             = 35
            .FontName           = "Arial"
            .HeaderHeight       = 17
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .ReadOnly           = .T.
            .ScrollBars         = 0
            .Visible            = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .Width    = 226
            .FontName = "Arial"
            .ReadOnly = .T.
        ENDWITH
        WITH loc_oGrid.Column1.Header1
            .Caption   = "Produto"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column2
            .Width    = 20
            .FontName = "Arial"
            .ReadOnly = .T.
        ENDWITH
        WITH loc_oGrid.Column2.Header1
            .Caption   = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column3
            .Width    = 242
            .FontName = "Arial"
            .ReadOnly = .T.
        ENDWITH
        WITH loc_oGrid.Column3.Header1
            .Caption   = "Quantidade"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 2
        ENDWITH

        WITH loc_oGrid.Column4
            .Width    = 238
            .FontName = "Arial"
            .ReadOnly = .T.
        ENDWITH
        WITH loc_oGrid.Column4.Header1
            .Caption   = "Valor"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 2
        ENDWITH

        BINDEVENT(loc_oGrid.Column1.Text1, "GotFocus",  THIS, "GrdCabecColumn1GotFocus")
        BINDEVENT(loc_oGrid.Column2.Text1, "GotFocus",  THIS, "GrdCabecColumn2GotFocus")
        BINDEVENT(loc_oGrid.Column2.Text1, "LostFocus", THIS, "GrdCabecColumn2LostFocus")
    ENDPROC

    *-- Redireciona o foco para a grade de itens de verdade (legado:
    *-- ThisForm.grdItens.Column1.SetFocus no GotFocus do Text1 da Column1)
    PROCEDURE GrdCabecColumn1GotFocus()
        THIS.grd_4c_Itens.Column1.SetFocus()
    ENDPROC

    *-- Truque Tag/Value do legado: guarda o valor ao entrar e devolve ao
    *-- sair, para a celula nunca mostrar cursor de edicao piscando
    PROCEDURE GrdCabecColumn2GotFocus()
        THIS.grd_4c_Cabec.Column2.Text1.Tag = THIS.grd_4c_Cabec.Column2.Text1.Value
    ENDPROC

    PROCEDURE GrdCabecColumn2LostFocus()
        THIS.grd_4c_Cabec.Column2.Text1.Value = THIS.grd_4c_Cabec.Column2.Text1.Tag
    ENDPROC

    *==========================================================================
    * ConfigurarGridItens - Grade "grdItens" do legado: os 11 campos do item
    * do documento, ligada a cursor_4c_Grade (equivalente ao
    * .RecordSource = 'crGrade' + Column1..11.ControlSource do PROCEDURE
    * MontaGrades legado). ReadOnly=.T. em tudo (tela de CONSULTA). Fonte
    * Courier New nas colunas e nos Text1 (mesmo loop "For I=1 To
    * .ColumnCount" do legado, aqui transcrito coluna a coluna).
    * DynamicForeColor/DynamicBackColor reproduzem as duas regras de negocio
    * do legado (saldo vazio em azul; disponibilidade insuficiente destaca
    * a linha) - regra #17 do CLAUDE.md, transcrever formula literalmente.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridItens()
        LOCAL loc_oGrid, loc_cCursor, loc_cExpFore, loc_cExpBack
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

        THIS.AddObject("grd_4c_Itens", "Grid")
        loc_oGrid = THIS.grd_4c_Itens

        WITH loc_oGrid
            .ColumnCount       = 11
            .RecordSource      = loc_cCursor
            .Top               = 135
            .Left              = 26
            .Width             = 750
            .Height            = 275
            .FontName          = "Arial"
            .HeaderHeight      = 17
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .T.
            .ScrollBars        = 2
            .Visible           = .T.
        ENDWITH

        *-- Column1 - numero sequencial do item (CItens = ordinal da consulta)
        WITH loc_oGrid.Column1
            .ControlSource = loc_cCursor + ".CItens"
            .InputMask     = "999999"
            .Width         = 31
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
        ENDWITH
        WITH loc_oGrid.Column1.Header1
            .Caption   = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
        ENDWITH
        WITH loc_oGrid.Column1.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column2 - codigo do produto (ponteiro de mao: DblClick abre a
        *-- Pesquisa Global de Produtos, equivalente ao "Do Form SIGOPCGP"
        *-- do legado - ver GrdItensColumn2DblClick)
        WITH loc_oGrid.Column2
            .ControlSource = loc_cCursor + ".CPros"
            .Width         = 108
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
        ENDWITH
        WITH loc_oGrid.Column2.Header1
            .Caption   = "Produto"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
        ENDWITH
        WITH loc_oGrid.Column2.Text1
            .FontName     = "Courier New"
            .BorderStyle  = 0
            .Margin       = 0
            .MousePointer = 99
            .MouseIcon    = gc_4c_CaminhoIcones + "h_point.cur"
            .ForeColor    = RGB(0, 0, 0)
            .BackColor    = RGB(255, 255, 255)
        ENDWITH

        *-- Column3 - unidade
        WITH loc_oGrid.Column3
            .ControlSource = loc_cCursor + ".CUnis"
            .Width         = 42
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
        ENDWITH
        WITH loc_oGrid.Column3.Header1
            .Caption   = "Unidade"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
        ENDWITH
        WITH loc_oGrid.Column3.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column4 - volume
        WITH loc_oGrid.Column4
            .ControlSource = loc_cCursor + ".Volumes"
            .InputMask     = "999"
            .Width         = 42
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
        ENDWITH
        WITH loc_oGrid.Column4.Header1
            .Caption   = "Volume"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
        ENDWITH
        WITH loc_oGrid.Column4.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column5 - operacao (O = origem/destino, "I"/"S" conforme legado)
        WITH loc_oGrid.Column5
            .ControlSource = loc_cCursor + ".Opers"
            .Width         = 20
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
        ENDWITH
        WITH loc_oGrid.Column5.Header1
            .Caption   = "O"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
        ENDWITH
        WITH loc_oGrid.Column5.Text1
            .FontName    = "Courier New"
            .FontBold    = .T.
            .Alignment   = 2
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column6 - quantidade original (a.Qtds)
        WITH loc_oGrid.Column6
            .ControlSource = loc_cCursor + ".QtdOs"
            .InputMask     = "9999999.99"
            .Width         = 80
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
        ENDWITH
        WITH loc_oGrid.Column6.Header1
            .Caption   = "Original"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
        ENDWITH
        WITH loc_oGrid.Column6.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column7 - quantidade baixada (a.QtBaixas)
        WITH loc_oGrid.Column7
            .ControlSource = loc_cCursor + ".QtdBs"
            .InputMask     = "9999999.99"
            .Width         = 80
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
        ENDWITH
        WITH loc_oGrid.Column7.Header1
            .Caption   = "Baixada"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
        ENDWITH
        WITH loc_oGrid.Column7.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column8 - saldo (a.Qtds - a.QtBaixas)
        WITH loc_oGrid.Column8
            .ControlSource = loc_cCursor + ".QtdSs"
            .InputMask     = "9999999.99"
            .Width         = 80
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
        ENDWITH
        WITH loc_oGrid.Column8.Header1
            .Caption   = "Saldo"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
        ENDWITH
        WITH loc_oGrid.Column8.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column9 - valor unitario (a.Units)
        WITH loc_oGrid.Column9
            .ControlSource = loc_cCursor + ".Units"
            .InputMask     = "999999999.99"
            .Width         = 100
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
        ENDWITH
        WITH loc_oGrid.Column9.Header1
            .Caption   = "Unit" + CHR(225) + "rio"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
        ENDWITH
        WITH loc_oGrid.Column9.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column10 - moeda (a.Moedas)
        WITH loc_oGrid.Column10
            .ControlSource = loc_cCursor + ".CMoes"
            .Width         = 36
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
        ENDWITH
        WITH loc_oGrid.Column10.Header1
            .Caption   = "Moeda"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
        ENDWITH
        WITH loc_oGrid.Column10.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Column11 - valor total (a.Totas)
        WITH loc_oGrid.Column11
            .ControlSource = loc_cCursor + ".Totas"
            .InputMask     = "999999999.99"
            .Width         = 100
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
        ENDWITH
        WITH loc_oGrid.Column11.Header1
            .Caption   = "Valor Total"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
        ENDWITH
        WITH loc_oGrid.Column11.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Regras de negocio do legado (transcritas - CLAUDE.md regra #17):
        *-- saldo vazio em azul; linha com disponibilidade insuficiente para
        *-- a baixa pintada de branco (destaque), senao amarelo-claro.
        loc_cExpFore = "IIF(EMPTY(" + loc_cCursor + ".QtdSs), RGB(0,0,255), RGB(0,0,0))"
        loc_oGrid.SetAll("DynamicForeColor", loc_cExpFore, "Column")

        IF THIS.this_lChecaDisps
            loc_cExpBack = "IIF(" + loc_cCursor + ".Disps < " + loc_cCursor + ;
                ".QtdSs, RGB(255,255,255), RGB(255,255,223))"
            loc_oGrid.SetAll("DynamicBackColor", loc_cExpBack, "Column")
        ENDIF

        *-- AfterRowColChange (legado: decodifica e exibe a foto do produto
        *-- da linha corrente) e DblClick na coluna do codigo (legado: abre
        *-- a Pesquisa Global de Produtos filtrada pelo codigo da linha)
        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdItensAfterRowColChange")
        BINDEVENT(loc_oGrid.Column2.Text1, "DblClick", THIS, "GrdItensColumn2DblClick")
    ENDPROC

    *==========================================================================
    * ConfigurarGridRodape - Grade "grdRodape" do legado: totais por moeda
    * (equivalente a .RecordSource = 'crRodape' do MontaGrades legado),
    * fundo amarelo-claro (RGB 255,255,223) e cabecalho amarelo (RGB
    * 255,255,0) sem legenda nenhuma (HeaderHeight=4 - praticamente oculto).
    * As colunas 1/2/3/5/9 apontam para CPros (sempre vazio no cursor de
    * totais - BO.CarregarItens grava CPros = "" na linha de totais) - isto
    * e FIEL ao legado, que usa o mesmo ControlSource redundante nessas
    * colunas como espacador (regra #17 - transcrever, nunca "corrigir"
    * o que parece estranho sem confirmar que e defeito).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridRodape()
        LOCAL loc_oGrid, loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorRodape

        THIS.AddObject("grd_4c_Rodape", "Grid")
        loc_oGrid = THIS.grd_4c_Rodape

        WITH loc_oGrid
            .ColumnCount       = 11
            .RecordSource      = loc_cCursor
            .Top               = 404
            .Left              = 26
            .Width             = 749
            .Height            = 25
            .FontName          = "Arial"
            .HeaderHeight      = 4
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .T.
            .ScrollBars        = 2
            .Visible           = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .ControlSource = loc_cCursor + ".CPros"
            .Width         = 31
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
            .BackColor     = RGB(255, 255, 223)
        ENDWITH
        WITH loc_oGrid.Column1.Header1
            .Caption   = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .BackColor = RGB(255, 255, 0)
        ENDWITH
        WITH loc_oGrid.Column1.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 223)
        ENDWITH

        WITH loc_oGrid.Column2
            .ControlSource = loc_cCursor + ".CPros"
            .Width         = 108
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
            .BackColor     = RGB(255, 255, 223)
        ENDWITH
        WITH loc_oGrid.Column2.Header1
            .Caption   = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .BackColor = RGB(255, 255, 0)
        ENDWITH
        WITH loc_oGrid.Column2.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 223)
        ENDWITH

        WITH loc_oGrid.Column3
            .ControlSource = loc_cCursor + ".CPros"
            .Width         = 42
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
            .BackColor     = RGB(255, 255, 223)
        ENDWITH
        WITH loc_oGrid.Column3.Header1
            .Caption   = ""
            .FontSize  = 8
            .Alignment = 2
            .BackColor = RGB(255, 255, 0)
        ENDWITH
        WITH loc_oGrid.Column3.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 223)
        ENDWITH

        WITH loc_oGrid.Column4
            .ControlSource = loc_cCursor + ".Volumes"
            .InputMask     = "999"
            .Width         = 42
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
            .BackColor     = RGB(255, 255, 223)
        ENDWITH
        WITH loc_oGrid.Column4.Header1
            .Caption   = ""
            .FontSize  = 8
            .Alignment = 2
            .BackColor = RGB(255, 255, 0)
        ENDWITH
        WITH loc_oGrid.Column4.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 223)
        ENDWITH

        WITH loc_oGrid.Column5
            .ControlSource = loc_cCursor + ".CPros"
            .Width         = 20
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
            .BackColor     = RGB(255, 255, 223)
        ENDWITH
        WITH loc_oGrid.Column5.Header1
            .Caption   = ""
            .FontSize  = 8
            .Alignment = 2
            .BackColor = RGB(255, 255, 0)
        ENDWITH
        WITH loc_oGrid.Column5.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 223)
        ENDWITH

        WITH loc_oGrid.Column6
            .ControlSource = loc_cCursor + ".QtdOs"
            .InputMask     = "9999999.99"
            .Width         = 80
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
            .BackColor     = RGB(255, 255, 223)
        ENDWITH
        WITH loc_oGrid.Column6.Header1
            .Caption   = ""
            .FontSize  = 8
            .Alignment = 2
            .BackColor = RGB(255, 255, 0)
        ENDWITH
        WITH loc_oGrid.Column6.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 223)
        ENDWITH

        WITH loc_oGrid.Column7
            .ControlSource = loc_cCursor + ".QtdBs"
            .InputMask     = "9999999.99"
            .Width         = 80
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
            .BackColor     = RGB(255, 255, 223)
        ENDWITH
        WITH loc_oGrid.Column7.Header1
            .Caption   = ""
            .FontSize  = 8
            .Alignment = 2
            .BackColor = RGB(255, 255, 0)
        ENDWITH
        WITH loc_oGrid.Column7.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 223)
        ENDWITH

        WITH loc_oGrid.Column8
            .ControlSource = loc_cCursor + ".QtdSs"
            .InputMask     = "9999999.99"
            .Width         = 80
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
            .BackColor     = RGB(255, 255, 223)
        ENDWITH
        WITH loc_oGrid.Column8.Header1
            .Caption   = ""
            .FontSize  = 8
            .Alignment = 2
            .BackColor = RGB(255, 255, 0)
        ENDWITH
        WITH loc_oGrid.Column8.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 223)
        ENDWITH

        WITH loc_oGrid.Column9
            .ControlSource = loc_cCursor + ".CPros"
            .Width         = 100
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
            .BackColor     = RGB(255, 255, 223)
        ENDWITH
        WITH loc_oGrid.Column9.Header1
            .Caption   = ""
            .FontSize  = 8
            .Alignment = 2
            .BackColor = RGB(255, 255, 0)
        ENDWITH
        WITH loc_oGrid.Column9.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 223)
        ENDWITH

        WITH loc_oGrid.Column10
            .ControlSource = loc_cCursor + ".CMoes"
            .Width         = 36
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
            .BackColor     = RGB(255, 255, 223)
        ENDWITH
        WITH loc_oGrid.Column10.Header1
            .Caption   = ""
            .FontSize  = 8
            .Alignment = 2
            .BackColor = RGB(255, 255, 0)
        ENDWITH
        WITH loc_oGrid.Column10.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 223)
        ENDWITH

        WITH loc_oGrid.Column11
            .ControlSource = loc_cCursor + ".Totas"
            .InputMask     = "999999999.99"
            .Width         = 100
            .ReadOnly      = .T.
            .Movable       = .F.
            .Resizable     = .F.
            .FontName      = "Courier New"
            .BackColor     = RGB(255, 255, 223)
        ENDWITH
        WITH loc_oGrid.Column11.Header1
            .Caption   = ""
            .FontSize  = 8
            .Alignment = 2
            .BackColor = RGB(255, 255, 0)
        ENDWITH
        WITH loc_oGrid.Column11.Text1
            .FontName    = "Courier New"
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 223)
        ENDWITH

        *-- Mesmo truque de foco do grdCabec (regra de UX do legado - o
        *-- usuario nunca "entra" na grade de totais): Column1 devolve o
        *-- foco para a grade de itens de verdade, Column2 guarda/devolve
        *-- o valor via Tag para a celula nunca mostrar cursor de edicao.
        BINDEVENT(loc_oGrid.Column1.Text1, "GotFocus",  THIS, "GrdRodapeColumn1GotFocus")
        BINDEVENT(loc_oGrid.Column2.Text1, "GotFocus",  THIS, "GrdRodapeColumn2GotFocus")
        BINDEVENT(loc_oGrid.Column2.Text1, "LostFocus", THIS, "GrdRodapeColumn2LostFocus")
    ENDPROC

    *-- Redireciona o foco para a grade de itens de verdade (legado:
    *-- ThisForm.grdItens.Column1.SetFocus no GotFocus do Text1 da
    *-- Column1 de grdRodape - mesmo comportamento do grdCabec)
    PROCEDURE GrdRodapeColumn1GotFocus()
        THIS.grd_4c_Itens.Column1.SetFocus()
    ENDPROC

    *-- Truque Tag/Value do legado na grade de totais: guarda o valor ao
    *-- entrar e devolve ao sair, para a celula nunca mostrar cursor de
    *-- edicao piscando
    PROCEDURE GrdRodapeColumn2GotFocus()
        THIS.grd_4c_Rodape.Column2.Text1.Tag = THIS.grd_4c_Rodape.Column2.Text1.Value
    ENDPROC

    PROCEDURE GrdRodapeColumn2LostFocus()
        THIS.grd_4c_Rodape.Column2.Text1.Value = THIS.grd_4c_Rodape.Column2.Text1.Tag
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - Botoes flutuantes do legado (Top=460, 75x75,
    * Comic Sans MS, Themes=.F. - mesmo padrao fwbtng). cmd_4c_Cmdsair usa
    * o tamanho DEFAULT da classe fwbtng (Height=100/Width=80 - ver
    * Framework\framework_class_codigo_fonte.txt), pois o SCX legado so
    * sobrescreve Top/Left/Picture/Caption/ToolTipText/Cancel - mantido
    * fiel, inclusive o overflow de +5px (725+80=805) alem do
    * Form.Width=800 que ja existia no legado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        THIS.AddObject("cmd_4c_BtnSubniveis", "CommandButton")
        WITH THIS.cmd_4c_BtnSubniveis
            .Top        = 460
            .Left       = 691
            .Width      = 75
            .Height     = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
            .Caption    = "\<Subniveis"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_BtnEntrega", "CommandButton")
        WITH THIS.cmd_4c_BtnEntrega
            .Top        = 460
            .Left       = 616
            .Width      = 75
            .Height     = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
            .Caption    = "\<Entrega"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Cmdsair", "CommandButton")
        WITH THIS.cmd_4c_Cmdsair
            .Top          = 3
            .Left         = 725
            .Width        = 80
            .Height       = 100
            .FontBold     = .T.
            .FontItalic   = .T.
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .WordWrap     = .T.
            .MousePointer = 15
            .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel       = .T.
            .Caption      = "Encerrar"
            .ToolTipText  = "[Esc] Encerrar"
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible      = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_BtnSubniveis, "Click", THIS, "BtnSubniveisClick")
        BINDEVENT(THIS.cmd_4c_BtnEntrega,   "Click", THIS, "BtnEntregaClick")
        BINDEVENT(THIS.cmd_4c_Cmdsair,      "Click", THIS, "CmdsairClick")
    ENDPROC

    *==========================================================================
    * ConfigurarCamposProduto - Primeira metade dos campos de dados do item
    * corrente da grade (equivalente a Get_descr/Say2 e Get_obs/Say_Obs do
    * legado): descricao e observacao do produto. Ligados por ControlSource
    * DIRETO a cursor_4c_Grade (equivalente a 'crGrade.DPros'/'crGrade.Obs'
    * do dump), o mesmo cursor da grd_4c_Itens - por isso so podem ser
    * criados DEPOIS de THIS.this_oBusinessObject.InicializarCursores()
    * (regra #41 do CLAUDE.md: ControlSource de cursor ainda inexistente
    * derruba o Init).
    *
    * .ReadOnly = .T. + .TabStop = .F. reproduzem o PROCEDURE When
    * (Return .f.) do legado - o usuario nunca ganha foco nem edita estes
    * campos, eles so espelham a linha selecionada na grade de itens. O
    * refresh explicito (ThisForm.Refresh / ThisForm.Get_Obs.Refresh do
    * AfterRowColChange legado) fica para a fase que amarra os eventos da
    * grade - sem ela os controles ainda mostram a 1a linha do cursor ate
    * o usuario navegar a grade, o que e seguro (nao estoura, nao perde
    * dados) e sera corrigido junto com FigJpg/disponibilidade.
    *
    * Say2/Say_Obs sao classe "say" do Framework legado - AutoSize=.T. e
    * Alignment=0, sem Width/Alignment declarados no dump (regra #23 do
    * CLAUDE.md: NUNCA inventar Width+Alignment=1). Como AddObject torna
    * AutoSize=.T. no-op (mesma regra #23), usar Alignment=0 explicito com
    * Width calculada para caber o texto, sem herdar nada do campo abaixo
    * (os dois estao em TOP diferentes, nao lado a lado - sem risco de
    * sobreposicao da regra #28).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposProduto()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

        *-- Say2 -> lbl_4c_Label2 ("Descricao Produto")
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .FontName  = THIS.FontName
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o Produto"
            .Left      = 30
            .Top       = 440
            .Width     = 150
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_descr -> txt_4c_Descr (espelha <cursor>.DPros - somente leitura)
        THIS.AddObject("txt_4c_Descr", "TextBox")
        WITH THIS.txt_4c_Descr
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ControlSource     = loc_cCursor + ".DPros"
            .Left              = 30
            .Top               = 456
            .Width             = 396
            .Height            = 23
            .ReadOnly          = .T.
            .TabStop           = .F.
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(192, 192, 192)
            .BorderColor       = RGB(100, 100, 100)
            .Visible           = .T.
        ENDWITH

        *-- Say_Obs -> lbl_4c__Obs ("Observacao Produto")
        THIS.AddObject("lbl_4c__Obs", "Label")
        WITH THIS.lbl_4c__Obs
            .FontName  = THIS.FontName
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o Produto"
            .Left      = 30
            .Top       = 481
            .Width     = 160
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_obs -> obj_4c_Get_obs (espelha <cursor>.Obs - memo, somente leitura)
        THIS.AddObject("obj_4c_Get_obs", "EditBox")
        WITH THIS.obj_4c_Get_obs
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ControlSource = loc_cCursor + ".Obs"
            .Left          = 30
            .Top           = 496
            .Width         = 396
            .Height        = 57
            .ReadOnly      = .T.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .NullDisplay   = " "
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarElementosVisuais - Formas decorativas (shpProdutos/Shape5/
    * Shape1 do legado), a imagem do produto (FigJpg) e o indicador de
    * disponibilidade (lblDisps/shpDisps). Transcrito literalmente do dump
    * (tasks\task633\sigprite_form_codigo_fonte.txt) - regra #17 do
    * CLAUDE.md, inclusive o Shape1 com BorderStyle=0 (sem contorno,
    * BorderColor sem efeito) e o shpDisps com cor fixa amarelo-claro (nao
    * ha regra de negocio dinamica para ele no legado - so o Visible muda,
    * equivalente a ".lblDisps.Visible = pDis" / ".shpDisps.Visible = pDis"
    * do Init legado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarElementosVisuais()
        *-- shpProdutos - moldura ao redor da area de grades/detalhe do produto
        THIS.AddObject("shp_4c_ShpProdutos", "Shape")
        WITH THIS.shp_4c_ShpProdutos
            .Top         = 113
            .Left        = 21
            .Width       = 757
            .Height      = 320
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Shape5 - moldura ao redor do bloco de descricao/observacao
        THIS.AddObject("shp_4c_Shape5", "Shape")
        WITH THIS.shp_4c_Shape5
            .Top         = 438
            .Left        = 21
            .Width       = 584
            .Height      = 121
            .BackStyle   = 0
            .Curvature   = 0
            .BackColor   = RGB(255, 255, 255)
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Shape1 - moldura decorativa junto aos botoes Subniveis/Entrega
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 691
            .Width       = 90
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- FigJpg -> img_4c_FigJpg (foto do produto da linha corrente -
        *-- preenchida/exibida por GrdItensAfterRowColChange)
        THIS.AddObject("img_4c_FigJpg", "Image")
        WITH THIS.img_4c_FigJpg
            .Stretch = 1
            .Top     = 443
            .Left    = 433
            .Width   = 166
            .Height  = 111
            .Picture = ""
            .Visible = .F.
        ENDWITH

        *-- lblDisps/shpDisps -> indicador de disponibilidade do produto,
        *-- visivel apenas quando o chamador pede a conferencia (par_lChecaDisps)
        THIS.AddObject("lbl_4c_LblDisps", "Label")
        WITH THIS.lbl_4c_LblDisps
            .FontName  = THIS.FontName
            .FontSize  = 8
            .Caption   = "Disponibilidade do Produto"
            .Left      = 270
            .Top       = 441
            .Width     = 160
            .Height    = 17
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = THIS.this_lChecaDisps
        ENDWITH

        THIS.AddObject("shp_4c_ShpDisps", "Shape")
        WITH THIS.shp_4c_ShpDisps
            .Top           = 441
            .Left          = 254
            .Width         = 14
            .Height        = 14
            .BackStyle     = 1
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 187)
            .Visible       = THIS.this_lChecaDisps
        ENDWITH
    ENDPROC

    *==========================================================================
    * GrdItensAfterRowColChange - Reage a troca de linha/coluna na grade de
    * itens, equivalente ao PROCEDURE AfterRowColChange de grdItens no
    * legado (dump, linhas 1672-1701). PUBLIC + LPARAMETERS par_nColIndex:
    * alvo de BINDEVENT (regra #3), que exige metodo PUBLIC declarando o
    * parametro do evento.
    *
    * O corpo do legado foi decomposto nos tres hooks canonicos, na MESMA
    * ordem e sem mudar comportamento:
    *   LimparCampos() - "FigJpg.Visible = .f. / FigJpg.Picture = ''";
    *   FormParaBO()   - "Select crGrade" (a linha corrente da grade passa a
    *                    ser o item corrente do BO);
    *   BOParaForm()   - o CursorQuery de FigJpgs, o Strconv/StrToFile e os
    *                    tres Refresh finais.
    *
    * NAO filtra por par_nColIndex: o legado tambem nao filtra, e filtrar
    * aqui seria o defeito da regra #46 (nColIndex e a coluna de DESTINO).
    *==========================================================================
    PROCEDURE GrdItensAfterRowColChange(par_nColIndex)
        THIS.LockScreen = .T.

        THIS.LimparCampos()
        THIS.FormParaBO()
        THIS.BOParaForm()

        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    * GrdItensColumn2DblClick - Abre a Pesquisa Global de Produtos filtrada
    * pelo codigo da linha corrente, equivalente ao PROCEDURE DblClick de
    * grdItens.Column2.Text1 no legado (dump, linhas 1713-1728):
    *   Do Form SIGOPCGP.Scx Name ThisForm.poObjExt1 Linked With [SIGOPCGP] NoShow
    *   .fld_principal.Pag_Consulta.Commandgroup1.Command1.Click()       (Limpar Filtros)
    *   .fld_principal.Pag_Consulta.Filtro.Principal.get_produto_inicial.Value = Padr(This.Value, 10)
    *   .fld_principal.Pag_Consulta.Filtro.Principal.get_produto_final.Value   = Padr(This.Value, 10)
    *   .fld_principal.Pag_Consulta.grp_operacao.cmd_consulta.Click()    (Consultar)
    *
    * FormSigOpCgp (ja migrado) expoe o mesmo fluxo atraves de metodos
    * PUBLIC equivalentes - GrpLimparFiltrosClick()/BtnConsultarClick() -
    * chamados aqui no lugar de simular clique em CommandGroup/Buttons
    * (regra #38: dentro de WITH nao ha .Self, e Buttons(N) e colecao, nao
    * API publica estavel para chamar de fora). PUBLIC (sem par_cModo) para
    * ser alvo de BINDEVENT "DblClick" (regra #3).
    *==========================================================================
    PROCEDURE GrdItensColumn2DblClick()
        LOCAL loc_cCodigoProduto, loc_oForm, loc_oErro, loc_oPag
        loc_oForm = .NULL.

        loc_cCodigoProduto = ALLTRIM(TratarNulo(THIS.grd_4c_Itens.Column2.Text1.Value, ""))

        IF !EMPTY(loc_cCodigoProduto)
            TRY
                loc_oForm = CREATEOBJECT("Formsigopcgp")
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao abrir Pesquisa Global de Produtos")
                loc_oForm = .NULL.
            ENDTRY

            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.GrpLimparFiltrosClick()

                loc_oPag = loc_oForm.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
                loc_oPag.txt_4c_ProdutoI.Value = PADR(loc_cCodigoProduto, 10)
                loc_oPag.txt_4c_ProdutoF.Value = PADR(loc_cCodigoProduto, 10)

                loc_oForm.BtnConsultarClick()
                loc_oForm.Show()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSubniveisClick - Abre o form de subniveis/movimentacao relacionada,
    * equivalente a "Do Form SigMvMvt With .f., <Emps>, <Dopes>, <Nums>" do
    * legado (o .f. e par_lModal=.F. -> FormSIGMVMVT.WindowType=0, Show() NAO
    * bloqueia - por isso pode ficar dentro do mesmo TRY sem o risco da
    * regra #29, que e especifica de Show() MODAL).
    *==========================================================================
    PROCEDURE BtnSubniveisClick()
        LOCAL loc_oForm, loc_oErro
        loc_oForm = .NULL.

        TRY
            loc_oForm = CREATEOBJECT("FormSIGMVMVT", .F., THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNums)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir Subniveis")
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEntregaClick - Abre o form de Entrega/Previsao do documento,
    * equivalente a "Do Form SigOpDen With <Emps>, <Dopes>, <Nums>" do
    * legado. FormSigOpDen ainda NAO foi migrado neste acervo (nao existe em
    * projeto\app\forms) - o CATCH informa a falha real (classe ausente) em
    * vez de fingir sucesso ou abrir tela quebrada; assim que SigOpDen for
    * migrado em outra task, este botao passa a funcionar sem alteracao.
    *==========================================================================
    PROCEDURE BtnEntregaClick()
        LOCAL loc_oForm, loc_oErro
        loc_oForm = .NULL.

        TRY
            loc_oForm = CREATEOBJECT("FormSigOpDen", THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNums)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir Entrega")
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdsairClick - Encerra o form (equivalente a ThisForm.Release do
    * legado - regra #8/#29: THIS.Release(), fora de qualquer TRY).
    *==========================================================================
    PROCEDURE CmdsairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * CarregarItens - Popula cursor_4c_Grade/cursor_4c_Rodape via o BO
    * (equivalente a .SelecionaDados do legado) e repinta as duas grades
    * (regra #21 do CLAUDE.md - popular cursor NAO repinta a grade sozinho).
    * Chamado por CarregarLista(), que e a entrada canonica de carga (e quem
    * sincroniza depois o item corrente com o BO e com a area de detalhe).
    * Continua PUBLIC para permitir recarregar SO as grades, sem mexer no
    * detalhe - por exemplo ao voltar de Subniveis/Entrega.
    *==========================================================================
    PROCEDURE CarregarItens()
        LOCAL loc_lSucesso, loc_cCursorGrade, loc_cCursorRodape
        loc_lSucesso = THIS.this_oBusinessObject.CarregarItens()

        loc_cCursorGrade  = THIS.this_oBusinessObject.this_cCursorGrade
        loc_cCursorRodape = THIS.this_oBusinessObject.this_cCursorRodape

        IF loc_lSucesso
            IF USED(loc_cCursorGrade)
                GO TOP IN (loc_cCursorGrade)
            ENDIF
            IF USED(loc_cCursorRodape)
                GO TOP IN (loc_cCursorRodape)
            ENDIF

            THIS.grd_4c_Itens.Refresh()
            THIS.grd_4c_Rodape.Refresh()
        ELSE
            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao carregar itens")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarLista - Entrada canonica de carga da tela: popula as duas
    * grades (CarregarItens -> BO.CarregarItens) e, em seguida, sincroniza o
    * item CORRENTE com o Business Object e com a area de detalhe do
    * produto. Equivale ao trecho final do Init legado, que chama
    * ".SelecionaDados" e logo depois ".grdItens.Refresh / .grdRodape.Refresh"
    * deixando a 1a linha selecionada com a foto/descricao ja na tela.
    *
    * PUBLIC (sem PROTECTED) de proposito: alem de InicializarForm(), este
    * metodo e chamado de FORA da classe pelo harness TesteAutomatico.prg
    * (THIS.oForm.CarregarLista()) - PROTECTED aqui falharia em runtime com
    * "Property CARREGARLISTA is not found" (CLAUDE.md regra #3).
    *
    * A "lista" desta tela e a grade de itens do documento: nao ha Page1 de
    * listagem CRUD (o legado e um form FLAT de consulta, ver cabecalho).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = THIS.CarregarItens()

        IF loc_lSucesso
            *-- Mesma sequencia do AfterRowColChange: limpa o detalhe, leva a
            *-- linha corrente para o BO e repinta a partir dele. Sem isto, a
            *-- 1a linha ficaria selecionada na grade com a foto do produto
            *-- em branco ate o usuario mexer no cursor da grade.
            THIS.LimparCampos()
            IF THIS.FormParaBO()
                THIS.BOParaForm()
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere o que esta SELECIONADO na tela para o Business
    * Object: a linha corrente da grade de itens vira o item corrente do BO
    * (this_cCodigoProduto, this_cDescricaoProduto, this_nQtdSaldo, ...).
    * Equivale ao "Select crGrade" que abre o AfterRowColChange legado e as
    * referencias "crGrade.<campo>" que vem depois dele.
    *
    * Esta tela e de CONSULTA - nao ha campo digitavel cujo .Value precise
    * voltar para o BO (Get_descr/Get_obs tem ControlSource direto no cursor
    * e When -> .F. no legado). O sentido util de "form -> BO" aqui e,
    * portanto, a SELECAO, e e ela que alimenta BOParaForm() e
    * BO.CarregarImagemProduto().
    *
    * PROTECTED explicito: FormBase.prg ja declara FormParaBO/BOParaForm/
    * LimparCampos como PROTECTED, e em VFP9 o escopo da base PREVALECE -
    * omitir o modificador aqui NAO tornaria o metodo publico, so esconderia
    * do leitor que ele e interno (CLAUDE.md regra #51). Os tres sao
    * chamados sempre por THIS., de dentro da classe.
    *
    * Restaura a area de trabalho anterior: BO.CarregarDoCursor() faz
    * SELECT no cursor da grade e deixaria o alias corrente trocado para
    * quem chamou (o AfterRowColChange dispara no meio de outras operacoes).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_cCursorGrade, loc_cAliasAnterior
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cAliasAnterior = ALIAS()
            loc_cCursorGrade   = THIS.this_oBusinessObject.this_cCursorGrade

            IF USED(loc_cCursorGrade) AND !EOF(loc_cCursorGrade) AND !BOF(loc_cCursorGrade)
                loc_lSucesso = THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursorGrade)
            ENDIF

            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - Leva o item corrente do Business Object para a tela: le a
    * foto do produto (BO.CarregarImagemProduto -> cursor_4c_Produto.FigJpgs),
    * decodifica o Base64 para o arquivo temporario e exibe em img_4c_FigJpg,
    * repintando depois a grade e os campos de detalhe. E o corpo do
    * AfterRowColChange legado (dump, linhas 1672-1701), transcrito.
    *
    * Decodificar o Base64 e gravar o JPG e responsabilidade da camada de UI
    * (o BO so entrega o cursor) - mesmo padrao de sigprcpdBO/ClienteBO.
    *
    * CLEAR RESOURCES antes de regravar THIS.this_cArquivo reproduz o
    * "Clear Resources" do legado - sem ele, reatribuir o MESMO caminho de
    * arquivo a .Picture nao forca o VFP9 a reler o conteudo (cache de GDI),
    * e a foto da linha anterior ficaria "colada" na tela.
    *
    * Descricao e Observacao NAO sao atribuidas aqui: tem ControlSource
    * direto em cursor_4c_Grade (fiel ao legado, que liga Get_descr a
    * "crGrade.DPros") e seguem a linha corrente sozinhas - so precisam do
    * Refresh final, igual ao "ThisForm.Get_Obs.Refresh" do legado.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_cCursorProduto, loc_cCodigoProduto
        LOCAL loc_cFigJpgs, loc_cFoto, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO            = THIS.this_oBusinessObject
            loc_cCursorProduto = loc_oBO.this_cCursorProduto
            loc_cCodigoProduto = ALLTRIM(TratarNulo(loc_oBO.this_cCodigoProduto, ""))

            IF loc_oBO.this_nImagems = 1 AND !EMPTY(loc_cCodigoProduto) ;
                    AND PEMSTATUS(THIS, "img_4c_FigJpg", 5) ;
                    AND loc_oBO.CarregarImagemProduto(loc_cCodigoProduto) ;
                    AND USED(loc_cCursorProduto) ;
                    AND TYPE(loc_cCursorProduto + ".FigJpgs") != "U"

                loc_cFigJpgs = EVALUATE(loc_cCursorProduto + ".FigJpgs")

                IF !ISNULL(loc_cFigJpgs) AND !EMPTY(loc_cFigJpgs)
                    CLEAR RESOURCES

                    loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)

                    IF STRTOFILE(loc_cFoto, THIS.this_cArquivo) > 0
                        THIS.img_4c_FigJpg.Picture = THIS.this_cArquivo
                        THIS.img_4c_FigJpg.Visible = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                THIS.grd_4c_Itens.Refresh()
            ENDIF
            THIS.Refresh()
            IF PEMSTATUS(THIS, "obj_4c_Get_obs", 5)
                THIS.obj_4c_Get_obs.Refresh()
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera a area de detalhe do produto antes de recarregar:
    * esconde e descarrega a foto. E o bloco de abertura do AfterRowColChange
    * legado (FigJpg.Visible = .f. / FigJpg.Picture = vazio).
    *
    * Descricao e Observacao NAO sao limpas por codigo: tem ControlSource
    * direto em cursor_4c_Grade (igual ao legado) e acompanham a linha
    * corrente sozinhas - atribuir .Value nelas GRAVARIA no cursor, que e o
    * oposto do que esta tela de consulta deve fazer.
    *
    * O guard PEMSTATUS existe porque AfterRowColChange pode disparar
    * enquanto a tela ainda esta sendo montada (a imagem e criada depois das
    * grades, em ConfigurarElementosVisuais).
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "img_4c_FigJpg", 5)
            THIS.img_4c_FigJpg.Visible = .F.
            THIS.img_4c_FigJpg.Picture = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * Activate - Coloca o foco na grade de itens na PRIMEIRA exibicao do
    * form, equivalente a ".grdItens.Column1.Setfocus" do fim do Init
    * legado. Nao pode ficar no Init: la o controle ainda nao foi desenhado
    * e o SetFocus nao tem efeito.
    *
    * A trava this_lFocoInicialDado evita roubar o foco a cada reativacao
    * (voltar de Subniveis/Entrega reativa este form). Sem TRY/CATCH de
    * proposito: as duas condicoes que fariam o SetFocus falhar - grade
    * inexistente/invisivel, form ainda nao desenhado e grade sem linha -
    * estao todas testadas antes
    * (CLAUDE.md regra #9: CATCH nunca silencioso; aqui nao ha CATCH a
    * silenciar porque nao ha excecao esperada).
    *==========================================================================
    PROCEDURE Activate()
        LOCAL loc_cCursorGrade

        IF !THIS.this_lFocoInicialDado AND PEMSTATUS(THIS, "grd_4c_Itens", 5) ;
                AND VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cCursorGrade = THIS.this_oBusinessObject.this_cCursorGrade

            IF THIS.Visible AND THIS.grd_4c_Itens.Visible AND THIS.grd_4c_Itens.Enabled ;
                    AND USED(loc_cCursorGrade) AND RECCOUNT(loc_cCursorGrade) > 0
                THIS.this_lFocoInicialDado = .T.
                THIS.grd_4c_Itens.Column1.SetFocus()
            ENDIF
        ENDIF

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * Destroy - Libera o Business Object. Fecha os cursores que as fases
    * seguintes virao a criar (cursor_4c_Grade/Rodape/Produto), repetindo
    * aqui o equivalente a ThisForm.poDataMgr.Release do Release legado -
    * a liberacao de conexao propriamente dita e feita pelo BO/gnConnHandle
    * global, nao por form.
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Grade")
            USE IN cursor_4c_Grade
        ENDIF
        IF USED("cursor_4c_Rodape")
            USE IN cursor_4c_Rodape
        ENDIF
        IF USED("cursor_4c_Produto")
            USE IN cursor_4c_Produto
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpriteBO.prg):
*==============================================================================
* SIGPRITEBO.PRG
* Business Object - Itens do Documento (Movimentacao)
* Entidade: SigMvItn (join com SigCdOpe e SigCdPro) - form OPERACIONAL somente-leitura
* Origem legado: tasks\task633\sigprite_form_codigo_fonte.txt (SIGPRITE.SCX)
*==============================================================================

DEFINE CLASS sigpriteBO AS BusinessBase

    *-- Chave do documento (equivalente ao EmpDopNum do legado - chave POSICIONAL)
    this_cEmps = ""              && Codigo da empresa - PADR(3) (pEmp)
    this_cDopes = ""             && Codigo do documento/operacao - PADR(20) (pDop)
    this_nNums = 0               && Numero do documento (pNum)
    this_cEmpDopNum = ""         && Chave concatenada PADR(Emps,3)+PADR(Dopes,20)+STR(Nums,6) = 29 chars

    *-- Parametros de comportamento recebidos pelo form (pDis/pCnx do legado)
    this_lChecaDisps = .F.       && Indica se a disponibilidade do produto deve ser conferida (pDis)

    *-- Dados auxiliares de SigCdOpe (consultados para a operacao do documento)
    this_nImagems = 0            && SigCdOpe.Imagems - flag que habilita exibicao da foto do produto

    *-- Arquivo temporario usado para decodificar a imagem do produto (Base64 -> JPG)
    this_cArquivo = ""           && Sys(2023) + "\" + Sys(2015) + ".Jpg" (equivalente ao .Arquivo do legado)

    *-- Dados do item CORRENTE (populados por CarregarDoCursor a partir da
    *-- linha ativa de cursor_4c_Grade - equivalente ao Scatter da grade)
    this_nItens = 0               && crGrade.CItens (numero sequencial = RECNO da consulta original, regra do legado)
    this_cCodigoProduto = ""      && crGrade.CPros
    this_cDescricaoProduto = ""   && crGrade.DPros (Get_descr)
    this_cObservacao = ""         && crGrade.Obs - memo (Get_obs)
    this_cUnidade = ""            && crGrade.CUnis
    this_nVolume = 0              && crGrade.Volumes
    this_cOperacao = ""           && crGrade.Opers
    this_nQtdOriginal = 0         && crGrade.QtdOs (a.Qtds)
    this_nQtdBaixada = 0          && crGrade.QtdBs (a.QtBaixas)
    this_nQtdSaldo = 0            && crGrade.QtdSs (a.Qtds - a.QtBaixas)
    this_nValorUnitario = 0       && crGrade.Units
    this_cMoeda = ""              && crGrade.CMoes (a.Moedas)
    this_nValorTotal = 0          && crGrade.Totas

    *-- Nomes dos cursores que este BO popula (propriedade para o Form
    *-- referenciar sem repetir literais - mesmo padrao de SigMvSbnBO)
    this_cCursorGrade = "cursor_4c_Grade"       && Grid de itens (equivalente a crGrade)
    this_cCursorRodape = "cursor_4c_Rodape"     && Grid de totais por moeda (equivalente a crRodape)
    this_cCursorProduto = "cursor_4c_Produto"   && Dados/imagem do produto exibido (equivalente a LocalPro)

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigMvItn"
        THIS.this_cCampoChave = "CItens"

        *-- Arquivo temporario para a foto do produto (equivalente a
        *-- Sys(2023) + "\" + Sys(2015) + ".Jpg" do Init legado)
        THIS.this_cArquivo = SYS(2023) + "\" + SYS(2015) + ".Jpg"

        RETURN .T.
    ENDPROC

    *==========================================================================
    * InicializarCursores - Cria (ou recria vazios) os cursores READWRITE
    * usados pelas grades do form (equivalente ao PROCEDURE Load do legado,
    * que faz Create Cursor crGrade/crRodape ANTES do Init popular os
    * dados). O Form deve chamar isto UMA VEZ, ANTES de configurar o
    * RecordSource dos grids (regra #41 do CLAUDE.md - Column.ControlSource
    * de cursor que ainda nao existe derruba o Init). Chamadas seguintes de
    * CarregarItens() so fazem ZAP + INSERT - nunca recriam a estrutura,
    * para nao perder o binding do Grid (regra do cursor compartilhado).
    *==========================================================================
    PROCEDURE InicializarCursores()
        IF USED(THIS.this_cCursorGrade)
            USE IN (THIS.this_cCursorGrade)
        ENDIF
        IF USED(THIS.this_cCursorRodape)
            USE IN (THIS.this_cCursorRodape)
        ENDIF

        CREATE CURSOR (THIS.this_cCursorGrade) (CItens N(10), CPros C(14), DPros C(40), ;
            Obs M, CUnis C(3), Volumes N(3), Opers C(1), QtdOs N(10,3), QtdBs N(10,3), ;
            QtdSs N(10,3), Units N(12,2), CMoes C(3), Totas N(12,2), Disps N(10,3))

        CREATE CURSOR (THIS.this_cCursorRodape) (CPros C(14), Volumes N(3), QtdOs N(10,3), ;
            QtdBs N(10,3), QtdSs N(10,3), CMoes C(3), Totas N(12,2))

        RETURN .T.
    ENDPROC

    *==========================================================================
    * MontarChaveEmpDopNum - Monta a chave Emps+Dopes+Str(Nums,6) usada pelo
    * legado (ThisForm.EmpDopNum) para filtrar os itens do documento
    * (SigMvItn.EmpDopNums). Publico porque ObterChavePrimaria() delega
    * para aqui, igual ao padrao de SigMvSbnBO.MontarChaveEmpDopNums.
    *==========================================================================
    FUNCTION MontarChaveEmpDopNum(par_cEmps, par_cDopes, par_nNums)
        *-- Chave POSICIONAL de 29 caracteres FIXOS (regra #42 do CLAUDE.md):
        *-- Emps char(3) + Dopes char(20) + Str(Nums,6) = 29 = largura de
        *-- SigMvItn.EmpDopNums (docs\schema.sql). ALLTRIM nas partes quebra
        *-- a busca em SILENCIO (o SELECT roda sem erro e devolve ZERO
        *-- linhas) porque perde o padding no MEIO da chave concatenada -
        *-- por isso PADR explicito em cada parte, nunca ALLTRIM.
        RETURN PADR(TratarNulo(par_cEmps, ""), 3) + ;
               PADR(TratarNulo(par_cDopes, ""), 20) + ;
               STR(TratarNulo(par_nNums, 0), 6)
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Chave logica do documento (EmpDopNum). SIGPRITE
    * nunca grava (ver Inserir/Atualizar abaixo), entao RegistrarAuditoria()
    * nunca chega a usar este valor - existe so para cumprir o contrato de
    * BusinessBase.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.MontarChaveEmpDopNum(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNums)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas da linha CORRENTE de
    * cursor_4c_Grade (equivalente ao Select crGrade + referencias diretas
    * ao Scatter da grade de itens no legado) para as propriedades this_*
    * do item selecionado. O Form chama isto a partir do AfterRowColChange
    * da grade, antes de pedir a imagem do produto.
    *   par_cAliasCursor - alias a ler; se omitido usa this_cCursorGrade
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_lSucesso
        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            par_cAliasCursor, THIS.this_cCursorGrade)

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto"
        ELSE
            SELECT (loc_cAlias)

            IF EOF() OR BOF()
                THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " registro corrente em " + loc_cAlias
            ELSE
                THIS.this_nItens            = TratarNulo(CItens, 0)
                THIS.this_cCodigoProduto    = TratarNulo(CPros, "")
                THIS.this_cDescricaoProduto = TratarNulo(DPros, "")
                THIS.this_cObservacao       = TratarNulo(Obs, "")
                THIS.this_cUnidade          = TratarNulo(CUnis, "")
                THIS.this_nVolume           = TratarNulo(Volumes, 0)
                THIS.this_cOperacao         = TratarNulo(Opers, "")
                THIS.this_nQtdOriginal      = TratarNulo(QtdOs, 0)
                THIS.this_nQtdBaixada       = TratarNulo(QtdBs, 0)
                THIS.this_nQtdSaldo         = TratarNulo(QtdSs, 0)
                THIS.this_nValorUnitario    = TratarNulo(Units, 0)
                THIS.this_cMoeda            = TratarNulo(CMoes, "")
                THIS.this_nValorTotal       = TratarNulo(Totas, 0)

                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir / Atualizar - SIGPRITE eh EXCLUSIVAMENTE uma tela de CONSULTA
    * (exibe os itens de um documento ja gravado por outras telas do
    * sistema - Movimentacao/Entrada/Saida). O codigo fonte legado inteiro
    * (tasks\task633\sigprite_form_codigo_fonte.txt) foi conferido e NAO
    * contem nenhum comando de gravacao (Insert/Update/Delete/TableUpdate/
    * Gather) contra tabela do SQL Server - so consultas (SqlExecute) e
    * Insert Into cursores LOCAIS (crGrade/crRodape/crDados, declarados no
    * proprio Load/Create Cursor). Inventar um INSERT/UPDATE aqui violaria
    * o PILAR 2 (nunca gravar algo que o legado nao grava). Os dois metodos
    * ficam sobrescritos apenas para deixar a mensagem explicita - o
    * comportamento padrao herdado de BusinessBase (recusar a operacao) ja
    * eh o correto; RegistrarAuditoria() nunca eh chamado porque nenhuma
    * gravacao ocorre.
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "SIGPRITE " + CHR(233) + " uma tela de consulta - n" + ;
            CHR(227) + "o grava registros."
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "SIGPRITE " + CHR(233) + " uma tela de consulta - n" + ;
            CHR(227) + "o grava registros."
        RETURN .F.
    ENDPROC

    *==========================================================================
    * CarregarFlagImagem - Busca SigCdOpe.Imagems para o Dopes do documento
    * (equivalente a .poDataMgr.CursorQuery('SigCdOpe','crSigCdOpe','Dopes',
    * Padr(pDop,20),'Imagems') do Init legado). Habilita/desabilita a
    * exibicao da foto do produto no AfterRowColChange da grade.
    *==========================================================================
    FUNCTION CarregarFlagImagem()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        THIS.this_cMensagemErro = ""
        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT Imagems FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))

            IF USED("cursor_4c_SigCdOpeTmp")
                USE IN cursor_4c_SigCdOpeTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpeTmp")

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crSigCdOpe)"
            ELSE
                SELECT cursor_4c_SigCdOpeTmp
                GO TOP
                THIS.this_nImagems = TratarNulo(Imagems, 0)
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_SigCdOpeTmp")
            USE IN cursor_4c_SigCdOpeTmp
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarItens - Monta cursor_4c_Grade/cursor_4c_Rodape com os itens do
    * documento (equivalente ao PROCEDURE SelecionaDados do legado). Chamar
    * DEPOIS de InicializarCursores() e de this_cEmps/this_cDopes/
    * this_nNums estarem preenchidos pelo Form.
    *==========================================================================
    FUNCTION CarregarItens()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nItens, loc_oErro

        THIS.this_cMensagemErro = ""
        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        IF !USED(THIS.this_cCursorGrade) OR !USED(THIS.this_cCursorRodape)
            THIS.InicializarCursores()
        ENDIF

        THIS.this_cEmpDopNum = THIS.MontarChaveEmpDopNum(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNums)

        TRY
            loc_cSQL = "SELECT a.CItens, a.CPros, a.DPros, a.Obs, a.CUnis, c.Volumes, a.Opers, " + ;
                "a.Qtds AS QtdOs, a.QtBaixas AS QtdBs, a.Qtds - a.QtBaixas AS QtdSs, " + ;
                "a.Units, a.Moedas AS CMoes, a.Totas " + ;
                "FROM SigMvItn a, SigCdOpe b, SigCdPro c " + ;
                "WHERE a.EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNum) + " AND " + ;
                "a.Dopes = b.Dopes AND a.CPros = c.CPros " + ;
                "ORDER BY a.CItens, a.CPros"

            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crDados)"
            ELSE
                SELECT (THIS.this_cCursorGrade)
                ZAP

                *-- m.CItens = Recno('crDados') no legado - o numero da linha
                *-- exibido eh o ORDINAL da consulta, nao o a.CItens cru
                loc_nItens = 0

                SELECT cursor_4c_DadosTmp
                SCAN
                    loc_nItens = loc_nItens + 1

                    INSERT INTO (THIS.this_cCursorGrade) (CItens, CPros, DPros, Obs, CUnis, ;
                        Volumes, Opers, QtdOs, QtdBs, QtdSs, Units, CMoes, Totas) VALUES ;
                        (loc_nItens, ;
                        TratarNulo(cursor_4c_DadosTmp.CPros, ""), ;
                        TratarNulo(cursor_4c_DadosTmp.DPros, ""), ;
                        TratarNulo(cursor_4c_DadosTmp.Obs, ""), ;
                        TratarNulo(cursor_4c_DadosTmp.CUnis, ""), ;
                        TratarNulo(cursor_4c_DadosTmp.Volumes, 0), ;
                        TratarNulo(cursor_4c_DadosTmp.Opers, ""), ;
                        TratarNulo(cursor_4c_DadosTmp.QtdOs, 0), ;
                        TratarNulo(cursor_4c_DadosTmp.QtdBs, 0), ;
                        TratarNulo(cursor_4c_DadosTmp.QtdSs, 0), ;
                        TratarNulo(cursor_4c_DadosTmp.Units, 0), ;
                        TratarNulo(cursor_4c_DadosTmp.CMoes, ""), ;
                        TratarNulo(cursor_4c_DadosTmp.Totas, 0))
                ENDSCAN

                *-- Totais por moeda (equivalente ao crTotal/crRodape do legado) -
                *-- GROUP BY local, sem variavel LOCAL embutida (regra #118 nao se aplica)
                SELECT CMoes, SUM(Volumes) AS Volumes, SUM(QtdOs) AS QtdOs, SUM(QtdBs) AS QtdBs, ;
                    SUM(QtdSs) AS QtdSs, SUM(Totas) AS Totas ;
                    FROM cursor_4c_DadosTmp ;
                    GROUP BY CMoes ;
                    INTO CURSOR cursor_4c_TotalTmp

                SELECT (THIS.this_cCursorRodape)
                ZAP

                SELECT cursor_4c_TotalTmp
                SCAN
                    INSERT INTO (THIS.this_cCursorRodape) (CPros, Volumes, QtdOs, QtdBs, QtdSs, ;
                        CMoes, Totas) VALUES ;
                        ("", ;
                        TratarNulo(cursor_4c_TotalTmp.Volumes, 0), ;
                        TratarNulo(cursor_4c_TotalTmp.QtdOs, 0), ;
                        TratarNulo(cursor_4c_TotalTmp.QtdBs, 0), ;
                        TratarNulo(cursor_4c_TotalTmp.QtdSs, 0), ;
                        TratarNulo(cursor_4c_TotalTmp.CMoes, ""), ;
                        TratarNulo(cursor_4c_TotalTmp.Totas, 0))
                ENDSCAN

                IF USED("cursor_4c_TotalTmp")
                    USE IN cursor_4c_TotalTmp
                ENDIF

                GO TOP IN (THIS.this_cCursorGrade)
                GO TOP IN (THIS.this_cCursorRodape)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_DadosTmp")
            USE IN cursor_4c_DadosTmp
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarImagemProduto - Busca Cpros/FigJpgs/Dpros do produto exibido
    * na linha corrente (equivalente ao CursorQuery('SigCdPro','LocalPro',
    * 'CPros', crGrade.CPros, 'FigJpgs') do AfterRowColChange legado).
    * Decodificar o Base64 de FigJpgs e gravar o JPG em disco (this_cArquivo)
    * eh responsabilidade do FORM (camada de UI), nao deste BO - mesmo
    * padrao de sigprcpdBO/ClienteBO.
    *==========================================================================
    FUNCTION CarregarImagemProduto(par_cCodigoProduto)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        THIS.this_cMensagemErro = ""
        loc_lSucesso = .F.

        IF EMPTY(TratarNulo(par_cCodigoProduto, ""))
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT Cpros, FigJpgs, Dpros FROM SigCdPro WHERE Cpros = " + ;
                EscaparSQL(ALLTRIM(par_cCodigoProduto))

            IF USED(THIS.this_cCursorProduto)
                USE IN (THIS.this_cCursorProduto)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorProduto))

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crTPro)"
            ELSE
                SELECT (THIS.this_cCursorProduto)
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

