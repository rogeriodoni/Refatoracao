* ProbeF8SigOpStc807.prg
* Fase 8 / task807 - CONSOLIDACAO: prova, numa unica execucao, que
*   (a) FormSIGOPSTC instancia COM e SEM form pai;
*   (b) todo metodo que o harness/BINDEVENT alcanca de FORA eh PUBLIC
*       (PEMSTATUS(...,2) = .F.), os DOIS BINDEVENT do legado estao
*       REGISTRADOS (AEVENTS, nao so "o metodo existe") e a chamada
*       externa sem dado devolve .F. sem estourar;
*   (c) o FUNIL CarregarLista (renomeado nesta fase) liga a grade ao cursor,
*       espelha o cabecalho nos quatro Text, liga o Edit1 por ControlSource
*       e posiciona na primeira linha;
*   (d) o elo mestre-detalhe funciona: trocar a linha corrente e chamar
*       GradeAfterRowColChange muda o Edit1 (AfterRowColChange do legado);
*   (e) BtnEncerrarClick fecha o dialogo (ThisForm.Release do legado).
*
* SigFiSit/SigFiSii estao VAZIAS no banco (COUNT(*) = 0 nas duas, medido em
* 2026-11-18), entao a consulta real nao devolve linha nenhuma e nao serve
* de prova. O probe injeta um BO de teste (StcBoFakeF8, subclasse de
* SIGOPSTCBO) que cria o cursor_4c_Envios com DUAS linhas - exatamente a
* estrutura que o SELECT do BO produz - e delega o resto para o
* CarregarDoCursor REAL. Nada do form eh alterado: so a origem das linhas.
*
* ARMADILHA MEDIDA (automation\_f8stc_diag.prg, 2026-11-18): objeto NAO
* visual fica amarrado a sessao de dados corrente NO MOMENTO DA CRIACAO.
* Criado na sessao 1 e injetado num form com DataSession = 2, o cursor do
* fake nasce na sessao 1 e o USED() de dentro de CarregarLista (que roda na
* sessao 2) devolve .F. - CarregarLista devolve .F. sem erro nenhum e
* "parece" defeito do form. Por isso o CREATEOBJECT do fake acontece com
* SET DATASESSION TO <sessao do form>. No fluxo REAL isso nao aparece: o
* SIGOPSTCBO de verdade eh criado DENTRO do InicializarForm, ja na sessao
* privada do form.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cOut, loc_cRel, loc_oForm, loc_oPai, loc_oErro, loc_lRet
LOCAL loc_cCursor, loc_nSessao, loc_cEdit1, loc_cEdit2, loc_nI, loc_lTemLinhas

loc_cOut = "C:\4c\automation\_f8stc_probe.txt"
loc_cRel = "CHECKPOINT 1 - vivo " + TTOC(DATETIME()) + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f8stc_erros.txt"
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "PROBE"

IF FILE(gc_4c_ArquivoErroTeste)
    ERASE (gc_4c_ArquivoErroTeste)
ENDIF

CD C:\4c\projeto\app\start
DO config.prg

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SIGOPSTCBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSIGOPSTC.prg") ADDITIVE

loc_cRel = loc_cRel + "CHECKPOINT 2 - dependencias OK" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

*===========================================================================
* (a1) instancia SEM form pai (caminho do harness/ValidarUIFidelity)
*===========================================================================
loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSIGOPSTC")
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "EXCECAO (sem pai): " + loc_oErro.Message + " | Linha " + ;
        TRANSFORM(loc_oErro.LineNo) + " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY
loc_cRel = loc_cRel + "(a1) SEM form pai   VARTYPE(form) = [" + VARTYPE(loc_oForm) + "]" + ;
    "  esperado [O]" + CHR(13) + CHR(10)
IF VARTYPE(loc_oForm) = "O"
    loc_oForm.Release()
    loc_oForm = .NULL.
ENDIF
STRTOFILE(loc_cRel, loc_cOut)

*===========================================================================
* (a2) instancia COM form pai, como o legado (Do Form SIGOPSTC With ThisForm)
*===========================================================================
loc_oPai = CREATEOBJECT("Form")
loc_oPai.AddProperty("pcSelFile", "CAT0001.TXT")

loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSIGOPSTC", loc_oPai)
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "EXCECAO (com pai): " + loc_oErro.Message + " | Linha " + ;
        TRANSFORM(loc_oErro.LineNo) + " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY
loc_cRel = loc_cRel + "(a2) COM form pai   VARTYPE(form) = [" + VARTYPE(loc_oForm) + "]" + ;
    "  this_cArqMovsPai = [" + IIF(VARTYPE(loc_oForm) = "O", loc_oForm.this_cArqMovsPai, "?") + "]" + ;
    CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

IF VARTYPE(loc_oForm) != "O"
    loc_cRel = loc_cRel + "ABORTADO - form nao instanciou" + CHR(13) + CHR(10)
    STRTOFILE(loc_cRel, loc_cOut)
    QUIT
ENDIF

loc_nSessao = loc_oForm.DataSessionId
loc_cCursor = loc_oForm.ObterCursorEnvios()

*===========================================================================
* (b) escopo dos metodos chamados de FORA (regra #3 / #51)
*     PEMSTATUS(obj, "M", 2) = .T. significa PROTECTED -> chamada externa
*     estouraria em runtime
*===========================================================================
loc_cRel = loc_cRel + "(b) ESCOPO (protected=SIM reprova)" + CHR(13) + CHR(10)
LOCAL ARRAY loc_aMet[8]
loc_aMet[1] = "ValidarParametros"
loc_aMet[2] = "CarregarLista"
loc_aMet[3] = "AtualizarCabecalho"
loc_aMet[4] = "AtualizarDetalheRetorno"
loc_aMet[5] = "GradeAfterRowColChange"
loc_aMet[6] = "BtnEncerrarClick"
loc_aMet[7] = "ObterCursorEnvios"
loc_aMet[8] = "CarregarDados"
FOR loc_nI = 1 TO 8
    loc_cRel = loc_cRel + "    " + PADR(loc_aMet[loc_nI], 26) + ;
        " existe=" + IIF(PEMSTATUS(loc_oForm, loc_aMet[loc_nI], 5), "SIM", "NAO") + ;
        " protected=" + IIF(PEMSTATUS(loc_oForm, loc_aMet[loc_nI], 5) AND ;
                            PEMSTATUS(loc_oForm, loc_aMet[loc_nI], 2), "SIM", "NAO") + ;
        CHR(13) + CHR(10)
ENDFOR
STRTOFILE(loc_cRel, loc_cOut)

*===========================================================================
* (b2) BINDEVENT REGISTRADO - AEVENTS tem DOIS argumentos (array + objeto de
* ORIGEM); a coluna 3 eh o EVENTO e a 4 eh o METODO delegate. A coluna 2 eh
* OBJETO: concatenar ela numa string pendura o VFP headless num dialogo
* modal de Program Error, sem gerar .ERR.
*===========================================================================
LOCAL ARRAY loc_aEv[1, 5]
LOCAL loc_nBind
loc_cRel = loc_cRel + "(b2) BINDEVENT registrados (AEVENTS por objeto de origem)" + CHR(13) + CHR(10)

loc_nBind = 0
TRY
    loc_nBind = AEVENTS(loc_aEv, loc_oForm.grd_4c_Dados)
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "    EXCECAO AEVENTS(grade): " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY
loc_cRel = loc_cRel + "    grade   bindings = " + TRANSFORM(loc_nBind) + CHR(13) + CHR(10)
FOR loc_nI = 1 TO loc_nBind
    loc_cRel = loc_cRel + "      evento [" + ALLTRIM(loc_aEv[loc_nI, 3]) + "] -> metodo [" + ;
        ALLTRIM(loc_aEv[loc_nI, 4]) + "]" + CHR(13) + CHR(10)
ENDFOR

loc_nBind = 0
TRY
    loc_nBind = AEVENTS(loc_aEv, loc_oForm.cmg_4c_Botoes.Buttons(1))
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "    EXCECAO AEVENTS(botao): " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY
loc_cRel = loc_cRel + "    Buttons(1) bindings = " + TRANSFORM(loc_nBind) + CHR(13) + CHR(10)
FOR loc_nI = 1 TO loc_nBind
    loc_cRel = loc_cRel + "      evento [" + ALLTRIM(loc_aEv[loc_nI, 3]) + "] -> metodo [" + ;
        ALLTRIM(loc_aEv[loc_nI, 4]) + "]" + CHR(13) + CHR(10)
ENDFOR
STRTOFILE(loc_cRel, loc_cOut)

*-- (b3) Chamada externa real: sem cursor/consulta o funil devolve .F. sem estourar
loc_cRel = loc_cRel + "(b3) chamadas externas sem dado:" + ;
    "  ObterCursorEnvios=[" + loc_cCursor + "]" + ;
    "  ValidarParametros=" + TRANSFORM(loc_oForm.ValidarParametros()) + ;
    "  AtualizarDetalheRetorno=" + TRANSFORM(loc_oForm.AtualizarDetalheRetorno()) + ;
    "  AtualizarCabecalho=" + TRANSFORM(loc_oForm.AtualizarCabecalho()) + ;
    CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

*===========================================================================
* (c) FUNIL CarregarLista com o BO de teste injetado (criado NA SESSAO DO
*     FORM - ver ARMADILHA MEDIDA no cabecalho)
*===========================================================================
SET DATASESSION TO loc_nSessao
loc_oForm.this_oBusinessObject = CREATEOBJECT("StcBoFakeF8")
SET DATASESSION TO 1

loc_lRet = loc_oForm.CarregarLista()

loc_cRel = loc_cRel + "(c) CarregarLista retorno = " + TRANSFORM(loc_lRet) + ;
    "  BO injetado = [" + loc_oForm.this_oBusinessObject.Class + "]" + ;
    "  DataSessionId = " + TRANSFORM(loc_nSessao) + CHR(13) + CHR(10)

loc_lTemLinhas = .F.
SET DATASESSION TO loc_nSessao
loc_cRel = loc_cRel + "    USED(cursor) = " + TRANSFORM(USED(loc_cCursor)) + ;
    "  RECCOUNT = " + TRANSFORM(IIF(USED(loc_cCursor), RECCOUNT(loc_cCursor), -1)) + ;
    "  esperado 2" + CHR(13) + CHR(10)
loc_lTemLinhas = USED(loc_cCursor) AND RECCOUNT(loc_cCursor) = 2
SET DATASESSION TO 1

loc_cRel = loc_cRel + "    Grid RecordSource = [" + loc_oForm.grd_4c_Dados.RecordSource + "]" + ;
    "  ColumnCount = " + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    Column1.ControlSource = [" + loc_oForm.grd_4c_Dados.Column1.ControlSource + "]" + ;
    "  Header = [" + loc_oForm.grd_4c_Dados.Column1.Header1.Caption + "]" + ;
    "  Width = " + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Width) + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    Column2.ControlSource = [" + loc_oForm.grd_4c_Dados.Column2.ControlSource + "]" + ;
    "  Header = [" + loc_oForm.grd_4c_Dados.Column2.Header1.Caption + "]" + ;
    "  Width = " + TRANSFORM(loc_oForm.grd_4c_Dados.Column2.Width) + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    Edit1.ControlSource = [" + loc_oForm.edt_4c_Edit1.ControlSource + "]" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    Text1=[" + loc_oForm.txt_4c_Text1.Value + "]" + ;
    " Text2=[" + loc_oForm.txt_4c_Text2.Value + "]" + ;
    " Text3=[" + loc_oForm.txt_4c_Text3.Value + "]" + ;
    " Text4=[" + loc_oForm.txt_4c_Text4.Value + "]" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    CONFERE cabecalho = " + ;
    IIF(loc_oForm.txt_4c_Text1.Value == "CAT0001.TXT" AND ;
        loc_oForm.txt_4c_Text2.Value == "778899" AND ;
        loc_oForm.txt_4c_Text3.Value == "001" AND ;
        loc_oForm.txt_4c_Text4.Value == "IMPFISCAL01", "SIM", "NAO") + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

