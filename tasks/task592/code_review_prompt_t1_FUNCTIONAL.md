# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [METODO-INEXISTENTE] Metodo 'THIS.ImprimirBoleto()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGridTit define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGridTit.RecordSource).
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCNB.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2194 linhas total):

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
353:             ENDWITH
354: 
355:             WITH .Buttons(2)
356:                 .FontName  = "Tahoma"
357:                 .FontSize  = 8
358:                 .BackStyle = 0
359:                 .Caption   = "J" + CHR(225) + " Processadas"
360:                 .ForeColor = RGB(90,90,90)
361:             ENDWITH
362:         ENDWITH
363: 
364:         *-- Empresa (Say4 + get_cd_empresa + get_ds_empresa no legado)
365:         loc_oPag.AddObject("lbl_4c_Empresa", "Label")
366:         WITH loc_oPag.lbl_4c_Empresa
367:             .Top       = 152
368:             .Left      = 297
369:             .Width     = 50
370:             .Height    = 15
371:             .FontName  = "Tahoma"
372:             .FontSize  = 8
373:             .AutoSize  = .F.
374:             .Alignment = 0
375:             .BackStyle = 0
376:             .ForeColor = RGB(90,90,90)

*-- Linhas 462 a 505:
462:             .Value         = {}
463:         ENDWITH
464: 
465:         loc_oPag.AddObject("obj_4c_Periodo", "OptionGroup")
466:         WITH loc_oPag.obj_4c_Periodo
467:             .Top         = 175
468:             .Left        = 544
469:             .Width       = 168
470:             .Height      = 25
471:             .BackStyle   = 0
472:             .BorderStyle = 0
473:             .ButtonCount = 2
474:             .Value       = 1
475: 
476:             WITH .Buttons(1)
477:                 .FontName  = "Tahoma"
478:                 .FontSize  = 8
479:                 .BackStyle = 0
480:                 .Caption   = "Vencimento"
481:                 .ForeColor = RGB(90,90,90)
482:             ENDWITH
483: 
484:             WITH .Buttons(2)
485:                 .FontName  = "Tahoma"
486:                 .FontSize  = 8
487:                 .BackStyle = 0
488:                 .Caption   = "Emiss" + CHR(227) + "o"
489:                 .ForeColor = RGB(90,90,90)
490:             ENDWITH
491:         ENDWITH
492: 
493:         *-- Banco/Conta (Say2 + get_cd_car_conta + get_ds_car_conta)
494:         loc_oPag.AddObject("lbl_4c_Banco", "Label")
495:         WITH loc_oPag.lbl_4c_Banco
496:             .Top       = 209
497:             .Left      = 309
498:             .Width     = 38
499:             .Height    = 15
500:             .FontName  = "Tahoma"
501:             .FontSize  = 8
502:             .AutoSize  = .F.
503:             .Alignment = 0
504:             .BackStyle = 0
505:             .ForeColor = RGB(90,90,90)

*-- Linhas 654 a 697:
654:     * (Say2/Botao1), a grade de titulos (grdope, 8 colunas) e os botoes de
655:     * acao (cmdTestaPos/Commandgroup1/Commandgroup2) ficam para a Fase 6.
656:     *==========================================================================
657:     PROTECTED PROCEDURE ConfigurarPaginaDados()
658:         LOCAL loc_oPag, loc_oCab, loc_oGridTit
659: 
660:         loc_oPag = THIS.pgf_4c_Paginas.Page2
661: 
662:         *-- Faixa do cabecalho - PRIMEIRO AddObject da pagina (regra #11/#39):
663:         *-- containers de botao (cnt_4c_BotoesAcao, Top=27..112) ficam DENTRO
664:         *-- da area da faixa (Top=29..109) e tem de ser criados DEPOIS para
665:         *-- desenhar por cima (excecao da regra: barra de acao do topo com
666:         *-- Top 20..55 e Height 60..100 fica POR CIMA, sem ser deslocada).
667:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
668:         loc_oCab = loc_oPag.cnt_4c_Cabecalho
669:         WITH loc_oCab
670:             .Top           = 29
671:             .Left          = 0
672:             .Width         = THIS.Width
673:             .Height        = 80
674:             .BorderWidth   = 0
675:             .SpecialEffect = 0
676:             .BackColor     = RGB(100,100,100)
677: 
678:             .AddObject("lbl_4c_Sombra", "Label")
679:             WITH .lbl_4c_Sombra
680:                 .Top       = 15
681:                 .Left      = 10
682:                 .Width     = THIS.Width
683:                 .Height    = 40
684:                 .FontName  = "Tahoma"
685:                 .FontSize  = 16
686:                 .FontBold  = .T.
687:                 .WordWrap  = .T.
688:                 .Alignment = 0
689:                 .BackStyle = 0
690:                 .ForeColor = RGB(0,0,0)
691:                 .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB - Recebimentos"
692:             ENDWITH
693: 
694:             .AddObject("lbl_4c_Titulo", "Label")
695:             WITH .lbl_4c_Titulo
696:                 .Top       = 18
697:                 .Left      = 10

*-- Linhas 1034 a 1077:
1034:     * Header1.Caption): uma vez na estrutura inicial (ConfigurarPaginaDados)
1035:     * e de novo apos o SQLEXEC real (THIS.ProcessarTitulos).
1036:     *==========================================================================
1037:     PROTECTED PROCEDURE FormatarGridTitulos(par_oGrid)
1038:         WITH par_oGrid
1039:             .Column1.Width           = 16
1040:             .Column1.Movable         = .F.
1041:             .Column1.Resizable       = .F.
1042:             .Column1.Sparse          = .F.
1043:             .Column1.ReadOnly        = .F.
1044:             .Column1.ColumnOrder     = 1
1045:             .Column1.Header1.Caption = ""
1046: 
1047:             .Column2.Width             = 150
1048:             .Column2.Movable           = .F.
1049:             .Column2.Resizable         = .F.
1050:             .Column2.ReadOnly          = .T.
1051:             .Column2.ColumnOrder       = 3
1052:             .Column2.Header1.Alignment = 2
1053:             .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
1054: 
1055:             .Column3.Width             = 52
1056:             .Column3.Movable           = .F.
1057:             .Column3.Resizable         = .F.
1058:             .Column3.ReadOnly          = .T.
1059:             .Column3.ColumnOrder       = 4
1060:             .Column3.Header1.Alignment = 2
1061:             .Column3.Header1.Caption   = "C" + CHR(243) + "digo"
1062: 
1063:             .Column4.Width             = 400
1064:             .Column4.Movable           = .F.
1065:             .Column4.Resizable         = .F.
1066:             .Column4.ReadOnly          = .T.
1067:             .Column4.ColumnOrder       = 5
1068:             .Column4.Header1.Alignment = 2
1069:             .Column4.Header1.Caption   = "Cliente"
1070: 
1071:             .Column5.Width             = 72
1072:             .Column5.Movable           = .F.
1073:             .Column5.Resizable         = .F.
1074:             .Column5.ReadOnly          = .T.
1075:             .Column5.ColumnOrder       = 6
1076:             .Column5.Header1.Alignment = 2
1077:             .Column5.Header1.Caption   = "Vencimento"

