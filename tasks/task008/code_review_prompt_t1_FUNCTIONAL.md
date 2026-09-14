# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (42)
- [CARGA-DADOS] Metodo ValidarGrupoFiltro faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarCgruDados faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarCSGruDados faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarLinDados faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarColDados faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarIforDados faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarCodFinPDados faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarCodAcbDados faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarClassDados faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarCuniDados faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarCunipDados faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarFtio faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarCmkpc faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] OptionGroup 'opt_4c_Situacao' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_SituacaoCopia' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_SituacaoPro' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_ProdWeb' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_OpcVar' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Lista' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_SubCp' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrupoCompo' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrupoCompo2' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_DTemp' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Mtz' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-HEADER] Header Caption 'Bloqueio' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Descrição, Grupo, Subgrp., Ref. Fornecedor, Usuário, I, Empresa, Quantidade, Material, Un, Valor, Qtde., Total, Moe, Observação, E, Consumo, Ord, Moeda, Tam, Período, Valor Custo GR, Ordem, Fase, Utilização, Uni. Produtiva, Matriz, Local, Qtde, Componente, Uni, Ord., Cat., Agrupamento, Tempo %, Item, Qtd, Etiq, Grp, Data de Início, Data de Conclusão, Tarefa, Arquivos Para Designer. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Bloqueio' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Descrição, Grupo, Subgrp., Ref. Fornecedor, Usuário, I, Empresa, Quantidade, Material, Un, Valor, Qtde., Total, Moe, Observação, E, Consumo, Ord, Moeda, Tam, Período, Valor Custo GR, Ordem, Fase, Utilização, Uni. Produtiva, Matriz, Local, Qtde, Componente, Uni, Ord., Cat., Agrupamento, Tempo %, Item, Qtd, Etiq, Grp, Data de Início, Data de Conclusão, Tarefa, Arquivos Para Designer. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [SQL-AVISO] 60 alertas SQL-COLUNA para tabela desconhecida suprimidos (provavel falso positivo por reuso de alias em queries complexas)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDPRO.Pagina.Lista.cntMensagem): Top original=32 vs migrado 'lbl_4c_Label1' Top=245 (diff=213px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblGrupo' (parent: SIGCDPRO.Pagina.Lista.cntFiltros): Top original=18 vs migrado 'lbl_4c_LblGrupoCus' Top=444 (diff=426px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblGrupo' (parent: SIGCDPRO.Pagina.Lista.cntFiltros): Left original=21 vs migrado 'lbl_4c_LblGrupoCus' Left=479 (diff=458px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Top original=5 vs migrado 'lbl_4c_Label8' Top=320 (diff=315px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Left original=8 vs migrado 'lbl_4c_Label8' Left=250 (diff=242px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=134 vs migrado 'lbl_4c_Label2' Top=270 (diff=136px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=451 vs migrado 'lbl_4c_Label10' Top=512 (diff=61px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=967 vs migrado 'lbl_4c_Label10' Left=147 (diff=820px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=451 vs migrado 'lbl_4c_Label9' Top=349 (diff=102px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=884 vs migrado 'lbl_4c_Label9' Left=756 (diff=128px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblAcabamento' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=350 vs migrado 'lbl_4c_LblAcabamento' Top=385 (diff=35px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=172 vs migrado 'chk_4c_Fwoption1' Top=360 (diff=188px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=879 vs migrado 'chk_4c_Fwoption1' Left=180 (diff=699px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblVenda' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=581 vs migrado 'lbl_4c_LblVendaSep' Top=503 (diff=78px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblVenda' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=416 vs migrado 'lbl_4c_LblVendaSep' Left=361 (diff=55px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (12515 linhas total):

*-- Linhas 35 a 155:
35:     this_nAntOrd         = 0  && Salva ordem anterior para reordenamento em GradFase
36: 
37:     *--------------------------------------------------------------------------
38:     PROCEDURE Init()
39:         RETURN DODEFAULT()
40:     ENDPROC
41: 
42:     *--------------------------------------------------------------------------
43:     PROTECTED PROCEDURE InicializarForm()
44:         LOCAL loc_lSucesso, loc_lContinuar
45:         loc_lSucesso   = .F.
46:         loc_lContinuar = .T.
47:         TRY
48:             IF !gb_4c_ValidandoUI
49:                 IF gnConnHandle <= 0
50:                     MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
51:                     loc_lContinuar = .F.
52:                 ENDIF
53:             ENDIF
54: 
55:             IF loc_lContinuar
56:                 this_oBusinessObject = CREATEOBJECT("ProdutoBO")
57:                 IF VARTYPE(this_oBusinessObject) # "O"
58:                     MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio.", "Erro")
59:                     loc_lContinuar = .F.
60:                 ENDIF
61:             ENDIF
62: 
63:             IF loc_lContinuar
64:                 THIS.ConfigurarPageFrame()
65:                 THIS.ConfigurarEventos()
66:                 THIS.TornarControlesVisiveis(THIS)
67:                 IF !gb_4c_ValidandoUI
68:                     THIS.CarregarLista()
69:                 ENDIF
70:                 loc_lSucesso = .T.
71:             ENDIF
72:         CATCH TO loc_oErro
73:             MsgErro(loc_oErro.Message, "Erro ao inicializar")
74:         ENDTRY
75:         RETURN loc_lSucesso
76:     ENDPROC
77: 
78:     *--------------------------------------------------------------------------
79:     PROTECTED PROCEDURE ConfigurarPageFrame()
80:         LOCAL loc_oPgf, loc_oPage1, loc_oPage2
81:         TRY
82:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
83:             loc_oPgf = THIS.pgf_4c_Paginas
84:             WITH loc_oPgf
85:                 .Top       = -29
86:                 .Left      = 0
87:                 .Width     = 1000
88:                 .Height    = 629
89:                 .PageCount = 2
90:                 .Tabs      = .F.
91:                 .Themes    = .F.
92:                 .Visible   = .T.
93:             ENDWITH
94: 
95:             loc_oPage1 = loc_oPgf.Page1
96:             WITH loc_oPage1
97:                 .Caption   = "Lista"
98:                 .BackColor = RGB(53,53,53)
99:             ENDWITH
100:             THIS.ConfigurarPage1(loc_oPage1)
101: 
102:             loc_oPage2 = loc_oPgf.Page2
103:             WITH loc_oPage2
104:                 .Caption   = "Dados"
105:                 .BackColor = RGB(53,53,53)
106:             ENDWITH
107:             THIS.ConfigurarPage2(loc_oPage2)
108: 
109:         CATCH TO loc_oErro
110:             MsgErro(loc_oErro.Message, "Erro ao configurar PageFrame")
111:         ENDTRY
112:     ENDPROC
113: 
114:     *--------------------------------------------------------------------------
115:     PROTECTED PROCEDURE ConfigurarPage1(par_oPage)
116:         LOCAL loc_oContainer
117:         TRY
118:             *-- Cabecalho (cntSombra no legado) - Top = 2+29 = 31
119:             par_oPage.AddObject("cnt_4c_Cabecalho", "Container")
120:             WITH par_oPage.cnt_4c_Cabecalho
121:                 .Top         = 31
122:                 .Left        = 0
123:                 .Width       = 800
124:                 .Height      = 80
125:                 .BackStyle   = 1
126:                 .BackColor   = RGB(53,53,53)
127:                 .BorderWidth = 0
128:                 .Visible     = .T.
129:             ENDWITH
130: 
131:             par_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
132:             WITH par_oPage.cnt_4c_Cabecalho.lbl_4c_Sombra
133:                 .Top       = 15
134:                 .Left      = 10
135:                 .Width     = 769
136:                 .Height    = 40
137:                 .FontName  = "Tahoma"
138:                 .FontSize  = 16
139:                 .FontBold  = .T.
140:                 .ForeColor = RGB(0,0,0)
141:                 .BackStyle = 0
142:                 .Caption   = "Cadastro de Produtos"
143:                 .Visible   = .T.
144:             ENDWITH
145: 
146:             par_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
147:             WITH par_oPage.cnt_4c_Cabecalho.lbl_4c_Titulo
148:                 .Top       = 18
149:                 .Left      = 10
150:                 .Width     = 769
151:                 .Height    = 46
152:                 .FontName  = "Tahoma"
153:                 .FontSize  = 16
154:                 .FontBold  = .T.
155:                 .ForeColor = RGB(255,255,255)

*-- Linhas 326 a 349:
326:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
327:                 .Visible         = .T.
328:             ENDWITH
329: 
330:             *-- Cursor placeholder para grid (ANTES de criar o grid)
331:             IF USED("cursor_4c_Lista")
332:                 USE IN cursor_4c_Lista
333:             ENDIF
334:             CREATE CURSOR cursor_4c_Lista (;
335:                 CPros    C(14),  ;
336:                 DPros    C(40),  ;
337:                 DPro2s   C(30),  ;
338:                 CGrus    C(10),  ;
339:                 DGrus    C(30),  ;
340:                 SGrus    C(10),  ;
341:                 Reffs    C(30),  ;
342:                 UsuaAlts C(15),  ;
343:                 Instalas N(1,0)  ;
344:             )
345: 
346:             *-- Container de filtros (cntFiltros no legado) - Top = 82+29 = 111
347:             par_oPage.AddObject("cnt_4c_Filtros", "Container")
348:             WITH par_oPage.cnt_4c_Filtros
349:                 .Top         = 111

*-- Linhas 454 a 509:
454:                 .Themes    = .F.
455:                 .Visible   = .T.
456:             ENDWITH
457: 
458:             *-- OptionGroup situacao (optFilSituas no legado: 3 botoes Todos/Ativos/Inativos)
459:             par_oPage.cnt_4c_Filtros.AddObject("opt_4c_Situacao", "OptionGroup")
460:             WITH par_oPage.cnt_4c_Filtros.opt_4c_Situacao
461:                 .Top         = 5
462:                 .Left        = 315
463:                 .Width       = 75
464:                 .Height      = 58
465:                 .ButtonCount = 3
466:                 .Value       = 1
467:                 .Themes      = .F.
468:                 .Visible     = .T.
469:             ENDWITH
470: 
471:             WITH par_oPage.cnt_4c_Filtros.opt_4c_Situacao.Buttons(1)
472:                 .Caption   = "Todos"
473:                 .Top       = 0
474:                 .Left      = 0
475:                 .Width     = 65
476:                 .Height    = 17
477:                 .FontName  = "Tahoma"
478:                 .FontSize  = 8
479:                 .Themes    = .F.
480:                 .Value     = 1
481:             ENDWITH
482: 
483:             WITH par_oPage.cnt_4c_Filtros.opt_4c_Situacao.Buttons(2)
484:                 .Caption   = "Ativos"
485:                 .Top       = 19
486:                 .Left      = 0
487:                 .Width     = 65
488:                 .Height    = 17
489:                 .FontName  = "Tahoma"
490:                 .FontSize  = 8
491:                 .Themes    = .F.
492:             ENDWITH
493: 
494:             WITH par_oPage.cnt_4c_Filtros.opt_4c_Situacao.Buttons(3)
495:                 .Caption   = "Inativos"
496:                 .Top       = 38
497:                 .Left      = 0
498:                 .Width     = 65
499:                 .Height    = 17
500:                 .FontName  = "Tahoma"
501:                 .FontSize  = 8
502:                 .Themes    = .F.
503:             ENDWITH
504: 
505:             *-- Container de mensagem "Aguarde" (cntMensagem no legado - Visible=.F.)
506:             par_oPage.AddObject("cnt_4c_Mensagem", "Container")
507:             WITH par_oPage.cnt_4c_Mensagem
508:                 .Top         = 255 + 29
509:                 .Left        = 254

*-- Linhas 741 a 786:
741:                 .FontSize = 8
742:                 .Themes   = .F.
743:                 .Visible  = .T.
744:             ENDWITH
745: 
746:             par_oPage.cnt_4c_Acabado.AddObject("opt_4c_SituacaoCopia", "OptionGroup")
747:             WITH par_oPage.cnt_4c_Acabado.opt_4c_SituacaoCopia
748:                 .Top         = 83
749:                 .Left        = 102
750:                 .Width       = 129
751:                 .Height      = 17
752:                 .ButtonCount = 2
753:                 .Value       = 1
754:                 .Themes      = .F.
755:                 .Visible     = .T.
756:             ENDWITH
757: 
758:             WITH par_oPage.cnt_4c_Acabado.opt_4c_SituacaoCopia.Buttons(1)
759:                 .Caption  = "Ativo"
760:                 .Top      = 0
761:                 .Left     = 0
762:                 .Width    = 55
763:                 .Height   = 17
764:                 .FontName = "Tahoma"
765:                 .FontSize = 8
766:                 .Themes   = .F.
767:             ENDWITH
768: 
769:             WITH par_oPage.cnt_4c_Acabado.opt_4c_SituacaoCopia.Buttons(2)
770:                 .Caption  = "Inativo"
771:                 .Top      = 0
772:                 .Left     = 60
773:                 .Width    = 55
774:                 .Height   = 17
775:                 .FontName = "Tahoma"
776:                 .FontSize = 8
777:                 .Themes   = .F.
778:             ENDWITH
779: 
780:             par_oPage.cnt_4c_Acabado.AddObject("cmd_4c_OkCopia", "CommandButton")
781:             WITH par_oPage.cnt_4c_Acabado.cmd_4c_OkCopia
782:                 .Top      = 90
783:                 .Left     = 344
784:                 .Width    = 40
785:                 .Height   = 40
786:                 .Caption  = ""

*-- Linhas 923 a 988:
923:             par_oPage.grd_4c_Lista.Column7.CurrentControl = "Check1"
924:             par_oPage.grd_4c_Lista.Column7.Check1.Themes  = .F.
925:             par_oPage.grd_4c_Lista.Column7.Check1.Value   = 0
926: 
927:             *-- RecordSource FORA de WITH (critico: evita "Unknown member COLUMN1")
928:             par_oPage.grd_4c_Lista.RecordSource = "cursor_4c_Lista"
929: 
930:             *-- Redefinir ControlSources apos RecordSource (VFP faz auto-bind pela ordem dos campos)
931:             par_oPage.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Lista.CPros"
932:             par_oPage.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Lista.DPros"
933:             par_oPage.grd_4c_Lista.Column3.ControlSource = "cursor_4c_Lista.DGrus"
934:             par_oPage.grd_4c_Lista.Column4.ControlSource = "cursor_4c_Lista.SGrus"
935:             par_oPage.grd_4c_Lista.Column5.ControlSource = "cursor_4c_Lista.Reffs"
936:             par_oPage.grd_4c_Lista.Column6.ControlSource = "cursor_4c_Lista.UsuaAlts"
937:             par_oPage.grd_4c_Lista.Column7.ControlSource = "cursor_4c_Lista.Instalas"
938: 
939:             *-- Configurar colunas APOS RecordSource (evita reset de headers/ControlSource)
940:             THIS.FormatarGridLista(par_oPage.grd_4c_Lista)
941: 
942:         CATCH TO loc_oErro
943:             MsgErro(loc_oErro.Message, "Erro ao configurar Page1")
944:         ENDTRY
945:     ENDPROC
946: 
947:     *--------------------------------------------------------------------------
948:     PROTECTED PROCEDURE ConfigurarPage2(par_oPage)
949:         LOCAL loc_oContainer
950:         TRY
951:             *-- Botoes de acao (Grupo_Salva no legado) - Top = 9+29 = 38
952:             par_oPage.AddObject("cnt_4c_BotoesAcao", "Container")
953:             WITH par_oPage.cnt_4c_BotoesAcao
954:                 .Top         = 38
955:                 .Left        = 842
956:                 .Width       = 160
957:                 .Height      = 85
958:                 .BackStyle = 1
959:                 .BackColor = RGB(53, 53, 53)
960:                 .BorderStyle = 0
961:                 .Visible     = .T.
962:             ENDWITH
963: 
964:             par_oPage.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
965:             WITH par_oPage.cnt_4c_BotoesAcao.cmd_4c_Confirmar
966:                 .Top             = 5
967:                 .Left            = 5
968:                 .Width           = 75
969:                 .Height          = 75
970:                 .Caption         = "Confirmar"
971:                 .FontName        = "Comic Sans MS"
972:                 .FontBold        = .T.
973:                 .FontItalic      = .T.
974:                 .FontSize        = 8
975:                 .ForeColor       = RGB(90,90,90)
976:                 .BackColor       = RGB(255,255,255)
977:                 .Themes          = .F.
978:                 .SpecialEffect   = 0
979:                 .PicturePosition = 13
980:                 .MousePointer    = 15
981:                 .WordWrap        = .T.
982:                 .AutoSize        = .F.
983:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
984:                 .Visible         = .T.
985:             ENDWITH
986: 
987:             par_oPage.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
988:             WITH par_oPage.cnt_4c_BotoesAcao.cmd_4c_Cancelar

*-- Linhas 1016 a 1201:
1016:     ENDPROC
1017: 
1018:     *--------------------------------------------------------------------------
1019:     * TornarControlesVisiveis - Torna visiveis apenas controles _4c_ (evita
1020:     * containers flutuantes com Visible=.F. no legado)
1021:     *--------------------------------------------------------------------------
1022:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1023:         LOCAL loc_nI, loc_oCtrl, loc_cNome
1024:         TRY
1025:             FOR loc_nI = 1 TO par_oContainer.ControlCount
1026:                 loc_oCtrl = par_oContainer.Controls(loc_nI)
1027:                 IF "_4c_" $ loc_oCtrl.Name
1028:                     *-- Filtrar containers flutuantes que devem permanecer ocultos
1029:                     loc_cNome = UPPER(loc_oCtrl.Name)
1030:                     IF loc_cNome == "CNT_4C_ACABADO" OR ;
1031:                        loc_cNome == "CNT_4C_MENSAGEM" OR ;
1032:                        loc_cNome == "IMG_4C_FIGJPG" OR ;
1033:                        loc_cNome == "LBL_4C_SEMMENU" OR ;
1034:                        loc_cNome == "CMD_4C_COPIARPRODUTO"
1035:                         LOOP
1036:                     ENDIF
1037:                     IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1038:                         loc_oCtrl.Visible = .T.
1039:                     ENDIF
1040:                 ENDIF
1041:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1042:                     THIS.TornarControlesVisiveis(loc_oCtrl)
1043:                 ENDIF
1044:             ENDFOR
1045:         CATCH TO loc_oErro
1046:             *-- Tolerado: controles podem nao estar acessiveis durante ValidarUIFidelity
1047:         ENDTRY
1048:     ENDPROC
1049: 
1050:     *--------------------------------------------------------------------------
1051:     PROCEDURE FormatarGridLista(par_oGrid)
1052:         LOCAL loc_oGrid
1053:         TRY
1054:             loc_oGrid = par_oGrid
1055: 
1056:             *-- Column1: Produto (CPros)
1057:             loc_oGrid.Column1.Header1.Caption  = "Produto"
1058:             loc_oGrid.Column1.ControlSource    = "cursor_4c_Lista.CPros"
1059:             loc_oGrid.Column1.Width            = 80
1060:             loc_oGrid.Column1.ReadOnly         = .T.
1061:             loc_oGrid.Column1.Header1.FontBold = .T.
1062: 
1063:             *-- Column2: Descricao (DPros)
1064:             loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
1065:             loc_oGrid.Column2.ControlSource    = "cursor_4c_Lista.DPros"
1066:             loc_oGrid.Column2.Width            = 250
1067:             loc_oGrid.Column2.ReadOnly         = .T.
1068:             loc_oGrid.Column2.Header1.FontBold = .T.
1069: 
1070:             *-- Column3: Grupo (DGrus - descricao do grupo via JOIN)
1071:             loc_oGrid.Column3.Header1.Caption  = "Grupo"
1072:             loc_oGrid.Column3.ControlSource    = "cursor_4c_Lista.DGrus"
1073:             loc_oGrid.Column3.Width            = 100
1074:             loc_oGrid.Column3.ReadOnly         = .T.
1075:             loc_oGrid.Column3.Header1.FontBold = .T.
1076: 
1077:             *-- Column4: Subgrupo (SGrus)
1078:             loc_oGrid.Column4.Header1.Caption  = "Subgrp."
1079:             loc_oGrid.Column4.ControlSource    = "cursor_4c_Lista.SGrus"
1080:             loc_oGrid.Column4.Width            = 70
1081:             loc_oGrid.Column4.ReadOnly         = .T.
1082:             loc_oGrid.Column4.Header1.FontBold = .T.
1083: 
1084:             *-- Column5: Ref. Fornecedor (Reffs)
1085:             loc_oGrid.Column5.Header1.Caption  = "Ref. Fornecedor"
1086:             loc_oGrid.Column5.ControlSource    = "cursor_4c_Lista.Reffs"
1087:             loc_oGrid.Column5.Width            = 180
1088:             loc_oGrid.Column5.ReadOnly         = .T.
1089:             loc_oGrid.Column5.Header1.FontBold = .T.
1090: 
1091:             *-- Column6: Usuario (UsuaAlts)
1092:             loc_oGrid.Column6.Header1.Caption  = "Usu" + CHR(225) + "rio"
1093:             loc_oGrid.Column6.ControlSource    = "cursor_4c_Lista.UsuaAlts"
1094:             loc_oGrid.Column6.Width            = 100
1095:             loc_oGrid.Column6.ReadOnly         = .T.
1096:             loc_oGrid.Column6.Header1.FontBold = .T.
1097: 
1098:             *-- Column7: Instalacao - CheckBox (Instalas)
1099:             *-- ControlSource definido na Column (NAO no Check1) - evita Error 1767
1100:             loc_oGrid.Column7.Header1.Caption  = "I"
1101:             loc_oGrid.Column7.ControlSource    = "cursor_4c_Lista.Instalas"
1102:             loc_oGrid.Column7.Width            = 30
1103:             loc_oGrid.Column7.ReadOnly         = .T.
1104:             loc_oGrid.Column7.Header1.FontBold = .T.
1105:             loc_oGrid.Column7.Alignment        = 2
1106: 
1107:         CATCH TO loc_oErro
1108:             MsgErro(loc_oErro.Message, "Erro ao formatar grid lista")
1109:         ENDTRY
1110:     ENDPROC
1111: 
1112:     *--------------------------------------------------------------------------
1113:     * AlternarPagina - Troca entre Page1 (Lista) e Page2 (Dados)
1114:     *--------------------------------------------------------------------------
1115:     PROCEDURE AlternarPagina(par_nPagina)
1116:         LOCAL loc_oErro
1117:         TRY
1118:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1119:             this_cModoAtual = IIF(par_nPagina = 1, "LISTA", "DADOS")
1120:         CATCH TO loc_oErro
1121:             MsgErro(loc_oErro.Message, "Erro ao alternar p" + CHR(225) + "gina")
1122:         ENDTRY
1123:     ENDPROC
1124: 
1125:     *--------------------------------------------------------------------------
1126:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1127:     * Chamado apos transicoes de modo (INCLUIR/ALTERAR/VISUALIZAR)
1128:     *--------------------------------------------------------------------------
1129:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1130:         LOCAL loc_oPage1, loc_oPage2, loc_lEditando, loc_oErro
1131:         TRY
1132:             loc_oPage1   = THIS.pgf_4c_Paginas.Page1
1133:             loc_oPage2   = THIS.pgf_4c_Paginas.Page2
1134:             loc_lEditando = this_lEmEdicao
1135: 
1136:             *-- Botoes CRUD na Page1: desabilitar quando editando
1137:             loc_oPage1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = !loc_lEditando
1138:             loc_oPage1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = !loc_lEditando
1139:             loc_oPage1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = !loc_lEditando
1140:             loc_oPage1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = !loc_lEditando
1141:             loc_oPage1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = !loc_lEditando
1142:             loc_oPage1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = !loc_lEditando
1143: 
1144:             *-- Botoes de acao na Page2: Confirmar habilitado somente quando editando
1145:             loc_oPage2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
1146:         CATCH TO loc_oErro
1147:             *-- Tolerado: botoes podem nao existir durante inicializacao
1148:         ENDTRY
1149:     ENDPROC
1150: 
1151:     *--------------------------------------------------------------------------
1152:     * BtnSalvarClick - Alias de BtnConfirmarClick (compatibilidade)
1153:     *--------------------------------------------------------------------------
1154:     PROCEDURE BtnSalvarClick()
1155:         THIS.BtnConfirmarClick()
1156:     ENDPROC
1157: 
1158:     *--------------------------------------------------------------------------
1159:     * CarregarLista - Carrega dados no grid da Page1 com filtros aplicados
1160:     *--------------------------------------------------------------------------
1161:     PROCEDURE CarregarLista()
1162:         LOCAL loc_cSQL, loc_cWhere, loc_cCodGrupo
1163:         LOCAL loc_dDtIni, loc_dDtFim, loc_nSituacao
1164:         LOCAL loc_nRet, loc_oPage1, loc_nCount, loc_lContinuar
1165:         IF gb_4c_ValidandoUI
1166:             RETURN
1167:         ENDIF
1168:         IF gnConnHandle <= 0
1169:             RETURN
1170:         ENDIF
1171:         TRY
1172:             loc_lContinuar = .T.
1173: 
1174:             *-- Obter valores dos filtros
1175:             loc_oPage1    = THIS.pgf_4c_Paginas.Page1
1176:             loc_cCodGrupo = ALLTRIM(loc_oPage1.cnt_4c_Filtros.txt_4c_CodGrupo.Value)
1177:             loc_dDtIni    = loc_oPage1.cnt_4c_Filtros.txt_4c_DtAlterIni.Value
1178:             loc_dDtFim    = loc_oPage1.cnt_4c_Filtros.txt_4c_DtAlterFim.Value
1179:             loc_nSituacao = loc_oPage1.cnt_4c_Filtros.opt_4c_Situacao.Value
1180: 
1181:             *-- Montar clausula WHERE
1182:             loc_cWhere = " WHERE (1=1)"
1183:             IF !EMPTY(loc_cCodGrupo)
1184:                 loc_cWhere = loc_cWhere + ;
1185:                     " AND p.CGrus = " + EscaparSQL(PADR(loc_cCodGrupo, 10))
1186:             ENDIF
1187:             IF !EMPTY(loc_dDtIni)
1188:                 loc_cWhere = loc_cWhere + ;
1189:                     " AND p.DataAlts >= " + FormatarDataSQL(loc_dDtIni)
1190:             ENDIF
1191:             IF !EMPTY(loc_dDtFim)
1192:                 loc_cWhere = loc_cWhere + ;
1193:                     " AND p.DataAlts <= " + FormatarDataSQL(loc_dDtFim)
1194:             ENDIF
1195:             DO CASE
1196:                 CASE loc_nSituacao = 2
1197:                     loc_cWhere = loc_cWhere + " AND ISNULL(g.chkInstalas, 0) = 1"
1198:                 CASE loc_nSituacao = 3
1199:                     loc_cWhere = loc_cWhere + " AND ISNULL(g.chkInstalas, 0) = 0"
1200:             ENDCASE
1201: 

*-- Linhas 1208 a 1681:
1208:                        "LEFT JOIN SigCdGrp g ON g.CGrus = p.CGrus " + ;
1209:                        loc_cWhere + ;
1210:                        " ORDER BY p.CPros"
1211: 
1212:             *-- Executar em cursor temporario
1213:             IF USED("cursor_4c_ListaTemp")
1214:                 USE IN cursor_4c_ListaTemp
1215:             ENDIF
1216:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaTemp")
1217:             IF loc_nRet < 1
1218:                 MsgErro("Erro ao carregar lista de produtos.", "Erro")
1219:                 loc_lContinuar = .F.
1220:             ENDIF
1221: 
1222:             IF loc_lContinuar
1223:                 *-- Atualizar cursor principal (preserva estrutura de colunas do grid)
1224:                 SELECT cursor_4c_Lista
1225:                 ZAP
1226:                 APPEND FROM DBF("cursor_4c_ListaTemp")
1227:                 IF USED("cursor_4c_ListaTemp")
1228:                     USE IN cursor_4c_ListaTemp
1229:                 ENDIF
1230: 
1231:                 *-- Posicionar no inicio e atualizar contador
1232:                 SELECT cursor_4c_Lista
1233:                 GO TOP
1234:                 loc_oPage1.grd_4c_Lista.Refresh()
1235:                 loc_nCount = RECCOUNT("cursor_4c_Lista")
1236:                 loc_oPage1.lbl_4c_Produtos.Caption = ;
1237:                     "Produtos Selecionados : " + LTRIM(STR(loc_nCount))
1238:             ENDIF
1239: 
1240:         CATCH TO loc_oErro
1241:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de produtos")
1242:         ENDTRY
1243:     ENDPROC
1244: 
1245:     *--------------------------------------------------------------------------
1246:     * ConfigurarEventos - BINDEVENT para botoes e filtros
1247:     * IMPORTANTE: todos os handlers devem ser PUBLIC
1248:     *--------------------------------------------------------------------------
1249:     PROTECTED PROCEDURE ConfigurarEventos()
1250:         LOCAL loc_oPage1, loc_oPage2, loc_oErro
1251:         TRY
1252:             loc_oPage1 = THIS.pgf_4c_Paginas.Page1
1253:             loc_oPage2 = THIS.pgf_4c_Paginas.Page2
1254: 
1255:             *-- Botoes CRUD (Page1)
1256:             BINDEVENT(loc_oPage1.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
1257:             BINDEVENT(loc_oPage1.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
1258:             BINDEVENT(loc_oPage1.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
1259:             BINDEVENT(loc_oPage1.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
1260:             BINDEVENT(loc_oPage1.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
1261:             BINDEVENT(loc_oPage1.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
1262: 
1263:             *-- Botoes de acao (Page2)
1264:             BINDEVENT(loc_oPage2.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
1265:             BINDEVENT(loc_oPage2.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1266: 
1267:             *-- Grid DblClick -> Alterar
1268:             BINDEVENT(loc_oPage1.grd_4c_Lista, "DblClick", THIS, "GridDblClick")
1269: 
1270:             *-- Filtro de grupo: KeyPress (NUNCA LostFocus - causa recursao infinita)
1271:             BINDEVENT(loc_oPage1.cnt_4c_Filtros.txt_4c_CodGrupo, ;
1272:                       "KeyPress", THIS, "FiltroGrupoKeyPress")
1273: 
1274:             *-- Filtro data final: KeyPress (ENTER/TAB recarrega lista)
1275:             BINDEVENT(loc_oPage1.cnt_4c_Filtros.txt_4c_DtAlterFim, ;
1276:                       "KeyPress", THIS, "FiltroDataFimKeyPress")
1277: 
1278:             *-- OptionGroup situacao: InteractiveChange recarrega lista
1279:             BINDEVENT(loc_oPage1.cnt_4c_Filtros.opt_4c_Situacao, ;
1280:                       "InteractiveChange", THIS, "FiltroSituacaoChange")
1281: 
1282:             *-- OptionGroup de navegacao interna das paginas de dados
1283:             BINDEVENT(loc_oPage2.obj_4c_Optiongroup1, ;
1284:                       "InteractiveChange", THIS, "NavegacaoDadosChange")
1285: 
1286:             *-- Lookups da pagina de dados (pgf_4c_DadosInterno.Page1)
1287:             LOCAL loc_oPgDados
1288:             loc_oPgDados = loc_oPage2.pgf_4c_DadosInterno.Page1
1289: 
1290:             *-- Produto Equivalente
1291:             BINDEVENT(loc_oPgDados.txt_4c_CProEq, "KeyPress", THIS, "CProEqKeyPress")
1292:             BINDEVENT(loc_oPgDados.txt_4c_CProEq, "DblClick", THIS, "CProEqDblClick")
1293: 
1294:             *-- Grupo Produto
1295:             BINDEVENT(loc_oPgDados.txt_4c_Cgru, "KeyPress", THIS, "CgruKeyPress")
1296:             BINDEVENT(loc_oPgDados.txt_4c_Cgru, "DblClick", THIS, "CgruDblClick")
1297: 
1298:             *-- SubGrupo
1299:             BINDEVENT(loc_oPgDados.txt_4c_CSGru, "KeyPress", THIS, "CSGruKeyPress")
1300:             BINDEVENT(loc_oPgDados.txt_4c_CSGru, "DblClick", THIS, "CSGruDblClick")
1301: 
1302:             *-- Linha
1303:             BINDEVENT(loc_oPgDados.txt_4c_Lin, "KeyPress", THIS, "LinKeyPress")
1304:             BINDEVENT(loc_oPgDados.txt_4c_Lin, "DblClick", THIS, "LinDblClick")
1305: 
1306:             *-- Colecao / Grupo de Venda
1307:             BINDEVENT(loc_oPgDados.txt_4c_Col, "KeyPress", THIS, "ColKeyPress")
1308:             BINDEVENT(loc_oPgDados.txt_4c_Col, "DblClick", THIS, "ColDblClick")
1309: 
1310:             *-- Fornecedor (campo + botao F4)
1311:             BINDEVENT(loc_oPgDados.txt_4c_Ifor, "KeyPress", THIS, "IforKeyPress")
1312:             BINDEVENT(loc_oPgDados.cmd_4c_BtnFornecedor, "Click", THIS, "BtnFornecedorClick")
1313: 
1314:             *-- Cor
1315:             BINDEVENT(loc_oPgDados.txt_4c_CorPro, "KeyPress", THIS, "CorProKeyPress")
1316:             BINDEVENT(loc_oPgDados.txt_4c_CorPro, "DblClick", THIS, "CorProDblClick")
1317: 
1318:             *-- Tamanho
1319:             BINDEVENT(loc_oPgDados.txt_4c_Tam, "KeyPress", THIS, "TamKeyPress")
1320:             BINDEVENT(loc_oPgDados.txt_4c_Tam, "DblClick", THIS, "TamDblClick")
1321: 
1322:             *-- Finalidade
1323:             BINDEVENT(loc_oPgDados.txt_4c_CodFinP, "KeyPress", THIS, "CodFinPKeyPress")
1324:             BINDEVENT(loc_oPgDados.txt_4c_CodFinP, "DblClick", THIS, "CodFinPDblClick")
1325: 
1326:             *-- Acabamento
1327:             BINDEVENT(loc_oPgDados.txt_4c_CodAcb, "KeyPress", THIS, "CodAcbKeyPress")
1328:             BINDEVENT(loc_oPgDados.txt_4c_CodAcb, "DblClick", THIS, "CodAcbDblClick")
1329: 
1330:             *-- Classificacao
1331:             BINDEVENT(loc_oPgDados.txt_4c_Class, "KeyPress", THIS, "ClassKeyPress")
1332:             BINDEVENT(loc_oPgDados.txt_4c_Class, "DblClick", THIS, "ClassDblClick")
1333: 
1334:             *-- Local
1335:             BINDEVENT(loc_oPgDados.txt_4c_Local, "KeyPress", THIS, "LocalKeyPress")
1336:             BINDEVENT(loc_oPgDados.txt_4c_Local, "DblClick", THIS, "LocalDblClick")
1337: 
1338:             *-- Unidade 1
1339:             BINDEVENT(loc_oPgDados.txt_4c_Cuni, "KeyPress", THIS, "CuniKeyPress")
1340:             BINDEVENT(loc_oPgDados.txt_4c_Cuni, "DblClick", THIS, "CuniDblClick")
1341: 
1342:             *-- Unidade 2
1343:             BINDEVENT(loc_oPgDados.txt_4c_Cunip, "KeyPress", THIS, "CunipKeyPress")
1344:             BINDEVENT(loc_oPgDados.txt_4c_Cunip, "DblClick", THIS, "CunipDblClick")
1345: 
1346:             *-- === Composicao (Page2 do inner pageframe) ===
1347:             LOCAL loc_oPgComp
1348:             loc_oPgComp = loc_oPage2.pgf_4c_DadosInterno.Page2
1349: 
1350:             BINDEVENT(loc_oPgComp.grd_4c_Compo,             "AfterRowColChange", THIS, "CompoAfterRowColChange")
1351:             BINDEVENT(loc_oPgComp.grd_4c_SubCp,             "AfterRowColChange", THIS, "SubCpAfterRowColChange")
1352:             BINDEVENT(loc_oPgComp.chk_4c_ChkLiberaCusto,    "InteractiveChange", THIS, "LiberaCustoChange")
1353:             BINDEVENT(loc_oPgComp.chk_4c_ChkLiberaVenda,    "InteractiveChange", THIS, "LiberaVendaChange")
1354:             BINDEVENT(loc_oPgComp.txt_4c_Moec,              "KeyPress", THIS, "MoecKeyPress")
1355:             BINDEVENT(loc_oPgComp.txt_4c_Moepc,             "KeyPress", THIS, "MoepcKeyPress")
1356:             BINDEVENT(loc_oPgComp.txt_4c_Moecusf,           "KeyPress", THIS, "MoecusfKeyPress")
1357:             BINDEVENT(loc_oPgComp.txt_4c_Moeda,             "KeyPress", THIS, "MoedaKeyPress")
1358:             BINDEVENT(loc_oPgComp.txt_4c_Moepv,             "KeyPress", THIS, "MoepvKeyPress")
1359:             BINDEVENT(loc_oPgComp.txt_4c_Moev,              "KeyPress", THIS, "MoevKeyPress")
1360:             BINDEVENT(loc_oPgComp.txt_4c_Ftio,              "KeyPress", THIS, "FtioKeyPress")
1361:             BINDEVENT(loc_oPgComp.txt_4c_Margem,            "KeyPress", THIS, "MargemKeyPress")
1362:             BINDEVENT(loc_oPgComp.txt_4c_Cmkpc,             "KeyPress", THIS, "CmkpcKeyPress")
1363:             BINDEVENT(loc_oPgComp.cmd_4c_CmdCalcVals,       "Click",    THIS, "CalcValsClick")
1364:             BINDEVENT(loc_oPgComp.cmd_4c_CmdPesoM,          "Click",    THIS, "PesoMClick")
1365:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(1), "Click",    THIS, "CompoIncluirClick")
1366:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(2), "Click",    THIS, "CompoExcluirClick")
1367:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(3), "Click",    THIS, "CompoAtualizaClick")
1368:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(4), "Click",    THIS, "CompoCopiarClick")
1369:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(5), "Click",    THIS, "CompoGrupoClick")
1370:             BINDEVENT(loc_oPgComp.cmdg_4c_SubCp.Buttons(1), "Click",    THIS, "SubCpIncluirClick")
1371:             BINDEVENT(loc_oPgComp.cmdg_4c_SubCp.Buttons(2), "Click",    THIS, "SubCpExcluirClick")
1372: 
1373:             *-- === Custo (Page6 do inner pageframe) ===
1374:             LOCAL loc_oPgCusto
1375:             loc_oPgCusto = loc_oPage2.pgf_4c_DadosInterno.Page6
1376: 
1377:             BINDEVENT(loc_oPgCusto.grd_4c_GrdCustoCompo,           "AfterRowColChange", THIS, "GrdCustoCompoAfterRowColChange")
1378:             BINDEVENT(loc_oPgCusto.cbo_4c_CmbTipos,                 "InteractiveChange", THIS, "CboTiposCustoInteractiveChange")
1379:             BINDEVENT(loc_oPgCusto.cmdg_4c_CustoCompo.Buttons(1),  "Click", THIS, "CustoCompoIncluirClick")
1380:             BINDEVENT(loc_oPgCusto.cmdg_4c_CustoCompo.Buttons(2),  "Click", THIS, "CustoCompoExcluirClick")
1381: 
1382:             *-- === DadosFiscais (Page3 do inner pageframe) ===
1383:             LOCAL loc_oPgFisc
1384:             loc_oPgFisc = loc_oPage2.pgf_4c_DadosInterno.Page3
1385: 
1386:             BINDEVENT(loc_oPgFisc.txt_4c__gruccus,   "KeyPress", THIS, "GruccusFiscKeyPress")
1387:             BINDEVENT(loc_oPgFisc.txt_4c__dgruccus,  "KeyPress", THIS, "DgruccusFiscKeyPress")
1388:             BINDEVENT(loc_oPgFisc.txt_4c__contaccus, "KeyPress", THIS, "ContaccusFiscKeyPress")
1389:             BINDEVENT(loc_oPgFisc.txt_4c__dcontaccus,"KeyPress", THIS, "DcontaccusFiscKeyPress")
1390:             BINDEVENT(loc_oPgFisc.txt_4c_Clfiscal,   "KeyPress", THIS, "ClfiscalKeyPress")
1391:             BINDEVENT(loc_oPgFisc.txt_4c_Clfiscal,   "DblClick", THIS, "ClfiscalDblClick")
1392:             BINDEVENT(loc_oPgFisc.txt_4c_Dclfiscal,  "KeyPress", THIS, "DclfiscalKeyPress")
1393:             BINDEVENT(loc_oPgFisc.txt_4c_Origmerc,   "KeyPress", THIS, "OrigmercKeyPress")
1394:             BINDEVENT(loc_oPgFisc.txt_4c_Origmerc,   "DblClick", THIS, "OrigmercDblClick")
1395:             BINDEVENT(loc_oPgFisc.txt_4c_Dorigmerc,  "KeyPress", THIS, "DorigmercKeyPress")
1396:             BINDEVENT(loc_oPgFisc.txt_4c_Sittricm,   "KeyPress", THIS, "SittricmKeyPress")
1397:             BINDEVENT(loc_oPgFisc.txt_4c_Sittricm,   "DblClick", THIS, "SittricmDblClick")
1398:             BINDEVENT(loc_oPgFisc.txt_4c_Dsittricm,  "KeyPress", THIS, "DsittricmKeyPress")
1399:             BINDEVENT(loc_oPgFisc.txt_4c_Codigo,     "KeyPress", THIS, "CodServsFiscKeyPress")
1400:             BINDEVENT(loc_oPgFisc.txt_4c_TpTrib,     "KeyPress", THIS, "TpTribKeyPress")
1401:             BINDEVENT(loc_oPgFisc.txt_4c_TpTrib,     "DblClick", THIS, "TpTribDblClick")
1402:             BINDEVENT(loc_oPgFisc.txt_4c_Iat,        "KeyPress", THIS, "IatFiscKeyPress")
1403:             BINDEVENT(loc_oPgFisc.txt_4c_AliqIPI,    "KeyPress", THIS, "AliqIPIKeyPress")
1404:             BINDEVENT(loc_oPgFisc.txt_4c_Mvalor,     "KeyPress", THIS, "MvalorKeyPress")
1405:             BINDEVENT(loc_oPgFisc.txt_4c_Mvalor,     "DblClick", THIS, "MvalorDblClick")
1406:             BINDEVENT(loc_oPgFisc.txt_4c_Metal,      "KeyPress", THIS, "MetalKeyPress")
1407:             BINDEVENT(loc_oPgFisc.txt_4c_Metal,      "DblClick", THIS, "MetalDblClick")
1408:             BINDEVENT(loc_oPgFisc.txt_4c_Teor,       "KeyPress", THIS, "TeorKeyPress")
1409:             BINDEVENT(loc_oPgFisc.txt_4c_Teor,       "DblClick", THIS, "TeorDblClick")
1410:             BINDEVENT(loc_oPgFisc.cmd_4c_BtnDescFis, "Click",    THIS, "BtnDescFisClick")
1411: 
1412:         CATCH TO loc_oErro
1413:             MsgErro(loc_oErro.Message, "Erro ao configurar eventos")
1414:         ENDTRY
1415:     ENDPROC
1416: 
1417:     *--------------------------------------------------------------------------
1418:     * Handlers de botoes (PUBLIC - obrigatorio para BINDEVENT)
1419:     *--------------------------------------------------------------------------
1420:     PROCEDURE BtnIncluirClick()
1421:         LOCAL loc_oErro
1422:         TRY
1423:             THIS.AlternarPagina(2)
1424:             this_oBusinessObject.NovoRegistro()
1425:             this_lNovoRegistro = .T.
1426:             this_lEmEdicao     = .T.
1427:             this_cCodigo       = ""
1428:             THIS.LimparCampos()
1429:             THIS.HabilitarCampos(.T.)
1430:         CATCH TO loc_oErro
1431:             MsgErro(loc_oErro.Message, "Erro ao incluir produto")
1432:         ENDTRY
1433:     ENDPROC
1434: 
1435:     PROCEDURE BtnVisualizarClick()
1436:         LOCAL loc_cCodigo, loc_oErro, loc_lContinuar
1437:         loc_lContinuar = .T.
1438:         TRY
1439:             IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
1440:                 MsgAviso("Nenhum produto selecionado.", "Aviso")
1441:                 loc_lContinuar = .F.
1442:             ENDIF
1443:             IF loc_lContinuar
1444:                 SELECT cursor_4c_Lista
1445:                 loc_cCodigo = ALLTRIM(CPros)
1446:                 IF EMPTY(loc_cCodigo)
1447:                     MsgAviso("Nenhum produto selecionado.", "Aviso")
1448:                     loc_lContinuar = .F.
1449:                 ENDIF
1450:             ENDIF
1451:             IF loc_lContinuar
1452:                 THIS.AlternarPagina(2)
1453:                 this_lNovoRegistro = .F.
1454:                 this_lEmEdicao     = .F.
1455:                 this_cCodigo       = loc_cCodigo
1456:                 this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1457:                 THIS.BOParaForm()
1458:                 THIS.HabilitarCampos(.F.)
1459:             ENDIF
1460:         CATCH TO loc_oErro
1461:             MsgErro(loc_oErro.Message, "Erro ao visualizar produto")
1462:         ENDTRY
1463:     ENDPROC
1464: 
1465:     PROCEDURE BtnAlterarClick()
1466:         LOCAL loc_cCodigo, loc_oErro, loc_lContinuar
1467:         loc_lContinuar = .T.
1468:         TRY
1469:             IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
1470:                 MsgAviso("Nenhum produto selecionado.", "Aviso")
1471:                 loc_lContinuar = .F.
1472:             ENDIF
1473:             IF loc_lContinuar
1474:                 SELECT cursor_4c_Lista
1475:                 loc_cCodigo = ALLTRIM(CPros)
1476:                 IF EMPTY(loc_cCodigo)
1477:                     MsgAviso("Nenhum produto selecionado.", "Aviso")
1478:                     loc_lContinuar = .F.
1479:                 ENDIF
1480:             ENDIF
1481:             IF loc_lContinuar
1482:                 THIS.AlternarPagina(2)
1483:                 this_lNovoRegistro = .F.
1484:                 this_lEmEdicao     = .T.
1485:                 this_cCodigo       = loc_cCodigo
1486:                 this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1487:                 this_oBusinessObject.EditarRegistro()
1488:                 THIS.BOParaForm()
1489:                 THIS.HabilitarCampos(.T.)
1490:             ENDIF
1491:         CATCH TO loc_oErro
1492:             MsgErro(loc_oErro.Message, "Erro ao alterar produto")
1493:         ENDTRY
1494:     ENDPROC
1495: 
1496:     PROCEDURE BtnExcluirClick()
1497:         LOCAL loc_cCodigo, loc_lConfirmou, loc_oErro, loc_lContinuar
1498:         loc_lContinuar = .T.
1499:         TRY
1500:             IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
1501:                 MsgAviso("Nenhum produto selecionado.", "Aviso")
1502:                 loc_lContinuar = .F.
1503:             ENDIF
1504:             IF loc_lContinuar
1505:                 SELECT cursor_4c_Lista
1506:                 loc_cCodigo = ALLTRIM(CPros)
1507:                 IF EMPTY(loc_cCodigo)
1508:                     MsgAviso("Nenhum produto selecionado.", "Aviso")
1509:                     loc_lContinuar = .F.
1510:                 ENDIF
1511:             ENDIF
1512:             IF loc_lContinuar
1513:                 loc_lConfirmou = MsgConfirma("Deseja excluir o produto [" + ;
1514:                     loc_cCodigo + "]?", ;
1515:                     "Confirmar Exclus" + CHR(227) + "o")
1516:                 IF loc_lConfirmou
1517:                     this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1518:                     IF this_oBusinessObject.Excluir()
1519:                         MsgInfo("Produto exclu" + CHR(237) + "do com sucesso.", "Sucesso")
1520:                         THIS.CarregarLista()
1521:                     ELSE
1522:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
1523:                             "vel excluir o produto.", "Erro")
1524:                     ENDIF
1525:                 ENDIF
1526:             ENDIF
1527:         CATCH TO loc_oErro
1528:             MsgErro(loc_oErro.Message, "Erro ao excluir produto")
1529:         ENDTRY
1530:     ENDPROC
1531: 
1532:     PROCEDURE BtnBuscarClick()
1533:         LOCAL loc_oErro
1534:         TRY
1535:             THIS.CarregarLista()
1536:         CATCH TO loc_oErro
1537:             MsgErro(loc_oErro.Message, "Erro ao buscar")
1538:         ENDTRY
1539:     ENDPROC
1540: 
1541:     PROCEDURE BtnEncerrarClick()
1542:         LOCAL loc_oErro
1543:         TRY
1544:             THIS.Release()
1545:         CATCH TO loc_oErro
1546:             *-- Tolerado durante encerramento
1547:         ENDTRY
1548:     ENDPROC
1549: 
1550:     PROCEDURE BtnConfirmarClick()
1551:         LOCAL loc_oErro
1552:         TRY
1553:             THIS.FormParaBO()
1554:             IF this_lNovoRegistro
1555:                 IF this_oBusinessObject.Inserir()
1556:                     MsgInfo("Produto salvo com sucesso.", "Sucesso")
1557:                     THIS.AlternarPagina(1)
1558:                     THIS.CarregarLista()
1559:                 ELSE
1560:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
1561:                         "vel salvar o produto.", "Erro")
1562:                 ENDIF
1563:             ELSE
1564:                 IF this_oBusinessObject.Atualizar()
1565:                     MsgInfo("Produto atualizado com sucesso.", "Sucesso")
1566:                     THIS.AlternarPagina(1)
1567:                     THIS.CarregarLista()
1568:                 ELSE
1569:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
1570:                         "vel atualizar o produto.", "Erro")
1571:                 ENDIF
1572:             ENDIF
1573:         CATCH TO loc_oErro
1574:             MsgErro(loc_oErro.Message, "Erro ao confirmar opera" + CHR(231) + CHR(227) + "o")
1575:         ENDTRY
1576:     ENDPROC
1577: 
1578:     PROCEDURE BtnCancelarClick()
1579:         LOCAL loc_oErro
1580:         TRY
1581:             THIS.AlternarPagina(1)
1582:             this_lEmEdicao = .F.
1583:         CATCH TO loc_oErro
1584:             *-- Tolerado
1585:         ENDTRY
1586:     ENDPROC
1587: 
1588:     *--------------------------------------------------------------------------
1589:     * Handlers de filtros (PUBLIC - obrigatorio para BINDEVENT)
1590:     *--------------------------------------------------------------------------
1591:     PROCEDURE FiltroGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1592:         LOCAL loc_oErro
1593:         TRY
1594:             *-- F4(115): abrir lookup de grupo
1595:             IF par_nKeyCode = 115
1596:                 THIS.AbrirLookupGrupo()
1597:             ELSE
1598:                 *-- ENTER(13) ou TAB(9): validar grupo e recarregar
1599:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
1600:                     THIS.ValidarGrupoFiltro()
1601:                     THIS.CarregarLista()
1602:                 ENDIF
1603:             ENDIF
1604:         CATCH TO loc_oErro
1605:             *-- Tolerado
1606:         ENDTRY
1607:     ENDPROC
1608: 
1609:     PROCEDURE GridDblClick()
1610:         LOCAL loc_oErro
1611:         TRY
1612:             THIS.BtnAlterarClick()
1613:         CATCH TO loc_oErro
1614:             MsgErro(loc_oErro.Message, "Erro ao abrir registro")
1615:         ENDTRY
1616:     ENDPROC
1617: 
1618:     PROCEDURE FiltroDataFimKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1619:         LOCAL loc_oErro
1620:         TRY
1621:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1622:                 THIS.CarregarLista()
1623:             ENDIF
1624:         CATCH TO loc_oErro
1625:             *-- Tolerado
1626:         ENDTRY
1627:     ENDPROC
1628: 
1629:     PROCEDURE FiltroSituacaoChange()
1630:         LOCAL loc_oErro
1631:         TRY
1632:             THIS.CarregarLista()
1633:         CATCH TO loc_oErro
1634:             MsgErro(loc_oErro.Message, "Erro ao filtrar por situa" + CHR(231) + CHR(227) + "o")
1635:         ENDTRY
1636:     ENDPROC
1637: 
1638:     *--------------------------------------------------------------------------
1639:     * LimparCampos - Limpa todos os campos de pgDados (Parte 1)
1640:     *--------------------------------------------------------------------------
1641:     PROTECTED PROCEDURE LimparCampos()
1642:         LOCAL loc_oPgDados, loc_oErro
1643:         TRY
1644:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
1645:             loc_oPgDados.txt_4c_Cpro.Value     = ""
1646:             loc_oPgDados.txt_4c_Dpro.Value     = ""
1647:             loc_oPgDados.txt_4c_DPro2s.Value   = ""
1648:             loc_oPgDados.txt_4c_Cbar.Value     = ""
1649:             loc_oPgDados.txt_4c_EAN13.Value    = ""
1650:             loc_oPgDados.txt_4c_CProEq.Value   = ""
1651:             loc_oPgDados.txt_4c_Cgru.Value     = ""
1652:             loc_oPgDados.txt_4c_Dgru.Value     = ""
1653:             loc_oPgDados.txt_4c_Merc.Value     = ""
1654:             loc_oPgDados.txt_4c_IdeCPros.Value = ""
1655:             loc_oPgDados.txt_4c_CSGru.Value    = ""
1656:             loc_oPgDados.txt_4c_DsGru.Value    = ""
1657:             loc_oPgDados.txt_4c_Qmin.Value     = ""
1658:             loc_oPgDados.txt_4c_Lin.Value      = ""
1659:             loc_oPgDados.txt_4c_DLin.Value     = ""
1660:             loc_oPgDados.txt_4c_Obs3.Value     = ""
1661:             loc_oPgDados.txt_4c_Col.Value      = ""
1662:             loc_oPgDados.txt_4c_DCol.Value     = ""
1663:             loc_oPgDados.txt_4c_Ifor.Value     = ""
1664:             loc_oPgDados.txt_4c_Dfor.Value     = ""
1665:             loc_oPgDados.txt_4c_Refs.Value     = ""
1666:             loc_oPgDados.opt_4c_SituacaoPro.Value = 1
1667:             *-- Parte 2
1668:             loc_oPgDados.txt_4c_LtMinsV.Value   = ""
1669:             loc_oPgDados.txt_4c_Conjunto.Value  = ""
1670:             loc_oPgDados.txt_4c_QtPed.Value     = ""
1671:             loc_oPgDados.txt_4c_DiasGar.Value   = ""
1672:             loc_oPgDados.txt_4c_Obs1.Value      = ""
1673:             loc_oPgDados.txt_4c_Obs2.Value      = ""
1674:             loc_oPgDados.txt_4c_Altura.Value    = ""
1675:             loc_oPgDados.txt_4c_Largura.Value   = ""
1676:             loc_oPgDados.txt_4c_Diametro.Value  = ""
1677:             loc_oPgDados.txt_4c_Espessura.Value = ""
1678:             loc_oPgDados.txt_4c_Compriment.Value = ""
1679:             loc_oPgDados.txt_4c_Tam.Value       = ""
1680:             loc_oPgDados.txt_4c_CorPro.Value    = ""
1681:             loc_oPgDados.txt_4c_CodFinP.Value   = ""

*-- Linhas 1706 a 1727:
1706:             loc_oPgDados.edt_4c_ObsCompras.Value = ""
1707:             loc_oPgDados.chk_4c_GarVit.Value    = 0
1708:             loc_oPgDados.chk_4c_Consig.Value    = 0
1709:             loc_oPgDados.chk_4c_FabrProprs.Value = 0
1710:             loc_oPgDados.chk_4c_Encoms.Value    = 0
1711:             loc_oPgDados.opt_4c_ProdWeb.Value   = 1
1712:             loc_oPgDados.opt_4c_OpcVar.Value    = 1
1713:             *-- Limpar campos FaseP (Page4)
1714:             LOCAL loc_oPgFaseP
1715:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
1716:             loc_oPgFaseP.txt_4c_Qmin.Value          = ""
1717:             loc_oPgFaseP.txt_4c_CodGarras.Value     = ""
1718:             loc_oPgFaseP.txt_4c_Conquilha.Value     = ""
1719:             loc_oPgFaseP.txt_4c_PesoBris.Value      = ""
1720:             loc_oPgFaseP.txt_4c_PesoMetal.Value     = ""
1721:             loc_oPgFaseP.txt_4c_PesoPdrs.Value      = ""
1722:             loc_oPgFaseP.txt_4c_Cor.Value           = ""
1723:             loc_oPgFaseP.txt_4c_Tam.Value           = ""
1724:             loc_oPgFaseP.txt_4c_codacb.Value        = ""
1725:             loc_oPgFaseP.txt_4c_Dacb.Value          = ""
1726:             loc_oPgFaseP.chk_4c_Opc_CravCera.Value  = 0
1727:             loc_oPgFaseP.chk_4c_Fwoption1.Value     = 0

*-- Linhas 1733 a 1790:
1733:             loc_oPgFaseP.img_4c_ImgBorracha.Visible = .F.
1734:             IF USED("cursor_4c_PrfFase")
1735:                 SELECT cursor_4c_PrfFase
1736:                 ZAP
1737:             ENDIF
1738:             IF USED("cursor_4c_Mtz")
1739:                 SELECT cursor_4c_Mtz
1740:                 ZAP
1741:             ENDIF
1742:         CATCH TO loc_oErro
1743:             MsgErro(loc_oErro.Message, "Erro ao limpar campos")
1744:         ENDTRY
1745:     ENDPROC
1746: 
1747:     *--------------------------------------------------------------------------
1748:     * HabilitarCampos - Habilita/desabilita campos de edicao
1749:     *--------------------------------------------------------------------------
1750:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1751:         LOCAL loc_oPgDados, loc_oErro
1752:         TRY
1753:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
1754:             *-- Codigo: somente editavel em novo registro
1755:             loc_oPgDados.txt_4c_Cpro.ReadOnly  = !par_lHabilitar OR !this_lNovoRegistro
1756:             *-- Campos editaveis
1757:             loc_oPgDados.txt_4c_Dpro.ReadOnly    = !par_lHabilitar
1758:             loc_oPgDados.txt_4c_DPro2s.ReadOnly  = !par_lHabilitar
1759:             loc_oPgDados.txt_4c_Cbar.ReadOnly    = !par_lHabilitar
1760:             loc_oPgDados.txt_4c_EAN13.ReadOnly   = !par_lHabilitar
1761:             loc_oPgDados.txt_4c_CProEq.ReadOnly  = !par_lHabilitar
1762:             loc_oPgDados.txt_4c_Cgru.ReadOnly    = !par_lHabilitar
1763:             loc_oPgDados.txt_4c_Merc.ReadOnly    = !par_lHabilitar
1764:             loc_oPgDados.txt_4c_IdeCPros.ReadOnly = !par_lHabilitar
1765:             loc_oPgDados.txt_4c_CSGru.ReadOnly   = !par_lHabilitar
1766:             loc_oPgDados.txt_4c_Qmin.ReadOnly    = !par_lHabilitar
1767:             loc_oPgDados.txt_4c_Lin.ReadOnly     = !par_lHabilitar
1768:             loc_oPgDados.txt_4c_Obs3.ReadOnly    = !par_lHabilitar
1769:             loc_oPgDados.txt_4c_Col.ReadOnly     = !par_lHabilitar
1770:             loc_oPgDados.txt_4c_Ifor.ReadOnly    = !par_lHabilitar
1771:             loc_oPgDados.txt_4c_Refs.ReadOnly    = !par_lHabilitar
1772:             *-- Campos somente leitura (lookups preenchidos automaticamente)
1773:             loc_oPgDados.txt_4c_Dgru.ReadOnly  = .T.
1774:             loc_oPgDados.txt_4c_DsGru.ReadOnly = .T.
1775:             loc_oPgDados.txt_4c_DLin.ReadOnly  = .T.
1776:             loc_oPgDados.txt_4c_DCol.ReadOnly  = .T.
1777:             loc_oPgDados.txt_4c_Dfor.ReadOnly  = .T.
1778:             *-- Parte 2 - campos editaveis
1779:             loc_oPgDados.txt_4c_LtMinsV.ReadOnly   = !par_lHabilitar
1780:             loc_oPgDados.txt_4c_Conjunto.ReadOnly   = !par_lHabilitar
1781:             loc_oPgDados.txt_4c_QtPed.ReadOnly      = !par_lHabilitar
1782:             loc_oPgDados.txt_4c_DiasGar.ReadOnly    = !par_lHabilitar
1783:             loc_oPgDados.txt_4c_Obs1.ReadOnly       = !par_lHabilitar
1784:             loc_oPgDados.txt_4c_Obs2.ReadOnly       = !par_lHabilitar
1785:             loc_oPgDados.txt_4c_Altura.ReadOnly     = !par_lHabilitar
1786:             loc_oPgDados.txt_4c_Largura.ReadOnly    = !par_lHabilitar
1787:             loc_oPgDados.txt_4c_Diametro.ReadOnly   = !par_lHabilitar
1788:             loc_oPgDados.txt_4c_Espessura.ReadOnly  = !par_lHabilitar
1789:             loc_oPgDados.txt_4c_Compriment.ReadOnly = !par_lHabilitar
1790:             loc_oPgDados.txt_4c_Tam.ReadOnly        = !par_lHabilitar

*-- Linhas 1841 a 1884:
1841:     *--------------------------------------------------------------------------
1842:     * BOParaForm - Preenche campos do form com dados do BO (COMPLETO)
1843:     *--------------------------------------------------------------------------
1844:     PROTECTED PROCEDURE BOParaForm()
1845:         LOCAL loc_oPgDados, loc_oBO, loc_nRet, loc_oErro
1846:         TRY
1847:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
1848:             loc_oBO      = this_oBusinessObject
1849: 
1850:             *-- === Identificacao ===
1851:             loc_oPgDados.txt_4c_Cpro.Value     = ALLTRIM(loc_oBO.this_cCpros)
1852:             loc_oPgDados.txt_4c_Dpro.Value     = ALLTRIM(loc_oBO.this_cDpros)
1853:             loc_oPgDados.txt_4c_DPro2s.Value   = ALLTRIM(loc_oBO.this_cDPro2s)
1854:             loc_oPgDados.txt_4c_Cbar.Value     = ALLTRIM(loc_oBO.this_cCbars)
1855:             loc_oPgDados.txt_4c_EAN13.Value    = ALLTRIM(loc_oBO.this_cCbars)  && EAN13 = Cbars
1856:             loc_oPgDados.txt_4c_CProEq.Value   = ALLTRIM(loc_oBO.this_cCProEqs)
1857:             loc_oPgDados.txt_4c_Merc.Value     = ALLTRIM(loc_oBO.this_cMercs)
1858:             loc_oPgDados.txt_4c_IdeCPros.Value = ALLTRIM(loc_oBO.this_cIdeCPros)
1859:             loc_oPgDados.txt_4c_Refs.Value     = ALLTRIM(loc_oBO.this_cReffs)
1860: 
1861:             *-- === Grupo / SubGrupo ===
1862:             loc_oPgDados.txt_4c_Cgru.Value  = ALLTRIM(loc_oBO.this_cCgrus)
1863:             loc_oPgDados.txt_4c_CSGru.Value = ALLTRIM(loc_oBO.this_cSGrus)
1864: 
1865:             *-- Descricoes de grupo e subgrupo (lookup)
1866:             IF gnConnHandle > 0 AND !gb_4c_ValidandoUI
1867:                 IF !EMPTY(loc_oBO.this_cCgrus)
1868:                     loc_nRet = SQLEXEC(gnConnHandle, ;
1869:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
1870:                         EscaparSQL(PADR(ALLTRIM(loc_oBO.this_cCgrus), 10)), ;
1871:                         "cursor_4c_BODGru")
1872:                     IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BODGru") > 0
1873:                         SELECT cursor_4c_BODGru
1874:                         loc_oPgDados.txt_4c_Dgru.Value = ALLTRIM(DGrus)
1875:                     ENDIF
1876:                     IF USED("cursor_4c_BODGru")
1877:                         USE IN cursor_4c_BODGru
1878:                     ENDIF
1879:                 ELSE
1880:                     loc_oPgDados.txt_4c_Dgru.Value = ""
1881:                 ENDIF
1882:                 IF !EMPTY(loc_oBO.this_cSGrus)
1883:                     loc_nRet = SQLEXEC(gnConnHandle, ;
1884:                         "SELECT Descricaos AS DSGrus FROM SigCdPsg WHERE Codigos = " + ;

*-- Linhas 2019 a 2127:
2019:             loc_oPgDados.chk_4c_Consig.Value     = IIF(IIF(VARTYPE(loc_oBO.this_nConsigs) = "L", loc_oBO.this_nConsigs, (NVL(loc_oBO.this_nConsigs, 0) = 1)), 1, 0)
2020:             loc_oPgDados.chk_4c_FabrProprs.Value = IIF(IIF(VARTYPE(loc_oBO.this_nFabrProprs) = "L", loc_oBO.this_nFabrProprs, (NVL(loc_oBO.this_nFabrProprs, 0) = 1)), 1, 0)
2021:             loc_oPgDados.chk_4c_Encoms.Value     = IIF(IIF(VARTYPE(loc_oBO.this_nEncoms) = "L", loc_oBO.this_nEncoms, (NVL(loc_oBO.this_nEncoms, 0) = 1)), 1, 0)
2022: 
2023:             *-- === OptionGroups ===
2024:             loc_oPgDados.opt_4c_SituacaoPro.Value = IIF(IIF(VARTYPE(loc_oBO.this_nInstalas) = "L", loc_oBO.this_nInstalas, (NVL(loc_oBO.this_nInstalas, 0) = 1)), 1, 2)
2025:             loc_oPgDados.opt_4c_ProdWeb.Value     = IIF(IIF(VARTYPE(loc_oBO.this_nProdWebs) = "L", loc_oBO.this_nProdWebs, (NVL(loc_oBO.this_nProdWebs, 0) = 1)), 1, 2)
2026:             loc_oPgDados.opt_4c_OpcVar.Value      = IIF(IIF(VARTYPE(loc_oBO.this_nOpcVars) = "L", loc_oBO.this_nOpcVars, (NVL(loc_oBO.this_nOpcVars, 0) = 1)), 1, 2)
2027: 
2028:             *-- === Auditoria (somente leitura) ===
2029:             loc_oPgDados.txt_4c_DtIncs.Value      = loc_oBO.this_dDtIncs
2030:             loc_oPgDados.txt_4c_DataAlts.Value     = loc_oBO.this_dDataAlts
2031:             loc_oPgDados.txt_4c_Usuario.Value      = ALLTRIM(loc_oBO.this_cUsuaIncs)
2032:             loc_oPgDados.txt_4c_UsuaAlts.Value     = ALLTRIM(loc_oBO.this_cUsuaAlts)
2033:             loc_oPgDados.txt_4c_DtSituas.Value     = loc_oBO.this_dDtSituas
2034:             loc_oPgDados.txt_4c_Estoques.Value     = loc_oBO.this_nEstoques
2035:             loc_oPgDados.txt_4c_QtdEsts.Value      = loc_oBO.this_nQtdEsts
2036:             loc_oPgDados.txt_4c_Dtucp.Value        = loc_oBO.this_dDtucps
2037:             loc_oPgDados.txt_4c_Vucp.Value         = loc_oBO.this_nVucps
2038:             loc_oPgDados.txt_4c_Mucp.Value         = ALLTRIM(loc_oBO.this_cMucps)
2039:             loc_oPgDados.txt_4c_QtdUltComp.Value   = loc_oBO.this_nQtdUltComps
2040: 
2041:             *-- Preencher campos da pagina FaseP (Page4)
2042:             THIS.BOParaFormFaseP()
2043: 
2044:         CATCH TO loc_oErro
2045:             MsgErro(loc_oErro.Message, "Erro ao preencher campos do formulario")
2046:         ENDTRY
2047:     ENDPROC
2048: 
2049:     *--------------------------------------------------------------------------
2050:     * CarregarDescricaoLookup - Auxiliar: busca descricao de um lookup simples
2051:     *--------------------------------------------------------------------------
2052:     PROTECTED PROCEDURE CarregarDescricaoLookup(par_cTabela, par_cCampoPK, par_cCampoDes, ;
2053:                                                  par_cCodigo,  par_oTextBox)
2054:         LOCAL loc_nRet, loc_cAlias, loc_lContinuar, loc_oErro
2055:         TRY
2056:             loc_lContinuar = !EMPTY(par_cCodigo)
2057:             IF !loc_lContinuar
2058:                 par_oTextBox.Value = ""
2059:             ENDIF
2060:             IF loc_lContinuar
2061:                 loc_cAlias = "cursor_4c_Lookup_" + par_cTabela
2062:                 IF USED(loc_cAlias)
2063:                     USE IN (loc_cAlias)
2064:                 ENDIF
2065:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2066:                     "SELECT " + par_cCampoDes + " FROM " + par_cTabela + ;
2067:                     " WHERE " + par_cCampoPK + " = " + EscaparSQL(par_cCodigo), ;
2068:                     loc_cAlias)
2069:                 IF loc_nRet > 0 AND RECCOUNT(loc_cAlias) > 0
2070:                     SELECT (loc_cAlias)
2071:                     par_oTextBox.Value = ALLTRIM(&par_cCampoDes)
2072:                 ELSE
2073:                     par_oTextBox.Value = ""
2074:                 ENDIF
2075:                 IF USED(loc_cAlias)
2076:                     USE IN (loc_cAlias)
2077:                 ENDIF
2078:             ENDIF
2079:         CATCH TO loc_oErro
2080:             *-- Tolerado: lookup nao critico
2081:         ENDTRY
2082:     ENDPROC
2083: 
2084:     *--------------------------------------------------------------------------
2085:     * FormParaBO - Le campos do form e envia para o BO (COMPLETO)
2086:     *--------------------------------------------------------------------------
2087:     PROTECTED PROCEDURE FormParaBO()
2088:         LOCAL loc_oPgDados, loc_oBO, loc_oErro
2089:         TRY
2090:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
2091:             loc_oBO      = this_oBusinessObject
2092: 
2093:             *-- === Identificacao ===
2094:             loc_oBO.this_cCpros    = ALLTRIM(loc_oPgDados.txt_4c_Cpro.Value)
2095:             loc_oBO.this_cDpros    = ALLTRIM(loc_oPgDados.txt_4c_Dpro.Value)
2096:             loc_oBO.this_cDPro2s   = ALLTRIM(loc_oPgDados.txt_4c_DPro2s.Value)
2097:             loc_oBO.this_cCbars    = ALLTRIM(loc_oPgDados.txt_4c_Cbar.Value)
2098:             loc_oBO.this_cCProEqs  = ALLTRIM(loc_oPgDados.txt_4c_CProEq.Value)
2099:             loc_oBO.this_cMercs    = ALLTRIM(loc_oPgDados.txt_4c_Merc.Value)
2100:             loc_oBO.this_cIdeCPros = ALLTRIM(loc_oPgDados.txt_4c_IdeCPros.Value)
2101:             loc_oBO.this_cReffs    = ALLTRIM(loc_oPgDados.txt_4c_Refs.Value)
2102: 
2103:             *-- === Grupo / SubGrupo ===
2104:             loc_oBO.this_cCgrus = ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value)
2105:             loc_oBO.this_cSGrus = ALLTRIM(loc_oPgDados.txt_4c_CSGru.Value)
2106: 
2107:             *-- === Linha / Colecao ===
2108:             loc_oBO.this_cLins = ALLTRIM(loc_oPgDados.txt_4c_Lin.Value)
2109:             loc_oBO.this_cCols = ALLTRIM(loc_oPgDados.txt_4c_Col.Value)
2110: 
2111:             *-- === Fornecedor ===
2112:             loc_oBO.this_cIFors = ALLTRIM(loc_oPgDados.txt_4c_Ifor.Value)
2113: 
2114:             *-- === Quantidades / Lote ===
2115:             loc_oBO.this_nQmins     = STR(loc_oPgDados.txt_4c_Qmin.Value)
2116:             loc_oBO.this_nLtMinsVs  = STR(loc_oPgDados.txt_4c_LtMinsV.Value)
2117:             loc_oBO.this_nConjuntos = STR(loc_oPgDados.txt_4c_Conjunto.Value)
2118:             loc_oBO.this_nQtPeds    = STR(loc_oPgDados.txt_4c_QtPed.Value)
2119:             loc_oBO.this_nDiasGars  = STR(loc_oPgDados.txt_4c_DiasGar.Value)
2120: 
2121:             *-- === Dimensoes ===
2122:             loc_oBO.this_nAlturas     = STR(loc_oPgDados.txt_4c_Altura.Value)
2123:             loc_oBO.this_nLarguras    = STR(loc_oPgDados.txt_4c_Largura.Value)
2124:             loc_oBO.this_nDiametros   = STR(loc_oPgDados.txt_4c_Diametro.Value)
2125:             loc_oBO.this_nEspessuras  = STR(loc_oPgDados.txt_4c_Espessura.Value)
2126:             loc_oBO.this_nCompriments = STR(loc_oPgDados.txt_4c_Compriment.Value)
2127:             loc_oBO.this_nPesoBs      = STR(loc_oPgDados.txt_4c_PesoBs.Value)

*-- Linhas 2164 a 2353:
2164:             loc_oBO.this_nConsigs    = IIF(loc_oPgDados.chk_4c_Consig.Value    = 1, 1, 0)
2165:             loc_oBO.this_nFabrProprs = IIF(loc_oPgDados.chk_4c_FabrProprs.Value = 1, 1, 0)
2166:             loc_oBO.this_nEncoms     = IIF(loc_oPgDados.chk_4c_Encoms.Value    = 1, 1, 0)
2167: 
2168:             *-- === OptionGroups ===
2169:             loc_oBO.this_nInstalas = IIF(loc_oPgDados.opt_4c_SituacaoPro.Value = 1, 1, 0)
2170:             loc_oBO.this_nProdWebs = IIF(loc_oPgDados.opt_4c_ProdWeb.Value     = 1, 1, 0)
2171:             loc_oBO.this_nOpcVars  = IIF(loc_oPgDados.opt_4c_OpcVar.Value      = 1, 1, 0)
2172: 
2173:             *-- Ler campos da pagina FaseP (Page4)
2174:             THIS.FormParaBOFaseP()
2175: 
2176:         CATCH TO loc_oErro
2177:             MsgErro(loc_oErro.Message, "Erro ao ler campos do formulario")
2178:         ENDTRY
2179:     ENDPROC
2180: 
2181:     *--------------------------------------------------------------------------
2182:     * NavegacaoDadosChange - Muda pagina do inner PageFrame via OptionGroup
2183:     *--------------------------------------------------------------------------
2184:     PROCEDURE NavegacaoDadosChange()
2185:         LOCAL loc_nPagina, loc_oErro
2186:         TRY
2187:             loc_nPagina = THIS.pgf_4c_Paginas.Page2.obj_4c_Optiongroup1.Value
2188:             THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.ActivePage = loc_nPagina
2189:             IF loc_nPagina = 2
2190:                 THIS.CarregarComposicao()
2191:             ENDIF
2192:             IF loc_nPagina = 4
2193:                 THIS.CarregarFaseP()
2194:                 THIS.CarregarMatrizes()
2195:             ENDIF
2196:             IF loc_nPagina = 5
2197:                 THIS.CarregarConsP()
2198:             ENDIF
2199:             IF loc_nPagina = 7
2200:                 THIS.CarregarDesigner()
2201:             ENDIF
2202:         CATCH TO loc_oErro
2203:             MsgErro(loc_oErro.Message, "Erro ao navegar entre p" + CHR(225) + "ginas")
2204:         ENDTRY
2205:     ENDPROC
2206: 
2207:     *==========================================================================
2208:     * ConfigurarPaginaDados - Cria inner PageFrame (pgframeDados) e navegacao
2209:     * Ambos diretamente em Page2 do outer PageFrame -> compensar +29
2210:     *==========================================================================
2211:     PROTECTED PROCEDURE ConfigurarPaginaDados(par_oPage)
2212:         LOCAL loc_oPgfInner, loc_oErro
2213:         TRY
2214:             *-- OptionGroup de navegacao (Optiongroup1 no legado)
2215:             *-- top=5+29=34, left=5, width=535, height=85
2216:             par_oPage.AddObject("obj_4c_Optiongroup1", "OptionGroup")
2217:             WITH par_oPage.obj_4c_Optiongroup1
2218:                 .Top         = 34
2219:                 .Left        = 5
2220:                 .Width       = 535
2221:                 .Height      = 85
2222:                 .ButtonCount = 7
2223:                 .Value       = 1
2224:                 .Themes      = .F.
2225:                 .Visible     = .T.
2226:             ENDWITH
2227: 
2228:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(1)
2229:                 .Caption   = "Dados"
2230:                 .Top       = 0
2231:                 .Left      = 0
2232:                 .Width     = 75
2233:                 .Height    = 80
2234:                 .FontName  = "Comic Sans MS"
2235:                 .FontBold  = .T.
2236:                 .FontSize  = 8
2237:                 .ForeColor = RGB(90,90,90)
2238:                 .BackColor = RGB(255,255,255)
2239:                 .Themes    = .F.
2240:                 .Value     = 1
2241:             ENDWITH
2242: 
2243:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(2)
2244:                 .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
2245:                 .Top       = 0
2246:                 .Left      = 76
2247:                 .Width     = 75
2248:                 .Height    = 80
2249:                 .FontName  = "Comic Sans MS"
2250:                 .FontBold  = .T.
2251:                 .FontSize  = 8
2252:                 .ForeColor = RGB(90,90,90)
2253:                 .BackColor = RGB(255,255,255)
2254:                 .Themes    = .F.
2255:             ENDWITH
2256: 
2257:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(3)
2258:                 .Caption   = "Fiscal"
2259:                 .Top       = 0
2260:                 .Left      = 152
2261:                 .Width     = 75
2262:                 .Height    = 80
2263:                 .FontName  = "Comic Sans MS"
2264:                 .FontBold  = .T.
2265:                 .FontSize  = 8
2266:                 .ForeColor = RGB(90,90,90)
2267:                 .BackColor = RGB(255,255,255)
2268:                 .Themes    = .F.
2269:             ENDWITH
2270: 
2271:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(4)
2272:                 .Caption   = "Fase P"
2273:                 .Top       = 0
2274:                 .Left      = 228
2275:                 .Width     = 75
2276:                 .Height    = 80
2277:                 .FontName  = "Comic Sans MS"
2278:                 .FontBold  = .T.
2279:                 .FontSize  = 8
2280:                 .ForeColor = RGB(90,90,90)
2281:                 .BackColor = RGB(255,255,255)
2282:                 .Themes    = .F.
2283:             ENDWITH
2284: 
2285:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(5)
2286:                 .Caption   = "Cons P"
2287:                 .Top       = 0
2288:                 .Left      = 304
2289:                 .Width     = 75
2290:                 .Height    = 80
2291:                 .FontName  = "Comic Sans MS"
2292:                 .FontBold  = .T.
2293:                 .FontSize  = 8
2294:                 .ForeColor = RGB(90,90,90)
2295:                 .BackColor = RGB(255,255,255)
2296:                 .Themes    = .F.
2297:             ENDWITH
2298: 
2299:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(6)
2300:                 .Caption   = "Custo"
2301:                 .Top       = 0
2302:                 .Left      = 380
2303:                 .Width     = 75
2304:                 .Height    = 80
2305:                 .FontName  = "Comic Sans MS"
2306:                 .FontBold  = .T.
2307:                 .FontSize  = 8
2308:                 .ForeColor = RGB(90,90,90)
2309:                 .BackColor = RGB(255,255,255)
2310:                 .Themes    = .F.
2311:             ENDWITH
2312: 
2313:             WITH par_oPage.obj_4c_Optiongroup1.Buttons(7)
2314:                 .Caption   = "Designer"
2315:                 .Top       = 0
2316:                 .Left      = 456
2317:                 .Width     = 75
2318:                 .Height    = 80
2319:                 .FontName  = "Comic Sans MS"
2320:                 .FontBold  = .T.
2321:                 .FontSize  = 8
2322:                 .ForeColor = RGB(90,90,90)
2323:                 .BackColor = RGB(255,255,255)
2324:                 .Themes    = .F.
2325:             ENDWITH
2326: 
2327:             *-- Inner PageFrame (pgframeDados no legado)
2328:             *-- top=-54+29=-25, left=-1 (diretamente em Page2 -> compensar +29)
2329:             par_oPage.AddObject("pgf_4c_DadosInterno", "PageFrame")
2330:             loc_oPgfInner = par_oPage.pgf_4c_DadosInterno
2331:             WITH loc_oPgfInner
2332:                 .Top       = -25
2333:                 .Left      = -1
2334:                 .Width     = 1003
2335:                 .Height    = 656
2336:                 .PageCount = 7
2337:                 .Tabs      = .F.
2338:                 .Themes    = .F.
2339:                 .Visible   = .T.
2340:             ENDWITH
2341: 
2342:             loc_oPgfInner.Page1.Caption = "Dados"
2343:             loc_oPgfInner.Page2.Caption = "Composi" + CHR(231) + CHR(227) + "o"
2344:             loc_oPgfInner.Page3.Caption = "Fiscal"
2345:             loc_oPgfInner.Page4.Caption = "Fase P"
2346:             loc_oPgfInner.Page5.Caption = "Cons P"
2347:             loc_oPgfInner.Page6.Caption = "Custo"
2348:             loc_oPgfInner.Page7.Caption = "Designer"
2349: 
2350:             *-- Configurar primeira pagina interna (pgDados - ambas as partes)
2351:             THIS.ConfigurarPgDados1(loc_oPgfInner.Page1)
2352:             THIS.ConfigurarPgDados2(loc_oPgfInner.Page1)
2353: 

*-- Linhas 2378 a 2425:
2378:     * ConfigurarPgDados1 - Campos de pgDados (primeira metade: top <= 301)
2379:     * Posicoes: original_top + 29 (inner PageFrame esta em Page2 outer -> +29)
2380:     *==========================================================================
2381:     PROTECTED PROCEDURE ConfigurarPgDados1(par_oPage)
2382:         TRY
2383:             *-- OptionGroup situacao (opc_situacao no legado)
2384:             *-- top=130+29=159, left=735, width=142, height=25
2385:             par_oPage.AddObject("opt_4c_SituacaoPro", "OptionGroup")
2386:             WITH par_oPage.opt_4c_SituacaoPro
2387:                 .Top         = 159
2388:                 .Left        = 735
2389:                 .Width       = 142
2390:                 .Height      = 25
2391:                 .ButtonCount = 2
2392:                 .Value       = 1
2393:                 .Themes      = .F.
2394:                 .Visible     = .T.
2395:             ENDWITH
2396:             WITH par_oPage.opt_4c_SituacaoPro.Buttons(1)
2397:                 .Caption  = "Ativo"
2398:                 .Top      = 0
2399:                 .Left     = 0
2400:                 .Width    = 68
2401:                 .Height   = 22
2402:                 .FontName = "Tahoma"
2403:                 .FontSize = 8
2404:                 .Themes   = .F.
2405:                 .Value    = 1
2406:             ENDWITH
2407:             WITH par_oPage.opt_4c_SituacaoPro.Buttons(2)
2408:                 .Caption  = "Inativo"
2409:                 .Top      = 0
2410:                 .Left     = 70
2411:                 .Width    = 68
2412:                 .Height   = 22
2413:                 .FontName = "Tahoma"
2414:                 .FontSize = 8
2415:                 .Themes   = .F.
2416:             ENDWITH
2417: 
2418:             *-- Label "Produto :" (Label2, top=134+29=163)
2419:             par_oPage.AddObject("lbl_4c_LbCpro", "Label")
2420:             WITH par_oPage.lbl_4c_LbCpro
2421:                 .Top       = 163
2422:                 .Left      = 58
2423:                 .Width     = 53
2424:                 .Height    = 15
2425:                 .FontName  = "Tahoma"

*-- Linhas 2885 a 2928:
2885:     * ConfigurarPgDados2 - Campos de pgDados (segunda metade: controles restantes)
2886:     * Posicoes: original_top + 29 (compensacao inner PageFrame em Page2 outer)
2887:     *==========================================================================
2888:     PROTECTED PROCEDURE ConfigurarPgDados2(par_oPage)
2889:         LOCAL loc_oErro
2890:         TRY
2891:             *-- cmd_4c_Produto (cmdProduto, top=33+29=62, left=623, w=85, h=85)
2892:             par_oPage.AddObject("cmd_4c_Produto", "CommandButton")
2893:             WITH par_oPage.cmd_4c_Produto
2894:                 .Top = 62
2895:                 .Left = 623
2896:                 .Width = 85
2897:                 .Height = 85
2898:                 .Caption = "Produto"
2899:                 .FontName = "Tahoma"
2900:                 .FontSize = 8
2901:                 .Themes = .F.
2902:                 .Visible = .T.
2903:             ENDWITH
2904: 
2905:             *-- cmd_4c_Arquivos (cmdArquivos, top=33+29=62, left=698, w=85, h=85)
2906:             par_oPage.AddObject("cmd_4c_Arquivos", "CommandButton")
2907:             WITH par_oPage.cmd_4c_Arquivos
2908:                 .Top = 62
2909:                 .Left = 698
2910:                 .Width = 85
2911:                 .Height = 85
2912:                 .Caption = "Arquivos"
2913:                 .FontName = "Tahoma"
2914:                 .FontSize = 8
2915:                 .Themes = .F.
2916:                 .Visible = .T.
2917:             ENDWITH
2918: 
2919:             *-- txt_4c_DtSituas (getDtSituas, data situacao, top=132+29=161) readonly
2920:             par_oPage.AddObject("txt_4c_DtSituas", "TextBox")
2921:             WITH par_oPage.txt_4c_DtSituas
2922:                 .Top = 161
2923:                 .Left = 878
2924:                 .Width = 80
2925:                 .Height = 21
2926:                 .FontName = "Tahoma"
2927:                 .FontSize = 8
2928:                 .ReadOnly = .T.

*-- Linhas 2969 a 3015:
2969:                 .BackStyle = 0
2970:                 .Caption = "Lote M" + CHR(237) + "nimo :"
2971:                 .Visible = .T.
2972:             ENDWITH
2973: 
2974:             *-- opt_4c_ProdWeb (Fwoption1, produto web, top=172+29=201, left=879, w=117, h=42)
2975:             par_oPage.AddObject("opt_4c_ProdWeb", "OptionGroup")
2976:             WITH par_oPage.opt_4c_ProdWeb
2977:                 .Top = 201
2978:                 .Left = 879
2979:                 .Width = 117
2980:                 .Height = 42
2981:                 .ButtonCount = 2
2982:                 .Value = 1
2983:                 .Themes = .F.
2984:                 .Visible = .T.
2985:             ENDWITH
2986:             WITH par_oPage.opt_4c_ProdWeb.Buttons(1)
2987:                 .Caption = "Sim"
2988:                 .Top = 0
2989:                 .Left = 0
2990:                 .Width = 55
2991:                 .Height = 20
2992:                 .FontName = "Tahoma"
2993:                 .FontSize = 8
2994:                 .Themes = .F.
2995:                 .Value = 1
2996:             ENDWITH
2997:             WITH par_oPage.opt_4c_ProdWeb.Buttons(2)
2998:                 .Caption = "N" + CHR(227) + "o"
2999:                 .Top = 0
3000:                 .Left = 57
3001:                 .Width = 55
3002:                 .Height = 20
3003:                 .FontName = "Tahoma"
3004:                 .FontSize = 8
3005:                 .Themes = .F.
3006:             ENDWITH
3007: 
3008:             *-- Label "Produto Web :" (Say29, top=176+29=205)
3009:             par_oPage.AddObject("lbl_4c_LbProdWeb", "Label")
3010:             WITH par_oPage.lbl_4c_LbProdWeb
3011:                 .Top = 205
3012:                 .Left = 805
3013:                 .Width = 72
3014:                 .Height = 15
3015:                 .FontName = "Tahoma"

*-- Linhas 3087 a 3133:
3087:                 .MaxLength = 14
3088:                 .Themes = .F.
3089:                 .Visible = .T.
3090:             ENDWITH
3091: 
3092:             *-- opt_4c_OpcVar (Fwoption2, top=203+29=232, left=874, w=107, h=22)
3093:             par_oPage.AddObject("opt_4c_OpcVar", "OptionGroup")
3094:             WITH par_oPage.opt_4c_OpcVar
3095:                 .Top = 232
3096:                 .Left = 874
3097:                 .Width = 107
3098:                 .Height = 22
3099:                 .ButtonCount = 2
3100:                 .Value = 1
3101:                 .Themes = .F.
3102:                 .Visible = .T.
3103:             ENDWITH
3104:             WITH par_oPage.opt_4c_OpcVar.Buttons(1)
3105:                 .Caption = "Sim"
3106:                 .Top = 0
3107:                 .Left = 0
3108:                 .Width = 50
3109:                 .Height = 20
3110:                 .FontName = "Tahoma"
3111:                 .FontSize = 8
3112:                 .Themes = .F.
3113:                 .Value = 1
3114:             ENDWITH
3115:             WITH par_oPage.opt_4c_OpcVar.Buttons(2)
3116:                 .Caption = "N" + CHR(227) + "o"
3117:                 .Top = 0
3118:                 .Left = 52
3119:                 .Width = 50
3120:                 .Height = 20
3121:                 .FontName = "Tahoma"
3122:                 .FontSize = 8
3123:                 .Themes = .F.
3124:             ENDWITH
3125: 
3126:             *-- Label "Conjunto :" (Say37, top=206+29=235, left=408)
3127:             par_oPage.AddObject("lbl_4c_LbConjunto", "Label")
3128:             WITH par_oPage.lbl_4c_LbConjunto
3129:                 .Top = 235
3130:                 .Left = 408
3131:                 .Width = 53
3132:                 .Height = 15
3133:                 .FontName = "Tahoma"

*-- Linhas 4703 a 5876:
4703:         CATCH TO loc_oErro
4704:             MsgErro(loc_oErro.Message, "Erro ao configurar campos pgDados (Parte 2)")
4705:         ENDTRY
4706:     ENDPROC
4707: 
4708:     PROTECTED PROCEDURE ValidarGrupoFiltro()
4709:         LOCAL loc_cCodGrupo, loc_nRet, loc_oPage1, loc_oErro
4710:         TRY
4711:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
4712:                 RETURN
4713:             ENDIF
4714:             loc_oPage1    = THIS.pgf_4c_Paginas.Page1
4715:             loc_cCodGrupo = ALLTRIM(loc_oPage1.cnt_4c_Filtros.txt_4c_CodGrupo.Value)
4716:             IF EMPTY(loc_cCodGrupo)
4717:                 loc_oPage1.cnt_4c_Filtros.txt_4c_DesGrupo.Value = ""
4718:                 RETURN
4719:             ENDIF
4720:             loc_nRet = SQLEXEC(gnConnHandle, ;
4721:                 "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
4722:                 EscaparSQL(PADR(loc_cCodGrupo, 10)), ;
4723:                 "cursor_4c_BuscaGrp")
4724:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BuscaGrp") > 0
4725:                 SELECT cursor_4c_BuscaGrp
4726:                 loc_oPage1.cnt_4c_Filtros.txt_4c_DesGrupo.Value = ALLTRIM(DGrus)
4727:             ELSE
4728:                 loc_oPage1.cnt_4c_Filtros.txt_4c_DesGrupo.Value = ""
4729:                 loc_oPage1.cnt_4c_Filtros.txt_4c_CodGrupo.Value = ""
4730:             ENDIF
4731:             IF USED("cursor_4c_BuscaGrp")
4732:                 USE IN cursor_4c_BuscaGrp
4733:             ENDIF
4734:         CATCH TO loc_oErro
4735:             MsgErro(loc_oErro.Message, "Erro ao validar grupo")
4736:         ENDTRY
4737:     ENDPROC
4738: 
4739:     *-- AbrirLookupGrupo: lookup para o FILTRO da Page1 (txt_4c_CodGrupo)
4740:     PROTECTED PROCEDURE AbrirLookupGrupo()
4741:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_oPage1, loc_oErro
4742:         TRY
4743:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
4744:                 RETURN
4745:             ENDIF
4746:             loc_oPage1 = THIS.pgf_4c_Paginas.Page1
4747:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", ;
4748:                 "cursor_4c_BuscaGrpFlt", "CGrus", ;
4749:                 ALLTRIM(loc_oPage1.cnt_4c_Filtros.txt_4c_CodGrupo.Value), ;
4750:                 "Grupo de Produto")
4751:             loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
4752:             loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
4753:             loc_oBusca.Show()
4754:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpFlt")
4755:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGrpFlt.CGrus)
4756:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrpFlt.DGrus)
4757:                 loc_oPage1.cnt_4c_Filtros.txt_4c_CodGrupo.Value = loc_cCodigo
4758:                 loc_oPage1.cnt_4c_Filtros.txt_4c_DesGrupo.Value = loc_cDescricao
4759:             ENDIF
4760:             IF USED("cursor_4c_BuscaGrpFlt")
4761:                 USE IN cursor_4c_BuscaGrpFlt
4762:             ENDIF
4763:             loc_oBusca.Release()
4764:         CATCH TO loc_oErro
4765:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup grupo (filtro)")
4766:         ENDTRY
4767:     ENDPROC
4768: 
4769:     *==========================================================================
4770:     * FASE 6: Lookup Handlers e Metodos AbrirLookup
4771:     * Todos os handlers sao PUBLIC (obrigatorio para BINDEVENT)
4772:     * Todos os AbrirLookup sao PROTECTED
4773:     *==========================================================================
4774: 
4775:     *-- Produto Equivalente (SigCdPro: CPros / DPros)
4776:     PROCEDURE CProEqKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4777:         TRY
4778:             IF par_nKeyCode = 115
4779:                 THIS.AbrirLookupCProEq()
4780:             ENDIF
4781:         CATCH TO loc_oErro
4782:             *-- Tolerado
4783:         ENDTRY
4784:     ENDPROC
4785: 
4786:     PROCEDURE CProEqDblClick()
4787:         THIS.AbrirLookupCProEq()
4788:     ENDPROC
4789: 
4790:     PROTECTED PROCEDURE AbrirLookupCProEq()
4791:         LOCAL loc_oBusca, loc_oPgDados, loc_oErro
4792:         TRY
4793:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
4794:                 RETURN
4795:             ENDIF
4796:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
4797:             IF !loc_oPgDados.txt_4c_CProEq.Enabled
4798:                 RETURN
4799:             ENDIF
4800:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
4801:                 "cursor_4c_BuscaCProEq", "CPros", ;
4802:                 ALLTRIM(loc_oPgDados.txt_4c_CProEq.Value), ;
4803:                 "Produto Equivalente")
4804:             loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
4805:             loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
4806:             loc_oBusca.Show()
4807:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCProEq")
4808:                 loc_oPgDados.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_BuscaCProEq.CPros)
4809:             ENDIF
4810:             IF USED("cursor_4c_BuscaCProEq")
4811:                 USE IN cursor_4c_BuscaCProEq
4812:             ENDIF
4813:             loc_oBusca.Release()
4814:         CATCH TO loc_oErro
4815:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup produto equivalente")
4816:         ENDTRY
4817:     ENDPROC
4818: 
4819:     *-- Grupo Produto (SigCdGrp: CGrus / DGrus)
4820:     PROCEDURE CgruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4821:         TRY
4822:             IF par_nKeyCode = 115
4823:                 THIS.AbrirLookupCgru()
4824:             ELSE
4825:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
4826:                 THIS.ValidarCgruDados()
4827:                 ENDIF
4828:             ENDIF
4829:         CATCH TO loc_oErro
4830:             *-- Tolerado
4831:         ENDTRY
4832:     ENDPROC
4833: 
4834:     PROCEDURE CgruDblClick()
4835:         THIS.AbrirLookupCgru()
4836:     ENDPROC
4837: 
4838:     PROTECTED PROCEDURE AbrirLookupCgru()
4839:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao, loc_oErro
4840:         TRY
4841:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
4842:                 RETURN
4843:             ENDIF
4844:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
4845:             IF !loc_oPgDados.txt_4c_Cgru.Enabled
4846:                 RETURN
4847:             ENDIF
4848:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", ;
4849:                 "cursor_4c_BuscaCgru", "CGrus", ;
4850:                 ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value), ;
4851:                 "Grupo de Produto")
4852:             loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
4853:             loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
4854:             loc_oBusca.Show()
4855:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCgru")
4856:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCgru.CGrus)
4857:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaCgru.DGrus)
4858:                 loc_oPgDados.txt_4c_Cgru.Value = loc_cCodigo
4859:                 loc_oPgDados.txt_4c_Dgru.Value = loc_cDescricao
4860:             ENDIF
4861:             IF USED("cursor_4c_BuscaCgru")
4862:                 USE IN cursor_4c_BuscaCgru
4863:             ENDIF
4864:             loc_oBusca.Release()
4865:         CATCH TO loc_oErro
4866:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup grupo de produto")
4867:         ENDTRY
4868:     ENDPROC
4869: 
4870:     PROTECTED PROCEDURE ValidarCgruDados()
4871:         LOCAL loc_oPgDados, loc_cCodGru, loc_nRet, loc_oErro
4872:         TRY
4873:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
4874:                 RETURN
4875:             ENDIF
4876:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
4877:             loc_cCodGru  = ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value)
4878:             IF EMPTY(loc_cCodGru)
4879:                 loc_oPgDados.txt_4c_Dgru.Value = ""
4880:                 RETURN
4881:             ENDIF
4882:             loc_nRet = SQLEXEC(gnConnHandle, ;
4883:                 "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
4884:                 EscaparSQL(PADR(loc_cCodGru, 10)), ;
4885:                 "cursor_4c_ValGru")
4886:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValGru") > 0
4887:                 SELECT cursor_4c_ValGru
4888:                 loc_oPgDados.txt_4c_Dgru.Value = ALLTRIM(DGrus)
4889:             ELSE
4890:                 loc_oPgDados.txt_4c_Cgru.Value = ""
4891:                 loc_oPgDados.txt_4c_Dgru.Value = ""
4892:             ENDIF
4893:             IF USED("cursor_4c_ValGru")
4894:                 USE IN cursor_4c_ValGru
4895:             ENDIF
4896:         CATCH TO loc_oErro
4897:             MsgErro(loc_oErro.Message, "Erro ao validar grupo")
4898:         ENDTRY
4899:     ENDPROC
4900: 
4901:     *-- SubGrupo (SigCdPsg: Codigos / Descricaos, filtrado por CGrus)
4902:     PROCEDURE CSGruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4903:         TRY
4904:             IF par_nKeyCode = 115
4905:                 THIS.AbrirLookupCSGru()
4906:             ELSE
4907:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
4908:                 THIS.ValidarCSGruDados()
4909:                 ENDIF
4910:             ENDIF
4911:         CATCH TO loc_oErro
4912:             *-- Tolerado
4913:         ENDTRY
4914:     ENDPROC
4915: 
4916:     PROCEDURE CSGruDblClick()
4917:         THIS.AbrirLookupCSGru()
4918:     ENDPROC
4919: 
4920:     PROTECTED PROCEDURE AbrirLookupCSGru()
4921:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao
4922:         LOCAL loc_cCodGru, loc_cSQL, loc_nRet, loc_oErro
4923:         TRY
4924:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
4925:                 RETURN
4926:             ENDIF
4927:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
4928:             IF !loc_oPgDados.txt_4c_CSGru.Enabled
4929:                 RETURN
4930:             ENDIF
4931:             *-- Montar cursor filtrado por grupo (como no legado)
4932:             loc_cCodGru = ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value)
4933:             IF USED("cursor_4c_BuscaCSGru")
4934:                 USE IN cursor_4c_BuscaCSGru
4935:             ENDIF
4936:             IF EMPTY(loc_cCodGru)
4937:                 loc_cSQL = "SELECT Codigos, Descricaos FROM SigCdPsg ORDER BY Codigos"
4938:             ELSE
4939:                 loc_cSQL = "SELECT Codigos, Descricaos FROM SigCdPsg " + ;
4940:                            "WHERE CGrus = " + EscaparSQL(PADR(loc_cCodGru, 10)) + ;
4941:                            " ORDER BY Codigos"
4942:             ENDIF
4943:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCSGru")
4944:             IF loc_nRet < 1 OR RECCOUNT("cursor_4c_BuscaCSGru") = 0
4945:                 IF USED("cursor_4c_BuscaCSGru")
4946:                     USE IN cursor_4c_BuscaCSGru
4947:                 ENDIF
4948:                 *-- Sem filtro de grupo
4949:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4950:                     "SELECT Codigos, Descricaos FROM SigCdPsg ORDER BY Codigos", ;
4951:                     "cursor_4c_BuscaCSGru")
4952:             ENDIF
4953:             IF loc_nRet < 1
4954:                 MsgErro("Erro ao carregar subgrupos.", "Erro")
4955:                 RETURN
4956:             ENDIF
4957:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPsg", ;
4958:                 "cursor_4c_BuscaCSGru2", "Codigos", ;
4959:                 ALLTRIM(loc_oPgDados.txt_4c_CSGru.Value), ;
4960:                 "Subgrupo")
4961:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
4962:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
4963:             loc_oBusca.Show()
4964:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCSGru2")
4965:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCSGru2.Codigos)
4966:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaCSGru2.Descricaos)
4967:                 loc_oPgDados.txt_4c_CSGru.Value = loc_cCodigo
4968:                 loc_oPgDados.txt_4c_DsGru.Value = loc_cDescricao
4969:             ENDIF
4970:             IF USED("cursor_4c_BuscaCSGru")
4971:                 USE IN cursor_4c_BuscaCSGru
4972:             ENDIF
4973:             IF USED("cursor_4c_BuscaCSGru2")
4974:                 USE IN cursor_4c_BuscaCSGru2
4975:             ENDIF
4976:             loc_oBusca.Release()
4977:         CATCH TO loc_oErro
4978:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup subgrupo")
4979:         ENDTRY
4980:     ENDPROC
4981: 
4982:     PROTECTED PROCEDURE ValidarCSGruDados()
4983:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
4984:         TRY
4985:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
4986:                 RETURN
4987:             ENDIF
4988:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
4989:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_CSGru.Value)
4990:             IF EMPTY(loc_cCod)
4991:                 loc_oPgDados.txt_4c_DsGru.Value = ""
4992:                 RETURN
4993:             ENDIF
4994:             loc_nRet = SQLEXEC(gnConnHandle, ;
4995:                 "SELECT Descricaos FROM SigCdPsg WHERE Codigos = " + ;
4996:                 EscaparSQL(PADR(loc_cCod, 10)), ;
4997:                 "cursor_4c_ValCSGru")
4998:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValCSGru") > 0
4999:                 SELECT cursor_4c_ValCSGru
5000:                 loc_oPgDados.txt_4c_DsGru.Value = ALLTRIM(Descricaos)
5001:             ELSE
5002:                 loc_oPgDados.txt_4c_CSGru.Value = ""
5003:                 loc_oPgDados.txt_4c_DsGru.Value = ""
5004:             ENDIF
5005:             IF USED("cursor_4c_ValCSGru")
5006:                 USE IN cursor_4c_ValCSGru
5007:             ENDIF
5008:         CATCH TO loc_oErro
5009:             MsgErro(loc_oErro.Message, "Erro ao validar subgrupo")
5010:         ENDTRY
5011:     ENDPROC
5012: 
5013:     *-- Linha (SigCdLin: Linhas / Descs)
5014:     PROCEDURE LinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5015:         TRY
5016:             IF par_nKeyCode = 115
5017:                 THIS.AbrirLookupLin()
5018:             ELSE
5019:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
5020:                 THIS.ValidarLinDados()
5021:                 ENDIF
5022:             ENDIF
5023:         CATCH TO loc_oErro
5024:             *-- Tolerado
5025:         ENDTRY
5026:     ENDPROC
5027: 
5028:     PROCEDURE LinDblClick()
5029:         THIS.AbrirLookupLin()
5030:     ENDPROC
5031: 
5032:     PROTECTED PROCEDURE AbrirLookupLin()
5033:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao, loc_oErro
5034:         TRY
5035:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5036:                 RETURN
5037:             ENDIF
5038:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5039:             IF !loc_oPgDados.txt_4c_Lin.Enabled
5040:                 RETURN
5041:             ENDIF
5042:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLin", ;
5043:                 "cursor_4c_BuscaLin", "Linhas", ;
5044:                 ALLTRIM(loc_oPgDados.txt_4c_Lin.Value), ;
5045:                 "Linha")
5046:             loc_oBusca.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
5047:             loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
5048:             loc_oBusca.Show()
5049:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
5050:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaLin.Linhas)
5051:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaLin.Descs)
5052:                 loc_oPgDados.txt_4c_Lin.Value  = loc_cCodigo
5053:                 loc_oPgDados.txt_4c_DLin.Value = loc_cDescricao
5054:             ENDIF
5055:             IF USED("cursor_4c_BuscaLin")
5056:                 USE IN cursor_4c_BuscaLin
5057:             ENDIF
5058:             loc_oBusca.Release()
5059:         CATCH TO loc_oErro
5060:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup linha")
5061:         ENDTRY
5062:     ENDPROC
5063: 
5064:     PROTECTED PROCEDURE ValidarLinDados()
5065:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5066:         TRY
5067:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5068:                 RETURN
5069:             ENDIF
5070:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5071:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_Lin.Value)
5072:             IF EMPTY(loc_cCod)
5073:                 loc_oPgDados.txt_4c_DLin.Value = ""
5074:                 RETURN
5075:             ENDIF
5076:             loc_nRet = SQLEXEC(gnConnHandle, ;
5077:                 "SELECT Descs FROM SigCdLin WHERE Linhas = " + ;
5078:                 EscaparSQL(PADR(loc_cCod, 10)), ;
5079:                 "cursor_4c_ValLin")
5080:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValLin") > 0
5081:                 SELECT cursor_4c_ValLin
5082:                 loc_oPgDados.txt_4c_DLin.Value = ALLTRIM(Descs)
5083:             ELSE
5084:                 loc_oPgDados.txt_4c_Lin.Value  = ""
5085:                 loc_oPgDados.txt_4c_DLin.Value = ""
5086:             ENDIF
5087:             IF USED("cursor_4c_ValLin")
5088:                 USE IN cursor_4c_ValLin
5089:             ENDIF
5090:         CATCH TO loc_oErro
5091:             MsgErro(loc_oErro.Message, "Erro ao validar linha")
5092:         ENDTRY
5093:     ENDPROC
5094: 
5095:     *-- Colecao / Grupo de Venda (SigCdCol: Colecoes / Descs)
5096:     PROCEDURE ColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5097:         TRY
5098:             IF par_nKeyCode = 115
5099:                 THIS.AbrirLookupCol()
5100:             ELSE
5101:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
5102:                 THIS.ValidarColDados()
5103:                 ENDIF
5104:             ENDIF
5105:         CATCH TO loc_oErro
5106:             *-- Tolerado
5107:         ENDTRY
5108:     ENDPROC
5109: 
5110:     PROCEDURE ColDblClick()
5111:         THIS.AbrirLookupCol()
5112:     ENDPROC
5113: 
5114:     PROTECTED PROCEDURE AbrirLookupCol()
5115:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao, loc_oErro
5116:         TRY
5117:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5118:                 RETURN
5119:             ENDIF
5120:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5121:             IF !loc_oPgDados.txt_4c_Col.Enabled
5122:                 RETURN
5123:             ENDIF
5124:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", ;
5125:                 "cursor_4c_BuscaCol", "Colecoes", ;
5126:                 ALLTRIM(loc_oPgDados.txt_4c_Col.Value), ;
5127:                 "Grupo de Venda")
5128:             loc_oBusca.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
5129:             loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
5130:             loc_oBusca.Show()
5131:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCol")
5132:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
5133:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaCol.Descs)
5134:                 loc_oPgDados.txt_4c_Col.Value  = loc_cCodigo
5135:                 loc_oPgDados.txt_4c_DCol.Value = loc_cDescricao
5136:             ENDIF
5137:             IF USED("cursor_4c_BuscaCol")
5138:                 USE IN cursor_4c_BuscaCol
5139:             ENDIF
5140:             loc_oBusca.Release()
5141:         CATCH TO loc_oErro
5142:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup grupo de venda")
5143:         ENDTRY
5144:     ENDPROC
5145: 
5146:     PROTECTED PROCEDURE ValidarColDados()
5147:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5148:         TRY
5149:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5150:                 RETURN
5151:             ENDIF
5152:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5153:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_Col.Value)
5154:             IF EMPTY(loc_cCod)
5155:                 loc_oPgDados.txt_4c_DCol.Value = ""
5156:                 RETURN
5157:             ENDIF
5158:             loc_nRet = SQLEXEC(gnConnHandle, ;
5159:                 "SELECT Descs FROM SigCdCol WHERE Colecoes = " + ;
5160:                 EscaparSQL(PADR(loc_cCod, 10)), ;
5161:                 "cursor_4c_ValCol")
5162:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValCol") > 0
5163:                 SELECT cursor_4c_ValCol
5164:                 loc_oPgDados.txt_4c_DCol.Value = ALLTRIM(Descs)
5165:             ELSE
5166:                 loc_oPgDados.txt_4c_Col.Value  = ""
5167:                 loc_oPgDados.txt_4c_DCol.Value = ""
5168:             ENDIF
5169:             IF USED("cursor_4c_ValCol")
5170:                 USE IN cursor_4c_ValCol
5171:             ENDIF
5172:         CATCH TO loc_oErro
5173:             MsgErro(loc_oErro.Message, "Erro ao validar grupo de venda")
5174:         ENDTRY
5175:     ENDPROC
5176: 
5177:     *-- Fornecedor (SigCdCli: IClis / RClis)
5178:     PROCEDURE IforKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5179:         TRY
5180:             IF par_nKeyCode = 115
5181:                 THIS.AbrirLookupIfor()
5182:             ELSE
5183:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
5184:                 THIS.ValidarIforDados()
5185:                 ENDIF
5186:             ENDIF
5187:         CATCH TO loc_oErro
5188:             *-- Tolerado
5189:         ENDTRY
5190:     ENDPROC
5191: 
5192:     PROCEDURE BtnFornecedorClick()
5193:         THIS.AbrirLookupIfor()
5194:     ENDPROC
5195: 
5196:     PROTECTED PROCEDURE AbrirLookupIfor()
5197:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao, loc_oErro
5198:         TRY
5199:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5200:                 RETURN
5201:             ENDIF
5202:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5203:             IF !loc_oPgDados.txt_4c_Ifor.Enabled
5204:                 RETURN
5205:             ENDIF
5206:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
5207:                 "cursor_4c_BuscaIfor", "IClis", ;
5208:                 ALLTRIM(loc_oPgDados.txt_4c_Ifor.Value), ;
5209:                 "Fornecedor")
5210:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
5211:             loc_oBusca.mAddColuna("RClis", "", "Nome")
5212:             loc_oBusca.Show()
5213:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIfor")
5214:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaIfor.IClis)
5215:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaIfor.RClis)
5216:                 loc_oPgDados.txt_4c_Ifor.Value = loc_cCodigo
5217:                 loc_oPgDados.txt_4c_Dfor.Value = loc_cDescricao
5218:             ENDIF
5219:             IF USED("cursor_4c_BuscaIfor")
5220:                 USE IN cursor_4c_BuscaIfor
5221:             ENDIF
5222:             loc_oBusca.Release()
5223:         CATCH TO loc_oErro
5224:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup fornecedor")
5225:         ENDTRY
5226:     ENDPROC
5227: 
5228:     PROTECTED PROCEDURE ValidarIforDados()
5229:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5230:         TRY
5231:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5232:                 RETURN
5233:             ENDIF
5234:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5235:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_Ifor.Value)
5236:             IF EMPTY(loc_cCod)
5237:                 loc_oPgDados.txt_4c_Dfor.Value = ""
5238:                 RETURN
5239:             ENDIF
5240:             loc_nRet = SQLEXEC(gnConnHandle, ;
5241:                 "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
5242:                 EscaparSQL(PADR(loc_cCod, 10)), ;
5243:                 "cursor_4c_ValIfor")
5244:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValIfor") > 0
5245:                 SELECT cursor_4c_ValIfor
5246:                 loc_oPgDados.txt_4c_Dfor.Value = ALLTRIM(RClis)
5247:             ELSE
5248:                 loc_oPgDados.txt_4c_Ifor.Value = ""
5249:                 loc_oPgDados.txt_4c_Dfor.Value = ""
5250:             ENDIF
5251:             IF USED("cursor_4c_ValIfor")
5252:                 USE IN cursor_4c_ValIfor
5253:             ENDIF
5254:         CATCH TO loc_oErro
5255:             MsgErro(loc_oErro.Message, "Erro ao validar fornecedor")
5256:         ENDTRY
5257:     ENDPROC
5258: 
5259:     *-- Cor (SigCdCor: Cods / Descs)
5260:     PROCEDURE CorProKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5261:         TRY
5262:             IF par_nKeyCode = 115
5263:                 THIS.AbrirLookupCorPro()
5264:             ENDIF
5265:         CATCH TO loc_oErro
5266:             *-- Tolerado
5267:         ENDTRY
5268:     ENDPROC
5269: 
5270:     PROCEDURE CorProDblClick()
5271:         THIS.AbrirLookupCorPro()
5272:     ENDPROC
5273: 
5274:     PROTECTED PROCEDURE AbrirLookupCorPro()
5275:         LOCAL loc_oBusca, loc_oPgDados, loc_oErro
5276:         TRY
5277:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5278:                 RETURN
5279:             ENDIF
5280:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5281:             IF !loc_oPgDados.txt_4c_CorPro.Enabled
5282:                 RETURN
5283:             ENDIF
5284:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCor", ;
5285:                 "cursor_4c_BuscaCor", "Cods", ;
5286:                 ALLTRIM(loc_oPgDados.txt_4c_CorPro.Value), ;
5287:                 "Cor")
5288:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
5289:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
5290:             loc_oBusca.Show()
5291:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
5292:                 loc_oPgDados.txt_4c_CorPro.Value = ALLTRIM(cursor_4c_BuscaCor.Cods)
5293:             ENDIF
5294:             IF USED("cursor_4c_BuscaCor")
5295:                 USE IN cursor_4c_BuscaCor
5296:             ENDIF
5297:             loc_oBusca.Release()
5298:         CATCH TO loc_oErro
5299:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup cor")
5300:         ENDTRY
5301:     ENDPROC
5302: 
5303:     *-- Tamanho (SigCdTam: Cods / Descs)
5304:     PROCEDURE TamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5305:         TRY
5306:             IF par_nKeyCode = 115
5307:                 THIS.AbrirLookupTam()
5308:             ENDIF
5309:         CATCH TO loc_oErro
5310:             *-- Tolerado
5311:         ENDTRY
5312:     ENDPROC
5313: 
5314:     PROCEDURE TamDblClick()
5315:         THIS.AbrirLookupTam()
5316:     ENDPROC
5317: 
5318:     PROTECTED PROCEDURE AbrirLookupTam()
5319:         LOCAL loc_oBusca, loc_oPgDados, loc_oErro
5320:         TRY
5321:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5322:                 RETURN
5323:             ENDIF
5324:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5325:             IF !loc_oPgDados.txt_4c_Tam.Enabled
5326:                 RETURN
5327:             ENDIF
5328:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", ;
5329:                 "cursor_4c_BuscaTam", "Cods", ;
5330:                 ALLTRIM(loc_oPgDados.txt_4c_Tam.Value), ;
5331:                 "Tamanho")
5332:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
5333:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
5334:             loc_oBusca.Show()
5335:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
5336:                 loc_oPgDados.txt_4c_Tam.Value = ALLTRIM(cursor_4c_BuscaTam.Cods)
5337:             ENDIF
5338:             IF USED("cursor_4c_BuscaTam")
5339:                 USE IN cursor_4c_BuscaTam
5340:             ENDIF
5341:             loc_oBusca.Release()
5342:         CATCH TO loc_oErro
5343:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup tamanho")
5344:         ENDTRY
5345:     ENDPROC
5346: 
5347:     *-- Finalidade (SigCdFip: Cods / Descs)
5348:     PROCEDURE CodFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5349:         TRY
5350:             IF par_nKeyCode = 115
5351:                 THIS.AbrirLookupCodFinP()
5352:             ELSE
5353:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
5354:                 THIS.ValidarCodFinPDados()
5355:                 ENDIF
5356:             ENDIF
5357:         CATCH TO loc_oErro
5358:             *-- Tolerado
5359:         ENDTRY
5360:     ENDPROC
5361: 
5362:     PROCEDURE CodFinPDblClick()
5363:         THIS.AbrirLookupCodFinP()
5364:     ENDPROC
5365: 
5366:     PROTECTED PROCEDURE AbrirLookupCodFinP()
5367:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao, loc_oErro
5368:         TRY
5369:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5370:                 RETURN
5371:             ENDIF
5372:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5373:             IF !loc_oPgDados.txt_4c_CodFinP.Enabled
5374:                 RETURN
5375:             ENDIF
5376:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdFip", ;
5377:                 "cursor_4c_BuscaFinP", "Cods", ;
5378:                 ALLTRIM(loc_oPgDados.txt_4c_CodFinP.Value), ;
5379:                 "Finalidade")
5380:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
5381:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
5382:             loc_oBusca.Show()
5383:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFinP")
5384:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaFinP.Cods)
5385:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaFinP.Descs)
5386:                 loc_oPgDados.txt_4c_CodFinP.Value = loc_cCodigo
5387:                 loc_oPgDados.txt_4c_DesFinP.Value = loc_cDescricao
5388:             ENDIF
5389:             IF USED("cursor_4c_BuscaFinP")
5390:                 USE IN cursor_4c_BuscaFinP
5391:             ENDIF
5392:             loc_oBusca.Release()
5393:         CATCH TO loc_oErro
5394:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup finalidade")
5395:         ENDTRY
5396:     ENDPROC
5397: 
5398:     PROTECTED PROCEDURE ValidarCodFinPDados()
5399:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5400:         TRY
5401:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5402:                 RETURN
5403:             ENDIF
5404:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5405:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_CodFinP.Value)
5406:             IF EMPTY(loc_cCod)
5407:                 loc_oPgDados.txt_4c_DesFinP.Value = ""
5408:                 RETURN
5409:             ENDIF
5410:             loc_nRet = SQLEXEC(gnConnHandle, ;
5411:                 "SELECT Descs FROM SigCdFip WHERE Cods = " + ;
5412:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5413:                 "cursor_4c_ValFinP")
5414:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValFinP") > 0
5415:                 SELECT cursor_4c_ValFinP
5416:                 loc_oPgDados.txt_4c_DesFinP.Value = ALLTRIM(Descs)
5417:             ELSE
5418:                 loc_oPgDados.txt_4c_CodFinP.Value = ""
5419:                 loc_oPgDados.txt_4c_DesFinP.Value = ""
5420:             ENDIF
5421:             IF USED("cursor_4c_ValFinP")
5422:                 USE IN cursor_4c_ValFinP
5423:             ENDIF
5424:         CATCH TO loc_oErro
5425:             MsgErro(loc_oErro.Message, "Erro ao validar finalidade")
5426:         ENDTRY
5427:     ENDPROC
5428: 
5429:     *-- Acabamento (SigCdAca: Cods / Descrs)
5430:     PROCEDURE CodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5431:         TRY
5432:             IF par_nKeyCode = 115
5433:                 THIS.AbrirLookupCodAcb()
5434:             ELSE
5435:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
5436:                 THIS.ValidarCodAcbDados()
5437:                 ENDIF
5438:             ENDIF
5439:         CATCH TO loc_oErro
5440:             *-- Tolerado
5441:         ENDTRY
5442:     ENDPROC
5443: 
5444:     PROCEDURE CodAcbDblClick()
5445:         THIS.AbrirLookupCodAcb()
5446:     ENDPROC
5447: 
5448:     PROTECTED PROCEDURE AbrirLookupCodAcb()
5449:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao, loc_oErro
5450:         TRY
5451:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5452:                 RETURN
5453:             ENDIF
5454:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5455:             IF !loc_oPgDados.txt_4c_CodAcb.Enabled
5456:                 RETURN
5457:             ENDIF
5458:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdAca", ;
5459:                 "cursor_4c_BuscaAcb", "Cods", ;
5460:                 ALLTRIM(loc_oPgDados.txt_4c_CodAcb.Value), ;
5461:                 "Acabamento")
5462:             loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "digo")
5463:             loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
5464:             loc_oBusca.Show()
5465:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAcb")
5466:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaAcb.Cods)
5467:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaAcb.Descrs)
5468:                 loc_oPgDados.txt_4c_CodAcb.Value = loc_cCodigo
5469:                 loc_oPgDados.txt_4c_DesAcb.Value = loc_cDescricao
5470:             ENDIF
5471:             IF USED("cursor_4c_BuscaAcb")
5472:                 USE IN cursor_4c_BuscaAcb
5473:             ENDIF
5474:             loc_oBusca.Release()
5475:         CATCH TO loc_oErro
5476:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup acabamento")
5477:         ENDTRY
5478:     ENDPROC
5479: 
5480:     PROTECTED PROCEDURE ValidarCodAcbDados()
5481:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5482:         TRY
5483:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5484:                 RETURN
5485:             ENDIF
5486:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5487:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_CodAcb.Value)
5488:             IF EMPTY(loc_cCod)
5489:                 loc_oPgDados.txt_4c_DesAcb.Value = ""
5490:                 RETURN
5491:             ENDIF
5492:             loc_nRet = SQLEXEC(gnConnHandle, ;
5493:                 "SELECT Descrs FROM SigCdAca WHERE Cods = " + ;
5494:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5495:                 "cursor_4c_ValAcb")
5496:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValAcb") > 0
5497:                 SELECT cursor_4c_ValAcb
5498:                 loc_oPgDados.txt_4c_DesAcb.Value = ALLTRIM(Descrs)
5499:             ELSE
5500:                 loc_oPgDados.txt_4c_CodAcb.Value = ""
5501:                 loc_oPgDados.txt_4c_DesAcb.Value = ""
5502:             ENDIF
5503:             IF USED("cursor_4c_ValAcb")
5504:                 USE IN cursor_4c_ValAcb
5505:             ENDIF
5506:         CATCH TO loc_oErro
5507:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
5508:         ENDTRY
5509:     ENDPROC
5510: 
5511:     *-- Classificacao (SigCdCls: Cods / Descs, filtrado por CGrus)
5512:     PROCEDURE ClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5513:         TRY
5514:             IF par_nKeyCode = 115
5515:                 THIS.AbrirLookupClass()
5516:             ELSE
5517:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
5518:                 THIS.ValidarClassDados()
5519:                 ENDIF
5520:             ENDIF
5521:         CATCH TO loc_oErro
5522:             *-- Tolerado
5523:         ENDTRY
5524:     ENDPROC
5525: 
5526:     PROCEDURE ClassDblClick()
5527:         THIS.AbrirLookupClass()
5528:     ENDPROC
5529: 
5530:     PROTECTED PROCEDURE AbrirLookupClass()
5531:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao
5532:         LOCAL loc_cCodGru, loc_cSQL, loc_oErro
5533:         TRY
5534:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5535:                 RETURN
5536:             ENDIF
5537:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5538:             IF !loc_oPgDados.txt_4c_Class.Enabled
5539:                 RETURN
5540:             ENDIF
5541:             loc_cCodGru = ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value)
5542:             IF !EMPTY(loc_cCodGru)
5543:                 loc_cSQL = "SELECT Cods, Descs FROM SigCdCls " + ;
5544:                            "WHERE CGrus IN (" + EscaparSQL(PADR(loc_cCodGru, 10)) + ;
5545:                            ", '          ') ORDER BY Cods"
5546:             ELSE
5547:                 loc_cSQL = "SELECT Cods, Descs FROM SigCdCls ORDER BY Cods"
5548:             ENDIF
5549:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCls", ;
5550:                 "cursor_4c_BuscaClass", "Cods", ;
5551:                 ALLTRIM(loc_oPgDados.txt_4c_Class.Value), ;
5552:                 "Classifica" + CHR(231) + CHR(227) + "o")
5553:             loc_oBusca.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
5554:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
5555:             loc_oBusca.Show()
5556:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClass")
5557:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaClass.Cods)
5558:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaClass.Descs)
5559:                 loc_oPgDados.txt_4c_Class.Value  = loc_cCodigo
5560:                 loc_oPgDados.txt_4c_DClass.Value = loc_cDescricao
5561:             ENDIF
5562:             IF USED("cursor_4c_BuscaClass")
5563:                 USE IN cursor_4c_BuscaClass
5564:             ENDIF
5565:             loc_oBusca.Release()
5566:         CATCH TO loc_oErro
5567:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup classifica" + CHR(231) + CHR(227) + "o")
5568:         ENDTRY
5569:     ENDPROC
5570: 
5571:     PROTECTED PROCEDURE ValidarClassDados()
5572:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5573:         TRY
5574:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5575:                 RETURN
5576:             ENDIF
5577:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5578:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_Class.Value)
5579:             IF EMPTY(loc_cCod)
5580:                 loc_oPgDados.txt_4c_DClass.Value = ""
5581:                 RETURN
5582:             ENDIF
5583:             loc_nRet = SQLEXEC(gnConnHandle, ;
5584:                 "SELECT Descs FROM SigCdCls WHERE Cods = " + ;
5585:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5586:                 "cursor_4c_ValClass")
5587:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValClass") > 0
5588:                 SELECT cursor_4c_ValClass
5589:                 loc_oPgDados.txt_4c_DClass.Value = ALLTRIM(Descs)
5590:             ELSE
5591:                 loc_oPgDados.txt_4c_Class.Value  = ""
5592:                 loc_oPgDados.txt_4c_DClass.Value = ""
5593:             ENDIF
5594:             IF USED("cursor_4c_ValClass")
5595:                 USE IN cursor_4c_ValClass
5596:             ENDIF
5597:         CATCH TO loc_oErro
5598:             MsgErro(loc_oErro.Message, "Erro ao validar classifica" + CHR(231) + CHR(227) + "o")
5599:         ENDTRY
5600:     ENDPROC
5601: 
5602:     *-- Local (SigPrLcl: Codigos / Descricaos)
5603:     PROCEDURE LocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5604:         TRY
5605:             IF par_nKeyCode = 115
5606:                 THIS.AbrirLookupLocal()
5607:             ENDIF
5608:         CATCH TO loc_oErro
5609:             *-- Tolerado
5610:         ENDTRY
5611:     ENDPROC
5612: 
5613:     PROCEDURE LocalDblClick()
5614:         THIS.AbrirLookupLocal()
5615:     ENDPROC
5616: 
5617:     PROTECTED PROCEDURE AbrirLookupLocal()
5618:         LOCAL loc_oBusca, loc_oPgDados, loc_oErro
5619:         TRY
5620:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5621:                 RETURN
5622:             ENDIF
5623:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5624:             IF !loc_oPgDados.txt_4c_Local.Enabled
5625:                 RETURN
5626:             ENDIF
5627:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrLcl", ;
5628:                 "cursor_4c_BuscaLocal", "Codigos", ;
5629:                 ALLTRIM(loc_oPgDados.txt_4c_Local.Value), ;
5630:                 "Localiza" + CHR(231) + CHR(227) + "o")
5631:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
5632:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
5633:             loc_oBusca.Show()
5634:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
5635:                 loc_oPgDados.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.Codigos)
5636:             ENDIF
5637:             IF USED("cursor_4c_BuscaLocal")
5638:                 USE IN cursor_4c_BuscaLocal
5639:             ENDIF
5640:             loc_oBusca.Release()
5641:         CATCH TO loc_oErro
5642:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup local")
5643:         ENDTRY
5644:     ENDPROC
5645: 
5646:     *-- Unidade 1 (SigCdUni: CUnis / DUnis)
5647:     PROCEDURE CuniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5648:         TRY
5649:             IF par_nKeyCode = 115
5650:                 THIS.AbrirLookupCuni()
5651:             ELSE
5652:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
5653:                 THIS.ValidarCuniDados()
5654:                 ENDIF
5655:             ENDIF
5656:         CATCH TO loc_oErro
5657:             *-- Tolerado
5658:         ENDTRY
5659:     ENDPROC
5660: 
5661:     PROCEDURE CuniDblClick()
5662:         THIS.AbrirLookupCuni()
5663:     ENDPROC
5664: 
5665:     PROTECTED PROCEDURE AbrirLookupCuni()
5666:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao, loc_oErro
5667:         TRY
5668:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5669:                 RETURN
5670:             ENDIF
5671:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5672:             IF !loc_oPgDados.txt_4c_Cuni.Enabled
5673:                 RETURN
5674:             ENDIF
5675:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUni", ;
5676:                 "cursor_4c_BuscaCuni", "CUnis", ;
5677:                 ALLTRIM(loc_oPgDados.txt_4c_Cuni.Value), ;
5678:                 "Unidade (1)")
5679:             loc_oBusca.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
5680:             loc_oBusca.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
5681:             loc_oBusca.Show()
5682:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCuni")
5683:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCuni.CUnis)
5684:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaCuni.DUnis)
5685:                 loc_oPgDados.txt_4c_Cuni.Value = loc_cCodigo
5686:                 loc_oPgDados.txt_4c_Duni.Value = loc_cDescricao
5687:             ENDIF
5688:             IF USED("cursor_4c_BuscaCuni")
5689:                 USE IN cursor_4c_BuscaCuni
5690:             ENDIF
5691:             loc_oBusca.Release()
5692:         CATCH TO loc_oErro
5693:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup unidade 1")
5694:         ENDTRY
5695:     ENDPROC
5696: 
5697:     PROTECTED PROCEDURE ValidarCuniDados()
5698:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5699:         TRY
5700:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5701:                 RETURN
5702:             ENDIF
5703:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5704:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_Cuni.Value)
5705:             IF EMPTY(loc_cCod)
5706:                 loc_oPgDados.txt_4c_Duni.Value = ""
5707:                 RETURN
5708:             ENDIF
5709:             loc_nRet = SQLEXEC(gnConnHandle, ;
5710:                 "SELECT DUnis FROM SigCdUni WHERE CUnis = " + ;
5711:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5712:                 "cursor_4c_ValCuni")
5713:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValCuni") > 0
5714:                 SELECT cursor_4c_ValCuni
5715:                 loc_oPgDados.txt_4c_Duni.Value = ALLTRIM(DUnis)
5716:             ELSE
5717:                 loc_oPgDados.txt_4c_Cuni.Value = ""
5718:                 loc_oPgDados.txt_4c_Duni.Value = ""
5719:             ENDIF
5720:             IF USED("cursor_4c_ValCuni")
5721:                 USE IN cursor_4c_ValCuni
5722:             ENDIF
5723:         CATCH TO loc_oErro
5724:             MsgErro(loc_oErro.Message, "Erro ao validar unidade 1")
5725:         ENDTRY
5726:     ENDPROC
5727: 
5728:     *-- Unidade 2 (SigCdUni: CUnis / DUnis)
5729:     PROCEDURE CunipKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5730:         TRY
5731:             IF par_nKeyCode = 115
5732:                 THIS.AbrirLookupCunip()
5733:             ELSE
5734:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
5735:                 THIS.ValidarCunipDados()
5736:                 ENDIF
5737:             ENDIF
5738:         CATCH TO loc_oErro
5739:             *-- Tolerado
5740:         ENDTRY
5741:     ENDPROC
5742: 
5743:     PROCEDURE CunipDblClick()
5744:         THIS.AbrirLookupCunip()
5745:     ENDPROC
5746: 
5747:     PROTECTED PROCEDURE AbrirLookupCunip()
5748:         LOCAL loc_oBusca, loc_oPgDados, loc_cCodigo, loc_cDescricao, loc_oErro
5749:         TRY
5750:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5751:                 RETURN
5752:             ENDIF
5753:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5754:             IF !loc_oPgDados.txt_4c_Cunip.Enabled
5755:                 RETURN
5756:             ENDIF
5757:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUni", ;
5758:                 "cursor_4c_BuscaCunip", "CUnis", ;
5759:                 ALLTRIM(loc_oPgDados.txt_4c_Cunip.Value), ;
5760:                 "Unidade (2)")
5761:             loc_oBusca.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
5762:             loc_oBusca.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
5763:             loc_oBusca.Show()
5764:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCunip")
5765:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCunip.CUnis)
5766:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaCunip.DUnis)
5767:                 loc_oPgDados.txt_4c_Cunip.Value = loc_cCodigo
5768:                 loc_oPgDados.txt_4c_Dunip.Value = loc_cDescricao
5769:             ENDIF
5770:             IF USED("cursor_4c_BuscaCunip")
5771:                 USE IN cursor_4c_BuscaCunip
5772:             ENDIF
5773:             loc_oBusca.Release()
5774:         CATCH TO loc_oErro
5775:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup unidade 2")
5776:         ENDTRY
5777:     ENDPROC
5778: 
5779:     PROTECTED PROCEDURE ValidarCunipDados()
5780:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5781:         TRY
5782:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
5783:                 RETURN
5784:             ENDIF
5785:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
5786:             loc_cCod = ALLTRIM(loc_oPgDados.txt_4c_Cunip.Value)
5787:             IF EMPTY(loc_cCod)
5788:                 loc_oPgDados.txt_4c_Dunip.Value = ""
5789:                 RETURN
5790:             ENDIF
5791:             loc_nRet = SQLEXEC(gnConnHandle, ;
5792:                 "SELECT DUnis FROM SigCdUni WHERE CUnis = " + ;
5793:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5794:                 "cursor_4c_ValCunip")
5795:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValCunip") > 0
5796:                 SELECT cursor_4c_ValCunip
5797:                 loc_oPgDados.txt_4c_Dunip.Value = ALLTRIM(DUnis)
5798:             ELSE
5799:                 loc_oPgDados.txt_4c_Cunip.Value = ""
5800:                 loc_oPgDados.txt_4c_Dunip.Value = ""
5801:             ENDIF
5802:             IF USED("cursor_4c_ValCunip")
5803:                 USE IN cursor_4c_ValCunip
5804:             ENDIF
5805:         CATCH TO loc_oErro
5806:             MsgErro(loc_oErro.Message, "Erro ao validar unidade 2")
5807:         ENDTRY
5808:     ENDPROC
5809: 
5810:     *==========================================================================
5811:     * ConfigurarPgpgComposicao - Aba Composicao (Page2 do inner PageFrame)
5812:     * Posicoes: original_top + 29 (inner PageFrame em Page2 outer -> +29)
5813:     *==========================================================================
5814:     PROTECTED PROCEDURE ConfigurarPgpgComposicao(par_oPage)
5815:         LOCAL loc_oErro
5816:         TRY
5817:             *-- === Cursores placeholder ANTES dos grids ===
5818:             SET NULL ON
5819:             IF USED("cursor_4c_Compo")
5820:                 USE IN cursor_4c_Compo
5821:             ENDIF
5822:             CREATE CURSOR cursor_4c_Compo (;
5823:                 Mats     C(14)    NULL, ;
5824:                 DPros    C(40)    NULL, ;
5825:                 Unisp    C(5)     NULL, ;
5826:                 Vals     N(15,6)  NULL, ;
5827:                 Qtds     N(15,6)  NULL, ;
5828:                 Totals   N(15,6)  NULL, ;
5829:                 Moedas   C(10)    NULL, ;
5830:                 Obss     C(50)    NULL, ;
5831:                 Es       C(10)    NULL, ;
5832:                 Conss    N(15,6)  NULL, ;
5833:                 Qtdss    N(15,6)  NULL, ;
5834:                 Unis     C(5)     NULL, ;
5835:                 Ords     N(5,0)   NULL, ;
5836:                 Bloqueio C(14)    NULL  ;
5837:             )
5838:             IF USED("cursor_4c_SubCp")
5839:                 USE IN cursor_4c_SubCp
5840:             ENDIF
5841:             CREATE CURSOR cursor_4c_SubCp (;
5842:                 Mats     C(14)    NULL, ;
5843:                 DPros    C(40)    NULL, ;
5844:                 Unisp    C(5)     NULL, ;
5845:                 Vals     N(15,6)  NULL, ;
5846:                 Qtds     N(15,6)  NULL, ;
5847:                 Totals   N(15,6)  NULL, ;
5848:                 Moedas   C(10)    NULL, ;
5849:                 Obss     C(50)    NULL, ;
5850:                 Es       C(10)    NULL, ;
5851:                 Conss    N(15,6)  NULL, ;
5852:                 Qtdss    N(15,6)  NULL, ;
5853:                 Unis     C(5)     NULL, ;
5854:                 Ords     N(5,0)   NULL, ;
5855:                 Bloqueio C(14)    NULL, ;
5856:                 Tams     C(10)    NULL  ;
5857:             )
5858:             IF USED("cursor_4c_GrupoCompo")
5859:                 USE IN cursor_4c_GrupoCompo
5860:             ENDIF
5861:             CREATE CURSOR cursor_4c_GrupoCompo (;
5862:                 CGrus  C(10)   NULL, ;
5863:                 Totals N(15,6) NULL, ;
5864:                 Moedas C(10)   NULL  ;
5865:             )
5866:             SET NULL OFF
5867: 
5868:             *-- === Obs. da OF (getObsOFs) - top=297+29=326 ===
5869:             par_oPage.AddObject("lbl_4c_LblObsOF", "Label")
5870:             WITH par_oPage.lbl_4c_LblObsOF
5871:                 .Top       = 329
5872:                 .Left      = 36
5873:                 .Width     = 64
5874:                 .Height    = 15
5875:                 .FontName  = "Tahoma"
5876:                 .FontSize  = 8

*-- Linhas 5959 a 5992:
5959:             par_oPage.grd_4c_Grupo.ReadOnly    = .T.
5960:             par_oPage.grd_4c_Grupo.ScrollBars  = 2
5961:             par_oPage.grd_4c_Grupo.Themes      = .F.
5962:             par_oPage.grd_4c_Grupo.Visible     = .T.
5963: 
5964:             par_oPage.grd_4c_Grupo.RecordSource = "cursor_4c_GrupoCompo"
5965: 
5966:             par_oPage.grd_4c_Grupo.Column1.Header1.Caption  = "Grupo"
5967:             par_oPage.grd_4c_Grupo.Column1.ControlSource    = "cursor_4c_GrupoCompo.CGrus"
5968:             par_oPage.grd_4c_Grupo.Column1.Width            = 60
5969:             par_oPage.grd_4c_Grupo.Column1.Header1.FontBold = .T.
5970: 
5971:             par_oPage.grd_4c_Grupo.Column2.Header1.Caption  = "Total"
5972:             par_oPage.grd_4c_Grupo.Column2.ControlSource    = "cursor_4c_GrupoCompo.Totals"
5973:             par_oPage.grd_4c_Grupo.Column2.Width            = 90
5974:             par_oPage.grd_4c_Grupo.Column2.Header1.FontBold = .T.
5975: 
5976:             par_oPage.grd_4c_Grupo.Column3.Header1.Caption  = "Moeda"
5977:             par_oPage.grd_4c_Grupo.Column3.ControlSource    = "cursor_4c_GrupoCompo.Moedas"
5978:             par_oPage.grd_4c_Grupo.Column3.Width            = 65
5979:             par_oPage.grd_4c_Grupo.Column3.Header1.FontBold = .T.
5980: 
5981:             *-- === grdCompo (composicao principal) - top=148+29=177 ===
5982:             par_oPage.AddObject("grd_4c_Compo", "Grid")
5983:             par_oPage.grd_4c_Compo.Top         = 177
5984:             par_oPage.grd_4c_Compo.Left        = 6
5985:             par_oPage.grd_4c_Compo.Width       = 943
5986:             par_oPage.grd_4c_Compo.Height      = 147
5987:             par_oPage.grd_4c_Compo.ColumnCount = 14
5988:             par_oPage.grd_4c_Compo.FontName    = "Tahoma"
5989:             par_oPage.grd_4c_Compo.FontSize    = 8
5990:             par_oPage.grd_4c_Compo.GridLines   = 3
5991:             par_oPage.grd_4c_Compo.DeleteMark  = .F.
5992:             par_oPage.grd_4c_Compo.RecordMark  = .F.

*-- Linhas 6204 a 6297:
6204:             par_oPage.grd_4c_SubCp.RowHeight   = 16
6205:             par_oPage.grd_4c_SubCp.ScrollBars  = 3
6206:             par_oPage.grd_4c_SubCp.Themes      = .F.
6207:             par_oPage.grd_4c_SubCp.Visible     = .T.
6208: 
6209:             par_oPage.grd_4c_SubCp.RecordSource = "cursor_4c_SubCp"
6210: 
6211:             par_oPage.grd_4c_SubCp.Column1.Header1.Caption  = "Material"
6212:             par_oPage.grd_4c_SubCp.Column1.ControlSource    = "cursor_4c_SubCp.Mats"
6213:             par_oPage.grd_4c_SubCp.Column1.Width            = 80
6214:             par_oPage.grd_4c_SubCp.Column1.Header1.FontBold = .T.
6215: 
6216:             par_oPage.grd_4c_SubCp.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
6217:             par_oPage.grd_4c_SubCp.Column2.ControlSource    = "cursor_4c_SubCp.DPros"
6218:             par_oPage.grd_4c_SubCp.Column2.Width            = 140
6219:             par_oPage.grd_4c_SubCp.Column2.Header1.FontBold = .T.
6220: 
6221:             par_oPage.grd_4c_SubCp.Column3.Header1.Caption  = "Un"
6222:             par_oPage.grd_4c_SubCp.Column3.ControlSource    = "cursor_4c_SubCp.Unisp"
6223:             par_oPage.grd_4c_SubCp.Column3.Width            = 30
6224:             par_oPage.grd_4c_SubCp.Column3.Header1.FontBold = .T.
6225: 
6226:             par_oPage.grd_4c_SubCp.Column4.Header1.Caption  = "Valor"
6227:             par_oPage.grd_4c_SubCp.Column4.ControlSource    = "cursor_4c_SubCp.Vals"
6228:             par_oPage.grd_4c_SubCp.Column4.Width            = 65
6229:             par_oPage.grd_4c_SubCp.Column4.Header1.FontBold = .T.
6230: 
6231:             par_oPage.grd_4c_SubCp.Column5.Header1.Caption  = "Qtde."
6232:             par_oPage.grd_4c_SubCp.Column5.ControlSource    = "cursor_4c_SubCp.Qtds"
6233:             par_oPage.grd_4c_SubCp.Column5.Width            = 60
6234:             par_oPage.grd_4c_SubCp.Column5.Header1.FontBold = .T.
6235: 
6236:             par_oPage.grd_4c_SubCp.Column6.Header1.Caption  = "Total"
6237:             par_oPage.grd_4c_SubCp.Column6.ControlSource    = "cursor_4c_SubCp.Totals"
6238:             par_oPage.grd_4c_SubCp.Column6.Width            = 65
6239:             par_oPage.grd_4c_SubCp.Column6.Header1.FontBold = .T.
6240: 
6241:             par_oPage.grd_4c_SubCp.Column7.Header1.Caption  = "Moe"
6242:             par_oPage.grd_4c_SubCp.Column7.ControlSource    = "cursor_4c_SubCp.Moedas"
6243:             par_oPage.grd_4c_SubCp.Column7.Width            = 30
6244:             par_oPage.grd_4c_SubCp.Column7.Header1.FontBold = .T.
6245: 
6246:             par_oPage.grd_4c_SubCp.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
6247:             par_oPage.grd_4c_SubCp.Column8.ControlSource    = "cursor_4c_SubCp.Obss"
6248:             par_oPage.grd_4c_SubCp.Column8.Width            = 90
6249:             par_oPage.grd_4c_SubCp.Column8.Header1.FontBold = .T.
6250: 
6251:             par_oPage.grd_4c_SubCp.Column9.Header1.Caption  = "E"
6252:             par_oPage.grd_4c_SubCp.Column9.ControlSource    = "cursor_4c_SubCp.Es"
6253:             par_oPage.grd_4c_SubCp.Column9.Width            = 20
6254:             par_oPage.grd_4c_SubCp.Column9.Header1.FontBold = .T.
6255: 
6256:             par_oPage.grd_4c_SubCp.Column10.Header1.Caption  = "Consumo"
6257:             par_oPage.grd_4c_SubCp.Column10.ControlSource    = "cursor_4c_SubCp.Conss"
6258:             par_oPage.grd_4c_SubCp.Column10.Width            = 60
6259:             par_oPage.grd_4c_SubCp.Column10.Header1.FontBold = .T.
6260: 
6261:             par_oPage.grd_4c_SubCp.Column11.Header1.Caption  = "Qtde."
6262:             par_oPage.grd_4c_SubCp.Column11.ControlSource    = "cursor_4c_SubCp.Qtdss"
6263:             par_oPage.grd_4c_SubCp.Column11.Width            = 60
6264:             par_oPage.grd_4c_SubCp.Column11.Header1.FontBold = .T.
6265: 
6266:             par_oPage.grd_4c_SubCp.Column12.Header1.Caption  = "Un"
6267:             par_oPage.grd_4c_SubCp.Column12.ControlSource    = "cursor_4c_SubCp.Unis"
6268:             par_oPage.grd_4c_SubCp.Column12.Width            = 30
6269:             par_oPage.grd_4c_SubCp.Column12.Header1.FontBold = .T.
6270: 
6271:             par_oPage.grd_4c_SubCp.Column13.Header1.Caption  = "Ord"
6272:             par_oPage.grd_4c_SubCp.Column13.ControlSource    = "cursor_4c_SubCp.Ords"
6273:             par_oPage.grd_4c_SubCp.Column13.Width            = 30
6274:             par_oPage.grd_4c_SubCp.Column13.Header1.FontBold = .T.
6275: 
6276:             par_oPage.grd_4c_SubCp.Column14.Header1.Caption  = "Bloqueio"
6277:             par_oPage.grd_4c_SubCp.Column14.ControlSource    = "cursor_4c_SubCp.Bloqueio"
6278:             par_oPage.grd_4c_SubCp.Column14.Width            = 75
6279:             par_oPage.grd_4c_SubCp.Column14.Header1.FontBold = .T.
6280: 
6281:             par_oPage.grd_4c_SubCp.Column15.Header1.Caption  = "Tam"
6282:             par_oPage.grd_4c_SubCp.Column15.ControlSource    = "cursor_4c_SubCp.Tams"
6283:             par_oPage.grd_4c_SubCp.Column15.Width            = 55
6284:             par_oPage.grd_4c_SubCp.Column15.Header1.FontBold = .T.
6285: 
6286:             *-- === cmdgSubCp (CommandGroup 2 botoes) - top=345+29=374 ===
6287:             par_oPage.AddObject("cmdg_4c_SubCp", "CommandGroup")
6288:             WITH par_oPage.cmdg_4c_SubCp
6289:                 .Top         = 374
6290:                 .Left        = 947
6291:                 .Width       = 50
6292:                 .Height      = 90
6293:                 .ButtonCount = 2
6294:                 .Themes      = .F.
6295:                 .Visible     = .T.
6296:             ENDWITH
6297: 

*-- Linhas 7199 a 7244:
7199:     * ConfigurarPgpgCusto - Configura Page6 (pgCusto) do pgf_4c_DadosInterno
7200:     * Posicoes: original_top + 29
7201:     *==========================================================================
7202:     PROTECTED PROCEDURE ConfigurarPgpgCusto(par_oPage)
7203:         LOCAL loc_oErro
7204:         TRY
7205:             *-- === Cursores placeholder ANTES dos grids ===
7206:             SET NULL ON
7207:             IF USED("cursor_4c_CustoCompo")
7208:                 USE IN cursor_4c_CustoCompo
7209:             ENDIF
7210:             CREATE CURSOR cursor_4c_CustoCompo (;
7211:                 Mats     C(14)    NULL, ;
7212:                 DPros    C(40)    NULL, ;
7213:                 Unisp    C(5)     NULL, ;
7214:                 Vals     N(15,6)  NULL, ;
7215:                 Qtds     N(15,6)  NULL, ;
7216:                 Totals   N(15,6)  NULL, ;
7217:                 Moedas   C(10)    NULL, ;
7218:                 Obss     C(50)    NULL, ;
7219:                 Es       C(10)    NULL, ;
7220:                 Conss    N(15,6)  NULL, ;
7221:                 Qtdss    N(15,6)  NULL, ;
7222:                 Unis     C(5)     NULL, ;
7223:                 CGrus    C(10)    NULL, ;
7224:                 Bloqueio C(14)    NULL  ;
7225:             )
7226:             IF USED("cursor_4c_GrupoCompo2")
7227:                 USE IN cursor_4c_GrupoCompo2
7228:             ENDIF
7229:             CREATE CURSOR cursor_4c_GrupoCompo2 (;
7230:                 CGrus  C(10)   NULL, ;
7231:                 Totals N(15,6) NULL, ;
7232:                 Moedas C(10)   NULL  ;
7233:             )
7234:             SET NULL OFF
7235: 
7236:             *-- === Say1: label "Tipo:" - top=159+29=188, left=112 ===
7237:             par_oPage.AddObject("lbl_4c_LblTipo", "Label")
7238:             WITH par_oPage.lbl_4c_LblTipo
7239:                 .Top       = 188
7240:                 .Left      = 112
7241:                 .Width     = 29
7242:                 .Height    = 15
7243:                 .FontName  = "Tahoma"
7244:                 .FontSize  = 8

*-- Linhas 7478 a 8244:
7478:             par_oPage.grd_4c_GrupoCompo2.ReadOnly    = .T.
7479:             par_oPage.grd_4c_GrupoCompo2.ScrollBars  = 2
7480:             par_oPage.grd_4c_GrupoCompo2.Themes      = .F.
7481:             par_oPage.grd_4c_GrupoCompo2.Visible     = .T.
7482: 
7483:             par_oPage.grd_4c_GrupoCompo2.RecordSource = "cursor_4c_GrupoCompo2"
7484: 
7485:             par_oPage.grd_4c_GrupoCompo2.Column1.Header1.Caption  = "Grp"
7486:             par_oPage.grd_4c_GrupoCompo2.Column1.ControlSource    = "cursor_4c_GrupoCompo2.CGrus"
7487:             par_oPage.grd_4c_GrupoCompo2.Column1.Width            = 60
7488:             par_oPage.grd_4c_GrupoCompo2.Column1.Header1.FontBold = .T.
7489: 
7490:             par_oPage.grd_4c_GrupoCompo2.Column2.Header1.Caption  = "Total"
7491:             par_oPage.grd_4c_GrupoCompo2.Column2.ControlSource    = "cursor_4c_GrupoCompo2.Totals"
7492:             par_oPage.grd_4c_GrupoCompo2.Column2.Width            = 90
7493:             par_oPage.grd_4c_GrupoCompo2.Column2.Header1.FontBold = .T.
7494: 
7495:             par_oPage.grd_4c_GrupoCompo2.Column3.Header1.Caption  = "Moe"
7496:             par_oPage.grd_4c_GrupoCompo2.Column3.ControlSource    = "cursor_4c_GrupoCompo2.Moedas"
7497:             par_oPage.grd_4c_GrupoCompo2.Column3.Width            = 40
7498:             par_oPage.grd_4c_GrupoCompo2.Column3.Header1.FontBold = .T.
7499: 
7500:         CATCH TO loc_oErro
7501:             MsgErro(loc_oErro.Message, "Erro ao configurar p" + CHR(225) + "gina Custo")
7502:         ENDTRY
7503:     ENDPROC
7504: 
7505:     *==========================================================================
7506:     * CarregarComposicao - Carrega SigPrCpo e SigPrScp para o produto atual
7507:     *==========================================================================
7508:     PROCEDURE CarregarComposicao()
7509:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgComp, loc_oErro
7510:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
7511:             RETURN
7512:         ENDIF
7513:         TRY
7514:             loc_cCPros = ALLTRIM(this_cCodigo)
7515:             IF EMPTY(loc_cCPros)
7516:                 RETURN
7517:             ENDIF
7518: 
7519:             *-- Carregar composicao principal (SigPrCpo)
7520:             IF USED("cursor_4c_CompoTemp")
7521:                 USE IN cursor_4c_CompoTemp
7522:             ENDIF
7523:             loc_cSQL = "SELECT c.mats, ISNULL(p.DPros,'') AS DPros, " + ;
7524:                        "       c.unicompos AS Unisp, c.pcompos AS Vals, c.qtds, c.totas AS Totals, c.moeds AS Moedas, " + ;
7525:                        "       ISNULL(c.obscompos,'') AS Obss, ISNULL(c.etiqs,'') AS Es, " + ;
7526:                        "       c.qtscons AS Conss, c.pesos AS Qtdss, ISNULL(c.cunips,'') AS Unis, " + ;
7527:                        "       c.ordts AS Ords, ISNULL(c.matriz,'') AS Bloqueio " + ;
7528:                        "FROM SigPrCpo c " + ;
7529:                        "LEFT JOIN SigCdPro p ON p.CPros = c.mats " + ;
7530:                        "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7531:                        " ORDER BY c.ordts"
7532:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoTemp")
7533:             IF loc_nRet > 0
7534:                 SELECT cursor_4c_Compo
7535:                 ZAP
7536:                 APPEND FROM DBF("cursor_4c_CompoTemp")
7537:                 IF USED("cursor_4c_CompoTemp")
7538:                     USE IN cursor_4c_CompoTemp
7539:                 ENDIF
7540:                 SELECT cursor_4c_Compo
7541:                 GO TOP
7542:             ENDIF
7543: 
7544:             *-- Carregar subcomposicao (SigPrScp)
7545:             IF USED("cursor_4c_SubCpTemp")
7546:                 USE IN cursor_4c_SubCpTemp
7547:             ENDIF
7548:             loc_cSQL = "SELECT s.Mats, ISNULL(p.DPros,'') AS DPros, " + ;
7549:                        "       s.Unisp, s.Vals, s.Qtds, s.Totals, s.Moedas, " + ;
7550:                        "       ISNULL(s.Obss,'') AS Obss, ISNULL(s.Es,'') AS Es, " + ;
7551:                        "       s.Conss, s.Qtdss, ISNULL(s.Unis,'') AS Unis, " + ;
7552:                        "       s.Ords, ISNULL(s.Bloqueio,'') AS Bloqueio, " + ;
7553:                        "       ISNULL(s.Tams,'') AS Tams " + ;
7554:                        "FROM SigPrScp s " + ;
7555:                        "LEFT JOIN SigCdPro p ON p.CPros = s.Mats " + ;
7556:                        "WHERE s.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7557:                        " ORDER BY s.Ords"
7558:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubCpTemp")
7559:             IF loc_nRet > 0
7560:                 SELECT cursor_4c_SubCp
7561:                 ZAP
7562:                 APPEND FROM DBF("cursor_4c_SubCpTemp")
7563:                 IF USED("cursor_4c_SubCpTemp")
7564:                     USE IN cursor_4c_SubCpTemp
7565:                 ENDIF
7566:                 SELECT cursor_4c_SubCp
7567:                 GO TOP
7568:             ENDIF
7569: 
7570:             *-- Refresh grids
7571:             loc_oPgComp = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7572:             loc_oPgComp.grd_4c_Compo.Refresh()
7573:             loc_oPgComp.grd_4c_SubCp.Refresh()
7574:             loc_oPgComp.grd_4c_Grupo.Refresh()
7575: 
7576:         CATCH TO loc_oErro
7577:             MsgErro(loc_oErro.Message, "Erro ao carregar composi" + CHR(231) + CHR(227) + "o")
7578:         ENDTRY
7579:     ENDPROC
7580: 
7581:     *==========================================================================
7582:     * Handlers de composicao (PUBLIC - obrigatorio para BINDEVENT)
7583:     *==========================================================================
7584:     PROCEDURE CompoAfterRowColChange(par_nColIndex)
7585:         LOCAL loc_oPg, loc_oErro
7586:         TRY
7587:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7588:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
7589:                 SELECT cursor_4c_Compo
7590:                 loc_oPg.txt_4c_Desc.Value    = ALLTRIM(DPros)
7591:                 loc_oPg.txt_4c_MatP.Value    = ALLTRIM(Mats)
7592:                 loc_oPg.txt_4c_ObsOFs.Value  = ALLTRIM(Obss)
7593:             ENDIF
7594:         CATCH TO loc_oErro
7595:             *-- Tolerado
7596:         ENDTRY
7597:     ENDPROC
7598: 
7599:     PROCEDURE SubCpAfterRowColChange(par_nColIndex)
7600:         LOCAL loc_oPg, loc_oErro
7601:         TRY
7602:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7603:             IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
7604:                 SELECT cursor_4c_SubCp
7605:                 loc_oPg.txt_4c_Desccp.Value = ALLTRIM(DPros)
7606:                 loc_oPg.txt_4c_Matsub.Value = ALLTRIM(Mats)
7607:             ENDIF
7608:         CATCH TO loc_oErro
7609:             *-- Tolerado
7610:         ENDTRY
7611:     ENDPROC
7612: 
7613:     PROCEDURE LiberaCustoChange()
7614:         LOCAL loc_oPg, loc_lLibera, loc_oErro
7615:         TRY
7616:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7617:             loc_lLibera = (loc_oPg.chk_4c_ChkLiberaCusto.Value = 1) AND this_lEmEdicao
7618:             loc_oPg.txt_4c_Pcus.ReadOnly    = !loc_lLibera
7619:             loc_oPg.txt_4c_Moec.ReadOnly    = !loc_lLibera
7620:             loc_oPg.txt_4c_FcustoC.ReadOnly = !loc_lLibera
7621:             loc_oPg.txt_4c_Moepc.ReadOnly   = !loc_lLibera
7622:             loc_oPg.txt_4c_Moecusf.ReadOnly = !loc_lLibera
7623:             loc_oPg.txt_4c_Cmkpc.ReadOnly   = !loc_lLibera
7624:             loc_oPg.txt_4c_Pftioc.ReadOnly  = !loc_lLibera
7625:         CATCH TO loc_oErro
7626:             MsgErro(loc_oErro.Message, "Erro ao liberar campos de custo")
7627:         ENDTRY
7628:     ENDPROC
7629: 
7630:     PROCEDURE LiberaVendaChange()
7631:         LOCAL loc_oPg, loc_lLibera, loc_oErro
7632:         TRY
7633:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7634:             loc_lLibera = (loc_oPg.chk_4c_ChkLiberaVenda.Value = 1) AND this_lEmEdicao
7635:             loc_oPg.txt_4c_Margem.ReadOnly  = !loc_lLibera
7636:             loc_oPg.txt_4c_Ftio.ReadOnly    = !loc_lLibera
7637:             loc_oPg.txt_4c_Moeda.ReadOnly   = !loc_lLibera
7638:             loc_oPg.txt_4c_Mftio.ReadOnly   = !loc_lLibera
7639:             loc_oPg.txt_4c_Pftio.ReadOnly   = !loc_lLibera
7640:             loc_oPg.txt_4c_Moepv.ReadOnly   = !loc_lLibera
7641:             loc_oPg.txt_4c_FvendaC.ReadOnly = !loc_lLibera
7642:             loc_oPg.txt_4c_Moev.ReadOnly    = !loc_lLibera
7643:         CATCH TO loc_oErro
7644:             MsgErro(loc_oErro.Message, "Erro ao liberar campos de venda")
7645:         ENDTRY
7646:     ENDPROC
7647: 
7648:     *-- Moeda custo (getMoec)
7649:     PROCEDURE MoecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7650:         LOCAL loc_oPg, loc_oErro
7651:         TRY
7652:             IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
7653:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7654:                 THIS.AbrirLookupMoedaComp(loc_oPg.txt_4c_Moec)
7655:             ENDIF
7656:         CATCH TO loc_oErro
7657:             *-- Tolerado
7658:         ENDTRY
7659:     ENDPROC
7660: 
7661:     *-- Moeda fator custo (getMoepc)
7662:     PROCEDURE MoepcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7663:         LOCAL loc_oPg, loc_oErro
7664:         TRY
7665:             IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
7666:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7667:                 THIS.AbrirLookupMoedaComp(loc_oPg.txt_4c_Moepc)
7668:             ENDIF
7669:         CATCH TO loc_oErro
7670:             *-- Tolerado
7671:         ENDTRY
7672:     ENDPROC
7673: 
7674:     *-- Moeda total custo (getMoecusf)
7675:     PROCEDURE MoecusfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7676:         LOCAL loc_oPg, loc_oErro
7677:         TRY
7678:             IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
7679:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7680:                 THIS.AbrirLookupMoedaComp(loc_oPg.txt_4c_Moecusf)
7681:             ENDIF
7682:         CATCH TO loc_oErro
7683:             *-- Tolerado
7684:         ENDTRY
7685:     ENDPROC
7686: 
7687:     *-- Moeda preco ideal (getMoeda)
7688:     PROCEDURE MoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7689:         LOCAL loc_oPg, loc_oErro
7690:         TRY
7691:             IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
7692:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7693:                 THIS.AbrirLookupMoedaComp(loc_oPg.txt_4c_Moeda)
7694:             ENDIF
7695:         CATCH TO loc_oErro
7696:             *-- Tolerado
7697:         ENDTRY
7698:     ENDPROC
7699: 
7700:     *-- Moeda fator venda (getMoepv)
7701:     PROCEDURE MoepvKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7702:         LOCAL loc_oPg, loc_oErro
7703:         TRY
7704:             IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
7705:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7706:                 THIS.AbrirLookupMoedaComp(loc_oPg.txt_4c_Moepv)
7707:             ENDIF
7708:         CATCH TO loc_oErro
7709:             *-- Tolerado
7710:         ENDTRY
7711:     ENDPROC
7712: 
7713:     *-- Moeda preco atual venda (getMoev)
7714:     PROCEDURE MoevKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7715:         LOCAL loc_oPg, loc_oErro
7716:         TRY
7717:             IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
7718:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7719:                 THIS.AbrirLookupMoedaComp(loc_oPg.txt_4c_Moev)
7720:             ENDIF
7721:         CATCH TO loc_oErro
7722:             *-- Tolerado
7723:         ENDTRY
7724:     ENDPROC
7725: 
7726:     *-- Feitio/markup (Getftio) - valida em SigPrFti
7727:     PROCEDURE FtioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7728:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
7729:             THIS.ValidarFtio()
7730:         ENDIF
7731:     ENDPROC
7732: 
7733:     *-- Margem de venda (getMargem) - aceita valor numerico
7734:     PROCEDURE MargemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7735:         LOCAL loc_oPg, loc_oErro
7736:         TRY
7737:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
7738:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7739:                 loc_oPg.txt_4c_Margem.Refresh()
7740:             ENDIF
7741:         CATCH TO loc_oErro
7742:             *-- Tolerado
7743:         ENDTRY
7744:     ENDPROC
7745: 
7746:     *-- Custo markup (Get_cmkpc) - valida em SigPrFti
7747:     PROCEDURE CmkpcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
7748:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
7749:             THIS.ValidarCmkpc()
7750:         ENDIF
7751:     ENDPROC
7752: 
7753:     PROCEDURE CalcValsClick()
7754:         LOCAL loc_oErro
7755:         TRY
7756:             THIS.CarregarComposicao()
7757:         CATCH TO loc_oErro
7758:             MsgErro(loc_oErro.Message, "Erro ao calcular valores")
7759:         ENDTRY
7760:     ENDPROC
7761: 
7762:     PROCEDURE PesoMClick()
7763:         LOCAL loc_oErro
7764:         TRY
7765:             MsgInfo("C" + CHR(225) + "lculo de peso m" + CHR(233) + "dio n" + CHR(227) + "o implementado.", "Info")
7766:         CATCH TO loc_oErro
7767:             *-- Tolerado
7768:         ENDTRY
7769:     ENDPROC
7770: 
7771:     *-- Incluir linha na composicao principal
7772:     PROCEDURE CompoIncluirClick()
7773:         LOCAL loc_nRet, loc_cCPros, loc_oErro, loc_lContinuar
7774:         loc_lContinuar = .T.
7775:         TRY
7776:             IF !this_lEmEdicao
7777:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
7778:                 loc_lContinuar = .F.
7779:             ENDIF
7780:             IF loc_lContinuar
7781:                 loc_cCPros = ALLTRIM(this_cCodigo)
7782:                 IF EMPTY(loc_cCPros)
7783:                     MsgAviso("Salve o produto antes de adicionar composi" + CHR(231) + CHR(227) + "o.", "Aviso")
7784:                     loc_lContinuar = .F.
7785:                 ENDIF
7786:             ENDIF
7787:             IF loc_lContinuar AND gnConnHandle > 0
7788:                 loc_nRet = SQLEXEC(gnConnHandle, ;
7789:                     "INSERT INTO SigPrCpo (CPros, DtMovs, cIdChaves, TpCalcCus) " + ;
7790:                     "VALUES (" + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7791:                     ", GETDATE(), NEWID(), 1)")
7792:                 IF loc_nRet < 1
7793:                     MsgErro("Erro ao incluir linha de composi" + CHR(231) + CHR(227) + "o.", "Erro")
7794:                 ELSE
7795:                     THIS.CarregarComposicao()
7796:                 ENDIF
7797:             ENDIF
7798:         CATCH TO loc_oErro
7799:             MsgErro(loc_oErro.Message, "Erro ao incluir linha de composi" + CHR(231) + CHR(227) + "o")
7800:         ENDTRY
7801:     ENDPROC
7802: 
7803:     *-- Excluir linha da composicao principal
7804:     PROCEDURE CompoExcluirClick()
7805:         LOCAL loc_nRet, loc_cMats, loc_lConfirmou, loc_oErro, loc_lContinuar
7806:         loc_lContinuar = .T.
7807:         TRY
7808:             IF !this_lEmEdicao
7809:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
7810:                 loc_lContinuar = .F.
7811:             ENDIF
7812:             IF loc_lContinuar
7813:                 IF !USED("cursor_4c_Compo") OR RECCOUNT("cursor_4c_Compo") = 0
7814:                     MsgAviso("Nenhuma linha selecionada.", "Aviso")
7815:                     loc_lContinuar = .F.
7816:                 ENDIF
7817:             ENDIF
7818:             IF loc_lContinuar
7819:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta linha de composi" + CHR(231) + CHR(227) + "o?", "Confirmar")
7820:                 IF loc_lConfirmou AND gnConnHandle > 0
7821:                     SELECT cursor_4c_Compo
7822:                     loc_cMats = ALLTRIM(Mats)
7823:                     loc_nRet  = SQLEXEC(gnConnHandle, ;
7824:                         "DELETE FROM SigPrCpo WHERE CPros = " + EscaparSQL(PADR(ALLTRIM(this_cCodigo), 14)) + ;
7825:                         " AND Mats = " + EscaparSQL(PADR(loc_cMats, 14)))
7826:                     THIS.CarregarComposicao()
7827:                 ENDIF
7828:             ENDIF
7829:         CATCH TO loc_oErro
7830:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de composi" + CHR(231) + CHR(227) + "o")
7831:         ENDTRY
7832:     ENDPROC
7833: 
7834:     PROCEDURE CompoAtualizaClick()
7835:         LOCAL loc_oErro
7836:         TRY
7837:             THIS.CarregarComposicao()
7838:         CATCH TO loc_oErro
7839:             MsgErro(loc_oErro.Message, "Erro ao atualizar composi" + CHR(231) + CHR(227) + "o")
7840:         ENDTRY
7841:     ENDPROC
7842: 
7843:     PROCEDURE CompoCopiarClick()
7844:         LOCAL loc_oErro
7845:         TRY
7846:             MsgInfo("Funcionalidade de c" + CHR(243) + "pia em desenvolvimento.", "Info")
7847:         CATCH TO loc_oErro
7848:             *-- Tolerado
7849:         ENDTRY
7850:     ENDPROC
7851: 
7852:     PROCEDURE CompoGrupoClick()
7853:         LOCAL loc_oErro
7854:         TRY
7855:             THIS.CarregarComposicao()
7856:         CATCH TO loc_oErro
7857:             *-- Tolerado
7858:         ENDTRY
7859:     ENDPROC
7860: 
7861:     *-- Incluir linha na subcomposicao
7862:     PROCEDURE SubCpIncluirClick()
7863:         LOCAL loc_nRet, loc_cCPros, loc_oErro, loc_lContinuar
7864:         loc_lContinuar = .T.
7865:         TRY
7866:             IF !this_lEmEdicao
7867:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
7868:                 loc_lContinuar = .F.
7869:             ENDIF
7870:             IF loc_lContinuar
7871:                 loc_cCPros = ALLTRIM(this_cCodigo)
7872:                 IF EMPTY(loc_cCPros)
7873:                     loc_lContinuar = .F.
7874:                 ENDIF
7875:             ENDIF
7876:             IF loc_lContinuar AND gnConnHandle > 0
7877:                 loc_nRet = SQLEXEC(gnConnHandle, ;
7878:                     "INSERT INTO SigPrScp (CPros, DtMovs, cIdChaves) " + ;
7879:                     "VALUES (" + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7880:                     ", GETDATE(), NEWID())")
7881:                 IF loc_nRet < 1
7882:                     MsgErro("Erro ao incluir linha de subcomposi" + CHR(231) + CHR(227) + "o.", "Erro")
7883:                 ELSE
7884:                     THIS.CarregarComposicao()
7885:                 ENDIF
7886:             ENDIF
7887:         CATCH TO loc_oErro
7888:             MsgErro(loc_oErro.Message, "Erro ao incluir subcomposi" + CHR(231) + CHR(227) + "o")
7889:         ENDTRY
7890:     ENDPROC
7891: 
7892:     *-- Excluir linha da subcomposicao
7893:     PROCEDURE SubCpExcluirClick()
7894:         LOCAL loc_nRet, loc_cMats, loc_lConfirmou, loc_oErro, loc_lContinuar
7895:         loc_lContinuar = .T.
7896:         TRY
7897:             IF !this_lEmEdicao
7898:                 loc_lContinuar = .F.
7899:             ENDIF
7900:             IF loc_lContinuar
7901:                 IF !USED("cursor_4c_SubCp") OR RECCOUNT("cursor_4c_SubCp") = 0
7902:                     loc_lContinuar = .F.
7903:                 ENDIF
7904:             ENDIF
7905:             IF loc_lContinuar
7906:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta linha de subcomposi" + CHR(231) + CHR(227) + "o?", "Confirmar")
7907:                 IF loc_lConfirmou AND gnConnHandle > 0
7908:                     SELECT cursor_4c_SubCp
7909:                     loc_cMats = ALLTRIM(Mats)
7910:                     loc_nRet  = SQLEXEC(gnConnHandle, ;
7911:                         "DELETE FROM SigPrScp WHERE CPros = " + EscaparSQL(PADR(ALLTRIM(this_cCodigo), 14)) + ;
7912:                         " AND Mats = " + EscaparSQL(PADR(loc_cMats, 14)))
7913:                     THIS.CarregarComposicao()
7914:                 ENDIF
7915:             ENDIF
7916:         CATCH TO loc_oErro
7917:             MsgErro(loc_oErro.Message, "Erro ao excluir subcomposi" + CHR(231) + CHR(227) + "o")
7918:         ENDTRY
7919:     ENDPROC
7920: 
7921:     *==========================================================================
7922:     * Helpers de composicao (PROTECTED)
7923:     *==========================================================================
7924:     PROTECTED PROCEDURE AbrirLookupMoedaComp(par_oTextBox)
7925:         LOCAL loc_oBusca, loc_cCodigo, loc_oErro
7926:         TRY
7927:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
7928:                 RETURN
7929:             ENDIF
7930:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
7931:                 "cursor_4c_BuscaMoeComp", "CMoes", ;
7932:                 ALLTRIM(par_oTextBox.Value), ;
7933:                 "Moeda")
7934:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
7935:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
7936:             loc_oBusca.Show()
7937:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeComp")
7938:                 loc_cCodigo = ALLTRIM(cursor_4c_BuscaMoeComp.CMoes)
7939:                 par_oTextBox.Value = loc_cCodigo
7940:             ENDIF
7941:             IF USED("cursor_4c_BuscaMoeComp")
7942:                 USE IN cursor_4c_BuscaMoeComp
7943:             ENDIF
7944:             loc_oBusca.Release()
7945:         CATCH TO loc_oErro
7946:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup moeda")
7947:         ENDTRY
7948:     ENDPROC
7949: 
7950:     PROTECTED PROCEDURE ValidarFtio()
7951:         LOCAL loc_oPg, loc_cCod, loc_nRet, loc_oErro
7952:         TRY
7953:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
7954:                 RETURN
7955:             ENDIF
7956:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7957:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ftio.Value)
7958:             IF EMPTY(loc_cCod)
7959:                 RETURN
7960:             ENDIF
7961:             loc_nRet = SQLEXEC(gnConnHandle, ;
7962:                 "SELECT Cods FROM SigPrFti WHERE Cods = " + ;
7963:                 EscaparSQL(PADR(loc_cCod, 5)), ;
7964:                 "cursor_4c_ValFtio")
7965:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_ValFtio") = 0
7966:                 loc_oPg.txt_4c_Ftio.Value = ""
7967:             ENDIF
7968:             IF USED("cursor_4c_ValFtio")
7969:                 USE IN cursor_4c_ValFtio
7970:             ENDIF
7971:         CATCH TO loc_oErro
7972:             MsgErro(loc_oErro.Message, "Erro ao validar feitio")
7973:         ENDTRY
7974:     ENDPROC
7975: 
7976:     PROTECTED PROCEDURE ValidarCmkpc()
7977:         LOCAL loc_oPg, loc_cCod, loc_nRet, loc_oErro
7978:         TRY
7979:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
7980:                 RETURN
7981:             ENDIF
7982:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7983:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cmkpc.Value)
7984:             IF EMPTY(loc_cCod)
7985:                 RETURN
7986:             ENDIF
7987:             loc_nRet = SQLEXEC(gnConnHandle, ;
7988:                 "SELECT Cods FROM SigPrFti WHERE Cods = " + ;
7989:                 EscaparSQL(PADR(loc_cCod, 5)), ;
7990:                 "cursor_4c_ValCmkpc")
7991:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_ValCmkpc") = 0
7992:                 loc_oPg.txt_4c_Cmkpc.Value = ""
7993:             ENDIF
7994:             IF USED("cursor_4c_ValCmkpc")
7995:                 USE IN cursor_4c_ValCmkpc
7996:             ENDIF
7997:         CATCH TO loc_oErro
7998:             MsgErro(loc_oErro.Message, "Erro ao validar markup custo")
7999:         ENDTRY
8000:     ENDPROC
8001: 
8002:     *==========================================================================
8003:     * CarregarCusto - Carrega SigPrCpo filtrado por Tipos para pgCusto
8004:     *==========================================================================
8005:     PROCEDURE CarregarCusto()
8006:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_nTipo, loc_oPgCusto, loc_oErro
8007:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
8008:             RETURN
8009:         ENDIF
8010:         TRY
8011:             loc_cCPros = ALLTRIM(this_cCodigo)
8012:             IF EMPTY(loc_cCPros)
8013:                 RETURN
8014:             ENDIF
8015: 
8016:             loc_oPgCusto = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page6
8017: 
8018:             *-- Obter tipo selecionado no combo (0 = todos)
8019:             loc_nTipo = 0
8020:             IF VARTYPE(loc_oPgCusto.cbo_4c_CmbTipos.Value) = "N"
8021:                 loc_nTipo = loc_oPgCusto.cbo_4c_CmbTipos.Value
8022:             ENDIF
8023: 
8024:             *-- Carregar composicao custo (SigPrCpo)
8025:             IF USED("cursor_4c_CustoCompoTemp")
8026:                 USE IN cursor_4c_CustoCompoTemp
8027:             ENDIF
8028:             loc_cSQL = "SELECT c.mats, ISNULL(p.DPros,'') AS DPros, " + ;
8029:                        "       c.unicompos AS Unisp, c.pcompos AS Vals, c.qtds, c.totas AS Totals, c.moeds AS Moedas, " + ;
8030:                        "       ISNULL(c.obscompos,'') AS Obss, ISNULL(c.etiqs,'') AS Es, " + ;
8031:                        "       c.qtscons AS Conss, c.pesos AS Qtdss, ISNULL(c.cunips,'') AS Unis, " + ;
8032:                        "       ISNULL(p.CGrus,'') AS CGrus, ISNULL(c.matriz,'') AS Bloqueio " + ;
8033:                        "FROM SigPrCpo c " + ;
8034:                        "LEFT JOIN SigCdPro p ON p.CPros = c.mats " + ;
8035:                        "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
8036:             IF loc_nTipo > 0
8037:                 loc_cSQL = loc_cSQL + " AND ISNULL(c.Tipos, 0) = " + LTRIM(STR(loc_nTipo))
8038:             ENDIF
8039:             loc_cSQL = loc_cSQL + " ORDER BY c.ordts"
8040: 
8041:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CustoCompoTemp")
8042:             IF loc_nRet > 0
8043:                 SELECT cursor_4c_CustoCompo
8044:                 ZAP
8045:                 APPEND FROM DBF("cursor_4c_CustoCompoTemp")
8046:                 IF USED("cursor_4c_CustoCompoTemp")
8047:                     USE IN cursor_4c_CustoCompoTemp
8048:                 ENDIF
8049:                 SELECT cursor_4c_CustoCompo
8050:                 GO TOP
8051:             ENDIF
8052: 
8053:             *-- Carregar resumo por grupo (GradeGRUPO2)
8054:             IF USED("cursor_4c_GrupoCompo2Temp")
8055:                 USE IN cursor_4c_GrupoCompo2Temp
8056:             ENDIF
8057:             loc_cSQL = "SELECT ISNULL(p.CGrus,'') AS CGrus, " + ;
8058:                        "       SUM(c.totas) AS Totals, MIN(c.moeds) AS Moedas " + ;
8059:                        "FROM SigPrCpo c " + ;
8060:                        "LEFT JOIN SigCdPro p ON p.CPros = c.mats " + ;
8061:                        "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
8062:             IF loc_nTipo > 0
8063:                 loc_cSQL = loc_cSQL + " AND ISNULL(c.Tipos, 0) = " + LTRIM(STR(loc_nTipo))
8064:             ENDIF
8065:             loc_cSQL = loc_cSQL + " GROUP BY p.CGrus ORDER BY p.CGrus"
8066: 
8067:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoCompo2Temp")
8068:             IF loc_nRet > 0
8069:                 SELECT cursor_4c_GrupoCompo2
8070:                 ZAP
8071:                 APPEND FROM DBF("cursor_4c_GrupoCompo2Temp")
8072:                 IF USED("cursor_4c_GrupoCompo2Temp")
8073:                     USE IN cursor_4c_GrupoCompo2Temp
8074:                 ENDIF
8075:                 SELECT cursor_4c_GrupoCompo2
8076:                 GO TOP
8077:             ENDIF
8078: 
8079:             *-- Refresh grids
8080:             loc_oPgCusto.grd_4c_GrdCustoCompo.Refresh()
8081:             loc_oPgCusto.grd_4c_GrupoCompo2.Refresh()
8082: 
8083:         CATCH TO loc_oErro
8084:             MsgErro(loc_oErro.Message, "Erro ao carregar custo")
8085:         ENDTRY
8086:     ENDPROC
8087: 
8088:     *==========================================================================
8089:     * Handlers da pagina Custo (PUBLIC - obrigatorio para BINDEVENT)
8090:     *==========================================================================
8091:     PROCEDURE GrdCustoCompoAfterRowColChange(par_nColIndex)
8092:         LOCAL loc_oPg, loc_cSQL, loc_nRet, loc_cGrus, loc_cDGrus, loc_oErro
8093:         TRY
8094:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page6
8095:             IF USED("cursor_4c_CustoCompo") AND !EOF("cursor_4c_CustoCompo")
8096:                 SELECT cursor_4c_CustoCompo
8097:                 loc_oPg.txt_4c_DescCus.Value  = ALLTRIM(DPros)
8098:                 loc_cGrus = ALLTRIM(CGrus)
8099:                 *-- Buscar descricao do grupo
8100:                 IF !EMPTY(loc_cGrus) AND gnConnHandle > 0
8101:                     IF USED("cursor_4c_GruCusto")
8102:                         USE IN cursor_4c_GruCusto
8103:                     ENDIF
8104:                     loc_cSQL = "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(PADR(loc_cGrus, 10))
8105:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruCusto")
8106:                     IF loc_nRet > 0 AND !EOF("cursor_4c_GruCusto")
8107:                         loc_cDGrus = ALLTRIM(cursor_4c_GruCusto.DGrus)
8108:                     ELSE
8109:                         loc_cDGrus = ""
8110:                     ENDIF
8111:                     IF USED("cursor_4c_GruCusto")
8112:                         USE IN cursor_4c_GruCusto
8113:                     ENDIF
8114:                     loc_oPg.txt_4c_DGruCompos.Value = loc_cDGrus
8115:                 ELSE
8116:                     loc_oPg.txt_4c_DGruCompos.Value = ""
8117:                 ENDIF
8118:             ENDIF
8119:         CATCH TO loc_oErro
8120:             *-- Tolerado
8121:         ENDTRY
8122:     ENDPROC
8123: 
8124:     PROCEDURE CboTiposCustoInteractiveChange()
8125:         LOCAL loc_oErro
8126:         TRY
8127:             THIS.CarregarCusto()
8128:         CATCH TO loc_oErro
8129:             MsgErro(loc_oErro.Message, "Erro ao filtrar tipos de custo")
8130:         ENDTRY
8131:     ENDPROC
8132: 
8133:     PROCEDURE CustoCompoIncluirClick()
8134:         LOCAL loc_nRet, loc_cCPros, loc_nTipo, loc_oPgCusto, loc_oErro, loc_lContinuar
8135:         loc_lContinuar = .T.
8136:         TRY
8137:             IF !this_lEmEdicao
8138:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
8139:                 loc_lContinuar = .F.
8140:             ENDIF
8141:             IF loc_lContinuar
8142:                 loc_cCPros = ALLTRIM(this_cCodigo)
8143:                 IF EMPTY(loc_cCPros)
8144:                     MsgAviso("Salve o produto antes de adicionar linha de custo.", "Aviso")
8145:                     loc_lContinuar = .F.
8146:                 ENDIF
8147:             ENDIF
8148:             IF loc_lContinuar AND gnConnHandle > 0
8149:                 loc_oPgCusto = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page6
8150:                 loc_nTipo    = 0
8151:                 IF VARTYPE(loc_oPgCusto.cbo_4c_CmbTipos.Value) = "N"
8152:                     loc_nTipo = INT(loc_oPgCusto.cbo_4c_CmbTipos.Value)
8153:                 ENDIF
8154:                 loc_nRet = SQLEXEC(gnConnHandle, ;
8155:                     "INSERT INTO SigPrCpo (CPros, DtMovs, cIdChaves, Tipos) " + ;
8156:                     "VALUES (" + EscaparSQL(PADR(loc_cCPros, 14)) + ;
8157:                     ", GETDATE(), NEWID(), " + LTRIM(STR(loc_nTipo)) + ")")
8158:                 IF loc_nRet < 1
8159:                     MsgErro("Erro ao incluir linha de custo.", "Erro")
8160:                 ELSE
8161:                     THIS.CarregarCusto()
8162:                 ENDIF
8163:             ENDIF
8164:         CATCH TO loc_oErro
8165:             MsgErro(loc_oErro.Message, "Erro ao incluir linha de custo")
8166:         ENDTRY
8167:     ENDPROC
8168: 
8169:     PROCEDURE CustoCompoExcluirClick()
8170:         LOCAL loc_nRet, loc_cMats, loc_lConfirmou, loc_oErro, loc_lContinuar
8171:         loc_lContinuar = .T.
8172:         TRY
8173:             IF !this_lEmEdicao
8174:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
8175:                 loc_lContinuar = .F.
8176:             ENDIF
8177:             IF loc_lContinuar
8178:                 IF !USED("cursor_4c_CustoCompo") OR RECCOUNT("cursor_4c_CustoCompo") = 0
8179:                     MsgAviso("Nenhuma linha selecionada.", "Aviso")
8180:                     loc_lContinuar = .F.
8181:                 ENDIF
8182:             ENDIF
8183:             IF loc_lContinuar
8184:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta linha de custo?", "Confirmar")
8185:                 IF loc_lConfirmou AND gnConnHandle > 0
8186:                     SELECT cursor_4c_CustoCompo
8187:                     loc_cMats = ALLTRIM(Mats)
8188:                     loc_nRet  = SQLEXEC(gnConnHandle, ;
8189:                         "DELETE FROM SigPrCpo WHERE CPros = " + EscaparSQL(PADR(ALLTRIM(this_cCodigo), 14)) + ;
8190:                         " AND Mats = " + EscaparSQL(PADR(loc_cMats, 14)))
8191:                     THIS.CarregarCusto()
8192:                 ENDIF
8193:             ENDIF
8194:         CATCH TO loc_oErro
8195:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de custo")
8196:         ENDTRY
8197:     ENDPROC
8198: 
8199:     *==========================================================================
8200:     * ConfigurarPgPgDadosConsP - PgDadosConsP (Page5 do pgf_4c_DadosInterno)
8201:     * Cons P: GrdCons (9 colunas), Getqtcpnt, chkFund, grDTEMP (2 colunas)
8202:     * Posicoes: original_top + 29
8203:     *==========================================================================
8204:     PROTECTED PROCEDURE ConfigurarPgPgDadosConsP(par_oPage)
8205:         LOCAL loc_oGrd, loc_oErro
8206:         TRY
8207:             *-- === Cursores placeholder ANTES dos grids ===
8208:             SET NULL ON
8209:             IF USED("cursor_4c_ConsP")
8210:                 USE IN cursor_4c_ConsP
8211:             ENDIF
8212:             CREATE CURSOR cursor_4c_ConsP (;
8213:                 Mats   C(14)   NULL, ;
8214:                 Qtds   N(15,6) NULL, ;
8215:                 Unisp  C(5)    NULL, ;
8216:                 Grupos C(10)   NULL, ;
8217:                 Descrs C(50)   NULL, ;
8218:                 Ordems N(5,0)  NULL, ;
8219:                 Conss  N(15,6) NULL, ;
8220:                 Ccats  C(10)   NULL, ;
8221:                 DCats  C(50)   NULL  ;
8222:             )
8223:             IF USED("cursor_4c_DTemp")
8224:                 USE IN cursor_4c_DTemp
8225:             ENDIF
8226:             CREATE CURSOR cursor_4c_DTemp (;
8227:                 Grupos C(10)   NULL, ;
8228:                 TempoP N(10,2) NULL  ;
8229:             )
8230:             SET NULL OFF
8231: 
8232:             *-- === Say7: label "Qtde Componentes :" - top=523+29=552, left=25 ===
8233:             par_oPage.AddObject("lbl_4c_Label7", "Label")
8234:             WITH par_oPage.lbl_4c_Label7
8235:                 .Top       = 552
8236:                 .Left      = 25
8237:                 .Width     = 105
8238:                 .Height    = 15
8239:                 .FontName  = "Tahoma"
8240:                 .FontSize  = 8
8241:                 .BackStyle = 0
8242:                 .Caption   = "Qtde Componentes :"
8243:                 .Visible   = .T.
8244:             ENDWITH

*-- Linhas 8356 a 8680:
8356:             loc_oGrd.Column9.ReadOnly         = .T.
8357:             loc_oGrd.Column9.Header1.FontBold = .T.
8358: 
8359:             *-- BINDEVENT para colunas editaveis (F4=115 dispara lookup)
8360:             BINDEVENT(loc_oGrd.Column4.Text1, "KeyPress", THIS, "GrdConsCol4KeyPress")
8361:             BINDEVENT(loc_oGrd.Column5.Text1, "KeyPress", THIS, "GrdConsCol5KeyPress")
8362:             BINDEVENT(loc_oGrd.Column8.Text1, "KeyPress", THIS, "GrdConsCol8KeyPress")
8363: 
8364:             *-- === grDTEMP - top=519+29=548, left=821, w=172, h=107, 2 colunas ===
8365:             par_oPage.AddObject("grd_4c_GrDTEMP", "Grid")
8366:             WITH par_oPage.grd_4c_GrDTEMP
8367:                 .Top         = 548
8368:                 .Left        = 821
8369:                 .Width       = 172
8370:                 .Height      = 107
8371:                 .ColumnCount = 2
8372:                 .FontName    = "Tahoma"
8373:                 .FontSize    = 8
8374:                 .GridLines   = 3
8375:                 .DeleteMark  = .F.
8376:                 .RecordMark  = .F.
8377:                 .RowHeight   = 16
8378:                 .ScrollBars  = 3
8379:                 .Themes      = .F.
8380:                 .Visible     = .T.
8381:             ENDWITH
8382: 
8383:             par_oPage.grd_4c_GrDTEMP.RecordSource = "cursor_4c_DTemp"
8384: 
8385:             par_oPage.grd_4c_GrDTEMP.Column1.Header1.Caption  = "Agrupamento"
8386:             par_oPage.grd_4c_GrDTEMP.Column1.ControlSource    = "cursor_4c_DTemp.Grupos"
8387:             par_oPage.grd_4c_GrDTEMP.Column1.Width            = 90
8388:             par_oPage.grd_4c_GrDTEMP.Column1.ReadOnly         = .T.
8389:             par_oPage.grd_4c_GrDTEMP.Column1.Header1.FontBold = .T.
8390: 
8391:             par_oPage.grd_4c_GrDTEMP.Column2.Header1.Caption  = "Tempo %"
8392:             par_oPage.grd_4c_GrDTEMP.Column2.ControlSource    = "cursor_4c_DTemp.TempoP"
8393:             par_oPage.grd_4c_GrDTEMP.Column2.Width            = 70
8394:             par_oPage.grd_4c_GrDTEMP.Column2.ReadOnly         = .T.
8395:             par_oPage.grd_4c_GrDTEMP.Column2.Header1.FontBold = .T.
8396: 
8397:         CATCH TO loc_oErro
8398:             MsgErro(loc_oErro.Message, "Erro ao configurar p" + CHR(225) + "gina ConsP")
8399:         ENDTRY
8400:     ENDPROC
8401: 
8402:     *==========================================================================
8403:     * CarregarConsP - Carrega SigPrCpo com fase (SigCdPrf) e cat (SigCdCat)
8404:     *==========================================================================
8405:     PROCEDURE CarregarConsP()
8406:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgConsP, loc_oErro, loc_lContinuar
8407:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
8408:             RETURN
8409:         ENDIF
8410:         loc_lContinuar = .T.
8411:         TRY
8412:             loc_cCPros = ALLTRIM(this_cCodigo)
8413:             IF EMPTY(loc_cCPros)
8414:                 loc_lContinuar = .F.
8415:             ENDIF
8416: 
8417:             IF loc_lContinuar
8418:                 *-- Carregar ConsP principal (SigPrCpo + SigCdPrf + SigCdCat)
8419:                 IF USED("cursor_4c_ConsPTemp")
8420:                     USE IN cursor_4c_ConsPTemp
8421:                 ENDIF
8422:                 loc_cSQL = "SELECT c.mats, ISNULL(c.qtds,0) AS Qtds, " + ;
8423:                            "       ISNULL(c.unicompos,'') AS Unisp, " + ;
8424:                            "       ISNULL(c.grupos,'') AS Grupos, " + ;
8425:                            "       ISNULL(gcr.Descrs,'') AS Descrs, " + ;
8426:                            "       ISNULL(c.ordems,0) AS Ordems, " + ;
8427:                            "       ISNULL(c.qtscons,0) AS Conss, " + ;
8428:                            "       ISNULL(c.cats,'') AS Ccats, " + ;
8429:                            "       ISNULL(cat.Descs,'') AS DCats " + ;
8430:                            "FROM SigPrCpo c " + ;
8431:                            "LEFT JOIN SigCdGcr gcr ON gcr.Codigos = c.grupos " + ;
8432:                            "LEFT JOIN SigCdCat cat ON LTRIM(RTRIM(cat.Cods)) = LTRIM(RTRIM(c.cats)) " + ;
8433:                            "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
8434:                            " ORDER BY c.ordems, c.mats"
8435:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPTemp")
8436:                 IF loc_nRet > 0
8437:                     SELECT cursor_4c_ConsP
8438:                     ZAP
8439:                     APPEND FROM DBF("cursor_4c_ConsPTemp")
8440:                     IF USED("cursor_4c_ConsPTemp")
8441:                         USE IN cursor_4c_ConsPTemp
8442:                     ENDIF
8443:                     SELECT cursor_4c_ConsP
8444:                     GO TOP
8445: 
8446:                     loc_oPgConsP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page5
8447:                     loc_oPgConsP.txt_4c_Qtcpnt.Value = LTRIM(STR(RECCOUNT("cursor_4c_ConsP")))
8448:                     loc_oPgConsP.grd_4c_GrdCons.Refresh()
8449:                 ENDIF
8450: 
8451:                 *-- Carregar DTemp (consumo agrupado por fase/grupo)
8452:                 IF USED("cursor_4c_DTempLoad")
8453:                     USE IN cursor_4c_DTempLoad
8454:                 ENDIF
8455:                 loc_cSQL = "SELECT ISNULL(c.grupos,'') AS Grupos, " + ;
8456:                            "       ISNULL(SUM(c.qtscons),0) AS TempoP " + ;
8457:                            "FROM SigPrCpo c " + ;
8458:                            "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
8459:                            "  AND c.grupos IS NOT NULL AND LTRIM(RTRIM(c.grupos)) <> '' " + ;
8460:                            "GROUP BY c.grupos ORDER BY c.grupos"
8461:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DTempLoad")
8462:                 IF loc_nRet > 0
8463:                     SELECT cursor_4c_DTemp
8464:                     ZAP
8465:                     APPEND FROM DBF("cursor_4c_DTempLoad")
8466:                     IF USED("cursor_4c_DTempLoad")
8467:                         USE IN cursor_4c_DTempLoad
8468:                     ENDIF
8469:                     SELECT cursor_4c_DTemp
8470:                     GO TOP
8471:                     IF VARTYPE(loc_oPgConsP) = "O"
8472:                         loc_oPgConsP.grd_4c_GrDTEMP.Refresh()
8473:                     ENDIF
8474:                 ENDIF
8475:             ENDIF
8476: 
8477:         CATCH TO loc_oErro
8478:             MsgErro(loc_oErro.Message, "Erro ao carregar ConsP")
8479:         ENDTRY
8480:     ENDPROC
8481: 
8482:     *==========================================================================
8483:     * GrdConsCol4KeyPress - F4 em Column4 (Fase) abre lookup SigCdPrf
8484:     *==========================================================================
8485:     PROCEDURE GrdConsCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
8486:         LOCAL loc_oErro
8487:         TRY
8488:             IF par_nKeyCode = 115
8489:                 THIS.AbrirLookupFaseConsP()
8490:             ENDIF
8491:         CATCH TO loc_oErro
8492:             *-- Tolerado
8493:         ENDTRY
8494:     ENDPROC
8495: 
8496:     PROTECTED PROCEDURE AbrirLookupFaseConsP()
8497:         LOCAL loc_oBusca, loc_cGrupos, loc_cDescrs, loc_oPgConsP, loc_oGrd, loc_oErro
8498:         TRY
8499:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
8500:                 RETURN
8501:             ENDIF
8502:             IF !this_lEmEdicao
8503:                 RETURN
8504:             ENDIF
8505:             loc_oPgConsP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page5
8506:             loc_oGrd     = loc_oPgConsP.grd_4c_GrdCons
8507:             loc_cGrupos  = ALLTRIM(loc_oGrd.Column4.Text1.Value)
8508:             loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPrf", ;
8509:                 "cursor_4c_BuscaFase", "Grupos", loc_cGrupos, "Fase de Produ" + CHR(231) + CHR(227) + "o")
8510:             loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "digo")
8511:             loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
8512:             loc_oBusca.Show()
8513:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFase")
8514:                 loc_cGrupos = ALLTRIM(cursor_4c_BuscaFase.Grupos)
8515:                 loc_cDescrs = ALLTRIM(cursor_4c_BuscaFase.Descrs)
8516:                 IF USED("cursor_4c_ConsP") AND !EOF("cursor_4c_ConsP")
8517:                     REPLACE cursor_4c_ConsP.Grupos WITH loc_cGrupos
8518:                     REPLACE cursor_4c_ConsP.Descrs WITH loc_cDescrs
8519:                 ENDIF
8520:                 loc_oGrd.Column4.Text1.Value = loc_cGrupos
8521:                 loc_oGrd.Column5.Text1.Value = loc_cDescrs
8522:                 loc_oGrd.Refresh()
8523:             ENDIF
8524:             IF USED("cursor_4c_BuscaFase")
8525:                 USE IN cursor_4c_BuscaFase
8526:             ENDIF
8527:             loc_oBusca.Release()
8528:         CATCH TO loc_oErro
8529:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de fase")
8530:         ENDTRY
8531:     ENDPROC
8532: 
8533:     *==========================================================================
8534:     * GrdConsCol5KeyPress - F4 em Column5 (Descricao fase) abre lookup SigCdPrf
8535:     *==========================================================================
8536:     PROCEDURE GrdConsCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
8537:         LOCAL loc_oErro
8538:         TRY
8539:             IF par_nKeyCode = 115
8540:                 THIS.AbrirLookupFaseDescConsP()
8541:             ENDIF
8542:         CATCH TO loc_oErro
8543:             *-- Tolerado
8544:         ENDTRY
8545:     ENDPROC
8546: 
8547:     PROTECTED PROCEDURE AbrirLookupFaseDescConsP()
8548:         LOCAL loc_oBusca, loc_cGrupos, loc_cDescrs, loc_oPgConsP, loc_oGrd, loc_oErro
8549:         TRY
8550:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
8551:                 RETURN
8552:             ENDIF
8553:             IF !this_lEmEdicao
8554:                 RETURN
8555:             ENDIF
8556:             loc_oPgConsP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page5
8557:             loc_oGrd     = loc_oPgConsP.grd_4c_GrdCons
8558:             loc_cDescrs  = ALLTRIM(loc_oGrd.Column5.Text1.Value)
8559:             loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPrf", ;
8560:                 "cursor_4c_BuscaFaseDesc", "Descrs", loc_cDescrs, "Descri" + CHR(231) + CHR(227) + "o de Fase")
8561:             loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
8562:             loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "digo")
8563:             loc_oBusca.Show()
8564:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFaseDesc")
8565:                 loc_cGrupos = ALLTRIM(cursor_4c_BuscaFaseDesc.Grupos)
8566:                 loc_cDescrs = ALLTRIM(cursor_4c_BuscaFaseDesc.Descrs)
8567:                 IF USED("cursor_4c_ConsP") AND !EOF("cursor_4c_ConsP")
8568:                     REPLACE cursor_4c_ConsP.Grupos WITH loc_cGrupos
8569:                     REPLACE cursor_4c_ConsP.Descrs WITH loc_cDescrs
8570:                 ENDIF
8571:                 loc_oGrd.Column4.Text1.Value = loc_cGrupos
8572:                 loc_oGrd.Column5.Text1.Value = loc_cDescrs
8573:                 loc_oGrd.Refresh()
8574:             ENDIF
8575:             IF USED("cursor_4c_BuscaFaseDesc")
8576:                 USE IN cursor_4c_BuscaFaseDesc
8577:             ENDIF
8578:             loc_oBusca.Release()
8579:         CATCH TO loc_oErro
8580:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de descri" + CHR(231) + CHR(227) + "o de fase")
8581:         ENDTRY
8582:     ENDPROC
8583: 
8584:     *==========================================================================
8585:     * GrdConsCol8KeyPress - F4 em Column8 (Cat.) abre lookup SigCdCat
8586:     *==========================================================================
8587:     PROCEDURE GrdConsCol8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
8588:         LOCAL loc_oErro
8589:         TRY
8590:             IF par_nKeyCode = 115
8591:                 THIS.AbrirLookupCatConsP()
8592:             ENDIF
8593:         CATCH TO loc_oErro
8594:             *-- Tolerado
8595:         ENDTRY
8596:     ENDPROC
8597: 
8598:     PROTECTED PROCEDURE AbrirLookupCatConsP()
8599:         LOCAL loc_oBusca, loc_cCods, loc_cDescs, loc_oPgConsP, loc_oGrd, loc_oErro
8600:         TRY
8601:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
8602:                 RETURN
8603:             ENDIF
8604:             IF !this_lEmEdicao
8605:                 RETURN
8606:             ENDIF
8607:             loc_oPgConsP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page5
8608:             loc_oGrd     = loc_oPgConsP.grd_4c_GrdCons
8609:             loc_cCods    = ALLTRIM(loc_oGrd.Column8.Text1.Value)
8610:             loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCat", ;
8611:                 "cursor_4c_BuscaCat", "Cods", loc_cCods, "Categoria")
8612:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
8613:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
8614:             loc_oBusca.Show()
8615:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
8616:                 loc_cCods  = ALLTRIM(cursor_4c_BuscaCat.Cods)
8617:                 loc_cDescs = ALLTRIM(cursor_4c_BuscaCat.Descs)
8618:                 IF USED("cursor_4c_ConsP") AND !EOF("cursor_4c_ConsP")
8619:                     REPLACE cursor_4c_ConsP.Ccats WITH loc_cCods
8620:                     REPLACE cursor_4c_ConsP.DCats WITH loc_cDescs
8621:                 ENDIF
8622:                 loc_oGrd.Column8.Text1.Value = loc_cCods
8623:                 loc_oGrd.Column9.Text1.Value = loc_cDescs
8624:                 loc_oGrd.Refresh()
8625:             ENDIF
8626:             IF USED("cursor_4c_BuscaCat")
8627:                 USE IN cursor_4c_BuscaCat
8628:             ENDIF
8629:             loc_oBusca.Release()
8630:         CATCH TO loc_oErro
8631:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de categoria")
8632:         ENDTRY
8633:     ENDPROC
8634: 
8635:     *==========================================================================
8636:     * ConfigurarPgPgDadosFaseP - PgDadosFaseP (Page4 do pgf_4c_DadosInterno)
8637:     * GradFase (5 col), grdMatrizes (4 col), controles de produto
8638:     * Posicoes: original_top + 29
8639:     *==========================================================================
8640:     PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP(par_oPage)
8641:         LOCAL loc_oGrd, loc_oGrd2, loc_oErro
8642:         TRY
8643:             *-- === Cursores placeholder ANTES dos grids ===
8644:             SET NULL ON
8645:             IF USED("cursor_4c_PrfFase")
8646:                 USE IN cursor_4c_PrfFase
8647:             ENDIF
8648:             CREATE CURSOR cursor_4c_PrfFase (;
8649:                 CIdChaves C(20)  NULL, ;
8650:                 Ordems    N(2,0) NULL, ;
8651:                 Grupos    C(10)  NULL, ;
8652:                 Descrs    C(50)  NULL, ;
8653:                 UniPrdts  C(10)  NULL, ;
8654:                 MatPrdts  C(15)  NULL  ;
8655:             )
8656:             IF USED("cursor_4c_Mtz")
8657:                 USE IN cursor_4c_Mtz
8658:             ENDIF
8659:             CREATE CURSOR cursor_4c_Mtz (;
8660:                 CIdChaves C(20)  NULL, ;
8661:                 CMats     C(14)  NULL, ;
8662:                 DPros     C(65)  NULL, ;
8663:                 Locals    C(10)  NULL, ;
8664:                 Qtds      N(3,0) NULL  ;
8665:             )
8666:             SET NULL OFF
8667: 
8668:             *-- === Shape fundo imagem fase (shpFig, top=152+29=181, left=231, w=244, h=148) ===
8669:             par_oPage.AddObject("shp_4c_ShpFig", "Shape")
8670:             WITH par_oPage.shp_4c_ShpFig
8671:                 .Top    = 181
8672:                 .Left   = 231
8673:                 .Width  = 244
8674:                 .Height = 148
8675:                 .BackColor   = RGB(255,255,255)
8676:                 .BorderStyle = 1
8677:                 .Visible     = .T.
8678:             ENDWITH
8679: 
8680:             *-- === Imagem fase (ImgFigJpg, top=153+29=182, left=232, w=241, h=146) ===

*-- Linhas 9065 a 9168:
9065:             loc_oGrd.Column5.Width            = 75
9066:             loc_oGrd.Column5.Header1.FontBold = .T.
9067: 
9068:             *-- BINDEVENTs para GradFase
9069:             BINDEVENT(loc_oGrd,             "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
9070:             BINDEVENT(loc_oGrd.Column1.Text1, "GotFocus",         THIS, "GradFaseCol1GotFocus")
9071:             BINDEVENT(loc_oGrd.Column1.Text1, "LostFocus",        THIS, "GradFaseCol1LostFocus")
9072:             BINDEVENT(loc_oGrd.Column2.Text1, "KeyPress",         THIS, "GradFaseCol2KeyPress")
9073:             BINDEVENT(loc_oGrd.Column4.Text1, "KeyPress",         THIS, "GradFaseCol4KeyPress")
9074:             BINDEVENT(loc_oGrd.Column5.Text1, "KeyPress",         THIS, "GradFaseCol5KeyPress")
9075: 
9076:             *-- === Botao Incluir fase (inserir, top=152+29=181, left=950, w=40, h=40) ===
9077:             par_oPage.AddObject("cmd_4c_Incluir", "CommandButton")
9078:             WITH par_oPage.cmd_4c_Incluir
9079:                 .Top     = 181
9080:                 .Left   = 950
9081:                 .Width   = 40
9082:                 .Height = 40
9083:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
9084:                 .Caption = ""
9085:                 .FontName = "Tahoma"
9086:                 .FontSize = 8
9087:                 .Themes  = .F.
9088:                 .Visible = .T.
9089:             ENDWITH
9090: 
9091:             *-- === Botao Excluir fase (excluir, top=192+29=221, left=950, w=40, h=40) ===
9092:             par_oPage.AddObject("cmd_4c_Excluir", "CommandButton")
9093:             WITH par_oPage.cmd_4c_Excluir
9094:                 .Top     = 221
9095:                 .Left   = 950
9096:                 .Width   = 40
9097:                 .Height = 40
9098:                 .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
9099:                 .Caption = ""
9100:                 .FontName = "Tahoma"
9101:                 .FontSize = 8
9102:                 .Themes  = .F.
9103:                 .Visible = .T.
9104:             ENDWITH
9105: 
9106:             *-- === Botao Alternativa (Alternativa, top=232+29=261, left=950, w=40, h=40) ===
9107:             par_oPage.AddObject("cmd_4c_Alternativa", "CommandButton")
9108:             WITH par_oPage.cmd_4c_Alternativa
9109:                 .Top     = 261
9110:                 .Left   = 950
9111:                 .Width   = 40
9112:                 .Height = 40
9113:                 .Picture = gc_4c_CaminhoIcones + "cadastro_alterar_26.jpg"
9114:                 .Caption = ""
9115:                 .FontName = "Tahoma"
9116:                 .FontSize = 8
9117:                 .Themes  = .F.
9118:                 .Visible = .T.
9119:             ENDWITH
9120: 
9121:             *-- BINDEVENTs para botoes do GradFase
9122:             BINDEVENT(par_oPage.cmd_4c_Incluir,    "Click", THIS, "FasePIncluirClick")
9123:             BINDEVENT(par_oPage.cmd_4c_Excluir,    "Click", THIS, "FasePExcluirClick")
9124:             BINDEVENT(par_oPage.cmd_4c_Alternativa,"Click", THIS, "FasePAlternativaClick")
9125:             BINDEVENT(par_oPage.cmd_4c_CmdFicha,   "Click", THIS, "FasePCmdFichaClick")
9126:             BINDEVENT(par_oPage.cmd_4c_CmdgFigura, "Click", THIS, "FasePCmdgFiguraClick")
9127:             BINDEVENT(par_oPage.cmd_4c_CmdgFigCam, "Click", THIS, "FasePCmdgFigCamClick")
9128:             BINDEVENT(par_oPage.img_4c_ImgFigJpg,  "Click", THIS, "FasePImgFigJpgClick")
9129: 
9130:             *-- === Label "Descricao :" (Say1, top=474+29=503, left=527, w=67, h=17) ===
9131:             par_oPage.AddObject("lbl_4c_Label1", "Label")
9132:             WITH par_oPage.lbl_4c_Label1
9133:                 .Top = 503
9134:                 .Left = 527
9135:                 .Width = 67
9136:                 .Height = 17
9137:                 .FontName = "Tahoma"
9138:                 .FontSize = 8
9139:                 .BackStyle = 0
9140:                 .Caption = "Descri" + CHR(231) + CHR(227) + "o :"
9141:                 .Visible = .T.
9142:             ENDWITH
9143: 
9144:             *-- === TextBox Desc (Get_Desc, top=471+29=500, left=595, w=395, h=23) ===
9145:             par_oPage.AddObject("txt_4c_Desc", "TextBox")
9146:             WITH par_oPage.txt_4c_Desc
9147:                 .Top = 500
9148:                 .Left = 595
9149:                 .Width = 395
9150:                 .Height = 23
9151:                 .FontName = "Tahoma"
9152:                 .FontSize = 8
9153:                 .Themes = .F.
9154:                 .Visible = .T.
9155:             ENDWITH
9156: 
9157:             *-- === EditBox Obs (Get_Obs, top=497+29=526, left=527, w=463, h=122) ===
9158:             par_oPage.AddObject("edt_4c_Get_Obs", "EditBox")
9159:             WITH par_oPage.edt_4c_Get_Obs
9160:                 .Top = 526
9161:                 .Left = 527
9162:                 .Width = 463
9163:                 .Height = 122
9164:                 .FontName = "Tahoma"
9165:                 .FontSize = 8
9166:                 .ScrollBars = 2
9167:                 .Themes = .F.
9168:                 .Visible = .T.

*-- Linhas 9184 a 9394:
9184:             loc_oGrd2.RowHeight   = 16
9185:             loc_oGrd2.ScrollBars  = 3
9186:             loc_oGrd2.Themes      = .F.
9187:             loc_oGrd2.Visible     = .T.
9188: 
9189:             loc_oGrd2.RecordSource = "cursor_4c_Mtz"
9190: 
9191:             loc_oGrd2.Column1.Header1.Caption  = "Matriz"
9192:             loc_oGrd2.Column1.ControlSource    = "cursor_4c_Mtz.CMats"
9193:             loc_oGrd2.Column1.Width            = 60
9194:             loc_oGrd2.Column1.Header1.FontBold = .T.
9195: 
9196:             loc_oGrd2.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
9197:             loc_oGrd2.Column2.ControlSource    = "cursor_4c_Mtz.DPros"
9198:             loc_oGrd2.Column2.Width            = 100
9199:             loc_oGrd2.Column2.ReadOnly         = .T.
9200:             loc_oGrd2.Column2.Header1.FontBold = .T.
9201: 
9202:             loc_oGrd2.Column3.Header1.Caption  = "Local"
9203:             loc_oGrd2.Column3.ControlSource    = "cursor_4c_Mtz.Locals"
9204:             loc_oGrd2.Column3.Width            = 50
9205:             loc_oGrd2.Column3.ReadOnly         = .T.
9206:             loc_oGrd2.Column3.Header1.FontBold = .T.
9207: 
9208:             loc_oGrd2.Column4.Header1.Caption  = "Qtde"
9209:             loc_oGrd2.Column4.ControlSource    = "cursor_4c_Mtz.Qtds"
9210:             loc_oGrd2.Column4.Width            = 36
9211:             loc_oGrd2.Column4.Header1.FontBold = .T.
9212: 
9213:             *-- BINDEVENTs para Matrizes
9214:             BINDEVENT(loc_oGrd2,              "AfterRowColChange", THIS, "MatrizesAfterRowColChange")
9215:             BINDEVENT(loc_oGrd2.Column1.Text1, "GotFocus",         THIS, "MatrizesCol1GotFocus")
9216:             BINDEVENT(loc_oGrd2.Column1.Text1, "KeyPress",         THIS, "MatrizesCol1KeyPress")
9217: 
9218:             *-- === Botao Inserir Matriz (btnInsereMtx, top=380+29=409, left=258, w=40, h=40) ===
9219:             par_oPage.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
9220:             WITH par_oPage.cmd_4c_BtnInsereMtx
9221:                 .Top     = 409
9222:                 .Left   = 258
9223:                 .Width   = 40
9224:                 .Height = 40
9225:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
9226:                 .Caption = ""
9227:                 .FontName = "Tahoma"
9228:                 .FontSize = 8
9229:                 .Themes  = .F.
9230:                 .Visible = .T.
9231:             ENDWITH
9232: 
9233:             *-- === Botao Excluir Matriz (btnExcluiMtz, top=420+29=449, left=258, w=40, h=40) ===
9234:             par_oPage.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
9235:             WITH par_oPage.cmd_4c_BtnExcluiMtz
9236:                 .Top     = 449
9237:                 .Left   = 258
9238:                 .Width   = 40
9239:                 .Height = 40
9240:                 .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
9241:                 .Caption = ""
9242:                 .FontName = "Tahoma"
9243:                 .FontSize = 8
9244:                 .Themes  = .F.
9245:                 .Visible = .T.
9246:             ENDWITH
9247: 
9248:             *-- BINDEVENTs botoes Matrizes
9249:             BINDEVENT(par_oPage.cmd_4c_BtnInsereMtx, "Click", THIS, "FasePBtnInsereMtxClick")
9250:             BINDEVENT(par_oPage.cmd_4c_BtnExcluiMtz, "Click", THIS, "FasePBtnExcluiMtzClick")
9251: 
9252:             *-- === Shape fundo borracha (shpBorracha, top=464+29=493, left=258, w=236, h=156) ===
9253:             par_oPage.AddObject("shp_4c_ShpBorracha", "Shape")
9254:             WITH par_oPage.shp_4c_ShpBorracha
9255:                 .Top    = 493
9256:                 .Left   = 258
9257:                 .Width  = 236
9258:                 .Height = 156
9259:                 .BackColor   = RGB(255,255,255)
9260:                 .BorderStyle = 1
9261:                 .Visible     = .T.
9262:             ENDWITH
9263: 
9264:             *-- === Imagem borracha/matriz (ImgBorracha, top=465+29=494, left=260, w=232, h=154) ===
9265:             par_oPage.AddObject("img_4c_ImgBorracha", "Image")
9266:             WITH par_oPage.img_4c_ImgBorracha
9267:                 .Top     = 494
9268:                 .Left    = 260
9269:                 .Width   = 232
9270:                 .Height  = 154
9271:                 .Stretch = 2
9272:                 .Visible = .F.
9273:             ENDWITH
9274: 
9275:             *-- BINDEVENTs controles de produto (FaseP)
9276:             BINDEVENT(par_oPage.txt_4c_codacb,   "KeyPress", THIS, "FasePCodAcbKeyPress")
9277:             BINDEVENT(par_oPage.txt_4c_Tam,       "KeyPress", THIS, "FasePTamKeyPress")
9278:             BINDEVENT(par_oPage.txt_4c_Cor,       "KeyPress", THIS, "FasePCorKeyPress")
9279:             BINDEVENT(par_oPage.txt_4c_Conquilha, "KeyPress", THIS, "FasePConquilhaKeyPress")
9280: 
9281:         CATCH TO loc_oErro
9282:             MsgErro(loc_oErro.Message, "Erro ao configurar p" + CHR(225) + "gina Fase P")
9283:         ENDTRY
9284:     ENDPROC
9285: 
9286:     *==========================================================================
9287:     * BOParaFormFaseP - Preenche controles da pagina FaseP com dados do BO
9288:     *==========================================================================
9289:     PROTECTED PROCEDURE BOParaFormFaseP()
9290:         LOCAL loc_oPgFaseP, loc_oBO, loc_oErro
9291:         TRY
9292:             loc_oBO     = this_oBusinessObject
9293:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9294: 
9295:             *-- Campos proprios da FaseP (SigCdPro)
9296:             loc_oPgFaseP.txt_4c_Qmin.Value         = NVL(loc_oBO.this_nQtMinFabs, 0)
9297:             loc_oPgFaseP.txt_4c_CodGarras.Value     = ALLTRIM(NVL(loc_oBO.this_cCodGarras, ""))
9298:             loc_oPgFaseP.txt_4c_Conquilha.Value     = ALLTRIM(NVL(loc_oBO.this_cConquilhas,""))
9299:             loc_oPgFaseP.txt_4c_PesoBris.Value      = NVL(loc_oBO.this_nPesoBris, 0)
9300:             loc_oPgFaseP.txt_4c_PesoMetal.Value     = NVL(loc_oBO.this_nPesoMetal, 0)
9301:             loc_oPgFaseP.txt_4c_PesoPdrs.Value      = NVL(loc_oBO.this_nPesoPdrs, 0)
9302:             loc_oPgFaseP.chk_4c_Opc_CravCera.Value  = IIF(IIF(VARTYPE(loc_oBO.this_nCravCers) = "L", loc_oBO.this_nCravCers, (NVL(loc_oBO.this_nCravCers, 0) = 1)), 1, 0)
9303:             loc_oPgFaseP.chk_4c_Fwoption1.Value     = IIF(IIF(VARTYPE(loc_oBO.this_nVarias) = "L", loc_oBO.this_nVarias, (NVL(loc_oBO.this_nVarias, 0) = 1)), 1, 0)
9304: 
9305:             *-- Campos espelhados de PgDados (Cor, Tam, Acabamento)
9306:             loc_oPgFaseP.txt_4c_Cor.Value    = ALLTRIM(NVL(loc_oBO.this_cCorPros, ""))
9307:             loc_oPgFaseP.txt_4c_Tam.Value    = ALLTRIM(NVL(loc_oBO.this_cTams,    ""))
9308:             loc_oPgFaseP.txt_4c_codacb.Value = ALLTRIM(NVL(loc_oBO.this_cCodAcbs, ""))
9309: 
9310:             *-- Carregar descricao de acabamento via lookup
9311:             IF !EMPTY(ALLTRIM(NVL(loc_oBO.this_cCodAcbs, "")))
9312:                 THIS.CarregarDescricaoLookup("SigCdAca", "Cods", "Descrs", ;
9313:                     ALLTRIM(loc_oBO.this_cCodAcbs), loc_oPgFaseP.txt_4c_Dacb)
9314:             ELSE
9315:                 loc_oPgFaseP.txt_4c_Dacb.Value = ""
9316:             ENDIF
9317: 
9318:         CATCH TO loc_oErro
9319:             MsgErro(loc_oErro.Message, "Erro ao preencher campos Fase P")
9320:         ENDTRY
9321:     ENDPROC
9322: 
9323:     *==========================================================================
9324:     * FormParaBOFaseP - Le controles da pagina FaseP e envia para o BO
9325:     *==========================================================================
9326:     PROTECTED PROCEDURE FormParaBOFaseP()
9327:         LOCAL loc_oPgFaseP, loc_oBO, loc_oErro
9328:         TRY
9329:             loc_oBO      = this_oBusinessObject
9330:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9331: 
9332:             loc_oBO.this_nQtMinFabs  = STR(loc_oPgFaseP.txt_4c_Qmin.Value)
9333:             loc_oBO.this_cCodGarras  = ALLTRIM(loc_oPgFaseP.txt_4c_CodGarras.Value)
9334:             loc_oBO.this_cConquilhas = ALLTRIM(loc_oPgFaseP.txt_4c_Conquilha.Value)
9335:             loc_oBO.this_nPesoBris   = STR(loc_oPgFaseP.txt_4c_PesoBris.Value)
9336:             loc_oBO.this_nPesoMetal  = STR(loc_oPgFaseP.txt_4c_PesoMetal.Value)
9337:             loc_oBO.this_nPesoPdrs   = STR(loc_oPgFaseP.txt_4c_PesoPdrs.Value)
9338:             loc_oBO.this_nCravCers   = IIF(loc_oPgFaseP.chk_4c_Opc_CravCera.Value = 1, 1, 0)
9339:             loc_oBO.this_nVarias     = IIF(loc_oPgFaseP.chk_4c_Fwoption1.Value    = 1, 1, 0)
9340: 
9341:             *-- Campos espelhados (ultimas escritas vencem)
9342:             loc_oBO.this_cCorPros = ALLTRIM(loc_oPgFaseP.txt_4c_Cor.Value)
9343:             loc_oBO.this_cTams    = ALLTRIM(loc_oPgFaseP.txt_4c_Tam.Value)
9344:             loc_oBO.this_cCodAcbs = ALLTRIM(loc_oPgFaseP.txt_4c_codacb.Value)
9345: 
9346:         CATCH TO loc_oErro
9347:             MsgErro(loc_oErro.Message, "Erro ao ler campos Fase P")
9348:         ENDTRY
9349:     ENDPROC
9350: 
9351:     *==========================================================================
9352:     * CarregarFaseP - SQLEXEC SigCdPrf -> cursor_4c_PrfFase
9353:     *==========================================================================
9354:     PROCEDURE CarregarFaseP()
9355:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgFaseP, loc_oErro, loc_lContinuar
9356:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
9357:             RETURN
9358:         ENDIF
9359:         loc_lContinuar = .T.
9360:         TRY
9361:             loc_cCPros = ALLTRIM(this_cCodigo)
9362:             IF EMPTY(loc_cCPros)
9363:                 loc_lContinuar = .F.
9364:             ENDIF
9365:             IF loc_lContinuar
9366:                 IF USED("cursor_4c_PrfFaseTemp")
9367:                     USE IN cursor_4c_PrfFaseTemp
9368:                 ENDIF
9369:                 loc_cSQL = "SELECT prf.CIdChaves, prf.Ordems, prf.Grupos, " + ;
9370:                            "ISNULL(gcr.Descrs,'') AS Descrs, " + ;
9371:                            "ISNULL(prf.UniPrdts,'') AS UniPrdts, " + ;
9372:                            "ISNULL(prf.MatPrdts,'') AS MatPrdts " + ;
9373:                            "FROM SigCdPrf prf " + ;
9374:                            "LEFT JOIN SigCdGcr gcr ON gcr.Codigos = prf.Grupos " + ;
9375:                            "WHERE prf.Produtos = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
9376:                            " ORDER BY prf.Ordems"
9377:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfFaseTemp")
9378:                 IF loc_nRet > 0
9379:                     SELECT cursor_4c_PrfFase
9380:                     ZAP
9381:                     IF RECCOUNT("cursor_4c_PrfFaseTemp") > 0
9382:                         APPEND FROM DBF("cursor_4c_PrfFaseTemp")
9383:                     ENDIF
9384:                     IF USED("cursor_4c_PrfFaseTemp")
9385:                         USE IN cursor_4c_PrfFaseTemp
9386:                     ENDIF
9387:                     SELECT cursor_4c_PrfFase
9388:                     GO TOP
9389:                     loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9390:                     loc_oPgFaseP.grd_4c_GradFase.Refresh()
9391:                     *-- Carregar imagem da primeira linha
9392:                     THIS.GradFaseAfterRowColChange(0)
9393:                 ELSE
9394:                     IF USED("cursor_4c_PrfFaseTemp")

*-- Linhas 9400 a 9499:
9400:             MsgErro(loc_oErro.Message, "Erro ao carregar Fase P")
9401:         ENDTRY
9402:     ENDPROC
9403: 
9404:     *==========================================================================
9405:     * CarregarMatrizes - SQLEXEC sigprmtz -> cursor_4c_Mtz
9406:     *==========================================================================
9407:     PROCEDURE CarregarMatrizes()
9408:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgFaseP, loc_oErro, loc_lContinuar
9409:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
9410:             RETURN
9411:         ENDIF
9412:         loc_lContinuar = .T.
9413:         TRY
9414:             loc_cCPros = ALLTRIM(this_cCodigo)
9415:             IF EMPTY(loc_cCPros)
9416:                 loc_lContinuar = .F.
9417:             ENDIF
9418:             IF loc_lContinuar
9419:                 IF USED("cursor_4c_MtzTemp")
9420:                     USE IN cursor_4c_MtzTemp
9421:                 ENDIF
9422:                 loc_cSQL = "SELECT mtz.CIdChaves, mtz.CMats, " + ;
9423:                            "ISNULL(pro.DPros,'') AS DPros, " + ;
9424:                            "ISNULL(pro.Locals,'') AS Locals, " + ;
9425:                            "ISNULL(mtz.Qtds,0) AS Qtds " + ;
9426:                            "FROM SigPrMtz mtz " + ;
9427:                            "LEFT JOIN SigCdPro pro ON pro.CPros = mtz.CMats " + ;
9428:                            "WHERE mtz.CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
9429:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MtzTemp")
9430:                 IF loc_nRet > 0
9431:                     SELECT cursor_4c_Mtz
9432:                     ZAP
9433:                     IF RECCOUNT("cursor_4c_MtzTemp") > 0
9434:                         APPEND FROM DBF("cursor_4c_MtzTemp")
9435:                     ENDIF
9436:                     IF USED("cursor_4c_MtzTemp")
9437:                         USE IN cursor_4c_MtzTemp
9438:                     ENDIF
9439:                     SELECT cursor_4c_Mtz
9440:                     GO TOP
9441:                     loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9442:                     loc_oPgFaseP.grd_4c_Matrizes.Refresh()
9443:                     *-- Carregar imagem da primeira matriz
9444:                     THIS.MatrizesAfterRowColChange(0)
9445:                 ELSE
9446:                     IF USED("cursor_4c_MtzTemp")
9447:                         USE IN cursor_4c_MtzTemp
9448:                     ENDIF
9449:                 ENDIF
9450:             ENDIF
9451:         CATCH TO loc_oErro
9452:             MsgErro(loc_oErro.Message, "Erro ao carregar Matrizes")
9453:         ENDTRY
9454:     ENDPROC
9455: 
9456:     *==========================================================================
9457:     * GradFaseAfterRowColChange - Carrega imagem FigProcs da linha atual
9458:     *==========================================================================
9459:     PROCEDURE GradFaseAfterRowColChange(par_nColIndex)
9460:         LOCAL loc_oPgFaseP, loc_cCIdChaves, loc_cArquivo, loc_nRet, loc_oErro
9461:         TRY
9462:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
9463:                 RETURN
9464:             ENDIF
9465:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9466:             loc_oPgFaseP.img_4c_ImgFigJpg.Picture = ""
9467:             loc_oPgFaseP.img_4c_ImgFigJpg.Visible = .F.
9468:             loc_oPgFaseP.txt_4c_Desc.Value    = ""
9469:             loc_oPgFaseP.edt_4c_Get_Obs.Value = ""
9470:             IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase") OR BOF("cursor_4c_PrfFase")
9471:                 RETURN
9472:             ENDIF
9473:             SELECT cursor_4c_PrfFase
9474:             loc_cCIdChaves = ALLTRIM(CIdChaves)
9475:             *-- Preencher descricao da fase atual (ja carregada no cursor)
9476:             loc_oPgFaseP.txt_4c_Desc.Value = ALLTRIM(NVL(Descrs, ""))
9477:             IF EMPTY(loc_cCIdChaves)
9478:                 RETURN
9479:             ENDIF
9480:             *-- Carregar FigProcs e Obs do banco
9481:             IF USED("cursor_4c_FigPrfTmp")
9482:                 USE IN cursor_4c_FigPrfTmp
9483:             ENDIF
9484:             loc_nRet = SQLEXEC(gnConnHandle, ;
9485:                 "SELECT FigProcs, CONVERT(NVARCHAR(MAX), obs) AS ObsText " + ;
9486:                 "FROM SigCdPrf WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves), ;
9487:                 "cursor_4c_FigPrfTmp")
9488:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_FigPrfTmp") > 0
9489:                 SELECT cursor_4c_FigPrfTmp
9490:                 *-- Preencher obs
9491:                 IF !ISNULL(ObsText)
9492:                     loc_oPgFaseP.edt_4c_Get_Obs.Value = ALLTRIM(ObsText)
9493:                 ENDIF
9494:                 *-- Exibir imagem
9495:                 IF !EMPTY(FigProcs) AND !ISNULL(FigProcs)
9496:                     loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9497:                     IF STRTOFILE(FigProcs, loc_cArquivo) > 0
9498:                         loc_oPgFaseP.img_4c_ImgFigJpg.Visible = .T.
9499:                         loc_oPgFaseP.img_4c_ImgFigJpg.Picture = loc_cArquivo

*-- Linhas 9511 a 10393:
9511:     *==========================================================================
9512:     * GradFaseCol1GotFocus - Salva valor anterior de Ordems para reordenacao
9513:     *==========================================================================
9514:     PROCEDURE GradFaseCol1GotFocus()
9515:         LOCAL loc_oErro
9516:         TRY
9517:             IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
9518:                 SELECT cursor_4c_PrfFase
9519:                 this_nAntOrd = NVL(Ordems, 0)
9520:             ENDIF
9521:         CATCH TO loc_oErro
9522:             *-- Tolerado
9523:         ENDTRY
9524:     ENDPROC
9525: 
9526:     *==========================================================================
9527:     * GradFaseCol1LostFocus - Aplica reordenacao se Ordems mudou
9528:     *==========================================================================
9529:     PROCEDURE GradFaseCol1LostFocus()
9530:         LOCAL loc_nNovoOrd, loc_cCIdChaves, loc_nRet, loc_oErro
9531:         TRY
9532:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
9533:                 RETURN
9534:             ENDIF
9535:             IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase")
9536:                 RETURN
9537:             ENDIF
9538:             SELECT cursor_4c_PrfFase
9539:             loc_nNovoOrd   = NVL(Ordems, 0)
9540:             loc_cCIdChaves = ALLTRIM(CIdChaves)
9541:             IF loc_nNovoOrd > 0 AND loc_nNovoOrd <> this_nAntOrd AND !EMPTY(loc_cCIdChaves)
9542:                 loc_nRet = SQLEXEC(gnConnHandle, ;
9543:                     "UPDATE SigCdPrf SET Ordems = " + FormatarNumeroSQL(loc_nNovoOrd) + ;
9544:                     " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
9545:                 THIS.CarregarFaseP()
9546:             ENDIF
9547:         CATCH TO loc_oErro
9548:             MsgErro(loc_oErro.Message, "Erro ao reordenar fase")
9549:         ENDTRY
9550:     ENDPROC
9551: 
9552:     *==========================================================================
9553:     * GradFaseCol2KeyPress - F4 abre lookup de Fase (SigCdGcr)
9554:     *==========================================================================
9555:     PROCEDURE GradFaseCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9556:         LOCAL loc_oErro
9557:         TRY
9558:             IF par_nKeyCode = 115
9559:                 THIS.AbrirLookupGradFaseFase()
9560:             ENDIF
9561:         CATCH TO loc_oErro
9562:             *-- Tolerado
9563:         ENDTRY
9564:     ENDPROC
9565: 
9566:     *==========================================================================
9567:     * GradFaseCol4KeyPress - F4 abre lookup de Unidade Produtiva (SigCdUpd)
9568:     *==========================================================================
9569:     PROCEDURE GradFaseCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9570:         LOCAL loc_oErro
9571:         TRY
9572:             IF par_nKeyCode = 115
9573:                 THIS.AbrirLookupGradFaseUpd()
9574:             ENDIF
9575:         CATCH TO loc_oErro
9576:             *-- Tolerado
9577:         ENDTRY
9578:     ENDPROC
9579: 
9580:     *==========================================================================
9581:     * GradFaseCol5KeyPress - F4 abre lookup de Material (SigOpOpt)
9582:     *==========================================================================
9583:     PROCEDURE GradFaseCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9584:         LOCAL loc_oErro
9585:         TRY
9586:             IF par_nKeyCode = 115
9587:                 THIS.AbrirLookupGradFaseOpt()
9588:             ENDIF
9589:         CATCH TO loc_oErro
9590:             *-- Tolerado
9591:         ENDTRY
9592:     ENDPROC
9593: 
9594:     *==========================================================================
9595:     * FasePIncluirClick - Insere nova linha em GradFase (SigCdPrf)
9596:     *==========================================================================
9597:     PROCEDURE FasePIncluirClick()
9598:         LOCAL loc_nRet, loc_cCPros, loc_oErro, loc_lContinuar, loc_cGrupos, loc_nOrdems
9599:         loc_lContinuar = .T.
9600:         TRY
9601:             IF !this_lEmEdicao
9602:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
9603:                 loc_lContinuar = .F.
9604:             ENDIF
9605:             IF loc_lContinuar
9606:                 loc_cCPros = ALLTRIM(this_cCodigo)
9607:                 IF EMPTY(loc_cCPros)
9608:                     MsgAviso("Salve o produto antes de adicionar fases.", "Aviso")
9609:                     loc_lContinuar = .F.
9610:                 ENDIF
9611:             ENDIF
9612:             IF loc_lContinuar AND gnConnHandle > 0
9613:                 *-- Calcular proximo Ordems
9614:                 IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
9615:                     SELECT cursor_4c_PrfFase
9616:                     loc_cGrupos = ALLTRIM(Grupos)
9617:                     GO BOTTOM
9618:                     loc_nOrdems = NVL(Ordems, 0) + 1
9619:                     GO TOP
9620:                 ELSE
9621:                     loc_cGrupos = ""
9622:                     loc_nOrdems = 1
9623:                 ENDIF
9624:                 loc_nRet = SQLEXEC(gnConnHandle, ;
9625:                     "INSERT INTO SigCdPrf (Produtos, Ordems, Grupos, CIdChaves) VALUES (" + ;
9626:                     EscaparSQL(PADR(loc_cCPros, 14)) + ", " + ;
9627:                     FormatarNumeroSQL(loc_nOrdems) + ", " + ;
9628:                     EscaparSQL(PADR(loc_cGrupos, 10)) + ", NEWID())")
9629:                 IF loc_nRet < 1
9630:                     MsgErro("Erro ao incluir linha de fase.", "Erro")
9631:                 ELSE
9632:                     THIS.CarregarFaseP()
9633:                     *-- Posicionar na nova linha (ultima)
9634:                     IF USED("cursor_4c_PrfFase")
9635:                         SELECT cursor_4c_PrfFase
9636:                         GO BOTTOM
9637:                     ENDIF
9638:                 ENDIF
9639:             ENDIF
9640:         CATCH TO loc_oErro
9641:             MsgErro(loc_oErro.Message, "Erro ao incluir fase")
9642:         ENDTRY
9643:     ENDPROC
9644: 
9645:     *==========================================================================
9646:     * FasePExcluirClick - Exclui linha atual de GradFase (SigCdPrf)
9647:     *==========================================================================
9648:     PROCEDURE FasePExcluirClick()
9649:         LOCAL loc_nRet, loc_cCIdChaves, loc_lConfirmou, loc_oErro, loc_lContinuar
9650:         loc_lContinuar = .T.
9651:         TRY
9652:             IF !this_lEmEdicao
9653:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
9654:                 loc_lContinuar = .F.
9655:             ENDIF
9656:             IF loc_lContinuar
9657:                 IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase") OR BOF("cursor_4c_PrfFase")
9658:                     loc_lContinuar = .F.
9659:                 ENDIF
9660:             ENDIF
9661:             IF loc_lContinuar
9662:                 SELECT cursor_4c_PrfFase
9663:                 loc_cCIdChaves = ALLTRIM(CIdChaves)
9664:                 IF EMPTY(loc_cCIdChaves)
9665:                     loc_lContinuar = .F.
9666:                 ENDIF
9667:             ENDIF
9668:             IF loc_lContinuar
9669:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta fase?", "Confirmar")
9670:                 IF loc_lConfirmou AND gnConnHandle > 0
9671:                     loc_nRet = SQLEXEC(gnConnHandle, ;
9672:                         "DELETE FROM SigCdPrf WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
9673:                     THIS.CarregarFaseP()
9674:                 ENDIF
9675:             ENDIF
9676:         CATCH TO loc_oErro
9677:             MsgErro(loc_oErro.Message, "Erro ao excluir fase")
9678:         ENDTRY
9679:     ENDPROC
9680: 
9681:     *==========================================================================
9682:     * FasePAlternativaClick - Insere fase alternativa (copia grupos da atual)
9683:     *==========================================================================
9684:     PROCEDURE FasePAlternativaClick()
9685:         LOCAL loc_nRet, loc_cCPros, loc_cGrupos, loc_nOrdems, loc_oErro, loc_lContinuar
9686:         loc_lContinuar = .T.
9687:         TRY
9688:             IF !this_lEmEdicao
9689:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
9690:                 loc_lContinuar = .F.
9691:             ENDIF
9692:             IF loc_lContinuar
9693:                 loc_cCPros = ALLTRIM(this_cCodigo)
9694:                 IF EMPTY(loc_cCPros)
9695:                     loc_lContinuar = .F.
9696:                 ENDIF
9697:             ENDIF
9698:             IF loc_lContinuar
9699:                 IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase")
9700:                     MsgAviso("Selecione uma fase antes de inserir alternativa.", "Aviso")
9701:                     loc_lContinuar = .F.
9702:                 ENDIF
9703:             ENDIF
9704:             IF loc_lContinuar AND gnConnHandle > 0
9705:                 SELECT cursor_4c_PrfFase
9706:                 loc_cGrupos = ALLTRIM(Grupos)
9707:                 loc_nOrdems = NVL(Ordems, 0)
9708:                 *-- Inserir alternativa logo apos a atual (Ordems atual + 0.5 => usa Ordems+1 e reordena depois)
9709:                 GO BOTTOM
9710:                 loc_nOrdems = NVL(Ordems, 0) + 1
9711:                 GO TOP
9712:                 loc_nRet = SQLEXEC(gnConnHandle, ;
9713:                     "INSERT INTO SigCdPrf (Produtos, Ordems, Grupos, CIdChaves) VALUES (" + ;
9714:                     EscaparSQL(PADR(loc_cCPros, 14)) + ", " + ;
9715:                     FormatarNumeroSQL(loc_nOrdems) + ", " + ;
9716:                     EscaparSQL(PADR(loc_cGrupos, 10)) + ", NEWID())")
9717:                 IF loc_nRet < 1
9718:                     MsgErro("Erro ao incluir alternativa de fase.", "Erro")
9719:                 ELSE
9720:                     THIS.CarregarFaseP()
9721:                     IF USED("cursor_4c_PrfFase")
9722:                         SELECT cursor_4c_PrfFase
9723:                         GO BOTTOM
9724:                     ENDIF
9725:                 ENDIF
9726:             ENDIF
9727:         CATCH TO loc_oErro
9728:             MsgErro(loc_oErro.Message, "Erro ao incluir alternativa de fase")
9729:         ENDTRY
9730:     ENDPROC
9731: 
9732:     *==========================================================================
9733:     * FasePCmdFichaClick - Ficha tecnica da fase (relatorio legado)
9734:     *==========================================================================
9735:     PROCEDURE FasePCmdFichaClick()
9736:         LOCAL loc_oErro
9737:         TRY
9738:             MsgInfo("Ficha T" + CHR(233) + "cnica: funcionalidade dispon" + CHR(237) + "vel no sistema legado.", "Informa" + CHR(231) + CHR(227) + "o")
9739:         CATCH TO loc_oErro
9740:             *-- Tolerado
9741:         ENDTRY
9742:     ENDPROC
9743: 
9744:     *==========================================================================
9745:     * FasePImgFigJpgClick - Exibe imagem em tamanho ampliado
9746:     *==========================================================================
9747:     PROCEDURE FasePImgFigJpgClick()
9748:         LOCAL loc_oPgFaseP, loc_cArquivo, loc_oErro
9749:         TRY
9750:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9751:             loc_cArquivo = loc_oPgFaseP.img_4c_ImgFigJpg.Picture
9752:             IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
9753:                 ShellExecute(0, "open", loc_cArquivo, "", "", 1)
9754:             ENDIF
9755:         CATCH TO loc_oErro
9756:             *-- Tolerado
9757:         ENDTRY
9758:     ENDPROC
9759: 
9760:     *==========================================================================
9761:     * FasePCmdgFiguraClick - Selecionar imagem JPG/BMP para a fase
9762:     *==========================================================================
9763:     PROCEDURE FasePCmdgFiguraClick()
9764:         LOCAL loc_cArquivo, loc_cDados, loc_cCIdChaves, loc_nRet, loc_oPgFaseP, loc_oErro
9765:         LOCAL loc_lContinuar, loc_cArqTemp
9766:         loc_lContinuar = .T.
9767:         TRY
9768:             IF !this_lEmEdicao
9769:                 loc_lContinuar = .F.
9770:             ENDIF
9771:             IF loc_lContinuar
9772:                 IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase")
9773:                     loc_lContinuar = .F.
9774:                 ENDIF
9775:             ENDIF
9776:             IF loc_lContinuar
9777:                 SELECT cursor_4c_PrfFase
9778:                 loc_cCIdChaves = ALLTRIM(CIdChaves)
9779:                 IF EMPTY(loc_cCIdChaves)
9780:                     loc_lContinuar = .F.
9781:                 ENDIF
9782:             ENDIF
9783:             IF loc_lContinuar AND gnConnHandle > 0
9784:                 loc_cArquivo = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Selecionar imagem")
9785:                 IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
9786:                     loc_cDados = FILETOSTR(loc_cArquivo)
9787:                     IF !EMPTY(loc_cDados)
9788:                         loc_nRet = SQLEXEC(gnConnHandle, ;
9789:                             "UPDATE SigCdPrf SET FigProcs = " + EscaparSQL(loc_cDados) + ;
9790:                             " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
9791:                         IF loc_nRet > 0
9792:                             *-- Exibir imagem
9793:                             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9794:                             loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
9795:                             IF STRTOFILE(loc_cDados, loc_cArqTemp) > 0
9796:                                 loc_oPgFaseP.img_4c_ImgFigJpg.Visible = .T.
9797:                                 loc_oPgFaseP.img_4c_ImgFigJpg.Picture = loc_cArqTemp
9798:                             ENDIF
9799:                         ENDIF
9800:                     ENDIF
9801:                 ENDIF
9802:             ENDIF
9803:         CATCH TO loc_oErro
9804:             MsgErro(loc_oErro.Message, "Erro ao carregar imagem da fase")
9805:         ENDTRY
9806:     ENDPROC
9807: 
9808:     *==========================================================================
9809:     * FasePCmdgFigCamClick - Captura de imagem via camera
9810:     *==========================================================================
9811:     PROCEDURE FasePCmdgFigCamClick()
9812:         LOCAL loc_oErro
9813:         TRY
9814:             MsgInfo("Captura de imagem por c" + CHR(226) + "mera n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Informa" + CHR(231) + CHR(227) + "o")
9815:         CATCH TO loc_oErro
9816:             *-- Tolerado
9817:         ENDTRY
9818:     ENDPROC
9819: 
9820:     *==========================================================================
9821:     * MatrizesAfterRowColChange - Carrega imagem borracha da matriz atual
9822:     *==========================================================================
9823:     PROCEDURE MatrizesAfterRowColChange(par_nColIndex)
9824:         LOCAL loc_oPgFaseP, loc_cCMats, loc_nRet, loc_oErro, loc_cArquivo
9825:         TRY
9826:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
9827:                 RETURN
9828:             ENDIF
9829:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9830:             loc_oPgFaseP.img_4c_ImgBorracha.Picture = ""
9831:             loc_oPgFaseP.img_4c_ImgBorracha.Visible = .F.
9832:             IF !USED("cursor_4c_Mtz") OR EOF("cursor_4c_Mtz") OR BOF("cursor_4c_Mtz")
9833:                 RETURN
9834:             ENDIF
9835:             SELECT cursor_4c_Mtz
9836:             loc_cCMats = ALLTRIM(CMats)
9837:             IF EMPTY(loc_cCMats)
9838:                 RETURN
9839:             ENDIF
9840:             *-- Buscar imagem do produto matriz
9841:             IF USED("cursor_4c_MtzImgTmp")
9842:                 USE IN cursor_4c_MtzImgTmp
9843:             ENDIF
9844:             loc_nRet = SQLEXEC(gnConnHandle, ;
9845:                 "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + EscaparSQL(PADR(loc_cCMats, 14)), ;
9846:                 "cursor_4c_MtzImgTmp")
9847:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_MtzImgTmp") > 0
9848:                 SELECT cursor_4c_MtzImgTmp
9849:                 IF !EMPTY(FigJpgs) AND !ISNULL(FigJpgs)
9850:                     loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9851:                     IF STRTOFILE(FigJpgs, loc_cArquivo) > 0
9852:                         loc_oPgFaseP.img_4c_ImgBorracha.Visible = .T.
9853:                         loc_oPgFaseP.img_4c_ImgBorracha.Picture = loc_cArquivo
9854:                     ENDIF
9855:                 ENDIF
9856:             ENDIF
9857:             IF USED("cursor_4c_MtzImgTmp")
9858:                 USE IN cursor_4c_MtzImgTmp
9859:             ENDIF
9860:         CATCH TO loc_oErro
9861:             *-- Tolerado: exibicao de imagem nao critica
9862:         ENDTRY
9863:     ENDPROC
9864: 
9865:     *==========================================================================
9866:     * MatrizesCol1GotFocus - Salva valor anterior de CMats para validacao
9867:     *==========================================================================
9868:     PROCEDURE MatrizesCol1GotFocus()
9869:         LOCAL loc_oGrd2, loc_oErro, loc_oPgFaseP
9870:         TRY
9871:             IF USED("cursor_4c_Mtz") AND !EOF("cursor_4c_Mtz")
9872:                 loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9873:                 loc_oGrd2 = loc_oPgFaseP.grd_4c_Matrizes
9874:                 loc_oGrd2.Column1.Text1.Tag = PADR(loc_oGrd2.Column1.Text1.Value, 14)
9875:             ENDIF
9876:         CATCH TO loc_oErro
9877:             *-- Tolerado
9878:         ENDTRY
9879:     ENDPROC
9880: 
9881:     *==========================================================================
9882:     * MatrizesCol1KeyPress - F4 abre lookup de Produto-Matriz (SigCdPro)
9883:     *==========================================================================
9884:     PROCEDURE MatrizesCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9885:         LOCAL loc_oErro
9886:         TRY
9887:             IF par_nKeyCode = 115
9888:                 THIS.AbrirLookupMatrizesCol1()
9889:             ENDIF
9890:         CATCH TO loc_oErro
9891:             *-- Tolerado
9892:         ENDTRY
9893:     ENDPROC
9894: 
9895:     *==========================================================================
9896:     * FasePBtnInsereMtxClick - Insere nova linha em grdMatrizes (SigPrMtz)
9897:     *==========================================================================
9898:     PROCEDURE FasePBtnInsereMtxClick()
9899:         LOCAL loc_nRet, loc_cCPros, loc_oErro, loc_lContinuar
9900:         loc_lContinuar = .T.
9901:         TRY
9902:             IF !this_lEmEdicao
9903:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
9904:                 loc_lContinuar = .F.
9905:             ENDIF
9906:             IF loc_lContinuar
9907:                 loc_cCPros = ALLTRIM(this_cCodigo)
9908:                 IF EMPTY(loc_cCPros)
9909:                     loc_lContinuar = .F.
9910:                 ENDIF
9911:             ENDIF
9912:             IF loc_lContinuar AND gnConnHandle > 0
9913:                 loc_nRet = SQLEXEC(gnConnHandle, ;
9914:                     "INSERT INTO SigPrMtz (CPros, CMats, Qtds, CIdChaves) VALUES (" + ;
9915:                     EscaparSQL(PADR(loc_cCPros, 14)) + ", '', 0, NEWID())")
9916:                 IF loc_nRet < 1
9917:                     MsgErro("Erro ao incluir linha de matriz.", "Erro")
9918:                 ELSE
9919:                     THIS.CarregarMatrizes()
9920:                     IF USED("cursor_4c_Mtz")
9921:                         SELECT cursor_4c_Mtz
9922:                         GO BOTTOM
9923:                     ENDIF
9924:                 ENDIF
9925:             ENDIF
9926:         CATCH TO loc_oErro
9927:             MsgErro(loc_oErro.Message, "Erro ao incluir matriz")
9928:         ENDTRY
9929:     ENDPROC
9930: 
9931:     *==========================================================================
9932:     * FasePBtnExcluiMtzClick - Exclui linha atual de grdMatrizes (SigPrMtz)
9933:     *==========================================================================
9934:     PROCEDURE FasePBtnExcluiMtzClick()
9935:         LOCAL loc_nRet, loc_cCIdChaves, loc_lConfirmou, loc_oErro, loc_lContinuar
9936:         loc_lContinuar = .T.
9937:         TRY
9938:             IF !this_lEmEdicao
9939:                 MsgAviso("Produto n" + CHR(227) + "o est" + CHR(225) + " em modo de edi" + CHR(231) + CHR(227) + "o.", "Aviso")
9940:                 loc_lContinuar = .F.
9941:             ENDIF
9942:             IF loc_lContinuar
9943:                 IF !USED("cursor_4c_Mtz") OR EOF("cursor_4c_Mtz") OR BOF("cursor_4c_Mtz")
9944:                     loc_lContinuar = .F.
9945:                 ENDIF
9946:             ENDIF
9947:             IF loc_lContinuar
9948:                 SELECT cursor_4c_Mtz
9949:                 loc_cCIdChaves = ALLTRIM(CIdChaves)
9950:                 IF EMPTY(loc_cCIdChaves)
9951:                     loc_lContinuar = .F.
9952:                 ENDIF
9953:             ENDIF
9954:             IF loc_lContinuar
9955:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta matriz?", "Confirmar")
9956:                 IF loc_lConfirmou AND gnConnHandle > 0
9957:                     loc_nRet = SQLEXEC(gnConnHandle, ;
9958:                         "DELETE FROM SigPrMtz WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
9959:                     THIS.CarregarMatrizes()
9960:                 ENDIF
9961:             ENDIF
9962:         CATCH TO loc_oErro
9963:             MsgErro(loc_oErro.Message, "Erro ao excluir matriz")
9964:         ENDTRY
9965:     ENDPROC
9966: 
9967:     *==========================================================================
9968:     * FasePCodAcbKeyPress - F4 abre lookup de Acabamento (SigCdAca)
9969:     *==========================================================================
9970:     PROCEDURE FasePCodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9971:         LOCAL loc_oErro
9972:         TRY
9973:             IF par_nKeyCode = 115
9974:                 THIS.AbrirLookupCodAcbFaseP()
9975:             ENDIF
9976:         CATCH TO loc_oErro
9977:             *-- Tolerado
9978:         ENDTRY
9979:     ENDPROC
9980: 
9981:     *==========================================================================
9982:     * FasePTamKeyPress - F4 abre lookup de Tamanho (SigCdTam)
9983:     *==========================================================================
9984:     PROCEDURE FasePTamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9985:         LOCAL loc_oErro
9986:         TRY
9987:             IF par_nKeyCode = 115
9988:                 THIS.AbrirLookupTamFaseP()
9989:             ENDIF
9990:         CATCH TO loc_oErro
9991:             *-- Tolerado
9992:         ENDTRY
9993:     ENDPROC
9994: 
9995:     *==========================================================================
9996:     * FasePCorKeyPress - F4 abre lookup de Cor (SigCdCor)
9997:     *==========================================================================
9998:     PROCEDURE FasePCorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9999:         LOCAL loc_oErro
10000:         TRY
10001:             IF par_nKeyCode = 115
10002:                 THIS.AbrirLookupCorFaseP()
10003:             ENDIF
10004:         CATCH TO loc_oErro
10005:             *-- Tolerado
10006:         ENDTRY
10007:     ENDPROC
10008: 
10009:     *==========================================================================
10010:     * FasePConquilhaKeyPress - F4 abre lookup de Conquilha (SigCdCnq)
10011:     *==========================================================================
10012:     PROCEDURE FasePConquilhaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10013:         LOCAL loc_oErro
10014:         TRY
10015:             IF par_nKeyCode = 115
10016:                 THIS.AbrirLookupConquilhaFaseP()
10017:             ENDIF
10018:         CATCH TO loc_oErro
10019:             *-- Tolerado
10020:         ENDTRY
10021:     ENDPROC
10022: 
10023:     *==========================================================================
10024:     * AbrirLookupGradFaseFase - Lookup SigCdGcr para Column2 (Grupos/Fase)
10025:     *==========================================================================
10026:     PROTECTED PROCEDURE AbrirLookupGradFaseFase()
10027:         LOCAL loc_oBusca, loc_cCodigos, loc_cDescrs, loc_cCIdChaves, loc_nRet, loc_oPgFaseP, loc_oGrd, loc_oErro
10028:         TRY
10029:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10030:                 RETURN
10031:             ENDIF
10032:             IF !this_lEmEdicao
10033:                 RETURN
10034:             ENDIF
10035:             IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase")
10036:                 RETURN
10037:             ENDIF
10038:             loc_oPgFaseP   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10039:             loc_oGrd       = loc_oPgFaseP.grd_4c_GradFase
10040:             loc_cCodigos   = ALLTRIM(loc_oGrd.Column2.Text1.Value)
10041:             loc_cCIdChaves = ALLTRIM(cursor_4c_PrfFase.CIdChaves)
10042:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
10043:                 "cursor_4c_BuscaGcr", "Codigos", loc_cCodigos, "Fase de Produ" + CHR(231) + CHR(227) + "o")
10044:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10045:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10046:             loc_oBusca.Show()
10047:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
10048:                 loc_cCodigos = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
10049:                 loc_cDescrs  = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
10050:                 *-- Atualizar cursor e DB
10051:                 IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
10052:                     REPLACE cursor_4c_PrfFase.Grupos WITH PADR(loc_cCodigos, 10)
10053:                     REPLACE cursor_4c_PrfFase.Descrs WITH PADR(loc_cDescrs,  50)
10054:                 ENDIF
10055:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10056:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10057:                         "UPDATE SigCdPrf SET Grupos = " + EscaparSQL(PADR(loc_cCodigos, 10)) + ;
10058:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10059:                 ENDIF
10060:                 loc_oGrd.Column2.Text1.Value = loc_cCodigos
10061:                 loc_oGrd.Column3.Text1.Value = loc_cDescrs
10062:                 loc_oGrd.Refresh()
10063:             ENDIF
10064:             IF USED("cursor_4c_BuscaGcr")
10065:                 USE IN cursor_4c_BuscaGcr
10066:             ENDIF
10067:             loc_oBusca.Release()
10068:         CATCH TO loc_oErro
10069:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de fase")
10070:         ENDTRY
10071:     ENDPROC
10072: 
10073:     *==========================================================================
10074:     * AbrirLookupGradFaseUpd - Lookup SigCdUpd para Column4 (UniPrdts)
10075:     *==========================================================================
10076:     PROTECTED PROCEDURE AbrirLookupGradFaseUpd()
10077:         LOCAL loc_oBusca, loc_cUniPrdts, loc_cCIdChaves, loc_nRet, loc_oPgFaseP, loc_oGrd, loc_oErro
10078:         TRY
10079:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10080:                 RETURN
10081:             ENDIF
10082:             IF !this_lEmEdicao
10083:                 RETURN
10084:             ENDIF
10085:             IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase")
10086:                 RETURN
10087:             ENDIF
10088:             LOCAL loc_cGruposUpd
10089:             loc_oPgFaseP   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10090:             loc_oGrd       = loc_oPgFaseP.grd_4c_GradFase
10091:             loc_cUniPrdts  = ALLTRIM(loc_oGrd.Column4.Text1.Value)
10092:             loc_cCIdChaves = ALLTRIM(cursor_4c_PrfFase.CIdChaves)
10093:             loc_cGruposUpd = ALLTRIM(cursor_4c_PrfFase.Grupos)
10094:             *-- Filtrar por Codigos = Grupos atual (conforme legado)
10095:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUpd", ;
10096:                 "cursor_4c_BuscaUpd", "UniPrdts", loc_cUniPrdts, "Unidade Produtiva", ;
10097:                 .F., .F., "Codigos = " + EscaparSQL(PADR(loc_cGruposUpd, 10)))
10098:             loc_oBusca.mAddColuna("UniPrdts", "", "Uni. Produtiva")
10099:             loc_oBusca.Show()
10100:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd")
10101:                 loc_cUniPrdts = ALLTRIM(cursor_4c_BuscaUpd.UniPrdts)
10102:                 IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
10103:                     REPLACE cursor_4c_PrfFase.UniPrdts WITH PADR(loc_cUniPrdts, 10)
10104:                 ENDIF
10105:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10106:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10107:                         "UPDATE SigCdPrf SET UniPrdts = " + EscaparSQL(PADR(loc_cUniPrdts, 10)) + ;
10108:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10109:                 ENDIF
10110:                 loc_oGrd.Column4.Text1.Value = loc_cUniPrdts
10111:                 loc_oGrd.Refresh()
10112:             ENDIF
10113:             IF USED("cursor_4c_BuscaUpd")
10114:                 USE IN cursor_4c_BuscaUpd
10115:             ENDIF
10116:             loc_oBusca.Release()
10117:         CATCH TO loc_oErro
10118:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de unidade produtiva")
10119:         ENDTRY
10120:     ENDPROC
10121: 
10122:     *==========================================================================
10123:     * AbrirLookupGradFaseOpt - Lookup SigOpOpt para Column5 (MatPrdts)
10124:     *==========================================================================
10125:     PROTECTED PROCEDURE AbrirLookupGradFaseOpt()
10126:         LOCAL loc_oBusca, loc_cMatPrdts, loc_cCIdChaves, loc_nRet, loc_oPgFaseP, loc_oGrd, loc_oErro
10127:         TRY
10128:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10129:                 RETURN
10130:             ENDIF
10131:             IF !this_lEmEdicao
10132:                 RETURN
10133:             ENDIF
10134:             IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase")
10135:                 RETURN
10136:             ENDIF
10137:             loc_oPgFaseP   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10138:             loc_oGrd       = loc_oPgFaseP.grd_4c_GradFase
10139:             loc_cMatPrdts  = ALLTRIM(loc_oGrd.Column5.Text1.Value)
10140:             loc_cCIdChaves = ALLTRIM(cursor_4c_PrfFase.CIdChaves)
10141:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigOpOpt", ;
10142:                 "cursor_4c_BuscaOpt", "Cods", loc_cMatPrdts, "Tipo de Material")
10143:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
10144:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10145:             loc_oBusca.Show()
10146:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
10147:                 loc_cMatPrdts = ALLTRIM(cursor_4c_BuscaOpt.Cods)
10148:                 IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
10149:                     REPLACE cursor_4c_PrfFase.MatPrdts WITH PADR(loc_cMatPrdts, 15)
10150:                 ENDIF
10151:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10152:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10153:                         "UPDATE SigCdPrf SET MatPrdts = " + EscaparSQL(PADR(loc_cMatPrdts, 15)) + ;
10154:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10155:                 ENDIF
10156:                 loc_oGrd.Column5.Text1.Value = loc_cMatPrdts
10157:                 loc_oGrd.Refresh()
10158:             ENDIF
10159:             IF USED("cursor_4c_BuscaOpt")
10160:                 USE IN cursor_4c_BuscaOpt
10161:             ENDIF
10162:             loc_oBusca.Release()
10163:         CATCH TO loc_oErro
10164:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de material")
10165:         ENDTRY
10166:     ENDPROC
10167: 
10168:     *==========================================================================
10169:     * AbrirLookupMatrizesCol1 - Lookup SigCdPro para Column1 de grdMatrizes
10170:     *==========================================================================
10171:     PROTECTED PROCEDURE AbrirLookupMatrizesCol1()
10172:         LOCAL loc_oBusca, loc_cCMats, loc_cDPros, loc_cLocals, loc_cCIdChaves, loc_nRet
10173:         LOCAL loc_oPgFaseP, loc_oGrd2, loc_oErro
10174:         TRY
10175:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10176:                 RETURN
10177:             ENDIF
10178:             IF !this_lEmEdicao
10179:                 RETURN
10180:             ENDIF
10181:             IF !USED("cursor_4c_Mtz") OR EOF("cursor_4c_Mtz")
10182:                 RETURN
10183:             ENDIF
10184:             loc_oPgFaseP   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10185:             loc_oGrd2      = loc_oPgFaseP.grd_4c_Matrizes
10186:             loc_cCMats     = ALLTRIM(loc_oGrd2.Column1.Text1.Value)
10187:             loc_cCIdChaves = ALLTRIM(cursor_4c_Mtz.CIdChaves)
10188:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
10189:                 "cursor_4c_BuscaMtz", "CPros", loc_cCMats, "Produto Matriz")
10190:             loc_oBusca.mAddColuna("CPros",  "", "Matriz")
10191:             loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
10192:             loc_oBusca.mAddColuna("Locals", "", "Local")
10193:             loc_oBusca.Show()
10194:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMtz")
10195:                 loc_cCMats  = ALLTRIM(cursor_4c_BuscaMtz.CPros)
10196:                 loc_cDPros  = ALLTRIM(cursor_4c_BuscaMtz.DPros)
10197:                 loc_cLocals = ALLTRIM(cursor_4c_BuscaMtz.Locals)
10198:                 IF USED("cursor_4c_Mtz") AND !EOF("cursor_4c_Mtz")
10199:                     REPLACE cursor_4c_Mtz.CMats  WITH PADR(loc_cCMats,  14)
10200:                     REPLACE cursor_4c_Mtz.DPros  WITH PADR(loc_cDPros,  65)
10201:                     REPLACE cursor_4c_Mtz.Locals WITH PADR(loc_cLocals, 10)
10202:                 ENDIF
10203:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10204:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10205:                         "UPDATE SigPrMtz SET CMats = " + EscaparSQL(PADR(loc_cCMats, 14)) + ;
10206:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10207:                 ENDIF
10208:                 loc_oGrd2.Column1.Text1.Value = loc_cCMats
10209:                 loc_oGrd2.Column2.Text1.Value = loc_cDPros
10210:                 loc_oGrd2.Column3.Text1.Value = loc_cLocals
10211:                 loc_oGrd2.Refresh()
10212:                 THIS.MatrizesAfterRowColChange(0)
10213:             ENDIF
10214:             IF USED("cursor_4c_BuscaMtz")
10215:                 USE IN cursor_4c_BuscaMtz
10216:             ENDIF
10217:             loc_oBusca.Release()
10218:         CATCH TO loc_oErro
10219:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de matriz")
10220:         ENDTRY
10221:     ENDPROC
10222: 
10223:     *==========================================================================
10224:     * AbrirLookupCodAcbFaseP - Lookup SigCdAca para txt_4c_codacb
10225:     *==========================================================================
10226:     PROTECTED PROCEDURE AbrirLookupCodAcbFaseP()
10227:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_oPgFaseP, loc_oErro
10228:         TRY
10229:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10230:                 RETURN
10231:             ENDIF
10232:             IF !this_lEmEdicao
10233:                 RETURN
10234:             ENDIF
10235:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10236:             loc_cCodigo  = ALLTRIM(loc_oPgFaseP.txt_4c_codacb.Value)
10237:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdAca", ;
10238:                 "cursor_4c_BuscaAcaFP", "Cods", loc_cCodigo, "Acabamento")
10239:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
10240:             loc_oBusca.mAddColuna("Descrs","", "Descri" + CHR(231) + CHR(227) + "o")
10241:             loc_oBusca.Show()
10242:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAcaFP")
10243:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaAcaFP.Cods)
10244:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaAcaFP.Descrs)
10245:                 loc_oPgFaseP.txt_4c_codacb.Value = loc_cCodigo
10246:                 loc_oPgFaseP.txt_4c_Dacb.Value   = loc_cDescricao
10247:             ENDIF
10248:             IF USED("cursor_4c_BuscaAcaFP")
10249:                 USE IN cursor_4c_BuscaAcaFP
10250:             ENDIF
10251:             loc_oBusca.Release()
10252:         CATCH TO loc_oErro
10253:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de acabamento")
10254:         ENDTRY
10255:     ENDPROC
10256: 
10257:     *==========================================================================
10258:     * AbrirLookupTamFaseP - Lookup SigCdTam para txt_4c_Tam
10259:     *==========================================================================
10260:     PROTECTED PROCEDURE AbrirLookupTamFaseP()
10261:         LOCAL loc_oBusca, loc_cCodigo, loc_oPgFaseP, loc_oErro
10262:         TRY
10263:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10264:                 RETURN
10265:             ENDIF
10266:             IF !this_lEmEdicao
10267:                 RETURN
10268:             ENDIF
10269:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10270:             loc_cCodigo  = ALLTRIM(loc_oPgFaseP.txt_4c_Tam.Value)
10271:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", ;
10272:                 "cursor_4c_BuscaTamFP", "Cods", loc_cCodigo, "Tamanho")
10273:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
10274:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10275:             loc_oBusca.Show()
10276:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTamFP")
10277:                 loc_oPgFaseP.txt_4c_Tam.Value = ALLTRIM(cursor_4c_BuscaTamFP.Cods)
10278:             ENDIF
10279:             IF USED("cursor_4c_BuscaTamFP")
10280:                 USE IN cursor_4c_BuscaTamFP
10281:             ENDIF
10282:             loc_oBusca.Release()
10283:         CATCH TO loc_oErro
10284:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de tamanho")
10285:         ENDTRY
10286:     ENDPROC
10287: 
10288:     *==========================================================================
10289:     * AbrirLookupCorFaseP - Lookup SigCdCor para txt_4c_Cor
10290:     *==========================================================================
10291:     PROTECTED PROCEDURE AbrirLookupCorFaseP()
10292:         LOCAL loc_oBusca, loc_cCodigo, loc_oPgFaseP, loc_oErro
10293:         TRY
10294:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10295:                 RETURN
10296:             ENDIF
10297:             IF !this_lEmEdicao
10298:                 RETURN
10299:             ENDIF
10300:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10301:             loc_cCodigo  = ALLTRIM(loc_oPgFaseP.txt_4c_Cor.Value)
10302:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCor", ;
10303:                 "cursor_4c_BuscaCorFP", "Cods", loc_cCodigo, "Cor")
10304:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
10305:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10306:             loc_oBusca.Show()
10307:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCorFP")
10308:                 loc_oPgFaseP.txt_4c_Cor.Value = ALLTRIM(cursor_4c_BuscaCorFP.Cods)
10309:             ENDIF
10310:             IF USED("cursor_4c_BuscaCorFP")
10311:                 USE IN cursor_4c_BuscaCorFP
10312:             ENDIF
10313:             loc_oBusca.Release()
10314:         CATCH TO loc_oErro
10315:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de cor")
10316:         ENDTRY
10317:     ENDPROC
10318: 
10319:     *==========================================================================
10320:     * AbrirLookupConquilhaFaseP - Lookup SigCdCnq para txt_4c_Conquilha
10321:     *==========================================================================
10322:     PROTECTED PROCEDURE AbrirLookupConquilhaFaseP()
10323:         LOCAL loc_oBusca, loc_cCodigo, loc_oPgFaseP, loc_oErro
10324:         TRY
10325:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10326:                 RETURN
10327:             ENDIF
10328:             IF !this_lEmEdicao
10329:                 RETURN
10330:             ENDIF
10331:             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10332:             loc_cCodigo  = ALLTRIM(loc_oPgFaseP.txt_4c_Conquilha.Value)
10333:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCnq", ;
10334:                 "cursor_4c_BuscaCnqFP", "conquilhas", loc_cCodigo, "Conquilhas")
10335:             loc_oBusca.mAddColuna("conquilhas", "", "Conquilhas")
10336:             loc_oBusca.Show()
10337:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnqFP")
10338:                 loc_oPgFaseP.txt_4c_Conquilha.Value = ALLTRIM(cursor_4c_BuscaCnqFP.conquilhas)
10339:             ENDIF
10340:             IF USED("cursor_4c_BuscaCnqFP")
10341:                 USE IN cursor_4c_BuscaCnqFP
10342:             ENDIF
10343:             loc_oBusca.Release()
10344:         CATCH TO loc_oErro
10345:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de conquilha")
10346:         ENDTRY
10347:     ENDPROC
10348: 
10349:     *==========================================================================
10350:     * ConfigurarPgpgDadosFiscais - Page3 (pgDadosFiscais) do pgf_4c_DadosInterno
10351:     * Posicoes: original_top + 29 (inner PageFrame em Page2 outer -> +29)
10352:     *==========================================================================
10353:     PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais(par_oPage)
10354:         LOCAL loc_oErro
10355:         TRY
10356:             *-- === Cursor placeholder ANTES do grid grdCmv ===
10357:             SET NULL ON
10358:             IF USED("cursor_4c_Cmv")
10359:                 USE IN cursor_4c_Cmv
10360:             ENDIF
10361:             CREATE CURSOR cursor_4c_Cmv (;
10362:                 Periodo C(7)    NULL, ;
10363:                 ValGR   N(15,6) NULL, ;
10364:                 Moe     C(3)    NULL  ;
10365:             )
10366:             SET NULL OFF
10367: 
10368:             *-- === Say16: "Grupo C.C. :" - top=165+29=194, left=138, w=63, h=15 ===
10369:             par_oPage.AddObject("lbl_4c_Label16", "Label")
10370:             WITH par_oPage.lbl_4c_Label16
10371:                 .Top       = 194
10372:                 .Left      = 138
10373:                 .Width     = 63
10374:                 .Height    = 15
10375:                 .FontName  = "Tahoma"
10376:                 .FontSize  = 8
10377:                 .BackStyle = 0
10378:                 .Caption   = "Grupo C.C. :"
10379:                 .ForeColor = RGB(90,90,90)
10380:                 .Visible   = .T.
10381:             ENDWITH
10382: 
10383:             *-- === Say17: "Conta C.C. :" - top=189+29=218, left=138, w=63, h=15 ===
10384:             par_oPage.AddObject("lbl_4c_Label17", "Label")
10385:             WITH par_oPage.lbl_4c_Label17
10386:                 .Top       = 218
10387:                 .Left      = 138
10388:                 .Width     = 63
10389:                 .Height    = 15
10390:                 .FontName  = "Tahoma"
10391:                 .FontSize  = 8
10392:                 .BackStyle = 0
10393:                 .Caption   = "Conta C.C. :"

*-- Linhas 11145 a 11862:
11145:     ENDPROC
11146: 
11147:     *==========================================================================
11148:     * Handlers - pgDadosFiscais (PUBLIC - obrigatorio para BINDEVENT)
11149:     *==========================================================================
11150: 
11151:     PROCEDURE GruccusFiscKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11152:         LOCAL loc_oPgFisc, loc_oErro
11153:         TRY
11154:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
11155:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11156:                 IF !EMPTY(ALLTRIM(loc_oPgFisc.txt_4c__gruccus.Value))
11157:                     fAcessoContab(gc_4c_UsuarioLogado, 'C', ;
11158:                         ALLTRIM(loc_oPgFisc.txt_4c__gruccus.Value), ;
11159:                         loc_oPgFisc.txt_4c__gruccus, ;
11160:                         loc_oPgFisc.txt_4c__dgruccus)
11161:                 ELSE
11162:                     loc_oPgFisc.txt_4c__dgruccus.Value  = ""
11163:                     loc_oPgFisc.txt_4c__contaccus.Value  = ""
11164:                     loc_oPgFisc.txt_4c__dcontaccus.Value = ""
11165:                     loc_oPgFisc.txt_4c__dgruccus.Refresh
11166:                 ENDIF
11167:             ENDIF
11168:         CATCH TO loc_oErro
11169:             MsgErro(loc_oErro.Message, "Erro ao validar grupo contabil")
11170:         ENDTRY
11171:     ENDPROC
11172: 
11173:     PROCEDURE DgruccusFiscKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11174:         LOCAL loc_oPgFisc, loc_oErro
11175:         TRY
11176:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
11177:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11178:                 IF !EMPTY(ALLTRIM(loc_oPgFisc.txt_4c__dgruccus.Value))
11179:                     fAcessoContab(gc_4c_UsuarioLogado, 'D', ;
11180:                         ALLTRIM(loc_oPgFisc.txt_4c__dgruccus.Value), ;
11181:                         loc_oPgFisc.txt_4c__gruccus, ;
11182:                         loc_oPgFisc.txt_4c__dgruccus)
11183:                 ELSE
11184:                     loc_oPgFisc.txt_4c__gruccus.Value    = ""
11185:                     loc_oPgFisc.txt_4c__contaccus.Value  = ""
11186:                     loc_oPgFisc.txt_4c__dcontaccus.Value = ""
11187:                     loc_oPgFisc.txt_4c__gruccus.Refresh
11188:                 ENDIF
11189:             ENDIF
11190:         CATCH TO loc_oErro
11191:             MsgErro(loc_oErro.Message, "Erro ao validar descri" + CHR(231) + CHR(227) + "o grupo contabil")
11192:         ENDTRY
11193:     ENDPROC
11194: 
11195:     PROCEDURE ContaccusFiscKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11196:         LOCAL loc_oPgFisc, loc_cGrupo, loc_oErro
11197:         TRY
11198:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
11199:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11200:                 loc_cGrupo  = ALLTRIM(loc_oPgFisc.txt_4c__gruccus.Value)
11201:                 IF !EMPTY(ALLTRIM(loc_oPgFisc.txt_4c__contaccus.Value))
11202:                     IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, 'C', ;
11203:                             ALLTRIM(loc_oPgFisc.txt_4c__contaccus.Value), ;
11204:                             loc_oPgFisc.txt_4c__contaccus, ;
11205:                             loc_oPgFisc.txt_4c__dcontaccus)
11206:                         MsgAviso("Acesso Negado !!", "Acesso")
11207:                         loc_oPgFisc.txt_4c__contaccus.Value  = ""
11208:                         loc_oPgFisc.txt_4c__dcontaccus.Value = ""
11209:                         loc_oPgFisc.txt_4c__contaccus.Refresh
11210:                         loc_oPgFisc.txt_4c__dcontaccus.Refresh
11211:                     ENDIF
11212:                 ELSE
11213:                     loc_oPgFisc.txt_4c__dcontaccus.Value = ""
11214:                     loc_oPgFisc.txt_4c__dcontaccus.Refresh
11215:                 ENDIF
11216:             ENDIF
11217:         CATCH TO loc_oErro
11218:             MsgErro(loc_oErro.Message, "Erro ao validar conta contabil")
11219:         ENDTRY
11220:     ENDPROC
11221: 
11222:     PROCEDURE DcontaccusFiscKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11223:         LOCAL loc_oPgFisc, loc_cGrupo, loc_oErro
11224:         TRY
11225:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
11226:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11227:                 loc_cGrupo  = ALLTRIM(loc_oPgFisc.txt_4c__gruccus.Value)
11228:                 IF !EMPTY(ALLTRIM(loc_oPgFisc.txt_4c__dcontaccus.Value))
11229:                     IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, 'D', ;
11230:                             ALLTRIM(loc_oPgFisc.txt_4c__dcontaccus.Value), ;
11231:                             loc_oPgFisc.txt_4c__contaccus, ;
11232:                             loc_oPgFisc.txt_4c__dcontaccus)
11233:                         MsgAviso("Acesso Negado !!", "Acesso")
11234:                         loc_oPgFisc.txt_4c__dcontaccus.Value = ""
11235:                         loc_oPgFisc.txt_4c__contaccus.Value  = ""
11236:                         loc_oPgFisc.txt_4c__dcontaccus.Refresh
11237:                         loc_oPgFisc.txt_4c__contaccus.Refresh
11238:                     ENDIF
11239:                 ELSE
11240:                     loc_oPgFisc.txt_4c__contaccus.Value = ""
11241:                     loc_oPgFisc.txt_4c__contaccus.Refresh
11242:                 ENDIF
11243:             ENDIF
11244:         CATCH TO loc_oErro
11245:             MsgErro(loc_oErro.Message, "Erro ao validar descri" + CHR(231) + CHR(227) + "o conta contabil")
11246:         ENDTRY
11247:     ENDPROC
11248: 
11249:     PROCEDURE ClfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11250:         TRY
11251:             IF par_nKeyCode = 115
11252:                 THIS.AbrirLookupClfiscal()
11253:             ELSE
11254:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
11255:                 THIS.AbrirLookupClfiscal()
11256:                 ENDIF
11257:             ENDIF
11258:         CATCH TO loc_oErro
11259:             *-- Tolerado
11260:         ENDTRY
11261:     ENDPROC
11262: 
11263:     PROCEDURE ClfiscalDblClick()
11264:         THIS.AbrirLookupClfiscal()
11265:     ENDPROC
11266: 
11267:     PROTECTED PROCEDURE AbrirLookupClfiscal()
11268:         LOCAL loc_oBusca, loc_oPgFisc, loc_cCodigo, loc_oErro
11269:         TRY
11270:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11271:                 RETURN
11272:             ENDIF
11273:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11274:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Clfiscal.Value)
11275:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", ;
11276:                 "cursor_4c_BuscaClf", "Codigos", loc_cCodigo, ;
11277:                 "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11278:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11279:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11280:             loc_oBusca.Show()
11281:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
11282:                 loc_oPgFisc.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_BuscaClf.Codigos)
11283:                 loc_oPgFisc.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_BuscaClf.Descricaos)
11284:                 loc_oPgFisc.lbl_4c__AliqIPI.Enabled = .T.
11285:                 loc_oPgFisc.txt_4c_AliqIPI.Enabled  = .T.
11286:             ELSE
11287:                 loc_oPgFisc.txt_4c_Clfiscal.Value  = ""
11288:                 loc_oPgFisc.txt_4c_Dclfiscal.Value = ""
11289:                 loc_oPgFisc.lbl_4c__AliqIPI.Enabled = .F.
11290:                 loc_oPgFisc.txt_4c_AliqIPI.Enabled  = .F.
11291:             ENDIF
11292:             IF USED("cursor_4c_BuscaClf")
11293:                 USE IN cursor_4c_BuscaClf
11294:             ENDIF
11295:             loc_oBusca.Release()
11296:             loc_oPgFisc.txt_4c_Clfiscal.Refresh
11297:             loc_oPgFisc.txt_4c_Dclfiscal.Refresh
11298:         CATCH TO loc_oErro
11299:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup classifica" + CHR(231) + CHR(227) + "o fiscal")
11300:         ENDTRY
11301:     ENDPROC
11302: 
11303:     PROCEDURE DclfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11304:         TRY
11305:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
11306:                 THIS.AbrirLookupDclfiscal()
11307:             ENDIF
11308:         CATCH TO loc_oErro
11309:             *-- Tolerado
11310:         ENDTRY
11311:     ENDPROC
11312: 
11313:     PROTECTED PROCEDURE AbrirLookupDclfiscal()
11314:         LOCAL loc_oBusca, loc_oPgFisc, loc_cDescricao, loc_oErro
11315:         TRY
11316:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11317:                 RETURN
11318:             ENDIF
11319:             loc_oPgFisc   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11320:             loc_cDescricao = ALLTRIM(loc_oPgFisc.txt_4c_Dclfiscal.Value)
11321:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", ;
11322:                 "cursor_4c_BuscaClf", "Descricaos", loc_cDescricao, ;
11323:                 "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11324:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11325:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11326:             loc_oBusca.Show()
11327:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
11328:                 loc_oPgFisc.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_BuscaClf.Codigos)
11329:                 loc_oPgFisc.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_BuscaClf.Descricaos)
11330:                 loc_oPgFisc.lbl_4c__AliqIPI.Enabled = .T.
11331:                 loc_oPgFisc.txt_4c_AliqIPI.Enabled  = .T.
11332:             ELSE
11333:                 loc_oPgFisc.txt_4c_Clfiscal.Value  = ""
11334:                 loc_oPgFisc.txt_4c_Dclfiscal.Value = ""
11335:                 loc_oPgFisc.lbl_4c__AliqIPI.Enabled = .F.
11336:                 loc_oPgFisc.txt_4c_AliqIPI.Enabled  = .F.
11337:             ENDIF
11338:             IF USED("cursor_4c_BuscaClf")
11339:                 USE IN cursor_4c_BuscaClf
11340:             ENDIF
11341:             loc_oBusca.Release()
11342:             loc_oPgFisc.txt_4c_Clfiscal.Refresh
11343:             loc_oPgFisc.txt_4c_Dclfiscal.Refresh
11344:         CATCH TO loc_oErro
11345:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup descri" + CHR(231) + CHR(227) + "o fiscal")
11346:         ENDTRY
11347:     ENDPROC
11348: 
11349:     PROCEDURE OrigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11350:         TRY
11351:             IF par_nKeyCode = 115
11352:                 THIS.AbrirLookupOrigmerc()
11353:             ELSE
11354:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
11355:                 THIS.AbrirLookupOrigmerc()
11356:                 ENDIF
11357:             ENDIF
11358:         CATCH TO loc_oErro
11359:             *-- Tolerado
11360:         ENDTRY
11361:     ENDPROC
11362: 
11363:     PROCEDURE OrigmercDblClick()
11364:         THIS.AbrirLookupOrigmerc()
11365:     ENDPROC
11366: 
11367:     PROTECTED PROCEDURE AbrirLookupOrigmerc()
11368:         LOCAL loc_oBusca, loc_oPgFisc, loc_cCodigo, loc_oErro
11369:         TRY
11370:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11371:                 RETURN
11372:             ENDIF
11373:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11374:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Origmerc.Value)
11375:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOrg", ;
11376:                 "cursor_4c_BuscaOrg", "Codigos", loc_cCodigo, ;
11377:                 "Origem da Mercadoria")
11378:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11379:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11380:             loc_oBusca.Show()
11381:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrg")
11382:                 loc_oPgFisc.txt_4c_Origmerc.Value  = ALLTRIM(cursor_4c_BuscaOrg.Codigos)
11383:                 loc_oPgFisc.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_BuscaOrg.Descricaos)
11384:             ELSE
11385:                 loc_oPgFisc.txt_4c_Origmerc.Value  = ""
11386:                 loc_oPgFisc.txt_4c_Dorigmerc.Value = ""
11387:             ENDIF
11388:             IF USED("cursor_4c_BuscaOrg")
11389:                 USE IN cursor_4c_BuscaOrg
11390:             ENDIF
11391:             loc_oBusca.Release()
11392:             loc_oPgFisc.txt_4c_Origmerc.Refresh
11393:             loc_oPgFisc.txt_4c_Dorigmerc.Refresh
11394:         CATCH TO loc_oErro
11395:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup origem mercadoria")
11396:         ENDTRY
11397:     ENDPROC
11398: 
11399:     PROCEDURE DorigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11400:         TRY
11401:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
11402:                 THIS.AbrirLookupDorigmerc()
11403:             ENDIF
11404:         CATCH TO loc_oErro
11405:             *-- Tolerado
11406:         ENDTRY
11407:     ENDPROC
11408: 
11409:     PROTECTED PROCEDURE AbrirLookupDorigmerc()
11410:         LOCAL loc_oBusca, loc_oPgFisc, loc_cDescricao, loc_oErro
11411:         TRY
11412:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11413:                 RETURN
11414:             ENDIF
11415:             loc_oPgFisc   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11416:             loc_cDescricao = ALLTRIM(loc_oPgFisc.txt_4c_Dorigmerc.Value)
11417:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOrg", ;
11418:                 "cursor_4c_BuscaOrg", "Descricaos", loc_cDescricao, ;
11419:                 "Origem da Mercadoria")
11420:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11421:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11422:             loc_oBusca.Show()
11423:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrg")
11424:                 loc_oPgFisc.txt_4c_Origmerc.Value  = ALLTRIM(cursor_4c_BuscaOrg.Codigos)
11425:                 loc_oPgFisc.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_BuscaOrg.Descricaos)
11426:             ELSE
11427:                 loc_oPgFisc.txt_4c_Origmerc.Value  = ""
11428:                 loc_oPgFisc.txt_4c_Dorigmerc.Value = ""
11429:             ENDIF
11430:             IF USED("cursor_4c_BuscaOrg")
11431:                 USE IN cursor_4c_BuscaOrg
11432:             ENDIF
11433:             loc_oBusca.Release()
11434:             loc_oPgFisc.txt_4c_Origmerc.Refresh
11435:             loc_oPgFisc.txt_4c_Dorigmerc.Refresh
11436:         CATCH TO loc_oErro
11437:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup descri" + CHR(231) + CHR(227) + "o origem")
11438:         ENDTRY
11439:     ENDPROC
11440: 
11441:     PROCEDURE SittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11442:         TRY
11443:             IF par_nKeyCode = 115
11444:                 THIS.AbrirLookupSittricm()
11445:             ELSE
11446:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
11447:                 THIS.AbrirLookupSittricm()
11448:                 ENDIF
11449:             ENDIF
11450:         CATCH TO loc_oErro
11451:             *-- Tolerado
11452:         ENDTRY
11453:     ENDPROC
11454: 
11455:     PROCEDURE SittricmDblClick()
11456:         THIS.AbrirLookupSittricm()
11457:     ENDPROC
11458: 
11459:     PROTECTED PROCEDURE AbrirLookupSittricm()
11460:         LOCAL loc_oBusca, loc_oPgFisc, loc_cCodigo, loc_oErro
11461:         TRY
11462:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11463:                 RETURN
11464:             ENDIF
11465:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11466:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Sittricm.Value)
11467:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", ;
11468:                 "cursor_4c_BuscaIcm", "Codigos", loc_cCodigo, ;
11469:                 "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
11470:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11471:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11472:             loc_oBusca.Show()
11473:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
11474:                 loc_oPgFisc.txt_4c_Sittricm.Value  = ALLTRIM(cursor_4c_BuscaIcm.Codigos)
11475:                 loc_oPgFisc.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_BuscaIcm.Descricaos)
11476:             ELSE
11477:                 loc_oPgFisc.txt_4c_Sittricm.Value  = ""
11478:                 loc_oPgFisc.txt_4c_Dsittricm.Value = ""
11479:             ENDIF
11480:             IF USED("cursor_4c_BuscaIcm")
11481:                 USE IN cursor_4c_BuscaIcm
11482:             ENDIF
11483:             loc_oBusca.Release()
11484:             loc_oPgFisc.txt_4c_Sittricm.Refresh
11485:             loc_oPgFisc.txt_4c_Dsittricm.Refresh
11486:         CATCH TO loc_oErro
11487:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup situa" + CHR(231) + CHR(227) + "o ICMS")
11488:         ENDTRY
11489:     ENDPROC
11490: 
11491:     PROCEDURE DsittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11492:         TRY
11493:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
11494:                 THIS.AbrirLookupDsittricm()
11495:             ENDIF
11496:         CATCH TO loc_oErro
11497:             *-- Tolerado
11498:         ENDTRY
11499:     ENDPROC
11500: 
11501:     PROTECTED PROCEDURE AbrirLookupDsittricm()
11502:         LOCAL loc_oBusca, loc_oPgFisc, loc_cDescricao, loc_oErro
11503:         TRY
11504:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11505:                 RETURN
11506:             ENDIF
11507:             loc_oPgFisc   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11508:             loc_cDescricao = ALLTRIM(loc_oPgFisc.txt_4c_Dsittricm.Value)
11509:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", ;
11510:                 "cursor_4c_BuscaIcm", "Descricaos", loc_cDescricao, ;
11511:                 "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
11512:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11513:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11514:             loc_oBusca.Show()
11515:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
11516:                 loc_oPgFisc.txt_4c_Sittricm.Value  = ALLTRIM(cursor_4c_BuscaIcm.Codigos)
11517:                 loc_oPgFisc.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_BuscaIcm.Descricaos)
11518:             ELSE
11519:                 loc_oPgFisc.txt_4c_Sittricm.Value  = ""
11520:                 loc_oPgFisc.txt_4c_Dsittricm.Value = ""
11521:             ENDIF
11522:             IF USED("cursor_4c_BuscaIcm")
11523:                 USE IN cursor_4c_BuscaIcm
11524:             ENDIF
11525:             loc_oBusca.Release()
11526:             loc_oPgFisc.txt_4c_Sittricm.Refresh
11527:             loc_oPgFisc.txt_4c_Dsittricm.Refresh
11528:         CATCH TO loc_oErro
11529:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup descri" + CHR(231) + CHR(227) + "o ICMS")
11530:         ENDTRY
11531:     ENDPROC
11532: 
11533:     PROCEDURE CodServsFiscKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11534:         LOCAL loc_oBusca, loc_oPgFisc, loc_cCodigo, loc_oErro
11535:         TRY
11536:             IF (par_nKeyCode = 13 OR par_nKeyCode = 9) AND gnConnHandle > 0 AND !gb_4c_ValidandoUI
11537:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11538:                 loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Codigo.Value)
11539:                 IF !EMPTY(loc_cCodigo)
11540:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", ;
11541:                         "cursor_4c_BuscaIcm", "Codigos", loc_cCodigo, ;
11542:                         "C" + CHR(243) + "digo ICMS")
11543:                     loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11544:                     loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11545:                     loc_oBusca.Show()
11546:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
11547:                         loc_oPgFisc.txt_4c_Sittricm.Value  = ALLTRIM(cursor_4c_BuscaIcm.Codigos)
11548:                         loc_oPgFisc.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_BuscaIcm.Descricaos)
11549:                     ENDIF
11550:                     IF USED("cursor_4c_BuscaIcm")
11551:                         USE IN cursor_4c_BuscaIcm
11552:                     ENDIF
11553:                     loc_oBusca.Release()
11554:                     loc_oPgFisc.txt_4c_Sittricm.Refresh
11555:                     loc_oPgFisc.txt_4c_Dsittricm.Refresh
11556:                 ENDIF
11557:             ENDIF
11558:         CATCH TO loc_oErro
11559:             MsgErro(loc_oErro.Message, "Erro ao validar c" + CHR(243) + "digo servi" + CHR(231) + "os ICMS")
11560:         ENDTRY
11561:     ENDPROC
11562: 
11563:     PROCEDURE TpTribKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11564:         TRY
11565:             IF par_nKeyCode = 115
11566:                 THIS.AbrirLookupTpTrib()
11567:             ELSE
11568:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
11569:                 THIS.AbrirLookupTpTrib()
11570:                 ENDIF
11571:             ENDIF
11572:         CATCH TO loc_oErro
11573:             *-- Tolerado
11574:         ENDTRY
11575:     ENDPROC
11576: 
11577:     PROCEDURE TpTribDblClick()
11578:         THIS.AbrirLookupTpTrib()
11579:     ENDPROC
11580: 
11581:     PROTECTED PROCEDURE AbrirLookupTpTrib()
11582:         LOCAL loc_oBusca, loc_oPgFisc, loc_cCodigo, loc_oErro
11583:         TRY
11584:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11585:                 RETURN
11586:             ENDIF
11587:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11588:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_TpTrib.Value)
11589:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrTri", ;
11590:                 "cursor_4c_BuscaTri", "Tipos", loc_cCodigo, ;
11591:                 "Tipo de Tributa" + CHR(231) + CHR(227) + "o")
11592:             loc_oBusca.mAddColuna("Tipos", "", "Tipo")
11593:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11594:             loc_oBusca.Show()
11595:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTri")
11596:                 loc_oPgFisc.txt_4c_TpTrib.Value = ALLTRIM(cursor_4c_BuscaTri.Tipos)
11597:             ELSE
11598:                 loc_oPgFisc.txt_4c_TpTrib.Value = ""
11599:             ENDIF
11600:             IF USED("cursor_4c_BuscaTri")
11601:                 USE IN cursor_4c_BuscaTri
11602:             ENDIF
11603:             loc_oBusca.Release()
11604:             loc_oPgFisc.txt_4c_TpTrib.Refresh
11605:         CATCH TO loc_oErro
11606:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup tipo tributa" + CHR(231) + CHR(227) + "o")
11607:         ENDTRY
11608:     ENDPROC
11609: 
11610:     PROCEDURE IatFiscKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11611:         LOCAL loc_oPgFisc, loc_oErro
11612:         TRY
11613:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
11614:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11615:                 IF !INLIST(UPPER(ALLTRIM(loc_oPgFisc.txt_4c_Iat.Value)), "A", "T", " ", "")
11616:                     MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
11617:                         "Digite [A] Arredondamento Ou [T] Truncamento!", "IAT")
11618:                     loc_oPgFisc.txt_4c_Iat.Value = ""
11619:                     loc_oPgFisc.txt_4c_Iat.Refresh
11620:                 ENDIF
11621:             ENDIF
11622:         CATCH TO loc_oErro
11623:             MsgErro(loc_oErro.Message, "Erro ao validar IAT")
11624:         ENDTRY
11625:     ENDPROC
11626: 
11627:     PROCEDURE AliqIPIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11628:         LOCAL loc_oPgFisc, loc_nAliqClf, loc_nRet, loc_oErro
11629:         loc_nRet = 0
11630:         TRY
11631:             IF (par_nKeyCode = 13 OR par_nKeyCode = 9) AND gnConnHandle > 0 AND !gb_4c_ValidandoUI
11632:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11633:                 IF !EMPTY(ALLTRIM(loc_oPgFisc.txt_4c_Clfiscal.Value)) AND ;
11634:                    !EMPTY(ALLTRIM(loc_oPgFisc.txt_4c_AliqIPI.Value))
11635:                     loc_nRet = SQLEXEC(gnConnHandle, ;
11636:                         "SELECT TOP 1 aIpis FROM SigCdClf WHERE Codigos = " + ;
11637:                         EscaparSQL(ALLTRIM(loc_oPgFisc.txt_4c_Clfiscal.Value)), ;
11638:                         "cursor_4c_TmpClf")
11639:                     IF loc_nRet > 0 AND !EOF("cursor_4c_TmpClf")
11640:                         loc_nAliqClf = cursor_4c_TmpClf.aIpis
11641:                         IF loc_oPgFisc.txt_4c_AliqIPI.Value = loc_nAliqClf
11642:                             MsgAviso("Al" + CHR(237) + "quota de IPI id" + CHR(234) + "ntica " + ;
11643:                                 CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal. " + ;
11644:                                 "Deixe zero para usar a da classifica" + CHR(231) + CHR(227) + "o fiscal!", ;
11645:                                 "Aten" + CHR(231) + CHR(227) + "o")
11646:                         ENDIF
11647:                     ENDIF
11648:                     IF USED("cursor_4c_TmpClf")
11649:                         USE IN cursor_4c_TmpClf
11650:                     ENDIF
11651:                 ENDIF
11652:             ENDIF
11653:         CATCH TO loc_oErro
11654:             MsgErro(loc_oErro.Message, "Erro ao validar al" + CHR(237) + "quota IPI")
11655:         ENDTRY
11656:     ENDPROC
11657: 
11658:     PROCEDURE MvalorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11659:         TRY
11660:             IF par_nKeyCode = 115
11661:                 THIS.AbrirLookupMvalor()
11662:             ELSE
11663:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
11664:                 THIS.AbrirLookupMvalor()
11665:                 ENDIF
11666:             ENDIF
11667:         CATCH TO loc_oErro
11668:             *-- Tolerado
11669:         ENDTRY
11670:     ENDPROC
11671: 
11672:     PROCEDURE MvalorDblClick()
11673:         THIS.AbrirLookupMvalor()
11674:     ENDPROC
11675: 
11676:     PROTECTED PROCEDURE AbrirLookupMvalor()
11677:         LOCAL loc_oBusca, loc_oPgFisc, loc_cCodigo, loc_oErro
11678:         TRY
11679:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11680:                 RETURN
11681:             ENDIF
11682:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11683:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Mvalor.Value)
11684:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
11685:                 "cursor_4c_BuscaMoe", "CMoes", loc_cCodigo, "Moeda")
11686:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11687:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11688:             loc_oBusca.Show()
11689:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
11690:                 loc_oPgFisc.txt_4c_Mvalor.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
11691:             ELSE
11692:                 loc_oPgFisc.txt_4c_Mvalor.Value = ""
11693:             ENDIF
11694:             IF USED("cursor_4c_BuscaMoe")
11695:                 USE IN cursor_4c_BuscaMoe
11696:             ENDIF
11697:             loc_oBusca.Release()
11698:             loc_oPgFisc.txt_4c_Mvalor.Refresh
11699:         CATCH TO loc_oErro
11700:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup moeda")
11701:         ENDTRY
11702:     ENDPROC
11703: 
11704:     PROCEDURE MetalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11705:         TRY
11706:             IF par_nKeyCode = 115
11707:                 THIS.AbrirLookupMetal()
11708:             ELSE
11709:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
11710:                 THIS.AbrirLookupMetal()
11711:                 ENDIF
11712:             ENDIF
11713:         CATCH TO loc_oErro
11714:             *-- Tolerado
11715:         ENDTRY
11716:     ENDPROC
11717: 
11718:     PROCEDURE MetalDblClick()
11719:         THIS.AbrirLookupMetal()
11720:     ENDPROC
11721: 
11722:     PROTECTED PROCEDURE AbrirLookupMetal()
11723:         LOCAL loc_oPgFisc, loc_cCodigo, loc_oErro
11724:         TRY
11725:             IF gb_4c_ValidandoUI
11726:                 RETURN
11727:             ENDIF
11728:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11729:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Metal.Value)
11730:             IF !EMPTY(loc_cCodigo) AND USED("TmpMTal")
11731:                 SELECT TmpMTal
11732:                 SET ORDER TO Codigos
11733:                 SET NEAR ON
11734:                 IF !SEEK(loc_cCodigo, "TmpMTal", "Codigos")
11735:                     *-- Nao encontrou exato: mant?m valor digitado
11736:                 ENDIF
11737:                 SET NEAR OFF
11738:                 loc_oPgFisc.txt_4c_Metal.Value    = ALLTRIM(TmpMTal.Codigos)
11739:                 loc_oPgFisc.txt_4c_DesMetal.Value = ALLTRIM(TmpMTal.Descs)
11740:                 loc_oPgFisc.txt_4c_Metal.Refresh
11741:                 loc_oPgFisc.txt_4c_DesMetal.Refresh
11742:             ENDIF
11743:         CATCH TO loc_oErro
11744:             MsgErro(loc_oErro.Message, "Erro ao validar metal")
11745:         ENDTRY
11746:     ENDPROC
11747: 
11748:     PROCEDURE TeorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11749:         TRY
11750:             IF par_nKeyCode = 115
11751:                 THIS.AbrirLookupTeor()
11752:             ELSE
11753:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9
11754:                 THIS.AbrirLookupTeor()
11755:                 ENDIF
11756:             ENDIF
11757:         CATCH TO loc_oErro
11758:             *-- Tolerado
11759:         ENDTRY
11760:     ENDPROC
11761: 
11762:     PROCEDURE TeorDblClick()
11763:         THIS.AbrirLookupTeor()
11764:     ENDPROC
11765: 
11766:     PROTECTED PROCEDURE AbrirLookupTeor()
11767:         LOCAL loc_oPgFisc, loc_cCodigo, loc_oErro
11768:         TRY
11769:             IF gb_4c_ValidandoUI
11770:                 RETURN
11771:             ENDIF
11772:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11773:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Teor.Value)
11774:             IF !EMPTY(loc_cCodigo) AND USED("TmpTeor")
11775:                 SELECT TmpTeor
11776:                 SET ORDER TO Codigos
11777:                 SET NEAR ON
11778:                 IF !SEEK(loc_cCodigo, "TmpTeor", "Codigos")
11779:                     *-- Nao encontrou exato: mant?m valor digitado
11780:                 ENDIF
11781:                 SET NEAR OFF
11782:                 loc_oPgFisc.txt_4c_Teor.Value    = ALLTRIM(TmpTeor.Codigos)
11783:                 loc_oPgFisc.txt_4c_DesTeor.Value = ALLTRIM(TmpTeor.Descs)
11784:                 loc_oPgFisc.txt_4c_Teor.Refresh
11785:                 loc_oPgFisc.txt_4c_DesTeor.Refresh
11786:             ENDIF
11787:         CATCH TO loc_oErro
11788:             MsgErro(loc_oErro.Message, "Erro ao validar teor")
11789:         ENDTRY
11790:     ENDPROC
11791: 
11792:     PROCEDURE BtnDescFisClick()
11793:         LOCAL loc_cFis, loc_oPgFisc, loc_oErro
11794:         TRY
11795:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
11796:                 RETURN
11797:             ENDIF
11798:             IF EMPTY(this_cCodigo)
11799:                 MsgAviso("Salve o produto antes de gerar a descri" + CHR(231) + CHR(227) + "o fiscal.", "Aviso")
11800:                 RETURN
11801:             ENDIF
11802:             loc_cFis = fGerDescFis(0, this_cCodigo, this_oBusinessObject)
11803:             IF !EMPTY(loc_cFis)
11804:                 IF USED("crSigCdPro")
11805:                     REPLACE crSigCdPro.DescFis WITH loc_cFis
11806:                 ENDIF
11807:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11808:                 loc_oPgFisc.obj_4c_Mgetdescfi.Refresh
11809:             ELSE
11810:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + ;
11811:                     CHR(231) + CHR(227) + "o fiscal!", "Aten" + CHR(231) + CHR(227) + "o")
11812:             ENDIF
11813:         CATCH TO loc_oErro
11814:             MsgErro(loc_oErro.Message, "Erro ao gerar descri" + CHR(231) + CHR(227) + "o fiscal")
11815:         ENDTRY
11816:     ENDPROC
11817: 
11818:     *==========================================================================
11819:     * ConfigurarPgpgDesigner - Page7 (pgDesigner) do pgf_4c_DadosInterno
11820:     * Posicoes: original_top + 29 (inner PageFrame em Page2 outer -> +29)
11821:     *==========================================================================
11822:     PROTECTED PROCEDURE ConfigurarPgpgDesigner(par_oPage)
11823:         LOCAL loc_oGrd, loc_oGrdArq, loc_oErro
11824:         TRY
11825:             *-- === Criar cursores placeholder ANTES dos grids ===
11826:             SET NULL ON
11827:             IF USED("crSigPrTar")
11828:                 USE IN crSigPrTar
11829:             ENDIF
11830:             CREATE CURSOR crSigPrTar (;
11831:                 CPros    C(14)  NULL, ;
11832:                 pkChaves C(30)  NULL, ;
11833:                 DtInis   T      NULL, ;
11834:                 DtFims   T      NULL, ;
11835:                 Usuars   C(20)  NULL, ;
11836:                 Tarefas  C(10)  NULL, ;
11837:                 ObsTars  M      NULL  ;
11838:             )
11839:             IF USED("crSigPrArq")
11840:                 USE IN crSigPrArq
11841:             ENDIF
11842:             CREATE CURSOR crSigPrArq (;
11843:                 CPros    C(14)  NULL, ;
11844:                 pkChaves C(30)  NULL, ;
11845:                 Arquivos C(254) NULL  ;
11846:             )
11847:             SET NULL OFF
11848: 
11849:             *-- === lbl_4c_ObsTar (Say31): top=144+29=173, left=583, w=126, h=15 ===
11850:             par_oPage.AddObject("lbl_4c_ObsTar", "Label")
11851:             WITH par_oPage.lbl_4c_ObsTar
11852:                 .Top       = 173
11853:                 .Left      = 583
11854:                 .Width     = 126
11855:                 .Height    = 15
11856:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
11857:                 .FontName  = "Tahoma"
11858:                 .FontSize  = 8
11859:                 .AutoSize  = .F.
11860:                 .BackStyle = 0
11861:                 .ForeColor = RGB(0, 0, 0)
11862:                 .Visible   = .T.

*-- Linhas 11906 a 11979:
11906:             loc_oGrd.Column4.ReadOnly         = .T.
11907:             loc_oGrd.Column4.Header1.FontBold = .T.
11908: 
11909:             *-- BINDEVENTs para grd_4c_Designer
11910:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "DesignerAfterRowColChange")
11911:             BINDEVENT(loc_oGrd.Column4.Text1, "KeyPress", THIS, "DesignerCol4KeyPress")
11912: 
11913:             *-- === cmd_4c_BtnIniTarefa (btnIniTarefa): top=161+29=190, left=509, w=42, h=42 ===
11914:             par_oPage.AddObject("cmd_4c_BtnIniTarefa", "CommandButton")
11915:             WITH par_oPage.cmd_4c_BtnIniTarefa
11916:                 .Top     = 190
11917:                 .Left    = 509
11918:                 .Width   = 42
11919:                 .Height  = 42
11920:                 .Caption = ""
11921:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
11922:                 .Themes  = .F.
11923:                 .Visible = .T.
11924:             ENDWITH
11925:             BINDEVENT(par_oPage.cmd_4c_BtnIniTarefa, "Click", THIS, "BtnIniTarefaClick")
11926: 
11927:             *-- === cmd_4c_BtnFimTarefa (btnFimTarefa): top=203+29=232, left=509, w=42, h=42 ===
11928:             par_oPage.AddObject("cmd_4c_BtnFimTarefa", "CommandButton")
11929:             WITH par_oPage.cmd_4c_BtnFimTarefa
11930:                 .Top     = 232
11931:                 .Left    = 509
11932:                 .Width   = 42
11933:                 .Height  = 42
11934:                 .Caption = ""
11935:                 .Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
11936:                 .Themes  = .F.
11937:                 .Visible = .T.
11938:             ENDWITH
11939:             BINDEVENT(par_oPage.cmd_4c_BtnFimTarefa, "Click", THIS, "BtnFimTarefaClick")
11940: 
11941:             *-- === obj_4c_GetObsTarefas (getObsTarefas): top=160+29=189, left=584, w=407, h=238 ===
11942:             par_oPage.AddObject("obj_4c_GetObsTarefas", "EditBox")
11943:             WITH par_oPage.obj_4c_GetObsTarefas
11944:                 .Top         = 189
11945:                 .Left        = 584
11946:                 .Width       = 407
11947:                 .Height      = 238
11948:                 .ControlSource = "crSigPrTar.ObsTars"
11949:                 .FontName    = "Tahoma"
11950:                 .FontSize    = 8
11951:                 .ScrollBars  = 2
11952:                 .ReadOnly    = .T.
11953:                 .Themes      = .F.
11954:                 .Visible     = .T.
11955:             ENDWITH
11956: 
11957:             *-- === shp_4c_Shape1 (Shape1): top=415+29=444, left=584, w=407, h=202 ===
11958:             par_oPage.AddObject("shp_4c_Shape1", "Shape")
11959:             WITH par_oPage.shp_4c_Shape1
11960:                 .Top         = 444
11961:                 .Left        = 584
11962:                 .Width       = 407
11963:                 .Height      = 202
11964:                 .BackColor   = RGB(255, 255, 255)
11965:                 .BackStyle   = 1
11966:                 .BorderStyle = 1
11967:                 .Visible     = .T.
11968:             ENDWITH
11969: 
11970:             *-- === grd_4c_Arquivos (grdArquivos): top=415+29=444, left=10, w=495, h=202 ===
11971:             par_oPage.AddObject("grd_4c_Arquivos", "Grid")
11972:             loc_oGrdArq = par_oPage.grd_4c_Arquivos
11973:             loc_oGrdArq.Top         = 444
11974:             loc_oGrdArq.Left        = 10
11975:             loc_oGrdArq.Width       = 495
11976:             loc_oGrdArq.Height      = 202
11977:             loc_oGrdArq.ColumnCount = 1
11978:             loc_oGrdArq.FontName    = "Tahoma"
11979:             loc_oGrdArq.FontSize    = 8

*-- Linhas 11993 a 12101:
11993:             loc_oGrdArq.Column1.ReadOnly         = .T.
11994:             loc_oGrdArq.Column1.Header1.FontBold = .T.
11995: 
11996:             *-- BINDEVENTs para grd_4c_Arquivos
11997:             BINDEVENT(loc_oGrdArq, "AfterRowColChange", THIS, "ArquivosAfterRowColChange")
11998: 
11999:             *-- === cmd_4c_BtnInsArqs (btnInsArqs): top=416+29=445, left=509, w=42, h=42 ===
12000:             par_oPage.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
12001:             WITH par_oPage.cmd_4c_BtnInsArqs
12002:                 .Top     = 445
12003:                 .Left    = 509
12004:                 .Width   = 42
12005:                 .Height  = 42
12006:                 .Caption = ""
12007:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
12008:                 .Themes  = .F.
12009:                 .Visible = .T.
12010:             ENDWITH
12011:             BINDEVENT(par_oPage.cmd_4c_BtnInsArqs, "Click", THIS, "BtnInsArqsClick")
12012: 
12013:             *-- === cmd_4c_BtnExcArqs (btnExcArqs): top=458+29=487, left=509, w=42, h=42 ===
12014:             par_oPage.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
12015:             WITH par_oPage.cmd_4c_BtnExcArqs
12016:                 .Top     = 487
12017:                 .Left    = 509
12018:                 .Width   = 42
12019:                 .Height  = 42
12020:                 .Caption = ""
12021:                 .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
12022:                 .Themes  = .F.
12023:                 .Visible = .T.
12024:             ENDWITH
12025:             BINDEVENT(par_oPage.cmd_4c_BtnExcArqs, "Click", THIS, "BtnExcArqsClick")
12026: 
12027:             *-- === cmd_4c_BtnOpnArqs (btnOpnArqs): top=500+29=529, left=509, w=42, h=42 ===
12028:             par_oPage.AddObject("cmd_4c_BtnOpnArqs", "CommandButton")
12029:             WITH par_oPage.cmd_4c_BtnOpnArqs
12030:                 .Top     = 529
12031:                 .Left    = 509
12032:                 .Width   = 42
12033:                 .Height  = 42
12034:                 .Caption = ""
12035:                 .Picture = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
12036:                 .Themes  = .F.
12037:                 .Visible = .T.
12038:             ENDWITH
12039:             BINDEVENT(par_oPage.cmd_4c_BtnOpnArqs, "Click", THIS, "BtnOpnArqsClick")
12040: 
12041:             *-- === img_4c_ImgArqJpg (imgArqJpg): top=417+29=446, left=586, w=403, h=198 ===
12042:             par_oPage.AddObject("img_4c_ImgArqJpg", "Image")
12043:             WITH par_oPage.img_4c_ImgArqJpg
12044:                 .Top     = 446
12045:                 .Left    = 586
12046:                 .Width   = 403
12047:                 .Height  = 198
12048:                 .Stretch = 2
12049:                 .Visible = .F.
12050:             ENDWITH
12051:             BINDEVENT(par_oPage.img_4c_ImgArqJpg, "Click", THIS, "ImgArqJpgClick")
12052: 
12053:         CATCH TO loc_oErro
12054:             MsgErro(loc_oErro.Message, "Erro ao configurar p" + CHR(225) + "gina Designer")
12055:         ENDTRY
12056:     ENDPROC
12057: 
12058:     *==========================================================================
12059:     * CarregarDesigner - Carrega SigPrTar e SigPrArq e crTarefas para o produto
12060:     *==========================================================================
12061:     PROCEDURE CarregarDesigner()
12062:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgDesigner, loc_oErro, loc_lContinuar
12063:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
12064:             RETURN
12065:         ENDIF
12066:         loc_lContinuar = .T.
12067:         TRY
12068:             loc_cCPros = ALLTRIM(this_cCodigo)
12069:             IF EMPTY(loc_cCPros)
12070:                 loc_lContinuar = .F.
12071:             ENDIF
12072:             IF loc_lContinuar
12073:                 loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12074: 
12075:                 *-- Carregar crSigPrTar de SigPrTar
12076:                 IF USED("cursor_4c_TarTemp")
12077:                     USE IN cursor_4c_TarTemp
12078:                 ENDIF
12079:                 loc_cSQL = "SELECT CPros, pkChaves, DtInis, DtFims, Usuars, Tarefas, " + ;
12080:                            "CONVERT(NVARCHAR(MAX), ObsTars) AS ObsTars " + ;
12081:                            "FROM SigPrTar WHERE CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
12082:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TarTemp")
12083:                 IF loc_nRet > 0
12084:                     SELECT crSigPrTar
12085:                     ZAP
12086:                     IF RECCOUNT("cursor_4c_TarTemp") > 0
12087:                         APPEND FROM DBF("cursor_4c_TarTemp")
12088:                     ENDIF
12089:                     IF USED("cursor_4c_TarTemp")
12090:                         USE IN cursor_4c_TarTemp
12091:                     ENDIF
12092:                     SELECT crSigPrTar
12093:                     GO TOP
12094:                     loc_oPgDesigner.grd_4c_Designer.Refresh()
12095:                     THIS.DesignerAfterRowColChange(0)
12096:                 ELSE
12097:                     IF USED("cursor_4c_TarTemp")
12098:                         USE IN cursor_4c_TarTemp
12099:                     ENDIF
12100:                 ENDIF
12101: 

*-- Linhas 12138 a 12515:
12138:     *==========================================================================
12139:     * CarregarTarefas - Carrega lista de tarefas de SigCdCad (lookup)
12140:     *==========================================================================
12141:     PROCEDURE CarregarTarefas()
12142:         LOCAL loc_cSQL, loc_nRet, loc_oErro
12143:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
12144:             RETURN
12145:         ENDIF
12146:         TRY
12147:             IF USED("crTarefas")
12148:                 USE IN crTarefas
12149:             ENDIF
12150:             loc_cSQL = "SELECT LEFT(CodCads, 10) AS CodCads, DesCads " + ;
12151:                        "FROM SigCdCad " + ;
12152:                        "WHERE TipoCads = " + EscaparSQL(PADR("TAREFAS", 20))
12153:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "crTarefas")
12154:             IF loc_nRet < 1
12155:                 IF USED("crTarefas")
12156:                     USE IN crTarefas
12157:                 ENDIF
12158:             ENDIF
12159:         CATCH TO loc_oErro
12160:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de tarefas")
12161:         ENDTRY
12162:     ENDPROC
12163: 
12164:     *==========================================================================
12165:     * DesignerAfterRowColChange - Atualiza ObsTarefas e controla edicao Tarefa
12166:     *==========================================================================
12167:     PROCEDURE DesignerAfterRowColChange(par_nColIndex)
12168:         LOCAL loc_oPgDesigner, loc_lPodeEditar, loc_oErro
12169:         TRY
12170:             IF gb_4c_ValidandoUI
12171:                 RETURN
12172:             ENDIF
12173:             loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12174:             *-- Atualizar editbox de observacoes da tarefa
12175:             loc_oPgDesigner.obj_4c_GetObsTarefas.Refresh()
12176:             *-- Controlar editabilidade da coluna Tarefa (Column4)
12177:             loc_lPodeEditar = .F.
12178:             IF INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12179:                 IF USED("crSigPrTar") AND !EOF("crSigPrTar") AND !BOF("crSigPrTar")
12180:                     SELECT crSigPrTar
12181:                     IF ALLTRIM(NVL(Usuars, "")) == ALLTRIM(gc_4c_UsuarioLogado) ;
12182:                        AND EMPTY(NVL(DtFims, {}))
12183:                         loc_lPodeEditar = .T.
12184:                     ENDIF
12185:                 ENDIF
12186:             ENDIF
12187:             loc_oPgDesigner.grd_4c_Designer.Column4.ReadOnly = !loc_lPodeEditar
12188:         CATCH TO loc_oErro
12189:             *-- Tolerado: controle da coluna nao critico
12190:         ENDTRY
12191:     ENDPROC
12192: 
12193:     *==========================================================================
12194:     * DesignerCol4KeyPress - F4 abre lookup de Tarefa (crTarefas/SigCdCad)
12195:     *==========================================================================
12196:     PROCEDURE DesignerCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
12197:         LOCAL loc_oErro
12198:         TRY
12199:             IF par_nKeyCode = 115
12200:                 THIS.AbrirLookupDesignerTarefa()
12201:             ENDIF
12202:         CATCH TO loc_oErro
12203:             *-- Tolerado
12204:         ENDTRY
12205:     ENDPROC
12206: 
12207:     *==========================================================================
12208:     * AbrirLookupDesignerTarefa - Busca em crTarefas para coluna Tarefa do grid
12209:     *==========================================================================
12210:     PROTECTED PROCEDURE AbrirLookupDesignerTarefa()
12211:         LOCAL loc_oBusca, loc_cCodCads, loc_oPgDesigner, loc_oGrd, loc_oErro
12212:         TRY
12213:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
12214:                 RETURN
12215:             ENDIF
12216:             IF !INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12217:                 RETURN
12218:             ENDIF
12219:             IF !USED("crTarefas")
12220:                 THIS.CarregarTarefas()
12221:             ENDIF
12222:             IF !USED("crTarefas")
12223:                 RETURN
12224:             ENDIF
12225:             loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12226:             loc_oGrd   = loc_oPgDesigner.grd_4c_Designer
12227:             loc_cCodCads = ALLTRIM(loc_oGrd.Column4.Text1.Value)
12228:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
12229:                 "crTarefas", "cursor_4c_BuscaTar", "CodCads", loc_cCodCads, ;
12230:                 "Busca de Tarefas", .F.)
12231:             IF VARTYPE(loc_oBusca) = "O"
12232:                 IF loc_oBusca.this_lSelecionou
12233:                     IF USED("cursor_4c_BuscaTar") AND RECCOUNT("cursor_4c_BuscaTar") > 0
12234:                         SELECT cursor_4c_BuscaTar
12235:                         REPLACE crSigPrTar.Tarefas WITH ALLTRIM(CodCads)
12236:                         loc_oGrd.Refresh()
12237:                     ENDIF
12238:                 ELSE
12239:                     loc_oBusca.mAddColuna("CodCads",  "", "C" + CHR(243) + "digo")
12240:                     loc_oBusca.mAddColuna("DesCads",  "", "Descri" + CHR(231) + CHR(227) + "o")
12241:                     loc_oBusca.Show()
12242:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTar")
12243:                         SELECT cursor_4c_BuscaTar
12244:                         REPLACE crSigPrTar.Tarefas WITH ALLTRIM(CodCads)
12245:                         loc_oGrd.Refresh()
12246:                     ENDIF
12247:                 ENDIF
12248:                 loc_oBusca.Release()
12249:             ENDIF
12250:             IF USED("cursor_4c_BuscaTar")
12251:                 USE IN cursor_4c_BuscaTar
12252:             ENDIF
12253:         CATCH TO loc_oErro
12254:             MsgErro(loc_oErro.Message, "Erro ao buscar tarefa")
12255:         ENDTRY
12256:     ENDPROC
12257: 
12258:     *==========================================================================
12259:     * BtnIniTarefaClick - Inicia nova tarefa (INSERT Into crSigPrTar)
12260:     *==========================================================================
12261:     PROCEDURE BtnIniTarefaClick()
12262:         LOCAL loc_oPgDesigner, loc_oGrd, loc_dtAgora, loc_lContinuar, loc_oErro
12263:         loc_lContinuar = .T.
12264:         TRY
12265:             IF !INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12266:                 loc_lContinuar = .F.
12267:             ENDIF
12268:             IF loc_lContinuar AND !USED("crSigPrTar")
12269:                 loc_lContinuar = .F.
12270:             ENDIF
12271:             IF loc_lContinuar
12272:                 *-- Verificar se existe tarefa nao encerrada para o usuario
12273:                 SELECT crSigPrTar
12274:                 GO TOP
12275:                 LOCATE FOR ALLTRIM(NVL(Usuars,"")) == ALLTRIM(gc_4c_UsuarioLogado) ;
12276:                          AND EMPTY(NVL(DtFims, {}))
12277:                 IF !EOF("crSigPrTar")
12278:                     MsgAviso("Existe uma tarefa n" + CHR(227) + "o encerrada para esse usu" + ;
12279:                              CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12280:                     loc_lContinuar = .F.
12281:                 ENDIF
12282:             ENDIF
12283:             IF loc_lContinuar
12284:                 *-- Verificar se existe tarefa com campo Tarefas vazio
12285:                 SELECT crSigPrTar
12286:                 GO TOP
12287:                 LOCATE FOR ALLTRIM(NVL(Usuars,"")) == ALLTRIM(gc_4c_UsuarioLogado) ;
12288:                          AND EMPTY(NVL(Tarefas,""))
12289:                 IF !EOF("crSigPrTar")
12290:                     MsgAviso("Existe uma tarefa ainda n" + CHR(227) + "o informada!", ;
12291:                              "Aten" + CHR(231) + CHR(227) + "o")
12292:                     loc_lContinuar = .F.
12293:                 ENDIF
12294:             ENDIF
12295:             IF loc_lContinuar
12296:                 loc_dtAgora = DATETIME()
12297:                 INSERT INTO crSigPrTar (CPros, pkChaves, DtInis, Usuars) ;
12298:                     VALUES (PADR(ALLTRIM(this_cCodigo), 14), ;
12299:                             PADR(SYS(2015), 30), ;
12300:                             loc_dtAgora, ;
12301:                             PADR(ALLTRIM(gc_4c_UsuarioLogado), 20))
12302:                 loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12303:                 loc_oPgDesigner.grd_4c_Designer.Refresh()
12304:             ENDIF
12305:         CATCH TO loc_oErro
12306:             MsgErro(loc_oErro.Message, "Erro ao iniciar tarefa")
12307:         ENDTRY
12308:     ENDPROC
12309: 
12310:     *==========================================================================
12311:     * BtnFimTarefaClick - Finaliza tarefa atual (Replace DtFims)
12312:     *==========================================================================
12313:     PROCEDURE BtnFimTarefaClick()
12314:         LOCAL loc_oPgDesigner, loc_dtAgora, loc_lContinuar, loc_oErro
12315:         loc_lContinuar = .T.
12316:         TRY
12317:             IF !INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12318:                 loc_lContinuar = .F.
12319:             ENDIF
12320:             IF loc_lContinuar AND (!USED("crSigPrTar") OR EOF("crSigPrTar") OR BOF("crSigPrTar"))
12321:                 loc_lContinuar = .F.
12322:             ENDIF
12323:             IF loc_lContinuar
12324:                 SELECT crSigPrTar
12325:                 *-- Verificar se a tarefa pertence ao usuario atual
12326:                 IF ALLTRIM(NVL(Usuars,"")) <> ALLTRIM(gc_4c_UsuarioLogado)
12327:                     MsgAviso("Essa tarefa n" + CHR(227) + "o pertence a esse usu" + ;
12328:                              CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12329:                     loc_lContinuar = .F.
12330:                 ENDIF
12331:             ENDIF
12332:             IF loc_lContinuar
12333:                 SELECT crSigPrTar
12334:                 *-- Verificar se a tarefa ja esta finalizada
12335:                 IF !EMPTY(NVL(DtFims, {}))
12336:                     MsgAviso("Essa tarefa j" + CHR(225) + " se encontra finalizada!", ;
12337:                              "Aten" + CHR(231) + CHR(227) + "o")
12338:                     loc_lContinuar = .F.
12339:                 ENDIF
12340:             ENDIF
12341:             IF loc_lContinuar
12342:                 loc_dtAgora = DATETIME()
12343:                 REPLACE DtFims WITH loc_dtAgora IN crSigPrTar
12344:                 loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12345:                 loc_oPgDesigner.grd_4c_Designer.Refresh()
12346:                 THIS.DesignerAfterRowColChange(0)
12347:             ENDIF
12348:         CATCH TO loc_oErro
12349:             MsgErro(loc_oErro.Message, "Erro ao finalizar tarefa")
12350:         ENDTRY
12351:     ENDPROC
12352: 
12353:     *==========================================================================
12354:     * ArquivosAfterRowColChange - Exibe preview de imagem para arquivo selecionado
12355:     *==========================================================================
12356:     PROCEDURE ArquivosAfterRowColChange(par_nColIndex)
12357:         LOCAL loc_oPgDesigner, loc_cArq, loc_cExt, loc_oErro
12358:         TRY
12359:             IF gb_4c_ValidandoUI
12360:                 RETURN
12361:             ENDIF
12362:             loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12363:             loc_oPgDesigner.img_4c_ImgArqJpg.Picture = ""
12364:             loc_oPgDesigner.img_4c_ImgArqJpg.Visible = .F.
12365:             IF !USED("crSigPrArq") OR EOF("crSigPrArq") OR BOF("crSigPrArq")
12366:                 RETURN
12367:             ENDIF
12368:             SELECT crSigPrArq
12369:             loc_cArq = ALLTRIM(NVL(Arquivos, ""))
12370:             IF EMPTY(loc_cArq)
12371:                 RETURN
12372:             ENDIF
12373:             loc_cExt = ALLTRIM(UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq), 5)))
12374:             IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG") AND FILE(loc_cArq)
12375:                 CLEAR RESOURCES
12376:                 loc_oPgDesigner.img_4c_ImgArqJpg.Picture  = loc_cArq
12377:                 loc_oPgDesigner.img_4c_ImgArqJpg.Visible  = .T.
12378:             ENDIF
12379:         CATCH TO loc_oErro
12380:             *-- Tolerado: preview de imagem nao critico
12381:         ENDTRY
12382:     ENDPROC
12383: 
12384:     *==========================================================================
12385:     * BtnInsArqsClick - Insere arquivo no cursor crSigPrArq (GetFile)
12386:     *==========================================================================
12387:     PROCEDURE BtnInsArqsClick()
12388:         LOCAL loc_cArq, loc_oPgDesigner, loc_lContinuar, loc_oErro
12389:         loc_lContinuar = .T.
12390:         TRY
12391:             IF !INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12392:                 loc_lContinuar = .F.
12393:             ENDIF
12394:             IF loc_lContinuar
12395:                 loc_cArq = GETFILE("", "Selecione o Arquivo", "Selecione o Arquivo", 0, ;
12396:                     "Sele" + CHR(231) + CHR(227) + "o de Arquivos")
12397:                 IF !EMPTY(loc_cArq)
12398:                     INSERT INTO crSigPrArq (CPros, pkChaves, Arquivos) ;
12399:                         VALUES (PADR(ALLTRIM(this_cCodigo), 14), ;
12400:                                 PADR(SYS(2015), 30), ;
12401:                                 UPPER(loc_cArq))
12402:                     loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12403:                     loc_oPgDesigner.grd_4c_Arquivos.Refresh()
12404:                 ENDIF
12405:             ENDIF
12406:         CATCH TO loc_oErro
12407:             MsgErro(loc_oErro.Message, "Erro ao inserir arquivo")
12408:         ENDTRY
12409:     ENDPROC
12410: 
12411:     *==========================================================================
12412:     * BtnOpnArqsClick - Abre arquivo selecionado com Shell.Application
12413:     *==========================================================================
12414:     PROCEDURE BtnOpnArqsClick()
12415:         LOCAL loc_cArq, loc_oShell, loc_lContinuar, loc_oErro
12416:         loc_lContinuar = .T.
12417:         TRY
12418:             IF !USED("crSigPrArq") OR EOF("crSigPrArq") OR BOF("crSigPrArq")
12419:                 loc_lContinuar = .F.
12420:             ENDIF
12421:             IF loc_lContinuar
12422:                 SELECT crSigPrArq
12423:                 loc_cArq = ALLTRIM(NVL(Arquivos, ""))
12424:                 IF EMPTY(loc_cArq)
12425:                     loc_lContinuar = .F.
12426:                 ENDIF
12427:             ENDIF
12428:             IF loc_lContinuar
12429:                 IF FILE(loc_cArq)
12430:                     loc_oShell = CREATEOBJECT("Shell.Application")
12431:                     IF VARTYPE(loc_oShell) = "O"
12432:                         loc_oShell.Open(loc_cArq)
12433:                     ENDIF
12434:                 ELSE
12435:                     MsgAviso("Arquivo n" + CHR(227) + "o encontrado: " + loc_cArq, ;
12436:                              "Aten" + CHR(231) + CHR(227) + "o")
12437:                 ENDIF
12438:             ENDIF
12439:         CATCH TO loc_oErro
12440:             MsgErro(loc_oErro.Message, "Erro ao abrir arquivo")
12441:         ENDTRY
12442:     ENDPROC
12443: 
12444:     *==========================================================================
12445:     * BtnExcArqsClick - Exclui arquivo do cursor crSigPrArq
12446:     *==========================================================================
12447:     PROCEDURE BtnExcArqsClick()
12448:         LOCAL loc_oPgDesigner, loc_lContinuar, loc_oErro
12449:         loc_lContinuar = .T.
12450:         TRY
12451:             IF !INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12452:                 loc_lContinuar = .F.
12453:             ENDIF
12454:             IF loc_lContinuar AND (!USED("crSigPrArq") OR EOF("crSigPrArq") OR BOF("crSigPrArq"))
12455:                 loc_lContinuar = .F.
12456:             ENDIF
12457:             IF loc_lContinuar
12458:                 SELECT crSigPrArq
12459:                 IF !EMPTY(ALLTRIM(NVL(Arquivos, "")))
12460:                     DELETE IN crSigPrArq
12461:                     IF !EOF("crSigPrArq")
12462:                         SKIP IN crSigPrArq
12463:                     ENDIF
12464:                 ENDIF
12465:                 loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12466:                 loc_oPgDesigner.grd_4c_Arquivos.Refresh()
12467:                 THIS.ArquivosAfterRowColChange(0)
12468:             ENDIF
12469:         CATCH TO loc_oErro
12470:             MsgErro(loc_oErro.Message, "Erro ao excluir arquivo")
12471:         ENDTRY
12472:     ENDPROC
12473: 
12474:     *==========================================================================
12475:     * ImgArqJpgClick - Zoom na imagem (abre SigOpZom se for imagem valida)
12476:     *==========================================================================
12477:     PROCEDURE ImgArqJpgClick()
12478:         LOCAL loc_cArq, loc_cExt, loc_lContinuar, loc_oErro
12479:         loc_lContinuar = .T.
12480:         TRY
12481:             IF !USED("crSigPrArq") OR EOF("crSigPrArq") OR BOF("crSigPrArq")
12482:                 loc_lContinuar = .F.
12483:             ENDIF
12484:             IF loc_lContinuar
12485:                 SELECT crSigPrArq
12486:                 loc_cArq = ALLTRIM(NVL(Arquivos, ""))
12487:                 IF EMPTY(loc_cArq)
12488:                     loc_lContinuar = .F.
12489:                 ENDIF
12490:             ENDIF
12491:             IF loc_lContinuar
12492:                 loc_cExt = ALLTRIM(UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq), 5)))
12493:                 IF FILE(loc_cArq) AND INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
12494:                     DO FORM SigOpZom WITH loc_cArq, "Arquivo: " + loc_cArq
12495:                 ENDIF
12496:             ENDIF
12497:         CATCH TO loc_oErro
12498:             MsgErro(loc_oErro.Message, "Erro ao exibir imagem em zoom")
12499:         ENDTRY
12500:     ENDPROC
12501: 
12502:     *--------------------------------------------------------------------------
12503:     PROCEDURE Destroy()
12504:         LOCAL loc_oErro
12505:         TRY
12506:             IF VARTYPE(this_oBusinessObject) = "O"
12507:                 this_oBusinessObject = .NULL.
12508:             ENDIF
12509:         CATCH TO loc_oErro
12510:             *-- Tolerado durante Destroy
12511:         ENDTRY
12512:         DODEFAULT()
12513:     ENDPROC
12514: 
12515: ENDDEFINE


### BO (C:\4c\projeto\app\classes\ProdutoBO.prg):
*==============================================================================
* ProdutoBO.prg - Business Object para Cadastro de Produtos (SigCdPro)
* Gerado: Fase 8/8 - Completo, tabela SigCdPro
*==============================================================================

DEFINE CLASS ProdutoBO AS BusinessBase

    *-- Identificacao
    this_cCpros       = ""    && CPros  char(14) - PK: codigo do produto
    *-- Descricoes
    this_cDpros       = ""    && DPros  - descricao principal
    this_cDPro2s      = ""    && DPro2s - descricao secundaria
    this_cDPro3s      = ""    && DPro3s - descricao memo (editbox)
    *-- Grupo / Subgrupo
    this_cCgrus       = ""    && CGrus  - codigo do grupo
    this_cSGrus       = ""    && SGrus  - codigo do subgrupo
    *-- Fornecedor / Referencia / Colecao
    this_cIFors       = ""    && IFors  - codigo do fornecedor
    this_cReffs       = ""    && Reffs  - referencia do fornecedor
    this_cColecoes    = ""    && Colecoes - colecao
    *-- Codigos auxiliares
    this_cCbars       = ""    && Cbars    - codigo de barras
    this_cEAN13       = ""    && EAN13    - EAN-13 (se campo separado)
    this_cCProEqs     = ""    && CProEqs  - produto equivalente
    this_cIdeCPros    = ""    && IdeCPros - identificador
    this_cMercs       = ""    && Mercs    - mercadoria
    *-- Linha / Colecao
    this_cLins        = ""    && Lins     - codigo da linha
    this_cCols        = ""    && Cols     - codigo da colecao/grupo venda
    *-- Unidades
    this_cCUnis       = ""    && CUnis    - unidade 1
    this_cCUnips      = ""    && CUnips   - unidade 2
    *-- Dimensoes
    this_nAlturas     = 0     && Alturas
    this_nLarguras    = 0     && Larguras
    this_nDiametros   = 0     && Diametros
    this_nEspessuras  = 0     && Espessuras
    this_nCompriments = 0     && Compriments
    this_nPesoMs      = 0     && PesoMs      - peso base
    this_nPesoBs      = 0     && PesoBs      - peso bruto
    this_nPesoPmedios = 0     && PesoPmedios - peso medio
    *-- Classificacoes
    this_cTams        = ""    && Tams     - tamanho
    this_cCorPros     = ""    && CorPros  - cor
    this_cCodFinPs    = ""    && CodFinPs - finalidade
    this_cCodAcbs     = ""    && CodAcbs  - acabamento
    this_cLocals      = ""    && Locals   - local
    this_cClasss      = ""    && Classs   - classificacao
    *-- Precos e moedas
    this_nPvens       = 0     && Pvens    - preco de venda
    this_cMoevs       = ""    && Moevs    - moeda venda
    this_nFvendas     = 0     && Fvendas  - fator venda
    this_cMfvendas    = ""    && Mfvendas - moeda fator venda
    this_nCustofs     = 0     && Custofs  - custo
    this_cMoecs       = ""    && Moecs    - moeda custo
    this_nMargems     = 0     && Margems  - margem
    this_nPcuss       = 0     && Pcuss    - preco custo unitario
    this_cMoePcs      = ""    && MoePcs   - moeda preco custo
    this_nFcustos     = 0     && Fcustos  - fator custo
    this_nPFTioCs     = 0     && PFTioCs  - feitio custo
    this_nPFTios      = 0     && PFTios   - feitio venda
    *-- Quantidades e lotes
    this_nQmins       = 0     && Qmins    - quantidade minima
    this_nLtMinsVs    = 0     && LtMinsVs - lote minimo venda
    this_nConjuntos   = 0     && Conjuntos - conjunto
    this_nQtPeds      = 0     && QtPeds   - quantidade pedido
    *-- Flags booleanos (armazenados como INT 0/1)
    this_nGarVits     = 0     && GarVits     - garantia vitrine
    this_nConsigs     = 0     && Consigs     - consignado
    this_nFabrProprs  = 0     && FabrProprs  - fabricacao propria
    this_nEncoms      = 0     && Encoms      - encomenda
    this_nProdWebs    = 0     && ProdWebs    - produto web
    this_nOpcVars     = 0     && OpcVars     - opcao variacao
    this_nInstalas    = 0     && Instalas    - instalado/ativo (chkInstalas)
    *-- Status e situacao
    this_nSituas      = 0     && Situas  - situacao
    this_dDtSituas    = {}    && DtSituas - data situacao
    *-- Observacoes
    this_cObs1s       = ""    && Obs1s
    this_cObs2s       = ""    && Obs2s
    this_cObs3s       = ""    && Obs3s
    this_cDscCompras  = ""    && DscCompras - descricao compras (memo)
    this_cObsCompras  = ""    && ObsCompras - obs compras (memo)
    *-- Campos customizados
    this_cFwget3s     = ""    && Fwget3s
    this_cFwget4s     = ""    && Fwget4s
    this_cFwget5s     = ""    && Fwget5s
    this_cFwget6s     = ""    && Fwget6s
    this_cCodIdents   = ""    && CodIdents
    this_cTEnts       = ""    && TEnts  - tipo entrada
    this_nDiasGars    = 0     && DiasGars - dias de garantia
    *-- Campos FaseP (Fase P - dados de processo)
    this_nQtMinFabs   = 0     && QtMinFabs  - qtd minima fabricacao
    this_cCodGarras   = ""    && CodGarras  - codigo de garras
    this_cConquilhas  = ""    && Conquilhas - conquilha padrao
    this_nPesoBris    = 0     && PesoBris   - peso brilhante
    this_nPesoMetal   = 0     && PesoMetal  - peso metal
    this_nPesoPdrs    = 0     && PesoPdrs   - peso pedra
    this_nCravCers    = 0     && CravCers   - cravacao em cera (0/1)
    this_nVarias      = 0     && Varias     - peso variavel (0/1)
    *-- Estoque e auditoria (somente leitura)
    this_nEstoques    = 0     && Estoques
    this_nQtdEsts     = 0     && QtdEsts
    this_dDtIncs      = {}    && DtIncs  - data de inclusao
    this_dDataAlts    = {}    && DataAlts - data alteracao
    this_cHoraAlts    = ""    && HoraAlts - hora alteracao
    this_cUsuaIncs    = ""    && UsuaIncs - usuario inclusao
    this_cUsuaAlts    = ""    && UsuaAlts - usuario alteracao
    this_dDtucps      = {}    && Dtucps  - data ult. compra
    this_nVucps       = 0     && Vucps   - valor ult. compra
    this_cMucps       = ""    && Mucps   - moeda ult. compra
    this_nQtdUltComps = 0     && QtdUltComps - qtd ult. compra

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCpros       = TratarNulo(CPros,       "C")
                THIS.this_cDpros       = TratarNulo(DPros,       "C")
                THIS.this_cDPro2s      = TratarNulo(DPro2s,      "C")
                THIS.this_cDPro3s      = TratarNulo(DPro3s,      "C")
                THIS.this_cCgrus       = TratarNulo(CGrus,       "C")
                THIS.this_cSGrus       = TratarNulo(SGrus,       "C")
                THIS.this_cIFors       = TratarNulo(IFors,       "C")
                THIS.this_cReffs       = TratarNulo(Reffs,       "C")
                THIS.this_cColecoes    = TratarNulo(Colecoes,    "C")
                THIS.this_cCbars       = TratarNulo(Cbars,       "C")
                THIS.this_cCProEqs     = TratarNulo(CProEqs,     "C")
                THIS.this_cIdeCPros    = TratarNulo(IdeCPros,    "C")
                THIS.this_cMercs       = TratarNulo(Mercs,       "C")
                THIS.this_cLins        = TratarNulo(Lins,        "C")
                THIS.this_cCols        = TratarNulo(Cols,        "C")
                THIS.this_cCUnis       = TratarNulo(CUnis,       "C")
                THIS.this_cCUnips      = TratarNulo(CUnips,      "C")
                THIS.this_nAlturas     = TratarNulo(Alturas,     "N")
                THIS.this_nLarguras    = TratarNulo(Larguras,    "N")
                THIS.this_nDiametros   = TratarNulo(Diametros,   "N")
                THIS.this_nEspessuras  = TratarNulo(Espessuras,  "N")
                THIS.this_nCompriments = TratarNulo(Compriments, "N")
                THIS.this_nPesoMs      = TratarNulo(PesoMs,      "N")
                THIS.this_nPesoBs      = TratarNulo(PesoBs,      "N")
                THIS.this_nPesoPmedios = TratarNulo(PesoPmedios, "N")
                THIS.this_cTams        = TratarNulo(Tams,        "C")
                THIS.this_cCorPros     = TratarNulo(CorPros,     "C")
                THIS.this_cCodFinPs    = TratarNulo(CodFinPs,    "C")
                THIS.this_cCodAcbs     = TratarNulo(CodAcbs,     "C")
                THIS.this_cLocals      = TratarNulo(Locals,      "C")
                THIS.this_cClasss      = TratarNulo(Classs,      "C")
                THIS.this_nPvens       = TratarNulo(Pvens,       "N")
                THIS.this_cMoevs       = TratarNulo(Moevs,       "C")
                THIS.this_nFvendas     = TratarNulo(Fvendas,     "N")
                THIS.this_cMfvendas    = TratarNulo(Mfvendas,    "C")
                THIS.this_nCustofs     = TratarNulo(Custofs,     "N")
                THIS.this_cMoecs       = TratarNulo(Moecs,       "C")
                THIS.this_nMargems     = TratarNulo(Margems,     "N")
                THIS.this_nQmins       = TratarNulo(Qmins,       "N")
                THIS.this_nLtMinsVs    = TratarNulo(LtMinsVs,    "N")
                THIS.this_nConjuntos   = TratarNulo(Conjuntos,   "N")
                THIS.this_nQtPeds      = TratarNulo(QtPeds,      "N")
                THIS.this_nGarVits     = TratarNulo(GarVits,     "N")
                THIS.this_nConsigs     = TratarNulo(Consigs,     "N")
                THIS.this_nFabrProprs  = TratarNulo(FabrProprs,  "N")
                THIS.this_nEncoms      = TratarNulo(Encoms,      "N")
                THIS.this_nProdWebs    = TratarNulo(ProdWebs,    "N")
                THIS.this_nOpcVars     = TratarNulo(OpcVars,     "N")
                THIS.this_nInstalas    = TratarNulo(Instalas,    "N")
                THIS.this_nSituas      = TratarNulo(Situas,      "N")
                THIS.this_dDtSituas    = TratarNulo(DtSituas,    "D")
                THIS.this_cObs1s       = TratarNulo(Obs1s,       "C")
                THIS.this_cObs2s       = TratarNulo(Obs2s,       "C")
                THIS.this_cObs3s       = TratarNulo(Obs3s,       "C")
                THIS.this_cDscCompras  = TratarNulo(DscCompras,  "C")
                THIS.this_cObsCompras  = TratarNulo(ObsCompras,  "C")
                THIS.this_cFwget3s     = TratarNulo(Fwget3s,     "C")
                THIS.this_cFwget4s     = TratarNulo(Fwget4s,     "C")
                THIS.this_cFwget5s     = TratarNulo(Fwget5s,     "C")
                THIS.this_cFwget6s     = TratarNulo(Fwget6s,     "C")
                THIS.this_cCodIdents   = TratarNulo(CodIdents,   "C")
                THIS.this_cTEnts       = TratarNulo(TEnts,       "C")
                THIS.this_nDiasGars    = TratarNulo(DiasGars,    "N")
                THIS.this_nQtMinFabs   = TratarNulo(QtMinFabs,   "N")
                THIS.this_cCodGarras   = TratarNulo(CodGarras,   "C")
                THIS.this_cConquilhas  = TratarNulo(Conquilhas,  "C")
                THIS.this_nPesoBris    = TratarNulo(PesoBris,    "N")
                THIS.this_nPesoMetal   = TratarNulo(PesoMetal,   "N")
                THIS.this_nPesoPdrs    = TratarNulo(PesoPdrs,    "N")
                THIS.this_nCravCers    = TratarNulo(CravCers,    "N")
                THIS.this_nVarias      = TratarNulo(Varias,      "N")
                THIS.this_nEstoques    = TratarNulo(Estoques,    "N")
                THIS.this_nQtdEsts     = TratarNulo(QtdEsts,     "N")
                THIS.this_dDtIncs      = TratarNulo(DtIncs,      "D")
                THIS.this_dDataAlts    = TratarNulo(DataAlts,    "D")
                THIS.this_cHoraAlts    = TratarNulo(HoraAlts,    "C")
                THIS.this_cUsuaIncs    = TratarNulo(UsuaIncs,    "C")
                THIS.this_cUsuaAlts    = TratarNulo(UsuaAlts,    "C")
                THIS.this_dDtucps      = TratarNulo(Dtucps,      "D")
                THIS.this_nVucps       = TratarNulo(Vucps,       "N")
                THIS.this_cMucps       = TratarNulo(Mucps,       "C")
                THIS.this_nQtdUltComps = TratarNulo(QtdUltComps, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar produto do cursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCpros
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Busca o produto no banco pelo CPros
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_nRet, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cCodigo) OR gnConnHandle <= 0
                loc_lSucesso = loc_lSucesso
            ENDIF
            IF USED("cursor_4c_ProdutoBO")
                USE IN cursor_4c_ProdutoBO
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigCdPro WHERE CPros = " + ;
                EscaparSQL(PADR(ALLTRIM(par_cCodigo), 14)), ;
                "cursor_4c_ProdutoBO")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ProdutoBO") > 0
                THIS.CarregarDoCursor("cursor_4c_ProdutoBO")
                loc_lSucesso = .T.
            ENDIF
            IF USED("cursor_4c_ProdutoBO")
                USE IN cursor_4c_ProdutoBO
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Retorna cursor com lista de produtos (filtro SQL WHERE opcional)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nRet, loc_oErro
        TRY
            IF USED("cursor_4c_BuscarBO")
                USE IN cursor_4c_BuscarBO
            ENDIF
            loc_cSQL = "SELECT CPros, DPros, CGrus, SGrus, Reffs, " + ;
                       "UsuaAlts, CAST(ISNULL(Instalas,0) AS INT) AS Instalas " + ;
                       "FROM SigCdPro"
            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY CPros"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscarBO")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar produtos")
        ENDTRY
        RETURN loc_nRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigCdPro (" + ;
                "CPros, DPros, DPro2s, CGrus, SGrus, IFors, Reffs, Colecoes, " + ;
                "Cbars, CProEqs, IdeCPros, Mercs, Lins, Cols, CUnis, CUnips, " + ;
                "Alturas, Larguras, Diametros, Espessuras, Compriments, " + ;
                "PesoMs, PesoBs, PesoPmedios, Tams, CorPros, CodFinPs, " + ;
                "CodAcbs, Locals, Classs, " + ;
                "Pvens, Moevs, Fvendas, Mfvendas, Custofs, Moecs, Margems, " + ;
                "Qmins, LtMinsVs, Conjuntos, QtPeds, DiasGars, " + ;
                "GarVits, Consigs, FabrProprs, Encoms, ProdWebs, OpcVars, Instalas, " + ;
                "Situas, DtSituas, Obs1s, Obs2s, Obs3s, DscCompras, ObsCompras, " + ;
                "Fwget3s, Fwget4s, Fwget5s, Fwget6s, CodIdents, TEnts, " + ;
                "QtMinFabs, CodGarras, Conquilhas, PesoBris, PesoMetal, PesoPdrs, CravCers, Varias, " + ;
                "DtIncs, UsuaIncs, DataAlts, UsuaAlts" + ;
                ") VALUES (" + ;
                EscaparSQL(PADR(THIS.this_cCpros, 14)) + "," + ;
                EscaparSQL(THIS.this_cDpros) + "," + ;
                EscaparSQL(THIS.this_cDPro2s) + "," + ;
                EscaparSQL(PADR(THIS.this_cCgrus, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cSGrus, 10)) + "," + ;
                EscaparSQL(THIS.this_cIFors) + "," + ;
                EscaparSQL(THIS.this_cReffs) + "," + ;
                EscaparSQL(THIS.this_cColecoes) + "," + ;
                EscaparSQL(THIS.this_cCbars) + "," + ;
                EscaparSQL(PADR(THIS.this_cCProEqs, 14)) + "," + ;
                EscaparSQL(THIS.this_cIdeCPros) + "," + ;
                EscaparSQL(THIS.this_cMercs) + "," + ;
                EscaparSQL(THIS.this_cLins) + "," + ;
                EscaparSQL(THIS.this_cCols) + "," + ;
                EscaparSQL(THIS.this_cCUnis) + "," + ;
                EscaparSQL(THIS.this_cCUnips) + "," + ;
                FormatarNumeroSQL(THIS.this_nAlturas) + "," + ;
                FormatarNumeroSQL(THIS.this_nLarguras) + "," + ;
                FormatarNumeroSQL(THIS.this_nDiametros) + "," + ;
                FormatarNumeroSQL(THIS.this_nEspessuras) + "," + ;
                FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoPmedios) + "," + ;
                EscaparSQL(THIS.this_cTams) + "," + ;
                EscaparSQL(THIS.this_cCorPros) + "," + ;
                EscaparSQL(THIS.this_cCodFinPs) + "," + ;
                EscaparSQL(THIS.this_cCodAcbs) + "," + ;
                EscaparSQL(THIS.this_cLocals) + "," + ;
                EscaparSQL(THIS.this_cClasss) + "," + ;
                FormatarNumeroSQL(THIS.this_nPvens) + "," + ;
                EscaparSQL(THIS.this_cMoevs) + "," + ;
                FormatarNumeroSQL(THIS.this_nFvendas) + "," + ;
                EscaparSQL(THIS.this_cMfvendas) + "," + ;
                FormatarNumeroSQL(THIS.this_nCustofs) + "," + ;
                EscaparSQL(THIS.this_cMoecs) + "," + ;
                FormatarNumeroSQL(THIS.this_nMargems) + "," + ;
                FormatarNumeroSQL(THIS.this_nQmins) + "," + ;
                FormatarNumeroSQL(THIS.this_nLtMinsVs) + "," + ;
                FormatarNumeroSQL(THIS.this_nConjuntos) + "," + ;
                FormatarNumeroSQL(THIS.this_nQtPeds) + "," + ;
                FormatarNumeroSQL(THIS.this_nDiasGars) + "," + ;
                FormatarNumeroSQL(THIS.this_nGarVits) + "," + ;
                FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;
                FormatarNumeroSQL(THIS.this_nFabrProprs) + "," + ;
                FormatarNumeroSQL(THIS.this_nEncoms) + "," + ;
                FormatarNumeroSQL(THIS.this_nProdWebs) + "," + ;
                FormatarNumeroSQL(THIS.this_nOpcVars) + "," + ;
                FormatarNumeroSQL(THIS.this_nInstalas) + "," + ;
                FormatarNumeroSQL(THIS.this_nSituas) + "," + ;
                FormatarDataSQL(THIS.this_dDtSituas) + "," + ;
                EscaparSQL(THIS.this_cObs1s) + "," + ;
                EscaparSQL(THIS.this_cObs2s) + "," + ;
                EscaparSQL(THIS.this_cObs3s) + "," + ;
                EscaparSQL(THIS.this_cDscCompras) + "," + ;
                EscaparSQL(THIS.this_cObsCompras) + "," + ;
                EscaparSQL(THIS.this_cFwget3s) + "," + ;
                EscaparSQL(THIS.this_cFwget4s) + "," + ;
                EscaparSQL(THIS.this_cFwget5s) + "," + ;
                EscaparSQL(THIS.this_cFwget6s) + "," + ;
                EscaparSQL(THIS.this_cCodIdents) + "," + ;
                EscaparSQL(THIS.this_cTEnts) + "," + ;
                FormatarNumeroSQL(THIS.this_nQtMinFabs) + "," + ;
                EscaparSQL(THIS.this_cCodGarras) + "," + ;
                EscaparSQL(THIS.this_cConquilhas) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoBris) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoMetal) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoPdrs) + "," + ;
                FormatarNumeroSQL(THIS.this_nCravCers) + "," + ;
                FormatarNumeroSQL(THIS.this_nVarias) + "," + ;
                "GETDATE()," + ;
                EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                "GETDATE()," + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ;
                ")"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCdPro SET " + ;
                "DPros       = " + EscaparSQL(THIS.this_cDpros) + "," + ;
                "DPro2s      = " + EscaparSQL(THIS.this_cDPro2s) + "," + ;
                "CGrus       = " + EscaparSQL(PADR(THIS.this_cCgrus, 10)) + "," + ;
                "SGrus       = " + EscaparSQL(PADR(THIS.this_cSGrus, 10)) + "," + ;
                "IFors       = " + EscaparSQL(THIS.this_cIFors) + "," + ;
                "Reffs       = " + EscaparSQL(THIS.this_cReffs) + "," + ;
                "Colecoes    = " + EscaparSQL(THIS.this_cColecoes) + "," + ;
                "Cbars       = " + EscaparSQL(THIS.this_cCbars) + "," + ;
                "CProEqs     = " + EscaparSQL(PADR(THIS.this_cCProEqs, 14)) + "," + ;
                "IdeCPros    = " + EscaparSQL(THIS.this_cIdeCPros) + "," + ;
                "Mercs       = " + EscaparSQL(THIS.this_cMercs) + "," + ;
                "Lins        = " + EscaparSQL(THIS.this_cLins) + "," + ;
                "Cols        = " + EscaparSQL(THIS.this_cCols) + "," + ;
                "CUnis       = " + EscaparSQL(THIS.this_cCUnis) + "," + ;
                "CUnips      = " + EscaparSQL(THIS.this_cCUnips) + "," + ;
                "Alturas     = " + FormatarNumeroSQL(THIS.this_nAlturas) + "," + ;
                "Larguras    = " + FormatarNumeroSQL(THIS.this_nLarguras) + "," + ;
                "Diametros   = " + FormatarNumeroSQL(THIS.this_nDiametros) + "," + ;
                "Espessuras  = " + FormatarNumeroSQL(THIS.this_nEspessuras) + "," + ;
                "Compriments = " + FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
                "PesoMs      = " + FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
                "PesoBs      = " + FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;
                "PesoPmedios = " + FormatarNumeroSQL(THIS.this_nPesoPmedios) + "," + ;
                "Tams        = " + EscaparSQL(THIS.this_cTams) + "," + ;
                "CorPros     = " + EscaparSQL(THIS.this_cCorPros) + "," + ;
                "CodFinPs    = " + EscaparSQL(THIS.this_cCodFinPs) + "," + ;
                "CodAcbs     = " + EscaparSQL(THIS.this_cCodAcbs) + "," + ;
                "Locals      = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                "Classs      = " + EscaparSQL(THIS.this_cClasss) + "," + ;
                "Pvens       = " + FormatarNumeroSQL(THIS.this_nPvens) + "," + ;
                "Moevs       = " + EscaparSQL(THIS.this_cMoevs) + "," + ;
                "Fvendas     = " + FormatarNumeroSQL(THIS.this_nFvendas) + "," + ;
                "Mfvendas    = " + EscaparSQL(THIS.this_cMfvendas) + "," + ;
                "Custofs     = " + FormatarNumeroSQL(THIS.this_nCustofs) + "," + ;
                "Moecs       = " + EscaparSQL(THIS.this_cMoecs) + "," + ;
                "Margems     = " + FormatarNumeroSQL(THIS.this_nMargems) + "," + ;
                "Qmins       = " + FormatarNumeroSQL(THIS.this_nQmins) + "," + ;
                "LtMinsVs    = " + FormatarNumeroSQL(THIS.this_nLtMinsVs) + "," + ;
                "Conjuntos   = " + FormatarNumeroSQL(THIS.this_nConjuntos) + "," + ;
                "QtPeds      = " + FormatarNumeroSQL(THIS.this_nQtPeds) + "," + ;
                "DiasGars    = " + FormatarNumeroSQL(THIS.this_nDiasGars) + "," + ;
                "GarVits     = " + FormatarNumeroSQL(THIS.this_nGarVits) + "," + ;
                "Consigs     = " + FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;
                "FabrProprs  = " + FormatarNumeroSQL(THIS.this_nFabrProprs) + "," + ;
                "Encoms      = " + FormatarNumeroSQL(THIS.this_nEncoms) + "," + ;
                "ProdWebs    = " + FormatarNumeroSQL(THIS.this_nProdWebs) + "," + ;
                "OpcVars     = " + FormatarNumeroSQL(THIS.this_nOpcVars) + "," + ;
                "Instalas    = " + FormatarNumeroSQL(THIS.this_nInstalas) + "," + ;
                "Situas      = " + FormatarNumeroSQL(THIS.this_nSituas) + "," + ;
                "DtSituas    = " + FormatarDataSQL(THIS.this_dDtSituas) + "," + ;
                "Obs1s       = " + EscaparSQL(THIS.this_cObs1s) + "," + ;
                "Obs2s       = " + EscaparSQL(THIS.this_cObs2s) + "," + ;
                "Obs3s       = " + EscaparSQL(THIS.this_cObs3s) + "," + ;
                "DscCompras  = " + EscaparSQL(THIS.this_cDscCompras) + "," + ;
                "ObsCompras  = " + EscaparSQL(THIS.this_cObsCompras) + "," + ;
                "Fwget3s     = " + EscaparSQL(THIS.this_cFwget3s) + "," + ;
                "Fwget4s     = " + EscaparSQL(THIS.this_cFwget4s) + "," + ;
                "Fwget5s     = " + EscaparSQL(THIS.this_cFwget5s) + "," + ;
                "Fwget6s     = " + EscaparSQL(THIS.this_cFwget6s) + "," + ;
                "CodIdents   = " + EscaparSQL(THIS.this_cCodIdents) + "," + ;
                "TEnts       = " + EscaparSQL(THIS.this_cTEnts) + "," + ;
                "QtMinFabs   = " + FormatarNumeroSQL(THIS.this_nQtMinFabs) + "," + ;
                "CodGarras   = " + EscaparSQL(THIS.this_cCodGarras) + "," + ;
                "Conquilhas  = " + EscaparSQL(THIS.this_cConquilhas) + "," + ;
                "PesoBris    = " + FormatarNumeroSQL(THIS.this_nPesoBris) + "," + ;
                "PesoMetal   = " + FormatarNumeroSQL(THIS.this_nPesoMetal) + "," + ;
                "PesoPdrs    = " + FormatarNumeroSQL(THIS.this_nPesoPdrs) + "," + ;
                "CravCers    = " + FormatarNumeroSQL(THIS.this_nCravCers) + "," + ;
                "Varias      = " + FormatarNumeroSQL(THIS.this_nVarias) + "," + ;
                "DataAlts    = GETDATE()," + ;
                "UsuaAlts    = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE CPros = " + EscaparSQL(PADR(THIS.this_cCpros, 14))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdPro (chamado por Excluir() do BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdPro WHERE CPros = " + ;
                EscaparSQL(PADR(THIS.this_cCpros, 14))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

