*-- Probe Fase 7 - task753 / FormSigOpIpB
*-- Prova: (1) o form INSTANCIA com os 5 BINDEVENT novos (bind com delegate
*-- inexistente estouraria aqui), (2) os BINDEVENT estao REGISTRADOS nos
*-- objetos certos, (3) os 8 metodos novos existem e com o escopo certo,
*-- (4) SelecionarImpressoraCorrente tem semantica de RADIO (marcar uma
*-- DESMARCA as outras) e (5) GradeNomeImpressoraLostFocus roda sem estourar
*-- com celula vazia e com o form nao exibido.
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f7_753_probe_dialogs.txt"
gnConnHandle           = 0

LOCAL lcOut, loForm, loErro, lnI, lcMarcadas, lnMarcadas, lcEol
lcEol = CHR(13) + CHR(10)
lcOut = ""

DO config.prg

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SigOpIpBBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpIpB.prg") ADDITIVE

lcOut = lcOut + "DEPENDENCIAS CARREGADAS" + lcEol

*-- O form PAI monta o cursor ANTES de abrir a tela (SIGCDTBI / sigopcgv).
*-- Reproduzido aqui com TRES linhas e DUAS marcadas, que eh o estado real
*-- de entrada: o pai marca toda impressora que achou.
CREATE CURSOR cursor_4c_Impressoras ;
    (Impres C(30), lSituas L, lMarcas L, nTpImpres N(4,0))
INDEX ON Impres TAG Impres
INDEX ON Impres FOR lSituas TAG Imprime
SET ORDER TO TAG Impres

INSERT INTO cursor_4c_Impressoras (Impres, lSituas, lMarcas, nTpImpres) ;
    VALUES ("ZEBRA ZT230", .T., .T., 1)
INSERT INTO cursor_4c_Impressoras (Impres, lSituas, lMarcas, nTpImpres) ;
    VALUES ("ARGOX OS-214", .T., .T., 1)
INSERT INTO cursor_4c_Impressoras (Impres, lSituas, lMarcas, nTpImpres) ;
    VALUES ("HP LASERJET 1020", .F., .T., 2)

lcOut = lcOut + "CURSOR DO PAI: RECCOUNT=" + ;
    TRANSFORM(RECCOUNT("cursor_4c_Impressoras")) + lcEol