*-- Linhas 1111 a 1154:
1111:     * Cursor eh READWRITE porque a Coluna1 do grid eh um CheckBox editavel
1112:     * (marca/desmarca operacao) - SQLEXEC devolve cursor somente-leitura.
1113:     *==========================================================================
1114:     PROTECTED PROCEDURE CarregarOperacoes()
1115:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
1116:         loc_lSucesso = .F.
1117: 
1118:         TRY
1119:             loc_cSQL = "SELECT Dopes, CAST(0 AS BIT) AS Marca" + CHR(13) + ;
1120:                        "FROM SigCdOpe" + CHR(13) + ;
1121:                        "WHERE Parcontas = 1 AND ValPends = 1" + CHR(13) + ;
1122:                        "ORDER BY Dopes"
1123: 
1124:             IF USED("cursor_4c_OperacoesTmp")
1125:                 USE IN cursor_4c_OperacoesTmp
1126:             ENDIF
1127: 
1128:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacoesTmp")
1129: 
1130:             IF loc_nResultado >= 0
1131:                 IF USED("cursor_4c_Operacoes")
1132:                     USE IN cursor_4c_Operacoes
1133:                 ENDIF
1134: 
1135:                 SELECT * FROM cursor_4c_OperacoesTmp INTO CURSOR cursor_4c_Operacoes READWRITE
1136: 
1137:                 IF USED("cursor_4c_OperacoesTmp")
1138:                     USE IN cursor_4c_OperacoesTmp
1139:                 ENDIF
1140: 
1141:                 IF RECCOUNT("cursor_4c_Operacoes") > 0
1142:                     SELECT cursor_4c_Operacoes
1143:                     GO TOP
1144:                 ENDIF
1145: 
1146:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.ColumnCount = 3
1147:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.RecordSource = "cursor_4c_Operacoes"
1148: 
1149:                 *-- RecordSource reatribuido faz o Grid auto-bindar as colunas
1150:                 *-- pela ordem dos campos do cursor, ignorando o ControlSource
1151:                 *-- anterior - redefinir explicitamente (regra GRID-RECORDSOURCE-AUTOBIND).
1152:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Column1.ControlSource = "cursor_4c_Operacoes.Marca"
1153:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Column2.ControlSource = "cursor_4c_Operacoes.Dopes"
1154: 

