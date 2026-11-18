* ProbeF5SigOpStc807.prg
* Fase 5 / task807 - prova que FormSIGOPSTC INSTANCIA com os campos do
* cabecalho criados (Text1/Label2/Text2/Label3/Text3) e que
* AtualizarCabecalho realmente POE VALOR neles (regra #42: conferir o
* observavel, nao o retorno .T.).
*
* NAO chama ConfigurarAmbiente() - ele nao retorna nesta maquina e o probe
* morreria por timeout antes do CREATEOBJECT. Carrega a mao so o que este
* form usa.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cOut, loc_cRel, loc_oForm, loc_oPai, loc_cArq, loc_oErro, loc_cConn, loc_nSess

loc_cOut = "C:\4c\automation\_f5stc_probe.txt"
loc_cRel = "CHECKPOINT 1 - script vivo" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f5stc_erros.txt"
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "PROBE"

CD C:\4c\projeto\app\start
DO config.prg

loc_cRel = loc_cRel + "CHECKPOINT 2 - config.prg OK" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

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
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SIGOPSTCBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSIGOPSTC.prg") ADDITIVE

loc_cRel = loc_cRel + "CHECKPOINT 3 - SET PROCEDURE OK" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

loc_cConn = "DRIVER={SQL Server};SERVER=192.168.200.10;DATABASE=DB_MBAHIA;" + ;
            "UID=4control;PWD=f2016jstcr%@"
gnConnHandle = SQLSTRINGCONNECT(loc_cConn)

loc_cRel = loc_cRel + "CHECKPOINT 4 - gnConnHandle = " + TRANSFORM(gnConnHandle) + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

*-- Escolhe um arquivo que REALMENTE tenha tentativa de envio gravada
loc_cArq = ""
IF gnConnHandle > 0
    IF SQLEXEC(gnConnHandle, "SELECT TOP 1 a.carqmovs, COUNT(*) AS qtd " + ;
            "FROM SigFiSit a INNER JOIN SigFiSii b ON a.carqmovs = b.carqmovs " + ;
            "GROUP BY a.carqmovs ORDER BY COUNT(*) DESC", "cur_arq") > 0
        IF RECCOUNT("cur_arq") > 0
            SELECT cur_arq
            GO TOP
            loc_cArq = ALLTRIM(cur_arq.carqmovs)
            loc_cRel = loc_cRel + "ARQUIVO ESCOLHIDO = [" + loc_cArq + "]  linhas em SigFiSii = " + ;
                TRANSFORM(cur_arq.qtd) + CHR(13) + CHR(10)
        ENDIF
        USE IN cur_arq
    ENDIF
ENDIF
STRTOFILE(loc_cRel, loc_cOut)

*-- Form pai simulado: o dialogo exige poForm.pcSelFile (Form tem
*-- AddProperty e DataSessionId, que eh o que o InicializarForm le)
loc_oPai = CREATEOBJECT("Form")
loc_oPai.AddProperty("pcSelFile", loc_cArq)

TRY
    loc_oForm = CREATEOBJECT("FormSIGOPSTC", loc_oPai)
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "EXCECAO no CREATEOBJECT: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

loc_cRel = loc_cRel + "VARTYPE(loc_oForm) = [" + VARTYPE(loc_oForm) + "]" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

