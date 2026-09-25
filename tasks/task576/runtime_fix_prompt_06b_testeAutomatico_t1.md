# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'CarregarDadosReais': Sem conexao ao banco (gnConnHandle invalido); Teste 'BtnEncerrarExiste': Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[25/09/2026 10:36:53] Erro em sigmvpenBO.BuscarPendentes: RETURN/RETRY statement not allowed in TRY/CATCH.
[25/09/2026 10:36:53] Erro: RETURN/RETRY statement not allowed in TRY/CATCH.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-09-25 10:34:36] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-25 10:34:36] [INFO] Config FPW: (nao fornecido)
[2026-09-25 10:34:36] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-25 10:34:36] [INFO] Timeout: 300 segundos
[2026-09-25 10:34:36] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zft23raf.prg
[2026-09-25 10:34:36] [INFO] Conteudo do wrapper:
[2026-09-25 10:34:36] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigmvpen', 'C:\4c\tasks\task576', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigmvpen', 'C:\4c\tasks\task576', 'OPERACIONAL'
QUIT

[2026-09-25 10:34:36] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zft23raf.prg
[2026-09-25 10:34:36] [INFO] VFP output esperado em: C:\4c\tasks\task576\vfp_output.txt
[2026-09-25 10:34:36] [INFO] Executando Visual FoxPro 9...
[2026-09-25 10:34:36] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zft23raf.prg
[2026-09-25 10:34:36] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zft23raf.prg
[2026-09-25 10:34:37] [INFO] Timeout configurado: 300 segundos
[2026-09-25 10:36:53] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-25 10:36:53] [INFO] VFP9 finalizado em 136.5979679 segundos
[2026-09-25 10:36:53] [INFO] Exit Code: 
[2026-09-25 10:36:53] [INFO] 
[2026-09-25 10:36:53] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-25 10:36:53] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zft23raf.prg
[2026-09-25 10:36:53] [INFO] 
[2026-09-25 10:36:53] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-25 10:36:53] [INFO] * Auto-generated wrapper for parameters
[2026-09-25 10:36:53] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-25 10:36:53] [INFO] * Parameters: 'Formsigmvpen', 'C:\4c\tasks\task576', 'OPERACIONAL'
[2026-09-25 10:36:53] [INFO] 
[2026-09-25 10:36:53] [INFO] * Anti-dialog protections for unattended execution
[2026-09-25 10:36:53] [INFO] SET SAFETY OFF
[2026-09-25 10:36:53] [INFO] SET RESOURCE OFF
[2026-09-25 10:36:53] [INFO] SET TALK OFF
[2026-09-25 10:36:53] [INFO] SET NOTIFY OFF
[2026-09-25 10:36:53] [INFO] SYS(2335, 0)
[2026-09-25 10:36:53] [INFO] 
[2026-09-25 10:36:53] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigmvpen', 'C:\4c\tasks\task576', 'OPERACIONAL'
[2026-09-25 10:36:53] [INFO] QUIT
[2026-09-25 10:36:53] [INFO] 
[2026-09-25 10:36:53] [INFO] === Fim do Wrapper.prg ===
[2026-09-25 10:36:53] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigmvpen",
  "timestamp": "20260925103653",
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
      "detalhes": "Metodo BtnIncluirClick nao encontrado (OK para REPORT/OPERACIONAL)"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": false,
      "erro": "Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)",
      "detalhes": ""
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 1 (KEYPRESS)"
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
    "passou": 7,
    "falhou": 2,
    "percentual": 78
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigmvpen.prg):
*====================================================================
* Formsigmvpen.prg
*
* Form OPERACIONAL "SIGMVPEN" - dialogo de CONSULTA que lista, agrupado
* por movimentacao (Empresa/Operacao/Numero), o saldo em aberto de um
* filtro (Fk_chave) repassado pelo processo chamador. Duas grades
* (itens + rodape com o total) e um TextBox somente-leitura com a razao
* social do cliente/fornecedor da linha selecionada. Unico botao:
* "Encerrar" (equivalente ao legado "ok"), que apenas fecha a tela -
* nao ha INSERT/UPDATE/DELETE em lugar nenhum do original.
*
* PILAR 1 (UX): dialogo fixo, identico ao legado - sem barra de
* titulo/controle de janela (ControlBox = .F.), nao movivel
* (Movable = .F.), 750x513, AutoCenter = .T..
*
* PILAR 3 (arquitetura): o legado e um form FLAT do VFP - SEM PageFrame,
* SEM Container algum (arvore do SCX: dataenvironment + form + Shape1 +
* ok + grdItens [8 colunas] + grdRodape [3 colunas] + getRClis, todos
* filhos DIRETOS do form). Este form migrado segue a mesma estrutura
* flat (excecao documentada em CLAUDE.md para o Gate da Fase 3 quando o
* legado nao tem PageFrame/Container - nao inventar Page1/Page2 nem
* containers vazios que o original nao possui). Ver tambem
* FormSigMvPdt.prg (mesmo padrao de dialogo flat).
*
* Controles criados em ConfigurarControles(), replicando fielmente a
* arvore do SCX legado (Top/Left/Width/Height/FontName/cores/Caption
* transcritos da SECAO 2 do dump), todos filhos DIRETOS do form:
*   - shp_4c_Shape1  (Shape1 legado - moldura decorativa ao redor do
*     botao Encerrar)
*   - grd_4c_Grade   (grdItens legado - grade de itens em aberto, 8
*     colunas, ligada a cursor_4c_Grade do Business Object)
*   - grd_4c_Rodape  (grdRodape legado - grade de 1 linha com o total
*     geral, ligada a cursor_4c_Rodape do Business Object)
*   - txt_4c_RClis   (getRClis legado - TextBox somente-leitura com a
*     razao social da linha selecionada; permanece Enabled = .F. desde
*     a criacao, como o legado - PROCEDURE When retorna .F., ou seja,
*     o campo NUNCA entra em edicao)
*   - cmd_4c_Encerrar (ok legado - unico botao, fecha o dialogo)
* As propriedades de coluna que o legado so define em RUNTIME
* (PROCEDURE montagrades, chamado pelo Init) - FontName "Courier New"
* sobrescrevendo o "Arial" de design-time - sao transcritas como o
* valor final que realmente aparece na tela.
*
* Ordem de configuracao dentro do Grid (CLAUDE.md - "Column.Width vai
* por ULTIMO"): ColumnCount -> RecordSource -> Column.ControlSource
* SOMENTE DEPOIS de cursor_4c_Grade/cursor_4c_Rodape existirem (o BO
* cria os cursores ANTES de ConfigurarControles() rodar - apontar
* ControlSource para cursor inexistente derruba o Init, regra
* CLAUDE.md #41) -> so DEPOIS Column.Width e Header1.Caption
* (RecordSource/ControlSource resetam Width/Caption para o default se
* setados antes).
*
* Sem PageFrame/Page2/Dados, sem lookups e sem botoes CRUD (Incluir/
* Alterar/Excluir/Buscar): medido no dump do legado, nao presumido - a
* arvore do SCX (8 objetos, zero PageFrame/Page/Container) e
* analise.json ("campos": [] e "lookups": [] vazios) provam que o
* UNICO controle de entrada eh getRClis -> txt_4c_RClis (somente-
* leitura, PROCEDURE When retorna .F.) e o UNICO CommandButton eh
* "ok"/Encerrar. Nenhuma chamada a fwbuscaext/fwBuscaSel/fwBuscaInt/
* sigacess()/Acesso<X>() no arquivo inteiro. Inventar Page2, lookups ou
* os outros botoes CRUD fabricaria funcionalidade que o legado nao
* possui (viola o PILAR 1 e a regra "NUNCA inventar" de
* migration_guide.md). Mesmo padrao de FormSigMvPdt.prg/
* FormSigMvChv.prg (nenhum dos dois tem Page2/lookup/CRUD).
*
* Fluxo real (comportamento.json, 11 metodos do legado - todos
* cobertos): Init recebe Fk_chave -> InicializarForm cria o Business
* Object, cria os cursores de trabalho, monta os controles e dispara a
* carga automatica (equivalente a ".SelecionaDados/.grdItens.Refresh/
* .grdRodape.Refresh/.grdItens.Column1.Setfocus" do Init legado, dentro
* de LockScreen=.T./.F.) - nao ha botao de busca/filtro, a carga eh
* sempre automatica. Trocar de linha na grade principal (equivalente ao
* AfterRowColChange legado, via BINDEVENT - LPARAMETERS par_nColIndex,
* CLAUDE.md regra #3) atualiza Empresa Destino/Usuario no rodape e a
* Razao Social em txt_4c_RClis. As celulas do rodape sao somente
* vitrine (GotFocus devolve o foco a grade principal / guarda-e-
* restaura via .Tag). Sem AlternarPagina/HabilitarCampos/FormParaBO/
* BOParaForm/CarregarLista/AjustarBotoesPorModo: nao ha Page, campo
* editavel, gravacao nem modo INCLUIR/ALTERAR/VISUALIZAR para
* justificar esses metodos (form FLAT de CONSULTA com um unico estado
* de exibicao - ver NOTA final de sigmvpenBO.prg: Inserir/Atualizar/
* ExecutarExclusao nao sao sobrescritos porque o legado nunca grava).
*
* Parametro de Init (equivalente ao legado LParameters pKey):
*   par_cLpKey - Fk_chave: chave usada para filtrar o saldo em aberto
*                em SigMvEstPd. Repassada para this_oBusinessObject no
*                CREATEOBJECT (sigmvpenBO.Init recebe par_cLpKey).
*
* Sem item de menu: SIGMVPEN e um dialogo de CONSULTA invocado com
* parametro (Fk_chave) pelo processo de movimentacao que precisa
* mostrar o saldo em aberto - nunca foi um destino de menu no legado
* (nao ha "DO FORM sigmvpen" solto em nenhum ponto do acervo, so a
* instanciacao com o parametro pKey). Mesmo padrao de FormSigMvPdt.prg/
* FormSigMvChv.prg (nenhum dos dois tem entrada em menu.prg). Quando o
* form de movimentacao que abre este dialogo (SigMvCab/SigMvMvt, ainda
* em ProximasMigracoes/) for migrado, ele passara a chamar
* CREATEOBJECT("Formsigmvpen", <Fk_chave>).Show() diretamente.
*====================================================================

DEFINE CLASS Formsigmvpen AS FormBase

    *-- Propriedade de filtro (equivalente a ThisForm.lpKey do legado,
    *-- recebida via Init e repassada ao Business Object)
    this_cMensagemErro = ""
    this_cLpKey = ""

    *-- Configuracoes visuais do dialogo (identicas ao SCX legado -
    *-- SECAO 2, objeto sigmvpen)
    Width          = 750
    Height         = 513
    BorderStyle    = 2
    AutoCenter     = .T.
    ControlBox     = .F.
    MaxButton      = .F.
    MinButton      = .F.
    Movable        = .F.
    WindowState    = 0
    AlwaysOnTop    = .F.
    Themes         = .F.
    Caption        = "Pendentes"
    ShowWindow     = 1
    WindowType     = 1

    *--------------------------------------------------------------------------
    * Init - Recebe o mesmo parametro posicional do legado (pKey) e o
    * grava em this_cLpKey ANTES de DODEFAULT() acionar FormBase.Init()
    * (que chama InicializarForm()).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cLpKey)
        THIS.this_cLpKey = TratarNulo(par_cLpKey, "")

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Hook chamado por FormBase.Init(). Equivalente a
    * ".poDataMgr = CreateObject([fSqlConector], .Name) / If
    * (.poDataMgr.pnIdconn > 0)" do Init legado: instancia o Business
    * Object (que usa o handle de conexao global gnConnHandle, ja aberto
    * pelo startup da aplicacao - nao ha conexao privada por form na
    * nova arquitetura) e configura as propriedades visuais restantes.
    *
    * Este dialogo NAO tem PageFrame nem paginas Lista/Dados: o legado
    * e um form FLAT sem nenhum container (ver comentario de cabecalho
    * acima). As grades, o botao Encerrar e o TextBox de razao social
    * sao criados em ConfigurarControles(), chamado logo abaixo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("sigmvpenBO", THIS.this_cLpKey)

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Cursores DEVEM existir antes do Grid.Column.ControlSource
                *-- apontar para eles (CLAUDE.md #41) - equivalente ao
                *-- PROCEDURE Load do legado (Create Cursor crGrade/crRodape),
                *-- que roda antes do Init.
                THIS.this_oBusinessObject.CriarCursoresPendentes()

                THIS.ConfigurarControles()

                *-- Equivalente a ".SelecionaDados / .grdItens.Refresh /
                *-- .grdRodape.Refresh / .grdItens.Column1.Setfocus" do
                *-- Init legado (dentro do bloco LockScreen=.T./.F.).
                THIS.CarregarPendentes()

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel criar o objeto de neg" + CHR(243) + "cio sigmvpenBO"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarControles - Cria os controles do dialogo, filhos DIRETOS
    * do form (sem Page/Container - PILAR 3, ver cabecalho do arquivo).
    * Replica a arvore do SCX legado (SECAO 1) e as propriedades da
    * SECAO 2 do dump, incluindo o que o PROCEDURE montagrades legado
    * sobrescreve em runtime (FontName "Courier New" das colunas, que
    * substitui o "Arial" de design-time).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarControles()
        LOCAL loc_cCursorGrade, loc_cCursorRodape
        loc_cCursorGrade  = THIS.this_oBusinessObject.this_cCursorGrade
        loc_cCursorRodape = THIS.this_oBusinessObject.this_cCursorRodape

        *-- Shape1 - moldura decorativa ao redor do botao Encerrar
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 654
            .Height      = 110
            .Width       = 90
            .BackStyle   = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- grdItens -> grd_4c_Grade (8 colunas, itens em aberto)
        THIS.AddObject("grd_4c_Grade", "Grid")
        THIS.grd_4c_Grade.ColumnCount  = 8
        THIS.grd_4c_Grade.RecordSource = loc_cCursorGrade
        WITH THIS.grd_4c_Grade
            .Top               = 131
            .Left              = 13
            .Height            = 326
            .Width             = 724
            .FontName          = "Courier New"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 17
            .ReadOnly          = .T.
            .ScrollBars        = 2

            .Column1.ControlSource = loc_cCursorGrade + ".Emps"
            .Column2.ControlSource = loc_cCursorGrade + ".Dopes"
            .Column3.ControlSource = loc_cCursorGrade + ".Numes"
            .Column3.InputMask     = "999999"
            .Column4.ControlSource = loc_cCursorGrade + ".Datas"
            .Column5.ControlSource = loc_cCursorGrade + ".GrupoDs"
            .Column6.ControlSource = loc_cCursorGrade + ".ContaDs"
            .Column7.ControlSource = loc_cCursorGrade + ".PrazoEnts"
            .Column8.ControlSource = loc_cCursorGrade + ".Pendentes"
            .Column8.InputMask     = "9999999.99"

            *-- Width/Header/cores DEPOIS do RecordSource+ControlSource
            *-- (senao o VFP9 reseta as larguras para o default 90)
            .Column1.Width  = 31
            .Column2.Width  = 206
            .Column3.Width  = 60
            .Column4.Width  = 80
            .Column5.Width  = 80
            .Column6.Width  = 80
            .Column7.Width  = 80
            .Column8.Width  = 80
            .Column8.FontBold  = .T.
            .Column8.BackColor = RGB(255, 255, 223)

            *-- Header1 mantem FontName/FontSize de DESIGN-TIME (Arial 8) -
            *-- o loop runtime do legado so troca Column.FontName/Text1.FontName
            *-- (celulas de dado), nunca Header1.FontName.
            .Column1.Header1.Caption   = "Emp"
            .Column1.Header1.FontName  = "Arial"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.FontName  = "Arial"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column3.Header1.Caption   = "C" + CHR(243) + "digo"
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.Alignment = 2
            .Column4.Header1.Caption   = "Data"
            .Column4.Header1.FontSize  = 8
            .Column4.Header1.Alignment = 2
            .Column5.Header1.Caption   = "Grupo"
            .Column5.Header1.FontSize  = 8
            .Column5.Header1.Alignment = 2
            .Column6.Header1.Caption   = "Conta"
            .Column6.Header1.FontSize  = 8
            .Column6.Header1.Alignment = 2
            .Column7.Header1.Caption   = "Data / Entrega"
            .Column7.Header1.FontSize  = 8
            .Column7.Header1.Alignment = 2
            .Column8.Header1.Caption   = "Qtde"
            .Column8.Header1.FontSize  = 8
            .Column8.Header1.Alignment = 2

            .Column1.Movable = .F.
            .Column2.Movable = .F.
            .Column3.Movable = .F.
            .Column4.Movable = .F.
            .Column5.Movable = .F.
            .Column6.Movable = .F.
            .Column7.Movable = .F.
            .Column8.Movable = .F.

            .Column1.Resizable = .F.
            .Column2.Resizable = .F.
            .Column3.Resizable = .F.
            .Column4.Resizable = .F.
            .Column5.Resizable = .F.
            .Column6.Resizable = .F.
            .Column7.Resizable = .F.
            .Column8.Resizable = .F.

            .Column1.ReadOnly = .T.
            .Column2.ReadOnly = .T.
            .Column3.ReadOnly = .T.
            .Column4.ReadOnly = .T.
            .Column5.ReadOnly = .T.
            .Column6.ReadOnly = .T.
            .Column7.ReadOnly = .T.
            .Column8.ReadOnly = .T.

            .Column1.Text1.FontName    = "Courier New"
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ForeColor   = RGB(0, 0, 0)
            .Column1.Text1.BackColor   = RGB(255, 255, 255)

            .Column2.Text1.FontName    = "Courier New"
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 255)

            .Column3.Text1.FontName    = "Courier New"
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin      = 0
            .Column3.Text1.ForeColor   = RGB(0, 0, 0)
            .Column3.Text1.BackColor   = RGB(255, 255, 255)

            .Column4.Text1.FontName    = "Courier New"
            .Column4.Text1.BorderStyle = 0
            .Column4.Text1.Margin      = 0
            .Column4.Text1.ForeColor   = RGB(0, 0, 0)
            .Column4.Text1.BackColor   = RGB(255, 255, 255)

            .Column5.Text1.FontName    = "Courier New"
            .Column5.Text1.FontBold    = .F.
            .Column5.Text1.Alignment   = 3
            .Column5.Text1.BorderStyle = 0
            .Column5.Text1.Margin      = 0
            .Column5.Text1.ForeColor   = RGB(0, 0, 0)
            .Column5.Text1.BackColor   = RGB(255, 255, 255)

            .Column6.Text1.FontName    = "Courier New"
            .Column6.Text1.BorderStyle = 0
            .Column6.Text1.Margin      = 0
            .Column6.Text1.ForeColor   = RGB(0, 0, 0)
            .Column6.Text1.BackColor   = RGB(255, 255, 255)

            .Column7.Text1.FontName    = "Courier New"
            .Column7.Text1.FontBold    = .F.
            .Column7.Text1.BorderStyle = 0
            .Column7.Text1.Margin      = 0
            .Column7.Text1.ForeColor   = RGB(0, 0, 0)
            .Column7.Text1.BackColor   = RGB(255, 255, 255)

            .Column8.Text1.FontName    = "Courier New"
            .Column8.Text1.FontBold    = .T.
            .Column8.Text1.BorderStyle = 0
            .Column8.Text1.Margin      = 0
            .Column8.Text1.ForeColor   = RGB(0, 0, 0)
            .Column8.Text1.BackColor   = RGB(255, 255, 223)

            .Visible = .T.
        ENDWITH

        *-- grdRodape -> grd_4c_Rodape (3 colunas, total geral)
        THIS.AddObject("grd_4c_Rodape", "Grid")
        THIS.grd_4c_Rodape.ColumnCount  = 3
        THIS.grd_4c_Rodape.RecordSource = loc_cCursorRodape
        WITH THIS.grd_4c_Rodape
            .Top               = 453
            .Left              = 13
            .Height            = 23
            .Width             = 724
            .FontName          = "Courier New"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 4
            .ReadOnly          = .T.
            .ScrollBars        = 2

            .Column1.ControlSource = loc_cCursorRodape + ".Descrs"
            .Column2.ControlSource = loc_cCursorRodape + ".Usuars"
            .Column3.ControlSource = loc_cCursorRodape + ".Pendentes"
            .Column3.InputMask     = "9999999.99"

            .Column1.Width = 542
            .Column2.Width = 80
            .Column3.Width = 80

            .Column1.Header1.Caption   = ""
            .Column1.Header1.FontName  = "Courier New"
            .Column1.Header1.BackColor = RGB(255, 255, 0)
            .Column2.Header1.Caption   = ""
            .Column2.Header1.FontName  = "Courier New"
            .Column2.Header1.BackColor = RGB(255, 255, 0)
            .Column3.Header1.Caption   = ""
            .Column3.Header1.FontName  = "Courier New"
            .Column3.Header1.BackColor = RGB(255, 255, 0)

            .Column1.Movable   = .F.
            .Column2.Movable   = .F.
            .Column3.Movable   = .F.
            .Column1.Resizable = .F.
            .Column2.Resizable = .F.
            .Column3.Resizable = .F.
            .Column1.ReadOnly  = .T.
            .Column2.ReadOnly  = .T.
            .Column3.ReadOnly  = .T.
            .Column1.BackColor = RGB(255, 255, 223)
            .Column2.BackColor = RGB(255, 255, 223)
            .Column2.FontBold  = .T.
            .Column3.BackColor = RGB(255, 255, 223)
            .Column3.FontBold  = .T.

            .Column1.Text1.FontName    = "Courier New"
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ForeColor   = RGB(0, 0, 0)
            .Column1.Text1.BackColor   = RGB(255, 255, 223)

            .Column2.Text1.FontName    = "Courier New"
            .Column2.Text1.FontBold    = .T.
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 223)

            .Column3.Text1.FontName    = "Courier New"
            .Column3.Text1.FontBold    = .T.
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin      = 0
            .Column3.Text1.ForeColor   = RGB(0, 0, 0)
            .Column3.Text1.BackColor   = RGB(255, 255, 223)

            .Visible = .T.
        ENDWITH

        *-- getRClis -> txt_4c_RClis (TextBox somente-leitura, razao
        *-- social da linha selecionada). Enabled = .F. desde a criacao:
        *-- o legado tem PROCEDURE When retornando .F., ou seja, o campo
        *-- NUNCA entra em edicao - so recebe .Value por codigo.
        THIS.AddObject("txt_4c_RClis", "TextBox")
        WITH THIS.txt_4c_RClis
            .Top                = 476
            .Left               = 13
            .Height             = 20
            .Width              = 724
            .FontName           = "Courier New"
            .FontSize           = 9
            .SpecialEffect      = 1
            .Enabled            = .F.
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 223)
            .DisabledForeColor  = RGB(0, 0, 0)
            .DisabledBackColor  = RGB(255, 255, 223)
            .BorderColor        = RGB(192, 192, 192)
            .Value              = ""
            .Visible            = .T.
        ENDWITH

        *-- ok -> cmd_4c_Encerrar (unico botao do dialogo - fecha a tela)
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top       = 12
            .Left = 5
            .Height    = 75
            .Width     = 75
            .FontName  = "Verdana"
            .FontSize  = 8
            .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel    = .T.
            .Caption   = "Encerrar"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible   = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")

        *-- Equivalente ao PROCEDURE AfterRowColChange de grdItens (troca de
        *-- linha na grade principal atualiza o rodape e a razao social).
        BINDEVENT(THIS.grd_4c_Grade, "AfterRowColChange", THIS, "GrdGradeAfterRowColChange")

        *-- Equivalente a grdRodape.Column1.Text1.GotFocus (devolve o foco
        *-- para a grade principal - a celula do rodape eh so vitrine).
        BINDEVENT(THIS.grd_4c_Rodape.Column1.Text1, "GotFocus", THIS, "GrdRodapeCol1TextGotFocus")

        *-- Equivalente ao par GotFocus/LostFocus de grdRodape.Column2.Text1
        *-- (guarda o valor em .Tag ao entrar e o restaura ao sair, para a
        *-- celula nunca aceitar edicao mesmo sendo alcancada via Tab).
        BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "GotFocus", THIS, "GrdRodapeCol2TextGotFocus")
        BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "KeyPress", THIS, "GrdRodapeCol2TextLostFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdEncerrarClick - Equivalente ao PROCEDURE Click do "ok" legado
    * (ThisForm.Release). PUBLIC porque e bindado via BINDEVENT (CLAUDE.md
    * regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CmdEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdGradeAfterRowColChange - Equivalente ao PROCEDURE AfterRowColChange
    * de grdItens do legado: a cada troca de linha/coluna na grade principal,
    * espelha Empresa Destino + Usuario no rodape e a Razao Social no
    * txt_4c_RClis. PUBLIC + LPARAMETERS porque e bindado via BINDEVENT
    * (CLAUDE.md regra #3 - o evento nativo AfterRowColChange manda
    * nColIndex).
    *--------------------------------------------------------------------------
    PROCEDURE GrdGradeAfterRowColChange(par_nColIndex)
        THIS.AtualizarLinhaSelecionada()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdRodapeCol1TextGotFocus - Equivalente ao GotFocus de
    * grdRodape.Column1.Text1 do legado (ThisForm.grdItens.Column1.SetFocus):
    * a celula do rodape eh somente vitrine, entao ao ganhar foco (Tab a
    * partir da grade principal) devolve o foco para a grade de itens.
    * PUBLIC porque e bindado via BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE GrdRodapeCol1TextGotFocus()
        THIS.grd_4c_Grade.Column1.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdRodapeCol2TextGotFocus / GrdRodapeCol2TextLostFocus - Equivalente ao
    * par GotFocus (This.Tag = This.Value) / LostFocus (This.Value = This.Tag)
    * de grdRodape.Column2.Text1 do legado: guarda o valor corrente em .Tag ao
    * entrar e o restaura ao sair, para a celula nunca aceitar edicao. PUBLIC
    * porque sao bindados via BINDEVENT.
    *--------------------------------------------------------------------------
    PROCEDURE GrdRodapeCol2TextGotFocus()
        THIS.grd_4c_Rodape.Column2.Text1.Tag = THIS.grd_4c_Rodape.Column2.Text1.Value
    ENDPROC

    PROCEDURE GrdRodapeCol2TextLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        THIS.grd_4c_Rodape.Column2.Text1.Value = THIS.grd_4c_Rodape.Column2.Text1.Tag
    ENDPROC

    *--------------------------------------------------------------------------
    * Carga inicial das grades - equivalente ao trecho do Init legado que
    * fica entre LockScreen = .T. e LockScreen = .F.: ".MontaGrades" ja
    * aconteceu em ConfigurarControles() (chamada antes deste metodo, ainda
    * em InicializarForm), entao aqui resta ".SelecionaDados" (busca do BO),
    * o Refresh das duas grades e o SetFocus na primeira coluna da grade de
    * itens. O cursor de itens em aberto (equivalente a crSigMvEstPd do
    * legado) e responsabilidade do processo CHAMADOR deste dialogo - ver o
    * metodo de busca em sigmvpenBO.prg.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarPendentes()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.LockScreen = .T.

        IF THIS.this_oBusinessObject.BuscarPendentes("crSigMvEstPd")
            THIS.grd_4c_Grade.Refresh()
            THIS.grd_4c_Rodape.Refresh()

            THIS.AtualizarLinhaSelecionada()

            THIS.grd_4c_Grade.Column1.SetFocus()

            loc_lSucesso = .T.
        ELSE
            IF !EMPTY(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMensagemErro, "")))
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
            ENDIF
        ENDIF

        THIS.LockScreen = .F.

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarLinhaSelecionada - Le a linha corrente de cursor_4c_Grade via
    * sigmvpenBO.CarregarDoCursor (PILAR 3: leitura de dados no BO, nao no
    * Form) e espelha Empresa Destino + Usuario (rodape) e Razao Social
    * (txt_4c_RClis) - equivalente ao corpo do AfterRowColChange legado.
    * Chamado tanto na carga inicial quanto a cada troca de linha
    * (GrdGradeAfterRowColChange).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarLinhaSelecionada()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        IF loc_oBO.CarregarDoCursor(loc_oBO.this_cCursorGrade)
            THIS.grd_4c_Rodape.Column1.Text1.Value = "Empresa Destino : " + loc_oBO.this_cEmpDs
            THIS.grd_4c_Rodape.Column2.Text1.Value = loc_oBO.this_cUsuars
            THIS.txt_4c_RClis.Value = loc_oBO.this_cRClis

            THIS.grd_4c_Rodape.Column1.Refresh()
            THIS.grd_4c_Rodape.Column2.Refresh()
            THIS.txt_4c_RClis.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Fecha os cursores de trabalho do Business Object (cursor_4c_Grade/
    * cursor_4c_Rodape, equivalentes a crGrade/crRodape do legado, criados
    * pelo metodo de criacao de cursores do BO) antes de liberar
    * this_oBusinessObject via heranca. Equivalente ao
    * "ThisForm.poDataMgr.Release" do PROCEDURE Release legado - aqui
    * nao ha conexao privada por form para liberar (gnConnHandle e
    * global), entao o que resta a fechar sao os cursores locais.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Grade")
            USE IN cursor_4c_Grade
        ENDIF
        IF USED("cursor_4c_Rodape")
            USE IN cursor_4c_Rodape
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigmvpenBO.prg):
*====================================================================
* sigmvpenBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGMVPEN" (saldo em aberto de
* movimentacao): consulta itens em aberto de recebimento/transferencia,
* agrupados por Empresa/Operacao/Numero.
*
* Nao existe tabela unica: o detalhe (cursor_4c_Grade) vem de um JOIN
* entre SigMvEstPd (saldo em aberto), SigMvCab (dados da movimentacao) e
* SigCdCli (razao social do cliente/fornecedor). SigMvEstPd e a tabela
* de origem do filtro, por isso THIS.this_cTabela aponta para ela.
*
* Chave de filtro: Fk_chave (equivalente a ThisForm.lpKey / LParameters
* pKey do Init do form legado sigmvpen)
*
* Herda de: BusinessBase
*
* Metodos principais: os metodos de criacao/carga dos cursores de
* trabalho (equivalentes a Load/selecionadados do legado) e
* CarregarDoCursor (linha selecionada da grade, equivalente ao
* AfterRowColChange do legado).
*====================================================================