*===========================================================================
* (d) elo mestre-detalhe: 1a linha -> SKIP -> GradeAfterRowColChange
*===========================================================================
loc_cRel = loc_cRel + "(d) mestre-detalhe (AfterRowColChange)" + CHR(13) + CHR(10)

IF loc_lTemLinhas
    loc_cEdit1 = loc_oForm.edt_4c_Edit1.Value

    SET DATASESSION TO loc_nSessao
    SELECT (loc_cCursor)
    GO TOP
    SKIP
    SET DATASESSION TO 1

    loc_lRet   = loc_oForm.GradeAfterRowColChange(1)
    loc_cEdit2 = loc_oForm.edt_4c_Edit1.Value

    loc_cRel = loc_cRel + "    linha 1  Edit1 = [" + loc_cEdit1 + "]" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "    linha 2  Edit1 = [" + loc_cEdit2 + "]" + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "    CONFERE detalhe = " + ;
        IIF(loc_cEdit1 == "RETORNO DA 1a TENTATIVA" AND ;
            loc_cEdit2 == "RETORNO DA 2a TENTATIVA", "SIM", "NAO") + CHR(13) + CHR(10)
ELSE
    loc_cRel = loc_cRel + "    PULADO - cursor sem as 2 linhas esperadas" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(loc_cRel, loc_cOut)