TRY
    loForm = CREATEOBJECT("FormSigOpIpB")

    lcOut = lcOut + "VARTYPE(loForm)       = " + VARTYPE(loForm) + lcEol

    IF VARTYPE(loForm) = "O"
        lcOut = lcOut + "BaseClass             = " + loForm.BaseClass + lcEol
        lcOut = lcOut + "Caption               = [" + loForm.Caption + "]" + lcEol

        *-- (3) os metodos da Fase 7: existencia (5) e escopo PROTECTED (2)
        lcOut = lcOut + "--- METODOS DA FASE 7 ---" + lcEol
        lcOut = lcOut + "ConfigurarEventosGrade       ex=" + ;
            TRANSFORM(PEMSTATUS(loForm, "ConfigurarEventosGrade", 5)) + ;
            " prot=" + TRANSFORM(PEMSTATUS(loForm, "ConfigurarEventosGrade", 2)) + lcEol
        lcOut = lcOut + "GradeNomeImpressoraLostFocus ex=" + ;
            TRANSFORM(PEMSTATUS(loForm, "GradeNomeImpressoraLostFocus", 5)) + ;
            " prot=" + TRANSFORM(PEMSTATUS(loForm, "GradeNomeImpressoraLostFocus", 2)) + lcEol
        lcOut = lcOut + "SelecionarImpressoraCorrente ex=" + ;
            TRANSFORM(PEMSTATUS(loForm, "SelecionarImpressoraCorrente", 5)) + ;
            " prot=" + TRANSFORM(PEMSTATUS(loForm, "SelecionarImpressoraCorrente", 2)) + lcEol
        lcOut = lcOut + "ChkImpressoraKeyPress        ex=" + ;
            TRANSFORM(PEMSTATUS(loForm, "ChkImpressoraKeyPress", 5)) + ;
            " prot=" + TRANSFORM(PEMSTATUS(loForm, "ChkImpressoraKeyPress", 2)) + lcEol
        lcOut = lcOut + "ChkImpressoraMouseUp         ex=" + ;
            TRANSFORM(PEMSTATUS(loForm, "ChkImpressoraMouseUp", 5)) + ;
            " prot=" + TRANSFORM(PEMSTATUS(loForm, "ChkImpressoraMouseUp", 2)) + lcEol
        lcOut = lcOut + "ChkImpressoraMouseDown       ex=" + ;
            TRANSFORM(PEMSTATUS(loForm, "ChkImpressoraMouseDown", 5)) + lcEol
        lcOut = lcOut + "ChkImpressoraClick           ex=" + ;
            TRANSFORM(PEMSTATUS(loForm, "ChkImpressoraClick", 5)) + lcEol
        lcOut = lcOut + "RepintarGrade                ex=" + ;
            TRANSFORM(PEMSTATUS(loForm, "RepintarGrade", 5)) + ;
            " prot=" + TRANSFORM(PEMSTATUS(loForm, "RepintarGrade", 2)) + lcEol

        *-- (2) BINDEVENT efetivamente registrado nos objetos certos
        lcOut = lcOut + "--- BINDEVENT REGISTRADOS ---" + lcEol
        LOCAL ARRAY laEvT1[1,5], laEvCk[1,5]
        lcOut = lcOut + "Column1.Text1  nEventos=" + ;
            TRANSFORM(AEVENTS(laEvT1, loForm.grd_4c_Dados.Column1.Text1)) + lcEol
        IF TYPE("laEvT1[1,3]") = "C"
            FOR lnI = 1 TO ALEN(laEvT1, 1)
                lcOut = lcOut + "   [" + laEvT1[lnI,3] + "] -> " + laEvT1[lnI,4] + lcEol
            ENDFOR
        ENDIF
        lcOut = lcOut + "Column2.Check  nEventos=" + ;
            TRANSFORM(AEVENTS(laEvCk, loForm.grd_4c_Dados.Column2.chk_4c_Check1)) + lcEol
        IF TYPE("laEvCk[1,3]") = "C"
            FOR lnI = 1 TO ALEN(laEvCk, 1)
                lcOut = lcOut + "   [" + laEvCk[lnI,3] + "] -> " + laEvCk[lnI,4] + lcEol
            ENDFOR
        ENDIF

        *-- Estado depois da abertura: PrepararSelecaoInicial marcou SO a 1a
        lcOut = lcOut + "--- APOS ABERTURA ---" + lcEol
        lcOut = lcOut + "Grid RecordSource     = [" + ;
            loForm.grd_4c_Dados.RecordSource + "]" + lcEol
        lcOut = lcOut + "Col1 ControlSource    = [" + ;
            loForm.grd_4c_Dados.Column1.ControlSource + "]" + lcEol
        lcOut = lcOut + "Col2 ControlSource    = [" + ;
            loForm.grd_4c_Dados.Column2.ControlSource + "]" + lcEol
        lcOut = lcOut + "Col2 CurrentControl   = [" + ;
            loForm.grd_4c_Dados.Column2.CurrentControl + "]" + lcEol

        SELECT cursor_4c_Impressoras
        lcMarcadas = ""
        lnMarcadas = 0
        SCAN
            IF lSituas
                lnMarcadas = lnMarcadas + 1
                lcMarcadas = lcMarcadas + ALLTRIM(Impres) + "/"
            ENDIF
        ENDSCAN
        lcOut = lcOut + "marcadas=" + TRANSFORM(lnMarcadas) + " [" + lcMarcadas + "]" + lcEol

        *-- (4) RADIO: escolher a TERCEIRA linha da ordem alfabetica
        lcOut = lcOut + "--- ESCOLHA NA LINHA 3 (RADIO) ---" + lcEol
        SELECT cursor_4c_Impressoras
        GO TOP
        SKIP 2
        lcOut = lcOut + "RECNO antes           = " + TRANSFORM(RECNO()) + ;
            "  Impres=[" + ALLTRIM(Impres) + "]" + lcEol

        lcOut = lcOut + "SelecionarCorrente    = " + ;
            TRANSFORM(loForm.SelecionarImpressoraCorrente()) + lcEol

        lcMarcadas = ""
        lnMarcadas = 0
        SELECT cursor_4c_Impressoras
        SCAN
            IF lSituas
                lnMarcadas = lnMarcadas + 1
                lcMarcadas = lcMarcadas + ALLTRIM(Impres) + "/"
            ENDIF
        ENDSCAN
        lcOut = lcOut + "marcadas=" + TRANSFORM(lnMarcadas) + " [" + lcMarcadas + "]" + lcEol
        lcOut = lcOut + "BO.selecionada        = [" + ;
            loForm.this_oBusinessObject.this_cImpressoraSelecionada + "]" + lcEol

        *-- IDEMPOTENCIA: repetir na MESMA linha nao pode desmarcar
        loForm.SelecionarImpressoraCorrente()
        lnMarcadas = 0
        SELECT cursor_4c_Impressoras
        SCAN
            IF lSituas
                lnMarcadas = lnMarcadas + 1
            ENDIF
        ENDSCAN
        lcOut = lcOut + "2a vez: marcadas      = " + TRANSFORM(lnMarcadas) + lcEol

        *-- (5) LostFocus com celula VAZIA, form NAO exibido: nao estoura
        lcOut = lcOut + "--- LOSTFOCUS ---" + lcEol
        loForm.grd_4c_Dados.Column1.Text1.Value = ""
        loForm.GradeNomeImpressoraLostFocus()
        lcOut = lcOut + "LostFocus vazio       = OK (sem excecao)" + lcEol
        loForm.grd_4c_Dados.Column1.Text1.Value = "ZEBRA ZT230"
        loForm.GradeNomeImpressoraLostFocus()
        lcOut = lcOut + "LostFocus preenchido  = OK (sem excecao)" + lcEol

        *-- KeyPress: Espaco age, outra tecla nao
        lcOut = lcOut + "--- KEYPRESS ---" + lcEol
        SELECT cursor_4c_Impressoras
        GO TOP
        loForm.ChkImpressoraKeyPress(32, 0)
        lcOut = lcOut + "Espaco -> selecionada = [" + ;
            loForm.this_oBusinessObject.this_cImpressoraSelecionada + "]" + lcEol
        SELECT cursor_4c_Impressoras
        GO BOTTOM
        loForm.ChkImpressoraKeyPress(65, 0)
        lcOut = lcOut + "Tecla A -> selecionada= [" + ;
            loForm.this_oBusinessObject.this_cImpressoraSelecionada + "]" + ;
            "  (deve seguir a do Espaco)" + lcEol

        loForm.Release()
        loForm = .NULL.
        lcOut = lcOut + "RELEASE OK" + lcEol
    ENDIF
CATCH TO loErro
    lcOut = lcOut + "EXCECAO: " + loErro.Message + lcEol + ;
        "Linha: " + TRANSFORM(loErro.LineNo) + lcEol + ;
        "Procedure: " + loErro.Procedure + lcEol
ENDTRY

STRTOFILE(lcOut, "C:\4c\automation\_f7_753_probe.txt")
QUIT
