*==============================================================================
* SIGPRESTBO.PRG
* Business Object para o utilitario "Gerar Estrutura" (SIGPREST)
*
* Este form NAO edita nenhuma tabela do SQL Server: ele varre os arquivos
* .DBF locais da pasta basededados\ (Set Default To .\basededados\ no
* legado) e monta duas tabelas de metadados tambem locais:
*   ArqDBF.DBF - estrutura de campos de cada .DBF encontrado
*   ArqInd.DBF - indices (tags) de cada .DBF encontrado
* Por isso this_cTabela/this_cCampoChave (BusinessBase) permanecem vazios -
* nao ha chave primaria nem tabela principal em SQL Server para este
* utilitario, e os metodos Inserir/Atualizar/ExecutarExclusao herdados de
* BusinessBase nunca serao usados (o processamento e local, via ADIR/INDEX,
* nao via SQLEXEC).
*==============================================================================

DEFINE CLASS SIGPRESTBO AS BusinessBase

    *-- Opcoes de processamento (checkboxes GeraArquivos / Gera?ndices)
    this_lGeraArquivos     = .T.   && GeraArquivos.Value - gera ArqDBF.DBF (estrutura de campos)
    this_lGeraIndices      = .T.   && Gera?ndices.Value  - gera ArqInd.DBF (indices/tags)

    *-- Mensagem de status exibida em Mensagem1.Caption durante/apos o processamento
    this_cMensagem         = ""

    *-- Diretorio local onde os .DBF residem (Set Default To .\basededados\ no legado)
    this_cCaminhoBaseDados = ""

    *-- Contadores do ultimo processamento (uso informativo/depuracao)
    this_nTotalArquivos    = 0     && Quantidade de .DBF encontrados na ultima varredura
    this_nTotalCampos      = 0     && Total de linhas gravadas em ArqDBF
    this_nTotalIndices     = 0     && Total de linhas gravadas em ArqInd

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * Nao repassa nome de tabela para DODEFAULT(): este BO nao tem tabela
    * principal em SQL Server (ver cabecalho do arquivo).
    *--------------------------------------------------------------------------
    * O legado resolve a pasta com "Set Default To .\basededados\", isto eh,
    * relativo ao diretorio da aplicacao. Aqui a ancora eh gc_4c_CaminhoBase
    * (pasta de start\, fixada no config.prg a partir de SYS(16)) e NAO
    * SYS(5)+CURDIR(): o SET DEFAULT do proprio ExecutarProcessamento() muda o
    * diretorio corrente do processo, e medido no VFP9 (2026-09-28) essa
    * mudanca SOBREVIVE ao fechamento do form (SET DEFAULT eh global, nao eh
    * escopado por datasession). Lendo CURDIR(), a SEGUNDA abertura do dialogo
    * montaria "...\start\basededados\basededados\" e o utilitario nao acharia
    * arquivo nenhum. gc_4c_CaminhoBase nao se mexe, entao o caminho eh o mesmo
    * em toda abertura.
    PROCEDURE Init()
        DODEFAULT()

        IF TYPE("gc_4c_CaminhoBase") = "C" AND !EMPTY(gc_4c_CaminhoBase)
            THIS.this_cCaminhoBaseDados = ADDBS(gc_4c_CaminhoBase) + "basededados\"
        ELSE
            THIS.this_cCaminhoBaseDados = ADDBS(SYS(5) + CURDIR()) + "basededados\"
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao ha chave primaria em SQL Server para este BO: o
    * processamento eh 100% local (ADIR/AFIELDS/TAG sobre .DBF), sem tabela nem
    * registro corrente vindo de banco (ver cabecalho do arquivo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Este BO nao tem registro corrente carregado de cursor
    * de banco: o estado que ele mantem (contadores, mensagem) vem do proprio
    * processamento local de arquivos .DBF, nao de uma linha de SELECT. O
    * comportamento herdado de BusinessBase (retorna .T. sem alterar nada) ja
    * eh o correto para este utilitario.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarProcessamento - Ponto de entrada chamado pelo botao Gerar do Form.
    * Reproduz a sequencia de SIGPREST.OK.Click do legado: gera a Estrutura de
    * Arquivos (ArqDBF.DBF) quando this_lGeraArquivos, depois os Indices
    * (ArqInd.DBF) quando this_lGeraIndices - com o MESMO guard do legado (nao
    * deixa gerar indices sem a estrutura existir). Inserir()/Atualizar()/
    * ExecutarExclusao() herdados de BusinessBase nunca sao usados aqui: nao ha
    * tabela SQL Server a gravar (ver cabecalho do arquivo).
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarProcessamento()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cSafetyAntes, loc_cDirAntes, loc_oErro

        loc_lSucesso     = .T.
        loc_lProsseguir  = .T.
        loc_cSafetyAntes = SET("SAFETY")

        *-- SET DEFAULT eh GLOBAL e NAO volta sozinho: medido no VFP9
        *-- (2026-09-28), o diretorio corrente trocado aqui dentro continua
        *-- trocado depois do form ser destruido. O legado nao restaurava - e
        *-- podia nao restaurar, porque era um utilitario de manutencao rodado
        *-- isolado. No sistema novo o dialogo eh um item de menu como outro
        *-- qualquer: deixar o diretorio corrente apontando para basededados\
        *-- quebraria toda resolucao de caminho relativo do resto da aplicacao
        *-- (inclusive a deste proprio BO na abertura seguinte - ver Init).
        *-- Guardar/repor eh invisivel para o usuario: nenhum comportamento da
        *-- TELA depende do diretorio corrente APOS o processamento.
        loc_cDirAntes = FULLPATH(CURDIR())

        *-- this_lErroExibido eh reposto a CADA clique em Gerar: o dialogo nao
        *-- fecha depois do processamento (o legado reabilita OK/Cancela e
        *-- espera novo clique), entao uma flag deixada ligada por uma falha
        *-- anterior faria o Form ENGOLIR a mensagem da proxima. Mesmo par de
        *-- resets que BusinessBase.Salvar()/Excluir() fazem na entrada.
        THIS.this_cMensagemErro  = ""
        THIS.this_lErroExibido   = .F.
        THIS.this_cMensagem      = ""
        THIS.this_nTotalArquivos = 0
        THIS.this_nTotalCampos   = 0
        THIS.this_nTotalIndices  = 0

        SET SAFETY OFF

        TRY
            CLOSE TABLES ALL
            SET DEFAULT TO (THIS.this_cCaminhoBaseDados)

            IF THIS.this_lGeraArquivos
                IF !THIS.GerarEstruturaArquivos()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            CLOSE TABLES ALL

            IF THIS.this_lGeraIndices AND !FILE("ArqDBF.DBF")
                THIS.this_cMensagem     = "Processamento Interrompido."
                THIS.this_cMensagemErro = THIS.ObterMensagemIndicesSemEstrutura()
                *-- A flag descreve a mensagem CORRENTE: esta acabou de
                *-- substituir a anterior e ainda NAO foi exibida, entao repor
                *-- .F. Sem isso, uma excecao na geracao da estrutura (que ja
                *-- marcou a flag) faria este aviso - outro fato, tambem
                *-- verdadeiro - ser engolido pelo guard do BtnOKClick.
                THIS.this_lErroExibido = .F.
                loc_lSucesso    = .F.
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND THIS.this_lGeraIndices
                IF !THIS.GerarIndicesArquivos()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            CLOSE TABLES ALL

            IF loc_lSucesso
                THIS.this_cMensagem = "Processamento Finalizado."
                *-- So cacheia csLogoTipo no caminho de sucesso - o legado
                *-- NAO faz isso quando cai no guard "indices sem estrutura"
                *-- (Return antecipado antes deste ponto no SIGPREST.OK.Click).
                THIS.CarregarLogoTipo()
            ELSE
                *-- Falha em GerarEstruturaArquivos/GerarIndicesArquivos: os
                *-- CATCH daqueles metodos preenchem this_cMensagemErro e ja
                *-- exibiram o dialogo, mas NAO tocam this_cMensagem - sem este
                *-- ELSE o rodape da tela ficava EM BRANCO depois de um erro
                *-- (medido em 2026-09-28), e o legado so tem dois estados
                *-- finais: "Processamento Finalizado." ou "Processamento
                *-- Interrompido.". O guard "indices sem estrutura" nao passa
                *-- por aqui: ele ja gravou a sua propria mensagem, identica.
                IF EMPTY(THIS.this_cMensagem)
                    THIS.this_cMensagem = "Processamento Interrompido."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            THIS.this_cMensagem     = "Processamento Interrompido."
            MsgErro(loc_oErro.Message, "Erro ao Gerar Estrutura")
            *-- Regra #20: exibiu, entao MARCA - senao o BtnOKClick do Form
            *-- repete o mesmo texto num segundo dialogo.
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        IF UPPER(loc_cSafetyAntes) = "ON"
            SET SAFETY ON
        ELSE
            SET SAFETY OFF
        ENDIF

        *-- Repoe o diretorio corrente SEMPRE (sucesso, guard ou excecao) - por
        *-- isso fica depois do ENDTRY, nao dentro dele. Sem TRY/CATCH proprio
        *-- de proposito: o guard DIRECTORY() ja cobre o caso previsivel (pasta
        *-- removida), e qualquer outra falha aqui DEVE aparecer - o TRY do
        *-- BtnOKClick a exibe com linha e procedure. CATCH vazio so esconderia
        *-- (CLAUDE.md #9).
        IF !EMPTY(loc_cDirAntes) AND DIRECTORY(loc_cDirAntes)
            SET DEFAULT TO (loc_cDirAntes)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemIndicesSemEstrutura - Texto EXATO do Messagebox do legado
    * (SIGPREST.OK.Click): "Antes de gerar os indices, e necessario que seja
    * gerada a Estrutura de Arquivos...". Fica num metodo unico porque a MESMA
    * condicao eh checada em dois pontos da sequencia que o legado roda toda
    * dentro de OK.Click: no pre-voo do Form (usuario pede indices SEM pedir a
    * estrutura, e ArqDBF.DBF nao existe) e logo apos gerar a estrutura (aqui,
    * quando a geracao nao produziu ArqDBF.DBF). Uma frase so, num lugar so.
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemIndicesSemEstrutura()
        RETURN "Antes de gerar os " + CHR(237) + "ndices, " + CHR(233) + ;
               " necess" + CHR(225) + "rio que seja gerada a Estrutura de Arquivos..."
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarEstruturaArquivos - Varre todos os .DBF de this_cCaminhoBaseDados e
    * grava, em ArqDBF.DBF (tabela local FREE), uma linha por CAMPO de cada
    * arquivo (nome do arquivo, nome do "banco" a que pertencia, e a estrutura
    * completa devolvida por AFIELDS()). Espelha SIGPREST.OK.Click do legado
    * (bloco "If ThisForm.GeraArquivos.Value").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarEstruturaArquivos()
        LOCAL loc_lSucesso, loc_nArq, loc_nGeraArq, loc_cArquivo, ;
              loc_nCampos, loc_nCCampos, loc_cDbc, loc_oBarra, loc_oErro

        *-- LOCAL ARRAY, nao LOCAL simples: declarada com LOCAL a variavel nasce
        *-- LOGICA (.F.), e ADIR()/AFIELDS() recusam o destino com
        *-- "'LOC_AARQ' is not an array." - erro de RUNTIME, o .prg compila
        *-- limpo. O legado funcionava por acidente: laArq/laCampos NAO estao na
        *-- lista "Local" dele, entao ADIR/AFIELDS as criavam como array.
        *-- Medido em 2026-09-28: sem esta linha, GerarEstruturaArquivos e
        *-- GerarIndicesArquivos falhavam SEMPRE (ArqDBF.DBF saia vazio e
        *-- ArqInd.DBF nem era criado). O [1] eh so o tamanho inicial - ADIR e
        *-- AFIELDS redimensionam.
        LOCAL ARRAY loc_aArq[1], loc_aCampos[1]

        loc_lSucesso = .T.

        TRY
            CREATE TABLE ArqDBF FREE (Arquivos C(20), Dbcs C(50), Campos C(20), Tipos C(1), Tamanhos N(3), ;
                Fracaos N(2), C_05s L, C_06s L, C_07s C(20), C_08s C(20), ;
                C_09s C(20), C_10s C(20), C_11s C(20), C_12s C(20), ;
                C_13s C(20), C_14s C(20), C_15s C(20), C_16s C(20))

            INDEX ON Arquivos + Campos TAG ArqCamp

            loc_nArq = ADIR(loc_aArq, "*.DBF")
            =ASORT(loc_aArq)

            loc_oBarra = CREATEOBJECT("fwprogressbar", "Processando Estrutura de Arquivos.", loc_nArq)
            loc_oBarra.Titulo.FontBold = .T.
            loc_oBarra.Show()

            FOR loc_nGeraArq = 1 TO loc_nArq

                loc_cArquivo = loc_aArq(loc_nGeraArq, 1)

                loc_oBarra.Update(.T.)
                loc_oBarra.SubTitulo.Caption = "Processando Arquivo : " + ALLTRIM(loc_cArquivo)

                IF INLIST(ALLTRIM(UPPER(loc_cArquivo)), "ARQDBF.DBF", "ARQIND.DBF", "FOXUSER.DBF")
                    LOOP
                ENDIF

                USE (loc_cArquivo) IN 0 ALIAS TmpArquivo AGAIN

                SELECT TmpArquivo
                loc_cDbc    = ALLTRIM(JUSTFNAME(CURSORGETPROP("DataBase")))
                loc_nCampos = AFIELDS(loc_aCampos)

                FOR loc_nCCampos = 1 TO loc_nCampos

                    IF loc_nCCampos = 1 AND EMPTY(loc_aCampos(loc_nCCampos, 12))
                        loc_aCampos(loc_nCCampos, 12) = STRTRAN(loc_cArquivo, ".DBF", "")
                    ENDIF

                    INSERT INTO ArqDBF (Arquivos, Dbcs, Campos, Tipos, Tamanhos, Fracaos, C_05s, C_06s, C_07s, ;
                            C_08s, C_09s, C_10s, C_11s, C_12s, C_13s, C_14s, C_15s, C_16s) ;
                        VALUES (loc_cArquivo, loc_cDbc, ;
                            loc_aCampos(loc_nCCampos, 1), loc_aCampos(loc_nCCampos, 2), ;
                            loc_aCampos(loc_nCCampos, 3), loc_aCampos(loc_nCCampos, 4), ;
                            loc_aCampos(loc_nCCampos, 5), loc_aCampos(loc_nCCampos, 6), ;
                            loc_aCampos(loc_nCCampos, 7), loc_aCampos(loc_nCCampos, 8), ;
                            loc_aCampos(loc_nCCampos, 9), loc_aCampos(loc_nCCampos, 10), ;
                            loc_aCampos(loc_nCCampos, 11), loc_aCampos(loc_nCCampos, 12), ;
                            loc_aCampos(loc_nCCampos, 13), loc_aCampos(loc_nCCampos, 14), ;
                            loc_aCampos(loc_nCCampos, 15), loc_aCampos(loc_nCCampos, 16))

                    THIS.this_nTotalCampos = THIS.this_nTotalCampos + 1
                ENDFOR

                USE IN TmpArquivo
                THIS.this_nTotalArquivos = THIS.this_nTotalArquivos + 1
            ENDFOR

            loc_oBarra.SubTitulo.Caption = "Finalizando Processo de Estrutura."
            loc_oBarra.Complete(.T.)

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Gerar Estrutura de Arquivos")
            *-- Regra #20: exibiu, entao MARCA (ver BtnOKClick do Form).
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarIndicesArquivos - Varre todos os .DBF de this_cCaminhoBaseDados e
    * grava, em ArqInd.DBF (tabela local FREE), uma linha por TAG de indice de
    * cada arquivo (nome do arquivo, tag, expressao de chave e filtro). Espelha
    * SIGPREST.OK.Click do legado (bloco "If ThisForm.Gera?ndices.Value").
    * PRE-REQUISITO (garantido por ExecutarProcessamento): ArqDBF.DBF ja existe.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarIndicesArquivos()
        *-- LOCAL ARRAY obrigatorio para o destino do ADIR - ver o comentario
        *-- em GerarEstruturaArquivos.
        LOCAL ARRAY loc_aArq[1]
        LOCAL loc_lSucesso, loc_nArq, loc_nGeraInd, loc_cArquivo, ;
              loc_nKey, loc_cChave, loc_cFiltro, loc_cTag, loc_oBarra, loc_oErro

        loc_lSucesso = .T.

        TRY
            SELECT 0
            USE ArqDBF ORDER ArqCamp

            loc_nArq = ADIR(loc_aArq, "*.DBF")
            =ASORT(loc_aArq)

            IF FILE("ArqInd.DBF")
                DELETE FILE ArqInd.DBF
                DELETE FILE ArqInd.CDX
            ENDIF

            CREATE TABLE ArqInd FREE (Arquivos C(20), Tags C(15), Indices C(240), Filtros C(240), Indexs L, C_12s C(20))
            INDEX ON Arquivos + Tags TAG Arquivos
            INDEX ON Arquivos TAG Temp UNIQUE

            loc_oBarra = CREATEOBJECT("fwprogressbar", "Processando " + CHR(205) + "ndices de Arquivos.", loc_nArq)
            loc_oBarra.Titulo.FontBold = .T.
            loc_oBarra.Show()

            FOR loc_nGeraInd = 1 TO loc_nArq

                loc_cArquivo = loc_aArq(loc_nGeraInd, 1)

                loc_oBarra.Update(.T.)
                loc_oBarra.SubTitulo.Caption = "Processando Arquivo : " + ALLTRIM(loc_cArquivo)

                IF INLIST(ALLTRIM(UPPER(loc_cArquivo)), "ARQDBF.DBF", "ARQIND.DBF", "FOXUSER.DBF")
                    LOOP
                ENDIF

                SELECT 0
                USE (loc_cArquivo) ALIAS TmpArquivo AGAIN

                loc_nKey = 1
                DO WHILE !EMPTY(TAG(loc_nKey))
                    loc_cChave  = KEY(loc_nKey)
                    loc_cFiltro = SYS(2021, loc_nKey)
                    loc_cTag    = TAG(loc_nKey)

                    INSERT INTO ArqInd (Arquivos, Tags, Indices, Filtros) ;
                        VALUES (loc_cArquivo, loc_cTag, loc_cChave, loc_cFiltro)

                    THIS.this_nTotalIndices = THIS.this_nTotalIndices + 1

                    SELECT TmpArquivo
                    loc_nKey = loc_nKey + 1
                ENDDO

                USE
            ENDFOR

            loc_oBarra.SubTitulo.Caption = "Finalizando Processo de " + CHR(205) + "ndice."
            loc_oBarra.Complete(.T.)

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Gerar " + CHR(205) + "ndices de Arquivos")
            *-- Regra #20: exibiu, entao MARCA (ver BtnOKClick do Form).
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLogoTipo - Espelha o bloco final de SIGPREST.OK.Click e de
    * SIGPREST.Cancela.Click no legado:
    *   If Not Used('csLogoTipo')
    *       Select Logos as gnLogos From SigCdPam Into Cursor csLogoTipo
    *       Use In SigCdPam
    *   EndIf
    * csLogoTipo eh cacheado uma unica vez por DATASESSION. O form declara
    * DataSession = 2 (privada), transcrito do SCX legado, entao este cursor
    * vive na sessao do dialogo e morre com ele - exatamente como no legado,
    * que tambem tem DataSession = 2. A alternativa (herdar a sessao corrente
    * para o cursor ficar visivel ao resto do sistema) foi medida e DESCARTADA:
    * o CLOSE TABLES ALL de ExecutarProcessamento() passaria a fechar todos os
    * cursores da aplicacao - ver o comentario da property DataSession em
    * FormSIGPREST.prg. PUBLIC (sem PROTECTED):
    * chamado tanto pelo Form (BtnOKClick/BtnCancelaClick) quanto internamente
    * por ExecutarProcessamento() (regra #8 exige THIS. nesse segundo caso).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLogoTipo()
        LOCAL loc_nResultado, loc_oErro

        TRY
            IF !USED("csLogoTipo")
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT Logos AS gnLogos FROM SigCdPam", ;
                        "cursor_4c_LogoTipo_Temp")

                    IF loc_nResultado > 0
                        SELECT * FROM cursor_4c_LogoTipo_Temp INTO CURSOR csLogoTipo READWRITE
                    ENDIF

                    IF USED("cursor_4c_LogoTipo_Temp")
                        USE IN cursor_4c_LogoTipo_Temp
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SIGPRESTBO.CarregarLogoTipo")
        ENDTRY

        RETURN .T.
    ENDPROC

ENDDEFINE
