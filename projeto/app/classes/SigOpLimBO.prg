*==============================================================================
* SigOpLimBO.prg - Business Object para SigOpLim (Limite de Descontos)
*
* Form OPERACIONAL do tipo DIALOGO DE AUTORIZACAO ("Limite Ultrapassado...").
* Nao eh cadastro: nao inclui, nao altera e nao exclui registro proprio. O
* legado (SIGOPLIM.SCX) eh chamado por outra tela quando o operador tenta um
* desconto/acrescimo acima do limite do cargo dele, e devolve em ThisForm.zsenha
* a credencial de quem liberou (ou .F. quando a liberacao foi negada).
*
* Fluxos do legado, selecionados por this_cTipo:
*   "D" - Desconto  : confere SigCdCrg.Limdescs / DescPors
*   "A" - Acrescimo : confere SigCdCrg.Limacres / AcrePors  (ramo Other do Do Case)
*   "X" - Limite    : confere SigCdCrg.Limites = "S" (ignora valor/percentual)
*   "L" - Senha livre: ignora usuario/cargo e consome senha pre-cadastrada
*                      em SigPrSnd (marcando-a como utilizada)
*
* Tabelas lidas (nomes e colunas conferidos em docs/schema.sql):
*   SigCdUsu  usuarios, senhas, ccargs, cativos, limdescs char(1)
*   SigCdCrg  ccargs, limdescs/descpors/limacres/acrepors numeric, nivels, limites
*   SigPrSnd  senhads, empdopnums, cidchaves          (senha livre)
*   SigCdFs   codigos, descrs, tipos, chkbins, blqtabds (motivos)
*   SigCdFsI  codigos, emps                            (motivo por empresa)
*   SigCdClc  codigos, cidchaves                       (classificacao da conta)
*   SigCdCmt  codigos, fkchaves, tipos                 (motivos da classificacao)
*
* ATENCAO - colunas homonimas de tipos DIFERENTES (regra #22 do CLAUDE.md):
*   SigCdUsu.limdescs eh char(1)        -> this_cLimDescs  (teste = "S")
*   SigCdCrg.limdescs eh numeric(11,2)  -> entra so no WHERE da consulta
* O "If limdescs = 'S'" do legado roda sobre TmpUsu (Select a.* de SigCdUsu),
* portanto eh a coluna CHAR. Trocar uma pela outra quebra a comparacao.
*
* Unica gravacao do fluxo: UPDATE SigPrSnd SET EmpDopNums (marca senha livre
* como consumida). Nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao() -
* o comportamento padrao herdado de BusinessBase ja eh o correto.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpLimBO AS BusinessBase

    *==========================================================================
    * Parametros recebidos do form chamador
    * Legado: Parameter totite, valor, pvalor, tipo, poform, Pcx, pMotivo,
    *                   pClaConta, plCheckBin, plCheckTabD, pcEmpresa
    * (poform/Pcx - form pai e data manager - ficam no Form, nao no BO: o
    *  acesso a dados aqui usa gnConnHandle)
    *==========================================================================
    this_nTotIte   = 0      && totite  - Total de itens da operacao
    this_nValDesc  = 0      && valor   - Valor do desconto/acrescimo pedido
    this_nPDescs   = 0      && pvalor  - Percentual do desconto/acrescimo pedido
    this_cTipo     = "D"    && tipo    - "D"/"C"/"X"/"L" (default "D" como no legado)
    this_lMotivo   = .F.    && pMotivo - .T. quando a tela exige informar motivo
    this_cClaConta = " "    && pClaConta - Classificacao da conta (SigCdClc.codigos)
    this_lCheckBin = .F.    && plCheckBin  - .T. filtra motivos com SigCdFs.ChkBins  <> 1
    this_lCheckTbd = .F.    && plCheckTabD - .T. filtra motivos com SigCdFs.BlqTabDs <> 1
    this_cEmps     = ""     && pcEmpresa - Empresa (SigCdFsI.emps); default = empresa logada

    *==========================================================================
    * Estado derivado (calculado a partir dos parametros)
    *==========================================================================
    *-- somotivo do legado: ( totite + valor + pvalor = 0 ) And ( Tipo <> "X" )
    *-- Quando .T. a tela pede SOMENTE o motivo, sem usuario/senha.
    this_lSoMotivo = .F.

    *==========================================================================
    * Resultado da autorizacao (equivale a ThisForm.zsenha do legado)
    *
    * No legado zsenha eh variante: recebe .F. quando negado e uma STRING
    * quando liberado. Aqui a decisao fica em this_lAutorizado (logico) e o
    * conteudo em this_cZSenha (caractere), para nao haver property de tipo
    * ambiguo; o Form remonta o valor de retorno do dialogo.
    *
    * Conteudo por tipo, conforme o legado:
    *   "X" -> usuario digitado
    *   "L" -> usuario logado (Usuar)
    *   so motivo -> Space(10) + codigo do motivo
    *   demais    -> SigCdUsu.usuarios + codigo do motivo
    *==========================================================================
    this_lAutorizado = .F.
    this_cZSenha     = ""

    *==========================================================================
    * Usuario autorizador selecionado (SigCdUsu / TmpUsu do legado)
    *==========================================================================
    this_cUsuarios = ""    && char(10) - Codigo do usuario que libera
    this_cSenhas   = ""     && char(10) - Senha gravada (conferida via fCriptografar)
    this_cCCargs   = ""     && char(10) - Cargo do usuario (FK SigCdCrg.ccargs)
    this_cLimDescs = ""     && char(1)  - SigCdUsu.limdescs ("S" = senha por data)

    *==========================================================================
    * Motivo selecionado (SigCdFs)
    *==========================================================================
    this_cCodigoMotivo  = ""   && char(10) - SigCdFs.codigos
    this_cDescrsMotivo  = ""   && char(40) - SigCdFs.descrs

    *==========================================================================
    * Senha livre (SigPrSnd) - fluxo this_cTipo = "L"
    *==========================================================================
    this_cSenhaDs     = ""   && char(6)  - Senha pre-cadastrada digitada
    this_cCidChaves   = ""   && char(20) - PK da senha livre localizada
    this_cEmpDopNums  = ""   && char(29) - Movimento que consumiu a senha
                             &&            (vazio = senha ainda disponivel)

    *==========================================================================
    * Espelho do que esta DIGITADO nos tres campos do dialogo (FormParaBO)
    *
    * Sao DIFERENTES de this_cUsuarios / this_cCodigoMotivo, que o legado le
    * do CURSOR (TmpUsu / TmpMdsc) via CarregarDoCursor/CarregarMotivoDoCursor
    * - nao se pode reusar as mesmas properties: o legado consulta as DUAS
    * origens no MESMO statement e elas tem significados distintos. Em
    * senha.Valid, "Zsenha = Iif(Tipo = [X], Usuario.Value,
    * TmpUsu.Usuarios + Get_motivo.Value)": o ramo "X" devolve o DIGITADO e o
    * ramo Else devolve o do CURSOR. Achatar os dois num campo so faria o
    * ramo "X" devolver o autorizador em vez de quem foi digitado - sem erro
    * e sem aviso, trocando a credencial gravada no movimento.
    *
    * this_cSenhaDigitada x this_cSenhaDs: o legado tem os dois usos tambem -
    * SenhaDs eh a senha pre-cadastrada que vira CHAVE DE BUSCA em SigPrSnd
    * (fluxo "L"), enquanto no fluxo normal a senha digitada eh so COMPARADA
    * com fCriptografar(SigCdUsu.Senhas) e nunca consultada em tabela.
    *==========================================================================
    this_cUsuarioDigitado = ""   && usuario.Value    - codigo digitado no campo
    this_cMotivoDigitado  = ""   && get_Motivo.Value - codigo digitado no campo
    this_cSenhaDigitada   = ""   && senha.Value      - senha digitada no campo

    *==========================================================================
    * Aliases dos cursores que este BO popula/consome
    * (mantidos como property para o Form nao repetir literais)
    *==========================================================================
    this_cCursorUsuarios   = "cursor_4c_Usuarios"     && TmpUsu     - usuarios com alcada
    this_cCursorMotivos    = "cursor_4c_Motivos"      && TmpMdsc    - motivos ja filtrados
    this_cCursorMotivosBase = "cursor_4c_MotivosBase" && LocalMdsc  - motivos antes da classificacao
    this_cCursorSenhaLivre = "cursor_4c_SenhaLivre"   && TmpPrSnd   - senha livre consultada
    this_cCursorClaMotivo  = "cursor_4c_ClaMotivo"    && TmpClaMt   - motivos da classificacao

    *==========================================================================
    * Init - Configura tabela/chave e resolve os defaults do legado
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            *-- Tabela principal consultada: cadastro de usuarios autorizadores
            THIS.this_cTabela     = "SigCdUsu"
            THIS.this_cCampoChave = "usuarios"

            *-- Empresa default = empresa logada.
            *-- Legado: ThisForm.pEmps = Iif(Type('pcempresa') = [C], pcempresa, _Empr)
            *-- _EMPR eh legado e nao se usa: a fonte eh go_4c_Sistema.cCodEmpresa.
            IF EMPTY(THIS.this_cEmps)
                IF VARTYPE(go_4c_Sistema) = "O"
                    THIS.this_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                ENDIF
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar SigOpLimBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega o usuario autorizador selecionado a partir
    * de uma linha de cursor_4c_Usuarios (equivalente a "Select TmpUsu" do
    * legado, lido direto por THIS.this_cUsuarios/Senhas/CCargs/LimDescs).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cUsuarios = TratarNulo(usuarios, "")
            THIS.this_cSenhas   = TratarNulo(senhas, "")
            THIS.this_cCCargs   = TratarNulo(ccargs, "")
            THIS.this_cLimDescs = TratarNulo(limdescs, "")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarUsuariosAutorizados - Legado: SIGOPLIM.usuario.Valid, Do Case
    * por this_cTipo. Popula this_cCursorUsuarios (TmpUsu do legado) com os
    * usuarios cujo cargo (SigCdCrg) tem alcada para o valor/percentual
    * pedidos. "X" confere Limites = "S" (ignora valor/percentual); os
    * demais ("D" Desconto e "C" Acrescimo, os dois pelo Other do Do Case)
    * conferem o
    * limite e o percentual do cargo.
    *==========================================================================
    PROCEDURE BuscarUsuariosAutorizados()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF USED(THIS.this_cCursorUsuarios)
                USE IN (THIS.this_cCursorUsuarios)
            ENDIF

            DO CASE
                CASE THIS.this_cTipo = "D"
                    loc_cSQL = "SELECT a.* FROM SigCdUsu a, SigCdCrg b " + ;
                        "WHERE NOT a.cativos = 'N' " + ;
                        "AND (b.limdescs = 0 OR b.limdescs >= " + FormatarNumeroSQL(THIS.this_nValDesc, 2) + ") " + ;
                        "AND (b.descpors = 0 OR b.descpors >= " + FormatarNumeroSQL(THIS.this_nPDescs, 2) + ") " + ;
                        "AND (b.limdescs <> 0 OR b.descpors <> 0) " + ;
                        "AND a.ccargs = b.ccargs " + ;
                        "AND b.nivels = 'S' " + ;
                        "AND a.senhas <> '  '"

                CASE THIS.this_cTipo = "X"
                    loc_cSQL = "SELECT a.* FROM SigCdUsu a, SigCdCrg b " + ;
                        "WHERE NOT a.cativos = 'N' " + ;
                        "AND a.ccargs = b.ccargs " + ;
                        "AND b.limites = 'S' " + ;
                        "AND a.senhas <> '  '"

                OTHERWISE
                    *-- "A" (Acrescimo) - ramo Other do Do Case legado
                    loc_cSQL = "SELECT a.* FROM SigCdUsu a, SigCdCrg b " + ;
                        "WHERE NOT a.cativos = 'N' " + ;
                        "AND (b.limacres = 0 OR b.limacres >= " + FormatarNumeroSQL(THIS.this_nValDesc, 2) + ") " + ;
                        "AND (b.acrepors = 0 OR b.acrepors >= " + FormatarNumeroSQL(THIS.this_nPDescs, 2) + ") " + ;
                        "AND (b.limacres <> 0 OR b.acrepors <> 0) " + ;
                        "AND a.ccargs = b.ccargs " + ;
                        "AND b.nivels = 'S' " + ;
                        "AND a.senhas <> '  '"
            ENDCASE

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorUsuarios)

            IF loc_nResultado < 1 OR !USED(THIS.this_cCursorUsuarios)
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ELSE
                SELECT (THIS.this_cCursorUsuarios)
                INDEX ON usuarios TAG usuarios
                GO TOP
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarMotivos - Legado: SIGOPLIM.get_Motivo.Valid. Monta a base
    * (SigCdFs Left Join SigCdFsI, filtrada por Tipos/ChkBins/BlqTabDs) em
    * this_cCursorMotivosBase (LocalMdsc do legado, ja filtrada por Emps) e
    * copia para this_cCursorMotivos (TmpMdsc do legado), que eh o cursor
    * final - restringido por FiltrarMotivosPorClassificacao() quando
    * this_cClaConta estiver preenchido.
    *==========================================================================
    PROCEDURE BuscarMotivos()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cCursorJoin
        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""
        loc_cCursorJoin = "cursor_4c_MotivosJoin"

        TRY
            IF USED(loc_cCursorJoin)
                USE IN (loc_cCursorJoin)
            ENDIF
            IF USED(THIS.this_cCursorMotivosBase)
                USE IN (THIS.this_cCursorMotivosBase)
            ENDIF
            IF USED(THIS.this_cCursorMotivos)
                USE IN (THIS.this_cCursorMotivos)
            ENDIF

            loc_cSQL = "SELECT a.*, b.emps FROM SigCdFs a LEFT JOIN SigCdFsI b ON a.codigos = b.codigos " + ;
                "WHERE a.tipos = " + EscaparSQL(THIS.this_cTipo) + " " + ;
                IIF(THIS.this_lCheckBin, "AND a.chkbins <> 1 ", "") + ;
                IIF(THIS.this_lCheckTbd, "AND a.blqtabds <> 1 ", "") + ;
                "ORDER BY a.codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorJoin)

            IF loc_nResultado < 1 OR !USED(loc_cCursorJoin)
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ELSE
                *-- Legado: Select Distinct Codigos, Descrs From LocalMdsc1
                *--         Where Nvl(Emps, pEmps) = pEmps Into Cursor LocalMdsc
                SELECT DISTINCT codigos, descrs FROM (loc_cCursorJoin) ;
                    WHERE NVL(emps, THIS.this_cEmps) = THIS.this_cEmps ;
                    INTO CURSOR (THIS.this_cCursorMotivosBase) READWRITE

                USE IN (loc_cCursorJoin)

                *-- Legado: Select * From LocalMdsc Into Cursor TmpMdsc ReadWrite
                SELECT * FROM (THIS.this_cCursorMotivosBase) ;
                    INTO CURSOR (THIS.this_cCursorMotivos) READWRITE

                IF !EMPTY(ALLTRIM(NVL(THIS.this_cClaConta, "")))
                    THIS.FiltrarMotivosPorClassificacao()
                ENDIF

                SELECT (THIS.this_cCursorMotivos)
                INDEX ON codigos TAG codigos
                GO TOP
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FiltrarMotivosPorClassificacao - Legado: bloco "If Not Empty(ThisForm.
    * ClaConta)" dentro de get_Motivo.Valid. SigCdCmt.Tipos=1 RESTRINGE
    * this_cCursorMotivos aos codigos daquela classificacao; Tipos=2
    * EXCLUI os codigos daquela classificacao. So chamado por BuscarMotivos.
    *==========================================================================
    PROTECTED PROCEDURE FiltrarMotivosPorClassificacao()
        LOCAL loc_cSQL, loc_nResultado

        TRY
            IF USED(THIS.this_cCursorClaMotivo)
                USE IN (THIS.this_cCursorClaMotivo)
            ENDIF

            loc_cSQL = "SELECT b.* FROM SigCdClc a, SigCdCmt b " + ;
                "WHERE a.codigos = " + EscaparSQL(ALLTRIM(THIS.this_cClaConta)) + " " + ;
                "AND a.cidchaves = b.fkchaves"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorClaMotivo)

            IF loc_nResultado >= 1 AND USED(THIS.this_cCursorClaMotivo)
                SELECT (THIS.this_cCursorClaMotivo)
                LOCATE FOR tipos = 1

                IF FOUND()
                    *-- Legado: Select a.* From LocalMdsc a, TmpClaMt b
                    *--         Where a.Codigos = b.codigos And b.Tipos = 1
                    *--         Into Cursor TmpMdsc ReadWrite
                    SELECT a.* FROM (THIS.this_cCursorMotivosBase) a, (THIS.this_cCursorClaMotivo) b ;
                        WHERE a.codigos = b.codigos AND b.tipos = 1 ;
                        INTO CURSOR (THIS.this_cCursorMotivos) READWRITE
                ELSE
                    SELECT (THIS.this_cCursorClaMotivo)
                    LOCATE FOR tipos = 2

                    IF FOUND()
                        *-- Legado: Select * From LocalMdsc Where Codigos Not in
                        *--         (Select Codigos From TmpClaMt Where Tipos = 2)
                        *--         Into Cursor TmpMdsc ReadWrite
                        SELECT * FROM (THIS.this_cCursorMotivosBase) ;
                            WHERE codigos NOT IN ;
                                (SELECT codigos FROM (THIS.this_cCursorClaMotivo) WHERE tipos = 2) ;
                            INTO CURSOR (THIS.this_cCursorMotivos) READWRITE
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarMotivoDoCursor - Carrega o motivo selecionado a partir de uma
    * linha de cursor_4c_Motivos (equivalente a ler TmpMdsc.Codigos/Descrs
    * apos o Seek do legado).
    *==========================================================================
    PROCEDURE CarregarMotivoDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigoMotivo = TratarNulo(codigos, "")
            THIS.this_cDescrsMotivo = TratarNulo(descrs, "")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GeraSenha - Transcricao literal de ThisForm.GeraSenha (SIGOPLIM.SCX).
    *
    * ATENCAO - metodo preservado so por fidelidade (PILAR 3), o resultado
    * NAO eh consultado em lugar nenhum do fluxo legado: pridig/segdig nunca
    * sao atribuidos (ficam 0) porque o legado esperava que fValidarCNPJ()
    * os preenchesse por efeito colateral (variavel nao-local visivel na
    * pilha de chamada); o wrapper novo (utils\fvalidarcnpj.prg) delega a
    * ValidarCNPJ() e devolve so um logico, sem esse efeito. zsen/zsen1,
    * calculados em usuario.Valid a partir deste metodo, tambem nunca sao
    * lidos depois. Quem chamar este metodo NAO deve basear autorizacao
    * nenhuma no retorno.
    *==========================================================================
    PROCEDURE GeraSenha(par_dData)
        LOCAL loc_nPriDig, loc_nSegDig, loc_cVar, loc_cVar1, loc_cSenha

        loc_nPriDig = 0
        loc_nSegDig = 0
        loc_cVar  = SUBSTR(DTOC(par_dData), 1, 2) + SUBSTR(DTOC(par_dData), 4, 2) + SUBSTR(DTOC(par_dData), 7, 2)
        loc_cVar  = loc_cVar + loc_cVar
        loc_cVar1 = TRANSFORM(loc_cVar + "00", "@R 99999999/9999-99")
        = fValidarCNPJ(loc_cVar1)
        loc_cSenha  = STR(loc_nPriDig, 1) + STR(loc_nSegDig, 1)
        loc_nPriDig = 0
        loc_nSegDig = 0
        loc_cVar1 = PADL(ALLTRIM(STR(VAL(loc_cVar) + VAL(loc_cSenha), 12)), 12, "0")
        loc_cVar1 = TRANSFORM(loc_cVar1 + "00", "@R 99999999/9999-99")
        loc_cSenha  = loc_cSenha + STR(loc_nPriDig, 1) + STR(loc_nSegDig, 1)

        RETURN loc_cSenha
    ENDPROC

    *==========================================================================
    * ValidarSenhaUsuario - Legado: SIGOPLIM.senha.Valid (ramo Else, Tipo
    * <> 'L'). Confere a senha digitada contra SigCdUsu.Senhas (ja carregada
    * em this_cSenhas por CarregarDoCursor) via fCriptografar.
    *
    * fCriptografar() NUNCA foi portada (funcao global legado Fortyus,
    * sig.prg/SIGFUNCS.PRG - nao vieram no acervo, e o algoritmo do hash nao
    * esta legivel em fonte nenhum). Transcrever a chamada literalmente e
    * deixar estourar dentro do TRY: o CATCH devolve a mensagem ao Form via
    * this_cMensagemErro em vez de fechar a tela (regra #27 do CLAUDE.md -
    * "DEIXAR AUSENTE", nunca inventar stub que devolva valor de calculo).
    *==========================================================================
    PROCEDURE ValidarSenhaUsuario(par_cSenhaDigitada)
        LOCAL loc_lResultado, loc_cSenhaPad, loc_cSenhaCripto
        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cSenhaPad    = PADR(ALLTRIM(NVL(par_cSenhaDigitada, "")), 10)
            loc_cSenhaCripto = fCriptografar(THIS.this_cSenhas)

            IF loc_cSenhaPad == PADR(loc_cSenhaCripto, 10)
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Senha Conflitante."
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarEConsumirSenhaLivre - Legado: SIGOPLIM.senha.Valid (ramo Tipo
    * = 'L'). Confere a senha pre-cadastrada em SigPrSnd e, se ainda nao
    * consumida, marca EmpDopNums com a chave do movimento que a consumiu.
    *
    * par_cEmpDopNumsMovimento: chave POSICIONAL (Emps char(3) + Dopes
    * char(20) + Str(Numes,6) = 29, igual EmpDopNums) - o Form monta com
    * PADR em cada parte (NUNCA ALLTRIM nas partes, regra da chave
    * posicional) a partir do cursor global TprMvCab do form chamador, que
    * este BO nao possui.
    *==========================================================================
    PROCEDURE ValidarEConsumirSenhaLivre(par_cSenhaDigitada, par_cEmpDopNumsMovimento)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cEmpDopNums
        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF USED(THIS.this_cCursorSenhaLivre)
                USE IN (THIS.this_cCursorSenhaLivre)
            ENDIF

            THIS.this_cSenhaDs = ALLTRIM(NVL(par_cSenhaDigitada, ""))

            loc_cSQL = "SELECT empdopnums, cidchaves FROM SigPrSnd WHERE senhads = " + ;
                EscaparSQL(THIS.this_cSenhaDs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorSenhaLivre)

            IF loc_nResultado < 1 OR !USED(THIS.this_cCursorSenhaLivre) OR RECCOUNT(THIS.this_cCursorSenhaLivre) = 0
                THIS.this_cMensagemErro = "Senha inv" + CHR(225) + "lida."
            ELSE
                SELECT (THIS.this_cCursorSenhaLivre)
                GO TOP

                IF !EMPTY(empdopnums)
                    THIS.this_cMensagemErro = "Senha j" + CHR(225) + " utilizada."
                ELSE
                    THIS.this_cCidChaves = ALLTRIM(cidchaves)
                    loc_cEmpDopNums = PADR(NVL(par_cEmpDopNumsMovimento, ""), 29)

                    loc_cSQL = "UPDATE SigPrSnd SET empdopnums = " + EscaparSQL(loc_cEmpDopNums) + ;
                        " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                    SQLEXEC(gnConnHandle, loc_cSQL)

                    THIS.this_cEmpDopNums = loc_cEmpDopNums
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ComporAutorizacaoSoMotivo - Legado: get_Motivo.Valid, "If ThisForm.
    * somotivo / ThisForm.Zsenha = Space(10) + This.Value". Usado quando a
    * tela so pede o motivo (totite+valor+pvalor=0 e Tipo<>'X').
    *==========================================================================
    PROCEDURE ComporAutorizacaoSoMotivo(par_cCodigoMotivo)
        THIS.this_cZSenha = SPACE(10) + NVL(par_cCodigoMotivo, "")
        THIS.this_lAutorizado = .T.
        THIS.RegistrarAuditoria("AUTORIZACAO")
    ENDPROC

    *==========================================================================
    * ComporAutorizacaoSenhaLivre - Legado: senha.Valid, Tipo = 'L',
    * "ThisForm.Zsenha = Usuar" apos ValidarEConsumirSenhaLivre() ter
    * sucesso. Usuar (legado) = gc_4c_UsuarioLogado (CLAUDE.md: _EMPR/Usuar
    * sao legado, nunca usar direto).
    *==========================================================================
    PROCEDURE ComporAutorizacaoSenhaLivre()
        THIS.this_cZSenha = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
        THIS.this_lAutorizado = .T.
        THIS.RegistrarAuditoria("AUTORIZACAO")
    ENDPROC

    *==========================================================================
    * ComporAutorizacaoUsuarioSenha - Legado: senha.Valid, ramo Else, apos
    * ValidarSenhaUsuario() ter sucesso. Tipo = "X" devolve o usuario
    * DIGITADO (par_cUsuarioDigitado); os demais devolvem o usuario
    * AUTORIZADOR (this_cUsuarios, carregado por CarregarDoCursor) + o
    * codigo do motivo.
    *==========================================================================
    PROCEDURE ComporAutorizacaoUsuarioSenha(par_cUsuarioDigitado, par_cCodigoMotivo)
        IF THIS.this_cTipo = "X"
            THIS.this_cZSenha = ALLTRIM(NVL(par_cUsuarioDigitado, ""))
        ELSE
            THIS.this_cZSenha = THIS.this_cUsuarios + NVL(par_cCodigoMotivo, "")
        ENDIF
        THIS.this_lAutorizado = .T.
        THIS.RegistrarAuditoria("AUTORIZACAO")
    ENDPROC

    *==========================================================================
    * LimparDados - zera SO o estado de uma rodada de autorizacao, PRESERVANDO
    * os parametros de abertura (this_nTotIte/this_nValDesc/this_nPDescs/
    * this_cTipo/this_lMotivo/this_cClaConta/this_lCheckBin/this_lCheckTbd/
    * this_cEmps/this_lSoMotivo).
    *
    * A separacao eh o ponto deste metodo, nao detalhe: os parametros de
    * abertura descrevem O QUE foi pedido (chegam pelo Init do Form e nao
    * mudam durante a vida do dialogo), enquanto o estado abaixo descreve QUEM
    * autorizou. Zerar os parametros aqui faria a rodada seguinte consultar
    * alcada para valor 0 com Tipo "D" - ou seja, QUALQUER usuario passaria a
    * ter alcada, em silencio.
    *
    * PUBLIC (eh PUBLIC na BusinessBase, regra #51): o Form chama no funil de
    * reentrada (LimparCampos). Sem este reset, reabrir o MESMO objeto de
    * dialogo deixaria this_cUsuarios/this_cSenhas carregados do autorizador
    * ANTERIOR - e como ValidarSenhaUsuario confere a senha digitada contra
    * this_cSenhas, a segunda rodada autorizaria com a senha de quem liberou
    * a primeira, sem que o novo usuario fosse sequer escolhido.
    *==========================================================================
    PROCEDURE LimparDados()
        *-- Resultado da autorizacao
        THIS.this_lAutorizado = .F.
        THIS.this_cZSenha     = ""

        *-- Usuario autorizador (TmpUsu do legado)
        THIS.this_cUsuarios = ""
        THIS.this_cSenhas   = ""
        THIS.this_cCCargs   = ""
        THIS.this_cLimDescs = ""

        *-- Motivo selecionado (TmpMdsc do legado)
        THIS.this_cCodigoMotivo = ""
        THIS.this_cDescrsMotivo = ""

        *-- Senha livre (TmpPrSnd do legado)
        THIS.this_cSenhaDs    = ""
        THIS.this_cCidChaves  = ""
        THIS.this_cEmpDopNums = ""

        *-- Espelho dos campos digitados
        THIS.this_cUsuarioDigitado = ""
        THIS.this_cMotivoDigitado  = ""
        THIS.this_cSenhaDigitada   = ""

        *-- BusinessBase.LimparDados limpa this_cMensagemErro
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Usuario autorizador (ou o usuario logado, no
    * fluxo de senha livre, que nao passa por CarregarDoCursor). Usado so
    * por RegistrarAuditoria - nunca chamado de fora do BO (regra #51).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(NVL(THIS.this_cUsuarios, ""))

        IF EMPTY(loc_cChave) AND TYPE("gc_4c_UsuarioLogado") = "C"
            loc_cChave = ALLTRIM(gc_4c_UsuarioLogado)
        ENDIF

        RETURN loc_cChave
    ENDPROC

ENDDEFINE
