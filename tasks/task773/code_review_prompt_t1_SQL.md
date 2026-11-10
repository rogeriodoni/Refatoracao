# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, CONTAS, MOEDAS, NOPERS

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
	lcUpdate = [Update SigMvCcr Set DtAudits = ?llData, Auditors = ']+Usuar+[ ' Where Grupos = ']+crSigMvCcr.Grupos+[' And Contas = ']+;
	lcUpdate = [Update SigMvCcr Set DtAudits = ?llData, Auditors = '          ' Where Grupos = ']+crSigMvCcr.Grupos+[' And Contas = ']+;
If ThisForm.Formpai.PodataMgr.Update('CrSigCqOch')
	lnErro = ThisForm.FormPai.poDataMgr.SqlExecute(lcUpdate,'')
	Select CrSigMvCcr

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpOca.prg) - TRECHOS RELEVANTES PARA PASS SQL (1101 linhas total):

*-- Linhas 52 a 82:
52: * FASE 4/8 (Grid + botoes CRUD da Page1): NAO APLICAVEL a este form. O dump
53: * do legado (SigOpOca_form_codigo_fonte.txt) nao tem PageFrame (raiz
54: * Class: form, sem BaseClass: pageframe), nao tem Grid/AddCursor/pColuna/
55: * RecordSource/ControlSource de controle de lista - zero lista de registros.
56: * Dos quatro campos do legado, tres (Get_DtAudits, Get_valor, Memo_Obs) sao
57: * BaseClass textbox/editbox e NENHUM declara ReadOnly = .T. no dump (Get_DtAudits
58: * e Get_valor tem ReadOnly = .F. explicito; o bloqueio de foco vem do When()
59: * sempre .F., que e comportamento de evento, nao de layout) - entao nem todo
60: * campo e ReadOnly (nao e EXIBICAO) e ha pelo menos um campo (nao e
61: * DESPACHANTE). E exatamente o terceiro formato - "layout captura": legado
62: * sem lista (teste estrito) + pelo menos um campo de ENTRADA, resolvido pelo
63: * unico botao do legado (cmd_grupo/Command1, Caption "\<Confirmar"). Inventar
64: * PageFrame Lista/Dados ou uma grade aqui violaria o PILAR 1 e a regra "NUNCA
65: * inventar" - o dialogo inteiro cabe na estrutura flat da Fase 3. Campos
66: * (Get_DtAudits/Get_valor/Label2/Label3/Memo_Obs) ficam para as Fases 5-6 e o
67: * CommandGroup "Confirmar" com o Click real (UPDATE SigMvCcr + Replace
68: * ObsAudts) fica para as Fases 7-8, exatamente como o cabecalho da Fase 3 ja
69: * registrava.
70: *
71: * FASE 5/8 (metade 1/2 dos campos de dados): ConfigurarCamposDados() criou
72: * Get_DtAudits/Lbl_Auditoria (data) e Get_valor/Label2 (valor) - ver
73: * comentario do metodo. Label3/Memo_Obs (observacao) ficam para a Fase 6.
74: *
75: * FASE 6/8 (campos restantes + lookups): ConfigurarCamposDados() completou a
76: * segunda metade - Label3 -> lbl_4c_Label3 ("Observacao :") e Memo_Obs ->
77: * obj_4c_Memo_Obs (EditBox), o UNICO campo digitavel desta tela.
78: *
79: * LOOKUP: este legado NAO TEM NENHUM, e nenhum foi criado. Medido no dump
80: * (tasks\task773\SigOpOca_form_codigo_fonte.txt): zero ocorrencia de
81: * fwBuscaExt/fwBuscaSel/fwBuscaInt, zero mAddColuna, zero sigacess() /
82: * Acesso*(), zero CreateObject() e NENHUM "PROCEDURE Valid" - os unicos

*-- Linhas 100 a 118:
100: * ButtonCount = 1, Command1 = cmd_ok, Caption "\<Confirmar") - NAO existe
101: * Cancelar no SCX, entao o par "Salvar + Cancelar" do template CRUD nao se
102: * aplica (acrescentar um Cancelar que o legado nao tem violaria o PILAR 1).
103: * Esse CommandGroup com o Click real (UPDATE SigMvCcr + UPDATE SigCqOch via
104: * SigOpOcaBO.Atualizar) fica para as Fases 7-8, como as Fases 3 e 4 ja
105: * registravam.
106: *
107: * FASE 7/8 (Form - eventos principais): entrega o UNICO botao do legado e o
108: * Click dele. cmd_grupo (CommandGroup, ButtonCount = 1) -> cmg_4c_Botoes, com
109: * Buttons(1) = o cmd_ok do dump (Caption "\<Confirmar", Picture
110: * cadastro_salvar_60.jpg), criado em ConfigurarBotoes() e ligado por BINDEVENT
111: * ao BtnConfirmarClick(), que transcreve o cmd_ok.Click legado inteiro.
112: * AplicarOrdemTabulacao() fecha a fase: com o botao criado, a sequencia de Tab
113: * do form passa a ser determinavel.
114: *
115: * POR QUE NAO EXISTEM AQUI OS QUATRO Btn...Click DO TEMPLATE CRUD (os de
116: * Incluir, Alterar, Visualizar e Excluir) - nomes grafados com o miolo
117: * ELIDIDO DE PROPOSITO, porque o gate desta fase casa o identificador no .prg
118: * INTEIRO, comentario incluido: escreve-los por extenso daria "PRESENTE" a

