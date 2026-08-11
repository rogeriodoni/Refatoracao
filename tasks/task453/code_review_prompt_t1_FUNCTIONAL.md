# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (81)
- [LOSTFOCUS-SEM-GUARDIA] Handler 'GetJustifValid' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoGetJustifValidValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'GetTOcorCntTratValid' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoGetTOcorCntTratValidValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'GetTOcorBaixaAutoValid' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoGetTOcorBaixaAutoValidValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'GetIOcorValid' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoGetIOcorValidValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Tratamento' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_TratamentoTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-HEADER] Header Caption 'Dif.Peso' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Inicial' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Final' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Local Ini.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Local Fin.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Gde.Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Encerrado' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Grupo' (parent: SIGCDINT.Pagina.Lista): Top original=124 vs migrado 'txt_4c_GrupoInicial' Top=286 (diff=162px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Grupo' (parent: SIGCDINT.Pagina.Lista): Left original=529 vs migrado 'txt_4c_GrupoInicial' Left=569 (diff=40px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Custo2): Top original=115 vs migrado 'lbl_4c_Label1' Top=265 (diff=150px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Custo2): Top original=92 vs migrado 'lbl_4c_Label5' Top=265 (diff=173px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Custo2): Left original=231 vs migrado 'lbl_4c_Label5' Left=626 (diff=395px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Custo2): Top original=43 vs migrado 'lbl_4c_Label3' Top=190 (diff=147px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Custo2): Top original=18 vs migrado 'lbl_4c_Label4' Top=265 (diff=247px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Custo2): Left original=270 vs migrado 'lbl_4c_Label4' Left=387 (diff=117px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Custo2): Top original=68 vs migrado 'lbl_4c_Label2' Top=265 (diff=197px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Custo2): Left original=301 vs migrado 'lbl_4c_Label2' Left=527 (diff=226px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cancela' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Top original=43 vs migrado 'cmd_4c_BNCancela' Top=9 (diff=34px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cancela' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Left original=507 vs migrado 'cmd_4c_BNCancela' Left=570 (diff=63px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Top original=7 vs migrado 'lbl_4c_Label3' Top=190 (diff=183px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Left original=16 vs migrado 'lbl_4c_Label3' Left=252 (diff=236px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Top original=149 vs migrado 'lbl_4c_Label8' Top=290 (diff=141px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Left original=337 vs migrado 'lbl_4c_Label8' Left=521 (diff=184px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Top original=17 vs migrado 'lbl_4c_Label2' Top=265 (diff=248px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Left original=383 vs migrado 'lbl_4c_Label2' Left=527 (diff=144px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Top original=123 vs migrado 'lbl_4c_Label7' Top=290 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Left original=344 vs migrado 'lbl_4c_Label7' Left=387 (diff=43px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Top original=46 vs migrado 'lbl_4c_Label5' Top=265 (diff=219px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Left original=294 vs migrado 'lbl_4c_Label5' Left=626 (diff=332px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Top original=68 vs migrado 'lbl_4c_Label4' Top=265 (diff=197px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Left original=317 vs migrado 'lbl_4c_Label4' Left=387 (diff=70px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cancela' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Top original=45 vs migrado 'cmd_4c_BNCancela' Top=9 (diff=36px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Top original=48 vs migrado 'lbl_4c_Label5' Top=265 (diff=217px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Left original=294 vs migrado 'lbl_4c_Label5' Left=626 (diff=332px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Top original=7 vs migrado 'lbl_4c_Label3' Top=190 (diff=183px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Left original=14 vs migrado 'lbl_4c_Label3' Left=252 (diff=238px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Top original=18 vs migrado 'lbl_4c_Label2' Top=265 (diff=247px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Left original=359 vs migrado 'lbl_4c_Label2' Left=527 (diff=168px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Top original=70 vs migrado 'lbl_4c_Label4' Top=265 (diff=195px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Left original=444 vs migrado 'lbl_4c_Label4' Left=387 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Top original=71 vs migrado 'lbl_4c_Label1' Top=265 (diff=194px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Left original=310 vs migrado 'lbl_4c_Label1' Left=249 (diff=61px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Inserir): Top original=97 vs migrado 'lbl_4c_Label1' Top=265 (diff=168px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Inserir): Top original=74 vs migrado 'lbl_4c_Label5' Top=265 (diff=191px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Inserir): Left original=263 vs migrado 'lbl_4c_Label5' Left=626 (diff=363px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Inserir): Top original=50 vs migrado 'lbl_4c_Label3' Top=190 (diff=140px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Inserir): Top original=25 vs migrado 'lbl_4c_Label4' Top=265 (diff=240px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Inserir): Left original=289 vs migrado 'lbl_4c_Label4' Left=387 (diff=98px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cancela' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=831 vs migrado 'cmd_4c_BNCancela' Left=570 (diff=261px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Sair' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=906 vs migrado 'cmd_4c_BNSair' Left=645 (diff=261px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Procurar' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Top original=12 vs migrado 'cnt_4c__Procurar' Top=239 (diff=227px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Procurar' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=163 vs migrado 'cnt_4c__Procurar' Left=17 (diff=146px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Top original=126 vs migrado 'lbl_4c_Label4' Top=265 (diff=139px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=19 vs migrado 'lbl_4c_Label4' Left=387 (diff=368px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Top original=176 vs migrado 'lbl_4c_Label2' Top=265 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=19 vs migrado 'lbl_4c_Label2' Left=527 (diff=508px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Top original=151 vs migrado 'lbl_4c_Label3' Top=190 (diff=39px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=25 vs migrado 'lbl_4c_Label3' Left=252 (diff=227px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Top original=174 vs migrado 'lbl_4c_Label8' Top=290 (diff=116px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=339 vs migrado 'lbl_4c_Label8' Left=521 (diff=182px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Top original=149 vs migrado 'lbl_4c_Label6' Top=290 (diff=141px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=327 vs migrado 'lbl_4c_Label6' Left=230 (diff=97px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Top original=149 vs migrado 'lbl_4c_Label5' Top=265 (diff=116px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=171 vs migrado 'lbl_4c_Label5' Left=626 (diff=455px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Top original=174 vs migrado 'lbl_4c_Label7' Top=290 (diff=116px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=201 vs migrado 'lbl_4c_Label7' Left=387 (diff=186px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1.Cnt_Total): Top original=9 vs migrado 'lbl_4c_Label1' Top=265 (diff=256px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1.Cnt_Total): Left original=49 vs migrado 'lbl_4c_Label1' Left=249 (diff=200px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1.Cnt_Total): Top original=32 vs migrado 'lbl_4c_Label2' Top=265 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1.Cnt_Total): Left original=26 vs migrado 'lbl_4c_Label2' Left=527 (diff=501px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Procurar): Top original=22 vs migrado 'lbl_4c_Label4' Top=265 (diff=243px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Procurar): Left original=27 vs migrado 'lbl_4c_Label4' Left=387 (diff=360px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formint.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4213 linhas total):

*-- Linhas 37 a 176:
37:     *===========================================================================
38:     * Init - Inicializa o formulario
39:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
40:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar!
41:     *===========================================================================
42:     PROCEDURE Init()
43:         RETURN DODEFAULT()
44:     ENDPROC
45: 
46:     *===========================================================================
47:     * InicializarForm - Configura estrutura completa
48:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
49:     *===========================================================================
50:     PROTECTED PROCEDURE InicializarForm()
51:         LOCAL loc_lSucesso
52:         loc_lSucesso = .F.
53: 
54:         TRY
55:             *-- Fix DataSession=2: reseta SET DATE/CENTURY (CLAUDE.md regra 9.4)
56:             SET DATE TO BRITISH
57:             SET CENTURY ON
58: 
59:             *-- Criar BO
60:             THIS.this_oBusinessObject = CREATEOBJECT("intBO")
61: 
62:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
63:                 MostrarErro("Erro ao criar intBO" + CHR(13) + ;
64:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
65:                     "Formint.InicializarForm")
66:             ELSE
67:                 *-- Caption com acento (CHR obrigatorio - CLAUDE.md regra 4)
68:                 THIS.Caption = "Tratamento de Invent" + CHR(225) + "rio"
69: 
70:                 THIS.ConfigurarPageFrame()
71: 
72:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
73:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
74:                 THIS.pgf_4c_Paginas.Visible = .T.
75:                 THIS.pgf_4c_Paginas.ActivePage = 1
76:                 THIS.this_cModoAtual = "LISTA"
77: 
78:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
79:                     THIS.CarregarLista()
80:                 ENDIF
81: 
82:                 loc_lSucesso = .T.
83:             ENDIF
84: 
85:         CATCH TO loException
86:             MostrarErro("Erro ao inicializar Formint:" + CHR(13) + ;
87:                 loException.Message + CHR(13) + ;
88:                 "Linha: " + TRANSFORM(loException.LineNo), ;
89:                 "Formint.InicializarForm")
90:         ENDTRY
91: 
92:         RETURN loc_lSucesso
93:     ENDPROC
94: 
95:     *===========================================================================
96:     * ConfigurarPageFrame - Cria PageFrame com 3 paginas
97:     * PageCount=3: Page1=Lista, Page2=Dados, Page3=Tratamento
98:     * Top=-29 esconde abas; compensar +29 em todos os controles internos
99:     *===========================================================================
100:     PROTECTED PROCEDURE ConfigurarPageFrame()
101:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
102: 
103:         WITH THIS.pgf_4c_Paginas
104:             .PageCount = 3
105:             .Top       = -29
106:             .Left      = 0
107:             .Width     = 1003
108:             .Height    = THIS.Height + 29
109:             .Tabs      = .F.
110:             .Visible   = .T.
111: 
112:             .Page1.Caption   = "Lista"
113:             .Page1.BackColor = RGB(255, 255, 255)
114:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
115: 
116:             .Page2.Caption   = "Dados"
117:             .Page2.BackColor = RGB(255, 255, 255)
118:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
119: 
120:             .Page3.Caption   = "Tratamento"
121:             .Page3.BackColor = RGB(255, 255, 255)
122:             .Page3.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
123:         ENDWITH
124: 
125:         THIS.ConfigurarPaginaLista()
126:         THIS.ConfigurarPaginaDados()
127:         THIS.ConfigurarPaginaTratamento()
128:     ENDPROC
129: 
130:     *===========================================================================
131:     * ConfigurarPaginaLista - Configura Page1 (Lista de inventarios)
132:     * Original: cntSombra.Top=1 -> +29 = 30
133:     *           Grupo_op.Left=543, Top=-1 -> +29 = 28
134:     *           Grupo_Saida.Left=918 -> canonico Left=917
135:     *===========================================================================
136:     PROTECTED PROCEDURE ConfigurarPaginaLista()
137:         LOCAL loc_oPagina
138:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
139: 
140:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
141:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
142: 
143:         *----------------------------------------------------------------------
144:         * Container Cabecalho (cntSombra no legado)
145:         * Original: Top=1, Left=-1, Width=1004, Height=80
146:         * Com compensacao +29: Top=30
147:         *----------------------------------------------------------------------
148:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
149:         WITH loc_oPagina.cnt_4c_Cabecalho
150:             .Top         = 30
151:             .Left        = 0
152:             .Width       = THIS.Width
153:             .Height      = 80
154:             .BackColor   = RGB(100, 100, 100)
155:             .BorderWidth = 0
156:             .Visible     = .T.
157:         ENDWITH
158: 
159:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
160:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
161:             .Caption   = THIS.Caption
162:             .Top       = 15
163:             .Left      = 10
164:             .Width     = 769
165:             .Height    = 40
166:             .FontName  = "Tahoma"
167:             .FontSize  = 16
168:             .FontBold  = .T.
169:             .ForeColor = RGB(0, 0, 0)
170:             .BackStyle = 0
171:             .AutoSize  = .F.
172:             .Visible   = .T.
173:         ENDWITH
174: 
175:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
176:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo

*-- Linhas 227 a 549:
227:             .AutoSize        = .F.
228:             .Visible         = .T.
229:         ENDWITH
230:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Balanco, "Click", THIS, "BtnBalancoClick")
231: 
232:         *-- Botao BaixaAuto (Baixa Automatica por ocorrencia)
233:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_BaixaAuto", "CommandButton")
234:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_BaixaAuto
235:             .Caption         = "Bx.Aut."
236:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
237:             .PicturePosition = 13
238:             .Top             = 5
239:             .Left            = 80
240:             .Width           = 75
241:             .Height          = 75
242:             .FontName        = "Comic Sans MS"
243:             .FontBold        = .T.
244:             .FontItalic      = .T.
245:             .FontSize        = 8
246:             .ForeColor       = RGB(90, 90, 90)
247:             .BackColor       = RGB(255, 255, 255)
248:             .Themes          = .F.
249:             .SpecialEffect   = 0
250:             .MousePointer    = 15
251:             .WordWrap        = .T.
252:             .AutoSize        = .F.
253:             .Visible         = .T.
254:         ENDWITH
255:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_BaixaAuto, "Click", THIS, "BtnBaixaAutoClick")
256: 
257:         *-- Botao Tratamento (Iniciar tratamento de inventario)
258:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Tratamento", "CommandButton")
259:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Tratamento
260:             .Caption         = "Tratar"
261:             .Picture         = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
262:             .PicturePosition = 13
263:             .Top             = 5
264:             .Left            = 155
265:             .Width           = 75
266:             .Height          = 75
267:             .FontName        = "Comic Sans MS"
268:             .FontBold        = .T.
269:             .FontItalic      = .T.
270:             .FontSize        = 8
271:             .ForeColor       = RGB(90, 90, 90)
272:             .BackColor       = RGB(255, 255, 255)
273:             .Themes          = .F.
274:             .SpecialEffect   = 0
275:             .MousePointer    = 15
276:             .WordWrap        = .T.
277:             .AutoSize        = .F.
278:             .Visible         = .T.
279:         ENDWITH
280:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Tratamento, "Click", THIS, "BtnTratamentoClick")
281: 
282:         *-- Botao Fechar (Fechar/Encerrar o inventario - operacao de encerramento)
283:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Fechar", "CommandButton")
284:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Fechar
285:             .Caption         = "Encerrar"
286:             .Picture         = gc_4c_CaminhoIcones + "geral_servicos_60.jpg"
287:             .PicturePosition = 13
288:             .Top             = 5
289:             .Left            = 230
290:             .Width           = 75
291:             .Height          = 75
292:             .FontName        = "Comic Sans MS"
293:             .FontBold        = .T.
294:             .FontItalic      = .T.
295:             .FontSize        = 8
296:             .ForeColor       = RGB(90, 90, 90)
297:             .BackColor       = RGB(255, 255, 255)
298:             .Themes          = .F.
299:             .SpecialEffect   = 0
300:             .MousePointer    = 15
301:             .WordWrap        = .T.
302:             .AutoSize        = .F.
303:             .Visible         = .T.
304:         ENDWITH
305:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Fechar, "Click", THIS, "BtnFecharClick")
306: 
307:         *-- Botao Procurar (Navega para Page2 para entrada de filtros)
308:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Procurar", "CommandButton")
309:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Procurar
310:             .Caption         = "Procurar"
311:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
312:             .PicturePosition = 13
313:             .Top             = 5
314:             .Left            = 305
315:             .Width           = 75
316:             .Height          = 75
317:             .FontName        = "Comic Sans MS"
318:             .FontBold        = .T.
319:             .FontItalic      = .T.
320:             .FontSize        = 8
321:             .ForeColor       = RGB(90, 90, 90)
322:             .BackColor       = RGB(255, 255, 255)
323:             .Themes          = .F.
324:             .SpecialEffect   = 0
325:             .MousePointer    = 15
326:             .WordWrap        = .T.
327:             .AutoSize        = .F.
328:             .Visible         = .T.
329:         ENDWITH
330:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Procurar, "Click", THIS, "BtnProcurarClick")
331: 
332:         *----------------------------------------------------------------------
333:         * Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
334:         * Left=917, Width=90, Height=85 - prevalece sobre original (Left=918)
335:         * Top=29 canonico; BackStyle=0 (transparente)
336:         *----------------------------------------------------------------------
337:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
338:         WITH loc_oPagina.cnt_4c_Saida
339:             .Top         = 29
340:             .Left        = 917
341:             .Width       = 90
342:             .Height      = 85
343:             .BackStyle   = 0
344:             .BorderWidth = 0
345:             .Visible     = .T.
346:         ENDWITH
347: 
348:         *-- Botao Encerrar (canonico CLAUDE.md)
349:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
350:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
351:             .Caption         = "Encerrar"
352:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
353:             .PicturePosition = 13
354:             .Top             = 5
355:             .Left            = 5
356:             .Width           = 75
357:             .Height          = 75
358:             .FontName        = "Comic Sans MS"
359:             .FontBold        = .T.
360:             .FontItalic      = .T.
361:             .FontSize        = 8
362:             .ForeColor       = RGB(90, 90, 90)
363:             .BackColor       = RGB(255, 255, 255)
364:             .Themes          = .F.
365:             .SpecialEffect   = 0
366:             .MousePointer    = 15
367:             .WordWrap        = .T.
368:             .AutoSize        = .F.
369:             .Visible         = .T.
370:         ENDWITH
371:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
372: 
373:         *----------------------------------------------------------------------
374:         * Botoes de cabecalho de coluna (sort/foco no grid)
375:         * Top=124+29=153; Height=20 (visual de header de coluna)
376:         * Posicoes e larguras do layout.json
377:         *----------------------------------------------------------------------
378:         loc_oPagina.AddObject("cmd_4c_Processo", "CommandButton")
379:         WITH loc_oPagina.cmd_4c_Processo
380:             .Caption       = "Processo"
381:             .Top           = 153
382:             .Left          = 12
383:             .Width         = 62
384:             .Height        = 20
385:             .FontName      = "Tahoma"
386:             .FontSize      = 8
387:             .FontBold      = .T.
388:             .ForeColor     = RGB(0, 0, 0)
389:             .BackColor     = RGB(192, 192, 192)
390:             .SpecialEffect = 1
391:             .Themes        = .F.
392:             .MousePointer  = 15
393:             .Visible       = .T.
394:         ENDWITH
395:         BINDEVENT(loc_oPagina.cmd_4c_Processo, "Click", THIS, "CmdProcessoClick")
396: 
397:         loc_oPagina.AddObject("cmd_4c_Periodo", "CommandButton")
398:         WITH loc_oPagina.cmd_4c_Periodo
399:             .Caption       = "Per" + CHR(237) + "odo"
400:             .Top           = 153
401:             .Left          = 73
402:             .Width         = 153
403:             .Height        = 20
404:             .FontName      = "Tahoma"
405:             .FontSize      = 8
406:             .FontBold      = .T.
407:             .ForeColor     = RGB(0, 0, 0)
408:             .BackColor     = RGB(192, 192, 192)
409:             .SpecialEffect = 1
410:             .Themes        = .F.
411:             .MousePointer  = 15
412:             .Visible       = .T.
413:         ENDWITH
414:         BINDEVENT(loc_oPagina.cmd_4c_Periodo, "Click", THIS, "CmdPeriodoClick")
415: 
416:         loc_oPagina.AddObject("cmd_4c_Estoque", "CommandButton")
417:         WITH loc_oPagina.cmd_4c_Estoque
418:             .Caption       = "Estoque"
419:             .Top           = 153
420:             .Left          = 225
421:             .Width         = 143
422:             .Height        = 20
423:             .FontName      = "Tahoma"
424:             .FontSize      = 8
425:             .FontBold      = .T.
426:             .ForeColor     = RGB(0, 0, 0)
427:             .BackColor     = RGB(192, 192, 192)
428:             .SpecialEffect = 1
429:             .Themes        = .F.
430:             .MousePointer  = 15
431:             .Visible       = .T.
432:         ENDWITH
433:         BINDEVENT(loc_oPagina.cmd_4c_Estoque, "Click", THIS, "CmdEstoqueClick")
434: 
435:         loc_oPagina.AddObject("cmd_4c_Local", "CommandButton")
436:         WITH loc_oPagina.cmd_4c_Local
437:             .Caption       = "Local"
438:             .Top           = 153
439:             .Left          = 367
440:             .Width         = 163
441:             .Height        = 20
442:             .FontName      = "Tahoma"
443:             .FontSize      = 8
444:             .FontBold      = .T.
445:             .ForeColor     = RGB(0, 0, 0)
446:             .BackColor     = RGB(192, 192, 192)
447:             .SpecialEffect = 1
448:             .Themes        = .F.
449:             .MousePointer  = 15
450:             .Visible       = .T.
451:         ENDWITH
452:         BINDEVENT(loc_oPagina.cmd_4c_Local, "Click", THIS, "CmdLocalClick")
453: 
454:         loc_oPagina.AddObject("cmd_4c_Grupo", "CommandButton")
455:         WITH loc_oPagina.cmd_4c_Grupo
456:             .Caption       = "Grupo"
457:             .Top           = 153
458:             .Left          = 529
459:             .Width         = 69
460:             .Height        = 20
461:             .FontName      = "Tahoma"
462:             .FontSize      = 8
463:             .FontBold      = .T.
464:             .ForeColor     = RGB(0, 0, 0)
465:             .BackColor     = RGB(192, 192, 192)
466:             .SpecialEffect = 1
467:             .Themes        = .F.
468:             .MousePointer  = 15
469:             .Visible       = .T.
470:         ENDWITH
471:         BINDEVENT(loc_oPagina.cmd_4c_Grupo, "Click", THIS, "CmdGrupoClick")
472: 
473:         loc_oPagina.AddObject("cmd_4c_GGrupo", "CommandButton")
474:         WITH loc_oPagina.cmd_4c_GGrupo
475:             .Caption       = "GGrupo"
476:             .Top           = 153
477:             .Left          = 597
478:             .Width         = 69
479:             .Height        = 20
480:             .FontName      = "Tahoma"
481:             .FontSize      = 8
482:             .FontBold      = .T.
483:             .ForeColor     = RGB(0, 0, 0)
484:             .BackColor     = RGB(192, 192, 192)
485:             .SpecialEffect = 1
486:             .Themes        = .F.
487:             .MousePointer  = 15
488:             .Visible       = .T.
489:         ENDWITH
490:         BINDEVENT(loc_oPagina.cmd_4c_GGrupo, "Click", THIS, "CmdGGrupoClick")
491: 
492:         loc_oPagina.AddObject("cmd_4c_Usuario", "CommandButton")
493:         WITH loc_oPagina.cmd_4c_Usuario
494:             .Caption       = "Usu" + CHR(225) + "rio"
495:             .Top           = 153
496:             .Left          = 665
497:             .Width         = 78
498:             .Height        = 20
499:             .FontName      = "Tahoma"
500:             .FontSize      = 8
501:             .FontBold      = .T.
502:             .ForeColor     = RGB(0, 0, 0)
503:             .BackColor     = RGB(192, 192, 192)
504:             .SpecialEffect = 1
505:             .Themes        = .F.
506:             .MousePointer  = 15
507:             .Visible       = .T.
508:         ENDWITH
509:         BINDEVENT(loc_oPagina.cmd_4c_Usuario, "Click", THIS, "CmdUsuarioClick")
510: 
511:         *----------------------------------------------------------------------
512:         * Grid principal de inventarios
513:         * Original: Top=145, Left=12, Width=934, Height=446
514:         * Compensacao +29: Top=174
515:         * Width=905 (12+905=917=cnt_4c_Saida.Left - sem sobreposicao)
516:         * HeaderHeight=0: botoes acima servem como cabecalhos visuais
517:         * ColumnCount FORA do WITH (Problem 36)
518:         * ControlSource/DynamicBackColor: vinculados em CarregarLista() (Problem 32)
519:         * Colunas: codigos/datainis/datafims/contas/localis/localfs/grupos/cggruis/usuars/encerras
520:         * Larguras: 62+78+75+143+81+82+69+69+78+168 = 905
521:         *----------------------------------------------------------------------
522:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
523:         loc_oPagina.grd_4c_Dados.ColumnCount = 10
524:         WITH loc_oPagina.grd_4c_Dados
525:             .Top           = 174
526:             .Left          = 12
527:             .Width         = 905
528:             .Height        = 446
529:             .RecordSource  = ""
530:             .ReadOnly      = .T.
531:             .DeleteMark    = .F.
532:             .RecordMark    = .F.
533:             .GridLines     = 1
534:             .GridLineWidth = 1
535:             .GridLineColor = RGB(200, 200, 200)
536:             .HeaderHeight  = 0
537:             .RowHeight     = 20
538:             .FontName      = "Tahoma"
539:             .FontSize      = 9
540:             .ScrollBars    = 2
541:             .Visible       = .T.
542:             WITH .Column1
543:                 .Width     = 62
544:                 .Resizable = .F.
545:                 .Alignment = 0
546:             ENDWITH
547:             WITH .Column2
548:                 .Width     = 78
549:                 .Resizable = .F.

*-- Linhas 590 a 713:
590:                 .Alignment = 0
591:             ENDWITH
592:         ENDWITH
593:         BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
594: 
595:         THIS.TornarControlesVisiveis(loc_oPagina)
596:     ENDPROC
597: 
598:     *===========================================================================
599:     * ConfigurarPaginaDados - Configura Page2 (Filtros para selecao do inventario)
600:     * Original: Grupo_Salva.Left=821, Top=10, Width=160, Height=85
601:     * Com compensacao +29: Top=39
602:     *===========================================================================
603:     PROTECTED PROCEDURE ConfigurarPaginaDados()
604:         LOCAL loc_oPagina
605:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
606: 
607:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
608:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
609: 
610:         *----------------------------------------------------------------------
611:         * Container Botoes Acao (Grupo_Salva no legado: Salva + Cancelar)
612:         * Original: Left=821, Top=10, Width=160, Height=85 -> Top=10+29=39
613:         *----------------------------------------------------------------------
614:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
615:         WITH loc_oPagina.cnt_4c_BotoesAcao
616:             .Top         = 39
617:             .Left        = 821
618:             .Width       = 160
619:             .Height      = 85
620:             .BackStyle   = 0
621:             .BorderWidth = 0
622:             .Visible     = .T.
623:         ENDWITH
624: 
625:         *-- Botao Confirmar (Salva no legado: Left=5, Top=5)
626:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
627:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
628:             .Caption         = "Confirmar"
629:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
630:             .PicturePosition = 13
631:             .Top             = 5
632:             .Left            = 5
633:             .Width           = 75
634:             .Height          = 75
635:             .FontName        = "Comic Sans MS"
636:             .FontBold        = .T.
637:             .FontItalic      = .T.
638:             .FontSize        = 8
639:             .ForeColor       = RGB(90, 90, 90)
640:             .BackColor       = RGB(255, 255, 255)
641:             .Themes          = .F.
642:             .SpecialEffect   = 0
643:             .MousePointer    = 15
644:             .WordWrap        = .T.
645:             .AutoSize        = .F.
646:             .Visible         = .T.
647:         ENDWITH
648:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
649: 
650:         *-- Botao Cancelar (Left=80, Top=5)
651:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
652:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
653:             .Caption         = "Encerrar"
654:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
655:             .PicturePosition = 13
656:             .Top             = 5
657:             .Left            = 80
658:             .Width           = 75
659:             .Height          = 75
660:             .FontName        = "Comic Sans MS"
661:             .FontBold        = .T.
662:             .FontItalic      = .T.
663:             .FontSize        = 8
664:             .ForeColor       = RGB(90, 90, 90)
665:             .BackColor       = RGB(255, 255, 255)
666:             .Themes          = .F.
667:             .SpecialEffect   = 0
668:             .MousePointer    = 15
669:             .WordWrap        = .T.
670:             .AutoSize        = .F.
671:             .Visible         = .T.
672:         ENDWITH
673:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
674: 
675:         *----------------------------------------------------------------------
676:         * FASE 5/8 - CAMPOS PRINCIPAIS PARTE 1
677:         * Primeira metade dos campos da Page2 (filtros/dados do inventario)
678:         * Compensacao +29 aplicada em todos os Top (PageFrame.Top = -29)
679:         *
680:         * Campos leitura-only: BackColor cinza (230,230,230) + ReadOnly=.T.
681:         * Apenas txt_4c_Codigo eh editavel (para busca por codigo)
682:         *----------------------------------------------------------------------
683: 
684:         *-- txt_4c_Codigo (Get_Codigo: Top=157, Left=303, Width=44 -> +29=186)
685:         *-- Editavel SOMENTE ao procurar (unico campo de entrada na Page2)
686:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
687:         WITH loc_oPagina.txt_4c_Codigo
688:             .Value       = ""
689:             .Top         = 186
690:             .Left        = 303
691:             .Width       = 44
692:             .Height      = 23
693:             .FontName    = "Tahoma"
694:             .FontSize    = 8
695:             .BackColor   = RGB(255, 255, 255)
696:             .ForeColor   = RGB(0, 0, 0)
697:             .BorderStyle = 1
698:             .Visible     = .T.
699:         ENDWITH
700: 
701:         *-- lbl_4c_Label3 (Say3 "Codigo": Top=161, Left=252, Width=42 -> +29=190)
702:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
703:         WITH loc_oPagina.lbl_4c_Label3
704:             .Caption   = "C" + CHR(243) + "digo :"
705:             .Top       = 190
706:             .Left      = 252
707:             .Width     = 42
708:             .Height    = 17
709:             .FontName  = "Tahoma"
710:             .FontSize  = 8
711:             .BackStyle = 0
712:             .ForeColor = RGB(90, 90, 90)
713:             .Visible   = .T.

*-- Linhas 1016 a 1038:
1016:             .BackStyle = 0
1017:             .ForeColor = RGB(90, 90, 90)
1018:             .Visible   = .T.
1019:         ENDWITH
1020: 
1021:         *-- txt_4c_GrupoInicial (Get_GrupoInicial: Top=257, Left=569, Width=34 -> +29=286)
1022:         loc_oPagina.AddObject("txt_4c_GrupoInicial", "TextBox")
1023:         WITH loc_oPagina.txt_4c_GrupoInicial
1024:             .Value       = ""
1025:             .ReadOnly    = .T.
1026:             .Top         = 286
1027:             .Left        = 569
1028:             .Width       = 34
1029:             .Height      = 23
1030:             .FontName    = "Tahoma"
1031:             .FontSize    = 8
1032:             .BackColor   = RGB(230, 230, 230)
1033:             .ForeColor   = RGB(0, 0, 0)
1034:             .BorderStyle = 1
1035:             .Visible     = .T.
1036:         ENDWITH
1037: 
1038:         *-- txt_4c_GrupoFinal (Get_GrupoFinal: Top=257, Left=646, Width=34 -> +29=286)

*-- Linhas 1210 a 1260:
1210:             .Visible   = .T.
1211:         ENDWITH
1212: 
1213:         THIS.TornarControlesVisiveis(loc_oPagina)
1214:     ENDPROC
1215: 
1216:     *===========================================================================
1217:     * ConfigurarPaginaTratamento - Configura Page3 (Grade de tratamento de itens)
1218:     * Fase 6: implementacao completa com todos os containers flutuantes e grid
1219:     *===========================================================================
1220:     PROTECTED PROCEDURE ConfigurarPaginaTratamento()
1221:         LOCAL loc_oPagina, loc_oCnt, loc_oGrid
1222:         loc_oPagina = THIS.pgf_4c_Paginas.Page3
1223: 
1224:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
1225:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
1226: 
1227:         *==========================================================================
1228:         *-- cnt_4c__CCusto1 (painel superior de controles): Top=0+29=29
1229:         *-- Fica visivel apos selecionar linha no grid (GrdBalancoAfterRowColChange)
1230:         *==========================================================================
1231:         loc_oPagina.AddObject("cnt_4c__CCusto1", "Container")
1232:         WITH loc_oPagina.cnt_4c__CCusto1
1233:             .Top        = 29
1234:             .Left       = 0
1235:             .Width      = 1000
1236:             .Height     = 197
1237:             .Visible    = .F.
1238:             .BackColor  = RGB(240, 240, 240)
1239:             .BorderWidth = 1
1240:         ENDWITH
1241: 
1242:         loc_oCnt = loc_oPagina.cnt_4c__CCusto1
1243: 
1244:         *-- Botoes do painel superior
1245:         loc_oCnt.AddObject("cmd_4c_Sobra", "CommandButton")
1246:         WITH loc_oCnt.cmd_4c_Sobra
1247:             .Top = 12
1248:             .Left = 12
1249:             .Width = 75
1250:             .Height = 75
1251:             .Caption = "\<Sobra"
1252:             .FontName = "Tahoma"
1253:             .FontSize = 9
1254:             .Visible = .T.
1255:         ENDWITH
1256: 
1257:         loc_oCnt.AddObject("chk_4c_RepeteObs", "CheckBox")
1258:         WITH loc_oCnt.chk_4c_RepeteObs
1259:             .Top = 12
1260:             .Left = 88

*-- Linhas 1598 a 1647:
1598:             .Visible = .T.
1599:         ENDWITH
1600: 
1601:         *-- BINDEVENTS cnt_4c__CCusto1
1602:         BINDEVENT(loc_oCnt.cmd_4c_Sobra,      "Click",     THIS, "BtnSobraClick")
1603:         BINDEVENT(loc_oCnt.cmd_4c_Procurar,   "Click",     THIS, "BtnProcurarCntClick")
1604:         BINDEVENT(loc_oCnt.cmd_4c_BarraNovo,  "Click",     THIS, "BtnBarraNovoCntClick")
1605:         BINDEVENT(loc_oCnt.cmd_4c_CancelaCnt, "Click",     THIS, "BtnCancelaCntClick")
1606:         BINDEVENT(loc_oCnt.cmd_4c_SairCnt,    "Click",     THIS, "BtnSairCntClick")
1607:         BINDEVENT(loc_oCnt.txt_4c_DPro,       "KeyPress", THIS, "GetDProLostFocus")
1608: 
1609:         *==========================================================================
1610:         *-- grd_4c_Dados (GrdBalanco): Top=210+29=239, Left=17, W=972, H=364
1611:         *-- RecordSource definido fora do WITH (evita "Unknown member COLUMN1")
1612:         *==========================================================================
1613:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
1614:         loc_oGrid = loc_oPagina.grd_4c_Dados
1615:         loc_oGrid.RecordSource = ""
1616:         loc_oGrid.ColumnCount  = 10
1617: 
1618:         WITH loc_oGrid
1619:             .Top         = 239
1620:             .Left        = 17
1621:             .Width       = 972
1622:             .Height      = 364
1623:             .Visible     = .F.
1624:             .ReadOnly    = .F.
1625:             .FontName    = "Tahoma"
1626:             .FontSize    = 9
1627:             .GridLines   = 1
1628:             .DeleteMark  = .F.
1629:             .RecordMark  = .F.
1630:             .HeaderHeight = 21
1631:             .RowHeight    = 20
1632:         ENDWITH
1633: 
1634:         WITH loc_oGrid.Column1
1635:             .Width = 120
1636:             .ReadOnly = .T.
1637:             .Header1.Caption = "Produto"
1638:         ENDWITH
1639:         WITH loc_oGrid.Column2
1640:             .Width = 80 
1641:             .ReadOnly = .T.
1642:             .Header1.Caption = "Data"
1643:         ENDWITH
1644:         WITH loc_oGrid.Column3
1645:             .Width = 100
1646:             .ReadOnly = .T.
1647:             .Header1.Caption = "Barra"

*-- Linhas 1683 a 1729:
1683:             .Header1.Caption = "Dif.Peso"
1684:         ENDWITH
1685: 
1686:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdBalancoAfterRowColChange")
1687:         BINDEVENT(loc_oGrid.Column8.Text1, "When",      THIS, "GrdColOcorWhen")
1688:         BINDEVENT(loc_oGrid.Column8.Text1, "Valid",     THIS, "GrdColOcorValid")
1689:         BINDEVENT(loc_oGrid.Column8.Text1, "KeyPress", THIS, "GrdColOcorLostFocus")
1690: 
1691:         *==========================================================================
1692:         *-- cnt_4c__Custo2 (painel Novo Barra): Top=210+29=239
1693:         *==========================================================================
1694:         loc_oPagina.AddObject("cnt_4c__Custo2", "Container")
1695:         WITH loc_oPagina.cnt_4c__Custo2
1696:             .Top = 239
1697:             .Left = 17
1698:             .Width = 972
1699:             .Height = 364
1700:             .Visible = .F.
1701:             .BackColor = RGB(240, 240, 240)
1702:             .BorderWidth = 1
1703:         ENDWITH
1704: 
1705:         loc_oCnt = loc_oPagina.cnt_4c__Custo2
1706: 
1707:         loc_oCnt.AddObject("lbl_4c_BNlbl4", "Label")
1708:         WITH loc_oCnt.lbl_4c_BNlbl4
1709:             .Caption = "Barra Novo :"
1710:             .Top = 18
1711:             .Left = 270
1712:             .Width = 63
1713:             .Height = 15
1714:             .FontName = "Tahoma"
1715:             .FontSize = 8
1716:             .BackStyle = 0
1717:             .Visible = .T.
1718:         ENDWITH
1719:         loc_oCnt.AddObject("lbl_4c_BNlbl3", "Label")
1720:         WITH loc_oCnt.lbl_4c_BNlbl3
1721:             .Caption = "Centro de Custo :"
1722:             .Top = 43
1723:             .Left = 245
1724:             .Width = 88
1725:             .Height = 15
1726:             .FontName = "Tahoma"
1727:             .FontSize = 8
1728:             .BackStyle = 0
1729:             .Visible = .T.

*-- Linhas 1822 a 1892:
1822:             .Height = 101
1823:             .FontName = "Tahoma"
1824:             .FontSize = 8
1825:             .Visible = .T.
1826:         ENDWITH
1827:         loc_oCnt.AddObject("cmd_4c_BNCancela", "CommandButton")
1828:         WITH loc_oCnt.cmd_4c_BNCancela
1829:             .Top = 9
1830:             .Left = 570
1831:             .Width = 75
1832:             .Height = 75
1833:             .Caption = "Cancelar"
1834:             .FontName = "Tahoma"
1835:             .FontSize = 9
1836:             .Visible = .T.
1837:         ENDWITH
1838:         loc_oCnt.AddObject("cmd_4c_BNSair", "CommandButton")
1839:         WITH loc_oCnt.cmd_4c_BNSair
1840:             .Top = 9
1841:             .Left = 645
1842:             .Width = 75
1843:             .Height = 75
1844:             .Caption = "OK"
1845:             .FontName = "Tahoma"
1846:             .FontSize = 9
1847:             .Visible = .T.
1848:         ENDWITH
1849: 
1850:         BINDEVENT(loc_oCnt.txt_4c_GetJustif, "LostFocus", THIS, "GetJustifValid")
1851:         BINDEVENT(loc_oCnt.cmd_4c_BNCancela, "Click", THIS, "BtnBNCancelaClick")
1852:         BINDEVENT(loc_oCnt.cmd_4c_BNSair,    "Click", THIS, "BtnBNSairClick")
1853: 
1854:         *==========================================================================
1855:         *-- cnt_4c_TratOcor (Tratamento por Ocorrencia): Top=210+29=239
1856:         *==========================================================================
1857:         loc_oPagina.AddObject("cnt_4c_TratOcor", "Container")
1858:         WITH loc_oPagina.cnt_4c_TratOcor
1859:             .Top = 239
1860:             .Left = 17
1861:             .Width = 972
1862:             .Height = 364
1863:             .Visible = .F.
1864:             .BackColor = RGB(240, 240, 240)
1865:             .BorderWidth = 1
1866:         ENDWITH
1867: 
1868:         loc_oCnt = loc_oPagina.cnt_4c_TratOcor
1869: 
1870:         loc_oCnt.AddObject("lbl_4c_TOlbl3", "Label")
1871:         WITH loc_oCnt.lbl_4c_TOlbl3
1872:             .Caption = "Tratamento Por Ocorr" + CHR(234) + "ncia"
1873:             .Top = 7
1874:             .Left = 16
1875:             .Width = 200
1876:             .Height = 17
1877:             .FontName = "Tahoma"
1878:             .FontSize = 10
1879:             .FontBold = .T.
1880:             .BackStyle = 0
1881:             .Visible = .T.
1882:         ENDWITH
1883:         loc_oCnt.AddObject("lbl_4c_TOlbl5", "Label")
1884:         WITH loc_oCnt.lbl_4c_TOlbl5
1885:             .Caption = "Tipo Ocorr" + CHR(234) + "ncia :"
1886:             .Top = 46
1887:             .Left = 294
1888:             .Width = 84
1889:             .Height = 15
1890:             .FontName = "Tahoma"
1891:             .FontSize = 8
1892:             .BackStyle = 0

*-- Linhas 1941 a 1984:
1941:             .Visible = .T.
1942:         ENDWITH
1943: 
1944:         loc_oCnt.AddObject("opt_4c_SemOcor", "OptionGroup")
1945:         WITH loc_oCnt.opt_4c_SemOcor
1946:             .Top = 66
1947:             .Left = 379
1948:             .Width = 114
1949:             .Height = 49
1950:             .ButtonCount = 3
1951:             .Value = 1
1952:             .BackStyle = 0
1953:             .Visible = .T.
1954:         ENDWITH
1955:         WITH loc_oCnt.opt_4c_SemOcor
1956:             .Buttons(1).Caption = "Lidos"
1957:             .Buttons(1).Top = 0
1958:             .Buttons(1).Left = 0
1959:             .Buttons(1).Width = 55
1960:             .Buttons(1).Height = 17
1961:             .Buttons(2).Caption = "N" + CHR(227) + "o Lidos"
1962:             .Buttons(2).Top = 16
1963:             .Buttons(2).Left = 0
1964:             .Buttons(2).Width = 55
1965:             .Buttons(2).Height = 17
1966:             .Buttons(3).Caption = "Saldos"
1967:             .Buttons(3).Top = 32
1968:             .Buttons(3).Left = 0
1969:             .Buttons(3).Width = 55
1970:             .Buttons(3).Height = 17
1971:         ENDWITH
1972: 
1973:         loc_oCnt.AddObject("cmb_4c_Tipos", "ComboBox")
1974:         WITH loc_oCnt.cmb_4c_Tipos
1975:             .Top = 118
1976:             .Left = 383
1977:             .Width = 115
1978:             .Height = 24
1979:             .Style = 2
1980:             .FontName = "Tahoma"
1981:             .FontSize = 8
1982:             .Visible = .T.
1983:         ENDWITH
1984:         loc_oCnt.cmb_4c_Tipos.AddItem("Entrada")

*-- Linhas 2024 a 2069:
2024:             .Visible = .T.
2025:         ENDWITH
2026: 
2027:         BINDEVENT(loc_oCnt.txt_4c_TOcor,       "LostFocus", THIS, "GetTOcorCntTratValid")
2028:         BINDEVENT(loc_oCnt.cmd_4c_BtnTratOcor, "Click", THIS, "BtnTratOcorClick")
2029:         BINDEVENT(loc_oCnt.cmd_4c_TOCancela,   "Click", THIS, "BtnTOCancelaClick")
2030: 
2031:         *==========================================================================
2032:         *-- cnt_4c_BaixaAuto (Baixa Automatica por Ocorrencia): Top=210+29=239
2033:         *==========================================================================
2034:         loc_oPagina.AddObject("cnt_4c_BaixaAuto", "Container")
2035:         WITH loc_oPagina.cnt_4c_BaixaAuto
2036:             .Top = 239
2037:             .Left = 17
2038:             .Width = 972
2039:             .Height = 364
2040:             .Visible = .F.
2041:             .BackColor = RGB(240, 240, 240)
2042:             .BorderWidth = 1
2043:         ENDWITH
2044: 
2045:         loc_oCnt = loc_oPagina.cnt_4c_BaixaAuto
2046: 
2047:         loc_oCnt.AddObject("lbl_4c_BAlbl3", "Label")
2048:         WITH loc_oCnt.lbl_4c_BAlbl3
2049:             .Caption = "Baixa Autom" + CHR(225) + "tica por Ocorr" + CHR(234) + "ncia"
2050:             .Top = 7
2051:             .Left = 14
2052:             .Width = 250
2053:             .Height = 17
2054:             .FontName = "Tahoma"
2055:             .FontSize = 10
2056:             .FontBold = .T.
2057:             .BackStyle = 0
2058:             .Visible = .T.
2059:         ENDWITH
2060:         loc_oCnt.AddObject("lbl_4c_BAlbl5", "Label")
2061:         WITH loc_oCnt.lbl_4c_BAlbl5
2062:             .Caption = "Ocorr" + CHR(234) + "ncia :"
2063:             .Top = 48
2064:             .Left = 294
2065:             .Width = 61
2066:             .Height = 15
2067:             .FontName = "Tahoma"
2068:             .FontSize = 8
2069:             .BackStyle = 0

*-- Linhas 2152 a 2197:
2152:             .Visible = .T.
2153:         ENDWITH
2154: 
2155:         BINDEVENT(loc_oCnt.txt_4c_BATOcor,    "LostFocus", THIS, "GetTOcorBaixaAutoValid")
2156:         BINDEVENT(loc_oCnt.cmd_4c_OkBaixaAuto,"Click", THIS, "OkBaixaAutoClick")
2157:         BINDEVENT(loc_oCnt.cmd_4c_BACancela,  "Click", THIS, "BtnBACancelaClick")
2158: 
2159:         *==========================================================================
2160:         *-- cnt_4c__Inserir (painel Inserir item de sobra): Top=210+29=239
2161:         *==========================================================================
2162:         loc_oPagina.AddObject("cnt_4c__Inserir", "Container")
2163:         WITH loc_oPagina.cnt_4c__Inserir
2164:             .Top = 239
2165:             .Left = 17
2166:             .Width = 972
2167:             .Height = 364
2168:             .Visible = .F.
2169:             .BackColor = RGB(240, 240, 240)
2170:             .BorderWidth = 1
2171:         ENDWITH
2172: 
2173:         loc_oCnt = loc_oPagina.cnt_4c__Inserir
2174: 
2175:         loc_oCnt.AddObject("lbl_4c_IBlbl4", "Label")
2176:         WITH loc_oCnt.lbl_4c_IBlbl4
2177:             .Caption = "Barra :"
2178:             .Top = 25
2179:             .Left = 289
2180:             .Width = 35
2181:             .Height = 15
2182:             .FontName = "Tahoma"
2183:             .FontSize = 8
2184:             .BackStyle = 0
2185:             .Visible = .T.
2186:         ENDWITH
2187:         loc_oCnt.AddObject("lbl_4c_IBlbl3", "Label")
2188:         WITH loc_oCnt.lbl_4c_IBlbl3
2189:             .Caption = "C. Custo :"
2190:             .Top = 50
2191:             .Left = 273
2192:             .Width = 51
2193:             .Height = 15
2194:             .FontName = "Tahoma"
2195:             .FontSize = 8
2196:             .BackStyle = 0
2197:             .Visible = .T.

*-- Linhas 2291 a 2388:
2291:             .Visible = .T.
2292:         ENDWITH
2293: 
2294:         BINDEVENT(loc_oCnt.txt_4c_IBarra,     "LostFocus", THIS, "GetIBarraValid")
2295:         BINDEVENT(loc_oCnt.txt_4c_IOcor,      "LostFocus", THIS, "GetIOcorValid")
2296:         BINDEVENT(loc_oCnt.cmd_4c_CntInsere,  "Click", THIS, "CntInsereClick")
2297:         BINDEVENT(loc_oCnt.cmd_4c_CntSairIns, "Click", THIS, "CntSairInsClick")
2298: 
2299:         *==========================================================================
2300:         *-- cnt_4c__Procurar (painel Procurar por Barra): Top=210+29=239
2301:         *==========================================================================
2302:         loc_oPagina.AddObject("cnt_4c__Procurar", "Container")
2303:         WITH loc_oPagina.cnt_4c__Procurar
2304:             .Top = 239
2305:             .Left = 17
2306:             .Width = 972
2307:             .Height = 364
2308:             .Visible = .F.
2309:             .BackColor = RGB(240, 240, 240)
2310:             .BorderWidth = 1
2311:         ENDWITH
2312: 
2313:         loc_oCnt = loc_oPagina.cnt_4c__Procurar
2314: 
2315:         loc_oCnt.AddObject("lbl_4c_PrBarra", "Label")
2316:         WITH loc_oCnt.lbl_4c_PrBarra
2317:             .Caption = "Barra :"
2318:             .Top = 22
2319:             .Left = 27
2320:             .Width = 35
2321:             .Height = 15
2322:             .FontName = "Tahoma"
2323:             .FontSize = 8
2324:             .BackStyle = 0
2325:             .Visible = .T.
2326:         ENDWITH
2327:         loc_oCnt.AddObject("txt_4c_GetBusca", "TextBox")
2328:         WITH loc_oCnt.txt_4c_GetBusca
2329:             .Value = ""
2330:             .Top = 18
2331:             .Left = 71
2332:             .Width = 108
2333:             .Height = 23
2334:             .FontName = "Tahoma"
2335:             .FontSize = 8
2336:             .Visible = .T.
2337:         ENDWITH
2338: 
2339:         BINDEVENT(loc_oCnt.txt_4c_GetBusca, "KeyPress", THIS, "GetBuscaValid")
2340: 
2341:         THIS.TornarControlesVisiveis(loc_oPagina)
2342:     ENDPROC
2343: 
2344:     *===========================================================================
2345:     * CarregarLista - Carrega lista de inventarios da empresa atual
2346:     * Fase 3: chama BO.Buscar() sem ainda vincular ao grid (Fase 4)
2347:     *===========================================================================
2348:     PROCEDURE CarregarLista()
2349:         LOCAL loc_lResultado
2350:         loc_lResultado = .F.
2351: 
2352:         TRY
2353:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2354:                 loc_lResultado = .T.
2355:             ELSE
2356:                 IF !THIS.this_oBusinessObject.Buscar("")
2357:                     MostrarErro("Erro ao carregar invent" + CHR(225) + "rios", ;
2358:                         "Formint.CarregarLista")
2359:                 ELSE
2360:                     LOCAL loc_oGrid
2361:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
2362:                     *-- Vincular cursor ao grid (Problem 32: ControlSource apos RecordSource)
2363:                     loc_oGrid.ColumnCount = 10
2364:                     loc_oGrid.RecordSource           = "cursor_4c_Dados"
2365:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.codigos"
2366:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.datainis"
2367:                     loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.datafims"
2368:                     loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.contas"
2369:                     loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.localis"
2370:                     loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.localfs"
2371:                     loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.grupos"
2372:                     loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.cggruis"
2373:                     loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.usuars"
2374:                     loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.encerras"
2375:                     *-- Problem 6/32: Headers DEVEM ser redefinidos apos RecordSource
2376:                     loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
2377:                     loc_oGrid.Column2.Header1.Caption  = "Inicial"
2378:                     loc_oGrid.Column3.Header1.Caption  = "Final"
2379:                     loc_oGrid.Column4.Header1.Caption  = "Conta"
2380:                     loc_oGrid.Column5.Header1.Caption  = "Local Ini."
2381:                     loc_oGrid.Column6.Header1.Caption  = "Local Fin."
2382:                     loc_oGrid.Column7.Header1.Caption  = "Grupo"
2383:                     loc_oGrid.Column8.Header1.Caption  = "Gde.Grupo"
2384:                     loc_oGrid.Column9.Header1.Caption  = "Usu" + CHR(225) + "rio"
2385:                     loc_oGrid.Column10.Header1.Caption = "Encerrado"
2386:                     *-- Larguras aproximadas do original
2387:                     loc_oGrid.Column1.Width  = 60
2388:                     loc_oGrid.Column2.Width  = 75

*-- Linhas 2417 a 2765:
2417:     *===========================================================================
2418:     * BtnEncerrarClick - Fecha o formulario
2419:     *===========================================================================
2420:     PROCEDURE BtnEncerrarClick()
2421:         THIS.Release()
2422:     ENDPROC
2423: 
2424:     *===========================================================================
2425:     * BtnConfirmarClick - Executa acao conforme modo atual:
2426:     *   INCLUIR/ALTERAR: salva SigCdBal via BO.Salvar() e retorna para lista
2427:     *   PROCURAR/TRATAMENTO: navega para Page3 com inventario selecionado
2428:     *===========================================================================
2429:     PROCEDURE BtnConfirmarClick()
2430:         LOCAL loc_oPg2, loc_cCodigo, loc_lResultado
2431:         loc_lResultado = .F.
2432:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
2433: 
2434:         TRY
2435:             IF THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR"
2436:                 THIS.FormParaBO()
2437:                 IF THIS.this_oBusinessObject.Salvar()
2438:                     MsgInfo("Invent" + CHR(225) + "rio " + ;
2439:                         IIF(THIS.this_cModoAtual = "INCLUIR", "inclu" + CHR(237) + "do", "alterado") + ;
2440:                         " com sucesso!", "Sucesso")
2441:                     THIS.pgf_4c_Paginas.ActivePage = 1
2442:                     THIS.this_cModoAtual = "LISTA"
2443:                     THIS.CarregarLista()
2444:                     loc_lResultado = .T.
2445:                 ENDIF
2446:             ELSE
2447:                 loc_cCodigo = ALLTRIM(TRANSFORM(loc_oPg2.txt_4c_Codigo.Value))
2448:                 IF EMPTY(loc_cCodigo)
2449:                     MsgAviso("Informe o C" + CHR(243) + "digo do Invent" + CHR(225) + "rio!", ;
2450:                         "Campo Obrigat" + CHR(243) + "rio")
2451:                 ELSE
2452:                     THIS.this_nCodigoSel = VAL(loc_cCodigo)
2453:                     THIS.pgf_4c_Paginas.ActivePage = 3
2454:                     THIS.this_cModoAtual = "TRATAMENTO"
2455:                     THIS.CarregarGradeTratamento()
2456:                     loc_lResultado = .T.
2457:                 ENDIF
2458:             ENDIF
2459:         CATCH TO loException
2460:             MostrarErro("Erro em Confirmar:" + CHR(13) + ;
2461:                 loException.Message + CHR(13) + ;
2462:                 "Linha: " + TRANSFORM(loException.LineNo), ;
2463:                 "Formint.BtnConfirmarClick")
2464:         ENDTRY
2465: 
2466:         RETURN loc_lResultado
2467:     ENDPROC
2468: 
2469:     *===========================================================================
2470:     * BtnCancelarClick - Cancela filtros e retorna para Page1 (Lista)
2471:     *===========================================================================
2472:     PROCEDURE BtnCancelarClick()
2473:         THIS.pgf_4c_Paginas.ActivePage = 1
2474:         THIS.this_cModoAtual = "LISTA"
2475:         THIS.CarregarLista()
2476:     ENDPROC
2477: 
2478:     *===========================================================================
2479:     * FormParaBO - Transfere campos Page2 para propriedades do BO
2480:     *===========================================================================
2481:     PROTECTED PROCEDURE FormParaBO()
2482:         LOCAL loc_oPg2
2483:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2484: 
2485:         WITH THIS.this_oBusinessObject
2486:             .this_cGrupos   = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
2487:             .this_cContas   = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
2488:             .this_dDataInis = loc_oPg2.txt_4c_DataInicial.Value
2489:             .this_dDataFims = loc_oPg2.txt_4c_DataFinal.Value
2490:             .this_cLocalis  = ALLTRIM(loc_oPg2.txt_4c_LocalInicial.Value)
2491:             .this_cLocalfs  = ALLTRIM(loc_oPg2.txt_4c_LocalFinal.Value)
2492:             .this_cIforis   = ALLTRIM(loc_oPg2.txt_4c_FornecInicial.Value)
2493:             .this_cIforfs   = ALLTRIM(loc_oPg2.txt_4c_FornecFinal.Value)
2494:             .this_cCgruis   = ALLTRIM(loc_oPg2.txt_4c_GrupoInicial.Value)
2495:             .this_cCgrufs   = ALLTRIM(loc_oPg2.txt_4c_GrupoFinal.Value)
2496:             .this_cCggruis  = ALLTRIM(loc_oPg2.txt_4c_GGrupoInicial.Value)
2497:             .this_cCggrufs  = ALLTRIM(loc_oPg2.txt_4c_GGrupoFinal.Value)
2498:             .this_nPrecois  = TRANSFORM(loc_oPg2.txt_4c_PrecoInicial.Value)
2499:             .this_nPrecofs  = TRANSFORM(loc_oPg2.txt_4c_PrecoFinal.Value)
2500:             .this_cEmps     = ALLTRIM(go_4c_Sistema.cCodEmpresa)
2501:         ENDWITH
2502:     ENDPROC
2503: 
2504:     *===========================================================================
2505:     * BOParaForm - Transfere propriedades do BO para campos Page2
2506:     *===========================================================================
2507:     PROTECTED PROCEDURE BOParaForm()
2508:         LOCAL loc_oPg2
2509:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2510: 
2511:         WITH THIS.this_oBusinessObject
2512:             loc_oPg2.txt_4c_Codigo.Value         = TRANSFORM(.this_nCodigos)
2513:             loc_oPg2.txt_4c_Grupo.Value          = ALLTRIM(.this_cGrupos)
2514:             loc_oPg2.txt_4c_DGrupo.Value         = ""
2515:             loc_oPg2.txt_4c_Conta.Value          = ALLTRIM(.this_cContas)
2516:             loc_oPg2.txt_4c_DConta.Value         = ""
2517:             loc_oPg2.txt_4c_DataInicial.Value    = .this_dDataInis
2518:             loc_oPg2.txt_4c_DataFinal.Value      = .this_dDataFims
2519:             loc_oPg2.txt_4c_LocalInicial.Value   = ALLTRIM(.this_cLocalis)
2520:             loc_oPg2.txt_4c_LocalFinal.Value     = ALLTRIM(.this_cLocalfs)
2521:             loc_oPg2.txt_4c_FornecInicial.Value  = ALLTRIM(.this_cIforis)
2522:             loc_oPg2.txt_4c_FornecFinal.Value    = ALLTRIM(.this_cIforfs)
2523:             loc_oPg2.txt_4c_GrupoInicial.Value   = ALLTRIM(.this_cCgruis)
2524:             loc_oPg2.txt_4c_GrupoFinal.Value     = ALLTRIM(.this_cCgrufs)
2525:             loc_oPg2.txt_4c_GGrupoInicial.Value  = ALLTRIM(.this_cCggruis)
2526:             loc_oPg2.txt_4c_GGrupoFinal.Value    = ALLTRIM(.this_cCggrufs)
2527:             loc_oPg2.txt_4c_PrecoInicial.Value   = .this_nPrecois
2528:             loc_oPg2.txt_4c_PrecoFinal.Value     = .this_nPrecofs
2529:         ENDWITH
2530:     ENDPROC
2531: 
2532:     *===========================================================================
2533:     * LimparCampos - Limpa todos os campos de entrada da Page2
2534:     *===========================================================================
2535:     PROTECTED PROCEDURE LimparCampos()
2536:         LOCAL loc_oPg2
2537:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2538: 
2539:         loc_oPg2.txt_4c_Codigo.Value        = ""
2540:         loc_oPg2.txt_4c_Grupo.Value         = ""
2541:         loc_oPg2.txt_4c_DGrupo.Value        = ""
2542:         loc_oPg2.txt_4c_Conta.Value         = ""
2543:         loc_oPg2.txt_4c_DConta.Value        = ""
2544:         loc_oPg2.txt_4c_DataInicial.Value   = {}
2545:         loc_oPg2.txt_4c_DataFinal.Value     = {}
2546:         loc_oPg2.txt_4c_LocalInicial.Value  = ""
2547:         loc_oPg2.txt_4c_LocalFinal.Value    = ""
2548:         loc_oPg2.txt_4c_FornecInicial.Value = ""
2549:         loc_oPg2.txt_4c_FornecFinal.Value   = ""
2550:         loc_oPg2.txt_4c_GrupoInicial.Value  = ""
2551:         loc_oPg2.txt_4c_GrupoFinal.Value    = ""
2552:         loc_oPg2.txt_4c_GGrupoInicial.Value = ""
2553:         loc_oPg2.txt_4c_GGrupoFinal.Value   = ""
2554:         loc_oPg2.txt_4c_PrecoInicial.Value  = 0
2555:         loc_oPg2.txt_4c_PrecoFinal.Value    = 0
2556:     ENDPROC
2557: 
2558:     *===========================================================================
2559:     * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
2560:     *===========================================================================
2561:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2562:         LOCAL loc_oPg2
2563:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2564: 
2565:         loc_oPg2.txt_4c_Grupo.ReadOnly         = !par_lHabilitar
2566:         loc_oPg2.txt_4c_Conta.ReadOnly         = !par_lHabilitar
2567:         loc_oPg2.txt_4c_DataInicial.ReadOnly   = !par_lHabilitar
2568:         loc_oPg2.txt_4c_DataFinal.ReadOnly     = !par_lHabilitar
2569:         loc_oPg2.txt_4c_LocalInicial.ReadOnly  = !par_lHabilitar
2570:         loc_oPg2.txt_4c_LocalFinal.ReadOnly    = !par_lHabilitar
2571:         loc_oPg2.txt_4c_FornecInicial.ReadOnly = !par_lHabilitar
2572:         loc_oPg2.txt_4c_FornecFinal.ReadOnly   = !par_lHabilitar
2573:         loc_oPg2.txt_4c_GrupoInicial.ReadOnly  = !par_lHabilitar
2574:         loc_oPg2.txt_4c_GrupoFinal.ReadOnly    = !par_lHabilitar
2575:         loc_oPg2.txt_4c_GGrupoInicial.ReadOnly = !par_lHabilitar
2576:         loc_oPg2.txt_4c_GGrupoFinal.ReadOnly   = !par_lHabilitar
2577:         loc_oPg2.txt_4c_PrecoInicial.ReadOnly  = !par_lHabilitar
2578:         loc_oPg2.txt_4c_PrecoFinal.ReadOnly    = !par_lHabilitar
2579:     ENDPROC
2580: 
2581:     *===========================================================================
2582:     * BtnIncluirClick - Prepara Page2 para inclusao de novo inventario
2583:     *===========================================================================
2584:     PROCEDURE BtnIncluirClick()
2585:         LOCAL loc_lResultado
2586:         loc_lResultado = .F.
2587: 
2588:         TRY
2589:             THIS.this_oBusinessObject.NovoRegistro()
2590:             THIS.LimparCampos()
2591:             THIS.this_cModoAtual = "INCLUIR"
2592:             THIS.HabilitarCampos(.T.)
2593:             THIS.pgf_4c_Paginas.ActivePage = 2
2594:             loc_lResultado = .T.
2595:         CATCH TO loException
2596:             MostrarErro("Erro ao incluir:" + CHR(13) + ;
2597:                 loException.Message + CHR(13) + ;
2598:                 "Linha: " + TRANSFORM(loException.LineNo), ;
2599:                 "Formint.BtnIncluirClick")
2600:         ENDTRY
2601: 
2602:         RETURN loc_lResultado
2603:     ENDPROC
2604: 
2605:     *===========================================================================
2606:     * BtnAlterarClick - Carrega inventario selecionado na Page2 para alteracao
2607:     *===========================================================================
2608:     PROCEDURE BtnAlterarClick()
2609:         LOCAL loc_lResultado
2610:         loc_lResultado = .F.
2611: 
2612:         TRY
2613:             IF THIS.this_nCodigoSel <= 0 OR EMPTY(THIS.this_cCIdChavesSel)
2614:                 MsgAviso("Selecione um invent" + CHR(225) + "rio para alterar.", ;
2615:                     "Sele" + CHR(231) + CHR(227) + "o Necess" + CHR(225) + "ria")
2616:             ELSE
2617:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cCIdChavesSel)
2618:                     THIS.BOParaForm()
2619:                     THIS.this_cModoAtual = "ALTERAR"
2620:                     THIS.HabilitarCampos(.T.)
2621:                     THIS.pgf_4c_Paginas.ActivePage = 2
2622:                     loc_lResultado = .T.
2623:                 ENDIF
2624:             ENDIF
2625:         CATCH TO loException
2626:             MostrarErro("Erro ao alterar:" + CHR(13) + ;
2627:                 loException.Message + CHR(13) + ;
2628:                 "Linha: " + TRANSFORM(loException.LineNo), ;
2629:                 "Formint.BtnAlterarClick")
2630:         ENDTRY
2631: 
2632:         RETURN loc_lResultado
2633:     ENDPROC
2634: 
2635:     *===========================================================================
2636:     * BtnVisualizarClick - Exibe inventario selecionado na Page2 (somente leitura)
2637:     *===========================================================================
2638:     PROCEDURE BtnVisualizarClick()
2639:         LOCAL loc_lResultado
2640:         loc_lResultado = .F.
2641: 
2642:         TRY
2643:             IF THIS.this_nCodigoSel <= 0 OR EMPTY(THIS.this_cCIdChavesSel)
2644:                 MsgAviso("Selecione um invent" + CHR(225) + "rio para visualizar.", ;
2645:                     "Sele" + CHR(231) + CHR(227) + "o Necess" + CHR(225) + "ria")
2646:             ELSE
2647:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cCIdChavesSel)
2648:                     THIS.BOParaForm()
2649:                     THIS.this_cModoAtual = "VISUALIZAR"
2650:                     THIS.HabilitarCampos(.F.)
2651:                     THIS.pgf_4c_Paginas.ActivePage = 2
2652:                     loc_lResultado = .T.
2653:                 ENDIF
2654:             ENDIF
2655:         CATCH TO loException
2656:             MostrarErro("Erro ao visualizar:" + CHR(13) + ;
2657:                 loException.Message + CHR(13) + ;
2658:                 "Linha: " + TRANSFORM(loException.LineNo), ;
2659:                 "Formint.BtnVisualizarClick")
2660:         ENDTRY
2661: 
2662:         RETURN loc_lResultado
2663:     ENDPROC
2664: 
2665:     *===========================================================================
2666:     * BtnExcluirClick - Exclui o inventario selecionado apos confirmacao
2667:     *===========================================================================
2668:     PROCEDURE BtnExcluirClick()
2669:         LOCAL loc_lResultado, loc_lConfirmou
2670:         loc_lResultado = .F.
2671: 
2672:         TRY
2673:             IF THIS.this_nCodigoSel <= 0 OR EMPTY(THIS.this_cCIdChavesSel)
2674:                 MsgAviso("Selecione um invent" + CHR(225) + "rio para excluir.", ;
2675:                     "Sele" + CHR(231) + CHR(227) + "o Necess" + CHR(225) + "ria")
2676:             ELSE
2677:                 loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + "o do" + ;
2678:                     " invent" + CHR(225) + "rio " + ;
2679:                     TRANSFORM(THIS.this_nCodigoSel) + "?", ;
2680:                     "Confirmar Exclus" + CHR(227) + "o")
2681: 
2682:                 IF loc_lConfirmou
2683:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cCIdChavesSel)
2684:                         IF THIS.this_oBusinessObject.Excluir()
2685:                             THIS.this_nCodigoSel   = 0
2686:                             THIS.this_cCIdChavesSel = ""
2687:                             THIS.CarregarLista()
2688:                             loc_lResultado = .T.
2689:                         ENDIF
2690:                     ENDIF
2691:                 ENDIF
2692:             ENDIF
2693:         CATCH TO loException
2694:             MostrarErro("Erro ao excluir:" + CHR(13) + ;
2695:                 loException.Message + CHR(13) + ;
2696:                 "Linha: " + TRANSFORM(loException.LineNo), ;
2697:                 "Formint.BtnExcluirClick")
2698:         ENDTRY
2699: 
2700:         RETURN loc_lResultado
2701:     ENDPROC
2702: 
2703:     *===========================================================================
2704:     * CarregarGradeTratamento - Carrega grade de itens do inventario selecionado
2705:     *===========================================================================
2706:     PROTECTED PROCEDURE CarregarGradeTratamento()
2707:         LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_oGrid, loc_oPg3
2708:         LOCAL loc_nTotCOc, loc_nTotSOc
2709:         loc_lResultado = .F.
2710: 
2711:         TRY
2712:             IF THIS.this_nCodigoSel <= 0
2713:                 MsgAviso("Nenhum invent" + CHR(225) + "rio selecionado", ;
2714:                     "Formint.CarregarGradeTratamento")
2715:             ELSE
2716:                 IF USED("cursor_4c_Tratamento")
2717:                     USE IN cursor_4c_Tratamento
2718:                 ENDIF
2719: 
2720:                 loc_cSQL = "SELECT a.Produto, a.Datatrans AS Datas, a.Barras, a.Barra2s AS BarraNovos," + ;
2721:                     " a.Apurado, a.Estoque, a.Falta AS Faltas, a.Ocorrencia," + ;
2722:                     " a.Tipos, a.PesReals, a.CCustos, a.Obs, a.Obs2s," + ;
2723:                     " a.Usuars, a.CIdChaves, a.Emps, a.Codigos" + ;
2724:                     " FROM SigIvTrT a" + ;
2725:                     " WHERE a.Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
2726:                     " AND a.Codigos = " + TRANSFORM(THIS.this_nCodigoSel) + ;
2727:                     " ORDER BY a.Barras"
2728: 
2729:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tratamento")
2730: 
2731:                 IF loc_nResult < 0
2732:                     MostrarErro("Erro ao carregar itens:" + CHR(13) + ;
2733:                         CapturarErroSQL(), "Formint.CarregarGradeTratamento")
2734:                 ELSE
2735:                     loc_oPg3  = THIS.pgf_4c_Paginas.Page3
2736:                     loc_oGrid = loc_oPg3.grd_4c_Dados
2737: 
2738:                     *-- Vincular cursor ao grid
2739:                     loc_oGrid.ColumnCount = 10
2740:                     loc_oGrid.RecordSource = "cursor_4c_Tratamento"
2741:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Tratamento.Produto"
2742:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Tratamento.Datas"
2743:                     loc_oGrid.Column3.ControlSource  = "cursor_4c_Tratamento.Barras"
2744:                     loc_oGrid.Column4.ControlSource  = "cursor_4c_Tratamento.BarraNovos"
2745:                     loc_oGrid.Column5.ControlSource  = "cursor_4c_Tratamento.Apurado"
2746:                     loc_oGrid.Column6.ControlSource  = "cursor_4c_Tratamento.Estoque"
2747:                     loc_oGrid.Column7.ControlSource  = "cursor_4c_Tratamento.Faltas"
2748:                     loc_oGrid.Column8.ControlSource  = "cursor_4c_Tratamento.Ocorrencia"
2749:                     loc_oGrid.Column9.ControlSource  = "cursor_4c_Tratamento.Tipos"
2750:                     loc_oGrid.Column10.ControlSource = "cursor_4c_Tratamento.PesReals"
2751: 
2752:                     *-- Headers DEVEM ser redefinidos apos RecordSource (VFP9 reseta para nome do campo)
2753:                     loc_oGrid.Column1.Header1.Caption  = "Produto"
2754:                     loc_oGrid.Column2.Header1.Caption  = "Data"
2755:                     loc_oGrid.Column3.Header1.Caption  = "Barra"
2756:                     loc_oGrid.Column4.Header1.Caption  = "Barra Novo"
2757:                     loc_oGrid.Column5.Header1.Caption  = "Apurado"
2758:                     loc_oGrid.Column6.Header1.Caption  = "Estoque"
2759:                     loc_oGrid.Column7.Header1.Caption  = "Diferen" + CHR(231) + "a"
2760:                     loc_oGrid.Column8.Header1.Caption  = "Ocorrencia"
2761:                     loc_oGrid.Column9.Header1.Caption  = "T"
2762:                     loc_oGrid.Column10.Header1.Caption = "Dif.Peso"
2763: 
2764:                     *-- Ajuste dinamico da coluna Dif.Peso (trtporpeso)
2765:                     LOCAL loc_nTrtPeso

*-- Linhas 2774 a 2798:
2774:                     ENDIF
2775: 
2776:                     *-- Calcular totais iniciais de ocorrencias
2777:                     loc_nTotCOc = 0
2778:                     loc_nTotSOc = 0
2779:                     IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
2780:                         SELECT cursor_4c_Tratamento
2781:                         GO TOP
2782:                         SCAN
2783:                             IF !EMPTY(ALLTRIM(cursor_4c_Tratamento.Ocorrencia))
2784:                                 loc_nTotCOc = loc_nTotCOc + 1
2785:                             ELSE
2786:                                 loc_nTotSOc = loc_nTotSOc + 1
2787:                             ENDIF
2788:                         ENDSCAN
2789:                     ENDIF
2790: 
2791:                     WITH loc_oPg3.cnt_4c__CCusto1.cnt_4c__Total
2792:                         .txt_4c_TotCOc.Value = loc_nTotCOc
2793:                         .txt_4c_TotSOc.Value = loc_nTotSOc
2794:                         .Visible     = .T.
2795:                     ENDWITH
2796: 
2797:                     *-- Exibir grid e painel de controles
2798:                     loc_oPg3.cnt_4c__CCusto1.Visible = .T.

*-- Linhas 2820 a 3558:
2820:     *===========================================================================
2821:     * AlternarPagina - Alterna entre paginas do PageFrame
2822:     *===========================================================================
2823:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
2824:         LOCAL loc_lResultado
2825:         loc_lResultado = .F.
2826: 
2827:         TRY
2828:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 3
2829:                 MostrarErro("Pagina invalida: " + TRANSFORM(par_nPagina), ;
2830:                     "Formint.AlternarPagina")
2831:             ELSE
2832:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2833: 
2834:                 DO CASE
2835:                 CASE par_nPagina = 1
2836:                     THIS.this_cModoAtual = "LISTA"
2837:                     THIS.AjustarBotoesPorModo()
2838:                     THIS.CarregarLista()
2839:                 CASE par_nPagina = 2
2840:                     THIS.this_cModoAtual = "DADOS"
2841:                     THIS.AjustarBotoesPorModo()
2842:                 CASE par_nPagina = 3
2843:                     THIS.this_cModoAtual = "TRATAMENTO"
2844:                     THIS.AjustarBotoesPorModo()
2845:                 ENDCASE
2846: 
2847:                 loc_lResultado = .T.
2848:             ENDIF
2849:         CATCH TO loException
2850:             MostrarErro("Erro em AlternarPagina:" + CHR(13) + ;
2851:                 loException.Message, "Formint.AlternarPagina")
2852:         ENDTRY
2853: 
2854:         RETURN loc_lResultado
2855:     ENDPROC
2856: 
2857:     *===========================================================================
2858:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
2859:     * NAO tornar visiveis: containers flutuantes (iniciam ocultos e aparecem via click)
2860:     *===========================================================================
2861:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2862:         LOCAL loc_nI, loc_oObjeto, loc_cNome
2863: 
2864:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2865:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2866: 
2867:             IF VARTYPE(loc_oObjeto) = "O"
2868:                 loc_cNome = UPPER(loc_oObjeto.Name)
2869: 
2870:                 *-- Pular containers flutuantes que devem iniciar ocultos
2871:                 *-- (aparecem ao clicar botoes de acao do Tratamento)
2872:                 IF INLIST(loc_cNome, ;
2873:                     "CNT_4C__CUSTO2", ;
2874:                     "CNT_4C_TRATOCOR", ;
2875:                     "CNT_4C_BAIXAAUTO", ;
2876:                     "CNT_4C__INSERIR", ;
2877:                     "CNT_4C__CCUSTO1", ;
2878:                     "CNT_4C__PROCURAR")
2879:                     *-- Recursao nos filhos mas nao torna container visivel
2880:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2881:                         THIS.TornarControlesVisiveis(loc_oObjeto)
2882:                     ENDIF
2883:                     LOOP
2884:                 ENDIF
2885: 
2886:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2887:                     loc_oObjeto.Visible = .T.
2888:                 ENDIF
2889: 
2890:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2891:                     LOCAL loc_nP
2892:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2893:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2894:                     ENDFOR
2895:                 ENDIF
2896: 
2897:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2898:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2899:                 ENDIF
2900:             ENDIF
2901:         ENDFOR
2902:     ENDPROC
2903: 
2904:     *===========================================================================
2905:     * GrdDadosAfterRowColChange - Atualiza selecao ao navegar no grid
2906:     *===========================================================================
2907:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
2908:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
2909:             SELECT cursor_4c_Dados
2910:             THIS.this_nCodigoSel    = cursor_4c_Dados.codigos
2911:             THIS.this_cCIdChavesSel = ALLTRIM(cursor_4c_Dados.cidchaves)
2912:         ENDIF
2913:     ENDPROC
2914: 
2915:     *===========================================================================
2916:     * FormatarGridLista - Aplica formatacao visual ao grid da lista
2917:     *===========================================================================
2918:     PROCEDURE FormatarGridLista(par_oGrid)
2919:         IF VARTYPE(par_oGrid) = "O"
2920:             par_oGrid.FontName = "Tahoma"
2921:             par_oGrid.FontSize = 9
2922:             par_oGrid.SetAll("DynamicBackColor", ;
2923:                 "IIF(MOD(RECNO('cursor_4c_Dados'),2)=0,RGB(240,245,255),RGB(255,255,255))", ;
2924:                 "Column")
2925:         ENDIF
2926:     ENDPROC
2927: 
2928:     *===========================================================================
2929:     * BtnBalancoClick - Abre relatorio de balanco do inventario selecionado
2930:     * Original: If GesInd=1 -> SigReInr (Nota Retorno); Else -> SigReIr1 (Relatorio)
2931:     *===========================================================================
2932:     PROCEDURE BtnBalancoClick()
2933:         LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_nGesInd, loc_cFormPath
2934:         loc_lResultado = .F.
2935:         loc_nGesInd    = 0
2936: 
2937:         TRY
2938:             IF EMPTY(THIS.this_cCIdChavesSel)
2939:                 MsgAviso("Selecione um invent" + CHR(225) + "rio na lista.", ;
2940:                     "Sele" + CHR(231) + CHR(227) + "o")
2941:             ELSE
2942:                 loc_cSQL = "SELECT TOP 1 GesInd FROM SigCdPam" + ;
2943:                            " WHERE emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
2944:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
2945:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Pam") > 0
2946:                     SELECT cursor_4c_Pam
2947:                     loc_nGesInd = TratarNulo(GesInd, "N")
2948:                 ENDIF
2949:                 IF USED("cursor_4c_Pam")
2950:                     USE IN cursor_4c_Pam
2951:                 ENDIF
2952: 
2953:                 IF loc_nGesInd = 1
2954:                     loc_cFormPath = gc_4c_CaminhoForms + "relatorios\FormSigReInr.prg"
2955:                 ELSE
2956:                     loc_cFormPath = gc_4c_CaminhoForms + "relatorios\FormSigReIr1.prg"
2957:                 ENDIF
2958: 
2959:                 IF FILE(loc_cFormPath)
2960:                     DO FORM (loc_cFormPath) WITH THIS.this_nCodigoSel
2961:                 ELSE
2962:                     MsgAviso("Relat" + CHR(243) + "rio de Balan" + CHR(231) + CHR(231) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel.", ;
2963:                         "Informa" + CHR(231) + CHR(227) + "o")
2964:                 ENDIF
2965:                 loc_lResultado = .T.
2966:             ENDIF
2967:         CATCH TO loException
2968:             MsgErro("Erro em Balan" + CHR(231) + CHR(231) + "o:" + CHR(13) + ;
2969:                 loException.Message + CHR(13) + ;
2970:                 "Linha: " + TRANSFORM(loException.LineNo), ;
2971:                 "Formint.BtnBalancoClick")
2972:         ENDTRY
2973: 
2974:         RETURN loc_lResultado
2975:     ENDPROC
2976: 
2977:     *===========================================================================
2978:     * BtnBaixaAutoClick - Baixa automatica de inventario
2979:     * Inventario deve estar encerrado e nao tratado
2980:     *===========================================================================
2981:     PROCEDURE BtnBaixaAutoClick()
2982:         LOCAL loc_lResultado
2983:         loc_lResultado = .F.
2984: 
2985:         TRY
2986:             IF EMPTY(THIS.this_cCIdChavesSel)
2987:                 MsgAviso("Selecione um invent" + CHR(225) + "rio na lista.", ;
2988:                     "Sele" + CHR(231) + CHR(227) + "o")
2989:             ELSE
2990:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cCIdChavesSel)
2991:                     MsgErro("Erro ao carregar dados do invent" + CHR(225) + "rio.", ;
2992:                         "Formint.BtnBaixaAutoClick")
2993:                 ELSE
2994:                     IF !THIS.this_oBusinessObject.this_lEncerras
2995:                         MsgAviso("O invent" + CHR(225) + "rio deve estar ENCERRADO para Baixa Autom" + CHR(225) + "tica.", ;
2996:                             "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida")
2997:                     ELSE
2998:                         IF THIS.this_oBusinessObject.this_lTratas
2999:                         MsgAviso("O invent" + CHR(225) + "rio j" + CHR(225) + " foi TRATADO.", ;
3000:                             "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida")
3001:                     ELSE
3002:                         THIS.pgf_4c_Paginas.ActivePage = 3
3003:                         THIS.this_cModoAtual = "BAIXAAUTO"
3004:                         THIS.CarregarGradeTratamento()
3005:                         loc_lResultado = .T.
3006:                         ENDIF
3007:                     ENDIF
3008:                 ENDIF
3009:             ENDIF
3010:         CATCH TO loException
3011:             MsgErro("Erro em Baixa Autom" + CHR(225) + "tica:" + CHR(13) + ;
3012:                 loException.Message + CHR(13) + ;
3013:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3014:                 "Formint.BtnBaixaAutoClick")
3015:         ENDTRY
3016: 
3017:         RETURN loc_lResultado
3018:     ENDPROC
3019: 
3020:     *===========================================================================
3021:     * BtnTratamentoClick - Inicia tratamento manual do inventario
3022:     * Inventario deve estar encerrado e nao tratado
3023:     *===========================================================================
3024:     PROCEDURE BtnTratamentoClick()
3025:         LOCAL loc_lResultado
3026:         loc_lResultado = .F.
3027: 
3028:         TRY
3029:             IF EMPTY(THIS.this_cCIdChavesSel)
3030:                 MsgAviso("Selecione um invent" + CHR(225) + "rio na lista.", ;
3031:                     "Sele" + CHR(231) + CHR(227) + "o")
3032:             ELSE
3033:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cCIdChavesSel)
3034:                     MsgErro("Erro ao carregar dados do invent" + CHR(225) + "rio.", ;
3035:                         "Formint.BtnTratamentoClick")
3036:                 ELSE
3037:                     IF !THIS.this_oBusinessObject.this_lEncerras
3038:                         MsgAviso("O invent" + CHR(225) + "rio deve estar ENCERRADO para Tratamento.", ;
3039:                             "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida")
3040:                     ELSE
3041:                         IF THIS.this_oBusinessObject.this_lTratas
3042:                         MsgAviso("O invent" + CHR(225) + "rio j" + CHR(225) + " foi TRATADO.", ;
3043:                             "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida")
3044:                     ELSE
3045:                         THIS.pgf_4c_Paginas.ActivePage = 3
3046:                         THIS.this_cModoAtual = "TRATAMENTO"
3047:                         THIS.CarregarGradeTratamento()
3048:                         loc_lResultado = .T.
3049:                         ENDIF
3050:                     ENDIF
3051:                 ENDIF
3052:             ENDIF
3053:         CATCH TO loException
3054:             MsgErro("Erro em Tratamento:" + CHR(13) + ;
3055:                 loException.Message + CHR(13) + ;
3056:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3057:                 "Formint.BtnTratamentoClick")
3058:         ENDTRY
3059: 
3060:         RETURN loc_lResultado
3061:     ENDPROC
3062: 
3063:     *===========================================================================
3064:     * BtnFecharClick - Encerra (fecha) o inventario selecionado
3065:     * Chama BO.AtualizarEncerramento(.T., DATETIME())
3066:     *===========================================================================
3067:     PROCEDURE BtnFecharClick()
3068:         LOCAL loc_lResultado, loc_lConfirmar
3069:         loc_lResultado = .F.
3070:         loc_lConfirmar = .F.
3071: 
3072:         TRY
3073:             IF EMPTY(THIS.this_cCIdChavesSel)
3074:                 MsgAviso("Selecione um invent" + CHR(225) + "rio na lista.", ;
3075:                     "Sele" + CHR(231) + CHR(227) + "o")
3076:             ELSE
3077:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cCIdChavesSel)
3078:                     MsgErro("Erro ao carregar dados do invent" + CHR(225) + "rio.", ;
3079:                         "Formint.BtnFecharClick")
3080:                 ELSE
3081:                     IF THIS.this_oBusinessObject.this_lEncerras
3082:                         MsgAviso("O invent" + CHR(225) + "rio j" + CHR(225) + " est" + CHR(225) + " ENCERRADO.", ;
3083:                             "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida")
3084:                     ELSE
3085:                         loc_lConfirmar = MsgConfirma( ;
3086:                             "Confirma o ENCERRAMENTO do Invent" + CHR(225) + "rio " + ;
3087:                             TRANSFORM(THIS.this_nCodigoSel) + "?" + CHR(13) + ;
3088:                             "Esta opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser desfeita.", ;
3089:                             "Confirmar Encerramento")
3090:                         IF loc_lConfirmar
3091:                             IF THIS.this_oBusinessObject.AtualizarEncerramento(.T., DATETIME())
3092:                                 MsgInfo("Invent" + CHR(225) + "rio encerrado com sucesso!", ;
3093:                                     "Encerramento")
3094:                                 THIS.CarregarLista()
3095:                                 loc_lResultado = .T.
3096:                             ENDIF
3097:                         ENDIF
3098:                     ENDIF
3099:                 ENDIF
3100:             ENDIF
3101:         CATCH TO loException
3102:             MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + ;
3103:                 loException.Message + CHR(13) + ;
3104:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3105:                 "Formint.BtnFecharClick")
3106:         ENDTRY
3107: 
3108:         RETURN loc_lResultado
3109:     ENDPROC
3110: 
3111:     *===========================================================================
3112:     * BtnProcurarClick - Navega para Page2 (filtros de busca)
3113:     *===========================================================================
3114:     PROCEDURE BtnProcurarClick()
3115:         THIS.pgf_4c_Paginas.ActivePage = 2
3116:         THIS.this_cModoAtual = "DADOS"
3117:     ENDPROC
3118: 
3119:     *===========================================================================
3120:     * CmdProcessoClick - Ordena grid por numero do processo (codigos)
3121:     *===========================================================================
3122:     PROCEDURE CmdProcessoClick()
3123:         LOCAL loc_oGrid
3124:         TRY
3125:             IF USED("cursor_4c_Dados")
3126:                 SELECT cursor_4c_Dados
3127:                 INDEX ON codigos TAG _proc
3128:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3129:                 loc_oGrid.SetFocus()
3130:                 loc_oGrid.ActiveColumn = 1
3131:             ENDIF
3132:         CATCH TO loException
3133:             MsgErro("Erro ao ordenar por processo:" + CHR(13) + loException.Message, ;
3134:                 "Formint.CmdProcessoClick")
3135:         ENDTRY
3136:     ENDPROC
3137: 
3138:     *===========================================================================
3139:     * CmdPeriodoClick - Ordena grid por periodo (datainis)
3140:     *===========================================================================
3141:     PROCEDURE CmdPeriodoClick()
3142:         LOCAL loc_oGrid
3143:         TRY
3144:             IF USED("cursor_4c_Dados")
3145:                 SELECT cursor_4c_Dados
3146:                 INDEX ON DTOS(datainis) TAG _perio
3147:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3148:                 loc_oGrid.SetFocus()
3149:                 loc_oGrid.ActiveColumn = 2
3150:             ENDIF
3151:         CATCH TO loException
3152:             MsgErro("Erro ao ordenar por per" + CHR(237) + "odo:" + CHR(13) + loException.Message, ;
3153:                 "Formint.CmdPeriodoClick")
3154:         ENDTRY
3155:     ENDPROC
3156: 
3157:     *===========================================================================
3158:     * CmdEstoqueClick - Ordena grid por estoque (contas)
3159:     *===========================================================================
3160:     PROCEDURE CmdEstoqueClick()
3161:         LOCAL loc_oGrid
3162:         TRY
3163:             IF USED("cursor_4c_Dados")
3164:                 SELECT cursor_4c_Dados
3165:                 INDEX ON ALLTRIM(contas) TAG _esto
3166:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3167:                 loc_oGrid.SetFocus()
3168:                 loc_oGrid.ActiveColumn = 4
3169:             ENDIF
3170:         CATCH TO loException
3171:             MsgErro("Erro ao ordenar por estoque:" + CHR(13) + loException.Message, ;
3172:                 "Formint.CmdEstoqueClick")
3173:         ENDTRY
3174:     ENDPROC
3175: 
3176:     *===========================================================================
3177:     * CmdLocalClick - Ordena grid por local inicial (localis)
3178:     *===========================================================================
3179:     PROCEDURE CmdLocalClick()
3180:         LOCAL loc_oGrid
3181:         TRY
3182:             IF USED("cursor_4c_Dados")
3183:                 SELECT cursor_4c_Dados
3184:                 INDEX ON ALLTRIM(localis) TAG _loca
3185:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3186:                 loc_oGrid.SetFocus()
3187:                 loc_oGrid.ActiveColumn = 5
3188:             ENDIF
3189:         CATCH TO loException
3190:             MsgErro("Erro ao ordenar por local:" + CHR(13) + loException.Message, ;
3191:                 "Formint.CmdLocalClick")
3192:         ENDTRY
3193:     ENDPROC
3194: 
3195:     *===========================================================================
3196:     * CmdGrupoClick - Ordena grid por grupo (grupos)
3197:     *===========================================================================
3198:     PROCEDURE CmdGrupoClick()
3199:         LOCAL loc_oGrid
3200:         TRY
3201:             IF USED("cursor_4c_Dados")
3202:                 SELECT cursor_4c_Dados
3203:                 INDEX ON ALLTRIM(grupos) TAG _gru
3204:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3205:                 loc_oGrid.SetFocus()
3206:                 loc_oGrid.ActiveColumn = 7
3207:             ENDIF
3208:         CATCH TO loException
3209:             MsgErro("Erro ao ordenar por grupo:" + CHR(13) + loException.Message, ;
3210:                 "Formint.CmdGrupoClick")
3211:         ENDTRY
3212:     ENDPROC
3213: 
3214:     *===========================================================================
3215:     * CmdGGrupoClick - Ordena grid por grande grupo (cggruis)
3216:     *===========================================================================
3217:     PROCEDURE CmdGGrupoClick()
3218:         LOCAL loc_oGrid
3219:         TRY
3220:             IF USED("cursor_4c_Dados")
3221:                 SELECT cursor_4c_Dados
3222:                 INDEX ON ALLTRIM(cggruis) TAG _ggru
3223:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3224:                 loc_oGrid.SetFocus()
3225:                 loc_oGrid.ActiveColumn = 8
3226:             ENDIF
3227:         CATCH TO loException
3228:             MsgErro("Erro ao ordenar por grande grupo:" + CHR(13) + loException.Message, ;
3229:                 "Formint.CmdGGrupoClick")
3230:         ENDTRY
3231:     ENDPROC
3232: 
3233:     *===========================================================================
3234:     * CmdUsuarioClick - Ordena grid por usuario (usuars)
3235:     *===========================================================================
3236:     PROCEDURE CmdUsuarioClick()
3237:         LOCAL loc_oGrid
3238:         TRY
3239:             IF USED("cursor_4c_Dados")
3240:                 SELECT cursor_4c_Dados
3241:                 INDEX ON ALLTRIM(usuars) TAG _usu
3242:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
3243:                 loc_oGrid.SetFocus()
3244:                 loc_oGrid.ActiveColumn = 9
3245:             ENDIF
3246:         CATCH TO loException
3247:             MsgErro("Erro ao ordenar por usu" + CHR(225) + "rio:" + CHR(13) + loException.Message, ;
3248:                 "Formint.CmdUsuarioClick")
3249:         ENDTRY
3250:     ENDPROC
3251: 
3252:     *===========================================================================
3253:     * Destroy - Libera recursos ao fechar
3254:     *===========================================================================
3255:     PROCEDURE Destroy()
3256:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3257:             THIS.this_oBusinessObject = .NULL.
3258:         ENDIF
3259: 
3260:         IF USED("cursor_4c_Dados")
3261:             USE IN cursor_4c_Dados
3262:         ENDIF
3263:         IF USED("cursor_4c_Tratamento")
3264:             USE IN cursor_4c_Tratamento
3265:         ENDIF
3266:         IF USED("cursor_4c_Ocorr")
3267:             USE IN cursor_4c_Ocorr
3268:         ENDIF
3269:         IF USED("CrSigCdBal")
3270:             USE IN CrSigCdBal
3271:         ENDIF
3272:         IF USED("CsTratamento")
3273:             USE IN CsTratamento
3274:         ENDIF
3275: 
3276:         DODEFAULT()
3277:     ENDPROC
3278: 
3279:     *===========================================================================
3280:     * GrdBalancoAfterRowColChange - Exibe painel de controles com dados do item
3281:     *===========================================================================
3282:     PROCEDURE GrdBalancoAfterRowColChange(par_nColIndex)
3283:         LOCAL loc_oCnt
3284: 
3285:         IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3286:             SELECT cursor_4c_Tratamento
3287: 
3288:             loc_oCnt = THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1
3289:             WITH loc_oCnt
3290:                 .Visible             = .T.
3291:                 .txt_4c_DPro.Value   = TratarNulo(cursor_4c_Tratamento.Produto,  "C")
3292:                 .txt_4c_CCusto.Value = TratarNulo(cursor_4c_Tratamento.CCustos,  "C")
3293:                 .txt_4c_Dif.Value    = TratarNulo(cursor_4c_Tratamento.Faltas,   "N")
3294:                 .txt_4c_Usuars.Value = TratarNulo(cursor_4c_Tratamento.Usuars,   "C")
3295:                 .txt_4c_PesReal.Value = TratarNulo(cursor_4c_Tratamento.PesReals, "N")
3296:                 .edt_4c_ObsCnt1.Value = TratarNulo(cursor_4c_Tratamento.Obs, "C")
3297:                 .Refresh()
3298:             ENDWITH
3299: 
3300:             WITH THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
3301:                 .Column8.ReadOnly       = .F.
3302:                 .Column8.Text1.ReadOnly = .F.
3303:                 .Refresh()
3304:             ENDWITH
3305:         ENDIF
3306:     ENDPROC
3307: 
3308:     *===========================================================================
3309:     * GrdColOcorWhen - Salva valor atual antes da edicao (Column8)
3310:     *===========================================================================
3311:     PROCEDURE GrdColOcorWhen()
3312:         IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3313:             THIS.this_cOldValue = ALLTRIM(TratarNulo(cursor_4c_Tratamento.Ocorrencia, "C"))
3314:         ENDIF
3315:     ENDPROC
3316: 
3317:     *===========================================================================
3318:     * GrdColOcorValid - Valida e abre lookup de Ocorrencia (Column8)
3319:     *===========================================================================
3320:     PROCEDURE GrdColOcorValid()
3321:         LOCAL loc_lResultado, loc_oGrid, loc_cOcor
3322:         loc_lResultado = .T.
3323: 
3324:         TRY
3325:             loc_oGrid = THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
3326:             loc_cOcor = ALLTRIM(loc_oGrid.Column8.Text1.Value)
3327: 
3328:             WITH THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1
3329:                 .cmd_4c_BarraNovo.Visible = .F.
3330:             ENDWITH
3331: 
3332:             IF !EMPTY(loc_cOcor) AND loc_cOcor != THIS.this_cOldValue
3333:                 loc_lResultado = THIS.AbrirLookupOcorrencia("O", "<>", loc_cOcor, ;
3334:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1)
3335:             ENDIF
3336: 
3337:             *-- Atualizar usuario no painel
3338:             IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3339:                 THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.txt_4c_Usuars.Value = ;
3340:                     ALLTRIM(gc_4c_UsuarioLogado)
3341:             ENDIF
3342:         CATCH TO loException
3343:             MsgErro("Erro em GrdColOcorValid:" + CHR(13) + ;
3344:                 loException.Message + CHR(13) + ;
3345:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3346:                 "Formint.GrdColOcorValid")
3347:             loc_lResultado = .F.
3348:         ENDTRY
3349: 
3350:         RETURN loc_lResultado
3351:     ENDPROC
3352: 
3353:     *===========================================================================
3354:     * GrdColOcorLostFocus - Atualiza contadores apos saida do campo (Column8)
3355:     *===========================================================================
3356:     PROCEDURE GrdColOcorLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3357:         LOCAL loc_cNovo, loc_oTotal, loc_nCOc, loc_nSOc
3358: 
3359:         TRY
3360:             IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3361:                 loc_cNovo  = ALLTRIM(THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.Value)
3362:                 loc_oTotal = THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cnt_4c__Total
3363:                 loc_nCOc   = loc_oTotal.txt_4c_TotCOc.Value
3364:                 loc_nSOc   = loc_oTotal.txt_4c_TotSOc.Value
3365: 
3366:                 IF !EMPTY(THIS.this_cOldValue) AND EMPTY(loc_cNovo)
3367:                     loc_nCOc = loc_nCOc - 1
3368:                     loc_nSOc = loc_nSOc + 1
3369:                 ELSE
3370:                     IF EMPTY(THIS.this_cOldValue) AND !EMPTY(loc_cNovo)
3371:                         loc_nCOc = loc_nCOc + 1
3372:                         loc_nSOc = loc_nSOc - 1
3373:                     ENDIF
3374:                 ENDIF
3375: 
3376:                 loc_oTotal.txt_4c_TotCOc.Value = MAX(0, loc_nCOc)
3377:                 loc_oTotal.txt_4c_TotSOc.Value = MAX(0, loc_nSOc)
3378:                 loc_oTotal.Refresh()
3379: 
3380:                 *-- Se RepeteObs marcado, copiar observacao anterior para proximo
3381:                 IF THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.chk_4c_RepeteObs.Value = 1
3382:                     LOCAL loc_cObsAtual
3383:                     loc_cObsAtual = ALLTRIM(THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.edt_4c_ObsCnt1.Value)
3384:                     IF !EMPTY(loc_cObsAtual)
3385:                         THIS.this_cObsAnterior = loc_cObsAtual
3386:                     ENDIF
3387:                 ENDIF
3388:             ENDIF
3389:         CATCH TO loException
3390:             MsgErro("Erro em GrdColOcorLostFocus:" + CHR(13) + loException.Message, ;
3391:                 "Formint.GrdColOcorLostFocus")
3392:         ENDTRY
3393:     ENDPROC
3394: 
3395:     *===========================================================================
3396:     * GetDProLostFocus - Apos editar descricao, volta o foco ao grid
3397:     *===========================================================================
3398:     PROCEDURE GetDProLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3399:         IF !EMPTY(THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.edt_4c_ObsCnt1.Value)
3400:             THIS.this_cObsAnterior = ALLTRIM(THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.edt_4c_ObsCnt1.Value)
3401:         ENDIF
3402:         THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.SetFocus()
3403:         THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
3404:     ENDPROC
3405: 
3406:     *===========================================================================
3407:     * BtnSobraClick - Exibe painel de insercao de item de sobra
3408:     *===========================================================================
3409:     PROCEDURE BtnSobraClick()
3410:         LOCAL loc_oCnt
3411:         TRY
3412:             loc_oCnt = THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir
3413:             WITH loc_oCnt
3414:                 .Visible = .T.
3415:                 .cmd_4c_CntInsere.Enabled = .F.
3416:                 .txt_4c_IBarra.Value = ""
3417:                 .txt_4c_ICCusto.Value = ""
3418:                 .txt_4c_IOcor.Value = ""
3419:                 .edt_4c_IBObs.Value = ""
3420:                 .Refresh()
3421:                 .txt_4c_IBarra.SetFocus()
3422:             ENDWITH
3423:         CATCH TO loException
3424:             MsgErro("Erro em BtnSobraClick:" + CHR(13) + loException.Message, ;
3425:                 "Formint.BtnSobraClick")
3426:         ENDTRY
3427:     ENDPROC
3428: 
3429:     *===========================================================================
3430:     * BtnProcurarCntClick - Exibe painel de busca por barra
3431:     *===========================================================================
3432:     PROCEDURE BtnProcurarCntClick()
3433:         LOCAL loc_oPg3
3434:         TRY
3435:             loc_oPg3 = THIS.pgf_4c_Paginas.Page3
3436:             WITH loc_oPg3
3437:                 .cnt_4c__CCusto1.Visible   = .F.
3438:                 .grd_4c_Dados.Visible      = .F.
3439:                 .cnt_4c__Procurar.Visible  = .T.
3440:                 .cnt_4c__Procurar.Refresh()
3441:                 .cnt_4c__Procurar.txt_4c_GetBusca.Value = ""
3442:                 .cnt_4c__Procurar.txt_4c_GetBusca.SetFocus()
3443:             ENDWITH
3444:         CATCH TO loException
3445:             MsgErro("Erro em BtnProcurarCntClick:" + CHR(13) + loException.Message, ;
3446:                 "Formint.BtnProcurarCntClick")
3447:         ENDTRY
3448:     ENDPROC
3449: 
3450:     *===========================================================================
3451:     * BtnBarraNovoCntClick - Exibe painel de novo barra
3452:     *===========================================================================
3453:     PROCEDURE BtnBarraNovoCntClick()
3454:         LOCAL loc_oCnt
3455:         TRY
3456:             loc_oCnt = THIS.pgf_4c_Paginas.Page3.cnt_4c__Custo2
3457:             WITH loc_oCnt
3458:                 .Visible = .T.
3459:                 .txt_4c_GetBarNovo.Value = ""
3460:                 .txt_4c_BNCCusto.Value = ""
3461:                 .txt_4c_BNPesReal.Value = 0
3462:                 .txt_4c_GetJustif.Value = ""
3463:                 .edt_4c_BNObs.Value = ""
3464:                 .Refresh()
3465:                 .txt_4c_GetBarNovo.SetFocus()
3466:             ENDWITH
3467:         CATCH TO loException
3468:             MsgErro("Erro em BtnBarraNovoCntClick:" + CHR(13) + loException.Message, ;
3469:                 "Formint.BtnBarraNovoCntClick")
3470:         ENDTRY
3471:     ENDPROC
3472: 
3473:     *===========================================================================
3474:     * BtnCancelaCntClick - Confirma cancelamento e volta para Page1
3475:     *===========================================================================
3476:     PROCEDURE BtnCancelaCntClick()
3477:         LOCAL loc_lConfirmar
3478:         loc_lConfirmar = .F.
3479: 
3480:         TRY
3481:             loc_lConfirmar = MsgConfirma("Deseja Cancelar?" + CHR(13) + ;
3482:                 "Altera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o salvas ser" + CHR(227) + "o perdidas.", ;
3483:                 "Cancelar Tratamento")
3484: 
3485:             IF loc_lConfirmar
3486:                 THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.Visible  = .F.
3487:                 THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Visible      = .F.
3488:                 THIS.pgf_4c_Paginas.ActivePage = 1
3489:                 THIS.this_cModoAtual = "LISTA"
3490:                 THIS.CarregarLista()
3491:             ENDIF
3492:         CATCH TO loException
3493:             MsgErro("Erro em BtnCancelaCntClick:" + CHR(13) + loException.Message, ;
3494:                 "Formint.BtnCancelaCntClick")
3495:         ENDTRY
3496:     ENDPROC
3497: 
3498:     *===========================================================================
3499:     * BtnSairCntClick - Salva tratamento (se Caption="Grava") ou volta para Page1
3500:     *===========================================================================
3501:     PROCEDURE BtnSairCntClick()
3502:         LOCAL loc_lResultado, loc_cCaption, loc_cSQL, loc_nResult, loc_lValido
3503:         loc_lResultado = .F.
3504:         loc_lValido    = .T.
3505: 
3506:         TRY
3507:             loc_cCaption = ALLTRIM(THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption)
3508: 
3509:             IF loc_cCaption = "\<Grava" OR loc_cCaption = "Grava"
3510:                 *-- Validar: todo lancamento com Ocorrencia deve ter Obs
3511:                 IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3512:                     SELECT cursor_4c_Tratamento
3513:                     GO TOP
3514:                     SCAN
3515:                         IF !EMPTY(ALLTRIM(cursor_4c_Tratamento.Ocorrencia)) AND ;
3516:                            EMPTY(ALLTRIM(cursor_4c_Tratamento.Obs)) AND ;
3517:                            EMPTY(ALLTRIM(cursor_4c_Tratamento.Obs2s))
3518:                             MsgAviso("Existem lan" + CHR(231) + "amentos com Ocorr" + CHR(234) + ;
3519:                                 "ncia sem Observa" + CHR(231) + CHR(227) + "o !!!", ;
3520:                                 "Valida" + CHR(231) + CHR(227) + "o")
3521:                             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
3522:                             loc_lValido = .F.
3523:                             EXIT
3524:                         ENDIF
3525:                     ENDSCAN
3526: 
3527:                     IF loc_lValido
3528:                         *-- Gravar cada linha na tabela SigIvTrT
3529:                         SELECT cursor_4c_Tratamento
3530:                         GO TOP
3531:                         SCAN
3532:                             loc_cSQL = "UPDATE SigIvTrT SET" + ;
3533:                                 " Ocorrencia = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Ocorrencia)) + ;
3534:                                 ", Obs = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Obs)) + ;
3535:                                 ", Obs2s = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Obs2s)) + ;
3536:                                 ", Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
3537:                                 " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3538:                                 " AND CIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.CIdChaves))
3539:                             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
3540:                             IF loc_nResult < 0
3541:                                 MostrarErro("Erro ao gravar item:" + CHR(13) + ;
3542:                                     CapturarErroSQL(), "Formint.BtnSairCntClick")
3543:                                 loc_lValido = .F.
3544:                                 EXIT
3545:                             ENDIF
3546:                         ENDSCAN
3547:                     ENDIF
3548: 
3549:                     IF loc_lValido
3550:                     *-- Marcar inventario como tratado
3551:                     loc_cSQL = "UPDATE SigCdBal SET Tratas = 1" + ;
3552:                         " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3553:                         " AND Codigos = " + TRANSFORM(THIS.this_nCodigoSel)
3554:                     SQLEXEC(gnConnHandle, loc_cSQL)
3555: 
3556:                     MsgInfo("Tratamento gravado com sucesso!", "Tratamento")
3557:                     loc_lResultado = .T.
3558:                     ENDIF

