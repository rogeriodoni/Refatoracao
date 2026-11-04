*==============================================================================
* Probe722F8.prg - Instancia FormSigOpDmp (Fase 8, task722) e exercita o que a
* fase entregou: FormParaBO, HabilitarCampos, BtnBuscarClick, o despachante
* BtnSalvarClick (INCLUIR/ALTERAR/EXCLUIR/PROCURAR/VISUALIZAR), o
* ExecutarBuscaPorNome (msv_procurar), o par Commit/RollBack e os BINDEVENT
* do Buscar e do Confirmar.
*
* NAO chama ConfigurarAmbiente() - ela BLOQUEIA nesta maquina. Carrega a mao
* so as dependencias do form. Sem conexao SQL (gnConnHandle = 0) os caminhos
* de gravacao tem de RECUSAR com mensagem, nunca estourar excecao nem abrir
* dialogo modal.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe722f8_dialogs.txt"
gnConnHandle           = 0

LOCAL loc_cSai, loc_oE
loc_cSai = "C:\4c\automation\probe722f8.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE("A: inicio" + CHR(13) + CHR(10), loc_cSai)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    STRTOFILE("B: config.prg OK" + CHR(13) + CHR(10), loc_cSai, 1)

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + ;
                 gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbuscaauxiliar.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "TextBoxGridLookup.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")           ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpDmpBO.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormSigOpDmp.prg") ADDITIVE
    STRTOFILE("C: deps carregadas" + CHR(13) + CHR(10), loc_cSai, 1)

    STRTOFILE(Exercitar() + CHR(13) + CHR(10), loc_cSai, 1)

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " | Linha: " + ;
        TRANSFORM(loc_oE.LineNo) + " | Proc: " + loc_oE.Procedure + ;
        CHR(13) + CHR(10), loc_cSai, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), loc_cSai, 1)
ELSE
    STRTOFILE("DIALOGOS SUPRIMIDOS: nenhum" + CHR(13) + CHR(10), loc_cSai, 1)
ENDIF

STRTOFILE("Z: fim" + CHR(13) + CHR(10), loc_cSai, 1)
QUIT


