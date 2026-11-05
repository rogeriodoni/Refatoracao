*==============================================================================
* sigopgarBO.prg
*
* Business Object para sigopgar (Gera Arquivo)
* Dialogo filho MODAL ("Gera Arquivo"), aberto por um formulario de consulta/
* selecao de produtos para exportar os produtos SELECIONADOS para um arquivo
* em disco, em um de dois formatos escolhidos pelo usuario (chkXml):
*
*   - chkXml.Value = 1 (XML): gera um XML via XMLAdapter com os produtos do
*     cursor de origem (Produto/Descricao/Grupo/Unidade/Modelo/Foto/DataAlt),
*     salvando no arquivo/diretorio escolhido em CntXml.getDirs.
*   - chkXml.Value = 0 (TXT, default): gera um arquivo TXT de largura fixa
*     (protocolo proprio "td01"/"td03") com um registro por Grupo distinto e
*     um registro por Produto, mais a exportacao de cada foto (FigJpgs) como
*     .jpg separado na mesma pasta do TXT (ProcessaTxt/ExportaProduto no
*     legado), usando o arquivo escolhido em CntTXT.getArqTXT.
*
* Nao possui tabela principal propria: a origem dos produtos e o cursor
* global CrImagens, populado pelo formulario pai ANTES de abrir este dialogo
* (equivalente ao parametro oObjForm do Init legado - aqui this_cCursorOrigem
* documenta o nome do cursor recebido). A gravacao real deste BO e em ARQUIVO
* (StrToFile), nao em tabela do SQL Server - os unicos SQLEXEC existentes sao
* leituras auxiliares (SigCdGrp/SigCdPro/SigPrCar+SigCrRap) para montar o
* conteudo exportado.
*
* Criado na Fase 1 (propriedades e Init). Completo a partir da Fase 2 com
* os metodos que GERAM O ARQUIVO (GerarArquivo/GerarArquivoXml/
* GerarArquivoTxt/ExportarXml) - os "metodos CRUD" deste BO, ja que nao
* ha Inserir()/Atualizar() de tabela neste dialogo (ver acima).
*==============================================================================