*-- Linhas 1162 a 1344:
1162:         CATCH TO loc_oErro
1163:             MostrarErro(loc_oErro.Message + CHR(13) + ;
1164:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1165:                         "Procedure: " + loc_oErro.Procedure, "Erro CarregarOperacoes")
1166:         ENDTRY
1167: 
1168:         RETURN loc_lSucesso
1169:     ENDPROC
1170: 
1171:     *==========================================================================
1172:     * ConfigurarBindEventsFiltro - Registra os BINDEVENTs dos campos de filtro
1173:     * da Page1 (Empresa/Periodo/Banco-Conta/Titulo Banco). Handlers PUBLIC
1174:     * (regra #3 - BINDEVENT falha silenciosamente em metodo PROTECTED).
1175:     *==========================================================================
1176:     PROTECTED PROCEDURE ConfigurarBindEventsFiltro()
1177:         LOCAL loc_oPag
1178:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1179: 
1180:         *-- Empresa
1181:         BINDEVENT(loc_oPag.txt_4c_CodEmpresa,  "KeyPress", THIS, "ValidarCodEmpresa")
1182:         BINDEVENT(loc_oPag.txt_4c_NomeEmpresa, "KeyPress", THIS, "ValidarNomEmpresa")
1183: 
1184:         *-- Periodo (validacao de intervalo de datas)
1185:         BINDEVENT(loc_oPag.txt_4c_DataFinal,   "KeyPress", THIS, "ValidarDataFinal")
1186: 
1187:         *-- Banco/Conta
1188:         BINDEVENT(loc_oPag.txt_4c_CodConta,    "KeyPress", THIS, "ValidarCodConta")
1189:         BINDEVENT(loc_oPag.txt_4c_NomeConta,   "KeyPress", THIS, "ValidarNomConta")
1190: 
1191:         *-- Titulo Banco (SigOpFp.Fpags)
1192:         BINDEVENT(loc_oPag.txt_4c_TituloBanco, "KeyPress", THIS, "ValidarTituloBanco")
1193:     ENDPROC
1194: 
1195:     *==========================================================================
1196:     * ConfigurarBindEventsPrincipais - Registra os BINDEVENTs dos botoes
1197:     * principais (Processar/Encerrar/Marcar/Desmarcar da Pagina Filtro e
1198:     * Voltar/Marcar/Desmarcar da Pagina Dados). Handlers PUBLIC (regra #3).
1199:     *==========================================================================
1200:     PROTECTED PROCEDURE ConfigurarBindEventsPrincipais()
1201:         LOCAL loc_oPag1, loc_oPag2
1202: 
1203:         loc_oPag1 = THIS.pgf_4c_Paginas.Page1
1204:         BINDEVENT(loc_oPag1.cnt_4c_Botoes.cmd_4c_Processar,    "Click", THIS, "BtnProcessarClick")
1205:         BINDEVENT(loc_oPag1.cnt_4c_Botoes.cmd_4c_Encerrar,     "Click", THIS, "BtnEncerrarClick")
1206:         BINDEVENT(loc_oPag1.cnt_4c_Marca.cmd_4c_MarcarTudo,    "Click", THIS, "BtnMarcarTudoClick")
1207:         BINDEVENT(loc_oPag1.cnt_4c_Marca.cmd_4c_DesmarcarTudo, "Click", THIS, "BtnDesmarcarTudoClick")
1208: 
1209:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1210:         BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Encerrar,   "Click", THIS, "BtnVoltarClick")
1211:         BINDEVENT(loc_oPag2.cnt_4c_Marca.cmd_4c_MarcarTudo,      "Click", THIS, "BtnMarcarTudoTitulosClick")
1212:         BINDEVENT(loc_oPag2.cnt_4c_Marca.cmd_4c_DesmarcarTudo,   "Click", THIS, "BtnDesmarcarTudoTitulosClick")
1213:         BINDEVENT(loc_oPag2.grd_4c_Titulos.Column1.chk_4c_Marca, "Click", THIS, "ChkTituloMarcaClick")
1214: 
1215:         *-- obj_4c_Comandos (Commandgroup1 no legado: btncnab/btnrelatorio/btnBoleto)
1216:         BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(1), "Click", THIS, "BtnGerarCnabClick")
1217:         BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(2), "Click", THIS, "BtnRelatorioCnabClick")
1218:         BINDEVENT(loc_oPag2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(3), "Click", THIS, "BtnBoletoClick")
1219:     ENDPROC
1220: 
1221:     *==========================================================================
1222:     * BtnProcessarClick - cmdTestaPos.btnProcessar.Click no legado. Valida
1223:     * Empresa/Periodo/Conta obrigatorios e exige ao menos 1 operacao marcada
1224:     * antes de consultar os titulos em aberto.
1225:     *==========================================================================
1226:     PROCEDURE BtnProcessarClick()
1227:         LOCAL loc_oPag, loc_nCont
1228: 
1229:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1230: 
1231:         IF EMPTY(ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value))
1232:             MsgAviso("Empresa inv" + CHR(225) + "lida", "Aviso")
1233:             loc_oPag.txt_4c_CodEmpresa.SetFocus()
1234:             RETURN
1235:         ENDIF
1236: 
1237:         IF EMPTY(loc_oPag.txt_4c_DataInicial.Value) OR EMPTY(loc_oPag.txt_4c_DataFinal.Value)
1238:             MsgAviso("Per" + CHR(237) + "odo inv" + CHR(225) + "lido", "Aviso")
1239:             loc_oPag.txt_4c_DataInicial.SetFocus()
1240:             RETURN
1241:         ENDIF
1242: 
1243:         IF EMPTY(ALLTRIM(loc_oPag.txt_4c_CodConta.Value))
1244:             MsgAviso("Banco inv" + CHR(225) + "lido", "Aviso")
1245:             loc_oPag.txt_4c_CodConta.SetFocus()
1246:             RETURN
1247:         ENDIF
1248: 
1249:         loc_nCont = 0
1250:         IF USED("cursor_4c_Operacoes")
1251:             SELECT cursor_4c_Operacoes
1252:             COUNT FOR Marca TO loc_nCont
1253:         ENDIF
1254:         IF loc_nCont = 0
1255:             MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o foi selecionada", "Aviso")
1256:             RETURN
1257:         ENDIF
1258: 
1259:         THIS.ProcessarTitulos()
1260:     ENDPROC
1261: 
1262:     *==========================================================================
1263:     * BtnEncerrarClick - cmdTestaPos.btnsair.Click (Pagina Filtro) no legado.
1264:     *==========================================================================
1265:     PROCEDURE BtnEncerrarClick()
1266:         THIS.Release()
1267:     ENDPROC
1268: 
1269:     *==========================================================================
1270:     * BtnMarcarTudoClick/BtnDesmarcarTudoClick - Commandgroup2.btnmarca/
1271:     * btndesmarca.Click (Pagina Filtro) no legado - marca/desmarca TODAS as
1272:     * operacoes do grid de filtro, sem excecao (igual ao legado).
1273:     *==========================================================================
1274:     PROCEDURE BtnMarcarTudoClick()
1275:         IF USED("cursor_4c_Operacoes")
1276:             SELECT cursor_4c_Operacoes
1277:             REPLACE ALL Marca WITH .T.
1278:             LOCATE
1279:             GO TOP
1280:         ENDIF
1281:         THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
1282:     ENDPROC
1283: 
1284:     PROCEDURE BtnDesmarcarTudoClick()
1285:         IF USED("cursor_4c_Operacoes")
1286:             SELECT cursor_4c_Operacoes
1287:             REPLACE ALL Marca WITH .F.
1288:             LOCATE
1289:             GO TOP
1290:         ENDIF
1291:         THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
1292:     ENDPROC
1293: 
1294:     *==========================================================================
1295:     * ProcessarTitulos - PROCEDURE processamento no legado. Monta a lista de
1296:     * operacoes marcadas + consulta os titulos em aberto (SigMvPar/SigOpFp/
1297:     * SigMvCab/SigCdCli/SigMvCcr), populando cursor_4c_Titulos (READWRITE -
1298:     * a coluna Marca eh CheckBox editavel no grid). Formula/filtros
1299:     * TRANSCRITOS literalmente do legado (regra CLAUDE.md #17) - inclusive a
1300:     * ausencia de filtro pela conta/carteira na consulta (o legado le
1301:     * get_cd_car_conta so para validar preenchimento, e aplica a conta
1302:     * apenas na geracao do CNAB, fase 8).
1303:     *==========================================================================
1304:     PROTECTED PROCEDURE ProcessarTitulos()
1305:         LOCAL loc_oPag, loc_cListaOperacoes, loc_cEmpresa, loc_dIni, loc_dFim, loc_nPeriodo, ;
1306:               loc_lNaoProcessados, loc_cCampoData, loc_cNotIn, loc_cSQL, loc_nResultado, ;
1307:               loc_lSucesso, loc_oGrid, loc_oErro
1308:         loc_lSucesso = .F.
1309: 
1310:         loc_oPag             = THIS.pgf_4c_Paginas.Page1
1311:         loc_cEmpresa         = ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value)
1312:         loc_dIni             = loc_oPag.txt_4c_DataInicial.Value
1313:         loc_dFim             = loc_oPag.txt_4c_DataFinal.Value
1314:         loc_nPeriodo         = loc_oPag.obj_4c_Periodo.Value          && 1=Vencimento, 2=Emissao
1315:         loc_lNaoProcessados  = (loc_oPag.obj_4c_Processados.Value = 1) && 1=Nao Processadas, 2=Ja Processadas
1316: 
1317:         *-- Lista das operacoes marcadas - IN-list de coluna CHAR unica
1318:         *-- (compara com blank-padding ANSI no SQL Server); NAO eh a chave
1319:         *-- POSICIONAL concatenada da regra #42, ALLTRIM por item eh seguro.
1320:         loc_cListaOperacoes = "("
1321:         IF USED("cursor_4c_Operacoes")
1322:             SELECT cursor_4c_Operacoes
1323:             SCAN FOR Marca
1324:                 loc_cListaOperacoes = loc_cListaOperacoes + ;
1325:                     IIF(loc_cListaOperacoes == "(", "", ",") + EscaparSQL(ALLTRIM(Dopes))
1326:             ENDSCAN
1327:         ENDIF
1328:         loc_cListaOperacoes = loc_cListaOperacoes + ")"
1329: 
1330:         loc_cCampoData = IIF(loc_nPeriodo = 1, "a.vencs", "e.dtemis")
1331:         loc_cNotIn     = IIF(loc_lNaoProcessados, "NOT ", "")
1332: 
1333:         TRY
1334:             loc_cSQL = ;
1335:                 "SELECT CAST(1 AS BIT) AS Marca, e.titulos AS Titulos, a.dopes AS Dopes, a.numes AS Numes," + CHR(13) + ;
1336:                 "       d.rclis AS RClis, a.vencs AS Vencs, b.fpags AS Fpags, a.valos AS Valos, a.datas AS Datas," + CHR(13) + ;
1337:                 "       a.vpags AS Vpags, d.iclis AS IClis, d.endes AS Endes, d.cidas AS Cidas, d.estas AS Estas," + CHR(13) + ;
1338:                 "       d.nums AS Nums, d.compls AS Compls, d.bairs AS Bairs, d.ceps AS Ceps, d.cpfs AS Cpfs," + CHR(13) + ;
1339:                 "       a.emps AS Emps, a.empdopnums AS EmpDopNums, a.nopers AS Nopers, d.razaos AS Razaos," + CHR(13) + ;
1340:                 "       d.endcobs AS EndCobs, d.cepcobs AS CepCobs, d.estcobs AS EstCobs, d.baicobs AS BaiCobs, d.cidcobs AS CidCobs," + CHR(13) + ;
1341:                 "       CASE WHEN d.endcobs <> '' AND LEN(RTRIM(d.endcobs)) > 40 THEN 1" + CHR(13) + ;
1342:                 "            WHEN d.endes <> '' AND LEN(RTRIM(d.endes) + ' ' + RTRIM(d.nums) + ' ' + RTRIM(d.compls)) > 40 THEN 1" + CHR(13) + ;
1343:                 "            ELSE 0 END AS EndErro" + CHR(13) + ;
1344:                 "FROM SigMvPar a" + CHR(13) + ;

