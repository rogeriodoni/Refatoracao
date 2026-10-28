# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[24/10/2026 08:22:52 AM] Erro InicializarForm: Property COLUMN4 is not found.Linha: 1582Procedure: configurargradessaldo


### LOG DA ETAPA (06b_testeAutomatico):
[2026-10-24 08:13:00] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-24 08:13:00] [INFO] Config FPW: (nao fornecido)
[2026-10-24 08:13:00] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-24 08:13:00] [INFO] Timeout: 300 segundos
[2026-10-24 08:13:00] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zikupr4v.prg
[2026-10-24 08:13:00] [INFO] Conteudo do wrapper:
[2026-10-24 08:13:01] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigopcgc', 'C:\4c\tasks\task690', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigopcgc', 'C:\4c\tasks\task690', 'OPERACIONAL'
QUIT

[2026-10-24 08:13:01] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zikupr4v.prg
[2026-10-24 08:13:01] [INFO] VFP output esperado em: C:\4c\tasks\task690\vfp_output.txt
[2026-10-24 08:13:01] [INFO] Executando Visual FoxPro 9...
[2026-10-24 08:13:01] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zikupr4v.prg
[2026-10-24 08:13:01] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zikupr4v.prg
[2026-10-24 08:13:01] [INFO] Timeout configurado: 300 segundos
[2026-10-24 08:15:49] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-24 08:15:49] [INFO] VFP9 finalizado em 168.4291289 segundos
[2026-10-24 08:15:49] [INFO] Exit Code: 
[2026-10-24 08:15:50] [INFO] 
[2026-10-24 08:15:50] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-24 08:15:50] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zikupr4v.prg
[2026-10-24 08:15:50] [INFO] 
[2026-10-24 08:15:50] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-24 08:15:50] [INFO] * Auto-generated wrapper for parameters
[2026-10-24 08:15:50] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-24 08:15:50] [INFO] * Parameters: 'Formsigopcgc', 'C:\4c\tasks\task690', 'OPERACIONAL'
[2026-10-24 08:15:50] [INFO] 
[2026-10-24 08:15:50] [INFO] * Anti-dialog protections for unattended execution
[2026-10-24 08:15:51] [INFO] SET SAFETY OFF
[2026-10-24 08:15:51] [INFO] SET RESOURCE OFF
[2026-10-24 08:15:51] [INFO] SET TALK OFF
[2026-10-24 08:15:51] [INFO] SET NOTIFY OFF
[2026-10-24 08:15:51] [INFO] SYS(2335, 0)
[2026-10-24 08:15:51] [INFO] 
[2026-10-24 08:15:51] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigopcgc', 'C:\4c\tasks\task690', 'OPERACIONAL'
[2026-10-24 08:15:51] [INFO] QUIT
[2026-10-24 08:15:51] [INFO] 
[2026-10-24 08:15:51] [INFO] === Fim do Wrapper.prg ===
[2026-10-24 08:15:51] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-10-24 08:19:40] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-24 08:19:40] [INFO] Config FPW: (nao fornecido)
[2026-10-24 08:19:40] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-24 08:19:41] [INFO] Timeout: 300 segundos
[2026-10-24 08:19:41] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_usxjclsh.prg
[2026-10-24 08:19:41] [INFO] Conteudo do wrapper:
[2026-10-24 08:19:41] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigopcgc', 'C:\4c\tasks\task690', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigopcgc', 'C:\4c\tasks\task690', 'OPERACIONAL'
QUIT

