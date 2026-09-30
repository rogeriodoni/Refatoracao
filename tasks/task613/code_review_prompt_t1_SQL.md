# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CCHAVE1S' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNTMSTR1, LNCONTA1, LLERROR, LNCONTA2
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TORNARCONTROLESVISIVE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNTMSTR1, LNCONTA1, LLERROR, LNCONTA2

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
		Select Distinct a.cEmps;
		  From ('crRel1') a;
		Select ('crGrafico1')
			Select ('crRel1')
			Select ('crGrafico1')
			Insert Into crGrafico1 (cchave1s,ctitulo1s,cempresas) Values (m.lcChave1,m.lcTitulo1,m.lcEmpresa)
				.ControlSource = 'crGrafico1.gGrafico1s'
	Select ('crGrafico1')
	.cntGrf1.oleGrafico1.ControlSource = ''

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGf2.prg) - TRECHOS RELEVANTES PARA PASS SQL (1412 linhas total):

*-- Linhas 27 a 51:
27: *                TornarControlesVisiveis, mesmo padrao de FormSigReCmg
28: *                (cnt_4c_Grf1/cnt_4c_Grf2/cnt_4c_Aguarde sao flutuantes,
29: *                controlados pelo Init/eventos, nao pelo
30: *                TornarControlesVisiveis generico). .ControlSource NAO eh
31: *                setado aqui - o legado so faz
32: *                ".cntGrf1.oleGrafico1.ControlSource = 'crGrafico1.gGrafico1s'"
33: *                dentro de mGeraGrafico, depois que o cursor crGrafico1 (e o
34: *                registro correspondente) ja existe; setar antes estouraria
35: *                alias inexistente (mesma familia da regra de
36: *                Column.ControlSource antes do cursor existir). Fica para a
37: *                Fase 7/8, junto com o resto de mGeraGrafico.
38: * Atualizado em: Fase 6 - cnt_4c_Grf2 (container flutuante do dump legado,
39: *                Top=558/Left=559/Width=228/Height=35/BackColor=branco)
40: *                com lbl_4c_LblChave1 ("Grupo / Vendedor :") e
41: *                cbo_4c_CmbChave1 (ComboBox Style=2/ColumnCount=1/
42: *                FontName="Courier New"). Container comeca Visible=.F. e
43: *                fica filtrado em TornarControlesVisiveis, mesmo padrao de
44: *                cnt_4c_Grf1: o Init legado faz ".cntGrf2.Visible = .f."
45: *                tanto ANTES quanto DEPOIS de mGeraGrafico (o combo de
46: *                selecao de chave nunca aparece neste fluxo).
47: *
48: *                LOOKUPS: o SCX legado NAO tem lookup nenhum - zero
49: *                fwBuscaExt / fwBuscaSel / sigacess() / mAddColuna /
50: *                Acesso*() no dump inteiro (SigPrGf2_form_codigo_fonte.txt).
51: *                Esta tela eh um visualizador de grafico: o unico campo de

