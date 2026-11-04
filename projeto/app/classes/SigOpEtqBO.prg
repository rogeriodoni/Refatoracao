*==============================================================================
* SigOpEtqBO.prg
*
* Business Object para SigOpEtq (Consulta Etiquetas nao lidas)
*
* Tabela SigOpEtq EXISTE no schema (PK cbars numeric(14,0)), mas este BO nao
* a consulta nem a grava. SigOpEtq.SCX eh o dialogo FILHO que o RELATORIO DE
* INVENTARIO (SIGREINR) abre quando o usuario escolhe o tipo de relatorio 5:
*
*     Do Form SigOpEtq With ThisForm
*
* CORRECAO DE FATO (fase final da task732): este cabecalho dizia, desde a
* Fase 1, que o pai era o "SigMvCab, movimentacao de itens", e citava
* sigmvcab.SCT. Estava ERRADO - foi palpite feito antes de o chamador ser
* procurado. Varridos os dumps de tasks\, a linha "Do Form SigOpEtq With
* ThisForm" aparece em UM unico arquivo, tasks\task125\
* sigreinr_form_codigo_fonte.txt, em quatro metodos dele (visualizacao,
* memail, impressao e documento), sempre no ramo TipoRelatorio.Value = 5.
* O SigMvCab nao chama esta tela em lugar nenhum. Deixar a frase antiga
* mandaria quem fosse diagnosticar a tela abrir o form errado.
*
* O form legado recebe UM parametro (pForm = form PAI), copia
* pForm.poDataMgr para si mesmo e liga a grade a um cursor que o PAI JA
* montou. O nome desse alias NAO eh "cursor_4c_Relatorio": o chamador
* migrado (sigreinrBO) PRESERVOU o nome legado e publica
* this_cCursorDados = "CsRelatorio". O valor abaixo eh so o DEFAULT para
* quando a tela eh instanciada fora do fluxo do chamador - quem resolve o
* alias de verdade eh FormSigOpEtq.ResolverCursorDaGrade(), em runtime, e
* escreve o resultado nesta property. Nao ha
* NENHUM SQLEXEC/AddCursor/Select...Into Cursor dentro do dump de SigOpEtq -
* confirmado em tasks\task732\comportamento.json (sqlQueries: [], totalQueries:
* 0). O Init so faz "Select csRelatorio / Go Top / Grade.Refresh".
*
* Dai o escopo deste BO: ele NAO consulta SigOpEtq (nem SigCdPro, de onde vem
* a descricao exibida na grade). Quem monta e popula o cursor eh o form PAI,
* antes de abrir esta tela. Tudo o que este BO faz eh LEITURA/NAVEGACAO no
* cursor recebido:
*
*   SIGOPETQ.Init                 copia Caption para os 2 labels da faixa,
*                                 liga poDataMgr, reposiciona a grade (Go Top
*                                 + Refresh) e foca a 1a celula
*   GetBusca.Valid                Seek por codigo de barras (CBars) no
*                                 cursor; nao achando, volta para o Recno
*                                 anterior (NAO limpa nem avisa)
*   GetBusca.LostFocus            Grade.Refresh + foca a 1a celula de novo
*   cmdEtiquetas (btnEtiquetas)   Do Form SigOpIpE With ThisForm (dialogo
*                                 NETO, cujo SCX segue em ProximasMigracoes\
*                                 - fora do escopo desta task)
*   cmdImprimir (btnImprimir)     Do Form SigMvDoc With SIGOPETQ + titulo
*                                 (impressao via form generico de documentos;
*                                 no sistema novo o ramo generico eh
*                                 FormSigOpEtqDoc, e os dois argumentos vem
*                                 das properties this_cArquivoRelatorio e
*                                 this_cTituloRelatorio deste BO)
*   Saida.Click                   ThisForm.Release, e mais nada - esta tela
*                                 nao desabilita o chamador ao abrir, logo
*                                 nao ha nada a reabilitar na saida. O
*                                 chamador (sigreinrBO.Visualizar/Imprimir)
*                                 segue vivo e volta a usar o cursor, por
*                                 isso nem o form nem este BO fecham um alias
*                                 que receberam de fora
*
* Por isso Inserir(), Atualizar() e ExecutarExclusao() ficam SEM override: o
* comportamento padrao herdado de BusinessBase (recusar a operacao e reportar
* pelo ExibirFalha do Salvar) ja eh o correto, porque esta tela nao grava
* nada - inventar INSERT/UPDATE aqui violaria a regra #22 do CLAUDE.md (a
* lista de colunas vem do schema, nunca de adivinhacao, e aqui nem ha
* operacao de escrita no dump para adivinhar). RegistrarAuditoria() fica
* herdado pelo mesmo motivo: a base so o chama em operacao de ESCRITA.
* ObterChavePrimaria() EH sobrescrito, porque a linha corrente da grade tem
* identidade - o codigo de barras (CsRelatorio.CBars).
*
* ESTRUTURA DO CURSOR DA GRADE (contrato com o form PAI)
* -------------------------------------------------------
* O csRelatorio que o PAI entrega (dump SIGOPETQ.Grade, 4 colunas):
*
*   CBars   <- codigo de barras da etiqueta (SigOpEtq.cbars numeric(14,0))
*   Datas   <- data de entrada/consulta da etiqueta (datetime)
*   DPros   <- descricao do produto (SigCdPro.dpros char(65), via JOIN
*              feito pelo PAI)
*   pLocals <- local do produto (SigOpEtq.locals char(10), idem acima)
*
* O Seek do GetBusca.Valid usa a TAG CBars - Seek(lcProd, csRelatorio,
* CBars) - logo o PAI tambem cria esse indice no cursor. Quando o pai NAO
* entrega o cursor, quem o cria (VAZIO, com esta MESMA estrutura e esta MESMA
* ordem de campos) eh GarantirCursorRelatorio() deste BO - fonte UNICA do
* CREATE CURSOR, para o placeholder da grade nunca divergir do cursor
* populado.
*
* DUAS CONDICOES DE CONTORNO DO CONTRATO
* --------------------------------------
* 1) O form migrado tem de ficar com DataSession = 1 (o default). Medido no
*    VFP9: DataSession = 1 significa a sessao CORRENTE, entao o dialogo roda
*    na sessao do pai e VE o cursor dele. DataSession = 2 criaria sessao
*    privada e o alias do pai ficaria invisivel - a grade abriria vazia.
* 2) Quem NAO criou o cursor nao pode fecha-lo: fechar o alias do pai
*    quebraria a tela de tras. Por isso this_lCursorProprio registra a
*    origem, e o Destroy() so fecha o que este BO mesmo criou.
*
* Fase 1/8 - declaracao das propriedades e Init().
* Fase 2/8 - CarregarDoCursor, ObterChavePrimaria, LimparDados, Destroy e os
*            metodos de navegacao/busca que espelham Init/Valid do legado.
*==============================================================================