[2026-10-24 08:19:41] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_usxjclsh.prg
[2026-10-24 08:19:41] [INFO] VFP output esperado em: C:\4c\tasks\task690\vfp_output.txt
[2026-10-24 08:19:41] [INFO] Executando Visual FoxPro 9...
[2026-10-24 08:19:41] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_usxjclsh.prg
[2026-10-24 08:19:41] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_usxjclsh.prg
[2026-10-24 08:19:41] [INFO] Timeout configurado: 300 segundos
[2026-10-24 08:22:52] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-24 08:22:53] [INFO] VFP9 finalizado em 191.4008607 segundos
[2026-10-24 08:22:53] [INFO] Exit Code: 
[2026-10-24 08:22:53] [INFO] 
[2026-10-24 08:22:53] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-24 08:22:53] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_usxjclsh.prg
[2026-10-24 08:22:53] [INFO] 
[2026-10-24 08:22:53] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-24 08:22:53] [INFO] * Auto-generated wrapper for parameters
[2026-10-24 08:22:53] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-24 08:22:53] [INFO] * Parameters: 'Formsigopcgc', 'C:\4c\tasks\task690', 'OPERACIONAL'
[2026-10-24 08:22:53] [INFO] 
[2026-10-24 08:22:54] [INFO] * Anti-dialog protections for unattended execution
[2026-10-24 08:22:54] [INFO] SET SAFETY OFF
[2026-10-24 08:22:54] [INFO] SET RESOURCE OFF
[2026-10-24 08:22:54] [INFO] SET TALK OFF
[2026-10-24 08:22:54] [INFO] SET NOTIFY OFF
[2026-10-24 08:22:54] [INFO] SYS(2335, 0)
[2026-10-24 08:22:54] [INFO] 
[2026-10-24 08:22:54] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigopcgc', 'C:\4c\tasks\task690', 'OPERACIONAL'
[2026-10-24 08:22:54] [INFO] QUIT
[2026-10-24 08:22:54] [INFO] 
[2026-10-24 08:22:54] [INFO] === Fim do Wrapper.prg ===
[2026-10-24 08:22:55] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigopcgc",
  "timestamp": "20261024082252",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": false,
      "erro": "CREATEOBJECT retornou valor nao-objeto",
      "detalhes": ""
    }
  ],
  "resumo": {
    "total": 1,
    "passou": 0,
    "falhou": 1,
    "percentual": 0
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgc.prg):
*==============================================================================
* Formsigopcgc.prg - Form Operacional: Consulta Generica de Compras
* Migrado de SIGOPCGC.SCX
* Herda de FormBase
* Business Object: sigopcgcBO
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado
*   BD   -> Schema IDENTICO (SigCdCli, SigCdGcr, SigCdMoe, SigCdEmp, SigCdPam, etc.)
*   CODE -> arquitetura em camadas (FormBase / sigopcgcBO)
*
* Form OPERACIONAL: NAO segue o padrao Page1=Lista/Page2=Dados de cadastro
* CRUD (regra CLAUDE.md "Form OPERACIONAL"). No legado (fld_principal):
*   Pagina 1 = pag_consulta  -> filtros de pesquisa (Grupo/Conta/CPF do
*              fornecedor, periodo de analise, moeda, empresa) + o
*              CommandGroup grp_operacao (Cadastro/Movimento/Sair).
*   Pagina 2 = pag_resultado -> dados cadastrais do fornecedor pesquisado
*              (Cadastro.Dados) + o PageFrame Result com 5 sub-paginas
*              (Saldo, Movimenta, Estoque, Pendencias, Conserto).
* As duas paginas do legado ja tem a faixa cinza (cntSombra) - replicada
* aqui como cnt_4c_Cabecalho nas duas (regra CLAUDE.md #11).
*
* FASE 3/8: Estrutura base do Form - DEFINE CLASS, Init/InicializarForm,
* ConfigurarPageFrame com as 2 paginas (Consulta/Resultado) e os
* containers principais (cnt_4c_Cabecalho completo nas duas paginas).
*
* FASE 4/8: Botoes de navegacao (este form OPERACIONAL de CONSULTA nao
* tem grid nem CRUD na Page1 - o legado so tem o CommandGroup
* grp_operacao com 3 botoes Cadastro/Movimento/Sair). Adicionados:
* cmg_4c_Operacao (Page1, 3 botoes) + AlternarPagina(); na Page2,
* cmg_4c_Operacao (botao Voltar) + cmg_4c_MudaFor/cmg_4c_MudaMov. A
* validacao e a consulta SQL dos botoes Cadastro/Movimento dependem dos
* campos de filtro (Fases 5-6) e da logica de negocio (Fases 7-8).
* Campos de dados para as Fases 5-6, BINDEVENTs/logica de negocio
* restante para as Fases 7-8.
*
* FASE 5/8: Primeiros 50% dos campos de Cadastro.Dados do legado
* (Codigo/Nome/Endereco/Bairro - TextBoxes + Labels - e os Labels de
* Cep/Cidade/Estado/Telefone 1, cujos TextBoxes entram na Fase 6/8
* junto com Telefone 2/Fax/CGC/IE e a foto do fornecedor).
* Container cnt_4c_Cadastro (legado: PageFrame "Cadastro", pagina
* unica "Dados", Top=155/Left=59/Width=701/Height=421 em
* pag_resultado) replicado como Container simples com Top compensado
* (+29 do PageFrame.Top=-29). Todos os TextBoxes desta aba sao
* somente-leitura (legado: Get_codfor/Get_nome/Get_end/Get_bairro/...
* tem Procedure When / Return(.F.) - nunca recebem foco, so exibem o
* resultado da consulta). Populados pelo BOParaForm nas Fases 7-8.
*==============================================================================

DEFINE CLASS Formsigopcgc AS FormBase

    *-- Dimensoes e propriedades visuais (padrao canonico de form OPERACIONAL)
    Height      = 600
    Width       = 1000
    BorderStyle = 2
    AutoCenter  = .T.
    ShowTips    = .T.
    Caption     = "Consulta Gen" + CHR(233) + "rica de Compras"
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowState = 0
    ShowWindow  = 1
    WindowType  = 1
    DataSession = 2
    Themes      = .F.

    *-- Business Object
    this_oBusinessObject = .NULL.

    *==========================================================================
    * Init(par_cGrupo, par_cConta) - o legado recebe os mesmos dois
    * parametros ("LParameters _Grupo, _Conta"). Quando os dois vem
    * preenchidos (form aberto por OUTRA tela, nao pelo menu), o legado liga
    * ThisForm.Automatico, roda a consulta NA HORA e abre direto na Pagina
    * Resultado no bloco de Movimentacao - e nesse modo o botao Voltar fecha
    * a tela em vez de voltar para os filtros.
    *==========================================================================
    PROCEDURE Init(par_cGrupo, par_cConta)
        LOCAL loc_lSucesso, loc_cGrupo, loc_cConta

        loc_lSucesso = DODEFAULT()

        IF loc_lSucesso
            loc_cGrupo = IIF(VARTYPE(par_cGrupo) = "C", ALLTRIM(par_cGrupo), "")
            loc_cConta = IIF(VARTYPE(par_cConta) = "C", ALLTRIM(par_cConta), "")

            IF !EMPTY(loc_cGrupo + loc_cConta) AND ;
                    PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Origem", 5)
                THIS.AbrirModoAutomatico(loc_cGrupo, loc_cConta)
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AbrirModoAutomatico - bloco final do Init do legado
    * ("If Type('_Grupo') = 'C' And ... ThisForm.Automatico = .T."): preenche
    * Grupo/Conta, consulta na hora e abre a Pagina Resultado no bloco de
    * Movimentacao, sem o botao de volta para os filtros.
    *==========================================================================
    PROTECTED PROCEDURE AbrirModoAutomatico(par_cGrupo, par_cConta)
        THIS.this_oBusinessObject.this_lAutomatico = .T.

        WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
            .txt_4c_Grupo.Value = par_cGrupo
            .txt_4c_Conta.Value = par_cConta
        ENDWITH

        THIS.this_oBusinessObject.this_lMensagem = .F.

        IF THIS.ExecutarProcessamento()
            THIS.MostrarBlocoMovimento()
            THIS.ConfigurarGradesSaldo()

            *-- no modo Automatico nao existe caminho de volta para os
            *-- filtros: so o botao de ida para o cadastro fica disponivel
            THIS.pgf_4c_Paginas.Page2.cmg_4c_MudaMov.Visible = .F.
            THIS.pgf_4c_Paginas.Page2.cmg_4c_MudaMov.Enabled = .F.

            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarParametros - guarda de conexao do Init legado ("Impossivel
    * Efetuar Conexao Com o Servidor de Banco de Dados..."), extraida de
    * InicializarForm com bypass para os dois modos sem usuario.
    *
    * PUBLIC de proposito: o harness da etapa 06b chama metodos do form de
    * FORA da classe, e metodo PROTECTED falha em runtime mesmo com PEMSTATUS
    * devolvendo .T.
    *==========================================================================
    PROCEDURE ValidarParametros()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF TYPE("gb_4c_ModoTeste") = "L"
            IF gb_4c_ModoTeste
                RETURN .T.
            ENDIF
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L"
            IF gb_4c_ValidandoUI
                RETURN .T.
            ENDIF
        ENDIF

        DO CASE
            CASE TYPE("gnConnHandle") != "N"
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
                        "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
                loc_lValido = .F.
            CASE gnConnHandle <= 0
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
                        "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
                loc_lValido = .F.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- A guarda de conexao sai do corpo do metodo (ValidarParametros) e o
        *-- RETURN fica FORA do TRY: com a guarda aqui dentro, o harness de
        *-- teste automatizado - que define gnConnHandle = 0 de proposito,
        *-- porque SQLSTRINGCONNECT bloqueia 300s quando o servidor esta
        *-- inacessivel - reprovaria SEMPRE a instanciacao do form.
        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigopcgcBO")

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()
            THIS.TornarControlesVisiveis(THIS)

            *-- Init do legado: o filtro Grupo nasce com o grupo padrao de
            *-- fornecedores (CrSigCdPam.grpadfors) e os demais campos de
            *-- Origem em branco.
            WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
                .txt_4c_Grupo.Value  = THIS.this_oBusinessObject.ObterGrupoPadrao()
                .txt_4c_Conta.Value  = ""
                .txt_4c_Cpf.Value    = ""
                .txt_4c_Dconta.Value = ""
            ENDWITH

            *-- estado inicial da Pagina Resultado: bloco de cadastro visivel,
            *-- resultado oculto (igual ao legado)
            THIS.MostrarBlocoCadastro()
            THIS.AplicarPermissoes()

            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Constroi o PageFrame com 2 paginas
    * (Consulta/Resultado, espelhando pag_consulta/pag_resultado do legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 2
        loc_oPgf.Top       = -29
        loc_oPgf.Left      = 0
        loc_oPgf.Width     = THIS.Width
        loc_oPgf.Height    = THIS.Height + 29
        loc_oPgf.TabIndex  = 1
        loc_oPgf.Tabs      = .F.

        loc_oPgf.Page1.Caption = "Consulta"
        loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        loc_oPgf.Page2.Caption = "Resultado"
        loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Estrutura da Page1 (Consulta)
    * Fase 3/8: so a faixa do cabecalho + container vazio para o
    * CommandGroup grp_operacao (Cadastro/Movimento/Sair do legado, Fase 4).
    * Campos de filtro (Grupo/Conta/CPF, periodo, moeda, empresa) vem nas
    * Fases 5-6.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag, loc_oCab

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Faixa do cabecalho - PRIMEIRO AddObject da pagina (regra #11/#39):
        *-- containers de botao ficam em Top=29..33 (dentro da faixa) e tem
        *-- de ser criados DEPOIS para desenhar por cima.
        loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPag.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .SpecialEffect = 0
            .BackColor     = RGB(100, 100, 100)

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
            ENDWITH
        ENDWITH

        *-- Container do CommandGroup grp_operacao (legado: Left=554, Top=-1,
        *-- Width=254, Height=110, ButtonCount=3).
        loc_oPag.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPag.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 254
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- CommandGroup grp_operacao - Cadastro/Movimento/Sair. No legado
        *-- cada Buttons(N) tem Click proprio (comportamento.json): Button1
        *-- valida Grupo/Conta/CPF e exibe o cadastro do fornecedor
        *-- consultado, Button2 vai direto para a analise de movimento,
        *-- Button3 eh "ThisForm.Release" (sair). A validacao + consulta
        *-- SQL dos Buttons 1/2 depende dos campos de filtro (Fases 5-6) e
        *-- eh ligada em THIS.ExecutarConsulta<X>() nas Fases 7-8; aqui so
        *-- a navegacao entre paginas (AlternarPagina) ja fica funcional.
        loc_oPag.cnt_4c_Botoes.AddObject("cmg_4c_Operacao", "CommandGroup")
        WITH loc_oPag.cnt_4c_Botoes.cmg_4c_Operacao
            .Top         = 0
            .Left        = 0
            .Width       = 254
            .Height      = 85
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.

            *-- Caption / Left / Picture / Fonte TRANSCRITOS do dump (regra
            *-- #25: o alvo do .Picture vem do legado, nunca de palpite
            *-- semantico). Fonte Tahoma, nao "Comic Sans MS": o Comic Sans
            *-- eh do bloco CRUD canonico do frmcadastro, e este form eh
            *-- OPERACIONAL - o SCX declara Tahoma nos tres botoes.
            WITH .Buttons(3)
                .Caption    = "Dados " + CHR(60) + "Cadastrais"
                .Top        = 5
                .Left       = 16
                .Width      = 75
                .Height     = 75
                .FontName   = "Tahoma"
                .FontSize   = 8
                .WordWrap   = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "geral_usuarios_60.jpg"
            ENDWITH

            WITH .Buttons(1)
                .Caption    = CHR(60) + "Movimenta" + CHR(231) + CHR(227) + "o"
                .Top        = 5
                .Left       = 92
                .Width      = 75
                .Height     = 75
                .FontName   = "Tahoma"
                .FontSize   = 7
                .WordWrap   = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "geral_arquivo_60.jpg"
            ENDWITH

            WITH .Buttons(2)
                .Caption    = "Encerrar"
                .Top        = 5
                .Left       = 168
                .Width      = 75
                .Height     = 75
                .FontName   = "Tahoma"
                .FontSize   = 8
                .WordWrap   = .T.
                .Cancel     = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            ENDWITH
        ENDWITH

        *-- A ordem dos Buttons segue a do legado (Command1 = cmd_movimenta,
        *-- Command2 = cmd_cancela, Command3 = cmd_cadastro) - o que o usuario
        *-- ve da esquerda para a direita vem do .Left, nao do indice.
        BINDEVENT(loc_oPag.cnt_4c_Botoes.cmg_4c_Operacao.Buttons(3), "Click", THIS, "BtnCadastroClick")
        BINDEVENT(loc_oPag.cnt_4c_Botoes.cmg_4c_Operacao.Buttons(1), "Click", THIS, "BtnMovimentoClick")
        BINDEVENT(loc_oPag.cnt_4c_Botoes.cmg_4c_Operacao.Buttons(2), "Click", THIS, "BtnCancelarClick")

        *-- FASE 6/8: campos de filtro da Pagina Consulta (shp_principal +
        *-- Label1/2/3/5/6/7 + Opt_Analise + Get_Datai/Dataf/Moeda/Empresa +
        *-- container Origem com Get_grupo/Get_conta/Get_dconta/Get_cpf).
        *-- Todos com os lookups do legado (fAcessoContab/fAcessoContas,
        *-- ja portados em utils\functions.prg, e FormBuscaAuxiliar para
        *-- Moeda/Empresa/Cpf - fAcessoEmpresa NAO foi portada, regra
        *-- CLAUDE.md "fAcessoEmpresa() NAO EXISTE").
        loc_oPag.AddObject("shp_4c_Shp_principal", "Shape")
        WITH loc_oPag.shp_4c_Shp_principal
            .Top           = 296
            .Left          = 92
            .Width         = 615
            .Height        = 69
            .BackStyle     = 0
            .SpecialEffect = 1
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag.lbl_4c_Label2
            .Top       = 313
            .Left      = 146
            .Width     = 51
            .Height    = 28
            .FontName  = "Tahoma"
            .FontSize  = 8
            .WordWrap  = .T.
            .Alignment = 1
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "An" + CHR(225) + "lise de Vendas :"
        ENDWITH

        loc_oPag.AddObject("obj_4c_Opt_Analise", "OptionGroup")
        WITH loc_oPag.obj_4c_Opt_Analise
            .Top           = 309
            .Left          = 214
            .Width         = 56
            .Height        = 46
            .ButtonCount   = 2
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 188, 189)
            .Value         = 2

            WITH .Buttons(1)
                .Caption   = "Sim"
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .Top       = 5
                .Left      = 7
                .Width     = 42
                .Height    = 17
                .ForeColor = RGB(36, 84, 155)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .Top       = 22
                .Left      = 7
                .Width     = 42
                .Height    = 17
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPag.obj_4c_Opt_Analise, "InteractiveChange", THIS, "OptAnaliseChange")

        loc_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag.lbl_4c_Label1
            .Top       = 309
            .Left      = 296
            .Width     = 45
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Per" + CHR(237) + "odo :"
        ENDWITH

        loc_oPag.AddObject("txt_4c_Datai", "TextBox")
        WITH loc_oPag.txt_4c_Datai
            .Top      = 306
            .Left     = 368
            .Width    = 88
            .Height   = 23
            .FontName = "Courier New"
            .Alignment = 3
            .Value    = {}
            .Format   = "K!"
        ENDWITH
        BINDEVENT(loc_oPag.txt_4c_Datai, "KeyPress", THIS, "ValidarDataI")

        loc_oPag.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPag.lbl_4c_Label7
            .Top       = 309
            .Left      = 349
            .Width     = 14
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "de"
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPag.lbl_4c_Label6
            .Top       = 334
            .Left      = 346
            .Width     = 18
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "at" + CHR(233)
        ENDWITH

        loc_oPag.AddObject("txt_4c_Dataf", "TextBox")
        WITH loc_oPag.txt_4c_Dataf
            .Top      = 332
            .Left     = 368
            .Width    = 88
            .Height   = 23
            .FontName = "Courier New"
            .Alignment = 3
            .Value    = {}
            .Format   = "K!"
        ENDWITH
        BINDEVENT(loc_oPag.txt_4c_Dataf, "KeyPress", THIS, "ValidarDataF")

        loc_oPag.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPag.lbl_4c_Label3
            .Top       = 310
            .Left      = 511
            .Width     = 41
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Moeda :"
        ENDWITH

        loc_oPag.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPag.txt_4c_Moeda
            .Top        = 306
            .Left       = 555
            .Width      = 36
            .Height     = 23
            .FontName   = "Courier New"
            .FontItalic = .F.
            .Alignment  = 0
            .Format     = "K"
            .InputMask  = "!!!"
            .MaxLength  = 3
            .Value      = ""
        ENDWITH
        BINDEVENT(loc_oPag.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoeda")

        loc_oPag.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPag.lbl_4c_Label5
            .Top       = 336
            .Left      = 502
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Empresa :"
        ENDWITH

        loc_oPag.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPag.txt_4c_Empresa
            .Top       = 332
            .Left      = 555
            .Width     = 36
            .Height    = 23
            .FontName  = "Courier New"
            .Alignment = 3
            .Value     = ""
            .MaxLength   = 3
        ENDWITH
        BINDEVENT(loc_oPag.txt_4c_Empresa, "KeyPress", THIS, "ValidarEmpresa")

        *-- Container Origem - Grupo/Conta do fornecedor pesquisado
        loc_oPag.AddObject("cnt_4c_Origem", "Container")
        WITH loc_oPag.cnt_4c_Origem
            .Top       = 239
            .Left      = 92
            .Width     = 615
            .Height    = 40
            .BackStyle = 0

            .AddObject("lbl_4c__Origem1", "Label")
            WITH .lbl_4c__Origem1
                .Top       = 2
                .Left      = 6
                .FontBold  = .T.
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Grupo / Conta"
            ENDWITH

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top       = 17
                .Left      = 87
                .Width     = 11
                .Height    = 15
                .FontBold  = .T.
                .Caption   = " : "
            ENDWITH

            .AddObject("txt_4c_Grupo", "TextBox")
            WITH .txt_4c_Grupo
                .Top       = 15
                .Left      = 7
                .Width     = 80
                .Height    = 21
                .FontBold  = .T.
                .Alignment = 3
                .Margin    = 0
                .InputMask = "XXXXXXXXXX"
                .MaxLength = 10
                .DisabledBackColor = RGB(255, 255, 255)
                .Value     = ""
            ENDWITH
            BINDEVENT(.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")

            .AddObject("lbl_4c_Label2", "Label")
            WITH .lbl_4c_Label2
                .Top       = 2
                .Left      = 107
                .FontBold  = .F.
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Conta"
            ENDWITH

            .AddObject("txt_4c_Conta", "TextBox")
            WITH .txt_4c_Conta
                .Top       = 15
                .Left      = 97
                .Width     = 80
                .Height    = 21
                .Margin    = 0
                .InputMask = "XXXXXXXXXX"
                .MaxLength = 10
                .DisabledBackColor = RGB(255, 255, 255)
                .Value     = ""
            ENDWITH
            BINDEVENT(.txt_4c_Conta, "KeyPress", THIS, "ValidarConta")

            .AddObject("lbl_4c__CPF", "Label")
            WITH .lbl_4c__CPF
                .Top       = 2
                .Left      = 183
                .FontBold  = .F.
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "CPF / CGC"
            ENDWITH

            .AddObject("txt_4c_Cpf", "TextBox")
            WITH .txt_4c_Cpf
                .Top       = 15
                .Left      = 181
                .Width     = 146
                .Height    = 21
                .Margin    = 0
                .InputMask = "XXXXXXXXXXXXXXXXXXXX"
                .MaxLength = 20
                .DisabledBackColor = RGB(255, 255, 255)
                .Value     = ""
            ENDWITH
            BINDEVENT(.txt_4c_Cpf, "KeyPress", THIS, "ValidarCpf")

            .AddObject("lbl_4c__dConta", "Label")
            WITH .lbl_4c__dConta
                .Top       = 2
                .Left      = 332
                .FontBold  = .F.
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Nome"
            ENDWITH

            .AddObject("txt_4c_Dconta", "TextBox")
            WITH .txt_4c_Dconta
                .Top       = 15
                .Left      = 330
                .Width     = 278
                .Height    = 21
                .Margin    = 0
                .InputMask = REPLICATE("X", 40)
                .MaxLength = 40
                .DisabledBackColor = RGB(255, 255, 255)
                .Value     = ""
            ENDWITH
            BINDEVENT(.txt_4c_Dconta, "KeyPress", THIS, "ValidarDConta")
        ENDWITH

        *-- Estado inicial dos campos de analise (legado: Opt_Analise.Value=2
        *-- "Nao" por default -> Data/Moeda/Empresa comecam desabilitados -
        *-- regra do When "Return(Opt_Analise.Value = 1)")
        THIS.OptAnaliseChange()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Estrutura base da Page2 (Resultado)
    * Fase 3/8: so a faixa do cabecalho (regra #11, repetida nas duas
    * paginas) + container vazio para os botoes de acao (grp_operacao +
    * Cmd_MudaFor/Cmd_MudaMov do legado, que alternam entre a aba Cadastro
    * e a aba Movimento - entram na Fase 4).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag, loc_oCab

        loc_oPag = THIS.pgf_4c_Paginas.Page2

        loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPag.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BorderWidth   = 0
            .SpecialEffect = 0
            .BackColor     = RGB(100, 100, 100)

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
            ENDWITH
        ENDWITH

        *-- cnt_4c_Cadastro - Cadastro.Dados do legado (dados cadastrais do
        *-- fornecedor pesquisado). PageFrame "Cadastro" legado tem
        *-- pagina unica ("Dados"), sem abas visiveis - replicado como
        *-- Container simples. Top compensado (+29): legado Top=155 ->
        *-- 184. Left/Width/Height identicos ao legado (Left=59,
        *-- Width=701, Height=421). FASE 5/8: primeiros 50% dos campos
        *-- (Codigo/Nome/Endereco/Bairro completos + labels de Cep/
        *-- Cidade/Estado/Telefone 1 - os TextBoxes correspondentes e o
        *-- restante dos campos/foto entram na Fase 6/8).
        loc_oPag.AddObject("cnt_4c_Cadastro", "Container")
        WITH loc_oPag.cnt_4c_Cadastro
            .Top         = 184
            .Left        = 59
            .Width       = 701
            .Height      = 421
            .BackStyle   = 0
            .BorderWidth = 0

            *-- Shape1 legado - moldura ao redor de Codigo/Nome
            .AddObject("shp_4c_Dados", "Shape")
            WITH .shp_4c_Dados
                .Top    = 16
                .Left   = 24
                .Width  = 384
                .Height = 68
            ENDWITH

            *-- shpFigura legado - moldura ao redor da foto do
            *-- fornecedor (olebcFigura/ImgFigJpg entram na Fase 6/8)
            .AddObject("shp_4c_Figura", "Shape")
            WITH .shp_4c_Figura
                .Top    = 16
                .Left   = 489
                .Width  = 184
                .Height = 144
            ENDWITH

            *-- Say1 "Codigo : " / Get_codfor
            .AddObject("lbl_4c_Codigo", "Label")
            WITH .lbl_4c_Codigo
                .Top       = 28
                .Left      = 54
                .Width     = 60
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "C" + CHR(243) + "digo :"
            ENDWITH

            .AddObject("txt_4c_CodFor", "TextBox")
            WITH .txt_4c_CodFor
                .Top      = 25
                .Left     = 101
                .Width    = 80
                .Height   = 21
                .Value    = ""
                .ReadOnly = .T.
                .TabStop  = .F.
            ENDWITH

            *-- Say2 "Nome : " / Get_nome
            .AddObject("lbl_4c_Nome", "Label")
            WITH .lbl_4c_Nome
                .Top       = 54
                .Left      = 60
                .Width     = 45
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Nome :"
            ENDWITH

            .AddObject("txt_4c_Nome", "TextBox")
            WITH .txt_4c_Nome
                .Top      = 51
                .Left     = 101
                .Width    = 290
                .Height   = 21
                .Value    = ""
                .ReadOnly = .T.
                .TabStop  = .F.
            ENDWITH

            *-- Say3 "Endereco : " / Get_end
            .AddObject("lbl_4c_End", "Label")
            WITH .lbl_4c_End
                .Top       = 100
                .Left      = 41
                .Width     = 70
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Endere" + CHR(231) + "o :"
            ENDWITH

            .AddObject("txt_4c_End", "TextBox")
            WITH .txt_4c_End
                .Top      = 95
                .Left     = 101
                .Width    = 290
                .Height   = 21
                .Value    = ""
                .ReadOnly = .T.
                .TabStop  = .F.
            ENDWITH

            *-- Say4 "Bairro : " / Get_bairro
            .AddObject("lbl_4c_Bairro", "Label")
            WITH .lbl_4c_Bairro
                .Top       = 127
                .Left      = 58
                .Width     = 53
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Bairro :"
            ENDWITH

            .AddObject("txt_4c_Bairro", "TextBox")
            WITH .txt_4c_Bairro
                .Top      = 124
                .Left     = 101
                .Width    = 150
                .Height   = 21
                .Value    = ""
                .ReadOnly = .T.
                .TabStop  = .F.
            ENDWITH

            *-- Say5 "Cep : " (TextBox Get_cep entra na Fase 6/8)
            .AddObject("lbl_4c_Cep", "Label")
            WITH .lbl_4c_Cep
                .Top       = 127
                .Left      = 328
                .Width     = 34
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Cep :"
            ENDWITH

            *-- Say6 "Cidade : " (TextBox Get_cid entra na Fase 6/8)
            .AddObject("lbl_4c_Cidade", "Label")
            WITH .lbl_4c_Cidade
                .Top       = 154
                .Left      = 53
                .Width     = 58
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Cidade :"
            ENDWITH

            *-- Say7 "Estado : " (TextBox Get_est entra na Fase 6/8)
            .AddObject("lbl_4c_Estado", "Label")
            WITH .lbl_4c_Estado
                .Top       = 154
                .Left      = 314
                .Width     = 58
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Estado :"
            ENDWITH

            *-- Say8 "Telefone 1 : " / Get_tel1
            .AddObject("lbl_4c_Tel1", "Label")
            WITH .lbl_4c_Tel1
                .Top       = 182
                .Left      = 35
                .Width     = 76
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Telefone 1 :"
            ENDWITH

            .AddObject("txt_4c_Tel1", "TextBox")
            WITH .txt_4c_Tel1
                .Top      = 179
                .Left     = 101
                .Width    = 150
                .Height   = 21
                .Value    = ""
                .ReadOnly = .T.
                .TabStop  = .F.
            ENDWITH

            *-- Say9 "Telefone 2 : " / Get_tel2
            .AddObject("lbl_4c_Tel2", "Label")
            WITH .lbl_4c_Tel2
                .Top       = 210
                .Left      = 35
                .Width     = 76
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Telefone 2 :"
            ENDWITH

            .AddObject("txt_4c_Tel2", "TextBox")
            WITH .txt_4c_Tel2
                .Top      = 207
                .Left     = 101
                .Width    = 150
                .Height   = 21
                .Value    = ""
                .ReadOnly = .T.
                .TabStop  = .F.
            ENDWITH

            *-- Say10 "Fax : " / Get_fax
            .AddObject("lbl_4c_Fax", "Label")
            WITH .lbl_4c_Fax
                .Top       = 237
                .Left      = 68
                .Width     = 35
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Fax :"
            ENDWITH

            .AddObject("txt_4c_Fax", "TextBox")
            WITH .txt_4c_Fax
                .Top      = 234
                .Left     = 101
                .Width    = 150
                .Height   = 21
                .Value    = ""
                .ReadOnly = .T.
                .TabStop  = .F.
            ENDWITH

            *-- Say11 "C.G.C : " / Get_cgc
            .AddObject("lbl_4c_Cgc", "Label")
            WITH .lbl_4c_Cgc
                .Top       = 182
                .Left      = 318
                .Width     = 44
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "C.G.C :"
            ENDWITH

            .AddObject("txt_4c_Cgc", "TextBox")
            WITH .txt_4c_Cgc
                .Top      = 179
                .Left     = 362
                .Width    = 150
                .Height   = 21
                .Value    = ""
                .ReadOnly = .T.
                .TabStop  = .F.
            ENDWITH

            *-- Say12 "I.E. : " / Get_ie
            .AddObject("lbl_4c_Ie", "Label")
            WITH .lbl_4c_Ie
                .Top       = 210
                .Left      = 329
                .Width     = 33
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "I.E. :"
            ENDWITH

            .AddObject("txt_4c_Ie", "TextBox")
            WITH .txt_4c_Ie
                .Top      = 207
                .Left     = 362
                .Width    = 150
                .Height   = 21
                .Value    = ""
                .ReadOnly = .T.
                .TabStop  = .F.
            ENDWITH

            *-- Get_cep (label lbl_4c_Cep ja criada na Fase 5)
            .AddObject("txt_4c_Cep", "TextBox")
            WITH .txt_4c_Cep
                .Top      = 124
                .Left     = 362
                .Width    = 73
                .Height   = 21
                .Value    = ""
                .ReadOnly = .T.
                .TabStop  = .F.
            ENDWITH

            *-- Get_cid (label lbl_4c_Cidade ja criada na Fase 5)
            .AddObject("txt_4c_Cid", "TextBox")
            WITH .txt_4c_Cid
                .Top      = 151
                .Left     = 101
                .Width    = 185
                .Height   = 21
                .Value    = ""
                .ReadOnly = .T.
                .TabStop  = .F.
            ENDWITH

            *-- Get_est (label lbl_4c_Estado ja criada na Fase 5)
            .AddObject("txt_4c_Est", "TextBox")
            WITH .txt_4c_Est
                .Top      = 151
                .Left     = 362
                .Width    = 24
                .Height   = 21
                .Value    = ""
                .ReadOnly = .T.
                .TabStop  = .F.
            ENDWITH

            *-- olebcFigura/ImgFigJpg - foto do fornecedor (shpFigura ja
            *-- criada na Fase 5). SigCdCli nao tem coluna de foto no
            *-- schema canonico (figjpgs/figuras pertencem a outras
            *-- tabelas) - o BO nunca popula a imagem; permanece apenas o
            *-- aviso "Foto nao disponivel", igual ao estado padrao do
            *-- legado quando TmpPro/figjpgs vem vazio.
            .AddObject("img_4c_Figura", "Image")
            WITH .img_4c_Figura
                .Top      = 20
                .Left     = 494
                .Width    = 174
                .Height   = 136
                .Stretch  = 1
                .Visible  = .F.
            ENDWITH

            .AddObject("lbl_4c_MsgFoto", "Label")
            WITH .lbl_4c_MsgFoto
                .Top       = 64
                .Left      = 518
                .Width     = 111
                .Height    = 15
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Foto n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            ENDWITH
        ENDWITH

        *-- Container dos botoes de acao da Page2 (grp_operacao/Cmd_MudaFor/
        *-- Cmd_MudaMov do legado).
        loc_oPag.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPag.cnt_4c_BotoesAcao
            .Top         = 29
            .Left        = 716
            .Width       = 160
            .Height      = 110
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- grp_operacao (legado: Left=716,Top=-1,W=90,H=110,ButtonCount=1)
        *-- - botao unico "Voltar" (Click legado: If ThisForm.Automatico /
        *-- ThisForm.Release / Else / ThisForm.Fld_Principal.ActivePage=1).
        loc_oPag.cnt_4c_BotoesAcao.AddObject("cmg_4c_Operacao", "CommandGroup")
        WITH loc_oPag.cnt_4c_BotoesAcao.cmg_4c_Operacao
            .Top         = 0
            .Left        = 0
            .Width       = 90
            .Height      = 85
            .ButtonCount = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.

            WITH .Buttons(1)
                .Caption    = "Voltar"
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontBold   = .T.
                .FontItalic = .T.
                .FontSize   = 8
                .Cancel     = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmg_4c_Operacao.Buttons(1), "Click", THIS, "BtnVoltarClick")

        *-- Cmd_MudaFor / Cmd_MudaMov (legado: Top=101,Left=629/671,W=50,
        *-- H=50,ButtonCount=1 cada) - alternam a exibicao entre a
        *-- sub-pagina Cadastro e a sub-pagina Movimento/Result da Page2
        *-- (Top compensado +29 pelo PageFrame.Top=-29). Os containers
        *-- Cadastro/Result ainda nao existem (entram quando as paginas
        *-- internas forem construidas) - os handlers ja alternam a
        *-- visibilidade entre os dois botoes, igual ao legado
        *-- (Cmd_MudaFor.Click/Cmd_MudaMov.Click trocam Enabled/Visible um
        *-- do outro); a troca de Cadastro.Visible/Result.Visible eh
        *-- concluida quando esses containers existirem.
        loc_oPag.AddObject("cmg_4c_MudaFor", "CommandGroup")
        WITH loc_oPag.cmg_4c_MudaFor
            .Top         = 130
            .Left        = 629
            .Width       = 50
            .Height      = 50
            .ButtonCount = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Visible     = .F.

            *-- Legado Cmd_MudaFor.Command1 (cmd_cadastro): botao SO de icone,
            *-- Caption vazio, ToolTipText "Dados Cadastrais", Verdana 8.
            WITH .Buttons(1)
                .Caption     = ""
                .Top         = 5
                .Left        = 5
                .Width       = 40
                .Height      = 40
                .FontName    = "Verdana"
                .FontSize    = 8
                .WordWrap    = .T.
                .ToolTipText = "Dados Cadastrais"
                .ForeColor   = RGB(36, 84, 155)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .T.
                .Picture         = gc_4c_CaminhoIcones + "profile_add.ico"
                .DisabledPicture = gc_4c_CaminhoIcones + "profile_add.ico"
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPag.cmg_4c_MudaFor.Buttons(1), "Click", THIS, "BtnMudaForClick")

        loc_oPag.AddObject("cmg_4c_MudaMov", "CommandGroup")
        WITH loc_oPag.cmg_4c_MudaMov
            .Top         = 130
            .Left        = 671
            .Width       = 50
            .Height      = 50
            .ButtonCount = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.

            *-- Legado Cmd_MudaMov.Command1 (cmd_movimenta): idem, ToolTipText
            *-- "Movimentacao".
            WITH .Buttons(1)
                .Caption     = ""
                .Top         = 5
                .Left        = 5
                .Width       = 40
                .Height      = 40
                .FontName    = "Verdana"
                .FontSize    = 8
                .WordWrap    = .T.
                .ToolTipText = "Movimenta" + CHR(231) + CHR(227) + "o"
                .ForeColor   = RGB(36, 84, 155)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .T.
                .Picture         = gc_4c_CaminhoIcones + "coins.ico"
                .DisabledPicture = gc_4c_CaminhoIcones + "coins.ico"
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPag.cmg_4c_MudaMov.Buttons(1), "Click", THIS, "BtnMudaMovClick")

        *-- PageFrame Result (5 sub-paginas) + container ImprimeOpcoes
        THIS.ConfigurarPaginaResultado(loc_oPag)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaResultado - PageFrame "Result" do legado, com as 5
    * sub-paginas de resultado da consulta, e o container ImprimeOpcoes.
    *
    * As paginas sao criadas na ordem do PageOrder do legado (Saldo=1,
    * Pendencias=2, Movimentacao=3, Estoque=4, Consertos=5), NAO na ordem em
    * que o SCX declara os objetos (Saldo, Movimenta, Estoque, Pendencias,
    * Conserto): ActivePage eh o PageOrder, nao a ordem de declaracao, e eh o
    * PageOrder que o usuario ve na fileira de abas.
    *
    * Top do PageFrame compensado (+29 pelo pgf_4c_Paginas.Top = -29): legado
    * 157 -> 186. Dentro dele os Tops sao relativos a cada Page e vao CRUS do
    * dump, sem compensacao.
    *
    * Os grids sao ligados aos cursores AQUI porque os 8 cursores locais ja
    * existem neste ponto: o BO eh instanciado no inicio de InicializarForm e
    * cria todos em InicializarCursoresDados. Column.Width vem DEPOIS de
    * RecordSource/ControlSource, que resetam a largura para o default 90.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaResultado(par_oPag)
        LOCAL loc_oPgf

        par_oPag.AddObject("pgf_4c_Result", "PageFrame")
        loc_oPgf = par_oPag.pgf_4c_Result

        WITH loc_oPgf
            .PageCount = 5
            .Top       = 186
            .Left      = 59
            .Width     = 701
            .Height    = 421
            .Tabs      = .T.

            .Page1.Caption   = "Saldo"
            .Page1.FontName  = "Tahoma"
            .Page1.FontSize  = 8
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.ForeColor = RGB(90, 90, 90)

            .Page2.Caption   = "Pend" + CHR(234) + "ncias"
            .Page2.FontName  = "Tahoma"
            .Page2.FontSize  = 8
            .Page2.BackColor = RGB(255, 255, 255)
            .Page2.ForeColor = RGB(90, 90, 90)

            .Page3.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Page3.FontName  = "Tahoma"
            .Page3.FontSize  = 8
            .Page3.BackColor = RGB(255, 255, 255)
            .Page3.ForeColor = RGB(90, 90, 90)

            .Page4.Caption   = "Estoque"
            .Page4.FontName  = "Tahoma"
            .Page4.FontSize  = 8
            .Page4.BackColor = RGB(255, 255, 255)
            .Page4.ForeColor = RGB(90, 90, 90)

            .Page5.Caption   = "Consertos"
            .Page5.FontName  = "Tahoma"
            .Page5.FontSize  = 8
            .Page5.BackColor = RGB(255, 255, 255)
            .Page5.ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.ConfigurarAbaSaldo(loc_oPgf.Page1)
        THIS.ConfigurarAbaPendencias(loc_oPgf.Page2)
        THIS.ConfigurarAbaMovimentacao(loc_oPgf.Page3)
        THIS.ConfigurarAbaEstoque(loc_oPgf.Page4)
        THIS.ConfigurarAbaConsertos(loc_oPgf.Page5)

        loc_oPgf.ActivePage = 1

        *-- Inicio: a Pagina Resultado abre no bloco Cadastro (o legado so
        *-- mostra o Result depois do botao Movimentacao), por isso o
        *-- PageFrame nasce oculto - BtnMovimentoClick / BtnMudaMovClick o
        *-- revelam. Entra na lista de excecao de TornarControlesVisiveis.
        loc_oPgf.Visible = .F.
        loc_oPgf.Enabled = .F.

        THIS.ConfigurarImprimeOpcoes(par_oPag)
    ENDPROC

    *==========================================================================
    * FormatarGradeResultado - propriedades comuns a todas as grades de
    * resultado (todas somente-leitura, sem marcador de registro/exclusao e
    * com a cor de linha de grade do legado).
    *==========================================================================
    PROTECTED PROCEDURE FormatarGradeResultado(par_oGrid)
        WITH par_oGrid
            .ReadOnly         = .T.
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .ScrollBars       = 2
            .RecordSourceType = 1
            .GridLineColor    = RGB(238, 238, 238)
            .FontName         = "Tahoma"
            .FontSize         = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAbaSaldo - Page "Saldo" do Result: historico de conta corrente
    * (grade FILHA da grade de saldos pela moeda), saldo por moeda, os dois
    * campos de historico da linha corrente e o botao de impressao do extrato.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaSaldo(par_oPage)
        *-- shp_historico / shp_saldo / Shape1 - molduras do legado
        par_oPage.AddObject("shp_4c_MoldHistorico", "Shape")
        WITH par_oPage.shp_4c_MoldHistorico
            .Top           = 21
            .Left          = 9
            .Width         = 664
            .Height        = 233
            .BackStyle     = 0
            .SpecialEffect = 1
        ENDWITH

        par_oPage.AddObject("shp_4c_MoldSaldo", "Shape")
        WITH par_oPage.shp_4c_MoldSaldo
            .Top           = 267
            .Left          = 9
            .Width         = 165
            .Height        = 125
            .BackStyle     = 0
            .SpecialEffect = 1
        ENDWITH

        par_oPage.AddObject("shp_4c_MoldHists", "Shape")
        WITH par_oPage.shp_4c_MoldHists
            .Top           = 267
            .Left          = 182
            .Width         = 411
            .Height        = 59
            .BackStyle     = 0
            .SpecialEffect = 1
        ENDWITH

        *-- Labels (AutoSize = .F. + Width/Height explicitos: AutoSize eh
        *-- no-op em Label criado por AddObject)
        par_oPage.AddObject("lbl_4c_TitHistorico", "Label")
        WITH par_oPage.lbl_4c_TitHistorico
            .Top        = 6
            .Left       = 14
            .Width      = 141
            .Height     = 15
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .BackStyle  = 0
            .Alignment  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Hist" + CHR(243) + "rico Conta Corrente"
        ENDWITH

        par_oPage.AddObject("lbl_4c_TitSaldo", "Label")
        WITH par_oPage.lbl_4c_TitSaldo
            .Top        = 254
            .Left       = 13
            .Width      = 96
            .Height     = 15
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .BackStyle  = 0
            .Alignment  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Saldo por Moeda"
        ENDWITH

        par_oPage.AddObject("lbl_4c_TitHists", "Label")
        WITH par_oPage.lbl_4c_TitHists
            .Top        = 254
            .Left       = 192
            .Width      = 52
            .Height     = 15
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .BackStyle  = 0
            .Alignment  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Hist" + CHR(243) + "rico"
        ENDWITH

        *-- Grades. A configuracao das COLUNAS fica em
        *-- ConfigurarGradesSaldo(), porque o legado a refaz a cada clique em
        *-- Movimentacao (o numero de colunas depende da permissao de SALDO).
        par_oPage.AddObject("grd_4c_Historico", "Grid")
        WITH par_oPage.grd_4c_Historico
            .Top    = 27
            .Left   = 14
            .Width  = 653
            .Height = 220
            .RecordMark   = .F.
            .DeleteMark   = .F.
        ENDWITH

        par_oPage.AddObject("grd_4c_Saldo", "Grid")
        WITH par_oPage.grd_4c_Saldo
            .Top    = 274
            .Left   = 14
            .Width  = 156
            .Height = 112
            .RecordMark   = .F.
            .DeleteMark   = .F.
        ENDWITH

        *-- Get_Hists / Get_Hist2s: exibem o historico da linha corrente da
        *-- grade. ReadOnly porque o When do legado devolve .F. (o campo
        *-- nunca recebe foco).
        par_oPage.AddObject("txt_4c_Hists", "TextBox")
        WITH par_oPage.txt_4c_Hists
            .Top           = 276
            .Left          = 187
            .Width         = 401
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .ControlSource = "cursor_4c_Historico.hists"
        ENDWITH

        par_oPage.AddObject("txt_4c_Hist2s", "TextBox")
        WITH par_oPage.txt_4c_Hist2s
            .Top           = 299
            .Left          = 187
            .Width         = 401
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ReadOnly      = .T.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .ControlSource = "cursor_4c_Historico.hist2s"
        ENDWITH

        *-- btnImprimir: abre o relatorio SigReCgc do fornecedor (legado:
        *-- "Do Form SigReCgc With Get_Grupo.Value, Get_Conta.Value")
        par_oPage.AddObject("cmd_4c_ImprimirExtrato", "CommandButton")
        WITH par_oPage.cmd_4c_ImprimirExtrato
            .Top             = 277
            .Left            = 618
            .Width           = 40
            .Height          = 40
            .FontName        = "Verdana"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = ""
            .ToolTipText     = "Imprimir"
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
        ENDWITH
        BINDEVENT(par_oPage.cmd_4c_ImprimirExtrato, "Click", THIS, "BtnImprimirExtratoClick")

        BINDEVENT(par_oPage.grd_4c_Saldo, "AfterRowColChange", THIS, "GradeSaldoAfterRowColChange")
        BINDEVENT(par_oPage.grd_4c_Historico, "AfterRowColChange", THIS, "GradeHistoricoAfterRowColChange")

        THIS.ConfigurarGradesSaldo()
    ENDPROC

    *==========================================================================
    * ConfigurarGradesSaldo - (re)configura grd_4c_Saldo e grd_4c_Historico.
    *
    * O legado faz isso DENTRO do cmd_movimenta.Click, e nao no SCX, porque o
    * numero de colunas depende da permissao: com acesso ao saldo a grade de
    * historico tem 8 colunas (inclui Saldo) e a de moedas tem 2; sem acesso,
    * 7 e 1, a moldura encolhe 94px e o titulo muda de "Saldo por Moeda" para
    * "Moedas". Como mexer em ColumnCount RECRIA os objetos Column, toda a
    * configuracao (ControlSource / Width / Header) eh refeita aqui - e a
    * Width sempre DEPOIS do ControlSource, que a reseta para o default 90.
    *
    * llSaldo transcrito do legado:
    *     llSaldo = !fChecaAcesso('SIGOPCGC','SALDO') Or llSupervis
    * ATENCAO: o "!" eh do legado e esta preservado (regra #17 - nao inverter
    * sinal de regra de negocio). Como fChecaAcesso em utils\functions.prg eh
    * um stub que devolve SEMPRE .T., o efeito pratico hoje eh: coluna Saldo
    * visivel apenas para o usuario 4CONTROL. Se a intencao do negocio for o
    * contrario, a correcao eh de UMA linha aqui - mas inverter sem confirmar
    * exporia saldo financeiro a quem o legado esconde.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradesSaldo()
        LOCAL loc_oPage, loc_oGrdH, loc_oGrdS, loc_lSaldo, loc_lSupervis, loc_nCol

        loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1
        loc_oGrdH = loc_oPage.grd_4c_Historico
        loc_oGrdS = loc_oPage.grd_4c_Saldo

        loc_lSupervis = .F.
        IF TYPE("gc_4c_UsuarioLogado") = "C"
            loc_lSupervis = (UPPER(ALLTRIM(gc_4c_UsuarioLogado)) == "4CONTROL")
        ENDIF
        loc_lSaldo    = !fChecaAcesso("SIGOPCGC", "SALDO") OR loc_lSupervis

        *---------------------------------------------------------------
        *-- Grade de HISTORICO (grade filha da grade de saldos)
        *---------------------------------------------------------------
        loc_oGrdH.ColumnCount  = IIF(loc_lSaldo, 8, 7)
        loc_oGrdH.ColumnCount = 3
        loc_oGrdH.RecordSource = "cursor_4c_Historico"
        WITH loc_oGrdH
            THIS.FormatarGradeResultado(loc_oGrdH)
            .Width          = 588
            .LinkMaster     = "cursor_4c_Saldo"
            .ChildOrder     = "moedata"
            .RelationalExpr = "moedas"

            THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Historico.emps", ;
                31, "Emp", 2, "", "")
            THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Historico.datas", ;
                80, "Data", 2, "", "")
            THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Historico.valors", ;
                94, "Valor", 2, "9,999,999.99", "9,999,999.99")
            THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Historico.opers", ;
                18, "O", 2, "", "")

            IF loc_lSaldo
                THIS.ConfigurarColunaResultado(.Column5, "cursor_4c_Historico.saldos", ;
                    94, "Saldo", 2, "9,999,999.99", "9,999,999.99")
                THIS.ConfigurarColunaResultado(.Column6, "cursor_4c_Historico.vencs", ;
                    80, "Vencimento", 2, "", "")
                THIS.ConfigurarColunaResultado(.Column7, "cursor_4c_Historico.nfs", ;
                    80, "Nota", 2, "", "")
                THIS.ConfigurarColunaResultado(.Column8, ;
                    "IIF(cursor_4c_Historico.valors - cursor_4c_Historico.valpags = 0, '*', '')", ;
                    20, "Pg", 2, "", "")
            ELSE
                THIS.ConfigurarColunaResultado(.Column5, "cursor_4c_Historico.vencs", ;
                    80, "Vencimento", 2, "", "")
                THIS.ConfigurarColunaResultado(.Column6, "cursor_4c_Historico.nfs", ;
                    80, "Nota", 2, "", "")
                THIS.ConfigurarColunaResultado(.Column7, ;
                    "IIF(cursor_4c_Historico.valors - cursor_4c_Historico.valpags = 0, '*', '')", ;
                    20, "Pg", 2, "", "")
            ENDIF
        ENDWITH

        *---------------------------------------------------------------
        *-- Grade de SALDO POR MOEDA (grade mae)
        *---------------------------------------------------------------
        loc_oGrdS.ColumnCount  = IIF(loc_lSaldo, 2, 1)
        loc_oGrdS.ColumnCount = 3
        loc_oGrdS.RecordSource = "cursor_4c_Saldo"
        WITH loc_oGrdS
            THIS.FormatarGradeResultado(loc_oGrdS)
            .Width        = IIF(loc_lSaldo, 156, 156 - 94)

            THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Saldo.moedas", ;
                31, "M.", 2, "", "")

            IF loc_lSaldo
                THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Saldo.saldos", ;
                    94, "Saldo", 2, "", "")
            ENDIF
        ENDWITH

        *-- moldura e titulo acompanham o numero de colunas (legado)
        loc_oPage.shp_4c_MoldSaldo.Width = IIF(loc_lSaldo, 165, 165 - 94)
        loc_oPage.lbl_4c_TitSaldo.Caption = IIF(loc_lSaldo, "Saldo por Moeda", "Moedas")
    ENDPROC

    *==========================================================================
    * ConfigurarColunaResultado - aplica de uma vez as propriedades que toda
    * coluna de grade de resultado recebe. A Width eh atribuida DEPOIS do
    * ControlSource de proposito: mexer no ControlSource reseta a largura para
    * o default 90.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarColunaResultado(par_oCol, par_cFonte, ;
            par_nWidth, par_cCaption, par_nAlinhaHeader, par_cFormat, par_cMask)
        WITH par_oCol
            .ControlSource = par_cFonte
            .Width         = par_nWidth
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8

            IF !EMPTY(par_cFormat)
                .Format = par_cFormat
            ENDIF
            IF !EMPTY(par_cMask)
                .InputMask = par_cMask
            ENDIF

            .Header1.Caption   = par_cCaption
            .Header1.Alignment = par_nAlinhaHeader
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.ForeColor = RGB(90, 90, 90)

            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ReadOnly    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAbaPendencias - Page "Pendencias" do Result: parcelas e
    * lancamentos de conta corrente em aberto (cursor_4c_Parcela).
    *
    * Grid1 do legado (a grade de baixo) nasce Visible = .F. / Enabled = .F.
    * com TODAS as colunas invisiveis - eh um resto de layout que o legado
    * nunca mostra. Reproduzida para nao perder objeto da tela, e por isso
    * entra na lista de excecao de TornarControlesVisiveis.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaPendencias(par_oPage)
        LOCAL loc_oGrd

        par_oPage.AddObject("shp_4c_MoldPendencias", "Shape")
        WITH par_oPage.shp_4c_MoldPendencias
            .Top           = 17
            .Left          = 9
            .Width         = 663
            .Height        = 199
            .BackStyle     = 0
            .SpecialEffect = 1
        ENDWITH

        par_oPage.AddObject("lbl_4c_TitPendencias", "Label")
        WITH par_oPage.lbl_4c_TitPendencias
            .Top        = 3
            .Left       = 20
            .Width      = 66
            .Height     = 15
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .BackStyle  = 0
            .Alignment  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Pend" + CHR(234) + "ncias"
        ENDWITH

        par_oPage.AddObject("grd_4c_Pendente", "Grid")
        loc_oGrd = par_oPage.grd_4c_Pendente
        loc_oGrd.ColumnCount  = 4
        loc_oGrd.RecordSource = "cursor_4c_Parcela"
        WITH loc_oGrd
            .Top               = 23
            .Left              = 14
            .Width             = 652
            .Height            = 184
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            THIS.FormatarGradeResultado(loc_oGrd)

            THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Parcela.valos", ;
                77, "Valor", 2, "", "999,999,999.99")
            THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Parcela.moefpgs", ;
                30, "Moe", 2, "", "")
            THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Parcela.vencs", ;
                90, "Vecto", 2, "", "")
            THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Parcela.hists", ;
                370, "Tipo", 2, "", "")

            .Column1.ColumnOrder = 2
            .Column2.ColumnOrder = 3
            .Column3.ColumnOrder = 1
            .Column4.ColumnOrder = 4
        ENDWITH

        *-- Grid1 do legado: oculta e desabilitada, mantida por fidelidade
        par_oPage.AddObject("grd_4c_PendenteOculta", "Grid")
        loc_oGrd = par_oPage.grd_4c_PendenteOculta
        loc_oGrd.ColumnCount  = 5
        loc_oGrd.RecordSource = "cursor_4c_Parcela"
        WITH loc_oGrd
            .Top               = 222
            .Left              = 5
            .Width             = 557
            .Height            = 166
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            THIS.FormatarGradeResultado(loc_oGrd)

            THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Parcela.fpags", ;
                177, "Tipo", 2, "", "")
            THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Parcela.valos", ;
                77, "Valor", 2, "", "999,999,999.99")
            THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Parcela.moefpgs", ;
                30, "Moe", 2, "", "")
            THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Parcela.vencs", ;
                90, "Vecto", 2, "", "")
            THIS.ConfigurarColunaResultado(.Column5, "cursor_4c_Parcela.hists", ;
                192, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")

            .Column1.ColumnOrder = 4
            .Column3.ColumnOrder = 3
            .Column4.ColumnOrder = 1

            .Enabled = .F.
            .Visible = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAbaMovimentacao - Page "Movimentacao" do Result: grade de
    * produtos do fornecedor, total por operacao, operacoes do produto
    * selecionado (grade filha), filtro Ativo/Inativo/Ambos e o botao que
    * abre o painel de opcoes de impressao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaMovimentacao(par_oPage)
        LOCAL loc_oGrd

        par_oPage.AddObject("lbl_4c_TitProdutos", "Label")
        WITH par_oPage.lbl_4c_TitProdutos
            .Top        = 30
            .Left       = 3
            .Width      = 59
            .Height     = 15
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .BackStyle  = 0
            .Alignment  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = " Produtos "
        ENDWITH

        *-- Grd_Produto: 10 colunas, ColumnOrder do legado
        par_oPage.AddObject("grd_4c_Produto", "Grid")
        loc_oGrd = par_oPage.grd_4c_Produto
        loc_oGrd.ColumnCount  = 10
        loc_oGrd.RecordSource = "cursor_4c_ProdFor"
        WITH loc_oGrd
            .Top          = 44
            .Left         = 2
            .Width        = 690
            .Height       = 106
            THIS.FormatarGradeResultado(loc_oGrd)
            .RowHeight    = 17
            .Highlight    = .T.
            .HighlightRow = .T.

            THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_ProdFor.cpros", ;
                108, "Produto", 2, "", "")
            THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_ProdFor.custofs", ;
                70, "Custo", 2, "", "999,999,999.99")
            THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_ProdFor.moecusfs", ;
                21, "Moe", 2, "", "")
            THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_ProdFor.marca", ;
                10, "", 2, "", "")
            THIS.ConfigurarColunaResultado(.Column5, "cursor_4c_ProdFor.qtvend", ;
                70, "Qt. Vendas", 2, "", "999,999.999")
            THIS.ConfigurarColunaResultado(.Column6, "cursor_4c_ProdFor.vlvend", ;
                70, "Valor Vendas", 2, "", "99,999,999.99")
            THIS.ConfigurarColunaResultado(.Column7, "cursor_4c_ProdFor.estoque", ;
                70, "Estoque Atual", 2, "9999,999.999", "")
            THIS.ConfigurarColunaResultado(.Column8, "cursor_4c_ProdFor.pvens", ;
                79, "Pre" + CHR(231) + "o de Venda", 2, "", "999,999,999.99")
            THIS.ConfigurarColunaResultado(.Column9, "cursor_4c_ProdFor.moedas", ;
                21, "Moe", 2, "", "")
            THIS.ConfigurarColunaResultado(.Column10, "cursor_4c_ProdFor.reffs", ;
                141, "Ref.Fornec", 2, "", "")

            .Column1.ColumnOrder  = 2
            .Column1.FontBold     = .T.
            .Column1.Alignment    = 3
            .Column2.ColumnOrder  = 4
            .Column2.Alignment    = 3
            .Column3.ColumnOrder  = 5
            .Column4.ColumnOrder  = 1
            .Column5.ColumnOrder  = 6
            .Column6.ColumnOrder  = 7
            .Column7.ColumnOrder  = 8
            .Column8.ColumnOrder  = 9
            .Column9.ColumnOrder  = 10
            .Column10.ColumnOrder = 3
        ENDWITH

        *-- Click/DblClick dos headers ordenam a grade (ascendente /
        *-- descendente), igual ao legado
        BINDEVENT(loc_oGrd.Column1.Header1,  "Click",    THIS, "HeaderProdutoClick")
        BINDEVENT(loc_oGrd.Column1.Header1,  "DblClick", THIS, "HeaderProdutoDblClick")
        BINDEVENT(loc_oGrd.Column5.Header1,  "Click",    THIS, "HeaderQtVendClick")
        BINDEVENT(loc_oGrd.Column5.Header1,  "DblClick", THIS, "HeaderQtVendDblClick")
        BINDEVENT(loc_oGrd.Column6.Header1,  "Click",    THIS, "HeaderVlVendClick")
        BINDEVENT(loc_oGrd.Column6.Header1,  "DblClick", THIS, "HeaderVlVendDblClick")
        BINDEVENT(loc_oGrd.Column10.Header1, "Click",    THIS, "HeaderReffsClick")
        BINDEVENT(loc_oGrd.Column10.Header1, "DblClick", THIS, "HeaderReffsDblClick")

        *-- shp_produto / lbl_produto + Grd_Resumo (total por operacao)
        par_oPage.AddObject("shp_4c_MoldResumo", "Shape")
        WITH par_oPage.shp_4c_MoldResumo
            .Top           = 173
            .Left          = 10
            .Width         = 329
            .Height        = 127
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 188, 189)
        ENDWITH

        par_oPage.AddObject("lbl_4c_TitResumo", "Label")
        WITH par_oPage.lbl_4c_TitResumo
            .Top        = 160
            .Left       = 11
            .Width      = 116
            .Height     = 15
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .BackStyle  = 0
            .Alignment  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = " Total por Opera" + CHR(231) + CHR(227) + "o "
        ENDWITH

        *-- No SCX as Columns de grd_resumo ficaram com ControlSource VAZIO e
        *-- os Text1 internos apontando para um alias "dbproduto" que nao
        *-- existe neste form (residuo de copia de outra grade). As ligacoes
        *-- abaixo vem dos captions dos headers e da estrutura de dbResumo -
        *-- deixar o ControlSource vazio exibiria a grade em branco.
        par_oPage.AddObject("grd_4c_Resumo", "Grid")
        loc_oGrd = par_oPage.grd_4c_Resumo
        loc_oGrd.ColumnCount  = 3
        loc_oGrd.RecordSource = "cursor_4c_Resumo"
        WITH loc_oGrd
            .Top          = 180
            .Left         = 14
            .Width        = 320
            .Height       = 113
            THIS.FormatarGradeResultado(loc_oGrd)
            .Highlight    = .T.
            .HighlightRow = .T.

            THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Resumo.dopes", ;
                150, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
            THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Resumo.valos", ;
                90, "Valor Total", 2, "", "999,999,999.99")
            THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Resumo.qtds", ;
                58, "Qtds", 0, "99999.99", "")

            .Column1.ColumnOrder = 1
            .Column1.Alignment   = 3
            .Column2.ColumnOrder = 3
            .Column2.Alignment   = 3
            .Column3.ColumnOrder = 2
        ENDWITH

        *-- Shape2 + Grd_OperaProd (operacoes do produto selecionado)
        par_oPage.AddObject("shp_4c_MoldOperaProd", "Shape")
        WITH par_oPage.shp_4c_MoldOperaProd
            .Top           = 152
            .Left          = 337
            .Width         = 332
            .Height        = 93
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 188, 189)
        ENDWITH

        par_oPage.AddObject("grd_4c_OperaProd", "Grid")
        loc_oGrd = par_oPage.grd_4c_OperaProd
        loc_oGrd.ColumnCount  = 3
        loc_oGrd.RecordSource = "cursor_4c_OperaProd"
        WITH loc_oGrd
            .Top            = 154
            .Left           = 340
            .Width          = 324
            .Height         = 88
            THIS.FormatarGradeResultado(loc_oGrd)
            .RowHeight      = 17
            .Highlight      = .T.
            .HighlightRow   = .T.
            .LinkMaster     = "cursor_4c_ProdFor"
            .ChildOrder     = "cprosdopes"
            .RelationalExpr = "cpros"

            THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_OperaProd.dopes", ;
                127, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
            THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_OperaProd.valos", ;
                80, "Valor Total", 2, "", "999,999,999.99")
            THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_OperaProd.qtds", ;
                55, "Qtde.", 2, "", "999,999.999")

            .Column1.ColumnOrder = 1
            .Column1.Alignment   = 3
            .Column2.ColumnOrder = 3
            .Column2.Alignment   = 3
            .Column3.ColumnOrder = 2
        ENDWITH

        *-- Mensagem1 / Mensagem2: aparecem quando a Analise de Vendas NAO foi
        *-- pedida (Opt_Analise = 2), no lugar das duas grades de totais
        par_oPage.AddObject("lbl_4c_Mensagem1", "Label")
        WITH par_oPage.lbl_4c_Mensagem1
            .Top       = 195
            .Left      = 370
            .Width     = 269
            .Height    = 17
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(255, 0, 0)
            .Caption   = "N" + CHR(227) + "o foi executada a An" + CHR(225) + ;
                         "lise de Vendas..."
        ENDWITH

        par_oPage.AddObject("lbl_4c_Mensagem2", "Label")
        WITH par_oPage.lbl_4c_Mensagem2
            .Top       = 230
            .Left      = 32
            .Width     = 230
            .Height    = 17
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(255, 0, 0)
            .Caption   = "N" + CHR(227) + "o foi executada a An" + CHR(225) + ;
                         "lise de Vendas..."
        ENDWITH

        *-- Imprimir: abre o painel ImprimeOpcoes
        par_oPage.AddObject("cmd_4c_ImprimirMov", "CommandButton")
        WITH par_oPage.cmd_4c_ImprimirMov
            .Top             = 255
            .Left            = 342
            .Width           = 40
            .Height          = 40
            .FontName        = "Verdana"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = ""
            .ToolTipText     = "Imprimir"
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
        ENDWITH
        BINDEVENT(par_oPage.cmd_4c_ImprimirMov, "Click", THIS, "BtnImprimirMovClick")

        *-- OptSituas: filtro de situacao da grade de produtos
        par_oPage.AddObject("obj_4c_OptSituas", "OptionGroup")
        WITH par_oPage.obj_4c_OptSituas
            .ButtonCount   = 3
            .Top           = 9
            .Left          = 434
            .Width         = 197
            .Height        = 26
            .BackStyle     = 0
            .SpecialEffect = 1
            .Value         = 3

            WITH .Buttons(1)
                .Caption   = "Ativo"
                .Top       = 5
                .Left      = 9
                .Width     = 43
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Inativo"
                .Top       = 5
                .Left      = 66
                .Width     = 52
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Ambos"
                .Top       = 5
                .Left      = 130
                .Width     = 50
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(par_oPage.obj_4c_OptSituas, "InteractiveChange", THIS, "OptSituasChange")
    ENDPROC

    *==========================================================================
    * ConfigurarAbaEstoque - Page "Estoque" do Result: produtos do fornecedor
    * em poder das empresas + a foto do produto da linha selecionada.
    *
    * O olebcFigura (OleBoundControl) do legado NAO eh reproduzido: TODOS os
    * caminhos de codigo do legado o deixam Visible = .F. e quem desenha a
    * imagem eh o Image ImgFigJpg, a partir de um arquivo temporario.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaEstoque(par_oPage)
        LOCAL loc_oGrd

        par_oPage.AddObject("shp_4c_MoldEstoque", "Shape")
        WITH par_oPage.shp_4c_MoldEstoque
            .Top           = 27
            .Left          = 13
            .Width         = 239
            .Height        = 360
            .BackStyle     = 0
            .SpecialEffect = 1
        ENDWITH

        par_oPage.AddObject("lbl_4c_TitEstoque", "Label")
        WITH par_oPage.lbl_4c_TitEstoque
            .Top        = 13
            .Left       = 22
            .Width      = 133
            .Height     = 15
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .BackStyle  = 0
            .Alignment  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Produtos em seu poder"
        ENDWITH

        par_oPage.AddObject("grd_4c_EstoqueProd", "Grid")
        loc_oGrd = par_oPage.grd_4c_EstoqueProd
        loc_oGrd.ColumnCount  = 2
        loc_oGrd.RecordSource = "cursor_4c_Estoque"
        WITH loc_oGrd
            .Top          = 34
            .Left         = 18
            .Width        = 229
            .Height       = 346
            THIS.FormatarGradeResultado(loc_oGrd)
            .Highlight    = .T.
            .HighlightRow = .T.

            THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Estoque.cpros", ;
                108, "Produto", 2, "", "")
            THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Estoque.sqtds", ;
                100, "Qtde.", 2, "", "99,999,999.999")

            .Column1.ColumnOrder = 1
            .Column1.Alignment   = 3
            .Column2.ColumnOrder = 2
            .Column2.Alignment   = 3
        ENDWITH
        BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeEstoqueAfterRowColChange")

        par_oPage.AddObject("shp_4c_MoldFoto", "Shape")
        WITH par_oPage.shp_4c_MoldFoto
            .Top           = 27
            .Left          = 251
            .Width         = 181
            .Height        = 138
            .BackStyle     = 0
            .SpecialEffect = 1
        ENDWITH

        par_oPage.AddObject("img_4c_FotoProduto", "Image")
        WITH par_oPage.img_4c_FotoProduto
            .Top     = 32
            .Left    = 255
            .Width   = 172
            .Height  = 129
            .Stretch = 1
            .Enabled = .F.
            .Visible = .F.
        ENDWITH

        par_oPage.AddObject("lbl_4c_MsgFotoProduto", "Label")
        WITH par_oPage.lbl_4c_MsgFotoProduto
            .Top       = 90
            .Left      = 260
            .Width     = 109
            .Height    = 16
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Foto n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            .Visible   = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAbaConsertos - Page "Consertos" do Result: operacoes de
    * conserto do fornecedor ainda nao baixadas.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaConsertos(par_oPage)
        LOCAL loc_oGrd

        par_oPage.AddObject("shp_4c_MoldConserto", "Shape")
        WITH par_oPage.shp_4c_MoldConserto
            .Top           = 27
            .Left          = 7
            .Width         = 663
            .Height        = 289
            .BackStyle     = 0
            .SpecialEffect = 1
        ENDWITH

        par_oPage.AddObject("lbl_4c_TitConserto", "Label")
        WITH par_oPage.lbl_4c_TitConserto
            .Top        = 12
            .Left       = 17
            .Width      = 122
            .Height     = 15
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .BackStyle  = 0
            .Alignment  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Consertos Pendentes"
        ENDWITH

        par_oPage.AddObject("grd_4c_Conserto", "Grid")
        loc_oGrd = par_oPage.grd_4c_Conserto
        loc_oGrd.ColumnCount  = 4
        loc_oGrd.RecordSource = "cursor_4c_Conserto"
        WITH loc_oGrd
            .Top          = 37
            .Left         = 11
            .Width        = 654
            .Height       = 275
            THIS.FormatarGradeResultado(loc_oGrd)
            .Highlight    = .T.
            .HighlightRow = .T.

            THIS.ConfigurarColunaResultado(.Column1, "cursor_4c_Conserto.datas", ;
                75, "Data", 2, "", "")
            THIS.ConfigurarColunaResultado(.Column2, "cursor_4c_Conserto.emps", ;
                27, "Emp", 2, "", "")
            THIS.ConfigurarColunaResultado(.Column3, "cursor_4c_Conserto.opers", ;
                130, "Opera" + CHR(231) + CHR(227) + "o", 2, "", "")
            THIS.ConfigurarColunaResultado(.Column4, "cursor_4c_Conserto.obscon", ;
                399, "Observa" + CHR(231) + CHR(227) + "o", 2, "", "")

            .Column1.ColumnOrder = 1
            .Column1.Alignment   = 3
            .Column2.ColumnOrder = 2
            .Column2.Alignment   = 3
            .Column3.ColumnOrder = 3
            .Column3.Alignment   = 3
            .Column4.ColumnOrder = 4
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarImprimeOpcoes - container "ImprimeOpcoes" do legado: painel
    * flutuante (Visible = .F.) com as tres opcoes de abrangencia do
    * relatorio e os botoes Visualizar / Imprimir / Sair. Top compensado
    * (+29): legado 241 -> 270.
    *
    * Nasce invisivel e eh alternado por BtnImprimirMovClick / BtnSairOpcoes
    * - por isso entra na lista de excecao de TornarControlesVisiveis.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarImprimeOpcoes(par_oPag)
        LOCAL loc_oCnt

        par_oPag.AddObject("cnt_4c_ImprimeOpcoes", "Container")
        loc_oCnt = par_oPag.cnt_4c_ImprimeOpcoes
        WITH loc_oCnt
            .Top           = 270
            .Left          = 263
            .Width         = 291
            .Height        = 127
            .BackStyle     = 1
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 0
            .BorderWidth   = 1
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_VisualizarOpc", "CommandButton")
        WITH loc_oCnt.cmd_4c_VisualizarOpc
            .Top             = 8
            .Left            = 164
            .Width           = 40
            .Height          = 40
            .FontName        = "Verdana"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = ""
            .ToolTipText     = "Visualizar"
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Picture         = gc_4c_CaminhoIcones + "kghostview.ico"
            .DisabledPicture = gc_4c_CaminhoIcones + "kghostview.ico"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_VisualizarOpc, "Click", THIS, "BtnVisualizarOpcoesClick")

        loc_oCnt.AddObject("cmd_4c_ImprimirOpc", "CommandButton")
        WITH loc_oCnt.cmd_4c_ImprimirOpc
            .Top             = 8
            .Left            = 204
            .Width           = 40
            .Height          = 40
            .FontName        = "Verdana"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = ""
            .ToolTipText     = "Imprimir"
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_ImprimirOpc, "Click", THIS, "BtnImprimirOpcoesClick")

        loc_oCnt.AddObject("cmd_4c_SairOpc", "CommandButton")
        WITH loc_oCnt.cmd_4c_SairOpc
            .Top             = 8
            .Left            = 244
            .Width           = 40
            .Height          = 40
            .FontName        = "Verdana"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = ""
            .Cancel          = .T.
            .ToolTipText     = "Sair"
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_SairOpc, "Click", THIS, "BtnSairOpcoesClick")

        loc_oCnt.AddObject("obj_4c_Opcao", "OptionGroup")
        WITH loc_oCnt.obj_4c_Opcao
            .ButtonCount   = 3
            .Top           = 53
            .Left          = 49
            .Width         = 191
            .Height        = 64
            .BackStyle     = 0
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Value         = 1

            WITH .Buttons(1)
                .Caption   = "Produto Selecionado"
                .Top       = 5
                .Left      = 5
                .Width     = 116
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Todos os Produtos"
                .Top       = 24
                .Left      = 5
                .Width     = 107
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Todos com Movimenta" + CHR(231) + CHR(227) + "o"
                .Top       = 43
                .Left      = 5
                .Width     = 141
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        loc_oCnt.Visible = .F.
    ENDPROC

    *==========================================================================
    * AlternarPagina - Troca a pagina ativa do pgf_4c_Paginas (Consulta<->
    * Resultado), espelhando ThisForm.Fld_Principal.ActivePage = N do
    * legado.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        *-- Refresh em pagina OCULTA nao pinta: as grades do Resultado sao
        *-- repintadas aqui, DEPOIS da troca de ActivePage, senao o usuario ve
        *-- as grades vazias com os cursores cheios.
        IF par_nPagina = 2
            THIS.AtualizarGrades()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarFiltrosConsulta - Do Case comum aos dois botoes do
    * grp_operacao (legado: cmd_cadastro.Click e cmd_movimenta.Click tem
    * o MESMO bloco de validacao, so o que roda depois diverge). Grupo e
    * Conta sao sempre obrigatorios e tem de existir em SigCdGcr/SigCdCli;
    * quando Opt_Analise = 1 ("Sim"), Data Inicial/Moeda tambem se tornam
    * obrigatorias e a Data Final nao pode ser anterior a Data Inicial.
    *==========================================================================
    PROTECTED FUNCTION ValidarFiltrosConsulta()
        LOCAL loc_oPag, loc_oOrigem, loc_cGrupo, loc_cConta, loc_cMoeda, ;
              loc_nResult, loc_oErro, loc_lValido, loc_lErroSql, loc_cMsg, loc_oFoco

        loc_oPag     = THIS.pgf_4c_Paginas.Page1
        loc_oOrigem  = loc_oPag.cnt_4c_Origem
        loc_cGrupo   = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
        loc_cConta   = ALLTRIM(loc_oOrigem.txt_4c_Conta.Value)
        loc_cMoeda   = ALLTRIM(loc_oPag.txt_4c_Moeda.Value)
        loc_lValido  = .T.
        loc_lErroSql = .F.
        loc_cMsg     = ""
        loc_oFoco    = .NULL.

        TRY
            IF loc_lValido AND EMPTY(loc_cGrupo)
                loc_lValido = .F.
                loc_cMsg    = "Grupo de Estoque Inv" + CHR(225) + "lido !!!"
                loc_oFoco   = loc_oOrigem.txt_4c_Grupo
            ENDIF

            IF loc_lValido
                IF USED("cursor_4c_VldGrp")
                    USE IN cursor_4c_VldGrp
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 codigos FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
                    "cursor_4c_VldGrp")
                IF loc_nResult <= 0 OR !USED("cursor_4c_VldGrp") OR EOF("cursor_4c_VldGrp")
                    loc_lValido = .F.
                    loc_cMsg    = "Grupo de Estoque Inv" + CHR(225) + "lido !!!"
                    loc_oFoco   = loc_oOrigem.txt_4c_Grupo
                ENDIF
                IF USED("cursor_4c_VldGrp")
                    USE IN cursor_4c_VldGrp
                ENDIF
            ENDIF

            IF loc_lValido AND EMPTY(loc_cConta)
                loc_lValido = .F.
                loc_cMsg    = "Conta de Estoque Inv" + CHR(225) + "lida !!!"
                loc_oFoco   = loc_oOrigem.txt_4c_Conta
            ENDIF

            IF loc_lValido
                IF USED("cursor_4c_VldCta")
                    USE IN cursor_4c_VldCta
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 iclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta), ;
                    "cursor_4c_VldCta")
                IF loc_nResult <= 0 OR !USED("cursor_4c_VldCta") OR EOF("cursor_4c_VldCta")
                    loc_lValido = .F.
                    loc_cMsg    = "Conta de Estoque Inv" + CHR(225) + "lida !!!"
                    loc_oFoco   = loc_oOrigem.txt_4c_Conta
                ENDIF
                IF USED("cursor_4c_VldCta")
                    USE IN cursor_4c_VldCta
                ENDIF
            ENDIF

            IF loc_lValido AND loc_oPag.obj_4c_Opt_Analise.Value = 1
                IF EMPTY(loc_oPag.txt_4c_Datai.Value)
                    loc_lValido = .F.
                    loc_cMsg    = "Data Inicial Inv" + CHR(225) + "lida !!!"
                    loc_oFoco   = loc_oPag.txt_4c_Datai
                ENDIF

                IF loc_lValido AND loc_oPag.txt_4c_Datai.Value > loc_oPag.txt_4c_Dataf.Value
                    loc_lValido = .F.
                    loc_cMsg    = "Data Final Inv" + CHR(225) + "lida !!!"
                    loc_oFoco   = loc_oPag.txt_4c_Dataf
                ENDIF

                IF loc_lValido
                    IF USED("cursor_4c_VldMoe")
                        USE IN cursor_4c_VldMoe
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT TOP 1 cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cMoeda), ;
                        "cursor_4c_VldMoe")
                    IF loc_nResult <= 0 OR !USED("cursor_4c_VldMoe") OR EOF("cursor_4c_VldMoe")
                        loc_lValido = .F.
                        loc_cMsg    = "Moeda Inv" + CHR(225) + "lida !!!"
                        loc_oFoco   = loc_oPag.txt_4c_Moeda
                    ENDIF
                    IF USED("cursor_4c_VldMoe")
                        USE IN cursor_4c_VldMoe
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lValido  = .F.
            loc_lErroSql = .T.
            loc_cMsg     = loc_oErro.Message
        ENDTRY

        IF !loc_lValido
            IF loc_lErroSql
                MsgErro(loc_cMsg, "Erro")
            ELSE
                MsgAviso(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
                IF VARTYPE(loc_oFoco) = "O"
                    loc_oFoco.SetFocus()
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * ExecutarProcessamento - o "ThisForm.Processa" do legado visto pelos dois
    * botoes do grp_operacao.
    *
    * O legado envolve TODO o corpo de Processa em "If !ThisForm.
    * ConsultaExecutada": com os filtros inalterados desde a ultima consulta
    * nada eh reconsultado nem repintado (os dados na tela ja sao os certos).
    * Reproduzido aqui com o mesmo guard - cada handler de filtro zera a flag.
    *
    * Ordem: Buscar (dados cadastrais do fornecedor, TmpCli do legado) ->
    * Processar (as 9 etapas de agregacao) -> BOParaForm + CarregarLista
    * (a parte de UI do fim de Processa).
    *==========================================================================
    PROTECTED FUNCTION ExecutarProcessamento()
        LOCAL loc_lOk
        loc_lOk = .T.

        IF !THIS.this_oBusinessObject.this_lConsultaExecutada
            THIS.FormParaBO()

            IF !THIS.this_oBusinessObject.Buscar( ;
                    THIS.this_oBusinessObject.this_cGrupo, ;
                    THIS.this_oBusinessObject.this_cConta)
                IF !THIS.this_oBusinessObject.this_lErroExibido
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                ENDIF
                loc_lOk = .F.
            ENDIF

            IF loc_lOk
                IF !THIS.this_oBusinessObject.Processar()
                    IF !THIS.this_oBusinessObject.this_lErroExibido
                        MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                    ENDIF
                    loc_lOk = .F.
                ENDIF
            ENDIF

            IF loc_lOk
                *-- "If llSemDados And !pcMensagem" do legado: o aviso de
                *-- fornecedor sem informacao so aparece no fluxo de
                *-- Movimentacao (pcMensagem = .F.), e uma vez so.
                IF THIS.this_oBusinessObject.this_lSemDados AND ;
                        !THIS.this_oBusinessObject.this_lMensagem
                    MsgInfo("Nenhuma informa" + CHR(231) + CHR(227) + "o foi " + ;
                        "encontrada sobre este fornecedor !!!", "")
                    THIS.this_oBusinessObject.this_lMensagem = .T.
                ENDIF

                THIS.this_oBusinessObject.this_lConsultaExecutada = .T.

                THIS.BOParaForm()
                THIS.CarregarLista()
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * CarregarLista - a parte de UI do fim do metodo Processa do legado:
    * posiciona os cursores, decide o que a aba Movimentacao mostra (grades de
    * totais x as duas mensagens de "Analise de Vendas nao executada"), poe a
    * moeda do filtro no caption das colunas de valor, carrega a foto do
    * fornecedor e repinta TODAS as grades.
    *
    * Popular cursor NAO repinta a grade: sem GO TOP + Refresh a grade fica
    * visualmente vazia com o cursor cheio - e o sintoma ("a tela nao traz
    * dados") manda o diagnostico para SQL/permissao. O Refresh em pagina
    * OCULTA tambem nao pinta, por isso AlternarPagina(2) chama
    * AtualizarGrades() novamente DEPOIS de trocar o ActivePage.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro, loc_oRes, loc_oMov, loc_cTitMoeda, ;
              loc_lAnalise, loc_oPag1

        loc_lSucesso = .F.

        IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Result", 5)
            RETURN .F.
        ENDIF

        TRY
            loc_oRes  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result
            loc_oMov  = loc_oRes.Page3
            loc_oPag1 = THIS.pgf_4c_Paginas.Page1

            loc_lAnalise = (loc_oPag1.obj_4c_Opt_Analise.Value = 1)

            *-- grades de totais x mensagens (legado: If lnAnalise = 1)
            loc_oMov.grd_4c_Resumo.Visible    = loc_lAnalise
            loc_oMov.grd_4c_OperaProd.Visible = loc_lAnalise
            loc_oMov.lbl_4c_Mensagem1.Visible = !loc_lAnalise
            loc_oMov.lbl_4c_Mensagem2.Visible = !loc_lAnalise

            *-- _TitMoeda do legado: a moeda do filtro entra entre parenteses
            *-- no caption das tres colunas de valor
            loc_cTitMoeda = ""
            IF !EMPTY(ALLTRIM(loc_oPag1.txt_4c_Moeda.Value))
                loc_cTitMoeda = "(" + ALLTRIM(loc_oPag1.txt_4c_Moeda.Value) + ")"
            ENDIF

            loc_oMov.grd_4c_Produto.Column6.Header1.Caption   = "Total Vendas" + loc_cTitMoeda
            loc_oMov.grd_4c_OperaProd.Column2.Header1.Caption = "Valor Total" + loc_cTitMoeda
            loc_oMov.grd_4c_Resumo.Column2.Header1.Caption    = "Valor Total" + loc_cTitMoeda

            THIS.AtualizarFotoFornecedor()
            THIS.AtualizarGrades()

            loc_oRes.ActivePage = 1
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao exibir o resultado")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarGrades - GO TOP em cada cursor + Refresh de cada grade. Metodo
    * UNICO, chamado de CarregarLista e de AlternarPagina(2) - esta ultima
    * porque Refresh em pagina oculta nao pinta, e a Pagina Resultado so fica
    * visivel DEPOIS da troca de ActivePage.
    *==========================================================================
    PROCEDURE AtualizarGrades()
        LOCAL loc_oRes, loc_oErro

        IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Result", 5)
            RETURN
        ENDIF

        TRY
            THIS.this_oBusinessObject.PosicionarCursores()

            loc_oRes = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result

            loc_oRes.Page1.grd_4c_Saldo.Refresh()
            loc_oRes.Page1.grd_4c_Historico.Refresh()
            loc_oRes.Page1.txt_4c_Hists.Refresh()
            loc_oRes.Page1.txt_4c_Hist2s.Refresh()
            loc_oRes.Page2.grd_4c_Pendente.Refresh()
            loc_oRes.Page3.grd_4c_Produto.Refresh()
            loc_oRes.Page3.grd_4c_Resumo.Refresh()
            loc_oRes.Page3.grd_4c_OperaProd.Refresh()
            loc_oRes.Page4.grd_4c_EstoqueProd.Refresh()
            loc_oRes.Page5.grd_4c_Conserto.Refresh()

            *-- foto do produto da linha corrente da aba Estoque (o legado
            *-- dispara "Result.Estoque.Grd_Produto.AfterRowColChange" a mao)
            THIS.GradeEstoqueAfterRowColChange(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao atualizar as grades")
        ENDTRY
    ENDPROC

    *==========================================================================
    * MostrarBlocoCadastro / MostrarBlocoMovimento - o par de blocos "With
    * ThisForm.Fld_Principal.Pag_Resultado" do legado, que alterna a Pagina
    * Resultado entre o cadastro do fornecedor e o resultado da consulta, e
    * troca qual botao de navegacao (Cmd_MudaFor / Cmd_MudaMov) fica visivel.
    *
    * fChecaAcesso decide se o botao de ida pode aparecer, como no legado.
    *==========================================================================
    PROTECTED PROCEDURE MostrarBlocoCadastro()
        LOCAL loc_oPag2

        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        loc_oPag2.cnt_4c_Cadastro.Visible = .T.
        loc_oPag2.cnt_4c_Cadastro.Enabled = .T.
        loc_oPag2.pgf_4c_Result.Visible   = .F.
        loc_oPag2.pgf_4c_Result.Enabled   = .F.

        loc_oPag2.cmg_4c_MudaFor.Visible = .F.
        loc_oPag2.cmg_4c_MudaFor.Enabled = .F.

        IF fChecaAcesso("SIGOPCGC", "MOVIMENTA")
            loc_oPag2.cmg_4c_MudaMov.Visible = .T.
            loc_oPag2.cmg_4c_MudaMov.Enabled = .T.
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE MostrarBlocoMovimento()
        LOCAL loc_oPag2

        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        loc_oPag2.cnt_4c_Cadastro.Visible = .F.
        loc_oPag2.cnt_4c_Cadastro.Enabled = .F.
        loc_oPag2.pgf_4c_Result.Visible   = .T.
        loc_oPag2.pgf_4c_Result.Enabled   = .T.

        loc_oPag2.cmg_4c_MudaMov.Visible = .F.
        loc_oPag2.cmg_4c_MudaMov.Enabled = .F.

        IF fChecaAcesso("SIGOPCGC", "CADASTRO")
            loc_oPag2.cmg_4c_MudaFor.Visible = .T.
            loc_oPag2.cmg_4c_MudaFor.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * AtualizarFotoFornecedor - bloco "With .Pag_Resultado.Cadastro" do fim de
    * Processa: a foto so aparece quando o GRUPO de contas esta marcado para
    * exibir foto (CrSigCdGcr.mfotos = 1); sem foto, mostra o aviso "Foto nao
    * disponivel"; com o grupo sem foto, esconde moldura, imagem e aviso.
    *
    * CLEAR RESOURCES antes de atribuir o .Picture eh do legado e eh
    * necessario: sem ele o VFP reaproveita a imagem em cache do arquivo
    * temporario anterior e a tela mostra a foto do fornecedor errado.
    *==========================================================================
    PROTECTED PROCEDURE AtualizarFotoFornecedor()
        LOCAL loc_oCad, loc_cArquivo

        loc_oCad = THIS.pgf_4c_Paginas.Page2.cnt_4c_Cadastro

        IF THIS.this_oBusinessObject.this_nMFotos != 1
            loc_oCad.shp_4c_Figura.Visible  = .F.
            loc_oCad.img_4c_Figura.Visible  = .F.
            loc_oCad.img_4c_Figura.Picture  = ""
            loc_oCad.lbl_4c_MsgFoto.Visible = .F.
            RETURN
        ENDIF

        loc_oCad.shp_4c_Figura.Visible = .T.
        loc_cArquivo = THIS.this_oBusinessObject.ObterArquivoFotoFornecedor()

        IF EMPTY(loc_cArquivo)
            loc_oCad.img_4c_Figura.Visible  = .F.
            loc_oCad.img_4c_Figura.Picture  = ""
            loc_oCad.lbl_4c_MsgFoto.Visible = .T.
        ELSE
            CLEAR RESOURCES
            loc_oCad.img_4c_Figura.Picture  = loc_cArquivo
            loc_oCad.img_4c_Figura.Visible  = .T.
            loc_oCad.lbl_4c_MsgFoto.Visible = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCadastroClick - botao "Dados Cadastrais" do grp_operacao (Page1).
    * Legado (cmd_cadastro.Click): valida Grupo/Conta/periodo/moeda, poe
    * pcMensagem = .T. (nao avisa fornecedor sem informacao), roda Processa e
    * abre a Pagina Resultado no bloco de CADASTRO do fornecedor.
    *==========================================================================
    PROCEDURE BtnCadastroClick()
        IF !THIS.ValidarFiltrosConsulta()
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_lMensagem = .T.

        IF !THIS.ExecutarProcessamento()
            RETURN
        ENDIF

        THIS.MostrarBlocoCadastro()
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnMovimentoClick - botao "Movimentacao" do grp_operacao (Page1).
    * Legado (cmd_movimenta.Click): MESMA validacao do botao de cadastro, poe
    * pcMensagem = .F. (avisa quando o fornecedor nao tem informacao nenhuma),
    * roda Processa, abre a Pagina Resultado direto no bloco de RESULTADO,
    * RECONFIGURA as grades de Saldo/Historico (o numero de colunas depende da
    * permissao de SALDO) e posiciona o historico no lancamento mais recente.
    *==========================================================================
    PROCEDURE BtnMovimentoClick()
        LOCAL loc_oErro

        IF !THIS.ValidarFiltrosConsulta()
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_lMensagem = .F.

        IF !THIS.ExecutarProcessamento()
            RETURN
        ENDIF

        THIS.MostrarBlocoMovimento()

        *-- O legado refaz a configuracao das duas grades da aba Saldo a cada
        *-- clique neste botao (ColumnCount depende da permissao) - mexer em
        *-- ColumnCount recria as Column, por isso ControlSource/Width/Header
        *-- sao reaplicados dentro de ConfigurarGradesSaldo.
        THIS.ConfigurarGradesSaldo()

        THIS.AlternarPagina(2)

        *-- "Select dbHistorico / Go Bottom" do legado: o extrato abre no
        *-- lancamento mais RECENTE. Tem de vir DEPOIS de AlternarPagina, que
        *-- chama AtualizarGrades -> PosicionarCursores (GO TOP em todos os
        *-- cursores) - antes dela, o GO TOP desfaria este GO BOTTOM.
        IF USED("cursor_4c_Historico")
            SELECT cursor_4c_Historico
            GO BOTTOM
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1.grd_4c_Historico.Refresh()
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1.grd_4c_Historico.SetFocus()
        CATCH TO loc_oErro
            *-- SetFocus falha quando a grade ainda nao esta visivel; eh so o
            *-- foco inicial, nao afeta o conteudo exibido
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - botao "Encerrar" do grp_operacao (Page1), que no
    * legado eh o objeto cmd_cancela (Cancel = .T., ou seja tambem responde ao
    * ESC) e cujo Click eh apenas "ThisForm.Release".
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnVoltarClick - grp_operacao da Page2 (botao unico). Legado:
    * If ThisForm.Automatico / ThisForm.Release / Else / ThisForm.
    * Fld_Principal.ActivePage = 1 / EndIf. No modo Automatico (form aberto
    * por outra tela, com Grupo/Conta recebidos por parametro) nao ha pagina
    * de Consulta para onde voltar - a tela fecha.
    *==========================================================================
    PROCEDURE BtnVoltarClick()
        IF THIS.this_oBusinessObject.this_lAutomatico
            THIS.Release()
        ELSE
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnMudaForClick - mostra o bloco de CADASTRO do fornecedor e oculta o
    * resultado da consulta (legado Cmd_MudaFor.cmd_cadastro.Click, que ainda
    * poe pcMensagem = .T.).
    *==========================================================================
    PROCEDURE BtnMudaForClick()
        THIS.this_oBusinessObject.this_lMensagem = .T.
        THIS.LockScreen = .T.
        THIS.MostrarBlocoCadastro()
        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    * BtnMudaMovClick - mostra o RESULTADO da consulta e oculta o cadastro
    * (legado Cmd_MudaMov.cmd_movimenta.Click, que ainda poe
    * pcMensagem = .F.).
    *==========================================================================
    PROCEDURE BtnMudaMovClick()
        THIS.this_oBusinessObject.this_lMensagem = .F.
        THIS.LockScreen = .T.
        THIS.MostrarBlocoMovimento()
        THIS.LockScreen = .F.
        THIS.AtualizarGrades()
    ENDPROC

    *==========================================================================
    * GradeSaldoAfterRowColChange - AfterRowColChange de grd_saldo: trocar de
    * moeda na grade mae repinta a grade filha de historico (a relacao filtra
    * por moeda).
    *==========================================================================
    PROCEDURE GradeSaldoAfterRowColChange(par_nColIndex)
        LOCAL loc_oErro

        TRY
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1.grd_4c_Historico.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeHistoricoAfterRowColChange - AfterRowColChange de grd_historico:
    * os dois campos de historico abaixo da grade acompanham a linha corrente.
    *==========================================================================
    PROCEDURE GradeHistoricoAfterRowColChange(par_nColIndex)
        LOCAL loc_oPage, loc_oErro

        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page1
            loc_oPage.txt_4c_Hists.Refresh()
            loc_oPage.txt_4c_Hist2s.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeEstoqueAfterRowColChange - AfterRowColChange da grade da aba
    * Estoque: carrega a foto do produto da linha corrente (SigCdPro.figjpgs
    * gravado num arquivo temporario) ou mostra "Foto nao disponivel".
    *==========================================================================
    PROCEDURE GradeEstoqueAfterRowColChange(par_nColIndex)
        LOCAL loc_oPage, loc_cArquivo, loc_cProduto, loc_oErro

        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page4

            loc_cProduto = ""
            IF USED("cursor_4c_Estoque") AND !EOF("cursor_4c_Estoque")
                loc_cProduto = cursor_4c_Estoque.cpros
            ENDIF

            loc_cArquivo = ""
            IF !EMPTY(ALLTRIM(loc_cProduto))
                loc_cArquivo = THIS.this_oBusinessObject.CarregarFotoProduto(loc_cProduto)
            ENDIF

            IF EMPTY(loc_cArquivo)
                loc_oPage.img_4c_FotoProduto.Visible    = .F.
                loc_oPage.img_4c_FotoProduto.Picture    = ""
                loc_oPage.lbl_4c_MsgFotoProduto.Visible = .T.
            ELSE
                CLEAR RESOURCES
                loc_oPage.img_4c_FotoProduto.Picture    = loc_cArquivo
                loc_oPage.img_4c_FotoProduto.Visible    = .T.
                loc_oPage.lbl_4c_MsgFotoProduto.Visible = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao carregar a foto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * OptSituasChange - InteractiveChange de OptSituas: filtra a grade de
    * produtos por situacao (1 = Ativo, 2 = Inativo, 3 = Ambos / sem filtro).
    * Transcrito do legado, inclusive o GO TOP + Refresh no fim (sem eles a
    * grade continua mostrando a pagina antiga).
    *==========================================================================
    PROCEDURE OptSituasChange()
        LOCAL loc_oPage, loc_nValor, loc_oErro

        *-- Guarda ANTES do TRY: RETURN dentro de TRY/CATCH eh proibido (o
        *-- VFP9 nao garante o desvio e o bloco fica abandonado).
        IF !USED("cursor_4c_ProdFor")
            RETURN
        ENDIF

        TRY
            loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page3
            loc_nValor = loc_oPage.obj_4c_OptSituas.Value

            SELECT cursor_4c_ProdFor
            IF loc_nValor != 3
                IF loc_nValor = 1
                    SET FILTER TO situas = 1
                ELSE
                    SET FILTER TO situas = 2
                ENDIF
            ELSE
                SET FILTER TO
            ENDIF

            GO TOP IN cursor_4c_ProdFor
            loc_oPage.grd_4c_Produto.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * OrdenarGradeProdutos - corpo comum aos 8 handlers de Click/DblClick dos
    * headers da grade de produtos: o legado troca a ordem corrente do cursor
    * (Click = ascendente, DblClick = descendente) e repinta a grade.
    *==========================================================================
    PROTECTED PROCEDURE OrdenarGradeProdutos(par_cTag, par_lDescendente)
        LOCAL loc_oErro

        IF !USED("cursor_4c_ProdFor")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_ProdFor
            IF par_lDescendente
                SET ORDER TO (par_cTag) DESCENDING
            ELSE
                SET ORDER TO (par_cTag) ASCENDING
            ENDIF
            GO TOP IN cursor_4c_ProdFor
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Result.Page3.grd_4c_Produto.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE HeaderProdutoClick()
        THIS.OrdenarGradeProdutos("cpros", .F.)
    ENDPROC

    PROCEDURE HeaderProdutoDblClick()
        THIS.OrdenarGradeProdutos("cpros", .T.)
    ENDPROC

    PROCEDURE HeaderQtVendClick()
        THIS.OrdenarGradeProdutos("qtvend", .F.)
    ENDPROC

    PROCEDURE HeaderQtVendDblClick()
        THIS.OrdenarGradeProdutos("qtvend", .T.)
    ENDPROC

    PROCEDURE HeaderVlVendClick()
        THIS.OrdenarGradeProdutos("vlvend", .F.)
    ENDPROC

    PROCEDURE HeaderVlVendDblClick()
        THIS.OrdenarGradeProdutos("vlvend", .T.)
    ENDPROC

    PROCEDURE HeaderReffsClick()
        THIS.OrdenarGradeProdutos("reffs", .F.)
    ENDPROC

    PROCEDURE HeaderReffsDblClick()
        THIS.OrdenarGradeProdutos("reffs", .T.)
    ENDPROC

    *==========================================================================
    * BtnImprimirExtratoClick - btnImprimir da aba Saldo. Legado:
    *   Do Form SigReCgc With Get_Grupo.Value, Get_Conta.Value
    * O relatorio migrado eh FormSigReCgc, cujo Init recebe (grupo, conta).
    *==========================================================================
    PROCEDURE BtnImprimirExtratoClick()
        LOCAL loc_oForm, loc_oOrigem, loc_oErro

        loc_oForm = .NULL.

        TRY
            loc_oOrigem = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
            loc_oForm   = CREATEOBJECT("FormSigReCgc", ;
                ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value), ;
                ALLTRIM(loc_oOrigem.txt_4c_Conta.Value))
        CATCH TO loc_oErro
            loc_oForm = .NULL.
            MsgErro("Erro ao abrir o relat" + CHR(243) + "rio:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        *-- Show() FORA do TRY: form modal faz o Show BLOQUEAR, e com ele
        *-- dentro do TRY qualquer erro de runtime da tela aberta cairia neste
        *-- CATCH, a referencia LOCAL seria perdida e o form fecharia sozinho.
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnImprimirMovClick - botao Imprimir da aba Movimentacao. Legado: NAO
    * imprime nada ainda - desabilita a tela e abre o painel ImprimeOpcoes,
    * onde o usuario escolhe a abrangencia e so entao visualiza ou imprime.
    * A opcao "Produto Selecionado" so fica disponivel quando ha produto na
    * linha corrente da grade.
    *==========================================================================
    PROCEDURE BtnImprimirMovClick()
        LOCAL loc_oPag1, loc_oPag2, loc_lTemProduto, loc_oCnt

        loc_oPag1 = THIS.pgf_4c_Paginas.Page1
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2
        loc_oCnt  = loc_oPag2.cnt_4c_ImprimeOpcoes

        loc_oPag1.Enabled                 = .F.
        loc_oPag2.pgf_4c_Result.Enabled   = .F.
        loc_oPag2.cmg_4c_MudaMov.Enabled  = .F.
        loc_oPag2.cmg_4c_MudaFor.Enabled  = .F.
        loc_oPag2.cnt_4c_BotoesAcao.Enabled = .F.

        loc_lTemProduto = .F.
        IF USED("cursor_4c_ProdFor") AND !EOF("cursor_4c_ProdFor")
            loc_lTemProduto = !EMPTY(ALLTRIM(cursor_4c_ProdFor.cpros))
        ENDIF

        loc_oCnt.obj_4c_Opcao.Buttons(1).Enabled = loc_lTemProduto
        loc_oCnt.obj_4c_Opcao.Value              = IIF(loc_lTemProduto, 1, 2)
        loc_oCnt.Visible                         = .T.
    ENDPROC

    *==========================================================================
    * ReabilitarAposImpressao - o bloco de 6 linhas que o legado repete nos
    * tres botoes do painel ImprimeOpcoes (Visualizar, Imprimir e Sair), para
    * devolver a tela ao estado normal e fechar o painel.
    *==========================================================================
    PROTECTED PROCEDURE ReabilitarAposImpressao()
        LOCAL loc_oPag1, loc_oPag2

        loc_oPag1 = THIS.pgf_4c_Paginas.Page1
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        loc_oPag1.Enabled                   = .T.
        loc_oPag2.pgf_4c_Result.Enabled     = .T.
        loc_oPag2.cmg_4c_MudaMov.Enabled    = .T.
        loc_oPag2.cmg_4c_MudaFor.Enabled    = .T.
        loc_oPag2.cnt_4c_BotoesAcao.Enabled = .T.
        loc_oPag2.cnt_4c_ImprimeOpcoes.Visible = .F.
    ENDPROC

    *==========================================================================
    * BtnVisualizarOpcoesClick / BtnImprimirOpcoesClick - botoes Visualizar e
    * Imprimir do painel ImprimeOpcoes. Legado: ThisForm.ProcImp() monta
    * TmpRelat/TmpFinal, "Report Form SIGOPCGC Preview|To Print Prompt",
    * libera os dois cursores e reabilita a tela.
    *==========================================================================
    PROCEDURE BtnVisualizarOpcoesClick()
        THIS.ExecutarImpressao("PREVIEW")
    ENDPROC

    PROCEDURE BtnImprimirOpcoesClick()
        THIS.ExecutarImpressao("PRINTER_PROMPT")
    ENDPROC

    PROTECTED PROCEDURE ExecutarImpressao(par_cModo)
        LOCAL loc_oPag2, loc_nOpcao, loc_nFiltro

        loc_oPag2   = THIS.pgf_4c_Paginas.Page2
        loc_nOpcao  = loc_oPag2.cnt_4c_ImprimeOpcoes.obj_4c_Opcao.Value
        loc_nFiltro = loc_oPag2.pgf_4c_Result.Page3.obj_4c_OptSituas.Value

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.PrepararDadosImpressao(loc_nOpcao, loc_nFiltro)
            THIS.this_oBusinessObject.ExecutarRelatorio(par_cModo)
        ENDIF

        THIS.this_oBusinessObject.LiberarCursoresImpressao()
        THIS.ReabilitarAposImpressao()
    ENDPROC

    *==========================================================================
    * BtnSairOpcoesClick - botao Sair do painel ImprimeOpcoes: so fecha o
    * painel e devolve a tela ao estado normal.
    *==========================================================================
    PROCEDURE BtnSairOpcoesClick()
        THIS.ReabilitarAposImpressao()
    ENDPROC

    *==========================================================================
    * AplicarPermissoes - bloco de fChecaAcesso do Init do legado, que esconde
    * os botoes que o usuario nao pode acionar:
    *   sem CADASTRO   -> some o botao "Dados Cadastrais" e os dois botoes de
    *                     troca de bloco da Pagina Resultado;
    *   sem MOVIMENTA  -> some o botao "Movimentacao" e os mesmos dois;
    *   sem IMPRIMIR   -> some o botao de impressao do extrato (aba Saldo).
    *
    * O legado ainda reposiciona o CommandGroup (Left + 81 / Width - 81) a
    * cada botao escondido, para a fileira nao ficar com buraco - transcrito.
    *==========================================================================
    PROTECTED PROCEDURE AplicarPermissoes()
        LOCAL loc_oPag1, loc_oPag2, loc_oGrupo

        loc_oPag1  = THIS.pgf_4c_Paginas.Page1
        loc_oPag2  = THIS.pgf_4c_Paginas.Page2
        loc_oGrupo = loc_oPag1.cnt_4c_Botoes.cmg_4c_Operacao

        IF !fChecaAcesso("SIGOPCGC", "CADASTRO")
            loc_oPag2.cmg_4c_MudaMov.Visible = .F.
            loc_oPag2.cmg_4c_MudaMov.Enabled = .F.
            loc_oPag2.cmg_4c_MudaFor.Visible = .F.
            loc_oPag2.cmg_4c_MudaFor.Enabled = .F.

            *-- Buttons(3) = cmd_cadastro no legado
            loc_oGrupo.Buttons(3).Visible = .F.
            loc_oGrupo.Buttons(3).Enabled = .F.
            loc_oGrupo.Buttons(1).Left    = loc_oGrupo.Buttons(1).Left - 81
            loc_oGrupo.Buttons(2).Left    = loc_oGrupo.Buttons(2).Left - 81
            loc_oGrupo.Width              = loc_oGrupo.Width - 81
            loc_oGrupo.Left               = loc_oGrupo.Left  + 81
        ENDIF

        IF !fChecaAcesso("SIGOPCGC", "MOVIMENTA")
            loc_oPag2.cmg_4c_MudaMov.Visible = .F.
            loc_oPag2.cmg_4c_MudaMov.Enabled = .F.
            loc_oPag2.cmg_4c_MudaFor.Visible = .F.
            loc_oPag2.cmg_4c_MudaFor.Enabled = .F.

            *-- Buttons(1) = cmd_movimenta no legado
            loc_oGrupo.Buttons(1).Visible = .F.
            loc_oGrupo.Buttons(1).Enabled = .F.
            loc_oGrupo.Buttons(2).Left    = loc_oGrupo.Buttons(2).Left - 81
            loc_oGrupo.Width              = loc_oGrupo.Width - 81
            loc_oGrupo.Left               = loc_oGrupo.Left  + 81
        ENDIF

        IF !fChecaAcesso("SIGOPCGC", "IMPRIMIR")
            loc_oPag2.pgf_4c_Result.Page1.cmd_4c_ImprimirExtrato.Visible = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * OptAnaliseChange - InteractiveChange de obj_4c_Opt_Analise (Page1).
    * Legado: os When de Get_DataI/Get_DataF/Get_Moeda/Get_Empresa so
    * retornam .T. (campo habilitado) quando Opt_Analise.Value = 1 ("Sim");
    * o Valid de Opt_Analise ainda limpa os 4 campos quando Value = 2.
    *==========================================================================
    PROCEDURE OptAnaliseChange()
        LOCAL loc_oPag, loc_lHabilita

        THIS.this_oBusinessObject.this_lConsultaExecutada = .F.

        loc_oPag      = THIS.pgf_4c_Paginas.Page1
        loc_lHabilita = (loc_oPag.obj_4c_Opt_Analise.Value = 1)

        loc_oPag.txt_4c_Datai.Enabled   = loc_lHabilita
        loc_oPag.txt_4c_Dataf.Enabled   = loc_lHabilita
        loc_oPag.txt_4c_Moeda.Enabled   = loc_lHabilita
        loc_oPag.txt_4c_Empresa.Enabled = loc_lHabilita

        IF !loc_lHabilita
            loc_oPag.txt_4c_Datai.Value   = {}
            loc_oPag.txt_4c_Dataf.Value   = {}
            loc_oPag.txt_4c_Moeda.Value   = ""
            loc_oPag.txt_4c_Empresa.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDataI - KeyPress de txt_4c_Datai (Page1). Legado (Get_Datai.
    * Valid): se Get_DataF estiver vazio, preenche com GoMonth(DataI, 1).
    *==========================================================================
    PROCEDURE ValidarDataI(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag

        THIS.this_oBusinessObject.this_lConsultaExecutada = .F.

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPag.txt_4c_Dataf.Value) AND !EMPTY(loc_oPag.txt_4c_Datai.Value)
            loc_oPag.txt_4c_Dataf.Value = GOMONTH(loc_oPag.txt_4c_Datai.Value, 1)
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDataF - KeyPress de txt_4c_Dataf (Page1). Legado (Get_Dataf.
    * InteractiveChange): ThisForm.ConsultaExecutada = .F. - sem validacao
    * de valor no Valid, so invalida o cache da ultima consulta.
    *==========================================================================
    PROCEDURE ValidarDataF(par_nKeyCode, par_nShiftAltCtrl)
        THIS.this_oBusinessObject.this_lConsultaExecutada = .F.
    ENDPROC

    *==========================================================================
    * ValidarMoeda - KeyPress de txt_4c_Moeda (Page1). Legado (Get_Moeda.
    * Valid): fwbuscaext em SigCdMoe.cmoes - aqui com match exato via
    * SQLEXEC e fallback no picker AbrirBuscaMoeda().
    *==========================================================================
    PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult, loc_oErro

        THIS.this_oBusinessObject.this_lConsultaExecutada = .F.

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value)
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF

        TRY
            IF USED("cursor_4c_MoedaVal")
                USE IN cursor_4c_MoedaVal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_MoedaVal")
            IF loc_nResult > 0 AND USED("cursor_4c_MoedaVal") AND !EOF("cursor_4c_MoedaVal")
                THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_MoedaVal.cmoes)
            ELSE
                THIS.AbrirBuscaMoeda()
            ENDIF
            IF USED("cursor_4c_MoedaVal")
                USE IN cursor_4c_MoedaVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaMoeda - picker por cmoes/dmoes em SigCdMoe
    *==========================================================================
    PROCEDURE AbrirBuscaMoeda()
        LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_lProsseguir, loc_oErro

        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value)

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe ORDER BY cmoes"
            ELSE
                loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
                           "WHERE cmoes LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR RTRIM(dmoes) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY cmoes"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeda")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaMoeda") OR RECCOUNT("cursor_4c_BuscaMoeda") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaMoeda")
                    USE IN cursor_4c_BuscaMoeda
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT cmoes, dmoes FROM SigCdMoe ORDER BY cmoes", "cursor_4c_BuscaMoeda")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaMoeda") OR RECCOUNT("cursor_4c_BuscaMoeda") = 0
                MsgAviso("Nenhuma moeda encontrada.", "Moedas")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMoeda"
                    loc_oBusca.this_cTitulo        = "Moedas"
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = "Moedas"
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = "Moedas"
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                        SELECT cursor_4c_BuscaMoeda
                        THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                    ELSE
                        THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarEmpresa - KeyPress de txt_4c_Empresa (Page1). Legado (Get_
    * Empresa.Valid): fAcessoEmpresa(Usuar,'C',This.Value,This.Parent.
    * Get_Empresa) - fAcessoEmpresa NAO foi portada (regra CLAUDE.md), aqui
    * substituida por match exato em SigCdEmp.Cemps + VerificarAcessoEmpresa
    * (modo check) + fallback no picker AbrirBuscaEmpresa().
    *==========================================================================
    PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult, loc_oErro

        THIS.this_oBusinessObject.this_lConsultaExecutada = .F.

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value)
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF

        TRY
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmpVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpVal") AND !EOF("cursor_4c_EmpVal")
                IF !VerificarAcessoEmpresa(gc_4c_UsuarioLogado, ALLTRIM(cursor_4c_EmpVal.Cemps))
                    MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
                ELSE
                    THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ALLTRIM(cursor_4c_EmpVal.Cemps)
                ENDIF
            ELSE
                THIS.AbrirBuscaEmpresa()
            ENDIF
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaEmpresa - picker por Cemps/Razas em SigCdEmp
    *==========================================================================
    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_lProsseguir, loc_oErro, loc_cTitulo

        loc_cValor  = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value)
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa"

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF

        loc_lProsseguir = .T.
        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                           "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Cemps"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmp")
                    USE IN cursor_4c_BuscaEmp
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", "cursor_4c_BuscaEmp")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0
                MsgAviso("Nenhuma empresa encontrada.", "Empresa")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmp"
                    loc_oBusca.this_cTitulo        = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                    loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        SELECT cursor_4c_BuscaEmp
                        IF VerificarAcessoEmpresa(gc_4c_UsuarioLogado, ALLTRIM(cursor_4c_BuscaEmp.Cemps))
                            THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        ELSE
                            MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
                            THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
                        ENDIF
                    ELSE
                        THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarGrupo - KeyPress de txt_4c_Grupo (container cnt_4c_Origem,
    * Page1). Legado (Origem.Get_grupo.Valid): fAcessoContab(...) + Seek em
    * CrSigCdGcr + ajusta Left/Width/Visible de Get_DConta/Get_Cpf conforme
    * CrSigCdGcr.tpcads (1 = mostra CPF e encolhe DConta; != 1 = esconde CPF
    * e DConta ocupa a largura toda). fAcessoContab ja esta portada em
    * utils\functions.prg (abre o picker internamente quando nao acha).
    *==========================================================================
    PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oOrigem, loc_cVal, loc_nResult, loc_oErro

        THIS.this_oBusinessObject.this_lConsultaExecutada = .F.

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oOrigem = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
        loc_cVal    = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)

        IF EMPTY(loc_cVal)
            RETURN
        ENDIF

        TRY
            fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cVal, loc_oOrigem.txt_4c_Grupo)

            loc_cVal = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
            IF !EMPTY(loc_cVal)
                IF USED("cursor_4c_GrpVal")
                    USE IN cursor_4c_GrpVal
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 tpcads FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cVal), ;
                    "cursor_4c_GrpVal")
                IF loc_nResult > 0 AND USED("cursor_4c_GrpVal") AND !EOF("cursor_4c_GrpVal")
                    IF cursor_4c_GrpVal.tpcads = 1
                        loc_oOrigem.txt_4c_Dconta.Left  = 326
                        loc_oOrigem.txt_4c_Dconta.Width = 278
                        loc_oOrigem.lbl_4c__dConta.Left = 329
                        loc_oOrigem.txt_4c_Cpf.Visible   = .T.
                        loc_oOrigem.lbl_4c__CPF.Visible  = .T.
                    ELSE
                        loc_oOrigem.txt_4c_Dconta.Left  = 177
                        loc_oOrigem.txt_4c_Dconta.Width = 427
                        loc_oOrigem.lbl_4c__dConta.Left = 180
                        loc_oOrigem.txt_4c_Cpf.Visible   = .F.
                        loc_oOrigem.lbl_4c__CPF.Visible  = .F.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_GrpVal")
                    USE IN cursor_4c_GrpVal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarConta - KeyPress de txt_4c_Conta (container cnt_4c_Origem,
    * Page1). Legado (Origem.Get_conta.Valid): fAcessoContas(...) valida o
    * acesso e preenche Get_DConta; em caso de sucesso, CursorQuery em
    * SigCdCli completa Grupo (se vazio) e Cpf.
    *==========================================================================
    PROCEDURE ValidarConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oOrigem, loc_cVal, loc_cGrupo, loc_nResult, loc_oErro

        THIS.this_oBusinessObject.this_lConsultaExecutada = .F.

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oOrigem = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
        loc_cVal    = ALLTRIM(loc_oOrigem.txt_4c_Conta.Value)
        loc_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)

        IF EMPTY(loc_cVal)
            loc_oOrigem.txt_4c_Dconta.Value = ""
            loc_oOrigem.txt_4c_Cpf.Value    = ""
            RETURN
        ENDIF

        TRY
            IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cVal, ;
                    loc_oOrigem.txt_4c_Conta, loc_oOrigem.txt_4c_Dconta)
                MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oOrigem.txt_4c_Conta.Value  = ""
                loc_oOrigem.txt_4c_Dconta.Value = ""
                loc_oOrigem.txt_4c_Cpf.Value    = ""
            ELSE
                loc_cVal = ALLTRIM(loc_oOrigem.txt_4c_Conta.Value)
                IF !EMPTY(loc_cVal)
                    IF USED("cursor_4c_CtaVal")
                        USE IN cursor_4c_CtaVal
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT TOP 1 grupos, cpfs FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cVal), ;
                        "cursor_4c_CtaVal")
                    IF loc_nResult > 0 AND USED("cursor_4c_CtaVal") AND !EOF("cursor_4c_CtaVal")
                        IF EMPTY(loc_oOrigem.txt_4c_Grupo.Value)
                            loc_oOrigem.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_CtaVal.grupos)
                        ENDIF
                        loc_oOrigem.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_CtaVal.cpfs)
                    ENDIF
                    IF USED("cursor_4c_CtaVal")
                        USE IN cursor_4c_CtaVal
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarDConta - KeyPress de txt_4c_Dconta (container cnt_4c_Origem,
    * Page1). Legado (Origem.Get_dconta.Valid): fAcessoContas(...,'D',...)
    * busca pelo NOME e preenche Get_Conta; mesmo complemento de Grupo/Cpf
    * via CursorQuery do ValidarConta.
    *==========================================================================
    PROCEDURE ValidarDConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oOrigem, loc_cVal, loc_cGrupo, loc_nResult, loc_oErro

        THIS.this_oBusinessObject.this_lConsultaExecutada = .F.

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oOrigem = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
        loc_cVal    = ALLTRIM(loc_oOrigem.txt_4c_Dconta.Value)
        loc_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)

        IF EMPTY(loc_cVal)
            loc_oOrigem.txt_4c_Conta.Value = ""
            loc_oOrigem.txt_4c_Cpf.Value   = ""
            RETURN
        ENDIF

        TRY
            IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", loc_cVal, ;
                    loc_oOrigem.txt_4c_Conta, loc_oOrigem.txt_4c_Dconta)
                MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oOrigem.txt_4c_Conta.Value  = ""
                loc_oOrigem.txt_4c_Dconta.Value = ""
                loc_oOrigem.txt_4c_Cpf.Value    = ""
            ELSE
                loc_cVal = ALLTRIM(loc_oOrigem.txt_4c_Conta.Value)
                IF !EMPTY(loc_cVal)
                    IF USED("cursor_4c_CtaVal")
                        USE IN cursor_4c_CtaVal
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT TOP 1 grupos, cpfs FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cVal), ;
                        "cursor_4c_CtaVal")
                    IF loc_nResult > 0 AND USED("cursor_4c_CtaVal") AND !EOF("cursor_4c_CtaVal")
                        IF EMPTY(loc_oOrigem.txt_4c_Grupo.Value)
                            loc_oOrigem.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_CtaVal.grupos)
                        ENDIF
                        loc_oOrigem.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_CtaVal.cpfs)
                    ENDIF
                    IF USED("cursor_4c_CtaVal")
                        USE IN cursor_4c_CtaVal
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarCpf - KeyPress de txt_4c_Cpf (container cnt_4c_Origem, Page1).
    * Legado (Origem.Get_cpf.Valid): fwbuscaext em SigCdCli.cpfs (aqui via
    * FormBuscaAuxiliar - mAddColuna cpfs/iclis/rclis) + fAcessoContas para
    * validar o acesso ao registro escolhido e preencher Conta/DConta.
    *==========================================================================
    PROCEDURE ValidarCpf(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oOrigem, loc_cVal, loc_cGrupo, loc_oBusca, loc_oErro

        THIS.this_oBusinessObject.this_lConsultaExecutada = .F.

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_oOrigem = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
        loc_cVal    = ALLTRIM(loc_oOrigem.txt_4c_Cpf.Value)
        loc_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)

        IF EMPTY(loc_cVal)
            loc_oOrigem.txt_4c_Dconta.Value = ""
            loc_oOrigem.txt_4c_Conta.Value  = ""
            RETURN
        ENDIF

        TRY
            IF USED("cursor_4c_BuscaCpf")
                USE IN cursor_4c_BuscaCpf
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
                "cursor_4c_BuscaCpf", "cpfs", loc_cVal, "Fornecedores")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cpfs",  "", "CPF / CGC")
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCpf")
                    SELECT cursor_4c_BuscaCpf
                    loc_cVal = ALLTRIM(cursor_4c_BuscaCpf.iclis)

                    IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cVal, ;
                            loc_oOrigem.txt_4c_Conta, loc_oOrigem.txt_4c_Dconta)
                        MsgAviso("Acesso Negado.", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_oOrigem.txt_4c_Cpf.Value    = ""
                        loc_oOrigem.txt_4c_Conta.Value  = ""
                        loc_oOrigem.txt_4c_Dconta.Value = ""
                    ELSE
                        loc_oOrigem.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCpf.cpfs)
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaCpf")
                USE IN cursor_4c_BuscaCpf
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere filtros da Page1 para o Business Object
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPag, loc_oOrigem

        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_oOrigem = loc_oPag.cnt_4c_Origem

        WITH THIS.this_oBusinessObject
            .this_nAnalise = loc_oPag.obj_4c_Opt_Analise.Value
            .this_dDataI   = ConverterParaData(loc_oPag.txt_4c_Datai.Value)
            .this_dDataF   = ConverterParaData(loc_oPag.txt_4c_Dataf.Value)
            .this_cMoeda   = ALLTRIM(loc_oPag.txt_4c_Moeda.Value)
            .this_cEmpresa = ALLTRIM(loc_oPag.txt_4c_Empresa.Value)

            .this_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_Grupo.Value)
            .this_cConta  = ALLTRIM(loc_oOrigem.txt_4c_Conta.Value)
            .this_cDConta = ALLTRIM(loc_oOrigem.txt_4c_Dconta.Value)
            .this_cCpf    = ALLTRIM(loc_oOrigem.txt_4c_Cpf.Value)
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere os dados cadastrais do fornecedor pesquisado
    * (Business Object) para os TextBoxes de cnt_4c_Cadastro (Page2).
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oCad

        loc_oCad = THIS.pgf_4c_Paginas.Page2.cnt_4c_Cadastro

        WITH THIS.this_oBusinessObject
            loc_oCad.txt_4c_CodFor.Value = .this_cCodFor
            loc_oCad.txt_4c_Nome.Value   = .this_cNome
            loc_oCad.txt_4c_End.Value    = .this_cEnd
            loc_oCad.txt_4c_Bairro.Value = .this_cBairro
            loc_oCad.txt_4c_Cep.Value    = .this_cCep
            loc_oCad.txt_4c_Cid.Value    = .this_cCid
            loc_oCad.txt_4c_Est.Value    = .this_cEst
            loc_oCad.txt_4c_Tel1.Value   = .this_cTel1
            loc_oCad.txt_4c_Tel2.Value   = .this_cTel2
            loc_oCad.txt_4c_Fax.Value    = .this_cFax
            loc_oCad.txt_4c_Cgc.Value    = .this_cCgc
            loc_oCad.txt_4c_Ie.Value     = .this_cIe
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles criados via
    * AddObject (que nascem com Visible=.F.), recursivamente em Pages e
    * Containers. cmg_4c_MudaFor comeca Visible=.F. de proposito (igual ao
    * legado: so um dos Cmd_MudaFor/Cmd_MudaMov fica visivel por vez,
    * alternado por BtnMudaForClick/BtnMudaMovClick) e img_4c_Figura comeca
    * Visible=.F. porque SigCdCli nao tem coluna de foto (fica so o aviso
    * "Foto nao disponivel") - pular esses nomes SEM deixar de recursar nos
    * filhos deles (regra CLAUDE.md "Form OPERACIONAL / Containers
    * Flutuantes").
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP, loc_lPularVisible

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            *-- Controles que NASCEM ocultos no legado e sao revelados por
            *-- codigo. O LOOP nao eh usado aqui de proposito: pular o
            *-- objeto sem recursar deixaria os FILHOS dele com Visible = .F.
            *-- para sempre, e o container apareceria VAZIO quando revelado.
            *--   CMG_4C_MUDAFOR / CMG_4C_MUDAMOV - so um por vez, alternados
            *--   PGF_4C_RESULT         - a Pagina Resultado abre no cadastro
            *--   CNT_4C_IMPRIMEOPCOES  - painel de opcoes de impressao
            *--   GRD_4C_PENDENTEOCULTA - Grid1 do legado, nunca exibida
            *--   IMG_4C_FIGURA / IMG_4C_FOTOPRODUTO - so com foto disponivel
            *--   LBL_4C_MSGFOTO / LBL_4C_MSGFOTOPRODUTO - so SEM foto
            *--   LBL_4C_MENSAGEM1 / 2 - so sem Analise de Vendas
            loc_lPularVisible = INLIST(UPPER(loc_oObjeto.Name), ;
                "CMG_4C_MUDAFOR", "CMG_4C_MUDAMOV", "PGF_4C_RESULT", ;
                "CNT_4C_IMPRIMEOPCOES", "GRD_4C_PENDENTEOCULTA", ;
                "IMG_4C_FIGURA", "IMG_4C_FOTOPRODUTO", "LBL_4C_MSGFOTO", ;
                "LBL_4C_MSGFOTOPRODUTO", "LBL_4C_MENSAGEM1", "LBL_4C_MENSAGEM2")

            IF !loc_lPularVisible AND PEMSTATUS(loc_oObjeto, "Visible", 5)
                loc_oObjeto.Visible = .T.
            ENDIF

            IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                FOR loc_nP = 1 TO loc_oObjeto.PageCount
                    THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                ENDFOR
            ELSE
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * DESTROY - delega para FormBase.Destroy (restaura menu apos fechamento)
    *==========================================================================
    PROCEDURE Destroy()
        RETURN DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopcgcBO.prg):