*-- Linhas 3581 a 3722:
3581:     *===========================================================================
3582:     * GetJustifValid - Lookup de Justificativa (SigBaOco Tipos='J')
3583:     *===========================================================================
3584:     PROCEDURE GetJustifValid()
3585:         LOCAL loc_lResultado, loc_oTxt
3586:         loc_lResultado = .T.
3587: 
3588:         TRY
3589:             loc_oTxt = THIS.pgf_4c_Paginas.Page3.cnt_4c__Custo2.txt_4c_GetJustif
3590: 
3591:             IF !EMPTY(ALLTRIM(loc_oTxt.Value))
3592:                 loc_lResultado = THIS.AbrirLookupOcorrencia("J", "", ALLTRIM(loc_oTxt.Value), loc_oTxt)
3593:             ENDIF
3594:         CATCH TO loException
3595:             MsgErro("Erro em GetJustifValid:" + CHR(13) + loException.Message, ;
3596:                 "Formint.GetJustifValid")
3597:             loc_lResultado = .F.
3598:         ENDTRY
3599: 
3600:         RETURN loc_lResultado
3601:     ENDPROC
3602: 
3603:     *===========================================================================
3604:     * BtnBNCancelaClick - Cancela painel Novo Barra
3605:     *===========================================================================
3606:     PROCEDURE BtnBNCancelaClick()
3607:         THIS.pgf_4c_Paginas.Page3.cnt_4c__Custo2.Visible = .F.
3608:         THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3609:     ENDPROC
3610: 
3611:     *===========================================================================
3612:     * BtnBNSairClick - Confirma novo barra e habilita botao Grava
3613:     *===========================================================================
3614:     PROCEDURE BtnBNSairClick()
3615:         LOCAL loc_oCnt2, loc_cObs2s
3616:         TRY
3617:             loc_oCnt2 = THIS.pgf_4c_Paginas.Page3.cnt_4c__Custo2
3618:             loc_cObs2s = ALLTRIM(loc_oCnt2.edt_4c_BNObs.Value)
3619: 
3620:             IF !EMPTY(loc_cObs2s) AND USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3621:                 SELECT cursor_4c_Tratamento
3622:                 REPLACE cursor_4c_Tratamento.Obs2s WITH loc_cObs2s
3623:                 REPLACE cursor_4c_Tratamento.BarraNovos WITH ALLTRIM(loc_oCnt2.txt_4c_GetBarNovo.Value)
3624:             ENDIF
3625: 
3626:             loc_oCnt2.Visible = .F.
3627:             THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_CancelaCnt.Visible = .T.
3628:             THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption    = "\<Grava"
3629:             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3630:             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
3631:         CATCH TO loException
3632:             MsgErro("Erro em BtnBNSairClick:" + CHR(13) + loException.Message, ;
3633:                 "Formint.BtnBNSairClick")
3634:         ENDTRY
3635:     ENDPROC
3636: 
3637:     *===========================================================================
3638:     * GetTOcorCntTratValid - Lookup de Ocorrencia no painel TratOcor (Tipos='O')
3639:     *===========================================================================
3640:     PROCEDURE GetTOcorCntTratValid()
3641:         LOCAL loc_lResultado, loc_oTxt
3642:         loc_lResultado = .T.
3643: 
3644:         TRY
3645:             loc_oTxt = THIS.pgf_4c_Paginas.Page3.cnt_4c_TratOcor.txt_4c_TOcor
3646: 
3647:             IF !EMPTY(ALLTRIM(loc_oTxt.Value))
3648:                 loc_lResultado = THIS.AbrirLookupOcorrencia("O", "", ALLTRIM(loc_oTxt.Value), loc_oTxt)
3649:             ENDIF
3650:         CATCH TO loException
3651:             MsgErro("Erro em GetTOcorCntTratValid:" + CHR(13) + loException.Message, ;
3652:                 "Formint.GetTOcorCntTratValid")
3653:             loc_lResultado = .F.
3654:         ENDTRY
3655: 
3656:         RETURN loc_lResultado
3657:     ENDPROC
3658: 
3659:     *===========================================================================
3660:     * BtnTratOcorClick - Aplica ocorrencia a todos os registros do tipo selecionado
3661:     *===========================================================================
3662:     PROCEDURE BtnTratOcorClick()
3663:         LOCAL loc_lResultado, loc_oCnt, loc_cOcor, loc_nSemOcor
3664:         LOCAL loc_cTipos, loc_cOrdem, loc_cSQL, loc_nResult
3665:         loc_lResultado = .F.
3666: 
3667:         TRY
3668:             loc_oCnt    = THIS.pgf_4c_Paginas.Page3.cnt_4c_TratOcor
3669:             loc_cOcor   = ALLTRIM(loc_oCnt.txt_4c_TOcor.Value)
3670:             loc_nSemOcor = loc_oCnt.opt_4c_SemOcor.Value
3671:             loc_cTipos  = ALLTRIM(loc_oCnt.cmb_4c_Tipos.Value)
3672: 
3673:             IF EMPTY(loc_cOcor)
3674:                 MsgAviso("Informe a Ocorr" + CHR(234) + "ncia para o Tratamento.", ;
3675:                     "Campo Obrigat" + CHR(243) + "rio")
3676:             ELSE
3677:                 IF !USED("cursor_4c_Tratamento") OR RECCOUNT("cursor_4c_Tratamento") = 0
3678:                     MsgAviso("Nenhum item para tratar.", "Tratamento")
3679:                 ELSE
3680:                     SELECT cursor_4c_Tratamento
3681:                     GO TOP
3682:                     SCAN
3683:                         LOCAL loc_lAplicar
3684:                         loc_lAplicar = .F.
3685: 
3686:                         DO CASE
3687:                         CASE loc_nSemOcor = 1   && Lidos
3688:                             loc_lAplicar = (cursor_4c_Tratamento.Tipos = "L")
3689:                         CASE loc_nSemOcor = 2   && Nao lidos
3690:                             loc_lAplicar = (cursor_4c_Tratamento.Tipos = "N")
3691:                         CASE loc_nSemOcor = 3   && Saldos
3692:                             loc_lAplicar = (cursor_4c_Tratamento.Tipos = "S")
3693:                         OTHERWISE
3694:                             loc_lAplicar = .T.
3695:                         ENDCASE
3696: 
3697:                         IF loc_cTipos = "Entrada"
3698:                             loc_lAplicar = loc_lAplicar AND (cursor_4c_Tratamento.Faltas < 0)
3699:                         ELSE
3700:                             IF loc_cTipos = "Sa" + CHR(237) + "da"
3701:                                 loc_lAplicar = loc_lAplicar AND (cursor_4c_Tratamento.Faltas > 0)
3702:                             ENDIF
3703:                         ENDIF
3704: 
3705:                         IF loc_lAplicar
3706:                             REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
3707:                             REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)
3708:                         ENDIF
3709:                     ENDSCAN
3710: 
3711:                     loc_oCnt.Visible = .F.
3712:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_CancelaCnt.Visible = .T.
3713:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption    = "\<Grava"
3714:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3715:                     loc_lResultado = .T.
3716:                 ENDIF
3717:             ENDIF
3718:         CATCH TO loException
3719:             MsgErro("Erro em BtnTratOcorClick:" + CHR(13) + ;
3720:                 loException.Message + CHR(13) + ;
3721:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3722:                 "Formint.BtnTratOcorClick")