*-- Linhas 1375 a 1729:
1375:                 ENDIF
1376: 
1377:                 IF RECCOUNT("cursor_4c_Titulos") = 0
1378:                     MsgAviso("Nenhum dado foi encontrado", "Aviso")
1379:                 ELSE
1380:                     SELECT cursor_4c_Titulos
1381:                     REPLACE ALL Marca WITH .F. FOR EndErro = 1
1382:                     GO TOP
1383: 
1384:                     loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos
1385:                     loc_oGrid.ColumnCount = 8
1386:                     loc_oGrid.RecordSource         = "cursor_4c_Titulos"
1387:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Titulos.Marca"
1388:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Titulos.Dopes"
1389:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Titulos.Numes"
1390:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Titulos.RClis"
1391:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Titulos.Vencs"
1392:                     loc_oGrid.Column6.ControlSource = "cursor_4c_Titulos.Fpags"
1393:                     loc_oGrid.Column7.ControlSource = "cursor_4c_Titulos.Valos"
1394:                     loc_oGrid.Column8.ControlSource = "cursor_4c_Titulos.Titulos"
1395:                     THIS.FormatarGridTitulos(loc_oGrid)
1396:                     loc_oGrid.Refresh()
1397: 
1398:                     THIS.pgf_4c_Paginas.Page1.Enabled = .F.
1399:                     THIS.pgf_4c_Paginas.Page2.Enabled = .T.
1400: 
1401:                     *-- cmdTestaPos.btnBoleto.Enabled = !llNPr no legado (linha
1402:                     *-- 1468): Boleto so comeca habilitado quando o filtro eh
1403:                     *-- "Ja Processadas" (reimpressao); ProcessadoBrasil/
1404:                     *-- Santander240 forcam .T. depois de gerar com sucesso.
1405:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(3).Enabled = ;
1406:                         (loc_oPag.obj_4c_Processados.Value = 2)
1407: 
1408:                     THIS.AlternarPagina(2)
1409:                     loc_lSucesso = .T.
1410:                 ENDIF
1411:             ELSE
1412:                 MostrarErro("Erro ao processar os t" + CHR(237) + "tulos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1413:             ENDIF
1414:         CATCH TO loc_oErro
1415:             MostrarErro(loc_oErro.Message + CHR(13) + ;
1416:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1417:                         "Procedure: " + loc_oErro.Procedure, "Erro ProcessarTitulos")
1418:         ENDTRY
1419: 
1420:         RETURN loc_lSucesso
1421:     ENDPROC
1422: 
1423:     *==========================================================================
1424:     * BtnVoltarClick - cmdTestaPos.btnsair.Click (Pagina Dados) no legado:
1425:     * limpa o RecordSource do grid, reabilita o filtro e volta para a Lista.
1426:     *==========================================================================
1427:     PROCEDURE BtnVoltarClick()
1428:         LOCAL loc_oGrid
1429:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos
1430:         loc_oGrid.RecordSource = ""
1431:         loc_oGrid.Refresh()
1432: 
1433:         THIS.pgf_4c_Paginas.Page1.Enabled = .T.
1434:         THIS.pgf_4c_Paginas.Page2.Enabled = .F.
1435:         THIS.AlternarPagina(1)
1436:     ENDPROC
1437: 
1438:     *==========================================================================
1439:     * BtnMarcarTudoTitulosClick/BtnDesmarcarTudoTitulosClick - Commandgroup2.
1440:     * btnmarca/btndesmarca.Click (Pagina Dados) no legado - marca/desmarca
1441:     * TODOS os titulos, sem excecao pelo EndErro (igual ao legado - o
1442:     * "Marcar Tudo" bypassa o guard do checkbox individual).
1443:     *==========================================================================
1444:     PROCEDURE BtnMarcarTudoTitulosClick()
1445:         IF USED("cursor_4c_Titulos")
1446:             SELECT cursor_4c_Titulos
1447:             REPLACE ALL Marca WITH .T.
1448:             LOCATE
1449:             GO TOP
1450:         ENDIF
1451:         THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
1452:     ENDPROC
1453: 
1454:     PROCEDURE BtnDesmarcarTudoTitulosClick()
1455:         IF USED("cursor_4c_Titulos")
1456:             SELECT cursor_4c_Titulos
1457:             REPLACE ALL Marca WITH .F.
1458:             LOCATE
1459:             GO TOP
1460:         ENDIF
1461:         THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
1462:     ENDPROC
1463: 
1464:     *==========================================================================
1465:     * ChkTituloMarcaClick - Column1.Check1.When no legado (Return
1466:     * crFiltro.EndErro = 0): titulo com endereco muito longo nao pode ser
1467:     * selecionado. O nativo do CheckBox ja alterna Marca no clique; aqui so
1468:     * revertemos quando a linha estiver marcada como EndErro=1.
1469:     *==========================================================================
1470:     PROCEDURE ChkTituloMarcaClick()
1471:         IF USED("cursor_4c_Titulos") AND !EOF("cursor_4c_Titulos")
1472:             IF cursor_4c_Titulos.EndErro = 1 AND cursor_4c_Titulos.Marca
1473:                 REPLACE cursor_4c_Titulos.Marca WITH .F.
1474:                 MsgAviso("Este t" + CHR(237) + "tulo tem endere" + CHR(231) + "o com mais de 40 caracteres e n" + CHR(227) + "o pode ser selecionado.", ;
1475:                          "Aten" + CHR(231) + CHR(227) + "o")
1476:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
1477:             ENDIF
1478:         ENDIF
1479:     ENDPROC
1480: 
1481:     *==========================================================================
1482:     * ExecutarReportForm (Pattern #117) - executa REPORT FORM com guard
1483:     * IF FILE() + isolamento de locale (SET POINT/SEPARATOR) + REPORTBEHAVIOR
1484:     * 80 durante o REPORT FORM. par_cModo: "PREVIEW" | "PRINTER_PROMPT".
1485:     * par_cCursorDados: opcional - se informado e cursor estiver vazio/
1486:     * inexistente, mostra MsgAviso e retorna .F. sem abrir preview vazio.
1487:     *==========================================================================
1488:     PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
1489:         LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
1490: 
1491:         loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")
1492: 
1493:         IF NOT FILE(loc_cFRX)
1494:             MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
1495:                 loc_cFRX + CHR(13) + CHR(13) + ;
1496:                 "O layout deste relat" + CHR(243) + "rio n" + CHR(227) + "o veio no acervo do sistema legado.", "Erro")
1497:             RETURN .F.
1498:         ENDIF
1499: 
1500:         IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
1501:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
1502:                 MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
1503:                     "Aten" + CHR(231) + CHR(227) + "o")
1504:                 RETURN .F.
1505:             ENDIF
1506:         ENDIF
1507: 
1508:         loc_cPointOrig    = SET("POINT")
1509:         loc_cSepOrig      = SET("SEPARATOR")
1510:         loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
1511:         SET POINT TO "."
1512:         SET SEPARATOR TO ","
1513:         SET REPORTBEHAVIOR 80
1514: 
1515:         DO CASE
1516:             CASE par_cModo == "PREVIEW"
1517:                 REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
1518:             CASE par_cModo == "PRINTER_PROMPT"
1519:                 REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
1520:         ENDCASE
1521: 
1522:         SET POINT TO (loc_cPointOrig)
1523:         SET SEPARATOR TO (loc_cSepOrig)
1524:         SET REPORTBEHAVIOR (loc_nBehaviorOrig)
1525: 
1526:         RETURN .T.
1527:     ENDPROC
1528: 
1529:     *==========================================================================
1530:     * BtnGerarCnabClick - Commandgroup1.btncnab.Click no legado ("thisform.
1531:     * geracnab([A])"). Gera o arquivo de remessa bancaria com os titulos
1532:     * marcados. Quando o banco eh Brasil (001), o BO ja dispara a impressao
1533:     * automatica do boleto (regra fiel ao legado - THIS.ImprimirBoleto
1534:     * dentro de GerarCnabBrasil); aqui so falta exibir o preview se o BO
1535:     * deixou um cursor pronto.
1536:     *==========================================================================
1537:     PROCEDURE BtnGerarCnabClick()
1538:         LOCAL loc_oPag, loc_lSucesso
1539: 
1540:         loc_oPag = THIS.pgf_4c_Paginas.Page2
1541: 
1542:         loc_lSucesso = THIS.this_oBusinessObject.GerarArquivoCnab( ;
1543:             "cursor_4c_Titulos", ;
1544:             ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CodEmpresa.Value), ;
1545:             ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CodConta.Value), ;
1546:             ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_TituloBanco.Value))
1547: 
1548:         IF loc_lSucesso AND INLIST(THIS.this_oBusinessObject.this_cBancoConvenio, "001", "033", "353")
1549:             loc_oPag.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(3).Enabled = .T.
1550:         ENDIF
1551: 
1552:         *-- GerarCnabBrasil ja chamou THIS.ImprimirBoleto(.F.) internamente -
1553:         *-- se deixou cursor pronto, exibe o preview aqui (camada de UI).
1554:         IF !EMPTY(THIS.this_oBusinessObject.this_cCursorBoleto)
1555:             THIS.ExibirPreviewBoleto()
1556:         ENDIF
1557:     ENDPROC
1558: 
1559:     *==========================================================================
1560:     * BtnRelatorioCnabClick - Commandgroup1.btnrelatorio.Click no legado
1561:     * ("thisform.geracnab([V])"): preview do relatorio com os titulos
1562:     * marcados (Report Form sigrecnb no legado -> SigReCnb no novo sistema).
1563:     *==========================================================================
1564:     PROCEDURE BtnRelatorioCnabClick()
1565:         LOCAL loc_nMarcados
1566: 
1567:         IF USED("cursor_4c_Titulos")
1568:             SELECT cursor_4c_Titulos
1569:             COUNT FOR Marca TO loc_nMarcados
1570:         ELSE
1571:             loc_nMarcados = 0
1572:         ENDIF
1573: 
1574:         IF loc_nMarcados = 0
1575:             MsgAviso("Nenhum registro foi selecionado", "Aviso")
1576:             RETURN
1577:         ENDIF
1578: 
1579:         THIS.ExecutarReportForm("SigReCnb", "PREVIEW", "cursor_4c_Titulos")
1580:     ENDPROC
1581: 
1582:     *==========================================================================
1583:     * BtnBoletoClick - Commandgroup1.btnBoleto.Click no legado ("thisform.
1584:     * geracnab([I])" + "thisform.impboleto(.T.)"): reimpressao do boleto dos
1585:     * titulos marcados, reaproveitando o Nosso Numero da ultima geracao
1586:     * gravada em SigPcOol (par_lReimpressao = .T.).
1587:     *==========================================================================
1588:     PROCEDURE BtnBoletoClick()
1589:         LOCAL loc_lSucesso
1590: 
1591:         loc_lSucesso = THIS.this_oBusinessObject.ImprimirBoleto( ;
1592:             "cursor_4c_Titulos", .T., ;
1593:             ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CodEmpresa.Value), ;
1594:             ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CodConta.Value))
1595: 
1596:         IF loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cCursorBoleto)
1597:             THIS.ExibirPreviewBoleto()
1598:         ENDIF
1599:     ENDPROC
1600: 
1601:     *==========================================================================
1602:     * ExibirPreviewBoleto - escolhe o layout de boleto pelo banco do
1603:     * convenio (BloquetoBB2/BloquetoSt/BloquetoBra no legado -> SigReBlqBB/
1604:     * SigReBlqSt/SigReBlqBra no novo sistema) e limpa as imagens de barra
1605:     * temporarias apos a impressao (igual ao legado).
1606:     *==========================================================================
1607:     PROTECTED PROCEDURE ExibirPreviewBoleto()
1608:         LOCAL loc_cRelatorio, loc_cCursor
1609: 
1610:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorBoleto
1611: 
1612:         DO CASE
1613:             CASE THIS.this_oBusinessObject.this_cBancoConvenio == "001"
1614:                 loc_cRelatorio = "SigReBlqBB"
1615:             CASE INLIST(THIS.this_oBusinessObject.this_cBancoConvenio, "033", "353")
1616:                 loc_cRelatorio = "SigReBlqSt"
1617:             CASE THIS.this_oBusinessObject.this_cBancoConvenio == "237"
1618:                 loc_cRelatorio = "SigReBlqBra"
1619:             OTHERWISE
1620:                 loc_cRelatorio = ""
1621:         ENDCASE
1622: 
1623:         IF !EMPTY(loc_cRelatorio)
1624:             THIS.ExecutarReportForm(loc_cRelatorio, "PREVIEW", loc_cCursor)
1625:         ENDIF
1626: 
1627:         THIS.this_oBusinessObject.LimparImagensBarras(loc_cCursor)
1628: 
1629:         IF USED(loc_cCursor)
1630:             USE IN (loc_cCursor)
1631:         ENDIF
1632:         THIS.this_oBusinessObject.this_cCursorBoleto = ""
1633:     ENDPROC
1634: 
1635:     *==========================================================================
1636:     * ValidarCodEmpresa - KeyPress em txt_4c_CodEmpresa (get_cd_empresa no
1637:     * legado). Enter/Tab/F4 -> SELECT exato em SigCdEmp.Cemps; hit preenche a
1638:     * razao social, miss abre o picker (fAcessoEmpresa modo 'C' nao portada -
1639:     * regra CLAUDE.md sobre fAcessoEmpresa, substituicao canonica FormBuscaAuxiliar
1640:     * em SigCdEmp).
1641:     *==========================================================================
1642:     PROCEDURE ValidarCodEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1643:         LOCAL loc_oPag, loc_cVal, loc_nResult
1644: 
1645:         IF par_nKeyCode = 115
1646:             THIS.AbrirBuscaEmpresa()
1647:             RETURN
1648:         ENDIF
1649: 
1650:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1651:             RETURN
1652:         ENDIF
1653: 
1654:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1655:         loc_cVal = ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value)
1656: 
1657:         IF EMPTY(loc_cVal)
1658:             loc_oPag.txt_4c_NomeEmpresa.Value = ""
1659:             loc_oPag.txt_4c_NomeEmpresa.Refresh
1660:             RETURN
1661:         ENDIF
1662: 
1663:         TRY
1664:             loc_nResult = SQLEXEC(gnConnHandle, ;
1665:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
1666:                 "cursor_4c_EmpresaVal")
1667:             IF loc_nResult > 0 AND USED("cursor_4c_EmpresaVal") AND !EOF("cursor_4c_EmpresaVal")
1668:                 SELECT cursor_4c_EmpresaVal
1669:                 loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_EmpresaVal.Cemps)
1670:                 loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Razas)
1671:             ELSE
1672:                 THIS.AbrirBuscaEmpresa()
1673:             ENDIF
1674:             IF USED("cursor_4c_EmpresaVal")
1675:                 USE IN cursor_4c_EmpresaVal
1676:             ENDIF
1677:         CATCH TO loc_oErro
1678:             MsgErro(loc_oErro.Message, "Erro")
1679:         ENDTRY
1680: 
1681:         loc_oPag.txt_4c_CodEmpresa.Refresh
1682:         loc_oPag.txt_4c_NomeEmpresa.Refresh
1683:     ENDPROC
1684: 
1685:     *==========================================================================
1686:     * ValidarNomEmpresa - KeyPress em txt_4c_NomeEmpresa (get_ds_empresa no
1687:     * legado). So age quando o codigo esta vazio (When: Empty(get_cd_empresa)).
1688:     *==========================================================================
1689:     PROCEDURE ValidarNomEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1690:         LOCAL loc_oPag, loc_cVal, loc_nResult
1691: 
1692:         IF par_nKeyCode = 115
1693:             THIS.AbrirBuscaEmpresa()
1694:             RETURN
1695:         ENDIF
1696: 
1697:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1698:             RETURN
1699:         ENDIF
1700: 
1701:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1702: 
1703:         IF !EMPTY(ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value))
1704:             RETURN
1705:         ENDIF
1706: 
1707:         loc_cVal = ALLTRIM(loc_oPag.txt_4c_NomeEmpresa.Value)
1708:         IF EMPTY(loc_cVal)
1709:             loc_oPag.txt_4c_CodEmpresa.Value = ""
1710:             loc_oPag.txt_4c_CodEmpresa.Refresh
1711:             RETURN
1712:         ENDIF
1713: 
1714:         TRY
1715:             loc_nResult = SQLEXEC(gnConnHandle, ;
1716:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE RTRIM(Razas) = " + EscaparSQL(loc_cVal), ;
1717:                 "cursor_4c_EmpresaVal")
1718:             IF loc_nResult > 0 AND USED("cursor_4c_EmpresaVal") AND !EOF("cursor_4c_EmpresaVal")
1719:                 SELECT cursor_4c_EmpresaVal
1720:                 loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_EmpresaVal.Cemps)
1721:                 loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Razas)
1722:             ELSE
1723:                 THIS.AbrirBuscaEmpresa()
1724:             ENDIF
1725:             IF USED("cursor_4c_EmpresaVal")
1726:                 USE IN cursor_4c_EmpresaVal
1727:             ENDIF
1728:         CATCH TO loc_oErro
1729:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 1737 a 1926:
1737:     * AbrirBuscaEmpresa - picker por Cemps/Razas em SigCdEmp (substitui
1738:     * fAcessoEmpresa modo lookup - funcao NAO portada, ver CLAUDE.md).
1739:     *==========================================================================
1740:     PROCEDURE AbrirBuscaEmpresa()
1741:         LOCAL loc_oPag, loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir
1742: 
1743:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
1744:         loc_cValor  = ALLTRIM(loc_oPag.txt_4c_CodEmpresa.Value)
1745:         IF EMPTY(loc_cValor)
1746:             loc_cValor = ALLTRIM(loc_oPag.txt_4c_NomeEmpresa.Value)
1747:         ENDIF
1748:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa"
1749: 
1750:         IF USED("cursor_4c_BuscaEmpresa")
1751:             USE IN cursor_4c_BuscaEmpresa
1752:         ENDIF
1753: 
1754:         loc_lProsseguir = .T.
1755:         TRY
1756:             IF EMPTY(loc_cValor)
1757:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
1758:             ELSE
1759:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
1760:                            "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
1761:                            " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
1762:                            " ORDER BY Cemps"
1763:             ENDIF
1764:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpresa")
1765: 
1766:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpresa") OR RECCOUNT("cursor_4c_BuscaEmpresa") = 0) ;
1767:                     AND !EMPTY(loc_cValor)
1768:                 IF USED("cursor_4c_BuscaEmpresa")
1769:                     USE IN cursor_4c_BuscaEmpresa
1770:                 ENDIF
1771:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1772:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
1773:                     "cursor_4c_BuscaEmpresa")
1774:             ENDIF
1775: 
1776:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpresa") OR RECCOUNT("cursor_4c_BuscaEmpresa") = 0
1777:                 MsgAviso("Nenhuma empresa encontrada.", "Empresa")
1778:                 loc_lProsseguir = .F.
1779:             ENDIF
1780: 
1781:             IF loc_lProsseguir
1782:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1783:                 IF VARTYPE(loc_oBusca) = "O"
1784:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpresa"
1785:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1786:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1787:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1788:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1789:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1790:                     loc_oBusca.Show()
1791:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
1792:                         SELECT cursor_4c_BuscaEmpresa
1793:                         loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
1794:                         loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
1795:                     ENDIF
1796:                     loc_oBusca.Release()
1797:                 ENDIF
1798:             ENDIF
1799:         CATCH TO loc_oErro
1800:             MsgErro(loc_oErro.Message, "Erro")
1801:         ENDTRY
1802: 
1803:         IF USED("cursor_4c_BuscaEmpresa")
1804:             USE IN cursor_4c_BuscaEmpresa
1805:         ENDIF
1806:         loc_oPag.txt_4c_CodEmpresa.Refresh
1807:         loc_oPag.txt_4c_NomeEmpresa.Refresh
1808:     ENDPROC
1809: 
1810:     *==========================================================================
1811:     * ValidarDataFinal - KeyPress em txt_4c_DataFinal (Get_Dataf.Valid no
1812:     * legado): data final nao pode ser menor que a inicial.
1813:     *==========================================================================
1814:     PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)
1815:         LOCAL loc_oPag
1816: 
1817:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1818:             RETURN
1819:         ENDIF
1820: 
1821:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1822: 
1823:         IF !EMPTY(loc_oPag.txt_4c_DataInicial.Value) ;
1824:                 AND !EMPTY(loc_oPag.txt_4c_DataFinal.Value) ;
1825:                 AND loc_oPag.txt_4c_DataFinal.Value < loc_oPag.txt_4c_DataInicial.Value
1826:             MsgAviso("Data Final Deve Ser Maior Que a Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
1827:             loc_oPag.txt_4c_DataFinal.SetFocus()
1828:         ENDIF
1829:     ENDPROC
1830: 
1831:     *==========================================================================
1832:     * ValidarCodConta - KeyPress em txt_4c_CodConta (get_cd_car_conta no
1833:     * legado). Enter/Tab/F4 -> SELECT exato em SigCdCli.IClis; hit preenche a
1834:     * razao social, miss abre o picker (fAcessoContas NAO USAR para lookup UX -
1835:     * regra CLAUDE.md, substituicao canonica SigCdCli.IClis/RClis).
1836:     *==========================================================================
1837:     PROCEDURE ValidarCodConta(par_nKeyCode, par_nShiftAltCtrl)
1838:         LOCAL loc_oPag, loc_cVal, loc_nResult
1839: 
1840:         IF par_nKeyCode = 115
1841:             THIS.AbrirBuscaConta()
1842:             RETURN
1843:         ENDIF
1844: 
1845:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1846:             RETURN
1847:         ENDIF
1848: 
1849:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1850:         loc_cVal = ALLTRIM(loc_oPag.txt_4c_CodConta.Value)
1851: 
1852:         IF EMPTY(loc_cVal)
1853:             loc_oPag.txt_4c_NomeConta.Value = ""
1854:             loc_oPag.txt_4c_NomeConta.Refresh
1855:             RETURN
1856:         ENDIF
1857: 
1858:         TRY
1859:             loc_nResult = SQLEXEC(gnConnHandle, ;
1860:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cVal), ;
1861:                 "cursor_4c_ContaVal")
1862:             IF loc_nResult > 0 AND USED("cursor_4c_ContaVal") AND !EOF("cursor_4c_ContaVal")
1863:                 SELECT cursor_4c_ContaVal
1864:                 loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_ContaVal.IClis)
1865:                 loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_ContaVal.RClis)
1866:             ELSE
1867:                 MsgAviso("Conta Inv" + CHR(225) + "lida, Acesso Negado.", "Aviso")
1868:                 loc_oPag.txt_4c_CodConta.Value  = ""
1869:                 loc_oPag.txt_4c_NomeConta.Value = ""
1870:             ENDIF
1871:             IF USED("cursor_4c_ContaVal")
1872:                 USE IN cursor_4c_ContaVal
1873:             ENDIF
1874:         CATCH TO loc_oErro
1875:             MsgErro(loc_oErro.Message, "Erro")
1876:         ENDTRY
1877: 
1878:         loc_oPag.txt_4c_CodConta.Refresh
1879:         loc_oPag.txt_4c_NomeConta.Refresh
1880:     ENDPROC
1881: 
1882:     *==========================================================================
1883:     * ValidarNomConta - KeyPress em txt_4c_NomeConta (get_ds_car_conta no
1884:     * legado). So age quando o codigo esta vazio (When: IsEmpty(get_cd_car_conta)).
1885:     *==========================================================================
1886:     PROCEDURE ValidarNomConta(par_nKeyCode, par_nShiftAltCtrl)
1887:         LOCAL loc_oPag, loc_cVal, loc_nResult
1888: 
1889:         IF par_nKeyCode = 115
1890:             THIS.AbrirBuscaConta()
1891:             RETURN
1892:         ENDIF
1893: 
1894:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1895:             RETURN
1896:         ENDIF
1897: 
1898:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1899: 
1900:         IF !EMPTY(ALLTRIM(loc_oPag.txt_4c_CodConta.Value))
1901:             RETURN
1902:         ENDIF
1903: 
1904:         loc_cVal = ALLTRIM(loc_oPag.txt_4c_NomeConta.Value)
1905:         IF EMPTY(loc_cVal)
1906:             loc_oPag.txt_4c_CodConta.Value = ""
1907:             loc_oPag.txt_4c_CodConta.Refresh
1908:             RETURN
1909:         ENDIF
1910: 
1911:         TRY
1912:             loc_nResult = SQLEXEC(gnConnHandle, ;
1913:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) = " + EscaparSQL(loc_cVal), ;
1914:                 "cursor_4c_ContaVal")
1915:             IF loc_nResult > 0 AND USED("cursor_4c_ContaVal") AND !EOF("cursor_4c_ContaVal")
1916:                 SELECT cursor_4c_ContaVal
1917:                 loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_ContaVal.IClis)
1918:                 loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_ContaVal.RClis)
1919:             ELSE
1920:                 THIS.AbrirBuscaConta()
1921:             ENDIF
1922:             IF USED("cursor_4c_ContaVal")
1923:                 USE IN cursor_4c_ContaVal
1924:             ENDIF
1925:         CATCH TO loc_oErro
1926:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 1934 a 2176:
1934:     * AbrirBuscaConta - picker por IClis/RClis em SigCdCli (conta/carteira do
1935:     * banco - substitui fAcessoContas, que NAO deve ser usada para lookup UX).
1936:     *==========================================================================
1937:     PROCEDURE AbrirBuscaConta()
1938:         LOCAL loc_oPag, loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir
1939: 
1940:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
1941:         loc_cValor  = ALLTRIM(loc_oPag.txt_4c_CodConta.Value)
1942:         IF EMPTY(loc_cValor)
1943:             loc_cValor = ALLTRIM(loc_oPag.txt_4c_NomeConta.Value)
1944:         ENDIF
1945:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Conta"
1946: 
1947:         IF USED("cursor_4c_BuscaConta")
1948:             USE IN cursor_4c_BuscaConta
1949:         ENDIF
1950: 
1951:         loc_lProsseguir = .T.
1952:         TRY
1953:             IF EMPTY(loc_cValor)
1954:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis"
1955:             ELSE
1956:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
1957:                            "WHERE IClis LIKE " + EscaparSQL(loc_cValor + "%") + ;
1958:                            " OR RTRIM(RClis) LIKE " + EscaparSQL(loc_cValor + "%") + ;
1959:                            " ORDER BY IClis"
1960:             ENDIF
1961:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
1962: 
1963:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaConta") OR RECCOUNT("cursor_4c_BuscaConta") = 0) ;
1964:                     AND !EMPTY(loc_cValor)
1965:                 IF USED("cursor_4c_BuscaConta")
1966:                     USE IN cursor_4c_BuscaConta
1967:                 ENDIF
1968:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1969:                     "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis", ;
1970:                     "cursor_4c_BuscaConta")
1971:             ENDIF
1972: 
1973:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaConta") OR RECCOUNT("cursor_4c_BuscaConta") = 0
1974:                 MsgAviso("Nenhuma conta encontrada.", "Conta")
1975:                 loc_lProsseguir = .F.
1976:             ENDIF
1977: 
1978:             IF loc_lProsseguir
1979:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1980:                 IF VARTYPE(loc_oBusca) = "O"
1981:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
1982:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1983:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1984:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1985:                     loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1986:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1987:                     loc_oBusca.Show()
1988:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1989:                         SELECT cursor_4c_BuscaConta
1990:                         loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1991:                         loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1992:                     ENDIF
1993:                     loc_oBusca.Release()
1994:                 ENDIF
1995:             ENDIF
1996:         CATCH TO loc_oErro
1997:             MsgErro(loc_oErro.Message, "Erro")
1998:         ENDTRY
1999: 
2000:         IF USED("cursor_4c_BuscaConta")
2001:             USE IN cursor_4c_BuscaConta
2002:         ENDIF
2003:         loc_oPag.txt_4c_CodConta.Refresh
2004:         loc_oPag.txt_4c_NomeConta.Refresh
2005:     ENDPROC
2006: 
2007:     *==========================================================================
2008:     * ValidarTituloBanco - KeyPress em txt_4c_TituloBanco (Get_titban no
2009:     * legado). Enter/Tab/F4 -> SEEK exato em SigOpFp.Fpags (mesmo filtro do
2010:     * legado: Situas in ('R','A') And Infos = 'K'); miss abre o picker
2011:     * (fwBuscaSel legado -> FormBuscaAuxiliar canonico, tabela single-column
2012:     * como SigCdOpe - so existe o campo Fpags, sem descricao textual).
2013:     *==========================================================================
2014:     PROCEDURE ValidarTituloBanco(par_nKeyCode, par_nShiftAltCtrl)
2015:         LOCAL loc_oPag, loc_cVal, loc_nResult
2016: 
2017:         IF par_nKeyCode = 115
2018:             THIS.AbrirBuscaTituloBanco()
2019:             RETURN
2020:         ENDIF
2021: 
2022:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
2023:             RETURN
2024:         ENDIF
2025: 
2026:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2027:         loc_cVal = ALLTRIM(loc_oPag.txt_4c_TituloBanco.Value)
2028: 
2029:         IF EMPTY(loc_cVal)
2030:             RETURN
2031:         ENDIF
2032: 
2033:         TRY
2034:             loc_nResult = SQLEXEC(gnConnHandle, ;
2035:                 "SELECT TOP 1 Fpags FROM SigOpFp WHERE Fpags = " + EscaparSQL(loc_cVal) + ;
2036:                 " AND Situas IN ('R','A') AND Infos = 'K'", ;
2037:                 "cursor_4c_TituloBancoVal")
2038:             IF loc_nResult > 0 AND USED("cursor_4c_TituloBancoVal") AND !EOF("cursor_4c_TituloBancoVal")
2039:                 SELECT cursor_4c_TituloBancoVal
2040:                 loc_oPag.txt_4c_TituloBanco.Value = ALLTRIM(cursor_4c_TituloBancoVal.Fpags)
2041:             ELSE
2042:                 THIS.AbrirBuscaTituloBanco()
2043:             ENDIF
2044:             IF USED("cursor_4c_TituloBancoVal")
2045:                 USE IN cursor_4c_TituloBancoVal
2046:             ENDIF
2047:         CATCH TO loc_oErro
2048:             MsgErro(loc_oErro.Message, "Erro")
2049:         ENDTRY
2050: 
2051:         loc_oPag.txt_4c_TituloBanco.Refresh
2052:     ENDPROC
2053: 
2054:     *==========================================================================
2055:     * AbrirBuscaTituloBanco - picker por Fpags em SigOpFp (Formas de
2056:     * Pagamento), mesmo filtro do legado (Situas in ('R','A') And Infos='K').
2057:     * Single-column, igual SigCdOpe (regra CLAUDE.md) - o legado so exibe o
2058:     * codigo (AddColuna('FPags', ...)), sem coluna de descricao.
2059:     *==========================================================================
2060:     PROCEDURE AbrirBuscaTituloBanco()
2061:         LOCAL loc_oPag, loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, loc_lProsseguir
2062: 
2063:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
2064:         loc_cValor  = ALLTRIM(loc_oPag.txt_4c_TituloBanco.Value)
2065:         loc_cTitulo = "Formas de Pagamento"
2066: 
2067:         IF USED("cursor_4c_BuscaTituloBanco")
2068:             USE IN cursor_4c_BuscaTituloBanco
2069:         ENDIF
2070: 
2071:         loc_lProsseguir = .T.
2072:         TRY
2073:             IF EMPTY(loc_cValor)
2074:                 loc_cSQL = "SELECT Fpags FROM SigOpFp WHERE Situas IN ('R','A') AND Infos = 'K' ORDER BY Fpags"
2075:             ELSE
2076:                 loc_cSQL = "SELECT Fpags FROM SigOpFp " + ;
2077:                            "WHERE Situas IN ('R','A') AND Infos = 'K' " + ;
2078:                            "AND Fpags LIKE " + EscaparSQL(loc_cValor + "%") + ;
2079:                            " ORDER BY Fpags"
2080:             ENDIF
2081:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTituloBanco")
2082: 
2083:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaTituloBanco") OR RECCOUNT("cursor_4c_BuscaTituloBanco") = 0) ;
2084:                     AND !EMPTY(loc_cValor)
2085:                 IF USED("cursor_4c_BuscaTituloBanco")
2086:                     USE IN cursor_4c_BuscaTituloBanco
2087:                 ENDIF
2088:                 loc_nResult = SQLEXEC(gnConnHandle, ;
2089:                     "SELECT Fpags FROM SigOpFp WHERE Situas IN ('R','A') AND Infos = 'K' ORDER BY Fpags", ;
2090:                     "cursor_4c_BuscaTituloBanco")
2091:             ENDIF
2092: 
2093:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaTituloBanco") OR RECCOUNT("cursor_4c_BuscaTituloBanco") = 0
2094:                 MsgAviso("Nenhuma forma de pagamento encontrada.", "Formas de Pagamento")
2095:                 loc_lProsseguir = .F.
2096:             ENDIF
2097: 
2098:             IF loc_lProsseguir
2099:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2100:                 IF VARTYPE(loc_oBusca) = "O"
2101:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTituloBanco"
2102:                     loc_oBusca.this_cTitulo        = loc_cTitulo
2103:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
2104:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
2105:                     loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
2106:                     loc_oBusca.Show()
2107:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTituloBanco")
2108:                         SELECT cursor_4c_BuscaTituloBanco
2109:                         loc_oPag.txt_4c_TituloBanco.Value = ALLTRIM(cursor_4c_BuscaTituloBanco.Fpags)
2110:                     ENDIF
2111:                     loc_oBusca.Release()
2112:                 ENDIF
2113:             ENDIF
2114:         CATCH TO loc_oErro
2115:             MsgErro(loc_oErro.Message, "Erro")
2116:         ENDTRY
2117: 
2118:         IF USED("cursor_4c_BuscaTituloBanco")
2119:             USE IN cursor_4c_BuscaTituloBanco
2120:         ENDIF
2121:         loc_oPag.txt_4c_TituloBanco.Refresh
2122:     ENDPROC
2123: 
2124:     *==========================================================================
2125:     * AlternarPagina - Alterna entre a pagina de Filtro (1) e a de Dados (2).
2126:     * Usado pelo fluxo Processar->Dados e pelo retorno Dados->Filtro (regra de
2127:     * negocio de quando alternar fica para as Fases 7-8).
2128:     *==========================================================================
2129:     PROCEDURE AlternarPagina(par_nPagina)
2130:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2131:     ENDPROC
2132: 
2133:     *==========================================================================
2134:     * TornarControlesVisiveis - Torna visiveis os controles ja criados
2135:     *==========================================================================
2136:     PROTECTED PROCEDURE TornarControlesVisiveis()
2137:         LOCAL loc_oP1, loc_oP2
2138: 
2139:         THIS.pgf_4c_Paginas.Visible = .T.
2140: 
2141:         loc_oP1 = THIS.pgf_4c_Paginas.Page1
2142:         loc_oP1.cnt_4c_Cabecalho.Visible                       = .T.
2143:         loc_oP1.cnt_4c_Cabecalho.lbl_4c_Sombra.Visible         = .T.
2144:         loc_oP1.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible         = .T.
2145:         loc_oP1.cnt_4c_Botoes.Visible                          = .T.
2146:         loc_oP1.cnt_4c_Botoes.cmd_4c_Processar.Visible         = .T.
2147:         loc_oP1.cnt_4c_Botoes.cmd_4c_Encerrar.Visible          = .T.
2148:         loc_oP1.cnt_4c_Marca.Visible                           = .T.
2149:         loc_oP1.cnt_4c_Marca.cmd_4c_MarcarTudo.Visible         = .T.
2150:         loc_oP1.cnt_4c_Marca.cmd_4c_DesmarcarTudo.Visible      = .T.
2151:         loc_oP1.lbl_4c_Operacoes.Visible                       = .T.
2152:         loc_oP1.obj_4c_Processados.Visible                     = .T.
2153:         loc_oP1.lbl_4c_Empresa.Visible                         = .T.
2154:         loc_oP1.txt_4c_CodEmpresa.Visible                      = .T.
2155:         loc_oP1.txt_4c_NomeEmpresa.Visible                     = .T.
2156:         loc_oP1.lbl_4c_Periodo.Visible                         = .T.
2157:         loc_oP1.txt_4c_DataInicial.Visible                     = .T.
2158:         loc_oP1.lbl_4c_Ate.Visible                             = .T.
2159:         loc_oP1.txt_4c_DataFinal.Visible                       = .T.
2160:         loc_oP1.obj_4c_Periodo.Visible                         = .T.
2161:         loc_oP1.lbl_4c_Banco.Visible                           = .T.
2162:         loc_oP1.txt_4c_CodConta.Visible                        = .T.
2163:         loc_oP1.txt_4c_NomeConta.Visible                       = .T.
2164:         loc_oP1.lbl_4c_TituloBanco.Visible                     = .T.
2165:         loc_oP1.txt_4c_TituloBanco.Visible                     = .T.
2166:         loc_oP1.lbl_4c_Operacao.Visible                        = .T.
2167:         loc_oP1.grd_4c_Operacoes.Visible                       = .T.
2168: 
2169:         loc_oP2 = THIS.pgf_4c_Paginas.Page2
2170:         loc_oP2.cnt_4c_Cabecalho.Visible                       = .T.
2171:         loc_oP2.cnt_4c_Cabecalho.lbl_4c_Sombra.Visible         = .T.
2172:         loc_oP2.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible         = .T.
2173:         loc_oP2.cnt_4c_BotoesAcao.Visible                      = .T.
2174:         loc_oP2.cnt_4c_BotoesAcao.cmd_4c_Encerrar.Visible      = .T.
2175:         loc_oP2.cnt_4c_BotoesAcao.obj_4c_Comandos.Visible      = .T.
2176:         loc_oP2.lbl_4c_Label12.Visible                         = .T.

*-- Linhas 2187 a 2194:
2187:     *==========================================================================
2188:     * DESTROY - delega para FormBase.Destroy (restaura menu apos fechamento)
2189:     *==========================================================================
2190:     PROCEDURE Destroy()
2191:         RETURN DODEFAULT()
2192:     ENDPROC
2193: 
2194: ENDDEFINE

