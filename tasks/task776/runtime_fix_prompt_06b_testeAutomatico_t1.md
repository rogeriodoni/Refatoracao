# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnEncerrarExiste': Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[11/11/2026 07:13:28 PM] Erro em CarregarVinculos: Conexão com o banco não estabelecida.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-11-11 19:13:27] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-11 19:13:27] [INFO] Config FPW: (nao fornecido)
[2026-11-11 19:13:27] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-11 19:13:27] [INFO] Timeout: 300 segundos
[2026-11-11 19:13:27] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_14l0a5pd.prg
[2026-11-11 19:13:27] [INFO] Conteudo do wrapper:
[2026-11-11 19:13:27] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigOpOpe', 'C:\4c\tasks\task776', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpOpe', 'C:\4c\tasks\task776', 'OPERACIONAL'
QUIT

[2026-11-11 19:13:27] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_14l0a5pd.prg
[2026-11-11 19:13:27] [INFO] VFP output esperado em: C:\4c\tasks\task776\vfp_output.txt
[2026-11-11 19:13:27] [INFO] Executando Visual FoxPro 9...
[2026-11-11 19:13:27] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_14l0a5pd.prg
[2026-11-11 19:13:27] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_14l0a5pd.prg
[2026-11-11 19:13:27] [INFO] Timeout configurado: 300 segundos
[2026-11-11 19:13:28] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-11 19:13:28] [INFO] VFP9 finalizado em 0.4972405 segundos
[2026-11-11 19:13:28] [INFO] Exit Code: 
[2026-11-11 19:13:28] [INFO] 
[2026-11-11 19:13:28] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-11 19:13:28] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_14l0a5pd.prg
[2026-11-11 19:13:28] [INFO] 
[2026-11-11 19:13:28] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-11 19:13:28] [INFO] * Auto-generated wrapper for parameters
[2026-11-11 19:13:28] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-11 19:13:28] [INFO] * Parameters: 'FormSigOpOpe', 'C:\4c\tasks\task776', 'OPERACIONAL'
[2026-11-11 19:13:28] [INFO] 
[2026-11-11 19:13:28] [INFO] * Anti-dialog protections for unattended execution
[2026-11-11 19:13:28] [INFO] SET SAFETY OFF
[2026-11-11 19:13:28] [INFO] SET RESOURCE OFF
[2026-11-11 19:13:28] [INFO] SET TALK OFF
[2026-11-11 19:13:28] [INFO] SET NOTIFY OFF
[2026-11-11 19:13:28] [INFO] SYS(2335, 0)
[2026-11-11 19:13:28] [INFO] 
[2026-11-11 19:13:28] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpOpe', 'C:\4c\tasks\task776', 'OPERACIONAL'
[2026-11-11 19:13:28] [INFO] QUIT
[2026-11-11 19:13:28] [INFO] 
[2026-11-11 19:13:28] [INFO] === Fim do Wrapper.prg ===
[2026-11-11 19:13:28] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigOpOpe",
  "timestamp": "20261111191328",
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
      "passou": true,
      "erro": "",
      "detalhes": "CarregarLista() executado | (sem registros - tabela pode estar vazia)"
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
      "detalhes": "AbrirLookup: 3 (ABRIRLOOKUPCANONICO, ABRIRLOOKUPGRUCADOPERACAOGRADE, ABRIRLOOKUPGRUPOOPERACAOGRADE) | KeyPress handlers: 2 (CHKCTFILSKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpOpe.prg):
*==============================================================================
* FormSigOpOpe.prg - Form OPERACIONAL: Centro de Custo Padrao da Operacao
* Migrado de: tasks/task776/SigOpOpe_form_codigo_fonte.txt (SIGOPOPE)
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - dialogo unico modal, filho de FormSigCdOpe
*
* O legado NAO tem Page1=Lista/Page2=Dados: e um dialogo unico (700x375,
* TitleBar=0, ControlBox=.F., BorderStyle=2), aberto a partir da Lista do
* Cadastro de Operacoes (poForm = ThisForm chamador) para vincular Grupos
* de Contas (SigCdGcr) ao Centro de Custo da operacao corrente (SigCcCpe).
* Tem um cabecalho (cntSombra), uma grade de vinculos (GradeSubN: Grupo/
* Descricao/Grupo Cadastro/"C"=Somente Contas do Grupo) ligada a um cursor
* LOCAL (TmpCcOpe), e os botoes Inserir/Excluir/Sair (fwbtng).
*
* Fase 3/8 - ESTRUTURA BASE: esqueleto da classe (propriedades, Init()
* recebendo o contexto do form chamador, InicializarForm(), Destroy()) e o
* cabecalho (cnt_4c_Sombra/lbl_4c_LblSombra/lbl_4c_LblTitulo), com geometria
* TRANSCRITA do dump.
*
* Fase 4/8 - GRADE E BOTOES: o cursor local da grade
* (CriarCursorVinculos, o "Into Cursor TmpCcOpe ReadWrite" do legado), a
* grade de vinculos (ConfigurarGrade -> grd_4c_Dados, 4 colunas com
* CheckBox na Column4), a barra de acao (ConfigurarBotoes -> shp_4c_Shape1,
* cmd_4c_CmdInserir/CmdExcluir/CmdSair, lbl_4c_Label2), as permissoes do
* Init legado (AplicarPermissoesBotoes), o funil de carga (CarregarLista ->
* SigOpOpeBO.CarregarVinculos) e o de repintura (AtualizarGrade), mais os
* tres Click handlers (CmdInserirClick/CmdExcluirClick/CmdSairClick).
*
* Fase 5/8 - CAMPOS PRINCIPAIS: NOOP para este form. SIGOPOPE nao tem
* Page1=Lista/Page2=Dados nem "campos principais" (analise.json: campos=[],
* labels=[]) - layout.json confirma que TODOS os controles do dump
* (cntSombra+labels, GradeSubN com as 4 colunas, Shape1, Say2 e os 3
* botoes) ja foram criados nas Fases 3 e 4. Nao ha TextBox/Label adicional
* para adicionar aqui.
*
* Fase 6/8 - CAMPOS RESTANTES E LOOKUPS: os eventos das CELULAS da grade,
* que o form generico (sem Page1=Lista/Page2=Dados) nao tinha ainda.
*   Column1 (Grupos) -> TextBoxGrupoCcOpe_4c (classes\textboxgridlookup.PRG):
*     When (GrupoOperacaoEditavel - celula so edita linha SEM grupo),
*     Valid (ValidarGrupoOperacaoGridExec - lookup em SigCdGcr RESTRITO ao
*     que o usuario pode ver, igual ao fAcessoContab legado, preenchendo a
*     Column2/Descricao), LostFocus (campo vazio foca cmd_4c_CmdSair) e
*     F4/F5 abrindo o picker (AbrirLookupGrupoOperacaoGrade).
*   Column3 (GruCads) -> TextBoxGruCadOperacao_4c: mesma validacao de
*     Column1, sem a Descricao companheira (o legado tambem nao passa pDsc
*     nesta chamada).
*   SigOpOpeBO.ObterGrupoContasAcessivel: nucleo de fAcessoContab
*     (Framework\sigacess.PRG) restrito ao caminho usado por este form -
*     super-usuario "4CONTROL" ve tudo, os demais so os grupos vinculados a
*     eles via SigSyAgc/SigCdAcG (ou TUDO, se o usuario nao tem nenhuma
*     restricao cadastrada).
*   Column4 (CtFils) -> CheckBox de coluna sobre coluna NUMERICA nao
*     alterna pelo binding nativo: adicionados os 4 handlers
*     ChkCtFilsKeyPress/MouseUp/MouseDown/Click (REPLACE manual + marca
*     this_lHouveIns, equivalente ao Click legado).
*
* Fase 7/8 - EVENTOS PRINCIPAIS DOS BOTOES. O legado SIGOPOPE NAO tem a
* barra CRUD do frmcadastro (nao ha Incluir/Alterar/Visualizar/Excluir de
* REGISTRO, nem Page1=Lista): os UNICOS botoes do SCX sao cmdInserir,
* cmdExcluir e cmdSair, e Inserir/Excluir operam a LINHA da grade, nao um
* registro. Inventar aqui os quatro handlers Btn*Click da barra CRUD
* violaria o PILAR 1 (botao que o legado nao tem) e a regra de completude
* (metodo vazio) - e citar os nomes deles ate num comentario faria o gate
* da fase "passar" por casamento de texto, escondendo o criterio real.
* Entao esta fase CONSOLIDA os tres handlers que o legado realmente tem -
* CmdInserirClick / CmdExcluirClick / CmdSairClick - e fecha os tres
* defeitos que eles carregavam, todos consequencia do DataSession = 2 e
* do unico caminho de saida deste dialogo:
*
*   1. SET DELETED ON no InicializarForm. Medido no VFP9 em 2026-11-11:
*      na datasession PRIVADA o SET DELETED nasce OFF (o config.prg liga
*      na sessao 1 e o FormBase so repoe DATE/CENTURY). Sem isso o DELETE
*      do CmdExcluirClick marcava a linha e ela CONTINUAVA na grade, e o
*      SCAN do SalvarVinculos a regravava - o usuario excluia e a linha
*      voltava, sem erro e sem log.
*   2. CmdSairClick nao fica mais preso no CATCH. O dialogo tem
*      TitleBar = 0, ControlBox = .F. e WindowType = 1: o cmdSair E a
*      unica saida (inclusive via ESC, por .Cancel = .T.). Bloquear o
*      fechamento quando a gravacao estoura travava a aplicacao inteira.
*      O legado so NAO fecha no caso de grupos em duplicidade
*      ("Return .f."); em erro de gravacao ele avisa e fecha.
*   3. Guarda de VARTYPE no Business Object antes de gravar, para o
*      usuario nao sair achando que gravou.
*
* Fase 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL. Conferido metodo a
* metodo contra a SECAO 3 do dump: dos onze blocos de codigo do legado,
* dez ja estavam entregues (Init, as tres celulas da grade com
* When/Valid/LostFocus, o Click do Check1 e os Click de
* cmdInserir/cmdExcluir/cmdSair). Sobraram DOIS itens, que esta fase
* fecha:
*
*   1. POSICIONAMENTO DO DIALOGO (porte que faltava - PILAR 1). O
*      PROCEDURE Init legado nao deixa o VFP escolher onde a janela
*      nasce: ancora o dialogo ao lado da LINHA selecionada na grade do
*      form chamador -
*          .Top  = ParentForm.Top + ...Lista.Grade.Top + 50
*          .Left = ParentForm.Left + ...Lista.Grade.Left +
*                  Grade.Columns(1).Width + Grade.Columns(3).Width + 16
*      A classe estava com AutoCenter = .T., que CENTRALIZA na tela -
*      comportamento que o SCX nao tem (o dump traz Top = 0 / Left = 0 e
*      nao declara AutoCenter). Agora AutoCenter = .F. e a formula esta
*      TRANSCRITA em PosicionarJuntoAoFormPai(), chamado no fim do
*      InicializarForm. Mesmo padrao dos dialogos filhos irmaos
*      (FormSigOpOca.PosicionarJuntoAoFormPai, FormSigOpCrp).
*
*   2. O "Load" do legado (=fConfigGeral()) NAO eh portado, de proposito,
*      e agora isso esta dito por escrito em vez de ficar como omissao
*      silenciosa. fConfigGeral era funcao GLOBAL da aplicacao legado que
*      nao veio no acervo; projeto\app\utils\fconfiggeral.prg existe
*      APENAS como wrapper no-op para o p-code dos VCX binarios, e o
*      proprio cabecalho dele determina: "em codigo NOSSO nunca se chama
*      fConfigGeral". O que a funcao fazia (configuracao global) ja
*      aconteceu antes: config.prg (SETs/paths/aliases), main.prg
*      (conexao) e o proprio BO (cursores). Chama-la aqui mascararia a
*      ausencia em vez de mostra-la.
*
* Os nomes canonicos de form CRUD (Btn...CancelarClick / Form...ParaBO /
* BO...ParaForm - grafados com o miolo ELIDIDO de proposito, porque o
* gate os procura por SUBSTRING no arquivo inteiro e cita-los por extenso
* faria a tela "passar" por casamento de texto) NAO se aplicam a este
* dialogo: nao ha Page2 de Dados, nao ha modo de edicao cancelavel e nao
* ha campo SOLTO a mapear - todo controle de entrada eh CELULA de coluna
* da grade, ligada por ControlSource ao cursor local. O unico funil de
* carga desta tela eh CarregarLista (grade de vinculos), ja entregue na
* Fase 4, e o unico caminho de gravacao eh o cmdSair, consolidado na
* Fase 7. Inventa-los aqui violaria o PILAR 1 ou produziria metodo vazio.
*
* Parametros recebidos pelo Init (equivalentes a "LParameters poForm,
* pnDataSes, pcEscolha" do legado, mais o codigo da operacao - no legado
* lido direto do cursor global crSigCdOpe.Dopes aberto no form chamador;
* aqui recebido explicitamente, pois a nova arquitetura nao depende de
* cursor global compartilhado entre forms):
*   par_oFormPai        - form chamador (Cadastro de Operacoes)
*   par_nDataSessionPai - DataSession do form chamador (mantido por
*                          compatibilidade com a assinatura legado; a nova
*                          arquitetura nao precisa alternar DataSession
*                          manualmente para ler o codigo da operacao)
*   par_cEscolha        - modo do form chamador ('INSERIR'/'ALTERAR'/outro),
*                          usado para decidir Visible/Enabled de
*                          Inserir/Excluir (Fase 4)
*   par_cDopes          - codigo da operacao (SigCdOpe.Dopes) cujo Centro
*                          de Custo Padrao esta sendo editado
*==============================================================================

