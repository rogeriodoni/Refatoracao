*==============================================================================
* ProbeModalEmInit - mede se FormBuscaAuxiliar (modal, MODO 2) abre de dentro
* do Init de um form que ainda nao foi exibido. E o risco tecnico do seletor de
* Tits do FormDrs, que a base nao exercita (SigSyCit vazia).
*
* LEITURA: se o log parar em "3) antes do Show" e o processo for morto por
* TIMEOUT, o modal ABRIU (Show de form modal bloqueia em headless).
* Qualquer linha depois de "3)" sem timeout = o modal NAO abriu.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_modalinit.txt"
#DEFINE OUT "C:\4c\automation\probe_modalinit.txt"

LOCAL loc_oForm, loc_oE

STRTOFILE("=== PROBE modal dentro de Init ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "4control"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeModalEmInit.prg" ADDITIVE

    loc_oForm = CREATEOBJECT("ProbeFormComModal")
    STRTOFILE("9) voltou do Init SEM travar -> modal NAO abriu. VARTYPE=" + ;
        VARTYPE(loc_oForm) + CHR(13) + CHR(10), OUT, 1)

CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + " | Linha " + TRANSFORM(loc_oE.LineNo) + ;
        " | " + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

QUIT


DEFINE CLASS ProbeFormComModal AS Form
    Height = 400
    Width  = 600

    PROCEDURE Init()
        LOCAL loc_oBusca

        *-- cursor local com 2 linhas, no formato que SelecionarTits produz
        CREATE CURSOR cursor_4c_BuscaTits (Tits C(20), Campos N(4))
        INSERT INTO cursor_4c_BuscaTits VALUES ("FICHA A", 7)
        INSERT INTO cursor_4c_BuscaTits VALUES ("FICHA B", 3)
        GO TOP IN cursor_4c_BuscaTits

        STRTOFILE("1) cursor criado RECCOUNT=" + ;
            TRANSFORM(RECCOUNT("cursor_4c_BuscaTits")) + CHR(13) + CHR(10), OUT, 1)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
        STRTOFILE("2) FormBuscaAuxiliar VARTYPE=" + VARTYPE(loc_oBusca) + CHR(13) + CHR(10), OUT, 1)

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTits"
            loc_oBusca.mAddColuna("Tits",   "X(20)", "Ficha Tecnica")
            loc_oBusca.mAddColuna("Campos", "9999",  "Campos")
            STRTOFILE("3) antes do Show (se travar aqui, o modal ABRIU)" + CHR(13) + CHR(10), OUT, 1)
            loc_oBusca.Show()
            STRTOFILE("4) DEPOIS do Show - nao bloqueou" + CHR(13) + CHR(10), OUT, 1)
            loc_oBusca.Release()
        ENDIF

        RETURN .T.
    ENDPROC
ENDDEFINE
