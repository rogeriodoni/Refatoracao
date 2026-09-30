*==============================================================================
* InstantiateCheckSigPrEtqF8.prg - valida a Fase 8 de FormSigPrEtq (task609)
*
* Prova, MEDINDO no VFP9 (nao por leitura de codigo):
*   1. o form INSTANCIA e reproduz a geometria do legado (833x700);
*   2. BOParaForm rodou no Init e levou os parametros aos controles
*      (Opcao_imp / spinners / separadora / checkboxes);
*   3. CriarCursorImpressorasWindows montou crImpreV com as TRES colunas
*      (IDupla/Impres/ImpresS) e alimentou this_nTotalImpressoras;
*   4. CarregarLista deixou a grade com a linha em branco obrigatoria;
*   5. HabilitarCampos(.F.) tranca a captura mas NUNCA o Encerrar, e
*      HabilitarCampos(.T.) respeita o teto de permissao (fChecaAcesso):
*      com this_lAcVertical = .F. o spinner continua bloqueado;
*   6. FormParaBO transfere a tela para o BO, com a chave posicional
*      EmpDopNums de 29 caracteres (PADR nas partes - CLAUDE.md #42);
*   7. LimparCampos faz o reset pos-impressao (Lista de Precos limpa,
*      grade com uma linha) sem apagar Empresa/Operacao/Codigo;
*   8. CarregarLista e BtnSairClick sao chamaveis de FORA (PUBLIC).
*
* NAO chama ConfigurarAmbiente(): ela nao retorna nesta maquina.
*
* gnConnHandle = -1: os guards de conexao dos metodos do BO devolvem .F. limpo. Com
* handle FALSO POSITIVO (1) o SQLEXEC DISPARA EXCECAO. gcTipoUsuario recebe "i"+Usuar de proposito:
* fChecaAcesso curto-circuita nesse caso e devolve .T. sem abrir conexao
* propria (nesta maquina nao ha rota para 192.168.200.10). O teto de permissao
* eh exercitado no passo 6, atribuindo a property direto.
*
* Cada passo eh GRAVADO EM DISCO assim que termina (LogP -> STRTOFILE
* ADDITIVE): se o processo travar, o log mostra onde parou.
*
* ATENCAO ao rodar: apagar o .FXP antes - vfp9.exe roda o .FXP velho e o
* resultado vira diagnostico falso (CLAUDE.md regra #29).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogF8, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigpretqf8.txt"
gc_4c_LogF8            = "C:\4c\automation\instantiate_sigpretqf8_result.txt"
gnConnHandle           = -1

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogF8)
    DELETE FILE (gc_4c_LogF8)
ENDIF

LOCAL loc_oForm, loc_oErro, loc_oImp, loc_cChave
LogP("FASE8 task609 - inicio " + TTOC(DATETIME()))

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    LogP("0a config.prg OK")

    PUBLIC gcTipoUsuario
    gcTipoUsuario = "i" + UPPER(ALLTRIM(gc_4c_UsuarioLogado))

    SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
                 gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigPrEtqBO.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigPrEtq.prg") ADDITIVE
    LogP("0b dependencias carregadas")
CATCH TO loc_oErro
    LogP("0 SETUP FALHOU: " + loc_oErro.Message)
ENDTRY

TRY
    loc_oForm = CREATEOBJECT("ProbeSigPrEtqF8")
    LogP("1 INSTANCIA VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm)="O", " Caption=[" + loc_oForm.Caption + "]" + ;
        " W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height), ""))
CATCH TO loc_oErro
    LogP("1 INSTANCIA FALHOU: " + loc_oErro.Message + " LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"

    TRY
        loc_oImp = loc_oForm.cnt_4c__Impressora
        LogP("2 BOParaForm -> OpcaoImp=" + TRANSFORM(loc_oImp.obj_4c_Opcao_imp.Value) + ;
            " AjVerts=" + TRANSFORM(loc_oImp.obj_4c_Spn_AjVerts.Value) + ;
            " AjHorzs=" + TRANSFORM(loc_oImp.obj_4c_Spn_AjHorzs.Value) + ;
            " AjDenss=" + TRANSFORM(loc_oImp.obj_4c_Spn_AjDenss.Value) + ;
            " AjVelos=" + TRANSFORM(loc_oImp.obj_4c_Spn_AjVelos.Value) + ;
            " Separador=" + TRANSFORM(loc_oForm.obj_4c_Opt_separador.Value) + ;
            " ChkLista=" + TRANSFORM(loc_oForm.chk_4c_ChkLista.Value) + ;
            " ChkOper=" + TRANSFORM(loc_oForm.chk_4c_ChkOperacoes.Value))
    CATCH TO loc_oErro
        LogP("2 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        LogP("3 crImpreV USED=" + TRANSFORM(USED("crImpreV")) + ;
            " RECCOUNT=" + TRANSFORM(IIF(USED("crImpreV"), RECCOUNT("crImpreV"), -1)) + ;
            " colunas=[" + IIF(USED("crImpreV"), ;
                FIELD(1, "crImpreV") + "/" + FIELD(2, "crImpreV") + "/" + FIELD(3, "crImpreV"), "") + "]" + ;
            " this_nTotalImpressoras=" + TRANSFORM(loc_oForm.this_nTotalImpressoras) + ;
            " this_nTotalTipos=" + TRANSFORM(loc_oForm.this_nTotalTipos) + ;
            " crImpre_fechado=" + TRANSFORM(!USED("crImpre")) + ;
            " ImpPar_fechado=" + TRANSFORM(!USED("cursor_4c_ImpPar")))
    CATCH TO loc_oErro
        LogP("3 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        LogP("4 CarregarLista(Init) -> cursor RECCOUNT=" + ;
            TRANSFORM(IIF(USED("cursor_4c_Dados"), RECCOUNT("cursor_4c_Dados"), -1)) + ;
            " RecordSource=[" + loc_oForm.grd_4c_Dados.RecordSource + "]" + ;
            " ColumnCount=" + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + ;
            " Col1.Width=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Width))
    CATCH TO loc_oErro
        LogP("4 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oForm.HabilitarCampos(.F.)
        LogP("5 HabilitarCampos(.F.) -> Lpreco=" + TRANSFORM(loc_oForm.txt_4c_Lpreco.Enabled) + ;
            " Grade=" + TRANSFORM(loc_oForm.grd_4c_Dados.Enabled) + ;
            " Carregar=" + TRANSFORM(loc_oForm.cmd_4c_BtnCarregar.Enabled) + ;
            " Imprimir=" + TRANSFORM(loc_oForm.obj_4c_BTNREPORT.Buttons(1).Enabled) + ;
            " Encerrar=" + TRANSFORM(loc_oForm.obj_4c_BTNREPORT.Buttons(2).Enabled) + ;
            " (Encerrar esperado .T.)" + ;
            " Form.Enabled=" + TRANSFORM(loc_oForm.Enabled) + " (esperado .T.)")
    CATCH TO loc_oErro
        LogP("5 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oForm.this_lAcVertical = .F.
        loc_oForm.this_lAcTipo     = .F.
        loc_oForm.HabilitarCampos(.T.)
        LogP("6 Teto de permissao com HabilitarCampos(.T.) -> " + ;
            "AjVerts.Enabled=" + TRANSFORM(loc_oForm.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Enabled) + ;
            " (esperado .F.)" + ;
            " OptTipo.Enabled=" + TRANSFORM(loc_oForm.obj_4c_Opt_Tipo.Enabled) + " (esperado .F.)" + ;
            " AjHorzs.Enabled=" + TRANSFORM(loc_oForm.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Enabled) + ;
            " (esperado .T.)" + ;
            " Lpreco.Enabled=" + TRANSFORM(loc_oForm.txt_4c_Lpreco.Enabled) + " (esperado .T.)")
        loc_oForm.this_lAcVertical = .T.
        loc_oForm.this_lAcTipo     = .T.
    CATCH TO loc_oErro
        LogP("6 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oForm.txt_4c_Lpreco.Value  = "LP01"
        loc_oForm.txt_4c_LPreco2.Value = "LP02"
        loc_oForm.txt_4c_Emps.Value    = "001"
        loc_oForm.txt_4c_Dopes.Value   = "MALOTE"
        loc_oForm.txt_4c_Numes.Value   = 3
        loc_oForm.obj_4c_Opt_Preco.Value = 2
        loc_oForm.ProbeFormParaBO()

        loc_cChave = loc_oForm.this_oBusinessObject.this_cEmpDopNums
        LogP("7 FormParaBO -> LP1=[" + loc_oForm.this_oBusinessObject.this_cLPreco + "]" + ;
            " LP2=[" + loc_oForm.this_oBusinessObject.this_cLPreco2 + "]" + ;
            " Emps=[" + loc_oForm.this_oBusinessObject.this_cEmps + "]" + ;
            " Dopes=[" + loc_oForm.this_oBusinessObject.this_cDopes + "]" + ;
            " Numes=[" + loc_oForm.this_oBusinessObject.this_cNumes + "]" + ;
            " Preco=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nPreco) + ;
            " ChaveLEN=" + TRANSFORM(LEN(loc_cChave)) + " (esperado 29)" + ;
            " Chave=[" + loc_cChave + "]")
    CATCH TO loc_oErro
        LogP("7 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oForm.ProbeLimparCampos()
        LogP("8 LimparCampos -> Lpreco=[" + loc_oForm.txt_4c_Lpreco.Value + "] (esperado vazio)" + ;
            " LPreco2=[" + loc_oForm.txt_4c_LPreco2.Value + "] (PRESERVADO)" + ;
            " Emps=[" + loc_oForm.txt_4c_Emps.Value + "] (PRESERVADO)" + ;
            " grade RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Dados")) + " (esperado 1)")
    CATCH TO loc_oErro
        LogP("8 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        LogP("9 CarregarLista de FORA (PUBLIC) -> " + TRANSFORM(loc_oForm.CarregarLista()))
    CATCH TO loc_oErro
        LogP("9 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        *-- O handler da acao principal eh bindado por BINDEVENT, logo tem de
        *-- ser PUBLIC (CLAUDE.md #3). PEMSTATUS(...,5) devolve .T. ate para
        *-- PROTECTED, entao a prova eh o ALCANCE real de fora da classe.
        LogP("11 BtnProcessarImpressaoClick existe: " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "BtnProcessarImpressaoClick", 5)) + ;
            " / BtnImprimeClick (nome antigo) existe: " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "BtnImprimeClick", 5)))
        *-- Chamavel de FORA sem grade carregada: sai pelo guard de cursor
        *-- vazio, sem excecao. Prova escopo PUBLIC sem disparar impressao.
        loc_oForm.BtnProcessarImpressaoClick()
        LogP("11 BtnProcessarImpressaoClick chamavel de FORA (PUBLIC): OK")
    CATCH TO loc_oErro
        LogP("11 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oForm.BtnSairClick()
        LogP("10 BtnSairClick de FORA: OK")
    CATCH TO loc_oErro
        LogP("10 FALHOU: " + loc_oErro.Message)
    ENDTRY
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    LogP("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    LogP("DIALOGOS: nenhum")
ENDIF
LogP("FIM " + TTOC(DATETIME()))
QUIT

PROCEDURE LogP(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogF8, 1)
ENDPROC

DEFINE CLASS ProbeSigPrEtqF8 AS FormSigPrEtq
    *-- FormParaBO/BOParaForm/LimparCampos sao PROTECTED (hooks de FormBase -
    *-- VFP9 nao deixa a subclasse alargar o escopo): exercitar de dentro.
    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

    PROCEDURE ProbeLimparCampos()
        THIS.LimparCampos()
        RETURN .T.
    ENDPROC
ENDDEFINE