*-- Linhas 86 a 131:
86: *                reposicionamento/redimensionamento dinamico do proprio
87: *                cntGrf2 (calculados a partir do tamanho dos valores de
88: *                crRel1.cEmps) e o DESENHO do MSGraph no OleBoundControl
89: *                (Append General + ControlSource + propriedades do chart)
90: *                ficam para a Fase 7/8, junto com o resto de mGeraGrafico e
91: *                com os Click dos 2 botoes de obj_4c_CmdgGrafico.
92: *
93: * Atualizado em: Fase 7/8 - fecha o mgeragrafico legado: PopularComboChaves()
94: *                (AddItem + reposicionamento de cnt_4c_Grf2, so na 1a chamada,
95: *                guardado pelo ListCount) e DesenharGrafico() (cursor LOCAL
96: *                cursor_4c_OleGrafico1 - equivalente a crGrafico1, com o
97: *                binario do OLE que o BO nao guarda - Append General +
98: *                ControlSource + toda a formatacao do MSGraph.Chart), ambos
99: *                por tras de MGeraGrafico() (fonte UNICA, chamada tanto por
100: *                ExecutarCargaInicial() - equivalente ao trecho do Init
101: *                legado que chama ".mGeraGrafico()" antes do Show() - quanto
102: *                por CboChave1Click(), que agora delega em vez de duplicar
103: *                Validar/Obter/Gerar). BINDEVENT dos 2 botoes de
104: *                obj_4c_CmdgGrafico: Buttons(1) "Grafico" -> BtnGraficoClick
105: *                (Report Form do registro atual do cache, igual ao
106: *                cmdImprimir.Click legado) e Buttons(2) "Encerrar" ->
107: *                BtnEncerrarClick (fecha o cursor do OLE, libera o form e
108: *                reabilita this_oFormPai, igual ao cmdSair.Click legado).
109: *                Medido no VFP9 (2026-09-29): fluxo pai->filho fim-a-fim
110: *                (crRel1 populado na sessao privada do pai, filho aberto com
111: *                CREATEOBJECT("FormSigPrGf2", <pai>)) prova o combo populado,
112: *                o BO gerando a serie certa e a troca de chave regenerando -
113: *                o unico ponto que a maquina de teste nao cobre eh o proprio
114: *                APPEND GENERAL CLASS "MSGraph.Chart", porque este ambiente
115: *                nao tem esse OLE server registrado (OLE error 0x800401f3);
116: *                por isso DesenharGrafico() isola o INSERT/APPEND GENERAL num
117: *                TRY proprio e desfaz a linha de cache se falhar - sem o
118: *                rollback, a mesma chave nunca mais tentaria desenhar (ficaria
119: *                para sempre com o cache "encontrado" e o gGrafico1s vazio).
120: *
121: * CONTRATO COM O FORM PAI (FormSigPrGf1, ja completo - ver o comentario acima
122: * de "CREATEOBJECT("FormSigPrGf2", THIS)" em FormSigPrGf1.BtnProcessarClick)
123: * --------------------------------------------------------------------------
124: * 1) CREATEOBJECT("FormSigPrGf2", <form pai>) - UM parametro, a referencia do
125: *    form pai (par_loForm1, mesmo nome do "loForm1" recebido pelo Init
126: *    legado). Sem parametro, THIS.this_oFormPai aponta para o proprio form
127: *    (equivalente a "Iif(Type('m.loForm1')=='O',m.loForm1,ThisForm)" do
128: *    legado).
129: * 2) THIS.DataSessionId = par_loForm1.DataSessionId ANTES do DODEFAULT() -
130: *    entra na MESMA sessao privada do pai (DataSession=2 dele) para enxergar
131: *    o cursor global "crRel1" que o pai populou antes de abrir este form.

*-- Linhas 447 a 466:
447:     * vai alternar a visibilidade eh a logica de Init/mGeraGrafico da
448:     * Fase 7/8, igual ao padrao de FormSigReCmg.
449:     *
450:     * .ControlSource do OLE NAO eh setado aqui: o legado so faz
451:     * ".ControlSource = 'crGrafico1.gGrafico1s'" dentro de mGeraGrafico,
452:     * depois que o cursor crGrafico1 e o registro correspondente ja existem -
453:     * setar antes estouraria alias inexistente. Fica para a Fase 7/8.
454:     *==========================================================================
455:     PROTECTED PROCEDURE ConfigurarGrf1()
456:         LOCAL loc_oErro
457: 
458:         TRY
459:             THIS.AddObject("cnt_4c_Grf1", "Container")
460:             WITH THIS.cnt_4c_Grf1
461:                 .Top           = 120
462:                 .Left          = 17
463:                 .Width         = 770
464:                 .Height        = 429
465:                 .BackStyle     = 1
466:                 .SpecialEffect = 0

*-- Linhas 750 a 791:
750:     * igual ao "If Empty(...)" do legado.
751:     *
752:     * m.lnTmStr1 do legado (Len(laVendedor(1)), 1o elemento do array
753:     * Select Distinct SEM AllTrim - cEmps eh char de largura fixa, entao
754:     * todos os elementos tem o MESMO Len) vira aqui o MAIOR comprimento
755:     * entre as chaves ja TRIMADAS por PopularChaves (regra #22/PILAR 3: o BO
756:     * ja decidiu usar ALLTRIM na Fase 1/2, entao os comprimentos podem
757:     * variar) - o maior valor preserva o alinhamento em coluna do PadR
758:     * usado no AddItem.
759:     *==========================================================================
760:     PROTECTED PROCEDURE PopularComboChaves()
761:         LOCAL loc_oCnt, loc_oCombo, loc_oLabel, loc_nTamanho, loc_cAlias, loc_oErro
762: 
763:         loc_oCnt   = THIS.cnt_4c_Grf2
764:         loc_oCombo = loc_oCnt.cbo_4c_CmbChave1
765:         loc_oLabel = loc_oCnt.lbl_4c_LblChave1
766: 
767:         IF loc_oCombo.ListCount > 0
768:             RETURN
769:         ENDIF
770: 
771:         TRY
772:             IF THIS.this_oBusinessObject.PopularChaves()
773:                 loc_cAlias = THIS.this_oBusinessObject.this_cCursorChaves
774: 
775:                 loc_nTamanho = 1
776:                 SELECT (loc_cAlias)
777:                 SCAN
778:                     loc_nTamanho = MAX(loc_nTamanho, LEN(ALLTRIM(Chaves)))
779:                 ENDSCAN
780: 
781:                 *-- Legado: With .cntGrf2 / With .lblChave1 / .Left=5 / .Top=10
782:                 loc_oLabel.Left = 5
783:                 loc_oLabel.Top  = 10
784: 
785:                 loc_oCombo.Clear
786:                 loc_oCombo.Alignment         = 0
787:                 loc_oCombo.ColumnCount       = 0
788:                 loc_oCombo.ColumnLines       = .F.
789:                 loc_oCombo.IncrementalSearch = .T.
790:                 loc_oCombo.FontName          = "Courier New"
791:                 loc_oCombo.FontSize          = 9

