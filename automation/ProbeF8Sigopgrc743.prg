* ProbeF8Sigopgrc743.prg
* Prova a Fase 8 do FormSIGOPGRC de ponta a ponta, com form PAI falso e um
* crFinal REAL: o form entra na data session do pai, o BO agrega o cursor, o
* form cria o cursor do campo General e tenta o APPEND GENERAL.
*
* NAO chama ConfigurarAmbiente() - ela nao retorna nesta maquina.
* MsGraph.Chart NAO esta registrado aqui: o caminho de FALHA de OLE eh
* justamente um dos itens sob teste (a tela tem de AVISAR, nunca exibir ou
* imprimir grafico vazio como se fosse resultado valido).
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cOut, loc_oForm, loc_oPai, loc_oBO, loc_oErro
loc_cOut = "C:\4c\automation\probe_f8_sigopgrc743_resultado.txt"
STRTOFILE("[1] inicio" + CHR(13) + CHR(10), loc_cOut)

DO LOCFILE("C:\4c\projeto\app\start\config.prg")

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_f8_sigopgrc743_dialogs.txt"
*-- .F. DE PROPOSITO: eh o GerarGrafico que esta sob teste
gb_4c_ValidandoUI      = .F.
STRTOFILE("", gc_4c_ArquivoErroTeste)

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SIGOPGRCBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGOPGRC.prg") ADDITIVE
STRTOFILE("[2] ambiente OK  DataSession corrente=" + TRANSFORM(SET("Datasession")) + ;
    CHR(13) + CHR(10), loc_cOut, 1)

*==========================================================================
* crFinal - o cursor que o form PAI deixa pronto. Colunas lidas pelo BO:
* Mes/Ordem/Ano/Grupos/Total/npercs (series) e dtini/dtfinal/lcGrupo1/
* lcGrupo2/lcMoe (subtitulos). Os tags Grupom e imp nao existem no acervo
* (o form pai nao foi migrado): aqui sao criados com as ORDENACOES que o
* legado pressupoe - Grupom percorre por Mes, imp percorre por grupo.
*==========================================================================
CREATE CURSOR crFinal ( ;
    Mes      N(2,0), ;
    Ordem    N(1,0), ;
    Ano      N(4,0), ;
    Grupos   C(20),  ;
    Total    N(12,2),;
    npercs   N(6,0), ;
    dtini    D,      ;
    dtfinal  D,      ;
    lcGrupo1 C(20),  ;
    lcGrupo2 C(20),  ;
    lcMoe    C(10))

INSERT INTO crFinal VALUES (1, 1, 2025, "GRUPO A", 100, 10, {^2025-01-01}, {^2026-12-31}, "Matriz", "Filial", "REAL")
INSERT INTO crFinal VALUES (2, 1, 2025, "GRUPO A", 200, 20, {^2025-01-01}, {^2026-12-31}, "Matriz", "Filial", "REAL")
INSERT INTO crFinal VALUES (1, 2, 2026, "GRUPO B", 300, 30, {^2025-01-01}, {^2026-12-31}, "Matriz", "Filial", "REAL")
INSERT INTO crFinal VALUES (2, 2, 2026, "GRUPO B", 400, 40, {^2025-01-01}, {^2026-12-31}, "Matriz", "Filial", "REAL")

SELECT crFinal
INDEX ON STR(Mes, 2) + Grupos               TAG Grupom
INDEX ON Grupos + STR(Ano, 4) + STR(Mes, 2) TAG imp
SET ORDER TO
GO TOP
STRTOFILE("[3] crFinal criado  n=" + TRANSFORM(RECCOUNT("crFinal")) + ;
    "  tagGrupom=" + TRANSFORM(TAGNO("Grupom", "", "crFinal")) + ;
    "  tagImp="    + TRANSFORM(TAGNO("imp", "", "crFinal")) + CHR(13) + CHR(10), loc_cOut, 1)

*==========================================================================
* Form PAI falso: so os tres membros que o legado le/escreve -
* Comparativo.Value, OptCotacao.Value e Aguarde.Visible.
*==========================================================================
loc_oPai = CREATEOBJECT("Form")
loc_oPai.AddObject("Comparativo", "TextBox")
loc_oPai.Comparativo.Value = 1
loc_oPai.AddObject("OptCotacao", "TextBox")
loc_oPai.OptCotacao.Value = 1
loc_oPai.AddObject("Aguarde", "Label")
loc_oPai.Aguarde.Visible = .T.
STRTOFILE("[4] pai falso  DataSessionId=" + TRANSFORM(loc_oPai.DataSessionId) + ;
    "  Aguarde.Visible=" + TRANSFORM(loc_oPai.Aguarde.Visible) + CHR(13) + CHR(10), loc_cOut, 1)

