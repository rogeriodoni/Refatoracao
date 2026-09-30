# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCNB.pgfprincipal.pgfiltro): Left original=279 vs migrado 'lbl_4c_Label1' Left=501 (diff=222px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCNB.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2225 linhas total):

*-- Linhas 15 a 76:
15: *
16: * FASE 4/8: Grid de operacoes (grdope) + botoes reais da Page1 (Processar/
17: * Encerrar/Marcar Tudo/Desmarcar Tudo) e AlternarPagina(). Campos de filtro
18: * (Empresa/Periodo/Conta/Titulo Banco) ficam para as Fases 5-6; BINDEVENTs e
19: * logica de negocio (validacoes do Processar, geracao do CNAB) para as
20: * Fases 7-8.
21: *
22: * FASE 5/8: Page2 (Dados) - faixa do cabecalho (regra #11, nas duas
23: * paginas) + primeiro grupo de campos "principais" de pgdados (Say12/
24: * spndias/Say1 - "Protestar apos <N> dias", ja com property no BO
25: * this_nDiasProtesto). O aviso de endereco longo (Say2/Botao1), a grade de
26: * titulos (grdope 8 colunas) e os botoes de acao de Page2 (cmdTestaPos/
27: * Commandgroup1/Commandgroup2) ficam para a Fase 6.
28: *
29: * FASE 6/8: Campos restantes da Page1 (Empresa/Periodo/Banco-Conta/Titulo
30: * Banco) + lookups completos via FormBuscaAuxiliar (fAcessoEmpresa/
31: * fAcessoContas nao portadas). BINDEVENTs registrados em
32: * ConfigurarBindEventsFiltro(). Wiring dos botoes Processar/Marcar/
33: * Desmarcar/Encerrar e geracao do CNAB ficou para as Fases 7-8.
34: *
35: * FASE 7/8: Eventos principais dos botoes ja construidos - Processar
36: * (THIS.ProcessarTitulos(), transcrito de PROCEDURE processamento do
37: * legado), Encerrar, Marcar/Desmarcar Tudo (Page1), e o "round-trip" da
38: * Page2: grade de titulos (grd_4c_Titulos, 8 colunas + DynamicForeColor
39: * para EndErro), Marcar/Desmarcar Tudo dos titulos, checkbox individual
40: * (guard EndErro=1, equivalente ao Column1.Check1.When do legado) e Voltar
41: * (cmd_4c_Encerrar de Page2, que reaproveita o Caption/Picture "Encerrar"
42: * do legado mas volta para o filtro, nao fecha o form). O aviso de
43: * endereco longo (Say2/Botao1) foi reposicionado para LOGO ABAIXO do grupo
44: * "Protestar apos" (regra #11/#39 - a faixa do cabecalho ocupa o lugar que
45: * ele tinha no legado).
46: *
47: * FASE 8/8: obj_4c_Comandos (Commandgroup1 no legado - Gerar CNAB/
48: * Relatorio/Boleto) adicionado em cnt_4c_BotoesAcao da Page2, com os 3
49: * Click handlers (BtnGerarCnabClick/BtnRelatorioCnabClick/BtnBoletoClick)
50: * e ExecutarReportForm (Pattern #117). A geracao do arquivo CNAB (dispatch
51: * por banco do convenio - Brasil/Itau/Bradesco/Santander240 - layouts
52: * Brasil6/Itau240/Santander eram DEAD CODE no legado, nunca chamados por
53: * nenhum botao nem pelo dispatcher, e por isso nao foram portados) e o
54: * calculo do boleto (nosso numero/codigo de barras/linha digitavel, Mod10/
55: * Mod11 padrao FEBRABAN - fCalcMod10/fCalcMod11BB/fCalcMod11B7/fGerBar2de5
56: * em utils/functions.prg, fontes legados ausentes do acervo, regra
57: * CLAUDE.md #27) ficam no SIGPRCNBBO (GerarArquivoCnab/GerarCnabBrasil/
58: * GerarCnabItau/GerarCnabBradesco/GerarCnabSantander240/ImprimirBoleto).
59: * Os relatorios de preview (SigReCnb/SigReBlqBB/SigReBlqSt/SigReBlqBra)
60: * NAO tem FRX no acervo (sigrecnb/BloquetoBB2/BloquetoSt/BloquetoBra do
61: * legado nunca foram extraidos) - ExecutarReportForm mostra o aviso
62: * padrao "arquivo de relatorio nao encontrado" em vez de preview vazio;
63: * toda a preparacao de dados (cursor_4c_Titulos/cursor_4c_Boletos, calculo
64: * de barra/DV) fica pronta para quando o FRX for portado.
65: *==============================================================================
66: 
67: DEFINE CLASS FormSIGPRCNB AS FormBase
68: 
69:     *-- Dimensoes e propriedades visuais (padrao canonico de form OPERACIONAL)
70:     Height      = 600
71:     Width       = 1000
72:     BorderStyle = 2
73:     AutoCenter  = .T.
74:     ShowTips    = .T.
75:     Caption     = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Recebimentos"
76:     ControlBox  = .F.