*-- Linhas 800 a 818:
800:                 loc_oCombo.Top               = 5
801:                 loc_oCombo.Left              = 5 + loc_oLabel.Width
802: 
803:                 SELECT (loc_cAlias)
804:                 GO TOP
805:                 SCAN
806:                     loc_oCombo.AddItem(PADR(ALLTRIM(Chaves), loc_nTamanho))
807:                 ENDSCAN
808: 
809:                 loc_oCnt.Height = loc_oCombo.Height + 10
810:                 loc_oCnt.Width  = loc_oLabel.Width + loc_oCombo.Width + 10
811:                 loc_oCnt.Top    = THIS.obj_4c_CmdgGrafico.Top - loc_oCnt.Height
812:                 loc_oCnt.Left   = THIS.Width - loc_oCnt.Width - 5
813:             ENDIF
814:         CATCH TO loc_oErro
815:             MsgErro(loc_oErro.Message + CHR(13) + ;
816:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
817:                 "Procedure: " + loc_oErro.Procedure, "Erro em PopularComboChaves")
818:         ENDTRY

*-- Linhas 873 a 954:
873:     *
874:     * Transcricao de mgeragrafico legado (linhas 486-634 do dump): Locate
875:     * por chave no cursor de cache -> achou (cache hit) => so reposiciona o
876:     * registro corrente e faz Refresh (o ControlSource fixo em
877:     * "<cursor>.gGrafico1s" reflete o registro corrente); nao achou => monta
878:     * o General a partir das series do BO (mesmo layout Data() do legado:
879:     * lcStrg1+CRLF+lcStrg2+CRLF+lcStrg3 = this_cLabelsMeses/this_cSerieFalha/
880:     * this_cSerieRecuperacao) e aplica toda a formatacao do chart.
881:     *==========================================================================
882:     PROTECTED PROCEDURE DesenharGrafico()
883:         LOCAL loc_oBO, loc_oOle, loc_cChavePad, loc_cDataChart, loc_nGrupo, ;
884:               loc_nMes, loc_lResultado, loc_lFalhaOle, loc_oErro, loc_oErroOle
885: 
886:         loc_lResultado = .F.
887:         loc_lFalhaOle  = .F.
888:         loc_oBO        = THIS.this_oBusinessObject
889:         loc_oOle       = THIS.cnt_4c_Grf1.obj_4c_OleGrafico1
890: 
891:         TRY
892:             IF !USED(THIS.this_cCursorOleGrafico)
893:                 CREATE CURSOR (THIS.this_cCursorOleGrafico) ;
894:                     (gGrafico1s G(4), cChave1s C(100), cEmpresas C(254), cTitulo1s C(128))
895:                 INDEX ON cChave1s TAG cChave1s
896:             ENDIF
897: 
898:             loc_cChavePad = PADR(ALLTRIM(loc_oBO.this_cChaveAtual), 100)
899: 
900:             SELECT (THIS.this_cCursorOleGrafico)
901:             LOCATE FOR cChave1s == loc_cChavePad
902: 
903:             IF !FOUND()
904:                 loc_cDataChart = loc_oBO.this_cLabelsMeses + CHR(13) + CHR(10) + ;
905:                     loc_oBO.this_cSerieFalha + CHR(13) + CHR(10) + ;
906:                     loc_oBO.this_cSerieRecuperacao
907: 
908:                 *-- INSERT/APPEND GENERAL isolados num TRY proprio: se o OLE
909:                 *-- server "MSGraph.Chart" nao estiver registrado na maquina
910:                 *-- (medido: OLE error 0x800401f3 "Cadeia de caracteres de
911:                 *-- classe invalida"), a linha de cache JA FOI inserida antes
912:                 *-- do APPEND GENERAL estourar - sem desfazer, a PROXIMA
913:                 *-- chamada para a MESMA chave acharia essa linha via LOCATE
914:                 *-- (FOUND()=.T.) e trataria como cache HIT, nunca mais
915:                 *-- tentando desenhar (gGrafico1s ficaria para sempre vazio,
916:                 *-- sem erro nenhum). Por isso a linha eh apagada no CATCH.
917:                 TRY
918:                     INSERT INTO (THIS.this_cCursorOleGrafico) (cChave1s, cTitulo1s, cEmpresas) ;
919:                         VALUES (loc_cChavePad, LEFT(loc_oBO.this_cTitulo1, 128), loc_oBO.this_cEmpresaAtual)
920: 
921:                     APPEND GENERAL gGrafico1s CLASS "MSGraph.Chart" DATA (loc_cDataChart)
922:                 CATCH TO loc_oErroOle
923:                     loc_lFalhaOle = .T.
924: 
925:                     SELECT (THIS.this_cCursorOleGrafico)
926:                     LOCATE FOR cChave1s == loc_cChavePad
927:                     IF FOUND()
928:                         DELETE
929:                     ENDIF
930: 
931:                     loc_oBO.this_cMensagemErro = loc_oErroOle.Message
932:                 ENDTRY
933:             ENDIF
934: 
935:             IF !FOUND() AND !loc_lFalhaOle
936:                 *-- So chega aqui com o APPEND GENERAL acima OK: aplica o
937:                 *-- ControlSource e toda a formatacao (Font/Interior/Border/
938:                 *-- Axes/ChartGroups) do chart recem-criado.
939:                 loc_oOle.ControlSource = THIS.this_cCursorOleGrafico + ".gGrafico1s"
940: 
941:                 WITH loc_oOle
942:                     .AutoActivate    = 0
943:                     .AutoSize        = .T.
944:                     .Height          = .Height
945:                     .Left            = .Left
946:                     .Sizable         = .T.
947:                     .Stretch         = 2
948:                     .Top             = .Top
949:                     .Width           = .Width
950:                     .HasLegend       = .T.
951:                     .HasTitle        = .T.
952:                     .DisplayBlanksAs = 1
953:                     .HasAxis(2)      = .T.
954:                     .Type            = -4100

*-- Linhas 1067 a 1086:
1067:                 IF !loc_lFalhaOle
1068:                     *-- Cache HIT de verdade (achou na LOCATE original, antes
1069:                     *-- do bloco de criacao acima rodar) - so reposiciona o
1070:                     *-- ControlSource; o registro corrente ja esta certo.
1071:                     loc_oOle.ControlSource = THIS.this_cCursorOleGrafico + ".gGrafico1s"
1072:                 ENDIF
1073:             ENDIF
1074: 
1075:             IF !loc_lFalhaOle
1076:                 loc_oOle.Refresh
1077:                 loc_lResultado = .T.
1078:             ENDIF
1079:         CATCH TO loc_oErro
1080:             MsgErro(loc_oErro.Message + CHR(13) + ;
1081:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1082:                 "Procedure: " + loc_oErro.Procedure, "Erro em DesenharGrafico")
1083:         ENDTRY
1084: 
1085:         RETURN loc_lResultado
1086:     ENDPROC

*-- Linhas 1153 a 1171:
1153:     *   .cntAguarde.Visible = .f. / .Refresh / .Draw / .LockScreen = .f.
1154:     *
1155:     * A parte de DADOS do mGeraGrafico eh SigPrGf2BO.GerarGrafico (completo
1156:     * desde a Fase 2); a parte de DESENHO (Append General + ControlSource do
1157:     * OleBoundControl + propriedades do MSGraph) entra na Fase 7/8.
1158:     *
1159:     * PUBLIC (sem PROTECTED): exigencia do BINDEVENT.
1160:     *
1161:     * A mensagem de falha eh exibida DEPOIS do ENDTRY, com a tela ja
1162:     * destravada - dialogo aberto com LockScreen = .T. deixa a janela
1163:     * congelada por tras. O LockScreen = .F. mora no FINALLY para valer
1164:     * tambem quando o CATCH dispara.
1165:     *==========================================================================
1166:     PROCEDURE CboChave1Click()
1167:         LOCAL loc_cAviso, loc_oErro
1168: 
1169:         loc_cAviso = ""
1170: 
1171:         TRY

*-- Linhas 1236 a 1254:
1236:     *   With ThisForm
1237:     *       .LockScreen = .t.
1238:     *       m.lnRecno1 = RecNo('crGrafico1')
1239:     *       Select ('crGrafico1')
1240:     *       Report Form SigPrGf1 Next 1 To Printer Prompt Noconsole
1241:     *       If BetWeen(m.lnRecno1,1,RecCount('crGrafico1'))
1242:     *           GoTo m.lnRecno1 In ('crGrafico1')
1243:     *       EndIf
1244:     *       .cntGrf2.cmbChave1.SetFocus
1245:     *       .Refresh / .Draw / .LockScreen = .f.
1246:     *   EndWith
1247:     *
1248:     * crGrafico1 -> this_cCursorOleGrafico (cursor_4c_OleGrafico1, criado em
1249:     * DesenharGrafico()). Guard IF FILE(...) antes do REPORT FORM (regra
1250:     * CLAUDE.md sobre .Picture/.frx ausente falhar em silencio e sobre o
1251:     * helper canonico de REPORT FORM) - SigPrGf1.frx nao existe no acervo
1252:     * (nem em origem\, nem no historico do git): a impressao real so
1253:     * funciona quando o arquivo for adicionado a
1254:     * projeto\app\reports\SigPrGf1.frx; ate la o usuario ve o aviso

*-- Linhas 1262 a 1280:
1262: 
1263:             loc_nRecnoAtual = RECNO(THIS.this_cCursorOleGrafico)
1264: 
1265:             SELECT (THIS.this_cCursorOleGrafico)
1266: 
1267:             loc_cFrx = FULLPATH(gc_4c_CaminhoReports + "SigPrGf1.frx")
1268: 
1269:             IF !FILE(loc_cFrx)
1270:                 MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
1271:                     "o encontrado: " + loc_cFrx, "Erro")
1272:             ELSE
1273:                 REPORT FORM (gc_4c_CaminhoReports + "SigPrGf1") NEXT 1 TO PRINTER PROMPT NOCONSOLE
1274:             ENDIF
1275: 
1276:             IF BETWEEN(loc_nRecnoAtual, 1, RECCOUNT(THIS.this_cCursorOleGrafico))
1277:                 GO loc_nRecnoAtual IN (THIS.this_cCursorOleGrafico)
1278:             ENDIF
1279: 
1280:             *-- SetFocus so com o container visivel e o combo habilitado -