*==========================================================================
* Instanciacao. Sem Show(): a tela eh WindowType = 1 e o Show BLOQUEIA.
*==========================================================================
loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSIGOPGRC", loc_oPai, loc_oPai.DataSessionId)
CATCH TO loc_oErro
    STRTOFILE("[X] CREATEOBJECT estourou: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10), loc_cOut, 1)
ENDTRY

STRTOFILE("[5] VARTYPE(form)=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), loc_cOut, 1)

IF VARTYPE(loc_oForm) = "O"
    loc_oBO = loc_oForm.this_oBusinessObject

    STRTOFILE("[6] DataSessionId form=" + TRANSFORM(loc_oForm.DataSessionId) + ;
        " (pai=" + TRANSFORM(loc_oPai.DataSessionId) + ")" + ;
        "  enxerga crFinal=" + TRANSFORM(USED("crFinal")) + CHR(13) + CHR(10), loc_cOut, 1)

    *-- A1: alias do cursor do grafico tem de ser o que o FRX cita
    STRTOFILE("A1 alias_grafico=[" + ALLTRIM(loc_oBO.this_cCursorGrafico) + "]" + ;
        "  esperado=[Graph]  campo=[" + ALLTRIM(loc_oBO.this_cCampoGeral) + "]" + ;
        "  USED=" + TRANSFORM(USED(ALLTRIM(loc_oBO.this_cCursorGrafico))) + ;
        CHR(13) + CHR(10), loc_cOut, 1)

    *-- A2: contagens de serie e de coluna
    STRTOFILE("A2 TotalMeses=" + TRANSFORM(loc_oBO.this_nTotalMeses) + " (esp 2)" + ;
        "  TotalGrupos=" + TRANSFORM(loc_oBO.this_nTotalGrupos) + " (esp 2)" + ;
        CHR(13) + CHR(10), loc_cOut, 1)

    *-- A3: ordem dos grupos (o Order By 1 reposto nesta fase)
    IF USED(ALLTRIM(loc_oBO.this_cCursorGrupos))
        SELECT (ALLTRIM(loc_oBO.this_cCursorGrupos))
        GO TOP
        STRTOFILE("A3 grupos_ordenados=[", loc_cOut, 1)
        SCAN
            STRTOFILE(ALLTRIM(EVALUATE(ALIAS() + ".cGrupos")) + " ", loc_cOut, 1)
        ENDSCAN
        STRTOFILE("]  esperado=[12025 22026]" + CHR(13) + CHR(10), loc_cOut, 1)
    ENDIF

    *-- A4: matriz de percentuais por posicao (grupo, mes)
    STRTOFILE("A4 perc(1,1)=" + TRANSFORM(loc_oBO.ObterPercentual(1, 1)) + " (esp 10)" + ;
        "  perc(1,2)=" + TRANSFORM(loc_oBO.ObterPercentual(1, 2)) + " (esp 20)" + ;
        "  perc(2,1)=" + TRANSFORM(loc_oBO.ObterPercentual(2, 1)) + " (esp 30)" + ;
        "  perc(2,2)=" + TRANSFORM(loc_oBO.ObterPercentual(2, 2)) + " (esp 40)" + ;
        "  perc(9,9)=" + TRANSFORM(loc_oBO.ObterPercentual(9, 9)) + " (esp 0)" + ;
        CHR(13) + CHR(10), loc_cOut, 1)

    *-- A5: subtitulos montados a partir do PROPRIO crFinal
    STRTOFILE("A5 Titulo=[" + ALLTRIM(loc_oBO.this_cTitulo) + "]" + CHR(13) + CHR(10) + ;
        "   Sub1=[" + ALLTRIM(loc_oBO.this_cSubTitulo1) + "]" + CHR(13) + CHR(10) + ;
        "   Sub2=[" + ALLTRIM(loc_oBO.this_cSubTitulo2) + "]" + CHR(13) + CHR(10) + ;
        "   Sub3=[" + ALLTRIM(loc_oBO.this_cSubTitulo3) + "]" + CHR(13) + CHR(10), loc_cOut, 1)

    *-- A6: matriz TAB/CRLF das series (lcStrg do legado), com TAB e CRLF
    *--     trocados por marcador visivel
    STRTOFILE("A6 DadosValidos=" + TRANSFORM(loc_oBO.this_lDadosValidos) + ;
        "  len=" + TRANSFORM(LEN(loc_oBO.this_cDadosGrafico)) + CHR(13) + CHR(10) + ;
        "   matriz=[" + STRTRAN(STRTRAN(loc_oBO.this_cDadosGrafico, CHR(9), "<TAB>"), ;
            CHR(13) + CHR(10), "<CRLF>") + "]" + CHR(13) + CHR(10), loc_cOut, 1)

    *-- A7: caminho de FALHA de OLE - MsGraph.Chart ausente nesta estacao
    STRTOFILE("A7 GraficoGerado=" + TRANSFORM(loc_oBO.this_lGraficoGerado) + " (esp .F. aqui)" + ;
        "  GraficoPronto=" + TRANSFORM(loc_oForm.this_lGraficoPronto) + " (esp .F. aqui)" + ;
        "  RECCOUNT(Graph)=" + TRANSFORM(IIF(USED("Graph"), RECCOUNT("Graph"), -1)) + ;
        " <- conta o registro EXCLUIDO, eh por isso que o guard eh o flag" + ;
        "  ControlSource=[" + loc_oForm.obj_4c_OleGrafico.ControlSource + "]" + ;
        CHR(13) + CHR(10), loc_cOut, 1)

    *-- A8: o painel Aguarde do pai foi apagado em caminho de FALHA tambem
    STRTOFILE("A8 pai.Aguarde.Visible=" + TRANSFORM(loc_oPai.Aguarde.Visible) + " (esp .F.)" + ;
        CHR(13) + CHR(10), loc_cOut, 1)

    *-- A9: Imprimir NAO pode mandar relatorio em branco para a impressora
    loc_oForm.CmdImprimirClick()
    STRTOFILE("A9 CmdImprimirClick executado (ver dialogs: tem de AVISAR, nao imprimir)" + ;
        CHR(13) + CHR(10), loc_cOut, 1)

    *-- A10: visibilidade dos metodos que o form PAI chama de fora (regra #51)
    STRTOFILE("A10 PROTECTED? GerarGrafico=" + TRANSFORM(PEMSTATUS(loc_oForm, "GerarGrafico", 2)) + ;
        "  MostrarGrafico=" + TRANSFORM(PEMSTATUS(loc_oForm, "MostrarGrafico", 2)) + ;
        "  BO.CarregarDoCursor=" + TRANSFORM(PEMSTATUS(loc_oBO, "CarregarDoCursor", 2)) + ;
        "  BO.ObterPercentual=" + TRANSFORM(PEMSTATUS(loc_oBO, "ObterPercentual", 2)) + ;
        "  BO.LimparCursores=" + TRANSFORM(PEMSTATUS(loc_oBO, "LimparCursores", 2)) + ;
        "  (todos tem de ser .F.)" + CHR(13) + CHR(10), loc_cOut, 1)

    *-- A11: Destroy fecha o cursor do grafico e os 3 de trabalho do BO, e NAO
    *--      derruba o crFinal, que eh do pai
    LOCAL loc_cG, loc_cM, loc_cGr, loc_cP
    loc_cG  = ALLTRIM(loc_oBO.this_cCursorGrafico)
    loc_cM  = ALLTRIM(loc_oBO.this_cCursorMeses)
    loc_cGr = ALLTRIM(loc_oBO.this_cCursorGrupos)
    loc_cP  = ALLTRIM(loc_oBO.this_cCursorPercentuais)
    STRTOFILE("A11 antes do Release  Graph=" + TRANSFORM(USED(loc_cG)) + ;
        " Meses=" + TRANSFORM(USED(loc_cM)) + ;
        " Grupos=" + TRANSFORM(USED(loc_cGr)) + ;
        " Perc=" + TRANSFORM(USED(loc_cP)) + ;
        " crFinal=" + TRANSFORM(USED("crFinal")) + CHR(13) + CHR(10), loc_cOut, 1)

    loc_oBO = .NULL.
    loc_oForm.Release()
    loc_oForm = .NULL.

    STRTOFILE("A11 depois do Release Graph=" + TRANSFORM(USED(loc_cG)) + ;
        " Meses=" + TRANSFORM(USED(loc_cM)) + ;
        " Grupos=" + TRANSFORM(USED(loc_cGr)) + ;
        " Perc=" + TRANSFORM(USED(loc_cP)) + ;
        " crFinal=" + TRANSFORM(USED("crFinal")) + ;
        "  (os 4 primeiros .F., crFinal .T.)" + CHR(13) + CHR(10), loc_cOut, 1)
ENDIF

loc_oPai = .NULL.
STRTOFILE("[7] FIM" + CHR(13) + CHR(10), loc_cOut, 1)
QUIT
