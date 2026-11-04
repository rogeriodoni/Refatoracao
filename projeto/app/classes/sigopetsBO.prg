*====================================================================
* sigopetsBO.prg
*
* Business Object de SIGOPETS - Impressao de Etiquetas de Produto
* (dialogo FILHO que configura os parametros de impressao - tipo de
*  etiqueta, impressora, ajustes de hardware - e dispara a rotina de
*  impressao; NAO possui tabela propria gravada por este BO)
*
* Origem legado : SIGOPETS.SCX ("SigOpEtS" no Do Form do chamador)
*                 tasks\task733\sigopets_form_codigo_fonte.txt
* Chamado por   : SIGMVCAB, depois de montar os cursores de cabecalho/
*                 itens do movimento
*                 Do Form SigOpEtS With ThisForm, ThisForm.DataSessionId
*                 (confirmado em tasks\task560\sigmvcab_form_codigo_fonte.txt,
*                  linhas 26869 e 32547)
*
* Tabelas de apoio (consultadas, NUNCA gravadas por este BO):
*   SigCdTpe  - tipos de etiqueta disponiveis (filtro nSituas = 1)
*   SigCdPam  - parametros/padroes do sistema (CrSigCdPam - o legado
*               espera esse cursor JA aberto pelo chamador; o Init so
*               faz Goto Top nele)
*   SigCdPac  - parametros de pacote/impressora (CrSigCdPac; se nao
*               estiver aberto, o legado consulta via SqlExecute)
*   SigCdmp   - impressoras configuradas por usuario/grupo (via
*               SigSyImp + SigCdAcG), casadas contra APRINTERS() do
*               Windows
*
* Cursores temporarios do legado espelhados pelas propriedades abaixo:
*   crImpre / crImpreV    - impressoras do Windows casadas com SigCdmp,
*                           exibidas no combobox Get_Printer
*   dbImpressao           - grade de etiquetas a imprimir; MONTADA PELO
*                           FORM PAI (SigMvCab) antes de abrir esta tela
*                           e, para alguns tipos de etiqueta (Romaneio,
*                           262, 145/155, 146/156/165/175, 158..163/174),
*                           REMONTADA aqui a partir de TprMvCab/crSigMvNfi
*   TprMvCab / crSigMvNfi - cursores de CABECALHO/ITENS de movimento,
*                           abertos pelo FORM PAI; este BO so LE
*
* A impressao de fato eh feita pela funcao global legado SigOpEtq()
* (SIGFUNCS.PRG), que recebe os ajustes configurados nesta tela e
* imprime a partir do cursor dbImpressao.
*
* Leitura de parametros: CarregarDoCursor() eh a fonte UNICA - todos os
* pontos que leem impetis/ajverts/ajhorzs/ajdens/ajvelos/etqseps/ntipos
* (CrSigCdPam, CrSigCdPac e o registro de SigCdmp da impressora
* escolhida) passam por ele, com os pisos e a regra "impetis = 0 nao
* troca o tipo" num lugar so.
*
* Gravacao: Inserir(), Atualizar(), ExecutarExclusao(),
* ObterChavePrimaria() e RegistrarAuditoria() ficam HERDADOS de
* BusinessBase - o dump legado prova que esta tela nao grava no SQL
* Server (so SELECT; todo Insert Into tem por destino cursor LOCAL) e o
* comportamento herdado ja eh o correto. Justificativa completa, com as
* linhas do dump, no bloco de comentario ao final desta classe.
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigopetsBO AS BusinessBase

    *----------------------------------------------------------------
    * Contrato com o FORM PAI (SigMvCab) - cursores que o pai ja deixa
    * abertos antes de instanciar esta tela; este BO somente LE.
    *----------------------------------------------------------------
    this_cCursorMovCab    = "TprMvCab"     && cabecalho do movimento (EmpDopNums, Dopes, Numes, ContaDs)
    this_cCursorItensNfi  = "crSigMvNfi"   && itens da nota fiscal (Qtdes, NFis)
    this_cCursorImpressao = "dbImpressao"  && grade de etiquetas a imprimir (CPros, Qtds, QtdeEtiq, Pedido, Obs, Moedas, EmpDopNums, PVens, Pesos, CItens, CodTams, CBars)

    *----------------------------------------------------------------
    * Tipo de etiqueta selecionado (Opt_Tipo) - populado a partir de
    * SigCdTpe.nTipos (Where nSituas = 1), guardado no Tag do botao
    *----------------------------------------------------------------
    this_nTipoEtiqueta       = 0   && vTipEtq - codigo do tipo de etiqueta (SigCdTpe.nTipos)
    this_nTotalTiposEtiqueta = 0   && lnTipos - Count(*) de SigCdTpe Where nSituas = 1
    this_nIndiceTipoPadrao   = 1   && indice do botao de Opt_Tipo casado com CrSigCdPam.TpEtiPads

    *----------------------------------------------------------------
    * Opcoes de impressao (Opt_Preco, opt_Qtd, OptOrigem)
    *----------------------------------------------------------------
    this_lImprimirPreco     = .F.  && Opt_Preco.Value = 1 (Sim/Nao) - llImpPreco
    this_lImprimirPesoTotal = .F.  && Cnt_Impressora.opt_Qtd.Value - "Imprimir Qtd/Peso Total" - llImpPeso
    this_lOrigemEtiqueta140 = .F.  && OptOrigem.Value <> 1 - usado so na etiqueta tipo 140 - llOrigem

    *----------------------------------------------------------------
    * Impressora selecionada (Cnt_Impressora, Get_Printer)
    *----------------------------------------------------------------
    this_cNomeImpressora  = ""   && lcNomeImp - crImpreV.impres da impressora escolhida no combobox
    this_nTotalImpressoras = 0   && lnImpres - impressoras do Windows casadas com SigCdmp
    this_nTipoImpressora   = 1   && Cnt_Impressora.Opcao_Imp.Value (1=Allegro,2=Zebra ZPL,3=Zebra EPL) - default CrSigCdPam.ImpEtis
    this_nAjusteVertical    = 0  && Spn_AjVerts.Value - default CrSigCdPam.AjVerts
    this_nAjusteHorizontal  = 0  && Spn_AjHorzs.Value - default CrSigCdPam.AjHorzs
    this_nAjusteDensidade   = 10 && Spn_AjDenss.Value - default CrSigCdPac.AjDens (minimo 10)
    this_nAjusteVelocidade  = 1  && Spn_AjVelos.Value - default CrSigCdPac.AjVelos (minimo 1)

    *----------------------------------------------------------------
    * Demais opcoes de impressao (opt_separador, OptOrdem)
    *----------------------------------------------------------------
    this_lSeparador = .F.  && opt_separador.Value = 1 (Sim) - llSeparador; default vem de CrSigCdPac.etqseps = 1
    this_nOrdem     = 2    && OptOrdem.Value (1=Produto/Index On Cpros, 2=Sem Ordem/Index On Recno())
    this_cBop       = ""   && lcBop - Padl(NDopes,4,'0')+Padl(Numes,6,'0'), usado quando vTipEtq <> 81

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- Dialogo de configuracao de impressao: nao possui tabela
        *-- propria gravada por INSERT/UPDATE/DELETE (a impressao em si
        *-- eh feita por SigOpEtq() a partir do cursor dbImpressao, que
        *-- o FORM PAI monta/remonta - ver cabecalho deste arquivo).
        *-- O comportamento padrao herdado de BusinessBase para
        *-- Inserir/Atualizar/ExecutarExclusao/ObterChavePrimaria/
        *-- RegistrarAuditoria ja eh o correto para este dialogo.
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        RETURN .T.
    ENDPROC

    *====================================================================
    * GarantirCursorSigCdPac - Garante que CrSigCdPac esteja aberto.
    * Legado (Init): If Not Used('SigCdPac') / CursorQuery(...) / Go Top.
    * SigCdPac eh tabela de parametros de pacote/impressora de UMA linha
    * so (mesmo padrao de SigCdPam), por isso o SELECT sem WHERE.
    *====================================================================
    PROTECTED FUNCTION GarantirCursorSigCdPac()
        LOCAL loc_lSucesso, loc_nResultado

        loc_lSucesso = .T.

        IF !USED("CrSigCdPac")
            TRY
                loc_nResultado = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPac", "CrSigCdPac")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lSucesso = .F.
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lSucesso = .F.
            ENDTRY
        ENDIF

        IF loc_lSucesso AND USED("CrSigCdPac")
            GO TOP IN CrSigCdPac
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarTiposEtiqueta - Carrega os tipos de etiqueta disponiveis.
    * Legado (Init):
    *   lcQuery = [Select * From SigCdTpe Where nSituas = 1]
    *   SqlExecute(lcQuery, 'CrSigCdTpe')
    *   Index On cordems + cEtiquetas Tag cordems
    *   Count To lnTipos
    * O ORDER BY substitui o INDEX ON (o cursor ja chega ordenado).
    *====================================================================
    FUNCTION CarregarTiposEtiqueta()
        LOCAL loc_lSucesso, loc_nResultado

        loc_lSucesso = .F.

        TRY
            IF USED("CrSigCdTpe")
                USE IN CrSigCdTpe
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigCdTpe WHERE nSituas = 1 " + ;
                "ORDER BY cordems, cEtiquetas", "CrSigCdTpe")

            IF loc_nResultado >= 1
                THIS.this_nTotalTiposEtiqueta = RECCOUNT("CrSigCdTpe")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ObterIndiceTipoEtiquetaPadrao - Devolve o indice (1-based) do tipo
    * de etiqueta que casa com CrSigCdPam.TpEtiPads, dentro do numero
    * maximo de botoes que a tela vai desenhar (par_nMaxBotoes).
    * Legado (Init): Scan For lnI < lnMaxTipos / If CrSigCdTpe.nTipos = ;
    *                CrSigCdPam.TpEtiPads / lnTipoPadrao = lnI / EndIf
    *====================================================================
    FUNCTION ObterIndiceTipoEtiquetaPadrao(par_nMaxBotoes)
        LOCAL loc_nIndicePadrao, loc_nI, loc_nAreaAnterior

        loc_nIndicePadrao = 1

        IF USED("CrSigCdTpe") AND USED("CrSigCdPam") AND VARTYPE(par_nMaxBotoes) = "N"
            loc_nAreaAnterior = SELECT()
            SELECT CrSigCdTpe
            GO TOP
            loc_nI = 1
            SCAN WHILE loc_nI <= par_nMaxBotoes
                IF CrSigCdTpe.nTipos = CrSigCdPam.TpEtiPads
                    loc_nIndicePadrao = loc_nI
                ENDIF
                loc_nI = loc_nI + 1
            ENDSCAN
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_nIndicePadrao
    ENDFUNC

    *====================================================================
    * CarregarImpressorasDisponiveis - Monta os cursores de impressora
    * exibidos no combobox Get_Printer (RowSource = "crImpreV").
    * Legado (Init, linhas 1018-1126): Aprinters() casado com SigCdmp
    * (impressoras liberadas para o usuario via SigSyImp/SigCdAcG).
    *
    * crImpre  = impressoras do Windows (Aprinters)
    * crSigCdmp = impressoras liberadas para gc_4c_UsuarioLogado (direto
    *             via SigSyImp ou por grupo via SigCdAcG), filtradas por
    *             nTpImpres = 2
    * crImpreV = combinacao (match textual) entre as duas - cursor que
    *            alimenta Get_Printer.RowSource
    *====================================================================
    FUNCTION CarregarImpressorasDisponiveis()
        LOCAL loc_lSucesso, loc_aPrinters[1], loc_nPrinters, loc_nI, ;
              loc_cSQL, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_nTotalImpressoras = 0

        TRY
            loc_nPrinters = APRINTERS(loc_aPrinters)

            IF USED("crImpre")
                USE IN crImpre
            ENDIF
            CREATE CURSOR crImpre (impres C(50))

            IF loc_nPrinters <= 0
                THIS.this_cMensagemErro = "N" + CHR(227) + "o Foi Encontrada Nenhuma Impressora!!!"
            ELSE
                FOR loc_nI = 1 TO loc_nPrinters
                    INSERT INTO crImpre (impres) VALUES (UPPER(loc_aPrinters[loc_nI, 1]))
                ENDFOR

                loc_cSQL = "SELECT b.impres, b.nTpImpres FROM SigSyImp a, SigCdmp b " + ;
                           "WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + " AND a.cimps = b.impres " + ;
                           "UNION ALL " + ;
                           "SELECT c.impres, c.nTpImpres FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
                           "WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + " " + ;
                           "AND a.Grupos = b.GrAcess AND b.cimps = c.impres"

                IF USED("cursor_4c_ImpressorasTemp")
                    USE IN cursor_4c_ImpressorasTemp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpressorasTemp")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o com Servidor de Banco de Dados."
                ELSE
                    IF USED("crSigCdmp")
                        USE IN crSigCdmp
                    ENDIF

                    IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ImpressorasTemp") > 0
                        SELECT impres, nTpImpres FROM cursor_4c_ImpressorasTemp ;
                            INTO CURSOR crSigCdmp READWRITE
                        SELECT crSigCdmp
                        INDEX ON impres TAG skImpres
                    ELSE
                        CREATE CURSOR crSigCdmp (impres C(50), nTpImpres N(4,0))
                    ENDIF

                    IF USED("cursor_4c_ImpressorasTemp")
                        USE IN cursor_4c_ImpressorasTemp
                    ENDIF

                    IF USED("crImp")
                        USE IN crImp
                    ENDIF

                    *-- Sem filtro de nTpImpres aqui - o legado tambem nao filtra
                    *-- nesta SELECT (Init, linha 1112); o filtro nTpImpres = 2
                    *-- so existia no Scan do Opt_Impressora (radio aposentado,
                    *-- substituido pelo combobox Get_Printer/crImpreV).
                    SELECT PADR(ALLTRIM(a.impres), 15) + " " + ALLTRIM(b.impres) AS IDupla, ;
                           b.impres, a.impres AS impresS ;
                        FROM crSigCdmp a, crImpre b ;
                        WHERE ALLTRIM(UPPER(a.impres)) LIKE "%" + ALLTRIM(UPPER(b.impres)) + "%" OR ;
                              ALLTRIM(UPPER(b.impres)) LIKE "%" + ALLTRIM(UPPER(a.impres)) + "%" ;
                        GROUP BY b.impres, a.impres ;
                        INTO CURSOR crImp READWRITE

                    IF RECCOUNT("crImp") > 1
                        APPEND BLANK
                    ENDIF

                    IF USED("crImpreV")
                        USE IN crImpreV
                    ENDIF

                    SELECT * FROM crImp ORDER BY 1 INTO CURSOR crImpreV READWRITE

                    THIS.this_nTotalImpressoras = RECCOUNT("crImpreV")

                    IF USED("crImpreV")
                        GO TOP IN crImpreV
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ObterParametrosPadraoImpressao - Carrega os defaults de ajuste de
    * impressao a partir de CrSigCdPam (contrato - aberto pelo chamador)
    * e CrSigCdPac (garantido por GarantirCursorSigCdPac).
    * Legado (Init, linhas 1165-1178).
    *====================================================================
    FUNCTION ObterParametrosPadraoImpressao()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF !THIS.GarantirCursorSigCdPac()
            RETURN .F.
        ENDIF

        IF USED("CrSigCdPam") AND USED("CrSigCdPac")
            *-- O legado resolve o tipo de impressora com
            *-- Iif(CrSigCdPam.ImpEtis <> 0, CrSigCdPam.ImpEtis, 1): o 1 eh
            *-- firmado AQUI, antes de ler o cursor, porque
            *-- CarregarDoCursor() so troca o tipo quando a coluna traz
            *-- valor diferente de zero (zero em impetis significa "nao
            *-- configurado", nunca o valor zero).
            THIS.this_nTipoImpressora = 1

            *-- CrSigCdPam traz impetis/ajverts/ajhorzs; CrSigCdPac traz
            *-- ajdens/ajvelos/etqseps. Os conjuntos de colunas sao
            *-- disjuntos (conferido em docs\schema.sql), por isso a
            *-- segunda chamada nao sobrescreve o que a primeira carregou.
            loc_lSucesso = THIS.CarregarDoCursor("CrSigCdPam")

            IF loc_lSucesso
                loc_lSucesso = THIS.CarregarDoCursor("CrSigCdPac")
            ENDIF
        ELSE
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarAjustesImpressora - Recarrega tipo/ajustes de impressao
    * quando o usuario troca a impressora selecionada no combobox.
    *
    * Legado: Opt_Impressora.InteractiveChange / Get_Printer.Interactive-
    * Change chamam a funcao global fCarregarImps() (SIGFUNCS.PRG), que
    * NAO veio no acervo extraido para esta task (ver comportamento.json,
    * "funcoesExternas"). Nao ha como transcrever o corpo original.
    *
    * Esta implementacao reproduz o efeito observavel pelos nomes de
    * parametro do call site (recarregar Opcao_Imp/ajustes a partir da
    * impressora escolhida), usando as colunas que SigCdmp efetivamente
    * tem para isso - impetis/ajdens/ajhorzs/ajvelos/ajverts, a mesma
    * familia de colunas usada em CrSigCdPam/CrSigCdPac para os defaults
    * (ver ObterParametrosPadraoImpressao). Sem registro casando o nome
    * da impressora, os defaults carregados antes permanecem validos.
    *====================================================================
    FUNCTION CarregarAjustesImpressora(par_cNomeImpressora)
        LOCAL loc_lSucesso, loc_nResultado, loc_lCarregou

        loc_lSucesso = .F.

        *-- LOCAL nasce .F. em VFP9: sem este .T. explicito, impressora sem
        *-- registro casando em SigCdmp (o SELECT volta zero linhas, caminho
        *-- legitimo - os defaults carregados antes seguem validos) sairia
        *-- como FALHA.
        loc_lCarregou = .T.

        IF VARTYPE(par_cNomeImpressora) != "C" OR EMPTY(par_cNomeImpressora)
            RETURN .T.
        ENDIF

        TRY
            IF USED("cursor_4c_AjusteImpressora")
                USE IN cursor_4c_AjusteImpressora
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT impetis, ajdens, ajhorzs, ajvelos, ajverts FROM SigCdmp " + ;
                "WHERE impres = " + EscaparSQL(ALLTRIM(par_cNomeImpressora)), ;
                "cursor_4c_AjusteImpressora")

            IF loc_nResultado >= 1 AND RECCOUNT("cursor_4c_AjusteImpressora") > 0
                SELECT cursor_4c_AjusteImpressora
                GO TOP

                *-- Mesma familia de colunas dos defaults (impetis/ajverts/
                *-- ajhorzs/ajdens/ajvelos), com os mesmos pisos: a leitura
                *-- mora toda em CarregarDoCursor().
                loc_lCarregou = THIS.CarregarDoCursor("cursor_4c_AjusteImpressora")
            ENDIF

            IF USED("cursor_4c_AjusteImpressora")
                USE IN cursor_4c_AjusteImpressora
            ENDIF

            loc_lSucesso = loc_lCarregou
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * MontarCursorImpressao - Remonta THIS.this_cCursorImpressao
    * (dbImpressao) a partir dos cursores de movimento (TprMvCab/
    * crSigMvNfi), para os tipos de etiqueta que o legado remonta.
    * Para os demais tipos, dbImpressao fica como o FORM PAI (SigMvCab)
    * ja deixou montado - este metodo nao faz nada nesses casos.
    *
    * Legado: Imprime.Click, linhas 1237-1376.
    *====================================================================
    FUNCTION MontarCursorImpressao(par_nTipoEtiqueta)
        LOCAL loc_lSucesso, loc_lContinuar, loc_cCursorMov, loc_cCursorItn, loc_cCursorImp, ;
              loc_cSQL, loc_nResultado, loc_nEtiquetas, loc_nI, loc_cNum

        loc_lSucesso = .T.
        loc_lContinuar = .T.
        loc_cCursorMov = THIS.this_cCursorMovCab
        loc_cCursorItn = THIS.this_cCursorItensNfi
        loc_cCursorImp = THIS.this_cCursorImpressao

        IF !USED(loc_cCursorImp)
            THIS.this_cMensagemErro = "Cursor de impress" + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            IF INLIST(par_nTipoEtiqueta, 23, 30, 102)
                *-- Romaneio
                SELECT (loc_cCursorImp)
                ZAP

                IF USED(loc_cCursorItn) AND !EOF(loc_cCursorItn) AND ;
                   USED(loc_cCursorMov) AND !EOF(loc_cCursorMov)

                    loc_nEtiquetas = IIF(EVALUATE(loc_cCursorItn + ".Qtdes") < 1, 1, ;
                        EVALUATE(loc_cCursorItn + ".Qtdes"))

                    FOR loc_nI = 1 TO loc_nEtiquetas
                        loc_cNum = ALLTRIM(STR(loc_nI, 14, 0)) + "/" + ALLTRIM(STR(loc_nEtiquetas, 14, 0))
                        INSERT INTO (loc_cCursorImp) (Cpros, Obs, CBars, Qtds) VALUES ;
                            (loc_cNum, EVALUATE(loc_cCursorMov + ".ContaDs"), ;
                             INT(VAL(EVALUATE(loc_cCursorItn + ".NFis"))), 1)
                    ENDFOR
                ENDIF

            ELSE
                IF loc_lContinuar AND USED(loc_cCursorMov) AND par_nTipoEtiqueta = 262

                    SELECT (loc_cCursorImp)
                    ZAP

                    loc_cSQL = "SELECT i.CPros, i.Qtds, a.Notas, LEFT(a.Ecfs, 3) AS Ecfs, a.Datas, a.Vends, b.Prins " + ;
                               "FROM SigMvItn i, SigMvCab a, SigCdEmp b " + ;
                               "WHERE i.EmpDopNums = " + EscaparSQL(EVALUATE(loc_cCursorMov + ".EmpDopNums")) + " " + ;
                               "AND a.EmpDopNums = i.EmpDopNums " + ;
                               "AND a.Emps = b.Cemps " + ;
                               "ORDER BY i.CItens"

                    loc_nResultado = THIS.ExecutarQueryRemontagem(loc_cSQL)

                    IF loc_nResultado < 1
                        loc_lContinuar = .F.
                    ELSE
                        SELECT cursor_4c_RemontaImpressao
                        SCAN
                            FOR loc_nI = 1 TO cursor_4c_RemontaImpressao.Qtds
                                INSERT INTO (loc_cCursorImp) (CPros, Qtds, QtdeEtiq, Pedido, Obs, Moedas, EmpDopNums) VALUES ;
                                    (cursor_4c_RemontaImpressao.CPros, 1, 1, cursor_4c_RemontaImpressao.Prins, ;
                                     cursor_4c_RemontaImpressao.Vends, cursor_4c_RemontaImpressao.Ecfs, ;
                                     LEFT(TTOC(cursor_4c_RemontaImpressao.Datas), 10) + cursor_4c_RemontaImpressao.Notas)
                            ENDFOR
                            SELECT cursor_4c_RemontaImpressao
                        ENDSCAN
                        USE IN cursor_4c_RemontaImpressao
                    ENDIF

                ENDIF

                IF loc_lContinuar AND USED(loc_cCursorMov) AND INLIST(par_nTipoEtiqueta, 145, 155)

                    SELECT (loc_cCursorImp)
                    ZAP

                    loc_cSQL = "SELECT LTRIM(RTRIM(CONVERT(VARCHAR(10),ROW_NUMBER() OVER(ORDER BY a.empdopnums ASC)))) + " + ;
                               EscaparSQL(SYS(2015)) + " AS Cpros, " + ;
                               "COUNT(1) AS qtdes, b.cpfs, rclis, F.tipos, a.datas, a.EmpDopNums, a.emps, a.dopes, " + ;
                               "a.numes, a.PedidoWeb, a.Notas, a.IDEntrega " + ;
                               "FROM SigMvCab a " + ;
                               "JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                               "JOIN SigMvNfi c ON a.EmpDopNums = c.EmpDopNums " + ;
                               "JOIN SIGMVITN D ON a.EmpDopNums = D.EmpDopNums " + ;
                               "JOIN sigcdpro e ON d.cpros = e.cpros " + ;
                               "JOIN sigcdcls F ON E.cClass = F.cods " + ;
                               "WHERE a.EmpDopNums = " + EscaparSQL(EVALUATE(loc_cCursorMov + ".EmpDopNums")) + " " + ;
                               "GROUP BY b.cpfs, rclis, F.tipos, a.datas, a.EmpDopNums, a.emps, a.dopes, a.numes, " + ;
                               "a.PedidoWeb, a.Notas, a.IDEntrega"

                    loc_nResultado = THIS.ExecutarQueryRemontagem(loc_cSQL)

                    IF loc_nResultado < 1
                        loc_lContinuar = .F.
                    ELSE
                        SELECT cursor_4c_RemontaImpressao
                        SCAN
                            INSERT INTO (loc_cCursorImp) (CPros, Qtds, QtdeEtiq, Pedido, Obs, Moedas, EmpDopNums) VALUES ;
                                (cursor_4c_RemontaImpressao.CPros, 1, 1, "", "", "", cursor_4c_RemontaImpressao.EmpDopNums)
                        ENDSCAN
                        USE IN cursor_4c_RemontaImpressao
                    ENDIF

                ENDIF

                IF loc_lContinuar AND USED(loc_cCursorMov) AND INLIST(par_nTipoEtiqueta, 146, 156, 165, 175)

                    SELECT (loc_cCursorImp)
                    ZAP

                    loc_cSQL = "SELECT LTRIM(RTRIM(CONVERT(VARCHAR(10),ROW_NUMBER() OVER(ORDER BY a.empdopnums ASC)))) + " + ;
                               EscaparSQL(SYS(2015)) + " AS Cpros, " + ;
                               "a.*, 1 AS qtdes, b.rclis, c.CliFors, e.Distribs, ISNULL(g.razaos,'') AS Transp " + ;
                               "FROM SigMvCab a " + ;
                               "JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                               "JOIN SigMvNfi c ON a.EmpDopNums = c.EmpDopNums " + ;
                               "JOIN SigCdOpe d ON a.Dopes = d.Dopes " + ;
                               "JOIN SigOpCdd e ON e.Dopes = d.Dopes " + ;
                               "LEFT JOIN sigprtrp g ON a.idTransp = g.itras " + ;
                               "WHERE a.EmpDopNums = " + EscaparSQL(EVALUATE(loc_cCursorMov + ".EmpDopNums"))

                    loc_nResultado = THIS.ExecutarQueryRemontagem(loc_cSQL)

                    IF loc_nResultado < 1
                        loc_lContinuar = .F.
                    ELSE
                        SELECT cursor_4c_RemontaImpressao
                        SCAN
                            INSERT INTO (loc_cCursorImp) (CPros, Qtds, QtdeEtiq, Pedido, Obs, Moedas, EmpDopNums) VALUES ;
                                (cursor_4c_RemontaImpressao.CPros, 1, 1, "", "", "", cursor_4c_RemontaImpressao.EmpDopNums)
                        ENDSCAN
                        USE IN cursor_4c_RemontaImpressao
                    ENDIF

                ENDIF

                IF loc_lContinuar AND USED(loc_cCursorMov) AND INLIST(par_nTipoEtiqueta, 158, 159, 160, 161, 162, 163, 174)

                    SELECT (loc_cCursorImp)
                    ZAP

                    loc_cSQL = "SELECT d.Cpros, d.qtds AS qtdes, b.cpfs, rclis, F.tipos, a.datas, " + ;
                               "a.EmpDopNums, a.emps, a.dopes, a.numes, a.PedidoWeb, a.Notas, a.IDEntrega, " + ;
                               "a.contads AS conta, d.CodBarras, CONVERT(CHAR(150),ISNULL(e.obsMkt,'')) AS obsMkt " + ;
                               "FROM SigMvCab a " + ;
                               "JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                               "LEFT JOIN SigMvNfi c ON a.EmpDopNums = c.EmpDopNums " + ;
                               "JOIN SIGMVITN D ON a.EmpDopNums = D.EmpDopNums " + ;
                               "JOIN sigcdpro e ON d.cpros = e.cpros " + ;
                               "JOIN sigcdcls F ON E.cClass = F.cods " + ;
                               "WHERE a.EmpDopNums = " + EscaparSQL(EVALUATE(loc_cCursorMov + ".EmpDopNums"))

                    loc_nResultado = THIS.ExecutarQueryRemontagem(loc_cSQL)

                    IF loc_nResultado < 1
                        loc_lContinuar = .F.
                    ELSE
                        SELECT cursor_4c_RemontaImpressao
                        SCAN
                            INSERT INTO (loc_cCursorImp) (CPros, Qtds, QtdeEtiq, Pedido, Obs, Moedas, EmpDopNums) VALUES ;
                                (cursor_4c_RemontaImpressao.CPros, cursor_4c_RemontaImpressao.qtdes, 1, "", "", "", ;
                                 cursor_4c_RemontaImpressao.EmpDopNums)
                        ENDSCAN
                        USE IN cursor_4c_RemontaImpressao
                    ENDIF

                ENDIF
            ENDIF

            loc_lSucesso = loc_lContinuar
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExecutarQueryRemontagem - Helper interno de MontarCursorImpressao;
    * roda a query no cursor intermediario cursor_4c_RemontaImpressao e
    * define a mensagem de erro padrao do legado em caso de falha.
    *====================================================================
    PROTECTED FUNCTION ExecutarQueryRemontagem(par_cSQL)
        LOCAL loc_nResultado

        IF USED("cursor_4c_RemontaImpressao")
            USE IN cursor_4c_RemontaImpressao
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, "cursor_4c_RemontaImpressao")

        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
        ENDIF

        RETURN loc_nResultado
    ENDFUNC

    *====================================================================
    * ObterBop - Monta o "lcBop" do legado (numero da operacao + numero
    * do movimento, usado pela impressora para compor o codigo de barras
    * da etiqueta). Vazio para o tipo de etiqueta 81 (o legado nunca
    * monta o Bop nesse caso).
    * Legado: Imprime.Click, linhas 1382-1388.
    *====================================================================
    FUNCTION ObterBop(par_nTipoEtiqueta)
        LOCAL loc_cBop, loc_cCursorMov, loc_cSQL, loc_nResultado

        loc_cBop = ""
        loc_cCursorMov = THIS.this_cCursorMovCab

        IF par_nTipoEtiqueta <> 81 AND USED(loc_cCursorMov)
            IF USED("cursor_4c_RemontaBop")
                USE IN cursor_4c_RemontaBop
            ENDIF

            loc_cSQL = "SELECT NDopes FROM SigCdOpe WHERE Dopes = " + ;
                EscaparSQL(EVALUATE(loc_cCursorMov + ".Dopes"))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RemontaBop")

            IF loc_nResultado >= 1 AND USED("cursor_4c_RemontaBop") AND ;
               !EOF("cursor_4c_RemontaBop") AND !EMPTY(cursor_4c_RemontaBop.NDopes)

                loc_cBop = PADL(ALLTRIM(STR(cursor_4c_RemontaBop.NDopes)), 4, "0") + ;
                           PADL(ALLTRIM(STR(EVALUATE(loc_cCursorMov + ".Numes"))), 6, "0")
            ENDIF

            IF USED("cursor_4c_RemontaBop")
                USE IN cursor_4c_RemontaBop
            ENDIF
        ENDIF

        THIS.this_cBop = loc_cBop

        RETURN loc_cBop
    ENDFUNC

    *====================================================================
    * OrdenarCursorImpressao - Reordena THIS.this_cCursorImpressao
    * (dbImpressao) antes da impressao, conforme THIS.this_nOrdem
    * (1 = Produto, Index On Cpros; qualquer outro = Sem Ordem,
    * Index On Recno()).
    * Legado: Imprime.Click, linhas 1390-1412.
    *====================================================================
    FUNCTION OrdenarCursorImpressao(par_nOrdem)
        LOCAL loc_cCursorImp, loc_lSucesso

        loc_cCursorImp = THIS.this_cCursorImpressao
        loc_lSucesso = .F.

        IF !USED(loc_cCursorImp)
            RETURN .F.
        ENDIF

        TRY
            SELECT (loc_cCursorImp)
            SET ORDER TO

            IF USED("cursor_4c_OrdenadoImpressao")
                USE IN cursor_4c_OrdenadoImpressao
            ENDIF

            IF par_nOrdem = 1
                INDEX ON Cpros TAG Cpros
            ELSE
                INDEX ON RECNO() TAG Registros
            ENDIF

            SELECT * FROM (loc_cCursorImp) WHERE 1 = 0 INTO CURSOR cursor_4c_OrdenadoImpressao READWRITE

            SELECT (loc_cCursorImp)
            SCAN
                SCATTER MEMVAR MEMO
                INSERT INTO cursor_4c_OrdenadoImpressao FROM MEMVAR
            ENDSCAN

            SELECT (loc_cCursorImp)
            ZAP

            SELECT cursor_4c_OrdenadoImpressao
            SCAN
                SCATTER MEMVAR MEMO
                INSERT INTO (loc_cCursorImp) FROM MEMVAR
            ENDSCAN

            USE IN cursor_4c_OrdenadoImpressao

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * PrepararImpressao - Orquestra a remontagem/ordenacao do cursor de
    * impressao antes de chamar ExecutarImpressao(). Retorna .F. (com
    * this_cMensagemErro preenchido) quando nao ha nenhuma etiqueta a
    * imprimir - o legado exibe "Nao Existem Etiquetas Para Impressao"
    * nesse caso e NAO chama SigOpEtq().
    * Legado: Imprime.Click, linhas 1378-1422.
    *====================================================================
    FUNCTION PrepararImpressao(par_nTipoEtiqueta, par_nOrdem)
        IF !USED(THIS.this_cCursorImpressao) OR RECCOUNT(THIS.this_cCursorImpressao) <= 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o Existem Etiquetas Para Impress" + CHR(227) + "o!!!"
            RETURN .F.
        ENDIF

        THIS.ObterBop(par_nTipoEtiqueta)

        IF par_nTipoEtiqueta <> 81
            IF !THIS.OrdenarCursorImpressao(par_nOrdem)
                RETURN .F.
            ENDIF
        ENDIF

        RETURN .T.
    ENDFUNC

    *====================================================================
    * ExecutarImpressao - Dispara a impressao de fato, delegando para a
    * funcao global legado SigOpEtq() (SIGFUNCS.PRG - ver cabecalho
    * deste arquivo). SigOpEtq nao foi portada (eh o driver de impressao
    * das etiquetas em si - ZPL/EPL/Allegro - e nao consta no acervo
    * extraido desta task); a chamada fica protegida por TRY/CATCH para
    * que a ausencia apareca como mensagem clara ao usuario, em vez de
    * travar o form ou falhar em silencio (CLAUDE.md regra #13/#27).
    *
    * Legado: Imprime.Click, linha 1414-1415.
    *====================================================================
    FUNCTION ExecutarImpressao(par_lImprimirPreco, par_lSeparador, par_nTipoEtiqueta, ;
            par_nTipoImpressora, par_nAjusteVertical, par_nAjusteHorizontal, ;
            par_nAjusteDensidade, par_lImprimirPesoTotal, par_cNomeImpressora, ;
            par_lOrigemEtiqueta140)

        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            SigOpEtq(gnConnHandle, par_lImprimirPreco, par_lSeparador, par_nTipoEtiqueta, ;
                par_nTipoImpressora, par_nAjusteVertical, par_nAjusteHorizontal, ;
                par_nAjusteDensidade, .F., .F., .F., par_cNomeImpressora, , , ;
                par_nAjusteDensidade, par_lImprimirPesoTotal, THIS.this_cBop, , , , , , , ;
                par_lOrigemEtiqueta140)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel imprimir as etiquetas: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Le a linha CORRENTE do cursor recebido e
    * espelha as colunas de parametro de impressao nas propriedades
    * deste BO. Sobrescreve BusinessBase.CarregarDoCursor (PUBLIC na
    * base, PUBLIC aqui - CLAUDE.md regra #51).
    *
    * Eh a FONTE UNICA de leitura dessas colunas. Os tres pontos do
    * legado que carregam a MESMA familia de colunas passam por aqui:
    *   CrSigCdPam  (Init, linhas 1169-1171) ...... impetis, ajverts, ajhorzs
    *   CrSigCdPac  (Init, linhas 1172-1181) ...... ajdens, ajvelos, etqseps
    *   SigCdmp da impressora escolhida no
    *     combobox (fCarregarImps, chamada por
    *     CarregarAjustesImpressora) .............. impetis, ajverts, ajhorzs,
    *                                               ajdens, ajvelos
    *   CrSigCdTpe  (tipo de etiqueta corrente) ... ntipos
    *
    * Cada coluna eh lida SO quando existe no cursor recebido - TYPE()
    * sobre "<alias>.<coluna>" devolve "U" quando a coluna nao esta la.
    * Isso eh necessario porque as tres origens tem subconjuntos
    * DIFERENTES: SigCdPam nao tem ajdens/ajvelos/etqseps e SigCdPac nao
    * tem impetis/ajverts/ajhorzs (conferido em docs\schema.sql, que eh
    * UTF-16 - ler com Get-Content -Raw, regra #14). Coluna ausente
    * deixa a propriedade como estava, que eh exatamente o que o legado
    * faz ao carregar um cursor depois do outro.
    *
    * As regras de valor sao do legado e ficam num lugar so:
    *   impetis = 0  -> "nao configurado", NAO troca o tipo de impressora
    *   ajdens  < 10 -> piso 10   (Iif(CrSigCdPac.AjDens  < 10, 10, ...))
    *   ajvelos <  1 -> piso 1    (Iif(CrSigCdPac.AjVelos <  1,  1, ...))
    *   etqseps = 1  -> separadora ligada (If Type(...) = [N] And ... = 1)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_nValor, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor)
            RETURN .F.
        ENDIF

        loc_cAlias = ALLTRIM(par_cAliasCursor)

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        IF EOF(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + ;
                "] sem registro posicionado."
            RETURN .F.
        ENDIF

        TRY
            *-- Tipo de impressora (1=Allegro, 2=Zebra ZPL, 3=Zebra EPL)
            IF TYPE(loc_cAlias + ".impetis") = "N"
                loc_nValor = NVL(EVALUATE(loc_cAlias + ".impetis"), 0)
                IF loc_nValor <> 0
                    THIS.this_nTipoImpressora = loc_nValor
                ENDIF
            ENDIF

            IF TYPE(loc_cAlias + ".ajverts") = "N"
                THIS.this_nAjusteVertical = NVL(EVALUATE(loc_cAlias + ".ajverts"), 0)
            ENDIF

            IF TYPE(loc_cAlias + ".ajhorzs") = "N"
                THIS.this_nAjusteHorizontal = NVL(EVALUATE(loc_cAlias + ".ajhorzs"), 0)
            ENDIF

            IF TYPE(loc_cAlias + ".ajdens") = "N"
                loc_nValor = NVL(EVALUATE(loc_cAlias + ".ajdens"), 0)
                THIS.this_nAjusteDensidade = IIF(loc_nValor < 10, 10, loc_nValor)
            ENDIF

            IF TYPE(loc_cAlias + ".ajvelos") = "N"
                loc_nValor = NVL(EVALUATE(loc_cAlias + ".ajvelos"), 0)
                THIS.this_nAjusteVelocidade = IIF(loc_nValor < 1, 1, loc_nValor)
            ENDIF

            IF TYPE(loc_cAlias + ".etqseps") = "N"
                THIS.this_lSeparador = (NVL(EVALUATE(loc_cAlias + ".etqseps"), 0) = 1)
            ENDIF

            *-- Tipo de etiqueta corrente - o legado guarda SigCdTpe.nTipos
            *-- no Tag do botao de Opt_Tipo e eh esse numero que vai para
            *-- vTipEtq no Imprime.Click.
            IF TYPE(loc_cAlias + ".ntipos") = "N"
                THIS.this_nTipoEtiqueta = NVL(EVALUATE(loc_cAlias + ".ntipos"), 0)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro("Erro ao carregar do cursor [" + loc_cAlias + "]:" + CHR(13) + ;
                loc_oErro.Message, "sigopetsBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir / Atualizar / ExecutarExclusao / ObterChavePrimaria /
    * RegistrarAuditoria - DECISAO DE PROJETO: ficam HERDADOS de
    * BusinessBase, sem override nesta classe.
    *
    * SIGOPETS eh o dialogo FILHO de configuracao da impressao de
    * etiquetas: ele nao tem tabela propria, nao tem chave primaria e
    * nao grava linha nenhuma no SQL Server. Conferido no dump legado
    * (tasks\task733\sigopets_form_codigo_fonte.txt), o acesso remoto
    * eh 100% SELECT e TODOS os alvos de escrita sao cursores LOCAIS:
    *
    *   Insert Into crImpre      (linha 1024) - Create Cursor na linha 1021
    *   Insert Into dbImpressao  (linhas 1245, 1276, 1308, 1339, 1370, 1410)
    *                            - cursor montado pelo FORM PAI (SigMvCab)
    *   Insert Into crOrdenado   (linha 1403) - Select ... Into Cursor
    *                              crOrdenado na linha 1398
    *
    * Nao existe TABLEUPDATE() nem .AddCursor() no dump - ou seja, nada
    * eh comitado de volta para o banco. Escrever INSERT/UPDATE aqui
    * significaria INVENTAR tabela e lista de colunas, o que a regra #22
    * do CLAUDE.md proibe (a lista vem do schema, nunca de adivinhacao).
    *
    * O comportamento herdado de BusinessBase ja eh o correto: Salvar()
    * e Excluir() recusam a operacao e reportam pelo ExibirFalha()
    * (regra #20), e ObterChavePrimaria()/RegistrarAuditoria() nao sao
    * alcancados porque nenhum caminho de gravacao existe.
    *
    * A gravacao de verdade desta tela eh FISICA, nao de banco: a funcao
    * global legado SigOpEtq() envia as etiquetas para a impressora a
    * partir do cursor dbImpressao - ver ExecutarImpressao() acima.
    *====================================================================

ENDDEFINE
