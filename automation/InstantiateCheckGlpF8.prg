*-- Fase 8 do FormSigPrGlp (task617): exercita os funis de consolidacao
*-- (CarregarLista / LigarGradeItens / FormParaBO / BOParaForm /
*-- HabilitarCampos / AjustarBotoesPorModo / LimparCampos) no VFP9 real.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_glp_f8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oPai, loc_oErro
loc_cRes = "FAIL"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg

    *-- .F. de proposito: queremos que o Init execute a carga inicial
    *-- (THIS.CarregarLista()) e nao o caminho de validacao de UI.
    gb_4c_ValidandoUI = .F.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrGlpBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrGlp.prg") ADDITIVE

    *-- Cursores que o form PAI entrega na sessao compartilhada
    CREATE CURSOR TmpFinal (Cpros C(14), CodCors C(4), CodTams C(4), ;
        Dopes C(20), Numes N(6), Saldo N(12,3), Estoque N(12,3), ;
        Produzir N(12,3), Obsps M, Emps C(3), Citens N(4), Linhas C(10))
    INSERT INTO TmpFinal (Cpros, CodCors, CodTams, Dopes, Numes, Saldo, ;
        Estoque, Produzir, Emps, Citens, Linhas) ;
        VALUES ("PROD-A", "VM", "P", "PEDIDO", 7, 100, 0, 100, "001", 1, "LINHA1")
    INSERT INTO TmpFinal (Cpros, CodCors, CodTams, Dopes, Numes, Saldo, ;
        Estoque, Produzir, Emps, Citens, Linhas) ;
        VALUES ("PROD-B", "AZ", "M", "PEDIDO", 9, 50, 0, 50, "001", 2, "LINHA2")
    GO TOP IN TmpFinal
    REPLACE Obsps WITH "obs do item A" IN TmpFinal

    CREATE CURSOR TmpSaldo (Cpros C(14), CodCors C(4), CodTams C(4), ;
        Saldo N(12,3), Disps N(12,3))
    INSERT INTO TmpSaldo VALUES ("PROD-A", "VM", "P   ", 30, 30)
    INSERT INTO TmpSaldo VALUES ("PROD-B", "AZ", "M   ", 40, 40)
    INDEX ON Cpros + CodCors + CodTams TAG Cpros

    CREATE CURSOR TmpSaldG (Priors N(2), Grupos C(10), Estos C(10), ;
        Cpros C(14), CodCors C(4), CodTams C(4), Saldo N(12,3), ;
        Disps N(12,3), Emps C(3))
    INSERT INTO TmpSaldG VALUES (1, "GRP1", "CTA1", "PROD-A", "VM", "P   ", 30, 30, "001")
    INSERT INTO TmpSaldG VALUES (1, "GRP1", "CTA1", "PROD-B", "AZ", "M   ", 40, 40, "001")
    INDEX ON Cpros + CodCors + CodTams + STR(Priors,2) + Grupos + Estos TAG Cpros

    CREATE CURSOR SelPedra (Cpros C(14), Dpros C(65), Cunis C(3), ;
        Qtds N(12,3), Cpro2s C(14))

    loc_oPai  = CREATEOBJECT("Form")
    loc_oForm = CREATEOBJECT("FormSigPrGlp", loc_oPai, loc_oPai.DataSessionId, .F., 0, .F., 0)

    IF VARTYPE(loc_oForm) != "O"
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ELSE
        loc_cRes = "FORM OK (Init executou CarregarLista)"

        *-- 1) Os 7 metodos da consolidacao existem
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- FASE 8: metodos ---" + CHR(13)+CHR(10) + ;
            "CarregarLista="       + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 5)) + ;
            " LigarGradeItens="    + TRANSFORM(PEMSTATUS(loc_oForm, "LigarGradeItens", 5)) + ;
            " FormParaBO="         + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 5)) + ;
            " BOParaForm="         + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 5)) + CHR(13)+CHR(10) + ;
            "HabilitarCampos="     + TRANSFORM(PEMSTATUS(loc_oForm, "HabilitarCampos", 5)) + ;
            " AjustarBotoesPorModo=" + TRANSFORM(PEMSTATUS(loc_oForm, "AjustarBotoesPorModo", 5)) + ;
            " LimparCampos="       + TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 5))

        *-- 2) Estado logo apos o Init (CarregarLista rodou dentro dele)
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- apos Init ---" + CHR(13)+CHR(10) + ;
            "RecordSource=[" + loc_oForm.grd_4c_Itens.RecordSource + "]" + ;
            " Totais=" + TRANSFORM(loc_oForm.txt_4c_TotQtd.Value) + "/" + ;
            TRANSFORM(loc_oForm.txt_4c_TotEst.Value) + "/" + ;
            TRANSFORM(loc_oForm.txt_4c_TotPrz.Value) + CHR(13)+CHR(10) + ;
            "RECNO(TmpFinal)=" + TRANSFORM(RECNO("TmpFinal")) + ;
            "  ObsLabel=[" + loc_oForm.lbl_4c_TxtObsItens.Caption + "]"

        *-- 3) Rebind: RecordSource perdido -> CarregarLista tem de repor
        *--    ControlSource + Width + Header (Problema 48)
        loc_oForm.grd_4c_Itens.RecordSource = ""
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- rebind via CarregarLista ---" + CHR(13)+CHR(10) + ;
            "apos limpar: RecordSource=[" + loc_oForm.grd_4c_Itens.RecordSource + "]" + ;
            " C1.Width=" + TRANSFORM(loc_oForm.grd_4c_Itens.Column1.Width) + ;
            " C6.Header=[" + loc_oForm.grd_4c_Itens.Column6.Header1.Caption + "]"
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + ;
            "CarregarLista()=" + TRANSFORM(loc_oForm.CarregarLista()) + CHR(13)+CHR(10) + ;
            "RecordSource=[" + loc_oForm.grd_4c_Itens.RecordSource + "]" + ;
            " C1.CtrlSrc=[" + loc_oForm.grd_4c_Itens.Column1.ControlSource + "]" + CHR(13)+CHR(10) + ;
            "C1.Width=" + TRANSFORM(loc_oForm.grd_4c_Itens.Column1.Width) + ;
            " C6.Width=" + TRANSFORM(loc_oForm.grd_4c_Itens.Column6.Width) + ;
            " C9.Width=" + TRANSFORM(loc_oForm.grd_4c_Itens.Column9.Width) + CHR(13)+CHR(10) + ;
            "C1.Header=[" + loc_oForm.grd_4c_Itens.Column1.Header1.Caption + "]" + ;
            " C6.Header=[" + loc_oForm.grd_4c_Itens.Column6.Header1.Caption + "]" + ;
            " C8.CtrlSrc=[" + loc_oForm.grd_4c_Itens.Column8.ControlSource + "]"

        *-- 4) BOParaForm (PROTECTED, herdado do FormBase) pelo caminho REAL:
        *--    o LostFocus da coluna Produzir. Ponteiro FORA do topo de
        *--    proposito - o metodo tem de somar tudo e devolver o RECNO.
        GO 2 IN TmpFinal
        loc_oForm.ItemProduzirLostFocus()
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- BOParaForm via ItemProduzirLostFocus (reg 2) ---" + CHR(13)+CHR(10) + ;
            "Totais=" + TRANSFORM(loc_oForm.txt_4c_TotQtd.Value) + "/" + ;
            TRANSFORM(loc_oForm.txt_4c_TotEst.Value) + "/" + ;
            TRANSFORM(loc_oForm.txt_4c_TotPrz.Value) + ;
            "  RECNO preservado=" + TRANSFORM(RECNO("TmpFinal")) + CHR(13)+CHR(10) + ;
            "Caption=[" + loc_oForm.Caption + "]" + ;
            " ObsLabel=[" + loc_oForm.lbl_4c_TxtObsItens.Caption + "]"

        *-- 5) AjustarBotoesPorModo com itens
        loc_oForm.AjustarBotoesPorModo()
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- AjustarBotoesPorModo (COM itens) ---" + CHR(13)+CHR(10) + ;
            "Processar=" + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + ;
            " TotLinha=" + TRANSFORM(loc_oForm.cmd_4c_TotLinha.Enabled) + ;
            " Disponivel=" + TRANSFORM(loc_oForm.cmd_4c_Disponivel.Enabled) + ;
            " Relatorio=" + TRANSFORM(loc_oForm.cmd_4c_BtnRelatorio.Enabled) + CHR(13)+CHR(10) + ;
            "Pedras=" + TRANSFORM(loc_oForm.cmd_4c_Pedras.Enabled) + ;
            " SelEstoque=" + TRANSFORM(loc_oForm.cmd_4c_SelEstoque.Enabled) + ;
            " Sair=" + TRANSFORM(loc_oForm.cmd_4c_Cancelar.Enabled) + ;
            " Grade=" + TRANSFORM(loc_oForm.grd_4c_Itens.Enabled) + CHR(13)+CHR(10) + ;
            "  (Pedras=.F. esperado: SigCdPam sem as 4 operacoes neste ambiente)"

        *-- 6) HabilitarCampos nos dois sentidos
        loc_oForm.HabilitarCampos(.F., .T.)
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- HabilitarCampos(.F., .T.) ---" + CHR(13)+CHR(10) + ;
            "Processar=" + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + ;
            " Sair=" + TRANSFORM(loc_oForm.cmd_4c_Cancelar.Enabled) + ;
            " TotLinha=" + TRANSFORM(loc_oForm.cmd_4c_TotLinha.Enabled) + ;
            " Pedras=" + TRANSFORM(loc_oForm.cmd_4c_Pedras.Enabled) + ;
            " Disponivel=" + TRANSFORM(loc_oForm.cmd_4c_Disponivel.Enabled) + CHR(13)+CHR(10) + ;
            "SelEstoque=" + TRANSFORM(loc_oForm.cmd_4c_SelEstoque.Enabled) + ;
            " Container3=" + TRANSFORM(loc_oForm.cnt_4c_Container3.Enabled) + ;
            " Grade=" + TRANSFORM(loc_oForm.grd_4c_Itens.Enabled)

        loc_oForm.HabilitarCampos(.T., .F.)
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- HabilitarCampos(.T., .F.) ---" + CHR(13)+CHR(10) + ;
            "Processar=" + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + ;
            " Grade=" + TRANSFORM(loc_oForm.grd_4c_Itens.Enabled) + ;
            " Container3=" + TRANSFORM(loc_oForm.cnt_4c_Container3.Enabled) + CHR(13)+CHR(10) + ;
            "SelEstoque continua .F. (fora do bloco)=" + ;
            TRANSFORM(loc_oForm.cmd_4c_SelEstoque.Enabled)

        *-- 7) FormParaBO (PROTECTED) pelo caminho REAL: BtnProcessarClick.
        *--    Sem o form AVO ele tem de RECUSAR - e a recusa eh o que
        *--    impede o Processar de gravar O.P. com previsao/geracao vazias.
        *--    Prova observavel: o form NAO eh liberado (nada foi processado).
        loc_oForm.BtnProcessarClick()
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- FormParaBO via BtnProcessarClick (sem avo) ---" + CHR(13)+CHR(10) + ;
            "form ainda vivo apos o clique=" + TRANSFORM(VARTYPE(loc_oForm) = "O") + ;
            "  previsao no BO=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_dPrevisao) + ;
            " (esperada vazia: FormParaBO abortou antes de gravar)"

        *-- 8) AjustarBotoesPorModo com a previa VAZIA (cursor existe, 0 linhas)
        SELECT TmpFinal
        ZAP
        loc_oForm.AjustarBotoesPorModo()
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- AjustarBotoesPorModo (SEM itens) ---" + CHR(13)+CHR(10) + ;
            "Processar=" + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + ;
            " TotLinha=" + TRANSFORM(loc_oForm.cmd_4c_TotLinha.Enabled) + ;
            " Relatorio=" + TRANSFORM(loc_oForm.cmd_4c_BtnRelatorio.Enabled) + ;
            " Grade=" + TRANSFORM(loc_oForm.grd_4c_Itens.Enabled) + ;
            " Sair=" + TRANSFORM(loc_oForm.cmd_4c_Cancelar.Enabled) + " (Sair sempre .T.)"

        *-- 9) LimparCampos (PROTECTED) pelo caminho REAL: CarregarLista com
        *--    cursor vazio. Prova tambem que o metodo NAO toca nos cursores
        *--    da sessao compartilhada (TmpSaldG segue intacto).
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- LimparCampos via CarregarLista (cursor vazio) ---" + CHR(13)+CHR(10) + ;
            "CarregarLista()=" + TRANSFORM(loc_oForm.CarregarLista()) + " (esperado .F.)" + CHR(13)+CHR(10) + ;
            "Totais=" + TRANSFORM(loc_oForm.txt_4c_TotQtd.Value) + "/" + ;
            TRANSFORM(loc_oForm.txt_4c_TotEst.Value) + "/" + ;
            TRANSFORM(loc_oForm.txt_4c_TotPrz.Value) + CHR(13)+CHR(10) + ;
            "C3 totais=" + TRANSFORM(loc_oForm.cnt_4c_Container3.txt_4c_TotQtd.Value) + "/" + ;
            TRANSFORM(loc_oForm.cnt_4c_Container3.txt_4c_TotEst.Value) + ;
            "  C3.Grupo=[" + loc_oForm.cnt_4c_Container3.txt_4c_GetDGrupo.Value + "]" + CHR(13)+CHR(10) + ;
            "C2.QtSelec=" + TRANSFORM(loc_oForm.cnt_4c_Container2.txt_4c_QtSelec.Value) + ;
            " C5.QtPedida=" + TRANSFORM(loc_oForm.cnt_4c_Container5.txt_4c_QtPedida.Value) + ;
            " Foto.Visible=" + TRANSFORM(loc_oForm.img_4c_ImgFigJpg.Visible) + CHR(13)+CHR(10) + ;
            "ObsLabel=[" + loc_oForm.lbl_4c_TxtObsItens.Caption + "]" + CHR(13)+CHR(10) + ;
            "cursor compartilhado intacto: TmpSaldG=" + TRANSFORM(RECCOUNT("TmpSaldG"))

        *-- 10) CarregarLista com o cursor AUSENTE (o form pai nao entregou):
        *--     avisa e nao estoura
        USE IN TmpFinal
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- CarregarLista (TmpFinal ausente) ---" + CHR(13)+CHR(10) + ;
            "retorno=" + TRANSFORM(loc_oForm.CarregarLista()) + " (esperado .F., com aviso)"

        loc_oForm.Release()
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13)+CHR(10) + "EXCECAO: " + loc_oErro.Message + ;
               " | Linha:" + TRANSFORM(loc_oErro.LineNo) + " | Proc:" + loc_oErro.Procedure
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- DIALOGOS CAPTURADOS ---" + CHR(13)+CHR(10) + ;
               FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_glp_f8.txt")
QUIT