DEFINE CLASS SigOpEtqBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Cursor da grade, recebido PRONTO do form PAI (csRelatorio no legado)
    *
    * this_cCursorRelatorio eh o alias que a grade consome. this_cTagBarras
    * guarda o nome da TAG usada no Seek por codigo de barras - mesmo nome
    * usado pelo GetBusca.Valid do legado, para nao espalhar o literal CBars
    * pelo form. O nome da COLUNA indexada por essa TAG eh CBars, escrito
    * literalmente nos pontos de leitura, junto das outras 3 colunas da grade.
    *--------------------------------------------------------------------------
    this_cCursorRelatorio = ""      && alias da grade (csRelatorio no legado)
    this_cTagBarras = ""            && TAG usada no Seek por CBars

    *--------------------------------------------------------------------------
    * Origem do cursor da grade
    *
    * .F. = veio do form PAI  -> este BO NAO pode fecha-lo
    * .T. = criado aqui vazio -> este BO fecha no Destroy()
    *--------------------------------------------------------------------------
    this_lCursorProprio = .F.

    *--------------------------------------------------------------------------
    * Valor digitado no campo de busca (Cnt_Procurar.GetBusca.Value)
    *--------------------------------------------------------------------------
    this_cBarraBusca = ""

    *--------------------------------------------------------------------------
    * Linha corrente da grade - espelha as 4 colunas do cursor csRelatorio
    *
    * A grade do legado eh somente leitura (Grade.ReadOnly = .T. e as 4
    * Column<N>.ReadOnly = .T.), entao estas propriedades sao de LEITURA:
    * servem para o form publicar a linha corrente sem ler o cursor direto.
    *--------------------------------------------------------------------------
    this_nCBars = 0                 && CBars   - codigo de barras (numeric(14,0))
    this_dDatas = {}                && Datas   - data de entrada da etiqueta
    this_cDPros = ""                && DPros   - descricao do produto
    this_cPLocals = ""              && pLocals - local do produto

    *--------------------------------------------------------------------------
    * Impressao da consulta (cmdImprimir do legado)
    *
    * No legado o botao Imprimir nao imprime direto: ele abre o dialogo
    * generico SIGMVDOC com dois parametros -
    *
    *   Do Form SigMvDoc With 'SIGOPETQ', 'Impressao da Consulta de Etiquetas'
    *
    * e o Init do SIGMVDOC guarda o 1o em NomeRepo e o 2o no Caption. Com
    * pRep <> 'SIGCDENT' (o caso desta tela) ele ESCONDE os campos de faixa de
    * Nota Fiscal, e a barra de botoes dele roda sobre o cursor CORRENTE:
    *
    *   visualizacao  -> Report Form &NomeRepo. Preview NoConsole
    *   impressao     -> Report Form &NomeRepo. To Printer Prompt NoConsole
    *   processamento -> Go Top
    *
    * Dai as duas propriedades abaixo: o nome-base do FRX (NomeRepo = o
    * proprio pRep, "SIGOPETQ") e o titulo do dialogo (pTit).
    *
    * this_cArquivoRelatorio eh NOME-BASE, sem path e sem ".frx" - quem
    * concatena gc_4c_CaminhoReports eh ExecutarReportForm. A grafia segue o
    * arquivo portado (projeto\app\reports\SigOpEtq.frx); o Windows nao
    * diferencia maiuscula de minuscula no nome, entao ela nao muda o alvo.
    *--------------------------------------------------------------------------
    this_cArquivoRelatorio = ""     && NomeRepo do SIGMVDOC legado (base do FRX)
    this_cTituloRelatorio = ""      && pTit do SIGMVDOC legado (Caption)

    *==========================================================================
    * Init - Inicializa Business Object
    *
    * DODEFAULT() eh chamado SEM argumento de proposito: passar um nome de
    * tabela faria BusinessBase instanciar um DataAccess, e esta tela nao tem
    * tabela proprietaria para consultar - o cursor da grade chega PRONTO do
    * form PAI (ver header).
    *
    * Por isso as duas propriedades herdadas ficam vazias - os nomes
    * corretos sao this_cTabela e this_cCampoChave (nunca this_cTabela /
    * this_cCampoChave).
    *
    * NAO chamar fChecaAcesso() (nem nenhuma das 12 funcoes de
    * Framework\sigacess.PRG) daqui: a versao que vence eh a do sigacess, que
    * abre conexao propria e PENDURA dentro do CREATEOBJECT. A visibilidade de
    * cmdEtiquetas/cmdImprimir eh resolvida no form.
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        *-- Visualizador de cursor recebido do pai: nao ha tabela propria
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        *-- Cursor da grade e a TAG que o form pai cria nele
        THIS.this_cCursorRelatorio = "cursor_4c_Relatorio"
        THIS.this_cTagBarras = "CBars"
        THIS.this_lCursorProprio = .F.

        *-- Campo de busca (ainda sem valor digitado)
        THIS.this_cBarraBusca = ""

        *-- Linha corrente da grade
        THIS.this_nCBars = 0
        THIS.this_dDatas = {}
        THIS.this_cDPros = ""
        THIS.this_cPLocals = ""

        *-- Impressao: os dois argumentos que o legado passa ao SIGMVDOC
        *-- ("SIGOPETQ" vira NomeRepo, usado como nome-base do FRX)
        THIS.this_cArquivoRelatorio = "SigOpEtq"
        THIS.this_cTituloRelatorio = "Impress" + CHR(227) + ;
            "o da Consulta de Etiquetas"

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GarantirCursorRelatorio - assegura que o alias da grade existe
    *
    * O cursor eh do form PAI, mas o dialogo tem de abrir mesmo quando ele nao
    * foi entregue: sem alias a grade fica sem RecordSource e aparece como um
    * retangulo branco, sem cabecalho e sem coluna, SEM erro nenhum.
    *
    * Este metodo eh a FONTE UNICA do CREATE CURSOR deste alias: nenhum outro
    * ponto do Form ou do BO pode declarar essa estrutura, para o placeholder
    * da grade nunca divergir (em nome, tipo ou ORDEM de campos) do cursor que
    * o pai popula - o APPEND FROM do pai casa por NOME, e a grade liga
    * Column1..Column4 exatamente a CBars/Datas/DPros/pLocals.
    *
    * SET NULL ON antes do CREATE CURSOR porque Datas eh datetime NULL em
    * SigOpEtq e as colunas de descricao vem de JOIN: sem isso, um APPEND FROM
    * de dado vindo do SQL Server recusaria o NULL.
    *
    * Cursor ja aberto (veio do pai) eh respeitado como esta - nao recriar,
    * nao reindexar.
    *==========================================================================
    PROCEDURE GarantirCursorRelatorio()
        LOCAL loc_lSucesso, loc_cCursor, loc_cTag, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)
        loc_cTag = ALLTRIM(THIS.this_cTagBarras)

        TRY
            IF EMPTY(loc_cCursor) OR EMPTY(loc_cTag)
                THIS.this_cMensagemErro = "Alias ou TAG do cursor da grade n" + ;
                    CHR(227) + "o definidos."
            ELSE
                IF USED(loc_cCursor)
                    *-- Entregue pelo form PAI: nao eh nosso para recriar nem fechar
                    loc_lSucesso = .T.
                ELSE
                    SET NULL ON
                    CREATE CURSOR (loc_cCursor) ( ;
                        CBars   N(14, 0) NULL, ;
                        Datas   T        NULL, ;
                        DPros   C(65)    NULL, ;
                        pLocals C(10)    NULL)
                    SET NULL OFF

                    SELECT (loc_cCursor)
                    INDEX ON CBars TAG (loc_cTag)
                    SET ORDER TO TAG (loc_cTag)

                    IF USED(loc_cCursor)
                        THIS.this_lCursorProprio = .T.
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + ;
                            CHR(237) + "vel criar o cursor da grade."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao preparar o cursor da grade:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Consulta de Etiquetas")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - publica a LINHA CORRENTE da grade nas propriedades
    *
    * Sem argumento usa this_cCursorRelatorio; com argumento aceita o alias
    * que o chamador indicar (o pai pode ter batizado o cursor de outro jeito).
    *
    * IF EOF() OBRIGATORIO: em VFP, ler campo com o ponteiro em EOF nao da
    * erro - devolve o valor em branco do tipo. Sem o guard as propriedades
    * seriam ZERADAS e o metodo ainda devolveria .T., relatando sucesso sem
    * haver linha nenhuma; USED() sozinho nao cobre isso, porque o cursor esta
    * aberto e cheio e o que esta fora de lugar eh o PONTEIRO.
    *
    * Os campos sao lidos com guarda de EXISTENCIA (TYPE do nome qualificado)
    * porque a estrutura vem de FORA: o pai monta o cursor. Faltando CBars nao
    * ha linha identificavel e o metodo FALHA; faltando uma das tres colunas
    * descritivas, a propriedade fica no valor vazio do tipo e a leitura segue
    * - a grade exibiria a coluna em branco do mesmo jeito.
    *
    * TratarNulo recebe o VALOR PADRAO do tipo ("" / 0 / {}), nunca um codigo
    * de tipo: TratarNulo(col, "C") gravaria a string literal C quando a
    * coluna vier NULL.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cCursor)
        LOCAL loc_lSucesso, loc_cCursor, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)

        IF VARTYPE(par_cCursor) = "C" AND !EMPTY(ALLTRIM(par_cCursor))
            loc_cCursor = ALLTRIM(par_cCursor)
        ENDIF

        TRY
            IF !USED(loc_cCursor)
                THIS.this_cMensagemErro = "O cursor [" + loc_cCursor + "] n" + ;
                    CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                SELECT (loc_cCursor)

                IF EOF()
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                        " etiqueta corrente para carregar."
                ELSE
                    IF TYPE(loc_cCursor + ".CBars") = "U"
                        THIS.this_cMensagemErro = "O cursor [" + loc_cCursor + ;
                            "] n" + CHR(227) + "o tem a coluna CBars (c" + ;
                            CHR(243) + "digo de barras)."
                    ELSE
                        THIS.this_nCBars = TratarNulo( ;
                            EVALUATE(loc_cCursor + ".CBars"), 0)

                        IF TYPE(loc_cCursor + ".Datas") = "U"
                            THIS.this_dDatas = {}
                        ELSE
                            THIS.this_dDatas = ConverterParaData( ;
                                TratarNulo(EVALUATE(loc_cCursor + ".Datas"), {}))
                        ENDIF

                        IF TYPE(loc_cCursor + ".DPros") = "U"
                            THIS.this_cDPros = ""
                        ELSE
                            THIS.this_cDPros = ALLTRIM(TratarNulo( ;
                                EVALUATE(loc_cCursor + ".DPros"), ""))
                        ENDIF

                        IF TYPE(loc_cCursor + ".pLocals") = "U"
                            THIS.this_cPLocals = ""
                        ELSE
                            THIS.this_cPLocals = ALLTRIM(TratarNulo( ;
                                EVALUATE(loc_cCursor + ".pLocals"), ""))
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao ler a etiqueta do cursor:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Consulta de Etiquetas")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PosicionarPrimeiro - espelha o Select csRelatorio / Go Top do Init
    *
    * O form chama isto no Init e em todo ponto que repopula a grade; o
    * Grade.Refresh fica no form, porque repintar eh responsabilidade da UI
    * (e grade em pagina oculta nao pinta).
    *
    * Cursor vazio nao eh erro: eh o caso em que o pai nao conferiu nenhuma
    * etiqueta. As propriedades sao limpas para nao sobrar a linha de uma
    * carga anterior, e a mensagem fica disponivel para quem quiser exibir -
    * este metodo NAO abre dialogo por cursor vazio. A mensagem eh atribuida
    * DEPOIS do LimparDados porque o LimparDados da base zera
    * this_cMensagemErro.
    *==========================================================================
    PROCEDURE PosicionarPrimeiro()
        LOCAL loc_lSucesso, loc_cCursor, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)

        TRY
            IF !USED(loc_cCursor)
                THIS.this_cMensagemErro = "O cursor [" + loc_cCursor + "] n" + ;
                    CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                SELECT (loc_cCursor)
                GO TOP

                IF EOF()
                    THIS.LimparDados()
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                        " etiquetas a exibir."
                ELSE
                    loc_lSucesso = THIS.CarregarDoCursor(loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao posicionar a grade de etiquetas:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Consulta de Etiquetas")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarPorBarra - espelha LITERALMENTE o GetBusca.Valid do legado
    *
    *   lcProd = This.Value
    *   If Not Empty(lcProd)
    *       Select csRelatorio
    *       lnReg = Recno()
    *       If Not Seek(lcProd, csRelatorio, CBars)
    *           Go lnReg
    *       EndIf
    *   EndIf
    *
    * Tres comportamentos do legado que NAO se alteram aqui:
    *   (a) barra vazia nao faz NADA - nao move o ponteiro, nao avisa;
    *   (b) barra nao encontrada volta para a linha onde o usuario estava -
    *       NAO limpa o campo digitado e NAO abre dialogo (avisar e apagar o
    *       digitado deixaria o usuario sem como preencher);
    *   (c) nao ha consulta ao banco - a busca eh so no cursor em memoria.
    *
    * O valor digitado chega CARACTERE do TextBox e a coluna CBars eh
    * numeric(14,0), entao a chave do Seek eh convertida conforme o tipo REAL
    * da coluna no cursor (o pai eh quem a declara). Cursor com CBars
    * caractere eh aceito tambem: ali vale a comparacao de texto e, com
    * SET EXACT ON (config.prg), o Seek exige a barra inteira - mesmo criterio
    * do legado, que tambem procura o codigo completo.
    *
    * O Recno eh reposto so quando ainda eh valido: apos um Seek frustrado o
    * ponteiro vai para EOF, e o Recno gravado antes pode ser RECCOUNT()+1 se
    * a linha de partida ja era EOF - GO nesse valor estouraria "Record is out
    * of range".
    *==========================================================================
    PROCEDURE BuscarPorBarra(par_uBarra)
        LOCAL loc_lSucesso, loc_cCursor, loc_cTag, loc_cBarra
        LOCAL loc_uChave, loc_nReg, loc_lTemValor, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)
        loc_cTag = ALLTRIM(THIS.this_cTagBarras)
        loc_cBarra = ""
        loc_lTemValor = .F.

        *-- Normaliza o que veio do TextBox (pode ser Caractere ou Numerico)
        *-- ISNULL testado ANTES de EMPTY: EMPTY(.NULL.) devolve .F. em VFP9
        IF PCOUNT() >= 1 AND !ISNULL(par_uBarra)
            DO CASE
                CASE VARTYPE(par_uBarra) = "C"
                    loc_cBarra = ALLTRIM(par_uBarra)
                    loc_lTemValor = !EMPTY(loc_cBarra)
                CASE VARTYPE(par_uBarra) = "N"
                    loc_cBarra = ALLTRIM(STR(par_uBarra, 14))
                    loc_lTemValor = (par_uBarra <> 0)
            ENDCASE
        ENDIF

        *-- Registra o que o usuario digitou, inclusive quando nao achar
        THIS.this_cBarraBusca = loc_cBarra

        TRY
            IF !loc_lTemValor
                *-- Legado: If Not Empty(lcProd) - barra vazia nao faz nada
                THIS.this_cMensagemErro = ""
            ELSE
                IF !USED(loc_cCursor)
                    THIS.this_cMensagemErro = "O cursor [" + loc_cCursor + ;
                        "] n" + CHR(227) + "o est" + CHR(225) + " aberto."
                ELSE
                    SELECT (loc_cCursor)
                    loc_nReg = RECNO()

                    *-- Chave do Seek no tipo REAL da coluna indexada
                    IF TYPE(loc_cCursor + ".CBars") = "N"
                        loc_uChave = VAL(loc_cBarra)
                    ELSE
                        loc_uChave = loc_cBarra
                    ENDIF

                    IF SEEK(loc_uChave, loc_cCursor, loc_cTag)
                        loc_lSucesso = THIS.CarregarDoCursor(loc_cCursor)
                    ELSE
                        *-- Legado: Go lnReg - volta para onde o usuario estava
                        IF BETWEEN(loc_nReg, 1, RECCOUNT(loc_cCursor))
                            GO loc_nReg
                        ELSE
                            GO TOP
                        ENDIF

                        THIS.this_cMensagemErro = "Barra [" + loc_cBarra + ;
                            "] n" + CHR(227) + "o consta nesta consulta."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao procurar a barra na consulta:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Consulta de Etiquetas")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ContarRegistros - quantas etiquetas a grade tem para exibir/imprimir
    *
    * Usado pelos botoes Etiquetas e Imprimir: o legado faz Select csRelatorio
    * e entrega o cursor ao form chamado, e um cursor sem linha nenhuma
    * geraria documento em branco.
    *
    * RECCOUNT nao move o ponteiro, entao a linha corrente da grade eh
    * preservada e nao ha Recno a repor.
    *==========================================================================
    PROCEDURE ContarRegistros()
        LOCAL loc_nTotal, loc_cCursor, loc_oErro

        loc_nTotal = 0
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)

        TRY
            IF USED(loc_cCursor)
                loc_nTotal = RECCOUNT(loc_cCursor)
            ELSE
                THIS.this_cMensagemErro = "O cursor [" + loc_cCursor + "] n" + ;
                    CHR(227) + "o est" + CHR(225) + " aberto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao contar as etiquetas da consulta:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Consulta de Etiquetas")
            THIS.this_lErroExibido = .T.
            loc_nTotal = 0
        ENDTRY

        RETURN loc_nTotal
    ENDPROC

    *==========================================================================
    * ExecutarReportForm - helper canonico do projeto (Pattern #117)
    *
    * Faz as tres coisas que um REPORT FORM solto nao faz, e cada uma vem de
    * um defeito ja medido no projeto:
    *
    *   1. GUARD de existencia do FRX - sem ele, FRX ausente estoura uma
    *      mensagem que nao diz qual arquivo faltou.
    *   2. ISOLAMENTO de locale - os FRX legado Fortyus foram desenhados com
    *      SET POINT TO "." e REPORTBEHAVIOR 80; no default brasileiro do VFP9
    *      (POINT = ",") e no REPORTBEHAVIOR 90 os campos numericos saem como
    *      ******* porque as PICTURE 9,999.999 do FRX deixam de casar.
    *   3. RESTAURACAO do menu - o _MREPORT do PREVIEW corrompe o _MSYSMENU e
    *      o menu principal volta encolhido, sem os pads.
    *
    * O guard de cursor existe porque o FRX imprime da WORK AREA CORRENTE: as
    * expressoes dele sao Contas/CBars/Tipos/datas/cpros/DPros SEM prefixo de
    * alias (conferido no .frt portado). Quem seleciona o alias eh este
    * metodo - igual ao "Select csRelatorio" que o legado faz antes do Do Form.
    *
    * PROTECTED: so os tres metodos de acao abaixo o usam, e ele nao entra na
    * lista de metodos que o form chama de fora (regra CLAUDE.md #51).
    *
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *
    * RETURN unico, FORA do TRY (regra CLAUDE.md #1) - o resultado passa pela
    * flag loc_lSucesso e os caminhos de recusa a deixam em .F.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cFRX, loc_cCursor, loc_cModo
        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig, loc_oErro

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        IF TYPE("gc_4c_CaminhoReports") != "C"
            gc_4c_CaminhoReports = ""
        ENDIF

        loc_cModo = UPPER(ALLTRIM(par_cModo))
        loc_cFRX  = FULLPATH(gc_4c_CaminhoReports + ;
            ALLTRIM(par_cRelatorioBase) + ".frx")

        IF !FILE(loc_cFRX)
            THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + ;
                CHR(227) + "o encontrado:" + CHR(13) + loc_cFRX
            MsgErro(THIS.this_cMensagemErro, "Imprimir")
            THIS.this_lErroExibido = .T.
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            loc_cCursor = ""
            IF VARTYPE(par_cCursorDados) = "C"
                loc_cCursor = ALLTRIM(par_cCursorDados)
            ENDIF

            IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
                THIS.this_cMensagemErro = "O cursor da consulta n" + CHR(227) + ;
                    "o est" + CHR(225) + " dispon" + CHR(237) + "vel."
                MsgAviso(THIS.this_cMensagemErro, ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                THIS.this_lErroExibido = .T.
                loc_lProsseguir = .F.
            ELSE
                IF RECCOUNT(loc_cCursor) = 0
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                        " etiquetas para imprimir."
                    MsgAviso(THIS.this_cMensagemErro, ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.this_lErroExibido = .T.
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF
        ENDIF

        IF loc_lProsseguir
            TRY
                *-- "Select csRelatorio" + "Go Top": o FRX le a work area
                *-- CORRENTE, e o Go Top eh o PROCEDURE processamento do
                *-- SIGMVDOC, que roda antes de cada saida.
                SELECT (loc_cCursor)
                GO TOP IN (loc_cCursor)

                loc_cPointOrig = SET("POINT")
                loc_cSepOrig   = SET("SEPARATOR")
                *-- SET("REPORTBEHAVIOR") ja devolve NUMERICO: VAL() aqui
                *-- dispararia o erro 11, igual ao SET("Decimals").
                loc_nBehaviorOrig = SET("REPORTBEHAVIOR")

                SET POINT TO "."
                SET SEPARATOR TO ","
                SET REPORTBEHAVIOR 80

                DO CASE
                    CASE loc_cModo == "PREVIEW"
                        REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
                    CASE loc_cModo == "PRINTER_PROMPT"
                        REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
                    CASE loc_cModo == "PRINTER"
                        REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
                ENDCASE

                SET POINT TO (loc_cPointOrig)
                SET SEPARATOR TO (loc_cSepOrig)
                SET REPORTBEHAVIOR (loc_nBehaviorOrig)

                loc_lSucesso = .T.
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Imprimir")
                THIS.this_lErroExibido = .T.
            ENDTRY

            *-- Repoe o menu principal depois do PREVIEW. Fica FORA do TRY
            *-- acima de proposito, para rodar tambem quando o REPORT FORM
            *-- abortou no meio e ja tinha trocado o _MSYSMENU.
            TRY
                SET SYSMENU TO DEFAULT
                RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
                    popRelatorios, popFerramentas, popAjuda
                CriarMenuPrincipal()
            CATCH
                *-- Menu fora de escopo (probe/teste headless) - sem efeito
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Visualizar - PROCEDURE visualizacao do SIGMVDOC legado
    *
    *   Report Form &NomeRepo. Preview NoConsole
    *
    * Sem o ramo "If ThisForm.pcRep = 'SIGCDENT'" que recorta por faixa de
    * Nota Fiscal: aqui pRep eh "SIGOPETQ", logo aquele IF nao entra e o
    * relatorio sai sobre a consulta inteira.
    *
    * PUBLIC (sem PROTECTED): o dialogo de impressao chama de FORA da classe,
    * e nenhum nivel da heranca de BusinessBase declara este nome - se algum
    * declarasse PROTECTED, a chamada externa estouraria "Property VISUALIZAR
    * is not found" (regra CLAUDE.md #51).
    *==========================================================================
    PROCEDURE Visualizar()
        RETURN THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, ;
            "PREVIEW", THIS.this_cCursorRelatorio)
    ENDPROC

    *==========================================================================
    * Imprimir - PROCEDURE impressao do SIGMVDOC legado
    *
    *   Report Form &NomeRepo. To Printer Prompt NoConsole
    *
    * O PROMPT eh do legado: o dialogo de impressora do Windows abre para o
    * usuario escolher bandeja/copias antes de sair o papel.
    *==========================================================================
    PROCEDURE Imprimir()
        RETURN THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, ;
            "PRINTER_PROMPT", THIS.this_cCursorRelatorio)
    ENDPROC

    *==========================================================================
    * GerarExcel - 3o botao da barra do frmrelatorio ("Arquivos Email")
    *
    * O frmrelatorio legado gera o arquivo com o MESMO FRX, trocando so o
    * destino por "To File ... Ascii" - eh esse arquivo que segue anexado no
    * email. O nome leva a data para dois cliques no mesmo dia nao se
    * sobrescreverem.
    *
    * NAO delega ao ExecutarReportForm porque o destino eh outro comando (TO
    * FILE, com nome de arquivo), e nao um dos tres modos dele; os guards de
    * FRX e de cursor sao portanto refeitos aqui. O isolamento de locale e a
    * reposicao do menu nao entram: sem PREVIEW nao ha _MREPORT para corromper
    * o _MSYSMENU, e a saida ASCII nao passa pelas PICTURE do FRX.
    *==========================================================================
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cFRX, loc_cCursor
        LOCAL loc_cArquivo, loc_oErro

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        IF TYPE("gc_4c_CaminhoReports") != "C"
            gc_4c_CaminhoReports = ""
        ENDIF

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + ;
            ALLTRIM(THIS.this_cArquivoRelatorio) + ".frx")
        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)

        IF !FILE(loc_cFRX)
            THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + ;
                CHR(227) + "o encontrado:" + CHR(13) + loc_cFRX
            MsgErro(THIS.this_cMensagemErro, "Arquivos Email")
            THIS.this_lErroExibido = .T.
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
                THIS.this_cMensagemErro = "O cursor da consulta n" + CHR(227) + ;
                    "o est" + CHR(225) + " dispon" + CHR(237) + "vel."
                MsgAviso(THIS.this_cMensagemErro, ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                THIS.this_lErroExibido = .T.
                loc_lProsseguir = .F.
            ELSE
                IF RECCOUNT(loc_cCursor) = 0
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                        " etiquetas para gerar o arquivo."
                    MsgAviso(THIS.this_cMensagemErro, ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.this_lErroExibido = .T.
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF
        ENDIF

        IF loc_lProsseguir
            TRY
                loc_cArquivo = FULLPATH(gc_4c_CaminhoReports + ;
                    ALLTRIM(THIS.this_cArquivoRelatorio) + "_" + ;
                    STRTRAN(DTOC(DATE()), "/", "") + ".xls")

                SELECT (loc_cCursor)
                GO TOP IN (loc_cCursor)

                REPORT FORM (loc_cFRX) TO FILE (loc_cArquivo) NOCONSOLE ASCII

                IF FILE(loc_cArquivo)
                    MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, ;
                        "Arquivos Email")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao gerar o arquivo " + ;
                        loc_cArquivo
                    MsgErro(THIS.this_cMensagemErro, "Arquivos Email")
                    THIS.this_lErroExibido = .T.
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Arquivos Email")
                THIS.this_lErroExibido = .T.
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - zera a linha corrente publicada e o campo de busca
    *
    * DODEFAULT() limpa this_cMensagemErro da base. NAO toca no cursor: o
    * conteudo da grade eh do form PAI.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_nCBars = 0
        THIS.this_dDatas = {}
        THIS.this_cDPros = ""
        THIS.this_cPLocals = ""
        THIS.this_cBarraBusca = ""
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - identidade da linha corrente
    *
    * PROTECTED igual a BusinessBase: medido no VFP9, PROTECTED na base
    * prevalece sobre override sem modificador, entao declarar publico aqui
    * nao abriria o metodo e so esconderia a restricao. De fora, ninguem
    * chama.
    *
    * A chave eh o codigo de barras - PK de SigOpEtq (cbars numeric(14,0)) e a
    * coluna indexada pela TAG do Seek. Barra zerada devolve vazio, para a
    * base nao registrar auditoria de linha sem identidade.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave

        loc_cChave = ""

        IF THIS.this_nCBars <> 0
            loc_cChave = ALLTRIM(STR(THIS.this_nCBars, 14))
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *==========================================================================
    * Destroy - fecha SO o cursor que este BO criou
    *
    * Cursor entregue pelo pai (this_lCursorProprio = .F.) fica aberto: a tela
    * de tras continua usando aquele alias, e fecha-lo daqui quebraria o fluxo
    * de conferencia do pai.
    *
    * USE IN basta e eh seguro mesmo com buffer sujo - TABLEREVERT aqui
    * estouraria "Function requires row or table buffering mode" num cursor
    * criado com Buffering = 1.
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_cCursor

        loc_cCursor = ALLTRIM(THIS.this_cCursorRelatorio)

        IF THIS.this_lCursorProprio AND !EMPTY(loc_cCursor) AND USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        THIS.this_lCursorProprio = .F.

        DODEFAULT()
    ENDPROC

ENDDEFINE
