*==============================================================================
* GARANTIRCLASSE.PRG
* Carga sob demanda - garante que a classe esta no SET PROCEDURE
*
* Por que existe: fazer SET PROCEDURE ADDITIVE de TODOS os BOs e Forms
* (~950 arquivos) custa QUADRATICO - o i-esimo arquivo custa proporcional a
* i. Medido em 2026-10-28: 168 s ate o menu, contra 0,9 s sob demanda.
* Agrupar varios arquivos num comando so NAO ajuda (custo por arquivo).
*
* Uso, antes de criar a classe (menu.prg, classe em variavel, probes):
*     GarantirClasse("FormLpr")
*     loForm = CREATEOBJECT("FormLpr")
* CREATEOBJECT com nome LITERAL dentro de form/BO nao precisa: o indice ja
* traz o fecho de dependencias de cada arquivo.
*
* Resolvido pelo NOME do arquivo via PATH (utils\ esta no PATH, regra #26),
* sem cabecalho FUNCTION - o mesmo padrao do isempty.prg. Le
* start\indice_classes.txt (gerado por automation\GerarIndiceClasses.ps1 e
* regerado pelo ConfigurarAmbiente quando algum .prg fica mais novo) e
* carrega o arquivo da classe mais o fecho das dependencias dele (BO, forms
* filhos, classe-mae). Com ConfigurarAmbiente(.T.) - carga completa -
* gl_4c_CargaSobDemanda fica .F. e a chamada vira no-op.
*
* Retorno: .T. se a classe esta carregada (ou o modo eh carga completa);
*          .F. se a classe nao esta no indice (classe base do VFP, classe de
*          VCX ou indice desatualizado) - o CREATEOBJECT seguinte da o erro
*          normal do VFP, que continua sendo tratado pelo chamador.
*==============================================================================
LPARAMETERS par_cClasse
LOCAL loc_cChave, loc_lResultado

IF TYPE("gl_4c_CargaSobDemanda") <> "L"
    RETURN .T.
ENDIF
IF !gl_4c_CargaSobDemanda
    RETURN .T.
ENDIF
IF VARTYPE(par_cClasse) <> "C" OR EMPTY(par_cClasse)
    RETURN .F.
ENDIF

IF TYPE("go_4c_IndiceClasses") <> "O"
    IF !CarregarIndiceClasses()
        RETURN .F.
    ENDIF
ENDIF

loc_cChave = LOWER(ALLTRIM(par_cClasse))
IF go_4c_IndiceClasses.oClasses.GetKey(loc_cChave) = 0
    RegistrarCarga("classe fora do indice: " + loc_cChave)
    RETURN .F.
ENDIF

loc_lResultado = CarregarComDependencias(go_4c_IndiceClasses.oClasses.Item(loc_cChave), SECONDS(), par_cClasse)
RETURN loc_lResultado

*------------------------------------------------------------------------------
* CarregarIndiceClasses - le o indice para Collections (nao dependem de
* data session, entao valem dentro de form com DataSession = 2)
*------------------------------------------------------------------------------
PROCEDURE CarregarIndiceClasses()
    LOCAL loc_cArquivo, loc_nLinhas, loc_nI, loc_cLinha, loc_cChave, loc_lOk, loc_oErro
    LOCAL ARRAY loc_aLinhas[1], loc_aCampos[1]

    loc_lOk = .F.
    loc_cArquivo = ADDBS(gc_4c_CaminhoBase) + "indice_classes.txt"
    IF !FILE(loc_cArquivo)
        MsgErro("Indice de classes n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cArquivo + ;
                CHR(13) + CHR(13) + "Rodar automation\GerarIndiceClasses.ps1.", "Carga sob demanda")
        RETURN .F.
    ENDIF

    TRY
        PUBLIC go_4c_IndiceClasses
        go_4c_IndiceClasses = CREATEOBJECT("Empty")
        ADDPROPERTY(go_4c_IndiceClasses, "oClasses",    CREATEOBJECT("Collection"))
        ADDPROPERTY(go_4c_IndiceClasses, "oDeps",       CREATEOBJECT("Collection"))
        ADDPROPERTY(go_4c_IndiceClasses, "oCarregados", CREATEOBJECT("Collection"))

        loc_nLinhas = ALINES(loc_aLinhas, FILETOSTR(loc_cArquivo), 1)
        FOR loc_nI = 1 TO loc_nLinhas
            loc_cLinha = loc_aLinhas[loc_nI]
            IF LEFT(loc_cLinha, 2) = "C|"
                ALINES(loc_aCampos, loc_cLinha, 0, "|")
                go_4c_IndiceClasses.oClasses.Add(loc_aCampos[3], loc_aCampos[2])
            ENDIF
            IF LEFT(loc_cLinha, 2) = "D|"
                ALINES(loc_aCampos, loc_cLinha, 0, "|")
                loc_cChave = ChaveArquivo(loc_aCampos[2])
                IF go_4c_IndiceClasses.oDeps.GetKey(loc_cChave) = 0
                    go_4c_IndiceClasses.oDeps.Add(loc_aCampos[3], loc_cChave)
                ELSE
                    *-- Collection.Item nao aceita atribuicao: remove e regrava
                    loc_cLinha = go_4c_IndiceClasses.oDeps.Item(loc_cChave) + "|" + loc_aCampos[3]
                    go_4c_IndiceClasses.oDeps.Remove(loc_cChave)
                    go_4c_IndiceClasses.oDeps.Add(loc_cLinha, loc_cChave)
                ENDIF
            ENDIF
        ENDFOR

        *-- O que a abertura ja carregou (bases, utils, FormBuscaAuxiliar...)
        *-- conta como carregado: SET("PROCEDURE") lista os caminhos completos
        loc_nLinhas = ALINES(loc_aLinhas, SET("PROCEDURE"), 1, ",")
        FOR loc_nI = 1 TO loc_nLinhas
            loc_cChave = ChaveArquivo(loc_aLinhas[loc_nI])
            IF go_4c_IndiceClasses.oCarregados.GetKey(loc_cChave) = 0
                go_4c_IndiceClasses.oCarregados.Add(.T., loc_cChave)
            ENDIF
        ENDFOR

        RegistrarCarga("indice: " + TRANSFORM(go_4c_IndiceClasses.oClasses.Count) + " classes, " + ;
                       TRANSFORM(go_4c_IndiceClasses.oCarregados.Count) + " arquivos ja carregados")
        loc_lOk = .T.
    CATCH TO loc_oErro
        MsgErro("Erro ao ler o " + CHR(237) + "ndice de classes:" + CHR(13) + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Carga sob demanda")
        go_4c_IndiceClasses = .NULL.
    ENDTRY

    RETURN loc_lOk
ENDPROC

*------------------------------------------------------------------------------
* CarregarComDependencias - SET PROCEDURE do arquivo e do fecho dele.
* Marca o arquivo ANTES de descer: dependencia circular (form que abre form
* que abre o primeiro) nao entra em laco.
*------------------------------------------------------------------------------
PROCEDURE CarregarComDependencias(par_cRelativo, par_nInicio, par_cClasse)
    LOCAL loc_cChave, loc_nDeps, loc_nI, loc_lOk, loc_nAntes, loc_oErro
    LOCAL ARRAY loc_aDeps[1]

    loc_lOk = .T.
    loc_cChave = ChaveArquivo(par_cRelativo)
    IF go_4c_IndiceClasses.oCarregados.GetKey(loc_cChave) > 0
        RETURN .T.
    ENDIF
    go_4c_IndiceClasses.oCarregados.Add(.T., loc_cChave)
    loc_nAntes = go_4c_IndiceClasses.oCarregados.Count

    IF go_4c_IndiceClasses.oDeps.GetKey(loc_cChave) > 0
        loc_nDeps = ALINES(loc_aDeps, go_4c_IndiceClasses.oDeps.Item(loc_cChave), 1, "|")
        FOR loc_nI = 1 TO loc_nDeps
            IF !CarregarComDependencias(loc_aDeps[loc_nI], 0, "")
                loc_lOk = .F.
            ENDIF
        ENDFOR
    ENDIF

    TRY
        SET PROCEDURE TO (ADDBS(gc_4c_CaminhoBase) + "..\" + par_cRelativo) ADDITIVE
    CATCH TO loc_oErro
        loc_lOk = .F.
        MsgErro("Erro ao carregar " + par_cRelativo + ":" + CHR(13) + loc_oErro.Message, "Carga sob demanda")
    ENDTRY

    *-- So a chamada de topo registra (as recursivas recebem par_nInicio = 0)
    IF par_nInicio > 0
        RegistrarCarga(par_cClasse + ": +" + TRANSFORM(go_4c_IndiceClasses.oCarregados.Count - loc_nAntes + 1) + ;
                       " arquivo(s) em " + TRANSFORM(SECONDS() - par_nInicio, "999.999") + " s" + ;
                       " (total no SET PROCEDURE: " + TRANSFORM(go_4c_IndiceClasses.oCarregados.Count) + ")")
    ENDIF
    RETURN loc_lOk
ENDPROC

*------------------------------------------------------------------------------
* ChaveArquivo - nome do arquivo sem pasta/extensao, minusculo. O gerador
* confere que nao ha dois .prg com o mesmo nome em pastas diferentes.
*------------------------------------------------------------------------------
PROCEDURE ChaveArquivo(par_cCaminho)
    RETURN LOWER(JUSTSTEM(ALLTRIM(par_cCaminho)))
ENDPROC

*------------------------------------------------------------------------------
* RegistrarCarga - log de medicao do piloto (start\carga_sobdemanda.log)
*------------------------------------------------------------------------------
PROCEDURE RegistrarCarga(par_cTexto)
    STRTOFILE("[" + TTOC(DATETIME()) + "] " + par_cTexto + CHR(13) + CHR(10), ;
              ADDBS(gc_4c_CaminhoBase) + "carga_sobdemanda.log", 1)
ENDPROC
