# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-25 22:37:12] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-25 22:37:12] [INFO] Config FPW: (nao fornecido)
[2026-09-25 22:37:12] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-25 22:37:12] [INFO] Timeout: 300 segundos
[2026-09-25 22:37:12] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ql4ndvru.prg
[2026-09-25 22:37:12] [INFO] Conteudo do wrapper:
[2026-09-25 22:37:12] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGPRALE', 'C:\4c\tasks\task582\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRALE', 'C:\4c\tasks\task582\logs\06_testForm.log'
QUIT

[2026-09-25 22:37:12] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ql4ndvru.prg
[2026-09-25 22:37:12] [INFO] VFP output esperado em: C:\4c\tasks\task582\vfp_output.txt
[2026-09-25 22:37:12] [INFO] Executando Visual FoxPro 9...
[2026-09-25 22:37:12] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ql4ndvru.prg
[2026-09-25 22:37:12] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ql4ndvru.prg
[2026-09-25 22:37:12] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGPRALE
Inicio: 25/09/2026 22:37:12

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 25/09/2026 22:40:28
Duracao: 196 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-25 22:40:28] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-25 22:40:28] [INFO] VFP9 finalizado em 195.7336729 segundos
[2026-09-25 22:40:28] [INFO] Exit Code: 
[2026-09-25 22:40:28] [INFO] 
[2026-09-25 22:40:28] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-25 22:40:28] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ql4ndvru.prg
[2026-09-25 22:40:28] [INFO] 
[2026-09-25 22:40:28] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-25 22:40:28] [INFO] * Auto-generated wrapper for parameters
[2026-09-25 22:40:28] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-25 22:40:28] [INFO] * Parameters: 'FormSIGPRALE', 'C:\4c\tasks\task582\logs\06_testForm.log'
[2026-09-25 22:40:28] [INFO] 
[2026-09-25 22:40:28] [INFO] * Anti-dialog protections for unattended execution
[2026-09-25 22:40:28] [INFO] SET SAFETY OFF
[2026-09-25 22:40:28] [INFO] SET RESOURCE OFF
[2026-09-25 22:40:28] [INFO] SET TALK OFF
[2026-09-25 22:40:28] [INFO] SET NOTIFY OFF
[2026-09-25 22:40:28] [INFO] SYS(2335, 0)
[2026-09-25 22:40:28] [INFO] 
[2026-09-25 22:40:28] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRALE', 'C:\4c\tasks\task582\logs\06_testForm.log'
[2026-09-25 22:40:28] [INFO] QUIT
[2026-09-25 22:40:28] [INFO] 
[2026-09-25 22:40:28] [INFO] === Fim do Wrapper.prg ===
[2026-09-25 22:40:28] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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
* FORMSIGPRALE.PRG
* Formulario SIGPRALE - dialogo de aguarde exibido durante a finalizacao da
* Reducao Z da impressora fiscal (chamado como SIGPRALE(<bitmap>, msg1, msg2,
* msg3) no legado - ver SIGPRALE_form_codigo_fonte.txt).
*
* SIGPRALE.SCX legado e' um form GENERICO (Class: form, BaseClass: form), sem
* PageFrame e sem nenhum Container: Imagem/mensagem/mensagem2/mensagem3 estao
* penduradas direto na Form (Secao 1 do dump). Por isso este form NAO tem
* PageFrame nem Page1=Lista/Page2=Dados - e' o sub-ramo FLAT SEM CONTAINER dos
* forms OPERACIONAIS (mesma familia de dialogo simples do fwprogressbar - ver
* CLAUDE.md "fwprogressbar NAO PORTADA"). A montagem de Imagem/mensagem* entra
* nas proximas fases (Fases 5-6).
*
* FASE 8 (Eventos Auxiliares e Consolidacao Final): o SCX legado NAO tem
* NENHUM CommandButton (Secao 1 do dump lista so Imagem + 3 Label - nem um
* "Sair"/"Fechar"), NENHUM campo editavel, NENHUMA grade e NENHUM PageFrame
* (Secao 3 so tem PROCEDURE Init - comportamento.json: totalMetodos=1). Nao
* ha o que Buscar, Encerrar, Salvar ou Cancelar: o dialogo eh mostrado com
* .Show() (nao-modal, ver ExibirComo/WindowType herdado de FormBase) pelo
* CODIGO que o instancia - com os 4 parametros ja resolvidos no Init - e
* Por isso NAO ha:
*   - BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/BtnCancelarClick: nao
*     existe botao nenhum no legado para ancorar esses handlers (inventa-los
*     seria inventar controles novos, violando o PILAR 1);
*   - FormParaBO()/BOParaForm(): os 4 parametros do Init (this_cParamBitmap/
*     this_cParamMensagem1/2/3) ja sao aplicados diretamente aos controles
*     em ConfigurarControles() - nao ha edicao de campo nem Salvar/Excluir
*     que dispare esse round-trip (FormBase.Salvar/Excluir, que sao os
*     unicos chamadores de FormParaBO/BOParaForm, nunca sao acionados aqui
*     porque nao ha botao que os chame). O no-op herdado de FormBase (linhas
*     280-288 de formbase.prg) ja eh o correto - sobrescrever aqui criaria
*     plumbing morto, sem chamador;
*   - HabilitarCampos()/LimparCampos(): nao ha campo editavel para habilitar
*     ou limpar (zero TextBox/EditBox/ComboBox/CheckBox no dump - mesma
*     conclusao da FASE 5);
*   - CarregarLista()/AjustarBotoesPorModo(): nao ha grid (Page1=Lista) nem
*     modos INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR - o dialogo nao tem conceito
*     de "modo atual", so o parametro de mensagem recebido uma unica vez.
* Nao ha item de menu.prg para este dialogo pela mesma razao: nenhum ponto
* do acervo legado (nem SIGPRALE_form_codigo_fonte.txt, nem os demais forms
* ja migrados) chama SIGPRALE(...) - o(s) caller(s) reais (rotina de
* fechamento de caixa/impressora fiscal) estao fora do escopo desta task.
* Criar uma entrada de menu que abre o dialogo isolado (sem quem o feche)
* inventaria uma superficie de uso que o legado nao tem. A classe ja esta
* completa e funcional como componente reutilizavel: THIS.this_oBusinessObject
* fica disponivel para quem quiser estender no futuro (ex.: registrar log da
* Reducao Z), mas nada no comportamento observado do legado exige isso hoje.
*
* FASE 7 (Eventos Principais): o SCX legado NAO tem NENHUM CommandButton nem
* metodo de Click (Secao 3 do dump so lista o PROCEDURE Init - ver
* comportamento.json: totalMetodos=1, metodosComSQL=0, metodosComValidacao=0).
* E' um dialogo passivo de "Aguarde...", sem Incluir/Alterar/Visualizar/
* Excluir - o usuario nao interage com ele, apenas o ve enquanto a Reducao Z
* da impressora fiscal termina, e ele e' fechado por codigo (Release) por
* quem o chamou. Criar BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
* BtnExcluirClick aqui inventaria uma superficie CRUD que o legado nao tem
* (mesma logica das Fases 4/5/6 acima - PILAR 1). Nao ha nada para esta fase
* acrescentar neste form especifico.
*
* FASE 6 (Campos Restantes e Lookups): o SCX legado NAO tem NENHUM lookup
* (Secao 3 do dump so tem o PROCEDURE Init, sem Valid/KeyPress/DblClick, e
* comportamento.json confirma temLookup=false, temSQL=false) - nao ha
* BINDEVENT nem AbrirLookupXxx() para acrescentar aqui, sob pena de inventar
* funcionalidade que o legado nao tem (mesma logica das Fases 4/5 abaixo).
* O que cabia nesta fase era a SEGUNDA METADE dos 4 objetos visuais do
* dump - mensagem2 + mensagem3 - concluindo ConfigurarControles() e a
* transcricao do Init legado (as tres Captions sao substituidas juntas,
* uma so vazia quando o parametro correspondente nao foi informado).
*
* FASE 5 (Campos Principais - Parte 1): o SCX legado NAO tem NENHUM controle
* de entrada de dados (Secao 1 do dump: zero TextBox/EditBox/ComboBox/
* CheckBox/OptionGroup/Spinner) - metade de zero campos e' zero campos, e
* inventar uma Page2 de Dados ou um campo com ControlSource aqui violaria o
* PILAR 1. A superficie que o legado de fato tem sao os 4 objetos visuais
* (Imagem + mensagem + mensagem2 + mensagem3); esta fase entregou a PRIMEIRA
* METADE deles (Imagem + mensagem) em ConfigurarControles, junto com a
* transcricao literal do Init legado que os popula.
*
* FASE 4 (Grid e Botoes CRUD): o SCX legado NAO tem grade, NAO tem PageFrame
* e NAO tem NENHUM CommandButton (Secao 1 do dump lista so Imagem + 3 Label;
* o unico codigo do form inteiro e' o Init, sem Click nenhum) - e' um
* dialogo passivo de "Aguarde...", nao um cadastro nem uma tela de lista.
* Adicionar ConfigurarPaginaLista/AlternarPagina/Grid/botoes CRUD aqui
* inventaria funcionalidade que o legado nao tem (viola o PILAR 1 e a
* regra "NUNCA inventar"). Nao ha nada para esta fase acrescentar - a
* estrutura entregue na Fase 3 ja e' suficiente.
*==============================================================================

DEFINE CLASS FormSIGPRALE AS FormBase

    *-- Propriedades visuais (copiadas EXATAS de SIGPRALE.SCX - PILAR 1)
    Height       = 115
    Width        = 419
    Caption      = ""
    DataSession  = 2
    ShowWindow = 1
    WindowType = 1
    AutoCenter   = .T.
    BorderStyle  = 2
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    AlwaysOnTop  = .T.

    *-- Propriedades do Form
    this_cTituloForm = ""

    *-- Parametros recebidos pelo Init legado (LParameters _BitMap, _Msg1,
    *-- _msg2, _msg3), guardados aqui para serem aplicados aos controles
    *-- Imagem/mensagem/mensagem2/mensagem3 em ConfigurarControles().
    this_cParamBitmap    = ""
    this_cParamMensagem1 = ""
    this_cParamMensagem2 = ""
    this_cParamMensagem3 = ""

    *-- O Init legado testa PRESENCA do parametro (Type("_BitMap") = "C" /
    *-- Type('_Msg1') = 'C'), NAO se ele esta preenchido: o chamador que passa
    *-- string VAZIA tem a Caption padrao do SCX SUBSTITUIDA por vazio, e a
    *-- Imagem fica visivel mesmo com Picture vazio. Como as properties acima
    *-- nao conseguem distinguir "nao informado" de "informado vazio", a
    *-- presenca de cada parametro e' registrada nestes flags (transcricao
    *-- literal do Init legado - ver CLAUDE.md regra #17).
    this_lTemBitmap   = .F.
    this_lTemMensagem = .F.

    *==========================================================================
    * Init - recebe os mesmos 4 parametros do Init legado e delega para
    * FormBase.Init() (que chama InicializarForm() internamente)
    *==========================================================================
    PROCEDURE Init(par_cBitmap, par_cMensagem1, par_cMensagem2, par_cMensagem3)
        THIS.this_cParamBitmap    = IIF(VARTYPE(par_cBitmap) = "C", par_cBitmap, "")
        THIS.this_cParamMensagem1 = IIF(VARTYPE(par_cMensagem1) = "C", par_cMensagem1, "")
        THIS.this_cParamMensagem2 = IIF(VARTYPE(par_cMensagem2) = "C", par_cMensagem2, "")
        THIS.this_cParamMensagem3 = IIF(VARTYPE(par_cMensagem3) = "C", par_cMensagem3, "")

        *-- Legado: If Type("_BitMap") = "C"  /  If Type('_Msg1') = 'C' Or
        *--         Type('_msg2')='C' Or Type('_msg3')='C'
        THIS.this_lTemBitmap   = (VARTYPE(par_cBitmap) = "C")
        THIS.this_lTemMensagem = (VARTYPE(par_cMensagem1) = "C") OR ;
                                 (VARTYPE(par_cMensagem2) = "C") OR ;
                                 (VARTYPE(par_cMensagem3) = "C")

        *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init().
        *-- FormBase.Init() NAO recebe parametros - por isso os 4 valores
        *-- acima sao guardados em properties ANTES do DODEFAULT(), que e'
        *-- como ConfigurarControles() os alcanca.
        *-- NAO chamar THIS.InicializarForm() novamente aqui!
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Instancia o Business Object, aplica o fundo do
    * dialogo (Picture do legado) e monta os controles (Imagem/Labels).
    * SIGPRALE nao tem PageFrame nem Container no legado - os controles sao
    * criados DIRETO na Form via THIS.AddObject() (ver ConfigurarControles).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado, loc_cPicture
        loc_lResultado = .F.

        loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
        IF FILE(loc_cPicture)
            THIS.Picture = loc_cPicture
        ENDIF

        THIS.this_oBusinessObject = CREATEOBJECT("SIGPRALEBO")

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.ConfigurarControles()
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarControles - Cria os controles do dialogo (Imagem + Labels).
    * SIGPRALE.SCX legado nao tem PageFrame nem NENHUM Container (Secao 1 do
    * dump): Imagem/mensagem/mensagem2/mensagem3 estao penduradas DIRETO na
    * Form (SIGPRALE.Imagem, SIGPRALE.mensagem, ...). Por isso nao ha
    * Page1=Lista/Page2=Dados aqui - eh o sub-ramo FLAT SEM CONTAINER dos
    * forms OPERACIONAIS, e os controles sao adicionados direto em THIS.
    *
    * FASE 5 entregou a primeira metade (2 dos 4 objetos do dump): Imagem +
    * mensagem. FASE 6 completou com a segunda metade: mensagem2 + mensagem3.
    *
    * Reproduz tambem a logica do Init legado (LParameters _BitMap, _Msg1,
    * _msg2, _msg3): Imagem so fica visivel quando o parametro de bitmap eh
    * informado, e a Caption de "mensagem" so eh sobrescrita quando algum dos
    * tres parametros de mensagem foi informado - caso contrario prevalecem
    * os Captions padrao do SCX ("Aguarde...", etc).
    *
    * NOTA sobre AutoSize (CLAUDE.md regra #23): os tres Say do SCX declaram
    * AutoSize = .T., mas em Label criado por AddObject essa propriedade NAO
    * eh utilizavel - MEDIDO no VFP9 em 2026-09-25 reproduzindo a ordem exata
    * de atribuicao deste metodo (automation\medir_autosize_label.prg e
    * medir_autosize_label2.prg):
    *
    *   AutoSize = .T.  -> mensagem 97x25 OK | mensagem2 221x25 OK |
    *                      mensagem3 248x25  (o .Height = 48 eh DESCARTADO)
    *   AutoSize = .F.  -> mensagem 97x25 OK | mensagem2 221x25 OK |
    *                      mensagem3 248x48 OK  (e sobrevive a troca de
    *                      Caption em runtime, que eh o que o Init legado faz)
    *
    * Com AutoSize = .T. a 3a mensagem colapsa para UMA linha e a segunda
    * linha de "Por Favor. Nao Desligue a impressora Fiscal." (que precisa de
    * duas linhas em 248px a Tahoma 14 bold) fica CORTADA - sem erro e sem
    * log. Por isso os tres labels ficam com AutoSize = .F. e com o Width/
    * Height EXATOS do dump: esses numeros JA SAO o resultado do auto-size
    * que o Form Designer gravou no SCX, entao fixa-los eh a reproducao fiel
    * do legado, nao um desvio dele.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarControles()
        *-- SIGPRALE.Imagem (dump: Top=5, Left=6, Width=38, Height=36)
        THIS.AddObject("img_4c_Imagem", "Image")
        WITH THIS.img_4c_Imagem
            .Top     = 5
            .Left    = 6
            .Width   = 38
            .Height  = 36
            *-- O SCX legado NAO declara Visible para a Imagem, ou seja ela fica
            *-- no default .T. da base class "image" (o dump lista so Height/
            *-- Left/Top/Width/Name). Como AddObject cria controle com
            *-- Visible = .F., e' preciso setar .T. aqui para reproduzir esse
            *-- default - sem isso a Imagem ficaria oculta quando o chamador
            *-- NAO passa bitmap, divergindo do legado. Sem Picture a Image nao
            *-- desenha nada (BackStyle/BorderStyle default 0), entao o dialogo
            *-- fica visualmente identico nos dois casos.
            .Visible = .T.
        ENDWITH

        *-- Legado: If Type("_BitMap") = "C" / ThisForm.Imagem.Visible = .T. /
        *--         ThisForm.Imagem.Picture = Alltrim(_BitMap) / Endif
        *-- Criterio e' a PRESENCA do parametro, nao o conteudo (ver
        *-- this_lTemBitmap no cabecalho da classe).
        IF THIS.this_lTemBitmap
            THIS.img_4c_Imagem.Visible = .T.
            THIS.img_4c_Imagem.Picture = ALLTRIM(THIS.this_cParamBitmap)
        ENDIF

        *-- SIGPRALE.mensagem (dump: AutoSize=.T./FontBold=.T./FontName=Tahoma/
        *-- FontSize=14/WordWrap=.T./Alignment=2/BackStyle=0/ForeColor=255,0,0/
        *-- Caption="Aguarde..."/Top=4/Left=85/Width=97/Height=25)
        THIS.AddObject("lbl_4c_Mensagem", "Label")
        WITH THIS.lbl_4c_Mensagem
            .AutoSize  = .F.    && ver nota sobre AutoSize no topo de ConfigurarControles
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 14
            .WordWrap  = .T.
            .Alignment = 2
            .BackStyle = 0
            .Caption   = "Aguarde..."
            .Top       = 4
            .Left      = 85
            .Width     = 97
            .Height    = 25
            .ForeColor = RGB(255,0,0)
            .Visible   = .T.
        ENDWITH

        *-- SIGPRALE.mensagem2 (dump: Top=32, Left=85, Width=221, Height=25,
        *-- Caption="Finalizando Reducao Z." - mesma fonte/estilo de mensagem)
        THIS.AddObject("lbl_4c_Mensagem2", "Label")
        WITH THIS.lbl_4c_Mensagem2
            .AutoSize  = .F.    && ver nota sobre AutoSize no topo de ConfigurarControles
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 14
            .WordWrap  = .T.
            .Alignment = 2
            .BackStyle = 0
            .Caption   = "Finalizando Reduc" + CHR(227) + "o Z."
            .Top       = 32
            .Left      = 85
            .Width     = 221
            .Height    = 25
            .ForeColor = RGB(255,0,0)
            .Visible   = .T.
        ENDWITH

        *-- SIGPRALE.mensagem3 (dump: Top=62, Left=85, Width=248, Height=48,
        *-- Caption="Por Favor. Nao Desligue a impressora Fiscal." - mesma
        *-- fonte/estilo de mensagem/mensagem2)
        THIS.AddObject("lbl_4c_Mensagem3", "Label")
        WITH THIS.lbl_4c_Mensagem3
            .AutoSize  = .F.    && ver nota sobre AutoSize no topo de ConfigurarControles
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 14
            .WordWrap  = .T.
            .Alignment = 2
            .BackStyle = 0
            .Caption   = "Por Favor. N" + CHR(227) + "o Desligue a impressora Fiscal."
            .Top       = 62
            .Left      = 85
            .Width     = 248
            .Height    = 48
            .ForeColor = RGB(255,0,0)
            .Visible   = .T.
        ENDWITH

        *-- Legado: If Type('_Msg1')='C' Or Type('_msg2')='C' Or Type('_msg3')='C'
        *--         ThisForm.mensagem.Caption  = Iif(Type('_msg1')='C',_msg1,'')
        *--         ThisForm.mensagem2.Caption = Iif(Type('_msg2')='C',_msg2,'')
        *--         ThisForm.mensagem3.Caption = Iif(Type('_msg3')='C',_msg3,'')
        *-- Basta UM dos tres parametros presente para as TRES Captions do SCX
        *-- serem substituidas - as que nao vieram ficam VAZIAS (nao mantem o
        *-- texto padrao do dump).
        IF THIS.this_lTemMensagem
            THIS.lbl_4c_Mensagem.Caption  = THIS.this_cParamMensagem1
            THIS.lbl_4c_Mensagem2.Caption = THIS.this_cParamMensagem2
            THIS.lbl_4c_Mensagem3.Caption = THIS.this_cParamMensagem3
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRALEBO.prg):
*==============================================================================
* SIGPRALEBO.PRG
* Business Object do formulario SIGPRALE (dialogo de aguarde/mensagem)
* Responsabilidade: manter os dados exibidos no dialogo de espera exibido
* durante a finalizacao da Reducao Z da impressora fiscal.
*
* SIGPRALE e um dialogo de PROGRESSO/AVISO, sem tabela associada no legado
* (o Init original apenas recebia parametros para popular Imagem/Mensagens).
* Por isso this_cTabela e this_cCampoChave permanecem vazios.
*==============================================================================

