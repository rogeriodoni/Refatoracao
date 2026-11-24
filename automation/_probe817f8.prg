* _probe817f8.prg - prova que o Init do FormSigOpVda nao quebra e que os
* defaults do Init legado (DATE()/DATE()/C:\CONCILIADOR.CSV) chegam a tela.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cOut, loc_oForm, loc_oErro

loc_cOut = ""

TRY
    DO config.prg

    PUBLIC gb_4c_ValidandoUI, gb_4c_ModoTeste, gnConnHandle, gc_4c_ArquivoErroTeste
    gb_4c_ValidandoUI = .T.
    gb_4c_ModoTeste   = .T.
    gnConnHandle      = -1
    gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe817f8_erros.txt"

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
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpVdaBO.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigOpVda.prg") ADDITIVE

    loc_oForm = CREATEOBJECT("FormSigOpVda")

    loc_cOut = loc_cOut + "VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

    IF VARTYPE(loc_oForm) = "O"
        loc_cOut = loc_cOut + ;
            "Caption=["      + loc_oForm.Caption + "]" + CHR(13) + CHR(10) + ;
            "DtIni=["        + TRANSFORM(loc_oForm.txt_4c_DtIni.Value) + "]" + CHR(13) + CHR(10) + ;
            "DtFin=["        + TRANSFORM(loc_oForm.txt_4c_DtFin.Value) + "]" + CHR(13) + CHR(10) + ;
            "Arquivo=["      + ALLTRIM(loc_oForm.obj_4c_GetArqNoms.Value) + "]" + CHR(13) + CHR(10) + ;
            "ArqReadOnly=["  + TRANSFORM(loc_oForm.obj_4c_GetArqNoms.ReadOnly) + "]" + CHR(13) + CHR(10) + ;
            "OptProc=["      + TRANSFORM(loc_oForm.obj_4c_OptProcessados.Value) + "]" + CHR(13) + CHR(10) + ;
            "EmpOs=["        + ALLTRIM(loc_oForm.txt_4c_EmpOs.Value) + "]" + CHR(13) + CHR(10) + ;
            "DEmpOsRO=["     + TRANSFORM(loc_oForm.txt_4c_DEmpOs.ReadOnly) + "]" + CHR(13) + CHR(10) + ;
            "BO_DataIni=["   + TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataIni) + "]" + CHR(13) + CHR(10) + ;
            "BO_Arquivo=["   + ALLTRIM(loc_oForm.this_oBusinessObject.this_cArquivo) + "]" + CHR(13) + CHR(10) + ;
            "BO_Emps_antes=[" + loc_oForm.this_oBusinessObject.this_cEmps + "]" + CHR(13) + CHR(10) + ;
            "GridCols=["     + TRANSFORM(loc_oForm.cnt_4c_Grade.grd_4c_Dados.ColumnCount) + "]" + CHR(13) + CHR(10) + ;
            "GridRecSrc=["   + loc_oForm.cnt_4c_Grade.grd_4c_Dados.RecordSource + "]" + CHR(13) + CHR(10) + ;
            "MsgErroForm=["  + loc_oForm.this_cMensagemErro + "]" + CHR(13) + CHR(10)

        *-- FormParaBO eh PROTECTED: so da para exercitar pelo caminho publico.
        *-- Simula o usuario digitando a empresa e apertando Gera Arquivo:
        *-- Processamento chama FormParaBO, que tem de levar o "1" para o BO
        *-- normalizado com Padr(...,3).
        loc_oForm.txt_4c_EmpOs.Value = "1"
        loc_oForm.txt_4c_Adquirs.Value = "CIELO"
        loc_oForm.obj_4c_OptProcessados.Value = 2
        loc_oForm.Selecionar()

        loc_cOut = loc_cOut + ;
            "--- apos Selecionar (sem conexao) ---" + CHR(13) + CHR(10) + ;
            "BO_Emps=["       + loc_oForm.this_oBusinessObject.this_cEmps + "] len=" + ;
                                TRANSFORM(LEN(loc_oForm.this_oBusinessObject.this_cEmps)) + CHR(13) + CHR(10) + ;
            "BO_Adquirente=[" + loc_oForm.this_oBusinessObject.this_cAdquirente + "]" + CHR(13) + CHR(10) + ;
            "BO_Processados=[" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nProcessados) + "]" + CHR(13) + CHR(10) + ;
            "BO_DataFin=["    + TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataFin) + "]" + CHR(13) + CHR(10)

        loc_oForm.Release()
    ENDIF

CATCH TO loc_oErro
    loc_cOut = loc_cOut + "ERRO=" + loc_oErro.Message + CHR(13) + CHR(10) + ;
        "LINHA=" + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10) + ;
        "PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

= STRTOFILE(loc_cOut, "C:\4c\automation\_probe817f8.txt")
QUIT