FUNCTION Exercitar()
    LOCAL loc_oForm, loc_oPg1, loc_oPg2, loc_oBO, loc_cO, loc_oE2
    LOCAL loc_cNomes, loc_nQtd, loc_lRet, loc_nI
    loc_cO = ""

    TRY
        loc_oForm = CREATEOBJECT("ProbeDmp722")
        IF VARTYPE(loc_oForm) != "O"
            loc_cO = "FALHA: CREATEOBJECT devolveu " + VARTYPE(loc_oForm)
        ELSE
            loc_cO = "CK01 instanciou OK  Caption=[" + loc_oForm.Caption + "]" + ;
                CHR(13) + CHR(10)

            loc_oPg1 = loc_oForm.pgf_4c_Paginas.Page1
            loc_oPg2 = loc_oForm.pgf_4c_Paginas.Page2
            loc_oBO  = loc_oForm.this_oBusinessObject

            *-- 1. Metodos novos existem e tem a visibilidade certa (regra #51)
            loc_cNomes = "HabilitarCampos,BtnBuscarClick," + ;
                "BtnSalvarClick,BtnCancelarClick,BtnEncerrarClick," + ;
                "BtnIncluirClick,BtnAlterarClick,BtnVisualizarClick," + ;
                "BtnExcluirClick,CarregarLista,AlternarPagina," + ;
                "AjustarBotoesPorModo,AtualizarEstadoCampos,InserirLinhaFase"
            loc_cO = loc_cO + "CK02 visibilidade dos metodos PUBLIC:" + ;
                CHR(13) + CHR(10) + ChecarPublicos(loc_oForm, loc_cNomes)

            *-- 2. Metodos do BO que o form chama de FORA
            loc_cNomes = "GravarFases,ExcluirFases,Salvar,Excluir," + ;
                "CarregarPorCodigo,CarregarDoCursor,LimparDados," + ;
                "NovoRegistro,EditarRegistro,CancelarEdicao,Buscar," + ;
                "ObterMensagemErro"
            loc_cO = loc_cO + "CK03 visibilidade dos metodos do BO:" + ;
                CHR(13) + CHR(10) + ChecarPublicos(loc_oBO, loc_cNomes)

            *-- 3. ExecutarExclusao tem de continuar PROTECTED (so o
            *--    BusinessBase.Excluir() pode chama-lo)
            loc_cO = loc_cO + "CK04 BO.ExecutarExclusao existe=" + ;
                TRANSFORM(PEMSTATUS(loc_oBO, "ExecutarExclusao", 5)) + ;
                " PROTECTED=" + TRANSFORM(PEMSTATUS(loc_oBO, "ExecutarExclusao", 2)) + ;
                "  (esperado .T./.T.)" + CHR(13) + CHR(10)

            *-- 4. BINDEVENT do Buscar e do Confirmar registrados
            loc_cO = loc_cO + "CK05 BINDEVENT Click: Buscar=" + ;
                TRANSFORM(ContarBind(loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar)) + ;
                " Confirmar=" + ;
                TRANSFORM(ContarBind(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar)) + ;
                " Cancelar=" + ;
                TRANSFORM(ContarBind(loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar)) + ;
                " Incluir=" + ;
                TRANSFORM(ContarBind(loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir)) + ;
                "  (todos >= 1)" + CHR(13) + CHR(10)

            *-- 5. FormParaBO copia os TRES campos com o LEFT das larguras
            loc_oPg2.txt_4c_Nome.Value  = "DEMONSTRATIVO TESTE XYZ"   && > 20
            loc_oPg2.txt_4c_Grupo.Value = "GRUPO12345678"             && > 10
            loc_oPg2.txt_4c_Conta.Value = "CONTA98765432"             && > 10
            loc_lRet = loc_oForm.ProbeFormParaBO()
            loc_cO = loc_cO + "CK06 FormParaBO=" + TRANSFORM(loc_lRet) + ;
                "  nome=[" + ALLTRIM(loc_oBO.this_cNome) + "](" + ;
                TRANSFORM(LEN(loc_oBO.this_cNome)) + ")" + ;
                " grupos=[" + ALLTRIM(loc_oBO.this_cGrupos) + "](" + ;
                TRANSFORM(LEN(loc_oBO.this_cGrupos)) + ")" + ;
                " contas=[" + ALLTRIM(loc_oBO.this_cContas) + "](" + ;
                TRANSFORM(LEN(loc_oBO.this_cContas)) + ")" + ;
                "  (esperado .T. / 20 / 10 / 10)" + CHR(13) + CHR(10)

            *-- 6. Ida e volta BO -> Form
            loc_oForm.ProbeLimparCampos()
            loc_oForm.ProbeBOParaForm()
            loc_cO = loc_cO + "CK07 BOParaForm: Nome=[" + ;
                ALLTRIM(loc_oPg2.txt_4c_Nome.Value) + "] Grupo=[" + ;
                ALLTRIM(loc_oPg2.txt_4c_Grupo.Value) + "] Conta=[" + ;
                ALLTRIM(loc_oPg2.txt_4c_Conta.Value) + "]" + CHR(13) + CHR(10)

            *-- 7. HabilitarCampos(.F.) trava tudo; (.T.) devolve ao "When"
            loc_oForm.this_cModoAtual = "ALTERAR"
            loc_oForm.HabilitarCampos(.F.)
            loc_cO = loc_cO + "CK08 HabilitarCampos(.F.): Nome.RO=" + ;
                TRANSFORM(loc_oPg2.txt_4c_Nome.ReadOnly) + ;
                " Grupo.RO=" + TRANSFORM(loc_oPg2.txt_4c_Grupo.ReadOnly) + ;
                " Conta.RO=" + TRANSFORM(loc_oPg2.txt_4c_Conta.ReadOnly) + ;
                " Grade.RO=" + TRANSFORM(loc_oPg2.grd_4c_Fases.ReadOnly) + ;
                "  (todos .T.)" + CHR(13) + CHR(10)

            loc_oPg2.txt_4c_Grupo.Value = ""
            loc_oForm.HabilitarCampos(.T.)
            loc_cO = loc_cO + "CK09 HabilitarCampos(.T.) em ALTERAR: Grupo.RO=" + ;
                TRANSFORM(loc_oPg2.txt_4c_Grupo.ReadOnly) + ;
                " DGrupo.RO=" + TRANSFORM(loc_oPg2.txt_4c_DGrupo.ReadOnly) + ;
                " Grade.RO=" + TRANSFORM(loc_oPg2.grd_4c_Fases.ReadOnly) + ;
                "  (esperado .F./.F./.F.)" + CHR(13) + CHR(10)

            *-- 8. Buscar: modo PROCURAR, ficha em branco, grade zerada
            loc_oForm.AlternarPagina(1)
            loc_lRet = loc_oForm.BtnBuscarClick()
            loc_cO = loc_cO + "CK10 BtnBuscarClick=" + TRANSFORM(loc_lRet) + ;
                " modo=[" + loc_oForm.this_cModoAtual + "] ActivePage=" + ;
                TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
                " Nome=[" + ALLTRIM(loc_oPg2.txt_4c_Nome.Value) + "]" + ;
                " fases=" + TRANSFORM(RECCOUNT("cursor_4c_Fases")) + ;
                "  (esperado .T./PROCURAR/2/vazio/0)" + CHR(13) + CHR(10)

            *-- 9. Em PROCURAR o Nome e editavel e Grupo/Conta nao (When)
            loc_cO = loc_cO + "CK11 PROCURAR: Nome.RO=" + ;
                TRANSFORM(loc_oPg2.txt_4c_Nome.ReadOnly) + ;
                " Grupo.RO=" + TRANSFORM(loc_oPg2.txt_4c_Grupo.ReadOnly) + ;
                " Conta.RO=" + TRANSFORM(loc_oPg2.txt_4c_Conta.ReadOnly) + ;
                " Confirmar.Enabled=" + ;
                TRANSFORM(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled) + ;
                "  (esperado .F./.T./.T./.T.)" + CHR(13) + CHR(10)

            *-- 10. msv_procurar: popular a Lista a mao e procurar por nome.
            *--     Sem conexao o Buscar do BO preserva o cursor existente
            *--     (so cria quando nao existe), logo as linhas sobrevivem ao
            *--     CarregarLista do AlternarPagina(1).
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                INSERT INTO cursor_4c_Dados (contas, grupos, nome, cidchaves) ;
                    VALUES ("", "", "AAA PRIMEIRO", "K1")
                INSERT INTO cursor_4c_Dados (contas, grupos, nome, cidchaves) ;
                    VALUES ("", "", "MMM MEIO", "K2")
                INSERT INTO cursor_4c_Dados (contas, grupos, nome, cidchaves) ;
                    VALUES ("", "", "ZZZ ULTIMO", "K3")
            ENDIF

            loc_oForm.this_cModoAtual  = "PROCURAR"
            loc_oPg2.txt_4c_Nome.Value = "MMM MEIO"
            loc_lRet = loc_oForm.BtnSalvarClick()
            loc_cO = loc_cO + "CK12 Confirmar em PROCURAR=" + TRANSFORM(loc_lRet) + ;
                " ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
                " linha=[" + ALLTRIM(TratarNulo(cursor_4c_Dados.nome, "")) + "]" + ;
                " RECNO=" + TRANSFORM(RECNO("cursor_4c_Dados")) + ;
                " SET(NEAR)=" + SET("NEAR") + ;
                "  (esperado .T./1/MMM MEIO/OFF)" + CHR(13) + CHR(10)

            loc_oForm.this_cModoAtual  = "PROCURAR"
            loc_oPg2.txt_4c_Nome.Value = "ZZZZZZZ INEXISTENTE"
            loc_lRet = loc_oForm.BtnSalvarClick()
            loc_cO = loc_cO + "CK13 Procurar nome posterior ao ultimo: EOF=" + ;
                TRANSFORM(EOF("cursor_4c_Dados")) + ;
                " linha=[" + ALLTRIM(TratarNulo(cursor_4c_Dados.nome, "")) + "]" + ;
                "  (esperado .F./ZZZ ULTIMO)" + CHR(13) + CHR(10)

            *-- 11. Confirmar sem Nome tem de RECUSAR (GetNome.Valid do legado)
            loc_oForm.this_cModoAtual  = "INCLUIR"
            loc_oPg2.txt_4c_Nome.Value = ""
            loc_lRet = loc_oForm.BtnSalvarClick()
            loc_cO = loc_cO + "CK14 Confirmar INCLUIR sem nome=" + ;
                TRANSFORM(loc_lRet) + "  (esperado .F.)" + CHR(13) + CHR(10)

            *-- 12. Confirmar com nome mas SEM conexao: recusa, nao estoura
            loc_oPg2.txt_4c_Nome.Value = "DEMO F8"
            loc_oForm.this_cModoAtual  = "INCLUIR"
            loc_oBO.NovoRegistro()
            loc_oForm.InserirLinhaFase()
            loc_lRet = loc_oForm.BtnSalvarClick()
            loc_cO = loc_cO + "CK15 Confirmar INCLUIR sem conexao=" + ;
                TRANSFORM(loc_lRet) + ;
                "  BO.msg=[" + ALLTRIM(loc_oBO.ObterMensagemErro()) + "]" + ;
                "  (esperado .F. com mensagem)" + CHR(13) + CHR(10)

            *-- 13. O BO tem de continuar EM EDICAO depois da falha, para a
            *--     retentativa repetir o INSERT e nao virar UPDATE
            loc_cO = loc_cO + "CK16 apos falha: EmEdicao=" + ;
                TRANSFORM(loc_oBO.this_lEmEdicao) + ;
                " NovoRegistro=" + TRANSFORM(loc_oBO.this_lNovoRegistro) + ;
                "  (esperado .T./.T.)" + CHR(13) + CHR(10)

            *-- 14. VISUALIZAR fecha a ficha sem gravar
            loc_oForm.this_cModoAtual = "VISUALIZAR"
            loc_lRet = loc_oForm.BtnSalvarClick()
            loc_cO = loc_cO + "CK17 Confirmar VISUALIZAR=" + TRANSFORM(loc_lRet) + ;
                " ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
                " modo=[" + loc_oForm.this_cModoAtual + "]" + ;
                "  (esperado .T./1/LISTA)" + CHR(13) + CHR(10)

            *-- 15. Confirmar fora de operacao: avisa e nao faz nada
            loc_oForm.this_cModoAtual = "LISTA"
            loc_lRet = loc_oForm.BtnSalvarClick()
            loc_cO = loc_cO + "CK18 Confirmar em LISTA=" + TRANSFORM(loc_lRet) + ;
                "  (esperado .F.)" + CHR(13) + CHR(10)

            *-- 16. EXCLUIR sem nome na ficha: recusa antes de qualquer DELETE
            loc_oForm.this_cModoAtual  = "EXCLUIR"
            loc_oPg2.txt_4c_Nome.Value = ""
            loc_lRet = loc_oForm.BtnSalvarClick()
            loc_cO = loc_cO + "CK19 Confirmar EXCLUIR sem nome=" + ;
                TRANSFORM(loc_lRet) + "  (esperado .F.)" + CHR(13) + CHR(10)

            *-- 17. GravarFases/ExcluirFases do BO: guardas de argumento
            loc_cO = loc_cO + "CK20 BO.ExcluirFases('')=" + ;
                TRANSFORM(loc_oBO.ExcluirFases("")) + ;
                " msg=[" + ALLTRIM(loc_oBO.ObterMensagemErro()) + "]" + ;
                CHR(13) + CHR(10)
            loc_cO = loc_cO + "CK21 BO.GravarFases('naoexiste','X')=" + ;
                TRANSFORM(loc_oBO.GravarFases("cursor_inexistente_4c", "X")) + ;
                " msg=[" + ALLTRIM(loc_oBO.ObterMensagemErro()) + "]" + ;
                CHR(13) + CHR(10)
            loc_cO = loc_cO + "CK22 BO.GravarFases(cursor,'')=" + ;
                TRANSFORM(loc_oBO.GravarFases("cursor_4c_Fases", "")) + ;
                " msg=[" + ALLTRIM(loc_oBO.ObterMensagemErro()) + "]" + ;
                CHR(13) + CHR(10)

            *-- 18. Cancelar em modo sem confirmacao volta direto para a Lista
            loc_oForm.this_cModoAtual = "VISUALIZAR"
            loc_oForm.AlternarPagina(2)
            loc_oForm.this_cModoAtual = "VISUALIZAR"
            loc_oForm.BtnCancelarClick()
            loc_cO = loc_cO + "CK23 Cancelar em VISUALIZAR: ActivePage=" + ;
                TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
                " modo=[" + loc_oForm.this_cModoAtual + "]" + ;
                " Incluir.Enabled=" + ;
                TRANSFORM(loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled) + ;
                "  (esperado 1/LISTA/.T.)" + CHR(13) + CHR(10)

            *-- 19. Regra #40: nenhum botao CRUD fica cinza na volta
            loc_cO = loc_cO + "CK24 botoes na Lista: Inc/Vis/Alt/Exc/Bus = " + ;
                TRANSFORM(loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled) + "/" + ;
                TRANSFORM(loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled) + "/" + ;
                TRANSFORM(loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled) + "/" + ;
                TRANSFORM(loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled) + "/" + ;
                TRANSFORM(loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled) + ;
                "  (todos .T.)" + CHR(13) + CHR(10)

            *-- 20. Confirmar desabilitado em VISUALIZAR (legado) e ligado nos
            *--     modos que gravam ou excluem
            loc_cNomes = ""
            FOR loc_nI = 1 TO 5
                DO CASE
                    CASE loc_nI = 1
                        loc_oForm.this_cModoAtual = "INCLUIR"
                    CASE loc_nI = 2
                        loc_oForm.this_cModoAtual = "ALTERAR"
                    CASE loc_nI = 3
                        loc_oForm.this_cModoAtual = "EXCLUIR"
                    CASE loc_nI = 4
                        loc_oForm.this_cModoAtual = "VISUALIZAR"
                    OTHERWISE
                        loc_oForm.this_cModoAtual = "PROCURAR"
                ENDCASE
                loc_oForm.AjustarBotoesPorModo()
                loc_cNomes = loc_cNomes + loc_oForm.this_cModoAtual + "=" + ;
                    TRANSFORM(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled) + " "
            ENDFOR
            loc_cO = loc_cO + "CK25 Confirmar.Enabled por modo: " + loc_cNomes + ;
                " (esperado .T. .T. .T. .F. .T.)" + CHR(13) + CHR(10)

            loc_oForm.Release()
            loc_cO = loc_cO + "CK26 Release OK" + CHR(13) + CHR(10)
        ENDIF

    CATCH TO loc_oE2
        loc_cO = loc_cO + "EXCEPTION NO EXERCICIO: " + loc_oE2.Message + ;
            " | Linha: " + TRANSFORM(loc_oE2.LineNo) + ;
            " | Proc: " + loc_oE2.Procedure + CHR(13) + CHR(10)
    ENDTRY

    RETURN loc_cO
ENDFUNC


FUNCTION ChecarPublicos(par_oObj, par_cNomes)
    LOCAL loc_nI, loc_cNome, loc_cOut, loc_nQtd, loc_cRuins
    loc_cOut   = ""
    loc_cRuins = ""
    loc_nQtd   = 0

    FOR loc_nI = 1 TO GETWORDCOUNT(par_cNomes, ",")
        loc_cNome = ALLTRIM(GETWORDNUM(par_cNomes, loc_nI, ","))
        loc_nQtd  = loc_nQtd + 1

        IF !PEMSTATUS(par_oObj, loc_cNome, 5)
            loc_cRuins = loc_cRuins + "     AUSENTE: " + loc_cNome + ;
                CHR(13) + CHR(10)
        ELSE
            IF PEMSTATUS(par_oObj, loc_cNome, 2)
                loc_cRuins = loc_cRuins + "     PROTECTED: " + loc_cNome + ;
                    CHR(13) + CHR(10)
            ENDIF
        ENDIF
    ENDFOR

    loc_cOut = "     " + TRANSFORM(loc_nQtd) + " metodos conferidos; " + ;
        IIF(EMPTY(loc_cRuins), "TODOS existem e sao PUBLIC", "PROBLEMAS:") + ;
        CHR(13) + CHR(10) + loc_cRuins

    RETURN loc_cOut
ENDFUNC


*-- Quantos BINDEVENT de Click o objeto tem registrados
FUNCTION ContarBind(par_oObj)
    LOCAL ARRAY laE[1]
    LOCAL loc_nQtd
    loc_nQtd = AEVENTS(laE, par_oObj)
    RETURN loc_nQtd
ENDFUNC


*-- Subclasse para alcancar os hooks PROTECTED herdados de FormBase
*-- (FormParaBO / BOParaForm / LimparCampos). O VFP9 nao deixa ALARGAR o
*-- escopo na subclasse, logo a UNICA forma de exercita-los e de DENTRO da
*-- classe - ver memoria feedback_formbase_hooks_protected_nao_alargam.
DEFINE CLASS ProbeDmp722 AS FormSigOpDmp
    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

    PROCEDURE ProbeLimparCampos()
        THIS.LimparCampos()
    ENDPROC
ENDDEFINE