DEFINE CLASS SIGPRALEBO AS BusinessBase

    *-- Propriedades (espelham os parametros do Init legado: _BitMap, _Msg1, _msg2, _msg3)
    this_cBitmap    = ""    && Caminho da imagem exibida no dialogo (Imagem.Picture)
    this_cMensagem1 = ""    && Texto da 1a linha de mensagem (mensagem.Caption)
    this_cMensagem2 = ""    && Texto da 2a linha de mensagem (mensagem2.Caption)
    this_cMensagem3 = ""    && Texto da 3a linha de mensagem (mensagem3.Caption)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- SIGPRALE nao possui tabela no banco de dados (dialogo de aguarde)
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        DODEFAULT()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - SIGPRALE nao tem cursor nem tabela. As unicas
    * "colunas" do form legado sao os 4 parametros recebidos pelo proprio
    * Init (_BitMap, _Msg1, _msg2, _msg3 - ver comportamento.json), que ja
    * sao atribuidos diretamente as properties this_cBitmap/this_cMensagem1/
    * this_cMensagem2/this_cMensagem3 pelo Form (FormParaBO). Nao ha SELECT,
    * nao ha cursor a percorrer - o comportamento padrao herdado de
    * BusinessBase (no-op, RETURN .T.) ja eh o correto.
    *==========================================================================

    *==========================================================================
    * ObterChavePrimaria - SIGPRALE nao grava registro nenhum (dialogo de
    * aguarde exibido durante a Reducao Z da impressora fiscal). Nao existe
    * chave primaria porque nao existe tabela; retornar vazio mantem
    * RegistrarAuditoria() inofensivo (ela ja aborta quando a chave vem
    * vazia - ver BusinessBase.RegistrarAuditoria).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * Inserir/Atualizar/ExecutarExclusao: SIGPRALE eh um dialogo de
    * PROGRESSO/AVISO (SIGPRALE.SCX), sem AddCursor, sem SQL e sem tabela
    * associada no legado - o Init original apenas recebia 4 parametros e
    * populava Imagem/Mensagens (ver comportamento.json: temSQL=false,
    * totalQueries=0). O comportamento padrao herdado de BusinessBase
    * (recusar a operacao) ja eh o correto - nao ha necessidade de
    * sobrescrever esses tres metodos aqui, e RegistrarAuditoria() nunca
    * roda porque Inserir/Atualizar/ExecutarExclusao nunca sao chamados.
    *==========================================================================

ENDDEFINE