DEFINE CLASS sigmvpenBO AS BusinessBase

    *-- Propriedade de filtro (equivalente a ThisForm.lpKey do form legado)
    this_cLpKey        = ""    && Fk_chave - chave usada para filtrar SigMvEstPd

    *-- Nomes dos cursores de trabalho (grade principal e rodape/legenda)
    this_cCursorGrade  = "cursor_4c_Grade"    && detalhe: Emps/Dopes/Numes/GrupoDs/ContaDs/Usuars/Datas/PrazoEnts/Pendentes/EmpDs/RClis
    this_cCursorRodape = "cursor_4c_Rodape"   && totais/legenda da linha selecionada: Descrs/Usuars/Pendentes

    *-- Propriedades da LINHA SELECIONADA na grade (equivalente ao que o
    *-- AfterRowColChange do legado le direto de crGrade.<campo>). Preenchidas
    *-- por CarregarDoCursor(THIS.this_cCursorGrade) a cada troca de linha.
    this_cEmps         = ""    && crGrade.Emps
    this_cDopes        = ""    && crGrade.Dopes
    this_nNumes        = 0     && crGrade.Numes
    this_cGrupoDs      = ""    && crGrade.GrupoDs
    this_cContaDs      = ""    && crGrade.ContaDs
    this_cRClis        = ""    && crGrade.RClis
    this_cUsuars       = ""    && crGrade.Usuars
    this_dDatas        = {}    && crGrade.Datas
    this_dPrazoEnts    = {}    && crGrade.PrazoEnts
    this_cEmpDs        = ""    && crGrade.EmpDs
    this_nPendentes    = 0     && crGrade.Pendentes

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * par_cLpKey: chave (Fk_chave) usada para filtrar o saldo em aberto.
    * Equivale ao LParameters pKey do Init do form legado sigmvpen, que o
    * form repassava para ThisForm.lpKey antes de montar as grades.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cLpKey)
        DODEFAULT("SigMvEstPd")

        THIS.this_cCampoChave = "Fk_chave"

        IF VARTYPE(par_cLpKey) = "C"
            THIS.this_cLpKey = par_cLpKey
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Cria (ou recria) os cursores de trabalho com a MESMA estrutura e ORDEM
    * DE CAMPOS em todos os pontos que os usam (Form e BO) - equivalente ao
    * "Create Cursor crGrade"/"Create Cursor crRodape" do PROCEDURE Load do
    * form legado. Chamado pelo Form (InicializarForm) e internamente pelo
    * metodo de carga abaixo, para garantir a estrutura antes de popular.
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursoresPendentes()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                USE IN (THIS.this_cCursorGrade)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorGrade) (Emps C(3), Dopes C(20), Numes N(6), ;
                GrupoDs C(10), ContaDs C(10), Usuars C(10), Datas D, PrazoEnts D, ;
                Pendentes N(10,3), EmpDs C(3), RClis C(50))

            SELECT (THIS.this_cCursorGrade)
            INDEX ON DTOS(PrazoEnts) + DTOS(Datas) + Emps + Dopes + STR(Numes, 6) TAG Ordem

            IF USED(THIS.this_cCursorRodape)
                USE IN (THIS.this_cCursorRodape)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorRodape) (Descrs C(100), Usuars C(10), Pendentes N(10,3))

            loc_lSucesso = .T.
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MsgErro(loException.Message, "Erro em sigmvpenBO.CriarCursoresPendentes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Busca os dados da grade - equivalente ao PROCEDURE selecionadados do
    * legado.
    *
    * par_cCursorEstPd: alias do cursor LOCAL, ja aberto na sessao, com os
    * itens em aberto (Fk_chave/EmpDopNums/Qtds) - equivalente a crSigMvEstPd
    * do form legado. Esse cursor NAO vem de uma tabela chamada "SigMvEstPd"
    * (ela nao existe no schema - a tabela real e SigMvEst, com colunas
    * totalmente diferentes de Fk_chave/EmpDopNums/Qtds); no sistema legado ele
    * e montado pelo processo CHAMADOR (a tela de movimentacao que abre este
    * dialogo) e permanece visivel aqui porque sigmvpen usa DataSession=1
    * (sessao compartilhada, nao privada). Por isso o parametro: quem chama
    * este BO e responsavel por ja ter esse cursor populado.
    *
    * Para cada grupo (EmpDopNums, Sum(Qtds)) dentro do Fk_chave filtrado,
    * busca no SQL Server o cabecalho da movimentacao (SigMvCab) e a razao
    * social do cliente/fornecedor (SigCdCli), e grava uma linha no cursor de
    * grade (this_cCursorGrade). Ao final, grava o total geral no cursor de
    * rodape (this_cCursorRodape).
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPendentes(par_cCursorEstPd)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nTotalPendentes, ;
              loc_dDatas, loc_dPrazoEnts
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cCursorEstPd) != "C" OR !USED(par_cCursorEstPd)
                THIS.this_cMensagemErro = "Cursor de itens pendentes n" + CHR(227) + "o localizado."
                RETURN .F.
            ENDIF

            THIS.CriarCursoresPendentes()

            SELECT (THIS.this_cCursorGrade)
            ZAP
            SELECT (THIS.this_cCursorRodape)
            ZAP

            *-- Equivalente a:
            *-- Select Distinct EmpDopNums, Sum(Qtds) as Qtds From crSigMvEstPd
            *--  Where Fk_chave = ThisForm.lpKey
            *--  Order By EmpDopNums Group By EmpDopNums Into Cursor LocalEstPd
            IF USED("cursor_4c_LocalEstPd")
                USE IN cursor_4c_LocalEstPd
            ENDIF

            SELECT DISTINCT EmpDopNums, SUM(Qtds) AS Qtds ;
                FROM (par_cCursorEstPd) ;
                WHERE Fk_chave = THIS.this_cLpKey ;
                GROUP BY EmpDopNums ;
                ORDER BY EmpDopNums ;
                INTO CURSOR cursor_4c_LocalEstPd READWRITE

            SELECT cursor_4c_LocalEstPd
            SCAN
                *-- Equivalente a:
                *-- Select a.Emps, a.EmpDs, a.Dopes, a.Numes, a.GrupoDs, a.ContaDs,
                *--        b.RClis, a.Usuars, a.Datas, a.PrazoEnts
                *--   From SigMvCab a, SigCdCli b
                *--  Where a.EmpDopNums = '<EmpDopNums>' And a.ContaDs = b.IClis
                loc_cSQL = "SELECT a.Emps, a.EmpDs, a.Dopes, a.Numes, a.grupods AS GrupoDs,"
                loc_cSQL = loc_cSQL + " a.contads AS ContaDs, b.rclis AS RClis, a.Usuars,"
                loc_cSQL = loc_cSQL + " a.Datas, a.prazoents AS PrazoEnts"
                loc_cSQL = loc_cSQL + " FROM SigMvCab a, SigCdCli b"
                loc_cSQL = loc_cSQL + " WHERE a.empdopnums = " + EscaparSQL(cursor_4c_LocalEstPd.EmpDopNums)
                loc_cSQL = loc_cSQL + " AND a.contads = b.iclis"

                IF USED("cursor_4c_EstDet")
                    USE IN cursor_4c_EstDet
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstDet")

                IF loc_nResultado < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (EstDet)")
                    SELECT cursor_4c_LocalEstPd
                    LOOP
                ENDIF

                SELECT cursor_4c_EstDet
                SCAN
                    IF ISNULL(cursor_4c_EstDet.Datas)
                        loc_dDatas = {}
                    ELSE
                        loc_dDatas = TTOD(cursor_4c_EstDet.Datas)
                    ENDIF

                    IF ISNULL(cursor_4c_EstDet.PrazoEnts)
                        loc_dPrazoEnts = {}
                    ELSE
                        loc_dPrazoEnts = TTOD(cursor_4c_EstDet.PrazoEnts)
                    ENDIF

                    INSERT INTO (THIS.this_cCursorGrade) ;
                        (Emps, Dopes, Numes, GrupoDs, ContaDs, RClis, Usuars, Datas, PrazoEnts, EmpDs, Pendentes) ;
                        VALUES ;
                        (cursor_4c_EstDet.Emps, cursor_4c_EstDet.Dopes, cursor_4c_EstDet.Numes, ;
                         cursor_4c_EstDet.GrupoDs, cursor_4c_EstDet.ContaDs, cursor_4c_EstDet.RClis, ;
                         cursor_4c_EstDet.Usuars, loc_dDatas, loc_dPrazoEnts, cursor_4c_EstDet.EmpDs, ;
                         cursor_4c_LocalEstPd.Qtds)

                    SELECT cursor_4c_EstDet
                ENDSCAN

                IF USED("cursor_4c_EstDet")
                    USE IN cursor_4c_EstDet
                ENDIF

                SELECT cursor_4c_LocalEstPd
            ENDSCAN

            IF USED("cursor_4c_LocalEstPd")
                USE IN cursor_4c_LocalEstPd
            ENDIF

            *-- Equivalente ao trecho do legado que soma o saldo em aberto da
            *-- grade e grava o total no cursor de rodape.
            loc_nTotalPendentes = 0
            SELECT (THIS.this_cCursorGrade)
            SUM Pendentes TO loc_nTotalPendentes

            INSERT INTO (THIS.this_cCursorRodape) (Pendentes) VALUES (loc_nTotalPendentes)

            SELECT (THIS.this_cCursorGrade)
            GO TOP
            SELECT (THIS.this_cCursorRodape)
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MsgErro(loException.Message, "Erro em sigmvpenBO.BuscarPendentes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia a linha CORRENTE de this_cCursorGrade para as
    * propriedades this_*. Equivalente ao que o AfterRowColChange do grid
    * legado fazia lendo crGrade.<campo> diretamente - aqui o Form chama este
    * metodo do BO a cada troca de linha (PILAR 3: leitura de dados no BO,
    * nao no Form) e depois espelha this_cEmpDs/this_cUsuars/this_cRClis no
    * rodape e no getRClis.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF !EOF()
                    THIS.this_cEmps      = TratarNulo(Emps, "")
                    THIS.this_cDopes     = TratarNulo(Dopes, "")
                    THIS.this_nNumes     = TratarNulo(Numes, 0)
                    THIS.this_cGrupoDs   = TratarNulo(GrupoDs, "")
                    THIS.this_cContaDs   = TratarNulo(ContaDs, "")
                    THIS.this_cRClis     = TratarNulo(RClis, "")
                    THIS.this_cUsuars    = TratarNulo(Usuars, "")
                    THIS.this_dDatas     = ConverterParaData(Datas)
                    THIS.this_dPrazoEnts = ConverterParaData(PrazoEnts)
                    THIS.this_cEmpDs     = TratarNulo(EmpDs, "")
                    THIS.this_nPendentes = TratarNulo(Pendentes, 0)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvpenBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao ha PK de registro unico nesta tela (a "chave"
    * do dialogo eh o proprio filtro Fk_chave, compartilhado por todas as
    * linhas da grade). Sobrescrito apenas para o contrato de BusinessBase;
    * este BO nunca chama RegistrarAuditoria/Salvar/Excluir - ver nota abaixo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cLpKey, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * NOTA: Inserir()/Atualizar()/ExecutarExclusao() NAO sao sobrescritos.
    * O form legado sigmvpen e um dialogo de CONSULTA (o unico botao, "ok",
    * apenas fecha a tela com ThisForm.Release - nao ha INSERT/UPDATE/DELETE
    * em lugar nenhum do codigo original). Sobrescrever esses metodos aqui
    * inventaria gravacao que o legado nunca teve (violaria a paridade
    * funcional). Os defaults herdados de BusinessBase permanecem validos,
    * pois Salvar()/Excluir() jamais sao chamados por este BO/Form.
    *--------------------------------------------------------------------------

ENDDEFINE