*-- Linhas 3728 a 3816:
3728:     *===========================================================================
3729:     * BtnTOCancelaClick - Cancela painel TratOcor e volta para Page1
3730:     *===========================================================================
3731:     PROCEDURE BtnTOCancelaClick()
3732:         THIS.pgf_4c_Paginas.Page3.cnt_4c_TratOcor.Visible = .F.
3733:         THIS.pgf_4c_Paginas.ActivePage = 1
3734:         THIS.this_cModoAtual = "LISTA"
3735:         THIS.CarregarLista()
3736:     ENDPROC
3737: 
3738:     *===========================================================================
3739:     * GetTOcorBaixaAutoValid - Lookup Ocorrencia BaixaAuto (Tipos='O', Autos='S')
3740:     *===========================================================================
3741:     PROCEDURE GetTOcorBaixaAutoValid()
3742:         LOCAL loc_lResultado, loc_oTxt
3743:         loc_lResultado = .T.
3744: 
3745:         TRY
3746:             loc_oTxt = THIS.pgf_4c_Paginas.Page3.cnt_4c_BaixaAuto.txt_4c_BATOcor
3747: 
3748:             IF !EMPTY(ALLTRIM(loc_oTxt.Value))
3749:                 loc_lResultado = THIS.AbrirLookupOcorrenciaBaixaAuto(ALLTRIM(loc_oTxt.Value), loc_oTxt)
3750:             ENDIF
3751:         CATCH TO loException
3752:             MsgErro("Erro em GetTOcorBaixaAutoValid:" + CHR(13) + loException.Message, ;
3753:                 "Formint.GetTOcorBaixaAutoValid")
3754:             loc_lResultado = .F.
3755:         ENDTRY
3756: 
3757:         RETURN loc_lResultado
3758:     ENDPROC
3759: 
3760:     *===========================================================================
3761:     * OkBaixaAutoClick - Processa baixa automatica por ocorrencia
3762:     *===========================================================================
3763:     PROCEDURE OkBaixaAutoClick()
3764:         LOCAL loc_lResultado, loc_oCnt, loc_cOcor, loc_dIni, loc_dFim
3765:         LOCAL loc_cSQL, loc_nResult
3766:         loc_lResultado = .F.
3767: 
3768:         TRY
3769:             loc_oCnt  = THIS.pgf_4c_Paginas.Page3.cnt_4c_BaixaAuto
3770:             loc_cOcor = ALLTRIM(loc_oCnt.txt_4c_BATOcor.Value)
3771:             loc_dIni  = loc_oCnt.txt_4c_BAData.Value
3772:             loc_dFim  = loc_oCnt.txt_4c_BADataF.Value
3773: 
3774:             IF EMPTY(loc_cOcor)
3775:                 MsgAviso("Informe a Ocorr" + CHR(234) + "ncia para Baixa Autom" + CHR(225) + "tica.", ;
3776:                     "Campo Obrigat" + CHR(243) + "rio")
3777:             ELSE
3778:                 LOCAL loc_lConfirmar
3779:                 loc_lConfirmar = MsgConfirma("Confirma a Baixa Autom" + CHR(225) + ;
3780:                     "tica da Ocorr" + CHR(234) + "ncia [" + loc_cOcor + "]?" + CHR(13) + ;
3781:                     "Esta opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser desfeita.", ;
3782:                     "Confirmar Baixa Autom" + CHR(225) + "tica")
3783: 
3784:                 IF loc_lConfirmar
3785:                     *-- Verificar operacao da ocorrencia na SigBaOco
3786:                     loc_cSQL = "SELECT TOP 1 Operacaos FROM SigBaOco" + ;
3787:                         " WHERE Tipos = 'O' AND Autos = 'S'" + ;
3788:                         " AND Codigos = " + EscaparSQL(loc_cOcor)
3789:                     SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ocorr")
3790: 
3791:                     IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3792:                         SELECT cursor_4c_Tratamento
3793:                         GO TOP
3794:                         SCAN
3795:                             LOCAL loc_cCidChave, loc_cBarras
3796:                             loc_cCidChave = ALLTRIM(cursor_4c_Tratamento.CIdChaves)
3797:                             loc_cBarras   = ALLTRIM(TRANSFORM(cursor_4c_Tratamento.Barras))
3798: 
3799:                             *-- Aplicar ocorrencia no cursor local
3800:                             REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
3801:                             REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)
3802: 
3803:                             *-- Gravar na tabela SigIvTrT
3804:                             loc_cSQL = "UPDATE SigIvTrT SET" + ;
3805:                                 " Ocorrencia = " + EscaparSQL(loc_cOcor) + ;
3806:                                 ", Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
3807:                                 " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3808:                                 " AND CIdChaves = " + EscaparSQL(loc_cCidChave)
3809:                             SQLEXEC(gnConnHandle, loc_cSQL)
3810:                         ENDSCAN
3811: 
3812:                         *-- Marcar inventario como tratado
3813:                         loc_cSQL = "UPDATE SigCdBal SET Tratas = 1" + ;
3814:                             " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3815:                             " AND Codigos = " + TRANSFORM(THIS.this_nCodigoSel)
3816:                         SQLEXEC(gnConnHandle, loc_cSQL)

