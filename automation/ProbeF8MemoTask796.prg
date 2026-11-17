*==============================================================================
* ProbeF8MemoTask796.prg
*
* Fase 8 de FormSigOpRob (task796). Mede DUAS coisas na classe REAL:
*
*  (1) COLUNA MEMO - o unico chamador legado (SIGCDPGR, task499) cria TmpConta
*      com "HistPgs M, Obsd M" e passa essas colunas ao dialogo. O Init do BO
*      guarda o texto sob IF VARTYPE(par_cTexto) = "C". A suspeita era de que
*      MEMO devolvesse "M", a guarda recusasse e o dialogo abrisse VAZIO.
*      Resultado medido em 2026-11-17: VARTYPE devolve "C" - NAO ha defeito.
*
*  (2) O hook de transferencia do Business Object para a tela, entregue na
*      Fase 8: as QUATRO linhas de interface do Init legado (Caption do Form,
*      Caption dos DOIS rotulos da faixa e Value do EditBox) tem de chegar aos
*      quatro destinos a partir de um ponto unico.
*
* Uso: powershell -ExecutionPolicy Bypass -File automation\RodarProbeF8Task796.ps1
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gc_4c_Out
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\tmp796\f8\vfp_error_f8.txt"
gc_4c_Out              = "C:\4c\automation\probe_f8_memo_task796.txt"
LOCAL loc_oErro, loc_oPai, loc_oDlg, loc_oEdt, loc_cEsperado
STRTOFILE("INICIO probe F8 (MEMO + hook de transferencia) - classe REAL" + CHR(13) + CHR(10), gc_4c_Out)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpRobBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms   + "operacionais\FormSigOpRob.prg") ADDITIVE

    *-- cursor IDENTICO ao do chamador legado (SIGCDPGR:11228)
    CREATE CURSOR TmpConta (Grupos c(10), Contas c(10), HistPgs M, Obsd M)
    APPEND BLANK
    REPLACE Obsd    WITH "LINHA 1 DO HISTORICO" + CHR(13) + CHR(10) + "LINHA 2"
    REPLACE HistPgs WITH "DADOS DE PAGAMENTO 123"

    DO Lg WITH "(1) VARTYPE(TmpConta.Obsd)    = [" + VARTYPE(TmpConta.Obsd) + "]  (esperado C)"
    DO Lg WITH "(1) VARTYPE(TmpConta.HistPgs) = [" + VARTYPE(TmpConta.HistPgs) + "]  (esperado C)"
    DO Lg WITH "(1) LEN(TmpConta.Obsd)        = " + TRANSFORM(LEN(TmpConta.Obsd))

    *-- comportamento LEGADO, para comparar: Edit1.Value = <memo> direto
    loc_oEdt = CREATEOBJECT("EditBox")
    loc_oEdt.Value = TmpConta.Obsd
    DO Lg WITH "(1) LEGADO Edit.Value = memo -> LEN=" + TRANSFORM(LEN(loc_oEdt.Value))

    *-- (2) classe REAL, com o MESMO argumento dos quatro call sites legado
    loc_oPai = CREATEOBJECT("FrmPaiF8")
    loc_oDlg = CREATEOBJECT("FormSigOpRob", "Historico", TmpConta.Obsd, loc_oPai)
    DO Lg WITH "(2) dlg VARTYPE=" + VARTYPE(loc_oDlg)
    IF VARTYPE(loc_oDlg) = "O"
        loc_cEsperado = ALLTRIM(TmpConta.Obsd)
        DO Lg WITH "(2) Form.Caption        = [" + loc_oDlg.Caption + "]"
        DO Lg WITH "(2) lblSombra.Caption   = [" + loc_oDlg.cnt_4c_Sombra.lbl_4c_LblSombra.Caption + "]"
        DO Lg WITH "(2) lblTitulo.Caption   = [" + loc_oDlg.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption + "]"
        DO Lg WITH "(2) Edit1.Value LEN=" + TRANSFORM(LEN(loc_oDlg.obj_4c_Edit1.Value)) + ;
            " integro=" + TRANSFORM(loc_oDlg.obj_4c_Edit1.Value == loc_cEsperado)
        DO Lg WITH "(2) BO.this_cTexto LEN=" + TRANSFORM(LEN(loc_oDlg.this_oBusinessObject.this_cTexto))
        DO Lg WITH "(2) os TRES destinos do titulo concordam=" + ;
            TRANSFORM(loc_oDlg.Caption == "Historico" AND ;
                      loc_oDlg.cnt_4c_Sombra.lbl_4c_LblSombra.Caption == "Historico" AND ;
                      loc_oDlg.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption == "Historico")
        DO Lg WITH "(2) hook protected=" + TRANSFORM(PEMSTATUS(loc_oDlg, "BOParaForm", 2))
        loc_oDlg.Release()
    ENDIF

    *-- (3) o OUTRO call site legado (Dados Pagamento / HistPgs)
    loc_oDlg = CREATEOBJECT("FormSigOpRob", "Dados Pagamento", TmpConta.HistPgs, loc_oPai)
    IF VARTYPE(loc_oDlg) = "O"
        DO Lg WITH "(3) Caption=[" + loc_oDlg.Caption + "] Edit1=[" + ;
            ALLTRIM(loc_oDlg.obj_4c_Edit1.Value) + "]"
        loc_oDlg.Release()
    ENDIF

    *-- (4) sem argumento nenhum (harness) - nao pode estourar
    loc_oDlg = CREATEOBJECT("FormSigOpRob")
    DO Lg WITH "(4) sem argumentos: VARTYPE=" + VARTYPE(loc_oDlg) + ;
        IIF(VARTYPE(loc_oDlg) = "O", " Caption=[" + loc_oDlg.Caption + "] Edit1 LEN=" + ;
            TRANSFORM(LEN(loc_oDlg.obj_4c_Edit1.Value)), "")
    IF VARTYPE(loc_oDlg) = "O"
        loc_oDlg.Release()
    ENDIF
    IF VARTYPE(loc_oPai) = "O"
        loc_oPai.Release()
    ENDIF
    DO Lg WITH "FIM"
CATCH TO loc_oErro
    DO Lg WITH "ERRO NAO TRATADO: " + loc_oErro.Message + " / linha " + ;
        TRANSFORM(loc_oErro.LineNo) + " / proc " + loc_oErro.Procedure
ENDTRY
QUIT

PROCEDURE Lg
    LPARAMETERS par_cTexto
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_Out, 1)
ENDPROC

DEFINE CLASS FrmPaiF8 AS Form
    Width      = 200
    Height     = 100
    WindowType = 0
    Name       = "frmpaif8"
ENDDEFINE