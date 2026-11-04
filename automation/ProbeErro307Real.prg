*==============================================================================
* ProbeErro307Real.prg - Executa o Inserir() REAL do OpsBO contra o banco,
* dentro de BEGIN TRANSACTION / ROLLBACK. Usa a COPIA do .prg (o app aberto
* segura o .fxp do projeto). Confere a contagem antes/depois para provar que
* nada ficou gravado.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado, gcLR
gb_4c_ModoTeste        = .T.
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_307r.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
gcLR = "C:\4c\automation\probe_erro307_real.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcLR)

LOCAL loc_oE, loBO, lnAntes, lnDepois, llOk

=SQLSETPROP(0, "ConnectTimeOut", 15)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO ("C:\Users\roger\AppData\Local\Temp\claude\C--4c\5c3d6e1b-73f7-4c38-8cb7-934e8d60a318\scratchpad\chk307\OpsBO.prg") ADDITIVE
    LR("B: deps carregadas (OpsBO da copia)")

    gnConnHandle = SQLSTRINGCONNECT("DRIVER={SQL Server};SERVER=192.168.200.10;" + ;
        "DATABASE=DB_MBAHIA;UID=4control;PWD=f2016jstcr%@;")
    LR("C: gnConnHandle = " + TRANSFORM(gnConnHandle))

    IF gnConnHandle > 0
        lnAntes = Conta()
        LR("D: SigCdOpe ANTES = " + TRANSFORM(lnAntes) + " linhas")

        =SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
        LR("E: transacao aberta")

        loBO = CREATEOBJECT("OpsBOEspiao")
        loBO.this_cDopes    = "ZZTST"
        loBO.this_nNDopes   = 999
        loBO.this_cTitOpes  = "TESTE AUTOMATIZADO"
        loBO.this_cMenus    = "CAIXA"
        loBO.this_cSubMenus = "VENDAS"
        loBO.this_nOrdes    = 1
        loBO.this_cCmoes    = "R$"
        loBO.this_nCopers   = 0
        loBO.this_cObsOpes  = "obs teste"
        loBO.this_nTipoOps  = 4
        loBO.this_cAbrevs   = "TST"
        loBO.this_cNivels   = "NIVEL"
        loBO.this_nNFiscals = 0

        llOk = loBO.ExporInserir()
        LR("F: Inserir() = " + TRANSFORM(llOk))

        *-- a linha existe DENTRO da transacao?
        IF SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS n FROM SigCdOpe WHERE Dopes='ZZTST'", "cur_i") > 0
            LR("G: dentro da transacao, linhas ZZTST = " + TRANSFORM(cur_i.n))
            USE IN cur_i
        ENDIF

        =SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        LR("H: ROLLBACK executado")

        lnDepois = Conta()
        LR("I: SigCdOpe DEPOIS = " + TRANSFORM(lnDepois) + ;
           "   nada gravado? " + TRANSFORM(lnAntes = lnDepois))
        IF SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS n FROM SigCdOpe WHERE Dopes='ZZTST'", "cur_f") > 0
            LR("J: apos rollback, linhas ZZTST = " + TRANSFORM(cur_f.n) + "  (tem de ser 0)")
            USE IN cur_f
        ENDIF
        =SQLDISCONNECT(gnConnHandle)
    ENDIF

CATCH TO loc_oE
    LR("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo))
    IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
        =SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        LR("   ROLLBACK de seguranca executado")
    ENDIF
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    LR("DIALOGOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste))
ENDIF
STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcLR, 1)
QUIT

PROCEDURE LR(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcLR, 1)
ENDPROC

FUNCTION Conta()
    LOCAL lnN
    lnN = -1
    IF SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS n FROM SigCdOpe", "cur_c") > 0
        lnN = cur_c.n
        USE IN cur_c
    ENDIF
    RETURN lnN
ENDFUNC

DEFINE CLASS OpsBOEspiao AS OpsBO
    PROCEDURE ExporInserir()
        RETURN THIS.Inserir()
    ENDPROC
ENDDEFINE
