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
[19/06/2026 20:37:53] Erro ao inicializar FormSigPdMp9: Alias 'XPESA' is not found.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-06-19 20:36:19] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-19 20:36:19] [INFO] Config FPW: (nao fornecido)
[2026-06-19 20:36:19] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-19 20:36:19] [INFO] Timeout: 300 segundos
[2026-06-19 20:36:19] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gffz5i42.prg
[2026-06-19 20:36:19] [INFO] Conteudo do wrapper:
[2026-06-19 20:36:19] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPdMp9', 'C:\4c\tasks\task150', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPdMp9', 'C:\4c\tasks\task150', 'OPERACIONAL'
QUIT

[2026-06-19 20:36:19] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gffz5i42.prg
[2026-06-19 20:36:19] [INFO] VFP output esperado em: C:\4c\tasks\task150\vfp_output.txt
[2026-06-19 20:36:19] [INFO] Executando Visual FoxPro 9...
[2026-06-19 20:36:19] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gffz5i42.prg
[2026-06-19 20:36:19] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gffz5i42.prg
[2026-06-19 20:36:19] [INFO] Timeout configurado: 300 segundos
[2026-06-19 20:36:33] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-19 20:36:33] [INFO] VFP9 finalizado em 13.5123812 segundos
[2026-06-19 20:36:33] [INFO] Exit Code: 
[2026-06-19 20:36:33] [INFO] 
[2026-06-19 20:36:33] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-19 20:36:33] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gffz5i42.prg
[2026-06-19 20:36:33] [INFO] 
[2026-06-19 20:36:33] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-19 20:36:33] [INFO] * Auto-generated wrapper for parameters
[2026-06-19 20:36:33] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-19 20:36:33] [INFO] * Parameters: 'FormSigPdMp9', 'C:\4c\tasks\task150', 'OPERACIONAL'
[2026-06-19 20:36:33] [INFO] 
[2026-06-19 20:36:33] [INFO] * Anti-dialog protections for unattended execution
[2026-06-19 20:36:33] [INFO] SET SAFETY OFF
[2026-06-19 20:36:33] [INFO] SET RESOURCE OFF
[2026-06-19 20:36:33] [INFO] SET TALK OFF
[2026-06-19 20:36:33] [INFO] SET NOTIFY OFF
[2026-06-19 20:36:33] [INFO] SYS(2335, 0)
[2026-06-19 20:36:33] [INFO] 
[2026-06-19 20:36:33] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPdMp9', 'C:\4c\tasks\task150', 'OPERACIONAL'
[2026-06-19 20:36:33] [INFO] QUIT
[2026-06-19 20:36:33] [INFO] 
[2026-06-19 20:36:33] [INFO] === Fim do Wrapper.prg ===
[2026-06-19 20:36:33] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-06-19 20:37:38] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-19 20:37:38] [INFO] Config FPW: (nao fornecido)
[2026-06-19 20:37:38] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-19 20:37:38] [INFO] Timeout: 300 segundos
[2026-06-19 20:37:38] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oersfurr.prg
[2026-06-19 20:37:38] [INFO] Conteudo do wrapper:
[2026-06-19 20:37:38] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPdMp9', 'C:\4c\tasks\task150', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPdMp9', 'C:\4c\tasks\task150', 'OPERACIONAL'
QUIT

