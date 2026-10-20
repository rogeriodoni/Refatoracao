*==============================================================================
* TestSigOpCco657F4.prg - Probe da Fase 4 do FormSIGOPCCO (task657).
* Prova o que o gate NAO prova:
*   1. o form INSTANCIA (o Init nao estoura em cadeia)
*   2. grd_4c_Dados existe, com as 3 colunas/headers/larguras do dump legado
*   3. a Column3 desenha o EditBox (CurrentControl + Sparse) - sem isso a
*      retificacao nunca apareceria (regra #18)
*   4. cmg_4c_Sair existe com os 2 botoes (Confirmar/Cancelar) do legado
*   5. cursor_4c_Ocorrencias existe com a estrutura do "Create Cursor XCorNf"
*      e esta LIGADO a grade (RecordSource/ControlSource)
*   6. CarregarDados/AtualizarGrade existem, sao PUBLIC (chamaveis de fora) e
*      CarregarDados sobrevive SEM conexao SQL devolvendo .F. em vez de estourar
*   7. os metodos do BO chamados de FORA nao sao PROTECTED (regra #51)
* Script auxiliar: SET SAFETY OFF + SET RESOURCE OFF (regra #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoFramework, gc_4c_ArquivoErroTeste
PUBLIC gc_4c_UsuarioLogado, gc_4c_CaminhoReports

gb_4c_ModoTeste         = .T.
gb_4c_ValidandoUI       = .F.
gnConnHandle            = -1
gc_4c_CaminhoIcones     = "C:\4c\vbmp\"
gc_4c_CaminhoFramework  = "C:\4c\Framework\"
gc_4c_CaminhoReports    = "C:\4c\projeto\app\reports\"
gc_4c_UsuarioLogado     = "TESTE"
gc_4c_ArquivoErroTeste  = "C:\4c\automation\teste_sigopcco657_dialogs.txt"

STRTOFILE("", gc_4c_ArquivoErroTeste)

SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg"    ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\validators.prg"  ADDITIVE
*-- FormErro.prg (MostrarErro) NAO eh carregado DE PROPOSITO: sem conexao SQL
*-- o CATCH do BO chamaria MostrarErro, que abre dialogo MODAL e TRAVA o probe
*-- headless. Sem ele a falha degrada para a mensagem capturada em
*-- gc_4c_ArquivoErroTeste, que eh o que este probe quer medir. Medido em
*-- 2026-10-17: com FormErro.prg carregado, MostrarErro RESOLVE e trava.
SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg"     ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\gridbase.prg"     ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\SIGOPCCOBO.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSIGOPCCO.prg" ADDITIVE

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oGrd, loc_lRet, loc_oBO
loc_cOut = "=== PROBE Fase 4 - FormSIGOPCCO (task657) ===" + CHR(13) + CHR(10)

*-- 1) INSTANCIAR -----------------------------------------------------------
loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSIGOPCCO", .NULL., "001", "1", {}, {}, "000123")
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[X] CREATEOBJECT estourou: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + ;
        CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loc_oForm) != "O"
    loc_cOut = loc_cOut + "[X] 1. INSTANCIA: FALHOU (VARTYPE = " + VARTYPE(loc_oForm) + ")" + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, "C:\4c\automation\teste_sigopcco657_f4.txt")
    QUIT
ENDIF
loc_cOut = loc_cOut + "[OK] 1. INSTANCIA: BaseClass=" + loc_oForm.BaseClass + ;
    " Caption=[" + loc_oForm.Caption + "]" + ;
    " " + TRANSFORM(loc_oForm.Width) + "x" + TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10)

