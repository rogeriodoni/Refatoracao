*------------------------------------------------------------------------------
* sigprilaBO.prg - Business Object para Importacao de Planilha
* Herda de: BusinessBase
* Tabela principal: SigPrTam (preco por tamanho, atualizado em atuapreco)
*------------------------------------------------------------------------------
DEFINE CLASS sigprilaBO AS BusinessBase

    *-- Identificacao da tabela e chave
    this_cTabela      = "SigPrTam"
    this_cCampoChave  = "CIdChaves"

    *-- Campos SigPrTam
    this_cCIdChaves   = ""
    this_cCpros       = ""
    this_nPercs       = 0
    this_nValor       = 0

    *-- Parametros carregados de SigCdPac
    this_cSigKey      = ""
    this_cDopImpPlan  = ""
    this_cDopTrfPed   = ""
    this_cDopPedCon   = ""
    this_cDopAcePed   = ""

    *-- Parametros carregados de SigCdPam
    this_cMoedaPadrao = ""
    this_cMoeLimes    = ""
    this_nTpPrecos    = 0
    this_lChqlCreds   = .F.

    *-- Estado do processamento
    this_cSigKeyEmp      = ""
    this_nValorAcumulado = 0
    this_nTipoImport     = 0
    this_nTipoPreco      = 0

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigPrTam"
        THIS.this_cCampoChave = "CIdChaves"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCIdChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor SigPrTam
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCIdChaves = NVL(CIdChaves, "")
            THIS.this_cCpros     = NVL(Cpros, "")
            THIS.this_nPercs     = NVL(Percs, 0)
            THIS.this_nValor     = NVL(Valor, 0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cCpros)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto obrigat" + CHR(243) + "rio"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigPrTam
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_cChave
        loc_lResultado = .F.
        TRY
            IF !THIS.ValidarDados()
                loc_lResultado = .F.
            ENDIF
            loc_cChave = fUniqueIds()
            loc_cSQL = "INSERT INTO SigPrTam (CIdChaves, Cpros, Percs, Valor)" + ;
                " VALUES (" + ;
                EscaparSQL(loc_cChave) + "," + ;
                EscaparSQL(THIS.this_cCpros) + "," + ;
                FormatarNumeroSQL(THIS.this_nPercs, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nValor, 5) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                THIS.this_cMensagemErro = "Erro ao inserir em SigPrTam"
                loc_lResultado = .F.
            ENDIF
            THIS.this_cCIdChaves = loc_cChave
            THIS.RegistrarAuditoria("INSERIR")
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigPrTam
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF !THIS.ValidarDados()
                loc_lResultado = .F.
            ENDIF
            loc_cSQL = "UPDATE SigPrTam SET " + ;
                "Percs = " + FormatarNumeroSQL(THIS.this_nPercs, 2) + "," + ;
                "Valor = " + FormatarNumeroSQL(THIS.this_nValor, 5) + ;
                " WHERE CIdChaves = " + EscaparSQL(THIS.this_cCIdChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                THIS.this_cMensagemErro = "Erro ao atualizar SigPrTam"
                loc_lResultado = .F.
            ENDIF
            THIS.RegistrarAuditoria("ALTERAR")
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove registro de SigPrTam
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPrTam" + ;
                " WHERE CIdChaves = " + EscaparSQL(THIS.this_cCIdChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                THIS.this_cMensagemErro = "Erro ao excluir de SigPrTam"
                loc_lResultado = .F.
            ENDIF
            THIS.RegistrarAuditoria("EXCLUIR")
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava log em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_oErro, loc_cSQL
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, ChaveRegistro, Operacao, Usuario, DataHora)" + ;
                " VALUES (" + ;
                EscaparSQL("SigPrTam") + "," + ;
                EscaparSQL(THIS.ObterChavePrimaria()) + "," + ;
                EscaparSQL(par_cOperacao) + "," + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ",GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL, "")
        CATCH TO loc_oErro
            *-- Falha de auditoria nao deve interromper a operacao principal
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarParametros - Carrega SigCdPam, SigCdPac e cursores de moeda
    *--------------------------------------------------------------------------
    FUNCTION InicializarParametros()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPam", "cursor_4c_Pam") > 0
                IF !EOF("cursor_4c_Pam")
                    SELECT cursor_4c_Pam
                    THIS.this_cMoedaPadrao = NVL(MoedaPs, "")
                    THIS.this_cMoeLimes    = NVL(MoeLimes, "")
                    THIS.this_nTpPrecos    = NVL(TpPrecos, 0)
                    THIS.this_lChqlCreds   = NVL(ChqlCreds, .F.)
                ENDIF
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPac", "cursor_4c_Pac") > 0
                IF !EOF("cursor_4c_Pac")
                    SELECT cursor_4c_Pac
                    THIS.this_cSigKey     = NVL(SigKeys, "")
                    THIS.this_cDopImpPlan = NVL(DopImpPlan, "")
                    THIS.this_cDopTrfPed  = NVL(DopTrfPed, "")
                    THIS.this_cDopPedCon  = NVL(DopPedCon, "")
                    THIS.this_cDopAcePed  = NVL(DopAcePed, "")
                ENDIF
            ENDIF
            IF !USED("crSigCdMoe")
                IF SQLEXEC(gnConnHandle, ;
                    "SELECT cmoes, cotas, moeqs, qtdeqs FROM SigCdMoe ORDER BY cmoes", ;
                    "crSigCdMoe") > 0
                    SELECT crSigCdMoe
                    INDEX ON cmoes TAG cmoes
                    SET ORDER TO "" IN crSigCdMoe
                ENDIF
            ENDIF
            IF !USED("crSigCdCot")
                IF SQLEXEC(gnConnHandle, ;
                    "SELECT cmoes, datas, horas, valos FROM SigCdCot ORDER BY cmoes ASC, datas DESC, horas DESC", ;
                    "crSigCdCot") > 0
                    SELECT crSigCdCot
                    INDEX ON cmoes + DTOS(datas) + horas TAG cmoedata
                    SET ORDER TO "" IN crSigCdCot
                ENDIF
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * PreencherTipos - Cria cursor ComboTipo com os tipos de importacao disponiveis
    *--------------------------------------------------------------------------
    FUNCTION PreencherTipos()
        LOCAL loc_lResultado, loc_oErro, loc_nI, loc_aTipos
        loc_lResultado = .F.
        TRY
            IF USED("ComboTipo")
                USE IN ComboTipo
            ENDIF
            CREATE CURSOR ComboTipo (Titulo C(20), Rotina C(20), ColunaLi M)

            DIMENSION loc_aTipos[7, 3]

            loc_aTipos[1, 1] = "Lista de Pre" + CHR(231) + "o"
            loc_aTipos[1, 2] = "ListaPreco"
            loc_aTipos[1, 3] = "Empresa,Emps c(3), Nome da Lista,NomeLista c(20)," + ;
                "C" + CHR(243) + "digo Produto,cPros c(14),Valor ,Valor c(16)," + ;
                "Data Inicial,DataIni d,Data Final,DataFim d,Preco De ,PrecoDe c(16)"

            loc_aTipos[2, 1] = "Transferencia"
            loc_aTipos[2, 2] = "GeraTransf"
            loc_aTipos[2, 3] = "Empresa Origem,EmpresaO c(6),Empresa Destino,EmpresaD c(6)," + ;
                "Categoria ,Categoria c(10),Colecao,Colecao c(20),Produto,cpros c(20)," + ;
                "Quantidade,Qtds n(10|3),Grupo,Grupo c(10),Prazo Entrega ,prazo d," + ;
                "Codigo Barra,CBars n(14|0),Cor,Cors c(4),Tamanho,Tams c(4) "

            loc_aTipos[3, 1] = "Precifica" + CHR(231) + CHR(227) + "o"
            loc_aTipos[3, 2] = "AtuaPreco"
            loc_aTipos[3, 3] = "Referencia,Referencia c(20),Data Inicio,dtInicial d," + ;
                "Data Termino,dtFinal d,Valor Venda,PrecoVen c(16)," + ;
                "Preco Especial,PrecoEsp c(16),Produto Off,ProdOff c(1)"

            loc_aTipos[4, 1] = "Pedido Terceiro"
            loc_aTipos[4, 2] = "GeraPedido"
            loc_aTipos[4, 3] = "Empresa Origem,Emps c(6),Empresa Destino,Empds c(6)," + ;
                "Conta Origem ,ContaOs c(10),Produto,cpros c(20)," + ;
                "Quantidade,Qtds n(10|3),Cor,Cors c(4),Tamanho,Tams c(4)," + ;
                "Peso,Pesos n(12|5),Data Recebimento ,prazo d "

            loc_aTipos[5, 1] = "Pedido Consignado"
            loc_aTipos[5, 2] = "Pedidocons"
            loc_aTipos[5, 3] = "Empresa Origem,Emps c(6),Empresa Destino,Empds c(6)," + ;
                "Conta Origem ,ContaOs c(10),Produto,cpros c(20)," + ;
                "Quantidade,Qtds n(10|3),Cor,Cors c(4),Tamanho,Tams c(4)," + ;
                "Peso,Pesos n(12|5),Data Recebimento ,prazo d "

            loc_aTipos[6, 1] = "Pedido Fabrica"
            loc_aTipos[6, 2] = "PedidoFab"
            loc_aTipos[6, 3] = "Conta Origem ,ContaOs c(10),Produto,cpros c(20)," + ;
                "Quantidade,Qtds n(10|3),Cor,Cors c(4),Tamanho,Tams c(4)," + ;
                "Peso,Pesos n(12|5), Valor ,Units n(12|5),Moeda,Moedas c(3)," + ;
                "Prazo ,prazoents d,Movimentacao, Dopes c(20)"

            loc_aTipos[7, 1] = "Pedido Acess" + CHR(243) + "rio"
            loc_aTipos[7, 2] = "PedAcesso"
            loc_aTipos[7, 3] = "Empresa Origem,Emps c(6),Empresa Destino,Empds c(6)," + ;
                "Conta Origem ,ContaOs c(10),Produto,cpros c(20)," + ;
                "Quantidade,Qtds n(10|3),Cor,Cors c(4),Tamanho,Tams c(4)," + ;
                "Peso,Pesos n(12|5),Data Recebimento ,prazo d "

            FOR loc_nI = 1 TO ALEN(loc_aTipos, 1)
                IF fChecaAcesso("SIGPRILA", UPPER(loc_aTipos[loc_nI, 2]))
                    INSERT INTO ComboTipo (Titulo, Rotina, ColunaLi) VALUES ;
                        (loc_aTipos[loc_nI, 1], loc_aTipos[loc_nI, 2], loc_aTipos[loc_nI, 3])
                ENDIF
            ENDFOR
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CompletarLista - Retorna colunas da lista para o tipo selecionado
    *--------------------------------------------------------------------------
    FUNCTION CompletarLista(par_cTitulo)
        LOCAL loc_cColunaLi, loc_oErro
        loc_cColunaLi = ""
        TRY
            SELECT ComboTipo
            IF !EOF("ComboTipo")
                loc_cColunaLi = ALLTRIM(ComboTipo.ColunaLi)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cColunaLi
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterVisibilidadeTipo - Retorna se OptTipo/OptPreco devem ser visiveis
    *--------------------------------------------------------------------------
    FUNCTION ObterVisibilidadeTipo(par_cTitulo)
        LOCAL loc_cTit
        loc_cTit = UPPER(ALLTRIM(par_cTitulo))
        RETURN INLIST(loc_cTit, "TRANSFERENCIA", "PRECIFICACAO", ;
            "PEDIDO TERCEIRO", "PEDIDO CONSIGNADO", "PEDIDO FABRICA", "PEDIDO ACESSORIO")
    ENDFUNC

    FUNCTION ObterVisibilidadePreco(par_cTitulo)
        LOCAL loc_cTit
        loc_cTit = UPPER(ALLTRIM(par_cTitulo))
        RETURN INLIST(loc_cTit, "PEDIDO TERCEIRO", "PEDIDO CONSIGNADO", "PEDIDO FABRICA", "PEDIDO ACESSORIO")
    ENDFUNC

    *--------------------------------------------------------------------------
    * CriarPlanilha - Le arquivo XLS e cria cursor TmpPlanilha
    *--------------------------------------------------------------------------
    FUNCTION CriarPlanilha(par_cArquivo, par_oList, par_lCabecalho)
        LOCAL loc_lResultado, loc_oErro, loc_nI, loc_cCursor, loc_cFile, loc_cMsg
        loc_lResultado = .F.
        TRY
            IF EMPTY(par_cArquivo)
                MsgAviso("Arquivo inv" + CHR(225) + "lido", "Aviso")
                loc_lResultado = .F.
            ENDIF

            IF USED("TmpPlanilha")
                USE IN TmpPlanilha
            ENDIF

            loc_cFile = ADDBS(SYS(5) + SYS(2003))
            IF FILE(loc_cFile + "TmpPlanilha.dbf")
                DELETE FILE loc_cFile + "TmpPlanilha.dbf"
            ENDIF

            loc_cCursor = "Create Table TmpPlanilha ("
            FOR loc_nI = 1 TO par_oList.ListCount
                loc_cCursor = loc_cCursor + par_oList.List(loc_nI, 2) + ","
            ENDFOR
            IF RIGHT(loc_cCursor, 1) = ","
                loc_cCursor = SUBSTR(loc_cCursor, 1, LEN(loc_cCursor) - 1)
            ENDIF
            loc_cCursor = loc_cCursor + ")"
            loc_cCursor = STRTRAN(loc_cCursor, "|", ",")
            &loc_cCursor

            TRY
                SELECT TmpPlanilha
                APPEND FROM (par_cArquivo) TYPE XL5
                loc_lResultado = .T.
            CATCH TO loc_oErro
                loc_lResultado = .F.
            ENDTRY

            IF !loc_lResultado
                loc_cMsg = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel criar o cursor tempor" + CHR(225) + "rio." + CHR(13)
                loc_cMsg = loc_cMsg + "Verifique se a planilha n" + CHR(227) + "o est" + CHR(225) + " aberta ou que esteja salva com o Formato :" + CHR(13)
                loc_cMsg = loc_cMsg + "Microsoft Excel 5.0/95 (.xls)"
                MsgErro(loc_cMsg, "Problema na Leitura da Planilha")
                loc_lResultado = .F.
            ENDIF

            IF par_lCabecalho
                SELECT TmpPlanilha
                GO TOP
                DELETE IN TmpPlanilha
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarColunas - Verifica se a rotina de processamento existe
    *--------------------------------------------------------------------------
    FUNCTION ValidarColunas(par_cRotina)
        LOCAL loc_cRot
        loc_cRot = UPPER(ALLTRIM(par_cRotina))
        RETURN INLIST(loc_cRot, "LISTAPRECO", "GERATRANSF", "ATUAPRECO", ;
            "GERAPEDIDO", "PEDIDOCONS", "PEDIDOFAB", "PEDACESSO")
    ENDFUNC

    *--------------------------------------------------------------------------
    * Processamento - Despachante principal da importacao
    *--------------------------------------------------------------------------
    FUNCTION Processamento(par_nTipo, par_nPreco, par_cRotina, par_cArquivo, par_lCabecalho, par_oList)
        LOCAL loc_lResultado, loc_oErro, loc_cRot
        loc_lResultado = .F.
        TRY
            IF !THIS.CriarPlanilha(par_cArquivo, par_oList, par_lCabecalho)
                loc_lResultado = .F.
            ENDIF
            IF !THIS.ValidarColunas(par_cRotina)
                MsgErro("M" + CHR(233) + "todo " + ALLTRIM(par_cRotina) + ;
                    " n" + CHR(227) + "o localizado", "Erro")
                loc_lResultado = .F.
            ENDIF
            IF !MsgConfirma("Aten" + CHR(231) + CHR(227) + "o, a ordem das colunas " + CHR(233) + " muito importante." + CHR(13) + ;
                "Certifique-se que elas est" + CHR(227) + "o corretas." + CHR(13) + ;
                "Ordem incorreta resultar" + CHR(225) + " em uma importa" + CHR(231) + CHR(227) + "o incorreta," + CHR(13) + ;
                "e este processo " + CHR(233) + " irrevers" + CHR(237) + "vel." + CHR(13) + ;
                "Tem certeza que deseja continuar a importa" + CHR(231) + CHR(227) + "o com a ordem selecionada")
                loc_lResultado = .F.
            ENDIF

            loc_cRot = UPPER(ALLTRIM(par_cRotina))
            DO CASE
                CASE loc_cRot = "LISTAPRECO"
                    loc_lResultado = THIS.ProcessarListaPreco()
                CASE loc_cRot = "GERATRANSF"
                    loc_lResultado = THIS.ProcessarTransferencia(par_nTipo)
                CASE loc_cRot = "ATUAPRECO"
                    loc_lResultado = THIS.ProcessarPrecificacao(par_nTipo, par_cArquivo)
                CASE loc_cRot = "GERAPEDIDO"
                    loc_lResultado = THIS.ProcessarPedidoTerceiro(par_nTipo, par_nPreco)
                CASE loc_cRot = "PEDIDOCONS"
                    loc_lResultado = THIS.ProcessarPedidoConsignado(par_nTipo, par_nPreco)
                CASE loc_cRot = "PEDIDOFAB"
                    loc_lResultado = THIS.ProcessarPedidoFabrica(par_nTipo, par_nPreco)
                CASE loc_cRot = "PEDACESSO"
                    loc_lResultado = THIS.ProcessarPedidoAcessorio(par_nTipo, par_nPreco)
                OTHERWISE
                    MsgErro("Rotina " + ALLTRIM(par_cRotina) + " n" + CHR(227) + "o reconhecida", "Erro")
                    loc_lResultado = .F.
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarListaPreco - Importa lista de preco do TmpPlanilha para SigCdLpc/SigCdLpi
    *--------------------------------------------------------------------------
    FUNCTION ProcessarListaPreco()
        LOCAL loc_lResultado, loc_oErro, loc_loBarra, loc_loBarraPro
        LOCAL loc_cPlCodLista, loc_cPlEmps, loc_cQuery, loc_cSQL
        LOCAL loc_nQtde
        loc_lResultado = .F.
        TRY
            LOCAL loc_plPrecos, loc_plCodLista, loc_pPro, loc_plEmps
            loc_plPrecos   = REPLICATE(CHR(254), 30)
            loc_plCodLista = REPLICATE(CHR(254), 30)
            loc_pPro       = REPLICATE(CHR(254), 10)
            loc_plEmps     = REPLICATE(CHR(254), 3)

            SELECT DISTINCT NomeLista, Emps FROM TmpPlanilha INTO CURSOR crNomeLista READWRITE

            loc_loBarra = CREATEOBJECT("fwprogressbar", "Importando Lista...", RECCOUNT("crNomeLista"))
            loc_loBarra.Top = loc_loBarra.Top - INT(loc_loBarra.Height / 2) - 1
            loc_loBarra.Titulo.FontBold = .T.
            loc_loBarra.Show

            SELECT crNomeLista
            GO TOP
            SCAN
                loc_loBarra.Update(.T., "Lista: " + crNomeLista.NomeLista)
                loc_cPlCodLista = crNomeLista.NomeLista
                loc_cPlEmps     = NVL(crNomeLista.Emps, "")

                IF !EMPTY(loc_cPlEmps)
                    loc_cQuery = "SELECT lPrecos FROM SigCdLpc WHERE Emps = " + EscaparSQL(loc_cPlEmps)
                    IF SQLEXEC(gnConnHandle, loc_cQuery, "crLocalBus") < 1
                        MsgErro("Falha na Conex" + CHR(227) + "o (LocalBus 1)", "Erro")
                        SELECT crNomeLista
                        loc_lResultado = .F.
                    ENDIF
                    GO TOP IN crLocalBus
                    IF !EOF("crLocalBus")
                        MsgAviso("J" + CHR(225) + " Existe uma Lista de Pre" + CHR(231) + "o Cadastrado para a Empresa : " + loc_cPlEmps, ;
                            "Aten" + CHR(231) + CHR(227) + "o!!!")
                        SELECT crNomeLista
                        LOOP
                    ENDIF
                ENDIF

                *-- Verifica se lista ja existe em SigCdLpc
                loc_cQuery = "SELECT * FROM SigCdLpc WHERE lPrecos = " + EscaparSQL(loc_cPlCodLista)
                SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdLpc")
                SELECT crSigCdLpc
                IF EOF("crSigCdLpc")
                    *-- Contar quantos produtos
                    SELECT COUNT(*) AS nQtde FROM TmpPlanilha ;
                        WHERE RTRIM(NomeLista) = ALLTRIM(m.loc_cPlCodLista) ;
                        INTO CURSOR crQtdLista READWRITE
                    SELECT crQtdLista
                    loc_nQtde = IIF(!EOF("crQtdLista"), NVL(crQtdLista.nQtde, 0), 0)

                    *-- INSERT SigCdLpc
                    loc_cSQL = "INSERT INTO SigCdLpc (lPrecos, Codigos, Formulas, Ncomiss, Nvencs, Tipos, Emps, CidChaves, nQtdes)" + ;
                        " VALUES (" + ;
                        EscaparSQL(loc_cPlCodLista) + "," + ;
                        FormatarNumeroSQL(fGerUniqueKey("SigCdLpc"), 0) + "," + ;
                        "2,2,2,' '," + ;
                        EscaparSQL(loc_cPlEmps) + "," + ;
                        EscaparSQL(fUniqueIds()) + "," + ;
                        FormatarNumeroSQL(loc_nQtde, 0) + ")"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                        MsgErro("Falha na Conex" + CHR(227) + "o (INSERT SigCdLpc)", "Erro")
                        SELECT crNomeLista
                        loc_lResultado = .F.
                    ENDIF

                    *-- Buscar produtos desta lista em TmpPlanilha
                    SELECT * FROM TmpPlanilha ;
                        WHERE RTRIM(NomeLista) = ALLTRIM(m.loc_cPlCodLista) ;
                        INTO CURSOR crTmpPlanilha READWRITE

                    loc_loBarraPro = CREATEOBJECT("fwprogressbar", "Importando Lista...", RECCOUNT("crTmpPlanilha"))
                    loc_loBarraPro.Top = loc_loBarraPro.Top + INT(loc_loBarraPro.Height / 2) + 1
                    loc_loBarraPro.Show

                    SELECT crTmpPlanilha
                    GO TOP
                    SCAN
                        loc_pPro = crTmpPlanilha.cPros
                        *-- Buscar produto
                        loc_cQuery = "SELECT cGrus, cPros, dPros, MoeVs, pCuss, Ean13, Reffs" + ;
                            " FROM SigCdPro WHERE cPros = " + EscaparSQL(loc_pPro)
                        SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdPro")
                        IF EOF("crSigCdPro")
                            SELECT crTmpPlanilha
                            LOOP
                        ENDIF

                        loc_loBarraPro.Update(.T., "Produto: " + ALLTRIM(crSigCdPro.cPros) + " - " + ALLTRIM(crSigCdPro.dPros))

                        *-- INSERT SigCdLpi
                        loc_cSQL = "INSERT INTO SigCdLpi" + ;
                            " (cGrus, cPros, dPros, MoeVs, pCuss, Ean13, Reffs, lPrecos, pVens, PrecoDe, Vencis, Vencfs, CidChaves)" + ;
                            " VALUES (" + ;
                            EscaparSQL(NVL(crSigCdPro.cGrus, "")) + "," + ;
                            EscaparSQL(NVL(crSigCdPro.cPros, "")) + "," + ;
                            EscaparSQL(NVL(crSigCdPro.dPros, "")) + "," + ;
                            EscaparSQL(NVL(crSigCdPro.MoeVs, "")) + "," + ;
                            FormatarNumeroSQL(NVL(crSigCdPro.pCuss, 0), 5) + "," + ;
                            EscaparSQL(NVL(crSigCdPro.Ean13, "")) + "," + ;
                            EscaparSQL(NVL(crSigCdPro.Reffs, "")) + "," + ;
                            EscaparSQL(loc_cPlCodLista) + "," + ;
                            FormatarNumeroSQL(IIF(VARTYPE(crTmpPlanilha.Valor) = "N", crTmpPlanilha.Valor, VAL(crTmpPlanilha.Valor)), 5) + "," + ;
                            FormatarNumeroSQL(IIF(VARTYPE(crTmpPlanilha.PrecoDe) = "N", crTmpPlanilha.PrecoDe, VAL(crTmpPlanilha.PrecoDe)), 5) + "," + ;
                            IIF(!EMPTY(crTmpPlanilha.DataIni), FormatarDataSQL(crTmpPlanilha.DataIni), "NULL") + "," + ;
                            IIF(!EMPTY(crTmpPlanilha.DataFim), FormatarDataSQL(crTmpPlanilha.DataFim), "NULL") + "," + ;
                            EscaparSQL(fUniqueIds()) + ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                            MsgErro("Falha na Conex" + CHR(227) + "o (INSERT SigCdLpi)", "Erro")
                            loc_loBarraPro.Complete(.T.)
                            SELECT crNomeLista
                            loc_lResultado = .F.
                        ENDIF
                        SELECT crTmpPlanilha
                    ENDSCAN
                    loc_loBarraPro.Complete(.T.)
                ELSE
                    MsgErro("Lista " + ALLTRIM(loc_cPlCodLista) + " j" + CHR(225) + " cadastrada" + CHR(13) + ;
                        "Processo Abortado", "Aten" + CHR(231) + CHR(227) + "o")
                    EXIT
                ENDIF
                SELECT crNomeLista
            ENDSCAN
            loc_loBarra.Complete(.T.)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPrecificacao - Atualiza precos de SigCdPro a partir de TmpPlanilha (atuapreco)
    *--------------------------------------------------------------------------
    FUNCTION ProcessarPrecificacao(par_nTipo, par_cArquivo)
        LOCAL loc_lResultado, loc_oErro, loc_loBarra, loc_cNomArq
        LOCAL loc_cQuery, loc_cSQL, loc_cCpros, loc_cMoevs
        LOCAL loc_nValAnt, loc_nPVens, loc_nPreDe, loc_nPVensEsp, loc_cProdOff
        loc_lResultado = .F.
        TRY
            loc_cNomArq = JUSTFNAME(par_cArquivo)

            SELECT TmpPlanilha
            GO TOP

            loc_loBarra = CREATEOBJECT("fwprogressbar", "Importando Lista...", RECCOUNT("TmpPlanilha"))
            loc_loBarra.Top = loc_loBarra.Top - INT(loc_loBarra.Height / 2) - 1
            loc_loBarra.Titulo.FontBold = .T.
            loc_loBarra.Show

            SELECT TmpPlanilha
            GO TOP
            SCAN
                IF EMPTY(TmpPlanilha.Referencia)
                    SELECT TmpPlanilha
                    LOOP
                ENDIF

                loc_loBarra.Update(.T., "Referencia: " + TmpPlanilha.Referencia)

                loc_cQuery = "SELECT Cpros, Dpros, PVens, Moevs, CUnis, PesoMs, cGrus, PrecoDe" + ;
                    " FROM SigCdPro" + ;
                    " WHERE " + IIF(par_nTipo = 1, "Cpros", IIF(par_nTipo = 2, "Dpro2s", "Reffs")) + ;
                    " = " + EscaparSQL(ALLTRIM(TmpPlanilha.Referencia))
                SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdPro")
                SELECT crSigCdPro
                IF EOF("crSigCdPro") OR EMPTY(crSigCdPro.Cpros)
                    SELECT TmpPlanilha
                    LOOP
                ENDIF

                loc_cCpros  = crSigCdPro.Cpros
                loc_cMoevs  = crSigCdPro.Moevs
                loc_nValAnt = NVL(crSigCdPro.PVens, 0)

                loc_nPreDe  = IIF(VARTYPE(TmpPlanilha.PrecoVen) = "N", TmpPlanilha.PrecoVen, VAL(TmpPlanilha.PrecoVen))
                loc_nPVensEsp = IIF(VARTYPE(TmpPlanilha.PrecoEsp) = "N", TmpPlanilha.PrecoEsp, VAL(TmpPlanilha.PrecoEsp))
                loc_cProdOff  = ALLTRIM(NVL(TmpPlanilha.ProdOff, ""))

                IF loc_nPVensEsp = 0
                    loc_nPVens = loc_nPreDe
                    loc_nPreDe = 0
                ELSE
                    loc_nPVens = loc_nPVensEsp
                ENDIF

                *-- Registra historico de preco se houve alteracao
                IF loc_nPVens <> NVL(crSigCdPro.PVens, 0) OR loc_nPreDe <> NVL(crSigCdPro.PrecoDe, 0)
                    loc_cSQL = "INSERT INTO SigPrPre (Cpros, CIdChaves, PVens, PVensAnt, Moevs, MoevsAnt, Datas)" + ;
                        " VALUES (" + ;
                        EscaparSQL(loc_cCpros) + "," + ;
                        EscaparSQL(fUniqueIds()) + "," + ;
                        FormatarNumeroSQL(loc_nPVens, 5) + "," + ;
                        FormatarNumeroSQL(loc_nValAnt, 5) + "," + ;
                        EscaparSQL(loc_cMoevs) + ",'',GETDATE())"
                    SQLEXEC(gnConnHandle, loc_cSQL, "")
                ENDIF

                *-- Registra importacao em SigImpPr
                loc_cSQL = "INSERT INTO SigImpPr" + ;
                    " (Cpros, Referencia, PrecoVen, PrecoEsp, DtInicial, DtFinal, UsuImp, DataImp, Utilizado, Arquivos, CidChaves)" + ;
                    " VALUES (" + ;
                    EscaparSQL(loc_cCpros) + "," + ;
                    EscaparSQL(ALLTRIM(TmpPlanilha.Referencia)) + "," + ;
                    FormatarNumeroSQL(NVL(loc_nPreDe, 0), 5) + "," + ;
                    FormatarNumeroSQL(NVL(loc_nPVens, 0), 5) + "," + ;
                    IIF(!EMPTY(TmpPlanilha.DtInicial), FormatarDataSQL(TmpPlanilha.DtInicial), "NULL") + "," + ;
                    IIF(!EMPTY(TmpPlanilha.DtFinal), FormatarDataSQL(TmpPlanilha.DtFinal), "NULL") + "," + ;
                    EscaparSQL(gc_4c_UsuarioLogado) + ",GETDATE()," + ;
                    "0," + ;
                    EscaparSQL(loc_cNomArq) + "," + ;
                    EscaparSQL(fUniqueIds()) + ")"
                SQLEXEC(gnConnHandle, loc_cSQL, "")

                *-- Verifica se grupo atualiza preco por tamanho (AtuPreTam)
                SQLEXEC(gnConnHandle, "SELECT AtuPreTam FROM SigCdGrp WHERE CGrus = " + EscaparSQL(ALLTRIM(crSigCdPro.cGrus)), "crSigCdGrp")
                IF !EOF("crSigCdGrp") AND NVL(crSigCdGrp.AtuPreTam, 0) = 1
                    SQLEXEC(gnConnHandle, "SELECT CIdChaves, Percs FROM SigPrTam WHERE Cpros = " + EscaparSQL(loc_cCpros), "crSigPrTam")
                    SELECT crSigPrTam
                    GO TOP
                    SCAN
                        LOCAL loc_nValTam
                        IF !EMPTY(crSigPrTam.Percs)
                            loc_nValTam = loc_nPVens + (loc_nPVens * (crSigPrTam.Percs / 100))
                        ELSE
                            loc_nValTam = loc_nPVens
                        ENDIF
                        loc_cSQL = "UPDATE SigPrTam SET Valor = " + FormatarNumeroSQL(loc_nValTam, 5) + ;
                            " WHERE CIdChaves = " + EscaparSQL(crSigPrTam.CIdChaves)
                        SQLEXEC(gnConnHandle, loc_cSQL, "")
                        SELECT crSigPrTam
                    ENDSCAN
                ENDIF

                *-- Atualiza SigCdPro
                loc_cSQL = "UPDATE SigCdPro SET" + ;
                    " pvens = " + FormatarNumeroSQL(loc_nPVens, 5) + ;
                    ", precode = " + FormatarNumeroSQL(loc_nPreDe, 5)
                IF !EMPTY(loc_cProdOff)
                    loc_cSQL = loc_cSQL + ", prodoff = " + IIF(loc_cProdOff = "S", "1", "0")
                ENDIF
                loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(loc_cCpros)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                    MsgErro("Falha na Conex" + CHR(227) + "o (UPDATE SigCdPro)", "Erro")
                    SELECT TmpPlanilha
                    LOOP
                ENDIF

                *-- Limpa registros de SigPrPrt para o produto
                loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_cCpros)
                SQLEXEC(gnConnHandle, loc_cSQL, "")

                SELECT TmpPlanilha
            ENDSCAN
            loc_loBarra.Complete(.T.)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarTransferencia - Importa planilha de transferencias (geratransf)
    *--------------------------------------------------------------------------
    FUNCTION ProcessarTransferencia(par_nTipo)
        LOCAL loc_lResultado, loc_oErro, loc_loBarra, loc_cQuery, loc_cSQL
        LOCAL loc_cDopes, loc_cOpers, loc_cGrupoOs, loc_cContaOs, loc_cGrupoDs, loc_cContaDs
        LOCAL loc_nEstoqs, loc_nQtdIni, loc_nQtdFim
        LOCAL loc_nVezes, loc_cXEmps, loc_cXEmpDs, loc_nNumes, loc_cMsg
        LOCAL loc_cEmps, loc_cEmpds, loc_nPecas, loc_cProd, loc_nCBars, loc_cCor, loc_cTam
        LOCAL loc_cCpros, loc_cDpros, loc_nPvens, loc_cMoevs, loc_cCunis, loc_nPesos
        LOCAL loc_nBarra, loc_lPular, loc_cChaveMvCab, loc_cChaveMvItn, loc_cChaveMvIts
        LOCAL loc_dPrz, loc_cEmpDopNums, loc_cPCidC, loc_nPSeq
        loc_lResultado = .F.
        TRY
            IF USED("csPrNAOCad")
                USE IN csPrNAOCad
            ENDIF
            IF USED("csPrSemCT")
                USE IN csPrSemCT
            ENDIF
            CREATE CURSOR csPrNAOCad (Origem C(10), Destino C(10), Produto C(20), ;
                Quantidade N(12, 2), Grupo C(10), Barra N(14, 0), Cor C(4), Tamanho C(4))
            CREATE CURSOR csPrSemCT (Referencia C(25), Unidade C(3), ;
                Qtds N(12, 2), Pesos N(12, 2), Valor N(12, 2))

            loc_cDopes = ALLTRIM(THIS.this_cDopImpPlan)
            IF EMPTY(loc_cDopes)
                MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o da Importa" + CHR(231) + CHR(227) + "o da Planilha n" + CHR(227) + "o Informada." + CHR(13) + CHR(13) + ;
                    "Par" + CHR(226) + "metros do Sistema > Diversos > Geral", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            SQLEXEC(gnConnHandle, "SELECT * FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes), "crSigCdOpe")
            SELECT crSigCdOpe
            IF EMPTY(crSigCdOpe.GruOrigs) OR EMPTY(crSigCdOpe.ConOrigs)
                MsgAviso("Grupo ou Conta de Origem n" + CHR(227) + "o definido na Movimenta" + CHR(231) + CHR(227) + "o " + ALLTRIM(crSigCdOpe.Dopes), ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF
            IF EMPTY(crSigCdOpe.GruDests) OR EMPTY(crSigCdOpe.ConDests)
                MsgAviso("Grupo ou Conta de Destino n" + CHR(227) + "o definido na Movimenta" + CHR(231) + CHR(227) + "o " + ALLTRIM(crSigCdOpe.Dopes), ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            loc_cOpers   = IIF(crSigCdOpe.Opers = 1, "E", "S")
            loc_cGrupoOs = ALLTRIM(crSigCdOpe.GruOrigs)
            loc_cContaOs = ALLTRIM(crSigCdOpe.ConOrigs)
            loc_cGrupoDs = ALLTRIM(crSigCdOpe.GruDests)
            loc_cContaDs = ALLTRIM(crSigCdOpe.ConDests)
            loc_nEstoqs  = NVL(crSigCdOpe.Estoqs, 0)

            SELECT TmpPlanilha
            loc_nQtdIni = 0
            SCAN FOR !DELETED()
                loc_nQtdIni = loc_nQtdIni + 1
            ENDSCAN

            SELECT *, RTRIM(RIGHT(EmpresaO, 3)) AS Emps, RTRIM(RIGHT(EmpresaD, 3)) AS EmpDs ;
                FROM TmpPlanilha INTO CURSOR csTransf READWRITE
            SELECT csTransf
            INDEX ON Emps + EmpDs TAG Empresa
            GO TOP
            loc_nQtdFim = RECCOUNT("csTransf")

            IF loc_nQtdIni <> loc_nQtdFim
                MsgAviso("H" + CHR(225) + " Registros duplicados, Favor Verificar a Planilha.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            loc_nVezes  = 1
            loc_cXEmps  = "X"
            loc_cXEmpDs = "X"

            loc_loBarra = CREATEOBJECT("fwprogressbar", "Importando Transferencias...", RECCOUNT("csTransf"))
            loc_loBarra.Top = loc_loBarra.Top - INT(loc_loBarra.Height / 2) - 1
            loc_loBarra.Titulo.FontBold = .T.
            loc_loBarra.Show

            SQLEXEC(gnConnHandle, "SELECT Cemps FROM SigCdEmp", "crSigCdEmp")
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION", "")

            SELECT csTransf
            GO TOP
            SCAN
                loc_loBarra.Update(.T., "Empresa: " + ALLTRIM(csTransf.Emps))

                loc_cEmps  = PADR(ALLTRIM(NVL(csTransf.Emps, "")), 3)
                loc_cEmpds = PADR(ALLTRIM(NVL(csTransf.EmpDs, "")), 3)
                loc_nPecas = NVL(csTransf.Qtds, 0)
                loc_cProd  = ALLTRIM(NVL(csTransf.Cpros, ""))
                loc_nCBars = NVL(csTransf.Cbars, 0)
                loc_cCor   = ALLTRIM(NVL(csTransf.Cors, ""))
                loc_cTam   = ALLTRIM(NVL(csTransf.Tams, ""))
                loc_dPrz   = csTransf.Prazo

                IF loc_nPecas = 0 OR EMPTY(loc_cEmps) OR EMPTY(loc_cEmpds) OR EMPTY(loc_cProd)
                    SELECT csTransf
                    LOOP
                ENDIF

                loc_nBarra = IIF(!EMPTY(loc_nCBars) AND (!EMPTY(loc_cCor) OR !EMPTY(loc_cTam)), 0, loc_nCBars)

                SELECT crSigCdEmp
                LOCATE FOR ALLTRIM(Cemps) = ALLTRIM(loc_cEmps)
                IF !FOUND()
                    SELECT csTransf
                    LOOP
                ENDIF

                LOCATE FOR ALLTRIM(Cemps) = ALLTRIM(loc_cEmpds)
                IF !FOUND()
                    SELECT csTransf
                    LOOP
                ENDIF

                loc_cQuery = "SELECT Cpros, Dpros, PVens, Moevs, CUnis, PesoMs, ForaLinha, Situas, cgrus" + ;
                    " FROM SigCdPro WHERE " + ;
                    IIF(par_nTipo = 1, "Cpros", IIF(par_nTipo = 2, "Dpro2s", "Reffs")) + ;
                    " = " + EscaparSQL(loc_cProd)
                SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdPro")
                SELECT crSigCdPro
                IF EOF("crSigCdPro") OR EMPTY(crSigCdPro.Cpros)
                    SELECT csPrNAOCad
                    APPEND BLANK
                    REPLACE Produto    WITH NVL(loc_cProd, ""), ;
                            Quantidade WITH NVL(loc_nPecas, 0), ;
                            Cor        WITH NVL(loc_cCor, ""), ;
                            Tamanho    WITH NVL(loc_cTam, ""), ;
                            Barra      WITH NVL(loc_nCBars, 0), ;
                            Origem     WITH NVL(loc_cEmps, ""), ;
                            Destino    WITH NVL(loc_cEmpds, "") IN csPrNAOCad
                    SELECT csTransf
                    LOOP
                ENDIF

                IF NVL(crSigCdPro.ForaLinha, 0) = 1
                    IF !MsgConfirma("Produto " + ALLTRIM(crSigCdPro.Cpros) + " Descontinuado, Deseja importar mesmo descontinuado?")
                        SELECT csTransf
                        LOOP
                    ENDIF
                ENDIF
                IF NVL(crSigCdPro.Situas, 0) = 2
                    IF !MsgConfirma("Produto " + ALLTRIM(crSigCdPro.Cpros) + " Inativo, Deseja Importar mesmo Inativo?")
                        SELECT csTransf
                        LOOP
                    ENDIF
                ENDIF

                loc_cCpros = crSigCdPro.Cpros
                loc_cDpros = crSigCdPro.Dpros
                loc_nPvens = NVL(crSigCdPro.PVens, 0)
                loc_cMoevs = NVL(crSigCdPro.Moevs, "")
                loc_cCunis = NVL(crSigCdPro.CUnis, "")
                loc_nPesos = NVL(crSigCdPro.PesoMs, 0)

                IF !EMPTY(loc_nBarra)
                    SQLEXEC(gnConnHandle, "SELECT Cbars, CPros FROM SigOpEtq WHERE Cbars = " + FormatarNumeroSQL(loc_nBarra, 0), "crSigOpEtq")
                    IF EOF("crSigOpEtq") OR ALLTRIM(crSigOpEtq.Cpros) <> ALLTRIM(loc_cCpros)
                        SELECT csTransf
                        LOOP
                    ENDIF
                ENDIF

                IF !EMPTY(loc_cTam)
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigCdTam WHERE Cods = " + EscaparSQL(loc_cTam), "crTmpTam")
                    IF EOF("crTmpTam")
                        loc_cTam = ""
                    ENDIF
                ENDIF

                IF !EMPTY(loc_cCor)
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigCdCor WHERE Cods = " + EscaparSQL(loc_cCor), "crTmpCor")
                    IF EOF("crTmpCor")
                        loc_cCor = ""
                    ENDIF
                ENDIF

                loc_cQuery = "SELECT TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, mtPrimas, LocalPdr" + ;
                    " FROM SigCdGrp WHERE CGrus = " + EscaparSQL(ALLTRIM(crSigCdPro.CGrus)) + ;
                    " ORDER BY TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas"
                IF SQLEXEC(gnConnHandle, loc_cQuery, "crTmpGru") < 1
                    MsgErro("Falha na Conex" + CHR(227) + "o (crTmpGru)", "Erro")
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "")
                    loc_lResultado = .F.
                ENDIF

                loc_lPular = .F.
                IF EMPTY(loc_cTam) AND INLIST(NVL(crTmpGru.TipoEstos, 0), 3, 4)
                    loc_lPular = .T.
                ENDIF
                IF EMPTY(loc_cCor) AND INLIST(NVL(crTmpGru.TipoEstos, 0), 2, 4)
                    loc_lPular = .T.
                ENDIF

                IF loc_lPular
                    SELECT csPrSemCT
                    APPEND BLANK
                    REPLACE Referencia WITH NVL(loc_cCpros, ""), ;
                            Qtds       WITH NVL(loc_nPecas, 0), ;
                            Pesos      WITH NVL(loc_nPesos, 0), ;
                            Unidade    WITH NVL(loc_cCunis, ""), ;
                            Valor      WITH NVL(loc_nPvens, 0) IN csPrSemCT
                ELSE
                    IF loc_cEmps <> loc_cXEmps OR loc_cEmpds <> loc_cXEmpDs
                        loc_cXEmps  = loc_cEmps
                        loc_cXEmpDs = loc_cEmpds
                        loc_nVezes  = 1000
                    ENDIF

                    IF loc_nVezes > 999
                        loc_nNumes   = fGerUniqueKey(ALLTRIM(loc_cDopes) + loc_cEmps)
                        loc_cEmpDopNums = loc_cEmps + loc_cDopes + STR(loc_nNumes, 6)
                        loc_cChaveMvCab = fUniqueIds()
                        loc_cSQL = "INSERT INTO SigMvCab" + ;
                            " (Datars,DataS,Dopes,Emps,EmpDs,Numes,MascNum,GrupoOs,ContaOs,GrupoDs,ContaDs," + ;
                            "CIdChaves,DtAlts,EmpDopNums,usuals,Usuars,PrazoEnts)" + ;
                            " VALUES (GETDATE(),GETDATE()," + ;
                            EscaparSQL(loc_cDopes) + "," + ;
                            EscaparSQL(loc_cEmps) + "," + ;
                            EscaparSQL(loc_cEmpds) + "," + ;
                            FormatarNumeroSQL(loc_nNumes, 0) + "," + ;
                            EscaparSQL(fGerMascara(loc_nNumes)) + "," + ;
                            EscaparSQL(loc_cGrupoOs) + "," + ;
                            EscaparSQL(loc_cContaOs) + "," + ;
                            EscaparSQL(loc_cGrupoDs) + "," + ;
                            EscaparSQL(loc_cContaDs) + "," + ;
                            EscaparSQL(loc_cChaveMvCab) + "," + ;
                            "GETDATE()," + ;
                            EscaparSQL(loc_cEmpDopNums) + "," + ;
                            EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                            EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                            IIF(!EMPTY(loc_dPrz), FormatarDataSQL(loc_dPrz), "NULL") + ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                            MsgErro("Falha na Conex" + CHR(227) + "o (INSERT SigMvCab)", "Erro")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "")
                            loc_lResultado = .F.
                        ENDIF
                        loc_nVezes = 1
                    ENDIF

                    loc_cChaveMvItn = fUniqueIds()
                    loc_cEmpDopNums = loc_cEmps + loc_cDopes + STR(loc_nNumes, 6)
                    loc_cSQL = "INSERT INTO SigMvItn" + ;
                        " (Cpros,Dopes,Emps,Numes,Opers,Qtds,CItens,Units,Totas,Moedas,Dpros,AQtds,CUnis,CIdChaves,DtAlts,EmpDopNums,Pesos,codbarras)" + ;
                        " VALUES (" + ;
                        EscaparSQL(loc_cCpros) + "," + ;
                        EscaparSQL(loc_cDopes) + "," + ;
                        EscaparSQL(loc_cEmps) + "," + ;
                        FormatarNumeroSQL(loc_nNumes, 0) + "," + ;
                        EscaparSQL(loc_cOpers) + "," + ;
                        FormatarNumeroSQL(loc_nPecas, 3) + "," + ;
                        FormatarNumeroSQL(loc_nVezes, 0) + "," + ;
                        FormatarNumeroSQL(loc_nPvens, 5) + "," + ;
                        FormatarNumeroSQL(loc_nPvens * loc_nPecas, 5) + "," + ;
                        EscaparSQL(loc_cMoevs) + "," + ;
                        EscaparSQL(loc_cDpros) + "," + ;
                        FormatarNumeroSQL(loc_nPecas, 3) + "," + ;
                        EscaparSQL(loc_cCunis) + "," + ;
                        EscaparSQL(loc_cChaveMvItn) + "," + ;
                        FormatarDataSQL(DATE()) + "," + ;
                        EscaparSQL(loc_cEmpDopNums) + "," + ;
                        FormatarNumeroSQL(loc_nPesos, 5) + "," + ;
                        FormatarNumeroSQL(loc_nBarra, 0) + ")"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                        MsgErro("Falha na Conex" + CHR(227) + "o (INSERT SigMvItn)", "Erro")
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "")
                        loc_lResultado = .F.
                    ENDIF

                    IF !EMPTY(loc_cCor) OR !EMPTY(loc_cTam)
                        loc_cChaveMvIts = fUniqueIds()
                        loc_cSQL = "INSERT INTO SigMvIts" + ;
                            " (Emps,Dopes,Numes,Cpros,CodTams,CodCors,Qtds,AQtds,codbarras,Pesos,CIdChaves,EmpDopNums,chksubn,CItens)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cEmps) + "," + ;
                            EscaparSQL(loc_cDopes) + "," + ;
                            FormatarNumeroSQL(loc_nNumes, 0) + "," + ;
                            EscaparSQL(loc_cCpros) + "," + ;
                            EscaparSQL(loc_cTam) + "," + ;
                            EscaparSQL(loc_cCor) + "," + ;
                            FormatarNumeroSQL(loc_nPecas, 3) + "," + ;
                            FormatarNumeroSQL(loc_nPecas, 3) + "," + ;
                            FormatarNumeroSQL(loc_nCBars, 0) + "," + ;
                            FormatarNumeroSQL(loc_nPesos, 5) + "," + ;
                            EscaparSQL(loc_cChaveMvIts) + "," + ;
                            EscaparSQL(loc_cEmpDopNums) + "," + ;
                            "0," + ;
                            FormatarNumeroSQL(loc_nVezes, 0) + ")"
                        SQLEXEC(gnConnHandle, loc_cSQL, "")
                    ENDIF

                    IF loc_nEstoqs = 1
                        loc_cPCidC = DTOS(DATE()) + loc_cOpers + ;
                            TRANSFORM(fGerUniqueKey(DTOS(DATE())), "@L 999999") + THIS.this_cSigKey
                        loc_nPSeq  = fGerUniqueKey("HISTBAR")
                        loc_cSQL = "INSERT INTO SigMvHst" + ;
                            " (Cpros,Datars,DataS,DtAudits,Dopes,EmpOs,Emps,Opers,Numes,Qtds,Units,Totas,Grupos," + ;
                            "Estos,CIdChaves,EmpDopNums,EmpGruEsts,Oridopnums,Seqs,Pesos,Usuars,codbarras,CodTams,CodCors)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cCpros) + ",GETDATE(),GETDATE(),NULL," + ;
                            EscaparSQL(loc_cDopes) + "," + ;
                            EscaparSQL(loc_cEmps) + "," + ;
                            EscaparSQL(loc_cEmps) + "," + ;
                            EscaparSQL(loc_cOpers) + "," + ;
                            FormatarNumeroSQL(loc_nNumes, 0) + "," + ;
                            FormatarNumeroSQL(loc_nPecas, 3) + "," + ;
                            FormatarNumeroSQL(loc_nPvens, 5) + "," + ;
                            FormatarNumeroSQL(loc_nPvens * loc_nPecas, 5) + "," + ;
                            EscaparSQL(loc_cGrupoOs) + "," + ;
                            EscaparSQL(loc_cContaOs) + "," + ;
                            EscaparSQL(loc_cPCidC) + "," + ;
                            EscaparSQL(loc_cEmpDopNums) + "," + ;
                            EscaparSQL(loc_cEmps + loc_cGrupoOs + loc_cContaOs) + "," + ;
                            EscaparSQL(loc_cEmpDopNums) + "," + ;
                            FormatarNumeroSQL(loc_nPSeq, 0) + "," + ;
                            FormatarNumeroSQL(loc_nPesos, 5) + "," + ;
                            EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                            FormatarNumeroSQL(loc_nCBars, 0) + "," + ;
                            EscaparSQL(loc_cTam) + "," + ;
                            EscaparSQL(loc_cCor) + ")"
                        SQLEXEC(gnConnHandle, loc_cSQL, "")

                        SQLEXEC(gnConnHandle, "SELECT * FROM SigMvHst WHERE CIdChaves = " + ;
                            EscaparSQL(loc_cPCidC), "crSigMvHstCur")
                        IF !EOF("crSigMvHstCur")
                            =SqlCalcP2(crSigMvHstCur.Emps, crSigMvHstCur.Grupos, crSigMvHstCur.Estos, ;
                                crSigMvHstCur.Cpros, crSigMvHstCur.DataS, ;
                                crSigMvHstCur.CodCors, crSigMvHstCur.CodTams, gnConnHandle)
                            =fRecalculaC(crSigMvHstCur.Emps, crSigMvHstCur.Cpros, crSigMvHstCur.DataS, gnConnHandle)
                        ENDIF
                    ENDIF

                    IF !EMPTY(loc_nCBars) AND loc_cOpers = "S"
                        loc_cSQL = "UPDATE SigOpEtq SET Contas = SPACE(10), Grupos = SPACE(10)" + ;
                            " WHERE Cbars = " + FormatarNumeroSQL(loc_nCBars, 0)
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                            MsgErro("Falha na Conex" + CHR(227) + "o (UPDATE SigOpEtq)", "Erro")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "")
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF

                    loc_nVezes = loc_nVezes + 1
                ENDIF
                SELECT csTransf
            ENDSCAN
            loc_loBarra.Complete(.T.)

            SELECT csPrNAOCad
            GO TOP
            IF RECCOUNT("csPrNAOCad") > 0
                loc_cMsg = "Houve Produtos n" + CHR(227) + "o Importados" + CHR(13) + CHR(13) + ;
                    "Arquivo : " + ADDBS(SYS(5) + SYS(2003)) + "TRANSFERENCIA_NAO_IMPORTADA.XLS"
                MsgAviso(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
                COPY TO (ADDBS(SYS(5) + SYS(2003)) + "TRANSFERENCIA_NAO_IMPORTADA") XL5
            ENDIF

            SELECT csPrSemCT
            GO TOP
            IF RECCOUNT("csPrSemCT") > 0
                loc_cMsg = "Houve produtos n" + CHR(227) + "o Importados" + CHR(13) + CHR(13) + ;
                    "Arquivo : " + ADDBS(SYS(5) + SYS(2003)) + "PRODUTOS_SEM_CORTAMANHO.XLS"
                MsgAviso(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
                COPY TO (ADDBS(SYS(5) + SYS(2003)) + "PRODUTOS_SEM_CORTAMANHO") XL5
            ENDIF

            *-- Atualiza totais SigMvCab.Valos
            loc_cSQL = "UPDATE SigMvCab SET Valos = (" + ;
                "SELECT SUM(Totas) FROM SigMvItn" + ;
                " WHERE SigMvItn.EmpDopNums = SigMvCab.EmpDopNums" + ;
                ") WHERE Dopes = " + EscaparSQL(loc_cDopes) + ;
                " AND Emps = " + EscaparSQL(loc_cEmps)
            SQLEXEC(gnConnHandle, loc_cSQL, "")

            THIS.this_nValorAcumulado = 0

            =fGravarLog("T", loc_cDopes, "SIGPRILA", ;
                "Importa" + CHR(231) + CHR(227) + "o da Planilha de Tranferencia: " + par_nTipo, ;
                gc_4c_UsuarioLogado)

            =SqlCalcP2(.T., gnConnHandle)
            =fRecalculaC(.T., .F., .F., gnConnHandle)

            IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION", "") < 1
                MsgErro("Falha na Grava" + CHR(231) + CHR(227) + "o dos Dados.", "Erro")
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "")
                loc_lResultado = .F.
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPedidoTerceiro - Importa pedidos de terceiros (gerapedido)
    *--------------------------------------------------------------------------
    FUNCTION ProcessarPedidoTerceiro(par_nTipo, par_nPreco)
        LOCAL loc_lResultado, loc_oErro, loc_loBarra, loc_cQuery, loc_cSQL, loc_cMsg
        LOCAL loc_cDopes, loc_cOpers, loc_cGrupoOs, loc_cContaOs, loc_cGrupoDs, loc_cContaDs
        LOCAL loc_nEstoqs, loc_cGrupoCs, loc_cContaCs, loc_nQtdIni, loc_nQtdFim
        LOCAL loc_nVezes, loc_cXEmps, loc_cXEmpDs, loc_nNumes, loc_cEmpDopNums
        LOCAL loc_cEmps, loc_cEmpDs, loc_nPecas, loc_cProd, loc_nCBars, loc_cCor, loc_cTam
        LOCAL loc_cCpros, loc_cDpros, loc_nPvens, loc_cMoevs, loc_cCunis, loc_nPesos
        LOCAL loc_nBarra, loc_lPular, loc_cChaveMvCab, loc_dPrz, loc_cContaOsItem
        LOCAL loc_cPCidC, loc_nPSeq
        loc_lResultado = .F.
        TRY
            IF USED("csPrNAOCad")
                USE IN csPrNAOCad
            ENDIF
            IF USED("csPrSemCT")
                USE IN csPrSemCT
            ENDIF
            CREATE CURSOR csPrNAOCad (Origem C(10), Destino C(10), Produto C(20), ;
                Quantidade N(12, 2), Grupo C(10), Barra N(14, 0), Cor C(4), Tamanho C(4))
            CREATE CURSOR csPrSemCT (Referencia C(25), Unidade C(3), ;
                Qtds N(12, 2), Pesos N(12, 2), Valor N(12, 2))

            loc_cDopes = ALLTRIM(THIS.this_cDopTrfPed)
            IF EMPTY(loc_cDopes)
                MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o da Importa" + CHR(231) + CHR(227) + "o da Planilha n" + CHR(227) + "o Informada." + CHR(13) + CHR(13) + ;
                    "Par" + CHR(226) + "metros do Sistema > Diversos > Geral", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            SQLEXEC(gnConnHandle, "SELECT * FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes), "crSigCdOpe")
            SQLEXEC(gnConnHandle, "SELECT * FROM SigOpCdd WHERE Dopes = " + EscaparSQL(loc_cDopes), "crSigOpCdd")
            SELECT crSigCdOpe

            IF EMPTY(crSigCdOpe.GruOrigs)
                MsgAviso("Grupo de Origem n" + CHR(227) + "o definido na Movimenta" + CHR(231) + CHR(227) + "o " + ALLTRIM(crSigCdOpe.Dopes), ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF
            IF EMPTY(crSigCdOpe.GruDests) OR EMPTY(crSigCdOpe.ConDests)
                MsgAviso("Grupo ou Conta de Destino n" + CHR(227) + "o definido na Movimenta" + CHR(231) + CHR(227) + "o " + ALLTRIM(crSigCdOpe.Dopes), ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            loc_cOpers   = IIF(NVL(crSigCdOpe.Opers, 0) = 1, "E", "S")
            loc_cGrupoOs = ALLTRIM(crSigCdOpe.GruOrigs)
            loc_cContaOs = ALLTRIM(NVL(crSigCdOpe.ConOrigs, ""))
            loc_cGrupoDs = ALLTRIM(crSigCdOpe.GruDests)
            loc_cContaDs = ALLTRIM(crSigCdOpe.ConDests)
            loc_nEstoqs  = NVL(crSigCdOpe.Estoqs, 0)
            loc_cGrupoCs = ALLTRIM(NVL(crSigOpCdd.GruposCC, ""))
            loc_cContaCs = ALLTRIM(NVL(crSigOpCdd.ContasCC, ""))

            SELECT TmpPlanilha
            loc_nQtdIni = 0
            SCAN FOR !DELETED()
                IF EMPTY(TmpPlanilha.Empds) OR EMPTY(TmpPlanilha.Emps)
                    LOOP
                ENDIF
                loc_nQtdIni = loc_nQtdIni + 1
            ENDSCAN

            SELECT DISTINCT * FROM TmpPlanilha INTO CURSOR csTransf READWRITE
            SELECT csTransf
            INDEX ON Empds TAG Empresa
            GO TOP
            loc_nQtdFim = 0
            SCAN FOR !DELETED()
                IF EMPTY(csTransf.Empds) OR EMPTY(csTransf.Emps)
                    LOOP
                ENDIF
                loc_nQtdFim = loc_nQtdFim + 1
            ENDSCAN

            IF loc_nQtdIni <> loc_nQtdFim
                MsgAviso("H" + CHR(225) + " Registros duplicados, Favor Verificar a Planilha.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            loc_nVezes  = 1
            loc_cXEmps  = "X"
            loc_cXEmpDs = "X"

            loc_loBarra = CREATEOBJECT("fwprogressbar", "Importando Transferencias...", RECCOUNT("csTransf"))
            loc_loBarra.Top = loc_loBarra.Top - INT(loc_loBarra.Height / 2) - 1
            loc_loBarra.Titulo.FontBold = .T.
            loc_loBarra.Show

            SQLEXEC(gnConnHandle, "SELECT Cemps FROM SigCdEmp", "crSigCdEmp")
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION", "")

            SELECT csTransf
            GO TOP
            SCAN
                loc_loBarra.Update(.T., "Empresa: " + ALLTRIM(csTransf.EmpDs))

                loc_cEmps       = PADR(ALLTRIM(NVL(csTransf.Emps, "")), 3)
                loc_cEmpDs      = PADR(ALLTRIM(NVL(csTransf.Empds, "")), 3)
                loc_nPecas      = NVL(csTransf.Qtds, 0)
                loc_cProd       = ALLTRIM(NVL(csTransf.Cpros, ""))
                loc_nCBars      = 0
                loc_cCor        = ALLTRIM(NVL(csTransf.Cors, ""))
                loc_cTam        = ALLTRIM(NVL(csTransf.Tams, ""))
                loc_nPesos      = NVL(csTransf.Pesos, 0)
                loc_cContaOsItem = ALLTRIM(NVL(csTransf.ContaOs, ""))
                loc_dPrz        = csTransf.Prazo

                IF loc_nPecas = 0 OR EMPTY(loc_cEmps) OR EMPTY(loc_cEmpDs) OR ;
                        EMPTY(loc_cContaOsItem) OR EMPTY(loc_cProd)
                    SELECT csTransf
                    LOOP
                ENDIF

                loc_nBarra = IIF(!EMPTY(loc_nCBars) AND (!EMPTY(loc_cCor) OR !EMPTY(loc_cTam)), 0, loc_nCBars)

                SELECT crSigCdEmp
                LOCATE FOR ALLTRIM(Cemps) = ALLTRIM(loc_cEmps)
                IF !FOUND()
                    SELECT csTransf
                    LOOP
                ENDIF
                LOCATE FOR ALLTRIM(Cemps) = ALLTRIM(loc_cEmpDs)
                IF !FOUND()
                    SELECT csTransf
                    LOOP
                ENDIF
                SQLEXEC(gnConnHandle, "SELECT Iclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cContaOsItem), "crSigCdCli")
                IF EOF("crSigCdCli")
                    SELECT csTransf
                    LOOP
                ENDIF

                loc_cQuery = "SELECT Cpros, Dpros, PVens, Moevs, CUnis, PesoMs, ForaLinha, Situas, moecusfs, custofs, cgrus" + ;
                    " FROM SigCdPro WHERE " + ;
                    IIF(par_nTipo = 1, "Cpros", IIF(par_nTipo = 2, "Dpro2s", "Reffs")) + ;
                    " = " + EscaparSQL(loc_cProd)
                SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdPro")
                SELECT crSigCdPro
                IF EOF("crSigCdPro") OR EMPTY(crSigCdPro.Cpros)
                    SELECT csPrNAOCad
                    APPEND BLANK
                    REPLACE Produto    WITH NVL(loc_cProd, ""), ;
                            Quantidade WITH NVL(loc_nPecas, 0), ;
                            Cor        WITH NVL(loc_cCor, ""), ;
                            Tamanho    WITH NVL(loc_cTam, ""), ;
                            Barra      WITH NVL(loc_nCBars, 0), ;
                            Origem     WITH NVL(loc_cEmps, ""), ;
                            Destino    WITH NVL(loc_cEmpDs, "") IN csPrNAOCad
                    SELECT csTransf
                    LOOP
                ENDIF

                IF NVL(crSigCdPro.ForaLinha, 0) = 1
                    IF !MsgConfirma("Produto " + ALLTRIM(crSigCdPro.Cpros) + " Descontinuado, Deseja importar mesmo descontinuado?")
                        SELECT csTransf
                        LOOP
                    ENDIF
                ENDIF
                IF NVL(crSigCdPro.Situas, 0) = 2
                    IF !MsgConfirma("Produto " + ALLTRIM(crSigCdPro.Cpros) + " Inativo, Deseja Importar mesmo Inativo?")
                        SELECT csTransf
                        LOOP
                    ENDIF
                ENDIF

                loc_cCpros = crSigCdPro.Cpros
                loc_cDpros = crSigCdPro.Dpros
                IF par_nPreco = 1
                    loc_nPvens = NVL(crSigCdPro.PVens, 0)
                    loc_cMoevs = NVL(crSigCdPro.Moevs, "")
                ELSE
                    loc_nPvens = NVL(crSigCdPro.custofs, 0)
                    loc_cMoevs = NVL(crSigCdPro.moecusfs, "")
                ENDIF
                loc_cCunis = NVL(crSigCdPro.CUnis, "")
                loc_nPesos = IIF(EMPTY(loc_nPesos), NVL(crSigCdPro.PesoMs, 0), loc_nPesos)

                IF !EMPTY(loc_nBarra)
                    SQLEXEC(gnConnHandle, "SELECT Cbars, CPros FROM SigOpEtq WHERE Cbars = " + FormatarNumeroSQL(loc_nBarra, 0), "crSigOpEtq")
                    IF EOF("crSigOpEtq") OR ALLTRIM(crSigOpEtq.Cpros) <> ALLTRIM(loc_cCpros)
                        SELECT csTransf
                        LOOP
                    ENDIF
                ENDIF

                IF !EMPTY(loc_cTam)
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigCdTam WHERE Cods = " + EscaparSQL(loc_cTam), "crTmpTam")
                    IF EOF("crTmpTam")
                        loc_cTam = ""
                    ENDIF
                ENDIF
                IF !EMPTY(loc_cCor)
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigCdCor WHERE Cods = " + EscaparSQL(loc_cCor), "crTmpCor")
                    IF EOF("crTmpCor")
                        loc_cCor = ""
                    ENDIF
                ENDIF

                loc_cQuery = "SELECT TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, mtPrimas, LocalPdr" + ;
                    " FROM SigCdGrp WHERE CGrus = " + EscaparSQL(ALLTRIM(crSigCdPro.CGrus)) + ;
                    " ORDER BY TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas"
                IF SQLEXEC(gnConnHandle, loc_cQuery, "crTmpGru") < 1
                    MsgErro("Falha na Conex" + CHR(227) + "o (crTmpGru)", "Erro")
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "")
                    loc_lResultado = .F.
                ENDIF

                loc_lPular = .F.
                IF EMPTY(loc_cTam) AND INLIST(NVL(crTmpGru.TipoEstos, 0), 3, 4)
                    loc_lPular = .T.
                ENDIF
                IF EMPTY(loc_cCor) AND INLIST(NVL(crTmpGru.TipoEstos, 0), 2, 4)
                    loc_lPular = .T.
                ENDIF

                IF loc_lPular
                    SELECT csPrSemCT
                    APPEND BLANK
                    REPLACE Referencia WITH NVL(loc_cCpros, ""), ;
                            Qtds       WITH NVL(loc_nPecas, 0), ;
                            Pesos      WITH NVL(loc_nPesos, 0), ;
                            Unidade    WITH NVL(loc_cCunis, ""), ;
                            Valor      WITH NVL(loc_nPvens, 0) IN csPrSemCT
                ELSE
                    IF loc_cEmps <> loc_cXEmps OR loc_cEmpDs <> loc_cXEmpDs
                        loc_cXEmps  = loc_cEmps
                        loc_cXEmpDs = loc_cEmpDs
                        loc_nVezes  = 1000
                    ENDIF

                    IF loc_nVezes > 999
                        loc_nNumes   = fGerUniqueKey(ALLTRIM(loc_cDopes) + loc_cEmps)
                        loc_cEmpDopNums = loc_cEmps + loc_cDopes + STR(loc_nNumes, 6)
                        loc_cChaveMvCab = fUniqueIds()
                        loc_cSQL = "INSERT INTO SigMvCab" + ;
                            " (Datars,DataS,Dopes,Emps,EmpDs,Numes,MascNum,GrupoOs,ContaOs,GrupoDs,ContaDs," + ;
                            "CIdChaves,DtAlts,EmpDopNums,usuals,Usuars,PrazoEnts,grupoccs,contaccs)" + ;
                            " VALUES (GETDATE(),GETDATE()," + ;
                            EscaparSQL(loc_cDopes) + "," + ;
                            EscaparSQL(loc_cEmps) + "," + ;
                            EscaparSQL(loc_cEmpDs) + "," + ;
                            FormatarNumeroSQL(loc_nNumes, 0) + "," + ;
                            EscaparSQL(fGerMascara(loc_nNumes)) + "," + ;
                            EscaparSQL(loc_cGrupoOs) + "," + ;
                            EscaparSQL(loc_cContaOsItem) + "," + ;
                            EscaparSQL(loc_cGrupoDs) + "," + ;
                            EscaparSQL(loc_cContaDs) + "," + ;
                            EscaparSQL(loc_cChaveMvCab) + "," + ;
                            "GETDATE()," + ;
                            EscaparSQL(loc_cEmpDopNums) + "," + ;
                            EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                            EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                            IIF(!EMPTY(loc_dPrz), FormatarDataSQL(loc_dPrz), "NULL") + "," + ;
                            EscaparSQL(loc_cGrupoCs) + "," + ;
                            EscaparSQL(loc_cContaCs) + ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                            MsgErro("Falha na Conex" + CHR(227) + "o (INSERT SigMvCab Pedido)", "Erro")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "")
                            loc_lResultado = .F.
                        ENDIF
                        loc_nVezes = 1
                    ENDIF

                    loc_cEmpDopNums = loc_cEmps + loc_cDopes + STR(loc_nNumes, 6)
                    loc_cSQL = "INSERT INTO SigMvItn" + ;
                        " (Cpros,Dopes,Emps,Numes,Opers,Qtds,CItens,Units,Totas,Moedas,Dpros,AQtds,CUnis,CIdChaves,DtAlts,EmpDopNums,Pesos,codbarras)" + ;
                        " VALUES (" + ;
                        EscaparSQL(loc_cCpros) + "," + ;
                        EscaparSQL(loc_cDopes) + "," + ;
                        EscaparSQL(loc_cEmps) + "," + ;
                        FormatarNumeroSQL(loc_nNumes, 0) + "," + ;
                        EscaparSQL(loc_cOpers) + "," + ;
                        FormatarNumeroSQL(loc_nPecas, 3) + "," + ;
                        FormatarNumeroSQL(loc_nVezes, 0) + "," + ;
                        FormatarNumeroSQL(loc_nPvens, 5) + "," + ;
                        FormatarNumeroSQL(loc_nPvens * loc_nPecas, 5) + "," + ;
                        EscaparSQL(loc_cMoevs) + "," + ;
                        EscaparSQL(loc_cDpros) + "," + ;
                        FormatarNumeroSQL(loc_nPecas, 3) + "," + ;
                        EscaparSQL(loc_cCunis) + "," + ;
                        EscaparSQL(fUniqueIds()) + "," + ;
                        FormatarDataSQL(DATE()) + "," + ;
                        EscaparSQL(loc_cEmpDopNums) + "," + ;
                        FormatarNumeroSQL(loc_nPesos, 5) + "," + ;
                        FormatarNumeroSQL(loc_nBarra, 0) + ")"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                        MsgErro("Falha na Conex" + CHR(227) + "o (INSERT SigMvItn Pedido)", "Erro")
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "")
                        loc_lResultado = .F.
                    ENDIF

                    IF !EMPTY(loc_cCor) OR !EMPTY(loc_cTam)
                        loc_cSQL = "INSERT INTO SigMvIts" + ;
                            " (Emps,Dopes,Numes,Cpros,CodTams,CodCors,Qtds,AQtds,codbarras,Pesos,CIdChaves,EmpDopNums,chksubn,CItens)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cEmps) + "," + ;
                            EscaparSQL(loc_cDopes) + "," + ;
                            FormatarNumeroSQL(loc_nNumes, 0) + "," + ;
                            EscaparSQL(loc_cCpros) + "," + ;
                            EscaparSQL(loc_cTam) + "," + ;
                            EscaparSQL(loc_cCor) + "," + ;
                            FormatarNumeroSQL(loc_nPecas, 3) + "," + ;
                            FormatarNumeroSQL(loc_nPecas, 3) + "," + ;
                            FormatarNumeroSQL(loc_nCBars, 0) + "," + ;
                            FormatarNumeroSQL(loc_nPesos, 5) + "," + ;
                            EscaparSQL(fUniqueIds()) + "," + ;
                            EscaparSQL(loc_cEmpDopNums) + "," + ;
                            "0," + ;
                            FormatarNumeroSQL(loc_nVezes, 0) + ")"
                        SQLEXEC(gnConnHandle, loc_cSQL, "")
                    ENDIF

                    IF loc_nEstoqs = 1
                        loc_cPCidC = DTOS(DATE()) + loc_cOpers + ;
                            TRANSFORM(fGerUniqueKey(DTOS(DATE())), "@L 999999") + THIS.this_cSigKey
                        loc_nPSeq  = fGerUniqueKey("HISTBAR")
                        loc_cSQL = "INSERT INTO SigMvHst" + ;
                            " (Cpros,Datars,DataS,DtAudits,Dopes,EmpOs,Emps,Opers,Numes,Qtds,Units,Totas,Grupos," + ;
                            "Estos,CIdChaves,EmpDopNums,EmpGruEsts,Oridopnums,Seqs,Pesos,Usuars,codbarras,CodTams,CodCors)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cCpros) + ",GETDATE(),GETDATE(),NULL," + ;
                            EscaparSQL(loc_cDopes) + "," + ;
                            EscaparSQL(loc_cEmps) + "," + ;
                            EscaparSQL(loc_cEmps) + "," + ;
                            EscaparSQL(loc_cOpers) + "," + ;
                            FormatarNumeroSQL(loc_nNumes, 0) + "," + ;
                            FormatarNumeroSQL(loc_nPecas, 3) + "," + ;
                            FormatarNumeroSQL(loc_nPvens, 5) + "," + ;
                            FormatarNumeroSQL(loc_nPvens * loc_nPecas, 5) + "," + ;
                            EscaparSQL(loc_cGrupoOs) + "," + ;
                            EscaparSQL(loc_cContaOsItem) + "," + ;
                            EscaparSQL(loc_cPCidC) + "," + ;
                            EscaparSQL(loc_cEmpDopNums) + "," + ;
                            EscaparSQL(loc_cEmps + loc_cGrupoOs + loc_cContaOsItem) + "," + ;
                            EscaparSQL(loc_cEmpDopNums) + "," + ;
                            FormatarNumeroSQL(loc_nPSeq, 0) + "," + ;
                            FormatarNumeroSQL(loc_nPesos, 5) + "," + ;
                            EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                            FormatarNumeroSQL(loc_nCBars, 0) + "," + ;
                            EscaparSQL(loc_cTam) + "," + ;
                            EscaparSQL(loc_cCor) + ")"
                        SQLEXEC(gnConnHandle, loc_cSQL, "")

                        SQLEXEC(gnConnHandle, "SELECT * FROM SigMvHst WHERE CIdChaves = " + ;
                            EscaparSQL(loc_cPCidC), "crSigMvHstCur")
                        IF !EOF("crSigMvHstCur")
                            =SqlCalcP2(crSigMvHstCur.Emps, crSigMvHstCur.Grupos, crSigMvHstCur.Estos, ;
                                crSigMvHstCur.Cpros, crSigMvHstCur.DataS, ;
                                crSigMvHstCur.CodCors, crSigMvHstCur.CodTams, gnConnHandle)
                            =fRecalculaC(crSigMvHstCur.Emps, crSigMvHstCur.Cpros, crSigMvHstCur.DataS, gnConnHandle)
                        ENDIF
                    ENDIF

                    IF !EMPTY(loc_nCBars) AND loc_cOpers = "S"
                        loc_cSQL = "UPDATE SigOpEtq SET Contas = SPACE(10), Grupos = SPACE(10)" + ;
                            " WHERE Cbars = " + FormatarNumeroSQL(loc_nCBars, 0)
                        SQLEXEC(gnConnHandle, loc_cSQL, "")
                    ENDIF

                    loc_nVezes = loc_nVezes + 1
                ENDIF
                SELECT csTransf
            ENDSCAN
            loc_loBarra.Complete(.T.)

            SELECT csPrNAOCad
            GO TOP
            IF RECCOUNT("csPrNAOCad") > 0
                loc_cMsg = "Houve Produtos n" + CHR(227) + "o Importados" + CHR(13) + CHR(13) + ;
                    "Arquivo : " + ADDBS(SYS(5) + SYS(2003)) + "TRANSFERENCIA_NAO_IMPORTADA.XLS"
                MsgAviso(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
                COPY TO (ADDBS(SYS(5) + SYS(2003)) + "TRANSFERENCIA_NAO_IMPORTADA") XL5
            ENDIF
            SELECT csPrSemCT
            GO TOP
            IF RECCOUNT("csPrSemCT") > 0
                loc_cMsg = "Houve produtos n" + CHR(227) + "o Importados" + CHR(13) + CHR(13) + ;
                    "Arquivo : " + ADDBS(SYS(5) + SYS(2003)) + "PRODUTOS_SEM_CORTAMANHO.XLS"
                MsgAviso(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
                COPY TO (ADDBS(SYS(5) + SYS(2003)) + "PRODUTOS_SEM_CORTAMANHO") XL5
            ENDIF

            *-- Atualiza totais SigMvCab.Valos
            loc_cSQL = "UPDATE SigMvCab SET Valos = (" + ;
                "SELECT SUM(Totas) FROM SigMvItn" + ;
                " WHERE SigMvItn.EmpDopNums = SigMvCab.EmpDopNums" + ;
                ") WHERE Dopes = " + EscaparSQL(loc_cDopes) + ;
                " AND Emps = " + EscaparSQL(loc_cEmps)
            SQLEXEC(gnConnHandle, loc_cSQL, "")

            THIS.this_nValorAcumulado = 0

            *-- Verifica limite de credito se necessario
            IF INLIST(NVL(crSigCdOpe.Limcres, 0), 7)
                SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigMvCab WHERE Dopes = " + EscaparSQL(loc_cDopes) + ;
                    " AND Emps = " + EscaparSQL(loc_cEmps), "crSigMvCabFin")
                SELECT crSigMvCabFin
                GO TOP
                SCAN
                    IF !EMPTY(crSigOpCdd.GruposCC) AND !EMPTY(crSigOpCdd.ContasCC) AND ;
                            !EMPTY(crSigOpCdd.GruposEmt) AND !EMPTY(crSigOpCdd.ContasEmt)
                        IF !THIS.LimiteCreditoMatriz(crSigOpCdd.GruposCC, crSigOpCdd.ContasCC, ;
                                crSigOpCdd.GruposEmt, crSigOpCdd.ContasEmt, "Centro de Custo", ;
                                crSigMvCabFin.DataS, crSigMvCabFin.Valos, loc_cDopes, ;
                                crSigMvCabFin.Emps, crSigMvCabFin.Numes)
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "")
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT crSigMvCabFin
                ENDSCAN
            ENDIF

            =fGravarLog("T", loc_cDopes, "SIGPRILA", ;
                "Importa" + CHR(231) + CHR(227) + "o da Planilha de Tranferencia: " + TRANSFORM(par_nTipo), ;
                gc_4c_UsuarioLogado)

            =SqlCalcP2(.T., gnConnHandle)
            =fRecalculaC(.T., .F., .F., gnConnHandle)

            IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION", "") < 1
                MsgErro("Falha na Grava" + CHR(231) + CHR(227) + "o dos Dados.", "Erro")
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "")
                loc_lResultado = .F.
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPedidoConsignado - Importa pedidos consignados (pedidocons)
    *--------------------------------------------------------------------------
    FUNCTION ProcessarPedidoConsignado(par_nTipo, par_nPreco)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            *-- Logica identica ao PedidoTerceiro usando this_cDopPedCon como Dopes
            *-- Salva DopTrfPed e substitui temporariamente
            LOCAL loc_cDopOrig
            loc_cDopOrig = THIS.this_cDopTrfPed
            THIS.this_cDopTrfPed = THIS.this_cDopPedCon
            loc_lResultado = THIS.ProcessarPedidoTerceiro(par_nTipo, par_nPreco)
            THIS.this_cDopTrfPed = loc_cDopOrig
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPedidoFabrica - Importa pedidos de fabrica (pedidofab)
    *--------------------------------------------------------------------------
    FUNCTION ProcessarPedidoFabrica(par_nTipo, par_nPreco)
        LOCAL loc_lResultado, loc_oErro, loc_loBarra, loc_cQuery, loc_cSQL, loc_cMsg
        LOCAL loc_cDopesBase, loc_cOpers, loc_cGrupoDs, loc_cContaDs, loc_nEstoqs
        LOCAL loc_cGrupoCs, loc_cContaCs, loc_nVezes, loc_nNumes, loc_cEmpDopNums
        LOCAL loc_cEmps, loc_cEmpDs, loc_nPecas, loc_cProd, loc_nCBars, loc_cCor, loc_cTam
        LOCAL loc_cCpros, loc_cDpros, loc_nPvens, loc_cMoevs, loc_cCunis, loc_nPesos
        LOCAL loc_nBarra, loc_lPular, loc_nUnits, loc_cMoeda, loc_cPCidC, loc_nPSeq
        LOCAL loc_cContaOsItem, loc_cGrupoOs, loc_cLcGrupo, loc_dPrz
        loc_lResultado = .F.
        TRY
            IF USED("csPrNAOCad")
                USE IN csPrNAOCad
            ENDIF
            IF USED("csPrSemCT")
                USE IN csPrSemCT
            ENDIF
            CREATE CURSOR csPrNAOCad (Origem C(10), Destino C(10), Produto C(20), ;
                Quantidade N(12, 2), Grupo C(10), Barra N(14, 0), Cor C(4), Tamanho C(4))
            CREATE CURSOR csPrSemCT (Referencia C(25), Unidade C(3), ;
                Qtds N(12, 2), Pesos N(12, 2), Valor N(12, 2))

            *-- Empresa escalonada (ChkEsc = 1)
            IF SQLEXEC(gnConnHandle, "SELECT Cemps FROM SigCdEmp WHERE ChkEsc = 1", "crChkEsc") < 1
                MsgErro("Falha na Conex" + CHR(227) + "o (crChkEsc)", "Erro")
                loc_lResultado = .F.
            ENDIF
            loc_cEmps = ALLTRIM(NVL(crChkEsc.Cemps, ""))

            SELECT TmpPlanilha
            SELECT DISTINCT Contaos, Dopes, PrazoEnts FROM TmpPlanilha ;
                WHERE !EMPTY(ALLTRIM(NVL(Contaos, ""))) ;
                AND !EMPTY(ALLTRIM(NVL(Cpros, ""))) ;
                AND NVL(Qtds, 0) > 0 ;
                AND !EMPTY(ALLTRIM(NVL(Dopes, ""))) ;
                INTO CURSOR csMovPlan READWRITE

            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION", "")

            SELECT csMovPlan
            GO TOP
            SCAN
                loc_cDopesBase  = ALLTRIM(csMovPlan.Dopes)
                loc_cLcGrupo    = ""
                loc_nVezes      = 1000

                SQLEXEC(gnConnHandle, "SELECT * FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopesBase), "crSigCdOpe")
                SQLEXEC(gnConnHandle, "SELECT * FROM SigOpCdd WHERE Dopes = " + EscaparSQL(loc_cDopesBase), "crSigOpCdd")

                SELECT crSigCdOpe
                IF EMPTY(crSigCdOpe.GruOrigs)
                    SQLEXEC(gnConnHandle, "SELECT Grupos FROM SigCdCli WHERE Iclis = " + EscaparSQL(ALLTRIM(csMovPlan.Contaos)), "crTmpCli")
                    loc_cLcGrupo = ALLTRIM(NVL(crTmpCli.Grupos, ""))
                ELSE
                    loc_cLcGrupo = ALLTRIM(crSigCdOpe.GruOrigs)
                ENDIF

                IF EMPTY(crSigCdOpe.GruDests) OR EMPTY(crSigCdOpe.ConDests)
                    MsgAviso("Grupo ou Conta de Destino n" + CHR(227) + "o definido na Movimenta" + CHR(231) + CHR(227) + "o " + ALLTRIM(crSigCdOpe.Dopes), ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    SELECT csMovPlan
                    LOOP
                ENDIF

                loc_cOpers      = IIF(NVL(crSigCdOpe.Opers, 0) = 1, "E", "S")
                loc_cGrupoOs    = loc_cLcGrupo
                loc_cContaOsItem = ALLTRIM(csMovPlan.Contaos)
                loc_cGrupoDs    = ALLTRIM(crSigCdOpe.GruDests)
                loc_cContaDs    = ALLTRIM(crSigCdOpe.ConDests)
                loc_nEstoqs     = NVL(crSigCdOpe.Estoqs, 0)
                loc_cGrupoCs    = ALLTRIM(NVL(crSigOpCdd.GruposCC, ""))
                loc_cContaCs    = ALLTRIM(NVL(crSigOpCdd.ContasCC, ""))

                SELECT * FROM TmpPlanilha ;
                    WHERE RTRIM(Contaos) = ALLTRIM(m.loc_cContaOsItem) ;
                    AND RTRIM(Dopes) = ALLTRIM(m.loc_cDopesBase) ;
                    INTO CURSOR csPedFab READWRITE

                SELECT csPedFab
                GO TOP
                SCAN
                    loc_cEmpDs  = PADR(ALLTRIM(""), 3)
                    loc_nPecas  = NVL(csPedFab.Qtds, 0)
                    loc_cProd   = ALLTRIM(NVL(csPedFab.Cpros, ""))
                    loc_nCBars  = 0
                    loc_cCor    = ALLTRIM(NVL(csPedFab.Cors, ""))
                    loc_cTam    = ALLTRIM(NVL(csPedFab.Tams, ""))
                    loc_nPesos  = NVL(csPedFab.Pesos, 0)
                    loc_nUnits  = NVL(csPedFab.Units, 0)
                    loc_cMoeda  = ALLTRIM(NVL(csPedFab.Moedas, ""))
                    loc_dPrz    = csPedFab.PrazoEnts
                    loc_nBarra  = 0

                    IF loc_nPecas = 0 OR EMPTY(loc_cEmps) OR EMPTY(loc_cContaOsItem) OR EMPTY(loc_cProd)
                        SELECT csPedFab
                        LOOP
                    ENDIF

                    IF !EMPTY(loc_cTam)
                        SQLEXEC(gnConnHandle, "SELECT * FROM SigCdTam WHERE Cods = " + EscaparSQL(loc_cTam), "crTmpTam")
                        IF EOF("crTmpTam")
                            loc_cTam = ""
                        ENDIF
                    ENDIF
                    IF !EMPTY(loc_cCor)
                        SQLEXEC(gnConnHandle, "SELECT * FROM SigCdCor WHERE Cods = " + EscaparSQL(loc_cCor), "crTmpCor")
                        IF EOF("crTmpCor")
                            loc_cCor = ""
                        ENDIF
                    ENDIF

                    SQLEXEC(gnConnHandle, "SELECT Iclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cContaOsItem), "crSigCdCli")
                    IF EOF("crSigCdCli")
                        SELECT csPedFab
                        LOOP
                    ENDIF

                    loc_cQuery = "SELECT Cpros, Dpros, PVens, Moevs, CUnis, PesoMs, ForaLinha, Situas, custofs, moecusfs, cgrus" + ;
                        " FROM SigCdPro WHERE " + ;
                        IIF(par_nTipo = 1, "Cpros", IIF(par_nTipo = 2, "Dpro2s", "Reffs")) + ;
                        " = " + EscaparSQL(loc_cProd)
                    SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdPro")
                    SELECT crSigCdPro
                    IF EOF("crSigCdPro") OR EMPTY(crSigCdPro.Cpros)
                        SELECT csPrNAOCad
                        APPEND BLANK
                        REPLACE Produto    WITH NVL(loc_cProd, ""), ;
                                Quantidade WITH NVL(loc_nPecas, 0), ;
                                Cor        WITH NVL(loc_cCor, ""), ;
                                Tamanho    WITH NVL(loc_cTam, ""), ;
                                Barra      WITH NVL(loc_nCBars, 0), ;
                                Origem     WITH NVL(loc_cEmps, ""), ;
                                Destino    WITH NVL(loc_cEmpDs, "") IN csPrNAOCad
                        SELECT csPedFab
                        LOOP
                    ENDIF

                    loc_cCpros = crSigCdPro.Cpros
                    loc_cDpros = crSigCdPro.Dpros
                    IF par_nPreco = 1
                        loc_nPvens = NVL(crSigCdPro.PVens, 0)
                        loc_cMoevs = NVL(crSigCdPro.Moevs, "")
                    ELSE
                        loc_nPvens = NVL(crSigCdPro.custofs, 0)
                        loc_cMoevs = NVL(crSigCdPro.moecusfs, "")
                    ENDIF
                    IF !EMPTY(loc_nUnits)
                        loc_nPvens = loc_nUnits
                    ENDIF
                    IF !EMPTY(loc_cMoeda)
                        loc_cMoevs = loc_cMoeda
                    ENDIF
                    loc_cCunis = NVL(crSigCdPro.CUnis, "")
                    loc_nPesos = IIF(EMPTY(loc_nPesos), NVL(crSigCdPro.PesoMs, 0), loc_nPesos)

                    loc_cQuery = "SELECT TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, mtPrimas, LocalPdr" + ;
                        " FROM SigCdGrp WHERE CGrus = " + EscaparSQL(ALLTRIM(crSigCdPro.CGrus)) + ;
                        " ORDER BY TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas"
                    IF SQLEXEC(gnConnHandle, loc_cQuery, "crTmpGru") < 1
                        MsgErro("Falha na Conex" + CHR(227) + "o (crTmpGru Fab)", "Erro")
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "")
                        loc_lResultado = .F.
                    ENDIF

                    loc_lPular = .F.
                    IF EMPTY(loc_cTam) AND INLIST(NVL(crTmpGru.TipoEstos, 0), 3, 4)
                        loc_lPular = .T.
                    ENDIF
                    IF EMPTY(loc_cCor) AND INLIST(NVL(crTmpGru.TipoEstos, 0), 2, 4)
                        loc_lPular = .T.
                    ENDIF

                    IF loc_lPular
                        SELECT csPrSemCT
                        APPEND BLANK
                        REPLACE Referencia WITH NVL(loc_cCpros, ""), ;
                                Qtds       WITH NVL(loc_nPecas, 0), ;
                                Pesos      WITH NVL(loc_nPesos, 0), ;
                                Unidade    WITH NVL(loc_cCunis, ""), ;
                                Valor      WITH NVL(loc_nPvens, 0) IN csPrSemCT
                    ELSE
                        IF loc_nVezes > 999
                            loc_nNumes   = fGerUniqueKey(ALLTRIM(loc_cDopesBase) + loc_cEmps)
                            loc_cEmpDopNums = loc_cEmps + loc_cDopesBase + STR(loc_nNumes, 6)
                            loc_cSQL = "INSERT INTO SigMvCab" + ;
                                " (Datars,DataS,Dopes,Emps,EmpDs,Numes,MascNum,GrupoOs,Contaos,GrupoDs,ContaDs," + ;
                                "CIdChaves,DtAlts,EmpDopNums,usuals,Usuars,PrazoEnts,grupoccs,contaccs)" + ;
                                " VALUES (GETDATE(),GETDATE()," + ;
                                EscaparSQL(loc_cDopesBase) + "," + ;
                                EscaparSQL(loc_cEmps) + "," + ;
                                EscaparSQL(loc_cEmpDs) + "," + ;
                                FormatarNumeroSQL(loc_nNumes, 0) + "," + ;
                                EscaparSQL(fGerMascara(loc_nNumes)) + "," + ;
                                EscaparSQL(loc_cGrupoOs) + "," + ;
                                EscaparSQL(loc_cContaOsItem) + "," + ;
                                EscaparSQL(loc_cGrupoDs) + "," + ;
                                EscaparSQL(loc_cContaDs) + "," + ;
                                EscaparSQL(fUniqueIds()) + "," + ;
                                "GETDATE()," + ;
                                EscaparSQL(loc_cEmpDopNums) + "," + ;
                                EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                                EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                                IIF(!EMPTY(loc_dPrz), FormatarDataSQL(loc_dPrz), "NULL") + "," + ;
                                EscaparSQL(loc_cGrupoCs) + "," + ;
                                EscaparSQL(loc_cContaCs) + ")"
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                                MsgErro("Falha na Conex" + CHR(227) + "o (INSERT SigMvCab Fab)", "Erro")
                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "")
                                loc_lResultado = .F.
                            ENDIF
                            loc_nVezes = 1
                        ENDIF

                        loc_cEmpDopNums = loc_cEmps + loc_cDopesBase + STR(loc_nNumes, 6)
                        loc_cSQL = "INSERT INTO SigMvItn" + ;
                            " (Cpros,Dopes,Emps,Numes,Opers,Qtds,CItens,Units,Totas,Moedas,Dpros,AQtds,CUnis,CIdChaves,DtAlts,EmpDopNums,Pesos,codbarras)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cCpros) + "," + ;
                            EscaparSQL(loc_cDopesBase) + "," + ;
                            EscaparSQL(loc_cEmps) + "," + ;
                            FormatarNumeroSQL(loc_nNumes, 0) + "," + ;
                            EscaparSQL(loc_cOpers) + "," + ;
                            FormatarNumeroSQL(loc_nPecas, 3) + "," + ;
                            FormatarNumeroSQL(loc_nVezes, 0) + "," + ;
                            FormatarNumeroSQL(loc_nPvens, 5) + "," + ;
                            FormatarNumeroSQL(loc_nPvens * loc_nPecas, 5) + "," + ;
                            EscaparSQL(loc_cMoevs) + "," + ;
                            EscaparSQL(loc_cDpros) + "," + ;
                            FormatarNumeroSQL(loc_nPecas, 3) + "," + ;
                            EscaparSQL(loc_cCunis) + "," + ;
                            EscaparSQL(fUniqueIds()) + "," + ;
                            FormatarDataSQL(DATE()) + "," + ;
                            EscaparSQL(loc_cEmpDopNums) + "," + ;
                            FormatarNumeroSQL(loc_nPesos, 5) + "," + ;
                            FormatarNumeroSQL(loc_nBarra, 0) + ")"
                        SQLEXEC(gnConnHandle, loc_cSQL, "")

                        IF !EMPTY(loc_cCor) OR !EMPTY(loc_cTam)
                            loc_cSQL = "INSERT INTO SigMvIts" + ;
                                " (Emps,Dopes,Numes,Cpros,CodTams,CodCors,Qtds,AQtds,codbarras,Pesos,CIdChaves,EmpDopNums,chksubn,CItens)" + ;
                                " VALUES (" + ;
                                EscaparSQL(loc_cEmps) + "," + ;
                                EscaparSQL(loc_cDopesBase) + "," + ;
                                FormatarNumeroSQL(loc_nNumes, 0) + "," + ;
                                EscaparSQL(loc_cCpros) + "," + ;
                                EscaparSQL(loc_cTam) + "," + ;
                                EscaparSQL(loc_cCor) + "," + ;
                                FormatarNumeroSQL(loc_nPecas, 3) + "," + ;
                                FormatarNumeroSQL(loc_nPecas, 3) + "," + ;
                                FormatarNumeroSQL(loc_nCBars, 0) + "," + ;
                                FormatarNumeroSQL(loc_nPesos, 5) + "," + ;
                                EscaparSQL(fUniqueIds()) + "," + ;
                                EscaparSQL(loc_cEmpDopNums) + "," + ;
                                "0," + ;
                                FormatarNumeroSQL(loc_nVezes, 0) + ")"
                            SQLEXEC(gnConnHandle, loc_cSQL, "")
                        ENDIF

                        IF loc_nEstoqs = 1
                            loc_cPCidC = DTOS(DATE()) + loc_cOpers + ;
                                TRANSFORM(fGerUniqueKey(DTOS(DATE())), "@L 999999") + THIS.this_cSigKey
                            loc_nPSeq  = fGerUniqueKey("HISTBAR")
                            loc_cSQL = "INSERT INTO SigMvHst" + ;
                                " (Cpros,Datars,DataS,DtAudits,Dopes,EmpOs,Emps,Opers,Numes,Qtds,Units,Totas,Grupos," + ;
                                "Estos,CIdChaves,EmpDopNums,EmpGruEsts,Oridopnums,Seqs,Pesos,Usuars,codbarras,CodTams,CodCors)" + ;
                                " VALUES (" + ;
                                EscaparSQL(loc_cCpros) + ",GETDATE(),GETDATE(),NULL," + ;
                                EscaparSQL(loc_cDopesBase) + "," + ;
                                EscaparSQL(loc_cEmps) + "," + ;
                                EscaparSQL(loc_cEmps) + "," + ;
                                EscaparSQL(loc_cOpers) + "," + ;
                                FormatarNumeroSQL(loc_nNumes, 0) + "," + ;
                                FormatarNumeroSQL(loc_nPecas, 3) + "," + ;
                                FormatarNumeroSQL(loc_nPvens, 5) + "," + ;
                                FormatarNumeroSQL(loc_nPvens * loc_nPecas, 5) + "," + ;
                                EscaparSQL(loc_cGrupoOs) + "," + ;
                                EscaparSQL(loc_cContaOsItem) + "," + ;
                                EscaparSQL(loc_cPCidC) + "," + ;
                                EscaparSQL(loc_cEmpDopNums) + "," + ;
                                EscaparSQL(loc_cEmps + loc_cGrupoOs + loc_cContaOsItem) + "," + ;
                                EscaparSQL(loc_cEmpDopNums) + "," + ;
                                FormatarNumeroSQL(loc_nPSeq, 0) + "," + ;
                                FormatarNumeroSQL(loc_nPesos, 5) + "," + ;
                                EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                                FormatarNumeroSQL(loc_nCBars, 0) + "," + ;
                                EscaparSQL(loc_cTam) + "," + ;
                                EscaparSQL(loc_cCor) + ")"
                            SQLEXEC(gnConnHandle, loc_cSQL, "")

                            SQLEXEC(gnConnHandle, "SELECT * FROM SigMvHst WHERE CIdChaves = " + ;
                                EscaparSQL(loc_cPCidC), "crSigMvHstCur")
                            IF !EOF("crSigMvHstCur")
                                =SqlCalcP2(crSigMvHstCur.Emps, crSigMvHstCur.Grupos, crSigMvHstCur.Estos, ;
                                    crSigMvHstCur.Cpros, crSigMvHstCur.DataS, ;
                                    crSigMvHstCur.CodCors, crSigMvHstCur.CodTams, gnConnHandle)
                                =fRecalculaC(crSigMvHstCur.Emps, crSigMvHstCur.Cpros, crSigMvHstCur.DataS, gnConnHandle)
                            ENDIF
                        ENDIF
                        loc_nVezes = loc_nVezes + 1
                    ENDIF
                    SELECT csPedFab
                ENDSCAN

                loc_nVezes = 1
                SELECT csMovPlan
            ENDSCAN

            SELECT csPrNAOCad
            GO TOP
            IF RECCOUNT("csPrNAOCad") > 0
                MsgAviso("Houve Produtos n" + CHR(227) + "o Importados" + CHR(13) + CHR(13) + ;
                    "Arquivo : " + ADDBS(SYS(5) + SYS(2003)) + "TRANSFERENCIA_NAO_IMPORTADA.XLS", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                COPY TO (ADDBS(SYS(5) + SYS(2003)) + "TRANSFERENCIA_NAO_IMPORTADA") XL5
            ENDIF
            SELECT csPrSemCT
            GO TOP
            IF RECCOUNT("csPrSemCT") > 0
                MsgAviso("Houve produtos n" + CHR(227) + "o Importados" + CHR(13) + CHR(13) + ;
                    "Arquivo : " + ADDBS(SYS(5) + SYS(2003)) + "PRODUTOS_SEM_CORTAMANHO.XLS", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                COPY TO (ADDBS(SYS(5) + SYS(2003)) + "PRODUTOS_SEM_CORTAMANHO") XL5
            ENDIF

            *-- Atualiza totais
            loc_cSQL = "UPDATE SigMvCab SET Valos = (" + ;
                "SELECT SUM(Totas) FROM SigMvItn" + ;
                " WHERE SigMvItn.EmpDopNums = SigMvCab.EmpDopNums" + ;
                ") WHERE Dopes = " + EscaparSQL(loc_cDopesBase) + ;
                " AND Emps = " + EscaparSQL(loc_cEmps)
            SQLEXEC(gnConnHandle, loc_cSQL, "")

            THIS.this_nValorAcumulado = 0

            *-- Verifica limite de credito
            IF INLIST(NVL(crSigCdOpe.Limcres, 0), 7)
                SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigMvCab WHERE Dopes = " + EscaparSQL(loc_cDopesBase) + ;
                    " AND Emps = " + EscaparSQL(loc_cEmps), "crSigMvCabFin")
                SELECT crSigMvCabFin
                GO TOP
                SCAN
                    IF !EMPTY(crSigOpCdd.GruposCC) AND !EMPTY(crSigOpCdd.ContasCC) AND ;
                            !EMPTY(crSigOpCdd.GruposEmt) AND !EMPTY(crSigOpCdd.ContasEmt)
                        IF !THIS.LimiteCreditoMatriz(crSigOpCdd.GruposCC, crSigOpCdd.ContasCC, ;
                                crSigOpCdd.GruposEmt, crSigOpCdd.ContasEmt, "Centro de Custo", ;
                                crSigMvCabFin.DataS, crSigMvCabFin.Valos, loc_cDopesBase, ;
                                crSigMvCabFin.Emps, crSigMvCabFin.Numes)
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "")
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT crSigMvCabFin
                ENDSCAN
            ENDIF

            =fGravarLog("T", loc_cDopesBase, "SIGPRILA", ;
                "Importa" + CHR(231) + CHR(227) + "o da Planilha de Tranferencia: " + TRANSFORM(par_nTipo), ;
                gc_4c_UsuarioLogado)

            =SqlCalcP2(.T., gnConnHandle)
            =fRecalculaC(.T., .F., .F., gnConnHandle)

            IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION", "") < 1
                MsgErro("Falha na Grava" + CHR(231) + CHR(227) + "o dos Dados.", "Erro")
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "")
                loc_lResultado = .F.
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPedidoAcessorio - Importa pedidos de acessorio (pedacesso)
    * Logica identica ao PedidoTerceiro usando this_cDopAcePed
    *--------------------------------------------------------------------------
    FUNCTION ProcessarPedidoAcessorio(par_nTipo, par_nPreco)
        LOCAL loc_lResultado, loc_oErro, loc_cDopOrig
        loc_lResultado = .F.
        TRY
            loc_cDopOrig = THIS.this_cDopTrfPed
            THIS.this_cDopTrfPed = THIS.this_cDopAcePed
            loc_lResultado = THIS.ProcessarPedidoTerceiro(par_nTipo, par_nPreco)
            THIS.this_cDopTrfPed = loc_cDopOrig
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimiteCreditoMatriz - Verifica limite de credito pela matriz contabil
    *--------------------------------------------------------------------------
    FUNCTION LimiteCreditoMatriz(par_cGrupo, par_cConta, par_cGrupoEm, par_cContaEm, par_cTipo, ;
            par_dData, par_nValor, par_cDopes, par_cEmps, par_nNumes)
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_nLimite, loc_nCotLim, loc_nSaldo, loc_nCotSal, loc_nCotPar, loc_nFatConv
        LOCAL loc_nValorAnt, loc_nValorMov, loc_cCampo, loc_cCmpUp
        LOCAL loc_pAno, loc_pMes, loc_cMtxGrupo, loc_cQuery, loc_cSQL
        LOCAL loc_lValidaLim, loc_cLcTitulo, loc_cMoeLim, loc_nCotMov
        LOCAL loc_nSaldoMov, loc_nSaldoAc, loc_cMoedaMov, loc_cMoeOrc
        LOCAL loc_cMatriz, loc_cContaEmpAtual, loc_llOk, loc_cRetorno
        loc_lResultado = .T.
        TRY
            SQLEXEC(gnConnHandle, "SELECT * FROM SigCdGcr", "crSigCdGcr2")
            SELECT crSigCdGcr2
            LOCATE FOR ALLTRIM(Codigos) = ALLTRIM(par_cGrupo)
            IF FOUND() AND !EMPTY(crSigCdGcr2.GrupoLms)
                loc_cMtxGrupo = ALLTRIM(crSigCdGcr2.GrupoLms)
            ELSE
                loc_cMtxGrupo = ALLTRIM(par_cGrupo)
            ENDIF

            loc_pAno = STR(YEAR(par_dData), 4)
            loc_pMes = PADL(MONTH(par_dData), 2, "0")
            loc_nValorMov = par_nValor

            loc_cCampo = ""
            loc_cCmpUp = ""
            DO CASE
                CASE loc_pMes = "01"
                    loc_cCampo = ",a.Val_Jan AS LimCres, a.Acm_Jan AS Saldos "
                    loc_cCmpUp = "Acm_Jan"
                CASE loc_pMes = "02"
                    loc_cCampo = ",a.Val_Fev AS LimCres, a.Acm_Fev AS Saldos "
                    loc_cCmpUp = "Acm_Fev"
                CASE loc_pMes = "03"
                    loc_cCampo = ",a.Val_Mar AS LimCres, a.Acm_Mar AS Saldos "
                    loc_cCmpUp = "Acm_Mar"
                CASE loc_pMes = "04"
                    loc_cCampo = ",a.Val_Abr AS LimCres, a.Acm_Abr AS Saldos "
                    loc_cCmpUp = "Acm_Abr"
                CASE loc_pMes = "05"
                    loc_cCampo = ",a.Val_Mai AS LimCres, a.Acm_Mai AS Saldos "
                    loc_cCmpUp = "Acm_Mai"
                CASE loc_pMes = "06"
                    loc_cCampo = ",a.Val_Jun AS LimCres, a.Acm_Jun AS Saldos "
                    loc_cCmpUp = "Acm_Jun"
                CASE loc_pMes = "07"
                    loc_cCampo = ",a.Val_Jul AS LimCres, a.Acm_Jul AS Saldos "
                    loc_cCmpUp = "Acm_Jul"
                CASE loc_pMes = "08"
                    loc_cCampo = ",a.Val_Ago AS LimCres, a.Acm_Ago AS Saldos "
                    loc_cCmpUp = "Acm_Ago"
                CASE loc_pMes = "09"
                    loc_cCampo = ",a.Val_Set AS LimCres, a.Acm_Set AS Saldos "
                    loc_cCmpUp = "Acm_Set"
                CASE loc_pMes = "10"
                    loc_cCampo = ",a.Val_Out AS LimCres, a.Acm_Out AS Saldos "
                    loc_cCmpUp = "Acm_Out"
                CASE loc_pMes = "11"
                    loc_cCampo = ",a.Val_Nov AS LimCres, a.Acm_Nov AS Saldos "
                    loc_cCmpUp = "Acm_Nov"
                CASE loc_pMes = "12"
                    loc_cCampo = ",a.Val_Dez AS LimCres, a.Acm_Dez AS Saldos "
                    loc_cCmpUp = "Acm_Dez"
            ENDCASE

            loc_cQuery = "SELECT a.cidchaves, a.codigo, a.grupos, a.contas, a.chkvalida, b.sgrupos, b.scontas, b.Ano, b.moeda " + ;
                loc_cCampo + ;
                "FROM SigCdMtI a JOIN SigCdMtz b ON a.codigo = b.codigo " + ;
                "WHERE b.Inativas = 0 AND b.ano = " + EscaparSQL(loc_pAno) + ;
                " AND b.sgrupos = " + EscaparSQL(loc_cMtxGrupo) + ;
                " AND b.scontas = " + EscaparSQL(par_cConta) + ;
                " AND Grupos = " + EscaparSQL(par_cGrupoEm) + ;
                " AND Contas = " + EscaparSQL(par_cContaEm)
            IF SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdMtI") < 1
                MsgErro("Falha na Conex" + CHR(227) + "o (crSigCdMtI)", "Erro")
                loc_lResultado = .F.
            ENDIF

            loc_cMoeOrc = ALLTRIM(NVL(crSigCdMtI.Moeda, ""))
            IF EMPTY(loc_cMoeOrc)
                SQLEXEC(gnConnHandle, "SELECT MoedaPs FROM SigCdPam", "crPamMoe")
                IF !EOF("crPamMoe")
                    loc_cMoeOrc = ALLTRIM(NVL(crPamMoe.MoedaPs, ""))
                ENDIF
            ENDIF

            loc_cQuery = "SELECT Ano, " + ;
                "REPLICATE('0',2-LEN(LTRIM(RTRIM(CAST(Mes AS VARCHAR))))) + LTRIM(RTRIM(CAST(Mes AS VARCHAR))) AS Mes, " + ;
                "GruposEmt, ContasEmt, GruposCC, ContasCC, SUM(valos) AS Valos, a.cmoes " + ;
                "FROM (" + ;
                "SELECT a.limcres, a.dopes, " + ;
                "CASE WHEN b.GruposEmt = SPACE(10) THEN c.grupods ELSE b.GruposEmt END AS GruposEmt, " + ;
                "CASE WHEN b.ContasEmt = SPACE(10) THEN c.Contads ELSE b.ContasEmt END AS ContasEmt, " + ;
                "MONTH(datas) AS mes, YEAR(datas) AS ano, " + ;
                "CASE WHEN c.grupoccs = SPACE(10) THEN b.GruposCC ELSE c.grupoccs END AS GruposCC, " + ;
                "CASE WHEN c.contaccs = SPACE(10) THEN b.ContasCC ELSE c.contaccs END AS ContasCC, " + ;
                "c.datas, CASE WHEN a.cmoes = SPACE(3) THEN (SELECT moedaps FROM sigcdpam) ELSE a.cmoes END AS cmoes, " + ;
                "CASE WHEN a.limcres = 8 THEN c.valos*-1 ELSE c.valos*1 END AS valos " + ;
                "FROM sigcdope a JOIN sigopcdd b ON a.dopes = b.dopes " + ;
                "JOIN sigmvcab c ON a.dopes = c.dopes " + ;
                "WHERE a.limcres IN(7,8) AND c.valos <> 0) a " + ;
                "WHERE 0=0 AND Ano = " + EscaparSQL(loc_pAno) + ;
                " AND Mes = " + EscaparSQL(loc_pMes) + ;
                " AND GruposCC = " + EscaparSQL(loc_cMtxGrupo) + ;
                " AND ContasCC = " + EscaparSQL(par_cConta) + ;
                " AND GruposEmt = " + EscaparSQL(par_cGrupoEm) + ;
                " AND ContasEmt = " + EscaparSQL(par_cContaEm) + ;
                " GROUP BY GruposEmt, ContasEmt, mes, ano, GruposCC, ContasCC, Cmoes"

            IF SQLEXEC(gnConnHandle, loc_cQuery, "crSldMov") < 1
                MsgErro("Falha na Conex" + CHR(227) + "o (crSldMov)", "Erro")
                loc_lResultado = .F.
            ENDIF

            loc_nSaldoMov = 0
            loc_nSaldoAc  = 0
            loc_cMoedaMov = ""
            loc_nCotLim   = THIS.ObterCotacao(loc_cMoeOrc, par_dData)

            SELECT crSldMov
            GO TOP
            SCAN
                loc_nSaldoAc  = crSldMov.Valos
                loc_cMoedaMov = ALLTRIM(NVL(crSldMov.CMoes, ""))
                IF loc_cMoedaMov <> loc_cMoeOrc
                    loc_nSaldoMov = loc_nSaldoMov + ROUND(loc_nSaldoAc * THIS.ObterCotacao(loc_cMoedaMov, par_dData) / loc_nCotLim, 2)
                ELSE
                    loc_nSaldoMov = loc_nSaldoMov + loc_nSaldoAc
                ENDIF
                SELECT crSldMov
            ENDSCAN

            loc_nSaldoMov = loc_nSaldoMov + THIS.this_nValorAcumulado

            IF EMPTY(loc_nSaldoMov)
                loc_nSaldoMov = NVL(crSigCdMtI.Saldos, 0)
            ENDIF

            SQLEXEC(gnConnHandle, "SELECT ContaMats FROM SigCdCli WHERE IClis = " + EscaparSQL(par_cConta), "crLocalMtz")
            GO TOP IN crLocalMtz
            IF !EOF("crLocalMtz") AND !EMPTY(crLocalMtz.ContaMats)
                loc_cMatriz = ALLTRIM(crLocalMtz.ContaMats)
                loc_cQuery = "SELECT a.cidchaves, a.codigo, a.grupos, a.contas, a.chkvalida, b.sgrupos, b.scontas, b.Ano, b.moeda " + ;
                    loc_cCampo + ;
                    "FROM SigCdMtI a JOIN SigCdMtz b ON a.codigo = b.codigo " + ;
                    "WHERE b.ano = " + EscaparSQL(loc_pAno) + ;
                    " AND b.sgrupos = " + EscaparSQL(loc_cMtxGrupo) + ;
                    " AND b.scontas = " + EscaparSQL(loc_cMatriz) + ;
                    " AND Grupos = " + EscaparSQL(par_cGrupoEm) + ;
                    " AND Contas = " + EscaparSQL(par_cContaEm)
                SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdMtI")
            ENDIF

            IF VARTYPE(crSigCdMtI.chkvalida) = "L"
                loc_lValidaLim = crSigCdMtI.chkvalida
            ELSE
                IF VARTYPE(crSigCdMtI.chkvalida) = "L"
                    loc_lValidaLim = crSigCdMtI.chkvalida
                ELSE
                    IF VARTYPE(crSigCdMtI.chkvalida) = "L"
                        loc_lValidaLim = crSigCdMtI.chkvalida
                    ELSE
                        IF VARTYPE(crSigCdMtI.chkvalida) = "L"
                            loc_lValidaLim = crSigCdMtI.chkvalida
                        ELSE
                            IF VARTYPE(crSigCdMtI.chkvalida) = "L"
                                loc_lValidaLim = crSigCdMtI.chkvalida
                            ELSE
                                IF VARTYPE(crSigCdMtI.chkvalida) = "L"
                                    loc_lValidaLim = crSigCdMtI.chkvalida
                                ELSE
                                    IF VARTYPE(crSigCdMtI.chkvalida) = "L"
                                        loc_lValidaLim = crSigCdMtI.chkvalida
                                    ELSE
                                        IF VARTYPE(crSigCdMtI.chkvalida) = "L"
                                            loc_lValidaLim = crSigCdMtI.chkvalida
                                        ELSE
                                            loc_lValidaLim = (NVL(crSigCdMtI.chkvalida, 0) = 1)
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF NVL(crSigCdGcr2.LimCres, 0) = 1
                loc_cLcTitulo = "Cr" + CHR(233) + "dito"
                loc_nSaldo    = 0
                SELECT crSigCdMtI
                GO TOP
                loc_nLimite  = NVL(LimCres, 0)
                loc_cMoeLim  = ALLTRIM(NVL(Moeda, ""))
                loc_nCotLim  = fCarregarCambio(loc_cMoeLim, par_dData)
                IF EMPTY(loc_nLimite)
                    loc_nLimite = 0.01
                ENDIF

                loc_nCotSal = THIS.ObterCotacao(loc_cMoedaMov, par_dData)
                IF loc_cMoedaMov <> loc_cMoeLim
                    loc_nSaldo = loc_nSaldo + ROUND(loc_nSaldoMov * loc_nCotSal / loc_nCotLim, 2)
                ELSE
                    loc_nSaldo = loc_nSaldo + loc_nSaldoMov
                ENDIF

                loc_nCotMov = THIS.ObterCotacao(loc_cMoedaMov, par_dData)
                IF loc_cMoedaMov <> loc_cMoeLim
                    loc_nValorMov = ROUND(par_nValor * loc_nCotMov / loc_nCotLim, 2)
                ENDIF

                IF loc_nSaldo > loc_nLimite AND loc_lValidaLim
                    MsgAviso("O Limite de " + loc_cLcTitulo + " da conta de " + ALLTRIM(par_cTipo) + ;
                        " " + CHR(233) + " de : " + TRANSFORM(loc_nLimite, "999,999,999.99") + ;
                        " " + ALLTRIM(loc_cMoeLim) + ". " + CHR(13) + ;
                        "O saldo desta conta somado ao valor " + CHR(13) + ;
                        "da movimenta" + CHR(231) + CHR(227) + "o excedeu o limite de " + ;
                        loc_cLcTitulo + " : " + TRANSFORM(loc_nSaldo, "999,999,999.99") + ;
                        " " + ALLTRIM(loc_cMoeLim) + ". " + CHR(13), ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .F.
                    loc_lResultado = .F.
                ENDIF

                THIS.this_nValorAcumulado = THIS.this_nValorAcumulado + par_nValor

                IF !EMPTY(loc_cCmpUp) AND !EMPTY(crSigCdMtI.cIdChaves)
                    loc_cSQL = "UPDATE SigCdMti SET " + loc_cCmpUp + " = " + ;
                        FormatarNumeroSQL(par_nValor + loc_nSaldoMov, 2) + ;
                        " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(crSigCdMtI.cIdChaves))
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                        MsgErro("Falha na Conex" + CHR(227) + "o (UPDATE SigCdMti)", "Erro")
                        loc_lResultado = .F.
                    ENDIF
                ENDIF
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterCotacao - Busca cotacao de moeda (com cache em TmpCot)
    *--------------------------------------------------------------------------
    FUNCTION ObterCotacao(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_oErro, loc_cAliasAnt
        loc_nCotacao = 1
        TRY
            loc_cAliasAnt = ALIAS()

            IF !USED("TmpCot")
                CREATE CURSOR TmpCot (Cmoes C(3), Valos N(14, 5))
                INDEX ON Cmoes TAG Cmoes
            ENDIF
            IF !USED("TmpTotal")
                CREATE CURSOR TmpTotal (Moeds C(3), MoeVals N(14, 5))
                INDEX ON Moeds TAG Moeds
            ENDIF

            IF !EMPTY(par_cMoeda)
                LOCAL loc_cQuery
                loc_cQuery = "SELECT Cotas FROM SigCdMoe WHERE Cmoes = " + EscaparSQL(par_cMoeda)
                IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalMoe") < 1
                    MsgErro("Favor reiniciar o Processo. Falha de conex" + CHR(227) + "o (LocalMoe)", "Erro")
                    loc_lResultado = 1
                ENDIF

                IF NVL(LocalMoe.Cotas, 0)
                    SELECT TmpCot
                    SET ORDER TO TAG Cmoes
                    IF !SEEK(par_cMoeda)
                        loc_nCotacao = fBuscarCotacao(par_cMoeda, par_dData, gnConnHandle)
                        INSERT INTO TmpCot (Cmoes, Valos) VALUES (par_cMoeda, loc_nCotacao)
                    ELSE
                        IF NVL(TmpCot.Valos, 0) = 0
                            loc_nCotacao = fBuscarCotacao(par_cMoeda, par_dData, gnConnHandle)
                            REPLACE Valos WITH loc_nCotacao IN TmpCot
                        ENDIF
                        loc_nCotacao = TmpCot.Valos
                    ENDIF

                    SELECT TmpTotal
                    SET ORDER TO TAG Moeds
                    IF !SEEK(par_cMoeda)
                        INSERT INTO TmpTotal (Moeds) VALUES (par_cMoeda)
                    ENDIF
                    REPLACE MoeVals WITH loc_nCotacao IN TmpTotal
                ELSE
                    loc_nCotacao = 1
                ENDIF
            ENDIF

            IF !EMPTY(loc_cAliasAnt)
                SELECT (loc_cAliasAnt)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_nCotacao = 1
        ENDTRY
        RETURN loc_nCotacao
    ENDFUNC

ENDDEFINE
