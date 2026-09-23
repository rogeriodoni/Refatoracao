# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarDadosReais': Sem conexao ao banco (gnConnHandle invalido)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-09-18 19:29:48] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-18 19:29:48] [INFO] Config FPW: (nao fornecido)
[2026-09-18 19:29:48] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-18 19:29:48] [INFO] Timeout: 300 segundos
[2026-09-18 19:29:48] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4gjamxiz.prg
[2026-09-18 19:29:48] [INFO] Conteudo do wrapper:
[2026-09-18 19:29:48] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormTPG', 'C:\4c\tasks\task544', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormTPG', 'C:\4c\tasks\task544', 'OPERACIONAL'
QUIT

[2026-09-18 19:29:48] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4gjamxiz.prg
[2026-09-18 19:29:48] [INFO] VFP output esperado em: C:\4c\tasks\task544\vfp_output.txt
[2026-09-18 19:29:48] [INFO] Executando Visual FoxPro 9...
[2026-09-18 19:29:48] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4gjamxiz.prg
[2026-09-18 19:29:48] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4gjamxiz.prg
[2026-09-18 19:29:48] [INFO] Timeout configurado: 300 segundos
[2026-09-18 19:31:38] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-18 19:31:38] [INFO] VFP9 finalizado em 110.265068 segundos
[2026-09-18 19:31:38] [INFO] Exit Code: 
[2026-09-18 19:31:38] [INFO] 
[2026-09-18 19:31:38] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-18 19:31:38] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4gjamxiz.prg
[2026-09-18 19:31:38] [INFO] 
[2026-09-18 19:31:38] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-18 19:31:38] [INFO] * Auto-generated wrapper for parameters
[2026-09-18 19:31:38] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-18 19:31:38] [INFO] * Parameters: 'FormTPG', 'C:\4c\tasks\task544', 'OPERACIONAL'
[2026-09-18 19:31:38] [INFO] 
[2026-09-18 19:31:38] [INFO] * Anti-dialog protections for unattended execution
[2026-09-18 19:31:38] [INFO] SET SAFETY OFF
[2026-09-18 19:31:38] [INFO] SET RESOURCE OFF
[2026-09-18 19:31:38] [INFO] SET TALK OFF
[2026-09-18 19:31:38] [INFO] SET NOTIFY OFF
[2026-09-18 19:31:38] [INFO] SYS(2335, 0)
[2026-09-18 19:31:38] [INFO] 
[2026-09-18 19:31:38] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormTPG', 'C:\4c\tasks\task544', 'OPERACIONAL'
[2026-09-18 19:31:38] [INFO] QUIT
[2026-09-18 19:31:38] [INFO] 
[2026-09-18 19:31:38] [INFO] === Fim do Wrapper.prg ===
[2026-09-18 19:31:38] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormTPG",
  "timestamp": "20260918193138",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "ContainersFlutuantes",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum container flutuante encontrado (OK)"
    },
    {
      "nome": "CarregarDadosReais",
      "passou": false,
      "erro": "Sem conexao ao banco (gnConnHandle invalido)",
      "detalhes": ""
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum PageFrame encontrado (form sem paginas)"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Form OPERACIONAL com BtnIncluirClick sem navegacao por PageFrame (OK)"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnEncerrarClick encontrado"
    },
    {
      "nome": "GridTemDados",
      "passou": true,
      "erro": "",
      "detalhes": "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": true,
      "erro": "",
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 4 (COL1EMPSKEYPRESS, COL2TPTRANSKEYPRESS, COL3TPSKEYPRESS, KEYPRESS)"
    },
    {
      "nome": "Fechar",
      "passou": true,
      "erro": "",
      "detalhes": "Formulario fechado com sucesso"
    }
  ],
  "resumo": {
    "total": 9,
    "passou": 8,
    "falhou": 1,
    "percentual": 89
  }
}



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormTPG.prg):
*==============================================================================
* FormTPG.prg - Form Operacional: Tipos de Transporte Automatico
* SCX Origem: SIGCDTPG.SCX
* Herda de: FormBase
* Tipo: OPERACIONAL - modal, flat layout (sem PageFrame), grade editavel
*
* Layout do legado (single-page, sem abas):
*   cntSombra (cabecalho escuro)      -> cnt_4c_Cabecalho
*   Grid1 (Emps/TpTrans/Tps editaveis) -> grd_4c_Dados
*   cmdinserir / cmdexcluir            -> cnt_4c_Botoes.cmd_4c_Incluir/Excluir
*   Commandgroup1.Command3 "Encerrar"  -> cnt_4c_Saida.cmd_4c_Encerrar
*     (no legado, o clique de Encerrar tambem valida a grade e grava tudo
*     via poDataMgr.Update+Commit antes de fechar - ver comportamento.json)
*
* Fase 3/8 - Estrutura base: propriedades, Init, InicializarForm, cabecalho
* Fase 4/8 - Grid editavel + botoes Incluir/Excluir/Encerrar
*   A grade legada eh editada linha-a-linha em memoria e so persiste tudo
*   no clique de Encerrar (poDataMgr.Update+Commit, modelo bufferizado).
*   BusinessBase/DataAccess desta arquitetura nao tem commit em lote, entao
*   a adaptacao persiste linha a linha (Salvar()/ExcluirPorChave() por
*   registro) preservando o MESMO resultado final que o usuario ve: a
*   validacao (Empty(Emps)/Empty(Tps)) roda ANTES de qualquer gravacao,
*   igual ao legado, e Excluir remove o registro na hora (nao bufferiza).
*   Sem AlternarPagina(): este form eh flat/single-page (sem PageFrame,
*   ver Fase 3) - nao existe segunda pagina para alternar. Criar um metodo
*   vazio so para "existir" seria um stub disfarcado (proibido).
* Fase 5/8 - N/A (ConfigurarPaginaDados / campos de Page2): o SIGCDTPG legado
*   nao tem segunda pagina de edicao (analise.json: campos=[], labels=[];
*   layout.json: 16 objetos, todos ja cobertos nas Fases 3-4). Os 3 unicos
*   dados (Emps/TpTrans/Tps) sao editados direto nas colunas do Grid1, ja
*   migradas em ConfigurarGrid()/ConfigurarGridDados() (Fase 4). Mesma
*   excecao que o CLAUDE.md ja documenta para FormFpd/FormGcp: form sem
*   pagina de dados real. Adicionar um ConfigurarPaginaDados() vazio so
*   para bater com o template das Fases 5-7 seria o mesmo stub disfarcado
*   vetado acima para AlternarPagina() - por isso a Fase 5 nao alterou
*   este arquivo.
* Fase 7/8 - N/A (BtnAlterarClick/BtnVisualizarClick): o SIGCDTPG legado
*   (SECAO 1 do dump) tem SOMENTE 3 CommandButtons - cmdinserir, cmdexcluir
*   e Command3 "Encerrar" dentro de Commandgroup1 (ButtonCount=1). NAO
*   existe Alterar nem Visualizar no original. A edicao dos dados eh feita
*   direto nas celulas do Grid1 (Column1/2/3.Text1.ControlSource ligado a
*   crSigPrTrn.Emps/TpTrans/Tps, com Valid por coluna) - ja migrada como
*   Col1EmpsKeyPress/Col2TpTransKeyPress/Col3TpsKeyPress na Fase 6.
*   BtnIncluirClick e BtnExcluirClick (os 2 unicos botoes CRUD do legado)
*   ja foram implementados na Fase 4, e BtnEncerrarClick (o Command3 -
*   equivalente ao "Salvar" deste form) tambem. Criar BtnAlterarClick/
*   BtnVisualizarClick vazios so para bater com o template das fases
*   seria tanto um stub disfarcado (proibido) quanto uma funcionalidade
*   inventada sem base no legado (viola o PILAR 1) - por isso a Fase 7
*   nao alterou os metodos de clique deste form.
* Fase 6/8 - Lookups das 3 colunas do Grid1 (fonte: SIGCDTPG_form_codigo_
*   fonte.txt, secao 3, Valid de Column1/Column2/Column3.Text1):
*   - Column1 (Emps): legado chama fAcessoEmpresa(Usuar,'C',...) - funcao
*     NAO portada (lesson feedback_facessoempresa_nao_portada). Substituida
*     pelo padrao canonico: valida existencia em SigCdEmp e abre
*     AbrirLookupCanonico("SigCdEmp","cemps","razas",...) quando nao acha
*     ou quando o usuario pede F4.
*   - Column2 (TpTrans): legado chama CreateObject('fwBuscaSel',
*     'crSigPrTrn','Codigos',...) com mAddColuna('Codigos'.../'Descrs'...).
*     'crSigPrTrn' e o alias do cursor principal (carregado de SigPrTra no
*     Init, que NAO tem colunas Codigos/Descrs) - o SEEK/lookup so faz
*     sentido contra a tabela MESTRE SigPrTrn (schema: codigos char(6) +
*     descrs char(20), EXATAMENTE do tamanho de TpTrans e dos nomes de
*     coluna citados no mAddColuna). Nome copiado do original (fwBuscaSel
*     recebe o mesmo texto 'SigPrTrn' sem o prefixo de cursor 'cr') -
*     NAO e tabela inventada.
*   - Column3 (Tps): legado so restringe a INLIST('T','R'), sem lookup.
*   - Os 3 Valid do legado terminam com a MESMA checagem de duplicidade
*     (Emps+TpTrans+Tps ja cadastrado em outra linha) - replicada em
*     ValidarDuplicidadeLinha(), chamada pelos 3 handlers apos a validacao
*     especifica de cada coluna.
* Fase 8/8 - Consolidacao final. O template generico desta fase pede
*   BtnBuscarClick/BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/
*   HabilitarCampos/LimparCampos/CarregarLista(no Form)/AjustarBotoesPorModo
*   - nenhum tem base no SIGCDTPG legado (mesmo raciocinio ja registrado
*   nas Fases 5 e 7): nao ha botao Buscar (a lista carrega tudo no Init);
*   nao ha Salvar/Cancelar por registro nem modos INCLUIR/ALTERAR/
*   VISUALIZAR (edicao eh direto na celula do grid, ver Fase 6, e a
*   persistencia em lote acontece so no clique de Encerrar); nao ha
*   segunda pagina de dados, logo FormParaBO/BOParaForm/HabilitarCampos/
*   LimparCampos (que existem para sincronizar campos soltos de uma pagina
*   de edicao) nao tem o que fazer aqui - a "sincronizacao" equivalente ja
*   acontece linha a linha dentro do SCAN de BtnEncerrarClick. Adicionar
*   qualquer um desses metodos vazio ou com logica inventada seria stub
*   disfarcado (proibido) ou funcionalidade sem base no legado (viola o
*   PILAR 1). Ajustes reais desta fase: (1) BtnEncerrarClick agora marca
*   flagnovo=.F. apos cada linha persistida com sucesso - sem isso, um
*   reenvio apos falha parcial no SCAN tentava reinserir linha ja gravada
*   e colidia com a PK cidchaves; (2) integracao no menu (popMovimentos,
*   bar 125 -> AbrirFormTPG) - config.prg ja carrega TPGBO.prg/FormTPG.prg
*   automaticamente via ADIR, sem SET PROCEDURE manual (CLAUDE.md
*   "config.prg - Dynamic Loading").
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS FormTPG AS FormBase

    *-- Propriedades visuais (copiadas do SIGCDTPG.SCX original - PILAR 1)
    Width       = 592
    Height      = 408
    AutoCenter  = .T.
    Caption     = "Tipos de Transporte Autom" + CHR(225) + "tico"
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    BorderStyle = 2

    *==========================================================================
    * Init - DODEFAULT() ja chama FormBase.Init() -> THIS.InicializarForm()
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria o Business Object e monta o cabecalho do form
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            THIS.this_oBusinessObject = CREATEOBJECT("TPGBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar TPGBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "FormTPG.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarPaginaLista()
                THIS.BindEventos()

                *-- Pula carga SQL em modo de validacao de UI (sem conexao)
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.this_oBusinessObject.CarregarLista()
                ENDIF
                THIS.ConfigurarGridDados()

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormTPG.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria o cabecalho do form operacional
    * Form OPERACIONAL sem PageFrame (SIGCDTPG legado eh single-page: o
    * Grid1 e os botoes Incluir/Excluir/Encerrar ficam direto na THIS)
    * Fase 3: apenas o cabecalho (cnt_4c_Cabecalho)
    * Fase 4: grade de tipos de transporte + botoes Incluir/Excluir/Encerrar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro

        TRY
            *-- Cabecalho escuro (cntSombra do legado: Top=-2, Left=-2, W=800, H=80)
            THIS.AddObject("cnt_4c_Cabecalho", "Container")
            WITH THIS.cnt_4c_Cabecalho
                .Top         = -2
                .Left        = -2
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = ""
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = THIS.Width - 20
                .ForeColor = RGB(0, 0, 0)
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = ""
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = THIS.Width - 20
                .ForeColor = RGB(255, 255, 255)
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormTPG.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Sem containers flutuantes neste form (nenhum Visible=.F. proposital)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Orquestra a montagem da grade e dos botoes
    * (unico "pagina" deste form flat/single-page - ver nota de cabecalho)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarGrid()
        THIS.ConfigurarBotoesCrud()
        THIS.ConfigurarBotaoEncerrar()
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Grid1 do legado -> grd_4c_Dados (3 colunas editaveis)
    * Posicoes EXATAS do SIGCDTPG.SCX (Top=96,Left=201,W=233,H=308) - form eh
    * flat/sem PageFrame (Fase 3), entao nao ha compensacao de +29 no Top
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid, loc_oCol

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados

        WITH loc_oGrid
            .Top           = 96
            .Left          = 201
            .Width         = 233
            .Height        = 308
            .ColumnCount   = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .ForeColor     = RGB(90, 90, 90)
            .GridLineColor = RGB(238, 238, 238)
            .Visible       = .T.
        ENDWITH

        *-- Column1: Empresa (Emps) - alinhado a direita
        loc_oCol = loc_oGrid.Column1
        WITH loc_oCol
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 3
            .Width     = 56
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oCol.Header1.Caption   = "Empresa"
        loc_oCol.Header1.FontName  = "Tahoma"
        loc_oCol.Header1.FontSize  = 8
        loc_oCol.Header1.ForeColor = RGB(90, 90, 90)
        loc_oCol.Text1.FontName    = "Tahoma"
        loc_oCol.Text1.FontSize    = 8
        loc_oCol.Text1.Alignment   = 3
        loc_oCol.Text1.BorderStyle = 0
        loc_oCol.Text1.Margin      = 0
        loc_oCol.Text1.ForeColor   = RGB(90, 90, 90)
        loc_oCol.Text1.BackColor   = RGB(255, 255, 255)

        *-- Column2: Tipo de Transporte (TpTrans)
        loc_oCol = loc_oGrid.Column2
        WITH loc_oCol
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Width     = 89
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oCol.Header1.Caption   = "Tipo de Transp."
        loc_oCol.Header1.FontName  = "Tahoma"
        loc_oCol.Header1.FontSize  = 8
        loc_oCol.Header1.ForeColor = RGB(90, 90, 90)
        loc_oCol.Text1.FontName    = "Tahoma"
        loc_oCol.Text1.FontSize    = 8
        loc_oCol.Text1.BorderStyle = 0
        loc_oCol.Text1.Margin      = 0
        loc_oCol.Text1.ForeColor   = RGB(90, 90, 90)
        loc_oCol.Text1.BackColor   = RGB(255, 255, 255)

        *-- Column3: Tipo T/R (Tps) - alinhado ao centro
        loc_oCol = loc_oGrid.Column3
        WITH loc_oCol
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Width     = 56
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oCol.Header1.Caption   = "Tipo (T/R)"
        loc_oCol.Header1.FontName  = "Tahoma"
        loc_oCol.Header1.FontSize  = 8
        loc_oCol.Header1.ForeColor = RGB(90, 90, 90)
        loc_oCol.Text1.FontName    = "Tahoma"
        loc_oCol.Text1.FontSize    = 8
        loc_oCol.Text1.Alignment   = 2
        loc_oCol.Text1.BorderStyle = 0
        loc_oCol.Text1.Margin      = 0
        loc_oCol.Text1.ForeColor   = RGB(90, 90, 90)
        loc_oCol.Text1.BackColor   = RGB(255, 255, 255)
    ENDPROC

    *==========================================================================
    * ConfigurarGridDados - Liga o grid ao cursor_4c_Dados (chamado apos
    * THIS.this_oBusinessObject.CarregarLista() preencher o cursor)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridDados()
        LOCAL loc_oGrid
        loc_oGrid = THIS.grd_4c_Dados

        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 3

        IF USED("cursor_4c_Dados")
            loc_oGrid.RecordSource = "cursor_4c_Dados"
            loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.emps"
            loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.tptrans"
            loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tps"
        ENDIF

        *-- RecordSource reseta Width/Header1.Caption (Problema 48) - reaplicar
        loc_oGrid.Column1.Width            = 56
        loc_oGrid.Column1.Header1.Caption  = "Empresa"
        loc_oGrid.Column2.Width            = 89
        loc_oGrid.Column2.Header1.Caption  = "Tipo de Transp."
        loc_oGrid.Column3.Width            = 56
        loc_oGrid.Column3.Header1.Caption  = "Tipo (T/R)"

        loc_oGrid.Refresh()
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesCrud - cnt_4c_Botoes com cmd_4c_Incluir/cmd_4c_Excluir
    * Posicoes EXATAS do legado: cmdinserir Left=366/Top=2, cmdexcluir
    * Left=441/Top=2, ambos filhos diretos de SIGCDTPG (sem container la;
    * agrupados aqui num container transparente so por organizacao interna)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesCrud()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Botoes", "Container")
        loc_oCnt = THIS.cnt_4c_Botoes
        WITH loc_oCnt
            .Top         = 2
            .Left        =  542
            .Width       = 150
            .Height      = 75
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Incluir
            .Top            = 0
            .Left           = 0
            .Width          = 75
            .Height         = 75
            .Caption        = "\<Incluir"
            .Picture        = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontName       = "Tahoma"
            .FontSize       = 8
            .ForeColor      = RGB(90, 90, 90)
            .BackColor      = RGB(255, 255, 255)
            .Themes         = .F.
            .SpecialEffect  = 0
            .PicturePosition = 13
            .MousePointer   = 15
            .WordWrap       = .T.
            .AutoSize       = .F.
            .Visible        = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Excluir
            .Top            = 0
            .Left = 230
            .Width          = 75
            .Height         = 75
            .Caption        = "\<Excluir"
            .Picture        = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontName       = "Tahoma"
            .FontSize       = 8
            .ForeColor      = RGB(90, 90, 90)
            .BackColor      = RGB(255, 255, 255)
            .Themes         = .F.
            .SpecialEffect  = 0
            .PicturePosition = 13
            .MousePointer   = 15
            .WordWrap       = .T.
            .AutoSize       = .F.
            .Visible        = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoEncerrar - Commandgroup1(Command3) do legado ->
    * cnt_4c_Saida.cmd_4c_Encerrar. Posicoes EXATAS do legado (Left=511,
    * W=90/H=110 + botao Left=5,W=75,H=75) - NAO eh o padrao canonico
    * Left=917 do CLAUDE.md #10, porque esse padrao vale so para forms CRUD
    * (frmcadastro, Width=1000); este eh OPERACIONAL flat com Width=592
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoEncerrar()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Saida", "Container")
        loc_oCnt = THIS.cnt_4c_Saida
        WITH loc_oCnt
            .Top         = 1
            .Left        = 917
            .Width       = 90
            .Height      = 110
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Encerrar
            .Top             = 0
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Cancel          = .T.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * BindEventos - Liga os cliques dos 3 botoes aos handlers (PUBLIC,
    * regra #3 - BINDEVENT exige metodo publico)
    *==========================================================================
    PROTECTED PROCEDURE BindEventos()
        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
        BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar,  "Click", THIS, "BtnEncerrarClick")

        *-- Lookups/validacao das 3 colunas editaveis do grid (Fase 6)
        BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "Col1EmpsKeyPress")
        BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "Col2TpTransKeyPress")
        BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "KeyPress", THIS, "Col3TpsKeyPress")
    ENDPROC

    *==========================================================================
    * Col1EmpsKeyPress - Column1.Text1 (Emps) KeyPress. Equivalente ao Valid
    * legado: fAcessoEmpresa(Usuar,'C',...) (funcao nao portada - lesson
    * feedback_facessoempresa_nao_portada) foi substituida por: F4 sempre
    * abre o lookup de Empresa; Enter/Tab valida existencia em SigCdEmp e,
    * se nao achar, abre o mesmo lookup. Ao final roda a checagem de
    * duplicidade Emps+TpTrans+Tps (igual nos 3 Valid do legado).
    *==========================================================================
    PROCEDURE Col1EmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oTxt, loc_cValor, loc_lAchou, loc_oErro

        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oTxt = THIS.grd_4c_Dados.Column1.Text1

            IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
                THIS.AbrirLookupEmpresa(loc_oTxt)
                THIS.ValidarDuplicidadeLinha(1)
            ELSE
                loc_cValor = ALLTRIM(NVL(loc_oTxt.Value, ""))

                IF !EMPTY(loc_cValor)
                    loc_lAchou = .F.

                    TRY
                        IF USED("cursor_4c_LkpChk")
                            USE IN cursor_4c_LkpChk
                        ENDIF

                        IF SQLEXEC(gnConnHandle, ;
                                "SELECT cemps FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cValor), ;
                                "cursor_4c_LkpChk") > 0 AND ;
                           USED("cursor_4c_LkpChk") AND RECCOUNT("cursor_4c_LkpChk") > 0
                            loc_lAchou = .T.
                        ENDIF

                        IF USED("cursor_4c_LkpChk")
                            USE IN cursor_4c_LkpChk
                        ENDIF
                    CATCH TO loc_oErro
                        MsgErro(loc_oErro.Message, "FormTPG.Col1EmpsKeyPress")
                    ENDTRY

                    IF !loc_lAchou
                        THIS.AbrirLookupEmpresa(loc_oTxt)
                    ENDIF

                    THIS.ValidarDuplicidadeLinha(1)
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * Col2TpTransKeyPress - Column2.Text1 (TpTrans) KeyPress. Equivalente ao
    * Valid legado (fwBuscaSel contra SigPrTrn - ver nota de cabecalho da
    * Fase 6): F4 sempre abre o lookup; Enter/Tab valida existencia em
    * SigPrTrn e, se nao achar, abre o mesmo lookup. Ao final roda a
    * checagem de duplicidade Emps+TpTrans+Tps.
    *==========================================================================
    PROCEDURE Col2TpTransKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oTxt, loc_cValor, loc_lAchou, loc_oErro

        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oTxt = THIS.grd_4c_Dados.Column2.Text1

            IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
                THIS.AbrirLookupTpTrans(loc_oTxt)
                THIS.ValidarDuplicidadeLinha(2)
            ELSE
                loc_cValor = ALLTRIM(NVL(loc_oTxt.Value, ""))

                IF !EMPTY(loc_cValor)
                    loc_lAchou = .F.

                    TRY
                        IF USED("cursor_4c_LkpChk")
                            USE IN cursor_4c_LkpChk
                        ENDIF

                        IF SQLEXEC(gnConnHandle, ;
                                "SELECT codigos FROM SigPrTrn WHERE codigos = " + EscaparSQL(loc_cValor), ;
                                "cursor_4c_LkpChk") > 0 AND ;
                           USED("cursor_4c_LkpChk") AND RECCOUNT("cursor_4c_LkpChk") > 0
                            loc_lAchou = .T.
                        ENDIF

                        IF USED("cursor_4c_LkpChk")
                            USE IN cursor_4c_LkpChk
                        ENDIF
                    CATCH TO loc_oErro
                        MsgErro(loc_oErro.Message, "FormTPG.Col2TpTransKeyPress")
                    ENDTRY

                    IF !loc_lAchou
                        THIS.AbrirLookupTpTrans(loc_oTxt)
                    ENDIF

                    THIS.ValidarDuplicidadeLinha(2)
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * Col3TpsKeyPress - Column3.Text1 (Tps) KeyPress. Equivalente ao Valid
    * legado: sem lookup, apenas restringe a INLIST('T','R') - "Opcao
    * Invalida. Informe <T>ransporte <R>ecepcao". Se valido, roda a mesma
    * checagem de duplicidade dos outros 2 campos.
    *==========================================================================
    PROCEDURE Col3TpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oTxt, loc_cValor

        IF INLIST(par_nKeyCode, 13, 9)
            loc_oTxt   = THIS.grd_4c_Dados.Column3.Text1
            loc_cValor = UPPER(ALLTRIM(NVL(loc_oTxt.Value, "")))

            IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "T", "R")
                MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. Informe <T>ransporte <R>ecepc" + CHR(227) + "o", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_oTxt.Value = ""
            ELSE
                IF !EMPTY(loc_cValor)
                    THIS.ValidarDuplicidadeLinha(3)
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupEmpresa - Lookup de Empresa (SigCdEmp.cemps/razas) para a
    * coluna Emps do grid, via helper canonico (FormBase.AbrirLookupCanonico)
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupEmpresa(par_oTxt)
        THIS.AbrirLookupCanonico("SigCdEmp", "cemps", "razas", ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            ALLTRIM(NVL(par_oTxt.Value, "")), ;
            par_oTxt, .NULL.)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * AbrirLookupTpTrans - Lookup de Tipo de Transporte (SigPrTrn.codigos/
    * descrs) para a coluna TpTrans do grid, via helper canonico
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupTpTrans(par_oTxt)
        THIS.AbrirLookupCanonico("SigPrTrn", "codigos", "descrs", ;
            "Tipo de Transporte", ;
            ALLTRIM(NVL(par_oTxt.Value, "")), ;
            par_oTxt, .NULL.)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * ValidarDuplicidadeLinha - Replica a checagem repetida nos 3 Valid do
    * legado: apos editar Emps/TpTrans/Tps, verifica se ja existe OUTRA
    * linha com a MESMA combinacao (chave de negocio). Se achar, avisa,
    * limpa o campo que disparou a checagem e devolve o foco a ele - mesmo
    * efeito pratico do MessageBox + Return .f. do Valid legado.
    * par_nColuna: 1=Emps, 2=TpTrans, 3=Tps (indica qual Column limpar/focar)
    *==========================================================================
    PROTECTED PROCEDURE ValidarDuplicidadeLinha(par_nColuna)
        LOCAL loc_cEmp, loc_cTra, loc_cTps, loc_cChave, loc_nRegAtual, loc_oErro, loc_oCol

        IF USED("cursor_4c_Dados")
            DO CASE
            CASE par_nColuna = 1
                loc_oCol = THIS.grd_4c_Dados.Column1
            CASE par_nColuna = 2
                loc_oCol = THIS.grd_4c_Dados.Column2
            CASE par_nColuna = 3
                loc_oCol = THIS.grd_4c_Dados.Column3
            ENDCASE

            TRY
                SELECT cursor_4c_Dados
                loc_nRegAtual = RECNO()
                loc_cEmp      = emps
                loc_cTra      = tptrans
                loc_cTps      = tps
                loc_cChave    = cidchaves

                LOCATE FOR emps = loc_cEmp AND tptrans = loc_cTra AND ;
                           tps = loc_cTps AND cidchaves <> loc_cChave

                IF !EOF()
                    MsgAviso("Tipo de Transfer" + CHR(234) + "ncia Cadastrada", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                    GO loc_nRegAtual IN cursor_4c_Dados
                    THIS.grd_4c_Dados.Refresh()
                    IF VARTYPE(loc_oCol) = "O"
                        loc_oCol.Text1.Value = ""
                        THIS.grd_4c_Dados.SetFocus()
                        loc_oCol.SetFocus()
                    ENDIF
                ELSE
                    GO loc_nRegAtual IN cursor_4c_Dados
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "Erro em FormTPG.ValidarDuplicidadeLinha")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - cmdinserir do legado: reaproveita linha vazia
    * existente ou anexa uma nova (cidchaves = fUniqueIds()), navega para
    * ela (index EmpTp legado ordena vazios primeiro - replicado em
    * TPGBO.CarregarLista) e foca a 1a coluna da grade
    *==========================================================================
    FUNCTION BtnIncluirClick()
        LOCAL loc_oErro, loc_lProsseguir
        loc_lProsseguir = .T.

        TRY
            IF !USED("cursor_4c_Dados")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_Dados
                LOCATE FOR EMPTY(emps) AND EMPTY(tptrans) AND EMPTY(tps)
                IF EOF()
                    APPEND BLANK
                    REPLACE cidchaves WITH fUniqueIds(), ;
                            flagnovo  WITH .T.
                    GO TOP
                ENDIF

                =fGravarLog("I", "SigPrTrnG", "INSERIR", "")

                THIS.grd_4c_Dados.Refresh()
                THIS.grd_4c_Dados.SetFocus()
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormTPG.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - cmdexcluir do legado: exclui o registro corrente.
    * Linha ainda nao persistida (flagnovo) so sai do cursor; linha ja
    * gravada tambem eh removida de SigPrTra na hora (TPGBO.ExcluirPorChave)
    * - o legado bufferiza ate o Encerrar, aqui persiste de imediato porque
    * esta arquitetura (BusinessBase/DataAccess) nao tem commit em lote
    *==========================================================================
    FUNCTION BtnExcluirClick()
        LOCAL loc_oErro, loc_cChave, loc_lNovo, loc_cCidChaves, loc_lProsseguir
        loc_lProsseguir = .T.

        TRY
            IF !USED("cursor_4c_Dados")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_Dados
                IF EOF()
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !MsgConfirmaExclusao()
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cCidChaves = cursor_4c_Dados.cidchaves
                loc_lNovo      = cursor_4c_Dados.flagnovo
                loc_cChave     = ALLTRIM(cursor_4c_Dados.emps) + " - " + ;
                                  ALLTRIM(cursor_4c_Dados.tptrans) + " - " + ;
                                  ALLTRIM(cursor_4c_Dados.tps)

                IF !loc_lNovo
                    IF !THIS.this_oBusinessObject.ExcluirPorChave(loc_cCidChaves)
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lProsseguir
                =fGravarLog("E", "SigPrTrnG", "EXCLUSAO", loc_cChave)

                SELECT cursor_4c_Dados
                DELETE
                PACK
                GO TOP

                THIS.grd_4c_Dados.Refresh()
                THIS.grd_4c_Dados.SetFocus()
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormTPG.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Commandgroup1.Command3 do legado: valida TODAS as
    * linhas (Empty(Emps)/Empty(Tps) - a checagem de TpTrans esta comentada
    * no legado e por isso NAO entra aqui, regra #17), so entao grava linha
    * a linha via BusinessObject e fecha o form
    *==========================================================================
    FUNCTION BtnEncerrarClick()
        LOCAL loc_oErro, loc_lValido, loc_lSucesso
        loc_lValido  = .T.
        loc_lSucesso = .T.

        TRY
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                GO TOP
                SCAN
                    IF EMPTY(cursor_4c_Dados.emps)
                        MsgAviso("Empresa Inv" + CHR(225) + "lida !!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        THIS.grd_4c_Dados.SetFocus()
                        THIS.grd_4c_Dados.Column1.SetFocus()
                        loc_lValido = .F.
                        EXIT
                    ENDIF
                    IF EMPTY(cursor_4c_Dados.tps)
                        MsgAviso("Tipo Inv" + CHR(225) + "lido !!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        THIS.grd_4c_Dados.SetFocus()
                        THIS.grd_4c_Dados.Column3.SetFocus()
                        loc_lValido = .F.
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF

            IF loc_lValido AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                GO TOP
                SCAN
                    IF cursor_4c_Dados.flagnovo
                        THIS.this_oBusinessObject.NovoRegistro()
                    ELSE
                        IF !THIS.this_oBusinessObject.EditarRegistro()
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF
                    ENDIF

                    THIS.this_oBusinessObject.this_cCidChaves = cursor_4c_Dados.cidchaves
                    THIS.this_oBusinessObject.this_cEmps      = cursor_4c_Dados.emps
                    THIS.this_oBusinessObject.this_cTpTrans   = cursor_4c_Dados.tptrans
                    THIS.this_oBusinessObject.this_cTps       = cursor_4c_Dados.tps
                    THIS.this_oBusinessObject.this_cModulos   = ""

                    IF !THIS.this_oBusinessObject.Salvar()
                        loc_lSucesso = .F.
                        EXIT
                    ENDIF

                    *-- Marca a linha como persistida: sem isso, um novo clique
                    *-- em Encerrar apos falha EM OUTRA linha do SCAN tentaria
                    *-- inserir de novo esta linha (ja gravada) com o mesmo
                    *-- cidchaves, colidindo com a PK
                    REPLACE cursor_4c_Dados.flagnovo WITH .F.
                ENDSCAN
            ELSE
                loc_lSucesso = .F.
            ENDIF

            IF loc_lValido AND loc_lSucesso
                =fGravarLog("G", "SigPrTrnG", "GRAVACAO", "")
                THIS.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormTPG.BtnEncerrarClick")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\TPGBO.prg):
*==============================================================================
* TPGBO.prg - Business Object para Tipos de Transporte Automatico
*==============================================================================
* Tabela   : SigPrTra
* PK real  : cidchaves (CHAR 20, gerado por fUniqueIds)
* Chave neg: emps + tptrans + tps
* Herda de : BusinessBase (app\classes\businessbase.prg)
*
* Fase 1/8 - Propriedades e Init
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS TPGBO AS BusinessBase

    *==========================================================================
    *-- PROPRIEDADES DA TABELA SigPrTra (schema exato)
    *==========================================================================

    *-- Chave primaria real (gerada por fUniqueIds)
    this_cCidChaves = ""    && cidchaves CHAR(20) - PK

    *-- Chave de negocio composta: Emps + TpTrans + Tps
    this_cEmps      = ""    && emps      CHAR(3)  - Codigo da Empresa
    this_cTpTrans   = ""    && tptrans   CHAR(6)  - Codigo do Tipo de Transporte (FK SigPrTrn.codigos)
    this_cTps       = ""    && tps       CHAR(1)  - Tipo (T=Transporte / R=Recepcao)

    *-- Coluna NOT NULL sem campo na tela original (regra #22 CLAUDE.md)
    this_cModulos   = ""    && modulos   CHAR(1)  - Modulo (nao exibido no legado)

    *==========================================================================
    *-- INICIALIZACAO
    *==========================================================================

    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTra"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "TPGBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- AUDITORIA: retorna PK real para RegistrarAuditoria()
    *==========================================================================

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *==========================================================================
    *-- CarregarDoCursor - Carrega propriedades a partir de uma linha do
    *-- cursor de dados (crSigPrTrn no legado / cursor_4c_Dados no migrado)
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cIdChaves, "C")
                THIS.this_cEmps      = TratarNulo(Emps,      "C")
                THIS.this_cTpTrans   = TratarNulo(TpTrans,   "C")
                THIS.this_cTps       = TratarNulo(Tps,       "C")
                THIS.this_cModulos   = TratarNulo(Modulos,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TPGBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- Inserir - Grava novo registro na tabela SigPrTra
    *-- Cobre TODAS as colunas NOT NULL (emps, tptrans, tps, cidchaves, modulos)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidChaves)
            THIS.this_cCidChaves = fUniqueIds()
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTra (emps, tptrans, tps, cidchaves, modulos)
                VALUES (
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cTpTrans)>>,
                    <<EscaparSQL(THIS.this_cTps)>>,
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(THIS.this_cModulos)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir tipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TPGBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- Atualizar - Atualiza registro existente na tabela SigPrTra
    *-- Chave de localizacao: cidchaves (PK real, imutavel)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTra
                SET emps    = <<EscaparSQL(THIS.this_cEmps)>>,
                    tptrans = <<EscaparSQL(THIS.this_cTpTrans)>>,
                    tps     = <<EscaparSQL(THIS.this_cTps)>>,
                    modulos = <<EscaparSQL(THIS.this_cModulos)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar tipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TPGBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- CarregarLista - Popula cursor_4c_Dados (READWRITE) com todos os
    *-- registros de SigPrTra, na ordem Emps+TpTrans+Tps (Index EmpTp legado)
    *-- Cursor precisa ser READWRITE porque a grade do form eh EDITAVEL
    *-- diretamente sobre as celulas (regra: grid editavel + cursor de
    *-- SQLEXEC = somente leitura)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cidchaves, emps, tptrans, tps
                FROM SigPrTra
                ORDER BY emps, tptrans, tps
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT cidchaves, emps, tptrans, tps, .F. AS flagnovo ;
                    FROM cursor_4c_DadosTmp ;
                    INTO CURSOR cursor_4c_Dados READWRITE

                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF

                SELECT cursor_4c_Dados
                INDEX ON emps + tptrans + tps TAG EmpTp
                SET ORDER TO TAG EmpTp
                GO TOP

                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar tipos de transporte:" + CHR(13) + ;
                            CapturarErroSQL(), "TPGBO.CarregarLista")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
                        "TPGBO.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- ExcluirPorChave - Exclui diretamente um registro ja persistido de
    *-- SigPrTra pela PK real (cidchaves). Usado pela grade editavel do form,
    *-- que grava/exclui linha a linha (NUNCA chamar ExecutarExclusao() daqui
    *-- - este metodo eh o caminho publico equivalente para exclusao por
    *-- linha de grade, fora do fluxo de registro unico de BusinessBase)
    *==========================================================================
    FUNCTION ExcluirPorChave(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(NVL(par_cCidChaves, "")))
            RETURN .F.
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigPrTra
                WHERE cidchaves = <<EscaparSQL(par_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cCidChaves = par_cCidChaves
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir tipo de transporte:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, ;
                        "TPGBO.ExcluirPorChave")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

