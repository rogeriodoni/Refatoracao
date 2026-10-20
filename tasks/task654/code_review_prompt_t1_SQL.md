# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDOPNUMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, CODS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, CODS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, CODS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, CODS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
		Insert Into crGrvCadRs (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro) ;
		Insert Into crGrvCadRs (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro) ;
		Insert Into crGrvCadRs (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro) ;
		Insert Into crGrvCadRs (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro) ;
	ThisForm.ParentForm.poDatamgr.UpDate('crGrvCadRs')
	ThisForm.ParentForm.poDatamgr.SqlExecute([UpDate SigSyCrs Set ChkSubn = ?llOk Where Cods = ?lnCod])

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCbx.prg) - TRECHOS RELEVANTES PARA PASS SQL (676 linhas total):

*-- Linhas 12 a 30:
12: * pai (Lparameters pcForm, pcCodigo) so para alcancar duas coisas
13: * (ParentForm.Tits e ParentForm.poDataMgr), o form migrado recebe o
14: * titulo diretamente como parametro escalar - o acesso a banco (que no
15: * legado passava por poDataMgr) e feito pelo proprio BO via SQLEXEC.
16: *
17: * Nao segue o padrao PageFrame Page1=Lista/Page2=Dados do CRUD: e um
18: * dialogo pequeno (527x135), sem barra de titulo, com layout FLAT
19: * (container de campos + grupo de botoes), igual ao legado.
20: *
21: * Fase 8/8 (eventos auxiliares e consolidacao final): extrai a transferencia
22: * Form->BO (Text1/Text2/Text3 -> this_cEmps/this_cDopes/this_cNumes) para o
23: * hook canonico FormParaBO() (FormBase, PROTECTED - conteudo REAL, chamado
24: * pelo handler de acao; nao ha BOParaForm nem CarregarLista porque o legado
25: * nao tem fluxo BO->Form nem grade - ver nota de completude junto de
26: * FormParaBO() mais abaixo) e renomeia os dois handlers de clique para o
27: * canonico do projeto, pela ACAO/convencao e nao pelo Caption literal do
28: * legado (mesmo padrao de FormSigOpBcb, que tambem tem um botao Caption
29: * "Baixa" chamado BtnConfirmarClick): BtnBaixaClick() -> BtnConfirmarClick(),
30: * BtnCancelaClick() -> BtnCancelarClick(). Este dialogo e OPERACIONAL

*-- Linhas 69 a 87:
69: *
70: * Fase 4/8 (layout captura): o SCX legado (SIGOPCBX) nao tem Grid nem
71: * PageFrame - layout.json/analise.json confirmam grid.temGrid = .F. e o
72: * unico ControlSource do dump e' o do CommandGroup "SAIDA" (vestigio de
73: * classe, nao lista). Este dialogo apenas COLETA valores (Emp/Operacao/
74: * Numero) e devolve ao chamador - nao ha o que listar, logo nao ha Grid
75: * nem botoes CRUD (Incluir/Alterar/Excluir/Buscar) para acrescentar
76: * nesta fase, sem violar o PILAR 1 (nunca inventar UI que o legado nao
77: * tem). Container1 (campos) e Commandgroup1 (botoes Baixa/Cancela)
78: * continuam agendados para as fases seguintes (5/6 = campos, 7 = eventos
79: * dos botoes).
80: *
81: * Fase 3/8 - Estrutura base: DEFINE CLASS, propriedades, Init(),
82: * InicializarForm() e a faixa do cabecalho (cnt_4c_Sombra). O container
83: * de campos (Container1 -> cnt_4c_Container1) e o grupo de botoes
84: * (Commandgroup1 -> obj_4c_Commandgroup1) sao montados nas proximas
85: * fases.
86: *====================================================================
87: 