DEFINE CLASS sigopgarBO AS BusinessBase

    *-- Cursor de origem dos produtos selecionados (equivalente a CrImagens
    *-- no legado), recebido do formulario pai antes de abrir este dialogo
    this_cCursorOrigem      = ""    && char - nome do cursor com os produtos selecionados (colunas Cpros/Cgrus/Cunis/FigJpgs)

    *-- Modo de geracao escolhido pelo usuario (chkXml.Valid no legado)
    this_lGeraXml           = .F.   && logical - .T. = gera arquivo XML (CntXml visivel) / .F. = gera arquivo TXT (CntTXT visivel), default .F.

    *-- Painel XML (CntXml) - visivel quando this_lGeraXml = .T.
    this_cCodArquivo        = ""    && char(20) - CntXml.Get_arquivo.Value ("Arquivo :") - codigo informativo do arquivo XML (Format "K!" no legado)
    this_cArquivoXml        = ""    && char - CntXml.getDirs.Value - caminho completo do arquivo XML de destino (extensao .xml obrigatoria)

    *-- Painel TXT (CntTXT) - visivel quando this_lGeraXml = .F. (default)
    this_cArquivoTxt        = ""    && char - CntTXT.getArqTXT.Value - caminho completo do arquivo TXT de destino
    this_lExportarImagens   = .T.   && logical - CntTXT.chkImagens.Value - exporta as fotos (FigJpgs) dos produtos como .jpg junto ao TXT, default .T. (Value=1 no SCX)

    *-- Progresso exibido durante a geracao do TXT (CntTXT.lblResults.Caption
    *-- no legado - atualizado a cada grupo/produto processado)
    this_cMensagemProgresso = ""    && char/memo - texto de progresso ("Processando N Grupo(s) / Produtos Gerados : M")
    this_nQtdGrupos         = 0     && numeric - total de grupos distintos no cursor de origem (lnQtd no legado)
    this_nQtdProdutos       = 0     && numeric - total de produtos efetivamente gravados no TXT (lnCnt no legado)

    *-- Referencia opcional ao form para repintar o progresso durante
    *-- GerarArquivoTxt (equivalente ao "ThisForm.cntTxt.lblResults.Caption
    *-- = ..." repetido dentro do Scan de ProcessaTxt no legado). Fica
    *-- .NULL. quando o BO eh usado sem interface (ex.: teste automatizado).
    this_oFormUI            = .NULL.

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object. Sem tabela principal propria (a
    * gravacao efetiva eh em arquivo, nao em tabela do SQL Server - ver
    * cabecalho da classe).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        *-- Cursor global montado pelo formulario pai antes de abrir este
        *-- dialogo (equivalente a CrImagens, citado direto por nome no
        *-- Init/Processamento/ProcessaTxt do legado - nao e parametro do
        *-- Init legado). Mantido como property (em vez de literal fixo)
        *-- para permitir que o Form troque o nome, se precisar.
        THIS.this_cCursorOrigem = "crImagens"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel. Este dialogo nao tem tabela/cursor
    * de registro unico: a origem dos dados eh this_cCursorOrigem (cursor
    * externo populado pelo formulario pai), percorrido inteiro pelo metodo
    * de geracao do arquivo, nao carregado campo a campo numa property.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel. A persistencia deste dialogo eh em ARQUIVO
    * (StrToFile do XML/TXT gerado), nao em INSERT no SQL Server.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel, pelo mesmo motivo de Inserir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel: sem tabela nem chave primaria
    * propria neste dialogo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Nao aplicavel: sem gravacao em tabela do SQL
    * Server neste dialogo, nao ha operacao para auditar aqui.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN
    ENDPROC

    *==========================================================================
    * METODOS DE PROCESSAMENTO (equivalentes as operacoes de gravacao deste
    * dialogo - ver cabecalho da classe: a persistencia real e em ARQUIVO,
    * nunca em INSERT/UPDATE de tabela, entao os "metodos CRUD" deste BO sao
    * os que GERAM O ARQUIVO, nao Inserir()/Atualizar() de BusinessBase
    * (mesmo padrao adotado em sigopecmBO.prg para forms operacionais sem
    * tabela propria).
    *==========================================================================

    *--------------------------------------------------------------------------
    * AtualizarProgresso - Repinta o andamento do processamento (equivalente
    * ao "ThisForm.cntTxt.lblResults.Caption = ..." repetido dentro do Scan
    * de ProcessaTxt no legado). Delega para um metodo PUBLIC do form
    * (THIS.this_oFormUI.AtualizarProgresso(cTexto)), que o Form (Fase 3)
    * implementa para repintar o label dele e fazer Refresh(). Nao faz nada
    * quando this_oFormUI esta .NULL. (BO usado sem interface).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarProgresso(par_nQtdGrupos, par_nQtdProdutos)
        LOCAL loc_cTexto

        loc_cTexto = "Processando " + ALLTRIM(STR(par_nQtdGrupos, 10)) + " Grupo" + ;
            IIF(par_nQtdGrupos = 1, "", "s") + " / " + ;
            "Produtos Gerados : " + ALLTRIM(STR(par_nQtdProdutos, 10))

        THIS.this_cMensagemProgresso = loc_cTexto

        IF VARTYPE(THIS.this_oFormUI) = "O" AND PEMSTATUS(THIS.this_oFormUI, "AtualizarProgresso", 5)
            THIS.this_oFormUI.AtualizarProgresso(loc_cTexto)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivo - Ponto de entrada do processamento (equivalente a
    * SIGOPGAR.Processamento no legado). Fecha o cursor auxiliar de XML
    * (equivalente ao "If Used([csArqXMl]) / Use In csArqXMl" do topo do
    * legado) e despacha para GerarArquivoXml() ou GerarArquivoTxt()
    * conforme this_lGeraXml (chkXml.Value).
    *--------------------------------------------------------------------------
    PROCEDURE GerarArquivo()
        IF USED("cursor_4c_ArqXml")
            USE IN cursor_4c_ArqXml
        ENDIF

        IF THIS.this_lGeraXml
            RETURN THIS.GerarArquivoXml()
        ELSE
            RETURN THIS.GerarArquivoTxt()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivoXml - Gera o arquivo XML com os produtos do cursor de
    * origem (equivalente ao ramo "Else" de Processamento + ExportaProduto
    * no legado - chkXml.Value = 1).
    *
    * Pre-requisitos (setados pelo Form antes de chamar):
    *   THIS.this_cArquivoXml   - caminho completo do .xml de destino
    *   THIS.this_cCursorOrigem - nome do cursor com os produtos
    *                             selecionados (default "crImagens", ver Init)
    *
    * Contrato de erro: falha de validacao (arquivo vazio/extensao errada/
    * sem produtos selecionados) preenche this_cMensagemErro e retorna .F.
    * SEM exibir MsgErro - quem exibe eh o Form (BtnProcessarClickExec,
    * com MsgAviso), igual ao legado, que devolve .F. e deixa a
    * MessageBox para o chamador. O SetFocus que o legado faz nesses
    * ramos (btnDirs no XML, btnGetArqO no TXT, Cancela no fim de
    * ProcessaTxt) NAO foi reproduzido de proposito: Processa.Click
    * executa "Thisform.Processamento() / Thisform.Release" SEM
    * condicionar ao retorno, entao o dialogo fecha logo depois e o
    * foco recem-posto nunca chega a ser visto. Reproduzi-lo seria
    * acrescentar linha inobservavel; o que importa para o PILAR 1 -
    * mensagem identica e dialogo fechando - esta reproduzido.
    * Falha de SQL exibe o proprio MsgErro aqui, igual ao resto da classe.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarArquivoXml()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cArquivo, loc_cCursorOrigem, loc_cProduto, loc_cSQL, loc_nResultado

        loc_lResultado          = .F.
        THIS.this_cMensagemErro = ""
        loc_cArquivo            = ALLTRIM(NVL(THIS.this_cArquivoXml, ""))
        loc_cCursorOrigem       = ALLTRIM(NVL(THIS.this_cCursorOrigem, ""))

        TRY
            IF EMPTY(loc_cArquivo)
                THIS.this_cMensagemErro = "Arquivo n" + CHR(227) + "o informado!!!"
            ELSE
                IF UPPER(JUSTEXT(loc_cArquivo)) != "XML"
                    THIS.this_cMensagemErro = "Arquivo com Extens" + CHR(227) + "o inv" + CHR(225) + "lida!!!"
                ELSE
                    IF EMPTY(loc_cCursorOrigem) OR !USED(loc_cCursorOrigem)
                        THIS.this_cMensagemErro = "Nenhum produto selecionado para exportar."
                    ELSE
                        IF USED("cursor_4c_ArqXml")
                            USE IN cursor_4c_ArqXml
                        ENDIF
                        SET NULL ON
                        CREATE CURSOR cursor_4c_ArqXml (Produto C(14), Descricao C(254), Grupo C(3), Unidade C(3), Modelo C(3), Foto W, DataAlt T)
                        SET NULL OFF
                        INDEX ON Produto TAG Produto

                        loc_lResultado = .T.

                        SELECT (loc_cCursorOrigem)
                        GO TOP
                        SCAN
                            IF !loc_lResultado
                                EXIT
                            ENDIF

                            loc_cProduto = EVALUATE(loc_cCursorOrigem + ".Cpros")

                            loc_cSQL = "SELECT a.DPro3s, a.CodFinP, b.DataAlts" + ;
                                " FROM SigCdPro a JOIN SigCdPrc b ON a.cpros = b.cpros" + ;
                                " WHERE a.cpros = " + EscaparSQL(loc_cProduto)

                            IF USED("cursor_4c_ArqXmlProd")
                                USE IN cursor_4c_ArqXmlProd
                            ENDIF
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ArqXmlProd")

                            IF loc_nResultado < 0
                                MsgErro("Falha na Gera" + CHR(231) + CHR(227) + "o do Arquivo. Reinicie o Processo...", "Select (crTProd)")
                                loc_lResultado = .F.
                                EXIT
                            ENDIF

                            INSERT INTO cursor_4c_ArqXml (Produto, Descricao, Grupo, Unidade, Modelo, Foto, DataAlt) VALUES ( ;
                                PADR(loc_cProduto, 14), ;
                                "", ;
                                EVALUATE(loc_cCursorOrigem + ".Cgrus"), ;
                                EVALUATE(loc_cCursorOrigem + ".Cunis"), ;
                                "", ;
                                NVL(EVALUATE(loc_cCursorOrigem + ".FigJpgs"), ""), ;
                                CTOD(""))

                            IF USED("cursor_4c_ArqXmlProd") AND RECCOUNT("cursor_4c_ArqXmlProd") > 0
                                SELECT cursor_4c_ArqXml
                                REPLACE Descricao WITH ALLTRIM(LEFT(TratarNulo(cursor_4c_ArqXmlProd.DPro3s, ""), 254)), ;
                                        Modelo    WITH TratarNulo(cursor_4c_ArqXmlProd.CodFinP, ""), ;
                                        DataAlt   WITH cursor_4c_ArqXmlProd.DataAlts
                            ENDIF

                            IF USED("cursor_4c_ArqXmlProd")
                                USE IN cursor_4c_ArqXmlProd
                            ENDIF

                            SELECT (loc_cCursorOrigem)
                        ENDSCAN

                        IF loc_lResultado
                            SELECT cursor_4c_ArqXml
                            GO TOP

                            THIS.ExportarXml(loc_cArquivo)

                            IF FILE(loc_cArquivo)
                                MsgInfo("Arquivo Gerado com Sucesso", "Gera" + CHR(231) + CHR(227) + "o de Arquivo")
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gerar arquivo XML: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo)
            loc_lResultado = .F.
        FINALLY
            IF USED("cursor_4c_ArqXmlProd")
                USE IN cursor_4c_ArqXmlProd
            ENDIF
            IF USED("cursor_4c_ArqXml")
                USE IN cursor_4c_ArqXml
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarXml - Grava em disco o arquivo XML com o conteudo do cursor
    * cursor_4c_ArqXml (equivalente a ExportaProduto() no legado - usa
    * XMLAdapter para serializar o cursor e grava a string resultante com
    * StrToFile).
    *
    * NOTA: XMLAdapter.ToXML() recebe o NOME da variavel de saida (como
    * string) e preenche essa variavel por substituicao - igual ao legado
    * (.ToXML([lcStr]) seguido de StrToFile(lcStr, ...)). Passar o VALOR de
    * loc_cStr no lugar do nome "loc_cStr" produziria XML vazio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExportarXml(par_cArquivo)
        LOCAL loc_oXml, loc_cStr
        loc_cStr = ""

        loc_oXml = CREATEOBJECT("XMLAdapter")

        WITH loc_oXml
            .RespectCursorCP = .T.
            .RespectNesting  = .T.
            .UTF8Encoded     = .T.
            .FormattedOutput = .T.
            .XMLName         = STRCONV("cpros", 12)

            .AddTableSchema("cursor_4c_ArqXml")
            .ToXML("loc_cStr")
        ENDWITH

        STRTOFILE(loc_cStr, par_cArquivo, 0)

        loc_oXml = .NULL.
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivoTxt - Gera o arquivo TXT de largura fixa (protocolo
    * "td01"/"td03") com um registro por Grupo distinto e um registro por
    * Produto do cursor de origem, mais a exportacao de cada foto (FigJpgs)
    * como .jpg separado na mesma pasta do TXT (equivalente a ProcessaTxt
    * no legado - chkXml.Value <> 1).
    *
    * Pre-requisitos (setados pelo Form antes de chamar):
    *   THIS.this_cArquivoTxt   - caminho completo do .txt a ser gerado
    *   THIS.this_cCursorOrigem - nome do cursor com os produtos
    *                             selecionados (default "crImagens", ver Init)
    *   THIS.this_oFormUI       - opcional, para repintar o progresso
    *
    * this_lExportarImagens NAO entra aqui: este metodo nao a le, porque o
    * legado tambem nao - CntTXT.chkImagens aparece so na arvore de objetos
    * e nas propriedades do SCX, nunca referenciado dentro de ProcessaTxt.
    * Acrescentar essa checagem seria inventar restricao que o legado nao
    * tem (PILAR 1 / CLAUDE.md regra #49) - a imagem e exportada sempre que
    * SigCdPro.FigJpgs estiver preenchido, independente da caixa marcada.
    *
    * Contrato de erro: igual a GerarArquivoXml() - falha de validacao
    * preenche this_cMensagemErro e retorna .F. sem MsgErro; falha de SQL
    * exibe o proprio MsgErro aqui.
    *
    * Retorno: .T. se o processamento rodou do inicio ao fim (mesmo que
    * nenhum produto tenha sido gerado - igual ao legado, que so muda a
    * mensagem final, nunca o retorno); .F. em falha de validacao ou de SQL.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarArquivoTxt()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cArquivo, loc_cCursorOrigem, loc_cChr, loc_cSQL, loc_nResultado
        LOCAL loc_nQtdGrupos, loc_nQtdProdutos
        LOCAL loc_cGru, loc_cDes, loc_cUni, loc_cStr
        LOCAL loc_cRef, loc_cDat, loc_cSit, loc_cPes, loc_cIpi, loc_cIcm, loc_cClf, loc_cTri, loc_cVal, loc_cPre
        LOCAL loc_cGvd, loc_cGr1, loc_cDe1, loc_cUn1
        LOCAL loc_cImg, loc_cFoto

        loc_lResultado = .F.
        THIS.this_cMensagemErro      = ""
        THIS.this_nQtdGrupos         = 0
        THIS.this_nQtdProdutos       = 0
        THIS.this_cMensagemProgresso = ""

        loc_cArquivo      = ALLTRIM(NVL(THIS.this_cArquivoTxt, ""))
        loc_cCursorOrigem = ALLTRIM(NVL(THIS.this_cCursorOrigem, ""))

        TRY
            IF EMPTY(loc_cArquivo)
                THIS.this_cMensagemErro = "O Arquivo a Ser Gerado N" + CHR(227) + "o Foi Informado!!!"
            ELSE
                *-- Testa se o arquivo pode ser criado (igual ao legado)
                STRTOFILE("", loc_cArquivo, 0)

                IF !FILE(loc_cArquivo)
                    THIS.this_cMensagemErro = "O Arquivo N" + CHR(227) + "o Pode Ser Criado!!!"
                ELSE
                    IF EMPTY(loc_cCursorOrigem) OR !USED(loc_cCursorOrigem)
                        THIS.this_cMensagemErro = "Nenhum produto selecionado para exportar."
                    ELSE
                        loc_cChr = CHR(13) + CHR(10)

                        IF USED("cursor_4c_GruposSelec")
                            USE IN cursor_4c_GruposSelec
                        ENDIF
                        SELECT DISTINCT Cgrus FROM (loc_cCursorOrigem) ;
                            INTO CURSOR cursor_4c_GruposSelec ;
                            ORDER BY Cgrus

                        IF USED("cursor_4c_ControleGrupos")
                            USE IN cursor_4c_ControleGrupos
                        ENDIF
                        SET NULL ON
                        CREATE CURSOR cursor_4c_ControleGrupos (Grupo N(8))
                        SET NULL OFF
                        INDEX ON Grupo TAG Grupo

                        loc_nQtdGrupos   = RECCOUNT("cursor_4c_GruposSelec")
                        loc_nQtdProdutos = 0

                        THIS.AtualizarProgresso(loc_nQtdGrupos, loc_nQtdProdutos)

                        loc_lResultado = .T.

                        SELECT cursor_4c_GruposSelec
                        SCAN
                            IF !loc_lResultado
                                EXIT
                            ENDIF

                            loc_cSQL = "SELECT Cgrus, Dgrus, Ids" + ;
                                " FROM SigCdGrp" + ;
                                " WHERE Cgrus = " + EscaparSQL(cursor_4c_GruposSelec.Cgrus) + ;
                                "   AND Ids > 0"

                            IF USED("cursor_4c_DadosGrupo")
                                USE IN cursor_4c_DadosGrupo
                            ENDIF
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosGrupo")

                            IF loc_nResultado < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalGrupo)")
                                loc_lResultado = .F.
                                EXIT
                            ENDIF

                            SELECT cursor_4c_DadosGrupo
                            GO TOP

                            IF !EOF("cursor_4c_DadosGrupo")
                                loc_cGru = PADL(cursor_4c_DadosGrupo.Ids, 8, "0")
                                loc_cDes = PADR(ALLTRIM(cursor_4c_DadosGrupo.Dgrus), 40)
                                loc_cUni = PADR("", 4)

                                *-- td01 - Tabela de Grupos
                                loc_cStr = "td01" + ;           && Tipo - "td01" - Constante - Caracter(4)
                                    loc_cGru + ;                && ID - Numerico(8)
                                    loc_cDes + ;                && Descricao - Caracter(40)
                                    loc_cUni + loc_cChr         && Unidade - Caracter(4)

                                STRTOFILE(loc_cStr, loc_cArquivo, .T.)

                                IF !SEEK(cursor_4c_DadosGrupo.Ids, "cursor_4c_ControleGrupos", "Grupo")
                                    INSERT INTO cursor_4c_ControleGrupos (Grupo) VALUES (cursor_4c_DadosGrupo.Ids)
                                ENDIF

                                *-- Produtos distintos do grupo (crPros do legado)
                                IF USED("cursor_4c_ProdutosGrupo")
                                    USE IN cursor_4c_ProdutosGrupo
                                ENDIF
                                SELECT DISTINCT Cpros FROM (loc_cCursorOrigem) ;
                                    WHERE Cgrus = cursor_4c_GruposSelec.Cgrus ;
                                    INTO CURSOR cursor_4c_ProdutosGrupo ;
                                    ORDER BY Cpros

                                SELECT cursor_4c_ProdutosGrupo
                                SCAN
                                    loc_cSQL = "SELECT Cpros, Dpros, Cunis, DtIncs, Situas, PesoMs, Icms," + ;
                                        " AliqIpis, ClFiscals, SitTrIcms, Pvens, FigJpgs" + ;
                                        " FROM SigCdPro" + ;
                                        " WHERE Cpros = " + EscaparSQL(cursor_4c_ProdutosGrupo.Cpros)

                                    IF USED("cursor_4c_DadosProduto")
                                        USE IN cursor_4c_DadosProduto
                                    ENDIF
                                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosProduto")

                                    IF loc_nResultado < 1
                                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalProds)")
                                        loc_lResultado = .F.
                                        EXIT
                                    ENDIF

                                    SELECT cursor_4c_DadosProduto
                                    GO TOP

                                    IF !EOF("cursor_4c_DadosProduto")
                                        loc_cRef = PADR(CHRTRAN(cursor_4c_DadosProduto.Cpros, [ */\:?"'<>|], []), 25)
                                        loc_cDes = PADR(ALLTRIM(cursor_4c_DadosProduto.Dpros), 60)
                                        loc_cUni = PADR(ALLTRIM(cursor_4c_DadosProduto.Cunis), 3)
                                        loc_cDat = DTOC(TTOD(cursor_4c_DadosProduto.DtIncs))
                                        loc_cSit = IIF(cursor_4c_DadosProduto.Situas = 2, "i", "a")
                                        *-- PADL direto na COLUNA (nao em variavel) converte o
                                        *-- numero com as decimais DECLARADAS no SQL Server
                                        *-- (pesoms numeric(8,3), pvens numeric(11,5)); em
                                        *-- variavel usaria SET DECIMALS (regra CLAUDE.md #42
                                        *-- / sigopecmBO.GerarArquivoExportacao).
                                        loc_cPes = STRTRAN(PADL(cursor_4c_DadosProduto.PesoMs, 8, "0"), ".", ",")
                                        loc_cIpi = PADL(INT(cursor_4c_DadosProduto.AliqIpis), 2, "0")
                                        loc_cIcm = PADL(INT(cursor_4c_DadosProduto.Icms), 2, "0")
                                        loc_cClf = PADR(CHRTRAN(cursor_4c_DadosProduto.ClFiscals, [ .], []), 8)
                                        loc_cTri = PADR(cursor_4c_DadosProduto.SitTrIcms, 3)
                                        loc_cVal = STRTRAN(PADL(cursor_4c_DadosProduto.Pvens, 8, "0"), ".", ",")
                                        loc_cPre = PADR("00000000" + loc_cVal + "0000^", 400)

                                        loc_cGvd = ""

                                        *-- Colecoes/caracteristicas do produto (SigPrCar + SigCrRap)
                                        loc_cSQL = "SELECT b.Descrs, b.Ordens" + ;
                                            " FROM SigPrCar a, SigCrRap b" + ;
                                            " WHERE a.Cpros = " + EscaparSQL(cursor_4c_DadosProduto.Cpros) + ;
                                            "   AND a.Codigos = b.Codigos"

                                        IF USED("cursor_4c_Caracteristicas")
                                            USE IN cursor_4c_Caracteristicas
                                        ENDIF
                                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Caracteristicas")

                                        IF loc_nResultado < 1
                                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalCaracs)")
                                            loc_lResultado = .F.
                                            EXIT
                                        ENDIF

                                        SELECT cursor_4c_Caracteristicas
                                        SCAN
                                            IF !EMPTY(cursor_4c_Caracteristicas.Ordens)
                                                IF !SEEK(cursor_4c_Caracteristicas.Ordens, "cursor_4c_ControleGrupos", "Grupo")
                                                    INSERT INTO cursor_4c_ControleGrupos (Grupo) VALUES (cursor_4c_Caracteristicas.Ordens)

                                                    loc_cGr1 = PADL(cursor_4c_Caracteristicas.Ordens, 8, "0")
                                                    loc_cDe1 = PADR(ALLTRIM(cursor_4c_Caracteristicas.Descrs), 40)
                                                    loc_cUn1 = PADR("", 4)

                                                    *-- td01 - Tabela de Grupos (colecao)
                                                    loc_cStr = "td01" + loc_cGr1 + loc_cDe1 + loc_cUn1 + loc_cChr

                                                    STRTOFILE(loc_cStr, loc_cArquivo, .T.)
                                                ENDIF
                                                loc_cGvd = loc_cGvd + ALLTRIM(STR(cursor_4c_Caracteristicas.Ordens, 8)) + "^"
                                            ENDIF
                                        ENDSCAN
                                        loc_cGvd = PADR(ALLTRIM(loc_cGvd), 60)

                                        *-- td03 - Tabela de Produtos
                                        loc_cStr = "td03" + ;               && Tipo - "td03" - Constante - Caracter(4)
                                            SPACE(8) + ;                    && RESERVADO - Caracter(8)
                                            loc_cRef + ;                    && Referencia - Caracter(25)
                                            loc_cDes + ;                    && Descricao - Caracter(60)
                                            loc_cUni + ;                    && Unidade - Caracter(3)
                                            loc_cGru + ;                    && ID Grupo - Numerico(8)
                                            "00000000" + ;                  && ID Subgrupo - Numerico(8)
                                            loc_cDat + ;                    && Data do produto - Data(10)
                                            " " + ;                         && Alternativo - Caracter(1)
                                            "001" + ;                       && Multiplicador - Numerico(3)
                                            PADR(loc_cRef, 20) + ;          && Nome Foto Sem Extensao - Caracter(20)
                                            loc_cSit + ;                    && Status Produto a=ativo/i=inativo - Caracter(1)
                                            "00000000" + ;                  && Desconto Maximo em % - Numerico(8)
                                            "00" + ;                        && Tabela - Caracter(2)
                                            loc_cPes + ;                    && Peso - Numerico(8)
                                            " " + ;                         && Status Foto - Caracter(1)
                                            " " + ;                         && Lancamento - Caracter(1)
                                            loc_cIpi + ;                    && % do IPI - Numerico(2)
                                            "00000000" + ;                  && Valor IPI - Numerico(8)
                                            loc_cIcm + ;                    && % ICMS - Numerico(2)
                                            "00000000" + ;                  && Valor ICMS - Numerico(8)
                                            loc_cClf + ;                    && Classificacao Fiscal - Caracter(8)
                                            loc_cTri + ;                    && Situacao Tributaria - Caracter(3)
                                            SPACE(8) + ;                    && RESERVADO - Caracter(8)
                                            "00000000" + ;                  && Estoque - Numerico(8)
                                            loc_cPre + ;                    && Lista(8)+Preco(8)+QtdeMinima(4)+^ - Caracter(400)
                                            SPACE(20) + ;                   && Codigo de Barras - Caracter(20)
                                            SPACE(64) + ;                   && RESERVADO - Caracter(64)
                                            SPACE(400) + ;                  && Caracteristicas (separador CHR(13)) - Caracter(400)
                                            loc_cGvd + loc_cChr             && Material/Complemento - Caracter(60)

                                        STRTOFILE(loc_cStr, loc_cArquivo, .T.)

                                        loc_nQtdProdutos = loc_nQtdProdutos + 1
                                        THIS.AtualizarProgresso(loc_nQtdGrupos, loc_nQtdProdutos)

                                        *-- Exportando a imagem. O legado NAO consulta
                                        *-- chkImagens aqui - ver nota de
                                        *-- this_lExportarImagens no cabecalho do metodo.
                                        IF !EMPTY(cursor_4c_DadosProduto.FigJpgs) AND !ISNULL(cursor_4c_DadosProduto.FigJpgs)
                                            loc_cImg  = ALLTRIM(JUSTPATH(loc_cArquivo)) + "\" + ALLTRIM(loc_cRef) + ".Jpg"
                                            loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_DadosProduto.FigJpgs, ;
                                                "data:image/png;base64,", ""), ;
                                                "data:image/jpeg;base64,", ""), ;
                                                "data:image/jpg;base64,", ""), 14)
                                            STRTOFILE(loc_cFoto, loc_cImg)
                                        ENDIF
                                    ENDIF

                                    IF USED("cursor_4c_DadosProduto")
                                        USE IN cursor_4c_DadosProduto
                                    ENDIF
                                    IF USED("cursor_4c_Caracteristicas")
                                        USE IN cursor_4c_Caracteristicas
                                    ENDIF
                                ENDSCAN

                                IF USED("cursor_4c_ProdutosGrupo")
                                    USE IN cursor_4c_ProdutosGrupo
                                ENDIF
                            ENDIF

                            IF USED("cursor_4c_DadosGrupo")
                                USE IN cursor_4c_DadosGrupo
                            ENDIF
                        ENDSCAN

                        THIS.this_nQtdGrupos   = loc_nQtdGrupos
                        THIS.this_nQtdProdutos = loc_nQtdProdutos

                        IF loc_lResultado
                            IF loc_nQtdProdutos > 0
                                THIS.this_cMensagemProgresso = "Arquivo de Produtos Gerado Com Sucesso!!!"
                            ELSE
                                THIS.this_cMensagemProgresso = "Aten" + CHR(231) + CHR(227) + "o!!! Arquivo Gerado Sem Produtos!!!"
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gerar arquivo TXT: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo)
            loc_lResultado = .F.
        FINALLY
            IF USED("cursor_4c_GruposSelec")
                USE IN cursor_4c_GruposSelec
            ENDIF
            IF USED("cursor_4c_ProdutosGrupo")
                USE IN cursor_4c_ProdutosGrupo
            ENDIF
            IF USED("cursor_4c_ControleGrupos")
                USE IN cursor_4c_ControleGrupos
            ENDIF
            IF USED("cursor_4c_DadosGrupo")
                USE IN cursor_4c_DadosGrupo
            ENDIF
            IF USED("cursor_4c_DadosProduto")
                USE IN cursor_4c_DadosProduto
            ENDIF
            IF USED("cursor_4c_Caracteristicas")
                USE IN cursor_4c_Caracteristicas
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