IF VARTYPE(loc_oForm) = "O"
    loc_cRel = loc_cRel + "this_cArqMovsPai = [" + loc_oForm.this_cArqMovsPai + "]" + CHR(13) + CHR(10)

    loc_cRel = loc_cRel + "--- CAMPOS DA FASE 5 (existencia / geometria / estado)" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Text1=" + IIF(PEMSTATUS(loc_oForm, "txt_4c_Text1", 5), "SIM", "NAO") + ;
        " Label2=" + IIF(PEMSTATUS(loc_oForm, "lbl_4c_Label2", 5), "SIM", "NAO") + ;
        " Text2=" + IIF(PEMSTATUS(loc_oForm, "txt_4c_Text2", 5), "SIM", "NAO") + ;
        " Label3=" + IIF(PEMSTATUS(loc_oForm, "lbl_4c_Label3", 5), "SIM", "NAO") + ;
        " Text3=" + IIF(PEMSTATUS(loc_oForm, "txt_4c_Text3", 5), "SIM", "NAO") + CHR(13) + CHR(10)

    loc_cRel = loc_cRel + "  Text1 T/L/WxH = " + TRANSFORM(loc_oForm.txt_4c_Text1.Top) + "/" + ;
        TRANSFORM(loc_oForm.txt_4c_Text1.Left) + "/" + TRANSFORM(loc_oForm.txt_4c_Text1.Width) + "x" + ;
        TRANSFORM(loc_oForm.txt_4c_Text1.Height) + "  Vis=" + TRANSFORM(loc_oForm.txt_4c_Text1.Visible) + ;
        "  RO=" + TRANSFORM(loc_oForm.txt_4c_Text1.ReadOnly) + ;
        "  TabStop=" + TRANSFORM(loc_oForm.txt_4c_Text1.TabStop) + ;
        "  Ena=" + TRANSFORM(loc_oForm.txt_4c_Text1.Enabled) + ;
        "  Align=" + TRANSFORM(loc_oForm.txt_4c_Text1.Alignment) + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Text2 T/L/WxH = " + TRANSFORM(loc_oForm.txt_4c_Text2.Top) + "/" + ;
        TRANSFORM(loc_oForm.txt_4c_Text2.Left) + "/" + TRANSFORM(loc_oForm.txt_4c_Text2.Width) + "x" + ;
        TRANSFORM(loc_oForm.txt_4c_Text2.Height) + "  Vis=" + TRANSFORM(loc_oForm.txt_4c_Text2.Visible) + ;
        "  RO=" + TRANSFORM(loc_oForm.txt_4c_Text2.ReadOnly) + ;
        "  TabStop=" + TRANSFORM(loc_oForm.txt_4c_Text2.TabStop) + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Text3 T/L/WxH = " + TRANSFORM(loc_oForm.txt_4c_Text3.Top) + "/" + ;
        TRANSFORM(loc_oForm.txt_4c_Text3.Left) + "/" + TRANSFORM(loc_oForm.txt_4c_Text3.Width) + "x" + ;
        TRANSFORM(loc_oForm.txt_4c_Text3.Height) + "  Vis=" + TRANSFORM(loc_oForm.txt_4c_Text3.Visible) + ;
        "  RO=" + TRANSFORM(loc_oForm.txt_4c_Text3.ReadOnly) + ;
        "  TabStop=" + TRANSFORM(loc_oForm.txt_4c_Text3.TabStop) + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Label2 [" + ALLTRIM(loc_oForm.lbl_4c_Label2.Caption) + "] T/L/WxH = " + ;
        TRANSFORM(loc_oForm.lbl_4c_Label2.Top) + "/" + TRANSFORM(loc_oForm.lbl_4c_Label2.Left) + "/" + ;
        TRANSFORM(loc_oForm.lbl_4c_Label2.Width) + "x" + TRANSFORM(loc_oForm.lbl_4c_Label2.Height) + ;
        "  AutoSize=" + TRANSFORM(loc_oForm.lbl_4c_Label2.AutoSize) + ;
        "  Vis=" + TRANSFORM(loc_oForm.lbl_4c_Label2.Visible) + ;
        "  Fore=" + TRANSFORM(loc_oForm.lbl_4c_Label2.ForeColor) + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Label3 [" + ALLTRIM(loc_oForm.lbl_4c_Label3.Caption) + "] T/L/WxH = " + ;
        TRANSFORM(loc_oForm.lbl_4c_Label3.Top) + "/" + TRANSFORM(loc_oForm.lbl_4c_Label3.Left) + "/" + ;
        TRANSFORM(loc_oForm.lbl_4c_Label3.Width) + "x" + TRANSFORM(loc_oForm.lbl_4c_Label3.Height) + ;
        "  AutoSize=" + TRANSFORM(loc_oForm.lbl_4c_Label3.AutoSize) + ;
        "  Vis=" + TRANSFORM(loc_oForm.lbl_4c_Label3.Visible) + CHR(13) + CHR(10)

    loc_cRel = loc_cRel + "--- VALOR EXIBIDO (o que o legado poe com Text1.Value = crTmpLgSit.col)" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Text1 (carqmovs)  = [" + TRANSFORM(loc_oForm.txt_4c_Text1.Value) + "]" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Text2 (cnumlotes) = [" + TRANSFORM(loc_oForm.txt_4c_Text2.Value) + "]" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Text3 (cemps)     = [" + TRANSFORM(loc_oForm.txt_4c_Text3.Value) + "]" + CHR(13) + CHR(10)

    loc_cRel = loc_cRel + "--- PROPERTIES DO BO (fonte unica dos valores acima)" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  ArqMovs=[" + loc_oForm.this_oBusinessObject.this_cCArqMovs + ;
        "] NumLotes=[" + loc_oForm.this_oBusinessObject.this_cCNumLotes + ;
        "] Emps=[" + loc_oForm.this_oBusinessObject.this_cCEmps + ;
        "] ImpFabs=[" + loc_oForm.this_oBusinessObject.this_cCImpFabs + "]" + CHR(13) + CHR(10)

    loc_cRel = loc_cRel + "--- GRADE E CURSOR (dentro da sessao privada do form)" + CHR(13) + CHR(10)
    loc_nSess = SET("DATASESSION")
    SET DATASESSION TO loc_oForm.DataSessionId
    IF USED("cursor_4c_Envios")
        loc_cRel = loc_cRel + "  cursor_4c_Envios RECCOUNT = " + ;
            TRANSFORM(RECCOUNT("cursor_4c_Envios")) + CHR(13) + CHR(10)
    ELSE
        loc_cRel = loc_cRel + "  cursor_4c_Envios AUSENTE" + CHR(13) + CHR(10)
    ENDIF
    SET DATASESSION TO loc_nSess
    loc_cRel = loc_cRel + "  Grid RecordSource=[" + loc_oForm.grd_4c_Dados.RecordSource + ;
        "] Col1=[" + loc_oForm.grd_4c_Dados.Column1.ControlSource + ;
        "] Col2=[" + loc_oForm.grd_4c_Dados.Column2.ControlSource + "]" + CHR(13) + CHR(10)

    loc_cRel = loc_cRel + "--- AtualizarCabecalho chamado DE FORA (metodo PUBLIC)" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  retorno = " + TRANSFORM(loc_oForm.AtualizarCabecalho()) + CHR(13) + CHR(10)

    loc_oForm.Release()
    loc_oForm = .NULL.
ENDIF

loc_cRel = loc_cRel + "--- ARQUIVO DE ERRO DE TESTE" + CHR(13) + CHR(10)
IF FILE("C:\4c\automation\_f5stc_erros.txt")
    loc_cRel = loc_cRel + FILETOSTR("C:\4c\automation\_f5stc_erros.txt") + CHR(13) + CHR(10)
ELSE
    loc_cRel = loc_cRel + "  (vazio - nenhum MsgErro/MsgAviso disparado)" + CHR(13) + CHR(10)
ENDIF

loc_cRel = loc_cRel + "FIM" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

IF gnConnHandle > 0
    =SQLDISCONNECT(gnConnHandle)
ENDIF

QUIT
