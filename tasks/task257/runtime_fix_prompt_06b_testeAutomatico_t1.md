# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarDadosReais': Property CARREGARLISTA is not found. | Detalhes: Linha: 799, Proc: testecarregardadosreais

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-14 15:12:22] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-14 15:12:22] [INFO] Config FPW: (nao fornecido)
[2026-07-14 15:12:22] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-14 15:12:22] [INFO] Timeout: 300 segundos
[2026-07-14 15:12:22] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2fwqhxwc.prg
[2026-07-14 15:12:22] [INFO] Conteudo do wrapper:
[2026-07-14 15:12:22] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRALE', 'C:\4c\tasks\task257', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRALE', 'C:\4c\tasks\task257', 'OPERACIONAL'
QUIT

[2026-07-14 15:12:22] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2fwqhxwc.prg
[2026-07-14 15:12:22] [INFO] VFP output esperado em: C:\4c\tasks\task257\vfp_output.txt
[2026-07-14 15:12:22] [INFO] Executando Visual FoxPro 9...
[2026-07-14 15:12:22] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2fwqhxwc.prg
[2026-07-14 15:12:22] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2fwqhxwc.prg
[2026-07-14 15:12:22] [INFO] Timeout configurado: 300 segundos
[2026-07-14 15:12:44] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-14 15:12:44] [INFO] VFP9 finalizado em 21.5942249 segundos
[2026-07-14 15:12:44] [INFO] Exit Code: 
[2026-07-14 15:12:44] [INFO] 
[2026-07-14 15:12:44] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-14 15:12:44] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2fwqhxwc.prg
[2026-07-14 15:12:44] [INFO] 
[2026-07-14 15:12:44] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-14 15:12:44] [INFO] * Auto-generated wrapper for parameters
[2026-07-14 15:12:44] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-14 15:12:44] [INFO] * Parameters: 'FormSIGPRALE', 'C:\4c\tasks\task257', 'OPERACIONAL'
[2026-07-14 15:12:44] [INFO] 
[2026-07-14 15:12:44] [INFO] * Anti-dialog protections for unattended execution
[2026-07-14 15:12:44] [INFO] SET SAFETY OFF
[2026-07-14 15:12:44] [INFO] SET RESOURCE OFF
[2026-07-14 15:12:44] [INFO] SET TALK OFF
[2026-07-14 15:12:44] [INFO] SET NOTIFY OFF
[2026-07-14 15:12:44] [INFO] SYS(2335, 0)
[2026-07-14 15:12:44] [INFO] 
[2026-07-14 15:12:44] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRALE', 'C:\4c\tasks\task257', 'OPERACIONAL'
[2026-07-14 15:12:44] [INFO] QUIT
[2026-07-14 15:12:44] [INFO] 
[2026-07-14 15:12:44] [INFO] === Fim do Wrapper.prg ===
[2026-07-14 15:12:44] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGPRALE",
  "timestamp": "20260714151244",
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
      "erro": "Property CARREGARLISTA is not found.",
      "detalhes": "Linha: 799, Proc: testecarregardadosreais"
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 2 (FORMKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRALE.prg):
*==============================================================================
* FormSIGPRALE.prg - Dialogo de progresso/aguarde exibido durante processamentos
* Equivalente ao SIGPRALE.SCX do legado
* Uso: loForm = CREATEOBJECT("FormSIGPRALE", cBitmap, cMsg1, cMsg2, cMsg3)
*      loForm.Show()
*      ... processamento ...
*==============================================================================

