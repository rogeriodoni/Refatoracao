# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH Thisform.Cnt_Planilha.GrdGrade define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: Thisform.Cnt_Planilha.GrdGrade.RecordSource).

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpPcu.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1347 linhas total):

*-- Linhas 73 a 81:
73: *            Release() destruiria o objeto antes do chamador poder ler o
74: *            cursor (regra do FormSigOpCtd/task715, mesma familia do
75: *            FormBuscaAuxiliar);
76: *         5. o ESC nao precisa de segundo handler - cmd_4c_Encerrar tem
77: *            Cancel = .T. transcrito do dump, e a tecla de cancelamento
78: *            dispara o mesmo Click interceptado pelo BINDEVENT.
79: *
80: *   (d) NAO ha outro evento de botao a portar. O dump nao tem CommandGroup
81: *       nem segundo CommandButton. O "Load" ("=fConfigGeral()") segue NAO

*-- Linhas 166 a 174:
166:     *-- FecharDialogo() - fechando por ali, MontarCursorAlterados() nunca
167:     *-- roda, crPrFtp nao eh montado e o form pai (SIGCDPRO/FormProduto)
168:     *-- recebe a planilha como se nada tivesse sido alterado, sem erro e sem
169:     *-- log. Com o "X" fora, a UNICA saida volta a ser cmd_4c_Encerrar - que
170:     *-- tem Cancel = .T. e portanto atende tambem o ESC -, exatamente como no
171:     *-- legado; o usuario nao fica sem saida (o risco inverso, de tirar a
172:     *-- unica saida da tela).
173:     *-- Mesmo par ja transcrito nos dialogos filhos irmaos: FormSigOpLrC,
174:     *-- FormDCC, FormSigOpClp e FormSIGOPDVM.

*-- Linhas 239 a 248:
239: 
240:                 THIS.ConfigurarPageFrame()
241: 
242:                 THIS.cnt_4c__Planilha.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
243:                 THIS.cnt_4c__Planilha.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
244: 
245:                 *-- SO AGORA os titulos que dependem de dado (ver
246:                 *-- AtualizarTitulos): no legado a faixa do cabecalho recebe o
247:                 *-- Caption ORIGINAL e so DEPOIS o Caption do form passa a ser
248:                 *-- o produto em edicao - invertido, a faixa cinza exibiria o

