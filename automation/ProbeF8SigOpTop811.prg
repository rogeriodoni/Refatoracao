* ProbeF8SigOpTop811.prg
* Fase 8 da task811: prova em RUNTIME que o funil de carga da grade responde
* pelo nome canonico CarregarLista e que ele eh alcancavel de FORA da classe,
* exatamente como TesteAutomatico.prg faz (THIS.oForm.CarregarLista()).
*
* NAO roda ConfigurarAmbiente(): ela nao retorna nesta maquina e o probe
* morreria por timeout antes do CREATEOBJECT. Carrega so as dependencias.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_CaminhoFramework, gc_4c_CaminhoIcones, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste    = .T.
gb_4c_ValidandoUI  = .T.
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\_erro_f8_sigoptop811.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cSaida, loc_oForm, loc_oErro, loc_oFormPaiFake, loc_lRet, loc_oGrd
loc_cSaida = ""

TRY
    SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\SigOpTopBO.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigOpTop.prg" ADDITIVE

    loc_oFormPaiFake = CREATEOBJECT("Form")
    loc_oForm = CREATEOBJECT("FormSigOpTop", loc_oFormPaiFake, "001234", 1)

    IF VARTYPE(loc_oForm) != "O"
        loc_cSaida = "CK01 FALHA: CREATEOBJECT devolveu [" + VARTYPE(loc_oForm) + "]" + CHR(13) + CHR(10)
    ELSE
        loc_cSaida = "CK01 instanciou           = OK" + CHR(13) + CHR(10)

        *-- CK02/CK03: o nome canonico existe e o antigo sumiu
        loc_cSaida = loc_cSaida + "CK02 PEMSTATUS CarregarLista = [" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 5)) + "] (esperado .T.)" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "CK03 PEMSTATUS CarregarDados = [" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "CarregarDados", 5)) + "] (esperado .F. - renomeado)" + CHR(13) + CHR(10)

        *-- CK04: PROTECTED? atributo 2 = Protected. Tem de ser .F. (regra #3)
        loc_cSaida = loc_cSaida + "CK04 CarregarLista PROTECTED = [" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 2)) + "] (esperado .F.)" + CHR(13) + CHR(10)

        *-- CK05: chamada EXTERNA, igual a TesteAutomatico.TesteCarregarLista.
        *-- Sem gnConnHandle o BO recusa e o metodo devolve .F. SEM estourar -
        *-- o que se prova aqui eh que a chamada de fora NAO da
        *-- "Property CARREGARLISTA is not found"
        loc_lRet = loc_oForm.CarregarLista()
        loc_cSaida = loc_cSaida + "CK05 CarregarLista() externa = [" + TRANSFORM(loc_lRet) + ;
            "] (esperado .F. - sem conexao; o que importa eh nao estourar)" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "CK06 this_cMensagemErro      = [" + ;
            ALLTRIM(loc_oForm.this_cMensagemErro) + "]" + CHR(13) + CHR(10)

        *-- CK07: a grade segue formatada mesmo sem carga (AplicarFormatoGrade)
        IF PEMSTATUS(loc_oForm, "grd_4c_Dados", 5)
            loc_oGrd = loc_oForm.grd_4c_Dados
            loc_cSaida = loc_cSaida + "CK07 grd ColumnCount=[" + TRANSFORM(loc_oGrd.ColumnCount) + ;
                "] C1.Width=[" + TRANSFORM(loc_oGrd.Column1.Width) + ;
                "] C2.Width=[" + TRANSFORM(loc_oGrd.Column2.Width) + "]" + CHR(13) + CHR(10)
            loc_cSaida = loc_cSaida + "CK08 headers=[" + ALLTRIM(loc_oGrd.Column1.Header1.Caption) + ;
                "] / [" + ALLTRIM(loc_oGrd.Column2.Header1.Caption) + "]" + CHR(13) + CHR(10)
            loc_cSaida = loc_cSaida + "CK09 grd ReadOnly=[" + TRANSFORM(loc_oGrd.ReadOnly) + ;
                "] C1.ReadOnly=[" + TRANSFORM(loc_oGrd.Column1.ReadOnly) + ;
                "] C2.ReadOnly=[" + TRANSFORM(loc_oGrd.Column2.ReadOnly) + "]" + CHR(13) + CHR(10)
        ELSE
            loc_cSaida = loc_cSaida + "CK07 FALHA: grd_4c_Dados ausente" + CHR(13) + CHR(10)
        ENDIF

        *-- CK10: reentrancia - chamar o funil duas vezes nao pode quebrar
        loc_lRet = loc_oForm.CarregarLista()
        loc_cSaida = loc_cSaida + "CK10 CarregarLista() 2a vez  = [" + TRANSFORM(loc_lRet) + "]" + CHR(13) + CHR(10)

        *-- CK11: AplicarFormatoGrade tambem eh PUBLIC e idempotente
        loc_cSaida = loc_cSaida + "CK11 AplicarFormatoGrade()   = [" + ;
            TRANSFORM(loc_oForm.AplicarFormatoGrade()) + "]" + CHR(13) + CHR(10)

        *-- CK12: Destroy reabilita o form pai
        loc_oFormPaiFake.Enabled = .F.
        loc_oForm.Release()
        loc_oForm = .NULL.
        loc_cSaida = loc_cSaida + "CK12 FormPai.Enabled pos-Release = [" + ;
            TRANSFORM(loc_oFormPaiFake.Enabled) + "] (esperado .T.)" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "CK13 cursor_4c_Transportes aberto = [" + ;
            TRANSFORM(USED("cursor_4c_Transportes")) + "] (esperado .F.)" + CHR(13) + CHR(10)
    ENDIF

CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "EXCECAO: " + loc_oErro.Message + ;
        " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Proc: " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cSaida = loc_cSaida + "--- DIALOGOS CAPTURADOS (ModoTeste) ---" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ELSE
    loc_cSaida = loc_cSaida + "--- nenhum dialogo capturado ---" + CHR(13) + CHR(10)
ENDIF

= STRTOFILE(loc_cSaida, "C:\4c\automation\_probe811f8.txt")
QUIT