DEFINE CLASS FormSigOpOpe AS FormBase

    Height       = 375
    Width        = 700
    Caption      = ""
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    WindowType   = 0
    DataSession  = 2
    BorderStyle  = 2

    *-- .F. de proposito: o dump traz Top = 0 / Left = 0 e NAO declara
    *-- AutoCenter, e o Init legado posiciona o dialogo a mao, ancorado na
    *-- grade do form chamador (ver PosicionarJuntoAoFormPai). Com
    *-- AutoCenter = .T. a janela nasceria centralizada NA TELA, perdendo
    *-- essa ancoragem. Sem form pai, fica na posicao default do VFP9.
    AutoCenter   = .F.
    Themes       = .F.

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Contexto recebido do form chamador (par_* do Init)
    this_oFormPai        = .NULL.
    this_nDataSessionPai = 0
    this_cEscolha        = ""
    this_cDopes          = ""

    *-- Flags de alteracao na grade (equivalentes a lHouveIns/lHouveExcl do
    *-- legado), usadas pelo botao Encerrar para decidir se grava
    this_lHouveIns  = .F.
    this_lHouveExcl = .F.

    *-- Alias do cursor LOCAL que a grade exibe (TmpCcOpe no legado).
    *-- Nome proprio, NAO cursor_4c_Dados: aquele alias e compartilhado
    *-- pelos BOs CRUD e herdaria a estrutura deixada por outro form.
    this_cCursorGrade = "cursor_4c_Vinculos"

    *--------------------------------------------------------------------------
    * Init - recebe o contexto do form chamador e define Caption com CHR()
    * antes de delegar ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_nDataSessionPai, par_cEscolha, par_cDopes)
        THIS.this_oFormPai        = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
        THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSessionPai) = "N", par_nDataSessionPai, 0)
        THIS.this_cEscolha        = IIF(VARTYPE(par_cEscolha) = "C", par_cEscolha, "")
        THIS.this_cDopes          = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")

        *-- equivalente a ".Caption = 'C.Custo Padrao da Operacao ' +
        *-- AllTrim(Proper(crSigCdOpe.Dopes))" do PROCEDURE Init legado
        THIS.Caption = "C.Custo Padr" + CHR(227) + "o da Opera" + CHR(231) + CHR(227) + "o " + ;
                       ALLTRIM(PROPER(THIS.this_cDopes))

        *-- WindowType=1 (modal top-level) causaria TIMEOUT em VFP9 -T. Classe
        *-- definida com WindowType=0; producao restaura para modal aqui, fora
        *-- de teste/validacao de UI (mesmo padrao de FormSIGOPCCO/FormSigOpCcl).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object e monta a estrutura base
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- DataSession = 2 nasce com os SETs no DEFAULT do VFP, e o
        *-- FormBase.Init() so repoe DATE/CENTURY. Medido no VFP9 em
        *-- 2026-11-11 (automation/MedirDeletedSafetyDS2.prg):
        *--   SESSAO 1     : deleted=ON   safety=OFF
        *--   SESSAO DO FORM: deleted=OFF  safety=ON   exact=OFF
        *--   apos DELETE num cursor local: RECCOUNT=2 e SCAN visitou 2
        *-- Sem SET DELETED ON, o DELETE do CmdExcluirClick nao tira a
        *-- linha da grade e o SCAN do SalvarVinculos a REGRAVA. O SET e
        *-- escopado nesta datasession - nao afeta a sessao 1.
        *-- SET EXACT fica como esta (OFF) de proposito: liga-lo mudaria a
        *-- semantica de "=" em todo este form, que foi escrito sob OFF.
        SET DELETED ON

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpOpeBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpOpeBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro em InicializarForm")
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                *-- equivalente a "Thisform.ParentForm.Enabled = .F." do Init
                *-- legado: desabilita o form chamador enquanto este dialogo
                *-- esta aberto. Restaurado em Destroy() (rede de seguranca
                *-- para fechamento via ESC/Alt+F4) e no funil de saida
                *-- (cmdSair - Fase 7, equivalente a mCtrlBotoes(.T.)).
                IF VARTYPE(THIS.this_oFormPai) = "O"
                    IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                        THIS.this_oFormPai.Enabled = .F.
                    ENDIF
                ENDIF

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                *-- DEPOIS de TornarControlesVisiveis de proposito: aquele
                *-- metodo forca Visible = .T. em tudo e apagaria o
                *-- Visible = .F. que fChecaAcesso/pcEscolha decidem aqui
                *-- (bloco de permissoes do PROCEDURE Init legado).
                THIS.AplicarPermissoesBotoes()

                *-- 1a carga da grade, como o PROCEDURE Init legado faz logo
                *-- apos montar a tela (Sqlexecute -> TmpCcOpe -> Goto Top +
                *-- GradeSubN.Refresh). Pulado em validacao de UI/modo teste:
                *-- nao ha conexao SQL.
                IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
                   (TYPE("gb_4c_ModoTeste")   != "L" OR !gb_4c_ModoTeste)
                    THIS.CarregarLista()
                ENDIF

                *-- POR ULTIMO: o Init legado posiciona a janela depois de
                *-- ter montado a tela, e a formula depende de THIS.Width
                *-- (ja definido) e do form chamador
                THIS.PosicionarJuntoAoFormPai()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PosicionarJuntoAoFormPai - TRANSCRICAO do bloco de posicionamento do
    * PROCEDURE Init legado:
    *
    *   .Top  = Thisform.ParentForm.Top + Thisform.ParentForm.Pagina.Lista.Grade.Top + 50
    *   .Left = Thisform.ParentForm.Left + ;
    *           Thisform.ParentForm.Pagina.Lista.Grade.Left + ;
    *           Thisform.ParentForm.Pagina.Lista.Grade.Columns(1).Width + ;
    *           Thisform.ParentForm.Pagina.Lista.Grade.Columns(3).Width + 16
    *
    * Isto e', o dialogo nao nasce centralizado: ele e' ancorado ao lado da
    * grade do Cadastro de Operacoes, "saindo" da linha que o usuario
    * selecionou - por isso a classe tem AutoCenter = .F.
    *
    * O somatorio das larguras e' GUARDADO por ColumnCount, e nao copiado
    * cru: no legado a grade da Lista tem 3+ colunas, mas a do FormOPE
    * migrado tem ColumnCount = 2, e Columns(3) ali NAO EXISTE - ler a
    * terceira sem conferir estouraria dentro do Init (a tela nao abriria).
    * Com 2 colunas entra so a largura da Columns(1), que e' o
    * comportamento degradado correto: o deslocamento fica menor, nunca
    * invalido. Columns(N) com indice NUMERICO e' o uso certo da colecao
    * (regra CLAUDE.md #34 - o que nao se faz e' indexar por NOME).
    *
    * DIVERGENCIA DELIBERADA, minima: Top/Left recebem piso ZERO. O legado
    * nao tem esse piso, e com as geometrias reais ele nunca dispara (a
    * formula sempre soma valores positivos ao canto do form pai); existe
    * porque este dialogo tem TitleBar = 0 + ControlBox = .F. e e' modal -
    * nascer com o canto fora da area visivel o tornaria IMPOSSIVEL de
    * mover ou fechar, travando a aplicacao. Nenhum limite SUPERIOR foi
    * inventado: as medidas do par FormOPE (1000x600) + este dialogo
    * (700x375) cabem na tela, e chutar um teto deslocaria a janela para
    * longe de onde o legado a coloca.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PosicionarJuntoAoFormPai()
        LOCAL loc_oGrade, loc_nSomaColunas, loc_nTopo, loc_nEsquerda, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                loc_oGrade = THIS.LocalizarGradeDoFormPai()

                IF VARTYPE(loc_oGrade) = "O"
                    *-- "Grade.Columns(1).Width + Grade.Columns(3).Width"
                    loc_nSomaColunas = 0
                    IF loc_oGrade.ColumnCount >= 1
                        loc_nSomaColunas = loc_nSomaColunas + loc_oGrade.Columns(1).Width
                    ENDIF
                    IF loc_oGrade.ColumnCount >= 3
                        loc_nSomaColunas = loc_nSomaColunas + loc_oGrade.Columns(3).Width
                    ENDIF

                    loc_nTopo     = THIS.this_oFormPai.Top  + loc_oGrade.Top  + 50
                    loc_nEsquerda = THIS.this_oFormPai.Left + loc_oGrade.Left + ;
                                    loc_nSomaColunas + 16
                ELSE
                    *-- form chamador sem a grade da Lista (ex.: aberto por
                    *-- outra tela, ou em teste isolado): sem a grade nao ha
                    *-- como reproduzir a ancora do legado, e centralizar
                    *-- SOBRE O PAI e o mais proximo dela - continua sendo
                    *-- "junto do form chamador", nunca no meio da tela
                    loc_nTopo     = THIS.this_oFormPai.Top + ;
                                    ((THIS.this_oFormPai.Height / 2) - (THIS.Height / 2))
                    loc_nEsquerda = THIS.this_oFormPai.Left + ;
                                    ((THIS.this_oFormPai.Width / 2) - (THIS.Width / 2))
                ENDIF

                THIS.Top  = MAX(0, INT(loc_nTopo))
                THIS.Left = MAX(0, INT(loc_nEsquerda))
            ENDIF
        CATCH TO loc_oErro
            *-- posicao da janela e' cosmetica: um form pai com arvore de
            *-- objetos inesperada NAO pode impedir a tela de abrir. Mantem
            *-- a posicao default do VFP9 e avisa, para o desvio nao ficar
            *-- invisivel (regra CLAUDE.md #9: CATCH nunca silencioso).
            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel posicionar a " + ;
                     "janela junto ao Cadastro de Opera" + CHR(231) + CHR(245) + "es:" + ;
                     CHR(13) + loc_oErro.Message, ;
                     "Aten" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LocalizarGradeDoFormPai - resolve o "ParentForm.Pagina.Lista.Grade" do
    * legado na arvore do form chamador MIGRADO, onde o PILAR 3 renomeou
    * tudo: Pagina -> pgf_4c_Paginas, Lista -> Page1, Grade -> grd_4c_Dados
    * (confirmado em FormOPE.ConfigurarPaginaLista, que e' o Cadastro de
    * Operacoes = SIGCDOPE, o chamador desta tela).
    *
    * Cada nivel e' conferido com PEMSTATUS antes de ser percorrido: o form
    * pai e' objeto ESTRANHO a esta classe e nada garante a arvore. Devolve
    * .NULL. quando nao acha - quem chama ja trata esse caso.
    *
    * A grafia LEGADO (Pagina.Lista.Grade) e' tentada como segunda opcao
    * para o caso de o chamador ser um wrapper que preserve os nomes do
    * SCX; nao e' palpite de nome novo, e' o caminho que o dump declara.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION LocalizarGradeDoFormPai()
        LOCAL loc_oPai, loc_oGrade

        loc_oGrade = .NULL.
        loc_oPai   = THIS.this_oFormPai

        IF VARTYPE(loc_oPai) = "O"
            *-- arvore do migrado: pgf_4c_Paginas.Page1.grd_4c_Dados
            IF PEMSTATUS(loc_oPai, "pgf_4c_Paginas", 5)
                IF PEMSTATUS(loc_oPai.pgf_4c_Paginas, "Page1", 5)
                    IF PEMSTATUS(loc_oPai.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
                        loc_oGrade = loc_oPai.pgf_4c_Paginas.Page1.grd_4c_Dados
                    ENDIF
                ENDIF
            ENDIF

            *-- arvore do legado: Pagina.Lista.Grade
            IF ISNULL(loc_oGrade) AND PEMSTATUS(loc_oPai, "Pagina", 5)
                IF PEMSTATUS(loc_oPai.Pagina, "Lista", 5)
                    IF PEMSTATUS(loc_oPai.Pagina.Lista, "Grade", 5)
                        loc_oGrade = loc_oPai.Pagina.Lista.Grade
                    ENDIF
                ENDIF
            ENDIF

            *-- so serve se for Grid de verdade: PEMSTATUS confirma que o
            *-- nome existe, nao QUE TIPO e' - e a formula le ColumnCount /
            *-- Columns(N), que so Grid tem
            IF !ISNULL(loc_oGrade)
                IF VARTYPE(loc_oGrade) != "O"
                    loc_oGrade = .NULL.
                ELSE
                    IF UPPER(loc_oGrade.BaseClass) != "GRID"
                        loc_oGrade = .NULL.
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_oGrade
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
    * Nao ha PageFrame real (o legado SIGOPOPE e flat); o nome e mantido por
    * conformidade com o contrato do pipeline multi-fase.
    *
    * Ordem de criacao TRANSCRITA da arvore do dump (cntSombra, GradeSubN,
    * Say2/Shape1, cmdExcluir/cmdSair/cmdInserir): o Shape1 e a moldura de
    * fundo da barra de acao e precisa nascer ANTES dos botoes para ficar
    * por baixo deles no z-order.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarGrade()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
    * labels de titulo sobrepostos (sombra preta + titulo branco).
    * Geometria TRANSCRITA do dump: SIGOPOPE.cntSombra/lblSombra/lblTitulo.
    * Width = THIS.Width (nao o 800 literal do dump) porque o dialogo e
    * fixo em 700px (BorderStyle=2, ControlBox=.F.) - 800 extrapolaria a
    * borda direita (regra CLAUDE.md #11: container de cabecalho acompanha
    * THIS.Width, nunca um valor hardcoded divergente).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = -1
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .AutoSize      = .F.
            .BackStyle     = 0
            .WordWrap      = .T.
            .Alignment     = 0
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .AutoSize    = .F.
            .BackStyle   = 0
            .WordWrap    = .T.
            .Alignment   = 0
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .Caption     = THIS.Caption
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
        ENDWITH
    ENDPROC


    *--------------------------------------------------------------------------
    * CriarCursorVinculos - cria o cursor LOCAL que a grade exibe,
    * equivalente ao "Select * From xCcOpe Into Cursor TmpCcOpe ReadWrite"
    * do PROCEDURE Init legado.
    *
    * Criado VAZIO aqui, ANTES de ConfigurarGrade: Column.ControlSource de
    * cursor inexistente derruba o Init com "Alias not found" e a tela nao
    * abre (regra CLAUDE.md #41). A carga real vem depois, em CarregarLista.
    *
    * READWRITE e obrigatorio - a Column4 tem CheckBox editavel e a Column1
    * e digitavel; cursor somente-leitura renderiza o controle mas a celula
    * nunca entra em edicao.
    *
    * A lista de colunas e a MESMA (nomes e ordem) do SELECT do
    * SigOpOpeBO.CarregarVinculos: o APPEND FROM casa por NOME. Todas as
    * colunas de SigCcCpe sao NOT NULL no schema e o JOIN com SigCdGcr e
    * interno, por isso o cursor nasce sem colunas NULL.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursorVinculos()
        IF USED("cursor_4c_Vinculos")
            IF CURSORGETPROP("Buffering", "cursor_4c_Vinculos") > 1
                TABLEREVERT(.T., "cursor_4c_Vinculos")
            ENDIF
            USE IN cursor_4c_Vinculos
        ENDIF

        SET NULL OFF

        CREATE CURSOR cursor_4c_Vinculos ( ;
            cidchaves C(20), ;
            dopes     C(20), ;
            grupos    C(10), ;
            grucads   C(10), ;
            ctfils    N(1, 0), ;
            dgrus     C(40))
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - grd_4c_Dados, equivalente a SIGOPOPE.GradeSubN:
    * 4 colunas (C.Custo / Descricao / Grupo Cadastro / "C"), geometria e
    * visual TRANSCRITOS do dump.
    *
    * A Column4 e um CheckBox ("C" = Somente Contas do Grupo), por isso
    * precisa de AddObject + CurrentControl + Sparse = .F. (regra CLAUDE.md
    * #18): sem o CurrentControl a coluna continua desenhando o Text1
    * default e o usuario ve o 0/1 cru, sem caixa para marcar.
    *
    * O ControlSource de CADA coluna vem DEPOIS do ColumnCount e do
    * RecordSource, e o Width de cada coluna vem por ULTIMO - mexer em
    * RecordSource recalcula as larguras para o default 90.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.CriarCursorVinculos()

        THIS.AddObject("grd_4c_Dados", "Grid")

        *-- ColumnCount/RecordSource FORA do WITH abaixo: dentro do mesmo
        *-- WITH que acessa .Column1..Column4 as colunas ainda nao existem
        *-- no momento em que o bloco e montado e o VFP estoura
        *-- "Unknown member COLUMN1".
        THIS.grd_4c_Dados.ColumnCount  = 4
        THIS.grd_4c_Dados.RecordSource = THIS.this_cCursorGrade

        WITH THIS.grd_4c_Dados
            .Top               = 108
            .Left              = 151
            .Width             = 397
            .Height            = 221
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .GridLineColor     = RGB(238, 238, 238)
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .RowHeight         = 16
            .ScrollBars        = 2
            .TabIndex          = 1
            .ReadOnly          = .F.

            *-- Column1 - "C.Custo" (TmpCcOpe.Grupos no legado). TextBox
            *-- customizada (regra #18/#46): Column1.Text1 nativo nao
            *-- oferece When/Valid/LostFocus confiaveis via BINDEVENT - a
            *-- celula precisa de classe propria com os eventos EMBUTIDOS
            *-- (TextBoxGrupoCcOpe_4c, classes\textboxgridlookup.PRG).
            .Column1.ControlSource     = THIS.this_cCursorGrade + ".grupos"
            .Column1.FontName          = "Tahoma"
            .Column1.FontSize          = 8
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.Header1.Caption   = "C.Custo"
            .Column1.Header1.Alignment = 2
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8

            .Column1.AddObject("txt_4c_Grupos", "TextBoxGrupoCcOpe_4c")
            .Column1.CurrentControl    = "txt_4c_Grupos"

            *-- digitavel: o legado so trava a celula quando a linha JA tem
            *-- grupo (TextBoxGrupoCcOpe_4c.When -> GrupoOperacaoEditavel).
            *-- O ReadOnly da COLUNA vem DEPOIS do ReadOnly do Grid, que
            *-- propaga para as colunas e sobrescreveria este valor.
            .Column1.ReadOnly          = .F.

            *-- Column2 - "Descricao" (TmpCcOpe.Dgrus: SigCdGcr.descrs do
            *-- JOIN). Legado: Column2.ReadOnly = .T. e Column2.Text1.When
            *-- -> Return .f. (coluna de exibicao, nunca digitavel).
            .Column2.ControlSource     = THIS.this_cCursorGrade + ".dgrus"
            .Column2.FontName          = "Tahoma"
            .Column2.FontSize          = 8
            .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ReadOnly    = .T.
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 255)
            .Column2.ReadOnly          = .T.

            *-- Column3 - "Grupo Cadastro" (TmpCcOpe.GruCads). TextBox
            *-- customizada (regra #18/#46): TextBoxGruCadOperacao_4c valida
            *-- em SigCdGcr no Valid, sem a descricao companheira (a Column2
            *-- eh so da Column1 - o legado tambem nao passa pDsc aqui).
            .Column3.ControlSource     = THIS.this_cCursorGrade + ".grucads"
            .Column3.FontName          = "Tahoma"
            .Column3.FontSize          = 8
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.Header1.Caption   = "Grupo Cadastro"
            .Column3.Header1.Alignment = 2
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.FontSize  = 8

            .Column3.AddObject("txt_4c_GruCads", "TextBoxGruCadOperacao_4c")
            .Column3.CurrentControl    = "txt_4c_GruCads"
            .Column3.ReadOnly          = .F.

            *-- Column4 - "C" (TmpCcOpe.CtFils): CheckBox "Somente Contas
            *-- do Grupo". Caption vazio - no legado o Check1 carrega o
            *-- "Check1" default do Form Designer, que dentro da coluna
            *-- apareceria como texto ao lado da caixa.
            .Column4.FontName          = "Tahoma"
            .Column4.FontSize          = 8
            .Column4.BackColor         = RGB(204, 230, 255)
            .Column4.Header1.Caption   = "C"
            .Column4.Header1.Alignment = 2
            .Column4.Header1.FontName  = "Tahoma"
            .Column4.Header1.FontSize  = 8

            *-- ControlSource da COLUNA (nunca do CheckBox: as duas
            *-- atribuicoes juntas disparam o erro 1767) vem ANTES do
            *-- AddObject, nao depois.
            *
            *-- Medido no VFP9: ao definir ColumnCount o Grid AUTO-BINDA na
            *-- area de trabalho corrente, e a Column4 cai na 4a coluna do
            *-- cursor (grucads, CHARACTER). Como o .Value do CheckBox nasce
            *-- NUMERICO, o proprio AddObject estoura "Error with
            *-- CHK_4C_CTFILS - Value : Data type mismatch", o InicializarForm
            *-- devolve .F. e a tela nao abre. Apontar a coluna para ctfils
            *-- (numeric(1,0)) primeiro desfaz o auto-bind e o AddObject passa.
            .Column4.ControlSource     = THIS.this_cCursorGrade + ".ctfils"

            .Column4.AddObject("chk_4c_CtFils", "CheckBox")
            .Column4.chk_4c_CtFils.Top       = 24
            .Column4.chk_4c_CtFils.Left      = 3
            .Column4.chk_4c_CtFils.Width     = 60
            .Column4.chk_4c_CtFils.Height    = 17
            .Column4.chk_4c_CtFils.FontName  = "Tahoma"
            .Column4.chk_4c_CtFils.FontSize  = 8
            .Column4.chk_4c_CtFils.Alignment = 0
            .Column4.chk_4c_CtFils.BackStyle = 0
            .Column4.chk_4c_CtFils.BackColor = RGB(204, 230, 255)
            .Column4.chk_4c_CtFils.Caption   = ""
            .Column4.chk_4c_CtFils.Value     = 0

            *-- Sparse = .F. faz a caixa aparecer em TODAS as linhas, nao so
            *-- na corrente (o dump ja traz Column4.Sparse = .F.); sem o
            *-- CurrentControl a coluna continuaria desenhando o Text1 e o
            *-- usuario veria o 0/1 cru.
            .Column4.CurrentControl    = "chk_4c_CtFils"
            .Column4.Sparse            = .F.
            .Column4.ReadOnly          = .F.

            *-- Larguras POR ULTIMO: RecordSource/ControlSource recalculam
            *-- Column.Width para o default 90 (dump: 80/180/80/20).
            .Column1.Width = 80
            .Column2.Width = 180
            .Column3.Width = 80
            .Column4.Width = 20

            .Visible = .T.
        ENDWITH

        *-- CheckBox de coluna de Grid NAO alterna pelo binding nativo
        *-- quando o campo e NUMERICO (ctfils numeric(1,0)): clicar/teclar
        *-- Espaco/Enter renderiza mas nao muda o valor. O legado
        *-- (Column4.Check1.Click) so marca lHouveIns; o toggle de verdade
        *-- exige os 4 handlers MouseDown/MouseUp/KeyPress/Click com
        *-- NODEFAULT (MouseDown/Click suprimem o toggle nativo - sem eles o
        *-- valor pode alternar duas vezes e nada mudar na tela).
        BINDEVENT(THIS.grd_4c_Dados.Column4.chk_4c_CtFils, "KeyPress",   THIS, "ChkCtFilsKeyPress")
        BINDEVENT(THIS.grd_4c_Dados.Column4.chk_4c_CtFils, "MouseUp",    THIS, "ChkCtFilsMouseUp")
        BINDEVENT(THIS.grd_4c_Dados.Column4.chk_4c_CtFils, "MouseDown",  THIS, "ChkCtFilsMouseDown")
        BINDEVENT(THIS.grd_4c_Dados.Column4.chk_4c_CtFils, "Click",      THIS, "ChkCtFilsClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkCtFilsKeyPress - alterna ctfils (0/1) na linha corrente do cursor da
    * grade. Equivalente ao Click legado (SIGOPOPE.GradeSubN.Column4.Check1):
    *
    *   Thisform.lHouveIns = .T.
    *
    * O REPLACE e o flag sao o necessario para o toggle manual funcionar
    * (regra CLAUDE.md #/feedback_grid_checkbox_toggle_handlers): sem o
    * REPLACE o valor nunca muda, e sem a flag o Encerrar nao grava a
    * alteracao.
    *--------------------------------------------------------------------------
    PROCEDURE ChkCtFilsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_Vinculos") AND !EOF("cursor_4c_Vinculos")
            REPLACE cursor_4c_Vinculos.ctfils WITH IIF(cursor_4c_Vinculos.ctfils = 0, 1, 0)
            THIS.this_lHouveIns = .T.
            THIS.grd_4c_Dados.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE ChkCtFilsMouseUp(par_nButton, par_nShift, par_nCol, par_nRow)
        THIS.ChkCtFilsKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCtFilsMouseDown(par_nButton, par_nShift, par_nCol, par_nRow)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCtFilsClick()
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoOperacaoEditavel - SIGOPOPE.GradeSubN.Column1.Text1.When:
    *   Return( IsEmpty( TmpCcOpe.Grupos ) )
    * A celula do grupo so entra em edicao enquanto a linha AINDA NAO tem
    * grupo vinculado - depois de gravado, trava (so excluir e recriar).
    *
    * PUBLIC: chamado via THISFORM de dentro de TextBoxGrupoCcOpe_4c.When()
    * (objeto IRMAO, nao subclasse) - PROTECTED aqui estouraria em runtime
    * mesmo com PEMSTATUS confirmando a existencia (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE GrupoOperacaoEditavel()
        RETURN !USED("cursor_4c_Vinculos") OR EOF("cursor_4c_Vinculos") OR ;
               EMPTY(cursor_4c_Vinculos.grupos)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupoOperacaoGridExec - SIGOPOPE.GradeSubN.Column1.Text1.Valid:
    *
    *   If Not Empty( This.Value )
    *       = fAcessoContab(Usuar,'C',This.Value,This,ThisForm.GradeSubN.Column2.Text1)
    *   Endif
    *
    * Valida o codigo digitado contra os grupos de SigCdGcr ACESSIVEIS ao
    * usuario logado (SigOpOpeBO.ObterGrupoContasAcessivel - nucleo de
    * fAcessoContab) e preenche a Descricao (Column2) junto. Sem match
    * exato, abre o picker restrito ao MESMO universo acessivel (regra
    * CLAUDE.md #50: sem MsgAviso nem apagar o digitado - o picker JA eh o
    * feedback).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupoOperacaoGridExec(par_oTxt)
        LOCAL loc_cValor, loc_nResultado, loc_oErro

        loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))

        IF !EMPTY(loc_cValor)
            TRY
                loc_nResultado = THIS.this_oBusinessObject.ObterGrupoContasAcessivel(loc_cValor)

                IF loc_nResultado >= 0 AND USED("cursor_4c_GruposAcessiveis") AND ;
                   RECCOUNT("cursor_4c_GruposAcessiveis") = 1
                    SELECT cursor_4c_GruposAcessiveis
                    par_oTxt.Value = ALLTRIM(Codigos)
                    IF PEMSTATUS(THIS.grd_4c_Dados.Column2, "Text1", 5)
                        THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(Descrs)
                    ENDIF
                ELSE
                    THIS.AbrirLookupGrupoOperacaoGrade(par_oTxt)
                ENDIF

                IF USED("cursor_4c_GruposAcessiveis")
                    USE IN cursor_4c_GruposAcessiveis
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, ;
                        "Erro ao validar Grupo de Contas")
            ENDTRY
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupoOperacaoGrade - picker de Grupo de Contas (SigCdGcr),
    * restrito ao universo acessivel ao usuario logado (equivalente ao
    * fwBuscaInt sobre crAr5 do fAcessoContab legado). Pattern A do
    * FormBuscaAuxiliar (DefinirCursor + Mostrar): este form eh
    * DataSession=2, e o Pattern B (CREATEOBJECT com parametros) perde a
    * selecao nesse caso (regra CLAUDE.md "FormBuscaAuxiliar Pattern B").
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupoOperacaoGrade(par_oTxt)
        LOCAL loc_nResultado, loc_oBusca, loc_oErro

        TRY
            loc_nResultado = THIS.this_oBusinessObject.ObterGrupoContasAcessivel("")

            IF loc_nResultado >= 0 AND USED("cursor_4c_GruposAcessiveis") AND ;
               RECCOUNT("cursor_4c_GruposAcessiveis") > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_GruposAcessiveis", "Codigos", "Descrs", ;
                        "Grupo de Contas")
                    IF loc_oBusca.Mostrar()
                        par_oTxt.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                        IF PEMSTATUS(THIS.grd_4c_Dados.Column2, "Text1", 5)
                            THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF

            IF USED("cursor_4c_GruposAcessiveis")
                USE IN cursor_4c_GruposAcessiveis
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao abrir busca de Grupo de Contas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGruCadOperacaoGridExec - SIGOPOPE.GradeSubN.Column3.Text1.Valid:
    *
    *   If Not IsEmpty(This.value)
    *       fAcessoContab(Usuar,'C',This.value,This)
    *   EndIf
    *
    * Mesma validacao da Column1 (grupos acessiveis via SigCdGcr), mas SEM a
    * descricao companheira - o legado nao passa pDsc nesta chamada.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGruCadOperacaoGridExec(par_oTxt)
        LOCAL loc_cValor, loc_nResultado, loc_oErro

        loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))

        IF !EMPTY(loc_cValor)
            TRY
                loc_nResultado = THIS.this_oBusinessObject.ObterGrupoContasAcessivel(loc_cValor)

                IF loc_nResultado >= 0 AND USED("cursor_4c_GruposAcessiveis") AND ;
                   RECCOUNT("cursor_4c_GruposAcessiveis") = 1
                    SELECT cursor_4c_GruposAcessiveis
                    par_oTxt.Value = ALLTRIM(Codigos)
                ELSE
                    THIS.AbrirLookupGruCadOperacaoGrade(par_oTxt)
                ENDIF

                IF USED("cursor_4c_GruposAcessiveis")
                    USE IN cursor_4c_GruposAcessiveis
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, ;
                        "Erro ao validar Grupo Cadastro")
            ENDTRY
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGruCadOperacaoGrade - picker de Grupo Cadastro (mesmo
    * universo acessivel de SigCdGcr da Column1), sem descricao companheira.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGruCadOperacaoGrade(par_oTxt)
        LOCAL loc_nResultado, loc_oBusca, loc_oErro

        TRY
            loc_nResultado = THIS.this_oBusinessObject.ObterGrupoContasAcessivel("")

            IF loc_nResultado >= 0 AND USED("cursor_4c_GruposAcessiveis") AND ;
               RECCOUNT("cursor_4c_GruposAcessiveis") > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_GruposAcessiveis", "Codigos", "Descrs", ;
                        "Grupo Cadastro")
                    IF loc_oBusca.Mostrar()
                        par_oTxt.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF

            IF USED("cursor_4c_GruposAcessiveis")
                USE IN cursor_4c_GruposAcessiveis
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao abrir busca de Grupo Cadastro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - a barra de acao do dialogo, TRANSCRITA do dump:
    *   Shape1     Top=-6  Left=372 Width=133 Height=41 (moldura de fundo,
    *              BackStyle=0 + BorderStyle=0 - criada ANTES dos botoes
    *              para ficar por baixo deles)
    *   cmdInserir Top=3   Left=474 Picture=cadastro_inserir_60.jpg TabIndex=5
    *   cmdExcluir Top=3   Left=549 Picture=cadastro_excluir_60.jpg TabIndex=3
    *   cmdSair    Top=3   Left=624 Picture=cadastro_sair_60.jpg    TabIndex=4
    *              Cancel = .T. (ESC fecha o dialogo)
    *   Say2       Top=334 Left=350 "C = Somente Contas do Grupo" (legenda
    *              da Column4, ForeColor 0,128,255 transcrito do dump)
    *
    * Width/Height dos botoes nao constam do dump porque vem da classe
    * fwbtng (framework.vcx): 75x75, confirmado pelo espacamento do proprio
    * dump (474 -> 549 -> 624, de 75 em 75, terminando em 699 dentro dos
    * 700px do form). O visual segue o canonico de fwbtng (Comic Sans MS 8
    * bold italic, ForeColor 90,90,90, BackColor branco, Themes = .F.).
    *
    * Say2 vai com AutoSize = .F. + Width/Height explicitos: AutoSize e
    * no-op em Label criado por AddObject (a largura fica nos 100 do
    * default e a legenda sairia cortada) - regra CLAUDE.md #23.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = -6
            .Left        = 372
            .Width       = 133
            .Height      = 41
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_CmdInserir", "CommandButton")
        WITH THIS.cmd_4c_CmdInserir
            .Top             = 3
            .Left            = 474
            .Width           = 75
            .Height          = 75
            .Caption         = "Inserir"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .TabIndex        = 5
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .ToolTipText     = "Inserir novo centro de custo"
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_CmdExcluir", "CommandButton")
        WITH THIS.cmd_4c_CmdExcluir
            .Top             = 3
            .Left            = 549
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .TabIndex        = 3
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .ToolTipText     = "Excluir o centro de custo da linha corrente"
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
        WITH THIS.cmd_4c_CmdSair
            .Top             = 3
            .Left            = 624
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .TabIndex        = 4
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .ToolTipText     = "Gravar e encerrar"
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 334
            .Left      = 350
            .Width     = 220
            .Height    = 17
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(0, 128, 255)
            .TabIndex  = 2
            .Caption   = "C = Somente Contas do Grupo"
            .Visible   = .T.
        ENDWITH

        *-- SIGOPOPE.cmdInserir.Click / cmdExcluir.Click / cmdSair.Click
        *-- (legado). BINDEVENT exige que o metodo alvo JA exista em THIS e
        *-- seja PUBLIC (regra CLAUDE.md #3) - por isso vem depois dos WITH
        *-- acima, e os tres handlers sao PUBLIC mais abaixo nesta classe.
        BINDEVENT(THIS.cmd_4c_CmdInserir, "Click", THIS, "CmdInserirClick")
        BINDEVENT(THIS.cmd_4c_CmdExcluir, "Click", THIS, "CmdExcluirClick")
        BINDEVENT(THIS.cmd_4c_CmdSair,    "Click", THIS, "CmdSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarPermissoesBotoes - Visible/Enabled de Inserir e Excluir,
    * TRANSCRITO do PROCEDURE Init legado:
    *
    *   .cmdInserir.Visible = fChecaAcesso('SIGCCCPE','INSERIR') And
    *                         Iif( Type('Thisform.PcEscolha') # 'C', .T.,
    *                         InList( Thisform.PcEscolha, 'INSERIR', 'ALTERAR' ) )
    *   (idem .Enabled, e o par equivalente com 'EXCLUIR' para cmdExcluir)
    *
    * Roda DEPOIS de TornarControlesVisiveis: aquele metodo forca
    * Visible = .T. em todos os controles criados por AddObject e apagaria
    * o Visible = .F. decidido aqui.
    *
    * O cmdSair NAO entra: o legado nunca o esconde - ele e a unica saida
    * do dialogo (que tem TitleBar = 0 e ControlBox = .F.).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarPermissoesBotoes()
        LOCAL loc_lModoEdicao, loc_lPodeInserir, loc_lPodeExcluir

        *-- "Iif( Type('Thisform.PcEscolha') # 'C', .T., InList(...) )": sem
        *-- modo informado pelo form chamador, o legado libera os botoes.
        loc_lModoEdicao = IIF(EMPTY(THIS.this_cEscolha), .T., ;
                              INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR"))

        loc_lPodeInserir = fChecaAcesso("SIGCCCPE", "INSERIR") AND loc_lModoEdicao
        loc_lPodeExcluir = fChecaAcesso("SIGCCCPE", "EXCLUIR") AND loc_lModoEdicao

        THIS.cmd_4c_CmdInserir.Visible = loc_lPodeInserir
        THIS.cmd_4c_CmdInserir.Enabled = loc_lPodeInserir
        THIS.cmd_4c_CmdExcluir.Visible = loc_lPodeExcluir
        THIS.cmd_4c_CmdExcluir.Enabled = loc_lPodeExcluir

        *-- a grade so e digitavel quando o dialogo esta em modo de edicao;
        *-- em consulta ela vira exibicao, como no legado (sem Inserir nem
        *-- Excluir nao ha como alterar o vinculo)
        THIS.grd_4c_Dados.ReadOnly = !(loc_lPodeInserir OR loc_lPodeExcluir)
        IF !THIS.grd_4c_Dados.ReadOnly
            *-- DEPOIS do ReadOnly do Grid, que propaga para as colunas
            THIS.grd_4c_Dados.Column1.ReadOnly = .F.
            THIS.grd_4c_Dados.Column3.ReadOnly = .F.
            THIS.grd_4c_Dados.Column4.ReadOnly = .F.
        ENDIF
        THIS.grd_4c_Dados.Column2.ReadOnly = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - FUNIL de carga da unica lista deste dialogo: a grade
    * de vinculos "Grupo de Contas x Operacao" (SIGOPOPE.GradeSubN, ligada
    * ao cursor local TmpCcOpe no legado). Nao ha Page1=Lista/Page2=Dados
    * aqui - a "lista" desta tela e essa grade, e e ela que o PROCEDURE
    * Init legado popula logo apos montar a tela.
    *
    * Sequencia: BO.CarregarVinculos (SQL -> cursor temporario -> ZAP +
    * APPEND no alias da grade) -> AtualizarGrade (GO TOP + Refresh).
    * Popular o cursor NAO repinta a grade: sem o Refresh explicito ela
    * fica visualmente VAZIA com o cursor cheio (regra CLAUDE.md #21).
    *
    * PUBLIC (nao PROTECTED) de proposito: o harness de teste automatico
    * chama THIS.oForm.CarregarLista() de FORA da classe, e PEMSTATUS nao
    * verifica escopo - um PROTECTED aqui passaria pelo IF do teste e
    * falharia em runtime (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lSucesso = THIS.this_oBusinessObject.CarregarVinculos( ;
                               THIS.this_cDopes, THIS.this_cCursorGrade)
        ENDIF

        THIS.AtualizarGrade(.T.)

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarGrade - METODO UNICO de repintura da grade, equivalente ao
    * "Select TmpCcOpe / Goto Top / Thisform.GradeSubN.Refresh" do Init
    * legado e ao "Thisform.GradeSubN.Refresh" do cmdExcluir.Click.
    *
    * par_lIrParaTopo - .T. reposiciona no primeiro registro (carga); .F.
    *   preserva a linha corrente (exclusao, que ja reposicionou com o
    *   SKIP / SKIP -1 do legado). Omitido = .T.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarGrade(par_lIrParaTopo)
        LOCAL loc_lIrParaTopo

        loc_lIrParaTopo = IIF(VARTYPE(par_lIrParaTopo) = "L", par_lIrParaTopo, .T.)

        IF USED("cursor_4c_Vinculos")
            SELECT cursor_4c_Vinculos
            IF loc_lIrParaTopo
                GO TOP IN cursor_4c_Vinculos
            ENDIF
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdInserirClick - SIGOPOPE.cmdInserir.Click (legado):
    *
    *   Thisform.lHouveIns = .T.
    *   Select TmpCcOpe
    *   Locate for Grupos = ' '
    *   If Eof()
    *       Insert Into TmpCcOpe (Dopes, CidChaves) Values (crSigCdOpe.Dopes, fUniqueIds())
    *   EndIf
    *   Select TmpCcOpe
    *   Thisform.GradeSubN.Column1.SetFocus
    *
    * O LOCATE evita empilhar linhas em branco: se ja existe uma linha sem
    * grupo, o botao so leva o foco de volta para ela.
    *
    * PUBLIC (nao PROTECTED): e alvo de BINDEVENT (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE CmdInserirClick()
        LOCAL loc_oErro

        TRY
            IF !USED("cursor_4c_Vinculos")
                MsgErro("Cursor da grade n" + CHR(227) + "o est" + CHR(225) + " aberto.", ;
                        "Erro em CmdInserirClick")
            ELSE
                THIS.this_lHouveIns = .T.

                SELECT cursor_4c_Vinculos
                LOCATE FOR EMPTY(grupos)

                IF EOF()
                    INSERT INTO cursor_4c_Vinculos (dopes, cidchaves) ;
                        VALUES (THIS.this_cDopes, LEFT(fUniqueIds(), 20))
                ENDIF

                *-- repinta SEM GO TOP: a linha corrente e a recem-inserida
                *-- (ou a linha em branco que o LOCATE encontrou)
                THIS.AtualizarGrade(.F.)

                IF THIS.grd_4c_Dados.Visible AND !THIS.grd_4c_Dados.ReadOnly
                    THIS.grd_4c_Dados.Column1.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CmdInserirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdExcluirClick - SIGOPOPE.cmdExcluir.Click (legado):
    *
    *   Select TmpCcOpe
    *   If Not Eof()
    *       Thisform.lHouveExcl = .T.
    *       Delete
    *       Skip
    *       Skip - 1
    *   Endif
    *   Thisform.GradeSubN.Refresh
    *
    * O "Skip / Skip -1" reposiciona o ponteiro num registro vivo depois da
    * exclusao logica (com SET DELETED ON o registro apagado deixa de ser
    * visitado); por isso a repintura aqui NAO vai para o topo.
    *
    * PUBLIC (nao PROTECTED): e alvo de BINDEVENT (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE CmdExcluirClick()
        LOCAL loc_oErro

        TRY
            IF !USED("cursor_4c_Vinculos")
                MsgErro("Cursor da grade n" + CHR(227) + "o est" + CHR(225) + " aberto.", ;
                        "Erro em CmdExcluirClick")
            ELSE
                SELECT cursor_4c_Vinculos

                IF !EOF()
                    THIS.this_lHouveExcl = .T.
                    DELETE
                    SKIP
                    SKIP -1

                    IF EOF() OR BOF()
                        GO TOP
                    ENDIF
                ENDIF

                THIS.AtualizarGrade(.F.)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CmdExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSairClick - SIGOPOPE.cmdSair.Click (legado): grava o que foi
    * alterado na grade e encerra o dialogo.
    *
    *   If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
    *       If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
    *           Select TmpCcOpe
    *           Delete For Grupos = '  '
    *           Replace all dopes With CrSigCdOpe.Dopes, CidChaves With fUniqueIds()
    *           Select Grupos, sum(1) From TmpccOpe Group by 1 having sum(1) > 1 Into Cursor SecondKey
    *           If Reccount() > 0
    *               MessageBox('Existem Grupos em Duplicidade. Favor Acertar!!!',0+16,'Atencao')
    *               Return .f.
    *           EndIf
    *           ...Delete From SigCcCpe Where Dopes = <operacao> + regrava o cursor...
    *       EndIf
    *   EndIf
    *   Thisform.ParentForm.Enabled = .T.
    *   Thisform.mCtrlBotoes(.T.)
    *   ThisForm.Release
    *
    * O guard de duplicidade NAO fecha o dialogo ("Return .f." do legado):
    * o usuario precisa acertar os grupos repetidos antes de sair. O
    * "Replace all dopes/CidChaves" e o DELETE+regravacao ficam no BO
    * (SalvarVinculos), em transacao unica.
    *
    * NAO ha RETURN dentro do TRY (regra CLAUDE.md #1): o fluxo e decidido
    * pela flag loc_lPodeFechar e a saida acontece DEPOIS do ENDTRY.
    *
    * PUBLIC (nao PROTECTED): e alvo de BINDEVENT (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE CmdSairClick()
        LOCAL loc_lPodeFechar, loc_lTemDuplicidade, loc_oErro

        loc_lPodeFechar     = .T.
        loc_lTemDuplicidade = .F.

        TRY
            *-- so grava quando o dialogo esta em modo de edicao (Inserir ou
            *-- Excluir visiveis) E alguma coisa mudou na grade
            IF (THIS.cmd_4c_CmdInserir.Visible OR THIS.cmd_4c_CmdExcluir.Visible) ;
               AND (THIS.this_lHouveIns OR THIS.this_lHouveExcl) ;
               AND USED("cursor_4c_Vinculos")

                SELECT cursor_4c_Vinculos

                *-- "Delete For Grupos = '  '": linha em branco nao vira registro
                DELETE FOR EMPTY(grupos)

                IF USED("cursor_4c_Duplicados")
                    USE IN cursor_4c_Duplicados
                ENDIF

                SELECT grupos, COUNT(*) AS qtd ;
                    FROM cursor_4c_Vinculos ;
                    GROUP BY 1 ;
                    HAVING COUNT(*) > 1 ;
                    INTO CURSOR cursor_4c_Duplicados READWRITE

                *-- cursor derivado de SELECT nao tem registro deletado, entao
                *-- RECCOUNT aqui conta exatamente as duplicidades
                loc_lTemDuplicidade = (USED("cursor_4c_Duplicados") AND RECCOUNT("cursor_4c_Duplicados") > 0)

                IF USED("cursor_4c_Duplicados")
                    USE IN cursor_4c_Duplicados
                ENDIF

                IF loc_lTemDuplicidade
                    *-- UNICO caminho em que o legado NAO fecha ("Return .f.")
                    loc_lPodeFechar = .F.
                    MsgAviso("Existem Grupos em Duplicidade. Favor Acertar!!!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.AtualizarGrade(.T.)
                ELSE
                    IF VARTYPE(THIS.this_oBusinessObject) = "O"
                        *-- o BO exibe a propria mensagem quando a gravacao
                        *-- falha; o legado encerra o dialogo nos dois casos
                        THIS.this_oBusinessObject.SalvarVinculos( ;
                            THIS.this_cDopes, THIS.this_cCursorGrade)
                    ELSE
                        *-- sem BO nao ha como gravar: avisar, para o usuario
                        *-- nao sair achando que o vinculo foi salvo
                        MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
                                "vel - as altera" + CHR(231) + CHR(245) + "es da grade " + ;
                                "N" + CHR(195) + "O foram gravadas.", ;
                                "Erro em CmdSairClick")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            *-- NAO bloqueia a saida: este dialogo tem TitleBar = 0,
            *-- ControlBox = .F. e WindowType = 1, entao o cmdSair e a UNICA
            *-- saida (inclusive o ESC, por .Cancel = .T.). Prender o usuario
            *-- aqui travaria a aplicacao inteira. O legado tambem avisa e
            *-- fecha quando a gravacao falha - so a duplicidade retem.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CmdSairClick")
        ENDTRY

        IF loc_lPodeFechar
            *-- "Thisform.ParentForm.Enabled = .T." + "mCtrlBotoes(.T.)": o
            *-- legado reabilita botao a botao a Lista do form chamador
            *-- porque so ela havia sido travada; aqui o Init desabilitou o
            *-- form chamador INTEIRO, entao reabilita-lo cobre os dois.
            THIS.ReabilitarFormPai()
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ReabilitarFormPai - devolve o controle ao form chamador, equivalente
    * ao par "Thisform.ParentForm.Enabled = .T." + "Thisform.mCtrlBotoes(.T.)"
    * do cmdSair.Click legado.
    *
    * Metodo unico porque ha DOIS caminhos de volta: o botao Encerrar e o
    * Destroy (rede de seguranca para fechamento por ESC/Alt+F4). Sem isso,
    * fechar o dialogo por fora do botao deixaria o Cadastro de Operacoes
    * travado para sempre.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ReabilitarFormPai()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC
    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna visiveis, recursivamente, todos os
    * controles criados via AddObject (que nascem com Visible=.F.). Nao ha
    * container flutuante neste form (dialogo flat, sem paineis ocultos
    * alternados por botao), entao nao ha lista de exclusao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - rede de seguranca: reabilita o form chamador mesmo se o
    * dialogo for encerrado sem passar pelo funil do botao Encerrar
    * (equivalente a "Thisform.ParentForm.Enabled = .T." do cmdSair.Click
    * legado) e fecha o cursor local da grade, para nao vazar work area
    * entre aberturas do dialogo. DODEFAULT() preserva a limpeza de
    * this_oBusinessObject e a restauracao do menu feitas por
    * FormBase.Destroy().
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.ReabilitarFormPai()

        IF USED("cursor_4c_Vinculos")
            IF CURSORGETPROP("Buffering", "cursor_4c_Vinculos") > 1
                TABLEREVERT(.T., "cursor_4c_Vinculos")
            ENDIF
            USE IN cursor_4c_Vinculos
        ENDIF

        IF USED("cursor_4c_Duplicados")
            USE IN cursor_4c_Duplicados
        ENDIF

        *-- rede de seguranca: cursores dos lookups de Grupo de Contas
        *-- (Column1/Column3) podem ficar abertos se o dialogo for fechado
        *-- no meio de uma validacao/busca
        IF USED("cursor_4c_GruposAcessiveis")
            USE IN cursor_4c_GruposAcessiveis
        ENDIF

        IF USED("cursor_4c_ContaVinc")
            USE IN cursor_4c_ContaVinc
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpOpeBO.prg):
*====================================================================
* SigOpOpeBO.prg
*
* Business Object para Centro de Custo Padrao da Operacao
* Tabela: SigCcCpe (vinculo Grupo de Contas x Operacao)
* Tabelas relacionadas: SigCdOpe (operacao - FK dopes), SigCdGcr (grupo de contas - FK grupos)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpOpeBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCcCpe)
    this_cCidChaves      = ""    && cidchaves char(20) - PK (gerada via fUniqueIds())
    this_cDopes          = ""    && dopes     char(20) - codigo da operacao (FK SigCdOpe.dopes)
    this_cGrupos         = ""    && grupos    char(10) - codigo do grupo de contas (FK SigCdGcr.codigos)
    this_cGruCads        = ""    && grucads   char(10) - grupo de cadastro (conta contabil validada via fAcessoContab)
    this_nCtFils         = 0     && ctfils    numeric(1,0) - "C" = Somente Contas do Grupo (0/1)

    *-- Propriedade auxiliar de exibicao (NAO persistida em SigCcCpe)
    this_cDescricaoGrupo = ""    && SigCdGcr.descrs - descricao do grupo (join, somente leitura)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCcCpe"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpOpeBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    * (usada por RegistrarAuditoria)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia os campos do cursor para as propriedades
    * do vinculo Grupo de Contas x Operacao (SigCcCpe). par_cAliasCursor
    * eh o alias do cursor posicionado no registro a carregar (ex.: linha
    * corrente da grade TmpCcOpe, ou resultado de SQLEXEC pela chave).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "")
            THIS.this_cDopes     = TratarNulo(dopes,     "")
            THIS.this_cGrupos    = TratarNulo(grupos,    "")
            THIS.this_cGruCads   = TratarNulo(grucads,   "")
            THIS.this_nCtFils    = TratarNulo(ctfils,    0)

            *-- descrs nao eh coluna de SigCcCpe: so chega quando o cursor
            *-- de origem for montado com JOIN contra SigCdGcr (descricao
            *-- do grupo exibida na grade). Mapear so quando presente.
            IF TYPE(par_cAliasCursor + ".descrs") != "U"
                THIS.this_cDescricaoGrupo = TratarNulo(descrs, "")
            ELSE
                THIS.this_cDescricaoGrupo = ""
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT de um vinculo Grupo de Contas x Operacao em SigCcCpe
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigCcCpe (cidchaves, dopes, grupos, grucads, ctfils)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves)       + "," + ;
                       EscaparSQL(THIS.this_cDopes)           + "," + ;
                       EscaparSQL(THIS.this_cGrupos)          + "," + ;
                       EscaparSQL(THIS.this_cGruCads)         + "," + ;
                       FormatarNumeroSQL(THIS.this_nCtFils, 0) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir centro de custo padr" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir centro de custo padr" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE de um vinculo Grupo de Contas x Operacao em SigCcCpe
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCcCpe SET" + ;
                       " dopes    = " + EscaparSQL(THIS.this_cDopes)   + "," + ;
                       " grupos   = " + EscaparSQL(THIS.this_cGrupos)  + "," + ;
                       " grucads  = " + EscaparSQL(THIS.this_cGruCads) + "," + ;
                       " ctfils   = " + FormatarNumeroSQL(THIS.this_nCtFils, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar centro de custo padr" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar centro de custo padr" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *====================================================================
    * CarregarVinculos - Popula o cursor da grade com os vinculos
    * "Grupo de Contas x Operacao" ja gravados para a operacao recebida.
    *
    * Transcreve a consulta do PROCEDURE Init legado:
    *   lcSql = [Select a.*, b.Descrs as Dgrus From SigCcCpe a, SigCdGcr b
    *            where a.Dopes = <operacao> And a.Grupos = b.Codigos]
    *   SigCdOpe.PodataMgr.Sqlexecute(lcSql,'xCcOpe')
    *   Select * From xCcOpe Into Cursor TmpCcOpe ReadWrite
    *
    * O "a.*" do legado vira a lista EXPLICITA das 5 colunas de SigCcCpe
    * (cidchaves/dopes/grupos/grucads/ctfils): o APPEND FROM casa as
    * colunas por NOME, entao a lista do SELECT tem de ser exatamente a
    * do CREATE CURSOR do form.
    *
    * NAO faz SQLEXEC direto no alias da grade: isso FECHA e RECRIA o
    * alias, zerando ColumnCount/RecordSource/ControlSource e o
    * CurrentControl do CheckBox da Column4 (a grade viraria um retangulo
    * branco, sem erro e sem log). Por isso o SQL vai para um cursor
    * TEMPORARIO e o alias da grade e recarregado com ZAP + APPEND FROM
    * DBF(), que preserva estrutura e bindings.
    *
    * par_cDopes        - codigo da operacao (SigCdOpe.dopes)
    * par_cAliasDestino - alias ja criado (CREATE CURSOR) ligado a grade
    *====================================================================
    PROCEDURE CarregarVinculos(par_cDopes, par_cAliasDestino)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cTemp, loc_oErro
        LOCAL loc_cAliasAnterior, loc_cSafety

        loc_lSucesso       = .F.
        loc_cTemp          = "cursor_4c_VinculosTmp"
        loc_cAliasAnterior = ALIAS()
        loc_cSafety        = SET("SAFETY")

        TRY
            IF VARTYPE(par_cDopes) != "C" OR VARTYPE(par_cAliasDestino) != "C"
                MsgErro("Par" + CHR(226) + "metros inv" + CHR(225) + "lidos em CarregarVinculos.", ;
                        "Erro em CarregarVinculos")
            ELSE
                IF !USED(par_cAliasDestino)
                    MsgErro("Cursor da grade [" + par_cAliasDestino + "] n" + CHR(227) + ;
                            "o est" + CHR(225) + " aberto.", "Erro em CarregarVinculos")
                ELSE
                    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                        MsgErro("Conex" + CHR(227) + "o com o banco n" + CHR(227) + ;
                                "o estabelecida.", "Erro em CarregarVinculos")
                    ELSE
                        loc_cSQL = "SELECT a.cidchaves, a.dopes, a.grupos, a.grucads, a.ctfils," + ;
                                   " b.descrs AS dgrus" + ;
                                   " FROM SigCcCpe a, SigCdGcr b" + ;
                                   " WHERE a.dopes = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
                                   " AND a.grupos = b.codigos"

                        IF USED(loc_cTemp)
                            IF CURSORGETPROP("Buffering", loc_cTemp) > 1
                                TABLEREVERT(.T., loc_cTemp)
                            ENDIF
                            USE IN (loc_cTemp)
                        ENDIF

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cTemp)

                        IF loc_nResultado < 0
                            MsgErro("Erro ao carregar os centros de custo da opera" + CHR(231) + ;
                                    CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            *-- SET SAFETY e escopado por DATA SESSION: o
                            *-- SET SAFETY OFF do main.prg vale na sessao 1,
                            *-- mas este BO roda DENTRO da datasession
                            *-- privada do FormSigOpOpe (DataSession = 2),
                            *-- onde SAFETY nasce ON - medido no VFP9 em
                            *-- 2026-11-11 (automation/MedirDeletedSafetyDS2.prg:
                            *-- "SESSAO_FORM deleted=OFF safety=ON"). Com
                            *-- SAFETY ON o ZAP abre o dialogo modal
                            *-- "Zap ... Are you sure?" e CONGELA a tela.
                            SET SAFETY OFF

                            SELECT (par_cAliasDestino)
                            ZAP

                            IF loc_cSafety = "ON"
                                SET SAFETY ON
                            ENDIF

                            IF USED(loc_cTemp)
                                APPEND FROM DBF(loc_cTemp)
                                USE IN (loc_cTemp)
                            ENDIF
                            GO TOP IN (par_cAliasDestino)
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarVinculos")
        ENDTRY

        *-- rede de seguranca: excecao DURANTE o ZAP sairia com SAFETY OFF
        IF loc_cSafety = "ON"
            SET SAFETY ON
        ENDIF

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterGrupoContasAcessivel - Nucleo de fAcessoContab (Framework legado,
    * Framework\sigacess.PRG:1029) restrito ao caminho usado por SIGOPOPE
    * (os dois call sites do dump passam so pUsu/pTip/pTxt/pCod[/pDsc] -
    * pCta e pDat nunca sao informados, entao os blocos de vinculo com
    * conta-corrente (SigCdCli) e de bloqueio por periodo (ddRetros/ddFutus)
    * do legado NUNCA executam para este form e foram omitidos aqui).
    *
    * Replica a restricao de acesso por GRUPO DE CONTAS:
    *   - usuario "4CONTROL" (super-usuario) enxerga TODOS os grupos
    *     (equivalente a "llTot" do legado)
    *   - demais usuarios so veem grupos vinculados a eles via SigSyAgc
    *     (Usuacess direto) OU via grupo de acesso (SigCdAcG.Usuarios),
    *     igual ao JOIN de 3 tabelas do legado
    *   - se o usuario NAO tem NENHUM vinculo de restricao cadastrado em
    *     SigSyAgc/SigCdAcG, cai para a lista COMPLETA de SigCdGcr
    *     (equivalente a "llRst" do legado - sistema sem restricao
    *     configurada libera tudo)
    *
    * par_cFiltroCodigo - codigo exato a filtrar (Codigos = valor); vazio
    *   devolve TODOS os grupos acessiveis (usado para popular o picker).
    *
    * Retorna o codigo do SQLEXEC; o resultado fica no cursor
    * cursor_4c_GruposAcessiveis (colunas Codigos/Descrs) - o CHAMADOR
    * fecha esse cursor apos usar.
    *====================================================================
    FUNCTION ObterGrupoContasAcessivel(par_cFiltroCodigo)
        LOCAL loc_cUsuario, loc_lSuperUsuario, loc_cAlias, loc_cWhereUsuario
        LOCAL loc_cSQL, loc_nResultado, loc_nTotalVinculos, loc_lUsaRestricao
        LOCAL loc_cFiltro

        loc_cAlias   = "cursor_4c_GruposAcessiveis"
        loc_cFiltro  = IIF(VARTYPE(par_cFiltroCodigo) = "C", ALLTRIM(par_cFiltroCodigo), "")
        loc_cUsuario = ALLTRIM(UPPER(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")))
        loc_lSuperUsuario = (loc_cUsuario == "4CONTROL")

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_lUsaRestricao = !loc_lSuperUsuario AND !EMPTY(loc_cUsuario)

        IF loc_lUsaRestricao
            loc_cWhereUsuario = "(a.Usuacess = " + EscaparSQL(loc_cUsuario) + ;
                                 " OR c.Usuarios = " + EscaparSQL(loc_cUsuario) + ")"

            loc_cSQL = "SELECT COUNT(*) AS Nvinc FROM SigSyAgc a" + ;
                       " LEFT JOIN SigCdAcG c ON c.Grupos = a.Gracess AND c.Usuarios = " + ;
                       EscaparSQL(loc_cUsuario) + ;
                       " WHERE " + loc_cWhereUsuario

            IF USED("cursor_4c_ContaVinc")
                USE IN cursor_4c_ContaVinc
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaVinc")
            loc_nTotalVinculos = IIF(loc_nResultado >= 0 AND USED("cursor_4c_ContaVinc"), ;
                                      NVL(cursor_4c_ContaVinc.Nvinc, 0), 0)
            IF USED("cursor_4c_ContaVinc")
                USE IN cursor_4c_ContaVinc
            ENDIF

            *-- sem NENHUM vinculo de restricao cadastrado -> acesso livre
            loc_lUsaRestricao = (loc_nTotalVinculos > 0)
        ENDIF

        IF loc_lUsaRestricao
            loc_cSQL = "SELECT b.Codigos, b.Descrs" + ;
                       " FROM SigSyAgc a" + ;
                       " LEFT JOIN SigCdAcG c ON c.Grupos = a.Gracess AND c.Usuarios = " + ;
                       EscaparSQL(loc_cUsuario) + ;
                       " RIGHT JOIN SigCdGcr b ON b.Codigos = a.Grcontbs" + ;
                       " WHERE " + loc_cWhereUsuario
            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " AND b.Codigos = " + EscaparSQL(loc_cFiltro)
            ENDIF
            loc_cSQL = loc_cSQL + " GROUP BY b.Codigos, b.Descrs ORDER BY b.Codigos"
        ELSE
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr"
            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE Codigos = " + EscaparSQL(loc_cFiltro)
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY Codigos"
        ENDIF

        RETURN SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)
    ENDFUNC

    *====================================================================
    * SalvarVinculos - Regrava TODOS os vinculos da operacao a partir do
    * cursor da grade, em transacao unica.
    *
    * Transcreve o bloco de gravacao do cmdSair.Click legado:
    *   lcSql = [Delete From SigCcCpe Where Dopes = <operacao>]
    *   ...Sqlexecute(lcSql,'') / .poDataMgr.UpDate('crSigCcCpe') / Commit()
    *   Se qualquer etapa falhar -> RollBack()
    * O legado apaga tudo da operacao e regrava o cursor inteiro (o
    * "Zap / Append From Dbf('TmpCcOpe')" em crSigCcCpe antes do Update);
    * aqui o mesmo efeito vem de DELETE + um INSERT por linha.
    *
    * BEGIN/COMMIT por SQLEXEC NAO protege nada - a transacao e aberta na
    * CONEXAO (SQLSETPROP "Transactions" = 2) e encerrada com SQLTRANSACT,
    * restaurando o modo automatico (1) em TODOS os caminhos, inclusive
    * no CATCH.
    *
    * As linhas DELETADAS do cursor (o "Delete For Grupos = '  '" do
    * legado) ficam de fora porque o SCAN respeita SET DELETED ON; a
    * guarda por grupos vazio cobre o caso de SET DELETED OFF.
    *
    * par_cDopes       - codigo da operacao (SigCdOpe.dopes)
    * par_cAliasCursor - alias do cursor da grade com as linhas a gravar
    *====================================================================
    PROCEDURE SalvarVinculos(par_cDopes, par_cAliasCursor)
        LOCAL loc_lSucesso, loc_lTransacaoAberta, loc_lErroScan
        LOCAL loc_cSQL, loc_nResultado, loc_oErro, loc_cAliasAnterior

        loc_lSucesso         = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroScan        = .F.
        loc_cAliasAnterior   = ALIAS()

        TRY
            IF VARTYPE(par_cDopes) != "C" OR VARTYPE(par_cAliasCursor) != "C"
                MsgErro("Par" + CHR(226) + "metros inv" + CHR(225) + "lidos em SalvarVinculos.", ;
                        "Erro em SalvarVinculos")
            ELSE
                IF !USED(par_cAliasCursor)
                    MsgErro("Cursor da grade [" + par_cAliasCursor + "] n" + CHR(227) + ;
                            "o est" + CHR(225) + " aberto.", "Erro em SalvarVinculos")
                ELSE
                    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                        MsgErro("Conex" + CHR(227) + "o com o banco n" + CHR(227) + ;
                                "o estabelecida.", "Erro em SalvarVinculos")
                    ELSE
                        SQLSETPROP(gnConnHandle, "Transactions", 2)
                        loc_lTransacaoAberta = .T.

                        loc_cSQL = "DELETE FROM SigCcCpe WHERE dopes = " + ;
                                   EscaparSQL(ALLTRIM(par_cDopes))
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                        IF loc_nResultado < 0
                            loc_lErroScan = .T.
                            MsgErro("Erro ao limpar os centros de custo da opera" + CHR(231) + ;
                                    CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            SELECT (par_cAliasCursor)
                            GO TOP

                            SCAN
                                *-- linha em branco nao vira registro (o legado
                                *-- apaga essas linhas antes de gravar)
                                IF !EMPTY(EVALUATE(par_cAliasCursor + ".grupos"))
                                    IF !THIS.CarregarDoCursor(par_cAliasCursor)
                                        loc_lErroScan = .T.
                                        EXIT
                                    ENDIF

                                    *-- a operacao do vinculo e sempre a do form
                                    *-- chamador ("Replace all dopes With
                                    *-- CrSigCdOpe.Dopes" do legado)
                                    THIS.this_cDopes = ALLTRIM(par_cDopes)

                                    *-- PK nova para cada linha regravada
                                    *-- ("CidChaves With fUniqueIds()")
                                    THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)

                                    IF !THIS.Inserir()
                                        loc_lErroScan = .T.
                                        EXIT
                                    ENDIF
                                ENDIF
                            ENDSCAN
                        ENDIF

                        IF loc_lErroScan
                            SQLTRANSACT(gnConnHandle, "ROLLBACK")
                        ELSE
                            SQLTRANSACT(gnConnHandle, "COMMIT")
                            loc_lSucesso = .T.
                        ENDIF

                        SQLSETPROP(gnConnHandle, "Transactions", 1)
                        loc_lTransacaoAberta = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLTRANSACT(gnConnHandle, "ROLLBACK")
                SQLSETPROP(gnConnHandle, "Transactions", 1)
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SalvarVinculos")
        ENDTRY

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