*==============================================================================
* sigopcgcBO.prg - Business Object para Consulta Generica de Compras
* Origem: SIGOPCGC.SCX
* Herda de: BusinessBase
* Tipo: OPERACIONAL (consulta/relatorio - nao eh CRUD de tabela unica)
*==============================================================================

DEFINE CLASS sigopcgcBO AS BusinessBase

    *-- Filtros de consulta (Pagina Consulta)
    this_nAnalise  = 1     && Opt_Analise: 1=Compra, 2=Venda (indice 1-based do OptionGroup)
    this_dDataI    = {}    && Get_Datai - data inicial do periodo de analise
    this_dDataF    = {}    && Get_Dataf - data final do periodo de analise
    this_cMoeda    = ""    && Get_Moeda - codigo da moeda (SigCdMoe.cmoes)
    this_cEmpresa  = ""    && Get_Empresa - codigo da empresa (SigCdEmp.Cemps)

    *-- Origem (grupo/conta/cpf do fornecedor pesquisado)
    this_cGrupo    = ""    && Origem.Get_grupo - grupo de contas (SigCdGcr.codigos)
    this_cConta    = ""    && Origem.Get_conta - conta do fornecedor (SigCdCli.iclis)
    this_cDConta   = ""    && Origem.Get_dconta - descricao/nome do fornecedor (auto-preenchido)
    this_cCpf      = ""    && Origem.Get_cpf - CPF ou CGC do fornecedor

    *-- Dados cadastrais do fornecedor (Pagina Resultado - Cadastro.Dados)
    this_cCodFor   = ""    && Get_codfor - codigo do fornecedor
    this_cNome     = ""    && Get_nome - razao social/nome
    this_cEnd      = ""    && Get_end - endereco
    this_cBairro   = ""    && Get_bairro - bairro
    this_cCid      = ""    && Get_cid - cidade
    this_cCep      = ""    && Get_cep - CEP
    this_cEst      = ""    && Get_est - UF
    this_cTel1     = ""    && Get_tel1 - telefone 1
    this_cTel2     = ""    && Get_tel2 - telefone 2
    this_cFax      = ""    && Get_fax - fax
    this_cCgc      = ""    && Get_cgc - CGC/CNPJ
    this_cIe       = ""    && Get_ie - inscricao estadual

    *-- Controle de fluxo (equivalentes as PUBLIC vars do legado: pcMensagem, _Fornece, _Moeda, _Produto, ConsultaExecutada)
    this_lConsultaExecutada = .F.   && ConsultaExecutada - evita reprocessar a mesma consulta
    this_lMensagem          = .F.   && pcMensagem - .T. = modo Movimento, .F. = modo Fornecedor (impressao)
    this_cFornece           = ""    && _Fornece - cabecalho formatado "Conta : Grupo / Conta [ Nome ]" para impressao
    this_cMoedaRelatorio    = ""    && _Moeda - moeda selecionada no momento da impressao
    this_cProdutoAtual      = ""    && _Produto - produto corrente (dbProdFor.cpros) ao trocar de linha na grade
    this_lAutomatico        = .F.   && Automatico - .T. quando o form foi aberto via parametro (fecha ao concluir)

    *-- Estado da agregacao do metodo Processa() do legado
    this_lSemDados   = .T.   && llSemDados - .T. enquanto nenhuma das 9 consultas devolveu linha
    this_nCotaConv   = 1     && lnCotaConv - cotacao da moeda do filtro, divisor de TODA conversao
    this_cFigJpg     = ""    && TmpCli.figjpgs - foto do fornecedor (coluna text de SigCdCli)
    this_nMFotos     = 0     && CrSigCdGcr.mfotos do grupo pesquisado - 1 = o grupo exibe foto

    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdCli"
        THIS.this_cCampoChave = "Iclis"
        DODEFAULT()

        *-- Legado: PROCEDURE Load cria os 8 cursores locais de resultado;
        *-- PROCEDURE Init carrega os 9 cursores de apoio (parametros do
        *-- sistema, empresas, operacoes, moedas, cotacoes...). Aqui as duas
        *-- coisas acontecem no Init do BO porque o form migrado nao tem
        *-- evento Load. NUNCA devolver .F. daqui: BO.Init() falso mata o
        *-- form (o CREATEOBJECT do menu recebe .F. e nada abre).
        THIS.InicializarCursoresDados()

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            THIS.InicializarCursoresApoio()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega os dados cadastrais do fornecedor pesquisado
    *
    * Espelha o bloco "With ThisForm.Fld_Principal.Pag_Resultado.Cadastro.Dados"
    * do metodo Processa() do legado (SIGOPCGC.SCX), que roda a query:
    *   Select iclis, rclis, endes, bairs, cidas, ceps, estas, tel1s, tel2s,
    *          faxs, cpfs, rgs From SigCdCli Where grupos = ? And iclis = ?
    * e atribui coluna a coluna aos campos Get_CodFor/Get_Nome/Get_End/...
    *
    * Os campos Get_Cgc e Get_Ie do legado NAO leem colunas cgcs/ies (SigCdCli
    * nao tem essas colunas) - eles reaproveitam cpfs e rgs. Transcrito
    * literalmente (regra #17 do CLAUDE.md) - nao "corrigir" para colunas
    * inexistentes no schema.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCodFor = TratarNulo(iclis, "")
        THIS.this_cNome   = TratarNulo(rclis, "")
        THIS.this_cEnd    = TratarNulo(endes, "")
        THIS.this_cBairro = TratarNulo(bairs, "")
        THIS.this_cCid    = TratarNulo(cidas, "")
        THIS.this_cCep    = TratarNulo(ceps,  "")
        THIS.this_cEst    = TratarNulo(estas, "")
        THIS.this_cTel1   = TratarNulo(tel1s, "")
        THIS.this_cTel2   = TratarNulo(tel2s, "")
        THIS.this_cFax    = TratarNulo(faxs,  "")
        THIS.this_cCgc    = TratarNulo(cpfs,  "")
        THIS.this_cIe     = TratarNulo(rgs,   "")

        *-- figjpgs (coluna text) - foto do fornecedor. O legado le a mesma
        *-- coluna no bloco final de Processa (Copy Memo TmpCli.figjpgs To
        *-- lcArquivo1) e so a exibe quando CrSigCdGcr.mfotos = 1.
        THIS.this_cFigJpg = TratarNulo(figjpgs, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Codigo do fornecedor (SigCdCli.Iclis) atualmente
    * carregado nos campos cadastrais da Pagina Resultado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCodFor, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Consulta os dados cadastrais do fornecedor (Grupo + Conta),
    * espelhando a query "TmpCli" do metodo Processa() do legado (SIGOPCGC.
    * SCX, linhas 4319-4360):
    *   Select iclis, rclis, endes, bairs, cidas, ceps, estas, tel1s, tel2s,
    *          faxs, cpfs, rgs From SigCdCli Where grupos = ? And iclis = ?
    *
    * Sobrescreve (nao chama DODEFAULT) porque BusinessBase.Buscar() exige
    * this_oDataAccess inicializado via Init(pcTabela) - este BO e de
    * CONSULTA customizada (SigOpCgc nao e cadastro CRUD de uma tabela so)
    * e nunca passou pcTabela para DODEFAULT() no Init.
    *
    * Conta nao encontrada NAO e falha de conexao - o legado so devolve
    * .F. quando o SqlExecute falha (Else zera os campos e segue adiante,
    * regra #17 - comportamento transcrito literalmente).
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cGrupo, par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        IF USED("cursor_4c_Fornecedor")
            USE IN cursor_4c_Fornecedor
        ENDIF

        loc_cSQL = "SELECT iclis, rclis, endes, bairs, cidas, ceps, estas, " + ;
                   "tel1s, tel2s, faxs, cpfs, rgs, figjpgs FROM SigCdCli " + ;
                   "WHERE grupos = " + EscaparSQL(ALLTRIM(NVL(par_cGrupo, ""))) + ;
                   " AND iclis = " + EscaparSQL(ALLTRIM(NVL(par_cConta, "")))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Fornecedor")

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
        ELSE
            IF USED("cursor_4c_Fornecedor") AND RECCOUNT("cursor_4c_Fornecedor") > 0
                THIS.CarregarDoCursor("cursor_4c_Fornecedor")
            ELSE
                THIS.this_cCodFor = ""
                THIS.this_cNome   = ""
                THIS.this_cEnd    = ""
                THIS.this_cBairro = ""
                THIS.this_cCid    = ""
                THIS.this_cCep    = ""
                THIS.this_cEst    = ""
                THIS.this_cTel1   = ""
                THIS.this_cTel2   = ""
                THIS.this_cFax    = ""
                THIS.this_cCgc    = ""
                THIS.this_cIe     = ""
                THIS.this_cFigJpg = ""
            ENDIF
            loc_lSucesso = .T.
        ENDIF

        IF USED("cursor_4c_Fornecedor")
            USE IN cursor_4c_Fornecedor
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * EmModoTeste - .T. quando o processo esta rodando sem usuario (harness de
    * teste automatizado ou ValidarUIFidelity). Usado para suprimir WAIT
    * WINDOW / barra de progresso, que em execucao headless ficariam na tela
    * sem ninguem para fechar.
    *
    * Os IFs sao ANINHADOS de proposito: VFP9 nao garante short-circuit, e
    * "TYPE('x') = 'L' AND x" avaliaria x mesmo quando a variavel nao existe.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION EmModoTeste()
        LOCAL loc_lTeste
        loc_lTeste = .F.

        IF TYPE("gb_4c_ModoTeste") = "L"
            loc_lTeste = gb_4c_ModoTeste
        ENDIF

        IF !loc_lTeste
            IF TYPE("gb_4c_ValidandoUI") = "L"
                loc_lTeste = gb_4c_ValidandoUI
            ENDIF
        ENDIF

        RETURN loc_lTeste
    ENDFUNC

    *--------------------------------------------------------------------------
    * MostrarProgresso / LimparProgresso - equivalentes aos
    * "Wait Window '...' NoWait" e ao "Wait Clear" do metodo Processa do
    * legado (Processando Saldos / Historico / Produtos / Consertos /
    * Pendencias).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MostrarProgresso(par_cTexto)
        IF !THIS.EmModoTeste()
            WAIT WINDOW ALLTRIM(NVL(par_cTexto, "")) NOWAIT
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE LimparProgresso()
        IF !THIS.EmModoTeste()
            WAIT CLEAR
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarBarraProgresso / AtualizarBarra / FecharBarra - espelham os
    * CreateObject('fwprogressbar', <titulo>, Reccount(<cursor>)) do legado
    * (tres lacos: Movimentacoes por Destino/Origem, Verificando
    * Movimentacoes e Processando Estoque). Devolvem .NULL. em modo de teste
    * ou se a classe falhar, e os chamadores seguem processando - a barra eh
    * feedback visual, nunca pre-requisito do calculo.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CriarBarraProgresso(par_cTitulo, par_nTotal)
        LOCAL loc_oBarra, loc_oErro
        loc_oBarra = .NULL.

        IF !THIS.EmModoTeste()
            TRY
                loc_oBarra = CREATEOBJECT("fwprogressbar", ;
                    ALLTRIM(NVL(par_cTitulo, "")), MAX(NVL(par_nTotal, 0), 1))
                loc_oBarra.Titulo.FontBold = .T.
                loc_oBarra.Show()
            CATCH TO loc_oErro
                loc_oBarra = .NULL.
            ENDTRY
        ENDIF

        RETURN loc_oBarra
    ENDFUNC

    PROTECTED PROCEDURE AtualizarBarra(par_oBarra, par_cTexto)
        LOCAL loc_oErro

        IF VARTYPE(par_oBarra) = "O"
            TRY
                par_oBarra.SubTitulo.Caption = ALLTRIM(NVL(par_cTexto, ""))
                par_oBarra.Update(.T.)
            CATCH TO loc_oErro
                *-- a barra eh so feedback visual: se a janela ja foi fechada
                *-- pelo usuario, o processamento continua sem ela
            ENDTRY
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE FecharBarra(par_oBarra)
        LOCAL loc_oErro

        IF VARTYPE(par_oBarra) = "O"
            TRY
                par_oBarra.Complete(.T.)
            CATCH TO loc_oErro
                *-- idem AtualizarBarra
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ZapCursor - ZAP guardado por SET SAFETY.
    *
    * SET SAFETY eh ESCOPADO POR DATA SESSION e o form que consome este BO eh
    * DataSession = 2: o SET SAFETY OFF do main.prg NAO alcanca a sessao
    * privada, e com SAFETY ON o ZAP abre dialogo modal de confirmacao e
    * CONGELA a tela (em teste headless isso aparece como timeout sem
    * resultado nenhum, nao como erro). FormBase.Init ja faz SET SAFETY OFF
    * na sessao do form; o guard aqui cobre o uso do BO fora dele.
    *
    * ZAP eh a escolha CERTA aqui, nao USE IN + CREATE CURSOR: o legado faz
    * "Zap In <cursor>" exatamente para preservar a estrutura e o binding das
    * grades (Grid.RecordSource / Column.ControlSource). Fechar e recriar o
    * alias derrubaria o binding e a grade ficaria vazia com o cursor cheio.
    *
    * Usado tambem onde o legado faz "Delete All" (dbParcela): com ZAP o
    * resultado nao depende de SET DELETED, que a data session privada reseta
    * para OFF (default do VFP) - com DELETE ALL + DELETED OFF as linhas
    * apagadas continuariam aparecendo na grade.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ZapCursor(par_cCursor)
        LOCAL loc_cSafety

        IF USED(par_cCursor)
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            ZAP IN (par_cCursor)
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarConsulta - SQLEXEC com o tratamento de erro do legado
    * ("MessageBox('Favor reinicializar o processo.',16,'Falha na Conexao')"
    * repetido nas 20 consultas de Processa).
    *
    * O alias de destino eh fechado antes, com o guard de buffering: sem ele
    * o segundo SQLEXEC sobre o mesmo alias estoura "Table buffer contains
    * uncommitted changes", e TABLEREVERT em cursor sem buffering dispara o
    * erro 1586 ("Function requires row or table buffering mode").
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarConsulta(par_cSQL, par_cCursor)
        LOCAL loc_nResultado

        IF USED(par_cCursor)
            IF CURSORGETPROP("Buffering", par_cCursor) > 1
                TABLEREVERT(.T., par_cCursor)
            ENDIF
            USE IN (par_cCursor)
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)

        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + ;
                CHR(13) + CapturarErroSQL()
        ENDIF

        RETURN (loc_nResultado >= 1)
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarCursoresDados - espelha a PROCEDURE Load do legado, que cria
    * os 8 cursores locais de resultado com os indices usados pelas grades e
    * pelos SEEK de Processa.
    *
    * As LARGURAS sao as do legado, NAO as do schema: dbHistorico.hists eh
    * c(30) contra SigMvCcr.hists char(60), dbProdFor.reffs eh c(20) contra
    * SigCdPro.reffs char(40) e dpros eh c(40) contra char(65). Sao as
    * larguras de EXIBICAO que o legado escolheu - transcritas literalmente
    * (PILAR 1), nao "corrigidas" para o tamanho da coluna de origem.
    *
    * Somente datas/vencs sao NULL (como no legado): os demais campos sao
    * acumuladores (Replace x With x + y) e com NULL a soma viraria NULL.
    * Por isso TODO valor vindo do SQL Server entra via NVL nos INSERT.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarCursoresDados()
        LOCAL loc_cNullAnt, loc_oErro

        loc_cNullAnt = SET("NULL")
        SET NULL OFF

        TRY
            *-- dbSaldo - saldos por moeda (grade "Saldo por Moeda")
            IF !USED("cursor_4c_Saldo")
                CREATE CURSOR cursor_4c_Saldo ( ;
                    grupos C(10), contas C(10), moedas C(3), saldos N(12,3))
            ENDIF

            *-- dbHistorico - historico de conta corrente. Grade FILHA de
            *-- cursor_4c_Saldo pela moeda; o tag eh composto (moeda + data)
            *-- para a grade sair filtrada pela moeda selecionada E ordenada
            *-- por data. DTOS(NVL(datas,{})) protege o indice das datas NULL
            *-- que SigMvCcr.datas (datetime NULL) pode trazer.
            IF !USED("cursor_4c_Historico")
                CREATE CURSOR cursor_4c_Historico ( ;
                    emps C(3), datas D NULL, valors N(12,2), opers C(1), ;
                    saldos N(12,3), hists C(30), moedas C(3), hist2s C(40), ;
                    vencs D NULL, valpags N(12,2), nfs C(10))
                INDEX ON moedas + DTOS(NVL(datas, {})) TAG moedata
            ENDIF

            *-- dbEstoque - produtos do fornecedor em poder das empresas
            IF !USED("cursor_4c_Estoque")
                CREATE CURSOR cursor_4c_Estoque ( ;
                    cpros C(14), dpros C(40), sqtds N(12,3))
            ENDIF

            *-- dbConserto - consertos em aberto
            IF !USED("cursor_4c_Conserto")
                CREATE CURSOR cursor_4c_Conserto ( ;
                    datas D, emps C(3), opers C(27), obscon C(50))
            ENDIF

            *-- dbParcela - valores em aberto (parcelas + conta corrente)
            IF !USED("cursor_4c_Parcela")
                CREATE CURSOR cursor_4c_Parcela ( ;
                    vencs D NULL, emps C(3), fpags C(10), valos N(12,2), ;
                    moefpgs C(3), dopes C(20), numes N(6), hists C(50))
                INDEX ON DTOS(NVL(vencs, {})) TAG vencs
            ENDIF

            *-- dbProdFor - produtos do fornecedor (grade "Produtos" da aba
            *-- Movimentacao). Os 4 tags sao os usados pelos Click/DblClick
            *-- dos headers (ordenacao ascendente/descendente). cpros fica por
            *-- ULTIMO para ser o tag controlador inicial, que eh o que os
            *-- SEEK(<produto>, 'dbProdFor') de Processa pressupoem.
            IF !USED("cursor_4c_ProdFor")
                CREATE CURSOR cursor_4c_ProdFor ( ;
                    cpros C(14), custofs N(12,2), moecusfs C(3), marca C(1), ;
                    qtvend N(12,3), vlvend N(12,2), estoque N(12,3), ;
                    cunis C(3), pvens N(12,2), moedas C(3), reffs C(20), ;
                    dpros C(40), situas N(1))
                INDEX ON qtvend TAG qtvend
                INDEX ON vlvend TAG vlvend
                INDEX ON reffs  TAG reffs
                INDEX ON cpros  TAG cpros
            ENDIF

            *-- dbResumo - total por operacao
            IF !USED("cursor_4c_Resumo")
                CREATE CURSOR cursor_4c_Resumo ( ;
                    dopes C(20), qtds N(7,2), valos N(12,2), custofs N(12,2))
                INDEX ON dopes TAG dopes
            ENDIF

            *-- dbOperaProd - operacoes por produto (grade FILHA de
            *-- cursor_4c_ProdFor pelo produto)
            IF !USED("cursor_4c_OperaProd")
                CREATE CURSOR cursor_4c_OperaProd ( ;
                    cpros C(14), dopes C(20), valos N(12,2), qtds N(12,3))
                INDEX ON cpros + dopes TAG cprosdopes
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao criar os cursores da consulta:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        IF loc_cNullAnt = "ON"
            SET NULL ON
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursoresApoio - espelha a PROCEDURE Init do legado, que
    * carrega uma unica vez os cursores de parametros/tabelas de apoio usados
    * pelos SEEK de Processa e pelas validacoes dos botoes.
    *
    * Os nomes crSigCd* sao preservados por serem a convencao ja adotada no
    * projeto para os cursores de apoio de cotacao (o CarregarCambio de
    * SigReAtmBO / SigReInvBO le crSigCdMoe / crSigCdCot com estes nomes).
    *
    * Cada cursor passa por "SELECT * INTO CURSOR ... READWRITE" antes do
    * INDEX ON: cursor de SQL pass-through nasce somente-leitura e nao aceita
    * a criacao de indice.
    *
    * crSigCdOpe NAO vem de "Select ... From SigCdOpe": o legado troca a
    * query antiga (comentada no SCX, com c.tipoops In (4,5,7,8)) por um JOIN
    * com SigCdTom para trazer GerGdmis, que eh o que decide se a operacao
    * gera movimento de estoque. Transcrito do JOIN vigente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarCursoresApoio()
        LOCAL loc_oErro

        TRY
            IF THIS.ExecutarConsulta("SELECT * FROM SigCdPam", "crSigCdPam")
                SELECT crSigCdPam
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta("SELECT cemps, razas, ativas FROM SigCdEmp", ;
                    "cursor_4c_EmpTmp")
                SELECT * FROM cursor_4c_EmpTmp INTO CURSOR crSigCdEmp READWRITE
                USE IN cursor_4c_EmpTmp
                SELECT crSigCdEmp
                INDEX ON cemps TAG Cemps
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta("SELECT usuarios, supervis FROM SigCdUsu " + ;
                    "WHERE NOT cAtivos = 'N'", "cursor_4c_UsuTmp")
                SELECT * FROM cursor_4c_UsuTmp INTO CURSOR crUsuarios READWRITE
                USE IN cursor_4c_UsuTmp
                SELECT crUsuarios
                INDEX ON usuarios TAG Usuarios
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta("SELECT codigos, tpcads, mfotos FROM SigCdGcr", ;
                    "cursor_4c_GcrTmp")
                SELECT * FROM cursor_4c_GcrTmp INTO CURSOR crSigCdGcr READWRITE
                USE IN cursor_4c_GcrTmp
                SELECT crSigCdGcr
                INDEX ON codigos TAG Codigos
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta( ;
                    "SELECT a.Dopes, a.Cmoes, a.Caixas, a.TipoOps, a.Pesovts, " + ;
                    "a.Precovts, a.Valpends, b.GerGdmis " + ;
                    "FROM SigCdOpe a, SigCdTom b " + ;
                    "WHERE a.TipoOps = b.Codigos", "cursor_4c_OpeTmp")
                SELECT * FROM cursor_4c_OpeTmp INTO CURSOR crSigCdOpe READWRITE
                USE IN cursor_4c_OpeTmp
                SELECT crSigCdOpe
                INDEX ON Dopes TAG Dopes
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta("SELECT operacaos, tipos FROM SigCdOpt", ;
                    "cursor_4c_OptTmp")
                SELECT * FROM cursor_4c_OptTmp INTO CURSOR crSigCdOpt READWRITE
                USE IN cursor_4c_OptTmp
                SELECT crSigCdOpt
                INDEX ON operacaos TAG Operacaos
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta("SELECT fpags, infos, valpends FROM SigOpFp", ;
                    "cursor_4c_FpTmp")
                SELECT * FROM cursor_4c_FpTmp INTO CURSOR crSigOpFp READWRITE
                USE IN cursor_4c_FpTmp
                SELECT crSigOpFp
                INDEX ON fpags TAG FPags
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta("SELECT * FROM SigCdMoe", "cursor_4c_MoeTmp")
                SELECT * FROM cursor_4c_MoeTmp INTO CURSOR crSigCdMoe READWRITE
                USE IN cursor_4c_MoeTmp
                SELECT crSigCdMoe
                INDEX ON cmoes TAG CMoes
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta("SELECT cmoes, datas, valos FROM SigCdCot", ;
                    "cursor_4c_CotTmp")
                SELECT * FROM cursor_4c_CotTmp INTO CURSOR crSigCdCot READWRITE
                USE IN cursor_4c_CotTmp
                SELECT crSigCdCot
                INDEX ON cmoes                        TAG CMoes
                INDEX ON cmoes + DTOS(NVL(datas, {})) TAG CMoeData
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta("SELECT linhas, tpcustos FROM SigCdLin", ;
                    "cursor_4c_LinTmp")
                SELECT * FROM cursor_4c_LinTmp INTO CURSOR crSigCdLin READWRITE
                USE IN cursor_4c_LinTmp
                SELECT crSigCdLin
                INDEX ON linhas TAG Linhas
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Falha na Conex" + CHR(227) + "o")
            THIS.this_lErroExibido = .T.
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterGrupoPadrao - CrSigCdPam.grpadfors, o grupo de contas default que o
    * Init do legado joga em Origem.Get_Grupo.Value.
    *--------------------------------------------------------------------------
    FUNCTION ObterGrupoPadrao()
        LOCAL loc_cGrupo
        loc_cGrupo = ""

        IF USED("crSigCdPam") AND RECCOUNT("crSigCdPam") > 0
            SELECT crSigCdPam
            GO TOP
            loc_cGrupo = ALLTRIM(TratarNulo(crSigCdPam.grpadfors, ""))
        ENDIF

        RETURN loc_cGrupo
    ENDFUNC

    *--------------------------------------------------------------------------
    * GrupoExiste / MoedaExiste - as verificacoes do Do Case que abre
    * cmd_cadastro.Click e cmd_movimenta.Click do legado:
    *   Seek(Get_Grupo.Value, 'CrSigCdGcr', 'codigos')
    *   Seek(Get_Moeda.Value, 'CrSigCdMoe', 'cmoes')
    *--------------------------------------------------------------------------
    FUNCTION GrupoExiste(par_cGrupo)
        IF !USED("crSigCdGcr") OR EMPTY(NVL(par_cGrupo, ""))
            RETURN .F.
        ENDIF

        SELECT crSigCdGcr
        SET ORDER TO Codigos

        RETURN SEEK(PADR(ALLTRIM(par_cGrupo), 10))
    ENDFUNC

    FUNCTION MoedaExiste(par_cMoeda)
        IF !USED("crSigCdMoe") OR EMPTY(NVL(par_cMoeda, ""))
            RETURN .F.
        ENDIF

        SELECT crSigCdMoe
        SET ORDER TO CMoes

        RETURN SEEK(PADR(ALLTRIM(par_cMoeda), 3))
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarCambio - substitui fCarregarCambio(cMoeda, dData) do framework
    * legado, que NAO foi portada para projeto\app\utils\functions.prg.
    *
    * Le a ultima cotacao com data <= dData em crSigCdCot (SigCdCot.valos),
    * so quando a moeda esta marcada como cotada em SigCdMoe (coluna cotas,
    * bit). Devolve 1 - nunca 0 - para poder ser usada como DIVISOR sem
    * estourar divisao por zero, que eh exatamente o uso em Processa
    * (lnValItem * lnCotOper / lnCotaConv).
    *--------------------------------------------------------------------------
    FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cMoeda, loc_dData, loc_oErro
        loc_nCotacao = 0
        loc_cMoeda   = ALLTRIM(NVL(par_cMoeda, ""))
        loc_dData    = IIF(EMPTY(par_dData), DATE(), ConverterParaData(par_dData))

        IF EMPTY(loc_cMoeda)
            RETURN 1
        ENDIF

        TRY
            IF USED("crSigCdMoe")
                SELECT crSigCdMoe
                SET ORDER TO CMoes
                IF SEEK(PADR(loc_cMoeda, 3)) AND THIS.BitParaLogico(crSigCdMoe.cotas)
                    IF USED("crSigCdCot")
                        SELECT crSigCdCot
                        SET ORDER TO CMoeData DESCENDING
                        SET NEAR ON
                        SEEK PADR(loc_cMoeda, 3) + DTOS(loc_dData)
                        SET NEAR OFF
                        IF !EOF() AND ALLTRIM(crSigCdCot.cmoes) == loc_cMoeda
                            loc_nCotacao = NVL(crSigCdCot.valos, 0)
                        ENDIF
                        SET ORDER TO CMoeData
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            SET NEAR OFF
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *--------------------------------------------------------------------------
    * BitParaLogico - SigCdMoe.cotas eh "bit" no SQL Server e chega ao VFP ora
    * como Logico (.T./.F.), ora como Numerico (0/1), conforme o driver ODBC.
    * Testar VARTYPE antes de comparar - comparar Logico com 1 estoura
    * "Operator/operand type mismatch".
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BitParaLogico(par_uValor)
        IF ISNULL(par_uValor)
            RETURN .F.
        ENDIF

        DO CASE
            CASE VARTYPE(par_uValor) = "L"
                RETURN par_uValor
            CASE VARTYPE(par_uValor) = "N"
                RETURN (par_uValor != 0)
            CASE VARTYPE(par_uValor) = "C"
                RETURN INLIST(UPPER(LEFT(ALLTRIM(par_uValor), 1)), "S", "1", "T", "Y")
        ENDCASE

        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimiteFinalDoDia - fDtoSQL(data, '23:59:59') do legado: o periodo fecha
    * no ULTIMO segundo do dia final, senao o BETWEEN descartaria tudo o que
    * foi lancado depois da meia-noite do dia F. Data vazia devolve {}, que
    * FormatarDataSQL converte em NULL (consulta sem linha, sem erro) - sem o
    * guard, DTOT({}) + 86399 estouraria em runtime.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION LimiteFinalDoDia(par_dData)
        LOCAL loc_dData
        loc_dData = ConverterParaData(par_dData)

        IF EMPTY(loc_dData)
            RETURN {}
        ENDIF

        RETURN DTOT(loc_dData) + 86399
    ENDFUNC

    *--------------------------------------------------------------------------
    * DataDoCursor - normaliza coluna datetime do SQL Server para o campo D
    * (nullable) dos cursores locais, preservando o NULL.
    *
    * TTOD so aceita DATETIME (com DATE dispara o erro 11 em runtime); aqui o
    * valor vem SEMPRE de cursor de SQLEXEC, que eh o unico caso em que TTOD
    * direto eh correto - mas o VARTYPE eh conferido de qualquer forma porque
    * o mesmo helper serve aos cursores locais.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION DataDoCursor(par_tValor)
        IF ISNULL(par_tValor)
            RETURN .NULL.
        ENDIF

        IF VARTYPE(par_tValor) = "T"
            RETURN ConverterParaData(par_tValor)
        ENDIF

        RETURN ConverterParaData(par_tValor)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Processar - espelha o metodo Processa() do legado (871 linhas), que monta
    * o conteudo INTEIRO da Pagina Resultado a partir dos filtros da Pagina
    * Consulta. A ordem das 9 etapas eh a do legado e NAO pode ser trocada:
    * Produtos popula cursor_4c_ProdFor, e Movimentacao / Verificacao /
    * Estoque Atual acumulam EM CIMA dele (qtvend / vlvend / estoque).
    *
    * O legado abandona o metodo inteiro ("Return(.F.)") na primeira consulta
    * que falha - reproduzido com os IF loc_lOk em cadeia (VFP9 nao garante
    * short-circuit em AND, entao nao se usa "A() AND B()").
    *
    * Os blocos de UI do fim de Processa (ActivePage, Refresh das grades,
    * Visible de Mensagem1/Mensagem2, caption das colunas com a moeda e a
    * foto do fornecedor) NAO vem para ca - sao do Form (CarregarLista).
    *--------------------------------------------------------------------------
    FUNCTION Processar()
        LOCAL loc_lOk, loc_oErro, loc_cGrupo, loc_cConta

        loc_lOk    = .F.
        loc_cGrupo = ALLTRIM(NVL(THIS.this_cGrupo, ""))
        loc_cConta = ALLTRIM(NVL(THIS.this_cConta, ""))

        TRY
            THIS.this_lSemDados     = .T.
            THIS.this_cMensagemErro = ""
            THIS.this_lErroExibido  = .F.

            *-- lnCotaConv: cotacao da moeda escolhida no filtro. Eh o DIVISOR
            *-- de toda conversao de Processa; CarregarCambio nunca devolve 0.
            IF !EMPTY(THIS.this_cMoeda)
                THIS.this_nCotaConv = THIS.CarregarCambio(THIS.this_cMoeda, DATE())
            ELSE
                THIS.this_nCotaConv = 1
            ENDIF

            loc_lOk = THIS.ProcessarSaldos(loc_cGrupo, loc_cConta)

            IF loc_lOk
                loc_lOk = THIS.ProcessarHistorico(loc_cGrupo, loc_cConta)
            ENDIF

            IF loc_lOk
                loc_lOk = THIS.ProcessarProdutos(loc_cConta)
            ENDIF

            *-- "If lnAnalise = 1" do legado: a analise de vendas (movimento
            *-- por operacao e por produto) so roda quando o usuario pediu.
            IF loc_lOk AND THIS.this_nAnalise = 1
                loc_lOk = THIS.ProcessarMovimentacao(loc_cGrupo, loc_cConta)

                IF loc_lOk
                    loc_lOk = THIS.ProcessarVerificacaoMovimentacao()
                ENDIF
            ENDIF

            IF loc_lOk
                loc_lOk = THIS.ProcessarEstoqueAtual()
            ENDIF

            IF loc_lOk
                loc_lOk = THIS.ProcessarEstoqueFornecedor(loc_cGrupo, loc_cConta)
            ENDIF

            IF loc_lOk
                loc_lOk = THIS.ProcessarConsertos(loc_cGrupo, loc_cConta)
            ENDIF

            IF loc_lOk
                loc_lOk = THIS.ProcessarPendencias(loc_cGrupo, loc_cConta)
            ENDIF

            IF loc_lOk
                THIS.CarregarParametrosGrupo(loc_cGrupo)
                THIS.PosicionarCursores()
            ENDIF

            THIS.LimparProgresso()
        CATCH TO loc_oErro
            loc_lOk = .F.
            THIS.LimparProgresso()
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, ;
                "Erro ao processar a consulta")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarSaldos - "Wait Window 'Processando Saldos...'" do legado:
    * SigMvSlc -> dbSaldo (grade "Saldo por Moeda").
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarSaldos(par_cGrupo, par_cConta)
        LOCAL loc_cSQL, loc_lOk

        THIS.MostrarProgresso("Processando Saldos...")
        THIS.ZapCursor("cursor_4c_Saldo")

        loc_cSQL = "SELECT grupos, contas, moedas, saldos FROM SigMvSlc " + ;
                   "WHERE grupos = " + EscaparSQL(par_cGrupo) + ;
                   " AND contas = " + EscaparSQL(par_cConta) + ;
                   " ORDER BY grupos, contas, moedas, saldos"

        loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_SaldoSql")

        IF loc_lOk
            SELECT cursor_4c_SaldoSql
            SCAN
                INSERT INTO cursor_4c_Saldo (grupos, contas, moedas, saldos) ;
                    VALUES (NVL(cursor_4c_SaldoSql.grupos, ""), ;
                            NVL(cursor_4c_SaldoSql.contas, ""), ;
                            NVL(cursor_4c_SaldoSql.moedas, ""), ;
                            NVL(cursor_4c_SaldoSql.saldos, 0))
                THIS.this_lSemDados = .F.
                SELECT cursor_4c_SaldoSql
            ENDSCAN
            USE IN cursor_4c_SaldoSql
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarHistorico - "Processando Historico...": SigMvCcr -> dbHistorico
    * (grade FILHA de cursor_4c_Saldo pela moeda).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarHistorico(par_cGrupo, par_cConta)
        LOCAL loc_cSQL, loc_lOk

        THIS.MostrarProgresso("Processando Hist" + CHR(243) + "rico...")
        THIS.ZapCursor("cursor_4c_Historico")

        loc_cSQL = "SELECT emps, grupos, contas, datas, moedas, saldos, " + ;
                   "valors, opers, hists, hist2s, vencs, valpags, nfs " + ;
                   "FROM SigMvCcr " + ;
                   "WHERE grupos = " + EscaparSQL(par_cGrupo) + ;
                   " AND contas = " + EscaparSQL(par_cConta) + ;
                   " ORDER BY emps, grupos, contas, datas, opers, saldos, " + ;
                   "moedas, valors, hists, hist2s, vencs, valpags, nfs"

        loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_HistSql")

        IF loc_lOk
            SELECT cursor_4c_HistSql
            SCAN
                INSERT INTO cursor_4c_Historico ;
                    (emps, datas, valors, opers, saldos, hists, moedas, ;
                     hist2s, vencs, valpags, nfs) ;
                    VALUES (NVL(cursor_4c_HistSql.emps, ""), ;
                            THIS.DataDoCursor(cursor_4c_HistSql.datas), ;
                            NVL(cursor_4c_HistSql.valors, 0), ;
                            NVL(cursor_4c_HistSql.opers, ""), ;
                            NVL(cursor_4c_HistSql.saldos, 0), ;
                            NVL(cursor_4c_HistSql.hists, ""), ;
                            NVL(cursor_4c_HistSql.moedas, ""), ;
                            NVL(cursor_4c_HistSql.hist2s, ""), ;
                            THIS.DataDoCursor(cursor_4c_HistSql.vencs), ;
                            NVL(cursor_4c_HistSql.valpags, 0), ;
                            NVL(cursor_4c_HistSql.nfs, ""))
                THIS.this_lSemDados = .F.
                SELECT cursor_4c_HistSql
            ENDSCAN
            USE IN cursor_4c_HistSql
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarProdutos - "Processando Produtos...": SigCdPro (ifors = conta)
    * -> dbProdFor, a grade "Produtos" da aba Movimentacao.
    *
    * A regra de custo eh do legado e vai TRANSCRITA: quando a LINHA do
    * produto tem tpcustos = '2' (custo por peso), o custo exibido eh
    * pesoms * custofs, nao custofs.
    *
    * Fecha zerando dbResumo/dbOperaProd, que no legado acontece aqui mesmo -
    * ANTES do "If lnAnalise = 1" -, ou seja as duas grades de totais ficam
    * vazias quando o usuario nao pediu a analise de vendas.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarProdutos(par_cConta)
        LOCAL loc_cSQL, loc_lOk, loc_nCusto

        THIS.MostrarProgresso("Processando Produtos...")

        SELECT cursor_4c_ProdFor
        SET ORDER TO cpros
        THIS.ZapCursor("cursor_4c_ProdFor")

        loc_cSQL = "SELECT cpros, dpros, custofs, moecusfs, cunis, pvens, " + ;
                   "moedas, reffs, pesoms, linhas, situas FROM SigCdPro " + ;
                   "WHERE ifors = " + EscaparSQL(par_cConta) + ;
                   " ORDER BY cpros, dpros, custofs, moecusfs, cunis, " + ;
                   "pvens, moedas, reffs, pesoms, linhas"

        loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_ProSql")

        IF loc_lOk
            SELECT cursor_4c_ProSql
            SCAN
                loc_nCusto = NVL(cursor_4c_ProSql.custofs, 0)

                IF USED("crSigCdLin")
                    SELECT crSigCdLin
                    SET ORDER TO Linhas
                    IF SEEK(PADR(ALLTRIM(NVL(cursor_4c_ProSql.linhas, "")), 10))
                        IF ALLTRIM(NVL(crSigCdLin.tpcustos, "")) == "2"
                            loc_nCusto = NVL(cursor_4c_ProSql.pesoms, 0) * ;
                                         NVL(cursor_4c_ProSql.custofs, 0)
                        ENDIF
                    ENDIF
                ENDIF

                *-- marca = ' ': produto do PROPRIO fornecedor. O '*' eh posto
                *-- em ProcessarMovimentacao, para produto movimentado com este
                *-- fornecedor mas cadastrado em outro (TmpProFor.ifors <> conta).
                INSERT INTO cursor_4c_ProdFor ;
                    (cpros, custofs, moecusfs, marca, qtvend, vlvend, ;
                     estoque, cunis, pvens, moedas, reffs, dpros, situas) ;
                    VALUES (NVL(cursor_4c_ProSql.cpros, ""), ;
                            loc_nCusto, ;
                            NVL(cursor_4c_ProSql.moecusfs, ""), ;
                            " ", 0, 0, 0, ;
                            NVL(cursor_4c_ProSql.cunis, ""), ;
                            NVL(cursor_4c_ProSql.pvens, 0), ;
                            NVL(cursor_4c_ProSql.moedas, ""), ;
                            NVL(cursor_4c_ProSql.reffs, ""), ;
                            NVL(cursor_4c_ProSql.dpros, ""), ;
                            NVL(cursor_4c_ProSql.situas, 0))

                SELECT cursor_4c_ProSql
            ENDSCAN
            USE IN cursor_4c_ProSql
        ENDIF

        THIS.ZapCursor("cursor_4c_Resumo")
        THIS.ZapCursor("cursor_4c_OperaProd")

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarMovimentacao - o laco "For _FazEst = 1 To 2" do legado: varre
    * SigMvCab primeiro pelo par DESTINO (grupods/contads) e depois pelo par
    * ORIGEM (grupoos/contaos), e para cada operacao valida desce aos itens
    * (SigMvItn) acumulando dbResumo (total por operacao) e dbOperaProd
    * (operacao por produto).
    *
    * Filtros transcritos do legado:
    *   - so operacao de CAIXA (crSigCdOpe.caixas = 1) que gere movimento de
    *     estoque (GerGdmis 1 ou 2) - a versao antiga, por tipoops In
    *     (4,5,7,8), esta COMENTADA no SCX e nao foi portada;
    *   - quando o filtro Empresa esta preenchido, so a empresa dele.
    *
    * Conversao de moeda: quando a operacao NAO tem moeda propria, o legado
    * converte pela moeda padrao do sistema (CrSigCdPam.moedaps) e liga
    * _Converte; com moeda propria na operacao, usa a dela e NAO converte o
    * item. Tudo dividido por lnCotaConv (moeda do filtro) no fim.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarMovimentacao(par_cGrupo, par_cConta)
        LOCAL loc_lOk, loc_nFaz, loc_cSQL, loc_cDtIni, loc_cDtFim, loc_oBarra, ;
              loc_cOrigDest, loc_nCotaEst, loc_cEDNs, loc_nCotItem1, ;
              loc_nCotItem2, loc_nCotOper, loc_lConverte, loc_nValItem, ;
              loc_nCota, loc_nCusto, loc_cMarca, loc_cEmpresa, loc_cMoeda, ;
              loc_cOpeMoeda, loc_nPesoVts, loc_nPrecoVts

        loc_lOk      = .T.
        loc_cEmpresa = ALLTRIM(NVL(THIS.this_cEmpresa, ""))
        loc_cMoeda   = ALLTRIM(NVL(THIS.this_cMoeda, ""))

        *-- fDtoSQL(dataI) / fDtoSQL(dataF, '23:59:59') do legado: o periodo
        *-- fecha no ULTIMO segundo do dia final, senao o BETWEEN descartaria
        *-- tudo o que foi lancado depois da meia-noite do dia F.
        loc_cDtIni = FormatarDataSQL(ConverterParaData(THIS.this_dDataI))
        loc_cDtFim = FormatarDataSQL(THIS.LimiteFinalDoDia(THIS.this_dDataF))

        FOR loc_nFaz = 1 TO 2
            IF loc_nFaz = 1
                loc_cSQL = "SELECT emps, dopes, numes, valos FROM SigMvCab " + ;
                           "WHERE grupods = " + EscaparSQL(par_cGrupo) + ;
                           " AND contads = " + EscaparSQL(par_cConta) + ;
                           " AND datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + ;
                           " ORDER BY emps, dopes, numes, valos"
                loc_cOrigDest = "(Destino)..."
            ELSE
                loc_cSQL = "SELECT emps, dopes, numes, valos FROM SigMvCab " + ;
                           "WHERE grupoos = " + EscaparSQL(par_cGrupo) + ;
                           " AND contaos = " + EscaparSQL(par_cConta) + ;
                           " AND datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + ;
                           " ORDER BY emps, dopes, numes, valos"
                loc_cOrigDest = "(Origem)..."
            ENDIF

            loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_CabSql")

            IF !loc_lOk
                EXIT
            ENDIF

            loc_oBarra = THIS.CriarBarraProgresso( ;
                "Processando Movimenta" + CHR(231) + CHR(245) + "es - " + loc_cOrigDest, ;
                RECCOUNT("cursor_4c_CabSql"))

            SELECT cursor_4c_CabSql
            SCAN
                THIS.AtualizarBarra(loc_oBarra, ;
                    "Opera" + CHR(231) + CHR(227) + "o: " + ;
                    ALLTRIM(NVL(cursor_4c_CabSql.dopes, "")))

                SELECT crSigCdOpe
                SET ORDER TO Dopes
                =SEEK(PADR(ALLTRIM(NVL(cursor_4c_CabSql.dopes, "")), 20))
                loc_cOpeMoeda = ALLTRIM(NVL(crSigCdOpe.cmoes, ""))
                loc_nPesoVts  = NVL(crSigCdOpe.pesovts, 0)
                loc_nPrecoVts = NVL(crSigCdOpe.precovts, 0)

                IF !EMPTY(loc_cOpeMoeda) AND THIS.MoedaTemCotacao(loc_cOpeMoeda)
                    loc_nCotaEst = THIS.CarregarCambio(loc_cOpeMoeda, DATE())
                ELSE
                    loc_nCotaEst = 1
                ENDIF

                IF NVL(crSigCdOpe.caixas, 0) != 1 OR ;
                        !INLIST(NVL(crSigCdOpe.GerGdmis, 0), 1, 2)
                    SELECT cursor_4c_CabSql
                    LOOP
                ENDIF

                IF !EMPTY(loc_cEmpresa) AND ;
                        loc_cEmpresa != ALLTRIM(NVL(cursor_4c_CabSql.emps, ""))
                    SELECT cursor_4c_CabSql
                    LOOP
                ENDIF

                SELECT cursor_4c_Resumo
                SET ORDER TO dopes
                IF !SEEK(PADR(ALLTRIM(NVL(cursor_4c_CabSql.dopes, "")), 20))
                    INSERT INTO cursor_4c_Resumo (dopes) ;
                        VALUES (NVL(cursor_4c_CabSql.dopes, ""))
                ENDIF
                REPLACE valos WITH valos + ;
                    (NVL(cursor_4c_CabSql.valos, 0) * loc_nCotaEst / THIS.this_nCotaConv) ;
                    IN cursor_4c_Resumo

                *-- empdopnums eh chave POSICIONAL char(29) = emps char(3) +
                *-- dopes char(20) + Str(numes,6). O padding FAZ PARTE da
                *-- chave: ALLTRIM nas partes devolveria ZERO linhas em
                *-- silencio (3+20+6 = 29 = a largura da coluna destino).
                loc_cEDNs = PADR(NVL(cursor_4c_CabSql.emps, ""), 3) + ;
                            PADR(NVL(cursor_4c_CabSql.dopes, ""), 20) + ;
                            STR(NVL(cursor_4c_CabSql.numes, 0), 6)

                loc_cSQL = "SELECT cpros, qtds, moefats, moedas, tpesos, totas " + ;
                           "FROM SigMvItn WHERE empdopnums = " + EscaparSQL(loc_cEDNs) + ;
                           " ORDER BY cpros, qtds, moefats, moedas, tpesos, totas"

                loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_ItnSql")

                IF !loc_lOk
                    EXIT
                ENDIF

                SELECT cursor_4c_ItnSql
                SCAN
                    loc_cSQL = "SELECT cpros, ifors, custofs, moecusfs, pvens, " + ;
                               "reffs, dpros, cunis, moedas, situas FROM SigCdPro " + ;
                               "WHERE cpros = " + ;
                               EscaparSQL(ALLTRIM(NVL(cursor_4c_ItnSql.cpros, ""))) + ;
                               " ORDER BY cpros, ifors, custofs, moecusfs, " + ;
                               "pvens, reffs, dpros, cunis, moedas"

                    loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_ProForSql")

                    IF !loc_lOk
                        EXIT
                    ENDIF

                    SELECT cursor_4c_OperaProd
                    SET ORDER TO cprosdopes
                    IF !SEEK(PADR(NVL(cursor_4c_ItnSql.cpros, ""), 14) + ;
                             PADR(NVL(cursor_4c_CabSql.dopes, ""), 20))
                        INSERT INTO cursor_4c_OperaProd (cpros, dopes) ;
                            VALUES (NVL(cursor_4c_ItnSql.cpros, ""), ;
                                    NVL(cursor_4c_CabSql.dopes, ""))
                    ENDIF

                    loc_nCotItem1 = THIS.CarregarCambio(cursor_4c_ItnSql.moefats, DATE())
                    loc_nCotItem2 = THIS.CarregarCambio(cursor_4c_ItnSql.moedas, DATE())

                    IF EMPTY(loc_cOpeMoeda)
                        loc_nCotOper  = THIS.CarregarCambio(THIS.ObterMoedaPadrao(), DATE())
                        loc_lConverte = .T.
                    ELSE
                        loc_nCotOper  = THIS.CarregarCambio(loc_cOpeMoeda, DATE())
                        loc_lConverte = .F.
                    ENDIF

                    loc_nValItem = 0
                    IF loc_nPesoVts = 1
                        loc_nValItem = loc_nValItem + (NVL(cursor_4c_ItnSql.tpesos, 0) * ;
                            IIF(loc_lConverte, loc_nCotItem1 / loc_nCotOper, 1))
                    ENDIF
                    IF loc_nPrecoVts = 1
                        loc_nValItem = loc_nValItem + (NVL(cursor_4c_ItnSql.totas, 0) * ;
                            IIF(loc_lConverte, loc_nCotItem2 / loc_nCotOper, 1))
                    ENDIF

                    loc_nValItem = ROUND(loc_nValItem * loc_nCotOper / THIS.this_nCotaConv, 2)

                    REPLACE valos WITH valos + loc_nValItem, ;
                            qtds  WITH qtds  + NVL(cursor_4c_ItnSql.qtds, 0) ;
                        IN cursor_4c_OperaProd

                    *-- Produto movimentado com este fornecedor mas que NAO esta
                    *-- na lista dele: entra no dbProdFor com marca '*' quando o
                    *-- cadastro aponta OUTRO fornecedor.
                    SELECT cursor_4c_ProdFor
                    SET ORDER TO cpros
                    IF !SEEK(PADR(NVL(cursor_4c_ItnSql.cpros, ""), 14))
                        SELECT cursor_4c_ProForSql
                        GO TOP

                        IF !EOF() AND ;
                                ALLTRIM(NVL(cursor_4c_ProForSql.ifors, "")) != par_cConta
                            loc_cMarca = "*"
                        ELSE
                            loc_cMarca = " "
                        ENDIF

                        *-- O legado usa "Scatter Fields ... MemVar" + "Insert
                        *-- From MemVar" com uma lista que NAO inclui cpros, e
                        *-- por isso grava o m.cpros que sobrou do Scatter do
                        *-- laco de Produtos (memvar obsoleto). Aqui as colunas
                        *-- sao explicitas e cpros eh o do produto que esta
                        *-- sendo processado - que eh a intencao do bloco.
                        INSERT INTO cursor_4c_ProdFor ;
                            (cpros, custofs, moecusfs, marca, qtvend, vlvend, ;
                             estoque, cunis, pvens, moedas, reffs, dpros, situas) ;
                            VALUES (NVL(cursor_4c_ProForSql.cpros, ""), ;
                                    NVL(cursor_4c_ProForSql.custofs, 0), ;
                                    NVL(cursor_4c_ProForSql.moecusfs, ""), ;
                                    loc_cMarca, 0, 0, 0, ;
                                    NVL(cursor_4c_ProForSql.cunis, ""), ;
                                    NVL(cursor_4c_ProForSql.pvens, 0), ;
                                    NVL(cursor_4c_ProForSql.moedas, ""), ;
                                    NVL(cursor_4c_ProForSql.reffs, ""), ;
                                    NVL(cursor_4c_ProForSql.dpros, ""), ;
                                    NVL(cursor_4c_ProForSql.situas, 0))
                    ENDIF

                    SELECT cursor_4c_ProForSql
                    IF ALLTRIM(NVL(cursor_4c_ProForSql.moecusfs, "")) != loc_cMoeda
                        loc_nCota  = THIS.CarregarCambio(cursor_4c_ProForSql.moecusfs, DATE())
                        loc_nCota  = IIF(loc_nCota = 0, 1, loc_nCota)
                        loc_nCusto = ROUND(NVL(cursor_4c_ProForSql.custofs, 0) * ;
                                           loc_nCota / THIS.this_nCotaConv, 2)
                    ELSE
                        loc_nCusto = NVL(cursor_4c_ProForSql.custofs, 0)
                    ENDIF

                    REPLACE custofs WITH custofs + ;
                                (loc_nCusto * NVL(cursor_4c_ItnSql.qtds, 0)), ;
                            qtds    WITH qtds + NVL(cursor_4c_ItnSql.qtds, 0) ;
                        IN cursor_4c_Resumo

                    THIS.this_lSemDados = .F.

                    USE IN cursor_4c_ProForSql
                    SELECT cursor_4c_ItnSql
                ENDSCAN

                IF USED("cursor_4c_ItnSql")
                    USE IN cursor_4c_ItnSql
                ENDIF

                IF !loc_lOk
                    EXIT
                ENDIF

                SELECT cursor_4c_CabSql
            ENDSCAN

            THIS.FecharBarra(loc_oBarra)
            loc_oBarra = .NULL.

            IF USED("cursor_4c_CabSql")
                USE IN cursor_4c_CabSql
            ENDIF

            IF !loc_lOk
                EXIT
            ENDIF
        ENDFOR

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarVerificacaoMovimentacao - "Verificando Movimentacoes...": o
    * legado varre TODO o movimento do periodo (SigMvCab + SigMvItn +
    * SigCdOpe + SigCdTom, sem filtro de conta) e acumula em dbProdFor
    * APENAS os produtos que ja estao nele - isto eh, os do fornecedor
    * pesquisado - de onde saem as colunas Qt. Vendas / Valor Vendas.
    *
    * SAIDA (Opers = 'S') soma; ENTRADA (Opers = 'E') SUBTRAI - as duas com
    * GerGdmis = 1. O sinal eh regra de negocio e vai transcrito.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarVerificacaoMovimentacao()
        LOCAL loc_lOk, loc_cSQL, loc_cDtIni, loc_cDtFim, loc_oBarra, ;
              loc_nCotItem1, loc_nCotItem2, loc_nCotOper, loc_lConverte, ;
              loc_nValItem, loc_nCota, loc_nCusto, loc_cEmpresa, loc_cMoeda, ;
              loc_cOper, loc_nGerGdmis

        loc_cEmpresa = ALLTRIM(NVL(THIS.this_cEmpresa, ""))
        loc_cMoeda   = ALLTRIM(NVL(THIS.this_cMoeda, ""))

        THIS.MostrarProgresso("Verificando Movimenta" + CHR(231) + CHR(245) + "es...")

        loc_cDtIni = FormatarDataSQL(ConverterParaData(THIS.this_dDataI))
        loc_cDtFim = FormatarDataSQL(THIS.LimiteFinalDoDia(THIS.this_dDataF))

        loc_cSQL = "SELECT b.Opers, b.emps, b.dopes, b.numes, b.cpros, b.qtds, " + ;
                   "b.totas, b.moedas, b.moefats, b.tpesos, c.tipoops, c.cmoes, " + ;
                   "c.pesovts, c.precovts, t.GerGdmis " + ;
                   "FROM SigMvCab a, SigMvItn b, SigCdOpe c, SigCdTom t " + ;
                   "WHERE a.datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " AND "

        IF !EMPTY(loc_cEmpresa)
            loc_cSQL = loc_cSQL + "a.emps = " + EscaparSQL(loc_cEmpresa) + " AND "
        ENDIF

        loc_cSQL = loc_cSQL + ;
                   "b.empdopnums = a.empdopnums AND " + ;
                   "c.dopes = b.dopes AND " + ;
                   "c.TipoOps = t.Codigos AND " + ;
                   "t.GerGdmis In (1, 2) AND " + ;
                   "c.caixas = 1 " + ;
                   "ORDER BY b.emps, b.dopes, b.numes, b.cpros, b.qtds, " + ;
                   "b.totas, b.moedas, b.moefats, b.tpesos, c.tipoops, " + ;
                   "c.cmoes, c.pesovts, c.precovts"

        loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_MovSql")

        IF !loc_lOk
            RETURN .F.
        ENDIF

        loc_oBarra = THIS.CriarBarraProgresso( ;
            "Verificando Movimenta" + CHR(231) + CHR(245) + "es...", ;
            RECCOUNT("cursor_4c_MovSql"))

        SELECT cursor_4c_MovSql
        SCAN
            THIS.AtualizarBarra(loc_oBarra, ;
                ALLTRIM(NVL(cursor_4c_MovSql.emps, "")) + " - " + ;
                ALLTRIM(NVL(cursor_4c_MovSql.dopes, "")) + " - " + ;
                ALLTRIM(STR(NVL(cursor_4c_MovSql.numes, 0), 6)))

            loc_nCotItem1 = THIS.CarregarCambio(cursor_4c_MovSql.moefats, DATE())
            loc_nCotItem2 = THIS.CarregarCambio(cursor_4c_MovSql.moedas, DATE())

            IF EMPTY(ALLTRIM(NVL(cursor_4c_MovSql.cmoes, "")))
                loc_nCotOper  = THIS.CarregarCambio(THIS.ObterMoedaPadrao(), DATE())
                loc_lConverte = .T.
            ELSE
                loc_nCotOper  = THIS.CarregarCambio(cursor_4c_MovSql.cmoes, DATE())
                loc_lConverte = .F.
            ENDIF

            loc_nValItem = 0
            IF NVL(cursor_4c_MovSql.pesovts, 0) = 1
                loc_nValItem = loc_nValItem + (NVL(cursor_4c_MovSql.tpesos, 0) * ;
                    IIF(loc_lConverte, loc_nCotItem1 / loc_nCotOper, 1))
            ENDIF
            IF NVL(cursor_4c_MovSql.precovts, 0) = 1
                loc_nValItem = loc_nValItem + (NVL(cursor_4c_MovSql.totas, 0) * ;
                    IIF(loc_lConverte, loc_nCotItem2 / loc_nCotOper, 1))
            ENDIF

            loc_nValItem = ROUND(loc_nValItem * loc_nCotOper / THIS.this_nCotaConv, 2)
            loc_cOper    = UPPER(ALLTRIM(NVL(cursor_4c_MovSql.Opers, "")))
            loc_nGerGdmis = NVL(cursor_4c_MovSql.GerGdmis, 0)

            SELECT cursor_4c_ProdFor
            SET ORDER TO cpros
            IF SEEK(PADR(NVL(cursor_4c_MovSql.cpros, ""), 14))
                IF loc_cOper == "S" AND loc_nGerGdmis = 1
                    REPLACE qtvend WITH qtvend + NVL(cursor_4c_MovSql.qtds, 0), ;
                            vlvend WITH vlvend + loc_nValItem ;
                        IN cursor_4c_ProdFor
                ENDIF
                IF loc_cOper == "E" AND loc_nGerGdmis = 1
                    REPLACE qtvend WITH qtvend - NVL(cursor_4c_MovSql.qtds, 0), ;
                            vlvend WITH vlvend - loc_nValItem ;
                        IN cursor_4c_ProdFor
                ENDIF

                SELECT cursor_4c_OperaProd
                SET ORDER TO cprosdopes
                IF !SEEK(PADR(NVL(cursor_4c_MovSql.cpros, ""), 14) + ;
                         PADR(NVL(cursor_4c_MovSql.dopes, ""), 20))
                    INSERT INTO cursor_4c_OperaProd (cpros, dopes) ;
                        VALUES (NVL(cursor_4c_MovSql.cpros, ""), ;
                                NVL(cursor_4c_MovSql.dopes, ""))
                ENDIF
                REPLACE valos WITH valos + loc_nValItem, ;
                        qtds  WITH qtds  + NVL(cursor_4c_MovSql.qtds, 0) ;
                    IN cursor_4c_OperaProd

                SELECT cursor_4c_Resumo
                SET ORDER TO dopes
                IF !SEEK(PADR(NVL(cursor_4c_MovSql.dopes, ""), 20))
                    INSERT INTO cursor_4c_Resumo (dopes) ;
                        VALUES (NVL(cursor_4c_MovSql.dopes, ""))
                ENDIF
                REPLACE valos WITH valos + loc_nValItem IN cursor_4c_Resumo

                loc_cSQL = "SELECT cpros, ifors, custofs, moecusfs FROM SigCdPro " + ;
                           "WHERE cpros = " + ;
                           EscaparSQL(ALLTRIM(NVL(cursor_4c_MovSql.cpros, "")))

                loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_Pro2Sql")

                IF !loc_lOk
                    EXIT
                ENDIF

                SELECT cursor_4c_Pro2Sql
                GO TOP
                IF !EOF()
                    IF ALLTRIM(NVL(cursor_4c_Pro2Sql.moecusfs, "")) != loc_cMoeda
                        loc_nCota  = THIS.CarregarCambio(cursor_4c_Pro2Sql.moecusfs, DATE())
                        loc_nCota  = IIF(loc_nCota = 0, 1, loc_nCota)
                        loc_nCusto = ROUND(NVL(cursor_4c_Pro2Sql.custofs, 0) * ;
                                           loc_nCota / THIS.this_nCotaConv, 2)
                    ELSE
                        loc_nCusto = NVL(cursor_4c_Pro2Sql.custofs, 0)
                    ENDIF

                    REPLACE custofs WITH custofs + ;
                                (loc_nCusto * NVL(cursor_4c_MovSql.qtds, 0)), ;
                            qtds    WITH qtds + NVL(cursor_4c_MovSql.qtds, 0) ;
                        IN cursor_4c_Resumo
                ENDIF

                USE IN cursor_4c_Pro2Sql
            ENDIF

            SELECT cursor_4c_MovSql
        ENDSCAN

        THIS.FecharBarra(loc_oBarra)

        IF USED("cursor_4c_MovSql")
            USE IN cursor_4c_MovSql
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarEstoqueAtual - "Processando Estoque Atual...": soma em
    * dbProdFor.estoque o saldo de SigMvEst da conta de ESTOQUE do sistema
    * (CrSigCdPam.grupoests/contaests), empresa por empresa quando o filtro
    * Empresa esta vazio, ou so a empresa escolhida.
    *
    * empgruests eh chave POSICIONAL char(23) = emps(3) + grupo(10) +
    * conta(10): montada com PADR, nunca com ALLTRIM nas partes.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarEstoqueAtual()
        LOCAL loc_lOk, loc_oBarra, loc_cEmpresa

        loc_lOk      = .T.
        loc_cEmpresa = ALLTRIM(NVL(THIS.this_cEmpresa, ""))

        IF !USED("crSigCdEmp") OR !USED("crSigCdPam")
            RETURN .T.
        ENDIF

        IF EMPTY(loc_cEmpresa)
            loc_oBarra = THIS.CriarBarraProgresso("Processando Estoque Atual...", ;
                RECCOUNT("crSigCdEmp"))

            SELECT crSigCdEmp
            GO TOP
            SCAN
                THIS.AtualizarBarra(loc_oBarra, "Empresa: " + ;
                    ALLTRIM(NVL(crSigCdEmp.cemps, "")) + " - " + ;
                    ALLTRIM(NVL(crSigCdEmp.razas, "")))

                IF NVL(crSigCdEmp.ativas, 0) = 1
                    loc_lOk = THIS.SomarEstoqueEmpresa(NVL(crSigCdEmp.cemps, ""))
                    IF !loc_lOk
                        EXIT
                    ENDIF
                ENDIF

                SELECT crSigCdEmp
            ENDSCAN

            THIS.FecharBarra(loc_oBarra)
        ELSE
            SELECT crSigCdEmp
            SET ORDER TO Cemps
            =SEEK(PADR(loc_cEmpresa, 3))
            loc_lOk = THIS.SomarEstoqueEmpresa(NVL(crSigCdEmp.cemps, ""))
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * SomarEstoqueEmpresa - corpo do laco de ProcessarEstoqueAtual para UMA
    * empresa. O cursor de SQL passa por "SELECT * INTO CURSOR ... READWRITE"
    * antes do INDEX ON porque cursor de pass-through nasce somente-leitura e
    * nao aceita a criacao do indice que o SEEK do legado pressupoe.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION SomarEstoqueEmpresa(par_cEmpresa)
        LOCAL loc_cSQL, loc_cChave, loc_lOk

        loc_cChave = PADR(NVL(par_cEmpresa, ""), 3) + ;
                     PADR(NVL(crSigCdPam.grupoests, ""), 10) + ;
                     PADR(NVL(crSigCdPam.contaests, ""), 10)

        loc_cSQL = "SELECT emps, cpros, sqtds FROM SigMvEst " + ;
                   "WHERE empgruests = " + EscaparSQL(loc_cChave) + ;
                   " ORDER BY emps, cpros, sqtds"

        loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_Est1Sql")

        IF loc_lOk
            IF USED("cursor_4c_Est1")
                USE IN cursor_4c_Est1
            ENDIF
            SELECT * FROM cursor_4c_Est1Sql INTO CURSOR cursor_4c_Est1 READWRITE
            USE IN cursor_4c_Est1Sql

            SELECT cursor_4c_Est1
            INDEX ON emps + cpros TAG EmpPro
            GO TOP

            SELECT cursor_4c_ProdFor
            SET ORDER TO cpros
            GO TOP
            SCAN
                IF SEEK(PADR(NVL(par_cEmpresa, ""), 3) + ;
                        PADR(NVL(cursor_4c_ProdFor.cpros, ""), 14), ;
                        "cursor_4c_Est1", "EmpPro")
                    REPLACE estoque WITH estoque + NVL(cursor_4c_Est1.sqtds, 0) ;
                        IN cursor_4c_ProdFor
                ENDIF
                SELECT cursor_4c_ProdFor
            ENDSCAN

            USE IN cursor_4c_Est1
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarEstoqueFornecedor - "Processando Estoque do Fornecedor...":
    * SigMvEst da conta do PROPRIO fornecedor -> dbEstoque, a grade "Produtos
    * em seu poder" da aba Estoque. Varre TODAS as empresas ativas,
    * independentemente do filtro Empresa (assim faz o legado).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarEstoqueFornecedor(par_cGrupo, par_cConta)
        LOCAL loc_lOk, loc_oBarra, loc_cSQL, loc_cChave

        loc_lOk = .T.
        THIS.ZapCursor("cursor_4c_Estoque")

        IF !USED("crSigCdEmp")
            RETURN .T.
        ENDIF

        loc_oBarra = THIS.CriarBarraProgresso( ;
            "Processando Estoque do Fornecedor...", RECCOUNT("crSigCdEmp"))

        SELECT crSigCdEmp
        GO TOP
        SCAN
            THIS.AtualizarBarra(loc_oBarra, "Empresa: " + ;
                ALLTRIM(NVL(crSigCdEmp.cemps, "")) + " - " + ;
                ALLTRIM(NVL(crSigCdEmp.razas, "")))

            IF NVL(crSigCdEmp.ativas, 0) = 1
                loc_cChave = PADR(NVL(crSigCdEmp.cemps, ""), 3) + ;
                             PADR(par_cGrupo, 10) + PADR(par_cConta, 10)

                loc_cSQL = "SELECT cpros, sqtds FROM SigMvEst " + ;
                           "WHERE empgruests = " + EscaparSQL(loc_cChave) + ;
                           " ORDER BY cpros, sqtds"

                loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_Est2Sql")

                IF !loc_lOk
                    EXIT
                ENDIF

                SELECT cursor_4c_Est2Sql
                SCAN
                    INSERT INTO cursor_4c_Estoque (cpros, sqtds) ;
                        VALUES (NVL(cursor_4c_Est2Sql.cpros, ""), ;
                                NVL(cursor_4c_Est2Sql.sqtds, 0))
                    THIS.this_lSemDados = .F.
                    SELECT cursor_4c_Est2Sql
                ENDSCAN

                USE IN cursor_4c_Est2Sql
            ENDIF

            SELECT crSigCdEmp
        ENDSCAN

        THIS.FecharBarra(loc_oBarra)

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarConsertos - "Processando Consertos...": operacoes de conserto
    * (CrSigCdPam.opconfors = conserto de cliente, opconsljs = conserto de
    * loja) AINDA NAO baixadas (chksubn falso) -> dbConserto. Varre os dois
    * pares de SigMvCab: ORIGEM (grupoos/contaos) e DESTINO (grupods/contads).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarConsertos(par_cGrupo, par_cConta)
        LOCAL loc_lOk

        THIS.MostrarProgresso("Processando Consertos...")
        THIS.ZapCursor("cursor_4c_Conserto")

        IF USED("crSigCdPam")
            SELECT crSigCdPam
            GO TOP
        ENDIF

        loc_lOk = THIS.CarregarConsertosPar(par_cGrupo, par_cConta, "grupoos", "contaos")

        IF loc_lOk
            loc_lOk = THIS.CarregarConsertosPar(par_cGrupo, par_cConta, "grupods", "contads")
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarConsertosPar - corpo repetido duas vezes no legado (TprMvCab3 e
    * TprMvCab4), com as colunas de ORIGEM e de DESTINO.
    *
    * A comparacao da operacao usa ALLTRIM(...) == ALLTRIM(...) de proposito:
    * a data session privada do form (DataSession = 2) reseta SET EXACT para
    * OFF, e com EXACT OFF o "=" do legado viraria comparacao por PREFIXO -
    * com opconfors em branco, casaria com TODA operacao. O "==" reproduz o
    * comportamento do legado, que roda com SET EXACT ON.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarConsertosPar(par_cGrupo, par_cConta, par_cColGrupo, par_cColConta)
        LOCAL loc_cSQL, loc_lOk, loc_cOpe, loc_cOpConFor, loc_cOpConSlj, loc_cOperDesc

        loc_cOpConFor = ALLTRIM(NVL(crSigCdPam.opconfors, ""))
        loc_cOpConSlj = ALLTRIM(NVL(crSigCdPam.opconsljs, ""))

        loc_cSQL = "SELECT emps, dopes, numes, datas, chksubn, obses, MascNum " + ;
                   "FROM SigMvCab " + ;
                   "WHERE " + par_cColGrupo + " = " + EscaparSQL(PADR(par_cGrupo, 10)) + ;
                   " AND " + par_cColConta + " = " + EscaparSQL(PADR(par_cConta, 10)) + ;
                   " ORDER BY emps, dopes, numes, datas, chksubn"

        loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_ConSql")

        IF loc_lOk
            SELECT cursor_4c_ConSql
            SCAN
                loc_cOpe = ALLTRIM(NVL(cursor_4c_ConSql.dopes, ""))

                IF (loc_cOpe == loc_cOpConFor OR loc_cOpe == loc_cOpConSlj) AND ;
                        !THIS.BitParaLogico(cursor_4c_ConSql.chksubn)

                    IF loc_cOpe == loc_cOpConFor
                        loc_cOperDesc = "C.Cliente : " + ;
                            ALLTRIM(NVL(cursor_4c_ConSql.mascnum, ""))
                    ELSE
                        loc_cOperDesc = "C.Loja : " + ;
                            ALLTRIM(NVL(cursor_4c_ConSql.mascnum, ""))
                    ENDIF

                    INSERT INTO cursor_4c_Conserto (datas, emps, opers, obscon) ;
                        VALUES (THIS.DataDoCursor(cursor_4c_ConSql.datas), ;
                                NVL(cursor_4c_ConSql.emps, ""), ;
                                PADR(loc_cOperDesc, 27), ;
                                PADR(LEFT(NVL(cursor_4c_ConSql.obses, ""), 50), 50))

                    THIS.this_lSemDados = .F.
                ENDIF

                SELECT cursor_4c_ConSql
            ENDSCAN

            USE IN cursor_4c_ConSql
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPendencias - "Processando Pendencias...": tres fontes somadas
    * em dbParcela (grade "Pendencias"):
    *   1. parcelas de SigMvPar das operacoes de ORIGEM  (grupoos/contaos);
    *   2. parcelas de SigMvPar das operacoes de DESTINO (grupods/contads);
    *   3. lancamentos em aberto de conta corrente (SigMvCcr).
    * So entra o que ainda tem saldo (valos - vpags > 0).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPendencias(par_cGrupo, par_cConta)
        LOCAL loc_lOk

        THIS.MostrarProgresso("Processando Pend" + CHR(234) + "ncias...")
        THIS.ZapCursor("cursor_4c_Parcela")

        loc_lOk = THIS.CarregarParcelasPar(par_cGrupo, par_cConta, "grupoos", "contaos")

        IF loc_lOk
            loc_lOk = THIS.CarregarParcelasPar(par_cGrupo, par_cConta, "grupods", "contads")
        ENDIF

        IF loc_lOk
            loc_lOk = THIS.CarregarPendenciasContaCorrente(par_cGrupo, par_cConta)
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParcelasPar - corpo repetido duas vezes no legado (TprMvCab5 /
    * TmpPar1 e TprMvCab6 / TmpPar2).
    *
    * Dois filtros do legado que NAO se descartam:
    *   - a OPERACAO precisa gerar pendencia (crSigCdOpe.valpends = 1);
    *   - a FORMA DE PAGAMENTO tambem (crSigOpFp.valpends = 1); e quando ela
    *     eh cheque (infos = 'C'), o cheque so conta se ainda nao foi
    *     movimentado para fora de 'CR' (SigChe.umovs -> SigCdOpt.tipos).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarParcelasPar(par_cGrupo, par_cConta, par_cColGrupo, par_cColConta)
        LOCAL loc_cSQL, loc_lOk, loc_cEDNs, loc_nValor, loc_cHist, loc_lPula

        loc_cSQL = "SELECT emps, dopes, numes FROM SigMvCab " + ;
                   "WHERE " + par_cColGrupo + " = " + EscaparSQL(PADR(par_cGrupo, 10)) + ;
                   " AND " + par_cColConta + " = " + EscaparSQL(PADR(par_cConta, 10)) + ;
                   " ORDER BY emps, dopes, numes"

        loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_ParCabSql")

        IF !loc_lOk
            RETURN .F.
        ENDIF

        SELECT cursor_4c_ParCabSql
        SCAN
            SELECT crSigCdOpe
            SET ORDER TO Dopes
            =SEEK(PADR(ALLTRIM(NVL(cursor_4c_ParCabSql.dopes, "")), 20))

            IF NVL(crSigCdOpe.valpends, 0) != 1
                SELECT cursor_4c_ParCabSql
                LOOP
            ENDIF

            *-- empdopnums: chave POSICIONAL char(29), montada com PADR
            loc_cEDNs = PADR(NVL(cursor_4c_ParCabSql.emps, ""), 3) + ;
                        PADR(NVL(cursor_4c_ParCabSql.dopes, ""), 20) + ;
                        STR(NVL(cursor_4c_ParCabSql.numes, 0), 6)

            loc_cSQL = "SELECT emps, dopes, numes, bancos, agencias, contas, " + ;
                       "numeros, fpags, valos, vpags, vencs, moefpgs " + ;
                       "FROM SigMvPar WHERE empdopnums = " + EscaparSQL(loc_cEDNs) + ;
                       " ORDER BY vencs, emps, dopes, numes, bancos, agencias, " + ;
                       "contas, numeros, fpags, valos, vpags, moefpgs"

            loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_ParSql")

            IF !loc_lOk
                EXIT
            ENDIF

            SELECT cursor_4c_ParSql
            SCAN
                SELECT crSigOpFp
                SET ORDER TO FPags
                =SEEK(PADR(ALLTRIM(NVL(cursor_4c_ParSql.fpags, "")), 12))

                IF NVL(crSigOpFp.valpends, 0) != 1
                    SELECT cursor_4c_ParSql
                    LOOP
                ENDIF

                loc_lPula = .F.

                IF ALLTRIM(NVL(crSigOpFp.infos, "")) == "C"
                    loc_lPula = THIS.ChequeJaMovimentado( ;
                        NVL(cursor_4c_ParSql.bancos, ""), ;
                        NVL(cursor_4c_ParSql.agencias, ""), ;
                        NVL(cursor_4c_ParSql.contas, ""), ;
                        NVL(cursor_4c_ParSql.numeros, ""))
                ENDIF

                IF loc_lPula
                    SELECT cursor_4c_ParSql
                    LOOP
                ENDIF

                loc_cHist = ALLTRIM(NVL(cursor_4c_ParSql.fpags, "")) + " - " + ;
                            ALLTRIM(NVL(cursor_4c_ParSql.emps, "")) + ;
                            ALLTRIM(NVL(cursor_4c_ParSql.dopes, "")) + ":" + ;
                            fGerMascara(NVL(cursor_4c_ParSql.numes, 0))

                loc_nValor = NVL(cursor_4c_ParSql.valos, 0) - ;
                             NVL(cursor_4c_ParSql.vpags, 0)

                IF loc_nValor > 0
                    INSERT INTO cursor_4c_Parcela ;
                        (vencs, emps, fpags, valos, moefpgs, dopes, numes, hists) ;
                        VALUES (THIS.DataDoCursor(cursor_4c_ParSql.vencs), ;
                                NVL(cursor_4c_ParSql.emps, ""), ;
                                NVL(cursor_4c_ParSql.fpags, ""), ;
                                loc_nValor, ;
                                NVL(cursor_4c_ParSql.moefpgs, ""), ;
                                NVL(cursor_4c_ParSql.dopes, ""), ;
                                NVL(cursor_4c_ParSql.numes, 0), ;
                                loc_cHist)
                    THIS.this_lSemDados = .F.
                ENDIF

                SELECT cursor_4c_ParSql
            ENDSCAN

            USE IN cursor_4c_ParSql
            SELECT cursor_4c_ParCabSql
        ENDSCAN

        IF USED("cursor_4c_ParCabSql")
            USE IN cursor_4c_ParCabSql
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ChequeJaMovimentado - bloco "If CrSigOpFp.infos = 'C'" do legado: o
    * cheque da parcela deixa de ser pendencia quando ja foi movimentado para
    * uma operacao de caixa que nao eh 'CR'.
    *
    * Cheque NAO encontrado em SigChe nao pula a parcela (o legado so testa
    * dentro de "If !Eof()").
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ChequeJaMovimentado(par_cBanco, par_cAgencia, par_cConta, par_cNumero)
        LOCAL loc_cSQL, loc_lPula

        loc_lPula = .F.

        loc_cSQL = "SELECT umovs FROM SigChe " + ;
                   "WHERE bancos = " + EscaparSQL(ALLTRIM(par_cBanco)) + ;
                   " AND agencias = " + EscaparSQL(ALLTRIM(par_cAgencia)) + ;
                   " AND ncontas = " + EscaparSQL(ALLTRIM(par_cConta)) + ;
                   " AND ncheques = " + EscaparSQL(ALLTRIM(par_cNumero))

        IF THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_CheSql")
            SELECT cursor_4c_CheSql
            GO TOP
            IF !EOF()
                SELECT crSigCdOpt
                SET ORDER TO Operacaos
                IF SEEK(PADR(ALLTRIM(NVL(cursor_4c_CheSql.umovs, "")), 15))
                    loc_lPula = (ALLTRIM(NVL(crSigCdOpt.tipos, "")) != "CR")
                ENDIF
            ENDIF
            USE IN cursor_4c_CheSql
        ENDIF

        RETURN loc_lPula
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPendenciasContaCorrente - terceira fonte de dbParcela: os
    * lancamentos de SigMvCcr ainda em aberto (valors - valpags > 0).
    *
    * ATENCAO ao tamanho da chave: o legado monta lcGCMs com Padr(grupo,10) +
    * Padr(conta,10) = 20 caracteres e compara com gruconmoes, que eh
    * char(23) (grupo + conta + MOEDA). Pelo padding ANSI do SQL Server, uma
    * chave de 20 caracteres casa apenas com as linhas cujo segmento de moeda
    * esta em branco. Transcrito literalmente (regra #17 - a abrangencia do
    * filtro eh regra de negocio, nao detalhe de migracao), mas registrado
    * aqui porque eh contra-intuitivo ao ler a tela de Pendencias.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarPendenciasContaCorrente(par_cGrupo, par_cConta)
        LOCAL loc_cSQL, loc_lOk, loc_cChave, loc_nValor

        loc_cChave = PADR(par_cGrupo, 10) + PADR(par_cConta, 10)

        loc_cSQL = "SELECT emps, dopes, numes, hists, vencs, " + ;
                   "moedas AS moefpgs, opers, nopers, valors, valpags " + ;
                   "FROM SigMvCcr " + ;
                   "WHERE gruconmoes = " + EscaparSQL(loc_cChave) + ;
                   " AND ( ( dopes = " + EscaparSQL(SPACE(20)) + " AND numes = 0 ) " + ;
                   "OR ( dopes <> ' ' AND numes <> 0 AND Tipos = 'X' ) ) " + ;
                   "AND opers <> 'D' AND nopers <> 0 " + ;
                   "ORDER BY vencs, emps, dopes, numes, hists, moedas, " + ;
                   "opers, nopers, valors, valpags"

        loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_CcrSql")

        IF loc_lOk
            SELECT cursor_4c_CcrSql
            SCAN
                loc_nValor = NVL(cursor_4c_CcrSql.valors, 0) - ;
                             NVL(cursor_4c_CcrSql.valpags, 0)

                IF loc_nValor > 0
                    *-- fpags fica vazio: o legado usa "Insert From MemVar" e
                    *-- esta consulta nao traz a forma de pagamento.
                    INSERT INTO cursor_4c_Parcela ;
                        (vencs, emps, fpags, valos, moefpgs, dopes, numes, hists) ;
                        VALUES (THIS.DataDoCursor(cursor_4c_CcrSql.vencs), ;
                                NVL(cursor_4c_CcrSql.emps, ""), ;
                                "", ;
                                loc_nValor, ;
                                NVL(cursor_4c_CcrSql.moefpgs, ""), ;
                                NVL(cursor_4c_CcrSql.dopes, ""), ;
                                NVL(cursor_4c_CcrSql.numes, 0), ;
                                NVL(cursor_4c_CcrSql.hists, ""))
                    THIS.this_lSemDados = .F.
                ENDIF

                SELECT cursor_4c_CcrSql
            ENDSCAN

            USE IN cursor_4c_CcrSql
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * MoedaTemCotacao - o "Seek(cmoes,'CrSigCdCot','cmoes')" que o legado faz
    * ANTES de chamar fCarregarCambio no laco de movimentacao (sem cotacao
    * cadastrada, a taxa fica 1).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MoedaTemCotacao(par_cMoeda)
        IF !USED("crSigCdCot") OR EMPTY(NVL(par_cMoeda, ""))
            RETURN .F.
        ENDIF

        SELECT crSigCdCot
        SET ORDER TO CMoes

        RETURN SEEK(PADR(ALLTRIM(par_cMoeda), 3))
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterMoedaPadrao - CrSigCdPam.moedaps, a moeda padrao do sistema, usada
    * para converter item de operacao que nao tem moeda propria.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterMoedaPadrao()
        IF !USED("crSigCdPam") OR RECCOUNT("crSigCdPam") = 0
            RETURN ""
        ENDIF

        RETURN ALLTRIM(TratarNulo(crSigCdPam.moedaps, ""))
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParametrosGrupo - "=Seek(lcGrEst,'CrSigCdGcr','Codigos')" do fim
    * de Processa: guarda mfotos, que decide se a Pagina Resultado mostra a
    * foto do fornecedor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarParametrosGrupo(par_cGrupo)
        THIS.this_nMFotos = 0

        IF USED("crSigCdGcr")
            SELECT crSigCdGcr
            SET ORDER TO Codigos
            IF SEEK(PADR(ALLTRIM(NVL(par_cGrupo, "")), 10))
                THIS.this_nMFotos = NVL(crSigCdGcr.mfotos, 0)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PosicionarCursores - os "Select dbX / Go Top" do legado. Popular cursor
    * NAO repinta a grade: sem GO TOP + Grid.Refresh (que o Form faz em
    * CarregarLista) a grade fica visualmente vazia com o cursor cheio.
    *--------------------------------------------------------------------------
    PROCEDURE PosicionarCursores()
        LOCAL loc_aCur[8], loc_nI

        loc_aCur[1] = "cursor_4c_Saldo"
        loc_aCur[2] = "cursor_4c_Historico"
        loc_aCur[3] = "cursor_4c_ProdFor"
        loc_aCur[4] = "cursor_4c_Resumo"
        loc_aCur[5] = "cursor_4c_OperaProd"
        loc_aCur[6] = "cursor_4c_Estoque"
        loc_aCur[7] = "cursor_4c_Conserto"
        loc_aCur[8] = "cursor_4c_Parcela"

        FOR loc_nI = 1 TO 8
            IF USED(loc_aCur[loc_nI])
                SELECT (loc_aCur[loc_nI])
                GO TOP
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosImpressao - espelha o metodo ProcImp() do legado, que monta
    * os DOIS cursores que o FRX SigOpCgc consome.
    *
    * Os nomes TmpRelat e TmpFinal sao CONTRATO com o FRX, nao escolha de
    * nomenclatura: o .frt referencia TmpFinal.tEstoque / tCusto / tVenda
    * explicitamente, e o cursor de dados eh lido pelo alias corrente. O
    * mesmo vale para a variavel PUBLIC _Moeda, impressa no cabecalho.
    *
    * par_nOpcao  = ImprimeOpcoes.Opcao.Value - 1 = so o produto selecionado,
    *               2 = todos os produtos, 3 = todos COM movimentacao.
    * par_nFiltro = OptSituas.Value da aba Movimentacao - 1 = Ativo,
    *               2 = Inativo, 3 = Ambos (sem filtro).
    *
    * As variaveis locais aparecem com o prefixo "m." dentro dos SELECT VFP:
    * sem ele o otimizador resolve o identificador como COLUNA e estoura
    * "SQL: Column 'LOC_NFILTRO' is not found".
    *--------------------------------------------------------------------------
    FUNCTION PrepararDadosImpressao(par_nOpcao, par_nFiltro)
        LOCAL loc_lOk, loc_oErro, loc_nFiltro, loc_nOpcao

        loc_lOk     = .F.
        loc_nOpcao  = INT(NVL(par_nOpcao, 2))
        loc_nFiltro = INT(NVL(par_nFiltro, 3))

        TRY
            *-- _Fornece / _Moeda / _Produto: PUBLIC no legado porque o FRX as
            *-- le direto. Mantidas PUBLIC aqui pelo mesmo motivo, com espelho
            *-- nas properties do BO para quem precisar delas em codigo.
            PUBLIC _Fornece, _Moeda, _Produto

            THIS.this_cFornece = "Conta : " + ALLTRIM(NVL(THIS.this_cGrupo, "")) + ;
                " / " + ALLTRIM(NVL(THIS.this_cConta, "")) + " [ " + ;
                ALLTRIM(NVL(THIS.this_cDConta, "")) + " ] "

            THIS.this_cMoedaRelatorio = ALLTRIM(NVL(THIS.this_cMoeda, ""))

            THIS.this_cProdutoAtual = ""
            IF USED("cursor_4c_ProdFor") AND !EOF("cursor_4c_ProdFor")
                THIS.this_cProdutoAtual = cursor_4c_ProdFor.cpros
            ENDIF

            _Fornece = THIS.this_cFornece
            _Moeda   = THIS.this_cMoedaRelatorio
            _Produto = THIS.this_cProdutoAtual

            IF USED("TmpTot1")
                USE IN TmpTot1
            ENDIF
            SELECT SUM(custofs * estoque) AS custofs, moecusfs ;
                FROM cursor_4c_ProdFor ;
                GROUP BY moecusfs ;
                INTO CURSOR TmpTot1 READWRITE

            IF USED("TmpTot2")
                USE IN TmpTot2
            ENDIF
            SELECT SUM(pvens * estoque) AS pvens, moedas ;
                FROM cursor_4c_ProdFor ;
                GROUP BY moedas ;
                INTO CURSOR TmpTot2 READWRITE

            *-- Linha de TOTAIS do relatorio (coluna = 4). O cpros preenchido
            *-- com Chr(255) garante que ela ordene DEPOIS de qualquer produto.
            IF USED("TmpTot3")
                USE IN TmpTot3
            ENDIF
            SELECT 4 AS coluna, PADR(REPLICATE(CHR(255), 2), 14) AS cpros, ;
                   c.custofs, c.moecusfs, SPACE(1) AS marca, 0 AS qtvend, ;
                   0 AS vlvend, 0 AS estoque, SPACE(3) AS cunis, v.pvens, ;
                   v.moedas, SPACE(40) AS reffs, SPACE(40) AS dpros, ;
                   SPACE(20) AS dopes, 0 AS qtds, 0 AS valos, ;
                   m._Fornece AS fornece ;
                FROM TmpTot1 c ;
                FULL JOIN TmpTot2 v ON c.moecusfs = v.moedas ;
                INTO CURSOR TmpTot3 READWRITE

            IF USED("TmpRelat")
                USE IN TmpRelat
            ENDIF

            DO CASE
                CASE loc_nOpcao = 1
                    *-- so o produto selecionado na grade
                    SELECT 1 AS coluna, a.*, b.dopes, b.qtds, b.valos, ;
                           m._Fornece AS fornece ;
                        FROM cursor_4c_ProdFor a ;
                        LEFT JOIN cursor_4c_OperaProd b ON a.cpros = b.cpros ;
                        WHERE a.cpros = m._Produto ;
                          AND IIF(m.loc_nFiltro != 3, a.situas = m.loc_nFiltro, .T.) ;
                        INTO CURSOR TmpRelat READWRITE

                CASE loc_nOpcao = 2
                    *-- todos os produtos + total por operacao + total por
                    *-- unidade + a linha de totais de TmpTot3
                    SELECT 1 AS coluna, a.*, b.dopes, b.qtds, b.valos, ;
                           m._Fornece AS fornece ;
                        FROM cursor_4c_ProdFor a ;
                        LEFT JOIN cursor_4c_OperaProd b ON a.cpros = b.cpros ;
                        WHERE IIF(m.loc_nFiltro != 3, a.situas = m.loc_nFiltro, .T.) ;
                    UNION ALL ;
                    SELECT 2 AS coluna, SPACE(14) AS cpros, c.custofs, ;
                           SPACE(3) AS moecusfs, SPACE(1) AS marca, 0 AS qtvend, ;
                           0 AS vlvend, 0 AS estoque, SPACE(3) AS cunis, ;
                           0 AS pvens, SPACE(3) AS moedas, SPACE(40) AS reffs, ;
                           SPACE(40) AS dpros, 1 AS situas, c.dopes, 0 AS qtds, ;
                           c.valos, m._Fornece AS fornece ;
                        FROM cursor_4c_Resumo c ;
                    UNION ALL ;
                    SELECT 3 AS coluna, PADR(CHR(255), 14) AS cpros, 0 AS custofs, ;
                           SPACE(3) AS moecusfs, SPACE(1) AS marca, 0 AS qtvend, ;
                           0 AS vlvend, SUM(d.estoque) AS estoque, d.cunis, ;
                           0 AS pvens, SPACE(3) AS moedas, SPACE(40) AS reffs, ;
                           SPACE(40) AS dpros, d.situas, SPACE(20) AS dopes, ;
                           0 AS qtds, 0 AS valos, m._Fornece AS fornece ;
                        FROM cursor_4c_ProdFor d ;
                        WHERE IIF(m.loc_nFiltro != 3, d.situas = m.loc_nFiltro, .T.) ;
                        GROUP BY d.cunis, d.situas ;
                    UNION ALL ;
                    SELECT e.coluna, e.cpros, IIF(ISNULL(e.custofs), 0, e.custofs) AS custofs, ;
                           IIF(ISNULL(e.moecusfs), SPACE(3), e.moecusfs) AS moecusfs, ;
                           e.marca, e.qtvend, e.vlvend, e.estoque, e.cunis, ;
                           IIF(ISNULL(e.pvens), 0, e.pvens) AS pvens, ;
                           IIF(ISNULL(e.moedas), SPACE(3), e.moedas) AS moedas, ;
                           e.reffs, e.dpros, 1 AS situas, e.dopes, e.qtds, ;
                           e.valos, e.fornece ;
                        FROM TmpTot3 e ;
                        ORDER BY 1, 2, 14 ;
                        INTO CURSOR TmpRelat READWRITE

                OTHERWISE
                    *-- Opcao 3 - identica a 2, mas o primeiro SELECT usa JOIN
                    *-- INTERNO: so produto que TEM movimentacao no periodo.
                    SELECT 1 AS coluna, a.*, b.dopes, b.qtds, b.valos, ;
                           m._Fornece AS fornece ;
                        FROM cursor_4c_ProdFor a, cursor_4c_OperaProd b ;
                        WHERE a.cpros = b.cpros ;
                          AND IIF(m.loc_nFiltro != 3, a.situas = m.loc_nFiltro, .T.) ;
                    UNION ALL ;
                    SELECT 2 AS coluna, SPACE(14) AS cpros, c.custofs, ;
                           SPACE(3) AS moecusfs, SPACE(1) AS marca, 0 AS qtvend, ;
                           0 AS vlvend, 0 AS estoque, SPACE(3) AS cunis, ;
                           0 AS pvens, SPACE(3) AS moedas, SPACE(40) AS reffs, ;
                           SPACE(40) AS dpros, 1 AS situas, c.dopes, 0 AS qtds, ;
                           c.valos, m._Fornece AS fornece ;
                        FROM cursor_4c_Resumo c ;
                    UNION ALL ;
                    SELECT 3 AS coluna, PADR(CHR(255), 14) AS cpros, 0 AS custofs, ;
                           SPACE(3) AS moecusfs, SPACE(1) AS marca, 0 AS qtvend, ;
                           0 AS vlvend, SUM(d.estoque) AS estoque, d.cunis, ;
                           0 AS pvens, SPACE(3) AS moedas, SPACE(40) AS reffs, ;
                           SPACE(40) AS dpros, d.situas, SPACE(20) AS dopes, ;
                           0 AS qtds, 0 AS valos, m._Fornece AS fornece ;
                        FROM cursor_4c_ProdFor d ;
                        WHERE IIF(m.loc_nFiltro != 3, d.situas = m.loc_nFiltro, .T.) ;
                        GROUP BY d.cunis, d.situas ;
                    UNION ALL ;
                    SELECT e.coluna, e.cpros, IIF(ISNULL(e.custofs), 0, e.custofs) AS custofs, ;
                           IIF(ISNULL(e.moecusfs), SPACE(3), e.moecusfs) AS moecusfs, ;
                           e.marca, e.qtvend, e.vlvend, e.estoque, e.cunis, ;
                           IIF(ISNULL(e.pvens), 0, e.pvens) AS pvens, ;
                           IIF(ISNULL(e.moedas), SPACE(3), e.moedas) AS moedas, ;
                           e.reffs, e.dpros, 1 AS situas, e.dopes, e.qtds, ;
                           e.valos, e.fornece ;
                        FROM TmpTot3 e ;
                        ORDER BY 1, 2, 14 ;
                        INTO CURSOR TmpRelat READWRITE
            ENDCASE

            loc_lOk = THIS.MontarTotaisImpressao(loc_nOpcao, loc_nFiltro)
        CATCH TO loc_oErro
            loc_lOk = .F.
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro ao preparar a impress" + CHR(227) + "o")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarTotaisImpressao - o cursor TmpFinal do ProcImp legado (totais de
    * estoque, custo e venda convertidos para a moeda do filtro).
    *
    * O legado monta isso com um SELECT ... Sum(... fCarregarCambio(...) ...)
    * Group by 1. Aqui o somatorio eh feito por SCAN: fCarregarCambio nao
    * existe como funcao global (nao foi portada) e a cotacao vem de
    * THIS.CarregarCambio, que nao se pode chamar de dentro de um SELECT. O
    * resultado numerico eh o mesmo - muda apenas por onde a conta passa.
    *
    * Na Opcao 1 o legado cria TmpFinal VAZIO (o relatorio de um produto so
    * nao imprime totais) - reproduzido deixando o cursor sem registro.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarTotaisImpressao(par_nOpcao, par_nFiltro)
        LOCAL loc_nEstoque, loc_nCusto, loc_nVenda, loc_nCotMoeda, ;
              loc_nCotCusto, loc_nCotVenda

        IF USED("TmpFinal")
            USE IN TmpFinal
        ENDIF

        CREATE CURSOR TmpFinal ( ;
            Agrupar C(1), TEstoque N(16,3), TCusto N(16,2), TVenda N(16,2))

        IF par_nOpcao = 1
            RETURN .T.
        ENDIF

        loc_nEstoque  = 0
        loc_nCusto    = 0
        loc_nVenda    = 0
        loc_nCotMoeda = THIS.CarregarCambio(THIS.this_cMoedaRelatorio, DATE())

        IF USED("cursor_4c_ProdFor")
            SELECT cursor_4c_ProdFor
            GO TOP
            SCAN
                IF par_nFiltro != 3 AND NVL(cursor_4c_ProdFor.situas, 0) != par_nFiltro
                    SELECT cursor_4c_ProdFor
                    LOOP
                ENDIF

                loc_nCotCusto = THIS.CarregarCambio(cursor_4c_ProdFor.moecusfs, DATE())
                loc_nCotVenda = THIS.CarregarCambio(cursor_4c_ProdFor.moedas, DATE())

                loc_nEstoque = loc_nEstoque + NVL(cursor_4c_ProdFor.estoque, 0)

                loc_nCusto = loc_nCusto + (NVL(cursor_4c_ProdFor.estoque, 0) * ;
                    (NVL(cursor_4c_ProdFor.custofs, 0) * loc_nCotCusto / loc_nCotMoeda))

                loc_nVenda = loc_nVenda + (NVL(cursor_4c_ProdFor.estoque, 0) * ;
                    (NVL(cursor_4c_ProdFor.pvens, 0) * loc_nCotVenda / loc_nCotMoeda))

                SELECT cursor_4c_ProdFor
            ENDSCAN
        ENDIF

        INSERT INTO TmpFinal (Agrupar, TEstoque, TCusto, TVenda) ;
            VALUES (" ", loc_nEstoque, ROUND(loc_nCusto, 2), ROUND(loc_nVenda, 2))

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarRelatorio - "Report Form SIGOPCGC Preview NoConsole" e
    * "Report Form SIGOPCGC To PRINTER Prompt Noconsole" do legado, com os tres
    * cuidados obrigatorios do projeto:
    *   1. guard IF FILE() - FRX ausente tem de dizer QUAL arquivo falta;
    *   2. isolamento de locale (SET POINT/SEPARATOR/REPORTBEHAVIOR) - FRX
    *      legado Fortyus foi desenhado com POINT="." e REPORTBEHAVIOR 80, e
    *      no default do VFP9 os campos numericos saem como asteriscos;
    *   3. restauracao do menu - o _MREPORT do preview corrompe o _MSYSMENU.
    *
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT"
    *--------------------------------------------------------------------------
    FUNCTION ExecutarRelatorio(par_cModo)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig, loc_lOk

        loc_lOk  = .F.
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + "SigOpCgc.frx")

        IF !FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o encontrado:" + CHR(13) + loc_cFRX, "Erro")
            RETURN .F.
        ENDIF

        IF !USED("TmpRelat") OR RECCOUNT("TmpRelat") = 0
            MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        SELECT TmpRelat
        GO TOP

        DO CASE
            CASE UPPER(ALLTRIM(NVL(par_cModo, ""))) == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE UPPER(ALLTRIM(NVL(par_cModo, ""))) == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            OTHERWISE
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        loc_lOk = .T.

        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
                popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora do escopo (teste automatizado)
        ENDTRY

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * LiberarCursoresImpressao - "Use In TmpRelat / Use In TmpFinal" que o
    * legado executa depois de cada Report Form.
    *--------------------------------------------------------------------------
    PROCEDURE LiberarCursoresImpressao()
        LOCAL loc_aCur[4], loc_nI

        loc_aCur[1] = "TmpRelat"
        loc_aCur[2] = "TmpFinal"
        loc_aCur[3] = "TmpTot1"
        loc_aCur[4] = "TmpTot2"

        FOR loc_nI = 1 TO 4
            IF USED(loc_aCur[loc_nI])
                USE IN (loc_aCur[loc_nI])
            ENDIF
        ENDFOR

        IF USED("TmpTot3")
            USE IN TmpTot3
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarImagemMemo - grava em arquivo o conteudo de uma coluna "text" de
    * imagem (SigCdCli.figjpgs / SigCdPro.figjpgs).
    *
    * As DUAS rotinas do legado leem a MESMA coluna de formas diferentes: o
    * fim de Processa usa "Copy Memo ... To arquivo" (conteudo BRUTO) e o
    * AfterRowColChange da aba Estoque faz Strconv(...,14), isto eh decodifica
    * BASE64 depois de tirar o prefixo "data:image/...;base64,". Em vez de
    * escolher uma e errar a outra, aqui o conteudo eh decodificado so quando
    * o resultado tem assinatura de imagem conhecida (JPEG/PNG/GIF/BMP);
    * fora disso vai bruto, como no caminho antigo.
    *--------------------------------------------------------------------------
    FUNCTION GravarImagemMemo(par_cConteudo, par_cArquivo)
        LOCAL loc_cDados, loc_cBase, loc_cDecod, loc_cSafety, loc_lOk, loc_oErro

        loc_lOk   = .F.
        loc_cDados = NVL(par_cConteudo, "")

        IF EMPTY(loc_cDados) OR EMPTY(NVL(par_cArquivo, ""))
            RETURN .F.
        ENDIF

        TRY
            loc_cBase = STRTRAN(loc_cDados, "data:image/png;base64,",  "")
            loc_cBase = STRTRAN(loc_cBase,  "data:image/jpeg;base64,", "")
            loc_cBase = STRTRAN(loc_cBase,  "data:image/jpg;base64,",  "")

            loc_cDecod = ""
            TRY
                loc_cDecod = STRCONV(loc_cBase, 14)
            CATCH TO loc_oErro
                loc_cDecod = ""
            ENDTRY

            IF THIS.TemAssinaturaDeImagem(loc_cDecod)
                loc_cDados = loc_cDecod
            ENDIF

            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            STRTOFILE(loc_cDados, par_cArquivo)
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF

            loc_lOk = FILE(par_cArquivo)
        CATCH TO loc_oErro
            loc_lOk = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * TemAssinaturaDeImagem - confere os bytes iniciais de JPEG, PNG, GIF e
    * BMP. Eh o que decide, em GravarImagemMemo, se o conteudo da coluna
    * estava em BASE64 ou bruto.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION TemAssinaturaDeImagem(par_cDados)
        LOCAL loc_cIni

        IF EMPTY(NVL(par_cDados, "")) OR LEN(par_cDados) < 4
            RETURN .F.
        ENDIF

        loc_cIni = LEFT(par_cDados, 4)

        DO CASE
            CASE LEFT(loc_cIni, 2) == CHR(255) + CHR(216)                && JPEG
                RETURN .T.
            CASE loc_cIni == CHR(137) + "PNG"                            && PNG
                RETURN .T.
            CASE LEFT(loc_cIni, 3) == "GIF"                              && GIF
                RETURN .T.
            CASE LEFT(loc_cIni, 2) == "BM"                               && BMP
                RETURN .T.
        ENDCASE

        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterArquivoFotoFornecedor - bloco final de Processa: a foto do
    * fornecedor so eh exibida quando o GRUPO de contas esta marcado para
    * mostrar foto (CrSigCdGcr.mfotos = 1). Devolve "" quando nao ha foto.
    * Arquivo temporario Temp4.jpg, o mesmo nome do legado.
    *--------------------------------------------------------------------------
    FUNCTION ObterArquivoFotoFornecedor()
        LOCAL loc_cArquivo

        IF THIS.this_nMFotos != 1 OR EMPTY(NVL(THIS.this_cFigJpg, ""))
            RETURN ""
        ENDIF

        loc_cArquivo = ADDBS(SYS(2023)) + "Temp4.jpg"

        IF THIS.GravarImagemMemo(THIS.this_cFigJpg, loc_cArquivo)
            RETURN loc_cArquivo
        ENDIF

        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarFotoProduto - AfterRowColChange da grade da aba Estoque:
    * le SigCdPro.figjpgs do produto da linha corrente e grava Temp5.jpg (o
    * mesmo nome do legado). Devolve "" quando o produto nao tem foto.
    *--------------------------------------------------------------------------
    FUNCTION CarregarFotoProduto(par_cProduto)
        LOCAL loc_cSQL, loc_cArquivo, loc_cConteudo, loc_cRetorno

        loc_cRetorno = ""

        IF EMPTY(ALLTRIM(NVL(par_cProduto, "")))
            RETURN ""
        ENDIF

        loc_cSQL = "SELECT figjpgs FROM SigCdPro WHERE cpros = " + ;
                   EscaparSQL(ALLTRIM(par_cProduto))

        IF THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_FotoSql")
            SELECT cursor_4c_FotoSql
            GO TOP
            loc_cConteudo = ""
            IF !EOF()
                loc_cConteudo = TratarNulo(cursor_4c_FotoSql.figjpgs, "")
            ENDIF
            USE IN cursor_4c_FotoSql

            IF !EMPTY(loc_cConteudo)
                loc_cArquivo = ADDBS(SYS(2023)) + "Temp5.jpg"
                IF THIS.GravarImagemMemo(loc_cConteudo, loc_cArquivo)
                    loc_cRetorno = loc_cArquivo
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_cRetorno
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / ExecutarExclusao - NAO sobrescritos de proposito.
    *
    * SIGOPCGC eh form de CONSULTA (Consulta Generica de Compras): o codigo
    * legado inteiro (871 linhas do metodo Processa + os demais eventos de
    * comportamento.json) so executa SELECT/SqlExecute para exibir saldos,
    * historico, estoque, pendencias e conserto do fornecedor pesquisado -
    * nao ha nenhum Insert/Update/Delete no SCX original. O comportamento
    * padrao herdado de BusinessBase (recusar a operacao) ja eh o correto
    * aqui; sobrescrever esses metodos so para preencher criaria uma via de
    * gravacao que o sistema legado nunca teve.
    *--------------------------------------------------------------------------

ENDDEFINE