*-- Linhas 87 a 205:
87:     this_oBusinessObject = .NULL.
88: 
89:     *==========================================================================
90:     PROCEDURE Init()
91:     *==========================================================================
92:         RETURN DODEFAULT()
93:     ENDPROC
94: 
95:     *==========================================================================
96:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
97:     *==========================================================================
98:     PROTECTED PROCEDURE InicializarForm()
99:         LOCAL loc_lSucesso, loc_oErro
100:         loc_lSucesso = .F.
101: 
102:         TRY
103:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCNBBO")
104: 
105:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
106:                 loc_lSucesso = .T.
107:             ELSE
108:                 IF gnConnHandle <= 0
109:                     MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
110:                             "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
111:                 ELSE
112:                     THIS.ConfigurarPageFrame()
113:                     THIS.ConfigurarPaginaLista()
114:                     THIS.ConfigurarPaginaDados()
115:                     THIS.ConfigurarBindEventsFiltro()
116:                     THIS.ConfigurarBindEventsPrincipais()
117:                     THIS.CarregarOperacoes()
118:                     THIS.TornarControlesVisiveis()
119:                     loc_lSucesso = .T.
120:                 ENDIF
121:             ENDIF
122:         CATCH TO loc_oErro
123:             MsgErro(loc_oErro.Message + CHR(13) + ;
124:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
125:                     "Procedure: " + loc_oErro.Procedure, "Erro InicializarForm")
126:         ENDTRY
127: 
128:         RETURN loc_lSucesso
129:     ENDPROC
130: 
131:     *==========================================================================
132:     * ConfigurarPageFrame - Constroi o PageFrame com 2 paginas (Filtro/Dados)
133:     *==========================================================================
134:     PROTECTED PROCEDURE ConfigurarPageFrame()
135:         LOCAL loc_oPgf
136: 
137:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
138:         loc_oPgf = THIS.pgf_4c_Paginas
139: 
140:         loc_oPgf.PageCount = 2
141:         loc_oPgf.Top       = -29
142:         loc_oPgf.Left      = 0
143:         loc_oPgf.Width     = THIS.Width
144:         loc_oPgf.Height    = THIS.Height + 29
145:         loc_oPgf.TabIndex  = 1
146:         loc_oPgf.Tabs      = .F.
147: 
148:         loc_oPgf.Page1.Caption = "Filtro"
149:         loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
150: 
151:         loc_oPgf.Page2.Caption = "Dados"
152:         loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
153: 
154:         loc_oPgf.Visible    = .T.
155:         loc_oPgf.ActivePage = 1
156:     ENDPROC
157: 
158:     *==========================================================================
159:     * ConfigurarPaginaLista - Estrutura da Page1 (Filtro)
160:     * Fase 4/8: faixa do cabecalho + botoes reais (Processar/Encerrar/Marcar
161:     * Tudo/Desmarcar Tudo) + grade de selecao de operacoes (grdope no
162:     * legado). Campos de filtro (empresa, periodo, banco/conta, titulo
163:     * banco) vem nas Fases 5-6.
164:     *==========================================================================
165:     PROTECTED PROCEDURE ConfigurarPaginaLista()
166:         LOCAL loc_oPag, loc_oCab, loc_oGrid
167: 
168:         loc_oPag = THIS.pgf_4c_Paginas.Page1
169: 
170:         *-- Faixa do cabecalho - PRIMEIRO AddObject da pagina (regra #11/#39):
171:         *-- containers de botao ficam em Top=29..33 (dentro da faixa) e tem
172:         *-- de ser criados DEPOIS para desenhar por cima.
173:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
174:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
175:         WITH loc_oCab
176:             .Top           = 29
177:             .Left          = 0
178:             .Width         = THIS.Width
179:             .Height        = 80
180:             .BorderWidth   = 0
181:             .SpecialEffect = 0
182:             .BackColor     = RGB(100,100,100)
183: 
184:             .AddObject("lbl_4c_Sombra", "Label")
185:             WITH .lbl_4c_Sombra
186:                 .Top       = 15
187:                 .Left      = 10
188:                 .Width     = THIS.Width
189:                 .Height    = 40
190:                 .FontName  = "Tahoma"
191:                 .FontSize  = 16
192:                 .FontBold  = .T.
193:                 .WordWrap  = .T.
194:                 .Alignment = 0
195:                 .BackStyle = 0
196:                 .ForeColor = RGB(0,0,0)
197:                 .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Recebimentos"
198:             ENDWITH
199: 
200:             .AddObject("lbl_4c_Titulo", "Label")
201:             WITH .lbl_4c_Titulo
202:                 .Top       = 18
203:                 .Left      = 10
204:                 .Width     = THIS.Width
205:                 .Height    = 46

*-- Linhas 333 a 376:
333:             .Caption   = "Opera" + CHR(231) + CHR(245) + "es :"
334:         ENDWITH
335: 
336:         loc_oPag.AddObject("obj_4c_Processados", "OptionGroup")
337:         WITH loc_oPag.obj_4c_Processados
338:             .Top         = 124
339:             .Left        = 344
340:             .Width       = 235
341:             .Height      = 19
342:             .BackStyle   = 0
343:             .BorderStyle = 0
344:             .ButtonCount = 2
345:             .Value       = 1
346: 
347:             WITH .Buttons(1)
348:                 .FontName  = "Tahoma"
349:                 .FontSize  = 8
350:                 .BackStyle = 0
351:                 .Caption   = "N" + CHR(227) + "o Processadas"
352:                 .ForeColor = RGB(90,90,90)
353:                 .Left      = 5
354:                 .Top       = 2
355:                 .AutoSize  = .T.
356:                 .Themes    = .F.
357:             ENDWITH
358: 
359:             WITH .Buttons(2)
360:                 .FontName  = "Tahoma"
361:                 .FontSize  = 8
362:                 .BackStyle = 0
363:                 .Caption   = "J" + CHR(225) + " Processadas"
364:                 .ForeColor = RGB(90,90,90)
365:                 .Left      = 126
366:                 .Top       = 2
367:                 .AutoSize  = .T.
368:                 .Themes    = .F.
369:             ENDWITH
370:         ENDWITH
371: 
372:         *-- Empresa (Say4 + get_cd_empresa + get_ds_empresa no legado)
373:         loc_oPag.AddObject("lbl_4c_Empresa", "Label")
374:         WITH loc_oPag.lbl_4c_Empresa
375:             .Top       = 152
376:             .Left      = 297

*-- Linhas 470 a 513:
470:             .Value         = {}
471:         ENDWITH
472: 
473:         loc_oPag.AddObject("obj_4c_Periodo", "OptionGroup")
474:         WITH loc_oPag.obj_4c_Periodo
475:             .Top         = 175
476:             .Left        = 544
477:             .Width       = 168
478:             .Height      = 25
479:             .BackStyle   = 0
480:             .BorderStyle = 0
481:             .ButtonCount = 2
482:             .Value       = 1
483: 
484:             WITH .Buttons(1)
485:                 .FontName  = "Tahoma"
486:                 .FontSize  = 8
487:                 .BackStyle = 0
488:                 .Caption   = "Vencimento"
489:                 .ForeColor = RGB(90,90,90)
490:                 .Left      = 5
491:                 .Top       = 5
492:                 .Width     = 73
493:                 .Height    = 15
494:                 .AutoSize  = .T.
495:                 .Themes    = .F.
496:             ENDWITH
497: 
498:             WITH .Buttons(2)
499:                 .FontName  = "Tahoma"
500:                 .FontSize  = 8
501:                 .BackStyle = 0
502:                 .Caption   = "Emiss" + CHR(227) + "o"
503:                 .ForeColor = RGB(90,90,90)
504:                 .Left      = 96
505:                 .Top       = 5
506:                 .AutoSize  = .T.
507:                 .Themes    = .F.
508:             ENDWITH
509:         ENDWITH
510: 
511:         *-- Banco/Conta (Say2 + get_cd_car_conta + get_ds_car_conta)
512:         loc_oPag.AddObject("lbl_4c_Banco", "Label")
513:         WITH loc_oPag.lbl_4c_Banco

*-- Linhas 678 a 721:
678:     * (Say2/Botao1), a grade de titulos (grdope, 8 colunas) e os botoes de
679:     * acao (cmdTestaPos/Commandgroup1/Commandgroup2) ficam para a Fase 6.
680:     *==========================================================================
681:     PROTECTED PROCEDURE ConfigurarPaginaDados()
682:         LOCAL loc_oPag, loc_oCab, loc_oGridTit
683: 
684:         loc_oPag = THIS.pgf_4c_Paginas.Page2
685: 
686:         *-- Faixa do cabecalho - PRIMEIRO AddObject da pagina (regra #11/#39):
687:         *-- containers de botao (cnt_4c_BotoesAcao, Top=27..112) ficam DENTRO
688:         *-- da area da faixa (Top=29..109) e tem de ser criados DEPOIS para
689:         *-- desenhar por cima (excecao da regra: barra de acao do topo com
690:         *-- Top 20..55 e Height 60..100 fica POR CIMA, sem ser deslocada).
691:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
692:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
693:         WITH loc_oCab
694:             .Top           = 29
695:             .Left          = 0
696:             .Width         = THIS.Width
697:             .Height        = 80
698:             .BorderWidth   = 0
699:             .SpecialEffect = 0
700:             .BackColor     = RGB(100,100,100)
701: 
702:             .AddObject("lbl_4c_Sombra", "Label")
703:             WITH .lbl_4c_Sombra
704:                 .Top       = 15
705:                 .Left      = 10
706:                 .Width     = THIS.Width
707:                 .Height    = 40
708:                 .FontName  = "Tahoma"
709:                 .FontSize  = 16
710:                 .FontBold  = .T.
711:                 .WordWrap  = .T.
712:                 .Alignment = 0
713:                 .BackStyle = 0
714:                 .ForeColor = RGB(0,0,0)
715:                 .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Recebimentos"
716:             ENDWITH
717: 
718:             .AddObject("lbl_4c_Titulo", "Label")
719:             WITH .lbl_4c_Titulo
720:                 .Top       = 18
721:                 .Left      = 10

*-- Linhas 1064 a 1107:
1064:     * Header1.Caption): uma vez na estrutura inicial (ConfigurarPaginaDados)
1065:     * e de novo apos o SQLEXEC real (THIS.ProcessarTitulos).
1066:     *==========================================================================
1067:     PROTECTED PROCEDURE FormatarGridTitulos(par_oGrid)
1068:         WITH par_oGrid
1069:             .Column1.Width           = 16
1070:             .Column1.Movable         = .F.
1071:             .Column1.Resizable       = .F.
1072:             .Column1.Sparse          = .F.
1073:             .Column1.ReadOnly        = .F.
1074:             .Column1.ColumnOrder     = 1
1075:             .Column1.Header1.Caption = ""
1076: 
1077:             .Column2.Width             = 150
1078:             .Column2.Movable           = .F.
1079:             .Column2.Resizable         = .F.
1080:             .Column2.ReadOnly          = .T.
1081:             .Column2.ColumnOrder       = 3
1082:             .Column2.Header1.Alignment = 2
1083:             .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
1084: 
1085:             .Column3.Width             = 52
1086:             .Column3.Movable           = .F.
1087:             .Column3.Resizable         = .F.
1088:             .Column3.ReadOnly          = .T.
1089:             .Column3.ColumnOrder       = 4
1090:             .Column3.Header1.Alignment = 2
1091:             .Column3.Header1.Caption   = "C" + CHR(243) + "digo"
1092: 
1093:             .Column4.Width             = 400
1094:             .Column4.Movable           = .F.
1095:             .Column4.Resizable         = .F.
1096:             .Column4.ReadOnly          = .T.
1097:             .Column4.ColumnOrder       = 5
1098:             .Column4.Header1.Alignment = 2
1099:             .Column4.Header1.Caption   = "Cliente"
1100: 
1101:             .Column5.Width             = 72
1102:             .Column5.Movable           = .F.
1103:             .Column5.Resizable         = .F.
1104:             .Column5.ReadOnly          = .T.
1105:             .Column5.ColumnOrder       = 6
1106:             .Column5.Header1.Alignment = 2
1107:             .Column5.Header1.Caption   = "Vencimento"

*-- Linhas 1141 a 1184:
1141:     * Cursor eh READWRITE porque a Coluna1 do grid eh um CheckBox editavel
1142:     * (marca/desmarca operacao) - SQLEXEC devolve cursor somente-leitura.
1143:     *==========================================================================
1144:     PROTECTED PROCEDURE CarregarOperacoes()
1145:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
1146:         loc_lSucesso = .F.
1147: 
1148:         TRY
1149:             loc_cSQL = "SELECT Dopes, CAST(0 AS BIT) AS Marca" + CHR(13) + ;
1150:                        "FROM SigCdOpe" + CHR(13) + ;
1151:                        "WHERE Parcontas = 1 AND ValPends = 1" + CHR(13) + ;
1152:                        "ORDER BY Dopes"
1153: 
1154:             IF USED("cursor_4c_OperacoesTmp")
1155:                 USE IN cursor_4c_OperacoesTmp
1156:             ENDIF
1157: 
1158:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacoesTmp")
1159: 
1160:             IF loc_nResultado >= 0
1161:                 IF USED("cursor_4c_Operacoes")
1162:                     USE IN cursor_4c_Operacoes
1163:                 ENDIF
1164: 
1165:                 SELECT * FROM cursor_4c_OperacoesTmp INTO CURSOR cursor_4c_Operacoes READWRITE
1166: 
1167:                 IF USED("cursor_4c_OperacoesTmp")
1168:                     USE IN cursor_4c_OperacoesTmp
1169:                 ENDIF
1170: 
1171:                 IF RECCOUNT("cursor_4c_Operacoes") > 0
1172:                     SELECT cursor_4c_Operacoes
1173:                     GO TOP
1174:                 ENDIF
1175: 
1176:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.ColumnCount = 3
1177:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.RecordSource = "cursor_4c_Operacoes"
1178: 
1179:                 *-- RecordSource reatribuido faz o Grid auto-bindar as colunas
1180:                 *-- pela ordem dos campos do cursor, ignorando o ControlSource
1181:                 *-- anterior - redefinir explicitamente (regra GRID-RECORDSOURCE-AUTOBIND).
1182:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Column1.ControlSource = "cursor_4c_Operacoes.Marca"
1183:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Column2.ControlSource = "cursor_4c_Operacoes.Dopes"
1184: 

*-- Linhas 1192 a 1374:
1192:         CATCH TO loc_oErro
1193:             MostrarErro(loc_oErro.Message + CHR(13) + ;
1194:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1195:                         "Procedure: " + loc_oErro.Procedure, "Erro CarregarOperacoes")
1196:         ENDTRY
1197: 
1198:         RETURN loc_lSucesso
1199:     ENDPROC
1200: 
1201:     *==========================================================================
1202:     * ConfigurarBindEventsFiltro - Registra os BINDEVENTs dos campos de filtro
1203:     * da Page1 (Empresa/Periodo/Banco-Conta/Titulo Banco). Handlers PUBLIC
1204:     * (regra #3 - BINDEVENT falha silenciosamente em metodo PROTECTED).
1205:     *==========================================================================
1206:     PROTECTED PROCEDURE ConfigurarBindEventsFiltro()
1207:         LOCAL loc_oPag
1208:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1209: 
1210:         *-- Empresa
1211:         BINDEVENT(loc_oPag.txt_4c_CodEmpresa,  "KeyPress", THIS, "ValidarCodEmpresa")
1212:         BINDEVENT(loc_oPag.txt_4c_NomeEmpresa, "KeyPress", THIS, "ValidarNomEmpresa")
1213: 
1214:         *-- Periodo (validacao de intervalo de datas)
1215:         BINDEVENT(loc_oPag.txt_4c_DataFinal,   "KeyPress", THIS, "ValidarDataFinal")
1216: 
1217:         *-- Banco/Conta
1218:         BINDEVENT(loc_oPag.txt_4c_CodConta,    "KeyPress", THIS, "ValidarCodConta")
1219:         BINDEVENT(loc_oPag.txt_4c_NomeConta,   "KeyPress", THIS, "ValidarNomConta")
1220: 
1221:         *-- Titulo Banco (SigOpFp.Fpags)
1222:         BINDEVENT(loc_oPag.txt_4c_TituloBanco, "KeyPress", THIS, "ValidarTituloBanco")
1223:     ENDPROC
1224: 
1225:     *==========================================================================
1226:     * ConfigurarBindEventsPrincipais - Registra os BINDEVENTs dos botoes
1227:     * principais (Processar/Encerrar/Marcar/Desmarcar da Pagina Filtro e
1228:     * Voltar/Marcar/Desmarcar da Pagina Dados). Handlers PUBLIC (regra #3).
1229:     *==========================================================================
1230:     PROTECTED PROCEDURE ConfigurarBindEventsPrincipais()
1231:         LOCAL loc_oPag1, loc_oPag2
1232: 
1233:         loc_oPag1 = THIS.pgf_4c_Paginas.Page1
1234:         BINDEVENT(loc_oPag1.cnt_4c_Botoes.cmd_4c_Processar,    "Click", THIS, "BtnProcessarClick")
1235:         BINDEVENT(loc_oPag1.cnt_4c_Botoes.cmd_4c_Encerrar,     "Click", THIS, "BtnEncerrarClick")
1236:         BINDEVENT(loc_oPag1.cnt_4c_Marca.cmd_4c_MarcarTudo,    "Click", THIS, "BtnMarcarTudoClick")
1237:         BINDEVENT(loc_oPag1.cnt_4c_Marca.cmd_4c_DesmarcarTudo, "Click", THIS, "BtnDesmarcarTudoClick")
1238: 
1239:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1240:         BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Encerrar,   "Click", THIS, "BtnVoltarClick")
1241:         BINDEVENT(loc_oPag2.cnt_4c_Marca.cmd_4c_MarcarTudo,      "Click", THIS, "BtnMarcarTudoTitulosClick")
1242:         BINDEVENT(loc_oPag2.cnt_4c_Marca.cmd_4c_DesmarcarTudo,   "Click", THIS, "BtnDesmarcarTudoTitulosClick")
1243:         BINDEVENT(loc_oPag2.grd_4c_Titulos.Column1.chk_4c_Marca, "Click", THIS, "ChkTituloMarcaClick")
1244: 
1245:         *-- obj_4c_Comandos (Commandgroup1 no legado: btncnab/btnrelatorio/btnBoleto)
1246:         BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(1), "Click", THIS, "BtnGerarCnabClick")
1247:         BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(2), "Click", THIS, "BtnRelatorioCnabClick")
1248:         BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(3), "Click", THIS, "BtnBoletoClick")
1249:     ENDPROC
1250: 
1251:     *==========================================================================
1252:     * BtnProcessarClick - cmdTestaPos.btnProcessar.Click no legado. Valida
1253:     * Empresa/Periodo/Conta obrigatorios e exige ao menos 1 operacao marcada
1254:     * antes de consultar os titulos em aberto.
1255:     *==========================================================================
1256:     PROCEDURE BtnProcessarClick()
1257:         LOCAL loc_oPag, loc_nCont
1258: 
1259:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1260: 
1261:         IF EMPTY(ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value))
1262:             MsgAviso("Empresa inv" + CHR(225) + "lida", "Aviso")
1263:             loc_oPag.txt_4c_CodEmpresa.SetFocus()
1264:             RETURN
1265:         ENDIF
1266: 
1267:         IF EMPTY(loc_oPag.txt_4c_DataInicial.Value) OR EMPTY(loc_oPag.txt_4c_DataFinal.Value)
1268:             MsgAviso("Per" + CHR(237) + "odo inv" + CHR(225) + "lido", "Aviso")
1269:             loc_oPag.txt_4c_DataInicial.SetFocus()
1270:             RETURN
1271:         ENDIF
1272: 
1273:         IF EMPTY(ALLTRIM(loc_oPag.txt_4c_CodConta.Value))
1274:             MsgAviso("Banco inv" + CHR(225) + "lido", "Aviso")
1275:             loc_oPag.txt_4c_CodConta.SetFocus()
1276:             RETURN
1277:         ENDIF
1278: 
1279:         loc_nCont = 0
1280:         IF USED("cursor_4c_Operacoes")
1281:             SELECT cursor_4c_Operacoes
1282:             COUNT FOR Marca TO loc_nCont
1283:         ENDIF
1284:         IF loc_nCont = 0
1285:             MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o foi selecionada", "Aviso")
1286:             RETURN
1287:         ENDIF
1288: 
1289:         THIS.ProcessarTitulos()
1290:     ENDPROC
1291: 
1292:     *==========================================================================
1293:     * BtnEncerrarClick - cmdTestaPos.btnsair.Click (Pagina Filtro) no legado.
1294:     *==========================================================================
1295:     PROCEDURE BtnEncerrarClick()
1296:         THIS.Release()
1297:     ENDPROC
1298: 
1299:     *==========================================================================
1300:     * BtnMarcarTudoClick/BtnDesmarcarTudoClick - Commandgroup2.btnmarca/
1301:     * btndesmarca.Click (Pagina Filtro) no legado - marca/desmarca TODAS as
1302:     * operacoes do grid de filtro, sem excecao (igual ao legado).
1303:     *==========================================================================
1304:     PROCEDURE BtnMarcarTudoClick()
1305:         IF USED("cursor_4c_Operacoes")
1306:             SELECT cursor_4c_Operacoes
1307:             REPLACE ALL Marca WITH .T.
1308:             LOCATE
1309:             GO TOP
1310:         ENDIF
1311:         THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
1312:     ENDPROC
1313: 
1314:     PROCEDURE BtnDesmarcarTudoClick()
1315:         IF USED("cursor_4c_Operacoes")
1316:             SELECT cursor_4c_Operacoes
1317:             REPLACE ALL Marca WITH .F.
1318:             LOCATE
1319:             GO TOP
1320:         ENDIF
1321:         THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
1322:     ENDPROC
1323: 
1324:     *==========================================================================
1325:     * ProcessarTitulos - PROCEDURE processamento no legado. Monta a lista de
1326:     * operacoes marcadas + consulta os titulos em aberto (SigMvPar/SigOpFp/
1327:     * SigMvCab/SigCdCli/SigMvCcr), populando cursor_4c_Titulos (READWRITE -
1328:     * a coluna Marca eh CheckBox editavel no grid). Formula/filtros
1329:     * TRANSCRITOS literalmente do legado (regra CLAUDE.md #17) - inclusive a
1330:     * ausencia de filtro pela conta/carteira na consulta (o legado le
1331:     * get_cd_car_conta so para validar preenchimento, e aplica a conta
1332:     * apenas na geracao do CNAB, fase 8).
1333:     *==========================================================================
1334:     PROTECTED PROCEDURE ProcessarTitulos()
1335:         LOCAL loc_oPag, loc_cListaOperacoes, loc_cEmpresa, loc_dIni, loc_dFim, loc_nPeriodo, ;
1336:               loc_lNaoProcessados, loc_cCampoData, loc_cNotIn, loc_cSQL, loc_nResultado, ;
1337:               loc_lSucesso, loc_oGrid, loc_oErro
1338:         loc_lSucesso = .F.
1339: 
1340:         loc_oPag             = THIS.pgf_4c_Paginas.Page1
1341:         loc_cEmpresa         = ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value)
1342:         loc_dIni             = loc_oPag.txt_4c_DataInicial.Value
1343:         loc_dFim             = loc_oPag.txt_4c_DataFinal.Value
1344:         loc_nPeriodo         = loc_oPag.obj_4c_Periodo.Value          && 1=Vencimento, 2=Emissao
1345:         loc_lNaoProcessados  = (loc_oPag.obj_4c_Processados.Value = 1) && 1=Nao Processadas, 2=Ja Processadas
1346: 
1347:         *-- Lista das operacoes marcadas - IN-list de coluna CHAR unica
1348:         *-- (compara com blank-padding ANSI no SQL Server); NAO eh a chave
1349:         *-- POSICIONAL concatenada da regra #42, ALLTRIM por item eh seguro.
1350:         loc_cListaOperacoes = "("
1351:         IF USED("cursor_4c_Operacoes")
1352:             SELECT cursor_4c_Operacoes
1353:             SCAN FOR Marca
1354:                 loc_cListaOperacoes = loc_cListaOperacoes + ;
1355:                     IIF(loc_cListaOperacoes == "(", "", ",") + EscaparSQL(ALLTRIM(Dopes))
1356:             ENDSCAN
1357:         ENDIF
1358:         loc_cListaOperacoes = loc_cListaOperacoes + ")"
1359: 
1360:         loc_cCampoData = IIF(loc_nPeriodo = 1, "a.vencs", "e.dtemis")
1361:         loc_cNotIn     = IIF(loc_lNaoProcessados, "NOT ", "")
1362: 
1363:         TRY
1364:             loc_cSQL = ;
1365:                 "SELECT CAST(1 AS BIT) AS Marca, e.titulos AS Titulos, a.dopes AS Dopes, a.numes AS Numes," + CHR(13) + ;
1366:                 "       d.rclis AS RClis, a.vencs AS Vencs, b.fpags AS Fpags, a.valos AS Valos, a.datas AS Datas," + CHR(13) + ;
1367:                 "       a.vpags AS Vpags, d.iclis AS IClis, d.endes AS Endes, d.cidas AS Cidas, d.estas AS Estas," + CHR(13) + ;
1368:                 "       d.nums AS Nums, d.compls AS Compls, d.bairs AS Bairs, d.ceps AS Ceps, d.cpfs AS Cpfs," + CHR(13) + ;
1369:                 "       a.emps AS Emps, a.empdopnums AS EmpDopNums, a.nopers AS Nopers, d.razaos AS Razaos," + CHR(13) + ;
1370:                 "       d.endcobs AS EndCobs, d.cepcobs AS CepCobs, d.estcobs AS EstCobs, d.baicobs AS BaiCobs, d.cidcobs AS CidCobs," + CHR(13) + ;
1371:                 "       CASE WHEN d.endcobs <> '' AND LEN(RTRIM(d.endcobs)) > 40 THEN 1" + CHR(13) + ;
1372:                 "            WHEN d.endes <> '' AND LEN(RTRIM(d.endes) + ' ' + RTRIM(d.nums) + ' ' + RTRIM(d.compls)) > 40 THEN 1" + CHR(13) + ;
1373:                 "            ELSE 0 END AS EndErro" + CHR(13) + ;
1374:                 "FROM SigMvPar a" + CHR(13) + ;

