*==============================================================================
* test_fase4_sigprnfe.prg - Instancia Formsigprnfe SEM carregar o framework legado
* (o SET CLASSLIB dos VCX Fortyus trava num modal nesta maquina: o
* TestFormWrapper completo nao passa da ETAPA 1 nem em forms NAO alterados).
* Prova o caminho do Init e os funis de grade/botoes.
* Grava o resultado a CADA passo, para o arquivo sobreviver a um travamento.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

PUBLIC gc_4c_CaminhoBase, gc_4c_CaminhoClasses, gc_4c_CaminhoUtils
PUBLIC gc_4c_CaminhoForms, gc_4c_CaminhoIcones, gc_4c_CaminhoFramework
PUBLIC gc_4c_CaminhoReports, gc_4c_UsuarioLogado, gc_4c_LogoRelatorio
PUBLIC gb_4c_ValidandoUI, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
PUBLIC go_4c_Sistema, gnConnHandle, _EMPR, goSistema, Usuar, Comando
PUBLIC gp_cSaida

gc_4c_CaminhoBase      = "C:\4c\projeto\app\start\"
gc_4c_CaminhoClasses   = "C:\4c\projeto\app\classes\"
gc_4c_CaminhoUtils     = "C:\4c\projeto\app\utils\"
gc_4c_CaminhoForms     = "C:\4c\projeto\app\forms\"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gc_4c_UsuarioLogado    = "SISTEMA"
gc_4c_LogoRelatorio    = ""
gnConnHandle           = -1
gb_4c_ValidandoUI      = .F.
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\test_fase4_sigprnfe_dialogs.txt"
gp_cSaida              = "C:\4c\automation\vfp_helpers\test_fase4_sigprnfe_resultado.txt"

go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "EMPRESA TESTE LTDA")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "01")
ADDPROPERTY(go_4c_Sistema, "cCNPJ", "00.000.000/0001-00")
ADDPROPERTY(go_4c_Sistema, "BuscaP", .F.)
ADDPROPERTY(go_4c_Sistema, "BuscaNome", "RClis")
ADDPROPERTY(go_4c_Sistema, "Matrizes", .F.)
ADDPROPERTY(go_4c_Sistema, "Transitorio", "")
ADDPROPERTY(go_4c_Sistema, "ObjectConn", .NULL.)
goSistema = go_4c_Sistema
_EMPR     = go_4c_Sistema.cCodEmpresa
Usuar     = "SISTEMA"
Comando   = ""

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigprnfeBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms   + "operacionais\Formsigprnfe.prg") ADDITIVE

STRTOFILE("=== PROBE FASE 4 ===" + CHR(13) + CHR(10), gp_cSaida)

LOCAL loc_oForm, loc_oErro, loc_i, loc_oGrd, loc_oBO
LOCAL ARRAY loc_aMet[8]