*-- Linhas 1302 a 1343:
1302:     *
1303:     *   With ThisForm
1304:     *       .LockScreen = .t.
1305:     *       .cntGrf1.oleGrafico1.ControlSource = ''
1306:     *       If Used('crGrafico1')
1307:     *           Use In ('crGrafico1')
1308:     *       EndIf
1309:     *       .Release / .Refresh / .LockScreen = .f.
1310:     *       If Type('ThisForm.poForm1')=='O'
1311:     *           .poForm1.LockScreen = .t.
1312:     *           .poForm1.Enabled = .t.
1313:     *           .poForm1.LockScreen = .f.
1314:     *       EndIf
1315:     *   EndWith
1316:     *
1317:     * poForm1 -> this_oFormPai. Guard adicional (!= THIS) para o caso deste
1318:     * form ter sido aberto SEM form pai (Init: this_oFormPai = THIS quando
1319:     * par_loForm1 nao eh objeto) - nesse caso nao ha ninguem para reabilitar.
1320:     * crRel1 (cursor global do form pai) NAO eh fechado aqui - ver Destroy().
1321:     *==========================================================================
1322:     PROCEDURE BtnEncerrarClick()
1323:         LOCAL loc_oErro
1324: 
1325:         TRY
1326:             THIS.LockScreen = .T.
1327: 
1328:             THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
1329: 
1330:             IF USED(THIS.this_cCursorOleGrafico)
1331:                 USE IN (THIS.this_cCursorOleGrafico)
1332:             ENDIF
1333: 
1334:             THIS.Release()
1335:             THIS.Refresh()
1336:             THIS.LockScreen = .F.
1337: 
1338:             IF VARTYPE(THIS.this_oFormPai) = "O" AND !(THIS.this_oFormPai == THIS)
1339:                 THIS.this_oFormPai.LockScreen = .T.
1340:                 THIS.this_oFormPai.Enabled    = .T.
1341:                 THIS.this_oFormPai.LockScreen = .F.
1342:             ENDIF
1343:         CATCH TO loc_oErro


