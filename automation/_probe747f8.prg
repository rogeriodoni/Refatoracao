*-- Probe de instanciacao e exercicio da Fase 8 do FormSigOpIgm (task747).
*-- Carrega a mao so o que o form usa (ConfigurarAmbiente nao retorna aqui).
*-- Prova: (1) Init/InicializarForm roda inteiro com os 4 BINDEVENT novos do
*-- Check1; (2) escopo dos metodos novos; (3) os 4 eventos ligados no Check1;
*-- (4) a tabela de verdade do Click legado (if !printed -> force .t.);
*-- (5) AjustarBotoesPorModo/HabilitarCampos; (6) ValidarLoteImpressao;
*-- (7) BtnImprimirClick com linha Docus=2 (nenhum dialogo filho -> sem modal).
SET SAFETY OFF
SET RESOURCE OFF

LOCAL lcOut, loForm, lcSaida, lcMet, lnI, lnEv, loErro
LOCAL ARRAY laEv[1]
lcSaida = "C:\4c\automation\_probe747f8_resultado.txt"
lcOut   = ""

DO ("C:\4c\projeto\app\start\config.prg")

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")         ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")        ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")        ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg")      ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpIgmBO.prg")        ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms   + "operacionais\FormSigOpIgm.prg") ADDITIVE

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe747f8_dialogs.txt"
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"
STRTOFILE("", gc_4c_ArquivoErroTeste)
PUBLIC pcCk
pcCk = "C:\4c\automation\_probe747f8_ck.txt"
STRTOFILE("CK00 ambiente ok" + CHR(13) + CHR(10), pcCk)
ON ERROR STRTOFILE("ONERROR: " + MESSAGE() + " LN=" + TRANSFORM(LINENO()) + CHR(13) + CHR(10), pcCk, 1)

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSigOpIgm")
CATCH TO loErro
    lcOut = lcOut + "EXCECAO NO CREATEOBJECT: " + loErro.Message + ;
            " LN=" + TRANSFORM(loErro.LineNo) + " PROC=" + loErro.Procedure + CHR(13) + CHR(10)
ENDTRY

lcOut = lcOut + "VARTYPE(loForm) = " + VARTYPE(loForm) + CHR(13) + CHR(10)

