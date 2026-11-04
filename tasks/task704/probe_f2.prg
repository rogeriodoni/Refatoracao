SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF
SET DATE TO BRITISH
SET CENTURY ON
SET NULL ON

PUBLIC gc_4c_Log
gc_4c_Log = "C:\4c\tasks\task704\logs\probe_f2.txt"
STRTOFILE("=== PROBE FASE 2 - SigOpClpBO ===" + CHR(13) + CHR(10), gc_4c_Log)

SET PROCEDURE TO ("C:\4c\projeto\app\utils\functions.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\utils\messages.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\SigOpClpBO.prg") ADDITIVE

LOCAL loc_oBO, loc_oErro, loc_cChave, loc_nAntes

TRY
    *-- Cursor com a estrutura EXATA de SigOpCclBO.RecriarCursorOperacoes
    CREATE CURSOR cursor_4c_Operacoes ;
        (Emps C(3), Dopes C(20), MascNum C(10), Tipo C(10), Moeda C(3), Valos N(12,2), Datas T NULL)
    INDEX ON Emps + Dopes + MascNum TAG Num
    INDEX ON Datas TAG Datas

    INSERT INTO cursor_4c_Operacoes (Emps, Dopes, MascNum, Tipo, Moeda, Valos, Datas) ;
        VALUES ("001", "PAGAMENTO", "0000000003", "Destino", "BRL", 1500.50, {^2026-03-10 00:00:00})
    INSERT INTO cursor_4c_Operacoes (Emps, Dopes, MascNum, Tipo, Moeda, Valos, Datas) ;
        VALUES ("001", "MALOTE", "0000000001", "Origem", "USD", 250.00, {^2026-09-25 00:00:00})
    INSERT INTO cursor_4c_Operacoes (Emps, Dopes, MascNum, Tipo, Moeda, Valos, Datas) ;
        VALUES ("002", "DEPOSITO", "0000000002", "Destino", "BRL", 99.99, {^2026-01-05 00:00:00})

    *-- Uma segunda area, para provar que CarregarDoCursor devolve a area de quem chamou
    CREATE CURSOR cursor_4c_Outro (X C(1))
    INSERT INTO cursor_4c_Outro (X) VALUES ("A")
    SELECT cursor_4c_Outro

    loc_oBO = CREATEOBJECT("SigOpClpBOProbe")

    STRTOFILE("1) Instanciou BO.......: " + VARTYPE(loc_oBO) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   cursor contratado...: [" + loc_oBO.this_cCursorOperacoes + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   ordem inicial.......: [" + loc_oBO.this_cOrdemAtual + "] desc=" + TRANSFORM(loc_oBO.this_lOrdemDescendente) + CHR(13) + CHR(10), gc_4c_Log, 1)

    *-- 2) Parametros e titulo (transcricao do Caption do legado)
    STRTOFILE("2) DefinirParametrosConsulta(vazio) = " + ;
        TRANSFORM(loc_oBO.DefinirParametrosConsulta("", "", "")) + ;
        "  msg=[" + loc_oBO.this_cMensagemErro + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   DefinirParametrosConsulta(ok)    = " + ;
        TRANSFORM(loc_oBO.DefinirParametrosConsulta("  10  ", " 1101 ", " GAVETA LOJA 001 ")) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   ObterTituloConsulta.: [" + loc_oBO.ObterTituloConsulta() + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)

    *-- 3) Contrato do cursor
    STRTOFILE("3) CursorPronto.......: " + TRANSFORM(loc_oBO.CursorPronto()) + ;
        "  msg=[" + loc_oBO.this_cMensagemErro + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   ContarOperacoes....: " + TRANSFORM(loc_oBO.ContarOperacoes()) + CHR(13) + CHR(10), gc_4c_Log, 1)

    *-- 4) CarregarDoCursor na 2a linha + restauracao da area de trabalho
    SELECT cursor_4c_Operacoes
    SET ORDER TO TAG Num
    GO TOP
    SKIP
    STRTOFILE("4) linha alvo RECNO...: " + TRANSFORM(RECNO()) + ;
        "  Dopes=[" + cursor_4c_Operacoes.Dopes + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)

    SELECT cursor_4c_Outro
    STRTOFILE("   area ANTES.........: [" + ALIAS() + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   CarregarLinhaCorrente = " + TRANSFORM(loc_oBO.CarregarLinhaCorrente()) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   area DEPOIS........: [" + ALIAS() + "]  (deve ser CURSOR_4C_OUTRO)" + CHR(13) + CHR(10), gc_4c_Log, 1)

    STRTOFILE("   this_cEmps.........: [" + loc_oBO.this_cEmps + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   this_cDopes........: [" + loc_oBO.this_cDopes + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   this_cMascNum......: [" + loc_oBO.this_cMascNum + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   this_cTipo.........: [" + loc_oBO.this_cTipo + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   this_cMoeda........: [" + loc_oBO.this_cMoeda + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   this_nValos........: " + TRANSFORM(loc_oBO.this_nValos) + "  tipo=" + VARTYPE(loc_oBO.this_nValos) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   this_dDatas........: " + TRANSFORM(loc_oBO.this_dDatas) + "  tipo=" + VARTYPE(loc_oBO.this_dDatas) + CHR(13) + CHR(10), gc_4c_Log, 1)

    *-- 5) Chave primaria POSICIONAL (tem de medir 33 = 3 + 20 + 10)
    loc_cChave = loc_oBO.ExporChavePrimaria()
    STRTOFILE("5) ObterChavePrimaria.: [" + loc_cChave + "]  LEN=" + TRANSFORM(LEN(loc_cChave)) + ;
        "  (esperado 33)" + CHR(13) + CHR(10), gc_4c_Log, 1)
    SELECT cursor_4c_Operacoes
    STRTOFILE("   chave do INDICE....: [" + (Emps + Dopes + MascNum) + "]  LEN=" + ;
        TRANSFORM(LEN(Emps + Dopes + MascNum)) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   casam?.............: " + TRANSFORM(loc_cChave == (Emps + Dopes + MascNum)) + CHR(13) + CHR(10), gc_4c_Log, 1)

    *-- 6) OrdenarPorData - DESCENDING, com RECNO preservado (legado)
    SELECT cursor_4c_Operacoes
    GO TOP
    SKIP
    loc_nAntes = RECNO()
    STRTOFILE("6) OrdenarPorData: RECNO antes=" + TRANSFORM(loc_nAntes) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   retorno............: " + TRANSFORM(loc_oBO.OrdenarPorData()) + CHR(13) + CHR(10), gc_4c_Log, 1)
    SELECT cursor_4c_Operacoes
    STRTOFILE("   RECNO depois.......: " + TRANSFORM(RECNO()) + "  (deve ser " + TRANSFORM(loc_nAntes) + ")" + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   ORDER()............: [" + ORDER() + "] desc=" + TRANSFORM(DESCENDING()) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   this_cOrdemAtual...: [" + loc_oBO.this_cOrdemAtual + "] desc=" + TRANSFORM(loc_oBO.this_lOrdemDescendente) + CHR(13) + CHR(10), gc_4c_Log, 1)
    GO TOP
    STRTOFILE("   1a linha (mais NOVA): " + TRANSFORM(cursor_4c_Operacoes.Datas) + ;
        " Dopes=[" + ALLTRIM(cursor_4c_Operacoes.Dopes) + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)

    *-- 7) OrdenarPorNumero - ASCENDENTE
    STRTOFILE("7) OrdenarPorNumero...: " + TRANSFORM(loc_oBO.OrdenarPorNumero()) + CHR(13) + CHR(10), gc_4c_Log, 1)
    SELECT cursor_4c_Operacoes
    STRTOFILE("   ORDER()............: [" + ORDER() + "] desc=" + TRANSFORM(DESCENDING()) + CHR(13) + CHR(10), gc_4c_Log, 1)
    GO TOP
    STRTOFILE("   1a linha...........: Emps=[" + cursor_4c_Operacoes.Emps + "] Dopes=[" + ;
        ALLTRIM(cursor_4c_Operacoes.Dopes) + "] MascNum=[" + ALLTRIM(cursor_4c_Operacoes.MascNum) + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)

    *-- 8) PosicionarNoTopo e EOF: CarregarDoCursor em EOF tem de ZERAR as props
    STRTOFILE("8) PosicionarNoTopo...: " + TRANSFORM(loc_oBO.PosicionarNoTopo()) + ;
        "  RECNO=" + TRANSFORM(RECNO("cursor_4c_Operacoes")) + CHR(13) + CHR(10), gc_4c_Log, 1)
    SELECT cursor_4c_Operacoes
    GO BOTTOM
    SKIP
    STRTOFILE("   EOF()..............: " + TRANSFORM(EOF()) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   CarregarLinhaCorrente (EOF) = " + TRANSFORM(loc_oBO.CarregarLinhaCorrente()) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("   props zeradas?.....: Dopes=[" + loc_oBO.this_cDopes + "] Valos=" + ;
        TRANSFORM(loc_oBO.this_nValos) + " Datas=" + TRANSFORM(loc_oBO.this_dDatas) + CHR(13) + CHR(10), gc_4c_Log, 1)

    *-- 9) LimparDados nao apaga os parametros da consulta
    loc_oBO.CarregarDoCursor("cursor_4c_Operacoes")
    loc_oBO.LimparDados()
    STRTOFILE("9) LimparDados: Dopes=[" + loc_oBO.this_cDopes + "] Grupo=[" + loc_oBO.this_cGrupo + ;
        "] Conta=[" + loc_oBO.this_cConta + "] cursor=[" + loc_oBO.this_cCursorOperacoes + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)

    *-- 10) Alias ausente e TAG inexistente nao estouram
    STRTOFILE("10) CarregarDoCursor('nao_existe') = " + ;
        TRANSFORM(loc_oBO.CarregarDoCursor("cursor_4c_NaoExiste")) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("    AplicarOrdem('TagInexistente') = " + ;
        TRANSFORM(loc_oBO.AplicarOrdem("TagInexistente", .F.)) + "  msg=[" + loc_oBO.this_cMensagemErro + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)

    *-- 11) Inserir/Atualizar HERDADOS: recusam e reportam (comportamento correto)
    STRTOFILE("11) Inserir() herdado..: " + TRANSFORM(loc_oBO.Inserir()) + ;
        "  msg=[" + loc_oBO.this_cMensagemErro + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("    Atualizar() herdado: " + TRANSFORM(loc_oBO.Atualizar()) + ;
        "  msg=[" + loc_oBO.this_cMensagemErro + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)

    *-- 12) Escopo dos metodos chamados de FORA (regra #51)
    STRTOFILE("12) PEMSTATUS protegido (2=Protected, esperado .F. nos publicos):" + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("    CarregarDoCursor..........: " + TRANSFORM(PEMSTATUS(loc_oBO, "CarregarDoCursor", 2)) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("    CarregarLinhaCorrente.....: " + TRANSFORM(PEMSTATUS(loc_oBO, "CarregarLinhaCorrente", 2)) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("    LimparDados...............: " + TRANSFORM(PEMSTATUS(loc_oBO, "LimparDados", 2)) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("    DefinirParametrosConsulta.: " + TRANSFORM(PEMSTATUS(loc_oBO, "DefinirParametrosConsulta", 2)) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("    ObterTituloConsulta.......: " + TRANSFORM(PEMSTATUS(loc_oBO, "ObterTituloConsulta", 2)) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("    CursorPronto..............: " + TRANSFORM(PEMSTATUS(loc_oBO, "CursorPronto", 2)) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("    ContarOperacoes...........: " + TRANSFORM(PEMSTATUS(loc_oBO, "ContarOperacoes", 2)) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("    PosicionarNoTopo..........: " + TRANSFORM(PEMSTATUS(loc_oBO, "PosicionarNoTopo", 2)) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("    OrdenarPorNumero..........: " + TRANSFORM(PEMSTATUS(loc_oBO, "OrdenarPorNumero", 2)) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("    OrdenarPorData............: " + TRANSFORM(PEMSTATUS(loc_oBO, "OrdenarPorData", 2)) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("    AplicarOrdem..............: " + TRANSFORM(PEMSTATUS(loc_oBO, "AplicarOrdem", 2)) + CHR(13) + CHR(10), gc_4c_Log, 1)
    STRTOFILE("    ObterChavePrimaria (deve .T.): " + TRANSFORM(PEMSTATUS(loc_oBO, "ObterChavePrimaria", 2)) + CHR(13) + CHR(10), gc_4c_Log, 1)

    STRTOFILE("=== FIM OK ===" + CHR(13) + CHR(10), gc_4c_Log, 1)
CATCH TO loc_oErro
    STRTOFILE("*** EXCECAO: " + loc_oErro.Message + CHR(13) + CHR(10) + ;
        "    Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10) + ;
        "    Proc : " + loc_oErro.Procedure + CHR(13) + CHR(10), gc_4c_Log, 1)
ENDTRY

QUIT


*-- Subclasse de prova: expoe o ObterChavePrimaria PROTECTED
DEFINE CLASS SigOpClpBOProbe AS SigOpClpBO
    PROCEDURE ExporChavePrimaria()
        RETURN THIS.ObterChavePrimaria()
    ENDPROC
ENDDEFINE
