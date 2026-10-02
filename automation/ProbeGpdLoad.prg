SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_gpdload.txt"
#DEFINE OUT "C:\4c\automation\probe_gpdload.txt"
LOCAL loc_oE, loc_oForm, loc_nR, loc_oPg1
STRTOFILE("A: inicio" + CHR(13)+CHR(10), OUT)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gpdbo.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\Formgpd.prg") ADDITIVE
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())

    *-- semeia dados de teste (a tabela esta vazia nesta base)
    SQLEXEC(gnConnHandle, "DELETE FROM SigCdPsg WHERE cgrus = 'ZZ8'")
    SQLEXEC(gnConnHandle, "INSERT INTO SigCdPsg (cgrus,codigos,descricaos,cidchaves,cgrucods,nfaixafins,nfaixainis,pesoprods,marckupa,nminpars,npars) VALUES (" + ;
        "'ZZ8','SG0001','SUB UM','E179CID0000000000001','ZZ8SG0001',9.5,1.5,1,11.11,2.5,3)")
    SQLEXEC(gnConnHandle, "INSERT INTO SigCdPsg (cgrus,codigos,descricaos,cidchaves,cgrucods,nfaixafins,nfaixainis,pesoprods,marckupa,nminpars,npars) VALUES (" + ;
        "'ZZ8','SG0002','SUB DOIS','E179CID0000000000002','ZZ8SG0002',8.25,2.25,0,22.22,1.5,2)")

    *-- quanto tem na tabela?
    loc_nR = SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS n FROM SigCdPsg", "crN")
    STRTOFILE("B: SQLEXEC=" + TRANSFORM(loc_nR) + " total SigCdPsg = " + ;
        IIF(USED("crN"), TRANSFORM(crN.n), "?") + CHR(13)+CHR(10), OUT, 1)
    loc_nR = SQLEXEC(gnConnHandle, ;
        "SELECT TOP 3 cgrus, COUNT(*) AS qtd FROM SigCdPsg GROUP BY cgrus " + ;
        "ORDER BY COUNT(*) DESC", "crTop")
    STRTOFILE("C: agrupado SQLEXEC=" + TRANSFORM(loc_nR) + " linhas=" + ;
        IIF(USED("crTop"), TRANSFORM(RECCOUNT("crTop")), "?") + CHR(13)+CHR(10), OUT, 1)
    IF USED("crTop")
        SCAN
            STRTOFILE("   [" + crTop.cgrus + "] qtd=" + TRANSFORM(crTop.qtd) + CHR(13)+CHR(10), OUT, 1)
        ENDSCAN
        GO TOP
    ENDIF

    loc_oForm = CREATEOBJECT("Formgpd")
    SET DATASESSION TO loc_oForm.DataSessionId
    loc_oPg1 = loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1

    *-- carrega o grupo com mais sub-grupos (na sessao do form)
    loc_nR = SQLEXEC(gnConnHandle, ;
        "SELECT TOP 1 cgrus FROM SigCdPsg GROUP BY cgrus ORDER BY COUNT(*) DESC", "crT2")
    IF loc_nR > 0 AND RECCOUNT("crT2") > 0
        STRTOFILE("D: carregando grupo [" + ALLTRIM(crT2.cgrus) + "]" + CHR(13)+CHR(10), OUT, 1)
        loc_oForm.CarregarSigCdPsgCad(ALLTRIM(crT2.cgrus))
        STRTOFILE("E: RECCOUNT cursor = " + TRANSFORM(RECCOUNT("cursor_4c_SigCdPsg")) + ;
            "  ColumnCount = " + TRANSFORM(loc_oPg1.grd_4c_PsgCad.ColumnCount) + ;
            "  RecordSource = [" + loc_oPg1.grd_4c_PsgCad.RecordSource + "]" + ;
            CHR(13)+CHR(10), OUT, 1)
        SELECT cursor_4c_SigCdPsg
        GO TOP
        LOCAL loc_nI
        loc_nI = 0
        SCAN WHILE loc_nI < 4
            loc_nI = loc_nI + 1
            STRTOFILE("   linha" + TRANSFORM(loc_nI) + ": cod=[" + codigos + ;
                "] desc=[" + ALLTRIM(descricaos) + "] markup=" + TRANSFORM(marckupa) + ;
                " peso=" + TRANSFORM(pesoprods) + " fxini=" + TRANSFORM(nfaixainis) + ;
                " npars=" + TRANSFORM(npars) + " cid=[" + ALLTRIM(cidchaves) + "]" + ;
                CHR(13)+CHR(10), OUT, 1)
        ENDSCAN
        *-- recarrega DE NOVO (prova que repetir nao degrada)
        loc_oForm.CarregarSigCdPsgCad(ALLTRIM(crT2.cgrus))
        STRTOFILE("F: 2a carga RECCOUNT = " + TRANSFORM(RECCOUNT("cursor_4c_SigCdPsg")) + ;
            "  ColumnCount = " + TRANSFORM(loc_oPg1.grd_4c_PsgCad.ColumnCount) + ;
            "  CC3=[" + loc_oPg1.grd_4c_PsgCad.Column3.CurrentControl + "]" + ;
            CHR(13)+CHR(10), OUT, 1)
    ELSE
        STRTOFILE("D: NENHUM grupo com sub-grupos na base" + CHR(13)+CHR(10), OUT, 1)
    ENDIF
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " Proc:" + loc_oE.Procedure + CHR(13)+CHR(10), OUT, 1)
ENDTRY
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13)+CHR(10), OUT, 1)
ENDIF
SQLEXEC(gnConnHandle, "DELETE FROM SigCdPsg WHERE cgrus = 'ZZ8'")
STRTOFILE("Z: fim (limpeza ZZ8 feita)" + CHR(13)+CHR(10), OUT, 1)
QUIT