IF VARTYPE(loForm) = "O"
    lcOut = lcOut + "INSTANCIACAO = OK" + CHR(13) + CHR(10)

    *-- (2) escopo
    lcOut = lcOut + "--- (2) metodos: existe / protegido ---" + CHR(13) + CHR(10)
    FOR lnI = 1 TO 10
        lcMet = GETWORDNUM("ChkMarcaKeyPress ChkMarcaMouseUp ChkMarcaMouseDown ChkMarcaClick " + ;
            "AjustarBotoesPorModo HabilitarCampos ValidarLoteImpressao CarregarLista " + ;
            "FormParaBO BOParaForm", lnI)
        lcOut = lcOut + "  " + PADR(lcMet, 22) + " existe=" + TRANSFORM(PEMSTATUS(loForm, lcMet, 5)) + ;
                "  protegido=" + TRANSFORM(PEMSTATUS(loForm, lcMet, 2)) + CHR(13) + CHR(10)
    ENDFOR
    lcOut = lcOut + "  (esperado: os 8 primeiros protegido=.F.; FormParaBO/BOParaForm=.T.)" + CHR(13) + CHR(10)

    *-- (3) BINDEVENT no Check1 da Column1
    lnEv = AEVENTS(laEv, loForm.grd_4c_Dados.Column1.Check1)
    lcOut = lcOut + "--- (3) eventos ligados no Check1 = " + TRANSFORM(lnEv) + " (esperado 4) ---" + CHR(13) + CHR(10)
    FOR lnI = 1 TO lnEv
        lcOut = lcOut + "  " + laEv[lnI, 2] + " -> " + laEv[lnI, 4] + CHR(13) + CHR(10)
    ENDFOR
    lcOut = lcOut + "  CurrentControl=[" + loForm.grd_4c_Dados.Column1.CurrentControl + "]" + ;
            " Sparse=" + TRANSFORM(loForm.grd_4c_Dados.Column1.Sparse) + ;
            " ControlSource=[" + loForm.grd_4c_Dados.Column1.ControlSource + "]" + CHR(13) + CHR(10)

    *-- (6a) grade vazia -> ValidarLoteImpressao recusa
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    lcOut = lcOut + "--- (6a) ValidarLoteImpressao com grade VAZIA = " + ;
            TRANSFORM(loForm.ValidarLoteImpressao("Impressao")) + " (esperado .F.) ---" + CHR(13) + CHR(10)
    lcOut = lcOut + "  dialogo: " + STRTRAN(STRTRAN(FILETOSTR(gc_4c_ArquivoErroTeste), CHR(13), " "), CHR(10), " ") + CHR(13) + CHR(10)

    *-- (4) tabela de verdade do Click legado
    lcOut = lcOut + "--- (4) ChkMarcaKeyPress(32): Printed/Marca antes -> depois ---" + CHR(13) + CHR(10)
    SELECT cursor_4c_Pgto
    INSERT INTO cursor_4c_Pgto (Marca, Obs, Printed, Valos, Emps, Dopes, Numes, Valdevs, Docus) ;
        VALUES (.T., "LINHA 1", .F., 10.00, "001", PADR("MALOTE", 20), 1, 0, 2)
    INSERT INTO cursor_4c_Pgto (Marca, Obs, Printed, Valos, Emps, Dopes, Numes, Valdevs, Docus) ;
        VALUES (.F., "LINHA 2", .F., 20.00, "001", PADR("MALOTE", 20), 2, 0, 2)
    INSERT INTO cursor_4c_Pgto (Marca, Obs, Printed, Valos, Emps, Dopes, Numes, Valdevs, Docus) ;
        VALUES (.T., "LINHA 3", .T., 30.00, "001", PADR("MALOTE", 20), 3, 0, 2)
    INSERT INTO cursor_4c_Pgto (Marca, Obs, Printed, Valos, Emps, Dopes, Numes, Valdevs, Docus) ;
        VALUES (.F., "LINHA 4", .T., 40.00, "001", PADR("MALOTE", 20), 4, 0, 2)
    FOR lnI = 1 TO 4
        SELECT cursor_4c_Pgto
        GO lnI
        lcOut = lcOut + "  rec " + TRANSFORM(lnI) + " Printed=" + TRANSFORM(cursor_4c_Pgto.Printed) + ;
                " Marca=" + TRANSFORM(cursor_4c_Pgto.Marca)
        loForm.ChkMarcaKeyPress(32, 0)
        SELECT cursor_4c_Pgto
        GO lnI
        lcOut = lcOut + " -> Marca=" + TRANSFORM(cursor_4c_Pgto.Marca) + CHR(13) + CHR(10)
    ENDFOR
    lcOut = lcOut + "  (esperado: rec1 .T.->.T. | rec2 .F.->.T. | rec3 .T.->.F. | rec4 .F.->.T.)" + CHR(13) + CHR(10)

    *-- MouseUp redireciona para o KeyPress
    SELECT cursor_4c_Pgto
    GO 3
    lcOut = lcOut + "  MouseUp em rec3: Marca=" + TRANSFORM(cursor_4c_Pgto.Marca)
    loForm.ChkMarcaMouseUp(1, 0, 0, 0)
    SELECT cursor_4c_Pgto
    GO 3
    lcOut = lcOut + " -> " + TRANSFORM(cursor_4c_Pgto.Marca) + CHR(13) + CHR(10)

    *-- (5) AjustarBotoesPorModo / HabilitarCampos
    lcOut = lcOut + "--- (5) estado dos botoes x this_lProcessandoLote ---" + CHR(13) + CHR(10)
    loForm.this_lProcessandoLote = .T.
    loForm.AjustarBotoesPorModo()
    lcOut = lcOut + "  lote=.T. Boleto=" + TRANSFORM(loForm.cmd_4c_BtnBoleto.Enabled) + ;
            " Imprimir=" + TRANSFORM(loForm.cmd_4c_Imprimir.Enabled) + ;
            " Grade=" + TRANSFORM(loForm.cmd_4c_Grade.Enabled) + ;
            " Sair=" + TRANSFORM(loForm.cmd_4c_Sair.Enabled) + ;
            " Col1.ReadOnly=" + TRANSFORM(loForm.grd_4c_Dados.Column1.ReadOnly) + CHR(13) + CHR(10)
    loForm.this_lProcessandoLote = .F.
    loForm.AjustarBotoesPorModo()
    lcOut = lcOut + "  lote=.F. Boleto=" + TRANSFORM(loForm.cmd_4c_BtnBoleto.Enabled) + ;
            " Imprimir=" + TRANSFORM(loForm.cmd_4c_Imprimir.Enabled) + ;
            " Grade=" + TRANSFORM(loForm.cmd_4c_Grade.Enabled) + ;
            " Sair=" + TRANSFORM(loForm.cmd_4c_Sair.Enabled) + ;
            " Col1.ReadOnly=" + TRANSFORM(loForm.grd_4c_Dados.Column1.ReadOnly) + CHR(13) + CHR(10)

    *-- a guarda de lote tambem bloqueia o teclado
    loForm.this_lProcessandoLote = .T.
    SELECT cursor_4c_Pgto
    GO 2
    lcOut = lcOut + "  com lote=.T. ChkMarcaKeyPress: Marca=" + TRANSFORM(cursor_4c_Pgto.Marca)
    loForm.ChkMarcaKeyPress(32, 0)
    SELECT cursor_4c_Pgto
    GO 2
    lcOut = lcOut + " -> " + TRANSFORM(cursor_4c_Pgto.Marca) + " (nao deve mudar)" + CHR(13) + CHR(10)
    loForm.this_lProcessandoLote = .F.
    loForm.AjustarBotoesPorModo()

    *-- (6b) grade com linhas -> ValidarLoteImpressao aceita
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    lcOut = lcOut + "--- (6b) ValidarLoteImpressao com 4 linhas = " + ;
            TRANSFORM(loForm.ValidarLoteImpressao("Impressao")) + " (esperado .T.) ---" + CHR(13) + CHR(10)
    lcOut = lcOut + "  dialogo: [" + STRTRAN(STRTRAN(FILETOSTR(gc_4c_ArquivoErroTeste), CHR(13), " "), CHR(10), " ") + "]" + CHR(13) + CHR(10)

    *-- (7) BtnImprimirClick: Docus=2 nao casa nenhum ramo -> so marca
    lcOut = lcOut + "--- (7) BtnImprimirClick (Docus=2: sem dialogo filho) ---" + CHR(13) + CHR(10)
    SELECT cursor_4c_Pgto
    REPLACE ALL Marca WITH .T., Printed WITH .F.
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    TRY
        loForm.BtnImprimirClick()
        lcOut = lcOut + "  voltou sem excecao" + CHR(13) + CHR(10)
    CATCH TO loErro
        lcOut = lcOut + "  EXCECAO: " + loErro.Message + " LN=" + TRANSFORM(loErro.LineNo) + ;
                " PROC=" + loErro.Procedure + CHR(13) + CHR(10)
    ENDTRY
    lcOut = lcOut + "  marcadas depois=" + TRANSFORM(loForm.this_oBusinessObject.ContarMarcadas()) + ;
            " (esperado 0)  lote=" + TRANSFORM(loForm.this_lProcessandoLote) + " (esperado .F.)" + CHR(13) + CHR(10)
    SELECT cursor_4c_Pgto
    GO TOP
    lcOut = lcOut + "  rec1 Printed=" + TRANSFORM(cursor_4c_Pgto.Printed) + " (esperado .T.)" + CHR(13) + CHR(10)
    lcOut = lcOut + "  Imprimir.Enabled=" + TRANSFORM(loForm.cmd_4c_Imprimir.Enabled) + " (esperado .T.)" + CHR(13) + CHR(10)
    lcOut = lcOut + "  dialogo: [" + STRTRAN(STRTRAN(FILETOSTR(gc_4c_ArquivoErroTeste), CHR(13), " "), CHR(10), " ") + "]" + CHR(13) + CHR(10)

    *-- (8) KeyPress do form (F3 = Grade) nao estoura
    lcOut = lcOut + "--- (8) KeyPress do form ---" + CHR(13) + CHR(10)
    TRY
        loForm.KeyPress(-2, 0)
        lcOut = lcOut + "  F3 (Grade) ok" + CHR(13) + CHR(10)
    CATCH TO loErro
        lcOut = lcOut + "  F3 EXCECAO: " + loErro.Message + " PROC=" + loErro.Procedure + CHR(13) + CHR(10)
    ENDTRY

    loForm.Release()
    lcOut = lcOut + "RELEASE OK" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcOut, lcSaida)
QUIT