*-- Linhas 442 a 472:
442:         ENDIF
443: 
444:         IF USED(loc_cCursor)
445:             USE IN SELECT(loc_cCursor)
446:         ENDIF
447: 
448:         loc_cSQL = "SELECT Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
449:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
450: 
451:         IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
452:             USE IN SELECT(loc_cCursor)
453:             RETURN
454:         ENDIF
455: 
456:         IF USED(loc_cCursor)
457:             USE IN SELECT(loc_cCursor)
458:         ENDIF
459: 
460:         THIS.AbrirLookupEmpresa()
461:     ENDPROC
462: 
463:     *--------------------------------------------------------------------------
464:     * OperacaoKeyPress / OperacaoDblClick - lookup de txt_4c_Text2 (legado:
465:     * Container1.Text2.Valid -> CreateObject('fwBuscaExt', ..., 'SigCdOpe',
466:     * ..., 'Dopes', ...)). PUBLIC: exigido por BINDEVENT (regra CLAUDE.md #3).
467:     *--------------------------------------------------------------------------
468:     PROCEDURE OperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
469:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
470:             THIS.AbrirLookupOperacao()
471:         ELSE
472:             IF par_nKeyCode = 13 OR par_nKeyCode = 9

*-- Linhas 508 a 538:
508:         ENDIF
509: 
510:         IF USED(loc_cCursor)
511:             USE IN SELECT(loc_cCursor)
512:         ENDIF
513: 
514:         loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cValor)
515:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
516: 
517:         IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
518:             USE IN SELECT(loc_cCursor)
519:             RETURN
520:         ENDIF
521: 
522:         IF USED(loc_cCursor)
523:             USE IN SELECT(loc_cCursor)
524:         ENDIF
525: 
526:         THIS.AbrirLookupOperacao()
527:     ENDPROC
528: 
529:     *--------------------------------------------------------------------------
530:     * ConfigurarGrupoBotoes - monta obj_4c_Commandgroup1 (legado
531:     * "Commandgroup1"), com os dois botoes de acao do dialogo:
532:     *   - Buttons(1) "Baixa"   (legado Command1) -> THIS.BtnConfirmarClick()
533:     *   - Buttons(2) "Cancela" (legado Command2) -> THIS.BtnCancelarClick()
534:     *
535:     * Geometria/propriedades EXATAS do dump (SigOpCbx_form_codigo_fonte.txt):
536:     * grupo Top=-3/Left=370/W=160/H=85/BackStyle=0/BorderStyle=0; botoes
537:     * W=75/H=75, FontName="Comic Sans MS", ForeColor=RGB(90,90,90),
538:     * BackColor=RGB(255,255,255), Themes=.F. (canonico de botao DENTRO de


### BO (C:\4c\projeto\app\classes\SigOpCbxBO.prg):
*====================================================================
* SigOpCbxBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGOPCBX" (Baixa de
* Cadastros/respostas ainda em aberto). O legado abre este form como filho
* MODAL de outro form (Lparameters pcForm, pcCodigo), captura Empresa/
* Operacao/Numero, valida a combinacao contra SigMvCab.EmpDopNums e,
* ao clicar "Baixa", grava uma linha de resposta por campo (Emps,
* Dopes, Numes, Baixa) num cursor local do form PAI (crGrvCadRs),
* comita essas respostas e marca SigSyCrs.ChkSubn = .T. para o
* registro ainda nao respondido (SigSyCrs.Cods = pcCodigo).
*
* Nao ha tela de listagem nem edicao de UM registro de SigSyCrs aqui -
* a "entidade" deste dialogo e o conjunto de respostas vinculado ao
* codigo (this_nCodigo) recebido do form pai. A chave primaria mais
* proxima, por completude de contrato com BusinessBase, e cidchaves
* (PK de SigSyCrs) - cada resposta grava a SUA PROPRIA cidchaves nova
* (fUniqueIds()), nunca reaproveitada entre Emps/Dopes/Numes/Baixa.
*
* Referencias legado -> BO:
*   Lparameters pcForm        -> fica no FORM (referencia a objeto UI,
*                                 ThisForm.ParentForm/poDataMgr/Tits)
*   Lparameters pcCodigo      -> this_nCodigo       (SigSyCrs.Cods)
*   Container1.Text1.Value    -> this_cEmps         (SigCdEmp.cEmps)
*   Container1.Text2.Value    -> this_cDopes        (SigCdOpe.Dopes)
*   Container1.Text3.Value    -> this_cNumes        (digitos, PADL 6 na chave)
*   lcEdn (chave posicional)  -> this_cEmpDopNums   (= SigMvCab.EmpDopNums)
*   ThisForm.ParentForm.Tits  -> this_cTitulo       (SigSyCrs.Tits)
*   Usuar (PUBLIC global)     -> this_cUsuario      (resposta do campo "Baixa")
*   Bxado ('B'/'C')           -> this_lBaixaConfirmada
*   crGrvCadRs (cursor local) -> this_cCursorRespostas ("cursor_4c_GrvCadRs")
*
* Herda de: BusinessBase
*
* Fase 2/8 - CarregarDoCursor(), validacao da chave EmpDopNums contra
* SigMvCab, gravacao (Inserir/Atualizar), ObterChavePrimaria() e
* RegistrarAuditoria() (chamada por Inserir/Atualizar).
*====================================================================