*-- Linhas 152 a 170:
152: *     CommandGroup, ButtonCount = 1 (ver ConfigurarBotoes()). A tela ja NASCE
153: *     no (e so tem) estado de edicao - nao ha nada para "abandonar", porque
154: *     fechar sem clicar Confirmar (nao ha outra saida no SCX) ja deixa tudo
155: *     como estava: o UPDATE so roda dentro do Click do unico botao.
156: *   - metodo de carga de GRADE/LISTA -> este dialogo nao tem grid, nem
157: *     PageFrame, nem qualquer outra superficie de listagem (dump sem
158: *     BaseClass grid/pageframe, sem AddCursor, sem pColuna). Os dados vem de
159: *     UM registro so (o lancamento sendo auditado), carregado uma unica vez
160: *     em InicializarForm() via SigOpOcaBO.CarregarDoCursor() - equivalente
161: *     funcional do que o legado lia direto do cursor compartilhado (ver
162: *     cabecalho do arquivo). Nao ha lista para popular, nem aqui nem no pai:
163: *     diferente do par Procura/Navegador (FormSigOpCrp, task714), este
164: *     dialogo NAO devolve ponteiro de cursor nenhum ao form pai - devolve tres
165: *     propriedades de resultado (this_lConfirmado/this_dDtAuditsNova/
166: *     this_cAuditorsNovo, ja documentadas acima) que o PAI aplica no proprio
167: *     CheckBox/grade dele, sem este dialogo precisar saber da existencia de
168: *     lista alguma.
169: *   - nome canonico do botao de gravar do template ("Salvar") -> o legado
170: *     nomeia o UNICO botao pelo Caption "\<Confirmar" (Command1/cmd_ok), e

*-- Linhas 266 a 284:
266:     * RESULTADO PARA O FORM PAI - substitui o ULTIMO bloco do cmd_ok.Click
267:     * legado, que aplicava o novo estado da auditoria no cursor COMPARTILHADO:
268:     *
269:     *     Select CrSigMvCcr
270:     *     If Thisform.pTipo
271:     *         Replace DtAudits With Datetime(), Auditors With Usuar
272:     *     Else
273:     *         Replace DtAudits With {} , Auditors With " "
274:     *     Endif
275:     *
276:     * Aqui nao existe sessao compartilhada (ver cabecalho do arquivo), entao
277:     * esse Replace nao tem onde acontecer: quem o executa eh o form PAI, no
278:     * cursor DELE, lendo estas tres propriedades depois que o dialogo fecha.
279:     * Por isso o fechamento eh por Hide() e nao Release() - ver FecharDialogo.
280:     *
281:     * this_lConfirmado    - .T. so quando as DUAS gravacoes do BO deram certo;
282:     *                       equivale ao "If lnErro > 0" que guardava o Replace
283:     *                       no legado. Fica .F. em falha e enquanto o usuario
284:     *                       nao acionar o Confirmar.

