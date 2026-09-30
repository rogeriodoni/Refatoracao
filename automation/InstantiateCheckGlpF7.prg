SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_glp_f7.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oPai, loc_oErro, loc_nEv
LOCAL ARRAY loc_aEv[1]
loc_cRes = "FAIL"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrGlpBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrGlp.prg") ADDITIVE

    *=======================================================================
    * Cursores de trabalho que o form PAI entrega na sessao compartilhada.
    * Criados ANTES do Init para que PrepararCursoresDeTrabalho os enxergue.
    *=======================================================================
    CREATE CURSOR TmpFinal (Cpros C(14), CodCors C(4), CodTams C(4), ;
        Dopes C(20), Numes N(6), Saldo N(12,3), Estoque N(12,3), ;
        Produzir N(12,3), Obsps M, Emps C(3), Citens N(4), Linhas C(10))
    INSERT INTO TmpFinal (Cpros, CodCors, CodTams, Dopes, Numes, Saldo, ;
        Estoque, Produzir, Emps, Citens, Linhas) ;
        VALUES ("PROD-A", "VM", "", "PEDIDO", 7, 100, 0, 100, "001", 1, "LINHA1")
    INSERT INTO TmpFinal (Cpros, CodCors, CodTams, Dopes, Numes, Saldo, ;
        Estoque, Produzir, Emps, Citens, Linhas) ;
        VALUES ("PROD-B", "AZ", "M", "PEDIDO", 9, 50, 0, 50, "001", 2, "LINHA2")
    GO TOP IN TmpFinal
    REPLACE Obsps WITH "obs do item A" IN TmpFinal

    CREATE CURSOR TmpSaldo (Cpros C(14), CodCors C(4), CodTams C(4), ;
        Saldo N(12,3), Disps N(12,3))
    INSERT INTO TmpSaldo VALUES ("PROD-A", "VM", "P   ", 30, 30)
    INSERT INTO TmpSaldo VALUES ("PROD-A", "VM", "G   ", 20, 20)
    INSERT INTO TmpSaldo VALUES ("PROD-B", "AZ", "M   ", 40, 40)
    INDEX ON Cpros + CodCors + CodTams TAG Cpros

    CREATE CURSOR TmpSaldG (Priors N(2), Grupos C(10), Estos C(10), ;
        Cpros C(14), CodCors C(4), CodTams C(4), Saldo N(12,3), ;
        Disps N(12,3), Emps C(3))
    INSERT INTO TmpSaldG VALUES (1, "GRP1", "CTA1", "PROD-A", "VM", "P   ", 30, 30, "001")
    INSERT INTO TmpSaldG VALUES (2, "GRP1", "CTA2", "PROD-A", "VM", "G   ", 20, 20, "001")
    INSERT INTO TmpSaldG VALUES (1, "GRP1", "CTA1", "PROD-B", "AZ", "M   ", 40, 40, "001")
    INDEX ON Cpros + CodCors + CodTams + STR(Priors,2) + Grupos + Estos TAG Cpros

    CREATE CURSOR SelPedra (Cpros C(14), Dpros C(65), Cunis C(3), ;
        Qtds N(12,3), Cpro2s C(14))

    *-- Form pai sintetico so para compartilhar a DataSession corrente
    loc_oPai = CREATEOBJECT("Form")

    loc_oForm = CREATEOBJECT("FormSigPrGlp", loc_oPai, loc_oPai.DataSessionId, .F., 0, .F., 0)

    IF VARTYPE(loc_oForm) != "O"
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ELSE
        loc_cRes = "FORM OK  DataSessionId=" + TRANSFORM(loc_oForm.DataSessionId)

        *-- 1) Os 10 handlers existem
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- FASE 7: handlers ---" + CHR(13)+CHR(10) + ;
            "Disponivel="   + TRANSFORM(PEMSTATUS(loc_oForm, "BtnDisponivelClick", 5)) + ;
            " SelEstoque="  + TRANSFORM(PEMSTATUS(loc_oForm, "BtnSelEstoqueClick", 5)) + ;
            " TotLinha="    + TRANSFORM(PEMSTATUS(loc_oForm, "BtnTotLinhaClick", 5)) + ;
            " Pedras="      + TRANSFORM(PEMSTATUS(loc_oForm, "BtnPedrasClick", 5)) + ;
            " Relatorio="   + TRANSFORM(PEMSTATUS(loc_oForm, "BtnRelatorioClick", 5)) + CHR(13)+CHR(10) + ;
            "Cancelar="     + TRANSFORM(PEMSTATUS(loc_oForm, "BtnCancelarClick", 5)) + ;
            " ConfProd="    + TRANSFORM(PEMSTATUS(loc_oForm, "BtnConfirmarDispProdutoClick", 5)) + ;
            " ConfGrupo="   + TRANSFORM(PEMSTATUS(loc_oForm, "BtnConfirmarDispGrupoClick", 5)) + ;
            " FecharPedra=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnFecharPedrasClick", 5)) + ;
            " FecharLinha=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnFecharLinhasClick", 5))

        *-- 2) BINDEVENT de fato ligado em cada botao (AEVENTS > 0)
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- BINDEVENT (AEVENTS por botao) ---" + CHR(13)+CHR(10) + ;
            "Disponivel="   + TRANSFORM(AEVENTS(loc_aEv, loc_oForm.cmd_4c_Disponivel)) + ;
            " SelEstoque="  + TRANSFORM(AEVENTS(loc_aEv, loc_oForm.cmd_4c_SelEstoque)) + ;
            " TotLinha="    + TRANSFORM(AEVENTS(loc_aEv, loc_oForm.cmd_4c_TotLinha)) + ;
            " Pedras="      + TRANSFORM(AEVENTS(loc_aEv, loc_oForm.cmd_4c_Pedras)) + ;
            " Relatorio="   + TRANSFORM(AEVENTS(loc_aEv, loc_oForm.cmd_4c_BtnRelatorio)) + ;
            " Cancelar="    + TRANSFORM(AEVENTS(loc_aEv, loc_oForm.cmd_4c_Cancelar)) + CHR(13)+CHR(10) + ;
            "C1.CancelaLin="  + TRANSFORM(AEVENTS(loc_aEv, loc_oForm.cnt_4c_Container1.cmd_4c_CancelaLin)) + ;
            " C2.CancelaDisp=" + TRANSFORM(AEVENTS(loc_aEv, loc_oForm.cnt_4c_Container2.cmd_4c_CancelaDisp)) + ;
            " C4.CancelaDisp=" + TRANSFORM(AEVENTS(loc_aEv, loc_oForm.cnt_4c_Container4.cmd_4c_CancelaDisp)) + ;
            " C5.CancelaDisp=" + TRANSFORM(AEVENTS(loc_aEv, loc_oForm.cnt_4c_Container5.cmd_4c_CancelaDisp))

        *-- 3) PrepararCursoresDeTrabalho: efeitos observaveis
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- PrepararCursoresDeTrabalho ---" + CHR(13)+CHR(10) + ;
            "SelPedra reccount=" + TRANSFORM(RECCOUNT("SelPedra")) + ;
            "  TmpSaldU used="   + TRANSFORM(USED("TmpSaldU")) + ;
            "  TmpSaldG order=[" + ORDER("TmpSaldG") + "]" + CHR(13)+CHR(10) + ;
            "Totais Qtd/Est/Prz = " + TRANSFORM(loc_oForm.txt_4c_TotQtd.Value) + " / " + ;
            TRANSFORM(loc_oForm.txt_4c_TotEst.Value) + " / " + ;
            TRANSFORM(loc_oForm.txt_4c_TotPrz.Value) + CHR(13)+CHR(10) + ;
            "Container3 RecordSource=[" + loc_oForm.cnt_4c_Container3.grd_4c_DispConta.RecordSource + ;
            "] C4.ControlSource=[" + loc_oForm.cnt_4c_Container3.grd_4c_DispConta.Column4.ControlSource + "]"

        *-- 4) BtnTotLinhaClick (puro VFP, sem SQL)
        loc_oForm.BtnTotLinhaClick()
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- BtnTotLinhaClick ---" + CHR(13)+CHR(10) + ;
            "TmpLinha used=" + TRANSFORM(USED("TmpLinha")) + ;
            " reccount="     + TRANSFORM(IIF(USED("TmpLinha"), RECCOUNT("TmpLinha"), -1)) + ;
            " Container1.Visible=" + TRANSFORM(loc_oForm.cnt_4c_Container1.Visible) + ;
            " Processar.Enabled="  + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled)
        IF USED("TmpLinha")
            GO BOTTOM IN TmpLinha
            loc_cRes = loc_cRes + CHR(13)+CHR(10) + ;
                "ultima linha=[" + TmpLinha.Linhas + "] Saldo=" + TRANSFORM(TmpLinha.Saldo) + ;
                " RecordSource=[" + loc_oForm.cnt_4c_Container1.grd_4c_Linhas.RecordSource + "]"
        ENDIF

        *-- 5) BtnFecharLinhasClick -> RestaurarGradePrincipal
        loc_oForm.BtnFecharLinhasClick()
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- BtnFecharLinhasClick ---" + CHR(13)+CHR(10) + ;
            "Container1.Visible=" + TRANSFORM(loc_oForm.cnt_4c_Container1.Visible) + ;
            " Processar.Enabled=" + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + ;
            " Pedras.Enabled="    + TRANSFORM(loc_oForm.cmd_4c_Pedras.Enabled) + ;
            " Grade.Enabled="     + TRANSFORM(loc_oForm.grd_4c_Itens.Enabled)

        *-- 6) BtnPedrasClick (liga SelPedra)
        loc_oForm.BtnPedrasClick()
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- BtnPedrasClick ---" + CHR(13)+CHR(10) + ;
            "Container4.Visible=" + TRANSFORM(loc_oForm.cnt_4c_Container4.Visible) + ;
            " RecordSource=["     + loc_oForm.cnt_4c_Container4.grd_4c_Pedras.RecordSource + "]" + ;
            " C5.ControlSource=[" + loc_oForm.cnt_4c_Container4.grd_4c_Pedras.Column5.ControlSource + "]" + ;
            " C1.Width="          + TRANSFORM(loc_oForm.cnt_4c_Container4.grd_4c_Pedras.Column1.Width) + ;
            " C2.Header=["        + loc_oForm.cnt_4c_Container4.grd_4c_Pedras.Column2.Header1.Caption + "]" + CHR(13)+CHR(10) + ;
            "lookup ainda ligado (AEVENTS C1.Text1)=" + ;
            TRANSFORM(AEVENTS(loc_aEv, loc_oForm.cnt_4c_Container4.grd_4c_Pedras.Column1.Text1))
        loc_oForm.BtnFecharPedrasClick()

        *-- 7) BtnDisponivelClick -> TmpDisp filtrado por Produto+Cor
        GO TOP IN TmpFinal
        loc_oForm.BtnDisponivelClick()
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- BtnDisponivelClick (PROD-A/VM) ---" + CHR(13)+CHR(10) + ;
            "TmpDisp used=" + TRANSFORM(USED("TmpDisp")) + ;
            " reccount="    + TRANSFORM(IIF(USED("TmpDisp"), RECCOUNT("TmpDisp"), -1)) + ;
            " Container2.Visible=" + TRANSFORM(loc_oForm.cnt_4c_Container2.Visible) + CHR(13)+CHR(10) + ;
            "RecordSource=[" + loc_oForm.cnt_4c_Container2.grd_4c_DispProduto.RecordSource + "]" + ;
            " C3.Width="     + TRANSFORM(loc_oForm.cnt_4c_Container2.grd_4c_DispProduto.Column3.Width) + ;
            " C4.Header=["   + loc_oForm.cnt_4c_Container2.grd_4c_DispProduto.Column4.Header1.Caption + "]"

        *-- 8) BtnConfirmarDispGrupoClick: caminho 100% VFP (sem SQL).
        *--    Reusa TmpDisp (que ja tem a coluna Utilizar) marcando 10 na
        *--    primeira linha e checando a baixa em TmpFinal/TmpSaldo/
        *--    TmpSaldG/TmpSaldU.
        IF USED("TmpDisp") AND RECCOUNT("TmpDisp") > 0
            SELECT TmpDisp
            GO TOP
            REPLACE Utilizar WITH 10
            *-- TmpDisp do Disponivel nao tem Priors/Grupos/Estos; o teste do
            *-- caminho por grupo usa o cursor do SelEstoque
            SELECT TmpFinal
            GO TOP
            loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- antes do confirma por grupo ---" + CHR(13)+CHR(10) + ;
                "TmpFinal.Produzir=" + TRANSFORM(TmpFinal.Produzir) + ;
                " TmpSaldo(P).Disps=" + TRANSFORM(IIF(SEEK(PADR("PROD-A",14) + PADR("VM",4) + PADR("P",4), "TmpSaldo"), TmpSaldo.Disps, -1))
        ENDIF

        *-- SelEstoque monta TmpDisp COM Priors/Grupos/Estos
        GO TOP IN TmpFinal
        loc_oForm.BtnSelEstoqueClick()
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- BtnSelEstoqueClick (PROD-A/VM/'') ---" + CHR(13)+CHR(10) + ;
            "TmpDisp reccount=" + TRANSFORM(IIF(USED("TmpDisp"), RECCOUNT("TmpDisp"), -1)) + ;
            " Container5.Visible=" + TRANSFORM(loc_oForm.cnt_4c_Container5.Visible) + ;
            " label=[" + loc_oForm.cnt_4c_Container5.lbl_4c_Label1.Caption + "]" + CHR(13)+CHR(10) + ;
            "QtPedida=" + TRANSFORM(loc_oForm.cnt_4c_Container5.txt_4c_QtPedida.Value) + ;
            " C3.Header=[" + loc_oForm.cnt_4c_Container5.grd_4c_DispGrupo.Column3.Header1.Caption + "]" + ;
            " C3.Width=" + TRANSFORM(loc_oForm.cnt_4c_Container5.grd_4c_DispGrupo.Column3.Width)

        *-- TmpFinal linha 1 tem CodTams vazio, entao o filtro do SelEstoque
        *-- nao casa; monta TmpDisp manualmente com a mesma estrutura para
        *-- exercitar a baixa do BtnConfirmarDispGrupoClick
        IF USED("TmpDisp")
            USE IN TmpDisp
        ENDIF
        SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, ;
               000000000.000 AS Utilizar ;
          FROM TmpSaldG WHERE Cpros = "PROD-A" AND CodTams = "P   " ;
          INTO CURSOR TmpDisp READWRITE
        REPLACE Utilizar WITH 10 IN TmpDisp

        SELECT TmpFinal
        GO TOP
        REPLACE CodTams WITH "P   " IN TmpFinal

        *-- A faixa de TmpSaldG eh CONGELADA no item corrente. O Init a
        *-- montou com CodTams vazio; quem a reemite a cada troca de linha eh
        *-- o AfterRowColChange da grade principal (Fase 8). Aqui a troca de
        *-- linha eh simulada chamando o mesmo metodo que ele vai chamar.
        loc_oForm.AplicarFaixaSaldoContas()
        SELECT TmpSaldG
        GO TOP
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + ;
            "TmpSaldG na faixa do item: eof=" + TRANSFORM(EOF("TmpSaldG")) + ;
            " 1a linha Grupo/Conta=[" + IIF(EOF("TmpSaldG"), "<vazio>", ;
                ALLTRIM(TmpSaldG.Grupos) + "/" + ALLTRIM(TmpSaldG.Estos)) + "]"

        loc_oForm.BtnConfirmarDispGrupoClick()

        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- BtnConfirmarDispGrupoClick (Utilizar=10) ---" + CHR(13)+CHR(10) + ;
            "TmpFinal.Produzir=" + TRANSFORM(TmpFinal.Produzir) + ;
            " TmpFinal.Estoque=" + TRANSFORM(TmpFinal.Estoque) + CHR(13)+CHR(10) + ;
            "TmpSaldo(P).Disps=" + TRANSFORM(IIF(SEEK(PADR("PROD-A",14) + PADR("VM",4) + PADR("P",4), "TmpSaldo"), TmpSaldo.Disps, -1)) + CHR(13)+CHR(10) + ;
            "TmpSaldG(GRP1/CTA1).Disps=" + ;
            TRANSFORM(IIF(SEEK(PADR("PROD-A",14) + PADR("VM",4) + PADR("P",4) + STR(1,2) + PADR("GRP1",10) + PADR("CTA1",10), "TmpSaldG"), TmpSaldG.Disps, -1)) + CHR(13)+CHR(10) + ;
            "TmpSaldU reccount=" + TRANSFORM(RECCOUNT("TmpSaldU")) + ;
            " KeySelm=" + TRANSFORM(IIF(RECCOUNT("TmpSaldU") > 0, TmpSaldU.KeySelm, .F.)) + CHR(13)+CHR(10) + ;
            "Container5.Visible=" + TRANSFORM(loc_oForm.cnt_4c_Container5.Visible) + ;
            " SelEstoque.Enabled=" + TRANSFORM(loc_oForm.cmd_4c_SelEstoque.Enabled)

        *-- 9) BtnConfirmarDispProdutoClick: exercita o desmembramento de
        *--    TmpFinal (AFIELDS / SCATTER MEMVAR MEMO / GATHER) ate o
        *--    ponto em que precisa do SQL Server (indisponivel aqui).
        IF USED("TmpDisp")
            USE IN TmpDisp
        ENDIF
        SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
          FROM TmpSaldo WHERE Cpros = "PROD-A" AND CodTams = "G   " ;
          INTO CURSOR TmpDisp READWRITE
        REPLACE Utilizar WITH 5 IN TmpDisp

        SELECT TmpFinal
        GO TOP
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "--- BtnConfirmarDispProdutoClick (Utilizar=5) ---" + CHR(13)+CHR(10) + ;
            "ANTES: TmpFinal.Saldo=" + TRANSFORM(TmpFinal.Saldo) + ;
            " Produzir=" + TRANSFORM(TmpFinal.Produzir) + ;
            " Obsps=[" + ALLTRIM(TmpFinal.Obsps) + "]" + CHR(13)+CHR(10) + ;
            "  (1o com a guarda de conexao ativa: nada pode mudar)"
        loc_oForm.BtnConfirmarDispProdutoClick()
        SELECT TmpFinal
        GO TOP
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + ;
            "  sem conexao: Saldo=" + TRANSFORM(TmpFinal.Saldo) + ;
            " Produzir=" + TRANSFORM(TmpFinal.Produzir) + ;
            " Temporario used=" + TRANSFORM(USED("Temporario"))

        *-- 2a passada com um handle FALSO so para passar da guarda e
        *-- exercitar o desmembramento (AFIELDS / SCATTER MEMVAR MEMO /
        *-- GATHER) e a redistribuicao em TmpSaldG. O SQLEXEC vai falhar
        *-- logo depois - o que interessa aqui eh o estado ANTES dele.
        PUBLIC gnConnHandle
        gnConnHandle = 99
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + "  (2o com handle falso: exercita o desmembramento)"
        loc_oForm.BtnConfirmarDispProdutoClick()
        SELECT TmpFinal
        GO TOP
        loc_cRes = loc_cRes + CHR(13)+CHR(10) + ;
            "DEPOIS: TmpFinal.Saldo=" + TRANSFORM(TmpFinal.Saldo) + ;
            " Produzir=" + TRANSFORM(TmpFinal.Produzir) + CHR(13)+CHR(10) + ;
            "Temporario used=" + TRANSFORM(USED("Temporario")) + ;
            " reccount=" + TRANSFORM(IIF(USED("Temporario"), RECCOUNT("Temporario"), -1))
        IF USED("Temporario")
            SELECT Temporario
            GO TOP
            loc_cRes = loc_cRes + CHR(13)+CHR(10) + ;
                "Temporario: Cpros=[" + Temporario.Cpros + "] CodTams=[" + Temporario.CodTams + ;
                "] Saldo=" + TRANSFORM(Temporario.Saldo) + ;
                " Estoque=" + TRANSFORM(Temporario.Estoque) + ;
                " Produzir=" + TRANSFORM(Temporario.Produzir) + ;
                " Obsps=[" + ALLTRIM(Temporario.Obsps) + "]"
        ENDIF

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

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_glp_f7.txt")
QUIT
