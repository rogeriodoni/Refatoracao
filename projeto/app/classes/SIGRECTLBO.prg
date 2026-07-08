*==============================================================================
* SIGRECTLBO.PRG
* Business Object para Relatorio Mensal de Acessos (SIGRECTL)
* Herda de RelatorioBase
*
* Tabelas: SigSyCtl, SigCdUsu, SigCdCrg, SigCdEmp, SigCdPam
* Cursor resultado: crDados
*==============================================================================

*-- Converte segundos para HH:MM (equivalente a fMtoH do legado com parametro em minutos)
*-- VFP subtrai dois DATETIME em segundos, entao recebe segundos diretamente
FUNCTION fMtoH_Seg(par_nSegundos)
    LOCAL loc_nSeg, loc_nHoras, loc_nMinutos
    loc_nSeg     = MAX(0, par_nSegundos)
    loc_nHoras   = INT(loc_nSeg / 3600)
    loc_nMinutos = MOD(INT(loc_nSeg / 60), 60)
    RETURN LTRIM(STR(loc_nHoras, 4)) + ":" + RIGHT("0" + LTRIM(STR(loc_nMinutos, 2)), 2)
ENDFUNC

DEFINE CLASS SIGRECTLBO AS RelatorioBase

    *-- Filtros do relatorio
    this_nMes           = 0     && Mes (1-12)
    this_nAno           = 0     && Ano (2000-2099)
    this_lImpTempo      = 0     && Imprimir Tempo de Utilizacao (0=Nao / 1=Sim)

    *-- Cursor resultado para o REPORT FORM
    this_cCursorDados   = "crDados"

    *-- Configuracao do relatorio
    this_cFRXPath       = ""
    this_cMensagemErro  = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO com mes/ano correntes e caminho do FRX
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_nMes      = MONTH(DATE())
            THIS.this_nAno      = YEAR(DATE())
            THIS.this_lImpTempo = 0

            IF DODEFAULT()
                IF TYPE("gc_4c_CaminhoReports") = "U"
                    gc_4c_CaminhoReports = ""
                ENDIF
                THIS.this_cFRXPath = gc_4c_CaminhoReports + "SigReCtl.frx"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursores crCabecalho e crDados para o REPORT FORM
    *
    * Logica original (processamento):
    *   1. Calcula periodo (primeiro e ultimo dia do mes/ano informados)
    *   2. Busca registros de acesso em SigSyCtl + SigCdUsu + SigCdCrg
    *   3. Clamp das datas Lic_Data/Lic_Vals ao periodo do mes
    *   4. Agrega por usuario calculando soma dos intervalos (segundos)
    *   5. Monta crDados com: cabecalho UTILIZACAO, linhas de usuario, total
    *   6. Busca usuarios ativos (SigCdUsu) e acrescenta ao crDados
    *   7. Busca empresas ativas (SigCdEmp) e acrescenta ao crDados
    *   8. Busca licencas (SigCdPam) e acrescenta ao crDados
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        LOCAL loc_nMes, loc_nAno, loc_lTpo
        LOCAL loc_dIni, loc_dFim, loc_tIni, loc_tFim
        LOCAL loc_cSQL, loc_nResult, loc_cMes, loc_cAno, loc_cSub, loc_cLic
        LOCAL loc_nTotalSeg, loc_cTempoTotal, loc_cQtde

        loc_lSucesso = .F.

        TRY
            DO WHILE .T.

                *-- Extrair filtros do BO
                loc_nMes = THIS.this_nMes
                loc_nAno = THIS.this_nAno
                loc_lTpo = (THIS.this_lImpTempo = 1)

                *-- Calcular primeiro e ultimo dia do mes
                loc_cMes = ALLTRIM(STR(loc_nMes, 2))
                loc_cAno = ALLTRIM(STR(loc_nAno, 4))
                loc_dIni = DATE(loc_nAno, loc_nMes, 1)
                IF loc_nMes >= 12
                    loc_dFim = DATE(loc_nAno + 1, 1, 1) - 1
                ELSE
                    loc_dFim = DATE(loc_nAno, loc_nMes + 1, 1) - 1
                ENDIF
                loc_tIni = CTOT(DTOC(loc_dIni) + " 00:00:00")
                loc_tFim = CTOT(DTOC(loc_dFim) + " 23:59:59")

                *-- Subtitulo do relatorio
                loc_cSub = "M" + CHR(234) + "s : " + loc_cMes + " / Ano : " + loc_cAno

                *-- Cursor de cabecalho (criado pelo BO, lido pelo FRX)
                IF USED("crCabecalho")
                    USE IN crCabecalho
                ENDIF
                IF USED("crDados1")
                    USE IN crDados1
                ENDIF
                IF USED("crDados2")
                    USE IN crDados2
                ENDIF
                IF USED("crDados")
                    USE IN crDados
                ENDIF
                IF USED("crDados4")
                    USE IN crDados4
                ENDIF
                IF USED("crDados5")
                    USE IN crDados5
                ENDIF

                CREATE CURSOR crCabecalho (Subtitulos C(250), Empresa C(250))
                INSERT INTO crCabecalho (Subtitulos) VALUES (loc_cSub)

                *--------------------------------------------------------------
                * Query 1: Registros de login do mes/ano (SigSyCtl + usuarios)
                *--------------------------------------------------------------
                loc_cSQL = "Select Left(a.Lic_Usua, 10) as Usuario, b.NComps as Nomes, " + ;
                           "b.ccargs as Cargo, isnull(c.dcargs,space(20)) as descricao, " + ;
                           "a.Lic_Data, a.Lic_Vals " + ;
                           "From SigSyCtl a " + ;
                           "Left Join SigCdUsu b On Left(a.Lic_Usua, 10) = b.Usuarios " + ;
                           "Left Join SigCdCrg c on b.ccargs = c.ccargs " + ;
                           "Where (Month(a.Lic_Data) = " + TRANSFORM(loc_nMes) + ;
                           " And Year(a.Lic_Data) = " + TRANSFORM(loc_nAno) + ") Or " + ;
                           "(Month(a.Lic_Vals) = " + TRANSFORM(loc_nMes) + ;
                           " And Year(a.Lic_Vals) = " + TRANSFORM(loc_nAno) + ") And " + ;
                           "Not b.Usuarios = '4CONTROL' " + ;
                           "Order By 1"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crDados1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crDados1)"
                    MsgErro(THIS.this_cMensagemErro, "PrepararDados")
                    EXIT
                ENDIF

                *-- Clamp de datas ao periodo do mes
                UPDATE crDados1 SET Lic_Data = loc_tIni WHERE Lic_Data < loc_tIni
                UPDATE crDados1 SET Lic_Vals = loc_tFim WHERE Lic_Vals > loc_tFim

                *-- Agregar por usuario: SUM de intervalos em segundos
                SELECT SUM(Lic_Vals - Lic_Data) as Minutos, ;
                       Usuario, Nomes, Cargo, Descricao ;
                  FROM crDados1 ;
                 GROUP BY Usuario, Nomes, Cargo, Descricao ;
                  INTO CURSOR crDados2 READWRITE

                *-- Pre-computar total de segundos para a linha de TOTAL
                IF USED("cursor_4c_SumTmp")
                    USE IN cursor_4c_SumTmp
                ENDIF
                loc_nTotalSeg  = 0
                loc_cTempoTotal = PADL("", 10)
                loc_cQtde = "QUANTIDADE : " + ALLTRIM(STR(RECCOUNT("crDados2"), 10))

                SELECT SUM(Minutos) as TotalSeg FROM crDados2 ;
                  INTO CURSOR cursor_4c_SumTmp READWRITE
                IF USED("cursor_4c_SumTmp") AND RECCOUNT("cursor_4c_SumTmp") > 0
                    GO TOP IN cursor_4c_SumTmp
                    loc_nTotalSeg = NVL(cursor_4c_SumTmp.TotalSeg, 0)
                    USE IN cursor_4c_SumTmp
                ENDIF
                loc_cTempoTotal = PADL(IIF(loc_lTpo, fMtoH_Seg(loc_nTotalSeg), ""), 10)

                *-- Cursor final com cabecalho, dados e linha de total
                SELECT "*" as Negrito, SPACE(10) as Usuario, ;
                       PADR("UTILIZA" + CHR(199) + CHR(195) + "O DOS USU" + CHR(193) + "RIOS", 60) as Nomes, ;
                       SPACE(10) as Tempo, SPACE(10) as Cargo, SPACE(20) as Descricao ;
                  FROM crDados2 ;
                 WHERE RECNO() = 1 ;
                 UNION ALL ;
                SELECT " " as Negrito, Usuario, PADR(Nomes, 60) as Nomes, ;
                       PADL(IIF(loc_lTpo, fMtoH_Seg(Minutos), ""), 10) as Tempo, ;
                       Cargo, Descricao ;
                  FROM crDados2 ;
                 UNION ALL ;
                SELECT "*" as Negrito, REPLICATE(CHR(254), 10) as Usuario, ;
                       PADR(m.loc_cQtde, 60) as Nomes, ;
                       loc_cTempoTotal as loc_cTempoTotal, ;
                       SPACE(10) as Cargo, SPACE(20) as Descricao ;
                  FROM crDados2 ;
                 GROUP BY 1, 2 ;
                  INTO CURSOR crDados READWRITE ;
                 ORDER BY 2, 3

                UPDATE crDados SET Usuario = "TOTAL" ;
                  WHERE Usuario = REPLICATE(CHR(254), 10)

                *--------------------------------------------------------------
                * Query 2: Usuarios ativos (SigCdUsu)
                *--------------------------------------------------------------
                loc_cSQL = "Select a.Usuarios as Usuario, a.NComps as Nomes, " + ;
                           "a.ccargs as Cargo, isnull(c.dcargs,space(20)) as descricao " + ;
                           "From SigCdUsu a " + ;
                           "Left Join SigCdCrg c on a.ccargs = c.ccargs " + ;
                           "Where Not a.CAtivos = 'N' And " + ;
                           "Not a.Usuarios = '4CONTROL' " + ;
                           "Order By 1"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crDados4")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crDados4)"
                    MsgErro(THIS.this_cMensagemErro, "PrepararDados")
                    EXIT
                ENDIF

                *-- Insere secao de usuarios ativos no cursor final
                INSERT INTO crDados (Usuario) VALUES ("")
                INSERT INTO crDados (Negrito, Nomes) ;
                       VALUES ("*", "USU" + CHR(193) + "RIOS ATIVOS")

                SELECT crDados4
                SCAN
                    INSERT INTO crDados (Usuario, Nomes, Cargo, Descricao) ;
                           VALUES (crDados4.Usuario, crDados4.Nomes, ;
                                   crDados4.Cargo, crDados4.Descricao)
                ENDSCAN
                INSERT INTO crDados (Negrito, Usuario, Nomes) ;
                       VALUES ("*", "TOTAL", ;
                               "USUARIOS ATIVOS : " + ALLTRIM(STR(RECCOUNT("crDados4"), 10)))

                *--------------------------------------------------------------
                * Query 3: Empresas ativas (SigCdEmp)
                *--------------------------------------------------------------
                loc_cSQL = "Select CEmps, Cgcs, Razas From SigCdEmp " + ;
                           "Where Ativas = 1 Order By CEmps"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crDados5")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crDados5)"
                    MsgErro(THIS.this_cMensagemErro, "PrepararDados")
                    EXIT
                ENDIF

                *-- Insere secao de empresas ativas no cursor final
                INSERT INTO crDados (Usuario) VALUES ("")
                INSERT INTO crDados (Negrito, Nomes) ;
                       VALUES ("*", "EMPRESAS ATIVAS")

                SELECT crDados5
                SCAN
                    INSERT INTO crDados (Usuario, Nomes) ;
                           VALUES (crDados5.CEmps, ;
                                   IIF(EMPTY(ALLTRIM(crDados5.Cgcs)), "", ;
                                       ALLTRIM(crDados5.Cgcs) + " / ") + ;
                                   crDados5.Razas)
                ENDSCAN
                INSERT INTO crDados (Negrito, Usuario, Nomes) ;
                       VALUES ("*", crDados5.CEmps, ;
                               "EMPRESAS ATIVAS : " + ALLTRIM(STR(RECCOUNT("crDados5"), 10)))

                *--------------------------------------------------------------
                * Query 4: Numero de licencas (SigCdPam)
                *--------------------------------------------------------------
                IF USED("crNumLics")
                    USE IN crNumLics
                ENDIF

                loc_cSQL = "Select CNumLics, DirLivrosV From SigCdPam"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crNumLics")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crNumLics)"
                    MsgErro(THIS.this_cMensagemErro, "PrepararDados")
                    EXIT
                ENDIF

                GO TOP IN crNumLics
                loc_cLic = ALLTRIM(TRANSFORM(crNumLics.CNumLics, ""))
                UPDATE crCabecalho SET Empresa = crNumLics.DirLivrosV
                USE IN crNumLics

                *-- Insere secao de licencas no cursor final
                INSERT INTO crDados (Usuario) VALUES ("")
                INSERT INTO crDados (Negrito, Usuario, Nomes) ;
                       VALUES ("*", "TOTAL", ;
                               "LICEN" + CHR(199) + "AS ATIVAS : " + loc_cLic)

                SELECT crDados
                GO TOP IN crDados

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel a relatorio
    *
    * RelatorioBase nao mantem registro corrente carregado de cursor.
    * Os filtros (this_nMes, this_nAno, this_lImpTempo) sao alimentados
    * diretamente pelo Form via FormParaRelatorio(). PrepararDados() monta
    * o cursor crDados dinamicamente a partir desses filtros.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF TYPE("&par_cAliasCursor..nMes") = "N"
                    THIS.this_nMes = NVL(EVALUATE(par_cAliasCursor + ".nMes"), MONTH(DATE()))
                ENDIF
                IF TYPE("&par_cAliasCursor..nAno") = "N"
                    THIS.this_nAno = NVL(EVALUATE(par_cAliasCursor + ".nAno"), YEAR(DATE()))
                ENDIF
                IF TYPE("&par_cAliasCursor..lImpTempo") = "L"
                    THIS.this_lImpTempo = IIF(EVALUATE(par_cAliasCursor + ".lImpTempo"), 1, 0)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                                          IIF(EMPTY(par_cAliasCursor), "<vazio>", par_cAliasCursor)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel a relatorio (mantido por compatibilidade de API)
    *
    * Relatorios nao gravam registros em banco. Para gerar saida do relatorio,
    * usar Imprimir() (impressora) ou Visualizar() (preview). Este metodo
    * existe para compatibilidade com chamadas genericas da camada Form.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o INSERIR n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rio. " + ;
                                  "Use Imprimir() ou Visualizar()."
        THIS.RegistrarAuditoria("INSERIR_RELATORIO")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel a relatorio (mantido por compatibilidade de API)
    *
    * Relatorios nao atualizam registros em banco. Os filtros do BO sao
    * volateis (resetam a cada execucao). Este metodo existe para
    * compatibilidade com chamadas genericas da camada Form.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o ATUALIZAR n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rio. " + ;
                                  "Use Imprimir() ou Visualizar()."
        THIS.RegistrarAuditoria("ATUALIZAR_RELATORIO")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora com dialogo de selecao
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) NOCONSOLE TO PRINTER PROMPT
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) NOCONSOLE PREVIEW
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Relatorios nao registram auditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("crCabecalho")
            USE IN crCabecalho
        ENDIF
        IF USED("crDados")
            USE IN crDados
        ENDIF
        IF USED("crDados1")
            USE IN crDados1
        ENDIF
        IF USED("crDados2")
            USE IN crDados2
        ENDIF
        IF USED("crDados4")
            USE IN crDados4
        ENDIF
        IF USED("crDados5")
            USE IN crDados5
        ENDIF
        IF USED("cursor_4c_SumTmp")
            USE IN cursor_4c_SumTmp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