[2026-06-19 20:37:38] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oersfurr.prg
[2026-06-19 20:37:38] [INFO] VFP output esperado em: C:\4c\tasks\task150\vfp_output.txt
[2026-06-19 20:37:38] [INFO] Executando Visual FoxPro 9...
[2026-06-19 20:37:38] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oersfurr.prg
[2026-06-19 20:37:38] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oersfurr.prg
[2026-06-19 20:37:38] [INFO] Timeout configurado: 300 segundos
[2026-06-19 20:37:53] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-19 20:37:53] [INFO] VFP9 finalizado em 15.7580326 segundos
[2026-06-19 20:37:53] [INFO] Exit Code: 
[2026-06-19 20:37:53] [INFO] 
[2026-06-19 20:37:53] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-19 20:37:53] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oersfurr.prg
[2026-06-19 20:37:53] [INFO] 
[2026-06-19 20:37:53] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-19 20:37:53] [INFO] * Auto-generated wrapper for parameters
[2026-06-19 20:37:53] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-19 20:37:53] [INFO] * Parameters: 'FormSigPdMp9', 'C:\4c\tasks\task150', 'OPERACIONAL'
[2026-06-19 20:37:53] [INFO] 
[2026-06-19 20:37:53] [INFO] * Anti-dialog protections for unattended execution
[2026-06-19 20:37:53] [INFO] SET SAFETY OFF
[2026-06-19 20:37:53] [INFO] SET RESOURCE OFF
[2026-06-19 20:37:53] [INFO] SET TALK OFF
[2026-06-19 20:37:53] [INFO] SET NOTIFY OFF
[2026-06-19 20:37:53] [INFO] SYS(2335, 0)
[2026-06-19 20:37:53] [INFO] 
[2026-06-19 20:37:53] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPdMp9', 'C:\4c\tasks\task150', 'OPERACIONAL'
[2026-06-19 20:37:53] [INFO] QUIT
[2026-06-19 20:37:53] [INFO] 
[2026-06-19 20:37:53] [INFO] === Fim do Wrapper.prg ===
[2026-06-19 20:37:53] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigPdMp9",
  "timestamp": "20260619203753",
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp9.prg):
*==============================================================================
* FormSigPdMp9.prg - Formulario Operacional: Pesagem de Pe" + CHR(231) + "as
* Herda de FormBase
* Tipo: OPERACIONAL (sem PageFrame Lista/Dados)
* Cursor de trabalho: xPesa (compartilhado da datasession do form pai)
* Tabela principal: SigPrCpo (composicao especial), SigCdNei (movimentos)
*==============================================================================
DEFINE CLASS FormSigPdMp9 AS FormBase

    *-- Propriedades visuais (sobrescreve FormBase)
    Caption      = "Pesagem de Pe" + CHR(231) + "as"
    Height       = 600
    Width        = 1000
    AutoCenter   = .T.
    BorderStyle  = 2
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    TitleBar     = 0
    Name         = "FormSigPdMp9"

    *-- Referencia ao form pai
    this_oPaiForm    = .NULL.

    *-- Estado do processo de pesagem
    this_lAlterou    = .F.   && Peso foi alterado na linha atual
    this_nOldValue   = 0     && Peso antes da edicao
    this_lLiberaPeso = .F.   && Usuario pode liberar pesagem fora do limite
    this_lTemBalanca = .F.   && Balanca serial disponivel

    *-- Codigo de acesso ao programa (fChecaAcesso)
    this_cProgAcesso = ""

    *==========================================================================
    * Init - Recebe referencia ao form pai e compartilha datasession
    *==========================================================================
    PROCEDURE Init(par_oParentForm)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF VARTYPE(par_oParentForm) = "O"
            THIS.this_oPaiForm = par_oParentForm
            THIS.DataSessionId = par_oParentForm.DataSessionId
        ENDIF
        loc_lSucesso = DODEFAULT()
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Hook de FormBase: configura todos os controles
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Imagem de fundo
            LOCAL loc_cImagem
            loc_cImagem = ALLTRIM(gc_4c_CaminhoBase) + "..\framework\imagens\new_background.jpg"
            IF FILE(loc_cImagem)
                THIS.Picture = loc_cImagem
            ENDIF

            *-- Cria Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPdMp9BO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"

            *-- Data de referencia para cotacoes
            IF USED("TmpNens")
                SELECT TmpNens
                GO TOP
                THIS.this_oBusinessObject.this_dDataMovimento = NVL(Datas, DATE())
            ENDIF

            *-- Codigo de acesso ao programa (crSigCdOpd.Ndopps)
            IF USED("crSigCdOpd")
                SELECT crSigCdOpd
                GO TOP
                THIS.this_cProgAcesso = "P" + PADL(TRANSFORM(NVL(Ndopps, 0)), 8, "0")
                THIS.this_oBusinessObject.this_cProgAcesso = THIS.this_cProgAcesso
            ENDIF

            *-- Cria cursores locais de trabalho
            THIS.CriarCursoresLocais()

            *-- Aparencia base do form (OPERACIONAL sem PageFrame Page1/Page2)
            THIS.ConfigurarPageFrame()

            *-- Interface
            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()
            THIS.ConfigurarBalanca()

            *-- Verifica permissao de liberar peso
            THIS.this_lLiberaPeso = THIS.this_oBusinessObject.BuscarPermissaoLiberaPeso()

            *-- Inicializa PesoFixs a partir de xNensI
            THIS.InicializarPesoFixs()

            *-- Posiciona xPesa no inicio
            IF USED("xPesa")
                SELECT xPesa
                SET ORDER TO Amarra
                GO TOP
            ENDIF

            THIS.Refresh()
            loc_lSucesso = .T.
        ELSE
            MsgErro("Falha ao criar SigPdMp9BO.", "Erro")
        ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar FormSigPdMp9")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CriarCursoresLocais - Cria CrSigCdNei e xNensiE na datasession compartilhada
    *==========================================================================
    PROTECTED PROCEDURE CriarCursoresLocais()
        LOCAL loc_oErro
        TRY
            SET NULL OFF

            *-- CrSigCdNei: buffer local de movimentos antes de gravar no SQL Server
            IF USED("CrSigCdNei")
                SELECT CrSigCdNei
                ZAP
            ELSE
                CREATE CURSOR CrSigCdNei ( ;
                    Emps      C(3),    ;
                    Dopps     C(10),   ;
                    Numps     N(10,0), ;
                    Nops      N(10,0), ;
                    Nenvs     N(10,0), ;
                    CMats     C(14),   ;
                    CDescs    C(40),   ;
                    CUnis     C(3),    ;
                    Tpops     C(3),    ;
                    Cats      C(6),    ;
                    Obss      C(40),   ;
                    AQtds     N(11,3), ;
                    Qtds      N(11,3), ;
                    Pesos     N(11,3), ;
                    FlagIncs  L,       ;
                    Fators    N(11,3), ;
                    Moedas    C(3),    ;
                    Servicos  L,       ;
                    GrupoFins C(10),   ;
                    nLotes    N(8,3),  ;
                    PesoFixs  N(3,0),  ;
                    cIdChaves C(20),   ;
                    EmpDNPs   C(23),   ;
                    Peso2s    N(11,3), ;
                    CustoFs   N(11,2), ;
                    MoeCusFs  C(3)     ;
                )
            ENDIF

            *-- xNensiE: cursor auxiliar para rateio de peso por envelope
            IF USED("xNensI")
                IF USED("xNensiE")
                    SELECT xNensiE
                    ZAP
                ELSE
                    SELECT * FROM xNensI WHERE .F. INTO CURSOR xNensiE READWRITE
                    SELECT xNensiE
                    IF TYPE("Rateio") <> "U"
                        INDEX ON NVL(Rateio, 0)          TAG Rateio
                    ENDIF
                    IF TYPE("Nenvs") <> "U"
                        INDEX ON NVL(Nenvs, 0)           TAG Nenvs
                    ENDIF
                    IF TYPE("Gravar") <> "U"
                        INDEX ON ALLTRIM(NVL(Gravar, "")) TAG Gravar
                    ENDIF
                    IF TYPE("PsFaseAnt") <> "U"
                        INDEX ON NVL(PsFaseAnt, 0)       TAG PsFaseAnt
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao criar cursores locais")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Aparencia base do form (OPERACIONAL sem PageFrame)
    * Forms OPERACIONAIS nao tem PageFrame Page1/Page2 como CRUD.
    * Este metodo define propriedades visuais globais do form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.BackColor  = RGB(212, 208, 200)
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *==========================================================================
    * Destroy - Libera objetos e cursores
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        IF USED("CrSigCdNei")
            USE IN CrSigCdNei
        ENDIF
        IF USED("xNensiE")
            USE IN xNensiE
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container de titulo com efeito sombra
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cTitulo
        loc_cTitulo = "Pesagem de Pe" + CHR(231) + "as"
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = 1100
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = loc_cTitulo
                .Height     = 40
                .Left       = 10
                .Top        = 18
                .Width      = THIS.Width
                .ForeColor  = RGB(0, 0, 0)
                .Visible    = .T.
            ENDWITH
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = loc_cTitulo
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width
                .ForeColor  = RGB(255, 255, 255)
                .Visible    = .T.
            ENDWITH
            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura a "pagina" principal do form OPERACIONAL
    * Em forms OPERACIONAIS nao ha PageFrame Page1/Page2 como nos CRUD.
    * Esta procedure agrupa Grid (lista de pecas) e Rodape (botoes de acao):
    *   - cmd_4c_Resumo    - Abre janela de resumo (SigPdM10)
    *   - cmd_4c_CustoP    - Visualiza custos do produto (apenas com permissao)
    *   - cmd_4c_Processar - Confirma pesagem e segue para SigPdM11
    *   - cmd_4c_Cancelar  - Cancela e fecha o form
    * O legado nao usa botoes CRUD (Incluir/Alterar/Excluir/Buscar) porque
    * a pesagem ja recebe a lista de pecas pronta do form pai.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarGrid()
        THIS.ConfigurarRodape()
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Grid GradeItens com 9 colunas ligadas a xPesa
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_lAcesso, loc_lLibObss, loc_lTrfPesas
        loc_lAcesso  = fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP")
        loc_lLibObss = .F.
        loc_lTrfPesas = .F.
        IF USED("crSigCdPam")
            SELECT crSigCdPam
            GO TOP
            IF VARTYPE(crSigCdPam.LibObss) = "L"
                loc_lLibObss = crSigCdPam.LibObss
            ELSE
                IF VARTYPE(crSigCdPam.LibObss) = "L"
                    loc_lLibObss = crSigCdPam.LibObss
                ELSE
                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                        loc_lLibObss = crSigCdPam.LibObss
                    ELSE
                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                            loc_lLibObss = crSigCdPam.LibObss
                        ELSE
                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                loc_lLibObss = crSigCdPam.LibObss
                            ELSE
                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                    loc_lLibObss = crSigCdPam.LibObss
                                ELSE
                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                        loc_lLibObss = crSigCdPam.LibObss
                                    ELSE
                                        loc_lLibObss = (NVL(crSigCdPam.LibObss, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        IF USED("crSigCdOpd")
            SELECT crSigCdOpd
            GO TOP
            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                loc_lTrfPesas = crSigCdOpd.TrfPesas
            ELSE
                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                ELSE
                    IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                        loc_lTrfPesas = crSigCdOpd.TrfPesas
                    ELSE
                        IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                            loc_lTrfPesas = crSigCdOpd.TrfPesas
                        ELSE
                            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                loc_lTrfPesas = crSigCdOpd.TrfPesas
                            ELSE
                                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                                ELSE
                                    IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                        loc_lTrfPesas = crSigCdOpd.TrfPesas
                                    ELSE
                                        loc_lTrfPesas = (NVL(crSigCdOpd.TrfPesas, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        THIS.AddObject("grd_4c_Itens", "Grid")
        THIS.grd_4c_Itens.RecordSource = "xPesa"
        THIS.grd_4c_Itens.ColumnCount  = 9
        WITH THIS.grd_4c_Itens
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .Height            = 463
            .Left              = 10
            .Panel             = 1
            .RowHeight         = 17
            .ScrollBars        = 2
            .TabIndex          = 1
            .Top               = 111
            .Width             = 980
            .GridLineColor     = RGB(238, 238, 238)
            .ReadOnly          = loc_lTrfPesas

            *-- Column1: Produto (Cpros) - ReadOnly
            WITH .Column1
                .ControlSource     = "xPesa.Cpros"
                .ColumnOrder       = 3
                .Width             = 120
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontSize          = 8
                .Header1.Caption   = "Produto"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column1.Text1, "When", THIS, "GradeCol1TextWhen")

            *-- Column2: Observacao (Obs) - editavel com LibObss=1 e INSERIR
            WITH .Column2
                .ControlSource     = "xPesa.Obs"
                .ColumnOrder       = 6
                .Width             = 100
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = !loc_lLibObss
                .FontSize          = 8
                .Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column2.Text1, "When", THIS, "GradeCol2TextWhen")

            *-- Column3: Movimentacao (Oper) - ReadOnly
            WITH .Column3
                .ControlSource     = "xPesa.Oper"
                .ColumnOrder       = 4
                .Width             = 221
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontSize          = 8
                .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column3.Text1, "When", THIS, "GradeCol3TextWhen")

            *-- Column4: Tamanho (Tams) - lookup SigCdTam, editavel com LibObss=1
            WITH .Column4
                .ControlSource     = "xPesa.Tams"
                .ColumnOrder       = 8
                .Width             = 40
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .F.
                .FontSize          = 8
                .Header1.Caption   = "Tam"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .F.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column4.Text1, "When",     THIS, "GradeCol4TextWhen")
            BINDEVENT(THIS.grd_4c_Itens.Column4.Text1, "KeyPress", THIS, "GradeCol4TextKeyPress")
            BINDEVENT(THIS.grd_4c_Itens.Column4.Text1, "DblClick", THIS, "GradeCol4TextDblClick")

            *-- Column5: Quantidade (Qtds) - ReadOnly (editavel se LibObss<>1)
            WITH .Column5
                .ControlSource     = "xPesa.Qtds"
                .ColumnOrder       = 5
                .Width             = 100
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontBold          = .T.
                .FontSize          = 8
                .Format            = "K"
                .Header1.Caption   = "Quantidade"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontBold    = .T.
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Format      = "K"
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column5.Text1, "When", THIS, "GradeCol5TextWhen")

            *-- Column6: Peso (Peso) - campo editavel principal com logica de balanca
            WITH .Column6
                .ControlSource     = "xPesa.Peso"
                .ColumnOrder       = 9
                .Width             = 100
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .F.
                .FontBold          = .T.
                .FontSize          = 8
                .Header1.Caption   = "Peso"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontBold    = .T.
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .F.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "When",      THIS, "GradeCol6TextWhen")
            BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "Valid",     THIS, "GradeCol6TextValid")
            BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "KeyPress", THIS, "GradeCol6TextLostFocus")

            *-- Column7: Cor (Cors) - lookup SigCdCor, editavel com LibObss=1
            WITH .Column7
                .ControlSource     = "xPesa.Cors"
                .ColumnOrder       = 7
                .Width             = 40
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .F.
                .FontSize          = 8
                .Header1.Caption   = "Cor"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .F.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column7.Text1, "When",     THIS, "GradeCol7TextWhen")
            BINDEVENT(THIS.grd_4c_Itens.Column7.Text1, "KeyPress", THIS, "GradeCol7TextKeyPress")
            BINDEVENT(THIS.grd_4c_Itens.Column7.Text1, "DblClick", THIS, "GradeCol7TextDblClick")

            *-- Column8: Barras (Cbars) - ReadOnly
            WITH .Column8
                .ControlSource     = "xPesa.Cbars"
                .ColumnOrder       = 2
                .Width             = 110
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontSize          = 8
                .Header1.Caption   = "Barras"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column8.Text1, "When", THIS, "GradeCol8TextWhen")

            *-- Column9: Custo (CustoFs) - ReadOnly, visivel apenas com permissao CUSTOP
            WITH .Column9
                .ControlSource     = "xPesa.CustoFs"
                .ColumnOrder       = 1
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontSize          = 8
                .Header1.Caption   = "Custo"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Text1.FontSize    = 8
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .T.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(THIS.grd_4c_Itens.Column9.Text1, "When",     THIS, "GradeCol9TextWhen")
            BINDEVENT(THIS.grd_4c_Itens.Column9.Text1, "DblClick", THIS, "GradeCol9TextDblClick")

            *-- Cor dinamica: peca especial em vermelho
            .SetAll("DynamicForeColor", ;
                    "IIF(xPesa.Especial,RGB(255,0,0),RGB(0,0,0))", "Column")

            *-- Ajuste de largura Column9 por permissao de acesso
            IF loc_lAcesso
                .Column9.Width = 72
            ELSE
                .Column9.Width  = 1
                .Column3.Width  = .Column3.Width + 71
            ENDIF

            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarRodape - Botoes de acao, peso medio e indicador de peca especial
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarRodape()
        LOCAL loc_cIconPath, loc_lAcesso
        loc_cIconPath = ALLTRIM(gc_4c_CaminhoBase) + "..\framework\imagens\"
        loc_lAcesso   = fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP")

        *-- Label "Peso medio :"
        THIS.AddObject("lbl_4c_PesoMedio", "Label")
        WITH THIS.lbl_4c_PesoMedio
            .FontSize  = 8
            .Caption   = "Peso m" + CHR(233) + "dio :"
            .Left      = 49
            .Top       = 88
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Peso Medio (equivalente a get_pesom do legado)
        THIS.AddObject("txt_4c_PesoMedio", "TextBox")
        WITH THIS.txt_4c_PesoMedio
            .FontUnderline = .T.
            .Alignment     = 3
            .Value         = 0
            .Height        = 23
            .InputMask     = "999.999"
            .Left          = 114
            .TabIndex      = 6
            .Top           = 84
            .Width         = 72
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_PesoMedio, "LostFocus", THIS, "TxtPesoMedioValid")

        *-- Indicador de peca especial (caixa vermelha decorativa - Botao1 do legado)
        THIS.AddObject("txt_4c_Especial", "TextBox")
        WITH THIS.txt_4c_Especial
            .Height        = 20
            .Left          = 12
            .SpecialEffect = 1
            .ToolTipText   = "Pe" + CHR(231) + "a Especial"
            .Top           = 86
            .Width         = 27
            .BackColor     = RGB(255, 0, 0)
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_Especial, "When", THIS, "TxtEspecialWhen")

        *-- Botao Resumo
        THIS.AddObject("cmd_4c_Resumo", "CommandButton")
        WITH THIS.cmd_4c_Resumo
            .Top       = 3
            .Left      = 700
            .Height    = 75
            .Width     = 75
            .Caption   = "\<Resumo"
            .Themes    = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            IF FILE(loc_cIconPath + "geral_documento_60.jpg")
                .Picture = loc_cIconPath + "geral_documento_60.jpg"
            ENDIF
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Resumo, "Click", THIS, "BtnResumoClick")

        *-- Botao CustoP (visivel apenas com permissao CUSTOP)
        THIS.AddObject("cmd_4c_CustoP", "CommandButton")
        WITH THIS.cmd_4c_CustoP
            .Top         = 3
            .Left        = 775
            .Height      = 75
            .Width       = 75
            .Caption     = "Cus\<tos"
            .ToolTipText = "Custo Produ" + CHR(231) + CHR(227) + "o"
            .Themes      = .F.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            IF FILE(loc_cIconPath + "geral_calculadora_60.jpg")
                .Picture = loc_cIconPath + "geral_calculadora_60.jpg"
            ENDIF
            .Visible     = loc_lAcesso
        ENDWITH
        BINDEVENT(THIS.cmd_4c_CustoP, "Click", THIS, "BtnCustoPClick")

        *-- Botao Processar (Confirmar)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top       = 3
            .Left      = 850
            .Height    = 75
            .Width     = 75
            .Caption   = "\<Confirmar"
            .Themes    = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            IF FILE(loc_cIconPath + "cadastro_salvar_60.jpg")
                .Picture = loc_cIconPath + "cadastro_salvar_60.jpg"
            ENDIF
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

        *-- Botao Cancelar
        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top       = 3
            .Left      = 925
            .Height    = 75
            .Width     = 75
            .Cancel    = .T.
            .Caption   = "Encerrar"
            .Themes    = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            IF FILE(loc_cIconPath + "cadastro_cancelar_60.jpg")
                .Picture = loc_cIconPath + "cadastro_cancelar_60.jpg"
            ENDIF
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Elementos visuais decorativos do form OPERACIONAL
    * Forms OPERACIONAIS nao tem Page2/PaginaDados como nos CRUD.
    * Este metodo adiciona as shapes visuais do legado (Shape2 e Shape1)
    * que flanqueiam a area de cabecalho e botoes respectivamente.
    * Shape2: moldura esquerda (area de identificacao do form)
    * Shape1: moldura direita (area de botoes de acao)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro
        TRY
            *-- Shape2: moldura decorativa lado esquerdo (area de titulo)
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top         = 11
                .Left        = 10
                .Height      = 110
                .Width       = 172
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            *-- Shape1: moldura decorativa lado direito (area dos botoes de acao)
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 11
                .Left        = 817
                .Height      = 110
                .Width       = 172
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(0, 0, 0)
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao configurar elementos visuais")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBalanca - Conecta controle de balanca serial do framework
    * Configurado a partir de crSigCdPam (Porta, Velocidade, Paridade, etc.)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBalanca()
        LOCAL loc_oErro
        THIS.this_lTemBalanca = .F.
        TRY
            IF USED("crSigCdPam")
            SELECT crSigCdPam
            GO TOP
            LOCAL loc_cVcx
            loc_cVcx = ALLTRIM(gc_4c_CaminhoBase) + "..\framework\framework.vcx"
            IF FILE(loc_cVcx)
            SET CLASSLIB TO (loc_cVcx) ADDITIVE
            THIS.AddObject("bal_4c_Balanca", "balan" + CHR(231) + "a")
            WITH THIS.bal_4c_Balanca
                .Top          = 84
                .Left         = 924
                .Height       = 36
                .Width        = 24
                .Porta        = NVL(crSigCdPam.BalPortas, 0)
                .Velocidade   = NVL(crSigCdPam.BalVelocs, 0)
                .TipoParidade = NVL(crSigCdPam.BalTppars, 0)
                .Bits         = NVL(crSigCdPam.BalBits,   0)
                .Paridade     = NVL(crSigCdPam.BalParids, 0)
                IF NVL(crSigCdPam.BalPortas, 0) = 0
                    .Leitura = "T"
                ENDIF
                .Visible      = .T.
            ENDWITH
            THIS.this_lTemBalanca = .T.
            ENDIF && FILE(loc_cVcx)
            ENDIF && USED("crSigCdPam")
        CATCH TO loc_oErro
            *-- Balanca nao disponivel - pesagem manual
        ENDTRY
    ENDPROC

    *==========================================================================
    * InicializarPesoFixs - Calcula PesoFixs para cada peca em xPesa
    * a partir dos pesos fixos acumulados em xNensi (Rateio=3, !Visivel)
    * Replica logica de Select/Index/Scan no Init do legado
    *==========================================================================
    PROTECTED PROCEDURE InicializarPesoFixs()
        LOCAL loc_oErro, loc_lPesMatPs
        loc_lPesMatPs = .F.
        TRY
            IF USED("xPesa") AND USED("xNensI") AND USED("crSigCdOpd")
            SELECT crSigCdOpd
            GO TOP
            loc_lPesMatPs = (NVL(crSigCdOpd.pesMatPs, 0) <> 0)
            IF loc_lPesMatPs

            *-- Total de pecas por envelope
            IF USED("tPesa_4c")
                USE IN tPesa_4c
            ENDIF
            SELECT Nenvs, SUM(Qtds) AS Qtds ;
              FROM xPesa ;
             GROUP BY Nenvs ;
              INTO CURSOR tPesa_4c

            *-- Peso fixo (Rateio=3, !Visivel) por envelope
            IF USED("xRateio_4c")
                USE IN xRateio_4c
            ENDIF
            SELECT a.Nenvs, SUM(a.Pesos) AS Pesos, b.Qtds ;
              FROM xNensI a, tPesa_4c b ;
             WHERE !IIF(VARTYPE(a.Visivel)="L", a.Visivel, NVL(a.Visivel,0)=1) ;
               AND NVL(a.Rateio, 0) = 3 ;
               AND a.Nenvs = b.Nenvs ;
             GROUP BY a.Nenvs, b.Qtds ;
              INTO CURSOR xRateio_4c

            IF RECCOUNT("xRateio_4c") > 0
                SELECT xRateio_4c
                INDEX ON NVL(Nenvs, 0) TAG Nenvs

                SELECT xPesa
                SCAN
                    LOCAL loc_nNenv, loc_nQtds, loc_nPesoFixs
                    loc_nNenv    = NVL(xPesa.Nenvs, 0)
                    loc_nQtds    = NVL(xPesa.Qtds, 0)
                    loc_nPesoFixs = 0
                    SELECT xRateio_4c
                    IF SEEK(loc_nNenv) AND NVL(xRateio_4c.Pesos, 0) <> 0 AND xRateio_4c.Qtds <> 0
                        loc_nPesoFixs = (xRateio_4c.Pesos / xRateio_4c.Qtds) * loc_nQtds
                        SELECT xPesa
                        REPLACE xPesa.PesoFixs WITH loc_nPesoFixs
                    ENDIF
                    SELECT xPesa
                ENDSCAN
            ENDIF

            IF USED("xRateio_4c")
                USE IN xRateio_4c
            ENDIF
            IF USED("tPesa_4c")
                USE IN tPesa_4c
            ENDIF
            ENDIF && loc_lPesMatPs
            ENDIF && USED("xPesa") AND USED("xNensI") AND USED("crSigCdOpd")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar PesoFixs")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HANDLERS DE GRID - Eventos do Grid grd_4c_Itens (PUBLIC para BINDEVENT)
    *--------------------------------------------------------------------------

    *==========================================================================
    * GradeCol1TextWhen - Produto (sempre ReadOnly)
    *==========================================================================
    FUNCTION GradeCol1TextWhen()
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * GradeCol2TextWhen - Observacao: editavel apenas com LibObss=1 e modo INSERIR
    *==========================================================================
    FUNCTION GradeCol2TextWhen()
        LOCAL loc_lLibObss, loc_lModoInserir
        loc_lLibObss = .F.
        loc_lModoInserir = .F.
        IF USED("crSigCdPam")
            SELECT crSigCdPam
            GO TOP
            IF VARTYPE(crSigCdPam.LibObss) = "L"
                loc_lLibObss = crSigCdPam.LibObss
            ELSE
                IF VARTYPE(crSigCdPam.LibObss) = "L"
                    loc_lLibObss = crSigCdPam.LibObss
                ELSE
                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                        loc_lLibObss = crSigCdPam.LibObss
                    ELSE
                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                            loc_lLibObss = crSigCdPam.LibObss
                        ELSE
                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                loc_lLibObss = crSigCdPam.LibObss
                            ELSE
                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                    loc_lLibObss = crSigCdPam.LibObss
                                ELSE
                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                        loc_lLibObss = crSigCdPam.LibObss
                                    ELSE
                                        loc_lLibObss = (NVL(crSigCdPam.LibObss, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        IF VARTYPE(THIS.this_oPaiForm) = "O"
            loc_lModoInserir = (ALLTRIM(THIS.this_oPaiForm.pcEscolha) = "INSERIR")
        ENDIF
        RETURN loc_lLibObss AND loc_lModoInserir
    ENDFUNC

    *==========================================================================
    * GradeCol3TextWhen - Movimentacao (ReadOnly)
    *==========================================================================
    FUNCTION GradeCol3TextWhen()
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * GradeCol4TextWhen - Tamanho: editavel apenas com LibObss=1
    *==========================================================================
    FUNCTION GradeCol4TextWhen()
        IF USED("crSigCdPam")
            SELECT crSigCdPam
            GO TOP
            RETURN NVL(crSigCdPam.LibObss, 0) = 1
        ENDIF
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * GradeCol4TextKeyPress - Tamanho: F4/F5 abre lookup SigCdTam
    *==========================================================================
    FUNCTION GradeCol4TextKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116  && F4 ou F5
            THIS.AbrirLookupTamanho()
            RETURN .F.
        ENDIF
    ENDFUNC

    *==========================================================================
    * GradeCol4TextDblClick - Tamanho: duplo clique abre lookup SigCdTam
    *==========================================================================
    FUNCTION GradeCol4TextDblClick()
        THIS.AbrirLookupTamanho()
    ENDFUNC

    *==========================================================================
    * AbrirLookupTamanho - Abre FormBuscaAuxiliar em SigCdTam
    *==========================================================================
    FUNCTION AbrirLookupTamanho()
        LOCAL loc_cValor, loc_oBusca, loc_oErro
        TRY
            loc_cValor = ""
            IF VARTYPE(THIS.grd_4c_Itens) = "O" AND ;
               VARTYPE(THIS.grd_4c_Itens.Column4) = "O" AND ;
               VARTYPE(THIS.grd_4c_Itens.Column4.Text1) = "O"
                loc_cValor = ALLTRIM(NVL(THIS.grd_4c_Itens.Column4.Text1.Value, ""))
            ENDIF
            IF EMPTY(loc_cValor) AND USED("xPesa")
                SELECT xPesa
                loc_cValor = ALLTRIM(NVL(Tams, ""))
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdTam", "cursor_4c_TamBusca", "Cods", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Tamanho", .T.)
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_TamBusca")
                    IF USED("xPesa")
                        SELECT xPesa
                        REPLACE Tams WITH ALLTRIM(cursor_4c_TamBusca.Cods)
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_TamBusca")
                USE IN cursor_4c_TamBusca
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar tamanho")
        ENDTRY
        IF VARTYPE(THIS.grd_4c_Itens) = "O"
            THIS.grd_4c_Itens.Refresh()
        ENDIF
    ENDFUNC

    *==========================================================================
    * GradeCol5TextWhen - Quantidade: editavel apenas se LibObss <> 1
    *==========================================================================
    FUNCTION GradeCol5TextWhen()
        IF USED("crSigCdPam")
            SELECT crSigCdPam
            GO TOP
            RETURN NVL(crSigCdPam.LibObss, 0) <> 1
        ENDIF
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * GradeCol6TextWhen - Peso: salva OldValue, ativa balanca, controla edicao
    * Replica Column6.Text1.When do legado
    *==========================================================================
    FUNCTION GradeCol6TextWhen()
        LOCAL loc_lModoInserir, loc_lPesoBals, loc_lTrfPesas
        THIS.this_lAlterou = .F.
        IF USED("xPesa")
            SELECT xPesa
            THIS.this_nOldValue = NVL(Peso, 0)
        ENDIF
        loc_lModoInserir = .F.
        loc_lPesoBals    = .F.
        loc_lTrfPesas    = .F.
        IF VARTYPE(THIS.this_oPaiForm) = "O"
            loc_lModoInserir = (ALLTRIM(THIS.this_oPaiForm.pcEscolha) = "INSERIR")
        ENDIF
        IF USED("crSigCdOpd")
            SELECT crSigCdOpd
            GO TOP
            IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                loc_lPesoBals = crSigCdOpd.PesoBals
            ELSE
                IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                    loc_lPesoBals = crSigCdOpd.PesoBals
                ELSE
                    IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                        loc_lPesoBals = crSigCdOpd.PesoBals
                    ELSE
                        IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                            loc_lPesoBals = crSigCdOpd.PesoBals
                        ELSE
                            IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                loc_lPesoBals = crSigCdOpd.PesoBals
                            ELSE
                                IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                    loc_lPesoBals = crSigCdOpd.PesoBals
                                ELSE
                                    IF VARTYPE(crSigCdOpd.PesoBals) = "L"
                                        loc_lPesoBals = crSigCdOpd.PesoBals
                                    ELSE
                                        loc_lPesoBals = (NVL(crSigCdOpd.PesoBals, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                loc_lTrfPesas = crSigCdOpd.TrfPesas
            ELSE
                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                ELSE
                    IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                        loc_lTrfPesas = crSigCdOpd.TrfPesas
                    ELSE
                        IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                            loc_lTrfPesas = crSigCdOpd.TrfPesas
                        ELSE
                            IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                loc_lTrfPesas = crSigCdOpd.TrfPesas
                            ELSE
                                IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                    loc_lTrfPesas = crSigCdOpd.TrfPesas
                                ELSE
                                    IF VARTYPE(crSigCdOpd.TrfPesas) = "L"
                                        loc_lTrfPesas = crSigCdOpd.TrfPesas
                                    ELSE
                                        loc_lTrfPesas = (NVL(crSigCdOpd.TrfPesas, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        *-- Ativa balanca serial quando no modo INSERIR e nao transferencia
        IF loc_lModoInserir AND !loc_lTrfPesas AND THIS.this_lTemBalanca
            LOCAL loc_oErro
            TRY
                LOCAL loc_oTxt
                loc_oTxt = THIS.grd_4c_Itens.Column6.Text1
                THIS.bal_4c_Balanca.Ativa(loc_oTxt)
                *-- Se balanca preencheu peso e usuario nao cancelou: avanca linha
                IF NVL(loc_oTxt.Value, 0) <> 0 AND LASTKEY() <> 27 AND ;
                   !THIS.bal_4c_Balanca.TempoEsgotado
                    IF USED("xPesa")
                        SELECT xPesa
                        SKIP
                        IF !EOF()
                            IF USED("crSigCdPam") AND NVL(crSigCdPam.LibObss, 0) = 1
                                THIS.grd_4c_Itens.Column2.SetFocus()
                            ELSE
                                THIS.grd_4c_Itens.Column5.SetFocus()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                *-- Balanca falhou durante ativacao - continuar com peso manual
            ENDTRY
        ENDIF
        RETURN loc_lModoInserir AND !loc_lPesoBals
    ENDFUNC

    *==========================================================================
    * GradeCol6TextValid - Peso: valida negativo e diferenca de tolerancia
    * Replica Column6.Text1.Valid do legado
    *==========================================================================
    FUNCTION GradeCol6TextValid()
        LOCAL loc_lValido, loc_nValorAtual, loc_oErro
        LOCAL loc_nQtds, loc_nPesoFixs, loc_nPesagem, loc_nXDif, loc_nDifPesags
        loc_lValido     = .T.
        loc_nValorAtual = 0
        TRY
            IF USED("xPesa")
                SELECT xPesa
                loc_nValorAtual = NVL(Peso, 0)
                loc_nQtds       = NVL(Qtds, 0)
                loc_nPesoFixs   = NVL(PesoFixs, 0)
            ENDIF

            *-- Sem alteracao ou zero: sem validacao
            IF loc_nValorAtual <> 0 AND loc_nValorAtual <> THIS.this_nOldValue
                *-- Valor negativo: nao permitido
                IF loc_nValorAtual < 0
                    MsgAviso("O Peso N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", "")
                    IF USED("xPesa")
                        SELECT xPesa
                        REPLACE Peso WITH THIS.this_nOldValue
                    ENDIF
                    loc_lValido = .F.
                ELSE
                    THIS.this_lAlterou = .T.

            *-- Verifica tolerancia de diferenca de peso
            IF !THIS.this_oBusinessObject.VerificarDiferencaPeso(loc_nValorAtual)
                *-- Fora do limite - calcula valores para mensagem
                loc_nPesagem  = 0
                loc_nDifPesags = 0
                IF USED("crSigCdPam")
                    SELECT crSigCdPam
                    GO TOP
                    loc_nDifPesags = NVL(crSigCdPam.DifPesags, 0)
                ENDIF
                IF loc_nQtds <> 0
                    loc_nPesagem = (loc_nValorAtual / loc_nQtds) - loc_nPesoFixs
                ENDIF

                MsgAviso("Peso Diferente do Peso da Tabela e fora do Limite de " + ;
                    TRANSFORM(loc_nDifPesags, "@Z 999.99%") + CHR(13) + ;
                    "Real: " + ALLTRIM(TRANSFORM(loc_nPesagem, "@Z 9999.999")), "")

                IF THIS.this_lLiberaPeso
                    *-- Solicita senha de autorizacao (SigOpSen)
                    LOCAL loc_cRetorno, loc_lOk, loc_cInfo
                    loc_cRetorno = ""
                    loc_cInfo    = "Libera Pesagem R:" + ALLTRIM(TRANSFORM(loc_nPesagem, "@Z999.999"))
                    DO FORM SigOpSen WITH "LIBPESO", loc_cInfo, "" TO loc_cRetorno
                    CLEAR TYPEAHEAD
                    loc_lOk = (LEFT(ALLTRIM(loc_cRetorno), 1) = "*")
                    IF !loc_lOk
                        MsgAviso("Pesagem n" + CHR(227) + "o autorizada!!!", "")
                        IF USED("xPesa")
                            SELECT xPesa
                            REPLACE Peso WITH 0
                        ENDIF
                        loc_lValido = .F.
                    ELSE
                        IF USED("xPesa")
                            SELECT xPesa
                            REPLACE UsuLibs WITH PADR(SUBSTR(loc_cRetorno, 2), 10)
                        ENDIF
                    ENDIF
                ELSE
                    IF USED("xPesa")
                        SELECT xPesa
                        REPLACE Peso WITH THIS.this_nOldValue
                    ENDIF
                    loc_lValido = .F.
                ENDIF
            ENDIF && !VerificarDiferencaPeso
                ENDIF && loc_nValorAtual >= 0
            ENDIF && loc_nValorAtual <> 0
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na valida" + CHR(231) + CHR(227) + "o do peso")
            loc_lValido = .T.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * GradeCol6TextLostFocus - Apos saida do campo Peso: rateio, custo, especial
    * Replica Column6.Text1.LostFocus do legado
    *==========================================================================
    PROCEDURE GradeCol6TextLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nValorAtual, loc_nRecno, loc_nNenv, loc_oErro
        LOCAL loc_lEspecial, loc_nNops, loc_cCpros, loc_nCusto
        TRY
            IF USED("xPesa")
                SELECT xPesa
                loc_nValorAtual = NVL(Peso, 0)
            ENDIF
            IF loc_nValorAtual <> 0 AND THIS.this_lAlterou
                SELECT xPesa
                loc_nRecno    = RECNO()
                loc_nNenv     = NVL(Nenvs, 0)
                loc_lEspecial = IIF(VARTYPE(Especial)="L", Especial, NVL(Especial,0)=1)
                loc_nNops     = NVL(Nops, 0)
                loc_cCpros    = ALLTRIM(NVL(Cpros, ""))

            *-- Distribui rateio de peso entre materiais do envelope
            THIS.this_oBusinessObject.DistribuirRateio(loc_nRecno)

            *-- Calcula custo de producao e atualiza xPesa.CustoFs
            loc_nCusto = THIS.this_oBusinessObject.CalcularCustoProducao(loc_nNops, loc_cCpros)
            IF USED("xPesa")
                SELECT xPesa
                IF loc_nRecno > 0
                    GO loc_nRecno
                ENDIF
                REPLACE CustoFs WITH loc_nCusto
            ENDIF

            *-- Peca especial: processa composicao SigPrCpo
            IF loc_lEspecial
                THIS.ProcessarPesoEspecial(loc_nNenv, loc_nNops, loc_cCpros, loc_nRecno)
            ENDIF

            *-- Navegacao: avanca para proxima peca
            IF USED("xPesa")
                SELECT xPesa
                IF loc_nRecno > 0
                    GO loc_nRecno
                ENDIF
                SKIP
                KEYBOARD "{DOWNARROW}"
                IF EOF("xPesa")
                    IF VARTYPE(THIS.cmd_4c_Resumo) = "O"
                        THIS.cmd_4c_Resumo.SetFocus()
                    ENDIF
                ELSE
                    IF USED("crSigCdPam") AND NVL(crSigCdPam.LibObss, 0) = 1
                        THIS.grd_4c_Itens.Column2.SetFocus()
                    ELSE
                        THIS.grd_4c_Itens.Column5.SetFocus()
                        KEYBOARD "{LEFTARROW}"
                    ENDIF
                ENDIF
            ENDIF
            ENDIF && loc_nValorAtual <> 0 AND this_lAlterou
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar LostFocus do Peso")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeCol7TextWhen - Cor: editavel apenas com LibObss=1
    *==========================================================================
    FUNCTION GradeCol7TextWhen()
        IF USED("crSigCdPam")
            SELECT crSigCdPam
            GO TOP
            RETURN NVL(crSigCdPam.LibObss, 0) = 1
        ENDIF
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * GradeCol7TextKeyPress - Cor: F4/F5 abre lookup SigCdCor
    *==========================================================================
    FUNCTION GradeCol7TextKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116  && F4 ou F5
            THIS.AbrirLookupCor()
            RETURN .F.
        ENDIF
    ENDFUNC

    *==========================================================================
    * GradeCol7TextDblClick - Cor: duplo clique abre lookup SigCdCor
    *==========================================================================
    FUNCTION GradeCol7TextDblClick()
        THIS.AbrirLookupCor()
    ENDFUNC

    *==========================================================================
    * AbrirLookupCor - Abre FormBuscaAuxiliar em SigCdCor
    *==========================================================================
    FUNCTION AbrirLookupCor()
        LOCAL loc_cValor, loc_oBusca, loc_oErro
        TRY
            loc_cValor = ""
            IF VARTYPE(THIS.grd_4c_Itens) = "O" AND ;
               VARTYPE(THIS.grd_4c_Itens.Column7) = "O" AND ;
               VARTYPE(THIS.grd_4c_Itens.Column7.Text1) = "O"
                loc_cValor = ALLTRIM(NVL(THIS.grd_4c_Itens.Column7.Text1.Value, ""))
            ENDIF
            IF EMPTY(loc_cValor) AND USED("xPesa")
                SELECT xPesa
                loc_cValor = ALLTRIM(NVL(Cors, ""))
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCor", "cursor_4c_CorBusca", "Cods", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Cor", .T.)
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CorBusca")
                    IF USED("xPesa")
                        SELECT xPesa
                        REPLACE Cors WITH ALLTRIM(cursor_4c_CorBusca.Cods)
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_CorBusca")
                USE IN cursor_4c_CorBusca
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar cor")
        ENDTRY
        IF VARTYPE(THIS.grd_4c_Itens) = "O"
            THIS.grd_4c_Itens.Refresh()
        ENDIF
    ENDFUNC

    *==========================================================================
    * GradeCol8TextWhen - Barras (ReadOnly)
    *==========================================================================
    FUNCTION GradeCol8TextWhen()
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * GradeCol9TextWhen - Custo (ReadOnly)
    *==========================================================================
    FUNCTION GradeCol9TextWhen()
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * GradeCol9TextDblClick - Custo: abre SigCdPro se tiver permissao CUSTOP
    *==========================================================================
    PROCEDURE GradeCol9TextDblClick()
        LOCAL loc_nRecno, loc_oErro
        TRY
            IF fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP") AND USED("xPesa")
                SELECT xPesa
                loc_nRecno = RECNO()
                DO FORM SigCdPro WITH "PESAGEM", ALLTRIM(NVL(Cpros, ""))
                SELECT xPesa
                IF loc_nRecno > 0
                    GO loc_nRecno
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir produto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtEspecialWhen - Indicador visual de peca especial (ReadOnly decorativo)
    *==========================================================================
    FUNCTION TxtEspecialWhen()
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * TxtPesoMedioValid - Distribui peso medio por todas as pecas do cursor xPesa
    * Replica get_pesom.Valid do legado
    *==========================================================================
    FUNCTION TxtPesoMedioValid()
        LOCAL loc_nPesoMedio, loc_oErro
        TRY
            loc_nPesoMedio = NVL(THIS.txt_4c_PesoMedio.Value, 0)
            IF !EMPTY(loc_nPesoMedio) AND loc_nPesoMedio <> 0
                THIS.this_oBusinessObject.AtualizarPesoMedio(loc_nPesoMedio)
                IF VARTYPE(THIS.grd_4c_Itens) = "O"
                    THIS.grd_4c_Itens.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao distribuir peso m" + CHR(233) + "dio")
        ENDTRY
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * HANDLERS DE BOTOES
    *--------------------------------------------------------------------------

    *==========================================================================
    * BtnIncluirClick - Adiciona nova pe" + CHR(231) + "a na grade de pesagem
    * Form OPERACIONAL: Incluir adiciona linha em xPesa para nova pesagem
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oPaiForm) <> "O" OR ;
               !INLIST(ALLTRIM(THIS.this_oPaiForm.pcEscolha), "INSERIR", "ALTERAR")
                MsgAviso("Inclus" + CHR(227) + "o de pe" + CHR(231) + "a permitida apenas em modo Inserir/Alterar.", "Aviso")
                RETURN
            ENDIF
            IF !USED("xPesa")
                MsgAviso("Cursor de pesagem n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
                RETURN
            ENDIF
            SELECT xPesa
            APPEND BLANK
            REPLACE Peso WITH 0, Qtds WITH 1
            THIS.this_lAlterou = .T.
            IF VARTYPE(THIS.grd_4c_Itens) = "O"
                THIS.grd_4c_Itens.Refresh()
                THIS.grd_4c_Itens.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao incluir pe" + CHR(231) + "a")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Foca grade na pe" + CHR(231) + "a corrente para editar peso
    * Form OPERACIONAL: Alterar = editar peso da pe" + CHR(231) + "a corrente
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oPaiForm) <> "O" OR ;
               !INLIST(ALLTRIM(THIS.this_oPaiForm.pcEscolha), "INSERIR", "ALTERAR")
                MsgAviso("Altera" + CHR(231) + CHR(227) + "o permitida apenas em modo Inserir/Alterar.", "Aviso")
                RETURN
            ENDIF
            IF !USED("xPesa") OR RECCOUNT("xPesa") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " pe" + CHR(231) + "as para alterar.", "Aviso")
                RETURN
            ENDIF
            SELECT xPesa
            IF EOF() OR BOF()
                GO TOP
            ENDIF
            THIS.this_lAlterou = .T.
            IF VARTYPE(THIS.grd_4c_Itens) = "O"
                THIS.grd_4c_Itens.SetFocus()
                IF PEMSTATUS(THIS.grd_4c_Itens, "Column6", 5)
                    THIS.grd_4c_Itens.Column6.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alterar pe" + CHR(231) + "a")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Exibe custo/composi" + CHR(231) + CHR(227) + "o da pe" + CHR(231) + "a corrente
    * Form OPERACIONAL: Visualizar abre SigCdPro com produto corrente
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_nRecno, loc_cCpros
        TRY
            IF !USED("xPesa") OR RECCOUNT("xPesa") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " pe" + CHR(231) + "a para visualizar.", "Aviso")
                RETURN
            ENDIF
            IF !fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP")
                MsgAviso("Sem permiss" + CHR(227) + "o para visualizar custo.", "Aviso")
                RETURN
            ENDIF
            SELECT xPesa
            loc_nRecno = RECNO()
            loc_cCpros = ALLTRIM(NVL(Cpros, ""))
            IF EMPTY(loc_cCpros)
                MsgAviso("Pe" + CHR(231) + "a sem produto associado.", "Aviso")
                RETURN
            ENDIF
            DO FORM SigCdPro WITH "PESAGEM", loc_cCpros
            SELECT xPesa
            IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT()
                GO loc_nRecno
            ENDIF
            IF VARTYPE(THIS.grd_4c_Itens) = "O"
                THIS.grd_4c_Itens.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar pe" + CHR(231) + "a")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Zera peso da pe" + CHR(231) + "a corrente (desfaz pesagem)
    * Form OPERACIONAL: Excluir zera Peso e PesoFixs da linha corrente
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro, loc_lConfirma
        TRY
            IF VARTYPE(THIS.this_oPaiForm) <> "O" OR ;
               !INLIST(ALLTRIM(THIS.this_oPaiForm.pcEscolha), "INSERIR", "ALTERAR")
                MsgAviso("Exclus" + CHR(227) + "o permitida apenas em modo Inserir/Alterar.", "Aviso")
                RETURN
            ENDIF
            IF !USED("xPesa") OR RECCOUNT("xPesa") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " pe" + CHR(231) + "a para excluir.", "Aviso")
                RETURN
            ENDIF
            SELECT xPesa
            IF EOF() OR BOF()
                GO TOP
            ENDIF
            loc_lConfirma = MsgConfirma("Confirma desfazer a pesagem desta pe" + CHR(231) + "a?", "Confirma" + CHR(231) + CHR(227) + "o")
            IF !loc_lConfirma
                RETURN
            ENDIF
            SELECT xPesa
            REPLACE Peso WITH 0
            IF TYPE("xPesa.PesoFixs") <> "U"
                REPLACE PesoFixs WITH 0
            ENDIF
            THIS.this_lAlterou = .T.
            THIS.this_nOldValue = 0
            IF VARTYPE(THIS.grd_4c_Itens) = "O"
                THIS.grd_4c_Itens.Refresh()
                THIS.grd_4c_Itens.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir pesagem")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnResumoClick - Abre form de resumo SigPdM10 com referencia ao form pai
    *==========================================================================
    PROCEDURE BtnResumoClick()
        DO FORM SigPdM10 WITH THIS.this_oPaiForm
    ENDPROC

    *==========================================================================
    * BtnCustoPClick - Abre SigCdPro no modo PESAGEM para a peca selecionada
    *==========================================================================
    PROCEDURE BtnCustoPClick()
        LOCAL loc_nRecno, loc_oErro
        TRY
            IF fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP") AND ;
               VARTYPE(THIS.this_oPaiForm) = "O" AND ;
               INLIST(ALLTRIM(THIS.this_oPaiForm.pcEscolha), "INSERIR", "ALTERAR")
                IF USED("xPesa")
                    SELECT xPesa
                    loc_nRecno = RECNO()
                    DO FORM SigCdPro WITH "PESAGEM", ALLTRIM(NVL(Cpros, ""))
                    SELECT xPesa
                    IF loc_nRecno > 0
                        LOCATE FOR RECNO() = loc_nRecno
                    ENDIF
                ENDIF
            ENDIF
            IF VARTYPE(THIS.grd_4c_Itens) = "O"
                THIS.grd_4c_Itens.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir custo de produto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Valida que todas as pecas foram pesadas e encerra
    * Replica Processar.Click do legado
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oErro, loc_lPodeProsseguir
        loc_lPodeProsseguir = .T.
        TRY
            *-- Valida pesagem completa apenas no modo INSERIR
            IF VARTYPE(THIS.this_oPaiForm) = "O" AND ;
               ALLTRIM(THIS.this_oPaiForm.pcEscolha) = "INSERIR"
                IF USED("xPesa")
                    SELECT xPesa
                    SCAN
                        IF NVL(Peso, 0) = 0
                            MsgAviso("Existe Uma Pe" + CHR(231) + "a Que N" + CHR(227) + ;
                                     "o Foi Pesada!!!", "")
                            IF VARTYPE(THIS.grd_4c_Itens) = "O"
                                THIS.grd_4c_Itens.Refresh()
                            ENDIF
                            loc_lPodeProsseguir = .F.
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDIF

            IF loc_lPodeProsseguir AND USED("xNensiS") AND RECCOUNT("xNensiS") > 0
                DO FORM SigPdM11 WITH THIS.this_oPaiForm, THIS.DataSessionId
            ENDIF

            *-- Habilita form pai e fecha
            IF loc_lPodeProsseguir
                IF VARTYPE(THIS.this_oPaiForm) = "O"
                    THIS.this_oPaiForm.Enabled = .T.
                ENDIF
                THIS.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar pesagem")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela pesagem e fecha o form
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        IF VARTYPE(THIS.this_oPaiForm) = "O"
            THIS.this_oPaiForm.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * OPERACIONAL: nao ha containers flutuantes a excluir neste form
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    IF loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * AlternarPagina - Sem alternancia de paginas em form OPERACIONAL
    * Reposiciona cursor xPesa e atualiza grid
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oErro
        TRY
            IF USED("xPesa")
                SELECT xPesa
                GO TOP
            ENDIF
            IF VARTYPE(THIS.grd_4c_Itens) = "O"
                THIS.grd_4c_Itens.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alternar p" + CHR(225) + "gina")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ProcessarPesoEspecial - Logica de composicao para peca especial
    * Constroi CrTmpCompo a partir de CrSigCdNei + servicos externos
    * Grava SigPrCpo e abre SigCdPro para revisao
    * Replica logica da secao IF xpesa.Especial de Column6.Text1.LostFocus
    *==========================================================================
    PROTECTED PROCEDURE ProcessarPesoEspecial(par_nNenv, par_nNops, par_cCpros, par_nRecno)
        LOCAL loc_oErro, loc_cSQL, loc_nRet, loc_lSucesso
        LOCAL loc_nMtPrimas, loc_lTemOpEopp
        LOCAL loc_cCMats, loc_nPeso2, loc_nQtds
        LOCAL loc_cDpros, loc_cCunis, loc_cCuniPs, loc_cCgrus2, loc_nCustoFs, loc_cMoeCusFs, loc_cEtiPads
        LOCAL loc_cSvcCpros, loc_nSvcQtds, loc_cSvcEtiPads
        LOCAL loc_cSvcDpros, loc_cSvcCunis, loc_cSvcCuniPs, loc_cSvcCgrus, loc_nSvcCustoFs, loc_cSvcMoeCusFs
        loc_lSucesso = .F.
        TRY
            *-- 1. Tipo de materia prima do grupo do produto (MtPrimas)
            loc_cSQL = "SELECT b.mtprimas FROM SigCdPro a " + ;
                       "JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                       "WHERE a.Cpros = " + EscaparSQL(par_cCpros)
            IF USED("cursor_4c_EspGruTip")
                USE IN cursor_4c_EspGruTip
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspGruTip")
            loc_nMtPrimas = 0
            IF loc_nRet >= 1
                SELECT cursor_4c_EspGruTip
                GO TOP
                loc_nMtPrimas = NVL(MtPrimas, 0)
                USE IN cursor_4c_EspGruTip
            ENDIF

            *-- 2. Carrega composicao atual do SQL Server em CrTmpCompo
            loc_cSQL = "SELECT * FROM SigPrCpo WHERE Cpros = " + EscaparSQL(par_cCpros)
            IF USED("CrTmpCompo")
                USE IN CrTmpCompo
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpCompo")
            IF loc_nRet >= 1
            *-- Indexa por Mats e reseta TpAlts
            SELECT CrTmpCompo
            INDEX ON ALLTRIM(NVL(Mats, "")) TAG Mats
            REPLACE ALL TpAlts WITH 0

            *-- 3. Servicos do cadastro (SigCdSvc)
            loc_cSQL = "SELECT Mats, cCats FROM SigCdSvc WHERE Mats <> ' '"
            IF USED("CsTmpSer")
                USE IN CsTmpSer
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "CsTmpSer")
            IF USED("CsTmpSer")
                SELECT CsTmpSer
                INDEX ON ALLTRIM(NVL(Mats, "")) TAG Mats
            ENDIF

            *-- 4. Servicos do envelope (SigCdNei JOIN SigCdSvc para o nenvs atual)
            loc_cSQL = "SELECT b.cpros, SUM(a.Qtds) AS Qtds " + ;
                       "FROM SigCdNei a JOIN SigCdSvc b ON a.cMats = b.ccats " + ;
                       "WHERE a.Nenvs = " + FormatarNumeroSQL(par_nNenv) + ;
                       " AND a.Servicos = 1 AND a.cMats <> ' ' AND b.Cpros <> ' ' " + ;
                       "GROUP BY b.cpros"
            IF USED("CsxNensi")
                USE IN CsxNensi
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "CsxNensi")

            *-- 5. Se MtPrimas=3: inclui materiais de CrSigCdNei que sao servicos
            IF loc_nMtPrimas = 3 AND USED("CrSigCdNei") AND USED("CsTmpSer") AND USED("CsxNensi")
                IF USED("CszNensi")
                    USE IN CszNensi
                ENDIF
                SELECT PADR(b.Mats, 14) AS Cpros, SUM(a.Qtds) AS Qtds ;
                  FROM CrSigCdNei a, CsTmpSer b ;
                 WHERE a.CMats = b.Mats AND a.Nenvs = par_nNenv ;
                 GROUP BY 1 HAVING SUM(a.Qtds) > 0 ;
                  INTO CURSOR CszNensi
                IF RECCOUNT("CszNensi") > 0
                    SELECT CsxNensi
                    APPEND FROM DBF("CszNensi")
                ENDIF
                IF USED("CszNensi")
                    USE IN CszNensi
                ENDIF
            ENDIF

            *-- 6. Operacoes de inspecao via SigOpOeo (SigMvItn/SigInBep/SigOpPic)
            loc_cSQL = "SELECT dopes FROM SigOpOeo"
            IF USED("TmpEOpp_4c")
                USE IN TmpEOpp_4c
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "TmpEOpp_4c")
            loc_lTemOpEopp = USED("TmpEOpp_4c") AND RECCOUNT("TmpEOpp_4c") > 0

            IF loc_lTemOpEopp AND USED("CsxNensi")
                loc_cSQL = "SELECT a.cpros, SUM(a.qtds) AS Qtds " + ;
                           "FROM SigMvItn a " + ;
                           "JOIN SigInBep b ON a.empDopNums = b.EmpDopNums " + ;
                           "JOIN SigCdNei c ON b.empdnps = c.empdnps " + ;
                           "JOIN SigOpPic d ON c.Nops = d.Nops " + ;
                           "JOIN SigCdSvc e ON a.Cpros = e.ccats " + ;
                           "WHERE c.nenvs = " + FormatarNumeroSQL(par_nNenv) + ;
                           " AND a.cpro2s = d.Cpros " + ;
                           "GROUP BY a.Cpros"
                IF USED("CsTmp3_4c")
                    USE IN CsTmp3_4c
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSQL, "CsTmp3_4c")
                IF USED("CsTmp3_4c") AND RECCOUNT("CsTmp3_4c") > 0
                    SELECT CsxNensi
                    APPEND FROM DBF("CsTmp3_4c")
                ENDIF
                IF USED("CsTmp3_4c")
                    USE IN CsTmp3_4c
                ENDIF
            ENDIF
            IF USED("TmpEOpp_4c")
                USE IN TmpEOpp_4c
            ENDIF

            *-- 7. Processa CrSigCdNei: atualiza ou insere em CrTmpCompo
            IF USED("CrSigCdNei")
                SELECT CrSigCdNei
                SCAN FOR NVL(Nops, 0) = par_nNops
                    IF EMPTY(ALLTRIM(NVL(CMats, ""))) OR ;
                       IIF(VARTYPE(Servicos)="L", Servicos, NVL(Servicos,0)=1)
                        LOOP
                    ENDIF
                    loc_cCMats = ALLTRIM(NVL(CMats, ""))
                    loc_nPeso2 = NVL(Peso2s, 0)
                    loc_nQtds  = NVL(Qtds, 0)

                    *-- Dados do produto/grupo do material
                    loc_cSQL = "SELECT p.Dpros, p.Cunis, p.cUniPs, p.Cgrus, p.CustoFs, p.MoeCusFs " + ;
                               "FROM SigCdPro p WHERE p.Cpros = " + EscaparSQL(loc_cCMats)
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspPro")
                    loc_cSQL = "SELECT g.EtiPads FROM SigCdGrp g " + ;
                               "JOIN SigCdPro p ON p.Cgrus = g.Cgrus " + ;
                               "WHERE p.Cpros = " + EscaparSQL(loc_cCMats)
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspGrp")
                    *-- Verifica Peso2s: se unidade tem Fators=0 e QtEqualPs<>'S', usa pesos do movimento
                    loc_cSQL = "SELECT u.Fators, u.QtEqualPs FROM SigCdUni u " + ;
                               "JOIN SigCdPro p ON p.Cunis = u.cUnis " + ;
                               "WHERE p.Cpros = " + EscaparSQL(loc_cCMats)
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspUni")
                    IF loc_nPeso2 = 0 AND USED("cursor_4c_EspUni")
                        SELECT cursor_4c_EspUni
                        GO TOP
                        IF !EOF() AND NVL(Fators,0)=0 AND ALLTRIM(NVL(QtEqualPs,""))<>"S"
                            SELECT CrSigCdNei
                            loc_nPeso2 = NVL(Pesos, 0)
                        ENDIF
                    ENDIF

                    *-- Atualiza CrTmpCompo
                    SELECT CrTmpCompo
                    IF SEEK(loc_cCMats)
                        IF NVL(TpAlts, 0) = 0
                            REPLACE Qtds WITH loc_nQtds, Pesos WITH loc_nPeso2, TpAlts WITH 1
                        ELSE
                            IF NVL(TpAlts, 0) > 0
                                REPLACE Qtds WITH NVL(Qtds,0)+loc_nQtds, Pesos WITH NVL(Pesos,0)+loc_nPeso2
                            ENDIF
                        ENDIF
                    ELSE
                        APPEND BLANK
                        loc_cDpros    = ""
                        loc_cCunis    = ""
                        loc_cCuniPs   = ""
                        loc_cCgrus2   = ""
                        loc_nCustoFs  = 0
                        loc_cMoeCusFs = ""
                        loc_cEtiPads  = ""
                        IF USED("cursor_4c_EspPro")
                            SELECT cursor_4c_EspPro
                            GO TOP
                            loc_cDpros    = ALLTRIM(NVL(Dpros,    ""))
                            loc_cCunis    = ALLTRIM(NVL(Cunis,    ""))
                            loc_cCuniPs   = ALLTRIM(NVL(cUniPs,   ""))
                            loc_cCgrus2   = ALLTRIM(NVL(Cgrus,    ""))
                            loc_nCustoFs  = NVL(CustoFs,   0)
                            loc_cMoeCusFs = ALLTRIM(NVL(MoeCusFs, ""))
                        ENDIF
                        IF USED("cursor_4c_EspGrp")
                            SELECT cursor_4c_EspGrp
                            GO TOP
                            IF !EOF()
                                loc_cEtiPads = ALLTRIM(NVL(EtiPads, ""))
                            ENDIF
                        ENDIF
                        SELECT CrTmpCompo
                        REPLACE cpros     WITH par_cCpros,   ;
                                Mats      WITH loc_cCMats,   ;
                                Qtds      WITH loc_nQtds,    ;
                                Pesos     WITH loc_nPeso2,   ;
                                dcompos   WITH loc_cDpros,   ;
                                UniCompos WITH loc_cCunis,   ;
                                cUniPs    WITH loc_cCuniPs,  ;
                                cgrus     WITH loc_cCgrus2,  ;
                                pcompos   WITH loc_nCustoFs, ;
                                Moeds     WITH loc_cMoeCusFs,;
                                DtMovs    WITH DATETIME(),   ;
                                TpAlts    WITH 2,            ;
                                cIdChaves WITH ALLTRIM(fUniqueIds()), ;
                                Etiqs     WITH loc_cEtiPads
                    ENDIF
                    IF USED("cursor_4c_EspPro")
                        USE IN cursor_4c_EspPro
                    ENDIF
                    IF USED("cursor_4c_EspGrp")
                        USE IN cursor_4c_EspGrp
                    ENDIF
                    IF USED("cursor_4c_EspUni")
                        USE IN cursor_4c_EspUni
                    ENDIF
                    SELECT CrSigCdNei
                ENDSCAN
            ENDIF

            *-- 8. Processa CsxNensi: servicos de producao
            IF USED("CsxNensi")
                SELECT CsxNensi
                GO TOP
                DO WHILE !EOF()
                    loc_cSvcCpros = ALLTRIM(NVL(CsxNensi.cpros, ""))
                    loc_nSvcQtds  = NVL(CsxNensi.Qtds, 0)
                    loc_cSQL = "SELECT p.Dpros, p.Cunis, p.cUniPs, p.Cgrus, p.CustoFs, p.MoeCusFs " + ;
                               "FROM SigCdPro p WHERE p.Cpros = " + EscaparSQL(loc_cSvcCpros)
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SvcPro")
                    loc_cSQL = "SELECT g.EtiPads FROM SigCdGrp g " + ;
                               "JOIN SigCdPro p ON p.Cgrus = g.Cgrus " + ;
                               "WHERE p.Cpros = " + EscaparSQL(loc_cSvcCpros)
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SvcGrp")
                    IF USED("CrTmpCompo")
                        SELECT CrTmpCompo
                        IF SEEK(loc_cSvcCpros)
                            IF NVL(TpAlts, 0) = 0
                                REPLACE Qtds WITH loc_nSvcQtds, TpAlts WITH 1
                            ELSE
                                IF NVL(TpAlts, 0) > 0
                                    REPLACE Qtds WITH NVL(Qtds, 0) + loc_nSvcQtds
                                ENDIF
                            ENDIF
                        ELSE
                            APPEND BLANK
                            loc_cSvcEtiPads  = ""
                            loc_cSvcDpros    = ""
                            loc_cSvcCunis    = ""
                            loc_cSvcCuniPs   = ""
                            loc_cSvcCgrus    = ""
                            loc_nSvcCustoFs  = 0
                            loc_cSvcMoeCusFs = ""
                            IF USED("cursor_4c_SvcPro")
                                SELECT cursor_4c_SvcPro
                                GO TOP
                                loc_cSvcDpros    = ALLTRIM(NVL(Dpros,    ""))
                                loc_cSvcCunis    = ALLTRIM(NVL(Cunis,    ""))
                                loc_cSvcCuniPs   = ALLTRIM(NVL(cUniPs,   ""))
                                loc_cSvcCgrus    = ALLTRIM(NVL(Cgrus,    ""))
                                loc_nSvcCustoFs  = NVL(CustoFs,   0)
                                loc_cSvcMoeCusFs = ALLTRIM(NVL(MoeCusFs, ""))
                            ENDIF
                            IF USED("cursor_4c_SvcGrp")
                                SELECT cursor_4c_SvcGrp
                                GO TOP
                                IF !EOF()
                                    loc_cSvcEtiPads = ALLTRIM(NVL(EtiPads, ""))
                                ENDIF
                            ENDIF
                            SELECT CrTmpCompo
                            REPLACE cpros     WITH par_cCpros,      ;
                                    Mats      WITH loc_cSvcCpros,   ;
                                    Qtds      WITH loc_nSvcQtds,    ;
                                    Pesos     WITH 0,               ;
                                    dcompos   WITH loc_cSvcDpros,   ;
                                    UniCompos WITH loc_cSvcCunis,   ;
                                    cUniPs    WITH loc_cSvcCuniPs,  ;
                                    cgrus     WITH loc_cSvcCgrus,   ;
                                    pcompos   WITH loc_nSvcCustoFs, ;
                                    Moeds     WITH loc_cSvcMoeCusFs,;
                                    DtMovs    WITH DATETIME(),      ;
                                    TpAlts    WITH 2,               ;
                                    cIdChaves WITH ALLTRIM(fUniqueIds()), ;
                                    Etiqs     WITH loc_cSvcEtiPads
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_SvcPro")
                        USE IN cursor_4c_SvcPro
                    ENDIF
                    IF USED("cursor_4c_SvcGrp")
                        USE IN cursor_4c_SvcGrp
                    ENDIF
                    SELECT CsxNensi
                    SKIP
                ENDDO
                USE IN CsxNensi
            ENDIF
            IF USED("CsTmpSer")
                USE IN CsTmpSer
            ENDIF

            *-- 9. Remove itens que nao devem ser gravados (TpAlts=0, CEstoqs=1, ImpOps=1)
            IF USED("CrTmpCompo")
                SELECT CrTmpCompo
                GO TOP
                DO WHILE !EOF()
                    IF NVL(TpAlts, 0) = 0
                        loc_cSQL = "SELECT g.CEstoqs, g.ImpOps FROM SigCdGrp g " + ;
                                   "JOIN SigCdPro p ON p.Cgrus = g.Cgrus " + ;
                                   "WHERE p.Cpros = " + EscaparSQL(ALLTRIM(NVL(Mats, "")))
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EspFilt")
                        IF loc_nRet >= 1 AND USED("cursor_4c_EspFilt")
                            SELECT cursor_4c_EspFilt
                            GO TOP
                            IF NVL(CEstoqs, 0) = 1 AND NVL(ImpOps, 0) = 1
                                SELECT CrTmpCompo
                                DELETE
                            ENDIF
                            USE IN cursor_4c_EspFilt
                        ENDIF
                    ENDIF
                    SELECT CrTmpCompo
                    SKIP
                ENDDO
            ENDIF

            *-- 10. Grava composicao especial no SQL Server
            loc_lSucesso = THIS.this_oBusinessObject.GravarComposicaoEspecial("CrTmpCompo")

            IF loc_lSucesso
                *-- Abre form de produto para revisao da composicao
                DO FORM SigCdPro WITH "PESAGEM", par_cCpros
            ELSE
                MsgErro("Falha ao gravar composi" + CHR(231) + CHR(227) + "o especial.", "Erro")
            ENDIF

            *-- Reposiciona xPesa no registro original
            IF USED("xPesa") AND par_nRecno > 0
                SELECT xPesa
                GO par_nRecno
            ENDIF

            IF USED("CrTmpCompo")
                USE IN CrTmpCompo
            ENDIF
            ENDIF && loc_nRet >= 1
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar pe" + CHR(231) + "a especial")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Atualiza o grid com os dados do cursor xPesa
    * Form OPERACIONAL: xPesa ja vem pre-carregado do form pai.
    * Este metodo apenas reposiciona e rebind o RecordSource quando necessario.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oErro
        TRY
            IF USED("xPesa") AND VARTYPE(THIS.grd_4c_Itens) = "O"
                SELECT xPesa
                GO TOP
                THIS.grd_4c_Itens.RecordSource = "xPesa"
                WITH THIS.grd_4c_Itens
                    .Column1.Header1.Caption = "Produto"
                    .Column2.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
                    .Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
                    .Column4.Header1.Caption = "Tam"
                    .Column5.Header1.Caption = "Quantidade"
                    .Column6.Header1.Caption = "Peso"
                    .Column7.Header1.Caption = "Cor"
                    .Column8.Header1.Caption = "Barras"
                    .Column9.Header1.Caption = "Custo"
                    .Refresh()
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar lista de pe" + CHR(231) + "as")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo do form pai
    * INSERIR/ALTERAR: Processar habilitado, grid editavel
    * VISUALIZAR: apenas Resumo, CustoP e Cancelar habilitados
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_cModo, loc_lEdicao, loc_lAcesso
        loc_cModo   = ""
        loc_lEdicao = .F.
        loc_lAcesso = fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP")
        IF VARTYPE(THIS.this_oPaiForm) = "O"
            loc_cModo   = ALLTRIM(NVL(THIS.this_oPaiForm.pcEscolha, ""))
            loc_lEdicao = INLIST(loc_cModo, "INSERIR", "ALTERAR")
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Processar) = "O"
            THIS.cmd_4c_Processar.Enabled = loc_lEdicao
        ENDIF
        IF VARTYPE(THIS.cmd_4c_CustoP) = "O"
            THIS.cmd_4c_CustoP.Visible  = loc_lAcesso
            THIS.cmd_4c_CustoP.Enabled  = loc_lAcesso AND loc_lEdicao
        ENDIF
        IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
            THIS.txt_4c_PesoMedio.ReadOnly = !loc_lEdicao
        ENDIF
        IF VARTYPE(THIS.grd_4c_Itens) = "O"
            THIS.grd_4c_Itens.ReadOnly = !loc_lEdicao
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do form para o Business Object
    * Form OPERACIONAL: o principal e o cursor xPesa (gerenciado diretamente).
    * Aqui transferimos apenas estado auxiliar (peso medio, prog acesso).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            RETURN
        ENDIF
        IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
            THIS.this_oBusinessObject.this_nPesoMedio = NVL(THIS.txt_4c_PesoMedio.Value, 0)
        ENDIF
        THIS.this_oBusinessObject.this_cProgAcesso    = THIS.this_cProgAcesso
        THIS.this_oBusinessObject.this_lAlterou       = THIS.this_lAlterou
        THIS.this_oBusinessObject.this_nOldValue      = THIS.this_nOldValue
        THIS.this_oBusinessObject.this_lLiberaPeso    = THIS.this_lLiberaPeso
        IF USED("xPesa")
            SELECT xPesa
            THIS.this_oBusinessObject.this_cCpros   = ALLTRIM(NVL(Cpros,    ""))
            THIS.this_oBusinessObject.this_cObs     = ALLTRIM(NVL(Obs,      ""))
            THIS.this_oBusinessObject.this_cOper    = ALLTRIM(NVL(Oper,     ""))
            THIS.this_oBusinessObject.this_nQtds    = NVL(Qtds,    0)
            THIS.this_oBusinessObject.this_nPeso    = NVL(Peso,    0)
            THIS.this_oBusinessObject.this_cTams    = ALLTRIM(NVL(Tams,     ""))
            THIS.this_oBusinessObject.this_cCors    = ALLTRIM(NVL(Cors,     ""))
            THIS.this_oBusinessObject.this_cCbars   = ALLTRIM(NVL(Cbars,    ""))
            THIS.this_oBusinessObject.this_nCustoFs = NVL(CustoFs, 0)
            THIS.this_oBusinessObject.this_nNops    = NVL(Nops,    0)
            THIS.this_oBusinessObject.this_nNenvs   = NVL(Nenvs,   0)
            THIS.this_oBusinessObject.this_nPesoFixs = NVL(PesoFixs, 0)
            THIS.this_oBusinessObject.this_lEspecial = IIF(VARTYPE(Especial)="L", Especial, NVL(Especial,0)=1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do Business Object para o form
    * Form OPERACIONAL: restaura peso medio e atualiza grid
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            RETURN
        ENDIF
        IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
            THIS.txt_4c_PesoMedio.Value = NVL(THIS.this_oBusinessObject.this_nPesoMedio, 0)
        ENDIF
        IF VARTYPE(THIS.grd_4c_Itens) = "O"
            THIS.grd_4c_Itens.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita edicao conforme par_lHabilitar
    * Form OPERACIONAL: controla grid e campo de peso medio
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lLibObss
        loc_lLibObss = .F.
        IF USED("crSigCdPam")
            SELECT crSigCdPam
            GO TOP
            IF VARTYPE(crSigCdPam.LibObss) = "L"
                loc_lLibObss = crSigCdPam.LibObss
            ELSE
                IF VARTYPE(crSigCdPam.LibObss) = "L"
                    loc_lLibObss = crSigCdPam.LibObss
                ELSE
                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                        loc_lLibObss = crSigCdPam.LibObss
                    ELSE
                        IF VARTYPE(crSigCdPam.LibObss) = "L"
                            loc_lLibObss = crSigCdPam.LibObss
                        ELSE
                            IF VARTYPE(crSigCdPam.LibObss) = "L"
                                loc_lLibObss = crSigCdPam.LibObss
                            ELSE
                                IF VARTYPE(crSigCdPam.LibObss) = "L"
                                    loc_lLibObss = crSigCdPam.LibObss
                                ELSE
                                    IF VARTYPE(crSigCdPam.LibObss) = "L"
                                        loc_lLibObss = crSigCdPam.LibObss
                                    ELSE
                                        loc_lLibObss = (NVL(crSigCdPam.LibObss, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
            THIS.txt_4c_PesoMedio.ReadOnly = !par_lHabilitar
        ENDIF
        IF VARTYPE(THIS.grd_4c_Itens) = "O"
            IF !par_lHabilitar
                THIS.grd_4c_Itens.ReadOnly = .T.
            ELSE
                THIS.grd_4c_Itens.ReadOnly = .F.
                THIS.grd_4c_Itens.Column4.ReadOnly = !loc_lLibObss
                THIS.grd_4c_Itens.Column6.ReadOnly = .F.
                THIS.grd_4c_Itens.Column7.ReadOnly = !loc_lLibObss
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera campos de entrada do form
    * Form OPERACIONAL: zera peso medio e reposiciona grid no inicio
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        THIS.this_lAlterou  = .F.
        THIS.this_nOldValue = 0
        IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
            THIS.txt_4c_PesoMedio.Value = 0
        ENDIF
        IF USED("xPesa") AND VARTYPE(THIS.grd_4c_Itens) = "O"
            SELECT xPesa
            GO TOP
            THIS.grd_4c_Itens.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Equivalente a BtnProcessarClick para forms OPERACIONAIS
    * Confirma a pesagem e encerra o form (chamado pelo FormBase se necessario)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnProcessarClick()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega/reposiciona o grid com os dados do cursor xPesa
    * Form OPERACIONAL: sem busca por codigo; apenas refresh da lista de pecas
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Equivalente a Cancelar para forms OPERACIONAIS
    * Habilita form pai e fecha sem processar a pesagem
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelarClick()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPdMp9BO.prg):
*------------------------------------------------------------------------------
* SigPdMp9BO.prg - Business Object: Pesagem de Pe" + CHR(231) + "as
* Herda de BusinessBase
* Tabela principal: SigPrCpo (composi" + CHR(231) + CHR(227) + "o especial de pe" + CHR(231) + "as)
* Cursor de trabalho: xPesa (gerenciado pelo form pai SigPdM8/similar)
*------------------------------------------------------------------------------
DEFINE CLASS SigPdMp9BO AS BusinessBase

    *-- Dados da linha atual do cursor xPesa (grid GradeItens)
    this_cCpros      = ""    && Codigo do produto (Column1 - Produto)
    this_cObs        = ""    && Observacao (Column2 - Observa" + CHR(231) + CHR(227) + "o)
    this_cOper       = ""    && Opera" + CHR(231) + CHR(227) + "o/Movimenta" + CHR(231) + CHR(227) + "o (Column3)
    this_nQtds       = 0     && Quantidade (Column5 - Quantidade)
    this_nPeso       = 0     && Peso (Column6 - Peso)
    this_cTams       = ""    && Codigo do tamanho (Column4 - Tam)
    this_cCors       = ""    && Codigo da cor (Column7 - Cor)
    this_cCbars      = ""    && Codigo de barras (Column8 - Barras)
    this_nCustoFs    = 0     && Custo de produ" + CHR(231) + CHR(227) + "o (Column9 - Custo)
    this_lEspecial   = .F.   && Flag pe" + CHR(231) + "a especial (DynamicForeColor vermelho)
    this_nNops       = 0     && N" + CHR(250) + "mero da opera" + CHR(231) + CHR(227) + "o
    this_nNenvs      = 0     && N" + CHR(250) + "mero do envelope/pe" + CHR(231) + "a
    this_nPesoFixs   = 0     && Peso fixo da pe" + CHR(231) + "a
    this_cUsuLibs    = ""    && Usu" + CHR(225) + "rio que liberou pesagem fora do limite
    this_cMatPs      = ""    && Material da pe" + CHR(231) + "a (para rateio)
    this_nPeso2s     = 0     && Peso secund" + CHR(225) + "rio da pe" + CHR(231) + "a

    *-- Estado do processo de pesagem
    this_lAlterou    = .F.   && Indica se peso foi alterado na linha atual
    this_lLiberaPeso = .F.   && Indica se usu" + CHR(225) + "rio tem permiss" + CHR(227) + "o para liberar pesagem
    this_nOldValue   = 0     && Valor anterior do peso antes da edi" + CHR(231) + CHR(227) + "o
    this_nPesoMedio  = 0     && Peso m" + CHR(233) + "dio calculado (campo get_pesom)

    *-- C" + CHR(243) + "digo de acesso ao programa para verifica" + CHR(231) + CHR(227) + "o de permiss" + CHR(227) + "o (fChecaAcesso)
    this_cProgAcesso = ""    && Ex: 'P00000001' constru" + CHR(237) + "do a partir de Ndopps

    *-- Data de refer" + CHR(234) + "ncia para cota" + CHR(231) + CHR(245) + "es de moeda (de TmpNens.Datas)
    this_dDataMovimento = {} && Data da movimenta" + CHR(231) + CHR(227) + "o atual

    *-- Propriedades de composi" + CHR(231) + CHR(227) + "o SigPrCpo (para INSERT/UPDATE via ExecutarInsercao/ExecutarAtualizacao)
    this_cIdChaves       = ""   && cidchaves char(20) PRIMARY KEY
    this_cMats           = ""   && mats char(14) - c" + CHR(243) + "digo do material
    this_cCgrus          = ""   && cgrus char(3) - c" + CHR(243) + "digo do grupo
    this_cCats           = ""   && cats char(6) - categoria
    this_cDcompos        = ""   && dcompos char(40) - descri" + CHR(231) + CHR(227) + "o da composi" + CHR(231) + CHR(227) + "o
    this_cDscGrp         = ""   && dscgrp char(20) - descri" + CHR(231) + CHR(227) + "o do grupo
    this_cEtiqs          = ""   && etiqs char(1) - etiqueta
    this_cGrupos         = ""   && grupos char(10) - grupos
    this_cMoeds          = ""   && moeds char(3) - moeda
    this_cObsCompos      = ""   && obscompos char(10) - observa" + CHR(231) + CHR(227) + "o
    this_nOrdems         = 0    && ordems numeric(2,0) - ordem
    this_nPcompos        = 0    && pcompos numeric(11,3) - pre" + CHR(231) + "o
    this_nQtdsCompo      = 0    && qtds numeric(8,3) - quantidade na composi" + CHR(231) + CHR(227) + "o
    this_nQtscons        = 0    && qtscons numeric(8,3) - qtd consumida
    this_cUniCompos      = ""   && unicompos char(3) - unidade
    this_cCompos         = ""   && compos char(10) - composi" + CHR(231) + CHR(227) + "o
    this_nOrdCompos      = 0    && ordcompos numeric(2,0) - ordem composi" + CHR(231) + CHR(227) + "o
    this_nQtdCvs         = 0    && qtdcvs numeric(11,3) - qtd convertida
    this_nVlrCvs         = 0    && vlrcvs numeric(11,2) - valor convertido
    this_dDtMovs         = {}   && dtmovs - data do movimento
    this_cCuniPs         = ""   && cunips char(3) - unidade peso
    this_nMarkCvs        = 0    && markcvs numeric(9,6) - markup convertido
    this_nPesos          = 0    && pesos numeric(8,3) - peso na composi" + CHR(231) + CHR(227) + "o
    this_nTotas          = 0    && totas numeric(11,3) - total
    this_nTpAlts         = 0    && tpalts numeric(1,0) - tipo de altera" + CHR(231) + CHR(227) + "o
    this_nVlrPvs         = 0    && vlrpvs numeric(11,2) - valor venda
    this_nOrdTs          = 0    && ordts numeric(2,0) - ordem t
    this_cTipos          = ""   && tipos char(20) - tipos
    this_cMatriz         = ""   && matriz char(14) - matriz
    this_cObsOfs         = ""   && obsofs char(120) - obs ofertas
    this_nPedraPrincipal = 0    && PedraPrincipal numeric(1,0)

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "SigPrCpo"
        THIS.this_cCampoChave = "cIdChaves"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna cIdChaves do registro atual
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir do cursor xPesa
    * par_cAliasCursor: alias do cursor (tipicamente "xPesa")
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCpros    = ALLTRIM(NVL(Cpros,    ""))
            THIS.this_cObs      = ALLTRIM(NVL(Obs,      ""))
            THIS.this_cOper     = ALLTRIM(NVL(Oper,     ""))
            THIS.this_nQtds     = NVL(Qtds,     0)
            THIS.this_nPeso     = NVL(Peso,     0)
            THIS.this_cTams     = ALLTRIM(NVL(Tams,    ""))
            THIS.this_cCors     = ALLTRIM(NVL(Cors,    ""))
            THIS.this_cCbars    = ALLTRIM(NVL(Cbars,   ""))
            THIS.this_nCustoFs  = NVL(CustoFs,  0)
            THIS.this_lEspecial = IIF(VARTYPE(Especial) = "L", Especial, NVL(Especial, 0) = 1)
            THIS.this_nNops     = NVL(Nops,     0)
            THIS.this_nNenvs    = NVL(Nenvs,    0)
            THIS.this_nPesoFixs = NVL(PesoFixs, 0)
            THIS.this_cUsuLibs  = ALLTRIM(NVL(UsuLibs, ""))
            THIS.this_cMatPs    = ALLTRIM(NVL(MatPs,   ""))
            THIS.this_nPeso2s   = NVL(Peso2s,   0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados m" + CHR(237) + "nimos antes de gravar SigPrCpo
    *==========================================================================
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_cCpros)
            MsgAviso("O c" + CHR(243) + "digo do produto deve ser informado.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cMats)
            MsgAviso("O c" + CHR(243) + "digo do material deve ser informado.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ExecutarInsercao - INSERT INTO SigPrCpo com os dados das propriedades do BO
    *==========================================================================
    PROTECTED FUNCTION ExecutarInsercao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cIdChaves = ALLTRIM(fUniqueIds())
            ENDIF

            loc_cSQL = "INSERT INTO SigPrCpo (" + ;
                       "cidchaves, cpros, mats, cgrus, cats, dcompos, dscgrp, etiqs, grupos, " + ;
                       "moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, " + ;
                       "ordcompos, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, " + ;
                       "tpalts, vlrpvs, ordts, tipos, matriz, obsofs, datatrans, PedraPrincipal) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves)        + ", " + ;
                       EscaparSQL(THIS.this_cCpros)           + ", " + ;
                       EscaparSQL(THIS.this_cMats)            + ", " + ;
                       EscaparSQL(THIS.this_cCgrus)           + ", " + ;
                       EscaparSQL(THIS.this_cCats)            + ", " + ;
                       EscaparSQL(THIS.this_cDcompos)         + ", " + ;
                       EscaparSQL(THIS.this_cDscGrp)          + ", " + ;
                       EscaparSQL(THIS.this_cEtiqs)           + ", " + ;
                       EscaparSQL(THIS.this_cGrupos)          + ", " + ;
                       EscaparSQL(THIS.this_cMoeds)           + ", " + ;
                       EscaparSQL(THIS.this_cObsCompos)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdems)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPcompos)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdsCompo)+ ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtscons)  + ", " + ;
                       EscaparSQL(THIS.this_cUniCompos)       + ", " + ;
                       EscaparSQL(THIS.this_cCompos)          + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdCompos)+ ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdCvs)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVlrCvs)   + ", " + ;
                       "GETDATE(), "                          + ;
                       EscaparSQL(THIS.this_cCuniPs)          + ", " + ;
                       FormatarNumeroSQL(THIS.this_nMarkCvs)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesos)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotas)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTpAlts)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVlrPvs)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdTs)    + ", " + ;
                       EscaparSQL(THIS.this_cTipos)           + ", " + ;
                       EscaparSQL(THIS.this_cMatriz)          + ", " + ;
                       EscaparSQL(THIS.this_cObsOfs)          + ", " + ;
                       "GETDATE(), "                          + ;
                       FormatarNumeroSQL(THIS.this_nPedraPrincipal) + ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Falha ao inserir composi" + CHR(231) + CHR(227) + "o em SigPrCpo.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir SigPrCpo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarAtualizacao - UPDATE SigPrCpo WHERE cpros = AND mats =
    *==========================================================================
    PROTECTED FUNCTION ExecutarAtualizacao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCpros) OR EMPTY(THIS.this_cMats)
                MsgErro("Produto ou material n" + CHR(227) + "o informado para UPDATE.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigPrCpo SET " + ;
                       "cgrus = "     + EscaparSQL(THIS.this_cCgrus)            + ", " + ;
                       "cats = "      + EscaparSQL(THIS.this_cCats)             + ", " + ;
                       "dcompos = "   + EscaparSQL(THIS.this_cDcompos)          + ", " + ;
                       "dscgrp = "    + EscaparSQL(THIS.this_cDscGrp)           + ", " + ;
                       "etiqs = "     + EscaparSQL(THIS.this_cEtiqs)            + ", " + ;
                       "grupos = "    + EscaparSQL(THIS.this_cGrupos)           + ", " + ;
                       "moeds = "     + EscaparSQL(THIS.this_cMoeds)            + ", " + ;
                       "obscompos = " + EscaparSQL(THIS.this_cObsCompos)        + ", " + ;
                       "ordems = "    + FormatarNumeroSQL(THIS.this_nOrdems)    + ", " + ;
                       "pcompos = "   + FormatarNumeroSQL(THIS.this_nPcompos)   + ", " + ;
                       "qtds = "      + FormatarNumeroSQL(THIS.this_nQtdsCompo) + ", " + ;
                       "qtscons = "   + FormatarNumeroSQL(THIS.this_nQtscons)   + ", " + ;
                       "unicompos = " + EscaparSQL(THIS.this_cUniCompos)        + ", " + ;
                       "compos = "    + EscaparSQL(THIS.this_cCompos)           + ", " + ;
                       "ordcompos = " + FormatarNumeroSQL(THIS.this_nOrdCompos) + ", " + ;
                       "qtdcvs = "    + FormatarNumeroSQL(THIS.this_nQtdCvs)    + ", " + ;
                       "vlrcvs = "    + FormatarNumeroSQL(THIS.this_nVlrCvs)    + ", " + ;
                       "dtmovs = GETDATE(), " + ;
                       "cunips = "    + EscaparSQL(THIS.this_cCuniPs)           + ", " + ;
                       "markcvs = "   + FormatarNumeroSQL(THIS.this_nMarkCvs)   + ", " + ;
                       "pesos = "     + FormatarNumeroSQL(THIS.this_nPesos)     + ", " + ;
                       "totas = "     + FormatarNumeroSQL(THIS.this_nTotas)     + ", " + ;
                       "tpalts = "    + FormatarNumeroSQL(THIS.this_nTpAlts)    + ", " + ;
                       "vlrpvs = "    + FormatarNumeroSQL(THIS.this_nVlrPvs)    + ", " + ;
                       "ordts = "     + FormatarNumeroSQL(THIS.this_nOrdTs)     + ", " + ;
                       "tipos = "     + EscaparSQL(THIS.this_cTipos)            + ", " + ;
                       "matriz = "    + EscaparSQL(THIS.this_cMatriz)           + ", " + ;
                       "obsofs = "    + EscaparSQL(THIS.this_cObsOfs)           + ", " + ;
                       "PedraPrincipal = " + FormatarNumeroSQL(THIS.this_nPedraPrincipal) + ;
                       " WHERE cpros = " + EscaparSQL(THIS.this_cCpros) + ;
                       " AND mats = "    + EscaparSQL(THIS.this_cMats)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Falha ao atualizar composi" + CHR(231) + CHR(227) + "o em SigPrCpo.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar SigPrCpo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarPermissaoLiberaPeso - Verifica se existe usu" + CHR(225) + "rio com senha de libera" + CHR(231) + CHR(227) + "o
    * Seta this_lLiberaPeso e retorna .T. se ao menos um usu" + CHR(225) + "rio tem LibPess='S'
    * Replica: lcSql = [Select Count(*) as Senha From SigCdUsu Where LibPess = 'S' And Senhas <> ' ']
    *==========================================================================
    FUNCTION BuscarPermissaoLiberaPeso()
        LOCAL loc_lPodeLiberar, loc_cSQL, loc_nRet, loc_oErro
        loc_lPodeLiberar = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS Senha FROM SigCdUsu " + ;
                       "WHERE LibPess = 'S' AND Senhas <> ' '"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSenha")
            IF loc_nRet >= 1
                SELECT cursor_4c_TmpSenha
                GO TOP
                IF NVL(Senha, 0) > 0
                    loc_lPodeLiberar = .T.
                ENDIF
                IF USED("cursor_4c_TmpSenha")
                    USE IN cursor_4c_TmpSenha
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar permiss" + CHR(227) + "o de peso")
        ENDTRY
        THIS.this_lLiberaPeso = loc_lPodeLiberar
        RETURN loc_lPodeLiberar
    ENDFUNC

    *==========================================================================
    * VerificarDiferencaPeso - Valida se novo peso est" + CHR(225) + " dentro do limite tolerado
    * par_nPesoNovo: valor do peso digitado pelo usu" + CHR(225) + "rio
    * Retorna .T. se dentro do limite (ou sem configura" + CHR(231) + CHR(227) + "o de limite)
    *         .F. se fora do limite (form deve tratar autoriza" + CHR(231) + CHR(227) + "o)
    * Replica logica de Column6.Text1.Valid do legado
    *==========================================================================
    FUNCTION VerificarDiferencaPeso(par_nPesoNovo)
        LOCAL loc_lDentroLimite, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_nDifPesags, loc_cDifPes, loc_nPesoMs
        LOCAL loc_nPesagem, loc_nXDif, loc_nSinals
        loc_lDentroLimite = .T.
        TRY
            *-- Busca flag de controle de diferenca de peso da empresa
            loc_cSQL = "SELECT DifPes FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDif")
            IF loc_nRet < 1
                loc_lSucesso = .T.
            ENDIF
            SELECT cursor_4c_EmpDif
            GO TOP
            loc_cDifPes = ALLTRIM(NVL(DifPes, ""))
            IF USED("cursor_4c_EmpDif")
                USE IN cursor_4c_EmpDif
            ENDIF

            *-- Busca tolerancia da parametrizacao (crSigCdPam.DifPesags, .Sinals)
            IF !USED("crSigCdPam")
                loc_lSucesso = .T.
            ENDIF
            SELECT crSigCdPam
            GO TOP
            loc_nDifPesags = NVL(DifPesags, 0)
            loc_nSinals    = NVL(Sinals, 0)

            IF loc_nDifPesags = 0 OR loc_cDifPes <> "S"
                loc_lSucesso = .T.
            ENDIF

            *-- Busca peso nominal do produto
            loc_cSQL = "SELECT PesoMs FROM SigCdPro " + ;
                       "WHERE Cpros = " + EscaparSQL(THIS.this_cCpros)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProPeso")
            IF loc_nRet < 1
                loc_lSucesso = .T.
            ENDIF
            SELECT cursor_4c_ProPeso
            GO TOP
            loc_nPesoMs = NVL(PesoMs, 0)
            IF USED("cursor_4c_ProPeso")
                USE IN cursor_4c_ProPeso
            ENDIF

            IF loc_nPesoMs = 0
                loc_lSucesso = .T.
            ENDIF

            *-- Calcula peso real por pe" + CHR(231) + "a e percentual de diferen" + CHR(231) + "a
            loc_nPesagem = 0
            IF THIS.this_nQtds <> 0
                loc_nPesagem = (par_nPesoNovo / THIS.this_nQtds) - THIS.this_nPesoFixs
            ENDIF

            IF loc_nPesagem <> loc_nPesoMs
                loc_nXDif = (((loc_nPesagem / loc_nPesoMs) - 1) * 100)
                IF (loc_nXDif < (loc_nDifPesags * -1) AND loc_nSinals <> 1) OR ;
                   (loc_nXDif > loc_nDifPesags AND loc_nSinals <> 2)
                    loc_lDentroLimite = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar diferen" + CHR(231) + "a de peso")
            loc_lDentroLimite = .T.
        ENDTRY
        RETURN loc_lDentroLimite
    ENDFUNC

    *==========================================================================
    * AtualizarPesoMedio - Distribui peso m" + CHR(233) + "dio por todas as pe" + CHR(231) + "as do cursor xPesa
    * par_nPesoMedio: valor do campo get_pesom
    * Replica logica de get_pesom.Valid do legado
    *==========================================================================
    FUNCTION AtualizarPesoMedio(par_nPesoMedio)
        LOCAL loc_lSucesso, loc_nTotal, loc_nPesoPorUnid, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !USED("xPesa") OR par_nPesoMedio = 0
                loc_lSucesso = .F.
            ENDIF
            SELECT xPesa
            SUM Qtds TO loc_nTotal
            IF loc_nTotal = 0
                loc_lSucesso = .F.
            ENDIF
            loc_nPesoPorUnid = par_nPesoMedio / loc_nTotal
            SELECT xPesa
            SCAN
                REPLACE Peso WITH NVL(Qtds, 0) * loc_nPesoPorUnid
            ENDSCAN
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar peso m" + CHR(233) + "dio")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CalcularCustoProducao - Calcula custo de produ" + CHR(231) + CHR(227) + "o de uma pe" + CHR(231) + "a
    * par_nNops: n" + CHR(250) + "mero da opera" + CHR(231) + CHR(227) + "o
    * par_cCpros: c" + CHR(243) + "digo do produto
    * Retorna valor num" + CHR(233) + "rico do custo calculado
    * Replica logica de custoproducao do legado (usa CrSigCdNei local)
    *==========================================================================
    FUNCTION CalcularCustoProducao(par_nNops, par_cCpros)
        LOCAL loc_nCusto, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_cMoeda, loc_nMoev, loc_nMoem
        LOCAL loc_nValor, loc_cMoedaItem, loc_lRetrab
        loc_nCusto = 0
        TRY
            *-- Busca dados do produto principal para cambio
            loc_cSQL = "SELECT MoeCusfs, CustoFs, pVens, Moevs FROM SigCdPro " + ;
                       "WHERE CPros = " + EscaparSQL(par_cCpros)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpPro")
            IF loc_nRet < 1
                loc_lSucesso = 0
            ENDIF
            SELECT cursor_4c_CpPro
            GO TOP
            loc_cMoeda = ALLTRIM(NVL(MoeCusfs, ""))
            IF USED("cursor_4c_CpPro")
                USE IN cursor_4c_CpPro
            ENDIF

            loc_nMoev = fBuscarCotacao(loc_cMoeda, THIS.this_dDataMovimento, gnConnHandle)

            *-- Soma custo de materiais do cursor local CrSigCdNei (por opera" + CHR(231) + CHR(227) + "o)
            IF USED("CrSigCdNei")
                SELECT CrSigCdNei
                SCAN FOR Nops = par_nNops
                    IF EMPTY(NVL(Cmats, "")) OR IIF(VARTYPE(Servicos)="L", Servicos, NVL(Servicos,0)=1)
                        LOOP
                    ENDIF
                    loc_cMoedaItem = ALLTRIM(NVL(MoeCusFs, ""))
                    loc_nMoem = fBuscarCotacao(loc_cMoedaItem, THIS.this_dDataMovimento, gnConnHandle)
                    SELECT CrSigCdNei
                    loc_nCusto = loc_nCusto + ;
                                 (NVL(Qtds,0) * NVL(CustoFs,0) * IIF(loc_nMoev=0, 1, loc_nMoem / loc_nMoev))
                ENDSCAN
            ENDIF

            *-- Busca servi" + CHR(231) + "os terceirizados no SQL Server
            loc_cSQL = "SELECT a.cMats, c.Retrabs, a.Qtds, a.Coefs, a.Fators, a.Moedas " + ;
                       "FROM SigCdNei a " + ;
                       "JOIN SigCdSvc b ON a.cMats = b.ccats AND b.Cpros <> ' ' " + ;
                       "JOIN SigCdNec c ON a.EmpDnps = c.EmpDnPs " + ;
                       "WHERE a.Nops = " + FormatarNumeroSQL(par_nNops) + ;
                       " AND a.Servicos = 1 AND a.cMats <> ' '"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpSvc")
            IF loc_nRet >= 1
                SELECT cursor_4c_CpSvc
                SCAN
                    loc_lRetrab    = IIF(VARTYPE(Retrabs)="L", Retrabs, NVL(Retrabs,0)=1)
                    loc_cMoedaItem = ALLTRIM(NVL(cursor_4c_CpSvc.Moedas, ""))
                    IF loc_lRetrab AND NVL(Coefs,0) <> 0
                        loc_nValor = ROUND(NVL(Coefs,0) * NVL(cursor_4c_CpSvc.Qtds,0), 2)
                    ELSE
                        loc_nValor = ROUND(NVL(Fators,0) * NVL(cursor_4c_CpSvc.Qtds,0), 2)
                    ENDIF

                    IF loc_nValor = 0
                        LOCAL loc_cMatsSvc
                        loc_cMatsSvc = ALLTRIM(NVL(cursor_4c_CpSvc.cMats, ""))
                        loc_cSQL = "SELECT p.MoeCusfs, p.CustoFs, p.pVens, p.Moevs, g.pvCompos " + ;
                                   "FROM SigCdPro p LEFT JOIN SigCdGrp g ON p.Cgrus = g.Cgrus " + ;
                                   "WHERE p.CPros = " + EscaparSQL(loc_cMatsSvc)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpProSvc")
                        IF loc_nRet >= 1
                            SELECT cursor_4c_CpProSvc
                            GO TOP
                            IF NVL(pvCompos,0) = 2
                                loc_nValor     = ROUND(NVL(pVens,0) * NVL(cursor_4c_CpSvc.Qtds,0), 2)
                                loc_cMoedaItem = ALLTRIM(NVL(Moevs,""))
                            ELSE
                                loc_nValor     = ROUND(NVL(CustoFs,0) * NVL(cursor_4c_CpSvc.Qtds,0), 2)
                                loc_cMoedaItem = ALLTRIM(NVL(MoeCusfs,""))
                            ENDIF
                            IF USED("cursor_4c_CpProSvc")
                                USE IN cursor_4c_CpProSvc
                            ENDIF
                        ENDIF
                    ENDIF

                    loc_nMoem = fBuscarCotacao(loc_cMoedaItem, THIS.this_dDataMovimento, gnConnHandle)
                    SELECT cursor_4c_CpSvc
                    loc_nCusto = loc_nCusto + (loc_nValor * IIF(loc_nMoev=0, 1, loc_nMoem / loc_nMoev))
                ENDSCAN
                IF USED("cursor_4c_CpSvc")
                    USE IN cursor_4c_CpSvc
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao calcular custo de produ" + CHR(231) + CHR(227) + "o")
            loc_nCusto = 0
        ENDTRY
        RETURN loc_nCusto
    ENDFUNC

    *==========================================================================
    * DistribuirRateio - Distribui peso entre os materiais do envelope
    * par_nAmarra: RECNO() da linha atual de xPesa
    * Popula cursor local CrSigCdNei com os materiais e pesos distribuidos
    * Replica logica de ratpeso do legado
    *==========================================================================
    FUNCTION DistribuirRateio(par_nAmarra)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_nNenv, loc_cMatP, loc_nPesagem, loc_nPesoAnt, loc_nRecnoRateio
        LOCAL loc_nDifPeso, loc_nTotGrava, loc_cSQL, loc_nRet, loc_lTemOuro
        LOCAL loc_cEmps, loc_cDopps, loc_nNumps, loc_cEmpDnPs
        LOCAL loc_nPsFaseAnt, loc_nDivisor
        loc_lSucesso = .F.
        TRY
            IF !USED("crSigCdOpd") OR !USED("xNensiE") OR !USED("TmpNens")
                MsgErro("Cursores de opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o est" + CHR(227) + "o abertos.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Posiciona crSigCdOpd pelo tipo de opera" + CHR(231) + CHR(227) + "o
            SELECT crSigCdOpd
            SET ORDER TO Dopps
            SELECT TmpNens
            GO TOP
            SEEK ALLTRIM(NVL(TmpNens.Dopps, "")) IN crSigCdOpd

            *-- Zera cursores de trabalho para reprocessamento
            IF USED("CrSigCdNei")
                SELECT CrSigCdNei
                ZAP
            ENDIF
            SELECT xNensiE
            ZAP

            *-- Copia xNensI para xNensiE e calcula totais
            IF USED("xNensI")
                SELECT xNensI
                SET ORDER TO
                SELECT xNensiE
                APPEND FROM DBF("xNensI")
                SUM Pesos TO loc_nTotGrava FOR Visivel AND !IIF(VARTYPE(Servicos)="L", Servicos, NVL(Servicos,0)=1)
                SET ORDER TO Rateio
                DELETE ALL FOR EMPTY(NVL(Nops,"")) AND EMPTY(NVL(CMats,"")) AND ;
                              EMPTY(NVL(Cats,"")) AND NVL(Rateio,0) <> 1
                GO TOP
            ENDIF

            *-- Rateio especial para etiquetas tipo 1 ou 3
            IF INLIST(NVL(crSigCdOpd.Etiqs, 0), 1, 3)
                IF USED("xRateio")
                    USE IN xRateio
                ENDIF
                SELECT xPesa
                SELECT Nenvs, MatPs, Peso AS Pesos ;
                FROM xPesa WHERE RECNO() = par_nAmarra ;
                INTO CURSOR xRateio

                SELECT xRateio
                SCAN
                    loc_nNenv        = NVL(Nenvs, 0)
                    loc_cMatP        = ALLTRIM(NVL(MatPs, ""))
                    loc_nPesagem     = NVL(Pesos, 0)
                    loc_nPesoAnt     = 0
                    loc_nRecnoRateio = 0
                    loc_lTemOuro     = .F.

                    SELECT xNensiE
                    SET ORDER TO Nenvs
                    IF SEEK(loc_nNenv)
                        SCAN WHILE NVL(Nenvs,0) = loc_nNenv
                            IF ALLTRIM(NVL(CMats,"")) = loc_cMatP
                                loc_lTemOuro = .T.
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    IF !loc_lTemOuro
                        SELECT TmpNens
                        GO TOP
                        INSERT INTO xNensiE (Nenvs, Nops, Numps, CMats, PsFaseAnt, Pesos, Qtds, Rateio) ;
                        VALUES (loc_nNenv, loc_nNenv, NVL(Numps,0), loc_cMatP, ;
                                loc_nPesagem, loc_nPesagem, loc_nPesagem, 2)
                    ENDIF

                    SELECT xNensiE
                    SCAN FOR NVL(Rateio,0) = 3 AND NVL(NEnvs,0) = loc_nNenv AND ;
                             !IIF(VARTYPE(FlagIncs)="L", FlagIncs, NVL(FlagIncs,0)=1)
                        loc_nPesagem = loc_nPesagem - NVL(Pesos, 0)
                    ENDSCAN

                    SCAN FOR NVL(Rateio,0) = 2 AND NVL(NEnvs,0) = loc_nNenv AND ;
                             !IIF(VARTYPE(FlagIncs)="L", FlagIncs, NVL(FlagIncs,0)=1)
                        IF loc_nRecnoRateio = 0
                            loc_nRecnoRateio = RECNO()
                        ENDIF
                        loc_nPesoAnt = loc_nPesoAnt + NVL(PsFaseAnt, 0)
                    ENDSCAN

                    loc_nDifPeso = loc_nPesagem - loc_nPesoAnt
                    SCAN FOR NVL(Rateio,0) = 2 AND NVL(NEnvs,0) = loc_nNenv AND ;
                             !IIF(VARTYPE(FlagIncs)="L", FlagIncs, NVL(FlagIncs,0)=1)
                        loc_nPsFaseAnt = NVL(PsFaseAnt, 0)
                        loc_nDivisor   = IIF(loc_nPesoAnt = 0, 1, loc_nPesoAnt)
                        REPLACE Pesos WITH ROUND(loc_nPsFaseAnt + (loc_nPsFaseAnt / loc_nDivisor * loc_nDifPeso), 2), ;
                                Qtds  WITH ROUND(loc_nPsFaseAnt + (loc_nPsFaseAnt / loc_nDivisor * loc_nDifPeso), 2)
                        loc_nPesagem = loc_nPesagem - NVL(Pesos, 0)
                    ENDSCAN

                    IF loc_nRecnoRateio <> 0 AND loc_nPesagem <> 0
                        GO loc_nRecnoRateio
                        REPLACE Pesos WITH NVL(Pesos,0) + loc_nPesagem, ;
                                Qtds  WITH NVL(Qtds,0)  + loc_nPesagem
                    ENDIF

                    SELECT xRateio
                ENDSCAN
                IF USED("xRateio")
                    USE IN xRateio
                ENDIF
            ENDIF

            *-- Grava xNensiE no cursor local CrSigCdNei com dados do SQL Server
            SELECT TmpNens
            GO TOP
            loc_cEmps    = ALLTRIM(NVL(TmpNens.Emps,  ""))
            loc_cDopps   = ALLTRIM(NVL(TmpNens.Dopps, ""))
            loc_nNumps   = NVL(TmpNens.Numps, 0)
            loc_cEmpDnPs = loc_cEmps + loc_cDopps + STR(loc_nNumps, 10)

            SELECT xNensiE
            SET ORDER TO Gravar
            SCAN FOR NVL(Qtds,0) <> 0 OR NVL(Pesos,0) <> 0 OR ;
                     (USED("crSigCdOpd") AND NVL(crSigCdOpd.ReiNops, 0) = 1)

                *-- Busca custo e flags do produto/grupo para este material
                loc_cSQL = "SELECT g.CEstoqs, g.pvCompos, p.Varias, " + ;
                           "p.CGrus, p.CustoFs, p.MoeCusFs, p.pVens, p.Moevs " + ;
                           "FROM SigCdPro p LEFT JOIN SigCdGrp g ON p.CGrus = g.CGrus " + ;
                           "WHERE p.Cpros = " + EscaparSQL(ALLTRIM(NVL(xNensiE.CMats,"")))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PgRateio")

                IF USED("CrSigCdNei")
                    INSERT INTO CrSigCdNei ;
                    (Emps, Dopps, Numps, Nops, Nenvs, CMats, CDescs, CUnis, Tpops, Cats, Obss, ;
                     AQtds, Qtds, Pesos, FlagIncs, Fators, Moedas, Servicos, GrupoFins, ;
                     nLotes, PesoFixs, cIdChaves, EmpDNPs, Peso2s) ;
                    VALUES ;
                    (loc_cEmps, loc_cDopps, loc_nNumps, ;
                     NVL(xNensiE.NOps,0), NVL(xNensiE.Nenvs,0), ;
                     ALLTRIM(NVL(xNensiE.CMats,"")),   ALLTRIM(NVL(xNensiE.CDescs,"")), ;
                     ALLTRIM(NVL(xNensiE.CUnis,"")),   ALLTRIM(NVL(xNensiE.Tpops,"")), ;
                     ALLTRIM(NVL(xNensiE.Cats,"")),    ALLTRIM(NVL(xNensiE.Obss,"")), ;
                     NVL(xNensiE.AQtds,0), NVL(xNensiE.Qtds,0), NVL(xNensiE.Pesos,0), ;
                     IIF(VARTYPE(xNensiE.FlagIncs)="L", xNensiE.FlagIncs, NVL(xNensiE.FlagIncs,0)=1), ;
                     NVL(xNensiE.Fators,0), ALLTRIM(NVL(xNensiE.Moedas,"")), ;
                     IIF(VARTYPE(xNensiE.Servicos)="L", xNensiE.Servicos, NVL(xNensiE.Servicos,0)=1), ;
                     ALLTRIM(NVL(xNensiE.GrupoFins,"")), ;
                     NVL(xNensiE.nLotes,0), NVL(xNensiE.PesoFixs,0), ;
                     ALLTRIM(fUniqueIds()), loc_cEmpDnPs, NVL(xNensiE.Peso2s,0))

                    *-- Atualiza custo/moeda e flag PesoFixs baseado no grupo do produto
                    IF loc_nRet >= 1 AND USED("cursor_4c_PgRateio")
                        SELECT cursor_4c_PgRateio
                        GO TOP
                        SELECT CrSigCdNei
                        GO BOTTOM
                        IF NVL(cursor_4c_PgRateio.pvCompos, 0) = 2
                            REPLACE CustoFs  WITH NVL(cursor_4c_PgRateio.pVens,    0), ;
                                    MoeCusfs WITH ALLTRIM(NVL(cursor_4c_PgRateio.Moevs,""))
                        ELSE
                            REPLACE CustoFs  WITH NVL(cursor_4c_PgRateio.CustoFs,  0), ;
                                    MoeCusFs WITH ALLTRIM(NVL(cursor_4c_PgRateio.MoeCusFs,""))
                        ENDIF
                        IF USED("crSigCdOpd") AND NVL(crSigCdOpd.PesoFixs,0) = 1 AND ;
                           NVL(cursor_4c_PgRateio.Varias,0) = 1
                            REPLACE PesoFixs WITH 1
                        ENDIF
                        IF USED("cursor_4c_PgRateio")
                            USE IN cursor_4c_PgRateio
                        ENDIF
                    ENDIF
                ENDIF
                SELECT xNensiE
            ENDSCAN
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao distribuir rateio de peso")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GravarComposicaoEspecial - Grava composi" + CHR(231) + CHR(227) + "o especial no SQL Server (SigPrCpo)
    * par_cAliasCursor: cursor local com dados (ex: "CsSigPrCpo")
    *   - Cursor deve ter campos do SigPrCpo (ideal: construido via SELECT * FROM SigPrCpo)
    *   - Campos m" + CHR(237) + "nimos: cpros, mats, qtds, pesos, dcompos, unicompos, cunips,
    *     cgrus, pcompos, moeds, dtmovs, tpalts, cidchaves, etiqs
    * Replica: Thisform.Podatamgr.update('CsSigPrCpo') do legado
    * Retorna .T. se sucesso, .F. se falha
    *==========================================================================
    FUNCTION GravarComposicaoEspecial(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_cCpros, loc_cIdChaves, loc_nTpAlts
        loc_lSucesso = .F.
        TRY
            IF !USED(par_cAliasCursor)
                MsgErro("Cursor " + par_cAliasCursor + " n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)
            GO TOP
            IF EOF()
                loc_lSucesso = .T.
            ENDIF

            *-- Remove composi" + CHR(231) + CHR(227) + "o anterior do produto no SQL Server
            loc_cCpros = ALLTRIM(NVL(cpros, ""))
            IF !EMPTY(loc_cCpros)
                loc_cSQL = "DELETE FROM SigPrCpo WHERE cpros = " + EscaparSQL(loc_cCpros)
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

            *-- Insere cada linha v" + CHR(225) + "lida (TpAlts > 0)
            SELECT (par_cAliasCursor)
            GO TOP
            DO WHILE !EOF()
                loc_nTpAlts = NVL(TpAlts, 0)
                IF loc_nTpAlts > 0
                    loc_cIdChaves = ALLTRIM(NVL(cIdChaves, ""))
                    IF EMPTY(loc_cIdChaves)
                        loc_cIdChaves = ALLTRIM(fUniqueIds())
                    ENDIF
                    loc_cSQL = "INSERT INTO SigPrCpo (" + ;
                               "cidchaves, cpros, mats, cgrus, cats, dcompos, dscgrp, etiqs, " + ;
                               "grupos, moeds, obscompos, ordems, pcompos, qtds, qtscons, " + ;
                               "unicompos, compos, ordcompos, qtdcvs, vlrcvs, dtmovs, cunips, " + ;
                               "markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, " + ;
                               "obsofs, datatrans, PedraPrincipal) " + ;
                               "VALUES (" + ;
                               EscaparSQL(loc_cIdChaves)                          + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(cpros,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(mats,      "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(cgrus,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(cats,      "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(dcompos,   "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(dscgrp,    "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(etiqs,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(grupos,    "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(moeds,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(obscompos, "")))            + ", " + ;
                               FormatarNumeroSQL(NVL(ordems,      0))             + ", " + ;
                               FormatarNumeroSQL(NVL(pcompos,     0))             + ", " + ;
                               FormatarNumeroSQL(NVL(qtds,        0))             + ", " + ;
                               FormatarNumeroSQL(NVL(qtscons,     0))             + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(unicompos, "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(compos,    "")))            + ", " + ;
                               FormatarNumeroSQL(NVL(ordcompos,   0))             + ", " + ;
                               FormatarNumeroSQL(NVL(qtdcvs,      0))             + ", " + ;
                               FormatarNumeroSQL(NVL(vlrcvs,      0))             + ", " + ;
                               "GETDATE(), "                                               + ;
                               EscaparSQL(ALLTRIM(NVL(cunips,    "")))            + ", " + ;
                               FormatarNumeroSQL(NVL(markcvs,     0))             + ", " + ;
                               FormatarNumeroSQL(NVL(pesos,       0))             + ", " + ;
                               FormatarNumeroSQL(NVL(totas,       0))             + ", " + ;
                               FormatarNumeroSQL(NVL(tpalts,      0))             + ", " + ;
                               FormatarNumeroSQL(NVL(vlrpvs,      0))             + ", " + ;
                               FormatarNumeroSQL(NVL(ordts,       0))             + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(tipos,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(matriz,    "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(obsofs,    "")))            + ", " + ;
                               "GETDATE(), "                                               + ;
                               FormatarNumeroSQL(NVL(PedraPrincipal, 0))          + ")"
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nRet < 1
                        MsgErro("Falha ao gravar composi" + CHR(231) + CHR(227) + "o especial. " + ;
                                "Produto: " + ALLTRIM(NVL(cpros,"")), "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
                SELECT (par_cAliasCursor)
                SKIP
            ENDDO
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar composi" + CHR(231) + CHR(227) + "o especial")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GravarSigCdNei - Persiste cursor local CrSigCdNei no SQL Server (SigCdNei)
    * Equivalente ao poDataMgr.update('CrSigCdNei') do legado
    * Chamado pelo form em BtnProcessarClick ap" + CHR(243) + "s todas as pe" + CHR(231) + "as pesadas
    * Retorna .T. se sucesso, .F. se falha
    *==========================================================================
    FUNCTION GravarSigCdNei()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_lFlagIncs, loc_lServicos
        loc_lSucesso = .F.
        TRY
            IF !USED("CrSigCdNei") OR RECCOUNT("CrSigCdNei") = 0
                loc_lSucesso = .T.
            ENDIF
            SELECT CrSigCdNei
            GO TOP
            DO WHILE !EOF()
                loc_lFlagIncs = IIF(VARTYPE(FlagIncs)="L", FlagIncs, NVL(FlagIncs,0)=1)
                loc_lServicos = IIF(VARTYPE(Servicos)="L", Servicos, NVL(Servicos,0)=1)

                loc_cSQL = "INSERT INTO SigCdNei (" + ;
                           "emps, dopps, numps, nops, nenvs, cmats, cdescs, cunis, tpops, cats, " + ;
                           "obss, aqtds, qtds, pesos, flagincs, fators, moedas, servicos, " + ;
                           "grupofins, nlotes, pesofixs, cidchaves, empdnps, peso2s, " + ;
                           "custofs, moecusfs) " + ;
                           "VALUES (" + ;
                           EscaparSQL(ALLTRIM(NVL(Emps,      ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Dopps,     ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(Numps,       0))  + ", " + ;
                           FormatarNumeroSQL(NVL(Nops,        0))  + ", " + ;
                           FormatarNumeroSQL(NVL(Nenvs,       0))  + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(CMats,     ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(CDescs,    ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(CUnis,     ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Tpops,     ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Cats,      ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Obss,      ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(AQtds,       0))  + ", " + ;
                           FormatarNumeroSQL(NVL(Qtds,        0))  + ", " + ;
                           FormatarNumeroSQL(NVL(Pesos,       0))  + ", " + ;
                           IIF(loc_lFlagIncs, "1", "0")            + ", " + ;
                           FormatarNumeroSQL(NVL(Fators,      0))  + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Moedas,    ""))) + ", " + ;
                           IIF(loc_lServicos, "1", "0")            + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(GrupoFins, ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(nLotes,      0))  + ", " + ;
                           FormatarNumeroSQL(NVL(PesoFixs,    0))  + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(cIdChaves, ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(EmpDNPs,   ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(Peso2s,      0))  + ", " + ;
                           FormatarNumeroSQL(NVL(CustoFs,     0))  + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(MoeCusFs,  ""))) + ")"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet < 1
                    MsgErro("Falha ao gravar SigCdNei (Nenvs=" + ;
                            TRANSFORM(NVL(Nenvs,0)) + ")", "Erro")
                    loc_lSucesso = .F.
                ENDIF
                SELECT CrSigCdNei
                SKIP
            ENDDO
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar SigCdNei")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