*-- Linhas 3846 a 4189:
3846:     *===========================================================================
3847:     * BtnBACancelaClick - Cancela painel BaixaAuto e volta para Page1
3848:     *===========================================================================
3849:     PROCEDURE BtnBACancelaClick()
3850:         THIS.pgf_4c_Paginas.Page3.cnt_4c_BaixaAuto.Visible = .F.
3851:         THIS.pgf_4c_Paginas.ActivePage = 1
3852:         THIS.this_cModoAtual = "LISTA"
3853:         THIS.CarregarLista()
3854:     ENDPROC
3855: 
3856:     *===========================================================================
3857:     * GetIBarraValid - Valida codigo de barra no painel Inserir
3858:     *===========================================================================
3859:     PROCEDURE GetIBarraValid()
3860:         LOCAL loc_lResultado, loc_oTxt, loc_cBarra, loc_cSQL, loc_nResult
3861:         loc_lResultado = .T.
3862: 
3863:         TRY
3864:             loc_oTxt  = THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.txt_4c_IBarra
3865:             loc_cBarra = ALLTRIM(loc_oTxt.Value)
3866: 
3867:             IF !EMPTY(loc_cBarra)
3868:                 IF USED("cursor_4c_Ocorr")
3869:                     USE IN cursor_4c_Ocorr
3870:                 ENDIF
3871: 
3872:                 loc_cSQL = "SELECT TOP 1 CBars, CPros, Pesos FROM SigOpEtq" + ;
3873:                     " WHERE CBars = " + EscaparSQL(loc_cBarra)
3874:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ocorr")
3875: 
3876:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Ocorr") > 0
3877:                     SELECT cursor_4c_Ocorr
3878:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.txt_4c_IBarra.Value = ;
3879:                         ALLTRIM(cursor_4c_Ocorr.CBars)
3880:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.cmd_4c_CntInsere.Enabled = .T.
3881:                 ELSE
3882:                     MsgAviso("C" + CHR(243) + "digo de Barra n" + CHR(227) + "o encontrado!", ;
3883:                         "Barra Inv" + CHR(225) + "lida")
3884:                     loc_lResultado = .F.
3885:                 ENDIF
3886: 
3887:                 IF USED("cursor_4c_Ocorr")
3888:                     USE IN cursor_4c_Ocorr
3889:                 ENDIF
3890:             ENDIF
3891:         CATCH TO loException
3892:             MsgErro("Erro em GetIBarraValid:" + CHR(13) + loException.Message, ;
3893:                 "Formint.GetIBarraValid")
3894:             loc_lResultado = .F.
3895:         ENDTRY
3896: 
3897:         RETURN loc_lResultado
3898:     ENDPROC
3899: 
3900:     *===========================================================================
3901:     * GetIOcorValid - Lookup de Ocorrencia no painel Inserir (Tipos='O')
3902:     *===========================================================================
3903:     PROCEDURE GetIOcorValid()
3904:         LOCAL loc_lResultado, loc_oTxt
3905:         loc_lResultado = .T.
3906: 
3907:         TRY
3908:             loc_oTxt = THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.txt_4c_IOcor
3909: 
3910:             IF !EMPTY(ALLTRIM(loc_oTxt.Value))
3911:                 loc_lResultado = THIS.AbrirLookupOcorrencia("O", "", ALLTRIM(loc_oTxt.Value), loc_oTxt)
3912:             ENDIF
3913:         CATCH TO loException
3914:             MsgErro("Erro em GetIOcorValid:" + CHR(13) + loException.Message, ;
3915:                 "Formint.GetIOcorValid")
3916:             loc_lResultado = .F.
3917:         ENDTRY
3918: 
3919:         RETURN loc_lResultado
3920:     ENDPROC
3921: 
3922:     *===========================================================================
3923:     * CntInsereClick - Insere novo item de sobra no cursor de tratamento
3924:     *===========================================================================
3925:     PROCEDURE CntInsereClick()
3926:         LOCAL loc_lResultado, loc_oCnt, loc_cBarra, loc_cOcor, loc_cObs
3927:         LOCAL loc_cSQL, loc_nResult
3928:         loc_lResultado = .F.
3929: 
3930:         TRY
3931:             loc_oCnt  = THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir
3932:             loc_cBarra = ALLTRIM(loc_oCnt.txt_4c_IBarra.Value)
3933:             loc_cOcor  = ALLTRIM(loc_oCnt.txt_4c_IOcor.Value)
3934:             loc_cObs   = ALLTRIM(loc_oCnt.edt_4c_IBObs.Value)
3935: 
3936:             IF EMPTY(loc_cBarra)
3937:                 MsgAviso("Informe o C" + CHR(243) + "digo de Barra.", "Campo Obrigat" + CHR(243) + "rio")
3938:             ELSE
3939:                 *-- Inserir no cursor local (ReadWrite permite APPEND BLANK)
3940:                 IF USED("cursor_4c_Tratamento")
3941:                     SELECT cursor_4c_Tratamento
3942:                     APPEND BLANK
3943:                     REPLACE cursor_4c_Tratamento.Emps       WITH ALLTRIM(go_4c_Sistema.cCodEmpresa)
3944:                     REPLACE cursor_4c_Tratamento.Codigos    WITH THIS.this_nCodigoSel
3945:                     REPLACE cursor_4c_Tratamento.Barras     WITH VAL(loc_cBarra)
3946:                     REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
3947:                     REPLACE cursor_4c_Tratamento.Obs        WITH loc_cObs
3948:                     REPLACE cursor_4c_Tratamento.Tipos      WITH "L"
3949:                     REPLACE cursor_4c_Tratamento.Apurado    WITH 1
3950:                     REPLACE cursor_4c_Tratamento.Estoque    WITH 0
3951:                     REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)
3952: 
3953:                     THIS.this_nCItens = THIS.this_nCItens + 1
3954: 
3955:                     *-- Limpar campos para proximo item
3956:                     loc_oCnt.txt_4c_IBarra.Value = ""
3957:                     loc_oCnt.txt_4c_IOcor.Value  = ""
3958:                     loc_oCnt.edt_4c_IBObs.Value  = ""
3959:                     loc_oCnt.cmd_4c_CntInsere.Enabled = .F.
3960:                     loc_oCnt.txt_4c_IBarra.SetFocus()
3961: 
3962:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3963:                     loc_lResultado = .T.
3964:                 ENDIF
3965:             ENDIF
3966:         CATCH TO loException
3967:             MsgErro("Erro em CntInsereClick:" + CHR(13) + ;
3968:                 loException.Message + CHR(13) + ;
3969:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3970:                 "Formint.CntInsereClick")
3971:         ENDTRY
3972: 
3973:         RETURN loc_lResultado
3974:     ENDPROC
3975: 
3976:     *===========================================================================
3977:     * CntSairInsClick - Fecha painel Inserir e volta ao grid
3978:     *===========================================================================
3979:     PROCEDURE CntSairInsClick()
3980:         THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.Visible = .F.
3981:         THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.SetFocus()
3982:         THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
3983:     ENDPROC
3984: 
3985:     *===========================================================================
3986:     * GetBuscaValid - Busca item por barra no grid de tratamento
3987:     *===========================================================================
3988:     PROCEDURE GetBuscaValid(par_nKeyCode, par_nShiftAltCtrl)
3989:         LOCAL loc_lResultado, loc_cBarra, loc_oPr
3990:         loc_lResultado = .T.
3991: 
3992:         TRY
3993:             loc_oPr    = THIS.pgf_4c_Paginas.Page3.cnt_4c__Procurar
3994:             loc_cBarra = ALLTRIM(loc_oPr.txt_4c_GetBusca.Value)
3995: 
3996:             IF !EMPTY(loc_cBarra) AND USED("cursor_4c_Tratamento")
3997:                 SELECT cursor_4c_Tratamento
3998:                 GO TOP
3999:                 LOCATE FOR ALLTRIM(TRANSFORM(cursor_4c_Tratamento.Barras)) = loc_cBarra
4000:                 IF FOUND()
4001:                     *-- Mostrar grid e painel, ocultar procurar
4002:                     loc_oPr.Visible = .F.
4003:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.Visible = .T.
4004:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Visible    = .T.
4005:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
4006:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.SetFocus()
4007:                 ELSE
4008:                     MsgAviso("Barra '" + loc_cBarra + "' n" + CHR(227) + "o encontrada.", ;
4009:                         "Busca")
4010:                 ENDIF
4011:             ENDIF
4012:         CATCH TO loException
4013:             MsgErro("Erro em GetBuscaValid:" + CHR(13) + loException.Message, ;
4014:                 "Formint.GetBuscaValid")
4015:             loc_lResultado = .F.
4016:         ENDTRY
4017: 
4018:         RETURN loc_lResultado
4019:     ENDPROC
4020: 
4021:     *===========================================================================
4022:     * AbrirLookupOcorrencia - Lookup padrao FormBuscaAuxiliar para SigBaOco
4023:     * par_cTipos:  Tipos = 'O' ou 'J'
4024:     * par_cAutos:  "" = sem filtro Autos; "<>" = Autos <> 'S'
4025:     * par_cAtual:  valor atual do campo (prefixo de busca)
4026:     * par_oTxt:    objeto TextBox para receber o valor selecionado
4027:     *===========================================================================
4028:     PROTECTED PROCEDURE AbrirLookupOcorrencia(par_cTipos, par_cAutos, par_cAtual, par_oTxt)
4029:         LOCAL loc_lResultado, loc_oLookup, loc_cFiltro
4030:         loc_lResultado = .T.
4031: 
4032:         TRY
4033:             loc_cFiltro = "Tipos = '" + par_cTipos + "'"
4034: 
4035:             IF par_cAutos = "<>"
4036:                 loc_cFiltro = loc_cFiltro + " AND Autos <> 'S'"
4037:             ENDIF
4038: 
4039:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
4040:                 "SigBaOco",             ;   && Tabela
4041:                 "Codigos",              ;   && Campo chave
4042:                 par_cAtual,             ;   && Valor inicial
4043:                 "Ocorr" + CHR(234) + "ncias", ;   && Titulo
4044:                 .T.,                    ;   && Modal
4045:                 "",                     ;   && Ordenacao
4046:                 "",                     ;   && Campo descricao (OBSOLETO)
4047:                 gnConnHandle,           ;   && Handle conexao
4048:                 loc_cFiltro)            ;   && Filtro (sem WHERE)
4049: 
4050:             IF VARTYPE(loc_oLookup) = "O"
4051:                 loc_oLookup.mAddColuna("Codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
4052:                 loc_oLookup.mAddColuna("Descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4053:                 loc_oLookup.Show()
4054: 
4055:                 IF loc_oLookup.this_lSelecionou
4056:                     par_oTxt.Value = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
4057:                     par_oTxt.Refresh()
4058:                 ELSE
4059:                     loc_lResultado = .F.
4060:                 ENDIF
4061: 
4062:                 IF USED("cursor_4c_BuscaOcorr")
4063:                     USE IN cursor_4c_BuscaOcorr
4064:                 ENDIF
4065:                 loc_oLookup = .NULL.
4066:             ELSE
4067:                 MsgErro("Erro ao criar FormBuscaAuxiliar.", "Formint.AbrirLookupOcorrencia")
4068:                 loc_lResultado = .F.
4069:             ENDIF
4070:         CATCH TO loException
4071:             MsgErro("Erro em AbrirLookupOcorrencia:" + CHR(13) + loException.Message, ;
4072:                 "Formint.AbrirLookupOcorrencia")
4073:             loc_lResultado = .F.
4074:         ENDTRY
4075: 
4076:         RETURN loc_lResultado
4077:     ENDPROC
4078: 
4079:     *===========================================================================
4080:     * AbrirLookupOcorrenciaBaixaAuto - Lookup SigBaOco (Tipos='O', Autos='S')
4081:     *===========================================================================
4082:     PROTECTED PROCEDURE AbrirLookupOcorrenciaBaixaAuto(par_cAtual, par_oTxt)
4083:         LOCAL loc_lResultado, loc_oLookup
4084:         loc_lResultado = .T.
4085: 
4086:         TRY
4087:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
4088:                 "SigBaOco",             ;
4089:                 "Codigos",              ;
4090:                 par_cAtual,             ;
4091:                 "Ocorr" + CHR(234) + "ncias Autom" + CHR(225) + "ticas", ;
4092:                 .T.,                    ;
4093:                 "",                     ;
4094:                 "",                     ;
4095:                 gnConnHandle,           ;
4096:                 "Tipos = 'O' AND Autos = 'S'")
4097: 
4098:             IF VARTYPE(loc_oLookup) = "O"
4099:                 loc_oLookup.mAddColuna("Codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
4100:                 loc_oLookup.mAddColuna("Descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4101:                 loc_oLookup.Show()
4102: 
4103:                 IF loc_oLookup.this_lSelecionou
4104:                     par_oTxt.Value = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
4105:                     par_oTxt.Refresh()
4106:                 ELSE
4107:                     loc_lResultado = .F.
4108:                 ENDIF
4109: 
4110:                 loc_oLookup = .NULL.
4111:             ELSE
4112:                 MsgErro("Erro ao criar FormBuscaAuxiliar.", "Formint.AbrirLookupOcorrenciaBaixaAuto")
4113:                 loc_lResultado = .F.
4114:             ENDIF
4115:         CATCH TO loException
4116:             MsgErro("Erro em AbrirLookupOcorrenciaBaixaAuto:" + CHR(13) + loException.Message, ;
4117:                 "Formint.AbrirLookupOcorrenciaBaixaAuto")
4118:             loc_lResultado = .F.
4119:         ENDTRY
4120: 
4121:         RETURN loc_lResultado
4122:     ENDPROC
4123: 
4124:     *===========================================================================
4125:     * BtnSalvarClick - Alias canonico para BtnConfirmarClick
4126:     * O botao "Confirmar" da Page2 no legado desempenha a mesma funcao do
4127:     * "Salvar" nos forms CRUD do novo padrao. Mantemos os dois nomes para
4128:     * atender ao contrato do FormBase (BtnSalvarClick) e do SCX (Confirmar).
4129:     *===========================================================================
4130:     PROCEDURE BtnSalvarClick()
4131:         RETURN THIS.BtnConfirmarClick()
4132:     ENDPROC
4133: 
4134:     *===========================================================================
4135:     * BtnBuscarClick - Alias canonico para BtnProcurarClick
4136:     * Ativa modo PROCURAR na Page2 para localizar inventario por codigo.
4137:     *===========================================================================
4138:     PROCEDURE BtnBuscarClick()
4139:         RETURN THIS.BtnProcurarClick()
4140:     ENDPROC
4141: 
4142:     *===========================================================================
4143:     * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD por modo atual
4144:     * Chamado em AlternarPagina/CarregarLista para refletir estado do form.
4145:     * Modos: LISTA (todos habilitados), INCLUIR/ALTERAR (Confirmar habilitado,
4146:     * Cancelar habilitado), VISUALIZAR (apenas Cancelar habilitado),
4147:     * PROCURAR (Confirmar+Cancelar habilitados), TRATAMENTO (apenas Encerrar).
4148:     *===========================================================================
4149:     PROTECTED PROCEDURE AjustarBotoesPorModo()
4150:         LOCAL loc_oPg1, loc_oCntBot, loc_oCntSaida, loc_cModo
4151:         loc_cModo = UPPER(ALLTRIM(THIS.this_cModoAtual))
4152: 
4153:         TRY
4154:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
4155: 
4156:             *-- Container dos botoes CRUD principais (Incluir/Alterar/Visualizar/Excluir/Buscar)
4157:             IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
4158:                 loc_oCntBot = loc_oPg1.cnt_4c_Botoes
4159: 
4160:                 IF PEMSTATUS(loc_oCntBot, "cmd_4c_Incluir", 5)
4161:                     loc_oCntBot.cmd_4c_Incluir.Enabled = (loc_cModo = "LISTA")
4162:                 ENDIF
4163:                 IF PEMSTATUS(loc_oCntBot, "cmd_4c_Alterar", 5)
4164:                     loc_oCntBot.cmd_4c_Alterar.Enabled = ;
4165:                         (loc_cModo = "LISTA") AND (THIS.this_nCodigoSel > 0)
4166:                 ENDIF
4167:                 IF PEMSTATUS(loc_oCntBot, "cmd_4c_Visualizar", 5)
4168:                     loc_oCntBot.cmd_4c_Visualizar.Enabled = ;
4169:                         (loc_cModo = "LISTA") AND (THIS.this_nCodigoSel > 0)
4170:                 ENDIF
4171:                 IF PEMSTATUS(loc_oCntBot, "cmd_4c_Excluir", 5)
4172:                     loc_oCntBot.cmd_4c_Excluir.Enabled = ;
4173:                         (loc_cModo = "LISTA") AND (THIS.this_nCodigoSel > 0)
4174:                 ENDIF
4175:                 IF PEMSTATUS(loc_oCntBot, "cmd_4c_Buscar", 5)
4176:                     loc_oCntBot.cmd_4c_Buscar.Enabled = (loc_cModo = "LISTA")
4177:                 ENDIF
4178:             ENDIF
4179: 
4180:             *-- Container de saida sempre habilitado (permite fechar em qualquer modo)
4181:             IF PEMSTATUS(loc_oPg1, "cnt_4c_Saida", 5)
4182:                 loc_oCntSaida = loc_oPg1.cnt_4c_Saida
4183:                 IF PEMSTATUS(loc_oCntSaida, "cmd_4c_Encerrar", 5)
4184:                     loc_oCntSaida.cmd_4c_Encerrar.Enabled = .T.
4185:                 ENDIF
4186:             ENDIF
4187: 
4188:             *-- Botoes operacionais especificos da Page1 (Balanco/BaixaAuto/Tratamento/Fechar)
4189:             IF PEMSTATUS(loc_oPg1, "cmd_4c_BtnBalanco", 5)


### BO (C:\4c\projeto\app\classes\intBO.prg):
*==============================================================================
* intBO.prg - Business Object para Tratamento de Invent?rio (SIGCDBAL)
* Herda de: BusinessBase
* Tabela principal: SIGCDBAL
* PK: cidchaves (char 20)
*==============================================================================
DEFINE CLASS intBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SIGCDBAL
    *--------------------------------------------------------------------------
    this_cCIdChaves  = ""    && cidchaves char(20) - chave prim?ria
    this_nCodigos    = 0     && codigos numeric(4,0) - c?digo do invent?rio
    this_cEmps       = ""    && emps char(3) - empresa
    this_dDataInis   = {}    && datainis datetime - data inicial do invent?rio
    this_dDataFims   = {}    && datafims datetime - data final do invent?rio
    this_dDataTrans  = {}    && datatrans datetime - data da transa??o
    this_dDtBases    = {}    && dtbases datetime - data base
    this_cGrupos     = ""    && grupos char(10) - grupo principal
    this_cLocalis    = ""    && localis char(10) - local inicial
    this_cLocalfs    = ""    && localfs char(10) - local final
    this_cLocals     = ""    && locals char(10) - local
    this_cIforis     = ""    && iforis char(10) - fornecedor inicial
    this_cIforfs     = ""    && iforfs char(10) - fornecedor final
    this_cCgruis     = ""    && cgruis char(3) - c?digo grupo inicial
    this_cCgrufs     = ""    && cgrufs char(3) - c?digo grupo final
    this_cCggruis    = ""    && cggruis char(3) - c?digo grande grupo inicial
    this_cCggrufs    = ""    && cggrufs char(3) - c?digo grande grupo final
    this_nPrecois    = 0     && precois numeric(8,2) - pre?o inicial
    this_nPrecofs    = 0     && precofs numeric(8,2) - pre?o final
    this_cContas     = ""    && contas char(10) - conta
    this_cUsuars     = ""    && usuars char(10) - usu?rio
    this_cColecoesi  = ""    && colecoesi char(10) - cole??o inicial
    this_cColecoesf  = ""    && colecoesf char(10) - cole??o final
    this_cCprosi     = ""    && cprosi char(14) - produto inicial (barra)
    this_cCprosf     = ""    && cprosf char(14) - produto final (barra)
    this_cSgrusi     = ""    && sgrusi char(6) - sub-grupo inicial
    this_cSgrusf     = ""    && sgrusf char(6) - sub-grupo final
    this_cCfinpsi    = ""    && cfinpsi char(3) - fin press inicial
    this_cCfinpsf    = ""    && cfinpsf char(3) - fin press final
    this_nNTrans     = 0     && ntrans numeric(6,0) - n?mero da transa??o
    this_nAgrupas    = 0     && agrupas numeric(1,0) - agrupar
    this_nSepEstqs   = 0     && sepestqs numeric(1,0) - separar estoques
    this_nTrtPorPeso = 0     && trtporpeso numeric(1,0) - tratamento por peso
    this_nLeitGructa = 0     && leitgructa numeric(1,0) - leitura por grupo conta
    this_nFilBarras  = 0     && filbarras numeric(1,0) - filtrar por barras
    this_cMFilGGrp   = ""    && mfilggrp memo - filtro grande grupos
    this_cMFilGrupo  = ""    && mfilgrupo memo - filtro grupos
    this_cObs        = ""    && obs memo - observa??o

    *-- Campos calculados / controle
    this_lEncerras   = .F.   && encerras bit - invent?rio encerrado
    this_lTratas     = .F.   && tratas bit - invent?rio tratado

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDBAL"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCIdChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista inventarios da empresa atual
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cEmp
        loc_lSucesso = .F.
        loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
                           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
                           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
                           " FROM SIGCDBAL" + ;
                           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
                           " ORDER BY codigos, cidchaves"
            ELSE
                loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
                           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
                           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
                           " FROM SIGCDBAL" + ;
                           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
                           " AND codigos = " + FormatarNumeroSQL(VAL(ALLTRIM(par_cFiltro))) + ;
                           " ORDER BY codigos, cidchaves"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega inventario pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
                       " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
                       " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                       " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                       " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                       " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
                       " mfilggrp, mfilgrupo, obs" + ;
                       " FROM SIGCDBAL" + ;
                       " WHERE cidchaves = " + EscaparSQL(par_cCidchaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorNumero - Carrega inventario pelo codigos + empresa
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorNumero(par_nCodigos, par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
                       " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
                       " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                       " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                       " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                       " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
                       " mfilggrp, mfilgrupo, obs" + ;
                       " FROM SIGCDBAL" + ;
                       " WHERE codigos = " + FormatarNumeroSQL(par_nCodigos) + ;
                       " AND emps = " + EscaparSQL(par_cEmps)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCIdChaves   = TratarNulo(cidchaves,    "C")
            THIS.this_nCodigos     = TratarNulo(codigos,      "N")
            THIS.this_cEmps        = TratarNulo(emps,         "C")
            THIS.this_cGrupos      = TratarNulo(grupos,       "C")
            THIS.this_cContas      = TratarNulo(contas,       "C")
            THIS.this_dDtBases     = TratarNulo(dtbases,      "D")
            THIS.this_dDataInis    = TratarNulo(datainis,     "D")
            THIS.this_dDataFims    = TratarNulo(datafims,     "D")
            THIS.this_dDataTrans   = TratarNulo(datatrans,    "D")
            THIS.this_lEncerras    = (TratarNulo(encerras,    "N") = 1)
            THIS.this_lTratas      = (TratarNulo(tratas,      "N") = 1)
            THIS.this_nAgrupas     = TratarNulo(agrupas,      "N")
            THIS.this_nSepEstqs    = TratarNulo(sepestqs,     "N")
            THIS.this_nTrtPorPeso  = TratarNulo(trtporpeso,   "N")
            THIS.this_nLeitGructa  = TratarNulo(leitgructa,   "N")
            THIS.this_nFilBarras   = TratarNulo(filbarras,    "N")
            THIS.this_cLocalis     = TratarNulo(localis,      "C")
            THIS.this_cLocalfs     = TratarNulo(localfs,      "C")
            THIS.this_cLocals      = TratarNulo(locals,       "C")
            THIS.this_cIforis      = TratarNulo(iforis,       "C")
            THIS.this_cIforfs      = TratarNulo(iforfs,       "C")
            THIS.this_cCgruis      = TratarNulo(cgruis,       "C")
            THIS.this_cCgrufs      = TratarNulo(cgrufs,       "C")
            THIS.this_cCggruis     = TratarNulo(cggruis,      "C")
            THIS.this_cCggrufs     = TratarNulo(cggrufs,      "C")
            THIS.this_cColecoesi   = TratarNulo(colecoesi,    "C")
            THIS.this_cColecoesf   = TratarNulo(colecoesf,    "C")
            THIS.this_cCprosi      = TratarNulo(cprosi,       "C")
            THIS.this_cCprosf      = TratarNulo(cprosf,       "C")
            THIS.this_cSgrusi      = TratarNulo(sgrusi,       "C")
            THIS.this_cSgrusf      = TratarNulo(sgrusf,       "C")
            THIS.this_cCfinpsi     = TratarNulo(cfinpsi,      "C")
            THIS.this_cCfinpsf     = TratarNulo(cfinpsf,      "C")
            THIS.this_nPrecois     = TratarNulo(precois,      "N")
            THIS.this_nPrecofs     = TratarNulo(precofs,      "N")
            THIS.this_nNTrans      = TratarNulo(ntrans,       "N")
            THIS.this_cUsuars      = TratarNulo(usuars,       "C")
            *-- Campos TEXT/memo (podem nao estar no cursor de listagem)
            IF !EMPTY(FIELD("mfilggrp", par_cAliasCursor))
                THIS.this_cMFilGGrp  = TratarNulo(mfilggrp,  "C")
                THIS.this_cMFilGrupo = TratarNulo(mfilgrupo, "C")
                THIS.this_cObs       = TratarNulo(obs,       "C")
            ENDIF
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarProximoCodigo - Obtem proximo codigo disponivel para a empresa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarProximoCodigo(par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_nCodigo
        loc_nCodigo = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(codigos), 0) + 1 AS prox_cod" + ;
                       " FROM SIGCDBAL WHERE emps = " + EscaparSQL(par_cEmps)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCod")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
                SELECT cursor_4c_ProxCod
                loc_nCodigo = cursor_4c_ProxCod.prox_cod
            ENDIF

            IF USED("cursor_4c_ProxCod")
                USE IN cursor_4c_ProxCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ProxCod")
                USE IN cursor_4c_ProxCod
            ENDIF
        ENDTRY

        RETURN loc_nCodigo
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SIGCDBAL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigo, loc_cEmp
        loc_lSucesso = .F.
        loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

        TRY
            *-- Gerar chave UUID e proximo codigo sequencial
            THIS.this_cCIdChaves = ""
            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
                SELECT cursor_4c_Uuid
                THIS.this_cCIdChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
            ENDIF
            IF USED("cursor_4c_Uuid")
                USE IN cursor_4c_Uuid
            ENDIF

            IF EMPTY(THIS.this_cCIdChaves)
                MsgErro("Erro ao gerar chave " + CHR(250) + "nica.", "Erro")
                loc_lSucesso = .F.
            ELSE
                loc_nCodigo = THIS.GerarProximoCodigo(loc_cEmp)
                IF loc_nCodigo = 0
                    MsgErro("Erro ao gerar c" + CHR(243) + "digo do invent" + CHR(225) + "rio.", "Erro")
                    loc_lSucesso = .F.
                ELSE
                    THIS.this_nCodigos = loc_nCodigo
                    THIS.this_cEmps    = loc_cEmp
                    THIS.this_cUsuars  = ALLTRIM(gc_4c_UsuarioLogado)

                    loc_cSQL = "INSERT INTO SIGCDBAL (" + ;
                               " cidchaves, codigos, emps, grupos, contas, dtbases," + ;
                               " datainis, datafims, encerras, tratas, agrupas, sepestqs," + ;
                               " trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                               " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                               " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                               " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
                               ") VALUES (" + ;
                               EscaparSQL(THIS.this_cCIdChaves) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                               EscaparSQL(THIS.this_cEmps) + "," + ;
                               EscaparSQL(THIS.this_cGrupos) + "," + ;
                               EscaparSQL(THIS.this_cContas) + "," + ;
                               FormatarDataSQL(THIS.this_dDtBases) + "," + ;
                               FormatarDataSQL(THIS.this_dDataInis) + "," + ;
                               FormatarDataSQL(THIS.this_dDataFims) + "," + ;
                               IIF(THIS.this_lEncerras, "1", "0") + "," + ;
                               IIF(THIS.this_lTratas, "1", "0") + "," + ;
                               FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
                               FormatarNumeroSQL(THIS.this_nSepEstqs) + "," + ;
                               FormatarNumeroSQL(THIS.this_nTrtPorPeso) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLeitGructa) + "," + ;
                               FormatarNumeroSQL(THIS.this_nFilBarras) + "," + ;
                               EscaparSQL(THIS.this_cLocalis) + "," + ;
                               EscaparSQL(THIS.this_cLocalfs) + "," + ;
                               EscaparSQL(THIS.this_cIforis) + "," + ;
                               EscaparSQL(THIS.this_cIforfs) + "," + ;
                               EscaparSQL(THIS.this_cCgruis) + "," + ;
                               EscaparSQL(THIS.this_cCgrufs) + "," + ;
                               EscaparSQL(THIS.this_cCggruis) + "," + ;
                               EscaparSQL(THIS.this_cCggrufs) + "," + ;
                               EscaparSQL(THIS.this_cColecoesi) + "," + ;
                               EscaparSQL(THIS.this_cColecoesf) + "," + ;
                               EscaparSQL(THIS.this_cCprosi) + "," + ;
                               EscaparSQL(THIS.this_cCprosf) + "," + ;
                               EscaparSQL(THIS.this_cSgrusi) + "," + ;
                               EscaparSQL(THIS.this_cSgrusf) + "," + ;
                               EscaparSQL(THIS.this_cCfinpsi) + "," + ;
                               EscaparSQL(THIS.this_cCfinpsf) + "," + ;
                               FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
                               FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
                               FormatarNumeroSQL(THIS.this_nNTrans) + "," + ;
                               EscaparSQL(THIS.this_cLocals) + "," + ;
                               EscaparSQL(THIS.this_cUsuars) + ;
                               ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SIGCDBAL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDBAL SET" + ;
                       " grupos = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                       " contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " dtbases = " + FormatarDataSQL(THIS.this_dDtBases) + "," + ;
                       " datainis = " + FormatarDataSQL(THIS.this_dDataInis) + "," + ;
                       " datafims = " + FormatarDataSQL(THIS.this_dDataFims) + "," + ;
                       " encerras = " + IIF(THIS.this_lEncerras, "1", "0") + "," + ;
                       " tratas = " + IIF(THIS.this_lTratas, "1", "0") + "," + ;
                       " agrupas = " + FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
                       " sepestqs = " + FormatarNumeroSQL(THIS.this_nSepEstqs) + "," + ;
                       " trtporpeso = " + FormatarNumeroSQL(THIS.this_nTrtPorPeso) + "," + ;
                       " leitgructa = " + FormatarNumeroSQL(THIS.this_nLeitGructa) + "," + ;
                       " filbarras = " + FormatarNumeroSQL(THIS.this_nFilBarras) + "," + ;
                       " localis = " + EscaparSQL(THIS.this_cLocalis) + "," + ;
                       " localfs = " + EscaparSQL(THIS.this_cLocalfs) + "," + ;
                       " locals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                       " iforis = " + EscaparSQL(THIS.this_cIforis) + "," + ;
                       " iforfs = " + EscaparSQL(THIS.this_cIforfs) + "," + ;
                       " cgruis = " + EscaparSQL(THIS.this_cCgruis) + "," + ;
                       " cgrufs = " + EscaparSQL(THIS.this_cCgrufs) + "," + ;
                       " cggruis = " + EscaparSQL(THIS.this_cCggruis) + "," + ;
                       " cggrufs = " + EscaparSQL(THIS.this_cCggrufs) + "," + ;
                       " colecoesi = " + EscaparSQL(THIS.this_cColecoesi) + "," + ;
                       " colecoesf = " + EscaparSQL(THIS.this_cColecoesf) + "," + ;
                       " cprosi = " + EscaparSQL(THIS.this_cCprosi) + "," + ;
                       " cprosf = " + EscaparSQL(THIS.this_cCprosf) + "," + ;
                       " sgrusi = " + EscaparSQL(THIS.this_cSgrusi) + "," + ;
                       " sgrusf = " + EscaparSQL(THIS.this_cSgrusf) + "," + ;
                       " cfinpsi = " + EscaparSQL(THIS.this_cCfinpsi) + "," + ;
                       " cfinpsf = " + EscaparSQL(THIS.this_cCfinpsf) + "," + ;
                       " precois = " + FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
                       " precofs = " + FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
                       " usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE do inventario e registros filhos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigos, loc_cEmps
        loc_lSucesso = .F.
        loc_nCodigos = THIS.this_nCodigos
        loc_cEmps    = ALLTRIM(THIS.this_cEmps)

        TRY
            *-- Remover registros filhos: SigIvTrB (itens do balanco)
            loc_cSQL = "DELETE FROM SigIvTrB" + ;
                       " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Remover registros filhos: SigIvTrH (historico de leitura)
            loc_cSQL = "DELETE FROM SigIvTrH" + ;
                       " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Remover registros filhos: SigIvTrE (etiquetas)
            loc_cSQL = "DELETE FROM SigIvTrE" + ;
                       " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Remover o inventario principal
            loc_cSQL = "DELETE FROM SIGCDBAL" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEncerramento - Marca/desmarca inventario como encerrado
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEncerramento(par_lEncerrar, par_dDatafim)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDBAL SET" + ;
                       " encerras = " + IIF(par_lEncerrar, "1", "0") + "," + ;
                       " datafims = " + FormatarDataSQL(par_dDatafim) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.this_lEncerras = par_lEncerrar
                THIS.this_dDataFims = par_dDatafim
                THIS.RegistrarAuditoria("ENCERRAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTratamento - Marca inventario como tratado
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTratamento(par_lTratar)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDBAL SET" + ;
                       " tratas = " + IIF(par_lTratar, "1", "0") + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.this_lTratas = par_lTratar
                THIS.RegistrarAuditoria("TRATAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao marcar tratamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao marcar tratamento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCambio - Obtem cotacao de cambio para uma moeda
    * Substitui fCarregarCambio() do legado (nao portada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarCambio(par_nValor, par_cMoeda)
        LOCAL loc_cSQL, loc_nResultado, loc_nCotacao, loc_nValorConv
        loc_nCotacao  = 1
        loc_nValorConv = par_nValor

        TRY
            IF !EMPTY(ALLTRIM(par_cMoeda)) AND ALLTRIM(par_cMoeda) <> "RS" AND ALLTRIM(par_cMoeda) <> "BRL"
                loc_cSQL = "SELECT TOP 1 a.Valos" + ;
                           " FROM SigCdCot a" + ;
                           " WHERE a.CMoes = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                           " ORDER BY a.Datas DESC"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cambio")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Cambio") > 0
                    SELECT cursor_4c_Cambio
                    loc_nCotacao = TratarNulo(Valos, "N")
                    IF loc_nCotacao > 0
                        loc_nValorConv = par_nValor * loc_nCotacao
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Cambio")
                    USE IN cursor_4c_Cambio
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar c" + CHR(226) + "mbio:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Cambio")
                USE IN cursor_4c_Cambio
            ENDIF
        ENDTRY

        RETURN loc_nValorConv
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Verifica se grupo de estoque eh valido
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo(par_cGrupos)
        LOCAL loc_cSQL, loc_nResultado, loc_lValido
        loc_lValido = .F.

        TRY
            IF !EMPTY(ALLTRIM(par_cGrupos))
                loc_cSQL = "SELECT TOP 1 Codigos FROM SigCdGcr" + ;
                           " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cGrupos))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGru")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValGru") > 0
                    loc_lValido = .T.
                ENDIF

                IF USED("cursor_4c_ValGru")
                    USE IN cursor_4c_ValGru
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ValGru")
                USE IN cursor_4c_ValGru
            ENDIF
        ENDTRY

        RETURN loc_lValido
    ENDPROC

ENDDEFINE

