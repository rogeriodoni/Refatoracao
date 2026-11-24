* ProbeF6Sigopvci816.prg
* Instancia Formsigopvci (Fase 6) e grava num TXT a prova dos eventos
* ligados nesta fase: os BINDEVENT registrados (AEVENTS), o estado inicial
* de habilitacao vindo das 4 procedures When do legado e a normalizacao do
* numero de cupom das 2 procedures LostFocus.
* NAO roda config.prg: o SQL Server do ambiente nao esta acessivel nesta
* maquina e ConfigurarAmbiente() travaria o probe. sigopvciBO.Init nao faz
* SQLEXEC, entao basta carregar as classes base + as globais que o Form le.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_CaminhoFramework, gc_4c_CaminhoIcones, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste    = .T.
gb_4c_ValidandoUI  = .T.
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gnConnHandle           = -1
gc_4c_ArquivoErroTeste = "C:\4c\automation\_erro_f6_sigopvci816.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cSaida, loc_oForm, loc_oErro, loc_nEv, loc_i
LOCAL ARRAY loc_aEv[1, 1]
loc_cSaida = ""

TRY
    SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\sigopvciBO.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\Formsigopvci.prg" ADDITIVE

    loc_oForm = CREATEOBJECT("Formsigopvci")

    IF VARTYPE(loc_oForm) = "O"
        loc_cSaida = "OK: Formsigopvci instanciado" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "ControlCount=[" + TRANSFORM(loc_oForm.ControlCount) + "]" + CHR(13) + CHR(10)

        *-- 1) BINDEVENT registrados (prova que o bind nao estourou e achou o delegate)
        loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + "--- BINDEVENT (AEVENTS) ---" + CHR(13) + CHR(10)
        loc_nEv = AEVENTS(loc_aEv, loc_oForm.obj_4c_Optiongroup1)
        loc_cSaida = loc_cSaida + "Optiongroup1: " + TRANSFORM(loc_nEv) + " binding(s)" + CHR(13) + CHR(10)
        FOR loc_i = 1 TO loc_nEv
            loc_cSaida = loc_cSaida + "   col2=[" + TRANSFORM(loc_aEv[loc_i, 2]) + "] col3=[" + TRANSFORM(loc_aEv[loc_i, 3]) + "] col4=[" + TRANSFORM(loc_aEv[loc_i, 4]) + "]" + CHR(13) + CHR(10)
        ENDFOR
        loc_nEv = AEVENTS(loc_aEv, loc_oForm.txt_4c_Text1)
        loc_cSaida = loc_cSaida + "Text1: " + TRANSFORM(loc_nEv) + " binding(s)" + CHR(13) + CHR(10)
        FOR loc_i = 1 TO loc_nEv
            loc_cSaida = loc_cSaida + "   col2=[" + TRANSFORM(loc_aEv[loc_i, 2]) + "] col3=[" + TRANSFORM(loc_aEv[loc_i, 3]) + "] col4=[" + TRANSFORM(loc_aEv[loc_i, 4]) + "]" + CHR(13) + CHR(10)
        ENDFOR
        loc_nEv = AEVENTS(loc_aEv, loc_oForm.txt_4c_Text2)
        loc_cSaida = loc_cSaida + "Text2: " + TRANSFORM(loc_nEv) + " binding(s)" + CHR(13) + CHR(10)
        FOR loc_i = 1 TO loc_nEv
            loc_cSaida = loc_cSaida + "   col2=[" + TRANSFORM(loc_aEv[loc_i, 2]) + "] col3=[" + TRANSFORM(loc_aEv[loc_i, 3]) + "] col4=[" + TRANSFORM(loc_aEv[loc_i, 4]) + "]" + CHR(13) + CHR(10)
        ENDFOR
        loc_nEv = AEVENTS(loc_aEv, loc_oForm.txt_4c_Text3)
        loc_cSaida = loc_cSaida + "Text3: " + TRANSFORM(loc_nEv) + " binding(s) (legado tem SO When, nenhum LostFocus)" + CHR(13) + CHR(10)

        *-- 2) Estado INICIAL de habilitacao (When do legado, Value = 1 -> Cupom)
        loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + "--- Habilitacao INICIAL (Optiongroup1.Value=" + ;
            TRANSFORM(loc_oForm.obj_4c_Optiongroup1.Value) + ") ---" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "Text1.Enabled=[" + TRANSFORM(loc_oForm.txt_4c_Text1.Enabled) + "] (esperado .T.)" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "Text2.Enabled=[" + TRANSFORM(loc_oForm.txt_4c_Text2.Enabled) + "] (esperado .T.)" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "Text3.Enabled=[" + TRANSFORM(loc_oForm.txt_4c_Text3.Enabled) + "] (esperado .F.)" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "Text4.Enabled=[" + TRANSFORM(loc_oForm.txt_4c_Text4.Enabled) + "] (esperado .F.)" + CHR(13) + CHR(10)

        *-- 3) Troca de criterio para Data (Value = 2) e reavaliacao da dependencia
        loc_oForm.obj_4c_Optiongroup1.Value = 2
        loc_oForm.ValidarCriterioBusca()
        loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + "--- Habilitacao apos trocar para Data (Value=2) ---" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "Text1.Enabled=[" + TRANSFORM(loc_oForm.txt_4c_Text1.Enabled) + "] (esperado .F.)" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "Text2.Enabled=[" + TRANSFORM(loc_oForm.txt_4c_Text2.Enabled) + "] (esperado .F.)" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "Text3.Enabled=[" + TRANSFORM(loc_oForm.txt_4c_Text3.Enabled) + "] (esperado .T.)" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "Text4.Enabled=[" + TRANSFORM(loc_oForm.txt_4c_Text4.Enabled) + "] (esperado .T.)" + CHR(13) + CHR(10)

        *-- 3b) Dispara o EVENTO (nao o delegate) para provar que o BINDEVENT despacha:
        *-- volta a Cupom e sai do .Enabled "errado" so chamando InteractiveChange/LostFocus.
        loc_oForm.txt_4c_Text3.Enabled = .F.
        loc_oForm.txt_4c_Text4.Enabled = .F.
        loc_oForm.obj_4c_Optiongroup1.Value = 2
        loc_oForm.obj_4c_Optiongroup1.InteractiveChange()
        loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + "--- Disparando o EVENTO Optiongroup1.InteractiveChange() ---" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "Text3.Enabled=[" + TRANSFORM(loc_oForm.txt_4c_Text3.Enabled) + "] (esperado .T. - o delegate rodou pelo bind)" + CHR(13) + CHR(10)
        loc_oForm.obj_4c_Optiongroup1.Value = 1
        loc_oForm.obj_4c_Optiongroup1.Click()
        loc_cSaida = loc_cSaida + "apos Click() com Value=1: Text1.Enabled=[" + TRANSFORM(loc_oForm.txt_4c_Text1.Enabled) + "] (esperado .T.) Text3.Enabled=[" + TRANSFORM(loc_oForm.txt_4c_Text3.Enabled) + "] (esperado .F.)" + CHR(13) + CHR(10)
        loc_oForm.txt_4c_Text1.Value = "77"
        loc_oForm.txt_4c_Text1.LostFocus()
        loc_cSaida = loc_cSaida + "apos Text1.LostFocus() com 77: Text1.Value=[" + loc_oForm.txt_4c_Text1.Value + "] (esperado 000077)" + CHR(13) + CHR(10)

        *-- 4) LostFocus do legado: Transform(Val(This.Value), '@L 999999')
        loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + "--- LostFocus / normalizacao do numero ---" + CHR(13) + CHR(10)
        loc_oForm.txt_4c_Text1.Value = "12"
        loc_oForm.ValidarNumeroInicial()
        loc_cSaida = loc_cSaida + "Text1 '12'   -> [" + loc_oForm.txt_4c_Text1.Value + "] (esperado 000012)" + CHR(13) + CHR(10)
        loc_oForm.txt_4c_Text2.Value = "4567"
        loc_oForm.ValidarNumeroFinal()
        loc_cSaida = loc_cSaida + "Text2 '4567' -> [" + loc_oForm.txt_4c_Text2.Value + "] (esperado 004567)" + CHR(13) + CHR(10)
        loc_oForm.txt_4c_Text1.Value = ""
        loc_oForm.ValidarNumeroInicial()
        loc_cSaida = loc_cSaida + "Text1 ''     -> [" + loc_oForm.txt_4c_Text1.Value + "] (esperado vazio - legado nao mexe quando Val=0)" + CHR(13) + CHR(10)
        loc_oForm.txt_4c_Text1.Value = "0"
        loc_oForm.ValidarNumeroInicial()
        loc_cSaida = loc_cSaida + "Text1 '0'    -> [" + loc_oForm.txt_4c_Text1.Value + "] (esperado 0 - legado nao mexe quando Val=0)" + CHR(13) + CHR(10)

        *-- 5) Nada do form legado ficou sem sosia: lookup = ZERO no legado
        loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + "--- Lookup ---" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "legado sem lookup: nenhum AbrirLookup/AbrirBusca a criar" + CHR(13) + CHR(10)

        loc_oForm = .NULL.
    ELSE
        loc_cSaida = "FALHA: CREATEOBJECT devolveu VARTYPE=[" + VARTYPE(loc_oForm) + "]" + CHR(13) + CHR(10)
    ENDIF

CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "EXCECAO: " + loc_oErro.Message + CHR(13) + CHR(10) + ;
        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10) + ;
        "Procedure: " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cSaida, "C:\4c\automation\_probe_f6_sigopvci816.txt")
QUIT