### BO (C:\4c\projeto\app\classes\SigPrGf2BO.prg):
*============================================================================
* SigPrGf2BO.prg - Business Object para "Grafico de Falha X Recuperacao
* Mensal" (SIGPRGF2)
*
* Form OPERACIONAL (SIGPRGF2 / FormSigPrGf2): tela de EXIBICAO de grafico
* (MSGraph.Chart via OleBoundControl), aberta pelo form pai (equivalente ao
* SIGPRGF1/FormSigPrGf1) que ja processou e deixou pronto um cursor agregado
* por mes (crRel1 no legado; normalmente SigPrGf1BO.this_cCursorResultado no
* sistema novo). O SIGPRGF2 nao processa dados novos contra o banco - ele so
* agrupa/formata o que ja veio no cursor de origem, monta as series do
* grafico (Falha/Recuperacao) por mes e mantem um cache por chave (empresa)
* para nao recalcular ao trocar no combo.
*
* Nao existe tabela proprietaria (this_cTabela fica vazio): este BO nao faz
* INSERT/UPDATE/DELETE contra o SQL Server, so agrega o cursor de origem.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrGf2BO AS BusinessBase

    *==========================================================================
    * Cursor de origem (crRel1 do legado) - resultado agregado por mes,
    * fornecido pelo form pai. NAO e populado por este BO; apenas consultado
    * (Select Distinct .../ Scan While ... do mGeraGrafico legado).
    *==========================================================================
    this_cCursorOrigem = ""

    *==========================================================================
    * Cursor com as chaves distintas do cursor de origem, para popular o
    * combo "Grupo / Vendedor :" (cmbChave1 - equivalente a "Select Distinct
    * a.cEmps From crRel1 a Order By 1 Into Array laVendedor" do legado).
    * Usamos cursor em vez de ARRAY para nao depender de escopo de m.array.
    *==========================================================================
    this_cCursorChaves = ""

    *==========================================================================
    * Cursor cache dos graficos ja gerados por chave (equivalente a
    * crGrafico1: gGrafico1s g(4)/cChave1s c(100)/cempresas c(254)/
    * ctitulo1s c(128)). A parte binaria do OLE (Append General ... Class
    * 'MSGraph.Chart') e responsabilidade do Form (glue com o OleBoundControl);
    * este BO cuida so da chave/titulos/series text-based.
    *==========================================================================
    this_cCursorGrafico = ""

    *==========================================================================
    * Chave (empresa) atualmente selecionada no combo (cChave1s do legado)
    *==========================================================================
    this_cChaveAtual = ""

    *==========================================================================
    * Titulos do grafico da chave atual (cTitulo1s/ctitulo2s do cursor de
    * origem - mGeraGrafico monta m.lcTitulo1 = AllTrim(cTitulo1s) + Chr(13)
    * + AllTrim(ctitulo2s))
    *==========================================================================
    this_cTitulo1      = ""
    this_cTitulo2      = ""
    this_cEmpresaAtual = ""

    *==========================================================================
    * Series do grafico (lnNgrupos fixo = 2: Falha e Recuperacao) e a
    * contagem de meses agregados na chave atual (lnNmeses)
    *==========================================================================
    this_nTotalGrupos = 2
    this_nTotalMeses  = 0

    *==========================================================================
    * Strings TAB-separadas com rotulos de mes e valores das duas series
    * (lcStrg1/lcStrg2/lcStrg3 do mGeraGrafico legado). O Form usa essas
    * strings para montar o Data() do Append General no OleBoundControl.
    *==========================================================================
    this_cLabelsMeses      = ""
    this_cSerieFalha       = ""
    this_cSerieRecuperacao = ""

    *==========================================================================
    * Flags de estado
    *==========================================================================
    this_lChaveEmCache  = .F.  && .T. quando a chave ja tinha grafico no cache (Locate achou)
    this_lGraficoGerado = .F.  && .T. quando ha dados validos para desenhar o grafico

    *==========================================================================
    * Init - Nao ha tabela proprietaria (form so exibe/agrega o que o form
    * pai processou), entao this_cTabela/this_cCampoChave ficam vazios.
    * Inicializa os nomes canonicos dos cursores de trabalho deste BO.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            THIS.this_cCursorChaves  = "cursor_4c_Chaves"
            THIS.this_cCursorGrafico = "cursor_4c_Grafico"

            THIS.this_nTotalGrupos = 2
            THIS.this_nTotalMeses  = 0

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Decisao de arquitetura (Fase 2 - CRUD): SIGPRGF2 eh um VISUALIZADOR de
    * grafico (Falha X Recuperacao Mensal) que so agrega/formata o cursor de
    * origem (crRel1 no legado, this_cCursorOrigem aqui) recebido do form pai
    * (equivalente ao SigPrGf1). O dump do legado nao tem NENHUM Insert
    * Into/Update/Delete From contra tabela do SQL Server: o unico Insert Into
    * do metodo mgeragrafico grava no cursor LOCAL crGrafico1 (cache de
    * graficos ja montados por chave), que aqui vira THIS.this_cCursorGrafico
    * dentro de GerarGrafico(). CarregarDoCursor() mapeia as colunas desse
    * cache; Inserir()/Atualizar()/ExecutarExclusao() NAO sao sobrescritos
    * neste BO porque o comportamento padrao herdado de BusinessBase (recusar
    * a operacao) ja eh o correto para um BO sem tabela proprietaria.
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia uma linha do cursor de cache de graficos
    * (this_cCursorGrafico, layout identico ao crGrafico1 legado) para as
    * propriedades do BO. Usado apos LOCATE/SEEK em GerarGrafico() ou por
    * quem precisar inspecionar uma linha ja posicionada do cache.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cChaveAtual      = ALLTRIM(TratarNulo(cChave1s, ""))
            THIS.this_cEmpresaAtual    = TratarNulo(cEmpresas, "")
            THIS.this_cTitulo1         = TratarNulo(cTitulo1s, "")
            THIS.this_cLabelsMeses     = TratarNulo(cLabelsMeses, "")
            THIS.this_cSerieFalha      = TratarNulo(cSerieFalha, "")
            THIS.this_cSerieRecuperacao = TratarNulo(cSerieRecuperacao, "")
            THIS.this_nTotalMeses      = OCCURS(CHR(9), THIS.this_cLabelsMeses)

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave do grafico atualmente selecionado (equivalente
    * ao cChave1s do cache legado). Nao ha tabela proprietaria neste BO; a
    * chave existe so para identificar a linha do cache de graficos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cChaveAtual)
    ENDPROC

    *--------------------------------------------------------------------------
    * PopularChaves - Monta THIS.this_cCursorChaves com as chaves distintas do
    * cursor de origem (equivalente a "Select Distinct a.cEmps From crRel1
    * Order By 1 Into Array laVendedor" do mGeraGrafico legado). O Form usa
    * este cursor para popular o combo "Grupo / Vendedor :" (cmbChave1).
    *--------------------------------------------------------------------------
    PROCEDURE PopularChaves()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            IF !USED(THIS.this_cCursorOrigem)
                THIS.this_cMensagemErro = "Cursor de origem n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF USED(THIS.this_cCursorChaves)
                    USE IN (THIS.this_cCursorChaves)
                ENDIF

                SELECT DISTINCT ALLTRIM(cEmps) AS Chaves ;
                    FROM (THIS.this_cCursorOrigem) ;
                    ORDER BY 1 ;
                    INTO CURSOR (THIS.this_cCursorChaves) READWRITE

                IF RECCOUNT(THIS.this_cCursorChaves) > 0
                    GO TOP IN (THIS.this_cCursorChaves)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarGrafico - Equivalente ao mGeraGrafico legado (parte de dados: o
    * desenho do OLE/MSGraph.Chart fica por conta do Form). Se a chave ja
    * esta no cache (this_cCursorGrafico), so recarrega as propriedades a
    * partir dele (LOCATE, igual ao "Locate For crGrafico1.cChave1s==..." do
    * legado). Senao, varre this_cCursorOrigem (equivalente ao "Scan While
    * crRel1.cEmps==m.lcChave1" do legado), monta os rotulos de mes e as duas
    * series (Falha/Recuperacao) separados por TAB e grava a linha nova no
    * cache - so entao Insert Into acontece, e sempre no cursor LOCAL, nunca
    * no SQL Server.
    *--------------------------------------------------------------------------
    PROCEDURE GerarGrafico(par_cChave)
        LOCAL loc_lResultado, loc_oErro, loc_cChavePad, loc_cTitulo1, ;
              loc_cEmpresa, loc_cLabelsMeses, loc_cSerieFalha, ;
              loc_cSerieRecuperacao, loc_nMeses, loc_cPointAntigo, ;
              loc_cSeparAntigo

        loc_lResultado           = .F.
        THIS.this_lChaveEmCache  = .F.
        THIS.this_lGraficoGerado = .F.

        TRY
            IF EMPTY(par_cChave) OR !USED(THIS.this_cCursorOrigem)
                THIS.this_cMensagemErro = "Chave n" + CHR(227) + "o informada ou cursor de origem n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                loc_cChavePad = PADR(ALLTRIM(par_cChave), 100)
                THIS.this_cChaveAtual = ALLTRIM(par_cChave)

                IF !USED(THIS.this_cCursorGrafico)
                    CREATE CURSOR (THIS.this_cCursorGrafico) ;
                        (cChave1s C(100), cEmpresas C(254), cTitulo1s M, ;
                         cLabelsMeses M, cSerieFalha M, cSerieRecuperacao M)
                    INDEX ON cChave1s TAG cChave1s
                ENDIF

                SELECT (THIS.this_cCursorGrafico)
                LOCATE FOR cChave1s == loc_cChavePad

                IF FOUND()
                    THIS.this_lChaveEmCache     = .T.
                    THIS.this_cEmpresaAtual     = TratarNulo(cEmpresas, "")
                    THIS.this_cTitulo1          = TratarNulo(cTitulo1s, "")
                    * cTitulo2s nao existe no cache (crGrafico1 legado so guarda
                    * o titulo ja concatenado) - fica vazio ate a proxima geracao
                    THIS.this_cTitulo2          = ""
                    THIS.this_cLabelsMeses      = TratarNulo(cLabelsMeses, "")
                    THIS.this_cSerieFalha       = TratarNulo(cSerieFalha, "")
                    THIS.this_cSerieRecuperacao = TratarNulo(cSerieRecuperacao, "")
                    THIS.this_nTotalMeses       = OCCURS(CHR(9), THIS.this_cLabelsMeses)
                    THIS.this_lGraficoGerado    = .T.
                    loc_lResultado = .T.
                ELSE
                    SELECT (THIS.this_cCursorOrigem)
                    LOCATE FOR ALLTRIM(cEmps) == ALLTRIM(par_cChave)

                    IF !FOUND()
                        THIS.this_cMensagemErro = "Nenhum registro encontrado para a chave [" + ALLTRIM(par_cChave) + "]."
                    ELSE
                        loc_cTitulo1 = ALLTRIM(cTitulo1s) + CHR(13) + ALLTRIM(cTitulo2s)
                        THIS.this_cTitulo2 = ALLTRIM(TratarNulo(cTitulo2s, ""))
                        loc_cEmpresa = TratarNulo(cEmpresas, "")

                        loc_cLabelsMeses      = ""
                        loc_cSerieFalha       = "Falha"
                        loc_cSerieRecuperacao = "Recupera" + CHR(231) + CHR(227) + "o"
                        loc_nMeses = 0

                        * Isolamento de locale igual ao mGeraGrafico legado -
                        * TRANSFORM abaixo usa picture fixa "999,999,999.99"
                        loc_cPointAntigo = SET("POINT")
                        loc_cSeparAntigo = SET("SEPARATOR")
                        SET POINT TO ","
                        SET SEPARATOR TO "."

                        TRY
                            SCAN WHILE ALLTRIM(cEmps) == ALLTRIM(par_cChave)
                                loc_nMeses = loc_nMeses + 1
                                loc_cLabelsMeses      = loc_cLabelsMeses + CHR(9) + ALLTRIM(TratarNulo(cStranomes, ""))
                                loc_cSerieFalha       = loc_cSerieFalha + CHR(9) + ALLTRIM(TRANSFORM(NVL(nFalhas, 0), "999,999,999.99"))
                                loc_cSerieRecuperacao = loc_cSerieRecuperacao + CHR(9) + ALLTRIM(TRANSFORM(NVL(nPesoccbs, 0), "999,999,999.99"))
                            ENDSCAN
                        FINALLY
                            SET POINT TO (loc_cPointAntigo)
                            SET SEPARATOR TO (loc_cSeparAntigo)
                        ENDTRY

                        SELECT (THIS.this_cCursorGrafico)
                        INSERT INTO (THIS.this_cCursorGrafico) ;
                            (cChave1s, cEmpresas, cTitulo1s, cLabelsMeses, cSerieFalha, cSerieRecuperacao) ;
                            VALUES (loc_cChavePad, loc_cEmpresa, loc_cTitulo1, loc_cLabelsMeses, loc_cSerieFalha, loc_cSerieRecuperacao)

                        THIS.this_cTitulo1          = loc_cTitulo1
                        THIS.this_cEmpresaAtual     = loc_cEmpresa
                        THIS.this_cLabelsMeses      = loc_cLabelsMeses
                        THIS.this_cSerieFalha       = loc_cSerieFalha
                        THIS.this_cSerieRecuperacao = loc_cSerieRecuperacao
                        THIS.this_nTotalMeses       = loc_nMeses
                        THIS.this_lChaveEmCache     = .F.
                        THIS.this_lGraficoGerado    = .T.
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera os cursores locais deste BO (nunca tocam SQL Server)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF !EMPTY(THIS.this_cCursorChaves) AND USED(THIS.this_cCursorChaves)
            USE IN (THIS.this_cCursorChaves)
        ENDIF

        IF !EMPTY(THIS.this_cCursorGrafico) AND USED(THIS.this_cCursorGrafico)
            USE IN (THIS.this_cCursorGrafico)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