*-- Linhas 1405 a 1760:
1405:                 ENDIF
1406: 
1407:                 IF RECCOUNT("cursor_4c_Titulos") = 0
1408:                     MsgAviso("Nenhum dado foi encontrado", "Aviso")
1409:                 ELSE
1410:                     SELECT cursor_4c_Titulos
1411:                     REPLACE ALL Marca WITH .F. FOR EndErro = 1
1412:                     GO TOP
1413: 
1414:                     loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos
1415:                     loc_oGrid.ColumnCount = 8
1416:                     loc_oGrid.RecordSource         = "cursor_4c_Titulos"
1417:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Titulos.Marca"
1418:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Titulos.Dopes"
1419:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Titulos.Numes"
1420:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Titulos.RClis"
1421:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Titulos.Vencs"
1422:                     loc_oGrid.Column6.ControlSource = "cursor_4c_Titulos.Fpags"
1423:                     loc_oGrid.Column7.ControlSource = "cursor_4c_Titulos.Valos"
1424:                     loc_oGrid.Column8.ControlSource = "cursor_4c_Titulos.Titulos"
1425:                     THIS.FormatarGridTitulos(loc_oGrid)
1426:                     loc_oGrid.Refresh()
1427: 
1428:                     THIS.pgf_4c_Paginas.Page1.Enabled = .F.
1429:                     THIS.pgf_4c_Paginas.Page2.Enabled = .T.
1430: 
1431:                     *-- cmdTestaPos.btnBoleto.Enabled = !llNPr no legado (linha
1432:                     *-- 1468): Boleto so comeca habilitado quando o filtro eh
1433:                     *-- "Ja Processadas" (reimpressao); ProcessadoBrasil/
1434:                     *-- Santander240 forcam .T. depois de gerar com sucesso.
1435:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(3).Enabled = ;
1436:                         (loc_oPag.obj_4c_Processados.Value = 2)
1437: 
1438:                     THIS.AlternarPagina(2)
1439:                     loc_lSucesso = .T.
1440:                 ENDIF
1441:             ELSE
1442:                 MostrarErro("Erro ao processar os t" + CHR(237) + "tulos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1443:             ENDIF
1444:         CATCH TO loc_oErro
1445:             MostrarErro(loc_oErro.Message + CHR(13) + ;
1446:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1447:                         "Procedure: " + loc_oErro.Procedure, "Erro ProcessarTitulos")
1448:         ENDTRY
1449: 
1450:         RETURN loc_lSucesso
1451:     ENDPROC
1452: 
1453:     *==========================================================================
1454:     * BtnVoltarClick - cmdTestaPos.btnsair.Click (Pagina Dados) no legado:
1455:     * limpa o RecordSource do grid, reabilita o filtro e volta para a Lista.
1456:     *==========================================================================
1457:     PROCEDURE BtnVoltarClick()
1458:         LOCAL loc_oGrid
1459:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos
1460:         loc_oGrid.RecordSource = ""
1461:         loc_oGrid.Refresh()
1462: 
1463:         THIS.pgf_4c_Paginas.Page1.Enabled = .T.
1464:         THIS.pgf_4c_Paginas.Page2.Enabled = .F.
1465:         THIS.AlternarPagina(1)
1466:     ENDPROC
1467: 
1468:     *==========================================================================
1469:     * BtnMarcarTudoTitulosClick/BtnDesmarcarTudoTitulosClick - Commandgroup2.
1470:     * btnmarca/btndesmarca.Click (Pagina Dados) no legado - marca/desmarca
1471:     * TODOS os titulos, sem excecao pelo EndErro (igual ao legado - o
1472:     * "Marcar Tudo" bypassa o guard do checkbox individual).
1473:     *==========================================================================
1474:     PROCEDURE BtnMarcarTudoTitulosClick()
1475:         IF USED("cursor_4c_Titulos")
1476:             SELECT cursor_4c_Titulos
1477:             REPLACE ALL Marca WITH .T.
1478:             LOCATE
1479:             GO TOP
1480:         ENDIF
1481:         THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
1482:     ENDPROC
1483: 
1484:     PROCEDURE BtnDesmarcarTudoTitulosClick()
1485:         IF USED("cursor_4c_Titulos")
1486:             SELECT cursor_4c_Titulos
1487:             REPLACE ALL Marca WITH .F.
1488:             LOCATE
1489:             GO TOP
1490:         ENDIF
1491:         THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
1492:     ENDPROC
1493: 
1494:     *==========================================================================
1495:     * ChkTituloMarcaClick - Column1.Check1.When no legado (Return
1496:     * crFiltro.EndErro = 0): titulo com endereco muito longo nao pode ser
1497:     * selecionado. O nativo do CheckBox ja alterna Marca no clique; aqui so
1498:     * revertemos quando a linha estiver marcada como EndErro=1.
1499:     *==========================================================================
1500:     PROCEDURE ChkTituloMarcaClick()
1501:         IF USED("cursor_4c_Titulos") AND !EOF("cursor_4c_Titulos")
1502:             IF cursor_4c_Titulos.EndErro = 1 AND cursor_4c_Titulos.Marca
1503:                 REPLACE cursor_4c_Titulos.Marca WITH .F.
1504:                 MsgAviso("Este t" + CHR(237) + "tulo tem endere" + CHR(231) + "o com mais de 40 caracteres e n" + CHR(227) + "o pode ser selecionado.", ;
1505:                          "Aten" + CHR(231) + CHR(227) + "o")
1506:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
1507:             ENDIF
1508:         ENDIF
1509:     ENDPROC
1510: 
1511:     *==========================================================================
1512:     * ExecutarReportForm (Pattern #117) - executa REPORT FORM com guard
1513:     * IF FILE() + isolamento de locale (SET POINT/SEPARATOR) + REPORTBEHAVIOR
1514:     * 80 durante o REPORT FORM. par_cModo: "PREVIEW" | "PRINTER_PROMPT".
1515:     * par_cCursorDados: opcional - se informado e cursor estiver vazio/
1516:     * inexistente, mostra MsgAviso e retorna .F. sem abrir preview vazio.
1517:     *==========================================================================
1518:     PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
1519:         LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
1520: 
1521:         loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")
1522: 
1523:         IF NOT FILE(loc_cFRX)
1524:             MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
1525:                 loc_cFRX + CHR(13) + CHR(13) + ;
1526:                 "O layout deste relat" + CHR(243) + "rio n" + CHR(227) + "o veio no acervo do sistema legado.", "Erro")
1527:             RETURN .F.
1528:         ENDIF
1529: 
1530:         IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
1531:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
1532:                 MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
1533:                     "Aten" + CHR(231) + CHR(227) + "o")
1534:                 RETURN .F.
1535:             ENDIF
1536:         ENDIF
1537: 
1538:         loc_cPointOrig    = SET("POINT")
1539:         loc_cSepOrig      = SET("SEPARATOR")
1540:         loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
1541:         SET POINT TO "."
1542:         SET SEPARATOR TO ","
1543:         SET REPORTBEHAVIOR 80
1544: 
1545:         DO CASE
1546:             CASE par_cModo == "PREVIEW"
1547:                 REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
1548:             CASE par_cModo == "PRINTER_PROMPT"
1549:                 REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
1550:         ENDCASE
1551: 
1552:         SET POINT TO (loc_cPointOrig)
1553:         SET SEPARATOR TO (loc_cSepOrig)
1554:         SET REPORTBEHAVIOR (loc_nBehaviorOrig)
1555: 
1556:         RETURN .T.
1557:     ENDPROC
1558: 
1559:     *==========================================================================
1560:     * BtnGerarCnabClick - Commandgroup1.btncnab.Click no legado ("thisform.
1561:     * geracnab([A])"). Gera o arquivo de remessa bancaria com os titulos
1562:     * marcados. Quando o banco eh Brasil (001), o BO ja dispara a impressao
1563:     * automatica do boleto (regra fiel ao legado - o BO chama sua propria
1564:     * rotina ImprimirBoleto dentro de GerarCnabBrasil); aqui so falta exibir
1565:     * o preview se o BO deixou um cursor pronto.
1566:     *==========================================================================
1567:     PROCEDURE BtnGerarCnabClick()
1568:         LOCAL loc_oPag, loc_lSucesso
1569: 
1570:         loc_oPag = THIS.pgf_4c_Paginas.Page2
1571: 
1572:         loc_lSucesso = THIS.this_oBusinessObject.GerarArquivoCnab( ;
1573:             "cursor_4c_Titulos", ;
1574:             ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CodEmpresa.Value), ;
1575:             ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CodConta.Value), ;
1576:             ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_TituloBanco.Value))
1577: 
1578:         IF loc_lSucesso AND INLIST(THIS.this_oBusinessObject.this_cBancoConvenio, "001", "033", "353")
1579:             loc_oPag.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(3).Enabled = .T.
1580:         ENDIF
1581: 
1582:         *-- GerarCnabBrasil (no BO) ja chamou sua propria rotina interna
1583:         *-- ImprimirBoleto(.F.) - se deixou cursor pronto, exibe o preview
1584:         *-- aqui (camada de UI).
1585:         IF !EMPTY(THIS.this_oBusinessObject.this_cCursorBoleto)
1586:             THIS.ExibirPreviewBoleto()
1587:         ENDIF
1588:     ENDPROC
1589: 
1590:     *==========================================================================
1591:     * BtnRelatorioCnabClick - Commandgroup1.btnrelatorio.Click no legado
1592:     * ("thisform.geracnab([V])"): preview do relatorio com os titulos
1593:     * marcados (Report Form sigrecnb no legado -> SigReCnb no novo sistema).
1594:     *==========================================================================
1595:     PROCEDURE BtnRelatorioCnabClick()
1596:         LOCAL loc_nMarcados
1597: 
1598:         IF USED("cursor_4c_Titulos")
1599:             SELECT cursor_4c_Titulos
1600:             COUNT FOR Marca TO loc_nMarcados
1601:         ELSE
1602:             loc_nMarcados = 0
1603:         ENDIF
1604: 
1605:         IF loc_nMarcados = 0
1606:             MsgAviso("Nenhum registro foi selecionado", "Aviso")
1607:             RETURN
1608:         ENDIF
1609: 
1610:         THIS.ExecutarReportForm("SigReCnb", "PREVIEW", "cursor_4c_Titulos")
1611:     ENDPROC
1612: 
1613:     *==========================================================================
1614:     * BtnBoletoClick - Commandgroup1.btnBoleto.Click no legado ("thisform.
1615:     * geracnab([I])" + "thisform.impboleto(.T.)"): reimpressao do boleto dos
1616:     * titulos marcados, reaproveitando o Nosso Numero da ultima geracao
1617:     * gravada em SigPcOol (par_lReimpressao = .T.).
1618:     *==========================================================================
1619:     PROCEDURE BtnBoletoClick()
1620:         LOCAL loc_lSucesso
1621: 
1622:         loc_lSucesso = THIS.this_oBusinessObject.ImprimirBoleto( ;
1623:             "cursor_4c_Titulos", .T., ;
1624:             ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CodEmpresa.Value), ;
1625:             ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CodConta.Value))
1626: 
1627:         IF loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cCursorBoleto)
1628:             THIS.ExibirPreviewBoleto()
1629:         ENDIF
1630:     ENDPROC
1631: 
1632:     *==========================================================================
1633:     * ExibirPreviewBoleto - escolhe o layout de boleto pelo banco do
1634:     * convenio (BloquetoBB2/BloquetoSt/BloquetoBra no legado -> SigReBlqBB/
1635:     * SigReBlqSt/SigReBlqBra no novo sistema) e limpa as imagens de barra
1636:     * temporarias apos a impressao (igual ao legado).
1637:     *==========================================================================
1638:     PROTECTED PROCEDURE ExibirPreviewBoleto()
1639:         LOCAL loc_cRelatorio, loc_cCursor
1640: 
1641:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorBoleto
1642: 
1643:         DO CASE
1644:             CASE THIS.this_oBusinessObject.this_cBancoConvenio == "001"
1645:                 loc_cRelatorio = "SigReBlqBB"
1646:             CASE INLIST(THIS.this_oBusinessObject.this_cBancoConvenio, "033", "353")
1647:                 loc_cRelatorio = "SigReBlqSt"
1648:             CASE THIS.this_oBusinessObject.this_cBancoConvenio == "237"
1649:                 loc_cRelatorio = "SigReBlqBra"
1650:             OTHERWISE
1651:                 loc_cRelatorio = ""
1652:         ENDCASE
1653: 
1654:         IF !EMPTY(loc_cRelatorio)
1655:             THIS.ExecutarReportForm(loc_cRelatorio, "PREVIEW", loc_cCursor)
1656:         ENDIF
1657: 
1658:         THIS.this_oBusinessObject.LimparImagensBarras(loc_cCursor)
1659: 
1660:         IF USED(loc_cCursor)
1661:             USE IN (loc_cCursor)
1662:         ENDIF
1663:         THIS.this_oBusinessObject.this_cCursorBoleto = ""
1664:     ENDPROC
1665: 
1666:     *==========================================================================
1667:     * ValidarCodEmpresa - KeyPress em txt_4c_CodEmpresa (get_cd_empresa no
1668:     * legado). Enter/Tab/F4 -> SELECT exato em SigCdEmp.Cemps; hit preenche a
1669:     * razao social, miss abre o picker (fAcessoEmpresa modo 'C' nao portada -
1670:     * regra CLAUDE.md sobre fAcessoEmpresa, substituicao canonica FormBuscaAuxiliar
1671:     * em SigCdEmp).
1672:     *==========================================================================
1673:     PROCEDURE ValidarCodEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1674:         LOCAL loc_oPag, loc_cVal, loc_nResult
1675: 
1676:         IF par_nKeyCode = 115
1677:             THIS.AbrirBuscaEmpresa()
1678:             RETURN
1679:         ENDIF
1680: 
1681:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1682:             RETURN
1683:         ENDIF
1684: 
1685:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1686:         loc_cVal = ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value)
1687: 
1688:         IF EMPTY(loc_cVal)
1689:             loc_oPag.txt_4c_NomeEmpresa.Value = ""
1690:             loc_oPag.txt_4c_NomeEmpresa.Refresh
1691:             RETURN
1692:         ENDIF
1693: 
1694:         TRY
1695:             loc_nResult = SQLEXEC(gnConnHandle, ;
1696:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
1697:                 "cursor_4c_EmpresaVal")
1698:             IF loc_nResult > 0 AND USED("cursor_4c_EmpresaVal") AND !EOF("cursor_4c_EmpresaVal")
1699:                 SELECT cursor_4c_EmpresaVal
1700:                 loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_EmpresaVal.Cemps)
1701:                 loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Razas)
1702:             ELSE
1703:                 THIS.AbrirBuscaEmpresa()
1704:             ENDIF
1705:             IF USED("cursor_4c_EmpresaVal")
1706:                 USE IN cursor_4c_EmpresaVal
1707:             ENDIF
1708:         CATCH TO loc_oErro
1709:             MsgErro(loc_oErro.Message, "Erro")
1710:         ENDTRY
1711: 
1712:         loc_oPag.txt_4c_CodEmpresa.Refresh
1713:         loc_oPag.txt_4c_NomeEmpresa.Refresh
1714:     ENDPROC
1715: 
1716:     *==========================================================================
1717:     * ValidarNomEmpresa - KeyPress em txt_4c_NomeEmpresa (get_ds_empresa no
1718:     * legado). So age quando o codigo esta vazio (When: Empty(get_cd_empresa)).
1719:     *==========================================================================
1720:     PROCEDURE ValidarNomEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1721:         LOCAL loc_oPag, loc_cVal, loc_nResult
1722: 
1723:         IF par_nKeyCode = 115
1724:             THIS.AbrirBuscaEmpresa()
1725:             RETURN
1726:         ENDIF
1727: 
1728:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1729:             RETURN
1730:         ENDIF
1731: 
1732:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1733: 
1734:         IF !EMPTY(ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value))
1735:             RETURN
1736:         ENDIF
1737: 
1738:         loc_cVal = ALLTRIM(loc_oPag.txt_4c_NomeEmpresa.Value)
1739:         IF EMPTY(loc_cVal)
1740:             loc_oPag.txt_4c_CodEmpresa.Value = ""
1741:             loc_oPag.txt_4c_CodEmpresa.Refresh
1742:             RETURN
1743:         ENDIF
1744: 
1745:         TRY
1746:             loc_nResult = SQLEXEC(gnConnHandle, ;
1747:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE RTRIM(Razas) = " + EscaparSQL(loc_cVal), ;
1748:                 "cursor_4c_EmpresaVal")
1749:             IF loc_nResult > 0 AND USED("cursor_4c_EmpresaVal") AND !EOF("cursor_4c_EmpresaVal")
1750:                 SELECT cursor_4c_EmpresaVal
1751:                 loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_EmpresaVal.Cemps)
1752:                 loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Razas)
1753:             ELSE
1754:                 THIS.AbrirBuscaEmpresa()
1755:             ENDIF
1756:             IF USED("cursor_4c_EmpresaVal")
1757:                 USE IN cursor_4c_EmpresaVal
1758:             ENDIF
1759:         CATCH TO loc_oErro
1760:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 1768 a 1957:
1768:     * AbrirBuscaEmpresa - picker por Cemps/Razas em SigCdEmp (substitui
1769:     * fAcessoEmpresa modo lookup - funcao NAO portada, ver CLAUDE.md).
1770:     *==========================================================================
1771:     PROCEDURE AbrirBuscaEmpresa()
1772:         LOCAL loc_oPag, loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir
1773: 
1774:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
1775:         loc_cValor  = ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value)
1776:         IF EMPTY(loc_cValor)
1777:             loc_cValor = ALLTRIM(loc_oPag.txt_4c_NomeEmpresa.Value)
1778:         ENDIF
1779:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa"
1780: 
1781:         IF USED("cursor_4c_BuscaEmpresa")
1782:             USE IN cursor_4c_BuscaEmpresa
1783:         ENDIF
1784: 
1785:         loc_lProsseguir = .T.
1786:         TRY
1787:             IF EMPTY(loc_cValor)
1788:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
1789:             ELSE
1790:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
1791:                            "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
1792:                            " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
1793:                            " ORDER BY Cemps"
1794:             ENDIF
1795:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpresa")
1796: 
1797:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpresa") OR RECCOUNT("cursor_4c_BuscaEmpresa") = 0) ;
1798:                     AND !EMPTY(loc_cValor)
1799:                 IF USED("cursor_4c_BuscaEmpresa")
1800:                     USE IN cursor_4c_BuscaEmpresa
1801:                 ENDIF
1802:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1803:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
1804:                     "cursor_4c_BuscaEmpresa")
1805:             ENDIF
1806: 
1807:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpresa") OR RECCOUNT("cursor_4c_BuscaEmpresa") = 0
1808:                 MsgAviso("Nenhuma empresa encontrada.", "Empresa")
1809:                 loc_lProsseguir = .F.
1810:             ENDIF
1811: 
1812:             IF loc_lProsseguir
1813:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1814:                 IF VARTYPE(loc_oBusca) = "O"
1815:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpresa"
1816:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1817:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1818:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1819:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1820:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1821:                     loc_oBusca.Show()
1822:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
1823:                         SELECT cursor_4c_BuscaEmpresa
1824:                         loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
1825:                         loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
1826:                     ENDIF
1827:                     loc_oBusca.Release()
1828:                 ENDIF
1829:             ENDIF
1830:         CATCH TO loc_oErro
1831:             MsgErro(loc_oErro.Message, "Erro")
1832:         ENDTRY
1833: 
1834:         IF USED("cursor_4c_BuscaEmpresa")
1835:             USE IN cursor_4c_BuscaEmpresa
1836:         ENDIF
1837:         loc_oPag.txt_4c_CodEmpresa.Refresh
1838:         loc_oPag.txt_4c_NomeEmpresa.Refresh
1839:     ENDPROC
1840: 
1841:     *==========================================================================
1842:     * ValidarDataFinal - KeyPress em txt_4c_DataFinal (Get_Dataf.Valid no
1843:     * legado): data final nao pode ser menor que a inicial.
1844:     *==========================================================================
1845:     PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)
1846:         LOCAL loc_oPag
1847: 
1848:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1849:             RETURN
1850:         ENDIF
1851: 
1852:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1853: 
1854:         IF !EMPTY(loc_oPag.txt_4c_DataInicial.Value) ;
1855:                 AND !EMPTY(loc_oPag.txt_4c_DataFinal.Value) ;
1856:                 AND loc_oPag.txt_4c_DataFinal.Value < loc_oPag.txt_4c_DataInicial.Value
1857:             MsgAviso("Data Final Deve Ser Maior Que a Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
1858:             loc_oPag.txt_4c_DataFinal.SetFocus()
1859:         ENDIF
1860:     ENDPROC
1861: 
1862:     *==========================================================================
1863:     * ValidarCodConta - KeyPress em txt_4c_CodConta (get_cd_car_conta no
1864:     * legado). Enter/Tab/F4 -> SELECT exato em SigCdCli.IClis; hit preenche a
1865:     * razao social, miss abre o picker (fAcessoContas NAO USAR para lookup UX -
1866:     * regra CLAUDE.md, substituicao canonica SigCdCli.IClis/RClis).
1867:     *==========================================================================
1868:     PROCEDURE ValidarCodConta(par_nKeyCode, par_nShiftAltCtrl)
1869:         LOCAL loc_oPag, loc_cVal, loc_nResult
1870: 
1871:         IF par_nKeyCode = 115
1872:             THIS.AbrirBuscaConta()
1873:             RETURN
1874:         ENDIF
1875: 
1876:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1877:             RETURN
1878:         ENDIF
1879: 
1880:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1881:         loc_cVal = ALLTRIM(loc_oPag.txt_4c_CodConta.Value)
1882: 
1883:         IF EMPTY(loc_cVal)
1884:             loc_oPag.txt_4c_NomeConta.Value = ""
1885:             loc_oPag.txt_4c_NomeConta.Refresh
1886:             RETURN
1887:         ENDIF
1888: 
1889:         TRY
1890:             loc_nResult = SQLEXEC(gnConnHandle, ;
1891:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cVal), ;
1892:                 "cursor_4c_ContaVal")
1893:             IF loc_nResult > 0 AND USED("cursor_4c_ContaVal") AND !EOF("cursor_4c_ContaVal")
1894:                 SELECT cursor_4c_ContaVal
1895:                 loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_ContaVal.IClis)
1896:                 loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_ContaVal.RClis)
1897:             ELSE
1898:                 MsgAviso("Conta Inv" + CHR(225) + "lida, Acesso Negado.", "Aviso")
1899:                 loc_oPag.txt_4c_CodConta.Value  = ""
1900:                 loc_oPag.txt_4c_NomeConta.Value = ""
1901:             ENDIF
1902:             IF USED("cursor_4c_ContaVal")
1903:                 USE IN cursor_4c_ContaVal
1904:             ENDIF
1905:         CATCH TO loc_oErro
1906:             MsgErro(loc_oErro.Message, "Erro")
1907:         ENDTRY
1908: 
1909:         loc_oPag.txt_4c_CodConta.Refresh
1910:         loc_oPag.txt_4c_NomeConta.Refresh
1911:     ENDPROC
1912: 
1913:     *==========================================================================
1914:     * ValidarNomConta - KeyPress em txt_4c_NomeConta (get_ds_car_conta no
1915:     * legado). So age quando o codigo esta vazio (When: IsEmpty(get_cd_car_conta)).
1916:     *==========================================================================
1917:     PROCEDURE ValidarNomConta(par_nKeyCode, par_nShiftAltCtrl)
1918:         LOCAL loc_oPag, loc_cVal, loc_nResult
1919: 
1920:         IF par_nKeyCode = 115
1921:             THIS.AbrirBuscaConta()
1922:             RETURN
1923:         ENDIF
1924: 
1925:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1926:             RETURN
1927:         ENDIF
1928: 
1929:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1930: 
1931:         IF !EMPTY(ALLTRIM(loc_oPag.txt_4c_CodConta.Value))
1932:             RETURN
1933:         ENDIF
1934: 
1935:         loc_cVal = ALLTRIM(loc_oPag.txt_4c_NomeConta.Value)
1936:         IF EMPTY(loc_cVal)
1937:             loc_oPag.txt_4c_CodConta.Value = ""
1938:             loc_oPag.txt_4c_CodConta.Refresh
1939:             RETURN
1940:         ENDIF
1941: 
1942:         TRY
1943:             loc_nResult = SQLEXEC(gnConnHandle, ;
1944:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) = " + EscaparSQL(loc_cVal), ;
1945:                 "cursor_4c_ContaVal")
1946:             IF loc_nResult > 0 AND USED("cursor_4c_ContaVal") AND !EOF("cursor_4c_ContaVal")
1947:                 SELECT cursor_4c_ContaVal
1948:                 loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_ContaVal.IClis)
1949:                 loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_ContaVal.RClis)
1950:             ELSE
1951:                 THIS.AbrirBuscaConta()
1952:             ENDIF
1953:             IF USED("cursor_4c_ContaVal")
1954:                 USE IN cursor_4c_ContaVal
1955:             ENDIF
1956:         CATCH TO loc_oErro
1957:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 1965 a 2207:
1965:     * AbrirBuscaConta - picker por IClis/RClis em SigCdCli (conta/carteira do
1966:     * banco - substitui fAcessoContas, que NAO deve ser usada para lookup UX).
1967:     *==========================================================================
1968:     PROCEDURE AbrirBuscaConta()
1969:         LOCAL loc_oPag, loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir
1970: 
1971:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
1972:         loc_cValor  = ALLTRIM(loc_oPag.txt_4c_CodConta.Value)
1973:         IF EMPTY(loc_cValor)
1974:             loc_cValor = ALLTRIM(loc_oPag.txt_4c_NomeConta.Value)
1975:         ENDIF
1976:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Conta"
1977: 
1978:         IF USED("cursor_4c_BuscaConta")
1979:             USE IN cursor_4c_BuscaConta
1980:         ENDIF
1981: 
1982:         loc_lProsseguir = .T.
1983:         TRY
1984:             IF EMPTY(loc_cValor)
1985:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis"
1986:             ELSE
1987:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
1988:                            "WHERE IClis LIKE " + EscaparSQL(loc_cValor + "%") + ;
1989:                            " OR RTRIM(RClis) LIKE " + EscaparSQL(loc_cValor + "%") + ;
1990:                            " ORDER BY IClis"
1991:             ENDIF
1992:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
1993: 
1994:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaConta") OR RECCOUNT("cursor_4c_BuscaConta") = 0) ;
1995:                     AND !EMPTY(loc_cValor)
1996:                 IF USED("cursor_4c_BuscaConta")
1997:                     USE IN cursor_4c_BuscaConta
1998:                 ENDIF
1999:                 loc_nResult = SQLEXEC(gnConnHandle, ;
2000:                     "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis", ;
2001:                     "cursor_4c_BuscaConta")
2002:             ENDIF
2003: 
2004:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaConta") OR RECCOUNT("cursor_4c_BuscaConta") = 0
2005:                 MsgAviso("Nenhuma conta encontrada.", "Conta")
2006:                 loc_lProsseguir = .F.
2007:             ENDIF
2008: 
2009:             IF loc_lProsseguir
2010:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2011:                 IF VARTYPE(loc_oBusca) = "O"
2012:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
2013:                     loc_oBusca.this_cTitulo        = loc_cTitulo
2014:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
2015:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
2016:                     loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2017:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
2018:                     loc_oBusca.Show()
2019:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
2020:                         SELECT cursor_4c_BuscaConta
2021:                         loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
2022:                         loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
2023:                     ENDIF
2024:                     loc_oBusca.Release()
2025:                 ENDIF
2026:             ENDIF
2027:         CATCH TO loc_oErro
2028:             MsgErro(loc_oErro.Message, "Erro")
2029:         ENDTRY
2030: 
2031:         IF USED("cursor_4c_BuscaConta")
2032:             USE IN cursor_4c_BuscaConta
2033:         ENDIF
2034:         loc_oPag.txt_4c_CodConta.Refresh
2035:         loc_oPag.txt_4c_NomeConta.Refresh
2036:     ENDPROC
2037: 
2038:     *==========================================================================
2039:     * ValidarTituloBanco - KeyPress em txt_4c_TituloBanco (Get_titban no
2040:     * legado). Enter/Tab/F4 -> SEEK exato em SigOpFp.Fpags (mesmo filtro do
2041:     * legado: Situas in ('R','A') And Infos = 'K'); miss abre o picker
2042:     * (fwBuscaSel legado -> FormBuscaAuxiliar canonico, tabela single-column
2043:     * como SigCdOpe - so existe o campo Fpags, sem descricao textual).
2044:     *==========================================================================
2045:     PROCEDURE ValidarTituloBanco(par_nKeyCode, par_nShiftAltCtrl)
2046:         LOCAL loc_oPag, loc_cVal, loc_nResult
2047: 
2048:         IF par_nKeyCode = 115
2049:             THIS.AbrirBuscaTituloBanco()
2050:             RETURN
2051:         ENDIF
2052: 
2053:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
2054:             RETURN
2055:         ENDIF
2056: 
2057:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2058:         loc_cVal = ALLTRIM(loc_oPag.txt_4c_TituloBanco.Value)
2059: 
2060:         IF EMPTY(loc_cVal)
2061:             RETURN
2062:         ENDIF
2063: 
2064:         TRY
2065:             loc_nResult = SQLEXEC(gnConnHandle, ;
2066:                 "SELECT TOP 1 Fpags FROM SigOpFp WHERE Fpags = " + EscaparSQL(loc_cVal) + ;
2067:                 " AND Situas IN ('R','A') AND Infos = 'K'", ;
2068:                 "cursor_4c_TituloBancoVal")
2069:             IF loc_nResult > 0 AND USED("cursor_4c_TituloBancoVal") AND !EOF("cursor_4c_TituloBancoVal")
2070:                 SELECT cursor_4c_TituloBancoVal
2071:                 loc_oPag.txt_4c_TituloBanco.Value = ALLTRIM(cursor_4c_TituloBancoVal.Fpags)
2072:             ELSE
2073:                 THIS.AbrirBuscaTituloBanco()
2074:             ENDIF
2075:             IF USED("cursor_4c_TituloBancoVal")
2076:                 USE IN cursor_4c_TituloBancoVal
2077:             ENDIF
2078:         CATCH TO loc_oErro
2079:             MsgErro(loc_oErro.Message, "Erro")
2080:         ENDTRY
2081: 
2082:         loc_oPag.txt_4c_TituloBanco.Refresh
2083:     ENDPROC
2084: 
2085:     *==========================================================================
2086:     * AbrirBuscaTituloBanco - picker por Fpags em SigOpFp (Formas de
2087:     * Pagamento), mesmo filtro do legado (Situas in ('R','A') And Infos='K').
2088:     * Single-column, igual SigCdOpe (regra CLAUDE.md) - o legado so exibe o
2089:     * codigo (AddColuna('FPags', ...)), sem coluna de descricao.
2090:     *==========================================================================
2091:     PROCEDURE AbrirBuscaTituloBanco()
2092:         LOCAL loc_oPag, loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir
2093: 
2094:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
2095:         loc_cValor  = ALLTRIM(loc_oPag.txt_4c_TituloBanco.Value)
2096:         loc_cTitulo = "Formas de Pagamento"
2097: 
2098:         IF USED("cursor_4c_BuscaTituloBanco")
2099:             USE IN cursor_4c_BuscaTituloBanco
2100:         ENDIF
2101: 
2102:         loc_lProsseguir = .T.
2103:         TRY
2104:             IF EMPTY(loc_cValor)
2105:                 loc_cSQL = "SELECT Fpags FROM SigOpFp WHERE Situas IN ('R','A') AND Infos = 'K' ORDER BY Fpags"
2106:             ELSE
2107:                 loc_cSQL = "SELECT Fpags FROM SigOpFp " + ;
2108:                            "WHERE Situas IN ('R','A') AND Infos = 'K' " + ;
2109:                            "AND Fpags LIKE " + EscaparSQL(loc_cValor + "%") + ;
2110:                            " ORDER BY Fpags"
2111:             ENDIF
2112:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTituloBanco")
2113: 
2114:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaTituloBanco") OR RECCOUNT("cursor_4c_BuscaTituloBanco") = 0) ;
2115:                     AND !EMPTY(loc_cValor)
2116:                 IF USED("cursor_4c_BuscaTituloBanco")
2117:                     USE IN cursor_4c_BuscaTituloBanco
2118:                 ENDIF
2119:                 loc_nResult = SQLEXEC(gnConnHandle, ;
2120:                     "SELECT Fpags FROM SigOpFp WHERE Situas IN ('R','A') AND Infos = 'K' ORDER BY Fpags", ;
2121:                     "cursor_4c_BuscaTituloBanco")
2122:             ENDIF
2123: 
2124:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaTituloBanco") OR RECCOUNT("cursor_4c_BuscaTituloBanco") = 0
2125:                 MsgAviso("Nenhuma forma de pagamento encontrada.", "Formas de Pagamento")
2126:                 loc_lProsseguir = .F.
2127:             ENDIF
2128: 
2129:             IF loc_lProsseguir
2130:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2131:                 IF VARTYPE(loc_oBusca) = "O"
2132:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTituloBanco"
2133:                     loc_oBusca.this_cTitulo        = loc_cTitulo
2134:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
2135:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
2136:                     loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
2137:                     loc_oBusca.Show()
2138:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTituloBanco")
2139:                         SELECT cursor_4c_BuscaTituloBanco
2140:                         loc_oPag.txt_4c_TituloBanco.Value = ALLTRIM(cursor_4c_BuscaTituloBanco.Fpags)
2141:                     ENDIF
2142:                     loc_oBusca.Release()
2143:                 ENDIF
2144:             ENDIF
2145:         CATCH TO loc_oErro
2146:             MsgErro(loc_oErro.Message, "Erro")
2147:         ENDTRY
2148: 
2149:         IF USED("cursor_4c_BuscaTituloBanco")
2150:             USE IN cursor_4c_BuscaTituloBanco
2151:         ENDIF
2152:         loc_oPag.txt_4c_TituloBanco.Refresh
2153:     ENDPROC
2154: 
2155:     *==========================================================================
2156:     * AlternarPagina - Alterna entre a pagina de Filtro (1) e a de Dados (2).
2157:     * Usado pelo fluxo Processar->Dados e pelo retorno Dados->Filtro (regra de
2158:     * negocio de quando alternar fica para as Fases 7-8).
2159:     *==========================================================================
2160:     PROCEDURE AlternarPagina(par_nPagina)
2161:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2162:     ENDPROC
2163: 
2164:     *==========================================================================
2165:     * TornarControlesVisiveis - Torna visiveis os controles ja criados
2166:     *==========================================================================
2167:     PROTECTED PROCEDURE TornarControlesVisiveis()
2168:         LOCAL loc_oP1, loc_oP2
2169: 
2170:         THIS.pgf_4c_Paginas.Visible = .T.
2171: 
2172:         loc_oP1 = THIS.pgf_4c_Paginas.Page1
2173:         loc_oP1.cnt_4c_Cabecalho.Visible                       = .T.
2174:         loc_oP1.cnt_4c_Cabecalho.lbl_4c_Sombra.Visible         = .T.
2175:         loc_oP1.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible         = .T.
2176:         loc_oP1.cnt_4c_Botoes.Visible                          = .T.
2177:         loc_oP1.cnt_4c_Botoes.cmd_4c_Processar.Visible         = .T.
2178:         loc_oP1.cnt_4c_Botoes.cmd_4c_Encerrar.Visible          = .T.
2179:         loc_oP1.cnt_4c_Marca.Visible                           = .T.
2180:         loc_oP1.cnt_4c_Marca.cmd_4c_MarcarTudo.Visible         = .T.
2181:         loc_oP1.cnt_4c_Marca.cmd_4c_DesmarcarTudo.Visible      = .T.
2182:         loc_oP1.lbl_4c_Operacoes.Visible                       = .T.
2183:         loc_oP1.obj_4c_Processados.Visible                     = .T.
2184:         loc_oP1.lbl_4c_Empresa.Visible                         = .T.
2185:         loc_oP1.txt_4c_CodEmpresa.Visible                      = .T.
2186:         loc_oP1.txt_4c_NomeEmpresa.Visible                     = .T.
2187:         loc_oP1.lbl_4c_Periodo.Visible                         = .T.
2188:         loc_oP1.txt_4c_DataInicial.Visible                     = .T.
2189:         loc_oP1.lbl_4c_Ate.Visible                             = .T.
2190:         loc_oP1.txt_4c_DataFinal.Visible                       = .T.
2191:         loc_oP1.obj_4c_Periodo.Visible                         = .T.
2192:         loc_oP1.lbl_4c_Banco.Visible                           = .T.
2193:         loc_oP1.txt_4c_CodConta.Visible                        = .T.
2194:         loc_oP1.txt_4c_NomeConta.Visible                       = .T.
2195:         loc_oP1.lbl_4c_TituloBanco.Visible                     = .T.
2196:         loc_oP1.txt_4c_TituloBanco.Visible                     = .T.
2197:         loc_oP1.lbl_4c_Operacao.Visible                        = .T.
2198:         loc_oP1.grd_4c_Operacoes.Visible                       = .T.
2199: 
2200:         loc_oP2 = THIS.pgf_4c_Paginas.Page2
2201:         loc_oP2.cnt_4c_Cabecalho.Visible                       = .T.
2202:         loc_oP2.cnt_4c_Cabecalho.lbl_4c_Sombra.Visible         = .T.
2203:         loc_oP2.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible         = .T.
2204:         loc_oP2.cnt_4c_BotoesAcao.Visible                      = .T.
2205:         loc_oP2.cnt_4c_BotoesAcao.cmd_4c_Encerrar.Visible      = .T.
2206:         loc_oP2.cnt_4c_BotoesAcao.obj_4c_Comandos.Visible      = .T.
2207:         loc_oP2.lbl_4c_Label12.Visible                         = .T.

*-- Linhas 2218 a 2225:
2218:     *==========================================================================
2219:     * DESTROY - delega para FormBase.Destroy (restaura menu apos fechamento)
2220:     *==========================================================================
2221:     PROCEDURE Destroy()
2222:         RETURN DODEFAULT()
2223:     ENDPROC
2224: 
2225: ENDDEFINE