DEFINE CLASS FormSIGPRALE AS FormBase

    *-- Parametros de exibicao (populados no Init antes de DODEFAULT)
    this_cBitmap    = ""
    this_cMensagem1 = "Aguarde..."
    this_cMensagem2 = ""
    this_cMensagem3 = ""

    *-- Flag de cancelamento (setada por ESC; consumidor le entre iteracoes)
    this_lCancelou  = .F.

    *-- Propriedades visuais (PILAR 1: identico ao legado)
    Width        = 419
    Height       = 115
    AutoCenter   = .T.
    BorderStyle  = 2
    Caption      = ""
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    AlwaysOnTop  = .T.
    ClipControls = .F.
    DataSession  = 2

    *--------------------------------------------------------------------------
    * Init - Aceita parametros opcionais de bitmap e mensagens
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cBitmap, par_cMsg1, par_cMsg2, par_cMsg3)
        LOCAL loc_lSucesso

        *-- Armazenar parametros ANTES de DODEFAULT (que chama InicializarForm)
        IF TYPE("par_cBitmap") = "C"
            THIS.this_cBitmap = par_cBitmap
        ENDIF

        IF TYPE("par_cMsg1") = "C" OR TYPE("par_cMsg2") = "C" OR TYPE("par_cMsg3") = "C"
            IF TYPE("par_cMsg1") = "C"
                THIS.this_cMensagem1 = par_cMsg1
            ELSE
                THIS.this_cMensagem1 = ""
            ENDIF
            IF TYPE("par_cMsg2") = "C"
                THIS.this_cMensagem2 = par_cMsg2
            ELSE
                THIS.this_cMensagem2 = ""
            ENDIF
            IF TYPE("par_cMsg3") = "C"
                THIS.this_cMensagem3 = par_cMsg3
            ELSE
                THIS.this_cMensagem3 = ""
            ENDIF
        ENDIF

        loc_lSucesso = DODEFAULT()

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Aparencia base do dialogo (OPERACIONAL sem PageFrame)
    * Form SIGPRALE eh um dialogo plano de progresso; sem PageFrame/Pages.
    * Este metodo configura fundo, fontes e cor de base do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.BackColor  = RGB(212, 208, 200)
        THIS.ScrollBars = 0
        THIS.ShowTips   = .F.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)

        *-- Fundo do dialogo (new_background.jpg do legado)
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria e configura todos os controles do dialogo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Business Object (sem tabela - form nao persiste dados)
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRALEBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Configura aparencia base do form (fundo, fontes, cores)
                THIS.ConfigurarPageFrame()

                *-- Criar imagem (icone/bitmap passado como parametro)
                THIS.AddObject("img_4c_Imagem", "Image")
                WITH THIS.img_4c_Imagem
                    .Top     = 5
                    .Left    = 6
                    .Width   = 38
                    .Height  = 36
                    IF !EMPTY(THIS.this_cBitmap) AND FILE(THIS.this_cBitmap)
                        .Picture = THIS.this_cBitmap
                        .Visible = .T.
                    ELSE
                        .Visible = .F.
                    ENDIF
                ENDWITH

                *-- Linha 1 da mensagem (principal, ex: "Aguarde...")
                THIS.AddObject("lbl_4c_Mensagem", "Label")
                WITH THIS.lbl_4c_Mensagem
                    .Top       = 4
                    .Left      = 85
                    .Width     = 314
                    .Height    = 25
                    .AutoSize  = .F.
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 14
                    .WordWrap  = .T.
                    .Alignment = 2
                    .BackStyle = 0
                    .ForeColor = RGB(255, 0, 0)
                    .Caption   = THIS.this_cMensagem1
                    .Visible   = .T.
                ENDWITH

                *-- Linha 2 da mensagem
                THIS.AddObject("lbl_4c_Mensagem2", "Label")
                WITH THIS.lbl_4c_Mensagem2
                    .Top       = 32
                    .Left      = 85
                    .Width     = 314
                    .Height    = 25
                    .AutoSize  = .F.
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 14
                    .WordWrap  = .T.
                    .Alignment = 2
                    .BackStyle = 0
                    .ForeColor = RGB(255, 0, 0)
                    .Caption   = THIS.this_cMensagem2
                    .Visible   = .T.
                ENDWITH

                *-- Linha 3 da mensagem (mais alta para texto longo)
                THIS.AddObject("lbl_4c_Mensagem3", "Label")
                WITH THIS.lbl_4c_Mensagem3
                    .Top       = 62
                    .Left      = 85
                    .Width     = 314
                    .Height    = 48
                    .AutoSize  = .F.
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 14
                    .WordWrap  = .T.
                    .Alignment = 2
                    .BackStyle = 0
                    .ForeColor = RGB(255, 0, 0)
                    .Caption   = THIS.this_cMensagem3
                    .Visible   = .T.
                ENDWITH

                *-- Handler de ESC para sinalizar cancelamento (Closable=.F.,
                *-- consumidor loop de processamento verifica this_lCancelou)
                BINDEVENT(THIS, "KeyPress", THIS, "FormKeyPress")

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SIGPRALEBO.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormKeyPress - Handler bindado a KeyPress do form
    * ESC (27) sinaliza cancelamento; consumidor deve verificar this_lCancelou
    * entre iteracoes do processamento e abortar/liberar o dialogo se .T.
    *--------------------------------------------------------------------------
    PROCEDURE FormKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27
            THIS.this_lCancelou = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarMensagens - Atualiza textos do dialogo em tempo de execucao
    * Permite que o chamador altere as mensagens sem recriar o form
    * par_cMsg1/2/3: nova mensagem (passar "" para limpar, .NULL. para nao alterar)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarMensagens(par_cMsg1, par_cMsg2, par_cMsg3)
        LOCAL loc_oErro
        TRY
            IF TYPE("par_cMsg1") = "C"
                THIS.lbl_4c_Mensagem.Caption  = par_cMsg1
                THIS.this_cMensagem1          = par_cMsg1
            ENDIF
            IF TYPE("par_cMsg2") = "C"
                THIS.lbl_4c_Mensagem2.Caption = par_cMsg2
                THIS.this_cMensagem2          = par_cMsg2
            ENDIF
            IF TYPE("par_cMsg3") = "C"
                THIS.lbl_4c_Mensagem3.Caption = par_cMsg3
                THIS.this_cMensagem3          = par_cMsg3
            ENDIF
            THIS.Refresh()
            DOEVENTS
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarBitmap - Troca a imagem exibida no dialogo
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarBitmap(par_cBitmap)
        LOCAL loc_oErro
        TRY
            IF TYPE("par_cBitmap") = "C" AND !EMPTY(par_cBitmap) AND FILE(par_cBitmap)
                THIS.img_4c_Imagem.Picture = par_cBitmap
                THIS.img_4c_Imagem.Visible = .T.
                THIS.this_cBitmap = par_cBitmap
            ELSE
                THIS.img_4c_Imagem.Visible = .F.
            ENDIF
            THIS.Refresh()
            DOEVENTS
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - N/A (form OPERACIONAL de dialogo, sem PageFrame)
    * SIGPRALE eh um dialogo modal de progresso (419x115) sem Page1/Grid/Botoes CRUD.
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 4).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- Sem-operacao: form nao possui PageFrame nem grid de lista.
        *-- Layout do dialogo eh totalmente construido em InicializarForm().
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - N/A (form OPERACIONAL de dialogo, sem Page2)
    * SIGPRALE eh um dialogo modal de progresso (419x115) sem campos de entrada.
    * Todos os controles (img_4c_Imagem, lbl_4c_Mensagem/2/3) sao criados
    * diretamente em InicializarForm(), nao em paginas separadas.
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 5).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Sem-operacao: form nao possui Page2 nem campos de entrada.
        *-- Controles de exibicao estao em InicializarForm().
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - N/A (form OPERACIONAL de dialogo, sem PageFrame)
    * SIGPRALE nao alterna entre paginas; sempre exibe imagem + 3 mensagens.
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 4).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        *-- Sem-operacao: dialogo nao possui paginas para alternar.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - N/A (form OPERACIONAL de dialogo, sem CRUD)
    * SIGPRALE eh um dialogo modal de progresso exibido durante processamentos
    * (ex: Reducao Z). Nao inclui/altera/visualiza/exclui registros - apenas
    * exibe status ao usuario enquanto o processamento em background executa.
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 7).
    * Consumidor tipico: DO WHILE processando / oProg.AtualizarMensagens(...) / ENDDO
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        *-- Sem-operacao: dialogo de progresso nao suporta inclusao de registros.
        *-- Ver AtualizarMensagens() / AtualizarBitmap() para uso pretendido.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - N/A (form OPERACIONAL de dialogo, sem CRUD)
    * SIGPRALE nao possui campos editaveis nem grid de lista para alterar.
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 7).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        *-- Sem-operacao: dialogo de progresso nao suporta alteracao de registros.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - N/A (form OPERACIONAL de dialogo, sem CRUD)
    * SIGPRALE ja eh o proprio dialogo de exibicao - nao ha registros
    * secundarios para visualizar (imagem + 3 labels ja sao o conteudo).
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 7).
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        *-- Sem-operacao: dialogo ja eh visual por natureza; sem grid/registros.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - N/A (form OPERACIONAL de dialogo, sem CRUD)
    * SIGPRALE nao persiste dados; encerramento eh via Release() do chamador
    * apos concluir o processamento em background. Nao ha registros para excluir.
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 7).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        *-- Sem-operacao: dialogo de progresso nao suporta exclusao de registros.
        *-- Para encerrar o dialogo, o chamador deve invocar THIS.Release().
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - N/A (dialogo de progresso sem busca de registros)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        *-- Sem-operacao: dialogo de progresso nao possui grade nem busca.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o dialogo de progresso
    * Chamado pelo consumidor ou por tecla ESC (via FormKeyPress)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.this_lCancelou = .T.
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - N/A (dialogo nao-persistente, sem campos editaveis)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        *-- Sem-operacao: form de progresso nao persiste dados.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela processamento em curso e fecha o dialogo
    * Sinaliza cancelamento para o consumidor atraves de this_lCancelou
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_lCancelou = .T.
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia estado atual do form para o BO
    * Para SIGPRALE: sincroniza as mensagens e bitmap exibidos com o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cBitmap    = THIS.this_cBitmap
                THIS.this_oBusinessObject.this_cMensagem1 = THIS.this_cMensagem1
                THIS.this_oBusinessObject.this_cMensagem2 = THIS.this_cMensagem2
                THIS.this_oBusinessObject.this_cMensagem3 = THIS.this_cMensagem3
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia dados do BO de volta para os controles do form
    * Para SIGPRALE: atualiza as labels com as mensagens do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.lbl_4c_Mensagem.Caption  = THIS.this_oBusinessObject.this_cMensagem1
                THIS.lbl_4c_Mensagem2.Caption = THIS.this_oBusinessObject.this_cMensagem2
                THIS.lbl_4c_Mensagem3.Caption = THIS.this_oBusinessObject.this_cMensagem3
                THIS.this_cMensagem1 = THIS.this_oBusinessObject.this_cMensagem1
                THIS.this_cMensagem2 = THIS.this_oBusinessObject.this_cMensagem2
                THIS.this_cMensagem3 = THIS.this_oBusinessObject.this_cMensagem3

                IF !EMPTY(THIS.this_oBusinessObject.this_cBitmap) AND ;
                   FILE(THIS.this_oBusinessObject.this_cBitmap)
                    THIS.img_4c_Imagem.Picture = THIS.this_oBusinessObject.this_cBitmap
                    THIS.img_4c_Imagem.Visible = .T.
                    THIS.this_cBitmap = THIS.this_oBusinessObject.this_cBitmap
                ELSE
                    THIS.img_4c_Imagem.Visible = .F.
                ENDIF

                THIS.Refresh()
                DOEVENTS
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - N/A (dialogo sem campos de entrada editaveis)
    * SIGPRALE exibe informacao read-only; nao ha campos para habilitar/desabilitar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        *-- Sem-operacao: form de progresso nao possui campos editaveis.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa as mensagens exibidas no dialogo
    * Util para reutilizacao do dialogo em fases distintas de processamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            THIS.this_cMensagem1 = ""
            THIS.this_cMensagem2 = ""
            THIS.this_cMensagem3 = ""
            THIS.lbl_4c_Mensagem.Caption  = ""
            THIS.lbl_4c_Mensagem2.Caption = ""
            THIS.lbl_4c_Mensagem3.Caption = ""
            THIS.img_4c_Imagem.Visible    = .F.
            THIS.this_cBitmap             = ""
            THIS.Refresh()
            DOEVENTS
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - N/A (dialogo de progresso sem grade de registros)
    * SIGPRALE nao exibe lista; conteudo e definido via parametros do Init
    * ou via AtualizarMensagens() durante o processamento em andamento.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarLista()
        *-- Sem-operacao: dialogo de progresso nao possui grade de lista.
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - N/A (dialogo de progresso sem modos CRUD)
    * SIGPRALE nao possui botoes CRUD nem modos INCLUIR/ALTERAR/VISUALIZAR.
    * O dialogo e exibido enquanto processamento externo executa e e encerrado
    * pelo chamador via THIS.Release() apos conclusao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        *-- Sem-operacao: dialogo de progresso nao possui modos nem botoes CRUD.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            UNBINDEVENTS(THIS)
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRALEBO.prg):
*==============================================================================
* SIGPRALEBO.prg - Business Object para FormSIGPRALE
* Dialogo de progresso/aguarde exibido durante processamentos
*==============================================================================
DEFINE CLASS SIGPRALEBO AS BusinessBase

    *-- Parametros do dialogo
    this_cBitmap    = ""    && Caminho da imagem a exibir
    this_cMensagem1 = ""    && Linha 1 da mensagem (caption "Aguarde...")
    this_cMensagem2 = ""    && Linha 2 da mensagem
    this_cMensagem3 = ""    && Linha 3 da mensagem

    *--------------------------------------------------------------------------
    * Init - Configura BO (sem tabela - form nao persiste dados)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega parametros de exibicao a partir de cursor
    * Form nao possui campos persistidos; cursor apenas transporta parametros
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF TYPE("cBitmap") = "C"
                    THIS.this_cBitmap    = TratarNulo(cBitmap,    "C")
                ENDIF
                IF TYPE("cMensagem1") = "C"
                    THIS.this_cMensagem1 = TratarNulo(cMensagem1, "C")
                ENDIF
                IF TYPE("cMensagem2") = "C"
                    THIS.this_cMensagem2 = TratarNulo(cMensagem2, "C")
                ENDIF
                IF TYPE("cMensagem3") = "C"
                    THIS.this_cMensagem3 = TratarNulo(cMensagem3, "C")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form nao possui tabela nem chave primaria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Dialogo nao-persistente (apenas exibe parametros ao usuario)
    * Retorna .T. porque nao ha tabela para persistir dados
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .T.

        TRY
            IF !EMPTY(THIS.this_cTabela)
                loc_lSucesso = DODEFAULT()

                IF loc_lSucesso
                    THIS.RegistrarAuditoria("I")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Dialogo nao-persistente (apenas exibe parametros ao usuario)
    * Retorna .T. porque nao ha tabela para persistir dados
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .T.

        TRY
            IF !EMPTY(THIS.this_cTabela)
                loc_lSucesso = DODEFAULT()

                IF loc_lSucesso
                    THIS.RegistrarAuditoria("A")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Dialogo nao-persistente (nao ha registros para excluir)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Sem tabela, sem auditoria (nao-op)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        IF !EMPTY(THIS.this_cTabela)
            DODEFAULT(par_cOperacao)
        ENDIF
    ENDPROC

ENDDEFINE