TRY
    Anota("dependencias carregadas")

    loc_oForm = CREATEOBJECT("Formsigprnfe")
    Anota("CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm))

    IF VARTYPE(loc_oForm) = "O"
        Anota("Caption=[" + loc_oForm.Caption + "] ControlCount=" + ;
              TRANSFORM(loc_oForm.ControlCount))

        loc_oGrd = loc_oForm.cnt_4c_Grade.grd_4c_Dados
        loc_oBO  = loc_oForm.this_oBusinessObject

        Anota("cursor_4c_Operacoes USED=" + TRANSFORM(USED("cursor_4c_Operacoes")) + ;
              " Grid.ColumnCount=" + TRANSFORM(loc_oGrd.ColumnCount) + ;
              " RecordSource=[" + loc_oGrd.RecordSource + "]")
        Anota("Col1.CurrentControl=[" + loc_oGrd.Column1.CurrentControl + ;
              "] Col1.Sparse=" + TRANSFORM(loc_oGrd.Column1.Sparse))
        Anota("grdInu.Col6.CurrentControl=[" + ;
              loc_oForm.cnt_4c_Inu.grd_4c_Inu.Column6.CurrentControl + "]")
        Anota("cnt_4c_Inu.Visible(esp .F.)=" + TRANSFORM(loc_oForm.cnt_4c_Inu.Visible))

        Anota("--- estado inicial dos botoes (AjustarBotoesPorModo(.F.)) ---")
        Anota("  Selecionar(esp .T.)=" + TRANSFORM(loc_oForm.cmd_4c_CmdSelecionar.Enabled) + ;
              "  Limpar(esp .F.)=" + TRANSFORM(loc_oForm.obj_4c_CmdBtnForm.Buttons(1).Enabled) + ;
              "  Processar(esp .F.)=" + TRANSFORM(loc_oForm.obj_4c_CmdBtnForm.Buttons(2).Enabled) + ;
              "  Encerrar(esp .T.)=" + TRANSFORM(loc_oForm.obj_4c_CmdBtnForm.Buttons(3).Enabled))
        Anota("  MarcaTudo(esp .F.)=" + TRANSFORM(loc_oForm.obj_4c_CmdBtnGrade.Buttons(1).Enabled) + ;
              "  Desmarcar(esp .F.)=" + TRANSFORM(loc_oForm.obj_4c_CmdBtnGrade.Buttons(2).Enabled) + ;
              "  Documento(esp .F.)=" + TRANSFORM(loc_oForm.obj_4c_CmdBtnGrade.Buttons(3).Enabled))

        Anota("--- filtros iniciais (AplicarFiltrosIniciais) ---")
        Anota("  Emps=[" + loc_oBO.this_cEmps + "] Processados=" + ;
              TRANSFORM(loc_oBO.this_nProcessados) + " Tipos=" + ;
              TRANSFORM(loc_oBO.this_nTipos) + " Acao=" + TRANSFORM(loc_oBO.this_nAcao))

        Anota("--- escopo dos metodos chamados de FORA (protected deve ser .F.) ---")
        loc_aMet[1] = "CarregarLista"
        loc_aMet[2] = "AtualizarGrade"
        loc_aMet[3] = "LimparSelecao"
        loc_aMet[4] = "AjustarBotoesPorModo"
        loc_aMet[5] = "ObterFiltrosSelecao"
        loc_aMet[6] = "MarcarTodasOperacoes"
        loc_aMet[7] = "DesmarcarTodasOperacoes"
        loc_aMet[8] = "AlternarMarcacaoLinha"
        FOR loc_i = 1 TO ALEN(loc_aMet)
            Anota("  " + PADR(loc_aMet[loc_i], 24) + " existe=" + ;
                  TRANSFORM(PEMSTATUS(loc_oForm, loc_aMet[loc_i], 5)) + ;
                  " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_aMet[loc_i], 2)))
        ENDFOR
        Anota("  BO.BuscarOperacoes       existe=" + ;
              TRANSFORM(PEMSTATUS(loc_oBO, "BuscarOperacoes", 5)) + ;
              " protected=" + TRANSFORM(PEMSTATUS(loc_oBO, "BuscarOperacoes", 2)))

        Anota("--- funis de marcacao (cursor povoado a mao) ---")
        *-- O form tem DataSession = 2: os cursores dele vivem na sessao
        *-- PRIVADA, invisivel aqui. Sem este SET DATASESSION o INSERT abre o
        *-- dialogo "localizar tabela" do VFP e o processo TRAVA.
        SET DATASESSION TO loc_oForm.DataSessionId
        Anota("  datasession do form=" + TRANSFORM(loc_oForm.DataSessionId) + ;
              " cursor USED=" + TRANSFORM(USED("cursor_4c_Operacoes")))
        INSERT INTO cursor_4c_Operacoes (SelImp, Emps, Dopes, Numes, Notas) ;
            VALUES (.F., "01 ", "VENDA", 1, "000001")
        INSERT INTO cursor_4c_Operacoes (SelImp, Emps, Dopes, Numes, Notas) ;
            VALUES (.F., "01 ", "VENDA", 2, "000002")
        Anota("  RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Operacoes")))

        loc_oForm.MarcarTodasOperacoes()
        SELECT cursor_4c_Operacoes
        COUNT FOR SelImp TO loc_i
        Anota("  MarcarTodas    -> marcadas(esp 2)=" + TRANSFORM(loc_i))

        loc_oForm.DesmarcarTodasOperacoes()
        SELECT cursor_4c_Operacoes
        COUNT FOR SelImp TO loc_i
        Anota("  DesmarcarTodas -> marcadas(esp 0)=" + TRANSFORM(loc_i))

        GO TOP IN cursor_4c_Operacoes
        loc_oForm.AlternarMarcacaoLinha()
        SELECT cursor_4c_Operacoes
        COUNT FOR SelImp TO loc_i
        Anota("  AlternarLinha  -> marcadas(esp 1)=" + TRANSFORM(loc_i))

        Anota("--- caminho de volta (regra #40) ---")
        loc_oForm.AjustarBotoesPorModo(.T.)
        Anota("  apos Ajustar(.T.):   Limpar(esp .T.)=" + ;
              TRANSFORM(loc_oForm.obj_4c_CmdBtnForm.Buttons(1).Enabled) + ;
              " Selecionar(esp .F.)=" + TRANSFORM(loc_oForm.cmd_4c_CmdSelecionar.Enabled))
        loc_oForm.LimparSelecao()
        Anota("  apos LimparSelecao: Limpar(esp .F.)=" + ;
              TRANSFORM(loc_oForm.obj_4c_CmdBtnForm.Buttons(1).Enabled) + ;
              " Selecionar(esp .T.)=" + TRANSFORM(loc_oForm.cmd_4c_CmdSelecionar.Enabled) + ;
              " RECCOUNT(esp 0)=" + TRANSFORM(RECCOUNT("cursor_4c_Operacoes")))

        Anota("--- validacao recusa carga sem data ---")
        Anota("  CarregarLista() (esp .F.)=" + TRANSFORM(loc_oForm.CarregarLista()))

        SET DATASESSION TO 1
        loc_oForm.Release()
        Anota("Release OK")
    ENDIF
CATCH TO loc_oErro
    Anota("*** EXCECAO: " + loc_oErro.Message + " | LN=" + ;
          TRANSFORM(loc_oErro.LineNo) + " | PROC=" + loc_oErro.Procedure)
ENDTRY

Anota("=== FIM ===")
QUIT

PROCEDURE Anota(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gp_cSaida, 1)
ENDPROC
