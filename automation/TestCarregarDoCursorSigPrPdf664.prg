*-- Prova de RUNTIME do CarregarDoCursor do sigprpdfBO (task664, Fase 2).
*-- Compilar nao basta: o que importa eh se o mapeamento coluna->property
*-- realmente acontece, com as mesmas conversoes do legado (Lower/Alltrim/Nvl).
*-- Mede 4 cenarios: linha normal, NULL em tudo, cursor vazio e alias ausente.
*-- A subclasse de teste tem Init vazio porque instanciar BO com gnConnHandle
*-- invalido abre dialogo e trava o VFP headless.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_UsuarioLogado, go_4c_Sistema
gb_4c_ModoTeste     = .T.
gb_4c_ValidandoUI   = .T.
gnConnHandle        = -1
gc_4c_UsuarioLogado = "TESTE"

LOCAL loc_cCls, loc_cUtl, loc_oBO, loc_cOut, loc_lR, loc_nAreaAntes, loc_cAreaDepois

loc_cCls = "C:\4c\projeto\app\classes\"
loc_cUtl = "C:\4c\projeto\app\utils\"
loc_cOut = ""

TRY
    SET PATH TO ("C:\4c\projeto\app\start,C:\4c\projeto\app\classes,C:\4c\projeto\app\utils")
    SET PROCEDURE TO (loc_cUtl + "functions.prg") ADDITIVE
    SET PROCEDURE TO (loc_cUtl + "messages.prg") ADDITIVE
    SET PROCEDURE TO (loc_cCls + "dataaccess.prg") ADDITIVE
    SET PROCEDURE TO (loc_cCls + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (loc_cCls + "sigprpdfBO.prg") ADDITIVE

    go_4c_Sistema = CREATEOBJECT("Empty")
    ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")

    loc_oBO = CREATEOBJECT("BOTesteSigPrPdf")

    *-- Cenario 1: linha normal, com sujeira de caixa/espaco igual ao banco
    *-- (char(50)/char(30) vem padded) para provar LOWER + ALLTRIM.
    SET NULL ON
    CREATE CURSOR cursor_4c_TmpEmpMail ( ;
        PadEmails C(50) NULL, PadServs C(50) NULL, PadSenhas C(30) NULL, ;
        Pastas C(50) NULL, PadPortas N(3, 0) NULL)
    SET NULL OFF

    INSERT INTO cursor_4c_TmpEmpMail (PadEmails, PadServs, PadSenhas, Pastas, PadPortas) ;
        VALUES ("  Fiscal@Empresa.COM.BR  ", "  SMTP.Empresa.COM.BR  ", ;
                "  SeNhA123  ", "  C:\Fiscais\  ", 587)

    *-- Trabalha noutra area para provar que a work area do chamador volta
    CREATE CURSOR cursor_4c_Sentinela (x C(1))
    SELECT cursor_4c_Sentinela
    loc_nAreaAntes = SELECT()

    loc_lR = loc_oBO.CarregarDoCursor("cursor_4c_TmpEmpMail")

    loc_cAreaDepois = IIF(SELECT() = loc_nAreaAntes, "RESTAURADA", "PERDIDA(" + ALIAS() + ")")

    loc_cOut = loc_cOut + "=== C1: linha normal ===" + CHR(13) + CHR(10) + ;
        "retorno            =[" + IIF(loc_lR, "T", "F") + "]" + CHR(13) + CHR(10) + ;
        "this_cEmpPadEmails =[" + loc_oBO.this_cEmpPadEmails + "]" + CHR(13) + CHR(10) + ;
        "this_cEmpPadServs  =[" + loc_oBO.this_cEmpPadServs  + "]" + CHR(13) + CHR(10) + ;
        "this_cEmpPadSenhas =[" + loc_oBO.this_cEmpPadSenhas + "]" + CHR(13) + CHR(10) + ;
        "this_cEmpPastas    =[" + loc_oBO.this_cEmpPastas    + "]" + CHR(13) + CHR(10) + ;
        "this_nEmpPadPortas =[" + TRANSFORM(loc_oBO.this_nEmpPadPortas) + "] tipo=" + ;
            VARTYPE(loc_oBO.this_nEmpPadPortas) + CHR(13) + CHR(10) + ;
        "this_cEmailDe      =[" + loc_oBO.this_cEmailDe + "]" + CHR(13) + CHR(10) + ;
        "contaCarregada     =[" + IIF(loc_oBO.this_lContaEmailCarregada, "T", "F") + "]" + CHR(13) + CHR(10) + ;
        "work area          =[" + loc_cAreaDepois + "]" + CHR(13) + CHR(10) + CHR(13) + CHR(10)

    *-- Cenario 2: colunas NULL (SigCdEmp e NOT NULL, mas o legado envolve
    *-- TUDO em Nvl() - reproduzir essa tolerancia eh parte do contrato)
    loc_oBO2 = CREATEOBJECT("BOTesteSigPrPdf")
    SELECT cursor_4c_TmpEmpMail
    REPLACE PadEmails WITH .NULL., PadServs WITH .NULL., ;
            PadSenhas WITH .NULL., Pastas WITH .NULL., PadPortas WITH .NULL.

    loc_lR = loc_oBO2.CarregarDoCursor("cursor_4c_TmpEmpMail")

    loc_cOut = loc_cOut + "=== C2: colunas NULL ===" + CHR(13) + CHR(10) + ;
        "retorno            =[" + IIF(loc_lR, "T", "F") + "]" + CHR(13) + CHR(10) + ;
        "this_cEmpPadEmails =[" + loc_oBO2.this_cEmpPadEmails + "]" + CHR(13) + CHR(10) + ;
        "this_nEmpPadPortas =[" + TRANSFORM(loc_oBO2.this_nEmpPadPortas) + "] tipo=" + ;
            VARTYPE(loc_oBO2.this_nEmpPadPortas) + CHR(13) + CHR(10) + ;
        "contaCarregada     =[" + IIF(loc_oBO2.this_lContaEmailCarregada, "T", "F") + "]" + CHR(13) + CHR(10) + CHR(13) + CHR(10)

    *-- Cenario 3: cursor existe mas esta VAZIO (empresa sem conta cadastrada)
    loc_oBO3 = CREATEOBJECT("BOTesteSigPrPdf")
    SELECT cursor_4c_TmpEmpMail
    ZAP

    loc_lR = loc_oBO3.CarregarDoCursor("cursor_4c_TmpEmpMail")

    loc_cOut = loc_cOut + "=== C3: cursor vazio ===" + CHR(13) + CHR(10) + ;
        "retorno            =[" + IIF(loc_lR, "T", "F") + "]" + CHR(13) + CHR(10) + ;
        "contaCarregada     =[" + IIF(loc_oBO3.this_lContaEmailCarregada, "T", "F") + "]" + CHR(13) + CHR(10) + ;
        "mensagemErro       =[" + loc_oBO3.this_cMensagemErro + "]" + CHR(13) + CHR(10) + CHR(13) + CHR(10)

    *-- Cenario 4: alias inexistente e argumento ausente (nao pode estourar)
    loc_oBO4 = CREATEOBJECT("BOTesteSigPrPdf")
    loc_lR = loc_oBO4.CarregarDoCursor("cursor_4c_NaoExiste")
    loc_cOut = loc_cOut + "=== C4: alias ausente ===" + CHR(13) + CHR(10) + ;
        "retorno(inexist.)  =[" + IIF(loc_lR, "T", "F") + "]" + CHR(13) + CHR(10) + ;
        "mensagemErro       =[" + loc_oBO4.this_cMensagemErro + "]" + CHR(13) + CHR(10)

    loc_lR = loc_oBO4.CarregarDoCursor()
    loc_cOut = loc_cOut + "retorno(sem arg)   =[" + IIF(loc_lR, "T", "F") + "]" + CHR(13) + CHR(10) + ;
        "RESULTADO=SEM_EXCECAO" + CHR(13) + CHR(10)

CATCH TO loc_oErro
    loc_cOut = loc_cOut + "RESULTADO=EXCECAO [" + loc_oErro.Message + ;
        "] LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cOut, "C:\4c\automation\test_carregardocursor_sigprpdf664.txt")
QUIT


*-- Subclasse de teste: Init vazio para nao tentar conexao SQL (o Init real
*-- do BO nao consulta nada, mas DODEFAULT do BusinessBase pode) e para o
*-- harness rodar headless sem dialogo.
DEFINE CLASS BOTesteSigPrPdf AS sigprpdfBO
    PROCEDURE Init()
        RETURN .T.
    ENDPROC
ENDDEFINE