DEFINE CLASS SigOpCbxBO AS BusinessBase

    *-- Parametro recebido na abertura do dialogo (legado: Lparameters
    *-- pcForm, pcCodigo - pcForm e referencia de objeto e fica no Form)
    this_nCodigo            = 0    && Codigo do registro pendente - legado "pcCodigo" - SigSyCrs.Cods numeric(6,0)

    *-- Campos digitados pelo usuario (Container1.Text1/Text2/Text3)
    this_cEmps              = ""   && Empresa - lookup SigCdEmp.cEmps (char 3)
    this_cDopes             = ""   && Operacao - lookup SigCdOpe.Dopes (char 20)
    this_cNumes             = ""   && Numero do movimento (so digitos) - PADL(ALLTRIM(...),6) na chave posicional

    *-- Chave posicional de validacao (legado "lcEdn") - regra CLAUDE.md
    *-- #42: PADR/PADL explicito em cada parte, NUNCA ALLTRIM isolado -
    *-- o padding faz parte da chave e eh o que casa com a coluna
    *-- EmpDopNums char(29) de SigMvCab (emps char(3) + dopes char(20) +
    *-- Str(numes,6) = 29)
    this_cEmpDopNums        = ""   && PADR(Emps,3) + PADR(Dopes,20) + PADL(ALLTRIM(Numes),6)

    *-- Dados do registro ainda em aberto, fornecidos pelo form pai (legado
    *-- "ThisForm.ParentForm.Tits"/"Usuar") - necessarios para montar as
    *-- linhas de resposta gravadas em SigSyCrs
    this_cTitulo            = ""   && Legado "ThisForm.ParentForm.Tits" - SigSyCrs.Tits (char 20)
    this_cUsuario           = ""   && Legado "Usuar" (PUBLIC global) - resposta do campo "Baixa"

    *-- Resultado da operacao (legado "Bxado": 'B' = baixou / 'C' = cancelou)
    this_lBaixaConfirmada   = .F.

    *-- Cursor de trabalho local (equivalente ao "crGrvCadRs" do legado:
    *-- buffer das respostas Emps/Dopes/Numes/Baixa antes do UpDate)
    this_cCursorRespostas   = "cursor_4c_GrvCadRs"

    *-- Espelho escalar de UMA linha de SigSyCrs (usado por CarregarDoCursor()/
    *-- Atualizar() quando o BO precisa ler ou corrigir uma resposta JA gravada
    *-- pela sua propria cidchaves - o fluxo principal de gravacao desta tela
    *-- (Inserir(), que cria QUATRO linhas por confirmacao) nao usa estes campos)
    this_cCidChaves         = ""   && SigSyCrs.cidchaves (char 20) - PK da linha carregada
    this_cCampos            = ""   && SigSyCrs.campos (char 10) - nome do campo respondido
    this_cPergs             = ""   && SigSyCrs.pergs (text) - rotulo da pergunta
    this_cResps             = ""   && SigSyCrs.resps (text) - resposta gravada
    this_lChkApro           = .F.  && SigSyCrs.chkapro (bit)
    this_lChkSubn           = .F.  && SigSyCrs.chksubn (bit) - .T. = grupo respondido/submetido

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * Parametro equivalente ao Lparameters pcCodigo do Init do form legado -
    * pcForm (referencia de objeto UI: ParentForm/poDataMgr/Tits) permanece
    * no Form, fora da responsabilidade do Business Object.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nCodigo)
        DODEFAULT("SigSyCrs")

        THIS.this_cCampoChave = "cidchaves"

        IF VARTYPE(par_nCodigo) = "N"
            THIS.this_nCodigo = par_nCodigo
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia TODAS as colunas de SigSyCrs para as properties
    * escalares do BO (this_cCidChaves/this_cCampos/this_cPergs/this_cResps/
    * this_lChkApro/this_lChkSubn + this_nCodigo/this_cTitulo ja existentes).
    *
    * Carrega UMA linha de resposta (uma unica cidchaves) - util para inspecao/
    * correcao de uma resposta ja gravada via Atualizar(). O fluxo principal de
    * gravacao (confirmar a Baixa) cria QUATRO linhas novas em Inserir() e nao
    * depende deste metodo.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCidChaves = TratarNulo(cidchaves, "")
        THIS.this_nCodigo    = TratarNulo(cods, 0)
        THIS.this_cTitulo    = TratarNulo(tits, "")
        THIS.this_cCampos    = TratarNulo(campos, "")
        THIS.this_cResps     = TratarNulo(resps, "")
        THIS.this_cPergs     = TratarNulo(pergs, "")
        THIS.this_lChkApro   = ConverterParaLogico(chkapro)
        THIS.this_lChkSubn   = ConverterParaLogico(chksubn)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Usada por RegistrarAuditoria(). Nao ha uma UNICA
    * cidchaves representando "o registro" desta tela (Inserir() grava quatro
    * linhas, uma por campo respondido) - a chave que identifica a OPERACAO de
    * principio a fim eh o codigo do registro ainda em aberto (this_nCodigo/SigSyCrs.cods).
    * Quando uma linha especifica foi carregada via CarregarDoCursor() (fluxo
    * de Atualizar()), a cidchaves dela e mais precisa e prevalece.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        IF !EMPTY(ALLTRIM(THIS.this_cCidChaves))
            RETURN THIS.this_cCidChaves
        ENDIF

        RETURN TRANSFORM(THIS.this_nCodigo)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Confirma a "Baixa" (legado: Commandgroup1.Command1.Click).
    *
    * 1) Monta a chave posicional EmpDopNums (CLAUDE.md #42: PADR/PADL
    *    EXPLICITO em cada parte - o padding FAZ PARTE da chave e eh o que
    *    casa com SigMvCab.empdopnums char(29) = emps char(3) + dopes char(20)
    *    + numes Str(.,6)).
    * 2) Valida a chave contra SigMvCab (legado: CursorQuery('SigMvCab',
    *    'LocalEest','EmpDopNums', lcEdn,'EmpDopNums') + If Eof('LocalEest')).
    * 3) Grava, num UNICO lote T-SQL com controle de transacao proprio (BEGIN/
    *    COMMIT via SQLEXEC separados NAO protegem - a conexao nasce com
    *    Transactions=2 e @@TRANCOUNT ja vale 1), uma linha em SigSyCrs por
    *    campo respondido (Emps/Dopes/Numes/Baixa - legado: 4x "Insert Into
    *    crGrvCadRs" + "poDatamgr.UpDate('crGrvCadRs')") e a seguir marca TODO
    *    o grupo do codigo ainda em aberto como respondido (legado: "UpDate SigSyCrs
    *    Set ChkSubn = ?llOk Where Cods = ?lnCod").
    *
    * Nota de fidelidade ao legado: a insercao da linha "Baixa" (Resps=Usuario)
    * eh condicionada ao MESMO teste de "Numero nao vazio" da linha "Numes" -
    * o legado reusa a variavel lcVal/Text3.Value nos dois blocos, sem
    * condicao propria para a linha da Baixa. Transcrito literalmente
    * (CLAUDE.md #17/#21b: a condicao que cerca a gravacao e regra, nao
    * detalhe).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cCidEmps, loc_cCidDopes, loc_cCidNumes, loc_cCidBaixa

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + ;
                                    PADR(THIS.this_cDopes, 20) + ;
                                    PADL(ALLTRIM(THIS.this_cNumes), 6)

            IF USED("cursor_4c_SigOpCbxMvCab")
                USE IN cursor_4c_SigOpCbxMvCab
            ENDIF

            loc_cSQL = "SELECT TOP 1 cidchaves FROM SigMvCab WHERE empdopnums = " + ;
                EscaparSQL(THIS.this_cEmpDopNums)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpCbxMvCab")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao consultar a opera" + CHR(231) + CHR(227) + ;
                    "o: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
                THIS.this_lErroExibido = .T.
            ELSE
                IF !USED("cursor_4c_SigOpCbxMvCab") OR EOF("cursor_4c_SigOpCbxMvCab")
                    THIS.this_cMensagemErro = "A opera" + CHR(231) + CHR(227) + "o com o n" + ;
                        CHR(250) + "mero digitado n" + CHR(227) + "o foi encontrada na empresa!"
                    MsgAviso(THIS.this_cMensagemErro, "Baixa de Cadastros")
                    THIS.this_lErroExibido = .T.
                ELSE
                    *-- Regra #22: cidchaves (PK Fortyus) NUNCA reaproveitada entre
                    *-- linhas - uma nova por campo respondido
                    loc_cCidEmps  = EscaparSQL(fUniqueIds())
                    loc_cCidDopes = EscaparSQL(fUniqueIds())
                    loc_cCidNumes = EscaparSQL(fUniqueIds())
                    loc_cCidBaixa = EscaparSQL(fUniqueIds())

                    loc_cSQL = "SET NOCOUNT ON;" + CHR(13) + ;
                        "DECLARE @nivel int = @@TRANCOUNT;" + CHR(13) + ;
                        "IF @nivel = 0 BEGIN TRANSACTION ELSE SAVE TRANSACTION Cop4c;" + CHR(13) + ;
                        "BEGIN TRY" + CHR(13)

                    IF !EMPTY(ALLTRIM(THIS.this_cEmps))
                        loc_cSQL = loc_cSQL + ;
                            "INSERT INTO SigSyCrs (tits, campos, cods, cidchaves, resps, pergs, chkapro, chksubn) VALUES (" + ;
                            EscaparSQL(THIS.this_cTitulo) + ", " + ;
                            EscaparSQL("Emps") + ", " + ;
                            FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                            loc_cCidEmps + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                            EscaparSQL("Empresa") + ", 1, 0);" + CHR(13)
                    ENDIF

                    IF !EMPTY(ALLTRIM(THIS.this_cDopes))
                        loc_cSQL = loc_cSQL + ;
                            "INSERT INTO SigSyCrs (tits, campos, cods, cidchaves, resps, pergs, chkapro, chksubn) VALUES (" + ;
                            EscaparSQL(THIS.this_cTitulo) + ", " + ;
                            EscaparSQL("Dopes") + ", " + ;
                            FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                            loc_cCidDopes + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                            EscaparSQL("Opera" + CHR(231) + CHR(227) + "o") + ", 1, 0);" + CHR(13)
                    ENDIF

                    IF !EMPTY(ALLTRIM(THIS.this_cNumes))
                        loc_cSQL = loc_cSQL + ;
                            "INSERT INTO SigSyCrs (tits, campos, cods, cidchaves, resps, pergs, chkapro, chksubn) VALUES (" + ;
                            EscaparSQL(THIS.this_cTitulo) + ", " + ;
                            EscaparSQL("Numes") + ", " + ;
                            FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                            loc_cCidNumes + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cNumes)) + ", " + ;
                            EscaparSQL("C" + CHR(243) + "digo") + ", 1, 0);" + CHR(13)

                        *-- Legado: a linha "Baixa" reusa o MESMO teste de
                        *-- Text3/Numes (sem condicao propria) - Resps = Usuar
                        loc_cSQL = loc_cSQL + ;
                            "INSERT INTO SigSyCrs (tits, campos, cods, cidchaves, resps, pergs, chkapro, chksubn) VALUES (" + ;
                            EscaparSQL(THIS.this_cTitulo) + ", " + ;
                            EscaparSQL("Baixa") + ", " + ;
                            FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                            loc_cCidBaixa + ", " + ;
                            EscaparSQL(THIS.this_cUsuario) + ", " + ;
                            EscaparSQL("Baixa") + ", 1, 0);" + CHR(13)
                    ENDIF

                    loc_cSQL = loc_cSQL + ;
                        "UPDATE SigSyCrs SET chksubn = 1 WHERE cods = " + ;
                        FormatarNumeroSQL(THIS.this_nCodigo, 0) + ";" + CHR(13) + ;
                        "IF @nivel = 0 COMMIT TRANSACTION;" + CHR(13) + ;
                        "END TRY" + CHR(13) + ;
                        "BEGIN CATCH" + CHR(13) + ;
                        "    IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + CHR(13) + ;
                        "    ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Cop4c; END;" + CHR(13) + ;
                        "    THROW;" + CHR(13) + ;
                        "END CATCH"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Erro ao gravar a baixa: " + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
                        THIS.this_lErroExibido = .T.
                    ELSE
                        THIS.this_lBaixaConfirmada = .T.
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao processar a baixa: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_SigOpCbxMvCab")
            USE IN cursor_4c_SigOpCbxMvCab
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Corrige UMA linha de resposta ja gravada em SigSyCrs,
    * identificada por this_cCidChaves (carregada previamente via
    * CarregarDoCursor()). Nao faz parte do fluxo principal desta tela
    * (Confirmar Baixa sempre grava linhas NOVAS via Inserir()), mas completa
    * o contrato CRUD de BusinessBase para a mesma tabela/chave.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "Registro de resposta n" + CHR(227) + ;
                    "o identificado para altera" + CHR(231) + CHR(227) + "o."
                MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
                THIS.this_lErroExibido = .T.
            ELSE
                loc_cSQL = "UPDATE SigSyCrs SET" + ;
                    " tits    = " + EscaparSQL(THIS.this_cTitulo)        + ", " + ;
                    " campos  = " + EscaparSQL(THIS.this_cCampos)        + ", " + ;
                    " cods    = " + FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                    " resps   = " + EscaparSQL(THIS.this_cResps)         + ", " + ;
                    " pergs   = " + EscaparSQL(THIS.this_cPergs)         + ", " + ;
                    " chkapro = " + IIF(THIS.this_lChkApro, "1", "0")    + ", " + ;
                    " chksubn = " + IIF(THIS.this_lChkSubn, "1", "0")    + ;
                    " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao atualizar a resposta: " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
                    THIS.this_lErroExibido = .T.
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar a resposta: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Baixa de Cadastros")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