*-- 2) GRADE ----------------------------------------------------------------
IF PEMSTATUS(loc_oForm, "grd_4c_Dados", 5)
    loc_oGrd = loc_oForm.grd_4c_Dados
    loc_cOut = loc_cOut + "[OK] 2. grd_4c_Dados: ColumnCount=" + TRANSFORM(loc_oGrd.ColumnCount) + ;
        " Top=" + TRANSFORM(loc_oGrd.Top) + " Left=" + TRANSFORM(loc_oGrd.Left) + ;
        " " + TRANSFORM(loc_oGrd.Width) + "x" + TRANSFORM(loc_oGrd.Height) + ;
        " RecordSource=[" + loc_oGrd.RecordSource + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "     Col1 H=[" + loc_oGrd.Column1.Header1.Caption + "] W=" + ;
        TRANSFORM(loc_oGrd.Column1.Width) + " CS=[" + loc_oGrd.Column1.ControlSource + ;
        "] RO=" + TRANSFORM(loc_oGrd.Column1.ReadOnly) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "     Col2 H=[" + loc_oGrd.Column2.Header1.Caption + "] W=" + ;
        TRANSFORM(loc_oGrd.Column2.Width) + " CS=[" + loc_oGrd.Column2.ControlSource + ;
        "] RO=" + TRANSFORM(loc_oGrd.Column2.ReadOnly) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "     Col3 H=[" + loc_oGrd.Column3.Header1.Caption + "] W=" + ;
        TRANSFORM(loc_oGrd.Column3.Width) + " CS=[" + loc_oGrd.Column3.ControlSource + ;
        "] RO=" + TRANSFORM(loc_oGrd.Column3.ReadOnly) + CHR(13) + CHR(10)
    *-- 3) Column3 tem de DESENHAR o EditBox (regra #18)
    loc_cOut = loc_cOut + IIF(UPPER(ALLTRIM(loc_oGrd.Column3.CurrentControl)) == "EDT_4C_RETIFICACAO", "[OK]", "[X] ") + ;
        " 3. Column3.CurrentControl=[" + loc_oGrd.Column3.CurrentControl + "] Sparse=" + ;
        TRANSFORM(loc_oGrd.Column3.Sparse) + " edtExiste=" + ;
        TRANSFORM(PEMSTATUS(loc_oGrd.Column3, "edt_4c_Retificacao", 5)) + CHR(13) + CHR(10)
ELSE
    loc_cOut = loc_cOut + "[X] 2. grd_4c_Dados AUSENTE" + CHR(13) + CHR(10)
ENDIF

*-- 4) BOTOES ---------------------------------------------------------------
IF PEMSTATUS(loc_oForm, "cmg_4c_Sair", 5)
    loc_cOut = loc_cOut + "[OK] 4. cmg_4c_Sair: ButtonCount=" + TRANSFORM(loc_oForm.cmg_4c_Sair.ButtonCount) + ;
        " Top=" + TRANSFORM(loc_oForm.cmg_4c_Sair.Top) + " Left=" + TRANSFORM(loc_oForm.cmg_4c_Sair.Left) + ;
        " B1=[" + loc_oForm.cmg_4c_Sair.Buttons(1).Caption + "]" + ;
        " B2=[" + loc_oForm.cmg_4c_Sair.Buttons(2).Caption + "]" + CHR(13) + CHR(10)
ELSE
    loc_cOut = loc_cOut + "[X] 4. cmg_4c_Sair AUSENTE" + CHR(13) + CHR(10)
ENDIF

*-- 5) CURSOR LOCAL (equivalente ao XCorNf) ---------------------------------
IF USED("cursor_4c_Ocorrencias")
    loc_cOut = loc_cOut + "[OK] 5. cursor_4c_Ocorrencias: campos=" + ;
        TRANSFORM(FCOUNT("cursor_4c_Ocorrencias")) + ;
        " [" + FIELD(1, "cursor_4c_Ocorrencias") + "," + FIELD(2, "cursor_4c_Ocorrencias") + ;
        "," + FIELD(3, "cursor_4c_Ocorrencias") + "]" + ;
        " TAG=[" + TAG(1, "cursor_4c_Ocorrencias") + "]" + ;
        " RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Ocorrencias")) + CHR(13) + CHR(10)
ELSE
    loc_cOut = loc_cOut + "[X] 5. cursor_4c_Ocorrencias AUSENTE" + CHR(13) + CHR(10)
ENDIF

*-- 6) METODOS DE CARGA: existem, sao PUBLIC e nao estouram sem SQL ---------
loc_cOut = loc_cOut + "     6a. CarregarDados   existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarDados", 5)) + ;
    " PROTECTED=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarDados", 2)) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "     6b. AtualizarGrade  existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "AtualizarGrade", 5)) + ;
    " PROTECTED=" + TRANSFORM(PEMSTATUS(loc_oForm, "AtualizarGrade", 2)) + CHR(13) + CHR(10)

loc_lRet = .NULL.
TRY
    loc_lRet = loc_oForm.CarregarDados("000123", .F.)
    loc_cOut = loc_cOut + "[OK] 6c. CarregarDados sem SQL retornou " + TRANSFORM(loc_lRet) + ;
        " (esperado .F. - sem conexao nao ha correcao) RECCOUNT=" + ;
        TRANSFORM(RECCOUNT("cursor_4c_Ocorrencias")) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[X] 6c. CarregarDados estourou: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

TRY
    loc_oForm.AtualizarGrade()
    loc_cOut = loc_cOut + "[OK] 6d. AtualizarGrade executou sem erro" + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[X] 6d. AtualizarGrade estourou: " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY

*-- 7) METODOS do BO chamados de FORA nao podem ser PROTECTED (regra #51) ---
loc_oBO = loc_oForm.this_oBusinessObject
IF VARTYPE(loc_oBO) = "O"
    loc_cOut = loc_cOut + "     7. BO.CarregarOcorrencias PROTECTED=" + ;
        TRANSFORM(PEMSTATUS(loc_oBO, "CarregarOcorrencias", 2)) + ;
        " BO.CarregarCorrecoes PROTECTED=" + ;
        TRANSFORM(PEMSTATUS(loc_oBO, "CarregarCorrecoes", 2)) + CHR(13) + CHR(10)
ELSE
    loc_cOut = loc_cOut + "[X] 7. BO nao instanciado" + CHR(13) + CHR(10)
ENDIF

loc_cOut = loc_cOut + "--- dialogos capturados ---" + CHR(13) + CHR(10) + ;
    FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)

loc_oForm.Release()
loc_oForm = .NULL.

STRTOFILE(loc_cOut, "C:\4c\automation\teste_sigopcco657_f4.txt")
QUIT