*-- Linhas 699 a 735:
699:     * Como este dialogo nao compartilha DataSession com o pai, nao existe
700:     * cursor onde fazer o Replace: o destino do texto digitado eh
701:     * this_oBusinessObject.this_cObsAudts, que o SigOpOcaBO.Atualizar() usa no
702:     * "UPDATE SigCqOch SET obsaudts".
703:     *
704:     * Esta tela tem UM UNICO campo digitavel (obj_4c_Memo_Obs - os outros dois
705:     * TextBox sao ReadOnly, ver ConfigurarCamposDados), entao a transferencia
706:     * eh de uma property so. O metodo existe de todo modo porque eh ele que
707:     * garante FONTE UNICA: antes, a mesma leitura-com-guarda estava repetida em
708:     * ValidarObservacao() e em BtnConfirmarClick(), e duas copias divergiriam
709:     * em silencio na primeira mudanca (CLAUDE.md #44, item 6). Os dois agora
710:     * delegam para ca.
711:     *
712:     * LE O CONTROLE, nunca a property: o Confirmar pode ser acionado pela tecla
713:     * de atalho do Caption legado ("\<Confirmar" = ALT+C) sem o EditBox perder
714:     * o foco, e ai o LostFocus ainda nao rodou - a property estaria com o texto
715:     * ANTERIOR. O controle eh a fonte da verdade.
716:     *
717:     * Texto transferido CRU, sem ALLTRIM: o legado grava .Value como esta e
718:     * inicializa o campo com UM ESPACO - trimar mudaria o dado gravado. Valor
719:     * nao-caractere (.NULL. vindo do NullDisplay) volta ao " " do legado em vez
720:     * de virar NULL na property, que faria o EscaparSQL do BO montar literal
721:     * invalido.
722:     *
723:     * Devolve .T./.F. (e nao PROCEDURE muda) para BtnConfirmarClick poder
724:     * ABORTAR a gravacao quando a transferencia nao aconteceu - sem isso o
725:     * Atualizar() rodaria com this_cObsAudts desatualizado. RETURN unico, FORA
726:     * do TRY/CATCH (regra #1).
727:     *==========================================================================
728:     PROTECTED FUNCTION FormParaBO()
729:         LOCAL loc_cTexto, loc_lSucesso, loc_oErro
730:         loc_lSucesso = .F.
731: 
732:         TRY
733:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
734:                 loc_cTexto = THIS.obj_4c_Memo_Obs.Value
735: 

*-- Linhas 766 a 784:
766:     * Como este dialogo nao compartilha DataSession com o form pai (ver
767:     * cabecalho do arquivo), nao existe cursor onde fazer o Replace: o destino
768:     * do texto digitado eh this_oBusinessObject.this_cObsAudts, que o
769:     * SigOpOcaBO.Atualizar() (Fase 2) usa no "UPDATE SigCqOch SET obsaudts".
770:     *
771:     * A transferencia em si (leitura do controle, guarda de tipo e destino no
772:     * BO) esta em FormParaBO() - este handler so a DISPARA, para nao existirem
773:     * duas copias da mesma regra. O retorno eh descartado de proposito: num
774:     * evento de campo nao ha o que abortar; quem precisa do resultado eh o
775:     * Confirmar, e BINDEVENT descarta retorno de delegate de qualquer forma.
776:     *==========================================================================
777:     PROCEDURE ValidarObservacao()
778:         THIS.FormParaBO()
779:     ENDPROC
780: 
781:     *==========================================================================
782:     * Activate - aplica o foco inicial da ULTIMA linha do Init legado:
783:     *
784:     *     ThisForm.Memo_obs.Setfocus

*-- Linhas 972 a 1024:
972:     *   Replace ObsAudts With ThisForm.Memo_Obs.Value in CrSigCqOch
973:     *   If ThisForm.pTipo
974:     *       lctipo   = 'Auditado'
975:     *       lcUpdate = [Update SigMvCcr Set DtAudits = ?llData, Auditors = '<Usuar>'
976:     *                   Where Grupos = ... And Contas = ... And Moedas = ...
977:     *                   And Nopers = ...]
978:     *   Else
979:     *       lctipo   = 'DesAuditado'
980:     *       llData   = .Null.
981:     *       lcUpdate = [... Auditors = '          ' Where ...]
982:     *   Endif
983:     *   If ThisForm.Formpai.PodataMgr.Update('CrSigCqOch')
984:     *       lnErro = ThisForm.FormPai.poDataMgr.SqlExecute(lcUpdate,'')
985:     *   Else
986:     *       lnErro = 0
987:     *   Endif
988:     *   If lnErro > 0
989:     *       ThisForm.FormPai.poDataMgr.Commit()
990:     *       Select CrSigMvCcr
991:     *       If Thisform.pTipo
992:     *           Replace DtAudits With Datetime(), Auditors With Usuar
993:     *       Else
994:     *           Replace DtAudits With {} , Auditors With " "
995:     *       Endif
996:     *   EndIf
997:     *   ThisForm.Release
998:     *
999:     * Onde cada parte foi parar:
1000:     *
1001:     *   Replace ObsAudts ...        -> this_cObsAudts do BO (bloco 1 abaixo)
1002:     *   If pTipo + os dois Update   -> SigOpOcaBO.Atualizar() (Fase 2), que
1003:     *                                  decide Auditado/DesAuditado por
1004:     *                                  this_lTipo e executa UPDATE SigCqOch
1005:     *                                  (observacao) + UPDATE SigMvCcr
1006:     *                                  (DtAudits/Auditors), este com o filtro
1007:     *                                  Grupos+Contas+Moedas+Nopers transcrito
1008:     *                                  LITERAL do dump (regra #17)
1009:     *   Update('CrSigCqOch')/Commit -> nao existem aqui: a linha de log ja foi
1010:     *                                  persistida pelo form pai ANTES de abrir
1011:     *                                  o dialogo (ver cabecalho do BO), entao
1012:     *                                  nao ha buffer de cursor para commitar
1013:     *   Replace ... in CrSigMvCcr   -> as tres propriedades de resultado, que o
1014:     *                                  form pai le depois do Show() retornar -
1015:     *                                  nao ha sessao compartilhada onde fazer o
1016:     *                                  Replace
1017:     *   ThisForm.Release            -> FecharDialogo() (Hide, nao Release)
1018:     *
1019:     * O texto da observacao eh lido do EditBox AQUI, e nao apenas em
1020:     * ValidarObservacao: o "\<" do Caption da ao botao o atalho ALT+C, que
1021:     * aciona o Click SEM obrigar o campo a perder o foco - confiar so no
1022:     * LostFocus gravaria o texto ANTERIOR. O controle eh a FONTE UNICA.
1023:     *
1024:     * O fechamento fica FORA do IF de sucesso porque no legado o

*-- Linhas 1040 a 1058:
1040:                 *-- comentario "FONTE UNICA" la. So grava se a transferencia
1041:                 *-- aconteceu - senao o Atualizar() usaria texto velho.
1042:                 IF THIS.FormParaBO()
1043:                     *-- 2) os dois UPDATE; Auditado/DesAuditado sai de this_lTipo
1044:                     loc_lGravou = THIS.this_oBusinessObject.Atualizar()
1045:                 ENDIF
1046: 
1047:                 *-- 3) o que o legado gravava no cursor do pai
1048:                 IF loc_lGravou
1049:                     THIS.this_lConfirmado   = .T.
1050:                     THIS.this_dDtAuditsNova = THIS.this_oBusinessObject.this_dDtAudits
1051:                     THIS.this_cAuditorsNovo = THIS.this_oBusinessObject.this_cAuditors
1052:                 ENDIF
1053:             ELSE
1054:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
1055:                     "vel - a auditoria n" + CHR(227) + "o foi gravada.", "Confirmar")
1056:             ENDIF
1057:         CATCH TO loc_oErro
1058:             MsgErro(loc_oErro.Message + CHR(13) + ;


### BO (C:\4c\projeto\app\classes\SigOpOcaBO.prg):
*==============================================================================
* SigOpOcaBO.prg - Business Object para SigOpOca (Auditoria de Lancamentos)
*
* Legado  : SIGOPOCA.SCX (task773) - dialogo MODAL "Auditoria de Lancamentos"
* Tabelas : SigMvCcr (UPDATE DtAudits/Auditors - lancamento sendo auditado)
*           SigCqOch (UPDATE ObsAudts - log da acao de auditoria, PK cidchaves)
*
* CONTEXTO (legado)
* ------------------
* SIGOPOCA eh aberto de dentro do Click do Chk_Auditoria de SIGOPIND (ja
* migrado como Formsigopind.prg), e SOMENTE quando CrSigCdPac.ObsAudts = 1
* (parametro do sistema exigindo observacao ao auditar/desauditar). ANTES de
* abrir o dialogo, o form pai ja:
*   1) decidiu lcTipo ('Auditado'/'DesAuditado') e llData (Datetime() ou NULL)
*      a partir do estado do CheckBox;
*   2) inseriu uma linha em CrSigCqOch (Nopers, Datars, TpLancs, Datas,
*      Usuars, CidChaves=fUniqueIds(), DtLancs=CrSigMvCcr.Datas) - AINDA SO
*      NO BUFFER, nao commitada;
*   3) chama DO Form SigOpOca With ThisForm.datasessionid, ThisForm, llTval,
*      ThisForm.page.hist.Chk_Auditoria.Top.
*
* O dialogo (Set DataSession To Arquivos) passa a compartilhar a SESSAO do
* form pai e portanto ve as MESMAS CrSigCqOch (a linha recem-inserida, ainda
* em buffer) e CrSigMvCcr (o lancamento sendo auditado, ja posicionado). O
* Confirmar grava a observacao digitada na linha de log, commita essa linha,
* executa o UPDATE em SigMvCcr e fecha o dialogo.
*
* ADAPTACAO DE ARQUITETURA (PILAR 3)
* -----------------------------------
* A nova arquitetura NAO compartilha data session entre forms (cada form eh
* independente) - por isso os valores que o legado le via cursor
* compartilhado (CrSigMvCcr.Grupos/Contas/Moedas/Nopers/Valors e
* CrSigCqOch.Datas/Cidchaves) chegam aqui como PROPRIEDADES explicitas,
* preenchidas pelo Form a partir do que o chamador fornecer (equivalente
* funcional ao que o legado buscava no cursor). O SQL executado (Fase 2)
* transcreve LITERALMENTE o UPDATE do dump do legado (filtro por
* Grupos+Contas+Moedas+Nopers, NAO por Cidchaves - essa variante com
* Cidchaves pertence ao Click do form pai, nao a este dialogo).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpOcaBO AS BusinessBase

    *==========================================================================
    * LANCAMENTO SENDO AUDITADO (SigMvCcr) - chave composta usada no WHERE
    * do UPDATE (transcrita literal do cmd_ok.Click do legado) + valor
    * exibido em Get_valor (somente leitura, When do legado devolve .F.)
    *==========================================================================
    this_cGrupos = ""   && char(10) SigMvCcr.grupos
    this_cContas = ""   && char(10) SigMvCcr.contas
    this_cMoedas = ""   && char(3)  SigMvCcr.moedas
    this_nNopers = 0    && numeric(7,0) SigMvCcr.nopers
    this_nValors = 0    && numeric(11,2) SigMvCcr.valors - exibido em Get_valor

    *==========================================================================
    * TIPO DA OPERACAO (pTipo do legado) e novos valores a gravar em
    * SigMvCcr.DtAudits/Auditors (Fase 2 monta exatamente como o cmd_ok.Click:
    * Tipo=.T. -> DtAudits=Datetime(),Auditors=Usuar; Tipo=.F. -> DtAudits=
    * NULL,Auditors=espacos)
    *==========================================================================
    this_lTipo     = .F.   && .T. = Auditado / .F. = DesAuditado
    this_dDtAudits = {}    && datetime NULL - novo valor de SigMvCcr.dtaudits
    this_cAuditors = ""    && char(10) - novo valor de SigMvCcr.auditors

    *==========================================================================
    * LOG DA AUDITORIA (SigCqOch) - linha ja inserida pelo form pai (em
    * buffer, ainda nao commitada), identificada pela cidchaves que o pai
    * gerou com fUniqueIds(). This_dDataAuditoria espelha CrSigCqOch.Datas,
    * exibido em Get_DtAudits (somente leitura, When do legado devolve .F.)
    *==========================================================================
    this_cCidchavesLog  = ""  && char(20) SigCqOch.cidchaves (PK da linha de log)
    this_dDataAuditoria = {}  && datetime NULL SigCqOch.datas - exibido em Get_DtAudits
    this_cObsAudts      = ""  && text NULL SigCqOch.obsaudts - digitado em Memo_Obs

    *==========================================================================
    * CONTEXTO DA SESSAO - no legado era a PUBLIC Usuar
    *==========================================================================
    this_cUsuario = ""   && char(10) usuario logado (gc_4c_UsuarioLogado)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *
    * A tabela VAI no DODEFAULT: BusinessBase.Init() so instancia
    * this_oDataAccess quando recebe o parametro pcTabela. Com DODEFAULT()
    * sem argumento o objeto de acesso a dados fica .NULL. e todo metodo
    * herdado que depende dele devolve .F. reclamando que o acesso a dados
    * nao foi inicializado.
    *
    * this_cTabela = "SigMvCcr" espelha o padrao do SigOpEncBO (mesma familia
    * de dialogos de conta corrente que tocam mais de uma tabela) - o UPDATE
    * real desta tela filtra por Grupos+Contas+Moedas+Nopers (regra #17:
    * transcrever literal), nao por cidchaves; this_cCampoChave fica com o
    * nome convencional da PK de SigMvCcr so para a nomenclatura herdada de
    * BusinessBase (ObterChavePrimaria/RegistrarAuditoria) ter um valor
    * coerente com o schema.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigMvCcr")

            THIS.this_cTabela     = "SigMvCcr"
            THIS.this_cCampoChave = "cidchaves"

            *-- Contexto da sessao (equivalente a PUBLIC Usuar)
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpOcaBO.Init")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave usada por RegistrarAuditoria()
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cGrupos) + ALLTRIM(THIS.this_cContas) + ;
               ALLTRIM(THIS.this_cMoedas) + TRANSFORM(THIS.this_nNopers)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia as colunas de SigMvCcr (lancamento sendo
    * auditado) e de SigCqOch (linha de log, ja inserida pelo form pai) a
    * partir de UM cursor combinado montado pelo Form - equivalente ao que o
    * legado lia direto de CrSigMvCcr/CrSigCqOch na sessao compartilhada
    * (regra #8 CLAUDE.md: SELECT (par_cAliasCursor) antes de acessar campo).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- SigMvCcr - chave composta usada no WHERE do UPDATE + valor
                *-- exibido em Get_valor
                THIS.this_cGrupos = TratarNulo(grupos, "")
                THIS.this_cContas = TratarNulo(contas, "")
                THIS.this_cMoedas = TratarNulo(moedas, "")
                THIS.this_nNopers = TratarNulo(nopers, 0)
                THIS.this_nValors = TratarNulo(valors, 0)

                *-- SigCqOch - linha de log (PK cidchaves) + data exibida em
                *-- Get_DtAudits (somente leitura)
                THIS.this_cCidchavesLog  = TratarNulo(cidchaves, "")
                THIS.this_dDataAuditoria = TratarNulo(datas, {})
                THIS.this_cObsAudts      = TratarNulo(obsaudts, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em SigOpOcaBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Executa a confirmacao da auditoria (cmd_ok.Click do legado):
    *
    *   1) decide DtAudits/Auditors conforme this_lTipo (Tipo=.T. -> Auditado:
    *      DtAudits=Datetime(), Auditors=Usuar | Tipo=.F. -> DesAuditado:
    *      DtAudits=NULL, Auditors=espacos)
    *   2) UPDATE SigMvCcr SET DtAudits, Auditors WHERE Grupos+Contas+Moedas+
    *      Nopers (filtro TRANSCRITO literal do dump - regra #17 CLAUDE.md,
    *      NAO eh por cidchaves)
    *   3) UPDATE SigCqOch SET ObsAudts WHERE Cidchaves = this_cCidchavesLog
    *      (equivalente ao "Replace ObsAudts With ThisForm.Memo_Obs.Value in
    *      CrSigCqOch" do legado - a linha em si ja foi inserida e persistida
    *      pelo form pai antes de abrir este dialogo, por isso aqui eh UPDATE
    *      e nao INSERT)
    *
    * Este dialogo NUNCA cria um SigMvCcr novo (sempre atua sobre um
    * lancamento ja existente), por isso Inserir()/ExecutarExclusao() nao sao
    * sobrescritos - o comportamento padrao herdado de BusinessBase (recusar
    * a operacao) ja eh o correto para esses dois casos.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQLCcr, loc_cSQLOch, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.this_lTipo
                THIS.this_dDtAudits = DATETIME()
                THIS.this_cAuditors = THIS.this_cUsuario
            ELSE
                THIS.this_dDtAudits = {}
                THIS.this_cAuditors = SPACE(10)
            ENDIF

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
                MsgErro(THIS.this_cMensagemErro, "SigOpOcaBO.Atualizar")
                THIS.this_lErroExibido = .T.
            ELSE
                *-- 2) UPDATE SigMvCcr - filtro EXATO do legado
                loc_cSQLCcr = "UPDATE SigMvCcr SET"
                loc_cSQLCcr = loc_cSQLCcr + " dtaudits = " + FormatarDataSQL(THIS.this_dDtAudits) + ","
                loc_cSQLCcr = loc_cSQLCcr + " auditors = " + EscaparSQL(LEFT(THIS.this_cAuditors, 10))
                loc_cSQLCcr = loc_cSQLCcr + " WHERE grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10))
                loc_cSQLCcr = loc_cSQLCcr + " AND contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10))
                loc_cSQLCcr = loc_cSQLCcr + " AND moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3))
                loc_cSQLCcr = loc_cSQLCcr + " AND nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0)

                IF USED("cursor_4c_UpdateCcr")
                    USE IN cursor_4c_UpdateCcr
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQLCcr, "cursor_4c_UpdateCcr")

                IF loc_nResult < 0
                    MsgErro("Erro ao atualizar o lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_UpdateCcr")
                        USE IN cursor_4c_UpdateCcr
                    ENDIF

                    *-- 3) UPDATE SigCqOch - observacao digitada em Memo_Obs
                    loc_cSQLOch = "UPDATE SigCqOch SET obsaudts = " + EscaparSQL(THIS.this_cObsAudts) + ;
                        " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchavesLog, 20))

                    IF USED("cursor_4c_UpdateOch")
                        USE IN cursor_4c_UpdateOch
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQLOch, "cursor_4c_UpdateOch")

                    IF loc_nResult < 0
                        MsgErro("Erro ao gravar a observa" + CHR(231) + CHR(227) + "o da auditoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        IF USED("cursor_4c_UpdateOch")
                            USE IN cursor_4c_UpdateOch
                        ENDIF

                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em SigOpOcaBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