*===========================================================================
* (e) BtnEncerrarClick fecha o dialogo (ThisForm.Release)
*===========================================================================
loc_lRet = loc_oForm.BtnEncerrarClick()
loc_cRel = loc_cRel + "(e) BtnEncerrarClick retorno = " + TRANSFORM(loc_lRet) + ;
    "  VARTYPE(form) depois = [" + VARTYPE(loc_oForm) + "]" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "    cursor fechado pelo Destroy (sessao 1 nao enxerga a privada): USED = " + ;
    TRANSFORM(USED(loc_cCursor)) + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

*===========================================================================
* Dialogos suprimidos pelo modo teste (MsgErro/MsgAviso escrevem no arquivo)
*===========================================================================
loc_cRel = loc_cRel + "--- ARQUIVO DE ERRO DE TESTE" + CHR(13) + CHR(10)
IF FILE(gc_4c_ArquivoErroTeste)
    loc_cRel = loc_cRel + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ELSE
    loc_cRel = loc_cRel + "  (vazio - nenhum MsgErro/MsgAviso disparado)" + CHR(13) + CHR(10)
ENDIF

loc_cRel = loc_cRel + "FIM" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

QUIT


*===========================================================================
* StcBoFakeF8 - BO de teste: substitui SO a origem das linhas (as tabelas
* estao vazias no banco) e delega o resto ao SIGOPSTCBO real. O cursor eh
* criado com as MESMAS colunas que o SELECT de CarregarSituacao produz.
*===========================================================================
DEFINE CLASS StcBoFakeF8 AS SIGOPSTCBO

    FUNCTION CarregarSituacao(par_cArqMovs)
        IF USED("cursor_4c_Envios")
            USE IN cursor_4c_Envios
        ENDIF

        CREATE CURSOR cursor_4c_Envios ( ;
            carqmovs  C(12), cidchaves C(20), cemps     C(3),  cnumlotes C(10), ;
            cimpfabs  C(20), cretsites C(20), cstatenvs C(1),  cstatvals C(1),  ;
            cusuarios C(20), tdtenvs   T,     tdtmovs   T,     cretornos M,     ;
            envios    T)

        INSERT INTO cursor_4c_Envios (carqmovs, cidchaves, cemps, cnumlotes, ;
            cimpfabs, cretsites, cstatenvs, cstatvals, cusuarios, tdtenvs, ;
            tdtmovs, cretornos, envios) ;
            VALUES ("CAT0001.TXT", "CHAVE0000000000000001", "001", "778899", ;
            "IMPFISCAL01", "SEFAZ OK", "1", "1", "OPERADOR01", ;
            DATETIME(), DATETIME(), "RETORNO DA 1a TENTATIVA", DATETIME())

        INSERT INTO cursor_4c_Envios (carqmovs, cidchaves, cemps, cnumlotes, ;
            cimpfabs, cretsites, cstatenvs, cstatvals, cusuarios, tdtenvs, ;
            tdtmovs, cretornos, envios) ;
            VALUES ("CAT0001.TXT", "CHAVE0000000000000001", "001", "778899", ;
            "IMPFISCAL01", "SEFAZ OK", "1", "1", "OPERADOR01", ;
            DATETIME(), DATETIME(), "RETORNO DA 2a TENTATIVA", DATETIME())

        THIS.CarregarDoCursor("cursor_4c_Envios")

        RETURN .T.
    ENDFUNC

ENDDEFINE