*-- Linhas 276 a 284:
276:     * A ORDEM de criacao eh a do SCX legado dentro de Cnt_Planilha
277:     * (cntSombra -> grdGrade -> Label1 -> Get_Adicional -> cmdSair) e importa
278:     * por DOIS motivos:
279:     *   - cmd_4c_Encerrar fica em Top = 3, isto eh DENTRO da area da faixa do
280:     *     cabecalho (Top 0..80), e so desenha por cima dela se for criado
281:     *     DEPOIS (regra #11);
282:     *   - a ordem de criacao EH a ordem de tabulacao efetiva do legado (ver
283:     *     AplicarOrdemTabulacao, que mede o descarte do TabIndex = 18 do
284:     *     dump), entao trocar a posicao de um Configurar* aqui muda a

*-- Linhas 319 a 379:
319:         *-- Container principal (legado: Cnt_Planilha, Top=0 Left=0 W=999 H=600)
320:         THIS.AddObject("cnt_4c__Planilha", "Container")
321:         WITH THIS.cnt_4c__Planilha
322:             .Top           = 0
323:             .Left          = 0
324:             .Width         = 999
325:             .Height        = 600
326:             .BackStyle     = 1
327:             .BorderWidth   = 0
328:             .SpecialEffect = 0
329:             .Picture       = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
330:             .Visible       = .T.
331:         ENDWITH
332: 
333:         *-- Faixa do cabecalho (legado: cntSombra, dentro de Cnt_Planilha)
334:         THIS.cnt_4c__Planilha.AddObject("cnt_4c_Sombra", "Container")
335:         WITH THIS.cnt_4c__Planilha.cnt_4c_Sombra
336:             .Top         = 0
337:             .Left        = 0
338:             .Width       = THIS.cnt_4c__Planilha.Width
339:             .Height      = 80
340:             .BackStyle   = 1
341:             .BackColor   = RGB(100, 100, 100)
342:             .BorderWidth = 0
343:             .Visible     = .T.
344:         ENDWITH
345: 
346:         THIS.cnt_4c__Planilha.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
347:         WITH THIS.cnt_4c__Planilha.cnt_4c_Sombra.lbl_4c_LblSombra
348:             .Top       = 25
349:             .Left      = 10
350:             .Width     = 769
351:             .Height    = 40
352:             .AutoSize  = .F.
353:             .BackStyle = 0
354:             .WordWrap  = .T.
355:             .Alignment = 0
356:             .Caption   = "Planilha de Custo"
357:             .FontName  = "Tahoma"
358:             .FontSize  = 16
359:             .FontBold  = .T.
360:             .ForeColor = RGB(0, 0, 0)
361:             .Visible   = .T.
362:         ENDWITH
363: 
364:         THIS.cnt_4c__Planilha.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
365:         WITH THIS.cnt_4c__Planilha.cnt_4c_Sombra.lbl_4c_LblTitulo
366:             .Top         = 24
367:             .Left        = 10
368:             .Width       = 769
369:             .Height      = 46
370:             .AutoSize    = .F.
371:             .BackStyle   = 0
372:             .WordWrap    = .T.
373:             .Alignment   = 0
374:             .Caption     = "Planilha de Custo"
375:             .FontName    = "Tahoma"
376:             .FontSize    = 16
377:             .FontBold    = .T.
378:             .ForeColor   = RGB(255, 255, 255)
379:             *-- ToolTipText do dump (lblTitulo) - unico dos dois labels que tem

*-- Linhas 436 a 445:
436:         loc_oCnt.AddObject("grd_4c_Dados", "Grid")
437: 
438:         WITH loc_oCnt.grd_4c_Dados
439:             .Top               = 130
440:             .Left              = 5
441:             .Width             = 989
442:             .Height            = 442
443:             .ColumnCount       = 7
444:             .HeaderHeight      = 16
445:             .RowHeight         = 16

*-- Linhas 701 a 715:
701:         loc_oGrade.Column7.Width = 100
702: 
703:         *-- 4. Header1.Caption por ULTIMO (o bind acima devolve "ColumnN")
704:         loc_oGrade.Column1.Header1.Caption = "C" + CHR(243) + "digo"
705:         loc_oGrade.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
706:         loc_oGrade.Column3.Header1.Caption = "Total (a)"
707:         loc_oGrade.Column4.Header1.Caption = "Coef. / (%)"
708:         loc_oGrade.Column5.Header1.Caption = "Valor (b)"
709:         loc_oGrade.Column6.Header1.Caption = "Total (a+b)"
710:         loc_oGrade.Column7.Header1.Caption = "Acumulado"
711: 
712:         *-- 5. Travas de coluna por ULTIMO: Column.ReadOnly tem de vir DEPOIS
713:         *--    de Grid.ReadOnly (que propaga para as colunas) - regra #18.
714:         THIS.AplicarTravasDeColuna()
715:     ENDPROC

*-- Linhas 961 a 992:
961: 
962:         *-- Subtitulo da planilha (legado: Label1). O Caption definitivo, com
963:         *-- o tipo entre parenteses, eh posto por AtualizarTitulos.
964:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
965:         WITH loc_oCnt.lbl_4c_Label1
966:             .Top       = 96
967:             .Left      = 67
968:             .Width     = 864
969:             .Height    = 21
970:             .AutoSize  = .F.
971:             .BackStyle = 0
972:             .WordWrap  = .F.
973:             .Alignment = 2
974:             .Caption   = "Planilha de Custo"
975:             .FontName  = "Tahoma"
976:             .FontSize  = 12
977:             .FontBold  = .T.
978:             .ForeColor = RGB(90, 90, 90)
979:             .Visible   = .T.
980:         ENDWITH
981: 
982:         *-- Total adicional (legado: Get_Adicional) - soma de Valos das linhas
983:         *-- visiveis, exibida no rodape. Somente leitura.
984:         loc_oCnt.AddObject("txt_4c_Adicional", "TextBox")
985:         WITH loc_oCnt.txt_4c_Adicional
986:             .Top               = 576
987:             .Left              = 588
988:             .Width             = 92
989:             .Height            = 23
990:             .Value             = 0
991:             .InputMask         = "9999,999.999"
992:             .Alignment         = 3

*-- Linhas 1056 a 1085:
1056:             loc_oCnt.grd_4c_Dados.TabIndex = loc_nSeq
1057:         ENDIF
1058: 
1059:         IF PEMSTATUS(loc_oCnt.lbl_4c_Label1, "TabIndex", 5)
1060:             loc_nSeq = loc_nSeq + 1
1061:             loc_oCnt.lbl_4c_Label1.TabIndex = loc_nSeq
1062:         ENDIF
1063: 
1064:         IF PEMSTATUS(loc_oCnt.txt_4c_Adicional, "TabIndex", 5)
1065:             loc_nSeq = loc_nSeq + 1
1066:             loc_oCnt.txt_4c_Adicional.TabIndex = loc_nSeq
1067:         ENDIF
1068: 
1069:         IF PEMSTATUS(loc_oCnt.cmd_4c_Encerrar, "TabIndex", 5)
1070:             loc_nSeq = loc_nSeq + 1
1071:             loc_oCnt.cmd_4c_Encerrar.TabIndex = loc_nSeq
1072:         ENDIF
1073:     ENDPROC
1074: 
1075:     *==========================================================================
1076:     * AtualizarTitulos - as duas atribuicoes de titulo que o Init legado faz
1077:     * DEPOIS de mandar o Caption para a faixa do cabecalho:
1078:     *
1079:     *     ThisForm.Caption = CrSigCdPro.Cpros + ' - ' + CrSigCdPro.Dpros
1080:     *     ThisForm.Cnt_Planilha.label1.Caption = ;
1081:     *         'Planilha de Custo ('+Iif(ptipo=[C],'Fator','Venda')+')'
1082:     *
1083:     * Por que NAO fica dentro de ConfigurarPaginaDados: a ORDEM eh que faz a
1084:     * faixa cinza exibir "Planilha de Custo" e nao o produto. No legado
1085:     * lblSombra/lblTitulo recebem o Caption ORIGINAL e so DEPOIS o Caption do

*-- Linhas 1104 a 1112:
1104: 
1105:         TRY
1106:             *-- "Planilha de Custo (Fator)" / "(Venda)" conforme o pTipo
1107:             THIS.cnt_4c__Planilha.lbl_4c_Label1.Caption = ;
1108:                 "Planilha de Custo (" + ;
1109:                 IIF(THIS.this_cTipo == "C", "Fator", "Venda") + ")"
1110: 
1111:             loc_cAliasProduto = ""
1112:             IF VARTYPE(THIS.this_oBusinessObject) = "O"

*-- Linhas 1121 a 1129:
1121:                     THIS.this_oBusinessObject.this_cCodigoProduto    = loc_cCodigo
1122:                     THIS.this_oBusinessObject.this_cDescricaoProduto = loc_cDescricao
1123: 
1124:                     THIS.Caption = loc_cCodigo + " - " + loc_cDescricao
1125:                 ENDIF
1126:             ENDIF
1127:         CATCH TO loc_oErro
1128:             THIS.this_cMensagemErro = loc_oErro.Message
1129:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel montar o " + ;

*-- Linhas 1176 a 1196:
1176:     ENDPROC
1177: 
1178:     *==========================================================================
1179:     * ConfigurarBotaoEncerrar - cmd_4c_Encerrar (legado: cmdSair, classe
1180:     * fwbtng do framework.vcx). Filho de cnt_4c__Planilha, como no legado.
1181:     *
1182:     * O SCX declara so Top=3, Left=924, Caption="Encerrar", Cancel=.T. e
1183:     * Picture=cadastro_sair_60.jpg - o resto vem da classe fwbtng
1184:     * (docs\FRAMEWORK_class_codigo_fonte.txt): FontName="Comic Sans MS",
1185:     * FontBold/FontItalic=.T., FontSize=8, WordWrap=.T., MousePointer=15,
1186:     * ForeColor=(90,90,90), BackColor=(255,255,255).
1187:     *
1188:     * GEOMETRIA: a fwbtng eh 80x100 e, no Left=924 do SCX, terminaria em 1004
1189:     * - 5px alem da borda do container (Width=999), que RECORTA o excedente
1190:     * (regra #30). Os 75x75 usados aqui sao o canonico do projeto para
1191:     * cmd_4c_Encerrar (medido no acervo: unanime nos forms OPERACIONAL) e
1192:     * fecham exatamente em 999, mantendo o Left do legado.
1193:     *
1194:     * Cancel = .T. faz o ESC disparar este MESMO Click, entao as duas saidas
1195:     * da tela (mouse e teclado) caem no funil unico FecharDialogo().
1196:     *

*-- Linhas 1206 a 1221:
1206:         LOCAL loc_oCnt
1207: 
1208:         loc_oCnt = THIS.cnt_4c__Planilha
1209:         loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
1210: 
1211:         WITH loc_oCnt.cmd_4c_Encerrar
1212:             .Top             = 3
1213:             .Left            = 924
1214:             .Width           = 75
1215:             .Height          = 75
1216:             .Caption         = "Encerrar"
1217:             .Cancel          = .T.
1218:             .FontName        = "Comic Sans MS"
1219:             .FontSize        = 8
1220:             .FontBold        = .T.
1221:             .FontItalic      = .T.

*-- Linhas 1232 a 1244:
1232:             .Visible         = .T.
1233:         ENDWITH
1234: 
1235:         BINDEVENT(loc_oCnt.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
1236:     ENDPROC
1237: 
1238:     *==========================================================================
1239:     * BtnEncerrarClick - Click de cmd_4c_Encerrar (e do ESC, por Cancel=.T.)
1240:     * Ligado por BINDEVENT, logo PUBLIC (regra #3).
1241:     *==========================================================================
1242:     PROCEDURE BtnEncerrarClick()
1243:         THIS.FecharDialogo()
1244:     ENDPROC


### BO (C:\4c\projeto\app\classes\SigOpPcuBO.prg):
*====================================================================
* SigOpPcuBO.prg
*
* Business Object para SigOpPcu - Planilha de Custo
* Herda de: BusinessBase
*
* ORIGEM LEGADO: SigOpPcu.SCX (dialogo modal filho)
*   Chamado por SIGCDPRO (Cadastro de Produto), aba Composicao:
*     chkPlanCus.Valid -> Do Form SigOpPcu With ThisForm, DataSessionId, [C]
*     chkPlanVen.Valid -> Do Form SigOpPcu With ThisForm, DataSessionId, [V]
*   Parametros do Init legado: poForm (form pai), pnDataSes (DataSession
*   do pai), pTipo ("C" = planilha de Fator/Custo, "V" = planilha de Venda).
*
* NATUREZA DA TELA (importante para entender este BO):
*   A planilha opera sobre o CURSOR LOCAL "csGrade", que pertence ao form
*   PAI (SIGCDPRO) e vive na DataSession DELE - o dialogo faz
*   "Set DataSession to pnDataSes" e edita o mesmo cursor em memoria.
*   Estrutura do cursor, transcrita do Load do SIGCDPRO:
*     Create Cursor CsGrade (Tipos c(1), Ordem n(3), Cpros c(14),
*            Dpros c(30), Totas n(12,3), Coefs n(8,4), Valos n(12,3),
*            TotalG n(12,3), Acumulas n(12,3), cGrus c(3), cods c(2),
*            CidChaves c(20), AltCoef n(1,0))
*     Index On Tipos + Str(Ordem,3) + Cpros Tag Ordem
*   O dialogo filtra as linhas do tipo recebido com "Set Key To pTipo"
*   sobre essa TAG e permite editar apenas a coluna Coefs (Coef./(%)),
*   recalculando Valos / TotalG / Acumulas e o total adicional.
*
* PERSISTENCIA: este dialogo NAO grava em tabela nenhuma. Quem persiste
*   eh o form PAI, no Salvar dele, lendo as linhas marcadas pelo dialogo:
*     SELECT csGrade / SCAN / IF altcoef = 1
*         Insert Into CrSigPrFtp (cGrus, cods, coefs, cpros, PkChaves)
*             Values (csGrade.cgrus, csGrade.cods, csGrade.coefs,
*                     crSigcdPro.cpros,
*                     IIF(EMPTY(csGrade.CidChaves), fUniqueIds(),
*                         csGrade.CidChaves))
*   Por isso o contrato de saida do dialogo sao as DUAS marcas que ele
*   grava na linha editada (AltCoef = 1 e CidChaves = fUniqueIds()) mais
*   o cursor crPrFtp que o botao Encerrar monta com as linhas alteradas:
*     SELECT * from csGrade where altcoef = 1 into cursor crPrFtp READWRITE
*   O comportamento padrao herdado de BusinessBase para Inserir() /
*   Atualizar() / ExecutarExclusao() (recusar a operacao e reportar pelo
*   ExibirFalha do Salvar) ja eh o correto para esta tela.
*
* TABELA DE REFERENCIA (PILAR 2 - nomes EXATOS do schema):
*   sigprftp  - destino final do coeficiente alterado (gravado pelo pai)
*               cgrus char(3), cods char(2), coefs numeric(6,4),
*               cpros char(14), pkchaves char(20), valors numeric(10,2)
*   SigPrFto  - origem das linhas da planilha montadas pelo pai
*               cidchaves char(20), coefs numeric(7,4), cpros char(14)
*====================================================================

DEFINE CLASS SigOpPcuBO AS BusinessBase

    *----------------------------------------------------------------
    * PARAMETROS DE ABERTURA (legado: LParameters poForm, pnDataSes, pTipo)
    *----------------------------------------------------------------
    this_cTipo              = "C"    && pTipo: "C" = Fator (custo), "V" = Venda
    this_nDataSessionPai    = 0      && pnDataSes - DataSession do form pai

    *----------------------------------------------------------------
    * CURSORES COMPARTILHADOS COM O FORM PAI
    * Os nomes sao os do legado de proposito: estes cursores NAO sao
    * criados aqui, eles pertencem a DataSession do form pai e os nomes
    * sao o CONTRATO entre as duas telas (mesma pratica de FormFti,
    * que tambem preserva "csGrade").
    *----------------------------------------------------------------
    this_cCursorGrade       = "csGrade"      && linhas da planilha (cursor do pai)
    this_cCursorProduto     = "CrSigCdPro"   && produto em edicao no pai (Cpros/Dpros)
    this_cCursorAlterados   = "crPrFtp"      && saida: linhas com AltCoef = 1
    this_cTagOrdem          = "Ordem"        && TAG Tipos + Str(Ordem,3) + Cpros

    *----------------------------------------------------------------
    * LINHA DA PLANILHA (colunas do cursor csGrade)
    * Tipo e tamanho transcritos do Create Cursor do SIGCDPRO.
    *----------------------------------------------------------------
    this_cTipos             = ""     && Tipos     c(1)      - "C" ou "V"
    this_nOrdem             = 0      && Ordem     n(3,0)    - sequencia da linha
    this_cCpros             = ""     && Cpros     c(14)     - codigo (coluna "Codigo")
    this_cDpros             = ""     && Dpros     c(30)     - descricao (coluna "Descricao")
    this_nTotas             = 0      && Totas     n(12,3)   - coluna "Total (a)"
    this_nCoefs             = 0      && Coefs     n(8,4)    - coluna "Coef. / (%)" (EDITAVEL)
    this_nValos             = 0      && Valos     n(12,3)   - coluna "Valor (b)"
    this_nTotalG            = 0      && TotalG    n(12,3)   - coluna "Total (a+b)"
    this_nAcumulas          = 0      && Acumulas  n(12,3)   - coluna "Acumulado"
    this_cCgrus             = ""     && cGrus     c(3)      - grupo (-> sigprftp.cgrus)
    this_cCods              = ""     && cods      c(2)      - feitio (-> sigprftp.cods)
    this_cCidChaves         = ""     && CidChaves c(20)     - PK (-> sigprftp.pkchaves)
    this_nAltCoef           = 0      && AltCoef   n(1,0)    - 1 = coeficiente alterado

    *----------------------------------------------------------------
    * CABECALHO DA TELA
    * Legado: ThisForm.Caption = CrSigCdPro.Cpros + " - " + CrSigCdPro.Dpros
    *         Label1 = "Planilha de Custo (" + Iif(pTipo="C","Fator","Venda") + ")"
    *----------------------------------------------------------------
    this_cCodigoProduto     = ""     && CrSigCdPro.Cpros c(14)
    this_cDescricaoProduto  = ""     && CrSigCdPro.Dpros c(30)

    *----------------------------------------------------------------
    * ESTADO DE CALCULO
    * this_nTotalAdicional eh o _TTA do legado (Sum Valos), exibido no
    * TextBox Get_Adicional, e eh recalculado a cada edicao de Coefs.
    * this_nCoefAnterior eh o lnCoef que o legado guardava no GotFocus
    * da celula para descobrir se o coeficiente mudou de fato - so nesse
    * caso a linha recebe AltCoef = 1 e CidChaves nova.
    *----------------------------------------------------------------
    this_nTotalAdicional    = 0      && _TTA - soma de Valos do tipo corrente
    this_nCoefAnterior      = 0      && lnCoef - valor de Coefs ao entrar na celula

    *----------------------------------------------------------------
    * CONTROLE DE ACESSO
    * Legado (When da Column4): Return fChecaAcesso([SIGCDFTI]) And (pcTipo = [V])
    * Ou seja: a coluna do coeficiente so eh editavel com acesso ao
    * cadastro de Feitios E na planilha de VENDA. O default .T. acompanha
    * o fChecaAcesso portado (utils\functions.prg), que libera o acesso;
    * o valor eh reavaliado por fChecaAcesso na carga da planilha.
    *----------------------------------------------------------------
    this_lAcessoFeitio      = .T.    && fChecaAcesso("SIGCDFTI")

    *====================================================================
    * Init - Inicializa o Business Object
    *
    * Nao recebe parametro obrigatorio: o harness de teste instancia com
    * CREATEOBJECT("SigOpPcuBO") sem argumento, e Init que devolve .F.
    * mata o form. O tipo da planilha ("C"/"V") e a DataSession do pai
    * sao atribuidos pelo form depois da instanciacao.
    *
    * this_cTabela / this_cCampoChave apontam para sigprftp / pkchaves,
    * que eh onde o coeficiente editado aqui termina gravado pelo form
    * pai (nomes EXATOS do schema - PILAR 2).
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "sigprftp"
            THIS.this_cCampoChave = "pkchaves"

            *-- Estado inicial da planilha (equivalente ao Init legado
            *-- antes de "Set Key To pTipo" / "Sum Valos to _TTA")
            THIS.this_cTipo             = "C"
            THIS.this_nDataSessionPai   = 0
            THIS.this_nTotalAdicional   = 0
            THIS.this_nCoefAnterior     = 0
            THIS.this_lAcessoFeitio     = .T.

            THIS.this_cCodigoProduto    = ""
            THIS.this_cDescricaoProduto = ""

            THIS.this_cTipos      = ""
            THIS.this_nOrdem      = 0
            THIS.this_cCpros      = ""
            THIS.this_cDpros      = ""
            THIS.this_nTotas      = 0
            THIS.this_nCoefs      = 0
            THIS.this_nValos      = 0
            THIS.this_nTotalG     = 0
            THIS.this_nAcumulas   = 0
            THIS.this_cCgrus      = ""
            THIS.this_cCods       = ""
            THIS.this_cCidChaves  = ""
            THIS.this_nAltCoef    = 0

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar SigOpPcuBO:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades desta linha a partir do
    * registro CORRENTE do cursor recebido (este dialogo nao usa SQLEXEC:
    * a "fonte de dados" eh o cursor local csGrade, compartilhado com o
    * form pai - ver cabecalho do arquivo).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cTipos     = TratarNulo(Tipos, "C")
            THIS.this_nOrdem     = TratarNulo(Ordem, "N")
            THIS.this_cCpros     = TratarNulo(Cpros, "C")
            THIS.this_cDpros     = TratarNulo(Dpros, "C")
            THIS.this_nTotas     = TratarNulo(Totas, "N")
            THIS.this_nCoefs     = TratarNulo(Coefs, "N")
            THIS.this_nValos     = TratarNulo(Valos, "N")
            THIS.this_nTotalG    = TratarNulo(TotalG, "N")
            THIS.this_nAcumulas  = TratarNulo(Acumulas, "N")
            THIS.this_cCgrus     = TratarNulo(cGrus, "C")
            THIS.this_cCods      = TratarNulo(cods, "C")
            THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
            THIS.this_nAltCoef   = TratarNulo(AltCoef, "N")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave desta linha no destino final (sigprftp.
    * pkchaves = csGrade.CidChaves). Mantido por consistencia com
    * BusinessBase; este dialogo NAO chama Salvar()/Excluir() (ver nota
    * de PERSISTENCIA no cabecalho do arquivo e Init() acima) - quem
    * grava em sigprftp eh o form PAI (SIGCDPRO), varrendo o proprio
    * csGrade pelas linhas com AltCoef = 1 que esta tela marcou.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN EscaparSQL(THIS.this_cCidChaves)
    ENDPROC

    *====================================================================
    * FiltrarGrade - Replica "Select CsGrade / Set Key To pTipo" do Init
    * legado: restringe o cursor compartilhado csGrade as linhas do tipo
    * recebido ("C" = Fator/Custo, "V" = Venda, Column4.When) e recalcula
    * o total adicional (_TTA do legado / TextBox Get_Adicional) somando
    * Valos das linhas visiveis.
    *
    * O "Set Key To pTipo" do legado NAO pode ser transcrito ao pe da letra
    * aqui - e o motivo nao se ve lendo o codigo, so MEDINDO. O TAG "Ordem"
    * do csGrade eh COMPOSTO ("Index On Tipos + Str(Ordem,3) + Cpros", dump
    * do SIGCDPRO), isto eh uma chave de 18 caracteres, e "V" eh um valor
    * PARCIAL dela. Medido no VFP9 em 2026-11-11 (automation\
    * MedirSetKeyRange777.prg, mesmo cursor e mesmo TAG):
    *
    *     SET EXACT OFF + SET KEY TO "V"                  -> 3 linhas
    *     SET EXACT ON  + SET KEY TO "V"                  -> 0 LINHAS
    *     SET EXACT ON  + SET KEY TO RANGE "V", "V"+CHR(255)...  -> 3 linhas
    *
    * E o projeto roda com EXACT ON: start\config.prg:242 faz "SET EXACT ON"
    * no nivel de cima, ao contrario do ambiente Fortyus. Transcrito
    * literalmente, portanto, o filtro casa ZERO linha e a planilha abre
    * VAZIA - sem erro, sem log e sem excecao, que eh o sintoma que manda o
    * diagnostico para o cursor ou para o form pai (a mesma familia da regra
    * #21 e da licao "INDEX composto + SEEK parcial com EXACT ON").
    *
    * SET KEY TO RANGE eh a forma que nao depende do SET EXACT: o limite
    * inferior eh o proprio tipo e o superior eh o tipo seguido de CHR(255),
    * que ordena acima de qualquer sufixo possivel da chave. Medido no mesmo
    * script: "V" -> 3, "C" -> 2, tipo inexistente -> 0, e o SUM Valos passa
    * a somar so as visiveis (250.000 contra 380.000 sem filtro). O sufixo
    * eh FOLGADO de proposito (250 chars, contra os 17 que faltariam para
    * completar a chave): limite superior maior que a chave foi medido e
    * funciona, e assim o codigo nao fica amarrado a largura exata do TAG,
    * que pertence ao form PAI e pode mudar la.
    *
    * NAO se usa "salvar e restaurar SET EXACT" no lugar disto: o SET eh
    * global, valeria para tudo que rodasse entre as duas linhas, e deixaria
    * o comportamento da tela dependendo de um estado de ambiente.
    *
    * Tipo vazio = sem filtro (o legado tambem limpa o filtro com
    * "Set Key To" sem argumento, em MontarCursorAlterados).
    *====================================================================
    PROCEDURE FiltrarGrade(par_cTipo)
        LOCAL loc_lSucesso, loc_nTotalAdicional, loc_cTipo
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorGrade)
            THIS.this_cTipo = par_cTipo
            loc_cTipo = IIF(VARTYPE(par_cTipo) = "C", ALLTRIM(par_cTipo), "")

            SELECT (THIS.this_cCursorGrade)
            SET ORDER TO TAG (THIS.this_cTagOrdem)
            IF EMPTY(loc_cTipo)
                SET KEY TO
            ELSE
                SET KEY TO RANGE loc_cTipo, loc_cTipo + REPLICATE(CHR(255), 250)
            ENDIF
            GO TOP IN (THIS.this_cCursorGrade)

            loc_nTotalAdicional = 0
            SUM Valos TO loc_nTotalAdicional
            THIS.this_nTotalAdicional = loc_nTotalAdicional

            GO TOP IN (THIS.this_cCursorGrade)

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * VerificarAcessoCoeficiente - Replica Column4.When do legado:
    *   Return fChecaAcesso([SIGCDFTI]) And (pcTipo = [V])
    * A celula do coeficiente so eh editavel com acesso ao cadastro de
    * Feitios (SIGCDFTI) E na planilha de VENDA. Chamado pelo Form no
    * When/InteractiveChange da coluna de Coefs.
    *====================================================================
    PROCEDURE VerificarAcessoCoeficiente()
        THIS.this_lAcessoFeitio = (fChecaAcesso("SIGCDFTI") AND (THIS.this_cTipo == "V"))
        RETURN THIS.this_lAcessoFeitio
    ENDPROC

    *====================================================================
    * ArmazenarCoefAnterior - Replica Column4.GotFocus do legado
    * ("PUBLIC lnCoef / lnCoef = this.Value"): guarda o valor do
    * coeficiente ANTES da edicao, para THIS.RecalcularCoeficiente()
    * decidir se a linha deve ser marcada como alterada.
    *====================================================================
    PROCEDURE ArmazenarCoefAnterior(par_nCoefAtual)
        THIS.this_nCoefAnterior = TratarNulo(par_nCoefAtual, 0)
    ENDPROC

    *====================================================================
    * RecalcularCoeficiente - Replica Column4.Valid do legado (formula
    * transcrita LITERALMENTE, sem reescrever - regra de negocio):
    *   IF this.Value <> lnCoef
    *       replace altcoef with 1 in csGrade
    *       replace cidChaves with fUniqueIds() in csGrade
    *   ENDIF
    *   replace valos with Round((( totas * coefs ) - totas ),3) in csGrade
    *   replace totalg with totas + valos in csGrade
    *   GO top / SCAN / replace acumulas with lnVr + valos + totas / lnVr = acumulas
    *   Sum Valos to lnVr -> Get_Adicional.Value
    *
    * par_nNovoCoef - valor novo da celula (TextBox.Value no legado),
    * aplicado ao registro CORRENTE do cursor csGrade.
    *====================================================================
    PROCEDURE RecalcularCoeficiente(par_nNovoCoef)
        LOCAL loc_lSucesso, loc_nRegistroAtual, loc_nAcumulado, loc_nTotalAdicional
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorGrade) AND !EOF(THIS.this_cCursorGrade)
            SELECT (THIS.this_cCursorGrade)

            IF par_nNovoCoef <> THIS.this_nCoefAnterior
                REPLACE AltCoef WITH 1 IN (THIS.this_cCursorGrade)
                REPLACE CidChaves WITH fUniqueIds() IN (THIS.this_cCursorGrade)
            ENDIF

            loc_nRegistroAtual = RECNO(THIS.this_cCursorGrade)

            REPLACE Coefs WITH par_nNovoCoef IN (THIS.this_cCursorGrade)
            REPLACE Valos WITH ROUND(((Totas * Coefs) - Totas), 3) IN (THIS.this_cCursorGrade)
            REPLACE TotalG WITH Totas + Valos IN (THIS.this_cCursorGrade)

            GO TOP IN (THIS.this_cCursorGrade)
            loc_nAcumulado = 0
            SCAN
                REPLACE Acumulas WITH loc_nAcumulado + Valos + Totas IN (THIS.this_cCursorGrade)
                loc_nAcumulado = Acumulas
            ENDSCAN

            loc_nTotalAdicional = 0
            SUM Valos TO loc_nTotalAdicional
            THIS.this_nTotalAdicional = loc_nTotalAdicional

            GO RECORD loc_nRegistroAtual IN (THIS.this_cCursorGrade)
            THIS.CarregarDoCursor(THIS.this_cCursorGrade)

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * MontarCursorAlterados - Replica a parte de dados do cmdSair.Click
    * do legado:
    *   SELECT * from csGrade where altcoef = 1 into cursor crPrFtp READWRITE
    *   Select CsGrade / Set Key To
    * (o restante do Click - ThisForm.ParentForm.Enabled = .T. e
    * ThisForm.Release - eh responsabilidade do Form, nao do BO). Chamado
    * pelo botao Encerrar antes de fechar o dialogo. MEDIDO no dump do pai:
    * o form PAI (SIGCDPRO) grava sigprftp a partir do SCAN do PROPRIO
    * csGrade por AltCoef = 1 (sigcdpro_form_codigo_fonte.txt:20840), e le
    * this_cCursorAlterados (crPrFtp) quando REMONTA a composicao, para
    * reaplicar Coefs/cidchaves (linhas 14706-14715).
    *====================================================================
    PROCEDURE MontarCursorAlterados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorGrade)
            IF USED(THIS.this_cCursorAlterados)
                USE IN (THIS.this_cCursorAlterados)
            ENDIF

            SELECT * FROM (THIS.this_cCursorGrade) WHERE AltCoef = 1 ;
                INTO CURSOR (THIS.this_cCursorAlterados) READWRITE

            SELECT (THIS.this_cCursorGrade)
            SET KEY TO

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

